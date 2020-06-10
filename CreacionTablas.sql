--CREATE DATABASE PROYECTO_FINAL;
GO
USE [PROYECTO_FINAL]
create table Camion(
Placa			varchar(6),
CargaMax		numeric(5),
CiudadRes		varchar(25),
constraint PK_Camion primary key (Placa)
);
GO
create table Ruta(
Ruta_id			numeric(2),
Descripcion		varchar(50),
constraint PK_Ruta primary key (Ruta_id),
constraint CK_Ruta_id check (Ruta_id between 1 and 10)
);
GO
create table Conductor(
RFC				varchar(13),
Nombre			varchar(25),
Direccion		varchar(50),
constraint PK_Conductor primary key (RFC)
);
GO
create table Ruta_Conductor_Camion(
id_RCC			numeric(6),
RFC				varchar(13),
Placa			varchar(6),
Fecha			date constraint DF_CC default getdate(),
Ruta_id			numeric(2),
constraint PK_CC primary key (id_RCC),
constraint FK_Con foreign key (RFC)
references Conductor (RFC) on update cascade,
constraint FK_Cam foreign key (Placa)
references Camion(Placa) on update cascade,
constraint FK_Ruta foreign key (Ruta_id)
references Ruta (Ruta_id) on update cascade
);
GO
create table C_local(
Codigo			numeric(5),
Nombre			varchar(50),
constraint PK_CLocal primary key (Codigo)
);
GO
create table Paquete(
Codigo			numeric(5),
Direccion		varchar(50),
Peso_gramos		numeric(5),
Destinatario	varchar(50),
Tipo			char(1),
constraint PK_Paquete primary key (Codigo),
constraint CK_Tipo check(Tipo in ('N','I'))
);
GO
create table P_Nacional(
Codigo			numeric(5),
Ciudad_d		varchar(25),
id_RCC			numeric(6),
constraint PK_Nacional primary key (Codigo),
constraint FK_Nac_RCC foreign key (id_RCC)
references Ruta_Conductor_Camion (id_RCC),
CONSTRAINT FK_NAC_PAQ FOREIGN KEY (Codigo)
references Paquete(Codigo) 
);
GO
create table P_Internacional(
Codigo			numeric(5),
LineaAerea		varchar(25),
F_Entrega		date,
Codigo_local	numeric(5),
constraint PK_Internacional primary key (Codigo),
constraint FK_Int_Loc foreign key (Codigo_local)
references C_local (Codigo) on update cascade,
CONSTRAINT FK_INT_PAQ FOREIGN KEY (Codigo)
references Paquete(Codigo)
);
--DROP DATABASE PROYECTO_FINAL;