DELIMITER // 


-- первое задание в Л.Р.1


-- второе задание (выбираю диапазон по id)
CREATE PROCEDURE if not exists getIdInRange (arg1 int, arg2 int) 
BEGIN 
select * from person where id between arg1 and arg2 ;
select * from house where id between arg1 and arg2 ;
select * from serving where id between arg1 and arg2 ;
select * from incident where id between arg1 and arg2 ;
END// 


-- третье задание
CREATE PROCEDURE if not exists getAverage () 
BEGIN 
select avg(id) from person;
select avg(floor) from house;
select avg(TreatyID) from serving;
select avg(ActionID) from incident;
END// 

-- четвертое задание
CREATE PROCEDURE if not exists getAverageForArea () 
BEGIN 
select id, person_id, avg(balcony) from house group by id, person_id;
select id, house_id, avg(cost) from serving group by id, house_id;
select id, serving_id, avg(tax) from incident group by id, serving_id;
END// 

-- пятое задание
CREATE PROCEDURE if not exists getnewValues () 
BEGIN 
select 10*(balcony-(select avg(balcony) from house)) shows_deviation_of_balcony from house;
select 10*(cost-(select avg(cost) from serving)) shows_deviation_of_cost from serving;
select 10*(tax-(select avg(tax) from incident)) shows_deviation_of_tax from incident;
END// 

-- шестое задание
CREATE PROCEDURE if not exists concatAreas () 
BEGIN 
select concat(name,phone) from_one_table from person;
select concat(person.name, house.floor) from_several_tables  from person join house on person.id=house.id;
END// 

-- седьмое задание
CREATE PROCEDURE if not exists useConditionWithQuery () 
BEGIN 
select * from person where id not in (select person_id from house ) ;
select id, person_id from house where floor > (select avg(floors) from house ) ;
END// 

-- восьмое задание
CREATE PROCEDURE if not exists updateData () 
BEGIN 
update person set phone = 'not';
update house set keyval = 1 where floors>7;
END// 

-- девятое задание
CREATE PROCEDURE if not exists deleteData () 
BEGIN 
delete from serving where cost<15;
delete from incident where tax<75;
-- select house_id, count(house_id)serv_number from serving group by house_id having house_id=4;
END// 

-- сохранение
CREATE PROCEDURE if not exists saveTable (arg varchar(50)) 
BEGIN 

SET @s1 = CONCAT('create table if not exists ', arg,'SaveTable like ', arg);
PREPARE stmt1 FROM @s1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
set @s1 = null;

SET @s = CONCAT('delete from ', arg,'SaveTable');
PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
set @s = null;

SET @s2 = CONCAT('insert into  ', arg,'SaveTable select * from ', arg);
PREPARE stmt2 FROM @s2;
EXECUTE stmt2;
DEALLOCATE PREPARE stmt2;
set @s2 = null;

END// 



-- загрузка
CREATE PROCEDURE if not exists loadAndDropTable (arg varchar(50)) 
BEGIN 

-- SET @s = CONCAT('truncate table ', arg);
-- PREPARE stmt FROM @s;
-- EXECUTE stmt;
-- DEALLOCATE PREPARE stmt;
-- set @s = null;

-- SET @s1 = CONCAT('insert into  ', arg,' select * from ',arg,'SaveTable ');
-- PREPARE stmt1 FROM @s1;
-- EXECUTE stmt1;
-- DEALLOCATE PREPARE stmt1;
-- set @s1 = null;

-- SET @s2 = CONCAT('drop table ', arg);
-- PREPARE stmt2 FROM @s2;
-- EXECUTE stmt2;
-- DEALLOCATE PREPARE stmt2;
-- set @s2 = null;

END// 





DELIMITER ;



call getIdInRange(2,4);
call getAverage();
call getAverageForArea();
call getNewValues();
call concatAreas ();

call useConditionWithQuery ();
call updateData ();
call deleteData ();
call saveTable ('person');
-- call loadAndDropTable ('person');

