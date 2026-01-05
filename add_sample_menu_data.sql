-- Add Sample Menu Data to Existing Businesses
-- Run this in Supabase SQL Editor

-- First, let's get the business IDs and add categories and items

-- =============================================
-- COFFEE SHOP (test123456 / coffee@test.com)
-- =============================================

DO $$
DECLARE
    coffee_business_id uuid;
    cat_hot_drinks uuid;
    cat_cold_drinks uuid;
    cat_pastries uuid;
BEGIN
    -- Get the coffee shop business
    SELECT id INTO coffee_business_id FROM businesses WHERE slug = 'test123456';
    
    IF coffee_business_id IS NOT NULL THEN
        -- Delete existing categories for fresh start
        DELETE FROM categories WHERE business_id = coffee_business_id;
        
        -- Hot Drinks Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (coffee_business_id, 'Hot Drinks', 1) 
        RETURNING id INTO cat_hot_drinks;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_hot_drinks, 'Espresso', 'Rich and bold single shot of espresso', 3.50, true),
        (cat_hot_drinks, 'Cappuccino', 'Espresso with steamed milk and foam', 4.50, true),
        (cat_hot_drinks, 'Latte', 'Smooth espresso with velvety steamed milk', 4.75, true),
        (cat_hot_drinks, 'Americano', 'Espresso diluted with hot water', 3.75, true),
        (cat_hot_drinks, 'Mocha', 'Espresso with chocolate and steamed milk', 5.25, true),
        (cat_hot_drinks, 'Hot Chocolate', 'Rich Belgian chocolate with steamed milk', 4.00, true);
        
        -- Cold Drinks Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (coffee_business_id, 'Cold Drinks', 2) 
        RETURNING id INTO cat_cold_drinks;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_cold_drinks, 'Iced Latte', 'Chilled espresso with cold milk over ice', 5.00, true),
        (cat_cold_drinks, 'Cold Brew', 'Slow-steeped for 20 hours, smooth and refreshing', 4.50, true),
        (cat_cold_drinks, 'Iced Americano', 'Espresso and cold water over ice', 4.00, true),
        (cat_cold_drinks, 'Frappuccino', 'Blended iced coffee with cream', 5.75, true),
        (cat_cold_drinks, 'Fresh Lemonade', 'House-made with fresh lemons', 3.50, true);
        
        -- Pastries Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (coffee_business_id, 'Pastries & Snacks', 3) 
        RETURNING id INTO cat_pastries;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_pastries, 'Croissant', 'Buttery, flaky French pastry', 3.75, true),
        (cat_pastries, 'Chocolate Muffin', 'Rich chocolate chip muffin', 3.50, true),
        (cat_pastries, 'Blueberry Scone', 'Fresh-baked with real blueberries', 3.25, true),
        (cat_pastries, 'Banana Bread', 'Moist slice with walnuts', 3.00, true),
        (cat_pastries, 'Avocado Toast', 'Sourdough with smashed avocado and seeds', 7.50, true);
        
        RAISE NOTICE 'Coffee shop menu added successfully!';
    ELSE
        RAISE NOTICE 'Coffee shop (test123456) not found';
    END IF;
END $$;


-- =============================================
-- RESTAURANT (12345678 / restaurant@test.com)
-- =============================================

DO $$
DECLARE
    restaurant_business_id uuid;
    cat_starters uuid;
    cat_mains uuid;
    cat_desserts uuid;
    cat_drinks uuid;
BEGIN
    -- Get the restaurant business
    SELECT id INTO restaurant_business_id FROM businesses WHERE slug = '12345678';
    
    IF restaurant_business_id IS NOT NULL THEN
        -- Delete existing categories for fresh start
        DELETE FROM categories WHERE business_id = restaurant_business_id;
        
        -- Starters Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (restaurant_business_id, 'Starters', 1) 
        RETURNING id INTO cat_starters;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_starters, 'Caesar Salad', 'Crisp romaine, parmesan, croutons, house Caesar dressing', 12.00, true),
        (cat_starters, 'Bruschetta', 'Grilled bread with fresh tomatoes, basil, and balsamic glaze', 9.50, true),
        (cat_starters, 'Soup of the Day', 'Ask your server for today''s selection', 8.00, true),
        (cat_starters, 'Calamari', 'Crispy fried squid with marinara sauce', 14.00, true),
        (cat_starters, 'Garlic Bread', 'Toasted with herb butter and melted mozzarella', 7.50, true);
        
        -- Main Courses Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (restaurant_business_id, 'Main Courses', 2) 
        RETURNING id INTO cat_mains;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_mains, 'Grilled Salmon', 'Atlantic salmon with lemon herb butter, seasonal vegetables', 26.00, true),
        (cat_mains, 'Ribeye Steak', '12oz prime ribeye, garlic mashed potatoes, asparagus', 38.00, true),
        (cat_mains, 'Chicken Parmesan', 'Breaded chicken breast, marinara, melted mozzarella, pasta', 22.00, true),
        (cat_mains, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and truffle oil', 19.00, true),
        (cat_mains, 'Fish & Chips', 'Beer-battered cod, hand-cut fries, tartar sauce', 18.00, true),
        (cat_mains, 'Vegetable Pasta', 'Penne with seasonal vegetables in garlic olive oil', 17.00, true);
        
        -- Desserts Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (restaurant_business_id, 'Desserts', 3) 
        RETURNING id INTO cat_desserts;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_desserts, 'Tiramisu', 'Classic Italian coffee-soaked ladyfingers with mascarpone', 9.00, true),
        (cat_desserts, 'Chocolate Lava Cake', 'Warm chocolate cake with molten center, vanilla ice cream', 10.00, true),
        (cat_desserts, 'Cheesecake', 'New York style with berry compote', 8.50, true),
        (cat_desserts, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 8.00, true);
        
        -- Drinks Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (restaurant_business_id, 'Beverages', 4) 
        RETURNING id INTO cat_drinks;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_drinks, 'Soft Drinks', 'Coke, Sprite, Fanta, or Ginger Ale', 3.00, true),
        (cat_drinks, 'Fresh Juice', 'Orange, Apple, or Cranberry', 4.50, true),
        (cat_drinks, 'Sparkling Water', 'San Pellegrino 500ml', 4.00, true),
        (cat_drinks, 'Coffee', 'Freshly brewed', 3.50, true),
        (cat_drinks, 'Tea Selection', 'Earl Grey, Green, Chamomile, or English Breakfast', 3.50, true);
        
        RAISE NOTICE 'Restaurant menu added successfully!';
    ELSE
        RAISE NOTICE 'Restaurant (12345678) not found';
    END IF;
