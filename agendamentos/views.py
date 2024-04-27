from collections import Counter
from datetime import datetime, timedelta, time
from imaplib import _Authenticator
from django.contrib.auth import authenticate, login
from django.contrib.admin.views.decorators import staff_member_required
from itertools import count
import json
from os import truncate
import sys
from dateutil.parser import parse
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import HistoricoAgendamento, User
from django.db.models import Count, DateTimeField, F, Q
from django.http import Http404, HttpResponse, HttpResponseForbidden, HttpResponseServerError, JsonResponse
from django.http import HttpResponseBadRequest
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse_lazy
from django.utils import timezone
from django.utils.timezone import make_aware
from requests import request
from agendamentos.forms import AgendamentoForm, EquipamentoForm, UserCreationFormWithExtraFields, UserRegistrationForm
from agendamentos.models import Agendamento, Equipamento
from rolepermissions.decorators import has_permission_decorator, has_role_decorator
from rolepermissions.permissions import revoke_permission, grant_permission
from rolepermissions.roles import assign_role, get_user_roles
from django.db.models.functions import Trunc
from django.db.models.functions import TruncDate
from django.db import transaction
import logging
from django.core.paginator import Paginator
from django.db.models.signals import post_save
from django.dispatch import receiver


#################  ------- Views de login, cadastro e home ---------  ###########################
def login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            # Verifique se o usuário é um superusuário ou um administrador
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
        form = UserCreationFormWithExtraFields(request.POST)
        if form.is_valid():
            user = form.save()  # Salva o usuário criado
            assign_role(user, 'cliente')  # Atribui o papel (grupo) 'cliente' ao usuário
            messages.success(request, 'Usuário cadastrado com sucesso! Faça o login para acessar sua conta.')  # Mensagem de sucesso
            return redirect('login')  # Redireciona para a página de login após o registro bem-sucedido
        else:
            for field, errors in form.errors.items():
                for error in errors:
                    messages.error(request, f"Erro no campo '{field}': {error}")  # Mensagem de erro para cada campo inválido
            print(form.errors)  # Exibe os erros de validação no console para depuração
    else:
        form = UserCreationFormWithExtraFields()
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
@user_passes_test(lambda u: u.is_superuser, login_url='/login/')    
def administrador(request):

    return render(request, 'administrador.html')   
    
def logged_out(request):
    if request.method == 'POST':
        logout(request)
        return redirect('login')
    else:
        # Se a solicitação não for POST, redirecione para onde desejar
        return redirect('logged_out')
#################  ------- Funções do Sistema ---------  ###########################   
@transaction.atomic
def agendar_equipamento(request):
    if request.method == 'POST':
        try:
            equipamento_id = request.POST['equipamento']
            data = request.POST['data']
            hora = request.POST['hora']
            tipo_servico = request.POST['tipo_servico']
            quantidade_dias = int(request.POST.get('quantidade_dias', 3))  # Default: 3 dias

            # Converta a data e hora em objetos datetime e torne-os conscientes do fuso horário
            data_hora = datetime.strptime(f"{data} {hora}", "%Y-%m-%d %H:%M")
            data_hora_consciente = timezone.make_aware(data_hora)

            # Verifique se a data e hora são anteriores à data e hora atual
            if data_hora_consciente < timezone.now():
                return JsonResponse({'success': False, 'message': 'Não é possível agendar um equipamento em uma data ou hora passada.'}, status=400)

            # Verifique se a data é para o mesmo dia e se a hora é pelo menos 1 hora à frente
            if data_hora_consciente.date() == timezone.now().date():
                if data_hora_consciente - timezone.now() < timedelta(hours=1):
                    return JsonResponse({'success': False, 'message': 'É necessário agendar com pelo menos 1 hora de antecedência.'}, status=400)

            # Obtenha o equipamento
            equipamento = Equipamento.objects.get(pk=equipamento_id)

            # Verifique a disponibilidade do equipamento
            agendamentos_conflitantes = Agendamento.objects.filter(
                Q(data=data_hora_consciente.date(), hora=data_hora_consciente.time()) |
                Q(data_entrega_prevista__gte=data_hora_consciente) &
                Q(data__lte=data_hora_consciente.date(), hora__lte=data_hora_consciente.time(), equipamento=equipamento)
            )

            if agendamentos_conflitantes.exists():
                return JsonResponse({'success': False, 'message': 'Este equipamento não está disponível para o horário solicitado.'}, status=400)

            # Criar o agendamento
            Agendamento.objects.create(
                equipamento=equipamento,
                cliente_nome=request.user.username,  # Use o nome do cliente armazenado na sessão
                data=data_hora_consciente.date(),
                hora=data_hora_consciente.time(),
                quantidade_dias=quantidade_dias,
                tipo_servico=tipo_servico
            )

            # Retorne uma resposta JSON indicando que o agendamento foi bem-sucedido
            return JsonResponse({'success': True, 'message': 'Agendamento realizado com sucesso!'})
            
        except KeyError:
            # Se os dados do formulário não foram fornecidos corretamente, retorne uma resposta JSON com erro 400 Bad Request
            return JsonResponse({'success': False, 'message': 'Dados de agendamento ausentes ou inválidos.'}, status=400)
        except Equipamento.DoesNotExist:
            # Se o equipamento não existir, retorne uma resposta JSON com erro 400 Bad Request
            return JsonResponse({'success': False, 'message': 'O equipamento selecionado não existe.'}, status=400)
    # Se o método não for POST, renderize a página de agendamento
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
            elif agendamento.reagendado:
                status_agendamentos[agendamento.id] = 'Reagendado'
            elif agendamento.data_emprestimo and not agendamento.data_devolucao:
                status_agendamentos[agendamento.id] = 'Emprestado'
            elif agendamento.data_devolucao:
                status_agendamentos[agendamento.id] = 'Devolvido'
            else:
                status_agendamentos[agendamento.id] = 'Agendado'

        return render(request, 'historico.html', {'agendamentos': agendamentos, 'status_agendamentos': status_agendamentos})
    else:
        return redirect('login')
   
