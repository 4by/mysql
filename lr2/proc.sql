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



DELIMITER ;



call getIdInRange(2,4);
call getAverage();

