# QR Menu Builder

A lean, local SaaS/service hybrid for creating beautiful QR code menus for restaurants.

## Tech Stack

- **Frontend**: Next.js 14 (App Router), TypeScript, Tailwind CSS
- **Backend**: Supabase (Auth, PostgreSQL)
- **Hosting**: Vercel (frontend), Supabase (backend)

## Features

### Included (MVP)
- Account creation with email, password, and phone number
- One business per account
- Menu builder (categories + items)
- Public QR menu with SSR
- Theme selection (classic, minimal, dark)
- Manual subscription system
- Super admin dashboard

### Excluded (for now)
- Custom domains
- Payments (Stripe)
- Online ordering
- Staff roles
- Analytics
- Theme customization
- Page builders
- AI features

## Setup

### 1. Supabase Setup

1. Create a new Supabase project
2. Run `schema.sql` in the SQL Editor to create all tables and RLS policies
3. Run the super admin setup section from `setup.sql`
4. Get your Supabase URL and keys from Settings > API

### 2. Environment Variables

Create a `.env.local` file:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
NEXT_PUBLIC_MENU_URL=https://menu.myowndomain.com
```

### 3. Install Dependencies

```bash
npm install
```

### 4. Run Development Server

```bash
npm run dev
```

### 5. Deploy

Deploy to Vercel:

```bash
vercel
```

## Project Structure

```
├── app/
│   ├── [slug]/          # Public menu pages
│   ├── admin/           # Owner dashboard
│   ├── super-admin/     # Super admin dashboard
│   ├── login/           # Login page
│   └── signup/          # Signup page
├── components/
│   ├── auth/            # Authentication components
│   ├── dashboard/       # Dashboard navigation
│   ├── menu/            # Menu builder components
│   ├── theme/           # Theme selector
│   ├── qr/              # QR code display
│   └── super-admin/     # Super admin components
├── lib/
│   ├── auth.ts          # Authentication helpers
│   ├── db/              # Database query functions
│   ├── themes/          # Theme configurations
│   ├── supabase/        # Supabase clients
│   └── utils/           # Utility functions
├── schema.sql           # Database schema
└── setup.sql            # Setup scripts
```

## Routes

### Public
- `/{slug}` - Public menu page

### Owner Dashboard
- `/admin` - Dashboard home
- `/admin/menu` - Menu builder
- `/admin/theme` - Theme selector
- `/admin/qr` - QR code download

### Super Admin
- `/super-admin` - Super admin dashboard

### Authentication
- `/login` - Login page
- `/signup` - Signup page

## Database Schema

See `schema.sql` for complete schema documentation.

Key tables:
- `profiles` - User profiles with roles
- `businesses` - Business accounts
- `themes` - Predefined themes
- `categories` - Menu categories
- `items` - Menu items
- `subscriptions` - Manual subscription management

## Subscription System

Subscriptions are managed manually via super admin dashboard. No Stripe integration.

1. Super admin sets `ends_at` date
2. Daily cron checks expiration
3. Expired subscriptions → business paused

## Theme System

Themes are configuration-only, no user customization:

- **Classic**: Red primary, white background
- **Minimal**: Black primary, light gray background
- **Dark**: Blue primary, dark background

Themes provide styling tokens, not components. One layout renders all themes.

## Super Admin Setup

1. Sign up normally
2. Run in Supabase SQL Editor:

```sql
UPDATE profiles 
SET role = 'super_admin' 
WHERE email = 'your@email.com';
```

Or use the helper function in `setup.sql`.

## License

Private - All rights reserved

