1
SELECT MIN(c) AS col1, MAX(c) AS col2
FROM (
    SELECT CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS c,
           CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS d
    FROM InputTbl
) 
2
SELECT *
FROM TestMultipleZero
WHERE A + B + C + D <> 0;

3
SELECT *
FROM section1
WHERE id % 2 = 1;
4
SELECT TOP 1 *
FROM section1
ORDER BY id ASC;
5
SELECT TOP 1 *
FROM section1
ORDER BY id DESC;
6
SELECT *
FROM section1
WHERE name LIKE 'B%';
7
SELECT *
FROM ProductCodes
WHERE Code LIKE '%[_]%';
