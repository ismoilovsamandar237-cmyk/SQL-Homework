1
SELECT E.Name AS EmployeeName, E.Salary, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > 50000;
2
SELECT C.FirstName, C.LastName, O.OrderDate
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE YEAR(O.OrderDate) = 2023;
3
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;
4
SELECT S.SupplierName, P.ProductName
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID;
5
SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders O
FULL OUTER JOIN Payments P ON O.OrderID = P.OrderID;
6
SELECT E.Name AS EmployeeName, M.Name AS ManagerName
FROM Employees E
LEFT JOIN Employees M ON E.ManagerID = M.EmployeeID;
7
SELECT S.Name AS StudentName, C.CourseName
FROM Students S
INNER JOIN Enrollments E ON S.StudentID = E.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.CourseName = 'Math 101';
8
SELECT C.FirstName, C.LastName, O.Quantity
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.Quantity > 3;
9
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Human Resources';
10
SELECT D.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount
FROM Departments D
INNER JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName
HAVING COUNT(E.EmployeeID) > 5;
11
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Sales S ON P.ProductID = S.ProductID
WHERE S.ProductID IS NULL;
12
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;
13
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;
14
SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID
FROM Employees E1
INNER JOIN Employees E2 ON E1.ManagerID = E2.ManagerID 
WHERE E1.EmployeeID < E2.EmployeeID;
15
SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = 2022;
16
SELECT E.Name AS EmployeeName, E.Salary, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sales' AND E.Salary > 60000;
17
SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID;
18
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Orders O ON P.ProductID = O.ProductID
WHERE O.ProductID IS NULL;
19
SELECT E.Name AS EmployeeName, E.Salary
FROM Employees E
INNER JOIN (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) DAVG ON E.DepartmentID = DAVG.DepartmentID
WHERE E.Salary > DAVG.AvgSalary;
20
SELECT O.OrderID, O.OrderDate
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE O.OrderDate < '2020-01-01' AND P.OrderID IS NULL;
21
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryID IS NULL;
22
SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID, E1.Salary
FROM Employees E1
INNER JOIN Employees E2 ON E1.ManagerID = E2.ManagerID
WHERE E1.EmployeeID < E2.EmployeeID AND E1.Salary > 60000 AND E2.Salary > 60000;
23
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'M%';
24
SELECT S.SaleID, P.ProductName, S.SaleAmount
FROM Sales S
INNER JOIN Products P ON S.ProductID = P.ProductID
WHERE S.SaleAmount > 500;
25
SELECT S.StudentID, S.Name AS StudentName
FROM Students S
WHERE S.StudentID NOT IN (
    SELECT E.StudentID
    FROM Enrollments E
    INNER JOIN Courses C ON E.CourseID = C.CourseID
    WHERE C.CourseName = 'Math 101'
);
26
SELECT O.OrderID, O.OrderDate, P.PaymentID
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL;
27
SELECT P.ProductID, P.ProductName, C.CategoryName
FROM Products P
INNER JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');
