from fastapi import APIRouter
from fastapi.responses import JSONResponse

from models.paths.path import Path
from routes.paths.services import create_path

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

    return JSONResponse(status_code=status_code, content={"coords": coords, "meta": meta})
