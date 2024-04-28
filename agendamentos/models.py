from django.contrib.auth.models import AbstractUser, Group, Permission, BaseUserManager
from django.contrib import admin
from django.db import models
from django.utils import timezone
from datetime import datetime, timedelta
from workdays import workday


class CustomUserManager(BaseUserManager):
    def create_user(self, username, password=None, **extra_fields):
        if not username:
            raise ValueError("O campo Nome de usuário deve ser definido")
        user = self.model(username=username, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault(
            "is_admin", True
        )  # Add this line to set is_admin=True for superuser

        if extra_fields.get("is_staff") is not True:
            raise ValueError("Superusuário deve ter is_staff=True.")
        if extra_fields.get("is_superuser") is not True:
            raise ValueError("Superusuário deve ter is_superuser=True.")

        return self.create_user(username, password, **extra_fields)


class User(AbstractUser):
    nome_completo = models.CharField(max_length=100)
    telefone = models.CharField(max_length=15)
    is_admin = models.BooleanField(
        default=False
    )  # Add this field to identify admin users

    groups = models.ManyToManyField(Group, related_name="custom_user_groups")
    user_permissions = models.ManyToManyField(
        Permission, related_name="custom_user_permissions"
    )

    objects = CustomUserManager()

    def __str__(self):
        return self.nome_completo if self.nome_completo else self.username


class Equipamento(models.Model):
    STATUS_CHOICES = (
        ("disponivel", "Disponível"),
        ("agendado", "Agendado"),
        ("cancelado", "Cancelado"),
    )

    nome = models.CharField(max_length=100)
    descricao = models.CharField(max_length=100)
    fabricante = models.CharField(max_length=50)
    data_aquisicao = models.DateField(blank=False)
    quantidade_disponivel = models.IntegerField(default=0)
    status = models.CharField(
        max_length=20, choices=STATUS_CHOICES, default="disponivel"
    )
    usuarios = models.ManyToManyField(User, related_name="equipamentos", blank=True)

    def __str__(self):
        return self.nome


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
    data_emprestimo = models.DateTimeField(
        default=None, null=True, blank=True
    )  # Data de empréstimo do equipamento
    data_devolucao = models.DateTimeField(null=True, blank=True)
    situacao = models.CharField(
        max_length=100, default="Agendado"
    )  # Situação do agendamento
    prazo_restante = models.DurationField(
        null=True, blank=True
    )  # Prazo restante para devolução
    emprestado = models.BooleanField(default=False)  # Se o equipamento foi emprestado
    devolvido = models.BooleanField(default=False)  # Se o equipamento foi devolvido
    quantidade_dias = models.IntegerField(
        choices=[(1, "1 dia"), (2, "2 dias"), (3, "3 dias")], default=3
    )

    nova_data = models.DateField(null=True, blank=True)
    nova_hora = models.TimeField(null=True, blank=True)
    data_original = models.DateField(null=True, blank=True)
    hora_original = models.TimeField(null=True, blank=True)

    def status_equipamento(self):
        return self.equipamento.status

    def get_status_agendamento(self):
        if self.cancelado:
            return "Cancelado"
        elif self.reagendado:
            return "Reagendado"
        elif self.emprestado:
            return "Emprestado"
        elif self.devolvido:
            return "Devolvido"
        elif self.data < timezone.now():
            return "Passado"
        elif self.data == timezone.now():
            return "Agendado para agora"
        else:
            return "Agendamento futuro"

    def pode_cancelar(self):
        if not self.cancelado:
            agora = timezone.now()
            data_hora_agendamento = timezone.make_aware(
                timezone.datetime.combine(self.data, self.hora),
                timezone.get_current_timezone(),
            )
            tempo_minimo_cancelamento = data_hora_agendamento - timedelta(minutes=30)
            agora = agora.astimezone(data_hora_agendamento.tzinfo)
            return agora < tempo_minimo_cancelamento

    def calcular_data_entrega_prevista(self):
        # Adiciona a quantidade de dias escolhida pelo cliente à data e hora do agendamento
        data_entrega_prevista = workday(self.data, self.quantidade_dias)
        data_entrega_prevista = datetime.combine(
            data_entrega_prevista, self.hora
        )  # Convertendo para datetime
        data_entrega_prevista = timezone.make_aware(
            data_entrega_prevista
        )  # Tornar a data consciente do fuso horário
        return data_entrega_prevista

    def calcular_data_devolucao(self):
        if self.data_emprestimo:
            data_devolucao = workday(self.data_emprestimo.date(), self.quantidade_dias)
            data_devolucao_prevista = timezone.datetime.combine(
                data_devolucao, self.data_emprestimo.time()
            )
            data_devolucao_prevista = timezone.make_aware(
                data_devolucao_prevista
            )  # Tornar a data consciente do fuso horário
            return data_devolucao_prevista
        return None

    def calcular_prazo_restante(self):
        if self.data_emprestimo:
            data_devolucao_prevista = self.calcular_data_devolucao()
            if data_devolucao_prevista:
                agora = timezone.now()
                prazo_restante = data_devolucao_prevista - agora
                return prazo_restante if prazo_restante > timedelta(0) else timedelta(0)
        return None

    def save(self, *args, **kwargs):
        if not self.pk:  # Novo agendamento
            self.data_original = self.data
            self.hora_original = self.hora
        elif (
            self.data != self.data_original or self.hora != self.hora_original
        ):  # Reagendamento
            self.reagendado = True

        if self.reagendado:  # Se houve reagendamento
            self.nova_data = self.data
            self.nova_hora = self.hora
        else:
            self.nova_data = None
            self.nova_hora = None

        super().save(*args, **kwargs)

    def __str__(self):
        return f"Agendamento para {self.cliente_nome} em {self.equipamento.nome}"


class AgendamentoAdmin(admin.ModelAdmin):
    list_display = (
        "id",
        "equipamento",
        "cliente_nome",
        "data",
        "hora",
        "situacao",
        "data_emprestimo",
    )
    list_filter = ("situacao", "data")
    search_fields = ("equipamento__nome", "cliente_nome")
    actions = ["marcar_como_emprestado"]

    def marcar_como_emprestado(self, request, queryset):
        queryset.update(
            situacao="Emprestado", data_emprestimo=timezone.now(), emprestado=True
        )

    marcar_como_emprestado.short_description = "Marcar como Emprestado"


admin.site.register(Agendamento, AgendamentoAdmin)


class HistoricoAgendamento(models.Model):
    agendamento = models.ForeignKey(Agendamento, on_delete=models.CASCADE)
    data_hora_alteracao = models.DateTimeField(default=timezone.now)
    tipo_alteracao = models.CharField(max_length=100)
