DROP TABLE IF EXISTS job_skills;
CREATE TABLE job_skills
(
	row_id		INT,
	job_role	VARCHAR(20),
	skills		VARCHAR(20)
);
INSERT INTO job_skills VALUES (1, 'Data Engineer', 'SQL');
INSERT INTO job_skills VALUES (2, NULL, 'Python');
INSERT INTO job_skills VALUES (3, NULL, 'AWS');
INSERT INTO job_skills VALUES (4, NULL, 'Snowflake');
INSERT INTO job_skills VALUES (5, NULL, 'Apache Spark');
INSERT INTO job_skills VALUES (6, 'Web Developer', 'Java');
INSERT INTO job_skills VALUES (7, NULL, 'HTML');
INSERT INTO job_skills VALUES (8, NULL, 'CSS');
INSERT INTO job_skills VALUES (9, 'Data Scientist', 'Python');
INSERT INTO job_skills VALUES (10, NULL, 'Machine Learning');
INSERT INTO job_skills VALUES (11, NULL, 'Deep Learning');
INSERT INTO job_skills VALUES (12, NULL, 'Tableau');

SELECT * FROM job_skills;


-- Solution 1 --> Using cte and First_value window function
WITH cte AS (
SELECT *,
	SUM(CASE WHEN job_role IS NOT NULL THEN 1 ELSE 0 END) OVER (ORDER BY row_id) job_role_flag
FROM job_skills
)
SELECT row_id, FIRST_VALUE(job_role) OVER(PARTITION BY job_role_flag) as job_role, skills
FROM cte;


-- Solution 2 --> using recursion
WITH RECURSIVE cte AS ( 
SELECT row_id, job_role, skills
FROM job_skills
WHERE row_id = 1
UNION
SELECT js.row_id, coalesce(js.job_role, cte.job_role), js.skills
FROM cte
JOIN job_skills jsd
	ON js.row_id = cte.row_id+1)
    
SELECT * from cte;

/*
Output -->
---------------------------------------------------------------------|
jobrole			|	skills											 |
---------------------------------------------------------------------|
Data Engineer	|	SQL, Python, AWS, Snowflake, Apache Spark		 |
Web Developer	|	Java, HTML, CSS									 |
Data Scientist	|	Python, Machine Learning, Deep Learning, Tableau |
---------------------------------------------------------------------|
*/
WITH cte AS (
SELECT row_id, FIRST_VALUE(job_role) OVER(PARTITION BY job_role_flag) as job_role, skills AS SKILLS
FROM (
SELECT *,
	SUM(CASE WHEN job_role IS NOT NULL THEN 1 ELSE 0 END) OVER (ORDER BY row_id) job_role_flag
FROM job_skills ) x
)
SELECT job_role, GROUP_CONCAT(SKILLS) AS Skills_req
FROM cte
GROUP BY job_role;