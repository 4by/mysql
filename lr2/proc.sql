use multiTableBD;

DELIMITER // 
DROP PROCEDURE IF EXISTS addAreas//
DROP PROCEDURE IF EXISTS addPersonArea//
DROP PROCEDURE IF EXISTS addHouseArea//
DROP PROCEDURE IF EXISTS addServingArea//
DROP PROCEDURE IF EXISTS addIncidentArea//
DROP PROCEDURE IF EXISTS getIdInRange//
DROP PROCEDURE IF EXISTS getAverage//



CREATE PROCEDURE addPersonArea (arg int) 
BEGIN 
insert into person values (
null,
concat('adressEx', arg+1), 
concat('nameEx', arg+1), 
concat('phoneEx', arg+1) 
);
END// 



CREATE PROCEDURE addHouseArea (arg int) 
BEGIN 
insert into house values (
null,
1,
concat('adressFlatEx', arg+1), 
true,
10,
1,
concat('typeHouseEx', arg+1), 
concat('typeDoorEx', arg+1), 
true,
concat('typeBalconyEx', arg+1)
);
END// 



CREATE PROCEDURE addServingArea (arg int) 
BEGIN 
insert into serving values (
null,
1,
101,
1.01,
now(),
now()
);
END// 


CREATE PROCEDURE addIncidentArea (arg int) 
BEGIN 
insert into incident values (
null,
1,
1,
101,
101,
concat('chiefEx', arg+1), 
concat('brandEx', arg+1), 
now(),
1,
1.01,
concat('documentEx', arg+1), 
now(),
1.01
);
END// 


CREATE PROCEDURE addAreas (number int) 
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


call addPersonArea(maxPersonId);
call addHouseArea(maxHouseId);
call addServingArea(maxServingId);
call addIncidentArea(maxIncidentId);
set i = i+1;
end while;
END// 



CREATE PROCEDURE getIdInRange (arg1 int, arg2 int) 
BEGIN 
select * from person where id between arg1 and arg2 ;
select * from house where id between arg1 and arg2 ;
select * from serving where id between arg1 and arg2 ;
select * from incident where id between arg1 and arg2 ;
END// 



CREATE PROCEDURE getAverage () 
BEGIN 
select avg(id) from person;
select avg(floor) from house;
select avg(TreatyID) from serving;
select avg(ActionID) from incident;
END// 



DELIMITER ;












call addAreas(1);

-- call getIdInRange(2,4);
-- call getAverage();

