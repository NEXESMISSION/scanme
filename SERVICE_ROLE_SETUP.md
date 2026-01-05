# Service Role Key Setup

## Problem
Super admin dashboard requires `SUPABASE_SERVICE_ROLE_KEY` to view all businesses.

## Solution Option 1: Add Service Role Key (Recommended)

1. Go to Supabase Dashboard > Settings > API
2. Copy the `service_role` key (NOT the anon key)
3. Open `.env.local` in your project
4. Uncomment and add the key:
   ```
   SUPABASE_SERVICE_ROLE_KEY=your_service_role_key_here
   ```
5. Restart your dev server

## Solution Option 2: Use RLS Policies (No Service Role Needed)

The code has been updated to work without service role key by using RLS policies.

1. Run `add_super_admin_rls.sql` in Supabase SQL Editor
2. This allows super admins to view and update all businesses through RLS

**Note**: Option 2 is already implemented and should work now. But Option 1 is more secure and recommended for production.

## Which One to Use?

- **Development/Testing**: Option 2 (RLS policies) - easier setup
- **Production**: Option 1 (Service Role Key) - more secure and performant

The code now works with both approaches - it will use service role if available, otherwise fallback to RLS policies.

