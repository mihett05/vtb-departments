from typing import Optional, Annotated
from fastapi import Header, status, Depends
from fastapi.exceptions import HTTPException

from config import config
from schemes import OfficeInfo, AtmsInfo


def get_admin(token: Annotated[Optional[str], Header()] = None) -> bool:
    if token != config.admin_token:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED)
    return True


async def get_office(id: str, is_admin: Annotated[bool, Depends(get_admin)]) -> OfficeInfo:
    office = await OfficeInfo.get(id)
    if not office:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    return office


async def get_atm(id: str, is_admin: Annotated[bool, Depends(get_admin)]) -> AtmsInfo:
    atm = await AtmsInfo.get(id)
    if not atm:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    return atm
