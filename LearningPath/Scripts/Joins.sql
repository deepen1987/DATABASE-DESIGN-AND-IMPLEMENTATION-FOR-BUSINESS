select order_id, oi.product_id, p.name, quantity, oi.unit_price 
from order_items oi
join products p
on oi.product_id = p.product_id;

select * 
from order_items oi
join sql_inventory.products p
on p.product_id = oi.product_id;

select e.employee_id, e.first_name, m.first_name as manager
from sql_hr.employees e
join sql_hr.employees m
	on e.reports_to = m.employee_id;
    
-- Self Join

select 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name as status
from orders o
join customers c
	on o.customer_id = c.customer_id
join order_statuses os
	on o.status = os.order_status_id;
    
use sql_invoicing;

select 
	p.payment_id,
    pm.name as payment,
    i.payment_total,
    c.name as client_name
from payments p
join payment_methods pm
	on p.payment_method = pm.payment_method_id
join invoices i
	on p.invoice_id = i.invoice_id
join clients c
	on p.client_id = c.client_id;

-- Compound Join condition
use sql_store;

select * 
from order_items oi
join order_item_notes oin
	on oi.order_id = oin.order_id
    and oi.product_id = oin.product_id;
    
-- Outer Join

select 
	p.product_id,
    p.name,
    oi.quantity,
    o.order_date
from products p
left join order_items oi
	on p.product_id = oi.product_id
left join orders o
	on o.order_id = oi.order_id;
    
select 
	o.order_date,
    o.order_id,
    c.first_name first_name,
    sh.name as shipper,
    os.name as status
from orders o
join customers c
	on o.customer_id = c.customer_id
left join shippers sh
	on o.shipper_id = sh.shipper_id
join order_statuses os
	on o.status = os.order_status_id
order by o.order_date;

-- USING clause

select * 
from order_items oi
join order_item_notes oin
	using (order_id, product_id);
    
select 
	p.date,
    c.name as client,
    p.amount,
    pm.name as payment_method
from payments p
join clients c 	using (client_id)
join payment_methods pm
	on p.payment_method = pm.payment_method_id;
    
--  cross join

select * 
from shippers, products;

select *
from shippers sh
cross join products p;

--  Unions

select 
	order_id,
    order_date,
    'Active' as status
from orders
where order_date >= '2019-01-01'
UNION
select 
	order_id,
    order_date,
    'Inactive' as status
from orders
where order_date <= '2019-01-01';


select 
	customer_id,
    first_name,
    points,
    'Gold' as type
from customers
where points >= 3000
UNION
select 
	customer_id,
    first_name,
    points,
    'Silver' as type
from customers
where points >= 2000 and points < 3000
UNION
select 
	customer_id,
    first_name,
    points,
    'Bronze' as type
from customers
where points < 2000
order by first_name