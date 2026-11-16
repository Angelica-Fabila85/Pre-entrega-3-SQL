USE RetailPro;
GO
FROM dbo.Clientes c
LEFT JOIN dbo.Ventas v
    ON c.CustomerID = v.CustomerID
WHERE v.CustomerID IS NULL;

-- Hallazgo: Los 200 clientes registrados realizaron al menos
-- una compra. No se identificaron clientes sin compras.


-- CONSULTA 3: PRODUCTOS SIN VENTAS
-- Identifica productos del catálogo sin movimientos.

SELECT
    p.NombreProducto,
    p.Categoria,
    p.PrecioUnitario
FROM dbo.Productos p
LEFT JOIN dbo.Ventas v
    ON p.ProductID = v.ProductID
WHERE v.ProductID IS NULL;

-- Hallazgo: Los 25 productos del catálogo registran ventas.
-- No se identificaron productos sin movimientos comerciales.


-- CONSULTA 4: CONSOLIDADO POR PERIODO
-- Divide las ventas en dos períodos utilizando UNION ALL.

SELECT
    canal,
    SUM(total) AS total_facturado
FROM (
    SELECT
        'Periodo 2024' AS canal,
        MontoTotal AS total
    FROM dbo.Ventas
    WHERE FechaCompra < '20250101'

    UNION ALL

    SELECT
        'Periodo 2025' AS canal,
        MontoTotal AS total
    FROM dbo.Ventas
    WHERE FechaCompra >= '20250101'
) AS ventas_por_periodo
GROUP BY canal;

-- Hallazgo: El período 2024 registró una facturación de
-- $92.490.654, superior a los $32.475.763 de 2025.