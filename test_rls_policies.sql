-- Test RLS Policies
-- Run this after fix_rls_policies_complete.sql to verify everything works

-- ============================================
-- Verify Policies Exist
-- ============================================
SELECT 
    schemaname,
    tablename,
    policyname,
    cmd,
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'businesses'
ORDER BY policyname;

-- ============================================
-- Expected Results
-- ============================================
-- You should see 5 policies:
-- 
-- 1. "Owners can create own business"
--    - cmd: INSERT
--    - with_check: (auth.uid() = owner_id)
--
-- 2. "Owners can delete own business"
--    - cmd: DELETE
--    - qual: (auth.uid() = owner_id)
--
-- 3. "Owners can update own business"
--    - cmd: UPDATE
--    - qual: (auth.uid() = owner_id)
--    - with_check: (auth.uid() = owner_id)
--
-- 4. "Owners can view own business"
--    - cmd: SELECT
--    - qual: (auth.uid() = owner_id)
--
-- 5. "Public can view businesses"
--    - cmd: SELECT
--    - qual: (status = ANY (ARRAY['active'::text, 'paused'::text]))

-- ============================================
-- Test INSERT Policy (as authenticated user)
-- ============================================
-- This should work after you're logged in:
-- INSERT INTO businesses (owner_id, name, slug) 
-- VALUES (auth.uid(), 'Test Business', 'test-business');

