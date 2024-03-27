drop table if exists interview_questions.mountain_huts;
create table interview_questions.mountain_huts 
(
	id 			integer not null unique,
	name 		varchar(40) not null unique,
	altitude 	integer not null
);
insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists interview_questions.trails;
create table interview_questions.trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);
insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);

select * from mountain_huts;
select * from trails;


WITH cte1 AS (
SELECT tr.hut1 AS start_hut, mh1.name AS start_hut_name, mh1.altitude AS start_hut_alt, mh2.id AS end_hut, mh2.name AS end_hut_name, mh2.altitude AS end_hut_alt
FROM mountain_huts mh1
JOIN trails tr
	ON mh1.id = tr.hut1
JOIN mountain_huts mh2
	ON mh2.id = tr.hut2
),
alt_flag_cte AS (
SELECT *,
	CASE WHEN start_hut_alt > end_hut_alt THEN 1
		 ELSE 0
	END AS alt_flag
FROM cte1
),
final_cte AS (
SELECT 
	CASE WHEN alt_flag = 1 THEN start_hut ELSE end_hut END AS start_hut,
    CASE WHEN alt_flag = 1 THEN start_hut_name ELSE end_hut_name END AS start_hut_name,
--    CASE WHEN alt_flag = 1 THEN start_hut_alt ELSE end_hut_alt END AS start_hut_alt,
    CASE WHEN alt_flag = 0 THEN start_hut ELSE end_hut END AS end_hut,
    CASE WHEN alt_flag = 0 THEN start_hut_name ELSE end_hut_name END AS end_hut_name
--    CASE WHEN alt_flag = 0 THEN start_hut_alt ELSE end_hut_alt END AS end_hut_alt
FROM alt_ flag_cte
)
-- 2-3-5
-- 1-3-5
-- 1-5-4
-- 3-5-4
SELECT fc1.start_hut_name AS start_point, fc2.start_hut_name AS mid_point, fc2.end_hut_name AS end_point
FROM final_cte fc1
JOIN final_cte fc2
	ON fc1.end_hut = fc2.start_hut;