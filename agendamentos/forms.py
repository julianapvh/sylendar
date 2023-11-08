from django import forms
from .models import Agendamento, Equipamento

class AgendamentoForm(forms.ModelForm):
    class Meta:
        model = Agendamento
        fields = ['cliente_nome', 'cliente_cpf', 'equipamento', 'data', 'hora']
        
        
class EquipamentoForm(forms.ModelForm):
    class Meta:
        model = Equipamento
        fields = ['nome', 'descricao', 'fabricante', 'data_aquisicao']
######################################------------MODIFICAÇÕES---------------###################################################



