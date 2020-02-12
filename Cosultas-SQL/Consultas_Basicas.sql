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

-- Listar los numeros de telefono celular que empiezen con 08 y 09.
select 'El Telefono del ' + codusu + ' es: '+ numtel as' Lista de Números Celulares'
from telusu where numtel like '09%' or  numtel like '08%'

-- Listar los nombres de los usuarios y  ordenarlos por genero en forma descendente.
select nomusu as 'Nombre', genero
from Usuarios order by genero desc

-- Mostrar la nacionalidad de los autores y la cantidad de autores por nacionalidad.
select nacaut as 'Nacionalidad', 
	   COUNT(codaut) as 'Cantidad de Autores'
from Autor group by nacaut

-- Mostrar la nacionalidad de los autores y la cantidad de autores por nacionalidad para aquellos mayores o iguales a 2 autores.
select nacaut as 'Nacionalidad',
       COUNT(codaut) as 'Cantidad de Autores'
from Autor group by nacaut having COUNT(codaut)>= 2

-- Cuantos Autores existen por nacionalidad para aquellos mayores o iguales a 2 autores y aquellos autores deben ser mayor a 30 años.
select nacaut as 'Nacionalidad',
	   COUNT(nacaut) as 'Cantidad de Autores'
from Autor where DATEDIFF(year,fech_nac,GETDATE())>= 30 group by nacaut having COUNT(nacaut)>=2

-- Listar el nombre, apelido y nacionalidad del autor y poner nombre completo a la ciudad
select Nombre= nomaut + ' ' + apeaut,
	   Nacionalidad = CASE nacaut
	                  WHEN 'FR' THEN 'FRANCIA'
					  WHEN 'EC' THEN 'ECUADOR'
					  WHEN 'CO' THEN 'COLOMBIA'
					  WHEN 'SU' THEN 'SUIZA'
					  WHEN 'UR' THEN 'URUGUAY'
					  ELSE 'NO DEFINIDO'
					  END
from Autor order by nacaut

-- Intersección entre dos tablas, donde el codigo de usuario es el mismo y las operadoras tiene la letra ACM
select nomusu +' ' + apeusu as 'Usuario',
       operadora as 'Operadora',
	   count(operadora) as 'Total Lìneas'
from usuarios u, telusu t where u.codusu = t.codusu and Operadora like '[ACM]' group by nomusu,apeusu,operadora

select nomusu + ' ' + apeusu as 'Usuario',
	   (select COUNT (operadora) from telusu t where t.codusu=u.codusu and operadora='A')as 'CNT',
	   (select COUNT (operadora) from telusu t where t.codusu=u.codusu and operadora='M')as 'Movistar',
	   (select COUNT (operadora) from telusu t where t.codusu=u.codusu and operadora='C')as 'Claro',
	   (select COUNT (operadora) from telusu t where t.codusu=u.codusu and operadora like'[^ACM]-')as 'Otras'
from Usuarios u group by u.nomusu, u.apeusu, u.codusu

-- Lista nombre cuya primera letra es J.
select nomaut from Autor where nomaut like 'J%'

-- Lista los nombre cuya primera letra es J y 5 letras más.
select nomaut from Autor where nomaut like 'J____'

-- Lista los nombre cuya primera letra no sea G.
select nomaut from Autor where nomaut like '[^G]%'

-- Lista los nombres cuya primera letra es A, F o J.
select nomaut from Autor where nomaut like '[AFJ]%'

-- Lista los nombres cuya primera letra no es A, F o J.
select nomaut from Autor where nomaut like '[^AFJ]%'

-- Listar los nombre cuya primera letra sea desde la G hasta la M.
select nomaut from Autor where nomaut like '[G-M]%'

-- Seleccionar libro cuyo código sea L03 o titulo empice con H y número de paginas sea mayor a 200 paginas.
select codlib, titulo, numpag from Libro where (titulo like 'H%' or codlib='L03' and numpag>200)

-- Listar los autores, nacionalidades y libros que tengan fechas de publicaciones >=1990 y que esten ordenados por el numero de paginas en orden descendiente.
select Autor = A.nomaut + ' ' + A.apeaut,
       Nacionalidad = CASE E.codaut WHEN E.codaut THEN A.nacaut ELSE 'NO DEFINIDO' END,
	   Libro = Titulo,
	   'Fecha Publicacion'= CASE L.codlib WHEN L.codlib THEN L.fecpub ELSE 'NO DEFINIDO' END,
	   Paginas= CASE L.codlib WHEN L.codlib THEN L.numpag ELSE 'NO DEFINIDO' END
from Libro L, Escribe E, Autor A where L.codlib = E.codlib and E.codaut = A.codaut and L.fecpub >= '1990' Order by numpag desc

-- Listar los libros, sus costos y su # de paginas tal que Costo <=30 y Paginas<=300.
select titulo as 'Libro',
       costoejem as 'Costo',
	   numpag as '# Paginas'
from Libro l, Ejemplar e where costoejem <= 30 and numpag <= 300 group by titulo, numpag, costoejem

--Listar el nombre del usuario y especificar  si es garante de otro usuario.
select distinct u.nomusu + ' '+ u.apeusu as 'Nombre Usuario',
	   Garante = Case When o.garante = u.codusu then 'Si es garante' else 'No' end
