from multiprocessing import context
from telnetlib import LOGOUT
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from .models import Agendamento, Equipamento
from .forms import AgendamentoForm, EquipamentoForm
from django.http import HttpResponse, HttpResponseForbidden, JsonResponse
from django.contrib.auth.models import User
from django.urls import reverse_lazy
from django.contrib.auth.forms import UserCreationForm
from .forms import UserRegistrationForm
from .models import User
from agendamentos.models import User
from agendamentos.forms import UserRegistrationForm
from dateutil.parser import parse
from django.utils import timezone
from datetime import datetime
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login
from django.contrib.auth import logout
from django.shortcuts import redirect
import sys
from django.http import Http404
from django.core.exceptions import PermissionDenied


######################################
# importações para o módulo role permissions, que trata do tipo de permissões dos usuários
from rolepermissions.permissions import revoke_permission, grant_permission
from rolepermissions.roles import assign_role, get_user_roles
from rolepermissions.decorators import has_role_decorator, has_permission_decorator
from django.contrib.auth.models import Group

#######################################




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
def agendar_equipamento(request):
    if request.method == 'POST':
        equipamento_id = request.POST['equipamento']
        data = request.POST['data']
        hora = request.POST['hora']

        # Converta a data e hora em objetos datetime e torne-os conscientes do fuso horário
        data_hora = datetime.strptime(f"{data} {hora}", "%Y-%m-%d %H:%M")
        data_hora_consciente = timezone.make_aware(data_hora)

        # Verifique se o equipamento está disponível para agendamento para o cliente atual
        agendamentos = Agendamento.objects.filter(
            equipamento_id=equipamento_id,
            cliente_nome=request.user.username,  # Verifique o agendamento apenas para o cliente atual
            data__year=data_hora_consciente.year,
            data__month=data_hora_consciente.month,
            data__day=data_hora_consciente.day,
            hora__hour=data_hora_consciente.hour,
            hora__minute=data_hora_consciente.minute
        )

        if agendamentos.exists():
            # Se houver agendamento para o equipamento na mesma data e hora para o cliente atual, retorne uma resposta JSON indicando o erro
            return JsonResponse({'success': False, 'message': 'Este equipamento já está agendado para você nesta data e hora. Por favor, escolha outra data ou hora.'})
        else:
            # Se o equipamento estiver disponível, crie o agendamento
            agendamento = Agendamento.objects.create(
                equipamento_id=equipamento_id,
                cliente_nome=request.user.username,  # Use o nome do cliente armazenado na sessão
                data=data_hora_consciente.date(),
                hora=data_hora_consciente.time()
            )

            # Retorne uma resposta JSON indicando que o agendamento foi bem-sucedido
            return JsonResponse({'success': True, 'message': 'Agendamento realizado com sucesso!'})

    equipamentos = Equipamento.objects.all()
    context = {'equipamentos': equipamentos}
    return render(request, 'agendar_equipamento.html', context)

def historico(request):
    # Verificar se o usuário está logado e se sim, obter os agendamentos dele
    if request.user.is_authenticated:
        # Obter os agendamentos do cliente atual
        agendamentos = Agendamento.objects.filter(cliente_nome=request.user.username)
        # Passar os agendamentos para o template como parte do contexto
        return render(request, 'historico.html', {'agendamentos': agendamentos})
    else:
        # Caso o usuário não esteja logado, redirecionar para a página de login ou fazer qualquer outra coisa que desejar
        return redirect('login')  # Ou renderizar outro template informando que o usuário precisa estar logado
    
def meus_agendamentos(request):
    # Verificar se o usuário está logado e, em caso afirmativo, obter seus agendamentos
    if request.user.is_authenticated:
        # Obter os agendamentos do cliente atual, excluindo os agendamentos cancelados
        agendamentos = Agendamento.objects.filter(cliente_nome=request.user.username, cancelado=False)
        # Passar os agendamentos para o template como parte do contexto
        return render(request, 'meus_agendamentos.html', {'agendamentos': agendamentos})
    else:
        # Caso o usuário não esteja logado, redirecionar para a página de login ou fazer qualquer outra coisa que desejar
        return redirect('login')  # Ou renderizar outro template informando que o usuário precisa estar logado
    
def visualizar_equipamentos(request):
    equipamentos = Equipamento.objects.all().order_by('nome')  # Ordenar os equipamentos pelo nome
    return render(request, 'visualizar_equipamentos.html', {'equipamentos': equipamentos})

def listar_equipamentos(request):
    equipamentos = Equipamento.objects.all()
    return render(request, 'listar_equipamentos.html', {'equipamentos': equipamentos})    
    
def administrador(request):

    return render(request, 'administrador.html')
     
