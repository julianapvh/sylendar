from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Agendamento
from .forms import AgendamentoForm
from django.contrib.auth import authenticate, login
from django.contrib.auth import logout
from django.contrib.auth.decorators import login_required
from django.urls import reverse
from . import login_sauron  # Importe seu módulo de login
from django.shortcuts import render
from django.http import HttpResponse
from .login_sauron import login_setic


  # Use o namespace 'agendamentos'
# Função index para a página inicial
def index(request):
    # Lógica da página inicial aqui
    return render(request, 'agendamentos/login.html')  # Use o template apropriado

# Função para inicialização da tela de login
def inicializa_tela_login(request):
    # Lógica de inicialização de tela de login
    return render(request, 'agendamentos/login.html')

# Função para iniciar a janela do cliente
def iniciar_janela_cliente(request):
    # Lógica para iniciar a janela do cliente
    return render(request, 'agendamentos/cliente.html')

# Função para adicionar um agendamento
def adicionar_agendamento(request):
    if request.method == 'POST':
        form = AgendamentoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('cliente')
    else:
        form = AgendamentoForm()
    
    return render(request, 'agendamentos/adicionar_agendamento.html', {'form': form})

# Função para cancelar um agendamento
def cancelar_agendamento(request, id):
    try:
        agendamento = Agendamento.objects.get(id=id)
        agendamento.delete()
        return HttpResponse("Agendamento cancelado com sucesso.")
    except Agendamento.DoesNotExist:
        return HttpResponse("Agendamento não encontrado.")

# Função para exibir o histórico de agendamentos
def exibir_historico_agendamentos(request):
    agendamentos = Agendamento.objects.all()
    return render(request, 'agendamentos/historico_agendamentos.html', {'agendamentos': agendamentos})

# Função para lidar com o login de usuário
def login_user(request):
    if request.method == 'POST':
        # Se o formulário de login foi enviado
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)

        if user is not None:
            # O usuário está autenticado com sucesso
            login(request, user)
            # Redirecionar para a página inicial após o login
            return redirect('home')
        else:
            # Exibir uma mensagem de erro de autenticação
            error_message = 'Credenciais inválidas. Tente novamente.'
            return render(request, 'agendamentos/login.html', {'error_message': error_message})
    else:
        # Se a página de login foi acessada por GET (primeira vez)
        return render(request, 'agendamentos/login.html')

# Função para a página inicial após o login
@login_required
def home_view(request):
    return render(request, 'agendamentos/home.html')
    
    
def logout_user(request):
    logout(request)
    # Redirecionar para onde você desejar após o logout, por exemplo, a página inicial.
    return redirect('home')
    
def login_view(request):
    if request.method == 'POST':
        # Se a solicitação for um POST, processe os dados de login
        username = request.POST['username']
        password = request.POST['password']
        
        # Você não precisa chamar a função login_setic() aqui

        # Redirecione o usuário para a página do Sauron com os parâmetros de login
        return redirect(f"https://meuacesso.sistemas.ro.gov.br/?Username={username}&Password={password}")

    # Se a solicitação não for um POST, renderize a página de login
    return render(request, 'login.html')




def login_custom(request):
    if request.method == 'POST':
        # Chame a função de login personalizada
        #print("X")
        resultado = login_setic()
        if resultado == "Sucesso":  # Personalize isso com base no retorno da sua função de login
            return HttpResponse("Login bem-sucedido")
        else:
            return HttpResponse("Erro no login")

    # Se o método não for POST, renderize o formulário de login
    return render(request, 'seu_template_de_login.html')
    
def login_user(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            return redirect('home')  # Redirecionar para a página inicial após o login
        else:
            error_message = 'Credenciais inválidas. Tente novamente.'
            return render(request, 'agendamentos/login.html', {'error_message': error_message})
    else:
        return render(request, 'agendamentos/login.html')
        
        


def login_custom(request):
    # ...
    return render(request, 'login.html')  # Correct template name



    






