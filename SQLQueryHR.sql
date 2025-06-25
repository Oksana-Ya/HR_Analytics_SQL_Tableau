DROP TABLE IF EXISTS hr_data;

CREATE TABLE hr_data (
    age INTEGER,
    attrition VARCHAR(10),
    business_travel VARCHAR(50),
    daily_rate INTEGER,
    department VARCHAR(50),
    distance_from_home INTEGER,
    education INTEGER,
    education_field VARCHAR(50),
    employee_count INTEGER,
    employee_number INTEGER PRIMARY KEY,
    environment_satisfaction INTEGER,
    gender VARCHAR(10),
    hourly_rate INTEGER,
    job_involvement INTEGER,
    job_level INTEGER,
    job_role VARCHAR(50),
    job_satisfaction INTEGER,
    marital_status VARCHAR(20),
    monthly_income INTEGER,
    monthly_rate INTEGER,
    num_companies_worked INTEGER,
    over_18 VARCHAR(2),
    overtime VARCHAR(5),
    percent_salary_hike INTEGER,
    performance_rating INTEGER,
    relationship_satisfaction INTEGER,
    standard_hours INTEGER,
    stock_option_level INTEGER,
    total_working_years INTEGER,
    training_times_last_year INTEGER,
    work_life_balance INTEGER,
    years_at_company INTEGER,
    years_in_current_role INTEGER,
    years_since_last_promotion INTEGER,
    years_with_curr_manager INTEGER
);



-- Load data into the hr_data table from a CSV file
-- The file must be accessible to the PostgreSQL server (on the server's filesystem)

COPY hr_data
FROM '/path/to/your/data/WA_Fn-UseC_-HR-Employee-Attrition.csv'  -- Replace this with the actual absolute path to your CSV file
DELIMITER ','        -- Use comma as the field delimiter (standard for CSV)
CSV HEADER;          -- The first row contains column names, so skip it during import







-- 1. Overall Attrition Rate
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM hr_data;

-- 2. Attrition by Department
SELECT 
    department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY department
ORDER BY attrition_rate DESC;

-- 3. Attrition by Job Role
SELECT 
    job_role,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY job_role
ORDER BY attrition_rate DESC;



-- 4. Years at Company vs. Attrition
SELECT 
    years_at_company,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY years_at_company
ORDER BY years_at_company;

-- 5. Total Working Years vs. Attrition
SELECT 
    total_working_years,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY total_working_years
ORDER BY total_working_years;



-- 6. Job Satisfaction vs. Attrition
SELECT 
    job_satisfaction,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY job_satisfaction;

-- 7. Environment Satisfaction vs. Attrition
SELECT 
    environment_satisfaction,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY environment_satisfaction;

-- 8. Work-Life Balance vs. Attrition
SELECT 
    work_life_balance,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY work_life_balance;

-- 9. Top 5 Job Roles with Highest Attrition Rate
WITH job_attrition AS (
    SELECT 
        job_role,
        COUNT(*) AS total,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left,
        ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
    FROM hr_data
    GROUP BY job_role
)
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY attrition_rate DESC) AS rank
    FROM job_attrition
) ranked
WHERE rank <= 5;



-- 10.  Average Years at Company by Department for Employees Who Left
WITH left_employees AS (
    SELECT department, years_at_company
    FROM hr_data
    WHERE attrition = 'Yes'
)
SELECT 
    department,
    ROUND(AVG(years_at_company), 2) AS avg_years_before_leaving
FROM left_employees
GROUP BY department
ORDER BY avg_years_before_leaving DESC;

-- 11. Most Common Education Field Among High Earners
SELECT education_field, COUNT(*) AS count
FROM hr_data
WHERE monthly_income > (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY monthly_income)
    FROM hr_data
)
GROUP BY education_field
ORDER BY count DESC
LIMIT 1;
