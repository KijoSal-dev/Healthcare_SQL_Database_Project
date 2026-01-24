-----Healthcare SQL Mini Project Questions 
--1. List all patients who live in Seattle. 
SELECT * FROM healthcare_patients
WHERE city = 'Seattle';

--2. Find all medications where the dosage is greater than 50mg. 
SELECT * FROM healthcare_medications
WHERE dosage >= '50mg';

--3. Get all completed appointments in February 2024. 
SELECT * FROM healthcare_appointments
WHERE status = 'completed'
AND appointment_date BETWEEN '2024-02-01' AND '2024-02-29';

--4. Show each doctor and how many appointments they completed.
SELECT * FROM healthcare_doctors

SELECT D.doctor_id, D.doctor_name, D.specialty, D.clinic_location, COUNT(A.appointment_id) AS complete_appointments
FROM healthcare_doctors D
LEFT JOIN healthcare_appointments A
ON D.doctor_id = A.doctor_id
AND A.status = 'completed'
GROUP BY D.doctor_id, D.doctor_name, D.specialty, D.clinic_location
ORDER BY complete_appointments DESC

--5. Find the most common diagnosis in the database. 
SELECT * FROM healthcare_diagnoses

SELECT diagnosis_code, COUNT(*) AS count
FROM healthcare_diagnoses
GROUP BY diagnosis_code
ORDER BY count DESC
LIMIT 1;

--6. List the total billing amount per patient. 
SELECT * FROM healthcare_billing
SELECT * FROM healthcare_patients

SELECT P.patient_id, 
CONCAT(P.first_name, ' ', P.last_name) AS patients_fullname, 
P.gender, 
COUNT(B.amount) AS total_billing
FROM healthcare_patients P
LEFT JOIN healthcare_appointments A
ON P.patient_id = A.patient_id
LEFT JOIN healthcare_billing B
ON B.appointment_id = A.appointment_id
GROUP BY P.patient_id, CONCAT(P.first_name, ' ', P.last_name), P.gender
ORDER BY total_billing DESC

--7. Which clinic location has the highest number of appointments? 
SELECT * FROM healthcare_appointments
SELECT * FROM healthcare_doctors

SELECT D.clinic_location, COUNT(appointment_id) AS number_of_appointments
FROM healthcare_doctors D
LEFT JOIN healthcare_appointments A
ON D.doctor_id = A.doctor_id
GROUP BY D.clinic_location
ORDER BY number_of_appointments DESC
LIMIT 1

--8. Identify patients who have more than one diagnosis in 2024. 
SELECT * FROM healthcare_patients
SELECT * FROM healthcare_diagnoses
SELECT * FROM healthcare_appointments

SELECT P.patient_id, 
CONCAT(P.first_name, ' ', P.last_name) AS patients_fullname, 
gender, 
city, 
COUNT(D.diagnosis_code) AS diagnosis_count
FROM healthcare_patients P
LEFT JOIN healthcare_appointments A
ON P.patient_id = A.patient_id
LEFT JOIN healthcare_diagnoses D
ON D.appointment_id = A.appointment_id
WHERE A.appointment_date BETWEEN '12-01-2024' AND '12-31-2024'
GROUP BY P.patient_id, CONCAT(P.first_name, ' ', P.last_name), gender, city
HAVING COUNT(D.diagnosis_code) > 1

--9. Rank doctors by total revenue generated. 
SELECT * FROM healthcare_doctors
SELECT * FROM healthcare_billing
SELECT * FROM healthcare_appointments

SELECT D.doctor_id, D.doctor_name, D.specialty, D.clinic_location, SUM(B.amount) AS total_revenue
FROM healthcare_doctors D
LEFT JOIN healthcare_appointments A
ON D.doctor_id = A.doctor_id
LEFT JOIN healthcare_billing B
ON B.appointment_id = A.appointment_id
GROUP BY D.doctor_id, D.doctor_name, D.specialty, D.clinic_location
ORDER BY total_revenue DESC

--10. For each patient, show their most recent appointment. 
SELECT * FROM healthcare_patients
SELECT * FROM healthcare_appointments

SELECT P.patient_id, CONCAT(P.first_name, ' ', P.last_name) AS patients_fullname, P.gender, P.city, P.insurance_provider, A.appointment_id, A.doctor_id, A.appointment_date
FROM healthcare_patients P
LEFT JOIN healthcare_appointments A
ON A.appointment_id =(
SELECT A2.appointment_id 
FROM healthcare_appointments A2
WHERE A2.patient_id = P.patient_id
ORDER BY A2.appointment_date DESC
LIMIT 1
)

