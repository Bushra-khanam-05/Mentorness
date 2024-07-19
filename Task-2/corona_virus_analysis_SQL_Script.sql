use coronavirus;

DESCRIBE corona_virus;

SET SQL_SAFE_UPDATES = 0;

UPDATE corona_virus
SET Date = STR_TO_DATE(Date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;

-- Q1. Write a code to check NULL values
SELECT 
    SUM(CASE WHEN Province IS NULL THEN 1 ELSE 0 END) AS Province_Null_Count,
    SUM(CASE WHEN `Country/Region` IS NULL THEN 1 ELSE 0 END) AS CountryRegion_Null_Count,
    SUM(CASE WHEN Latitude IS NULL THEN 1 ELSE 0 END) AS Latitude_Null_Count,
    SUM(CASE WHEN Longitude IS NULL THEN 1 ELSE 0 END) AS Longitude_Null_Count,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Date_Null_Count,
    SUM(CASE WHEN Confirmed IS NULL THEN 1 ELSE 0 END) AS Confirmed_Null_Count,
    SUM(CASE WHEN Deaths IS NULL THEN 1 ELSE 0 END) AS Deaths_Null_Count,
    SUM(CASE WHEN Recovered IS NULL THEN 1 ELSE 0 END) AS Recovered_Null_Count
FROM corona_virus;

-- Q2. If NULL values are present, update them with zeros for all columns.
-- NO NULL VALUES ARE FOUND 

-- Q3. Check total number of rows
SELECT COUNT(*) AS Total_Rows FROM corona_virus;

-- Q4. Check what is start_date and end_date
SELECT 
    MIN(Date) AS Start_Date, 
    MAX(Date) AS End_Date 
FROM corona_virus;

-- Q5. Number of months present in the dataset
SELECT COUNT(DISTINCT DATE_FORMAT(Date, '%Y-%m')) AS Total_Months 
FROM corona_virus;


-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month, 
    AVG(Confirmed) AS Avg_Confirmed, 
    AVG(Deaths) AS Avg_Deaths, 
    AVG(Recovered) AS Avg_Recovered 
FROM corona_virus
GROUP BY Month
ORDER BY Month;

-- Q7. Find most frequent value for confirmed, deaths, recovered each month
WITH MonthlyData AS (
    SELECT 
        DATE_FORMAT(Date, '%Y-%m') AS Month, 
        Confirmed, 
        Deaths, 
        Recovered 
    FROM corona_virus
), CountData AS (
    SELECT 
        Month, 
        Confirmed, 
        Deaths, 
        Recovered,
        COUNT(*) AS Frequency
    FROM MonthlyData
    GROUP BY Month, Confirmed, Deaths, Recovered
), RankedData AS (
    SELECT 
        Month, 
        Confirmed, 
        Deaths, 
        Recovered,
        Frequency,
        ROW_NUMBER() OVER (PARTITION BY Month ORDER BY Frequency DESC) AS `Rank`
    FROM CountData
)
SELECT 
    Month,
    Confirmed AS Most_Frequent_Confirmed,
    Deaths AS Most_Frequent_Deaths,
    Recovered AS Most_Frequent_Recovered
FROM RankedData
WHERE `Rank` = 1;

-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS Year, 
    MIN(Confirmed) AS Min_Confirmed, 
    MIN(Deaths) AS Min_Deaths, 
    MIN(Recovered) AS Min_Recovered 
FROM corona_virus
GROUP BY Year
ORDER BY Year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS Year, 
    MAX(Confirmed) AS Max_Confirmed, 
    MAX(Deaths) AS Max_Deaths, 
    MAX(Recovered) AS Max_Recovered 
FROM corona_virus
GROUP BY Year
ORDER BY Year;

-- Q10. The total number of cases of confirmed, deaths, recovered each month
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month, 
    SUM(Confirmed) AS Total_Confirmed, 
    SUM(Deaths) AS Total_Deaths, 
    SUM(Recovered) AS Total_Recovered 
FROM corona_virus
GROUP BY Month
ORDER BY Month;

-- Q11. Check how coronavirus spread out with respect to confirmed case
SELECT 
    SUM(Confirmed) AS Total_Confirmed, 
    AVG(Confirmed) AS Avg_Confirmed, 
    VARIANCE(Confirmed) AS Var_Confirmed, 
    STDDEV(Confirmed) AS Stddev_Confirmed 
FROM corona_virus;

-- Q12. Check how coronavirus spread out with respect to death cases per month
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month, 
    SUM(Deaths) AS Total_Deaths, 
    AVG(Deaths) AS Avg_Deaths, 
    VARIANCE(Deaths) AS Var_Deaths, 
    STDDEV(Deaths) AS Stddev_Deaths 
FROM corona_virus
GROUP BY Month
ORDER BY Month;

-- Q13. Check how coronavirus spread out with respect to recovered cases
SELECT 
    SUM(Recovered) AS Total_Recovered, 
    AVG(Recovered) AS Avg_Recovered, 
    VARIANCE(Recovered) AS Var_Recovered, 
    STDDEV(Recovered) AS Stddev_Recovered 
FROM corona_virus;

-- Q14. Find the country having the highest number of confirmed cases
SELECT 
    `Country/Region`, 
    SUM(Confirmed) AS Total_Confirmed 
FROM corona_virus
GROUP BY `Country/Region`
ORDER BY Total_Confirmed DESC
LIMIT 1;

-- Q15. Find the country having the lowest number of death cases
SELECT 
    `Country/Region`, 
    SUM(Deaths) AS Total_Deaths 
FROM corona_virus
GROUP BY `Country/Region`
ORDER BY Total_Deaths ASC
LIMIT 1;

-- Q16. Find the top 5 countries having the highest recovered cases

SELECT 
    `Country/Region`, 
    SUM(Recovered) AS Total_Recovered 
FROM corona_virus
GROUP BY `Country/Region`
ORDER BY Total_Recovered DESC
LIMIT 5;


























































































