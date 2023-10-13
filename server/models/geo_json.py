from pydantic import BaseModel


class GeoJSON(BaseModel):
    geo_type: str
    coordinates: list[float]

    @classmethod
    def create_point(cls, longitude: float, latitude: float, geo_type: str = "Point"):
        return cls(geo_type=geo_type, coordinates=[longitude, latitude])
