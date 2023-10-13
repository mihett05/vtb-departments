import os


class Config:
    host = "0.0.0.0"
    port = 8080

    # host = os.getenv("SERVER_HOST")
    # port = int(os.getenv("SERVER_PORT"))


config = Config()
