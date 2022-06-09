#Task-1
#Write an SQL query to fetch “FIRST_NAME” from the Worker table using the alias name as <WORKER_NAME>.
select First_name as WORKER_NAME from worker;
#Write an SQL query to fetch unique values of DEPARTMENT from the Worker table.
select distinct(department) from worker;
#Write an SQL query to show the last 5 records from a table.
SELECT * FROM worker order by first_name desc limit 5;

#Task-2
#Write an SQL query to print the first three characters of FIRST_NAME from Worker
SELECT SUBSTRING(first_name,1,3) as first_name FROM worker;
#Write an SQL query to find the position of the alphabet (‘a’) in the first name
SELECT position('a' in first_name)  as Position from worker;
#Write an SQL query to print the name of employees who have the highest salary in each department.
select department,max(salary) from worker group by department;

#Task-3
#Write an SQL query to print the FIRST_NAME from the Worker table after removing white spaces from the right side.
select rtrim(first_name) as first_name from worker group by department;
#Write an SQL query that fetches the unique values of DEPARTMENT from the Worker table and prints its length.
select department,length(department) from worker group by department;
#Write an SQL query to fetch nth max salaries from a table.
select salary from worker order by salary desc limit 3,1;

#Task-4
#Write an SQL query to print the FIRST_NAME from the Worker table after replacing ‘a’ with ‘A’.
SELECT REPLACE(first_name,'a','A') AS "replace" FROM worker;
#Write an SQL query to print all Worker details from the Worker table order FIRST_NAME Ascending and DEPARTMENT Descending.
select * from worker order by first_name asc,department desc;
#Write an SQL query to fetch the names of workers who earn the highest salary.
select first_name,salary from worker order by salary desc limit 1;

#Task-5
#Write an SQL query to print details of workers excluding first names, “Ramesh” and “Santhosh” from the Worker table.
select * from worker where first_name not in ('Ramesh','Ramesh ','Santhosh');
#Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
select * from worker where first_name like '_____h';
#Write a query to validate Email of Employee (email should have first name last name and guvi.com example (first name=Kamal last name= raja and the mail id should be kamalraja@guvi.com).
select  first_name,last_name,email as Invalid_email from worker
where email not like '%@guvi.com' or 
concat(first_name,last_name) != SUBSTRING_INDEX(email,'@',1);

#Task-6
#Write an SQL query to print details of the Workers who have joined in March ’2021.
SELECT * FROM worker WHERE month(join_date)=03 and year(join_date) = 2021;
#Write an SQL query to fetch duplicates that have matching data in some fields of a table.
SELECT * FROM worker group by first_name,email having count(*)>1;
#How to remove duplicate rows from the Employees table.
delete from worker where email in(SELECT * FROM (SELECT *, ROW_NUMBER()   
OVER (partition by first_name,email order BY email) AS row_num   
FROM worker) AS worker_table WHERE row_num>1);

#Task-7
#Write an SQL query to show only odd rows from a table.
SELECT * FROM (SELECT *, ROW_NUMBER()   
OVER (order BY email) AS row_num   
FROM worker) AS worker_table WHERE row_num%2!=0;
#Write an SQL query to clone a new table from another table.
create table clone_table select * from worker;

#Task-8
#Write an SQL query to fetch intersecting records of two tables.
select * from worker where email in (select email from clone_table);
#Write an SQL query to show records from one table that another table does not have.
select * from worker where email not in (select email from clone_table);

#Task-9
#Write an SQL query to show the top n (say 15) records of a table.
select * from worker limit 15;
#Write an SQL query to determine the nth (say n=10) highest salary from a table.
select distinct salary from worker order by salary desc limit 9,1;

#Task-10
#Write an SQL query to determine the 8th highest salary without using TOP or LIMIT methods.
SELECT * FROM worker w1 WHERE (8) = (
SELECT COUNT( DISTINCT ( w2.Salary ) )
FROM worker w2 WHERE w2.salary >= w1.salary);

#Write an SQL query to fetch the list of employees with the same salary.
SELECT * FROM worker w1 WHERE salary IN (SELECT salary
FROM worker w2 WHERE w1.email != w2.email);