END $$;


-- =============================================
-- BAKERY (test123457 / bakery@test.com)
-- =============================================

DO $$
DECLARE
    bakery_business_id uuid;
    cat_breads uuid;
    cat_cakes uuid;
    cat_cookies uuid;
    cat_special uuid;
BEGIN
    -- Get the bakery business
    SELECT id INTO bakery_business_id FROM businesses WHERE slug = 'test123457';
    
    IF bakery_business_id IS NOT NULL THEN
        -- Delete existing categories for fresh start
        DELETE FROM categories WHERE business_id = bakery_business_id;
        
        -- Breads Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (bakery_business_id, 'Fresh Breads', 1) 
        RETURNING id INTO cat_breads;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_breads, 'Sourdough Loaf', 'Traditional 24-hour fermented sourdough', 6.50, true),
        (cat_breads, 'French Baguette', 'Crusty exterior, soft interior', 4.00, true),
        (cat_breads, 'Ciabatta', 'Italian bread with olive oil', 5.00, true),
        (cat_breads, 'Whole Wheat Loaf', 'Hearty and nutritious', 5.50, true),
        (cat_breads, 'Focaccia', 'Rosemary and sea salt topped', 6.00, true),
        (cat_breads, 'Rye Bread', 'Dense and flavorful', 5.75, true);
        
        -- Cakes Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (bakery_business_id, 'Cakes & Tarts', 2) 
        RETURNING id INTO cat_cakes;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_cakes, 'Chocolate Ganache Cake', 'Rich dark chocolate layers with ganache frosting', 45.00, true),
        (cat_cakes, 'Red Velvet Cake', 'Classic with cream cheese frosting', 42.00, true),
        (cat_cakes, 'Carrot Cake', 'Spiced cake with walnuts and cream cheese', 40.00, true),
        (cat_cakes, 'Fruit Tart', 'Buttery crust with pastry cream and fresh fruits', 35.00, true),
        (cat_cakes, 'Slice of Cake', 'Daily selection, ask for availability', 6.50, true);
        
        -- Cookies & Pastries Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (bakery_business_id, 'Cookies & Pastries', 3) 
        RETURNING id INTO cat_cookies;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_cookies, 'Chocolate Chip Cookie', 'Soft and chewy with Belgian chocolate', 3.00, true),
        (cat_cookies, 'Croissant', 'Buttery layers of perfection', 4.00, true),
        (cat_cookies, 'Pain au Chocolat', 'Croissant dough with dark chocolate', 4.50, true),
        (cat_cookies, 'Cinnamon Roll', 'Warm with cream cheese glaze', 4.75, true),
        (cat_cookies, 'Almond Croissant', 'Filled with almond cream, topped with sliced almonds', 5.00, true),
        (cat_cookies, 'Macarons (Box of 6)', 'Assorted flavors', 15.00, true);
        
        -- Special Items Category
        INSERT INTO categories (business_id, name, position) 
        VALUES (bakery_business_id, 'Special Orders', 4) 
        RETURNING id INTO cat_special;
        
        INSERT INTO items (category_id, name, description, price, available) VALUES
        (cat_special, 'Custom Birthday Cake', 'Order 48 hours in advance, serves 12-16', 65.00, true),
        (cat_special, 'Wedding Cake Tasting', 'Book a consultation for your special day', 50.00, true),
        (cat_special, 'Pastry Box (12 pieces)', 'Assorted pastries for your event', 48.00, true);
        
        RAISE NOTICE 'Bakery menu added successfully!';
    ELSE
        RAISE NOTICE 'Bakery (test123457) not found';
    END IF;
END $$;

-- Verify the data was added
SELECT 
    b.name as business,
    b.slug,
    COUNT(DISTINCT c.id) as categories,
    COUNT(i.id) as items
FROM businesses b
LEFT JOIN categories c ON c.business_id = b.id
LEFT JOIN items i ON i.category_id = c.id
GROUP BY b.id, b.name, b.slug
ORDER BY b.name;

