DROP TABLE IF EXISTS  student_tests;
CREATE TABLE student_tests
(
	test_id		INT,
	marks		INT
);
INSERT INTO student_tests VALUES(100, 55);
INSERT INTO student_tests VALUES(101, 55);
INSERT INTO student_tests VALUES(102, 60);
INSERT INTO student_tests VALUES(103, 58);
INSERT INTO student_tests VALUES(104, 40);
INSERT INTO student_tests VALUES(105, 50);

SELECT * FROM student_tests;

-- Output 1
WITH cte AS (
SELECT test_id, marks, LAG(marks, 1, 0) OVER(ORDER BY test_id) prev_test_mks 
FROM student_tests
)
SELECT test_id, marks
FROM cte
WHERE marks > prev_test_mks;
/*in the lag window function 1st element is mandatory, 2nd element tells us how many previous record 
should be considered (optional), 3rd element is default value (optional)*/


-- Output 2
SELECT test_id, marks
FROM (
		SELECT test_id, marks, LAG(marks, 1) OVER(ORDER BY test_id) prev_test_mks
		FROM student_tests) sub
WHERE sub.marks > sub.prev_test_mks;