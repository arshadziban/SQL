Create database lab2;
USE lab2;

CREATE TABLE Branch
(branch_name varchar(50),
branch_city varchar(50),
assets int )

SELECT *FROM Branch

INSERT INTO Branch (branch_name,branch_city,assets)
VALUES ('zero point','Rajshai', 1000),
('Talaimari','Rajshai', 400)


DELETE FROM Branch
WHERE branch_name = 'zero point';

INSERT INTO Branch (branch_name,branch_city,assets)
VALUES ('zero point','Rajshai', 1000)

ALTER TABLE Branch
ADD branch_ID int;

UPDATE Branch
SET branch_ID = 02
WHERE branch_name = 'Talaimari';

SELECT *FROM Branch

SELECT assets*10
FROM Branch


SELECT * FROM  Branch 
WHERE branch_name = 'zero point' AND assets = 1000;

ALTER TABLE Branch
ADD customrt_name int, loan_id int, amount int;

UPDATE Branch
SET  amount = 5500
WHERE branch_name = 'Talaimari';

ALTER TABLE Branch
DROP COLUMN  customrt_name;

ALTER TABLE Branch
ADD customrt_name VARCHAR (40);

UPDATE Branch
SET  customrt_name ='Jon'
WHERE branch_name = 'zero point';

SELECT customrt_name
FROM Branch
WHERE customrt_name like '_on'

SELECT *FROM Branch

 
SELECT branch_name 
FROM Branch 
ORDER BY branch_name ASC