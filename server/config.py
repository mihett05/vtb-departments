import os


class Config:
    host = "0.0.0.0"
    port = 8080
    mongo_url = "mongodb://localhost:27017/db"

    # host = os.getenv("SERVER_HOST")
    # port = int(os.getenv("SERVER_PORT"))


config = Config()
