CREATE DATABASE control_maritimo;


CREATE TABLE tipo_barco (
  codigo_tipo INT AUTO_INCREMENT  NOT NULL,
  nombre      VARCHAR(100)        NOT NULL,

  CONSTRAINT Pk_tipo_barco_codigo_tipo PRIMARY KEY (codigo_tipo)
);


CREATE TABLE pais (
  codigo_pais INT AUTO_INCREMENT  NOT NULL,
  nombre      VARCHAR(100)        NOT NULL,

  CONSTRAINT Pk_pais_codigo_pais PRIMARY KEY (codigo_pais)
);


CREATE TABLE zona (
  codigo_zona INT AUTO_INCREMENT  NOT NULL,
  nombre      VARCHAR(100)        NOT NULL,

  CONSTRAINT Pk_zona_codigo_zona PRIMARY KEY (codigo_zona)
);


CREATE TABLE distancia (
  codigo_distancia  INT AUTO_INCREMENT  NOT NULL,
  codigo_puerto_o   INT                 NOT NULL,
  codigo_puerto_d   INT                 NOT NULL,
  distancia_km      DECIMAL(10,2)       NOT NULL,

  CONSTRAINT Pk_distancia_codigo_distancia PRIMARY KEY (codigo_distancia)
);


CREATE TABLE especie (
  codigo_especie  INT AUTO_INCREMENT  NOT NULL,
  nombre          VARCHAR(100)        NOT NULL,

  CONSTRAINT Pk_especie_codigo_especie PRIMARY KEY (codigo_especie)
);


CREATE TABLE grua (
  codigo_grua INT AUTO_INCREMENT  NOT NULL,
  nombre      VARCHAR(100)        NOT NULL,

  CONSTRAINT Pk_grua_codigo_grua PRIMARY KEY (codigo_grua)
);


CREATE TABLE mercaderia (
  codigo_mercaderia INT AUTO_INCREMENT  NOT NULL,
  nombre            VARCHAR(100)        NOT NULL,
  unidad            INT                 NOT NULL,
  peso_m3           DECIMAL(6,2)        NOT NULL,

  CONSTRAINT Pk_mercaderia_codigo_mercaderia PRIMARY KEY (codigo_mercaderia)
);


CREATE TABLE barco (
  matricula           INT AUTO_INCREMENT  NOT NULL,
  codigo_tipo         INT                 NOT NULL,
  bandera             VARCHAR(100)        NOT NULL,
  nombre              VARCHAR(100)        NOT NULL,
  tonelaje            INT                 NOT NULL,
  calado              INT                 NOT NULL,
  fecha_botadura      DATE                NOT NULL,
  tipo_pesca          VARCHAR(100)        NOT NULL,
  cantidad_pasajeros  INT                 NOT NULL,
  capacidad_carga     INT                 NOT NULL,

  CONSTRAINT Pk_barco_matricula PRIMARY KEY (matricula),
  CONSTRAINT Fk_barco_codigo_tipo FOREIGN KEY (codigo_tipo) REFERENCES tipo_barco (codigo_tipo)
);


CREATE TABLE puerto (
  codigo_puerto     INT AUTO_INCREMENT      NOT NULL,
  codigo_pais       INT                     NOT NULL,
  nombre            VARCHAR(100)            NOT NULL,
  tipo_agua         ENUM('Dulce','Salada')  NOT NULL,
  profundidad       INT                     NOT NULL,
  capacidad_barcos  INT                     NOT NULL,

  CONSTRAINT Pk_puerto_codigo_puerto PRIMARY KEY (codigo_puerto),
  CONSTRAINT Fk_puerto_codigo_pais FOREIGN KEY (codigo_pais) REFERENCES pais (codigo_pais)
);


CREATE TABLE punto (
  codigo_punto  INT AUTO_INCREMENT  NOT NULL,
  codigo_zona   INT                 NOT NULL,
  latitud       INT,
  longitud      INT,

  CONSTRAINT Pk_punto_codigo_punto PRIMARY KEY (codigo_punto),
  CONSTRAINT Fk_punto_codigo_zona FOREIGN KEY (codigo_zona) REFERENCES zona (codigo_zona)
);


