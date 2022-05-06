drop database if exists qq;
create database qq;
use qq;


create table if not exists qq(
id int primary key auto_increment not null,
c1 int, c2 int
);


insert into qq values (null,1,1);
insert into qq values (null,2,2);
insert into qq values (null,1,32);
insert into qq values (null,2,2);
insert into qq values (null,1,2);