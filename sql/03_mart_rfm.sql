CREATE TABLE IF NOT EXISTS mart_rfm AS
WITH customer_stats AS (
    SELECT
        customer_id,
        COUNT(order_id) AS frequency,
        SUM(total_revenue) AS monetary,
        MAX(order_purchase_timestamp) AS last_purchase
    FROM fct_orders
    GROUP BY customer_id
),

max_date AS (
    SELECT MAX(order_purchase_timestamp) AS max_purchase
    FROM fct_orders
)

SELECT
    c.customer_id,
    CAST((julianday(m.max_purchase) - julianday(c.last_purchase)) AS INTEGER) AS recency_days,
    c.frequency,
    c.monetary
FROM customer_stats c
CROSS JOIN max_date m;