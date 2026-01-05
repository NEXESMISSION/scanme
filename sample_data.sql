-- Sample Data for QR Menu Builder
-- Creates 3 businesses with menus: Coffee Shop, Restaurant, and Bakery
-- Run this after setting up your database

-- ============================================
-- IMPORTANT: Before Running
-- ============================================
-- 1. Make sure you have at least one user in auth.users
-- 2. Replace 'YOUR_USER_ID_HERE' with an actual user_id from auth.users
-- 3. To get a user_id, run: SELECT id, email FROM auth.users;
-- 4. Or create a user through signup first, then get their ID

-- ============================================
-- Get User IDs (Run this first to get IDs)
-- ============================================
-- SELECT id, email FROM auth.users;

-- ============================================
-- COFFEE SHOP - "Brew & Bean Cafe"
-- ============================================

-- Insert Coffee Shop Business
-- Replace 'USER_ID_1' with actual user_id
INSERT INTO businesses (owner_id, name, slug, theme_id, status)
VALUES (
    (SELECT id FROM auth.users LIMIT 1 OFFSET 0),  -- First user
    'Brew & Bean Cafe',
    'brew-bean-cafe',
    'classic',
    'active'
)
RETURNING id;

-- Coffee Shop Categories and Items
-- Hot Beverages
INSERT INTO categories (business_id, name, position)
SELECT 
    id,
    'Hot Beverages',
    1
FROM businesses WHERE slug = 'brew-bean-cafe'
RETURNING id;

INSERT INTO items (category_id, name, description, price, available)
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 1),
    'Espresso',
    'Strong Italian coffee shot',
    3.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 1),
    'Cappuccino',
    'Espresso with steamed milk and foam',
    4.75,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 1),
    'Latte',
    'Espresso with steamed milk',
    5.00,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 1),
    'Americano',
    'Espresso with hot water',
    3.75,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 1),
    'Hot Chocolate',
    'Rich Belgian chocolate',
    4.50,
    true;

-- Cold Beverages
INSERT INTO categories (business_id, name, position)
SELECT 
    id,
    'Cold Beverages',
    2
FROM businesses WHERE slug = 'brew-bean-cafe'
RETURNING id;

INSERT INTO items (category_id, name, description, price, available)
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 2),
    'Iced Coffee',
    'Cold brewed coffee served over ice',
    4.25,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 2),
    'Frappuccino',
    'Blended coffee with ice and flavor',
    5.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 2),
    'Iced Tea',
    'Refreshing iced tea, various flavors',
    3.50,
    true;

-- Pastries & Snacks
INSERT INTO categories (business_id, name, position)
SELECT 
    id,
    'Pastries & Snacks',
    3
FROM businesses WHERE slug = 'brew-bean-cafe'
RETURNING id;

INSERT INTO items (category_id, name, description, price, available)
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 3),
    'Croissant',
    'Fresh butter croissant',
    3.25,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 3),
    'Blueberry Muffin',
    'Homemade blueberry muffin',
    3.75,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'brew-bean-cafe') AND position = 3),
    'Bagel with Cream Cheese',
    'Fresh bagel with cream cheese',
    4.50,
    true;

-- ============================================
-- RESTAURANT - "Mama Mia Italian"
-- ============================================

-- Insert Restaurant Business
-- Replace with second user if you have multiple users, otherwise use same user
INSERT INTO businesses (owner_id, name, slug, theme_id, status)
VALUES (
    (SELECT id FROM auth.users LIMIT 1 OFFSET 0),  -- First user (or change OFFSET for different user)
    'Mama Mia Italian',
    'mama-mia-italian',
    'minimal',
    'active'
)
RETURNING id;

-- Appetizers
INSERT INTO categories (business_id, name, position)
SELECT 
    id,
    'Appetizers',
    1
FROM businesses WHERE slug = 'mama-mia-italian'
RETURNING id;

INSERT INTO items (category_id, name, description, price, available)
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 1),
    'Bruschetta',
    'Toasted bread with tomatoes, garlic, and basil',
    8.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 1),
    'Mozzarella Sticks',
    'Fried mozzarella with marinara sauce',
    9.00,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 1),
    'Caesar Salad',
    'Fresh romaine, parmesan, croutons, caesar dressing',
    10.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 1),
    'Antipasto Platter',
    'Selection of Italian meats, cheeses, and vegetables',
    14.00,
    true;

-- Main Courses
INSERT INTO categories (business_id, name, position)
SELECT 
    id,
    'Main Courses',
    2
FROM businesses WHERE slug = 'mama-mia-italian'
RETURNING id;

