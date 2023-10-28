import redis
from django.shortcuts import redirect
from django.conf import settings

class CookieMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        redis_client = redis.StrictRedis(host=settings.REDIS_HOST, port=settings.REDIS_PORT, db=settings.REDIS_DB)
        # print(request.COOKIES)
        # print(f"request.META={request.META}")

        # if 'hackaton_user' not in request.COOKIES:
        #     print("Redirect")
        #     if request.path != '/register/':
        #         return redirect('/register/')

        # else: 
        #     cookie_value = request.COOKIES['hackaton_user']
        #     print(cookie_value)
        #     if not redis_client.exists(cookie_value):
        #         if request.path != '/register/':
        #             return redirect('/register/')

        response = self.get_response(request)
        return response
