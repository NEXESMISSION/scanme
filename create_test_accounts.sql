-- Create Complete Test Accounts
-- This creates user accounts, profiles, businesses, and menus
-- IMPORTANT: This uses service role, so it must be run from Supabase Dashboard SQL Editor

-- ============================================
-- STEP 1: Create Auth Users (Manual Step Required)
-- ============================================
-- Supabase doesn't allow direct INSERT into auth.users via SQL
-- You have two options:

-- OPTION A: Create users through the app
-- 1. Go to http://localhost:3000/signup
-- 2. Sign up with these credentials:
--    - Email: coffee@test.com / Password: test123456
--    - Email: restaurant@test.com / Password: test123456
--    - Email: bakery@test.com / Password: test123456

-- OPTION B: Use Supabase Dashboard
-- 1. Go to Authentication > Users > Add User
-- 2. Create users with above emails

-- ============================================
-- STEP 2: After creating users, run this script
-- ============================================
-- This will create profiles, businesses, and menus for existing users

-- ============================================
-- COFFEE SHOP ACCOUNT
-- ============================================

DO $$
DECLARE
    v_user_id uuid;
    v_business_id uuid;
    v_category_id uuid;
BEGIN
    -- Get or create user (you need to create user first via signup or dashboard)
    SELECT id INTO v_user_id FROM auth.users WHERE email = 'coffee@test.com' LIMIT 1;
    
    IF v_user_id IS NULL THEN
        RAISE NOTICE 'User coffee@test.com not found. Please create user first via signup or dashboard.';
        RETURN;
    END IF;
    
    -- Create/Update profile
    INSERT INTO profiles (user_id, email, phone_number, role)
    VALUES (v_user_id, 'coffee@test.com', '+1234567890', 'owner')
    ON CONFLICT (user_id) DO UPDATE 
    SET phone_number = '+1234567890';
    
    -- Create business
    INSERT INTO businesses (owner_id, name, slug, theme_id, status)
    VALUES (v_user_id, 'Brew & Bean Cafe', 'brew-bean-cafe', 'classic', 'active')
    ON CONFLICT (slug) DO NOTHING
    RETURNING id INTO v_business_id;
    
    -- Get business ID if it already existed
    IF v_business_id IS NULL THEN
        SELECT id INTO v_business_id FROM businesses WHERE slug = 'brew-bean-cafe';
    END IF;
    
    -- Clear existing categories (if re-running)
    DELETE FROM categories WHERE business_id = v_business_id;
    
    -- Hot Beverages
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Hot Beverages', 1)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Espresso', 'Strong Italian coffee shot', 3.50, true),
        (v_category_id, 'Cappuccino', 'Espresso with steamed milk and foam', 4.75, true),
        (v_category_id, 'Latte', 'Espresso with steamed milk', 5.00, true),
        (v_category_id, 'Americano', 'Espresso with hot water', 3.75, true),
        (v_category_id, 'Mocha', 'Espresso with chocolate and steamed milk', 5.25, true);
    
    -- Cold Beverages
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Cold Beverages', 2)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Iced Coffee', 'Cold brewed coffee served over ice', 4.25, true),
        (v_category_id, 'Frappuccino', 'Blended coffee with ice and flavor', 5.50, true),
        (v_category_id, 'Iced Latte', 'Espresso with cold milk and ice', 4.75, true);
    
    -- Pastries & Snacks
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Pastries & Snacks', 3)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Croissant', 'Fresh butter croissant', 3.25, true),
        (v_category_id, 'Blueberry Muffin', 'Homemade blueberry muffin', 3.75, true),
        (v_category_id, 'Bagel with Cream Cheese', 'Fresh bagel with cream cheese', 4.50, true),
        (v_category_id, 'Chocolate Chip Cookie', 'Warm chocolate chip cookie', 2.50, true);
    
    RAISE NOTICE 'Coffee shop account created successfully!';
END $$;

-- ============================================
-- RESTAURANT ACCOUNT
-- ============================================

DO $$
DECLARE
    v_user_id uuid;
    v_business_id uuid;
    v_category_id uuid;
BEGIN
    SELECT id INTO v_user_id FROM auth.users WHERE email = 'restaurant@test.com' LIMIT 1;
    
    IF v_user_id IS NULL THEN
        RAISE NOTICE 'User restaurant@test.com not found. Please create user first.';
        RETURN;
    END IF;
    
    INSERT INTO profiles (user_id, email, phone_number, role)
    VALUES (v_user_id, 'restaurant@test.com', '+1234567891', 'owner')
    ON CONFLICT (user_id) DO UPDATE 
    SET phone_number = '+1234567891';
    
    INSERT INTO businesses (owner_id, name, slug, theme_id, status)
    VALUES (v_user_id, 'Mama Mia Italian', 'mama-mia-italian', 'minimal', 'active')
    ON CONFLICT (slug) DO NOTHING
    RETURNING id INTO v_business_id;
    
    IF v_business_id IS NULL THEN
        SELECT id INTO v_business_id FROM businesses WHERE slug = 'mama-mia-italian';
    END IF;
    
    DELETE FROM categories WHERE business_id = v_business_id;
    
    -- Appetizers
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Appetizers', 1)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Bruschetta', 'Toasted bread with tomatoes, garlic, and basil', 8.50, true),
        (v_category_id, 'Mozzarella Sticks', 'Fried mozzarella with marinara sauce', 9.00, true),
        (v_category_id, 'Caesar Salad', 'Fresh romaine, parmesan, croutons, caesar dressing', 10.50, true),
        (v_category_id, 'Antipasto Platter', 'Selection of Italian meats, cheeses, and vegetables', 14.00, true);
    
    -- Main Courses
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Main Courses', 2)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Spaghetti Carbonara', 'Classic pasta with eggs, pancetta, and parmesan', 16.50, true),
        (v_category_id, 'Margherita Pizza', 'Fresh mozzarella, tomato sauce, basil', 14.00, true),
        (v_category_id, 'Chicken Parmesan', 'Breaded chicken breast with marinara and mozzarella', 18.00, true),
        (v_category_id, 'Lasagna', 'Layers of pasta, meat sauce, and cheese', 17.50, true),
        (v_category_id, 'Risotto ai Funghi', 'Creamy risotto with mushrooms', 16.00, true),
        (v_category_id, 'Penne Arrabbiata', 'Spicy tomato sauce with penne pasta', 15.00, true);
    
    -- Desserts
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Desserts', 3)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Tiramisu', 'Classic Italian dessert with coffee and mascarpone', 7.50, true),
        (v_category_id, 'Cannoli', 'Crispy shell filled with sweet ricotta', 6.50, true),
        (v_category_id, 'Gelato', 'Italian ice cream, various flavors', 5.50, true);
    
    RAISE NOTICE 'Restaurant account created successfully!';
