-- Esplora la tabelle dei prodotti (DimProduct)

SELECT 
	* 
FROM 
	DimProduct
;

 -- Interroga la tabella dei prodotti DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, 
 -- Color, StandardCost, FinishedGoodsFlag. Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno.
 
SELECT
ProductKey
, ProductAlternateKey AS "Modello"
, EnglishproductName AS "Nome prodotto"
, Color AS "Colore"
, StandardCost AS "Costo Standard"
, FinishedGoodsFlag AS "ProdottiFiniti"

FROM 
	DimProduct
;

-- Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti 
-- finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.

SELECT
	ProductKey
, ProductAlternateKey AS "Modello"
, EnglishproductName AS "Nome prodotto"
, Color AS "Colore"
, StandardCost AS "Costo Standard"
, FinishedGoodsFlag AS "ProdottiFiniti"

FROM 
	DimProduct

WHERE 
	FinishedGoodsFlag = 1
;

--  Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK.
--  Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost) e il prezzo di listino (ListPrice).

SELECT
	ProductKey
, ProductAlternateKey AS "Modello"
, EnglishproductName AS "Nome prodotto"
, Color AS "Colore"
, StandardCost AS "Costo Standard"
, ListPrice AS "Prezzo di listino"

FROM 
	DimProduct
    
WHERE 
	ProductAlternateKey LIKE "FR%"
OR 
	ProductAlternateKey LIKE "BK%"
;

-- Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dallʼazienda (ListPrice - StandardCost)

SELECT
	ProductKey
, ProductAlternateKey AS "Modello"
, EnglishproductName AS "Nome prodotto"
, Color AS "Colore"
, StandardCost AS "Costo Standard"
, ListPrice AS "Prezzo di listino"
, ListPrice - StandardCost AS "Markup"

FROM 
	DimProduct
    
WHERE 
	ProductAlternateKey LIKE "FR%"
OR 
	ProductAlternateKey LIKE "BK%"
;

-- Scrivi unʼaltra query al fine di esporre lʼelenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.

SELECT
	ProductKey
, ProductAlternateKey AS "Modello"
, EnglishproductName AS "Nome prodotto"
, Color AS "Colore"
, StandardCost AS "Costo Standard"
, ListPrice AS "Prezzo di listino"
, ListPrice - StandardCost AS "Markup"

FROM 
	DimProduct
    
WHERE 
	FinishedGoodsFlag = 1
AND 
	Listprice BETWEEN 1000 AND 2000
;

-- Esplora la tabella degli impiegati aziendali (DimEmployee)

SELECT
	*
FROM 
	dimemployee
;

-- Esponi, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti. 
-- Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.

SELECT
	*

FROM 
	dimemployee
    
WHERE 
	SalesPersonFlag = 1
;

-- Interroga la tabella delle vendite (FactResellerSales). Esponi in output lʼelenco delle transazioni 
-- registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214. 
-- Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).

SELECT
	*
, SalesAmount - TotalProductCost
FROM 
	FactResellerSales
    
WHERE 
	ProductKey IN (597, 598, 477, 214)

AND
	OrderDate > "2020-01-01"
;