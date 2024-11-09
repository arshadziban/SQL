Create database test
use test

-- Create the 'salesman' table
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4, 2)
);

-- Insert data into 'salesman' table
INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

-- Create the 'customer' table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

-- Insert data into 'customer' table
INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002),
(3003, 'Jozy Altidore', 'Moscow', 200, 5007);

-- Create the 'orders' table
CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

-- Insert data into 'orders' table
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3007, 5001),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70013, 3045.6, '2012-04-25', 3002, 5001);



--Create a stored procedure that takes a city name as an input parameter and returns all salesman details (ID, name, city, and commission) who are located in that city.
Create proc GetSalesmenByCity
@city_name VARCHAR(50)
as
begin
select salesman_id, name, city, commission
from salesman
where city = @city_name
end

Exec GetSalesmenByCity 'New York';

--Write a stored procedure that takes a salesman's ID as an input and calculates the total purchase amount (purch_amt) from the orders table for that salesman.
create proc CalculateTotalSalesmanOrders
@salesmanID INT
as
begin
SELECT SUM(purch_amt) AS Total_Amount FROM orders WHERE salesman_id = @salesmanID;
end

exec CalculateTotalSalesmanOrders 5005 ;


--Write a stored procedure that takes two date parameters (start date and end date) and retrieves orders (order number, purchase amount, and order date) within that date range.
create procedure listordersbydaterange
    @startdate date,
    @enddate date
as
begin
    select ord_no, purch_amt, ord_date
    from orders
    where ord_date between @startdate and @enddate;
end;


-- executing
exec listordersbydaterange @startdate = '2012-06-27', @enddate = '2012-08-17';


--Create a stored procedure that calculates the average commission of salesmen in a given city. The city name should be passed as a parameter.

create procedure getavgcommissionbycity
@cityname varchar (50)
as
begin
    select avg(commission) as avg_commission
    from salesman
    where city = @cityname;
end ;

exec getavgcommissionbycity 'London';
