INSERT INTO gama_producto (gama, descripcion_texto, descripcion_html, imagen) VALUES 
('Gama1', 'Descripción de la gama 1', 'Descripción de la gama 1', 'imagen1.jpg'),
('Gama2', 'Descripción de la gama 2', 'Descripción de la gama 2', 'imagen2.jpg');

INSERT INTO oficina (codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2) VALUES 
('OF1', 'Madrid', 'España', 'Europa', '28001', '123456789', 'Calle Falsa 123', ''),
('OF2', 'Barcelona', 'España', 'Europa', '08001', '987654321', 'Avenida Siempre Viva 456', '');


INSERT INTO producto (codigo_producto, nombre, gama, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor) VALUES 
('P001', 'Producto 1', 'Gama1', '10x10x10', 'Proveedor 1', 'Descripción del producto 1', 100, 10.00, 7.00),
('P002', 'Producto 2', 'Gama2', '20x20x20', 'Proveedor 2', 'Descripción del producto 2', 200, 20.00, 14.00);


INSERT INTO empleado (codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto) VALUES 
(3, 'Juan', 'Pérez', 'García', '101', 'juan.perez@example.com', 'OF1', NULL, 'jefe')
(4, 'Ana', 'López', 'Martínez', '102', 'ana.lopez@example.com', 'OF2', 7, 'Subgerente')
(6, 'jjj', 'López', 'Martínez', '102', 'ana.lopez@example.com', 'OF2', 6, 'jefejefe');


INSERT INTO cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, codigo_empleado_rep_ventas, limite_credito) VALUES 
(1, 'Cliente 1', 'Carlos', 'Sánchez', '123456789', '987654321', 'Calle Falsa 123', '', 'Madrid', 'Europa', 'España', '28001', 3, 10000.00),
(2, 'Cliente 2', 'María', 'Gómez', '987654321', '123456789', 'Avenida Siempre Viva 456', '', 'Barcelona', 'Europa', 'España', '08001', 4, 20000.00);
(5, 'Cliente 2', 'María', 'Gómez', '987654321', '123456789', 'Avenida Siempre Viva 456', '', 'Barcelona', 'Europa', 'España', '08001', 20000.00);


INSERT INTO pago (codigo_cliente, forma_pago, id_transaccion, fecha_pago, total) VALUES 
(1, 'Tarjeta de Crédito', 'TX001', '2024-07-01', 150.00),
(2, 'Transferencia Bancaria', 'TX002', '2024-07-02', 250.00),
(2, 'Transferencia Bancaria', 'TX003', '2024-07-02', 250.00);


INSERT INTO pedido (codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, codigo_cliente) VALUES 
(1, '2024-07-01', '2024-07-05', '2024-07-03', 'Entregado', 'Todo correcto', 1),
(2, '2024-07-02', '2024-07-06', '2024-07-04', 'Pendiente', 'Pendiente de entrega', 2);


INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea) VALUES 
(1, 'P001', 2, 10.00, 1),
(1, 'P002', 1, 20.00, 2),
(2, 'P001', 5, 10.00, 1);

---------------------------------------
--1--
SELECT o.codigo_oficina, o.ciudad
FROM oficina o;

--2--
SELECT o.codigo_oficina, o.ciudad, o.telefono
FROM oficina o
WHERE o.pais = "España";

--3--
SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2, e.email, e.codigo_jefe
FROM empleado e 
WHERE e.codigo_jefe = 7;

--4--
SELECT e.codigo_empleado, e.puesto, e.nombre, e.apellido1, e.apellido2, e.email
FROM empleado e 
WHERE e.puesto = "jefe";

--5
SELECT e.nombre, e.apellido1, e.apellido2, e.puesto
FROM empleado AS e
WHERE e.puesto <> "Representante de ventas";

--6
SELECT c.codigo_cliente, c.nombre_cliente, c.pais
FROM cliente AS c
WHERE c.pais = "España";

--7
SELECT p.estado
FROM pedido AS p;

--8
SELECT DISTINCT p.codigo_cliente
FROM pago AS p
WHERE p.fecha_pago LIKE "%2008%";

--9
SELECT p.codigo_pedido, p.codigo_cliente, p.fecha_entrega, p.fecha_entrega
FROM pedido AS p
WHERE p.fecha_entrega > p.fecha_entrega;

--10--
SELECT p.codigo_pedido, p.codigo_cliente, p.fecha_esperada, p.fecha_entrega
FROM pedido p
WHERE DATEDIFF(p.fecha_esperada,p.fecha_entrega) = 2;

--11--
SELECT p.codigo_pedido, p.estado
FROM pedido p, (
    SELECT YEAR(p.fecha_entrega) AS año
    FROM pedido p
    WHERE p.estado = "Rechazado"
)sub
WHERE sub.año = "2009" AND p.estado = "Rechazado";

--12--
SELECT p.codigo_pedido, p.estado
FROM pedido p, (
    SELECT MONTH(p.fecha_entrega) AS mes
    FROM pedido p
    WHERE p.estado = "Entregado"
)sub
WHERE sub.mes = "01" AND p.estado = "Entregado";

