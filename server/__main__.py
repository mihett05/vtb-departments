import uvicorn

from config import config

if __name__ == "__main__":
    uvicorn.run("server:app", host=config.HOST, port=config.PORT, reload=False)
