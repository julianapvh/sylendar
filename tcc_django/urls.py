from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('agendamentos.urls')),  # Use o nome do aplicativo correto
]
