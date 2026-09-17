# Cards — report 6

Source: `App Store Reports/6. Streak Tracker - StreakUp - Habit Builder & Breaker (REPORT).md`  
104 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 3
- [Must-haves](#must-haves) — 4
- [Must never break](#must-never-break) — 10
- [Features](#features) — 12
- [Monetization](#monetization) — 8
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 14
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 5
- [Dated events and trends](#dated-events-and-trends) — 7
- [Positioning](#positioning) — 4
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 3
- [Contradictions](#contradictions) — 4
- [Data caveats and method](#data-caveats-and-method) — 21

## Product rules

### R06-100 — Never let the paywall imply a capability the product does not have — a buyer who pays for a feature that isn't there turns a feature request into a refund cause and a cancellation

- **Where:** §4.1 The paywall implied a capability the product does not have; §1.2
- **This app does:** Pro implied multiple daily check-ins; product has none
- **User reaction:** churn
- **Magnitude:** 1 paid churn (2.27%), 4★; 'there are free ones with basic'
- **Direction for us:** product-rule · **Report confidence:** weight raised by a paid churn · **Generalisable:** yes
- **Review IDs:** `13390634274`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R06-101 — A free quantity cap must sit above the number of things a normal user tracks: a cap below that (gym + water + no doomscrolling is already three) cannot demonstrate value and generates public complaint; raising 1 → 2 did not fix it and the ask is for unlimited or near-unlimited

- **Where:** Part 0 §2 cap too tight to demonstrate value; §8.3
- **This app does:** 2-streak cap
- **User reaction:** blocked-conversion
- **Magnitude:** 7 cap complaints (15.91%), mean 3.00; 1 → 2 raise followed by 1-in-9 → 5-in-23
- **Direction for us:** product-rule · **Report confidence:** high-priority (n = 7) · **Generalisable:** yes
- **Conditions:** contrast report 5, where a 2-routine cap sat above core value (morning + night) and was tolerated
- **Review IDs:** `13185604622`, `14477924333`, `14214912053`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R06-102 — One clear price on the paywall, kept stable — users who cannot tell what the price is call the app greedy and a scam regardless of the price level

- **Where:** Part 0 §4 users are objecting to not knowing the price; Part 9 #8
- **This app does:** five prices in eleven months
- **User reaction:** 1★-burst
- **Magnitude:** greed cluster 4 (9.09%), mean 1.00
- **Direction for us:** product-rule · **Report confidence:** high-priority (n = 4) · **Generalisable:** yes
- **Review IDs:** `13628759209`, `13185604622`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

## Must-haves

### R06-012 — Both billing complaints are unanswered support tickets posted into the App Store — what people do when they cannot find an in-app refund path; add a visible in-app 'Manage / cancel / request refund' link to Apple's subscription management

- **Where:** Part 0 §3 Both reviews are also unanswered support tickets; Part 4 Refund requested in public row; §4.2; Part 9 #4
- **This app does:** no visible in-app manage/refund route
- **User reaction:** complaint
- **Magnitude:** Refund requested in public: 2 (4.55%), mean 2.00
- **Direction for us:** must-have · **Report confidence:** meaningful (n = 2) · **Generalisable:** yes
- **Review IDs:** `13771926913`, `13939159292`, `13390634274`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C112 In-app cancellation

### R06-024 — Make the Tracker-vs-Counter mode choice explicit at streak creation with one line explaining each: both modes ship ('An automatic tracker and manual tracker both are good') but onboarding does not make users choose, so a subset lands in the wrong mode and rates 1★ — and 2 of the 5 feature requests ask for a mode that already exists, a discovery failure not a feature gap

- **Where:** Part 0 §7 Both modes ship; Part 6 discovery failure; Part 4 Wants manual check-off row; Part 9 #11
- **This app does:** both modes ship; choice invisible
- **User reaction:** churn
- **Magnitude:** Wants manual check-off / accountability 2 (4.55%), mean 3.00; 2 of 5 actionable requests (11.36%) ask for an existing feature; 2 × 1★ in the wrong mode
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** any app with more than one tracking model per item
- **Review IDs:** `14292633754`, `13085620460`, `13628759209`, `13994050917`
- **Canonical:** C075 Skippable, replayable onboarding tour; C136 When an item can be tracked more than one way, make the user choose the mode at creation

### R06-084 — Add a visible in-app 'Manage / cancel / request refund' link to Apple's subscription management — both billing complaints were filed as public 1★/3★ reviews because there was no other route

- **Where:** Part 9 #4
- **This app does:** no in-app route
- **User reaction:** complaint
- **Magnitude:** 3 reviews
- **Direction for us:** must-have · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R06-012
- **Review IDs:** `13771926913`, `13939159292`, `13390634274`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C112 In-app cancellation

### R06-091 — Make the Tracker-vs-Counter mode choice explicit at streak creation, with one line explaining each — two 1★s are people in the wrong mode; two more asked for a mode that already ships

- **Where:** Part 9 #11
- **This app does:** mode choice invisible
- **User reaction:** churn
- **Magnitude:** 4 reviews
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R06-023, R06-024
- **Review IDs:** `13628759209`, `13994050917`, `13085620460`, `14292633754`
- **Canonical:** C075 Skippable, replayable onboarding tour; C136 When an item can be tracked more than one way, make the user choose the mode at creation

## Must never break

### R06-010 — Charge-vs-quote mismatch: a user quoted $1.99/month was charged $20.99 — 'Said it was $1.99/month and charged my card $20.99?? I want my money back, this is not right' — the highest-severity class of finding, a refund, chargeback and App Review risk, not just a rating risk

- **Where:** Part 0 §3 (Two people were charged amounts they did not agree to — highest-severity finding); Part 9 #2
- **This app does:** paywall quote does not match the charge
- **User reaction:** 1★-burst
- **Magnitude:** 1 of 44 (2.27%), 1★, US, 21 Feb 2026; billing-integrity failures 2 of 44 (4.55%) both unresolved in text
- **Direction for us:** must-never-break · **Report confidence:** highest-severity · **Generalisable:** yes
- **Review IDs:** `13771926913`
- **Canonical:** C029 Billing must be exactly right

### R06-011 — Buying the lifetime unlock does not cancel the in-flight annual subscription, so the user pays both: 'I was on the free trial, and decided to purchase the 14.99 forever choice. But come to find out they charge the 11.99 yearly and the 14.99. So I paid 25.98 and can't figure out how to get the 11.99 back' — a specific, reproducible failure mode; if the flow does not cancel/refund, every trial user who upgrades to lifetime is double-billed

- **Where:** Part 0 §3 lifetime double-billing; §1.2; Part 4 Billing double-charge row; Part 9 #1
- **This app does:** lifetime purchase leaves trial→yearly subscription active
- **User reaction:** complaint
- **Magnitude:** 1 of 44 (2.27%), 3★, US, 9 Apr 2026; $11.99 + $14.99 = $25.98
- **Direction for us:** must-never-break · **Report confidence:** highest-severity · **Generalisable:** yes
- **Side effects:** the reviewer gave 3★ while over-billed by $11.99 and led with 'I like the app' — a person who wanted to stay
- **Conditions:** any app selling both a subscription and a lifetime SKU with a trial that auto-converts
- **Review IDs:** `13939159292`
- **Canonical:** C029 Billing must be exactly right

### R06-014 — The incoherent price ladder is the mechanism behind the 'greed' theme: users are not objecting to a price, they are objecting to not knowing the price — publish one clear price on the paywall and keep it stable

- **Where:** Part 0 §4 mechanism behind the greed theme; Part 4 Distrust row; §1.4; Part 9 #8
- **This app does:** $1.99, ~$5, $11.99, $14.99 quoted/charged, $20.99 charged
- **User reaction:** 1★-burst
- **Magnitude:** Distrust / 'greedy' / deceptive: 4 of 44 (9.09%), mean 1.00 — the angriest cluster in the corpus; 5 prices in 11 months
- **Direction for us:** must-never-break · **Report confidence:** high-priority (n = 4) · **Generalisable:** yes
- **Review IDs:** `13185604622`, `13531820409`, `13628759209`, `13969396065`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R06-016 — A willing buyer could not pay: a 5★ review whose entire body is 'In app purchases are not available. I want to buy the life time subscription for this app' — the single highest-value defect by expected revenue, and it costs nothing to check; may be an India-storefront IAP configuration, an age/region gate or a client bug; needs a same-day answer

- **Where:** Part 0 §5 (A willing buyer could not give the company money); Part 4 IAP unavailable row
- **This app does:** IAP unavailable for at least one user (IN)
- **User reaction:** blocked-conversion
- **Magnitude:** 1 of 44 (2.27%), 5★, IN, 20 Jun 2026
- **Direction for us:** must-never-break · **Report confidence:** highest expected revenue · **Generalisable:** yes
- **Review IDs:** `14203637124`
- **Canonical:** C077 Purchase and signup flow must not leak buyers

### R06-037 — Every purchase or purchase attempt in the corpus went wrong — four for four: one bought the wrong thing because the paywall over-promised, two were over-billed, one could not pay at all; zero reviewers report a satisfying purchase

- **Where:** §1.2 Every single purchase or purchase attempt in this corpus went wrong
- **This app does:** checkout path fails in 4 different ways
- **User reaction:** complaint
- **Magnitude:** 4 of 4 paid-evidence reviewers; 0 satisfying purchases; not a rate — a qualitative fact about the checkout path
- **Direction for us:** must-never-break · **Report confidence:** unambiguous qualitatively · **Generalisable:** yes
- **Conditions:** appendix: emphatically not a claim that 100% of purchases fail; no conversion rate is claimed
- **Review IDs:** `13390634274`, `13771926913`, `13939159292`, `14203637124`
- **Canonical:** C029 Billing must be exactly right; C065 Paying customers are the highest 1★ risk — every paid feature must work; C077 Purchase and signup flow must not leak buyers

### R06-055 — Investigate 'can't add widget': the widget is the most-loved feature, so it failing to install is disproportionately costly — reported inside a 5★ review

- **Where:** Part 4 Widget cannot be added row; Part 9 #5
- **This app does:** widget install failure for at least one user
- **User reaction:** complaint
- **Magnitude:** 1 (2.27%), mean 5.00
- **Direction for us:** must-never-break · **Report confidence:** weak (n = 1), high cost · **Generalisable:** yes
- **Review IDs:** `14389534229`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R06-081 — Audit the lifetime-purchase flow: reproduce trial → lifetime and check whether buying lifetime cancels/refunds an active subscription — every trial user who upgrades may be paying twice

- **Where:** Part 9 #1
- **This app does:** double charge reported
- **User reaction:** complaint
- **Magnitude:** 1 review; named, reproducible path
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R06-011
- **Review IDs:** `13939159292`
- **Canonical:** C029 Billing must be exactly right

### R06-082 — Reconcile the paywall's quoted price with the actual charge ($1.99/mo quoted, $20.99 charged) — a refund, chargeback and App Review risk, not just a rating risk

- **Where:** Part 9 #2
- **This app does:** quote ≠ charge
- **User reaction:** 1★-burst
- **Magnitude:** 1 review
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R06-010
- **Review IDs:** `13771926913`
- **Canonical:** C029 Billing must be exactly right

### R06-085 — Investigate 'can't add widget' — the most-loved feature failing to install is disproportionately costly

- **Where:** Part 9 #5
- **This app does:** widget install failure
- **User reaction:** complaint
- **Magnitude:** 1 review
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R06-055
- **Review IDs:** `14389534229`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R06-088 — Publish one clear price on the paywall and keep it stable — reviewers quoted $1.99, ~$5, $11.99, $14.99 and $20.99 in eleven months

- **Where:** Part 9 #8
- **This app does:** incoherent ladder
- **User reaction:** 1★-burst
- **Magnitude:** §0.4 — 4 'greed' reviews, mean 1.00
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R06-014
- **Canonical:** C113 One stable, disclosed price — no discount wheels

## Features

### R06-018 — The widget is the most-loved feature and is free — for some users the widget IS the product: 'I lwk js use for the widget'; 'I added this to my widgets which is really helping me to do my works irrespective of my mood'; 'you don't have to check it in the app since they have widgets'

- **Where:** Part 0 §6a The widget; Part 3 Widget (positive) row; Part 2 5★
- **This app does:** free home-screen widget
- **User reaction:** praise
- **Magnitude:** 7 mentions (15.91%), mean 5.00; Part 3 positive 6 (13.64%), mean 5.00; 6 of the 7 widget mentions are 5★
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13085620460`, `13093308789`, `13767758923`, `13795256017`, `13845360166`, `14372026009`, `14389534229`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R06-020 — Streak Counter mode — no daily check-in, you only declare when you broke the streak — is praised by the very first review: 'I really like that you don't need daily check-ins, but rather only declare if you broke your streak'

- **Where:** Part 0 §6b No daily check-in required; Part 3 row
- **This app does:** free Streak Counter mode (auto-increment, reset on break)
- **User reaction:** praise
- **Magnitude:** 2 mentions (4.55%), mean 5.00 ('structurally important')
- **Direction for us:** build-free · **Report confidence:** very strong band, n = 2 · **Generalisable:** yes
- **Review IDs:** `13085620460`, `13767758923`
- **Canonical:** C019 Quit-habit / bad-habit mode; C135 Offer both check-in tracking and auto-counting (no daily check-in) per item

### R06-022 — The user defines when their day ends — a BR reviewer switched from competitors specifically because of the midnight-boundary problem: 'Every app is locked to clock hours and I like to count my day based on when I wake up and when I go to sleep… Traditional apps make me lose my goal when I actually didn't lose it! Here I can log the truth of what I live'

- **Where:** Part 0 §6c The user defines what 'a day' means; Part 3 User-defined day boundary row
- **This app does:** user-defined day boundary
- **User reaction:** praise
- **Magnitude:** 1 (2.27%), mean 5.00; the most detailed review in the corpus
- **Direction for us:** must-have · **Report confidence:** meaningful (n = 1) · **Generalisable:** yes
- **Side effects:** the midnight boundary is 'a known killer in this category'
- **Review IDs:** `13672386764`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R06-029 — Streak Tracker mode (manual daily check-in) is free and ships alongside the counter; the one reviewer who names both modes rates 5★

- **Where:** §1.1 Streak Tracker mode (manual check-in) row
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** Both modes (auto + manual) 1 (2.27%), mean 5.00
- **Direction for us:** build-free · **Report confidence:** meaningful (n = 1) · **Generalisable:** yes
- **Review IDs:** `14292633754`, `14271116952`
- **Canonical:** C135 Offer both check-in tracking and auto-counting (no daily check-in) per item

### R06-030 — Notifications/reminders are free and draw no complaints: the one notification mention is positive and there are zero notification-failure reports

- **Where:** §1.1 Notifications / reminders row; Part 3 Notifications work row; §4.2 no notification-failure complaints
- **This app does:** free reminders
- **User reaction:** praise
- **Magnitude:** Notifications work 1 (2.27%), mean 5.00; 0 notification-failure complaints
- **Direction for us:** build-free · **Report confidence:** meaningful (n = 1) · **Generalisable:** yes
- **Review IDs:** `14292633754`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C039 Reminders fire reliably, once

### R06-031 — Backfilling or editing a missed day is free and is named as a reason for 5★: 'you can edit your calendar in case you miss a day… It's free too'

- **Where:** §1.1 Backfill / edit a missed day row; Part 3 row
- **This app does:** free backfill
- **User reaction:** praise
- **Magnitude:** 1 (2.27%), mean 5.00
- **Direction for us:** build-free · **Report confidence:** meaningful (n = 1) · **Generalisable:** yes
- **Review IDs:** `14271116952`
- **Canonical:** C010 Backfill missed days / edit start date

### R06-032 — Trophy tiers (Spark → Legend) and sharing milestones to socials are free and praised by free users

- **Where:** §1.1 Trophies (Spark → Legend), sharing to socials row; Part 3 Trophies / gamification and Social sharing of milestones rows
- **This app does:** free trophies + social share
- **User reaction:** praise
- **Magnitude:** Trophies / gamification 2 (4.55%), mean 5.00; Social sharing of milestones 1 (2.27%), mean 5.00
- **Direction for us:** build-free · **Report confidence:** very strong band (n = 2) · **Generalisable:** yes
- **Review IDs:** `13093308789`, `13845360166`
- **Canonical:** C024 Streaks / gamification; C101 Milestones, achievements, celebration

### R06-033 — Streak Freeze is paid; one reviewer names it both as a complaint ('streak freezes and unlimited streaks is only available if you pay') and as a thing worth having — the report says sell the freeze and the streak count, not cosmetics

- **Where:** §1.1 Streak Freeze PAID row; §1.3 #3; Part 4 Streak Freeze locked behind paywall row; Part 9 #10
- **This app does:** paid Streak Freeze
- **User reaction:** mixed
- **Magnitude:** Streak Freeze locked 1 (2.27%), mean 4.00; only explicit source
- **Direction for us:** build-paid · **Report confidence:** weak (n = 1) · **Generalisable:** yes
- **Review IDs:** `14214912053`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R06-056 — Lack of customization and poor UI are the grounds on which a user says StreakUp loses to Days Since — 'horrible UI and lack of customizability' — even though no reviewer mentions the paid themes/icons

- **Where:** Part 4 UI quality / customization lacking row; Part 6 More customization request
- **This app does:** custom themes & icons paid; UI judged poor by one user
- **User reaction:** churn
- **Magnitude:** 1 (2.27%), mean 1.00
- **Direction for us:** research · **Report confidence:** weak (n = 1) · **Generalisable:** yes
- **Conditions:** tension with R06-034: customisation is absent from praise and from purchase talk, present only as a competitor comparison
- **Review IDs:** `13557096013`
- **Canonical:** — (nuance register)

### R06-057 — Support counting completions, not just days — 'twice a day', '3× per week': the one real feature gap, described from two angles ('Does NOT allow for multiple streaks for one task, within a day. I purchased the Pro Version in hopes it would have'; teeth-brushing twice a day: 'you have to log everyday, not necessarily when goal is accomplished daily'), persisting nine months

- **Where:** §4.1 The one real feature gap: multiple logs per day; Part 4 Cannot log a task more than once per day and Friction rows; Part 6; §8.5 #4; Part 9 #12
- **This app does:** one log per day per streak at every tier
- **User reaction:** churn
- **Magnitude:** Cannot log a task more than once per day 2 (4.55%), mean 4.00; Friction: must log daily even when goal met 1 (2.27%), 4.00; Nov 2025 → Aug 2026, both from paying-intent users; one paid churn
- **Direction for us:** must-have · **Report confidence:** thin (n = 2), weight raised by a paid churn · **Generalisable:** yes
- **Review IDs:** `13390634274`, `14471219702`
- **Canonical:** C043 Flexible / custom frequency

### R06-065 — Optional manual check-in alongside counter mode is requested as a future feature ('that could be something to add in the future') by a 5★ user sitting in counter mode — it already ships

- **Where:** Part 6 feature request — optional manual check-in alongside counter mode
- **This app does:** ships (Streak Tracker mode) but invisible
- **User reaction:** praise
- **Magnitude:** 1 (2.27%), 5★
- **Direction for us:** must-have · **Report confidence:** discovery failure · **Generalisable:** yes
- **Review IDs:** `13085620460`, `14292633754`
- **Canonical:** C135 Offer both check-in tracking and auto-counting (no daily check-in) per item; C136 When an item can be tracked more than one way, make the user choose the mode at creation

### R06-092 — Support counting completions, not just days — 'twice a day', '3× per week'; nine months of the same request, including one paid churn

- **Where:** Part 9 #12
- **This app does:** one log per day
- **User reaction:** churn
- **Magnitude:** 2 reviews
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R06-057
- **Review IDs:** `13390634274`, `14471219702`
- **Canonical:** C043 Flexible / custom frequency

## Monetization

### R06-007 — The 2-streak free cap is the single most-named thing in the corpus and the median cap-complainer likes the app: ratings 1, 1, 4, 3, 3, 5, 4 — 'Love the app, just wish i could have more than 2 streaks without paying' (4★); 'it's got all it needs to have u can only have 2 streaks on the free plan tho' (5★); 'I'm personally a go-getter so I would like to have more than 2 streaks' (4★)

- **Where:** Part 0 §2 (The 2-streak free cap is the single most-named thing in the corpus); §1.1; Part 4 table; §8.3; Part 9 #6
- **This app does:** free tier = 2 streaks (was 1); unlimited streaks paid
- **User reaction:** blocked-conversion
- **Magnitude:** 7 of 44 (15.91%), mean 3.00 (Part 4: 'Free streak cap (1→2)' 7, 15.91%, 3.00); 5 of 7 in May–Aug 2026 (21.7% of that window) at mean 3.4 vs earlier two at 1.0; 4 of 7 are US
- **Direction for us:** build-free · **Report confidence:** high-priority (n = 7) · **Generalisable:** yes
- **Side effects:** the ask in the text is for unlimited or near-unlimited, not for 3
- **Conditions:** a streak counter where users track several streaks at once (gym + water + no doomscrolling is already three); contrast report 5, where a 2-routine cap sat above the point of core value and was tolerated
- **Review IDs:** `13185604622`, `13969396065`, `14214912053`, `14267106974`, `14346310474`, `14372026009`, `14477924333`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R06-034 — Cosmetics carry part of the price tag and none of the perceived value: the listing sells Premium as 'unlimited streaks, custom themes & icons', reviewers only ever ask for the first — zero of 44 reviews mention themes or icons in any context; stop selling Premium on themes and icons

- **Where:** §1.1 A note on the paid feature set; Part 9 #10
- **This app does:** custom themes & icons paid
- **User reaction:** none
- **Magnitude:** 0 of 44 mention themes or icons
- **Direction for us:** dont · **Report confidence:** observed absence · **Generalisable:** unknown
- **Conditions:** n = 44; a streak-counter audience; contrast report 3 where widget customisation was the #1 purchase trigger and report 1 where icon themes were a minor purchase factor
- **Canonical:** C018 App-icon themes; C133 Gate on capability, not on quantity

### R06-040 — Lead with the one-time/lifetime SKU: three of the four paid-evidence reviewers engage with it (one asked to buy it, one bought it, one welcomed it — 'They did add a new feature where you can pay to have a lifetime subscription (which is nice)'), all positively in principle, while four separate reviewers object to subscriptions as such

- **Where:** §1.3 #2 A lifetime/one-time option instead of a subscription; §8.4; Part 9 #7
- **This app does:** yearly $11.99 subscription + $14.99 lifetime (added mid-corpus)
- **User reaction:** purchase-driver
- **Magnitude:** 3 of 4 paid-evidence reviewers engage with lifetime; 4 reject subscriptions; 'the clearest packaging signal in the corpus'
- **Direction for us:** product-rule · **Report confidence:** clearest packaging signal · **Generalisable:** yes
- **Review IDs:** `14203637124`, `13939159292`, `14214912053`, `14491149862`, `14307898374`, `14205874183`, `13185604622`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R06-041 — A 1★ review whose entire body is 'You gotta pay a subscription😭' — a subscription as such, not its price, is the objection

- **Where:** §1.3 subscription objection quote; §0.1
- **This app does:** subscription required for more than 2 streaks
- **User reaction:** 1★-burst
- **Magnitude:** 1 (2.27%), 1★, NO; May–Aug 2026's only 1–2★
- **Direction for us:** product-rule · **Report confidence:** quoted (n = 1) · **Generalisable:** yes
- **Review IDs:** `14491149862`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R06-043 — Price objection / 'make it free': a 3★ that says only 'make it free / pls', and a UA reviewer objecting to a ~5-dollar subscription ('5 баксов')

- **Where:** §1.4 'make it free / pls'; Part 4 Price objection / 'make it free' row
- **This app does:** yearly/monthly subscription
- **User reaction:** complaint
- **Magnitude:** 6 (13.64%), mean 2.00
- **Direction for us:** research · **Report confidence:** high band (n = 6) · **Generalisable:** yes
- **Review IDs:** `13185604622`, `13939159292`, `13969396065`, `14205874183`, `14307898374`, `14491149862`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R06-086 — Raise the free cap well above 2 — test 5, or unlimited-with-cosmetics-paid — as an experiment with conversion and rating as joint metrics; do not ship blind

- **Where:** Part 9 #6
- **This app does:** 2-streak cap
- **User reaction:** blocked-conversion
- **Magnitude:** §0.2, §8.3 — 7 reviews, mean 3.00, 5 of them in the last 4 months
- **Direction for us:** build-free · **Report confidence:** experiment · **Generalisable:** yes
- **Conditions:** evidence: R06-007, R06-075; see R06-035 on the cosmetics fallback
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R06-087 — Lead with the one-time/lifetime SKU — three of four paid-evidence reviewers engage with it positively; four separate reviewers reject subscriptions outright

- **Where:** Part 9 #7
- **This app does:** lifetime secondary to yearly
- **User reaction:** purchase-driver
- **Magnitude:** §1.3, §8.4 — 3 of 4; 4 reject subscriptions
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R06-040
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R06-090 — Stop selling Premium on themes and icons — not one of 44 reviewers mentions them; sell the freeze and the streak count

- **Where:** Part 9 #10
- **This app does:** Premium = unlimited streaks + themes + icons
- **User reaction:** none
- **Magnitude:** §1.1 — 0 of 44
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** unknown
- **Conditions:** evidence: R06-033, R06-034
- **Canonical:** C018 App-icon themes; C133 Gate on capability, not on quantity

## Tactics the app used

### R06-103 — Tactic: StreakUp raised the free allowance from 1 streak to 2 (between Sep 2025 and Apr 2026). Outcome: the cap-complaint rate rose (1 in the first 9 reviews → 5 in the last 23; 11.1% → 8.3% → 21.7% by window), but the complaints' tone moved from 'scam' (mean 1.0) to 'love it, want more' (mean 3.4)

- **Where:** Part 0 §2 cap moved once; §8.3 — tactic outcome
- **This app does:** raised cap 1 → 2
- **User reaction:** mixed
- **Magnitude:** 1-in-9 → 5-in-23; window share 11.1% → 8.3% → 21.7%; mean 1.0 → 3.4
- **Direction for us:** undecided · **Report confidence:** observed (small n); inferred from text, no changelog · **Generalisable:** yes
- **Conditions:** a small raise inside a quantity-gated model; a large raise was not tried
- **Review IDs:** `13185604622`, `13969396065`, `14477924333`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R06-104 — Tactic: StreakUp added a $14.99 lifetime 'forever' SKU next to the $11.99 yearly plan in spring 2026. Outcome: welcomed ('which is nice'), actively sought (an IN user tried to buy it), and bought — but the upgrade path from an active trial/yearly subscription double-billed the buyer

- **Where:** §8.4 lifetime SKU appeared mid-corpus — tactic outcome; Part 0 §3
- **This app does:** added lifetime alongside subscription
- **User reaction:** purchase-driver
- **Magnitude:** 3 of 4 paid-evidence reviewers engage, all positively in principle; 1 double charge ($25.98)
- **Direction for us:** product-rule · **Report confidence:** clearest packaging signal · **Generalisable:** yes
- **Side effects:** a new SKU must ship with its cross-grade billing path tested
- **Review IDs:** `13939159292`, `14203637124`, `14214912053`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C029 Billing must be exactly right

## Insights (the why)

### R06-003 — A genuinely liked, genuinely differentiated streak counter is converting its own goodwill into 1★ reviews because the free tier caps at 2 streaks, the upsell is loud, the price ladder is incoherent, and at least two people were billed an amount they did not agree to — while the one thing users unanimously love, the widget, is free and barely mentioned in the store listing

- **Where:** Part 0 executive summary line
- **This app does:** 2-streak cap, launch upsell, shifting prices, billing defects; free widget buried in listing
- **User reaction:** mixed
- **Magnitude:** report gives none beyond the sections below (47.73% touch money; 7 cap complaints; 2 billing failures; 7 widget mentions)
- **Direction for us:** product-rule · **Report confidence:** headline · **Generalisable:** yes
- **Side effects:** the goodwill is still there — the damage is recoverable by packaging, not product work
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R06-004 — Nearly half the written corpus is about money and all the damage is there: 21 of 44 (47.73%) touch monetization, 16 (36.36%) are negative about it at mean 2.44 vs corpus 3.89; 6 of 8 one-star reviews (75%, 7 of 8 counting the body 'You gotta pay a subscription😭') and all 5 three-star reviews are monetization complaints

- **Where:** Part 0 §1 (Nearly half the written corpus is about money, and it is where all the damage is)
- **This app does:** freemium with 2-streak cap + subscription + lifetime
- **User reaction:** 1★-burst
- **Magnitude:** 21/44 (47.73%) touch monetization; 16/44 (36.36%) negative, mean 2.44 vs corpus 3.89; 1★: 6 of 8 (75%), 7 of 8 incl. 14491149862; 3★: 5 of 5; distribution 24 / 7 / 5 / 0 / 8
- **Direction for us:** product-rule · **Report confidence:** high-priority (n-limited) · **Generalisable:** yes
- **Review IDs:** `13185604622`, `13531820409`, `13557096013`, `13628759209`, `13771926913`, `13969396065`, `14491149862`, `13939159292`, `14205874183`, `14267106974`, `14307898374`, `14346310474`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R06-005 — Interpretation: this app does not have a product problem at its core — it has a packaging and billing problem sitting on top of a product people like; fix the packaging and the 3★ band converts almost mechanically, because every one of those five reviewers said something positive in the same breath

- **Where:** Part 0 §1 Interpretation
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 3★ band = 5 reviews, all monetization, all with praise
- **Direction for us:** do · **Report confidence:** interpretation · **Generalisable:** yes
- **Side effects:** packaging fixes (cap, one price, paywall timing, lifetime-first) are cheaper than feature work and aim at the most convertible band
- **Review IDs:** `13939159292`, `14205874183`, `14267106974`, `14307898374`, `14346310474`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R06-008 — The cap is a conversion problem being paid for in stars: these are people who hit the wall, did not buy, and rated on the way past; the cap does two jobs and fails at both — too tight to demonstrate value, loud enough to generate public complaint

- **Where:** Part 0 §2 This is a conversion problem being paid for in stars
- **This app does:** 2-streak cap
- **User reaction:** blocked-conversion
- **Magnitude:** 7 cap complaints; ratings 1,1,4,3,3,5,4
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Conditions:** holds when the cap lands below the number of things a normal user wants to track
- **Review IDs:** `14477924333`, `14372026009`, `14214912053`, `14346310474`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R06-017 — Every reviewer who reports a concrete behaviour-change outcome rated 5★ — quitting a bad habit, self-harm recovery, fitness, writing a first draft, general discipline

- **Where:** Part 0 §6 (What people actually love); Part 3 Behaviour-change outcome row; Part 2 5★
- **This app does:** streak counter
- **User reaction:** 5★-burst
- **Magnitude:** 9 of 44 (20.45%), mean 5.00, zero exceptions
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13093308789`, `13672386764`, `13795256017`, `13837160367`, `13845360166`, `13891333657`, `14093501015`, `14349062008`, `14389534229`, `14311507310`
- **Canonical:** — (nuance register)

### R06-039 — The stated purchase trigger is a short list, led by more streaks — 'I'm personally a go-getter so I would like to have more than 2 streaks'; demand is explicit and repeated

- **Where:** §1.3 What would trigger a purchase #1 More streaks
- **This app does:** unlimited streaks paid
- **User reaction:** purchase-driver
- **Magnitude:** 4 reviewers name more streaks
- **Direction for us:** undecided · **Report confidence:** explicit, repeated · **Generalisable:** yes
- **Conditions:** tension: the same demand is the #1 complaint — whether it converts or just costs stars is research question #1
- **Review IDs:** `14214912053`, `14477924333`, `14346310474`, `14372026009`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R06-044 — 5★ is driven by four things in order: a behaviour-change outcome achieved (9, all 5★), the widget (6 of 7 mentions 5★), simplicity, and perceived free-ness (3 reviews praise the app as free, mean 5.00)

- **Where:** Part 2 5★ — n = 24 (54.55%)
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** 5★ n = 24 (54.55%); outcome 9; widget 6 of 7; simplicity 4 named; free-ness 3 at 5.00
- **Direction for us:** do · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `13837160367`, `13891333657`, `14311507310`, `14349062008`, `13845360166`, `13672386764`, `14389534229`, `13795256017`, `14093501015`, `13466777630`, `13767758923`, `14146487084`, `14271116952`
- **Canonical:** — (nuance register)

### R06-047 — The 4★ band is 'good app, but…': four of seven name a specific gap — cancelled over a missing feature, cap + freeze, must log daily, cap; the remaining three are low-information

- **Where:** Part 2 4★ — n = 7 (15.91%) — the 'almost, but the cap' band
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 4★ n = 7 (15.91%); 4 of 7 'good app, but'
- **Direction for us:** do · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `13390634274`, `14214912053`, `14471219702`, `14477924333`, `13276224447`, `13564532421`, `14456589309`
- **Canonical:** — (nuance register)

### R06-048 — The 3★ band is 100% monetization and the most convertible band in the corpus: not one of the five is about a bug, a crash or a missing feature other than the paywall, and every one says or implies they like the app — it converts on packaging alone

- **Where:** Part 2 3★ — n = 5 (11.36%) — 100% monetization
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 3★ n = 5 (11.36%), 5 of 5 monetization
- **Direction for us:** do · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `13939159292`, `14205874183`, `14267106974`, `14307898374`, `14346310474`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R06-050 — Only one of the eight 1★ reviews alleges the app is broken, with no detail; seven of eight are about money, expectations or comparison — there is no reliability crisis, there is a trust and packaging crisis

- **Where:** Part 2 1★ Only one of the eight 1★ reviews alleges the app is broken; Part 4 'App doesn't work' row
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1 of 8 alleges broken ('App doesn't work' 1, 2.27%, mean 1.00); 7 of 8 money / expectations / comparison
- **Direction for us:** product-rule · **Report confidence:** observed · **Generalisable:** yes
- **Conditions:** a 13-month-old, local-only, single-device app; contrast report 5 where reliability produced the volume of 2–3★
- **Review IDs:** `13531820409`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R06-052 — Simplicity is praised and conditional: 'Great if you want a simple streak app but only lets you have 2 streaks for free'; 'Super simple et super efficace'

- **Where:** Part 3 Simplicity / ease row
- **This app does:** minimal streak counter
- **User reaction:** praise
- **Magnitude:** Simplicity / ease 7 (15.91%), mean 4.57
- **Direction for us:** product-rule · **Report confidence:** high band (n = 7) · **Generalisable:** yes
- **Review IDs:** `13390634274`, `13466777630`, `13767758923`, `13795256017`, `14146487084`, `14271116952`, `14346310474`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R06-053 — Explicit recommendations come from outcome and widget reviewers — the same people who report behaviour change

- **Where:** Part 3 Explicit recommendation row
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Explicit recommendation 6 (13.64%), mean 4.83
- **Direction for us:** do · **Report confidence:** high band (n = 6) · **Generalisable:** yes
- **Review IDs:** `13093308789`, `13767758923`, `13795256017`, `13845360166`, `14093501015`, `14456589309`
- **Canonical:** — (nuance register)

### R06-058 — The pattern of absence is itself the finding: zero crash reports ('App never has any glitches and works perfectly!'), zero data-loss, zero sync/multi-device complaints, no notification failures, no support-contact complaints as such, no localization complaints despite six declared languages and four non-English reviews, no Apple Watch mentions — alongside dense monetization complaints

- **Where:** §4.2 What is *not* in this corpus
- **This app does:** local-only storage; no Watch; six languages
- **User reaction:** praise
- **Magnitude:** 0 crash; 0 data loss; 0 sync; 0 notification failure; 0 localisation; 0 Watch; Stability / no glitches 1 (2.27%), mean 4.00
- **Direction for us:** none · **Report confidence:** absence (proves little at n = 44) · **Generalisable:** yes
- **Side effects:** sync may become a complaint if users ever expect it
- **Review IDs:** `14214912053`, `14292633754`
- **Canonical:** — (nuance register)

### R06-075 — After the cap was raised 1 → 2 the complaint migrated from 'this app is a scam' to 'I like this app, please let me have more streaks' — the later cap complaints rate higher, a better problem to have and a clearer buy signal

- **Where:** §8.3 Trend 2 — the free cap became *more* discussed, not less
- **This app does:** cap raised 1 → 2
- **User reaction:** blocked-conversion
- **Magnitude:** 5 of 7 cap complaints in May–Aug 2026 (21.7% of window) at mean 3.4 vs earlier two at 1.0
- **Direction for us:** undecided · **Report confidence:** observed (small n) · **Generalisable:** yes
- **Review IDs:** `13969396065`, `14267106974`, `14346310474`, `14372026009`, `14477924333`, `13185604622`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

## Audiences

### R06-061 — Habit-breaking (abstinence streaks) is over-represented relative to habit-building and produces the strongest emotional reviews: all four abstinence reviewers rated 5★ — the segment the product fits best and the one Streak Counter mode was built for

- **Where:** Part 5 habit-breaking over-represented; All four abstinence reviewers rated 5★
- **This app does:** Streak Counter mode (auto-increment unless reset)
- **User reaction:** praise
- **Magnitude:** 4 abstinence reviewers, 4 × 5★
- **Direction for us:** do · **Report confidence:** small n, unanimous · **Generalisable:** yes
- **Side effects:** abstinence users often track several streaks at once, so they are the segment least served by the 2-streak cap
- **Review IDs:** `13837160367`, `13891333657`, `14311507310`, `14349062008`
- **Canonical:** C019 Quit-habit / bad-habit mode

### R06-062 — The app is being used as a self-harm recovery aid — 'This app helped me get over my self harm and I am forever grateful' — on a 12+ app with no visible crisis-resource surface; decide deliberately whether a broken self-harm or substance streak shows supportive copy and a resource link instead of the current neutral reset — right now the decision has been made by default

- **Where:** Part 5 Safety-adjacent, and it needs a decision; Part 9 #14
- **This app does:** neutral reset, no resource link
- **User reaction:** praise
- **Magnitude:** 1 (2.27%), 5★, US; recorded not as a trend
- **Direction for us:** do · **Report confidence:** safety-adjacent · **Generalisable:** yes
- **Review IDs:** `14349062008`, `13837160367`, `14311507310`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

## Markets and languages

### R06-066 — Per-storefront table — every row [limited evidence]; largest storefront US at 23; all 44 counted in every global number

- **Where:** §7.1 No storefront qualifies for standalone analysis table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** CC | n | % of corpus | Mean ★ | 1★ | 5★ | Neg-monetization | Store rating (Apple, 9 Sep 2026) ; US | 23 | 52.27% | 3.96 | 4 | 14 | 9 (39.1%) | 188 ratings @ 4.65 ; CA | 5 | 11.36% | 3.80 | 1 | 2 | 3 (60.0%) | 21 @ 4.57 ; GB | 4 | 9.09% | 3.50 | 1 | 1 | 1 | 25 @ 4.56 ; FR | 2 | 4.55% | 5.00 | 0 | 2 | 0 | 17 @ 4.94 ; IN | 2 | 4.55% | 5.00 | 0 | 2 | 0 | 20 @ 4.85 ; AU | 1 | 2.27% | 4.00 | 0 | 0 | 0 | 12 @ 4.83 ; BR | 1 | 2.27% | 5.00 | 0 | 1 | 0 | 2 @ 5.00 ; IL | 1 | 2.27% | 5.00 | 0 | 1 | 0 | — ; TR | 1 | 2.27% | 5.00 | 0 | 1 | 0 | 2 @ 3.00 ; CZ | 1 | 2.27% | 3.00 | 0 | 0 | 1 | — ; UA | 1 | 2.27% | 3.00 | 0 | 0 | 1 | — ; NG | 1 | 2.27% | 1.00 | 1 | 0 | 0 | — ; NO | 1 | 2.27% | 1.00 | 1 | 0 | 1 | 2 @ 3.00
- **Direction for us:** none · **Report confidence:** verbatim, limited evidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R06-067 — English-speaking storefronts carry the monetization anger: US + CA + GB = 32 reviews (72.7%) at mean 3.88 hold 13 of the 16 negative-monetization reviews (81.3%), while the 10 non-English-storefront reviews average 4.10 and contribute 3 — fragile, possibly just that English speakers write more and longer, and not evidence that non-English markets accept the pricing (UA and NO both object to price)

- **Where:** §7.1 The only observation strong enough to record
- **This app does:** same pricing everywhere
- **User reaction:** complaint
- **Magnitude:** US+CA+GB 32 (72.7%), mean 3.88, 13/16 neg-monetization (81.3%); non-English 10, mean 4.10, 3/16
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** unknown
- **Review IDs:** `14307898374`, `14491149862`
- **Canonical:** — (nuance register)

### R06-069 — The US is the only high-volume storefront and the worst-rated one with more than two reviews: 3.96 written vs 4.10 for all non-US and vs its own 4.65 tap rating; every billing complaint and 4 of 7 cap complaints are US

- **Where:** §7.3 High-review-volume markets
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** US 23 of 44 (52.27%); 3.96 vs 4.10 non-US; tap 4.65; 2/2 billing, 4/7 cap
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `13771926913`, `13939159292`
- **Canonical:** — (nuance register)

### R06-071 — The listing declares six languages but four of them (DE, JP-adjacent, ES, IT) produced zero reviews — localisation may be shipped but unmarketed; research whether those markets are absent or just unmonetised

- **Where:** Part 9 research questions — Are DE/JP/ES/IT genuinely absent, or unmonetised?; §4.2 no localization complaints
- **This app does:** EN, FR, DE, IT, PT, ES declared
- **User reaction:** none
- **Magnitude:** 0 reviews from DE, JP, ES, IT; 0 localization complaints; 4 non-English reviews (FR ×2, pt-BR, ru)
- **Direction for us:** research · **Report confidence:** open question · **Generalisable:** unknown
- **Canonical:** C027 Localise early — it unlocks revenue

### R06-083 — Check IAP availability by storefront, starting with India — a 5★ user with intent to buy could not transact; highest expected-revenue defect in the corpus

- **Where:** Part 9 #3
- **This app does:** IAP unavailable (IN)
- **User reaction:** blocked-conversion
- **Magnitude:** 1 review
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R06-016
- **Review IDs:** `14203637124`
- **Canonical:** C077 Purchase and signup flow must not leak buyers

## Dated events and trends

### R06-009 — The free cap moved once and it did not solve the problem: the earliest cap complaint (26 Sep 2025) says 'only one streak'; every cap complaint from 18 Apr 2026 onward says two — the allowance was raised 1 → 2 and the complaint rate went up, not down; going from 1 to 2 was not enough and there is no evidence 3 would be either

- **Where:** Part 0 §2 The cap moved once already, and it did not solve the problem; §1.1 free-tier change
- **This app does:** raised free allowance 1 → 2 between Sep 2025 and Apr 2026
- **User reaction:** complaint
- **Magnitude:** 1 cap complaint in the first 9 reviews → 5 in the last 23; Window | Cap complaints | Share of window ; Sep–Dec 2025 | 1 | 11.1% ; Jan–Apr 2026 | 1 | 8.3% ; May–Aug 2026 | 5 | 21.7%
- **Direction for us:** undecided · **Report confidence:** observed (small n) · **Generalisable:** yes
- **Conditions:** an incremental cap raise inside a quantity-gated model; the ask is for unlimited
- **Review IDs:** `13185604622`, `13969396065`, `14267106974`, `14346310474`, `14372026009`, `14477924333`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R06-013 — Price ladder reconstructed from reviewers: five different numbers in eleven months from six reviewers in a corpus of 44

- **Where:** Part 0 §4 (The price ladder is incoherent) table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Price named | SKU implied | Source | Date ; $1.99 | monthly, or a "Pro" unlock | `13390634274` (*"Thankfully I only paid $1.99"*), `13771926913` (*"Said it was $1.99/month"*) | Nov 2025, Feb 2026 ; ~$5 | subscription (UAH/USD, reviewer says "5 баксов") | `14307898374` | Jul 2026 ; $11.99 | yearly | `13628759209` (*"What is the $11.99 for?"*), `13939159292` | Jan 2026, Apr 2026 ; $14.99 | lifetime / "forever" | `13939159292` | Apr 2026 ; $20.99 | *actually charged* against a $1.99/mo quote | `13771926913` | Feb 2026
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13390634274`, `13771926913`, `14307898374`, `13628759209`, `13939159292`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R06-072 — Quarterly shape: the app launched 6 Aug 2025, first review 1 Sep 2025; 2026 Q3 holds 17 of 44 reviews

- **Where:** §8.1 Shape of the corpus quarter table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Quarter | n | Mean ★ | 1–2★ | 5★ ; 2025 Q3 | 3 | 3.67 | 1 | 2 ; 2025 Q4 | 6 | 3.17 | 2 | 1 ; 2026 Q1 | 9 | 4.11 | 2 | 7 ; 2026 Q2 | 9 | 3.56 | 2 | 4 ; 2026 Q3 | 17 | 4.24 | 1 | 10
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R06-073 — Three windows: rating and 1–2★ share improved sharply in May–Aug 2026 while negative-monetization share stayed flat

- **Where:** §8.1 three comparable windows table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Window | n | Mean ★ | 1–2★ | 5★ | Neg-monetization ; Sep–Dec 2025 (launch) | 9 | 3.33 | 33.3% | 33.3% | 44.4% ; Jan–Apr 2026 | 12 | 3.50 | 33.3% | 58.3% | 33.3% ; May–Aug 2026 | 23 | 4.30 | 4.3% | 60.9% | 34.8%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R06-074 — The rating improved (mean 3.33 → 4.30, 1–2★ share 33.3% → 4.3%) under a fast release cadence (v1.13.4 thirteen months after launch) — but partly compositionally: the latest window has proportionally more short low-information 5★s, and negative-monetization share did not improve at all (44.4% → 33.3% → 34.8%); what fell away was the clone and doesn't-work criticism, launch-window artefacts from Dec 2025

- **Where:** §8.2 Trend 1 — the rating improved, and the improvement is real but partly compositional
- **This app does:** shipped continuously; pricing unchanged in effect
- **User reaction:** mixed
- **Magnitude:** mean 3.33 → 3.50 → 4.30; 1–2★ 33.3% → 33.3% → 4.3% (one review); neg-monetization 44.4% → 33.3% → 34.8%; volume 9 → 12 → 23
- **Direction for us:** none · **Report confidence:** observed, partly compositional · **Generalisable:** yes
- **Side effects:** a rising rating can hide a flat monetization-anger share
- **Conditions:** no version field in the data — trends may reflect audience mix as much as product change
- **Review IDs:** `14491149862`, `13531820409`, `13557096013`
- **Canonical:** — (nuance register)

### R06-076 — The lifetime SKU appeared mid-corpus and was received well: first evidence of a lifetime purchase 9 Apr 2026 ($14.99 'forever choice'), demand for it 20 Jun 2026, first explicit framing as new 23 Jun 2026 ('which is nice')

- **Where:** §8.4 Trend 3 — the lifetime SKU appeared mid-corpus and was received well
- **This app does:** added $14.99 lifetime alongside $11.99 yearly
- **User reaction:** purchase-driver
- **Magnitude:** 9 Apr 2026 → 20 Jun 2026 → 23 Jun 2026; 3 of 4 paid-evidence reviewers engage, all positively in principle
- **Direction for us:** product-rule · **Report confidence:** clearest packaging signal · **Generalisable:** yes
- **Side effects:** its launch also opened the lifetime+subscription double-billing path (R06-011)
- **Review IDs:** `13939159292`, `14203637124`, `14214912053`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R06-077 — Four things persisted unfixed across all 13 months: the free-streak cap as a rating drag (Sep 2025 → Aug 2026), price confusion/distrust (Sep 2025 → Aug 2026), counter-mode confusion (Jan → Apr 2026), and the multi-log-per-day gap (Nov 2025 → Aug 2026 — nine months, same request, both from paying-intent users)

- **Where:** §8.5 What persisted, unfixed, across all 13 months
- **This app does:** none of the four addressed
- **User reaction:** complaint
- **Magnitude:** 1. cap 13185604622 → 14477924333; 2. price 13185604622 → 14491149862; 3. mode 13628759209 → 13994050917; 4. multi-log 13390634274 → 14471219702
- **Direction for us:** do · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `13185604622`, `14477924333`, `14491149862`, `13628759209`, `13994050917`, `13390634274`, `14471219702`
- **Canonical:** — (nuance register)

## Positioning

### R06-001 — Streak Tracker — StreakUp (App Store ID 6749051240) is a 13-month-old streak counter ('Habit Builder & Breaker') with two modes — Streak Tracker (manual check-in) and Streak Counter (auto-increments, you only declare a break) — rated 4.65 on 188 US ratings; listing claims 'Most features are free! Premium is only required to unlock unlimited streaks, custom themes & icons'

- **Where:** header lines 1-6
- **This app does:** developer Explora SAS (artist 'Explora (Apps)'), bundle com.aura.streaktracker, site with-aura.com; free download; first released 6 Aug 2025; v1.13.4 on 31 Aug 2026; Productivity (secondary Health & Fitness); 12+; 81 MB; min iOS 15.1; listing declares EN, FR, DE, IT, PT, ES; store rank 6 in this set
- **User reaction:** praise
- **Magnitude:** 44 reviews, 13 storefronts, 1 Sep 2025 → 30 Aug 2026; US 188 ratings @ 4.65 (Apple lookup 9 Sep 2026)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Conditions:** a very young, very small corpus — the smallest in the set so far
- **Canonical:** — (nuance register)

### R06-015 — Users benchmark a streak app against free iPhone Reminders and do the value math aloud: 'I can set a reminder list on in my iPhone reminders for $0. What is the $11.99 for?' — and conclude the app is a scam

- **Where:** Part 0 §4 value math; Part 4 Value-for-money objection row
- **This app does:** $11.99/yr for a streak counter
- **User reaction:** 1★-burst
- **Magnitude:** Value-for-money objection (does too little for the price): 2 (4.55%), mean 2.00
- **Direction for us:** do · **Report confidence:** quoted (n = 2) · **Generalisable:** yes
- **Side effects:** a thin product invites comparison with the free OS app — the paid layer must be visibly more than a reminder list
- **Review IDs:** `13628759209`, `14307898374`
- **Canonical:** C005 Know which competitors buyers compare against; C064 Price level — where 'fair' turns into 'too expensive'

### R06-021 — The no-check-in counter is the app's actual differentiator against every check-off habit tracker on the store, and the user-defined day boundary is a positioning asset nobody at Explora appears to be marketing

- **Where:** Part 0 §6b differentiator; §6c positioning asset
- **This app does:** differentiated but unmarketed
- **User reaction:** praise
- **Magnitude:** report gives none (2 + 1 reviews)
- **Direction for us:** do · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `13085620460`, `13672386764`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C134 Lead the store listing with what users actually love; C135 Offer both check-in tracking and auto-counting (no daily check-in) per item

### R06-025 — Two reviewers call it a clone and both are 1★: 'Terrible app a clone of streaks' (Streaks by Crunchy Bagel) and 'literally a copy of the app Days Since but it's both more expensive and has less features, let alone the horrible UI and lack of customizability' — Days Since is report 3 in this set, so users compare these products directly, and StreakUp loses on customization and price, not core function

- **Where:** Part 0 §8 (Two reviewers call it a clone, and both are 1★); §8.2 launch-window artefacts
- **This app does:** near-identical concept to Streaks and Days Since at a higher price
- **User reaction:** 1★-burst
- **Magnitude:** 2 of 44 (4.55%), mean 1.00; both Dec 2025 (launch window)
- **Direction for us:** research · **Report confidence:** not a trend (n = 2) · **Generalisable:** yes
- **Side effects:** cross-report link: report 3 (Days Since) and the Streaks app (report 23)
- **Review IDs:** `13531820409`, `13557096013`
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R06-023 — The same no-check-in design is the top source of confusion and 1★ churn: users in Streak Counter mode read it working as designed as a bug — 'The streaks keep moving whether I enter data or not' is a person who thinks the app is fabricating their progress, a trust failure not a UX nit; another wanted a checklist and asks 'Am I missing something?'

- **Where:** Part 0 §7 (The same 'no check-in' design is also the top source of confusion and 1★ churn); Part 4 Counter mode read as a tracking bug row
- **This app does:** counter mode auto-increments with no explanation of the mode
- **User reaction:** churn
- **Magnitude:** 2 × 1★; Counter mode read as a tracking bug 1 (2.27%), mean 1.00
- **Direction for us:** do · **Report confidence:** second-most-actionable product finding · **Generalisable:** yes
- **Review IDs:** `13628759209`, `13994050917`
- **Canonical:** C136 When an item can be tracked more than one way, make the user choose the mode at creation

### R06-038 — The paywall implied a capability the product does not have: a user bought Pro at $1.99 to get multiple daily check-ins, found it doesn't exist and cancelled — 'Thankfully I only paid $1.99 as I will now cancel — there are free ones with basic'; that is the difference between a feature request and a refund cause

- **Where:** §1.2 13390634274 row; §4.1 The paywall implied a capability the product does not have; Part 4 Cancelled subscription row
- **This app does:** Pro sold without multi-log; buyer expected it
- **User reaction:** churn
- **Magnitude:** 1 (2.27%), 4★, CA; Cancelled subscription 1 (2.27%), mean 4.00
- **Direction for us:** dont · **Report confidence:** weight raised: a paying customer who churned · **Generalisable:** yes
- **Review IDs:** `13390634274`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Things not to do

### R06-042 — The paywall surfaces on launch rather than at the point of need — 'every time I open the app it begs me for money'; move it to the moment of need (attempting streak #3, or attempting a freeze)

- **Where:** §1.4 Upsell pressure; Part 4 Upsell nagging on every launch row; Part 9 #9
- **This app does:** upsell on every app open
- **User reaction:** 1★-burst
- **Magnitude:** 1 explicit (2.27%), mean 1.00; aligns with the greed cluster (4, mean 1.00)
- **Direction for us:** dont · **Report confidence:** weak alone; aligned with the angriest cluster · **Generalisable:** yes
- **Side effects:** cap-complainers already like the app, so a need-time paywall reaches people with intent
- **Review IDs:** `13185604622`, `14205874183`, `14491149862`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C137 Show the paywall at the moment of need, not on app open

### R06-063 — Do not build for the NoFap / semen-retention communities that already use the app — they come with their own community norms

- **Where:** Part 5 Recommendation: do not build for these communities
- **This app does:** used by those communities unprompted
- **User reaction:** praise
- **Magnitude:** 2 reviews (stopping masturbation; semen retention), both 5★
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13837160367`, `14311507310`
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R06-089 — Move the paywall from app-launch to the moment of need (attempting streak #3, or attempting a freeze)

- **Where:** Part 9 #9
- **This app does:** paywall on launch
- **User reaction:** 1★-burst
- **Magnitude:** 1 explicit complaint; supported by cap-complainers already liking the app
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R06-042
- **Review IDs:** `13185604622`
- **Canonical:** C137 Show the paywall at the moment of need, not on app open

## Things to do

### R06-019 — Market what users say is unique — the widget and the user-defined day boundary; the widget is the most-loved feature yet is one bullet at the bottom of the store description, and the day boundary is the reason at least one user switched

- **Where:** Part 0 §6a widget buried in the listing; Part 9 #13
- **This app does:** widget = one bullet at the bottom of the listing; day boundary not marketed
- **User reaction:** praise
- **Magnitude:** 7 widget mentions; 1 switcher on day boundary
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13672386764`, `14372026009`, `13795256017`
- **Canonical:** C134 Lead the store listing with what users actually love

### R06-093 — Market the two things users say are unique — the widget and the user-defined day boundary; both are buried in the listing and both are the reason people switched

- **Where:** Part 9 #13
- **This app does:** buried in listing
- **User reaction:** praise
- **Magnitude:** 7 widget mentions; 1 switched because of the day boundary
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R06-018, R06-019, R06-022
- **Review IDs:** `13672386764`
- **Canonical:** C134 Lead the store listing with what users actually love

### R06-094 — Decide deliberately how a broken streak is handled for sensitive categories (self-harm, substances) — supportive copy and a resource link vs the current neutral reset; the app is rated 12+

- **Where:** Part 9 #14
- **This app does:** neutral reset
- **User reaction:** praise
- **Magnitude:** 3 reviews
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R06-062
- **Review IDs:** `14349062008`, `13837160367`, `14311507310`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

## Contradictions

### R06-035 — Report 6 contradicts itself on cosmetics: Part 9 #6 proposes testing 'unlimited-with-cosmetics-paid' while Part 9 #10 says stop selling Premium on themes and icons because zero of 44 reviewers mention them — so the fallback paid layer if the cap is lifted is unvalidated

- **Where:** §1.1 cosmetics note vs Part 9 #6 'unlimited-with-cosmetics-paid'
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 0 of 44 mention cosmetics; #6 vs #10
- **Direction for us:** research · **Report confidence:** internal tension · **Generalisable:** yes
- **Conditions:** resolve before copying the 'unlimited free, cosmetics paid' model; report 3 found widget customisation sells, report 6 finds themes/icons don't register
- **Canonical:** C018 App-icon themes; C133 Gate on capability, not on quantity

### R06-045 — The same free tier reads as generous to some and as a trap to others, and the difference appears to be how many habits the user is tracking — 'completely free' 5★s track one or two things, cap complainers track more

- **Where:** Part 2 5★ tension with Part 0.2; Part 3 Perceived as free / generous free tier row
- **This app does:** 2-streak free tier
- **User reaction:** mixed
- **Magnitude:** Perceived as free / generous free tier 3 (6.82%), mean 5.00 vs Free streak cap 7 (15.91%), mean 3.00
- **Direction for us:** research · **Report confidence:** inference · **Generalisable:** yes
- **Conditions:** a quantity cap is judged by each user against their own count — it cannot be generous and tight at once; supports gating on capability rather than quantity
- **Review IDs:** `13767758923`, `14093501015`, `14271116952`, `14477924333`, `14214912053`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R06-059 — Local-only storage produced zero data-loss and zero sync complaints in report 6 — against report 1, where local-only storage was the root cause of data loss (×10.6 among buyers)

- **Where:** §4.2 No data-loss reports — consistent with the listing's local-only storage claim
- **This app does:** local-only storage, no account
- **User reaction:** none
- **Magnitude:** 0 of 44 data-loss or sync complaints
- **Direction for us:** research · **Report confidence:** absence at n = 44 · **Generalisable:** unknown
- **Conditions:** a 13-month-old app with 44 reviews — too young for phone-change and reinstall losses to accumulate; the report expects sync complaints if users come to expect sync
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R06-068 — Monetization complaints come from the highest-willingness-to-pay markets, not from price-sensitive ones — the opposite of the usual pattern — which reinforces that the problem is packaging clarity, not the price point itself

- **Where:** §7.2 High-spend markets — [limited evidence, cannot be assessed]
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 35 reviews across US/GB/CA/AU/FR (79.5% high-spend); zero JP or DE
- **Direction for us:** product-rule · **Report confidence:** limited evidence · **Generalisable:** yes
- **Conditions:** contrast reports 3–5, where price complaints came from IN/TR/UA/BR/MX/SA and regional pricing was the fix; no spend or download data — storefront review volume is a disclosed engagement proxy, never downloads
- **Canonical:** C002 Ratings follow the offer, not the feature set; C092 Regional pricing

## Data caveats and method

### R06-002 — Method: n = 44, one review = 2.27%, so a single review lands in 'Meaningful' and three reviews clear 'high-priority' — the raw count is the primary unit and the percentage is decoration; every finding is a hypothesis with named witnesses, not a measured rate; no storefront reaches the 50-review bar (US largest at 23) so every country statement is [limited evidence]; Part 9 recommendations are 'prioritised hypotheses to act on and instrument — not conclusions from a measured population'

- **Where:** How to read this; ⚠️ The threshold table barely applies at this sample size — read counts, not percentages; Part 9 preamble
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** n = 44; one review = 2.27%; bands: <0.1% ignore, 0.1–0.5% weak, 0.5–1% emerging, 1–3% meaningful, 3–5% very strong, >5% high-priority; largest storefront US 23
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Conditions:** applies to every numeric claim from report 6; confidence scoring must weight report 6 by count, not by %
- **Canonical:** — (nuance register)

### R06-006 — There are zero two-star reviews (distribution 24 / 7 / 5 / 0 / 8): people are either happy or angry about the paywall — no one lands in the 'disappointed but not angry' zone; the app produces enthusiasm or grievance

- **Where:** Part 0 §1; Part 2 2★ — n = 0
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2★ n = 0 of 44
- **Direction for us:** none · **Report confidence:** observed · **Generalisable:** unknown
- **Conditions:** contrast report 5, where 2★ was the peak of reliability complaints — a missing 2★ band signals no engineering frustration
- **Canonical:** — (nuance register)

### R06-026 — The 4.65 badge is not telling the team about the paywall problem: roughly 12% of US raters wrote anything, the written mean sits 0.69 below the tap mean, and 36% of the people who typed complain about money — none of which reaches the dashboard

- **Where:** Part 0 §9 (The public rating is 0.7 stars higher than what people write) table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Measure | Value ; Written corpus, all 13 storefronts (n = 44) | 3.89 ; Written corpus, US only (n = 23) | 3.96 ; US App Store displayed rating (188 ratings, 9 Sep 2026) | 4.65 ; 23 written / 188 US taps ≈ 12%; gap 0.69
- **Direction for us:** do · **Report confidence:** observed · **Generalisable:** yes
- **Conditions:** the written-vs-tap gap is the normal direction; its size is what matters
- **Canonical:** — (nuance register)

### R06-027 — Short reviews inflate; the app's real feedback lives in the long ones: 12 of 44 bodies (27.3%) are under 40 characters and average 4.17 stars, while the 32 substantive reviews average 3.78 with 21.9% one-and-two-star

- **Where:** Part 0 §9 Length confirms it
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 12/44 (27.3%) < 40 chars, mean 4.17; 32 substantive, mean 3.78, 21.9% 1–2★
- **Direction for us:** none · **Report confidence:** observed · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R06-028 — Free/paid split reconstructed from reviews + listing: both modes, widget, reminders, backfill, trophies and sharing are free; streaks beyond 2, Streak Freeze and custom themes & icons are paid; multiple check-ins per task per day does not exist at any tier

- **Where:** §1.1 The model, reconstructed from reviews + listing table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Status | Evidence ; Streak Tracker mode (manual check-in) | Free | `14292633754`, `14271116952` ; Streak Counter mode (auto-increment, reset on break) | Free | `13085620460`, `13767758923`, `13994050917` ; Home-screen widget | Free | `13767758923` (*"completely free"* + widget praise), `14372026009` ; Notifications / reminders | Free | `14292633754`, `13628759209` ; Backfill / edit a missed day | Free | `14271116952` (*"you can edit your calendar in case you miss a day… It's free too"*) ; Trophies (Spark → Legend), sharing to socials | Free (listing); praised by free users | `13093308789`, `13845360166` ; Streaks beyond 2 | PAID | `14214912053`, `14346310474`, `14372026009`, `14477924333`, `14267106974`, `13969396065` ; Streak Freeze | PAID | `14214912053` (only explicit source) ; Custom themes & icons | PAID | Listing only — no reviewer mentions these at all ; Multiple check-ins per task per day | Does not exist at any tier | `13390634274` (paid Pro to get it, did not get it), `14471219702`
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `14292633754`, `14271116952`, `13085620460`, `13767758923`, `13994050917`, `14372026009`, `13628759209`, `13093308789`, `13845360166`, `14214912053`, `14346310474`, `14477924333`, `14267106974`, `13969396065`, `13390634274`, `14471219702`
- **Canonical:** — (nuance register)

### R06-036 — Only four reviewers give direct evidence of a transaction or attempt — the narrowest and most important denominator; segment rates on n = 4 must not be generalised; purchase evidence excludes the reviewer who only approves of lifetime

- **Where:** §1.2 Direct paid-user evidence — 4 reviewers (9.09%), mean 3.25 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 4 (9.09%), mean 3.25; ID | CC | ★ | What they bought | Outcome ; `13390634274` | CA | 4 | Pro at $1.99 | Cancelled. Bought it to get multiple daily check-ins; feature does not exist. *"Thankfully I only paid $1.99 as I will now cancel — there are free ones with basic."* ; `13771926913` | US | 1 | quoted $1.99/mo | Charged $20.99. Refund requested in public. ; `13939159292` | US | 3 | trial → $14.99 lifetime | Also charged $11.99 yearly. $25.98 total, no refund path found. ; `14203637124` | IN | 5 | wanted lifetime | Could not purchase — IAP unavailable.
- **Direction for us:** none · **Report confidence:** verbatim (segment n = 4) · **Generalisable:** app-specific
- **Review IDs:** `13390634274`, `13771926913`, `13939159292`, `14203637124`
- **Canonical:** — (nuance register)

### R06-046 — 6 of the 24 five-star reviews carry effectively no product information ('Good', 'Worth it', 'Super simple et super efficace' borderline); 'Max verstappen' is pure noise, retained in all denominators

- **Where:** Part 2 5★ low-information reviews
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 6 of 24 5★ low-information
- **Direction for us:** none · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `13466777630`, `14184863622`, `14351962860`, `14417731278`, `14414628073`, `13872472954`
- **Canonical:** — (nuance register)

### R06-049 — 1★ drivers: paywall/price/greed 4, billing over-charge 1, clone accusation 2, mode confusion read as a bug 1, 'app doesn't work' 1 (same review as a clone)

- **Where:** Part 2 1★ — n = 8 (18.18%) table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1★ n = 8 (18.18%); Driver | n | IDs ; Paywall / price / greed | 4 | `13185604622`, `13628759209`, `13969396065`, `14491149862` ; Billing over-charge | 1 | `13771926913` ; Clone accusation | 2 | `13531820409`, `13557096013` ; Mode confusion read as a bug | 1 | `13994050917` ; "App doesn't work" | 1 | `13531820409` (same review as clone)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13185604622`, `13628759209`, `13969396065`, `14491149862`, `13771926913`, `13531820409`, `13557096013`, `13994050917`
- **Canonical:** — (nuance register)

### R06-051 — Praise themes (non-exclusive, n = 44; at this size a single review reads as 'Meaningful')

- **Where:** Part 3 WHAT PEOPLE PRAISE (full table) (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of 44 | Mean ★ | Band* | IDs ; Behaviour-change outcome (any) | 9 | 20.45% | 5.00 | HIGH | `13093308789`, `13672386764`, `13795256017`, `13837160367`, `13845360166`, `13891333657`, `14093501015`, `14349062008`, `14389534229` ; Simplicity / ease | 7 | 15.91% | 4.57 | HIGH | `13390634274`, `13466777630`, `13767758923`, `13795256017`, `14146487084`, `14271116952`, `14346310474` ; Widget (positive) | 6 | 13.64% | 5.00 | HIGH | `13085620460`, `13093308789`, `13767758923`, `13795256017`, `13845360166`, `14372026009` ; Explicit recommendation | 6 | 13.64% | 4.83 | HIGH | `13093308789`, `13767758923`, `13795256017`, `13845360166`, `14093501015`, `14456589309` ; Perceived as free / generous free tier | 3 | 6.82% | 5.00 | HIGH | `13767758923`, `14093501015`, `14271116952` ; No daily check-in required | 2 | 4.55% | 5.00 | V.strong | `13085620460`, `13767758923` ; Trophies / gamification | 2 | 4.55% | 5.00 | V.strong | `13093308789`, `13845360166` ; User-defined day boundary | 1 | 2.27% | 5.00 | Meaningful | `13672386764` ; Both modes (auto + manual) | 1 | 2.27% | 5.00 | Meaningful | `14292633754` ; Backfill / edit a missed day | 1 | 2.27% | 5.00 | Meaningful | `14271116952` ; Notifications work | 1 | 2.27% | 5.00 | Meaningful | `14292633754` ; Stability / no glitches | 1 | 2.27% | 4.00 | Meaningful | `14214912053` ; Social sharing of milestones | 1 | 2.27% | 5.00 | Meaningful | `13093308789`
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13093308789`, `13390634274`, `13085620460`, `13767758923`, `14093501015`, `13672386764`, `14292633754`, `14271116952`, `14214912053`, `14456589309`
- **Canonical:** — (nuance register)

### R06-054 — Complaint themes (non-exclusive, n = 44): money themes dominate; the only functional gaps are multi-log per day and a mode choice users cannot see

- **Where:** Part 4 COMPLAINTS AND UNMET NEEDS (full table) (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 44 | Mean ★ | IDs ; Free streak cap (1→2) | 7 | 15.91% | 3.00 | `13185604622`, `13969396065`, `14214912053`, `14267106974`, `14346310474`, `14372026009`, `14477924333` ; Price objection / "make it free" | 6 | 13.64% | 2.00 | `13185604622`, `13939159292`, `13969396065`, `14205874183`, `14307898374`, `14491149862` ; Distrust / "greedy" / deceptive | 4 | 9.09% | 1.00 | `13185604622`, `13531820409`, `13628759209`, `13969396065` ; Clone of a named competitor | 2 | 4.55% | 1.00 | `13531820409` (Streaks), `13557096013` (Days Since) ; Value-for-money objection (does too little for the price) | 2 | 4.55% | 2.00 | `13628759209`, `14307898374` ; Cannot log a task more than once per day | 2 | 4.55% | 4.00 | `13390634274`, `14471219702` ; Refund requested in public | 2 | 4.55% | 2.00 | `13771926913`, `13939159292` ; Wants manual check-off / accountability | 2 | 4.55% | 3.00 | `13085620460` (as request), `13628759209` (as 1★ mismatch) ; Billing over-charge ($1.99 → $20.99) | 1 | 2.27% | 1.00 | `13771926913` ; Billing double-charge (lifetime + yearly) | 1 | 2.27% | 3.00 | `13939159292` ; IAP unavailable — could not buy | 1 | 2.27% | 5.00 | `14203637124` ; Counter mode read as a tracking bug | 1 | 2.27% | 1.00 | `13994050917` ; Widget cannot be added | 1 | 2.27% | 5.00 | `14389534229` ; Upsell nagging on every launch | 1 | 2.27% | 1.00 | `13185604622` ; UI quality / customization lacking | 1 | 2.27% | 1.00 | `13557096013` ; Streak Freeze locked behind paywall | 1 | 2.27% | 4.00 | `14214912053` ; "App doesn't work" (no detail) | 1 | 2.27% | 1.00 | `13531820409` ; Cancelled subscription | 1 | 2.27% | 4.00 | `13390634274` ; Friction: must log daily even when goal met | 1 | 2.27% | 4.00 | `14471219702`
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13185604622`, `13531820409`, `13557096013`, `13628759209`, `13390634274`, `13771926913`, `13085620460`, `13939159292`, `14203637124`, `13994050917`, `14389534229`, `14214912053`, `14471219702`
- **Canonical:** — (nuance register)

### R06-060 — Use cases in the text are narrower than the listing implies: quitting a bad habit 4, general goals 3, fitness 2, hygiene 2 (teeth-brushing 2×/day), creative practice 1 (writing a first draft)

- **Where:** Part 5 WHO ACTUALLY USES THIS table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Use case | n | IDs ; Quitting a bad habit / abstinence streaks | 4 | `13837160367` (stopping masturbation), `13891333657` (unnamed bad habit), `14311507310` (semen retention), `14349062008` (self-harm) ; Fitness / exercise / walking | 2 | `13845360166`, `13672386764` ; Hygiene | 2 | `14468692280`, `14471219702` (teeth-brushing 2×/day) ; Creative practice | 1 | `14389534229` (writing a first draft) ; General goals / discipline | 3 | `13093308789`, `13795256017`, `14093501015`
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13837160367`, `13891333657`, `14311507310`, `14349062008`, `13845360166`, `13672386764`, `14468692280`, `14471219702`, `14389534229`, `13093308789`, `13795256017`, `14093501015`
- **Canonical:** — (nuance register)

### R06-064 — Only five reviews (11.36%) contain an actionable request: optional manual check-in, check-off list + accountability, multiple logs per day, log when goal accomplished, more customization

- **Where:** Part 6 WHAT THE FEATURE REQUESTS ACTUALLY SAY table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5 (11.36%); Request | ID | ★ | Verbatim ; Optional manual check-in alongside counter mode | `13085620460` | 5 | *"you don't need daily check-ins… But that could be something to add in the future"* ; Check-off list + accountability | `13628759209` | 1 | *"hoping for more of a checklist where I could actually check off when I had completed my task"* ; Multiple logs of one task per day | `13390634274` | 4 | *"Does NOT allow for multiple streaks for one task, within a day"* ; Log when goal accomplished, not merely daily | `14471219702` | 4 | *"you have to log everyday, not necessarily when goal is accomplished"* ; More customization | `13557096013` | 1 | *"lack of customizability"*
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13085620460`, `13628759209`, `13390634274`, `14471219702`, `13557096013`
- **Canonical:** — (nuance register)

### R06-070 — Nine storefronts have one review each (FR and IN two): a single review moves those means by up to 4 full stars — NG at 1.00 and NO at 1.00 are single reviewers, not markets, given no standalone weight

- **Where:** §7.4 Small-storefront caveat
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** AU, BR, IL, TR, CZ, UA, NG, NO at n = 1; FR, IN at n = 2
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R06-078 — Immediate fixes (days, not sprints): lifetime double-charge audit, quote-vs-charge reconciliation, IAP availability by storefront, in-app manage/refund link, can't-add-widget

- **Where:** Part 9 Immediate — fix before anything else (days, not sprints) table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** # | Action | Rests on | Why now ; 1 | Audit the lifetime-purchase flow: does buying lifetime cancel/refund an active subscription? Reproduce trial → lifetime and check for a double charge. | `13939159292` (§0.3, §1.2) | A named, reproducible over-billing path. Every trial user who upgrades may be paying twice. ; 2 | Reconcile the paywall's quoted price with the actual charge. One user was quoted $1.99/mo and charged $20.99. | `13771926913` (§0.3) | Charge-vs-quote mismatch is a refund, chargeback and App Review risk, not just a rating risk. ; 3 | Check IAP availability by storefront — starting with India. | `14203637124` (§0.5) | A 5★ user with intent to buy could not transact. Highest expected-revenue defect in the corpus. ; 4 | Add a visible in-app "Manage / cancel / request refund" link to Apple's subscription management. | `13771926913`, `13939159292`, `13390634274` | Both billing complaints were filed as public 1★/3★ reviews because there was no other route. ; 5 | Investigate "can't add widget." | `14389534229` (§0.6) | The widget is the most-loved feature; it failing to install is disproportionately costly.
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13939159292`, `13771926913`, `14203637124`, `13390634274`, `14389534229`
- **Canonical:** — (nuance register)

### R06-079 — Monetization actions — repackage, don't reprice: raise the cap well above 2, lead with lifetime, one stable price, paywall at the moment of need, stop selling themes/icons

- **Where:** Part 9 Monetization — repackage, don't reprice table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** # | Action | Rests on ; 6 | Raise the free cap well above 2 — test 5, or unlimited-with-cosmetics-paid. The cap is generating public complaint from 4★ and 5★ users who did *not* convert. Test as an experiment with conversion and rating as joint metrics; do not ship blind. | §0.2, §8.3 — 7 reviews, mean 3.00, 5 of them in the last 4 months ; 7 | Lead with the one-time / lifetime SKU. Three of four paid-evidence reviewers engage with it positively; four separate reviewers reject subscriptions outright. | §1.3, §8.4 ; 8 | Publish one clear price on the paywall and keep it stable. Reviewers have quoted $1.99, ~$5, $11.99, $14.99 and $20.99 in eleven months. | §0.4 — 4 "greed" reviews, mean 1.00 ; 9 | Move the paywall from app-launch to the moment of need (attempting streak #3, or attempting a freeze). | `13185604622`; supported by the pattern that cap-complainers already like the app ; 10 | Stop selling Premium on themes and icons. Not one of 44 reviewers mentions them. Sell the freeze and the streak count. | §1.1
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13185604622`
- **Canonical:** — (nuance register)

### R06-080 — Product actions that convert 3–4★ into 5★: explicit mode choice, count completions not days, market widget and day boundary, deliberate broken-streak handling for sensitive categories

- **Where:** Part 9 Product — converts 3–4★ into 5★ table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Action | Rests on ; 11 | Make the Tracker-vs-Counter mode choice explicit at streak creation, with one line explaining each. Two 1★ reviews are people in the wrong mode; two more asked for a mode that already ships. | `13628759209`, `13994050917`, `13085620460`; ships per `14292633754` ; 12 | Support counting completions, not just days — "twice a day," "3× per week." Nine months of the same request, including one paid churn. | `13390634274`, `14471219702` ; 13 | Market the two things users say are unique: the widget and the user-defined day boundary. Both are buried in the listing; both are the reason people switched. | `13672386764` (switched *because of* the day boundary), 7 widget mentions ; 14 | Decide deliberately how a broken streak is handled for sensitive categories (self-harm, substances) — supportive copy and a resource link vs. the current neutral reset. | `14349062008`, `13837160367`, `14311507310`; app is rated 12+
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13628759209`, `13994050917`, `13085620460`, `14292633754`, `13390634274`, `14471219702`, `13672386764`, `14349062008`, `13837160367`, `14311507310`
- **Canonical:** — (nuance register)

### R06-095 — Research: does raising the free cap to 5 increase or decrease revenue? 44 reviews cannot tell — needs a live A/B test with conversion, ARPU and rating tracked together

- **Where:** Part 9 Research questions this corpus cannot answer — does raising the cap to 5 increase or decrease revenue?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R06-096 — Research: how common is the lifetime + subscription double charge? One review — check the billing ledger, not the reviews

- **Where:** Part 9 Research questions — how common is the lifetime + subscription double charge?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 1 review
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right

### R06-097 — Research: what is the retention curve after a streak breaks? Every review is from someone still engaged — the corpus is structurally blind to churn

- **Where:** Part 9 Research questions — what is the actual retention curve after the streak breaks?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R06-098 — Research: are the two clone accusations (Streaks, Days Since) reputational noise or a real ASO/positioning problem? Two reviews cannot separate these

- **Where:** Part 9 Research questions — are the two clone accusations reputational noise or a real ASO/positioning problem?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 2 reviews
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Review IDs:** `13531820409`, `13557096013`
- **Canonical:** C005 Know which competitors buyers compare against

### R06-099 — Method per the appendix: all 44 reviews hand-coded single-pass with no second coder and no automated classification; no version field so nothing is attributed to a release; is_edited unreliable and unused; themes non-exclusive (one review carries six labels); the 1 → 2 cap change is inferred from review text, not a changelog; 4 paid-evidence reviewers is a qualitative finding, not a 100% failure rate; written reviews are ~12% of US raters and over-represent grievance — the right lens for a fix list, the wrong one for overall satisfaction

- **Where:** Part 10 method and limitations (skimmed)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 44 records, 0 duplicates, 13 by_country files reconcile; rating distribution {5:24, 4:7, 3:5, 2:0, 1:8}; mean 3.886
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `13531820409`, `14414628073`, `14389534229`, `14417731278`
- **Canonical:** — (nuance register)
