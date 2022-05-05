DELIMITER // 
DROP PROCEDURE IF EXISTS qq//
CREATE PROCEDURE qq (arg int) 
BEGIN 
    declare i int default 0;
    while i<arg do
    select * from person where a=1; 
    set i = i+1;
    end while;
END// 

call qq(4);