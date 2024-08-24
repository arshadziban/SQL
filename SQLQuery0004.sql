CREATE DATABASE labtest01;
USE labtest01;

CREATE TABLE Studentas(
    ID int,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Section VARCHAR(30)
);

SELECT * FROM Students;

--Table rename
EXEC sp_rename 'Studentas', 'Students';


--column rename
EXEC sp_rename 'Students.last_name', 'Last_Name', 'COLUMN';

--SELECT First_Name AS First, Last_Name AS last
--FROM Students

--insert data
INSERT INTO Students(ID,First_Name, Last_Name,Section)
VALUES
(01,'Arshad','Ziban','A'),
(04,'Abdullah','Khan','A'),
(02,'Muhit','Uddin','A'),
(03,'Hafizul','Islam','A'),
(06,'Abdul','Momin','A'),
(05,'Zahid','Hasan','A');


-- add column

ALTER TABLE Students
ADD CGPA FLOAT

SELECT * FROM Students;

--update value in column named CGPA

UPDATE Students
SET CGPA= 3.87
WHERE ID= 6

--setect specific column

SELECT First_Name,Last_name
FROM Students;

--String opertion
SELECT * FROM Students
WHERE Last_Name LIKE '%a%';

--Sorting Result
SELECT ID,First_Name, Last_name, CGPA
FROM Students
ORDER BY CGPA ASC


--Filtering Result
SELECT*
FROM Students
Where CGPA > 3.00

