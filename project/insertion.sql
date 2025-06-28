-- =============================================
-- INSERCIÓN DE DATOS - TABLAS MAESTRAS 
-- =============================================

INSERT INTO Cliente (nombres, apellidos, sexo, edad, peso, altura, telefono, correo, objetivo, nivelActividad, tiempoDisponible) VALUES
('Alan Gabriel', 'García Pérez', 'Masculino', 48, 75.5, 1.75, 987654321, 'alangarcia@peru.pe', 'Perder peso', 'Moderado', 70),
('María Elena', 'González López', 'Femenino', 32, 68.2, 1.62, 912345678, 'maria.gonzalez@email.com', 'Ganar masa muscular', 'Alto', 90),
('Carlos Alberto', 'Rodríguez Silva', 'Masculino', 25, 82.0, 1.80, 945678123, 'carlos.rodriguez@email.com', 'Mantener peso', 'Bajo', 45),
('Ana Sofía', 'Martínez Torres', 'Femenino', 29, 55.8, 1.58, 923456789, 'ana.martinez@email.com', 'Perder peso', 'Moderado', 75),
('Luis Fernando', 'Herrera Díaz', 'Masculino', 35, 90.3, 1.85, 956789012, 'luis.herrera@email.com', 'Ganar masa muscular', 'Alto', 120);

-- SELECT * FROM Cliente

INSERT INTO Nutricionista (nombre, apellidos, edad, telefono, correo) VALUES
('Patricia', 'Vásquez Morales', 38, 987123456, 'patricia.vasquez@saludcenter.com'),
('Carmen', 'Jiménez Ruiz', 42, 912876543, 'carmen.jimenez@nutrix.com'),
('Roberto', 'Castillo Mendoza', 45, 945321678, 'roberto.castillo@salud.com'),
('Lucía', 'Fernández Castro', 36, 923654781, 'lucia.fernandez@wellness.com'),
('Miguel', 'Vargas Paredes', 40, 956147382, 'miguel.vargas@nutricenter.com');

-- SELECT * From Nutricionista

INSERT INTO Entrenador (nombre, apellidos, edad, telefono, correo) VALUES
('José Antonio', 'Ramírez López', 30, '987456123', 'jose.ramirez@gym.com'),
('Sandra Milena', 'Cruz Delgado', 28, '912789456', 'sandra.cruz@fitness.com'),
('Fernando', 'Morales Vega', 33, '945123789', 'fernando.morales@training.com'),
('Claudia', 'Espinoza Ríos', 27, '923789456', 'claudia.espinoza@sport.com'),
('Ricardo', 'Salinas Guerrero', 31, '956456789', 'ricardo.salinas@coach.com');

-- SELECT * FROM Entrenador

INSERT INTO Alimentos (nombre, tipoAlimento, precio, calorias) VALUES
('Pechuga de Pollo', 'Proteína', 12.50, 165),
('Arroz Integral', 'Carbohidrato', 3.80, 123),
('Brócoli', 'Verdura', 2.50, 25),
('Aguacate', 'Grasa Saludable', 4.20, 160),
('Quinoa', 'Carbohidrato', 8.90, 120);

-- SELECT * FROM Alimentos

INSERT INTO Ejercicio (nombre, duracion, intensidad, calorias) VALUES
('Sentadillas', 30, 'Moderado', 150),
('Flexiones de Pecho', 25, 'Moderado', 120),
('Plancha Abdominal', 15, 'Alto', 80),
('Burpees', 20, 'Alto', 200),
('Caminata Rápida', 45, 'Bajo', 180);

-- SELECT * FROM Ejercicio



-- =============================================
-- INSERCIÓN DE DATOS - TABLAS DE TRANSACCIONES
-- =============================================

