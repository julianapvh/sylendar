from django.contrib.auth.models import AbstractUser, Group, Permission, BaseUserManager
from django.db import models
from django.utils import timezone
from datetime import datetime, timedelta
from workdays import workday


class CustomUserManager(BaseUserManager):
    def create_user(self, username, password=None, **extra_fields):
        if not username:
            raise ValueError('O campo Nome de usuário deve ser definido')
        user = self.model(username=username, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_admin', True)  # Add this line to set is_admin=True for superuser

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superusuário deve ter is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superusuário deve ter is_superuser=True.')

        return self.create_user(username, password, **extra_fields)

class User(AbstractUser):
    nome_completo = models.CharField(max_length=100)
    telefone = models.CharField(max_length=15)
    is_admin = models.BooleanField(default=False)  # Add this field to identify admin users
    
    
    groups = models.ManyToManyField(Group, related_name='custom_user_groups')
    user_permissions = models.ManyToManyField(Permission, related_name='custom_user_permissions')
    
    objects = CustomUserManager()

    def __str__(self):
        return self.nome_completo if self.nome_completo else self.username

        

class Equipamento(models.Model):
    STATUS_CHOICES = (
        ('disponivel', 'Disponível'),
        ('agendado', 'Agendado'),
        ('cancelado', 'Cancelado'),
    )

    nome = models.CharField(max_length=100)
    descricao = models.CharField(max_length=100)
    fabricante = models.CharField(max_length=50)
    data_aquisicao = models.DateField(default=timezone.now)
    quantidade_disponivel = models.IntegerField(default=0)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='disponivel')
    usuarios = models.ManyToManyField(User, related_name='equipamentos', blank=True)

    def __str__(self):
        return self.nome


'''class Agendamento(models.Model):
    cliente_nome = models.CharField(max_length=100)
    cliente_cpf = models.CharField(max_length=11, default="00000000000")
    equipamento = models.ForeignKey(Equipamento, on_delete=models.CASCADE)  
    data = models.DateTimeField(default=timezone.now)
    hora = models.TimeField()
    cancelado = models.BooleanField(default=False)  # Campo para indicar se o agendamento foi cancelado
    reagendado = models.BooleanField(default=False)

    def status_equipamento(self):
        return self.equipamento.status  # Retorna o status do equipamento associado ao agendamento

    def __str__(self):
        return f"Agendamento para {self.cliente_nome} em {self.equipamento.nome}"'''
        
        

class Agendamento(models.Model):
    cliente_nome = models.CharField(max_length=100)
    cliente_cpf = models.CharField(max_length=11, default="00000000000")
    equipamento = models.ForeignKey(Equipamento, on_delete=models.CASCADE)  
    data = models.DateField(default=timezone.now)
    hora = models.TimeField(default=timezone.now)
    tipo_servico = models.CharField(max_length=100)
    cancelado = models.BooleanField(default=False)
    reagendado = models.BooleanField(default=False)
    data_entrega_prevista = models.DateTimeField(default=None, null=True, blank=True)

    def status_equipamento(self):
        return self.equipamento.status

    def pode_cancelar(self):
        if not self.cancelado:
            agora = timezone.now()
            # Combine the date and time and make them timezone-aware
            data_hora_agendamento = timezone.make_aware(
                timezone.datetime.combine(self.data, self.hora),
                timezone.get_current_timezone()
            )
            tempo_minimo_cancelamento = data_hora_agendamento - timedelta(minutes=30)
            # Ensure that 'agora' is timezone-aware
            agora = agora.astimezone(data_hora_agendamento.tzinfo)
            return agora < tempo_minimo_cancelamento

    def calcular_data_entrega_prevista(self):
        # Adiciona três dias úteis à data e hora do agendamento
        data_entrega_prevista = workday(self.data, 3)
        return timezone.datetime.combine(data_entrega_prevista, self.hora)

    def save(self, *args, **kwargs):
        # Calcula e atribui a data de entrega prevista antes de salvar o objeto
        if not self.data_entrega_prevista:
            self.data_entrega_prevista = self.calcular_data_entrega_prevista()
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Agendamento para {self.cliente_nome} em {self.equipamento.nome}"

