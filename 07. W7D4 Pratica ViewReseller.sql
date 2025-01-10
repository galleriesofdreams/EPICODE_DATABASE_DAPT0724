CREATE VIEW Reseller AS
    (SELECT 
        ResellerKey,
        r.GeographyKey,
        ResellerAlternateKey,
        Phone,
        BusinessType,
        ResellerName,
        AddressLine1,
        AddressLine2,
        City,
        SalesTerritoryRegion,
        SalesTerritoryCountry
    FROM
        dimreseller r
            LEFT JOIN
        dimgeography g ON r.GeographyKey = g.GeographyKey
            LEFT JOIN
        dimsalesterritory t ON g.SalesTerritoryKey = t.SalesTerritoryKey)

