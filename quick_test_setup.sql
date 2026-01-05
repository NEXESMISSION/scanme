-- Quick Test Setup: Creates everything for the first available user
-- Use this if you just want to create test data for your current account
-- Run this AFTER you've signed up at least once

DO $$
DECLARE
    v_user_id uuid;
    v_business_id uuid;
    v_category_id uuid;
    v_business_count int;
BEGIN
    -- Get the first user (your account)
    SELECT id INTO v_user_id FROM auth.users ORDER BY created_at LIMIT 1;
    
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'No users found. Please sign up first at /signup';
    END IF;
    
    -- Check how many businesses this user already has
    SELECT COUNT(*) INTO v_business_count 
    FROM businesses 
    WHERE owner_id = v_user_id;
    
    -- Create Coffee Shop
    INSERT INTO businesses (owner_id, name, slug, theme_id, status)
    VALUES (v_user_id, 'Brew & Bean Cafe', 'brew-bean-cafe', 'classic', 'active')
    ON CONFLICT (slug) DO NOTHING
    RETURNING id INTO v_business_id;
    
    IF v_business_id IS NOT NULL THEN
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
            (v_category_id, 'Iced Coffee', 'Cold brewed coffee', 4.25, true),
            (v_category_id, 'Frappuccino', 'Blended coffee with ice', 5.50, true);
        
        -- Pastries
        INSERT INTO categories (business_id, name, position)
        VALUES (v_business_id, 'Pastries', 3)
        RETURNING id INTO v_category_id;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
            (v_category_id, 'Croissant', 'Fresh butter croissant', 3.25, true),
            (v_category_id, 'Blueberry Muffin', 'Homemade muffin', 3.75, true);
    END IF;
    
    -- Create Restaurant (if user doesn't have one yet)
    IF v_business_count = 0 THEN
        INSERT INTO businesses (owner_id, name, slug, theme_id, status)
        VALUES (v_user_id, 'Mama Mia Italian', 'mama-mia-italian', 'minimal', 'active')
        ON CONFLICT (slug) DO NOTHING
        RETURNING id INTO v_business_id;
        
        IF v_business_id IS NOT NULL THEN
            -- Appetizers
            INSERT INTO categories (business_id, name, position)
            VALUES (v_business_id, 'Appetizers', 1)
            RETURNING id INTO v_category_id;
            
            INSERT INTO items (category_id, name, description, price, available) VALUES
                (v_category_id, 'Bruschetta', 'Toasted bread with tomatoes', 8.50, true),
                (v_category_id, 'Caesar Salad', 'Fresh romaine salad', 10.50, true);
            
            -- Main Courses
            INSERT INTO categories (business_id, name, position)
            VALUES (v_business_id, 'Main Courses', 2)
            RETURNING id INTO v_category_id;
            
            INSERT INTO items (category_id, name, description, price, available) VALUES
                (v_category_id, 'Spaghetti Carbonara', 'Classic pasta dish', 16.50, true),
                (v_category_id, 'Margherita Pizza', 'Fresh mozzarella pizza', 14.00, true),
                (v_category_id, 'Chicken Parmesan', 'Breaded chicken', 18.00, true);
        END IF;
    END IF;
    
    RAISE NOTICE 'Test data created! Visit /brew-bean-cafe or /mama-mia-italian to see menus.';
END $$;

