# IMPORTANT: SQL Fix Instructions

## ⚠️ DO NOT RUN schema.sql AGAIN

The error `relation "profiles" already exists` means the tables are already created.

## ✅ What to Do

1. **Only run `fix_rls_policies.sql`** in your Supabase SQL Editor
   - This file ONLY updates the RLS policies
   - It won't try to create tables again
   - It uses `DROP POLICY IF EXISTS` to safely update policies

2. **Steps:**
   - Go to Supabase Dashboard
   - Navigate to SQL Editor
   - Copy the contents of `fix_rls_policies.sql`
   - Paste and run it
   - You should see success messages

3. **After running the fix:**
   - Try signing up again
   - The RLS error should be gone
   - Signup should work correctly

## Why This Happens

- `schema.sql` creates all tables (profiles, businesses, etc.)
- If you run it twice, it tries to create tables that already exist
- `fix_rls_policies.sql` only updates policies, not tables

