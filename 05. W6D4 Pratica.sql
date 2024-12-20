-- 1. Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory). 
SELECT
	ProductKey
    , EnglishProductName
    , EnglishProductSubcategoryName
FROM 
	dimproduct AS p
INNER JOIN
	DIMPRODUCTSUBCATEGORY AS subcat
ON 
	p.ProductSubcategoryKey = subcat.ProductSubcategoryKey
;

-- 2. Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory). 

SELECT
	ProductKey
    , EnglishProductName
    , EnglishProductSubcategoryName
    , cat.ProductCategoryKey
FROM 
	dimproduct AS p
INNER JOIN
	DIMPRODUCTSUBCATEGORY AS subcat
ON 
	p.ProductSubcategoryKey = subcat.ProductSubcategoryKey
INNER JOIN
	DimProductCategory AS CAT
ON 
	subcat.ProductCategoryKey = cat.ProductCategoryKey
	;

-- 3. Esponi lʼelenco dei soli prodotti venduti (DimProduct, FactResellerSales). 

SELECT DISTINCT
	prod.ProductKey
    , EnglishproductName
FROM
	dimproduct AS prod
INNER JOIN
	factresellersales AS s
ON 
	prod.productkey = s.productkey
;

-- 4. Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1). 

SELECT DISTINCT
	prod.ProductKey
    , EnglishproductName
FROM
	dimproduct AS prod
LEFT JOIN
	factresellersales AS s
ON 
	prod.productkey = s.productkey
WHERE
	prod.FinishedGoodsFlag = 1
AND
	s.ProductKey IS NULL
;

-- 5. Esponi lʼelenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)

SELECT 
	 SalesOrderNumber
    , SalesOrderLineNumber
    , prod.ProductKey
    , prod.EnglishproductName
    , OrderDate
    , UnitPrice
    , OrderQuantity
    , TotalProductCost
FROM
	dimproduct AS prod
RIGHT JOIN
	factresellersales AS s
ON 
	s.productkey = prod.productkey
;

-- 1. Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.

SELECT 
	 SalesOrderNumber
    , SalesOrderLineNumber
	, prod.ProductKey
    , EnglishProductCategoryName
    , prod.EnglishproductName
    , OrderDate
    , UnitPrice
    , OrderQuantity
    , TotalProductCost
FROM
	dimproduct AS prod
RIGHT JOIN
	factresellersales AS s
ON 
	s.productkey = prod.productkey
INNER JOIN
	DIMPRODUCTSUBCATEGORY AS subcat
ON 
	prod.ProductSubcategoryKey = subcat.ProductSubcategoryKey
INNER JOIN
	DimProductCategory AS cat
ON 
	subcat.ProductCategoryKey = cat.ProductCategoryKey
;

-- 2. Esplora la tabella DimReseller.

SELECT
	*
FROM
	dimreseller
;

-- 3. Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica.  

SELECT
	ResellerKey	
    , ResellerName
    , BusinessType
    , City
    , StateProvinceName
    , EnglishCountryRegionName
FROM 
	dimreseller AS r
INNER JOIN
	dimgeography AS g
ON 
	r.GeographyKey = g.GeographyKey
;

/* 4. Esponi lʼelenco delle transazioni di vendita. Il result set deve esporre i campi: 
SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica. */

SELECT 
	 SalesOrderNumber
    , SalesOrderLineNumber
    , OrderDate
    , UnitPrice
    , OrderQuantity
    , TotalProductCost
	, prod.ProductKey
    , prod.EnglishproductName
    , r.ResellerKey	
    , ResellerName
    , BusinessType
    , City
    , StateProvinceName
    , EnglishCountryRegionName
FROM
	dimproduct AS prod
RIGHT JOIN
	factresellersales AS s
ON 
	s.productkey = prod.productkey
INNER JOIN
	dimreseller AS r
ON
    s.resellerkey = r.resellerkey
INNER JOIN
	dimgeography AS g
ON 
	r.GeographyKey = g.GeographyKey
;

 