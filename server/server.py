from fastapi import FastAPI
from routes import admin
from init_mongo import init_db

app = FastAPI(
    title="VTBApp",
    version="0.0.1",
)


@app.on_event("startup")
async def start_db():
    await init_db()


app.include_router(admin.router)
