/******************************************************************
Queries para practivar el filtrado
*******************************************************************/
USE AdventureWorks2022;

SELECT * FROM Purchasing.PurchaseOrderHeader;
-- 01 ¿Qué registros tienen un Status igual a 4 y un SubTotal mayor de 10,000? (2097)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE Status = 4 and SubTotal > 1000;

-- 02 ¿Cuáles son las órdenes con una ShipMethodID igual a 5 y un TaxAmt inferior a 50? (569)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE ShipMethodID = 4 and TaxAmt <50 ;

-- 03 ¿Qué PurchaseOrderID tiene un TotalDue entre 1,000 y 2,000? (183)
SELECT PurchaseOrderID FROM Purchasing.PurchaseOrderHeader
WHERE TotalDue between 1000 and 2000 ;

SELECT PurchaseOrderID FROM Purchasing.PurchaseOrderHeader
WHERE  1000 <= TotalDue and TotalDue <= 2000 ;

-- 04 ¿Qué registros tienen un OrderDate posterior al 2012-01-01? (3984)

SELECT PurchaseOrderID, OrderDate FROM Purchasing.PurchaseOrderHeader
WHERE '2012-01-01' < OrderDate ;

-- 05 ¿Qué filas tienen un VendorID diferente a 1600? (3961)
SELECT PurchaseOrderID, VendorID FROM Purchasing.PurchaseOrderHeader
WHERE 1600 <> VendorID ;

SELECT PurchaseOrderID, VendorID FROM Purchasing.PurchaseOrderHeader
WHERE 1600 != VendorID ;

-- la contraria da 51 registros
SELECT PurchaseOrderID, VendorID FROM Purchasing.PurchaseOrderHeader
WHERE 1600 = VendorID ;

-- 3961 + 51 = 4012 que son todos los registros de la tabla

-- 06 ¿Cuáles son las órdenes donde Freight es mayor que el 10% de SubTotal? (0)
SELECT * FROM Purchasing.PurchaseOrderHeader;

SELECT SubTotal, subtotal * 0.1 as diezporciento, Freight FROM Purchasing.PurchaseOrderHeader
WHERE subtotal * 0.1 < Freight ;

SELECT SubTotal, cast(subtotal * 0.01 as money) as diezporciento, Freight FROM Purchasing.PurchaseOrderHeader
WHERE cast(subtotal * 0.01 as money) < Freight ;

-- 06 bis ¿Cuáles son las órdenes donde Freight es mayor que el 1% de SubTotal? (4012)
SELECT SubTotal, subtotal * 0.01 as diezporciento, Freight FROM Purchasing.PurchaseOrderHeader
WHERE subtotal * 0.01 < Freight ;

-- 07 ¿Cuáles son las filas en las que el EmployeeID está en el rango de 250 a 260? (3611)
SELECT PurchaseOrderID, EmployeeID FROM Purchasing.PurchaseOrderHeader
WHERE 250 <= EmployeeID and EmployeeID <=260;

-- 08 ¿Qué registros tienen un PurchaseOrderID igual a 9 o 10? (2)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE PurchaseOrderID IN (9,10);

SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE PurchaseOrderID = 9 or PurchaseOrderID = 10;


-- 09 ¿Qué filas tienen un ShipDate exactamente igual a la fecha de ModifiedDate? (4000)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE ShipDate <> ModifiedDate ;

-- 09 BIS ¿Qué filas tienen un ShipDate distinto la fecha de ModifiedDate? (4012)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE ShipDate <> ModifiedDate ;

-- 10 ¿Qué filas tienen un SubTotal mayor o igual a 50,000 y un Freight menor o igual a 2,000? (213)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE 50000 <= SubTotal  and Freight  <= 2000;

-- 11 ¿Qué filas tienen un TaxAmt superior a 10 y un TotalDue inferior a 100? (0)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE 10 < TaxAmt  and TotalDue  < 1000;
SELECT TotalDue, TaxAmt FROM Purchasing.PurchaseOrderHeader
WHERE 10 < TaxAmt  and TotalDue  < 100;

-- 12 ¿Qué filas tienen un Status que no es 4? (323)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE status != 4;

-- 13 ¿Cuáles son las órdenes donde ShipMethodID comienza por el número 2 (usa LIKE)? (655)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE ShipMethodID like '2%';

-- 14 ¿Qué registros tienen un OrderDate en 2011? (28)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE '2011-01-01' <= OrderDate and OrderDate <= '2011-12-31';

-- 15 ¿Qué filas tienen un SubTotal igual a la suma de TaxAmt y Freight? (0)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE SubTotal = TaxAmt + Freight;

-- 16 ¿Cuáles son las órdenes cuyo EmployeeID es mayor que 255 y cuyo ShipMethodID es igual a 5? (824)
SELECT EmployeeID, ShipMethodID FROM Purchasing.PurchaseOrderHeader
WHERE 255 < EmployeeID and ShipMethodID = 5 ;

-- 17 ¿Qué órdenes tienen un VendorID entre 1500 y 1600? (1824)
SELECT VendorID, EmployeeID, ShipMethodID FROM Purchasing.PurchaseOrderHeader
WHERE VendorID between 1500 and 1600;

-- 18 ¿Qué registros tienen un PurchaseOrderID mayor a 50 o un TotalDue menor que 500? (3974)
SELECT VendorID, PurchaseOrderID, TotalDue FROM Purchasing.PurchaseOrderHeader
WHERE TotalDue < 500 or 50 < PurchaseOrderID;

-- 19 ¿Qué registros tienen un TaxAmt superior a 1 y un Freight entre 10 y 20? (642)
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE 1 < TaxAmt and Freight between 10 and 20;

-- 20 ¿Qué filas tienen un Status que sea 1, 3 o 5? (311)
Select * from Purchasing.PurchaseOrderHeader where status in (1,3,5);

-- 21 ¿Qué registros tienen un ShipDate que no sea NULL? (4012)
select * from Purchasing.PurchaseOrderHeader where ShipDate IS NOT NULL;

-- 22 ¿Qué filas tienen un ShipMethodID mayor que 3 y un OrderDate antes de 2012-01-01? (16)
select * from Purchasing.PurchaseOrderHeader where 3 < ShipMethodID and OrderDate < '2012-01-01';

-- 23 ¿Qué registros tienen un ModifiedDate igual al ShipDate y un Status de 4? (2689)
select * from Purchasing.PurchaseOrderheader where ModifiedDate = ShipDate and status = 4;

-- 24 ¿Qué filas tienen un TotalDue superior a 25,000 y un PurchaseOrderID que finaliza en 5 (usa LIKE)? (126)
select TotalDue, PurchaseOrderID from Purchasing.PurchaseOrderHeader where 25000 < TotalDue and PurchaseOrderID like '%5'

-- 25 ¿Qué registros tienen un ShipDate al menos 10 días después del OrderDate? (12)
select OrderDate, ShipDate, cast(ShipDate - OrderDate as int) as dias from Purchasing.PurchaseOrderHeader where  cast(ShipDate - OrderDate as int) > 10;