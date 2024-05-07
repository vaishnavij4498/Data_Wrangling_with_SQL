--Query3
CREATE OR ALTER PROCEDURE [dbo].[ReportCustomerTurnover]
(
    @Choice INT = 1,
    @Year INT = 2013
)
AS 
BEGIN
    SET NOCOUNT ON;

    IF (@Choice = 1)
    BEGIN
        SELECT 
            CustomerName,
            ISNULL(Jan, 0.00) AS Jan,
            ISNULL(Feb, 0.00) AS Feb,
            ISNULL(Mar, 0.00) AS Mar,
            ISNULL(Apr, 0.00) AS Apr,
            ISNULL(May, 0.00) AS May,
            ISNULL(Jun, 0.00) AS Jun,
            ISNULL(July, 0.00) AS July,
            ISNULL(Aug, 0.00) AS Aug,
            ISNULL(Sep, 0.00) AS Sep,
            ISNULL(Oct, 0.00) AS Oct,
            ISNULL(Nov, 0.00) AS Nov,
            ISNULL([Dec], 0.00) AS [Dec]
        FROM 
        (
            SELECT 
                Cus.CustomerName,
                COALESCE(Invl.unitprice * Invl.quantity, 0) AS InvoicesTotalValue,
                FORMAT(INV.invoicedate, 'MMM') AS MonthInvoiceDate
            FROM   
                WideWorldImporters.Sales.InvoiceLines AS INVL 
                INNER JOIN WideWorldImporters.Sales.Invoices AS INV ON INVL.Invoiceid = INV.InvoiceID
                INNER JOIN WideWorldImporters.Sales.Customers CUS ON CUS.CustomerID = INV.CustomerID
            WHERE 
                YEAR(INV.invoicedate) = @Year
        ) AS SourceTable
        PIVOT
        (
            SUM(InvoicesTotalValue) 
            FOR MonthInvoiceDate IN ([Jan],[Feb],[Mar],[Apr],[May],[Jun],[July],[Aug],[Sep],[Oct],[Nov],[Dec])
        ) AS PivotTable
        ORDER BY 
            CustomerName;
    END;
   
    IF (@Choice = 3)
    BEGIN
        SELECT 
            *
        FROM
        (
            SELECT 
                Cus.CustomerName,
                COALESCE(Invl.unitprice * Invl.quantity, 0) AS InvoicesTotalValue,
                YEAR(INV.invoicedate) AS YearInvoiceDate
            FROM   
                WideWorldImporters.Sales.InvoiceLines AS INVL 
                INNER JOIN WideWorldImporters.Sales.Invoices AS INV ON INVL.Invoiceid = INV.InvoiceID
                INNER JOIN WideWorldImporters.Sales.Customers CUS ON CUS.CustomerID = INV.CustomerID
            WHERE 
                YEAR(INV.invoicedate) BETWEEN 2013 AND 2016
        ) AS SourceTable
        PIVOT 
        (
            SUM(InvoicesTotalValue) 
            FOR YearInvoiceDate IN ([2013],[2014],[2015],[2016])
        ) AS PivotTable
        ORDER BY 
            CustomerName;
    END;
END;
