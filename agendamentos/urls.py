from django.contrib import admin
from django.urls import path, include
from . import views

urlpatterns = [
    path('', include('agendamentos.urls')),  # Adicione esta linha
    path('admin/', admin.site.urls),
    path('login/', include('login_app.urls')),
    path('cliente/', include('cliente_app.urls')),
    path('cancelar/<int:agendamento_id>/', include('cancelar_app.urls')),
    path('historico/', include('historico_app.urls')),
]
