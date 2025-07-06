# Preliminar: Crear la base de datos, y confirmar que se ha creado
use mycare
db

#  ============ CLIENTES ============
db.clientes.insertMany([
    {
        nombres: "Alan Gabriel",
        apellidos: "García Pérez",
        sexo: "Masculino",
        edad: 48,
        peso: 75.5,
        altura: 1.75,
        telefono: 987654321,
        correo: "alangarcia@peru.pe",
        objetivo: "Perder peso",
        nivelActividad: "Moderado",
        tiempoDisponible: 70
    },
    {
        nombres: "Maria Elena",
        apellidos: "González López",
        sexo: "Femenino",
        edad: 32,
        peso: 68.2,
        altura: 1.62,
        telefono: 912345678,
        correo: "maria.gonzalez@email.com",
        objetivo: "Ganar masa muscular",
        nivelActividad: "Alto",
        tiempoDisponible: 90
    },
    {
        nombres: "Carlos Alberto",
        apellidos: "Rodríguez Silva",
        sexo: "Masculino",
        edad: 25,
        peso: 82.0,
        altura: 1.80,
        telefono: 945678123,
        correo: "carlos.rodriguez@email.com",
        objetivo: "Mantener peso",
        nivelActividad: "Bajo",
        tiempoDisponible: 45
    },
    {
        nombres: "Ana Sofía",
        apellidos: "Martínez Torres",
        sexo: "Femenino",
        edad: 29,
        peso: 55.8,
        altura: 1.58,
        telefono: 923456789,
        correo: "ana.martinez@email.com",
        objetivo: "Perder peso",
        nivelActividad: "Moderado",
        tiempoDisponible: 75
    },
    {
        nombres: "Luis Fernando",
        apellidos: "Herrera Díaz",
        sexo: "Masculino",
        edad: 35,
        peso: 90.3,
        altura: 1.85,
        telefono: 956789012,
        correo: "luis.herrera@email.com",
        objetivo: "Ganar masa muscular",
        nivelActividad: "Alto",
        tiempoDisponible: 120
    }
])

# ============ NUTRICIONISTAS ============
db.nutricionistas.insertMany([
    {
        nombre: "Patricia",
        apellidos: "Vásquez Morales",
        edad: 38,
        telefono: 987123456,
        correo: "patricia.vasquez@saludcenter.com"
    },
    {
        nombre: "Carmen",
        apellidos: "Jimenez Ruiz",
        edad: 42,
        telefono: 912345678,
        correo: "carmen.jimenez@nutrix.com"
    },
    {
        nombre: "Roberto",
        apellidos: "Castillo Mendoza",
        edad: 45,
        telefono: 945678123,
        correo: "roberto.castillo@salud.com"
    },
    {
        nombre: "Lucía",
        apellidos: "Fernández Castro",
        edad: 36,
        telefono: 923654781,
        correo: "lucia.fernandez@wellness.com"
    },
    {
        nombre: "Miguel",
        apellidos: "Vargas Paredes",
        edad: 40,
        telefono: 956147382,
        correo: "miguel.vargas@nutricenter.com"
    }
])

# ============ ENTRENADORES ============
db.entrenadores.insertMany([
    {
        nombre: "José Antonio",
        apellidos: "Ramírez López",
        edad: 30,
        telefono: 987456123,
        correo: "joseantonio.ramirez@gym.com"
    },
    {
        nombre: "Sandra Milena",
        apellidos: "Cruz Delgado",
        edad: 28,
        telefono: 912789456,
        correo: "sandramilena.cruz@fitness.com"
    },
    {
        nombre: "Fernando",
        apellidos: "Morales Vega",
        edad: 33,
        telefono: 945123789,
        correo: "fernando.morales@training.com"
    },
    {
        nombre: "Claudia",
        apellidos: "Espinoza Ríos",
        edad: 27,
        telefono: 923789456,
        correo: "claudia.espinoza@sport.com"
    },
    {
        nombre: "Ricardo",
        apellidos: "Salinas Guerrero",
        edad: 31,
        telefono: 956456789,
        correo: "ricardo.salinas@coach.com"
    }
])


# Tablas de asignaciones 
# ======= ASIGNACIONES NUTRICIONISTAS =======
db.asignaciones_nutricionista.insertMany([
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c6'),
        idNutricionista: ObjectId('686adbe914114c37bfbb55cb'),
        fechaAsignacion: ISODate("2025-01-01")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c7'),
        idNutricionista: ObjectId('686adbe914114c37bfbb55cc'),
        fechaAsignacion: ISODate("2025-01-15")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c8'),
        idNutricionista: ObjectId('686adbe914114c37bfbb55cd'),
        fechaAsignacion: ISODate("2025-02-01")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c9'),
        idNutricionista: ObjectId('686adbe914114c37bfbb55ce'),
        fechaAsignacion: ISODate("2025-01-10")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55ca'),
        idNutricionista: ObjectId('686adbe914114c37bfbb55cf'),
        fechaAsignacion: ISODate("2025-02-15")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c6'),
        idNutricionista: ObjectId('686adbe914114c37bfbb55cc'),
        fechaAsignacion: ISODate("2025-03-02")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c7'),
        idNutricionista: ObjectId('686adbe914114c37bfbb55cb'),
        fechaAsignacion: ISODate("2025-04-16")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c8'),
        idNutricionista: ObjectId('686adbe914114c37bfbb55ce'),
        fechaAsignacion: ISODate("2025-05-02")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c9'),
        idNutricionista: ObjectId('686adbe914114c37bfbb55cd'),
        fechaAsignacion: ISODate("2025-04-11")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55ca'),
        idNutricionista: ObjectId('686adbe914114c37bfbb55cb'),
        fechaAsignacion: ISODate("2025-05-16")
    }
])


db.asignaciones_entrenador.insertMany([
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c6'),
        idEntrenador: ObjectId('686adbf314114c37bfbb55d0'),
        fechaAsignacion: ISODate("2025-01-05")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c7'),
        idEntrenador: ObjectId('686adbf314114c37bfbb55d1'),
        fechaAsignacion: ISODate("2025-01-20")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c8'),
        idEntrenador: ObjectId('686adbf314114c37bfbb55d2'),
        fechaAsignacion: ISODate("2025-02-05")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c9'),
        idEntrenador: ObjectId('686adbf314114c37bfbb55d3'),
        fechaAsignacion: ISODate("2025-01-15")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55ca'),
        idEntrenador: ObjectId('686adbf314114c37bfbb55d4'),
        fechaAsignacion: ISODate("2025-02-20")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c6'),
        idEntrenador: ObjectId('686adbf314114c37bfbb55d2'),
        fechaAsignacion: ISODate("2025-03-05")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c7'),
        idEntrenador: ObjectId('686adbf314114c37bfbb55d3'),
        fechaAsignacion: ISODate("2025-04-20")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c8'),
        idEntrenador: ObjectId('686adbf314114c37bfbb55d0'),
        fechaAsignacion: ISODate("2025-05-05")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55c9'),
        idEntrenador: ObjectId('686adbf314114c37bfbb55d1'),
        fechaAsignacion: ISODate("2025-04-15")
    },
    {
        idCliente: ObjectId('686adb4f14114c37bfbb55ca'),
        idEntrenador: ObjectId('686adbf314114c37bfbb55d2'),
        fechaAsignacion: ISODate("2025-05-20")
    }
])
