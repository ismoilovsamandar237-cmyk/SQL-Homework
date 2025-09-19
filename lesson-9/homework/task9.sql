1
SELECT P.ProductName, S.SupplierName
FROM Products P
CROSS JOIN Suppliers S;
2
SELECT D.DepartmentName, E.Name
FROM Departments D
CROSS JOIN Employees E;
3
SELECT S.SupplierName, P.ProductName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID;
4
SELECT C.FirstName, O.OrderID
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;
5
SELECT S.Name, C.CourseName
FROM Students S
CROSS JOIN Courses C;
6
SELECT P.ProductName, O.OrderID
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID;
7
SELECT E.Name, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;
8
SELECT S.Name, E.CourseID
FROM Students S
INNER JOIN Enrollments E ON S.StudentID = E.StudentID;
9
SELECT O.OrderID, P.PaymentID, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID;
10
SELECT O.OrderID, P.ProductName, P.Price
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID
WHERE P.Price > 100;
11
SELECT E.Name, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID <> D.DepartmentID;
12
SELECT O.OrderID, P.ProductName, O.Quantity, P.StockQuantity
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID
WHERE O.Quantity > P.StockQuantity;
13
SELECT C.FirstName, S.ProductID, S.SaleAmount
FROM Sales S
INNER JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE S.SaleAmount >= 500;
14
SELECT S.Name, C.CourseName
FROM Students S
INNER JOIN Enrollments E ON S.StudentID = E.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID;
15
SELECT P.ProductName, S.SupplierName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE '%Tech%';
16
SELECT O.OrderID, O.TotalAmount, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.Amount < O.TotalAmount;
17
SELECT E.Name, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;
18
SELECT P.ProductName, C.CategoryName
FROM Products P
INNER JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics','Furniture');
19
SELECT S.SaleID, S.ProductID, C.FirstName, C.Country
FROM Sales S
INNER JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE C.Country = 'USA';
20
SELECT O.OrderID, C.FirstName, O.TotalAmount
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Germany' AND O.TotalAmount > 100;
21
SELECT E1.Name AS Employee1, E2.Name AS Employee2
FROM Employees E1
INNER JOIN Employees E2 ON E1.DepartmentID <> E2.DepartmentID;
22
SELECT P.PaymentID, O.OrderID, P.Amount, (O.Quantity * Pr.Price) AS ExpectedAmount
FROM Payments P
INNER JOIN Orders O ON P.OrderID = O.OrderID
INNER JOIN Products Pr ON O.ProductID = Pr.ProductID
WHERE P.Amount <> (O.Quantity * Pr.Price);
23
SELECT S.Name
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.StudentID IS NULL;
24 SELECT M.Name AS Manager, E.Name AS Employee
FROM Employees M
INNER JOIN Employees E ON M.EmployeeID = E.ManagerID
WHERE M.Salary <= E.Salary;
25
SELECT DISTINCT C.FirstName, C.LastName
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.OrderID IS NULL;
