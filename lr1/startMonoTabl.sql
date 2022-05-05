-- создание таблицы с полями
create table if not exists person(
id int primary key auto_increment not null,
Address varchar(60),
Name varchar(60),
Phone varchar(10) not null,
TreatyID int,
AddressFlat varchar(60),
KeyVal bool,
Floors int,
Floor int,
TypeHouse varchar(20),
TypeDoor varchar(20),
Balcony bool,
TypeBalcony varchar(20),
Cost decimal(15,2),
Compensation decimal(15,2),
DateStart Date,
StopDate Date,
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

-- функция-рандом для целых чисел
CREATE function if not exists intRandRange (fromVal int, toVal int) returns int
deterministic
BEGIN 
return (SELECT (floor(RAND()*(fromVal-toVal+1)+toVal)));
END// 

-- функция-рандом для десятичных чисел
CREATE function if not exists decRandRange (fromVal int, toVal int) returns decimal(15,2)
deterministic
BEGIN 
return (SELECT (round(RAND()*(fromVal-toVal+1)+toVal, 2)));
END// 

-- процедура для создания поля person
CREATE PROCEDURE if not exists addPersonArea () 
BEGIN 
declare randCounter int default ifnull((select count(id) from person)+1, 1);
insert into person values (
null, -- Регистрационный номер клиента
concat('adressEx', randCounter), -- Адрес клиента
concat('nameEx', randCounter), -- ФИО клиента
concat('phoneEx', randCounter), -- Телефон для связи с клиентом
intRandRange(1, 100), -- Регистрационный номер договора
concat('adressFlatEx', randCounter), -- Адрес квартиры
true,-- Наличие кодового замка на подъезде
intRandRange(1, 100),-- Количество этажей в доме
intRandRange(1, 100),-- Этаж, на котором расположена квартира
concat('typeHouseEx', randCounter), -- Тип дома (кирпичный, панельный)
concat('typeDoorEx', randCounter), -- Тип квартирной двери (мет, дер, две шт.)
true,-- Наличие балкона
concat('typeBalconyEx', randCounter) ,-- Тип балкона (отдельный, совмещенный)
decRandRange(1, 100),-- Стоимость ежемесячной оплаты
decRandRange(1, 100),-- Компенсация при краже имущества
now(),-- Начало действия договора
now(),-- Окончание действия
intRandRange(1, 100),-- Номер выезда на захват
intRandRange(1, 100),-- Номер экипажа, выезжавшего на захват
concat('chiefEx', randCounter), -- Командир экипажа
concat('brandEx', randCounter), -- Марка автомобиля
now(),-- Дата и время выезда
true,-- Вызов ложный (да/нет)
decRandRange(1, 100),-- Величина штрафа за ложный вызов
concat('documentEx', randCounter), -- Документ, оформленный при задержании
now()-- Продление срока действия договора
);
END// 


DELIMITER ;

-- заполнение таблицы данными
call addPersonArea();
call addPersonArea();
call addPersonArea();

-- получение информации о таблице
show tables;
describe person;
select phone, floors, Tax from person;




