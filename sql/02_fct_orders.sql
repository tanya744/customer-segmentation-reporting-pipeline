CREATE TABLE IF NOT EXISTS fct_orders AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM stg_orders o
JOIN raw_order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp;