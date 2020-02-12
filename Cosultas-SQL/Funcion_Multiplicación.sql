-- Crear función que permita multiplicar dos números
create function multiplica (@a numeric(9,1), @b numeric (9,1))
returns numeric (14,1)
	as
		begin
			declare @c numeric(14,1)
			set @c = @a * @b
			return @c
end
GO

-- Utilización de la función
select dbo.multiplica(3,5)
GO
-- Visulizar las propiedades de la funcion
SELECT sm.object_id, OBJECT_NAME(sm.object_id) AS object_name, o.type, o.type_desc, sm.definition,  
	   sm.uses_ansi_nulls, sm.uses_quoted_identifier, sm.is_schema_bound, sm.execute_as_principal_id  
FROM sys.sql_modules AS sm JOIN sys.objects AS o ON sm.object_id = o.object_id   
WHERE sm.object_id = OBJECT_ID('dbo.multiplica') ORDER BY o.type;
GO

-- Permite borrar la funcion
drop function multiplica
GO