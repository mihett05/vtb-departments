from beanie import init_beanie
from motor.motor_asyncio import AsyncIOMotorClient
from config import config
from schemes import AtmsInfo, OfficeInfo
from schemes.geo_json import GeoJSON


async def init_db():
    client = AsyncIOMotorClient(config.MONGO_URL)

    await init_beanie(database=client.vtb_ofices, document_models=[OfficeInfo, AtmsInfo])
