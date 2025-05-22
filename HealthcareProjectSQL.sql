
create database Medical_Data_History;
set sql_safe_updates = 0;
use Medical_data_history;


select * from admissions;
select * from doctors;
select * from patients;
select * from provincename;


describe admissions;
describe doctors;
describe patients;
describe provincename;

-- Creating simple stored procedure to call multiple tables at ones.

Delimiter $$
create procedure show_multiple_tables()
begin
	select * from admissions;
	select * from doctors;
	select * from patients;
	select * from provincename;
end $$
Delimiter ;

call show_multiple_tables;

-- 1) Show first name, last name, and gender of patients who's gender is 'M'

select * from patients;
select first_name, Last_name , gender from patients where gender = 'M';

-- 2) Show first name and last name of patients who does not have allergies.

select first_name, last_name, allergies from patients  where allergies = '';

-- 3) Show first name of patients that start with the letter 'C'.

select first_name from patients where first_name like 'C%';

-- 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

select first_name , last_name from patients where weight between 100 and 120 ;
select first_name, last_name from patients where weight >= 100 and weight <= 120;

-- 5. Update the patients table for the allergies column. If the patient's allergies 
--    is null then replace it with 'NKA'

select allergies from patients where allergies is null;
update patients 
set allergies = 'NKA'
where allergies is null;

-- 6. Show first name and last name concatenated into one column to show their full name.

select concat(first_name,' ',last_name) as "Patient's full Name" from patients;

-- 7) Show first name, last name, and the full province name of each patient.

select * from patients;
select * from provincename;

select pat.first_name, pat.last_name , pro.province_name
from patients pat left join provincename pro
on pat.province_id = pro.province_id;

-- 8 ) Show how many patients have a birth_date with 2010 as the birth year.

select count(*) as 'No.of.Patients' from patients 
where birth_date like '2010%';

-- 9) Show the first_name, last_name, and height of the patient with the greatest height.

select first_name, last_name , height from patients 
where height = (select max(height) from patients) ;

-- 10) Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
select * from patients where patient_id in (1,45,534,879,1000) ;

-- 11) Show the total number of admissions

select count(*) as "Total_Admission" from admissions;

-- 12. Show all the columns from admissions where the patient was admitted and discharged on the same day.

select * from admissions where admission_date = discharge_date;

-- 13) Show the total number of admissions for patient_id 579.

select count(*) as "Total admission"  from admissions where patient_id = 579;

-- 14) Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

select distinct(city) from patients
where province_id = 'NS';

-- 15. Write a query to find the first_name, last name and birth date of patients 
--     who have height more than 160 and weight more than 70

select first_name,last_name, birth_date 
from patients where height > 160 and weight > 70 ;

-- 16) Show unique birth years from patients and order them by ascending.

use Medical_data_history;

select distinct year(birth_date)  from patients order by birth_date asc;


call show_multiple_tables;

-- 17) Show unique first names from the patients table which only occurs once in the list.

select first_name from patients group by first_name having count(*) = 1;

-- or  

SELECT first_name, COUNT(*) 
FROM Patients
GROUP BY first_name having count(*) = 1;

-- 18) Show patient_id and first_name from patients where their first_name start and ends with 's' and 
--     is at least 6 characters long.

select patient_id, first_name from patients where first_name like 's%s' and char_length(first_name) >=6;

-- 19. Show patient_id, first_name, last_name from patients whose diagnosis is 'Dementia'. 
--     Primary diagnosis is stored in the admissions table.

call show_multiple_tables;

select pat.patient_id, pat.first_name, pat.last_name, ad.diagnosis
from patients pat join admissions ad 
on pat.patient_id = ad.patient_id  where ad.diagnosis= 'Dementia';

-- 20) Display every patient's first_name. Order the list by the length of each name and then by alphbetically.

select first_name from patients order by length(first_name) asc, first_name asc;

-- 21) Show the total amount of male patients and the total amount of female 
--      patients in the patients table. Display the two results in the same row.

select distinct(gender),
count(*)
	over ( partition by gender ) as Total_Patients
from patients ;

