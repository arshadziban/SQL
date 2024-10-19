--Create databse
Create database lab
--use database
use lab

--Create Table
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_Name VARCHAR(100),
    Order_Date DATE,
    Quantity INT,
    Price DECIMAL(10, 2)
);

-- Insert Data
INSERT INTO Orders (Order_ID, Customer_ID, Product_Name, Order_Date, Quantity, Price)
VALUES 
(101, 1, 'Laptop', '2021-05-01', 1, 1200),
(102, 2, 'Smartphone', '2020-07-15', 2, 800),
(103, 3, 'Tablet', '2022-01-10', 3, 600),
(104, 1, 'Monitor', '2023-03-20', 1, 300),
(105, 4, 'Laptop', '2021-08-05', 2, 2400);

-- show database
SELECT * FROM Orders;

--add new column
Alter table Orders
add email varchar(30)

--permanent delete column named email
Alter table Orders
drop column email

--Modifying an existing column
EXEC sp_rename 'Orders.Price', 'Prices', 'COLUMN';

--Select Specific column
Select Product_Name, Prices
From Orders

--Filtering data with condition
Select Product_Name, Prices
from Orders 
Where Prices > 300

--Sorting data
Select Product_Name, Prices ,Quantity
from Orders
Order by Prices ASC

--String Matching
Select*
from Orders
where Product_Name LIKE '____o%'

--Avg price
SElect AVG(Prices) as Avarage_Price 
from Orders

--Total sales
Select count(*) as Total_Sales
from Orders

--maximum Price
Select MAX(Prices) AS MAX_Price
From Orders

--Minimum Price
Select MIN(Prices) AS MIN_Price
From Orders

--Total Revenue
Select Sum (Prices * Quantity ) AS Total_Revenue
from Orders

--Total Quantity
select Product_Name , sum(Quantity) as Total_Quantity
From Orders
Group by Product_Name

--Total Sales
select Product_Name ,sum(Prices * Quantity) as Total_Sales
From Orders
Group by Product_Name

--Avg price
select Product_Name ,AVG(Prices) as AVG_Price
From Orders
Group by Product_Name


-- filtering data using having Clause
Select Product_Name , Sum ( Prices * Quantity ) AS Total_Revenue
from Orders
Group by Product_Name
having Sum ( Prices * Quantity ) > 300


--Price matching with laptop
Select *
From Orders
Where Prices IN (Select Prices From Orders Where Product_Name = 'Laptop');

--does not matching with product laptop
Select *
From Orders
Where Prices NOT IN (Select Prices From Orders Where Product_Name = 'Laptop');


-- Large price than all product's price
SELECT *
FROM Orders 
WHERE Prices > ALL (SELECT Prices FROM Orders);

--another sale of same porduct with different price
SELECT *
FROM Orders O1
where EXISTS (
SELECT *
FROM Orders O2
where O1.Product_Name = O2.Product_Name and O1.Prices <> O2.Prices);