INSERT INTO Encuesta_Inicial (idCliente, preferencias, restriccionesAlimenticias) VALUES
(1, 'Comida casera, sabores suaves', 'Intolerancia a la lactosa'),
(2, 'Comida mediterránea, picante', 'Ninguna'),
(3, 'Comida vegetariana', 'Vegetariano estricto'),
(4, 'Comida baja en sodio', 'Hipertensión y diabetes'),
(5, 'Comida alta en proteínas', 'Alergia al maní');

-- SELECT * FROM Encuesta_Inicial

INSERT INTO Plan_Alimentacion (idCliente, tipoPlan, fechaInicio, fechaFin, caloriasDiarias) VALUES
(1, 'Pérdida de peso', '2025-01-01', '2025-03-01', 1800),
(1, 'Mantenimiento', '2025-03-02', '2025-06-01', 2000),
(2, 'Ganancia muscular', '2025-01-15', '2025-04-15', 2500),
(2, 'Definición', '2025-04-16', '2025-07-15', 2200),
(3, 'Vegetariano', '2025-02-01', '2025-05-01', 2000),
(3, 'Vegetariano plus', '2025-05-02', '2025-08-01', 2100),
(4, 'Pérdida de peso', '2025-01-10', '2025-04-10', 1600),
(4, 'Mantenimiento', '2025-04-11', '2025-07-10', 1900),
(5, 'Ganancia muscular', '2025-02-15', '2025-05-15', 2800),
(5, 'Volumen', '2025-05-16', '2025-08-15', 3000),
(1, 'Detox', '2025-06-02', '2025-06-30', 1500),
(2, 'Competencia', '2025-07-16', '2025-08-15', 2000),
(3, 'Vegano', '2025-08-02', '2025-11-01', 1950),
(4, 'Bajo sodio', '2025-07-11', '2025-10-10', 1800),
(5, 'Cutting', '2025-08-16', '2025-11-15', 2400);

-- SELECT * FROM Plan_Alimentacion

INSERT INTO Rutina (idCliente, fecha, duracion) VALUES
(1, '2025-01-05', 60),
(1, '2025-01-12', 45),
(2, '2025-01-20', 90),
(2, '2025-01-27', 75),
(3, '2025-02-05', 45),
(3, '2025-02-12', 60),
(4, '2025-01-15', 75),
(4, '2025-01-22', 60),
(5, '2025-02-20', 120),
(5, '2025-02-27', 90),
(1, '2025-01-19', 50),
(2, '2025-02-03', 85);

-- ALTER TABLE Recomendaciones
-- ALTER COLUMN tipo VARCHAR(50) NOT NULL;

INSERT INTO Recomendaciones (idCliente, tipo, contenido, fechaGeneracion) VALUES
(1, 'Hidratación', 'Aumentar consumo de agua a 2.5L diarios', '2025-01-03'),
(1, 'Ejercicio', 'Incluir más ejercicios cardiovasculares', '2025-01-10'),
(2, 'Alimentación', 'Incrementar proteínas post-entreno', '2025-01-18'),
(2, 'Ejercicio', 'Reducir tiempo de descanso entre series', '2025-01-25'),
(3, 'Alimentación', 'Complementar con vitamina B12', '2025-02-02'),
(3, 'Ejercicio', 'Añadir ejercicios de fuerza', '2025-02-09'),
(4, 'Alimentación', 'Evitar alimentos procesados', '2025-01-12'),
(4, 'Ejercicio', 'Incrementar actividad física gradualmente', '2025-01-19'),
(5, 'Alimentación', 'Consumir carbohidratos pre-entreno', '2025-02-17'),
(5, 'Ejercicio', 'Enfocar en ejercicios compuestos', '2025-02-24');

-- SELECT * FROM Recomendaciones


