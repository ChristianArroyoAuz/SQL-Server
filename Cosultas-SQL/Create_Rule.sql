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

-- CRETATE RULE: Crea un objeto llamado regla. Cuando está vinculado a una columna o un tipo de datos de alias, una regla especifica los valores aceptables que se pueden insertar en esa columna.
-- DROP RULE: Borra la regla creada.
-- SP_BINDRULE : Asocia la regla creada a una columna de una tabla especificada.
-- SP_UNBINDRULE : Desasocia la regla creada de la columna de la tabla a la cual estaba asociada.
-- GO: Señala el final de un lote de instrucciones Transact-SQL a las utilidades de SQL Server.

-- Permite crear la regla para la columna de números y así establecer un formato especifico de números de telefono.
create rule r_num as @numtel like '[0][5689]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
GO
sp_bindrule r_num,'telusu1.numtel'
GO
sp_unbindrule 'telusu1.numtel'
GO
drop rule r_num
GO

-- Permite visualizar las reglas creadas que empiezan con r
select * from sys.objects where type='r'