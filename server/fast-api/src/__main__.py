import uvicorn

from config import config

if __name__ == "__main__":
    uvicorn.run("server:app", host=config.host, port=config.port, reload=False)
