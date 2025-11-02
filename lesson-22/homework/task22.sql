

-- 1. Running Total Sales per Customer
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data;


-- 2. Number of Orders per Product Category
SELECT 
    product_category,
    COUNT(*) AS total_orders
FROM sales_data
GROUP BY product_category;


-- 3. Maximum Total Amount per Product Category
SELECT 
    product_category,
    MAX(total_amount) AS max_total
FROM sales_data
GROUP BY product_category;


-- 4. Minimum Price per Product Category
SELECT 
    product_category,
    MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category;


-- 5. Moving Average of Sales (3-day window)
SELECT 
    order_date,
    total_amount,
    ROUND(AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS moving_avg
FROM sales_data;


-- 6. Total Sales per Region
SELECT 
    region,
    SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;


-- 7. Rank of Customers Based on Total Purchase
SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS total_purchase,
    DENSE_RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_by_purchase
FROM sales_data
GROUP BY customer_id, customer_name;


-- 8. Difference Between Current and Previous Sale per Customer
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS diff_from_prev
FROM sales_data;


-- 9. Top 3 Most Expensive Products per Category
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS rnk
    FROM sales_data
) t
WHERE rnk <= 3;


-- 10. Cumulative Sum of Sales per Region by Order Date
SELECT 
    region,
    order_date,
    SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS cumulative_sales
FROM sales_data;


------------------------------------------------------------
-- MEDIUM QUESTIONS
------------------------------------------------------------

-- 11. Cumulative Revenue per Product Category
SELECT 
    product_category,
    order_date,
    SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue
FROM sales_data;


-- 12. Sum of previous values (simple incremental running total)
CREATE TABLE #Nums (ID INT);
INSERT INTO #Nums VALUES (1),(2),(3),(4),(5);

SELECT 
    ID,
    SUM(ID) OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SumPreValues
FROM #Nums;


-- 13. Sum of previous values for each Value (OneColumn)
SELECT 
    Value,
    SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn;


-- 14. Customers who purchased from more than one category
SELECT 
    customer_id,
    customer_name,
    COUNT(DISTINCT product_category) AS category_count
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;


-- 15. Customers with above-average spending in their region
SELECT 
    customer_id,
    customer_name,
    region,
    total_amount,
    AVG(total_amount) OVER (PARTITION BY region) AS region_avg
FROM sales_data
WHERE total_amount > AVG(total_amount) OVER (PARTITION BY region);


-- 16. Rank customers by total spending within each region
SELECT 
    region,
    customer_id,
    customer_name,
    SUM(total_amount) AS total_spent,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS region_rank
FROM sales_data
GROUP BY region, customer_id, customer_name;


-- 17. Running total of total_amount for each customer
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS cumulative_sales
FROM sales_data;


-- 18. Monthly sales growth rate vs previous month
SELECT 
    FORMAT(order_date, 'yyyy-MM') AS sales_month,
    SUM(total_amount) AS monthly_sales,
    ROUND(
        (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM'))) 
        / NULLIF(LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')), 0) * 100, 2
    ) AS growth_rate
FROM sales_data
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY sales_month;


-- 19. Customers whose total_amount > previous order’s total
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_amount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date);


------------------------------------------------------------
-- HARD QUESTIONS
------------------------------------------------------------

-- 20. Products with price above average
SELECT 
    product_name,
    unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);


-- 21. Sum of val1 + val2 for each group (MyData)
SELECT 
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
             THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS Tot
FROM MyData;


-- 22. TheSumPuzzle – aggregate by ID
SELECT 
    ID,
    SUM(Cost) AS Cost,
    SUM(DISTINCT Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID;


-- 23. Seats – find missing seat gaps
SELECT 
    LAG(SeatNumber, 1, 0) OVER (ORDER BY SeatNumber) + 1 AS GapStart,
    SeatNumber - 1 AS GapEnd
FROM Seats
WHERE SeatNumber - LAG(SeatNumber, 1, 0) OVER (ORDER BY SeatNumber) > 1;
