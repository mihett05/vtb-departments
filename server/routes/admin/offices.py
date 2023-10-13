import pymongo.errors
from fastapi import APIRouter, Depends, status, Response
from fastapi.exceptions import HTTPException
from typing import Annotated
from routes.deps import get_admin, get_office

from models.admin.offices import CreateOffice, UpdateOffice
from schemes import OfficeInfo, GeoJSON

router = APIRouter(
    prefix="/offices",
    tags=["offices"]
)


@router.get("/")
async def read(is_admin: Annotated[bool, Depends(get_admin)]):
    return await OfficeInfo.find_all().to_list()


@router.post("/")
async def create(body: CreateOffice, is_admin: Annotated[bool, Depends(get_admin)]):
    data = body.model_dump()
    lat = data.pop("latitude")
    lng = data.pop("longitude")
    geo = GeoJSON.create_point(lng, lat)
    office = OfficeInfo(**{
        **data,
        "coordinates": geo,
        "statistics": [],
    })
    try:
        await office.create()
    except pymongo.errors.DuplicateKeyError:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Office already exists",
        )
    return office


@router.put("/{id}")
async def update(body: UpdateOffice, office: Annotated[OfficeInfo, Depends(get_office)]):
    data = body.model_dump()
    if data["latitude"] is not None and data["longitude"] is not None:
        geo = GeoJSON.create_point(data.pop("longitude"), data.pop("latitude"))
    else:
        geo = office.coordinates
    for key in data:
        if data[key] is not None:
            setattr(office, key, data[key])
    office.coordinates = geo
    await office.save()
    return office


@router.delete("/{id}")
async def delete(office: Annotated[OfficeInfo, Depends(get_office)]):
    await office.delete()
    return Response(status_code=status.HTTP_200_OK)
