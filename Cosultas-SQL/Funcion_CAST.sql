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
-- CAST: Convierta un valor a un tipo de datos int.

-- Redondeo del libro mediante CAST.    
select codlib as'codigo libro', costoejem as 'costo',
CAST(ROUND((costoejem/2),0) as int) as 'mitad costo' 
from Ejemplar