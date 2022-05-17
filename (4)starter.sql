source (1)starter.sql;

drop database if exists fourthbd;
create database fourthbd;
use fourthbd;


delimiter //

create procedure if not exists addAreasWithDate ()
begin

call monobd.addPersonArea(1);
call monobd.addPersonArea(1);

set @id_curr_date = (monobd.personNumber()-1);
set @id_last_date = (monobd.personNumber());

update monobd.person set datestart = now() 
where id = @id_curr_date;

update monobd.person set datestart = now() - INTERVAL 14 DAY
where id = @id_last_date;

end//


create procedure if not exists addAreasWithStudNameAndNumb ()
begin
call monobd.addPersonArea(1);

update monobd.person set name = "Eugene"
where id = (monobd.personNumber());

call monobd.addPersonArea(1);

update monobd.person set name = "Computer_number_is_2" 
where id = (monobd.personNumber());
end//

create function cap_only_first (input varchar(255))
returns varchar(255)
deterministic
begin
declare len int default CHAR_LENGTH(input);
declare i int default 0 ;
set input = lower(input);
while (i < len) do
if ( (mid(input,i,1) = ' ' OR i = 0) and (i < len) ) then
set input = concat(
left(input,i),
upper(mid(input,i + 1,1)),
right(input,len - i - 1)
);
end if;
set i = i + 1;
end while;
return input;
end//



create procedure if not exists getAddedDates ()
begin

select datestart from monobd.person 
where id = @id_curr_date;

select datestart from monobd.person 
where id = @id_last_date;

end//


create function if not exists changeAddedDatesAndGetDiff ()
returns int
deterministic
begin

declare changedAddedCurrDate date default 
(select datestart from monobd.person 
where id = @id_curr_date) - INTERVAL 3 month;

declare changedAddedLastDate date default
(select datestart from monobd.person 
where id = @id_last_date) + INTERVAL 2 month; 

update monobd.person 
set datestart = changedAddedCurrDate
where id = @id_curr_date;

update monobd.person 
set datestart = changedAddedLastDate
where id = @id_last_date;

return timestampdiff(month, changedAddedCurrDate, changedAddedLastDate);
end//







create procedure if not exists getMaxDaysOfAddedDates ()
begin

declare changedAddedCurrDate date default 
(select datestart from monobd.person 
where id = @id_curr_date);

declare changedAddedLastDate date default
(select datestart from monobd.person 
where id = @id_last_date);

select day(last_day(changedAddedCurrDate));
select day(last_day(changedAddedLastDate));

end//




create procedure if not exists showDateInDiffForms ()
begin

-- строчная форма с пробелами
SELECT STR_TO_DATE('April 1996 15', '%M %Y %d');
-- строчная форма с пробелами (перестановка, запятые, сокращения)
SELECT STR_TO_DATE('96, APR, 15', '%Y, %M, %d');
-- форма со "слешами" (перестановка, запятые, сокращения аналогично)
SELECT STR_TO_DATE('96/APR/15', '%Y/ %M/ %d');
-- форма "одной строкой" (перестановка, запятые, сокращения аналогично)
SELECT STR_TO_DATE('96APR15', '%Y%M%d');

end//





create procedure if not exists addAreasWithDatesInDiffForms ()
begin

call monobd.addPersonArea(1);
update monobd.person 
set datestart = STR_TO_DATE('April 1996 15', '%M %Y %d') 
where id = monobd.personNumber();

call monobd.addPersonArea(1);
update monobd.person 
set datestart = STR_TO_DATE('96, APR, 15', '%Y, %M, %d') 
where id = monobd.personNumber();

call monobd.addPersonArea(1);
update monobd.person 
set datestart = STR_TO_DATE('96/APR/15', '%Y/ %M/ %d') 
where id = monobd.personNumber();

call monobd.addPersonArea(1);
update monobd.person 
set datestart = STR_TO_DATE('96APR15', '%Y%M%d') 
where id = monobd.personNumber();

end//





delimiter ;


-- задание а
-- добавил в одно поле две даты, а не два поля с датами(принцип тот же)
call addAreasWithDate();

-- задание б
call addAreasWithStudNameAndNumb();

-- задание г
select cap_only_first(name) from monobd.person;

-- задание д
select max(length(name)) minimum_length,
min(length(name)) maxim_length,
avg(length(name)) average_length
from monobd.person;

-- задание e
SELECT 
REGEXP_SUBSTR(name, '[a-z]+', 1, 1) имя, 
REGEXP_SUBSTR(name, '[a-z]+', 1, 2) фамилия, 
REGEXP_SUBSTR(name, '[a-z]+', 1, 3) отчество, 
REGEXP_SUBSTR(name, '[a-z]+.', 1, 4) номер_в_автогенераторе 
from monobd.person\G 

-- задание ж
-- обьяснение: В общем случае возможно исключать захват других полей
-- с подходящей (по случайности) датой без способов, влияющих на саму таблицу
-- только путем использования глобальных переменных
-- здесь по заданию они захватываться не должны. Я использовал глобальные переменные
call getAddedDates();

-- задание з
-- функция обновит даты в таблицах и вернет их разницу
select changeAddedDatesAndGetDiff();

-- задание и
call getMaxDaysOfAddedDates ();

-- задание к
-- разобрал все вариации форматов ввода 
-- (в задании написано "вывода", видимо, опечатка),
-- представленных в задании
call showDateInDiffForms();

-- задание л
call addAreasWithDatesInDiffForms();










