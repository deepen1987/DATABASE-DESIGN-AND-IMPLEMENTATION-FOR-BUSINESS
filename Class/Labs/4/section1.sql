
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

insert into `post`
values
		(
		default,
        1,
        'WWE had a huge influence over my life',
        '2011-02-02',
        'WWE had a hu...'
        ),
        (
		default,
        1,
        'WWE made a star out of me thank you for your support',
        '2012-02-02',
        'WWE made a s...'
        ),
        (
		default,
        3,
        'Buckys role was excellently played by...',
        '2011-02-02',
        'Buckys role ...'
        ),
        (
		default,
        3,
        'Hail Hydra was a quick thought in last avenger',
        '2020-02-02',
        'Hail hydra w...'
        ),
        (
		default,
        4,
        'Avengers was the best movies series I worked in',
        '2021-02-02',
        'Avengers was...'
        ),
        (
		default,
        4,
        'The character of Black Widow was a tough one',
        '2018-02-02',
        'The characte...'
        ),
        (
		default,
        5,
        'Boston is one of the oldest cities in US',
        '2019-02-02',
        'Boston is on...'
        ),
        (
		default,
        5,
        'Boston has the best beer in New England',
        '2019-02-02',
        'Boston has t...'
        );
        
	
select * from post;


insert into likes
values 
		(
		default,
        2,
        1,
        '2011-03-03'
        ),
        (
		default,
        1,
        4,
        '2020-03-03'
        ),
        (
		default,
        4,
        8,
        '2019-03-03'
        ),
        (
		default,
        4,
        6,
        '2018-03-03'
        );

select * from likes;






















