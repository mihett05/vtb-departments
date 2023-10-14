import os


class Config:
    host = "0.0.0.0"
    port = 8080
    mongo_url = "mongodb://localhost:27017/db"
    open_route_service_url = "http://localhost:8080/ors/v2/directions"
    open_route_service_api_key = "5b3ce3597851110001cf62487c921f18b74a4d1cbf4e768025399814"
    admin_token = "test-token"

    # host = os.getenv("SERVER_HOST")
    # port = int(os.getenv("SERVER_PORT"))


config = Config()
