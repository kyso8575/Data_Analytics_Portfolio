/*
 * World Happiness Score Data Analysis
 * Platfrom Used: Mysql
 */


-- 1. Dataset Overview and Participation

-- Check Dataset for analysis

SELECT * FROM happiness_data hd;


-- Number of participated countries

SELECT COUNT(DISTINCT `癤�Country name`) as `Number of Countries`
FROM  happiness_data hd;


-- Numer of participation by year

SELECT `year` , COUNT(*) 
FROM happiness_data hd 
GROUP BY `year`
order by COUNT(*) desc;


-- Most participated countries

SELECT `癤�Country name`  as Country, COUNT(*) as ParticipationCount
FROM happiness_data
GROUP BY `癤�Country name` 
HAVING COUNT(*) = (
  SELECT MAX(ParticipationCount) FROM (
    SELECT COUNT(*) as ParticipationCount
    FROM happiness_data
    GROUP BY `癤�Country name`
  ) as SubQuery
)
ORDER BY COUNT(*) DESC;

-- 2. Analysis on Happiness Score and other related variables

-- TOp 10 Happiest Countries

SELECT `癤�Country name` as Country , AVG(`Life Ladder`) as `Life Ladder`
FROM happiness_data hd 
GROUP BY `癤�Country name` 
ORDER BY AVG(`Life Ladder`) desc
LIMIT 10;

-- Happiness Score by Year

SELECT `year`, ROUND(AVG(`Life Ladder`),2)
FROM happiness_data hd 
GROUP BY `year`
ORDER BY `year`;

-- Top 10 Countires with highest social support

SELECT `癤�Country name` as Country, AVG(`Social support`) as `Social Support`
FROM happiness_data hd 
GROUP BY `癤�Country name` 
ORDER BY AVG(`Social support`) desc
LIMIT 10;

-- Top 10 Countires with most freedom to make choices

SELECT `癤�Country name` as Country, AVG(`Freedom to make life choices`) as `Freedom of choice`
FROM happiness_data hd 
GROUP BY `癤�Country name` 
ORDER BY AVG(`Freedom to make life choices`) desc
LIMIT 10;



-- 3. Analysis on Affect of Happiness on Countries

-- Top 10 Countries with highest positive affect

SELECT `癤�Country name` as Country, AVG(`Positive affect`) as `Positive Affect`
FROM happiness_data hd 
GROUP BY `癤�Country name` 
ORDER BY AVG(`Positive affect`) desc
LIMIT  10;


-- Top 10 Countries with highest negative affect

SELECT `癤�Country name` as Country, AVG(`Negative affect`) as `Negative Affect`
FROM happiness_data hd 
GROUP BY `癤�Country name` 
ORDER BY AVG(`Negative affect`) desc
LIMIT 10;


-- Top 10 Countries by Total Affect (Positive Affect - Negative Affect)

SELECT `癤�Country name` as Country, AVG(`Positive affect`) - AVG(`Negative affect`) as `Total`
FROM happiness_data hd 
GROUP BY `癤�Country name` 
ORDER BY AVG(`Positive Affect`) - AVG(`Negative affect`) desc
LIMIT 10;


-- 4. Relationship Between Happiness and Other variables

-- Happiness vs Social Support

SELECT 
    CASE 
        WHEN `Social Support` BETWEEN 0.25 AND 0.5 THEN '0.25 ~ 0.5'
        WHEN `Social Support` BETWEEN 0.5 AND 0.75 THEN '0.5 ~ 0.75'
        WHEN `Social Support` BETWEEN 0.75 AND 1 THEN '0.75 ~ 1'
    END as `Social Support Range`,
    AVG(`Life Ladder`) as `Average Life Ladder`
FROM happiness_data hd 
WHERE `Social support` IS NOT NULL
GROUP BY `Social Support Range`
ORDER BY `Social Support Range`


-- Happiness vs Freedom

SELECT 
    CASE 
        WHEN `Freedom to make life choices`  BETWEEN 0.25 AND 0.5 THEN '0.25 ~ 0.5'
        WHEN `Freedom to make life choices`  BETWEEN 0.5 AND 0.75 THEN '0.5 ~ 0.75'
        WHEN `Freedom to make life choices`  BETWEEN 0.75 AND 1 THEN '0.75 ~ 1'
    END as `Freedom to make life choices range`,
    AVG(`Life Ladder`) as `Average Life Ladder`
FROM happiness_data hd 
WHERE `Freedom to make life choices` IS NOT NULL
GROUP BY `Freedom to make life choices range`
ORDER BY `Freedom to make life choices range`


