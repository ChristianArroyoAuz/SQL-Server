-- Contar el nùmero de ejemplares existentes en la biblioteca
Create Function F_ejem ()
returns integer
	as
		begin
			declare @contador integer
			select @contador = COUNT(codlib) from Ejemplar
			return @contador
end
GO
select dbo.F_ejem() as 'Cantidad'
GO
drop function dbo.f_ejem
GO

-- Contar el nùmero de ejemplares existentes en la biblioteca por libro
create function N_ejem()
returns table
	as
		return(select titulo as 'Titulo Libro', (select COUNT(numeje) from Ejemplar e where l.codlib=e.codlib) as 'Numero de Ejemplares' from Libro l);
GO
select * from N_ejem()
GO
drop function dbo.N_ejem
GO

-- Ejemplares con la numeración L01
create function Fnejem (@codlib char(3))
returns integer
	as
		begin
			return (select COUNT(numeje) from Ejemplar e where @codlib = e.codlib)
end
GO
select dbo.fnejem ('L01') as 'Cantidad'
GO
drop function dbo.Fnejem
GO

-- Dado el codigo del libro y número de ejempla determinar en que sala se encuentra.
create function sala6(@codlib char(3), @numeje tinyint )
returns integer
	as 
		begin
			return(select sala from Libro l, Ejemplar e, Localidad lo where l.codlib = e.codlib and e.CodLoc = lo.CodLoc and numeje = @numeje and l.codlib = @codlib)
end 
GO
select dbo.sala6('l01',1) as 'Sala'
GO
select l.codlib,titulo,dbo.sala6(c.codloc,2) from Ejemplar e, Localidad c, Libro l where l.codlib=e.codlib and e.CodLoc=c.codloc group by titulo,sala,c.codloc,l.codlib 
GO
drop function dbo.sala6
GO

-- Listar codigo y titulo de los libros usando una funcion de tabla
create function libros()
returns table
	as 
		return(select codlib, titulo from libro)
GO
select * from libros()
GO
drop function dbo.libros
GO

-- Listar codigo y titulo de los libros usando una funcion de tabla
create function libros1()
returns @tmp table (codlib char(3), titulo varchar(50))
	as 
		begin
			insert into @tmp 
			select codlib, titulo from libro
			return
end
GO
select * from libros1()
GO
drop function dbo.libros1
GO

-- Listar codigo y titulo de los libros usando una funcion de tabla
create function libros2()
returns @tmp table (codlib char(3), titulo varchar(50))
	as 
		begin 
			declare @codlib char(3)
			declare @titulo varchar(50)
			insert into @tmp values (@codlib, @titulo)
			return
end
GO
select * from libros2()
GO
drop function dbo.libros2
GO

-- Listar el nombre del escritor y su nacionalidad (Colombiano, Ecuatoriano, etc., usando una funciones de tabla
create function listautor()
returns table
	as
		return (select nomaut as 'Nombre Autor', 
				  case nacaut when 'CO' then 'Colombiano'
							  when 'FR' then 'Frances'
							  when 'EC' then 'Ecuatoriano'
							  else 'ND'
end as 'Nacionalidad' from Autor)
GO
select * from listautor()
GO
drop function dbo.listautor
GO

-- Dado un codigo de usuario, listar lo siguiente: nombre y apellido, total libros prestados, total multas usando funciones de tabla
create function multas6(@codusu char(3))
returns table
	as
		return (select u.nomusu + ' ' + u.apeusu as 'Nombre',
			    COUNT(p.codlib) as 'Libros Prestados', TotalMulta as 'Multa'
				from Usuarios u,Prestamo p, Ejemplar e
				where @codusu=p.codusu and u.codusu=p.codusu and p.codlib=e.codlib and p.numeje=e.numeje
				group by p.codlib,u.nomusu,u.apeusu,TotalMulta)
GO
select * from multas6('U01')
GO
drop function dbo.multas6
GO

create function info1(@codusu char (3))
returns table
	as
		return (select nomusu + ' '+ apeusu as 'Nombre Usuario',(select COUNT (codusu)
		        from prestamo p where u.codusu = p.codusu) as 'Libros prestados',
				TotalMulta from Usuarios u where codusu=@codusu
)
GO
select *  from info1('U01')
GO
drop function info1
GO