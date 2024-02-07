SELECT * FROM query8.event_category;

SELECT * FROM query8.patient_treatment;

SELECT * FROM query8.physician_speciality;


SELECT physician_speciality.speciality
FROM physician_speciality
SELECT pt.event_name, pt.physician_id
FROM query8.patient_treatment pt
     JOIN query8.event_category ec ON pt.event_name = ec.event_name
WHERE ec.category = 'Prescription';

select pt2.event_name, pt2.physician_id
							from query8.patient_treatment pt2
							join query8.event_category ec on ec.event_name = pt2.event_name
							where ec.category = 'Prescription';