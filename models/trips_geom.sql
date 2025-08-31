SELECT
    id,
    ST_SetSRID(ST_MakePoint(start_lon, start_lat), 4326) AS start_point,
    ST_SetSRID(ST_MakePoint(finish_lon, finish_lat), 4326) AS finish_point
FROM
    {{ source("scooters_raw", "trips") }}
