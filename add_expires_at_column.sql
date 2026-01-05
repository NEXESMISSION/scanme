-- Add expires_at column to businesses table for time management
-- Run this in Supabase SQL Editor

-- Add expires_at column if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'businesses' AND column_name = 'expires_at'
    ) THEN
        ALTER TABLE businesses ADD COLUMN expires_at timestamptz DEFAULT NULL;
        RAISE NOTICE 'Added expires_at column to businesses';
    ELSE
        RAISE NOTICE 'expires_at column already exists';
    END IF;
END $$;

-- Create function to auto-pause expired businesses
CREATE OR REPLACE FUNCTION check_expired_businesses()
RETURNS void AS $$
BEGIN
    UPDATE businesses
    SET status = 'paused'
    WHERE expires_at IS NOT NULL
      AND expires_at < NOW()
      AND status = 'active';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Optional: Create a cron job to run every hour (requires pg_cron extension)
-- SELECT cron.schedule('check-expired-businesses', '0 * * * *', 'SELECT check_expired_businesses();');

-- Verify column was added
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'businesses' AND column_name = 'expires_at';

