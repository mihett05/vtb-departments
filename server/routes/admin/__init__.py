from fastapi import APIRouter
from . import offices, atms


router = APIRouter(
    prefix="/admin",
    responses={404: {"description": "Not found"}},
)

router.include_router(offices.router)
router.include_router(atms.router)
