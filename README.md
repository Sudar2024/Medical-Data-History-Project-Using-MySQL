# Medical-Data-History-Project-Using-MySQL

```sql
SELECT 
  p.patient_id,
  CONCAT(
    p.patient_id,
    LENGTH(p.last_name),
    YEAR(p.birth_date)
  ) AS temp_password
FROM patients p
WHERE p.patient_id IN (SELECT DISTINCT patient_id FROM admissions);
```

_______________________________________________________________________________________________________________________________________________________________________________


```

35. All patients who have gone through admissions, can see their medical documents on our site. 
Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
The password must be the following, in order:
- patient_id
- the numerical length of patient's last_name
- year of patient's birth_date

```
