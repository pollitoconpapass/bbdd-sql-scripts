-- =============================================
-- CONSULTAS CON CÁLCULOS, JOINS, FUNCIONES Y PROCEDIMIENTOS (3 X INTEGRANTE = 15 EN TOTAL)
-- =============================================

-- =============================================
-- 1. Consulta con JOIN - Clientes con sus nutricionistas actuales
SELECT 
    c.nombres + ' ' + c.apellidos AS Cliente,
    n.nombre + ' ' + n.apellidos AS Nutricionista,
    an.fechaAsignacion
FROM Cliente c
INNER JOIN Asignacion_Nutricionista an ON c.idCliente = an.idCliente
INNER JOIN Nutricionista n ON an.idNutricionista = n.idNutricionista
WHERE an.fechaAsignacion = (
    SELECT MAX(fechaAsignacion) 
    FROM Asignacion_Nutricionista 
    WHERE idCliente = c.idCliente
);
-- =============================================

-- =============================================
-- 2. Consulta con cálculo - IMC de todos los Clientes
SELECT 
    nombres + ' ' + apellidos AS Cliente,
    peso,
    altura,
    ROUND(peso / (altura * altura), 2) AS IMC,
    CASE 
        WHEN peso / (altura * altura) < 18.5 THEN 'Bajo peso'
        WHEN peso / (altura * altura) BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN peso / (altura * altura) BETWEEN 25 AND 29.9 THEN 'Sobrepeso'
        ELSE 'Obesidad'
    END AS Clasificacion
FROM Cliente;
-- =============================================

-- =============================================
-- 3. Función para calcular calorías totales de un plan
CREATE FUNCTION fn_CaloriasTotalesPlan(@idPlan INT)
RETURNS INT
AS
BEGIN
    DECLARE @totalCalorias INT;
    
    SELECT @totalCalorias = SUM(a.calorias * dpa.cantidad / 100)
    FROM Detalle_Plan_Alimento dpa
    INNER JOIN Alimentos a ON dpa.idAlimento = a.idAlimento
    WHERE dpa.idPlan = @idPlan;
    
    RETURN ISNULL(@totalCalorias, 0);
END;
GO

-- 3.1. Usar la función creada
SELECT 
    pa.idPlan,
    c.nombres + ' ' + c.apellidos AS Cliente,
    pa.tipoPlan,
    pa.caloriasDiarias AS CaloriasPlanificadas,
    dbo.fn_CaloriasTotalesPlan(pa.idPlan) AS CaloriasReales
FROM Plan_Alimentacion pa
INNER JOIN Cliente c ON pa.idCliente = c.idCliente;
-- =============================================

-- =============================================
-- 4. Procedimiento almacenado - Reporte de actividad de Cliente
CREATE PROCEDURE sp_ReporteActividadCliente
    @idCliente INT
AS
BEGIN
    SELECT 
        'Planes de Alimentación' AS TipoActividad,
        COUNT(*) AS Cantidad
    FROM Plan_Alimentacion 
    WHERE idCliente = @idCliente
    
    UNION ALL
    
    SELECT 
        'Rutinas Completadas' AS TipoActividad,
        COUNT(*) AS Cantidad
    FROM Rutina 
    WHERE idCliente = @idCliente
    
    UNION ALL
    
    SELECT 
        'Recomendaciones Recibidas' AS TipoActividad,
        COUNT(*) AS Cantidad
    FROM Recomendaciones 
    WHERE idCliente = @idCliente;
END;
GO

-- 4.1. Ejecutar el procedimiento almacenado
EXEC sp_ReporteActividadCliente @idCliente = 1;
-- =============================================

-- =============================================
-- 5. Consulta con subconsulta - Clientes más activos
SELECT 
    c.nombres + ' ' + c.apellidos AS Cliente,
    (SELECT COUNT(*) FROM Rutina WHERE idCliente = c.idCliente) AS TotalRutinas,
    (SELECT COUNT(*) FROM Plan_Alimentacion WHERE idCliente = c.idCliente) AS TotalPlanes
FROM Cliente c
WHERE (SELECT COUNT(*) FROM Rutina WHERE idCliente = c.idCliente) > 1
ORDER BY TotalRutinas DESC;
-- =============================================

-- =============================================
-- 6. Consulta con GROUP BY y HAVING - Ejercicios más populares
SELECT 
    e.nombre AS Ejercicio,
    COUNT(*) AS VecesRealizado,
    AVG(CAST(dre.repeticiones AS FLOAT)) AS PromedioRepeticiones,
    AVG(CAST(dre.series AS FLOAT)) AS PromedioSeries
