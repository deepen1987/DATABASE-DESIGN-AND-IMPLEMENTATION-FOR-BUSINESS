SELECT * 
FROM orders
WHERE YEAR(order_date) = YEAR(NOW());

SELECT CONCAT(first_name, " ", last_name) AS customer,
		IFNULL(phone, "Unknown") AS phone
FROM customers;

SELECT 
		product_id,
        name,
        COUNT(*) AS orders,
        IF(COUNT(*) > 1, "Many Times", "Once") AS frequency
FROM products p
JOIN order_items os USING (product_id)
GROUP BY product_id, name;

SELECT
		CONCAT(first_name, " ", last_name) AS customer,
        points,
        CASE
			WHEN points > 3000 THEN "GOLD"
            WHEN points > 2000 AND points < 3000 THEN "SILVER"
            ELSE "BRONZE"
		END AS category
FROM customers
ORDER BY points DESC;

select * 
from customers
cross 


















