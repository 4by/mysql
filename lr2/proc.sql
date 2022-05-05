
DELIMITER // 


CREATE PROCEDURE if not exists addAreas (number int) 
BEGIN 


declare i int default 0;
while i<number do
call addPersonArea((select max(id) from person));
call addHouseArea((select max(id) from house));
call addServingArea((select max(id) from serving));
call addIncidentArea((select max(id) from incident));
set i = i+1;
end while;
END// 



-- CREATE PROCEDURE getIdInRange (arg1 int, arg2 int) 
-- BEGIN 
-- select * from person where id between arg1 and arg2 ;
-- select * from house where id between arg1 and arg2 ;
-- select * from serving where id between arg1 and arg2 ;
-- select * from incident where id between arg1 and arg2 ;
-- END// 



-- CREATE PROCEDURE getAverage () 
-- BEGIN 
-- select avg(id) from person;
-- select avg(floor) from house;
-- select avg(TreatyID) from serving;
-- select avg(ActionID) from incident;
-- END// 



DELIMITER ;












call addAreas(1);

-- call getIdInRange(2,4);
-- call getAverage();

