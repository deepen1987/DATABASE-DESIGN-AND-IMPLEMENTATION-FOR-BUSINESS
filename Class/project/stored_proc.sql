USE `ecommerce`;
DROP PROCEDURE IF EXISTS `ecommerce`.`add_inventory`;
DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_inventory`(
    name VARCHAR(45),
    quantity INT,
    unit_price DECIMAL(4,2),
    category_id INT
)
BEGIN
INSERT INTO inventory
VALUES	(
			default,
            name,
            quantity,
            unit_price,
            category_id
		);
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS `ecommerce`.`add_customer`;
DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_customer`(
    firstn varchar(64),
    lastn varchar(64),
    email varchar(150),
    phone varchar(15),
    street varchar(60),
    city varchar(60),
    state varchar(5),
    zip_code int,
    flag varchar(5)
)
BEGIN
	insert into customers
    values	(
				default,
                firstn,
                lastn,
                email,
                phone,
                street,
                city,
                state,
                zip_code,
                flag
            );
END$$

DELIMITER ;


DROP procedure IF EXISTS `generate_bill`;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_bill`(
    customer_id INT,
    order_id INT,
    discountid INT,
    total DECIMAL(6,2),
    payment_method VARCHAR(45),
    payment_total DECIMAL(6,2),
    payment_date DATETIME,
    payment_status VARCHAR(45)
)
BEGIN

	INSERT INTO billing
    VALUES	(
					default,
					customer_id,
					order_id,
					discountid,
					total,
					payment_method,
					payment_total,
					payment_date,
					payment_status
            );
END$$

DELIMITER ;



DROP procedure IF EXISTS `ecommerce`.`add_order_items`;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_order_items`
(
	qty INT,
    order_id INT,
    inv_id INT
)
BEGIN
	DECLARE price DECIMAL(4,2);
    
	SELECT unit_price
    INTO price
    FROM inventory
    WHERE inventory_id = inv_id;
    
    INSERT INTO order_items
    VALUES (qty, price, order_id, inv_id);
END$$

DELIMITER ;



