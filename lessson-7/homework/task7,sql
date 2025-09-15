-- 20. Average price per product category > 150
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

-- 21. Total sales per customer > 1500
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

-- 22. Total and average salary per department with avg > 65000
SELECT DepartmentName, SUM(Salary) AS TotalSalary, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

-- 23. Total amount for orders with weight > 50 and least purchase (Orders table)
-- Assuming 'Freight' column = weight in Orders
SELECT CustomerID, SUM(TotalAmount) AS TotalAmount, MIN(TotalAmount) AS LeastPurchase
FROM Orders
WHERE TotalAmount > 50
GROUP BY CustomerID;

-- 24. Total sales and count of unique products per month/year, months with >=2 products sold
SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth,
       SUM(TotalAmount) AS TotalSales,
       COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2;

-- 25. Min and Max order quantity per year
SELECT YEAR(OrderDate) AS OrderYear, MIN(Quantity) AS MinQuantity, MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate);
