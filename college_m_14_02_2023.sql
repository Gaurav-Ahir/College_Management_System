
----------------code for create the college management system database-----------
create database college_management_system
use college_management_system 

-----------code for create student table--------------
create table student(
  stud_id integer primary key not null, 
  name varchar(200), 
  mobile_no varchar(200), 
  age integer not null, 
  deptno integer not null, 
  college_code integer not null,
) 

-----------code for create college table---------------
  create table college(
    college_code integer primary key not null, 
    college_name nvarchar(200) not null, 
    district varchar(100) not null, 
    course_offered varchar(200) not null)
	
----------code for create faculty table---------------
  create table faculty(
    faculty_id integer primary key not null, 
    faculty_name varchar(200) not null, 
    subject varchar(200) not null, 
    subject_code integer unique, 
    deptno integer not null, 
    college_code integer not null
  ) 
  
 ---------code for create cource table----------
  create table course(
    cource_id integer primary key not null, 
    cource_name varchar(200) not null, 
    duration integer not null, 
    college_code integer not null
  ) 
  
-----------code for create department table-------
  create table department(
    deptno integer primary key not null, 
    deptname varchar(200) not null, 
    cource_id integer not null, 
    college_code integer not null
  ) 
---------code for create class table--------------
  create table class(
    classno integer primary key not null, 
    class_name varchar(200) not null, 
    deptno integer not null
  ) 

 
----------adding foreign key constraints------------------

alter table 
  student 
add 
  foreign key(college_code) references college(college_code) 
alter table 
  student 
add 
  foreign key(deptno) references department(deptno) 
alter table 
  faculty 
add 
  foreign key(college_code) references college(college_code) 
alter table 
  faculty 
add 
  foreign key(deptno) references department(deptno) 
alter table 
  course 
add 
  foreign key(college_code) references college(college_code) 
alter table 
  department 
add 
  foreign key(cource_id) references course(cource_id) 
alter table 
  department 
add 
  foreign key(college_code) references college(college_code) 
alter table 
  class 
add 
  foreign key(deptno) references department(deptno) 

  --------------------Inserting Values----------------------

  --------------------inserting values into college table------------

insert into college values(1241,'Sinhgad Lonavala','UG')


--------------------inserting data into department table--------------

insert into department values
(13,'information technology',102,1241)

--------------------inserting data into course table------------------

insert into course values
(102,'BE',4,1241)

--------------------inserting data into student table------------------------

insert into student values
(1,'Gaurav Ahir','91-21536456',22,12,1241)

--------------------inserting data into faculty table------------------------

insert into faculty values
(2022,'ram','english','333',12,1241)

--------------------inserting data into class table------------------------

insert into class values
(50,'B-50',12)

  ------------------------------VIEWS--------------------------------

 --code for create view to------find which faculty repots which hod--------------

  alter view vw_faculty_reports_to
  as
select 
  t1.faculty_name, 
  t2.faculty_name as HOD_Name
from 
  faculty t1 
  join faculty t2 
  on t1.hod_id = t2.faculty_id 

select * from vw_faculty_reports_to
  
--code for create view to -------get the department wise course details-----------

  alter view vw_department_wise_course 
  as 
select 
  d.deptno, 
  d.deptname, 
  c.cource_id, 
  c.cource_name 
from 
  department d 
  join course c on d.cource_id = c.cource_id 
  
select 
  * 
from 
  vw_department_wise_course
  
--code for create view to --------get department wise classrooms count------------
  alter view vw_classroom_details 
  as 
select 
  c.deptno, 
  d.deptname, 
  count(c.deptno) as classroom_count 
from 
  class c 
  join department d on c.deptno = d.deptno 
group by 
  c.deptno, 
  d.deptname 


select 
  * 
from 
  vw_classroom_details 
  
--code for create view to---------Count faculties incourse-------------

  alter view vw_Count_faculty_incourse 
  as 
select 
  c.cource_id, 
  cource_name, 
  count(c.cource_id) as count_of_faculties_incourse 
