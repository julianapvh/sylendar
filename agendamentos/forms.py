from django import forms
from .models import Agendamento

class AgendamentoForm(forms.ModelForm):
    class Meta:
        model = Agendamento
        fields = ['cliente_nome', 'cliente_cpf', 'equipamento', 'data', 'hora']
