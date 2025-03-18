USE Apol_Excel_00;
SELECT * FROM dbo.Datos;

SELECT FORMAT(SUM(Ingresos), 'C', 'en-US') as TOTALINGRESOS FROM dbo.Datos
WHERE Pais_FK = 'ARG' and YEAR(fecha) = 2017 and MONTH(fecha) = 1;

