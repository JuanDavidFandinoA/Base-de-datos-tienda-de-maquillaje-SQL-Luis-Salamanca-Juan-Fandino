
CREATE DATABASE Tienda_Maquillaje;
USE Tienda_Maquillaje;

CREATE TABLE Puestos (
    ID_puesto INTEGER PRIMARY KEY,
    Puesto VARCHAR(100) NOT NULL
);

CREATE TABLE Areas (
    ID_area INTEGER PRIMARY KEY,
    Area VARCHAR(100) NOT NULL
);

CREATE TABLE Empleados (
    ID_empleado INTEGER PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    ID_puesto INTEGER,
    ID_area INTEGER,
    Fecha_contratación DATE,
    FOREIGN KEY (ID_puesto) REFERENCES Puestos(ID_puesto),
    FOREIGN KEY (ID_area) REFERENCES Areas(ID_area)
);

CREATE TABLE Clientes (
    ID_cliente INTEGER PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Correo VARCHAR(100),
    Dirección VARCHAR(100),
    Telefono VARCHAR(20)  -- Cambiado a VARCHAR
);

CREATE TABLE Proveedores (
    ID_proveedor INTEGER PRIMARY KEY,
    Empresa VARCHAR(100) NOT NULL,
    Contacto VARCHAR(100),
    Dirección VARCHAR(100),
    Telefono VARCHAR(20)  -- Cambiado a VARCHAR
);

CREATE TABLE Categorias (
    ID_categoria INTEGER PRIMARY KEY,
    categoria VARCHAR(100) NOT NULL
);

CREATE TABLE Productos (
    ID_producto INTEGER PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripción TEXT,
    ID_categoria INTEGER,  -- Cambiado para ser clave foránea
    Precio DECIMAL(10, 2),
    Stock INTEGER,
    FOREIGN KEY (ID_categoria) REFERENCES Categorias(ID_categoria)
);

CREATE TABLE Perfumes (
    ID_perfumes INTEGER PRIMARY KEY,
    ID_producto INTEGER,
    Tipo_aroma VARCHAR(100),
    Tamaño DECIMAL(10, 2),
    Material VARCHAR(100),
    FOREIGN KEY (ID_producto) REFERENCES Productos(ID_producto)
);

CREATE TABLE Cosmeticos (
    ID_cosmeticos INTEGER PRIMARY KEY,
    ID_producto INTEGER,  -- Cambiado a ID_producto
    Tipo VARCHAR(100),
    Tono VARCHAR(100),
    Caducidad DATE,
    FOREIGN KEY (ID_producto) REFERENCES Productos(ID_producto)
);

CREATE TABLE Cuidado_de_piel (
    ID_cuidado_piel INTEGER PRIMARY KEY,
    ID_producto INTEGER,  -- Cambiado a ID_producto
    Tipo_piel VARCHAR(100),
    Componentes VARCHAR(100),
    Caducidad DATE,
    FOREIGN KEY (ID_producto) REFERENCES Productos(ID_producto)
);

CREATE TABLE Ventas (
    ID_venta INTEGER PRIMARY KEY,
    Fecha DATE,
    ID_cliente INTEGER,
    ID_empleado INTEGER,
    Monto DECIMAL(10, 2),  -- Total de la venta (opcional)
    FOREIGN KEY (ID_cliente) REFERENCES Clientes(ID_cliente),
    FOREIGN KEY (ID_empleado) REFERENCES Empleados(ID_empleado)
);

CREATE TABLE Detalle_Venta (
    ID_venta INTEGER,
    ID_producto INTEGER,
    Cantidad INTEGER,
    PRIMARY KEY (ID_venta, ID_producto),
    FOREIGN KEY (ID_venta) REFERENCES Ventas(ID_venta),
    FOREIGN KEY (ID_producto) REFERENCES Productos(ID_producto)
);

CREATE TABLE Orden_de_compra (
    ID_orden INTEGER PRIMARY KEY,
    Productos_solicitados INTEGER,
    Fecha_orden DATE,
    ID_proveedor INTEGER,
    FOREIGN KEY (ID_proveedor) REFERENCES Proveedores(ID_proveedor)
);

CREATE TABLE Detalle_Orden_Compra (
    ID_orden INTEGER,
    ID_producto INTEGER,
    Productos_recibidos INTEGER,
    PRIMARY KEY (ID_orden, ID_producto),
    FOREIGN KEY (ID_orden) REFERENCES Orden_de_compra(ID_orden),
    FOREIGN KEY (ID_producto) REFERENCES Productos(ID_producto)
);