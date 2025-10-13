--------------------------------------------------------------
-- ✅ 1. Create a Numbers table using recursion (1 to 1000)
--------------------------------------------------------------
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < 1000
)
SELECT n
FROM Numbers;


--------------------------------------------------------------
-- ✅ 2. Total Sales per Employee (Derived Table)
--------------------------------------------------------------
SELECT 
    E.FirstName,
    E.LastName,
    S.TotalSales
FROM Employees AS E
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS S
ON E.EmployeeID = S.EmployeeID;


--------------------------------------------------------------
-- ✅ 3. Average Salary of Employees (CTE)
--------------------------------------------------------------
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AvgSal
    FROM Employees
)
SELECT 
    E.FirstName,
    E.LastName,
    E.Salary,
    A.AvgSal
FROM Employees AS E
CROSS JOIN AvgSalary AS A;


--------------------------------------------------------------
-- ✅ 4. Highest Sales for Each Product (Derived Table)
--------------------------------------------------------------
SELECT 
    P.ProductName,
    MAX(S.SalesAmount) AS HighestSale
FROM Products AS P
JOIN Sales AS S
ON P.ProductID = S.ProductID
GROUP BY P.ProductName;


--------------------------------------------------------------
-- ✅ 5. Double Numbers Until Less Than 1,000,000 (Recursive CTE)
--------------------------------------------------------------
WITH Doubles AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n * 2
    FROM Doubles
    WHERE n * 2 < 1000000
)
SELECT n
FROM Doubles;


--------------------------------------------------------------
-- ✅ 6. Employees Who Made More Than 5 Sales (CTE)
--------------------------------------------------------------
WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT 
    E.FirstName,
    E.LastName,
    S.TotalSales
FROM Employees AS E
JOIN SalesCount AS S
ON E.EmployeeID = S.EmployeeID
WHERE S.TotalSales > 5;


--------------------------------------------------------------
-- ✅ 7. Products with Total Sales Greater Than $500 (CTE)
--------------------------------------------------------------
WITH ProductSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT 
    P.ProductName,
    PS.TotalSales
FROM Products AS P
JOIN ProductSales AS PS
ON P.ProductID = PS.ProductID
WHERE PS.TotalSales > 500;


--------------------------------------------------------------
-- ✅ 8. Employees with Salary Above Average (CTE)
--------------------------------------------------------------
WITH AvgSal AS (
    SELECT AVG(Salary) AS AvgSalary FROM Employees
)
SELECT 
    FirstName,
    LastName,
    Salary
FROM Employees
WHERE Salary > (SELECT AvgSalary FROM AvgSal);


--------------------------------------------------------------
-- ✅ 9. Top 5 Employees by Number of Orders (Derived Table)
--------------------------------------------------------------
SELECT TOP 5
    E.FirstName,
    E.LastName,
    S.TotalOrders
FROM Employees AS E
JOIN (
    SELECT EmployeeID, COUNT(*) AS TotalOrders
    FROM Sales
    GROUP BY EmployeeID
) AS S
ON E.EmployeeID = S.EmployeeID
ORDER BY S.TotalOrders DESC;


--------------------------------------------------------------
-- ✅ 10. Sales per Product Category (Derived Table)
--------------------------------------------------------------
SELECT 
    P.CategoryID,
    SUM(S.SalesAmount) AS TotalSales
FROM Sales AS S
JOIN Products AS P
ON S.ProductID = P.ProductID
GROUP BY P.CategoryID;


--------------------------------------------------------------
-- ✅ 11. Factorial for Each Value (Recursive CTE)
--------------------------------------------------------------
WITH Factorial AS (
    SELECT Number AS n, 1 AS fact
    FROM Numbers1
    UNION ALL
    SELECT n, fact * n
    FROM Factorial
    WHERE n > 1
)
SELECT * FROM Factorial;


--------------------------------------------------------------
-- ✅ 12. Split String into Characters (Recursive CTE)
--------------------------------------------------------------
WITH Split AS (
    SELECT 
        Id,
        SUBSTRING(String, 1, 1) AS CharValue,
        1 AS n
    FROM Example
    UNION ALL
    SELECT 
        s.Id,
        SUBSTRING(e.String, n + 1, 1),
        n + 1
    FROM Split AS s
    JOIN Example AS e ON s.Id = e.Id
    WHERE n < LEN(e.String)
)
SELECT * FROM Split;


--------------------------------------------------------------
-- ✅ 13. Monthly Sales Difference (CTE + LAG)
--------------------------------------------------------------
WITH MonthlySales AS (
    SELECT 
        YEAR(SaleDate) AS Year,
        MONTH(SaleDate) AS Month,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
)
SELECT 
    Year,
    Month,
    TotalSales,
    TotalSales - LAG(TotalSales,1) OVER (ORDER BY Year, Month) AS Difference
FROM MonthlySales;


--------------------------------------------------------------
-- ✅ 14. Employees with Sales Over $45,000 per Quarter (Derived)
--------------------------------------------------------------
SELECT 
    E.FirstName,
    E.LastName,
    SUM(S.SalesAmount) AS QuarterlySales
FROM Sales AS S
JOIN Employees AS E ON S.EmployeeID = E.EmployeeID
GROUP BY E.FirstName, E.LastName, DATEPART(QUARTER, S.SaleDate)
HAVING SUM(S.SalesAmount) > 45000;


--------------------------------------------------------------
-- ✅ 15. Fibonacci Numbers (Recursive CTE)
--------------------------------------------------------------
WITH Fib AS (
    SELECT 0 AS a, 1 AS b
    UNION ALL
    SELECT b, a + b
    FROM Fib
    WHERE a + b < 10000
)
SELECT a AS FibonacciNumber FROM Fib;


--------------------------------------------------------------
-- ✅ 16. Strings with All Same Characters (FindSameCharacters)
--------------------------------------------------------------
SELECT Vals
FROM FindSameCharacters
WHERE LEN(Vals) > 1
AND LEN(REPLACE(Vals, LEFT(Vals,1), '')) = 0;


--------------------------------------------------------------
-- ✅ 17. Incremental Number Pattern (Example n=5 → 1, 12, 123...)
--------------------------------------------------------------
WITH Pattern AS (
    SELECT 1 AS n, CAST('1' AS VARCHAR(20)) AS pattern
    UNION ALL
    SELECT n + 1, pattern + CAST(n + 1 AS VARCHAR(20))
    FROM Pattern
    WHERE n < 5
)
SELECT pattern FROM Pattern;


--------------------------------------------------------------
-- ✅ 18. Employees Who Made the Most Sales in Last 6 Months
--------------------------------------------------------------
SELECT 
    E.FirstName,
    E.LastName,
    SUM(S.SalesAmount) AS TotalSales
FROM Employees AS E
JOIN Sales AS S
ON E.EmployeeID = S.EmployeeID
WHERE S.SaleDate >= DATEADD(MONTH, -6, GETDATE())
GROUP BY E.FirstName, E.LastName
ORDER BY TotalSales DESC;


--------------------------------------------------------------
-- ✅ 19. Remove Duplicate Integer Values from String
--------------------------------------------------------------
SELECT 
    Pawan_slug_name,
    REPLACE(
        TRANSLATE(Pawan_slug_name, '1234567890', '          '), 
        ' ', ''
    ) AS CleanedString
FROM RemoveDuplicateIntsFromNames;
