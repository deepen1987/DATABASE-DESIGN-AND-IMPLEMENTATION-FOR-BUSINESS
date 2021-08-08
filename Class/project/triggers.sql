DROP TRIGGER IF EXISTS update_billing_from_order_items;

DELIMITER $$
CREATE TRIGGER update_billing_from_order_items
	AFTER INSERT ON order_items
    FOR EACH ROW
BEGIN
	DECLARE total DECIMAL(6,2);
    DECLARE dis_count INT;
    DECLARE dis_count_id INT;
    
    select discount_id 
    INTO dis_count_id
    from billing 
    where order_id = New.order_id;
    
    SELECT SUM(unit_price * order_quantity) 
    INTO total
    FROM order_items 
    WHERE order_id = NEW.order_id;
    
	UPDATE billing
    SET total_bill = total
    WHERE order_id = NEW.order_id;
    
	IF  dis_count_id IS NULL THEN
		UPDATE billing
		SET payment_total = total
        WHERE order_id = NEW.order_id;
	ELSE
		SELECT discount
		INTO dis_count
		FROM discounts;
            
		UPDATE billing
		SET payment_total = total - ((total * dis_count) / 100)
        WHERE order_id = NEW.order_id;
	END IF;
END$$
DELIMITER ;



DROP TRIGGER IF EXISTS update_membership_change;

DELIMITER $$
CREATE TRIGGER update_membership_change
	AFTER UPDATE ON customers
    FOR EACH ROW
BEGIN
	IF OLD.membership_flag != NEW.membership_flag THEN
		IF NEW.membership_flag = 'NO' THEN
			DELETE FROM members WHERE customer_id = NEW.customer_id;
            
			INSERT INTO non_members
			VALUES (default, NEW.customer_id); 
		END IF;
		IF NEW.membership_flag = 'YES' THEN
			DELETE FROM non_members WHERE customer_id = NEW.customer_id;
            
			INSERT INTO members
			VALUES (default, 70, NEW.customer_id); 
		END IF;
        
        INSERT INTO member_history VALUES (NEW.customer_id, 
        OLD.membership_flag, NEW.membership_flag);
	END IF;    
END$$
DELIMITER ;



DROP TRIGGER IF EXISTS update_billing_from_orders;

DELIMITER $$
CREATE TRIGGER update_billing_from_orders
	AFTER INSERT ON orders
    FOR EACH ROW
BEGIN
	DECLARE flag VARCHAR(5);
    DECLARE coupon INT;
    DECLARE dates DATE;
    
    SET dates = CURDATE();
    
    SELECT membership_flag
    INTO flag
    FROM customers
    WHERE customer_id = NEW.customer_id;
    
    IF flag = 'yes' THEN 
		SELECT discount_id
		INTO coupon
		FROM discounts;
    END IF;
    
    CALL generate_bill(NEW.customer_id, NEW.order_id, coupon, 0, 
    'Credit Card', 0, dates, 'NO');
    
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS insert_members;

DELIMITER $$
CREATE TRIGGER insert_members
	AFTER INSERT ON customers
    FOR EACH ROW
BEGIN
	IF NEW.membership_flag = 'YES' THEN
		INSERT INTO members
        VALUES (default, 70, NEW.customer_id);
	ELSE
		INSERT INTO non_members
        VALUES (default, NEW.customer_id);
    END IF;
END $$
DELIMITER ;


