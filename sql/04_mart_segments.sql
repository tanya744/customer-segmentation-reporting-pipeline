CREATE TABLE IF NOT EXISTS mart_segments AS
WITH scored AS (
    SELECT
        customer_id,
        recency_days,
        frequency,
        monetary,

        NTILE(5) OVER (ORDER BY recency_days ASC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary DESC) AS m_score

    FROM mart_rfm
)

SELECT
    *,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 4 AND f_score >= 3 THEN 'Loyal'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'New Customers'
        ELSE 'Regular'
    END AS segment
FROM scored;