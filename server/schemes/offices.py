import uuid

from beanie import Document, Indexed
from pydantic import BaseModel, Field
from schemes.geo_json import GeoJSON


class TimeOpen(BaseModel):
    days: str
    hours: str


class Statistics(BaseModel):
    time: TimeOpen
    percent: float


class OfficeInfo(Document):
    token: uuid.UUID = Field(default_factory=uuid.uuid4)
    sale_point_name: str
    address: Indexed(str, unique=True)
    rko: bool
    open_office: bool
    has_suo: bool
    has_ramp: bool
    metro_station: str | None
    open_hours_legal: list[TimeOpen]
    open_hours_individual: list[TimeOpen]
    coordinates: GeoJSON
    statistics: list[Statistics]