FROM Detalle_Rutina_Ejercicio dre
INNER JOIN Ejercicio e ON dre.idEjercicio = e.idEjercicio
GROUP BY e.idEjercicio, e.nombre
HAVING COUNT(*) >= 2
ORDER BY VecesRealizado DESC;
-- =============================================

-- =============================================
-- 7. Consulta con funciones de fecha - Planes activos en el mes actual
SELECT 
    c.nombres + ' ' + c.apellidos AS Cliente,
    pa.tipoPlan,
    pa.fechaInicio,
    pa.fechaFin,
    DATEDIFF(DAY, pa.fechaInicio, pa.fechaFin) AS DuracionDias
FROM Plan_Alimentacion pa
INNER JOIN Cliente c ON pa.idCliente = c.idCliente
WHERE pa.fechaInicio <= GETDATE() AND pa.fechaFin >= GETDATE();
-- =============================================

-- =============================================
-- 8. Consulta con CASE y cálculos - Análisis de objetivos vs actividad
SELECT 
    c.objetivo,
    COUNT(*) AS CantidadClientes,
    AVG(CAST(c.tiempoDisponible AS FLOAT)) AS PromedioTiempoDisponible,
    CASE 
        WHEN AVG(CAST(c.tiempoDisponible AS FLOAT)) < 60 THEN 'Tiempo Limitado'
        WHEN AVG(CAST(c.tiempoDisponible AS FLOAT)) BETWEEN 60 AND 90 THEN 'Tiempo Moderado'
        ELSE 'Tiempo Amplio'
    END AS ClasificacionTiempo
FROM Cliente c
GROUP BY c.objetivo;
-- =============================================

-- 9. Vista para consultas frecuentes - Resumen de Clientes
CREATE VIEW vw_ResumenClientes AS
SELECT 
    c.idCliente,
    c.nombres + ' ' + c.apellidos AS NombreCompleto,
    c.edad,
    c.objetivo,
    c.nivelActividad,
    ROUND(c.peso / (c.altura * c.altura), 2) AS IMC,
    (SELECT COUNT(*) FROM Plan_Alimentacion WHERE idCliente = c.idCliente) AS TotalPlanes,
    (SELECT COUNT(*) FROM Rutina WHERE idCliente = c.idCliente) AS TotalRutinas,
    (SELECT TOP 1 nombre + ' ' + apellidos 
     FROM Nutricionista n 
     INNER JOIN Asignacion_Nutricionista an ON n.idNutricionista = an.idNutricionista
     WHERE an.idCliente = c.idCliente 
     ORDER BY an.fechaAsignacion DESC) AS NutricionistaActual
FROM Cliente c;
GO

-- 9.1 Consultar la vista creada
SELECT * FROM vw_ResumenClientes WHERE IMC > 25; -- Los que tienen sobrepeso
-- =============================================

-- =============================================
-- 10. Consulta con múltiples JOINs - Detalle completo de rutinas
SELECT 
    c.nombres + ' ' + c.apellidos AS Cliente,
    r.fecha AS FechaRutina,
    r.duracion AS DuracionTotal,
    e.nombre AS Ejercicio,
    dre.repeticiones,
    dre.series,
    e.calorias * dre.series AS CaloriasEjercicio
FROM Cliente c
INNER JOIN Rutina r ON c.idCliente = r.idCliente
INNER JOIN Detalle_Rutina_Ejercicio dre ON r.idRutina = dre.idRutina
INNER JOIN Ejercicio e ON dre.idEjercicio = e.idEjercicio
ORDER BY c.idCliente, r.fecha, e.nombre;
-- =============================================

-- =============================================
-- 11. Función para obtener el nutricionista actual de un Cliente
CREATE FUNCTION fn_NutricionistaActual(@idCliente INT)
RETURNS VARCHAR(101)
AS
BEGIN
    DECLARE @nutricionista VARCHAR(101);
    
    SELECT TOP 1 @nutricionista = n.nombre + ' ' + n.apellidos
    FROM Nutricionista n
    INNER JOIN Asignacion_Nutricionista an ON n.idNutricionista = an.idNutricionista
    WHERE an.idCliente = @idCliente
    ORDER BY an.fechaAsignacion DESC;
    
    RETURN ISNULL(@nutricionista, 'Sin asignar');
END;
GO

-- 11.1 Consultar la función creada (para un Cliente específico)
SELECT dbo.fn_NutricionistaActual(5) AS NutricionistaAsignado; -- Nutricionista actual del Cliente con ID 5

