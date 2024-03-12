from datetime import datetime
import json
import sys
#################  -------  ---------  ###########################
from dateutil.parser import parse
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from django.core.exceptions import PermissionDenied
from django.db.models import F, Q
from django.http import Http404, HttpResponse, HttpResponseForbidden, JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse_lazy
from django.utils import timezone
#################  -------  ---------  ###########################
from agendamentos.forms import AgendamentoForm, EquipamentoForm, UserRegistrationForm
from agendamentos.models import Agendamento, Equipamento, User
#################  -------  ---------  ###########################
from rolepermissions.decorators import has_permission_decorator, has_role_decorator
from rolepermissions.permissions import revoke_permission, grant_permission
from rolepermissions.roles import assign_role, get_user_roles
from django.contrib.auth.models import Group
from multiprocessing import context
from telnetlib import LOGOUT


#################  ------- Views de login, cadastro e home ---------  ###########################


def login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            # Verifique se o usuário é um administrador
            if user.is_superuser:
                # Se sim, redirecione para a página de administração
                return redirect('administrador')
            else:
                # Se não, redirecione para a página do cliente
                return redirect('cliente')
        else:
            # Caso as credenciais estejam incorretas
            return render(request, 'registration/login.html', {'error': 'Credenciais inválidas. Tente novamente.'})
    else:
        # Se a solicitação for GET, renderize a página de login
        return render(request, 'registration/login.html')

