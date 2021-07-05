select * 
from orders
where year(order_date) = year(now());

select concat(first_name, " ", last_name) as customer,
		ifnull(phone, "Unknown") as phone
from customers;