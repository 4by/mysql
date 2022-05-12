drop database if exists t;
create database t;
use t;

delimiter//
create trigger changeStep
before insert on t1
for each row
begin
set NEW.id = 1;
end//
delimiter;

create table if not exists t1(
id int primary key auto_increment not null,
c1 varchar(30), c2 varchar(30)
);
create table if not exists t2(
id int primary key auto_increment not null,
t1_id int not null,
foreign key (t1_id) 
references t1(id)
on update cascade
on delete cascade,
c1 varchar(30), c2 varchar(30)
);

insert into t1 values (null,'1','a');
insert into t1 values (null,'2','a');
-- insert into t2 values (null,'1','1','b');
-- insert into t2 values (null,'2','2','b');

