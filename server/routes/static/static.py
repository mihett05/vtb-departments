from fastapi import APIRouter
from models.static import Office
from schemes import OfficeInfo, AtmsInfo

router = APIRouter(
    prefix="/static",
    tags=["static"]
)


@router.get("/")
async def get_departments():
    return {
        "offices": [Office(**office.model_dump()) for office in await OfficeInfo.find_all().to_list()],
        "atms": await AtmsInfo.find_all().to_list(),
    }
