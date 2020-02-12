/* Base de Datos: Administraci�n de una libreria.
   Tablas: Autor: C�digo Autor (codaut), Nombre Autor (nomaut), Apellido Autor (apeaut), Nacionalidad Autor (nacaut), Fecha Nacimiento (fech_nac).
		   Ejemplar: N�mero Ejemplar (numeje), C�digo Libro (codlib), Costo Ejemplar (costoejem), Disponibilidad (disponible), C�digo Localiad (codloc).
		   Escribe: C�digo Autor (codaut), C�digo Libro (codlib), Fecha Escritura (fecesc).
		   Libro: C�digo Libro (codlib), Titulo Libro (titulo), ISBN (isbn), Fecha Publicaci�n (fecpub), Editorial (editorial), N�mero Paginas (numpag).
		   Localidad: C�digo Localiad (codloc), Estanteria (estanteria), Sala (sala), Piso (piso).
		   Prestamo: C�digo Usuario (codusu), N�mero Ejemplar (numeje), C�digo Localiad (codloc), Fecha Prestamo (fecpre), Fecha Devoluci�n (fecdev).
		   T1: XXXX (a), YYYY (b), ZZZZ (c).
		   T2: ZZZZ (c), ABCD (d).
		   Telusu: C�digo Usuario (codusu), N�mero Telefono (numtel), Operadora (operadora).
		   Telusu1: C�digo Usuario (codusu), N�mero Telefono (numtel).
		   Usuarios: C�digo Usuario (codusu), Nombre Usuario (nomusu), Apellido Usuario (apeusu), Fecha Registro (fecreg), Direcci�n Usuario (dirusu), Multas (totalmulta), Garate (garante), Genero (genero).
*/

-- INNER JOIN: Selecciona registros que tienen valores coincidentes en ambas tablas.

-- Lista los nombres de autores, libros, costo y n�mero de ejemplares.
select nomaut + ' ' + apeaut as 'Autor',
       (select titulo from libro l where l.codlib = e.codlib and a.codaut = e.codaut) as 'Nombre Libro',
	   (select convert(numeric(9,6), avg(costoejem)) from Ejemplar j where j.codlib = e.codlib and a.codaut = e.codaut) as 'Costo Ejemplar',                                 
	   (select COUNT(codlib) from escribe e where a.codaut = e.codaut ) as '# de Libros'
from Autor a inner join escribe e on e.codaut=a.codaut

select nomaut + ' ' + apeaut as'Autor',
       titulo as 'Nombre Libro',
	   avg(j.costoejem) as 'Costo Ejemplar',
	   (select COUNT(e1.codlib) from escribe e1 where e1.codaut = a.codaut ) as '# de Libros'
from Autor a, escribe e, Libro l, Ejemplar j
where a.codaut = e.codaut and l.codlib = j.codlib and e.codlib = l.codlib group by a.codaut, a.nomaut, a.apeaut, titulo

-- Mostrar que estanter�as tienen m�s de 2 libros del mismo autor, el piso donde se encuentra y su respectiva sala.
select Titulo as 'Titulo Libro',
       (select COUNT(E.codaut) from Escribe E where E.codaut = A.codaut having count(e.codaut)>=2) as 'Ejemplares',
	   'Estanteria'= CASE A.codaut WHEN A.codaut THEN Estanteria ELSE null END,
	   'Sala'= CASE A.codaut WHEN A.codaut THEN Sala ELSE null END,
	   'Piso'= CASE A.codaut WHEN A.codaut THEN Piso ELSE null END
from (Autor A inner join  Escribe e ON ( A.codaut = E.codaut ) inner join Libro l ON (L.codlib = E.codlib) inner join Ejemplar m ON (L.codlib = m.codlib) inner join Localidad d ON (m.codloc = d.codloc))
group by A.codaut,L.codlib,L.Titulo,E.codaut,Estanteria,Sala,Piso