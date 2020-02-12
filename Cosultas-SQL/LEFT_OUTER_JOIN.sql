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
-- LEFT OUTER JOIN: ealiza una unión que comienza con la primera tabla (más a la izquierda) y luego cualquier segundo registro de tabla coincidente (más a la derecha).

-- Listar Nombre del Autor, Titulo, Fecha de publicacion, Cuanto Tiempo Transcurrido desde la publicacion, Numero de Ejemplar, Costo libro (promedio), EStanteria (Sala y Piso).
select A.nomaut + A.apeaut as 'Nombre del Autor',
       Titulo as 'Titulo del Libro',
	   fecpub as 'Fecha Publicacion',
	   (DATEDIFF(year,fecpub,GETDATE())) AS 'Tiempo Transcurrido',
	   (select COUNT(E.codaut) from Escribe E where E.codaut=A.codaut) as 'Numero de Ejemplares',
	   (select CONVERT (numeric(9,2),AVG(costoejem)) from Ejemplar Y where Y.codlib=E.codlib and A.codaut=E.codaut) as 'Costo Promedio Libro',
	   Estanteria, Sala, Piso
from (Autor A left outer join  Escribe E ON (A.codaut = E.codaut) full join Libro L ON (L.codlib = E.codlib) full join Ejemplar Y ON (L.codlib = Y.codlib) full join Localidad X ON (Y.codloc=X.codloc))
group by A.codaut, A.nomaut, A.apeaut, L.codlib, L.fecpub, L.Titulo, E.codaut, E.codlib, Estanteria, Sala, Piso
order by A.nomaut + A.apeaut desc