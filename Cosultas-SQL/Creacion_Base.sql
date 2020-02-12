/* Base de Datos: Administración de una libreria.
   Tablas: Autor: Código Autor (codaut), Nombre Autor (nomaut), Apellido Autor (apeaut), Nacionalidad Autor (nacaut), Fecha Nacimiento (fech_nac).
		   Ejemplar: Número Ejemplar (numeje), Código Libro (codlib), Costo Ejemplar (costoejem), Disponibilidad (disponible), Código Localiad (codloc).
		   Escribe: Código Autor (codaut), Código Libro (codlib), Fecha Escritura (fecesc).
		   Libro: Código Libro (codlib), Titulo Libro (titulo), ISBN (isbn), Fecha Publicación (fecpub), Editorial (editorial), Número Paginas (numpag).
		   Localidad: Código Localiad (codloc), Estanteria (estanteria), Sala (sala), Piso (piso).
		   Prestamo: Código Usuario (codusu), Número Ejemplar (numeje), Código Localiad (codloc), Fecha Prestamo (fecpre), Fecha Devolución (fecdev).
		   T1: XXXX (a), YYYY (b), ZZZZ (c).
		   T2: ZZZZ (c), ABCD (d).
		   Telusu: Código Usuario (codusu), Número Telefono (numtel), Operadora (operadora).
		   Telusu1: Código Usuario (codusu), Número Telefono (numtel).
		   Usuarios: Código Usuario (codusu), Nombre Usuario (nomusu), Apellido Usuario (apeusu), Fecha Registro (fecreg), Dirección Usuario (dirusu), Multas (totalmulta), Garate (garante), Genero (genero).
*/

--Creación de varias tablas
Create table [Autor] 
(
	[codaut] Char(3) NOT NULL,
	[nomaut] Varchar(30) NOT NULL,
	[apeaut] Varchar(30) NULL,
	Constraint [pk_Autor] Primary Key ([codaut])
) 
on [primary]
GO

Create table [Libro]
(
	[codlib] Char(3) NOT NULL,
	[titulo] Varchar(30) NOT NULL,
	[ISBN] Varchar(10) NOT NULL, UNIQUE ([ISBN]),
	[fecpub] Datetime NULL,
	[editorial] Varchar(30) NOT NULL,
	[numpag] smallint NULL,
	Constraint [pk_Libro] Primary Key ([codlib])
)
on [primary]
GO

Create table [Ejemplar]
(
	[numeje] Tinyint NOT NULL,
	[codlib] Char(3) NOT NULL,
	[costoejem] Numeric(9,2) NULL,
	[disponible] Char(1) not null Constraint [CK_disponible] Check (disponible in ('S','N')),
	[CodLoc] Char(3) NOT NULL,
	Constraint [pk_Ejemplar] Primary Key ([numeje],[codlib])
) 
on secundario
GO

Create table [Usuarios]
(
	[codusu] Char(3) NOT NULL,
	[nomusu] Varchar(30) NULL,
	[apeusu] Varchar(30) NULL,
	[fecreg] Datetime NULL,
	[dirusu] Varchar(30) NULL,
	[TotalMulta] Numeric(8,2) NULL,
	[garante] Char(3) NOT NULL,
	Constraint [pk_Usuarios] Primary Key ([codusu])
) 
on secundario
GO

Create table [telusu]
(
	[codusu] Char(3) NOT NULL,
	[numtel] Varchar(9) NOT NULL,
	Constraint [pk_telusu] Primary Key ([codusu],[numtel])
) 
on secundario
GO

Create table [escribe]
(
	[codaut] Char(3) NOT NULL,
	[codlib] Char(3) NOT NULL,
	[fecesc] Datetime NULL,
	Constraint [pk_escribe] Primary Key ([codaut],[codlib])
) 
on secundario
go

Create table [prestamo]
(
	[codusu] Char(3) NOT NULL,
	[numeje] Tinyint NOT NULL,
	[codlib] Char(3) NOT NULL,
	[fecpre] Datetime NOT NULL,
	[fecdev] Datetime NULL,
Constraint [pk_prestamo] Primary Key ([codusu],[numeje],[codlib],[fecpre])
) 
on secundario
go

Create table [Localidad]
(
	[CodLoc] Char(3) NOT NULL,
	[Estanteria] Char(30) NULL,
	[Sala] Smallint NULL,
	[Piso] Smallint NULL,
Constraint [pk_Localidad] Primary Key ([CodLoc])
) 
on secundario
go


Alter table [escribe] add Constraint [autor-escribe] foreign key([codaut]) references [Autor] ([codaut])  on update cascade on delete no action 
go
Alter table [escribe] add Constraint [escribe-libro] foreign key([codlib]) references [Libro] ([codlib])  on update cascade on delete no action 
go
Alter table [Ejemplar] add Constraint [libro-ejemplar] foreign key([codlib]) references [Libro] ([codlib])  on update cascade on delete no action 
go
Alter table [prestamo] add Constraint [prestamo-ejemplar] foreign key([numeje],[codlib]) references [Ejemplar] ([numeje],[codlib])  on update cascade on delete no action 
go
Alter table [prestamo] add Constraint [usuario-prestamo] foreign key([codusu]) references [Usuarios] ([codusu])  on update cascade on delete no action 
go
Alter table [telusu] add Constraint [usuario-tel.usuario] foreign key([codusu]) references [Usuarios] ([codusu])  on update cascade on delete cascade 
go
Alter table [Usuarios] add Constraint [Garante] foreign key([garante]) references [Usuarios] ([codusu])  on update no action on delete no action 
go
Alter table [Ejemplar] add Constraint [ubicado_en] foreign key([CodLoc]) references [Localidad] ([CodLoc])  on update no action on delete cascade 
go

