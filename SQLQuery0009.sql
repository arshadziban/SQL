Create Database EMS
use EMS

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO Employees (employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES 
(1, 'John', 'Doe', 1, 75000.00, '2023-01-15'),
(2, 'Jane', 'Smith', 2, 68000.00, '2022-07-20'),
(3, 'Michael', 'Johnson', 1, 85000.00, '2023-06-10'),
(4, 'Emily', 'Davis', 3, 50000.00, '2021-03-11'),
(5, 'David', 'Williams', 2, 60000.00, '2022-11-23'),
(6, 'Sarah', 'Miller', 3, 52000.00, '2023-05-01'),
(7, 'James', 'Brown', 1, 90000.00, '2021-12-30'),
(8, 'Linda', 'Taylor', 4, 48000.00, '2022-10-10'),
(9, 'Robert', 'Moore', 4, 72000.00, '2023-03-05'),
(10, 'Karen', 'Harris', 2, 64000.00, '2023-04-25');


Select * From Employees

INSERT INTO Departments (department_id, department_name)
VALUES 
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'HR'),
(4, 'Sales');

Select * From Departments

--Find Employees Earning More than Department's Average Salary
SELECT E.employee_id, E.first_name, E.last_name, E.salary, D.department_name
FROM Employees E
JOIN Departments D ON E.department_id = D.department_id
WHERE E.salary > (
    SELECT AVG(E2.salary)
    FROM Employees E2
    WHERE E2.department_id = E.department_id
);


--Find Recently Hired Employees: who were hired in the last 6 months.
SELECT employee_id, first_name, last_name, salary, hire_date
FROM Employees
WHERE hire_date >= DATEADD(MONTH, -6, GETDATE());


--Department-wise Employee Count: how many employees are there in each department.
SELECT D.department_name, COUNT(E.employee_id) AS employee_count
FROM Departments D
LEFT JOIN Employees E ON D.department_id = E.department_id
GROUP BY D.department_name;



--Top 5 Highest Paid Employees:the top 5 highest-paid employees along with their department names.
SELECT TOP 5 E.employee_id, E.first_name, E.last_name, E.salary, D.department_name
FROM Employees E
JOIN Departments D ON E.department_id = D.department_id
ORDER BY E.salary DESC;



--List of Departments without Employees:list all departments that do not have any employees.
SELECT D.department_name
FROM Departments D
LEFT JOIN Employees E ON D.department_id = E.department_id
WHERE E.employee_id IS NULL;
