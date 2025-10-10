# Hospital Analytics — SQL Project

## Project Overview
This project explores hospital encounter data using SQL to uncover insights that can improve patient care, reduce costs, and support strategic decision-making.

The analysis focuses on patient encounters, procedure costs, coverage gaps, and readmission trends to help healthcare organizations make data-driven decisions around operations and patient outcomes.

> Note: The original dataset is not included in this repository due to copyright restrictions. All queries, results, and screenshots are shared for educational purposes only.

---

## Objectives
The goal of this analysis is to answer key business and operational questions, including:

1. How many total encounters occurred each year?
2. What percentage of encounters belonged to each encounter class (ambulatory, outpatient, wellness, urgent care, emergency, inpatient)?
3. What percentage of encounters lasted over 24 hours vs. under 24 hours?
4. How many encounters had zero payer coverage, and what percentage of total encounters does this represent?
5. What are the top 10 most frequent procedures and their average base cost?
6. Which procedures have the highest average base cost, and how many times were they performed?
7. What is the average total claim cost per payer?
8. How many unique patients were admitted each quarter over time?
9. How many patients were readmitted within 30 days?
10. Which patients had the most readmissions?

---

## Project Structure

maven-sql-project
│
├─ README.md # Project documentation (this file)
├─ queries_and_results.md # All business questions, queries, and results with visuals
│
├─ sql/
│ ├─ queries.sql # All SQL queries used in the project
│ ├─ schema.sql # Database schema (optional)
│ └─ query_images/ # Screenshots of query results
│
└─ data/ # (Optional) Placeholder if dataset is added later
