CREATE DATABASE Hotel;


CREATE TYPE SEXO AS ENUM('Femenino', 'Masculino'); 


CREATE TABLE Cliente (
  id_cliente          SERIAL          NOT NULL,
  nombre              VARCHAR(100)    NOT NULL,
  sexo                SEXO            NOT NULL,
  pais                VARCHAR(100)    NOT NULL,
  fecha_nacimiento    DATE            NOT NULL,

  CONSTRAINT Pk_Cliente_id_cliente PRIMARY KEY(id_cliente)
);


CREATE TABLE Empleado (
  id_empleado        SERIAL          NOT NULL,
  nombre             VARCHAR(100)    NOT NULL,
  dni                INT             NOT NULL,
  direccion          VARCHAR(200)    NOT NULL,
  cargo              VARCHAR(75)     NOT NULL,
  
  CONSTRAINT Pk_Empleado_id_empleado PRIMARY KEY(id_empleado)
);


CREATE TABLE Destino (
  id_destino      SERIAL          NOT NULL,
  ciudad          VARCHAR(100)    NOT NULL,
  
  CONSTRAINT Pk_Destino_id_destino PRIMARY KEY(id_destino)
);


CREATE TYPE VIGENCIA AS ENUM('Si', 'No');


CREATE TABLE Paquete (
  id_paquete          SERIAL          NOT NULL,
  id_destino          INT             NOT NULL,
  tipo                VARCHAR(75)     NOT NULL,
  nombre              VARCHAR(100)    NOT NULL,
  precio_costo        MONEY           NOT NULL,
  precio_venta        MONEY           NOT NULL,
  fecha_inicio        DATE            NOT NULL,
  fecha_final         DATE            NOT NULL,
  categoria           VARCHAR(50)     NOT NULL,
  fecha_confirmacion  DATE            NOT NULL,
  cupos               INT             NOT NULL,
  vigente             VIGENCIA        NOT NULL,

  CONSTRAINT Pk_Paquete_id_paquete PRIMARY KEY(id_paquete),
  CONSTRAINT Fk_Paquete_id_destino FOREIGN KEY(id_destino) REFERENCES Destino             
);


CREATE TABLE Reserva (
  id_reserva     SERIAL       NOT NULL,
  id_paquete     INT          NOT NULL,
  id_cliente     INT          NOT NULL,
  fecha          DATE         NOT NULL,
  cantidad       INT          NOT NULL,
  tipo_pago      VARCHAR(100) NOT NULL,
  total_venta    MONEY        NOT NULL,
  descuento      MONEY        NOT NULL,
  total_neto     MONEY        NOT NULL,
  cod_empleado   INT          NOT NULL,
  
  CONSTRAINT Pk_Reserva_id_reserva PRIMARY KEY(id_reserva),
  CONSTRAINT Fk_Reserva_id_paquete FOREIGN KEY(id_paquete) REFERENCES Paquete,
  CONSTRAINT Fk_Reserva_id_cliente FOREIGN KEY(id_cliente) REFERENCES Cliente,
  CONSTRAINT Fk_Reserva_id_empleado FOREIGN KEY(id_empleado) REFERENCES Empleado
);