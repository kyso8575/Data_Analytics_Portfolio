/* 
 * Employee Satisfaction Data Exploration
 * Platform Used: Mysql
 */


-- 1. Check the dataset that we are going to use
SELECT * FROM satisfaction_data;


-- 2. Demographics Anlaysis

-- Gender Distribution

SELECT gender, Count(*)
FROM satisfaction_data
GROUP BY gender;

-- Position Distribution
SELECT position, Count(*)
FROM satisfaction_data
GROUP BY POSITION ;

-- Department Distribution

Select Department, Count(*) 
From satisfaction_data sd 
Group by Department
Order by COUNT(*) desc;

-- Age distribution

SELECT 
    CASE
        WHEN Age BETWEEN 20 AND 29 THEN '20s'
        WHEN Age BETWEEN 30 AND 39 THEN '30s'
        WHEN Age BETWEEN 40 AND 49 THEN '40s'
        WHEN Age BETWEEN 50 AND 59 THEN '50s'
        else '60s'
        -- Add additional age groups as needed
    END AS AgeGroup,
    COUNT(*) AS Total
FROM satisfaction_data 
GROUP BY AgeGroup
ORDER BY AgeGroup;


-- 3.Satisfaction Analysis

-- Average Satisfaction score by Deaprtment

SELECT 
    Department, 
    AVG(`Satisfaction Rate (%)`) AS AvgSatisfactionRate,
    RANK() OVER (ORDER BY AVG(`Satisfaction Rate (%)`) DESC) `Rank`
FROM satisfaction_data sd
GROUP BY Department
ORDER BY  'Rank';

-- Average Satisfaction Score by Position
SELECT 
    Position, 
    AVG(`Satisfaction Rate (%)`) AS AvgSatisfactionRate,
    RANK() OVER (ORDER BY AVG(`Satisfaction Rate (%)`) DESC) `Rank`
FROM satisfaction_data sd
GROUP BY Position
ORDER BY  'Rank';

-- Average Satisfaction Score by Joining Year

SELECT 
    CASE 
        WHEN CAST(RIGHT(`Joining Date`, 2) AS UNSIGNED) BETWEEN 0 AND 10 THEN '2000 ~ 2010'
        WHEN CAST(RIGHT(`Joining Date`, 2) AS UNSIGNED) BETWEEN 11 AND 20 THEN '2011 ~ 2020'
        WHEN CAST(RIGHT(`Joining Date`, 2) AS UNSIGNED) BETWEEN 21 AND 29 THEN 'After 2020'
        ELSE 'Before 2000'
    END as `Joining Year`,
    AVG(`Satisfaction Rate (%)`) AS AvgSatisfactionRate
FROM 
    satisfaction_data
GROUP BY
    `Joining Year`
ORDER BY
    CASE `Joining Year`
        WHEN 'Before 2000' THEN 1
        WHEN '2000 ~ 2010' THEN 2
        WHEN '2011 ~ 2020' THEN 3
        WHEN 'After 2020' THEN 4
    END;
   
   
 -- 4. Salary Anlaysis
   
 -- Salary VS Satifaction score
   
  SELECT 
    CASE
        WHEN `Satisfaction rate (%)` BETWEEN 0 AND 25 THEN '0 ~ 25'
        WHEN `Satisfaction rate (%)` BETWEEN 6 AND 50 THEN '26 ~ 50'
        WHEN `Satisfaction rate (%)` BETWEEN 51 AND 75 THEN '51 ~ 75'
        WHEN `Satisfaction rate (%)` BETWEEN 76 AND 100 THEN '76 ~ 100'
        else 'None'
        -- Add additional age groups as needed
    END as `Satisfaction Rate`,
    ROUND(AVG(Salary))  AS Salary
FROM satisfaction_data 
GROUP BY `Satisfaction Rate`
ORDER BY `Satisfaction Rate`;


   
  -- Salary VS Productivity

  SELECT 
    CASE
        WHEN `Productivity (%)` BETWEEN 0 AND 25 THEN '0 ~ 25'
        WHEN `Productivity (%)` BETWEEN 6 AND 50 THEN '26 ~ 50'
        WHEN `Productivity (%)` BETWEEN 51 AND 75 THEN '51 ~ 75'
        WHEN `Productivity (%)` BETWEEN 76 AND 100 THEN '76 ~ 100'
        else 'None'
        -- Add additional age groups as needed
    END as `Satisfaction Rate`,
    ROUND(AVG(Salary))  AS Salary
FROM satisfaction_data 
GROUP BY `Satisfaction Rate`
ORDER BY `Satisfaction Rate`;

   
