-- Add Image Support to Database
-- Run this in Supabase SQL Editor

-- Add logo column to businesses
ALTER TABLE businesses 
ADD COLUMN IF NOT EXISTS logo_url text;

-- Add image_url column to items
ALTER TABLE items 
ADD COLUMN IF NOT EXISTS image_url text;

-- Add image_url to categories (optional, for category headers)
ALTER TABLE categories 
ADD COLUMN IF NOT EXISTS image_url text;

