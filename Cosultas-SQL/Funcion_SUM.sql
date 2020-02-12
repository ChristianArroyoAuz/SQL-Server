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

--SUM: Devuelve la suma de todos los valores, o solo los valores DISTINCT, en la expresi�n. SUM solo se puede usar con columnas num�ricas. Los valores nulos se ignoran.

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