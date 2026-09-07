use tata_stock_db

SELECT * FROM tata_motors_stock LIMIT 10;

SELECT
    Date,
    Close,
    LAG(Close) OVER (ORDER BY Date) AS Previous_Close,
    ROUND(((Close - LAG(Close) OVER (ORDER BY Date)) / LAG(Close) OVER (ORDER BY Date)) * 100, 2) AS Daily_Return_Pct
FROM tata_motors_stock
ORDER BY Date
LIMIT 20;
--                 


SELECT
    Date,
    Close,
    ROUND(AVG(Close) OVER (ORDER BY Date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS Moving_Avg_7Day
FROM tata_motors_stock
ORDER BY Date
LIMIT 20;
--


SELECT
    Date,
    Close,
    ROUND(AVG(Close) OVER (ORDER BY Date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW), 2) AS Moving_Avg_30Day
FROM tata_motors_stock
ORDER BY Date
LIMIT 20;
--


SELECT Date, Close,
    ROUND(((Close - LAG(Close) OVER (ORDER BY Date)) / LAG(Close) OVER (ORDER BY Date)) * 100, 2) AS Daily_Return_Pct
FROM tata_motors_stock
ORDER BY Daily_Return_Pct DESC
LIMIT 5;
-- 

SELECT Date, Close,
    ROUND(((Close - LAG(Close) OVER (ORDER BY Date)) / LAG(Close) OVER (ORDER BY Date)) * 100, 2) AS Daily_Return_Pct
FROM tata_motors_stock
ORDER BY Daily_Return_Pct ASC
LIMIT 5;


SELECT
    MIN(Date) AS Start_Date,
    MAX(Date) AS End_Date,
    (SELECT Close FROM tata_motors_stock ORDER BY Date ASC LIMIT 1) AS First_Close,
    (SELECT Close FROM tata_motors_stock ORDER BY Date DESC LIMIT 1) AS Last_Close,
    ROUND((((SELECT Close FROM tata_motors_stock ORDER BY Date DESC LIMIT 1) - (SELECT Close FROM tata_motors_stock ORDER BY Date ASC LIMIT 1)) / (SELECT Close FROM tata_motors_stock ORDER BY Date ASC LIMIT 1)) * 100, 1) AS Total_Growth_Pct
FROM tata_motors_stock;

SELECT
    YEAR(Date) AS Year,
    ROUND(AVG(Close), 2) AS Avg_Close,
    ROUND(AVG(Volume), 0) AS Avg_Volume
FROM tata_motors_stock
GROUP BY YEAR(Date)
ORDER BY Year;

SELECT Date, Close,
    ROUND(((Close - LAG(Close) OVER (ORDER BY Date)) / LAG(Close) OVER (ORDER BY Date)) * 100, 2) AS Daily_Return_Pct
FROM tata_motors_stock
WHERE Close IS NOT NULL
ORDER BY Daily_Return_Pct ASC
LIMIT 5;

SELECT COUNT(*) AS Missing_Close_Count
FROM tata_motors_stock
WHERE Close IS NULL;

SELECT Date, Close, Volume,
    ROUND(((Close - LAG(Close) OVER (ORDER BY Date)) / LAG(Close) OVER (ORDER BY Date)) * 100, 2) AS Daily_Return_Pct
FROM tata_motors_stock
WHERE Close IS NOT NULL
ORDER BY Volume DESC
LIMIT 10;

SELECT
    MIN(Date) AS Start_Date,
    MAX(Date) AS End_Date,
    (SELECT Close FROM tata_motors_stock WHERE Close IS NOT NULL ORDER BY Date ASC LIMIT 1) AS First_Close,
    (SELECT Close FROM tata_motors_stock WHERE Close IS NOT NULL ORDER BY Date DESC LIMIT 1) AS Last_Close,
    ROUND((((SELECT Close FROM tata_motors_stock WHERE Close IS NOT NULL ORDER BY Date DESC LIMIT 1) - (SELECT Close FROM tata_motors_stock WHERE Close IS NOT NULL ORDER BY Date ASC LIMIT 1)) / (SELECT Close FROM tata_motors_stock WHERE Close IS NOT NULL ORDER BY Date ASC LIMIT 1)) * 100, 1) AS Total_Growth_Pct
FROM tata_motors_stock;

SELECT
    YEAR(Date) AS Year,
    ROUND(AVG(Close), 2) AS Avg_Close,
    ROUND(AVG(Volume), 0) AS Avg_Volume
FROM tata_motors_stock
WHERE Close IS NOT NULL
GROUP BY YEAR(Date)
ORDER BY Year;

