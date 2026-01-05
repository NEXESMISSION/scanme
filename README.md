# QR Menu Builder

A modern, full-featured QR code menu builder for restaurants and cafes built with Next.js 14, Supabase, and Tailwind CSS.

## Features

- 🎨 **Three Beautiful Themes** - Classic, Dark, and Minimal designs
- 📱 **Mobile Responsive** - Works perfectly on all devices
- 🔐 **Secure Authentication** - Email/password with role-based access
- 🌐 **Arabic RTL Support** - Full Arabic translation and RTL layout
- 📸 **Image Support** - Upload logos, item images, and category banners
- 🔗 **Social Media Links** - Add Facebook, Instagram, Twitter, WhatsApp, and website links
- ⏱️ **Time Management** - Subscription expiration tracking and countdown
- 👨‍💼 **Admin Dashboard** - Simple, clean interface for managing your menu
- 👑 **Super Admin** - Manage all businesses and subscriptions

## Tech Stack

- **Next.js 14** (App Router)
- **TypeScript**
- **Supabase** (Auth, Database, Storage)
- **Tailwind CSS**
- **PostgreSQL** (via Supabase)

## Getting Started

### Prerequisites

- Node.js 18+ 
- npm or yarn
- Supabase account

### Installation

1. Clone the repository:
```bash
git clone https://github.com/NEXESMISSION/scanme.git
cd scanme
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
Create a `.env.local` file:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
```

4. Run database migrations:
- Run `schema.sql` in Supabase SQL Editor
- Run `add_images_schema.sql`
- Run `add_social_media.sql`
- Run `add_expires_at_column.sql`

5. Start the development server:
```bash
npm run dev
```

6. Open [http://localhost:3000](http://localhost:3000) in your browser.

## Deployment on Vercel

1. Push your code to GitHub

2. Go to [Vercel](https://vercel.com) and sign in

3. Click "New Project" and import your GitHub repository

4. **Important**: Use a unique project name (not "scanme" if it's taken)

5. Add environment variables in Vercel dashboard:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`

6. Click "Deploy"

## Environment Variables

| Variable | Description |
|----------|-------------|
| `NEXT_PUBLIC_SUPABASE_URL` | Your Supabase project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Your Supabase anonymous key |
| `SUPABASE_SERVICE_ROLE_KEY` | Your Supabase service role key (for super admin) |

## Database Setup

See the SQL files in the root directory:
- `schema.sql` - Main database schema
- `add_images_schema.sql` - Image support columns
- `add_social_media.sql` - Social media links columns
- `add_expires_at_column.sql` - Expiration tracking
- `setup_storage.sql` - Storage bucket setup

## Project Structure

```
├── app/                    # Next.js app directory
│   ├── [slug]/            # Public menu pages
│   ├── admin/             # Owner dashboard
│   ├── super-admin/       # Super admin dashboard
│   └── api/               # API routes
├── components/            # React components
│   ├── admin/            # Admin dashboard components
│   ├── menu/             # Menu display components
│   └── auth/             # Authentication components
├── lib/                   # Utility libraries
│   ├── db/               # Database functions
│   ├── supabase/         # Supabase clients
│   └── themes/           # Theme configurations
└── public/               # Static assets
```

## License

MIT
