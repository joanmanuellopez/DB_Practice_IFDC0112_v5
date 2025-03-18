/******************************************************************
Queries para practivar el filtrado
*******************************************************************/

-- 01 Lista los códigos de pedidos cuyto toatl sea mayor de 20000 y la cantidad de impuestos menos de 3000.
SELECT SalesOrderID FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE SubTotal > 20000 AND TaxAmt < 3000;

-- 02 Registros del territorio cinco con un total debido mayor o igual que 200 y menor o igual que 800 
---   o con un total debido mayor o igual que 9000 y menor o igual que 10000. 
SELECT TerritoryID,TotalDue FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE TerritoryID = 5 AND ((TotalDue BETWEEN 9000 AND 10000) or (TotalDue BETWEEN 200 AND 800));

-- 03 Registros del vendedor 274 y numero de cuenta con final 96
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE AccountNumber LIKE '%96' AND SalesPersonID = 274;
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE AccountNumber LIKE '%2%6' AND SalesPersonID = 274;

-- 04 Muestras los códigos de los pedidos  cuyo método de envio sea 5 o haya tenido un coste superior a 2000
SELECT SalesOrderID, ShipMethodID, Freight FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE ShipMethodID = 5 OR Freight > 2000;

-- 05 Pedidos con comentarios cuyo subtotal en mayor o igual a 10000
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE comment IS NOT NULL AND SubTotal >= 10000;

-- 06 Selección entre dos fechas
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE ModifiedDate >= '2011-06-07' AND ModifiedDate < '2011-06-08';

-- 07 Pedidos con el número de cuenta que empieza por "10-4020-00" 
-- seguido de un caracter, seguido de un "7" y cualquier número de carácteres.
USE [AdventureWorks2022];
SELECT SalesOrderID, AccountNumber  FROM [Sales].[SalesOrderHeader]
WHERE AccountNumber LIKE '10-4020-00_7%'

-- 08 Pedidos en los que coincide la dirección de envío con la dirección de facturación
SELECT SalesOrderID, BillToAddressID, ShipToAddressID FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE BillToAddressID = ShipToAddressID;

-- 09 Pedidos con el número de pedido de la serir SO4 que terminan en 60
SELECT SalesOrderNumber,CreditCardID  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE SalesOrderNumber LIKE 'SO4%_60' AND CreditCardID IS NOT NULL;

-- 10 Registros con el número de orden de venta empezando por SO6, seguido de un dígito 7, o 8 o 9, 
---   seguido de un uno o un cero, seguido de un 3 o un 4 o un 5, seguido de cualquier cosa
SELECT SalesOrderNumber FROM [Sales].[SalesOrderHeader]
WHERE SalesOrderNumber LIKE 'SO6[7-9][0-1][3-5]%'

-- 11 registros con el estado en el conjuto {1,5} y sin tasa de cambio de moneda
SELECT SalesOrderID, [status], CurrencyRateID FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE [Status] IN (1, 5) AND CurrencyRateID IS NULL;

-- 12 Registros con el número de órden de compra empezando por PO1 y cuyo código de aprobación de la tarjeta de crédito contiene "23Vi3"
SELECT PurchaseOrderNumber, CreditCardApprovalCode FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE PurchaseOrderNumber LIKE '%4906%' AND CreditCardApprovalCode  LIKE '%23Vi3%';

SELECT SalesOrderNumber, PurchaseOrderNumber, CreditCardApprovalCode FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE PurchaseOrderNumber LIKE '_____49%';
-- 13 Muestra los registros con el los números de pedido entre 43500 y 43799
SELECT SalesOrderNumber FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE SalesOrderNumber LIKE 'SO43[5-7]%';

-- 14 Registros sin número de orden de compra, ni tarjeta de crédito, si tipo de cambio
SELECT PurchaseOrderNumber, CreditCardID,CurrencyRateID FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE PurchaseOrderNumber IS NULL and CreditCardID IS NULL and CurrencyRateID IS NULL;

-- 15 Muestra el registro con el identificador 
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE rowguid = '79B65321-39CA-4115-9CBA-8FE0903E12E6';

-- 16 Registros con el total debod mayor que la suma del subtotal, el impuesto y el flete
SELECT TotalDue, SubTotal, TaxAmt , Freight FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE  TotalDue >= SubTotal + TaxAmt + Freight;

-- 17 Registro modificados el 7 de Julio de 2011 con la fecha de embarque anterior a la fecha de envío.
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE ShipDate < DueDate  AND ModifiedDate = '2011-06-07 00:00:00.000';

-- 18 comment
select * from [AdventureWorks2022].[Sales].[SalesOrderHeader]
where CustomerID BETWEEN 29500 AND 30000 AND status = 5;

-- 19 Pedidos con un coste de flete superios a 250 que tenga direccion de facturación y de envío diferentes
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE ShipToAddressID != BillToAddressID AND Freight > 250;

-- 20 Pedidos con un subtotal mayor de 10000 cuyo codigo de territorio pertenece al conjinto {1, 3, 5}
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE TerritoryID IN (1, 3, 5) AND SubTotal > 10000;

-- 21 comment
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE OrderDate >= '2011-05-01' AND OrderDate <= '2011-06-01';

-- 22 Pedidos con subtotal mayor de 15 000, flete menor de 200 y método de envío cinco
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE ShipMethodID = 5 AND Freight < 200 AND SubTotal > 15000;

SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE ShipMethodID = 5 OR (Freight < 200 AND SubTotal > 15000);
-- 23 Registros con Status 5 y final de número de cuenta 28x
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE Status = 5 AND AccountNumber LIKE '%0-00028%';

-- 24 Para los Pedidos con un subtotal superior a 10000 y 
-- un coste de flete superior al 5% del subtotal, 
-- muestra  en cuantos dólares el flete excede al 5% del subtotal
SELECT SalesOrderID, 
PurchaseOrderNumber, 
SubTotal, 
SubTotal * 0.05 as fivePercent, 
Freight,  
Freight - (SubTotal * 0.05) as excess 
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE SubTotal * 0.05 <= Freight AND SubTotal > 10000;

-- 25 Pedidos con un subtotal superior a 10000 y un coste de flete superior al 5% del subtotal
SELECT SalesOrderID, SubTotal, SubTotal * 0.05 as fivePercent, Freight FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE SubTotal * 0.05 <= Freight AND SubTotal > 10000;



