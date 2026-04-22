SELECT
    Region,
    SUM(TotalAmount) AS TotalSales
FROM RetailTransactions
WHERE Date >= DATE_SUB('2023-12-31', INTERVAL 3 MONTH)
GROUP BY Region;

SELECT
    ProductName,
    SUM(TotalAmount) AS TotalRevenue
FROM RetailTransactions
GROUP BY ProductName
ORDER BY TotalRevenue DESC
LIMIT 5;

SELECT
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(TotalAmount) AS MonthlySales
FROM RetailTransactions
GROUP BY Month
ORDER BY Month;

SELECT
    Region,
    ROUND(
        (SUM(TotalAmount) / (SELECT SUM(TotalAmount) FROM RetailTransactions)) * 100,
        2
    ) AS ContributionPercentage
FROM RetailTransactions
GROUP BY Region;

SELECT
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SalesChannel,
    SUM(TotalAmount) AS ChannelSales
FROM RetailTransactions
GROUP BY Month, SalesChannel
ORDER BY Month;

SELECT
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    Category,
    SUM(TotalAmount) AS CategorySales
FROM RetailTransactions
GROUP BY Month, Category
ORDER BY Category, Month;

SELECT
    CustomerID,
    COUNT(TransactionID) AS PurchaseCount
FROM RetailTransactions
GROUP BY CustomerID
HAVING COUNT(TransactionID) > 5;
