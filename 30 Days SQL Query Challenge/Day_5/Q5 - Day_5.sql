drop table if exists salary;
create table salary
(
	emp_id		int,
	emp_name	varchar(30),
	base_salary	int
);
insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);


drop table if exists income;
create table income
(
	id			int,
	income		varchar(20),
	percentage	int
);
insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);


drop table if exists deduction;
create table deduction
(
	id			int,
	deduction	varchar(20),
	percentage	int
);
insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);


SELECT * FROM salary;
SELECT * FROM income;
SELECT * FROM deduction;

CREATE TABLE emp_transaction
(
	emp_id		INT,
    emp_name	VARCHAR(50),
    TRNS_TYPE	VARCHAR(20),
    amount		NUMERIC
);


-- Output 1 - emp_transaction table
INSERT INTO emp_transaction (
SELECT emp_id, emp_name, TRNS_TYPE,
	CASE WHEN TRNS_TYPE = 'Allowance' THEN ROUND((base_salary * (inc_per/100.0)), 2)
		 WHEN TRNS_TYPE = 'Others' THEN ROUND(base_salary * (inc_per/100.0), 2)
         WHEN TRNS_TYPE = 'Insurance' THEN ROUND(base_salary * (inc_per/100.0), 2)
         WHEN TRNS_TYPE = 'Health' THEN ROUND(base_salary * (inc_per/100.0), 2)
         WHEN TRNS_TYPE = 'House' THEN ROUND(base_salary * (inc_per/100.0), 2)
         WHEN TRNS_TYPE = 'Basic' THEN ROUND(base_salary * (inc_per/100.0), 2) END AS Amount
FROM salary
CROSS JOIN (
			SELECT income AS TRNS_TYPE, percentage AS inc_per
            FROM income inc
            UNION
            SELECT deduction AS TRNS_TYPE, percentage AS ded_per
            FROM deduction ) joined_table
ORDER BY emp_id );

SELECT * FROM emp_transaction;


-- Output 2 - Salary Report
WITH cte AS (
SELECT emp_name, 
	SUM(CASE WHEN TRNS_TYPE = 'Basic' THEN amount END) AS Basic,
	SUM(CASE WHEN TRNS_TYPE = 'Allowance' THEN amount END) AS Allowance,
    SUM(CASE WHEN TRNS_TYPE = 'Others' THEN amount END) AS Others,
    SUM(CASE WHEN TRNS_TYPE = 'Insurance' THEN amount END) AS Insurance,
    SUM(CASE WHEN TRNS_TYPE = 'Health' THEN amount END) AS Health,
    SUM(CASE WHEN TRNS_TYPE = 'House' THEN amount END) AS House
FROM emp_transaction
GROUP BY emp_name
)
SELECT emp_name, Basic, Allowance, Others, 
	SUM(Basic+Allowance+Others) AS Gross, 
    Insurance, Health, House,
    SUM(Insurance + Health + House) AS Total_Deductions,
    SUM(Basic+Allowance+Others) - SUM(Insurance + Health + House) AS Net_Pay
FROM cte
GROUP BY emp_name;