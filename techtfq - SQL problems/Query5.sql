SELECT * FROM query5.login_details;

/*insert into query5.login_details values
(101, 'Michael', 2021-08-21);

insert into query5.login_details values (102, 'James', current_date);
insert into query5.login_details values (103, 'Stewart', current_date+1);
insert into query5.login_details values (104, 'Stewart', current_date+1);
insert into query5.login_details values (105, 'Stewart', current_date+1);
insert into query5.login_details values (107, 'Michael', current_date+2);
insert into query5.login_details values (108, 'Stewart', current_date+3);
insert into query5.login_details values (109, 'Stewart', current_date+3);
insert into query5.login_details values (110, 'James', current_date+4);
insert into query5.login_details values (111, 'James', current_date+4);
insert into query5.login_details values (112, 'James', current_date+5);
insert into query5.login_details values (113, 'James', current_date+6);*/

SELECT DISTINCT(user_name)
FROM (
		SELECT *,
		CASE WHEN user_name = LEAD(user_name) OVER (ORDER BY login_id)
				AND user_name = LEAD(user_name, 2) OVER (ORDER BY login_id)
			THEN user_name
			ELSE null
		END AS repeated_users
FROM query5.login_details) x
WHERE x.repeated_users IS NOT null;