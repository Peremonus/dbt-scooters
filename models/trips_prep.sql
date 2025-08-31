SELECT
    id,
    user_id,
    scooter_hw_id,
    started_at,
    finished_at,
    start_lat,
    start_lon,
    finish_lat,
    finish_lon,
    -- Переименовываем distance в distance_m для ясности (метры)
    distance AS distance_m,
    -- Конвертируем цену из копеек в рубли с округлением до 2 знаков
    CAST(price AS DECIMAL(20, 2)) / 100 AS price_rub,
    -- Вычисляем длительность поездки в секундах
    EXTRACT(EPOCH FROM (finished_at - started_at)) AS duration_s,
    -- Флаг бесплатной поездки: закончена, не мгновенная и цена = 0
    finished_at <> started_at AND price = 0 AS is_free,
    -- Дата начала поездки (без времени)
    DATE(started_at) AS date
FROM
    {{ source("scooters_raw", "trips") }}