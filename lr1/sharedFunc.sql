delimiter //
-- функция-рандом для целых чисел
CREATE function if not exists intRandRange (fromVal int, toVal int) returns int
deterministic
BEGIN 
return (SELECT (floor(RAND()*(toVal-fromVal+1)+fromVal)));
END// 

-- функция-рандом для десятичных чисел
CREATE function if not exists decRandRange (fromVal int, toVal int) returns decimal(15,2)
deterministic
BEGIN 
return (SELECT (round(RAND()*(toVal-fromVal+1)+fromVal, 2)));
END// 

-- количество полей в person
CREATE function if not exists personNumber () 
returns int
deterministic
BEGIN
return ifnull((select max(id) from person),0);
END// 


delimiter ;