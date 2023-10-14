import asyncio
from worker.tasks.consumer import Consumer
from init_mongo import init_db


async def run_worker():
    await init_db()
    await Consumer().run()


if __name__ == "__main__":
    asyncio.run(run_worker())
