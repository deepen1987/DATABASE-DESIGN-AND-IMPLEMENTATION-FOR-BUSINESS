-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Table `ecommerce`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(64) NOT NULL,
  `last_name` VARCHAR(64) NOT NULL,
  `email_id` VARCHAR(150) NOT NULL,
  `phone_no` VARCHAR(15) NULL,
  `street` VARCHAR(60) NOT NULL,
  `city` VARCHAR(60) NOT NULL,
  `state` VARCHAR(6) NOT NULL,
  `zip_code` INT NOT NULL,
  `membership_flag` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email_id_UNIQUE` (`email_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`members` (
  `member_id` INT NOT NULL AUTO_INCREMENT,
  `membership_cost` DECIMAL(4,2) NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`member_id`),
  INDEX `fk_members_customers1_idx` (`customer_id` ASC) VISIBLE,
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_members_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `ecommerce`.`customers` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`non_members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`non_members` (
  `non_member_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`non_member_id`),
  INDEX `fk_non_members_customers1_idx` (`customer_id` ASC) VISIBLE,
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_non_members_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `ecommerce`.`customers` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`discounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`discounts` (
  `discount_id` INT NOT NULL AUTO_INCREMENT,
  `discount` INT NOT NULL,
  PRIMARY KEY (`discount_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`shipper`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`shipper` (
  `shipper_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`shipper_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`shipping` (
  `shipping_id` INT NOT NULL AUTO_INCREMENT,
  `tracking_id` VARCHAR(60) NOT NULL,
  `shipper_id` INT NOT NULL,
  PRIMARY KEY (`shipping_id`),
  INDEX `fk_shipping_shipper_id1_idx` (`shipper_id` ASC) VISIBLE,
  CONSTRAINT `fk_shipping_shipper_id`
    FOREIGN KEY (`shipper_id`)
    REFERENCES `ecommerce`.`shipper` (`shipper_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` DATETIME NOT NULL,
  `status` INT NOT NULL,
  `shipping_date` DATETIME NOT NULL,
  `shipping_id` INT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_orders_shipping1_idx` (`shipping_id` ASC) VISIBLE,
  UNIQUE INDEX `shipping_id_UNIQUE` (`shipping_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `ecommerce`.`customers` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shipping`
    FOREIGN KEY (`shipping_id`)
    REFERENCES `ecommerce`.`shipping` (`shipping_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`inventory` (
  `inventory_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `fk_inventory_categories1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_categories`
    FOREIGN KEY (`category_id`)
    REFERENCES `ecommerce`.`categories` (`category_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`order_items` (
  `order_quantity` INT NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  `order_id` INT NOT NULL,
  `inventory_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `inventory_id`),
  INDEX `fk_order_items_inventory1_idx` (`inventory_id` ASC) VISIBLE,
  UNIQUE INDEX `inventory_id_UNIQUE` (`inventory_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_items_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `ecommerce`.`orders` (`order_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_items_inventory`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `ecommerce`.`inventory` (`inventory_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`billing` (
  `bill_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `discount_id` INT NULL,
  `total_bill` DECIMAL(6,2) NOT NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `payment_total` DECIMAL(6,2) NOT NULL,
  `payment_date` DATETIME NOT NULL,
  `payment_status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bill_id`),
  INDEX `fk_billing_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_billing_orders1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_billing_discounts1_idx` (`discount_id` ASC) VISIBLE,
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_billing_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `ecommerce`.`customers` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_billing_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `ecommerce`.`orders` (`order_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_billing_discounts`
    FOREIGN KEY (`discount_id`)
    REFERENCES `ecommerce`.`discounts` (`discount_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`member_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`member_history` (
  `customer_id` INT NOT NULL,
  `old_status` VARCHAR(45) NOT NULL,
  `new_status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`),
  CONSTRAINT `fk_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `ecommerce`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
