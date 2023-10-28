import redis
from django.http import HttpResponse
from django.conf import settings
import uuid
from django.shortcuts import get_object_or_404, render
from app.models import MapElenent
from rest_framework.decorators import api_view
from rest_framework.response import Response
from app.serializers import MapElementSerializer
from django.shortcuts import redirect
from rest_framework import status
import requests
import numpy as np
import json
import copy
from app.route import route


step = 20
subtrahend = 150

@api_view(['GET'])
def route_generate(request, firmat=None):
    """
    генерирует маршрут для автопилота
    """
    # print(list)
    # print(list['current_y'])
    response = requests.get('http://84.201.134.49:8001/get_position')
    response_data = response.json()
    resp_data = copy.deepcopy(response_data)
    result = {'x': [resp_data['current_x']], 'y': [resp_data['current_y']]}
    start_typle = (resp_data['current_x']-subtrahend, resp_data['current_y']-subtrahend)
    end_typle = (resp_data['current_x']+10-subtrahend, resp_data['current_y']+10-subtrahend)
    result_misha = {'x': [resp_data['current_x']-subtrahend], 'y': [resp_data['current_y']-subtrahend]}
    maze_resp = requests.get('http://84.201.134.49:8000/map/render')
    maze = maze_resp.json()
    
    # for i in range(10):
        # resp_data['current_y'] = resp_data['current_y']+1
    #     result['x'].append(resp_data['current_x'])
    #     result['y'].append(resp_data['current_y'])
    #     result_misha['x'].append(resp_data['current_x']-subtrahend)
    #     result_misha['y'].append(resp_data['current_y']-subtrahend)
    # for i in range(15):
    #     resp_data['current_x'] = resp_data['current_x']-1
    #     result['x'].append(resp_data['current_x'])
    #     result['y'].append(resp_data['current_y'])
    #     result_misha['x'].append(resp_data['current_x']-subtrahend)
    #     result_misha['y'].append(resp_data['current_y']-subtrahend)
    # for i in range(10):
    #     resp_data['current_y'] = resp_data['current_y']+1
    #     result['x'].append(resp_data['current_x'])
    #     result['y'].append(resp_data['current_y'])
    #     result_misha['x'].append(resp_data['current_x']-subtrahend)
    #     result_misha['y'].append(resp_data['current_y']-subtrahend)
    # for i in range(20):
    #     resp_data['current_x'] = resp_data['current_x']-1
    #     result['x'].append(resp_data['current_x'])
    #     result['y'].append(resp_data['current_y'])
    #     result_misha['x'].append(resp_data['current_x']-subtrahend)
    #     result_misha['y'].append(resp_data['current_y']-subtrahend)
    # for i in range(16):
    #     resp_data['current_y'] = resp_data['current_y']+1
    #     result['x'].append(resp_data['current_x'])
    #     result['y'].append(resp_data['current_y'])
    #     result_misha['x'].append(resp_data['current_x']-subtrahend)
    #     result_misha['y'].append(resp_data['current_y']-subtrahend)
    
    path = route(maze, start_typle, end_typle)
    for i in range(len(path)):
        result['x'].append(path[i][0]+subtrahend)
        result['y'].append(path[i][1]+subtrahend)
        result_misha['x'].append(path[i][0])
        result_misha['y'].append(path[i][1])

    q = requests.post('http://84.201.134.49:8001/turn_autopilot_on/', data=result)
    return Response(result_misha)


@api_view(['GET'])
def map_generated(request, format=None):
    """
    генерируем карту
    """
    # удаляем все что было
    data_base = MapElenent.objects.all()
    data_base.delete()
    
    # берем массив
    response = requests.get("http://84.201.134.49:8001/get_map/")
    # Убираем лишние символы и превращаем строку в список чисел
    numbers = list(map(int, response.text.replace("[", "").replace("]", " ").split()))
    # Преобразуем список в двумерный массив (400 * 400)
    two_dimensional_array = np.array(numbers).reshape(400, 400)
    two_data = two_dimensional_array.tolist()
    json_data = json.dumps(two_data)
    # print(json_data)
    MapElenent.objects.create(arr_data = json_data)

    return Response({'message': 'the map has been generated'}, status=status.HTTP_200_OK)

@api_view(['GET'])
def map_get(request, format=None):
    """
    вся карта
    """
    data = MapElenent.objects.first()
    data_map = data.arr_data

    return Response(data_map)


@api_view(['GET'])
def map_render(request, format=None):
    """
    отрисовка участка карты
    """
    # q = requests.get('http://84.201.134.49:8000/map/generated')

    elements = MapElenent.objects.first()
    arr_elements = elements.arr_data

    numbers = list(map(int, arr_elements.replace("[", "").replace("]", " ").replace(",", "").split()))
    # print(numbers)
    # Преобразуем список в двумерный массив (400 * 400)
    two_dimensional_array = np.array(numbers).reshape(400, 400)

    
    world_scaled = two_dimensional_array[int(elements.y_min):int(elements.y_max):, int(elements.x_min):int(elements.x_max):]
    # world_scaled = two_dimensional_array[100:250:, 150:300:]
    # serializer = MapElementSerializer(elements, many=True)
    return Response(world_scaled)


