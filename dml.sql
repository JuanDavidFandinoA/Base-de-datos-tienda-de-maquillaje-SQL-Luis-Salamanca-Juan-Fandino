USE tienda_maquillaje;
INSERT INTO Puestos (ID_puesto, Puesto) VALUES
(1, 'Gerente'),
(2, 'Vendedor'),
(3, 'Cajero'),
(4, 'Almacén');

INSERT INTO Areas (ID_area, Area) VALUES
(1, 'Ventas'),
(2, 'Logística'),
(3, 'Atención al Cliente'),
(4, 'Finanzas');

INSERT INTO Empleados (ID_empleado, Nombre, Apellido, ID_puesto, ID_area, Fecha_contratación) VALUES
(1, 'Juan', 'Pérez', 1, 1, '2021-01-15'),
(2, 'María', 'Gómez', 2, 1, '2022-05-10'),
(3, 'Carlos', 'López', 3, 3, '2023-03-20'),
(4, 'Lucía', 'Martínez', 4, 2, '2020-07-25');

INSERT INTO Clientes (ID_cliente, Nombres, Apellidos, Correo, Dirección, Telefono) VALUES
(1, 'Ana', 'Ramírez', 'ana.ramirez@email.com', 'Calle Falsa 123', '555-1234'),
(2, 'Luis', 'Torres', 'luis.torres@email.com', 'Avenida Siempre Viva 742', '555-5678'),
(3, 'Sofía', 'Hernández', 'sofia.hernandez@email.com', 'Calle de la Rosa 456', '555-4321');

INSERT INTO Proveedores (ID_proveedor, Empresa, Contacto, Dirección, Telefono) VALUES
(1, 'Cosmeticos S.A.', 'Laura Mejía', 'Av. Belleza 101', '555-8765'),
(2, 'Perfumerías Elite', 'Manuel Domínguez', 'Calle Aromas 55', '555-9876'),
(3, 'Productos Naturales', 'Clara Jiménez', 'Camino Verde 300', '555-6789');

INSERT INTO Categorias (ID_categoria, categoria) VALUES
(1, 'Cosméticos'),
(2, 'Cuidado de la piel'),
(3, 'Perfumes');

INSERT INTO Productos (ID_producto, Nombre, Descripción, ID_categoria, Precio, Stock) VALUES
(1, 'Labial Rojo', 'Labial de larga duración', 1, 10.50, 150),
(2, 'Crema Hidratante', 'Crema para piel seca', 2, 25.75, 50),
(3, 'Perfume Floral', 'Perfume con aroma floral', 3, 50.00, 100);

INSERT INTO Perfumes (ID_perfumes, ID_producto, Tipo_aroma, Tamaño, Material) VALUES
(1, 3, 'Floral', 50.0, 'Vidrio');

INSERT INTO Cosmeticos (ID_cosmeticos, ID_producto, Tipo, Tono, Caducidad) VALUES
(1, 1, 'Labial', 'Rojo', '2025-06-30');

INSERT INTO Cuidado_de_piel (ID_cuidado_piel, ID_producto, Tipo_piel, Componentes, Caducidad) VALUES
(1, 2, 'Piel Seca', 'Aloe Vera, Vitamina E', '2024-12-31');

INSERT INTO Ventas (ID_venta, Fecha, ID_cliente, ID_empleado, Monto) VALUES
(1, '2024-08-01', 1, 2, 35.50),
(2, '2024-08-15', 2, 1, 50.00),
(3, '2024-09-10', 3, 2, 10.50);

INSERT INTO Detalle_Venta (ID_venta, ID_producto, Cantidad) VALUES
(1, 1, 2),
(2, 3, 1),
(3, 1, 1);

INSERT INTO Orden_de_compra (ID_orden, Productos_solicitados, Fecha_orden, ID_proveedor) VALUES
(1, 100, '2024-07-01', 1),
(2, 50, '2024-07-20', 2);

INSERT INTO Detalle_Orden_Compra (ID_orden, ID_producto, Productos_recibidos) VALUES
(1, 1, 100),
(2, 3, 50);