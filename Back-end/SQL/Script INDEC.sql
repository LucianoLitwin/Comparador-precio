DROP TABLE IF EXISTS dbo.productos_supermercados
DROP TABLE IF EXISTS dbo.servicios_supermercados
DROP TABLE IF EXISTS dbo.sucursales
DROP TABLE IF EXISTS dbo.supermercados
DROP TABLE IF EXISTS dbo.idiomas_tipos_productos
DROP TABLE IF EXISTS dbo.idiomas_rubros_productos
DROP TABLE IF EXISTS dbo.idiomas_categorias_productos
DROP TABLE IF EXISTS dbo.localidades
DROP TABLE IF EXISTS dbo.provincias
DROP TABLE IF EXISTS dbo.paises
DROP TABLE IF EXISTS dbo.idiomas
DROP TABLE IF EXISTS dbo.idiomas_productos
DROP TABLE IF EXISTS dbo.productos
DROP TABLE IF EXISTS dbo.marcas_productos
DROP TABLE IF EXISTS dbo.tipos_productos
DROP TABLE IF EXISTS dbo.categorias_productos
DROP TABLE IF EXISTS dbo.rubros_productos

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

-- Tabla idiomas
CREATE TABLE dbo.idiomas (
    cod_idioma VARCHAR(3) NOT NULL,
    nom_idioma VARCHAR(40) NOT NULL,
    CONSTRAINT PK_idiomas PRIMARY KEY (cod_idioma)
);
GO

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

-- Tabla supermercados
CREATE TABLE dbo.supermercados (
    nro_supermercado INT NOT NULL,
    razon_social VARCHAR(100) NOT NULL,
    cuit VARCHAR(20) NOT NULL,
	imagen VARCHAR(255),
    CONSTRAINT PK_supermercados PRIMARY KEY (nro_supermercado)
);
GO

-- Tabla idiomas_rubros_productos
CREATE TABLE dbo.idiomas_rubros_productos (
    nro_rubro INT NOT NULL,
    cod_idioma VARCHAR(3) NOT NULL,
    rubro VARCHAR(255) NOT NULL,
    CONSTRAINT PK_idiomas_rubros_productos PRIMARY KEY (nro_rubro, cod_idioma),
    CONSTRAINT FK_idiomas_rubros FOREIGN KEY (nro_rubro) 
        REFERENCES dbo.rubros_productos(nro_rubro),
    CONSTRAINT FK_rubros_idiomas FOREIGN KEY (cod_idioma) 
        REFERENCES dbo.idiomas(cod_idioma)
);
GO

-- Tabla idiomas_categorias_productos
CREATE TABLE dbo.idiomas_categorias_productos (
    nro_categoria INT NOT NULL,
    cod_idioma VARCHAR(3) NOT NULL,
    categoria VARCHAR(255) NOT NULL,
    CONSTRAINT PK_idiomas_categorias_productos PRIMARY KEY (nro_categoria, cod_idioma),
    CONSTRAINT FK_idiomas_categorias FOREIGN KEY (nro_categoria) 
        REFERENCES dbo.categorias_productos(nro_categoria),
    CONSTRAINT FK_categorias_idiomas FOREIGN KEY (cod_idioma) 
        REFERENCES dbo.idiomas(cod_idioma)
);
GO

-- Tabla idiomas_tipos_productos
CREATE TABLE dbo.idiomas_tipos_productos (
    nro_tipo_producto INT NOT NULL,
    cod_idioma VARCHAR(3) NOT NULL,
    tipo_producto VARCHAR(255) NOT NULL,
    CONSTRAINT PK_idiomas_tipos_productos PRIMARY KEY (nro_tipo_producto, cod_idioma),
    CONSTRAINT FK_idiomas_tipos FOREIGN KEY (nro_tipo_producto) 
        REFERENCES dbo.tipos_productos(nro_tipo_producto),
    CONSTRAINT FK_tipos_idiomas FOREIGN KEY (cod_idioma) 
        REFERENCES dbo.idiomas(cod_idioma)
);
GO

-- Tabla servicios_supermercados
CREATE TABLE dbo.servicios_supermercados (
    nro_supermercado INT NOT NULL,
    url_servicio VARCHAR(255) NOT NULL,
    tipo_servicio VARCHAR(255) NOT NULL,
    usuario VARCHAR(20) NOT NULL,
	clave VARCHAR(20) NOT NULL,
    fecha_ult_act_servicio SMALLDATETIME NOT NULL,
    CONSTRAINT PK_servicios_supermercados PRIMARY KEY (nro_supermercado),
    CONSTRAINT FK_servicios_supermercados FOREIGN KEY (nro_supermercado) 
        REFERENCES dbo.supermercados(nro_supermercado)
);
GO

-- Tabla sucursales
CREATE TABLE dbo.sucursales (
    nro_sucursal INT NOT NULL,
    nro_supermercado INT NOT NULL,
    nom_sucursal VARCHAR(100) NOT NULL,
    calle VARCHAR(100),
    nro_calle INT,
    telefono VARCHAR(20),
    coord_latitud DECIMAL(10, 7),
    coord_longitud DECIMAL(10, 7),
    horario_sucursal VARCHAR(MAX),
    servicios_disponibles VARCHAR(255), 
    nro_localidad INT NOT NULL,
    habilitada BIT,
    CONSTRAINT PK_sucursales PRIMARY KEY (nro_supermercado, nro_sucursal),
    CONSTRAINT FK_sucursales_localidades FOREIGN KEY (nro_localidad) 
        REFERENCES dbo.localidades(nro_localidad),
    CONSTRAINT FK_sucursales_supermercados FOREIGN KEY (nro_supermercado) 
        REFERENCES dbo.supermercados(nro_supermercado)
);
GO

-- Tabla productos_supermercados
CREATE TABLE dbo.productos_supermercados (
    nro_supermercado INT NOT NULL,
    nro_sucursal INT NOT NULL,
    cod_barra VARCHAR(40) NOT NULL,
    precio DECIMAL(10, 2),
	precio_anterior DECIMAL(10, 2),
	variacion DECIMAL(10, 2),
    fecha_ult_actualizacion SMALLDATETIME,
    CONSTRAINT PK_productos_supermercados PRIMARY KEY (nro_supermercado, nro_sucursal, cod_barra),
    CONSTRAINT FK_productos_supermercados_sucursales FOREIGN KEY (nro_supermercado, nro_sucursal) 
        REFERENCES dbo.sucursales(nro_supermercado, nro_sucursal),
    CONSTRAINT FK_productos_supermercados_productos FOREIGN KEY (cod_barra) 
        REFERENCES dbo.productos(cod_barra)
);
GO

-- Tabla idiomas_productos
CREATE TABLE dbo.idiomas_productos (
	cod_idioma VARCHAR(3) NOT NULL,
    cod_barra VARCHAR(40) NOT NULL,
    nom_producto VARCHAR(100) NOT NULL
    CONSTRAINT PK_idiomas_productos PRIMARY KEY (cod_idioma, cod_barra),
    CONSTRAINT FK_idiomas_productos FOREIGN KEY (cod_barra) 
        REFERENCES dbo.productos(cod_barra)
);
GO


------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------


-- Insertar en idiomas
INSERT INTO dbo.idiomas (cod_idioma, nom_idioma)
VALUES 
    ('ES', 'ESPAÑOL'),
    ('EN', 'INGLÉS');
GO

-- Insertar en paises (5 países de LATAM)
INSERT INTO dbo.paises (cod_pais, nom_pais, local)
VALUES 
    ('ARG', 'Argentina', 1);
