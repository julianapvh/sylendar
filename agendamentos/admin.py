from django.contrib import admin
from .models import Agendamento, Equipamento, Usuario
from agendamentos.models import Usuario

# Registre o modelo Agendamento no painel de administração
admin.site.register(Agendamento)

# Registre o modelo Usuario no painel de administração
admin.site.register(Usuario)

admin.site.register(Equipamento)
