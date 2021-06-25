CREATE TABLE pizza (
pizza_id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(32) NOT NULL,
date_available DATE NOT NULL,
price DECIMAL(4,2) NOT NULL,
PRIMARY KEY(pizza_id));

CREATE TABLE toppings (
topping_id INT NOT NULL AUTO_INCREMENT,
topping_name VARCHAR(64) NOT NULL,
pizza_id INT NULL,
PRIMARY KEY(topping_id),
FOREIGN KEY(pizza_id) REFERENCES pizza(pizza_id));


INSERT INTO pizza
VALUES (DEFAULT,
        "Plain",
        "2021-06-23",
        12.99),
        (DEFAULT,
        "Mediterranean",
        "2021-05-23",
        23.99),
        (DEFAULT,
        "Pepperoni",
        "2021-07-23",
        17.99),
        (DEFAULT,
        "Meat-Lovers",
        "2021-06-23",
        19.99);
        
SELECT * FROM pizza;

INSERT INTO toppings
VALUES (DEFAULT,
		"pepperoni",
        4),
		(DEFAULT,
        "Feta Cheese",
        4),
        (DEFAULT,
        "Olives",
        3),
        (DEFAULT,
        "salad",
        NULL),
		(DEFAULT,
        "onion",
        3),
        (DEFAULT,
        "chicken",
        5),
        (DEFAULT,
        "beef jerky",
        5);

SELECT * FROM toppings;


INSERT INTO toppings
VALUES (
		DEFAULT,
        "carrot",
        1);


SELECT * 
FROM pizza
JOIN toppings
USING (pizza_id);

SELECT
		p.name,
        p.date_available,
        t.topping_name
FROM pizza p
LEFT JOIN toppings t
USING (pizza_id)
ORDER BY p.date_available;

SELECT
		p.name,
        p.date_available,
        t.topping_name
FROM toppings t
RIGHT JOIN pizza p
USING (pizza_id)
ORDER BY p.date_available;



SELECT 
		t.topping_name,
        p.name
FROM toppings t
LEFT JOIN pizza p
ON t.pizza_id = p.pizza_id
ORDER BY t.topping_name DESC;

SELECT 
		t.topping_name,
        p.name
FROM pizza p 
RIGHT JOIN toppings t
ON p.pizza_id = t.pizza_id
ORDER BY t.topping_name DESC;


SELECT 
		p.name,
        t.topping_name
FROM pizza p
LEFT JOIN toppings t
USING (pizza_id)

UNION

SELECT 
		p.name,
        t.topping_name
FROM pizza p
RIGHT JOIN toppings t
USING (pizza_id);


SELECT 
		p.name,
        CONCAT("$",p.price) AS price
FROM pizza p;

SELECT 
		p.name,
        p.price AS actual_price,
        CONCAT("$",p.price - 1) AS discounted_price
FROM pizza p;


SELECT 
		CONCAT(t.topping_name," ( ",p.name,": ",p.price," )") AS "All Pizzas"
FROM pizza p
JOIN toppings t
USING (pizza_id);