--11. Identify patients whose insurance covered less than 70% of their bill
SELECT * FROM healthcare_patients
SELECT * FROM healthcare_billing
SELECT * FROM healthcare_appointments

SELECT P.patient_id, 
CONCAT(P.first_name, ' ', P.last_name) AS patients_fullname, 
P.gender, 
P.date_of_birth, 
P.city, 
P.insurance_provider, 
( SUM(B.insurance_covered)::numeric / SUM(B.amount)::numeric ) * 100 AS insurance_percentage
FROM healthcare_patients P
LEFT JOIN healthcare_appointments A
ON P.patient_id = A.patient_id
LEFT JOIN healthcare_billing B
ON B.appointment_id = A.appointment_id
GROUP BY P.patient_id, CONCAT(P.first_name, ' ', P.last_name), P.gender, P.date_of_birth, P.city, P.insurance_provider
HAVING ( SUM(B.insurance_covered)::numeric / SUM(B.amount)::numeric ) * 100  < 70

--12. Identify all diabetic patients and list their last medication renewal date.
SELECT * FROM healthcare_patients
SELECT * FROM healthcare_medications

SELECT P.patient_id, 
CONCAT(P.first_name, ' ', P.last_name) AS patients_fullname, 
P.gender, 
P.date_of_birth, 
P.city, 
P.insurance_provider, 
'Metformin' AS diabetes_medication,
MAX(M.end_date) AS last_renewal_date
FROM healthcare_patients P
LEFT JOIN healthcare_medications M
ON P.patient_id = M.patient_id
WHERE M.medication_name =('Metformin')
GROUP BY P.patient_id, 
CONCAT(P.first_name, ' ', P.last_name), 
P.gender, 
P.date_of_birth, 
P.city, 
P.insurance_provider

--13. Which doctor has the lowest no‑show rate?
SELECT * FROM healthcare_doctors
SELECT * FROM healthcare_appointments

SELECT D.doctor_id, 
D.doctor_name, 
D.specialty, 
D.clinic_location, 
(COUNT(*) FILTER (WHERE A.status = 'No-show')::float / COUNT(*)) * 100 AS no_show_rate_percentage
FROM healthcare_doctors D
JOIN healthcare_appointments A
ON D.doctor_id = A.doctor_id
GROUP BY D.doctor_id, D.doctor_name, D.specialty, D.clinic_location
ORDER BY no_show_rate_percentage ASC
LIMIT 1

--14. Which age group has the highest incidence of hypertension (I10)?
SELECT * FROM healthcare_patients
SELECT * FROM healthcare_appointments
SELECT * FROM healthcare_diagnoses

SELECT
  CASE
    WHEN DATE_PART('year', AGE(CURRENT_DATE, P.date_of_birth)) BETWEEN 0 AND 17 THEN '0-17'
    WHEN DATE_PART('year', AGE(CURRENT_DATE, P.date_of_birth)) BETWEEN 18 AND 35 THEN '18-35'
    WHEN DATE_PART('year', AGE(CURRENT_DATE, P.date_of_birth)) BETWEEN 36 AND 50 THEN '36-50'
    WHEN DATE_PART('year', AGE(CURRENT_DATE, P.date_of_birth)) BETWEEN 51 AND 65 THEN '51-65'
    ELSE '66+'
  END AS age_group,
  ROUND(
    COUNT(DISTINCT CASE WHEN D.diagnosis_code = 'I10' THEN P.patient_id END)::numeric
    / NULLIF(COUNT(DISTINCT P.patient_id),0) * 100, 2
  ) AS hypertension_incidence_percentage
FROM healthcare_patients P
JOIN healthcare_appointments A ON P.patient_id = A.patient_id
JOIN healthcare_diagnoses D ON A.appointment_id = D.appointment_id
GROUP BY age_group
ORDER BY hypertension_incidence_percentage DESC
LIMIT 1;

--15. Which insurance provider covers the highest average amount?
SELECT * FROM healthcare_patients
SELECT * FROM healthcare_billing

SELECT P.insurance_provider, AVG(B.amount) AS average_amount
FROM healthcare_patients P
JOIN healthcare_appointments A
ON P.patient_id = A.patient_id
JOIN healthcare_billing B
ON B.appointment_id = A.appointment_id
GROUP BY P.insurance_provider
ORDER BY average_amount DESC
LIMIT 1

--16. Determine peak days of the week for appointments.
SELECT * FROM healthcare_appointments

SELECT weekday, num_appointments
FROM (
    SELECT
        TO_CHAR(appointment_date, 'Day') AS weekday,
        COUNT(*) AS num_appointments,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM healthcare_appointments
    GROUP BY weekday
) sub
WHERE rnk = 1;