from 
  faculty f 
  inner join department d 
  on f.deptno = d.deptno 
  inner join course c 
  on d.cource_id = c.cource_id 
group by 
  c.cource_id, 
  cource_name 


select 
  * 
from 
  vw_Count_faculty_incourse 
  
--code for create view to---------select all records from student table--------
  
  alter view vw_student 
  as 
select  * 
from 
  student
  

select 
  * 
from 
  vw_student 
  
--code for create view to-----------------select all records from faculty table--------
  alter view vw_faculty 
  as 
select 
  * 
from 
  faculty 


select 
  * 
from 
  vw_faculty 
  
--code for create view to--------------select all records from department table----------
  alter view vw_department
  as 
select 
  * 
from 
  department 


select 
  * 
from 
  vw_department 
  
--code for create view to----------------select all records from course table-------
  create view vw_course 
  as 
select 
  * 
from 
  course 


select 
  * 
from 
  vw_course 
  
--code for create view to------------select all records from class table---------
  create view vw_class 
  as 
select 
  * 
from 
  class 


select 
  * 
from 
  vw_class 
  
--code for create view to-------------select all records from college table--------
  
  create view vw_college
  as 
select 
  * 
from 
  college 


select 
  * 
from 
  vw_college 
  
--code for create view to ---------find which students are pursuing the course--------

  create view vw_pursuing_students
  as 
select 
  * 
from 
  student 
where 
  status = 'pursuing' 
  and
  leaving_date is null


select 
  * 
from 
  vw_pursuing_students 
  
  
-------------------------------------Stored Procedures---------------------------------------------------

---code for create stored procedure to---------update student details who leaved from college---------
  
  create procedure sp_add_passout_student
  @stud_id integer,
  @leaving_date date, 
  @status varchar(200) as 
update 
  student 
set 
  leaving_date = @leaving_date, 
  status = @status 
where 
  stud_id = @stud_id 
  
  -----------------------------
  exec sp_add_passout_student 
  @stud_id = 1, 
  @leaving_date = '02/10/2023', 
  @status = 'completed' 

  select * from vw_student
  
  --code for crud operations on------student table---------------

  create procedure sp_crud_student 
  @stud_id integer, 
  @name varchar(200), 
  @mobile_no varchar(200), 
  @age integer, 
  @deptno integer, 
  @college_code integer, 
  @admission_date date, 
  @status varchar(200), 
  @leaving_date date, 
  @operation varchar(200) 
  as 
	begin 
  if @operation = 'insert' insert into student 
values 
  (
    @stud_id, @name, @mobile_no, @age, 
    @deptno, @college_code, @admission_date, 
    @status, @leaving_date
  ) 
  else if @operation = 'update' 
update student 
set name = @name 
where 
  stud_id = @stud_id 
  else if @operation = 'delete' 
delete from 
  student 
where 
  stud_id = @stud_id else print null end 
  
-------------------------------------------------------------------------------------------------
  EXECUTE sp_crud_student 
  @stud_id = 24, 
  @name = 'pawan mohe', 
  @mobile_no = '91-535366', 
  @age = 23, 
  @deptno = 17, 
  @college_code = 1241, 
  @admission_date = '08/31/2023', 
  @status = 'pursuing', 
  @leaving_date = null, 
  @operation = 'insert' 
  
  select * from vw_student
--code for crud operations on---------faculty table--------------------
  create procedure sp_crud_faculty 
  @faculty_id integer, 
  @faculty_name varchar(200), 
  @subject varchar(200), 
  @subject_code integer, 
  @deptno integer, 
  @college_code integer, 
  @HOD integer, 
  @operation varchar(200) 
  as
  begin 
  if @operation = 'insert' insert into faculty 
values 
  (
    @faculty_id, @faculty_name, @subject, 
    @subject_code, @deptno, @college_code, 
    @HOD
  ) else if @operation = 'update' 
update 
  faculty 
set 
  faculty_name = @faculty_name 
