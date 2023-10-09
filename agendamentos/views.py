# agendamento/views.py
from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Agendamento
from .forms import AgendamentoForm
# agendamentos/views.py
from django.shortcuts import render
from .login_sauron import login_setic
from django.shortcuts import render
from django.contrib.auth import authenticate, login


def index(request):
    # Lógica da página inicial aqui
    return render(request, 'agendamentos/index.html')  # Use o template apropriado


def inicializa_tela_login(request):
    # Lógica de inicialização de tela de login
    return render(request, 'agendamento/login.html')

def iniciar_janela_cliente(request):
    # Lógica para iniciar a janela do cliente
    return render(request, 'agendamento/cliente.html')

def adicionar_agendamento(request):
    if request.method == 'POST':
        form = AgendamentoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('cliente')
    else:
        form = AgendamentoForm()
    
    return render(request, 'agendamento/adicionar_agendamento.html', {'form': form})

def cancelar_agendamento(request, id):
    try:
        agendamento = Agendamento.objects.get(id=id)
        agendamento.delete()
        return HttpResponse("Agendamento cancelado com sucesso.")
    except Agendamento.DoesNotExist:
        return HttpResponse("Agendamento não encontrado.")

def exibir_historico_agendamentos(request):
    agendamentos = Agendamento.objects.all()
    return render(request, 'agendamento/historico_agendamentos.html', {'agendamentos': agendamentos})
    
    
    

def index(request):
    # Chama a função Python e obtém o resultado
    resultado = login_setic()

    # Passe o resultado para o template
    return render(request, 'agendamentos/index.html', {'resultado': resultado})



def login(request):
    if request.method == 'POST':
        # Se o formulário de login foi enviado
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)

        if user is not None:
            # O usuário está autenticado com sucesso
            login(request, user)
            # Redirecionar para a página inicial do aplicativo após o login
            return redirect('index')
        else:
            # Exibir uma mensagem de erro de autenticação
            error_message = 'Credenciais inválidas. Tente novamente.'
            return render(request, 'nome_do_aplicativo/login.html', {'error_message': error_message})
    else:
        # Se a página de login foi acessada por GET (primeira vez)
        return render(request, 'nome_do_aplicativo/login.html')
