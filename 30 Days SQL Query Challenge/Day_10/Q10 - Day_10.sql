DROP TABLE IF EXISTS auto_repair;
CREATE TABLE auto_repair
(
	client1			VARCHAR(20),
	auto			VARCHAR(20),
	repair_date		INT,
	indicator		VARCHAR(20),
	value1			VARCHAR(20)
);
INSERT INTO auto_repair VALUES('c1','a1',2022,'level','good');
INSERT INTO auto_repair VALUES('c1','a1',2022,'velocity','90');
INSERT INTO auto_repair VALUES('c1','a1',2023,'level','regular');
INSERT INTO auto_repair VALUES('c1','a1',2023,'velocity','80');
INSERT INTO auto_repair VALUES('c1','a1',2024,'level','wrong');
INSERT INTO auto_repair VALUES('c1','a1',2024,'velocity','70');
INSERT INTO auto_repair VALUES('c2','a1',2022,'level','good');
INSERT INTO auto_repair VALUES('c2','a1',2022,'velocity','90');
INSERT INTO auto_repair VALUES('c2','a1',2023,'level','wrong');
INSERT INTO auto_repair VALUES('c2','a1',2023,'velocity','50');
INSERT INTO auto_repair VALUES('c2','a2',2024,'level','good');
INSERT INTO auto_repair VALUES('c2','a2',2024,'velocity','80');

SELECT * FROM auto_repair;

WITH cte AS (
SELECT 
	CASE WHEN value1 = '50' THEN 50
		 WHEN value1 = '70' THEN 70
		 WHEN value1 = '80' THEN 80
		 WHEN value1 = '90' THEN 90 END AS velocity,
	CASE WHEN value1 = 'good' THEN LEAD(value1) OVER (ORDER BY client1) END AS good,
    CASE WHEN value1 = 'wrong' THEN LEAD(value1) OVER (ORDER BY client1) END AS wrong,
    CASE WHEN value1 = 'regular' THEN LEAD(value1) OVER (ORDER BY client1) END AS regular
FROM auto_repair 
WHERE value1 IS NOT NULL)
SELECT cte.velocity, COUNT(cte.good) AS good, COUNT(cte.wrong) AS wrong, COUNT(cte.regular) AS regular
FROM cte
GROUP BY cte.velocity;


SELECT vel.value1 AS velocity, lev.value1 AS level, COUNT(vel.value1) AS vel
FROM auto_repair lev
JOIN auto_repair vel
	ON lev.client1 = vel.client1 AND lev.auto = vel.auto AND lev.repair_date = vel.repair_date
WHERE lev.indicator = 'level' AND vel.indicator = 'velocity'
GROUP BY vel.value1, lev.value1
ORDER BY vel.value1, lev.value1;


SELECT velocity, SUM(CASE WHEN level = 'good' THEN level END) AS good,
		SUM(CASE WHEN level = 'wrong' THEN level END) AS wrong,
        SUM(CASE WHEN level = 'regular' THEN level END) AS regular
FROM cte
GROUP BY velocity;