where 
  faculty_id = @faculty_id else if @operation = 'delete' 
delete from 
  faculty 
where 
  faculty_id = @faculty_id else print null end
  
-----------------------------------------------------------------------
  EXEC sp_crud_faculty
  @faculty_id = 2034, 
  @faculty_name = 'vishvjeet', 
  @subject = 'math', 
  @subject_code = 345, 
  @deptno = 17, 
  @college_code = 1241, 
  @HOD = 2022, 
  @operation = 'update' 
  
  select * from vw_faculty
--code for crud operations ------------on department table-------------------
  
  alter procedure sp_crud_department 
  @deptno integer, 
  @deptname varchar(200), 
  @cource_id integer, 
  @college_code integer, 
  @operation varchar(200) as begin if @operation = 'insert' insert into department 
values 
  (
    @deptno, @deptname, @cource_id, @college_code
  ) else if @operation = 'update' 
update 
  department 
set 
  deptname = @deptname 
where 
  deptno = @deptno else if @operation = 'delete' 
delete from 
  department 
where 
  deptno = @deptno else print null end 
  
--------------------------------------------------------------------------------
  EXEC sp_crud_department
  @deptno = 18, 
  @deptname = 'cs', 
  @cource_id = 105, 
  @college_code = 1241, 
  @operation = 'insert' 
  
  select * from vw_department

------------------code for crud operations---------on course table-------------
  alter procedure sp_crud_course 
  @cource_id integer, 
  @cource_name varchar(200), 
  @duration integer, 
  @college_code integer, 
  @operation varchar(200) as begin if @operation = 'insert' insert into course 
values 
  (
    @cource_id, @cource_name, @duration, 
    @college_code
  ) else if @operation = 'update' 
update 
  course 
set 
  cource_name = @cource_name 
where 
  cource_id = @cource_id else if @operation = 'delete' 
delete from 
  course 
where 
  cource_id = @cource_id else print null end 
  
-------------------------------------------------------------------------
  EXEC sp_crud_course 
  @cource_id = 101, 
  @cource_name = 'BSC', 
  @duration = 4, 
  @college_code = 1241, 
  @operation = 'insert' 
  
  select * from vw_course
--code for crud operations----------------on class table------------------
  alter procedure sp_crud_class 
  @classno integer, 
  @class_name varchar(200), 
  @deptno integer, 
  @operation varchar(200) as begin if @operation = 'insert' insert into class 
values 
  (@classno, @class_name, @deptno) else if @operation = 'update' 
update 
  class 
set 
  class_name = @class_name 
where 
  classno = @classno else if @operation = 'delete' 
delete from 
  class 
where 
  classno = @classno else print null end 
  
-----------------------------------------------------------------------------------------
  EXEC sp_crud_class 
  @classno = 70, 
  @class_name = 'BB-58', 
  @deptno = 18, 
  @operation = 'insert' 
  
  select * from vw_class
--code for crou operations-----------on college table----------------------
  alter procedure sp_crud_college 
  @college_code integer, 
  @college_name nvarchar(200), 
  @district varchar(100), 
  @operation varchar(200) as begin if @operation = 'insert' insert into college 
values 
  (
    @college_code, @college_name, @district
  ) else if @operation = 'update' 
update 
  college 
set 
  college_name = @college_name 
where 
  college_code = @college_code else if @operation = 'delete' 
delete from 
  college 
where 
  college_code = @college_code else print null end 
  
-----------------------------------------------------------------------------------------
  EXEC sp_crud_college 
  @college_code = 1241, 
  @college_name = 'Sinhgad Vadgaon', 
  @district = 'pune', 
  @operation = 'insert' 
  
  select * from vw_college

--code for create stored procedure to---------get the perticular student status-------------

  create procedure sp_student_status
  @name varchar(200)
  as
  begin

  select
  name,admission_date,status,leaving_date from 
  student where name = @name
  end

  exec sp_student_status 'sachin raut'

  select * from vw_student

  select * from student

