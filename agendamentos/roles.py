from rolepermissions.roles import AbstractUserRole


class Administrador(AbstractUserRole):
    available_permissions = {'cadastrar_equipamento': True,'editar_equipamento': True, 'cancelar_agendamento': True, 'excluir_equipamento': True, 'register': True, }


class Cliente(AbstractUserRole):
    available_permissions = {'cliente': True,'historico': True, 'meus_agendamentos': True, 'listar_equipamentos': True, 'reagendar_equipamentos': True, 'cancelar_agendamento': True, 'agendar_equipamento': True, }