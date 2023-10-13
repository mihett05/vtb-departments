from beanie import Document
from pydantic import BaseModel
from models.geo_json import GeoJSON


class ServiceStatus(BaseModel):
    service_capability: str  # UNKNOWN, UNSUPPORTED, SUPPORTED
    service_activity: str  # UNKNOWN, UNAVAILABLE, AVAILABLE


class Service(BaseModel):
    name: str
    service_status: ServiceStatus


class AtmsInfo(Document):
    address: str
    all_day: bool
    services: list[Service]
    coordinates: GeoJSON
