drop database if exists t;
create database t;
use t;


CREATE TABLE tabl1 (
id INT UNSIGNED NOT NULL DEFAULT 0,
name VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
);

-- хранит последний id, относительно которого мы будем делать шаг
-- если вариант проще и шаг делает относительно, например, максимального id, то можно обойтись без этого
CREATE TABLE sequence (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL
);

delimiter //

CREATE TRIGGER tabl1_seq
BEFORE INSERT ON 
tabl1
FOR EACH ROW
BEGIN
INSERT sequence SET id=DEFAULT;
DELETE FROM sequence WHERE id < LAST_INSERT_ID();
SET NEW.id = LAST_INSERT_ID();
END//


delimiter ;

INSERT tabl1 SET name = 'example 1';