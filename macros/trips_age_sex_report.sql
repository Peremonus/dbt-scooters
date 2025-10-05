{% macro trips_age_sex_report(trips_table, granularity) %}
{%- set time_column -%}
    {%- if granularity == 'daily' -%}
        "date"
    {%- elif granularity == 'weekly' -%}
        date_trunc('week', "date")::date as "week"
    {%- elif granularity == 'monthly' -%}
        date_trunc('month', "date")::date as "month"
    {%- else -%}
        {{ exceptions.raise_compiler_error("Invalid granularity: " ~ granularity) }}
    {%- endif -%}
{%- endset -%}

SELECT
    {{ time_column }},
    age,
    COALESCE(sex, 'UNKNOWN') as sex,
    COUNT(*) as trips,
    SUM(price_rub) as revenue_rub
FROM
    {{ trips_table }}
GROUP BY
    1, 2, 3
{% endmacro %}