source lr1/starter.sql;

drop database if exists thirdbd;
create database thirdbd;
use thirdbd;


delimiter //

CREATE procedure if not exists addTo50 ()
begin
declare personNum int default (select count(*) from monobd.person);
declare needToAdd int default (50 - personNum);
call monobd.addPersonArea(needToAdd);
end//


CREATE procedure if not exists addConstaints ()
begin
alter table multbd.person modify Name varchar(60) not null;
alter table multbd.house modify address varchar(60) null;
alter table multbd.serving modify cost decimal(15,2) unique;
alter table multbd.incident modify actionid int check(actionid>0);
end//


CREATE procedure if not exists fillWithDepr ()
begin
insert into multbd.person (name) values(null);
insert into multbd.serving(house_id,cost) values(1,(select cost from (select cost from multbd.serving where id=1)d));
insert into multbd.incident(house_id, serving_id, actionid) values (1,1, -3);
end//


CREATE procedure if not exists connTabl ()
begin
select person.name, house.floor from multbd.person join multbd.house;
select person.name, house.floor from multbd.person left join multbd.house on person.id=house.id;
end//


CREATE procedure if not exists selecting ()
begin
select id from multbd.person union select id from multbd.house;
select id from multbd.person union all select id from multbd.house;
-- имитация intersect
select id from multbd.person 
where id>1 and exists (
select person_id from multbd.house 
where person_id>1 and house.person_id=person.id
);
-- имитация minus
select person.id 
from multbd.person left join multbd.house 
on person.id=house.person_id 
where house.person_id is null;
end//


CREATE procedure if not exists addArea ()
begin
alter table test_table add newArea int null default 0;
alter table test_table modify newArea varchar(60) not null;
end//


delimiter ;

-- задание а
call addTo50();

-- задание б
select id from monobd.person where id = 3;

-- задание в
select balcony from monobd.person where balcony=0;

-- задание г
alter table monobd.person add index (id, balcony);

-- задание д 
-- (hash не поддерживается):
-- Message: This storage engine does not support the HASH index algorithm, storage engine default was used instead.
alter table monobd.person add index (id, balcony) using hash;


-- задание e
call addConstaints();

-- задание ж
-- нельзя включить/отключить эти ограничения, только удалить и поставить заново

-- задание з
-- call fillWithDepr();

-- задание и
call connTabl();

-- задание к
call selecting();

-- задание л
create table test_table like monobd.person;

-- задание м
insert into test_table 
(select null as id,
Address,
Name,
Phone,
TreatyID,
AddressFlat,
KeyVal,
Floors,
Floor,
TypeHouse,
TypeDoor,
Balcony,
TypeBalcony,
Cost,
Compensation,
DateStart,
StopDate,
ActionID,
PatrolID,
Chief,
Brand,
DateTime,
IsFalse,
Tax,
Document,
Prolong from monobd.person); 

-- задание н
insert into test_table(id, name, phone) 
(select null as id, 
name, 
phone from multbd.person);


-- задание o
call addArea();

-- задание п
create view test_view as 
(select person.name, house.floor 
from multbd.person left join multbd.house 
on person.id=house.id 
order by floor limit 10);


-- задание p
source lr3/sequences.sql;


-- задание с
call multbd.addPersonArea(3);
call multbd.addHouseArea(3);








