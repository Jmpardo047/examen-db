DROP DATABASE IF EXISTS garden;
CREATE DATABASE garden;
USE garden;

CREATE TABLE IF NOT EXISTS gama_producto(
    gama VARCHAR(50),
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256),
    CONSTRAINT pk_gama_producto PRIMARY KEY (gama)
);

CREATE TABLE IF NOT EXISTS producto(
    codigo_producto VARCHAR(15),
    nombre VARCHAR(70),
    gama VARCHAR(50),
    dimensiones VARCHAR(25),
    proveedor VARCHAR(50),
    descripcion TEXT,
    cantidad_en_stock SMALLINT(6),
    precio_venta DECIMAL(15,2),
    precio_proveedor DECIMAL(15,2),
    CONSTRAINT pk_codigo_producto PRIMARY KEY (codigo_producto),
    CONSTRAINT fk_gama_producto FOREIGN KEY (gama) REFERENCES gama_producto(gama)
);

CREATE TABLE IF NOT EXISTS detalle_pedido