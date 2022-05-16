source (1)starter.sql;

drop database if exists secondbd;
create database secondbd;
use secondbd;



DELIMITER // 


CREATE PROCEDURE if not exists getIdInRange (arg1 int, arg2 int) 
BEGIN 
select * from multbd.person where id between arg1 and arg2 ;
select * from multbd.house where id between arg1 and arg2 ;
select * from multbd.serving where id between arg1 and arg2 ;
select * from multbd.incident where id between arg1 and arg2 ;
END// 


CREATE PROCEDURE if not exists getAverage () 
BEGIN 
select avg(id) from multbd.person;
select avg(floor) from multbd.house;
select avg(TreatyID) from multbd.serving;
select avg(ActionID) from multbd.incident;
END// 

CREATE PROCEDURE if not exists getAverageForArea () 
BEGIN 
select id, person_id, avg(balcony) from multbd.house group by id, person_id;
select id, house_id, avg(cost) from multbd.serving group by id, house_id;
select id, serving_id, avg(tax) from multbd.incident group by id, serving_id;
END// 

CREATE PROCEDURE if not exists getnewValues () 
BEGIN 
select 10*(balcony-(select avg(balcony) from multbd.house)) shows_deviation_of_balcony from multbd.house;
select 10*(cost-(select avg(cost) from multbd.serving)) shows_deviation_of_cost from multbd.serving;
select 10*(tax-(select avg(tax) from multbd.incident)) shows_deviation_of_tax from multbd.incident;
END// 

CREATE PROCEDURE if not exists concatAreas () 
BEGIN 
select concat(name,phone) from_one_table from multbd.person;
select concat(person.name, house.floor) from_several_tables  from multbd.person join multbd.house on person.id=house.id;
END// 

CREATE PROCEDURE if not exists useConditionWithQuery () 
BEGIN 
select * from multbd.person where id not in (select person_id from multbd.house ) ;
select id, person_id from multbd.house where floor > (select avg(floors) from multbd.house ) ;
END// 

CREATE PROCEDURE if not exists updateData () 
BEGIN 
update multbd.person set phone = 'not';
update multbd.house set keyval = 1 where floors>7;
END// 

CREATE PROCEDURE if not exists deleteData () 
BEGIN 
delete from multbd.serving where cost<15;
delete from multbd.incident where tax<75;
END// 


-- выполнение динамического sql
CREATE PROCEDURE if not exists exec (arg varchar(100)) 
BEGIN 
SET @s = arg;
PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
set @s = null;
END// 


-- сохранение
CREATE PROCEDURE if not exists pushToBackup (arg varchar(100)) 
BEGIN 
call exec (CONCAT('drop table if exists ', arg,'SaveTable'));
call exec (CONCAT('create table ', arg,'SaveTable like multbd.', arg));
call exec (CONCAT('insert into  ', arg,'SaveTable select * from multbd.', arg));
END// 


-- загрузка (удалит ключи у зависимых таблиц)
CREATE PROCEDURE if not exists pullFromBackup (arg varchar(100)) 
BEGIN 
call exec (CONCAT('delete from multbd.', arg));
call exec (CONCAT('insert into multbd.', arg,' select * from ', arg, 'SaveTable'));
call exec (CONCAT('drop table if exists ', arg,'SaveTable'));
END// 




DELIMITER ;

-- задание а в Л.Р.1

-- задание б (выбираю диапазон по id)
call getIdInRange(2,4);

-- -- задание в
call getAverage();

-- -- задание г
call getAverageForArea();

-- -- задание д
call getNewValues();

-- -- задание е
call concatAreas ();

-- -- задание ж
call useConditionWithQuery ();

-- (я выполнил сохранение таким способом)
call pushToBackup ('person');

-- -- задание з
call updateData ();

-- -- задание и
call deleteData ();

-- (загрузка)
call pullFromBackup ('person');

