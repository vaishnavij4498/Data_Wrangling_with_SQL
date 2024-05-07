# Data_Wrangling_with_SQL
#Q1
Using the database WideWorldImporters, write a SQL query which reports the consistency between orders and their attached invoices.
The resultset should report for each (CustomerID, CustomerName)
 a. the total number of orders: TotalNBOrders
 b. the number of invoices converted from an order: TotalNBInvoices
 c. the total value of orders: OrdersTotalValue
 d. the total value of invoices: InvoicesTotalValue
 f. the absolute value of the difference between c - d: AbsoluteValueDifference
 
 The resultset must be sorted by highest values of AbsoluteValueDifference, then by smallest to highest values of TotalNBOrders and CustomerName is that order.
 
 Please note that all values in a & b must be identical by definition of the query, as we are observing orders converted into invoices.
We are looking for potential differences between c & d.
BUT, you must find them consistent as the data is clean in WideWorldImporters.
Resultset enclosed in Q1-Resultset_Corrected.csv

#Q2
Q2. For the CustomerId = 1060 (CustomerName = 'Anand Mudaliyar')
Identify the first InvoiceLine of his first Invoice, where "first" means the lowest respective IDs, and write an update query increasing the UnitPrice of this InvoiceLine by 20.

A re-run of the query in Q1 gives the resultset in Q2-Resultset_Corrected.csv (corrected on 15th April 2018 - Summed values in columns OrdersTotalValue & InvoicesTotalValue were incorrect) .

If you haven't managed to answer Q1, add the following selection query to the previous update query: CustomerId, CustomerName, InvoiceTotal.
The latter is the sum of all invoice lines for the target invoice.
The target InvoiceID is purposefully not shown, but the resultset post-update is given in Q2-Alternative-Resultset.csv 

#Q3
Q3.
Using the database WideWorldImporters, write a T-SQL stored procedure called ReportCustomerTurnover.
This procedure takes two parameters: Choice and Year, both integers.

When Choice = 1 and Year = <aYear>, ReportCustomerTurnover selects all the customer names and their total monthly turnover (invoiced value) for the year <aYear>.

When Choice = 2 and Year = <aYear>, ReportCustomerTurnover  selects all the customer names and their total quarterly (3 months) turnover (invoiced value) for the year <aYear>.

When Choice = 3, the value of Year is ignored and ReportCustomerTurnover  selects all the customer names and their total yearly turnover (invoiced value).

When no value is provided for the parameter Choice, the default value of Choice must be 1.
When no value is provided for the parameter Year, the default value is 2013. This doesn't impact Choice = 3.

For Choice = 3, the years can be hard-coded within the range of [2013-2016].

NULL values in the resultsets are not acceptable and must be substituted to 0.

All output resultsets are ordered by customer names alphabetically.

Example datasets are provided for the following calls:
EXEC dbo.ReportCustomerTurnover;
EXEC dbo.ReportCustomerTurnover 1, 2014;
EXEC dbo.ReportCustomerTurnover 2, 2015;
EXEC dbo.ReportCustomerTurnover 3;

#Q4
Q4. In the database WideWorldImporters, write a SQL query which reports the highest loss of money from orders not being converted into invoices, by customer category.

The name and id of the customer who generated this highest loss must also be identified. The resultset is ordered by highest loss.

You should be able to write it in pure SQL, but if too challenging, you may use T-SQL and cursors.
Resultset enclosed in Q4-Resultset.csv

#Q5
Q5. In the database SQLPlayground, write a SQL query selecting all the customers' data who have purchased all the products AND have bought more than 50 products in total (sum of all purchases).

Resultset enclosed in Q5-Resultset.csv


