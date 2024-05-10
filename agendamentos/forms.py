from django import forms
from .models import Agendamento, Equipamento
from .models import User
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from agendamentos.models import User
from django.core.validators import RegexValidator


class AgendamentoForm(forms.ModelForm):
    class Meta:
        model = Agendamento
        fields = ["cliente_nome", "cliente_cpf", "equipamento", "data", "hora"]


class EquipamentoForm(forms.ModelForm):
    class Meta:
        model = Equipamento
        fields = [
            "nome",
            "descricao",
            "fabricante",
            "data_aquisicao",
            "quantidade_disponivel",
        ]  # Adicione 'quantidade_disponivel'


######################################------------MODIFICAÇÕES---------------###################################################


class UserRegistrationForm(forms.ModelForm):
    password1 = forms.CharField(label="Senha", widget=forms.PasswordInput)
    password2 = forms.CharField(
        label="Confirmação de senha", widget=forms.PasswordInput
    )

    class Meta:
        model = User
        fields = ["nome_completo", "telefone", "username", "email"]

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


class UserCreationFormWithExtraFields(UserCreationForm):
    email = forms.EmailField(label="E-mail")
    first_name = forms.CharField(label="Primeiro Nome")
    last_name = forms.CharField(label="Sobrenome")
    telefone = forms.CharField(label="Telefone", validators=[RegexValidator(regex=r'^\d{11}$', message='O número de telefone deve ter 11 dígitos.')])

    class Meta(UserCreationForm.Meta):
        fields = UserCreationForm.Meta.fields + ("email", "first_name", "last_name", "telefone")  # Corrigido para adicionar o campo "telefone"


class UserProfileForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email', 'telefone']