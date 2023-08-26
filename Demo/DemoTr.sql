-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF OBJECT_ID('dbo.trAutoresAuditarInsert', 'TR') IS NOT NULL DROP TRIGGER dbo.trAutoresAuditarInsert
GO
--CREACION DE TRIGGER--Las funciones estan en rosadoUse Test
go
--Crear el trigger
CREATE TRIGGER dbo.trAutoresAuditarInsert
ON dbo.Autores FOR INSERT AS 
--indica que el proceso se realiza una vez que se hace un insert--Comenzar el proceso
Begin
DECLARE @Usuario varchar(128) = SYSTEM_USER;
DECLARE @PC varchar(128) = HOST_NAME();

--Por cada columna se realiza un registro 

INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'id_autor', NULL, INSERTED.id_autor, @Usuario, @PC, GETDATE(), 'I', INSERTED.id_autor FROM INSERTED;

INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'nombre', NULL, INSERTED.nombre, @Usuario, @PC, GETDATE(), 'I', INSERTED.id_autor FROM INSERTED;

INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'correo', NULL, INSERTED.correo, @Usuario, @PC, GETDATE(), 'I', INSERTED.id_autor FROM INSERTED;

INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'temas', NULL, INSERTED.temas, @Usuario, @PC, GETDATE(), 'I', INSERTED.id_autor FROM INSERTED;

END

go
