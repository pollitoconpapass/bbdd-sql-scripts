-- =============================================
-- CONSULTAS CON CÁLCULOS, JOINS, FUNCIONES Y PROCEDIMIENTOS (3 X INTEGRANTE = 15 EN TOTAL)
-- =============================================

-- =============================================
-- 1. Consulta con JOIN - Usuarios con sus nutricionistas actuales
SELECT 
    u.nombres + ' ' + u.apellidos AS Usuario,
    n.nombre + ' ' + n.apellidos AS Nutricionista,
    an.fechaAsignacion
FROM Usuario u
INNER JOIN Asignacion_Nutricionista an ON u.idUsuario = an.idUsuario
INNER JOIN Nutricionista n ON an.idNutricionista = n.idNutricionista
WHERE an.fechaAsignacion = (
    SELECT MAX(fechaAsignacion) 
    FROM Asignacion_Nutricionista 
    WHERE idUsuario = u.idUsuario
);
-- =============================================

-- =============================================
-- 2. Consulta con cálculo - IMC de todos los usuarios
SELECT 
    nombres + ' ' + apellidos AS Usuario,
    peso,
    altura,
    ROUND(peso / (altura * altura), 2) AS IMC,
    CASE 
        WHEN peso / (altura * altura) < 18.5 THEN 'Bajo peso'
        WHEN peso / (altura * altura) BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN peso / (altura * altura) BETWEEN 25 AND 29.9 THEN 'Sobrepeso'
        ELSE 'Obesidad'
    END AS Clasificacion
FROM Usuario;
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
    u.nombres + ' ' + u.apellidos AS Usuario,
    pa.tipoPlan,
    pa.caloriasDiarias AS CaloriasPlanificadas,
    dbo.fn_CaloriasTotalesPlan(pa.idPlan) AS CaloriasReales
FROM Plan_Alimentacion pa
INNER JOIN Usuario u ON pa.idUsuario = u.idUsuario;
-- =============================================

-- =============================================
-- 4. Procedimiento almacenado - Reporte de actividad de usuario
CREATE PROCEDURE sp_ReporteActividadUsuario
    @idUsuario INT
AS
BEGIN
    SELECT 
        'Planes de Alimentación' AS TipoActividad,
        COUNT(*) AS Cantidad
    FROM Plan_Alimentacion 
    WHERE idUsuario = @idUsuario
    
    UNION ALL
    
    SELECT 
        'Rutinas Completadas' AS TipoActividad,
        COUNT(*) AS Cantidad
    FROM Rutina 
    WHERE idUsuario = @idUsuario
    
    UNION ALL
    
    SELECT 
        'Recomendaciones Recibidas' AS TipoActividad,
        COUNT(*) AS Cantidad
    FROM Recomendaciones 
    WHERE idUsuario = @idUsuario;
END;
GO

-- 4.1. Ejecutar el procedimiento almacenado
EXEC sp_ReporteActividadUsuario @idUsuario = 1;
-- =============================================

-- =============================================
-- 5. Consulta con subconsulta - Usuarios más activos
SELECT 
    u.nombres + ' ' + u.apellidos AS Usuario,
    (SELECT COUNT(*) FROM Rutina WHERE idUsuario = u.idUsuario) AS TotalRutinas,
    (SELECT COUNT(*) FROM Plan_Alimentacion WHERE idUsuario = u.idUsuario) AS TotalPlanes
FROM Usuario u
WHERE (SELECT COUNT(*) FROM Rutina WHERE idUsuario = u.idUsuario) > 1
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
    u.nombres + ' ' + u.apellidos AS Usuario,
    pa.tipoPlan,
    pa.fechaInicio,
    pa.fechaFin,
    DATEDIFF(DAY, pa.fechaInicio, pa.fechaFin) AS DuracionDias
FROM Plan_Alimentacion pa
INNER JOIN Usuario u ON pa.idUsuario = u.idUsuario
WHERE pa.fechaInicio <= GETDATE() AND pa.fechaFin >= GETDATE();
-- =============================================

-- =============================================
-- 8. Consulta con CASE y cálculos - Análisis de objetivos vs actividad
SELECT 
    u.objetivo,
    COUNT(*) AS CantidadUsuarios,
    AVG(CAST(u.tiempoDisponible AS FLOAT)) AS PromedioTiempoDisponible,
    CASE 
        WHEN AVG(CAST(u.tiempoDisponible AS FLOAT)) < 60 THEN 'Tiempo Limitado'
        WHEN AVG(CAST(u.tiempoDisponible AS FLOAT)) BETWEEN 60 AND 90 THEN 'Tiempo Moderado'
        ELSE 'Tiempo Amplio'
    END AS ClasificacionTiempo
