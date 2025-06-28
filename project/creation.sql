-- CREATE DATABASE DB_MyCare;
-- GO

-- USE DB_MyCare;
-- GO

-- === TABLAS MAESTRAS ===
CREATE TABLE Cliente (
    idCliente INT IDENTITY(1,1) PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    sexo VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    peso FLOAT NOT NULL,
    altura FLOAT NOT NULL,
    telefono INT NOT NULL,
    correo VARCHAR(50) NOT NULL UNIQUE,
    objetivo VARCHAR(50) NOT NULL,
    nivelActividad VARCHAR(50) NOT NULL,
    tiempoDisponible INT NOT NULL
);
GO

CREATE TABLE Nutricionista (
    idNutricionista INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    telefono INT NOT NULL,
    correo VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Entrenador (
    idEntrenador INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    correo VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Alimentos (
    idAlimento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipoAlimento VARCHAR(50) NOT NULL,
    precio FLOAT NOT NULL,
    calorias INT NOT NULL
);
GO

CREATE TABLE Ejercicio (
    idEjercicio INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    duracion INT NOT NULL,
    intensidad VARCHAR(50) NOT NULL,
    calorias INT NOT NULL
);
GO

-- === TABLAS TRANSACCIONES ===
CREATE TABLE Encuesta_Inicial (
    idCliente INT PRIMARY KEY,
    preferencias VARCHAR(50) NOT NULL,
    restriccionesAlimenticias VARCHAR(50) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);
GO

CREATE TABLE Plan_Alimentacion (
    idPlan INT IDENTITY(1,1) PRIMARY KEY,
    idCliente INT NOT NULL,
    tipoPlan VARCHAR(50) NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    caloriasDiarias INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);
GO

CREATE TABLE Rutina (
    idRutina INT IDENTITY(1,1) PRIMARY KEY,
    idCliente INT NOT NULL,
    fecha DATE NOT NULL,
    duracion INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);
GO

CREATE TABLE Recomendaciones (
    idRecomendacion INT IDENTITY(1,1) PRIMARY KEY,
    idCliente INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    contenido VARCHAR(50) NOT NULL,
    fechaGeneracion DATE NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);
GO

CREATE TABLE Notificaciones (
    idNotificacion INT IDENTITY(1,1) PRIMARY KEY,
    idCliente INT NOT NULL,
    mensaje VARCHAR(100) NOT NULL,
    fechaGeneracion DATE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);
GO

CREATE TABLE Detalle_Plan_Alimento (
    idDetallePlan INT IDENTITY(1,1) PRIMARY KEY,
    idPlan INT NOT NULL,
    idAlimento INT NOT NULL,
    cantidad INT NOT NULL,
    unidadMedida VARCHAR(20) NOT NULL,
    tiempoComida VARCHAR(20) NOT NULL,
    FOREIGN KEY (idPlan) REFERENCES Plan_Alimentacion(idPlan) ON DELETE CASCADE,
    FOREIGN KEY (idAlimento) REFERENCES Alimentos(idAlimento) ON DELETE CASCADE
);
GO

CREATE TABLE Detalle_Rutina_Ejercicio (
    idDetalleRutina INT IDENTITY(1,1) PRIMARY KEY,
    idRutina INT NOT NULL,
    idEjercicio INT NOT NULL,
    repeticiones INT NOT NULL,
    series INT NOT NULL,
    FOREIGN KEY (idRutina) REFERENCES Rutina(idRutina) ON DELETE CASCADE,
    FOREIGN KEY (idEjercicio) REFERENCES Ejercicio(idEjercicio) ON DELETE CASCADE
);
GO

CREATE TABLE Asignacion_Nutricionista (
    idAsignacion INT IDENTITY(1,1) PRIMARY KEY,
    idCliente INT NOT NULL,
    idNutricionista INT NOT NULL,
    fechaAsignacion DATE NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE,
    FOREIGN KEY (idNutricionista) REFERENCES Nutricionista(idNutricionista) ON DELETE CASCADE
);
GO

CREATE TABLE Asignacion_Entrenador (
    idAsignacion INT IDENTITY(1,1) PRIMARY KEY,
    idCliente INT NOT NULL,
    idEntrenador INT NOT NULL,
    fechaAsignacion DATE NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE,
    FOREIGN KEY (idEntrenador) REFERENCES Entrenador(idEntrenador) ON DELETE CASCADE
);
GO
