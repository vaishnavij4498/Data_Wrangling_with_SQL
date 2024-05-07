--Query2
UPDATE WideWorldImporters.Sales.InvoiceLines
SET WideWorldImporters.Sales.InvoiceLines.UnitPrice 
= WideWorldImporters.Sales.InvoiceLines.UnitPrice + 20
WHERE WideWorldImporters.Sales.InvoiceLines.InvoiceLineID = 
(SELECT TOP(1) il.InvoiceLineID
FROM WideWorldImporters.Sales.InvoiceLines AS il
JOIN WideWorldImporters.Sales.Invoices AS i 
ON il.InvoiceID = i.InvoiceID
JOIN WideWorldImporters.Sales.Orders AS o 
ON i.OrderID = o.OrderID
WHERE o.CustomerID = 1060
ORDER BY il.InvoiceLineID ASC)
