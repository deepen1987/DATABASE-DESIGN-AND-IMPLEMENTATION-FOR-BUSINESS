CREATE TABLE vacation (
	vacation_id DECIMAL(12) PRIMARY KEY,
    location VARCHAR(64) NOT NULL,
    description VARCHAR(1024) NULL,
    started_on DATE,
    end_on DATE);

INSERT INTO vacation (
		vacation_id, 
		location, 
		description, 
		started_on, 
		End_on)
VALUES (
		1,
        'Costa Rica',
        'Relaxing Hot Springs',
        '2019-01-13',
        '2019-01-21'
        ),
        (
		2,
        'Bora Bora',
        'Exciting Snorkeling',
        '2019-03-05',
        '2019-03-15'
        ),
        (
		3,
        'Jamaica',
        DEFAULT,
        '2018-12-10',
        '2018-12-28'
        );
        
SELECT * FROM vacation;

INSERT INTO vacation
VALUES (
		4,
        'Netherlands',
        'Experience the Netherlands No Other Way',
        '2020-01-01',
        '2020-01-10');
        

SELECT location, description
FROM vacation
WHERE vacation_id = 2;

UPDATE vacation 
SET 
	description = 'Aquatic Wonders'
WHERE vacation_id = 3;

SELECT * FROM vacation;

UPDATE vacation
SET 
	description = NULL
WHERE vacation_id = 3;	

SELECT * FROM vacation;

DELETE FROM vacation
WHERE started_on > '2019-01-01';

SELECT * FROM vacation;