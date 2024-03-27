# Use a imagem base do Python 3.12.2
FROM python:3.12.2-slim

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie os arquivos necessários para o contêiner
COPY . .

# Instale as dependências do sistema
RUN pip install --no-cache-dir -r requirements.txt

# Exponha a porta em que o servidor Django será executado
EXPOSE 8000

# Defina as variáveis de ambiente necessárias
ENV DJANGO_SETTINGS_MODULE=tcc_django.settings
ENV PYTHONUNBUFFERED=1

# Execute o comando para iniciar o servidor Django
CMD ["gunicorn", "--bind", "127.0.0.1:8000", "tcc_django.wsgi:application"]
