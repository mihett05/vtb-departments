import pymongo
from beanie import Document, Indexed
from pydantic import BaseModel
from schemes.geo_json import GeoJSON


class ServiceStatus(BaseModel):
    service_capability: str  # UNKNOWN, UNSUPPORTED, SUPPORTED
    service_activity: str  # UNKNOWN, UNAVAILABLE, AVAILABLE


class Service(BaseModel):
    name: str
    service_status: ServiceStatus


class AtmsInfo(Document):
    address: Indexed(str, unique=True)
    all_day: bool
    services: list[Service]
    coordinates: GeoJSON

    class Settings:
        indexes = [
            [("coordinates", pymongo.GEOSPHERE)],  # GEO index
        ]
