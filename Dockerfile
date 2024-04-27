# Use a imagem base do Python 3.12.2
FROM python:3.12.3

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

# Execute o comando para coletar os arquivos estáticos
RUN python manage.py collectstatic --noinput

# Exponha a porta em que o servidor Django será executado
EXPOSE 8000

# Defina as variáveis de ambiente necessárias
ENV DJANGO_SETTINGS_MODULE=tcc_django.settings
ENV PYTHONUNBUFFERED=1

# Execute o comando para iniciar o servidor Django
CMD [ "gunicorn", "tcc_django.wsgi:application", "--bind", "0.0.0.0:8000" ]
