-- 01. Subtotalizar por mes y género las contrataciones

SELECT MONTH(HireDate) AS Mes, Gender, COUNT(*) AS Empleados,
	GROUPING(Gender) AS AgrupadoPorGenero,
	GROUPING(MONTH(HirEDate)) AS AgrupadoPorMes
FROM [AdventureWorks2022].[HumanResources].[Employee]
GROUP BY ROLLUP(MONTH(HireDate), Gender)


-- 02. Subtotalizar por mes y género las contrataciones

SELECT TOP 1 * FROM (
	SELECT MONTH(HireDate) AS Mes,
		COALESCE(Gender,'Subtotal Mes') AS Genero,
		COUNT(*) AS Empleados,
		GROUPING(Gender) AS AgrupadoPorGenero,
		GROUPING(MONTH(HirEDate)) AS AgrupadoPorMes
	FROM [AdventureWorks2022].[HumanResources].[Employee]
	GROUP BY ROLLUP(MONTH(HireDate), Gender)
) AS Subconsulta
WHERE AgrupadoPorGenero = 1 AND Mes IS NOT NULL
ORDER BY Empleados DESC


-- 03. Alternativa

--SELECT TOP 1 Mes, MAX(Empleados) AS MaxHires
--FROM (
--	SELECT MONTH(HireDate) AS Mes,
--		COALESCE(Gender,'Subtotal Mes') AS Genero,
--		COUNT(*) AS Empleados,
--		GROUPING(Gender) AS AgrupadoPorGenero,
--		GROUPING(MONTH(HireDate)) AS AgrupadoPorMes
--	FROM [AdventureWorks2022].[HumanResources].[Employee]
--	GROUP BY ROLLUP(MONTH(HireDate), Gender)
--) AS Subconsulta
