from django import forms
from django.forms import ModelForm
from .models import Post

class LoginForm(forms.Form):
    username = forms.CharField(label='Usuário')
    password = forms.CharField(label='Senha', widget=forms.PasswordInput)
    

class PostForm(ModelForm):
    class Meta:
        model = Post
        fields = ['title', 'slug', 'body', 'author', 'status']
