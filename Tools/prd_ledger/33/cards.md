# Cards — report 33

Source: `App Store Reports/33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks (REPORT).md`  
227 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 11
- [Must-haves](#must-haves) — 10
- [Must never break](#must-never-break) — 46
- [Features](#features) — 38
- [Monetization](#monetization) — 22
- [Tactics the app used](#tactics-the-app-used) — 6
- [Insights (the why)](#insights-the-why) — 25
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 19
- [Dated events and trends](#dated-events-and-trends) — 14
- [Positioning](#positioning) — 5
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 8
- [Things to do](#things-to-do) — 3
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 16

## Product rules

### R33-031 — Keep a lifetime option as the anchor beside subscriptions: the entry price moved from a $3–10 one-off (2016–18) to $25–40 a year or $40–99 once, and the lifetime option is the model's anchor — 112 payers mention a lifetime / one-time purchase (mean 3.62) and cite it as the reason they chose Habitify over subscription-only rivals; regional prices are a recurring objection (Vietnam, Turkey, Korea, Japan — 'unfair to base your pricing on [exchange rates] alone'); a monthly plan is not offered in every storefront, or only on the web

- **Where:** §2.3 Interpretation — entry price moved from a $3–10 one-off (2016–18) to $25–40 a year or $40–99 once; the lifetime option is the model's anchor: 112 payers mention a lifetime / one-time purchase (mean 3.62) and cite it as the reason they chose Habitify over subscription-only rivals; regional prices are a recurring objection (Vietnam, Turkey, Korea, Japan: 'unfair to base your pricing on [exchange rates] alone'); a monthly plan is not offered in every storefront, or only on the web
- **This app does:** lifetime + subscription
- **User reaction:** purchase-driver
- **Magnitude:** 112 payers (3.62)
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `4179813347`, `6343893474`, `4771857078`, `6966124853`, `5211451534`, `14106494461`, `5583352286`, `11335013815`, `12163064741`, `11509675380`, `12814496096`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C092 Regional pricing; C163 Visible monthly plan — annual-default trials drive billing disputes

### R33-126 — What turns a free user into a 1★ is not the cap itself (tolerated by many, 18 defend it) but losing access they already had (notes, check-ins), a price set without regard to local income, and no way to try Premium before a year-long commitment; against the objections sit 99 price-praise reviews (mean 4.85) and 51 one-time/lifetime praises (4.63) — 'the one time cost of $9.99 for lifetime use … Most habit apps look to charge a monthly subscription... Habitify does not'; 'Cheap life time subscription!'; 'permanent premium is only equal to other apps' annual fee'; 'I would have paid triple'

- **Where:** §3.3 Against these sit 99 price-praise (mean 4.85) and 51 one-time/lifetime praises (4.63) — 'the one time cost of $9.99 for lifetime use … Habitify does not'; 'Cheap life time subscription!'; 'permanent premium is only equal to other apps' annual fee'; 'I would have paid triple' — interpretation: the cap is tolerated by many, including 18 who defend it; what turns a free user into a 1★ is losing access they already had (notes, check-ins), a price set without regard to local income, and having no way to try Premium before a year-long commitment
- **This app does:** lifetime price praised
- **User reaction:** purchase-driver
- **Magnitude:** 99 (4.85); 51 (4.63); 18 defend cap
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `3440017816`, `6058800143`, `6481448783`, `14234671252`, `2524381507`, `5049998510`, `14107414859`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R33-137 — A check-in cap punishes the most engaged free users: from Oct 2020 free users could log only ~15 check-ins a week, locking long streaks ('After 500 days I was pay-walled'; 432 days; 2 years of data) — 29 reviews, mean 2.00, 51.7% 1★, 4.2% of E3; 'three habits is reasonable. The problem … I can't check into those habits more than 15 times a week'; 'limiting the number of check ins per week ruins the whole point'

- **Where:** §4.2 Never meter check-ins on the free tier — the Oct 2020 weekly check-in cap (15 per week) locked long-time free users out mid-streak: 29 reviews, mean 2.00, 'punishes the most engaged free users'
- **This app does:** 15 check-ins/week
- **User reaction:** 1★-burst
- **Magnitude:** 29 (0.74%), 2.00; E3 4.2%
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `6495113718`, `6515490377`, `6541638912`, `7038821896`, `7108556777`, `10871729516`, `11354879589`
- **Canonical:** C176 Never let fear of losing history be the reason people pay; C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R33-143 — If cross-platform is what people pay for, ship platforms in parity: cross-platform availability is a top reason to choose and pay (106 praise reviews rated 4–5★) and the top engineering complaint of 2020–23, because one platform shipped ahead of the others — iOS first, Mac months later — so users who bought for parity experienced broken parity

- **Where:** §4.4 Interpretation — cross-platform availability is a top reason people choose and pay (106 praise rated 4–5★) and also the top engineering complaint of 2020–23; the pattern is one platform shipping ahead of the others (iOS first, Mac months later), so users who bought for parity experience broken parity
- **This app does:** iOS-first releases
- **User reaction:** churn
- **Magnitude:** 106 praise vs 354 issues
- **Direction for us:** must-never-break · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-166 — A lifetime model obliges the developer to migrate, not delete: a lifetime purchase is a bet on continuity, and the reviews where lifetime holders turn hostile are about removals, not price — 'I paid for the lifetime subscription because the old app was exactly what I wanted. It never occurred to me that they would update it and actually remove things … I wish I had got the monthly subscription so I could cancel'; history navigation broken 9 months in; widgets ruined by the May 2025 update; the passcode lock removed; reordering never works; 'a lifetime subscriber … on the Watch it keeps asking me to subscribe'

- **Where:** §6.7 The lifetime holder is the most sensitive customer — a lifetime purchase is a bet on continuity; hostile lifetime reviews are about removals, not price ('I paid for the lifetime subscription because the old app was exactly what I wanted. It never occurred to me that they would update it and actually remove things … I wish I had got the monthly subscription so I could cancel'; history navigation broken 9 months in; widgets ruined after May 2025; passcode lock removed; reordering never works; 'a lifetime subscriber … on the Watch it keeps asking me to subscribe'); a lifetime model obliges the developer to migrate, not delete
- **This app does:** lifetime holders hit by removals
- **User reaction:** churn
- **Magnitude:** 112 lifetime payers (3.62)
- **Direction for us:** must-never-break · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `6373708406`, `6682256233`, `12711946464`, `12506599929`, `13701264625`, `14023238746`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace; C186 Never revoke what earlier buyers paid for when the model changes

### R33-195 — A lifetime price is also a promise: removing features from lifetime holders produces the angriest paid reviews ('I wish I had got the monthly subscription so I could cancel')

- **Where:** Part 9 #3 — a lifetime price is also a promise: removing features from lifetime holders produces the angriest paid reviews ('I wish I had got the monthly subscription so I could cancel')
- **This app does:** removals hit lifetime holders
- **User reaction:** churn
- **Magnitude:** qualitative
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `6373708406`
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

### R33-196 — Cross-platform wins sales and loses stars: offer one account on every device only if every device ships on the same day

- **Where:** Part 9 #4 — cross-platform wins sales and loses stars: offer one account on every device only if every device ships on the same day
- **This app does:** platform lag
- **User reaction:** mixed
- **Magnitude:** 106 praise vs 354 issues
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-197 — Never take back what a free user already has: the check-in cap (mean 2.00) and moving notes to Premium generated more hostility per review than the habit cap itself (2.31)

- **Where:** Part 9 #5 — never take back what a free user already has: the check-in cap (mean 2.00) and notes-to-Premium moves generated more hostility per review than the cap itself
- **This app does:** take-backs
- **User reaction:** 1★-burst
- **Magnitude:** 2.00 vs 2.31
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R33-210 — Release parity: no feature ships on iOS without Mac, web and Watch support in the same release, or a visible 'coming' state — Mac/web was 18.5% of 2022 reviews and support conceded the gap

- **Where:** Part 10 #10 §10.3 Near-term — parity, sync and reach [4.4]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 18.5% of 2022
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `7727790054`
- **Canonical:** C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-215 — Every removal gets a toggle or a migration — priorities: notes back-dating and editing, an off switch for the 'day is over?' pop-up, the passcode lock, ordering that sticks

- **Where:** Part 10 #15 §10.4 Near-term — stop removing, start migrating [4.5, 6.7]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 197 regression
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `12185327521`, `13665455992`, `12506599929`, `13701264625`, `13659075450`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace

### R33-216 — Keep 'simple mode' defaults: hide friends, challenges and journal until enabled — complexity complaints tripled to 5.8% of E5

- **Where:** Part 10 #16 §10.4 [8.3]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 5.8% of E5
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13209298416`, `14144429082`, `9616844062`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

## Must-haves

### R33-060 — Support failure (union)

- **Where:** §3.1 theme table #26 Support failure (union)
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 131 (3.33%, very strong), mean 1.70; 1★ 89
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R33-063 — Confusing / hard to use, rising to 5.8% of E5

- **Where:** §3.1 theme table #29 Confusing / hard to use
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 116 (2.94%, meaningful), mean 2.72
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C142 Surface existing features where users look

### R33-071 — Support unresponsive / contact broken

- **Where:** §3.1 theme table #37 Support unresponsive / contact broken
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 91 (2.31%, meaningful), mean 1.91
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R33-111 — Forced account / guest confusion

- **Where:** §3.1 theme table #77 Forced account / guest confusion
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 26 (0.66%, emerging), mean 2.92
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C035 Account system from day one

### R33-131 — Broken or regressed: China access, entitlement, Mac/web sync and sign-in, Watch, widgets, notes, the timer, export, streak display, 'N per week', ordering, Health counts, account deletion, e-mail opt-out; misunderstandings — a UX problem, not a gap — with complexity at 116 reviews rising to 5.8% of E5: the time-of-day filter hides habits ('I had previously said that the app is buggy … it was because of the selected time of day filter'); how to reorder and how to delete a habit; skip vs cancel vs fail; 'every day starts skipped' (a setting); where the timer is; how to connect the Watch

- **Where:** §3.5 Broken or regressed (Part 4): China access, entitlement, Mac/web sync and sign-in, Watch, widgets, notes, the timer, export, streak display, 'N per week', ordering, Health counts, account deletion, email opt-out; misunderstandings (a UX problem) — complexity 116, rising to 5.8% of E5: the time-of-day filter hides habits ('I had previously said that the app is buggy … it was because of the selected time of day filter'); how to reorder and delete a habit; skip vs cancel vs fail; 'every day starts skipped' (a setting); where the timer is; how to connect the Watch
- **This app does:** legibility gaps as features grow
- **User reaction:** complaint
- **Magnitude:** 116 (2.94%); 5.8% of E5
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `5224462090`, `6864103347`, `5938727222`, `12610965791`, `12785440572`, `7521935821`, `9771138270`, `14135755783`
- **Canonical:** C142 Surface existing features where users look; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R33-138 — Tell users the habit limit before they create habits, not after: 'you finally mention that habits are limited … after they've created it'

- **Where:** §4.2 Disclose limits before creation — 'you finally mention that habits are limited … after they've created it'
- **This app does:** limit disclosed late
- **User reaction:** complaint
- **Magnitude:** 1 named
- **Direction for us:** must-have · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `3463341082`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R33-207 — Show the renewal date, price and a cancel link in-app for every billing channel: 13 cancellation traps; 45 refund reviews

- **Where:** Part 10 #7 §10.2 [4.3]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 13; 45
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `6559520547`, `8371039111`
- **Canonical:** C112 In-app cancellation

### R33-211 — Offer iCloud sync as an option alongside the account backend, and a reachable endpoint for mainland China: 173 China reviews; iCloud requested repeatedly

- **Where:** Part 10 #11 §10.3 [4.1, 4.4]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 173
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `3208341657`, `4505011830`, `9491548292`, `11626791974`
- **Canonical:** C030 Sync must work — and prove it; C132 Do not sell in a storefront where the app cannot function

### R33-212 — Restore interactive widgets (incremental +1, streak, compact) and fix widget refresh on iPad: widget complaints were 6.3% of 2025

- **Where:** Part 10 #12 §10.3 [4.4, 8.5]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 6.3% of 2025
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `12711946464`, `12832854491`, `12402275998`
- **Canonical:** C023 Interactive widget check-off

### R33-213 — Watch: single-tap completion and area / time-of-day complications back; sync without opening the phone

- **Where:** Part 10 #13 §10.3 [4.4]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 100 Watch
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `12081627373`, `13224394178`, `9545911562`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

## Must never break

### R33-008 — Cross-device reliability is the persistent engineering weakness: platform issues — Mac/web app, Watch, widgets and sync — 354 reviews (8.99%, high-priority), mean 2.87, rising from 3.7% of E1 to 18.7% of 2020–21 and 19.9% of 2022–23; the Mac app stalled in 2021–22 (no sync, stuck in 'Guest', 'abandoned'; XPLAT- reached 18.5% of 2022; support conceded 'the update version is only released on phone, not the MacOS yet'), fixed in macOS 13.0.1 (Dec 2022 – Feb 2023); Watch problems 100; widget problems 85, rising to 6.3% of 2025 after the May 2025 widget redesign

- **Where:** Executive summary #4 — cross-device reliability is the persistent engineering weakness: platform issues (Mac/web app, Watch, widgets, sync) 354 (8.99%, high-priority), mean 2.87, rising 3.7% of E1 → 18.7% of 2020–21 → 19.9% of 2022–23; Mac app stalled 2021–22 (no sync, stuck in 'Guest', 'abandoned'; XPLAT- 18.5% of 2022; support: 'the update version is only released on phone, not the MacOS yet'; fixed in macOS 13.0.1, Dec 2022 – Feb 2023); Watch problems 100; widget problems 85, rising to 6.3% of 2025 after the May 2025 widget redesign
- **This app does:** multi-platform parity gaps
- **User reaction:** complaint
- **Magnitude:** 354 (8.99%), 2.87; 3.7% → 18.7% → 19.9%; XPLAT- 18.5% of 2022; Watch 100; widget 85 (6.3% of 2025)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `7727790054`, `9359375535`, `9570248200`, `6378964234`, `7997487916`, `9545911562`, `12711946464`, `12832854491`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C023 Interactive widget check-off; C044 Mac / desktop / web app; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-010 — Billing and entitlement integrity is smaller than at some peers but concentrates on the best customers: 147 reviews (3.73%, very strong), mean 2.22 — Premium not granted or lost 69, refunds 45, disputed charges 42, cannot cancel 13, promotions shown to people who already paid 14; two patterns — the Jan 2018 purchase wave (21 reviews, 11 from Japan, all fixed within about two weeks) and entitlements that don't follow the user across a new phone, guest → account, a web purchase (Paddle) → iPhone, or after an update (18 days without activation; 6 weeks, later resolved)

- **Where:** Executive summary #6 — billing and entitlement integrity is smaller than at some peers, but it concentrates on the best customers: 147 (3.73%, very strong), mean 2.22 — Premium not granted or lost 69; refunds 45; disputed charges 42; cannot cancel 13; promotions shown to people who already paid 14; the Jan 2018 purchase wave: 21 reviews, 11 from Japan, all fixed within about two weeks; entitlements that don't follow the user across a new phone, guest → account, web purchase (Paddle) → iPhone, or after an update (18 days without activation; 6 weeks, later resolved)
- **This app does:** entitlement portability failures
- **User reaction:** 1★-burst
- **Magnitude:** 147 (3.73%), 2.22; not granted 69; refunds 45; disputes 42; cancel 13; promo-to-payers 14; Jan 2018 wave 21 (11 jp)
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `2093117380`, `2132082291`, `6574885307`, `6934749412`, `13400575929`, `13516370858`, `13732504298`, `14029456083`, `14023238746`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-011 — Account and data trust is the sharpest reputational risk: 102 reviews (2.59%), mean 1.80 — account deletion that spins forever 47 (mean 1.23, 41 of them 1★; 2019–2025, heavily from Korea and Japan); unwanted marketing e-mail 37, 27 of them in July 2023 (12.7% of all 2023 reviews) — dormant or deleted accounts received daily e-mails with no working unsubscribe link, reviewers citing GDPR/ICO and CAN-SPAM, and a privacy professional still reporting failure in May 2024; privacy 23 (mean 1.35), including a reviewer who saw other customers' support conversations, e-mails and photos in the in-app help, and goal-share URLs that work without login

- **Where:** Executive summary #7 — account and data trust is the sharpest reputational risk: 102 (2.59%), mean 1.80; account deletion that spins forever 47, mean 1.23, 41 1★ (2019–2025, heavily Korea and Japan); unwanted marketing email 37, 27 in July 2023 (12.7% of all 2023 reviews) — dormant or deleted accounts received daily emails with no working unsubscribe; GDPR/ICO and CAN-SPAM cited; a privacy professional still reported failure May 2024; privacy 23, mean 1.35 — a reviewer saw other customers' support conversations, emails and photos in the in-app help; goal-share URLs work without login
- **This app does:** deletion broken; spam to deleted accounts; support-chat leak
- **User reaction:** 1★-burst
- **Magnitude:** 102 (2.59%), 1.80; deletion 47 (1.23, 41 1★); e-mail 37 (27 Jul 2023, 12.7% of 2023); privacy 23 (1.35)
- **Direction for us:** must-never-break · **Report confidence:** meaningful; sharpest ratings · **Generalisable:** yes
- **Review IDs:** `5202035434`, `6091415990`, `12715605250`, `10101814356`, `10095812056`, `11244516686`, `10638299850`, `8440977492`
- **Canonical:** C096 Privacy and discretion stack; C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-036 — Reliability (union)

- **Where:** §3.1 theme table #2 Reliability (union)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 950 (24.12%, high-priority), mean 2.69; 1★ 317; E3 38.9%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R33-042 — Platform issues: Mac/web, Watch, widget, sync (union)

- **Where:** §3.1 theme table #8 Platform issues: Mac/web, Watch, widget, sync (union)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 354 (8.99%, high-priority), mean 2.87; E3 18.7, E4 19.9
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-046 — Other functional bug

- **Where:** §3.1 theme table #12 Other functional bug
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 297 (7.54%, high-priority), mean 2.85
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-051 — Regression (union: update worse / feature removed), E3 14.9%

- **Where:** §3.1 theme table #17 Regression (union: update worse / feature removed)
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 197 (5.00%, very strong*), mean 2.51
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace; C175 Updates must not break function or wipe progress

### R33-054 — An update made it worse, E3 12.8%

- **Where:** §3.1 theme table #20 An update made it worse
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 170 (4.32%, very strong), mean 2.42
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C175 Updates must not break function or wipe progress

### R33-055 — Login / registration fails — mostly China and the Mac app

- **Where:** §3.1 theme table #21 Login / registration fails
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 151 (3.83%, very strong), mean 2.19; E1 7.3, E4 7.2
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C132 Do not sell in a storefront where the app cannot function; C188 The app must open offline — never block launch on a network call

### R33-056 — Billing & entitlement integrity (union)

- **Where:** §3.1 theme table #22 Billing & entitlement integrity (union)
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 147 (3.73%, very strong), mean 2.22
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately

### R33-057 — Mac / web / iPad / Android app broken or lagging, E4 12.2%

- **Where:** §3.1 theme table #23 Mac / web / iPad / Android app broken or lagging
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 141 (3.58%, very strong), mean 2.74
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C044 Mac / desktop / web app; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-062 — Sync missing / fails, E4 7.9%

- **Where:** §3.1 theme table #28 Sync missing / fails
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 119 (3.02%, very strong), mean 2.69
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it

### R33-067 — Account, email & data trust (union), E4 7.9%

- **Where:** §3.1 theme table #33 Account, email & data trust (union)
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 102 (2.59%, meaningful), mean 1.80
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C096 Privacy and discretion stack; C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-068 — Apple Watch app broken / poor, E3 6.8%

- **Where:** §3.1 theme table #34 Apple Watch app broken / poor
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 100 (2.54%, meaningful), mean 2.84
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R33-070 — Crash / won't open

- **Where:** §3.1 theme table #36 Crash / won't open
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 94 (2.39%, meaningful), mean 2.14
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R33-073 — Stats / streaks wrong or weak, E3 7.0%

- **Where:** §3.1 theme table #39 Stats / streaks wrong or weak
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 89 (2.26%, meaningful), mean 2.82
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R33-076 — Widget broken / poor / removed, E5 5.2%

- **Where:** §3.1 theme table #42 Widget broken / poor / removed
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 85 (2.16%, meaningful), mean 3.15
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app

### R33-078 — A feature was removed, E3 6.0%

- **Where:** §3.1 theme table #44 A feature was removed
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 82 (2.08%, meaningful), mean 2.77
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace

### R33-081 — Paid but Premium not granted / lost, E1 3.6%

- **Where:** §3.1 theme table #47 Paid but Premium not granted / lost
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 69 (1.75%, meaningful), mean 2.33
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R33-082 — Reminders not firing / wrong

- **Where:** §3.1 theme table #48 Reminders not firing / wrong
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 68 (1.73%, meaningful), mean 2.68
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once

### R33-086 — Data / history lost

- **Where:** §3.1 theme table #52 Data / history lost
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 55 (1.40%, meaningful), mean 2.25
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R33-088 — Freeze / lag / slow

- **Where:** §3.1 theme table #54 Freeze / lag / slow
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 52 (1.32%, meaningful), mean 2.58
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C083 Performance must not degrade with habit count

### R33-094 — Account deletion fails — zero 5★, 41 1★

- **Where:** §3.1 theme table #60 Account deletion fails
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 47 (1.19%, meaningful), mean 1.23
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot

### R33-095 — Refund requested / discussed

- **Where:** §3.1 theme table #61 Refund requested / discussed
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 45 (1.14%, meaningful), mean 2.16
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R33-099 — Billing dispute / unexpected charge / scam language

- **Where:** §3.1 theme table #65 Billing dispute / unexpected charge / scam language
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 42 (1.07%, meaningful), mean 1.90
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right

### R33-102 — Unwanted marketing email — E4 6.5%

- **Where:** §3.1 theme table #68 Unwanted marketing email
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 37 (0.94%, emerging), mean 1.41; 1★ 30
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-104 — Price hidden / misleading 'free' / unclear

- **Where:** §3.1 theme table #70 Price hidden / misleading "free" / unclear
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 34 (0.86%, emerging), mean 2.18
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R33-115 — Privacy / data-handling concern — zero 5★

- **Where:** §3.1 theme table #81 Privacy / data-handling concern
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 23 (0.58%, emerging), mean 1.35; 1★ 17; E4 2.4%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C096 Privacy and discretion stack

### R33-133 — A mandatory non-Apple backend unreachable in mainland China made the app unusable there for eight years: 173 reviews (4.39%), mean 2.36, 171 from cn; 11.5% of E1 falling to 1.2% of E5 only because China reviews fell (162 → 12), not because it was fixed; Oct 2016 – 2017 the mainland download showed the Japanese UI, could not register, login failed after an update ('only via VPN can I log in'); Jun & Sep 2018 stuck on the tour spinner, 'Oh no! Something went wrong' at registration, saved habits never appear ('should tell users at the start that the app needs a VPN'; 'the Great Firewall … mandatory registration'); 13 Dec 2018 – 10 Jan 2019 the same failure after an App Store 'Today' feature — 68 China reviews, mean 2.34 ('can't register — and you recommended it on the home page?'); 2019 – 2021 sync and login need a VPN and paid users cannot use what they bought (iPhone/iPad/Mac sync only on VPN; 'I'd pay 188 RMB lifetime if you fixed the server'; 328 RMB lifetime, refunds refused); 2022 – 2026 still unresolved ('10 minutes to open'; 'thank you for the Chinese localisation … but I simply cannot log in'; 'I want to pay but doubt it works in China')

- **Where:** §4.1 Cluster 1 — mainland China (verbatim table): 173 (4.39%), mean 2.36, 171 from cn; 11.5% of E1 → 1.2% of E5 (fewer cn reviews, 162 → 12, not a fix); Oct 2016 – 2017 Japanese UI, cannot register, 'only via VPN can I log in'; Jun & Sep 2018 tour spinner, 'Oh no! Something went wrong' at registration ('should tell users at the start that the app needs a VPN'; 'the Great Firewall … mandatory registration'); 13 Dec 2018 – 10 Jan 2019 after the App Store 'Today' feature 68 China reviews, mean 2.34 ('can't register — and you recommended it on the home page?'); 2019 – 2021 sync and login need a VPN, paid users cannot use what they bought ('I'd pay 188 RMB lifetime if you fixed the server'; 328 RMB lifetime, refunds refused); 2022 – 2026 still unresolved ('10 minutes to open'; 'thank you for the Chinese localisation … but I simply cannot log in'; 'I want to pay but doubt it works in China')
- **This app does:** account-only backend blocked in China
- **User reaction:** 1★-burst
- **Magnitude:** Window | Symptom (as reviewers describe it) | Evidence ; Oct 2016 – 2017 | Mainland download shows the Japanese UI and cannot register; login fails after an update | 1469161177, 1493380781, 1504505526, 1512751825 ("only via VPN can I log in") ; Jun & Sep 2018 | Stuck on the tour spinner; "Oh no! Something went wrong" at registration; saved habits never appear | 2752887130 ("should tell users at the start that the app needs a VPN"), 2756845405 ("the Great Firewall … mandatory registration"), 3161727412, 3188961175 ; 13 Dec 2018 – 10 Jan 2019 | Same failure after an App Store "Today" feature: 68 China reviews, mean 2.34 | 3528438035 ("can't register — and you recommended it on the home page?"), 3541075226 (downloaded from Today), 3589796422, 3590376404, 3617585831 ; 2019 – 2021 | Sync and login need a VPN; paid users cannot use what they bought | 3743506421 (iPhone/iPad/Mac only sync on VPN), 4736772525 (subscribed; "must use VPN in China"), 5602217006 ("I'd pay 188 RMB lifetime if you fixed the server"), 6925930580, 7112692402 (328 RMB lifetime, refunds refused) ; 2022 – 2026 | Still unresolved: "10 minutes to open", login spinner, "can't log in in China recently" | 8227319958 ("thank you for the Chinese localisation … but I simply cannot log in"), 8757334591, 12890334582, 13572613236 ("I want to pay but doubt it works in China"), 14019544061
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1469161177`, `1493380781`, `1504505526`, `1512751825`, `2752887130`, `2756845405`, `3161727412`, `3188961175`, `3528438035`, `3541075226`, `3589796422`, `3590376404`, `3617585831`, `3743506421`, `4736772525`, `5602217006`, `6925930580`, `7112692402`, `8227319958`, `8757334591`, `12890334582`, `13572613236`, `14019544061`
- **Canonical:** C132 Do not sell in a storefront where the app cannot function

### R33-140 — Billing and entitlement integrity: 147 reviews (3.73%), mean 2.22, 84 1★ — Premium not granted, lost or not restorable 69 (1.75%, mean 2.33), refunds 45, billing disputes 42, cancellation traps 13, ads or upsell shown to payers 14, discount not honoured 3; mechanisms — store purchase not applied: 21 in Jan 2018 (11 Japan), fixed ~27 Jan ('thank you for responding right after my review'), a trickle later (paid monthly three times); entitlement doesn't follow the person across a new phone, iPad ↔ iPhone, Mac ↔ iOS, guest → account or web (Paddle) → iPhone, ~25 (a stolen phone; a lifetime tied to one e-mail and paid twice; a Paddle receipt; 18 days; resolved after 6+ weeks and 20+ e-mails); an update or redesign removes Premium ~6 (v2.0 'wiped out my premium status'; a lifetime holder asked to subscribe on the Watch); charged more than shown ~6 (¥4,900 shown, ¥5,150 charged; a $39.99 offer charged $48.97; monthly chosen, annual charged; lifetime then an annual charge); cannot cancel / charged after cancel or deletion 13 ('payments … through a third party and there's no unsubscribe button'; charged >1,700 RUB; deleted account, still charged); refund routed to Apple then refused ('they're unable to process refunds'; 'denied a refund due to the company's arrangement with Apple'; a child's 598 RMB refused twice); ads for the developer's other apps shown to payers 14 (a Nirow ad blocks use; 'False advertisement – Still get ads with lifetime premium')

- **Where:** §4.3 Cluster 3 — billing and entitlement integrity: 147 (3.73%), mean 2.22, 84 1★ — Premium not granted, lost or not restorable 69 (1.75%), 2.33; refunds 45; billing disputes 42; cancellation traps 13; ads or upsell to payers 14; discount not honoured 3; mechanisms (verbatim table): store purchase not applied — 21 in Jan 2018 (11 Japan) fixed ~27 Jan ('thank you for responding right after my review'), a trickle later (paid monthly three times); entitlement doesn't follow the person — new phone, iPad ↔ iPhone, Mac ↔ iOS, guest → account, web (Paddle) → iPhone ~25 (stolen phone; lifetime tied to one email, paid twice; Paddle receipt; 18 days; resolved after 6+ weeks, 20+ emails); update or redesign removes Premium ~6 (v2.0 'wiped out my premium status'; lifetime asked to subscribe on the Watch); charged more than shown ~6 (¥4,900 shown, ¥5,150 charged; $39.99 offer, $48.97 charged; monthly chosen, annual charged; lifetime then annual charge); cannot cancel / charged after cancel or deletion 13 ('payments … through a third party and there's no unsubscribe button'; >1,700 RUB; deleted account, still charged); refund routed to Apple then refused ('they're unable to process refunds'; a child's 598 RMB refused twice); ads for the developer's other apps shown to payers 14 (Nirow ad blocks use; 'False advertisement – Still get ads with lifetime premium')
- **This app does:** portability + third-party billing gaps
- **User reaction:** 1★-burst
- **Magnitude:** Mechanism | n (approx.) | Window | Evidence ; Store purchase not applied | 21 in Jan 2018 (11 Japan); a trickle later | Jan 2018 wave, fixed ~27 Jan 2018; recurring 2019–26 | 2077043653, 2083040453, 2092713521, 2093117380, 2096241882; fixed 2132082291, 2096151645 ("thank you for responding right after my review"). Later: 3730665503 (paid monthly three times), 5058976402, 10292077249, 10693981551, 12270453636, 13951351680 ; Entitlement doesn't follow the person — new phone, iPad ↔ iPhone, Mac ↔ iOS, guest → account, web (Paddle) → iPhone | ~25 | 2018 → 2026 | 2098694832, 3565627936, 4502731816, 6574885307 (stolen phone), 6811003189 (guest → Apple ID), 6925930580 (lifetime tied to one email; paid twice), 7107343222, 7272591152, 13400575929 (Paddle receipt), 13516370858 (18 days), 13732504298 → 14029456083 (resolved after 6+ weeks, 20+ emails) ; Update or redesign removes Premium | ~6 | 2016, 2019, 2020, 2026 | 1495393864 (v2.0 "wiped out my premium status"), 5333682703, 6402220006 ("habits and progress … as well as my subscription"), 14023238746 (lifetime asked to subscribe on the Watch) ; Charged more than shown | ~6 | 2019 → 2020 | 5155111757 (¥4,900 shown, ¥5,150 charged), 6412142626 ($39.99 offer, $48.97 charged), 6677079669 (monthly chosen, annual charged), 10513138749 (lifetime, then an annual charge) ; Cannot cancel / charged after cancel or deletion | 13 | 2019 → 2026 | 6559520547 ("payments … through a third party and there's no 'unsubscribe' button"), 8371039111 (no cancel option; charged >1,700 RUB), 7363611676 (deleted account, still charged), 13684263840, 13550132289 ; Refund routed to Apple, then refused | part of 45 | 2019 → 2026 | 7297383865 ("they're unable to process refunds"), 6461110648 ("denied a refund due to the company's arrangement with Apple"), 10201858110 (a child's 598 RMB, refused twice), 11917816355, 14165773730 ; Ads for the developer's other apps shown to payers | 14 | 2018 → 2025 | 2082489237, 2089193559 (Nirow ad blocks use), 5556783335 ("False advertisement – Still get ads with lifetime premium"), 5652896336, 12158613728
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `2077043653`, `2083040453`, `2092713521`, `2093117380`, `2096241882`, `2132082291`, `2096151645`, `3730665503`, `5058976402`, `10292077249`, `10693981551`, `12270453636`, `13951351680`, `2098694832`, `3565627936`, `4502731816`, `6574885307`, `6811003189`, `6925930580`, `7107343222`, `7272591152`, `13400575929`, `13516370858`, `13732504298`, `14029456083`, `1495393864`, `5333682703`, `6402220006`, `14023238746`, `5155111757`, `6412142626`, `6677079669`, `10513138749`, `6559520547`, `8371039111`, `7363611676`, `13684263840`, `13550132289`, `7297383865`, `6461110648`, `10201858110`, `11917816355`, `14165773730`, `2082489237`, `2089193559`, `5556783335`, `5652896336`, `12158613728`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C112 In-app cancellation; C113 One stable, disclosed price — no discount wheels; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request; C248 Never show an upsell to anyone holding an active or historical entitlement

### R33-142 — Cross-device reliability: platform issues 354 (8.99%), mean 2.87 — Mac / web / iPad / Android 141 (18.5% of 2022), sync 119, Watch 100, widgets 85, and login failures outside China cluster with the Mac app (LOGIN 13.7% of 2022); Mac app — bought separately and buggy (2018) → unavailable in the RU/KR stores (2020) → no sync with iOS (2021) → cannot sign in, stuck as 'Guest', 'abandoned', 'left for a year at a time' (2022; support: 'the update version is only released on phone, not the MacOS yet') → fixed in macOS 13.0.1 (Dec 2022 – Feb 2023) → slow, 1 min to open (2025) → sync broken again (Oct 2025); web app slow with duplicate habits and fewer features ('1 minute to reach the site and tick the first habit'); Apple Watch — broken by iOS 13 (Oct 2019) → won't launch after Habitify X (Aug–Oct 2020) → fixed Jun 2021 → complication broken since iOS 15.1 (Oct 2021 – 2022) → sync lag → 'finally' fixed Jan 2024 → sync issues 2024–26, area complications and single-tap logging removed ('Streaks costs a tenth and works'); widgets — the 2016 Today widget removed ('the entire reason I paid') → iOS 14 widgets non-interactive (2020) → not refreshing on iPad for years → May 2025 redesign removes compact, incremental and streak widgets; sync & sign-in — account-based, personal iCloud sync removed ('Original Habitify was able to sync … over personal iCloud. This has been removed'), Firebase-only, repeated logouts (sign in daily)

- **Where:** §4.4 Cluster 4 — cross-device reliability (verbatim table): platform issues 354 (8.99%), 2.87 — Mac / web / iPad / Android 141 (18.5% of 2022); sync 119; Watch 100; widgets 85; LOGIN 13.7% of 2022 clustering with the Mac app; Mac app 2018 bought separately and buggy → 2020 unavailable in RU/KR stores → 2021 no sync with iOS → 2022 cannot sign in, stuck as 'Guest', 'abandoned' ('left for a year at a time') → fixed in macOS 13.0.1 (Dec 2022 – Feb 2023) → 2025 slow (1 min to open) → Oct 2025 sync broken again; web app slow, duplicate habits, fewer features ('1 minute to reach the site and tick the first habit'); Apple Watch iOS 13 → won't launch after Habitify X → fixed Jun 2021 → complication broken since iOS 15.1 → sync lag → 'finally' fixed Jan 2024 → sync issues 2024–26, area complications and single-tap logging removed ('Streaks costs a tenth and works'); widgets 2016 Today widget removed ('the entire reason I paid') → iOS 14 widgets non-interactive → not refreshing on iPad for years → May 2025 redesign removes compact, incremental and streak widgets; sync & sign-in account-based, personal iCloud sync removed ('Original Habitify was able to sync … over personal iCloud. This has been removed'), Firebase-only, repeated logouts (sign in daily)
- **This app does:** iOS-first, other platforms lag
- **User reaction:** complaint
- **Magnitude:** Surface | Timeline | Evidence ; Mac app | 2018 bought separately and buggy → 2020 unavailable in the RU/KR stores → 2021 no sync with iOS → 2022 cannot sign in, stuck as "Guest", "abandoned" → fixed in macOS 13.0.1 (Dec 2022 – Feb 2023) → 2025 slow (1 min to open) → Oct 2025 sync broken again | 3166206833, 5974877379, 5975638358, 7727790054 (support: "the update version is only released on phone, not the MacOS yet"), 8387555235, 9029892348 ("left for a year at a time"), 9250877212, 9359375535, 9570248200, 13503164488, 13332457934 ; Web app | Slow; duplicate habits; fewer features | 5494522026 ("1 minute to reach the site and tick the first habit"), 6295806726, 8301263103 ; Apple Watch | iOS 13 (Oct 2019) → won't launch after Habitify X (Aug–Oct 2020) → fixed Jun 2021 → complication broken since iOS 15.1 (Oct 2021 – 2022) → sync lag → "finally" fixed Jan 2024 → sync issues 2024–26; area complications and single-tap logging removed | 4880936953, 6378964234, 6385690908, 6462372951, 7477852791, 7885792414, 7997487916 ("Streaks costs a tenth and works"), 9545911562, 10842104134, 11020040946, 13224394178, 12081627373 ; Widgets | 2016 Today widget removed ("the entire reason I paid", 1456032628) → iOS 14 widgets non-interactive (2020) → not refreshing on iPad for years → May 2025 redesign removes compact, incremental and streak widgets | 6544400233, 8308869652 (bought for the old widget), 6798110337, 12402275998, 12703753311, 12711946464, 12832854491, 13448603169, 13981272932 ; Sync & sign-in | Account-based sync; personal iCloud sync removed; Firebase-only; repeated logouts | 9382891858, 9491548292 ("Original Habitify was able to sync … over personal iCloud. This has been removed"), 11626791974, 12000656068, 7907020932 (sign in daily), 14165773730
- **Direction for us:** must-never-break · **Report confidence:** high-priority as a union · **Generalisable:** yes
- **Review IDs:** `3166206833`, `5974877379`, `5975638358`, `7727790054`, `8387555235`, `9029892348`, `9250877212`, `9359375535`, `9570248200`, `13503164488`, `13332457934`, `5494522026`, `6295806726`, `8301263103`, `4880936953`, `6378964234`, `6385690908`, `6462372951`, `7477852791`, `7885792414`, `7997487916`, `9545911562`, `10842104134`, `11020040946`, `13224394178`, `12081627373`, `1456032628`, `6544400233`, `8308869652`, `6798110337`, `12402275998`, `12703753311`, `12711946464`, `12832854491`, `13448603169`, `13981272932`, `9382891858`, `9491548292`, `11626791974`, `12000656068`, `7907020932`, `14165773730`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C023 Interactive widget check-off; C030 Sync must work — and prove it; C044 Mac / desktop / web app; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-144 — Redesigns removed what users relied on — regression 197 (5.00%), mean 2.51, 14.9% of E3; 'update made it worse' 170; 'a feature was removed' 82: v2.0 (29 Nov 2016) charity points gone, data and Premium wiped, login forced (30 routines gone; 'it's mainly what motivated me'); the v3 era (2017) removed skip, notification actions, the 14-day histogram, the Russian UI and morning/day/evening sections; the Apr 2019 paywall move took notes and skip from free users plus percentage stats and yearly totals; 'Habitify X' (v10, ~27 Aug 2020) removed time log and timer data, daily ratio and yearly stats, month swipe, the visible date bar, 'N per week', CSV export, Siri Shortcuts, non-daily streaks and the Watch app — 27 Aug – 31 Oct 2020: 149 reviews, mean 3.14, 42 UPDATE-, 22 REMOVED ('Version X … breaks habits … no migration path'; 4 months of time logs vanished; 'I paid for the lifetime subscription because the old app was exactly what I wanted … $40 down the drain'; weekday habits now break streaks); fire-streak and journal changes (2021–22, the streak count on the complete button); the notes redesign (Dec 2024 – 2026) removed back-dating, editing and custom dates (1,000+ gym days logged in memos); the May 2025 widget redesign removed compact, incremental (+1) and streak widgets; the passcode lock was removed (2025); a Jan 2026 'Are you sure the day is over?' pop-up with no off switch ('infantilizing … Shipping annoying stuff without an off switch is a churn risk')

- **Where:** §4.5 Cluster 5 — redesigns removed what users relied on (verbatim table): regression 197 (5.00%), 2.51 — 14.9% of E3; update worse 170; removed 82; v2.0 29 Nov 2016 charity points, data and Premium wiped, login forced (30 routines gone; 'it's mainly what motivated me'); v3 era 2017 skip, notification actions, 14-day histogram, Russian UI, morning/day/evening sections; paywall move Apr 2019 notes and skip for free users, percentage stats, yearly totals; Habitify X (v10) ~27 Aug 2020 time log and timer data, daily ratio and yearly stats, month swipe, visible date bar, 'N per week', CSV export, Siri Shortcuts, non-daily streaks, Watch app — window 27 Aug – 31 Oct 2020: 149 reviews, mean 3.14, 42 UPDATE-, 22 REMOVED ('Version X … breaks habits … no migration path'; 4 months of time logs vanished; 'I paid for the lifetime subscription because the old app was exactly what I wanted … $40 down the drain'; weekday habits now break streaks); fire-streak and journal changes 2021–22; notes redesign Dec 2024 – 2026 back-dating and editing notes, custom dates (1,000+ gym days logged in memos); widget redesign May 2025 compact, incremental (+1) and streak widgets; passcode lock 2025; fail / skip friction Jan 2026 'Are you sure the day is over?' pop-up with no off switch ('infantilizing … Shipping annoying stuff without an off switch is a churn risk')
- **This app does:** removal without migration
- **User reaction:** churn
- **Magnitude:** Event | When | What was lost | Evidence ; v2.0 | 29 Nov 2016 | Charity points; data and Premium wiped; login forced | 1494883584, 1493584000 (30 routines gone), 1499882108 ("it's mainly what motivated me"), 1500907322 ; v3 era | 2017 | Skip, notification actions, 14-day histogram, Russian UI, morning/day/evening sections | 1592152210, 1516426571, 1552349488, 1556286849 ; Paywall move | Apr 2019 | Notes and skip for free users; percentage stats; yearly totals | 4002480223, 4005130935, 3892831632, 3896982142 ; "Habitify X" (v10) | ~27 Aug 2020 | Time log and timer data; daily ratio and yearly stats; month swipe; visible date bar; "N per week"; CSV export; Siri Shortcuts; non-daily streaks; Watch app | Window 27 Aug – 31 Oct 2020: 149 reviews, mean 3.14, 42 UPDATE-, 22 REMOVED. 6341543939 ("Version X … breaks habits … no migration path"), 6372859679 (4 months of time logs vanished), 6373708406 ("I paid for the lifetime subscription because the old app was exactly what I wanted … $40 down the drain"), 6384710442, 6389260394, 6390610879 (weekday habits now break streaks), 6461110648 ; Fire-streak and journal changes | 2021 – 2022 | Streak count on the complete button; "fire" streak visual | 7779015433, 7871024411, 8292117837 ; Notes redesign | Dec 2024 – 2026 | Back-dating and editing notes; custom dates | 12001725042, 12125726713, 12129630081, 12185327521 (1,000+ gym days logged in memos), 13991900844 ; Widget redesign | May 2025 | Compact, incremental (+1) and streak widgets | 12703753311, 12711946464, 12832854491 ; Passcode lock | 2025 | App passcode | 12506599929 ; Fail / skip friction | Jan 2026 | "Are you sure the day is over?" pop-up with no off switch | 13634328613, 13665455992 ("infantilizing … Shipping annoying stuff without an off switch is a churn risk")
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1494883584`, `1493584000`, `1499882108`, `1500907322`, `1592152210`, `1516426571`, `1552349488`, `1556286849`, `4002480223`, `4005130935`, `3892831632`, `3896982142`, `6341543939`, `6372859679`, `6373708406`, `6384710442`, `6389260394`, `6390610879`, `6461110648`, `7779015433`, `7871024411`, `8292117837`, `12001725042`, `12125726713`, `12129630081`, `12185327521`, `13991900844`, `12703753311`, `12711946464`, `12832854491`, `12506599929`, `13634328613`, `13665455992`
- **Canonical:** C017 Passcode lock; C023 Interactive widget check-off; C104 Never ship a paywall or feature-removal change silently; C155 Never remove a feature people bought the app for — add alongside, do not replace; C172 Per-day / per-habit notes and journal text

### R33-146 — Account deletion that never completes: 47 reviews (1.19%), mean 1.23, 41 of them 1★ — by year 2019 2 · 2020 23 · 2021 7 · 2022 2 · 2023 10 · 2024 1 · 2025 2, Korea 16 (5.5% of Korea) — users who wanted to switch apps found support silent ('emails keep coming, so I can't uninstall'), the app crashed on delete, and 'once you ask the chat bot … it stops answering'; 'I trust it isn't deliberate… but inflating users this way looks bad'; 'Did you choose to block account deletion to keep customers?' — part of the account, e-mail & data trust union 102 (2.59%, mean 1.80, 67 1★; 7.9% of E4)

- **Where:** §4.6 Cluster 6 — account, email and data trust: 102 (2.59%), 1.80, 67 1★; 7.9% of E4 (2023 email wave); (a) account deletion that never completes 47 (1.19%), 1.23, 41 1★ — by year 2019 2 · 2020 23 · 2021 7 · 2022 2 · 2023 10 · 2024 1 · 2025 2; Korea 16 (5.5% of Korea); wanted to switch apps, support silent, 'emails keep coming, so I can't uninstall'; 'I trust it isn't deliberate… but inflating users this way looks bad'; crash on delete; 'once you ask the chat bot … it stops answering'
- **This app does:** deletion spins forever
- **User reaction:** 1★-burst
- **Magnitude:** 47 (1.19%), 1.23; 2020 23; Korea 16 (5.5%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful; sharpest ratings · **Generalisable:** yes
- **Review IDs:** `5006290727`, `5202035434`, `5436553027`, `5683409156`, `5875469166`, `6091415990`, `6434454672`, `7333094952`, `12715605250`, `12515577285`
- **Canonical:** C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot

### R33-147 — Never e-mail dormant or deleted accounts without consent and a working unsubscribe: in July 2023 (28 Jun – 31 Aug: 59 reviews, mean 2.88; 9 on 5 July alone, mean 1.67) users who had not opened the app in one to two years, or had deleted their account, received daily 'habit' e-mails with no working unsubscribe — 37 marketing-email reviews (0.94%, mean 1.41), 27 in 2023 (12.7% of that year): 'They probably do this on purpose to inflate their active user stats'; 'daily spam messages that contain all my data … I'll report them to the ICO for breaching GDPR'; CAN-SPAM cited

- **Where:** §4.6(b) Unwanted marketing email 37 (0.94%), 1.41; 27 in 2023 (12.7% of that year); July 2023 wave (28 Jun – 31 Aug: 59 reviews, mean 2.88; 9 on 5 July, mean 1.67) — dormant or deleted accounts received daily 'habit' emails with no working unsubscribe ('They probably do this on purpose to inflate their active user stats'; 'daily spam messages that contain all my data … I'll report them to the ICO for breaching GDPR'; CAN-SPAM); response: unsubscribe added quickly ('they, quite quickly fixed it'; raised to 3★); residue Aug 2023 and May 2024 (a privacy professional: 'The Unsubscribe button … doesn't work … this is simply embarassing')
- **This app does:** daily e-mails to dormant/deleted users
- **User reaction:** 1★-burst
- **Magnitude:** 37 (0.94%), 1.41; Jul 2023 59 at 2.88; 9 on 5 Jul at 1.67
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10096299644`, `10101814356`, `10095812056`, `10084398148`, `10105286283`, `10106326416`
- **Canonical:** C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-149 — Privacy: 23 reviews (0.58%), mean 1.35, single-reviewer claims reported as claims — the in-app help 'messages' list showed conversations between support and other customers, including e-mails and photos (Nov 2023); goal-share URLs readable without login, with no way to turn sharing off; sync requiring an Apple ID, a Google account and an e-mail; a location permission; third-party analytics in the privacy policy; forced login since 2016

- **Where:** §4.6(c) Privacy 23 (0.58%), 1.35 — single-reviewer claims: the in-app help 'messages' list showed conversations between support and other customers, including emails and photos (Nov 2023); goal-share URLs readable without login with no way to turn sharing off; sync requiring an Apple ID, a Google account and an email; a location permission; third-party analytics in the privacy policy; forced login since 2016
- **This app does:** support-chat exposure; public share URLs
- **User reaction:** 1★-burst
- **Magnitude:** 23 (0.58%), 1.35; 17 1★
- **Direction for us:** must-never-break · **Report confidence:** emerging (single claims) · **Generalisable:** yes
- **Review IDs:** `10638299850`, `8440977492`, `9231182178`, `5348615613`, `6321445666`, `12284289977`, `1500907322`, `2913632619`, `3837963170`
- **Canonical:** C096 Privacy and discretion stack

### R33-150 — Guest mode must not be a data trap: 26 users who never created an account lost everything on update, reinstall or Mac sign-in (support merged the data for one; another was told to start again; 'Never use guest mode'; a ¥6,000 lifetime bought as a guest); the account/e-mail/privacy cluster is small in volume but carries the lowest ratings in the corpus and the only regulatory exposure — data-subject deletion, e-mail consent, confidentiality of support conversations — and is cheap to fix relative to its reputational cost

- **Where:** §4.6(d) Guest-account confusion 26 — users who never created an account lose everything on update, reinstall or Mac sign-in (support merged the data; told to start again; 'Never use guest mode'; a ¥6,000 lifetime bought as a guest); interpretation: small in volume but the lowest ratings in the corpus; the only cluster with regulatory exposure (data-subject deletion, email consent, confidentiality of support conversations); cheap to fix relative to its reputational cost
- **This app does:** guest data not migrated
- **User reaction:** churn
- **Magnitude:** 26 (0.66%), 2.92
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `4188962054`, `5259328224`, `6938277719`, `7261000773`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one

### R33-163 — After payment (within 427 payers): any reliability issue 182 (42.6%), mean 2.37; billing & entitlement integrity 114 (26.7%), 2.23 — Premium not granted / lost 66 (15.5%), 2.30; support failure 51 (11.9%), 2.02 (three refund requests unanswered); regression after paying 49 (11.5%), 2.24; refund requested 33 (7.7%), 2.09; sync failure 28 (6.6%), 2.89; explicit churn 27 (6.3%), 1.78 ('Lost a premium customer'); data lost 25 (5.9%), 2.40 (two years, twice); ads / upsell after paying 13 (3.0%), 2.54 ('I wish the upgrade button would disappear when you buy premium'); Premium not worth it 9 (2.1%), 1.78 — segment rates, against global entitlement failure 1.75% and support failure 3.33%; the 172 payers rating 1–2★ most often cite entitlement (42), unresponsive support (38), bugs (30), an update made it worse (24), refund (24), churn (22), billing dispute (18), data loss (16)

- **Where:** §6.5 What goes wrong after payment (verbatim table) — any reliability issue 182 (42.6%) 2.37; billing & entitlement integrity 114 (26.7%) 2.23; …Premium not granted / lost 66 (15.5%) 2.30; support failure 51 (11.9%) 2.02 (three refund requests unanswered); regression after paying 49 (11.5%) 2.24; refund requested 33 (7.7%) 2.09; sync failure 28 (6.6%) 2.89; explicit churn 27 (6.3%) 1.78 ('Lost a premium customer'); data lost 25 (5.9%) 2.40 (two years, twice); ads / upsell after paying 13 (3.0%) 2.54 ('I wish the upgrade button would disappear when you buy premium'); Premium not worth it 9 (2.1%) 1.78 — segment rates on 427; global entitlement 1.75%, support failure 3.33%; the 172 payers rating 1–2★ cite entitlement 42, unresponsive support 38, bugs 30, update made it worse 24, refund 24, churn 22, billing dispute 18, data loss 16
- **This app does:** payer failures
- **User reaction:** churn
- **Magnitude:** Problem | n (within 427 payers) | % of payers | Mean | Evidence ; Any reliability issue | 182 | 42.6% | 2.37 | Part 4.4 ; Billing & entitlement integrity | 114 | 26.7% | 2.23 | Part 4.3 ; …Premium not granted / lost | 66 | 15.5% | 2.30 | 2092713521, 6934749412, 13732504298 ; Support failure | 51 | 11.9% | 2.02 | 2105200122 (three refund requests unanswered), 7206302157, 14165773730 ; Regression after paying | 49 | 11.5% | 2.24 | 6373708406, 6682256233, 12711946464 ; Refund requested | 33 | 7.7% | 2.09 | 2093117380, 6414440114, 12154261985 ; Sync failure | 28 | 6.6% | 2.89 | 8605522610, 8947613685 ; Explicit churn | 27 | 6.3% | 1.78 | 6359290822 ("Lost a premium customer"), 6428238618 ; Data lost | 25 | 5.9% | 2.40 | 1497758838, 5887612478 (two years, twice) ; Ads / upsell after paying | 13 | 3.0% | 2.54 | 5556783335, 10620666635, 12606209462 ("I wish the upgrade button would disappear when you buy premium") ; Premium not worth it | 9 | 2.1% | 1.78 | 8330729266, 13449001668
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `2092713521`, `6934749412`, `13732504298`, `2105200122`, `7206302157`, `14165773730`, `6373708406`, `6682256233`, `12711946464`, `2093117380`, `6414440114`, `12154261985`, `8605522610`, `8947613685`, `6359290822`, `6428238618`, `1497758838`, `5887612478`, `5556783335`, `10620666635`, `12606209462`, `8330729266`, `13449001668`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C065 Paying customers are the highest 1★ risk — every paid feature must work; C248 Never show an upsell to anyone holding an active or historical entitlement

### R33-165 — Cancelling auto-renewal must leave the paid-for period intact: a reviewer charged annually after a 7-day trial found that cancelling the renewal ended their current access

- **Where:** §6.6 Cancelling a renewal must not end access already paid for — an annual charge after a 7-day trial, then cancelling the renewal ended current access
- **This app does:** cancel ends current access
- **User reaction:** 1★-burst
- **Magnitude:** 1 named
- **Direction for us:** must-never-break · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13550132289`
- **Canonical:** C112 In-app cancellation

### R33-198 — Make leaving easy: account deletion (mean 1.23) and e-mail opt-out (mean 1.41) are the worst-rated themes in the corpus and the cheapest to fix

- **Where:** Part 9 #6 — make leaving easy: account deletion (mean 1.23) and email opt-out (mean 1.41) are the worst-rated themes, and the cheapest to fix
- **This app does:** exit friction
- **User reaction:** 1★-burst
- **Magnitude:** 1.23; 1.41
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-201 — Make account deletion work in one step, in-app and on the web, and confirm it by e-mail: 47 reviews, mean 1.23; 23 in 2020 alone; still reported in 2025

- **Where:** Part 10 #1 §10.1 Immediate — trust, exit and privacy [4.6a, 3.2]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 47 (1.23)
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `12515577285`, `12715605250`
- **Canonical:** C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot

### R33-202 — Put an unsubscribe link in every e-mail and honour account deletion across marketing systems: 37 reviews, 27 in July 2023; GDPR and CAN-SPAM cited; failure still reported in May 2024

- **Where:** Part 10 #2 §10.1 [4.6b, 8.7]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 37 (1.41)
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `10101814356`, `10095812056`, `11244516686`
- **Canonical:** C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-203 — Audit the in-app help conversation list for cross-customer leakage — a single claim that other customers' messages, e-mails and photos were visible, but one that must be ruled out

- **Where:** Part 10 #3 §10.1 [4.6c]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 1 claim
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `10638299850`
- **Canonical:** C096 Privacy and discretion stack

### R33-204 — Make goal-sharing opt-in and use expiring or unguessable links

- **Where:** Part 10 #4 §10.1 [4.6c]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 1 claim
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `8440977492`
- **Canonical:** C096 Privacy and discretion stack

### R33-206 — One entitlement per person, recognised on every platform: web (Paddle) purchases must unlock iOS, iOS purchases must unlock Mac and web, and guest and account purchases merge automatically — about 25 portability cases including 6+ week resolutions

- **Where:** Part 10 #6 §10.2 Immediate — entitlement portability [4.3, 6.5]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** ~25
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13732504298`, `13516370858`, `6925930580`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-208 — Make trial conversion explicit: a reminder before the charge, and access kept after cancelling a renewal

- **Where:** Part 10 #8 §10.2 [6.6]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 31 trial (2.19)
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13422214812`, `13550132289`, `14019544061`
- **Canonical:** C109 A free trial must be a real trial; C112 In-app cancellation; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R33-214 — Health accuracy: de-duplicate sleep, allow manual override of Health-linked habits, and do not wipe data when switching tracking mode

- **Where:** Part 10 #14 §10.3 [8.9]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 29 Health poor
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `10712781996`, `13517256802`
- **Canonical:** C072 Writes to shared system stores (calendar, health) must be exact and reversible

## Features

### R33-022 — Frequency — daily, specific weekdays, 'N times a week' and later every-N-days — is free ('N times per week' removed Aug 2020, later restored); time-of-day sections (morning / afternoon / evening / anytime) with an adjustable day start are free; reminders, including repeats every 30 min until done, are free for one per habit with multiple reminders Premium

- **Where:** §2.1 Daily, specific-weekday, 'N times a week' and later every-N-days frequency — free; 'N times per week' removed Aug 2020 and later restored; time-of-day sections (morning / afternoon / evening / anytime) with adjustable day start — free; reminders including repeats every 30 min until done — 1 per habit free, multiple Premium
- **This app does:** flexible frequency; time-of-day sections; nagging reminders
- **User reaction:** praise
- **Magnitude:** inventory
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1460574941`, `1470303977`, `3295388458`, `5775951762`, `6305379316`, `6346899859`, `6458942355`, `1534629525`, `2113325079`, `3294233351`, `5932629140`, `1546230523`, `1821856292`, `4583533909`, `6009503696`
- **Canonical:** C014 Multiple reminders per habit; C039 Reminders fire reliably, once; C043 Flexible / custom frequency; C053 Custom time-of-day segments

### R33-023 — Streaks, completion rates, calendar and charts are free at a basic level, with history beyond 30 days gated in 2019; per-habit per-day notes / journal (from ~Oct 2018, natural-language dates) moved to Premium in Apr 2019; skip and fail states (skip removed 2017, returned, Premium in 2019); timer / stopwatch / Pomodoro (Oct 2019) free, its time-log data removed in Aug 2020 and the timer restored in 2021; goals with units and multiple check-ins per day (Aug 2020) free; areas / folders (Dec 2019) free; habit stacking broken for long periods

- **Where:** §2.1 Streaks, completion rates, calendar and charts — basic free, history beyond 30 days gated 2019; notes / journal per habit per day (from ~Oct 2018, natural-language dates) — moved to Premium Apr 2019; skip and fail states — skip removed 2017, returned, Premium 2019; timer / stopwatch / Pomodoro (Oct 2019) — free, time-log data removed Aug 2020, restored 2021; goals with units and multiple check-ins per day (Aug 2020) — free; areas / folders (Dec 2019) — free; habit stacking — broken for long periods
- **This app does:** stats, notes, skip, timer, areas
- **User reaction:** mixed
- **Magnitude:** inventory
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1471543599`, `2599530918`, `3440017816`, `5351195268`, `4207353472`, `3358156602`, `3527749082`, `5518407122`, `4002480223`, `4166681642`, `1477618808`, `5981035792`, `1592152210`, `4005130935`, `4883952820`, `6211239705`, `11200846854`, `12642188195`, `6372859679`, `7749321554`, `6353124209`, `6358235333`, `7713495259`, `5248212573`, `6137145408`, `12041896476`, `12086710828`, `8083522711`, `12195201168`
- **Canonical:** C011 Weekly / monthly / yearly reports; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C045 Grouping / folders / categories / tags; C048 Flexible units / partial progress; C066 Focus timer; C172 Per-day / per-habit notes and journal text; C173 Sub-tasks / sub-routines nested inside a habit or routine

### R33-024 — Apple Health auto-logging (≈2020–21) and Fitbit, Strava, screen-time and NFC habits (2024–26), described both as free and as Premium; mood log (Aug 2021, multiple moods per day Premium); challenges, friends and sharing (2022+, some gated); platforms iPhone, iPad (landscape), Apple Watch, Mac, a menu-bar mini app, web, Android and Windows — one purchase covers all except the 2018 Mac app, sold separately; widgets — Today widget (2016), home-screen widgets (iOS 14, 2020), redesigned May 2025 — free; CSV export removed with Habitify X, present again from 2022; integrations — x-callback/Shortcuts, Zapier/IFTTT, a public API, Apple/Google calendar sync (described as 'plus'); dark mode and themes Premium in 2019–20; a motivational-quote widget and notification copy often disliked; passcode lock removed in 2025; charity 'points' donated per completed habit (2016) removed in v2.0; AI 'smart fill' and AI/chatbot support (2025–26); a paid family plan (2025) whose sharing is described as not working

- **Where:** §2.1 Apple Health auto-logging (≈2020–21); Fitbit, Strava, screen-time and NFC habits (2024–26) — free vs Premium contradictory; mood log (Aug 2021) — multiple moods per day Premium; challenges, friends and sharing (2022+) — some gated; platforms iPhone, iPad (landscape), Apple Watch, Mac, menu-bar mini app, web, Android, Windows — one purchase covers all except the 2018 Mac app sold separately; widgets Today (2016), home-screen (iOS 14, 2020), redesigned May 2025 — free; CSV export removed with Habitify X, back from 2022; integrations x-callback/Shortcuts, Zapier/IFTTT, public API, Apple/Google calendar sync ('plus'); dark mode and themes Premium 2019–20; motivational-quote widget and notification copy often disliked; passcode lock removed 2025; charity points removed v2.0 Nov 2016; AI 'smart fill' and AI/chatbot support (2025–26); family plan (2025) paid, sharing described as not working
- **This app does:** broad platform and integration surface
- **User reaction:** mixed
- **Magnitude:** inventory
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `6496710391`, `7399087065`, `14242881753`, `13575307315`, `13291400972`, `13759922947`, `7480042765`, `7765702076`, `14401018465`, `7665159079`, `8151088180`, `10866310493`, `9696710729`, `8982833388`, `12135068738`, `13691298674`, `8695467024`, `3389713889`, `4003745901`, `5332861460`, `5952039329`, `13236248497`, `14040060412`, `3301240499`, `1456262900`, `6544400233`, `12711946464`, `2093238122`, `3294255105`, `9476514584`, `6461110648`, `6461863220`, `8267226236`, `3295311733`, `7118907544`, `9183367135`, `12023309995`, `13912801657`, `11142922352`, `12250165294`, `3301575141`, `4541759968`, `3729902277`, `5842936639`, `5874213446`, `1461242882`, `5865277155`, `12506599929`, `1465696397`, `1483150889`, `1494883584`, `13572613236`, `13659075450`, `14106494461`, `12840463016`, `13344142529`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C015 Shared / group habits; C017 Passcode lock; C020 Data export / backup / CSV; C021 Apple Health integration; C023 Interactive widget check-off; C037 Family plan; C044 Mac / desktop / web app; C046 Shortcuts / Siri / URL scheme / API; C049 Mood tracker; C056 Don't build AI features on demand grounds; C080 Colour themes / dark mode; C095 Neutral, non-judgemental tone on failure; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R33-025 — Not present per reviewers: one-off tasks; pause / vacation mode; monthly or custom-interval frequency (for most of the corpus); per-habit colours and themes; an interactive widget after iOS 14; iCloud-only sync without an account; a working service in mainland China; a monthly plan in some storefronts

- **Where:** §2.1 Not present, per reviewers — one-off tasks; pause / vacation mode; monthly or custom-interval frequency (for most of the corpus); per-habit colours and themes; an interactive widget after iOS 14; iCloud-only sync without an account; a working service in mainland China; a monthly plan in some storefronts
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** inventory note
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1461088305`, `5436679593`, `8397582957`, `3285402822`, `6854783487`, `1461800857`, `3601357542`, `5817575296`, `2050580709`, `6804994945`, `6544400233`, `8308869652`, `1934322613`, `4505011830`, `11626791974`, `5583352286`, `11335013815`, `12163064741`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C018 App-icon themes; C023 Interactive widget check-off; C030 Sync must work — and prove it; C043 Flexible / custom frequency; C050 One-off to-dos alongside habits; C132 Do not sell in a storefront where the app cannot function; C163 Visible monthly plan — annual-default trials drive billing disputes

### R33-037 — Unmet needs — all requests (union), mean 3.87 — requesters are mostly happy

- **Where:** §3.1 theme table #3 Unmet needs — all requests (union)
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 530 (13.46%, high-priority)
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-043 — Design / UI praised

- **Where:** §3.1 theme table #9 Design / UI praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 322 (8.17%, high-priority), mean 4.52
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C134 Lead the store listing with what users actually love

### R33-052 — Statistics praised

- **Where:** §3.1 theme table #18 Statistics praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 187 (4.75%, very strong), mean 4.79
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C011 Weekly / monthly / yearly reports

### R33-058 — Other feature requests

- **Where:** §3.1 theme table #24 Other feature requests
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 133 (3.38%, very strong), mean 4.02
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-061 — Motivating / streaks / accountability

- **Where:** §3.1 theme table #27 Motivating / streaks / accountability
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 130 (3.30%, very strong), mean 4.75
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C024 Streaks / gamification

### R33-064 — Cross-platform praised — zero 1★

- **Where:** §3.1 theme table #30 Cross-platform praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 112 (2.84%, meaningful), mean 4.70
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-072 — Reminders praised, falling from 4.5% of E1

- **Where:** §3.1 theme table #38 Reminders praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 91 (2.31%, meaningful), mean 4.78
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once

### R33-077 — Request: frequency / scheduling

- **Where:** §3.1 theme table #43 Request: frequency / scheduling
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 82 (2.08%, meaningful), mean 3.91; E1 4.1%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency

### R33-079 — Flexible scheduling praised

- **Where:** §3.1 theme table #45 Flexible scheduling praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 79 (2.01%, meaningful), mean 4.80
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency

### R33-080 — Timer mentioned

- **Where:** §3.1 theme table #46 Timer mentioned
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 71 (1.80%, meaningful), mean 3.80
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C066 Focus timer

### R33-084 — Request: better statistics

- **Where:** §3.1 theme table #50 Request: better statistics
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 58 (1.47%, meaningful), mean 4.03
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C011 Weekly / monthly / yearly reports

### R33-085 — Request: units / icons / custom fields

- **Where:** §3.1 theme table #51 Request: units / icons / custom fields
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 56 (1.42%, meaningful), mean 4.18
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C048 Flexible units / partial progress

### R33-087 — Request: multiple completions per day / quantities — 50 before the Aug 2020 fix

- **Where:** §3.1 theme table #53 Request: multiple completions per day / quantities
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 53 (1.35%, meaningful), mean 3.94; E1 2.9 → E5 0.1
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N

### R33-090 — Request: themes / colours / dark mode

- **Where:** §3.1 theme table #56 Request: themes / colours / dark mode
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 48 (1.22%, meaningful), mean 4.00
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C018 App-icon themes; C080 Colour themes / dark mode

### R33-092 — Request / problem: custom ordering (and ordering that sticks)

- **Where:** §3.1 theme table #58 Request / problem: custom ordering
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 47 (1.19%, meaningful), mean 3.40
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R33-093 — Integrations — Shortcuts, Zapier, API, calendar, NFC — rising to 2.5% of E5

- **Where:** §3.1 theme table #59 Integrations (Shortcuts, Zapier, API, calendar, NFC)
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 47 (1.19%, meaningful), mean 3.91
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R33-097 — Time-of-day sections

- **Where:** §3.1 theme table #63 Time-of-day sections
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 43 (1.09%, meaningful), mean 4.37
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C053 Custom time-of-day segments

### R33-101 — Notes / journal feature

- **Where:** §3.1 theme table #67 Notes / journal feature
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 38 (0.96%, emerging), mean 3.89
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R33-105 — Apple Watch praised

- **Where:** §3.1 theme table #71 Apple Watch praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 32 (0.81%, emerging), mean 4.62
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R33-108 — Areas / folders

- **Where:** §3.1 theme table #74 Areas / folders
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 31 (0.79%, emerging), mean 3.77
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C045 Grouping / folders / categories / tags

### R33-109 — Apple Health integration poor / wrong / gated, rising to 2.2% of E5

- **Where:** §3.1 theme table #75 Apple Health integration poor / wrong / gated
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 29 (0.74%, emerging), mean 3.10
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration; C072 Writes to shared system stores (calendar, health) must be exact and reversible

### R33-112 — Widget praised

- **Where:** §3.1 theme table #78 Widget praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 26 (0.66%, emerging), mean 4.73
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C023 Interactive widget check-off

### R33-113 — Request: widget

- **Where:** §3.1 theme table #79 Request: widget
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 24 (0.61%, emerging), mean 4.12
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C023 Interactive widget check-off

### R33-114 — Request: bad-habit / quit tracking

- **Where:** §3.1 theme table #80 Request: bad-habit / quit tracking
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 23 (0.58%, emerging), mean 3.35
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C019 Quit-habit / bad-habit mode

### R33-117 — Sounds / haptics praised — none after E2

- **Where:** §3.1 theme table #83 Sounds / haptics praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 22 (0.56%, emerging), mean 4.64
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C069 Check-off sound and haptic

### R33-118 — Request: notes / descriptions

- **Where:** §3.1 theme table #84 Request: notes / descriptions
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 22 (0.56%, emerging), mean 3.91
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R33-119 — Apple Health praised

- **Where:** §3.1 theme table #85 Apple Health praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 21 (0.53%, emerging), mean 4.57
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration

### R33-120 — Request: Health / wearable auto-completion

- **Where:** §3.1 theme table #86 Request: Health / wearable auto-completion
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 20 (0.51%, emerging), mean 4.00
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration

### R33-128 — A public API, Shortcuts, Zapier/IFTTT, calendar sync and NFC habits serve power users and are rising (47 mentions, 2.5% of E5): API 'unbeatable'; 'Pairs nicely with agentic workflows'; Shortcuts tiles

- **Where:** §3.4 Integrations for power users — API 'unbeatable'; 'Pairs nicely with agentic workflows'; Shortcuts tiles; Zapier / IFTTT; calendar sync; NFC habits — rising to 2.5% of E5
- **This app does:** API + automation
- **User reaction:** praise
- **Magnitude:** 47 (1.19%); E5 2.5%
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `7118907544`, `13575307315`, `13912801657`, `9183367135`, `12023309995`, `13759922947`
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R33-193 — Time-of-day sections plus flexible frequency is a winning core: 453 simplicity and 299 'best tracker' reviews rated 4–5★ describe it, and 'no other app does [time of day] as well'

- **Where:** Part 9 #1 — time-of-day sections plus flexible frequency is a winning core: 453 simplicity and 299 'best tracker' reviews rated 4–5★; 'no other app does [time of day] as well'
- **This app does:** time-of-day + N-per-week
- **User reaction:** praise
- **Magnitude:** 453; 299
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `1634301611`
- **Canonical:** C043 Flexible / custom frequency; C053 Custom time-of-day segments

### R33-221 — Statistics: an all-habit weekly grid, raw totals (not just %), and multi-year history — 58 requests

- **Where:** Part 10 #21 §10.6 Product opportunities [3.5]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 58
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13502513407`, `13574501337`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R33-222 — Bad-habit counters with limits — tap per occurrence, auto-fail over the limit

- **Where:** Part 10 #22 §10.6 [3.5]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 23
- **Direction for us:** research · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `9696710729`, `12689579726`
- **Canonical:** C019 Quit-habit / bad-habit mode

### R33-223 — Scheduling: monthly nth-weekday, end dates, a vacation or pause that preserves streaks, and one-tap reschedule

- **Where:** Part 10 #23 §10.6 [3.5]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 82 + 18
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `10990216385`, `12352483402`, `11292910105`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency

### R33-224 — Custom units, icons and per-habit colours: 56 + 48 reviews

- **Where:** Part 10 #24 §10.6 [3.5]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 56 + 48
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C018 App-icon themes; C048 Flexible units / partial progress

## Monetization

### R33-006 — The paywall is the biggest source of friction and has tightened three times: monetisation friction 521 (13.23%, high-priority), mean 2.52; the 3-habit cap 213 (5.41%), mean 2.31 — three habits are too few to judge the app; (1) 17 Jan 2019 one-time Premium replaced by a subscription — price objection rose to 9.4% of 2019 reviews (68); a buyer who paid £9.99 two days earlier found they had bought one year; 'The $10 lifetime option has vanished'; (2) Oct 2020 a weekly check-in limit for free users — 29 reviews, mean 2.00 — long-time free users locked out mid-streak ('After 500 days I was pay-walled'; 432 days; '15 log/week'); (3) 2026 cap complaints reach 9.3% of reviews, the highest since 2016, with several saying the free tier is now two habits ('Deleted as soon as the free tier dropped to 2')

- **Where:** Executive summary #2 — the paywall is the biggest source of friction, and it has tightened three times: monetisation friction 521 (13.23%, high-priority), mean 2.52; the 3-habit cap 213 (5.41%), mean 2.31 — three habits too few to judge the app; 17 Jan 2019 one-time Premium replaced by a subscription — price objection 9.4% of 2019 (68); a buyer who paid £9.99 two days earlier found they had bought one year; 'The $10 lifetime option has vanished'; Oct 2020 weekly check-in limit for free users — 29 reviews, mean 2.00; long-time free users locked out mid-streak ('After 500 days I was pay-walled'; 432 days; '15 log/week'); 2026 cap complaints 9.3% of reviews, the highest since 2016; free tier now two habits ('Deleted as soon as the free tier dropped to 2')
- **This app does:** cap 3 → 2; one-time → subscription; 15 check-ins/week
- **User reaction:** blocked-conversion
- **Magnitude:** friction 521 (13.23%), 2.52; cap 213 (5.41%), 2.31; price objection 9.4% of 2019; weekly cap 29 (2.00); cap 9.3% of 2026
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `3302452135`, `7834427180`, `9594953333`, `3619346514`, `3662823096`, `6541638912`, `6515490377`, `7108556777`, `10871729516`, `13684177637`, `13784118583`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C186 Never revoke what earlier buyers paid for when the model changes; C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R33-013 — Payers are split, not uniformly angry: 427 explicit payers (10.84%), mean 3.16 — 212 rate 4–5★, 172 rate 1–2★; they bought for the lifetime / one-time option (112 payers mention it, mean 3.62), design and simplicity, cross-platform sync and supporting a small team; after paying, what goes wrong is entitlement failure (66 payers, 15.5%), reliability (182, 42.6%), support failure (51, 11.9%) and regressions (49, 11.5%)

- **Where:** Executive summary #9 — payers are split, not uniformly angry: 427 explicit payers (10.84%), mean 3.16 — 212 rate 4–5★, 172 rate 1–2★; bought for the lifetime / one-time option (112 payers mention it, mean 3.62), design and simplicity, cross-platform sync, supporting a small team; after paying: entitlement failure 66 (15.5%), reliability 182 (42.6%), support failure 51 (11.9%), regressions 49 (11.5%)
- **This app does:** polarised payers
- **User reaction:** mixed
- **Magnitude:** 427 (10.84%), 3.16; 212 vs 172; lifetime 112 (3.62)
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `1504622058`, `3293870240`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C061 Goodwill conversion — a generous free tier and 'support the devs'; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R33-029 — The free gate tightened in steps: (1) habit count 3, reported as 2 early on, in 2020–21 and again from Feb 2025 – 2026; (2) in 2019 notes, skip, multiple reminders, dark mode and history beyond 30 days moved into Premium; (3) from Oct 2020 check-ins capped at 15 per week; (4) by 2025–26 Health sleep sync, checklists and some challenges gated

- **Where:** §2.3 The gate tightened in steps — 1. habit count 3 (reported as 2 early on, in 2020–21 and again Feb 2025 – 2026); 2. features moved into Premium in 2019: notes, skip, multiple reminders, dark mode and history beyond 30 days; 3. check-ins 15 per week from Oct 2020; 4. Health sleep sync, checklists and some challenges by 2025–26
- **This app does:** stepwise gate tightening
- **User reaction:** complaint
- **Magnitude:** 4 steps
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `1974587723`, `6703021557`, `7620785588`, `12267448585`, `13684177637`, `13784118583`, `14401018465`, `13977555592`, `8695467024`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R33-030 — Price ladder per reviewers: 2016–2018 one-time $3–4 / €4 / 25 RMB → $5–6 / €6 → $9.99 / £9.99 / €11 / ¥1,200 / 749 RUB (Sep 2018 rise to 45 RMB); 17 Jan – Apr 2019 subscription only — $9.99/mo quoted, A$40/yr, €30/yr, £24/yr, $39.99/yr, 269 RUB; Apr 2019 – 2020 monthly / annual / lifetime — ¥500 / ¥3,300 / ¥4,800; ₩7,500 / – / ₩49,000–59,000; ~€7 / €27 / €44; $7.99/mo and ~$40–50 lifetime; CA$7.99 / CA$29.99 / CA$54.99; A$62; 188 RMB; 2020–2021 $5/mo, $25/yr, $50–90 lifetime, ₩79,000, ¥6,000–6,100, 328–400 RMB, £26.99/yr sale, 260 TL, R80/mo; 2021–2024 $99 lifetime quoted, $40 lifetime = 598 RMB, $55/yr, a 50% first-day offer, £1.67/mo-equivalent or £39.99 lifetime, €50 lifetime; 2025–2026 $9/mo, $35/yr, $39.99/yr, €25/yr, $28/yr, ¥19,000 lifetime

- **Where:** §2.3 Price ladder (verbatim table) — 2016–2018 one-time $3–4, €4, 25 RMB → $5–6, €6 → $9.99 / £9.99, €11, ¥1,200, 749 RUB, Sep 2018 45 RMB; 17 Jan – Apr 2019 subscription only $9.99/mo (quoted), A$40/yr, €30/yr, £24/yr, $39.99/yr, 269 RUB; Apr 2019 – 2020 monthly / annual / lifetime ¥500 / ¥3,300 / ¥4,800, ₩7,500 / ₩49,000–59,000, ~€7 / €27 / €44, $7.99/mo, ~$40–50 lifetime, CA$7.99 / CA$29.99 / CA$54.99, A$62, 188 RMB; 2020–2021 $5/mo, $25/yr, $50–90 lifetime, ₩79,000, ¥6,000–6,100, 328–400 RMB, £26.99/yr sale, 260 TL, R80/mo; 2021–2024 $99 lifetime, $40 lifetime = 598 RMB, $55/yr, 50% first-day offer, £39.99 lifetime, €50 lifetime; 2025–2026 $9/mo, $35/yr, $39.99/yr, €25/yr, $28/yr, ¥19,000 lifetime
- **This app does:** one-time → subscription + lifetime
- **User reaction:** mixed
- **Magnitude:** Period | What an upgrade cost, per reviewers | Representative IDs ; 2016–2018 | One-time: $3–4, €4, 25 RMB → $5–6, €6 → $9.99 / £9.99, €11, ¥1,200, 749 RUB; Sep 2018 rise to 45 RMB | 1460574941, 1512838955, 1468380047, 2917668175, 3200640926, 3434571250, 3528421989, 3143812831 ; 17 Jan – Apr 2019 | Subscription only: $9.99/mo (quoted), A$40/yr, €30/yr, £24/yr, $39.99/yr, 269 RUB | 3644199616, 3795256803, 3873901587, 3887636788, 3959201696, 3936231580 ; Apr 2019 – 2020 | Monthly / annual / lifetime: ¥500 / ¥3,300 / ¥4,800; ₩7,500 / – / ₩49,000–59,000; ~€7 / €27 / €44; $7.99/mo, ~$40–50 lifetime; CA$7.99 / CA$29.99 / CA$54.99; A$62; 188 RMB | 4151962952, 4611712882, 5348866355, 5336471509, 4328070287, 5125718200, 6186108971, 5856846519, 5602217006 ; 2020–2021 | $5/mo; $25/yr; $50–90 lifetime; ₩79,000; ¥6,000–6,100; 328–400 RMB; £26.99/yr sale; 260 TL; R80/mo | 6566048336, 7169126431, 6715379070, 6804994945, 7276053699, 7112692402, 7036681918, 7498411514, 7711901965 ; 2021–2024 | $99 lifetime (quoted); $40 lifetime = 598 RMB; $55/yr; 50% first-day offer; £1.67/mo-equivalent or £39.99 lifetime; €50 lifetime | 7957634662, 11773675345, 10793301666, 10832124422, 11614599585, 11654766103 ; 2025–2026 | $9/mo, $35/yr; $39.99/yr; €25/yr; $28/yr; ¥19,000 lifetime | 12565185507, 13583645105, 13977135417, 14008672142, 14106494461, 14398774902
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `1460574941`, `1512838955`, `1468380047`, `2917668175`, `3200640926`, `3434571250`, `3528421989`, `3143812831`, `3644199616`, `3795256803`, `3873901587`, `3887636788`, `3959201696`, `3936231580`, `4151962952`, `4611712882`, `5348866355`, `5336471509`, `4328070287`, `5125718200`, `6186108971`, `5856846519`, `5602217006`, `6566048336`, `7169126431`, `6715379070`, `6804994945`, `7276053699`, `7112692402`, `7036681918`, `7498411514`, `7711901965`, `7957634662`, `11773675345`, `10793301666`, `10832124422`, `11614599585`, `11654766103`, `12565185507`, `13583645105`, `13977135417`, `14008672142`, `14106494461`, `14398774902`
- **Canonical:** C001 Never move a free feature behind the paywall; C092 Regional pricing

### R33-038 — Monetisation friction (union)

- **Where:** §3.1 theme table #4 Monetisation friction (union)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 521 (13.23%, high-priority), mean 2.52; E2 17.3%
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall

### R33-040 — Explicit payer, first person

- **Where:** §3.1 theme table #6 Explicit payer (first person)
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 427 (10.84%, high-priority), mean 3.16; 5★ 159, 1★ 130
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R33-048 — Free-tier habit cap

- **Where:** §3.1 theme table #14 Free-tier habit cap
- **This app does:** see §3.1
- **User reaction:** blocked-conversion
- **Magnitude:** 213 (5.41%, high-priority), mean 2.31; 1★ 87
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R33-050 — Price objection, peaking in E2 (8.4%)

- **Where:** §3.1 theme table #16 Price objection
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 203 (5.15%, high-priority), mean 2.64
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R33-069 — Price fair / worth it — zero 1★

- **Where:** §3.1 theme table #35 Price fair / worth it
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 99 (2.51%, meaningful), mean 4.85
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R33-074 — General paywall

- **Where:** §3.1 theme table #40 General paywall
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 89 (2.26%, meaningful), mean 2.36
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C147 Let people use the product before they pay

### R33-089 — One-time / lifetime / no-subscription praised

- **Where:** §3.1 theme table #55 One-time / lifetime / no-subscription praised
- **This app does:** see §3.1
- **User reaction:** purchase-driver
- **Magnitude:** 51 (1.29%, meaningful), mean 4.63
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R33-091 — Free tier sufficient

- **Where:** §3.1 theme table #57 Free tier sufficient
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 48 (1.22%, meaningful), mean 4.85
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R33-096 — Purchase intent — 'would buy if…'

- **Where:** §3.1 theme table #62 Purchase intent ("would buy if…")
- **This app does:** see §3.1
- **User reaction:** blocked-conversion
- **Magnitude:** 44 (1.12%, meaningful), mean 4.25
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C147 Let people use the product before they pay

### R33-100 — Objection to the subscription model — the 2019 switch (E2 2.6%)

- **Where:** §3.1 theme table #66 Objection to the subscription model
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 39 (0.99%, emerging), mean 1.95
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase

### R33-106 — Trial — wanted / too short / auto-converted

- **Where:** §3.1 theme table #72 Trial (wanted / too short / auto-converted)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 31 (0.79%, emerging), mean 2.19
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

### R33-110 — Weekly check-in cap (free) — E3 4.2%

- **Where:** §3.1 theme table #76 Weekly check-in cap (free)
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 29 (0.74%, emerging), mean 2.00
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R33-136 — The paywall tightened in steps (friction 521, 13.23%, mean 2.52; free-tier union of cap, check-in cap and general paywall 304, 7.72%, mean 2.32, 131 1★): (a) the habit cap, always 3 and sometimes 2 — 213 (5.41%) ('at that point just sell it for 3.99'; 'you finally mention that habits are limited … after they've created it'); (b) subscription replaces one-time on 17 Jan 2019 — subscription objection 39 (29 in 2019), price objection 9.4% of 2019 ('from an $8 one-time payment to $40 a year'; a recent buyer converted to one year); (c) features move into Premium in Apr 2019 — notes with 300 days of history, skip, multiple reminders, dark mode, history beyond 30 days (part of paywall 89 + removed 82); (d) a weekly check-in cap of ~15 for free users, Oct 2020 → 2024 — 29 reviews (14 in 2020, 8 in 2021, 6 in 2024), mean 2.00, long streaks locked (2 years of data; 432 days; 500 days; 'three habits is reasonable. The problem … I can't check into those habits more than 15 times a week'); (e) upsell surfaces 2023 → 2026 — a full-screen offer on every open, a banner covering the third habit, a banner that cannot be closed ('I have adhd … huge banner … you CAN NOT CLOSE'), notices after paying (a premium user: 'No. deal with it') — upsell 22 (1.7% of E5) + ads to payers 14; (f) free tier cut to two habits Feb 2025 → 2026 — 'free is just a demo', cap 9.3% of 2026, 20 reviews since Dec 2025 ('slowly chipping away at the most basic features'); (g) no trial for most of the corpus, then auto-converting trials in 2025–26 — trial 31, mean 2.19

- **Where:** §4.2 Cluster 2 — the paywall tightened in steps (verbatim table): friction 521 (13.23%), 2.52; free-tier union (cap, check-in cap, general paywall) 304 (7.72%), 2.32, 131 1★; (a) habit cap always 3 (sometimes 2) 213 ('at that point just sell it for 3.99'; 'you finally mention that habits are limited … after they've created it'); (b) subscription replaces one-time 17 Jan 2019 — subscription objection 39 (29 in 2019), price objection 9.4% of 2019 ('from an $8 one-time payment to $40 a year'); (c) features move into Premium Apr 2019 — notes with 300 days of history, skip, multiple reminders, dark mode, history beyond 30 days; (d) weekly check-in cap Oct 2020 → 2024 ~15 a week — 29 (14 in 2020, 8 in 2021, 6 in 2024), mean 2.00 ('three habits is reasonable. The problem … I can't check into those habits more than 15 times a week'); (e) upsell surfaces 2023 → 2026 — full-screen offer on every open, a banner covering the third habit, a banner that cannot be closed ('I have adhd … huge banner … you CAN NOT CLOSE'), notices after paying ('No. deal with it') — upsell 22 (1.7% of E5) + ads to payers 14; (f) free tier cut Feb 2025 → 2026 — two habits, 'free is just a demo', cap 9.3% of 2026 (20 since Dec 2025; 'slowly chipping away at the most basic features'); (g) no trial, then auto-converting trials — 31, mean 2.19
- **This app does:** stepwise take-backs
- **User reaction:** 1★-burst
- **Magnitude:** Step | When | What reviewers report | n | Evidence ; (a) The habit cap | Always | 3 habits (sometimes 2) on the free tier | 213 (5.41%) | 1461098314 ("at that point just sell it for 3.99"), 3463341082 ("you finally mention that habits are limited … after they've created it"), 5615780125, 12730282337 ; (b) Subscription replaces one-time | 17 Jan 2019 | "The $10 lifetime option has vanished"; a recent buyer is converted to one year; "my habits don't need a rack of servers" | subscription objection 39 (29 in 2019); price objection 9.4% of 2019 | 3619346514, 3662823096, 3661739808, 3674478475, 3879350608 ("from an $8 one-time payment to $40 a year") ; (c) Features move into Premium | Apr 2019 | Notes (with 300 days of history), skip, multiple reminders, dark mode, history beyond 30 days | part of paywall 89 + removed 82 | 4002480223, 4005130935, 4010084040, 4207353472, 5842936639 ; (d) Weekly check-in cap | Oct 2020 → 2024 | Free users can tick only ~15 check-ins a week; long streaks locked | 29 (0.74%); 14 in 2020, 8 in 2021, 6 in 2024; mean 2.00 | 6495113718 (2 years of data), 6515490377 (432 days), 6541638912 (500 days), 7038821896, 7108556777, 11354879589 ("three habits is reasonable. The problem … I can't check into those habits more than 15 times a week") ; (e) Upsell surfaces | 2023 → 2026 | Full-screen offer on every open; a banner covering the third habit; a banner that cannot be closed; notices after paying | upsell 22 (1.7% of E5) + ads to payers 14 | 12730282337, 13022842033 ("I have adhd … huge banner … you CAN NOT CLOSE"), 13061919171, 13610321423, 13688287990, 10620666635 (premium user: "No. deal with it") ; (f) Free tier cut | Feb 2025 → 2026 | Two habits; "free is just a demo" | cap is 9.3% of 2026 (20 reviews since Dec 2025) | 12267448585, 13684177637, 13784118583, 14057584186 ("slowly chipping away at the most basic features") ; (g) No trial, then auto-converting trials | throughout; 2025–26 | "no chance to try"; a trial silently converts to an annual charge | trial 31 (mean 2.19) | 7032422476, 11363702706, 13422214812, 13550132289, 14019544061
- **Direction for us:** product-rule · **Report confidence:** high-priority as a union · **Generalisable:** yes
- **Review IDs:** `1461098314`, `3463341082`, `5615780125`, `12730282337`, `3619346514`, `3662823096`, `3661739808`, `3674478475`, `3879350608`, `4002480223`, `4005130935`, `4010084040`, `4207353472`, `5842936639`, `6495113718`, `6515490377`, `6541638912`, `7038821896`, `7108556777`, `11354879589`, `13022842033`, `13061919171`, `13610321423`, `13688287990`, `10620666635`, `12267448585`, `13684177637`, `13784118583`, `14057584186`, `7032422476`, `11363702706`, `13422214812`, `13550132289`, `14019544061`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C063 Free trial before purchase; C109 A free trial must be a real trial; C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C200 Never meter the completion action — a free cap may limit habits, never check-offs; C248 Never show an upsell to anyone holding an active or historical entitlement

### R33-161 — Purchase triggers: a lifetime / one-time price instead of rent ('Habitify allows you to unlock all premium features with a 1 time in-app purchase of $10'; 'not willing to go the subscription way'; 'you'll pay double in a year for some other similar apps'); design and simplicity (bought within the week; bought lifetime 'attracted by the clean design'); statistics ('The statistics … is what sold me'; 'because it shows stats … I bought premium'); cross-platform access ('since I get Mac OS, iPad, and Apple Watch apps all for one subscription … I'm fine with it'; 'signed up for premium mainly because this has a web interface'); more than three habits; supporting a small team ('I can see this team cares'); specific paid features — multiple reminders, timer analytics, mood, ADHD support ('With the premium subscription, I can add multiple reminders'); sales, first-day discounts and contests (50% on day one; lifetime on sale 'on a whim … well worth the money'; lifetime won in a Twitter contest); and the one fully described funnel — an ad-acquired user who took a free month, then monthly, then annual

- **Where:** §6.3 What made people buy (verbatim table) — a lifetime / one-time price instead of rent ('Habitify allows you to unlock all premium features with a 1 time in-app purchase of $10'; 'not willing to go the subscription way'; 'you'll pay double in a year for some other similar apps'); design and simplicity (bought within the week; bought lifetime 'attracted by the clean design'); statistics ('The statistics … is what sold me'); cross-platform access ('since I get Mac OS, iPad, and Apple Watch apps all for one subscription … I'm fine with it'; 'signed up for premium mainly because this has a web interface'); more than three habits; supporting a small team ('I can see this team cares'); specific paid features — multiple reminders, timer analytics, mood, ADHD support; sales, first-day discounts, contests (50% on day one; lifetime on sale 'on a whim … well worth the money'; won lifetime in a Twitter contest); a free month, then monthly, then annual (ad-acquired) — the one fully described funnel
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Trigger | Evidence ; A lifetime / one-time price instead of rent | 2917668175 ("the price was subscription based … Habitify allows you to unlock all premium features with a 1 time in-app purchase of $10"), 3440017816, 3613334476 ("not willing to go the subscription way"), 5194210441 ("you'll pay double in a year for some other similar apps"), 7191544761, 13449836057 ; Design and simplicity | 1470008848 (bought within the week, "really worth it"), 1789612595 ("willingly bought membership"), 5518407122 (bought lifetime "attracted by the clean design"), 6358235333 ; Statistics | 3158042031 ("The statistics … is what sold me"), 5770923833 ("because it shows stats … I bought premium") ; Cross-platform access (Mac, web, Watch) | 3678466422 ("since I get Mac OS, iPad, and Apple Watch apps all for one subscription … I'm fine with it"), 5193130183, 6328737124 ("signed up for premium mainly because this has a web interface"), 6341023589 ; More than three habits | 2008162858, 4509262890, 9491502032 ; Supporting a small team | 1498848084, 1504622058, 1546230523, 3293870240 ("I can see this team cares") ; Specific paid features: multiple reminders, timer analytics, mood, ADHD support | 6309480498, 10038284177 ("With the premium subscription, I can add multiple reminders"), 9696710729 ; Sales, first-day discounts, contests | 10832124422 (50% on day one), 12881867268 (lifetime on sale "on a whim … well worth the money"), 4259261483 (won lifetime in a Twitter contest) ; A free month, then monthly, then annual (ad-acquired) | 6277375380 — the one fully described funnel in the corpus
- **Direction for us:** build-paid · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `2917668175`, `3440017816`, `3613334476`, `5194210441`, `7191544761`, `13449836057`, `1470008848`, `1789612595`, `5518407122`, `6358235333`, `3158042031`, `5770923833`, `3678466422`, `5193130183`, `6328737124`, `6341023589`, `2008162858`, `4509262890`, `9491502032`, `1498848084`, `1504622058`, `1546230523`, `3293870240`, `6309480498`, `10038284177`, `9696710729`, `10832124422`, `12881867268`, `4259261483`, `6277375380`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C006 Stay minimal — every addition is opt-in or off by default; C011 Weekly / monthly / yearly reports; C013 Cloud sync / multi-device as the paid differentiator; C014 Multiple reminders per habit; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R33-164 — Trial reaction is negative both ways: 31 reviews (0.79%), mean 2.19, 15 1★ — for most of the corpus there was no trial ('Three habits, and three days, is simply too little'; 'No free trial'; 'I wasn't given the option for a premium trial period'), and when trials appeared in 2025–26 they converted to an annual charge unexpectedly ('I signed up for a free trial and somehow got converted to paid'; an annual charge after a 7-day trial, where cancelling the renewal ended current access; 'it said a 7- or 14-day trial, then charged a full year of Pro')

- **Where:** §6.6 Trial reaction is negative both ways — 31 (0.79%), 2.19, 15 1★; for most of the corpus there was no trial ('Three habits, and three days, is simply too little'; 'No free trial'; 'I wasn't given the option for a premium trial period'); when trials appeared (2025–26) they converted to an annual charge unexpectedly ('I signed up for a free trial and somehow got converted to paid'; an annual charge after a 7-day trial, then cancelling the renewal ended current access; 'a 7- or 14-day trial, then charged a full year of Pro')
- **This app does:** no trial → auto-converting annual trial
- **User reaction:** complaint
- **Magnitude:** 31 (0.79%), 2.19; 15 1★
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `7032422476`, `8165243761`, `10866310493`, `13422214812`, `13550132289`, `14019544061`
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

### R33-218 — Test the free tier: 3 habits + unlimited check-ins vs 5 habits vs a 14-day full trial, measuring conversion and 1★ rate — the evaluation argument is the plurality and the check-in cap has the worst rating of any monetisation mechanism (2.00)

- **Where:** Part 10 #18 §10.5 Monetisation experiments (after 10.1–10.2) [3.3, 4.2]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** cap 213 (2.31); check-in 29 (2.00)
- **Direction for us:** research · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C063 Free trial before purchase; C147 Let people use the product before they pay; C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R33-219 — Offer monthly in-app in every storefront, and regionalise lifetime pricing (¥19,000; Vietnam and Turkey requests)

- **Where:** Part 10 #19 §10.5 [2.3, 7.7]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 8 monthly; regional requests
- **Direction for us:** research · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `5583352286`, `12163064741`, `14106494461`
- **Canonical:** C092 Regional pricing; C163 Visible monthly plan — annual-default trials drive billing disputes

### R33-220 — Keep the lifetime option and publish what lifetime includes — it is the top purchase trigger

- **Where:** Part 10 #20 §10.5 [6.3, 6.7]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 112 payers
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

## Tactics the app used

### R33-004 — Outcome of soliciting reviews through the founder, e-mail and a free-lifetime reward: between 12 Oct and 1 Nov 2018, 110 reviews arrived at mean 4.64 (81.8% 5★) against 3.30 in the six weeks before — 32 on 12 Oct alone (mean 4.81) — alongside reviews naming the founder ('Is that okay Peter?'; 'developed by Peter and his team'), 'a strange email … asking for a rating', a free-lifetime link sent after reviewing, and a CEO asking for a 5★ review; the burst lifted 2018's 5★ share but left no durable effect — 2018-12 fell to mean 3.28 with the China wave — and the report's final cheapest win is to stop soliciting reviews in ways that look incentivised

- **Where:** Seven warnings #3 — some high ratings were probably prompted: 12 Oct → 1 Nov 2018, 110 reviews at mean 4.64 (81.8% 5★) vs 3.30 in the six weeks before; 32 on 12 Oct alone (mean 4.81); reviews naming the founder ('Is that okay Peter?'; 'developed by Peter and his team'); 'a strange email … asking for a rating'; a free-lifetime link sent after reviewing; a CEO asking for a 5★ review; the 5★ share of 2018 should be read with this in mind
- **This app does:** founder/e-mail review solicitation, free lifetime after review
- **User reaction:** praise
- **Magnitude:** 110 at 4.64 (81.8% 5★) vs 3.30 before; 32 on 12 Oct (4.81)
- **Direction for us:** dont · **Report confidence:** probable (burst pattern + named solicitation) · **Generalisable:** yes
- **Review IDs:** `3356614111`, `3393688311`, `3367548037`, `3897029485`, `5817575296`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R33-135 — Outcome of an App Store 'Today' feature in a storefront the backend cannot serve: from 13 Dec 2018 to 10 Jan 2019 it produced 68 China reviews at mean 2.34 ('can't register — and you recommended it on the home page?') — December 2018 was the second-busiest month (111 reviews, mean 3.28) and 30 Dec 2018 had 12 of its 15 reviews from China; verify reachability before accepting or seeking featuring in a market

- **Where:** §4.1 Being featured in a market you cannot serve converts the feature into 1★ — Dec 2018 App Store 'Today' feature sent Chinese users who could not register: 68 China reviews in four weeks, mean 2.34; busiest day 30 Dec 2018, 12 of 15 from China
- **This app does:** featured while unreachable
- **User reaction:** 1★-burst
- **Magnitude:** 68 at 2.34; Dec 2018 111 at 3.28
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `3528438035`, `3541075226`
- **Canonical:** C132 Do not sell in a storefront where the app cannot function

### R33-141 — Outcome of a fast developer fix to a purchase wave: the Jan 2018 wave (21 reviews, 11 from Japan) was fixed by ~27 Jan, reviewers thanked the developer 'for responding right after my review', and entitlement failure fell from 3.6% of E1 to 0.9–1.9% thereafter — integrity never became a sustained wave; the durable residue is portability across the platforms the product sells on (a web purchase that does not unlock the iPhone; a lifetime tied to one e-mail), which turns the cross-platform promise into a support case

- **Where:** §4.3 Interpretation — integrity problems are not a sustained wave; the largest event (Jan 2018) was fixed within about two weeks; the durable defect is entitlement portability across the platforms that are Habitify's selling point — a web purchase that does not unlock the iPhone, or a lifetime tied to one e-mail, turns the cross-platform promise into a support case
- **This app does:** two-week fix of purchase wave
- **User reaction:** praise
- **Magnitude:** 21 fixed in ~2 weeks; 3.6% → 0.9–1.9%
- **Direction for us:** must-never-break · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `2132082291`, `2096151645`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C059 Be visibly responsive; fixes bring reviewers back

### R33-148 — Outcome of a dated developer response to an e-mail complaint wave: an unsubscribe link was added quickly after the July 2023 complaints ('they, quite quickly fixed it'; one reviewer raised the rating to 3★), and marketing-email complaints fell from 6.5% of E4 to 0.1% of E5 — but the fix was incomplete (Aug 2023; in May 2024 a privacy professional: 'The Unsubscribe button … doesn't work … this is simply embarassing')

- **Where:** §4.6(b) Response — unsubscribe was added quickly after the July 2023 complaints ('they, quite quickly fixed it'; one review raised to 3★); residue: Aug 2023 and May 2024 a privacy professional: 'The Unsubscribe button … doesn't work … this is simply embarassing'
- **This app does:** unsubscribe added after the wave
- **User reaction:** mixed
- **Magnitude:** 6.5% of E4 → 0.1% of E5
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10109604865`, `10125754353`, `10206423262`, `10297034393`, `11244516686`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-192 — Outcome of aggressive in-app rating prompts: Nov 2017 – Jan 2018 reviewers complained of prompts 'three in 10 seconds'; review-nag complaints were 3.8% of 2017 reviews and fell to ≤1% of every later year once prompting calmed — 35 review-prompt complaints overall (0.89%, mean 2.60)

- **Where:** §2.2 / §8.11 Review-prompt nagging Nov 2017 – Jan 2018 ('three in 10 seconds') — review-nag complaints 3.8% of 2017, ≤1% of every later year after the prompt was fixed
- **This app does:** rating prompt burst 2017–18
- **User reaction:** complaint
- **Magnitude:** 3.8% of 2017 → ≤1%; 35 (2.60)
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1973100159`, `2049009103`, `2049455058`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R33-227 — Experiments: (32) free-tier design — cap 3 vs 5, check-in cap vs none, trial vs none — measuring conversion, D30 retention and 1★ rate; (33) simple vs full default UI for new users; (34) interactive-widget variant vs current; (35) notification tone, neutral vs current, among users who self-identify as neurodivergent or opt in

- **Where:** Part 10 #32, Part 10 #33, Part 10 #34, Part 10 #35 — §10.8 Experiments worth running — free-tier design: cap 3 vs 5, check-in cap vs none, trial vs none, measuring conversion, D30 retention and 1★ rate [10.5]; simple vs full default UI for new users [10.4]; interactive-widget variant vs current [10.3]; notification tone neutral vs current among users who self-identify as neurodivergent or opt in [10.4]
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 4 experiments
- **Direction for us:** research · **Report confidence:** experiment proposals · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C007 Generous fixed habit cap (or unlimited) — never change it; C023 Interactive widget check-off; C095 Neutral, non-judgemental tone on failure

## Insights (the why)

### R33-005 — The product concept wins — the majority story: 51.9% of reviews are 5★ (2,044 of 3,939), mean 3.74; core praise appears in 1,477 reviews (37.50%, high-priority), mean 4.77 — simplicity 461 (11.70%; 453 rated 4–5★), design 322 (8.17%), 'best habit tracker I've tried' 303 (7.69%, rising from 2.9% of 2016 reviews to 10.4–10.5% of 2023–24), concrete life outcomes 205 (5.20%), statistics 187 (4.75%); the named differentiators are time-of-day sections (morning / afternoon / evening), 'N times a week' and every-N-days frequency, one account across iPhone, iPad, Watch, Mac, web, Android and Windows, and a lifetime price when rivals only rent

- **Where:** Executive summary #1 — the product concept wins; that is the corpus's majority story: 51.9% of reviews 5★ (2,044 of 3,939), mean 3.74; core praise 1,477 (37.50%, high-priority), mean 4.77 — simplicity 461 (11.70%; 453 rated 4–5★), design 322 (8.17%), 'best habit tracker I've tried' 303 (7.69%, rising 2.9% of 2016 → 10.4–10.5% of 2023–24), life outcomes 205 (5.20%), statistics 187 (4.75%); named differentiators: time-of-day sections (morning / afternoon / evening); 'N times a week' and every-N-days frequency; one account across iPhone, iPad, Watch, Mac, web, Android and Windows; a lifetime price when rivals only rent
- **This app does:** time-of-day sections; flexible frequency; cross-platform account; lifetime option
- **User reaction:** praise
- **Magnitude:** 5★ 51.9%; core praise 1,477 (37.50%), 4.77; simplicity 461; design 322; best-tried 303; outcomes 205; stats 187
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `2113325079`, `3294233351`, `3491889583`, `10942733003`, `1460574941`, `1470303977`, `5775951762`, `3389713889`, `7785151407`, `14040060412`, `3440017816`, `7191544761`, `13449836057`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C006 Stay minimal — every addition is opt-in or off by default; C013 Cloud sync / multi-device as the paid differentiator; C043 Flexible / custom frequency; C053 Custom time-of-day segments

### R33-012 — Support is two-sided: support praised 103 (2.61%), mean 4.73, versus support failure (unresponsive or deletion) 131 (3.33%), mean 1.70; the better experiences come with quick fixes ('within one minute'); the worst involve payers — 5 weeks without a reply and then the review deleted; AI-only replies

- **Where:** Executive summary #8 — support is two-sided: praised 103 (2.61%), mean 4.73; support failure (unresponsive or deletion) 131 (3.33%), mean 1.70; better experiences come with quick fixes ('within one minute'); the worst involve payers — 5 weeks without a reply, then the review deleted; AI-only replies
- **This app does:** fast human support vs AI replies
- **User reaction:** mixed
- **Magnitude:** praised 103 (4.73) vs failure 131 (1.70)
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `2096151645`, `6373930592`, `14040060412`, `7206302157`, `13659075450`, `14106494461`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R33-035 — Core praise (union)

- **Where:** §3.1 theme table #1 Core praise (union)
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 1,477 (37.50%, high-priority), mean 4.77; 5★ 1,240; E1 42.0 → E3 25.8 → E5 32.6
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R33-039 — Simple / easy / intuitive — 392 of 461 are 5★, 1 is 1★

- **Where:** §3.1 theme table #5 Simple / easy / intuitive
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 461 (11.70%, high-priority), mean 4.82; E1 15.9 → E5 7.3
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C134 Lead the store listing with what users actually love

### R33-044 — Helps build / track habits — zero 1★

- **Where:** §3.1 theme table #10 Helps build / track habits
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 321 (8.15%, high-priority), mean 4.90
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-049 — Concrete life outcome

- **Where:** §3.1 theme table #15 Concrete life outcome
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 205 (5.20%, high-priority), mean 4.88
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C067 Fitness / health tracking use case

### R33-059 — Explicit churn — deleted / switched / cancelled; the review is the exit interview

- **Where:** §3.1 theme table #25 Explicit churn (deleted / switched / cancelled)
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 132 (3.35%, very strong), mean 1.83
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R33-065 — An update improved it

- **Where:** §3.1 theme table #31 An update improved it
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 112 (2.84%, meaningful), mean 4.78
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R33-107 — Too basic

- **Where:** §3.1 theme table #73 Too basic
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 31 (0.79%, emerging), mean 2.32
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-124 — Worst rating profile (n ≥ 13, by mean): account deletion fails 47, 1.23, 87.2% 1★ ('Did you choose to block account deletion to keep customers?' — looks like dark-pattern retention); privacy / data handling 23, 1.35, 73.9% (GDPR / CAN-SPAM exposure; the leaked support chat); unwanted marketing e-mail 37, 1.41, 81.1% (27 in one month, drawing people who had not opened the app in years back to write a 1★); cannot cancel 13, 1.62, 84.6% (web-billed Paddle subscriptions with no in-app cancel); support failure 131, 1.70, 67.9%; explicit churn 132, 1.83; billing dispute 42, 1.90; Premium not worth it 13, 1.92; objection to subscription 39, 1.95; weekly check-in cap 29, 2.00 (punishes the most engaged free users); crash 94, 2.14; refund 45, 2.16; login fails 151, 2.19 (mostly China and Mac); billing integrity 147, 2.22; data lost 55, 2.25; free-tier cap 213, 2.31 (the volume complaint, milder than the trust themes); Premium not granted 69, 2.33; China connectivity 173, 2.36 — the eight worst-rated themes are about leaving, being contacted, being billed or being ignored and none is a missing feature; the free cap (2.31) and price objection (2.64) are milder than the trust failures (1.23–1.95): people tolerate a gate, they do not tolerate being trapped, spammed or charged for nothing

- **Where:** §3.2 Worst rating profile (verbatim table) — account deletion fails 47, 1.23, 87.2% 1★ ('Did you choose to block account deletion to keep customers?'); privacy / data handling 23, 1.35, 73.9% (GDPR / CAN-SPAM; the leaked support chat); unwanted marketing email 37, 1.41, 81.1% (27 in one month; drew people who had not opened the app in years back to write a 1★); cannot cancel 13, 1.62, 84.6% (web-billed Paddle subscriptions with no in-app cancel); support failure 131, 1.70; explicit churn 132, 1.83; billing dispute 42, 1.90; Premium not worth it 13, 1.92; objection to subscription 39, 1.95; weekly check-in cap 29, 2.00 (punishes the most engaged free users); crash 94, 2.14; refund 45, 2.16; login fails 151, 2.19; billing integrity 147, 2.22; data lost 55, 2.25; free-tier cap 213, 2.31; Premium not granted 69, 2.33; China connectivity 173, 2.36 — the eight worst are about leaving, being contacted, being billed or being ignored; none is a missing feature; people tolerate a gate, they do not tolerate being trapped, spammed or charged for nothing
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | Mean | % 1★ | Why it matters ; Account deletion fails | 47 | 1.23 | 87.2% | Users cannot leave; looks like dark-pattern retention (6091415990: "Did you choose to block account deletion to keep customers?") ; Privacy / data handling | 23 | 1.35 | 73.9% | GDPR / CAN-SPAM exposure; the leaked support chat (10638299850) ; Unwanted marketing email | 37 | 1.41 | 81.1% | 27 in one month; drew people who had not opened the app in years back to write a 1★ ; Cannot cancel | 13 | 1.62 | 84.6% | Web-billed (Paddle) subscriptions with no in-app cancel (6559520547, 8371039111) ; Support failure (union) | 131 | 1.70 | 67.9% | Converts every other defect into a public 1★ ; Explicit churn | 132 | 1.83 | 52.3% | The review is the exit interview ; Billing dispute | 42 | 1.90 | 71.4% | ; Premium not worth it | 13 | 1.92 | 46.2% | ; Objection to subscription | 39 | 1.95 | 51.3% | The 2019 switch ; Weekly check-in cap | 29 | 2.00 | 51.7% | Punishes the most engaged free users ; Crash / won't open | 94 | 2.14 | 52.1% | ; Refund | 45 | 2.16 | 60.0% | ; Login fails | 151 | 2.19 | 50.3% | Mostly China and the Mac app ; Billing integrity (union) | 147 | 2.22 | 57.1% | ; Data lost | 55 | 2.25 | 43.6% | ; Free-tier cap | 213 | 2.31 | 40.8% | The *volume* complaint, but milder than the trust themes ; Premium not granted | 69 | 2.33 | 52.2% | ; China connectivity | 173 | 2.36 | 46.2% |
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `6091415990`, `10638299850`, `6559520547`, `8371039111`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C096 Privacy and discretion stack; C112 In-app cancellation; C200 Never meter the completion action — a free cap may limit habits, never check-offs; C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-125 — What the 521 monetisation complaints argue (manual, overlapping): the plurality — 'three habits is too few to judge the app' ('isn't much of a test run'; 'if … 5 rather than 3 … I'd have … probably upgraded'); concentrated in 2019–21 — 'don't take away what I already had' (the check-in cap and features moved to Premium; 300 days of notes; 'limiting the number of check ins per week ruins the whole point'); a 2019 spike — 'a tracker is not a service; don't rent it to me' ('my habits don't need a rack of servers'); steady — 'too expensive for what it is' ('269 roubles … I pay 400 for Netflix'; '43 euro … for an agenda???'); steady, non-US — 'price it for my country / my income' (Vietnam; Turkey 270 TL; a high-school student; a student who deleted; 'After 2 years … I finally can afford'; ¥19,000); E5 — 'let me pay monthly / try it first' ('pagar 50-60€ como única opción?')

- **Where:** §3.3 Reading the monetisation objection (verbatim table) — plurality 'three habits is too few to judge the app' ('isn't much of a test run'; 'if … 5 rather than 3 … I'd have … probably upgraded'); 'don't take away what I already had' (check-in cap, features moved to Premium; 300 days of notes; 'limiting the number of check ins per week ruins the whole point') concentrated 2019–21; 'a tracker is not a service; don't rent it to me' ('my habits don't need a rack of servers') 2019 spike; 'too expensive for what it is' ('269 roubles … I pay 400 for Netflix'; '43 euro … for an agenda???') steady; 'price it for my country / my income' (Vietnam; Turkey 270 TL; high-school student; 'After 2 years … I finally can afford'; ¥19,000) steady, non-US; 'let me pay monthly / try it first' ('pagar 50-60€ como única opción?') E5
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Argument | Rough share | Example IDs ; "Three habits is too few to *judge* the app" (evaluation) | the plurality | 1468304734 ("isn't much of a test run"), 3302452135 ("if … 5 rather than 3 … I'd have … probably upgraded"), 7834427180, 9594953333, 12379414402 ; "Don't take away what I already had" (the check-in cap, features moved to Premium) | concentrated in 2019–21 | 4002480223 (300 days of notes), 4005130935, 6495113718, 6541638912, 7038821896 ("limiting the number of check ins per week ruins the whole point") ; "A tracker is not a service; don't rent it to me" (subscription principle) | 2019 spike | 3661739808 ("my habits don't need a rack of servers"), 3828231545, 3674478475, 3873901587, 5336471509 ; "Too expensive for what it is" (value) | steady | 3936231580 ("269 roubles … I pay 400 for Netflix"), 5884634297 ("43 euro … for an agenda???"), 6186108971, 7169126431, 12565185507 ; "Price it for my country / my income" (affordability) | steady, non-US | 4179813347 (Vietnam), 4771857078 (Turkey, 270 TL), 5071251596 (high-school student), 6257885145 (student, deleted), 13153252441 ("After 2 years … I finally can afford"), 14106494461 (¥19,000) ; "Let me pay monthly / try it first" (commitment) | E5 | 5583352286, 10866310493, 11363702706, 12814496096 ("pagar 50-60€ como única opción?")
- **Direction for us:** product-rule · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `1468304734`, `3302452135`, `7834427180`, `9594953333`, `12379414402`, `4002480223`, `4005130935`, `6495113718`, `6541638912`, `7038821896`, `3661739808`, `3828231545`, `3674478475`, `3873901587`, `5336471509`, `3936231580`, `5884634297`, `6186108971`, `7169126431`, `12565185507`, `4179813347`, `4771857078`, `5071251596`, `6257885145`, `13153252441`, `14106494461`, `5583352286`, `10866310493`, `11363702706`, `12814496096`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase; C063 Free trial before purchase; C064 Price level — where 'fair' turns into 'too expensive'; C092 Regional pricing; C147 Let people use the product before they pay; C163 Visible monthly plan — annual-default trials drive billing disputes

### R33-127 — What the product does well (4–5★ counts): simple, uncluttered, fast to log 453 ('This app doesn't get in your way'; 'Dead simple'; 'None of the over-designed … gamification'); beautiful, calm design 285 ('simple like Apple products'); 'the best tracker I've tried' 299 ('tested almost every habit tracking app'; 'From streaks to strides to way of life… Habitify crushes'); life outcomes 201 (on the way to 100 books; 'helped me out of my depression'; quitting smoking; 1,000+ gym days; a 100-day journal streak); statistics and history 182 ('The statistics … is what sold me'; a Korean study planner); time-of-day structure 43 mentions ('no other app does as well'; 'the best thing about Habitify'); cross-platform 106 ('The only 100% cross platform habit tracker'); lifetime pricing 51 + 99; integrations for power users 47 (Shortcuts tiles; API 'unbeatable'; 'Pairs nicely with agentic workflows'); neurodivergent and health users, 7 ADHD + 20 health ('as an adult with ADHD'; 'I'm neurodivergent and I really hate routine'; 'I live with ADHD and anxiety'; medication)

- **Where:** §3.4 What the product does well (verbatim table) — simple, uncluttered, fast to log 453 ('This app doesn't get in your way'; 'Dead simple'; 'None of the over-designed … gamification'); beautiful calm design 285 ('simple like Apple products'); 'the best tracker I've tried' 299 ('tested almost every habit tracking app'; 'From streaks to strides to way of life… Habitify crushes'); life outcomes 201 (100 books; out of depression; quitting smoking; 1,000+ gym days; 100-day journal streak); statistics and history 182 ('The statistics … is what sold me'; Korean study planner); time-of-day structure 43 ('no other app does as well'; 'the best thing about Habitify'); cross-platform 106 ('The only 100% cross platform habit tracker'); lifetime pricing 51 + 99; integrations for power users 47 (Shortcuts tiles; API 'unbeatable'; 'Pairs nicely with agentic workflows'); neurodivergent and health users 7 ADHD + 20 health ('as an adult with ADHD'; 'I'm neurodivergent and I really hate routine'; 'I live with ADHD and anxiety'; medication)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Strength | n (4–5★) | Evidence ; Simple, uncluttered, fast to log | 453 | 2113325079 ("This app doesn't get in your way"), 3392751941 ("Dead simple"), 5234456903, 6080560135 ("None of the over-designed … gamification") ; Beautiful, calm design | 285 | 2261849364, 3150788244 (Japanese: "simple like Apple products"), 3294255105, 11183844412 ; "The best tracker I've tried" | 299 | 3304559331, 5440406266 ("tested almost every habit tracking app"), 9437498863, 13644168457 ("From streaks to strides to way of life… Habitify crushes") ; Life outcomes | 201 | 4823889316 (on the way to 100 books), 5065106375 ("helped me out of my depression"), 4401029955 (quitting smoking), 12185327521 (1,000+ gym days), 11951396915 (100-day journal streak) ; Statistics and history | 182 | 3158042031 ("The statistics … is what sold me"), 3440017816, 5351195268 (Korean study planner) ; Time-of-day structure | 43 mentions | 1634301611 ("no other app does as well"), 3491889583, 10942733003 ("the best thing about Habitify") ; Cross-platform | 106 | 3389713889 (Mac, iPad, iPhone, Watch), 7191544761, 13541473741 ("The only 100% cross platform habit tracker") ; Lifetime pricing | 51 + 99 | Part 3.3 ; Integrations for power users | 47 | 7118907544 (Shortcuts tiles), 13575307315 (API "unbeatable"), 13912801657 ("Pairs nicely with agentic workflows") ; Neurodivergent and health users | 7 ADHD + 20 health | 9696710729, 10038284177 ("as an adult with ADHD"), 10854384133 ("I'm neurodivergent and I really hate routine"), 14025511246 ("I live with ADHD and anxiety"), 5652896336 (medication)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `2113325079`, `3392751941`, `5234456903`, `6080560135`, `2261849364`, `3150788244`, `3294255105`, `11183844412`, `3304559331`, `5440406266`, `9437498863`, `13644168457`, `4823889316`, `5065106375`, `4401029955`, `12185327521`, `11951396915`, `3158042031`, `3440017816`, `5351195268`, `1634301611`, `3491889583`, `10942733003`, `3389713889`, `7191544761`, `13541473741`, `7118907544`, `13575307315`, `13912801657`, `9696710729`, `10038284177`, `10854384133`, `14025511246`, `5652896336`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C011 Weekly / monthly / yearly reports; C013 Cloud sync / multi-device as the paid differentiator; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C046 Shortcuts / Siri / URL scheme / API; C053 Custom time-of-day segments; C067 Fitness / health tracking use case; C134 Lead the store listing with what users actually love

### R33-130 — Shipping a request retires it: multiple completions per day / quantities drew 53 requests, 50 of them before multi-check-in goals shipped in Aug 2020 — 2.9% of E1 falling to 0.1% of E5

- **Where:** §3.5 Shipping a request retires it — multiple completions per day: 53 requests, 50 of them before multi-check-in goals shipped in Aug 2020 (E1 2.9% → E5 0.1%)
- **This app does:** shipped multi-check-in goals
- **User reaction:** praise
- **Magnitude:** 53; 50 pre-Aug 2020; 2.9% → 0.1%
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N

### R33-139 — Anger follows take-backs, not the cap: 18 reviewers defend the cap and 48 call the free tier sufficient, while the spikes in 1★ follow the subscription switch, features moved to Premium, the weekly check-in cap and the cut to two habits — each tightening produced its own wave of 1★ from engaged free users; conversion cannot be measured from reviews

- **Where:** §4.2 What the evidence says and does not say — the cap alone is not the whole story: 18 defend it and 48 call the free tier sufficient; the spikes in anger follow the take-backs — steps (b), (c), (d) and (f) — rather than the cap; conversion cannot be measured, but each tightening produced its own wave of 1★ from engaged free users
- **This app does:** take-backs
- **User reaction:** 1★-burst
- **Magnitude:** 18 defend; 48 sufficient
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R33-152 — 5★ (n = 2,044, 51.89%): core praise 1,240 (60.7%); simplicity 392 (19.2%); generic only 347 (17.0%); helps build habits 292 (14.3%); 'best tracker' 276 (13.5%); design 230 (11.3%); any request 188 (9.2%); life outcome 186 (9.1%); reliability complaint 162 (7.9%); explicit payer 159 (7.8%); statistics 155 (7.6%); competitor comparison 152 (7.4%); monetisation friction 86 (4.2%); rating contradicts text 82 (4.0%) — four sub-populations: short affective reviews ('Best'); comparison essays choosing Habitify over named rivals; outcome stories; and 82 complaints filed at 5★ (a China block; data lost; 'Progress Gone!!! Subscription cancelled'; can't open for a week), some rating 5 to be noticed and the rest mis-taps; the Oct 2018 burst also sits here

- **Where:** §5.1 5★ — n = 2,044 (51.89%) table (verbatim): core praise 1,240 (60.7%); simplicity 392 (19.2%); generic only 347 (17.0%); helps build habits 292 (14.3%); 'best tracker' 276 (13.5%); design 230 (11.3%); any request 188 (9.2%); life outcome 186 (9.1%); reliability complaint 162 (7.9%); explicit payer 159 (7.8%); statistics 155 (7.6%); competitor comparison 152 (7.4%); monetisation friction 86 (4.2%); rating contradicts text 82 (4.0%) — four sub-populations: short affective reviews ('Best'); comparison essays choosing Habitify over named rivals; outcome stories; complaints filed at 5★ — 82 (China block; data lost; 'Progress Gone!!! Subscription cancelled'; can't open for a week), some rating 5 to be noticed, the rest mis-taps; the Oct 2018 burst also sits here
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of 5★ ; Core praise (union) | 1,240 | 60.7% ; Simplicity | 392 | 19.2% ; Generic only | 347 | 17.0% ; Helps build habits | 292 | 14.3% ; "Best tracker" | 276 | 13.5% ; Design | 230 | 11.3% ; Any request (unmet) | 188 | 9.2% ; Life outcome | 186 | 9.1% ; Reliability complaint | 162 | 7.9% ; Explicit payer | 159 | 7.8% ; Statistics | 155 | 7.6% ; Competitor comparison | 152 | 7.4% ; Monetisation friction | 86 | 4.2% ; Rating contradicts text | 82 | 4.0%
- **Direction for us:** build-free · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `1456186344`, `3304559331`, `3491889583`, `5440406266`, `13644168457`, `4823889316`, `5065106375`, `11951396915`, `3184955956`, `5974967423`, `6402220006`, `12251927719`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R33-153 — 4★ (n = 526, 13.35%) is the feature-request band — requests 184 (35.0% vs 13.46% globally); core praise 178 (33.8%); reliability 153 (29.1%); monetisation friction 68 (12.9%); simplicity 61 (11.6%); bug 59 (11.2%); platform issues 56 (10.6%); design 55 (10.5%); scheduling request 37 (7.0%); cap 31 (5.9%); units / icons 26 (4.9%); themes / colours 25 (4.8%) — reviewers name the missing piece: 'if these options are one day added, I will update my rating to 5 stars'; weekly completion rates and negative habits; a habit score; interactive widgets and Mac parity

- **Where:** §5.2 4★ — n = 526 (13.35%) table (verbatim): any request 184 (35.0%); core praise 178 (33.8%); reliability 153 (29.1%); monetisation friction 68 (12.9%); simplicity 61 (11.6%); bug 59 (11.2%); platform issues 56 (10.6%); design 55 (10.5%); scheduling request 37 (7.0%); cap 31 (5.9%); units / icons 26 (4.9%); themes / colours 25 (4.8%) — 4★ is the feature-request band (35.0% vs 13.46% globally): 'if these options are one day added, I will update my rating to 5 stars'; weekly completion rates and negative habits; a habit score; interactive widgets and Mac parity
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 4★ ; Any request (unmet) | 184 | 35.0% ; Core praise | 178 | 33.8% ; Reliability | 153 | 29.1% ; Monetisation friction | 68 | 12.9% ; Simplicity | 61 | 11.6% ; Bug | 59 | 11.2% ; Platform issues | 56 | 10.6% ; Design | 55 | 10.5% ; Scheduling request | 37 | 7.0% ; Cap | 31 | 5.9% ; Units / icons | 26 | 4.9% ; Themes / colours | 25 | 4.8%
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `3092330445`, `5462712336`, `7386841861`, `12757003557`
- **Canonical:** C011 Weekly / monthly / yearly reports; C023 Interactive widget check-off; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-154 — 3★ (n = 383, 9.72%) is the 'good app, broken on my other device' band: reliability 183 (47.8%); any request 94 (24.5%); platform issues 82 (21.4%); monetisation friction 81 (21.1%); bug 56 (14.6%); price objection 41 (10.7%); cap 34 (8.9%); Mac / web 28 (7.3%); widget 28 (7.3%); Watch 26 (6.8%)

- **Where:** §5.3 3★ — n = 383 (9.72%) table (verbatim): reliability 183 (47.8%); any request 94 (24.5%); platform issues 82 (21.4%); monetisation friction 81 (21.1%); bug 56 (14.6%); price objection 41 (10.7%); cap 34 (8.9%); Mac / web 28 (7.3%); widget 28 (7.3%); Watch 26 (6.8%) — the 'good app, broken on my other device' band
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 3★ ; Reliability | 183 | 47.8% ; Any request | 94 | 24.5% ; Platform issues | 82 | 21.4% ; Monetisation friction | 81 | 21.1% ; Bug | 56 | 14.6% ; Price objection | 41 | 10.7% ; Cap | 34 | 8.9% ; Mac / web | 28 | 7.3% ; Widget | 28 | 7.3% ; Watch | 26 | 6.8%
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `5441810150`, `6144410650`, `6390933328`, `12815466155`, `13236248497`, `13572292515`
- **Canonical:** C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-155 — 2★ (n = 279, 7.08%) is the 'I used to love it' band: reliability 135 (48.4%); monetisation friction 82 (29.4%); bug 51 (18.3%); cap 42 (15.1%); regression 42 (15.1% vs 5.0% globally); explicit payer 42 (15.1%); update made it worse 38 (13.6%); price objection 35 (12.5%); explicit churn 34 (12.2% vs 3.4%); China connectivity 24 (8.6%) — 'almost 2 years … finally decided it's time to move on'

- **Where:** §5.4 2★ — n = 279 (7.08%) table (verbatim): reliability 135 (48.4%); monetisation friction 82 (29.4%); bug 51 (18.3%); cap 42 (15.1%); regression 42 (15.1%); explicit payer 42 (15.1%); update made it worse 38 (13.6%); price objection 35 (12.5%); explicit churn 34 (12.2%); China connectivity 24 (8.6%) — the 'I used to love it' band: regression 15.1% vs 5.0% globally, churn 12.2% vs 3.4% ('almost 2 years … finally decided it's time to move on')
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Theme | n | % of 2★ ; Reliability | 135 | 48.4% ; Monetisation friction | 82 | 29.4% ; Bug | 51 | 18.3% ; Cap | 42 | 15.1% ; Regression | 42 | 15.1% ; Explicit payer | 42 | 15.1% ; Update made it worse | 38 | 13.6% ; Price objection | 35 | 12.5% ; Explicit churn | 34 | 12.2% ; China connectivity | 24 | 8.6%
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `6373708406`, `6384710442`, `6486868709`, `6546552236`, `7321970137`, `13235819413`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace

### R33-156 — 1★ (n = 707, 17.95%): reliability 317 (44.8%); monetisation friction 204 (28.9%); explicit payer 130 (18.4%); platform issues 103 (14.6%); support failure 89 (12.6%); cap 87 (12.3%); billing integrity 84 (11.9%); China connectivity 80 (11.3%); login fails 76 (10.7%); regression 71 (10.0%); explicit churn 69 (9.8%); account / e-mail / privacy 67 (9.5%); account deletion 41 (5.8%); marketing e-mail 30 (4.2%) — money gates and reliability dominate; nearly one 1★ in five comes from a payer; China alone is 11.3% of all 1★; trust failures (deletion, e-mail, privacy) are 9.5% of 1★ but only 2.6% of the corpus — the most over-represented group; the register is sharp in several languages: 「詐欺アプリ」 (scam app), 'Abzocke', 'CON ARTISTS', 流氓 (rogue)

- **Where:** §5.5 1★ — n = 707 (17.95%) table (verbatim): reliability 317 (44.8%); monetisation friction 204 (28.9%); explicit payer 130 (18.4%); platform issues 103 (14.6%); support failure 89 (12.6%); cap 87 (12.3%); billing integrity 84 (11.9%); China connectivity 80 (11.3%); login fails 76 (10.7%); regression 71 (10.0%); explicit churn 69 (9.8%); account / email / privacy 67 (9.5%); account deletion 41 (5.8%); marketing email 30 (4.2%) — money gates and reliability dominate; nearly one 1★ in five from a payer; China alone 11.3% of all 1★; trust failures 9.5% of 1★ but 2.6% of the corpus — the most over-represented group; register: 「詐欺アプリ」, 'Abzocke', 'CON ARTISTS', 流氓
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of 1★ ; Reliability | 317 | 44.8% ; Monetisation friction | 204 | 28.9% ; Explicit payer | 130 | 18.4% ; Platform issues | 103 | 14.6% ; Support failure | 89 | 12.6% ; Cap | 87 | 12.3% ; Billing integrity | 84 | 11.9% ; China connectivity | 80 | 11.3% ; Login fails | 76 | 10.7% ; Regression | 71 | 10.0% ; Explicit churn | 69 | 9.8% ; Account / email / privacy | 67 | 9.5% ; Account deletion | 41 | 5.8% ; Marketing email | 30 | 4.2%
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `5058976402`, `5516255548`, `3873901587`, `5731725220`, `6559520547`, `3830846002`
- **Canonical:** C029 Billing must be exactly right; C065 Paying customers are the highest 1★ risk — every paid feature must work; C132 Do not sell in a storefront where the app cannot function; C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-157 — Across the rating line (5★+4★ / 3★ / 2★+1★): free cap 50 / 34 / 129 — mostly hostile, a quarter from 4–5★; price objection 59 / 41 / 103 — many 'great app, too expensive' at 4–5★; update made it worse 43 / 25 / 102 — loyal users object at 4–5★ before leaving; Mac / web broken 47 / 28 / 66 — tolerated by fans, decisive for multi-device buyers; Watch broken 34 / 26 / 40 — evenly split; widget broken 34 / 28 / 23 — the mildest complaint (mean 3.15), annoying but rarely fatal; China connectivity 45 / 24 / 104 — 17 China reviewers rate 5★ while blocked; explicit payer 212 / 43 / 172 — the most polarised group; competitor named 182 / 6 / 29 — overwhelmingly arrivals

- **Where:** §5.6 Themes across the rating line (verbatim table): free cap 50 / 34 / 129 — mostly hostile, a quarter from 4–5★; price objection 59 / 41 / 103 — many 'great app, too expensive' 4–5★; update made it worse 43 / 25 / 102 — loyal users object at 4–5★ before leaving; Mac / web broken 47 / 28 / 66 — tolerated by fans, decisive for multi-device buyers; Watch broken 34 / 26 / 40 — evenly split; widget broken 34 / 28 / 23 — mildest complaint (mean 3.15), annoying, rarely fatal; China connectivity 45 / 24 / 104 — 17 China reviewers rate 5★ while blocked; explicit payer 212 / 43 / 172 — the most polarised group; competitor named 182 / 6 / 29 — overwhelmingly arrivals
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 5★+4★ | 3★ | 2★+1★ | Reading ; Free cap | 50 | 34 | 129 | Mostly hostile; a quarter comes from people rating 4–5★ ; Price objection | 59 | 41 | 103 | Many "great app, too expensive" 4–5★ ; Update made it worse | 43 | 25 | 102 | Loyal users object at 4–5★ before leaving ; Mac / web broken | 47 | 28 | 66 | Tolerated by fans; decisive for multi-device buyers ; Watch broken | 34 | 26 | 40 | Evenly split ; Widget broken | 34 | 28 | 23 | Mildest complaint (mean 3.15) — annoying, rarely fatal ; China connectivity | 45 | 24 | 104 | 17 China reviewers rate 5★ while blocked ; Explicit payer | 212 | 43 | 172 | Payers are the most polarised group ; Competitor named | 182 | 6 | 29 | Overwhelmingly arrivals
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C065 Paying customers are the highest 1★ risk — every paid feature must work; C132 Do not sell in a storefront where the app cannot function; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-160 — Payers turn hostile when what they bought changes, not when the price rises: explicit payers E1 92 (9.9% of era), mean 2.82; E2 126 (10.1%), 3.77 — the high, when a lifetime option coexisted with a stable app; E3 79 (14.9%, the highest share), 2.78 — lifetime holders reacting to Habitify X, the check-in cap and the Mac stall; E4 47 (11.3%), 2.96; E5 83 (10.2%), 3.10; 2018 is the low point among payers (54 payers, mean 2.83), 25 of whom report a purchase not applied (the Jan 2018 wave and v2.0 losses)

- **Where:** §6.2 Payers are polarised and their mood tracks integrity events, not price (verbatim table) — E1 92 (9.9%) 2.82; E2 126 (10.1%) 3.77; E3 79 (14.9%) 2.78; E4 47 (11.3%) 2.96; E5 83 (10.2%) 3.10; 2018 the low point (54 payers, 2.83; 25 report a purchase not applied); E3 highest payer share, lifetime holders reacting to Habitify X, the check-in cap and the Mac stall; E2, when a lifetime option coexisted with a stable app, is the payer high (3.77); payers turn hostile when what they bought changes, not when the price rises
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era | Explicit payers | % of era | Mean ; E1 (2016 – Jan 2019) | 92 | 9.9% | 2.82 ; E2 (Jan 2019 – Aug 2020) | 126 | 10.1% | 3.77 ; E3 (Aug 2020 – 2021) | 79 | 14.9% | 2.78 ; E4 (2022–23) | 47 | 11.3% | 2.96 ; E5 (2024–26) | 83 | 10.2% | 3.10
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C186 Never revoke what earlier buyers paid for when the model changes

### R33-162 — What buyers value after paying: price fair / worth it 41 (9.6% of payers, mean 4.85); simplicity 30; design 28; 'best tracker' 25; life outcome 24; one-time pricing 13; support praise 15 — lifetime holders use the language of investment ('the best £30 I ever spent'; 'some of the best money I ever spent on an app'; 'I would have paid triple')

- **Where:** §6.4 What buyers value once they have paid — price fair / worth it 41 (9.6%, mean 4.85); simplicity 30; design 28; 'best tracker' 25; life outcome 24; one-time pricing 13; support praise 15; lifetime holders use the language of investment ('the best £30 I ever spent'; 'some of the best money I ever spent on an app'; 'I would have paid triple')
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 41 (9.6%, 4.85)
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `5065106375`, `13421769372`, `14234671252`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors

### R33-177 — The more reviewers engage with paying and with multiple devices, the more integrity and parity problems they meet: Group B (18 storefronts ≥50 reviews, a disclosed proxy, not downloads) n = 3,190 (81.0%), mean 3.71, 5★ 50.3%, 1★ 18.5%, payer 11.8%, not granted 2.0%, billing integrity 4.2%, China 5.4%, best 7.1%, generic 10.0%; tail (81 storefronts) n = 749 (19.0%), mean 3.89, 5★ 58.6%, 1★ 15.8%, payer 6.5%, not granted 0.7%, billing integrity 1.9%, China 0.0%, best 10.3%, generic 12.4% — the tail rates higher and pays less

- **Where:** §7.5 Group B — the 18 storefronts ≥50 reviews (disclosed proxy, not downloads): n = 3,190 (81.0%), mean 3.71, 5★ 50.3%, 1★ 18.5%, payer 11.8%, not granted 2.0%, billing integrity 4.2%, China 5.4%, best 7.1%, generic 10.0%; tail (81 storefronts) 749 (19.0%), 3.89, 5★ 58.6%, 1★ 15.8%, payer 6.5%, not granted 0.7%, billing 1.9%, China 0.0%, best 10.3%, generic 12.4% — the tail rates higher and pays less; the more reviewers engage with paying and multiple devices, the more integrity and parity problems they meet
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 3.71 vs 3.89
- **Direction for us:** none · **Report confidence:** disclosed proxy · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R33-183 — Feature accumulation erodes a simplicity identity: as goals, timer, Health, mood, challenges, friends and AI were added, simplicity praise fell 15.9% (E1) → 15.7% → 6.0% → 6.0% → 7.3% and design 14.0% → 4.8%, core praise 42.0% → 32.6%, while 'best tracker' rose 6.6% → 9.2% and life outcome 3.4% → 7.4% (E4) → 5.4% and 'confusing / hard to use' tripled 1.8% → 5.8% — reviewers now praise capability and the identity that won the early users is eroding

- **Where:** §8.3 Trend 2 — praise moved from 'simple and beautiful' to 'the best, and it changed my life' (verbatim table): core praise 42.0% → 44.6% → 25.8% → 30.7% → 32.6%; simplicity 15.9 → 15.7 → 6.0 → 6.0 → 7.3; design 14.0 → 9.0 → 4.2 → 4.3 → 4.8; 'best tracker' 6.6 → 7.7 → 6.2 → 9.1 → 9.2; life outcome 3.4 → 5.6 → 5.3 → 7.4 → 5.4; confusing / hard to use 1.8 → 1.8 → 3.8 → 2.4 → 5.8 — as features accumulated (goals, timer, Health, mood, challenges, friends, AI) 'simple' stopped being the headline; reviewers praise capability while 'confusing' triples; the simplicity identity that won the early users is eroding
- **This app does:** feature accretion
- **User reaction:** mixed
- **Magnitude:** Praise theme | E1 | E2 | E3 | E4 | E5 ; Core praise (union) | 42.0% | 44.6% | 25.8% | 30.7% | 32.6% ; Simplicity | 15.9% | 15.7% | 6.0% | 6.0% | 7.3% ; Design | 14.0% | 9.0% | 4.2% | 4.3% | 4.8% ; "Best tracker" | 6.6% | 7.7% | 6.2% | 9.1% | 9.2% ; Life outcome | 3.4% | 5.6% | 5.3% | 7.4% | 5.4% ; Confusing / hard to use | 1.8% | 1.8% | 3.8% | 2.4% | 5.8%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

### R33-190 — AI support replies are an emerging negative: support praised 2.3% (E1) → 2.0% → 4.0% → 2.9% → 3.0% and unresponsive 1.8% → 1.4% → 4.2% → 2.4% → 3.1%, while AI features or AI support drew 8 reviews, 7 of them 2025–26 and mostly negative — 'Stop shoving AI everywhere'; 'Their support is AI'; the chatbot 'stops answering' mid account deletion; an instant AI reply with no human — weak but new and directional

- **Where:** §8.10 Trend 9 — support better than peers, but AI replies arrive: support praised 2.3% → 2.0% → 4.0% → 2.9% → 3.0%; unresponsive 1.8% → 1.4% → 4.2% → 2.4% → 3.1%; AI features or AI support 8 reviews, 7 of them 2025–26, mostly negative ('Stop shoving AI everywhere'; 'Their support is AI'; the chatbot 'stops answering'; an AI reply with no human) — weak signal but new and directional
- **This app does:** AI-first support
- **User reaction:** complaint
- **Magnitude:** AI 8 (7 in 2025–26), mean 2.62
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12324906138`, `13659075450`, `12715605250`, `14106494461`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C056 Don't build AI features on demand grounds

## Audiences

### R33-121 — Medical / mental-health use

- **Where:** §3.1 theme table #87 Medical / mental-health use
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 20 (0.51%, emerging), mean 4.70
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C067 Fitness / health tracking use case

## Markets and languages

### R33-007 — China was a lost market from 2018 and never fixed: 173 reviews (4.39%, very strong globally; 57.8% of China) say that in mainland China the app cannot register, log in, save or sync without a VPN; the peak was Dec 2018 → Jan 2019 (61 reviews), right after the App Store 'Today' feature sent Chinese users to the app, and they were still arriving in 2025–26 ('you can't even log in, but the charge was fast'); paying Chinese users could not unlock or restore what they bought (paid twice; 328 RMB with refunds refused)

- **Where:** Executive summary #3 — China was a lost market from 2018, and it was never fixed: 173 (4.39%, very strong globally; 57.8% of China) say in mainland China the app cannot register, log in, save or sync without a VPN; peak Dec 2018 → Jan 2019 (61), right after the App Store 'Today' feature sent Chinese users to the app; still arriving 2025–26 ('you can't even log in, but the charge was fast'); paying Chinese users could not unlock or restore (paid twice; 328 RMB, refunds refused)
- **This app does:** backend unreachable in mainland China
- **User reaction:** 1★-burst
- **Magnitude:** 173 (4.39%); 57.8% of cn; peak 61 Dec 2018 – Jan 2019
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `3528438035`, `3541075226`, `12890334582`, `14019544061`, `3529813395`, `6925930580`, `7112692402`
- **Canonical:** C132 Do not sell in a storefront where the app cannot function

### R33-019 — An unusually Asian-heavy corpus: Latin script 2,676 (67.9%); Japanese 461 (11.7%); Chinese 281 (7.1%); Korean 250 (6.3%); Cyrillic 152 (3.9%); Vietnamese with diacritics 106 (2.7%); Arabic 7; Thai 6

- **Where:** §1.6 Languages — Latin 2,676 (67.9%); Japanese 461 (11.7%); Chinese 281 (7.1%); Korean 250 (6.3%); Cyrillic 152 (3.9%); Vietnamese 106 (2.7%); Arabic 7; Thai 6 — an unusually Asian-heavy corpus
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ja 11.7%; zh 7.1%; ko 6.3%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C027 Localise early — it unlocks revenue

### R33-053 — Mainland-China connectivity (needs VPN), E1 11.5%

- **Where:** §3.1 theme table #19 Mainland-China connectivity (needs VPN)
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 173 (4.39%, very strong), mean 2.36; 1★ 80
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C132 Do not sell in a storefront where the app cannot function

### R33-083 — Localisation — quality / wrong language / request

- **Where:** §3.1 theme table #49 Localisation (quality / wrong language / request)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 62 (1.57%, meaningful), mean 3.18
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R33-134 — China was lost on reachability, not product fit: mean 2.96 with the block, 3.77 without it; 79 of China's 101 1★ reviews are this one problem; 18 explicit payers affected; 17 China reviews give 5★ while describing the block, so the rating under-represents it; reviewers describe mandatory sign-in to a non-Apple backend (later naming Firebase) and ask for plain iCloud sync, while praising the design and the localisation and saying they were ready to pay

- **Where:** §4.1 Impact — China's mean 2.96, 3.77 without these; 79 of 101 China 1★ are this one problem; 18 explicit payers affected; 17 China reviews give 5★ while describing the block, so the problem is under-represented in the rating; interpretation: reviewers describe mandatory sign-in to a non-Apple backend (Firebase named) and ask for plain iCloud sync; China reviewers praise the design and localisation and several were ready to pay — the market was not lost on product fit; it was lost on reachability
- **This app does:** Firebase-only account sync
- **User reaction:** blocked-conversion
- **Magnitude:** 2.96 vs 3.77; 79/101 1★; 18 payers; 17 5★ blocked
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `3184955956`, `3202158097`, `3589796422`, `11626791974`, `12000656068`, `3208341657`, `3555416943`, `5716375250`
- **Canonical:** C030 Sync must work — and prove it; C132 Do not sell in a storefront where the app cannot function

### R33-168 — Per-storefront rates for the 18 eligible storefronts

- **Where:** §7.2 All 18 eligible storefronts (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** cc | n | mean | 5★% | 1★% | subst. mean | cap | mon-friction | price obj. | subscr. obj. | payer | not granted | billing-int. | CN / login | Mac/web | Watch | locale | acct-del | email | simple | design | best | update worse | generic ; us | 610 | 3.61 | 45.9 | 20.3 | 3.58 | 6.7 | 12.5 | 3.3 | 0.7 | 11.8 | 1.5 | 3.4 | 0.3 / 2.1 | 4.6 | 2.8 | 0.0 | 0.5 | 1.0 | 12.8 | 10.7 | 9.8 | 4.3 | 5.4 ; jp | 524 | 3.65 | 46.0 | 17.0 | 3.52 | 4.2 | 10.7 | 3.6 | 0.4 | 16.0 | 3.2 | 5.3 | 0.0 / 1.7 | 2.5 | 5.0 | 3.1 | 1.7 | 0.8 | 13.9 | 4.4 | 2.7 | 8.2 | 7.8 ; cn | 296 | 2.96 | 30.7 | 34.1 | 3.35 | 0.0 | 5.4 | 3.0 | 0.7 | 12.2 | 3.4 | 7.1 | 57.8 / 35.5 | 2.7 | 3.4 | 2.0 | 0.3 | 0.0 | 4.7 | 10.8 | 2.0 | 1.0 | 5.4 ; kr | 292 | 4.20 | 64.7 | 10.3 | 4.18 | 3.1 | 12.0 | 6.8 | 0.0 | 13.7 | 1.4 | 6.5 | 0.0 / 0.3 | 1.4 | 2.4 | 1.7 | 5.5 | 0.7 | 14.7 | 4.8 | 6.2 | 3.8 | 13.7 ; gb | 162 | 3.60 | 47.5 | 20.4 | 3.56 | 10.5 | 23.5 | 8.0 | 3.1 | 13.6 | 3.7 | 6.8 | 0.0 / 0.0 | 2.5 | 2.5 | 0.6 | 0.6 | 1.2 | 10.5 | 11.7 | 8.6 | 4.3 | 5.6 ; ru | 159 | 3.79 | 54.1 | 17.0 | 3.62 | 5.0 | 13.2 | 8.8 | 0.6 | 8.2 | 0.6 | 1.9 | 0.0 / 2.5 | 10.1 | 1.9 | 5.0 | 0.0 | 0.6 | 7.5 | 6.9 | 13.8 | 10.1 | 12.6 ; vn | 158 | 4.61 | 79.7 | 3.8 | 4.30 | 2.5 | 7.6 | 3.8 | 0.0 | 2.5 | 0.0 | 0.6 | 0.0 / 0.0 | 1.3 | 0.6 | 0.6 | 0.0 | 0.0 | 10.1 | 3.8 | 2.5 | 0.6 | 32.9 ; ca | 132 | 3.68 | 48.5 | 18.2 | 3.64 | 3.8 | 12.9 | 7.6 | 0.8 | 10.6 | 3.0 | 4.5 | 0.0 / 1.5 | 3.8 | 1.5 | 1.5 | 2.3 | 2.3 | 15.2 | 8.3 | 9.1 | 3.8 | 4.5 ; in | 130 | 3.78 | 54.6 | 18.5 | 3.52 | 6.2 | 13.1 | 3.1 | 0.0 | 17.7 | 3.1 | 5.4 | 0.0 / 0.8 | 4.6 | 1.5 | 0.0 | 0.8 | 0.0 | 10.0 | 9.2 | 8.5 | 4.6 | 14.6 ; de | 109 | 3.35 | 40.4 | 25.7 | 3.30 | 4.6 | 21.1 | 14.7 | 9.2 | 8.3 | 0.9 | 1.8 | 0.0 / 0.0 | 1.8 | 2.8 | 3.7 | 3.7 | 6.4 | 14.7 | 14.7 | 8.3 | 3.7 | 6.4 ; br | 105 | 3.63 | 53.3 | 22.9 | 3.23 | 10.5 | 19.0 | 3.8 | 0.0 | 18.1 | 1.0 | 5.7 | 0.0 / 1.0 | 4.8 | 2.9 | 1.0 | 0.0 | 0.0 | 11.4 | 3.8 | 4.8 | 1.9 | 13.3 ; mx | 91 | 3.98 | 62.6 | 11.0 | 3.89 | 8.8 | 14.3 | 4.4 | 2.2 | 4.4 | 0.0 | 0.0 | 0.0 / 0.0 | 4.4 | 2.2 | 1.1 | 1.1 | 0.0 | 11.0 | 5.5 | 7.7 | 4.4 | 13.2 ; pl | 87 | 3.70 | 48.3 | 14.9 | 3.57 | 6.9 | 19.5 | 6.9 | 4.6 | 6.9 | 1.1 | 1.1 | 0.0 / 0.0 | 4.6 | 3.4 | 1.1 | 0.0 | 1.1 | 5.7 | 6.9 | 13.8 | 3.4 | 9.2 ; au | 87 | 3.52 | 46.0 | 25.3 | 3.38 | 8.0 | 16.1 | 3.4 | 2.3 | 9.2 | 1.1 | 1.1 | 0.0 / 0.0 | 4.6 | 1.1 | 0.0 | 1.1 | 2.3 | 12.6 | 10.3 | 6.9 | 4.6 | 9.2 ; fr | 77 | 3.77 | 50.6 | 15.6 | 3.63 | 7.8 | 18.2 | 10.4 | 1.3 | 9.1 | 3.9 | 3.9 | 0.0 / 2.6 | 7.8 | 3.9 | 2.6 | 0.0 | 0.0 | 11.7 | 13.0 | 6.5 | 3.9 | 15.6 ; ua | 58 | 4.16 | 70.7 | 15.5 | 3.97 | 1.7 | 5.2 | 3.4 | 0.0 | 12.1 | 1.7 | 3.4 | 0.0 / 12.1 | 6.9 | 1.7 | 0.0 | 0.0 | 1.7 | 6.9 | 10.3 | 12.1 | 3.4 | 15.5 ; tr | 57 | 4.19 | 63.2 | 8.8 | 4.03 | 3.5 | 22.8 | 10.5 | 1.8 | 7.0 | 0.0 | 0.0 | 0.0 / 0.0 | 0.0 | 0.0 | 1.8 | 0.0 | 0.0 | 7.0 | 5.3 | 12.3 | 1.8 | 15.8 ; es | 56 | 3.70 | 44.6 | 14.3 | 3.65 | 10.7 | 26.8 | 8.9 | 0.0 | 10.7 | 1.8 | 1.8 | 0.0 / 0.0 | 0.0 | 3.6 | 3.6 | 0.0 | 0.0 | 3.6 | 3.6 | 12.5 | 1.8 | 8.9 ; *Global* | 3,939 | 3.74 | 51.9 | 17.9 | 3.63 | 5.4 | 13.2 | 5.2 | 1.0 | 10.8 | 1.8 | 3.7 | 4.4 / 3.8 | 3.6 | 2.5 | 1.6 | 1.2 | 0.9 | 11.7 | 8.2 | 7.7 | 4.3 | 10.5
- **Direction for us:** none · **Report confidence:** per-market · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R33-169 — United States (n = 610, mean 3.61) is close to the global profile, with the cross-device story most visible (Mac/web 4.6%, sync 3.6%; support admits Mac lag; a $50 lifetime refunded), the long comparison essays behind lifetime purchases, the sharpest 2026 UX critique, and the CAN-SPAM and support-chat privacy reports

- **Where:** §7.3 United States — n = 610, mean 3.61: close to global; cross-device story most visible (Mac/web 4.6%, sync 3.6%; support admits Mac lag; $50 lifetime, refund); the long comparison essays behind the lifetime decision; the sharpest 2026 UX critique; the CAN-SPAM complaint and the support-chat privacy report are US
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 610; 3.61; Mac/web 4.6%; sync 3.6%
- **Direction for us:** none · **Report confidence:** per-market · **Generalisable:** app-specific
- **Review IDs:** `7727790054`, `9231182178`, `13332457934`, `2917668175`, `3440017816`, `13665455992`, `10095812056`, `10638299850`
- **Canonical:** C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-170 — Japan (n = 524, mean 3.65) has the highest payer share (16.0%), Watch complaints (5.0%) and 'update made it worse' (8.2%) of large storefronts; it was the centre of the Jan 2018 purchase wave (11 of 21); localisation grievances — 「たどたどしい日本語」 (halting Japanese), simplified-Chinese glyphs in Japanese text, English-only support replies; reordering never sticks (90 routines); memo input breaks under Japanese IME; lifetime price rose ¥1,200 (2018) → ¥4,800 (2019) → ¥6,000 (2021) → ¥19,000 (2026) — 「前に比べて値段が爆上がり」 (the price has exploded)

- **Where:** §7.3 Japan — n = 524, mean 3.65: highest payer share (16.0%), Watch complaints (5.0%) and 'update made it worse' (8.2%) among large storefronts; centre of the Jan 2018 purchase wave (11 of 21); localisation grievances 「たどたどしい日本語」 (halting Japanese), simplified-Chinese glyphs, English-only support; reordering never sticks (90 routines); memo input breaks for Japanese IME; price ¥1,200 (2018) → ¥4,800 lifetime (2019) → ¥6,000 (2021) → ¥19,000 (2026) 「前に比べて値段が爆上がり」
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 524; 3.65; payer 16.0%; Watch 5.0%; update worse 8.2%
- **Direction for us:** do · **Report confidence:** per-market · **Generalisable:** app-specific
- **Review IDs:** `2077043653`, `2093117380`, `2097705770`, `1565006445`, `3253608656`, `7596083103`, `13311766586`, `4018038145`, `7656152222`, `13701264625`, `7656211283`, `14106494461`, `14398774902`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C027 Localise early — it unlocks revenue; C033 Restore purchase and entitlements must work immediately; C073 Manual reordering, renaming and editing of habits/tasks — free; C092 Regional pricing; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R33-171 — China (n = 296, mean 2.96; 3.77 excluding connectivity) has high design praise (10.8%) and 12.2% payers but is dominated by reviews saying the service cannot be reached; Korea (n = 292, mean 4.20) is enthusiastic and largely 2019–20 — simplicity 14.7%, 'worth it even if expensive' — yet is the centre of the account-deletion failure (16 of 47) and of refund requests (13 of 45), with price objection 6.8% often phrased as a request for a discount event: 「할인하면 사겠다」 (I'll buy if it's discounted)

- **Where:** §7.3 China — n = 296, mean 2.96 (3.77 excluding connectivity): design praise high (10.8%), 12.2% payers; dominated by reviews saying the service cannot be reached; Korea — n = 292, mean 4.20: enthusiastic, largely 2019–20, simplicity 14.7%, 'worth it even if expensive'; centre of the account-deletion failure (16 of 47); most renewal and refund requests (refund 13 of 45); price objection 6.8%, often a request for a discount event 「할인하면 사겠다」
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** cn 296, 2.96 / kr 292, 4.20; deletion 16/47; refund 13/45
- **Direction for us:** research · **Report confidence:** per-market · **Generalisable:** app-specific
- **Review IDs:** `6110426928`, `5770923833`, `5202035434`, `5436553027`, `5683409156`, `6091415990`, `5213926173`, `7164301825`, `8022517166`, `8548501117`, `5211451534`, `5347117394`, `6714650309`
- **Canonical:** C092 Regional pricing; C132 Do not sell in a storefront where the app cannot function; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request; C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot

### R33-172 — United Kingdom (n = 162, mean 3.60) has the highest monetisation friction among storefronts ≥100 (23.5%), cap 10.5% and subscription objection 3.1% — the 2019 switch told most sharply ('£5.99 → £9.99 → £24 a year') — and the GDPR complaint about the 2023 e-mails; Russia (n = 159, mean 3.79) has the highest Mac/web complaint rate (10.1%) — the Mac app unavailable in the Russian store, its Russian UI lost, no sync — plus 'update made it worse' 10.1%, localisation 5.0%, price benchmarked against Netflix and no way to cancel

- **Where:** §7.3 United Kingdom — n = 162, mean 3.60: highest monetisation friction among storefronts ≥100 (23.5%), cap 10.5%, subscription objection 3.1%; the 2019 switch told most sharply ('£5.99 → £9.99 → £24 a year'); the GDPR complaint about the 2023 emails; Russia — n = 159, mean 3.79: highest Mac/web complaint rate (10.1%) — Mac app unavailable in the Russian store, lost its Russian UI, did not sync; update made it worse 10.1%; localisation 5.0%; price benchmarked against Netflix; no way to cancel
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** gb 23.5% friction / ru 10.1% Mac/web
- **Direction for us:** none · **Report confidence:** per-market · **Generalisable:** app-specific
- **Review IDs:** `3619346514`, `3887636788`, `10101814356`, `5974877379`, `6020488457`, `7244646323`, `7673086187`, `9107782562`, `1552349488`, `2227517484`, `3936231580`, `8371039111`
- **Canonical:** C001 Never move a free feature behind the paywall; C027 Localise early — it unlocks revenue; C044 Mac / desktop / web app; C064 Price level — where 'fair' turns into 'too expensive'; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-173 — Vietnam (n = 158, mean 4.61, 79.7% 5★) is the happiest storefront — a third generic — with pride in a Vietnamese-built app ('App của người Việt') and requests for local pricing; Canada (n = 132, mean 3.68) has the highest simplicity praise (15.2%), calls CA$ pricing 'highway robbery' and felt the check-in cap early; India (n = 130, mean 3.78) has a 17.7% payer share and complains about plan availability ('only … yearly and lifetime … I would have signed up for a month'), plus students and paid-but-inactive cases

- **Where:** §7.3 Vietnam — n = 158, mean 4.61: the happiest storefront (79.7% 5★), a third generic; pride in a Vietnamese-built app ('App của người Việt') and requests for local pricing; Canada — n = 132, mean 3.68: highest simplicity praise (15.2%); CA$ pricing 'highway robbery'; the check-in cap hit early; India — n = 130, mean 3.78: payer share 17.7%; plan availability ('only … yearly and lifetime … I would have signed up for a month'); students; paid-but-inactive cases
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** vn 4.61 / ca 3.68 / in 3.78, payer 17.7%
- **Direction for us:** do · **Report confidence:** per-market · **Generalisable:** app-specific
- **Review IDs:** `4721534340`, `5810323969`, `14062845602`, `4179813347`, `6229968661`, `6343893474`, `6186108971`, `6566048336`, `6593969693`, `5583352286`, `5071251596`, `8860733083`, `10693981551`, `10875668056`, `13550132289`
- **Canonical:** C092 Regional pricing; C163 Visible monthly plan — annual-default trials drive billing disputes

### R33-174 — Germany (n = 109, mean 3.35) is the most price- and subscription-averse storefront — price objection 14.7%, subscription objection 9.2% ('Abo-Abzocke'; 'Schon wieder ein Abo?'; 'in-app purchases should be banned') — with six of its seven e-mail complaints from the July 2023 wave, an offensive German UI string ('Pisst du dabei?') and high design praise (14.7%); Brazil (n = 105, mean 3.63, limited depth) has an 18.1% payer share and a 9.5% crash rate — in Oct–Nov 2019 the app would not open after purchase — cap 10.5%, R$20/month

- **Where:** §7.3 Germany — n = 109, mean 3.35: the most price- and subscription-averse storefront, price objection 14.7%, subscription objection 9.2% ('Abo-Abzocke'; 'Schon wieder ein Abo?'; 'in-app purchases should be banned'); six of its seven email complaints from the July 2023 wave; the German UI string 'Pisst du dabei?'; design praise also high (14.7%); Brazil — n = 105, mean 3.63: payer share 18.1%, crash rate 9.5% (Oct–Nov 2019 app would not open after purchase); cap 10.5%; R$20/month [limited depth: n < 150]
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** de 3.35, price 14.7%, subscr 9.2% / br payer 18.1%, crash 9.5%
- **Direction for us:** none · **Report confidence:** per-market · **Generalisable:** app-specific
- **Review IDs:** `3873901587`, `5336471509`, `6315670170`, `6209853497`, `10101941744`, `10105269764`, `10105286283`, `10105314059`, `10109101853`, `10131134360`, `5481722444`, `6315649053`, `4884387541`, `4999720797`, `5129836305`, `4811572821`, `4728517189`
- **Canonical:** C027 Localise early — it unlocks revenue; C064 Price level — where 'fair' turns into 'too expensive'; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-175 — Smaller eligible storefronts (limited depth): Spain (56, 3.70) has the highest monetisation friction of any eligible storefront (26.8%) and 3 check-in-cap reviews; Turkey (57, 4.19; friction 22.8%) objects to local-currency prices (270 TL; 260 TL lifetime; 'under 100 TL a year'); Poland (87, 3.70; 19.5%) to the subscription principle; Australia (87, 3.52) has a 25.3% 1★ share ('Dodge as hell'; A$40/yr; A$62); France (77, 3.77) combines price objection 10.4% ('€40 … vous vivez où, Monaco?'), web-app slowness and translation quality (later fixed); Ukraine (58, 4.16) has 12.1% login failures (early registration errors; Google sign-in crashes on iPad); Mexico (91, 3.98)

- **Where:** §7.3 Mexico (91, 3.98), Poland (87, 3.70), Australia (87, 3.52), France (77, 3.77), Ukraine (58, 4.16), Turkey (57, 4.19), Spain (56, 3.70) [limited depth: under 100 each] — Spain highest monetisation friction of any eligible storefront (26.8%), 3 check-in-cap reviews; Turkey (22.8%) local-currency prices (270 TL; 260 TL lifetime; 'under 100 TL a year') and Poland (19.5%) subscription principle; Australia 25.3% 1★ ('Dodge as hell'; A$40/yr; A$62); France price objection 10.4% ('€40 … vous vivez où, Monaco?'), web-app slowness, translation quality (fixed); Ukraine login failures 12.1% (early registration errors; Google sign-in crashes on iPad)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** es 26.8%; tr 22.8%; pl 19.5%; au 25.3% 1★; fr 10.4%; ua 12.1% login
- **Direction for us:** none · **Report confidence:** limited depth · **Generalisable:** app-specific
- **Review IDs:** `6623842824`, `7108556777`, `7698991901`, `4771857078`, `7498411514`, `6966124853`, `3661117378`, `3828231545`, `3879350608`, `3795256803`, `5856846519`, `5122246109`, `5494522026`, `7351181517`, `11258874148`, `1827275316`, `6961415994`
- **Canonical:** C027 Localise early — it unlocks revenue; C064 Price level — where 'fair' turns into 'too expensive'; C092 Regional pricing

### R33-176 — High-spend markets (us, cn, jp, gb, de, fr, ca, au, kr — external-knowledge definition, no spend figure in data) rate lower than the rest of the world (3.60 vs 3.93; 5★ 46.5% vs 59.3%; 1★ 20.2% vs 14.8%), about half of the gap being China (≈3.70 without cn, (3.60 × 2,289 − 2.96 × 296) / 1,993); what differs is what money buys — high-spend reviewers (2,289, 58.1%) are 1.6× as likely to be payers (12.8% vs 8.2%), 3× as likely to report Premium not granted (2.4% vs 0.8%), 2.3× billing integrity (4.9% vs 2.1%), 2× Watch (3.2% vs 1.6%) and account deletion (1.7% vs 0.5%), with price objection identical (5.2% vs 5.2%); the rest of the world (1,650, 41.9%, 90 storefronts) reports access and affordability — the cap (6.1% vs 4.9%), friction 14.1% vs 12.6%, Mac/web 4.1% vs 3.2%, more 'best' (9.6% vs 6.3%) and generic praise (14.6% vs 7.5%); in high-spend markets people pay and then hit portability and integrity problems, elsewhere more stop at the gate

- **Where:** §7.4 Group A — high-spend markets (us, cn, jp, gb, de, fr, ca, au, kr; external-knowledge definition) (verbatim table): high-spend 2,289 (58.1%) mean 3.60, 5★ 46.5, 1★ 20.2, cap 4.9, friction 12.6, price obj 5.2, payer 12.8, not granted 2.4, billing 4.9, CN 7.6, login 5.8, Watch 3.2, Mac/web 3.2, acct-del 1.7, best 6.3, generic 7.5; rest of world (90 storefronts) 1,650 (41.9%) 3.93, 59.3, 14.8, cap 6.1, friction 14.1, price 5.2, payer 8.2, not granted 0.8, billing 2.1, CN 0.0, login 1.2, Watch 1.6, Mac/web 4.1, acct-del 0.5, best 9.6, generic 14.6 — findings: 1. high-spend rate lower (3.60 vs 3.93), about half the gap is China (≈3.70 without cn); 2. what differs is what money buys — high-spend 1.6× payers, 3× Premium not granted, 2.3× billing integrity, 2× Watch and account deletion; price objection identical (5.2% vs 5.2%); 3. rest of world reports access and affordability — the cap (6.1% vs 4.9%) and more generic praise; in high-spend markets people pay then hit portability and integrity problems, elsewhere more stop at the gate
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Group | n | mean | 5★% | 1★% | cap | mon-friction | price obj. | payer | not granted | billing-int. | CN | login | Watch | Mac/web | acct-del | best | generic ; High-spend | 2,289 (58.1%) | 3.60 | 46.5 | 20.2 | 4.9 | 12.6 | 5.2 | 12.8 | 2.4 | 4.9 | 7.6 | 5.8 | 3.2 | 3.2 | 1.7 | 6.3 | 7.5 ; Rest of world (90 storefronts) | 1,650 (41.9%) | 3.93 | 59.3 | 14.8 | 6.1 | 14.1 | 5.2 | 8.2 | 0.8 | 2.1 | 0.0 | 1.2 | 1.6 | 4.1 | 0.5 | 9.6 | 14.6
- **Direction for us:** none · **Report confidence:** external definition, disclosed · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R33-178 — Sub-50 storefronts, limited evidence: Taiwan (26, 3.27) is the lowest-rated storefront with ≥15 reviews (notes moved to Premium; lifetime bought but no count habits; 'My data and life-time access were both deleted'); Netherlands (49, 3.35) — price and cap, motivational copy 'far too American and over the top'; Italy (37, 3.65) — cap and price ('43 euro … Per una agenda???'); Switzerland (31, 3.84) — the probable duplicate 'Update is worse' pair and a 2023 spam complaint; Singapore (21, 3.76) — freezes, support 'not yet seen' for 4 days, lifetime regret; Thailand (29, 4.28) and Malaysia (21, 4.57) — strongly positive on design and simplicity; Arabic-language users (Egypt, Saudi Arabia) ask for an Arabic UI

- **Where:** §7.6 Sub-50 storefronts [limited evidence] — Taiwan (26, 3.27) lowest-rated with ≥15 reviews (notes moved to Premium; lifetime bought but no count habits; 'My data and life-time access were both deleted'); Netherlands (49, 3.35) price and cap, motivational copy 'far too American and over the top'; Italy (37, 3.65) cap and price ('43 euro … Per una agenda???'); Switzerland (31, 3.84) the probable duplicate 'Update is worse' pair and a 2023 spam complaint; Singapore (21, 3.76) freezes, support 'not yet seen' for 4 days, lifetime regret; Thailand (29, 4.28) and Malaysia (21, 4.57) strongly positive; Arabic-language users ask for an Arabic UI (Egypt, Saudi Arabia)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as listed
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `4166681642`, `4435992248`, `6934749412`, `3870589285`, `5884634297`, `6428238618`, `6428288301`, `10094809568`, `6118170712`, `7723922183`, `6209402227`, `6623437123`, `8971467237`
- **Canonical:** C027 Localise early — it unlocks revenue; C095 Neutral, non-judgemental tone on failure

### R33-179 — Motivational notification copy does not travel across cultures: a Dutch reviewer found it 'far too American and over the top'

- **Where:** §7.6 Motivational copy does not travel — Netherlands: 'far too American and over the top'; guilt copy disliked (Part 9 #8)
- **This app does:** US-toned motivational copy
- **User reaction:** complaint
- **Magnitude:** 1 named
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `3870589285`
- **Canonical:** C027 Localise early — it unlocks revenue; C095 Neutral, non-judgemental tone on failure

### R33-180 — What genuinely varies by storefront: cannot use the service without a VPN — cn 57.8% vs ≈0 everywhere else; subscription-principle objection — de 9.2%, pl 4.6%, gb 3.1% vs jp 0.4%, kr/in/br/es 0%; price objection — de 14.7%, tr 10.5%, fr 10.4%, es 8.9%, ru 8.8% vs us 3.3%, in 3.1%, cn 3.0%; free cap — es 10.7%, gb 10.5%, br 10.5%, mx 8.8% vs cn 0%, ua 1.7%, vn 2.5%; payer share — br 18.1%, in 17.7%, jp 16.0% vs vn 2.5%, mx 4.4%; Mac/web problems — ru 10.1%, fr 7.8%, ua 6.9% vs tr/es 0%; account-deletion failure — kr 5.5%, de 3.7% vs us 0.5%; marketing-email complaint — de 6.4% vs global 0.9%; localisation complaint — ru 5.0%, de 3.7%, es 3.6%, jp 3.1%; happiest — vn 4.61, kr 4.20, tr 4.19, ua 4.16 (with high generic shares); no cultural generalisation beyond these measured differences

- **Where:** §7.7 What genuinely varies by storefront (verbatim table) — cannot use without a VPN cn 57.8% vs ≈0 elsewhere; subscription-principle objection de 9.2%, pl 4.6%, gb 3.1% vs jp 0.4%, kr/in/br/es 0%; price objection de 14.7%, tr 10.5%, fr 10.4%, es 8.9%, ru 8.8% vs us 3.3%, in 3.1%, cn 3.0%; free cap es 10.7%, gb 10.5%, br 10.5%, mx 8.8% vs cn 0%, ua 1.7%, vn 2.5%; payer share br 18.1%, in 17.7%, jp 16.0% vs vn 2.5%, mx 4.4%; Mac/web app problems ru 10.1%, fr 7.8%, ua 6.9% vs tr/es 0%; account-deletion failure kr 5.5%, de 3.7% vs us 0.5%; marketing-email complaint de 6.4% vs global 0.9%; localisation complaint ru 5.0%, de 3.7%, es 3.6%, jp 3.1%; happiest vn 4.61, kr 4.20, tr 4.19, ua 4.16 (high generic shares); no cultural generalisation drawn
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Pattern | Where | Section ; Cannot use the service without a VPN | cn 57.8% vs ≈0 everywhere else | 4.1 ; Subscription-principle objection | de 9.2%, pl 4.6%, gb 3.1% vs jp 0.4%, kr/in/br/es 0% | 4.2 ; Price objection | de 14.7%, tr 10.5%, fr 10.4%, es 8.9%, ru 8.8% vs us 3.3%, in 3.1%, cn 3.0% | 3.3 ; Free cap | es 10.7%, gb 10.5%, br 10.5%, mx 8.8% vs cn 0%, ua 1.7%, vn 2.5% | 4.2 ; Payer share | br 18.1%, in 17.7%, jp 16.0% vs vn 2.5%, mx 4.4% | 6 ; Mac/web app problems | ru 10.1%, fr 7.8%, ua 6.9% vs tr/es 0% | 4.4 ; Account-deletion failure | kr 5.5%, de 3.7% vs us 0.5% | 4.6 ; Marketing-email complaint | de 6.4% vs global 0.9% | 4.6 ; Localisation complaint | ru 5.0%, de 3.7%, es 3.6%, jp 3.1% | 2.4 ; Happiest storefronts | vn 4.61, kr 4.20, tr 4.19, ua 4.16 (with high generic shares) | 7.3
- **Direction for us:** none · **Report confidence:** measured differences · **Generalisable:** app-specific
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R33-199 — China is winnable with a reachable backend: Chinese reviewers praise the design and localisation and ask to pay ('I'd pay 188 RMB lifetime if you fixed the server'; 'I want to pay but doubt it works in China')

- **Where:** Part 9 #7 — China is winnable with a reachable backend: Chinese reviewers praise the design and localisation and ask to pay
- **This app does:** blocked backend
- **User reaction:** blocked-conversion
- **Magnitude:** 173
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `5602217006`, `13572613236`
- **Canonical:** C132 Do not sell in a storefront where the app cannot function

### R33-225 — Localisation QA for Japanese, German, French, Polish and Spanish, and local-language support replies

- **Where:** Part 10 #25 §10.6 [7.3]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 62 localisation
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `3253608656`, `5481722444`, `8322104956`, `7596083103`
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R33-009 — Redesigns repeatedly removed what paying users relied on: regression — 'an update made it worse' or 'a feature was removed' — 197 reviews (5.00%), mean 2.51, concentrated in five events: v2.0 (Nov 2016) removed the charity feature and wiped data; Apr 2019 moved notes and skip behind the paywall and free users lost 300 days of notes; 'Habitify X' (late Aug 2020) removed the timer and time-log data, yearly and daily-ratio stats, CSV export, swipe between days and 'N times per week', and broke the Watch app — 149 reviews in nine weeks, 42 of them UPDATE-; the notes redesign (Dec 2024 – Jan 2025) stopped notes being back-dated or edited; the May 2025 widget redesign

- **Where:** Executive summary #5 — redesigns repeatedly removed what paying users relied on: regression 197 (5.00%), mean 2.51, in five events — v2.0 Nov 2016 (charity feature removed, data wiped); Apr 2019 notes and skip moved behind the paywall, free users lost 300 days of notes; 'Habitify X' late Aug 2020 (timer and time-log data, yearly and daily-ratio stats, CSV export, swipe between days and 'N times per week' removed, Watch app broke; 149 reviews in nine weeks, 42 UPDATE-); notes redesign Dec 2024 – Jan 2025 (notes can no longer be back-dated or edited); May 2025 widget redesign
- **This app does:** five removal events
- **User reaction:** churn
- **Magnitude:** 197 (5.00%), 2.51; Habitify X 149 in 9 weeks (42 UPDATE-)
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1494883584`, `1493584000`, `4002480223`, `6373708406`, `6372859679`, `6461110648`, `12185327521`, `12129630081`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R33-015 — 169 edited reviews, several dated update logs — four dated additions Jan–Feb 2020; four successive reviews in 2021; a 1★ raised to 4★ after a fix

- **Where:** §1.3 is_edited — 169 records treated as normal; several are dated update logs (four dated additions Jan–Feb 2020; four successive reviews 2021; 1★ → 4★ after a fix)
- **This app does:** fixes recover ratings
- **User reaction:** mixed
- **Magnitude:** 169 is_edited
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `5516255548`, `7572082701`, `7656211283`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R33-017 — Per year: 2016 (from 3 Aug) n=136 mean 3.50 (39.7% 5★, 20.6% 1★); 2017 157, 3.59; 2018 571, 3.72 (51.0% 5★); 2019 722, 4.04 (60.8% 5★, 13.3% 1★ — the best year); 2020 815, 3.78 (the busiest); 2021 310, 3.50; 2022 205, 3.32 (28.8% 1★ — the worst year); 2023 212, 3.60; 2024 219, 3.90; 2025 378, 3.75; 2026 (to 2 Sep) 214, 3.61; substantive means 3.12–3.97; short reviews 13.4–25.8%; top scripts Latin, then ja / zh / ko

- **Where:** §1.6 By year table (verbatim) — 2016 136 at 3.50; 2017 157, 3.59; 2018 571, 3.72; 2019 722, 4.04 (60.8% 5★); 2020 815, 3.78; 2021 310, 3.50; 2022 205, 3.32 (28.8% 1★); 2023 212, 3.60; 2024 219, 3.90; 2025 378, 3.75; 2026 214, 3.61; short share 13.4–25.8%; scripts Latin, ja, zh, ko
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | mean | 5★ % | 1★ % | substantive mean | short % | top scripts ; 2016 (from 3 Aug) | 136 | 3.50 | 39.7 | 20.6 | 3.39 | 14.0 | Latin 92, ja 22, zh 13 ; 2017 | 157 | 3.59 | 42.0 | 19.1 | 3.63 | 13.4 | Latin 100, ja 22, zh 20 ; 2018 | 571 | 3.72 | 51.0 | 19.1 | 3.97 | 22.1 | Latin 366, zh 98, ja 51 ; 2019 | 722 | 4.04 | 60.8 | 13.3 | 3.90 | 25.8 | Latin 439, ja 106, ko 71 ; 2020 | 815 | 3.78 | 54.0 | 17.4 | 3.58 | 22.9 | Latin 499, ko 122, ja 102 ; 2021 | 310 | 3.50 | 43.9 | 20.6 | 3.43 | 16.8 | Latin 206, ja 52 ; 2022 | 205 | 3.32 | 43.9 | 28.8 | 3.12 | 17.1 | Latin 153, ja 21 ; 2023 | 212 | 3.60 | 49.1 | 21.2 | 3.34 | 17.0 | Latin 174, ja 12 ; 2024 | 219 | 3.90 | 57.1 | 15.1 | 3.73 | 16.4 | Latin 176, ja 22 ; 2025 | 378 | 3.75 | 51.6 | 16.4 | 3.59 | 20.4 | Latin 305, ja 31 ; 2026 (to 2 Sep) | 214 | 3.61 | 48.6 | 18.2 | 3.46 | 21.0 | Latin 166, ja 20
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R33-018 — Eras from product events: E1 (3 Aug 2016 → 16 Jan 2019 — one-time Premium; charity feature and v2.0 wipe; China registration block; Jan 2018 purchase wave; Mac app; Oct 2018 5★ burst) n=929 (23.58%), mean 3.64, 5★ 46.9%, 1★ 19.6%; E2 (17 Jan 2019 → 26 Aug 2020 — subscription replaces one-time; lifetime restored Apr 2019; notes/skip gated; timer; areas; account-deletion failures) 1,252 (31.78%), 4.06, 61.7% / 12.9%; E3 (27 Aug 2020 → 2021 — 'Habitify X' redesign; weekly check-in cap; iOS 14 widgets; Mac app stalls; mood log) 530 (13.46%), 3.36, 41.1% / 23.6%; E4 (2022–2023 — Mac sign-in / sync failures fixed by macOS 13.0.1; Watch complication; July 2023 e-mail wave) 417 (10.59%), 3.47, 46.5% / 24.9%; E5 (2024 → 2 Sep 2026 — Watch sync fixed; notes redesign; May 2025 widgets; Sep 2025 crash; AI; 2-habit free tier; ¥19,000 lifetime) 811 (20.59%), 3.75, 52.3% / 16.5%; substantive means 3.24–3.91

- **Where:** §1.6 Eras table (verbatim) — E1 2016-08-03 → 2019-01-16 one-time Premium, charity feature and v2.0 wipe, China registration block, Jan 2018 purchase wave, Mac app, Oct 2018 5★ burst, 929 at 3.64; E2 2019-01-17 → 2020-08-26 subscription replaces one-time, lifetime restored Apr 2019, notes/skip gated, timer, areas, account-deletion failures, 1,252 at 4.06; E3 2020-08-27 → 2021-12-31 Habitify X, weekly check-in cap, iOS 14 widgets, Mac app stalls, mood log, 530 at 3.36; E4 2022–2023 Mac sign-in/sync failures fixed by macOS 13.0.1, Watch complication, July 2023 email wave, 417 at 3.47 (24.9% 1★); E5 2024 → 2026-09-02 Watch sync fixed, notes redesign, May 2025 widgets, Sep 2025 crash, AI, 2-habit free tier, ¥19,000 lifetime, 811 at 3.75
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era | Window | What reviewers describe | n | % | mean | 5★ % | 1★ % | subst. mean ; E1 | 2016-08-03 → 2019-01-16 | One-time Premium; charity feature and v2.0 wipe; China registration block; Jan 2018 purchase wave; Mac app; Oct 2018 5★ burst | 929 | 23.58% | 3.64 | 46.9 | 19.6 | 3.79 ; E2 | 2019-01-17 → 2020-08-26 | Subscription replaces one-time; lifetime restored Apr 2019; notes/skip gated; timer; areas; account-deletion failures | 1,252 | 31.78% | 4.06 | 61.7 | 12.9 | 3.91 ; E3 | 2020-08-27 → 2021-12-31 | "Habitify X" redesign; weekly check-in cap; iOS 14 widgets; Mac app stalls; mood log | 530 | 13.46% | 3.36 | 41.1 | 23.6 | 3.24 ; E4 | 2022-01-01 → 2023-12-31 | Mac sign-in / sync failures, fixed by macOS 13.0.1; Watch complication; July 2023 email wave | 417 | 10.59% | 3.47 | 46.5 | 24.9 | 3.24 ; E5 | 2024-01-01 → 2026-09-02 | Watch sync fixed; notes redesign; May 2025 widgets; Sep 2025 crash; AI; 2-habit free tier; ¥19,000 lifetime | 811 | 20.59% | 3.75 | 52.3 | 16.5 | 3.60
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C001 Never move a free feature behind the paywall; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R33-020 — Review volume is event-shaped: busiest months 2018-10 (121, mean 4.46 — the burst), 2018-12 (111, 3.28 — the China wave), 2020-05 (109, 4.17), 2019-01 (93, 3.35 — subscription switch), 2020-09 (83, 3.23 — Habitify X); busiest days 12 Oct 2018 (32, 4.81), 30 Dec 2018 (15, 12 from China), 14 Dec 2018 (13, 2.23), 30 Nov 2016 (10 — the v2.0 data wipe), 5 Jul 2023 (9, 1.67 — e-mail spam); 99 storefronts, eighteen above 50 reviews holding 3,190 (81.0%): us 610 · jp 524 · cn 296 · kr 292 · gb 162 · ru 159 · vn 158 · ca 132 · in 130 · de 109 · br 105 · mx 91 · pl 87 · au 87 · fr 77 · ua 58 · tr 57 · es 56; the other 81 hold 749 (19.0%)

- **Where:** §1.6 Volume — busiest months 2018-10 (121, mean 4.46, the burst), 2018-12 (111, 3.28, the China wave), 2020-05 (109, 4.17), 2019-01 (93, 3.35, subscription switch), 2020-09 (83, 3.23, Habitify X); busiest days 2018-10-12 (32, 4.81), 2018-12-30 (15, 12 from China), 2018-12-14 (13, 2.23), 2016-11-30 (10, v2.0 wipe), 2023-07-05 (9, 1.67, email spam); storefronts 99 — eighteen clear the 50-review bar with 3,190 (81.0%): us 610 · jp 524 · cn 296 · kr 292 · gb 162 · ru 159 · vn 158 · ca 132 · in 130 · de 109 · br 105 · mx 91 · pl 87 · au 87 · fr 77 · ua 58 · tr 57 · es 56; the other 81 hold 749 (19.0%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as listed
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C132 Do not sell in a storefront where the app cannot function

### R33-026 — The business timeline reviewers lived: Aug 2016 launch — free tier 3 habits (some say 2 or 1), one-time Premium ~$3–4 / €4 / 25 RMB, charity points; 29 Nov 2016 v2.0 — charity removed, history wiped for many, login now required, some Premium lost; 2017 — skip and notification actions removed, 14-day histogram removed, Russian UI lost, v3.0 (Sep), multiple reminders (Oct); Nov 2017 – Jan 2018 review-prompt nagging ('three in 10 seconds'); Jan 2018 purchase not applied — 21 reviews, 11 from Japan, fixed by ~27 Jan; Jun – Dec 2018 mainland China cannot register or log in without a VPN, worst after the Dec 2018 'Today' feature; Sep 2018 price rise 30 → 45 RMB, +¥500; Oct 2018 Mac app, the 5★ burst naming 'Peter', a rating-request e-mail; 17 Jan 2019 one-time Premium replaced by subscription, recent buyers get one year; Apr 2019 v5.5 — lifetime option restored, iPad layout, streak on journal, notes and skip moved to Premium; Jun – Sep 2019 new app icon disliked, v6.0; Oct 2019 iOS 13 breaks notifications, Watch and Touch ID, timer launched buggy; Dec 2019 – 2020 areas, account deletion spins forever (23 reviews in 2020), marketing e-mail; May 2020 new UI and icon, a German string 'Pisst du dabei?'; ~27 Aug 2020 'Habitify X' (v10) — time logs, yearly stats, export, swipe and 'N per week' removed, Watch and Shortcuts break, multi-check-in goals added; Oct 2020 weekly check-in cap for free users; 2021 — Mac app stops syncing, reorder breaks in v10.7.4–10.7.5, Watch fixed (Jun), mood log (Aug), timer returns, icon-rich redesign (Sep); 2022 — Mac app cannot sign in ('waiting for v11 macOS'), Watch complication broken since iOS 15.1; Dec 2022 – Feb 2023 macOS 13.0.1 fixes sign-in with a new Mac UI; Jul 2023 e-mail spam to dormant/deleted users, unsubscribe added after complaints; Jan 2024 Watch sync 'finally' fixed; Dec 2024 – Jan 2025 notes redesign removes back-dating and editing; May 2025 widget redesign removes incremental and streak widgets; 11 Sep 2025 'Liquid glass' update crashes on launch (iOS 18), fixed in ~1–3 days; Jan 2026 'Are you sure the day is over?' pop-up on fail/skip, reorder broken, free tier reported as 2 habits; 2026 lifetime ¥19,000 in Japan, AI-only support replies

- **Where:** §2.2 Timeline of the business (verbatim table) — Aug 2016 launch, free 3 habits, one-time Premium ~$3–4 / €4 / 25 RMB, charity points → 29 Nov 2016 v2.0 charity removed, history wiped, login required, some Premium lost → 2017 skip, notification actions, 14-day histogram, Russian UI removed; v3.0; multiple reminders → Nov 2017 – Jan 2018 review-prompt nagging ('three in 10 seconds') → Jan 2018 purchase not applied (21, 11 jp) fixed ~27 Jan → Jun–Dec 2018 China cannot register without VPN, worst after Dec 2018 'Today' feature → Sep 2018 30 → 45 RMB → Oct 2018 Mac app, 5★ burst naming Peter, rating-request email → 17 Jan 2019 subscription replaces one-time → Apr 2019 v5.5 lifetime restored, iPad layout, notes and skip to Premium → Jun–Sep 2019 new icon disliked, v6.0 → Oct 2019 iOS 13 breaks notifications, Watch, Touch ID; timer → Dec 2019 – 2020 areas, account deletion spins forever (23 in 2020), marketing email → May 2020 new UI, 'Pisst du dabei?' → ~27 Aug 2020 Habitify X v10 → Oct 2020 weekly check-in cap → 2021 Mac stops syncing, reorder breaks v10.7.4–10.7.5, Watch fixed, mood log, timer returns, icon-rich redesign → 2022 Mac cannot sign in, Watch complication broken since iOS 15.1 → Dec 2022 – Feb 2023 macOS 13.0.1 fix → Jul 2023 email spam to dormant/deleted users, unsubscribe added → Jan 2024 Watch sync fixed → Dec 2024 – Jan 2025 notes redesign → May 2025 widget redesign removes incremental and streak widgets → 11 Sep 2025 'Liquid glass' crash on launch (iOS 18) fixed in ~1–3 days → Jan 2026 'Are you sure the day is over?' pop-up, reorder broken, free tier 2 → 2026 lifetime ¥19,000, AI-only support
- **This app does:** ten years of iterative change
- **User reaction:** mixed
- **Magnitude:** When (from reviews) | Event | Evidence ; Aug 2016 | Launch. Free tier 3 habits (some say 2 or 1); one-time Premium ~$3–4 / €4 / 25 RMB; charity points | 1461098314, 1468380047, 1470008848, 1465696397 ; 29 Nov 2016 (v2.0) | Charity removed; history wiped for many; login now required; some Premium lost | 1494883584, 1493584000, 1493125287, 1500907322, 1495393864 ; 2017 | Skip and notification actions removed; 14-day histogram removed; Russian UI lost; v3.0 (Sep); multiple reminders (Oct) | 1592152210, 1516426571, 1552349488, 1811412629, 1821856292 ; Nov 2017 – Jan 2018 | Review-prompt nagging ("three in 10 seconds") | 1973100159, 2049009103, 2049455058 ; Jan 2018 | Purchase not applied — 21 reviews, 11 from Japan; fixed by ~27 Jan | 2083040453, 2092713521, 2093117380, 2132082291 ; Jun – Dec 2018 | Mainland China cannot register or log in without a VPN; worst after the Dec 2018 "Today" feature | 2756845405, 3528438035, 3541075226 ; Sep 2018 | Price rise: 30 → 45 RMB; +¥500 | 3143812831, 3230217843 ; Oct 2018 | Mac app; 5★ burst naming "Peter"; rating-request email | 3294014241, 3356614111, 3367548037 ; 17 Jan 2019 | One-time Premium replaced by subscription; recent buyers get one year | 3619346514, 3662823096, 3674478475, 3678780341 ; Apr 2019 (v5.5) | Lifetime option restored; iPad layout; streak on journal. Notes and skip moved to Premium | 3999789474, 3995925905, 3999581807, 4002480223, 4005130935 ; Jun – Sep 2019 | New app icon disliked; v6.0 | 4387717158, 4396996014, 4819310385, 4401174963 ; Oct 2019 | iOS 13 breaks notifications, Watch and Touch ID; timer launched (buggy) | 4880936953, 4884387541, 4923042177, 5050548030 ; Dec 2019 – 2020 | Areas; account deletion spins forever (23 reviews in 2020); marketing email | 5248212573, 5202035434, 5395539035 ; May 2020 | New UI and icon; German string "Pisst du dabei?" | 5979240207, 5995366742, 5481722444 ; ~27 Aug 2020 ("Habitify X", v10) | Time logs, yearly stats, export, swipe and "N per week" removed; Watch and Shortcuts break; multi-check-in goals added | 6341543939, 6373708406, 6389260394, 6353124209 ; Oct 2020 | Weekly check-in cap for free users | 6495113718, 6515490377, 6541638912 ; 2021 | Mac app stops syncing; reorder breaks in v10.7.4–10.7.5; Watch fixed (Jun); mood log (Aug); timer returns; icon-rich redesign (Sep) | 7727790054, 7656152222, 7477852791, 7665159079, 7848207278 ; 2022 | Mac app cannot sign in ("waiting for v11 macOS"); Watch complication broken since iOS 15.1 | 8212189719, 9029892348, 8031471211 ; Dec 2022 – Feb 2023 | macOS 13.0.1 fixes sign-in and brings a new Mac UI | 9359375535, 9537687059, 9570248200 ; Jul 2023 | Email spam to dormant/deleted users; unsubscribe added after complaints | 10096299644, 10101814356, 10109604865 ; Jan 2024 | Watch sync "finally" fixed | 10842104134 ; Dec 2024 – Jan 2025 | Notes redesign removes back-dating and editing | 12001725042, 12129630081, 12185327521 ; May 2025 | Widget redesign removes incremental and streak widgets | 12703753311, 12711946464, 12832854491 ; 11 Sep 2025 | "Liquid glass" update crashes on launch (iOS 18); fixed in ~1–3 days | 13123452070, 13125502668, 13134366728, 13135420295 ; Jan 2026 | "Are you sure the day is over?" pop-up on fail/skip; reorder broken; free tier reported as 2 habits | 13665455992, 13634328613, 13701264625, 13684177637 ; 2026 | Lifetime ¥19,000 in Japan; AI-only support replies | 14106494461, 14398774902
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `1461098314`, `1468380047`, `1470008848`, `1465696397`, `1494883584`, `1493584000`, `1493125287`, `1500907322`, `1495393864`, `1592152210`, `1516426571`, `1552349488`, `1811412629`, `1821856292`, `1973100159`, `2049009103`, `2049455058`, `2083040453`, `2092713521`, `2093117380`, `2132082291`, `2756845405`, `3528438035`, `3541075226`, `3143812831`, `3230217843`, `3294014241`, `3356614111`, `3367548037`, `3619346514`, `3662823096`, `3674478475`, `3678780341`, `3999789474`, `3995925905`, `3999581807`, `4002480223`, `4005130935`, `4387717158`, `4396996014`, `4819310385`, `4401174963`, `4880936953`, `4884387541`, `4923042177`, `5050548030`, `5248212573`, `5202035434`, `5395539035`, `5979240207`, `5995366742`, `5481722444`, `6341543939`, `6373708406`, `6389260394`, `6353124209`, `6495113718`, `6515490377`, `6541638912`, `7727790054`, `7656152222`, `7477852791`, `7665159079`, `7848207278`, `8212189719`, `9029892348`, `8031471211`, `9359375535`, `9537687059`, `9570248200`, `10096299644`, `10101814356`, `10109604865`, `10842104134`, `12001725042`, `12129630081`, `12185327521`, `12703753311`, `12711946464`, `12832854491`, `13123452070`, `13125502668`, `13134366728`, `13135420295`, `13665455992`, `13634328613`, `13701264625`, `13684177637`, `14106494461`, `14398774902`
- **Canonical:** C001 Never move a free feature behind the paywall; C054 Never run incentivised / review-for-premium campaigns; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C132 Do not sell in a storefront where the app cannot function; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R33-027 — A launch crash fixed in 1–3 days does little lasting damage: the 11 Sep 2025 'Liquid glass' update crashed on launch on iOS 18 and was fixed in about 1–3 days, with no lasting rating shift in 2025 (3.75)

- **Where:** §2.2 11 Sep 2025 'Liquid glass' update crashes on launch (iOS 18); fixed in ~1–3 days
- **This app does:** fast hotfix
- **User reaction:** complaint
- **Magnitude:** Sep 2025 crash window; 2025 mean 3.75
- **Direction for us:** must-never-break · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13123452070`, `13125502668`, `13134366728`, `13135420295`
- **Canonical:** C031 Crashes / launch failures; C059 Be visibly responsive; fixes bring reviewers back

### R33-182 — Sentiment dipped in 2020–23 and largely recovered: mean 3.64 (E1) → 4.06 (E2) → 3.36 (E3) → 3.47 (E4) → 3.75 (E5); substantive 3.79 → 3.91 → 3.24 → 3.24 → 3.60; 5★ 46.9% → 61.7% → 41.1% → 46.5% → 52.3%; 1★ 19.6% → 12.9% → 23.6% → 24.9% → 16.5% — E1 held down by China (106 connectivity reviews), the v2.0 wipe and the Jan 2018 purchase wave, and held up by the Oct 2018 burst; E2 the high point, a stable app with a lifetime option and active development; E3–E4 fall with Habitify X, the check-in cap, the Mac stall and the 2023 e-mail wave, 2022 the worst year (3.32, 28.8% 1★); E5 recovers to 3.75 despite new redesign complaints

- **Where:** §8.2 Trend 1 — sentiment dipped in 2020–23 and has largely recovered (verbatim table): mean 3.64 → 4.06 → 3.36 → 3.47 → 3.75; substantive 3.79 → 3.91 → 3.24 → 3.24 → 3.60; 5★ 46.9% → 61.7% → 41.1% → 46.5% → 52.3%; 1★ 19.6% → 12.9% → 23.6% → 24.9% → 16.5% — E1 held down by China (106 connectivity), the v2.0 wipe and the Jan 2018 purchase wave, held up by the Oct 2018 burst; E2 the high point — a stable app with a lifetime option and active development; E3–E4 fall with Habitify X, the check-in cap, the Mac stall and the 2023 email wave; 2022 the worst year (3.32, 28.8% 1★); E5 recovers to 3.75 despite new redesign complaints
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Series | E1 | E2 | E3 | E4 | E5 ; Mean (all) | 3.64 | 4.06 | 3.36 | 3.47 | 3.75 ; Mean (substantive) | 3.79 | 3.91 | 3.24 | 3.24 | 3.60 ; 5★ share | 46.9% | 61.7% | 41.1% | 46.5% | 52.3% ; 1★ share | 19.6% | 12.9% | 23.6% | 24.9% | 16.5%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R33-184 — Money complaints track the take-backs: monetisation friction 9.0% (E1) → 17.3% (E2) → 14.0% → 7.2% → 14.4%; free cap 4.6% → 6.5% → 5.1% → 3.4% → 5.8% (9.3% in 2026); price objection 2.3% → 8.4% → 6.0% → 2.9% → 4.1%; subscription objection 0.1% → 2.6% → 0.6% → 0.2% → 0.1%; weekly check-in cap 4.2% (E3) → 0.2% → 0.7%; upsell surfaces 0.4% → 0.1% → 0.2% → 0.5% → 1.7%; one-time / lifetime praised 3.0% → 0.6% → 0.9% → 0.5% → 1.0%; price praised 1.9% → 2.5% → 2.6% → 2.4% → 3.2% — each spike aligns with a dated change (the subscription switch, 29 objections in 2019; the check-in cap, 14 in 2020 and 8 in 2021; the 2025–26 upsell banners and 2-habit tier), and price praise never fell because the lifetime option kept a satisfied paying base

- **Where:** §8.4 Trend 3 — money complaints track the take-backs (verbatim table): friction 9.0% → 17.3% → 14.0% → 7.2% → 14.4%; free cap 4.6 → 6.5 → 5.1 → 3.4 → 5.8 (2026 9.3%); price objection 2.3 → 8.4 → 6.0 → 2.9 → 4.1; subscription objection 0.1 → 2.6 → 0.6 → 0.2 → 0.1; weekly check-in cap E3 4.2, E4 0.2, E5 0.7; upsell surfaces 0.4 → 0.1 → 0.2 → 0.5 → 1.7; one-time / lifetime praised 3.0 → 0.6 → 0.9 → 0.5 → 1.0; price praised 1.9 → 2.5 → 2.6 → 2.4 → 3.2 — each spike aligns with a dated change (subscription switch: 29 objections in 2019; check-in cap 14 in 2020, 8 in 2021; 2025–26 upsell banners and 2-habit tier); price praise never fell — the lifetime option kept a satisfied paying base
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | E1 | E2 | E3 | E4 | E5 ; Monetisation friction (union) | 9.0% | 17.3% | 14.0% | 7.2% | 14.4% ; Free cap | 4.6% | 6.5% | 5.1% | 3.4% | 5.8% (2026: 9.3%) ; Price objection | 2.3% | 8.4% | 6.0% | 2.9% | 4.1% ; Subscription objection | 0.1% | 2.6% | 0.6% | 0.2% | 0.1% ; Weekly check-in cap | — | — | 4.2% | 0.2% | 0.7% ; Upsell surfaces | 0.4% | 0.1% | 0.2% | 0.5% | 1.7% ; One-time / lifetime praised | 3.0% | 0.6% | 0.9% | 0.5% | 1.0% ; Price praised | 1.9% | 2.5% | 2.6% | 2.4% | 3.2%
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase

### R33-185 — Cross-device problems peaked in 2020–23 and fell after fixes: platform issues 3.7% (E1) → 4.7% → 18.7% → 19.9% → 9.7%; Mac / web 0.8% → 1.8% → 7.9% → 12.2% → 2.2% (the macOS 13.0.1 fix); sync 1.4% → 1.7% → 6.2% → 7.9% → 2.3%; Watch 1.2% → 1.6% → 6.8% → 4.6% → 1.7% (the Jan 2024 fix); widgets 0.8% → 0.4% → 4.2% → 2.2% → 5.2% — the one surface still worsening after the May 2025 redesign (6.3% of 2025)

- **Where:** §8.5 Trend 4 — cross-device problems peaked in 2020–23 (verbatim table): platform issues 3.7% → 4.7% → 18.7% → 19.9% → 9.7%; Mac / web 0.8 → 1.8 → 7.9 → 12.2 → 2.2; sync 1.4 → 1.7 → 6.2 → 7.9 → 2.3; Watch 1.2 → 1.6 → 6.8 → 4.6 → 1.7; widget 0.8 → 0.4 → 4.2 → 2.2 → 5.2 — the Mac fix (13.0.1) and the Watch fix (Jan 2024) show clearly in E5; widgets are the one surface still worsening (May 2025 redesign; 6.3% of 2025)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | E1 | E2 | E3 | E4 | E5 ; Platform issues (union) | 3.7% | 4.7% | 18.7% | 19.9% | 9.7% ; Mac / web app | 0.8% | 1.8% | 7.9% | 12.2% | 2.2% ; Sync | 1.4% | 1.7% | 6.2% | 7.9% | 2.3% ; Watch | 1.2% | 1.6% | 6.8% | 4.6% | 1.7% ; Widget | 0.8% | 0.4% | 4.2% | 2.2% | 5.2%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-186 — Regressions come in release-shaped spikes: regression union 3.8% (E1) → 2.2% → 14.9% (E3) → 3.8% → 4.8%; 'update made it worse' by year 2016 8.8% · 2017 8.9% · 2018 0.2% · 2019 1.7% · 2020 7.6% · 2021 6.5% · 2022 3.4% · 2023 3.8% · 2024 2.3% · 2025 5.8% · 2026 3.3% — each spike maps to one release: v2.0, the 2017 changes, Habitify X, and the 2025 notes and widget redesigns

- **Where:** §8.6 Trend 5 — regressions come in release-shaped spikes: union 3.8% (E1) → 2.2% → 14.9% (E3) → 3.8% → 4.8%; 'update made it worse' by year 2016 8.8% · 2017 8.9% · 2018 0.2% · 2019 1.7% · 2020 7.6% · 2021 6.5% · 2022 3.4% · 2023 3.8% · 2024 2.3% · 2025 5.8% · 2026 3.3%; each spike maps to one release — v2.0, the 2017 changes, Habitify X, the 2025 notes and widget redesigns
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 14.9% E3; 7.6% 2020; 5.8% 2025
- **Direction for us:** must-never-break · **Report confidence:** very strong in E3 · **Generalisable:** yes
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace; C175 Updates must not break function or wipe progress

### R33-187 — Account and data trust — one bad year per failure: union 0.8% (E1) → 2.9% → 3.4% → 7.9% (E4) → 1.0%; account deletion 23 reviews in 2020 (2.8% of the year), 10 in 2023, 1–2 a year since; marketing e-mail 27 in 2023 (12.7% of that year), 1 in 2024; privacy 2.4% of E4 — both failures were largely fixed after their spike, with residual cases continuing

- **Where:** §8.7 Trend 6 — account and data trust, one bad year per failure: union 0.8% → 2.9% → 3.4% → 7.9% → 1.0%; account deletion 23 in 2020 (2.8% of the year), 10 in 2023, 1–2 a year since; marketing email 27 in 2023 (12.7%), 1 in 2024; privacy 2.4% of E4; both largely fixed after their spike, residual cases continue
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 7.9% E4; 23 in 2020; 27 in 2023
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11244516686`, `12515577285`
- **Canonical:** C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R33-188 — Entitlement failure improved and stayed improved: billing integrity 5.1% (E1) → 2.7% → 5.5% → 3.4% → 2.8%; Premium not granted 3.6% → 0.9% → 1.9% → 1.2% → 1.2% — the 2018 store-purchase defect did not recur at scale, and what remains in E5 is cross-platform / web-purchase portability and auto-converting trials

- **Where:** §8.8 Trend 7 — entitlement failure improved and stayed improved: billing integrity 5.1% → 2.7% → 5.5% → 3.4% → 2.8%; Premium not granted 3.6% (E1) → 0.9% → 1.9% → 1.2% → 1.2%; the 2018 store-purchase defect did not recur at scale; what remains in E5 is cross-platform / web-purchase portability and auto-converting trials
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 3.6% → 1.2%
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13400575929`, `13516370858`, `13732504298`, `13422214812`, `14019544061`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R33-189 — Demand shifted from 'more habit types' to 'integrations and polish': multiple completions / quantities 2.9% (E1) → 1.8% → 0.2% → 0.2% → 0.1% and scheduling 4.1% → 1.8% → 0.9% → 1.2% → 1.4% after multi-check-in goals (Aug 2020) and every-N-days frequency shipped; widget requests 0.1% → 1.1%; Health integration poor / gated 0.1% → 2.2% (sleep double-counting); integrations mentioned 0.1% → 2.5% (Garmin, Fitbit, interactive widgets)

- **Where:** §8.9 Trend 8 — demand shifted from 'more habit types' to 'integrations and polish' (verbatim table): multiple completions / quantities 2.9% → 1.8% → 0.2% → 0.2% → 0.1%; scheduling 4.1 → 1.8 → 0.9 → 1.2 → 1.4; widget request 0.1 → 0.1 → 1.5 → 1.2 → 1.1; Health integration poor / gated 0.1 → 0.0 → 0.8 → 1.4 → 2.2; integrations mentioned 0.1 → 0.6 → 1.9 → 1.9 → 2.5 — two of the largest early requests substantially answered (multi-check-in goals Aug 2020, every-N-days frequency); later demand concerns Health accuracy (sleep double-counting), wearables (Garmin, Fitbit) and interactive widgets
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Request / theme | E1 | E2 | E3 | E4 | E5 ; Multiple completions / quantities | 2.9% | 1.8% | 0.2% | 0.2% | 0.1% ; Scheduling | 4.1% | 1.8% | 0.9% | 1.2% | 1.4% ; Widget request | 0.1% | 0.1% | 1.5% | 1.2% | 1.1% ; Health integration poor / gated | 0.1% | 0.0% | 0.8% | 1.4% | 2.2% ; Integrations mentioned | 0.1% | 0.6% | 1.9% | 1.9% | 2.5%
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9530252692`, `10712781996`, `8460050694`, `13975290800`, `14242881753`
- **Canonical:** C021 Apple Health integration; C046 Shortcuts / Siri / URL scheme / API; C143 Intra-day completion: tap N times to fill N/N

## Positioning

### R33-001 — Habitify: Habit Tracker (App Store ID 1111447047, 'Daily Goals, Routine & Streaks') — a Vietnamese indie team (a founder addressed as 'Peter'); free download with a 3-habit free tier (reported as 2 at several points, including from Jan 2026); a one-time Premium unlock (~$3–10) Aug 2016 → 16 Jan 2019; monthly/annual subscription from 17 Jan 2019 with a lifetime option restored Apr 2019; from Oct 2020 the free tier also caps check-ins at 15 per week; cross-promotion of the developer's other apps, no third-party ads; one account across iPhone, iPad, Watch, Mac, web, Android and Windows

- **Where:** header lines 1-9; §11.5 External sources
- **This app does:** developer of record Unstatic Ltd Co; bundle co.vuvo.habitify; extracted 8 Sep 2026; analysis 11 Sep 2026; store rank 33
- **User reaction:** praise
- **Magnitude:** 3,939 reviews · 99 storefronts · 3 Aug 2016 → 2 Sep 2026; mean 3.742; 5★ 2,044 (51.89%) / 4★ 526 / 3★ 383 / 2★ 279 / 1★ 707 (17.95%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `4721534340`, `5810323969`, `14062845602`, `3356614111`, `3393688311`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C013 Cloud sync / multi-device as the paid differentiator; C053 Custom time-of-day segments

### R33-045 — 'Best habit tracker' claim, rising in later eras

- **Where:** §3.1 theme table #11 "Best habit tracker" claim
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 303 (7.69%, high-priority), mean 4.89; E1 6.6 → E5 9.2
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against

### R33-047 — Competitor named / 'tried many' — mostly as the destination

- **Where:** §3.1 theme table #13 Competitor named / "tried many"
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 217 (5.51%, high-priority), mean 4.31; 5★ 152
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against

### R33-132 — 217 reviews (5.51%) name a competitor or say they 'tried many' — mean 4.31, 152 of them 5★ — and unlike peers in decline Habitify is mostly the destination: arrivals from Productive, Way of Life, HabitBull, Strides, Momentum, Done and Habit, Notion, HabitMinder (returned) and Streaks; departures / threats — Streaks (one-time price, iCloud sync, better Health; 'a tenth of the price'), Everyday, Fabulous, TickTick, Loop (free), Awesome Habits, Atoms, Way of Life; complements — Things, Structured, Todoist, Habitica

- **Where:** §3.6 Competitors — 217 (5.51%), mean 4.31, 152 5★; Habitify is mostly the destination — arrivals from Productive, Way of Life, HabitBull, Strides, Momentum, Done and Habit, Notion, HabitMinder (returned), Streaks; departures / threats: Streaks (one-time price, iCloud sync, better Health; 'a tenth of the price'), Everyday, Fabulous, TickTick, Loop (free), Awesome Habits, Atoms, Way of Life; complements Things, Structured, Todoist, Habitica
- **This app does:** net destination
- **User reaction:** praise
- **Magnitude:** 217 (5.51%), 4.31; 152 5★
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `2077625655`, `3440017816`, `4902293402`, `2052461760`, `4100540802`, `5421125900`, `5932629140`, `4733753637`, `5436429394`, `9963220481`, `7749321554`, `14040060412`, `3619346514`, `4004922568`, `7997487916`, `11264323131`, `9545911562`, `8330729266`, `6837148923`, `12871409625`, `13779571391`, `13606005182`, `11598703636`, `8215055300`, `1811412629`, `8482240585`, `6565634510`, `10113019619`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C005 Know which competitors buyers compare against

### R33-194 — A lifetime price is a moat: it is the single most-cited purchase trigger (112 payers), and rivals that only rent are named as the reason people chose Habitify

- **Where:** Part 9 #2 — a lifetime price is a moat: the single most-cited purchase trigger (112 payers); rivals that only rent are named as the reason people chose Habitify
- **This app does:** lifetime option
- **User reaction:** purchase-driver
- **Magnitude:** 112 payers
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `3440017816`, `5194210441`
- **Canonical:** C003 Lead with a one-time lifetime purchase

## Anti-patterns

### R33-033 — Troubling developer signals: review solicitation — the Oct 2018 burst, 'the CEO … asked me to write a 5star review meanwhile', a free-lifetime link after reviewing, contests and hidden-feature games that awarded Premium, 'Who the hell is peter?'; a single unverified claim of review removal ('Now I see that the developers deleted my review!!!'); cross-promotion ads for the developer's other apps shown even to lifetime payers (sibling apps Nirow — abandoned — and Poly); English-only support replies that frustrate Japanese and Chinese users; AI-only support ('Their support is AI also'; 'I received an instant AI response … never got [a human]')

- **Where:** §2.4 Signals reviewers find troubling — review solicitation (Oct 2018 burst; 'the CEO … asked me to write a 5star review meanwhile'; a free-lifetime link after reviewing; contests and hidden-feature games that awarded Premium; 'Who the hell is peter?'); review removal ('Now I see that the developers deleted my review!!!', unverified); cross-promotion ads for the developer's other apps shown even to lifetime payers (sibling apps Nirow — abandoned — and Poly); English-only support replies frustrate Japanese and Chinese users; AI support ('Their support is AI also'; 'an instant AI response … never got [a human]')
- **This app does:** solicitation, cross-promo to payers, AI support
- **User reaction:** complaint
- **Magnitude:** qualitative
- **Direction for us:** dont · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `5817575296`, `3897029485`, `3560594753`, `3868120875`, `4259261483`, `3879007615`, `7206302157`, `5469055688`, `5527838555`, `5556783335`, `11961688261`, `12158613728`, `3845038437`, `5473199522`, `13136171600`, `3618410698`, `7596083103`, `13311766586`, `13659075450`, `14106494461`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C054 Never run incentivised / review-for-premium campaigns; C055 Never gate or delete reviews; C248 Never show an upsell to anyone holding an active or historical entitlement

## Things not to do

### R33-028 — Do not add a confirmation pop-up to fail/skip logging: from Jan 2026 an 'Are you sure the day is over?' pop-up appeared on fail/skip and drew complaints alongside broken reordering

- **Where:** §2.2 Jan 2026 'Are you sure the day is over?' pop-up on fail/skip
- **This app does:** confirmation on fail/skip
- **User reaction:** complaint
- **Magnitude:** Jan 2026
- **Direction for us:** dont · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13665455992`, `13634328613`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R33-098 — Unwanted / guilt-inducing notifications, rising to 2.0% of E5

- **Where:** §3.1 theme table #64 Unwanted / guilt-inducing notifications
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 43 (1.09%, meaningful), mean 2.33
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R33-103 — Review-prompt nagging

- **Where:** §3.1 theme table #69 Review-prompt nagging
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 35 (0.89%, emerging), mean 2.60; E1 2.2%
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R33-116 — Upsell pop-ups / banners, rising to 1.7% of E5

- **Where:** §3.1 theme table #82 Upsell pop-ups / banners
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 22 (0.56%, emerging), mean 2.14
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C145 Every promotional or onboarding modal must be dismissible on the smallest screen

### R33-200 — Guilt-based notification and prompt copy backfires: 'Let's do better tomorrow, shall we?'; 'Yikes'; 'Are you sure the day is over?' — neurodivergent users say so most clearly; 43 reviews on unwanted or guilt-inducing notifications (mean 2.33)

- **Where:** Part 9 #8 — guilt-based notifications backfire: 'Let's do better tomorrow, shall we?'; 'Yikes'; 'Are you sure the day is over?'; neurodivergent users say so most clearly
- **This app does:** guilt copy
- **User reaction:** complaint
- **Magnitude:** 43 (1.09%), 2.33
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8028507816`, `10980648112`, `13665455992`, `13022842033`, `10854384133`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R33-205 — Stop incentivised or solicited reviews — rating e-mails, contests awarding Premium, and a CEO asking for 5★ (Apple guidelines are an external consideration)

- **Where:** Part 10 #5 §10.1 [Warning 3, 2.4]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 6 explicit; Oct 2018 burst
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `3367548037`, `3897029485`, `5817575296`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R33-209 — Never show upsell or cross-promotion to payers: 14 + 12 reviews

- **Where:** Part 10 #9 §10.2 [4.3, 4.2e]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 14 + 12
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `5556783335`, `10620666635`, `12606209462`
- **Canonical:** C248 Never show an upsell to anyone holding an active or historical entitlement

### R33-217 — Replace guilt copy with neutral or positive notifications, and let users choose categories: 43 reviews on unwanted or guilt notifications

- **Where:** Part 10 #17 §10.4 [9.8]
- **This app does:** see Part 10
- **User reaction:** complaint
- **Magnitude:** 43
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `12144897668`, `13606005182`
- **Canonical:** C095 Neutral, non-judgemental tone on failure

## Things to do

### R33-014 — Cheapest wins in evidence order: (1) make account deletion and e-mail unsubscribe work in one tap (47 + 37 reviews, the lowest means in the corpus); (2) make entitlements follow the Apple ID or account on every platform and make restore work; (3) never remove a feature paid users rely on without a migration path; (4) restore a free tier that lets people judge the app — e.g. 5 habits with unlimited check-ins on them; (5) keep Mac, web, Watch and widgets in feature and sync parity; (6) offer a China-reachable backend or iCloud sync; (7) stop soliciting reviews in ways that look incentivised

- **Where:** Executive summary #10 — cheapest wins, in evidence order: 1. make account deletion and email unsubscribe work in one tap (47 + 37, the lowest means); 2. make entitlements follow the Apple ID or account on every platform, and make restore work; 3. never remove a feature paid users rely on without a migration path; 4. restore a free tier that lets people judge the app (e.g. 5 habits, unlimited check-ins); 5. keep Mac, web, Watch and widgets in feature and sync parity; 6. offer a China-reachable backend or iCloud sync; 7. stop soliciting reviews in ways that look incentivised
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** ranked list
- **Direction for us:** do · **Report confidence:** summary ranking · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C054 Never run incentivised / review-for-premium campaigns; C132 Do not sell in a storefront where the app cannot function; C147 Let people use the product before they pay; C155 Never remove a feature people bought the app for — add alongside, do not replace; C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

### R33-032 — Responsiveness is real but uneven: quick, human support praised in 103 reviews (fixed after the review; 'Hana … sent me a video'; 'Zoey'; 'one minute'); a public roadmap and feature voting; developer replies visible from 2019 onward

- **Where:** §2.4 Responsiveness is real but uneven — quick human support praised 103 (fixed after the review; 'Hana … sent me a video'; 'Zoey'; 'one minute'); a public roadmap and feature voting; developer replies visible from 2019
- **This app does:** named human support; public roadmap
- **User reaction:** praise
- **Magnitude:** 103 (4.73)
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `2096151645`, `4259261483`, `6373930592`, `13306619094`, `14040060412`, `6615191705`, `7048943462`, `12492862362`, `3750834909`, `5746939879`, `13665455992`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R33-066 — Support praised

- **Where:** §3.1 theme table #32 Support praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 103 (2.61%, meaningful), mean 4.73
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

## Contradictions

### R33-145 — The same redesign both answered the biggest request and triggered the biggest regression wave: Habitify X added multi-check-in goals, answering the largest 2017–19 request ('The latest update appears to have mostly fixed my two previous concerns'), and later updates earned 'Great update' and 'Vastly improved' — the problem is removal without migration or a toggle, noticed disproportionately by long-tenure lifetime payers

- **Where:** §4.5 The same releases also drew praise — Habitify X added multi-check-in goals, answering the largest 2017–19 request ('The latest update appears to have mostly fixed my two previous concerns'); later updates earned 'Great update' and 'Vastly improved'; interpretation: the problem is removal without migration or a toggle; the long-tenure users who notice removals are disproportionately lifetime payers
- **This app does:** add + remove in one release
- **User reaction:** mixed
- **Magnitude:** update improved 112 (4.78) vs worse 170 (2.42)
- **Direction for us:** must-never-break · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `6353124209`, `6358235333`, `6413379285`, `7848207278`, `8215877352`, `9425929290`
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R33-158 — The praised qualities — simplicity, design, cross-platform, lifetime — are the same qualities the 2★/1★ reviews cite as what was lost; the product concept is not what fails, parity, portability and take-backs are

- **Where:** §5.6 The single most important cross-cutting fact — the praised qualities (simplicity, design, cross-platform, lifetime) are the same qualities cited in the 2★/1★ reviews as what was lost; the product concept is not what fails — parity, portability and take-backs are
- **This app does:** praise = loss list
- **User reaction:** mixed
- **Magnitude:** n/a
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C155 Never remove a feature people bought the app for — add alongside, do not replace; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state

## Data caveats and method

### R33-002 — Method: every one of 3,939 reviews read in full in date order in 19 batches (~200 each), in every language, and hand-coded by one analyst against a 110-code taxonomy (100 component codes + 10 unions) built inductively in batches 1–2 and extended; new codes retro-applied; a coverage script confirmed every review_id coded exactly once (first run found two skipped reviews); a 20-pattern multilingual keyword recall sweep afterwards — every candidate read — made 33 corrections; no theme count comes from keyword matching alone; theme counts are non-exclusive; aggregates by theme, band, year, era, storefront, market group and event windows (Oct 2018 burst, Dec 2018 China wave, Jan 2019 subscription switch, Habitify X, Jul 2023 email wave, Sep 2025 crash); warnings — the corpus is front-loaded (2018–2020 hold 2,108, 53.5%; 2022–23 only 417, 10.6%) so a global rate is mostly a 2018–20 rate; short reviews (≤25 chars) are 820 (20.8%), mean 4.04, 65.6% 5★, and 413 (10.5%) carry only generic praise or complaint (mean 4.69) but stay in every denominator; no version field (reviewers name v2.0, v3.0, v5.5, v6.0, Habitify X / v10.0.3, v10.7.4–10.7.7, macOS 13.0.1); payer evidence is self-selected (427, 10.84% — 212 rate 4–5★, 172 rate 1–2★); single-rater coding with no second rater; 88 MISRATE reviews (82 are 5★ reporting a bug, lost purchase or block); storefront ≠ nationality ≠ language (61 jp reviews in Latin script, 12 br in Vietnamese); unverifiable claims reported as claims; no download, revenue, retention, churn or refund-outcome data exists; no external source consulted except the high-spend market list; 3,526 (89.5%) carry a specific theme

- **Where:** How to read this; Seven warnings #1 #4 #5 #6 #7; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations; §11.5 External sources
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 3,939/3,939 coded once; 99 storefronts; 16 duplicate-text groups (50 records) kept, one substantive double submission (6428238618 / 6428288301); is_edited 169; votes on 461 records (top 3612038924 at 55; 7169126431 'Money Grab' 36; 3314289081 34; 3312785510 26; 4771857078 25)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `3612038924`, `7169126431`, `3314289081`, `3312785510`, `4771857078`, `6428238618`, `6428288301`, `1548983585`, `1556318326`, `10638299850`, `7206302157`, `6329244260`, `5437264469`, `12978195444`, `12313182001`
- **Canonical:** — (nuance register)

### R33-003 — A single storefront's problem distorts global numbers: 171 of the 173 mainland-China connectivity reviews come from cn — 57.8% of all China reviews and 79 of its 101 1★; excluding them the corpus mean is 3.81 (not 3.74) and China's is 3.77 (not 2.96)

- **Where:** Seven warnings #2 — one storefront's problem is not a product-wide problem: 171 of the 173 mainland-China connectivity reviews come from cn, 57.8% of China reviews and 79 of its 101 1★; excluding them the corpus mean is 3.81 (not 3.74) and China's 3.77 (not 2.96)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 171/173; 57.8%; 79/101 1★; 3.81; 3.77
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R33-016 — Ratings form a J-curve — 5★ 2,044 (51.89%), 4★ 526 (13.35%), 3★ 383 (9.72%), 2★ 279 (7.08%), 1★ 707 (17.95%), mean 3.742; 65.2% of reviews are 4–5★ and 25.0% are 1–2★

- **Where:** §1.6 Ratings table (verbatim) — J-curve: 5★ 2,044 (51.89%), 4★ 526 (13.35%), 3★ 383 (9.72%), 2★ 279 (7.08%), 1★ 707 (17.95%), mean 3.742; 65.2% 4–5★ and 25.0% 1–2★
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Rating | n | % ; 5★ | 2,044 | 51.89% ; 4★ | 526 | 13.35% ; 3★ | 383 | 9.72% ; 2★ | 279 | 7.08% ; 1★ | 707 | 17.95% ; Mean |  | 3.742
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R33-021 — Feature inventory with free/paid state as reviewers describe it

- **Where:** §2.1 Feature inventory table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Attested by | Free / Paid as reviewers describe it ; Daily, specific-weekday, "N times a week" and (later) every-N-days frequency | 1460574941, 1470303977, 3295388458, 5775951762, 6305379316 | Free; "N times per week" was removed in Aug 2020 and later restored (6346899859, 6458942355) ; Time-of-day sections (morning / afternoon / evening / anytime), adjustable day start | 1534629525, 2113325079, 3294233351, 5932629140 | Free ; Reminders, including repeats every 30 min until done | 1534629525, 1546230523, 1821856292 | 1 reminder per habit free; multiple reminders Premium (4583533909, 6009503696) ; Streaks, completion rates, calendar and progress charts | 1471543599, 2599530918, 3440017816, 5351195268 | Basic free; history beyond 30 days gated in 2019 (4207353472) ; Notes / journal per habit per day (from ~Oct 2018), natural-language dates | 3358156602, 3527749082, 5518407122 | Moved to Premium Apr 2019 (4002480223, 4166681642) ; Skip and fail states | 1477618808 (2016), 5981035792 | Skip removed 2017 (1592152210), later returned; Premium in 2019 (4005130935) ; Timer / stopwatch / Pomodoro (from Oct 2019) | 4883952820, 6211239705, 11200846854, 12642188195 | Free; time-log data removed in Aug 2020 (6372859679), timer restored 2021 (7749321554) ; Goals with units and multiple check-ins per day (Aug 2020) | 6353124209, 6358235333, 7713495259 | Free ; Areas / folders (Dec 2019) | 5248212573, 6137145408 | Free ; Habit stacking | 12041896476, 12086710828 | Broken for long periods (8083522711, 12195201168) ; Apple Health auto-logging (≈2020–21); Fitbit, Strava, screen-time and NFC habits (2024–26) | 6496710391, 7399087065, 14242881753, 13575307315, 13291400972, 13759922947 | Mixed: "free" (7480042765) vs "Premium" (7765702076, 14401018465) ; Mood log (Aug 2021) | 7665159079, 8151088180, 10866310493 | Multiple moods per day Premium (9696710729) ; Challenges, friends and sharing (2022+) | 8982833388, 12135068738, 13691298674 | Some challenges gated (8695467024) ; Platforms: iPhone, iPad (landscape), Apple Watch, Mac, menu-bar mini app, web, Android, Windows | 3389713889, 4003745901, 5332861460, 5952039329, 13236248497, 14040060412 | One purchase covers all, except the 2018 Mac app, which was sold separately (3301240499) ; Widgets: Today widget (2016), home-screen widgets (iOS 14, 2020), redesigned May 2025 | 1456262900, 6544400233, 12711946464 | Free ; CSV export | 2093238122, 3294255105, 9476514584 | Removed with Habitify X (6461110648, 6461863220); present again from 2022 (8267226236) ; Integrations: x-callback/Shortcuts, Zapier/IFTTT, public API, Apple/Google calendar sync | 3295311733, 7118907544, 9183367135, 12023309995, 13912801657, 11142922352 | Calendar sync described as "plus" (12250165294) ; Dark mode and themes | 3301575141, 4541759968 | Premium in 2019–20 (3729902277, 5842936639, 5874213446) ; Motivational-quote widget and notification copy | 1461242882, 5865277155 | Free; the copy is often disliked (Part 3.1) ; Passcode lock | 3301575141 | Removed 2025 (12506599929) ; Charity "points" donated per completed habit (2016) | 1465696397, 1483150889 | Removed in v2.0, Nov 2016 (1494883584) ; AI "smart fill" and AI/chatbot support (2025–26) | 13572613236, 13659075450, 14106494461 | — ; Family plan (2025) | 12840463016, 13344142529 | Paid; sharing described as not working
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R33-034 — Master theme table, denominator 3,939

- **Where:** §3.1 Complete ranked theme table (verbatim), 113 themes
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | n | % | Signal | Dir | Mean | 5★ | 1★ | E1 % | E2 % | E3 % | E4 % | E5 % ; 1 | Core praise (union) | 1,477 | 37.50% | high-priority | pos | 4.77 | 1,240 | 16 | 42.0 | 44.6 | 25.8 | 30.7 | 32.6 ; 2 | Reliability (union) | 950 | 24.12% | high-priority | neg | 2.69 | 162 | 317 | 24.2 | 14.8 | 38.9 | 32.6 | 24.4 ; 3 | Unmet needs — all requests (union) | 530 | 13.46% | high-priority | unmet | 3.87 | 188 | 35 | 18.1 | 11.7 | 12.3 | 11.5 | 12.7 ; 4 | Monetisation friction (union) | 521 | 13.23% | high-priority | neg | 2.52 | 86 | 204 | 9.0 | 17.3 | 14.0 | 7.2 | 14.4 ; 5 | Simple / easy / intuitive | 461 | 11.70% | high-priority | pos | 4.82 | 392 | 1 | 15.9 | 15.7 | 6.0 | 6.0 | 7.3 ; 6 | Explicit payer (first person) | 427 | 10.84% | high-priority | segment | 3.16 | 159 | 130 | 9.9 | 10.1 | 14.9 | 11.3 | 10.2 ; 7 | Generic only (no specific theme) | 413 | 10.48% | high-priority | — | 4.69 | 347 | 14 | 8.9 | 12.9 | 7.0 | 9.6 | 11.2 ; 8 | Platform issues: Mac/web, Watch, widget, sync (union) | 354 | 8.99% | high-priority | neg | 2.87 | 72 | 103 | 3.7 | 4.7 | 18.7 | 19.9 | 9.7 ; 9 | Design / UI praised | 322 | 8.17% | high-priority | pos | 4.52 | 230 | 10 | 14.0 | 9.0 | 4.2 | 4.3 | 4.8 ; 10 | Helps build / track habits | 321 | 8.15% | high-priority | pos | 4.90 | 292 | 0 | 10.5 | 10.5 | 5.7 | 6.0 | 4.6 ; 11 | "Best habit tracker" claim | 303 | 7.69% | high-priority | pos | 4.89 | 276 | 1 | 6.6 | 7.7 | 6.2 | 9.1 | 9.2 ; 12 | Other functional bug | 297 | 7.54% | high-priority | neg | 2.85 | 52 | 79 | 6.6 | 5.0 | 11.7 | 8.4 | 9.4 ; 13 | Competitor named / "tried many" | 217 | 5.51% | high-priority | mixed | 4.31 | 152 | 21 | 7.1 | 5.3 | 4.5 | 5.8 | 4.6 ; 14 | Free-tier habit cap | 213 | 5.41% | high-priority | neg | 2.31 | 19 | 87 | 4.6 | 6.5 | 5.1 | 3.4 | 5.8 ; 15 | Concrete life outcome | 205 | 5.20% | high-priority | pos | 4.88 | 186 | 1 | 3.4 | 5.6 | 5.3 | 7.4 | 5.4 ; 16 | Price objection | 203 | 5.15% | high-priority | neg | 2.64 | 38 | 68 | 2.3 | 8.4 | 6.0 | 2.9 | 4.1 ; 17 | Regression (union: update worse / feature removed) | 197 | 5.00% | very strong* | neg | 2.51 | 32 | 71 | 3.8 | 2.2 | 14.9 | 3.8 | 4.8 ; 18 | Statistics praised | 187 | 4.75% | very strong | pos | 4.79 | 155 | 1 | 5.4 | 5.8 | 1.9 | 3.6 | 4.8 ; 19 | Mainland-China connectivity (needs VPN) | 173 | 4.39% | very strong | neg | 2.36 | 28 | 80 | 11.5 | 2.8 | 2.1 | 2.4 | 1.2 ; 20 | An update made it worse | 170 | 4.32% | very strong | neg | 2.42 | 25 | 64 | 2.9 | 2.1 | 12.8 | 3.6 | 4.2 ; 21 | Login / registration fails | 151 | 3.83% | very strong | neg | 2.19 | 20 | 76 | 7.3 | 1.9 | 3.8 | 7.2 | 1.1 ; 22 | Billing & entitlement integrity (union) | 147 | 3.73% | very strong | neg | 2.22 | 28 | 84 | 5.1 | 2.7 | 5.5 | 3.4 | 2.8 ; 23 | Mac / web / iPad / Android app broken or lagging | 141 | 3.58% | very strong | neg | 2.74 | 30 | 48 | 0.8 | 1.8 | 7.9 | 12.2 | 2.2 ; 24 | Other feature requests | 133 | 3.38% | very strong | unmet | 4.02 | 53 | 5 | 3.4 | 3.5 | 2.5 | 3.8 | 3.5 ; 25 | Explicit churn (deleted / switched / cancelled) | 132 | 3.35% | very strong | neg | 1.83 | 7 | 69 | 2.5 | 3.1 | 5.7 | 3.8 | 3.0 ; 26 | Support failure (union) | 131 | 3.33% | very strong | neg | 1.70 | 9 | 89 | 1.8 | 2.6 | 6.4 | 5.0 | 3.2 ; 27 | Motivating / streaks / accountability | 130 | 3.30% | very strong | pos | 4.75 | 109 | 3 | 4.0 | 3.8 | 1.5 | 2.6 | 3.3 ; 28 | Sync missing / fails | 119 | 3.02% | very strong | neg | 2.69 | 23 | 40 | 1.4 | 1.7 | 6.2 | 7.9 | 2.3 ; 29 | Confusing / hard to use | 116 | 2.94% | meaningful | neg | 2.72 | 14 | 34 | 1.8 | 1.8 | 3.8 | 2.4 | 5.8 ; 30 | Cross-platform praised | 112 | 2.84% | meaningful | pos | 4.70 | 84 | 0 | 3.2 | 2.6 | 3.2 | 3.4 | 2.2 ; 31 | An update improved it | 112 | 2.84% | meaningful | pos | 4.78 | 93 | 1 | 1.6 | 2.0 | 5.7 | 3.8 | 3.2 ; 32 | Support praised | 103 | 2.61% | meaningful | pos | 4.73 | 87 | 1 | 2.3 | 2.0 | 4.0 | 2.9 | 3.0 ; 33 | Account, email & data trust (union) | 102 | 2.59% | meaningful | neg | 1.80 | 9 | 67 | 0.8 | 2.9 | 3.4 | 7.9 | 1.0 ; 34 | Apple Watch app broken / poor | 100 | 2.54% | meaningful | neg | 2.84 | 18 | 28 | 1.2 | 1.6 | 6.8 | 4.6 | 1.7 ; 35 | Price fair / worth it | 99 | 2.51% | meaningful | pos | 4.85 | 86 | 0 | 1.9 | 2.5 | 2.6 | 2.4 | 3.2 ; 36 | Crash / won't open | 94 | 2.39% | meaningful | neg | 2.14 | 11 | 49 | 3.0 | 1.6 | 2.6 | 2.2 | 2.8 ; 37 | Support unresponsive / contact broken | 91 | 2.31% | meaningful | neg | 1.91 | 9 | 54 | 1.8 | 1.4 | 4.2 | 2.4 | 3.1 ; 38 | Reminders praised | 91 | 2.31% | meaningful | pos | 4.78 | 74 | 0 | 4.5 | 2.5 | 0.8 | 1.0 | 1.2 ; 39 | Stats / streaks wrong or weak | 89 | 2.26% | meaningful | neg | 2.82 | 9 | 17 | 1.6 | 1.0 | 7.0 | 1.7 | 2.2 ; 40 | General paywall | 89 | 2.26% | meaningful | neg | 2.36 | 15 | 41 | 2.2 | 2.6 | 1.9 | 1.2 | 2.7 ; 41 | Rating contradicts text | 88 | 2.23% | meaningful | — | 4.85 | 82 | 1 | 1.8 | 2.0 | 4.3 | 2.9 | 1.4 ; 42 | Widget broken / poor / removed | 85 | 2.16% | meaningful | neg | 3.15 | 16 | 14 | 0.8 | 0.4 | 4.2 | 2.2 | 5.2 ; 43 | Request: frequency / scheduling | 82 | 2.08% | meaningful | unmet | 3.91 | 26 | 6 | 4.1 | 1.8 | 0.9 | 1.2 | 1.4 ; 44 | A feature was removed | 82 | 2.08% | meaningful | neg | 2.77 | 16 | 24 | 1.5 | 1.0 | 6.0 | 1.7 | 2.1 ; 45 | Flexible scheduling praised | 79 | 2.01% | meaningful | pos | 4.80 | 65 | 0 | 3.1 | 1.2 | 0.9 | 1.7 | 2.8 ; 46 | Timer mentioned | 71 | 1.80% | meaningful | mixed | 3.80 | 30 | 6 | 0.1 | 2.4 | 3.0 | 2.4 | 1.7 ; 47 | Paid but Premium not granted / lost | 69 | 1.75% | meaningful | neg | 2.33 | 13 | 36 | 3.6 | 0.9 | 1.9 | 1.2 | 1.2 ; 48 | Reminders not firing / wrong | 68 | 1.73% | meaningful | neg | 2.68 | 7 | 20 | 1.5 | 1.7 | 2.8 | 1.7 | 1.4 ; 49 | Localisation (quality / wrong language / request) | 62 | 1.57% | meaningful | neg | 3.18 | 20 | 14 | 2.4 | 1.6 | 1.5 | 1.7 | 0.6 ; 50 | Request: better statistics | 58 | 1.47% | meaningful | unmet | 4.03 | 23 | 1 | 2.0 | 1.0 | 1.5 | 0.7 | 2.0 ; 51 | Request: units / icons / custom fields | 56 | 1.42% | meaningful | unmet | 4.18 | 21 | 1 | 1.7 | 1.0 | 1.3 | 2.9 | 1.0 ; 52 | Data / history lost | 55 | 1.40% | meaningful | neg | 2.25 | 8 | 24 | 2.2 | 1.2 | 2.5 | 0.5 | 0.6 ; 53 | Request: multiple completions per day / quantities | 53 | 1.35% | meaningful | unmet | 3.94 | 20 | 1 | 2.9 | 1.8 | 0.2 | 0.2 | 0.1 ; 54 | Freeze / lag / slow | 52 | 1.32% | meaningful | neg | 2.58 | 7 | 21 | 1.1 | 0.8 | 1.1 | 2.6 | 1.8 ; 55 | One-time / lifetime / no-subscription praised | 51 | 1.29% | meaningful | pos | 4.63 | 38 | 0 | 3.0 | 0.6 | 0.9 | 0.5 | 1.0 ; 56 | Request: themes / colours / dark mode | 48 | 1.22% | meaningful | unmet | 4.00 | 14 | 2 | 1.3 | 1.4 | 1.1 | 0.5 | 1.2 ; 57 | Free tier sufficient | 48 | 1.22% | meaningful | pos | 4.85 | 41 | 0 | 0.9 | 1.8 | 0.8 | 0.5 | 1.5 ; 58 | Request / problem: custom ordering | 47 | 1.19% | meaningful | neg | 3.40 | 11 | 5 | 1.1 | 0.8 | 2.6 | 1.0 | 1.1 ; 59 | Integrations (Shortcuts, Zapier, API, calendar, NFC) | 47 | 1.19% | meaningful | mixed | 3.91 | 22 | 3 | 0.1 | 0.6 | 1.9 | 1.9 | 2.5 ; 60 | Account deletion fails | 47 | 1.19% | meaningful | neg | 1.23 | 0 | 41 | 0.0 | 1.5 | 2.5 | 2.9 | 0.4 ; 61 | Refund requested / discussed | 45 | 1.14% | meaningful | neg | 2.16 | 9 | 27 | 1.1 | 0.7 | 2.8 | 1.4 | 0.6 ; 62 | Purchase intent ("would buy if…") | 44 | 1.12% | meaningful | mixed | 4.25 | 24 | 2 | 0.9 | 1.9 | 1.3 | 0.2 | 0.5 ; 63 | Time-of-day sections | 43 | 1.09% | meaningful | pos | 4.37 | 27 | 1 | 1.8 | 1.0 | 0.8 | 0.2 | 1.0 ; 64 | Unwanted / guilt-inducing notifications | 43 | 1.09% | meaningful | neg | 2.33 | 3 | 16 | 1.0 | 0.3 | 1.9 | 1.0 | 2.0 ; 65 | Billing dispute / unexpected charge / scam language | 42 | 1.07% | meaningful | neg | 1.90 | 7 | 30 | 0.4 | 1.0 | 1.9 | 2.4 | 0.7 ; 66 | Objection to the subscription model | 39 | 0.99% | emerging | neg | 1.95 | 2 | 20 | 0.1 | 2.6 | 0.6 | 0.2 | 0.1 ; 67 | Notes / journal feature | 38 | 0.96% | emerging | mixed | 3.89 | 19 | 5 | 0.3 | 1.2 | 1.3 | 0.5 | 1.4 ; 68 | Unwanted marketing email | 37 | 0.94% | emerging | neg | 1.41 | 1 | 30 | 0.1 | 0.6 | 0.2 | 6.5 | 0.1 ; 69 | Review-prompt nagging | 35 | 0.89% | emerging | neg | 2.60 | 6 | 15 | 2.2 | 0.5 | 0.4 | 0.5 | 0.6 ; 70 | Price hidden / misleading "free" / unclear | 34 | 0.86% | emerging | neg | 2.18 | 3 | 15 | 1.3 | 0.8 | 1.5 | 0.0 | 0.5 ; 71 | Apple Watch praised | 32 | 0.81% | emerging | pos | 4.62 | 22 | 0 | 1.1 | 1.0 | 0.9 | 0.5 | 0.4 ; 72 | Trial (wanted / too short / auto-converted) | 31 | 0.79% | emerging | neg | 2.19 | 3 | 15 | 0.3 | 0.3 | 1.7 | 1.0 | 1.4 ; 73 | Too basic | 31 | 0.79% | emerging | neg | 2.32 | 2 | 9 | 1.7 | 0.7 | 0.2 | 0.7 | 0.2 ; 74 | Areas / folders | 31 | 0.79% | emerging | mixed | 3.77 | 10 | 3 | 0.0 | 0.9 | 0.9 | 1.7 | 1.0 ; 75 | Apple Health integration poor / wrong / gated | 29 | 0.74% | emerging | neg | 3.10 | 7 | 9 | 0.1 | 0.0 | 0.8 | 1.4 | 2.2 ; 76 | Weekly check-in cap (free) | 29 | 0.74% | emerging | neg | 2.00 | 2 | 15 | 0.0 | 0.0 | 4.2 | 0.2 | 0.7 ; 77 | Forced account / guest confusion | 26 | 0.66% | emerging | neg | 2.92 | 8 | 8 | 0.6 | 0.9 | 0.9 | 0.2 | 0.4 ; 78 | Widget praised | 26 | 0.66% | emerging | pos | 4.73 | 21 | 0 | 0.8 | 0.4 | 0.4 | 0.7 | 1.1 ; 79 | Request: widget | 24 | 0.61% | emerging | unmet | 4.12 | 10 | 1 | 0.1 | 0.1 | 1.5 | 1.2 | 1.1 ; 80 | Request: bad-habit / quit tracking | 23 | 0.58% | emerging | unmet | 3.35 | 6 | 2 | 0.8 | 0.4 | 0.6 | 0.5 | 0.7 ; 81 | Privacy / data-handling concern | 23 | 0.58% | emerging | neg | 1.35 | 0 | 17 | 0.3 | 0.6 | 0.0 | 2.4 | 0.4 ; 82 | Upsell pop-ups / banners | 22 | 0.56% | emerging | neg | 2.14 | 3 | 11 | 0.4 | 0.1 | 0.2 | 0.5 | 1.7 ; 83 | Sounds / haptics praised | 22 | 0.56% | emerging | pos | 4.64 | 16 | 0 | 1.2 | 0.9 | 0.0 | 0.0 | 0.0 ; 84 | Request: notes / descriptions | 22 | 0.56% | emerging | unmet | 3.91 | 7 | 1 | 1.6 | 0.2 | 0.0 | 0.2 | 0.5 ; 85 | Apple Health praised | 21 | 0.53% | emerging | pos | 4.57 | 13 | 0 | 0.0 | 0.0 | 1.7 | 1.2 | 0.9 ; 86 | Request: Health / wearable auto-completion | 20 | 0.51% | emerging | unmet | 4.00 | 7 | 1 | 0.4 | 0.5 | 0.8 | 0.5 | 0.5 ; 87 | Medical / mental-health use | 20 | 0.51% | emerging | pos | 4.70 | 15 | 0 | 0.5 | 0.8 | 0.6 | 0.0 | 0.2 ; 88 | Challenges | 19 | 0.48% | weak | mixed | 3.84 | 9 | 2 | 0.0 | 0.0 | 0.0 | 1.4 | 1.6 ; 89 | Cannot afford | 19 | 0.48% | weak | neg | 3.32 | 8 | 5 | 0.3 | 0.6 | 0.2 | 0.7 | 0.6 ; 90 | Request: skip / pause / vacation | 18 | 0.46% | weak | unmet | 4.11 | 6 | 0 | 1.1 | 0.1 | 0.8 | 0.2 | 0.2 ; 91 | Free cap accepted / defended | 18 | 0.46% | weak | pos | 4.61 | 12 | 0 | 0.3 | 0.9 | 0.0 | 0.0 | 0.5 ; 92 | Student / teen / child | 16 | 0.41% | weak | segment | 4.81 | 13 | 0 | 0.3 | 0.8 | 0.0 | 0.2 | 0.2 ; 93 | Motivational quotes | 16 | 0.41% | weak | mixed | 4.12 | 7 | 0 | 1.2 | 0.3 | 0.2 | 0.0 | 0.0 ; 94 | Mood log | 14 | 0.36% | weak | mixed | 3.86 | 3 | 0 | 0.0 | 0.0 | 0.6 | 1.9 | 0.4 ; 95 | Ads / upsell shown to payers | 14 | 0.36% | weak | neg | 2.71 | 4 | 7 | 0.3 | 0.6 | 0.0 | 0.2 | 0.4 ; 96 | Request: another platform | 13 | 0.33% | weak | unmet | 4.15 | 8 | 2 | 0.9 | 0.3 | 0.2 | 0.0 | 0.0 ; 97 | Premium not worth it | 13 | 0.33% | weak | neg | 1.92 | 0 | 6 | 0.2 | 0.2 | 0.2 | 0.5 | 0.6 ; 98 | Cannot cancel / charged after cancel | 13 | 0.33% | weak | neg | 1.62 | 2 | 11 | 0.1 | 0.2 | 0.8 | 1.0 | 0.2 ; 99 | App-icon redesign complaint | 12 | 0.30% | weak | neg | 3.67 | 4 | 1 | 0.0 | 0.8 | 0.4 | 0.0 | 0.0 ; 100 | Charity feature (2016) | 12 | 0.30% | weak | mixed | 2.67 | 2 | 4 | 1.3 | 0.0 | 0.0 | 0.0 | 0.0 ; 101 | Ads / cross-promotion | 12 | 0.30% | weak | neg | 2.50 | 3 | 7 | 0.3 | 0.6 | 0.0 | 0.0 | 0.2 ; 102 | Export praised / export missing | 12 / 9 | 0.30% / 0.23% | weak | mixed | 4.42 / 2.67 | — | — |  |  |  |  | ; 103 | Request: one-off tasks | 10 | 0.25% | weak | unmet | 3.80 | 2 | 1 | 0.3 | 0.3 | 0.0 | 0.5 | 0.1 ; 104 | Asks for a one-time option | 10 | 0.25% | weak | unmet | 2.80 | 2 | 3 | 0.0 | 0.7 | 0.2 | 0.0 | 0.0 ; 105 | Monthly plan wanted | 8 | 0.20% | weak | unmet | 2.00 | 0 | 4 | 0.0 | 0.2 | 0.0 | 0.0 | 0.6 ; 106 | AI features / AI support | 8 | 0.20% | weak | neg | 2.62 | 2 | 4 | 0.0 | 0.0 | 0.0 | 0.2 | 0.9 ; 107 | Developer contests / sales (promo) | 8 | 0.20% | weak | mixed | 4.12 | 5 | 1 |  |  |  |  | ; 108 | Price increase noticed | 7 | 0.18% | weak | neg | 2.43 | 1 | 3 | 0.3 | 0.2 | 0.0 | 0.0 | 0.2 ; 109 | Family Sharing / family plan | 7 | 0.18% | weak | neg | 2.00 | 1 | 4 | 0.0 | 0.0 | 0.4 | 0.0 | 0.6 ; 110 | ADHD / neurodivergent self-identified | 7 | 0.18% | weak | pos | 3.86 | 3 | 0 | 0.0 | 0.0 | 0.2 | 0.5 | 0.5 ; 111 | Review prompted / incentivised by developer | 6 | 0.15% | weak | integrity | 3.67 | 4 | 2 | 0.4 | 0.2 | 0.0 | 0.0 | 0.0 ; 112 | Purchase flow fails | 5 | 0.13% | weak | neg | 3.00 | 2 | 2 |  |  |  |  | ; 113 | Request: social / sharing | 5 | 0.13% | weak | unmet | 4.00 | 1 | 0 |  |  |  |  | ; — | Time-zone / travel breaks data (3); discount not honoured (3); legacy purchase dishonoured (3); achievements (3); review deleted by developer (1) | ≤3 each | <0.1% | ignore (see below) |  |  |  |  |  |  |  |  |
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R33-041 — Generic only — no specific theme

- **Where:** §3.1 theme table #7 Generic only (no specific theme)
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 413 (10.48%), mean 4.69
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-075 — Rating contradicts text (MISRATE) — 82 of 88 are 5★

- **Where:** §3.1 theme table #41 Rating contradicts text
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 88 (2.23%, meaningful), mean 4.85
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R33-122 — Weak rows (0.1–0.5%): challenges 19 (3.84); cannot afford 19 (3.32); request skip / pause / vacation 18 (4.11); free cap accepted / defended 18 (4.61); student / teen / child 16 (4.81); motivational quotes 16 (4.12); mood log 14 (3.86); ads / upsell shown to payers 14 (2.71); request another platform 13 (4.15); Premium not worth it 13 (1.92); cannot cancel / charged after cancel 13 (1.62); app-icon redesign complaint 12 (3.67); charity feature (2016) 12 (2.67); ads / cross-promotion 12 (2.50); export praised 12 (4.42) / export missing 9 (2.67); request one-off tasks 10 (3.80); asks for a one-time option 10 (2.80); monthly plan wanted 8 (2.00); AI features / AI support 8 (2.62); developer contests / sales 8 (4.12); price increase noticed 7 (2.43); Family Sharing / family plan 7 (2.00); ADHD / neurodivergent 7 (3.86); review prompted / incentivised by developer 6 (3.67); purchase flow fails 5 (3.00); request social / sharing 5 (4.00); below 0.1%: time-zone / travel breaks data 3, discount not honoured 3, legacy purchase dishonoured 3, achievements 3, review deleted by developer 1

- **Where:** §3.1 theme table #88–#113 weak rows — challenges 19 (3.84); cannot afford 19 (3.32); request skip / pause / vacation 18 (4.11); free cap accepted / defended 18 (4.61); student / teen / child 16 (4.81); motivational quotes 16; mood log 14; ads / upsell shown to payers 14 (2.71); request another platform 13; Premium not worth it 13 (1.92); cannot cancel / charged after cancel 13 (1.62); app-icon redesign complaint 12; charity feature (2016) 12 (2.67); ads / cross-promotion 12 (2.50); export praised 12 / missing 9; request one-off tasks 10; asks for a one-time option 10 (2.80); monthly plan wanted 8 (2.00); AI features / AI support 8 (2.62); developer contests / sales 8; price increase noticed 7; Family Sharing / family plan 7 (2.00); ADHD / neurodivergent 7 (3.86); review prompted / incentivised by developer 6 (3.67); purchase flow fails 5; request social / sharing 5; ignore: time-zone / travel breaks data 3, discount not honoured 3, legacy purchase dishonoured 3, achievements 3, review deleted by developer 1
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 26 weak rows + 5 ignore
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-123 — Positive themes restricted to reviews rated 4–5★: simplicity 453 (11.50%); utility 320 (8.12%); best-tracker claim 299 (7.59%); design 285 (7.24%); life outcome 201 (5.10%); statistics 182 (4.62%); competitor comparison 182 (4.62%); motivation 125 (3.17%); cross-platform 106 (2.69%); price praise 97 (2.46%); support praise 95 (2.41%); reminders 88 (2.23%); kept below the ignore threshold because of their nature — legacy purchase dishonoured (3, paid entitlement), time-zone data loss (3), developer deleted a review (1, an integrity claim); regression at exactly 5.00% is labelled very strong because high-priority is 'above 5%'

- **Where:** §3.1 Positive themes restricted to 4–5★ — simplicity 453 (11.50%); utility 320 (8.12%); best-tracker claim 299 (7.59%); design 285 (7.24%); life outcome 201 (5.10%); statistics 182 (4.62%); competitor comparison 182 (4.62%); motivation 125 (3.17%); cross-platform 106 (2.69%); price praise 97 (2.46%); support praise 95 (2.41%); reminders 88 (2.23%); below 0.1% but kept: legacy purchase dishonoured (3) — paid entitlement; time-zone data loss (3); developer deleted a review (1) — integrity claim; 5.00% regression labelled very strong at the boundary
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** as listed
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `3619346514`, `3964994194`, `5333682703`, `8804625942`, `11430478320`, `11961320357`, `7206302157`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C006 Stay minimal — every addition is opt-in or off by default; C011 Weekly / monthly / yearly reports; C013 Cloud sync / multi-device as the paid differentiator; C036 A support channel that exists, is reachable outside the app, and answers

### R33-129 — Requests (capability never existed, or not at the time): multiple completions per day / quantities (water ×8, pills ×3) 53 — 50 before 2021, since multi-check-in goals shipped in Aug 2020; monthly / bi-weekly / every-N / end-date scheduling 82 (haircut, bills on the 15th, can't end a 30-day challenge); better statistics — all-habit grid, weekly totals, raw counts — 58 ('I want a GitHub type chart'); units, icons, custom fields 56 (kg, kcal, metric, custom icons); themes / colours per habit 48 ('I dislike blue … would pay more'); custom ordering that sticks 47 (90 routines); a widget with check-off and streaks 24; bad-habit / limit tracking done well 23 (a tap per cigarette); Health / wearable auto-completion 20 (Garmin, medications, sleep); skip / pause / vacation 18 (a 'reschedule' swipe); one-off tasks 10; social / accountability 5

- **Where:** §3.5 Requests (verbatim table) — multiple completions per day / quantities (water ×8, pills ×3) 53 (50 before 2021 — multi-check-in goals shipped Aug 2020); monthly / bi-weekly / every-N / end-date scheduling 82 (haircut, bills on the 15th, can't end a 30-day challenge); better statistics 58 ('I want a GitHub type chart'); units, icons, custom fields 56 (kg, kcal, metric, custom icons); themes / colours per habit 48 ('I dislike blue … would pay more'); custom ordering that sticks 47 (90 routines); widget with check-off, streaks 24; bad-habit / limit tracking 23 (tap per cigarette); Health / wearable auto-completion 20 (medications, Garmin); skip / pause / vacation 18 ('reschedule' swipe); one-off tasks 10; social / accountability 5
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Need | n | Evidence ; Multiple completions per day / quantities (water ×8, pills ×3) | 53 (1.35%; 50 of them before 2021 — multi-check-in goals shipped in Aug 2020) | 2765961302, 3218740377, 3372620292, 5409754562, 6050368511 ; Monthly / bi-weekly / every-N / end-date scheduling | 82 | 1461800857 (haircut, bills), 2903709690, 5722068064 (bills on the 15th), 9140981915, 12352483402 (can't end a 30-day challenge) ; Better statistics (all-habit grid, weekly totals, raw counts) | 58 | 2008162858, 13291400972, 13502513407 ("I want a GitHub type chart"), 13574501337 ; Units, icons, custom fields | 56 | 4776591687 (kg), 10977635910 (kcal), 12654766240 (metric), 9854673140 (custom icons) ; Themes / colours per habit | 48 | 2050580709, 5157954414 ("I dislike blue … would pay more"), 6804994945 ; Custom ordering (and ordering that sticks) | 47 | 4018038145 (90 routines), 7656152222, 13701264625 ; Widget with check-off, streaks | 24 | 5136866716, 6478366058, 13214357556 ; Bad-habit / limit tracking done well | 23 | 3356422241, 9696710729 (tap per cigarette), 12689579726 ; Health / wearable auto-completion (Garmin, medications, sleep) | 20 | 3302666007, 12159050522 (medications), 13975290800 (Garmin) ; Skip / pause / vacation | 18 | 3285402822, 6854783487, 11292910105 ("reschedule" swipe) ; One-off tasks | 10 | 3322670660, 5481788644, 8455989216 ; Social / accountability | 5 | 1745724575, 7799933808, 12268421926
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `2765961302`, `3218740377`, `3372620292`, `5409754562`, `6050368511`, `1461800857`, `2903709690`, `5722068064`, `9140981915`, `12352483402`, `2008162858`, `13291400972`, `13502513407`, `13574501337`, `4776591687`, `10977635910`, `12654766240`, `9854673140`, `2050580709`, `5157954414`, `6804994945`, `4018038145`, `7656152222`, `13701264625`, `5136866716`, `6478366058`, `13214357556`, `3356422241`, `9696710729`, `12689579726`, `3302666007`, `12159050522`, `13975290800`, `3285402822`, `6854783487`, `11292910105`, `3322670660`, `5481788644`, `8455989216`, `1745724575`, `7799933808`, `12268421926`
- **Canonical:** C011 Weekly / monthly / yearly reports; C015 Shared / group habits; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C018 App-icon themes; C019 Quit-habit / bad-habit mode; C021 Apple Health integration; C023 Interactive widget check-off; C043 Flexible / custom frequency; C048 Flexible units / partial progress; C050 One-off to-dos alongside habits; C073 Manual reordering, renaming and editing of habits/tasks — free; C143 Intra-day completion: tap N times to fill N/N

### R33-151 — 5★-dominant (51.9%) with a real 1★ tail (18.0%); each band is a different population and band shares are of that band

- **Where:** Part 5 — the corpus is 5★-dominant (51.9%) with a real 1★ tail (18.0%); each band is a different population; shares are of that band
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 51.9% / 18.0%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-159 — Paid-user framing: explicit payers (first-person 'I paid / bought / subscribed / upgraded', 'lifetime member', 'premium user', in any language) 427 (10.84%), mean 3.16; of them, reviews naming a lifetime / one-time purchase (lifetime, one-time, 買い切り, 永久, 평생, 终身, пожизненн…) 112 (2.84%), mean 3.62; global 3,939, mean 3.74 — no conversion rate is claimed, and none can be claimed from review text

- **Where:** §6.1 Framing (verbatim table) — explicit payers 427 (10.84%), 3.16 (first-person, any language); …mentioning a lifetime / one-time purchase 112 (2.84%), 3.62 (lifetime, one-time, 買い切り, 永久, 평생, 终身, пожизненн…); global 3,939, 3.74; no conversion rate is claimed, and none can be claimed from review text
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Group | Definition | n | % of corpus | Mean ; Explicit payers | First-person "I paid / bought / subscribed / upgraded", "lifetime member", "premium user", in any language | 427 | 10.84% | 3.16 ; …mentioning a lifetime / one-time purchase | Payer review that names lifetime, one-time, 買い切り, 永久, 평생, 终身, пожизненн… | 112 | 2.84% | 3.62 ; Global | All reviews | 3,939 | 100% | 3.74
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-167 — Country eligibility: ≥50 reviews — 18 storefronts, 3,190 of 3,939 (81.0%); the other 81 storefronts (749, 19.0%) are in every global number with standalone claims labelled limited evidence; because every language was hand-coded, theme rates are comparable across storefronts, though storefronts under 100 reviews have limited depth; era mix matters — China is 55% E1 (162 of 296), Korea 64% E2 (187 of 292), Japan 36% E2 (191 of 524), while the US, India and Brazil lean toward E5 (172, 38 and 34 reviews)

- **Where:** §7.1 Eligibility — ≥50 reviews: 18 storefronts, 3,190 of 3,939 (81.0%); the other 81 (749, 19.0%) in every global number, standalone claims [limited evidence]; themes hand-coded in every language so theme rates are comparable across storefronts; under 100 reviews still limited depth; §7.2 era mix matters — China 55% E1 (162 of 296), Korea 64% E2 (187 of 292), Japan 36% E2 (191 of 524), US, India and Brazil lean E5 (172, 38, 34)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 18 storefronts; 81.0%
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-181 — Trend method: five eras defined from product events, rates as % of each era's reviews; year figures where an event is narrower than an era; event windows isolate single releases; no trend is claimed from a single month

- **Where:** §8.1 Method — five eras from product events; rates % of each era; year figures where an event is narrower than an era; event windows isolate single releases; no trend claimed from a single month
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5 eras
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R33-191 — Trends not claimed: the App Store 'Today' feature did not cause the China failure, it exposed an existing one dating from 2016–18; the whole Oct 2018 burst is not claimed as solicited — the shape and 'Peter'/rating-email mentions are circumstantial and six reviews carry explicit solicitation signals; no review-prompt trend after 2018 (review-nag complaints 3.8% of 2017, ≤1% of every later year); no ADHD / neurodivergent trend (seven reviews over ten years, positive-to-mixed); no conversion, retention or churn rate; no monthly trend within E5

- **Where:** §8.11 Trends explicitly NOT claimed — no causal claim that the App Store 'Today' feature caused the China failure (it exposed an existing failure dating from 2016–18); no claim that the whole Oct 2018 burst was solicited (circumstantial; six reviews carry explicit solicitation signals); no review-prompt trend after 2018 (review-nag 3.8% of 2017, ≤1% every later year); no ADHD or neurodivergent trend (seven over ten years, positive-to-mixed); no conversion, retention or churn rate; no monthly trend within E5
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as listed
- **Direction for us:** none · **Report confidence:** explicit non-claims · **Generalisable:** yes
- **Review IDs:** `9696710729`, `10038284177`, `10854384133`, `14025511246`
- **Canonical:** — (nuance register)

### R33-226 — Open verification questions, ranked: (26) how many accounts are stuck mid-deletion, and are they still e-mailed; (27) what share of web (Paddle) purchases fail to unlock on iOS; (28) does the support-conversation list scope correctly by user; (29) is the backend still blocked in mainland China today; (30) did the 2019 check-in and notes gates raise conversion enough to offset the 1★ wave — internal data only; (31) were the Oct 2018 reviews tied to an e-mail campaign

- **Where:** Part 10 #26, Part 10 #27, Part 10 #28, Part 10 #29, Part 10 #30, Part 10 #31 — §10.7 Verification questions this report cannot answer, ranked — how many accounts are stuck mid-deletion and are they still emailed [4.6]; what share of web (Paddle) purchases fail to unlock on iOS [4.3]; does the support-conversation list scope correctly by user [4.6c]; mainland-China reachability today [4.1]; did the 2019 check-in and notes gates raise conversion enough to offset the 1★ wave (internal data only) [4.2]; were the Oct 2018 reviews tied to an email campaign [Warning 3]
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 6 questions
- **Direction for us:** research · **Report confidence:** open questions · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C054 Never run incentivised / review-for-premium campaigns; C096 Privacy and discretion stack; C132 Do not sell in a storefront where the app cannot function; C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot
