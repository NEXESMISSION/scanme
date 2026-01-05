-- Add Unique Constraints for Email and Business Name
-- Run this in Supabase SQL Editor

-- =============================================
-- 1. UNIQUE EMAIL CONSTRAINT (profiles table)
-- =============================================

-- First, check for any duplicate emails
SELECT email, COUNT(*) 
FROM profiles 
WHERE email IS NOT NULL 
GROUP BY email 
HAVING COUNT(*) > 1;

-- Add unique constraint on email (if no duplicates exist)
DO $$
BEGIN
    -- Check if constraint already exists
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'profiles_email_unique'
    ) THEN
        ALTER TABLE profiles ADD CONSTRAINT profiles_email_unique UNIQUE (email);
        RAISE NOTICE 'Added unique constraint on profiles.email';
    ELSE
        RAISE NOTICE 'profiles_email_unique constraint already exists';
    END IF;
END $$;


-- =============================================
-- 2. UNIQUE BUSINESS NAME CONSTRAINT
-- =============================================

-- First, check for any duplicate business names
SELECT name, COUNT(*) 
FROM businesses 
GROUP BY name 
HAVING COUNT(*) > 1;

-- Add unique constraint on business name
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'businesses_name_unique'
    ) THEN
        ALTER TABLE businesses ADD CONSTRAINT businesses_name_unique UNIQUE (name);
        RAISE NOTICE 'Added unique constraint on businesses.name';
    ELSE
        RAISE NOTICE 'businesses_name_unique constraint already exists';
    END IF;
END $$;


-- =============================================
-- 3. UNIQUE SLUG CONSTRAINT (should already exist)
-- =============================================

-- Verify slug constraint exists
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'businesses_slug_unique' OR conname = 'businesses_slug_key'
    ) THEN
        ALTER TABLE businesses ADD CONSTRAINT businesses_slug_unique UNIQUE (slug);
        RAISE NOTICE 'Added unique constraint on businesses.slug';
    ELSE
        RAISE NOTICE 'businesses slug constraint already exists';
    END IF;
END $$;


-- =============================================
-- 4. VERIFY CONSTRAINTS
-- =============================================

-- List all constraints on profiles and businesses tables
SELECT 
    tc.table_name, 
    tc.constraint_name, 
    tc.constraint_type,
    kcu.column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu 
    ON tc.constraint_name = kcu.constraint_name
WHERE tc.table_name IN ('profiles', 'businesses')
    AND tc.constraint_type IN ('UNIQUE', 'PRIMARY KEY')
ORDER BY tc.table_name, tc.constraint_name;

