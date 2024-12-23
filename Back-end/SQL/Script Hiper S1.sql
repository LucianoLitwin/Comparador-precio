DROP TABLE IF EXISTS dbo.provincias_localidades;
DROP TABLE IF EXISTS dbo.productos_sucursales;
DROP TABLE IF EXISTS dbo.productos;
DROP TABLE IF EXISTS dbo.categorias_productos;
DROP TABLE IF EXISTS dbo.rubros_productos;
DROP TABLE IF EXISTS dbo.tipos_servicios_sucursales;
DROP TABLE IF EXISTS dbo.tipos_servicios_supermercado;
DROP TABLE IF EXISTS dbo.horarios_sucursales;
DROP TABLE IF EXISTS dbo.sucursales;
DROP TABLE IF EXISTS dbo.supermercado;
DROP TABLE IF EXISTS dbo.localidades;
DROP TABLE IF EXISTS dbo.provincias;
DROP TABLE IF EXISTS dbo.paises;
DROP TABLE IF EXISTS dbo.empresas_externas;
DROP TABLE IF EXISTS dbo.tipos_productos;
DROP TABLE IF EXISTS dbo.marcas_productos;


-- Tabla rubros_productos
CREATE TABLE dbo.rubros_productos (
    nro_rubro INT NOT NULL,
    nom_rubro VARCHAR(100) NOT NULL,
    vigente BIT,
    CONSTRAINT PK_rubros_productos PRIMARY KEY (nro_rubro)
);
GO

-- Tabla categorias_productos
CREATE TABLE dbo.categorias_productos (
    nro_categoria INT NOT NULL,
    nom_categoria VARCHAR(100) NOT NULL,
    nro_rubro INT NOT NULL,
    vigente BIT,
    CONSTRAINT PK_categorias_productos PRIMARY KEY (nro_categoria),
    CONSTRAINT FK_categorias_rubros FOREIGN KEY (nro_rubro) 
        REFERENCES dbo.rubros_productos(nro_rubro)
);
GO

-- Tabla tipos_productos
CREATE TABLE dbo.tipos_productos (
    nro_tipo_producto INT NOT NULL,
	nro_categoria INT NOT NULL,
    nom_tipo_producto VARCHAR(100) NOT NULL,
    CONSTRAINT PK_tipos_productos PRIMARY KEY (nro_tipo_producto),
	CONSTRAINT FK_tipos_productos_categorias FOREIGN KEY (nro_categoria) 
        REFERENCES dbo.categorias_productos(nro_categoria)
);
GO

-- Tabla marcas_productos
CREATE TABLE dbo.marcas_productos (
    nro_marca INT NOT NULL,
    nom_marca VARCHAR(100) NOT NULL,
	nro_tipo_producto INT NOT NULL,
    vigente BIT,
    CONSTRAINT PK_marcas_productos PRIMARY KEY (nro_marca, nro_tipo_producto),
	CONSTRAINT FK_marcas_tipo_productos FOREIGN KEY (nro_tipo_producto) 
		REFERENCES dbo.tipos_productos(nro_tipo_producto)
);
GO



-- Tabla productos
CREATE TABLE dbo.productos (
    cod_barra VARCHAR(40) NOT NULL,
    nom_producto VARCHAR(100) NOT NULL,
    desc_producto TEXT,
    nro_categoria INT NOT NULL,
    nro_marca INT NOT NULL,
    nro_tipo_producto INT NOT NULL,
    imagen VARCHAR(255),
    vigente BIT,
    CONSTRAINT PK_productos PRIMARY KEY (cod_barra),
    CONSTRAINT FK_productos_categorias FOREIGN KEY (nro_categoria) 
        REFERENCES dbo.categorias_productos(nro_categoria),
    CONSTRAINT FK_productos_tipos FOREIGN KEY (nro_marca, nro_tipo_producto) 
        REFERENCES dbo.marcas_productos(nro_marca, nro_tipo_producto)
);
GO

-- Tabla paises
CREATE TABLE dbo.paises (
    cod_pais VARCHAR(3) NOT NULL,
    nom_pais VARCHAR(255) NOT NULL,
    local BIT,
    CONSTRAINT PK_paises PRIMARY KEY (cod_pais)
);
GO

-- Tabla provincias
CREATE TABLE dbo.provincias (
    cod_pais VARCHAR(3) NOT NULL,
    cod_provincia INT NOT NULL,
    nom_provincia VARCHAR(100) NOT NULL,
    CONSTRAINT PK_provincias PRIMARY KEY (cod_pais, cod_provincia),
    CONSTRAINT FK_provincias_paises FOREIGN KEY (cod_pais) 
        REFERENCES dbo.paises(cod_pais)
);
GO

-- Tabla localidades
CREATE TABLE dbo.localidades (
    nro_localidad INT NOT NULL,
    nom_localidad VARCHAR(100) NOT NULL,
    cod_pais VARCHAR(3) NOT NULL,
    cod_provincia INT NOT NULL,
    CONSTRAINT PK_localidades PRIMARY KEY (nro_localidad),
    CONSTRAINT FK_localidades_paises FOREIGN KEY (cod_pais) 
        REFERENCES dbo.paises(cod_pais),
    CONSTRAINT FK_localidades_provincias FOREIGN KEY (cod_pais, cod_provincia) 
        REFERENCES dbo.provincias(cod_pais, cod_provincia)
);
GO

-- Tabla sucursales
CREATE TABLE dbo.sucursales (
    nro_sucursal INT NOT NULL,
    nom_sucursal VARCHAR(100) NOT NULL,
    calle VARCHAR(100),
    nro_calle INT,
    telefono VARCHAR(20),
    coord_latitud DECIMAL(10, 7),
    coord_longitud DECIMAL(10, 7),
    nro_localidad INT NOT NULL,
    habilitada BIT,
    CONSTRAINT PK_sucursales PRIMARY KEY (nro_sucursal),
    CONSTRAINT FK_sucursales_localidades FOREIGN KEY (nro_localidad) 
        REFERENCES dbo.localidades(nro_localidad)
);
GO

-- Tabla horarios_sucursales
CREATE TABLE dbo.horarios_sucursales (
    nro_sucursal INT NOT NULL,
    dia_semana VARCHAR(20) NOT NULL,
    hora_desde TIME NOT NULL,
    hora_hasta TIME NOT NULL,
    CONSTRAINT PK_horarios_sucursales PRIMARY KEY (nro_sucursal, dia_semana),
    CONSTRAINT FK_horarios_sucursales FOREIGN KEY (nro_sucursal) 
        REFERENCES dbo.sucursales(nro_sucursal)
);
GO

