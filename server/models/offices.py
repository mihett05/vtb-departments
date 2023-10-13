import uuid

from beanie import Document, Indexed
from pydantic import BaseModel
from models.geo_json import GeoJSON


class TimeOpen(BaseModel):
    days: str
    hours: str


class Statistics(BaseModel):
    time: TimeOpen
    percent: float


class OfficeInfo(Document):
    token: uuid.UUID
    sale_point_name: str
    address: str
    rko: str
    open_office: bool
    has_suo: bool
    has_ramp: bool
    metro_station: str
    open_hours_legal: list[TimeOpen]
    open_hours_individual: list[TimeOpen]
    coordinates: GeoJSON
    statistics: list[Statistics]