INSERT INTO Notificaciones (idCliente, mensaje, fechaGeneracion, tipo) VALUES
(1, 'Recordatorio: Es hora de tu comida', '2025-01-05', 'Alimentación'),
(1, 'Tu rutina de ejercicios te espera', '2025-01-05', 'Ejercicio'),
(2, 'Nuevo plan nutricional disponible', '2025-01-18', 'Alimentación'),
(2, 'Actualización de tu progreso semanal', '2025-01-25', 'Progreso'),
(3, 'Recordatorio: Tomar suplemento B12', '2025-02-02', 'Suplementos'),
(3, 'Sesión con nutricionista mañana', '2025-02-08', 'Cita'),
(4, 'Meta de pasos diaria alcanzada', '2025-01-15', 'Logro'),
(4, 'Recordatorio: Medir presión arterial', '2025-01-22', 'Salud'),
(5, 'Nueva rutina de fuerza disponible', '2025-02-20', 'Ejercicio'),
(5, 'Cita con entrenador confirmada', '2025-02-26', 'Cita'),
(1, 'Hidratación: Has tomado solo 1L hoy', '2025-01-12', 'Hidratación'),
(2, 'Peso registrado correctamente', '2025-02-01', 'Progreso'),
(3, 'Receta vegana de la semana', '2025-02-10', 'Receta'),
(4, 'Recordatorio: Ejercicio de relajación', '2025-01-28', 'Bienestar'),
(5, 'Logro desbloqueado: 30 días activo', '2025-03-01', 'Logro');

-- SELECT * FROM Notificaciones

INSERT INTO Detalle_Plan_Alimento (idPlan, idAlimento, cantidad, unidadMedida, tiempoComida) VALUES
(1, 1, 150, 'gramos', 'Almuerzo'),
(1, 2, 100, 'gramos', 'Almuerzo'),
(1, 3, 200, 'gramos', 'Cena'),
(2, 1, 200, 'gramos', 'Cena'),
(2, 4, 50, 'gramos', 'Desayuno'),
(3, 1, 250, 'gramos', 'Almuerzo'),
(3, 5, 80, 'gramos', 'Desayuno'),
(4, 2, 120, 'gramos', 'Desayuno'),
(4, 3, 150, 'gramos', 'Almuerzo'),
(5, 5, 100, 'gramos', 'Cena'),
(6, 4, 75, 'gramos', 'Merienda'),
(7, 1, 100, 'gramos', 'Cena'),
(8, 2, 80, 'gramos', 'Desayuno'),
(9, 1, 300, 'gramos', 'Almuerzo'),
(10, 5, 120, 'gramos', 'Desayuno');

-- SELECT * FROM Detalle_Plan_Alimento

INSERT INTO Detalle_Rutina_Ejercicio (idRutina, idEjercicio, repeticiones, series) VALUES
(1, 1, 15, 3),
(1, 2, 12, 3),
(2, 1, 20, 4),
(2, 3, 30, 2),
(3, 2, 15, 4),
(3, 4, 10, 3),
(4, 1, 25, 3),
(4, 5, 1, 1),
(5, 3, 45, 3),
(5, 4, 8, 4),
(6, 1, 18, 3),
(6, 2, 10, 4),
(7, 5, 1, 1),
(8, 1, 12, 2),
(9, 4, 12, 5);

INSERT INTO Asignacion_Nutricionista (idCliente, idNutricionista, fechaAsignacion) VALUES
(1, 1, '2025-01-01'),
(2, 2, '2025-01-15'),
(3, 3, '2025-02-01'),
(4, 4, '2025-01-10'),
(5, 5, '2025-02-15'),
(1, 2, '2025-03-02'),
(2, 1, '2025-04-16'),
(3, 4, '2025-05-02'),
(4, 3, '2025-04-11'),
(5, 1, '2025-05-16');

INSERT INTO Asignacion_Entrenador (idCliente, idEntrenador, fechaAsignacion) VALUES
(1, 1, '2025-01-05'),
(2, 2, '2025-01-20'),
(3, 3, '2025-02-05'),
(4, 4, '2025-01-15'),
(5, 5, '2025-02-20'),
(1, 3, '2025-03-05'),
(2, 4, '2025-04-20'),
(3, 1, '2025-05-05'),
(4, 2, '2025-04-15'),
(5, 3, '2025-05-20');