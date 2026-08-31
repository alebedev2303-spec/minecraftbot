-- Таблица категорий (чтобы не писать "Блоки", "Еда" каждый раз вручную)
CREATE TABLE IF NOT EXISTS item_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Основная таблица магазина
CREATE TABLE IF NOT EXISTS shop_items (
    id BIGSERIAL PRIMARY KEY,
    
    -- Ссылка на категорию
    category_id INT REFERENCES item_categories(id),
    
    -- Название предмета как оно будет отображаться
    name_ru VARCHAR(255) NOT NULL,
    
    -- Уникальный ключ (для поиска кодом, если понадобится)
    key VARCHAR(255) UNIQUE NOT NULL,
    
    price NUMERIC(10, 2) NOT NULL,          -- Цена за указанную партию
    amount_in_batch INTEGER NOT NULL,       -- Количество штук в этой цене (64, 16, 1...)
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Индексы для быстрого поиска по названию
CREATE INDEX IF NOT EXISTS idx_shop_items_name ON shop_items(name_ru);
CREATE INDEX IF NOT EXISTS idx_shop_items_key ON shop_items(key);

-- Заполняем категории (один раз)
INSERT INTO item_categories (name) VALUES 
('Блоки'), ('Предметы'), ('Руды и слитки'), ('Еда и растения'), ('Моб-дропы'), 
('Инструменты и оружие'), ('Красители'), ('Механизмы'), ('Магия и редкости'), ('Отделки')
ON CONFLICT DO NOTHING; -- Чтобы не было ошибки при повторном запуске
