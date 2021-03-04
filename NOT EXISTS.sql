
/*Is there any orders not converted into an invoice?*/
SELECT *
FROM 
Sales.Orders o
WHERE NOT EXISTS
(SELECT *
FROM Sales.Invoices i
WHERE o.OrderID = i.OrderID)

https://stackoverflow.com/questions/9775693/are-the-sql-concepts-left-outer-join-and-where-not-exists-basically-the-same
/*Use Left Outer Join*/
SELECT*
FROM Sales.Orders o
LEFT OUTER JOIN Sales.Invoices i
ON o.OrderID = i.OrderID
WHERE i.OrderID IS NULL