--mysql

CREATE DATABASE Hotel;

CREATE TABLE Cliente (
  id_cliente          INT AUTO_INCREMENT              NOT NULL, 
  apellidos           VARCHAR(100)                    NOT NULL, 
  nombres             VARCHAR(100)                    NOT NULL, 
  sexo                ENUM('Femenino', 'Masculino')   NOT NULL,
  pais                VARCHAR(100)                    NOT NULL, 
  fecha_nacimiento    DATE                            NOT NULL, 
  
  CONSTRAINT Pk_Cliente_id_cliente PRIMARY KEY(id_cliente)
);

CREATE TABLE Destino (
  id_destino  INT AUTO_INCREMENT  NOT NULL,
  ciudad      VARCHAR(100)        NOT NULL,

  CONSTRAINT Pk_Destino_id_destino PRIMARY KEY(id_destino)
);

CREATE TABLE Empleado (
  id_empleado     INT AUTO_INCREMENT  NOT NULL,
  nombres         VARCHAR(100)        NOT NULL,
  direccion       VARCHAR(200)        NOT NULL,
  cargo           VARCHAR(100)        NOT NULL, 

  CONSTRAINT Pk_Empleado_id_empleado PRIMARY KEY(id_empleado)
);

CREATE TABLE Paquete (
  id_paquete              INT AUTO_INCREMENT  NOT NULL,
  id_destino              INT                 NOT NULL,
  tipo                    VARCHAR(100)        NOT NULL,
  nombre                  VARCHAR(100)        NOT NULL,
  precio_costo            DECIMAL(8,2)        NOT NULL,
  precio_venta            DECIMAL(8,2)        NOT NULL,
  fecha_inicio            DATE                NOT NULL,
  fecha_final             DATE                NOT NULL,
  categoria               VARCHAR(100)        NOT NULL, 
  fecha_confirmacion      DATE                NOT NULL,
  cupos                   INT                 NOT NULL,
  vigente                 ENUM('Si', 'No')    NOT NULL,

  CONSTRAINT Pk_Paquete_id_cliente PRIMARY KEY(id_paquete),
  CONSTRAINT Fk_Paquete_id_destino FOREIGN KEY(id_destino) REFERENCES Destino(id_destino)
);

CREATE TABLE Reserva (
  id_reserva          INT AUTO_INCREMENT  NOT NULL,
  id_paquete          INT                 NOT NULL,
  id_cliente          INT                 NOT NULL,
  fecha               DATE                NOT NULL,
  cantidad            INT                 NOT NULL,
  tipo_pago           VARCHAR(100)        NOT NULL,
  total_venta         DECIMAL(8,2)        NOT NULL,
  descuento           DECIMAL(8,2)        NOT NULL,
  total_neto          DECIMAL(8,2)        NOT NULL,
  confirmado          ENUM('Si', 'No')    NOT NULL,
  anulado             ENUM('Si', 'No')    NOT NULL,
  id_empleado         INT                 NOT NULL,

  CONSTRAINT Pk_Reserva_id_reserva PRIMARY KEY(id_reserva),
  CONSTRAINT Fk_Reserva_id_paquete FOREIGN KEY (id_paquete) REFERENCES Paquete(id_paquete),
  CONSTRAINT Fk_Reserva_id_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  CONSTRAINT Fk_Reserva_id_empleado FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
); 
