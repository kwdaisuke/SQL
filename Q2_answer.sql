UPDATE Sales.InvoiceLines
SET Sales.InvoiceLines.UnitPrice = Sales.InvoiceLines.UnitPrice + 20
WHERE Sales.InvoiceLines.InvoiceLineID = (
SELECT TOP 1 il.InvoiceLineID
FROM Sales.Customers c
	,Sales.Invoices i
	,Sales.InvoiceLines il
WHERE i.InvoiceID = il.InvoiceID
AND   i.CustomerID = c.CustomerID
AND   i.CustomerID = 1060
ORDER BY il.InvoiceID ASC)