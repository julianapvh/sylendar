from django.db import models

class Equipamento(models.Model):
    nome = models.CharField(max_length=100)
    descricao = models.TextField()
    disponivel = models.BooleanField(default=True)

    def __str__(self):
        return self.nome
        
class Agendamento(models.Model):
    
   
# Your fields here
    # For example:
    client_name = models.CharField(max_length=100)
    appointment_date = models.DateTimeField()

    def __str__(self):
        return self.client_name
