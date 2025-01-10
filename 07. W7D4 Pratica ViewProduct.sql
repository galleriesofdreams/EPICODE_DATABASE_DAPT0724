CREATE VIEW Product AS
    (SELECT 
        EnglishProductName AS NomeProdotto,
        ProductKey AS CodiceProdotto,
        s.ProductCategoryKey AS CategoriaProdotto,
        s.ProductSubcategoryKey AS SottocategoriaProdotto
    FROM
        dimproduct p
            INNER JOIN
        dimproductsubcategory s ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
            INNER JOIN
        dimproductcategory c ON s.ProductCategoryKey = c.ProductCategorykey)
;
	

    