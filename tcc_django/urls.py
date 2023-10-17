from django.contrib import admin
from django.urls import path, include
from django.contrib import admin
from django.urls import path
from agendamentos import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('agendamentos.urls')),
    # Outras URLs do projeto principal
]




urlpatterns = [
    #path('admin/', admin.site.urls),

    path('', views.index, name='index'),
]