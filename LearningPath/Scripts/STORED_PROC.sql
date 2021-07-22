DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
	SELECT * 
	FROM invoice
	WHERE (invoice_total - payment_total) > 0;
END$$
DELIMITER ;

CALL get_invoices_with_balance;

DROP PROCEDURE IF EXISTS get_clients;


DROP PROCEDURE IF EXISTS get_client_by_state;

DELIMITER $$
CREATE PROCEDURE get_client_by_state
(
	state CHAR(2)
)
BEGIN
	IF state IS NULL THEN
		SET state = 'CA';
	END IF;
	SELECT * 
	FROM clients c
	WHERE c.state = state;
END$$
DELIMITER ;

CALL get_client_by_state('NY');


DROP PROCEDURE IF EXISTS get_invoices_by_client;

DELIMITER $$
CREATE PROCEDURE get_invoices_by_client
(
	client_id INT
)
BEGIN
	SELECT * 
	FROM invoices i
	WHERE i.client_id = client_id;
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS get_payments;

DELIMITER $$
CREATE PROCEDURE get_payments
(
	client_id INT,
    payment_method_id TINYINT
)
BEGIN
		SELECT * 
		FROM payments p
		WHERE 	p.client_id 		= IFNULL(client_id, p.client_id) AND 
				p.payment_method 	= IFNULL(payment_method_id, p.payment_method);
END$$
DELIMITER ;

call get_payments(NULL, NULL);


DROP PROCEDURE IF EXISTS make_payments;

DELIMITER $$
CREATE PROCEDURE make_payments
(
	invoice_id int,
    payment_amount DECIMAL (9, 2),
    payment_date DATE
)
BEGIN
	IF payment_amount <= 0 THEN
		SIGNAL SQLSTATE '22003' 
        SET MESSAGE_TEXT = 'Invalid Payment Amount';
    END IF;
    
    UPDATE invoices i 
    SET
		i.payment_total = payment_amount,
        i.payment_date = payment_date
	where i.invoice_id = invoice_id;
END$$
DELIMITER ;	





















