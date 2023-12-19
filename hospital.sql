CREATE DATABASE hospital;


CREATE TABLE genero (
  IdGenero  INT(11) AUTO_INCREMENT  NOT NULL,
  Detalle   VARCHAR(45)             NOT NULL,

  CONSTRAINT Pk_genero_IdGenero PRIMARY KEY (IdGenero)
);


CREATE TABLE gestiones (
  IdGestion   INT(11) AUTO_INCREMENT  NOT NULL,
  TipoGestion VARCHAR(45)             NOT NULL,

  CONSTRAINT Pk_gestiones_IdGestion PRIMARY KEY (IdGestion)
);


CREATE TABLE clientes (
  IdCliente   INT(11) AUTO_INCREMENT  NOT NULL,
  Nombre      VARCHAR(45)             NOT NULL,
  Apellido    VARCHAR(45)             NOT NULL,
  Telefono    VARCHAR(45)             NOT NULL,
  Direccion   VARCHAR(200),
  Email       VARCHAR(45)             NOT NULL,
  Contrasenia TINYBLOB                NOT NULL,
  IdGenero    INT(11)                 NOT NULL,

  CONSTRAINT Pk_clientes_IdCliente PRIMARY KEY (IdCliente)
);

ALTER TABLE clientes
  ADD CONSTRAINT FK_Clientes_IdGenero FOREIGN KEY (IdGenero) REFERENCES genero (IdGenero);


CREATE TABLE turnos (
  IdTurno     INT(11) AUTO_INCREMENT NOT NULL,
  Descripcion VARCHAR(100),

  CONSTRAINT Pk_turnos_IdTurno PRIMARY KEY (IdTurno)
);


CREATE TABLE horarios (
  IdHorario   INT(11) AUTO_INCREMENT  NOT NULL,
  Dia         VARCHAR(45)             NOT NULL,
  HoraInicio  VARCHAR(45)             NOT NULL,
  HoraFin     VARCHAR(45)             NOT NULL,
  IdTurno     INT(11)                 NOT NULL,

  CONSTRAINT Pk_horarios_IdHorario PRIMARY KEY (IdHorario)
);

ALTER TABLE horarios
  ADD CONSTRAINT FK_Horarios_IdTurno FOREIGN KEY (IdTurno) REFERENCES turnos (IdTurno);


CREATE TABLE especialidades (
  IdEspecialidad      INT(11) AUTO_INCREMENT  NOT NULL,
  NombreEspecialidad  VARCHAR(75)             NOT NULL,
  Descripcion         VARCHAR(100),

  CONSTRAINT Pk_especialidades_IdEspecialidad PRIMARY KEY (IdEspecialidad)
);


CREATE TABLE medicos (
  IdMedico        INT(11) AUTO_INCREMENT  NOT NULL,
  Nombre          VARCHAR(45)             NOT NULL,
  Apellido        VARCHAR(45)             NOT NULL,
  Telefono        VARCHAR(45)             NOT NULL,
  Email           VARCHAR(45)             NOT NULL,
  IdEspecialidad  INT(11)                 NOT NULL,
  IdTurno         INT(11)                 NOT NULL,

  CONSTRAINT Pk_medicos_IdMedico PRIMARY KEY (IdMedico)
);

ALTER TABLE medicos
  ADD CONSTRAINT FK_Medicos_IdEspecialidad FOREIGN KEY (IdEspecialidad) REFERENCES especialidades (IdEspecialidad),
  ADD CONSTRAINT FK_Medicos_IdTurno FOREIGN KEY (IdTurno) REFERENCES turnos (IdTurno);


CREATE TABLE tipospagos (
  IdTipoPago  INT(11) AUTO_INCREMENT  NOT NULL,
  Descripcion VARCHAR(100)            NOT NULL,

  CONSTRAINT Pk_tipospagos_IdTipoPago PRIMARY KEY (IdTipoPago)
);


CREATE TABLE pagos (
  IdPago      INT(11) AUTO_INCREMENT  NOT NULL,
  IdTipoPago  INT(11)                 NOT NULL,

  CONSTRAINT Pk_pagos_IdPago PRIMARY KEY (IdPago)
);

ALTER TABLE pagos
  ADD CONSTRAINT FK_Pagos_IdTipoPago FOREIGN KEY (IdTipoPago) REFERENCES tipospagos (IdTipoPago);


CREATE TABLE sucursales (
  IdSucursal      INT(11) auto_increment  NOT NULL,
  NombreSucursal  VARCHAR(45)             NOT NULL,
  Telefono        VARCHAR(45)             NOT NULL,
  Direccion       VARCHAR(200)            NOT NULL,

  CONSTRAINT Pk_sucursales_IdSucursal PRIMARY KEY (IdSucursal)
);


CREATE TABLE citas (
  IdCita      INT(11) AUTO_INCREMENT  NOT NULL,
  Estado      VARCHAR(45)             NOT NULL,
  Fecha       DATE                    NOT NULL,
  Costo       DECIMAL(8,2)            NOT NULL,
  IdCliente   INT(11)                 NOT NULL,
  IdSucursal  INT(11)                 NOT NULL,
  IdHorario   INT(11)                 NOT NULL,
  IdMedico    INT(11)                 NOT NULL,
  IdPago      INT(11)                 NOT NULL,

  CONSTRAINT Pk_citas_IdCita PRIMARY KEY (IdCita)
);

