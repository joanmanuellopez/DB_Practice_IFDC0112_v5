-- Cuántas personas el middle name con una 'A'
SELECT COUNT(*) AS Total
FROM [AdventureWorks2022].[Person].[Person]
WHERE [MiddleName] = 'A'


SELECT [MiddleName], COUNT(*) AS Total
FROM [AdventureWorks2022].[Person].[Person]
WHERE [MiddleName] LIKE '_'
GROUP BY [MiddleName]
--HAVING [MiddleName] = 'A'


-- PurchaseOrderHeader: Año | ShipMethodId | SUM(Subtotal)
SELECT YEAR(ShipDate),
	ShipMethodID AS TipoEnvio,
	FORMAT(SUM(SubTotal),'C','UK-GB') AS Total,
	--SUM(SubTotal) AS Total,
	GROUPING(YEAR(ShipDate)) AS AgrupadoPorAño,
	GROUPING(ShipMethodID) AS AgrupadoPorEnvio
FROM [AdventureWorks2022].[Purchasing].[PurchaseOrderHeader]
GROUP BY ROLLUP(YEAR(ShipDate)), ShipMethodID


-- Qué promedio de tasas he pagado según la fecha (año, mes, día) y zona territorial
SELECT 
	YEAR(OrderDate) AS Año, 
	MONTH(OrderDate) AS Mes, 
	DAY(OrderDate) AS Dia,
	TerritoryID AS Zona,
	FORMAT(AVG(TaxAmt), 'C', 'en-US') AS PromedioTasas,
    GROUPING(YEAR(OrderDate)) as AgrupandoAño,
    GROUPING(MONTH(OrderDate)) as AgrupandoMes, 
	GROUPING(DAY(OrderDate)) as AgrupandoDia
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
GROUP BY ROLLUP (YEAR(OrderDate), MONTH(OrderDate), Day(orderDate), TerritoryID)