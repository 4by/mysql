source lr1/starter.sql

delimiter //

use monoTableBD//

CREATE procedure if not exists addTo ()
begin
declare personNum int default (select count(*) from person);
declare needToAdd int default (50 - personNum);
call addPersonArea(needToAdd);
end//

use multTableBD//

CREATE procedure if not exists addConstaints ()
begin
alter table person modify Name varchar(60) not null;
alter table house modify address varchar(60) null;
alter table serving modify cost decimal(15,2) unique;
alter table incident modify actionid int check(actionid>0);
end//


CREATE procedure if not exists fillWithDepr ()
begin
insert into person (name) values(null);
insert into serving(house_id,cost) values(1,(select cost from (select cost from serving where id=1)d));
insert into incident(house_id, serving_id, actionid) values (1,1, -3);
end//

delimiter ;

use monoTableBD;

-- задание а
call addTo();

-- задание б
select id from person where id = 3;

-- задание в
select balcony from person where balcony=0;

-- задание г
alter table person add index (id, balcony);

-- задание д 
-- (hash не поддерживается):
-- Message: This storage engine does not support the HASH index algorithm, storage engine default was used instead.
alter table person add index (id, balcony) using hash;

use multiTableBD;


-- задание e
call addConstaints();

-- задание ж
-- нельзя включить/отключить эти ограничения, только удалить и поставить заново

-- задание з
-- call fillWithDepr();

-- задание и
