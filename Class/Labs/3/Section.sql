-- CREATE DATABASE sqllabs3; 
drop table if exists movie;
drop table if exists movie_series;
drop table if exists genre;
drop table if exists creator;


CREATE TABLE if not exists `genre`
(
	`genre_id`		INT(12) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `genre_name` 	VARCHAR(64) NOT NULL
);


CREATE TABLE if not exists  `creator`
(
	`creator_id`	INT(12) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `first_name`	VARCHAR(64) NOT NULL,
    `last_name`		VARCHAR(64) NOT NULL
);


CREATE TABLE if not exists  `movie_series`
(
	`movie_series_id`	INT(12) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `genre_id`			INT(12) NOT NULL,
    `creator_id` 		INT(12) NOT NULL,
    `series_name` 		VARCHAR(255) NOT NULL,
    `suggested_price` 	DECIMAL(8,2) NULL,
    CONSTRAINT `fk_genre_id` 	FOREIGN KEY(`genre_id`) 	REFERENCES `genre`(`genre_id`) 		ON UPDATE CASCADE,
    CONSTRAINT `fk_creator_id` 	FOREIGN KEY(`creator_id`) REFERENCES `creator`(`creator_id`) 	ON UPDATE CASCADE
-- 	FOREIGN KEY(genre_id) REFERENCES genre(genre_id) 
);


CREATE TABLE if not exists  `movie`
(
	`movie_id` 			INT(12) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `movie_series_id` 	INT(12) NOT NULL,
    `movie_name` 		VARCHAR (64) NOT NULL,
    `length_in_minutes` DECIMAL(4),
    CONSTRAINT `fk_movie_series_id` FOREIGN KEY(`movie_series_id`) REFERENCES `movie_series`(`movie_series_id`) ON UPDATE CASCADE
);