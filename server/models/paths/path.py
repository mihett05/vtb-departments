from typing import Literal

from pydantic import BaseModel


class Path(BaseModel):
    start_latitude: float
    end_latitude: float
    start_longitude: float
    end_longitude: float
    profile: Literal['driving-car', 'foot-walking', 'cycling-regular', 'wheelchair']
