Create database view_practice
use view_practice

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Phone VARCHAR(15),
    TotalPurchase DECIMAL(10, 2)
);

INSERT INTO Customers VALUES
(1, 'John Doe', '555-1234', 1500),
(2, 'Jane Smith', '555-5678', 850),
(3, 'Alice Johnson', '555-8765', 11000),
(4, 'Bob Brown', '555-4321', 6000);

select * from Customers

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders VALUES
(101, 1, '2024-10-01', 'Complete'),
(102, 2, '2024-10-03', 'Pending'),
(103, 1, '2024-10-05', 'Complete'),
(104, 3, '2024-10-07', 'Pending'),
(105, 4, '2024-10-08', 'Complete');

select * from Orders

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderDetails VALUES
(1, 101, 201, 2, 50),
(2, 101, 202, 1, 150),
(3, 103, 203, 4, 25),
(4, 104, 202, 1, 150),
(5, 105, 204, 2, 80);

select * from OrderDetails 

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
);

INSERT INTO Products VALUES
(201, 'Laptop', 1),
(202, 'Smartphone', 1),
(203, 'Headphones', 2),
(204, 'Charger', 2);

select * from Products

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

INSERT INTO Categories VALUES
(1, 'Electronics'),
(2, 'Accessories');

select * from Categories



-- view problem solving

--Create a view named HighValueCustomer that shows all customers from the Customers table with a total purchase amount greater than $1,000.
CREATE VIEW HighValueCustomer AS
SELECT CustomerID, Name, Phone, TotalPurchase
FROM Customers
WHERE TotalPurchase > 1000;

SELECT * FROM HighValueCustomer;

--Create a view named OrderSummary that joins Orders and Customers tables to show each order ID, customer name, order date, and total amount.
CREATE VIEW OrderSummary AS
SELECT o.OrderID,c.Name AS CustomerName,o.OrderDate, SUM(od.Quantity * od.UnitPrice) AS TotalAmount
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID 
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, c.Name, o.OrderDate;

SELECT * FROM OrderSummary;


--Create a view ordervalue that includes the orderid, customername, and a calculated column showing the total value for each order.
create view ordervalue as
select o.orderid, c.name as customername, sum(od.quantity * od.unitprice) as totalvalue
from orders o
join customers c on o.customerid = c.customerid
join orderdetails od on o.orderid = od.orderid
group by o.orderid, c.name; 

Select * from ordervalue

--Create a view customercontacts that displays customerid, name, and phone numbers. Then, update the phone number of a specific customer through this view.
create view customercontacts as
select customerid, name, phone
from customers;

select * from customercontacts

-- example of updating phone number
update customercontacts
set phone = '555-9999'
where customerid = 1;

--Create a view customerstatus that shows each customer’s name and a status based on their purchase history.
create view customerstatus as
select name,
       case
           when totalpurchase > 10000 then 'VIP'
           when totalpurchase between 1000 and 10000 then 'Regular'
           else 'New'
       end as status
from customers;

select * from customerstatus


