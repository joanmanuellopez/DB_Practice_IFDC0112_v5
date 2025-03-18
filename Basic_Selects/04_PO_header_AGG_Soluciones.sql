USE AdventureWorks2022;
Select * from Purchasing.PurchaseOrderHeader;

-- 01 �Cu�l es la suma total de SubTotal para todos los registros?n(63 791 994,838)
SELECT SUM(SubTotal) FROM Purchasing.PurchaseOrderHeader;

-- 02 �Cu�l es el valor promedio de TaxAmt en la tabla? (1 272,0238)
SELECT AVG(TaxAmt) FROM Purchasing.PurchaseOrderHeader;

-- 03 �Cu�ntos registros tienen un Status igual a 4? (3 689)
SELECT COUNT(*) FROM Purchasing.PurchaseOrderHeader
WHERE Status = 4

SELECT Status, COUNT(*) FROM Purchasing.PurchaseOrderHeader
GROUP BY Status
HAVING Status = 4;

-- 04 �Cu�l es el TotalDue m�s alto en la tabla? (1 097 448,00)
SELECT MAX(TotalDue) FROM Purchasing.PurchaseOrderHeader;

-- 05 �Cu�l es el SubTotal m�s bajo en la tabla? (40,9684)
SELECT MIN(TotalDue) FROM Purchasing.PurchaseOrderHeader;

-- 06 �Cu�l es la cantidad de �rdenes por cada EmployeeID? 
-- EmployeeID	(No column name)
-- 250	160
SELECT EmployeeID, count(*) as pedidos FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID
ORDER BY Pedidos DESC;

-- 06 �Cu�l son los tres empleados con m�s pedidos? 
--EmployeeID	Pedidos
--261	        401
--253	        400
--254	        362

SELECT TOP 3 EmployeeID, count(*) as Pedidos FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID
ORDER BY Pedidos DESC;

-- 07 �Qu� ShipMethodID tiene el promedio m�s alto de Freight? (3)
SELECT TOP 1 ShipMethodID, AVG(Freight) as FletePromedio FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID
ORDER BY FletePromedio DESC;

-- 08 �Cu�ntos registros hay en la tabla que tengan un VendorID mayor que 1600? (1980)
SELECT count(*) FROM Purchasing.PurchaseOrderHeader
WHERE VendorID > 1600;

-- 09 �Cu�l es la suma de TotalDue para cada ShipMethodID?
SELECT ShipMethodID, SUM(TotalDue)as Total FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID;

-- 10 �Cu�l es el n�mero total de �rdenes realizadas en cada a�o (bas�ndote en OrderDate)?
SELECT  YEAR(OrderDate) as Year, count(*) FROM Purchasing.PurchaseOrderHeader
GROUP BY YEAR(OrderDate);

-- 11 �Qu� VendorID tiene la mayor cantidad de registros asociados? (1494) Hay varios candidatos
SELECT  VendorId, count(*) AS pedidos 
FROM Purchasing.PurchaseOrderHeader 
GROUP BY VendorID 
ORDER BY pedidos DESC;

 

-- 11 bis �Qu� VendorID tiene la mayor cantidad de registros asociados, Desempata con  el total comprado? (1696)
SELECT TOP 1 VendorId, count(*) AS pedidos, SUM(subtotal) as total 
FROM Purchasing.PurchaseOrderHeader 
GROUP BY VendorID 
ORDER BY pedidos DESC, total DESC;

-- 12 �Cu�l es la suma total de Freight por cada Status?
--  Status	TotalFreight
--  3	32545,6492
--  1	87644,3398
--  4	1420501,459
--  2	43286,7783
SELECT Status, SUM(Freight) as TotalFreight FROM Purchasing.PurchaseOrderHeader
GROUP BY Status;

-- 13 �Cu�l es la cantidad de �rdenes realizadas por cada ShipDate?
SELECT ShipDate, count(*)FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipDate
ORDER BY ShipDate;

-- 14  �Qu� EmployeeID gener� el mayor TotalDue en suma? (251)

SELECT top 1 EmployeeID ,  sum(TotalDue) as total
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID
ORDER BY sum(TotalDue)  DESC;


SELECT top 1 EmployeeID
FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID
ORDER BY sum(TotalDue)  DESC;

-- 15 �Cu�l es el valor promedio de SubTotal para las �rdenes con un TaxAmt superior a 50? ( 25 559,4371)
SELECT  AVG(subtotal) FROM Purchasing.PurchaseOrderHeader
WHERE TaxAmt > 50;

-- 16 �Cu�l es el valor m�ximo de TaxAmt para cada ShipMethodID?
SELECT ShipMethodID, MAX(TaxAmt) FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID;

-- 17 �Cu�ntos registros hay por cada combinaci�n de EmployeeID y ShipMethodID?
SELECT EmployeeID, ShipMethodID, count(*) as pedidos FROM Purchasing.PurchaseOrderHeader
GROUP BY EmployeeID, ShipMethodID
ORDER BY EmployeeID, ShipMethodID;

-- 18 �Cu�l es el valor m�nimo de Freight para los registros con un SubTotal mayor a 20,000? (437,65)
SELECT MIN(Freight) FROM Purchasing.PurchaseOrderHeader
WHERE SubTotal > 20000

-- 19 �Cu�l es el promedio de TotalDue para cada a�o basado en OrderDate?
SELECT  YEAR(OrderDate) as Year, AVG(TotalDue) as Promedio FROM Purchasing.PurchaseOrderHeader
GROUP BY YEAR(OrderDate);

-- 20 �Qu� PurchaseOrderID tiene el mayor valor de Freight asociado? (4012)

SELECT TOP 1 PurchaseOrderID FROM Purchasing.PurchaseOrderHeader
ORDER BY Freight DESC;

SELECT PurchaseOrderID, FREIGHT FROM Purchasing.PurchaseOrderHeader ORDER BY FREIGHT DESC

-- 21 �Cu�l es la suma total de TaxAmt por cada combinaci�n de Status y ShipMethodID?
SELECT Status, ShipMethodID, SUM(TaxAmt) TOTALTAX FROM Purchasing.PurchaseOrderHeader
GROUP BY Status, ShipMethodID
ORDER BY Status, ShipMethodID;

-- 22 �Cu�ntos registros tienen un OrderDate en cada mes del a�o 2011?
--mes	(No column name)
--4		8
--12	20
SELECT MONTH(OrderDate) as mes , COUNT(*) FROM Purchasing.PurchaseOrderHeader
WHERE YEAR(OrderDate) = 2011
GROUP BY MONTH(OrderDate)



-- 23 �Cu�l es el valor promedio de Freight para los registros donde EmployeeID es mayor que 255?
--	EmployeeID	AVG_FREIG
--	261			408,2708
--	258			342,8497
--	259			325,9195
--	256			410,3685
--	257			436,3257
--	260			361,2174

SELECT EmployeeID, AVG(Freight) AVG_FREIG FROM Purchasing.PurchaseOrderHeader
WHERE EmployeeID > 255
GROUP BY EmployeeID;

-- 24 �Cu�l es el menor SubTotal registrado por cada ShipMethodID?
SELECT ShipMethodID, MIN(SubTotal) MINVALUE FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID;

-- 25 �Cu�ntos registros tienen un ShipDate anterior al ModifiedDate? (12)
SELECT COUNT(*) as COUNTAJE FROM Purchasing.PurchaseOrderHeader
WHERE ShipDate < ModifiedDate;

Select * from Purchasing.PurchaseOrderHeader
WHERE ShipDate < ModifiedDate;