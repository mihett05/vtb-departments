from pydantic import BaseModel


class GeoJSON(BaseModel):
    type: str
    coordinates: list[float]

    @classmethod
    def create_point(cls, longitude: float, latitude: float, type: str = "Point"):
        return cls(type=type, coordinates=[longitude, latitude])
