
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
return ifnull((select count(id) from person), 0);
END// 

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
CREATE PROCEDURE if not exists addPersonArea () 
BEGIN 
declare personNum int default personNumber()+1;
insert into person values (
null, -- Регистрационный номер клиента
concat('adressEx', personNum), -- Адрес клиента
concat('nameEx', personNum), -- ФИО клиента
concat('phoneEx', personNum) -- Телефон для связи с клиентом
);
END// 


-- процедура для создания поля house
CREATE PROCEDURE if not exists addHouseArea () 
BEGIN 
declare personNum int default personNumber();
declare houseNum int default houseNumber() + 1;
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
END// 



-- процедура для создания поля serving
CREATE PROCEDURE if not exists addServingArea () 
BEGIN 
declare houseNum int default houseNumber();
insert into serving values (
null, -- Регистрационный номер клиента
intRandRange(0, houseNum), -- ссылка на дом
intRandRange(1, 100), -- Регистрационный номер договора
decRandRange(1, 100),-- Стоимость ежемесячной оплаты
now(),-- Начало действия договора
now()-- Окончание действия
);
END// 

-- процедура для создания поля incident
CREATE PROCEDURE if not exists addIncidentArea () 
BEGIN 
declare houseNum int default houseNumber();
declare servingNum int default servingNumber();
declare incidentNum int default incidentNumber()+1;
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
END// 



DELIMITER ;


-- заполнение таблицы данными
call addPersonArea();
call addHouseArea();
call addServingArea();
call addIncidentArea();

-- получение информации о таблицах
show tables;
describe person;
describe house;
describe serving;
describe incident;
select Phone from person;
select Floor from house;
select Cost from serving;
select ActionID from incident;
update person set Name = "nameChangedEx1";
-- alter table person drop column name; -- выдаст ошибку на второй вызов
-- alter table person drop column id; -- не сработает