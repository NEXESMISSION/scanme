-- Add RLS Policies for Super Admins
-- Run this in Supabase SQL Editor

-- Super admins can view all businesses
CREATE POLICY "Super admins can view all businesses"
    ON businesses FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.user_id = auth.uid()
            AND profiles.role = 'super_admin'
        )
    );

-- Super admins can update any business
CREATE POLICY "Super admins can update any business"
    ON businesses FOR UPDATE
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.user_id = auth.uid()
            AND profiles.role = 'super_admin'
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.user_id = auth.uid()
            AND profiles.role = 'super_admin'
        )
    );

