--Query3
CREATE OR ALTER 
PROCEDURE [dbo].[ReportCustomerTurnover]
(@Choice INT = 1, @Year INT = 2013)
AS 
BEGIN
SET nocount ON;

IF (@Choice = 1)
BEGIN
SELECT CustomerName,
CASE WHEN Jan is null  then 0.00 ELSE Jan  END AS Jan,
CASE WHEN Feb is null  then 0.00 ELSE Feb  END AS Feb,
CASE WHEN Mar is null  then 0.00 ELSE Mar  END AS Mar,
CASE WHEN Apr is null  then 0.00 ELSE Apr  END AS Apr,
CASE WHEN May is null  then 0.00 ELSE May  END AS May,
CASE WHEN Jun is null  then 0.00 ELSE Jun  END AS Jun,
CASE WHEN July is null then 0.00 ELSE July END AS July,
CASE WHEN Aug is null then 0.00  ELSE Aug  END AS Aug,
CASE WHEN Sep is null then 0.00  ELSE Sep  END AS Sep,
CASE WHEN Oct is null then 0.00  ELSE Oct  END AS Oct,
CASE WHEN Nov is null then 0.00  ELSE Nov  END AS Nov,
CASE WHEN Dec is null then 0.00  ELSE Dec  END AS Dec
FROM (SELECT * 
FROM
(
SELECT Cus.CustomerName,COALESCE(Invl.unitprice*Invl.quantity, 0) InvoicesTotalValue,FORMAT(INV.invoicedate,'MMM') MonthInvoiceDate
FROM   WideWorldImporters.Sales.InvoiceLines AS INVL 
	Inner Join WideWorldImporters.Sales.Invoices AS INV
	On INVL.Invoiceid = INV.InvoiceID
	Inner Join 
	WideWorldImporters.Sales.Customers CUS
	On CUS.CustomerID = INV.CustomerID
	Where YEAR(INV.invoicedate) = @Year
	) SourceTable
	PIVOT
	(
	 SUM(InvoicesTotalValue) FOR MonthInvoiceDate IN ([Jan],[Feb],[Mar],[Apr],[May],[Jun],[July],[Aug],[Sep],[Oct],[Nov],[Dec] )
	) PivotTable) A
	ORDER BY CustomerName 
  END;
   
   IF(@Choice = 3)
   BEGIN
    SELECT *
	FROM
	(
	SELECT Cus.CustomerName,COALESCE(Invl.unitprice*Invl.quantity, 0) InvoicesTotalValue,YEAR(INV.invoicedate) YearInvoiceDate
	FROM   WideWorldImporters.Sales.InvoiceLines AS INVL 
	Inner Join WideWorldImporters.Sales.Invoices AS INV
	On INVL.Invoiceid = INV.InvoiceID
	Inner Join 
	WideWorldImporters.Sales.Customers CUS
	On CUS.CustomerID = INV.CustomerID
	Where YEAR(INV.invoicedate) Between 2013 and 2016
	) SourceTable
	PIVOT 
	(
	 SUM(InvoicesTotalValue) FOR YearInvoiceDate IN ([2013],[2014],[2015],[2016])
	) PivotTable
	ORDER BY CustomerName
   END;
END;
