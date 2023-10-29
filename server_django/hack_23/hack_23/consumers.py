import asyncio
import json
import numpy as np
from channels.generic.websocket import AsyncWebsocketConsumer
from app.route import route
import requests
import copy
import websockets
from app.views import subtrahend_x, step, subtrahend_y
from rest_framework.response import Response
from app.models import MapElenent
from asgiref.sync import sync_to_async

running = False

class MapRender(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def disconnect(self, close_code):
        # Установить флаг running в False, чтобы завершить задачу
        pass        

    async def receive(self, text_data):

        elements = sync_to_async(MapElenent.objects.get)
        elem = await elements(id =1)
        numbers = list(map(int, elem.arr_data.replace("[", "").replace("]", " ").replace(",", "").split()))
        two_dimensional_array = np.array(numbers).reshape(100, 100)
        world_scaled = two_dimensional_array[int(elem.y_min):int(elem.y_max):, int(elem.x_min):int(elem.x_max):].tolist()
    
        # print(world_scaled)
        await self.send(text_data=json.dumps(world_scaled))

class GetCurrentPosition(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def disconnect(self, close_code):
      # Установить флаг running в False, чтобы завершить задачу
        pass        

    async def receive(self, text_data):
        uri = "ws://localhost:8001/ws/get_position/"  # Замените на ваш адрес веб-сокета
        async with websockets.connect(uri) as websocket:
            # Отправляем сообщение на веб-сокет сервер
            message_to_send = "stop_task"

            await websocket.send(message_to_send)
            print(f"Sent {message_to_send}")


            # Принимаем сообщение от веб-сокет сервера
            response = await websocket.recv()
            print(f"Response {response}")
            resp_data = json.loads(response)
            resp_data['current_x'] = resp_data['current_x'] - subtrahend_x
            resp_data['current_y'] = resp_data['current_y'] - subtrahend_y
            while True:
                await self.send(text_data=json.dumps(resp_data))
                await asyncio.sleep(1)
            


class SomeConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def disconnect(self, close_code):
        # Установить флаг running в False, чтобы завершить задачу
        pass        

    async def receive(self, text_data):
        # Обработка полученных данных
        splited_data = text_data.split()
        end_x, end_y = splited_data[0], splited_data[1]
        print(end_x, end_y)
        uri = "ws://localhost:8001/ws/get_position/"  # Замените на ваш адрес веб-сокета


        print("sending something to 2 server")

        async with websockets.connect(uri) as websocket:
            # Отправляем сообщение на веб-сокет сервер
            message_to_send = "stop_task"

            await websocket.send(message_to_send)
            print(f"Sent: {message_to_send}")


            # Принимаем сообщение от веб-сокет сервераp
            response = await websocket.recv()
            print(f"Received1: {response}")
            resp_data = json.loads(response)

            # logic
            print(resp_data['current_x'])
            result = {'x': [resp_data['current_x']], 'y': [resp_data['current_y']]}
            start_typle = (int(resp_data['current_x'])-subtrahend_x, int(resp_data['current_y'])-subtrahend_y)
            end_typle = (int(end_x), int(end_y))
            result_misha = {'x': [int(resp_data['current_x'])-subtrahend_x], 'y': [int(resp_data['current_y'])-subtrahend_y]}


        uri2 = "ws://localhost:8000/ws/map/render/"
        async with websockets.connect(uri2) as web2:
            message_to_send = "message2"
            print(f"Sent2: {message_to_send}")
            await web2.send(message_to_send)
            print(f"Sent2: {message_to_send}")

            # Принимаем сообщение от веб-сокет сервера
            world = await web2.recv()
            world_scape = json.loads(world)
            print("Received2------------------------------------:")


            path = route(world_scape, start_typle, end_typle)
            for i in range(len(path)):
                result['x'].append(path[i][0]+subtrahend_x)
                result['y'].append(path[i][1]+subtrahend_y)
                result_misha['x'].append(path[i][0])
                result_misha['y'].append(path[i][1])
            result_misha_ans = json.dumps(result_misha)
            
            # await web2.send(result_misha_ans)
            await self.send(result_misha_ans)


        # uri3 = "ws://localhost:8001/ws/turn_autopilot_on/"
        # async with websockets.connect(uri3) as web3:
        #     message_to_send = json.dumps(result)
        #     await web3.send(message_to_send)
        #     # print(f"Sent3: {message_to_send}")

        #     # Принимаем сообщение от веб-сокет сервера
        #     resp = await web3.recv()
        #     print(f"Received2: {resp}")
        #     await self.send(text_data=json.dumps(resp))
class StartAutoPilot(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def disconnect(self, close_code):
        # Установить флаг running в False, чтобы завершить задачу
        pass        

    async def receive(self, text_data):
        uri = "ws://localhost:8001/ws/start_autopilot/"  # Замените на ваш адрес веб-сокета
        async with websockets.connect(uri) as web:
            with open('vova.txt', 'r') as file:
                file_contents = file.read()
            await web.send(json.dumps(file_contents))


            # Принимаем сообщение от веб-сокет сервераp
            while True:
                response = await web.recv()
                print(f"Received1: {response}")
                resp_data = json.loads(response)
                
                await self.send(json.dumps(resp_data))





