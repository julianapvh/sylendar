from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Agendamento
from datetime import datetime

def realizar_login(request):
    if request.method == 'POST':
        usuario = request.POST['usuario']
        senha = request.POST['senha']
        
        # Coloque aqui a lógica de login do seu sistema, e redirecione para a página do cliente em caso de sucesso
        if login_successful:
            return redirect('cliente')
        else:
            messages.error(request, 'Erro ao realizar o login.')

    return render(request, 'login.html')

def cliente(request):
    equipamentos_disponiveis = []  # Carregue os equipamentos do seu banco de dados
    datas_agendadas = []  # Carregue as datas agendadas do seu banco de dados
    
    if request.method == 'POST':
        equipamento = request.POST['equipamento']
        data = request.POST['data']
        hora = request.POST['hora']
        
        # Coloque aqui a lógica para adicionar um agendamento no seu banco de dados
        if agendamento_successful:
            messages.success(request, 'Agendamento adicionado com sucesso.')
        else:
            messages.error(request, 'Erro ao adicionar o agendamento.')

    return render(request, 'cliente.html', {'equipamentos_disponiveis': equipamentos_disponiveis, 'datas_agendadas': datas_agendadas})

def cancelar_agendamento(request, agendamento_id):
    # Coloque aqui a lógica para cancelar um agendamento no seu banco de dados
    messages.success(request, 'Agendamento cancelado com sucesso.')
    return redirect('cliente')

def historico_agendamentos(request):
    historico = Agendamento.objects.all()  # Carregue o histórico de agendamentos do seu banco de dados
    return render(request, 'historico.html', {'historico': historico})
