USE Biblioteca;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[spGenerarAuditoriaTablaInsert]
(
    @Esquema varchar(5),
    @Tabla varchar(150)
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Campo varchar(50);
    DECLARE @IdColumna int;
    DECLARE @Tipo varchar(50);
    DECLARE @Longitud varchar(20);
    DECLARE @Precision int;
    DECLARE @Escala int;
    DECLARE @TablaCompleta varchar(155) = @Esquema + '.' + @Tabla;

    SELECT
        c.name 'Columna',
        t.name 'Tipo',
        c.max_length 'Longitud',
        c.precision,
        c.scale,
        c.is_nullable,
        ISNULL(i.is_primary_key, 0) 'PrimaryKey',
        c.column_id
    INTO 
	
	#InfoTabla
    FROM sys.columns c
    INNER JOIN sys.types t ON c.user_type_id = t.user_type_id
    LEFT OUTER JOIN sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
    LEFT OUTER JOIN sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
    WHERE c.object_id = OBJECT_ID(@TablaCompleta)
    ORDER BY c.column_id;

    DECLARE @NombreTrigger varchar(158) = @Esquema + '.tr' + @Tabla + 'AuditarInsert';

    PRINT 'IF OBJECT_ID(''' + @NombreTrigger + ''', ''TR'') IS NOT NULL DROP TRIGGER ' + @NombreTrigger;
    PRINT 'GO';
    PRINT CHAR(13);

    PRINT 'CREATE TRIGGER ' + @NombreTrigger;
    PRINT 'ON ' + @TablaCompleta + ' FOR INSERT AS ';
    PRINT CHAR(13);
	PRINT 'Begin'
    PRINT 'DECLARE @Usuario varchar(128) = SYSTEM_USER;';
    PRINT 'DECLARE @PC varchar(128) = HOST_NAME();';
    PRINT CHAR(13);

	--Bucle por los campos

    DECLARE @NombreClavePrimaria varchar(50) = '';
	select * into #InfoTablaParametros FROM #InfoTabla;
    SELECT @IdColumna = MIN(column_id) FROM #InfoTablaParametros;

    WHILE @IdColumna IS NOT NULL
    BEGIN
        SELECT @Campo = Columna, @Tipo = Tipo, @Longitud = Longitud, @Precision = precision, @Escala = scale FROM #InfoTabla WHERE column_id = @IdColumna;

        IF @Longitud = -1 SET @Longitud = 'MAX';

        IF @NombreClavePrimaria = ''
        BEGIN
            SET @NombreClavePrimaria = @Campo;
        END

        PRINT 'INSERT INTO dbo.Auditoria (Tabla, Campo, ValorAntes, ValorDespues, Usuario, PC, Fecha, Tipo, Registro)';
        PRINT 'SELECT ''' + @TablaCompleta + ''', ''' + @Campo + ''', NULL, INSERTED.' + @Campo + ', @Usuario, @PC, GETDATE(), ''I'', INSERTED.' + @NombreClavePrimaria + ' FROM INSERTED;';
        PRINT CHAR(13);

		---siguiente registro
        DELETE FROM #InfoTabla WHERE column_id = @IdColumna;
        SELECT @IdColumna = MIN(column_id) FROM #InfoTabla;
    END

    PRINT 'END' + CHAR(13);
    PRINT CHAR(13);
    PRINT 'go' + CHAR(13);
END;
GO

--drop procedure [dbo].[spGenerarAuditoriaTablaInsert]



