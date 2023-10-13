from beanie import Document
from pydantic import BaseModel
from geo_json import GeoJSON


class ServiceStatus(BaseModel):
    service_capability: str  # UNKNOWN, UNSUPPORTED, SUPPORTED
    service_activity: str  # UNKNOWN, UNAVAILABLE, AVAILABLE


class Service(BaseModel):
    name: str
    service_status: ServiceStatus


class OfficeInfo(Document):
    address: str
    allDay: bool
    services: list[Service]
    coordinates: GeoJSON
