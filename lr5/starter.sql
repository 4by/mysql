-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema U2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema U2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `U2` ;
USE `U2` ;

-- -----------------------------------------------------
-- Table `U2`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `U2`.`student` ;

CREATE TABLE IF NOT EXISTS `U2`.`student` (
  `id` INT NOT NULL,
  `fac_code` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `U2`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `U2`.`book` ;

CREATE TABLE IF NOT EXISTS `U2`.`book` (
  `id` INT NOT NULL,
  `stud_id` INT NULL,
  `exp_date` DATE NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_1_idx` (`stud_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_1`
    FOREIGN KEY (`stud_id`)
    REFERENCES `U2`.`student` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `U2`.`student`
-- -----------------------------------------------------
START TRANSACTION;
USE `U2`;
INSERT INTO `U2`.`student` (`id`, `fac_code`, `name`) VALUES (1, 123, 's1');
INSERT INTO `U2`.`student` (`id`, `fac_code`, `name`) VALUES (2, 121, 's2');
INSERT INTO `U2`.`student` (`id`, `fac_code`, `name`) VALUES (3, 223, 's3');
INSERT INTO `U2`.`student` (`id`, `fac_code`, `name`) VALUES (4, 121, 's4');
INSERT INTO `U2`.`student` (`id`, `fac_code`, `name`) VALUES (5, 122, 's5');

COMMIT;


-- -----------------------------------------------------
-- Data for table `U2`.`book`
-- -----------------------------------------------------
START TRANSACTION;
USE `U2`;
INSERT INTO `U2`.`book` (`id`, `stud_id`, `exp_date`, `name`) VALUES (1, 3, '2011-03-12', 'b1');
INSERT INTO `U2`.`book` (`id`, `stud_id`, `exp_date`, `name`) VALUES (2, 2, '2011-05-23', 'b2');
INSERT INTO `U2`.`book` (`id`, `stud_id`, `exp_date`, `name`) VALUES (3, 3, '2011-03-12', 'b3');
INSERT INTO `U2`.`book` (`id`, `stud_id`, `exp_date`, `name`) VALUES (4, 1, '2011-03-14', 'b4');
INSERT INTO `U2`.`book` (`id`, `stud_id`, `exp_date`, `name`) VALUES (5, 1, '2011-04-04', 'b5');

COMMIT;

