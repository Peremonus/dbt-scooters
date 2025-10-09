SELECT
    month,
    COUNT(*) AS users,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY revenue_total)
        AS revenue_median,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY revenue_total) AS revenue_95,
    MAX(revenue_total) AS revenue_max,
    SUM(revenue_total) AS revenue_total
FROM
    {{ ref("revenue_user_monthly") }}
GROUP BY
    1
