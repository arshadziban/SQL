Create database labtest2
use labtest2

CREATE TABLE Orders ( 
Order_ID INT PRIMARY KEY, 
Customer_ID INT, 
Product_Name VARCHAR(50), 
Order_Date DATE, 
Quantity INT, 
Price DECIMAL(10, 2) 
); 
INSERT INTO Orders (Order_ID, Customer_ID, Product_Name, Order_Date, Quantity, Price)  
VALUES (101, 1, 'Laptop', '2021-05-01', 1, 1200.00),
(102, 2, 'Smartphone', '2020-07-15', 2, 800.00),
(103, 3, 'Tablet', '2022-01-10', 3, 600.00),
(104, 1, 'Monitor', '2023-03-20', 1, 300.00),
(105, 4, 'Laptop', '2021-08-05', 2, 2400.00);


Select * from Orders


--problem 1
--first table
CREATE TABLE Employees ( 
Employee_ID INT PRIMARY KEY,  
Names VARCHAR(50),
Department VARCHAR(50), 
Salary DECIMAL(10, 2),
Join_date Date,
Departmen_ID int 
Foreign key (Departmen_ID) references Departments (Departmen_ID));

--second table
CREATE TABLE Projects ( 
Project_ID INT PRIMARY KEY,  
Project_Names VARCHAR(50),
Employee_ID int,  
Start_Dates Date,
End_Dates Date,
Budget DECIMAL(10, 2),
Foreign key (Employee_ID) references Employees(Employee_ID));

--CREATE TABLE Projects
CREATE TABLE Departments(
Departmen_ID INT PRIMARY KEY,
Departmen_Name VARCHAR(50) );

CREATE TABLE Assignments(
Assignment_ID INT PRIMARY KEY,
Employee_ID int,
Project_ID INT,
Roles VARCHAR(50),
Start_Dates Date,
Foreign key (Employee_ID) references Employees(Employee_ID),
Foreign key (Project_ID) references Projects(Project_ID));


--problem 2
Select Product_Name
From Orders
where Quantity > 2
group by Product_Name

Select *
From Orders
where Quantity > 2

--Problem 3
Select Distinct Product_Name
From Orders
Where Product_Name LIke '%to%';

--problem 4
Select Product_Name, Quantity * Price as Total_Price , Order_Date
from Orders
Where Order_Date between '2021-01-01' and '2021-12-31'; 

-- problem 5
SELECT Product_Name, sum (Quantity) as Total_Quantity
from Orders
where Quantity > 1
group by Product_Name;

--problem 6
Update Orders 
set Price = (Price + (Price*.10))
where Product_Name = 'Laptop';


Select * from Orders