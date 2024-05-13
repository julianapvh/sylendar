from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth.models import User


@api_view(["GET"])
def check_username(request):
    username = request.GET.get("username", None)
    if username:
        user_exists = User.objects.filter(username=username).exists()
        return Response({"exists": user_exists})
    else:
        return Response(status=400)
