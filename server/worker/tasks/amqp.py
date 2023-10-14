import aio_pika
from config import config


class Amqp:
    connection: aio_pika.abc.AbstractRobustConnection
    channel: aio_pika.abc.AbstractChannel
    exchange: aio_pika.abc.AbstractExchange
    queue: aio_pika.abc.AbstractQueue

    def __init__(self):
        self.connection = None
        self.channel = None
        self.exchange = None
        self.queue = None

    async def connect(self):
        self.connection = await aio_pika.connect_robust(config.RABBITMQ_URL, timeout=240)
        self.channel: aio_pika.abc.AbstractChannel = await self.connection.channel()
        await self.channel.set_qos(prefetch_count=1)
        self.exchange = await self.channel.declare_exchange(
            config.RABBITMQ_EXCHANGE, aio_pika.ExchangeType.DIRECT, durable=True
        )
        self.queue = await self.channel.declare_queue(
            config.RABBITMQ_QUEUE, durable=True
        )
        await self.queue.bind(self.exchange, config.RABBITMQ_QUEUE)
