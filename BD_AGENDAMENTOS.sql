 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'bd_agendamentos')      
     EXEC (N'CREATE SCHEMA bd_agendamentos')                                   
 GO                                                               
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_agendamento'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'agendamentos_agendamento'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[agendamentos_agendamento]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[agendamentos_agendamento]
(
   [id] bigint IDENTITY(60, 1)  NOT NULL,
   [cliente_nome] nvarchar(100)  NOT NULL,
   [cliente_cpf] nvarchar(11)  NOT NULL,
   [data] date  NOT NULL,
   [hora] time(6)  NOT NULL,
   [prazo_devolucao] date  NULL,
   [tipo_servico] nvarchar(100)  NOT NULL,
   [cancelado] smallint  NOT NULL,
   [reagendado] smallint  NOT NULL,
   [equipamento_id] bigint  NOT NULL,
   [data_entrega_prevista] datetime2(6)  NULL,
   [nova_data] date  NULL,
   [data_original] date  NULL,
   [hora_original] time(6)  NULL,
   [nova_hora] time(6)  NULL,
   [data_emprestimo] datetime2(6)  NULL,
   [prazo_restante] bigint  NULL,
   [situacao] nvarchar(100)  NOT NULL,
   [emprestado] smallint  NOT NULL,
   [data_devolucao] datetime2(6)  NULL,
   [devolvido] smallint  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.agendamentos_agendamento',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'agendamentos_agendamento'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_equipamento'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'agendamentos_equipamento'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[agendamentos_equipamento]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[agendamentos_equipamento]
(
   [id] bigint IDENTITY(31, 1)  NOT NULL,
   [nome] nvarchar(100)  NOT NULL,
   [descricao] nvarchar(100)  NOT NULL,
   [fabricante] nvarchar(50)  NOT NULL,
   [data_aquisicao] date  NOT NULL,
   [quantidade_disponivel] int  NOT NULL,
   [status] nvarchar(20)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.agendamentos_equipamento',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'agendamentos_equipamento'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_equipamento_usuarios'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'agendamentos_equipamento_usuarios'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[agendamentos_equipamento_usuarios]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[agendamentos_equipamento_usuarios]
(
   [id] bigint IDENTITY(1, 1)  NOT NULL,
   [equipamento_id] bigint  NOT NULL,
   [user_id] bigint  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.agendamentos_equipamento_usuarios',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'agendamentos_equipamento_usuarios'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_event'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'agendamentos_event'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[agendamentos_event]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[agendamentos_event]
(
   [id] bigint IDENTITY(1, 1)  NOT NULL,
   [equipamento] nvarchar(100)  NOT NULL,
   [data] date  NOT NULL,
   [hora] time(6)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.agendamentos_event',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'agendamentos_event'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_historicoagendamento'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'agendamentos_historicoagendamento'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[agendamentos_historicoagendamento]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[agendamentos_historicoagendamento]
(
   [id] bigint IDENTITY(1, 1)  NOT NULL,
   [data_hora_alteracao] datetime2(6)  NOT NULL,
   [tipo_alteracao] nvarchar(100)  NOT NULL,
   [agendamento_id] bigint  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.agendamentos_historicoagendamento',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'agendamentos_historicoagendamento'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_user'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'agendamentos_user'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[agendamentos_user]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[agendamentos_user]
(
   [id] bigint IDENTITY(1, 1)  NOT NULL,
   [password] nvarchar(128)  NOT NULL,
   [last_login] datetime2(6)  NULL,
   [is_superuser] smallint  NOT NULL,
   [username] nvarchar(150)  NOT NULL,
   [first_name] nvarchar(150)  NOT NULL,
   [last_name] nvarchar(150)  NOT NULL,
   [email] nvarchar(254)  NOT NULL,
   [is_staff] smallint  NOT NULL,
   [is_active] smallint  NOT NULL,
   [date_joined] datetime2(6)  NOT NULL,
   [nome_completo] nvarchar(100)  NOT NULL,
   [telefone] nvarchar(15)  NOT NULL,
   [is_admin] smallint  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.agendamentos_user',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'agendamentos_user'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_user_groups'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'agendamentos_user_groups'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[agendamentos_user_groups]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[agendamentos_user_groups]
(
   [id] bigint IDENTITY(1, 1)  NOT NULL,
   [user_id] bigint  NOT NULL,
   [group_id] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.agendamentos_user_groups',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'agendamentos_user_groups'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_user_user_permissions'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'agendamentos_user_user_permissions'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[agendamentos_user_user_permissions]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[agendamentos_user_user_permissions]
(
   [id] bigint IDENTITY(1, 1)  NOT NULL,
   [user_id] bigint  NOT NULL,
   [permission_id] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.agendamentos_user_user_permissions',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'agendamentos_user_user_permissions'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_group'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'auth_group'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[auth_group]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[auth_group]
(
   [id] int IDENTITY(5, 1)  NOT NULL,
   [name] nvarchar(150)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.auth_group',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'auth_group'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_group_permissions'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'auth_group_permissions'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[auth_group_permissions]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[auth_group_permissions]
(
   [id] bigint IDENTITY(88, 1)  NOT NULL,
   [group_id] int  NOT NULL,
   [permission_id] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.auth_group_permissions',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'auth_group_permissions'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_permission'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'auth_permission'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[auth_permission]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[auth_permission]
(
   [id] int IDENTITY(51, 1)  NOT NULL,
   [name] nvarchar(255)  NOT NULL,
   [content_type_id] int  NOT NULL,
   [codename] nvarchar(100)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.auth_permission',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'auth_permission'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_user'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'auth_user'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[auth_user]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[auth_user]
(
   [id] int IDENTITY(28, 1)  NOT NULL,
   [password] nvarchar(128)  NOT NULL,
   [last_login] datetime2(6)  NULL,
   [is_superuser] smallint  NOT NULL,
   [username] nvarchar(150)  NOT NULL,
   [first_name] nvarchar(150)  NOT NULL,
   [last_name] nvarchar(150)  NOT NULL,
   [email] nvarchar(254)  NOT NULL,
   [is_staff] smallint  NOT NULL,
   [is_active] smallint  NOT NULL,
   [date_joined] datetime2(6)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.auth_user',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'auth_user'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_user_groups'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'auth_user_groups'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[auth_user_groups]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[auth_user_groups]
(
   [id] bigint IDENTITY(31, 1)  NOT NULL,
   [user_id] int  NOT NULL,
   [group_id] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.auth_user_groups',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'auth_user_groups'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_user_user_permissions'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'auth_user_user_permissions'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[auth_user_user_permissions]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[auth_user_user_permissions]
(
   [id] bigint IDENTITY(319, 1)  NOT NULL,
   [user_id] int  NOT NULL,
   [permission_id] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.auth_user_user_permissions',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'auth_user_user_permissions'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'django_admin_log'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'django_admin_log'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[django_admin_log]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[django_admin_log]
(
   [id] int IDENTITY(72, 1)  NOT NULL,
   [action_time] datetime2(6)  NOT NULL,
   [object_id] nvarchar(max)  NULL,
   [object_repr] nvarchar(200)  NOT NULL,
   [action_flag] int  NOT NULL,
   [change_message] nvarchar(max)  NOT NULL,
   [content_type_id] int  NULL,
   [user_id] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.django_admin_log',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'django_admin_log'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'django_content_type'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'django_content_type'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[django_content_type]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[django_content_type]
(
   [id] int IDENTITY(11, 1)  NOT NULL,
   [app_label] nvarchar(100)  NOT NULL,
   [model] nvarchar(100)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.django_content_type',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'django_content_type'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'django_migrations'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'django_migrations'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[django_migrations]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[django_migrations]
(
   [id] bigint IDENTITY(38, 1)  NOT NULL,
   [app] nvarchar(255)  NOT NULL,
   [name] nvarchar(255)  NOT NULL,
   [applied] datetime2(6)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.django_migrations',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'django_migrations'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'django_session'  AND sc.name = N'bd_agendamentos'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'django_session'  AND sc.name = N'bd_agendamentos'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bd_agendamentos].[django_session]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bd_agendamentos].[django_session]
(
   [session_key] nvarchar(40)  NOT NULL,
   [session_data] nvarchar(max)  NOT NULL,
   [expire_date] datetime2(6)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bd_agendamentos.django_session',
        N'SCHEMA', N'bd_agendamentos',
        N'TABLE', N'django_session'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_agendamentos_agendamento_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[agendamentos_agendamento] DROP CONSTRAINT [PK_agendamentos_agendamento_id]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_agendamento]
 ADD CONSTRAINT [PK_agendamentos_agendamento_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_agendamentos_equipamento_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[agendamentos_equipamento] DROP CONSTRAINT [PK_agendamentos_equipamento_id]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_equipamento]
 ADD CONSTRAINT [PK_agendamentos_equipamento_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_agendamentos_equipamento_usuarios_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[agendamentos_equipamento_usuarios] DROP CONSTRAINT [PK_agendamentos_equipamento_usuarios_id]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_equipamento_usuarios]
 ADD CONSTRAINT [PK_agendamentos_equipamento_usuarios_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_agendamentos_event_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[agendamentos_event] DROP CONSTRAINT [PK_agendamentos_event_id]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_event]
 ADD CONSTRAINT [PK_agendamentos_event_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_agendamentos_historicoagendamento_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[agendamentos_historicoagendamento] DROP CONSTRAINT [PK_agendamentos_historicoagendamento_id]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_historicoagendamento]
 ADD CONSTRAINT [PK_agendamentos_historicoagendamento_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_agendamentos_user_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[agendamentos_user] DROP CONSTRAINT [PK_agendamentos_user_id]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_user]
 ADD CONSTRAINT [PK_agendamentos_user_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_agendamentos_user_groups_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[agendamentos_user_groups] DROP CONSTRAINT [PK_agendamentos_user_groups_id]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_user_groups]
 ADD CONSTRAINT [PK_agendamentos_user_groups_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_agendamentos_user_user_permissions_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[agendamentos_user_user_permissions] DROP CONSTRAINT [PK_agendamentos_user_user_permissions_id]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_user_user_permissions]
 ADD CONSTRAINT [PK_agendamentos_user_user_permissions_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_auth_group_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[auth_group] DROP CONSTRAINT [PK_auth_group_id]
 GO



ALTER TABLE [bd_agendamentos].[auth_group]
 ADD CONSTRAINT [PK_auth_group_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_auth_group_permissions_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[auth_group_permissions] DROP CONSTRAINT [PK_auth_group_permissions_id]
 GO



ALTER TABLE [bd_agendamentos].[auth_group_permissions]
 ADD CONSTRAINT [PK_auth_group_permissions_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_auth_permission_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[auth_permission] DROP CONSTRAINT [PK_auth_permission_id]
 GO



ALTER TABLE [bd_agendamentos].[auth_permission]
 ADD CONSTRAINT [PK_auth_permission_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_auth_user_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[auth_user] DROP CONSTRAINT [PK_auth_user_id]
 GO



ALTER TABLE [bd_agendamentos].[auth_user]
 ADD CONSTRAINT [PK_auth_user_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_auth_user_groups_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[auth_user_groups] DROP CONSTRAINT [PK_auth_user_groups_id]
 GO



ALTER TABLE [bd_agendamentos].[auth_user_groups]
 ADD CONSTRAINT [PK_auth_user_groups_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_auth_user_user_permissions_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[auth_user_user_permissions] DROP CONSTRAINT [PK_auth_user_user_permissions_id]
 GO



ALTER TABLE [bd_agendamentos].[auth_user_user_permissions]
 ADD CONSTRAINT [PK_auth_user_user_permissions_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_django_admin_log_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[django_admin_log] DROP CONSTRAINT [PK_django_admin_log_id]
 GO



ALTER TABLE [bd_agendamentos].[django_admin_log]
 ADD CONSTRAINT [PK_django_admin_log_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_django_content_type_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[django_content_type] DROP CONSTRAINT [PK_django_content_type_id]
 GO



ALTER TABLE [bd_agendamentos].[django_content_type]
 ADD CONSTRAINT [PK_django_content_type_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_django_migrations_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[django_migrations] DROP CONSTRAINT [PK_django_migrations_id]
 GO



ALTER TABLE [bd_agendamentos].[django_migrations]
 ADD CONSTRAINT [PK_django_migrations_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_django_session_session_key'  AND sc.name = N'bd_agendamentos'  AND type in (N'PK'))
ALTER TABLE [bd_agendamentos].[django_session] DROP CONSTRAINT [PK_django_session_session_key]
 GO



ALTER TABLE [bd_agendamentos].[django_session]
 ADD CONSTRAINT [PK_django_session_session_key]
   PRIMARY KEY
   CLUSTERED ([session_key] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_equipamento_usuarios$agendamentos_equipamento_equipamento_id_user_id_eda279af_uniq'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[agendamentos_equipamento_usuarios] DROP CONSTRAINT [agendamentos_equipamento_usuarios$agendamentos_equipamento_equipamento_id_user_id_eda279af_uniq]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_equipamento_usuarios]
 ADD CONSTRAINT [agendamentos_equipamento_usuarios$agendamentos_equipamento_equipamento_id_user_id_eda279af_uniq]
 UNIQUE 
   NONCLUSTERED ([equipamento_id] ASC, [user_id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_user$username'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[agendamentos_user] DROP CONSTRAINT [agendamentos_user$username]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_user]
 ADD CONSTRAINT [agendamentos_user$username]
 UNIQUE 
   NONCLUSTERED ([username] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_user_groups$agendamentos_user_groups_user_id_group_id_6d91e88f_uniq'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[agendamentos_user_groups] DROP CONSTRAINT [agendamentos_user_groups$agendamentos_user_groups_user_id_group_id_6d91e88f_uniq]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_user_groups]
 ADD CONSTRAINT [agendamentos_user_groups$agendamentos_user_groups_user_id_group_id_6d91e88f_uniq]
 UNIQUE 
   NONCLUSTERED ([user_id] ASC, [group_id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_user_user_permissions$agendamentos_user_user_p_user_id_permission_id_f5308dc4_uniq'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[agendamentos_user_user_permissions] DROP CONSTRAINT [agendamentos_user_user_permissions$agendamentos_user_user_p_user_id_permission_id_f5308dc4_uniq]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_user_user_permissions]
 ADD CONSTRAINT [agendamentos_user_user_permissions$agendamentos_user_user_p_user_id_permission_id_f5308dc4_uniq]
 UNIQUE 
   NONCLUSTERED ([user_id] ASC, [permission_id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_group$name'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[auth_group] DROP CONSTRAINT [auth_group$name]
 GO



ALTER TABLE [bd_agendamentos].[auth_group]
 ADD CONSTRAINT [auth_group$name]
 UNIQUE 
   NONCLUSTERED ([name] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_group_permissions$auth_group_permissions_group_id_permission_id_0cd325b0_uniq'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[auth_group_permissions] DROP CONSTRAINT [auth_group_permissions$auth_group_permissions_group_id_permission_id_0cd325b0_uniq]
 GO



ALTER TABLE [bd_agendamentos].[auth_group_permissions]
 ADD CONSTRAINT [auth_group_permissions$auth_group_permissions_group_id_permission_id_0cd325b0_uniq]
 UNIQUE 
   NONCLUSTERED ([group_id] ASC, [permission_id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_permission$auth_permission_content_type_id_codename_01ab375a_uniq'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[auth_permission] DROP CONSTRAINT [auth_permission$auth_permission_content_type_id_codename_01ab375a_uniq]
 GO



ALTER TABLE [bd_agendamentos].[auth_permission]
 ADD CONSTRAINT [auth_permission$auth_permission_content_type_id_codename_01ab375a_uniq]
 UNIQUE 
   NONCLUSTERED ([content_type_id] ASC, [codename] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_user$username'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[auth_user] DROP CONSTRAINT [auth_user$username]
 GO



ALTER TABLE [bd_agendamentos].[auth_user]
 ADD CONSTRAINT [auth_user$username]
 UNIQUE 
   NONCLUSTERED ([username] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_user_groups$auth_user_groups_user_id_group_id_94350c0c_uniq'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[auth_user_groups] DROP CONSTRAINT [auth_user_groups$auth_user_groups_user_id_group_id_94350c0c_uniq]
 GO



ALTER TABLE [bd_agendamentos].[auth_user_groups]
 ADD CONSTRAINT [auth_user_groups$auth_user_groups_user_id_group_id_94350c0c_uniq]
 UNIQUE 
   NONCLUSTERED ([user_id] ASC, [group_id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_user_user_permissions$auth_user_user_permissions_user_id_permission_id_14a6b632_uniq'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[auth_user_user_permissions] DROP CONSTRAINT [auth_user_user_permissions$auth_user_user_permissions_user_id_permission_id_14a6b632_uniq]
 GO



ALTER TABLE [bd_agendamentos].[auth_user_user_permissions]
 ADD CONSTRAINT [auth_user_user_permissions$auth_user_user_permissions_user_id_permission_id_14a6b632_uniq]
 UNIQUE 
   NONCLUSTERED ([user_id] ASC, [permission_id] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'django_content_type$django_content_type_app_label_model_76bd3d3b_uniq'  AND sc.name = N'bd_agendamentos'  AND type in (N'UQ'))
ALTER TABLE [bd_agendamentos].[django_content_type] DROP CONSTRAINT [django_content_type$django_content_type_app_label_model_76bd3d3b_uniq]
 GO



ALTER TABLE [bd_agendamentos].[django_content_type]
 ADD CONSTRAINT [django_content_type$django_content_type_app_label_model_76bd3d3b_uniq]
 UNIQUE 
   NONCLUSTERED ([app_label] ASC, [model] ASC)

GO

IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'agendamentos_agendamento'  AND sc.name = N'bd_agendamentos'  AND si.name = N'agendamentos_agendam_equipamento_id_34a6ea1d_fk_agendamen' AND so.type in (N'U'))
   DROP INDEX [agendamentos_agendam_equipamento_id_34a6ea1d_fk_agendamen] ON [bd_agendamentos].[agendamentos_agendamento] 
GO
CREATE NONCLUSTERED INDEX [agendamentos_agendam_equipamento_id_34a6ea1d_fk_agendamen] ON [bd_agendamentos].[agendamentos_agendamento]
(
   [equipamento_id] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'agendamentos_equipamento_usuarios'  AND sc.name = N'bd_agendamentos'  AND si.name = N'agendamentos_equipam_user_id_47f7ff6c_fk_agendamen' AND so.type in (N'U'))
   DROP INDEX [agendamentos_equipam_user_id_47f7ff6c_fk_agendamen] ON [bd_agendamentos].[agendamentos_equipamento_usuarios] 
GO
CREATE NONCLUSTERED INDEX [agendamentos_equipam_user_id_47f7ff6c_fk_agendamen] ON [bd_agendamentos].[agendamentos_equipamento_usuarios]
(
   [user_id] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'agendamentos_historicoagendamento'  AND sc.name = N'bd_agendamentos'  AND si.name = N'agendamentos_histori_agendamento_id_05342f8d_fk_agendamen' AND so.type in (N'U'))
   DROP INDEX [agendamentos_histori_agendamento_id_05342f8d_fk_agendamen] ON [bd_agendamentos].[agendamentos_historicoagendamento] 
GO
CREATE NONCLUSTERED INDEX [agendamentos_histori_agendamento_id_05342f8d_fk_agendamen] ON [bd_agendamentos].[agendamentos_historicoagendamento]
(
   [agendamento_id] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'agendamentos_user_groups'  AND sc.name = N'bd_agendamentos'  AND si.name = N'agendamentos_user_groups_group_id_f8a1a175_fk_auth_group_id' AND so.type in (N'U'))
   DROP INDEX [agendamentos_user_groups_group_id_f8a1a175_fk_auth_group_id] ON [bd_agendamentos].[agendamentos_user_groups] 
GO
CREATE NONCLUSTERED INDEX [agendamentos_user_groups_group_id_f8a1a175_fk_auth_group_id] ON [bd_agendamentos].[agendamentos_user_groups]
(
   [group_id] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'agendamentos_user_user_permissions'  AND sc.name = N'bd_agendamentos'  AND si.name = N'agendamentos_user_us_permission_id_6d9e53e5_fk_auth_perm' AND so.type in (N'U'))
   DROP INDEX [agendamentos_user_us_permission_id_6d9e53e5_fk_auth_perm] ON [bd_agendamentos].[agendamentos_user_user_permissions] 
GO
CREATE NONCLUSTERED INDEX [agendamentos_user_us_permission_id_6d9e53e5_fk_auth_perm] ON [bd_agendamentos].[agendamentos_user_user_permissions]
(
   [permission_id] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'auth_group_permissions'  AND sc.name = N'bd_agendamentos'  AND si.name = N'auth_group_permissio_permission_id_84c5c92e_fk_auth_perm' AND so.type in (N'U'))
   DROP INDEX [auth_group_permissio_permission_id_84c5c92e_fk_auth_perm] ON [bd_agendamentos].[auth_group_permissions] 
GO
CREATE NONCLUSTERED INDEX [auth_group_permissio_permission_id_84c5c92e_fk_auth_perm] ON [bd_agendamentos].[auth_group_permissions]
(
   [permission_id] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'auth_user_groups'  AND sc.name = N'bd_agendamentos'  AND si.name = N'auth_user_groups_group_id_97559544_fk_auth_group_id' AND so.type in (N'U'))
   DROP INDEX [auth_user_groups_group_id_97559544_fk_auth_group_id] ON [bd_agendamentos].[auth_user_groups] 
GO
CREATE NONCLUSTERED INDEX [auth_user_groups_group_id_97559544_fk_auth_group_id] ON [bd_agendamentos].[auth_user_groups]
(
   [group_id] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'auth_user_user_permissions'  AND sc.name = N'bd_agendamentos'  AND si.name = N'auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm' AND so.type in (N'U'))
   DROP INDEX [auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm] ON [bd_agendamentos].[auth_user_user_permissions] 
GO
CREATE NONCLUSTERED INDEX [auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm] ON [bd_agendamentos].[auth_user_user_permissions]
(
   [permission_id] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'django_admin_log'  AND sc.name = N'bd_agendamentos'  AND si.name = N'django_admin_log_content_type_id_c4bce8eb_fk_django_co' AND so.type in (N'U'))
   DROP INDEX [django_admin_log_content_type_id_c4bce8eb_fk_django_co] ON [bd_agendamentos].[django_admin_log] 
GO
CREATE NONCLUSTERED INDEX [django_admin_log_content_type_id_c4bce8eb_fk_django_co] ON [bd_agendamentos].[django_admin_log]
(
   [content_type_id] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'django_admin_log'  AND sc.name = N'bd_agendamentos'  AND si.name = N'django_admin_log_user_id_c564eba6_fk_auth_user_id' AND so.type in (N'U'))
   DROP INDEX [django_admin_log_user_id_c564eba6_fk_auth_user_id] ON [bd_agendamentos].[django_admin_log] 
GO
CREATE NONCLUSTERED INDEX [django_admin_log_user_id_c564eba6_fk_auth_user_id] ON [bd_agendamentos].[django_admin_log]
(
   [user_id] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'django_session'  AND sc.name = N'bd_agendamentos'  AND si.name = N'django_session_expire_date_a5c62663' AND so.type in (N'U'))
   DROP INDEX [django_session_expire_date_a5c62663] ON [bd_agendamentos].[django_session] 
GO
CREATE NONCLUSTERED INDEX [django_session_expire_date_a5c62663] ON [bd_agendamentos].[django_session]
(
   [expire_date] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_agendamento$agendamentos_agendam_equipamento_id_34a6ea1d_fk_agendamen'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[agendamentos_agendamento] DROP CONSTRAINT [agendamentos_agendamento$agendamentos_agendam_equipamento_id_34a6ea1d_fk_agendamen]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_agendamento]
 ADD CONSTRAINT [agendamentos_agendamento$agendamentos_agendam_equipamento_id_34a6ea1d_fk_agendamen]
 FOREIGN KEY 
   ([equipamento_id])
 REFERENCES 
   [bd_agendamentos].[agendamentos_equipamento]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_equipamento_usuarios$agendamentos_equipam_equipamento_id_11117a2e_fk_agendamen'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[agendamentos_equipamento_usuarios] DROP CONSTRAINT [agendamentos_equipamento_usuarios$agendamentos_equipam_equipamento_id_11117a2e_fk_agendamen]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_equipamento_usuarios]
 ADD CONSTRAINT [agendamentos_equipamento_usuarios$agendamentos_equipam_equipamento_id_11117a2e_fk_agendamen]
 FOREIGN KEY 
   ([equipamento_id])
 REFERENCES 
   [bd_agendamentos].[agendamentos_equipamento]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_equipamento_usuarios$agendamentos_equipam_user_id_47f7ff6c_fk_agendamen'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[agendamentos_equipamento_usuarios] DROP CONSTRAINT [agendamentos_equipamento_usuarios$agendamentos_equipam_user_id_47f7ff6c_fk_agendamen]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_equipamento_usuarios]
 ADD CONSTRAINT [agendamentos_equipamento_usuarios$agendamentos_equipam_user_id_47f7ff6c_fk_agendamen]
 FOREIGN KEY 
   ([user_id])
 REFERENCES 
   [bd_agendamentos].[agendamentos_user]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_historicoagendamento$agendamentos_histori_agendamento_id_05342f8d_fk_agendamen'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[agendamentos_historicoagendamento] DROP CONSTRAINT [agendamentos_historicoagendamento$agendamentos_histori_agendamento_id_05342f8d_fk_agendamen]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_historicoagendamento]
 ADD CONSTRAINT [agendamentos_historicoagendamento$agendamentos_histori_agendamento_id_05342f8d_fk_agendamen]
 FOREIGN KEY 
   ([agendamento_id])
 REFERENCES 
   [bd_agendamentos].[agendamentos_agendamento]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_user_groups$agendamentos_user_gr_user_id_efc056f5_fk_agendamen'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[agendamentos_user_groups] DROP CONSTRAINT [agendamentos_user_groups$agendamentos_user_gr_user_id_efc056f5_fk_agendamen]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_user_groups]
 ADD CONSTRAINT [agendamentos_user_groups$agendamentos_user_gr_user_id_efc056f5_fk_agendamen]
 FOREIGN KEY 
   ([user_id])
 REFERENCES 
   [bd_agendamentos].[agendamentos_user]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_user_groups$agendamentos_user_groups_group_id_f8a1a175_fk_auth_group_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[agendamentos_user_groups] DROP CONSTRAINT [agendamentos_user_groups$agendamentos_user_groups_group_id_f8a1a175_fk_auth_group_id]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_user_groups]
 ADD CONSTRAINT [agendamentos_user_groups$agendamentos_user_groups_group_id_f8a1a175_fk_auth_group_id]
 FOREIGN KEY 
   ([group_id])
 REFERENCES 
   [bd_agendamentos].[auth_group]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_user_user_permissions$agendamentos_user_us_permission_id_6d9e53e5_fk_auth_perm'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[agendamentos_user_user_permissions] DROP CONSTRAINT [agendamentos_user_user_permissions$agendamentos_user_us_permission_id_6d9e53e5_fk_auth_perm]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_user_user_permissions]
 ADD CONSTRAINT [agendamentos_user_user_permissions$agendamentos_user_us_permission_id_6d9e53e5_fk_auth_perm]
 FOREIGN KEY 
   ([permission_id])
 REFERENCES 
   [bd_agendamentos].[auth_permission]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'agendamentos_user_user_permissions$agendamentos_user_us_user_id_676a76fe_fk_agendamen'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[agendamentos_user_user_permissions] DROP CONSTRAINT [agendamentos_user_user_permissions$agendamentos_user_us_user_id_676a76fe_fk_agendamen]
 GO



ALTER TABLE [bd_agendamentos].[agendamentos_user_user_permissions]
 ADD CONSTRAINT [agendamentos_user_user_permissions$agendamentos_user_us_user_id_676a76fe_fk_agendamen]
 FOREIGN KEY 
   ([user_id])
 REFERENCES 
   [bd_agendamentos].[agendamentos_user]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_group_permissions$auth_group_permissio_permission_id_84c5c92e_fk_auth_perm'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[auth_group_permissions] DROP CONSTRAINT [auth_group_permissions$auth_group_permissio_permission_id_84c5c92e_fk_auth_perm]
 GO



ALTER TABLE [bd_agendamentos].[auth_group_permissions]
 ADD CONSTRAINT [auth_group_permissions$auth_group_permissio_permission_id_84c5c92e_fk_auth_perm]
 FOREIGN KEY 
   ([permission_id])
 REFERENCES 
   [bd_agendamentos].[auth_permission]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_group_permissions$auth_group_permissions_group_id_b120cbf9_fk_auth_group_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[auth_group_permissions] DROP CONSTRAINT [auth_group_permissions$auth_group_permissions_group_id_b120cbf9_fk_auth_group_id]
 GO



ALTER TABLE [bd_agendamentos].[auth_group_permissions]
 ADD CONSTRAINT [auth_group_permissions$auth_group_permissions_group_id_b120cbf9_fk_auth_group_id]
 FOREIGN KEY 
   ([group_id])
 REFERENCES 
   [bd_agendamentos].[auth_group]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_permission$auth_permission_content_type_id_2f476e4b_fk_django_co'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[auth_permission] DROP CONSTRAINT [auth_permission$auth_permission_content_type_id_2f476e4b_fk_django_co]
 GO



ALTER TABLE [bd_agendamentos].[auth_permission]
 ADD CONSTRAINT [auth_permission$auth_permission_content_type_id_2f476e4b_fk_django_co]
 FOREIGN KEY 
   ([content_type_id])
 REFERENCES 
   [bd_agendamentos].[django_content_type]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_user_groups$auth_user_groups_group_id_97559544_fk_auth_group_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[auth_user_groups] DROP CONSTRAINT [auth_user_groups$auth_user_groups_group_id_97559544_fk_auth_group_id]
 GO



ALTER TABLE [bd_agendamentos].[auth_user_groups]
 ADD CONSTRAINT [auth_user_groups$auth_user_groups_group_id_97559544_fk_auth_group_id]
 FOREIGN KEY 
   ([group_id])
 REFERENCES 
   [bd_agendamentos].[auth_group]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_user_groups$auth_user_groups_user_id_6a12ed8b_fk_auth_user_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[auth_user_groups] DROP CONSTRAINT [auth_user_groups$auth_user_groups_user_id_6a12ed8b_fk_auth_user_id]
 GO



ALTER TABLE [bd_agendamentos].[auth_user_groups]
 ADD CONSTRAINT [auth_user_groups$auth_user_groups_user_id_6a12ed8b_fk_auth_user_id]
 FOREIGN KEY 
   ([user_id])
 REFERENCES 
   [bd_agendamentos].[auth_user]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_user_user_permissions$auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[auth_user_user_permissions] DROP CONSTRAINT [auth_user_user_permissions$auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm]
 GO



ALTER TABLE [bd_agendamentos].[auth_user_user_permissions]
 ADD CONSTRAINT [auth_user_user_permissions$auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm]
 FOREIGN KEY 
   ([permission_id])
 REFERENCES 
   [bd_agendamentos].[auth_permission]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'auth_user_user_permissions$auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[auth_user_user_permissions] DROP CONSTRAINT [auth_user_user_permissions$auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id]
 GO



ALTER TABLE [bd_agendamentos].[auth_user_user_permissions]
 ADD CONSTRAINT [auth_user_user_permissions$auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id]
 FOREIGN KEY 
   ([user_id])
 REFERENCES 
   [bd_agendamentos].[auth_user]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'django_admin_log$django_admin_log_content_type_id_c4bce8eb_fk_django_co'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[django_admin_log] DROP CONSTRAINT [django_admin_log$django_admin_log_content_type_id_c4bce8eb_fk_django_co]
 GO



ALTER TABLE [bd_agendamentos].[django_admin_log]
 ADD CONSTRAINT [django_admin_log$django_admin_log_content_type_id_c4bce8eb_fk_django_co]
 FOREIGN KEY 
   ([content_type_id])
 REFERENCES 
   [bd_agendamentos].[django_content_type]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'django_admin_log$django_admin_log_user_id_c564eba6_fk_auth_user_id'  AND sc.name = N'bd_agendamentos'  AND type in (N'F'))
ALTER TABLE [bd_agendamentos].[django_admin_log] DROP CONSTRAINT [django_admin_log$django_admin_log_user_id_c564eba6_fk_auth_user_id]
 GO



ALTER TABLE [bd_agendamentos].[django_admin_log]
 ADD CONSTRAINT [django_admin_log$django_admin_log_user_id_c564eba6_fk_auth_user_id]
 FOREIGN KEY 
   ([user_id])
 REFERENCES 
   [bd_agendamentos].[auth_user]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

ALTER TABLE  [bd_agendamentos].[agendamentos_agendamento]
 ADD DEFAULT NULL FOR [prazo_devolucao]
GO

ALTER TABLE  [bd_agendamentos].[agendamentos_agendamento]
 ADD DEFAULT NULL FOR [data_entrega_prevista]
GO

ALTER TABLE  [bd_agendamentos].[agendamentos_agendamento]
 ADD DEFAULT NULL FOR [nova_data]
GO

ALTER TABLE  [bd_agendamentos].[agendamentos_agendamento]
 ADD DEFAULT NULL FOR [data_original]
GO

ALTER TABLE  [bd_agendamentos].[agendamentos_agendamento]
 ADD DEFAULT NULL FOR [hora_original]
GO

ALTER TABLE  [bd_agendamentos].[agendamentos_agendamento]
 ADD DEFAULT NULL FOR [nova_hora]
GO

ALTER TABLE  [bd_agendamentos].[agendamentos_agendamento]
 ADD DEFAULT NULL FOR [data_emprestimo]
GO

ALTER TABLE  [bd_agendamentos].[agendamentos_agendamento]
 ADD DEFAULT NULL FOR [prazo_restante]
GO

ALTER TABLE  [bd_agendamentos].[agendamentos_agendamento]
 ADD DEFAULT NULL FOR [data_devolucao]
GO

ALTER TABLE  [bd_agendamentos].[agendamentos_user]
 ADD DEFAULT NULL FOR [last_login]
GO

ALTER TABLE  [bd_agendamentos].[auth_user]
 ADD DEFAULT NULL FOR [last_login]
GO

ALTER TABLE  [bd_agendamentos].[django_admin_log]
 ADD DEFAULT NULL FOR [content_type_id]
GO

