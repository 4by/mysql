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



CREATE PROCEDURE if not exists saveTable (arg varchar(50)) 
BEGIN 

SET @s1 = CONCAT('create table ', arg,'SaveTable like ', arg);
PREPARE stmt FROM @s1;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
set @s1 = null;

SET @s2 = CONCAT('insert into  ', arg,'SaveTable select * from ', arg);
PREPARE stmt2 FROM @s2;
EXECUTE stmt2;
DEALLOCATE PREPARE stmt2;
set @s2 = null;

END// 








DELIMITER ; 

call saveTable('t1');