FROM Usuario u
GROUP BY u.objetivo;
-- =============================================

-- 9. Vista para consultas frecuentes - Resumen de usuarios
CREATE VIEW vw_ResumenUsuarios AS
SELECT 
    u.idUsuario,
    u.nombres + ' ' + u.apellidos AS NombreCompleto,
    u.edad,
    u.objetivo,
    u.nivelActividad,
    ROUND(u.peso / (u.altura * u.altura), 2) AS IMC,
    (SELECT COUNT(*) FROM Plan_Alimentacion WHERE idUsuario = u.idUsuario) AS TotalPlanes,
    (SELECT COUNT(*) FROM Rutina WHERE idUsuario = u.idUsuario) AS TotalRutinas,
    (SELECT TOP 1 nombre + ' ' + apellidos 
     FROM Nutricionista n 
     INNER JOIN Asignacion_Nutricionista an ON n.idNutricionista = an.idNutricionista
     WHERE an.idUsuario = u.idUsuario 
     ORDER BY an.fechaAsignacion DESC) AS NutricionistaActual
FROM Usuario u;
GO

-- 9.1 Consultar la vista creada
SELECT * FROM vw_ResumenUsuarios WHERE IMC > 25; -- Los que tienen sobrepeso
-- =============================================

-- =============================================
-- 10. Consulta con múltiples JOINs - Detalle completo de rutinas
SELECT 
    u.nombres + ' ' + u.apellidos AS Usuario,
    r.fecha AS FechaRutina,
    r.duracion AS DuracionTotal,
    e.nombre AS Ejercicio,
    dre.repeticiones,
    dre.series,
    e.calorias * dre.series AS CaloriasEjercicio
FROM Usuario u
INNER JOIN Rutina r ON u.idUsuario = r.idUsuario
INNER JOIN Detalle_Rutina_Ejercicio dre ON r.idRutina = dre.idRutina
INNER JOIN Ejercicio e ON dre.idEjercicio = e.idEjercicio
ORDER BY u.idUsuario, r.fecha, e.nombre;
-- =============================================

-- =============================================
-- 11. Función para obtener el nutricionista actual de un usuario
CREATE FUNCTION fn_NutricionistaActual(@idUsuario INT)
RETURNS VARCHAR(101)
AS
BEGIN
    DECLARE @nutricionista VARCHAR(101);
    
    SELECT TOP 1 @nutricionista = n.nombre + ' ' + n.apellidos
    FROM Nutricionista n
    INNER JOIN Asignacion_Nutricionista an ON n.idNutricionista = an.idNutricionista
    WHERE an.idUsuario = @idUsuario
    ORDER BY an.fechaAsignacion DESC;
    
    RETURN ISNULL(@nutricionista, 'Sin asignar');
END;
GO

-- 11.1 Consultar la función creada (para un usuario específico)
SELECT dbo.fn_NutricionistaActual(5) AS NutricionistaAsignado; -- Nutricionista actual del usuario con ID 5

-- 11.2 Consultar la función creada para todos los usuarios
SELECT  -- Para todos los usuarios
    u.idUsuario,
    u.nombres AS NombreUsuario,
    dbo.fn_NutricionistaActual(u.idUsuario) AS NutricionistaAsignado
FROM Usuario u;
-- =============================================

-- =============================================
-- 12. Consulta con ranking - Top usuarios por actividad usando funciones de ventana
SELECT 
    nombres + ' ' + apellidos AS Usuario,
    TotalActividades,
    RANK() OVER (ORDER BY TotalActividades DESC) AS Ranking,
    CASE 
        WHEN RANK() OVER (ORDER BY TotalActividades DESC) <= 2 THEN 'Muy Activo'
        WHEN RANK() OVER (ORDER BY TotalActividades DESC) <= 4 THEN 'Activo'
        ELSE 'Poco Activo'
    END AS NivelActividad
FROM (
    SELECT 
        u.idUsuario,
        u.nombres,
        u.apellidos,
        (SELECT COUNT(*) FROM Plan_Alimentacion WHERE idUsuario = u.idUsuario) +
        (SELECT COUNT(*) FROM Rutina WHERE idUsuario = u.idUsuario) +
        (SELECT COUNT(*) FROM Recomendaciones WHERE idUsuario = u.idUsuario) AS TotalActividades
    FROM Usuario u
) AS ActividadesPorUsuario
ORDER BY Ranking;
-- =============================================