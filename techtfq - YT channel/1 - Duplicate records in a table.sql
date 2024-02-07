/*Write a SQL Query to fetch all the duplicate records in a table.*/

CREATE TABLE users
(
user_id INT PRIMARY KEY,
user_name VARCHAR(30) NOT NULL,
email VARCHAR(50));

SELECT * FROM query1.users;

INSERT INTO query1.users VALUES
(1, 'Sumit', 'sumit@gmail.com'),
(2, 'Reshma', 'reshma@gmail.com'),
(3, 'Farhana', 'farhana@gmail.com'),
(4, 'Robin', 'robin@gmail.com'),
(5, 'Robin', 'robin@gmail.com');

SELECT * FROM query1.users;


SELECT user_id, user_name, email
FROM (SELECT *,
		ROW_NUMBER() OVER(PARTITION BY user_name ORDER BY user_id) AS rn
        FROM query1.users
        ORDER BY user_id) sub
WHERE sub.rn > 1;
