import redis
from django.http import HttpResponse
from django.shortcuts import render
from django.conf import settings
import uuid

def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")

def register_view(request):
    redis_client = redis.StrictRedis(host=settings.REDIS_HOST, port=settings.REDIS_PORT, db=settings.REDIS_DB)


    print("handle post register")

    unique_cookie_value = str(uuid.uuid4())

    redis_client.setex(unique_cookie_value, 3600, "valid") 

    response = HttpResponse("Registration successful!")

    response.set_cookie("Cookie", unique_cookie_value)

    return response

    print("Not post")
    return HttpResponse("redirected")