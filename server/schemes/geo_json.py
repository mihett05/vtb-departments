import math

from pydantic import BaseModel


class GeoJSON(BaseModel):
    type: str
    coordinates: list[float]

    @classmethod
    def create_point(cls, longitude: float, latitude: float, type: str = "Point"):
        return cls(type=type, coordinates=[longitude, latitude])

    def __sub__(self, other):
        return math.dist(self.coordinates, other.coordinates)