select 
count(case when gender = 'M' then 1 end ) as Total_Male_patient,
count(case when gender = 'F' then 1 end ) as Total_Female_patient
from patients;

-- 22) Show the total amount of male patients and the total amount of female 
-- patients in the patients table. Display the two results in different same row.
 
select distinct gender, count(*) over (partition by gender) as Total_patients from patients;

-- or we can use simple group by clause 

select distinct gender, count(*) as Total_patients from patients group by gender;

-- 23) Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

select patient_id, diagnosis
from admissions
group by patient_id, diagnosis having count(*) > 1 ;


-- 24) Show the city and the total number of patients in the city. 
--     Order from most to least patients and then by city name ascending.

call show_multiple_tables;

select city, count(*) as Total_patients from patients group by city order by Total_patients desc , city asc;

-- 25) Show first name, last name and role of every person that is either patient or doctor. 
--     The roles are either "Patient" or "Doctor"

select first_name, last_name, 'Doctors' as role 
from Doctors
Union all
select first_name, last_name, 'Patients' as Role
from patients;


-- 26) Show all allergies ordered by popularity. Remove NULL values from query.

call show_multiple_tables;
select * from patients;

select distinct(allergies),count(*) from patients where allergies is not null group by allergies order by count(*) desc;

select allergies, count(*) as count
from patients
where allergies is not null and trim(allergies) <>''																							
group by allergies
order by count desc ;

-- 27. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
--     Sort the list starting from the earliest birth_date.

select first_name, last_name , birth_date 
from patients where birth_date between '1970-01-01' and '1979-12-31'
order by birth_date asc;

/*   28) We want to display each patient's full name in a single column. 
	Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
	Separate the last_name and first_name with a comma. 
	Order the list by the first_name in decending order EX: SMITH,jane */
    
    select concat(upper(last_name),',',lower(first_name)) as "Patient Name" from patients 
    order by lower(first_name) desc;

/* 29. Show the province_id(s), sum of height; where the total sum of its patient's 
height is greater than or equal to 7,000. */

select * from patients;
select province_id, sum(height) as Total_height from patients group by province_id having Total_height >= 7000;

-- 30) Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni':

select max(weight)-min(weight) as "Difference b/w weight" from patients where last_name = 'Maroni' ;

-- 31) Show all of the days of the month (1-31) and how many admission_dates occurred on that day. 
--     Sort by the day with most admissions to least admissions.


select day(admission_date) as "Day of month" ,  count(*) as admission_count 
from admissions 
group by day(admission_date) 
order by (admission_count) desc  ;

/* 32) Show all of the patients grouped into weight groups. 
Show the total amount of patients in each weight group. 
Order the list by the weight group decending. e.g. if they weight 100 to 109 they are placed 
in the 100 weight group, 110-119 = 110 weight group, etc. */ 

select * from patients;

select floor(weight/10)*10 as weight_group, count(*) as Total_patients 
from patients 
where weight is not null
group by weight_group
order by weight_group desc;


/* 33) 33. Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. 
Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm. */

select patient_id,weight,height,
case 
when weight / POWER(height / 100, 2) >= 30 then 1
else 0
end as isObese
from patients
where weight is not null and height is not null;

/* 34) 34. Show patient_id, first_name, last_name, and attending doctor's specialty. 
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. 
Check patients, admissions, and doctors tables for required information. */
call show_multiple_tables;
select pat.patient_id, pat.first_name, pat.last_name, doc.specialty,ad.diagnosis
from patients pat 
	join admissions ad on ad.patient_id = pat.patient_id
	join doctors doc on ad.attending_doctor_id = doc.doctor_id
where ad.diagnosis = 'Epilepsy' and doc.first_name = 'Lisa';

/* 35. All patients who have gone through admissions, can see their medical documents on our site. 
Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
The password must be the following, in order:
- patient_id
- the numerical length of patient's last_name
- year of patient's birth_date */

select 
  p.patient_id,
  concat (p.patient_id,LENGTH(p.last_name),year(p.birth_date)) as temp_password
from patients p
where p.patient_id in (select distinct patient_id from admissions);


