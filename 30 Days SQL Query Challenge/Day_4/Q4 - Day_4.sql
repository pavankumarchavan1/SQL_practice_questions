/*
Derive expected output
			ID	Name	LOCATION
Output 1:	1	David	London
Output 2:	5	David	London

*/

DROP TABLE IF EXISTS Q4_data;
CREATE TABLE Q4_data
(
	id			INT,
	Name1		VARCHAR(20),
	location	VARCHAR(20)
);
INSERT INTO Q4_data VALUES(1,NULL,NULL);
INSERT INTO Q4_data VALUES(2,'David',NULL);
INSERT INTO Q4_data VALUES(3,NULL,'London');
INSERT INTO Q4_data VALUES(4,NULL,NULL);
INSERT INTO Q4_data VALUES(5,'David',NULL);

SELECT * FROM Q4_data;

-- Output 1
SELECT MIN(id) AS ID, MIN(name) AS NAME1, MIN(location) AS LOCATION
FROM q4_data;

-- Output 2
SELECT MAX(id) AS ID, MIN(name) AS NAME1, MIN(location) AS LOCATION
FROM q4_data;