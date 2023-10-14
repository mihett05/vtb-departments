import uuid
from datetime import datetime

from beanie import Document, Indexed, TimeSeriesConfig, Granularity, Link
from pydantic import BaseModel, Field
from schemes.geo_json import GeoJSON


class TimeOpen(BaseModel):
    days: str
    hours: str


class Statistics(Document):
    time_series: datetime = Field(default_factory=datetime.now)
    meta: float

    class Settings:
        timeseries = TimeSeriesConfig(
            time_field='time_series',
            meta_field='meta',
            granularity=Granularity.minutes,
            expire_after_seconds=60 * 60 * 24 * 30
        )


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
    statistics: list[Link[Statistics]]
    max_capacity: int
