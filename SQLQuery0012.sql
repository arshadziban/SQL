-- Create the database and use it
CREATE DATABASE lab003;
USE lab003;

--Create tblEmp with appropriate data types and insert data
CREATE TABLE tblEmp (
    EmpName VARCHAR(20),
    EmpSalary INT,
    JoiningDate DATE  
);

INSERT INTO tblEmp VALUES ('Smith', 25000, '2024-03-20');
INSERT INTO tblEmp VALUES ('Jhon', 35000, '2024-01-20');
INSERT INTO tblEmp VALUES ('Sara', 28000, '2023-11-11');
INSERT INTO tblEmp VALUES ('Devid', 45000, '2022-12-10');

SELECT * FROM tblEmp;

--Create info table and insert data
CREATE TABLE info (
    SName VARCHAR(20),
    CGPA FLOAT,
    Department VARCHAR(20)
);

INSERT INTO info VALUES ('Jara', 3.5, 'CSE');
INSERT INTO info VALUES ('Sara', 3.99, 'CSE');
INSERT INTO info VALUES ('Devid', 3.6, 'CSE');
INSERT INTO info VALUES ('Smith', 3.87, 'EEE');

SELECT * FROM info;

-- Task 1: Create a stored procedure to fetch employee salaries from tblEmp
CREATE PROCEDURE EmpBySalary  
AS 
BEGIN
    SELECT EmpSalary FROM tblEmp; 
END;

-- Execute the stored procedure
EXEC EmpBySalary;

-- Task 2: Stored procedure to find the second-highest CGPA in the CSE department
CREATE PROCEDURE CgpaOfStudents 
    @Department VARCHAR(20),
    @SecondHighestCGPA FLOAT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT @SecondHighestCGPA = MAX(CGPA)
    FROM info
    WHERE Department = @Department 
      AND CGPA < (SELECT MAX(CGPA) FROM info WHERE Department = @Department);
END;

-- Declare output variable and execute the stored procedure
DECLARE @Result FLOAT;
EXEC CgpaOfStudents @Department = 'CSE', @SecondHighestCGPA = @Result OUTPUT;
SELECT @Result AS SecondHighestCGPA;

-- Task 3: Create a stored procedure to find employees who joined before 6 months ago and have salary > 20,000
CREATE PROCEDURE EmpJoiningDate 
AS
BEGIN
    SELECT * FROM tblEmp
    WHERE EmpSalary > 20000 
      AND JoiningDate < DATEADD(MONTH, -6, GETDATE()); 
END;

-- Execute the procedure
EXEC EmpJoiningDate;

-- Task 4: Find dependencies for tblEmp table
EXEC sp_depends 'tblEmp';
