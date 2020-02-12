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

-- CRETATE RULE: Crea un objeto llamado regla. Cuando est� vinculado a una columna o un tipo de datos de alias, una regla especifica los valores aceptables que se pueden insertar en esa columna.
-- DROP RULE: Borra la regla creada.
-- SP_BINDRULE : Asocia la regla creada a una columna de una tabla especificada.
-- SP_UNBINDRULE : Desasocia la regla creada de la columna de la tabla a la cual estaba asociada.
-- GO: Se�ala el final de un lote de instrucciones Transact-SQL a las utilidades de SQL Server.

-- Permite crear la regla para la columna de n�meros y as� establecer un formato especifico de n�meros de telefono.
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