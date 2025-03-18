/*
FUnciones de Agregad0 
APPROX_COUNT_DISTINCT
CHECKSUM_AGG
COUNT
COUNT_BIG
GROUPING
GROUPING_ID
STRING_AGG

AVG
MAX
MIN
STDEV
STDEVP
SUM
VAR
VARP
*/

-- 00 Mostramos 10 registros de la tabla para familiarizarnos con ella
USE AdventureWorks2022;
Select * from Purchasing.PurchaseOrderHeader;

-- 01 Cual ha sido el valor total comprado registrado en la base de datos (63791994,838)
SELECT SUM(SubTotal) AS TotalSubTotal
FROM Purchasing.PurchaseOrderHeader;

-- 02 Cual ha sido el valor promedio del impuesto
SELECT AVG(TaxAmt) AS AverageTax
FROM Purchasing.PurchaseOrderHeader;

-- 03 Encuentra el valor máximo de Freight.
SELECT MAX(Freight) AS MaxFreight
FROM Purchasing.PurchaseOrderHeader;

-- 04 Encuentra el valor mínimo de TotalDue.
SELECT MIN(TotalDue) AS MinTotalDue
FROM Purchasing.PurchaseOrderHeader;

-- 05 Cuenta el total de registros en la tabla. (4012)
SELECT COUNT(*) AS TotalOrders
FROM Purchasing.PurchaseOrderHeader;


-- 06 Cuenta cuántas órdenes realizó cada empleado.
SELECT EmployeeID, COUNT(*) AS OrdersPerEmployee
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID;

-- 07 Calcula la suma total de TotalDue para cada método de envío.
SELECT ShipMethodID, SUM(TotalDue) AS TotalByShipMethod
FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID;

-- 08 Encuentra el valor máximo de SubTotal para cada proveedor.
SELECT VendorID, MAX(SubTotal) AS MaxSubTotalPerVendor
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID
ORDER BY MaxSubTotalPerVendor DESC;

-- 09 Calcula el promedio de Freight para cada estado.
SELECT Status, AVG(Freight) AS AvgFreightByStatus
FROM Purchasing.PurchaseOrderHeader
GROUP BY Status;


-- 10 Encuentra los empleados cuyo total de TotalDue supera los 50,000.
SELECT EmployeeID, SUM(TotalDue) AS TotalDuePerEmployee
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID
HAVING SUM(TotalDue) > 7000000;


-- 11 Cuenta el número de órdenes por año basado en OrderDate.
SELECT YEAR(OrderDate) AS Year, COUNT(*) AS OrdersPerYear
FROM Purchasing.PurchaseOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrdersPerYear;


-- 12 Encuentra el valor mínimo de Freight para cada método de envío.
SELECT ShipMethodID, MIN(Freight) AS MinFreightByShipMethod
FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID;


-- 13 Cuenta el número de órdenes por proveedor.
SELECT VendorID, COUNT(*) AS TotalOrdersPerVendor
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID;

-- 14 Cuenta el número de órdenes por proveedor y el total de sus pedidos
SELECT VendorID, COUNT(*) AS TotalOrdersPerVendor, SUM(SubTotal) as SumaOrdersPerVendor
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID;



-- 15 Cuenta el número de órdenes por proveedor y el total de sus pedidos
SELECT VendorID, SUM(SubTotal) / COUNT(*) AS PedidoMedioPerVendor
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID;

-- 16 Encuentra el valor máximo de TaxAmt para cada estado.
SELECT Status, MAX(TaxAmt) AS MaxTaxByStatus
FROM Purchasing.PurchaseOrderHeader
GROUP BY Status;

-- 17 Muestra empleados con más de 10 órdenes.
SELECT EmployeeID, COUNT(*) AS OrdersPerEmployee
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID
HAVING COUNT(*) > 10;

