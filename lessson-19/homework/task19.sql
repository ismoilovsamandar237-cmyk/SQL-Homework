------------------------------------------------------------
-- TASK 1: Employee Bonus Calculation Procedure
-------------------------------------------------------------
CREATE PROCEDURE GetEmployeeBonus
AS
BEGIN
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * d.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus d ON e.Department = d.Department;

    SELECT * FROM #EmployeeBonus;
END;
GO


-------------------------------------------------------------
-- TASK 2: Update Department Salary Procedure
-------------------------------------------------------------
CREATE PROCEDURE UpdateDepartmentSalary
    @DeptName NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercent / 100)
    WHERE Department = @DeptName;

    SELECT * FROM Employees WHERE Department = @DeptName;
END;
GO



-----------------------------
-- PART 2: MERGE TASKS
-----------------------------

-------------------------------------------------------------
-- TASK 3: MERGE Products (Update, Insert, Delete)
-------------------------------------------------------------
MERGE INTO Products_Current AS Target
USING Products_New AS Source
ON Target.ProductID = Source.ProductID

WHEN MATCHED THEN
    UPDATE SET 
        Target.ProductName = Source.ProductName,
        Target.Price = Source.Price

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (Source.ProductID, Source.ProductName, Source.Price)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

SELECT * FROM Products_Current;
GO



-------------------------------------------------------------
-- TASK 4: Tree Node Classification
-------------------------------------------------------------
SELECT 
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree
ORDER BY id;
GO



-------------------------------------------------------------
-- TASK 5: Confirmation Rate Calculation
-------------------------------------------------------------
SELECT 
    s.user_id,
    ISNULL(
        ROUND(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) * 1.0 / COUNT(c.user_id), 2),
        0
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;
GO



-------------------------------------------------------------
-- TASK 6: Employees with Lowest Salary (Subquery)
-------------------------------------------------------------
SELECT name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
GO



-------------------------------------------------------------
-- TASK 7: Product Sales Summary Procedure
-------------------------------------------------------------
CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
GO
