DELIMITER // 

CREATE PROCEDURE if not exists addServingArea (arg varchar(14)) 
BEGIN 
select id from arg;
END// 

DELIMITER ;



create table if not exists serving(
id int primary key auto_increment not null
);

call addServingArea(`serving`);
