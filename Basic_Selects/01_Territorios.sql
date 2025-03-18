/* este comentarios
ocupa varias lineas
*/

-- muestra todas las columnas de una tabla y todas las filas
select * from Sales.SalesTerritory;
-- muestras algunas columnas de una tabla y todas las filas
select [Name], [CountryRegionCode], [SalesLastYear] from Sales.SalesTerritory;
-- muestras algunas columnas RENOMBRADAS de una tabla y todas las filas
select [Name] as Nombre, [CountryRegionCode] as Pais, [SalesLastYear] as Ventas from Sales.SalesTerritory;
-- muestra todas las columnas de una tabla y algunas filas
select * from Sales.SalesTerritory
where CountryRegionCode = 'US';
-- muestra algunas columnas de una tabla y algunas filas
select [Name] as nombre, [CountryRegionCode] as pais, [SalesLastYear] as Ventas from Sales.SalesTerritory
where CountryRegionCode = 'US' or CountryRegionCode = 'AU' or CountryRegionCode = 'GB';

select [Name] as nombre, [CountryRegionCode] as pais, [SalesLastYear] as Ventas from Sales.SalesTerritory
where CountryRegionCode in ('US','AU', 'GB');

select [Name] as nombre, [CountryRegionCode] as pais, [SalesLastYear] as Ventas from Sales.SalesTerritory
where CountryRegionCode not in ('US','AU');

select [Name] as nombre, [CountryRegionCode] as pais, [SalesLastYear] as Ventas from Sales.SalesTerritory
where CountryRegionCode != 'US' or SalesLastYear > 2000000;
select [Name] as nombre, [CountryRegionCode] as pais, [SalesLastYear] as Ventas from Sales.SalesTerritory
where CountryRegionCode <> 'US' or SalesLastYear > 2000000;