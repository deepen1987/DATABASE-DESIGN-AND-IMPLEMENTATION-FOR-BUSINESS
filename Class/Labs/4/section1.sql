
CREATE TABLE IF NOT EXISTS `person`
(
	`person_id` INT(12) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    `username` VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS `post`
(
	`post_id` INT(12) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `person_id` INT(12) NOT NULL,
    `content` VARCHAR(255) NOT NULL,
    `created_on` DATE NOT NULL,
    `summary` VARCHAR(15) NOT NULL,
    CONSTRAINT `fk_person_id` FOREIGN KEY(`person_id`) REFERENCES `person`(`person_id`)
);

CREATE TABLE IF NOT EXISTS `likes`
(
	`likes_id` INT(12) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `person_id` INT(12) NOT NULL,
    `post_id` INT(12) NOT NULL,
    `liked_on` DATE,
    CONSTRAINT `fk1_person_id` FOREIGN KEY(`person_id`) REFERENCES `person`(`person_id`),
    CONSTRAINT `fk_post_id` FOREIGN KEY(`post_id`) REFERENCES `post`(`post_id`)
);

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO `person`
VALUES
		(
        DEFAULT,
        'John',
        'Cena',
        'john5678'
        ),
        (
        DEFAULT,
        'Dave',
        'Batista',
        'db9870'
        ),
        (
        DEFAULT,
        'Captain',
        'America',
        'CA2021'
        ),
        (
        DEFAULT,
        'Scarlet',
        'Johnson',
        'sjbw2019'
        ),
        (
        DEFAULT,
        'Deependrasingh',
        'Shekhawat',
        'deep1234'
        );
        
SELECT * FROM person;

INSERT INTO `post`
VALUES
		(
		DEFAULT,
        1,
        'WWE had a huge influence over my life',
        '2011-02-02',
        'WWE had a hu...'
        ),
        (
		DEFAULT,
        1,
        'WWE made a star out of me thank you for your support',
        '2012-02-02',
        'WWE made a s...'
        ),
        (
		DEFAULT,
        3,
        'Buckys role was excellently played by...',
        '2011-02-02',
        'Buckys role ...'
        ),
        (
		DEFAULT,
        3,
        'Hail Hydra was a quick thought in last avenger',
        '2020-02-02',
        'Hail hydra w...'
        ),
        (
		DEFAULT,
        4,
        'Avengers was the best movies series I worked in',
        '2021-02-02',
        'Avengers was...'
        ),
        (
		DEFAULT,
        4,
        'The character of Black Widow was a tough one',
        '2018-02-02',
        'The characte...'
        ),
        (
		DEFAULT,
        5,
        'Boston is one of the oldest cities in US',
        '2019-02-02',
        'Boston is on...'
        ),
        (
		DEFAULT,
        5,
        'Boston has the best beer in New England',
        '2019-02-02',
        'Boston has t...'
        );
        
	
SELECT * FROM post;


INSERT INTO likes
VALUES 
		(
		DEFAULT,
        2,
        1,
        '2011-03-03'
        ),
        (
		DEFAULT,
        1,
        4,
        '2020-03-03'
        ),
        (
		DEFAULT,
        4,
        8,
        '2019-03-03'
        ),
        (
		DEFAULT,
        4,
        6,
        '2018-03-03'
        );

SELECT * FROM likes;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
drop procedure if exists add_zana_sage;
delimiter $$
create procedure add_zana_sage()
begin
insert into person
values
		(
        6,
        'Zana',
        'Sage',
        'z_sage'
        );
end$$
delimiter;

call add_zana_sage();

select * from person;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
call add_zana_sage();

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
DROP procedure IF EXISTS `add_person`;
DELIMITER $$
CREATE PROCEDURE `add_person` 
(
	f_name varchar(32),
    l_name varchar(32),
    u_name varchar(20)
)
BEGIN
insert into person 
values
		(
        default,
		f_name,
        l_name,
        u_name
        );
END$$

DELIMITER ;

call add_person('The','Rock','t_rock');

select * from person;

delete from person where person_id = 8;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
DROP PROCEDURE add_post;
DELIMITER $$
CREATE PROCEDURE add_post
(
	p_id INT,
    contents VARCHAR(255),
    c_date DATE
)
BEGIN
	DECLARE agg_summary VARCHAR(15);
	SET agg_summary = CONCAT(SUBSTRING(contents,1,12),'...');
INSERT INTO post
VALUES 
		(
        DEFAULT,
        p_id,
        contents,
        c_date,
        agg_summary
        );
END$$

DELIMITER ;
CALL add_post(5,'Cheked in at Hawaii...','2020-05-05');
select * from post;

delete from post where post_id = 9;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------


DROP PROCEDURE IF EXISTS add_like
DELIMITER $$
CREATE PROCEDURE add_like
(
	user_name VARCHAR(20),
    post INT,
    liked DATE
)
BEGIN
	DECLARE p_id INT;
    SELECT person_id 
    INTO p_id
    FROM person 
    WHERE username = user_name;
    INSERT INTO likes
    VALUES 
			(
            DEFAULT,
            p_id,
            post,
            liked
            );
END$$
DELIMITER ;
CALL add_like('z_sage', 8, '2021-07-25');
select * from likes;


-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------

DROP PROCEDURE delete_person;
DELIMITER $$
CREATE PROCEDURE delete_person
(
	user_name VARCHAR(20)
)
BEGIN
	DECLARE p_id INT;
    SELECT person_id 
    INTO p_id
    FROM person WHERE username = user_name;
    DELETE FROM likes WHERE person_id = p_id OR post_id IN (SELECT post_id FROM post WHERE person_id = p_id);
    DELETE FROM post WHERE person_id = p_id;
    DELETE FROM person WHERE person_id = p_id;
END$$
DELIMITER ;

CALL delete_person('john5678');

rollback;


-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------





































