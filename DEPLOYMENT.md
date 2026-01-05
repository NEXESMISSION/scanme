# Deployment Guide

## Step-by-Step Deployment

### 1. Supabase Setup

1. **Create Supabase Project**
   - Go to https://supabase.com
   - Create a new project
   - Wait for database to be ready

2. **Run Database Schema**
   - Go to SQL Editor in Supabase dashboard
   - Copy and paste contents of `schema.sql`
   - Run the script
   - Verify all tables are created

3. **Seed Themes**
   - Themes should be automatically seeded by `schema.sql`
   - Verify in Table Editor that themes table has: classic, minimal, dark

4. **Set Up Super Admin**
   - Sign up normally through the app
   - Go to SQL Editor and run:
   ```sql
   UPDATE profiles 
   SET role = 'super_admin' 
   WHERE email = 'your@email.com';
   ```

5. **Get API Keys**
   - Go to Settings > API
   - Copy:
     - Project URL
     - anon/public key
     - service_role key (keep secret!)

### 2. Environment Variables

Create `.env.local` in project root:

```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGc...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGc... (keep this secret!)
NEXT_PUBLIC_MENU_URL=https://menu.myowndomain.com
```

### 3. Local Development

```bash
npm install
npm run dev
```

Visit http://localhost:3000

### 4. Deploy to Vercel

1. **Connect Repository**
   - Push code to GitHub/GitLab
   - Go to https://vercel.com
   - Import your repository

2. **Configure Environment Variables**
   - Add all variables from `.env.local`
   - Make sure `SUPABASE_SERVICE_ROLE_KEY` is added
   - Set `NEXT_PUBLIC_MENU_URL` to your actual domain

3. **Deploy**
   - Vercel will auto-deploy on push
   - Or click "Deploy" manually

### 5. Post-Deployment

1. **Update Supabase Auth Settings**
   - Go to Authentication > URL Configuration
   - Add your Vercel URL to "Site URL"
   - Add your Vercel URL to "Redirect URLs"

2. **Set Up Cron Job (Optional)**
   - In Supabase, go to Database > Extensions
   - Enable `pg_cron` extension
   - Run from `setup.sql`:
   ```sql
   SELECT cron.schedule(
     'check-expired-subscriptions',
     '0 0 * * *',
     $$SELECT public.check_expired_subscriptions()$$
   );
   ```

3. **Test Everything**
   - Sign up a new account
   - Create menu items
   - View public menu at `/{slug}`
   - Test QR code generation
   - Test super admin dashboard

### 6. Custom Domain (Optional)

1. **Add Domain in Vercel**
   - Project Settings > Domains
   - Add your domain (e.g., menu.myowndomain.com)

2. **Update DNS**
   - Add CNAME record pointing to Vercel
   - Wait for DNS propagation

3. **Update Environment Variables**
   - Update `NEXT_PUBLIC_MENU_URL` to your custom domain
   - Redeploy

## Troubleshooting

### RLS Policy Errors
- If you get permission errors, check that RLS policies are correctly set
- Super admin operations require service role key

### Auth Redirect Issues
- Make sure Vercel URL is in Supabase redirect URLs
- Check that environment variables are set correctly

### Database Connection Errors
- Verify Supabase URL and keys are correct
- Check that tables exist in Supabase dashboard

### Build Errors
- Make sure all environment variables are set in Vercel
- Check that `@supabase/ssr` is installed

## Security Checklist

- [ ] Service role key is NEVER exposed to client
- [ ] RLS policies are enabled on all tables
- [ ] Super admin routes are protected
- [ ] Environment variables are set in Vercel (not in code)
- [ ] Supabase auth redirect URLs are configured

