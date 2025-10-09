SELECT
    id,
    ST_SETSRID(ST_MAKEPOINT(start_lon, start_lat), 4326) AS start_point,
    ST_SETSRID(ST_MAKEPOINT(finish_lon, finish_lat), 4326) AS finish_point
FROM
    {{ source("scooters_raw", "trips") }}
