from pydantic_settings import BaseSettings


class Config(BaseSettings):
    HOST: str = "0.0.0.0"
    PORT: int = 8000
    MONGO_URL: str = "mongodb://localhost:27017/db"
    OPEN_ROUTE_SERVICE_URL: str = "http://localhost:8080/ors/v2/directions"
    OPEN_ROUTE_SERVICE_API_KEY: str = "5b3ce3597851110001cf62487c921f18b74a4d1cbf4e768025399814"
    ADMIN_TOKEN: str = "test-token"


config = Config()
