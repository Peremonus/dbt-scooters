{% macro check_diff() %}
    select * from dbt_dev.book_scooter_retention
    except
    select * from dbt.book_scooter_retention
{% endmacro %}