@login_required
def meus_agendamentos(request):
    if request.user.is_authenticated:
        agendamentos = Agendamento.objects.filter(cliente_nome=request.user.username, cancelado=False)
        agora = timezone.now()
        for agendamento in agendamentos:
            if agendamento.data_emprestimo:
                if agendamento.devolvido:  # Verifica se o equipamento foi devolvido
                    agendamento.prazo_restante = None  # Define como None se o equipamento foi devolvido
                else:
                    agendamento.prazo_restante = agendamento.calcular_prazo_restante()
                # Define o atributo 'pode_reagendar' como False se o equipamento estiver emprestado
                agendamento.pode_reagendar = False
                # Define o atributo 'pode_cancelar' como False se o equipamento estiver emprestado
                agendamento.pode_cancelar = False
            else:
                agendamento.prazo_restante = None  # Define como None se não estiver emprestado
                # Define o atributo 'pode_reagendar' como True se o equipamento não estiver emprestado
                agendamento.pode_reagendar = True
                # Define o atributo 'pode_cancelar' como True se o equipamento não estiver emprestado
                agendamento.pode_cancelar = True

            # Verifica se o agendamento pode ser cancelado
            if agendamento.data_entrega_prevista:
                tempo_minimo_cancelamento = agendamento.data_entrega_prevista - timedelta(minutes=30)
                if agora >= tempo_minimo_cancelamento:
                    agendamento.pode_cancelar = False

            # Verifica se o agendamento pode ser reagendado
            if agendamento.data_entrega_prevista:
                tempo_minimo_reagendamento = agendamento.data_entrega_prevista - timedelta(minutes=30)
                if agora >= tempo_minimo_reagendamento:
                    agendamento.pode_reagendar = False

            # Ajustar o prazo restante de acordo com a quantidade de dias escolhida
            if agendamento.data_emprestimo:
                if agendamento.quantidade_dias > 0:
                    # Se a quantidade de dias for maior que zero, calcular o prazo restante com base nessa quantidade
                    agendamento.prazo_restante = agendamento.calcular_prazo_restante()

        context = {'agendamentos': agendamentos}
        return render(request, 'meus_agendamentos.html', context)
    else:
        return redirect('login')

def visualizar_equipamentos(request):
    equipamentos = Equipamento.objects.all()
    return render(request, 'listar_equipamentos.html', {'equipamentos': equipamentos})
     
@transaction.atomic
def reagendar_agendamento(request, agendamento_id):
    agendamento = get_object_or_404(Agendamento, pk=agendamento_id)

    if request.method == 'POST':
        data = json.loads(request.body.decode('utf-8'))  # Decodifica o JSON enviado no corpo da requisição
        nova_data = data.get('nova_data')
        nova_hora = data.get('nova_hora')

        if nova_data and nova_hora:
            try:
                # Verifique se o agendamento pode ser reagendado
                agora = timezone.now()
                data_hora_agendamento = datetime.combine(agendamento.data, agendamento.hora)
                data_hora_agendamento = timezone.make_aware(data_hora_agendamento, timezone.get_current_timezone())
                tempo_minimo_reagendamento = data_hora_agendamento - timedelta(minutes=30)
                if agora >= tempo_minimo_reagendamento:
                    return JsonResponse({'erro': 'Não é possível reagendar este agendamento. O reagendamento não é permitido dentro de 30 minutos do início do agendamento.'}, status=400)

                # Atualize a data e hora do agendamento
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

        # Verificar se o agendamento já foi cancelado
        if agendamento.cancelado:
            return HttpResponseBadRequest("Este agendamento já foi cancelado.")

        # Verificar se o agendamento pode ser cancelado
        agora = timezone.now()
        data_hora_agendamento = datetime.combine(agendamento.data, agendamento.hora)
        data_hora_agendamento = timezone.make_aware(data_hora_agendamento, timezone.get_current_timezone())
        tempo_minimo_cancelamento = data_hora_agendamento - timedelta(minutes=30)
        if agora >= tempo_minimo_cancelamento:
            # Se já passou do tempo mínimo de cancelamento, retorne uma mensagem de erro
            return HttpResponseBadRequest("Não é possível cancelar este agendamento. O cancelamento não é permitido dentro de 30 minutos do início do agendamento.")

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
        fabricante = request.POST.get('fabricante')
        data_aquisicao = request.POST.get('data_aquisicao')
        quantidade_disponivel = request.POST.get('quantidade_disponivel')

        # Verificar se os campos obrigatórios estão preenchidos
        if not nome_equipamento:
            # O campo nome_equipamento não foi preenchido.
            messages.error(request, 'O campo nome é obrigatório.')
            return render(request, 'cadastrar_equipamento.html')

        try:
            # Criar um novo equipamento
            equipamento = Equipamento(nome=nome_equipamento, descricao=descricao, fabricante=fabricante, data_aquisicao=data_aquisicao, quantidade_disponivel=quantidade_disponivel)
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
    
