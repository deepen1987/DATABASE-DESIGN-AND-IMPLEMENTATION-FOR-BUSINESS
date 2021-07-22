EXPLAIN SELECT * 
FROM customers 
WHERE state = 'CA';

CREATE INDEX 
		idx_state 
ON customers (state);

EXPLAIN SELECT customer_id 
FROM customers
WHERE points > 1000;

CREATE INDEX
		idx_points
ON customers (points);


SHOW INDEX IN customers;

ANALYZE TABLE customers;


SELECT * 
FROM posts
WHERE title LIKE '%react redux%' OR
		body LIKE '%react redux%';
        
CREATE FULLTEXT INDEX idx_title_body ON posts (title, body);

SELECT *, MATCH (title, body) AGAINST('react redux') 
FROM posts
WHERE MATCH (title, body) AGAINST('react redux');

CREATE INDEX idx_state_points ON customers (state, points);
EXPLAIN SELECT * 
FROM customers
WHERE state = 'CA' AND points > 1000;

SHOW INDEX IN customers;

DROP INDEX idx_points ON customers;

SHOW INDEX IN customers;
EXPLAIN SELECT customer_id
FROM customers
ORDER BY state, first_name, points;

SHOW STATUS LIKE 'last_query_cost'







