# Quick Start Guide

## 5-Minute Setup

### 1. Supabase (2 minutes)

```bash
# 1. Create project at supabase.com
# 2. Run schema.sql in SQL Editor
# 3. Get API keys from Settings > API
```

### 2. Environment (1 minute)

Create `.env.local`:
```env
NEXT_PUBLIC_SUPABASE_URL=your_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_key
SUPABASE_SERVICE_ROLE_KEY=your_service_key
NEXT_PUBLIC_MENU_URL=https://menu.myowndomain.com
```

### 3. Install & Run (1 minute)

```bash
npm install
npm run dev
```

### 4. Create Super Admin (1 minute)

1. Sign up at http://localhost:3000/signup
2. Run in Supabase SQL Editor:
```sql
UPDATE profiles SET role = 'super_admin' WHERE email = 'your@email.com';
```

### 5. Test (1 minute)

1. Create menu items at `/admin/menu`
2. View menu at `/{your-slug}`
3. Download QR code at `/admin/qr`

## What You Get

✅ **Public Menu**: Beautiful, themed menu pages  
✅ **Menu Builder**: Add categories and items  
✅ **QR Codes**: Generate downloadable QR codes  
✅ **Theme Selector**: Choose from 3 themes  
✅ **Super Admin**: Manage all businesses  

## Next Steps

- Deploy to Vercel (see DEPLOYMENT.md)
- Set up custom domain
- Start selling to restaurants!

