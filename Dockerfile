# Use a imagem base do Python 3.12.2
FROM python:3.12.2

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie todo o projeto para o contêiner
COPY . /app

# Instale as dependências do sistema
RUN pip install --no-cache-dir -r requirements.txt

# Exponha a porta em que o servidor Django será executado
EXPOSE 8000

# Defina as variáveis de ambiente necessárias
ENV DJANGO_SETTINGS_MODULE=tcc_django.settings
ENV PYTHONUNBUFFERED=1
ENV MYSQL_HOST=localhost
ENV MYSQL_PORT=3306
ENV MYSQL_USER=django
ENV MYSQL_PASSWORD=@siosa
ENV MYSQL_DATABASE=bd_agendamentos


# Execute o comando para iniciar o servidor Django
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "tcc_django.wsgi:application"]
