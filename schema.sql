-- QR Menu Builder - Database Schema
-- Supabase PostgreSQL

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- TABLES
-- ============================================

-- Profiles table (extends auth.users)
CREATE TABLE profiles (
    user_id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email text NOT NULL,
    phone_number text NOT NULL,
    role text CHECK (role IN ('owner','super_admin')) DEFAULT 'owner',
    created_at timestamp DEFAULT now()
);

-- Themes table (predefined themes)
CREATE TABLE themes (
    id text PRIMARY KEY,
    name text NOT NULL,
    preview_image text
);

-- Businesses table
CREATE TABLE businesses (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id uuid REFERENCES profiles(user_id) ON DELETE CASCADE,
    name text NOT NULL,
    slug text UNIQUE NOT NULL,
    theme_id text DEFAULT 'classic' REFERENCES themes(id),
    status text CHECK (status IN ('active','paused')) DEFAULT 'active',
    created_at timestamp DEFAULT now()
);

-- Categories table
CREATE TABLE categories (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id uuid REFERENCES businesses(id) ON DELETE CASCADE,
    name text NOT NULL,
    position integer,
    created_at timestamp DEFAULT now()
);

-- Items table
CREATE TABLE items (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    category_id uuid REFERENCES categories(id) ON DELETE CASCADE,
    name text NOT NULL,
    description text,
    price numeric,
    available boolean DEFAULT true,
    created_at timestamp DEFAULT now()
);

-- Subscriptions table (manual management)
CREATE TABLE subscriptions (
    business_id uuid PRIMARY KEY REFERENCES businesses(id) ON DELETE CASCADE,
    ends_at timestamp NOT NULL,
    status text CHECK (status IN ('active','expired','paused')) DEFAULT 'active',
    created_at timestamp DEFAULT now(),
    updated_at timestamp DEFAULT now()
);

-- ============================================
-- INDEXES (Performance)
-- ============================================

CREATE INDEX idx_businesses_slug ON businesses(slug);
CREATE INDEX idx_businesses_owner_id ON businesses(owner_id);
CREATE INDEX idx_businesses_status ON businesses(status);
CREATE INDEX idx_categories_business_id ON categories(business_id);
CREATE INDEX idx_items_category_id ON items(category_id);
CREATE INDEX idx_items_available ON items(available);
CREATE INDEX idx_subscriptions_business_id ON subscriptions(business_id);
CREATE INDEX idx_subscriptions_status ON subscriptions(status);
CREATE INDEX idx_profiles_email ON profiles(email);

-- ============================================
-- SEED DATA
-- ============================================

-- Insert predefined themes
INSERT INTO themes (id, name, preview_image) VALUES
    ('classic', 'Classic', '/themes/classic-preview.png'),
    ('minimal', 'Minimal', '/themes/minimal-preview.png'),
    ('dark', 'Dark', '/themes/dark-preview.png')
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS on all tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE businesses ENABLE ROW LEVEL SECURITY;
ALTER TABLE themes ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE items ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;

-- ============================================
-- PROFILES RLS POLICIES
-- ============================================

-- Users can read their own profile
CREATE POLICY "Users can view own profile"
    ON profiles FOR SELECT
    USING (auth.uid() = user_id);

-- Users can update their own profile
CREATE POLICY "Users can update own profile"
    ON profiles FOR UPDATE
    USING (auth.uid() = user_id);

-- Users can insert their own profile (via trigger)
CREATE POLICY "Users can insert own profile"
    ON profiles FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- ============================================
-- THEMES RLS POLICIES
-- ============================================

-- Public read access to themes
CREATE POLICY "Themes are publicly readable"
    ON themes FOR SELECT
    USING (true);

-- ============================================
-- BUSINESSES RLS POLICIES
-- ============================================

-- Public can read active and paused businesses (paused shows disabled message)
CREATE POLICY "Public can view businesses"
    ON businesses FOR SELECT
    USING (status IN ('active', 'paused'));

-- Owners can read their own business (including paused)
CREATE POLICY "Owners can view own business"
    ON businesses FOR SELECT
    USING (auth.uid() = owner_id);

-- Owners can insert their own business
CREATE POLICY "Owners can create own business"
    ON businesses FOR INSERT
    WITH CHECK (auth.uid() = owner_id);

-- Owners can update their own business
CREATE POLICY "Owners can update own business"
    ON businesses FOR UPDATE
    USING (auth.uid() = owner_id);

-- Owners can delete their own business
CREATE POLICY "Owners can delete own business"
    ON businesses FOR DELETE
    USING (auth.uid() = owner_id);

