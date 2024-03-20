from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Agendamento, Equipamento, User
from .forms import UserRegistrationForm

class CustomUserAdmin(UserAdmin):
    add_form = UserRegistrationForm
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        ('Informações pessoais', {'fields': ('nome_completo', 'telefone', 'email')}),
        ('Permissões', {'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')}),
        ('Datas importantes', {'fields': ('last_login', 'date_joined')}),
    )

# Registrar os modelos no painel de administração

admin.site.register(Equipamento)
admin.site.register(User, CustomUserAdmin)
