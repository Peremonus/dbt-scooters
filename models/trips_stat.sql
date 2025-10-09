SELECT
    -- Общее количество поездок
    COUNT(*) AS trips,

    -- Количество уникальных пользователей
    COUNT(DISTINCT user_id) AS users,

    -- Средняя продолжительность поездки в минутах
    AVG(duration_s) / 60 AS avg_duration_min,

    -- Общая дистанция в километрах
    SUM(distance_m) / 1000 AS sum_distance_km,

    -- Общая выручка в рублях
    SUM(price_rub) AS revenue_rub,

    -- Процент бесплатных поездок
    -- Используем "is_free or null" для подсчета только true значений
    COUNT(is_free OR NULL) / CAST(COUNT(*) AS REAL) * 100 AS free_trips_pct

FROM
    {{ ref("trips_prep") }}
