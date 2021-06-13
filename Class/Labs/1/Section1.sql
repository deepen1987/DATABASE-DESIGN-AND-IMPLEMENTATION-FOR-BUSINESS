-- DROP DATABASE IF EXISTS `class`;
-- CREATE DATABASE `class`;

CREATE TABLE movie (
title VARCHAR(64),
genre VARCHAR(32),
release_date DATE,
price DECIMAL(6,2)
);

INSERT INTO movie
VALUES (
		'Furious 7',
        'Action Film',
        '2015-04-01',
        9.94);
        
SELECT * FROM movie;

UPDATE movie
SET price = 10.15;

SELECT * FROM movie;

DELETE FROM movie;

SELECT * FROM movie;

DROP TABLE movie;

SELECT * FROM movie;
        
