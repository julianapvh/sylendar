from django.urls import path
from . import views

urlpatterns = [
    # outras URLs do aplicativo...
    path('login_setic/', views.login_setic, name='login_setic'),
    # outras URLs do aplicativo...
]
