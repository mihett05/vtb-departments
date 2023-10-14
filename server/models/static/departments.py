import uuid
from typing import Any

from pydantic import BaseModel, Field
from schemes import OfficeInfo, AtmsInfo, GeoJSON
from schemes.offices import TimeOpen, Statistics


class Office(OfficeInfo):
    token: uuid.UUID = Field(exclude=True)
    statistics: Any
