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

-- GETDATE: Devuelve la fecha y hora actual del sistema de base de datos.

-- Funcion Obtener Fecha.
select GETDATE()

-- Obtener la los a�os hace cuanto fue escrito un libro.
select codlib, 'fue escrito hace: ' as ' ', 
DATEDIFF(year,fecesc,GETDATE())as 'a�os'
from escribe where codlib='L01'

-- Funciones del sistema. Listar el nombre de usuario y de login.
select USER_NAME() as 'usuario',
       SUSER_NAME() as 'login',
       CURRENT_USER, SESSION_USER , SYSTEM_USER
       


