# Website Reset — Checklist

Written by Claude (Claude Code), 4 November 2026 (Rulebook W1): every point from the user's request, ticked as it's done. Research: [Website Reset — Pages, SEO and AI Search](<../Research/Research Reports/Website/Website Reset — Pages, SEO and AI Search — 4 November 2026.md>).

**New Figma file:** [Design-System](https://www.figma.com/design/DCLa48e0M68Y2miWj8OoiN/Design-System) · **Old designs, reference only:** [Design](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=1268-11389)

## How we work

- Design first, one section at a time. The next section starts only after the user approves the last.
- Development starts only after the designs are approved.
- Work on `main`, website work in this root `website/` folder.
- App facts come from the current Android code, never memory.

## Research

- [x] What the website needs, and whether Delete account stays (later dropped too, 4 Nov 2026)
- [x] Pages Google Play and the App Store need
- [x] Read the rejection message
- [x] Current Android features, from the code
- [x] SEO, and how AI tools find and read a site
- [x] What to keep from the old website
- [x] Hero copy: what people look for first
- [x] Which store button each device sees
- [x] What people want to know after the hero
- [x] What people need to know about Free and Plus, and how the copy should read
- [x] What keeps people going: progress, streaks and missed days, and how the copy should read
- [x] How the app fits into a day: routines, reminders, tasks and widgets, and how the copy should read
- [x] Each of those as its own section: alarms, kinds of notification, tasks and every widget
- [x] What the homepage still missed: privacy, offline, backup, a new phone
- [x] What the Privacy page must say, from the code and the stores' rules
- [x] What people need help with, for the Support page
- [x] What the Terms page must say, and what people fear about paying

## Design (Figma, for the user's approval)

- [x] Home · Hero: approved by the user, 4 Nov 2026 (1.1 to 1.4; older versions are on Figma's archive page)
- [x] Home · Every kind of habit: approved by the user, 4 Nov 2026 (2.1, 2.2)
- [x] Home · Free and Plus: approved by the user, 4 Nov 2026 (3.1, 3.2)
- [x] Home · Progress and streaks: approved by the user, 4 Nov 2026, after the changes they asked for (4.1, 4.2)
- [x] Home · Routines: approved by the user, 4 Nov 2026 (5.1, 5.2)
- [x] Home · Reminders and alarms: approved by the user, 4 Nov 2026 (6.1, 6.2)
- [x] Home · Tasks: approved by the user, 4 Nov 2026 (7.1, 7.2)
- [x] Home · Widgets: approved by the user, 4 Nov 2026 (8.1, 8.2)
- [x] Checked the whole homepage for gaps, 4 Nov 2026: one more section, then a closing Download and footer; no Questions section ([why](<../Research/Research Reports/Website/Private and Backed Up — What the Homepage Still Missed — 4 November 2026.md>))
- [x] Home · Private and backed up: approved by the user, 4 Nov 2026 (9.1, 9.2)
- [x] Home · Download and footer: approved by the user, 4 Nov 2026 (10.1, 10.2). The homepage is complete
- [x] Privacy: approved by the user, 4 Nov 2026 (`Page · Privacy`)
- [x] Support: approved by the user, 4 Nov 2026 (`Page · Support`)
- [x] Terms: approved by the user, 4 Nov 2026 (`Page · Terms`)
- [x] Delete your data: dropped by the user, 4 Nov 2026 (no accounts; Support answers it)
- [x] Refunds: dropped by the user, 4 Nov 2026 (the stores' billing; Support answers it)
- [ ] Features
- [ ] Plus
- [ ] Download
- [ ] About
- [ ] Often Enough facts
- [ ] Search pages: no subscription, no account, widgets, quit and cut down

## Development (after approval)

- [x] Build every page as static HTML in `website/` (`website/build.py`, sources in `website/src/`). Features, Plus, Download, About, facts and search pages aren't designed yet
  - [x] Privacy: built, matches Figma at 1440 and 390, passes `tests/responsive-check.mjs` at 14 widths
  - [x] Support: built and checked the same way
  - [x] Terms: built and checked the same way
  - [x] Home, one section at a time
    - [x] Hero: matches Figma at 1440 and 390, passes `tests/responsive-check.mjs` at 14 widths and `tests/device-check.mjs` (store button per device, no script, the live count, reduced motion)
    - [x] Every kind of habit: matches Figma at 1440 and 390, checked at 14 widths. "See every feature" waits for a Features page
    - [x] Free and Plus: matches Figma at 1440 and 390, checked at 14 widths. "See what's in Plus" waits for the Plus page
    - [x] Progress and streaks: matches Figma at 1440 and 390, checked at 14 widths. "See how progress works" waits for a Features page
    - [x] Routines: matches Figma at 1440 and 390, checked at 14 widths. "See how routines work" waits for a Features page
    - [x] Reminders and alarms: matches Figma at 1440 and 390, checked at 14 widths. "See how reminders work" waits for a Features page
    - [x] Tasks: matches Figma at 1440 and 390, checked at 14 widths (the Repeating phone is cut below a whole row on a computer, 18 px taller than Figma, because Figma cut through words). "See how tasks work" waits for a Features page
    - [x] Widgets: matches Figma at 1440 and 390, checked at 14 widths; two columns on a tablet. Smoking counts from Figma's 19 days, so the Best 45 days pill stays true, while the hero's count is 94 days. "See every widget" waits for a Features page
    - [x] Private and backed up: matches Figma at 1440 and 390, checked at 14 widths, tablets too. "Read our privacy policy" links to Privacy
    - [x] Download and footer: matches Figma at 1440 and 390, checked at 14 widths. The footer shows only pages that exist, and "Coming soon to" above the two stores until they're live
- [x] Remove what's no longer true (iPad, Apple Watch, Plus Family, accounts, the Work in progress banner); the old verification build and checks went too
- [x] `/delete-account`, `/delete-your-data` and `/refunds` redirect to Support's answers; `/privacy` stays where it is. `/help`, `/privacy-policy`, `/terms-and-conditions` and `/download` redirect too
- [x] Everything in [Website Build Notes](<Website Build Notes.md>): store buttons by device, the live count, the floating cards, Every kind of habit, Free and Plus, Progress and streaks, Routines, Reminders and alarms, Tasks, Widgets, Private and backed up, Download and footer, Privacy, Support, Terms
- [x] Canonicals, meta descriptions, Open Graph (`og.png`), structured data, an icon set
- [x] `sitemap.xml`, `robots.txt`, `llms.txt`, real 404 (no Figma design: built in the same style)
- [x] One address: `pages.dev` noindex is done in `_headers` (live once published), and every page names its canonical. `www` goes to the bare domain with a 301 (Cloudflare Redirect Rule, added by the user 4 Nov 2026; checked with curl, paths and query strings kept)
- [x] Speed check on a cheap phone, in Chrome slowed to one (360 wide, CPU 6×, slow 4G): first paint and largest paint 0.87–1.09 s, no layout shift, scrolling a steady 17 ms a frame with none over 50 ms. Not yet checked on a real phone
- [x] Published with `wrangler pages deploy`, 4 Nov 2026, on the user's word (deployment 3aa33e50). Checked live: pages, redirects, `www`, `pages.dev` noindex, CSP, no script or email changes at the edge, crawlers, 14 widths, device check. Not yet looked at on a real phone

## Needs the user

- [x] Cloudflare: allow AI crawlers, Training too (the user, 4 Nov 2026; 14 crawler names checked, all 200, and Cloudflare's lines are gone from `robots.txt`)
- [x] Cloudflare: a Redirect Rule from `www.oftenenough.com` to `oftenenough.com`, keeping the path (added by the user, 4 Nov 2026)
- [ ] Whether the user's real name appears on About
- [x] The developer's name for Privacy: Koyalakonda Lalith Sai Charan, the user's legal name (given 4 Nov 2026)
- [ ] When the iPhone app is rebuilt: leave out Share Usage (PostHog), or the homepage and Privacy must change first
- [ ] Before submitting the iPhone app: check Privacy against Apple's own guideline 5.1.1 text
- [x] `support@oftenenough.com` works through Cloudflare Email Routing (set up by the user, 4 Nov 2026; MX and SPF records checked). The user's test email arrived, 4 Nov 2026
- [x] The apps' Contact us write to `support@oftenenough.com` (`Support.kt`, `HelpView.swift`)
- [ ] A way to move Plus between iPhone and Android by hand, as Support promises (D16)
- [x] Search Console and Bing Webmaster Tools (the user, 4 Nov 2026: verified, sitemap sent, four pages submitted to each). Check what's listed around 11 Nov
- [x] Play Console: Data safety, Sign in details and the Google consent screen no longer describe accounts (the user, 4 Nov 2026)
- [x] Play Console: reviewers get a Google Play promo code (in Sign in details, 4 Nov 2026; the codes end 31 Dec 2026)
- [x] Play Console: the two Plus Family products are switched off (D16), and the full-screen notification declaration is filled in (the user, 4 Nov 2026)
- [ ] Apple: what the EU's trader rules show publicly (an individual's address, phone and email on the EU page). Google Play: Trader declared by the user, 4 Nov 2026; a separate phone number still to replace the personal one
- [ ] When submitting the iPhone app: whether it may run on Macs (we're phones only)
- [ ] The price of Plus (printed on the site only once it's settled)
- [ ] Terms: read its three promises (what's free stays free; Plus never becomes a subscription; Plus moved by hand), and decide with a lawyer which country's law applies
