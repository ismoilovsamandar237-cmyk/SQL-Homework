
1.
BULK INSERT is used to quickly load large amounts of data from external files (like .txt or .csv) into a SQL Server table.

2.

CSV

TXT

Excel (.xls/.xlsx)

XML

3.

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);
4.

INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1, 'Phone', 500.00),
(2, 'Laptop', 1200.00),
(3, 'Tablet', 300.00);
5.

NULL → means no value.

NOT NULL → value must always be provided.

6.

ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);
7.

-- This query selects all records from Products table
SELECT * FROM Products;
8.

ALTER TABLE Products
ADD CategoryID INT;
9.

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);
10.
The IDENTITY column automatically generates sequential numbers for each new row (e.g., 1, 2, 3…).

11.

BULK INSERT Products
FROM 'C:\data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
12.

ALTER TABLE Products
ADD CONSTRAINT FK_Category FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);
13.

PRIMARY KEY: Only one per table, does not allow NULL.

UNIQUE KEY: Multiple can exist, allows NULL.

14.

ALTER TABLE Products
ADD CONSTRAINT CK_Price CHECK (Price > 0);
15.

ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;
16.

SELECT ProductName, ISNULL(Price, 0) AS Price
FROM Products;
17.
A FOREIGN KEY links one table’s column to another table’s PRIMARY KEY, ensuring referential integrity.

18.

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT CHECK (Age >= 18)
);
19.

CREATE TABLE Orders (
    OrderID INT IDENTITY(100,10) PRIMARY KEY,
    OrderName VARCHAR(50)
);
20.

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);
21.

ISNULL(expression, value) → replaces NULL with the given value.

COALESCE(expr1, expr2, …) → returns the first non-NULL expression.

22.

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50) UNIQUE
);
23.

ALTER TABLE OrderDetails
ADD CONSTRAINT FK_Order FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID)
ON DELETE CASCADE
ON UPDATE CASCADE;