-- Tabla tipos_servicios_supermercado
CREATE TABLE dbo.tipos_servicios_supermercado (
    nro_tipo_servicio INT NOT NULL,
    nom_tipo_servicio VARCHAR(100) NOT NULL,
    CONSTRAINT PK_tipos_servicios PRIMARY KEY (nro_tipo_servicio)
);
GO

-- Tabla tipos_servicios_sucursales
CREATE TABLE dbo.tipos_servicios_sucursales (
    nro_sucursal INT NOT NULL,
    nro_tipo_servicio INT NOT NULL,
	vigente BIT DEFAULT 1,
    CONSTRAINT PK_servicios_sucursales PRIMARY KEY (nro_sucursal, nro_tipo_servicio),
    CONSTRAINT FK_servicios_sucursales FOREIGN KEY (nro_sucursal) 
        REFERENCES dbo.sucursales(nro_sucursal),
    CONSTRAINT FK_servicios_tipo FOREIGN KEY (nro_tipo_servicio) 
        REFERENCES dbo.tipos_servicios_supermercado(nro_tipo_servicio)
);
GO

-- Tabla productos_sucursales
CREATE TABLE dbo.productos_sucursales (
    nro_sucursal INT NOT NULL,
    cod_barra VARCHAR(40) NOT NULL,
    precio DECIMAL(10, 2),
    vigente BIT,
    CONSTRAINT PK_productos_sucursales PRIMARY KEY (nro_sucursal, cod_barra),
    CONSTRAINT FK_productos_sucursal FOREIGN KEY (nro_sucursal) 
        REFERENCES dbo.sucursales(nro_sucursal),
    CONSTRAINT FK_productos_sucursal_barra FOREIGN KEY (cod_barra) 
        REFERENCES dbo.productos(cod_barra)
);
GO

-- Tabla empresas_externas
CREATE TABLE dbo.empresas_externas (
    nro_empresa INT NOT NULL,
    razon_social VARCHAR(100) NOT NULL,
    cuit_empresa VARCHAR(20) NOT NULL,
    token_servicio VARCHAR(100),
    CONSTRAINT PK_empresas_externas PRIMARY KEY (nro_empresa)
);
GO

-- Tabla supermercado
CREATE TABLE dbo.supermercado (
    cuit VARCHAR(20) NOT NULL,
    razon_social VARCHAR(100) NOT NULL,
    calle VARCHAR(100),
    nro_calle INT,
    telefono VARCHAR(20),
    CONSTRAINT PK_supermercado PRIMARY KEY (cuit)
);
GO


------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------


-- Insertar datos en la tabla paises
INSERT INTO dbo.paises (cod_pais, nom_pais, local)
VALUES 
    ('ARG', 'Argentina', 1);
GO

-- Insertar datos en la tabla provincias (5 provincias de Argentina)
INSERT INTO dbo.provincias (cod_pais, cod_provincia, nom_provincia)
VALUES 
    ('ARG', 1, 'Buenos Aires'),
    ('ARG', 2, 'Córdoba'),
    ('ARG', 3, 'Santa Fe'),
    ('ARG', 4, 'Mendoza'),
    ('ARG', 5, 'Salta');
GO

-- Insertar datos en la tabla localidades (10 localidades: 2 por provincia)
INSERT INTO dbo.localidades (nro_localidad, nom_localidad, cod_pais, cod_provincia)
VALUES 
    -- Localidades de Buenos Aires
    (1, 'La Plata', 'ARG', 1),
    (2, 'Mar del Plata', 'ARG', 1),

    -- Localidades de Córdoba
    (3, 'Córdoba Capital', 'ARG', 2),
    (4, 'Carlos Paz', 'ARG', 2),

    -- Localidades de Santa Fe
    (5, 'Rosario', 'ARG', 3),
    (6, 'Santa Fe Capital', 'ARG', 3),

    -- Localidades de Mendoza
    (7, 'Mendoza Capital', 'ARG', 4),
    (8, 'San Rafael', 'ARG', 4),

    -- Localidades de Salta
    (9, 'Salta Capital', 'ARG', 5),
    (10, 'Cafayate', 'ARG', 5);
GO

-- Insertar datos en la tabla supermercado (Disco)
INSERT INTO dbo.supermercado (cuit, razon_social, calle, nro_calle, telefono)
VALUES 
    ('201111111110', 'HiperLibertad', 'Av. Libertad', 4444, '351-1111111');
GO

-- Insertar datos en la tabla sucursales (2 sucursales del Disco)
INSERT INTO dbo.sucursales (nro_sucursal, nom_sucursal, calle, nro_calle, telefono, 
                            coord_latitud, coord_longitud, nro_localidad, habilitada)
VALUES 
	(1, 'HiperLibertad - Calle 50', 'Calle 50', 300, '0221-456-7890', -34.9203, -57.9538, 1, 1),
    (2, 'HiperLibertad - Quiros', 'Av. Duarte Quirós', 1100, '0351-789-4561', -31.4171, -64.1833, 3, 1),
    (3, 'HiperLibertad - Orono', 'Bv. Oroño', 800, '0341-456-7892', -32.9475, -60.6307, 5, 1),
    (4, 'HiperLibertad - Belgrano', 'Av. Belgrano', 1200, '0387-789-1234', -24.7822, -65.4234, 9, 1);
    
GO


-- Insertar datos en la tabla horarios_sucursales (Horarios para las 2 sucursales del Disco)
INSERT INTO dbo.horarios_sucursales (nro_sucursal, dia_semana, hora_desde, hora_hasta)
VALUES 
    -- Horarios para HiperLibertad - Rosario
    (1, 'Lunes', '08:00', '22:00'),
    (1, 'Martes', '08:00', '22:00'),
    (1, 'Miércoles', '08:00', '22:00'),
    (1, 'Jueves', '08:00', '22:00'),
    (1, 'Viernes', '08:00', '20:00'),
    (1, 'Sábado', '08:00', '20:00'),
    (1, 'Domingo', '09:00', '18:00'),

    -- Horarios para HiperLibertad - Salta Capital
    (2, 'Lunes', '09:00', '21:00'),
    (2, 'Martes', '09:00', '21:00'),
    (2, 'Miércoles', '09:00', '21:00'),
    (2, 'Jueves', '09:00', '21:00'),
    (2, 'Viernes', '09:00', '21:00'),
    (2, 'Sábado', '09:00', '19:00'),
    (2, 'Domingo', '10:00', '19:00'),

	-- Insertar horarios para HiperLibertad - Córdoba Capital
	(3, 'Lunes', '08:00', '22:00'),
    (3, 'Martes', '08:00', '22:00'),
    (3, 'Miércoles', '08:00', '22:00'),
    (3, 'Jueves', '08:00', '22:00'),
    (3, 'Viernes', '08:00', '20:00'),
    (3, 'Sábado', '08:00', '20:00'),
    (3, 'Domingo', '09:00', '18:00'),

    -- Insertar horarios para HiperLibertad - Córdoba Capital
    (4, 'Lunes', '09:00', '21:00'),
    (4, 'Martes', '09:00', '21:00'),
    (4, 'Miércoles', '09:00', '21:00'),
    (4, 'Jueves', '09:00', '21:00'),
    (4, 'Viernes', '09:00', '21:00'),
    (4, 'Sábado', '09:00', '19:00'),
    (4, 'Domingo', '10:00', '19:00');
