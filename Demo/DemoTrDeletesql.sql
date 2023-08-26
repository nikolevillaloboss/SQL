
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<TRIGGER PARA CUANDO SE ELIMINA UN DATO>
-- =============================================
IF OBJECT_ID('dbo.trAutoresAuditarDelete', 'TR') IS NOT NULL DROP TRIGGER dbo.trAutoresAuditarDelete
GO

--CREACION DE TRIGGER
--Las funciones estan en rosado

--Crear el trigger
CREATE TRIGGER dbo.trAutoresAuditarDelete
ON dbo.Autores FOR DELETE AS

--indica que el proceso se realiza una vez que se hace un DELETE
--Comenzar el proceso
Begin

--Por cada columna se realiza un registro 

DECLARE @Usuario varchar(128) = SYSTEM_USER;
DECLARE @PC varchar(128) = HOST_NAME();

INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'id_autor', d.id_autor, NULL, @Usuario, @PC, GETDATE(), 'D', id_autor
FROM DELETED as d


INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'nombre', d.nombre, NULL, @Usuario, @PC, GETDATE(), 'D', id_autor
FROM DELETED as d


INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'correo', d.nombre, NULL, @Usuario, @PC, GETDATE(), 'D', id_autor
FROM DELETED as d


INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'temas', d.temas, NULL, @Usuario, @PC, GETDATE(), 'D', id_autor
FROM DELETED as d

END;