-- Ingreso datos en la tabla Autores.
insert into Autor values ('A07','Alejandro','Dumas','FR','10-12-1975')
insert into Autor values ('A08','Victor','Hugo','FR','10-12-2000')
insert into Autor values ('A09','Ariana','Molina','CO','10-12-2000')
insert into Autor values ('A06','Mario','Benedetti','UR')

-- Ingresando datos en la tabla Usuarios.
insert usuarios (codusu, nomusu, apeusu, dirusu, garante) values ('U01','Diego','Lopez','La Gasca','U01')
insert usuarios (codusu, nomusu, apeusu, dirusu, garante) values ('U02','Myrian','Perez','La Gasca','U01')
insert usuarios (codusu, nomusu, apeusu, dirusu, garante) values ('U03','David','Correa','Av.Shyris','U02')
insert usuarios values ('U04','Zoila','Vaca','01-01-2012','Machachi',0,'U01','F')

-- Modificando la tabla Usuarios. Agregando nueva columna llamada Genero.
alter table Usuarios add genero char(1)null

-- Elinando datos de un usurio.
delete Libro where titulo in 
       (select titulo from escribe where codaut in
	   (select codaut from Autor where apeaut= 'Spyrii'))

-- Ingresando datos a la tabla Escribe
insert into escribe values ('A01', 'L01','01-01-1986')
insert into escribe values ('A01', 'L02','20-07-1986')
insert into escribe values ('A02', 'L03','01-03-1987')
insert into escribe values ('A05', 'L05','01-01-1990')

-- Ingresando datos tabla Telusu
insert into Telusu values ('U01',22345678)
insert into Telusu values ('U02',93479011)
insert into Telusu values ('U03',22974809)
insert into Telusu values ('U04',85304040)
insert into Telusu values ('U05',69459303)
insert into Telusu values ('U06',22992939)
insert into Telusu values ('U01',93456872)
insert into Telusu values ('U02',79937622)

-- Borrando datos tabla Telusu
delete from Telusu where codusu='U01'
delete from Telusu where codusu='U02'
delete from Telusu where codusu='U03'
delete from Telusu where codusu='U04'
delete from Telusu where codusu='U05'
delete from Telusu where codusu='U06'

-- Modificando la tabla Telusu. Agregando nueva columna llamada Operadora.
alter table telusu add operadora char(1)

--Creación Tabla Telusu1
create table telusu1 (codusu char(3) not null, numtel varchar(12) not null)

-- Ingreso de datos en la tabla Telusu1.
insert into telusu1 values ('U01','09-987-7654')

-- Ingreso de datos en la tabla Prestamo
insert into prestamo values ('U01','1','L03','5-6-2011','8-9-2011')
insert into prestamo values ('U03','1','L01','6-7-2011','9-8-2011')

-- Ingreso de datos tabla Ejemplar
insert into Ejemplar values (1,'L01',25,'S','C01')
insert into Ejemplar values (2,'L01',30,'S','C01')
insert into Ejemplar values (3,'L01',30,'S','C01')
insert into Ejemplar values (1,'L02',10,'S','C02')
insert into Ejemplar values (2,'L02',10,'S','C02')
insert into Ejemplar values (3,'L02',15.25,'S','C02')
insert into Ejemplar values (4,'L02',15.75,'S','C02')
insert into Ejemplar values (1,'L03',50.45,'S','C03')
insert into Ejemplar values (2,'L03',50.55,'S','C03')
insert into Ejemplar values (3,'L03',50.555,'S','C03')

-- Ingreso de datos tabla Localidad
insert into Localidad values ('C01','Estanteria1',1,1)
insert into Localidad values ('C02','Estanteria2',2,1)
insert into Localidad values ('C03','Estanteria1',1,2)
insert into Localidad values ('C04','Estanteria2',2,2)
insert into Localidad values ('C05','Estanteria1',1,3)
insert into Localidad values ('C06','Estanteria1',2,3)

-- Creación tabla T1
create table T1 (a char(1) not null primary key, b tinyint not null, c char(1) null)

-- Ingreso datos tabla T1
insert into T1 values ('a',1,'1')
insert into T1 values ('b',2,'6')
insert into T1 values ('e',4,'a')
insert into T1 (a,b) values ('f',8)
insert into T1 (a,b) values ('g',5)
insert into T1 values ('g',default,null)

-- Actualización datos tabla T1
update T1
set b=2
where a='a'

-- Creación tabla T2 
create table T2 (a char(3) not null, b int null, c char(2)null ) 
 
-- Ingresando datos tabla T2
insert into T2 values ('a',5,'bb')

-- Creación de tablas temporales
select * into #tmp from T1 
select * from #tmp 
select * into #t3 from T1 where 1=2
select * from #t3
select * from #tmp 
select * from #t3
drop table #tmp
drop table #t3