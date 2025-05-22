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
