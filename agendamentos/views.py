from multiprocessing import context
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from .models import Agendamento, Equipamento
from .forms import AgendamentoForm, EquipamentoForm
from django.http import HttpResponse, HttpResponseForbidden
from django.contrib.auth.models import User
from django.urls import reverse_lazy
from django.contrib.auth.forms import UserCreationForm
from .forms import UserRegistrationForm
from .models import Usuario
# Importe o modelo Usuario
from agendamentos.models import Usuario
from agendamentos.forms import UserRegistrationForm
from dateutil.parser import parse
from django.utils import timezone
from datetime import datetime
from django.contrib.auth.decorators import login_required




# funções de apoio
def login_sauron(usuario,senha):
    from mechanize import Browser
    from bs4 import BeautifulSoup as bs
    from getpass import getpass
    from http.cookiejar import CookieJar

    usuario = str(usuario)
    senha = str(senha)

    #___---¨¨¨ Variáveis do login ¨¨¨---___
    link_de_acesso = "https://meuacesso.sistemas.ro.gov.br/"

    #___---¨¨¨ Sub-Funções do login ¨¨¨---___
    def valida_acesso_sauron(usuario,senha):
        # Faz acesso no sauron

        # Prepara o navegador
        cookies = CookieJar()  # Cria um repositório de cookies
        browser = Browser()    # Inicia um browser
        browser.set_cookiejar(cookies)   # Aponta para o repositório de cookies

        # Acessa o link que redireciona para a página inicial
        browser.open(link_de_acesso)

        # Faz login
        browser.select_form(nr=0)      # o formulário de login é o primeiro(nr=0)
        browser.form['Username'] = usuario  # O texto em form['texto'] é o nome do elemento web onde a informação será inserida
        browser.form['Password'] = senha
        browser.submit()  # envia os dados através do formulário de login

        
        # Tenta obter informações do acesso
        try:
            # Carrega os dados da página atual ("página clique para continuar") e confirma
            browser.select_form(nr=0) # O botão de confirmar é do tipo formulário, então uma opção foi dar submit vazio no primeiro form
            browser.submit()

            # A página carregada deve ser o login efetuado
            pagina_de_acesso = browser.response().read()

            # Passa os dados da página para o BeautifulSoup
            soup = bs(pagina_de_acesso, 'html.parser')

            #print(soup.decode())

            # Salva o resultado em texto, pesquisando classes como tag
            nome = str(soup.find(class_="user-block-name").get_text())
            cpf = str(soup.find(class_="user-block-role").get_text())

            return(nome,cpf)

            #print(f"Login realizado com sucesso!\nNome: {nome.title()}\nCPF: {cpf}\n\n")
            
            

        except Exception as ex:
            #print("Erro", f"Erro ao realizar o login: {ex}")
            #print("senha incorreta\n")
            return("","")


    #___---¨¨¨ Início da execução ¨¨¨---___
    return(valida_acesso_sauron(usuario, senha))

def login(request):
    return render(request, 'agendamentos\\login.html')
    
