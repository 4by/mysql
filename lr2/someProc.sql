DELIMITER // 


CREATE PROCEDURE if not exists getIdInRange (arg1 int, arg2 int) 
BEGIN 
select * from person where id between arg1 and arg2 ;
select * from house where id between arg1 and arg2 ;
select * from serving where id between arg1 and arg2 ;
select * from incident where id between arg1 and arg2 ;
END// 


CREATE PROCEDURE if not exists getAverage () 
BEGIN 
select avg(id) from person;
select avg(floor) from house;
select avg(TreatyID) from serving;
select avg(ActionID) from incident;
END// 

CREATE PROCEDURE if not exists getAverageForArea () 
BEGIN 
select id, person_id, avg(balcony) from house group by id, person_id;
select id, house_id, avg(cost) from serving group by id, house_id;
select id, serving_id, avg(tax) from incident group by id, serving_id;
END// 

CREATE PROCEDURE if not exists getnewValues () 
BEGIN 
select 10*(balcony-(select avg(balcony) from house)) shows_deviation_of_balcony from house;
select 10*(cost-(select avg(cost) from serving)) shows_deviation_of_cost from serving;
select 10*(tax-(select avg(tax) from incident)) shows_deviation_of_tax from incident;
END// 

CREATE PROCEDURE if not exists concatAreas () 
BEGIN 
select concat(name,phone) from_one_table from person;
select concat(person.name, house.floor) from_several_tables  from person join house on person.id=house.id;
END// 

CREATE PROCEDURE if not exists useConditionWithQuery () 
BEGIN 
select * from person where id not in (select person_id from house ) ;
select id, person_id from house where floor > (select avg(floors) from house ) ;
END// 

CREATE PROCEDURE if not exists updateData () 
BEGIN 
update person set phone = 'not';
update house set keyval = 1 where floors>7;
END// 

CREATE PROCEDURE if not exists deleteData () 
BEGIN 
delete from serving where cost<15;
delete from incident where tax<75;
-- select house_id, count(house_id)serv_number from serving group by house_id having house_id=4;
END// 


-- выполнение динамического sql
CREATE PROCEDURE if not exists exec (arg varchar(50)) 
BEGIN 
SET @s = arg;
PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
set @s = null;
END// 


-- сохранение (удалит ключи у зависимых таблиц)
CREATE PROCEDURE if not exists pushToBackup (arg varchar(50)) 
BEGIN 
call exec (CONCAT('drop table if exists ', arg,'SaveTable'));
call exec (CONCAT('create table ', arg,'SaveTable like ', arg));
call exec (CONCAT('insert into  ', arg,'SaveTable select * from ', arg));
END// 


-- загрузка
CREATE PROCEDURE if not exists pullFromBackup (arg varchar(50)) 
BEGIN 
call exec (CONCAT('delete from ', arg));
call exec (CONCAT('insert into  ', arg,' select * from ', arg, 'SaveTable'));
call exec (CONCAT('drop table if exists ', arg,'SaveTable'));
END// 




DELIMITER ;

-- задание а в Л.Р.1

-- задание б (выбираю диапазон по id)
call getIdInRange(2,4);

-- задание в
call getAverage();

-- задание г
call getAverageForArea();

-- задание д
call getNewValues();

-- задание е
call concatAreas ();

-- задание ж
call useConditionWithQuery ();

call pushToBackup ('person');

-- задание з
call updateData ();

-- задание и
call deleteData ();

call pullFromBackup ('person');

