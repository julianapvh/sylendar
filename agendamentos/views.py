# imports
from django.shortcuts import render


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


# views de agendamento
def index(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        #print(f"\n\nUsuário: {username}\nSenha: {password}\n\n")

        nome,cpf = login_sauron(username,password)

        #print(f"Login realizado com sucesso!\nNome: {nome}\nCPF: {cpf}\n\n")

        # Verifique se o usuário e a senha são "teste"
        if nome != "" and cpf != "" and nome != None and cpf != None:
            #return render(request, 'agendamentos\login.html',{f'error_message': f"Login realizado com sucesso!  Nome: {nome}  CPF: {cpf} "})
            return render(request, 'agendamentos\home.html')
        else:
            return render(request, 'agendamentos\login.html', {'error_message': 'Credenciais inválidas'})

    return render(request, 'agendamentos\login.html',{'error_message': 'Insira usuário e senha'})
    
def home(request):   
    return render(request, 'agendamentos\home.html')
    
    
    
def cliente(request):
    return render(request, 'agendamentos\cliente.html')
    
def agendar_equipamento(request):
    return render(request, 'agendamentos\agendar_equipamento.html')
    
def historico(request):
    return render(request, 'agendamentos\historico.html')
    
def administrador(request):
    return render(request, 'agendamentos/administrador.html')
    
def cadastrar_equipamentos(request):
    return render(request, 'agendamentos\cadastrar_equipamento.html')