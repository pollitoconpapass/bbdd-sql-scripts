/* Ejercicio 1: Crear una funcion que retorne el pasís de procedencia del cliente con la menor
 cantidad de pedidos atendidos para un determinado año
*/
-- SELECT ShipCountry FROM Orders WHERE YEAR(OrderDate) = 2006 GROUP BY ShipCountry ORDER BY COUNT(ShipCountry) ASC
-- GO

-- CREATE FUNCTION fnPedidosAtendidos(@anio int)
-- RETURNS TABLE
-- AS
-- RETURN (
--     SELECT ShipCountry FROM Orders WHERE YEAR(OrderDate) = @anio GROUP BY ShipCountry ORDER BY COUNT(ShipCountry) ASC
-- )
-- GO

-- SELECT * FROM fnPedidosAtendidos(2006)

CREATE FUNCTION dbo.fPaisTOP1
( @periodo int)
RETURNS varchar(50)
AS 
BEGIN
    DECLARE @pais varchar(50)

    SELECT TOP 1 @pais=Country FROM Customers c 
    JOIN Orders o ON c.CustomerId = o.CustomerId
    WHERE YEAR(OrderDate) = @periodo
    GROUP BY Country, o.CustomerId ORDER BY COUNT(OrderId) ASC
    RETURN @pais
END


/* Ejercicio 2: Crear un procedimiento almacenado o funcion que retorne el nombre del embarcador con mayor cantidad de pedidos atendidos 
para un determinado pais de destino, el cual es ingresado como parametro */