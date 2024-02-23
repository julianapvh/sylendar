from django import forms
from .models import Agendamento, Equipamento
from .models import Usuario
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from agendamentos.models import Usuario

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
    password1 = forms.CharField(label='Senha', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Confirmação de senha', widget=forms.PasswordInput)

    class Meta:
        model = Usuario
        fields = ['nome_completo', 'telefone', 'username', 'email']

    def clean_password2(self):
        # Verifica se as duas senhas inseridas são iguais
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("As senhas não correspondem")
        return password2

    def save(self, commit=True):
        user = super().save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()
        return user
        
