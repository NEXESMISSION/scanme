-- Simplified Sample Data - Creates businesses for existing users
-- This version is easier to use if you want to specify user IDs manually

-- ============================================
-- STEP 1: Get Your User ID
-- ============================================
-- Run this first to see available users:
-- SELECT id, email FROM auth.users;

-- ============================================
-- STEP 2: Replace USER_ID with actual ID
-- ============================================
-- Replace 'USER_ID_1', 'USER_ID_2', 'USER_ID_3' below with actual user IDs
-- OR use the same user ID for all businesses

-- ============================================
-- COFFEE SHOP
-- ============================================

-- Get first user's ID (you can change this)
DO $$
DECLARE
    v_user_id uuid;
    v_business_id uuid;
    v_category_id uuid;
BEGIN
    -- Get first user
    SELECT id INTO v_user_id FROM auth.users LIMIT 1;
    
    -- Create business
    INSERT INTO businesses (owner_id, name, slug, theme_id, status)
    VALUES (v_user_id, 'Brew & Bean Cafe', 'brew-bean-cafe', 'classic', 'active')
    RETURNING id INTO v_business_id;
    
    -- Hot Beverages
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Hot Beverages', 1)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Espresso', 'Strong Italian coffee shot', 3.50, true),
        (v_category_id, 'Cappuccino', 'Espresso with steamed milk and foam', 4.75, true),
        (v_category_id, 'Latte', 'Espresso with steamed milk', 5.00, true),
        (v_category_id, 'Americano', 'Espresso with hot water', 3.75, true);
    
    -- Cold Beverages
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Cold Beverages', 2)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Iced Coffee', 'Cold brewed coffee served over ice', 4.25, true),
        (v_category_id, 'Frappuccino', 'Blended coffee with ice and flavor', 5.50, true);
    
    -- Pastries
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Pastries', 3)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Croissant', 'Fresh butter croissant', 3.25, true),
        (v_category_id, 'Blueberry Muffin', 'Homemade blueberry muffin', 3.75, true);
END $$;

-- ============================================
-- RESTAURANT
-- ============================================

DO $$
DECLARE
    v_user_id uuid;
    v_business_id uuid;
    v_category_id uuid;
BEGIN
    SELECT id INTO v_user_id FROM auth.users LIMIT 1;
    
    INSERT INTO businesses (owner_id, name, slug, theme_id, status)
    VALUES (v_user_id, 'Mama Mia Italian', 'mama-mia-italian', 'minimal', 'active')
    RETURNING id INTO v_business_id;
    
    -- Appetizers
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Appetizers', 1)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Bruschetta', 'Toasted bread with tomatoes, garlic, and basil', 8.50, true),
        (v_category_id, 'Mozzarella Sticks', 'Fried mozzarella with marinara sauce', 9.00, true),
        (v_category_id, 'Caesar Salad', 'Fresh romaine, parmesan, croutons', 10.50, true);
    
    -- Main Courses
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Main Courses', 2)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Spaghetti Carbonara', 'Classic pasta with eggs, pancetta, parmesan', 16.50, true),
        (v_category_id, 'Margherita Pizza', 'Fresh mozzarella, tomato sauce, basil', 14.00, true),
        (v_category_id, 'Chicken Parmesan', 'Breaded chicken with marinara and mozzarella', 18.00, true),
        (v_category_id, 'Lasagna', 'Layers of pasta, meat sauce, and cheese', 17.50, true);
    
    -- Desserts
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Desserts', 3)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Tiramisu', 'Classic Italian dessert', 7.50, true),
        (v_category_id, 'Cannoli', 'Crispy shell with sweet ricotta', 6.50, true);
END $$;

-- ============================================
-- BAKERY
-- ============================================

DO $$
DECLARE
    v_user_id uuid;
    v_business_id uuid;
    v_category_id uuid;
BEGIN
    SELECT id INTO v_user_id FROM auth.users LIMIT 1;
    
    INSERT INTO businesses (owner_id, name, slug, theme_id, status)
    VALUES (v_user_id, 'Sweet Dreams Bakery', 'sweet-dreams-bakery', 'dark', 'active')
    RETURNING id INTO v_business_id;
    
    -- Cakes
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Cakes', 1)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Chocolate Cake (Slice)', 'Rich chocolate cake with buttercream', 5.50, true),
        (v_category_id, 'Vanilla Cake (Slice)', 'Classic vanilla with vanilla frosting', 5.00, true),
        (v_category_id, 'Red Velvet (Slice)', 'Southern classic with cream cheese', 6.00, true),
        (v_category_id, 'Cheesecake (Slice)', 'New York style cheesecake', 6.50, true);
    
    -- Cookies
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Cookies & Pastries', 2)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Chocolate Chip Cookies (3pc)', 'Fresh baked cookies', 4.50, true),
        (v_category_id, 'Macarons (6pc)', 'French macarons, assorted flavors', 8.00, true),
        (v_category_id, 'Éclair', 'Chocolate éclair with vanilla cream', 4.75, true);
    
    -- Breads
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Fresh Breads', 3)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Sourdough Loaf', 'Artisan sourdough bread', 6.00, true),
        (v_category_id, 'French Baguette', 'Traditional French baguette', 4.50, true),
        (v_category_id, 'Cinnamon Rolls (2pc)', 'Warm cinnamon rolls with glaze', 5.75, true);
END $$;

-- ============================================
-- VERIFICATION
-- ============================================
-- Check what was created:
SELECT 
    b.name as business_name,
    b.slug,
    COUNT(DISTINCT c.id) as category_count,
    COUNT(i.id) as item_count
FROM businesses b
LEFT JOIN categories c ON c.business_id = b.id
LEFT JOIN items i ON i.category_id = c.id
WHERE b.slug IN ('brew-bean-cafe', 'mama-mia-italian', 'sweet-dreams-bakery')
GROUP BY b.id, b.name, b.slug
ORDER BY b.name;

