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
    path('administrador/', views.administrador, name='administrador'),
    #path('cadastrar_equipamento/', views.cadastrar_equipamentos, name='cadastrar_equipamento'),
    path('editar_equipamento/', views.editar_equipamento, name='editar_equipamento'),
    #path('excluir_equipamento/', views.excluir_equipamento, name='excluir_equipamento'),
    
    
    
    path('equipamentos_list/', views.listar_equipamentos, name='equipamentos_list'),
    path('cadastrar_equipamento/', views.cadastrar_equipamento, name='cadastrar_equipamento'),
    path('gerenciar_equipamentos/', views.gerenciar_equipamentos, name='gerenciar_equipamentos'),
    path('excluir_equipamento/<int:equipamento_id>/', views.excluir_equipamento, name='excluir_equipamento'),
    path('alterar_equipamento/<int:equipamento_id>/', views.alterar_equipamento, name='alterar_equipamento'),
    
]
