import base64
import json
import aio_pika
from config import config
from .amqp import Amqp


class Producer(Amqp):
    instance = None

    async def send_images(self, office_id: str, images: list[bytes]):
        await self.exchange.publish(
            aio_pika.Message(
                headers={
                    "office_id": office_id
                },
                body=json.dumps([
                    base64.b64encode(image).decode("utf-8")
                    for image in images
                ]).encode("utf-8"),
            ),
            routing_key=config.RABBITMQ_QUEUE,
        )
