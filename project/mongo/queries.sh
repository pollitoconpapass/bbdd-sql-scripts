# 1. Obtener los nombres y correos de los clientes junto con sus nutricionistas asignados

db.asignaciones_nutricionista.aggregate([
  {
    $lookup: {
      from: "clientes",
      localField: "idCliente",
      foreignField: "_id",
      as: "cliente"
    }
  },
  { $unwind: "$cliente" },
  {
    $lookup: {
      from: "nutricionistas",
      localField: "idNutricionista",
      foreignField: "_id",
      as: "nutricionista"
    }
  },
  { $unwind: "$nutricionista" },
  {
    $project: {
      _id: 0,
      cliente: { $concat: ["$cliente.nombres", " ", "$cliente.apellidos"] },
      correo_cliente: "$cliente.correo",
      nutricionista: { $concat: ["$nutricionista.nombre", " ", "$nutricionista.apellidos"] }
    }
  }
])

# 2. Mostrar todos los entrenadores asignados a clientes con objetivo “Ganar masa muscular”

db.asignaciones_entrenador.aggregate([
  {
    $lookup: {
      from: "clientes",
      localField: "idCliente",
      foreignField: "_id",
      as: "cliente"
    }
  },
  { $unwind: "$cliente" },
  {
    $match: {
      "cliente.objetivo": "Ganar masa muscular"
    }
  },
  {
    $lookup: {
      from: "entrenadores",
      localField: "idEntrenador",
      foreignField: "_id",
      as: "entrenador"
    }
  },
  { $unwind: "$entrenador" },
  {
    $project: {
      _id: 0,
      cliente: { $concat: ["$cliente.nombres", " ", "$cliente.apellidos"] },
      entrenador: { $concat: ["$entrenador.nombre", " ", "$entrenador.apellidos"] }
    }
  }
])

# 3. Contar cuántos clientes tiene asignado cada nutricionista

db.asignaciones_nutricionista.aggregate([
  {
    $group: {
      _id: "$idNutricionista",
      totalClientes: { $sum: 1 }
    }
  },
  {
    $lookup: {
      from: "nutricionistas",
      localField: "_id",
      foreignField: "_id",
      as: "nutricionista"
    }
  },
  { $unwind: "$nutricionista" },
  {
    $project: {
      _id: 0,
      nombre_nutricionista: { $concat: ["$nutricionista.nombre", " ", "$nutricionista.apellidos"] },
      totalClientes: 1
    }
  },
  { $sort: { totalClientes: -1 } }
])

# 4. Visualizar el historial de asignaciones (fechas) de un cliente específico

db.asignaciones_entrenador.aggregate([
  { $match: { idCliente: ObjectId("686adb4f14114c37bfbb55c6") } },
  {
    $lookup: {
      from: "entrenadores",
      localField: "idEntrenador", 
      foreignField: "_id",
      as: "entrenador"
    }
  },
  { $unwind: "$entrenador" },
  {
    $project: {
      fechaAsignacion: 1,
      entrenador: { $concat: ["$entrenador.nombre", " ", "$entrenador.apellidos"] }
    }
  },
  { $sort: { fechaAsignacion: -1 } }
])

# 5. Obtener los clientes que han sido asignados más de una vez al mismo entrenador

db.asignaciones_entrenador.aggregate([
  {
    $group: {
      _id: { idCliente: "$idCliente", idEntrenador: "$idEntrenador" },
      asignaciones: { $sum: 1 }
    }
  },
  { $match: { asignaciones: { $gt: 1 } } }
])

# 6. Visualizar los nombres de clientes junto a su nutricionista y entrenador asignado más recientemente

db.clientes.aggregate([
  { $match: { _id: ObjectId("686adb4f14114c37bfbb55c6") } },
  {
    $lookup: {
      from: "asignaciones_nutricionista",
      localField: "_id",
      foreignField: "idCliente",
      as: "asignaciones_nutri"
    }
  },
  {
    $lookup: {
      from: "asignaciones_entrenador", 
      localField: "_id",
      foreignField: "idCliente",
      as: "asignaciones_entren"
    }
  },
  {
    $addFields: {
      ultimaNutri: { $arrayElemAt: [{ $sortArray: { input: "$asignaciones_nutri", sortBy: { fechaAsignacion: -1 } } }, 0] },
      ultimoEntren: { $arrayElemAt: [{ $sortArray: { input: "$asignaciones_entren", sortBy: { fechaAsignacion: -1 } } }, 0] }
    }
  },
  // Continuar con lookups para obtener nombres...
])

