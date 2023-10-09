from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('agendamento/adicionar/', views.adicionar_agendamento, name='adicionar_agendamento'),
]
