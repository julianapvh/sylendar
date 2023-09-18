from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='home'),
    # Outras rotas do aplicativo aqui...
]