# 7. Contar cuántos clientes hay por objetivo (agregación estilo informe)

db.clientes.aggregate([
  { $group: { _id: "$objetivo", total: { $sum: 1 } } },
  { $sort: { total: -1 } }
])

# 8. Obtener los clientes con nivel de actividad 'Bajo' y menos de 60 minutos disponibles

db.clientes.find({
  nivelActividad: "Bajo",
  tiempoDisponible: { $lt: 60 }
})

# 9. Lista de clientes con su altura y peso ordenado por IMC (índice de masa corporal)

db.clientes.aggregate([
  {
    $addFields: {
      imc: { $divide: ["$peso", { $multiply: ["$altura", "$altura"] }] }
    }
  },
  {
    $project: {
      nombres: 1,
      apellidos: 1,
      imc: { $round: ["$imc", 2] }
    }
  },
  { $sort: { imc: -1 } }
])

# 10. Nutricionistas que han sido asignados a más de 2 clientes distintos

db.asignaciones_nutricionista.aggregate([
  {
    $group: {
      _id: "$idNutricionista",
      clientesUnicos: { $addToSet: "$idCliente" }
    }
  },
  {
    $project: {
      cantidad: { $size: "$clientesUnicos" }
    }
  },
  {
    $match: {
      cantidad: { $gt: 2 }
    }
  }
])

# 11. Clientes con múltiples asignaciones a distintos entrenadores

db.asignaciones_entrenador.aggregate([
  {
    $group: {
      _id: "$idCliente",
      entrenadores: { $addToSet: "$idEntrenador" }
    }
  },
  {
    $project: {
      cantidadEntrenadores: { $size: "$entrenadores" }
    }
  },
  {
    $match: {
      cantidadEntrenadores: { $gt: 1 }
    }
  }
])

# 12. Obtener todos los entrenadores que han trabajado con clientes cuyo objetivo es "Mantener peso"

db.asignaciones_entrenador.aggregate([
  {
    $lookup: {
      from: "clientes",
      localField: "idCliente",
      foreignField: "_id",
      as: "cliente"
    }
  },
  { $unwind: "$cliente" },
  {
    $match: {
      "cliente.objetivo": "Mantener peso"
    }
  },
  {
    $lookup: {
      from: "entrenadores",
      localField: "idEntrenador",
      foreignField: "_id",
      as: "entrenador"
    }
  },
  { $unwind: "$entrenador" },
  {
    $project: {
      _id: 0,
      entrenador: { $concat: ["$entrenador.nombre", " ", "$entrenador.apellidos"] },
      cliente: { $concat: ["$cliente.nombres", " ", "$cliente.apellidos"] }
    }
  }
])

# 13. Cantidad total de asignaciones por mes para entrenadores

db.asignaciones_entrenador.aggregate([
  {
    $group: {
      _id: { mes: { $month: "$fechaAsignacion" }, año: { $year: "$fechaAsignacion" } },
      total: { $sum: 1 }
    }
  },
  { $sort: { "_id.año": 1, "_id.mes": 1 } }
])

# 14. Promedio de tiempo disponible por objetivo de cliente

db.clientes.aggregate([
  {
    $group: {
      _id: "$objetivo",
      promedioTiempo: { $avg: "$tiempoDisponible" }
    }
  }
])

# 15. Lista de clientes sin asignación a entrenadores (LEFT JOIN simulado)

db.clientes.aggregate([
  {
    $lookup: {
      from: "asignaciones_entrenador",
      localField: "_id",
      foreignField: "idCliente",
      as: "asignaciones"
    }
  },
  {
    $match: { "asignaciones": { $eq: [] } }
  },
  {
    $project: {
      nombres: 1,
      apellidos: 1
    }
  }
])