ALTER TABLE citas
  ADD CONSTRAINT FK_Citas_IdCliente FOREIGN KEY (IdCliente) REFERENCES clientes (IdCliente),
  ADD CONSTRAINT FK_Citas_IdHorario FOREIGN KEY (IdHorario) REFERENCES horarios (IdHorario),
  ADD CONSTRAINT FK_Citas_IdMedico FOREIGN KEY (IdMedico) REFERENCES medicos (IdMedico),
  ADD CONSTRAINT FK_Citas_IdPago FOREIGN KEY (IdPago) REFERENCES pagos (IdPago),
  ADD CONSTRAINT FK_Citas_IdSucursal FOREIGN KEY (IdSucursal) REFERENCES sucursales (IdSucursal);


CREATE TABLE historial (
  IdHistorial INT(11) AUTO_INCREMENT  NOT NULL,
  Fecha       DATE                    NOT NULL,
  Detalle     BLOB,
  Costo       DECIMAL(8,2)            NOT NULL,
  IdGestion   INT(11)                 NOT NULL,

  CONSTRAINT Pk_historial_IdHistorial PRIMARY KEY (IdHistorial)
);

ALTER TABLE historial
  ADD CONSTRAINT FK_Historial_IdGestion FOREIGN KEY (IdGestion) REFERENCES gestiones (IdGestion);


CREATE TABLE clienteshistorial (
  IdCliente   INT(11) AUTO_INCREMENT  NOT NULL,
  IdHistorial INT(11)                 NOT NULL,

  CONSTRAINT FK_ClientesHistorial_IdCliente FOREIGN KEY (IdCliente) REFERENCES clientes (IdCliente),
  CONSTRAINT FK_ClientesHistorial_IdHistoiral FOREIGN KEY (IdHistorial) REFERENCES historial (IdHistorial)
);


CREATE TABLE sucursalesmedicos (
  IdMedico    INT(11) AUTO_INCREMENT  NOT NULL,
  IdSucursal  INT(11)                 NOT NULL,

  CONSTRAINT FK_SucursalesMedicos_IdMedico FOREIGN KEY (IdMedico) REFERENCES medicos (IdMedico),
  CONSTRAINT FK_SucursalesMedicos_IdSucursal FOREIGN KEY (IdSucursal) REFERENCES sucursales (IdSucursal)
);


--INSERT 

INSERT INTO genero (Detalle) VALUES
('Masculino'),
('Femenino'),
('No binario');

INSERT INTO clientes (Nombre, Apellido, Telefono, Direccion, Email, Contrasenia, IdGenero) VALUES
('Ana', 'Rodriguez', '1234-1234', 'Jardines del recuerdo, San Salvador, El Salvador', 'a@rodriguez.com', 0x3132333435, 2),
('Eliseo', 'Moran', '1111-1111', 'Los angeles, San Salvador, El Salvador', 'e@moran.com', 0x3535363733, 1),
('Alejandro', 'Henriquez', '2222-2222', 'La Cima, La Libertad, El Salvador', 'a@henriquez.com', 0x303938373635, 1);

INSERT INTO turnos (Descripcion) VALUES
('8 A.M. - 11:59 A.M.'),
('12 P.M. - 5:59 P.M.'),
('6 P.M. - 11:59 P.M.');

INSERT INTO horarios (Dia, HoraInicio, HoraFin, IdTurno) VALUES
('Lunes', '8:00 A.M.', '9:00 P.M.', 1),
('Martes', '9:00 A.M.', '10:00 P.M.', 2),
('Miercoles', '10:00 A.M.', '11:00 P.M.', 3);

INSERT INTO especialidades (NombreEspecialidad, Descripcion) VALUES
('Cardiologo', 'Medico Cardiologo'),
('Internista', 'Medico Internista'),
('Ginecologo', 'Medico Ginecologo');

INSERT INTO medicos (Nombre, Apellido, Telefono, Email, IdEspecialidad, IdTurno) VALUES
('Carlos', 'Palacios', '7777-8888', 'capalacios@hospital.com', 1, 1),
('Gabriel', 'Hernandez', '7777-9999', 'ghernandez@hospital.com', 2, 2),
('Marcela', 'Joya', '7777-7777', 'mjoya@hospital.com', 3, 3);

INSERT INTO tipospagos (Descripcion) VALUES
('Efectivo'),
('Debito'),
('Credito');

INSERT INTO pagos (IdTipoPago) VALUES
(3),
(2),
(1);

INSERT INTO sucursales (NombreSucursal, Telefono, Direccion) VALUES
('Laboratorio San Salvador', '2121-2121', '25 Avenida Norte'),
('Clinica y Laboratorio Chalatenango', '2121-2122', '5° Calle Oriente colonia Santa Cecilia'),
('Clinica y Laboratorio San Miguel', '2121-2123', '7° Avenida Sur #503');

INSERT INTO citas (Estado, Fecha, Costo, IdCliente, IdSucursal, IdHorario, IdMedico, IdPago) VALUES
('Activo', '0000-00-00', '9.50', 1, 1, 3, 1, 3),
('Inactivo', '0000-00-00', '9.50', 2, 2, 2, 2, 3),
('Activo', '0000-00-00', '9.50', 3, 3, 1, 1, 1);