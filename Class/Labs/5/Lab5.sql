SELECT 
	us_dollars_to_currency_ratio 
FROM Currency c
JOIN Store_location sl
ON c.currency_id = sl.currency_accepted_id
WHERE sl.store_location_id = 12;

SELECT 
	product_name,
    CONCAT('£ ',ROUND(Price_in_us_dollars * (0.67),2)) AS `price`
FROM Sells s
JOIN product p
WHERE p.Product_id = 102 AND store_location_id = 12
GROUP BY p.Product_name;


SELECT 
	product_name,
    cONCAT('£ ',rOUND(PRice_in_us_dollars * 
				(
					SELECT Us_dollars_to_currency_ratio 
					FROM Currency c
					JOIN Store_location sl
					ON C.cUrrency_id = Sl.cUrrency_accepted_id
					WHERE Sl.sTore_location_id = 12
				),2)) AS `price`
FROM Sells s
JOIN Product p
WHERE P.pRoduct_id = 102 AND Store_location_id = 12
GROUP BY P.pRoduct_name;

SELECT 
		product_id,
		product_name,
        CONCAT('€ ',ROUND(price_in_us_dollars  * 
					(
					SELECT us_dollars_to_currency_ratio 
					FROM currency c
					WHERE c.currency_id = 4
                    ),2)) AS `price`
FROM product
WHERE  (price_in_us_dollars  * 
					(
					SELECT us_dollars_to_currency_ratio 
					FROM currency c
					WHERE c.currency_id = 4
                    )) > 300 OR 
(price_in_us_dollars  * 
					(
					SELECT us_dollars_to_currency_ratio 
					FROM currency c
					WHERE c.currency_id = 4
                    )) < 25; 

SELECT 
		DISTINCT an.name,
		product_id,
        p.product_name
FROM product p
JOIN Alternate_name an USING (product_id)
JOIN sells s USING (product_id)
WHERE s.product_id IN ( SELECT 
							product_id
						FROM class.Sells
						GROUP BY product_id
						HAVING COUNT(product_id) >= ( SELECT
														COUNT(store_location_id)
													  FROM Store_location
													)
					   );


SELECT 
		DISTINCT an.name,
		product_id,
        p.product_name
FROM (  SELECT 
			product_id
		FROM class.Sells
		GROUP BY product_id
		HAVING COUNT(product_id) >= ( SELECT
										COUNT(store_location_id)
									  FROM Store_location
									)
	   ) as `derived_product`
JOIN Product p using (product_id)
JOIN Alternate_name an USING (product_id)
JOIN sells s USING (product_id);


SELECT 
		DISTINCT an.name,
		s.product_id,
        p.product_name
FROM sells s
JOIN Alternate_name an USING (product_id)
JOIN product p USING (product_id)
WHERE EXISTS ( SELECT 
					s.product_id
				FROM sells s1
                WHERE s1.product_id = s.product_id
				GROUP BY s1.product_id
				HAVING COUNT(s1.product_id) >= ( SELECT
												COUNT(store_location_id)
											  FROM Store_location
											)
					   );



SELECT 
					s.product_id
				FROM sells s
				GROUP BY s.product_id
				HAVING COUNT(s.product_id) >= ( SELECT
												COUNT(store_location_id)
											  FROM Store_location
											)

















