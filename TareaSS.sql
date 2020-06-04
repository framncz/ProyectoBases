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
create table R_Conductor(
R_C_id			numeric(4),
Ruta_id			numeric(2),
RFC				varchar(13),
constraint PK_R_C primary key (R_C_id),
constraint FK_Ruta foreign key (Ruta_id)
references Ruta (Ruta_id) on update cascade,
constraint FK_RFC foreign key (RFC)
references Conductor (RFC) on update cascade
);
GO
create table Conductor_Camion(
id_CC			numeric(6),
RFC				varchar(13),
Placa			varchar(6),
Fecha			date constraint DF_CC default getdate(),
constraint PK_CC primary key (id_CC),
constraint FK_Con foreign key (RFC)
references Conductor (RFC) on update cascade,
constraint FK_Cam foreign key (Placa)
references Camion(Placa) on update cascade
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
Ciudad_d		varchar(25),
Codigo			numeric(5),
RFC				varchar(13),
constraint FK_Paq_Nac foreign key (Codigo)
references Paquete (Codigo) on update cascade on delete cascade,
constraint PK_Nacional primary key (Codigo),
constraint FK_Nac_Con foreign key (RFC)
references Conductor (RFC) on update cascade
);
GO
create table P_Internacional(
LineaAerea		varchar(25),
Codigo			numeric(5),
F_Entrega		date,
Codigo_local	numeric(5),
constraint FK_Paq_Int foreign key (Codigo)
references Paquete (Codigo) on update cascade on delete cascade,
constraint PK_Internacional primary key (Codigo),
constraint FK_Int_Loc foreign key (Codigo_local)
references C_local (Codigo) on update cascade
);
GO
create table Ruta_Nac(
id_Ruta_Nac		numeric(5),
Codigo			numeric(5),
Ruta_id			numeric(2),
constraint PK_Rut_Nac primary key (id_Ruta_Nac),
constraint FK_Rut_PN foreign key (Codigo)
references P_Nacional (Codigo) on update cascade,
constraint FK_RN_Rut foreign key (Ruta_id)
references Ruta (Ruta_id) on update cascade 
);

insert into Ruta values (1,'CDMX-Puebla');
insert into Ruta values (2,'Leon-Cuernavaca');
insert into Ruta values (3,'Acapulco-Taxco');
insert into Ruta values (4,'Chihuahua-Nvo. Leon');

insert into C_local values(1,'FedEx');
insert into C_local values(2,'U.S. Postal Service');
insert into C_local values(3,'DHL');
insert into C_local values(4,'Royal Mail');

insert into Camion values('123AU9',18000,'CDMX');
insert into Camion values('456PO2',20000,'Chihuahua');
insert into Camion values('789JH7',26000,'Nvo. Leon');
insert into Camion values('753BB9',30000,'Acapulco');

insert into Conductor values('POLK150889JK7','Luis Perez','Tajin #88, col. Narvarte, CDMX.');
insert into Conductor values('FTHU221195DE3','Hugo Flores','Av. 1 #3, col. Rios, Chihuahua,CHIH.');
insert into Conductor values('RUTS140870PL7','Tatiana Rios','Av. Insurgentes #15, col. Centro, Leon,GTO.');
insert into Conductor values('LPTU010191YY7','Teodoro Lopez','Av. Diamante #33, col. Arboledas, Acapulco,GRO.');

select * from Camion;

insert into Paquete values(1,'Torre BBVA, CDMX',500,'Bruce Banner','N');
insert into Paquete values(2,'Krispy Kream Nvo. Leon, MTY.',1500,'Homero Simpson','N');
insert into Paquete values(3,'Mansion Wayne, Ciudad Gotica',8000,'Bruce Wayne','I');
insert into Paquete values(4,'Cabana cuidador del bosque prohibido',10000,'Hagrid','I');
insert into Paquete values(5,'Secretaria de Salud, CDMX',5000,'Lopez Gatell','N');
insert into Paquete values(6,'Estrella #13 ',1500,'Chewbacca','N');
insert into Paquete values(7,'Rodeo Drive #77, L.A.,California',50000,'Dominic Toretto','I');
insert into Paquete values(8,'Nou Camp',1000,'Leo Messi','I');

insert into P_Nacional values('CDMX',1,'LPTU010191YY7');
insert into P_Nacional values('Nvo. Leon, MTY.',2,'RUTS140870PL7');
insert into P_Nacional values('Cristobal...Casas,Chiapas',5,'FTHU221195DE3');
insert into P_Nacional values('CDMX',6,'LPTU010191YY7');

insert into P_Internacional values('United Airlines',3,'04/14/2020',2);
insert into P_Internacional values('British airways',4,'04/14/2020',4);
insert into P_Internacional values('Aeromexico',7,'04/14/2020',2);
insert into P_Internacional values('Iberia',8,'04/14/2020',3);

insert into R_Conductor values(1,1,'POLK150889JK7');
insert into R_Conductor values(2,2,'LPTU010191YY7');
insert into R_Conductor values(3,3,'RUTS140870PL7');
insert into R_Conductor values(4,4,'FTHU221195DE3');

insert into Conductor_Camion values(1,'LPTU010191YY7','123AU9','04/14/2020');
insert into Conductor_Camion values(2,'RUTS140870PL7','456PO2','04/14/2020');
insert into Conductor_Camion values(3,'FTHU221195DE3','789JH7','04/14/2020');
insert into Conductor_Camion values(4,'LPTU010191YY7','753BB9','04/14/2020');

insert into Ruta_Nac values(1,1,1);
insert into Ruta_Nac values(2,2,2);
insert into Ruta_Nac values(3,5,3);
insert into Ruta_Nac values(4,6,4);

drop table Ruta_Nac;
drop table Conductor_Camion;
drop table R_Conductor;
drop table P_Internacional;
drop table P_Nacional;
drop table Paquete;
drop table Ruta;
drop table Conductor;
drop table Camion;
drop table C_local;