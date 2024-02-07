SELECT * FROM query7.weather;

insert into query7.weather values
(1, 'London', -1, '2021-01-01'),
(2, 'London', -2, '2021-01-02'),
(3, 'London', 4, '2021-01-03'),
(4, 'London', 1, '2021-01-04'),
(5, 'London', -2, '2021-01-05'),
(6, 'London', -5, '2021-01-06'),
(7, 'London', -7, '2021-01-07'),
(8, 'London', 5, '2021-01-08');


SELECT id,  city, temperature, day
FROM (
SELECT *,
CASE WHEN temperature < 0
		AND LEAD(temperature) OVER (ORDER BY id) < 0
        AND LEAD(temperature, 2) OVER (ORDER BY id) < 0
	THEN 'YES'
    
    WHEN temperature < 0
		AND LAG(temperature) OVER (ORDER BY id) < 0
        AND LEAD(temperature,1) OVER (ORDER BY id) < 0
	THEN 'YES'
    
    WHEN temperature < 0
		AND LAG(temperature) OVER (ORDER BY id) < 0
        AND LAG(temperature, 2) OVER (ORDER BY id) < 0
	THEN 'YES'
ELSE null
END tag
FROM query7.weather) low_temp
WHERE low_temp.tag = 'YES';
