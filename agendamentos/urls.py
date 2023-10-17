# Imports
from django.urls import path
from agendamentos import views


# links
urlpatterns = [

    path('', views.index, name='index'),
    path('/home',views.home, name='home'),
   

]