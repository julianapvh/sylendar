from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth.models import User


@api_view(["GET"])
def check_username(request):
    username = request.GET.get("username", None)
    if username:
        user_exists = User.objects.filter(username=username).exists()
        if user_exists:
            return Response(
                {"message": "Este nome de usuário já está em uso.", "exists": True}
            )
        else:
            return Response({"message": "Nome de usuário disponível.", "exists": False})
    else:
        return Response({"message": "O nome de usuário não foi fornecido."}, status=400)
