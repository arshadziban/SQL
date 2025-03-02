-- =========================
-- Create Database
-- =========================
create database test02;
go
use test02;
go

-- =========================
-- Create teacher table
-- =========================
create table teacher (
    teacher_id int identity(1,1) primary key,
    name varchar(50) not null,
    subject varchar(50),
    experience int
);

-- =========================
-- Create student table
-- =========================
create table student (
    student_id int identity(1,1) primary key,
    name varchar(50) not null,
    age int,
    gender varchar(10),
    class varchar(20),
    teacher_id int,
    foreign key (teacher_id) references teacher(teacher_id)
);

-- =========================
-- Insert sample data into teacher table
-- =========================
insert into teacher (name, subject, experience) values
('Alice Johnson', 'Mathematics', 10),
('Robert Smith', 'Physics', 8),
('Sophia Lee', 'Chemistry', 6),
('David Brown', 'Biology', 12);

-- =========================
-- Insert sample data into student table
-- =========================
insert into student (name, age, gender, class, teacher_id) values
('John Doe', 16, 'Male', '10th Grade', 1),
('Emma Watson', 15, 'Female', '9th Grade', 2),
('Liam James', 17, 'Male', '11th Grade', 3),
('Sophia Miller', 16, 'Female', '10th Grade', 1),
('Noah Wilson', 15, 'Male', '9th Grade', 2),
('Olivia Brown', 17, 'Female', '11th Grade', 3),
('Ethan Davis', 18, 'Male', '12th Grade', 4);

-- =========================
-- SQL PRACTICE QUERIES
-- =========================

-- 1. Select all students
select * from student;

-- 2. Select all teachers who have more than 8 years of experience
select * from teacher where experience > 8;

-- 3. Count the total number of students
select count(*) as total_students from student;

-- 4. Find the students who are in '10th Grade'
select * from student where class = '10th Grade';

-- 5. Get the names of students along with their teacher's name
select student.name as student_name, teacher.name as teacher_name
from student
join teacher on student.teacher_id = teacher.teacher_id;

-- 6. Find the youngest student
select top 1 * from student order by age asc;

-- 7. Get the number of students per class
select class, count(*) as student_count
from student
group by class;

-- 8. Get the number of students assigned to each teacher
select teacher.name, count(student.student_id) as student_count
from teacher
left join student on teacher.teacher_id = student.teacher_id
group by teacher.name;

-- 9. Retrieve students who have names starting with 'S'
select * from student where name like 'S%';

-- 10. Find the teacher who has the most students assigned
select top 1 teacher.name, count(student.student_id) as student_count
from teacher
join student on teacher.teacher_id = student.teacher_id
group by teacher.name
order by student_count desc;

-- 11. Retrieve male students only
select * from student where gender = 'Male';

-- 12. Update the experience of a teacher (e.g., Increase 'Alice Johnson's experience by 2 years)
update teacher set experience = experience + 2 where name = 'Alice Johnson';
