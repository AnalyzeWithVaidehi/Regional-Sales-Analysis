-- ============================================================
-- SQL CLEANUP FILE
-- Regional Sales Analysis — sales_hybrid_db
-- ============================================================
-- PIPELINE NOTE:
-- sales_orders is loaded and pre-cleaned via Python (see 05_notebooks/Data_Import.ipynb)
-- Numeric columns and OrderDate are already correct datatypes after Python import. 
-- Steps 2 and 3 below are kept for documentation — they show what the data problem was and how it was diagnosed.
-- Only Step 4 (budgets_2026) and Step 5 (view creation) need to be run manually.
-- ============================================================

-- ============================================================
-- STEP 1: DISABLE SAFE UPDATES
-- ============================================================
SET SQL_SAFE_UPDATES = 0;

-- ============================================================
-- STEP 2: CLEAN NUMERIC COLUMNS
-- (documentation only — already handled by Data_Import.ipynb)
-- Root cause: Unit Price stored as text with comma formatting e.g. "2,499.10" → MySQL CAST silently truncates to 2
-- 79% of rows (50,352) were affected — all prices above $1,000
-- This caused total revenue to show $66.6M instead of $1.24B
-- Fix: strip commas before converting to DECIMAL

UPDATE sales_orders SET `Unit Price` = REPLACE(`Unit Price`, ',', '');
UPDATE sales_orders SET `Line Total` = REPLACE(`Line Total`, ',', '');
UPDATE sales_orders SET `Total Unit Cost` = REPLACE(`Total Unit Cost`, ',', '');

-- verify all return 0 before altering
SELECT COUNT(*) FROM sales_orders WHERE `Unit Price` REGEXP '[^0-9.]';
SELECT COUNT(*) FROM sales_orders WHERE `Line Total` REGEXP '[^0-9.]';
SELECT COUNT(*) FROM sales_orders WHERE `Total Unit Cost` REGEXP '[^0-9.]';

-- convert to correct numeric types
ALTER TABLE sales_orders 
  MODIFY COLUMN `Unit Price` DECIMAL(10,2),
  MODIFY COLUMN `Line Total` DECIMAL(12,2),
  MODIFY COLUMN `Total Unit Cost` DECIMAL(10,2);

-- convert index and quantity columns to int
ALTER TABLE sales_orders 
  MODIFY COLUMN `Customer Name Index` INT,
  MODIFY COLUMN `Delivery Region Index` INT,
  MODIFY COLUMN `Product Description Index` INT,
  MODIFY COLUMN `Order Quantity` INT;

-- sanity check after conversion
SELECT MAX(`Unit Price`), MIN(`Unit Price`), AVG(`Unit Price`) FROM sales_orders;
-- MAX must be ~6566, MIN must not be 1
SELECT `Unit Price` FROM sales_orders ORDER BY `Unit Price` DESC LIMIT 10;

-- ============================================================
-- STEP 3: CONVERT ORDERDATE
-- (documentation only — already handled by Data_Import.ipynb)
-- Source data format: MM/DD/YYYY (US format)
-- Must use explicit STR_TO_DATE — never let MySQL guess format Indian locale (DD/MM/YYYY) would silently corrupt dates

-- verify format is consistent, should return 0
SELECT COUNT(*) FROM sales_orders 
WHERE STR_TO_DATE(OrderDate, '%m/%d/%Y') IS NULL;

-- rewrite and convert
UPDATE sales_orders SET OrderDate = STR_TO_DATE(OrderDate, '%m/%d/%Y');
ALTER TABLE sales_orders MODIFY COLUMN OrderDate DATE;

-- sanity check the range
SELECT MIN(OrderDate), MAX(OrderDate) FROM sales_orders;
-- expected: 2022-01-01 to 2026-02-28

-- ============================================================
-- STEP 4: FIX budgets_2026 — RUN THIS MANUALLY
-- (loaded via Workbench wizard, needs SQL cleanup)

-- check for formatting issues first
SELECT DISTINCT `2026 Budgets` 
FROM budgets_2026 
WHERE `2026 Budgets` REGEXP '[^0-9.]' 
LIMIT 10;

-- clean and convert
UPDATE budgets_2026 SET `2026 Budgets` = REPLACE(`2026 Budgets`, ',', '');
ALTER TABLE budgets_2026 MODIFY COLUMN `2026 Budgets` DOUBLE;

-- verify product names match products table for future joins
-- must return 0 rows
SELECT b.`Product Name` 
FROM budgets_2026 b 
LEFT JOIN products p ON b.`Product Name` = p.`Product Name` 
WHERE p.`Product Name` IS NULL;

-- ============================================================
-- STEP 5: VALIDATION CHECKS

-- channel: check for casing/whitespace duplicates
SELECT DISTINCT Channel, COUNT(*) 
FROM sales_orders 
GROUP BY Channel;

-- orphaned foreign keys: all three must return 0
SELECT COUNT(*) FROM sales_orders s 
LEFT JOIN products p ON s.`Product Description Index` = p.`Index` 
WHERE p.`Index` IS NULL;

SELECT COUNT(*) FROM sales_orders s 
LEFT JOIN customers c ON s.`Customer Name Index` = c.`Customer Index` 
WHERE c.`Customer Index` IS NULL;

SELECT COUNT(*) FROM sales_orders s 
LEFT JOIN regions r ON s.`Delivery Region Index` = r.id 
WHERE r.id IS NULL;

-- ============================================================
-- STEP 6: CREATE MASTER VIEW
-- ============================================================
DROP VIEW IF EXISTS v_master_sales_report;

CREATE OR REPLACE VIEW v_master_sales_report AS
SELECT 
    s.OrderNumber,
    s.OrderDate,
    c.`Customer Names`                    AS Customer,
    p.`Product Name`                      AS Product,
    r.state                               AS State,
    r.name                                AS City,
    s.`Order Quantity`                    AS Qty,
    s.`Unit Price`                        AS Price,
    (s.`Order Quantity` * s.`Unit Price`) AS Revenue
FROM sales_orders s
LEFT JOIN customers c ON s.`Customer Name Index`       = c.`Customer Index`
LEFT JOIN products p  ON s.`Product Description Index` = p.`Index`
LEFT JOIN regions r   ON s.`Delivery Region Index`     = r.id;

-- ============================================================
-- STEP 7: FINAL SANITY CHECK
-- ============================================================

-- revenue must be ~1,235,968,899
SELECT SUM(Revenue) FROM v_master_sales_report;

-- line total cross check: must return 0
-- verifies Order Quantity x Unit Price matches stored Line Total
SELECT COUNT(*) 
FROM sales_orders 
WHERE ROUND(`Order Quantity` * `Unit Price`, 2) <> `Line Total`;