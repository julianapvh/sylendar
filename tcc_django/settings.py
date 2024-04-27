"""
Django settings for tcc_django project.

Generated by 'django-admin startproject' using Django 4.2.3.

For more information on this file, see
https://docs.djangoproject.com/en/4.2/topics/settings/

For the full list of settings and their values, see

https://docs.djangoproject.com/en/4.2/ref/settings/
"""

import os
from dotenv import load_dotenv
from pathlib import Path



# Carrega as variáveis de ambiente do arquivo .env
load_dotenv()

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent
PROJECT_DIR = os.path.dirname(os.path.abspath(__file__))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.environ.get('DJANGO_SECRET_KEY',
                            'cg#p$g+j9tax!#a3cup@1$8obt2_+&k3q+pmu)5%asj6yjpkag')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = os.environ.get('DJANGO_DEBUG', '') != 'True'

ALLOWED_HOSTS = ['*']

CSRF_TRUSTED_ORIGINS = [
    'https://sistemadeagendamentos2-23lcg0kt.b4a.run','https://agendamentos.azurewebsites.net',
    # Add other trusted origins here if needed
]

# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'agendamentos',
    'tcc_django',
    'django_extensions',
    'django_fastdev',
    
    # apps de terceiros
    
    'rolepermissions',
    
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    #'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'tcc_django.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(BASE_DIR, 'agendamentos', '%s/templates' % PROJECT_DIR)
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'tcc_django.wsgi.application'

# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases




DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': os.getenv('DB_NAME'),
        'USER': os.getenv('DB_USER'),
        'PASSWORD': os.getenv('DB_PASSWORD'),
        'HOST': os.getenv('DB_HOST'),
        'PORT': os.getenv('DB_PORT'),
        'OPTIONS': {
            'ssl_ca': 'https://github.com/julianapvh/sistema_de_agendamentos/blob/main/ssl/DigiCertGlobalRootCA.crt.pem',
        },
    },
      # banco SQLITE3 para testes off-line
    #'sqlite3': {
        #'ENGINE': 'django.db.backends.sqlite3',
        #'NAME': BASE_DIR / 'db.sqlite3',
}
        
  
        
        




# Password validation
# https://docs.djangoproject.com/en/4.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Internationalization
# https://docs.djangoproject.com/en/4.2/topics/i18n/

LANGUAGE_CODE = 'pt-br'

TIME_ZONE = 'America/Porto_Velho'

USE_I18N = True

USE_L10N = True

USE_TZ = True

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/2.1/howto/static-files/

# No seu arquivo de configurações settings.py


# O URL para usar ao se referir aos arquivos estáticos (de onde eles serão servidos).
STATIC_URL = '/agendamentos/static/'
# O caminho absoluto para o diretório onde collectstatic coletará os arquivos estáticos para implantação.
STATIC_ROOT = os.path.join(BASE_DIR, '/agendamentos/staticfiles')



# Adicione o diretório 'agendamentos/static' aos diretórios de arquivos estáticos
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'agendamentos', 'staticfiles'),
]



# Default primary key field type
# https://docs.djangoproject.com/en/4.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

ROLEPERMISSIONS_MODULE = "agendamentos.roles"

AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.ModelBackend',
    # Outros backends de autenticação, se necessário
]

LOGIN_REDIRECT_URL = 'home'


# Configurações de envio do e-mail

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
EMAIL_HOST_USER = "agendamentossistema9@gmail.com"
EMAIL_HOST_PASSWORD = "s t l q q l k d s p v g p o g e"