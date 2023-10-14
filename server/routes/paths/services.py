from config import config
from urllib.parse import urlencode
import requests


def create_path(start_lat: float, end_lat: float, start_lng: float, end_lng: float, profile: str) -> tuple[int, list]:
    request_url = f"{config.open_route_service_url}/{profile}?"
    params = {
        "api_key": config.open_route_service_api_key,
        "start": f"{start_lng},{start_lat}",
        "end": f"{end_lng},{end_lat}"
    }

    url = request_url + urlencode(params)

    response = requests.get(url)
    coords = []
    if response.status_code == 200:
        coords = response.json()["features"][0]["geometry"]["coordinates"]

    return response.status_code, coords
