DROP TRIGGER IF EXISTS check_summary;

DELIMITER $$
CREATE TRIGGER check_summary
	BEFORE INSERT ON post
    FOR EACH ROW
BEGIN
	DECLARE post_summ VARCHAR(15);
	SET post_summ = CONCAT(SUBSTR(new.content,1,12),'...');
	IF NEW.summary <> post_summ THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Summary is not correct';
    END IF;
END $$
DELIMITER ;

INSERT INTO post
VALUES 
		(
        DEFAULT,
        4,
        'Boston has the best beer in New England',
        '2018-01-01',
        'Boston has.t...'
        );
        
INSERT INTO post
VALUES 
		(
        DEFAULT,
        4,
        'Boston has the best beer in New England',
        '2018-01-01',
        'Boston has t...'
        );
        

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS verify_liked_on;

DELIMITER $$
CREATE TRIGGER verify_liked_on
	BEFORE INSERT ON `likes`
    FOR EACH ROW
BEGIN
	DECLARE create_date DATE;
    
    SELECT created_on 
    INTO create_date 
    FROM post
    WHERE post_id = new.post_id;
    
    IF NEW.liked_on < create_date THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Liked on Date cannot be before the creation date';
    END IF;
END $$
DELIMITER ;

INSERT INTO likes
VALUES		(        DEFAULT, 4, 11, '2017-01-01'        );
        
INSERT INTO likes
VALUES		(        DEFAULT, 4, 11, '2019-01-01'        );


-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS post_content_history;
CREATE TABLE IF NOT EXISTS post_content_history
(
		history_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        old_content VARCHAR(255) NOT NULL,
        action_type VARCHAR(50),
        action_date DATETIME
);

SELECT * FROM post_content_history;

DROP TRIGGER IF EXISTS content_update_history;

DELIMITER $$
CREATE TRIGGER content_update_history
	AFTER UPDATE ON post
    FOR EACH ROW
BEGIN
	INSERT INTO post_content_history
    VALUES (DEFAULT, OLD.content, 'UPDATE', NOW());
END $$
DELIMITER ;

UPDATE post
SET  content = 'Checked in at Germany'
WHERE post_id = 11;


SELECT * FROM post_content_history;






















