# Cards — report 11

Source: `App Store Reports/11. Daily Habits - Streak Tracker - Morning Routine & Goal Planner (REPORT).md`  
70 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 5
- [Must-haves](#must-haves) — 2
- [Must never break](#must-never-break) — 5
- [Features](#features) — 8
- [Monetization](#monetization) — 6
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 11
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 6
- [Dated events and trends](#dated-events-and-trends) — 5
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 2
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 10

## Product rules

### R11-006 — The paywall was retrofitted over previously-free features and the corpus dates it to a ~4-month window: 'all functions are free' attested 30 Jan 2025 and 5 Dec 2025 (RU), then 'charging for features that were previously free' by April 2026 (IE); 'free' was the third-most-cited praise theme and was praised in the same breath as 'no pressure' and 'no imposed junk' — a 5★ reviewer explicitly declined to buy ('sorry that I didn't buy'); the free tier WAS the positioning

- **Where:** Part 0 §3 The paywall was retrofitted over features that were previously free, and the corpus dates it
- **This app does:** moved free features behind IAPs Dec 2025–Apr 2026 without disclosure
- **User reaction:** 1★-burst
- **Magnitude:** 7 of 33 (21.21%, mean 4.86) name 'free' as a reason; window Dec 2025 – Apr 2026; v1.0.165 12 Jul 2026, paid twin last updated 15 Apr 2026
- **Direction for us:** product-rule · **Report confidence:** very strong (count 7) · **Generalisable:** yes
- **Review IDs:** `8800831234`, `10285428672`, `10985521600`, `11468101739`, `12221849177`, `12249396648`, `13476851347`, `14438257886`
- **Canonical:** C001 Never move a free feature behind the paywall; C104 Never ship a paywall or feature-removal change silently

### R11-012 — Free unlimited habits was the acquisition wedge — 'First app that has more than 3 habits' is a reviewer's entire body — the app won its audience by being the un-paywalled option in a paywalled category, then adopted the category's paywall (up to $14.99 for 'All Features') without disclosure and with broken billing; nothing says the app cannot be monetized — a 5★ reviewer apologises for NOT buying — but the free tier was the differentiator

- **Where:** Part 0 §7 Free unlimited habits was the acquisition wedge — and it is the thing that was monetized
- **This app does:** no 3-habit cap (historically free); status after retrofit unknown
- **User reaction:** purchase-driver
- **Magnitude:** 1 review (n=1, diagnostic)
- **Direction for us:** product-rule · **Report confidence:** n=1 · **Generalisable:** yes
- **Review IDs:** `11904287504`, `12221849177`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R11-037 — A paywall retrofit over previously-free features needs a grandfathering policy — existing users who had the features free must keep them

- **Where:** §6.3 Paywall retrofitted over previously-free features without notice — fixable by grandfathering policy
- **This app does:** no grandfathering
- **User reaction:** 1★-burst
- **Magnitude:** 1 complaint contradicted by 2 earlier 'all free' reviews
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `14438257886`, `12249396648`, `13476851347`
- **Canonical:** C001 Never move a free feature behind the paywall; C104 Never ship a paywall or feature-removal change silently

### R11-060 — Publish and honour a grandfathering rule for pre-2026 users — the users being paywalled are the ones who wrote the 4.86 rating

- **Where:** Part 9 Immediate — disclosure #7 Publish and honour a grandfathering rule for pre-2026 users
- **This app does:** no grandfathering
- **User reaction:** 1★-burst
- **Magnitude:** free parity attested 5 Dec 2025, gone by Apr 2026
- **Direction for us:** product-rule · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `13476851347`, `14438257886`
- **Canonical:** C001 Never move a free feature behind the paywall; C104 Never ship a paywall or feature-removal change silently

### R11-065 — Decide whether the free tier keeps unlimited habits — this was the acquisition wedge against the category; if it has been capped, that is the highest-risk change the app has made and it is invisible in this corpus

- **Where:** Part 9 Near-term product #12 Decide whether the free tier keeps unlimited habits
- **This app does:** unlimited habits status unknown after retrofit
- **User reaction:** purchase-driver
- **Magnitude:** 1 review is the entire wedge evidence
- **Direction for us:** product-rule · **Report confidence:** recommendation (near-term) · **Generalisable:** yes
- **Review IDs:** `11904287504`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

## Must-haves

### R11-056 — Ship a reachable in-app support channel with a response SLA — 'there is no way in app to talk with developer or team'; support absence is converting fixable billing bugs into permanent store damage (unanswered tickets filed as public 1–2★ reviews)

- **Where:** Part 9 Immediate — billing integrity #3 Ship a reachable in-app support channel with a response SLA
- **This app does:** no in-app support; email unanswered
- **User reaction:** 1★-burst
- **Magnitude:** 2 of 33 support unreachable, mean 1.50
- **Direction for us:** must-have · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14472099021`, `14446220984`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R11-059 — State the free/paid split in the store description — the current description discloses nothing (0 mentions of premium, subscription, free, unlock or ads) while four IAPs up to $14.99 exist; the core grievance is being charged for what was free with no warning anywhere

- **Where:** Part 9 Immediate — disclosure #6 State the free/paid split in the store description
- **This app does:** no paywall disclosure
- **User reaction:** 1★-burst
- **Magnitude:** 0 disclosure terms; 4 IAPs
- **Direction for us:** must-have · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14438257886`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

## Must never break

### R11-005 — 100% of direct paid-user evidence is an entitlement failure: restore-purchases does not work (BR 'VIP' unlocked a week then re-locked, reinstall did not restore, support silent), a non-consumable lifetime entitlement expired (PK 'worked properly for few months then suddenly my membership cancelled and there is no way in app to talk with developer'), and an active annual subscription is being re-charged (IE 'trying to charge again even though I have a subscription for another 7 months… Appears to be a scam now') — consistent with one receipt-validation / entitlement-persistence defect; two reviewers title their reviews 'scam' and 'Purchase fraud'; promoted under the billing-integrity carve-out

- **Where:** Part 0 §2 100% of direct paid-user evidence in this corpus is an entitlement failure; table (verbatim)
- **This app does:** receipts not validated / entitlements not persisted; no in-app support path
- **User reaction:** 1★-burst
- **Magnitude:** 3 of 33 (9.09%) paid; 3 of 3 (100%) lost access; paid mean 1.33 vs corpus 4.576; ID | CC | ★ | SKU named | What was paid | What happened ; `14438257886` | IE | 1 | "annual fee" | paid, 7 months of term remaining | app is *"trying to charge again"* ; `14446220984` | BR | 2 | "VIP" subscription | paid | unlocked 1 week, then re-locked; reinstall did not restore; support silent ; `14472099021` | PK | 1 | "lifetime subscription" | paid | worked "a few months", then *"membership cancelled"*
- **Direction for us:** must-never-break · **Report confidence:** high-severity carve-out · **Generalisable:** yes
- **Review IDs:** `14438257886`, `14446220984`, `14472099021`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers

### R11-026 — The 2★ reviewer is still asking for help (title simply 'Support'); both 1★ reviewers are paid users using fraud language ('Avoid this app - appears to be a scam now'; 'Purchase fraud') — 100% of 1★ reviews are paid users reporting lost entitlement

- **Where:** Part 2 2★ band; 1★ band — both paid users, both use fraud language; segment rate 2 of 2
- **This app does:** entitlement failure
- **User reaction:** 1★-burst
- **Magnitude:** 2★ n=1; 1★ n=2 (6.06%); segment 2 of 2 one-star are paid
- **Direction for us:** must-never-break · **Report confidence:** n=3 · **Generalisable:** yes
- **Review IDs:** `14446220984`, `14438257886`, `14472099021`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R11-054 — Audit receipt validation and entitlement persistence end to end — reproduce a lifetime non-consumable expiring after months, an entitlement re-locking ~7 days after purchase, and an active annual term being re-prompted for payment

- **Where:** Part 9 Immediate — billing integrity #1 Audit receipt validation and entitlement persistence end to end
- **This app does:** entitlements fail
- **User reaction:** 1★-burst
- **Magnitude:** 3 of 3 paid reviewers lost access; 2 titled 'scam'/'fraud'
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14472099021`, `14446220984`, `14438257886`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately

### R11-055 — Fix Restore Purchases — the only self-service remedy a user has, and it is not working (reinstall did not restore)

- **Where:** Part 9 Immediate — billing integrity #2 Fix Restore Purchases
- **This app does:** restore purchases broken
- **User reaction:** 1★-burst
- **Magnitude:** 1 review
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14446220984`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R11-057 — Rename the three identically-named SKUs so $1.99 / $6.99 / $8.99 are distinguishable and state the period (or 'one time') in each display name — a user cannot identify what they bought; neither can support

- **Where:** Part 9 Immediate — billing integrity #4 Rename the three 'Habits PRO Functions' SKUs; state the period in each display name
- **This app does:** 3 SKUs, one name, no period
- **User reaction:** complaint
- **Magnitude:** listing check
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C177 Every IAP SKU has a distinct name that states its period or 'one time'

## Features

### R11-013 — The one recurring usability pattern: the UI offers only single-step increments where a jump is needed — history navigation ('No month view, can only see the active week… Literally have to skip back one day at a time') and list reordering ('it only moves up one position at a time'; 'wish that you add rearranging the tasks') — two screens, 17 months and two countries apart

- **Where:** Part 0 §8 The one recurring usability pattern: everything moves one step at a time
- **This app does:** week-only history; one-step reordering; no drag
- **User reaction:** complaint
- **Magnitude:** 2 of 33 (6.06%, mean 4.50) single-step pattern; reordering 2 of 33 (6.06%) on its own
- **Direction for us:** build-free · **Report confidence:** n=2 · **Generalisable:** yes
- **Review IDs:** `10985521600`, `11490387774`, `10016901878`
- **Canonical:** C012 Week / month / year grid views; C073 Manual reordering, renaming and editing of habits/tasks — free

### R11-014 — The biggest feature gap is history depth — cloud/iCloud history, weekly/monthly/yearly statistics, month view, date-range filter, search, per-task completion stats — and the current listing claims 'ADVANCED STATISTICS — weeks, months and individual tasks' and 'DARK THEME' (answering a 4★ 'only yellow-white… not comfortable for eyes in the evening') are shipped; the developer does ship what users ask for, but there is no post-ship review evidence confirming it; cloud backup / export remains unaddressed and is now load-bearing

- **Where:** Part 0 §9 The biggest feature gap is history depth — and the current listing claims it is now fixed
- **This app does:** month/period stats and dark theme claimed shipped Jul 2026; backup/export absent
- **User reaction:** complaint
- **Magnitude:** 3 of 33 (9.09%, mean 4.67) ask for history depth; the most detailed critical review is a product brief with 4 asks; 6 reviews after Dec 2025, none confirm
- **Direction for us:** build-free · **Report confidence:** n=3 + listing · **Generalisable:** yes
- **Review IDs:** `9327859322`, `9332848196`, `10985521600`, `9809639708`
- **Canonical:** C011 Weekly / monthly / yearly reports; C012 Week / month / year grid views; C080 Colour themes / dark mode; C153 Automatic cloud backup on by default — never manual opt-in

### R11-016 — Feature inventory: what reviews prove vs what the 12 Jul 2026 listing claims — daily checklist, per-habit reminders, weekly view + daily %, rewards/badges, unlimited habits, optional times (all historically free); month/period stats and dark theme (requested, claimed shipped, unverified); drag-to-reorder, date filter/search (requested, no evidence shipped); cloud backup/export (still missing); widget, multiple lists, AI habit generator, share list (listed, never mentioned by a reviewer); ads (inferred)

- **Where:** §1.1 Feature inventory table (verbatim)
- **This app does:** see table
- **User reaction:** mixed
- **Magnitude:** Capability | Review evidence | Listing (9 Sep 2026) | Gating ; Daily habit checklist | `11375045777`, `12249396648`, `10874846443`, +many | ✔ "DAILY HABIT TRACKER" | Core; free historically (`12249396648`, `13476851347`) ; Per-habit reminders / notifications | `12249396648` — *"на каждую привычку можно поставить отдельное уведомление"* ("you can set a separate notification for each habit") | ✔ "REMINDERS & WEEKLY SCHEDULE" | Free as of Jan 2025 ; Weekly view + daily completion % | `11375045777` — *"I love the daily percentage and being able to look at each week"* | ✔ | Free as of Jun 2024 ; Rewards / achievement badges | `12249396648` — *"фича со значками достижений — мотивирует заходить и отмечать привычки"* ("the achievement-badges feature motivates me to come in and check off habits") | ✔ "REWARDS & PROGRESS" | Free as of Jan 2025 ; Unlimited habits (no 3-habit cap) | `11904287504` — *"First app that has more than 3 habits"* | not stated | Free as of Nov 2024; status after paywall retrofit unknown ; No forced schedule / optional times | `8756804446` | ✔ (schedule is opt-in per habit) | Free ; Monthly view / period statistics | requested, absent — `9332848196`, `10985521600` | ✔ "ADVANCED STATISTICS… weeks, months and individual tasks" | Claimed shipped; unverified by reviews ; Dark theme | requested, absent — `9809639708` | ✔ "DARK THEME" | Claimed shipped; unverified by reviews ; Drag-to-reorder habits | requested, absent — `10016901878`, `11490387774` | not stated | No evidence it shipped ; Date filter / search in history | requested, absent — `10985521600` | not stated | No evidence it shipped ; Cloud backup / iCloud / export | requested, absent — `9327859322`; data-loss fear drives the only purchase in the corpus (`14438257886`) | absent — 0 mentions of iCloud/sync/backup/cloud/export | Still missing ; Home-screen widget | not mentioned by any reviewer | ✔ "HOME SCREEN WIDGET" | Unknown ; Multiple lists | not mentioned by any reviewer | ✔ "MULTIPLE LISTS" | Unknown ; AI habit generator | not mentioned by any reviewer | ✔ headline feature, "NEW" | Unknown ; Share habit list with a friend | not mentioned by any reviewer | on `daily-habits.app` only | Unknown ; Ads | not mentioned by any reviewer | implied by paid twin's *"no ads, no banners"* | Inferred
- **Direction for us:** research · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `11375045777`, `12249396648`, `10874846443`, `11904287504`, `8756804446`, `9332848196`, `10985521600`, `9809639708`, `10016901878`, `11490387774`, `9327859322`, `14438257886`
- **Canonical:** — (nuance register)

### R11-017 — Small free features draw explicit praise: a separate notification per habit, achievement badges that 'motivate me to come in and check off habits', and the daily percentage with a weekly view

- **Where:** §1.1 Per-habit reminders; rewards / achievement badges; weekly view + daily completion %
- **This app does:** per-habit reminder, badges, weekly view all free
- **User reaction:** praise
- **Magnitude:** 1 review each (RU Jan 2025; US Jun 2024)
- **Direction for us:** build-free · **Report confidence:** n=1 each · **Generalisable:** yes
- **Review IDs:** `12249396648`, `11375045777`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C012 Week / month / year grid views; C101 Milestones, achievements, celebration

### R11-031 — A satisfied 5★ RU reviewer notes lag and a dated visual design alongside praise for being free without imposed junk

- **Where:** Part 4 Lag / performance; Dated visual design (12221849177)
- **This app does:** dated UI, some lag
- **User reaction:** praise
- **Magnitude:** 1 review each
- **Direction for us:** research · **Report confidence:** n=1 · **Generalisable:** app-specific
- **Review IDs:** `12221849177`
- **Canonical:** C057 Offer a non-pastel / premium design option

### R11-052 — Persistent gaps across five years: cloud backup / export (first raised Nov 2022, still absent, now load-bearing), drag-to-reorder (2023 and 2024, two 5★ reviewers), date filter / search (2024)

- **Where:** §8.6 What persisted, unfixed, across all five years table (verbatim)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** Persistent gap | First raised | Still absent as of | Evidence ; Cloud backup / export | 25 Nov 2022 (`9327859322`) | 9 Sep 2026 store listing (0 mentions of iCloud/sync/backup/cloud/export) | Now load-bearing: `14438257886` bought to protect 3 years of local history ; Drag-to-reorder | 9 Jun 2023 (`10016901878`), 14 Jul 2024 (`11490387774`) | not in listing | 2 reviewers, both 5★ ; Date filter / search in history | 27 Feb 2024 (`10985521600`) | not in listing | 1 reviewer
- **Direction for us:** build-free · **Report confidence:** n=1–2 each · **Generalisable:** yes
- **Review IDs:** `9327859322`, `10016901878`, `11490387774`, `10985521600`, `14438257886`
- **Canonical:** C012 Week / month / year grid views; C073 Manual reordering, renaming and editing of habits/tasks — free; C153 Automatic cloud backup on by default — never manual opt-in

### R11-062 — Ship export and/or iCloud backup — the oldest request and now the mechanism behind the worst review; removes data hostage as a purchase driver, removes catastrophic downside when billing misfires, and makes a POSITIVE upgrade case (backup as a Premium feature) that no reviewer would call a scam

- **Where:** Part 9 Near-term product #9 Ship export and/or iCloud backup — sell durability, not access
- **This app does:** absent
- **User reaction:** blocked-conversion
- **Magnitude:** first raised Nov 2022; 1 purchase driven by data fear
- **Direction for us:** build-paid · **Report confidence:** recommendation (near-term) · **Generalisable:** yes
- **Review IDs:** `9327859322`, `14438257886`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C020 Data export / backup / CSV; C153 Automatic cloud backup on by default — never manual opt-in

### R11-063 — Add drag-to-reorder and audit for other one-step-only interactions — both requesters gave 5★, cheap goodwill, and the pattern likely recurs

- **Where:** Part 9 Near-term product #10 Add drag-to-reorder, and audit for other one-step-only interactions
- **This app does:** one-step reordering
- **User reaction:** complaint
- **Magnitude:** 2 reviewers, both 5★
- **Direction for us:** build-free · **Report confidence:** recommendation (near-term) · **Generalisable:** yes
- **Review IDs:** `10016901878`, `11490387774`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

## Monetization

### R11-008 — The paid ladder is incoherent and undisclosed: three SKUs share the identical display name 'Habits PRO Functions' at $1.99 / $6.99 / $8.99 (a user cannot tell from a receipt which they own — exactly what two reviewers are trying to describe to support); the lifetime option is $5 cheaper as a separate app ($9.99) than as an IAP ($14.99); reviewers describe subscriptions ('annual fee', 'assinatura', 'subscription for another 7 months') but the IAP list names no periods; and the store description discloses no paywall at all (zero occurrences of 'premium', 'subscription', 'free', 'PRO' as a tier, 'ads' or 'unlock')

- **Where:** Part 0 §5 The paid ladder is incoherent and undisclosed; table (verbatim)
- **This app does:** 4 IAPs with duplicate names, no period disclosure, no paywall disclosure; separate cheaper lifetime app
- **User reaction:** 1★-burst
- **Magnitude:** Price | SKU name as listed | Evidence ; $1.99 | "Habits PRO Functions" | store page ; $6.99 | "Habits PRO Functions" | store page ; $8.99 | "Habits PRO Functions" | store page ; $14.99 | "Daily Habits All Features Pack" | store page ; $9.99 | *separate app* "Daily Habits: Lifetime Premium" (ID 1550003470) | store listing ; "annual fee" | — | `14438257886` ; "VIP" | — | `14446220984` ; "lifetime subscription" | — | `14472099021`
- **Direction for us:** dont · **Report confidence:** listing check · **Generalisable:** yes
- **Review IDs:** `14438257886`, `14446220984`, `14472099021`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C113 One stable, disclosed price — no discount wheels; C177 Every IAP SKU has a distinct name that states its period or 'one time'

### R11-020 — 3 of 3 direct paid reviewers report losing purchased access; no conversion rate is claimed or claimable

- **Where:** §1.3 Direct paid-user evidence — 3 reviewers (9.09%), mean 1.33
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 3 of 33 (9.09%), mean 1.33; segment 3 of 3 (100%)
- **Direction for us:** must-never-break · **Report confidence:** n=3 · **Generalisable:** yes
- **Review IDs:** `14438257886`, `14446220984`, `14472099021`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R11-035 — Only one purchase motivation is stated and it is defensive — data retention under threat; the other two paid reviewers name the SKU ('VIP', 'lifetime') but give no reason; buyer value delivered: none in every case — access worked briefly (one week / a few months / partial term) and then stopped; a satisfied user's 'sorry that I didn't buy' shows the ask is registered without resentment when the free tier is intact

- **Where:** §6.1 Purchase triggers — only one stated motivation, and it is defensive; §6.2 Buyer value delivered: none
- **This app does:** paywall over history; entitlements fail
- **User reaction:** churn
- **Magnitude:** 1 stated trigger; 3 of 3 buyers got no lasting value
- **Direction for us:** must-never-break · **Report confidence:** n=3 · **Generalisable:** yes
- **Review IDs:** `14438257886`, `14446220984`, `14472099021`, `12221849177`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C176 Never let fear of losing history be the reason people pay

### R11-036 — Eight upgrade barriers and what fixes each: entitlement does not persist and restore fails (receipt validation + restore audit); active subscription re-prompted (same); no reachable support channel (in-app contact + SLA); three SKUs one display name (App Store Connect metadata); in-app lifetime $5 dearer than standalone app (pricing decision); no paywall disclosure in listing (listing copy); paywall retrofitted without notice (grandfathering policy)

- **Where:** §6.3 Upgrade barriers and monetization friction table (verbatim)
- **This app does:** see table
- **User reaction:** 1★-burst
- **Magnitude:** Barrier | Evidence | Fixable by ; Entitlement does not persist | `14446220984`, `14472099021` | Receipt validation + restore-purchases audit ; Restore-purchases does not work | `14446220984` (*"tentei reinstalar mas não liberou"*) | Same ; Active subscription re-prompted for payment | `14438257886` | Same ; Support has no reachable channel | `14446220984` (no reply), `14472099021` (*"no way in app to talk with developer or team"*) | In-app contact + SLA ; Three IAP SKUs share one display name | Store page: "Habits PRO Functions" at $1.99 / $6.99 / $8.99 | App Store Connect metadata ; In-app lifetime ($14.99) costs $5 more than the standalone paid app ($9.99) | Store listings | Pricing decision ; Store description discloses no paywall at all | US description: 0 mentions of premium/subscription/free/unlock | Listing copy ; Paywall retrofitted over previously-free features without notice | `14438257886`, contradicted by `12249396648`, `13476851347` | Grandfathering policy
- **Direction for us:** must-never-break · **Report confidence:** n=3 + listing · **Generalisable:** yes
- **Review IDs:** `14446220984`, `14472099021`, `14438257886`, `12249396648`, `13476851347`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C113 One stable, disclosed price — no discount wheels

### R11-066 — This is not a product that needs a cheaper price — it needs a paid tier that adds something rather than removing something: sell durability (backup, export, multi-device, long-history analytics), not access; the one buyer was paying to KEEP what they had rather than to GAIN something

- **Where:** Part 9 Monetization — repackage around what the corpus actually values: Sell durability, not access
- **This app does:** paywall removes; nothing added
- **User reaction:** blocked-conversion
- **Magnitude:** 0 price objections; 1 buyer willing to pay for durability
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `12221849177`, `14438257886`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C133 Gate on capability, not on quantity; C176 Never let fear of losing history be the reason people pay

### R11-068 — Price for the actual base: 86% of ratings sit outside high-spend storefronts (RU/MX/CO/BR/CL/IN/AR/ES); a US-anchored $14.99 pack is not priced for this audience — rests on external rating-volume data, no reviewer complains about price

- **Where:** Part 9 Monetization — Price for the actual base
- **This app does:** US-anchored pricing
- **User reaction:** none
- **Magnitude:** 86% of ratings outside high-spend storefronts
- **Direction for us:** do · **Report confidence:** recommendation (external data) · **Generalisable:** yes
- **Canonical:** C092 Regional pricing

## Tactics the app used

### R11-046 — The app carries at least eight different names across storefronts — deliberate per-storefront ASO testing: Spanish-speaking Latin America gets an AI-forward name while Spain does not; the entire English world outside the US gets 'Habit Builder with AI Planner' while the US keeps 'Daily Habits: Streak Tracker'; users in different markets are being sold different promises — a plausible contributor to expectation mismatch, recorded as context (no reviewer complains)

- **Where:** §7.7 Per-storefront naming — an ASO fact worth flagging; table (verbatim)
- **This app does:** per-storefront app names
- **User reaction:** none
- **Magnitude:** Name | Storefronts ; Daily Habits: Streak Tracker | US, SE, NL ; Habit Builder with AI Planner | GB, IE, DK, SA, PK, CZ, SN, AU, IN, PL, TR, UA ; Habit Tracker: Goals & Routine | CA ; Hábitos y metas diarias con IA | MX, AR, CO, CL ; Hábitos: Tracker & Rachas | ES ; Hábitos: Tracker & Sequências | BR ; Привычки: трекер и серии | RU ; Abitudini: Tracker & Streak / Gewohnheiten: Habit Tracker / Suivi d'habitudes & Streaks / 習慣トラッカー＆ストリーク | IT / DE / FR / JP
- **Direction for us:** research · **Report confidence:** listing check · **Generalisable:** yes
- **Canonical:** C134 Lead the store listing with what users actually love

## Insights (the why)

### R11-003 — A six-year-old, genuinely loved, deliberately minimal habit tracker whose single largest stated value driver was 'it's free and it doesn't nag you' retrofitted a paywall over previously-free features between Dec 2025 and Apr 2026 — and every one of the three reviewers who then paid lost the access they bought, taking the corpus from 29 consecutive 4–5★ reviews to 1★/2★/1★ in nine days

- **Where:** Part 0 Executive summary in one line
- **This app does:** paywall retrofit + broken entitlements
- **User reaction:** 1★-burst
- **Magnitude:** 29 reviews mean 4.90, zero below 4★ in five years → 3 of 4 Aug 2026 reviews at 1–2★
- **Direction for us:** product-rule · **Report confidence:** headline · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R11-007 — The only stated purchase motivation in the corpus is data hostage, not feature value — 'I paid the annual fee as I had 3 years worth of history I didn't want to lose' — on a product with no backup or export (the listing has zero mentions of iCloud/sync/backup/cloud/export; the oldest unmet request, Nov 2022, is cloud/iCloud history); long-tenure users are maximally exposed: no way to leave, no way to keep the record if the entitlement lapses — a monetization design where the strongest purchase driver is fear of data loss converts loyal users into 1★ reviewers when billing misfires

- **Where:** Part 0 §4 The purchase driver named in the corpus is data hostage, not feature value
- **This app does:** no export/backup; history local-only; paywall over history
- **User reaction:** 1★-burst
- **Magnitude:** 1 stated purchase motive (n=1); cloud request from 25 Nov 2022 still absent 4 years later
- **Direction for us:** dont · **Report confidence:** structural (n=1 + listing check) · **Generalisable:** yes
- **Review IDs:** `14438257886`, `9327859322`
- **Canonical:** C020 Data export / backup / CSV; C153 Automatic cloud backup on by default — never manual opt-in; C176 Never let fear of losing history be the reason people pay

### R11-010 — What people love is simplicity and the absence of pressure — the single dominant theme, stated in five languages across six years; a sharper positioning claim underneath: praise for what the app does NOT do — 'I hate apps that demand set times, and it doesn't bother me about that'; 'not overwhelm me with settings and frills'; 'without any imposed junk'

- **Where:** Part 0 §6 What people actually love: simplicity, and the absence of pressure
- **This app does:** minimal, no forced schedule, no nag
- **User reaction:** praise
- **Magnitude:** 19 of 33 (57.58%, mean 4.95) praise simplicity; 4 of 33 (12.12%, mean 5.00) praise absence of things
- **Direction for us:** product-rule · **Report confidence:** dominant theme · **Generalisable:** yes
- **Review IDs:** `8756804446`, `8800831234`, `9327859322`, `9332848196`, `9758570716`, `9809639708`, `10285428672`, `10315480705`, `10796416820`, `10874846443`, `11375045777`, `11468101739`, `12113191512`, `12221849177`, `12269558510`, `12285262144`, `13469176367`, `13476851347`, `13685904641`
- **Canonical:** C006 Stay minimal and ad-free; C093 No upsell nagging without a 'never ask again' option; C095 Neutral, non-judgemental tone on failure

### R11-021 — The only evidence a purchasable option existed before 2026 is a satisfied 5★ user who declined to buy — 'I like that it's free (sorry that I didn't buy)' — coded purchase_declined and excluded from paid evidence

- **Where:** §1.4 Inferred, non-purchasing interest — purchase_declined
- **This app does:** optional purchase existed pre-2026
- **User reaction:** praise
- **Magnitude:** 1 review
- **Direction for us:** research · **Report confidence:** n=1 · **Generalisable:** yes
- **Review IDs:** `12221849177`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R11-022 — The most reliable route to 5★ is 'it is simple and it does not get in my way': 17 of 27 five-star reviews praise simplicity; other drivers — it's free, no pressure / no infantilization, concrete outcome or motivation, switched from competitors, low-information praise

- **Where:** Part 2 5★ band — the single most reliable route to 5 stars is 'it is simple and it does not get in my way'; recurring 5★ drivers
- **This app does:** minimal free tracker
- **User reaction:** praise
- **Magnitude:** 5★ n=27 (81.82%); simplicity 17; free 6 of 7; no-pressure 4; outcome 4; switched 3; low-info 10
- **Direction for us:** product-rule · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `9592340459`, `12076364194`, `12119209447`, `13952453631`, `14462951464`
- **Canonical:** C006 Stay minimal and ad-free; C095 Neutral, non-judgemental tone on failure

### R11-023 — Four 5★ reviews carry an unmet feature request in the same body (cloud backup, statistics, reordering ×2): these users are not withholding stars over missing features, they are volunteering a roadmap — a high-trust audience

- **Where:** Part 2 5★ band Notable: three 5★ reviews carry an unmet feature request in the same body — volunteering a roadmap
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 4 of 27 five-star reviews with a request
- **Direction for us:** do · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `9327859322`, `9332848196`, `10016901878`, `11490387774`
- **Canonical:** — (nuance register)

### R11-024 — All three 4★ reviews are constructive 'almost' reviews naming a specific gap — a 2021 'Limited to 3 day usage?' (ambiguous: trial limit, history window or misunderstanding; coded onboarding_limit_confusion, not used for any quantified finding), no dark theme, no month view / date filter / search — and two of the three gaps now appear in the listing as shipped

- **Where:** Part 2 4★ band — every one names a specific, nameable gap; table (verbatim); 6869680821 is genuinely ambiguous
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** ID | CC | Date | Gap named ; `6869680821` | CA | Jan 2021 | *"Limited to 3 day usage? What to do after 3 day if use? Habits not built yet"* ; `9809639708` | CZ | Apr 2023 | No dark theme — *"only yellow-white and that is not comfortable for eyes in the evening"* ; `10985521600` | GB | Feb 2024 | No month view, no date filter, no search, one-day-at-a-time history navigation
- **Direction for us:** build-free · **Report confidence:** n=3 · **Generalisable:** yes
- **Review IDs:** `6869680821`, `9809639708`, `10985521600`
- **Canonical:** C012 Week / month / year grid views; C080 Colour themes / dark mode

### R11-027 — Sixteen praise themes with n, %, band, mean and IDs

- **Where:** Part 3 WHAT PEOPLE PRAISE full table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of 33 | Band | Mean ★ | Review IDs ; Simplicity / ease of use (any form) | 19 | 57.58% | High-priority | 4.95 | `8756804446`, `8800831234`, `9327859322`, `9332848196`, `9758570716`, `9809639708`, `10285428672`, `10315480705`, `10796416820`, `10874846443`, `11375045777`, `11468101739`, `12113191512`, `12221849177`, `12269558510`, `12285262144`, `13469176367`, `13476851347`, `13685904641` ; Low-information praise ("great app") | 10 | 30.30% | High-priority | 5.00 | `9592340459`, `10016901878`, `10315480705`, `10796416820`, `11468101739`, `12113191512`, `12119209447`, `12285262144`, `13952453631`, `14462951464` ; It's free | 7 | 21.21% | High-priority | 4.86 | `8800831234`, `10285428672`, `10985521600`, `11468101739`, `12221849177`, `12249396648`, `13476851347` ; No pressure / no nagging / no infantilization | 4 | 12.12% | High-priority | 5.00 | `8756804446`, `11375045777`, `12221849177`, `13685904641` ; Concrete outcome or motivation | 4 | 12.12% | High-priority | 5.00 | `9592340459`, `11375045777`, `12076364194`, `13476851347` ; Practical / fit for purpose | 3 | 9.09% | High-priority | 5.00 | `9758570716`, `12269558510`, `14462951464` ; Switched from / compared against competitors | 3 | 9.09% | High-priority | 5.00 | `11904287504`, `13469176367`, `13685904641` ; "All functions are free" (explicit) | 2 | 6.06% | High-priority | 5.00 | `12249396648`, `13476851347` ; Usability / friendly interface | 2 | 6.06% | High-priority | 5.00 | `13469176367`, `13476851347` ; Per-habit reminders | 1 | 3.03% | Very strong | 5.00 | `12249396648` ; Rewards / achievement badges | 1 | 3.03% | Very strong | 5.00 | `12249396648` ; Weekly view + daily completion % | 1 | 3.03% | Very strong | 5.00 | `11375045777` ; No 3-habit cap | 1 | 3.03% | Very strong | 5.00 | `11904287504` ; Stability / works reliably | 1 | 3.03% | Very strong | 5.00 | `13476851347` ; Accountability | 1 | 3.03% | Very strong | 5.00 | `11375045777` ; Would recommend | 1 | 3.03% | Very strong | 5.00 | `8756804446`
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R11-028 — Smaller praise themes: practical / fit for purpose, friendly interface, stability, accountability, would recommend

- **Where:** Part 3 Practical / fit for purpose; Usability / friendly interface; Stability / works reliably; Accountability; Would recommend
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** practical 3 (9.09%); usability 2 (6.06%); stability 1; accountability 1; recommend 1 — all mean 5.00
- **Direction for us:** none · **Report confidence:** n≤3 · **Generalisable:** yes
- **Review IDs:** `9758570716`, `12269558510`, `14462951464`, `13469176367`, `13476851347`, `11375045777`, `8756804446`
- **Canonical:** — (nuance register)

### R11-032 — No reviewer in this corpus objects to a price point — zero 'too expensive' complaints; the one money complaint is about being charged TWICE, not the amount; the monetization damage is entirely about execution and disclosure; complaint types: broken paid capability (3, highest severity), missing capability (7), pricing objection (0), misunderstanding (possibly 1)

- **Where:** §4.1 Distinguishing the four complaint types — No reviewer objects to a price point; zero 'too expensive' complaints
- **This app does:** IAPs $1.99–$14.99
- **User reaction:** none
- **Magnitude:** 0 price objections of 33
- **Direction for us:** product-rule · **Report confidence:** absence finding · **Generalisable:** yes
- **Review IDs:** `14438257886`, `6869680821`
- **Canonical:** C029 Billing must be exactly right; C064 Price level — where 'fair' turns into 'too expensive'

### R11-038 — No refund request appears; two of three paid users publicly warned others off; churn is not price-driven but trust-driven, and it is expressed in the storefront rather than a support queue because there is no support queue the reviewers could find

- **Where:** §6.4 Refund and churn drivers — churn is trust-driven and expressed in the storefront because there is no support queue
- **This app does:** no in-app support channel
- **User reaction:** churn
- **Magnitude:** 2 of 3 paid users warn others off; 0 refund requests
- **Direction for us:** must-have · **Report confidence:** n=3 · **Generalisable:** yes
- **Review IDs:** `14438257886`, `14472099021`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

## Audiences

### R11-029 — Six jobs-to-be-done each named once: a reminder layer over an existing routine ('simply a shortcut to remember things'), starting new habits, following up on existing habits, deliberately seeking a simple tracker, day planning / task tracking, plain counting — two of the six explicitly do not want a coaching product, the same audience as 'no infantilization', directly in tension with the AI-coach positioning

- **Where:** §3.1 Use cases users describe table (verbatim); two of six explicitly do not want a coaching product
- **This app does:** plain tracker; AI-coach listing
- **User reaction:** praise
- **Magnitude:** Use case | ID | What they say ; Reminder layer over an existing routine | `8756804446` | *"já possuo compromissos diários então ele é simplesmente um atalho para relembrar coisas"* — "I already have daily commitments so it's simply a shortcut to remember things" ; Starting new habits from zero | `10874846443` | *"muy útil para empezar nuevos hábitos"* ; Following up on existing habits | `9758570716` | *"para darle seguimiento a mis hábitos"* ; Deliberately seeking a *simple* tracker | `11375045777` | *"I was looking for a simple tracker… not overwhelm me"* ; Day planning / task tracking | `12076364194` | *"keeping track of tasks I need to do and allowing me to plan my days"* ; Plain counting | `12119209447` | *"Good to hold count on your tings"*
- **Direction for us:** research · **Report confidence:** n=1 each · **Generalisable:** yes
- **Review IDs:** `8756804446`, `10874846443`, `9758570716`, `11375045777`, `12076364194`, `12119209447`
- **Canonical:** C140 Market the generic-tracker use case; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R11-034 — Five hypothesised segments with named witnesses: the already-organised adult (memory aid, not a coach — no alarms, no gamified pressure, no mascot); the simplicity refugee (tested ~6 apps, deleted all others, hit 3-habit caps elsewhere — wants to not be re-complicated); the long-tenure archivist (3 years of local history, needs export/backup and a durable entitlement); the analytical reviewer (month/year views, filters, search, per-task stats); the motivated beginner (badges, per-habit reminders); the first two are the audience the AI-coach positioning speaks past — four reviewers chose this product because it was quieter than the alternatives

- **Where:** Part 5 WHO ACTUALLY USES THIS table (verbatim); the first two segments are the same audience the AI-coach positioning speaks past
- **This app does:** quiet, minimal tracker
- **User reaction:** praise
- **Magnitude:** Segment | Evidence | What they need ; The already-organised adult — has a routine, wants a memory aid, not a coach | `8756804446`, `11375045777`, `13685904641`, `12076364194` | Low-friction logging, no alarms, no gamified pressure, no cute mascot ; The simplicity refugee — arrived after testing gamified/complex competitors | `13685904641` (tested ~6 apps), `13469176367` (deleted all others), `11904287504` (3-habit caps elsewhere) | To not be re-complicated; unlimited habits; no infantilization ; The long-tenure archivist — years of local history, no backup | `14438257886` (3 years of history) | Export, backup, and an entitlement that does not evaporate ; The analytical reviewer — wants to audit their own progress | `9332848196`, `10985521600`, `9327859322` | Month/year views, filters, search, per-task stats, durable storage ; The motivated beginner | `9592340459`, `10874846443`, `12249396648` | Badges, per-habit reminders, a starting list
- **Direction for us:** do · **Report confidence:** hypotheses (n=1–4 each) · **Generalisable:** yes
- **Review IDs:** `8756804446`, `11375045777`, `13685904641`, `12076364194`, `13469176367`, `11904287504`, `14438257886`, `9332848196`, `10985521600`, `9327859322`, `9592340459`, `10874846443`, `12249396648`
- **Canonical:** C153 Automatic cloud backup on by default — never manual opt-in; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

## Markets and languages

### R11-015 — The written corpus is 6% of the ratings and is not where the market is: this is a Russia- and Latin-America-first product with a US tail — the US contributes 6.3% of ratings and 1 of 33 written reviews; Mexico (76 ratings) and Colombia (67) are almost silent in the written corpus — the single largest blind spot and the highest-value gap to fill with research

- **Where:** Part 0 §10 The written corpus is 6% of the ratings, and it is not where the market is; table (verbatim)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Measure | Value ; Written reviews analysed | 33 ; Ratings across the same 18 storefronts (Apple, 9 Sep 2026) | 537 ; Write rate | 6.15% ; Written mean (n = 33) | 4.576 ; Volume-weighted displayed mean across those 18 storefronts | 4.862 ; Gap | −0.286 stars ; ratings by storefront: RU 170, MX 76, CO 67, BR 49, CL 39, US 34, IN 30, AR 27, ES 25, FR 19, DE 15, UA 13, IT 11, GB 10; written 4.576 vs displayed 4.862, gap −0.286
- **Direction for us:** research · **Report confidence:** external data · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C092 Regional pricing

### R11-040 — No storefront reaches 50 (largest RU 9); per-storefront written n, mean, span, store ratings and displayed rating for 18 storefronts; IN (30 @ 4.80), FR (19 @ 4.47), DE (15 @ 4.40), UA (13 @ 4.92) plus AU, JP, NL, PL, TR have ratings but zero written reviews; crawl polled 85 storefronts

- **Where:** §7.1 No storefront qualifies for standalone analysis table (verbatim); storefronts with ratings but zero written reviews
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** CC | Written n | % of corpus | Mean ★ | 1–2★ | Date span | Store ratings (Apple, 9 Sep 2026) | Displayed ★ ; RU | 9 | 27.27% | 5.00 | 0 | Feb 2023 – Aug 2026 | 170 | 4.95 ; BR | 3 | 9.09% | 4.00 | 1 | Jun 2022 – Aug 2026 | 49 | 4.86 ; CL | 3 | 9.09% | 5.00 | 0 | Aug 2023 – Jul 2024 | 39 | 4.90 ; AR | 2 | 6.06% | 5.00 | 0 | Jun 2022 – Jan 2024 | 27 | 5.00 ; CO | 2 | 6.06% | 5.00 | 0 | Nov 2022 | 67 | 4.81 ; GB | 2 | 6.06% | 4.50 | 0 | Feb 2024 – Dec 2024 | 10 | 4.90 ; CA | 1 | 3.03% | 4.00 | 0 | Jan 2021 | 7 | 4.71 ; CZ | 1 | 3.03% | 4.00 | 0 | Apr 2023 | 4 | 4.75 ; DK | 1 | 3.03% | 5.00 | 0 | Dec 2024 | 3 | 4.67 ; ES | 1 | 3.03% | 5.00 | 0 | Apr 2026 | 25 | 4.84 ; IE | 1 | 3.03% | 1.00 | 1 | Aug 2026 | 2 | 3.00 ; IT | 1 | 3.03% | 5.00 | 0 | Feb 2025 | 11 | 4.82 ; MX | 1 | 3.03% | 5.00 | 0 | Mar 2023 | 76 | 4.87 ; PK | 1 | 3.03% | 1.00 | 1 | Aug 2026 | 6 | 4.17 ; SA | 1 | 3.03% | 5.00 | 0 | Jun 2023 | 3 | 3.67 ; SE | 1 | 3.03% | 5.00 | 0 | Nov 2024 | 2 | 5.00 ; SN | 1 | 3.03% | 5.00 | 0 | Dec 2024 | 2 | 5.00 ; US | 1 | 3.03% | 5.00 | 0 | Jun 2024 | 34 | 4.77
- **Direction for us:** none · **Report confidence:** verbatim [limited evidence] · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R11-041 — Russia is 27% of the written corpus and 32% of all ratings, with a written mean of 5.00 and the highest displayed rating of any storefront with >10 ratings; three of the nine Russian reviews carry the most substantive positive content and two of them date the free-tier baseline — Russian-language reviewers are this product's most engaged writers (fragile: nine reviews cannot establish a market characteristic)

- **Where:** §7.2 The only observation strong enough to record — Russia
- **This app does:** RU-localised, historically free
- **User reaction:** praise
- **Magnitude:** RU 9 of 33 (27.27%); 170 of 537 ratings (31.7%); written 5.00, displayed 4.95
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `12249396648`, `13476851347`, `13469176367`
- **Canonical:** C027 Localise early — it unlocks revenue

### R11-042 — This app's audience is not in the high-spend markets: 86% of its rating base sits outside US/JP/GB/CA/AU/DE/FR, concentrated in RU, MX, CO, BR, CL, IN, AR, ES — a US-anchored $14.99 in-app pack is being shown to a base that is majority Russian and Latin American (a monetization-strategy fact from rating volume, not a review finding)

- **Where:** §7.3 High-spend markets — [limited evidence, cannot be assessed]; This app's audience is not in the high-spend markets
- **This app does:** US-priced IAPs for a RU/LatAm base
- **User reaction:** none
- **Magnitude:** 4 written reviews from US/GB/CA (mean 4.50), 0 from JP/AU/DE/FR; high-spend ratings 89 of 623 (14.3%)
- **Direction for us:** research · **Report confidence:** limited evidence / external · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C092 Regional pricing

### R11-043 — By rating volume the market is RU, MX, CO, BR, CL (74.7% of ratings) but they contribute only a third of written reviews; MX (76 ratings) and CO (67) contribute one and two written reviews — the misalignment is itself the finding

- **Where:** §7.4 High-review-volume markets — the market and the written corpus are badly misaligned
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** RU+MX+CO+BR+CL 401 of 537 ratings (74.7%) vs 11 of 33 written (33.3%)
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R11-045 — Storefront does not predict language; every Russian, Spanish, French and Italian review is 5★ while all sub-5★ reviews are English — most likely a length-and-detail effect (English reviewers write longer and more critically) plus the two 2026 billing complaints happening to be English, not a cultural finding

- **Where:** §7.6 Language vs storefront table (verbatim); every Russian-, Spanish-, French- and Italian-language review is 5★
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Language | n | % | Mean ★ ; English | 11 | 33.3% | 4.00 ; Russian | 9 | 27.3% | 5.00 ; Spanish | 8 | 24.2% | 5.00 ; Portuguese | 3 | 9.1% | 4.00 ; French | 1 | 3.0% | 5.00 ; Italian | 1 | 3.0% | 5.00
- **Direction for us:** none · **Report confidence:** n=33 · **Generalisable:** app-specific
- **Review IDs:** `8800831234`, `9809639708`, `10016901878`, `12119209447`, `12113191512`
- **Canonical:** — (nuance register)

## Dated events and trends

### R11-004 — The cleanest before/after signal in the analysis set: zero reviews below 4★ for five years and three months (no 3★ in the corpus at all), then two 1★ and one 2★ in nine days of August 2026 — all three about money paid, access lost, in three countries, on three different SKUs (annual / 'VIP' / lifetime)

- **Where:** Part 0 §1 Five years without a single bad review, then three in nine days; table (verbatim)
- **This app does:** entitlement failure after paywall retrofit
- **User reaction:** 1★-burst
- **Magnitude:** Window | n | Mean ★ | 1–2★ | 5★ ; 14 Jan 2021 → 13 Apr 2026 | 29 | 4.897 | 0 (0.0%) | 26 (89.7%) ; 17 Aug 2026 → 25 Aug 2026 | 4 | 2.250 | 3 (75.0%) | 1 (25.0%) ; distribution 27/3/0/1/2
- **Direction for us:** must-never-break · **Report confidence:** high-severity (n=3, unanimous) · **Generalisable:** yes
- **Review IDs:** `14438257886`, `14446220984`, `14472099021`
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set; C033 Restore purchase and entitlements must work immediately

### R11-047 — Corpus shape by year and split at the paywall: 33 reviews over 68 months (0.49/month) — not dense enough for month-level claims

- **Where:** Part 8 intro; §8.1 Shape of the corpus year table (verbatim); split at the paywall table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | Mean ★ | 1–2★ | 5★ ; 2021 | 1 | 4.00 | 0 | 0 ; 2022 | 4 | 5.00 | 0 | 4 ; 2023 | 6 | 4.83 | 0 | 5 ; 2024 | 10 | 4.90 | 0 | 9 ; 2025 | 6 | 5.00 | 0 | 6 ; 2026 | 6 | 3.17 | 3 | 3 ;; Window | n | Mean ★ | 1–2★ | 5★ ; Jan 2021 – 13 Apr 2026 | 29 | 4.897 | 0 (0.0%) | 26 (89.7%) ; 17 Aug 2026 – 25 Aug 2026 | 4 | 2.250 | 3 (75.0%) | 1 (25.0%)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R11-048 — A five-year plateau of near-perfect ratings, then a cliff — confidence high on the discontinuity, low on the magnitude; the corpus is thin at both ends: only 2 reviews Jan–Apr 2026 and a 126-day gap before the first billing complaint, so whatever happened in that gap is visible only through one retrospective reference

- **Where:** §8.2 Trend 1 — a five-year plateau of near-perfect ratings, then a cliff; Caution against over-reading (126-day gap)
- **This app does:** paywall retrofit + entitlement failure
- **User reaction:** 1★-burst
- **Magnitude:** 29 consecutive 4–5★ Jan 2021–Apr 2026 mean 4.897; then 3 of next 4 at 1–2★; 126-day gap 13 Apr → 17 Aug 2026
- **Direction for us:** must-never-break · **Report confidence:** high on direction, low on magnitude · **Generalisable:** yes
- **Review IDs:** `13952453631`, `14438257886`
- **Canonical:** C001 Never move a free feature behind the paywall; C033 Restore purchase and entitlements must work immediately

### R11-049 — Free-tier praise runs Jun 2022 → Dec 2025 and then stops: zero of six reviews after 5 Dec 2025 praise the app for being free, and three of them complain about payment — directionally consistent with the retrofit, moderate confidence

- **Where:** §8.3 Trend 2 — the free-tier praise runs from 2022 to Dec 2025 and stops
- **This app does:** free tier removed
- **User reaction:** complaint
- **Magnitude:** 7 'free' praise reviews Jun 2022–Dec 2025; 0 of 6 after; 3 of 6 complain about payment
- **Direction for us:** product-rule · **Report confidence:** moderate · **Generalisable:** yes
- **Review IDs:** `8800831234`, `10285428672`, `10985521600`, `11468101739`, `12221849177`, `12249396648`, `13476851347`
- **Canonical:** C001 Never move a free feature behind the paywall; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R11-050 — All six feature requests fall between Nov 2022 and Jul 2024 and none after — either shipped (supported for dark theme and period statistics) or the corpus thinned; reordering, cloud backup, date filter and search have no evidence of shipping

- **Where:** §8.4 Trend 3 — feature requests concentrate in 2022–2024 and stop
- **This app does:** some requests shipped, some not
- **User reaction:** mixed
- **Magnitude:** 6 requests Nov 2022–Jul 2024; 0 after Jul 2024; 2025–26 has 12 reviews, 10 short praise or billing
- **Direction for us:** research · **Report confidence:** two readings · **Generalisable:** app-specific
- **Review IDs:** `9327859322`, `9332848196`, `9809639708`, `10016901878`, `10985521600`, `11490387774`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

## Positioning

### R11-001 — Daily Habits: Streak Tracker (App Store ID 1523643868) is a six-year-old, deliberately minimal habit tracker by a solo developer, historically free with everything unlocked, now with four in-app purchases and a separate paid twin app; a tiny written corpus of 33 reviews

- **Where:** header lines 1-7
- **This app does:** developer Sergey Belychev; bundle com.free-simple-apps.habits; site daily-habits.app; free download; v1.0.165 12 Jul 2026; first released 25 Jul 2020; min iOS 16.6; Lifestyle; 4+; 70 MB; listing declares EN, FR, DE, IT, PT, RU, ES; IAPs 'Habits PRO Functions' $1.99 / $6.99 / $8.99 + 'Daily Habits All Features Pack' $14.99; paid twin 'Daily Habits: Lifetime Premium' $9.99 (ID 1550003470, bundle …habits.paid) = app #63 in this set; store rank 11
- **User reaction:** praise
- **Magnitude:** 33 reviews, 18 storefronts, 14 Jan 2021 → 25 Aug 2026; distribution 27 / 3 / 0 / 1 / 2; mean 4.576
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R11-011 — 'Functional, no frills and no infantilization. I tested half a dozen similar apps before finding this one and sticking with it' — a direct rejection of the gamified-pet / cute-companion design language that dominates the category (Finch, Habit Rabbit, Roubit, Blossom); the reviewer tested six competitors and chose this app for what it refuses to do; three reviewers explicitly switched from or compared against competitors ('I deleted all the other apps and kept yours')

- **Where:** Part 0 §6 'No infantilization' is the most commercially interesting phrase in the corpus
- **This app does:** non-gamified, adult, plain
- **User reaction:** purchase-driver
- **Magnitude:** 1 review ('no infantilization'); 3 of 33 (9.09%, mean 5.00) switched from competitors
- **Direction for us:** do · **Report confidence:** n=1 / n=3 · **Generalisable:** yes
- **Review IDs:** `13685904641`, `11904287504`, `13469176367`
- **Canonical:** C005 Know which competitors buyers compare against; C117 Mascot / companion character; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

## Anti-patterns

### R11-019 — The developer runs two products against the same feature set: the free app with 4 IAPs and a paid twin at $9.99 up front that has ONE rating in six years — not a distribution channel but a duplicate binary running one version behind, undercutting the in-app lifetime SKU by $5 and creating a second entitlement surface, a plausible contributor to the 'lifetime subscription… suddenly cancelled' confusion

- **Where:** §1.2 Monetization architecture — two products against the same feature set; table (verbatim); The paid twin has one rating in six years
- **This app does:** free app + paid twin app
- **User reaction:** 1★-burst
- **Magnitude:** | Free app (this one) | Paid twin (app #63 in this set) ; Name | Daily Habits: Streak Tracker | Daily Habits: Lifetime Premium ; ID / bundle | 1523643868 / `com.free-simple-apps.habits` | 1550003470 / `com.free-simple-apps.habits.paid` ; Price | Free + 4 IAPs ($1.99–$14.99) | $9.99 up front ; First released | 25 Jul 2020 | 3 Mar 2021 ; Last updated | 12 Jul 2026 (v1.0.165) | 15 Apr 2026 (v1.0.156) ; Ratings (US, 9 Sep 2026) | 34 @ 4.77 | 1 @ 5.00 ; Positioning | *"Become happier with daily habits — built just for you by AI"* | *"Pay once. No ads, no limits."* ; paid twin 1 rating @ 5.00 (US)
- **Direction for us:** dont · **Report confidence:** listing check · **Generalisable:** yes
- **Review IDs:** `14472099021`
- **Canonical:** C179 Do not run a paid twin app beside the free app

## Things not to do

### R11-061 — Resolve the two-product pricing conflict — retire the paid twin (1 rating in 6 years, one version behind) or price it consistently; a user who finds both is asked to pay $5 more for buying inside the product

- **Where:** Part 9 Immediate — disclosure #8 Resolve the two-product pricing conflict
- **This app does:** paid twin $9.99 vs IAP lifetime $14.99
- **User reaction:** complaint
- **Magnitude:** listing check
- **Direction for us:** dont · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C179 Do not run a paid twin app beside the free app

### R11-067 — Do not sell the quiet: four reviewers chose this app because it does not nag, gamify or infantilize — ads and upsell pressure attack the differentiator directly

- **Where:** Part 9 Monetization — Do not sell the quiet
- **This app does:** possible ads in free tier (inferred)
- **User reaction:** praise
- **Magnitude:** 4 of 33 chose it for quiet
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `8756804446`, `11375045777`, `12221849177`, `13685904641`
- **Canonical:** C006 Stay minimal and ad-free; C082 Ads in the free tier; C093 No upsell nagging without a 'never ask again' option

## Things to do

### R11-058 — Reply to the three affected reviewers in the App Store and reinstate their access — three public accusations of fraud, unanswered, on a listing whose displayed rating is 4.86

- **Where:** Part 9 Immediate — billing integrity #5 Reply to the three reviewers in the App Store and reinstate their access
- **This app does:** no developer replies
- **User reaction:** 1★-burst
- **Magnitude:** 3 unanswered fraud accusations
- **Direction for us:** do · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14438257886`, `14446220984`, `14472099021`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R11-064 — Verify the shipped state of month view, date filter, search and per-task statistics against the most detailed review's four asks — the listing claims two of four and no user has confirmed post-ship

- **Where:** Part 9 Near-term product #11 Verify the shipped state of month view, date filter, search and per-task statistics
- **This app does:** claimed shipped
- **User reaction:** none
- **Magnitude:** listing claims 2 of 4
- **Direction for us:** do · **Report confidence:** recommendation (near-term) · **Generalisable:** app-specific
- **Review IDs:** `10985521600`
- **Canonical:** — (nuance register)

## Contradictions

### R11-018 — The app's entire current positioning is unvalidated by user feedback: the AI habit generator is the first thing in the description in every storefront, labelled 'NEW', and several storefronts renamed the app around it ('Habit Builder with AI Planner'; 'Hábitos y metas diarias con IA') — yet zero of 33 reviews mention AI in any language (absence of evidence, not rejection: only 6 reviews postdate Dec 2025)

- **Where:** §1.1 The most striking row is the AI habit generator
- **This app does:** AI habit generator as headline feature
- **User reaction:** none
- **Magnitude:** 0 of 33 mention AI
- **Direction for us:** research · **Report confidence:** listing check · **Generalisable:** yes
- **Canonical:** C056 Don't build AI features on demand grounds

### R11-069 — Positioning tension: the listing now leads with AI while the corpus's strongest positive signal is anti-coaching minimalism ('no infantilization', 'I hate apps that demand set times', 'don't overwhelm me with settings and frills', 'without any imposed junk'); no reviewer has said anything about AI — the highest-risk change is completely unmeasured and the loyal audience selected for the opposite quality; top research priority, not a finding

- **Where:** Part 9 Positioning — a live tension the corpus flags but cannot resolve
- **This app does:** AI-first listing over a minimalist product
- **User reaction:** none
- **Magnitude:** 0 AI mentions; 4 anti-coaching reviews
- **Direction for us:** research · **Report confidence:** recommendation (research) · **Generalisable:** yes
- **Review IDs:** `13685904641`, `8756804446`, `11375045777`, `12221849177`
- **Canonical:** C056 Don't build AI features on demand grounds; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

## Data caveats and method

### R11-002 — Method: n = 33 so one review = 3.03% and lands in the 'very strong' band automatically — the raw count is the primary unit and the percentage is decoration; every finding is a hypothesis with named witnesses; no storefront reaches 50 (largest RU 9) so every country statement is [limited evidence]; 29 of 33 reviews predate 15 Apr 2026 and only 4 come from Aug 2026, and the most consequential findings rest on those four — reported as high-severity because of what they describe and their unanimity, not statistical sufficiency; all 33 read in original language; external store data (iTunes Lookup + US page, 9 Sep 2026) used for listing/price facts

- **Where:** How to read this; ⚠️ The threshold table does not function at this sample size; §10.3 Method; §10.4 Known limitations; §10.5 Counting rules
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** signal bands as standard; 1 review = 3.03%; 29 pre-Apr-2026 / 4 Aug-2026; Part 11 indexes all 33
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R11-009 — Inference, labelled as such: the paid twin's pitch 'no ads, no banners, no subscriptions' implies the free app now shows ads — but no reviewer mentions ads and the corpus is thin after April 2026; flagged as a monitoring item, not a finding

- **Where:** Part 0 §5 Inference, labelled as such: the free app now shows ads (monitoring item)
- **This app does:** ads possibly introduced 2026
- **User reaction:** none
- **Magnitude:** 0 of 33 mention ads; newest review 25 Aug 2026
- **Direction for us:** research · **Report confidence:** inference · **Generalisable:** app-specific
- **Canonical:** C082 Ads in the free tier

### R11-025 — There is no 3★ review at all — reviewers are either satisfied (30 of 33 at 4–5★) or feel wronged (3 of 33 at 1–2★, all Aug 2026); the August reviews are not mild dissatisfaction sliding down the scale, they are a discontinuity

- **Where:** Part 2 3★ — n = 0; the August 2026 reviews are a discontinuity
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 3★ n=0; 4–5★ 30; 1–2★ 3
- **Direction for us:** none · **Report confidence:** band analysis · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R11-030 — 11 of 33 reviews contain any criticism or unmet need and eight of the eleven are 4–5★ — this corpus criticises politely; sixteen complaint themes with type classification

- **Where:** Part 4 COMPLAINTS AND UNMET NEEDS full table (verbatim); 11 of 33 contain any criticism; this corpus criticises politely
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 11 of 33 (33.33%, mean 3.73); Theme | n | % of 33 | Band | Mean ★ | IDs | Type ; Lost purchased entitlement | 3 | 9.09% | High-priority | 1.33 | `14438257886`, `14446220984`, `14472099021` | Broken paid capability ; Distrust / "scam" or "fraud" language | 2 | 6.06% | High-priority | 1.00 | `14438257886`, `14472099021` | Trust ; Support unreachable or unanswered | 2 | 6.06% | High-priority | 1.50 | `14446220984`, `14472099021` | Support ; Drag-to-reorder habits missing | 2 | 6.06% | High-priority | 5.00 | `10016901878`, `11490387774` | Missing capability ; One-step-at-a-time navigation | 2 | 6.06% | High-priority | 4.50 | `10985521600`, `11490387774` | Usability friction ; Period statistics missing (week/month/year) | 2 | 6.06% | High-priority | 4.50 | `9332848196`, `10985521600` | Missing capability ; Paywall retrofit over free features | 1 | 3.03% | Very strong | 1.00 | `14438257886` | Pricing/trust ; Re-charged on an active subscription | 1 | 3.03% | Very strong | 1.00 | `14438257886` | Billing integrity ; Restore-purchases failed after reinstall | 1 | 3.03% | Very strong | 2.00 | `14446220984` | Broken paid capability ; Cloud / iCloud history backup missing | 1 | 3.03% | Very strong | 5.00 | `9327859322` | Missing capability ; Month view missing | 1 | 3.03% | Very strong | 4.00 | `10985521600` | Missing capability ; Date filter / search missing | 1 | 3.03% | Very strong | 4.00 | `10985521600` | Missing capability ; Dark theme missing | 1 | 3.03% | Very strong | 4.00 | `9809639708` | Missing capability *(listing now claims shipped)* ; Lag / performance | 1 | 3.03% | Very strong | 5.00 | `12221849177` | Reliability ; Dated visual design | 1 | 3.03% | Very strong | 5.00 | `12221849177` | Design ; Onboarding limit confusion | 1 | 3.03% | Very strong | 4.00 | `6869680821` | Ambiguous — see §2
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R11-033 — Absences that narrow the problem space: no price objections, no data-loss reports (but fear of data loss drives purchase), no sync/multi-device complaints, no ads complaints despite the paid twin implying ads, no AI feedback, no widget feedback despite the listing headline, no accessibility complaints beyond evening eye-strain, no privacy, no onboarding complaints after 2021, no localization complaints despite 6 languages across 18 storefronts

- **Where:** §4.2 What is not in this corpus
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 0 of 33 for each
- **Direction for us:** none · **Report confidence:** absence findings · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R11-039 — Cannot be claimed: no conversion rate (reviewers are not a sample of users); no claim that most purchases fail (reviewers with a working purchase have little reason to write — a qualitative finding that a defect exists, not a failure rate); no revenue impact

- **Where:** §6.5 What cannot be claimed
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** n=3
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R11-044 — Twelve storefronts have exactly one review; IE and PK at 1.00 are single reviewers, not markets — their significance comes entirely from what they say, corroborated by a third reviewer in a third country

- **Where:** §7.5 Small-storefront caveat — IE at 1.00 and PK at 1.00 are single reviewers, not markets
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 12 single-review storefronts
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R11-051 — Reviews got longer and more substantive, not shorter — the usual late-life drift to short praise does not appear; the recent corpus is the more considered half, a caution against dismissing the Aug 2026 cluster as noise; short bodies inflate the mean everywhere (7 of 33 under 40 chars average 5.00 vs 4.46 for the 26 substantive)

- **Where:** §8.5 Trend 4 — reviews got longer and more substantive, not shorter; table (verbatim)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Window | n | Bodies < 40 chars ; 2021–2024 | 21 | 6 (28.6%) ; 2025–2026 | 12 | 1 (8.3%) ; 7 of 33 (21.2%) under 40 chars mean 5.00; 26 substantive mean 4.46
- **Direction for us:** none · **Report confidence:** low confidence · **Generalisable:** yes
- **Review IDs:** `12221849177`, `12249396648`, `14438257886`, `14462951464`
- **Canonical:** — (nuance register)

### R11-053 — One corpus gap is provably a coverage loss: a reviewer says 'I posted a review in April' and that review is not in the corpus — the App Store keeps one review per user per app, so the April review was overwritten by the August one; paywall complaints began in April not August, the corpus under-counts repeat reviewers, and the true count of paywall complaints is at least 4

- **Where:** §8.7 Corpus gaps — One gap is provably a coverage loss: the overwritten April 2026 review
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 7 gaps of 100+ days (511 days Jan 2021→Jun 2022; 298 days Feb→Dec 2025); ≥4 paywall complaints, 3 is a floor
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `14438257886`
- **Canonical:** — (nuance register)

### R11-070 — Research questions: do MX and CO users share the RU/BR themes (largest blind spot: 26.6% of ratings, 9.1% of written); what exactly moved behind the paywall in Q1 2026 and were unlimited habits part of it; how many users were affected by the entitlement defect (the overwritten April review proves undercounting); is the AI habit generator used and by whom; does the free app now show ads; did dark theme and period statistics actually ship and land well

- **Where:** Part 9 Research questions this corpus cannot answer #1–#6; part 9 #1; part 9 #2; part 9 #3; part 9 #4; part 9 #5; part 9 #6
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** MX+CO 143 of 537 ratings, 3 of 33 written
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** yes
- **Canonical:** — (nuance register)
