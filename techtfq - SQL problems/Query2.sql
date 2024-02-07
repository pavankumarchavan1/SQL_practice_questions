SELECT * FROM query2.employee;

insert into query2.employee values(101, 'Mohan', 'Admin', 4000);
insert into query2.employee values(102, 'Rajkumar', 'HR', 3000);
insert into query2.employee values(103, 'Akbar', 'IT', 4000);
insert into query2.employee values(104, 'Dorvin', 'Finance', 6500);
insert into query2.employee values(105, 'Rohit', 'HR', 3000);
insert into query2.employee values(106, 'Rajesh',  'Finance', 5000);
insert into query2.employee values(107, 'Preet', 'HR', 7000);
insert into query2.employee values(108, 'Maryam', 'Admin', 4000);
insert into query2.employee values(109, 'Sanjay', 'IT', 6500);
insert into query2.employee values(110, 'Vasudha', 'IT', 7000);
insert into query2.employee values(111, 'Melinda', 'IT', 8000);
insert into query2.employee values(112, 'Komal', 'IT', 10000);
insert into query2.employee values(113, 'Gautham', 'Admin', 2000);
insert into query2.employee values(114, 'Manisha', 'HR', 3000);
insert into query2.employee values(115, 'Chandni', 'IT', 4500);
insert into query2.employee values(116, 'Satya', 'Finance', 6500);
insert into query2.employee values(117, 'Adarsh', 'HR', 3500);
insert into query2.employee values(118, 'Tejaswi', 'Finance', 5500);
insert into query2.employee values(119, 'Cory', 'HR', 8000);
insert into query2.employee values(120, 'Monica', 'Admin', 5000);
insert into query2.employee values(121, 'Rosalin', 'IT', 6000);
insert into query2.employee values(122, 'Ibrahim', 'IT', 8000);
insert into query2.employee values(123, 'Vikram', 'IT', 8000);
insert into query2.employee values(124, 'Dheeraj', 'IT', 11000);

SELECT * FROM query2.employee;

/*2. Write a SQL query to fetch the second last record from employee table.*/
SELECT emp_ID, emp_name, dept_name
FROM (SELECT *,
		ROW_NUMBER() OVER() AS rn
		FROM query2.employee
		ORDER BY emp_ID DESC) tab
WHERE tab.rn = 2;


/*3. Write a SQL query to display only the details of employees who either earn the highest salary or the lowest salary in each department from the employee table.*/
SELECT *
FROM query2.employee e
JOIN(
SELECT *,
		MIN(salary) OVER(PARTITION BY dept_name) AS min_salary,
		MAX(salary) OVER(PARTITION BY dept_name) AS max_salary
        FROM query2.employee) tab3
ON e.emp_ID = tab3.emp_ID AND (e.salary = tab3.min_salary OR e.salary = tab3.max_salary)
ORDER BY tab3.dept_name, tab3.salary;