from django.contrib import admin
from django.urls import path, include
from agendamentos import views
from agendamentos.views import excluir_equipamento
from .views import logged_out, register
from django.contrib.auth import views as auth_views
from agendamentos.models import User
from .views import reagendar_agendamento, cancelar_agendamento
from agendamentos import views as agendamentos_views
from django.views.generic import RedirectView
from .views import historico_agendamentos
from django.conf.urls.static import static
from django.conf import settings


tcc_django = "agendamentos"
urlpatterns = [
    path("login/", views.login, name="login"),
    path("admin/", admin.site.urls),
    path("home/", views.home, name="home"),
    path("cliente/", views.cliente, name="cliente"),
    path("agendar_equipamento/", views.agendar_equipamento, name="agendar_equipamento"),
    path("historico/", views.historico, name="historico"),
    path("equipamentos_list/", views.listar_equipamentos, name="equipamentos_list"),
    path(
        "cadastrar_equipamento/",
        views.cadastrar_equipamento,
        name="cadastrar_equipamento",
    ),
    path("administrador/", views.administrador, name="administrador"),
    path(
        "visualizar_equipamentos/",
        views.visualizar_equipamentos,
        name="visualizar_equipamentos",
    ),
    path(
        "adicionar_agendamento/",
        views.adicionar_agendamento,
        name="adicionar_agendamento",
    ),
    path("meus_agendamentos/", views.meus_agendamentos, name="meus_agendamentos"),
    path(
        "excluir_equipamento/<int:equipamento_id>/",
        views.excluir_equipamento,
        name="excluir_equipamento",
    ),
    path(
        "excluir_equipamento/<int:equipamento_id>/",
        excluir_equipamento,
        name="excluir_equipamento",
    ),
    path("administrador_home/", views.administrador_home, name="administrador_home"),
    path("cliente_home/", views.cliente_home, name="cliente_home"),
    path(
        "reagendar/<int:agendamento_id>/",
        reagendar_agendamento,
        name="reagendar_agendamento",
    ),
    path(
        "cancelar/<int:agendamento_id>/",
        cancelar_agendamento,
        name="cancelar_agendamento",
    ),
    path("accounts/", include("django.contrib.auth.urls")),
    path("register/", views.register, name="register"),
    path("logout/", auth_views.LogoutView.as_view(next_page="login"), name="logout"),
    path(
        "selecionar_nova_data_hora/<int:agendamento_id>/",
        views.selecionar_nova_data_hora,
        name="selecionar_nova_data_hora",
    ),
    path(
        "editar_equipamento/<int:equipamento_id>/",
        views.editar_equipamento,
        name="editar_equipamento",
    ),
    path(
        "devolucao_equipamento/<int:agendamento_id>/",
        views.devolucao_equipamento,
        name="devolucao_equipamento",
    ),
    path(
        "historico_agendamentos/",
        views.historico_agendamentos,
        name="historico_agendamentos",
    ),
    path(
        "obter_dados_equipamento/",
        views.obter_dados_equipamento,
        name="obter_dados_equipamento",
    ),
    path(
        "marcar_como_emprestado/",
        views.marcar_como_emprestado,
        name="marcar_como_emprestado",
    ),
    path("emprestimo_sucesso/", views.emprestimo_sucesso, name="emprestimo_sucesso"),
    path(
        "emprestimo_sucesso/<int:agendamento_id>/",
        views.emprestimo_sucesso,
        name="emprestimo_sucesso",
    ),
    path(
        "reset_password/", auth_views.PasswordResetView.as_view(), name="reset_password"
    ),
    path(
        "reset_password_sent/",
        auth_views.PasswordResetDoneView.as_view(),
        name="password_reset_done",
    ),
    path(
        "reset/<uidb64>/<token>",
        auth_views.PasswordResetConfirmView.as_view(),
        name="password_reset_confirm",
    ),
    path(
        "reset_password_complete/",
        auth_views.PasswordResetCompleteView.as_view(),
        name="password_reset_complete",
    ),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