-- ============================================
-- CATEGORIES RLS POLICIES
-- ============================================

-- Public can read categories for active businesses
CREATE POLICY "Public can view categories for active businesses"
    ON categories FOR SELECT
    USING (
        business_id IN (
            SELECT id FROM businesses WHERE status = 'active'
        )
    );

-- Owners can manage categories for their business
CREATE POLICY "Owners can manage own categories"
    ON categories FOR ALL
    USING (
        business_id IN (
            SELECT id FROM businesses 
            WHERE owner_id = auth.uid()
        )
    )
    WITH CHECK (
        business_id IN (
            SELECT id FROM businesses 
            WHERE owner_id = auth.uid()
        )
    );

-- ============================================
-- ITEMS RLS POLICIES
-- ============================================

-- Public can read items for active businesses
CREATE POLICY "Public can view items for active businesses"
    ON items FOR SELECT
    USING (
        category_id IN (
            SELECT c.id FROM categories c
            INNER JOIN businesses b ON c.business_id = b.id
            WHERE b.status = 'active'
        )
    );

-- Owners can manage items for their business
CREATE POLICY "Owners can manage own items"
    ON items FOR ALL
    USING (
        category_id IN (
            SELECT c.id FROM categories c
            INNER JOIN businesses b ON c.business_id = b.id
            WHERE b.owner_id = auth.uid()
        )
    )
    WITH CHECK (
        category_id IN (
            SELECT c.id FROM categories c
            INNER JOIN businesses b ON c.business_id = b.id
            WHERE b.owner_id = auth.uid()
        )
    );

-- ============================================
-- SUBSCRIPTIONS RLS POLICIES
-- ============================================

-- Owners can view their own subscription
CREATE POLICY "Owners can view own subscription"
    ON subscriptions FOR SELECT
    USING (
        business_id IN (
            SELECT id FROM businesses WHERE owner_id = auth.uid()
        )
    );

-- Note: Subscriptions INSERT/UPDATE/DELETE should be handled server-side
-- with service role key (super admin only)
-- No client-side policies for modifications

-- ============================================
-- TRIGGERS & FUNCTIONS
-- ============================================

-- Function to automatically create profile on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
    INSERT INTO public.profiles (user_id, email, phone_number, role)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'phone_number', ''),
        'owner'
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create profile on auth.users insert
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Function to update subscriptions.updated_at
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS trigger AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update subscriptions.updated_at
CREATE TRIGGER update_subscriptions_updated_at
    BEFORE UPDATE ON subscriptions
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Function to check and expire subscriptions (for cron job)
CREATE OR REPLACE FUNCTION public.check_expired_subscriptions()
RETURNS void AS $$
BEGIN
    -- Update expired subscriptions
    UPDATE subscriptions
    SET status = 'expired'
    WHERE ends_at < now()
    AND status = 'active';
    
    -- Pause businesses with expired subscriptions
    UPDATE businesses
    SET status = 'paused'
    WHERE id IN (
        SELECT business_id FROM subscriptions
        WHERE status = 'expired'
    )
    AND status = 'active';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- COMMENTS (Documentation)
-- ============================================

COMMENT ON TABLE profiles IS 'User profiles extending auth.users. One business per owner.';
COMMENT ON TABLE businesses IS 'Business accounts. Each owner has one business.';
COMMENT ON TABLE themes IS 'Predefined theme configurations. No user customization.';
COMMENT ON TABLE categories IS 'Menu categories with position ordering.';
COMMENT ON TABLE items IS 'Menu items belonging to categories.';
COMMENT ON TABLE subscriptions IS 'Manual subscription management. No Stripe integration.';

COMMENT ON COLUMN businesses.slug IS 'Unique URL slug for public menu: /{slug}';
COMMENT ON COLUMN businesses.status IS 'active = menu visible, paused = menu disabled';
COMMENT ON COLUMN subscriptions.ends_at IS 'Subscription expiration date. Manual entry by super admin.';

-- ============================================
-- INITIAL SETUP NOTES
-- ============================================

-- After running this schema:
-- 1. Create a super_admin profile manually:
--    UPDATE profiles SET role = 'super_admin' WHERE email = 'your@email.com';
-- 
-- 2. Set up cron job for subscription checks (Supabase Cron):
--    SELECT cron.schedule('check-subscriptions', '0 0 * * *', 'SELECT public.check_expired_subscriptions()');
--
-- 3. Super admin operations require service role key (server-side only)

