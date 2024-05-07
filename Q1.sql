--Query1
SELECT 
    c.CustomerID,
    c.CustomerName,
    COALESCE(Orders.TotalNBOrders, 0) AS TotalNBOrders,
    COALESCE(Invoices.TotalNBInvoices, 0) AS TotalNBInvoices,
    COALESCE(Orders.OrdersTotalValue, 0) AS OrdersTotalValue,
    COALESCE(Invoices.InvoicesTotalValue, 0) AS InvoicesTotalValue,
    ABS(COALESCE(Orders.OrdersTotalValue, 0) - COALESCE(Invoices.InvoicesTotalValue, 0)) AS AbsoluteValueDifference
FROM 
    WideWorldImporters.Sales.Customers AS c
LEFT JOIN 
    (SELECT 
         o.CustomerID,
         COUNT(DISTINCT o.OrderID) AS TotalNBOrders,
         SUM(ol.Quantity * ol.UnitPrice) AS OrdersTotalValue
     FROM 
         WideWorldImporters.Sales.Orders AS o
     JOIN 
         WideWorldImporters.Sales.OrderLines AS ol ON o.OrderID = ol.OrderID
     GROUP BY 
         o.CustomerID) Orders ON c.CustomerID = Orders.CustomerID
LEFT JOIN 
    (SELECT 
         i.CustomerID,
         COUNT(DISTINCT i.InvoiceID) AS TotalNBInvoices,
         SUM(il.Quantity * il.UnitPrice) AS InvoicesTotalValue
     FROM 
         WideWorldImporters.Sales.Invoices AS i
     JOIN 
         WideWorldImporters.Sales.InvoiceLines AS il ON i.InvoiceID = il.InvoiceID
     GROUP BY 
         i.CustomerID) Invoices ON c.CustomerID = Invoices.CustomerID
ORDER BY 
    AbsoluteValueDifference DESC, 
    TotalNBOrders, 
    c.CustomerName;
