USE sql_store;

-- Return all the products name, unit price and new price(unit price * 1.1)

select 
	name, 
    unit_price, 
    (unit_price * 1.1) as new_price 
from products;

-- Get the orders placed this year

select * from orders 
	where order_date >= '2019-01-01' 
	and order_date < '2019-01-01';
    

select * 
from order_items 
where order_id = 6 
and (unit_price * quantity) > 30;

select * 
from products
where quantity_in_stock in (49,38,72);

select * 
from customers
where birth_date between '1990-01-01' and '2000-01-01';

select * 
from customers
where address like '%trail%' or 
	  address like '%avenue%';
      
select *
from customers
where first_name regexp 'elka|ambur';

select *
from customers
where last_name regexp 'ey$|on$';

select *
from customers
where last_name regexp '^my|se';

select *
from customers
where last_name regexp 'b[re]';

select *
from orders
where shipped_date is not NULL;

select *
from order_items
where order_id = 2
order by product_id;

select *
from customers
order by points desc
limit 3
