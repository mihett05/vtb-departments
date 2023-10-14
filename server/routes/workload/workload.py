from typing import Annotated
from fastapi import APIRouter, File, Depends, status
from fastapi.exceptions import HTTPException

from schemes import OfficeInfo
from worker.tasks.producer import Producer
from .deps import get_office, get_producer

router = APIRouter(prefix="/workload", tags=["workload"])


@router.post("/")
async def handle_workload(
    files: Annotated[list[bytes], File()],
    office: Annotated[OfficeInfo, Depends(get_office)],
    producer: Annotated[Producer, Depends(get_producer)],
):
    if len(files) != 5:
        raise HTTPException(
            status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
            detail=[
                {
                    "loc": ["files"],
                    "msg": "Workload should contain 5 images",
                    "type": "bytes",
                }
            ],
        )
    await producer.send_images(office_id=str(office.id), images=files)
