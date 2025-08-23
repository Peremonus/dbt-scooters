WITH daily_trips_by_age AS (
    SELECT
        -- Вычисляем возраст пользователя на дату поездки в полных годах
        -- EXTRACT(YEAR FROM AGE(t.started_at, u.birth_date)) вычисляет разницу в годах
        -- между датой начала поездки и датой рождения пользователя
        EXTRACT(YEAR FROM AGE(t.started_at, u.birth_date))::integer AS age,
        
        -- Извлекаем дату начала поездки (без времени)
        DATE(t.started_at) AS date,
        
        -- Считаем количество поездок для каждой комбинации возраст-дата
        COUNT(*) AS daily_trips_count
    
    -- Объединяем таблицу поездок с таблицей пользователей
    FROM scooters_raw.trips AS t
    INNER JOIN scooters_raw.users AS u 
        ON t.user_id = u.id  -- Связываем по идентификатору пользователя
    
    -- Группируем по возрасту и дате для получения дневной статистики по возрастам
    GROUP BY 
        EXTRACT(YEAR FROM AGE(t.started_at, u.birth_date))::integer,
        DATE(t.started_at)
)

SELECT
    -- Возрастная группа
    age,
    
    -- Среднее количество дневных поездок для каждого возраста
    -- AVG(daily_trips_count) вычисляет среднее значение по всем дням для каждого возраста
    -- ROUND(..., 2) округляет до 2 десятичных знаков для читаемости
    ROUND(AVG(daily_trips_count)::numeric, 2) AS avg_daily_trips
    
FROM daily_trips_by_age

-- Группируем только по возрасту для финальной агрегации
GROUP BY age

-- Сортируем по возрасту для удобства чтения результатов
ORDER BY age