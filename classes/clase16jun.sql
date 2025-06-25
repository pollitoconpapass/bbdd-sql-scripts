CREATE DATABASE Farmacia
go

USE Farmacia
go

CREATE TABLE Producto(
    idProducto int identity(1,1) primary key,
    descripcion varchar(30) unique not null,
    precioUnitario money not null,
    laboratorio varchar(30) not null,
    unidadMedida char(3) not null
)
go

CREATE TABLE Saldos(
    idProducto int primary key,
    saldoDisponible money not null
)
go

CREATE TABLE Historial(
    idHistorial int identity(1,1) primary key,
    idProducto int not null,
    precioHistorico money not null,
    fechaRegistro datetime
)
go

/* --------------------------------------------------------------- */ 

CREATE OR ALTER TRIGGER txActualizarProducto ON Producto
FOR INSERT, UPDATE, DELETE
AS 
    PRINT 'Registro actualizado en la tabla de Productos'

INSERT INTO Producto( descripcion, precioUnitario, unidadMedida, laboratorio)
VALUES ('Paracetamol', 0.20, 'UND', 'MEDFARMA')


CREATE OR ALTER TRIGGER txActualizarProducto ON Producto
FOR INSERT
AS 
    INSERT INTO Historial (idProducto, precioHistorico, fechaRegistro)
    SELECT idProducto, precioUnitario, GETDATE() FROM inserted 


INSERT INTO Producto( descripcion, precioUnitario, unidadMedida, laboratorio)
VALUES ('Ibuprofeno', 0.50, 'UND', 'MEDIKALABS')


-- VERSION 3
CREATE OR ALTER TRIGGER txInsertarProducto ON Producto
FOR INSERT
AS 
BEGIN
    INSERT INTO Saldos (idProducto, saldoDisponible) -- Inserta un saldo disponible de 0 para cada producto insertado
    SELECT idProducto, 0.00 FROM inserted
    
    INSERT INTO Historial (idProducto, precioHistorico, fechaRegistro) -- Inserta un precio historico para cada producto insertado
    SELECT idProducto, precioUnitario, GETDATE() FROM inserted
END


-- TRIGGER PARA UPDATE
CREATE OR ALTER TRIGGER txActualizarProducto ON Producto
FOR UPDATE
AS 
    IF UPDATED(precioUnitario) -- Si el precio unitario se actualiza, si es de otro atributo no hace nada
    BEGIN
        INSERT INTO Historial (idProducto, precioHistorico, fechaRegistro)  
        SELECT idProducto, precioUnitario, GETDATE() FROM inserted
    END
    
INSERT INTO Producto( descripcion, precioUnitario, unidadMedida, laboratorio)
VALUES ('Ketorolaco', 5.00, 'UND', 'INKAMEDIC')



-- COMO SABER LOS VALORES? 
-- Hacer SELECTs


UPDATE Producto SET descripcion 'Ketorolaco 300mg' WHERE idProducto = 4 -- NO llamaria al trigger