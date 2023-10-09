from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Agendamento  # Certifique-se de que o modelo Agendamento está definido no seu aplicativo
from django.contrib.auth import authenticate, login  # Importar funções para autenticação


def index(request):
    # Coloque aqui a lógica para renderizar a página inicial do aplicativo 'agendamentos'
    return render(request, 'agendamentos/templates/home.html')  # Substitua 'agendamentos/index.html' pelo caminho correto do seu template 
    
def realizar_login(request):
    if request.method == 'POST':
        usuario = request.POST['usuario']
        senha = request.POST['senha']
        
        # Use a função authenticate para verificar as credenciais do usuário
        user = authenticate(request, username=usuario, password=senha)
        
        if user is not None:
            # Se a autenticação for bem-sucedida, faça o login do usuário
            login(request, user)
            return redirect('cliente')
        else:
            messages.error(request, 'Erro ao realizar o login. Verifique suas credenciais.')

    return render(request, 'login.html')

def cliente(request):
    equipamentos_disponiveis = []  # Carregue os equipamentos do seu banco de dados
    datas_agendadas = []  # Carregue as datas agendadas do seu banco de dados
    
    if request.method == 'POST':
        equipamento = request.POST['equipamento']
        data = request.POST['data']
        hora = request.POST['hora']
        
        # Coloque aqui a lógica para adicionar um agendamento no seu banco de dados
        # Certifique-se de verificar a autenticação do usuário antes de adicionar um agendamento
        if request.user.is_authenticated:
            # Adicione a lógica para criar o agendamento no banco de dados
            messages.success(request, 'Agendamento adicionado com sucesso.')
        else:
            messages.error(request, 'Erro ao adicionar o agendamento. Faça login primeiro.')

    return render(request, 'cliente.html', {'equipamentos_disponiveis': equipamentos_disponiveis, 'datas_agendadas': datas_agendadas})

def cancelar_agendamento(request, agendamento_id):
    # Coloque aqui a lógica para cancelar um agendamento no seu banco de dados
    # Certifique-se de verificar a autenticação do usuário antes de cancelar um agendamento
    if request.user.is_authenticated:
        # Adicione a lógica para cancelar o agendamento no banco de dados
        messages.success(request, 'Agendamento cancelado com sucesso.')
    else:
        messages.error(request, 'Erro ao cancelar o agendamento. Faça login primeiro.')
    return redirect('cliente')

def historico_agendamentos(request):
    # Carregue o histórico de agendamentos apenas se o usuário estiver autenticado
    if request.user.is_authenticated:
        historico = Agendamento.objects.all()  # Carregue o histórico de agendamentos do seu banco de dados
        return render(request, 'historico.html', {'historico': historico})
    else:
        messages.error(request, 'Você não tem permissão para acessar o histórico. Faça login primeiro.')
        return redirect('realizar_login')
