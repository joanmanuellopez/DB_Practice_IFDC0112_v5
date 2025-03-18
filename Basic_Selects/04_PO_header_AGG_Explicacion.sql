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

-- 03 Encuentra el valor m�ximo de Freight.
SELECT MAX(Freight) AS MaxFreight
FROM Purchasing.PurchaseOrderHeader;

-- 04 Encuentra el valor m�nimo de TotalDue.
SELECT MIN(TotalDue) AS MinTotalDue
FROM Purchasing.PurchaseOrderHeader;

-- 05 Cuenta el total de registros en la tabla. (4012)
SELECT COUNT(*) AS TotalOrders
FROM Purchasing.PurchaseOrderHeader;


-- 06 Cuenta cu�ntas �rdenes realiz� cada empleado.
SELECT EmployeeID, COUNT(*) AS OrdersPerEmployee
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID;

-- 07 Calcula la suma total de TotalDue para cada m�todo de env�o.
SELECT ShipMethodID, SUM(TotalDue) AS TotalByShipMethod
FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID;

-- 08 Encuentra el valor m�ximo de SubTotal para cada proveedor.
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


-- 11 Cuenta el n�mero de �rdenes por a�o basado en OrderDate.
SELECT YEAR(OrderDate) AS Year, COUNT(*) AS OrdersPerYear
FROM Purchasing.PurchaseOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrdersPerYear;


-- 12 Encuentra el valor m�nimo de Freight para cada m�todo de env�o.
SELECT ShipMethodID, MIN(Freight) AS MinFreightByShipMethod
FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID;


-- 13 Cuenta el n�mero de �rdenes por proveedor.
SELECT VendorID, COUNT(*) AS TotalOrdersPerVendor
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID;

-- 14 Cuenta el n�mero de �rdenes por proveedor y el total de sus pedidos
SELECT VendorID, COUNT(*) AS TotalOrdersPerVendor, SUM(SubTotal) as SumaOrdersPerVendor
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID;



-- 15 Cuenta el n�mero de �rdenes por proveedor y el total de sus pedidos
SELECT VendorID, SUM(SubTotal) / COUNT(*) AS PedidoMedioPerVendor
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID;

-- 16 Encuentra el valor m�ximo de TaxAmt para cada estado.
SELECT Status, MAX(TaxAmt) AS MaxTaxByStatus
FROM Purchasing.PurchaseOrderHeader
GROUP BY Status;

-- 17 Muestra empleados con m�s de 10 �rdenes.
SELECT EmployeeID, COUNT(*) AS OrdersPerEmployee
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID
HAVING COUNT(*) > 10;

-- 18 Muestra empleados con un n�emro de �rdenes comprendido entre 100 y 200.
SELECT EmployeeID, COUNT(*) AS OrdersPerEmployee
FROM Purchasing.PurchaseOrderHeader
WHERE ShipMethodID BETWEEN 1 AND 3
GROUP BY EmployeeID
HAVING COUNT(*) BETWEEN 100 AND 200;

SELECT COUNT(*) AS OrdersPerEmployee
FROM Purchasing.PurchaseOrderHeader
WHERE ShipMethodID BETWEEN 4 AND 5

-- 19 Calcula el promedio de TotalDue para cada m�todo de env�o.
SELECT ShipMethodID, AVG(TotalDue) AS AvgTotalDueByShipMethod
FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID;

-- 20 Calcula las ventas totales por mes y a�o.
SELECT YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month, SUM(TotalDue) AS TotalSales
FROM Purchasing.PurchaseOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate);



-- 21 Calcula las ventas totales por mes y a�o. Muestra primero los datos de los a�os m�s recientes.
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

-- 25 Cuenta cu�ntas �rdenes se enviaron en cada fecha.
SELECT ShipDate, COUNT(*) AS OrdersPerShipDate
FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipDate;


-- 26 Encuentra el valor m�ximo de TotalDue para cada a�o.
SELECT YEAR(OrderDate) AS Year, MAX(TotalDue) AS MaxTotalDue
FROM Purchasing.PurchaseOrderHeader
GROUP BY YEAR(OrderDate);

-- 27 Encuentra proveedores cuyo total de Freight supera los 1,000.
SELECT VendorID, SUM(Freight) AS TotalFreightPerVendor
FROM Purchasing.PurchaseOrderHeader
GROUP BY VendorID
HAVING SUM(Freight) > 1000;

-- 28 Cuenta cu�ntos empleados diferentes trabajan en �rdenes con cada estado.
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


-- 31 Encuentra el Freight m�nimo y m�ximo por empleado.
SELECT EmployeeID, MIN(Freight) AS MinFreight, MAX(Freight) AS MaxFreight
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID;

-- 32 Elabora una lista con los c�digos de los m�todos de env�os
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


�Cu�l es la suma total de SubTotal para todos los registros?

�Cu�l es el valor promedio de TaxAmt en la tabla?

�Cu�ntos registros tienen un Status igual a 4?

�Cu�l es el TotalDue m�s alto en la tabla?

�Cu�l es el SubTotal m�s bajo en la tabla?

�Cu�l es la cantidad de �rdenes por cada EmployeeID?

�Qu� ShipMethodID tiene el promedio m�s alto de Freight?

�Cu�ntos registros hay en la tabla que tengan un VendorID mayor que 1600?

�Cu�l es la suma de TotalDue para cada ShipMethodID?

�Cu�l es el n�mero total de �rdenes realizadas en cada a�o (bas�ndote en OrderDate)?

�Qu� VendorID tiene la mayor cantidad de registros asociados?

�Cu�l es la suma total de Freight por cada Status?

�Cu�l es la cantidad de �rdenes realizadas por cada ShipDate?

�Qu� EmployeeID gener� el mayor TotalDue en suma?

�Cu�l es el valor promedio de SubTotal para las �rdenes con un TaxAmt superior a 50?

�Cu�l es el valor m�ximo de TaxAmt para cada ShipMethodID?

�Cu�ntos registros hay por cada combinaci�n de EmployeeID y ShipMethodID?

�Cu�l es el valor m�nimo de Freight para los registros con un SubTotal mayor a 20,000?

�Cu�l es el promedio de TotalDue para cada a�o basado en OrderDate?

�Qu� Purchasing.PurchaseOrderHeaderID tiene el mayor valor de Freight asociado?

�Cu�l es la suma total de TaxAmt por cada combinaci�n de Status y ShipMethodID?

�Cu�ntos registros tienen un OrderDate en cada mes del a�o 2011?

�Cu�l es el valor promedio de Freight para los registros donde EmployeeID es mayor que 255?

�Cu�l es el menor SubTotal registrado por cada ShipMethodID?

�Cu�ntos registros tienen un ShipDate anterior al ModifiedDate?

*/