from django.conf import settings
from django.contrib import admin
from django.urls import path, include
from agendamentos import views
from agendamentos.views import (
    cancelar_agendamento,
    excluir_equipamento,
    historico_agendamentos,
    reagendar_agendamento,
)
from django.contrib.auth import views as auth_views
from django.views.generic import RedirectView
from django.contrib.auth import views as auth_views
from django.conf.urls.static import static
from django.conf import settings
from django.contrib import admin
from django.urls import path, include
from agendamentos import views, api_views
from django.contrib.auth import views as auth_views
from django.views.generic import RedirectView
from django.contrib.auth import views as auth_views
from django.conf.urls.static import static
from django.conf.urls import handler404, handler500
from agendamentos.views import logged_out


tcc_django = "agendamentos"
urlpatterns = [
    path("", RedirectView.as_view(url="/index/")),
    path("index/", views.index, name="index"),
    path("cadastro/", views.cadastro, name="cadastro"),
    path("admin/", admin.site.urls),
    path("cliente/", views.cliente, name="cliente"),
    path("home/", views.home, name="home"),
    path("agendar_equipamento/", views.agendar_equipamento, name="agendar_equipamento"),
    path("historico/", views.historico, name="historico"),
    path("administrador/", views.administrador, name="administrador"),
    path(
        "cadastrar_equipamento/",
        views.cadastrar_equipamento,
        name="cadastrar_equipamento",
    ),
    path(
        "editar_equipamento/<int:equipamento_id>/",
        views.editar_equipamento,
        name="editar_equipamento",
    ),
    path("meus_agendamentos/", views.meus_agendamentos, name="meus_agendamentos"),
    path(
        "visualizar_equipamentos/",
        views.visualizar_equipamentos,
        name="visualizar_equipamentos",
    ),
    path("excluir_equipamento/", views.excluir_equipamento, name="excluir_equipamento"),
    path("editar_equipamento/", views.editar_equipamento, name="editar_equipamento"),
    path(
        "editar_equipamento/<int:equipamento_id>/",
        views.editar_equipamento,
        name="editar_equipamento",
    ),
    path(
        "excluir_equipamento/<int:equipamento_id>/",
        excluir_equipamento,
        name="excluir_equipamento",
    ),
    path("administrador_home/", views.administrador_home, name="administrador_home"),
    path("login/", auth_views.LoginView.as_view(), name="login"),
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
    path(
        "accounts/logout/",
        auth_views.LogoutView.as_view(next_page="logged_out"),
        name="logout",
    ),
    path("logged_out/", views.logged_out, name="logged_out"),
    path("", RedirectView.as_view(pattern_name="login", permanent=False)),
    path("accounts/", include("django.contrib.auth.urls")),
    path("register/", views.register, name="register"),
    path("marcar_devolucao/", views.marcar_devolucao, name="marcar_devolucao"),
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
    path("api/check_username/", api_views.check_username, name="check_username_api"),
]

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)


# Configurações para páginas de erro personalizadas
handler400 = "agendamentos.views.custom_400_view"
handler403 = "agendamentos.views.custom_403_view"
handler404 = "agendamentos.views.custom_404_view"
handler500 = "agendamentos.views.custom_500_view"
