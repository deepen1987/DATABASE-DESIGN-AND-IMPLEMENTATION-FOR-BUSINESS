SELECT 
    'First half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM
    invoices
WHERE
    invoice_date BETWEEN '2019-01-01' AND '2019-06-30' 
UNION SELECT 
    'Second half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM
    invoices
WHERE
    invoice_date BETWEEN '2019-07-01' AND '2019-12-31' 
UNION SELECT 
    'TOTAL' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM
    invoices;

SELECT 
    p.date,
    pm.name AS payment_method,
    SUM(p.amount) AS total_payments
FROM
    payments p
        JOIN
    payment_methods pm ON p.payment_method = pm.payment_method_id
GROUP BY p.date , p.payment_method
ORDER BY p.date;


SELECT 
    c.customer_id,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM
    customers c
        JOIN
    orders o USING (customer_id)
        JOIN
    order_items oi USING (order_id)
WHERE
    c.state = 'VA'
GROUP BY c.customer_id
HAVING total_spent > 100;


SELECT 
    pm.name, SUM(p.amount)
FROM
    payments p
        JOIN
    payment_methods pm ON p.payment_method = pm.payment_method_id
GROUP BY pm.name WITH ROLLUP;























