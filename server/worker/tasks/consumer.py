import aio_pika
import base64
import json
import traceback

from schemes.offices import OfficeInfo, Statistics
from .amqp import Amqp
from worker.worker import Worker


class Consumer(Amqp):
    async def handle(self, office: OfficeInfo, images: list[bytes]):
        average_count = sum(map(Worker.get_people_count, images)) / len(images)
        statistics = Statistics(meta=average_count / office.max_capacity)
        await statistics.create()
        office.statistics.append(statistics)

    async def run(self):
        await self.connect()
        async with self.connection:
            async with self.queue.iterator() as queue:
                async for message in queue:
                    message: aio_pika.IncomingMessage
                    async with message.process(requeue=False):
                        office_id = message.headers["office_id"]
                        try:
                            await self.handle(
                                await OfficeInfo.get(office_id),
                                [
                                    base64.b64decode(image.encode("utf-8"))
                                    for image in json.loads(message.body.decode("utf-8"))
                                ]
                            )
                        except Exception as e:
                            print(traceback.format_exc())

