from urllib.parse import urlencode
from aiohttp import ClientSession
from config import config


async def create_path(
    start_lat: float,
    end_lat: float,
    start_lng: float,
    end_lng: float,
    profile: str
) -> tuple[int, list]:
    request_url = f"{config.OPEN_ROUTE_SERVICE_URL}/{profile}"
    params = {
        "api_key": config.OPEN_ROUTE_SERVICE_API_KEY,
        "start": f"{start_lng},{start_lat}",
        "end": f"{end_lng},{end_lat}"
    }

    url = request_url + "?" + urlencode(params)
    async with ClientSession() as session:
        async with session.get(url) as response:
            print(response)
            print(await response.text())
            data = await response.json()
            coords = []
            if response.status == 200:
                coords = data["features"][0]["geometry"]["coordinates"]
                properties = data["features"][0]["properties"]["segments"][0]
                distance, duration = properties["distance"], properties["duration"]

            return response.status, coords
