DROP TABLE IF EXISTS orders;
CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);
INSERT INTO orders VALUES
(1, '2024-02-18', 101),
(1, '2024-02-18', 102),
(1, '2024-02-19', 101),
(1, '2024-02-19', 103),
(2, '2024-02-18', 104),
(2, '2024-02-18', 105),
(2, '2024-02-19', 101),
(2, '2024-02-19', 106); 


SELECT * FROM orders;
/*
SELECT dates, product_id
FROM orders
WHERE customer_id = 1 AND dates = '2024-02-18';
*/

SELECT dates, product_id
FROM orders
UNION
SELECT dates, GROUP_CONCAT(product_id) AS product_id
FROM orders
GROUP BY customer_id, dates
ORDER BY dates, product_id;