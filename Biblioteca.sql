create database Biblioteca
go

use Biblioteca
go

create table Autores(
id_autor int not null primary key,
nombre varchar(100),
correo varchar(100),
temas varchar(100)
)
go
create table ArticuloCientifico(
id_cientifico int not null primary key,
titulo varchar(100),
palabras_clave varchar(100),
correo varchar(100),
tema varchar(100),
num_copias int,
ubicacion varchar(100),
fk_id_autor int foreign key references Autores(id_autor)
)
go
create table ActaCongreso(
acta_id int not null primary key,
nombre varchar(100),
edicion int,
frecuencia varchar(100),
tipo varchar(100),
fec_inicio date,
anio_celeb date,
ciudad varchar(100),
pais varchar(100)

)
go

alter table InformeTecnico(
informe_id int not null primary key,
numero int,
centro_pub varchar(100),
tipo varchar(100),
anio date

)
go
create table Revista(
nombre varchar(100),
nombre_editor varchar(100),
anio_pub date,
frecuencia varchar(100),
tema varchar(100),
paginas varchar(100)
)
go
alter table Revista  
add fk_id_cientifico int foreign key  references ArticuloCientifico(id_cientifico)
go

alter table InformeTecnico 
add fk_id_cientifico int foreign key  references ArticuloCientifico(id_cientifico)
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