from beanie import init_beanie
from motor.motor_asyncio import AsyncIOMotorClient
from config import config
from models import AtmsInfo, OfficeInfo
from models.geo_json import GeoJSON


async def init_db():
    client = AsyncIOMotorClient(config.mongo_url)

    await init_beanie(database=client.vtb_ofices, document_models=[OfficeInfo, AtmsInfo])

    geo = GeoJSON.create_point(latitude=55.802432, longitude=37.704547)
    atms = AtmsInfo(**{'address': 'ул. Богородский Вал, д. 6, корп. 1', 'all_day': False, 'coordinates': geo, 'services': [{'name': 'wheelchair', 'service_status': {'service_capability': 'UNKNOWN', 'service_activity': 'UNKNOWN'}}, {'name': 'blind', 'service_status': {'service_capability': 'UNKNOWN', 'service_activity': 'UNKNOWN'}}, {'name': 'nfcForBankCards', 'service_status': {'service_capability': 'UNKNOWN', 'service_activity': 'UNAVAILABLE'}}, {'name': 'qrRead', 'service_status': {'service_capability': 'UNSUPPORTED', 'service_activity': 'UNAVAILABLE'}}, {'name': 'supportsUsd', 'service_status': {'service_capability': 'UNSUPPORTED', 'service_activity': 'UNAVAILABLE'}}, {'name': 'supportsChargeRub', 'service_status': {'service_capability': 'SUPPORTED', 'service_activity': 'AVAILABLE'}}, {'name': 'supportsEur', 'service_status': {'service_capability': 'UNSUPPORTED', 'service_activity': 'UNAVAILABLE'}}, {'name': 'supportsRub', 'service_status': {'service_capability': 'SUPPORTED', 'service_activity': 'AVAILABLE'}}]})
    await atms.insert()

