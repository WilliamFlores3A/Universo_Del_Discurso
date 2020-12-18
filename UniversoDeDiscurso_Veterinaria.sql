--Universidad Laica Eloy Alfaro de Manabí
--Flores Cedeño William Andres
--Materia: Gestión de base de datos
--Docente y colaborador: Ing. Robert Wilfrido Moreira Centeno, Mg

create table Cliente(
	CI_Cliente numeric(8) not null,
	Nombre char(256) not null,
	Apellido char(256) not null,
	Genero char(256) not null,
	Direccion char(256) not null,
	telefono numeric(8) not null,
	Fecha_Registro Date not null,
	Antiguedad numeric(8) null,
	Fecha_Ultima_Visita Date  null,
	Num_Mascotas numeric (8) not null,
	constraint PK_Cliente primary key (CI_Cliente)
);

create table Mascota(
	ID_Mascota	Numeric(8) not null,
	Nombre_Mascota char(256) not null,
	Fecha_Nacimiento Date not null,
	Genero_Mascota char(256) not null,
	Mascota_Color char(256) not null,
	Mascota_Esterilizada char(256) not null,
	CI_Cliente numeric(8) not null,
	ID_Reserva Numeric(8) null,
	ID_Vacuna Numeric(8)  null,
	ID_Consulta Numeric(8) not null,
	constraint PK_Mascota primary key (ID_Mascota)
);

create table Reserva(
	ID_Reserva Numeric(8) not null,
	Fecha_Reserva Date not null,
	Descripcion char(256) not null,
	constraint PK_Reserva primary key (ID_Reserva)
);

create table Consulta(
	ID_Consulta Numeric(8) not null,
	Fecha_Consulta Date not null,
	Sintomas char(256) not null,
	Diagnostico char(256) not null,
	ID_Veterinario Numeric(8) not null,
	constraint PK_Consulta primary key (ID_Consulta)
);

create table Vacuna(
	ID_Vacuna Numeric(8) not null,
	Fecha_Programada Date not null,
	Fecha_Aplicada Date not null,
	ID_Veterinario Numeric(8) not null,
	ID_Detalle_Vacuna Numeric(8) not null,
	constraint PK_Vacuna primary key (ID_Vacuna)
);

create table Detalle_Vacuna(
	ID_Detalle_Vacuna Numeric(8) not null,
	Vacuna_Dosis char(256) not null,
	Vacuna_Nombre char(256) not null,
	constraint PK_Detalle_Vacuna primary key (ID_Detalle_Vacuna)
);

create table Veterinario(
	ID_Veterinario numeric(8) not null,
	Veterinario_Nombre char(256) not null,
	constraint PK_Veterinario primary key (ID_Veterinario)
);

create table Venta(
	ID_Venta numeric(8) not null,
	CI_Cliente numeric(8) not null,
	Fecha_Venta Date not null,
	constraint PK_Venta primary key (ID_Venta)
);

create table Detalle_Venta(
	ID_VentaDetalle numeric(8) not null,
	ID_Venta numeric(8)not null,
	ID_Producto numeric(8)not null,
	Descripcion_Venta char(256) not null,
	Cantidad_Venta numeric(8) null,
	Costo_Venta numeric(8) null,
	constraint PK_Detalle_Venta primary key (ID_VentaDetalle)
);

create table Producto(
	ID_Producto numeric(8) not null,
	Descripcion_Producto char(256) not null,
	Costo_Producto numeric(8) not null,
	Precio_Producto numeric(8) not null,
	Inventario numeric(8) not null,
	constraint PK_Producto primary key (ID_Producto)
);

create table Compra_Detalle(
	ID_CompraDetalle numeric(8)not null,
	ID_Producto numeric(8) not null,
	ID_Compra numeric(8)not null,
	Descripcion_Compra char(256) not null,
	Cantidad_Compra numeric(8) null,
	Costo_Compra numeric(8) null,
	constraint PK_Compra_Detalle primary key (ID_CompraDetalle)
);

