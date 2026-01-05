# Sample Data Instructions

## Two Options

### Option 1: Simple Version (Recommended)
Use `sample_data_simple.sql` - it automatically uses your first user and is easier to run.

### Option 2: Manual Version
Use `sample_data.sql` if you want more control over which users own which businesses.

## Quick Start (Recommended)

1. **Run the simple version:**
   - Open Supabase SQL Editor
   - Copy and paste `sample_data_simple.sql`
   - Run it
   - Done! ✅

This creates 3 businesses:
- **Brew & Bean Cafe** (Coffee Shop) - Classic theme
- **Mama Mia Italian** (Restaurant) - Minimal theme  
- **Sweet Dreams Bakery** (Bakery) - Dark theme

## What Gets Created

### Coffee Shop
- 3 categories: Hot Beverages, Cold Beverages, Pastries
- ~10 items total

### Restaurant
- 3 categories: Appetizers, Main Courses, Desserts
- ~10 items total

### Bakery
- 3 categories: Cakes, Cookies & Pastries, Fresh Breads
- ~11 items total

## View Your Menus

After running the SQL, visit:
- Coffee Shop: `http://localhost:3000/brew-bean-cafe`
- Restaurant: `http://localhost:3000/mama-mia-italian`
- Bakery: `http://localhost:3000/sweet-dreams-bakery`

## Customization

Want to change items or prices? Just modify the SQL before running, or update them through the admin dashboard at `/admin/menu`.

## Verification

After running, verify with:
```sql
SELECT b.name, COUNT(DISTINCT c.id) as categories, COUNT(i.id) as items
FROM businesses b
LEFT JOIN categories c ON c.business_id = b.id
LEFT JOIN items i ON i.category_id = c.id
GROUP BY b.id, b.name;
```

