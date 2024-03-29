/* PROBLEM STATEMENT: Write a sql query to return the footer values from input table, 
meaning all the last non null values from each field as shown in expected output.
*/

DROP TABLE IF EXISTS FOOTER;

CREATE TABLE FOOTER 
(
	id 			INT PRIMARY KEY,
	car 		VARCHAR(20), 
	length 		INT, 
	width 		INT, 
	height 		INT
);

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

SELECT * FROM FOOTER;


-- Solution 1:
SELECT *
FROM (SELECT car FROM footer WHERE car IS NOT NULL ORDER BY id DESC LIMIT 1) car
CROSS JOIN (SELECT length FROM footer WHERE length IS NOT NULL ORDER BY id DESC LIMIT 1) length
CROSS JOIN (SELECT width FROM footer WHERE width IS NOT NULL ORDER BY id DESC LIMIT 1) width
CROSS JOIN (SELECT height FROM footer WHERE height IS NOT NULL ORDER BY id DESC LIMIT 1) height;