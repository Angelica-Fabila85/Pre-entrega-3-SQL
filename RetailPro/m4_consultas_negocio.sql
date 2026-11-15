-- CONSULTA 1: RESUMEN EJECUTIVO MENSUAL

SELECT
    MONTH(fecha) AS mes,
    SUM(total) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(total) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha)
ORDER BY mes;
-- CONSULTA 2: TOP 5 PRODUCTOS

SELECT TOP (5)
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(total) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
-- CONSULTA 3: CLIENTES RECURRENTES

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(total) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;
-- CONSULTA 4: COMPARACION CON EL PROMEDIO GENERAL

WITH facturacion_producto AS (
    SELECT
        id_producto,
        SUM(total) AS total_facturado
    FROM ventas
    GROUP BY id_producto
),
promedio_general AS (
    SELECT
        AVG(total_facturado) AS promedio_facturacion
    FROM facturacion_producto
)

SELECT
    fp.id_producto,
    fp.total_facturado,
    pg.promedio_facturacion,
    CASE
        WHEN fp.total_facturado > pg.promedio_facturacion
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS clasificacion
FROM facturacion_producto fp
CROSS JOIN promedio_general pg
ORDER BY fp.total_facturado DESC;

-- CONCLUSIONES DE NEGOCIO

-- 1. Durante octubre se registraron 4 pedidos,
-- con una facturacion total de $127400 y un ticket
-- promedio de $31850.

-- 2. Los productos 4 y 1 lideran la facturacion,
-- generando $52000 y $45000 respectivamente.

-- 3. El cliente 1 es recurrente, con 2 pedidos
-- y un gasto acumulado de $97000.

-- 4. Los productos 1 y 4 concentran aproximadamente
-- el 76.1% de la facturacion total.

-- 5. Los productos 2 y 3 se encuentran por debajo
-- del promedio general de facturacion.
