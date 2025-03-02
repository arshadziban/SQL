-- create database
create database test01;
use test01;

-- create employees table
create table employees (
    employeeid int primary key,
    name varchar(50),
    age int,
    department varchar(50),
    salary int,
    joiningdate date
);

-- insert data into employees table
insert into employees values
(101, 'Alice', 30, 'HR', 50000, '2019-06-15'),
(102, 'Bob', 28, 'IT', 60000, '2020-08-23'),
(103, 'Charlie', 35, 'Finance', 70000, '2018-01-10'),
(104, 'David', 40, 'IT', 80000, '2016-05-14'),
(105, 'Eve', 25, 'Marketing', 45000, '2021-03-05');

-- create orders table
create table orders (
    orderid int primary key,
    customername varchar(50),
    product varchar(50),
    quantity int,
    price decimal(10,2),
    orderdate date
);

-- insert data into orders table
insert into orders values
(1, 'John Doe', 'Laptop', 1, 1000, '2024-02-20'),
(2, 'Jane Smith', 'Smartphone', 2, 1200, '2024-02-22'),
(3, 'Alex Brown', 'Tablet', 1, 500, '2024-02-25'),
(4, 'Maria Lee', 'Monitor', 3, 600, '2024-02-28'),
(5, 'Tom Wilson', 'Keyboard', 2, 100, '2024-03-01');

-- create students table
create table students (
    studentid int primary key,
    name varchar(50),
    age int,
    major varchar(50),
    gpa decimal(3,2),
    graduationyear int
);

-- insert data into students table
insert into students values
(201, 'Sarah', 22, 'Computer Science', 3.8, 2025),
(202, 'John', 23, 'Mathematics', 3.6, 2024),
(203, 'Emily', 21, 'Physics', 3.9, 2026),
(204, 'Mark', 24, 'Engineering', 3.5, 2023),
(205, 'Anna', 22, 'Economics', 3.7, 2025);

-- sql queries for practice


-- 1. retrieve all employees from the it department
select * from employees where department = 'IT';

-- 2. find students with a gpa greater than 3.7
select * from students where gpa > 3.7;

-- 3. list all orders placed after february 20, 2024
select * from orders where orderdate > '2024-02-20';

-- 4. calculate the total salary paid by each department
select department, sum(salary) as totalsalary from employees group by department;

-- 5. find the total number of orders per customer
select customername, count(*) as totalorders from orders group by customername;

-- 6. find the average age of employees in each department
select department, avg(age) as avgage from employees group by department;

-- 7. retrieve the highest-paid employee in each department
select e.department, e.name, e.salary
from employees e
join (
    select department, max(salary) as max_salary
    from employees
    group by department
) as max_salaries
on e.department = max_salaries.department and e.salary = max_salaries.max_salary;


-- 8. retrieve the most expensive order placed
select * from orders where price = (select max(price) from orders);

-- 9. count the number of students per major
select major, count(*) as studentcount from students group by major;

-- 10. find employees who joined before 2020
select * from employees where joiningdate < '2020-01-01';
