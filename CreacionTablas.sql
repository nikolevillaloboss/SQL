--Ejercicio Practico
--Base de datos
--Creacion de una auditoria mediente triggers, procedimientos almacenados y tablas temporales

--Primer paso: creacion de una nueva tabla llamada auditoría en la base de datos biblioteca ya existente
Use Asocia_cines
go
--crear tabla para registrar cambios
Create table Auditoria(
Id int identity primary key,
Tipo char(1),
Tabla varchar (50),
Registro int,
Campo varchar (50),
ValorAntes varchar (50),
ValorDespues varchar(50),
Fecha datetime,
Usuario varchar(50),
PC varchar(50)

);
--tabla a auditar en la base de datos biblioteca
create table Autores(
id_autor int primary key,
nombre varchar (50),
correo varchar (50),
temas varchar (100)

);

go

select *from Autores

go





go
--ejecutar procedimiento almacenado para generar script automatico para triggers de tipo insert (cualquier otro tipo de modificacion, editar proc almacenado para que funcione)
execute dbo.spGenerarAuditoriaTablaInsert 'dbo', 'Autores'




use Biblioteca

