Create database lab_test02
use lab_test02

-- Table: SupplierInfo
CREATE TABLE SupplierInfo (
    SupplierID CHAR(5) PRIMARY KEY,
    SupplierName VARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(15),
    Location VARCHAR(50)
);

-- Table: ProductInfo
CREATE TABLE ProductInfo (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT,
    SupplierID CHAR(5),
    FOREIGN KEY (SupplierID) REFERENCES SupplierInfo(SupplierID)
);

-- Table: CustomerOrders
CREATE TABLE CustomerOrders (
    OrderID CHAR(5) PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (ProductID) REFERENCES ProductInfo(ProductID)
);


INSERT INTO SupplierInfo (SupplierID, SupplierName, ContactNumber, Location) VALUES
('S101', 'TechZone', '01712345678', 'Dhaka'),
('S102', 'Digital Mart', '01998765432', 'Chattogram'),
('S103', 'Furniture World', '01545678912', 'Sylhet'),
('S104', 'Home Essentials', '01611223344', 'Rajshahi');


-- Insert values into ProductInfo table
INSERT INTO ProductInfo (ProductID, ProductName, Category, Price, Stock, SupplierID) VALUES
(301, 'Wireless Mouse', 'Electronics', 1500.00, 200, 'S101'),
(302, 'Gaming Keyboard', 'Electronics', 4500.00, 150, 'S102'),
(303, 'Office Chair', 'Furniture', 8500.00, 50, 'S103'),
(304, 'Wooden Desk', 'Furniture', 12500.00, 30, 'S104'),
(305, 'Power Bank', 'Electronics', 2500.00, 500, 'S102');

select * from ProductInfo

-- Insert values into CustomerOrders table
INSERT INTO CustomerOrders (OrderID, CustomerName, ProductID, Quantity, OrderDate, Status) VALUES
('O1001', 'Alice Smith', 301, 2, '2023-11-01', 'Delivered'),
('O1002', 'Bob Williams', 303, 1, '2023-11-02', 'Pending'),
('O1003', 'Carol Johnson', 303, 3, '2023-11-03', 'Delivered'),
('O1004', 'David Brown', 302, 1, '2023-11-05', 'Pending'),
('O1005', 'Emma Davis', 304, 2, '2023-11-06', 'Pending');


--Problem Solving

-- 1. Find the total number of products available in each category.
select Category, sum(Stock) as Total_Stock
From ProductInfo 
Group by Category

--2. Calculate the average price of products supplied by each supplier.
Select SupplierName, AVG (Price) aS AveragePrice
From SupplierInfo 
join ProductInfo on ProductInfo.SupplierID = SupplierInfo.SupplierID
group by SupplierName 

--3. Find the number of orders placed by each customer.
SELECT CustomerName, COUNT(OrderID) AS OrderCount
FROM CustomerOrders
GROUP BY CustomerName;

--4. Find the suppliers who have more than 100 products in stock.
Select SupplierName, sum (Stock) aS TotalStock
From SupplierInfo 
join ProductInfo on ProductInfo.SupplierID = SupplierInfo.SupplierID
group by SupplierName
having sum (Stock) > 100

--5. Find the names of all suppliers who supply products in "Electronics".
select DISTINCT s.SupplierName
from SupplierInfo s
JOIN ProductInfo p ON s.SupplierID = p.SupplierID
where p.Category = 'Electronics';

--6. Find the names and locations of all suppliers whose products fall under the "Furniture" category.
select distinct s.suppliername, s.location
from supplierinfo s
join productinfo p on s.supplierid = p.supplierid
where p.category = 'Furniture';

--7. Find the names, locations, and contact numbers of suppliers who provide products priced above 10,000 BDT.
select distinct s.suppliername, s.location,s.ContactNumber
from supplierinfo s
join productinfo p on s.supplierid = p.supplierid
where p.price > 10000;


--8. Find all products not supplied by "TechZone".
select p.productname
from productinfo p
where p.supplierid <> (
    select supplierid 
    from supplierinfo 
    where suppliername = 'TechZone'
);

select p.productname
from productinfo p 
join supplierinfo s on s.supplierid = p.supplierid
where s.SupplierName != 'TechZone'

--9. Find the names of all products supplied by suppliers located in "Rajshahi".
select p.ProductName
from ProductInfo p
join supplierinfo s on s.supplierid = p.supplierid
where s.Location = 'Rajshahi'

--10 Find all customers who ordered products with a price higher than the price of any "Power Bank".
select distinct o.customername
from customerorders o
join productinfo p on o.productid = p.productid
where p.price > (select max(price) from productinfo where productname = 'Power Bank');

SELECT DISTINCT o.customername
FROM customerorders o
JOIN productinfo p ON o.productid = p.productid
JOIN productinfo mp_product ON mp_product.productname = 'Power Bank'
WHERE p.price > mp_product.price;

--11. Find all products priced above the average price of all products in their category.
select p.productname, p.category, p.price
from productinfo p
where p.price > (
select avg(p2.price)
from productinfo p2
where p2.category = p.category
);

--12. Find the supplier who has supplied the most number of products.
select TOP 1 s.suppliername
from supplierinfo s
join productinfo p on s.supplierid = p.supplierid
group by s.suppliername
order by count(p.productid) desc

--13. Find the supplier whose supplied products have the lowest total stock.
select top 1 s.suppliername
from supplierinfo s
join productinfo p on s.supplierid = p.supplierid
group by s.suppliername
order by sum(p.stock) asc

--14. Increase the stock of all products supplied by "Digital Mart" by 10%.
update productinfo
set stock = stock * 1.10
where supplierid = (
    select supplierid 
    from supplierinfo 
    where suppliername = 'Digital Mart'
);

Select * from productinfo


--15. How many units of the product "Wireless Mouse" are in stock, supplied by "TechZone"?
select SUM(Stock) AS TotalStock
from ProductInfo p
JOIN SupplierInfo s ON p.SupplierID = s.SupplierID
where p.ProductName = 'Wireless Mouse' AND s.SupplierName = 'TechZone';

--16. How many units of the product "Wireless Mouse" are in stock for each supplier?
select s.SupplierName, SUM(p.Stock) as TotalStock
from ProductInfo p
JOIN SupplierInfo s ON p.SupplierID = s.SupplierID
where p.ProductName = 'Wireless Mouse'
group by s.SupplierName;
