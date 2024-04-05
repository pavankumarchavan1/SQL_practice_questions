DROP TABLE IF EXISTS hotel_ratings;
CREATE TABLE hotel_ratings
(
	hotel 		VARCHAR(30),
	year1		INT,
	rating 		FLOAT
);
INSERT INTO hotel_ratings VALUES('Radisson Blu', 2020, 4.8);
INSERT INTO hotel_ratings VALUES('Radisson Blu', 2021, 3.5);
INSERT INTO hotel_ratings VALUES('Radisson Blu', 2022, 3.2);
INSERT INTO hotel_ratings VALUES('Radisson Blu', 2023, 3.8);
INSERT INTO hotel_ratings VALUES('InterContinental', 2020, 4.2);
INSERT INTO hotel_ratings VALUES('InterContinental', 2021, 4.5);
INSERT INTO hotel_ratings VALUES('InterContinental', 2022, 1.5);
INSERT INTO hotel_ratings VALUES('InterContinental', 2023, 3.8);

SELECT * FROM hotel_ratings;

WITH cte AS (
	SELECT *, abs( ROUND(x.avg_rating - x.rating, 2)) AS Diff
	FROM (
		SELECT *, ROUND(AVG(rating) OVER (PARTITION BY hotel), 2) AS avg_rating
		FROM hotel_ratings ) x
), 
cte_rn AS (
	SELECT *, RANK() OVER (PARTITION BY hotel ORDER BY Diff DESC) AS rn
	FROM cte
)
SELECT hotel, year1, rating
FROM cte_rn
WHERE rn <> 1
ORDER BY hotel DESC, year1;