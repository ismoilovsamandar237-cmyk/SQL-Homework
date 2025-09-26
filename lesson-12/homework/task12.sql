1
SELECT 
    P.firstName, 
    P.lastName, 
    A.city, 
    A.state
FROM Person P
LEFT JOIN Address A
    ON P.personId = A.personId;

	2 SELECT E.name AS Employee
FROM Employee E
JOIN Employee M
    ON E.managerId = M.id
WHERE E.salary > M.salary;
3
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;
4
DELETE P1
FROM Person P1
JOIN Person P2
   ON P1.email = P2.email
  AND P1.id > P2.id;

5
SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (SELECT b.ParentName FROM boys b);
6
SELECT CustomerID,
       SUM(Freight) AS TotalSales,
       MIN(Weight) AS LeastWeight
FROM Sales.Orders
WHERE Weight > 50
GROUP BY CustomerID;
7
SELECT C1.Item AS [Item Cart 1],
       C2.Item AS [Item Cart 2]
FROM Cart1 C1
FULL OUTER JOIN Cart2 C2
     ON C1.Item = C2.Item;
8
SELECT C.name AS Customers
FROM Customers C
LEFT JOIN Orders O 
       ON C.id = O.customerId
WHERE O.id IS NULL;
9
SELECT S.student_id,
       S.student_name,
       Sub.subject_name,
       COUNT(E.subject_name) AS attended_exams
FROM Students S
CROSS JOIN Subjects Sub
LEFT JOIN Examinations E
       ON S.student_id = E.student_id 
      AND Sub.subject_name = E.subject_name
GROUP BY S.student_id, S.student_name, Sub.subject_name
ORDER BY S.student_id, Sub.subject_name;

