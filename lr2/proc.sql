
DELIMITER // 


CREATE PROCEDURE if not exists addAreas (number int) 
BEGIN 
declare i int default 0;

declare maxPersonId int;
declare maxHouseId int;
declare maxServingId int;
declare maxIncidentId int;

while i<number do

set maxPersonId = (select max(id) from person);
set maxHouseId = (select max(id) from house);
set maxServingId = (select max(id) from serving);
set maxIncidentId = (select max(id) from incident);


-- call addPersonArea(maxPersonId);
-- call addHouseArea(maxHouseId);
-- call addServingArea(maxServingId);
-- call addIncidentArea(maxIncidentId);
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

