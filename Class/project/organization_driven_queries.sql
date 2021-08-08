SELECT 
		customer_id
FROM ecommerce.member_history
WHERE old_status = 'NO' AND new_status = 'YES';


SELECT 
		COUNT(order_id) AS order_count
FROM orders
WHERE order_id IN	(
						SELECT order_id
						FROM order_items
						GROUP BY order_id
						HAVING SUM(order_quantity) > 4
					);