-- 18 Muestra empleados con un núemro de órdenes comprendido entre 100 y 200.
SELECT EmployeeID, COUNT(*) AS OrdersPerEmployee
FROM Purchasing.PurchaseOrderHeader
WHERE ShipMethodID BETWEEN 1 AND 3
GROUP BY EmployeeID
HAVING COUNT(*) BETWEEN 100 AND 200;

SELECT COUNT(*) AS OrdersPerEmployee
FROM Purchasing.PurchaseOrderHeader
WHERE ShipMethodID BETWEEN 4 AND 5

-- 19 Calcula el promedio de TotalDue para cada método de envío.
SELECT ShipMethodID, AVG(TotalDue) AS AvgTotalDueByShipMethod
FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID;

-- 20 Calcula las ventas totales por mes y año.
SELECT YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month, SUM(TotalDue) AS TotalSales
FROM Purchasing.PurchaseOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate);



-- 21 Calcula las ventas totales por mes y año. Muestra primero los datos de los años más recientes.
SELECT YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month, SUM(TotalDue) AS TotalSales
FROM Purchasing.PurchaseOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY YEAR DESC, month;

-- 24 Encuentra la suma de SubTotal por empleado y proveedor. Agrupa los datos por empleado
SELECT EmployeeID, VendorID, SUM(SubTotal) AS TotalSubTotal
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID, VendorID
ORDER BY EmployeeID;

-- 24 Encuentra la suma de SubTotal por empleado y proveedor. Agrupa los datos por empleado
SELECT EmployeeID, VendorID, GROUPING_ID(VendorID,  EmployeeID) as Niveldeagrupacion, SUM(SubTotal) AS TotalSubTotal
FROM Purchasing.PurchaseOrderHeader
GROUP BY GROUPING SETS ((),(EmployeeID), (VendorID))
ORDER BY EmployeeID;

-- 25 Cuenta cuántas órdenes se enviaron en cada fecha.
SELECT ShipDate, COUNT(*) AS OrdersPerShipDate
FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipDate;


-- 26 Encuentra el valor máximo de TotalDue para cada año.
SELECT YEAR(OrderDate) AS Year, MAX(TotalDue) AS MaxTotalDue
FROM Purchasing.PurchaseOrderHeader
GROUP BY YEAR(OrderDate);

-- 27 Encuentra proveedores cuyo total de Freight supera los 1,000.
SELECT VendorID, SUM(Freight) AS TotalFreightPerVendor
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID
HAVING SUM(Freight) > 1000;

-- 28 Cuenta cuántos empleados diferentes trabajan en órdenes con cada estado.
SELECT Status, COUNT(DISTINCT EmployeeID) AS EmployeesPerStatus
FROM Purchasing.PurchaseOrderHeader
GROUP BY Status;

-- 29 Calcula el promedio de TaxAmt por mes.
SELECT MONTH(OrderDate) AS Month, AVG(TaxAmt) AS AvgTaxAmt
FROM Purchasing.PurchaseOrderHeader
GROUP BY MONTH(OrderDate)
ORDER BY Month;


-- 30 Ordena los proveedores por su total de SubTotal en orden descendente.
SELECT VendorID, COUNT(*) AS Orders, SUM(SubTotal) AS TotalSubTotal
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID
ORDER BY TotalSubTotal DESC;


-- 31 Encuentra el Freight mínimo y máximo por empleado.
SELECT EmployeeID, MIN(Freight) AS MinFreight, MAX(Freight) AS MaxFreight
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID;

-- 32 Elabora una lista con los códigos de los métodos de envíos
SELECT STRING_AGG(CAST(ShipMethodID AS NVARCHAR(MAX)), ', ') AS MetodosEnvio
FROM Purchasing.PurchaseOrderHeader;

-- 33 Elabora una lista con los nombres de las tiendas Atendidas por cada vendedor
SELECT SalesPersonID, STRING_AGG(CAST(Name AS NVARCHAR), ', ') AS ListaTiendas
FROM [Sales].[Store]
WHERE SalesPersonID = 282
GROUP BY SalesPersonID;

