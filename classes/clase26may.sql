SELECT OrderId, CustomerId, OrderDate, ShipCountry, Freight, Freight * 1.10 as NuevoFreight, YEAR(OrderDate) as Periodo
FROM Orders
ORDER BY CustomerId, OrderDate DESC

SELECT LastName + ', ' +  FirstName as NombreCompleto FROM Employees  -- Concatenación de cadenas

-- SELECT <atributos / *> FROM <tabla>
-- YEAR() es una función que devuelve el año de una fecha
-- ORDER BY <atributo>

-- TOP 10 devuelve los primeros 10 registros de la consulta:
SELECT TOP 10 OrderId, CustomerId, OrderDate, ShipCountry, Freight, Freight * 1.10 as NuevoFreight, YEAR(OrderDate) as Periodo
FROM Orders
ORDER BY CustomerId, OrderDate DESC

-- WHERE <condición>
SELECT OrderId, CustomerId, OrderDate, ShipCountry, Freight, Freight * 1.10 as NuevoFreight, YEAR(OrderDate) as Periodo
FROM Orders
WHERE Freight > 40 AND Freight < 100 -- WHERE <condición> AND <otra condición> (como en Python o JS)
AND (ShipCountry = 'USA' or ShipCountry = 'Canada') -- se puede negar con NOT: AND NOT (ShipCountry = 'USA' or ShipCountry = 'Canada') 

ORDER BY NuevoGasto DESC

-- BETWEEN <valor1> AND <valor2>
SELECT OrderId, CustomerId, OrderDate, ShipCountry, Freight, Freight * 1.10 as NuevoFreight, YEAR(OrderDate) as Periodo
FROM Orders
WHERE Freight BETWEEN 40 AND 100 -- incluye los rangos minimos y máximos (ej: incluye 40 y 100)
AND (ShipCountry = 'USA' or ShipCountry = 'Canada') 

ORDER BY NuevoGasto DESC

-- IN (<valor1>, <valor2>, ...) permite incluir varios valores en una condición
SELECT OrderId, CustomerId, OrderDate, ShipCountry, Freight, Freight * 1.10 as NuevoFreight, YEAR(OrderDate) as Periodo
FROM Orders
WHERE Freight BETWEEN 40 AND 100 
AND ShipCountry IN ('USA', 'Canada', 'Austria', 'Germany') -- IN es como un OR, pero más legible

ORDER BY NuevoGasto DESC