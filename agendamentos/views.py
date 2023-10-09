from django.shortcuts import render, redirect
from .models import Equipamento, Agendamento
from .forms import AgendamentoForm

def index(request):
    equipamentos = Equipamento.objects.all()
    agendamentos = Agendamento.objects.all()
    return render(request, 'agendamentos/index.html', {'equipamentos': equipamentos, 'agendamentos': agendamentos})

def adicionar_agendamento(request):
    if request.method == 'POST':
        form = AgendamentoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('index')
    else:
        form = AgendamentoForm()
    return render(request, 'agendamentos/adicionar_agendamento.html', {'form': form})
