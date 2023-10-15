import asyncio
import datetime
from operator import itemgetter

from fastapi import APIRouter
from fastapi.responses import JSONResponse

from models.paths.path import Path, FilteredPath
from models.static import Office
from routes.paths.services import create_path
from schemes import OfficeInfo

router = APIRouter(
    prefix="/paths",
    tags=["paths"]
)


@router.post("/get_path")
async def get_path(body: Path):
    status_code, coords, meta = await create_path(
        start_lat=body.start_latitude,
        start_lng=body.start_longitude,
        end_lat=body.end_latitude,
        end_lng=body.end_longitude,
        profile=body.profile
    )

    if status_code == 200:
        return JSONResponse(status_code=status_code, content={"coords": coords, "meta": meta})
    else:
        return JSONResponse(status_code=status_code, content={'error': f'Map service returned {status_code}'})


@router.post("/get_offices")
async def get_offices(body: FilteredPath):
    offices = [Office(**office.model_dump()) for office in await OfficeInfo.find(
        {"coordinates.coordinates": {"$geoWithin": {"$centerSphere": [body.geo_json.coordinates, 60 / 6378.1]}}},
        fetch_links=True
    ).to_list()]
    if body.has_ramp:
        offices = [office for office in offices if office.has_ramp]
    offices = sorted(offices, key=lambda x: x.coordinates - body.geo_json)[:10]

    start_lng, start_lat = body.geo_json.coordinates

    paths = await asyncio.gather(
        *(create_path(start_lat=start_lat,
                      start_lng=start_lng,
                      end_lat=office.coordinates.coordinates[1],
                      end_lng=office.coordinates.coordinates[0],
                      profile=body.profile) for office in offices)
    )

    closest_offices = sorted(zip(paths, offices), key=lambda x: x[0][2]['duration'])
    closest_offices = [(path, office) for path, office in closest_offices if path[0] == 200]

    durations = map(itemgetter('duration'), map(itemgetter(2), map(itemgetter(0), closest_offices)))

    arrival_times = [datetime.datetime.now() + datetime.timedelta(seconds=duration) for duration in durations]

    arrival_load = []

    for arrival_time, (_, office) in zip(arrival_times, closest_offices):
        arrival_hour = arrival_time.hour
        arrival_weekday = arrival_time.weekday()

        weekday_stats = [stat for stat in office.statistics if stat["time_series"].weekday() == arrival_weekday]
        hours_stats = [stat for stat in weekday_stats if stat["time_series"].hour == arrival_hour]

        if len(hours_stats) == 0:
            arrival_load.append(-1)
            continue
        avg_load = sum(map(itemgetter("load"), hours_stats)) / len(hours_stats)
        arrival_load.append(avg_load)

    return {
        "offices": list(map(itemgetter(1), closest_offices)),
        "paths": list(map(itemgetter(0), closest_offices)),
        "arrival_load": arrival_load
    }