create table Compra(
	ID_Compra numeric(8) not null,
	ID_Proveedor numeric(8) not null,
	Fecha_Compra Date not null,
	constraint PK_Compra primary key (ID_Compra)
);

create table Proveedor(
	ID_Proveedor numeric(8) not null,
	Nombre_Proveedor char(256) not null,
	Apellido_Proveedor char(256) not null,
	Telefono_Proveedor numeric(8) not null,
	Direccion_Proveedor char(256) not null,
	constraint PK_Proveedor primary key (ID_Proveedor)
);

alter table Vacuna
	add constraint FK_Vacuna_DetalleVacuna foreign key (ID_Detalle_Vacuna)
	references Detalle_Vacuna (ID_Detalle_Vacuna)
	on delete restrict on update restrict;
	
alter table Vacuna
	add constraint FK_Vacuna_Veterinario foreign key (ID_Veterinario)
	references Veterinario (ID_Veterinario)
	on delete restrict on update restrict;
	
alter table Mascota
	add constraint FK_Mascota_Vacuna foreign key (ID_Vacuna)
	references Vacuna (ID_Vacuna)
	on delete restrict on update restrict;

alter table Consulta
	add constraint FK_Consulta_Veterinario foreign key (ID_Veterinario)
	references Veterinario (ID_Veterinario)
	on delete restrict on update restrict;

alter table Mascota
	add constraint FK_Mascota_Consulta foreign key (ID_Consulta)
	references Consulta (ID_Consulta)
	on delete restrict on update restrict;
	
alter table Mascota
	add constraint FK_Mascota_Reserva foreign key (ID_Reserva)
	references Reserva (ID_Reserva)
	on delete restrict on update restrict;
	
alter table Mascota
	add constraint FK_Mascota_Cliente foreign key (CI_Cliente)
	references Cliente (CI_Cliente)
	on delete restrict on update restrict;
	
alter table Venta
	add constraint FK_Venta_Cliente foreign key (CI_Cliente)
	references Cliente (CI_Cliente)
	on delete restrict on update restrict;
	
alter table Detalle_Venta
	add constraint FK_DetalleVenta_Venta foreign key (ID_Venta)
	references Venta (ID_Venta)
	on delete restrict on update restrict;
	
alter table Detalle_Venta
	add constraint FK_DetalleVenta_Producto foreign key (ID_Producto)
	references Producto (ID_Producto)
	on delete restrict on update restrict;
	
alter table Compra_Detalle
	add constraint FK_CompraDetalle_Producto foreign key (ID_Producto)
	references Producto (ID_Producto)
	on delete restrict on update restrict;

alter table Compra_Detalle
	add constraint FK_CompraDetalle_Compra foreign key (ID_Compra)
	references Compra (ID_Compra)
	on delete restrict on update restrict;

alter table Compra
	add constraint FK_Compra_Proveedor foreign key (ID_Proveedor)
	references Proveedor (ID_Proveedor)
	on delete restrict on update restrict;

insert into Veterinario values (00000001,'William Flores');
insert into Veterinario values (00000002,'Agustin Intriago');

insert into Detalle_Vacuna values (00000001,'2ml','Rabia');
insert into Detalle_Vacuna values (00000002,'1ml','Moquillo');

insert into Cliente values (00000001,'Andres Carlos','Gonzales Cedeño','Masculino','Manta Av.24 calle 13',09949460,'18/12/2020',0,'18/12/2020',2);
insert into Cliente values (00000002,'Sergio Ivan','Zabala Intriago','Masculino','Manta Av.12 calle 118',09949467,'11/12/2020',0,'11/12/2020',1);

insert into Reserva values (00000001,'23/12/2020','La mascota Sabrina tiene una cita apartada');


insert into Vacuna values (00000001,'18/12/2020','18/12/2020',00000001,00000002);
insert into Vacuna values (00000002,'11/12/2020','11/12/2020',00000002,00000001);

