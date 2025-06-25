SELECT OrderId, CustomerId, OrderDate, Freight, ShipCountry, ShipName FROM Orders
WHERE Freight BETWEEN 40 AND 100
AND ShipCountry IN ('Germany', 'Austria', 'Brazil')
AND ShipName LIKE '%to%' -- LIKE da un resultado que se parezca con la cadena que le indiques
                            -- % permite obviar cualquier cosa adelante o atrás
ORDER BY Freight DESC

-- Calculos /* SUM, AVG, MIN, MAX, COUNT */
SELECT  ShipCountry, SUM(Freight) as GastoTotal, AVG(Freight) as Promedio, COUNT(ShipCountry) as CantidadVeces, MIN(Freight) as GastoMinimo, MAX(Freight) as GastoMaximo
FROM Orders
GROUP BY ShipCountry
ORDER BY GastoTotal DESC

-- HAVING (se usa en los calculos, para agrupar los calculos)
SELECT  ShipCountry, SUM(Freight) as GastoTotal, AVG(Freight) as Promedio, COUNT(ShipCountry) as CantidadVeces, MIN(Freight) as GastoMinimo, MAX(Freight) as GastoMaximo
FROM Orders
GROUP BY ShipCountry
HAVING COUNT(ShipCountry) > 80 -- "cuando el contador de paises es mayor a 80"
ORDER BY GastoTotal DESC

-- JOIN
SELECT * FROM Categories
SELECT * FROM Products

/* Ambos tienen CategoryID como mismo valor */
SELECT ProductId, ProductName, UnitPrice, p.CategoryID, CategoryName FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID


-- Ejercicio:
SELECT ProductId, ProductName, UnitPrice, p.CategoryID, CategoryName, p.SupplierID, CompanyName FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
