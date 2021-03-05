USE WideWorldImporters

SELECT
	t.CustomerID,
	t.CustomerName,
	SUM(t.NBTotalOrders) AS NBTotalOrders, 
	SUM(t.NBTotalInvoices) AS NBTotalInvoices,
	SUM(t.OrderTotalValue) AS OrdersTotalValue,
	SUM(t.InvoicesTotalValue) AS InvoicesTotalValue,
	ABS(SUM(t.InvoicesTotalValue - t.OrderTotalValue )) AS AbsoluteValueDifference
FROM
	(
		SELECT
			Cu.CustomerID
			, Cu.CustomerName

			, (
					SELECT SUM(il.Quantity*il.UnitPrice)
					FROM Sales.Orders o
							,Sales.Invoices i
							,Sales.InvoiceLines il
					WHERE	o.CustomerID = Cu.CustomerID
							AND o.OrderID = i.OrderID
							AND i.InvoiceID = il.InvoiceID 
					) AS InvoicesTotalValue

			 , (	SELECT SUM(oi.Quantity*oi.UnitPrice)
					FROM Sales.Orders Od
							,Sales.Invoices i
							,Sales.OrderLines oi
					WHERE	i.CustomerID = Cu.CustomerID
							AND Od.OrderID = oi.OrderID
							AND Od.OrderID = i.OrderID		
					) AS OrderTotalValue

			  ,	(
					SELECT	COUNT(DISTINCT o.OrderID)
					FROM	Sales.Orders o,
							Sales.OrderLines oi,
							Sales.Invoices i
					WHERE	
							o.OrderID = oi.OrderID
							AND o.CustomerID = Cu.CustomerID
							AND o.orderid = i.orderid 
					) AS NBTotalOrders
			  ,	(
			 		SELECT COUNT(DISTINCT i.InvoiceID)
					FROM	Sales.Orders o,
							Sales.Invoices i
					WHERE	o.CustomerID = Cu.CustomerID
							AND o.OrderID = i.OrderID			
					) As NBTotalInvoices
		FROM
			Sales.Customers as Cu
	) as t
GROUP  BY CustomerID, 
          CustomerName
ORDER  BY AbsoluteValueDifference DESC, 
		  NBTotalOrders ASC,
          CustomerName ASC 
