import pymongo
from typing import Annotated
from fastapi import APIRouter, Depends, HTTPException, status, Response
from schemes import AtmsInfo, GeoJSON

from .deps import get_admin, get_atm
from models.admin.atms import CreatAtm, UpdateAtm


router = APIRouter(
    prefix="/atms",
    tags=["atms"]
)


@router.get("/")
async def read(is_admin: Annotated[bool, Depends(get_admin)]):
    return await AtmsInfo.find_all().to_list()


@router.post("/")
async def create(body: CreatAtm, is_admin: Annotated[bool, Depends(get_admin)]):
    data = body.model_dump()
    lat = data.pop("latitude")
    lng = data.pop("longitude")
    geo = GeoJSON.create_point(lng, lat)
    atm = AtmsInfo(**{
        **data,
        "coordinates": geo,
    })
    try:
        await atm.create()
    except pymongo.errors.DuplicateKeyError:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Atm already exists",
        )
    return atm


@router.put("/{id}")
async def update(body: UpdateAtm, atm: Annotated[AtmsInfo, Depends(get_atm)]):
    data = body.model_dump()
    if data["latitude"] is not None and data["longitude"] is not None:
        geo = GeoJSON.create_point(data.pop("longitude"), data.pop("latitude"))
    else:
        geo = atm.coordinates
    for key in data:
        if data[key] is not None:
            setattr(atm, key, data[key])
    atm.coordinates = geo
    await atm.save()
    return atm


@router.delete("/{id}")
async def delete(atm: Annotated[AtmsInfo, Depends(get_atm)]):
    await atm.delete()
    return Response(status_code=status.HTTP_200_OK)
