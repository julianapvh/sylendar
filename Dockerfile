# Use a imagem base do Python 3.12.3
FROM python:3.12.3

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Instale dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copie o arquivo de requisitos e instale as dependências
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copie todo o conteúdo do diretório atual para o diretório de trabalho
COPY . .

# Execute o comando para coletar os arquivos estáticos
RUN python manage.py collectstatic --noinput

# Exponha a porta em que o servidor Django será executado
EXPOSE 8000

# Defina as variáveis de ambiente necessárias
ENV DJANGO_SETTINGS_MODULE=tcc_django.settings
ENV PYTHONUNBUFFERED=1

# Execute o comando para iniciar o servidor Django
CMD ["gunicorn", "tcc_django.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3", "--threads", "2"]
