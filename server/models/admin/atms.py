from pydantic import BaseModel

from schemes.atms import Service


class CreatAtm(BaseModel):
    address: str
    all_day: bool
    services: list[Service]
    latitude: float
    longitude: float


class UpdateAtm(BaseModel):
    address: str | None = None
    all_day: bool | None = None
    services: list[Service] | None = None
    latitude: float | None = None
    longitude: float | None = None

