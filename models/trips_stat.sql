SELECT 
    -- Общее количество всех поездок в таблице
    -- COUNT(*) подсчитывает все строки, независимо от значений
    COUNT(*) AS trips,
    
    -- Количество уникальных пользователей
    -- COUNT(DISTINCT user_id) считает только уникальные значения user_id
    -- DISTINCT исключает повторяющиеся user_id из подсчета
    COUNT(DISTINCT user_id) AS users,
    
    -- Средняя длительность поездки в минутах с округлением до 2 знаков
    -- EXTRACT(EPOCH FROM (finished_at - started_at)): 
    --   finished_at - started_at = разница во времени как interval
    --   EXTRACT(EPOCH FROM ...) преобразует interval в количество секунд
    --   / 60 - преобразуем секунды в минуты
    -- AVG(...) - вычисляет среднее арифметическое
    -- ROUND(..., 2) - округляет результат до 2 десятичных знаков
    -- ::numeric - явное приведение типа для корректного округления
    ROUND(AVG(EXTRACT(EPOCH FROM (finished_at - started_at)) / 60)::numeric, 2) AS avg_duration_m,
    
    -- Суммарная выручка в рублях
    -- SUM(price) складывает все значения в столбце price
    -- Предполагается, что price хранится в рублях
    SUM(price) AS revenue_rub,
    
    -- Процент бесплатных поездок (с нулевой стоимостью) от общего числа
    -- COUNT(CASE WHEN price = 0 THEN 1 END): 
    --   CASE WHEN price = 0 THEN 1 END - для бесплатных поездок возвращает 1, для остальных NULL
    --   COUNT считает только не-NULL значения, т.е. только бесплатные поездки
    -- * 100.0 - умножение на 100.0 (дробное число) для получения процента
    -- / COUNT(*) - деление на общее количество поездок
    -- ROUND(..., 2) - округление до 2 десятичных знаков
    ROUND((COUNT(CASE WHEN price = 0 THEN 1 END) * 100.0 / COUNT(*))::numeric, 2) AS free_trips_pct

-- Указываем полное имя таблицы со схемой
-- scooters_raw - имя схемы (namespace) в базе данных
-- trips - имя таблицы с данными о поездках
FROM scooters_raw.trips