from pydantic import BaseModel

from schemes.offices import TimeOpen


class CreateOffice(BaseModel):
    sale_point_name: str
    address: str
    rko: bool
    open_office: bool
    has_suo: bool
    has_ramp: bool
    metro_station: str | None
    open_hours_legal: list[TimeOpen]
    open_hours_individual: list[TimeOpen]
    latitude: float
    longitude: float


class UpdateOffice(BaseModel):
    sale_point_name: str | None = None
    address: str | None = None
    rko: bool | None = None
    open_office: bool | None = None
    has_suo: bool | None = None
    has_ramp: bool | None = None
    metro_station: str | None = None
    open_hours_legal: list[TimeOpen] | None = None
    open_hours_individual: list[TimeOpen] | None = None
    latitude: float | None = None
    longitude: float | None = None

