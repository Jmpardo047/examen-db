### EXAMEN GARDEN DATABASE

##### Consultas sobre una tabla

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

   ```sql
   SELECT o.codigo_oficina, o.ciudad
   FROM oficina AS o;
   ```

   

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

   ```sql
   SELECT o.codigo_oficina, o.ciudad, o.telefono
   FROM oficina o
   WHERE o.pais = "España";
   ```

   

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7. 

   ```sql
   SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2, e.email, e.codigo_jefe
   FROM empleado e 
   WHERE e.codigo_jefe = 7;
   ```

   

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa. 

   ```sql
   SELECT e.codigo_empleado, e.puesto, e.nombre, e.apellido1, e.apellido2, e.email
   FROM empleado e 
   WHERE e.puesto = "jefe";
   ```

   

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas. 

   ```sql
   SELECT e.nombre, e.apellido1, e.apellido2, e.puesto
   FROM empleado AS e
   WHERE e.puesto <> "Representante de ventas";
   ```

   

6. Devuelve un listado con el nombre de los todos los clientes españoles. 

   ```sql
   SELECT c.codigo_cliente, c.nombre_cliente, c.pais
   FROM cliente AS c
   WHERE c.pais = "España";
   ```

   

7. Devuelve un listado con los distintos estados por los que puede pasar un pedido. 

   ```sql
   SELECT p.estado
   FROM pedido AS p;
   ```

   

8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta: 

• Utilizando la función YEAR de MySQL. 

• Utilizando la función DATE_FORMAT de MySQL. 

• Sin utilizar ninguna de las funciones anteriores. 

```sql
SELECT DISTINCT p.codigo_cliente
FROM pago AS p
WHERE p.fecha_pago LIKE "%2008%";
```



9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo. 

   ```sql
   SELECT p.codigo_pedido, p.codigo_cliente, p.fecha_entrega, p.fecha_entrega
   FROM pedido AS p
   WHERE p.fecha_entrega > p.fecha_entrega;
   ```

   

10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada. 

• Utilizando la función ADDDATE de MySQL. 

• Utilizando la función DATEDIFF de MySQL. 

• ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -? 

```sql
SELECT p.codigo_pedido, p.codigo_cliente, p.fecha_esperada, p.fecha_entrega
FROM pedido p
WHERE DATEDIFF(p.fecha_esperada,p.fecha_entrega) = 2;
```



11. Devuelve un listado de todos los pedidos que fueron **rechazados** en 2009. 

    ```sql
    SELECT p.codigo_pedido, p.estado
    FROM pedido p, (
        SELECT YEAR(p.fecha_entrega) AS año
        FROM pedido p
        WHERE p.estado = "Rechazado"
    )sub
    WHERE sub.año = "2009" AND p.estado = "Rechazado";
    ```

    

12. Devuelve un listado de todos los pedidos que han sido **entregados** en el mes de enero de cualquier año.

    ```sql
    SELECT p.codigo_pedido, p.estado
    FROM pedido p, (
        SELECT MONTH(p.fecha_entrega) AS mes
        FROM pedido p
        WHERE p.estado = "Entregado"
    )sub
    WHERE sub.mes = "01" AND p.estado = "Entregado";
    ```

    

13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor. 

    ```sql
    SELECT p.codigo_cliente, p.forma_pago, p.fecha_pago, p.total
    FROM pago p
    WHERE p.forma_pago = "Paypal" AND p.fecha_pago LIKE "%2008%";
    ```

14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas. 

    ```sql
    SELECT DISTINCT p.forma_pago
    FROM pago p;
    ```

    

15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio. 

    ```sql
    SELECT p.codigo_producto, p.nombre, p.gama, p.precio_venta
    FROM producto p
    WHERE p.gama = "Gama2" AND p.cantidad_en_stock > 100
    ORDER BY p.precio_venta DESC;
    ```

    

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30. 

    ```sql
    SELECT c.codigo_cliente, c.nombre_cliente, c.codigo_empleado_rep_ventas
    FROM cliente as c
    INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    WHERE ciudad = "Madrid" AND e.codigo_empleado IN (11,30);
    ```

    

**Consultas multitabla (Composición interna)** 

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN. 

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas. 

   ```sql
   SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
   FROM cliente c
   INNER JOIN empleado e ON e.codigo_empleado = c.codigo_cliente;
   ```

   

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas. 

   ```sql
   SELECT c.nombre_cliente, e.nombre
   FROM pago p
   INNER JOIN cliente c ON c.codigo_cliente = p.codigo_cliente
   INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas;
   ```

   

3. Muestra el nombre de los clientes que **no** hayan realizado pagos junto con el nombre de sus representantes de ventas. 

   ```sql
   SELECT c.codigo_cliente, c.nombre_cliente, e.nombre
   FROM cliente c
   LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
   INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
   WHERE p.codigo_cliente IS NULL;
   ```

   

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

   ```sql
   SELECT c.codigo_cliente, c.nombre_cliente, e.nombre AS nombre_representante, o.ciudad AS ciudad_oficina
   FROM cliente c
   LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
   INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
   INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   WHERE p.codigo_cliente IS NOT NULL;
   ```

    

