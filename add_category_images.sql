-- Add image_url column to categories table
-- Run this in Supabase SQL Editor

-- Add image_url to categories if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'categories' AND column_name = 'image_url'
    ) THEN
        ALTER TABLE categories ADD COLUMN image_url text;
        RAISE NOTICE 'Added image_url column to categories';
    ELSE
        RAISE NOTICE 'image_url column already exists in categories';
    END IF;
END $$;

-- Verify the column was added
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'categories';

