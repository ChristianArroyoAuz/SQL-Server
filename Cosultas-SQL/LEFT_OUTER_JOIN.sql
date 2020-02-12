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
-- LEFT OUTER JOIN: ealiza una uni�n que comienza con la primera tabla (m�s a la izquierda) y luego cualquier segundo registro de tabla coincidente (m�s a la derecha).

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