insert into Consulta values (00000001,'18/12/2020','No presento sintomas','llevarla a pasear',00000001);
insert into Consulta values (00000002,'11/12/2020','Cansancio','Dejarle descansar',00000002);

insert into Mascota values (00000001,'Sabrina','25/11/2019','Femenino','Verde','No',00000001,00000001,00000002,00000001);
insert into Mascota values (00000002,'Patrack','15/10/2018','Masculino','Blanco','No',00000001,00000001,00000001,00000001);
insert into Mascota values (00000003,'Dorotea','20/12/2016','Femenino','Negro','Si',00000002,00000001,00000001,00000002);

insert into Venta values (00000001,00000001,'18/12/2020');
insert into Venta values (00000002,00000002,'11/12/2020');

insert into Producto values (00000001,'Juguete de perro',12,13,20);
insert into Producto values (00000002,'Juguete de Loro',24,25,20);

insert into Detalle_Venta values (00000001,00000001,00000002,'esta es la descripcion 1',1,25);
insert into Detalle_Venta values (00000002,00000002,00000001,'Buen dia',1,13);

insert into Proveedor values (00000001,'Don Borito','Zambrano Zambrano',09949460,'AV.2 calle 45'); 

insert into Compra values (00000001,00000001,'28/11/2020');

insert into Compra_Detalle values (00000001,00000001,00000001,'Reabastecimiento de stock',1,12);
insert into Compra_Detalle values (00000002,00000002,00000001,'Reabastecimiento de stock',1,24);

--Cantidad de veces que cada cliente ha visitado el centro.--
	SELECT
	  cliente.ci_cliente as identificacion, 
	  cliente.nombre, 
	  mascota.nombre_mascota, 
	  vacuna.fecha_aplicada as Dia_de_vacunacion, 
	  consulta.fecha_consulta, 
	  cliente.fecha_registro, 
	  venta.fecha_venta
	FROM 
	public.mascota
	  INNER JOIN public.cliente ON cliente.ci_cliente = mascota.ci_cliente
	  INNER JOIN public.consulta ON consulta.id_consulta = mascota.id_consulta 
	  INNER JOIN public.reserva ON reserva.id_reserva = mascota.id_reserva
	  INNER JOIN public.vacuna ON vacuna.id_vacuna = mascota.id_vacuna 
	  INNER JOIN public.venta ON venta.ci_cliente = cliente.ci_cliente
	WHERE 
	 cliente.ci_cliente = '00000001';
 
--Cantidad de vacunas que una mascota ha tenido. --	
  SELECT 
  cliente.nombre as Dueño, 
  mascota.nombre_mascota, 
  vacuna.fecha_aplicada, 
  vacuna.id_vacuna, 
  vacuna.id_detalle_vacuna,
  detalle_vacuna.vacuna_nombre as Vacuna
  FROM 
  public.mascota 
	  INNER JOIN public.cliente ON cliente.ci_cliente = mascota.ci_cliente
	  INNER JOIN public.vacuna ON vacuna.id_vacuna = mascota.id_vacuna
	  INNER JOIN public.veterinario ON veterinario.id_veterinario = vacuna.id_veterinario
	  INNER JOIN public.detalle_vacuna ON vacuna.id_detalle_vacuna = detalle_vacuna.id_detalle_vacuna
  WHERE 
  mascota.id_mascota = '00000002';
  
--Cantidad de vacunas que cada veterinario ha puesto.--
  SELECT 
  	veterinario.veterinario_nombre, 
  	vacuna.id_vacuna,
  	vacuna.fecha_aplicada, 
  	detalle_vacuna.vacuna_nombre as Vacuna
  FROM 
  public.mascota
    inner join public.vacuna on vacuna.id_vacuna = mascota.id_vacuna
    inner join public.veterinario on veterinario.id_veterinario = vacuna.id_veterinario
    inner join public.detalle_vacuna ON vacuna.id_detalle_vacuna = detalle_vacuna.id_detalle_vacuna
  WHERE 
  veterinario.id_veterinario = '00000002';
  