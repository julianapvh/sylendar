from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('agendamentos.urls')),
    # Outras URLs do projeto principal
]
