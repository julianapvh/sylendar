from django.contrib.auth.models import Group
from django.db import models
from django.contrib.auth.models import AbstractUser, AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.utils import timezone
from django.contrib.auth.models import Permission

class Equipamento(models.Model):
    nome = models.CharField(max_length=100)
    descricao = models.CharField(max_length=100)
    fabricante = models.CharField(max_length=50)
    data_aquisicao = models.DateField(default=timezone.now)


class Usuario(AbstractUser):
    nome = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    senha = models.CharField(max_length=128)
    telefone = models.CharField(max_length=15)
    endereco = models.CharField(max_length=200)
    data_nascimento = models.DateField()

    def __str__(self):
        return self.nome

class Agendamento(models.Model):
    cliente_nome = models.CharField(max_length=100)
    cliente_cpf = models.CharField(max_length=11, default="00000000000")
    equipamento = models.ForeignKey(Equipamento, on_delete=models.CASCADE)  # Foreign key to Equipamento
    data = models.DateTimeField(default=timezone.now)
    hora = models.TimeField()

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self.create_user(email, password, **extra_fields)

class CustomUser(AbstractUser):
    # Your other fields go here

    # Update the groups field
    groups = models.ManyToManyField(
        Group,
        blank=True,
        related_name='customuser_set',  # Use a different name for the reverse relation
    )

    # Update the user_permissions field
    user_permissions = models.ManyToManyField(
        Permission,
        blank=True,
        related_name='customuser_set',  # Use a different name for the reverse relation
    )





######################################------------MODIFICAÇÕES---------------###################################################