@api_view(['GET'])
def move_up(request, format=None):
    """
    сдвигает текущую координату вверх
    """
    cur_pos = requests.get('http://84.201.134.49:8001/get_position')
    cur_pos_data = cur_pos.json()
    data_base = MapElenent.objects.first()
    if (cur_pos_data['current_y']>data_base.y_max-step):
        data_base.y_max = data_base.y_max + step
        data_base.y_min = data_base.y_min + step
        data_base.save()
        global subtrahend 
        subtrahend = subtrahend + step
        qw = requests.get('http://84.201.134.49:8001/map/render')
    new_pos = (cur_pos_data['current_x']-subtrahend, cur_pos_data['current_y']+1-subtrahend)
    new_pos_dict = {
        'x': new_pos[0]+subtrahend,
        'y': new_pos[1]+subtrahend,
    }
    q=requests.post('http://84.201.134.49:8001/set_position/', data=new_pos_dict)
    print(new_pos)

    return Response(new_pos)

@api_view(['GET'])
def move_down(request, format=None):
    """
    сдвигает текущую координату down
    """
    cur_pos = requests.get('http://84.201.134.49:8001/get_position')
    cur_pos_data = cur_pos.json()
    data_base = MapElenent.objects.first()
    if (cur_pos_data['current_y']<data_base.y_max+step):
        data_base.y_max = data_base.y_max - step
        data_base.y_min = data_base.y_min - step
        data_base.save()
        global subtrahend 
        subtrahend = subtrahend - step
        qw = requests.get('http://84.201.134.49:8001/map/render')
    new_pos = (cur_pos_data['current_x'], cur_pos_data['current_y']-1)
    new_pos_dict = {
        'x': new_pos[0],
        'y': new_pos[1],
    }
    q=requests.post('http://84.201.134.49:8001/set_position/', data=new_pos_dict)
    print(new_pos)
    return Response(new_pos)

@api_view(['GET'])
def move_right(request, format=None):
    """
    сдвигает текущую координату вправо
    """
    cur_pos = requests.get('http://84.201.134.49:8001/get_position')
    cur_pos_data = cur_pos.json()
    data_base = MapElenent.objects.first()
    if (cur_pos_data['current_x']>data_base.x_max-step):
        data_base.x_max = data_base.x_max + step
        data_base.x_min = data_base.x_min + step
        data_base.save()
        global subtrahend 
        subtrahend = subtrahend + step
        qw = requests.get('http://84.201.134.49:8001/map/render')
    new_pos = (cur_pos_data['current_x']+1, cur_pos_data['current_y'])
    new_pos_dict = {
        'x': new_pos[0],
        'y': new_pos[1],
    }
    q=requests.post('http://84.201.134.49:8001/set_position/', data=new_pos_dict)
    print(new_pos)
    return Response(new_pos)

@api_view(['GET'])
def move_left(request, format=None):
    """
    сдвигает текущую координату влево
    """
    cur_pos = requests.get('http://84.201.134.49:8001/get_position')
    cur_pos_data = cur_pos.json()
    data_base = MapElenent.objects.first()
    if (cur_pos_data['current_x']>data_base.x_max+step):
        data_base.x_max = data_base.x_max - step
        data_base.x_min = data_base.x_min - step
        data_base.save()
        global subtrahend 
        subtrahend = subtrahend - step
        qw = requests.get('http://84.201.134.49:8001/map/render')
    new_pos = (cur_pos_data['current_x']-1, cur_pos_data['current_y'])
    new_pos_dict = {
        'x': new_pos[0],
        'y': new_pos[1],
    }
    q=requests.post('http://84.201.134.49:8001/set_position/', data=new_pos_dict)
    
    print(new_pos)
    return Response(new_pos)


def register_view(request):
    redis_client = redis.StrictRedis(host=settings.REDIS_HOST, port=settings.REDIS_PORT, db=settings.REDIS_DB)

    print("handle post register")

    unique_cookie_value = str(uuid.uuid4())

    redis_client.setex(unique_cookie_value, 3600, "valid") 

    response = HttpResponse("Registration successful!")

    response.set_cookie("Cookie", unique_cookie_value, samesite='None', secure=True)

    print("\n\nHeaders:")
    for header, value in response.items():
        print(f"{header}: {value}")

    set_cookie_header = response.get('Set-Cookie')
    print(f'Set-Cookie Header: {set_cookie_header}')

    return response

    print("Not post")
    return HttpResponse("redirected")


def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")
