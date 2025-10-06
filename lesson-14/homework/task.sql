

-- 1️⃣ Split the Name column by comma (Name, Surname)
SELECT 
    LEFT(Name, CHARINDEX(',', Name) - 1) AS FirstName,
    RIGHT(Name, LEN(Name) - CHARINDEX(',', Name)) AS LastName
FROM TestMultipleColumns;

-- 2️⃣ Find strings containing the % character
SELECT * 
FROM TestPercent
WHERE Strs LIKE '%[%]%';

-- 3️⃣ Split a string by dot (.)
SELECT 
    LEFT(Vals, CHARINDEX('.', Vals)-1) AS BeforeDot,
    RIGHT(Vals, LEN(Vals) - CHARINDEX('.', Vals)) AS AfterDot
FROM Splitter;

-- 4️⃣ Return rows where value has more than two dots
SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

-- 5️⃣ Count spaces in a string
SELECT 
    texts,
    LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

-- 6️⃣ Employees earning more than their managers
SELECT 
    E.FIRST_NAME, 
    E.SALARY, 
    M.FIRST_NAME AS ManagerName, 
    M.SALARY AS ManagerSalary
FROM Employees E
JOIN Employees M ON E.MANAGER_ID = M.EMPLOYEE_ID
WHERE E.SALARY > M.SALARY;

-- 7️⃣ Employees who worked 10–15 years
SELECT 
    EMPLOYEE_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 15;




-- 8️⃣ Dates with higher temperature than previous day
SELECT 
    W1.Id, 
    W1.RecordDate, 
    W1.Temperature
FROM weather W1
JOIN weather W2 ON DATEDIFF(DAY, W2.RecordDate, W1.RecordDate) = 1
WHERE W1.Temperature > W2.Temperature;

-- 9️⃣ First login date for each player
SELECT 
    player_id, 
    MIN(event_date) AS FirstLoginDate
FROM Activity
GROUP BY player_id;

-- 🔟 Return the 3rd item from fruit list
SELECT 
    PARSENAME(REPLACE(fruit_list, ',', '.'), 2) AS ThirdFruit
FROM fruits;

-- 11️⃣ Determine employment stage (CASE)
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Years,
    CASE 
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;

-- 12️⃣ Extract integer at the start of the string
SELECT 
    VALS,
    LEFT(VALS, PATINDEX('%[^0-9]%', VALS + 'a') - 1) AS IntegerValue
FROM GetIntegers
WHERE VALS LIKE '[0-9]%';



-- 13️⃣ Swap first two letters of comma-separated string
SELECT 
    Id,
    REVERSE(SUBSTRING(Vals, CHARINDEX(',', Vals)+1, CHARINDEX(',', REVERSE(Vals))-1)) AS Swapped
FROM MultipleVals;

-- 14️⃣ Convert each character into a new row
SELECT 
    SUBSTRING('sdgfhsdgfhs@121313131', Number, 1) AS CharValue
FROM master.dbo.spt_values
WHERE Type='P' AND Number BETWEEN 1 AND LEN('sdgfhsdgfhs@121313131');

-- 15️⃣ Report first logged-in device for each player
SELECT 
    A1.player_id, 
    A1.device_id
FROM Activity A1
JOIN (
    SELECT 
        player_id, 
        MIN(event_date) AS FirstLogin
    FROM Activity
    GROUP BY player_id
) A2
ON A1.player_id = A2.player_id 
AND A1.event_date = A2.FirstLogin;

-- 16️⃣ Separate integers and characters
DECLARE @str VARCHAR(100) = 'rtcfvty34redt';

SELECT 
    @str AS Original,
    LEFT(@str, PATINDEX('%[0-9]%', @str)-1) AS Characters,
    SUBSTRING(@str, PATINDEX('%[0-9]%', @str), LEN(@str)) AS Numbers;
