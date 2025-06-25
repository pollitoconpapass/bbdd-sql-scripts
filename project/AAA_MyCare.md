# My Care 🩺❤️‍🩹

## Instrucciones SQL
- Generar carga de datos (incluir los comandos de inserción de datos)
- Insertar 5 registros por Tabla Maestra (los registros no suelen ser cambiados constantemente) Ejemplos: paciente, cliente, estudiante, producto, servicio.
- Insertar 10 a 15 registros por Tabla de Transacciones (son tablas que tienen mayor movimiento a nivel transacción). Ejemplos: orden de compra, pedidos, facturas, boletas. cotizaciones.
- Cada integrante de grupo (5 integrantes) debe presentar 3 consultas que involucran cálculos, JOINS, funciones o procedimientos almacenados.

## Documentacion del Proyecto 
### Tablas Maestras
- `Usuario`: Información básica de los usuarios del sistema
- `Nutricionista`: Profesionales en nutrición
- `Entrenador`: Profesionales en fitness
- `Alimentos`: Catálogo de alimentos con información nutricional
- `Ejercicio`: Catálogo de ejercicios con información de calorías

### Tablas de Transacciones
- `Plan_Alimentacion`: Planes nutricionales asignados a usuarios
- `Rutina`: Sesiones de ejercicio realizadas por usuarios
- `Recomendaciones`: Sugerencias personalizadas del sistema
- `Notificaciones`: Mensajes y alertas del sistema
- `Detalle_Plan_Alimento`: Detalles de alimentos en cada plan
- `Detalle_Rutina_Ejercicio`: Detalles de ejercicios en cada rutina
- `Asignacion_Nutricionista`: Relación usuario-nutricionista
- `Asignacion_Entrenador`: Relación usuario-entrenador

### Funciones Creadas
- `fn_CaloriasTotalesPlan`: Calcula calorías reales de un plan
- `fn_NutricionistaActual`: Obtiene el nutricionista actual de un usuario
- `fn_CalcularEdadExacta`: Calcula edad exacta desde fecha de nacimiento

### Procedimientos Almacenados
- `sp_ReporteActividadUsuario`: Genera reporte de actividad de un usuario
- `sp_ReporteMensual`: Genera métricas mensuales del sistema

### Vistas
- `vw_ResumenUsuarios`: Vista consolidada con información principal de usuarios

### Triggers
- `tr_AuditoriaPlan`: Auditoría de cambios en planes