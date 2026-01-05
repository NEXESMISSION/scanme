# Fix Row-Level Security Policies

## The Problem
The signup process fails with: `new row violates row-level security policy for table "businesses"`

This is because the RLS policies are too complex and fail during signup.

## Solution

Run the SQL in `fix_rls_policies.sql` in your Supabase SQL Editor:

1. Go to your Supabase Dashboard
2. Navigate to SQL Editor
3. Copy and paste the contents of `fix_rls_policies.sql`
4. Run it

This will update the RLS policies to be simpler and correct:
- `auth.uid() = owner_id` instead of complex subqueries

## Alternative: Re-run schema.sql

If you prefer, you can:
1. Drop all existing policies
2. Re-run the updated `schema.sql` file (which now has the fixed policies)

The key change is that all business RLS policies now use the simpler check:
```sql
auth.uid() = owner_id
```

This ensures that during signup, when a user creates their business, the RLS policy will allow it because `auth.uid()` will equal the `owner_id` being inserted.

