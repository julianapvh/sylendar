from django.contrib import admin
from django.urls import path, include
from agendamentos import views
from agendamentos.views import home, agendar_equipamento
from django.conf import settings
from django.conf.urls.static import static


app_name = 'Agendamento'

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', home, name='home'),
    path('agendar/', agendar_equipamento, name='agendar_equipamento'),
    path('agendar/cliente/', views.agendar_cliente, name='agendar_cliente'),
    path('agendar/cliente/success/', views.agendar_cliente_success, name='agendar_cliente_success'),
]

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
