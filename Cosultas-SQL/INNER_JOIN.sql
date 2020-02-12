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

-- INNER JOIN: Selecciona registros que tienen valores coincidentes en ambas tablas.

-- Lista los nombres de autores, libros, costo y número de ejemplares.
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

-- Mostrar que estanterías tienen màs de 2 libros del mismo autor, el piso donde se encuentra y su respectiva sala.
select Titulo as 'Titulo Libro',
       (select COUNT(E.codaut) from Escribe E where E.codaut = A.codaut having count(e.codaut)>=2) as 'Ejemplares',
	   'Estanteria'= CASE A.codaut WHEN A.codaut THEN Estanteria ELSE null END,
	   'Sala'= CASE A.codaut WHEN A.codaut THEN Sala ELSE null END,
	   'Piso'= CASE A.codaut WHEN A.codaut THEN Piso ELSE null END
from (Autor A inner join  Escribe e ON ( A.codaut = E.codaut ) inner join Libro l ON (L.codlib = E.codlib) inner join Ejemplar m ON (L.codlib = m.codlib) inner join Localidad d ON (m.codloc = d.codloc))
group by A.codaut,L.codlib,L.Titulo,E.codaut,Estanteria,Sala,Piso