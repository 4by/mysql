-- MySQL Workbench Synchronization
-- Generated: 2022-05-13 20:25
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Eugene

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `t` ;

CREATE SCHEMA IF NOT EXISTS `U2` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `U2`.`house` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `person_id` INT(11) NOT NULL,
  `Address` VARCHAR(60) NULL DEFAULT NULL,
  `AddressFlat` VARCHAR(60) NULL DEFAULT NULL,
  `KeyVal` TINYINT(1) NULL DEFAULT NULL,
  `Floors` INT(11) NULL DEFAULT NULL,
  `Floor` INT(11) NULL DEFAULT NULL,
  `TypeHouse` VARCHAR(20) NULL DEFAULT NULL,
  `TypeDoor` VARCHAR(20) NULL DEFAULT NULL,
  `Balcony` TINYINT(1) NULL DEFAULT NULL,
  `TypeBalcony` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `person_id` (`person_id` ASC) VISIBLE,
  CONSTRAINT `house_ibfk_1`
    FOREIGN KEY (`person_id`)
    REFERENCES `U2`.`person` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `U2`.`incident` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `house_id` INT(11) NOT NULL,
  `serving_id` INT(11) NOT NULL,
  `Compensation` DECIMAL(15,2) NULL DEFAULT NULL,
  `ActionID` INT(11) NULL DEFAULT NULL,
  `PatrolID` INT(11) NULL DEFAULT NULL,
  `Chief` VARCHAR(10) NULL DEFAULT NULL,
  `Brand` VARCHAR(15) NULL DEFAULT NULL,
  `DateTime` DATETIME NULL DEFAULT NULL,
  `IsFalse` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `house_id` (`house_id` ASC) VISIBLE,
  INDEX `serving_id` (`serving_id` ASC) VISIBLE,
  CONSTRAINT `incident_ibfk_1`
    FOREIGN KEY (`house_id`)
    REFERENCES `U2`.`house` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `incident_ibfk_2`
    FOREIGN KEY (`serving_id`)
    REFERENCES `U2`.`serving` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `U2`.`person` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(60) NULL DEFAULT NULL,
  `Phone` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `U2`.`serving` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `house_id` INT(11) NOT NULL,
  `TreatyID` INT(11) NULL DEFAULT NULL,
  `Cost` DECIMAL(15,2) NULL DEFAULT NULL,
  `DateStart` DATE NULL DEFAULT NULL,
  `StopDate` DATE NULL DEFAULT NULL,
  `Prolong` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `house_id` (`house_id` ASC) VISIBLE,
  CONSTRAINT `serving_ibfk_1`
    FOREIGN KEY (`house_id`)
    REFERENCES `U2`.`house` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


DELIMITER $$
USE `U2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addHouseArea`(i int)
BEGIN 

declare houseNum int default 0;
declare personNum int default 0;


while i>0 do
set houseNum = houseNumber()+1;
insert house values (
null, 
((select id from person) order by rand() limit 1), 
concat('adressEx', houseNum), 
concat('adressFlatEx', houseNum), 
intRandRange(0,1),
intRandRange(1, 100),
intRandRange(1, 100),
concat('typeHouseEx', houseNum), 
concat('typeDoorEx', houseNum), 
intRandRange(0,1),
concat('typeBalconyEx', houseNum) 
);
set i = i-1;
end while;

END$$

DELIMITER ;

DELIMITER $$
USE `U2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addIncidentArea`(i int)
BEGIN 
declare incidentNum int default 0;
declare houseNum int default 0;
declare servingNum int default 0;
while i>0 do
set incidentNum = incidentNumber()+1;
insert incident values (
null, 
((select id from house) order by rand() limit 1), 
((select id from serving) order by rand() limit 1), 
decRandRange(1, 100),
intRandRange(1, 100),
intRandRange(1, 100),
concat('chiefEx', incidentNum), 
concat('brandEx', incidentNum), 
date_add("2017-06-15", INTERVAL intRandRange(0,200) DAY),
intRandRange(0,1),
decRandRange(1, 100),
concat('documentEx', incidentNum) 
);
set i = i-1;
end while;


END$$

DELIMITER ;

DELIMITER $$
USE `U2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addPersonArea`(i int)
BEGIN 

declare personNum int default 0;

while i>0 do
set personNum = personNumber()+1;
insert person values (
null, 
concat('nameEx', personNum), 
concat('phoneEx', personNum) 
);
set i = i-1;
end while;

END$$

DELIMITER ;

DELIMITER $$
USE `U2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addServingArea`(i int)
BEGIN 
declare houseNum int default 0;


while i>0 do
insert serving values (
null, 
((select id from house) order by rand() limit 1), 
intRandRange(1, 100), 
decRandRange(1, 100),
date_add("2017-06-15", INTERVAL intRandRange(0,100) DAY),
date_add("2017-06-15", INTERVAL intRandRange(100,200) DAY),
date_add("2017-06-15", INTERVAL intRandRange(100,200) DAY)
);
set i = i-1;
end while;

END$$

DELIMITER ;

DELIMITER $$
USE `U2`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `decRandRange`(fromVal int, toVal int) RETURNS decimal(15,2)
    DETERMINISTIC
BEGIN 
return (SELECT (round(RAND()*(toVal-fromVal+1)+fromVal, 2)));
END$$

DELIMITER ;

DELIMITER $$
USE `U2`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `houseNumber`() RETURNS int
    DETERMINISTIC
BEGIN
return ifnull((select max(id) from house), 0);
END$$

DELIMITER ;

DELIMITER $$
USE `U2`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `incidentNumber`() RETURNS int
    DETERMINISTIC
BEGIN
return ifnull((select max(id) from incident), 0);
END$$

DELIMITER ;

DELIMITER $$
USE `U2`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `intRandRange`(fromVal int, toVal int) RETURNS int
    DETERMINISTIC
BEGIN 
return (SELECT (floor(RAND()*(toVal-fromVal+1)+fromVal)));
END$$

DELIMITER ;

DELIMITER $$
USE `U2`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `personNumber`() RETURNS int
    DETERMINISTIC
BEGIN
return ifnull((select max(id) from person),0);
END$$

DELIMITER ;

DELIMITER $$
USE `U2`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `servingNumber`() RETURNS int
    DETERMINISTIC
BEGIN
return ifnull((select max(id) from serving), 0);
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
