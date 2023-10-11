from django.urls import path
from . import views
from .views import login_custom
from django.contrib import admin


app_name = 'agendamentos'  # Defina um namespace para o aplicativo

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.index, name='index'),
    path('cliente/', views.iniciar_janela_cliente, name='cliente'),
    path('adicionar/', views.adicionar_agendamento, name='adicionar_agendamento'),
    path('cancelar/<int:id>/', views.cancelar_agendamento, name='cancelar_agendamento'),
    path('historico/', views.exibir_historico_agendamentos, name='historico_agendamentos'),
    path('home/', views.home_view, name='home'),
    path('login/', login_custom, name='login_custom'),
    path('home/', views.home_view, name='home'),  # URL para a página home
    # Adicione outras URLs aqui
]