CREATE TABLE bitacora_atraco (
  codigo_bitacora INT AUTO_INCREMENT  NOT NULL,
  codigo_puerto   INT                 NOT NULL,
  matricula       INT                 NOT NULL,
  fecha           DATE                NOT NULL,

  CONSTRAINT Pk_bitacora_atraco_codigo_bitacora PRIMARY KEY (codigo_bitacora),
  CONSTRAINT Fk_bitacora_atraco_codigo_puerto FOREIGN KEY (codigo_puerto) REFERENCES puerto (codigo_puerto),
  CONSTRAINT Fk_bitacora_atraco_matricula FOREIGN KEY (matricula) REFERENCES barco (matricula)
);


CREATE TABLE bitacora_pesca (
  codigo_zona INT NOT NULL,
  matricula   INT NOT NULL,
  fecha       DATE,

  CONSTRAINT Fk_bitacora_pesca_codigo_zona FOREIGN KEY (codigo_zona) REFERENCES zona (codigo_zona),
  CONSTRAINT Fk_bitacora_pesca_matricula FOREIGN KEY (matricula) REFERENCES barco (matricula)
);


CREATE TABLE movimiento (
  codigo_bitacora   INT                       NOT NULL,
  codigo_mercaderia INT                       NOT NULL,
  operacion         ENUM('Carga','Descarga')  NOT NULL,
  cantidad          INT                       NOT NULL,

  CONSTRAINT Fk_movimiento_codigo_bitacora FOREIGN KEY (codigo_bitacora) REFERENCES bitacora_atraco (codigo_bitacora),
  CONSTRAINT Fk_movimiento_codigo_mercaderia FOREIGN KEY (codigo_mercaderia) REFERENCES mercaderia (codigo_mercaderia)
);


CREATE TABLE permiso (
  codigo_zona     INT             NOT NULL,
  codigo_especie  INT             NOT NULL,
  permiso         ENUM('Si','No') NOT NULL,

  CONSTRAINT Fk_permiso_codigo_zona FOREIGN KEY (codigo_zona) REFERENCES zona (codigo_zona),
  CONSTRAINT Fk_permiso_codigo_especie FOREIGN KEY (codigo_especie) REFERENCES especie (codigo_especie)
);


CREATE TABLE puerto_grua (
  codigo_puerto INT NOT NULL,
  codigo_grua   INT NOT NULL,
  cantidad      INT NOT NULL,

  CONSTRAINT Fk_puerto_grua_codigo_puerto FOREIGN KEY (codigo_puerto) REFERENCES puerto (codigo_puerto),
  CONSTRAINT Fk_puerto_grua_codigo_grua FOREIGN KEY (codigo_grua) REFERENCES grua (codigo_grua)
);


CREATE TABLE zona_puerto (
  codigo_zona     INT NOT NULL,
  codigo_puerto   INT NOT NULL,
  
  CONSTRAINT Fk_zona_puerto_codigo_zona FOREIGN KEY (codigo_zona) REFERENCES zona (codigo_zona),
  CONSTRAINT Fk_zona_puerto_codigo_puerto FOREIGN KEY (codigo_puerto) REFERENCES puerto (codigo_puerto)
);


-- INSERT


INSERT INTO tipo_barco (nombre) VALUES 
('Furtivo'),('Cablero'),('Pesquero'),('Experimental'),('Funerario'),
('Fluvial'),('Maltes'),('Salvavida'),('Yate'),('Grua flotante'),
('Barco de pasajeros'),('De rescate'),('Barco espia'),('Crucero'),('Atunero');


INSERT INTO pais (nombre) VALUES 
('El Salvador'),('Guatemala'),('Honduras'),
('Nicaragua'),('Panama'),('Canada'),
('Costa Rica'),('Belice'),('Argentina'),
('Chile'),('Venezuela'),('Peru'),
('Republica Dominicana'),('Cuba'),('Mexico');


