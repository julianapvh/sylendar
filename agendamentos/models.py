# models.py
from django.db import models

class Agendamento(models.Model):
    nome = models.CharField(max_length=100)
    cpf = models.CharField(max_length=14)
    equipamento = models.CharField(max_length=100)
    data = models.DateField()
    hora = models.TimeField()
