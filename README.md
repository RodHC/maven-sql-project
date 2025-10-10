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

1. README.md - Project Documentation
2. queries.sql - All SQL queries used in the project
3. queries_and_results.md - All Business questions, queries, and results with visuals
4. schema.sql - Database Schema
5. query_images - Screenshots of query results

## Tools

1. SQLite
2. DB Browser for SQLite

## Key Findings & Insights

### 1. Encounter Trends Over Time
- Total Encounters: The dataset contains 27,891 encounters from 2011–2022.
- Growth & Fluctuations: Encounters grew significantly between 2011 (1,336) and 2014 (3,885), followed by fluctuations and a notable peak again in 2021 (3,530).
- 2022 has incomplete data.

---

### 2. Encounter Class Distribution
- Ambulatory care consistently represents the largest share of encounters, averaging around 45–60% annually.
- Outpatient visits are the second most common (17–24%), followed by wellness visits (4–13%).
- Urgent care and emergency visits remain smaller segments (2–17% combined).
- Inpatient stays make up the smallest proportion (<7%).

---

### 3. Encounter Duration
- The vast majority of encounters (95.9%) lasted under 24 hours, while only 4.1% extended beyond that threshold.
- This highlights that most care episodes are short-term and do not require extended hospitalization.

---

### 4. Coverage Gaps & Financial Implications
- Nearly 48.7% of all encounters (13,586) occurred with zero payer coverage, indicating a significant portion of patients were either uninsured or had no insurance claims submitted.
- This is a critical finding for healthcare administrators — addressing coverage gaps could dramatically improve revenue capture and reduce uncompensated care.

---

### 5. Cost Insights by Payer
- Medicaid has the highest average claim cost ($6,205.2), followed by patients with no insurance ($5,593.2).
- Private insurers like Anthem, Humana, and Blue Cross show average claim costs between $3,200–$4,200, while Medicare and Dual Eligible patients have the lowest costs (<$2,200).
- This suggests that payer mix significantly impacts revenue and cost structures.

---

### 6. Procedures: Volume vs. Cost
- Most Frequent Procedures: Routine assessments dominate — including assessment of care needs, hospice care, depression screening, and substance use assessments — all with approximately 1,400–4,500+ occurrences but relatively low costs (~$431–$1,004).
- Highest Cost Procedures: ICU admissions, coronary bypass grafting, and breast lumpectomies show the highest average base costs, ranging from $19,728 to $206,260. These are less frequent but represent substantial financial impact per case.

---

### 7. Patient Behavior & Readmissions
- Readmissions: Of 773 patients identified with readmissions, some experienced extremely high recurrence, with one patient readmitted 1,376 times.
- Within 30 Days: Many patients were readmitted within 30 days, indicating potential gaps in post-discharge care or chronic condition management.
- Patient Concentration: A small cohort drives the majority of readmissions — a classic “high-utilizer” profile that offers opportunities for targeted care interventions.

---

### 8. Patient Flow Over Time
- Quarterly patient admissions range from 150–400+, with notable spikes in Q1 2014 (394) and Q1 2021 (417).
- Seasonal fluctuations are consistent, but the data shows a general upward trend in patient volumes until 2021.

---

## Strategic Takeaways

- Revenue Optimization: With nearly half of encounters uncovered by payers, expanding insurance verification and billing workflows could significantly increase revenue.
- Cost Control: Targeting high-cost procedures and improving pre- and post-care coordination can reduce expenses.
- Readmission Reduction: Focused care programs for the small percentage of high-utilization patients could substantially lower readmissions and improve outcomes.
- Capacity Planning: The dominance of short-term encounters and the rise in ambulatory and outpatient visits suggests shifting resources away from inpatient capacity toward more flexible, outpatient-oriented care models.

---
