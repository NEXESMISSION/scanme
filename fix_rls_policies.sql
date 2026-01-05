-- Fix RLS Policies for Businesses Table
-- Run this in Supabase SQL Editor to fix the signup issue
-- IMPORTANT: Only run this file, NOT schema.sql (tables already exist)

-- Drop existing policies (IF EXISTS handles errors gracefully)
DROP POLICY IF EXISTS "Owners can create own business" ON businesses;
DROP POLICY IF EXISTS "Owners can view own business" ON businesses;
DROP POLICY IF EXISTS "Owners can update own business" ON businesses;
DROP POLICY IF EXISTS "Owners can delete own business" ON businesses;
DROP POLICY IF EXISTS "Public can view active businesses" ON businesses;
DROP POLICY IF EXISTS "Public can view businesses" ON businesses;

-- Recreate with simplified, correct policies

-- Public can read active and paused businesses
CREATE POLICY "Public can view businesses"
    ON businesses FOR SELECT
    USING (status IN ('active', 'paused'));

-- Owners can read their own business (including paused)
CREATE POLICY "Owners can view own business"
    ON businesses FOR SELECT
    USING (auth.uid() = owner_id);

-- Owners can insert their own business
CREATE POLICY "Owners can create own business"
    ON businesses FOR INSERT
    WITH CHECK (auth.uid() = owner_id);

-- Owners can update their own business
CREATE POLICY "Owners can update own business"
    ON businesses FOR UPDATE
    USING (auth.uid() = owner_id)
    WITH CHECK (auth.uid() = owner_id);

-- Owners can delete their own business
CREATE POLICY "Owners can delete own business"
    ON businesses FOR DELETE
    USING (auth.uid() = owner_id);