def register(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('login')  # Redireciona para a página de login após o registro bem-sucedido
        else:
            print(form.errors)  # Exibe os erros de validação no console para depuração
    else:
        form = UserRegistrationForm()
    return render(request, 'agendamentos/register.html', {'form': form})
    
def index(request):
    error_message = None
    instruction_message = None
    
    
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        #print(f"\n\nUsuário: {username}\nSenha: {password}\n\n")

        nome,cpf = login_sauron(username,password)

        #print(f"Login realizado com sucesso!\nNome: {nome}\nCPF: {cpf}\n\n")

        # Verifique se o usuário e a senha são "teste"
        if nome != "" and cpf != "" and nome is not None and cpf is not None:
            request.session['username'] = nome  # Salve o nome do usuário na sessão
            return render(request, 'agendamentos/administrador_home.html')
        else:
            messages.error(request, 'Credenciais inválidas')  # Use o sistema de mensagens do Django para exibir a mensagem de erro
            return render(request, 'agendamentos/login.html')

    return render(request, 'agendamentos/login.html')
    
def home(request):   
    return render(request, 'agendamentos\\home.html')    

def administrador_home(request):
    return render(request, 'agendamentos\\administrador_home.html')

def cliente_home(request):
    return render(request, 'agendamentos\\cliente_home.html')

def cliente(request):
    # Verificar se o usuário está logado e se sim, obter os agendamentos dele
    if 'username' in request.session:
        # Obter os agendamentos do cliente atual
        agendamentos = Agendamento.objects.filter(cliente_nome=request.session['username'])
        # Passar os agendamentos para o template como parte do contexto
        return render(request, 'agendamentos/cliente.html', {'agendamentos': agendamentos})
    else:
        # Caso o usuário não esteja logado, redirecionar para a página de login ou fazer qualquer outra coisa que desejar
        return redirect('login')  # Ou renderizar outro template informando que o usuário precisa estar logado

def agendar_equipamento(request):
    if request.method == 'POST':
        equipamento_id = request.POST['equipamento']
        data = request.POST['data']
        hora = request.POST['hora']

        # Verifique se 'username' está presente na sessão
        if 'username' not in request.session:
            # Se 'username' não estiver presente na sessão, redirecione para onde desejar
            return redirect('login')

        # Converta a data e hora em objetos datetime e torne-os conscientes do fuso horário
        data_hora = datetime.strptime(f"{data} {hora}", "%Y-%m-%d %H:%M")
        data_hora_consciente = timezone.make_aware(data_hora)

        # Verifique se o equipamento está disponível para agendamento para o cliente atual
        agendamentos = Agendamento.objects.filter(
            equipamento_id=equipamento_id,
            cliente_nome=request.session['username'],  # Verifique o agendamento apenas para o cliente atual
            data__year=data_hora_consciente.year,
            data__month=data_hora_consciente.month,
            data__day=data_hora_consciente.day,
            hora__hour=data_hora_consciente.hour,
            hora__minute=data_hora_consciente.minute
        )

        if agendamentos.exists():
            # Se houver agendamento para o equipamento na mesma data e hora para o cliente atual, exiba uma mensagem de erro
            error_message = 'Este equipamento já está agendado para você nesta data e hora. Por favor, escolha outra data ou hora.'
            equipamentos = Equipamento.objects.all()
            context = {'equipamentos': equipamentos, 'error_message': error_message}
            return render(request, 'agendamentos/agendar_equipamento.html', context)
        else:
            # Se o equipamento estiver disponível, crie o agendamento
            agendamento = Agendamento.objects.create(
                equipamento_id=equipamento_id,
                cliente_nome=request.session['username'],  # Use o nome do cliente armazenado na sessão
                data=data_hora_consciente.date(),
                hora=data_hora_consciente.time()
            )

            # Redirecione para a página de sucesso ou para onde desejar
            return redirect('cliente')

    equipamentos = Equipamento.objects.all()
    context = {'equipamentos': equipamentos}
    return render(request, 'agendamentos/agendar_equipamento.html', context)

def historico(request):
    return render(request, 'agendamentos\\historico.html')
    
def meus_agendamentos(request):
    # Verifique se 'username' está presente na sessão
    if 'username' not in request.session:
        # Se 'username' não estiver presente na sessão, redirecione para onde desejar
        return redirect('login')  # Substitua 'nome_da_pagina_de_login' pelo nome da sua página de login
    
    # Obtenha os agendamentos do cliente atual excluindo os agendamentos cancelados
    agendamentos = Agendamento.objects.filter(cliente_nome=request.session['username'], cancelado=False)
    
    # Renderize o template 'meus_agendamentos.html' e passe os agendamentos para ele
    return render(request, 'agendamentos/meus_agendamentos.html', {'agendamentos': agendamentos})
    
def visualizar_equipamentos(request):
    equipamentos = Equipamento.objects.all().order_by('nome')  # Ordenar os equipamentos pelo nome
    return render(request, 'agendamentos/visualizar_equipamentos.html', {'equipamentos': equipamentos})

def listar_equipamentos(request):
    equipamentos = Equipamento.objects.all()
    return render(request, 'agendamentos/listar_equipamentos.html', {'equipamentos': equipamentos})    
    
def administrador(request):

    return render(request, 'agendamentos\\administrador.html')
     
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
            return redirect('agendamentos/falha_agendamento.html')  # Redirecione para a página de erro ou para o formulário de agendamento
        else:
            # Se não houver conflito, crie o novo agendamento
            novo_agendamento = Agendamento(
                equipamento=equipamento,
                data=data_agendamento,
                hora=hora_agendamento
            )
            novo_agendamento.save()
            messages.success(request, 'Agendamento realizado com sucesso.')
            return redirect('agendamentos/sucesso_agendamento.html')  # Redirecione para a página de sucesso ou para a lista de agendamentos
    else:
        # Se a requisição não for POST, retorne o formulário vazio ou a página inicial
        return render(request, 'agendamentos/agendar_equipamento.html')
        
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
    return render(request, 'agendamentos/editar_equipamento.html', {'formulario': formulario})
    
def excluir_equipamento(request, equipamento_id):
    equipamento = Equipamento.objects.get(pk=equipamento_id)
    equipamento.delete()
    return redirect('visualizar_equipamentos')
    
    
######################################------------MODIFICAÇÕES---------------###################################################

#def visualizar_equipamentos(request):
    equipamentos = Equipamento.objects.all()
    return render(request, 'agendamentos/visualizar_equipamentos.html', {'equipamentos': equipamentos})

def cadastrar_equipamento(request):
    if request.method == 'POST':
        # Obter os dados do formulário
        nome_equipamento = request.POST.get('nome_equipamento')
        descricao = request.POST.get('descricao')

        # Verificar se os campos obrigatórios estão preenchidos
        if not nome_equipamento:
            # O campo nome_equipamento não foi preenchido.
            messages.error(request, 'O campo nome é obrigatório.')
            return render(request, 'agendamentos/cadastrar_equipamento.html')

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
            return render(request, 'agendamentos/cadastrar_equipamento.html')

    else:
        return render(request, 'agendamentos/cadastrar_equipamento.html')

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
        return render(request, 'agendamentos/excluir_equipamento.html', {'equipamento': equipamento})

def confirmar_exclusao_equipamento(request, equipamento_id):
    equipamento = get_object_or_404(Equipamento, pk=equipamento_id)
    equipamento.delete()
    return redirect('gerenciar_equipamentos')
    
def gerenciar_equipamentos(request):
    equipamentos = Equipamento.objects.all()  # Obtém todos os equipamentos do banco de dados

    # Renderiza a página 'gerenciar_equipamentos.html' e passa os equipamentos para o contexto do template
    return render(request, 'agendamentos/gerenciar_equipamentos.html', {'equipamentos': equipamentos})

def alterar_equipamento(request, equipamento_id):
    equipamento = get_object_or_404(Equipamento, pk=equipamento_id)
    if request.method == 'POST':
        form = EquipamentoForm(request.POST, instance=equipamento)
        if form.is_valid():
            form.save()
            return redirect('gerenciar_equipamentos')
    else:
        form = EquipamentoForm(instance=equipamento)
    return render(request, 'agendamentos/alterar_equipamento.html', {'form': form, 'equipamento': equipamento})
      
def user_list(request):
    users = Usuario.objects.all()
    return render(request, 'agendamentos\\user_list.html', {'users': users})
    
def reagendar_agendamento(request, agendamento_id):
    if request.method == 'POST':
        agendamento = Agendamento.objects.get(pk=agendamento_id)
        nova_data_str = request.POST.get('nova_data')
        nova_hora_str = request.POST.get('nova_hora')

        # Verifica se nova_data_str não está vazio
        if nova_data_str:
            nova_data = datetime.strptime(nova_data_str, '%Y-%m-%d').date()
            nova_hora = datetime.strptime(nova_hora_str, '%H:%M').time()
            
            # Atualiza os campos do agendamento
            agendamento.data = nova_data
            agendamento.hora = nova_hora
            agendamento.save()

            # Redireciona para a página de sucesso ou qualquer outra página desejada
            return redirect('sucesso_agendamento')
        else:
            # Trate o caso em que nova_data_str está vazio
            # Por exemplo, retorne uma mensagem de erro para o usuário
            messages.error(request, 'Por favor, selecione uma nova data.')
            return redirect('pagina_erro')
    else:
        # Trate o caso em que o método da requisição não é POST
        # Por exemplo, retorne uma mensagem de erro para o usuário
        messages.error(request, 'Método de requisição inválido.')
        return redirect('pagina_erro')


def cancelar_agendamento(request, agendamento_id):
    # Verificar se o usuário está logado
    if 'username' not in request.session:
        return redirect('login')  # Redirecionar para a página de login se não estiver logado
    
    # Lógica para cancelar o agendamento com base no ID do agendamento
    try:
        agendamento = Agendamento.objects.get(id=agendamento_id)
        # Lógica para cancelar o agendamento (por exemplo, marcar como cancelado no banco de dados)
        agendamento.cancelado = True
        agendamento.save()
        # Redirecionar de volta para a página de agendamentos após o cancelamento
        return redirect('meus_agendamentos')
    except Agendamento.DoesNotExist:
        # Se o agendamento não for encontrado, redirecionar para uma página de erro ou qualquer outra ação adequada
        return redirect('pagina_erro')  # Substitua 'pagina_de_erro' pelo nome da sua página de erro
        
def error_404_view(request, exception):
    return render(request, 'pagina_erro.html', {'heading': 'Erro 404', 'message': 'Página não encontrada'}, status=404)

def error_500_view(request):
    return render(request, 'pagina_erro.html', {'heading': 'Erro 500', 'message': 'Ocorreu um erro interno no servidor'}, status=500)
    
    
def pagina_erro(request):
    return render(request, 'agendamentos\\pagina_erro.html')