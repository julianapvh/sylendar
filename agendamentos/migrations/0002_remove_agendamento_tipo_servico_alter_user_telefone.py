# Generated by Django 5.0.4 on 2024-05-20 14:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("agendamentos", "0001_initial"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="agendamento",
            name="tipo_servico",
        ),
        migrations.AlterField(
            model_name="user",
            name="telefone",
            field=models.CharField(max_length=15, null=True),
        ),
    ]
