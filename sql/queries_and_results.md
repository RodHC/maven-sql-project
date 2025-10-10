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

###2. Encounter Class Distribution by Year

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
