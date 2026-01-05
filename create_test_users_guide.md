# Complete Guide: Create Test Accounts

## What This Creates

For each account, you'll get:
- ✅ User account (email + password)
- ✅ Profile with phone number
- ✅ Business with theme
- ✅ Complete menu (categories + items)

## Step-by-Step Instructions

### Step 1: Create User Accounts

You have 2 options:

#### Option A: Sign Up Through the App (Recommended)

1. Go to `http://localhost:3000/signup`
2. Create 3 accounts with these details:

**Account 1 - Coffee Shop:**
- Email: `coffee@test.com`
- Password: `test123456`
- Phone: `+1234567890`
- Business Name: `Brew & Bean Cafe`

**Account 2 - Restaurant:**
- Email: `restaurant@test.com`
- Password: `test123456`
- Phone: `+1234567891`
- Business Name: `Mama Mia Italian`

**Account 3 - Bakery:**
- Email: `bakery@test.com`
- Password: `test123456`
- Phone: `+1234567892`
- Business Name: `Sweet Dreams Bakery`

#### Option B: Create via Supabase Dashboard

1. Go to Supabase Dashboard > Authentication > Users
2. Click "Add User" for each:
   - Email: `coffee@test.com`, Password: `test123456`
   - Email: `restaurant@test.com`, Password: `test123456`
   - Email: `bakery@test.com`, Password: `test123456`

### Step 2: Run the SQL Script

1. Open Supabase SQL Editor
2. Copy the entire contents of `create_test_accounts.sql`
3. Paste and run it
4. Check the output for success messages

### Step 3: Verify Everything Works

1. **Login to Coffee Shop:**
   - Go to `/login`
   - Email: `coffee@test.com` / Password: `test123456`
   - You should see the dashboard with "Brew & Bean Cafe"

2. **View Public Menu:**
   - Visit: `http://localhost:3000/brew-bean-cafe`
   - Should show the coffee shop menu

3. **Repeat for other accounts**

## Test Account Details Summary

| Email | Password | Business | Theme | Menu URL |
|-------|----------|----------|-------|----------|
| coffee@test.com | test123456 | Brew & Bean Cafe | Classic | /brew-bean-cafe |
| restaurant@test.com | test123456 | Mama Mia Italian | Minimal | /mama-mia-italian |
| bakery@test.com | test123456 | Sweet Dreams Bakery | Dark | /sweet-dreams-bakery |

## What Each Account Has

### Coffee Shop Account
- **Categories:** 3 (Hot Beverages, Cold Beverages, Pastries)
- **Items:** 12 total
- **Theme:** Classic (red primary color)

### Restaurant Account
- **Categories:** 3 (Appetizers, Main Courses, Desserts)
- **Items:** 13 total
- **Theme:** Minimal (black/white)

### Bakery Account
- **Categories:** 3 (Cakes, Cookies & Pastries, Fresh Breads)
- **Items:** 14 total
- **Theme:** Dark (dark background)

## Troubleshooting

### "User not found" Error
- Make sure you created the user accounts first (Step 1)
- Check that emails match exactly: `coffee@test.com`, etc.
- Verify users exist: `SELECT email FROM auth.users;`

### "Business already exists"
- This is OK! The script will update existing data
- If you want fresh data, delete businesses first:
  ```sql
  DELETE FROM businesses WHERE slug IN ('brew-bean-cafe', 'mama-mia-italian', 'sweet-dreams-bakery');
  ```

### Can't Login
- Make sure email verification is disabled for test accounts
- Or verify emails in Supabase Dashboard > Authentication > Users

## Quick Reset

To delete all test accounts and start fresh:
```sql
-- Delete businesses (cascades to categories and items)
DELETE FROM businesses WHERE slug IN ('brew-bean-cafe', 'mama-mia-italian', 'sweet-dreams-bakery');

-- Delete profiles (but keep users)
DELETE FROM profiles WHERE email IN ('coffee@test.com', 'restaurant@test.com', 'bakery@test.com');

-- Delete users (if you want to start completely fresh)
-- DO THIS IN SUPABASE DASHBOARD > Authentication > Users
```

