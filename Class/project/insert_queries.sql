INSERT INTO discounts
VALUES (DEFAULT, 10);

INSERT INTO shipper
VALUES	(DEFAULT, 'Fedex'),
		(DEFAULT, 'UPS');
        
INSERT INTO categories
VALUES	(DEFAULT, 'Snow'),
		(DEFAULT, 'Rain'),
        (DEFAULT, 'Summer');
        
call ecommerce.add_customer('Neha', 'Bais', 'nb@nb.com', '12340987', 'halwa', 'boston', 'MA', 12345, 'YES');
call ecommerce.add_customer('Deep', 'Shek', 'ds@ds.com', '65748931', 'biryani', 'Boston', 'MA', 12345, 'NO');
call ecommerce.add_customer('Tom', 'Hanks', 'TH@th.com', '64674892', 'South Street', 'Marlborough', 'MA', 98765, 'YES');
call ecommerce.add_customer('Scarlet', 'Johnson', 'sj@sj.com', '56453219', 'random', 'Westborough', 'MA', 65742, 'NO');
call ecommerce.add_customer('Captain', 'America', 'ca@ca.com', '46897123', 'marvel', 'Wakanda', 'MA', 01545, 'NO');
call ecommerce.add_customer('Kang', 'Conqurer', 'kc@kc.com', '75648944', 'TVA', 'Boston', 'MA', 01545, 'YES');
call ecommerce.add_customer('Kungfu', 'Panda', 'kp@kp.com', '75648944', 'Disney', 'Boston', 'MA', 01545, 'YES');


call ecommerce.add_inventory('MICHELIN', 100, 75, 1);
call ecommerce.add_inventory('Cooper Tiers', 100, 57, 2);
call ecommerce.add_inventory('Bridgestone', 100, 68, 3);
call ecommerce.add_inventory('Yokohama', 100, 73, 3);

INSERT INTO orders
VALUES	(default, 3, CURDATE(), 0, CURDATE(), NULL);
INSERT INTO orders
VALUES	(default, 4, CURDATE(), 0, CURDATE(), NULL);
INSERT INTO orders
VALUES	(default, 5, CURDATE(), 0, CURDATE(), NULL);
INSERT INTO orders
VALUES	(default, 6, CURDATE(), 0, CURDATE(), NULL);
INSERT INTO orders
VALUES	(default, 7, CURDATE(), 0, CURDATE(), NULL);


call ecommerce.add_order_items(4, 2, 1);
call ecommerce.add_order_items(4, 3, 2);
call ecommerce.add_order_items(4, 4, 3);
call ecommerce.add_order_items(4, 5, 1);
call ecommerce.add_order_items(4, 3, 3);
call ecommerce.add_order_items(4, 4, 1);
call ecommerce.add_order_items(4, 6, 1);
call ecommerce.add_order_items(4, 6, 3);

update customers 
set membership_flag = 'NO'
where customer_id = 8;

insert into shipping
values 
		(default, 'XYZ1234NBC', 1),
        (default, 'XYZ4567NBC', 1),
        (default, 'XYZ7894NBC', 2),
        (default, 'XYZ5465NBC', 2),
        (default, 'XYZ5555NBC', 1);

update orders
set shipping_id = 1
where order_id = 2;
update orders
set shipping_id = 2
where order_id = 3;
update orders
set shipping_id = 3
where order_id = 4;
update orders
set shipping_id = 4
where order_id = 5;        
update orders
set shipping_id = 5
where order_id = 6;


update customers 
set membership_flag = 'YES'
where customer_id = 7;

