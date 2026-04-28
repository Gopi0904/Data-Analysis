-- Create Database
create database ChurnAnalysis;

use ChurnAnalysis;
-- Create Table
CREATE TABLE CustomerSubscriptions (
    CustomerID VARCHAR(10),
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    SubscriptionType VARCHAR(20),
    SubscriptionDate DATE,
    LastLoginDate DATE,
    TotalSessions INT,
    FeedbackScore INT,
    IsChurned INT
);

-- =========================================
-- 1. Active vs Churned Customers by SubscriptionType
SELECT 
    SubscriptionType,
    IsChurned,
    COUNT(*) AS TotalCustomers
FROM CustomerSubscriptions
GROUP BY SubscriptionType, IsChurned;

-- =========================================
-- 2. Average FeedbackScore by SubscriptionType and Gender
SELECT 
    SubscriptionType,
    Gender,
    AVG(FeedbackScore) AS AvgFeedback
FROM CustomerSubscriptions
GROUP BY SubscriptionType, Gender;

-- =========================================
-- 3. Customers with <5 sessions AND feedback <5
SELECT *
FROM CustomerSubscriptions
WHERE TotalSessions < 5 AND FeedbackScore < 5;

-- =========================================
-- 4. Customers not logged in for 60 days
SELECT *
FROM CustomerSubscriptions
WHERE LastLoginDate < DATE_SUB(CURDATE(), INTERVAL 60 DAY);

-- (For SQL Server use this instead)
-- WHERE LastLoginDate < DATEADD(DAY, -60, GETDATE());

-- =========================================
-- 5. Churn Rate by SubscriptionType
SELECT 
    SubscriptionType,
    COUNT(*) AS TotalCustomers,
    SUM(IsChurned) AS ChurnedCustomers,
    (SUM(IsChurned) * 100.0 / COUNT(*)) AS ChurnRate
FROM CustomerSubscriptions
GROUP BY SubscriptionType;

-- =========================================
-- 6. Top 10 longest subscriptions
SELECT *
FROM CustomerSubscriptions
ORDER BY SubscriptionDate ASC
LIMIT 10;

-- =========================================
-- 7. Age Group-wise Churn Analysis
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '46+'
    END AS AgeGroup,
    COUNT(*) AS TotalCustomers,
    SUM(IsChurned) AS Churned,
    (SUM(IsChurned) * 100.0 / COUNT(*)) AS ChurnRate
FROM CustomerSubscriptions
GROUP BY AgeGroup;