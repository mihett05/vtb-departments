from typing import Literal

from pydantic import BaseModel

from schemes import GeoJSON


class Path(BaseModel):
    start_latitude: float
    end_latitude: float
    start_longitude: float
    end_longitude: float
    profile: Literal['driving-car', 'foot-walking', 'cycling-regular', 'wheelchair']


class FilteredPath(BaseModel):
    has_ramp: bool
    geo_json: GeoJSON
    profile: Literal['driving-car', 'foot-walking', 'cycling-regular', 'wheelchair']