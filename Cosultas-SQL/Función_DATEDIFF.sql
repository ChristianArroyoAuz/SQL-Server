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

-- DATEDIFF: Esta funci�n devuelve el recuento (como un valor entero con signo) de los l�mites de parte de fecha especificados cruzados entre la fecha de inicio y la fecha de finalizaci�n especificadas .

-- Selecci�n de la Nacioalidad, Nombre, Apellido y Fecha de nacimiento del Autor. Finalmente, calcular la edad del Autor a la fecha actual y mostrar los mayores de 30 a�os.
select nacaut as 'Nacioalidad',
	   nomaut + ' ' + apeaut as 'Nombre',
	   fech_nac as 'Fecha de Nacimiento',
	   DATEDIFF(year, fech_nac,GETDATE()) as 'Edad'
from Autor where DATEDIFF(year, fech_nac,GETDATE())>= '30'