INSERT INTO items (category_id, name, description, price, available)
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 2),
    'Spaghetti Carbonara',
    'Classic pasta with eggs, pancetta, and parmesan',
    16.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 2),
    'Margherita Pizza',
    'Fresh mozzarella, tomato sauce, basil',
    14.00,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 2),
    'Chicken Parmesan',
    'Breaded chicken breast with marinara and mozzarella',
    18.00,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 2),
    'Lasagna',
    'Layers of pasta, meat sauce, and cheese',
    17.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 2),
    'Risotto ai Funghi',
    'Creamy risotto with mushrooms',
    16.00,
    true;

-- Desserts
INSERT INTO categories (business_id, name, position)
SELECT 
    id,
    'Desserts',
    3
FROM businesses WHERE slug = 'mama-mia-italian'
RETURNING id;

INSERT INTO items (category_id, name, description, price, available)
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 3),
    'Tiramisu',
    'Classic Italian dessert with coffee and mascarpone',
    7.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 3),
    'Cannoli',
    'Crispy shell filled with sweet ricotta',
    6.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'mama-mia-italian') AND position = 3),
    'Gelato',
    'Italian ice cream, various flavors',
    5.50,
    true;

-- ============================================
-- BAKERY - "Sweet Dreams Bakery"
-- ============================================

-- Insert Bakery Business
INSERT INTO businesses (owner_id, name, slug, theme_id, status)
VALUES (
    (SELECT id FROM auth.users LIMIT 1 OFFSET 0),  -- First user (or change OFFSET for different user)
    'Sweet Dreams Bakery',
    'sweet-dreams-bakery',
    'dark',
    'active'
)
RETURNING id;

-- Cakes
INSERT INTO categories (business_id, name, position)
SELECT 
    id,
    'Cakes',
    1
FROM businesses WHERE slug = 'sweet-dreams-bakery'
RETURNING id;

INSERT INTO items (category_id, name, description, price, available)
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 1),
    'Chocolate Cake (Slice)',
    'Rich chocolate cake with buttercream frosting',
    5.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 1),
    'Vanilla Cake (Slice)',
    'Classic vanilla cake with vanilla frosting',
    5.00,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 1),
    'Red Velvet (Slice)',
    'Southern classic with cream cheese frosting',
    6.00,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 1),
    'Cheesecake (Slice)',
    'New York style cheesecake',
    6.50,
    true;

-- Cookies & Pastries
INSERT INTO categories (business_id, name, position)
SELECT 
    id,
    'Cookies & Pastries',
    2
FROM businesses WHERE slug = 'sweet-dreams-bakery'
RETURNING id;

INSERT INTO items (category_id, name, description, price, available)
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 2),
    'Chocolate Chip Cookies (3pc)',
    'Fresh baked chocolate chip cookies',
    4.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 2),
    'Sugar Cookies (6pc)',
    'Decorated sugar cookies',
    5.00,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 2),
    'Macarons (6pc)',
    'French macarons, assorted flavors',
    8.00,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 2),
    'Éclair',
    'Chocolate éclair filled with vanilla cream',
    4.75,
    true;

-- Breads
INSERT INTO categories (business_id, name, position)
SELECT 
    id,
    'Fresh Breads',
    3
FROM businesses WHERE slug = 'sweet-dreams-bakery'
RETURNING id;

INSERT INTO items (category_id, name, description, price, available)
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 3),
    'Sourdough Loaf',
    'Artisan sourdough bread',
    6.00,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 3),
    'French Baguette',
    'Traditional French baguette',
    4.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 3),
    'Multigrain Bread',
    'Healthy multigrain loaf',
    5.50,
    true
UNION ALL
SELECT 
    (SELECT id FROM categories WHERE business_id = (SELECT id FROM businesses WHERE slug = 'sweet-dreams-bakery') AND position = 3),
    'Cinnamon Rolls (2pc)',
    'Warm cinnamon rolls with glaze',
    5.75,
    true;

-- ============================================
-- VERIFICATION
-- ============================================
-- After running, verify data:
-- 
-- SELECT b.name, b.slug, COUNT(DISTINCT c.id) as categories, COUNT(i.id) as items
-- FROM businesses b
-- LEFT JOIN categories c ON c.business_id = b.id
-- LEFT JOIN items i ON i.category_id = c.id
-- GROUP BY b.id, b.name, b.slug;
--
-- You should see:
-- - brew-bean-cafe: 3 categories, ~10 items
-- - mama-mia-italian: 3 categories, ~12 items
-- - sweet-dreams-bakery: 3 categories, ~12 items

