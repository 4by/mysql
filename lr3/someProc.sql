delimiter //

CREATE procedure if not exists addTo50 ()
begin
declare personNum int default (select count(*) from person);
declare needToAdd int default (50 - personNum);
select needToAdd;
-- while 
end//

delimiter ;


call addTo50();