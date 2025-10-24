

------------------------------------------------------------
-- 1. Row number based on SaleDate
------------------------------------------------------------
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;


------------------------------------------------------------
-- 2. Rank products by total quantity sold (DENSE_RANK)
------------------------------------------------------------
SELECT 
    ProductName,
    SUM(Quantity) AS TotalQty,
    DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS RankByQuantity
FROM ProductSales
GROUP BY ProductName;


------------------------------------------------------------
-- 3. Top sale per customer
------------------------------------------------------------
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS RankNum
    FROM ProductSales
) t
WHERE RankNum = 1;


------------------------------------------------------------
-- 4. Each sale with next sale amount
------------------------------------------------------------
SELECT 
    SaleID,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSale
FROM ProductSales;


------------------------------------------------------------
-- 5. Each sale with previous sale amount
------------------------------------------------------------
SELECT 
    SaleID,
    SaleAmount,
    LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSale
FROM ProductSales;


------------------------------------------------------------
-- 6. Sales amounts greater than previous sale
------------------------------------------------------------
SELECT SaleID, SaleAmount, 
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSale
FROM ProductSales
WHERE SaleAmount > LAG(SaleAmount) OVER (ORDER BY SaleDate);


------------------------------------------------------------
-- 7. Difference from previous sale (by product)
------------------------------------------------------------
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffPrev
FROM ProductSales;


------------------------------------------------------------
-- 8. Percentage change with next sale (by product)
------------------------------------------------------------
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    ROUND(
        ((LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) - SaleAmount) / SaleAmount) * 100, 2
    ) AS PctChange
FROM ProductSales;


------------------------------------------------------------
-- 9. Ratio current to previous (by product)
------------------------------------------------------------
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    ROUND(
        SaleAmount / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 2
    ) AS RatioToPrev
FROM ProductSales;


------------------------------------------------------------
-- 10. Difference from first sale (by product)
------------------------------------------------------------
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales;


------------------------------------------------------------
-- 11. Continuously increasing sales per product
------------------------------------------------------------
SELECT *
FROM (
    SELECT *,
           CASE WHEN SaleAmount > LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate)
                THEN 1 ELSE 0 END AS Increasing
    FROM ProductSales
) t
WHERE Increasing = 1;


------------------------------------------------------------
-- 12. Running total (cumulative sum)
------------------------------------------------------------
SELECT 
    SaleID,
    ProductName,
    SaleAmount,
    SUM(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM ProductSales;


------------------------------------------------------------
-- 13. Moving average over last 3 sales
------------------------------------------------------------
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    ROUND(AVG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS MovingAvg3
FROM ProductSales;


------------------------------------------------------------
-- 14. Difference from overall average
------------------------------------------------------------
SELECT 
    ProductName,
    SaleAmount,
    SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales;


------------------------------------------------------------
-- 15. Employees with same salary rank
------------------------------------------------------------
SELECT 
    Name,
    Department,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1;


------------------------------------------------------------
-- 16. Top 2 salaries per department
------------------------------------------------------------
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptRank
    FROM Employees1
) t
WHERE DeptRank <= 2;


------------------------------------------------------------
-- 17. Lowest-paid employee per department
------------------------------------------------------------
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS RankNum
    FROM Employees1
) t
WHERE RankNum = 1;


------------------------------------------------------------
-- 18. Running total of salaries per department
------------------------------------------------------------
SELECT 
    Department,
    Name,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees1;


------------------------------------------------------------
-- 19. Total salary per department (without GROUP BY)
------------------------------------------------------------
SELECT 
    Department,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalDeptSalary
FROM Employees1
GROUP BY Department, Salary;


------------------------------------------------------------
-- 20. Average salary per department (without GROUP BY)
------------------------------------------------------------
SELECT 
    Department,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgDeptSalary
FROM Employees1
GROUP BY Department, Salary;


------------------------------------------------------------
-- 21. Salary difference from department average
------------------------------------------------------------
SELECT 
    Name,
    Department,
    Salary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1;


------------------------------------------------------------
-- 22. Moving average salary over 3 employees
------------------------------------------------------------
SELECT 
    Department,
    Name,
    Salary,
    ROUND(AVG(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS MovingAvg3
FROM Employees1;


------------------------------------------------------------
-- 23. Sum of last 3 hired employees
------------------------------------------------------------
SELECT 
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Last3HiresSum
FROM Employees1
ORDER BY HireDate DESC;
