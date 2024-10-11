USE tienda_maquillaje;

DELIMITER //

CREATE PROCEDURE ListarProductosCosmeticosPorTipo (IN tipo_especifico VARCHAR(100))
BEGIN
    SELECT 
        p.ID_producto,
        p.Nombre,
        p.Descripción,
        p.Precio,
        p.Stock,
        c.Tipo AS Tipo_Cosmetico,
        c.Tono
    FROM 
        Productos p
    INNER JOIN 
        Cosmeticos c ON p.ID_producto = c.ID_producto
    WHERE 
        c.Tipo = tipo_especifico;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ObtenerProductosPorCategoria (IN categoria_especifica VARCHAR(100))
BEGIN
    SELECT 
        p.ID_producto,
        p.Nombre,
        p.Descripción,
        p.Precio,
        p.Stock,
        cat.categoria AS Categoria
    FROM 
        Productos p
    INNER JOIN 
        Categorias cat ON p.ID_categoria = cat.ID_categoria
    WHERE 
        cat.categoria = categoria_especifica;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE MostrarVentasPorCliente (
    IN id_cliente INTEGER,
    IN fecha_inicio DATE,
    IN fecha_fin DATE
)
BEGIN
    SELECT 
        v.ID_venta,
        v.Fecha,
        v.Monto,
        c.Nombres,
        c.Apellidos
    FROM 
        Ventas v
    INNER JOIN 
        Clientes c ON v.ID_cliente = c.ID_cliente
    WHERE 
        v.ID_cliente = id_cliente
        AND v.Fecha BETWEEN fecha_inicio AND fecha_fin
    ORDER BY 
        v.Fecha;  -- Ordenar por fecha, opcional
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE CalcularTotalVentasPorEmpleado (
    IN id_empleado INTEGER,
    IN mes INTEGER,
    IN anio INTEGER
)
BEGIN
    SELECT 
        SUM(v.Monto) AS Total_Ventas
    FROM 
        Ventas v
    WHERE 
        v.ID_empleado = id_empleado
        AND MONTH(v.Fecha) = mes
        AND YEAR(v.Fecha) = anio;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ListarProductosMasVendidos (
    IN fecha_inicio DATE,
    IN fecha_fin DATE
)
BEGIN
    SELECT 
        p.ID_producto,
        p.Nombre,
        SUM(dv.Cantidad) AS Total_Vendido
    FROM 
        Detalle_Venta dv
    INNER JOIN 
        Ventas v ON dv.ID_venta = v.ID_venta
    INNER JOIN 
        Productos p ON dv.ID_producto = p.ID_producto
    WHERE 
        v.Fecha BETWEEN fecha_inicio AND fecha_fin
    GROUP BY 
        p.ID_producto, p.Nombre
    ORDER BY 
        Total_Vendido DESC;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE MostrarVentasPorClienteYFecha (
    IN cliente_id INTEGER,
    IN fecha_inicio DATE,
    IN fecha_fin DATE
)
BEGIN
    SELECT 
        v.ID_venta,
        v.Fecha,
        v.Monto,
        c.Nombres,
        c.Apellidos
    FROM 
        Ventas v
    INNER JOIN 
        Clientes c ON v.ID_cliente = c.ID_cliente
    WHERE 
        v.ID_cliente = cliente_id 
        AND v.Fecha BETWEEN fecha_inicio AND fecha_fin;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE MostrarOrdenesCompraPorProveedor (
    IN proveedor_id INTEGER
)
BEGIN
    SELECT 
        o.ID_orden,
        o.Productos_solicitados,
        o.Fecha_orden,
        p.Empresa AS Proveedor
    FROM 
        Orden_de_compra o
    INNER JOIN 
        Proveedores p ON o.ID_proveedor = p.ID_proveedor
    WHERE 
        o.ID_proveedor = proveedor_id 
        AND o.Fecha_orden >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ListarEmpleadosConMasDeUnAnio ()
BEGIN
    SELECT 
        e.ID_empleado,
        e.Nombre,
        e.Apellido,
        e.Fecha_contratación,
        DATEDIFF(CURDATE(), e.Fecha_contratación) AS Dias_Trabajados
    FROM 
        Empleados e
    WHERE 
        DATEDIFF(CURDATE(), e.Fecha_contratación) > 365;  -- Más de un año
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ObtenerCantidadTotalVendidosPorDia (
    IN fecha_especifica DATE
)
BEGIN
    SELECT 
        SUM(dv.Cantidad) AS Total_Vendidos
    FROM 
        Detalle_Venta dv
    INNER JOIN 
        Ventas v ON dv.ID_venta = v.ID_venta
    WHERE 
        v.Fecha = fecha_especifica;
END //

DELIMITER ;

DELIMITER //

-- Eliminar el procedimiento si ya existe
DROP PROCEDURE IF EXISTS ConsultarVentasPorProducto;

-- Crear el nuevo procedimiento
CREATE PROCEDURE ConsultarVentasPorProducto (
    IN producto_id INTEGER,  -- Parámetro para buscar por ID
    IN producto_nombre VARCHAR(100)  -- Parámetro para buscar por nombre
)
BEGIN
    SELECT 
        p.ID_producto,
        p.Nombre,
        SUM(dv.Cantidad) AS Unidades_Vendidas
    FROM 
        Productos p
    INNER JOIN 
        Detalle_Venta dv ON p.ID_producto = dv.ID_producto
    INNER JOIN 
        Ventas v ON dv.ID_venta = v.ID_venta
    WHERE 
        (p.ID_producto = producto_id OR p.Nombre = producto_nombre)
    GROUP BY 
        p.ID_producto;
END //

DELIMITER ;


-- Ejemplos de llamadas a procedimientos

-- 1. Listar productos cosméticos de tipo "labial"
CALL ListarProductosCosmeticosPorTipo('Labial');

-- 2. Obtener productos en la categoría "cosméticos"
CALL ObtenerProductosPorCategoria('Cosméticos');

-- 3. Mostrar ventas por cliente con ID 1 en el rango de fechas especificado
CALL MostrarVentasPorCliente(1, '2024-01-01', '2024-01-31');

-- 4. Calcular total de ventas por empleado con ID 2 en enero de 2024
CALL CalcularTotalVentasPorEmpleado(2, 1, 2024);

-- 5. Listar productos más vendidos entre dos fechas
CALL ListarProductosMasVendidos('2024-01-01', '2024-01-31');

-- 6. Mostrar ventas de un cliente específico en un rango de fechas
CALL MostrarVentasPorClienteYFecha(1, '2024-01-01', '2024-01-31');

-- 7. Mostrar órdenes de compra realizadas a un proveedor con ID 1 en el último año
CALL MostrarOrdenesCompraPorProveedor(1);

-- 8. Listar empleados que han trabajado más de un año
CALL ListarEmpleadosConMasDeUnAnio();

-- 9. Obtener la cantidad total de productos vendidos en una fecha específica
CALL ObtenerCantidadTotalVendidosPorDia('2024-10-10');

-- 10. Consultar ventas de un producto específico por ID o nombre
CALL ConsultarVentasPorProducto(1, 'Labial');
