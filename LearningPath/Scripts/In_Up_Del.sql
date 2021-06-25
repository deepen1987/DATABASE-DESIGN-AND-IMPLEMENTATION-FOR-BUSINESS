Insert into customers
values (
		default,
        'Deependrasingh',
        'Shekhawat',
        '19870820',
        null,
        'Audubon',
        'shrewsbury',
        'MA',
        default);
        
select * from customers;

Insert into shippers (name)
values ('FedEx'),
	   ('UPS'),
       ('AirOne');
       
select * from shippers;

Insert into products
values (default,
		'inspiron',
        77,
        8.91),
        (default,
		'xps',
        21,
        1.91),
        (default,
		'Alienware',
        81,
        9.42);
   
--  Inserting in multiple tables in a hirarchical relationship Parent - Child
insert into orders (customer_id, order_date, status)
values (1, '2021-03-31', 1);

insert into order_items
values (last_insert_id(),1,1,2.5),
	   (last_insert_id(),2,1,2.9);
        
-- copy table from another table
create table orders_archieved as 
select * from orders;


CREATE TABLE invoices_archieved AS
SELECT i.invoice_id,
	   i.number,
       c.name,
       i.invoice_total,
       i.payment_total,
       i.invoice_date,
       i.due_date,
       i.payment_date
FROM invoices i
JOIN clients c 
	USING (client_id)
WHERE payment_date IS NOT NULL ;

--  Updating single row
UPDATE invoices
SET 
	payment_total = 10, 
    payment_date = '2019-06-04'
WHERE invoice_id = 1;


UPDATE customers
SET	
	points = points + 50
WHERE birth_date < '1990-01-01';

SELECT * 
FROM customers
WHERE birth_date < '1990-01-01';

UPDATE orders
SET
	comments = 'Gold'
WHERE customer_id IN
				(SELECT customer_id 
                FROM customers
                WHERE points > 3000);
                
select * from orders;





    