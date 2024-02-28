from django.contrib import admin
from django.urls import path, include
from agendamentos import views
from agendamentos.views import excluir_equipamento
from .views import register
from django.contrib.auth import views as auth_views
from agendamentos.models import Usuario
from .views import reagendar_agendamento, cancelar_agendamento




urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.index, name='index'),
    path('home/', views.home, name='home'),
    path('cliente/', views.cliente, name='cliente'),
    path('agendar_equipamento/', views.agendar_equipamento, name='agendar_equipamento'),
    path('historico/', views.historico, name='historico'),
    path('administrador/editar_equipamento/', views.editar_equipamento, name='editar_equipamento'),
    path('equipamentos_list/', views.listar_equipamentos, name='equipamentos_list'),
    path('cadastrar_equipamento/', views.cadastrar_equipamento, name='cadastrar_equipamento'),
    path('administrador/excluir_equipamento/<int:equipamento_id>/', views.excluir_equipamento, name='excluir_equipamento'),
    path('alterar_equipamento/<int:equipamento_id>/', views.alterar_equipamento, name='alterar_equipamento'),
    path('administrador/', views.administrador, name='administrador'),
    path('administrador/visualizar_equipamentos/', views.visualizar_equipamentos, name='visualizar_equipamentos'),
    path('administrador/editar_equipamento/<int:equipamento_id>/', views.editar_equipamento, name='editar_equipamento'),
    path('agendamentos/adicionar_agendamento', views.adicionar_agendamento, name='adicionar_agendamento'),
    path('meus_agendamentos/', views.meus_agendamentos, name='meus_agendamentos'),
    path('agendar_equipamento/', views.agendar_equipamento, name='agendar_equipamento'),
    path('visualizar_equipamentos/', views.visualizar_equipamentos, name='visualizar_equipamentos'),
    path('excluir_equipamento/', views.excluir_equipamento, name='excluir_equipamento'),
    path('editar_equipamento/', views.editar_equipamento, name='editar_equipamento'),
    path('editar_equipamento/<int:equipamento_id>/', views.editar_equipamento, name='editar_equipamento'),
    path('excluir_equipamento/<int:equipamento_id>/', excluir_equipamento, name='excluir_equipamento'),
    path('listar_equipamentos/', views.listar_equipamentos, name='listar_equipamentos'),
    path('administrador_home/', views.administrador_home, name='administrador_home'),
    path('cliente_home/', views.cliente_home, name='cliente_home'),
    path('agendamentos\registro/', register, name='registro'),
    path('login/', auth_views.LoginView.as_view(), name='login'),
    path('agendamentos\templates\agendamentos\login.html/', views.login, name='login'),
    path('agendamentos\register/', views.register, name='register'),
    path('user_list/', views.user_list, name='user_list'),
    path('reagendar/<int:agendamento_id>/', reagendar_agendamento, name='reagendar_agendamento'),
    path('cancelar/<int:agendamento_id>/', cancelar_agendamento, name='cancelar_agendamento'),
    
    

    
    
    
]
