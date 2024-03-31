drop table if exists day_indicator;
create table day_indicator
(
	Product_ID 		varchar(10),	
	Day_Indicator 	varchar(7),
	Dates			date
);

INSERT INTO day_indicator VALUES('AP755', '1010101', '2024-03-04');
INSERT INTO day_indicator VALUES('AP755', '1010101', '2024-03-05');
INSERT INTO day_indicator VALUES('AP755', '1010101', '2024-03-06');
INSERT INTO day_indicator VALUES('AP755', '1010101', '2024-03-07');
INSERT INTO day_indicator VALUES('AP755', '1010101', '2024-03-08');
INSERT INTO day_indicator VALUES('AP755', '1010101', '2024-03-09');
INSERT INTO day_indicator VALUES('AP755', '1010101', '2024-03-10');

INSERT INTO day_indicator VALUES('XQ802', '1000110', '2024-03-04');
INSERT INTO day_indicator VALUES('XQ802', '1000110', '2024-03-05');
INSERT INTO day_indicator VALUES('XQ802', '1000110', '2024-03-06');
INSERT INTO day_indicator VALUES('XQ802', '1000110', '2024-03-07');
INSERT INTO day_indicator VALUES('XQ802', '1000110', '2024-03-08');
INSERT INTO day_indicator VALUES('XQ802', '1000110', '2024-03-09');
INSERT INTO day_indicator VALUES('XQ802', '1000110', '2024-03-10');

SELECT * FROM day_indicator;


/*
-> dayofweek() function ins MySQL Workbench assumes the start of the week from Sunday, ie 1. Hence the subsequent days
will be Monday 2, Tuesday 3 etc. The last day ie, Saturday is 7.
-> weekday() function starts from Monday. And Monday is given as 0. Hence the days will be from 0 to 6.
As the requirement we need is the week to start from Monday, so, I'm adding +1 to the weekday().
*/

-- Showing the output of dayofweek() and weekday() function.
SELECT *, dayofweek(dates), weekday(dates) AS w_day
FROM day_indicator
WHERE Product_ID = 'AP755';


SELECT Product_ID, Day_Indicator, Dates
FROM (
SELECT *, weekday(dates) AS w_day, weekday(dates) + 1 AS req_days,
	CASE WHEN substring(day_indicator, weekday(dates) + 1, 1) = '1' THEN 'yes' ELSE 'no' end as flag 
FROM day_indicator) x
WHERE x.flag = 'yes';	