END $$;

-- ============================================
-- BAKERY ACCOUNT
-- ============================================

DO $$
DECLARE
    v_user_id uuid;
    v_business_id uuid;
    v_category_id uuid;
BEGIN
    SELECT id INTO v_user_id FROM auth.users WHERE email = 'bakery@test.com' LIMIT 1;
    
    IF v_user_id IS NULL THEN
        RAISE NOTICE 'User bakery@test.com not found. Please create user first.';
        RETURN;
    END IF;
    
    INSERT INTO profiles (user_id, email, phone_number, role)
    VALUES (v_user_id, 'bakery@test.com', '+1234567892', 'owner')
    ON CONFLICT (user_id) DO UPDATE 
    SET phone_number = '+1234567892';
    
    INSERT INTO businesses (owner_id, name, slug, theme_id, status)
    VALUES (v_user_id, 'Sweet Dreams Bakery', 'sweet-dreams-bakery', 'dark', 'active')
    ON CONFLICT (slug) DO NOTHING
    RETURNING id INTO v_business_id;
    
    IF v_business_id IS NULL THEN
        SELECT id INTO v_business_id FROM businesses WHERE slug = 'sweet-dreams-bakery';
    END IF;
    
    DELETE FROM categories WHERE business_id = v_business_id;
    
    -- Cakes
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Cakes', 1)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Chocolate Cake (Slice)', 'Rich chocolate cake with buttercream frosting', 5.50, true),
        (v_category_id, 'Vanilla Cake (Slice)', 'Classic vanilla cake with vanilla frosting', 5.00, true),
        (v_category_id, 'Red Velvet (Slice)', 'Southern classic with cream cheese frosting', 6.00, true),
        (v_category_id, 'Cheesecake (Slice)', 'New York style cheesecake', 6.50, true),
        (v_category_id, 'Carrot Cake (Slice)', 'Moist carrot cake with cream cheese frosting', 5.75, true);
    
    -- Cookies & Pastries
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Cookies & Pastries', 2)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Chocolate Chip Cookies (3pc)', 'Fresh baked chocolate chip cookies', 4.50, true),
        (v_category_id, 'Sugar Cookies (6pc)', 'Decorated sugar cookies', 5.00, true),
        (v_category_id, 'Macarons (6pc)', 'French macarons, assorted flavors', 8.00, true),
        (v_category_id, 'Éclair', 'Chocolate éclair filled with vanilla cream', 4.75, true),
        (v_category_id, 'Danish Pastry', 'Buttery pastry with fruit filling', 4.25, true);
    
    -- Breads
    INSERT INTO categories (business_id, name, position)
    VALUES (v_business_id, 'Fresh Breads', 3)
    RETURNING id INTO v_category_id;
    
    INSERT INTO items (category_id, name, description, price, available) VALUES
        (v_category_id, 'Sourdough Loaf', 'Artisan sourdough bread', 6.00, true),
        (v_category_id, 'French Baguette', 'Traditional French baguette', 4.50, true),
        (v_category_id, 'Multigrain Bread', 'Healthy multigrain loaf', 5.50, true),
        (v_category_id, 'Cinnamon Rolls (2pc)', 'Warm cinnamon rolls with glaze', 5.75, true),
        (v_category_id, 'Garlic Bread', 'Fresh bread with garlic butter', 4.00, true);
    
    RAISE NOTICE 'Bakery account created successfully!';
END $$;

-- ============================================
-- VERIFICATION
-- ============================================
-- Check all accounts created:
SELECT 
    u.email,
    p.phone_number,
    p.role,
    b.name as business_name,
    b.slug,
    b.theme_id,
    COUNT(DISTINCT c.id) as category_count,
    COUNT(i.id) as item_count
FROM auth.users u
LEFT JOIN profiles p ON p.user_id = u.id
LEFT JOIN businesses b ON b.owner_id = u.id
LEFT JOIN categories c ON c.business_id = b.id
LEFT JOIN items i ON i.category_id = c.id
WHERE u.email IN ('coffee@test.com', 'restaurant@test.com', 'bakery@test.com')
GROUP BY u.id, u.email, p.phone_number, p.role, b.id, b.name, b.slug, b.theme_id
ORDER BY u.email;