INSERT INTO zona (nombre) VALUES 
('Zona 1'),('Zona 2'),('Zona 3'),('Zona 4'),('Zona 5'),
('Zona 6'),('Zona 7'),('Zona 8'),('Zona 9'),('Zona 10'),
('Zona 11'),('Zona 12'),('Zona 13'),('Zona 14'),('Zona 15');


INSERT INTO distancia (codigo_puerto_o, codigo_puerto_d, distancia_km) VALUES 
(1,15,300.00),(2,14,301.00),(3,13,302.00),
(4,12,303.00),(5,11,304.00),(6,10,305.00),
(7,9,306.00),(8,8,307.00),(9,9,308.00),
(10,10,309.00),(11,11,310.00),(12,12,311.00),
(13,13,312.00),(14,14,313.00),(15,15,314.00);


INSERT INTO especie (nombre) VALUES 
('Peces'),('Peces continentales'),('Cnidarios'),
('Moluscos'),('Equinodermos'),('Crusteceos'),
('Tunicados'),('Ctenoforos'),('Poriferos'),
('Anelidos'),('Reptiles'),('Brioozoos'),
('Algas'),('Fanerogamas'),('Cetaceos');


INSERT INTO grua (nombre) VALUES 
('grua 1'),('grua 2'),('grua 3'),
('grua 4'),('grua 5'),('grua 6'),
('grua 7'),('grua 8'),('grua 9'),
('grua 10'),('grua 11'),('grua 12'),
('grua 13'),('grua 14'),('grua 15');


INSERT INTO mercaderia (nombre, unidad, peso_m3) VALUES 
('Tunylite',300,1000.01),('Calmex',301,1000.02),('Great Value',302,1000.03),
('El Dorado',303,1000.04),('Calvo',304,1000.05),('La Sirena',305,1000.06),
('Dolores',306,1000.07),('Bahia',307,1000.08),('Pacifico Azul',308,1000.09),
('Van Camps',309,1000.10),('Sardimar',310,1000.11),('Tesoro del mar',311,1000.12),
('Ancla',312,1000.13),('Suli',313,1000.14),('Florida',314,1000.15);


INSERT INTO barco (codigo_tipo, bandera, nombre, tonelaje, calado, fecha_botadura, tipo_pesca, cantidad_pasajeros, capacidad_carga) VALUES 
(1,'bandera 1','La Niña',11,150,'2020-06-15','De altura',2,60),
(2,'bandera 2','La Pinta',12,151,'2020-06-16','De altura',3,61),
(3,'bandera 3','Santa Maria',13,152,'2020-06-17','De altura',4,62),
(4,'bandera 4','Joseph',14,153,'2020-06-18','De altura',5,63),
(5,'bandera 5','James',15,154,'2020-06-19','De altura',6,64),
(6,'bandera 6','Going Merry go',20,150,'2020-09-26','con red',8,70),
(7,'bandera 7','Baroque Works',5,150,'2020-10-17','con trampas',4,50),
(8,'bandera 8','Thousand Sunny',5,150,'2023-11-30','con arpon',6,50),
(9,'bandera 9','Navegante',18,170,'2016-08-19','Industrial',30,200),
(10,'bandera 10','Titanic',20,155,'2018-01-25','De altura',45,95),
(11,'bandera 11','Queen Mary',45,110,'2003-01-11','De altura',45,80),
(12,'bandera 12','Jamestone',78,300,'2004-02-12','De bajura',78,90),
(13,'bandera 13','Elizabeth',36,450,'2005-03-13','Industrial',80,100),
(14,'bandera 14','Dorothy',46,460,'2006-04-14','Industrial',90,110),
(15,'bandera 15','Rose',46,460,'2007-05-15','Industrial',100,120);


