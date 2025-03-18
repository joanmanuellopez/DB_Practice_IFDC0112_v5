/*
12345678901234567890123456789012345678901234567890123456789012345678901234567890
         1         2         3         4         5         6         7         8
*/

/* ************************************************************************** **
Explorando la tabla de productos
** ************************************************************************** */
USE [AdventureWorks2022]; --La finalidad es simplificar la referencia a tablas. 
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT *   FROM [Production].[Product]

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

-- 00 ¿Cuántos productos tengo? (504)
select count(*) FROM Production.Product;

-- 01 investiga la columna ProdutNumber
-- 01.01 ¿Cuántas familias de producto tenemos? (85)
--       Considera que las dos primeras letras del número de producto se refieren a la familia de producto. 
        
select count(DISTINCT LEFT(ProductNumber,2)) FROM Production.Product;
-- 01.02 ¿cuantos productos tenemos por familia?


SELECT LEFT(ProductNumber, 2) as familia, count(*) as productos FROM Production.Product
GROUP BY LEFT(ProductNumber, 2)
ORDER BY productos DESC;

-- 01 investiga la columna MakeFlag
select distinct MakeFlag from Production.Product; -- 0,1

-- 02 investiga la columna FinishedGoodsFlag
select distinct FinishedGoodsFlag from Production.Product; -- 0,1

select  STRING_AGG(cast(color_unico AS NVARCHAR), ',') as lista_colores
from (select distinct color as color_unico from Production.Product) as colores_unicos;
-- lista en orden inverso los diferentes colores de fabricación para el grupo.

select  STRING_AGG(cast(color_unico AS NVARCHAR), ',') WITHIN GROUP (ORDER BY color_unico DESC) AS lista_colores
from (select distinct color as color_unico from Production.Product) as colores_unicos;
/*
Paso 1: Subconsulta
-- La primera parte de la consulta es la subconsulta dentro del FROM:

	(SELECT DISTINCT color AS color_unico FROM Production.Product) AS colores_unicos;
		Detalles:
		--	SELECT DISTINCT:Se utiliza para obtener una lista única de colores (color) en la tabla Production.Product.
			La función DISTINCT elimina duplicados, asegurando que cada color aparece solo una vez.
			Si se elimina DISTINCT incluirá colores duplicados, afectando resultado final de STRING_AGG al concatenar colores redundantes.

		--  Alias color_unico:mejora la legibilidad del código, indicando que los datos han sido depurados para incluir solo colores únicos.

		--  Alias de tabla colores_unicos:La subconsulta completa recibe el alias colores_unicos. 
			Este nombre transmite que esta tabla temporal contiene exclusivamente colores únicos, 
			lo que facilita su referencia en la consulta principal.	
			Si se omite el alias colores_unicos Generará un error porque SQL Server requiere un alias para las subconsultas.	


Paso 2: STRING_AGG (Concatenación de Colores)
En la consulta principal, se utiliza la función STRING_AGG para concatenar los valores únicos obtenidos de la subconsulta:


	STRING_AGG(CAST(color_unico AS NVARCHAR), ',') WITHIN GROUP (ORDER BY color_unico DESC) AS lista_colores
		Detalles:
		-- STRING_AGG(CAST(color_unico AS NVARCHAR), ','):STRING_AGG es una función de agregación que combina valores 
		   en una sola cadena de texto, separándolos con un delimitador (en este caso, una coma ,).

		-- Se utiliza CAST para asegurarse de que color_unico es del tipo NVARCHAR, lo cual es importante para evitar errores 
		   si color originalmente es un tipo de datos distinto.Si no se usa CAST, Podrían ocurrir problemas de compatibilidad
		   si el tipo de datos de color_unico no es compatible con el procesamiento de cadenas.
		   
		-- WITHIN GROUP (ORDER BY color_unico DESC):Este segmento especifica el orden en que se concatenarán los colores.
		   ORDER BY color_unico DESC asegura que los colores se ordenen de manera descendente (alfabéticamente inversa)
		   antes de ser concatenados. Si se elimina WITHIN GROUP (ORDER BY ...) los colores se concatenarán en un orden arbitrario, 
		   dependiendo de cómo SQL Server lea los datos.
		   		
		-- Alias lista_colores:Se asigna el alias lista_colores al resultado de STRING_AGG, describiendo claramente su propósito: una lista de colores concatenados.


Resumen: Orden de las Palabras Clave
El orden de las palabras en esta consulta es crucial porque sigue el flujo lógico del procesamiento de consultas en T-SQL. Así se evaluará la consulta:

Subconsulta (FROM):

Primero se ejecuta la subconsulta para obtener los colores únicos.

Agregación (STRING_AGG):

Luego, los valores de la subconsulta se concatenan utilizando la función STRING_AGG.

Orden (WITHIN GROUP):

Los valores se ordenan ANTES de ser concatenados.

Proyección (AS lista_colores):

Finalmente, el resultado se presenta con un alias legible.

Si se altera este orden, la consulta puede arrojar resultados incorrectos, errores de sintaxis o un comportamiento inesperado.
*/

SELECT *   FROM [Production].[Product]; -- 0,1

