source (1)starter.sql;

drop database if exists fourthbd;
create database fourthbd;
use fourthbd;



CREATE procedure if not exists addAreaWithDate ()
begin
call multbd.addPersonArea()
end//


-- поскольку в задании не указано, на какой из таблиц ЛР1
-- работать - я буду работать на таблице
-- однотабличной базы данных


-- задание а
call
now();
date_add(now(), -14 DAY);