1
SELECT 
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;


2
SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) AS X
GROUP BY rID;


3
SELECT 
    Id, 
    Vals
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;


4
SELECT 
    T1.ID, 
    T1.Item, 
    T1.Vals
FROM TestMaximum T1
INNER JOIN (
    SELECT ID, MAX(Vals) AS MaxVal
    FROM TestMaximum
    GROUP BY ID
) T2 
ON T1.ID = T2.ID AND T1.Vals = T2.MaxVal;


5
SELECT 
    Id, 
    SUM(MaxVal) AS SumOfMax
FROM (
    SELECT 
        Id,
        DetailedNumber,
        MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS X
GROUP BY Id;


6
SELECT 
    Id,
    a,
    b,
    NULLIF(a - b, 0) AS OUTPUT
FROM TheZeroPuzzle;


7
SELECT 
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;


8
SELECT 
    AVG(UnitPrice) AS AvgUnitPrice
FROM Sales;


9
SELECT 
    COUNT(*) AS TotalTransactions
FROM Sales;


10
SELECT 
    MAX(QuantitySold) AS MaxUnitsSold
FROM Sales;


11
SELECT 
    Category,
    SUM(QuantitySold) AS TotalProductsSold
FROM Sales
GROUP BY Category;


12
SELECT 
    Region,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region
ORDER BY TotalRevenue DESC;


13
SELECT TOP 1
    Product,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;


14
SELECT 
    SaleDate,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningTotalRevenue
FROM Sales;


15
    Category,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue,
    CAST(
        (SUM(QuantitySold * UnitPrice) * 100.0 /
         (SELECT SUM(QuantitySold * UnitPrice) FROM Sales)
        ) AS DECIMAL(5,2)
    ) AS PercentageOfTotal
FROM Sales
GROUP BY Category
ORDER BY PercentageOfTotal DESC;  

WITH ProductRevenue AS (
    SELECT 
        Region,
        Product,
        SUM(QuantitySold * UnitPrice) AS TotalRevenue
    FROM Sales
    GROUP BY Region, Product
)
SELECT 
    Region,
    Product,
    TotalRevenue
FROM (
    SELECT 
        Region,
        Product,
        TotalRevenue,
        ROW_NUMBER() OVER (PARTITION BY Region ORDER BY TotalRevenue DESC) AS RowNum
    FROM ProductRevenue
) AS Ranked
WHERE RowNum <= 3
ORDER BY Region, TotalRevenue DESC;


17
SELECT 
    S.SaleID,
    S.Product,
    S.Region,
    C.CustomerName,
    S.QuantitySold,
    S.UnitPrice,
    (S.QuantitySold * S.UnitPrice) AS TotalRevenue
FROM Sales S
INNER JOIN Customers C
ON S.CustomerID = C.CustomerID;


18
    C.CustomerID,
    C.CustomerName
FROM Customers C
LEFT JOIN Sales S
ON C.CustomerID = S.CustomerID
WHERE S.CustomerID IS NULL;


19
    C.CustomerName,
    SUM(S.QuantitySold * S.UnitPrice) AS TotalRevenue
FROM Sales S
INNER JOIN Customers C
ON S.CustomerID = C.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalRevenue DESC;

20
SELECT TOP 1
    C.CustomerName,
    SUM(S.QuantitySold * S.UnitPrice) AS TotalRevenue
FROM Sales S
INNER JOIN Customers C
ON S.CustomerID = C.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalRevenue DESC;


21-----
SELECT 
    C.CustomerName,
    COUNT(S.SaleID) AS TotalSales
FROM Sales S
INNER JOIN Customers C
ON S.CustomerID = C.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalSales DESC;


22
SELECT DISTINCT 
    Product
FROM Sales;


23
SELECT TOP 1
    ProductName,
    SellingPrice
FROM Products
ORDER BY SellingPrice DESC;


24
SELECT 
    ProductName,
    Category,
    SellingPrice
FROM Products P
WHERE SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products
    WHERE Category = P.Category
);
