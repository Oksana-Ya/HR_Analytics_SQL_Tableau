# HR Employee Attrition Analysis (SQL Project)

This project explores employee attrition trends using SQL and a structured HR dataset. It helps uncover patterns in departments, roles, and employee satisfaction that influence turnover.

---

## Dataset

- Source: [Oksana-Ya/SQLProject_HR_Analytics](https://github.com/Oksana-Ya/SQLProject_HR_Analytics/blob/main/WA_Fn-UseC_-HR-Employee-Attrition.csv)
- Data includes demographics, job roles, compensation, satisfaction scores, and attrition status.

---

## Setup

1. Install PostgreSQL.
2. Clone this repo and download the dataset.
3. Load data with:

```sql
COPY hr_data
FROM '/absolute/path/to/WA_Fn-UseC_-HR-Employee-Attrition.csv'
DELIMITER ','
CSV HEADER;

4. Run the queries in hr_attrition_analysis.sql



__Key Analyses__

Overall attrition rate

Attrition by department and job role

Tenure impact on attrition

Satisfaction and work-life balance analysis

Top 5 roles with highest attrition

Most common education field among high earners


** SQL Features Used **
CASE WHEN for conditional aggregation

WITH (CTEs) for modular queries

ROW_NUMBER() for ranking

PERCENTILE_CONT() for income analysis


