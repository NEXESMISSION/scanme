# SEO Setup Guide for Scaniha.com

## ✅ What's Already Done

- ✅ Dynamic sitemap.xml with all active businesses
- ✅ Robots.txt configured
- ✅ Structured data (JSON-LD) for restaurant menus
- ✅ Open Graph tags for social sharing
- ✅ Twitter Card metadata
- ✅ Enhanced page metadata

## 🚀 Next Steps

### 1. Set Environment Variable

**In your deployment platform (Vercel/Netlify/etc.):**
```
NEXT_PUBLIC_SITE_URL=https://scaniha.com
```

**Or add to `.env.local` for local development:**
```
NEXT_PUBLIC_SITE_URL=https://scaniha.com
```

### 2. Test Your SEO Files

After deployment, verify these URLs work:
- **Sitemap**: https://scaniha.com/sitemap.xml
- **Robots.txt**: https://scaniha.com/robots.txt

### 3. Submit to Search Engines

#### Google Search Console
1. Go to https://search.google.com/search-console
2. Add property: `https://scaniha.com`
3. Verify ownership (DNS or HTML file)
4. Submit sitemap: `https://scaniha.com/sitemap.xml`

#### Bing Webmaster Tools
1. Go to https://www.bing.com/webmasters
2. Add site: `https://scaniha.com`
3. Verify ownership
4. Submit sitemap: `https://scaniha.com/sitemap.xml`

### 4. Test Social Media Previews

Test how your pages look when shared:

- **Facebook**: https://developers.facebook.com/tools/debug/
  - Enter: `https://scaniha.com/[business-slug]`
  - Click "Scrape Again" to refresh cache

- **Twitter**: https://cards-dev.twitter.com/validator
  - Enter: `https://scaniha.com/[business-slug]`

- **LinkedIn**: https://www.linkedin.com/post-inspector/
  - Enter: `https://scaniha.com/[business-slug]`

### 5. Verify Structured Data

- **Google Rich Results Test**: https://search.google.com/test/rich-results
  - Enter any menu page URL
  - Should show "Restaurant" schema detected

- **Schema Markup Validator**: https://validator.schema.org/
  - Paste page HTML or URL
  - Verify Restaurant schema is valid

### 6. Monitor Performance

**Google Search Console:**
- Check indexing status weekly
- Monitor search performance
- Fix any crawl errors

**Analytics:**
- Track organic traffic
- Monitor which pages rank well
- Optimize based on data

## 📋 SEO Checklist

- [ ] Environment variable `NEXT_PUBLIC_SITE_URL` set
- [ ] Sitemap accessible at `/sitemap.xml`
- [ ] Robots.txt accessible at `/robots.txt`
- [ ] Google Search Console configured
- [ ] Sitemap submitted to Google
- [ ] Bing Webmaster Tools configured
- [ ] Sitemap submitted to Bing
- [ ] Facebook preview tested
- [ ] Twitter preview tested
- [ ] Structured data validated
- [ ] Google Rich Results test passed

## 🔍 What Gets Indexed

**Indexed Pages:**
- ✅ Homepage (`/`)
- ✅ All active business menu pages (`/{slug}`)
- ✅ Login page (`/login`)
- ✅ Signup page (`/signup`)

**Not Indexed (Protected):**
- ❌ Admin pages (`/admin/*`)
- ❌ Super admin pages (`/super-admin/*`)
- ❌ API routes (`/api/*`)

## 📊 Expected Results

After proper setup, you should see:
- Menu pages appearing in Google search results
- Rich snippets showing restaurant information
- Better social media sharing previews
- Improved search rankings over time

## 🆘 Troubleshooting

**Sitemap not updating?**
- Check that businesses have `status = 'active'`
- Verify businesses haven't expired
- Check database connection

**Structured data not showing?**
- Use Google Rich Results Test to debug
- Check browser console for errors
- Verify business has categories/items

**Social previews not working?**
- Clear cache in Facebook/Twitter debuggers
- Verify Open Graph tags in page source
- Check that logo URLs are accessible

## 📞 Need Help?

If you encounter issues:
1. Check browser console for errors
2. Verify environment variables are set
3. Test URLs directly in browser
4. Use Google Search Console for detailed errors

