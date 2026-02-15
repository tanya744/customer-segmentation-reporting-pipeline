CREATE TABLE IF NOT EXISTS stg_orders AS
SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date
FROM raw_orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;