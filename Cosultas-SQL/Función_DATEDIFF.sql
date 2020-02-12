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

-- DATEDIFF: Esta función devuelve el recuento (como un valor entero con signo) de los límites de parte de fecha especificados cruzados entre la fecha de inicio y la fecha de finalización especificadas .

-- Selección de la Nacioalidad, Nombre, Apellido y Fecha de nacimiento del Autor. Finalmente, calcular la edad del Autor a la fecha actual y mostrar los mayores de 30 años.
select nacaut as 'Nacioalidad',
	   nomaut + ' ' + apeaut as 'Nombre',
	   fech_nac as 'Fecha de Nacimiento',
	   DATEDIFF(year, fech_nac,GETDATE()) as 'Edad'
from Autor where DATEDIFF(year, fech_nac,GETDATE())>= '30'