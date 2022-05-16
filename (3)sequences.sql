delimiter //

create trigger multbd.person_sequence
before insert on multbd.person
for each row
begin
set NEW.id = multbd.personNumber() + 2;
end//

create trigger multbd.house_sequence
before insert on multbd.house
for each row
begin
set NEW.id = multbd.houseNumber() + 3;
end//

delimiter ;