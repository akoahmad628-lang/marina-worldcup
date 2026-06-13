# Marina World Cup 2026 — Realtime Website

This version is made so daily admin changes, predictions, prediction counts, and winners show for everyone using the same public link.

## Files
- `index.html` public website
- `admin.html` admin control
- `winners.html` past winners
- `schema.sql` Supabase database setup

## Setup
1. Create a Supabase project.
2. Go to Supabase → SQL Editor → paste `schema.sql` → Run.
3. Go to Supabase → Project Settings → API.
4. Copy:
   - Project URL
   - anon public key
5. Open `index.html`, `admin.html`, and `winners.html`.
6. Replace:
   - `PASTE_SUPABASE_URL_HERE`
   - `PASTE_SUPABASE_ANON_KEY_HERE`
7. Upload all files to GitHub.
8. Redeploy on Vercel.

## Admin
Open `/admin.html` and use your private password.

## Important
This is a static website with Supabase. For stronger admin security later, add a backend/login system.
