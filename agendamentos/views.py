from django.shortcuts import render, redirect
from .forms import AgendamentoForm, LoginForm
from .models import Equipamento

def agendar_cliente(request):
    if request.method == 'POST':
        form = AgendamentoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('agendamentos:agendar_cliente_success')
    else:
        form = AgendamentoForm()

    return render(request, 'clientes/agendar_cliente.html', {'form': form})

def home(request):
    # Verificar se o usuário já está autenticado
    
   
    if request.user.is_authenticated:
        # Aqui você pode redirecionar para a página inicial ou outra página após o login
        return redirect('pagina_inicial')

    if request.method == 'POST':
        form = AgendamentoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('agendamentos:agendar_cliente_success')
    else:
        form = AgendamentoForm()

    return render(request, 'agendamentos/agendar_cliente.html', {'form': form})

def agendar_cliente_success(request):
    # Add any logic or data processing here if needed
    return render(request, 'agendamentos/agendar_cliente_success.html')

def agendar_equipamento(request):
    if request.method == 'POST':
        form = AgendamentoForm(request.POST)
        if form.is_valid():
            equipamento = form.cleaned_data['equipamento']
            data_hora = form.cleaned_data['data_hora']

            # Verificar se o equipamento está disponível na data/hora escolhida
            if equipamento.disponivel:
                # Salvar o agendamento no banco de dados
                equipamento.disponivel = False  # Marcar o equipamento como indisponível
                equipamento.save()

                # Aqui você pode adicionar qualquer outra lógica relacionada ao agendamento, se necessário
                # Por exemplo, enviar um e-mail de confirmação, notificar o usuário, etc.

                return redirect('home')  # Redirecionar o usuário de volta para a página inicial

    else:
        form = AgendamentoForm()

    return render(request, 'agendamentos/agendar_equipamento.html', {'form': form})


def agendar_cliente_success(request):
    # Adicione qualquer lógica ou processamento de dados aqui, se necessário
    return render(request, 'agendamentos/agendar_cliente_success.html')
