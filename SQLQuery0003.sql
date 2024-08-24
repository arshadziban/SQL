USE test01
SELECT* FROM Salesman_Data;

--Add new column
ALTER TABLE Salesman
ADD orders VARCHAR(255);

-- Update column value
UPDATE Salesman
SET orders = '1'
WHERE salesman_id = 5007;

EXEC sp_rename 'Salesman', 'Salesman_Data';