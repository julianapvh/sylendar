from django.contrib import admin
from django.urls import path, include
from agendamentos import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.index, name='index'),
    path('home/', views.home, name='home'),
    path('cliente/', views.cliente, name='cliente'),
    path('agendar_equipamento/', views.agendar_equipamento, name='agendar_equipamento'),
    path('historico/', views.historico, name='historico'),
    path('administrador/', views.historico, name='administrador'),
    path('cadastrar_equipamento/', views.historico, name='cadastrar_equipamento'),
]
