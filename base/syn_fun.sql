drop database if exists app;
drop database if exists lib;
CREATE DATABASE app;
CREATE DATABASE lib;


use lib;

DELIMITER $$

CREATE FUNCTION if not exists demo(str VARCHAR(20)) RETURNS VARCHAR(20)
deterministic
BEGIN
RETURN CONCAT('"',str,'"');
END;
$$

DELIMITER ;



use app;

DELIMITER $$

CREATE FUNCTION if not exists demo(str VARCHAR(20)) RETURNS VARCHAR(20)
deterministic
BEGIN
RETURN lib.demo(str);
END;
$$

DELIMITER ;

SELECT demo('Ciao amico!');