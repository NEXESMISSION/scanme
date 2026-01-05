-- Add Sample Images to Categories and Items
-- Run this after running add_category_images.sql
-- Uses placeholder images from Unsplash

-- =============================================
-- CATEGORY IMAGES
-- =============================================

-- Coffee Shop Categories
UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400&h=300&fit=crop'
WHERE name = 'Hot Drinks' AND business_id = (SELECT id FROM businesses WHERE slug = 'test123456');

UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400&h=300&fit=crop'
WHERE name = 'Cold Drinks' AND business_id = (SELECT id FROM businesses WHERE slug = 'test123456');

UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=400&h=300&fit=crop'
WHERE name = 'Pastries & Snacks' AND business_id = (SELECT id FROM businesses WHERE slug = 'test123456');

-- Restaurant Categories
UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=300&fit=crop'
WHERE name = 'Starters' AND business_id = (SELECT id FROM businesses WHERE slug = '12345678');

UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=300&fit=crop'
WHERE name = 'Main Courses' AND business_id = (SELECT id FROM businesses WHERE slug = '12345678');

UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=400&h=300&fit=crop'
WHERE name = 'Desserts' AND business_id = (SELECT id FROM businesses WHERE slug = '12345678');

UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=400&h=300&fit=crop'
WHERE name = 'Beverages' AND business_id = (SELECT id FROM businesses WHERE slug = '12345678');

-- Bakery Categories
UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&h=300&fit=crop'
WHERE name = 'Fresh Breads' AND business_id = (SELECT id FROM businesses WHERE slug = 'test123457');

UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400&h=300&fit=crop'
WHERE name = 'Cakes & Tarts' AND business_id = (SELECT id FROM businesses WHERE slug = 'test123457');

UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=400&h=300&fit=crop'
WHERE name = 'Cookies & Pastries' AND business_id = (SELECT id FROM businesses WHERE slug = 'test123457');

UPDATE categories SET image_url = 'https://images.unsplash.com/photo-1486427944544-d2c6a43f5205?w=400&h=300&fit=crop'
WHERE name = 'Special Orders' AND business_id = (SELECT id FROM businesses WHERE slug = 'test123457');


-- =============================================
-- ITEM IMAGES (Sample - just a few key items)
-- =============================================

-- Coffee Shop Items
UPDATE items SET image_url = 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=200&h=200&fit=crop'
WHERE name = 'Espresso';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=200&h=200&fit=crop'
WHERE name = 'Cappuccino';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=200&h=200&fit=crop'
WHERE name = 'Latte';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=200&h=200&fit=crop'
WHERE name = 'Croissant';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1486427944544-d2c6a43f5205?w=200&h=200&fit=crop'
WHERE name = 'Cold Brew';

-- Restaurant Items
UPDATE items SET image_url = 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=200&h=200&fit=crop'
WHERE name = 'Caesar Salad';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=200&h=200&fit=crop'
WHERE name = 'Grilled Salmon';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=200&h=200&fit=crop'
WHERE name = 'Ribeye Steak';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=200&h=200&fit=crop'
WHERE name = 'Mushroom Risotto';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=200&h=200&fit=crop'
WHERE name = 'Tiramisu';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=200&h=200&fit=crop'
WHERE name = 'Chocolate Lava Cake';

-- Bakery Items
UPDATE items SET image_url = 'https://images.unsplash.com/photo-1585478259715-4a2f1e3b6c58?w=200&h=200&fit=crop'
WHERE name = 'Sourdough Loaf';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?w=200&h=200&fit=crop'
WHERE name = 'French Baguette';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=200&h=200&fit=crop'
WHERE name = 'Chocolate Ganache Cake';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=200&h=200&fit=crop'
WHERE name = 'Chocolate Chip Cookie';

UPDATE items SET image_url = 'https://images.unsplash.com/photo-1509365465985-25d11c17e812?w=200&h=200&fit=crop'
WHERE name = 'Macarons (Box of 6)';

-- Verify updates
SELECT 
    c.name as category,
    c.image_url as category_image,
    COUNT(i.image_url) as items_with_images
FROM categories c
LEFT JOIN items i ON i.category_id = c.id AND i.image_url IS NOT NULL
GROUP BY c.id, c.name, c.image_url
ORDER BY c.name;

