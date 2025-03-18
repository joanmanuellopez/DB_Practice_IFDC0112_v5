/*
 Nombre: 05_resumiendo con ROLLUP() y CUBE()
 Autor: Luis MIguel Casado D�az
 Created: 2025-03-15
 Last Modified: 2025-03-15 by Jane Smith
 Prop�sito: Explicar el funcionamiento de la cluausula ROLLUP().
 Version: 1.1

Finalidad de ROLLUP() en SQL Server
La funci�n ROLLUP() se utiliza en la cl�usula GROUP BY.
La usamos para generar subtotales y totales jerarquizados en un conjunto de resultados.

Permite analizar datos en m�ltiples niveles de agregaci�n, lo que es �til para 
informes y an�lisis de datos.

La syntaxis es 
SELECT columna1, columna2, ..., funci�n_agregada(columna_agregada)
FROM tabla
GROUP BY ROLLUP (columna1, columna2, ...);


El orden en que escribimos las columnas importa.
Podemos escribir las columnas ordenadas en dos partes de la instruccion

Considerando solo dos columnas estado_civil y g�nero

Tenemos estas combinaciones
SELECT		GROUP BY ROLLUP()
G M			G M
G M			M G
M G			M G
M G			G M
*/

SELECT Gender, MaritalStatus, count(*) AS Empleados
FROM [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY ROLLUP (Gender, MaritalStatus);

/*
Gender	MaritalStatus	TotalVentas
F		M				49
F		S				35
F		NULL			84
M		M				97
M		S				109
M		NULL			206
NULL	NULL			290
*/
SELECT Gender, MaritalStatus, count(*) AS Empleados
FROM [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY ROLLUP (MaritalStatus, Gender);

/*
Gender	MaritalStatus	Empleados
F		M				49
M		M				97
NULL	M				146
F		S				35
M		S				109
NULL	S				144
NULL	NULL			290
*/

SELECT MaritalStatus, Gender, count(*) AS Empleados
FROM [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY ROLLUP (MaritalStatus, Gender);

/*
MaritalStatus	Gender	TotalVentas
M				F		49
M				M		97
M				NULL	146
S				F		35
S				M		109
S				NULL	144
NULL			NULL	290
*/

SELECT MaritalStatus, Gender, count(*) AS Empleados
FROM [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY ROLLUP (Gender, MaritalStatus);


/*
MaritalStatus	Gender	TotalVentas
M				F		49
S				F		35
NULL			F		84
M				M		97
S				M	1	09
NULL			M	2	06
NULL			NULL	290
*/

/*
Para ayudarnos a identificar qu� fila es un subtotal, podemos a�adir
columnas al resultado de nuestra consulta con la funci�n GROUPING( columna)
QUe nos marcar� con un uno la fila que sitei un sibtotal para la columna
*/

SELECT MaritalStatus, Gender, count(*) AS TotalVentas,
    GROUPING(MaritalStatus) as Grupo_EstadoCivil,
    GROUPING(Gender) as Grupo_genero
FROM [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY ROLLUP (MaritalStatus, Gender)

SELECT  Gender, MaritalStatus,count(*) AS TotalVentas,
    GROUPING(MaritalStatus) as Grupo_EstadoCivil,
    GROUPING(Gender) as Grupo_genero
FROM [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY ROLLUP ( Gender, MaritalStatus)


/* veamos un ejemplo con tres columnas de resumen */

/*suma las ventas diarias y calcula el subtotal por mes y por a�o*/

SELECT 
	YEAR(OrderDate) AS a�o, 
	MONTH(OrderDate) AS Mes, 
	DAY(OrderDate) AS d�a,
	FORMAT(SUM(TotalDue), 'C', 'en-US') AS TotalVentas,
    GROUPING(YEAR(OrderDate)) as AgrupandoA�o,
    GROUPING(MONTH(OrderDate)) as AgrupandoMes, 
	GROUPING(DAY(orderdate)) as Agrupandoday
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP (YEAR(OrderDate), MONTH(OrderDate), Day(orderDate))
ORDER BY YEAR(OrderDate), MONTH(OrderDate), DAY(orderdate);


-- filtrando adecuadamente esta consulta podemos obtener varias informaciones

-- Total ventas de todos los tiempos
select a�o, TotalVentas from
	(
	SELECT 
		YEAR(OrderDate) AS a�o, 
		MONTH(OrderDate) AS Mes, 
		DAY(OrderDate) AS d�a,
		FORMAT(SUM(TotalDue), 'C', 'en-US') AS TotalVentas,
		GROUPING(YEAR(OrderDate)) as AgrupandoA�o,
		GROUPING(MONTH(OrderDate)) as AgrupandoMes, 
		GROUPING(DAY(orderdate)) as Agrupandoday
	FROM Sales.SalesOrderHeader
	GROUP BY ROLLUP (YEAR(OrderDate), MONTH(OrderDate), Day(orderDate))
	) as tabla_auxiliar 
where AgrupandoA�o = 1 and AgrupandoMes = 1;


-- total de ventas anuales
select a�o, TotalVentas from
	(
	SELECT 
		YEAR(OrderDate) AS a�o, 
		MONTH(OrderDate) AS Mes, 
		DAY(OrderDate) AS d�a,
		FORMAT(SUM(TotalDue), 'C', 'en-US') AS TotalVentas,
		GROUPING(YEAR(OrderDate)) as AgrupandoA�o,
		GROUPING(MONTH(OrderDate)) as AgrupandoMes, 
		GROUPING(DAY(orderdate)) as Agrupandoday
	FROM Sales.SalesOrderHeader
	GROUP BY ROLLUP (YEAR(OrderDate), MONTH(OrderDate), Day(orderDate))
	) as tabla_auxiliar 
where AgrupandoMes = 1 and Agrupandoday = 1

-- ventas mensuales del a�o 2012
select a�o, mes, TotalVentas from
	(
	SELECT 
		YEAR(OrderDate) AS a�o, 
		MONTH(OrderDate) AS Mes, 
		DAY(OrderDate) AS d�a,
		FORMAT(SUM(TotalDue), 'C', 'en-US') AS TotalVentas,
		GROUPING(YEAR(OrderDate)) as AgrupandoA�o,
		GROUPING(MONTH(OrderDate)) as AgrupandoMes, 
		GROUPING(DAY(orderdate)) as Agrupandoday
	FROM Sales.SalesOrderHeader
	GROUP BY ROLLUP (YEAR(OrderDate), MONTH(OrderDate), Day(orderDate))
	) as tabla_auxiliar 
where a�o = 2012 and AgrupandoMes = 0 and Agrupandoday = 1

-- Si la tabla resumen es tan potente, quizas me compense crearla temporalemente
-- SELECT .... INTO nombre_tabla me puede ayudar en este proposito
DROP TABLE IF EXISTS Tabla_resumen_rollup;

SELECT 
	YEAR(OrderDate) AS a�o, 
	MONTH(OrderDate) AS Mes, 
	DAY(OrderDate) AS d�a,
	FORMAT(SUM(TotalDue), 'C', 'en-US') AS TotalVentas,
    GROUPING(YEAR(OrderDate)) as AgrupandoA�o,
    GROUPING(MONTH(OrderDate)) as AgrupandoMes, 
	GROUPING(DAY(orderdate)) as Agrupandoday
INTO Tabla_resumen_rollup
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP (YEAR(OrderDate), MONTH(OrderDate), Day(orderDate))
ORDER BY YEAR(OrderDate), MONTH(OrderDate), DAY(orderdate);

select a�o, TotalVentas from Tabla_resumen_rollup where AgrupandoA�o = 1 and AgrupandoMes = 1
select a�o, TotalVentas from Tabla_resumen_rollup where AgrupandoMes = 1 and Agrupandoday = 1
select a�o, mes, TotalVentas from Tabla_resumen_rollup where a�o = 2012 and AgrupandoMes = 0 and Agrupandoday = 1

-- select * from Tabla_resumen
/* ************************************************************************** **
ROLLUP() VS CUBE()
** ************************************************************************** */

-- Mientras que ROLLUP() es jer�rquico, CUBE() es combinatorio
SELECT  Gender, MaritalStatus,count(*) AS TotalVentas,
    GROUPING(MaritalStatus) as Grupo_EstadoCivil,
    GROUPING(Gender) as Grupo_genero
FROM [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY ROLLUP ( Gender, MaritalStatus);

SELECT  Gender, MaritalStatus,count(*) AS TotalVentas,
    GROUPING(MaritalStatus) as Grupo_EstadoCivil,
    GROUPING(Gender) as Grupo_genero
FROM [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY CUBE ( MaritalStatus,Gender);

SELECT  
	coalesce(Gender, 'Subtotal marital status') as Gender, 
	coalesce(MaritalStatus,'Subtotal genre') as Marital_status,
	count(*) AS TotalVentas,
    GROUPING(MaritalStatus) as Grupo_EstadoCivil,
    GROUPING(Gender) as Grupo_genero
FROM [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY CUBE ( MaritalStatus,Gender);



-- Ahora con tres .....
-- Vemos que acumula las ventas para los dias 1 de todos los a�os
-- Vemos que acumula las ventas para todos los dias 1 del mes 1.
DROP TABLE IF EXISTS Tabla_resumen_cube;
SELECT 
	YEAR(OrderDate) AS a�o, 
	MONTH(OrderDate) AS Mes, 
	DAY(OrderDate) AS d�a,
	FORMAT(SUM(TotalDue), 'C', 'en-US') AS TotalVentas,
    GROUPING(YEAR(OrderDate)) as AgrupandoA�o,
    GROUPING(MONTH(OrderDate)) as AgrupandoMes, 
	GROUPING(DAY(orderdate)) as Agrupandoday

FROM Sales.SalesOrderHeader
GROUP BY ROLLUP (YEAR(OrderDate), MONTH(OrderDate), Day(orderDate))
ORDER BY YEAR(OrderDate), MONTH(OrderDate), DAY(orderdate);
SELECT 
	YEAR(OrderDate) AS a�o, 
	MONTH(OrderDate) AS Mes, 
	DAY(OrderDate) AS d�a,
	FORMAT(SUM(TotalDue), 'C', 'en-US') AS TotalVentas,
    GROUPING(YEAR(OrderDate)) as AgrupandoA�o,
    GROUPING(MONTH(OrderDate)) as AgrupandoMes, 
	GROUPING(DAY(orderdate)) as Agrupandoday
FROM Sales.SalesOrderHeader
GROUP BY CUBE (YEAR(OrderDate), MONTH(OrderDate), Day(orderDate))
ORDER BY YEAR(OrderDate), MONTH(OrderDate), DAY(orderdate);