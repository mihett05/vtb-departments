from typing import Annotated
from uuid import UUID
from fastapi import Header, status
from fastapi.exceptions import HTTPException

from schemes.offices import OfficeInfo
from worker.tasks.producer import Producer


async def get_office(token: Annotated[str | None, Header()]) -> OfficeInfo:
    if not token:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token in Authorization Header",
        )
    return await OfficeInfo.find_one(OfficeInfo.token == UUID(token))


async def get_producer() -> Producer:
    if not Producer.instance:
        Producer.instance = Producer()
        await Producer.instance.connect()
    return Producer.instance
