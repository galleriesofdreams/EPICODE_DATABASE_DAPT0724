/* 1. Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia? */

SELECT
	ProductKey
FROM 
	dimproduct
GROUP BY
	ProductKey
HAVING
	count(*)>1;

/* 2. Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.*/

SELECT
	concat(SalesOrderNumber
    ,SalesOrderLineNumber) AS pk
FROM 
	factresellersales
GROUP BY
	pk
HAVING
	count(*)>1;
    
/* 3. Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.*/

WITH total_sales AS ( SELECT * FROM (
SELECT 
'res' as channel,
frs.SalesOrderNumber,
frs.SalesOrderLineNumber,
frs.OrderDate,
frs.ProductKey,
frs.OrderQuantity,
frs.UnitPrice,
frs.TotalProductCost,
frs.SalesAmount
FROM factresellersales frs
UNION
SELECT 
'int' as channel,
fis.SalesOrderNumber,
fis.SalesOrderLineNumber,
fis.OrderDate,
fis.ProductKey,
fis.OrderQuantity,
fis.UnitPrice,
fis.TotalProductCost,
fis.SalesAmount
FROM factinternetsales fis) as A
ORDER BY A.OrderDate)
SELECT
    OrderDate,
    channel,
    count(SalesOrderLineNumber) as lineeordine
    FROM
    total_sales
    GROUP BY 
    OrderDate, 
    channel
    HAVING 
    OrderDate >= '2020-01-01'
    order by Orderdate;
    
/* 4. Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) e il prezzo medio di vendita 
(FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, 
il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!*/

SELECT
	OrderDate,
	p.EnglishProductName,
	SUM(f.SalesAmount) AS VenditeTotali,
    SUM(f.OrderQuantity) AS OrdiniTotali,
    AVG(f.UnitPrice) AS PrezzoMedio
FROM
	factresellersales f
LEFT JOIN
	dimproduct p
ON 
	p.ProductKey = f.ProductKey
GROUP BY
	f.OrderDate,
    p.EnglishProductName
HAVING
	f.OrderDate >= '2020-01-01'
;


/* 1. Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) 
per Categoria prodotto (DimProductCategory). Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. 
I campi in output devono essere parlanti! */

SELECT
	EnglishProductCategoryName AS CategoriaProdotto,
	sum(f.SalesAmount) AS FatturatoTotale,
    sum(f.OrderQuantity) AS QuantitaTotale
FROM
	factresellersales f
INNER JOIN
	dimproduct p
ON
	f.productkey = p.productkey
INNER JOIN
	dimproductsubcategory s
ON
	p.ProductSubcategoryKey = s.ProductSubcategoryKey
INNER JOIN
	dimproductcategory c
ON 
	s.ProductcategoryKey = c.ProductCategoryKey
GROUP BY
	c.EnglishProductCategoryName;

/* 2. Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K. */

SELECT 
    CITY AS CITTA, SUM(SalesAmount) AS FATTURATO
FROM
    factresellersales A
        LEFT JOIN
    dimproduct B ON A.ProductKey = B.ProductKey
        LEFT JOIN
    dimreseller E ON E.ResellerKey = A.ResellerKey
        LEFT JOIN
    dimgeography F ON F.GeographyKey = E.GeographyKey
WHERE
    A.ORDERDATE >= '2020-01-01'
GROUP BY 1
HAVING SUM(SalesAmount) > 60000
ORDER BY 2 DESC;