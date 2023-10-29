from django.urls import re_path

from . import consumers

websocket_urlpatterns = [
    re_path(r'ws/some_path/$', consumers.SomeConsumer.as_asgi()),
    # # Добавьте другие URL-паттерны, если необходимо
    re_path(r'ws/map/render/', consumers.MapRender.as_asgi()),
    re_path(r'ws/route/generate/', consumers.SomeConsumer.as_asgi()),

    re_path(r'ws/get_position/', consumers.GetCurrentPosition.as_asgi()),
    re_path(r'ws/start_autopilot/', consumers.StartAutoPilot.as_asgi()),
    
]