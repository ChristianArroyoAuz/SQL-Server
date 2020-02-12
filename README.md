# SQL-Server

Base de Datos: Administraci�n de una libreria.

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

Creacion Base:
	1) Creaci�n de las tablas de usuario.
	2) Ingreso de Datos de datos.
	3) Modificaci�n de datos.
	4) Creaci�n de tablas temporales.
	5) Actualizaci�n datos de tablas.
	6) Eliminaci�n datos tabla.

Consultas Basicas:
	1) Listar los numeros de telefono celular que empiezen con 08 y 09.
	2) Listar los nombres de los usuarios y  ordenarlos por genero en forma descendente.
	3) Mostrar la nacionalidad de los autores y la cantidad de autores por nacionalidad.
	4) Mostrar la nacionalidad de los autores y la cantidad de autores por nacionalidad para aquellos mayores o iguales a 2 autores.
	5) Cuantos Autores existen por nacionalidad para aquellos mayores o iguales a 2 autores y aquellos autores deben ser mayor a 30 a�os.
	6) Listar el nombre, apelido y nacionalidad del autor y poner nombre completo a la ciudad.
	7) Intersecci�n entre dos tablas, donde el codigo de usuario es el mismo y las operadoras tiene la letra ACM.
	8) Lista nombre cuya primera letra es J.
	9) Lista los nombre cuya primera letra es J y 5 letras m�s.
	10) Lista los nombre cuya primera letra no sea G.
	11) Lista los nombres cuya primera letra es A, F o J.
	12) Lista los nombres cuya primera letra no es A, F o J.
	13) Listar los nombre cuya primera letra sea desde la G hasta la M.
	14) Seleccionar libro cuyo c�digo sea L03 o titulo empice con H y n�mero de paginas sea mayor a 200 paginas.
	15) Listar los autores, nacionalidades y libros que tengan fechas de publicaciones >=1990 y que esten ordenados por el numero de paginas en orden descendiente.
	16) Listar los libros, sus costos y su # de paginas tal que Costo <=30 y Paginas<=300.
	17) Listar el nombre del usuario y especificar  si es garante de otro usuario.
	18) Listar el nombre de usuario y quien es el garante, el nombre del libro que llevo prestado, la fecha en la cual fue preestado  y el tiempo que le queda para entregarlo.
	19) Listar los libros que se encuentran en la Estanteria 1, su costo y el numero de paginas. Ordenar por costo, tal que el costo sea entre 25 y 30.
	20) Listar el nombre de autor, el libro que escribio, si el libro esta prestado poner el nombre de usuario que lo alquilo, ademas poner la fecha de prestamo y la fecha de devolucion. Si el libro esta disponible hacer que aparezca "disponible".
	21) Listar la estanteria, sala, piso, c�digo autor y numero de libros mayores a 1 en cantidad.
	22) Listar el costo de los libros incluido 12% del iva.
	23) Listar el codigo del libro y el precio dividido por 2 de Ejemplar.
	24) Redondeo del coste de libro.
	25) Elevar al cuadrado el precio del libro.
	26) Manejo de caracteres.
	27) Establecimiento de cabeceras.

Consultas Avanzadas:
	1) Fucnion_DATEDIFF: Selecci�n de la Nacioalidad, Nombre, Apellido y Fecha de nacimiento del Autor. Finalmente, calcular la edad del Autor a la fecha actual y mostrar los mayores de 30 a�os.
	2) CREATE_RULE: Regla para establecer el formato del n�mero celuar de los usuarios.
			Visualizar reglas creadas.
	3) Convert_Numeric_Avg: Obtener el promedio del coste de libros cuyo c�digo sea L01.
	4) INNER_JOIN: Lista los nombres de autores, libros, costo y n�mero de ejemplares.
                       Mostrar que estanter�as tienen m�s de 2 libros del mismo autor, el piso donde se encuentra y su respectiva sala.
	5) LEFT OUTER JOIN: Listar Nombre del Autor, Titulo, Fecha de publicacion, Cuanto Tiempo Transcurrido desde la publicacion, Numero de Ejemplar, Costo libro (promedio), EStanteria (Sala y Piso)
	6) Multiplicaci�n: Crear funci�n que permita multiplicar dos n�meros.
	7) Consulta Base: consulta a la base de datos mediante funciones.
	8) GETDATE: Funcion Obtener Fecha.
		    Obtener la los a�os hace cuanto fue escrito un libro.
                    Funciones del sistema. Listar el nombre de usuario y de login.
	9) CAST: Redondeo del libro mediante CAST.
	10) SUM: Sumar en n�mero de painas de los libros de un autor.