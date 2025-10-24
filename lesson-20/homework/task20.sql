1
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1 FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND MONTH(s2.SaleDate) = 3 AND YEAR(s2.SaleDate) = 2024
);
2
SELECT TOP 1 Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;
3
SELECT MAX(TotalSale) AS SecondHighest
FROM (
    SELECT DISTINCT Quantity * Price AS TotalSale
    FROM #Sales
) t
WHERE TotalSale < (SELECT MAX(Quantity * Price) FROM #Sales);
4
SELECT MONTH(SaleDate) AS SaleMonth, SUM(Quantity) AS TotalQty
FROM #Sales
GROUP BY MONTH(SaleDate);
5
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1 FROM #Sales s2
    WHERE s1.Product = s2.Product
      AND s1.CustomerName <> s2.CustomerName
);
6
SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;
7
WITH FamilyTree AS (
    SELECT ParentID, ChildID FROM Family
    UNION ALL
    SELECT f.ParentID, c.ChildID
    FROM Family f
    JOIN FamilyTree c ON f.ChildID = c.ParentID
)
SELECT * FROM FamilyTree;
8
SELECT DISTINCT o2.CustomerID, o2.OrderID, o2.DeliveryState, o2.Amount
FROM #Orders o2
WHERE o2.DeliveryState = 'TX'
AND EXISTS (
    SELECT 1 FROM #Orders o1
    WHERE o1.CustomerID = o2.CustomerID
      AND o1.DeliveryState = 'CA'
);
9
UPDATE #residents
SET fullname = SUBSTRING(address, CHARINDEX('name=', address) + 5,
              CHARINDEX(' ', address + ' ', CHARINDEX('name=', address)) - (CHARINDEX('name=', address) + 5))
WHERE fullname IS NULL OR fullname = '';
10
WITH RoutesCTE AS (
    SELECT RouteID, DepartureCity, ArrivalCity, Cost,
           CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(200)) AS RoutePath
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    UNION ALL
    SELECT r.RouteID, rc.DepartureCity, r.ArrivalCity, rc.Cost + r.Cost,
           CAST(rc.RoutePath + ' - ' + r.ArrivalCity AS VARCHAR(200))
    FROM #Routes r
    JOIN RoutesCTE rc ON rc.ArrivalCity = r.DepartureCity
)
SELECT TOP 2 RoutePath AS Route, Cost
FROM RoutesCTE
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost ASC;
11
SELECT ID, Vals,
       DENSE_RANK() OVER (ORDER BY (SELECT NULL)) AS RankOrder
FROM #RankingPuzzle;
12
SELECT e.EmployeeName, e.Department, e.SalesAmount
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);
13
SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1 FROM #EmployeeSales s
    WHERE s.SalesMonth = e.SalesMonth
      AND s.SalesYear = e.SalesYear
    GROUP BY s.SalesMonth, s.SalesYear
    HAVING MAX(s.SalesAmount) = e.SalesAmount
);
14
SELECT e.EmployeeName
FROM #EmployeeSales e
GROUP BY e.EmployeeName
HAVING COUNT(DISTINCT e.SalesMonth) = (
    SELECT COUNT(DISTINCT SalesMonth) FROM #EmployeeSales
);
15
SELECT Name, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);
16
SELECT Name, Stock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);
17
SELECT Name, Category
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');
18
SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price) FROM Products WHERE Category = 'Electronics'
);
19
SELECT Name, Category, Price
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);
20
SELECT DISTINCT p.Name
FROM Products p
WHERE EXISTS (
    SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID
);
21
SELECT p.Name, SUM(o.Quantity) AS TotalQty
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders);
22
SELECT Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID
);
23
SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalOrdered
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY TotalOrdered DESC;
