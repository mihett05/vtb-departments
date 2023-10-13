from fastapi import APIRouter
from fastapi.responses import JSONResponse


admin_router = APIRouter(
    prefix="/admin",
    tags=["admin"],
    responses={404: {"description": "Not found"}},
)


@admin_router.get("/hi")
async def get_moscow_time() -> JSONResponse:
    return JSONResponse(content="hi", status_code=200)