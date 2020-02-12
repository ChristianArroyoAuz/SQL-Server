insert into T1 values ('e',2,'4')

insert into T1 (a,b) values ('f',8)

insert into T1 (a,c) values ('f','2') -- me da un error porque c no admite null

insert into T1 (a,b) values ('g',8) -- uk no permite el ingreso de dos valores null en C

insert into T1 values ('g',default,null) -- b es not null y el default se aplica si no es
										 --	es explicito para definiciones null
insert into T1 values ('g',8,null) -- error en C ya existe un Null

alter table T1 add d integer identity (1,1) -- Forza a que la columna d sea not null

insert into T1 values ('g',5,8) -- Identity tiene un valor de 7

delete from T1 where a='g' -- Borrar fila
alter table T1 drop column d -- Borrar columna 

insert into T1 values ('g',5,8) -- Despues de borrar la columna y volver a insertar la columna
							    -- inserta el valor 8

dbcc checkident (T1,reseed,6) -- Para volver a insertar el numero 7
insert into T1 values ('g',5,8) -- Vuelve a ingresar el valor 7

alter table T1 add e timestamp -- Agrega numero binarios del sistema

select * into #tmp  /* Genera una tabla temporal*/
from T1             /* una tabla temporal*/

select * from #tmp  -- Para ver la tabla temporal

select * into T3 from T1 where 1=2 -- Copia una tabla con otro nombre bajo las condiciones dadas

select * from T3 -- Para ver la tabla copiada

select * into ##tmp from T1 -- Para copiar la tabla desde T1

select * from #tmp -- Puede ser vista desde la sesion actual

select * from ##tmp -- Puede ser vista desde otra sesion

insert into T3   /* Copiar los datos de la tabla T1 a */

select * from T1 /* la tabla T3 */

delete from T3 -- Borra toda la tabla T3

insert into T3   -- Copiar tabla con condiciones
select * from T1
where c>3
order by c desc

insert into T3   -- Copiar tabla con condiciones
select a,b from T1
where c>3

update T1  -- Update Datos solo para la fila 1
set b=2
where a='a'

update T1  -- Update Datos solo para toda la columna b
set b=2

drope table T1
insert into T1
select * from #tmp


select * from T1
select * from T3

