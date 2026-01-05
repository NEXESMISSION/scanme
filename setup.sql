-- QR Menu Builder - Setup & Utility Scripts
-- Run after schema.sql

-- ============================================
-- SUPER ADMIN SETUP
-- ============================================

-- Create or update super admin profile
-- Replace 'your-email@example.com' with actual email
-- Replace 'uuid-here' with the auth.users.id UUID from Supabase Auth dashboard

-- Method 1: If you know the user_id UUID
-- UPDATE profiles 
-- SET role = 'super_admin' 
-- WHERE user_id = 'your-user-uuid-here';

-- Method 2: If you know the email
-- UPDATE profiles 
-- SET role = 'super_admin' 
-- WHERE email = 'your-email@example.com';

-- Method 3: Create super admin from auth user (if profile doesn't exist)
-- INSERT INTO profiles (user_id, email, phone_number, role)
-- VALUES (
--     'your-user-uuid-here',
--     'your-email@example.com',
--     '+1234567890',
--     'super_admin'
-- )
-- ON CONFLICT (user_id) DO UPDATE SET role = 'super_admin';

-- ============================================
-- CRON JOB SETUP (Supabase)
-- ============================================

-- Enable pg_cron extension (requires Supabase dashboard or service role)
-- CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Schedule daily subscription check (runs at midnight UTC)
-- SELECT cron.schedule(
--     'check-expired-subscriptions',
--     '0 0 * * *',  -- Daily at midnight
--     $$SELECT public.check_expired_subscriptions()$$
-- );

-- To unschedule later:
-- SELECT cron.unschedule('check-expired-subscriptions');

-- ============================================
-- HELPER FUNCTIONS
-- ============================================

-- Function to manually pause a business (super admin use)
CREATE OR REPLACE FUNCTION public.pause_business(business_slug text)
RETURNS void AS $$
BEGIN
    UPDATE businesses
    SET status = 'paused'
    WHERE slug = business_slug;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to manually activate a business (super admin use)
CREATE OR REPLACE FUNCTION public.activate_business(business_slug text)
RETURNS void AS $$
BEGIN
    UPDATE businesses
    SET status = 'active'
    WHERE slug = business_slug;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to extend subscription (super admin use)
CREATE OR REPLACE FUNCTION public.extend_subscription(
    business_slug text,
    new_end_date timestamp
)
RETURNS void AS $$
DECLARE
    biz_id uuid;
BEGIN
    SELECT id INTO biz_id FROM businesses WHERE slug = business_slug;
    
    IF biz_id IS NULL THEN
        RAISE EXCEPTION 'Business with slug % not found', business_slug;
    END IF;
    
    INSERT INTO subscriptions (business_id, ends_at, status)
    VALUES (biz_id, new_end_date, 'active')
    ON CONFLICT (business_id) 
    DO UPDATE SET 
        ends_at = new_end_date,
        status = 'active',
        updated_at = now();
    
    -- Activate business if it was paused
    UPDATE businesses
    SET status = 'active'
    WHERE id = biz_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get all businesses with subscription info (super admin view)
CREATE OR REPLACE FUNCTION public.get_all_businesses()
RETURNS TABLE (
    business_id uuid,
    business_name text,
    slug text,
    owner_email text,
    owner_phone text,
    status text,
    theme_id text,
    subscription_ends_at timestamp,
    subscription_status text,
    created_at timestamp
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        b.id,
        b.name,
        b.slug,
        p.email,
        p.phone_number,
        b.status,
        b.theme_id,
        s.ends_at,
        s.status,
        b.created_at
    FROM businesses b
    INNER JOIN profiles p ON b.owner_id = p.user_id
    LEFT JOIN subscriptions s ON b.id = s.business_id
    ORDER BY b.created_at DESC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- SAMPLE DATA (Optional - for testing)
-- ============================================

-- Create a test business (after creating a user profile)
-- Replace 'owner-user-id-here' with actual owner user_id

/*
INSERT INTO businesses (owner_id, name, slug, theme_id, status)
VALUES (
    'owner-user-id-here',
    'Test Restaurant',
    'test-restaurant',
    'classic',
    'active'
)
RETURNING id;
*/

-- Create sample categories (after creating business)
/*
INSERT INTO categories (business_id, name, position)
VALUES
    ('business-id-here', 'Appetizers', 1),
    ('business-id-here', 'Main Courses', 2),
    ('business-id-here', 'Desserts', 3)
RETURNING id;
*/

-- Create sample items (after creating categories)
/*
INSERT INTO items (category_id, name, description, price, available)
VALUES
    ('category-id-here', 'Caesar Salad', 'Fresh romaine lettuce with Caesar dressing', 8.99, true),
    ('category-id-here', 'Bruschetta', 'Toasted bread with tomato and basil', 7.50, true);
*/

-- Set test subscription (after creating business)
/*
INSERT INTO subscriptions (business_id, ends_at, status)
VALUES (
    'business-id-here',
    now() + interval '30 days',
    'active'
);
*/

-- ============================================
-- VERIFICATION QUERIES
-- ============================================

-- Check all tables exist
-- SELECT table_name 
-- FROM information_schema.tables 
-- WHERE table_schema = 'public' 
-- ORDER BY table_name;

-- Check RLS is enabled
-- SELECT tablename, rowsecurity 
-- FROM pg_tables 
-- WHERE schemaname = 'public';

-- Check all policies
-- SELECT schemaname, tablename, policyname 
-- FROM pg_policies 
-- WHERE schemaname = 'public'
-- ORDER BY tablename, policyname;

-- Check indexes
-- SELECT tablename, indexname 
-- FROM pg_indexes 
-- WHERE schemaname = 'public'
-- ORDER BY tablename;

-- ============================================
-- MAINTENANCE QUERIES
-- ============================================

-- Manually run subscription check
-- SELECT public.check_expired_subscriptions();

-- Find businesses with expired subscriptions
-- SELECT 
--     b.name,
--     b.slug,
--     s.ends_at,
--     s.status
-- FROM businesses b
-- INNER JOIN subscriptions s ON b.id = s.business_id
-- WHERE s.ends_at < now()
-- AND s.status = 'active';

-- Find businesses without subscriptions
-- SELECT 
--     b.name,
--     b.slug,
--     b.created_at
-- FROM businesses b
-- LEFT JOIN subscriptions s ON b.id = s.business_id
-- WHERE s.business_id IS NULL;

-- Count businesses by status
-- SELECT status, COUNT(*) 
-- FROM businesses 
-- GROUP BY status;

-- Count businesses by theme
-- SELECT theme_id, COUNT(*) 
-- FROM businesses 
-- GROUP BY theme_id;