GO

-- Insertar datos en la tabla tipos_servicios_supermercado
INSERT INTO dbo.tipos_servicios_supermercado (nro_tipo_servicio, nom_tipo_servicio)
VALUES 
    (1, 'Delivery'), 
    (2, 'Recolección en Tienda'),
    (3, 'Descuentos Exclusivos'), 
    (4, 'Club de Beneficios');
GO

-- Insertar datos en la tabla tipos_servicios_sucursales (Servicios por sucursal del Disco)
INSERT INTO dbo.tipos_servicios_sucursales (nro_sucursal, nro_tipo_servicio, vigente)
VALUES 
    -- Servicios para Disco - La Plata
    (1, 1, 1),  -- Delivery
    (1, 3, 1),  -- Descuentos Exclusivos
    -- Servicios para Disco - Córdoba Capital
    (2, 2, 1),  -- Recolección en Tienda
    (2, 4, 1),  -- Club de Beneficios

	(3, 1, 1),  -- Delivery
    (3, 2, 1),  -- Recolección en Tienda
    (3, 3, 1),  -- Descuentos Exclusivos

	(4, 1, 1),  -- Delivery
    (4, 4, 1);  -- Club de Beneficios
GO

-- Insertar datos en la tabla empresas_externas
INSERT INTO dbo.empresas_externas (nro_empresa, razon_social, cuit_empresa, token_servicio)
VALUES 
    (1, 'Logística Rápida SA', '30-65432100-8', 'token123456'),
    (2, 'Pagos Online SRL', '30-99887766-5', 'token789012'),
    (3, 'Publicidad y Marketing SAS', '30-11223344-1', 'token345678');
GO

-- Insertar datos en la tabla rubros_productos
INSERT INTO dbo.rubros_productos (nro_rubro, nom_rubro, vigente)
VALUES 
    (1, 'Lácteos', 1),
    (2, 'Carnes', 1),
    (3, 'Frutas y Verduras', 1),
    (4, 'Panadería', 1),
    (5, 'Bebidas', 1),
    (6, 'Legumbres y Conservas', 1),
    (7, 'Cuidado Personal', 1),
    (8, 'Limpieza Hogar', 1);
GO

-- Insertar datos en la tabla categorias_productos
INSERT INTO dbo.categorias_productos (nro_categoria, nom_categoria, nro_rubro, vigente)
VALUES 
    -- Lácteos
    (1, 'Leches', 1, 1),
    (2, 'Yogures', 1, 1),
    (3, 'Quesos', 1, 1),
    -- Carnes
    (4, 'Res', 2, 1),
    (5, 'Pollo', 2, 1),
    (6, 'Cerdo', 2, 1),
    -- Frutas y Verduras
    (7, 'Frutas Frescas', 3, 1),
    (8, 'Verduras Frescas', 3, 1),
    -- Panadería
    (9, 'Panes', 4, 1),
    (10, 'Facturas', 4, 1),
    -- Bebidas
    (11, 'Gaseosas', 5, 1),
    (12, 'Aguas', 5, 1),
    (13, 'Jugos', 5, 1),
    (14, 'Alcohol', 5, 1),
    -- Legumbres y Conservas
    (15, 'Legumbres', 6, 1),
    (16, 'Conservas', 6, 1),
    -- Cuidado Personal
    (17, 'Higiene Personal', 7, 1),
    (18, 'Cuidado Bucal', 7, 1),
    -- Limpieza Hogar
    (19, 'Limpieza General', 8, 1),
    (20, 'Lavado de Ropa', 8, 1);
GO

