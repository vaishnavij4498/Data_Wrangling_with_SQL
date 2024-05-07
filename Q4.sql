--Query 4
SELECT ml.CustomerCategoryName,
       ml.MaxLoss,
       olss.CustomerName,
       olss.CustomerID
FROM (
    SELECT cc.CustomerCategoryName,
           MAX(ol.Quantity * ol.UnitPrice) AS MaxLoss
    FROM WideWorldImporters.Sales.Orders AS o
    JOIN WideWorldImporters.Sales.OrderLines AS ol ON o.OrderID = ol.OrderID
    JOIN WideWorldImporters.Sales.Customers AS c ON o.CustomerID = c.CustomerID
    JOIN WideWorldImporters.Sales.CustomerCategories AS cc ON c.CustomerCategoryID = cc.CustomerCategoryID
    WHERE NOT EXISTS (
            SELECT 1
            FROM WideWorldImporters.Sales.Invoices AS i
            WHERE i.OrderID = o.OrderID
        )
    GROUP BY cc.CustomerCategoryName
) AS ml
JOIN (
    SELECT c.CustomerName,
           c.CustomerID,
           cc.CustomerCategoryName,
           SUM(ol.Quantity * ol.UnitPrice) AS TotalLost
    FROM WideWorldImporters.Sales.Orders AS o
    JOIN WideWorldImporters.Sales.OrderLines AS ol ON o.OrderID = ol.OrderID
    JOIN WideWorldImporters.Sales.Customers AS c ON o.CustomerID = c.CustomerID
    JOIN WideWorldImporters.Sales.CustomerCategories AS cc ON c.CustomerCategoryID = cc.CustomerCategoryID
    WHERE NOT EXISTS (
            SELECT 1
            FROM WideWorldImporters.Sales.Invoices AS i
            WHERE i.OrderID = o.OrderID
        )
    GROUP BY c.CustomerName, c.CustomerID, cc.CustomerCategoryName
) AS olss ON ml.CustomerCategoryName = olss.CustomerCategoryName AND ml.MaxLoss = olss.TotalLost
ORDER BY ml.MaxLoss DESC;

