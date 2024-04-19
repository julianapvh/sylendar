from django.contrib import admin
from django.urls import path, include
from agendamentos import views
from agendamentos.views import cancelar_agendamento, excluir_equipamento, historico_agendamentos, reagendar_agendamento, relatorio_padroes_agendamento, relatorio_quantidade_agendamentos_por_dia
from django.contrib.auth import views as auth_views
from django.views.generic import RedirectView
from django.contrib.auth import views as auth_views







tcc_django = 'agendamentos'
urlpatterns = [
    path('admin/', admin.site.urls),
    path('cliente/', views.cliente, name='cliente'),
    path('home/', views.home, name='home'),
    path('agendar_equipamento/', views.agendar_equipamento, name='agendar_equipamento'),
    path('historico/', views.historico, name='historico'),
    path('administrador/', views.administrador, name='administrador'),
    path('cadastrar_equipamento/', views.cadastrar_equipamento, name='cadastrar_equipamento'),
    path('editar_equipamento/<int:equipamento_id>/', views.editar_equipamento, name='editar_equipamento'), 
    #path('adicionar_agendamento/', views.adicionar_agendamento, name='adicionar_agendamento'),
    path('meus_agendamentos/', views.meus_agendamentos, name='meus_agendamentos'),
    path('visualizar_equipamentos/', views.visualizar_equipamentos, name='visualizar_equipamentos'),
    path('excluir_equipamento/', views.excluir_equipamento, name='excluir_equipamento'),
    path('editar_equipamento/', views.editar_equipamento, name='editar_equipamento'),
    path('editar_equipamento/<int:equipamento_id>/', views.editar_equipamento, name='editar_equipamento'),
    path('excluir_equipamento/<int:equipamento_id>/', excluir_equipamento, name='excluir_equipamento'),
    #path('listar_equipamentos/', views.listar_equipamentos, name='listar_equipamentos'),
    path('administrador_home/', views.administrador_home, name='administrador_home'),
    path('login/', auth_views.LoginView.as_view(), name='login'),
    path('user_list/', views.user_list, name='user_list'),
    path('reagendar/<int:agendamento_id>/', reagendar_agendamento, name='reagendar_agendamento'),
    path('cancelar/<int:agendamento_id>/', cancelar_agendamento, name='cancelar_agendamento'),
    path('pagina_de_erro/', views.pagina_erro, name='pagina_erro'),
    path('', RedirectView.as_view(pattern_name='login', permanent=False)),
    path('accounts/', include('django.contrib.auth.urls')),
    path('register/', views.register, name='register'),
    path('relatorios/', views.relatorios_home, name='relatorios_home'),
    path('relatorio_padroes_agendamento/', relatorio_padroes_agendamento, name='relatorio_padroes_agendamento'),
    path('relatorio_quantidade_agendamentos_por_dia/', relatorio_quantidade_agendamentos_por_dia, name='relatorio_quantidade_agendamentos_por_dia'),
    path('buscar_agendamentos/', views.buscar_agendamentos, name='buscar_agendamentos'),
    path('devolucao_equipamento/<int:agendamento_id>/', views.devolucao_equipamento, name='devolucao_equipamento'),
    path('historico_agendamentos/', views.historico_agendamentos, name='historico_agendamentos'),
    path('obter_dados_equipamento/', views.obter_dados_equipamento, name='obter_dados_equipamento'),
    path('marcar_como_emprestado/', views.marcar_como_emprestado, name='marcar_como_emprestado'),
    path('emprestimo_sucesso/', views.emprestimo_sucesso, name='emprestimo_sucesso'),
    path('emprestimo_sucesso/<int:agendamento_id>/', views.emprestimo_sucesso, name='emprestimo_sucesso'),
    path('lista_clientes/', views.lista_clientes, name='lista_clientes'),
    path('reset_password/', auth_views.PasswordResetView.as_view(), name="reset_password"),
    path('reset_password_sent/', auth_views.PasswordResetDoneView.as_view(), name="password_reset_done"),
    path('reset/<uidb64>/<token>', auth_views.PasswordResetConfirmView.as_view(), name="password_reset_confirm"),
    path('reset_password_complete/', auth_views.PasswordResetCompleteView.as_view(), name="password_reset_complete"),
    #path('calendario_mensal/', views.calendario_mensal, name='calendario_mensal'),
]

# Mapeie a visualização para lidar com erros
handler404 = 'agendamentos.views.error_404_view'
handler500 = 'agendamentos.views.error_500_view'