from Usuarios u,Usuarios o where o.garante = u.codusu

-- Listar el nombre de usuario y quien es el garante, el nombre del libro que llevo prestado, la fecha en la cual fue preestado  y el tiempo que le queda para entregarlo.
select nomusu + ' ' + apeusu as 'Nombre Usuario',
       titulo as 'Titulo Libro',
	   fecpre as 'Fecha Prestamo',
       DATEDIFF(day, fecpre, fecdev) as 'Días Restantes'
from Usuarios u, Libro l, prestamo p
where p.codusu = u.codusu and p.codlib = l.codlib

-- Listar los libros que se encuentran en la Estanteria 1, su costo y el numero de paginas. Ordenar por costo, tal que el costo sea entre 25 y 30.
select distinct Titulo as 'Titulo Libro',
                Numpag as '# de Paginas',
				Estanteria as 'Estanteria',
				costoejem as 'Costo Ejemplar'
from Libro l, Localidad d, Ejemplar e
where Estanteria = 'Estanteria1' and e.CodLoc = d.CodLoc and e.codlib = l.codlib and (costoejem >= 25 and costoejem <= 30) order by costoejem

-- Listar el nombre de autor, el libro que escribio, si el libro esta prestado poner el nombre de usuario que lo alquilo, ademas poner la fecha de prestamo y la fecha de devolucion. Si el libro esta disponible hacer que aparezca "disponible".
select a.nomaut + ' ' + a.apeaut as 'nombre de Autor',
       l.titulo as 'Titulo Libro',
	   (select case disponible when 'S' then 'No' when 'N' then 'Si' end from ejemplar ej1 where ej1.codlib = ej.codlib and ej1.numeje = ej.numeje ) as'Se encuentra prestado?',
	   fecpre as 'Fecha Prestamo',
	   fecdev as 'Fecha Devolucion',
	   Disponible = case disponible when 'S' then 'Si' when 'N' then 'No' end
from Autor a, escribe e, Libro l, Ejemplar ej, prestamo p, Usuarios u
where a.codaut = e.codaut and e.codlib = l.codlib and e.codlib = ej.codlib and ej.codlib = p.codlib and ej.numeje = p.numeje and p.codusu = u.codusu

-- Listar la estanteria, sala, piso, código autor y numero de libros mayores a 1 en cantidad.
 select estanteria as 'Estanteria', sala 'Sala', piso as 'Piso', nomaut as'Nombre Autor', count(li.codlib) as '# de Libros'
 from Localidad l, Ejemplar ej, Libro li, escribe e, Autor a
 where l.CodLoc =ej.CodLoc and ej.codlib = li.codlib and li.codlib = e.codlib and e.codaut = a.codaut
 group by nomaut,Piso,Sala,estanteria,li.codlib having count(li.codlib) >= 1

 -- Listar el costo de los libros incluido 12% del iva.
select codlib as 'codigo libro', costoejem as 'costo',
       (costoejem*1.12) as 'costo mas iva'
from Ejemplar

-- Listar el codigo del libro y el precio dividido por 2 de Ejemplar.
select codlib as 'codigo libro', costoejem as 'costo',
       (costoejem/2) as 'mitad costo'
from Ejemplar

-- Redondeo del coste de libro.
select codlib as 'codigo libro', costoejem as 'costo',
       round (costoejem/2,0) as 'mitad costo'
from Ejemplar

-- Elevar al cuadrado el precio del libro.
select codlib as 'codigo libro', costoejem as 'costo',
       POWER (costoejem,2) as 'mitad costo'
from Ejemplar

-- Manejo de caracteres.
select SUBSTRING(nomaut,1,1)+'.'+ apeaut 'Inicial Apellido'
from Autor

select SUBSTRING(nomaut,1,1)+'.'+ SUBSTRING(apeaut,1,1) as 'Iniaciales Nombres y Apellidos'
from Autor

-- Estableciendo cabezeras.
select 'nombre del autor' as 'literal' , 
nomaut as 'nombre'
from Autor

select literal='nombre del autor', nombre=nomaut
from Autor

-- Consultas Varias
select distinct nomaut + apeaut, c.codaut as 'Autor'
from (escribe c right outer join autor A on c.codaut=a.codaut)
where c.codaut is null

select titulo,codaut as 'Autor'
from (Libro L left outer join escribe E on L.codlib=E.codlib)
where codaut is NULL
 
select distinct o.nomusu + o.apeusu as 'Nombre de Usuario'
from usuarios o, Usuarios u
where o.dirusu=u.dirusu and o.nomusu <> u.nomusu

select distinct o.nomusu + o.apeusu as 'Nombre de Usuario'
from usuarios o inner join Usuarios u on o.dirusu=u.dirusu
where u.nomusu='Diego' and u.apeusu='Lopez'

select distinct o.nomusu + o.apeusu as 'Nombre de Usuario'
from usuarios o, Usuarios u
where o.dirusu=u.dirusu and u.nomusu='Diego'

select nomusu + apeusu,
       'vive en',
	   (select dirusu from Usuarios where nomusu = 'Diego' and apeusu ='Lopez')
from Usuarios

select nomusu + apeusu from Usuarios
where dirusu in (select dirusu from usuarios where nomusu='Dieago' and apeusu='Lopez')