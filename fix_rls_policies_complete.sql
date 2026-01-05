-- Complete Fix for RLS Policies
-- Run this ENTIRE file in Supabase SQL Editor
-- This fixes the signup issue where businesses can't be created

-- ============================================
-- STEP 1: Drop ALL existing business policies
-- ============================================
-- Drop policies in reverse dependency order to avoid conflicts
DROP POLICY IF EXISTS "Owners can delete own business" ON businesses;
DROP POLICY IF EXISTS "Owners can update own business" ON businesses;
DROP POLICY IF EXISTS "Owners can create own business" ON businesses;
DROP POLICY IF EXISTS "Owners can view own business" ON businesses;
DROP POLICY IF EXISTS "Public can view active businesses" ON businesses;
DROP POLICY IF EXISTS "Public can view businesses" ON businesses;

-- ============================================
-- STEP 2: Create corrected policies
-- ============================================
-- Policies are created in order to ensure proper access control

-- Public can read active and paused businesses
-- This allows anyone to view menus of active/paused businesses
CREATE POLICY "Public can view businesses"
    ON businesses FOR SELECT
    USING (status IN ('active', 'paused'));

-- Owners can read their own business (including paused)
-- This allows owners to see their business regardless of status
CREATE POLICY "Owners can view own business"
    ON businesses FOR SELECT
    USING (auth.uid() = owner_id);

-- CRITICAL: Owners can INSERT their own business
-- This MUST use auth.uid() = owner_id directly (no subqueries)
-- This is what allows signup to work - user creates business with their own ID
CREATE POLICY "Owners can create own business"
    ON businesses FOR INSERT
    WITH CHECK (auth.uid() = owner_id);

-- Owners can update their own business
-- Both USING (for existing rows) and WITH CHECK (for new values)
CREATE POLICY "Owners can update own business"
    ON businesses FOR UPDATE
    USING (auth.uid() = owner_id)
    WITH CHECK (auth.uid() = owner_id);

-- Owners can delete their own business
CREATE POLICY "Owners can delete own business"
    ON businesses FOR DELETE
    USING (auth.uid() = owner_id);

-- ============================================
-- VERIFICATION
-- ============================================
-- After running, verify policies exist:
-- SELECT * FROM pg_policies WHERE tablename = 'businesses';
--
-- You should see 5 policies:
-- 1. Public can view businesses
-- 2. Owners can view own business
-- 3. Owners can create own business
-- 4. Owners can update own business
-- 5. Owners can delete own business

