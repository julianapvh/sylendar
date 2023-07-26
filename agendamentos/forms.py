# agendamentos/forms.py
from django import forms
from .models import Agendamento
from .models import Equipamento

class LoginForm(forms.Form):
    username = forms.CharField(label='Usuário', max_length=100)
    password = forms.CharField(label='Senha', max_length=100, widget=forms.PasswordInput)


class AgendamentoForm(forms.Form):
    equipamento = forms.ModelChoiceField(queryset=Equipamento.objects.filter(disponivel=True))
    data_hora = forms.DateTimeField()

class AgendamentoForm(forms.ModelForm):
    class Meta:
        model = Agendamento
        fields = '__all__'