INSERT INTO dbo.tipos_productos (nro_tipo_producto, nro_categoria, nom_tipo_producto)
VALUES 
    -- Lacteos
    (1, 1, 'Leche Entera'),
    (2, 1, 'Leche Descremada'),
    (3, 1, 'Leche Sin Lactosa'),
    (4, 2, 'Yogur Natural'),
    (5, 2, 'Yogur con Frutas'),
    (6, 3, 'Queso Cremoso'),
    (7, 3, 'Queso Rallado'),
    (8, 3, 'Manteca'),
    (9, 3, 'Crema de Leche'),
    -- Carnes
    (10, 4, 'Bife de Res'),
    (11, 5, 'Pollo Entero'),
    (12, 6, 'Chuletas de Cerdo'),
    (13, 6, 'Hamburguesas'),
    (14, 6, 'Chorizos'),
    (15, 6, 'Jamon Cocido'),
    (16, 6, 'Jamon Crudo'),
    -- Frutas y Verduras
    (17, 7, 'Manzanas'),
    (18, 7, 'Naranjas'),
    (19, 7, 'Bananas'),
    (20, 8, 'Tomates'),
    (21, 8, 'Papas'),
    (22, 8, 'Zanahorias'),
    (23, 8, 'Cebollas'),
    (24, 8, 'Lechuga'),
    -- Panaderia
    (25, 9, 'Pan de Molde Blanco'),
    (26, 9, 'Pan Integral'),
    (27, 10, 'Facturas'),
    (28, 10, 'Galletas Dulces'),
    (29, 10, 'Galletas Saladas'),
    -- Bebidas
    (30, 11, 'Gaseosa Regular'),
    (31, 11, 'Gaseosa Light'),
    (32, 12, 'Agua Mineral con Gas'),
    (33, 12, 'Agua Mineral sin Gas'),
    (34, 13, 'Jugo de Naranja'),
    (35, 13, 'Jugo de Manzana'),
    (36, 14, 'Cerveza Rubia'),
    (37, 14, 'Vino Tinto'),
    -- Legumbres y Conservas
    (38, 15, 'Lentejas'),
    (39, 15, 'Arvejas'),
    (40, 15, 'Porotos Negros'),
    (41, 15, 'Porotos Blancos'),
    (42, 16, 'Pure de Tomate'),
    (43, 16, 'Atun en Lata'),
    (44, 16, 'Mermelada de Durazno'),
    -- Cuidado Personal
    (45, 17, 'Papel Higienico Doble Hoja'),
    (46, 17, 'Jabon de Tocador'),
    (47, 17, 'Shampoo'),
    (48, 17, 'Acondicionador'),
    (49, 18, 'Pasta Dental'),
    -- Limpieza Hogar
    (50, 19, 'Lavandina'),
    (51, 19, 'Detergente'),
    (52, 19, 'Limpiador Multiuso'),
    (53, 19, 'Desinfectante'),
    (54, 20, 'Jabon en Polvo'),
    -- Mas variedades
    (55, 3, 'Queso Azul'),
    (56, 16, 'Salsa Ketchup'),
    (57, 16, 'Mayonesa'),
    (58, 13, 'Te Verde'),
    (59, 13, 'Cafe Instantaneo'),
    (60, 13, 'Yerba Mate'),
    (61, 10, 'Galletas de Arroz'),
    (62, 13, 'Chocolate para Taza'),
    (63, 14, 'Cerveza Negra'),
    (64, 14, 'Vino Blanco'),
    (65, 16, 'Azucar Rubia'),
    (66, 16, 'Sal Fina'),
    (67, 16, 'Vinagre de Manzana'),
    (68, 16, 'Aceite de Girasol'),
    (69, 16, 'Aceite de Oliva'),
    -- Nuevos tipos para diversidad
    (70, 10, 'Galletas Sin Gluten'),
    (71, 1, 'Leche de Almendras'),
    (72, 2, 'Yogur Vegano'),
    (73, 6, 'Tofu'),
    (74, 15, 'Proteina en Polvo'),
    (75, 10, 'Snacks Saludables'),
    (76, 12, 'Agua Saborizada'),
    (77, 14, 'Cerveza Artesanal'),
    (78, 20, 'Detergente para Ropa'),
    (79, 20, 'Suavizante para Ropa'),
    (80, 17, 'Shampoo Anticaspa'),
    (81, 17, 'Papel Higienico Reciclado'),
    (82, 16, 'Vinagre Blanco'),
    (83, 16, 'Sal Marina'),
    (84, 7, 'Frutillas Congeladas'),
    (85, 13, 'Cafe Molido Gourmet'),
    (86, 13, 'Te Chai'),
    (87, 16, 'Azucar Mascabo'),
    (88, 16, 'Aceite de Coco'),
    (89, 6, 'Hamburguesa Vegana'),
    (90, 1, 'Leche de Avena'),
    (91, 10, 'Barras de Cereal'),
    (92, 10, 'Galletas Digestivas'),
    (93, 13, 'Te de Hierbas'),
    (94, 16, 'Mermelada Light'),
    (95, 16, 'Atun en Agua'),
    (96, 15, 'Porotos Rojos'),
    (97, 6, 'Carne de Pescado'),
    (98, 14, 'Harina Integral'),
    (99, 15, 'Avena Instantanea'),
    (100, 15, 'Snack de Frutas Deshidratadas');
GO


-- Insertar datos en la tabla marcas_productos
INSERT INTO dbo.marcas_productos (nro_marca, nom_marca, nro_tipo_producto, vigente)
VALUES 
    (1, 'La Serenisima', 1,1),
	(9, 'Bimbo', 25,1),
    (14, 'Swift', 10, 1),
    (15, 'Paladini', 14, 1),
    (16, 'Cagnoli', 12, 1),
    (17, 'Arcor', 17, 1),
    (18, 'San Miguel', 20, 1),
    (19, 'Molto', 22, 1),
    (20, 'Bimbo', 25, 1),
    (21, 'Fargo', 27, 1),
    (23, 'Coca-Cola', 30, 1),
    (24, 'Villavicencio', 32, 1),
    (27, 'Norton', 37, 1),
    (27, 'Norton', 64, 1), -- Vino Blanco
    (28, 'La Campagnola', 38, 1),
    (29, 'Arcor', 39, 1),
    (29, 'Arcor', 43, 1),
    (31, 'Colgate', 49, 1),
    (32, 'Elite', 45, 1),
    (33, 'Sedal', 48, 1),
    (34, 'Ala', 50, 1),
    (35, 'Vim', 52, 1),
    (38, 'Heinz', 56, 1),     -- Salsa Ketchup
    (38, 'Hellmann', 57, 1), -- Mayonesa
    (40, 'Nescafe', 59, 1),   -- Café Instantáneo
    (41, 'La Merced', 60, 1), -- Yerba Mate
    (43, 'Fenix', 62, 1),     -- Chocolate para Taza
    (47, 'Natura', 69, 1),    -- Aceite de Oliva
    (48, 'Arcor', 70, 1),     -- Galletas Sin Gluten
    (48, 'Silk', 71, 1),      -- Leche de Almendras
    (49, 'Crudda', 72, 1),    -- Yogur Vegano
    (54, 'Antares', 77, 1),   -- Cerveza Artesanal
    (55, 'Skip', 78, 1),      -- Detergente para Ropa
    (55, 'Suavitel', 79, 1),  -- Suavizante para Ropa
    (56, 'Head & Shoulders', 80, 1), -- Shampoo Anticaspa
    (60, 'Frutilla S.A.', 84, 1), -- Frutillas Congeladas
    (61, 'Bonafide', 85, 1),  -- Café Molido Gourmet
    (62, 'La Virginia', 86, 1), -- Té Chai
    (63, 'Ledesma', 87, 1),   -- Azúcar Mascabo
    (67, 'Granix', 91, 1),    -- Barras de Cereal
    (68, 'Havanna', 92, 1),   -- Galletas Digestivas
    (72, 'Goya', 96, 1),      -- Porotos Rojos
    (74, 'Morixe', 98, 1),    -- Harina Integral
    (75, 'Quaker', 99, 1),    -- Avena Instantánea
    (76, 'Arcor', 100, 1);    -- Snack de Frutas Deshidratadas
GO

