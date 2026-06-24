-- 1. row count
SELECT COUNT(*) FROM v_master_sales_report;
-- expected: 64104

-- 2. revenue
SELECT SUM(Revenue) FROM v_master_sales_report;
-- expected: ~1,235,968,899

-- 3. top 5 products
SELECT Product, SUM(Revenue) AS Total_Revenue
FROM v_master_sales_report
GROUP BY Product
ORDER BY Total_Revenue DESC
LIMIT 5;
-- expected: different from the old Products 25,26,13

-- 4. top 5 states
SELECT State, SUM(Revenue) AS Total_Revenue
FROM v_master_sales_report
GROUP BY State
ORDER BY Total_Revenue DESC
LIMIT 5;


-- 5. orphaned keys - all must be 0
SELECT COUNT(*) FROM v_master_sales_report WHERE Customer IS NULL;
SELECT COUNT(*) FROM v_master_sales_report WHERE Product IS NULL;

-- 6. date range
SELECT MIN(OrderDate), MAX(OrderDate) FROM v_master_sales_report;
-- expected: 2022-01-01 to 2026-02-28

-- 7. avg order value
SELECT AVG(Revenue) FROM v_master_sales_report;
-- will be very different from old $1,039.87