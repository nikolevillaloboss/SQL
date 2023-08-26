
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<TRIGGER PARA CUANDO SE ACTUALIZA UN DATO>
-- =============================================
IF OBJECT_ID('dbo.trAutoresAuditarUpdate', 'TR') IS NOT NULL DROP TRIGGER dbo.trAutoresAuditarUpdate
GO
--CREACION DE TRIGGER
--Las funciones estan en rosado

--Crear el trigger

CREATE TRIGGER dbo.trAutoresAuditarUpdate
ON dbo.Autores FOR UPDATE AS
--indica que el proceso se realiza una vez que se hace un UPDATE
--Comenzar el proceso
Begin

--Por cada columna se realiza un registro 

DECLARE @Usuario varchar(128) = SYSTEM_USER;
DECLARE @PC varchar(128) = HOST_NAME();

--Para registra el dato anterior de la tabla se utilizan pseudo tablas que son propias de SQL
--DELETED que registra los elementos elimados e INSERTED que registra lo elementos ingresados
--En el query se ligan los valores que queremos registrar el cambio, con su respectiva pseudo tabla
--y luego se hace un join mediante el entre las dos pseudo tablas

INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'id_autor', d.id_autor, i.id_autor, @Usuario, @PC, GETDATE(), 'U', i.id_autor
FROM DELETED as d
JOIN INSERTED as i
on d.id_autor=i.id_autor;


INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'nombre', d.nombre, i.nombre, @Usuario, @PC, GETDATE(), 'U', i.id_autor
FROM DELETED as d
JOIN INSERTED as i
on d.id_autor=i.id_autor;


INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'correo', d.nombre, i.nombre, @Usuario, @PC, GETDATE(), 'U', i.id_autor
FROM DELETED as d
JOIN INSERTED as i
on d.id_autor=i.id_autor;


INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'temas', d.temas, i.temas, @Usuario, @PC, GETDATE(), 'U', i.id_autor
FROM DELETED as d
JOIN INSERTED as i
on d.id_autor=i.id_autor;

END;

