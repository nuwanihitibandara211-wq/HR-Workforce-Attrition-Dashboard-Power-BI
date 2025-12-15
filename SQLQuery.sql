SELECT*FROM [HR Data]

ALTER TABLE [HR Data]
DROP COLUMN[Over18],[Standard_Hours], [Employee_Count];

EXEC sp_rename '[HR Data].[emp_no]', 'EmployeeID', 'COLUMN';
EXEC sp_rename '[HR Data].[CF_age_band]', 'Age_Group', 'COLUMN';

CREATE VIEW v_HR_Dashboard_Source AS
SELECT 
    EmployeeID,
    CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END AS Attrition_Flag,
    Attrition,
    Department,
    Job_Role,
    Gender,
    Age,
    Age_Group,
    Monthly_Income,
    Job_Satisfaction,
    Years_At_Company
FROM [HR Data];

SELECT*FROM v_HR_Dashboard_Source

SELECT COUNT(*) AS [Total Employees] FROM v_HR_Dashboard_Source

SELECT SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS [Attrition Count] FROM v_HR_Dashboard_Source

SELECT CAST(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) 
    / CAST(COUNT(*) AS FLOAT) AS [Attrition Rate] FROM v_HR_Dashboard_Source

SELECT COUNT(*) - SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS [Active Employees] FROM v_HR_Dashboard_Source

SELECT AVG(Age) AS [Avg Age] FROM v_HR_Dashboard_Source

SELECT AVG([Monthly_Income]) AS [Avg Salary] FROM v_HR_Dashboard_Source

SELECT AVG([Job_Satisfaction]) AS [Avg Job Satisfaction] FROM v_HR_Dashboard_Source