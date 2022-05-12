drop database if exists t;
create database t;
use t;

CREATE TABLE tabl1 (
id INT UNSIGNED NOT NULL DEFAULT 0,
name VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
);

delimiter //

CREATE TRIGGER tabl1_seq
BEFORE INSERT ON tabl1
FOR EACH ROW
BEGIN
SET NEW.id = (select max(id) from tabl1);
END//

delimiter ;

INSERT tabl1 SET name = 'example 1';
INSERT tabl1 SET name = 'example 1';