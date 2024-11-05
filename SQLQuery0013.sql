create database cascade01;
use cascade01;

-- Cascading on Update
-- Cascading on Delete

create table department(
    deptid int primary key not null,
    deptname varchar(15)
);

create table employee(
    empid int,
    empname varchar(15),
    deptid int,
    foreign key(deptid) references department(deptid) on update cascade on delete cascade -- both relations
);

insert into department values(230, 'cse'), (231, 'eee'), (233, 'ece');
insert into employee values(2341, 'rifat', 233), (2344, 'jannat', 230); 

select * from department;
select * from employee;

update department set deptid = 235 where deptid = 230;

create table student(
    studentid int,
    deptid int,
    foreign key(deptid) references department(deptid) on delete cascade
);

insert into student values(223311002, 231), (223311007, 233), (223311022, 235);

delete from department where deptid = 231;

select * from department;
select * from student;
select * from employee;