@staff_member_required
def buscar_agendamentos(request):
    if request.method == 'POST':
        cliente_nome = request.POST.get('cliente_nome', None)
        if cliente_nome:
            # Buscar os agendamentos de todos os clientes pelo nome
            agendamentos = Agendamento.objects.filter(cliente_nome__icontains=cliente_nome, cancelado=False, devolvido=False)
            return render(request, 'buscar_agendamentos.html', {'agendamentos': agendamentos})
    else:
        # Se o método não for POST, exibir a página de busca vazia
        return render(request, 'buscar_agendamentos.html')

@staff_member_required
def devolucao_equipamento(request, agendamento_id):
    try:
        # Obter o agendamento pelo ID
        agendamento = get_object_or_404(Agendamento, pk=agendamento_id)

        # Verificar se o agendamento já foi cancelado
        if agendamento.cancelado:
            return HttpResponseBadRequest("Este agendamento já foi cancelado.")

        # Marcar o agendamento como devolvido
        agendamento.devolvido = True
        agendamento.save()  # Salvar o agendamento para atualizar o campo devolvido

        # Atualizar o status do agendamento para "Devolvido"
        agendamento.situacao = 'Devolvido'
        agendamento.save()  # Salvar o agendamento para atualizar o status

        # Atualizar o status do equipamento para disponível e incrementar o número de equipamentos disponíveis
        with transaction.atomic():
            equipamento = agendamento.equipamento
            equipamento.disponivel = True
            equipamento.save()

            # Incrementar o número de equipamentos disponíveis
            Equipamento.objects.filter(id=equipamento.id).update(quantidade_disponivel=F('quantidade_disponivel') + 1)

        # Redirecionar para o painel administrativo ou para onde desejar
        return redirect('administrador')  # Altere 'admin_dashboard' para o nome da sua view de painel administrativo
    except Agendamento.DoesNotExist:
        raise Http404("O agendamento não foi encontrado.")
    
@login_required
def marcar_como_emprestado(request):
    if not request.user.is_superuser:
        return redirect('login')  # Redirecionar para a página de login se não for um superusuário

    agendamentos = Agendamento.objects.filter(cancelado=False, data_emprestimo__isnull=True)
    
    if request.method == 'POST':
        agendamento_ids = request.POST.getlist('agendamento')
        for agendamento_id in agendamento_ids:
            agendamento = Agendamento.objects.get(pk=agendamento_id)
            agendamento.situacao = 'Emprestado'
            agendamento.data_emprestimo = timezone.now()
            agendamento.emprestado = True
            agendamento.save()

            # Decrementar o estoque do equipamento associado ao agendamento
            agendamento.equipamento.quantidade_disponivel -= 1
            agendamento.equipamento.save()

        return redirect('emprestimo_sucesso', agendamento_id=agendamento.id)
  # Redirecione para a página desejada após marcar os agendamentos como emprestados

    context = {'agendamentos': agendamentos}
    return render(request, 'marcar_como_emprestado.html', context)
    
def emprestimo_sucesso(request, agendamento_id):
    # Obter o objeto Agendamento usando o ID recebido
    agendamento = Agendamento.objects.get(pk=agendamento_id)

    context = {'agendamento': agendamento}
    return render(request, 'emprestimo_sucesso.html', context)
     
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

    
#################  -------  ---------  ###########################

@staff_member_required
def historico_agendamentos(request):
    agendamentos = Agendamento.objects.all()
    return render(request, 'historico_agendamentos.html', {'agendamentos': agendamentos})
    
def obter_dados_equipamento(request):
    equipamento_id = request.GET.get('equipamento_id')
    equipamento = Equipamento.objects.get(pk=equipamento_id)
    data = {
        'id': equipamento.id,
        'nome': equipamento.nome,
        'descricao': equipamento.descricao,
        'fabricante': equipamento.fabricante,
        'data_aquisicao': equipamento.data_aquisicao,
        'quantidade_disponivel': equipamento.quantidade_disponivel
    }
    return JsonResponse(data)
    