-- Insertar productos en la tabla productos
INSERT INTO dbo.productos (cod_barra, nom_producto, desc_producto, nro_categoria, nro_marca, nro_tipo_producto, imagen, vigente)
VALUES
	-- Lacteos
    ('7790001000011', 'Leche Entera La Serenisima', 'Leche entera de alta calidad', 1, 1, 1, 'https://f2h.shop/media/catalog/product/cache/ab45d104292f1bb63d093e6be8310c97/i/m/imageedit_1_4837957539.png', 1),
    ('7790011000001', 'Leche de Almendras Silk', 'Bebida vegetal de almendra', 1, 48, 71, 'https://cafemartinez.vtexassets.com/arquivos/ids/158836/Silk-LecheAlmendrasSinAzucar.jpg?v=638298055738330000', 1),
    ('7790011000002', 'Yogur Vegano Crudda', 'Yogur sin productos animales', 2, 49, 72, 'https://estilorganico.com/738-large_default/yogur-vegano-sin-azucar-sabor-natural-x-160-grs-crudda.jpg', 1),
	-- Carnes
    ('7790002000011', 'Bife de Res Swift', 'Bife de res fresco y jugoso', 4, 14, 10, 'https://sinreservas.com.ar/download/multimedia.normal.a646e3931ea0a891.4167726567617220756e207469cc8174756c6f20283330295f6e6f726d616c2e77656270.webp', 1),
    ('7790012000003', 'Salchichas Viena Paladini', 'Salchichas estilo aleman', 4, 15, 14, 'https://acdn.mitiendanube.com/stores/001/157/846/products/diseno-sin-titulo-2022-03-09t132341-1951-9a0ced78192301f1d816468430575221-1024-1024.png', 1),
    ('7790012000004', 'Costilla de Cerdo Cagnoli', 'Costilla fresca y jugosa', 6, 16, 12, 'https://i.pinimg.com/736x/06/bc/3b/06bc3b038f807c5275291eb7cb013b48.jpg', 1),
	-- Frutas y Verduras
    ('7790013000005', 'Frutillas Congeladas Frutilla S.A.', 'Frutillas listas para batidos', 7, 60, 84, 'https://acdn.mitiendanube.com/stores/001/301/922/products/frutillas-congeladas1-3a2e9ed24ca3299ca716788305397970-480-0.jpg', 1),
    ('7790013000006', 'Zanahorias Baby Pascual', 'Zanahorias tiernas', 8, 19, 22, 'https://images.ecestaticos.com/RzmSokhH4AUwPIHWvwsPK5DdRxk=/15x121:2120x1302/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Ffc3%2Fd2f%2Feee%2Ffc3d2feee45e9d586adbba1be1abd51c.jpg', 1),
    ('7790003000011', 'Manzanas Rojas', 'Manzanas frescas y crujientes', 7, 17, 17, 'https://elegifruta.com.ar/wp-content/uploads/2017/07/manzana_roja.jpg', 1),
    ('7790003000028', 'Tomates', 'Tomates maduros para ensalada', 8, 18, 20, 'https://www.clarin.com/img/2024/02/22/zoiUbI60o_600x600__1.jpg', 1),
    -- Panaderia
    ('7790004000011', 'Pan de Molde Blanco', 'Pan fresco para sandwiches', 9, 9, 25, 'https://cdn.recetasderechupete.com/wp-content/uploads/2018/08/Pan-de-molde.jpg', 1),
    ('7790004000028', 'Facturas Variadas', 'Facturas dulces y crocantes', 10, 21, 27, 'https://www.cronica.com.ar/img/2022/04/06/recetas-de-factura-faci-casera-rapida_crop1649253823896.jpg?__scale=w:1200,h:900,t:2,fpx:960,fpy:542', 1),
    ('7790014000007', 'Baguette Artesanal', 'Pan frances fresco', 9, 20, 25, 'https://i.ytimg.com/vi/ahlZVBfmBcU/maxresdefault.jpg', 1),
    ('7790014000008', 'Galletas Digestivas', 'Galletas ricas en fibra', 10, 68, 92, 'https://sparlapalma.com/documents/10180/12821/748798_G.jpg', 1),
    -- Bebidas
    ('7790005000011', 'Gaseosa Regular Coca-Cola', 'Bebida gaseosa clasica', 11, 23, 30, 'https://f2h.shop/media/catalog/product/cache/ab45d104292f1bb63d093e6be8310c97/i/m/imageedit_3_4516158279.png', 1),
    ('7790005000028', 'Agua Mineral con Gas', 'Agua con gas refrescante', 12, 24, 32, 'https://statics.dinoonline.com.ar/imagenes/full_600x600_ma/3040006_f.jpg', 1),
    ('7790005000035', 'Vino Tinto', 'Vino tinto fino', 14, 27, 37, 'https://acdn.mitiendanube.com/stores/798/865/products/30280409-d1085f67ed38dffde716639326895645-640-0.jpg', 1),
    ('7790015000009', 'Te Chai', 'Te especiado estilo indio', 13, 62, 86, 'https://www.lavirginia.com.ar/wp-content/uploads/2022/01/7790150250501_02.jpg', 1),
    ('7790015000010', 'Vino Rosado', 'Vino suave y afrutado', 14, 27, 64, 'https://bodegaputruele.com/tienda/wp-content/uploads/2020/07/PUTRUELE-ROSADO-DULCE-2023.jpg', 1),
    -- Legumbres y Conservas
    ('7790006000011', 'Lentejas', 'Legumbres de alta calidad', 15, 28, 38, 'https://www.gastronomiavasca.net/uploads/image/file/4295/lentejas.jpg', 1),
    ('7790006000028', 'Atun en Lata', 'Atun en agua', 16, 29, 43, 'https://s1.elespanol.com/2020/06/22/ciencia/nutricion/pescado-atun-nutricion_499711411_154276028_1024x576.jpg', 1),
    ('7790016000011', 'Garbanzos', 'Legumbres para guisos', 15, 29, 39, 'https://saborgourmet.com/wp-content/uploads/garbanzos-cocidos.jpg', 1),
    ('7790016000012', 'Porotos Rojos', 'Legumbres ricas en proteinas', 15, 72, 96, 'https://desanroman.com.ar/agroseis/wp-content/uploads/2020/03/Colorado-Dark-01.jpg', 1),
    ('7790017000013', 'Pasta Dental Blanqueadora', 'Pasta dental para dientes mas blancos', 17, 31, 49, 'https://farmacityar.vtexassets.com/arquivos/ids/259892-800-auto?v=638609688649830000&width=800&height=auto&aspect=true', 1),
    ('7790017000014', 'Acondicionador Hidratante', 'Acondicionador con aceite de argan', 18, 33, 48, 'https://www.uomax.com.ar/12563-large_default/acondicionador-garnier-fructis-hydra-liss-x-350-ml.jpg', 1),
   -- Cuidado Personal
    ('7790007000011', 'Papel Higienico Doble Hoja', 'Papel suave y resistente', 17, 32, 45, 'https://softysar.vtexassets.com/arquivos/ids/158369/label-1.png?v=638600311504000000', 1),
    ('7790007000028', 'Shampoo Anticaspa', 'Shampoo especial para cuero cabelludo', 18, 56, 80, 'https://acdn.mitiendanube.com/stores/001/557/823/products/961-cac8f73ea4b41cae5c16863253449117-640-0.jpg', 1),
     -- Limpieza Hogar
    ('7790008000011', 'Lavandina', 'Producto para desinfeccion profunda', 19, 34, 50, 'https://jumboargentina.vtexassets.com/arquivos/ids/678470/Lavandina-Ayud-n-Cl-sica-1-L-2-248228.jpg?v=637739049680870000', 1),
    ('7790008000028', 'Detergente para Ropa', 'Detergente de alta eficiencia', 20, 55, 78, 'https://jumboargentina.vtexassets.com/arquivos/ids/826347/Detergente-Magistral-Ultra-Lim-n-Botella-750-Ml-1-1017530.jpg?v=638551209644270000', 1),
    ('7790018000015', 'Limpiador Multiuso', 'Producto para todo tipo de superficies', 19, 35, 52, 'https://limpiasol.com.ar/sitio/wp-content/uploads/2015/05/limpiador-multiuso@2x.png', 1),
    ('7790018000016', 'Suavizante para Ropa', 'Deja la ropa suave y perfumada', 20, 55, 79, 'https://cdn.batitienda.com/baticloud/images/product_picture_713358e44b564a7b815a5fec54d8f175_638337078378512678_0_m.jpg', 1),
    -- productos variados
    ('7790009000028', 'Cafe Instantaneo', 'Cafe listo en segundos', 13, 40, 59, 'https://acdn.mitiendanube.com/stores/001/157/846/products/copia-de-diseno-sin-nombre-611-a462dd7d4798d139ac16466564239451-1024-1024.png', 1),
    ('7790009000035', 'Yerba Mate', 'Yerba tradicional argentina', 13, 41, 60, 'https://shop.gustoargentino.com/cdn/shop/articles/yerba-mate-gusto-argentino.png?v=1621357637', 1),
    ('7790009000059', 'Galletas Sin Gluten', 'Snack saludable', 10, 48, 70, 'https://acdn.mitiendanube.com/stores/001/058/870/products/gull05_1-688f7a85db90451d2e16698435762616-640-0.jpeg', 1),
    ('7790009000066', 'Cerveza Artesanal', 'Bebida artesanal premium', 14, 54, 77, 'https://www.republicacervecerashop.com.mx/cdn/shop/articles/cerveza-artesanal_1600x.jpg?v=1703130948', 1),
    ('7790009000073', 'Snack de Frutas Deshidratadas', 'Fruta lista para llevar', 7, 76, 100, 'https://images.ecestaticos.com/VahaWc4uGYQGfs8BcxxivNLcg8A=/228x71:2019x1413/1200x900/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Ffda%2Fef3%2F908%2Ffdaef39083f74550604017b67fa3c073.jpg', 1),
    ('7790009000080', 'Aceite de Oliva', 'Aceite de alta calidad', 16, 47, 69, 'https://d22fxaf9t8d39k.cloudfront.net/d4733e2e53ee0d2a59be1ffc23318e25af45204f0754ad13c655c5c01f47c81d78302.jpeg', 1),
    ('7790009000087', 'Avena Instantanea', 'Avena para un desayuno rapido', 9, 75, 99, 'https://miserdiet.com.ar/wp-content/uploads/2022/08/avena-inst.jpg', 1),
    ('7790019000018', 'Chocolate Amargo', 'Chocolate sin azucar anadido', 10, 43, 62, 'https://www.infobae.com/resizer/v2/LZB5AJBQB5CZ7HOSNZY6Z3BFOQ.png?auth=f5c17e24b72c42be3a7af449cb1aadcc4a7ff7015a7eac86357c4a6f97ce1245&smart=true&width=1200&height=1200&quality=85', 1),
    ('7790019000019', 'Harina Integral', 'Harina para recetas saludables', 9, 74, 98, 'https://resizer.glanacion.com/resizer/v2/la-argentina-exporto-en-2017-harina-por-unos-350-SRODS4H5QZE6ZPEJJ5JFINC3XM.jpg?auth=41dd4b26326590de0a2f9c57fef9dfa4758909cc6ffac4c3b63a360bc485da91&width=1280&height=854&quality=70&smart=true', 1),
    ('7790019000020', 'Barras de Cereal', 'Barras con frutas y semillas', 10, 67, 91, 'https://silavegan.com/wp-content/uploads/2019/12/barritas-energeticas.jpg', 1),
    ('7790019000022', 'Azucar Mascabo', 'Azucar natural sin refinar', 12, 63, 87, 'https://http2.mlstatic.com/D_NQ_NP_765899-MLA42481566874_072020-O.webp', 1),
    ('7790019000023', 'Cafe Molido Gourmet', 'Cafe de alta calidad', 13, 61, 85, 'https://www.somoselcafe.com.ar/img/novedades/87.jpg', 1),
    ('7790019000026', 'Mayonesa Light', 'Mayonesa baja en calorias', 12, 38, 57, 'https://jumboargentina.vtexassets.com/arquivos/ids/604749/Mayonesa-Hellmanns-Light-Doypack-475-Gr-2-7060.jpg?v=637369900281530000', 1),
    ('7790019000027', 'Salsa Ketchup', 'Salsa clasica para acompanar comidas', 12, 38, 56, 'https://acdn.mitiendanube.com/stores/002/027/147/products/mrs-taste-ketchup-11-48a7c29d5e1a48d54a16439140987638-1024-1024.jpeg', 1);
