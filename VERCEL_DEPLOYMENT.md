# Vercel Deployment Guide

## Quick Setup

Since the project name "scanme" already exists on Vercel, you have two options:

### Option 1: Use a Different Project Name (Recommended)

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)

2. Click **"Add New..."** → **"Project"**

3. Import your GitHub repository: `NEXESMISSION/scanme`

4. **Project Name**: Use a unique name like:
   - `qr-menu-builder`
   - `scanme-app`
   - `menu-builder-app`
   - Or any other unique name you prefer

5. **Framework Preset**: Should auto-detect as "Next.js"

6. **Root Directory**: Leave as `./` (default)

7. **Build and Output Settings**: Leave default (auto-detected)

### Option 2: Use Existing "scanme" Project

1. Go to your existing "scanme" project on Vercel

2. Click **Settings** → **General**

3. Scroll down and click **"Delete Project"** (if you want to start fresh)

4. Or go to **Settings** → **Git** and reconnect to the new repository

## Environment Variables Setup

**CRITICAL**: Add these environment variables in Vercel before deploying:

1. In your Vercel project, go to **Settings** → **Environment Variables**

2. Add these three variables:

   ```
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
   SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
   ```

3. Make sure to add them for all environments:
   - ✅ Production
   - ✅ Preview
   - ✅ Development

4. Click **Save**

## Deploy

1. After setting up environment variables, click **"Deploy"**

2. Vercel will automatically:
   - Install dependencies (`npm install`)
   - Build the project (`npm run build`)
   - Deploy to a production URL

3. Your site will be available at: `https://your-project-name.vercel.app`

## Post-Deployment Checklist

- [ ] Test the landing page
- [ ] Test signup flow
- [ ] Test login flow
- [ ] Test admin dashboard
- [ ] Test public menu display
- [ ] Verify images are loading from Supabase Storage
- [ ] Test social media links functionality
- [ ] Verify favicon displays correctly

## Custom Domain (Optional)

1. Go to **Settings** → **Domains**

2. Add your custom domain

3. Follow the DNS configuration instructions

## Troubleshooting

### Build Fails
- Check that all environment variables are set
- Verify Supabase URL and keys are correct
- Check build logs in Vercel dashboard

### Images Not Loading
- Verify Supabase Storage bucket is configured
- Check Storage bucket policies allow public access
- Ensure image URLs are correct

### Authentication Issues
- Verify `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` are correct
- Check Supabase Auth settings
- Verify redirect URLs are configured in Supabase

### Database Connection Issues
- Verify RLS policies are set up correctly
- Check Supabase database connection
- Review RLS policy SQL files

## Support

If you encounter issues:
1. Check Vercel deployment logs
2. Check Supabase logs
3. Review error messages in browser console
4. Verify all SQL migrations have been run

