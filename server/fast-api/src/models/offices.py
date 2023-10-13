from beanie import Document
from pydantic import BaseModel


class TimeOpen(BaseModel):
    days: str
    hours: str


class OfficeInfo(Document):
    sale_point_name: str
    address: str
    rko: str
    open_office: bool
    has_suo: bool
    has_ramp: bool
    metroStation: str
    openHours: list[TimeOpen]
    openHoursIndividual: list[TimeOpen]