CREATE DATABASE practice
USE practice

-- Create Tables

-- Create table for `meve_employee`
CREATE TABLE meve_employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50)
);

-- Insert data into `meve_employee`
INSERT INTO meve_employee (employee_name, street, city)
VALUES 
('Arif', '51 upashahar', 'Rajshahi'),
('Sumon', '52 east', 'Moynamoti'),
('Sagor', 'Neemgachhi', 'Sirajgonj'),
('Abdul', 'Binodpur', 'Rajshahi'),
('Himesh', 'Nazrul avenue', 'Dhaka'),
('Amirul', 'Chawk bazar', 'Sylhet'),
('Sajib', '99 north', 'Chittagong');


-- Create table for `meve_company`
CREATE TABLE meve_company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- Insert data into `meve_company`
INSERT INTO meve_company (company_name, city)
VALUES
('Agrani', 'Rajshahi'),
('Sonali', 'Sylhet'),
('Janata', 'Dhaka');

-- 1. Create table for `meve_works`
CREATE TABLE meve_works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary INT,
    PRIMARY KEY (employee_name, company_name),
    FOREIGN KEY (employee_name) REFERENCES meve_employee(employee_name),
    FOREIGN KEY (company_name) REFERENCES meve_company(company_name)
);
-- Insert data into `meve_works`
INSERT INTO meve_works (employee_name, company_name, salary)
VALUES
('Sumon', 'Agrani', 12000),
('Abdul', 'Sonali', 13000),
('Himesh', 'Agrani', 6000),
('Amirul', 'Sonali', 20000),
('Sagor', 'Sonali', 8000),
('Arif', 'Janata', 13000),
('Sajib', 'Janata', 9000);


-- Create table for `meve_manages`
CREATE TABLE meve_manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    PRIMARY KEY (employee_name),
    FOREIGN KEY (employee_name) REFERENCES meve_employee(employee_name),
    FOREIGN KEY (manager_name) REFERENCES meve_employee(employee_name)
);

-- Insert data into `meve_manages`
INSERT INTO meve_manages (employee_name, manager_name)
VALUES
('Amirul', 'Amirul'),
('Abdul', 'Amirul'),
('Sagor', 'Amirul'),
('Sumon', 'Sumon'),
('Himesh', 'Sumon'),
('Arif', 'Arif'),
('Sajib', 'Arif');

--Solving Problems

--2. Find the names of all employees who work for "Sonali".
select employee_name as Worked_Sonali_Bank from meve_works
where company_name =  'Sonali'


--3. Find the names, streets, and city residence of all employees who work for "Agrani".
select e.employee_name, e.street, e.city from meve_employee e
join meve_works w on e.employee_name = w.employee_name
where w.company_name =  'Agrani'

--4. Find the names, streets, and city residence of all employees who work for "Sonali" and earn more than 1,20,000 per annum.
select e.employee_name, e.street, e.city from meve_employee e
join meve_works w on e.employee_name = w.employee_name
where w.company_name =  'Sonali' and w.salary * 12 > 120000


--5. Find all employees who live in the same cities as the companies for which they work.
SELECT DISTINCT e.employee_name
from meve_employee e
JOIN meve_works w ON e.employee_name = w.employee_name
JOIN meve_company c ON w.company_name = c.company_name
where e.city = c.city;

SELECT * from meve_company

--6. Find all employees in the database who live in the same cities and on the same streets as their managers. 
select e.employee_name from meve_employee e
JOIN meve_manages m on e.employee_name = m.employee_name
JOIN meve_employee mng on m.manager_name = mng.employee_name
where e.city = mng.city and e.street = mng.street;

-- 7. Find all employees in the database who do not work for "Sonali"
select e.employee_name
from meve_employee e
JOIN meve_works w on e.employee_name = w.employee_name
where w.company_name != 'Sonali';


--8. Find all employees in the database who earn more than each employee of "Janata" Bank.
select e.employee_name
from meve_works e
where e.salary > all (
    select w.salary
    from meve_works w
    where w.company_name = 'Janata'
);

--9. Find all employees who earn more than the average salary of all employees of their companies.
select w.employee_name
from meve_works w
join (
    select company_name, avg(salary) as avg_salary
    from meve_works
    group by company_name
) c_avg on w.company_name = c_avg.company_name
where w.salary > c_avg.avg_salary;

--10. Find the company that has the most employees.
select top 1 w.company_name
from meve_works w
group by w.company_name
order by count(w.employee_name) desc;

--11. Find the company that has the smallest payroll.
select top 1 w.company_name
from meve_works w
group by w.company_name
order by count(w.employee_name) asc;