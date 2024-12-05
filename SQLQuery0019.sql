Create database Random001
use Random001

CREATE TABLE majors (
    major_id INT PRIMARY KEY, -- Unique ID for each major
    major_name VARCHAR(50) UNIQUE -- Ensure unique major names
);

-- Insert unique majors into the table
INSERT INTO majors (major_id, major_name)
VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Chemistry');

--Create student Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    grade CHAR(1),
    major_id INT, -- References the majors table
    FOREIGN KEY (major_id) REFERENCES majors(major_id)
);

-- Insert students data using major IDs
INSERT INTO students (student_id, name, age, gender, grade, major_id)
VALUES
(1, 'Alice', 20, 'Female', 'A', 1),
(2, 'Bob', 22, 'Male', 'B', 2),
(3, 'Charlie', 21, 'Male', 'A', 3),
(4, 'Diana', 23, 'Female', 'C', 1),
(5, 'Eva', 20, 'Female', 'B', 4);
 

 select * from students



 CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    credits INT,
    major_id INT, -- References the majors table
    FOREIGN KEY (major_id) REFERENCES majors(major_id)
);

-- Insert courses data using major IDs
INSERT INTO courses (course_id, course_name, credits, major_id)
VALUES
(101, 'Data Structures', 4, 1),
(102, 'Linear Algebra', 3, 2),
(103, 'Quantum Mechanics', 4, 3),
(104, 'Organic Chemistry', 3, 4),
(105, 'Algorithms', 4, 1);


--Solving the problems

-- Retrieve All Students Along with Their Majors
select s.student_id, s.name, s.age, s.gender, s.grade, m.major_name 
from students s
join majors m on s.major_id = m.major_id;


--Find the Total Number of Credits for Computer Science Courses
select m.major_name, sum(c.credits) as total_credits
from courses c
join majors m on c.major_id = m.major_id
where m.major_name = 'Computer Science'
group by m.major_name;


-- List All Students Enrolled in Courses for Their Major
select s.name as student_name, c.course_name as eligible_course, m.major_name
from students s
join majors m on s.major_id = m.major_id
join courses c on m.major_id = c.major_id;


--Find the Most Popular Major by Number of Students
select top 1 m.major_name, count(s.student_id) as student_count
from students s
join majors m on s.major_id = m.major_id
group by m.major_name
order by student_count desc;