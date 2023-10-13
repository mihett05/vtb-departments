from fastapi import FastAPI
from src.admin.simple import admin_router


app = FastAPI(
    title="VTBApp",
    version="0.0.1",
)

app.include_router(admin_router)
