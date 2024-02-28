
from django.contrib import admin
from django.urls import path, include
from agendamentos import views
from agendamentos.views import cancelar_agendamento, excluir_equipamento, reagendar_agendamento
from django.contrib.auth import views as auth_views
from agendamentos.models import Usuario

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.index, name='index'),
    path('home/', views.home, name='home'),
    path('cliente/', views.cliente, name='cliente'),
    path('agendar_equipamento/', views.agendar_equipamento, name='agendar_equipamento'),
    path('historico/', views.historico, name='historico'),
    path('administrador/', views.administrador, name='administrador'),
    path('cadastrar_equipamento/', views.cadastrar_equipamento, name='cadastrar_equipamento'),
    path('editar_equipamento/<int:equipamento_id>/', views.editar_equipamento, name='editar_equipamento'),  # Add this line
    path('agendamentos/adicionar_agendamento/', views.adicionar_agendamento, name='adicionar_agendamento'),
    path('meus_agendamentos/', views.meus_agendamentos, name='meus_agendamentos'),
    path('agendar_equipamento/', views.agendar_equipamento, name='agendar_equipamento'),
    path('visualizar_equipamentos/', views.visualizar_equipamentos, name='visualizar_equipamentos'),
    path('excluir_equipamento/', views.excluir_equipamento, name='excluir_equipamento'),
    path('editar_equipamento/', views.editar_equipamento, name='editar_equipamento'),
    path('editar_equipamento/<int:equipamento_id>/', views.editar_equipamento, name='editar_equipamento'),
    path('excluir_equipamento/<int:equipamento_id>/', excluir_equipamento, name='excluir_equipamento'),
    path('listar_equipamentos/', views.listar_equipamentos, name='listar_equipamentos'),
    path('administrador_home/', views.administrador_home, name='administrador_home'),
    #path('cliente_home/', views.cliente_home, name='cliente_home'),
    #path('registro/', views.registro, name='registro'),
    path('login/', auth_views.LoginView.as_view(), name='login'),
    path('agendamentos\templates\agendamentos\login.html/', views.login, name='login'),
    path('register/', views.register, name='register'),
    path('user_list/', views.user_list, name='user_list'),
    path('reagendar/<int:agendamento_id>/', reagendar_agendamento, name='reagendar_agendamento'),
    path('cancelar/<int:agendamento_id>/', cancelar_agendamento, name='cancelar_agendamento'),
    path('pagina_de_erro/', views.pagina_erro, name='pagina_erro'),


]

# Mapeie a visualização para lidar com erros
handler404 = 'agendamentos.views.error_404_view'
handler500 = 'agendamentos.views.error_500_view'