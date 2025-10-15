/*────────────────────────────────────────────
 1️⃣ Task 1 – Report of All Distributors and Their Sales by Region
────────────────────────────────────────────*/
WITH Regions AS (SELECT DISTINCT Region FROM #RegionSales),
Distributors AS (SELECT DISTINCT Distributor FROM #RegionSales)
SELECT r.Region, d.Distributor, ISNULL(rs.Sales,0) AS Sales
FROM Regions r
CROSS JOIN Distributors d
LEFT JOIN #RegionSales rs
  ON rs.Region=r.Region AND rs.Distributor=d.Distributor
ORDER BY d.Distributor,r.Region;


/*────────────────────────────────────────────
 2️⃣ Task 2 – Managers with ≥5 Direct Reports
────────────────────────────────────────────*/
SELECT m.name AS ManagerName
FROM Employee AS m
JOIN Employee AS e ON e.managerId=m.id
GROUP BY m.name
HAVING COUNT(e.id)>=5;


/*────────────────────────────────────────────
 3️⃣ Task 3 – Products with ≥100 units in Feb 2020
────────────────────────────────────────────*/
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id=o.product_id
WHERE YEAR(o.order_date)=2020 AND MONTH(o.order_date)=2
GROUP BY p.product_name
HAVING SUM(o.unit)>=100;


/*────────────────────────────────────────────
 4️⃣ Task 4 – Vendor from which each Customer has Most Orders
────────────────────────────────────────────*/
SELECT CustomerID, Vendor
FROM (
  SELECT CustomerID, Vendor,
         RANK() OVER(PARTITION BY CustomerID ORDER BY SUM([Count]) DESC) AS rnk
  FROM Orders
  GROUP BY CustomerID, Vendor
) x
WHERE rnk=1;


/*────────────────────────────────────────────
 5️⃣ Task 5 – Check if a number is Prime
────────────────────────────────────────────*/
DECLARE @Check_Prime INT=91, @i INT=2, @flag BIT=1;
WHILE @i<=SQRT(@Check_Prime)
BEGIN
  IF @Check_Prime%@i=0 BEGIN SET @flag=0; BREAK; END
  SET @i=@i+1;
END
IF @flag=1 PRINT('This number is prime');
ELSE PRINT('This number is not prime');


/*────────────────────────────────────────────
 6️⃣ Task 6 – Device signals per location
────────────────────────────────────────────*/
SELECT 
  d.Device_id,
  COUNT(DISTINCT d.Locations) AS no_of_location,
  (
    SELECT TOP 1 Locations
    FROM Device x
    WHERE x.Device_id=d.Device_id
    GROUP BY Locations
    ORDER BY COUNT(*) DESC
  ) AS max_signal_location,
  COUNT(*) AS no_of_signals
FROM Device d
GROUP BY d.Device_id;


/*────────────────────────────────────────────
 7️⃣ Task 7 – Employees earning above dept average
────────────────────────────────────────────*/
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
WHERE e.Salary >
 (
   SELECT AVG(Salary)
   FROM Employee x
   WHERE x.DeptID=e.DeptID
 );


/*────────────────────────────────────────────
 8️⃣ Task 8 – Lottery winnings calculation
────────────────────────────────────────────*/
WITH TicketMatches AS (
  SELECT t.TicketID, COUNT(*) AS MatchCount
  FROM Tickets t
  JOIN Numbers n ON n.Number=t.Number
  GROUP BY t.TicketID
)
SELECT SUM(
 CASE 
   WHEN MatchCount=3 THEN 100
   WHEN MatchCount>0 THEN 10
   ELSE 0 END
) AS Total_Winnings
FROM TicketMatches;


/*────────────────────────────────────────────
 9️⃣ Task 9 – Spending by device type per date
────────────────────────────────────────────*/
WITH Base AS (
  SELECT User_id, Spend_date,
         SUM(CASE WHEN Platform='Mobile' THEN Amount ELSE 0 END) AS MobileAmt,
         SUM(CASE WHEN Platform='Desktop' THEN Amount ELSE 0 END) AS DeskAmt
  FROM Spending
  GROUP BY User_id, Spend_date
)
SELECT 1 AS Row#, Spend_date,'Mobile' AS Platform,SUM(MobileAmt) AS Total_Amount,COUNT(User_id) AS Total_users
FROM Base WHERE MobileAmt>0 GROUP BY Spend_date
UNION ALL
SELECT 2,Spend_date,'Desktop',SUM(DeskAmt),COUNT(User_id)
FROM Base WHERE DeskAmt>0 GROUP BY Spend_date
UNION ALL
SELECT 3,Spend_date,'Both',SUM(MobileAmt+DeskAmt),COUNT(User_id)
FROM Base WHERE MobileAmt>0 AND DeskAmt>0 GROUP BY Spend_date
ORDER BY Spend_date,Row#;


/*────────────────────────────────────────────
 🔟 Task 10 – De-group data
────────────────────────────────────────────*/
WITH Numbers AS (
  SELECT 1 AS n
  UNION ALL SELECT n+1 FROM Numbers WHERE n<100
)
SELECT g.Product,1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n<=g.Quantity
OPTION (MAXRECURSION 0);
