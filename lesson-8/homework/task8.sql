1
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;
2
SELECT AVG(Price) AS AvgPrice
FROM Products
WHERE Category = 'Electronics';
3
SELECT *
FROM Customers
WHERE City LIKE 'L%';
4
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';
5
SELECT *
FROM Customers
WHERE Country LIKE '%A';
6
SELECT MAX(Price) AS HighestPrice
FROM Products;
7
SELECT ProductName,
       CASE 
           WHEN Quantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;
8
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;
9
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;
10
SELECT DISTINCT CustomerID
FROM Orders
WHERE YEAR(OrderDate) = 2023
  AND MONTH(OrderDate) = 1
  AND CustomerID NOT IN (
      SELECT CustomerID
      FROM Invoices
  );
  11
  SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;
12
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;
13
SELECT YEAR(OrderDate) AS OrderYear,
       AVG(OrderAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);
14
SELECT ProductName,
       CASE
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;
15
SELECT City, [2012], [2013]
INTO Population_Each_Year
FROM (
    SELECT City, Year, Population
    FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population) FOR Year IN ([2012], [2013])
) AS P;
16
SELECT ProductID, SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;
17
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';
18
SELECT Year, [Bektemir], [Chilonzor], [Yakkasaroy]
INTO Population_Each_City
FROM (
    SELECT City, Year, Population
    FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population) FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS P;
19
SELECT TOP 3 CustomerID, 
       SUM(InvoiceAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;
20
SELECT City, Year, Population
FROM Population_Each_Year
UNPIVOT (
    Population FOR Year IN ([2012], [2013])
) AS Unpvt;
21
SELECT ProductName,
       (SELECT COUNT(*) 
        FROM Sales S
        WHERE S.ProductID = P.ProductID) AS TimesSold
FROM Products P;
22
SELECT Year, City, Population
FROM Population_Each_City
UNPIVOT (
    Population FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS Unpvt;

