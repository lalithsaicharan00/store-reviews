# Cards — report 13

Source: `App Store Reports/13. Productive - Habit Tracker - Daily Routine & Goals Planner (REPORT).md`  
90 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 2
- [Must-haves](#must-haves) — 2
- [Must never break](#must-never-break) — 17
- [Features](#features) — 11
- [Monetization](#monetization) — 8
- [Insights (the why)](#insights-the-why) — 11
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 8
- [Dated events and trends](#dated-events-and-trends) — 9
- [Positioning](#positioning) — 1
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 8
- [Things to do](#things-to-do) — 4
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 6

## Product rules

### R13-085 — Move the first paywall behind engagement: the actual purchase trigger is hitting the cap while engaged, yet the paywall fires 3–15 times in the first three minutes — delay the first interstitial until the user completes habits on three separate days

- **Where:** §8.4 #2 Move the first paywall behind engagement — three separate days
- **This app does:** paywall before engagement
- **User reaction:** blocked-conversion
- **Magnitude:** cap-trigger in 836 buyers; 3–15 interstitials in first 3 minutes
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C137 Show the paywall at the moment of need, not on app open

### R13-088 — Do not gate exact reminder times — a habit app's core mechanic, the most-resented single gate in the corpus, and free competitors provide it

- **Where:** §8.4 #5 Do not gate exact reminder times — a habit app's core mechanic
- **This app does:** exact reminder times paid
- **User reaction:** complaint
- **Magnitude:** U-exact-time 227 (1.14%) mean 3.90
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `2246849667`, `2172919142`, `2544359717`, `6953060121`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free

## Must-haves

### R13-070 — Privacy: a Jul 2017 privacy-policy revision triggered an 11-review backlash in one month (one reviewer about to upgrade stopped); 2024–26 a modern concern — 'By far the worst user and metadata tracking policy of any of the habit trackers'; a long-time user read disclosure to law enforcement plus location tracking and deleted; location collection has no stated purpose and reviewers say so ('Keeps nagging about turning location on… No, you don't need it')

- **Where:** §7.7 Trend 6 — Privacy: two separate, dated flare-ups; location collection has no stated product purpose
- **This app does:** location prompts; broad data policy
- **User reaction:** complaint
- **Magnitude:** C-privacy 38 mean 1.55; Jul 2017 n=11 in one month
- **Direction for us:** must-have · **Report confidence:** weak, reputationally sharp · **Generalisable:** yes
- **Review IDs:** `1669007653`, `1669583149`, `1672427701`, `1701657469`, `11792920885`, `13792517171`, `6803835963`, `6044332210`, `4511478137`, `2920926816`
- **Canonical:** C085 Address tracking / privacy visibly; C096 Privacy and discretion stack

### R13-075 — Put a working 'Manage / cancel subscription' link inside the app — would address ~1 in 4 Korean reviews on its own

- **Where:** §8.1 #3 Put a working 'Manage / cancel subscription' link inside the app
- **This app does:** no in-app cancel
- **User reaction:** 1★-burst
- **Magnitude:** M-cancel-hard 448 (2.26%) mean 1.54; KR 24.7%
- **Direction for us:** must-have · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C112 In-app cancellation

## Must never break

### R13-005 — For every reviewer who says they chose to buy, there is one who says they were charged without consent — the two populations are nearly the same size; that ratio, not the price, is the company's core problem

- **Where:** EXECUTIVE SUMMARY #2 For every reviewer who says they chose to buy, there is one who says they were charged without consent
- **This app does:** trial auto-converting; undisclosed recurring charge
- **User reaction:** 1★-burst
- **Magnitude:** voluntary 836 (4.21%) mean 3.06; involuntary 856 (4.31%) mean 1.27, 89.0% 1★
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R13-008 — A specific, diagnosable, still-unfixed bug bricks the app on launch — stuck on 'Update in progress' — in three waves (Nov 2019, Oct 2020, Sep 2025 → Aug 2026); one 2026 review states the root cause: 'Will not launch without internet — stuck on update in progress until internet is available'; a local habit tracker that cannot open offline is a fixable, high-severity defect

- **Where:** EXECUTIVE SUMMARY #5 A specific, diagnosable, still-unfixed reliability bug that bricks the app on launch
- **This app does:** launch blocked on a network update check
- **User reaction:** 1★-burst
- **Magnitude:** three waves; 46 hand-audited reviews (43 true positives)
- **Direction for us:** must-never-break · **Report confidence:** weak by volume, severe by nature · **Generalisable:** yes
- **Review IDs:** `14453446467`
- **Canonical:** C031 Crashes / launch failures; C139 Cache entitlements locally — never block a paid surface on a live server check; C188 The app must open offline — never block launch on a network call

### R13-013 — The paid built-in timer / Pomodoro stops when the screen locks

- **Where:** §2.1 Built-in timer stops when the screen locks
- **This app does:** timer does not run in background
- **User reaction:** complaint
- **Magnitude:** 2 cited IDs
- **Direction for us:** must-never-break · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `3489233437`, `4573131040`
- **Canonical:** C066 Focus timer

### R13-021 — Some billing is taken outside Apple and cannot be cancelled in iOS Settings — the standard cancel path the user knows does not work

- **Where:** §2.5 Billing taken outside Apple, un-cancellable in Settings
- **This app does:** off-Apple billing
- **User reaction:** 1★-burst
- **Magnitude:** qualitative, 3 IDs
- **Direction for us:** must-never-break · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `8157301628`, `8981908261`, `7352163199`
- **Canonical:** C029 Billing must be exactly right; C112 In-app cancellation

### R13-027 — Reliability tail: iPad layout problems, Apple Watch broken for extended periods, widget long absent, update regressions, lag, notification spam, wrong day of week, auth prompts, cannot add/edit/delete, premium not applied, purchase failure

- **Where:** §3.1 D-ipad; D-watch; D-widget; D-update-regression; D-perf; D-notif-spam; D-wrongday; D-auth-prompt; D-add-broken; D-cannot-edit-delete; D-premium-not-applied; M-purchase-fail
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** D-ipad 277 (1.40%) mean 2.88; D-watch 210 (1.06%) 3.55; D-widget 186 (0.94%) 3.58; D-update-regression 87 (0.44%) 2.39; D-perf 56; D-notif-spam 33; D-wrongday 27 mean 2.63; D-auth-prompt 7; D-add-broken 6; D-cannot-edit-delete 16; D-premium-not-applied 2; M-purchase-fail 19
- **Direction for us:** must-never-break · **Report confidence:** weak–meaningful · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C040 Widgets must not go blank, stale or disagree with the app; C083 Performance must not degrade with habit count; C141 Native iPad layout; C175 Updates must not break function or wipe progress

### R13-029 — The five lowest-mean themes reliably produce a 1★: fake-review allegations, trial auto-charge (the single most damaging mechanic — 5.55% of every review ever written about this app, 999 of 1,102 one-star), support failure, canned replies, refund friction (a distinct, separate injury)

- **Where:** §3.3 The five findings with the lowest mean ratings table (verbatim); M-trial-autocharge is the most consequential single number
- **This app does:** trial auto-charge; unreachable support; canned replies; refund friction
- **User reaction:** 1★-burst
- **Magnitude:** Rank | Theme | n | Mean★ | 1★ share of theme | Interpretation ; 1 | C-fake-reviews | 5 | 1.00 | 100% | Too small to act on, but every instance is a 1★ ; 2 | M-trial-autocharge | 1,102 | 1.20 | 90.7% | The single most damaging mechanic in the product ; 3 | D-support | 57 | 1.35 | 78.9% | Support failure converts a fixable issue into a permanent 1★ ; 4 | C-canned-reply | 20 | 1.40 | 75.0% | Copy-paste replies actively make ratings worse ; 5 | M-refund | 521 | 1.42 | 82.0% | Refund friction is a distinct, separate injury
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C036 A support channel that exists, is reachable outside the app, and answers; C109 A free trial must be a real trial; C189 Never post canned public replies — answer the specific complaint or don't reply

### R13-036 — Broken capabilities: iCloud sync does not work (the most important item — 8.90% of 3★ reviews where people still want to like the app, rising 0.7% in 2015 to 7.4% in 2026, the defect most likely costing renewals), crashes, data/streak loss, reminders don't fire, reordering doesn't persist, bricked on launch, timer stops when locked, wrong day of week, cannot edit/delete

- **Where:** §3.5 Broken existing capabilities table (verbatim); the sync failure is the most important item
- **This app does:** sync advertised, non-functional
- **User reaction:** 1★-burst
- **Magnitude:** Defect | n | % | Signal | Evidence ; iCloud sync does not work | 497 | 2.50% | meaningful | `3386723296` `3070069271` `4356794558` `5778564141` ; Crashes / won't open | 263 | 1.32% | meaningful | `5121372777` `6579249054` `9017392549` ; Data / streak loss | 228 | 1.15% | meaningful | `1893314966` `6525723770` `9703849036` `3397938852` ; Reminders don't fire | 196 | 0.99% | emerging | `1292927622` `1867635363` `3331399691` `1362664639` ; Habit reordering doesn't persist | 77 | 0.39% | weak | `5343328336` `5538242964` `5454764650` `7881326098` ; App bricked on launch ("Update in progress") | 46 | 0.23% | weak | Part 8.4 ; Timer stops when the screen locks | 25 | 0.13% | weak | `4573131040` `3489233437` ; Wrong day of week displayed | 27 | 0.14% | weak | `1812417285` `2312903618` `2488005855` `8248675525` ; Cannot edit or delete a habit | 16 | 0.08% | ignore | `3207908444` `6542346491` `8577355284` ; D-sync 8.90% of 3★; 0.7% (2015) → 7.4% (2026)
- **Direction for us:** must-never-break · **Report confidence:** meaningful, worsening · **Generalisable:** yes
- **Review IDs:** `3386723296`, `3070069271`, `4356794558`, `5778564141`, `5121372777`, `1893314966`, `1292927622`, `5343328336`, `1812417285`, `3207908444`
- **Canonical:** C030 Sync must work — and prove it; C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C039 Reminders fire reliably, once; C073 Manual reordering, renaming and editing of habits/tasks — free; C188 The app must open offline — never block launch on a network call

### R13-037 — Habit reordering does not persist — a small but repeated defect

- **Where:** §3.5 Habit reordering doesn't persist
- **This app does:** reorder resets
- **User reaction:** complaint
- **Magnitude:** D-reorder 77 (0.39%, weak) mean 3.36
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `5343328336`, `5538242964`, `5454764650`, `7881326098`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R13-050 — Involuntary charges: 89% one-star; half from mainland China and 11% from Korea; the mechanics in reviewers' own accounts: the trial cannot start without first authorising a subscription; the plan defaults to the most expensive annual tier ('I didn't even get to choose, it just charged the highest'); no cancel control in the app and the subscription does not appear in Apple's list until after the charge; the charge lands after the app was deleted; in China password-free payment (免密支付) means no authentication step interrupts the charge; refunds declined with support redirecting to Apple and Apple back

- **Where:** §5.3 Involuntary charges — n = 856, mean 1.27; geography table (verbatim); the mechanics reviewers describe
- **This app does:** subscription-first trial defaulting to the dearest tier; no in-app cancel
- **User reaction:** 1★-burst
- **Magnitude:** 856 (4.31%) mean 1.27; 1★ 762 (89.0%); M-trial-autocharge 84.3%, M-refund 20.6%, M-cancel-hard 13.2%; Storefront | n | % of segment ; China mainland | 437 | 51.1% ; United States | 121 | 14.1% ; South Korea | 97 | 11.3% ; Canada | 28 | 3.3% ; Brazil | 26 | 3.0% ; United Kingdom | 20 | 2.3% ; Russia | 19 | 2.2% ; Mexico | 13 | 1.5%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `3272238239`, `2380437896`, `3233093755`, `2178452576`, `3183095608`, `3163329581`, `2266470444`, `3366758790`, `2475980289`
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial; C112 In-app cancellation; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date; C187 No paid acquisition into an auto-converting trial in frictionless-payment markets

### R13-053 — Post-purchase problems among payers: charged twice / wrong tier, entitlement revoked or lost after an update, sync doesn't work despite paying, data/streak loss, reminders don't fire, crashes

- **Where:** §5.5 Post-purchase problems affecting people who did pay table (verbatim)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Problem | n in paid-evidence segment | segment rate | global n ; Charged twice / wrong tier / price inconsistency | 26 | 1.50% | 86 ; Entitlement revoked or lost after an update | 60 | 3.46% | 84 ; Sync doesn't work despite paying | 56 | 3.23% | 497 ; Data or streak loss | 33 | 1.90% | 228 ; Reminders don't fire despite paying | 32 | 1.84% | 196 ; App crashes despite paying | 31 | 1.79% | 263
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it; C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R13-061 — Two localisation defects: the wrong language served ('I am from Turkey but this app language is Korean. I can't turn it into Turkish or English' — 41 net votes, the 5th most-upvoted review; a Czech user served Italian, Ukrainians served Russian) and advertised languages that do not exist ('Fake Czech — it's not in Czech at all, as shown in the photos and description')

- **Where:** §6.7 Two distinct localisation defects: wrong language served; advertised languages that do not exist
- **This app does:** locale detection wrong; listing claims unshipped languages
- **User reaction:** 1★-burst
- **Magnitude:** 4 wrong-language IDs; 1 fake-language ID (2025)
- **Direction for us:** must-never-break · **Report confidence:** weak volume, high visibility · **Generalisable:** yes
- **Review IDs:** `1789316870`, `3343174115`, `8800823899`, `6475424640`, `12911930158`
- **Canonical:** C027 Localise early — it unlocks revenue; C114 Ads must match the app

### R13-067 — The app performs a blocking, network-dependent data migration on launch ('Why is there even an update inside the app? Those are loaded via the App Store'); when it fails or the device is offline the app is unopenable — a design error, not just a bug — and the Oct 2020 wave also destroyed data on reinstall ('lost almost 3 years of habit tracking'); hits paying subscribers; recurred across seven years; the strongest 'fix this week' candidate in the report

- **Where:** §7.4 Trend 3 — App-bricking launch failure. Three waves, still unfixed in 2026; waves table (verbatim); the root cause is stated; the strongest candidate for 'fix this week'
- **This app does:** blocking network update check on launch
- **User reaction:** 1★-burst
- **Magnitude:** Wave | Period | n | Evidence ; 1 | Nov 2019 | 5 | `5111443326` `5121372777` `5129943624` `5130400039` ; 2 | Oct 2020 (peak: 5.9% of that month's 287 reviews) | ~17 | `6513718209` `6514576183` `6515243916` `6515887759` `6522720688` `6523909120` `6525011522` `6556727084` `6557166073` `6560866141` `6563648888` `6569375125` `6572149626` `6574904910` `6577338106` `6579249054` `6591236625` ; 3 | Sep 2025 → Aug 2026 | 8 | `13099718036` `13101529734` `13200146012` `13595945455` `13634977398` `14453446467` `12844697075` `13019846620` ; Oct 2020 peak 5.9% of 287 reviews; 43 of 46 true positives
- **Direction for us:** must-never-break · **Report confidence:** weak by volume, severe by nature · **Generalisable:** yes
- **Review IDs:** `5111443326`, `6513718209`, `6557166073`, `6525723770`, `6515887759`, `6569375125`, `13099718036`, `14453446467`, `12844697075`
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C188 The app must open offline — never block launch on a network call

### R13-073 — Let the trial start without first authorising a subscription — trial ends, THEN ask; removes the corpus's single largest 1★ cause

- **Where:** §8.1 #1 Let the trial start without first authorising a subscription
- **This app does:** subscription-first trial
- **User reaction:** 1★-burst
- **Magnitude:** M-trial-autocharge 1,102 (5.55%) mean 1.20, 999 one-star
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C109 A free trial must be a real trial

### R13-074 — Send a pre-charge reminder 48h before the trial converts, by push and email — reviewers repeatedly say they simply forgot and were given no warning

- **Where:** §8.1 #2 Send a pre-charge reminder 48h before the trial converts, by push and email
- **This app does:** no pre-charge reminder
- **User reaction:** 1★-burst
- **Magnitude:** 5 cited IDs
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `2761367882`, `3245169646`, `2922764410`, `4547651109`, `6437141830`
- **Canonical:** C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R13-076 — Never default the trial to the most expensive tier — let the user pick and show the price before the Apple sheet; removes the 'I never chose this plan' complaint

- **Where:** §8.1 #4 Never default the trial to the most expensive tier; show the price before the Apple sheet
- **This app does:** defaults to dearest annual tier
- **User reaction:** 1★-burst
- **Magnitude:** M-price-tiers 42 mean 1.95
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `3272238239`, `2380437896`, `2072447786`, `3013464875`
- **Canonical:** C109 A free trial must be a real trial; C113 One stable, disclosed price — no discount wheels

### R13-081 — Fix the blocking on-launch update path: a habit tracker must open offline and must never gate its local data behind a network call — make the migration non-blocking, cache locally, never wipe on reinstall

- **Where:** §8.2 Immediate — the launch-failure bug: a habit tracker must open offline and must never gate its local data behind a network call
- **This app does:** network-blocked launch; wipe on reinstall
- **User reaction:** 1★-burst
- **Magnitude:** D-stuck-updating 46; Oct 2020 5.9% of month
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14453446467`, `12844697075`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C139 Cache entitlements locally — never block a paid surface on a live server check; C188 The app must open offline — never block launch on a network call

### R13-083 — Make iCloud sync actually work and show sync state in the UI — the fastest-worsening dimension

- **Where:** §8.3 #1 Make iCloud sync actually work, and show sync state in the UI
- **This app does:** sync broken, no state shown
- **User reaction:** complaint
- **Magnitude:** D-sync 497 (2.50%); 8.90% of 3★; 0.9% → 5.7% across eras
- **Direction for us:** must-never-break · **Report confidence:** recommendation (near-term) · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it

## Features

### R13-011 — Feature inventory from reviews with gating: named habits with icons/colours (free, count-capped), daily check-off (free), time-of-day buckets (free), exact-clock reminder times (PAID — the single most resented gate), streaks/'ideal day' (free), statistics (tiered), notes (limited), timer/Pomodoro (paid, stops when the screen locks), Apple Watch (exists, broken for long periods), widget (long absent then present), iCloud sync (advertised, widely non-functional), network account (sign-up path frequently broken), Siri Shortcuts (broken), Challenges/Explore tabs (~2020, partly paid), templates (free), data export (absent), Android/web/macOS (absent), Apple Health (absent), localisation (effectively absent; screenshots show languages the app lacks)

- **Where:** §2.1 Feature inventory derived from reviews table (verbatim)
- **This app does:** see table
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence of existence | Gating reviewers report ; Create named habits with icons and colours | Universal across corpus | Free, but count-capped ; Daily check-off (swipe to Done / Skip) | Universal | Free ; Time-of-day buckets: Morning / Afternoon / Evening / Anytime | `2246849667`, `2172919142`, `2412434756`, `5218534959` | Free ; Exact-clock reminder times | `2246849667`, `2544359717`, `3412849953`, `6953060121` | Paid — repeatedly named as the single most resented gate ; Reminders / notifications / badge counts | `1292927622`, `1867635363`, `3331399691` | Mixed; several report reminders as a paid feature ; Streaks and "ideal day" scoring | `1893314966`, `9402208057`, `9703849036` | Free ; Statistics and charts | `1545747128`, `3088099615`, `3397938852` | Tiered — "free stats are very limited" ; Habit notes | `1289775574`, `5092478493`, `5822571198` | Requested; limited or absent ; Built-in timer / Pomodoro | `4573131040`, `8091736452`, `5765818181`, `8622440806` | Paid; stops when the screen locks (`3489233437`, `4573131040`) ; Apple Watch app | `1603462276`, `2873841903`, `2957074134`, `3302608407` | Exists; broken for extended periods ; Home-screen widget | `1471553000`, `3302608407`, `1399170502` | Long absent, then present ; iCloud sync across devices | `1313972378`, `1379830019`, `3386723296`, `3070069271` | Advertised; widely reported non-functional ; Network account / login | `7431388676`, `8419538814`, `10964257169`, `10828083076`, `6950293278` | Added later; sign-up path frequently missing or broken ; Siri Shortcuts | `6586946528`, `6622475941` | Exists; reported broken ; Challenges / Explore content tabs | 122 reviews, 45 of them in 2020 | Appears ~2020; partly paid ; Templates / pre-made habit suggestions | `1417054726`, `6332137171`, `6887296777` | Free ; Data export | `2344695224` and 40 others | Absent — "no progress on data export for years" ; Android / web / macOS clients | `10185998135`, `6893540461`, `6806854391` | Absent (iOS only) ; Apple Health / HealthKit integration | `8273087572`, `4012290104` | Absent ; Localisation beyond a few languages | Part 4.7 | Effectively absent; screenshots reportedly show languages the app does not have (`12911930158`)
- **Direction for us:** research · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `2246849667`, `2544359717`, `3412849953`, `6953060121`, `3489233437`, `4573131040`, `1603462276`, `1313972378`, `7431388676`, `6586946528`, `2344695224`, `10185998135`, `8273087572`, `12911930158`
- **Canonical:** — (nuance register)

### R13-012 — Exact-clock reminder times are paid — repeatedly named as the single most resented gate; free users get only Morning/Afternoon/Evening/Anytime buckets

- **Where:** §2.1 Exact-clock reminder times — Paid, the single most resented gate
- **This app does:** exact reminder time paywalled
- **User reaction:** complaint
- **Magnitude:** 4 cited IDs; named repeatedly
- **Direction for us:** build-free · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `2246849667`, `2544359717`, `3412849953`, `6953060121`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C133 Gate on capability, not on quantity

### R13-014 — Free time-of-day buckets (Morning / Afternoon / Evening / Anytime) organise the daily list

- **Where:** §2.1 Time-of-day buckets Morning / Afternoon / Evening / Anytime — free
- **This app does:** buckets free
- **User reaction:** praise
- **Magnitude:** 4 cited IDs
- **Direction for us:** build-free · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `2246849667`, `2172919142`, `2412434756`, `5218534959`
- **Canonical:** C053 Custom time-of-day segments

### R13-015 — Data export is absent — 'no progress on data export for years'

- **Where:** §2.1 Data export — Absent, 'no progress on data export for years'
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 41 reviews
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `2344695224`
- **Canonical:** C020 Data export / backup / CSV

### R13-025 — UX themes: confusing to use, cluttered (content tabs), onboarding complaints; icons and stats requested or praised

- **Where:** §3.1 U-confusing; U-clutter; U-onboarding; U-icons; U-stats
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** U-confusing 558 (2.81%) mean 2.62; U-clutter 202 (1.02%) mean 4.21; U-onboarding 80 (0.40%) mean 2.75; U-icons 308 (1.55%) mean 4.16; U-stats 365 (1.84%) mean 3.76
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C011 Weekly / monthly / yearly reports; C075 Skippable, replayable onboarding tour

### R13-026 — Smaller requests: flexibility praised where present, skip flexibility, multiple-times-daily, week-start setting, swipe-back gesture, upcoming-days overview, sort order, Touch ID / app lock, dark mode, calendar integration, one-off tasks, bad-habit mode, more free habits, and objections to required sign-in

- **Where:** §3.1 P-flexible-good; U-skip-flex; U-multi-daily; U-week-start; U-swipe-back; U-overview; U-order-sort; U-touchid; U-dark-mode; U-calendar; U-onetime-task; U-bad-habit; U-more-free; U-signin-required
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** P-flexible-good 365 (1.84%) mean 4.40; U-skip-flex 155 (0.78%) 4.21; U-multi-daily 34; U-week-start 28 mean 4.11; U-swipe-back 26; U-overview 24; U-order-sort 22; U-touchid 31; U-dark-mode 36; U-calendar 35; U-onetime-task 81 (0.41%); U-bad-habit 69 (0.35%) mean 4.45; U-more-free 56; U-signin-required 7
- **Direction for us:** research · **Report confidence:** weak–emerging · **Generalisable:** yes
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C017 Passcode lock; C019 Quit-habit / bad-habit mode; C050 One-off to-dos alongside habits; C080 Colour themes / dark mode; C143 Intra-day completion: tap N times to fill N/N

### R13-032 — Missing capabilities ranked: habit notes/journaling, exact reminder times without paying, numeric/quantity goals, localisation (Arabic, Portuguese, Russian, Turkish), flexible frequency, widget, bad-habit mode, one-off tasks, data export, Apple Health, web/Android/macOS, categories/folders, back-dating a missed check-off

- **Where:** §3.5 Genuinely missing capabilities table (verbatim)
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** Request | n | % | Signal | Evidence ; Habit notes / journaling per entry | 251 | 1.26% | meaningful | `1289775574` `5092478493` `5822571198` ; Exact reminder times without paying | 227 | 1.14% | meaningful | `2246849667` `2544359717` `6953060121` ; Numeric / quantity goals (pages, glasses, minutes) | 165 | 0.83% | emerging | `2804919606` `5951908643` `8389382415` `6988565357` ; Localisation (esp. Arabic, Portuguese, Russian, Turkish) | 164 | 0.83% | emerging | Part 7.5 ; Flexible frequency (every-N-days, N×/week, specific weekdays) | 79 + 34 | 0.57% | emerging | `3743847782` `5907419362` `7806022477` `9402208057` ; Home-screen widget | 186 | 0.94% | emerging | `1471553000` `1399170502` ; Bad-habit / quit-counter mode | 69 | 0.35% | weak | `8471728362` `2804919606` ; One-off tasks alongside recurring habits | 81 | 0.41% | weak | `1571196484` `3261608481` `3961445525` ; Data export | 41 | 0.21% | weak | `2344695224` ; Apple Health / HealthKit | part of 66 | 0.33% | weak | `8273087572` `4012290104` ; Web / Android / macOS client | 75 | 0.38% | weak | `6893540461` `10185998135` ; Categories or folders for habits | 56 | 0.28% | weak | — ; Back-dating a missed check-off | 29 | 0.15% | weak | `1233009943` `2126311604` `3158012910`
- **Direction for us:** build-free · **Report confidence:** verbatim · **Generalisable:** yes
- **Review IDs:** `1289775574`, `5092478493`, `2804919606`, `5951908643`, `3743847782`, `5907419362`, `1471553000`, `8471728362`, `1571196484`, `2344695224`, `8273087572`, `6893540461`, `1233009943`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C009 Basic widgets, icons and colours are free; C010 Backfill missed days / edit start date; C019 Quit-habit / bad-habit mode; C020 Data export / backup / CSV; C021 Apple Health integration; C027 Localise early — it unlocks revenue; C043 Flexible / custom frequency; C044 Mac / desktop / web app; C045 Grouping / folders / categories / tags; C048 Flexible units / partial progress; C050 One-off to-dos alongside habits; C172 Per-day / per-habit notes and journal text

### R13-033 — Numeric / quantity goals (pages, glasses, minutes) are an emerging request

- **Where:** §3.5 Numeric / quantity goals (pages, glasses, minutes)
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** U-quantity 165 (0.83%, emerging) mean 3.86
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `2804919606`, `5951908643`, `8389382415`, `6988565357`
- **Canonical:** C048 Flexible units / partial progress

### R13-034 — Flexible frequency — every N days, N times per week, specific weekdays — is an emerging request

- **Where:** §3.5 Flexible frequency (every-N-days, N×/week, specific weekdays)
- **This app does:** daily only (or limited)
- **User reaction:** praise
- **Magnitude:** U-weekday-schedule 79 + U-multi-daily 34 (0.57%, emerging)
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `3743847782`, `5907419362`, `7806022477`, `9402208057`
- **Canonical:** C043 Flexible / custom frequency

### R13-035 — Per-entry habit notes / journaling is the largest missing capability

- **Where:** §3.5 Habit notes / journaling per entry
- **This app does:** limited or absent
- **User reaction:** praise
- **Magnitude:** U-notes 251 (1.26%, meaningful) mean 3.45
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1289775574`, `5092478493`, `5822571198`
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R13-082 — Near-term build priorities: make iCloud sync work and show sync state in the UI; flexible scheduling (weekdays, every-N-days, N-times-per-week that scores correctly); reordering that persists; per-entry notes (the largest pure request); numeric goals; Arabic then Portuguese, Turkish, Traditional Chinese; back-dating a missed check-off (named since the corpus's second-ever review, 2015); data export (unaddressed for eleven years, also a trust signal); let users hide Challenges/Explore

- **Where:** §8.3 Near-term product table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** sync 497; scheduling 79+34+155; reorder 77+22; notes 251; quantity 165; localisation 164; backdate 29; export 41; challenges 122
- **Direction for us:** build-free · **Report confidence:** recommendation (near-term) · **Generalisable:** yes
- **Review IDs:** `9402208057`, `3743847782`, `5747144309`, `7806022477`, `5907419362`, `5343328336`, `6078869840`, `2804919606`, `8389382415`, `5951908643`, `1233009943`, `9948539388`, `10245447172`
- **Canonical:** C010 Backfill missed days / edit start date; C020 Data export / backup / CSV; C027 Localise early — it unlocks revenue; C030 Sync must work — and prove it; C043 Flexible / custom frequency; C048 Flexible units / partial progress; C073 Manual reordering, renaming and editing of habits/tasks — free; C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C172 Per-day / per-habit notes and journal text

## Monetization

### R13-006 — Price rose roughly 25× and the complaint followed it exactly: $3.99 one-time → $19.99–$24/yr → $30/yr → $40–60/yr → $80–100/yr and $3.99/week; 'price is too high' went from 2.9% of 2015 reviews to 26.7% of 2025 reviews and by 2025 is the most-cited theme after generic sentiment

- **Where:** EXECUTIVE SUMMARY #3 Price rose roughly 25× and the complaint followed it
- **This app does:** $3.99 one-time (2015–16) → $80–100/yr or $3.99/week (2024–26)
- **User reaction:** complaint
- **Magnitude:** price-too-high 2.9% (2015) → 26.7% (2025), 9× rise
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'; C190 No weekly billing tier

### R13-017 — Price ladder by year from reviewer-named prices: $3.99 one-time (2015–Jul 2017) → Aug 2017 subscription $9.99–$19.99/yr → 2019–20 $30 dominant, ¥208 → 2021–22 $35–60 → 2023 $50–60 → 2024 $80 (14 mentions), $3.99/week → 2025 $100–120, ₽499/week, €6/week → 2026 $99.99–$168; ~25× in year one and unbounded over years; the most common formulation is that the app is 'not Netflix' and adds no new content to justify recurrence

- **Where:** §2.2 The price ladder, as reviewers reported it table (verbatim); 'not Netflix'
- **This app does:** subscription with rising price and weekly tier
- **User reaction:** complaint
- **Magnitude:** Period | Model | Prices named in reviews ; 2015 – Jul 2017 | One-time purchase | $3.99 / $4 (18 mentions 2015, 33 in 2016); ¥25 in China ; Aug 2017 | Converted to subscription | $9.99–$14.99/yr, then $19.99–$20/yr; ¥48/yr China ; 2018 | Subscription, rising | $19.99, $23.99, $24, $25, $30.99; €23.99; £17.49–£20.99; ¥128–158 ; 2019 | Subscription | $30 dominant (62 mentions), $29.99, $40; ¥208 (43 mentions); ₽1,350–2,500 ; 2020 | Subscription | $30 (29), $40, $29.99; ¥208 (54 mentions) ; 2021–2022 | Subscription | $35–$40; $60 appears; ¥233 ; 2023 | Subscription | $50, $60; R$199.90/yr or R$40/mo; ฿/₺ equivalents rising ; 2024 | Subscription + weekly tier | $80 (14 mentions), $99, $59.99, $79.99; $3.99/week (US); ₺4,000/yr ; 2025 | Subscription | $100, $120; €99.99/yr (IT); ₽8,990/yr or ₽499/week; €24/month (LV); €6/week (AT); R$29.90/week (BR); COP 30,000/week ; 2026 | Subscription | $99.99, $100, $168
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `2056030038`, `2346902589`, `3216212174`, `6462684894`, `9540734229`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'; C190 No weekly billing tier

### R13-019 — Tiers: free = 3–5 habits, coarse buckets, check-off, streaks, limited stats plus persistent full-screen upgrade interstitials; 7-day trial = full features but requires committing to a subscription first and defaults to the most expensive annual tier; premium = unlimited habits, exact reminder times, full stats, timer, some Challenges; one-time purchase withdrawn Aug 2017 and explicitly asked back by 239 reviews

- **Where:** §2.4 Free / paid / trial classification table (verbatim); 239 reviews ask for the one-time purchase back
- **This app does:** subscription-first trial; one-time withdrawn
- **User reaction:** complaint
- **Magnitude:** Tier | What reviewers report it contains ; Free | 3–5 habits (see 2.3), coarse Morning/Afternoon/Evening buckets, check-off, streaks, limited stats — plus persistent full-screen upgrade interstitials ; 7-day trial | Full features, but requires committing to a subscription first; several reviewers report the plan defaults to the most expensive annual tier (`3272238239`, `2380437896`, `3254598597`) ; Premium (subscription) | Unlimited habits, exact reminder times, full statistics, timer, some Challenges ; One-time purchase | Existed until Aug 2017; withdrawn. 239 reviews (1.20%) explicitly ask for it back ; Unclear from corpus | Whether premium removes third-party ads; whether the network account is required for sync ; one-time asked back 239 (1.20%)
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `3272238239`, `2380437896`, `3254598597`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C109 A free trial must be a real trial

### R13-023 — Subscription objection and 'pay required' are high-priority themes in their own right, and 239 reviews ask for the one-time purchase back

- **Where:** §3.1 M-sub-objection; M-pay-required; M-want-onetime
- **This app does:** subscription-only since 2017
- **User reaction:** complaint
- **Magnitude:** M-sub-objection 1,998 (10.07%, HIGH) mean 2.45; M-pay-required 1,692 (8.52%) mean 2.13; M-want-onetime 239 (1.20%) mean 2.37
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C147 Let people use the product before they pay

### R13-040 — 837 five-star reviews (8.75% of 5★) still complain about price or the subscription model — people who love the product telling you the pricing is wrong anyway: '100% recommendable. The only mistake I find is the monthly, quarterly or annual payment. It would be better to charge only once. It would attract more users, trust me' (20 votes); a Turkish 5★ titled 'Very expensive'

- **Where:** §4.1 837 five-star reviews still complain about price or the subscription model
- **This app does:** subscription
- **User reaction:** complaint
- **Magnitude:** 837 of 9,571 5★ (8.75%); M-price-high 456 + M-sub-objection 428 in 5★
- **Direction for us:** product-rule · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `2054778874`, `1809268653`, `11178911368`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C003 Lead with a one-time lifetime purchase

### R13-048 — Voluntary buyers are bimodal, not unhappy: 37% five-star and 33% one-star; within them utility, 'worth paying' and recommend are heavily over-represented; 'The premium account is really worth it. I bought it at least 2 years ago'; '$12 a year. Netflix is $15 a month, so that seemed fine'; 'well worth the money. And I'm a broke college student'; the 1★ third are people who bought and then objected to a price rise, model change or defect — a renewal-risk population

- **Where:** §5.2 Voluntary buyers — n = 836, mean 3.06; bimodal, not unhappy; themes table (verbatim); geography
- **This app does:** annual subscription
- **User reaction:** mixed
- **Magnitude:** 836 (4.21%) mean 3.06; 5★ 311 (37.2%) · 4★ 75 · 3★ 85 · 2★ 86 · 1★ 279 (33.4%); Theme | segment rate | global rate ; P-utility | 44.3% | 28.04% ; P-worth-paying | 25.5% | 1.46% ; P-recommend | 22.6% | 6.82% ; M-sub-objection | 21.8% | 10.07% ; M-price-high | 18.3% | 9.96% ; P-simple | 18.3% | 16.54% ; D-sync | 6.8% | 2.50% ; geography US 476 (57%), GB 69, CA 45, AU 33, BR 24, RU 23, DE 22, KR 17
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `4579753907`, `3137332075`, `4968659911`, `3573097080`, `1630174450`, `1358897750`, `1399170502`, `1402716583`, `1539169002`, `1652748005`, `1678598831`, `1812076040`, `4158416940`, `5858474870`, `6138703058`, `7191015742`, `1339259899`, `1299340618`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C061 Goodwill conversion — a generous free tier and 'support the devs'; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R13-051 — Upgrade barriers: objection to the subscription model itself, price level, wants one-time purchase, free tier too small to evaluate the paid tier, cannot try before committing a payment method, upgrade prompts prevent evaluation, purchase fails

- **Where:** §5.4 Upgrade barriers table (verbatim)
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** Barrier | n | % of corpus | Evidence ; Objection to the subscription model itself | 1,998 | 10.07% | `2274339164` `3627881877` `9540734229` `6462684894` ; Price level | 1,978 | 9.96% | `2404027318` `3130510376` `11782257948` `12827096820` ; Wants a one-time purchase instead | 239 | 1.20% | `2013556192` `2181939031` `3369796254` `8833995869` ; Free tier too small to evaluate the paid tier | 860 | 4.33% | `2593975724` `3712876508` `10227478057` ; Cannot try before committing a payment method | part of 1,102 | — | `2267301153` `10209353160` `4133950241` ; Upgrade prompts prevent evaluation | 397 | 2.00% | `2286844068` `6277521468` `8467812056` `8778546806` ; Purchase itself fails | 19 | 0.10% | `1465724209` `2439004359` `1924985674` `6227346469`
- **Direction for us:** research · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `2274339164`, `2404027318`, `2013556192`, `2593975724`, `2267301153`, `2286844068`, `1465724209`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C064 Price level — where 'fair' turns into 'too expensive'; C093 No upsell nagging without a 'never ask again' option; C147 Let people use the product before they pay

### R13-084 — Sell the thing people say they'd buy: 239 reviews request a one-time purchase, in every year 2017–2026 and inside 5★ reviews — a perpetual 'Pro' unlock alongside the subscription would convert a population that currently converts at zero

- **Where:** §8.4 #1 Sell the thing people say they'd buy — a perpetual 'Pro' unlock alongside the subscription
- **This app does:** subscription only
- **User reaction:** blocked-conversion
- **Magnitude:** M-want-onetime 239 (1.20%)
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `2054778874`, `1809268653`, `8833995869`
- **Canonical:** C003 Lead with a one-time lifetime purchase

## Insights (the why)

### R13-009 — The thing users actually pay for is small and the company never priced it that way: satisfied voluntary buyers describe one benefit — a simple daily checklist with reminders that produces a felt sense of accomplishment; they do not describe content, coaching or AI, while the app added Challenges and Explore content tabs (2020–22) that reviewers mostly asked to hide

- **Where:** EXECUTIVE SUMMARY #6 The thing users actually pay for is small, and the company has never priced it that way
- **This app does:** simple checklist core + unwanted content tabs
- **User reaction:** purchase-driver
- **Magnitude:** P-utility 44.3% of voluntary-buyer reviews; P-worth-paying 25.5%
- **Direction for us:** product-rule · **Report confidence:** high-priority (segment) · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C166 Keep the therapeutic core in front of the game layer

### R13-028 — The monetisation family dominates everything else: a third of the corpus raises a monetisation issue at the lowest ratings in the corpus, ~3.7× more discussed than reliability — any roadmap that starts with features is mis-prioritised against this evidence

- **Where:** §3.2 The monetisation family dominates everything else
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** M-* union 6,516 (32.83%) mean 2.34; D-* union 1,785 (8.99%); U-* union 2,911 (14.66%); P-* union 9,393 (47.32%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R13-030 — What the product genuinely does well, consistent across eleven years and all major storefronts: it works — keeps me on track; simplicity (chosen OVER more powerful tools because it is small); visual design (named even inside 1★ reviews); motivation/accountability (highest mean of any theme); habit actually formed; life change; ADHD/neurodivergent segment; mental-health contexts — the real job is 'remind me, let me tick it off, show me I did it'; nobody asks for content, coaching, courses or AI; the three most-upvoted 5★ reviews describe exactly this loop

- **Where:** §3.4 What the product genuinely does well table (verbatim); the product's real job
- **This app does:** simple checklist + reminders
- **User reaction:** praise
- **Magnitude:** Strength | n | % | Mean★ | What reviewers actually say ; It works — keeps me on track | 5,565 | 28.04% | 4.29 | Reminders + checklist produce follow-through (`6929025111`, `1537523702`, `4250072408`, `5875165421`) ; Simplicity | 3,284 | 16.54% | 4.39 | Chosen *over* more powerful tools precisely because it is small (`1417054726`, `3026852113`) ; Visual design | 1,411 | 7.11% | 4.12 | "Beautiful", "elegant", "sleek" — named even inside 1★ reviews ; Motivation / accountability | 1,339 | 6.75% | 4.61 | Highest mean of any theme in the corpus ; Habit actually formed | 902 | 4.54% | 4.44 | Concrete outcome claims, not vague praise (`7806022477`, `3573097080`) ; Life change | 381 | 1.92% | 4.31 | Strong transformation claims (`4949195093`, `1339259899`, `4371666634`) ; Serves ADHD / neurodivergent users | 463 | 2.33% | 3.68 | A named, self-identifying segment (`9550964281`, `3026852113`, `4725668608`) ; Serves mental-health contexts | 100 | 0.50% | 4.34 | Including the corpus's 3rd most-upvoted review, from a reviewer with paranoid schizophrenia (`2622642664`, 53 net votes) ; top upvoted 144 / 112 / 53 votes
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `6929025111`, `1537523702`, `4250072408`, `5875165421`, `1417054726`, `3026852113`, `7806022477`, `3573097080`, `4949195093`, `1339259899`, `4371666634`, `9550964281`, `4725668608`, `2622642664`, `2284758864`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C134 Lead the store listing with what users actually love

### R13-039 — 'Do X, get 5 stars': ship a reminder that fires, a list that is quick to tick, and a visible streak — that is the whole formula; 39.93% of five-star reviewers describe utility, only 8.84% mention design

- **Where:** §4.1 'Do X, get 5 stars': ship a reminder that fires, a list that is quick to tick, and a visible streak
- **This app does:** reminder + checklist + streak
- **User reaction:** praise
- **Magnitude:** 5★ n=9,571 (48.22%); P-utility 39.93% of 5★; P-design 8.84%
- **Direction for us:** must-have · **Report confidence:** band analysis · **Generalisable:** yes
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C024 Streaks / gamification

### R13-041 — The 4★ band is the product backlog: feature requests are 3.6× concentrated here vs 5★; the most frequent named items — notes on habits, flexible frequency, sync, widget, reordering that sticks, a higher free cap

- **Where:** §4.2 The 4★ band is the product backlog
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 4★ n=2,431; G-feature-request 12.75% of 4★ vs 3.52% of 5★; D-sync 3.58%; D-widget 2.55%; M-free-limit 5.47%
- **Direction for us:** build-free · **Report confidence:** band analysis · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free; C030 Sync must work — and prove it; C043 Flexible / custom frequency; C073 Manual reordering, renaming and editing of habits/tasks — free; C172 Per-day / per-habit notes and journal text

### R13-042 — 3★ is where reliability surfaces: sync runs 3.6× its global rate and iPad 4.0× — engaged multi-device users who paid attention long enough to find the sync bug, the highest-value population to fix things for and the most under-served

- **Where:** §4.3 3★ is where reliability surfaces — engaged multi-device users, the highest-value population to fix things for
- **This app does:** sync and iPad broken
- **User reaction:** complaint
- **Magnitude:** 3★ n=1,505; D-sync 8.90%; D-ipad 5.58%; D-crash 3.26%
- **Direction for us:** must-never-break · **Report confidence:** band analysis · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it; C141 Native iPad layout

### R13-043 — 2★ is 'beautiful, but I can't get in': the free-limit theme peaks here — the characteristic review praises the interface then says the free tier is too small to evaluate

- **Where:** §4.4 2★ is 'beautiful, but I can't get in'
- **This app does:** 3–5 habit free cap
- **User reaction:** blocked-conversion
- **Magnitude:** 2★ n=1,230; M-free-limit 12.36% (2.9× global); 28.05% contain praise
- **Direction for us:** product-rule · **Report confidence:** band analysis · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R13-044 — The 1★ population has four causes in order — money taken without perceived consent, the subscription model itself, price level, can't use it without paying — and 551 one-star reviews still contain praise ('this app is truly remarkable… I feel like I'm ripping you off for only $3.99… sorry for the one star'; a recovering addict describing a month clean): a large share are protest votes about commerce from satisfied users, the most reversible kind of 1★ there is

- **Where:** §4.5 The 1★ population has four causes, in order; 551 one-star reviews still contain praise language; protest votes about commerce from satisfied users
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1★ n=5,113 (25.76%); M-trial-autocharge 999 (19.54%); M-sub-objection 973 (19.03%); M-pay-required 950 (18.58%); M-price-high 897 (17.54%); M-refund 427 (8.35%); M-cancel-hard 345 (6.75%); praise in 1★ 551 (10.78%); P-utility 494 (9.66%)
- **Direction for us:** product-rule · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `1417054726`, `3044712205`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'; C109 A free trial must be a real trial; C147 Let people use the product before they pay

### R13-049 — Buyers name a single trigger with striking consistency: hitting the habit cap while already engaged — 'I purchased premium for a year so I can have more activities'; 'I upgraded pretty early on so I could have more habits to work on' — the cap converts, but only for users who got far enough in to care; that is why the aggressive first-minute paywall is self-defeating: it fires before engagement exists

- **Where:** §5.2 Interpretation — the purchase trigger: hitting the habit cap while already engaged
- **This app does:** habit cap as the paid trigger; interstitials before engagement
- **User reaction:** purchase-driver
- **Magnitude:** 836 voluntary buyers; cap-trigger stated repeatedly
- **Direction for us:** product-rule · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `1812076040`, `1652748005`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C137 Show the paywall at the moment of need, not on app open

### R13-062 — Core product praise is universal — utility and simplicity appear at similar rates in every Latin-script storefront, and the highest-rated storefronts are simply the ones with the fewest billing complaints; there is no evidence the product concept fails in any market — every market difference traces to commerce, payments or language

- **Where:** §6.8 What does not vary by country — core product praise is universal; every market difference traces to commerce, payments, or language
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** SG 4.29, ID 4.11, NO 3.97, NZ 3.93 — fewest billing complaints
- **Direction for us:** product-rule · **Report confidence:** stable · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue; C029 Billing must be exactly right

### R13-089 — For a competitor: the core need is small and well-specified — reminder → tick → visible streak; a one-time purchase option is a live differentiator requested continuously across eleven years; ADHD/neurodivergent and mental-health users are self-identifying under-served segments; Arabic is an open market; the trust bar is on the floor — honest pre-download pricing and a working cancel button would be positioning, not table stakes

- **Where:** §8.5 What a competitor entering this category gets free from this corpus
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** P-utility 5,565; M-want-onetime 239; P-adhd-nd 463 (2.33%); P-mentalhealth 100 mean 4.34; SA 20.5%
- **Direction for us:** do · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C027 Localise early — it unlocks revenue; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

## Audiences

### R13-031 — Mental-health users are a small but highly rated context — the corpus's third most-upvoted review is from a reviewer with paranoid schizophrenia

- **Where:** §3.4 Serves mental-health contexts — the corpus's 3rd most-upvoted review from a reviewer with paranoid schizophrenia
- **This app does:** simple structure
- **User reaction:** praise
- **Magnitude:** P-mentalhealth 100 (0.50%) mean 4.34; 53 net votes
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `2622642664`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

## Markets and languages

### R13-007 — China and Korea are not weak markets, they are billing-complaint markets: China 73.3% 1★ with 42.6% carrying auto-charge language; Korea 24.7% ask for a refund and 24.7% cannot cancel (~10× global); a large share traces to Douyin (TikTok China) advertising that reviewers say did not disclose the price

- **Where:** EXECUTIVE SUMMARY #4 China and Korea are not weak markets. They are billing-complaint markets.
- **This app does:** ads on Douyin without price disclosure; auto-charge
- **User reaction:** 1★-burst
- **Magnitude:** CN 1,337 mean 1.84, 73.3% 1★, 42.6% auto-charge; KR 571 mean 2.84, 24.7% refund, 24.7% cannot cancel; CN+KR 9.6% of corpus, 27.8% + 11.4% of paid-evidence
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Canonical:** C092 Regional pricing; C112 In-app cancellation; C187 No paid acquisition into an auto-converting trial in frictionless-payment markets

### R13-055 — 42 of 115 storefronts have ≥50 reviews; 73 storefronts hold 813 reviews (4.10%); per-storefront n, mean, 1★%, 5★%, paid-evidence%; theme rates compared within a language only, cross-country leads with rating distribution and paid-evidence share

- **Where:** §6.1 Eligibility and method; §6.2 All 42 eligible storefronts table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | % corpus | Mean★ | 1★% | 5★% | paid-evidence% ; United States | 8,273 | 41.68% | 3.88 | 17.3 | 58.0 | 6.5 ; China mainland | 1,337 | 6.74% | 1.84 | 73.3 | 14.7 | 36.1 ; United Kingdom | 1,171 | 5.90% | 3.82 | 16.7 | 54.3 | 7.2 ; Canada | 1,059 | 5.34% | 3.47 | 25.9 | 46.5 | 5.6 ; Brazil | 751 | 3.78% | 3.16 | 31.7 | 39.5 | 5.9 ; Australia | 593 | 2.99% | 3.82 | 18.0 | 56.2 | 6.4 ; South Korea | 571 | 2.88% | 2.84 | 42.4 | 31.3 | 34.7 ; Germany | 526 | 2.65% | 3.45 | 24.9 | 43.2 | 6.3 ; Russia | 490 | 2.47% | 3.09 | 33.1 | 36.5 | 5.7 ; Mexico | 388 | 1.95% | 3.47 | 26.8 | 47.4 | 4.9 ; France | 309 | 1.56% | 3.16 | 30.7 | 33.7 | 2.9 ; Turkey | 296 | 1.49% | 3.16 | 34.5 | 39.2 | 2.7 ; Italy | 238 | 1.20% | 3.18 | 25.6 | 31.1 | 1.7 ; India | 228 | 1.15% | 3.31 | 31.6 | 43.4 | 10.1 ; Spain | 210 | 1.06% | 3.00 | 35.7 | 32.4 | 1.4 ; Vietnam | 187 | 0.94% | 3.71 | 21.9 | 55.1 | 0.0 ; Netherlands | 184 | 0.93% | 3.40 | 28.3 | 43.5 | 5.4 ; Taiwan | 152 | 0.77% | 2.96 | 38.8 | 36.2 | 11.8 ; Poland | 149 | 0.75% | 3.21 | 30.2 | 40.3 | 6.0 ; Ukraine | 149 | 0.75% | 3.13 | 34.9 | 38.3 | 6.7 ; Japan | 144 | 0.73% | 3.15 | 32.6 | 33.3 | 3.5 ; Sweden | 144 | 0.73% | 3.48 | 22.2 | 43.8 | 0.7 ; Saudi Arabia | 127 | 0.64% | 3.44 | 21.3 | 41.7 | 1.6 ; Colombia | 107 | 0.54% | 3.31 | 25.2 | 42.1 | 0.9 ; Chile | 101 | 0.51% | 2.94 | 37.6 | 34.7 | 3.0 ; Belgium | 94 | 0.47% | 3.39 | 23.4 | 35.1 | 5.3 ; Switzerland | 88 | 0.44% | 3.68 | 19.3 | 46.6 | 5.7 ; New Zealand | 88 | 0.44% | 3.93 | 18.2 | 60.2 | 11.4 ; Philippines | 88 | 0.44% | 3.64 | 19.3 | 44.3 | 9.1 ; Thailand | 77 | 0.39% | 3.75 | 18.2 | 54.5 | 7.8 ; Argentina | 74 | 0.37% | 3.39 | 27.0 | 45.9 | 1.4 ; Norway | 73 | 0.37% | 3.97 | 17.8 | 61.6 | 4.1 ; Austria | 66 | 0.33% | 3.18 | 34.8 | 45.5 | 4.5 ; Denmark | 65 | 0.33% | 3.18 | 35.4 | 44.6 | 3.1 ; Singapore | 62 | 0.31% | 4.29 | 8.1 | 66.1 | 1.6 ; South Africa | 60 | 0.30% | 3.80 | 20.0 | 55.0 | 6.7 ; Indonesia | 55 | 0.28% | 4.11 | 12.7 | 70.9 | 0.0 ; Czechia | 54 | 0.27% | 3.37 | 24.1 | 33.3 | 7.4 ; Malaysia | 54 | 0.27% | 3.78 | 16.7 | 44.4 | 5.6 ; Hong Kong | 53 | 0.27% | 3.45 | 18.9 | 43.4 | 9.4 ; UAE | 52 | 0.26% | 3.73 | 21.2 | 51.9 | 7.7 ; Israel | 50 | 0.25% | 3.50 | 26.0 | 48.0 | 8.0
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R13-056 — Top-8 review-volume storefronts (71.94% of corpus): US healthy (complaints about model and price, not conduct); China a billing-dispute corpus; UK and Australia mirror the US; Canada price-sensitive (sub-objection 11.6% vs US 8.5%); Brazil 'not free' complaint 11.1% (5.8× global); Korea a refund/cancellation corpus; Germany the strongest anti-subscription stance (16.7%)

- **Where:** §6.3 Group A — high-review-volume markets table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Rank | Storefront | Reviews | % of corpus | Mean★ | Character ; 1 | United States | 8,273 | 41.68% | 3.88 | Healthy; complaints are about model and price, not conduct ; 2 | China mainland | 1,337 | 6.74% | 1.84 | Billing-dispute corpus ; 3 | United Kingdom | 1,171 | 5.90% | 3.82 | Mirrors US ; 4 | Canada | 1,059 | 5.34% | 3.47 | Price-sensitive; sub-objection 11.6% vs US 8.5% ; 5 | Brazil | 751 | 3.78% | 3.16 | "Not free" complaint 11.1% — 5.8× global ; 6 | Australia | 593 | 2.99% | 3.82 | Mirrors US/UK ; 7 | South Korea | 571 | 2.88% | 2.84 | Refund/cancellation corpus ; 8 | Germany | 526 | 2.65% | 3.45 | Strongest anti-subscription stance: 16.7% ; 14,281 reviews (71.94%)
- **Direction for us:** research · **Report confidence:** group · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R13-057 — The storefronts where money is discussed most are the two with the worst ratings, and the correlation runs through conduct not price tolerance: in the US 6.5% discuss a transaction and the mean is 3.88; in China 36.1% and 1.84 — 51.1% of all involuntary-charge reviews in the corpus come from China

- **Where:** §6.4 Group B — high-spend markets table (verbatim); the defining insight: the correlation runs through conduct, not price tolerance
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Storefront | n | paid-evidence % | Mean★ | 1★% | Reading ; China mainland | 1,337 | 36.1% | 1.84 | 73.3 | Money is discussed because it was taken ; South Korea | 571 | 34.7% | 2.84 | 42.4 | Same — refund requests ; Taiwan | 152 | 11.8% | 2.96 | 38.8 | Same pattern, smaller ; New Zealand | 88 | 11.4% | 3.93 | 18.2 | Mixed; healthy ratings ; India | 228 | 10.1% | 3.31 | 31.6 | Mixed ; Hong Kong | 53 | 9.4% | 3.45 | 18.9 | Mixed ; Philippines | 88 | 9.1% | 3.64 | 19.3 | Mixed ; Israel | 50 | 8.0% | 3.50 | 26.0 | Mixed ; UAE | 52 | 7.7% | 3.73 | 21.2 | Mixed ; United States | 8,273 | 6.5% | 3.88 | 17.3 | Largely voluntary purchase ; CN 437 of 856 involuntary (51.1%)
- **Direction for us:** product-rule · **Report confidence:** group · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set; C187 No paid acquisition into an auto-converting trial in frictionless-payment markets

### R13-058 — China is the worst market and it is a marketing-and-billing failure, not product-market fit: a Douyin (TikTok China) paid-acquisition campaign from mid-2019 drove high-intent installs into a trial that opened an annual ¥208 subscription, in a payment environment (password-free payment, 免密支付, WeChat balance) with no friction to catch the mistake — 'everyone who sees this on Douyin, don't click through'; '¥200+ after the 7-day trial… In the US it's three meals' money; in China it's about 14 meals'; the counterfactual: a Douyin user who liked the app and planned to buy gave 5★

- **Where:** §6.5 China — the corpus's worst market; a specific, dated acquisition problem — Douyin advertising; mechanism: password-free payment
- **This app does:** Douyin ads → trial → ¥208/yr auto-charge with no auth step
- **User reaction:** 1★-burst
- **Magnitude:** CN 1,337 mean 1.84; 73.3% 1★, 14.7% 5★; auto-charge 42.6% (7.7× global); paid-evidence 36.1%; monthly spikes 2019-07 (99), 2020-02 (134), 2020-05 (112), 2020-03 (82); ¥208 cited 43× (2019), 54× (2020)
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Review IDs:** `6028565692`, `5901610531`, `5525308783`, `5921822925`, `5972284336`, `5906879974`, `6437141830`, `7235327975`, `5682690700`, `5637324239`, `5959939024`, `5789787004`, `5494092368`, `5307809011`, `4538118097`, `3163329581`, `2266470444`, `3237593845`, `4596135051`
- **Canonical:** C092 Regional pricing; C114 Ads must match the app; C187 No paid acquisition into an auto-converting trial in frictionless-payment markets

### R13-059 — Korea is a refund/cancellation corpus following a near-template: downloaded, deleted the same day, charged a full year later, cannot locate the subscription in Apple's settings, requesting cancellation and refund in the review itself; two Korean reviewers wrote public how-to-cancel instructions for other users — a strong signal the in-app path did not exist; an in-app 'Manage subscription' link and a pre-charge reminder email would address roughly a quarter of all Korean reviews

- **Where:** §6.6 South Korea — n = 571; Korea's problem is almost entirely cancellation discoverability
- **This app does:** no in-app cancel path; no pre-charge reminder
- **User reaction:** 1★-burst
- **Magnitude:** KR 571 mean 2.84; 42.4% 1★, 31.3% 5★; refund 24.7% (9.4× global); cannot cancel 24.7% (10.9×); paid-evidence 34.7%; ₩22,000–38,000/yr
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `2502496417`, `3358473617`, `3401042634`, `3188103086`, `4544409043`, `3153827976`, `3155492207`, `2697826231`, `3126692841`, `3220644612`, `3366758790`, `3407642979`, `4549292785`, `4599438088`, `4594513464`, `3370259939`, `3069605383`
- **Canonical:** C112 In-app cancellation; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R13-060 — Localisation is the clearest country-specific gap and Arabic is the single largest unserved language: one in five Saudi reviews asks for it, with requests from Oman, Morocco, UAE, Kuwait, Qatar, Bahrain, Jordan; also Taiwan, Turkey, Brazil, Russia; as a share the request keeps rising to 2.9% in 2026

- **Where:** §6.7 Localisation — the clearest country-specific product gap table (verbatim); Arabic is the single largest unserved language
- **This app does:** Arabic absent
- **User reaction:** blocked-conversion
- **Magnitude:** U-localization 164 (0.83%); Storefront | localisation mentions | % of that storefront's reviews | vs global 0.83% ; Saudi Arabia | 26 | 20.5% | 24.7× ; Taiwan | 13 | 8.6% | 10.4× ; Turkey | 18 | 6.1% | 7.3× ; Brazil | 13 | 1.7% | 2.1× ; China | 10 | 0.7% | 0.9× ; Russia | 8 | 1.6% | 1.9× ; 5 (2015) → 29–30/yr (2019–20); 2.9% (2026, n=68)
- **Direction for us:** build-free · **Report confidence:** emerging globally, high-priority in SA · **Generalisable:** yes
- **Review IDs:** `8272266849`, `9376522201`, `10247463002`, `10494385578`, `10912704838`, `10219606844`, `9560705598`, `11656689372`
- **Canonical:** C027 Localise early — it unlocks revenue

### R13-063 — Sub-50 storefronts: Arabic-language demand extends past Saudi Arabia (Oman, Morocco, Kuwait, Qatar, Bahrain, Jordan); Portugal and Ireland sit just under threshold and pattern with Brazil and the UK

- **Where:** §6.9 Sub-50 storefronts [limited evidence] — Arabic demand beyond Saudi; Portugal and Ireland pattern with Brazil and UK
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** 73 storefronts, 813 reviews (4.10%); OM 10, MA 4, KW 12, QA 7, BH 6, JO 6; PT 48, IE 48
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R13-003 — Corpus composition by rating and year: 2015–16 mean 4.75–4.77 with 1★ ~1%, then a straight-line fall from 2017 to 2.37 in 2026; script distribution Latin 86.2%, Han 7.6%, Cyrillic 2.8%, Hangul 2.8%, Kana 0.26%, Arabic 0.25%

- **Where:** §1.6 Corpus composition rating table (verbatim); year table (verbatim); script distribution
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Rating | n | % ; 5★ | 9,571 | 48.22% ; 4★ | 2,431 | 12.25% ; 3★ | 1,505 | 7.58% ; 2★ | 1,230 | 6.20% ; 1★ | 5,113 | 25.76% ; Total | 19,850 | 100% ;; Year | n | Mean | 1★% | 5★% ; 2015 | 1,120 | 4.75 | 1.2 | 81.3 ; 2016 | 2,593 | 4.77 | 0.9 | 83.1 ; 2017 | 2,050 | 4.40 | 6.7 | 70.4 ; 2018 | 2,153 | 2.85 | 37.5 | 29.1 ; 2019 | 4,398 | 3.21 | 33.7 | 42.7 ; 2020 | 4,056 | 3.16 | 33.6 | 38.8 ; 2021 | 1,151 | 2.91 | 36.5 | 30.8 ; 2022 | 887 | 2.74 | 39.7 | 25.5 ; 2023 | 815 | 3.07 | 30.1 | 32.0 ; 2024 | 413 | 2.68 | 40.4 | 24.7 ; 2025 | 146 | 2.53 | 45.9 | 20.5 ; 2026 | 68 | 2.37 | 48.5 | 19.1 ; scripts: Latin 17,112 (86.2%), Han 1,510 (7.6%), Cyrillic 550, Hangul 546, Kana 52, Arabic 49, Thai 28, Hebrew 3
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R13-004 — This app was loved and then the business model destroyed it, and the date is knowable: for two years one of the best-rated products in its category; in August 2017 the developer converted a $3.99 one-time purchase into a recurring subscription and by many accounts revoked the entitlement of people who had already paid; ratings fell in a straight line and never recovered — the clearest monetisation-damage case in the corpus set

- **Where:** EXECUTIVE SUMMARY #1 This app was loved, and then the business model destroyed it. The date is knowable.
- **This app does:** one-time → subscription Aug 2017; prior buyers' entitlement revoked
- **User reaction:** 1★-burst
- **Magnitude:** 2015 mean 4.75, 2016 4.77 (5★ 81–83%, 1★ ~1%) → 2017 4.40 → 2018 2.85 → 2026 2.37
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C104 Never ship a paywall or feature-removal change silently; C186 Never revoke what earlier buyers paid for when the model changes

### R13-018 — The free habit allowance was tightened from 5 to 3 around 2018 and relaxed back to 5 around 2020 — corroborated by a reviewer in real time ('rather than listen to feedback, that number has now been dropped to 3'); the tightening coincides with the worst year (mean 2.85) and the reversal did not recover the rating, suggesting the damage by then was billing conduct, not the cap

- **Where:** §2.3 The free tier moved, and the corpus records it table (verbatim); a reviewer who noticed it happening in real time
- **This app does:** free cap 5 → 3 (2018) → 5 (2020)
- **User reaction:** 1★-burst
- **Magnitude:** Year | "5 habits" | "3 habits" | "2 habits" | Dominant stated limit ; 2015 | 22 | 0 | 1 | 5 ; 2016 | 48 | 3 | 0 | 5 ; 2017 | 49 | 7 | 2 | 5 ; 2018 | 21 | 108 | 16 | 3 ; 2019 | 10 | 71 | 13 | 3 ; 2020 | 39 | 5 | 3 | 5 ; 2021 | 10 | 11 | 3 | 3–5 ; 2023 | 11 | 1 | 1 | 5 ; 2024–26 | 11 | 1 | 1 | 5
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `2849109648`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R13-054 — The entitlement-revocation cluster is the 2017 conversion's permanent scar and it recurs: Aug 2017 one-time purchasers found 'my purchase was worthless as I have been downgraded to the free version'; since then subscriptions silently expire after an update ('I got the year subscription… then it said it needed to be updated. NOW! I have zero days left instead of like 353')

- **Where:** §5.5 The entitlement-revocation cluster (M-paid-lost) — the 2017 conversion's permanent scar, and it recurs
- **This app does:** revoked one-time entitlements; subscriptions expiring on update
- **User reaction:** 1★-burst
- **Magnitude:** M-paid-lost 84 (0.42%) mean 2.10; 60 in paid segment (3.46%)
- **Direction for us:** must-never-break · **Report confidence:** weak volume, strategic · **Generalisable:** yes
- **Review IDs:** `2047285228`, `1710960363`, `1711139434`, `1717245795`, `2022210088`, `2086725532`, `2138643008`, `3060816879`, `1742078444`, `4548741361`, `4550145452`, `2632403649`, `6971182110`, `3686854032`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C186 Never revoke what earlier buyers paid for when the model changes

### R13-064 — Four eras: paid app (2015-06 → 2017-07) mean 4.73; subscription conversion (2017-08 → 2018-12) 3.09; scale and paid acquisition (2019–20) 3.18; decline (2021–26) 2.85

- **Where:** §7.1 Method — four eras
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era 1 5,104 reviews 4.73; Era 2 2,812 3.09; Era 3 8,454 3.18; Era 4 3,480 2.85; 136 months
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R13-065 — The subscription conversion is dated, decisive and permanent: the mean fell 1.79 stars in nine months (Aug 2017 → Apr 2018) and the corpus has not seen a month above 4.0 since Sep 2017; 'They replaced the one-time purchase with a subscription without a word about it in the update notes'; 'Unannounced switch to subscription model… including those who had already paid'; 'Bait & Switch!'; aggravating context in the same window: the app was renamed from 'Balanced', the predecessor pulled, and ownership reportedly moved to an ad company

- **Where:** §7.2 Trend 1 — The subscription conversion. Dated, decisive, permanent; monthly table (verbatim); evidence for the conversion; aggravating context
- **This app does:** one-time → subscription Aug 2017, unannounced, prior buyers downgraded; rebrand
- **User reaction:** 1★-burst
- **Magnitude:** Month | n | Mean★ | 1★% ; 2017-05 | 167 | 4.60 | 3.6 ; 2017-06 | 162 | 4.62 | 3.7 ; 2017-07 | 218 | 4.50 | 7.3 ; 2017-08 | 206 | 4.21 | 10.7 ; 2017-09 | 156 | 4.24 | 9.0 ; 2017-10 | 109 | 3.59 | 18.3 ; 2017-11 | 90 | 3.39 | 22.2 ; 2017-12 | 98 | 3.40 | 22.4 ; 2018-03 | 131 | 3.11 | 31.3 ; 2018-04 | 195 | 2.81 | 38.5 ; 2018-06 | 176 | 2.83 | 38.1 ; M-sub-objection 6.9% (2017) → 17.3% (2018); M-trial-autocharge 0.3% → 8.4%; M-cancel-hard 0.2% → 5.1%; 140 1–2★ reviews Aug–Dec 2017
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1709443938`, `1710045692`, `1711354112`, `1717245795`, `1714126118`, `1795269347`, `1742078444`, `2022210088`, `1944811074`, `2048313987`, `2994148554`, `1798982614`, `1879018954`, `1709611336`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C003 Lead with a one-time lifetime purchase; C104 Never ship a paywall or feature-removal change silently; C186 Never revoke what earlier buyers paid for when the model changes

### R13-066 — Price complaints tracked the price exactly year by year; the 2024 introduction of WEEKLY billing is a distinct escalation with its own reaction — '$3.99 WEEKLY to track my habits is insane'; '29.90 per week. Per week! I didn't even test it'; 'I used the app when it was affordable, 5 euro a month… but now 6€ A WEEK'; '24€ a month to track habits… that is immoral'

- **Where:** §7.3 Trend 2 — Price rose ~25×, and complaints tracked it exactly table (verbatim); weekly billing is a distinct escalation
- **This app does:** weekly tier added 2024; $100/yr by 2025
- **User reaction:** 1★-burst
- **Magnitude:** Year | M-price-high % | Named annual price (mode) ; 2015 | 2.9% | $3.99 one-time ; 2016 | 3.9% | $3.99 one-time ; 2017 | 6.9% | $19.99/yr ; 2018 | 15.1% | $23.99/yr ; 2019 | 11.9% | $30/yr ; 2020 | 10.6% | $30/yr ; 2022 | 10.9% | $35–60/yr ; 2023 | 10.6% | $50–60/yr ; 2024 | 16.9% | $80/yr, $3.99/week ; 2025 | 26.7% | $100/yr `[small sample n=146]` ; 2026 | 22.1% | $99.99/yr `[small sample n=68]`
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11156001886`, `12283821466`, `12289420481`, `12827096820`, `11737276918`, `11782257948`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C190 No weekly billing tier

### R13-068 — Sync failure is the fastest-worsening product dimension — a 10× rise from 2015 to 2021 sustained through 2026 ('iCloud sync broken, fixed, now broken again'); the 2024 dip is sampling noise, not a fix

- **Where:** §7.5 Trend 4 — Sync failure is the fastest-worsening product dimension; yearly table (verbatim)
- **This app does:** iCloud sync unreliable
- **User reaction:** complaint
- **Magnitude:** 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 | 2026 ; 0.7% | 0.7% | 1.3% | 1.7% | 1.5% | 3.6% | 7.0% | 6.2% | 4.9% | 1.5% | 6.8% | 7.4% ; 8.90% of 3★
- **Direction for us:** must-never-break · **Report confidence:** meaningful, worsening · **Generalisable:** yes
- **Review IDs:** `1313972378`, `1379830019`, `3070069271`, `3386723296`, `4356794558`, `5778564141`, `6806854391`, `9346061306`, `9717725547`, `6792537279`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C030 Sync must work — and prove it

### R13-071 — Nine themes present at material rates in every era and never fixed: must pay to use, free tier too small, upgrade interstitials (worsening), sync (worsening), localisation (worsening), no Android/web/macOS, no export, reminders unreliable, exact reminder times gated (discussed less only because engaged users left)

- **Where:** §7.8 Trend 7 — What never changed in eleven years table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Persistent theme | 2015–17 (n=5,763) | 2018–20 (n=10,607) | 2021–26 (n=3,480) | Status ; Must pay to use it at all (`M-pay-required`) | 1.8% | 11.5% | 10.6% | unresolved ; Free tier too small to evaluate (`M-free-limit`) | 3.8% | 4.5% | 4.7% | unresolved ; Upgrade interstitials block evaluation (`M-upsell-nag`) | 0.9% | 2.0% | 4.0% | worsening ; No cross-device sync that works (`D-sync`) | 0.9% | 2.3% | 5.7% | worsening ; Localisation gaps (`U-localization`) | 0.7% | 0.7% | 1.5% | worsening ; No Android / web / macOS client (`U-desktop`) | 0.2% | 0.3% | 0.9% | unresolved ; No data export (`U-export`) | 0.2% | 0.2% | 0.3% | unresolved ; Reminders unreliable (`D-reminder-broken`) | 0.9% | 1.1% | 0.7% | unresolved ; Cannot set exact reminder times free (`U-exact-time`) | 1.8% | 1.0% | 0.4% | unresolved as a gate; discussed less as users left
- **Direction for us:** must-never-break · **Report confidence:** persistent · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C008 Daily check-in and one basic reminder per habit are free; C020 Data export / backup / CSV; C027 Localise early — it unlocks revenue; C030 Sync must work — and prove it; C039 Reminders fire reliably, once; C044 Mac / desktop / web app; C093 No upsell nagging without a 'never ask again' option; C147 Let people use the product before they pay

## Positioning

### R13-001 — Productive — Habit Tracker (App Store ID 983826477) is an eleven-year-old daily habit checklist that converted from a $3.99 one-time purchase to a subscription in August 2017; the second-largest corpus in the set

- **Where:** header lines 1-8
- **This app does:** developer Mosaic S.r.l.; bundle com.beHappy.Productive; subscription (weekly / yearly) after 2017; store rank 13
- **User reaction:** mixed
- **Magnitude:** 19,850 written reviews, 115 storefronts, 3 Jun 2015 → 2 Sep 2026; mean 3.51; extracted 8 Sep 2026
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

## Anti-patterns

### R13-069 — Challenges/Explore content tabs arrived in 2020, peaked and were not wanted — 'Please get rid of the challenges and explore tabs, or make it so we can hide them… I will not pay for a subscription to an app that is 50% entirely useless and unhelpful content'; the company invested in content while the corpus asked for sync, reordering, flexible scheduling and honest billing; content did not move ratings

- **Where:** §7.6 Trend 5 — Content tabs arrived in 2020, peaked, and were not wanted
- **This app does:** content tabs added 2020, partly paid, not hideable
- **User reaction:** complaint
- **Magnitude:** U-challenges 6 (2019) → 45 (2020) → 29 → 21 → 11 → 3 → 0; means 2020 3.16, 2021 2.91, 2022 2.74
- **Direction for us:** dont · **Report confidence:** emerging, then fading · **Generalisable:** yes
- **Review IDs:** `9948539388`, `8091736452`, `6536839803`, `8536372117`, `8035852270`, `10245447172`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C166 Keep the therapeutic core in front of the game layer

## Things not to do

### R13-016 — Store screenshots reportedly show languages the app does not actually have

- **Where:** §2.1 Localisation screenshots reportedly show languages the app does not have
- **This app does:** listing claims languages not shipped
- **User reaction:** complaint
- **Magnitude:** 1 cited ID
- **Direction for us:** dont · **Report confidence:** n=1 · **Generalisable:** yes
- **Review IDs:** `12911930158`
- **Canonical:** C027 Localise early — it unlocks revenue; C114 Ads must match the app

### R13-020 — Seven dark-pattern mechanics counted separately: charged after trial without perceived consent (the dominant negative subject), cannot find a way to cancel, 'free' claim disputed, exit-intent discount that halves the price when you decline ('Here's one star for you. You can buy the rest at a 49% discount'), two different prices for the same term, countdown-timer paywall with hidden dismiss, billing taken outside Apple and un-cancellable in Settings

- **Where:** §2.5 Dark-pattern mechanics reviewers describe table (verbatim)
- **This app does:** trial auto-charge, hidden cancel, exit discount, dual pricing, countdown paywall, off-Apple billing
- **User reaction:** 1★-burst
- **Magnitude:** Mechanic | n | % of 19,850 | Signal | Sample IDs ; Charged after trial without perceived consent | 1,102 | 5.55% | HIGH | `2276777044` `2380437896` `3272238239` `4547651109` `4564876103` `6055610596` ; Cannot find a way to cancel | 448 | 2.26% | meaningful | `2178452576` `2294117871` `3501292248` `9994398751` `7855570445` `8981908261` ; "Free" claim in the store description disputed | 379 | 1.91% | meaningful | `2603968263` `3279151694` `3608386362` `9891322915` `12356031942` ; Exit-intent discount (price halves when you decline) | 36 | 0.18% | weak | `4532521548` `4581049748` `6883350995` `3537334343` `3793673176` `9314024371` ; Two different prices for the same term | 42 | 0.21% | weak | `3013464875` `3407578757` `4546194207` `4548741361` `2093895798` ; Countdown-timer paywall with hidden dismiss | — | qualitative | — | `8778546806` `9018706622` `3515037683` `6229315001` ; Billing taken outside Apple, un-cancellable in Settings | — | qualitative | — | `8157301628` `8981908261` `7352163199`
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `2276777044`, `2380437896`, `2178452576`, `2603968263`, `4532521548`, `6883350995`, `3013464875`, `8778546806`, `8157301628`
- **Canonical:** C109 A free trial must be a real trial; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C112 In-app cancellation; C113 One stable, disclosed price — no discount wheels; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

### R13-024 — Smaller conduct themes: upsell nagging, cross-app ads, a 'Balanced' rebrand / copycat / Apalon confusion, stale COVID-era copy, changelogs that describe nothing, a rating prompt, and fake-review allegations (every one a 1★)

- **Where:** §3.1 M-upsell-nag; M-crossapp-ads; C-rebrand ('Balanced', copycat, Apalon); C-stale-content; C-update-fake; C-rate-prompt; C-fake-reviews
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** M-upsell-nag 397 (2.00%) mean 2.27; M-crossapp-ads 48 mean 2.38; C-rebrand 98 (0.49%) mean 3.38; C-stale-content 20; C-update-fake 7; C-rate-prompt 10 mean 2.10; C-fake-reviews 5 mean 1.00
- **Direction for us:** dont · **Report confidence:** weak–meaningful · **Generalisable:** yes
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C114 Ads must match the app

### R13-046 — Support conduct is a rating multiplier: a copy-paste reply that restates Apple's cancellation instructions without addressing the complaint, sometimes posted publicly under the review — multiple reviewers edited their reviews DOWNWARD afterwards ('If you're just going to copy-paste an answer again, don't leave one at all'; 'our team won't be able to prioritize the specific issue you encountered'); a cheap, high-leverage fix fully under the company's control

- **Where:** §4.7 Support conduct is a rating multiplier
- **This app does:** public canned replies
- **User reaction:** 1★-burst
- **Magnitude:** D-support 57 mean 1.35; C-canned-reply 20 mean 1.40, zero 5★
- **Direction for us:** dont · **Report confidence:** weak volume, maximal damage · **Generalisable:** yes
- **Review IDs:** `3369796254`, `2982642975`, `3366758790`, `10784706921`, `1858671482`, `3320840012`, `4458988543`, `5188692960`, `5747695972`, `5932232366`, `6554315923`, `8281301323`, `11089158134`, `11437814220`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C189 Never post canned public replies — answer the specific complaint or don't reply

### R13-052 — Users count the paywalls: '3 separate screens telling me to go premium' in one minute; 'asked to join a free premium trial 3 times within the first minute'; '4 times in 1 minute during registration'; 'more than 10 pop ups' in five minutes; '15 notifications in the first 3 minutes'; '3 full screen countdowns to subscribe during setup' with the dismiss hidden; 'unable to close until I closed the app manually'; many say they would have paid had they been allowed to try first — the clearest experiment: delay the first interstitial until the user has completed habits on three separate days

- **Where:** §5.4 The interstitial problem, quantified by reviewers themselves; delay the first interstitial until the user has completed habits on three separate days
- **This app does:** multiple full-screen countdown paywalls in the first minute
- **User reaction:** blocked-conversion
- **Magnitude:** M-upsell-nag 397 (2.00%) mean 2.27; 5 'would have paid' IDs
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `6044246844`, `6277521468`, `8467812056`, `7160729894`, `6364577409`, `8778546806`, `9018706622`, `2475980289`, `3243630686`, `9232056269`, `10227478057`, `8166604351`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C137 Show the paywall at the moment of need, not on app open; C147 Let people use the product before they pay

### R13-078 — Stop the exit-intent discount — halving the price the moment someone declines tells every full-price buyer they overpaid

- **Where:** §8.1 #6 Stop the exit-intent discount
- **This app does:** 49% exit discount
- **User reaction:** complaint
- **Magnitude:** M-exit-discount 36
- **Direction for us:** dont · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `6883350995`, `4581049748`, `3537334343`, `4356723890`
- **Canonical:** C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

### R13-079 — Retire canned public replies — answer the specific complaint or do not reply; the cheapest rating repair available

- **Where:** §8.1 #7 Retire canned public replies
- **This app does:** canned public replies
- **User reaction:** 1★-burst
- **Magnitude:** C-canned-reply 20 mean 1.40, zero 5★; D-support 57 mean 1.35
- **Direction for us:** dont · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C189 Never post canned public replies — answer the specific complaint or don't reply

### R13-086 — Re-examine the price ladder: weekly billing at $3.99–€6 draws uniquely hostile reactions and is the format most associated with the word 'immoral' in this corpus

- **Where:** §8.4 #3 Re-examine the price ladder — weekly billing is the format most associated with the word 'immoral'
- **This app does:** weekly tier
- **User reaction:** 1★-burst
- **Magnitude:** M-price-high 26.7% of 2025 [small sample]
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C190 No weekly billing tier

## Things to do

### R13-010 — The cheapest unshipped wins in order of evidence weight: honest pre-download price disclosure; a working in-app cancel path; cross-device sync (rising to 7.4% by 2026); Arabic and other localisation (Saudi Arabia 20.5%); flexible scheduling (specific weekdays, every-N-days, N-times-per-week); habit reordering that persists

- **Where:** EXECUTIVE SUMMARY #7 The cheapest unshipped wins are unambiguous
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** sync 2.50% global → 7.4% (2026); SA localisation 20.5%
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C027 Localise early — it unlocks revenue; C043 Flexible / custom frequency; C073 Manual reordering, renaming and editing of habits/tasks — free; C181 If the app is paid-only, say so in the subtitle and first screenshot

### R13-077 — State the price and the subscription requirement in the store listing's first line — reviewers quote 'Productive is a free tool' back verbatim; converts a trust complaint into an expectation

- **Where:** §8.1 #5 State the price and the subscription requirement in the store listing's first line
- **This app does:** listing says 'free tool'
- **User reaction:** 1★-burst
- **Magnitude:** M-not-free 379 (1.91%) mean 1.73
- **Direction for us:** do · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `2603968263`, `3279151694`, `3608386362`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C181 If the app is paid-only, say so in the subtitle and first screenshot

### R13-080 — Regional priority: ship the billing fixes to China and South Korea first — 9.6% of the corpus but 62.4% of all involuntary-charge reviews; in China password-free payment means an explicit in-app confirmation step is required, not optional

- **Where:** §8.1 Regional priority — ship to China and South Korea first; explicit in-app confirmation step required in China
- **This app does:** no confirmation before charge in CN
- **User reaction:** 1★-burst
- **Magnitude:** CN+KR 534 of 856 involuntary (62.4%)
- **Direction for us:** do · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C187 No paid acquisition into an auto-converting trial in frictionless-payment markets

### R13-087 — Price by market — the same USD price is 'three meals' in one market and 'fourteen meals' in another; China's mean of 1.84 is not a product verdict

- **Where:** §8.4 #4 Price by market — 'three meals' vs 'fourteen meals'
- **This app does:** single global price
- **User reaction:** complaint
- **Magnitude:** CN mean 1.84
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `5525308783`
- **Canonical:** C092 Regional pricing

## Contradictions

### R13-045 — Themes on both sides of the rating line: price and subscription objections from fans who keep using it; stats praised when present and resented when gated; icons loved by most and called 'childish' by some; the Skip function genuinely praised but too rigid for others; the Watch app beloved when working and dead for long stretches; Challenges enjoyed by some, 'please let me hide it' from others

- **Where:** §4.6 Themes that cut across the rating line table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 5★ n | 1★ n | Why it appears on both sides ; M-price-high | 456 | 897 | Fans say it's overpriced *and* keep using it ; M-sub-objection | 428 | 973 | Objection to the *model*, decoupled from satisfaction ; U-stats | 171 | 55 | Praised when present, resented when gated ; U-icons | 182 | 25 | Loved by most; called "childish" by some (`1233009943`) ; U-skip-flex | 94 | 8 | The Skip function is genuinely praised (`5395232140`) but too rigid for others ; D-watch | 80 | 32 | Beloved when working, dead for long stretches (`2873841903`, `2957074134`) ; U-challenges | 49 | 14 | Enjoyed by some, "please let me hide it" from others (`9948539388`) ; U-clutter | 128 | 16 | Mostly mild feedback inside otherwise positive reviews
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** yes
- **Review IDs:** `1233009943`, `5395232140`, `2873841903`, `2957074134`, `9948539388`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C024 Streaks / gamification; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

## Data caveats and method

### R13-002 — Method: denominator 19,850, non-exclusive themes, standard bands; the corpus is heavily a billing-dispute sample (25.76% 1★) — do not read mean 3.51 as product quality; regex classifier with 90 themes and patterns in 23 languages, coverage differs by language so themes are under-counted never over-counted (M-free-limit fires on 4.9% of US vs 0.4% of CN reviews — a coverage artefact), so cross-country comparison leads with rating distributions; paid-evidence split into voluntary purchase vs involuntary charge and never merged; corpus back-weighted to 2015–2020 (82.5%), only 627 reviews (3.16%) from 2024–26 [small sample]; no version field — release attribution is date-based or reviewer-stated; direct reading of the full 2015–19 1★ stream (875) plus seven residual-closure loops (37.24% → 10.64% unclassified, all read, no new theme survived); D-stuck-updating hand-audited 43 of 46 true positives (93.5%); prices are reviewer-reported; developer replies not in corpus

- **Where:** How to read this; ⚠️ Five warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations; §9.1–9.2
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 19,850 / 19,850 parsed; 0 duplicate IDs; 115/115 storefronts reconcile; 0 empty bodies; no deduplication (121 repeats are legit); edited 353 (1.78%); upvoted 1,040 (5.24%)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R13-022 — Ninety themes ranked with n, %, signal, mean, 1★ n, 5★ n and direction

- **Where:** §3.1 Complete ranked theme table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % | Signal | Mean★ | 1★ n | 5★ n | Direction ; G-praise-generic | 9,205 | 46.37% | HIGH | 4.36 | 551 | 6,262 | positive ; P-utility (it helps / keeps me on track) | 5,565 | 28.04% | HIGH | 4.29 | 494 | 3,822 | positive ; P-simple (simple, easy, clean) | 3,284 | 16.54% | HIGH | 4.39 | 244 | 2,401 | positive ; G-negative-generic | 2,013 | 10.14% | HIGH | 1.45 | 1,616 | 100 | negative ; M-sub-objection | 1,998 | 10.07% | HIGH | 2.45 | 973 | 428 | negative ; M-price-high | 1,978 | 9.96% | HIGH | 2.52 | 897 | 456 | negative ; M-pay-required | 1,692 | 8.52% | HIGH | 2.13 | 950 | 208 | negative ; P-design (beautiful, sleek) | 1,411 | 7.11% | HIGH | 4.12 | 117 | 846 | positive ; P-recommend | 1,354 | 6.82% | HIGH | 4.25 | 162 | 968 | positive ; P-motivation | 1,339 | 6.75% | HIGH | 4.61 | 43 | 1,057 | positive ; M-trial-autocharge | 1,102 | 5.55% | HIGH | 1.20 | 999 | 23 | negative ; G-feature-request | 999 | 5.03% | HIGH | 3.61 | 162 | 337 | mixed ; P-habit-formed | 902 | 4.54% | very strong | 4.44 | 51 | 655 | positive ; M-free-limit | 860 | 4.33% | very strong | 2.73 | 266 | 158 | negative ; U-confusing | 558 | 2.81% | meaningful | 2.62 | 228 | 125 | negative ; M-refund | 521 | 2.62% | meaningful | 1.42 | 427 | 25 | negative ; D-sync | 497 | 2.50% | meaningful | 2.80 | 128 | 72 | negative ; P-adhd-nd | 463 | 2.33% | meaningful | 3.68 | 82 | 215 | context ; M-cancel-hard | 448 | 2.26% | meaningful | 1.54 | 345 | 27 | negative ; M-upsell-nag | 397 | 2.00% | meaningful | 2.27 | 187 | 63 | negative ; P-life-change | 381 | 1.92% | meaningful | 4.31 | 35 | 286 | positive ; M-not-free | 379 | 1.91% | meaningful | 1.73 | 256 | 31 | negative ; U-stats | 365 | 1.84% | meaningful | 3.76 | 55 | 171 | mixed ; P-flexible-good | 365 | 1.84% | meaningful | 4.40 | 15 | 252 | positive ; U-icons | 308 | 1.55% | meaningful | 4.16 | 25 | 182 | mixed ; P-worth-paying | 290 | 1.46% | meaningful | 3.80 | 56 | 169 | positive ; D-ipad | 277 | 1.40% | meaningful | 2.88 | 69 | 45 | negative ; D-crash | 263 | 1.32% | meaningful | 2.42 | 112 | 42 | negative ; U-notes | 251 | 1.26% | meaningful | 3.45 | 55 | 95 | request ; M-want-onetime | 239 | 1.20% | meaningful | 2.37 | 101 | 26 | request ; D-dataloss | 228 | 1.15% | meaningful | 2.43 | 93 | 34 | negative ; U-exact-time | 227 | 1.14% | meaningful | 3.90 | 17 | 107 | request ; D-watch | 210 | 1.06% | meaningful | 3.55 | 32 | 80 | mixed ; U-clutter | 202 | 1.02% | meaningful | 4.21 | 16 | 128 | mixed ; D-reminder-broken | 196 | 0.99% | emerging | 2.82 | 65 | 47 | negative ; D-widget | 186 | 0.94% | emerging | 3.58 | 27 | 55 | request ; U-quantity (numeric goals) | 165 | 0.83% | emerging | 3.86 | 16 | 77 | request ; U-localization | 164 | 0.83% | emerging | 3.45 | 32 | 57 | request ; U-skip-flex | 155 | 0.78% | emerging | 4.21 | 8 | 94 | mixed ; U-timer | 128 | 0.64% | emerging | 3.54 | 18 | 48 | mixed ; U-challenges | 122 | 0.61% | emerging | 3.71 | 14 | 49 | mixed ; P-reminders-work | 102 | 0.51% | emerging | 3.98 | 12 | 61 | positive ; P-mentalhealth | 100 | 0.50% | emerging | 4.34 | 8 | 71 | context ; C-rebrand ("Balanced", copycat, Apalon) | 98 | 0.49% | weak | 3.38 | 27 | 43 | negative ; U-weekday-schedule | 79 | 0.40% | weak | 3.62 | 10 | 25 | request ; D-update-regression | 87 | 0.44% | weak | 2.39 | 35 | 17 | negative ; M-price-inconsistent | 86 | 0.43% | weak | 2.14 | 45 | 11 | negative ; M-paid-lost (entitlement revoked) | 84 | 0.42% | weak | 2.10 | 48 | 14 | negative ; U-onetime-task | 81 | 0.41% | weak | 3.64 | 13 | 29 | request ; U-onboarding | 80 | 0.40% | weak | 2.75 | 35 | 24 | negative ; D-reorder | 77 | 0.39% | weak | 3.36 | 14 | 25 | negative ; U-desktop / Android / web | 75 | 0.38% | weak | 3.21 | 16 | 21 | request ; U-bad-habit (quit tracking) | 69 | 0.35% | weak | 4.45 | 4 | 48 | request ; U-siri / HealthKit | 66 | 0.33% | weak | 3.55 | 13 | 27 | request ; D-support | 57 | 0.29% | weak | 1.35 | 45 | 1 | negative ; D-perf (lag, slowness) | 56 | 0.28% | weak | 2.59 | 25 | 16 | negative ; U-more-free | 56 | 0.28% | weak | 3.45 | 6 | 10 | request ; U-categories / folders | 56 | 0.28% | weak | 3.93 | 6 | 27 | request ; M-crossapp-ads | 48 | 0.24% | weak | 2.38 | 23 | 7 | negative ; D-stuck-updating | 46 | 0.23% | weak | 2.61 | 19 | 11 | negative ; M-should-be-free | 44 | 0.22% | weak | 2.18 | 19 | 5 | negative ; M-price-tiers | 42 | 0.21% | weak | 1.95 | 23 | 4 | negative ; U-export | 41 | 0.21% | weak | 2.90 | 10 | 8 | request ; P-visual-progress | 39 | 0.20% | weak | 4.33 | 2 | 26 | positive ; C-privacy | 38 | 0.19% | weak | 1.55 | 25 | 1 | negative ; M-exit-discount | 36 | 0.18% | weak | 2.47 | 14 | 5 | negative ; U-dark-mode | 36 | 0.18% | weak | 3.56 | 5 | 12 | request ; U-calendar integration | 35 | 0.18% | weak | 3.60 | 4 | 14 | request ; U-multi-daily | 34 | 0.17% | weak | 3.94 | 2 | 17 | request ; D-notif-spam | 33 | 0.17% | weak | 3.18 | 9 | 8 | negative ; U-touchid / app lock | 31 | 0.16% | weak | 2.90 | 13 | 11 | request ; U-backdate | 29 | 0.15% | weak | 2.66 | 10 | 5 | request ; U-week-start | 28 | 0.14% | weak | 4.11 | 1 | 9 | request ; D-wrongday | 27 | 0.14% | weak | 2.63 | 10 | 5 | negative ; U-swipe-back | 26 | 0.13% | weak | 3.92 | 3 | 14 | request ; U-timer-bg (timer stops when locked) | 25 | 0.13% | weak | 3.12 | 5 | 5 | negative ; U-overview (see upcoming days) | 24 | 0.12% | weak | 3.25 | 6 | 6 | request ; U-order-sort | 22 | 0.11% | weak | 3.41 | 3 | 6 | request ; C-stale-content (COVID/mask copy) | 20 | 0.10% | weak | 3.30 | 7 | 10 | negative ; C-canned-reply | 20 | 0.10% | weak | 1.40 | 15 | 0 | negative ; M-purchase-fail | 19 | 0.10% | ignore | 1.95 | 10 | 1 | negative ; D-cannot-edit-delete | 16 | 0.08% | ignore | 2.50 | 8 | 3 | negative ; P-recovery (sobriety/addiction) | 16 | 0.08% | ignore | 4.31 | 2 | 13 | context ; C-rate-prompt | 10 | 0.05% | ignore | 2.10 | 6 | 0 | negative ; U-signin-required | 7 | 0.04% | ignore | 1.71 | 5 | 0 | negative ; D-auth-prompt | 7 | 0.04% | ignore | 1.86 | 4 | 0 | negative ; C-update-fake (changelog) | 7 | 0.04% | ignore | 2.14 | 3 | 0 | negative ; D-siri-shortcut-broken | 6 | 0.03% | ignore | 3.17 | 1 | 0 | negative ; D-add-broken | 6 | 0.03% | ignore | 1.67 | 4 | 0 | negative ; C-fake-reviews | 5 | 0.03% | ignore | 1.00 | 5 | 0 | negative ; D-premium-not-applied | 2 | 0.01% | ignore | 1.50 | 1 | 0 | negative
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R13-038 — Per-band theme tables for all five star bands

- **Where:** §4.1 5★ table (verbatim); §4.2 4★ table (verbatim); §4.3 3★ table (verbatim); §4.4 2★ table (verbatim); §4.5 1★ table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★: Theme | n | % of 5★ ; G-praise-generic | 6,262 | 65.43% ; P-utility | 3,822 | 39.93% ; P-simple | 2,401 | 25.09% ; P-motivation | 1,057 | 11.04% ; P-recommend | 968 | 10.11% ; P-design | 846 | 8.84% ; P-habit-formed | 655 | 6.84% ; M-price-high | 456 | 4.76% ; M-sub-objection | 428 | 4.47% ; P-life-change | 286 | 2.99% ; P-worth-paying | 169 | 1.77% ;; 4★: Theme | n | % of 4★ ; G-praise-generic | 1,426 | 58.66% ; P-utility | 727 | 29.91% ; P-simple | 367 | 15.10% ; G-feature-request | 310 | 12.75% ; P-design | 222 | 9.13% ; M-sub-objection | 205 | 8.43% ; M-price-high | 178 | 7.32% ; M-free-limit | 133 | 5.47% ; D-sync | 87 | 3.58% ; D-widget | 62 | 2.55% ;; 3★: Theme | n | % of 3★ ; G-praise-generic | 621 | 41.26% ; P-utility | 296 | 19.67% ; M-price-high | 203 | 13.49% ; M-sub-objection | 188 | 12.49% ; M-pay-required | 181 | 12.03% ; D-sync | 134 | 8.90% ; M-free-limit | 151 | 10.03% ; D-ipad | 84 | 5.58% ; D-crash | 49 | 3.26% ;; 2★: Theme | n | % of 2★ ; G-praise-generic | 345 | 28.05% ; M-price-high | 244 | 19.84% ; P-utility | 226 | 18.37% ; M-sub-objection | 204 | 16.59% ; M-pay-required | 171 | 13.90% ; M-free-limit | 152 | 12.36% ; P-design | 102 | 8.29% ; D-sync | 76 | 6.18% ; M-upsell-nag | 74 | 6.02% ; D-dataloss | 39 | 3.17% ;; 1★: Theme | n | % of 1★ ; G-negative-generic | 1,616 | 31.61% ; M-trial-autocharge | 999 | 19.54% ; M-sub-objection | 973 | 19.03% ; M-pay-required | 950 | 18.58% ; M-price-high | 897 | 17.54% ; G-praise-generic | 551 | 10.78% ; P-utility | 494 | 9.66% ; M-refund | 427 | 8.35% ; M-cancel-hard | 345 | 6.75% ; M-free-limit | 266 | 5.20% ; M-not-free | 256 | 5.01% ; U-confusing | 228 | 4.46% ; M-upsell-nag | 187 | 3.66% ; D-sync | 128 | 2.50%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R13-047 — Transaction language is split because people mention money mainly when it went wrong: voluntary purchase vs involuntary charge are the same size (review-visible ratio 1:1); reported as one group the mean is 1.85, an artefact; no conversion, churn, renewal, revenue or subscriber count is claimable

- **Where:** §5.1 The evidence base, stated honestly table (verbatim); the two populations are the same size
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 1,736 (8.75%) transaction language; Segment | Definition | n | % of corpus | Mean★ ; Voluntary purchase | Reviewer says *they chose* to buy / subscribe / upgrade | 836 | 4.21% | 3.06 ; Involuntary charge | Reviewer says they were charged without consent / want a refund | 856 | 4.31% | 1.27 ; Both | Chose to buy, *then* had a billing dispute | 51 | 0.26% | 1.31
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R13-072 — Not claimed: that review-volume decline (4,398 → 68) indicates usage decline (volume follows prompt policy, store changes and paid acquisition — the 2019–20 spike is substantially Chinese acquisition); reliable 2024–26 theme rates at fine granularity; that the 2020 free-tier reversal caused any rating change; developer intent behind any dark pattern

- **Where:** §7.9 Trends explicitly NOT claimed
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** n=413/146/68 for 2024–26
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R13-090 — Research questions: actual trial→paid conversion and how much is unintended; how many subscribers sync successfully; would a perpetual unlock cannibalise or expand; did the Oct 2020 launch failure cause churn; is the weekly tier net-positive despite rating damage; what share of Douyin installs understood they were purchasing; does the app still collect location and why

- **Where:** §8.6 Research questions this corpus cannot answer; part 8 #1; part 8 #2; part 8 #3; part 8 #4; part 8 #5; part 8 #6; part 8 #7
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 7 questions
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** yes
- **Canonical:** — (nuance register)
