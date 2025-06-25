SELECT CompanyName FROM Orders o
JOIN Customers c ON o.CustomerId = c.CustomerId
WHERE ShipCountry IN (SELECT DISTINCT Country FROM Employees)   


SELECT OrderId, CompanyName, (SELECT SUM(Quantity * UnitPrice * (1 - Discount)) FROM [Order Details] WHERE OrderId = o.OrderId) 
FROM Orders o
JOIN Customers c ON o.CustomerId = c.CustomerId

