# Troubleshooting Guide

## Console Errors But Page Works

If you're seeing errors in the browser console but the page is displaying correctly (e.g., "No business found"), these are typically:

1. **React Error Boundaries** - Catching and handling errors gracefully
2. **Redirect Boundaries** - Next.js handling redirects
3. **Development warnings** - Not breaking functionality

**These errors are safe to ignore if:**
- The page displays correctly
- You can interact with the UI
- Functionality works as expected

## Common Issues

### "No business found" After Signup

This is **normal**! It means:
- ✅ Signup was successful
- ✅ User profile was created
- ✅ Authentication is working
- ⚠️ Business creation may have failed or you need to sign up again

**Solution:**
1. Try signing up again with a different business name
2. Check Supabase logs to see if there was an RLS policy error
3. Make sure you ran `fix_rls_policies.sql` in Supabase

### RLS Policy Errors

If you see "new row violates row-level security policy":
1. Make sure you ran `fix_rls_policies.sql` (not `schema.sql`)
2. Check that the policies exist in Supabase Dashboard > Database > Policies
3. Verify the policies use `auth.uid() = owner_id` (not subqueries)

### Redirect Loop

If you're stuck in a redirect loop:
1. Clear browser cookies/localStorage
2. Sign out and sign in again
3. Check that your profile exists in the `profiles` table

### Can't Access Admin After Login

1. Check Supabase Auth > Users to see if your user exists
2. Check the `profiles` table to see if your profile exists
3. Verify the profile has `role = 'owner'`

## Getting Help

If issues persist:
1. Check browser console for full error messages
2. Check server console (terminal) for server-side errors
3. Check Supabase logs for database errors
4. Verify all environment variables are set correctly

