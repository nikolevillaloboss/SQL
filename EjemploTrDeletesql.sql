
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
IF OBJECT_ID('dbo.trAutoresAuditarDelete', 'TR') IS NOT NULL DROP TRIGGER dbo.trAutoresAuditarDelete
GO


CREATE TRIGGER dbo.trAutoresAuditarDelete
ON dbo.Autores FOR DELETE AS
Begin


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

