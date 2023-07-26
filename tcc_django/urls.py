from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('agendamentos.urls')),  # Certifique-se de que esta linha está presente
]
