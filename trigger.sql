--Cursor que muestre el número de Reservas hechas el día actual--

--Creacion de la funcion trigger--
Create or replace function tg_reserva() returns trigger 
as
$res$
	declare --Declaramos variables--
		fecha_actual date;
		tg_limite int;
		Reservas_actuales int;
begin --Comenzamos el bloque--
	select current_date into fecha_actual from current_date;
	select limite_cantidad into tg_limite from limite;
	select count(*) into Reservas_actuales from reserva where fecha_reserva=new.fecha_reserva;
	
	if (new.fecha_reserva < fecha_actual) then --La fecha ingresada es menor a la fecha actual?--
		raise exception 'la fecha ingresada es invalida';
	end if;
	
	if (Reservas_actuales = tg_limite) then --El numero de reservas en una determinada fecha es igual al limite de reservas?--
		raise exception 'El limite reservas ya a sido alcanzado';
	end if;
	return new;
end;--Finalizamos el bloque--
$res$
language plpgsql; --Especificamos el lenguaje a usar--

--Creacion del trigger--
create trigger tg_reserva before insert or update on reserva
for each row execute procedure tg_reserva();

select*from reserva
insert into Reserva values (00000019,'12/03/2021','17:34:00',00000001,'La mascota Sabrina tiene una cita apartada');