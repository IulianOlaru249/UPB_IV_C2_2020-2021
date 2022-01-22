# # import socket

# # HOST = '127.0.0.1'  # The server's hostname or IP address
# # PORT = 65432        # The port used by the server

# # with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
# #     s.connect((HOST, PORT))
# #     s.sendall(b'Hello, world')

# import socket
# import json

# # ClientSocket = socket.socket()
# host = '127.0.0.1'
# port = 65432

# class Client:
#     def __init__(self, socket):
#         self.socket = socket

#     def connect(self):
#         try:
#             self.socket.connect((host, port))
#         except socket.error as e:
#             print(str(e))

#     def send(self, payload):
#         self.socket.send(payload)

#     def close(self):
#         self.socket.close()

# payload = {}
# payload["x"] = 0
# payload["y"] = 0
# json_payload = json.dumps(payload, indent=2).encode('utf-8')

# submarineClient = Client(socket.socket())
# submarineClient.connect()
# submarineClient.send(json_payload)


# fishClient = Client(socket.socket())
# fishClient.connect()
# fishClient.send(json_payload)


# artifactClient = Client(socket.socket())
# artifactClient.connect()
# fishClient.send(json_payload)


# submarineClient.close()
# fishClient.close()
# artifactClient.close()

# main.py

from hashlib import new
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from fastapi.encoders import jsonable_encoder
import socket
import json

class Client:
    def __init__(self, socket):
        self.socket = socket

    def connect(self):
        try:
            self.socket.connect((host, port))
        except socket.error as e:
            print(str(e))

    def send(self, payload):
        self.socket.send(payload)

    def close(self):
        self.socket.close()

class Coordinates:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def get_x(self):
        return self.x
        
    def get_y(self):
        return self.y

    def set_x(self, x):
        self.x = x
        
    def set_y(self, y):
        self.y = y

class Item(BaseModel):
    x: str
    y: str

#Socket Server Address And Port
host = '127.0.0.1'
port = 65432

# Objects to keep track of the state of each entity
fish = []
submarine = Coordinates(0, 0)
artifact = Coordinates(0, 0)

# HTTP Server
app = FastAPI()

# Clients for socket server comm with drawer
submarineClient = Client(socket.socket())
submarineClient.connect()

fishClient = Client(socket.socket())
fishClient.connect()

artifactClient = Client(socket.socket())
artifactClient.connect()

@app.get("/api/submarine")
async def get_sub():
    response = {}
    response["x"] = submarine.get_x()
    response["y"] = submarine.get_y()

    # Send HTTP response
    json_response = jsonable_encoder(response)
    return JSONResponse(content=json_response)

@app.post("/api/submarine/move")
async def move_sub(new_position: Item):
    submarine.set_x(submarine.get_x() + new_position.x)
    submarine.set_y(submarine.get_y() + new_position.y)

    # Send to socket server
    socket_respone = '{' + new_position.x + new_position.y + '}'
    json_payload = json.dumps(new_position)
    submarineClient.send(json_payload)

    return {"message": "Submarine Moved!"}

@app.get("/api/fish")
async def get_fish():
    response = []
    for fish_entity in fish:
        response_item = {}
        response_item["x"] = fish_entity.get_x()
        response_item["y"] = fish_entity.get_y()
        response.append(response_item)
    json_response = jsonable_encoder(response)
    return JSONResponse(content=json_response)

@app.post("/api/fish/add")
async def add_fish(new_position: Item):
    new_fish = Coordinates(new_position.x, new_position.y)
    fish.append(new_fish)

    if len(fish) > 5:
        fish.pop(0)

    return {"message": "Fish Added!" + str(len(fish))}

@app.get("/api/artifact")
async def get_artifact():
    response = {}
    response["x"] = artifact.get_x()
    response["y"] = artifact.get_y()

    json_response = jsonable_encoder(response)
    return JSONResponse(content=json_response)

@app.post("/api/artifact/update")
async def update_artifact(new_position: Item):
    artifact.set_x(new_position.x)
    artifact.set_y(new_position.y)

    # Send to socket server
    json_payload = json.dumps(new_position)
    artifactClient.send(json_payload)

    return {"message": "Artifact Updated!"}
