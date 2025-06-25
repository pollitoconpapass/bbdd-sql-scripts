/*SELECT ProductID, ProductName, CategoryName, UnitPrice FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Suppliers s ON p.SupplierID = s.SupplierID*/

-- UPDATE orders set EmployeeID = null
-- WHERE OrderId > 11070

SELECT OrderId, CustomerId, EmployeeID 
FROM Orders o JOIN Employees e ON e.EmployeeID = o.EmployeeID

--   LEFT  <---->    RIGHT 
-- Con RIGHT JOIN le da prioridad a la tabla de la derecha (en este caso: Employees)
SELECT OrderId, CustomerId, EmployeeID 
FROM Orders o RIGHT JOIN Employees e ON e.EmployeeID = o.EmployeeID

INSERT INTO Employees (LastName, FirstName) VALUES ('Gutierrez', 'Juan')


-- CROSS JOIN crea una combinación de todos los valores de ambas tablas, incluso cuando no hay conexión entre ellas
SELECT * FROM Suppliers
CROSS JOIN Categories 


-- Filtros 
SELECT o.CustomerId, CompanyName, o.EmployeeId
LastName + ' ' + FirstName as Empleado, ShipCountry, Freight, SUM(Freight), AVG(Freight)
FROM Orders o 
JOIN Employees e ON o.EmployeeId = e.EmployeeId
JOIN Customers c ON o.CustomerId = c.CustomerId
WHERE c.Country in ('USA', 'UK') and YEAR(OrderDate) = 2017
GROUP BY o.CustomerId, CompanyName, o.EmployeeId, LastName, FirstName, ShipCountry
HAVING AVG(Freight) > 50


-- Subqueries
SELECT CompanyName FROM Customers
WHERE Country in ('USA', 'UK')

SELECT DISTINCT Country FROM Employees

UPDATE Employees SET Country = 'Brazil' WHERE Country is NULL


SELECT CompanyName FROM Customers
WHERE Country in (SELECT DISTINCT Country FROM Employees)

-- SELECT * FROM Products WHERE UnitPrice > 28.8663
SELECT * FROM Products WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)


SELECT OrderId, CustomerId, EmployeeId, -- externo
(SELECT  SUM(UnitPrice * Quantity * (1 - Discount)) FROM [Order Details] od 
WHERE od.OrderId = o.OrderId)  AS ValorTotal -- interno

FROM Orders o 
