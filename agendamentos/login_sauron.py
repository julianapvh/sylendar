####### Bibliotecas importadas #######
from mechanize import Browser
from bs4 import BeautifulSoup as bs
from getpass import getpass
from http.cookiejar import CookieJar

#___---¨¨¨ FUNÇÕES PRINCIPAIS ¨¨¨---___
def login_setic():
    #___---¨¨¨ Variáveis do login ¨¨¨---___
    link_de_acesso = "https://meuacesso.sistemas.ro.gov.br/"
    

    #___---¨¨¨ Sub-Funções do login ¨¨¨---___
    def inserir_usuario_e_senha():
        # Retorna o usuário e senha
        print("\n\n")

        usuario = str(input("Informe o usuário: "))
        senha = str(getpass(prompt='Digite a Senha:  ', stream=None))
        
        return usuario,senha

    def valida_acesso_sauron(usuario,senha):
        #Faz acesso no sauron

        # Prepara o navegador 
        cookies = CookieJar()  # Cria um repositório de cookies
        browser = Browser()    # Inicia um browser
        browser.set_cookiejar(cookies)   # Aponta para o repositório de cookies


        # Acessa o link que redireciona para a página inicial
        browser.open(link_de_acesso)
        #pagina_inicial = browser.response().read()
        #print(pagina_inicial.decode())

        
        # Faz login
        browser.select_form(nr=0)      # o formulário de login é o primeiro(nr=0)
        browser.form['Username'] = usuario  # O texto em form['texto'] é o nome do elemento web onde a informação será inserida
        browser.form['Password'] = senha 
        browser.submit()  # envia os dados através do formulário de login
        

        # Tenta obter informações do acesso
        try:
            # Carrega os dados da página atual("página clique para continuar") e confirma
            browser.select_form(nr=0) # O botão de confirmar é do tipo formulário, então uma opção foi dar submit vazio no primeiro form
            browser.submit()
            
            # A pagina carregada deve ser o login efetuado
            pagina_de_acesso = browser.response().read()

            # passa os dados da página para o BeautifulSoup
            soup = bs(pagina_de_acesso,'html.parser')

            #salva o resultado em texto, pesquisando classes como tag
            nome = str(soup.find(class_="user-block-name").get_text())
            cpf = str(soup.find(class_="user-block-role").get_text())

            #print(f"\n__--'' DADOS VALIDADOS ''--__\nNome: {nome.title()}\nCPF: {cpf}\n")

            # retorna Infomações do acesso
            return nome,cpf
        
        except Exception as ex:
            # retorna o erro
            return str(ex),""
            #return str(ex,f"{usuario};{senha}")
                
    def controlador_de_login():
        # Solicita usuário e senha
        usuario, senha = inserir_usuario_e_senha()

        # Salva o retorno da da função "valida_acesso_sauron"
        nome,cpf = valida_acesso_sauron(usuario,senha)

        # Trata o erro de tempo de resposta
        if str(nome) == "HTTP Error 504: Gateway Time-out":
                print("O SAURON está muito lento e não repondeu a tempo -_-\nTentando acessar novamente...\n")
                controlador_de_login()

        # Trata o erro de formulário preenchido incorreto
        elif str(nome) == "'NoneType' object has no attribute 'get_text'":
            print("Usuário ou senha incorreta, tente novamente!")
            controlador_de_login()

        # Trata qualquer outro erro que ocorrer
        elif str(cpf) == "":
            print("Erro ",str(nome))
        
        # Caso o acesso tenha sido realizado corretamente, exibe o nome completo e CPF do usuário
        else:
            print(f"\n__--'' DADOS VALIDADOS ''--__\nNome: {nome.title()}\nCPF: {cpf}\n")
            #return nome,cpf


    #___---¨¨¨ Início da execução ¨¨¨---___
    controlador_de_login()

    
#¨¨¨---___     EXECUÇÃO      ___---¨¨¨ 
login_setic()