-- =============================================
-- CONSULTAS ADICIONALES DE ANÁLISIS Y REPORTES
-- =============================================

-- Consulta adicional 1: Procedimiento para generar reporte mensual
CREATE PROCEDURE sp_ReporteMensual
    @mes INT,
    @anio INT
AS
BEGIN
    DECLARE @fechaInicio DATE = DATEFROMPARTS(@anio, @mes, 1);
    DECLARE @fechaFin DATE = EOMONTH(@fechaInicio);
    
    SELECT 
        'Nuevos Planes Creados' AS Metrica,
        COUNT(*) AS Valor
    FROM Plan_Alimentacion
    WHERE fechaInicio BETWEEN @fechaInicio AND @fechaFin
    
    UNION ALL
    
    SELECT 
        'Rutinas Completadas' AS Metrica,
        COUNT(*) AS Valor
    FROM Rutina
    WHERE fecha BETWEEN @fechaInicio AND @fechaFin
    
    UNION ALL
    
    SELECT 
        'Recomendaciones Generadas' AS Metrica,
        COUNT(*) AS Valor
    FROM Recomendaciones
    WHERE fechaGeneracion BETWEEN @fechaInicio AND @fechaFin;
END;
GO

-- Ejemplo de uso del reporte mensual
EXEC sp_ReporteMensual @mes = 1, @anio = 2025;

-- Consulta adicional 2: Análisis de costos de planes alimenticios
SELECT 
    pa.idPlan,
    u.nombres + ' ' + u.apellidos AS Usuario,
    pa.tipoPlan,
    SUM(a.precio * dpa.cantidad / 100) AS CostoTotal,
    AVG(a.precio * dpa.cantidad / 100) AS CostoPromedioPorAlimento,
    COUNT(DISTINCT dpa.idAlimento) AS CantidadAlimentosDistintos
FROM Plan_Alimentacion pa
INNER JOIN Usuario u ON pa.idUsuario = u.idUsuario
INNER JOIN Detalle_Plan_Alimento dpa ON pa.idPlan = dpa.idPlan
INNER JOIN Alimentos a ON dpa.idAlimento = a.idAlimento
GROUP BY pa.idPlan, u.nombres, u.apellidos, pa.tipoPlan
ORDER BY CostoTotal DESC;

-- Consulta adicional 3: Función para calcular edad en años exactos
CREATE FUNCTION fn_CalcularEdadExacta(@fechaNacimiento DATE)
RETURNS DECIMAL(5,2)
AS
BEGIN
    RETURN DATEDIFF(DAY, @fechaNacimiento, GETDATE()) / 365.25;
END;
GO

-- Consulta adicional 4: Trigger para auditoría de cambios en planes
CREATE TABLE Auditoria_Planes (
    idAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    idPlan INT,
    accion VARCHAR(20),
    usuario_sistema VARCHAR(50),
    fecha_cambio DATETIME DEFAULT GETDATE(),
    valores_anteriores VARCHAR(500),
    valores_nuevos VARCHAR(500)
);
GO

CREATE TRIGGER tr_AuditoriaPlan
ON Plan_Alimentacion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Para INSERT
    IF EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    BEGIN
        INSERT INTO Auditoria_Planes (idPlan, accion, usuario_sistema, valores_nuevos)
        SELECT 
            idPlan, 
            'INSERT', 
            SYSTEM_USER,
            'Nuevo plan: ' + tipoPlan + ', Calorías: ' + CAST(caloriasDiarias AS VARCHAR)
        FROM inserted;
    END
    
    -- Para UPDATE
    IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
    BEGIN
        INSERT INTO Auditoria_Planes (idPlan, accion, usuario_sistema, valores_anteriores, valores_nuevos)
        SELECT 
            i.idPlan,
            'UPDATE',
            SYSTEM_USER,
            'Anterior: ' + d.tipoPlan + ', Calorías: ' + CAST(d.caloriasDiarias AS VARCHAR),
            'Nuevo: ' + i.tipoPlan + ', Calorías: ' + CAST(i.caloriasDiarias AS VARCHAR)
        FROM inserted i
        INNER JOIN deleted d ON i.idPlan = d.idPlan;
    END
    
    -- Para DELETE
    IF EXISTS(SELECT * FROM deleted) AND NOT EXISTS(SELECT * FROM inserted)
    BEGIN
        INSERT INTO Auditoria_Planes (idPlan, accion, usuario_sistema, valores_anteriores)
        SELECT 
            idPlan,
            'DELETE',
            SYSTEM_USER,
            'Plan eliminado: ' + tipoPlan + ', Calorías: ' + CAST(caloriasDiarias AS VARCHAR)
        FROM deleted;
    END
END;
GO