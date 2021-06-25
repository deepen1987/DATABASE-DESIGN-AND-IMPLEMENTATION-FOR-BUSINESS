SELECT 
    *
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees);
            
-- subqueries with IN

SELECT * 
FROM clients
WHERE client_id NOT IN (
	SELECT 
    DISTINCT client_id 
    FROM invoices
);


SELECT 
    *
FROM
    customers
WHERE
    customer_id IN (SELECT DISTINCT
            customer_id
        FROM
            orders
        WHERE
            order_id IN (SELECT 
                    order_id
                FROM
                    order_items
                WHERE
                    product_id = 3));

SELECT DISTINCT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    customers c
        JOIN
    orders o USING (customer_id)
        JOIN
    order_items oi USING (order_id)
WHERE
    oi.product_id = 3;

SELECT * 
FROM invoices i
WHERE invoice_total > (
	SELECT 
		AVG(invoice_total)
	FROM invoices
    WHERE client_id = i.client_id    
);


SELECT * 
FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    FROM order_items
    WHERE product_id = p.product_id
);


SELECT 
	client_id,
    name,
    (SELECT SUM(invoice_total) FROM invoices WHERE c.client_id = client_id) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices) AS average,
    (SELECT total_sales - (SELECT average)) AS difference
FROM clients c





























