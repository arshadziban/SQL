-- =========================
-- Create Database
-- =========================
create database school_db;
go
use school_db;
go

-- =========================
-- Create students table
-- =========================
create table students (
    student_id int identity(1,1) primary key,
    name varchar(50) not null,
    age int,
    gender varchar(10),
    email varchar(100) unique
);

-- =========================
-- Create courses table
-- =========================
create table courses (
    course_id int identity(1,1) primary key,
    course_name varchar(100) not null,
    instructor varchar(50)
);

-- =========================
-- Create enrollments table
-- =========================
create table enrollments (
    enrollment_id int identity(1,1) primary key,
    student_id int,
    course_id int,
    enrollment_date date default getdate(),
    foreign key (student_id) references students(student_id),
    foreign key (course_id) references courses(course_id)
);

-- =========================
-- Insert sample data into students table
-- =========================
insert into students (name, age, gender, email) values
('John Doe', 20, 'Male', 'john.doe@email.com'),
('Emma Watson', 22, 'Female', 'emma.watson@email.com'),
('Liam James', 21, 'Male', 'liam.james@email.com'),
('Sophia Miller', 23, 'Female', 'sophia.miller@email.com'),
('Noah Wilson', 19, 'Male', 'noah.wilson@email.com');

-- =========================
-- Insert sample data into courses table
-- =========================
insert into courses (course_name, instructor) values
('Database Management', 'Dr. Alice Johnson'),
('Artificial Intelligence', 'Dr. Robert Smith'),
('Computer Networks', 'Prof. Sophia Lee'),
('Software Engineering', 'Dr. David Brown');

-- =========================
-- Insert sample data into enrollments table
-- =========================
insert into enrollments (student_id, course_id) values
(1, 1), (1, 2),  -- John Doe enrolled in DB Management & AI
(2, 3), (2, 4),  -- Emma Watson enrolled in Networks & Software Eng
(3, 1), (3, 3),  -- Liam James enrolled in DB Management & Networks
(4, 2), (4, 4),  -- Sophia Miller enrolled in AI & Software Eng
(5, 1), (5, 2);  -- Noah Wilson enrolled in DB Management & AI

-- =========================
-- SQL PRACTICE QUERIES
-- =========================

-- 1. Retrieve all students
select * from students;

-- 2. Retrieve all courses
select * from courses;

-- 3. Find the total number of students
select count(*) as total_students from students;

-- 4. Find all students who are enrolled in 'Database Management'
select students.name, courses.course_name
from students
join enrollments on students.student_id = enrollments.student_id
join courses on enrollments.course_id = courses.course_id
where courses.course_name = 'Database Management';

-- 5. Get the number of students enrolled in each course
select courses.course_name, count(enrollments.student_id) as total_students
from courses
left join enrollments on courses.course_id = enrollments.course_id
group by courses.course_name;

-- 6. Find students who are not enrolled in any course
select * from students
where student_id not in (select distinct student_id from enrollments);

-- 7. Find all students whose names start with 'S'
select * from students where name like 'S%';

-- 8. Find the oldest student
select top 1 * from students order by age desc;

-- 9. Get the courses with the highest number of students
select top 1 courses.course_name, count(enrollments.student_id) as total_students
from courses
join enrollments on courses.course_id = enrollments.course_id
group by courses.course_name
order by total_students desc;

-- 10. Retrieve students along with their enrolled courses
select students.name as student_name, courses.course_name
from students
join enrollments on students.student_id = enrollments.student_id
join courses on enrollments.course_id = courses.course_id;

-- 11. Retrieve students who are enrolled in more than one course
select students.name, count(enrollments.course_id) as total_courses
from students
join enrollments on students.student_id = enrollments.student_id
group by students.name
having count(enrollments.course_id) > 1;

-- 12. Update the instructor for 'Artificial Intelligence'
update courses set instructor = 'Dr. Richard Clark' where course_name = 'Artificial Intelligence';
