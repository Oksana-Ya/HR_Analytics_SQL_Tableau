#  HR Employee Attrition Analysis (SQL Project)

This project explores employee attrition patterns using SQL within pgAdmin 4, leveraging a structured HR dataset to identify trends across departments, roles, tenure, and employee satisfaction.



---

## Dataset

- Source: [Oksana-Ya/SQLProject_HR_Analytics](https://github.com/Oksana-Ya/SQLProject_HR_Analytics/blob/main/WA_Fn-UseC_-HR-Employee-Attrition.csv)
- Data includes demographics, job roles, compensation, satisfaction scores, and attrition status.

---

## ⚙️ Setup

1. Install PostgreSQL and pgAdmin 4.
2. Clone the repository and download the dataset.
3. Load the data into pgAdmin 4 by executing the following SQL in the Query Tool:

```sql
COPY hr_data
FROM '/absolute/path/to/WA_Fn-UseC_-HR-Employee-Attrition.csv'
DELIMITER ','
CSV HEADER;
```

Replace /absolute/path/to/... with the actual path to the file on your machine.

4. All SQL queries and analysis were performed directly in pgAdmin 4 using the built-in query editor.

5. Run analysis scripts from hr_attrition_analysis.sql inside pgAdmin 4.



## Key Analyses

- Overall attrition rate
- Attrition by department and job role
- Tenure impact on attrition
- Satisfaction and work-life balance analysis
- Top 5 roles with highest attrition
- Most common education field among high earners

## SQL Features Used

- CASE WHEN for conditional aggregation
- WITH (CTEs) for modular queries
- ROW_NUMBER() for ranking
- PERCENTILE_CONT() for income analysis
