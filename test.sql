drop database if exists t;
create database t;
use t;


create table if not exists t1(
id int primary key auto_increment not null,
c1 varchar(10), c2 varchar(10)
);
create table if not exists t2(
id int primary key auto_increment not null,
c1 varchar(10), c2 varchar(10)
);

insert into t1 values (null,'1','a');
insert into t1 values (null,'2','a');
insert into t2 values (null,'1','b');
insert into t2 values (null,'2','b');


DELIMITER // 
CREATE PROCEDURE if not exists qq (arg varchar(10)) 
BEGIN 


SET @s = CONCAT('SELECT ', arg,' FROM t1');

PREPARE stmt3 FROM @s;
EXECUTE stmt3;
DEALLOCATE PREPARE stmt3;
set @s = null;


END// 
DELIMITER ; 

call qq('c1');
