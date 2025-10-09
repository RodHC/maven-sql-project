-- OBJECTIVE 1: ENCOUNTERS OVERVIEW

-- a. How many total encounters occurred each year?

SELECT
	strftime('%Y', START) AS year,
	count(Id) AS patient_count
FROM encounters
GROUP BY year
ORDER BY year

-- b. For each year, what percentage of all encounters belonged to each encounter class
-- (ambulatory, outpatient, wellness, urgent care, emergency, and inpatient)?

SELECT 
	strftime('%Y', START) AS year,
	round(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'ambulatory' THEN 1 ELSE 0 END) / count(*), 2)   AS ambulatory,
	round(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'outpatient' THEN 1 ELSE 0 END) / count(*), 2)  AS outpatient,
	round(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'wellness' THEN 1 ELSE 0 END) / count(*), 2)  AS wellness,
	round(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'urgentcare' THEN 1 ELSE 0 END) / count(*), 2)  AS urgent_care,
	round(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'emergency' THEN 1 ELSE 0 END) / count(*), 2)  AS emergency,
	round(100.0 * SUM(CASE WHEN ENCOUNTERCLASS = 'inpatient' THEN 1 ELSE 0 END) / count(*), 2)  AS inpatient
FROM encounters
GROUP BY year
ORDER BY year

-- c. What percentage of encounters were over 24 hours versus under 24 hours?

SELECT 
	ROUND(100.0 * SUM(CASE WHEN ((julianday(STOP) - julianday(START)) * 24) >= 24 THEN 1 ELSE 0 END) / COUNT(*), 2) AS over_24_hrs,
	ROUND(100.0 * SUM(CASE WHEN ((julianday(STOP) - julianday(START)) * 24) < 24 THEN 1 ELSE 0 END) / COUNT(*), 2) AS under_24_hrs,
	COUNT(*) AS total_encounter
FROM encounters


-- OBJECTIVE 2: COST & COVERAGE INSIGHTS

-- a. How many encounters had zero payer coverage, and what percentage of total encounters does this represent?

SELECT
	SUM(CASE WHEN PAYER_COVERAGE <= 0 THEN 1 ELSE 0 END) AS zero_payer_coverage,
	ROUND(100.0 * SUM(CASE WHEN PAYER_COVERAGE <= 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS zero_payer_coverage_pct,
	COUNT(*) AS total_encounters
FROM encounters

-- b. What are the top 10 most frequent procedures performed and the average base cost for each?

SELECT
	CODE,
	DESCRIPTION, 
	COUNT(*) AS num_procedures,
	ROUND(AVG(BASE_COST), 1) AS avg_base_cost
FROM procedures
GROUP BY 
	CODE, 
	DESCRIPTION
ORDER BY
	num_procedures DESC
LIMIT 10;


-- c. What are the top 10 procedures with the highest average base cost and the number of times they were performed?

SELECT
	CODE,
	DESCRIPTION,
	COUNT(*) AS num_procedures,
	ROUND(AVG(BASE_COST), 1) AS highest_avg_base_cost
FROM procedures
GROUP BY
	CODE, 
	DESCRIPTION
ORDER BY 
	highest_avg_base_cost DESC
LIMIT 10;

-- d. What is the average total claim cost for encounters, broken down by payer?

SELECT	
	p.NAME,
	ROUND(AVG(e.TOTAL_CLAIM_COST), 1) AS avg_claim_cost
FROM encounters e 
LEFT JOIN payers p ON e.PAYER = p.Id
GROUP BY p.NAME
ORDER BY avg_claim_cost DESC;

-- OBJECTIVE 3: PATIENT BEHAVIOR ANALYSIS

-- a. How many unique patients were admitted each quarter over time?

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
ORDER BY year, quarter 

-- b. How many patients were readmitted within 30 days of a previous encounter?

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
WHERE (julianday(next_start_date) - julianday(STOP)) < 30 

-- c. Which patients had the most readmissions?

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
