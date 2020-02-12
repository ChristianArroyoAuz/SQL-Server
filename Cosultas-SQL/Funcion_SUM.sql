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

--SUM: Devuelve la suma de todos los valores, o solo los valores DISTINCT, en la expresión. SUM solo se puede usar con columnas numéricas. Los valores nulos se ignoran.

-- Sumar el numero de paginas de los libros de un autor
select nomaut + ' ' + apeaut as 'nombre',
       (select SUM(numpag) from Libro) as 'Total de paginas'
from Autor
	
select nomaut + ' ' + apeaut as 'nombre',
	   (select SUM(numpag) from escribe e,
	   Libro l where e.codlib = l.codlib and e.codaut=a.codaut) as 'Total de paginas'
from Autor a
	
select u.nomusu + ' ' + u.apeusu as 'Nombre Usuario',
      (select COUNT(numtel) from Telusu t where u.codusu=t.codusu) as 'Total de Telefonos'
from Usuarios u