-- (пере)инициализация БД
drop database if exists multbd;
create database multbd;
use multbd;

-- импорт общих функций
source lr1/sharedFunc.sql;

-- создание таблицы person с полями
create table if not exists person(
id int primary key auto_increment not null,
Name varchar(60),
Phone varchar(10) not null
);

-- создание таблицы house с полями
create table if not exists house(
id int primary key auto_increment not null,
person_id int not null,
foreign key (person_id) 
references person(id)
on update cascade
on delete cascade,
Address varchar(60),
AddressFlat varchar(60),
KeyVal bool,
Floors int,
Floor int,
TypeHouse varchar(20),
TypeDoor varchar(20),
Balcony bool,
TypeBalcony varchar(20)
);

-- создание таблицы serving с полями
create table if not exists serving(
id int primary key auto_increment not null,
house_id int not null,
foreign key (house_id) 
references house(id)
on update cascade
on delete cascade,
TreatyID int,
Cost decimal(15,2),
DateStart Date,
StopDate Date,
Prolong Date
);

-- создание таблицы incident с полями
create table if not exists incident(
id int primary key auto_increment not null,
house_id int not null,
serving_id int not null,
foreign key (house_id) 
references house(id)
on update cascade
on delete cascade,
foreign key (serving_id) 
references serving(id)
on update cascade
on delete cascade,
Compensation decimal(15,2),
ActionID int,
PatrolID int,
Chief varchar(10),
Brand varchar(15),
DateTime DateTime,
IsFalse bool,
Tax decimal(15,2),
Document varchar(40)
);


-- функциональная часть

DELIMITER // 


-- количество полей в house
CREATE function if not exists houseNumber () 
returns int
deterministic
BEGIN
return ifnull((select count(id) from house), 0);
END// 

-- количество полей в serving
CREATE function if not exists servingNumber () 
returns int
deterministic
BEGIN
return ifnull((select count(id) from serving), 0);
END// 

-- количество полей в incident
CREATE function if not exists incidentNumber () 
returns int
deterministic
BEGIN
return ifnull((select count(id) from incident), 0);
END// 

-- процедура для внесения в person множества полей
CREATE PROCEDURE if not exists addPersonArea (i int) 
BEGIN 

declare personNum int default 0;

while i>0 do
set personNum = personNumber()+1;
insert into person values (
null, -- Регистрационный номер клиента
concat('nameEx', personNum), -- ФИО клиента
concat('phoneEx', personNum) -- Телефон для связи с клиентом
);
set i = i-1;
end while;

END// 


-- процедура для внесения в house множества полей
CREATE PROCEDURE if not exists addHouseArea (i int) 
BEGIN 

declare houseNum int default 0;
declare personNum int default 0;


while i>0 do
set houseNum = houseNumber()+1;
set personNum = personNumber();
insert into house values (
null, -- Регистрационный номер клиента
intRandRange(1, personNum), -- ссылка на пользователя
concat('adressEx', personNum), -- Адрес клиента
concat('adressFlatEx', houseNum), -- Адрес квартиры
intRandRange(0,1),-- Наличие кодового замка на подъезде
intRandRange(1, 100),-- Количество этажей в доме
intRandRange(1, 100),-- Этаж, на котором расположена квартира
concat('typeHouseEx', houseNum), -- Тип дома (кирпичный, панельный)
concat('typeDoorEx', houseNum), -- Тип квартирной двери (мет, дер, две шт.)
intRandRange(0,1),-- Наличие балкона
concat('typeBalconyEx', houseNum) -- Тип балкона (отдельный, совмещенный)
);
set i = i-1;
end while;

END// 



-- процедура для внесения в serving множества полей
CREATE PROCEDURE if not exists addServingArea (i int) 
BEGIN 
declare houseNum int default 0;


while i>0 do
set houseNum = houseNumber();
insert into serving values (
null, -- Регистрационный номер клиента
intRandRange(1, houseNum), -- ссылка на дом
intRandRange(1, 100), -- Регистрационный номер договора
decRandRange(1, 100),-- Стоимость ежемесячной оплаты
date_add("2017-06-15", INTERVAL intRandRange(0,100) DAY),-- Начало действия договора
date_add("2017-06-15", INTERVAL intRandRange(100,200) DAY),-- Окончание действия
date_add("2017-06-15", INTERVAL intRandRange(100,200) DAY)-- Продление срока действия договора
);
set i = i-1;
end while;

END// 

-- процедура для внесения в incident множества полей
CREATE PROCEDURE if not exists addIncidentArea (i int) 
BEGIN 
declare incidentNum int default 0;
declare houseNum int default 0;
declare servingNum int default 0;
while i>0 do
set incidentNum = incidentNumber()+1;
set houseNum = houseNumber();
set servingNum = servingNumber();
insert into incident values (
null, -- Регистрационный номер клиента
intRandRange(1, houseNum), -- ссылка на дом
intRandRange(1, servingNum), -- ссылка на обслуживание
decRandRange(1, 100),-- Компенсация при краже имущества
intRandRange(1, 100),-- Номер выезда на захват
intRandRange(1, 100),-- Номер экипажа, выезжавшего на захват
concat('chiefEx', incidentNum), -- Командир экипажа
concat('brandEx', incidentNum), -- Марка автомобиля
date_add("2017-06-15", INTERVAL intRandRange(0,200) DAY),-- Дата и время выезда
intRandRange(0,1),-- Вызов ложный (да/нет)
decRandRange(1, 100),-- Величина штрафа за ложный вызов
concat('documentEx', incidentNum) -- Документ, оформленный при задержании
);
set i = i-1;
end while;


END// 



DELIMITER ;


-- заполнение таблицы данными
call addPersonArea(5);
call addHouseArea(3);
call addServingArea(4);
call addIncidentArea(2);

-- получение информации о таблицах

-- select count(id) from person;
-- select count(id) from house;
-- select count(id) from serving;
-- select count(id) from incident;
-- select id, house_id, serving_id from incident order by id;
-- show tables;
-- describe person;
-- describe house;
-- describe serving;
-- describe incident;
-- select Phone from person;
-- select Floor from house;
-- select Cost from serving;
-- select ActionID from incident;
-- update person set Name = "nameChangedEx1";
-- alter table person drop column name; -- выдаст ошибку на второй вызов
-- alter table person drop column id; -- не сработает