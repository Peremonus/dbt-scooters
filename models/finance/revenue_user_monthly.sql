SELECT
    user_id,
    date(date_trunc('month', "date")) AS "month",
    sum(price_rub) AS revenue_total
FROM
    {{ ref("trips_users") }}
WHERE
    NOT is_free
GROUP BY
    1, 2