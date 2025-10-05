SELECT
    *
FROM
    {{ ref("revenue_monthly") }}
WHERE
    "month" < date_trunc('month', current_date)
    {%- if is_incremental() %}
        AND "month" > (SELECT MAX("month") FROM {{ this }})
    {%- else -%}
        AND "month" = (SELECT MIN("month") FROM {{ ref("revenue_monthly") }})
    {% endif -%}
    AND NOT(users < 1000 OR revenue_median < 500)