INSERT INTO puerto (codigo_pais, nombre, tipo_agua, profundidad, capacidad_barcos) VALUES 
(15,'Puerto El Triunfo','Dulce',200,50),(14,'Puerto De La Libertad','Salada',201,51),
(13,'Puerto De La Union','Dulce',202,52),(12,'Puerto Acajutla','Salada',203,53),
(11,'Puerto Barillas','Dulce',204,54),(10,'Puerto CORSAIN','Salada',205,55),
(9,'Puerto San Juan del Sur','Dulce',206,56),(8,'Puerto San Miguel','Salada',207,57),
(7,'Puerto Charco Azul','Dulce',208,58),(6,'Puerto Santo Tomas','Salada',209,59),
(5,'Puerto Cristobal','Dulce',210,60),(4,'Puerto Cortez','Salada',211,61),
(3,'Puerto Roatan','Dulce',212,62),(2,'Puerto Tela','Salada',213,63),
(1,'Puerto Limon','Dulce',214,64);


INSERT INTO punto (codigo_zona, latitud, longitud) VALUES 
(15,100,30),(14,101,31),(13,102,32),(12,103,33),(11,104,34),
(10,105,35),(9,106,36),(8,107,37),(7,108,38),(6,109,39),
(5,110,40),(4,111,41),(3,112,42),(2,113,43),(1,114,44);


INSERT INTO bitacora_atraco (codigo_puerto, matricula, fecha) VALUES 
(1,1,'2008-04-01'),(2,2,'2008-04-02'),(3,3,'2008-04-03'),
(4,4,'2008-04-04'),(5,5,'2008-04-05'),(6,6,'2008-04-06'),
(7,7,'2008-04-07'),(8,8,'2008-04-08'),(9,9,'2008-04-09'),
(10,10,'2008-04-10'),(11,11,'2008-04-11'),(12,12,'2008-04-12'),
(13,13,'2008-04-13'),(14,14,'2008-04-14'),(15,15,'2008-04-15');


INSERT INTO bitacora_pesca VALUES 
(1,1,'2005-02-10'),(2,2,'2005-02-11'),(3,3,'2005-02-12'),
(4,4,'2005-02-13'),(5,5,'2005-02-14'),(6,6,'2006-02-15'),
(7,7,'2005-02-16'),(8,8,'2006-02-17'),(9,9,'2005-02-18'),
(10,10,'2006-02-19'),(11,11,'2005-02-20'),(12,12,'2006-02-21'),
(13,13,'2005-02-10'),(14,14,'2006-02-11'),(15,15,'2005-02-10');


INSERT INTO movimiento VALUES 
(1,15,'Carga',100),(2,14,'Carga',101),(3,13,'Carga',103),
(4,12,'Carga',104),(5,11,'Carga',105),(6,10,'Carga',106),
(7,9,'Descarga',107),(8,8,'Descarga',108),(9,7,'Descarga',109),
(10,6,'Descarga',110),(11,5,'Descarga',111),(12,4,'Descarga',112),
(13,3,'Descarga',113),(14,2,'Descarga',114),(15,1,'Descarga',115);


INSERT INTO permiso VALUES 
(1,15,'Si'),(2,14,'Si'),(3,13,'Si'),
(4,12,'Si'),(5,11,'Si'),(6,10,'Si'),
(7,9,'Si'),(8,8,'No'),(9,7,'No'),
(10,6,'No'),(11,5,'No'),(12,4,'No'),
(13,3,'No'),(14,2,'No'),(15,1,'No');


INSERT INTO puerto_grua VALUES 
(1,15,5),(2,14,5),(3,13,5),(4,12,5),(5,11,5),
(6,10,5),(7,9,5),(8,8,6),(9,7,6),(10,6,6),
(11,5,6),(12,4,6),(13,3,6),(14,2,6),(15,1,6);


INSERT INTO zona_puerto VALUES (15,1),(14,2),(13,3),(12,4),(11,5),(10,6),(9,7),(8,8),(7,9),(6,10),(5,11),(4,12),(3,13),(2,14),(1,15);