-- 11.2 Consultar la función creada para todos los Clientes
SELECT  -- Para todos los Clientes
    c.idCliente,
    c.nombres AS NombreCliente,
    dbo.fn_NutricionistaActual(c.idCliente) AS NutricionistaAsignado
FROM Cliente c;
-- =============================================

-- =============================================
-- 12. Consulta con ranking - Top Clientes por actividad usando funciones de ventana
SELECT 
    nombres + ' ' + apellidos AS Cliente,
    TotalActividades,
    RANK() OVER (ORDER BY TotalActividades DESC) AS Ranking,
    CASE 
        WHEN RANK() OVER (ORDER BY TotalActividades DESC) <= 2 THEN 'Muy Activo'
        WHEN RANK() OVER (ORDER BY TotalActividades DESC) <= 4 THEN 'Activo'
        ELSE 'Poco Activo'
    END AS NivelActividad
FROM (
    SELECT 
        c.idCliente,
        c.nombres,
        c.apellidos,
        (SELECT COUNT(*) FROM Plan_Alimentacion WHERE idCliente = c.idCliente) +
        (SELECT COUNT(*) FROM Rutina WHERE idCliente = c.idCliente) +
        (SELECT COUNT(*) FROM Recomendaciones WHERE idCliente = c.idCliente) AS TotalActividades
    FROM Cliente c
) AS ActividadesPorCliente
ORDER BY Ranking;
-- =============================================

-- =============================================
-- 13. Consulta de Lista sobre los datos en base a su objetivo, por medio de su alimentacion y ejercicio a detalle
select MAX(c.nombres +'
, '+ c.apellidos) as nombre_Completo, MAX(c.objetivo) as objetivo, dpa. tiempoComida, MAX(a.nombre) as alimentoPrincipal,
MAX(a. tipoAlimento) as tipoAlimento, sum(a. calorias) as cantidadCaloriasEntrantes, MIN(e.nombre) as ejercicio
_Finishet, count (e.duracion) as cantidad
Lejercicios,
SUM(e.duracion) as duracionEjercicios, sum(e calorias) as CantidadCaloriasSalientes
from Cliente c
JOIN Plan _Alimentacion pa ON c.idCliente = pa. idCliente
JOIN Detalle_Plan _Alimento dpa ON pa. idPlan = dpa. idPlan
JOIN Alimentos a ON dpa. idAlimento = a. idAlimento
JOIN Rutina r ON c.idCliente = r. idCliente
JOIN Detalle
_Rutina_Ejercicio dre ON r. idRutina = dre. idRutina
JOIN Ejercicio e ON dre idEjercicio = e idEjercicio
Group by dpa. tiempoComida, c. idCliente order by MIN(c.idCliente), count (tiempoComida)
-- =============================================

-- =============================================
-- 14. Funcion para obtener la hora de la comida mas consumida
create or alter function dbo.HoraMASComelona
(@usuario varchar(20))
returns Varchar (20)
As
BEGIN
DECLARE @ComidaTempo Varchar (20)
DECLARE @contador Varchar (20)
Select top 1 @contador = count(dpa.idAlimento), @ComidaTempo = dpa.tiempoComida FROM Cliente c
JOIN Plan_Alimentacion pa ON c.idCliente = pa.idCliente
JOIN Detalle_Plan_Alimento dpa ON pa.idPlan = dpa.idPlan
JOIN Alimentos a ON dpa.idAlimento = a.idAlimento
WHERE c.nombres = @usuario
group by c.nombres, c.apellidos, dpa.tiempoComida
Return @ComidaTempo
end
-- 14.1 llamada a la funcion
select dbo. HoraMASComelona ('Alan Gabriel') as hora_mas_comelona
-- =============================================

-- =============================================
-- 15. Procedimiento almacenado para obtener la lista de usuarios por entrenador
Create or alter Procedure uspListadeUsuariosXEntrenador(
@entrenadoreti varchar(15))
AS
BEGIN
select c.nombres, c.apellidos, c.nivelActividad, c.peso, c.altura, ae.fechaAsignacion From cliente c
JOIN Asignacion_Entrenador ae ON c.idCLiente = ae.idCliente
JOIN Entrenador e ON ae.idEntrenador = e.idEntrenador
WHERE e.nombre= @entrenadoreti
END
-- 15.1 ejecutar lista
exec uspListadeUsuariosXEntrenador 'José Antonio'
-- =============================================