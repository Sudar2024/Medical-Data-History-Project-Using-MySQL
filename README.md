# Medical-Data-History-Project-Using-MySQL

### Project Overview
This project demonstrates SQL proficiency through 35 real-world queries based on a simulated Medical Data History database. It includes operations across four tables — patients, doctors, admissions, and provincename. The goal of this project is to extract meaningful insights from healthcare data using various SQL techniques such as filtering, aggregation, joins, subqueries, and stored procedures.
__________________________________________________________________________________________________________________________________________________________________________________________
### Database Schema

The project uses the following main tables:

**patients** – Contains details such as patient ID, names, birth date, height, weight, gender, allergies, province, and city.

**doctors** – Stores information about doctor ID, name, and medical specialty.

**admissions** – Tracks patient admissions including admission and discharge dates, attending doctors, and diagnoses.

**provincename** – Maps province IDs to full province names.

__________________________________________________________________________________________________________________________________________________________________________________________

### Key SQL Concepts Used: 

```
  - SELECT with WHERE, LIKE, IN, BETWEEN

  - Aggregate Functions (COUNT, MAX, MIN, SUM)

  - GROUP BY and HAVING Clauses

  - JOINS (INNER, LEFT JOIN)

  - Window Functions (COUNT(*) OVER)

  - String Functions (CONCAT, UPPER, LOWER, CHAR_LENGTH)

  - Date Functions (YEAR, DAY)

  - Subqueries

  - CASE Statements

  - Stored Procedures
```
____________________________________________________________________________________________________________________________________________________________________________________________

### Key Findings from Medical Data History Analysis:

1) Gender Distribution
The total number of male and female patients was identified, which helps in understanding the gender ratio in the patient database.

Common Allergies

Popular allergies were ranked by frequency, with NULL or empty values replaced by 'NKA' (No Known Allergies).

This cleanup helped identify the most common allergy types and the percentage of patients with no allergies.

Diagnosis Frequency

Repeat admissions for the same diagnosis were found, indicating chronic illnesses or poor recovery for certain patients.

Patients with 'Dementia' and 'Epilepsy' were specifically traced, showing the disease burden and specialist care requirements.

Admissions Patterns

Admissions that occurred and discharged on the same day were identified, likely indicating short-term or emergency visits.

A day-wise breakdown of admissions revealed peak days for patient visits, helping in resource and staff planning.

Height, Weight, and Obesity Trends

Patients were categorized into weight groups, which provides a basic view of the population's health condition.

A BMI-based obesity flag (0 or 1) was calculated, revealing the obesity rate within the patient population.

Demographics by Province and City

Patient distribution by province and city shows the geographic concentration of patients, useful for local healthcare planning.

Some cities in Nova Scotia (NS) had more patients, which might suggest region-specific health focus.

Age Analysis

Birth years of patients were extracted to see age distribution, including patients born in the 1970s and 2010s, indicating a wide age spread.

Doctor-Patient Relationships

By joining the admissions and doctors table, the specialties of attending doctors were retrieved, such as "Lisa" attending epilepsy patients, highlighting doctor expertise mapping.

Patient Diversity

A list of unique first names, names starting with or ending with specific letters, and length-based name filtering was performed, which helps understand diversity in patient data.

Custom Temporary Passwords

A logic was created to generate temporary passwords for patients after their first admission, combining patient ID, last name length, and birth year — showing data engineering logic capability.

Full Name Formatting

Patient names were formatted in multiple ways (e.g., SMITH,john) to show data presentation skills, useful in real-world dashboards or user interfaces.

Top Provinces by Height Sum

Provinces where the total height of patients exceeded 7000 cm were identified, which may be a proxy for demographic clustering or physical health indicators.