GO

-- Insertar en provincias (5 provincias de Argentina)
INSERT INTO dbo.provincias (cod_pais, cod_provincia, nom_provincia)
VALUES 
    ('ARG', 1, 'Buenos Aires'),
    ('ARG', 2, 'Cordoba'),
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

    -- Localidades de C rdoba
    (3, 'Cordoba Capital', 'ARG', 2),
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

-- Insertar en supermercados (DISCO e HiperLibertad)
INSERT INTO dbo.supermercados (nro_supermercado, razon_social, cuit, imagen)
VALUES 
    (1, 'Disco', '20304567890', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Disco-Supermarket-Logo.svg/2048px-Disco-Supermarket-Logo.svg.png'),
    (2, 'HiperLibertad', '201111111110', 'https://www.clublibertad.com.ar/assets/images/ico-beneficios/Logo-Libertad-.png'),
    (3, 'Mami', '32412411552', 'https://www.supermami.com.ar/super/images/logo-super-mami.png'),
    (4, 'DinosaurioMall', '44444444444', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmDLoBZ8HbNX8b7geqtGmXQyn8Cw42JDLnNA&s');
GO


-- Insertar en servicios_supermercados
INSERT INTO dbo.servicios_supermercados (nro_supermercado, url_servicio, tipo_servicio, usuario, clave, fecha_ult_act_servicio)
VALUES 
    (1, 'http://localhost:8085/api/v1/super/', 'REST', 'usr_admin', 'pwd_admin', GETDATE()),
    (2, 'http://localhost:8080/services/SuperSoapWS.wsdl', 'SOAP', 'usr_admin', 'pwd_admin', GETDATE()),
	(3, 'http://localhost:8086/api/v1/super/', 'REST', 'usr_admin', 'pwd_admin', GETDATE()),
    (4, 'http://localhost:8087/services/SuperSoapWS.wsdl', 'SOAP', 'usr_admin', 'pwd_admin', GETDATE());
GO

-- Insertar en rubros_productos (Ampliado para cubrir la canasta básica)
INSERT INTO dbo.rubros_productos (nro_rubro, nom_rubro, vigente)
VALUES 
    (1, 'Lacteos', 1),
    (2, 'Carnes', 1),
    (3, 'Frutas y Verduras', 1),
    (4, 'Panaderia', 1),
    (5, 'Bebidas', 1),
    (6, 'Legumbres y Conservas', 1),
    (7, 'Cuidado Personal', 1),
    (8, 'Limpieza Hogar', 1);
GO

-- Insertar en idiomas_rubros_productos (Rubros en Español e Inglés)
INSERT INTO dbo.idiomas_rubros_productos (nro_rubro, cod_idioma, rubro)
VALUES 
    (1, 'ES', 'Lacteos'),          (1, 'EN', 'Dairy Products'),
    (2, 'ES', 'Carnes'),           (2, 'EN', 'Meat'),
    (3, 'ES', 'Frutas y Verduras'),           (3, 'EN', 'Fruits & Vegetables'),
    (4, 'ES', 'Panaderia'),         (4, 'EN', 'Bakery'),
    (5, 'ES', 'Bebidas'),          (5, 'EN', 'Beverages'),
    (6, 'ES', 'Legumbres y Conservas'),        (6, 'EN', 'Legumes and Preserves'),
    (7, 'ES', 'Cuidado Personal'),        (7, 'EN', 'Personal Care'),
    (8, 'ES', 'Limpieza Hogar'), (8, 'EN', 'Home Cleaning');
GO

-- Insertar en categorias_productos (Categorías según los rubros)
INSERT INTO dbo.categorias_productos (nro_categoria, nom_categoria, nro_rubro, vigente)
VALUES 
    -- Lacteos
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
    -- Panaderia
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

-- Insertar en idiomas_categorias_productos (Categorías en Español e Inglés)
INSERT INTO dbo.idiomas_categorias_productos (nro_categoria, cod_idioma, categoria)
VALUES 
    -- Lácteos (Rubro 1)
    (1, 'ES', 'Leches'),          (1, 'EN', 'Milk'),
    (2, 'ES', 'Yogures'),         (2, 'EN', 'Yogurt'),
    (3, 'ES', 'Quesos'),          (3, 'EN', 'Cheese'),

    -- Carnes (Rubro 2)
    (4, 'ES', 'Res'),             (4, 'EN', 'Beef'),
    (5, 'ES', 'Pollo'),           (5, 'EN', 'Chicken'),
    (6, 'ES', 'Cerdo'),           (6, 'EN', 'Pork'),

    -- Frutas y Verduras (Rubro 3)
    (7, 'ES', 'Frutas Frescas'),  (7, 'EN', 'Fresh Fruits'),
    (8, 'ES', 'Verduras Frescas'),(8, 'EN', 'Fresh Vegetables'),

    -- Panadería (Rubro 4)
    (9, 'ES', 'Panes'),           (9, 'EN', 'Bread'),
    (10, 'ES', 'Facturas'),       (10, 'EN', 'Pastries'),

    -- Bebidas (Rubro 5)
    (11, 'ES', 'Gaseosas'),       (11, 'EN', 'Soft Drinks'),
    (12, 'ES', 'Aguas'),          (12, 'EN', 'Water'),
    (13, 'ES', 'Jugos'),          (13, 'EN', 'Juices'),
    (14, 'ES', 'Alcohol'),        (14, 'EN', 'Alcohol'),

    -- Legumbres y Conservas (Rubro 6)
    (15, 'ES', 'Legumbres'),      (15, 'EN', 'Legumes'),
    (16, 'ES', 'Conservas'),      (16, 'EN', 'Canned Goods'),

    -- Cuidado Personal (Rubro 7)
    (17, 'ES', 'Higiene Personal'), (17, 'EN', 'Personal Hygiene'),
    (18, 'ES', 'Cuidado Bucal'),    (18, 'EN', 'Oral Care'),

    -- Limpieza Hogar (Rubro 8)
    (19, 'ES', 'Limpieza General'), (19, 'EN', 'General Cleaning'),
    (20, 'ES', 'Lavado de Ropa'),   (20, 'EN', 'Laundry');
GO


-- Insertar datos en la tabla tipos_productos con nro_categoria añadido
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

-- Insertar en idiomas_tipos_productos (Tipos de productos en Español e Inglés)
INSERT INTO dbo.idiomas_tipos_productos (nro_tipo_producto, cod_idioma, tipo_producto)
VALUES
    -- Lácteos
    (1, 'ES', 'Leche Entera'),      (1, 'EN', 'Whole Milk'),
    (2, 'ES', 'Leche Descremada'),  (2, 'EN', 'Skim Milk'),
    (3, 'ES', 'Leche Sin Lactosa'), (3, 'EN', 'Lactose-Free Milk'),
    (4, 'ES', 'Yogur Natural'),     (4, 'EN', 'Plain Yogurt'),
    (5, 'ES', 'Yogur con Frutas'),  (5, 'EN', 'Fruit Yogurt'),
    (6, 'ES', 'Queso Cremoso'),     (6, 'EN', 'Cream Cheese'),
    (7, 'ES', 'Queso Rallado'),     (7, 'EN', 'Grated Cheese'),
    (8, 'ES', 'Manteca'),           (8, 'EN', 'Butter'),
    (9, 'ES', 'Crema de Leche'),    (9, 'EN', 'Heavy Cream'),
     -- Carnes
    (10, 'ES', 'Bife de Res'),         (10, 'EN', 'Beef Steak'),
    (11, 'ES', 'Pollo Entero'),        (11, 'EN', 'Whole Chicken'),
    (12, 'ES', 'Chuletas de Cerdo'),   (12, 'EN', 'Pork Chops'),
    (13, 'ES', 'Hamburguesas'),        (13, 'EN', 'Burgers'),
    (14, 'ES', 'Chorizos'),            (14, 'EN', 'Chorizo Sausage'),
    (15, 'ES', 'Jamón Cocido'),        (15, 'EN', 'Cooked Ham'),
    (16, 'ES', 'Jamón Crudo'),         (16, 'EN', 'Cured Ham'),
    -- Frutas y Verduras
    (17, 'ES', 'Manzanas'),            (17, 'EN', 'Apples'),
    (18, 'ES', 'Naranjas'),            (18, 'EN', 'Oranges'),
    (19, 'ES', 'Bananas'),             (19, 'EN', 'Bananas'),
    (20, 'ES', 'Tomates'),             (20, 'EN', 'Tomatoes'),
    (21, 'ES', 'Papas'),               (21, 'EN', 'Potatoes'),
    (22, 'ES', 'Zanahorias'),          (22, 'EN', 'Carrots'),
    (23, 'ES', 'Cebollas'),            (23, 'EN', 'Onions'),
    (24, 'ES', 'Lechuga'),             (24, 'EN', 'Lettuce'),
    -- Panadería
    (25, 'ES', 'Pan de Molde Blanco'), (25, 'EN', 'White Bread Loaf'),
    (26, 'ES', 'Pan Integral'),        (26, 'EN', 'Whole Wheat Bread'),
    (27, 'ES', 'Facturas'),            (27, 'EN', 'Pastries'),
    (28, 'ES', 'Galletas Dulces'),     (28, 'EN', 'Sweet Cookies'),
    (29, 'ES', 'Galletas Saladas'),    (29, 'EN', 'Salted Crackers'),
     -- Bebidas
    (30, 'ES', 'Gaseosa Regular'),        (30, 'EN', 'Regular Soda'),
    (31, 'ES', 'Gaseosa Light'),          (31, 'EN', 'Diet Soda'),
    (32, 'ES', 'Agua Mineral con Gas'),   (32, 'EN', 'Sparkling Water'),
    (33, 'ES', 'Agua Mineral sin Gas'),   (33, 'EN', 'Still Water'),
    (34, 'ES', 'Jugo de Naranja'),        (34, 'EN', 'Orange Juice'),
    (35, 'ES', 'Jugo de Manzana'),        (35, 'EN', 'Apple Juice'),
    (36, 'ES', 'Cerveza Rubia'),          (36, 'EN', 'Light Beer'),
    (37, 'ES', 'Vino Tinto'),             (37, 'EN', 'Red Wine'),

    -- Legumbres y Conservas
    (38, 'ES', 'Lentejas'),               (38, 'EN', 'Lentils'),
    (39, 'ES', 'Arvejas'),                (39, 'EN', 'Peas'),
    (40, 'ES', 'Porotos Negros'),         (40, 'EN', 'Black Beans'),
    (41, 'ES', 'Porotos Blancos'),        (41, 'EN', 'White Beans'),
    (42, 'ES', 'Puré de Tomate'),         (42, 'EN', 'Tomato Puree'),
    (43, 'ES', 'Atún en Lata'),           (43, 'EN', 'Canned Tuna'),
    (44, 'ES', 'Mermelada de Durazno'),   (44, 'EN', 'Peach Jam'),

    -- Cuidado Personal
    (45, 'ES', 'Papel Higiénico Doble Hoja'), (45, 'EN', 'Double-Ply Toilet Paper'),
    (46, 'ES', 'Jabón de Tocador'),       (46, 'EN', 'Bar Soap'),
    (47, 'ES', 'Shampoo'),                (47, 'EN', 'Shampoo'),
    (48, 'ES', 'Acondicionador'),         (48, 'EN', 'Conditioner'),
    (49, 'ES', 'Pasta Dental'),           (49, 'EN', 'Toothpaste'),

    -- Limpieza Hogar
    (50, 'ES', 'Lavandina'),              (50, 'EN', 'Bleach'),
    (51, 'ES', 'Detergente'),             (51, 'EN', 'Dish Soap'),
    (52, 'ES', 'Limpiador Multiuso'),     (52, 'EN', 'All-Purpose Cleaner'),
    (53, 'ES', 'Desinfectante'),          (53, 'EN', 'Disinfectant'),
    (54, 'ES', 'Jabón en Polvo'),         (54, 'EN', 'Powdered Soap'),

	 -- Mas variedades
	(55, 'ES', 'Queso Azul'),            (55, 'EN', 'Blue Cheese'),
    (56, 'ES', 'Salsa Ketchup'),         (56, 'EN', 'Ketchup'),
    (57, 'ES', 'Mayonesa'),              (57, 'EN', 'Mayonnaise'),
    (58, 'ES', 'Té Verde'),              (58, 'EN', 'Green Tea'),
    (59, 'ES', 'Café Instantáneo'),      (59, 'EN', 'Instant Coffee'),
    (60, 'ES', 'Yerba Mate'),            (60, 'EN', 'Yerba Mate'),
    (61, 'ES', 'Galletas de Arroz'),     (61, 'EN', 'Rice Cakes'),
    (62, 'ES', 'Chocolate para Taza'),   (62, 'EN', 'Hot Chocolate'),
    (63, 'ES', 'Cerveza Negra'),         (63, 'EN', 'Dark Beer'),
    (64, 'ES', 'Vino Blanco'),           (64, 'EN', 'White Wine'),
    (65, 'ES', 'Azúcar Rubia'),          (65, 'EN', 'Brown Sugar'),
    (66, 'ES', 'Sal Fina'),              (66, 'EN', 'Table Salt'),
    (67, 'ES', 'Vinagre de Manzana'),    (67, 'EN', 'Apple Cider Vinegar'),
    (68, 'ES', 'Aceite de Girasol'),     (68, 'EN', 'Sunflower Oil'),
    (69, 'ES', 'Aceite de Oliva'),       (69, 'EN', 'Olive Oil'),

    -- Nuevos tipos para diversidad
    (70, 'ES', 'Galletas Sin Gluten'),    (70, 'EN', 'Gluten-Free Cookies'),
    (71, 'ES', 'Leche de Almendras'),     (71, 'EN', 'Almond Milk'),
    (72, 'ES', 'Yogur Vegano'),           (72, 'EN', 'Vegan Yogurt'),
    (73, 'ES', 'Tofu'),                   (73, 'EN', 'Tofu'),
    (74, 'ES', 'Proteína en Polvo'),      (74, 'EN', 'Protein Powder'),
    (75, 'ES', 'Snacks Saludables'),      (75, 'EN', 'Healthy Snacks'),
    (76, 'ES', 'Agua Saborizada'),        (76, 'EN', 'Flavored Water'),
    (77, 'ES', 'Cerveza Artesanal'),      (77, 'EN', 'Craft Beer'),
    (78, 'ES', 'Detergente para Ropa'),   (78, 'EN', 'Laundry Detergent'),
    (79, 'ES', 'Suavizante para Ropa'),   (79, 'EN', 'Fabric Softener'),
    (80, 'ES', 'Shampoo Anticaspa'),      (80, 'EN', 'Anti-Dandruff Shampoo'),
    (81, 'ES', 'Papel Higiénico Reciclado'), (81, 'EN', 'Recycled Toilet Paper'),
    (82, 'ES', 'Vinagre Blanco'),         (82, 'EN', 'White Vinegar'),
    (83, 'ES', 'Sal Marina'),             (83, 'EN', 'Sea Salt'),
    (84, 'ES', 'Frutillas Congeladas'),   (84, 'EN', 'Frozen Strawberries'),
    (85, 'ES', 'Café Molido Gourmet'),    (85, 'EN', 'Gourmet Ground Coffee'),
    (86, 'ES', 'Té Chai'),                (86, 'EN', 'Chai Tea'),
    (87, 'ES', 'Azúcar Mascabo'),         (87, 'EN', 'Raw Sugar'),
    (88, 'ES', 'Aceite de Coco'),         (88, 'EN', 'Coconut Oil'),
    (89, 'ES', 'Hamburguesa Vegana'),     (89, 'EN', 'Vegan Burger'),
    (90, 'ES', 'Leche de Avena'),         (90, 'EN', 'Oat Milk'),
    (91, 'ES', 'Barras de Cereal'),       (91, 'EN', 'Cereal Bars'),
    (92, 'ES', 'Galletas Digestivas'),    (92, 'EN', 'Digestive Biscuits'),
    (93, 'ES', 'Té de Hierbas'),          (93, 'EN', 'Herbal Tea'),
    (94, 'ES', 'Mermelada Light'),        (94, 'EN', 'Light Jam'),
    (95, 'ES', 'Atún en Agua'),           (95, 'EN', 'Tuna in Water'),
    (96, 'ES', 'Porotos Rojos'),          (96, 'EN', 'Red Beans'),
    (97, 'ES', 'Carne de Pescado'),       (97, 'EN', 'Fish Meat'),
    (98, 'ES', 'Harina Integral'),         (98, 'EN', 'Whole wheat flour'),
    (99, 'ES', 'Avena Instantánea'),      (99, 'EN', 'Instant Oats'),
    (100, 'ES', 'Snack de Frutas Deshidratadas'), (100, 'EN', 'Dried Fruit Snacks');
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

-- Insertar productos en la tabla idiomas_productos
INSERT INTO dbo.idiomas_productos (cod_idioma, cod_barra, nom_producto)
VALUES
    -- Lacteos
    ('ES', '7790001000011', 'Leche Entera La Serenisima'),
    ('EN', '7790001000011', 'La Serenisima Whole Milk'),
    ('ES', '7790011000001', 'Leche de Almendras Silk'),
    ('EN', '7790011000001', 'Silk Almond Milk'),
    ('ES', '7790011000002', 'Yogur Vegano'),
    ('EN', '7790011000002', 'Vegan Yogurt'),
    -- Carnes
    ('ES', '7790002000011', 'Bife de Res'),
    ('EN', '7790002000011', 'Beef Steak'),
    ('ES', '7790012000003', 'Salchichas Viena'),
    ('EN', '7790012000003', 'Vienna Sausages'),
    ('ES', '7790012000004', 'Costilla de Cerdo'),
    ('EN', '7790012000004', 'Pork Ribs'),
    -- Frutas y Verduras
    ('ES', '7790013000005', 'Frutillas Congeladas'),
    ('EN', '7790013000005', 'Frozen Strawberries'),
    ('ES', '7790013000006', 'Zanahorias Baby'),
    ('EN', '7790013000006', 'Baby Carrots'),
    ('ES', '7790003000011', 'Manzanas Rojas'),
    ('EN', '7790003000011', 'Red Apples'),
    ('ES', '7790003000028', 'Tomates'),
    ('EN', '7790003000028', 'Tomatoes'),
    -- Panaderia
    ('ES', '7790004000011', 'Pan de Molde Blanco'),
    ('EN', '7790004000011', 'White Sandwich Bread'),
    ('ES', '7790004000028', 'Facturas Variadas'),
    ('EN', '7790004000028', 'Assorted Pastries'),
    ('ES', '7790014000007', 'Baguette Artesanal'),
    ('EN', '7790014000007', 'Artisan Baguette'),
    ('ES', '7790014000008', 'Galletas Digestivas'),
    ('EN', '7790014000008', 'Digestive Cookies'),
    -- Bebidas
    ('ES', '7790005000011', 'Gaseosa Regular Coca-Cola'),
    ('EN', '7790005000011', 'Coca-Cola Regular Soda'),
    ('ES', '7790005000028', 'Agua Mineral con Gas'),
    ('EN', '7790005000028', 'Sparkling Mineral Water'),
    ('ES', '7790005000035', 'Vino Tinto'),
    ('EN', '7790005000035', 'Red Wine'),
    ('ES', '7790015000009', 'Te Chai'),
    ('EN', '7790015000009', 'Chai Tea'),
    ('ES', '7790015000010', 'Vino Rosado'),
    ('EN', '7790015000010', 'Rosé Wine'),
    -- Legumbres y Conservas
    ('ES', '7790006000011', 'Lentejas'),
    ('EN', '7790006000011', 'Lentils'),
    ('ES', '7790006000028', 'Atun en Lata'),
    ('EN', '7790006000028', 'Canned Tuna'),
    ('ES', '7790016000011', 'Garbanzos'),
    ('EN', '7790016000011', 'Chickpeas'),
    ('ES', '7790016000012', 'Porotos Rojos'),
    ('EN', '7790016000012', 'Red Beans'),
    -- Otros
    ('ES', '7790019000026', 'Mayonesa Light'),
    ('EN', '7790019000026', 'Light Mayonnaise'),
    ('ES', '7790019000027', 'Salsa Ketchup'),
    ('EN', '7790019000027', 'Ketchup Sauce'),
	('ES', '7790017000013', 'Pasta Dental Blanqueadora'),
    ('EN', '7790017000013', 'Whitening Toothpaste'),
    ('ES', '7790017000014', 'Acondicionador Hidratante'),
    ('EN', '7790017000014', 'Moisturizing Conditioner'),
    ('ES', '7790007000011', 'Papel Higienico Doble Hoja'),
    ('EN', '7790007000011', 'Double-Ply Toilet Paper'),
    ('ES', '7790007000028', 'Shampoo Anticaspa'),
    ('EN', '7790007000028', 'Anti-Dandruff Shampoo'),
    -- Limpieza Hogar
    ('ES', '7790008000011', 'Lavandina'),
    ('EN', '7790008000011', 'Bleach'),
    ('ES', '7790008000028', 'Detergente para Ropa'),
    ('EN', '7790008000028', 'Laundry Detergent'),
    ('ES', '7790018000015', 'Limpiador Multiuso'),
    ('EN', '7790018000015', 'Multipurpose Cleaner'),
    ('ES', '7790018000016', 'Suavizante para Ropa'),
    ('EN', '7790018000016', 'Fabric Softener'),
    -- Más productos variados
    ('ES', '7790009000028', 'Cafe Instantaneo'),
    ('EN', '7790009000028', 'Instant Coffee'),
    ('ES', '7790009000035', 'Yerba Mate'),
    ('EN', '7790009000035', 'Yerba Mate Tea'),
    ('ES', '7790009000059', 'Galletas Sin Gluten'),
    ('EN', '7790009000059', 'Gluten-Free Cookies'),
    ('ES', '7790009000066', 'Cerveza Artesanal'),
    ('EN', '7790009000066', 'Craft Beer'),
    ('ES', '7790009000073', 'Snack de Frutas Deshidratadas'),
    ('EN', '7790009000073', 'Dried Fruit Snack'),
    ('ES', '7790009000080', 'Aceite de Oliva'),
    ('EN', '7790009000080', 'Olive Oil'),
    ('ES', '7790009000087', 'Avena Instantanea'),
    ('EN', '7790009000087', 'Instant Oatmeal'),
    ('ES', '7790019000018', 'Chocolate Amargo'),
    ('EN', '7790019000018', 'Dark Chocolate'),
    ('ES', '7790019000019', 'Harina Integral'),
    ('EN', '7790019000019', 'Whole Wheat Flour'),
    ('ES', '7790019000020', 'Barras de Cereal'),
    ('EN', '7790019000020', 'Cereal Bars'),
    ('ES', '7790019000022', 'Azucar Mascabo'),
    ('EN', '7790019000022', 'Unrefined Sugar'),
    ('ES', '7790019000023', 'Cafe Molido Gourmet'),
    ('EN', '7790019000023', 'Gourmet Ground Coffee');
GO



------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------


CREATE OR ALTER PROCEDURE dbo.get_provincias
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        cod_pais,
        cod_provincia, 
        nom_provincia 
    FROM 
        dbo.provincias;
END;
GO

CREATE OR ALTER PROCEDURE dbo.get_localidades
    @cod_provincia INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        nro_localidad,
        nom_localidad,
        cod_pais,
        cod_provincia
    FROM 
        dbo.localidades
    WHERE 
        cod_provincia = @cod_provincia;
END;
GO

CREATE OR ALTER PROCEDURE dbo.get_sucursales
    @nro_localidad INT,
    @supermercado NVARCHAR(100) = NULL -- Nuevo parámetro para filtrar por nombre de supermercado
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        sm.imagen,
        sm.razon_social,
        s.nro_sucursal,
        s.nom_sucursal,
        s.calle,
        s.nro_calle,
        s.telefono,
        s.coord_latitud,
        s.coord_longitud,
        s.horario_sucursal,
        s.servicios_disponibles,
        l.nom_localidad,
        p.nom_provincia
    FROM 
        dbo.sucursales AS s
    INNER JOIN 
        dbo.supermercados AS sm ON s.nro_supermercado = sm.nro_supermercado
    INNER JOIN 
        dbo.localidades AS l ON s.nro_localidad = l.nro_localidad
    INNER JOIN 
        dbo.provincias AS p ON l.cod_pais = p.cod_pais AND l.cod_provincia = p.cod_provincia
    WHERE 
        s.nro_localidad = @nro_localidad
        AND s.habilitada = 1
        AND (@supermercado IS NULL OR sm.razon_social LIKE '%' + @supermercado + '%'); -- Filtro por supermercado
END;
GO



EXEC dbo.get_sucursales @nro_localidad = 1, @supermercado = 'Di';
GO



CREATE OR ALTER PROCEDURE dbo.get_productos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        cod_barra
    FROM 
        dbo.productos
    WHERE 
        vigente = 1;
END;
GO

--exec dbo.get_productos


CREATE OR ALTER PROCEDURE dbo.get_rubros
    @cod_idioma VARCHAR(3)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        rp.nro_rubro,
        COALESCE(irp.rubro, rp.nom_rubro) AS rubro
    FROM 
        dbo.rubros_productos rp
    LEFT JOIN 
        dbo.idiomas_rubros_productos irp ON rp.nro_rubro = irp.nro_rubro 
        AND irp.cod_idioma = @cod_idioma
    WHERE 
        rp.vigente = 1;
END;
GO


CREATE OR ALTER PROCEDURE dbo.get_categorias
    @cod_idioma VARCHAR(3),
    @json NVARCHAR(MAX) -- Parámetro JSON
AS
BEGIN
    SET NOCOUNT ON;

    -- Crear una tabla temporal para extraer los valores del JSON
    CREATE TABLE #Rubros (nro_rubro INT);

    -- Insertar valores desde el JSON a la tabla temporal
    INSERT INTO #Rubros (nro_rubro)
    SELECT CAST(JSON_VALUE(value, '$.nro_rubro') AS INT)
    FROM OPENJSON(@json);

    -- Seleccionar las categorías filtrando por los valores en la tabla temporal
    SELECT 
        cp.nro_categoria,
        cp.nro_rubro,
        COALESCE(icp.categoria, cp.nom_categoria) AS categoria
    FROM 
        dbo.categorias_productos cp
    LEFT JOIN 
        dbo.idiomas_categorias_productos icp 
        ON cp.nro_categoria = icp.nro_categoria 
        AND icp.cod_idioma = @cod_idioma
    WHERE 
        cp.vigente = 1
        AND cp.nro_rubro IN (SELECT nro_rubro FROM #Rubros);

    -- Eliminar la tabla temporal
    DROP TABLE #Rubros;
END;
GO

/*
EXEC dbo.get_categorias @cod_idioma = 'ES', @json = '[
    { "nro_rubro": 1 },
    { "nro_rubro": 2 },
    { "nro_rubro": 3 }
]'
*/

CREATE OR ALTER PROCEDURE dbo.get_tipos_productos
    @cod_idioma VARCHAR(3),
    @json NVARCHAR(MAX) -- Parámetro JSON con IDs de categorías
AS
BEGIN
    SET NOCOUNT ON;

    -- Crear una tabla temporal para extraer los valores del JSON
    CREATE TABLE #Categorias (nro_categoria INT);

    -- Insertar valores desde el JSON a la tabla temporal
    INSERT INTO #Categorias (nro_categoria)
    SELECT CAST(JSON_VALUE(value, '$.nro_categoria') AS INT)
    FROM OPENJSON(@json);

    -- Seleccionar los tipos de productos filtrando por los valores en la tabla temporal
    SELECT 
        tp.nro_tipo_producto,
        tp.nro_categoria,
        COALESCE(itp.tipo_producto, tp.nom_tipo_producto) AS tipo_producto
    FROM 
        dbo.tipos_productos tp
    LEFT JOIN 
        dbo.idiomas_tipos_productos itp 
        ON tp.nro_tipo_producto = itp.nro_tipo_producto 
        AND itp.cod_idioma = @cod_idioma
    WHERE 
        tp.nro_categoria IN (SELECT nro_categoria FROM #Categorias);

    -- Eliminar la tabla temporal
    DROP TABLE #Categorias;
END;
GO

 
CREATE OR ALTER PROCEDURE dbo.get_marcas_productos
    @json NVARCHAR(MAX) -- Parámetro JSON con IDs de tipos de productos
AS
BEGIN
    SET NOCOUNT ON;

    -- Crear una tabla temporal para extraer los valores del JSON
    CREATE TABLE #TiposProductos (nro_tipo_producto INT);

    -- Insertar valores desde el JSON a la tabla temporal
    INSERT INTO #TiposProductos (nro_tipo_producto)
    SELECT CAST(JSON_VALUE(value, '$.nro_tipo_producto') AS INT)
    FROM OPENJSON(@json);

    -- Seleccionar las marcas filtrando por los tipos de productos en la tabla temporal
    SELECT DISTINCT
        mp.nro_marca,
        mp.nom_marca
    FROM 
        dbo.marcas_productos mp
    WHERE 
        mp.nro_tipo_producto IN (SELECT nro_tipo_producto FROM #TiposProductos)
        AND mp.vigente = 1;

    -- Eliminar la tabla temporal
    DROP TABLE #TiposProductos;
END;
GO


/*
EXEC dbo.get_marcas_productos @json = '[
    { "nro_tipo_producto": 1 },
    { "nro_tipo_producto": 2 },
    { "nro_tipo_producto": 3 }
]'
*/

--GET PRODUCTOS

CREATE OR ALTER PROCEDURE dbo.get_productos_filtrados 
    @cod_idioma VARCHAR(3),
    @json_rubros NVARCHAR(MAX) = NULL,        -- JSON con los IDs de rubros
    @json_categorias NVARCHAR(MAX) = NULL,    -- JSON con los IDs de categorías
    @json_tipos NVARCHAR(MAX) = NULL,         -- JSON con los IDs de tipos de producto
    @json_marcas NVARCHAR(MAX) = NULL,        -- JSON con los IDs de marcas
    @page_number INT,                         -- Número de página solicitado
    @page_size INT,                           -- Tamaño de página 
    @barra_busqueda VARCHAR(50) = NULL        -- Parámetro para la barra de búsqueda
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @offset INT = (@page_number - 1) * @page_size;

    -- Tablas temporales para almacenar los valores extraídos del JSON
    CREATE TABLE #Rubros (nro_rubro INT);
    CREATE TABLE #Categorias (nro_categoria INT);
    CREATE TABLE #Tipos (nro_tipo_producto INT);
    CREATE TABLE #Marcas (nro_marca INT);

    -- Insertar los valores desde el JSON a las tablas temporales
    IF (@json_rubros IS NOT NULL)
    BEGIN
        INSERT INTO #Rubros (nro_rubro)
        SELECT CAST(JSON_VALUE(value, '$.nro_rubro') AS INT)
        FROM OPENJSON(@json_rubros);
    END

    IF (@json_categorias IS NOT NULL)
    BEGIN
        INSERT INTO #Categorias (nro_categoria)
        SELECT CAST(JSON_VALUE(value, '$.nro_categoria') AS INT)
        FROM OPENJSON(@json_categorias);
    END

    IF (@json_tipos IS NOT NULL)
    BEGIN
        INSERT INTO #Tipos (nro_tipo_producto)
        SELECT CAST(JSON_VALUE(value, '$.nro_tipo_producto') AS INT)
        FROM OPENJSON(@json_tipos);
    END

    IF (@json_marcas IS NOT NULL)
    BEGIN
        INSERT INTO #Marcas (nro_marca)
        SELECT CAST(JSON_VALUE(value, '$.nro_marca') AS INT)
        FROM OPENJSON(@json_marcas);
    END

    -- Consulta para contar el total de productos que cumplen con los filtros
    DECLARE @total_count INT;
    SELECT @total_count = COUNT(*)
    FROM 
        dbo.productos AS p
    INNER JOIN dbo.categorias_productos AS c ON p.nro_categoria = c.nro_categoria
    INNER JOIN dbo.idiomas_categorias_productos AS ic ON c.nro_categoria = ic.nro_categoria
    INNER JOIN dbo.rubros_productos AS r ON c.nro_rubro = r.nro_rubro
    INNER JOIN dbo.marcas_productos AS m ON p.nro_marca = m.nro_marca AND p.nro_tipo_producto = m.nro_tipo_producto
    INNER JOIN dbo.idiomas_productos AS idp ON p.cod_barra = idp.cod_barra AND idp.cod_idioma = @cod_idioma
    WHERE 
        p.vigente = 1
        AND c.vigente = 1
        AND m.vigente = 1
        AND ic.cod_idioma = @cod_idioma
        AND (@json_rubros IS NULL OR r.nro_rubro IN (SELECT nro_rubro FROM #Rubros))
        AND (@json_categorias IS NULL OR c.nro_categoria IN (SELECT nro_categoria FROM #Categorias))
        AND (@json_tipos IS NULL OR m.nro_tipo_producto IN (SELECT nro_tipo_producto FROM #Tipos))
        AND (@json_marcas IS NULL OR m.nro_marca IN (SELECT nro_marca FROM #Marcas))
        AND (@barra_busqueda IS NULL OR idp.nom_producto LIKE '%' + @barra_busqueda + '%');

    -- Devuelve los productos paginados con la URL de la imagen y el nombre traducido
    SELECT 
        p.cod_barra,
        COALESCE(idp.nom_producto, p.nom_producto) AS nom_producto,
        p.imagen
    FROM 
        dbo.productos AS p
    INNER JOIN dbo.categorias_productos AS c ON p.nro_categoria = c.nro_categoria
    INNER JOIN dbo.idiomas_categorias_productos AS ic ON c.nro_categoria = ic.nro_categoria
    INNER JOIN dbo.rubros_productos AS r ON c.nro_rubro = r.nro_rubro
    INNER JOIN dbo.marcas_productos AS m ON p.nro_marca = m.nro_marca AND p.nro_tipo_producto = m.nro_tipo_producto
    INNER JOIN dbo.idiomas_productos AS idp ON p.cod_barra = idp.cod_barra AND idp.cod_idioma = @cod_idioma
    WHERE 
        p.vigente = 1
        AND c.vigente = 1
        AND m.vigente = 1
        AND ic.cod_idioma = @cod_idioma
        AND (@json_rubros IS NULL OR r.nro_rubro IN (SELECT nro_rubro FROM #Rubros))
        AND (@json_categorias IS NULL OR c.nro_categoria IN (SELECT nro_categoria FROM #Categorias))
        AND (@json_tipos IS NULL OR m.nro_tipo_producto IN (SELECT nro_tipo_producto FROM #Tipos))
        AND (@json_marcas IS NULL OR m.nro_marca IN (SELECT nro_marca FROM #Marcas))
        AND (@barra_busqueda IS NULL OR idp.nom_producto LIKE '%' + @barra_busqueda + '%')
    ORDER BY p.cod_barra
    OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;

    -- Devuelve el total de productos como una tabla separada
    SELECT @total_count AS TotalCount;

    -- Limpiar tablas temporales
    DROP TABLE #Rubros;
    DROP TABLE #Categorias;
    DROP TABLE #Tipos;
    DROP TABLE #Marcas;
END;
GO




/*
EXEC dbo.get_productos_filtrados 
    @cod_idioma = 'es',
    @json_rubros = '[
    { "nro_rubro": 1 },
    { "nro_rubro": 2 }
]',
    @json_categorias = '[
    { "nro_categoria": 1 },
    { "nro_categoria": 2 }
]',
    @json_tipos = '[
    { "nro_tipo_producto": 1 },
    { "nro_tipo_producto": 2 }
]',
    @json_marcas = '[
    { "nro_marca": 1 },
    { "nro_marca": 2 }
]',
    @page_number = 1,
    @page_size = 12,
    @barra_busqueda = '';
*/

CREATE OR ALTER PROCEDURE get_informacion_sucursales
	@nro_localidad INT
AS
BEGIN
    SELECT 
		sm.razon_social,
        s.nro_sucursal,
        s.nom_sucursal,
        s.calle,
        s.nro_calle,
        s.telefono,
        s.coord_latitud,
        s.coord_longitud,
        s.horario_sucursal,
		s.servicios_disponibles,
		l.nom_localidad,
		p.nom_provincia
    FROM 
        dbo.sucursales AS s
    INNER JOIN 
        dbo.supermercados AS sm ON s.nro_supermercado = sm.nro_supermercado
    INNER JOIN 
        dbo.localidades AS l ON s.nro_localidad = l.nro_localidad
    INNER JOIN 
        dbo.provincias AS p ON l.cod_pais = p.cod_pais AND l.cod_provincia = p.cod_provincia
    WHERE 
        s.nro_localidad = @nro_localidad
		AND s.habilitada = 1
    ORDER BY 
        s.nro_sucursal;
END;
GO


CREATE OR ALTER PROCEDURE dbo.get_servicios_supermercados
AS
BEGIN

    SELECT 
        s.nro_supermercado,
        s.url_servicio,
        s.tipo_servicio,
        s.usuario,
		s.clave,
        s.fecha_ult_act_servicio
    FROM 
        dbo.servicios_supermercados AS s;
END;
GO


CREATE OR ALTER PROCEDURE dbo.act_informacion_sucursales
    @nro_supermercado INT,
    @json NVARCHAR(MAX)
AS
BEGIN
    DECLARE @fecha_ult_actualizacion DATETIME = GETDATE();

    -- Crear una tabla temporal para almacenar los nuevos datos
    CREATE TABLE #sucursales
    (
        nro_supermercado       INT,
        nro_sucursal           INT,
        nom_sucursal           VARCHAR(255),
        calle                  VARCHAR(255),
        nro_calle              INT,
        telefono               VARCHAR(30),
        nro_localidad          INT,
        coord_latitud          DECIMAL(9, 6),
        coord_longitud         DECIMAL(9, 6),
        horarios               VARCHAR(MAX),
        servicios              VARCHAR(MAX)
    );

    -- Insertar los datos del JSON en la tabla temporal
    INSERT INTO #sucursales (nro_supermercado, nro_sucursal, nom_sucursal, calle, nro_calle, telefono, nro_localidad, coord_latitud, coord_longitud, horarios, servicios)
    SELECT  
        @nro_supermercado,
        JSON_VALUE(sucursal.VALUE, '$.nro_sucursal'), 
        JSON_VALUE(sucursal.VALUE, '$.nom_sucursal'), 
        JSON_VALUE(sucursal.VALUE, '$.calle'), 
        JSON_VALUE(sucursal.VALUE, '$.nro_calle'),
        JSON_VALUE(sucursal.VALUE, '$.telefono'), 
        JSON_VALUE(sucursal.VALUE, '$.nro_localidad'),
        CAST(JSON_VALUE(sucursal.VALUE, '$.coord_latitud') AS DECIMAL(9, 6)),
        CAST(JSON_VALUE(sucursal.VALUE, '$.coord_longitud') AS DECIMAL(9, 6)),
        JSON_VALUE(sucursal.VALUE, '$.horarios'),
        JSON_VALUE(sucursal.VALUE, '$.servicios')
    FROM OPENJSON(@json) AS sucursal;

    -- Eliminar los registros existentes para el supermercado especificado
    DELETE FROM dbo.sucursales
    WHERE nro_supermercado = @nro_supermercado;

    -- Insertar los nuevos datos desde la tabla temporal
    INSERT INTO dbo.sucursales (nro_supermercado, nro_sucursal, nom_sucursal, calle, nro_calle, telefono, coord_latitud, coord_longitud, horario_sucursal, servicios_disponibles, nro_localidad, habilitada)
    SELECT 
        nro_supermercado, nro_sucursal, nom_sucursal, calle, nro_calle, telefono, coord_latitud, coord_longitud, horarios, servicios, nro_localidad, 1
    FROM #sucursales;

    -- Actualizar la fecha de último servicio en servicios_supermercados
    UPDATE dbo.servicios_supermercados
       SET fecha_ult_act_servicio = @fecha_ult_actualizacion
     WHERE nro_supermercado = @nro_supermercado;

    -- Limpiar la tabla temporal
    DROP TABLE #sucursales;
END
GO


/*exec dbo.act_informacion_sucursales @nro_supermercado=1, @json='[{"nro_sucursal":1,"nom_sucursal":"Disco - La Plata","calle":"Calle 50","nro_calle":300,"telefono":"0221-456-7890","coord_latitud":-34.9205,"coord_longitud":-57.9536,"habilitada":true,"nro_localidad":1,"servicios":"Delivery - Descuentos Exclusivos","horarios":" Domingo - 09:00 - 18:00  Jueves - 08:00 - 22:00  Lunes - 08:00 - 22:00  Martes - 08:00 - 22:00  Miércoles - 08:00 - 22:00  Sábado - 08:00 - 20:00  Viernes - 08:00 - 22:00"},{"nro_sucursal":2,"nom_sucursal":"Disco - Córdoba Capital","calle":"Av. Duarte Quirós","nro_calle":1100,"telefono":"0351-789-4561","coord_latitud":-31.4173,"coord_longitud":-64.1831,"habilitada":true,"nro_localidad":3,"servicios":"Recolección en Tienda - Club de Beneficios","horarios":" Domingo - 10:00 - 18:00  Jueves - 09:00 - 21:00  Lunes - 09:00 - 21:00  Martes - 09:00 - 21:00  Miércoles - 09:00 - 21:00  Sábado - 09:00 - 19:00  Viernes - 09:00 - 21:00"}]'
GO
*/

/*
select * from dbo.sucursales
delete from dbo.sucursales

select * from dbo.productos_supermercados
delete from dbo.productos_supermercados
*/

/*
exec dbo.act_precios_productos @nro_supermercado=1, @json='[{"nro_sucursal":1,"cod_barra":"7790001000011","precio":"130.00"}]'
GO
*/

CREATE OR ALTER PROCEDURE dbo.act_precios_productos
(
    @json NVARCHAR(MAX),
    @nro_supermercado INTEGER
)
AS
BEGIN
    DECLARE @fecha_ult_actualizacion DATETIME = GETDATE();

    -- Crear tabla temporal para los productos
    CREATE TABLE #temp_productos 
    (
        nro_supermercado    INT,
        nro_sucursal        INT,
        cod_barra           VARCHAR(40),
        precio              DECIMAL(10, 2),
		precio_anterior     DECIMAL(10, 2),
		variacion			DECIMAL(10, 2)
    );

    -- Insertar datos en la tabla temporal desde el JSON
    INSERT INTO #temp_productos (nro_supermercado, nro_sucursal, cod_barra, precio, precio_anterior, variacion)
    SELECT
        nro_supermercado    = @nro_supermercado,
        nro_sucursal        = CAST(JSON_VALUE(VALUE, '$.nro_sucursal') AS INT),
        cod_barra           = JSON_VALUE(VALUE, '$.cod_barra'),
        precio              = CAST(JSON_VALUE(VALUE, '$.precio') AS DECIMAL(10, 2)),
		precio_anterior     = CAST(JSON_VALUE(VALUE, '$.precio') AS DECIMAL(10, 2)),
		variacion			= 0
    FROM OPENJSON(@json) AS VALUE;

    -- Actualizar precios existentes
    UPDATE p
       SET p.precio_anterior=p.precio,
		   p.precio = tp.precio,
           p.fecha_ult_actualizacion = @fecha_ult_actualizacion,
		   p.variacion = ((tp.precio/p.precio)-1)
      FROM dbo.productos_supermercados p
      JOIN #temp_productos tp
        ON p.cod_barra = tp.cod_barra
       AND p.nro_supermercado = tp.nro_supermercado
       AND p.nro_sucursal = tp.nro_sucursal;

    -- Insertar nuevos productos
    INSERT INTO dbo.productos_supermercados (nro_supermercado, nro_sucursal, cod_barra, precio, precio_anterior, variacion, fecha_ult_actualizacion)
    SELECT 
        tp.nro_supermercado, 
        tp.nro_sucursal, 
        tp.cod_barra, 
        tp.precio,
		tp.precio_anterior,
		tp.variacion,
        @fecha_ult_actualizacion
    FROM #temp_productos tp
    WHERE NOT EXISTS (
        SELECT 1
        FROM dbo.productos_supermercados ps
        WHERE ps.cod_barra = tp.cod_barra
          AND ps.nro_supermercado = tp.nro_supermercado
          AND ps.nro_sucursal = tp.nro_sucursal
    )
    AND EXISTS (
        SELECT 1
        FROM dbo.productos p
        WHERE p.cod_barra = tp.cod_barra
    )
    AND EXISTS (
        SELECT 1
        FROM dbo.sucursales s
        WHERE s.nro_supermercado = tp.nro_supermercado
          AND s.nro_sucursal = tp.nro_sucursal
    );

    -- Actualizar fecha de último servicio en servicios_supermercados
    UPDATE dbo.servicios_supermercados
       SET fecha_ult_act_servicio = @fecha_ult_actualizacion
     WHERE nro_supermercado = @nro_supermercado;

    -- Limpiar tabla temporal
    DROP TABLE #temp_productos;
END;
GO


CREATE OR ALTER PROCEDURE dbo.CompararPreciosProductos
    @CodigosBarra NVARCHAR(MAX), -- Lista de códigos de barra en formato JSON
    @Localidad INT               -- Número de la localidad
AS
BEGIN
    SET NOCOUNT ON;

    -- Convertimos la lista de códigos de barra JSON a una tabla temporal
    DECLARE @CodigosTable TABLE (CodBarra NVARCHAR(50));
    INSERT INTO @CodigosTable (CodBarra)
    SELECT value 
    FROM OPENJSON(@CodigosBarra);

    -- Calcular el total de precios por supermercado y productos actualizados
    WITH SupermercadosTotales AS (
        SELECT 
            s.nro_supermercado,
            s.nom_sucursal,
            sm.imagen,
            MAX(CASE 
                WHEN CAST(ss.fecha_ult_act_servicio AS DATE) <> CAST(GETDATE() AS DATE) THEN 1
                ELSE 0
            END) AS super_desactualizado,
            SUM(CASE 
                WHEN CAST(ps.fecha_ult_actualizacion AS DATE) = CAST(GETDATE() AS DATE) THEN ps.precio
                ELSE 0
            END) AS total_actualizados, -- Sumar solo precios actualizados
            COUNT(CASE 
                WHEN CAST(ps.fecha_ult_actualizacion AS DATE) = CAST(GETDATE() AS DATE) THEN 1
                ELSE NULL
            END) AS productos_actualizados -- Contar productos actualizados
        FROM productos p
        LEFT JOIN productos_supermercados ps 
            ON p.cod_barra = ps.cod_barra
        LEFT JOIN sucursales s
            ON ps.nro_supermercado = s.nro_supermercado
            AND ps.nro_sucursal = s.nro_sucursal
        LEFT JOIN supermercados sm 
            ON s.nro_supermercado = sm.nro_supermercado
        LEFT JOIN servicios_supermercados ss 
            ON ss.nro_supermercado = sm.nro_supermercado
        WHERE s.nro_localidad = @Localidad
          AND p.cod_barra IN (SELECT CodBarra FROM @CodigosTable)
        GROUP BY s.nro_supermercado, s.nom_sucursal, sm.imagen
        HAVING MAX(CASE 
                WHEN CAST(ss.fecha_ult_act_servicio AS DATE) <> CAST(GETDATE() AS DATE) THEN 1
                ELSE 0
            END) = 0 -- Excluir supermercados desactualizados
    ),
    -- Identificar el supermercado con más productos actualizados
    MaximosActualizados AS (
        SELECT 
            MAX(productos_actualizados) AS max_actualizados
        FROM SupermercadosTotales
    ),
    -- Filtrar supermercados con el máximo de productos actualizados
    SupermercadosFiltrados AS (
        SELECT 
            st.nro_supermercado,
            st.nom_sucursal,
            st.imagen,
            st.total_actualizados,
            st.productos_actualizados
        FROM SupermercadosTotales st
        CROSS JOIN MaximosActualizados ma
        WHERE st.productos_actualizados = ma.max_actualizados
    ),
    -- Determinar el supermercado más conveniente entre los filtrados
    MinimosTotales AS (
        SELECT TOP 1 
            nro_supermercado,
            MIN(total_actualizados) AS minimo_total
        FROM SupermercadosFiltrados
        GROUP BY nro_supermercado
        ORDER BY minimo_total ASC
    )
    SELECT DISTINCT
		p.imagen as imagen_producto,
        sm.imagen,
        p.nom_producto,
        sm.razon_social,
        CASE 
            WHEN ps.precio IS NOT NULL THEN ps.precio
            ELSE '-' 
        END AS precio,
		ps.precio_anterior,
		ps.variacion,
        CASE 
            WHEN CAST(ps.fecha_ult_actualizacion AS DATE) <> CAST(GETDATE() AS DATE) THEN 'Desactualizado'
            ELSE 'Actualizado'
        END AS estado_precio, -- Indica si el producto está actualizado o no
        CASE 
            WHEN ps.precio = MIN(CASE 
                                    WHEN CAST(ps.fecha_ult_actualizacion AS DATE) = CAST(GETDATE() AS DATE) 
                                         AND CAST(ss.fecha_ult_act_servicio AS DATE) = CAST(GETDATE() AS DATE) 
                                    THEN ps.precio 
                                    ELSE NULL 
                                 END) OVER (PARTITION BY p.cod_barra) THEN 1
            ELSE 0
        END AS precio_mas_barato, -- Marca si es el precio más barato considerando solo precios y supermercados actualizados
        CASE 
            WHEN CAST(ss.fecha_ult_act_servicio AS DATE) <> CAST(GETDATE() AS DATE) THEN 'Desactualizado'
            ELSE 'Actualizado'
        END AS estado_super,
		CASE 
            WHEN st.nro_supermercado = mt.nro_supermercado THEN 'Más conveniente'
            ELSE NULL
        END AS supermercado_mas_conveniente, -- Marca el supermercado más conveniente
        st.total_actualizados AS monto_total_supermercado -- Monto total del supermercado más conveniente
    FROM productos p
    LEFT JOIN productos_supermercados ps 
        ON p.cod_barra = ps.cod_barra
        AND ps.fecha_ult_actualizacion IS NOT NULL
    LEFT JOIN sucursales s
        ON ps.nro_supermercado = s.nro_supermercado
        AND ps.nro_sucursal = s.nro_sucursal
    LEFT JOIN supermercados sm 
        ON s.nro_supermercado = sm.nro_supermercado
    LEFT JOIN servicios_supermercados ss 
        ON ss.nro_supermercado = sm.nro_supermercado
    LEFT JOIN SupermercadosTotales st 
        ON s.nro_supermercado = st.nro_supermercado
    CROSS JOIN MinimosTotales mt
    WHERE s.nro_localidad = @Localidad
      AND p.cod_barra IN (SELECT CodBarra FROM @CodigosTable)
    ORDER BY p.nom_producto, sm.razon_social;
END;
GO


EXEC dbo.CompararPreciosProductos @localidad=1, @CodigosBarra='["7790001000011"]';
EXEC dbo.CompararPreciosProductos @localidad=1, @CodigosBarra='["7790005000028"]';

/*
UPDATE p
set fecha_ult_actualizacion = '2024-12-18 02:58:00'
from dbo.productos_supermercados p where nro_supermercado = 3 and nro_sucursal=1

UPDATE s
set fecha_ult_act_servicio = '2024-12-18 02:58:00'
from dbo.servicios_supermercados s where nro_supermercado = 3
*/

/*
select * from dbo.sucursales
delete from dbo.sucursales

select * from dbo.productos_supermercados
delete from dbo.productos_supermercados
*/
