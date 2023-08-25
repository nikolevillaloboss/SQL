
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

CREATE TRIGGER dbo.trAutoresAuditarInsert
ON dbo.Autores FOR INSERT AS
Begin

DECLARE @Usuario varchar(128) = SYSTEM_USER;
DECLARE @PC varchar(128) = HOST_NAME();

INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'id_autor', NULL, INSERTED.id_autor, @Usuario, @PC, GETDATE(), 'I', INSERTED.id_autor FROM INSERTED;

INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'nombre', NULL, INSERTED.nombre, @Usuario, @PC, GETDATE(), 'I', INSERTED.id_autor FROM INSERTED;

INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'correo', NULL, INSERTED.correo, @Usuario, @PC, GETDATE(), 'I', INSERTED.id_autor FROM INSERTED;

INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)
SELECT 'dbo.Autores', 'temas', NULL, INSERTED.temas, @Usuario, @PC, GETDATE(), 'I', INSERTED.id_autor FROM INSERTED;


END;