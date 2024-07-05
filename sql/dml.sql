--INSERTS
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
(1, 'Juan', 'Pérez', 'García', '101', 'juan.perez@example.com', 'OF1', NULL, 'Gerente'),
(2, 'Ana', 'López', 'Martínez', '102', 'ana.lopez@example.com', 'OF2', 1, 'Subgerente');


INSERT INTO cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, codigo_empleado_rep_ventas, limite_credito) VALUES 
(1, 'Cliente 1', 'Carlos', 'Sánchez', '123456789', '987654321', 'Calle Falsa 123', '', 'Madrid', 'Europa', 'España', '28001', 1, 10000.00),
(2, 'Cliente 2', 'María', 'Gómez', '987654321', '123456789', 'Avenida Siempre Viva 456', '', 'Barcelona', 'Europa', 'España', '08001', 2, 20000.00);


INSERT INTO pago (codigo_cliente, forma_pago, id_transaccion, fecha_pago, total) VALUES 
(1, 'Tarjeta de Crédito', 'TX001', '2024-07-01', 150.00),
(2, 'Transferencia Bancaria', 'TX002', '2024-07-02', 250.00);


INSERT INTO pedido (codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, codigo_cliente) VALUES 
(1, '2024-07-01', '2024-07-05', '2024-07-03', 'Entregado', 'Todo correcto', 1),
(2, '2024-07-02', '2024-07-06', '2024-07-04', 'Pendiente', 'Pendiente de entrega', 2);


INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea) VALUES 
(1, 'P001', 2, 10.00, 1),
(1, 'P002', 1, 20.00, 2),
(2, 'P001', 5, 10.00, 1);


-- CONSULTA 1
SELECT o.codigo_oficina, o.ciudad
FROM oficina AS o;

--CONSULTA 2
SELECT 