drop database if exists test;

create database test; use test;

create table person(id int primary key auto_increment not null);
alter table person add a int;
alter table person add b int;
alter table person add c int;

insert into person values (null, 1, 2, 3); 
insert into person values (null, 4, 5, 6);
insert into person values (null, 7, 8, 9);
