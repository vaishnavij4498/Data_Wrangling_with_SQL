--Query2
UPDATE il
SET il.UnitPrice = il.UnitPrice + 20
FROM WideWorldImporters.Sales.InvoiceLines AS il
JOIN WideWorldImporters.Sales.Invoices AS i ON il.InvoiceID = i.InvoiceID
JOIN WideWorldImporters.Sales.Orders AS o ON i.OrderID = o.OrderID
WHERE o.CustomerID = 1060
AND il.InvoiceLineID = (
    SELECT TOP(1) il2.InvoiceLineID
    FROM WideWorldImporters.Sales.InvoiceLines AS il2
    JOIN WideWorldImporters.Sales.Invoices AS i2 ON il2.InvoiceID = i2.InvoiceID
    JOIN WideWorldImporters.Sales.Orders AS o2 ON i2.OrderID = o2.OrderID
    WHERE o2.CustomerID = 1060
    ORDER BY il2.InvoiceLineID ASC
);
