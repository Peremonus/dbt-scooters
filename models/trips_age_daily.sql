WITH date_age_cte AS (
    SELECT
        t.*,
        -- Вычисляем возраст пользователя на момент поездки
        EXTRACT(YEAR FROM t.started_at) - EXTRACT(YEAR FROM u.birth_date) AS age
    FROM
        {{ ref("trips_prep") }} AS t
    INNER JOIN
        {{ source("scooters_raw", "users") }} AS u
        ON t.user_id = u.id
)

SELECT
    -- Дата поездки
    "date",
    
    -- Возраст пользователя
    age,
    
    -- Количество поездок по дате и возрасту
    COUNT(*) AS trips,
    
    -- Суммарная выручка по дате и возрасту
    SUM(price_rub) AS revenue_rub

FROM
    date_age_cte

-- Группируем по дате и возрасту для анализа
GROUP BY
    "date",
    age

-- Сортируем по дате и возрасту
ORDER BY
    "date",
    age