5. Devuelve el nombre de los clientes que **no** hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante. 

   ```sql
   SELECT c.codigo_cliente, c.nombre_cliente, e.nombre AS nombre_representante, o.ciudad AS ciudad_oficina
   FROM cliente c
   LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
   INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
   INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   WHERE p.codigo_cliente IS NULL;
   ```

   

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

   ```sql
   SELECT c.codigo_cliente, c.nombre_cliente, o.codigo_oficina, o.linea_direccion1
   FROM cliente c
   INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
   INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   WHERE o.ciudad = "Fuenlabrada";
   ```

    

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante. 

   ```sql
   SELECT c.nombre_cliente, e.nombre AS nombre_representante, o.ciudad AS ciudad_oficina
   FROM cliente c
   INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
   INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   WHERE c.codigo_empleado_rep_ventas IS NOT NULL;
   ```

   

8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

   ```sql
   SELECT e.nombre AS nombre_empleado, e1.nombre AS nombre_jefe
   FROM empleado e
   INNER JOIN empleado e1 ON e.codigo_jefe = e1.codigo_empleado;
   ```

   

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe. 

   ```sql
   SELECT e.nombre AS nombre_empleado, e1.nombre AS nombre_jefe, e2.nombre AS nombre_jefe_del_jefe
   FROM empleado e
   INNER JOIN empleado e1 ON e.codigo_jefe = e1.codigo_empleado
   INNER JOIN empleado e2 ON e.codigo_jefe = e2.codigo_empleado;
   ```

   

10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido. 

    ```sql
    SELECT c.nombre_cliente
    FROM cliente c, (
        SELECT p.fecha_entrega, p.fecha_esperada
        FROM pedido p
        WHERE p.fecha_entrega > p.fecha_esperada
    )tiempo;
    ```

    

11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente. 

    ```sql
    SELECT c.nombre_cliente, g.gama, g.descripcion_texto
    FROM detalle_pedido dp
    INNER JOIN pedido pe ON pe.codigo_pedido = dp.codigo_pedido
    INNER JOIN producto pr ON pr.codigo_producto = dp.codigo_producto
    INNER JOIN cliente c ON c.codigo_cliente = pe.codigo_cliente
    INNER JOIN gama_producto g ON g.gama = pr.gama; 
    ```

    

**Consultas multitabla (Composición externa)** 

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN. 

1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago. 

   ```sql
   SELECT c.codigo_cliente, c.nombre_cliente
   FROM cliente c
   LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
   WHERE p.codigo_cliente IS NULL; 
   ```

   

2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido. 

   ```sql
   SELECT c.codigo_cliente, c.nombre_cliente
   FROM cliente c
   LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
   WHERE p.codigo_cliente IS NULL; 
   ```

   

3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido. 

   ```sql
   SELECT c.codigo_cliente, c.nombre_cliente
   FROM cliente c
   LEFT JOIN pago pa ON pa.codigo_cliente = c.codigo_cliente
   LEFT JOIN pedido pe ON pe.codigo_cliente = c.codigo_cliente
   WHERE pa.codigo_cliente IS NULL OR pe.codigo_cliente IS NULL; 
   ```

   

4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada. 

   ```sql
   SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2
   FROM empleado e
   RIGHT JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   WHERE e.codigo_oficina IS NULL; 
   ```

   

5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado. 

   ```sql
   SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2
   FROM empleado e
   LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   WHERE c.codigo_empleado_rep_ventas IS NULL; 
   ```

   

6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan. 

   ```sql
   SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2, o.codigo_oficina, o.ciudad, o.pais, o.region, o.codigo_postal, o.linea_direccion1
   FROM empleado e
   LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   WHERE c.codigo_empleado_rep_ventas IS NULL; 
   ```

   

7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado. 

   ```sql
   SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2
   FROM empleado e
   RIGHT JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   WHERE e.codigo_oficina IS NULL OR c.codigo_empleado_rep_ventas IS NULL; 
   ```

   

8. Devuelve un listado de los productos que nunca han aparecido en un pedido. 

   ```sql
   SELECT p.codigo_producto, p.nombre
   FROM Producto p
   LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
   WHERE dp.codigo_producto IS NULL;
   ```

   

9. Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.

   ```sql
   SELECT p.codigo_producto, p.nombre, p.descripcion, g.imagen
   FROM Producto p
   LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
   INNER JOIN gama_producto g ON g.gama = p.gama
   WHERE dp.codigo_producto IS NULL;
   ```

   

10. Devuelve las oficinas donde **no trabajan** ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales. 

    ```
    
    ```

    

11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago. 

12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado. 

**Consultas resumen** 

1. ¿Cuántos empleados hay en la compañía? 
2. ¿Cuántos clientes tiene cada país? 
3. ¿Cuál fue el pago medio en 2009? 
4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos. 
5. Calcula el precio de venta del producto más caro y más barato en una misma consulta. 
6. Calcula el número de clientes que tiene la empresa. 
7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid? 
8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M? 
9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno. 
10. Calcula el número de clientes que no tiene asignado representante de ventas. 
11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente. 
12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos. 
14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas. 
15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores. 
16. La misma información que en la pregunta anterior, pero agrupada por código de producto. 
17. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR. 
18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA). 
19. Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos. 

**Consultas variadas** 

1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. 
2. Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago. 
3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor. 
4. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del 

representante de ventas, de aquellos clientes que no hayan realizado 