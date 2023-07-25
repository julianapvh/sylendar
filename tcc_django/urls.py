# tcc_django/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('agendamentos/', include('agendamentos.urls')),
    # outras URLs do projeto...
]
