# imports
import datetime
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from .models import Agendamento, Equipamento
from .forms import EquipamentoForm
from django.http import HttpResponse, HttpResponseForbidden
from django.contrib.auth.models import User


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
            return render(request, 'agendamentos/home.html')
        else:
            messages.error(request, 'Credenciais inválidas')  # Use o sistema de mensagens do Django para exibir a mensagem de erro
            return render(request, 'agendamentos/login.html')

    return render(request, 'agendamentos/login.html')
    
def home(request):   
    return render(request, 'agendamentos\home.html')    

def cliente(request):
    return render(request, 'agendamentos\cliente.html')
    
def agendar_equipamento(request):
    equipamentos = Equipamento.objects.all()
    context = {'equipamentos': equipamentos}
    return render(request, 'agendamentos/agendar_equipamento.html', context)
    
def historico(request):
    return render(request, 'agendamentos\historico.html')
    
    
def administrador(request):
    return render(request, 'agendamentos\\administrador.html')
    
    
    
    
    
    ### Está função foi desativada por um erro que eu ainda não descobri qual é
    
"""def administrador(request):
    if request.method == 'POST':
        # Obter o ID do equipamento a ser excluído
        equipamento_id = request.POST['equipamento_id']

        # Excluir o equipamento
        equipamento = get_object_or_404(Equipamento, pk=equipamento_id)
        equipamento.delete()

        # Redirecionar o usuário para a página do administrador
        return redirect('administrador')

    else:
        # Puxar todos os equipamentos do banco de dados
        equipamentos = Equipamento.objects.all()

        # Filtrar os equipamentos que têm o nome "Computador"
        equipamentos = equipamentos.filter(nome_equipamento="Computador")

        return render(request, 'agendamentos/administrador.html', {'equipamentos': equipamentos})"""

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
        # Obter os dados do formulário
        nome_equipamento = request.POST['nome_equipamento']
        descricao = request.POST['descricao']

        # Validar os dados do formulário

        # Salvar as alterações
        equipamento.nome_equipamento = nome_equipamento
        equipamento.descricao = descricao
        equipamento.save()

        # Redirecionar o usuário para a página de gerenciamento de equipamentos
        return redirect('administrador')

    else:
        # Renderizar o formulário de edição do equipamento
        return render(request, 'agendamentos/editar_equipamento.html', {'equipamento': equipamento})
    
#def excluir_equipamento(request, equipamento_id):
    equipamento = get_object_or_404(Equipamento, pk=equipamento_id)
    equipamento.delete()
    return redirect('excluir_equipamento')  # Redireciona de volta para a página de exclusão
    
    
######################################------------MODIFICAÇÕES---------------###################################################

#def visualizar_equipamentos(request):
    equipamentos = Equipamento.objects.all()
    return render(request, 'agendamentos/visualizar_equipamentos.html', {'equipamentos': equipamentos})

def cadastrar_equipamento(request):
    if request.method == 'POST':
        # Obter os dados do formulário
        nome_equipamento = request.POST.get('nome')  # Ajuste o nome do campo conforme o formulário HTML
        descricao = request.POST.get('descricao')  # Nome do campo no formulário HTML

        # Verificar se os campos obrigatórios estão preenchidos
        if not nome_equipamento:
            # O campo nome_equipamento não foi preenchido.
            messages.error(request, 'O campo nome é obrigatório.')
            return render(request, 'agendamentos/cadastrar_equipamento.html')

        # Validar o campo nome_equipamento
        if not nome_equipamento.isalnum():
            # O campo nome_equipamento não contém apenas letras e números.
            messages.error(request, 'O campo nome deve conter apenas letras e números.')
            return render(request, 'agendamentos/cadastrar_equipamento.html')

        try:
            # Criar um novo equipamento
            equipamento = Equipamento(nome_equipamento=nome_equipamento, descricao=descricao)
            equipamento.save()

            # Define a mensagem de sucesso
            mensagem = 'O equipamento foi salvo com sucesso.'

            # Redireciona o usuário para a página de listagem de equipamentos com a mensagem
            return redirect('visualizar_equipamentos', mensagem=mensagem)
        except Exception as e:
            # Se ocorrer um erro ao salvar, exibe uma mensagem de erro
            messages.error(request, f'O equipamento não foi salvo. Erro: {e}')
            return render(request, 'agendamentos/cadastrar_equipamento.html')

    else:
        return render(request, 'agendamentos/cadastrar_equipamento.html')

def excluir_equipamento(request, equipamento_id):
    equipamento = get_object_or_404(Equipamento, pk=equipamento_id)

    if request.method == 'POST':
        equipamento.delete()
        return redirect('administrador')

    else:
        return render(request, 'agendamentos/excluir_equipamento.html', {'equipamento': equipamento})

def gerenciar_equipamentos(request):
    equipamentos = Equipamento.objects.all()  # Obtém todos os equipamentos do banco de dados

    # Renderiza a página 'gerenciar_equipamentos.html' e passa os equipamentos para o contexto do template
    return render(request, 'agendamentos/gerenciar_equipamentos.html', {'equipamentos': equipamentos})

def excluir_equipamento(request, equipamento_id):
    equipamento = get_object_or_404(Equipamento, pk=equipamento_id)
    equipamento.delete()
    return redirect('gerenciar_equipamentos')

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
    
    