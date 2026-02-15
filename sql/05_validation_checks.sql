-- 1) No negative revenue
SELECT COUNT(*) AS negative_revenue_orders
FROM fct_orders
WHERE total_revenue < 0;

-- 2) Each customer appears only once
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT customer_id) AS distinct_customers
FROM mart_segments;

-- 3) No NULL segments
SELECT COUNT(*) AS null_segments
FROM mart_segments
WHERE segment IS NULL;