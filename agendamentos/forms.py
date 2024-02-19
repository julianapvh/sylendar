from django import forms
from .models import Agendamento, Equipamento
from .models import Usuario

class AgendamentoForm(forms.ModelForm):
    class Meta:
        model = Agendamento
        fields = ['cliente_nome', 'cliente_cpf', 'equipamento', 'data', 'hora']
        
        
class EquipamentoForm(forms.ModelForm):
    class Meta:
        model = Equipamento
        fields = ['nome', 'descricao', 'fabricante', 'data_aquisicao']
######################################------------MODIFICAÇÕES---------------###################################################



class UserRegistrationForm(forms.ModelForm):
    password = forms.CharField(label='Senha', widget=forms.PasswordInput)

    class Meta:
        model = Usuario
        fields = ['username', 'password', 'nome', 'nome_completo', 'email', 'telefone', 'endereco', 'data_nascimento']