def register(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()  # Salva o usuário criado
            assign_role(user, 'cliente')  # Atribui o papel (grupo) 'cliente' ao usuário
            return redirect('login')  # Redireciona para a página de login após o registro bem-sucedido
        else:
            print(form.errors)  # Exibe os erros de validação no console para depuração
    else:
        form = UserCreationForm()
    return render(request, 'registration/register.html', {'form': form})
    
def home(request):   
    return render(request, 'home.html')    

def administrador_home(request):
    return render(request, 'administrador_home.html')

def cliente_home(request):
    return render(request, 'cliente_home.html')
    
@login_required
def cliente(request):
    # Verificar se o usuário está logado e se sim, obter os agendamentos dele
    if request.user.is_authenticated:
        # Obter os agendamentos do cliente atual
        agendamentos = Agendamento.objects.filter(cliente_nome=request.user.username)
        # Passar os agendamentos para o template como parte do contexto
        return render(request, 'cliente.html', {'agendamentos': agendamentos})
    else:
        # Caso o usuário não esteja logado, redirecionar para a página de login ou fazer qualquer outra coisa que desejar
        return redirect('login')  # Ou renderizar outro template informando que o usuário precisa estar logado
    
@login_required    
def administrador(request):

    return render(request, 'administrador.html')   
    
    
#################  ------- Funções do Sistema ---------  ###########################
        
        
def agendar_equipamento(request):
    if request.method == 'POST':
        equipamento_id = request.POST['equipamento']
        data = request.POST['data']
        hora = request.POST['hora']

        # Converta a data e hora em objetos datetime e torne-os conscientes do fuso horário
        data_hora = datetime.strptime(f"{data} {hora}", "%Y-%m-%d %H:%M")
        data_hora_consciente = timezone.make_aware(data_hora)

        # Verifique se a data e hora já passaram
        if data_hora_consciente < timezone.now():
            return JsonResponse({'success': False, 'message': 'Não é possível agendar um equipamento em uma data ou hora passada.'})

        # Verifique se o equipamento está disponível para agendamento
        agendamentos = Agendamento.objects.filter(
            equipamento_id=equipamento_id,
            data=data_hora_consciente.date(),
            hora=data_hora_consciente.time()
        )

        if agendamentos.exists():
            # Se houver agendamento para o equipamento na mesma data e hora, retorne uma resposta JSON indicando o erro
            return JsonResponse({'success': False, 'message': 'Este equipamento já está agendado para esta data e hora. Por favor, escolha outra data ou hora.'})
        else:
            # Obtenha o equipamento
            equipamento = Equipamento.objects.get(pk=equipamento_id)

            # Verifique se há equipamento disponível
            if equipamento.quantidade_disponivel > 0:
                # Criar o agendamento
                Agendamento.objects.create(
                    equipamento=equipamento,
                    cliente_nome=request.user.username,  # Use o nome do cliente armazenado na sessão
                    data=data_hora_consciente.date(),
                    hora=data_hora_consciente.time()
                )

                # Decrementar a quantidade disponível atomicamente
                Equipamento.objects.filter(pk=equipamento_id).update(quantidade_disponivel=F('quantidade_disponivel') - 1)

                # Retorne uma resposta JSON indicando que o agendamento foi bem-sucedido
                return JsonResponse({'success': True, 'message': 'Agendamento realizado com sucesso!'})
            else:
                # Se não houver equipamento disponível, retorne uma resposta JSON indicando o erro
                return JsonResponse({'success': False, 'message': 'Este equipamento não está disponível no momento.'})

    equipamentos = Equipamento.objects.all()
    context = {'equipamentos': equipamentos}
    return render(request, 'agendar_equipamento.html', context)

def historico(request):
    if request.user.is_authenticated:
        agendamentos = Agendamento.objects.filter(cliente_nome=request.user.username)

        # Criar um dicionário para mapear o ID do agendamento ao seu status
        status_agendamentos = {}
        for agendamento in agendamentos:
            if agendamento.cancelado:
                status_agendamentos[agendamento.id] = 'Cancelado'
            else:
                status_agendamentos[agendamento.id] = 'Agendado'

            # Verificar se o agendamento foi reagendado
            if agendamento.reagendado:
                status_agendamentos[agendamento.id] = 'Reagendado'

        return render(request, 'historico.html', {'agendamentos': agendamentos, 'status_agendamentos': status_agendamentos})
    else:
        return redirect('login')
        
def meus_agendamentos(request):
    # Verificar se o usuário está logado e, em caso afirmativo, obter seus agendamentos
    if request.user.is_authenticated:
        # Obter os agendamentos do cliente atual, excluindo os agendamentos cancelados
        agendamentos = Agendamento.objects.filter(cliente_nome=request.user.username, cancelado=False)
        
        # Adicione a lógica de filtragem por data e equipamento, se houver parâmetros de consulta na solicitação
        data_filter = request.GET.get('data')
        equipamento_filter = request.GET.get('equipamento')
        
        if data_filter:
            agendamentos = agendamentos.filter(data=data_filter)
        
        if equipamento_filter:
            agendamentos = agendamentos.filter(equipamento__nome__icontains=equipamento_filter)

        # Passar os agendamentos para o template como parte do contexto
        context = {'agendamentos': agendamentos}
        return render(request, 'meus_agendamentos.html', context)
    else:
        # Caso o usuário não esteja logado, redirecionar para a página de login ou fazer qualquer outra coisa que desejar
        return redirect('login')  # Ou renderizar outro template informando que o usuário precisa estar logado
    
def visualizar_equipamentos(request):
    equipamentos = Equipamento.objects.all()
    return render(request, 'listar_equipamentos.html', {'equipamentos': equipamentos})
     
def reagendar_agendamento(request, agendamento_id):
    agendamento = get_object_or_404(Agendamento, pk=agendamento_id)

    if request.method == 'POST':
        data = json.loads(request.body.decode('utf-8'))  # Decodifica o JSON enviado no corpo da requisição
        nova_data = data.get('nova_data')
        nova_hora = data.get('nova_hora')

        if nova_data and nova_hora:
            try:
                agendamento.data = nova_data
                agendamento.hora = nova_hora
                agendamento.save()
                return JsonResponse({'mensagem': 'Agendamento reagendado com sucesso!'})
            except ValueError:
                return JsonResponse({'erro': 'Data ou hora inválida. Por favor, verifique e tente novamente.'}, status=400)
        else:
            return JsonResponse({'erro': 'Por favor, selecione uma nova data e hora.'}, status=400)
    else:
        return JsonResponse({'erro': 'Método não permitido'}, status=405)
        
def cancelar_agendamento(request, agendamento_id):
    # Verificar se o usuário está autenticado
    if not request.user.is_authenticated:
        return redirect('login')  # Redirecionar para a página de login se não estiver autenticado

    try:
        # Obter o agendamento pelo ID
        agendamento = get_object_or_404(Agendamento, pk=agendamento_id, cliente_nome=request.user)

        # Obter o equipamento associado ao agendamento
        equipamento = agendamento.equipamento

        # Marcar o agendamento como cancelado
        agendamento.cancelado = True
        agendamento.save()

        # Incrementar a quantidade disponível do equipamento associado
        equipamento.quantidade_disponivel += 1
        equipamento.save()

        # Redirecionar para a página de meus agendamentos ou para onde desejar
        return redirect('meus_agendamentos')
    except Agendamento.DoesNotExist:
        # Se o agendamento não for encontrado, levantar uma exceção Http404
        raise Http404("O agendamento não foi encontrado.")
                    
def editar_equipamento(request):
    if request.method == 'POST':
        equipamento_id = request.POST.get('equipamento_id')
        nome = request.POST.get('nome')
        descricao = request.POST.get('descricao')
        fabricante = request.POST.get('fabricante')
        data_aquisicao = request.POST.get('data_aquisicao')
        quantidade_disponivel = request.POST.get('quantidade_disponivel')
        
        # Obtenha o equipamento a ser editado
        equipamento = get_object_or_404(Equipamento, pk=equipamento_id)
        
        # Atualize os dados do equipamento
        equipamento.nome = nome
        equipamento.descricao = descricao
        equipamento.fabricante = fabricante
        equipamento.data_aquisicao = data_aquisicao
        equipamento.quantidade_disponivel = quantidade_disponivel
        equipamento.save()
        
        # Redireciona o usuário para a página de gerenciamento de equipamentos
        return redirect('editar_equipamento')
    else:
        # Se não for uma solicitação POST, renderize o formulário de edição
        equipamentos = Equipamento.objects.all()
        return render(request, 'editar_equipamento.html', {'equipamentos': equipamentos})
           
def cadastrar_equipamento(request):
    if request.method == 'POST':
        # Obter os dados do formulário
        nome_equipamento = request.POST.get('nome_equipamento')
        descricao = request.POST.get('descricao')
        quantidade_disponivel = request.POST.get('quantidade_disponivel')

        # Verificar se os campos obrigatórios estão preenchidos
        if not nome_equipamento:
            # O campo nome_equipamento não foi preenchido.
            messages.error(request, 'O campo nome é obrigatório.')
            return render(request, 'cadastrar_equipamento.html')

        try:
            # Criar um novo equipamento
            equipamento = Equipamento(nome=nome_equipamento, descricao=descricao, quantidade_disponivel=quantidade_disponivel)
            equipamento.save()

            # Define a mensagem de sucesso
            messages.success(request, 'O equipamento foi salvo com sucesso.')

            # Redireciona o usuário para a página de visualização de equipamentos
            return redirect('visualizar_equipamentos')
        except Exception as e:
            # Se ocorrer um erro ao salvar, exibe uma mensagem de erro
            messages.error(request, f'O equipamento não foi salvo. Erro: {e}')
            return render(request, 'cadastrar_equipamento.html')

    else:
        return render(request, 'cadastrar_equipamento.html')

def excluir_equipamento(request):
    if request.method == 'POST':
        equipamento_id = request.POST.get('equipamento_id')
        equipamento = get_object_or_404(Equipamento, pk=equipamento_id)
        try:
            # Excluir o equipamento
            equipamento.delete()
            # Define a mensagem de sucesso
            messages.success(request, 'O equipamento foi excluído com sucesso.')
            # Redireciona o usuário para a página de gerenciamento de equipamentos
            return redirect('gerenciar_equipamentos')
        except Exception as e:
            # Se ocorrer um erro ao excluir, exibe uma mensagem de erro
            messages.error(request, f'O equipamento não foi excluído. Erro: {e}')
            # Redireciona o usuário de volta para a página de excluir equipamento
            return redirect('excluir_equipamento')
    else:
        equipamentos = Equipamento.objects.all()
        return render(request, 'excluir_equipamento.html', {'equipamentos': equipamentos})

def confirmar_exclusao_equipamento(request, equipamento_id):
    equipamento = get_object_or_404(Equipamento, pk=equipamento_id)
    equipamento.delete()
    return redirect('gerenciar_equipamentos')
    
def gerenciar_equipamentos(request):
    equipamentos = Equipamento.objects.all()  # Obtém todos os equipamentos do banco de dados

    # Renderiza a página 'gerenciar_equipamentos.html' e passa os equipamentos para o contexto do template
    return render(request, 'gerenciar_equipamentos.html', {'equipamentos': equipamentos})

def alterar_equipamento(request, equipamento_id):
    equipamento = get_object_or_404(Equipamento, pk=equipamento_id)
    if request.method == 'POST':
        form = EquipamentoForm(request.POST, instance=equipamento)
        if form.is_valid():
            form.save()
            return redirect('gerenciar_equipamentos')
    else:
        form = EquipamentoForm(instance=equipamento)
    return render(request, 'alterar_equipamento.html', {'form': form, 'equipamento': equipamento})
      
def user_list(request):
    users = User.objects.all()
    return render(request, 'user_list.html', {'users': users})
     

#################  ------- Páginas de erro ---------  ###########################


def error_404_view(request, exception):
    return render(request, 'pagina_erro.html', {'heading': 'Erro 404', 'message': 'Página não encontrada'}, status=404)

def error_500_view(request):
    return render(request, 'pagina_erro.html', {'heading': 'Erro 500', 'message': 'Ocorreu um erro interno no servidor'}, status=500)

def pagina_erro(request):
    # Defina as variáveis de exceção
    exception_type = "FastDevVariableDoesNotExist"  # O tipo de exceção que ocorreu
    exception_value = "exception_value_placeholder"  # O valor da exceção (se necessário)
    traceback = "traceback_placeholder"  # O rastreamento da exceção (se necessário)

    # Renderize o template com as variáveis no contexto
    return render(request, 'pagina_erro.html', {
        'exception_type': exception_type,
        'exception_value': exception_value,
        'traceback': traceback,
    })
        
def error_404_view(request, exception):
    return render(request, 'pagina_erro.html', {'heading': 'Erro 404', 'message': 'Página não encontrada'}, status=404)

def error_500_view(request):
    return render(request, 'pagina_erro.html', {'heading': 'Erro 500', 'message': 'Ocorreu um erro interno no servidor'}, status=500)
      
      
#################  -------Novas Funções---------  ###########################
                    
                    
def logged_out(request):
    LOGOUT(request)
    return redirect(login)
    
def sucesso_agendamento(request):
    return render(request, 'sucesso_agendamento.html')

