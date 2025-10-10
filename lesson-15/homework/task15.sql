1
SELECT name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
2
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);
3
SELECT name
FROM employees
WHERE department_id = (
    SELECT id
    FROM departments
    WHERE department_name = 'Sales'
);
4
SELECT name
FROM customers AS C
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS O
    WHERE O.customer_id = C.customer_id
);
5
SELECT product_name, price, category_id
FROM products AS P
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = P.category_id
);
6
SELECT name, salary
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);
7
SELECT name, salary, department_id
FROM employees AS E
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = E.department_id
);
8
SELECT s.name, g.course_id, g.grade
FROM grades AS g
JOIN students AS s ON g.student_id = s.student_id
WHERE g.grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE course_id = g.course_id
);
9
SELECT p1.product_name, p1.price, p1.category_id
FROM products AS p1
WHERE 2 = (
    SELECT COUNT(DISTINCT p2.price)
    FROM products AS p2
    WHERE p2.category_id = p1.category_id
      AND p2.price > p1.price
);
10 SELECT name, salary, department_id
FROM employees AS E
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND salary < (
      SELECT MAX(salary)
      FROM employees AS M
      WHERE M.department_id = E.department_id
  );
