"""
URL configuration for hack_23 project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from app import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('say_hello/', views.index),
    path('register/', views.register_view),

    path(r'move/up', views.move_up),
    path(r'move/down', views.move_down),
    path(r'move/left', views.move_left),
    path(r'move/right', views.move_right),

    path(r'map/generated/', views.map_generated),
    path(r'map/get', views.map_get),
    path(r'map/render', views.map_render),

    path(r'route/generate', views.route_generate),

    path(r'database/get/wheels/', views.get_wheels),
    path(r'database/get/panels/', views.get_panels),
    path(r'database/get/other/', views.get_other),
]