USE TechStore;
GO

-- =====================================
-- CONSULTA 1: VISTA ENRIQUECIDA
-- INNER JOIN entre ventas, clientes y productos
-- =====================================

SELECT
    v.fecha,
    v.id_cliente,
    p.nombre_producto,
    v.cantidad,
    p.precio AS precio_unitario,
    (v.cantidad * p.precio) AS total_calculado
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto;


-- =====================================
-- CONSULTA 2: CLIENTES SIN COMPRAS
-- =====================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: En los datos de prueba hay 3 clientes
-- registrados y 0 clientes sin compras.
-- Implicancia CRM: todos los clientes tienen actividad
-- comercial registrada.


-- =====================================
-- CONSULTA 3: PRODUCTOS SIN VENTAS
-- =====================================

SELECT
    p.nombre_producto,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- Hallazgo: En los datos de prueba hay 4 productos
-- y 0 productos sin ventas.
-- Implicancia Producto: todo el catálogo tiene
-- actividad comercial registrada.


-- =====================================
-- CONSULTA 4: CONSOLIDADO POR CANAL
-- UNION ALL y agrupación por canal
-- =====================================

SELECT
    canal,
    SUM(total) AS total_facturado
FROM (
    SELECT
        'Online' AS canal,
        total
    FROM ventas
    WHERE canal = 'Online'

    UNION ALL

    SELECT
        'Local' AS canal,
        total
    FROM ventas
    WHERE canal = 'Local'
) AS ventas_por_canal
GROUP BY canal;