select * from [AdventureWorks2022].[Sales].[Store]


-- 24 Encuentra la suma de SubTotal por empleado y proveedor. Agrupa los datos por empleado
SELECT EmployeeID, VendorID, GROUPING_ID(EmployeeID, VendorID) as Niveldeagrupacion, SUM(SubTotal) AS TotalSubTotal
FROM Purchasing.PurchaseOrderHeader
GROUP BY GROUPING SETS ((EmployeeID), (VendorID));
ORDER BY EmployeeID;

SELECT EmployeeID, ShipMethodID,
       GROUPING_ID(EmployeeID, ShipMethodID) AS GroupingID,
       COUNT(*) AS TotalOrders
FROM Purchasing.PurchaseOrderHeader
GROUP BY GROUPING SETS ((EmployeeID), (ShipMethodID), ());


SELECT EmployeeID, 
       ShipMethodID, 
       GROUPING(EmployeeID) AS IsGroupedByEmployee, 
       GROUPING(ShipMethodID) AS IsGroupedByShipMethod, 
       COUNT(*) AS TotalOrders
FROM Purchasing.PurchaseOrderHeader
GROUP BY GROUPING SETS ((EmployeeID), (ShipMethodID), ());

SELECT EmployeeID, VendorID, COUNT(*) AS TotalSubTotal
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID, VendorID
ORDER BY EmployeeID;

-- 24 Encuentra la suma de SubTotal por empleado y proveedor. Agrupa los datos por empleado
SELECT EmployeeID, VendorID, GROUPING_ID(EmployeeID, VendorID) as Niveldeagrupacion, COUNT(*) AS TotalSubTotal
FROM Purchasing.PurchaseOrderHeader
GROUP BY GROUPING SETS ((EmployeeID), (VendorID))
ORDER BY EmployeeID;
/*


¿Cuál es la suma total de SubTotal para todos los registros?

¿Cuál es el valor promedio de TaxAmt en la tabla?

¿Cuántos registros tienen un Status igual a 4?

¿Cuál es el TotalDue más alto en la tabla?

¿Cuál es el SubTotal más bajo en la tabla?

¿Cuál es la cantidad de órdenes por cada EmployeeID?

¿Qué ShipMethodID tiene el promedio más alto de Freight?

¿Cuántos registros hay en la tabla que tengan un VendorID mayor que 1600?

¿Cuál es la suma de TotalDue para cada ShipMethodID?

¿Cuál es el número total de órdenes realizadas en cada año (basándote en OrderDate)?

¿Qué VendorID tiene la mayor cantidad de registros asociados?

¿Cuál es la suma total de Freight por cada Status?

¿Cuál es la cantidad de órdenes realizadas por cada ShipDate?

¿Qué EmployeeID generó el mayor TotalDue en suma?

¿Cuál es el valor promedio de SubTotal para las órdenes con un TaxAmt superior a 50?

¿Cuál es el valor máximo de TaxAmt para cada ShipMethodID?

¿Cuántos registros hay por cada combinación de EmployeeID y ShipMethodID?

¿Cuál es el valor mínimo de Freight para los registros con un SubTotal mayor a 20,000?

¿Cuál es el promedio de TotalDue para cada año basado en OrderDate?

¿Qué Purchasing.PurchaseOrderHeaderID tiene el mayor valor de Freight asociado?

¿Cuál es la suma total de TaxAmt por cada combinación de Status y ShipMethodID?

¿Cuántos registros tienen un OrderDate en cada mes del año 2011?

¿Cuál es el valor promedio de Freight para los registros donde EmployeeID es mayor que 255?

¿Cuál es el menor SubTotal registrado por cada ShipMethodID?

¿Cuántos registros tienen un ShipDate anterior al ModifiedDate?

*/