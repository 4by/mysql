-- (пере)инициализация БД
drop database if exists monobd;
create database monobd;
use monobd;

-- импорт общих функций
source (1)sharedFunc.sql;

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


-- процедура для создания поля person
CREATE PROCEDURE if not exists addPersonArea (i int) 
BEGIN 
declare personNum int default 0;
while i>0 do
set personNum = personNumber() + 1;
insert into person values (
null, -- Регистрационный номер клиента
concat('adressEx', personNum), -- Адрес клиента
concat('name surname fathname ex', personNum), -- ФИО клиента
concat('phoneEx', personNum), -- Телефон для связи с клиентом
intRandRange(1, 100), -- Регистрационный номер договора
concat('adressFlatEx', personNum), -- Адрес квартиры
intRandRange(0,1),-- Наличие кодового замка на подъезде
intRandRange(1, 100),-- Количество этажей в доме
intRandRange(1, 100),-- Этаж, на котором расположена квартира
concat('typeHouseEx', personNum), -- Тип дома (кирпичный, панельный)
concat('typeDoorEx', personNum), -- Тип квартирной двери (мет, дер, две шт.)
intRandRange(0,1),-- Наличие балкона
concat('typeBalconyEx', personNum) ,-- Тип балкона (отдельный, совмещенный)
decRandRange(1, 100),-- Стоимость ежемесячной оплаты
decRandRange(1, 100),-- Компенсация при краже имущества
date_add("2017-06-15", INTERVAL intRandRange(0,100) DAY),-- Начало действия договора
date_add("2017-06-15", INTERVAL intRandRange(100,200) DAY),-- Окончание действия
intRandRange(1, 100),-- Номер выезда на захват
intRandRange(1, 100),-- Номер экипажа, выезжавшего на захват
concat('chiefEx', personNum), -- Командир экипажа
concat('brandEx', personNum), -- Марка автомобиля
date_add("2017-06-15", INTERVAL intRandRange(0,200) DAY),-- Дата и время выезда
intRandRange(0,1),-- Вызов ложный (да/нет)
decRandRange(1, 100),-- Величина штрафа за ложный вызов
concat('documentEx', personNum), -- Документ, оформленный при задержании
date_add("2017-06-15", INTERVAL intRandRange(100,200) DAY)-- Продление срока действия договора
);
set i = i-1;
end while;

END// 


DELIMITER ;

-- заполнение таблицы данными
call addPersonArea(3);

-- получение информации о таблице полями
-- (закомментировал, чтобы не мешало)
-- show tables;
-- describe person;
-- select phone, floors, prolong from person;




