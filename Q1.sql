--Query1
SELECT c.CustomerID, c.CustomerName, TotalOrder.TotalNBOrders,
TotalInvoice.TotalNBInvoices, TotalOrder.OrdersTotalValue,
TotalInvoice.InvoicesTotalValue,
abs(TotalOrder.OrdersTotalValue - 
TotalInvoice.InvoicesTotalValue) AS AbsoluteValueDifference
FROM WideWorldImporters.Sales.Customers AS c
JOIN (SELECT o.CustomerID, COUNT(DISTINCT o.OrderID) 
AS TotalNBOrders,
SUM(ol.Quantity * ol.UnitPrice) AS OrdersTotalValue
FROM WideWorldImporters.Sales.Orders AS o
JOIN WideWorldImporters.Sales.OrderLines AS ol 
ON o.OrderID = ol.OrderID
JOIN WideWorldImporters.Sales.Invoices AS i 
ON o.OrderID = i.OrderID
GROUP BY o.CustomerID) AS TotalOrder
ON TotalOrder.CustomerID = c.CustomerID
JOIN (SELECT i.CustomerID, COUNT(DISTINCT i.InvoiceID) 
AS TotalNBInvoices,
SUM(il.Quantity * il.UnitPrice) 
AS InvoicesTotalValue
FROM WideWorldImporters.Sales.Invoices AS i
JOIN WideWorldImporters.Sales.InvoiceLines 
AS il ON i.InvoiceID = il.InvoiceID
GROUP BY i.CustomerID) TotalInvoice
ON TotalInvoice.CustomerID = c.CustomerID
ORDER BY AbsoluteValueDifference DESC, 
TotalNBOrders, c.CustomerName