GO

-- Insertar productos en la tabla productos_sucursales para ambas sucursales
INSERT INTO dbo.productos_sucursales (nro_sucursal, cod_barra, precio, vigente)
VALUES
    -- Sucursal 1: HiperLibertad - La Plata
	(1, '7790001000011', 125.50, 1),  -- Leche Entera La Serenísima
    (1, '7790011000001', 215.90, 1),  -- Leche de Almendras Silk
    (1, '7790011000002', 230.50, 1),  -- Yogur Vegano
    (1, '7790002000011', 396.50, 1),  -- Bife de Res
    (1, '7790012000003', 223.43, 1),  -- Salchichas Viena
    (1, '7790012000004', 368.24, 1),  -- Costilla de Cerdo
    (1, '7790013000005', 292.14, 1),  -- Frutillas Congeladas
    (1, '7790013000006', 119.60, 1),  -- Zanahorias Baby
    (1, '7790003000011', 67.50, 1),   -- Manzanas Rojas
    (1, '7790003000028', 49.57, 1),   -- Tomates
    (1, '7790004000011', 125.40, 1),  -- Pan de Molde Blanco
    (1, '7790004000028', 139.50, 1),  -- Facturas Variadas
    (1, '7790014000007', 147.20, 1),  -- Baguette Artesanal
    (1, '7790014000008', 93.38, 1),   -- Galletas Digestivas
    (1, '7790005000011', 216.08, 1),  -- Gaseosa Regular Coca-Cola
    (1, '7790005000028', 90.65, 1),   -- Agua Mineral con Gas
    (1, '7790005000035', 345.30, 1),  -- Vino Tinto
    (1, '7790015000009', 40.43, 1),   -- Té Chai
    (1, '7790015000010', 313.50, 1),  -- Vino Rosado
    (1, '7790006000011', 83.60, 1),   -- Lentejas
    (1, '7790006000028', 92.00, 1),   -- Atún en Lata
    (1, '7790016000011', 119.00, 1),  -- Garbanzos
    (1, '7790016000012', 94.50, 1),   -- Porotos Rojos
    (1, '7790017000013', 69.75, 1),   -- Pasta Dental Blanqueadora
    (1, '7790017000014', 149.28, 1),  -- Acondicionador Hidratante
    (1, '7790007000011', 82.95, 1),   -- Papel Higiénico Doble Hoja
    (1, '7790007000028', 96.30, 1),   -- Shampoo Anticaspa
    (1, '7790008000011', 75.00, 1),   -- Lavandina
    (1, '7790008000028', 172.50, 1),  -- Detergente para Ropa
    (1, '7790018000015', 98.61, 1),   -- Limpiador Multiuso
    (1, '7790018000016', 113.60, 1),  -- Suavizante para Ropa
    (1, '7790009000028', 70.80, 1),   -- Café Instantáneo
    (1, '7790009000035', 193.94, 1),  -- Yerba Mate
    (1, '7790009000059', 86.25, 1),   -- Galletas Sin Gluten
    (1, '7790009000066', 212.75, 1),  -- Cerveza Artesanal

    -- Sucursal 2: HiperLibertad - Cordoba
    (2, '7790001000011', 125.50, 1),  -- Leche Entera La Serenísima
    (2, '7790011000001', 215.90, 1),  -- Leche de Almendras Silk
    (2, '7790011000002', 230.50, 1),  -- Yogur Vegano
    (2, '7790002000011', 396.50, 1),  -- Bife de Res
    (2, '7790012000003', 223.43, 1),  -- Salchichas Viena
    (2, '7790012000004', 368.24, 1),  -- Costilla de Cerdo
    (2, '7790013000005', 292.14, 1),  -- Frutillas Congeladas
    (2, '7790013000006', 119.60, 1),  -- Zanahorias Baby
    (2, '7790003000011', 67.50, 1),   -- Manzanas Rojas
    (2, '7790003000028', 49.57, 1),   -- Tomates
    (2, '7790004000011', 125.40, 1),   -- Pan de Molde Blanco
    (2, '7790004000028', 139.50, 1),  -- Facturas Variadas
    (2, '7790014000007', 147.20, 1),  -- Baguette Artesanal
    (2, '7790014000008', 93.38, 1),   -- Galletas Digestivas
    (2, '7790005000011', 216.08, 1),  -- Gaseosa Regular Coca-Cola
    (2, '7790005000028', 90.65, 1),  -- Agua Mineral con Gas
    (2, '7790005000035', 345.30, 1),  -- Vino Tinto
    (2, '7790015000009', 40.43, 1),   -- Té Chai
    (2, '7790015000010', 313.50, 1),  -- Vino Rosado
    (2, '7790006000011', 83.60, 1),  -- Lentejas
    (2, '7790006000028', 92.00, 1),   -- Atún en Lata
    (2, '7790016000011', 119.00, 1),  -- Garbanzos
    (2, '7790016000012', 94.50, 1),  -- Porotos Rojos
    (2, '7790017000013', 69.75, 1),   -- Pasta Dental Blanqueadora
    (2, '7790017000014', 149.28, 1),  -- Acondicionador Hidratante
    (2, '7790007000011', 82.95, 1),  -- Papel Higiénico Doble Hoja
    (2, '7790007000028', 96.30, 1),   -- Shampoo Anticaspa
    (2, '7790008000011', 75.00, 1),   -- Lavandina
    (2, '7790008000028', 172.50, 1),  -- Detergente para Ropa
    (2, '7790018000015', 98.61, 1),   -- Limpiador Multiuso
    (2, '7790018000016', 113.60, 1),  -- Suavizante para Ropa
    (2, '7790009000028', 70.80, 1),   -- Café Instantáneo
    (2, '7790009000035', 193.94, 1),  -- Yerba Mate
    (2, '7790009000059', 86.25, 1),   -- Galletas Sin Gluten
    (2, '7790009000066', 212.75, 1),  -- Cerveza Artesanal

	    -- Sucursal 3: HiperLibertad - Rosario
    (3, '7790001000011', 125.50, 1),  -- Leche Entera La Serenísima
    (3, '7790011000001', 215.90, 1),  -- Leche de Almendras Silk
    (3, '7790011000002', 230.50, 1),  -- Yogur Vegano
    (3, '7790002000011', 396.50, 1),  -- Bife de Res
    (3, '7790012000003', 223.43, 1),  -- Salchichas Viena
    (3, '7790012000004', 368.24, 1),  -- Costilla de Cerdo
    (3, '7790013000005', 292.14, 1),  -- Frutillas Congeladas
    (3, '7790013000006', 119.60, 1),  -- Zanahorias Baby
    (3, '7790003000011', 67.50, 1),   -- Manzanas Rojas
    (3, '7790003000028', 49.57, 1),   -- Tomates
    (3, '7790004000011', 125.40, 1),   -- Pan de Molde Blanco
    (3, '7790004000028', 139.50, 1),  -- Facturas Variadas
    (3, '7790014000007', 147.20, 1),  -- Baguette Artesanal
    (3, '7790014000008', 93.38, 1),   -- Galletas Digestivas
    (3, '7790005000011', 216.08, 1),  -- Gaseosa Regular Coca-Cola
    (3, '7790005000028', 90.65, 1),  -- Agua Mineral con Gas
    (3, '7790005000035', 345.30, 1),  -- Vino Tinto
    (3, '7790015000009', 40.43, 1),   -- Té Chai
    (3, '7790015000010', 313.50, 1),  -- Vino Rosado
    (3, '7790006000011', 83.60, 1),  -- Lentejas
    (3, '7790006000028', 92.00, 1),   -- Atún en Lata
    (3, '7790016000011', 119.00, 1),  -- Garbanzos
    (3, '7790016000012', 94.50, 1),  -- Porotos Rojos
    (3, '7790017000013', 69.75, 1),   -- Pasta Dental Blanqueadora
    (3, '7790017000014', 149.28, 1),  -- Acondicionador Hidratante
    (3, '7790007000011', 82.95, 1),  -- Papel Higiénico Doble Hoja
    (3, '7790007000028', 96.30, 1),   -- Shampoo Anticaspa
    (3, '7790008000011', 75.00, 1),   -- Lavandina
    (3, '7790008000028', 172.50, 1),  -- Detergente para Ropa
    (3, '7790018000015', 98.61, 1),   -- Limpiador Multiuso
    (3, '7790018000016', 113.60, 1),  -- Suavizante para Ropa
    (3, '7790009000028', 70.80, 1),   -- Café Instantáneo
    (3, '7790009000035', 193.94, 1),  -- Yerba Mate
    (3, '7790009000059', 86.25, 1),   -- Galletas Sin Gluten
    (3, '7790009000066', 212.75, 1),  -- Cerveza Artesanal

    -- Sucursal 4: HiperLibertad - Salta
    (4, '7790001000011', 125.50, 1),  -- Leche Entera La Serenísima
    (4, '7790011000001', 215.90, 1),  -- Leche de Almendras Silk
    (4, '7790011000002', 230.50, 1),  -- Yogur Vegano
    (4, '7790002000011', 396.50, 1),  -- Bife de Res
    (4, '7790012000003', 223.43, 1),  -- Salchichas Viena
    (4, '7790012000004', 368.24, 1),  -- Costilla de Cerdo
    (4, '7790013000005', 292.14, 1),  -- Frutillas Congeladas
    (4, '7790013000006', 119.60, 1),  -- Zanahorias Baby
    (4, '7790003000011', 67.50, 1),   -- Manzanas Rojas
    (4, '7790003000028', 49.57, 1),   -- Tomates
    (4, '7790004000011', 125.40, 1),   -- Pan de Molde Blanco
    (4, '7790004000028', 139.50, 1),  -- Facturas Variadas
    (4, '7790014000007', 147.20, 1),  -- Baguette Artesanal
    (4, '7790014000008', 93.38, 1),   -- Galletas Digestivas
    (4, '7790005000011', 216.08, 1),  -- Gaseosa Regular Coca-Cola
    (4, '7790005000028', 90.65, 1),  -- Agua Mineral con Gas
    (4, '7790005000035', 345.30, 1),  -- Vino Tinto
    (4, '7790015000009', 40.43, 1),   -- Té Chai
    (4, '7790015000010', 313.50, 1),  -- Vino Rosado
    (4, '7790006000011', 83.60, 1),  -- Lentejas
    (4, '7790006000028', 92.00, 1),   -- Atún en Lata
    (4, '7790016000011', 119.00, 1),  -- Garbanzos
    (4, '7790016000012', 94.50, 1),  -- Porotos Rojos
    (4, '7790017000013', 69.75, 1),   -- Pasta Dental Blanqueadora
    (4, '7790017000014', 149.28, 1),  -- Acondicionador Hidratante
    (4, '7790007000011', 82.95, 1),  -- Papel Higiénico Doble Hoja
    (4, '7790007000028', 96.30, 1),   -- Shampoo Anticaspa
    (4, '7790008000011', 75.00, 1),   -- Lavandina
    (4, '7790008000028', 172.50, 1),  -- Detergente para Ropa
    (4, '7790018000015', 98.61, 1),   -- Limpiador Multiuso
    (4, '7790018000016', 113.60, 1),  -- Suavizante para Ropa
    (4, '7790009000028', 70.80, 1),   -- Café Instantáneo
    (4, '7790009000035', 193.94, 1),  -- Yerba Mate
    (4, '7790009000059', 86.25, 1),   -- Galletas Sin Gluten
    (4, '7790009000066', 212.75, 1);  -- Cerveza Artesanal
