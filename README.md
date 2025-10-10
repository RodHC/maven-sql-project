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
5. How many encounters had zero payer coverage by Payer?
6. What are the top 10 most frequent procedures and their average base cost?
7. Which procedures have the highest average base cost, and how many times were they performed?
8. What is the average total claim cost per payer?
9. How many unique patients were admitted each quarter over time?
10. How many patients were readmitted within 30 days?
11. Which patients had the most readmissions?

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

## Key Findings & Insights

### 1. Encounter Trends Over Time  
Across the dataset, there were **27,891 total encounters** between 2011 and 2022. Volumes grew steadily from 2011 (1,336 encounters) to a peak in 2014 (3,885), followed by small fluctuations in subsequent years. There was another spike in 2021 (3,530), but 2022 shows a sharp drop (220), which is likely due to incomplete data rather than a real decline.  

This trend highlights how patient volumes have changed over time and can help identify periods of higher demand, which is valuable for staffing and capacity planning.

---

### 2. Encounter Class Distribution  
Ambulatory visits consistently made up the largest share of encounters each year, averaging around **45–60%** of total visits. Outpatient care followed at **17–24%**, while wellness visits ranged from **4–13%**. Urgent care and emergency visits remained smaller but stable portions of total encounters, and inpatient stays were consistently the lowest (<7%).  

This breakdown shows that most encounters are lower-acuity and outpatient-focused, which suggests opportunities to optimize resources around those services rather than inpatient capacity.

---

### 3. Encounter Duration  
Most encounters were short-term. About **95.9%** lasted less than 24 hours, while only **4.1%** extended beyond that. This reinforces that the majority of care episodes are resolved quickly and do not require long hospital stays.

---

### 4. Coverage Gaps  
Nearly **48.7% of all encounters (13,586)** had zero payer coverage, meaning almost half of the care provided was not billed to or paid by any insurer. This is a critical area for improvement — better insurance verification, patient intake processes, and financial counseling could significantly reduce uncompensated care and improve revenue capture.

---

### 5. Encounters with Zero Payer Coverage by Payer  
The largest share of uncovered encounters came from patients with **no insurance at all — 8,807 cases**, which is a major driver of uncompensated care. Among insured patients, **Humana (1,038)**, **Aetna (898)**, and **UnitedHealthcare (820)** accounted for the most uncovered encounters, suggesting possible issues with claim submission, eligibility verification, or coverage lapses.  

Government programs like **Medicare (61)** and **Medicaid (5)** were rarely involved in uncovered encounters, indicating that those billing processes are more reliable. Overall, the data points to two priorities: improving how uninsured patients are identified and counseled on payment options, and reviewing billing workflows with commercial payers to reduce missed claims.

---

### 6. Cost Insights by Payer  
Average claim costs varied widely across payers. **Medicaid ($6,205)** and **No Insurance ($5,593)** had the highest average costs, followed by private insurers such as **Anthem ($4,236)** and **Humana ($3,269)**. **Medicare ($2,167)** and **Dual Eligible ($1,696)** had the lowest average costs.  

This variation shows how payer mix can significantly impact revenue and cost recovery, and it suggests that patient population characteristics and coverage types should be factored into budgeting and forecasting.

---

### 7. Procedures: Volume vs. Cost  
The most frequently performed procedures were routine assessments such as **health and social care needs assessments, hospice care, and depression screening**, each with thousands of occurrences but relatively low average base costs (around $431–$1,004).  

On the other hand, the most expensive procedures — including **ICU admission, coronary bypass grafting, and breast lumpectomy** — were performed less often but had significantly higher costs, ranging from about $19,000 to over $206,000. This contrast shows how a small number of high-cost procedures can account for a large portion of total spending.

---

### 8. Patient Behavior and Readmissions  
A total of **773 patients** were readmitted, and a small group accounted for the majority of readmissions. One patient, for example, was readmitted **1,376 times**. Many patients were also readmitted within 30 days of a previous encounter, which suggests potential issues with discharge planning, follow-up care, or chronic condition management.  

Focusing care coordination efforts on high-utilizer patients could significantly reduce readmissions and improve overall patient outcomes.

---

### 9. Patient Flow Over Time  
Quarterly admissions ranged between **150 and 400+** patients, with noticeable peaks in Q1 2014 (394) and Q1 2021 (417). The data shows a generally increasing trend over time with some seasonal variation, which can help hospitals better plan for patient demand throughout the year.


---

## Strategic Takeaways

- Revenue Optimization: With nearly half of encounters uncovered by payers, expanding insurance verification and billing workflows could significantly increase revenue.
- Cost Control: Targeting high-cost procedures and improving pre- and post-care coordination can reduce expenses.
- Readmission Reduction: Focused care programs for the small percentage of high-utilization patients could substantially lower readmissions and improve outcomes.
- Capacity Planning: The dominance of short-term encounters and the rise in ambulatory and outpatient visits suggests shifting resources away from inpatient capacity toward more flexible, outpatient-oriented care models.

---

## How to Use This Repository

1. Explore the Queries:  
   Review all SQL queries in [sql/queries_and_results.md](./sql/queries_and_results.md) or [sql/queries.sql](./sql/queries.sql).

2. View Results:  
   Each query is accompanied by screenshots of the output for visual context in the `query_images/` folder.

## Author

**Rodrigo Hurtado**  
Miami, FL  
[GitHub Profile](https://github.com/RodHC)  
Data Analytics | SQL | Business Intelligence |

---