--13--
SELECT p.codigo_cliente, p.forma_pago, p.fecha_pago, p.total
FROM pago p
WHERE p.forma_pago = "Paypal" AND p.fecha_pago LIKE "%2008%";

--14--
SELECT DISTINCT p.forma_pago
FROM pago p;

--15--
SELECT p.codigo_producto, p.nombre, p.gama, p.precio_venta
FROM producto p
WHERE p.gama = "Gama2" AND p.cantidad_en_stock > 100
ORDER BY p.precio_venta DESC;

--16--
SELECT c.codigo_cliente, c.nombre_cliente, c.codigo_empleado_rep_ventas
FROM cliente as c
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE ciudad = "Madrid" AND e.codigo_empleado IN (11,30);

-----MULTITABLA-------
--1--
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
FROM cliente c
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_cliente;

--2--
SELECT c.nombre_cliente, e.nombre
FROM pago p
INNER JOIN cliente c ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

--3--


--4--
SELECT c.codigo_cliente, c.nombre_cliente, e.nombre AS nombre_representante, o.ciudad AS ciudad_oficina
FROM cliente c
LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE p.codigo_cliente IS NOT NULL;

--5--
SELECT c.codigo_cliente, c.nombre_cliente, e.nombre AS nombre_representante, o.ciudad AS ciudad_oficina
FROM cliente c
LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE p.codigo_cliente IS NULL;

--6--
SELECT c.codigo_cliente, c.nombre_cliente, o.codigo_oficina, o.linea_direccion1
FROM cliente c
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE o.ciudad = "Fuenlabrada";

--7--
SELECT c.nombre_cliente, e.nombre AS nombre_representante, o.ciudad AS ciudad_oficina
FROM cliente c
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE c.codigo_empleado_rep_ventas IS NOT NULL;

--8--
SELECT e.nombre AS nombre_empleado, e1.nombre AS nombre_jefe
FROM empleado e
INNER JOIN empleado e1 ON e.codigo_jefe = e1.codigo_empleado;

--9--
SELECT e.nombre AS nombre_empleado, e1.nombre AS nombre_jefe, e2.nombre AS nombre_jefe_del_jefe
FROM empleado e
INNER JOIN empleado e1 ON e.codigo_jefe = e1.codigo_empleado
INNER JOIN empleado e2 ON e.codigo_jefe = e2.codigo_empleado;

--10--
SELECT c.nombre_cliente
FROM cliente c, (
    SELECT p.fecha_entrega, p.fecha_esperada
    FROM pedido p
    WHERE p.fecha_entrega > p.fecha_esperada
)tiempo;

--11--
SELECT c.nombre_cliente, g.gama, g.descripcion_texto
FROM detalle_pedido dp
INNER JOIN pedido pe ON pe.codigo_pedido = dp.codigo_pedido
INNER JOIN producto pr ON pr.codigo_producto = dp.codigo_producto
INNER JOIN cliente c ON c.codigo_cliente = pe.codigo_cliente
INNER JOIN gama_producto g ON g.gama = pr.gama; 

-----CONSULTAS MULTITABLA 2------
--1--
SELECT c.codigo_cliente, c.nombre_cliente
FROM cliente c
LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
WHERE p.codigo_cliente IS NULL; 

--2--
SELECT c.codigo_cliente, c.nombre_cliente
FROM cliente c
LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
WHERE p.codigo_cliente IS NULL; 

--3--
SELECT c.codigo_cliente, c.nombre_cliente
FROM cliente c
LEFT JOIN pago pa ON pa.codigo_cliente = c.codigo_cliente
LEFT JOIN pedido pe ON pe.codigo_cliente = c.codigo_cliente
WHERE pa.codigo_cliente IS NULL OR pe.codigo_cliente IS NULL; 

--4--
SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2
FROM empleado e
RIGHT JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE e.codigo_oficina IS NULL; 

--5--
SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL; 

--6--
SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2, o.codigo_oficina, o.ciudad, o.pais, o.region, o.codigo_postal, o.linea_direccion1
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE c.codigo_empleado_rep_ventas IS NULL; 

--7--
SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2
FROM empleado e
RIGHT JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE e.codigo_oficina IS NULL OR c.codigo_empleado_rep_ventas IS NULL; 

--8--
SELECT p.codigo_producto, p.nombre
FROM Producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

--9--
SELECT p.codigo_producto, p.nombre, p.descripcion, g.imagen
FROM Producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
INNER JOIN gama_producto g ON g.gama = p.gama
WHERE dp.codigo_producto IS NULL;

--10--
SELECT
FROM empleado e

----RESUMEN----

--1--
SELECT COUNT(*)
FROM empleado;

--2--
SELECT c.ciudad, COUNT(*) AS numero_clientes
FROM cliente c
GROUP BY c.ciudad;

--3--
SELECT AVG(p.total)
FROM pago p
WHERE p.fecha_pago LIKE "%2009%";

--4--
SELECT p.estado, 
FROM pedido p
GROUP BY p.estado
ORDER BY 