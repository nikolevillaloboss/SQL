USE [Test]
GO
--Ver en programmability en stored procedure

/****** Object:  StoredProcedure [dbo].[spGenerarAuditoriaTablaInsert]    Script Date: 25/8/2023 20:07:40 ******/
SET ANSI_NULLS ON
--Los ansi nulls son una configuracion para controlar comportamientos de igualdad y de operacion
GO
SET QUOTED_IDENTIFIER ON
--Palabras reservadas de los objetos de la base de datos
GO

--Este procedimiento tiene como objetivo generar el script automatico para los triggers

Create PROCEDURE [dbo].[spGenerarAuditoriaTablaInsert]
(
--Parametros a utilizar 
    @Esquema varchar(5),
    @Tabla varchar(150)
)
AS

BEGIN
--El set nocount on hace que no se devuelve valores de recuento
    SET NOCOUNT ON;

	--declaracion de parametros
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
	--Se hace una tabla temporal llamada infotabla 
	--En resumen, el fragmento de código está seleccionando información específica de las columnas de tablas o vistas y está usando la cláusula INTO para crear una tabla temporal llamada #InfoTabla con esa información. La nueva tabla temporal contendrá los resultados de la consulta y permitirá trabajar con esos resultados de manera más organizada.
	--El # es lo que hace que la tabla sea temporal
	#InfoTabla
	
	--Sys columns es una vista encargada de almacenar los diferentes datos de todas las tablas 
    FROM sys.columns c
    INNER JOIN sys.types t ON c.user_type_id = t.user_type_id
    LEFT OUTER JOIN sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
    LEFT OUTER JOIN sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
    WHERE c.object_id = OBJECT_ID(@TablaCompleta)
    ORDER BY c.column_id;



	--Se declara el nombre del trigger y se le dice al sistema que imprima el script automatico para los desencadenadores
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
	--En resumen, este fragmento de código genera comandos SQL dinámicos que registran cambios en una tabla de auditoría para cada columna de una tabla específica. También determina la columna que se utilizará como clave primaria en los registros de auditoría. Este proceso se realiza mediante un bucle que recorre las columnas y utiliza valores de variables para construir los comandos SQL.

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
		--En resumen, este fragmento de código elimina la fila de la tabla temporal que corresponde a la columna actual que se está procesando en el bucle y luego avanza al siguiente valor de column_id en la tabla temporal para prepararse para el próximo ciclo del bucle.
        DELETE FROM #InfoTabla WHERE column_id = @IdColumna;
        SELECT @IdColumna = MIN(column_id) FROM #InfoTabla;
    END
	

    PRINT 'END' + CHAR(13);
    PRINT CHAR(13);
    PRINT 'go' + CHAR(13);
END;
