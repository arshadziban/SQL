create database lab_test;
use lab_test;

CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission float
);

INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', '  ' , 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

select*from salesman;




CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', null , 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002),
(3003, 'Jozy Altidore', 'Moscow', 200, 5007);

select*from customer;


CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt float,
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.6, '2012-04-25', 3002, 5001);

select*from orders;


--1 Write a query to create a view that finds the salesman who has the customer with the highest order of a day.
Create view highest_order_salesman as
SELECT DISTINCT o.ord_date, 
s.salesman_id, 
s.name AS salesman_name,
c.cust_name,
o.purch_amt
FROM salesman s
JOIN orders o ON s.salesman_id = o.salesman_id
JOIN customer c ON o.customer_id = c.customer_id
where o.purch_amt IN (
select MAX(purch_amt) FROM orders o2 where o2.ord_date = o.ord_date
);

SELECT * FROM highest_order_salesman

-- 2 Write a query to create a view that finds the salesman who has the customer with the highest order at least 3 times on a day.
create view top_salesmans as
select distinct s.salesman_id, 
s.name as salesman_name,
o.ord_date,
count(*) as highest_order_count
from salesman s
join orders o on s.salesman_id = o.salesman_id
where o.purch_amt in (
select max(purch_amt) from orders o2 where o2.ord_date = o.ord_date
)
group by s.salesman_id, s.name, o.ord_date
having count(*) > 3;

select * from top_salesmans
order by ord_date;

drop view top_salesmans

-- 3. Write a query to create a view that shows all of the customers who have the highest grade.
create  view highest_grade as
select c.customer_id, c.cust_name, c.city, c.grade
from customer c
where c.grade = (select MAX(grade) from customer);

Select * FROM highest_grade


-- 4. Write a query to create a view that shows the number of the salesman in each city. 
create view salesman_count_by_city as
select s.city, count(s.salesman_id) AS number_of_salesmen
from salesman s
group by s.city;

Select * FROM salesman_count_by_city

--5 Write a query to create a view that shows the average and total orders for each salesman after his or her name. (Assume all names are unique)
create view order_summary as
select s.salesman_id, s.name AS salesman_name,AVG(o.purch_amt) as avg_order_amount, SUM(o.purch_amt) AS total_order_amount
from
salesman s
join orders o on s.salesman_id = o.salesman_id
group by s.salesman_id, s.name;

Select * FROM order_summary

--6 Write a query to create a view that shows each salesman with more than one customers. 
create view salesmen_multiple_customers as
select s.salesman_id, s.name AS salesman_name, count (c.customer_id) as number_of_customers
from salesman s
join customer c ON s.salesman_id = c.salesman_id
group by s.salesman_id, s.name
having count(c.customer_id) > 1;


Select * FROM salesmen_multiple_customers

--7 Write a query to create a view that shows all matches of customers with salesman such that at least one customer in the city of customer served by a salesman in the city of the salesman.create view customer_salesman_city_match as
select distinct c1.cust_name as customer_name,
       c1.city as customer_city,
       s.name as salesman_name,
       s.city as salesman_city
from customer c1, salesman s
where exists (
    select 1 
    from customer c2 
    where c2.city = s.city
);


select * from customer_salesman_city_match

--8  Write a query to create a view that shows the number of orders in each day. 
create view orders_per_day AS
SELECT o.ord_date, count(o.ord_no) as number_of_orders
from orders o
group by o.ord_date;

Select * FROM orders_per_day 

--9 Write a query to create a view that finds the salesmen who issued orders on October 10th, 2012. 
create view salesmen_orders as
select DISTINCT s.salesman_id, s.name as salesman_name
FROM orders o
JOIN salesman s on o.salesman_id = s.salesman_id
where o.ord_date = '2012-10-10';

Select * FROM salesmen_orders

-- 10.Write a query to create a view that finds the salesmen who issued orders on either August 17th, 2012 or October 10th, 2012.
CREATE VIEW salesmen_orders_date AS
select DISTINCT s.salesman_id, s.name AS salesman_name
FROM orders o
JOIN salesman s ON o.salesman_id = s.salesman_id
where o.ord_date IN ('2012-08-17', '2012-10-10');

Select * FROM salesmen_orders_date