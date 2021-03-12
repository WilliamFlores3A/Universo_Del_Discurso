--Cursor que muestre el número de Reservas hechas el día actual--
do $$
declare
registro record;
cantidad int=0;
num int;
c_reserva cursor for select*from reserva where fecha_reserva=current_date;
begin
	for num in c_reserva
	loop cantidad = cantidad + count(num.fecha_reserva);
	end loop;
	
	open c_reserva;
	fetch c_reserva into registro;
	raise notice 'reservas: %', cantidad;
end $$
language 'plpgsql';