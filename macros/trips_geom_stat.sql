{% macro trips_geom_stat(source_relation, geom_col='finish_point', grid=10) %}
(
    SELECT
        ST_Transform(hex.geom, 4326) AS geom,
        COUNT(*) AS trips
    FROM
        {{ source_relation }} AS t
    CROSS JOIN LATERAL
        ST_HexagonGrid(
            {{ grid }},
            ST_Transform(t.{{ geom_col }}, 3857)
        ) AS hex
    WHERE
        ST_Intersects(
            ST_Transform(t.{{ geom_col }}, 3857),
            hex.geom
        )
    GROUP BY
        hex.geom
)
{% endmacro %}