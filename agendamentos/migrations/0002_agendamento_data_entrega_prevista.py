# Generated by Django 5.0.3 on 2024-03-15 17:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('agendamentos', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='agendamento',
            name='data_entrega_prevista',
            field=models.DateTimeField(blank=True, default=None, null=True),
        ),
    ]
