from django.db import models

class Equipamento(models.Model):
    nome = models.CharField(max_length=100)
    # Outros campos do equipamento

class Agendamento(models.Model):
    cliente_nome = models.CharField(max_length=100)
    cliente_cpf = models.CharField(max_length=14)
    equipamento = models.ForeignKey(Equipamento, on_delete=models.CASCADE)
    data = models.DateField()
    hora = models.TimeField()

    def __str__(self):
        return f"{self.cliente_nome} - {self.equipamento} - {self.data} - {self.hora}"
