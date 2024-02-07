SELECT * FROM query4.doctors;

insert into query4.doctors values
(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
(2, 'Dr. Abdul', 'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500);

/*From the doctors table, fetch the details of doctors who work in the same hospital but in different speciality.*/
SELECT d1.name, d1.speciality, d1.hospital
FROM query4.doctors d1
JOIN query4.doctors d2
ON d1.hospital = d2.hospital AND d1.speciality <> d2.speciality;

/*From the doctors table, fetch the details of doctors who work in the same hospital irrespective of their speciality.*/
SELECT d1.name, d1.speciality, d1.hospital
FROM query4.doctors d1
JOIN query4.doctors d2
ON d1.hospital = d2.hospital AND d1.id <> d2.id;