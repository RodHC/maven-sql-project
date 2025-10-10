# Hospital Analytics — Queries & Results

This report documents all SQL queries, explanations, and results for the Hospital Analytics project. Each section includes the business question, the query used to answer it, and a placeholder for the visual output or screenshot.

**Note:** Original dataset is excluded due to copyright restrictions. All queries and results are shared for educational purposes only.

---

## OBJECTIVE 1: ENCOUNTERS OVERVIEW

### 1. Total Encounters Per Year

**Business Question:**  
How many total encounters occurred each year?

**SQL Query:**
```sql
SELECT
  strftime('%Y', START) AS year,
  COUNT(Id) AS patient_count
FROM encounters
GROUP BY year
ORDER BY year;
```
[![Total Encounters Per Year](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/total_encounters_per_year.png)](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/total_encounters_per_year.png)

### 2. Encounter Class Distribution by Year

**Business Question:**
For each year, what percentage of encounters belonged to each encounter class (ambulatory, outpatient, wellness, urgent care, emergency, inpatient)?

**SQL Query:**
```sql
SELECT 
  strftime('%Y', START) AS year,
  ROUND(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'ambulatory' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ambulatory,
  ROUND(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'outpatient' THEN 1 ELSE 0 END) / COUNT(*), 2) AS outpatient,
  ROUND(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'wellness' THEN 1 ELSE 0 END) / COUNT(*), 2) AS wellness,
  ROUND(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'urgentcare' THEN 1 ELSE 0 END) / COUNT(*), 2) AS urgent_care,
  ROUND(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'emergency' THEN 1 ELSE 0 END) / COUNT(*), 2) AS emergency,
  ROUND(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'inpatient' THEN 1 ELSE 0 END) / COUNT(*), 2) AS inpatient
FROM encounters
GROUP BY year
ORDER BY year;
```
[![Total Encounters Per Year](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/encounter_class_distribution.png)](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/encounter_class_distribution.png)

### 3. Encounters Over vs. Under 24 Hours

**Business Question:**
What percentage of encounters were over 24 hours versus under 24 hours?

**SQL Query:**
```sql
SELECT 
  ROUND(100.0 * SUM(CASE WHEN ((julianday(STOP) - julianday(START)) * 24) >= 24 THEN 1 ELSE 0 END) / COUNT(*), 2) AS over_24_hrs,
  ROUND(100.0 * SUM(CASE WHEN ((julianday(STOP) - julianday(START)) * 24) < 24 THEN 1 ELSE 0 END) / COUNT(*), 2) AS under_24_hrs,
  COUNT(*) AS total_encounter
FROM encounters;
```
[![Total Encounters Per Year](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/encounters_over_under_24hrs.png)](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/encounters_over_under_24hrs.png)

## OBJECTIVE 2: COST & COVERAGE INSIGHTS

### 4. Encounters with Zero Payer Coverage

**Business Question:**
How many encounters had zero payer coverage, and what percentage of total encounters does this represent?

**SQL Query:**
```sql
SELECT
	SUM(CASE WHEN PAYER_COVERAGE <= 0 THEN 1 ELSE 0 END) AS zero_payer_coverage,
	ROUND(100.0 * SUM(CASE WHEN PAYER_COVERAGE <= 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS zero_payer_coverage_pct,
	COUNT(*) AS total_encounters
FROM encounters
```
[![Total Encounters Per Year](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/encounters_zero_pay_coverage.png)](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/encounters_zero_pay_coverage.png)

### 5. Top 10 Most Frequent Procedures

**Business Question:**
What are the top 10 most frequent procedures performed and their average base cost?

**SQL Query:**
```sql
SELECT
  CODE,
  DESCRIPTION, 
  COUNT(*) AS num_procedures,
  ROUND(AVG(BASE_COST), 1) AS avg_base_cost
FROM procedures
GROUP BY CODE, DESCRIPTION
ORDER BY num_procedures DESC
LIMIT 10;
```
[![Total Encounters Per Year](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/top_10_procedures_cost.png)](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/top_10_procedures_cost.png)

