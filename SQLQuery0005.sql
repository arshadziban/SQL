--create database
create database vu
--use database
use vu

--1 create table named Student
create table Student(
id int,
Names varchar(40),
Semester varchar (30),
Credit_Taken int,
Age int,
Result float,
Section varchar(30),
Batch int,
CourseCode varchar(30),
Department varchar(20)
);


--2 insert values
INSERT INTO Student (id,Names,Semester,Credit_Taken,Age,Result,Section,Batch,CourseCode,Department)
values
(161311044,'Dola', '7th', 13, 21, 3.00, 'B', 11, 'CSE-312', 'CSE' ),
(161311045,'Atik', '7th', 11, 20, 3.3, 'B', 11, 'CSE-311', 'EEE' ),
(161311081,'Habib', '7th', 10, 22, 3.1, 'C', 11, 'CSE-313', 'EEE' ),
(161311082,'Farzana', '7th', 12, 20, 3.5, 'C', 11, 'CSE-314', 'ICT' ),
(161311084,'Sakib', '7th', 13, 22, 3.6, 'C', 11, 'CSE-312', 'ICT' ),
(171311001,'Sadia', '4th', 11, 20, 3, 'A', 14, 'CSE-213', 'CSE' ),
(171311002,'Nozir', '4th', 11, 19, 3.25, 'A', 14, 'CSE-214', 'CSE' ),
(171311001,'Sadia', '4th', 11, 20, 3, 'A', 14, 'CSE-213', 'CSE' ),
(171311002,'Nazir',' 4th', 11, 19,3.25, 'A', 14, 'CSE-214','CSE'),
(171311003,'Akib',' 4th', 10, 21, 3.7, 'A', 14, 'CSE-211', 'ICT'),
(171311042,'Biplob', '4th', 11, 23, 3.8, 'B', 14, 'CSE-212', 'EEE'),
(171311043,'Lincon', '4th', 10, 21, 2.5, 'B', 14, 'CSE-212', 'EEE');


--3 Find all the info
SELECT*FROM Student

--4
select Names, Batch,Result,Department
from Student
Where Section='B'

--5
select Names,Semester,Result,Age,Credit_Taken
from Student

--6
select Names
from Student
where Age =20

--7
select Semester,Result,Age
from Student
where Names= 'Akib'

--8

select Department,Age,Semester
From Student
Where Age>20

--9
select Department,Age,Semester
From Student
Where Age not in (20)

--10
select top 5*
from Student


--11 add column
Alter table  Student
add Addresses Varchar (30) 

--12
Alter table Student
alter column Addresses INT


--13
select Names ,Age
From Student
Where Age>(
SELECT Age 
From Student
Where  Names= 'Akib'
);

--14
select MAX (Result) FROM  Student