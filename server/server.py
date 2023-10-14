from fastapi import FastAPI
from routes import admin, paths, static, workload
from init_mongo import init_db

app = FastAPI(
    title="VTBApp",
    version="0.0.1",
)


@app.on_event("startup")
async def start_db():
    await init_db()


app.include_router(admin.router)
app.include_router(paths.router)
app.include_router(static.router)
app.include_router(workload.router)
