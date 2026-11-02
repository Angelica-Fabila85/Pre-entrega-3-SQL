--SQL
-- =====================================
-- 1. DROP TABLES
-- =====================================

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-- SQL

USE TechStore;

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200)
);
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE NOT NULL
);
CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    activo BIT DEFAULT 1,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    fecha DATE,
    cantidad INT,
    total DECIMAL(10,2),
    canal VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
INSERT INTO categorias
(id_categoria, nombre_categoria, descripcion)
VALUES
(1, 'Computadoras', 'Equipos informaticos'),
(2, 'Celulares', 'Telefonos moviles'),
(3, 'Accesorios', 'Accesorios tecnologicos');

INSERT INTO clientes
(id_cliente, nombre, email, ciudad, fecha_registro)
VALUES
(1, 'Maria Perez', 'maria@gmail.com', 'Montevideo', '2026-10-01'),
(2, 'Juan Rodriguez', 'juan@gmail.com', 'Canelones', '2026-10-05'),
(3, 'Laura Silva', 'laura@gmail.com', 'Maldonado', '2026-10-10');

INSERT INTO productos
(id_producto, nombre_producto, id_categoria, precio, stock, activo)
VALUES
(1, 'Notebook Lenovo', 1, 45000.00, 10, 1),
(2, 'Samsung Galaxy', 2, 28000.00, 15, 1),
(3, 'Mouse Logitech', 3, 1200.00, 30, 1),
(4, 'Notebook HP', 1, 52000.00, 8, 1);

INSERT INTO ventas
(id_venta, id_cliente, id_producto, fecha, cantidad, total, canal)
VALUES
(1, 1, 1, '2026-10-15', 1, 45000.00, 'Online'),
(2, 2, 2, '2026-10-16', 1, 28000.00, 'Local'),
(3, 3, 3, '2026-10-17', 2, 2400.00, 'Online'),
(4, 1, 4, '2026-10-18', 1, 52000.00, 'Local');

-- VALIDACION DE LAS TABLAS

SELECT * FROM categorias;

SELECT * FROM clientes;

SELECT * FROM productos;

SELECT * FROM ventas;