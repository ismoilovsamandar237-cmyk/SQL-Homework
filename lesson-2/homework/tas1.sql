

✅ Basic-Level Tasks (1–10)
-- 1. Create Employees table
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 2. Insert records (3 usul bilan)
INSERT INTO Employees (EmpID, Name, Salary) VALUES (1, 'Ali', 6000); -- single row
INSERT INTO Employees VALUES (2, 'Vali', 5500);                      -- single row (all columns)
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (3, 'Hasan', 4000), (4, 'Husan', 4500);                       -- multiple rows

-- 3. Update Salary where EmpID=1
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

-- 4. Delete record where EmpID=2
DELETE FROM Employees WHERE EmpID = 2;

-- 5. DELETE vs TRUNCATE vs DROP
-- DELETE   = faqat data o‘chadi, structure qoladi, WHERE shart ishlaydi
-- TRUNCATE = hamma data o‘chadi, structure qoladi, tezroq ishlaydi, WHERE yo‘q
-- DROP     = butun table o‘chadi (data + structure)

-- 6. Modify Name column to VARCHAR(100)
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

-- 7. Add Department column
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 8. Change Salary to FLOAT
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- 9. Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 10. Remove all records but keep structure
TRUNCATE TABLE Employees;
✅ Intermediate-Level Tasks (11–16)
-- 11. Insert into Departments using INSERT INTO SELECT
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' UNION ALL
SELECT 2, 'Finance' UNION ALL
SELECT 3, 'IT' UNION ALL
SELECT 4, 'Sales' UNION ALL
SELECT 5, 'Marketing';

-- 12. Update Department where Salary > 5000
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

-- 13. Remove all employees but keep structure
TRUNCATE TABLE Employees;

-- 14. Drop Department column
ALTER TABLE Employees
DROP COLUMN Department;

-- 15. Rename Employees to StaffMembers
EXEC sp_rename 'Employees', 'StaffMembers';

-- 16. Drop Departments table completely
DROP TABLE Departments;
✅ Advanced-Level Tasks (17–25)
-- 17. Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Supplier VARCHAR(50)
);

-- 18. Add CHECK constraint for Price > 0
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

-- 19. Add StockQuantity with DEFAULT 50
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

-- 20. Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- 21. Insert 5 records
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Supplier)
VALUES 
(1, 'Laptop', 'Electronics', 1200.00, 'HP'),
(2, 'Phone', 'Electronics', 800.00, 'Samsung'),
(3, 'Chair', 'Furniture', 150.00, 'IKEA'),
(4, 'Table', 'Furniture', 300.00, 'IKEA'),
(5, 'Shoes', 'Clothing', 100.00, 'Nike');

-- 22. Backup table using SELECT INTO
SELECT * INTO Products_Backup
FROM Products;

-- 23. Rename Products to Inventory
EXEC sp_rename 'Products', 'Inventory';

-- 24. Change Price data type to FLOAT
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

-- 25. Add IDENTITY column ProductCode starting 1000 + increment 5
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);