### 6. Top 10 Procedures by Highest Average Cost

**Business Question:**
What are the top 10 procedures with the highest average base cost and how many times were they performed?

**SQL Query:**
```sql
SELECT
  CODE,
  DESCRIPTION,
  COUNT(*) AS num_procedures,
  ROUND(AVG(BASE_COST), 1) AS highest_avg_base_cost
FROM procedures
GROUP BY CODE, DESCRIPTION
ORDER BY highest_avg_base_cost DESC
LIMIT 10;
```
[![Total Encounters Per Year](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/top_10_procedure_highest_base_cost.png)](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/top_10_procedure_highest_base_cost.png)

### 7. Average Total Claim Cost by Payer

**Business Question:**
What is the average total claim cost for encounters, broken down by payer?

**SQL Query:**
```sql
SELECT	
  p.NAME,
  ROUND(AVG(e.TOTAL_CLAIM_COST), 1) AS avg_claim_cost
FROM encounters e 
LEFT JOIN payers p ON e.PAYER = p.Id
GROUP BY p.NAME
ORDER BY avg_claim_cost DESC;
```
[![Total Encounters Per Year](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/avg_claim_cost_by_payer.png)](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/avg_claim_cost_by_payer.png)

## OBJECTIVE 3: PATIENT BEHAVIOR ANALYSIS

### 8. Unique Patients Per Quarter

**Business Question:**
How many unique patients were admitted each quarter over time?

**SQL Query:**
```sql
SELECT
  strftime('%Y', START) AS year,
  CASE 
    WHEN CAST(strftime('%m', START) AS INTEGER) BETWEEN 1 AND 3 THEN 'Q1'
    WHEN CAST(strftime('%m', START) AS INTEGER) BETWEEN 4 AND 6 THEN 'Q2'
    WHEN CAST(strftime('%m', START) AS INTEGER) BETWEEN 7 AND 9 THEN 'Q3'
    WHEN CAST(strftime('%m', START) AS INTEGER) BETWEEN 10 AND 12 THEN 'Q4'
  END AS quarter,
  COUNT(DISTINCT PATIENT) AS num_patients
FROM encounters
GROUP BY year, quarter
ORDER BY year, quarter;
```
[![Total Encounters Per Year](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/number_of_patients_by_quarter.png)](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/number_of_patients_by_quarter.png)

### 9. Readmissions Within 30 Days

**Business Question:**
How many patients were readmitted within 30 days of a previous encounter?

**SQL Query:**
```sql
WITH cte AS (
  SELECT 
    PATIENT,
    START,
    STOP,
    LEAD(START) OVER(PARTITION BY PATIENT ORDER BY START) AS next_start_date
  FROM encounters
)
SELECT 
  COUNT(DISTINCT PATIENT) AS total_patients
FROM cte
WHERE (julianday(next_start_date) - julianday(STOP)) < 30;
```
[![Total Encounters Per Year](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/readmitted_patients_within_30_days.png)](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/readmitted_patients_within_30_days.png)

### 10. Patients With the Most Readmissions

**Business Question:**
Which patients had the most readmissions within 30 days?

**SQL Query:**
```sql
WITH cte AS (
  SELECT 
    PATIENT,
    START,
    STOP,
    LEAD(START) OVER(PARTITION BY PATIENT ORDER BY START) AS next_start_date
  FROM encounters
)
SELECT 
  PATIENT, 
  COUNT(*) AS num_readmissions
FROM cte
WHERE (julianday(next_start_date) - julianday(STOP)) < 30 
GROUP BY PATIENT
ORDER BY num_readmissions DESC;
```
[![Total Encounters Per Year](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/patients_with_most_readmissions.png)](https://raw.githubusercontent.com/RodHC/maven-sql-project/main/sql/query_images/patients_with_most_readmissions.png)
