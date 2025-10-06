------------------------------------------
-- 🟢 EASY TASKS
------------------------------------------

-- 1️⃣  "100-Steven King" (EMP_ID + FIRST_NAME + LAST_NAME)
SELECT 
    CONCAT(EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME) AS FullInfo
FROM Employees;


-- 2️⃣  Phone_number ichidagi '124' ni '999' ga almashtirish
UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999');


-- 3️⃣  Ismi A, J yoki M bilan boshlanuvchilar va ism uzunligi
SELECT 
    FIRST_NAME AS Name,
    LEN(FIRST_NAME) AS NameLength
FROM Employees
WHERE FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'J%' OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME;


-- 4️⃣  Har bir manager uchun umumiy maosh
SELECT 
    MANAGER_ID,
    SUM(SALARY) AS TotalSalary
FROM Employees
GROUP BY MANAGER_ID;


-- 5️⃣  Har yil uchun eng katta Max1, Max2, Max3 qiymatini topish
SELECT 
    Year1,
    CASE 
        WHEN Max1 >= Max2 AND Max1 >= Max3 THEN Max1
        WHEN Max2 >= Max1 AND Max2 >= Max3 THEN Max2
        ELSE Max3
    END AS HighestValue
FROM TestMax;


-- 6️⃣  Odd ID va description 'boring' bo‘lmagan filmlar
SELECT * 
FROM cinema
WHERE id % 2 <> 0 
  AND description <> 'boring';


-- 7️⃣  Id bo‘yicha sortlash, lekin Id = 0 eng oxirda chiqsin
SELECT * 
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;


-- 8️⃣  Birinchi NULL bo‘lmagan qiymatni tanlash
SELECT 
    id,
    COALESCE(ssn, passportid, itin) AS FirstNonNull
FROM person;




-- 9️⃣  FullName ni First, Middle, Last ga bo‘lish
SELECT 
    StudentID,
    PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM Students;


-- 🔟  California’da yetkazilgan mijozlarning Texas’dagi buyurtmalari
SELECT DISTINCT O2.*
FROM Orders O1
JOIN Orders O2 ON O1.CustomerID = O2.CustomerID
WHERE O1.DeliveryState = 'CA'
  AND O2.DeliveryState = 'TX';


-- 1️⃣1️⃣  DMLTable qiymatlarini bir qatorda ko‘rsatish
SELECT STRING_AGG(String, ' ') AS FullSentence
FROM DMLTable
ORDER BY SequenceNumber;


-- 1️⃣2️⃣  Ismida kamida 3ta “a” mavjud xodimlar
SELECT *
FROM Employees
WHERE (LEN(FIRST_NAME + LAST_NAME) - LEN(REPLACE(FIRST_NAME + LAST_NAME, 'a', ''))) >= 3;


-- 1️⃣3️⃣  Har departmentda 3 yildan ortiq ishlaganlarning foizi
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS PercentOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID;




-- 1️⃣4️⃣  Har qatorni o‘zidan oldingilarning yig‘indisi bilan chiqarish
SELECT 
    StudentID,
    SUM(Grade) OVER (ORDER BY StudentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeGrade
FROM Students;


-- 1️⃣5️⃣  Tug‘ilgan kuni bir xil bo‘lgan talabalar
SELECT s1.StudentName, s1.Birthday
FROM Student s1
JOIN Student s2 ON s1.Birthday = s2.Birthday AND s1.StudentName <> s2.StudentName
ORDER BY s1.Birthday;


-- 1️⃣6️⃣  O‘yinchilar juftliklarini birlashtirish va umumiy ball hisoblash
SELECT 
    LEAST(PlayerA, PlayerB) AS Player1,
    GREATEST(PlayerA, PlayerB) AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY LEAST(PlayerA, PlayerB), GREATEST(PlayerA, PlayerB);


-- 1️⃣7️⃣  Stringni katta, kichik, raqam va boshqa belgiga ajratish
DECLARE @txt VARCHAR(50) = 'tf56sd#%OqH';

SELECT
    REPLACE(STRING_AGG(CASE WHEN PATINDEX('%[A-Z]%', SUBSTRING(@txt, v.number, 1))>0 THEN SUBSTRING(@txt, v.number, 1) ELSE '' END, ''),' ','') AS Uppercase,
    REPLACE(STRING_AGG(CASE WHEN PATINDEX('%[a-z]%', SUBSTRING(@txt, v.number, 1))>0 THEN SUBSTRING(@txt, v.number, 1) ELSE '' END, ''),' ','') AS Lowercase,
    REPLACE(STRING_AGG(CASE WHEN PATINDEX('%[0-9]%', SUBSTRING(@txt, v.number, 1))>0 THEN SUBSTRING(@txt, v.number, 1) ELSE '' END, ''),' ','') AS Numbers,
    REPLACE(STRING_AGG(CASE WHEN PATINDEX('%[^0-9A-Za-z]%', SUBSTRING(@txt, v.number, 1))>0 THEN SUBSTRING(@txt, v.number, 1) ELSE '' END, ''),' ','') AS Others
FROM master.dbo.spt_values v
WHERE v.number BETWEEN 1 AND LEN(@txt);
