from django.contrib import admin
from django.urls import path, include
from agendamentos import views
from agendamentos.views import excluir_equipamento
from .views import logged_out, register, sucesso_agendamento
from django.contrib.auth import views as auth_views
from agendamentos.models import User
from .views import reagendar_agendamento, cancelar_agendamento
from agendamentos import views as agendamentos_views
from django.views.generic import RedirectView
from .views import relatorios_home, relatorio_padroes_agendamento, relatorio_quantidade_agendamentos_por_dia

tcc_django = 'agendamentos'
urlpatterns = [
    path('login/', views.login, name='login'),
    path('admin/', admin.site.urls),
    path('home/', views.home, name='home'),
    path('cliente/', views.cliente, name='cliente'),
    path('agendar_equipamento/', views.agendar_equipamento, name='agendar_equipamento'),
    path('historico/', views.historico, name='historico'),
    path('equipamentos_list/', views.listar_equipamentos, name='equipamentos_list'),
    path('cadastrar_equipamento/', views.cadastrar_equipamento, name='cadastrar_equipamento'),
    path('alterar_equipamento/<int:equipamento_id>/', views.alterar_equipamento, name='alterar_equipamento'),
    path('administrador/', views.administrador, name='administrador'),
    path('visualizar_equipamentos/', views.visualizar_equipamentos, name='visualizar_equipamentos'),
    path('adicionar_agendamento/', views.adicionar_agendamento, name='adicionar_agendamento'),
    path('meus_agendamentos/', views.meus_agendamentos, name='meus_agendamentos'),
    path('excluir_equipamento/<int:equipamento_id>/', views.excluir_equipamento, name='excluir_equipamento'),
    #path('listar_equipamentos/', views.listar_equipamentos, name='listar_equipamentos'),
    path('administrador_home/', views.administrador_home, name='administrador_home'),
    path('cliente_home/', views.cliente_home, name='cliente_home'),
    path('user_list/', views.user_list, name='user_list'),
    path('reagendar/<int:agendamento_id>/', reagendar_agendamento, name='reagendar_agendamento'),
    path('cancelar/<int:agendamento_id>/', cancelar_agendamento, name='cancelar_agendamento'),
    path('accounts/', include('django.contrib.auth.urls')),
    path('register/', views.register, name='register'),
    #path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('logout/', auth_views.LogoutView.as_view(next_page='login'), name='logout'),
    path('sucesso_agendamento/', sucesso_agendamento, name='sucesso_agendamento'),
    path('selecionar_nova_data_hora/<int:agendamento_id>/', views.selecionar_nova_data_hora, name='selecionar_nova_data_hora'),
    path('editar_equipamento/<int:equipamento_id>/', views.editar_equipamento, name='editar_equipamento'),
    path('relatorios/', views.relatorios_home, name='relatorios_home'),
    path('relatorio_padroes_agendamento/', relatorio_padroes_agendamento, name='relatorio_padroes_agendamento'),
    path('relatorio_quantidade_agendamentos_por_dia/', relatorio_quantidade_agendamentos_por_dia, name='relatorio_quantidade_agendamentos_por_dia'),
    path('devolucao_equipamento/', views.devolucao_equipamento, name='devolucao_equipamento'),
]

    


