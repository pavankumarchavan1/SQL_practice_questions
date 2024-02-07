SELECT * FROM query6.students;

insert into query6.students values
(1, 'James'),
(2, 'Michael'),
(3, 'George'),
(4, 'Stewart'),
(5, 'Robin');

SELECT id, student_name,
	CASE WHEN id%2 <> 0
			THEN LEAD(student_name, 1, student_name) OVER(ORDER BY id)
		 WHEN id%2 = 0
			THEN LAG(student_name, 1, student_name) OVER(ORDER BY id)
	END AS studname
FROM query6.students;