Create Database Random
use Random
CREATE TABLE STATION (
    ID INT,
    CITY VARCHAR(21),
    STATE CHAR(2),
    LAT_N FLOAT,
    LONG_W FLOAT
);
INSERT INTO STATION (ID, CITY, STATE, LAT_N, LONG_W) VALUES
(1, 'New York', 'NY', 40.7128, -74.0060),
(2, 'Los Angeles', 'CA', 34.0522, -118.2437),
(3, 'Chicago', 'IL', 41.8781, -87.6298),
(4, 'Houston', 'TX', 29.7604, -95.3698),
(5, 'Phoenix', 'AZ', 33.4484, -112.0740),
(6, 'Philadelphia', 'PA', 39.9526, -75.1652),
(7, 'San Antonio', 'TX', 29.4241, -98.4936),
(8, 'San Diego', 'CA', 32.7157, -117.1611),
(9, 'Dallas', 'TX', 32.7767, -96.7970),
(10, 'San Jose', 'CA', 37.3382, -121.8863);

-- Show all
Select *
From STATION

--Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT 
    (COUNT(CITY) - COUNT(DISTINCT CITY)) AS city_difference
FROM 
    STATION;


-- Query for the shortest city name
SELECT TOP 1 CITY, LEN(CITY) AS Length
FROM STATION
ORDER BY LEN(CITY), CITY;

-- Query for the longest city name
SELECT TOP 1 CITY, LEN(CITY) AS Length
FROM STATION
ORDER BY LEN(CITY) DESC, CITY;

--Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE 'A%' 
   OR CITY LIKE 'E%' 
   OR CITY LIKE 'I%' 
   OR CITY LIKE 'O%' 
   OR CITY LIKE 'U%';

--Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE '%a' 
   OR CITY LIKE '%e' 
   OR CITY LIKE '%i' 
   OR CITY LIKE '%o' 
   OR CITY LIKE '%u';

 --Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
 SELECT DISTINCT CITY
FROM STATION
WHERE (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%')
  AND (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u');

--Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U');

--Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U');