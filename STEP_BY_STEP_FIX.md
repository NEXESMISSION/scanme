# Step-by-Step RLS Policy Fix

## Problem
Getting error: `new row violates row-level security policy for table "businesses"` during signup.

## Solution

### Step 1: Open Supabase Dashboard
1. Go to https://supabase.com/dashboard
2. Select your project (vrwfbmxynnmdbrsoerrq)
3. Click on **SQL Editor** in the left sidebar

### Step 2: Run the Fix
1. In SQL Editor, click **New Query**
2. Copy the **entire contents** of `fix_rls_policies_complete.sql`
3. Paste into the SQL Editor
4. Click **Run** (or press Ctrl+Enter)
5. Wait for "Success. No rows returned" message

### Step 3: Verify It Worked
1. In SQL Editor, run this query:
```sql
SELECT policyname, cmd 
FROM pg_policies 
WHERE tablename = 'businesses';
```

2. You should see 5 policies listed

### Step 4: Test Signup
1. Go back to your app (http://localhost:3000/signup)
2. Refresh the page
3. Fill in the signup form
4. Click "Sign up"
5. **The error should be gone!**

## What This Does

The fix replaces complex RLS policies with simple ones:
- **Old (broken)**: Uses subqueries that fail during signup
- **New (working)**: Uses `auth.uid() = owner_id` which works immediately

## If It Still Doesn't Work

1. **Check you ran the SQL**: Go to SQL Editor > History, verify the query ran
2. **Check policies exist**: Run the verification query above
3. **Clear browser cache**: Hard refresh (Ctrl+Shift+R)
4. **Try different browser**: Sometimes cache issues persist

## Need Help?

If you're still getting errors after running the fix:
1. Check the browser console for the exact error message
2. Check Supabase logs: Dashboard > Logs > Postgres Logs
3. Make sure you're using the correct Supabase project

