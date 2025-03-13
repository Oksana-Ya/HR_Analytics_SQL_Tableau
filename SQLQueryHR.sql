--Show amount of employees based on their marital status grouped by gender
WITH MaritalStatusGenderCount AS (
    SELECT
        MaritalStatus, Gender, COUNT(*) AS number
    FROM hr.dbo.hr_data
    GROUP BY
        MaritalStatus, Gender
)
SELECT MaritalStatus, Gender, number
FROM MaritalStatusGenderCount
ORDER BY number DESC;


--Count of Employees by Attrition and show total number of all employees
WITH AttritionCounts AS (
    SELECT COUNT(*) AS Attrition_number
    FROM hr.dbo.hr_data
    WHERE Attrition = 'Yes'
)
SELECT 'Attrition' AS Category, Attrition_number AS Count
FROM AttritionCounts

UNION ALL

SELECT 'ActiveEmployees' AS Category,
    (SELECT COUNT(*) FROM hr.dbo.hr_data) - Attrition_number AS Count
FROM AttritionCounts

UNION ALL

SELECT 'Total' AS Category, COUNT(*) AS Count
FROM hr.dbo.hr_data;


--Calculate average age of all employees
SELECT AVG(Age) AS AverageAge
FROM hr.dbo.hr_data

--Calculate attrition by each department
SELECT Department,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees
FROM hr.dbo.hr_data
GROUP BY Department
ORDER BY AttritionCount DESC

--Count attrition by salary range
SELECT
    CASE
        WHEN MonthlyIncome <= 3000 THEN 'Low'
        WHEN MonthlyIncome <= 6000 THEN 'Medium'
        ELSE 'High'
    END AS SalaryRange,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees
FROM hr.dbo.hr_data
GROUP BY
    CASE
        WHEN MonthlyIncome <= 3000 THEN 'Low'
        WHEN MonthlyIncome <= 6000 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY AttritionCount DESC




--Active employee count by department:
SELECT Department, COUNT(*) AS Count
FROM hr.dbo.hr_data
WHERE Attrition = 'No'
GROUP BY Department

--Average Years at Company by Job Role
SELECT JobRole, ROUND(AVG(YearsAtCompany), 2) AS AvgYearsAtCompany
FROM hr.dbo.hr_data
GROUP BY JobRole
ORDER BY AvgYearsAtCompany DESC


--Find Employee with the highest salary
SELECT EmployeeNumber, Department, JobRole, MonthlyIncome
FROM hr.dbo.hr_data
WHERE MonthlyIncome = (SELECT MAX(MonthlyIncome) FROM hr.dbo.hr_data);

--Count of Employees by Marital Status and Gender
SELECT MaritalStatus, Gender, COUNT(*) AS Count
FROM hr.dbo.hr_data
GROUP BY MaritalStatus, Gender;

--Analyze the average salary based on education level and education field
SELECT Education, EducationField, AVG(MonthlyIncome) AS AvgMonthlySalary
FROM hr.dbo.hr_data
GROUP BY Education, EducationField
ORDER BY AvgMonthlySalary DESC

--Calculates the average age of employees in each job role
SELECT JobRole, AVG(Age) AS AvgAge
FROM hr.dbo.hr_data
GROUP BY JobRole
ORDER BY AvgAge Desc



--Show only those employees whose monthly salary is higher than the average salary for their job role
SELECT EmployeeNumber, JobRole, MonthlyIncome, AvgSalaryByJobRole
FROM (
    SELECT EmployeeNumber, JobRole, MonthlyIncome, AVG(MonthlyIncome) OVER (PARTITION BY JobRole) AS AvgSalaryByJobRole
    FROM hr.dbo.hr_data
)  AS income
WHERE MonthlyIncome >= AvgSalaryByJobRole
ORDER BY AvgSalaryByJobRole DESC, MonthlyIncome DESC

--Show top 5 employees who work at the company the longest period of time
SELECT TOP(5) EmployeeNumber, JobRole, MonthlyIncome, YearsAtCompany
FROM hr.dbo.hr_data
ORDER BY YearsAtCompany DESC


--Show employees who got salary increase by 20 and more %
SELECT EmployeeNumber, JobRole, PercentSalaryHike
FROM hr.dbo.hr_data
WHERE EmployeeNumber IN (
	SELECT EmployeeNumber 
	FROM hr.dbo.hr_data 
	WHERE PercentSalaryHike>=20)
ORDER BY PercentSalaryHike DESC








