create database sample16
use sample16

-- create 1st table
CREATE TABLE Employee (
    employee_name VARCHAR(300) PRIMARY KEY,
    street VARCHAR(300),
    city VARCHAR(300)
);
--insert value on 2nd table
insert into Employee (employee_name,street,city)
values 
('Arif','51 uposhahar','Rajshahi'),
('sumon','12 east','Moynamoti'),
('Sagor','Neemgschi','Sirajgoang'),
('Abdul','Binodpur','Rajshahi'),
('Hemish','Nazrul avenue','Dhaka'),
('Amirul','Chawk bazar','Dhaka'),
('Sajib','99 north','Rajshahi')

--Show Table
Select * From Employee

-- create 2nd table
CREATE TABLe Works (
 employee_name VARCHAR(300),
 company_name VARCHAR(300),
 salary int ,
 Foreign key (employee_name) references Employee (employee_name)
 );

 --2nd table value insert
INSERT INTO Works(employee_name, company_name, salary)
VALUES 
('Sumon', 'Agrani', 1200),
('Abdul', 'Sonali', 13000),
('Hemish', 'Agrani', 6000),
('Amirul', 'Sonali', 20000),
('Sagor', 'Sonali', 8000),
('Arif', 'Janata', 13000),
('Sajib', 'Janata', 9000);


---Find the names of all employees who live in Rajshahi city
select employee_name 
from Employee 
Where city = 'Rajshahi'

-- Find the names and street addresses of all employees who live in Rajshahi city
SELECT employee_name, street 
FROM Employee 
WHERE city = 'Rajshahi';
 

 --Find the names of all employees who work for:
--(i) Sonali
--(ii) Agrani
--(iii) Janata
SELECT employee_name
FROM Works
WHERE company_name IN ('Sonali', 'Agrani', 'Janata');


--Find the names of all employees who work for:
--(i) Sonali
--(ii) Agrani
--(iii) Janata
SELECT salary
FROM Works
WHERE company_name IN ('Sonali', 'Agrani', 'Janata');


--Find the names of all employees whose salary is:
--(i) 12000
--(ii) >= 12000
--(iii) < 12000
-- (i) 12000
-- (i) 12000
SELECT employee_name
FROM Works
WHERE salary = 1200;

-- (ii) >= 12000
SELECT employee_name
FROM Works
WHERE salary >= 12000;

-- (iii) < 12000
SELECT employee_name
FROM Works
WHERE salary < 12000;


--Find the names and company of all employees whose salary is:
--(i) 12000
--(ii) >= 12000
--(iii) < 12000
-- (i) 12000
SELECT employee_name, company_name
FROM Works
WHERE salary = 1200;

-- (ii) >= 12000
SELECT employee_name, company_name
FROM Works
WHERE salary >= 12000;

-- (iii) < 12000
SELECT employee_name, company_name
FROM Works
WHERE salary < 12000;


--Find the names, streets, and cities of all employees who work for Agrani
SELECT e.employee_name, e.street, e.city
FROM Employee e
JOIN Works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'Agrani';


-- Find the names, streets, and cities of all employees who earn >= 10000:
SELECT e.employee_name, e.street, e.city
FROM Employee e
JOIN Works w ON e.employee_name = w.employee_name
WHERE w.salary >= 10000;


--Find the names, company, and salary of all employees who live in Rajshahi city
SELECT e.employee_name, w.company_name, w.salary
FROM Employee e
JOIN Works w ON e.employee_name = w.employee_name
WHERE e.city = 'Rajshahi';

--Find the names, streets, cities, and companies of all employees who earn >= 10000
SELECT e.employee_name, e.street, e.city, w.company_name
FROM Employee e
JOIN Works w ON e.employee_name = w.employee_name
WHERE w.salary >= 10000;

--Find the names, streets, and cities of all employees who work for Sonali and earn more than 12000
SELECT e.employee_name, e.street, e.city
FROM Employee e
JOIN Works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'Sonali' AND w.salary > 12000;



--Find all employees in the database who do not work for Sonali Bank
SELECT e.employee_name
FROM Employee e
WHERE e.employee_name NOT IN (
    SELECT employee_name
    FROM Works
    WHERE company_name = 'Sonali'
);


--Modify the database so that "Arif" now lives in Natore
UPDATE Employee
SET city = 'Natore'
WHERE employee_name = 'Arif';

-- Give all employees of "Agrani" Bank a 10 percent salary raise
UPDATE Works
SET salary = salary * 1.10
WHERE company_name = 'Agrani';


--Delete all records for Sagor in the Employee table
DELETE FROM Employee
WHERE employee_name = 'Sagor';

--Add a column manager in the Works table
ALTER TABLE Works
ADD manager VARCHAR(300);
