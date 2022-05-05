
-- создание таблицы person с полями
create table if not exists person(
id int primary key auto_increment not null,
Address varchar(60),
Name varchar(60),
Phone varchar(10) not null
);

-- создание таблицы house с полями
create table if not exists house(
id int primary key auto_increment not null,
person_id int not null,
foreign key (person_id) references person(id),
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
foreign key (house_id) references house(id),
TreatyID int,
Cost decimal(15,2),
DateStart Date,
StopDate Date
);

-- создание таблицы incident с полями
create table if not exists incident(
id int primary key auto_increment not null,
house_id int not null,
serving_id int not null,
foreign key (house_id) references house(id),
foreign key (serving_id) references serving(id),
Compensation decimal(15,2),
ActionID int,
PatrolID int,
Chief varchar(10),
Brand varchar(15),
DateTime DateTime,
IsFalse bool,
Tax decimal(15,2),
Document varchar(40),
Prolong Date
);


-- функциональная часть

DELIMITER // 

-- количество полей в person
CREATE function if not exists personNumber () 
returns int
deterministic
BEGIN
return (select count(id) from person);
END// 

-- количество полей в house
CREATE function if not exists houseNumber () 
returns int
deterministic
BEGIN
return (select count(id) from house);
END// 

-- количество полей в serving
CREATE function if not exists servingNumber () 
returns int
deterministic
BEGIN
return (select count(id) from serving);
END// 

-- количество полей в incident
CREATE function if not exists incidentNumber () 
returns int
deterministic
BEGIN
return (select count(id) from incident);
END// 



-- функция-рандом для целых чисел
CREATE function if not exists intRandRange (fromVal int, toVal int) 
returns int
deterministic
BEGIN 
return (SELECT (floor(RAND()*(fromVal-toVal+1)+toVal)));
END// 

-- функция-рандом для десятичных чисел
CREATE function if not exists decRandRange (fromVal int, toVal int) 
returns decimal(15,2)
deterministic
BEGIN 
return (SELECT (round(RAND()*(fromVal-toVal+1)+toVal, 2)));
END// 

-- процедура для создания поля person
CREATE PROCEDURE if not exists addPersonArea (numberCount int) 
BEGIN 

declare personNum int default 0;
declare i int default 0;

while i<numberCount do
set personNum = personNumber()+1;
insert into person values (
null, -- Регистрационный номер клиента
concat('adressEx', personNum), -- Адрес клиента
concat('nameEx', personNum), -- ФИО клиента
concat('phoneEx', personNum) -- Телефон для связи с клиентом
);

set i = i+1;
end while;
END// 


-- процедура для создания поля house
CREATE PROCEDURE if not exists addHouseArea (numberCount int) 
BEGIN 


declare houseNum int default 0;
declare personNum int default 0;
declare i int default 0;

while i<numberCount do

set houseNum = houseNumber()+1;
set personNum = personNumber();


insert into house values (
null, -- Регистрационный номер клиента
intRandRange(0, personNum), -- ссылка на пользователя
concat('adressFlatEx', houseNum), -- Адрес квартиры
true,-- Наличие кодового замка на подъезде
intRandRange(1, 100),-- Количество этажей в доме
intRandRange(1, 100),-- Этаж, на котором расположена квартира
concat('typeHouseEx', houseNum), -- Тип дома (кирпичный, панельный)
concat('typeDoorEx', houseNum), -- Тип квартирной двери (мет, дер, две шт.)
true,-- Наличие балкона
concat('typeBalconyEx', houseNum) -- Тип балкона (отдельный, совмещенный)
);

set i = i+1;
end while;

END// 



-- процедура для создания поля serving
CREATE PROCEDURE if not exists addServingArea (numberCount int) 
BEGIN 
declare houseNum int default 0;

declare i int default 0;
while i<numberCount do

set houseNum = houseNumber();

insert into serving values (
null, -- Регистрационный номер клиента
intRandRange(0, houseNum), -- ссылка на дом
intRandRange(1, 100), -- Регистрационный номер договора
decRandRange(1, 100),-- Стоимость ежемесячной оплаты
now(),-- Начало действия договора
now()-- Окончание действия
);

set i = i+1;
end while;

END// 

-- процедура для создания поля incident
CREATE PROCEDURE if not exists addIncidentArea (numberCount int) 
BEGIN 


declare incidentNum int default 0;
declare houseNum int default 0;
declare servingNum int default 0;

declare i int default 0;
while i<numberCount do

set incidentNum = incidentNumber()+1;
set houseNum = houseNumber();
set servingNum = servingNumber();


insert into incident values (
null, -- Регистрационный номер клиента
intRandRange(0, houseNum), -- ссылка на дом
intRandRange(0, servingNum), -- ссылка на обслуживание
decRandRange(1, 100),-- Компенсация при краже имущества
intRandRange(1, 100),-- Номер выезда на захват
intRandRange(1, 100),-- Номер экипажа, выезжавшего на захват
concat('chiefEx', incidentNum), -- Командир экипажа
concat('brandEx', incidentNum), -- Марка автомобиля
now(),-- Дата и время выезда
true,-- Вызов ложный (да/нет)
decRandRange(1, 100),-- Величина штрафа за ложный вызов
concat('documentEx', incidentNum), -- Документ, оформленный при задержании
now()-- Продление срока действия договора
);

set i = i+1;
end while;


END// 



DELIMITER ;


-- заполнение таблицы данными
call addPersonArea(15);
call addHouseArea(20);
call addServingArea(10);
call addIncidentArea(7);

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