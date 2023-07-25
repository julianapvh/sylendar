from django.shortcuts import render
from django.http import HttpResponse

def login_setic(request):
    if request.method == 'POST':
        # Aqui você pode processar o formulário de login
        # Por exemplo, obter os dados enviados pelo formulário
        username = request.POST.get('username')
        password = request.POST.get('password')

        # Faça aqui a validação do usuário e senha (pode ser com o sauron_login)

        # Exemplo de validação simples (apenas para fins didáticos)
        if username == 'usuario' and password == 'senha':
            # Login bem-sucedido, redirecionar para a página de sucesso ou outra view
            return HttpResponse("Login bem-sucedido!")
        else:
            # Login falhou, retornar mensagem de erro ou redirecionar para página de login novamente
            return HttpResponse("Usuário ou senha inválidos!")

    else:
        # Se o método HTTP for GET, exibir o formulário de login
        return render(request, 'login_setic.html')
