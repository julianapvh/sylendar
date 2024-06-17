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
from agendamentos.api_views import check_username
from .views import logged_out
from agendamentos.views import logged_out
from django.conf.urls import handler404, handler500
from .views import erro_500_view
from .views import privacy_policy, register_cookie_consent


tcc_django = "agendamentos"
urlpatterns = [
    path("index/", views.index, name="index"),
    path("cadastro/", views.cadastro, name="cadastro"),
    path("login/", views.login, name="login"),
    path(
        "accounts/logout/",
        auth_views.LogoutView.as_view(next_page="logged_out"),
        name="logout",
    ),
    path("logged_out/", views.logged_out, name="logged_out"),
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
    path("perfil/", views.profile, name="perfil"),
    path("base/", views.base, name="base"),
    path(
        "equipamentos_disponiveis/",
        views.equipamentos_disponiveis,
        name="equipamentos_disponiveis",
    ),
    path(
        "agendamentos_emprestados/",
        views.agendamentos_emprestados,
        name="agendamentos_emprestados",
    ),
    path("register-consent/", register_cookie_consent, name="register_cookie_consent"),
    path("privacy-policy/", privacy_policy, name="privacy_policy"),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

# Configurações para páginas de erro personalizadas
handler400 = "agendamentos.views.custom_400_view"
handler403 = "agendamentos.views.custom_403_view"
handler404 = "agendamentos.views.custom_404_view"
handler500 = "agendamentos.views.custom_500_view"