def adicionar_agendamento(request):
    if request.method == 'POST':
        equipamento_id = request.POST['equipamento']
        data = request.POST['data']
        hora = request.POST['hora']
        
        # Conversão da string de data e hora para objetos do tipo datetime
        data_agendamento = datetime.strptime(data, '%Y-%m-%d')
        hora_agendamento = datetime.strptime(hora, '%H:%M').time()
        
        # Verificação de disponibilidade do equipamento na data e hora especificadas
        equipamento = Equipamento.objects.get(pk=equipamento_id)
        agendamentos_conflitantes = Agendamento.objects.filter(
            equipamento=equipamento,
            data=data_agendamento,
            hora=hora_agendamento
        )
        
        if agendamentos_conflitantes.exists():
            # Se existir um agendamento conflitante, retorne uma mensagem de erro
            messages.error(request, 'Já existe um agendamento para este equipamento nesta data e hora.')
            return redirect('falha_agendamento.html')  # Redirecione para a página de erro ou para o formulário de agendamento
        else:
            # Se não houver conflito, crie o novo agendamento
            novo_agendamento = Agendamento(
                equipamento=equipamento,
                data=data_agendamento,
                hora=hora_agendamento
            )
            novo_agendamento.save()
            messages.success(request, 'Agendamento realizado com sucesso.')
            return redirect('sucesso_agendamento.html')  # Redirecione para a página de sucesso ou para a lista de agendamentos
    else:
        # Se a requisição não for POST, retorne o formulário vazio ou a página inicial
        return render(request, 'agendar_equipamento.html')
        
def editar_equipamento(request, equipamento_id):
    equipamento = get_object_or_404(Equipamento, pk=equipamento_id)

    if request.method == 'POST':
        # Instanciar o formulário com os dados submetidos e o equipamento existente
        formulario = EditarEquipamentoForm(request.POST, instance=equipamento)
        if formulario.is_valid():
            # Salvar os dados do formulário no objeto equipamento
            formulario.save()
            # Retornar uma resposta de sucesso ou redirecionar para algum lugar
            return HttpResponse("Equipamento editado com sucesso")
        # Se o formulário não for válido, renderizar o formulário novamente com os erros
    else:
        # Se o método for GET, renderizar o formulário de edição com os dados do equipamento
        formulario = EditarEquipamentoForm(instance=equipamento)
    
    # Renderizar o formulário de edição
    return render(request, 'editar_equipamento.html', {'formulario': formulario})
    
def excluir_equipamento(request, equipamento_id):
    equipamento = Equipamento.objects.get(pk=equipamento_id)
    equipamento.delete()
    return redirect('visualizar_equipamentos')
       
def cadastrar_equipamento(request):
    if request.method == 'POST':
        # Obter os dados do formulário
        nome_equipamento = request.POST.get('nome_equipamento')
        descricao = request.POST.get('descricao')

        # Verificar se os campos obrigatórios estão preenchidos
        if not nome_equipamento:
            # O campo nome_equipamento não foi preenchido.
            messages.error(request, 'O campo nome é obrigatório.')
            return render(request, 'cadastrar_equipamento.html')

        try:
            # Criar um novo equipamento
            equipamento = Equipamento(nome=nome_equipamento, descricao=descricao)
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

def excluir_equipamento(request, equipamento_id):
    equipamento = get_object_or_404(Equipamento, pk=equipamento_id)

    if request.method == 'POST':
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
            return redirect('excluir_equipamento', equipamento_id=equipamento_id)
    else:
        return render(request, 'excluir_equipamento.html', {'equipamento': equipamento})

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
    
def reagendar_agendamento(request, agendamento_id):
    # Obtém o agendamento pelo ID
    agendamento = get_object_or_404(Agendamento, pk=agendamento_id)

    if request.method == 'POST':
        nova_data_str = request.POST.get('nova_data')
        nova_hora_str = request.POST.get('nova_hora')

        # Verifica se nova_data_str e nova_hora_str não estão vazios
        if nova_data_str and nova_hora_str:
            try:
                nova_data = datetime.strptime(nova_data_str, '%Y-%m-%d').date()
                nova_hora = datetime.strptime(nova_hora_str, '%H:%M').time()

                # Atualiza os campos do agendamento
                agendamento.data = nova_data
                agendamento.hora = nova_hora
                agendamento.save()

                # Redireciona para a página de sucesso ou qualquer outra página desejada
                messages.success(request, 'Agendamento reagendado com sucesso!')
                return redirect('meus_agendamentos')
            except ValueError:
                # Trate o caso em que a conversão da data ou hora falha
                # Por exemplo, retorne uma mensagem de erro para o usuário
                messages.error(request, 'Data ou hora inválida. Por favor, verifique e tente novamente.')
                return redirect('pagina_erro')
        else:
            # Trate o caso em que nova_data_str ou nova_hora_str está vazio
            # Por exemplo, retorne uma mensagem de erro para o usuário
            messages.error(request, 'Por favor, selecione uma nova data e hora.')
            return redirect('pagina_erro')
    else:
        # Trate o caso em que o método da requisição não é POST
        # Por exemplo, retorne uma mensagem de erro para o usuário
        messages.error(request, 'Método de requisição inválido.')
        return redirect('pagina_erro')

def cancelar_agendamento(request, agendamento_id):
    # Verificar se o usuário está autenticado
    if not request.user.is_authenticated:
        return redirect('login')  # Redirecionar para a página de login se não estiver autenticado

    try:
        # Obter o agendamento pelo ID
        agendamento = Agendamento.objects.get(pk=agendamento_id, cliente_nome=request.user)
        
        # Marcar o agendamento como cancelado
        agendamento.cancelado = True
        agendamento.save()
        
        # Redirecionar para a página de meus agendamentos ou para onde desejar
        return redirect('meus_agendamentos')
    except Agendamento.DoesNotExist:
        # Se o agendamento não for encontrado, levantar uma exceção Http404
        raise Http404("O agendamento não foi encontrado.")
        
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
    
#############

