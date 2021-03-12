--ALMACENADO que devuelva el precio de un producto según su id--


create or replace function BuscarPrecio(numeric) returns numeric
as
$$
select precio_producto from producto
where id_producto =$1
$$
language sql