GO


------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------


--Info sucursales SP
CREATE OR ALTER PROCEDURE ObtenerInformacionSucursales
AS
BEGIN
    WITH array_horarios AS (
        SELECT 
            nro_sucursal = s.nro_sucursal,
            horarios = ' ' + hs.dia_semana + 
                        ' - ' + CONVERT(VARCHAR(5), hs.hora_desde, 108) + 
                        ' - ' + CONVERT(VARCHAR(5), hs.hora_hasta, 108)
        FROM dbo.horarios_sucursales hs (NOLOCK)
        JOIN dbo.sucursales s (NOLOCK)
            ON s.nro_sucursal = hs.nro_sucursal 
    )

    SELECT 
        s.nro_sucursal,
        s.nom_sucursal,
        s.calle,
        s.nro_calle,
        s.telefono,
        s.coord_latitud,
        s.coord_longitud,
        s.habilitada,
        l.nro_localidad,
        servicios = (
            SELECT STRING_AGG(tss.nom_tipo_servicio, ' - ')
            FROM dbo.tipos_servicios_supermercado tss 
            JOIN dbo.tipos_servicios_sucursales ts 
                ON tss.nro_tipo_servicio = ts.nro_tipo_servicio 
            WHERE ts.vigente = 1 
              AND ts.nro_sucursal = s.nro_sucursal
        ),
        horarios = STRING_AGG(h.horarios, ' ')
    FROM 
        dbo.sucursales s
    LEFT JOIN 
        dbo.localidades l ON s.nro_localidad = l.nro_localidad
     LEFT JOIN 
        array_horarios h ON h.nro_sucursal = s.nro_sucursal
    GROUP BY
        s.nro_sucursal,
        s.nom_sucursal,
        s.calle,
        s.nro_calle,
        s.telefono,
        s.coord_latitud,
        s.coord_longitud,
        s.habilitada,
        l.nro_localidad
		ORDER BY 
        s.nro_sucursal;
END;
GO

--EXEC ObtenerInformacionSucursales;

CREATE OR ALTER PROCEDURE dbo.ObtenerPreciosProductos
(
	@json			NVARCHAR(MAX)
)
AS
BEGIN

	CREATE TABLE #temp_productos 
	(
     cod_barra					varchar(40)
    )

    INSERT INTO #temp_productos (cod_barra)
    SELECT
        cod_barra			= JSON_VALUE(VALUE, '$.cod_barra')
    FROM OPENJSON(@json) AS VALUE
	
	SELECT p.nro_sucursal,
		   p.cod_barra,
		   p.precio 
	  FROM dbo.productos_sucursales p 
	       JOIN #temp_productos tp
		     ON p.cod_barra = tp.cod_barra
END
GO
/*
EXEC dbo.ObtenerPreciosProductos @json='[{
    "cod_barra": 7790001000011
  },
  {
    "cod_barra": 7790002000011
  }]'*/

