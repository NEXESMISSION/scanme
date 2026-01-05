# URGENT: Fix RLS Policy Error

## The Error
```
new row violates row-level security policy for table "businesses"
```

## The Problem
The RLS policies are blocking business creation during signup.

## The Solution

**Run this SQL file in Supabase:**

1. Open Supabase Dashboard
2. Go to SQL Editor
3. Copy and paste the **ENTIRE** contents of `fix_rls_policies_complete.sql`
4. Click "Run"
5. Wait for success message

## What This Does

- Drops old incorrect policies
- Creates new policies that use `auth.uid() = owner_id` (simple check)
- Allows users to create their own business during signup

## After Running

1. Try signing up again
2. The error should be gone
3. Business should be created successfully

## Verification

To verify policies were created correctly, run this query:

```sql
SELECT policyname, cmd, qual, with_check 
FROM pg_policies 
WHERE tablename = 'businesses';
```

You should see 5 policies, and the "Owners can create own business" policy should have:
- `with_check`: `(auth.uid() = owner_id)`

## If Still Not Working

1. Make sure you're logged into Supabase Dashboard
2. Make sure you selected the correct project
3. Check that the SQL ran without errors
4. Try refreshing the browser and signing up again

