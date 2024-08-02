USE test01
SELECT* FROM Salesman

-- Rename the colum
EXEC sp_rename 'Salesman.name', 'names', 'COLUMN';

--display specific columns such as names and commissions for all salespeople.
SELECT names,city
FROM Salesman

-- to identify the unique salespeople ID. Return salesman_id
SELECT DISTINCT salesman_id
FROM Salesman;
 