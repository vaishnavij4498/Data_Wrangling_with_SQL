--Query 4
WITH OrderLoss AS
(SELECT c.CustomerName, c.CustomerID, 
cc.CustomerCategoryName, SUM(ol.Quantity*ol.UnitPrice) 
AS TotalLost
FROM WideWorldImporters.Sales.CustomerCategories AS cc 
JOIN WideWorldImporters.Sales.Customers AS c  
ON cc.CustomerCategoryID = c.CustomerCategoryID
JOIN WideWorldImporters.Sales.Orders AS o
ON c.CustomerID = o.CustomerID
JOIN WideWorldImporters.Sales.OrderLines AS ol 
ON ol.OrderID = o.OrderID 
WHERE NOT EXISTS
(
SELECT i.CustomerID
FROM WideWorldImporters.Sales.Invoices AS i
WHERE i.OrderID = o.OrderID
)
GROUP BY  c.CustomerName, 
c.CustomerID, 
cc.CustomerCategoryName
), MaxLossInsideCategory AS 
(SELECT ols.CustomerCategoryName, MAX(TotalLost) AS MaxLoss
FROM OrderLoss As ols
GROUP BY ols.CustomerCategoryName)

SELECT ml.CustomerCategoryName, ml.MaxLoss, 
olss.CustomerName, olss.CustomerID
FROM MaxLossInsideCategory AS ml 
JOIN OrderLoss AS olss ON ml.MaxLoss = olss.TotalLost 
AND ml.CustomerCategoryName = olss.CustomerCategoryName
GROUP BY ml.CustomerCategoryName, ml.MaxLoss,
olss.CustomerName, olss.CustomerID
ORDER BY MaxLoss DESC
