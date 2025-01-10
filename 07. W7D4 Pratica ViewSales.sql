CREATE VIEW Sales AS
    (SELECT 
		frs.OrderDate AS DataOrdine,
        frs.SalesOrderNumber AS CodiceDocumento,
        frs.SalesOrderLineNumber AS LineaDocumento,
        frs.ProductKey,
        frs.ResellerKey,
        frs.OrderQuantity AS QuantitaVenduta,
        frs.UnitPrice AS PrezzoUnitario,
        frs.TotalProductCost AS CostoProdotto,
        frs.SalesAmount AS ImportoTotale,
        CASE
            WHEN TotalProductCost IS NULL THEN frs.SalesAmount - frs.OrderQuantity * pr.StandardCost
            ELSE SalesAmount - TotalProductCost
        END AS Profitto
    FROM
        factresellersales frs
            INNER JOIN
        dimproduct AS pr ON frs.ProductKey = pr.ProductKey)
;