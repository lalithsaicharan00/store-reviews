# Cards — report 62

Source: `App Store Reports/62. Streaks – Daily Habit Tracker - Atomic Goals & Accountability (REPORT).md`  
38 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 1
- [Must-haves](#must-haves) — 2
- [Must never break](#must-never-break) — 3
- [Features](#features) — 6
- [Monetization](#monetization) — 4
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 6
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 2
- [Dated events and trends](#dated-events-and-trends) — 1
- [Positioning](#positioning) — 1
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 2
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 4

## Product rules

### R62-005 — Praise is the biggest theme and it is almost entirely one word — simple: 18 of 45 (40.00%, mean 4.67) contain praise; 11 (24.44%, high-priority, mean 4.45) praise simplicity or minimalism specifically, said the same way in six languages — 'Sade ve kullanışlı' (simple and useful, TR); 'Solo check y a seguir. Como debe ser' (just check and carry on. As it should be, PY); 'really intuitive, just what i needed'; and from a 2★ uninstalling over the free cap: 'Really clean, minimal UI and super easy to use… no-nonsense layout' — simplicity is the moat and it is not in dispute: even the churned users and the 1★ reviewers concede it; nothing in the corpus asks for the app to become more complicated, the 4★ band asks for depth without complexity ('It's minimalistic I get it, but…'; 'It's minimal, clean, and includes everything you actually need', then one bounded suggestion); present in every period; design implication: every feature in Part 8 must be additive-on-demand, not surfaced by default; §8.5: do not add features to the main screen

- **Where:** §0.2; §3.3.1; §7.9; §8.5
- **This app does:** one-tap check-off; minimal main screen
- **User reaction:** praise
- **Magnitude:** 11 (24.44%) at 4.45★; praise 18 (40%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `12510217982`, `13332648782`, `13354961662`, `13366854737`, `13610103490`, `13759855538`, `13926027561`, `14191010644`, `14288307273`, `14421182094`, `14453647912`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C185 Aesthetic and a polished onboarding convert; they do not retain; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

## Must-haves

### R62-013 — The visualisation people love is the visualisation one person cannot read: 'on the main screen you only see the habit titles with their icon, but the overall view is totally confusing: you see a sea of dots without being able to distinguish month, week and day' (IT, 1★) — the same dot / heat-map grid another user paid for and a third credits with their first successful habit is unreadable to this reviewer because it carries no time axis; consistent with a 4★ asking for the options to be explained — 'the UI is legible to people who already understand it'; P8: give the dot grid a time axis (visible month / week / day framing) as a design test, not a rewrite; P7: explain the options in-product with one-line hints on first use — the cheapest item in the report

- **Where:** §0.9; §3.4.3; §8.3 P7, P8
- **This app does:** dot grid with no time axis; unexplained options
- **User reaction:** complaint
- **Magnitude:** 1 (2.22%) + 1 (2.22%)
- **Direction for us:** must-have · **Report confidence:** single review · **Generalisable:** generalisable
- **Review IDs:** `13212775795`, `14421182094`
- **Canonical:** C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in; C217 An unexplained metric reads as broken — explain the score on-screen

### R62-019 — Reliability — 11 (24.44%, mean 1.64), the lowest-rated family (verbatim): Sub-theme | n | IDs ; Taps/buttons do not register | 6 | 14131374072, 14131709751, 14134782126, 14135188688, 14136118921, 14136173462 ; "Nothing works" (mechanism unnamed) | 2 | 14129863718, 14136346335 ; Blamed on an update | 2 | 14129863718, 14481733593 ; First-run habit creation blocked | 1 | 14136118921 ; Lag / freeze / system-wide slowdown | 1 | 14131374072 ; Total data loss | 1 | 13330819055 ; Repeating partial data loss on update | 1 | 14481733593 ; Apple Health link not working | 1 | 14435767351 — 8 of 11 are the June burst; the three that are not (total data loss Oct 2025, repeating weekly wipe on update Aug 2026, Apple Health link not working Aug 2026) are spread across the corpus and not fixed by whatever fixed the burst; the Health link: 'It doesn't communicate with iPhone Health-fitness; it said it did' (TR, 2★) — if the listing promises it, an expectation mismatch, which is worse than an absent feature; I5: either make the Apple Health / fitness link work or remove the claim — the cheapest of the five immediate fixes

- **Where:** §3.4.1 table (verbatim); §8.1 I5; §8.4 #4
- **This app does:** Health integration claimed but not working
- **User reaction:** complaint
- **Magnitude:** reliability 11 (24.44%) at 1.64★
- **Direction for us:** must-have · **Report confidence:** single review · **Generalisable:** generalisable
- **Review IDs:** `14435767351`, `13330819055`, `14481733593`, `14129863718`, `14136346335`, `14136118921`, `14131374072`
- **Canonical:** C021 Apple Health integration; C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C175 Updates must not break function or wipe progress; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Must never break

### R62-004 — The June 2026 build broke the app and is the biggest single event in the corpus: 8 of 45 (17.78%, high-priority, mean 1.62) report the app non-functional inside a 39-hour window (verbatim): UTC timestamp | CC | ★ | Review ID | What it says ; 2026-06-01 04:33 | in | 1 | 14129863718 | *"Since the last update, nothing is working"* ; 2026-06-01 14:16 | ar | 1 | 14131374072 | unstable, laggy, freezes, *"severe touch-responsiveness issues every time I try to select an option"* ; 2026-06-01 15:52 | ar | 1 | 14131709751 | ES: clicking any option does nothing — *"you have to do a little swipe"* ; 2026-06-02 11:13 | tr | 2 | 14134782126 | TR: premium buyer — the edit-previous-day buttons are dead ; 2026-06-02 13:25 | es | 1 | 14135188688 | ES: *"the components that should be clickable don't work"* → *"hire a designer"* ; 2026-06-02 18:02 | tr | 1 | 14136118921 | TR: *"I couldn't get past the 'start creating a habit' step, the button won't press"* ; 2026-06-02 18:19 | ua | 1 | 14136173462 | paid $10 — a week later: can't create a habit, can't mark one, *"the app just stop working"* ; 2026-06-02 19:16 | sa | 5 | 14136346335 | title and body both *"App doesn't work"* (★ contradicts text) — six of eight name the same mechanism, taps do not register (tap_unresponsive 6, 13.33%, mean 1.17); one found a workaround — swipe instead of tap — pointing at a gesture-recognition or hit-testing regression, not a crash; 6 of the 15 1★ reviews (40%) come from this window (remove it and the 1★ share falls from 33.33% to 24.32%); it hit six countries in two days (IN, AR×2, TR×2, ES, UA, SA) so not a device- or locale-specific edge; it caught paying customers mid-subscription (a premium buyer; a $10 buyer one week after purchase) and blocked first-run onboarding ('I couldn't get past the start creating a habit step, the button won't press') — destroying new-user acquisition for its duration; fixed: 16 reviews from 3 Jun average 3.875 with zero unresponsive-tap reports, August alone 9 at 4.00 — 'the recovery is real, but the 1★ reviews it generated are permanent and still sit on the listing'; I3: a regression gate on tap / hit-testing before release plus a fast rollback path — 'the cost of one bad build here was ~0.32 stars on the app's entire written history'

- **Where:** Part 0 summary line; §0.1 table (verbatim); §7.3; §8.1 I3
- **This app does:** shipped a build with broken hit-testing
- **User reaction:** 1★-burst
- **Magnitude:** 8 (17.78%); 40% of all 1★; −0.32 on the mean
- **Direction for us:** must-never-break · **Report confidence:** high confidence · **Generalisable:** generalisable
- **Review IDs:** `14129863718`, `14131374072`, `14131709751`, `14134782126`, `14135188688`, `14136118921`, `14136173462`, `14136346335`
- **Canonical:** C031 Crashes / launch failures; C065 Paying customers are the highest 1★ risk — every paid feature must work; C156 Content and event releases need a crash gate across device generations; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R62-008 — Paying customers are the least-satisfied group: 6 reviewers state they paid (13.33%, mean 3.00) and five of six report a defect or shortfall (segment 5/6; global 11.11%); only one is unreservedly happy (verbatim): Review ID | CC | ★ | What they bought | What happened ; 12863807910 | br | 1 | monthly subscription | *"I paid for subscription monthly but still not working. Is this scam?"* ; 13314856744 | ec | 5 | bought the app | ES: offline, the app demands premium again — *"I already bought the app. This is a headache. Can you fix this critical error!"* ; 13332648782 | in | 5 | one month | Happy. Bought *specifically* for the large heat-map widget. ; 14134782126 | tr | 2 | premium | TR: edit-previous-day buttons dead (June burst) ; 14136173462 | ua | 1 | $10 | Bought, worked a week, then nothing worked (June burst) ; 14191010644 | uz | 4 | lifetime | *"no dark themed widget? Widget so basic? Please step it up, I just paid for lifetime access"* || SKU breakdown (verbatim): SKU as described | n | IDs | Mean ★ ; Monthly subscription | 2 | 12863807910 (br), 13332648782 (in) | 3.00 ; Lifetime / outright purchase | 2 | 13314856744 (ec), 14191010644 (uz) | 4.50 ; "Premium" / unspecified | 2 | 14134782126 (tr), 14136173462 (ua, *"$10"*) | 1.50 || Failure modes (verbatim): Failure mode | n | IDs | What it costs ; Entitlement not honoured | 2 | 12863807910 (paid monthly, *"still not working. Is this scam?"*), 13314856744 (bought, then re-paywalled when offline) | A completed purchase converted into a 1★ and a public fraud accusation ; App broke after purchase | 2 | 14134782126 (premium, edit buttons dead), 14136173462 ($10, everything dead one week in) | Paid users hit by the June burst ; Paid tier under-delivers | 1 | 14191010644 (lifetime: no dark widget, widget too basic) | Buyer's remorse voiced publicly by the highest-LTV SKU — two are entitlement failures, not feature failures: 'I paid for subscription monthly but still not working. Is this scam?' (BR, 1★) and 'If I don't have internet access the app asks me to go premium, when I already bought the app. This is a headache. Can you fix this critical error!' (EC, 5★ despite the bug) — the premium check appears to require network access, re-paywalling exactly the offline moments (commute, flight, poor signal) when a habit app is used; 'the single highest-severity non-burst finding in this report: it converts a successful purchase into a 1★ review and a fraud accusation'; I1: make the premium entitlement work offline — cache the receipt locally, never re-paywall a verified purchaser because the network is unavailable; I2: audit the purchase-unlock path end to end including a charged subscription that still behaves as free — two of six payers had an entitlement failure, 'the worst ratio in this report'; never infer a conversion rate from six reviewers who chose to write

- **Where:** §0.5 table (verbatim); §5.1 table (verbatim); §5.3; §5.4 table (verbatim); §8.1 I1, I2
- **This app does:** entitlement check needs network; purchase not unlocking
- **User reaction:** 1★-burst
- **Magnitude:** 5 of 6 payers report a problem; 2 entitlement failures
- **Direction for us:** must-never-break · **Report confidence:** high-priority (n=6) · **Generalisable:** generalisable
- **Review IDs:** `12863807910`, `13314856744`, `13332648782`, `14134782126`, `14136173462`, `14191010644`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C107 Widget variants and customisation as the paid layer; C139 Cache entitlements locally — never block a paid surface on a live server check

### R62-010 — Data integrity — two reports, one total and one repeating: 'After several months of usage all my habits disappeared upon app launch' (UA, 1★, Oct 2025 — total loss); 'Great app but unfortunately unreliable. Seems like each time when it updates the habits progress for the last week wipes. These happened two times already' (KZ, 2★, Aug 2026 — partial loss, on update, reproducible, twice); two reviews is 4.44% — two people, not a rate — but both describe destroyed history in a product whose entire value is an unbroken streak, ten months apart, the second naming app update as the trigger; promoted under the severe-data-loss rule; present before the June regression and still present two months after it was fixed — 'whatever fixed June did not fix this'; I4: stop wiping the last week's progress on update — treat habit history as migration-critical data with an integrity check on upgrade; 'in a streak product, destroyed history destroys the only thing the user has accumulated'

- **Where:** §0.7; §3.4.1; §7.7; §8.1 I4
- **This app does:** history wiped on update
- **User reaction:** 1★-burst
- **Magnitude:** 2 (4.44%), promoted — severe
- **Direction for us:** must-never-break · **Report confidence:** promoted — severe data loss · **Generalisable:** generalisable
- **Review IDs:** `13330819055`, `14481733593`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C175 Updates must not break function or wipe progress

## Features

### R62-011 — The data model makes streaks unfalsifiable: any past day can be edited (edit-previous-day buttons at the top) — 'unlimited back-dating makes streaks less meaningful' (IN, 4★, a fan) asks to mark missed days explicitly (a cross / red mark) and to lock past days; P4: streak integrity — mark missed days, optionally lock past days, shipped as an option because some users need back-fill; §8.5: do not remove back-dating — the fan wants it lockable, not gone, and a premium buyer was actively using the edit-previous-day buttons when they broke

- **Where:** §0.7; §2.1; §3.5 rank 4; §8.3 P4; §8.5
- **This app does:** unrestricted back-dating
- **User reaction:** request
- **Magnitude:** 1 (2.22%) at 4★
- **Direction for us:** feature · **Report confidence:** single review · **Generalisable:** generalisable
- **Review IDs:** `14453647912`, `14134782126`
- **Canonical:** C010 Backfill missed days / edit start date; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

### R62-014 — Feature inventory reconstructed from review text (verbatim): Capability | Evidence (review IDs) | What reviewers actually say ; Habit tiles + dot / heat-map grid | 13212775795, 13332648782, 14394122206, 14421182094 | Main screen shows habit titles with an icon and a grid of dots; a "larger widget showing the entire heat map" exists ; Streaks | app name, 14453647912 | Streak continuity is the core loop; back-dating undermines it ; Home-screen widgets | 13332648782, 14394122206, 14191010644, 13616264173 | Multiple sizes incl. a large heat-map widget; no dark theme; does not surface the next unfinished habit ; Check-off interaction | 14288307273, 14136173462 | ES *"just check and carry on"*; marking progress is one tap ; Back-dating / editing past days | 14453647912, 14134782126 | Any past day can be edited; there are edit-previous-day buttons at the top ; Reminders | 13956421952 | One reminder per day only ; Per-habit icons | 13212775795 | Each habit carries a reference icon ; Statistics | 13453953092 | Not on the main screen — has to be sought out ; Apple Health / fitness link | 14435767351 | TR: *"It doesn't communicate with iPhone Health-fitness; it said it did"* — claimed somewhere, not working for this user ; Cross-device sync | 13742691466 | Absent — *"does not let you sync between your Phone and iPad"* ; Apple Watch app | 13616264173 | Requested → treated as absent as of Jan 2026 by this reviewer; not verifiable here ; Within-day counting | 13453953092, 14061534070 | Absent — cannot log a habit N times a day and sum it ; Per-day values / notes | 14438650069 | Absent — cannot record "walked 5k" against a day ; Missed-day marking / past-day lock | 14453647912 | Absent — no cross/red mark, no way to freeze history ; Offline operation | 13314856744 | Premium check fails without internet and re-paywalls a paying customer ; Localisation | 17 non-English reviews across TR/ES/IT/RU/AR/VI | Reviewers write in their own languages; no reviewer complains about missing localisation or about translation quality — one reminder per day only; statistics not on the main screen; Apple Health link claimed somewhere but not working ('It doesn't communicate with iPhone Health-fitness; it said it did'); cross-device sync absent; Apple Watch treated as absent; within-day counting, per-day values and missed-day marking absent; premium check fails without internet; no localisation complaints across 17 non-English reviews

- **Where:** §2.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** inventory table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `13212775795`, `13332648782`, `14394122206`, `14421182094`, `14453647912`, `14191010644`, `13616264173`, `14288307273`, `14136173462`, `14134782126`, `13956421952`, `13453953092`, `14435767351`, `13742691466`, `14061534070`, `14438650069`, `13314856744`
- **Canonical:** C010 Backfill missed days / edit start date; C013 Cloud sync / multi-device as the paid differentiator; C014 Multiple reminders per habit; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C139 Cache entitlements locally — never block a paid surface on a live server check; C143 Intra-day completion: tap N times to fill N/N

### R62-022 — Unmet needs ranked by evidence (verbatim): Rank | Unmet need | n | % | Mean ★ | Why it ranks here ; 1 | Within-day granularity (count N times/day, multiple reminders/day, per-day values) | 4 | 8.89% | 3.25 | The largest coherent feature gap in the corpus, from 4 storefronts (dk, tj, in, za) across 8 months. IDs 13453953092, 13956421952, 14061534070, 14438650069. Two of the corpus's described use cases (water, steps) are unserviceable without it ; 2 | Widget depth (dark theme, next-unfinished, richer) | 2 | 4.44% | 4.00 | Small count, outsized leverage: the widget is the only named purchase trigger (13332648782) and the credited retention mechanism (14394122206). A lifetime buyer is the one complaining (14191010644) ; 3 | Cross-device sync | 1 | 2.22% | 1.00 | 13742691466 is a willing buyer (*"reasonably priced"*) who did not buy solely because of this. A revenue-blocking gap, not a nice-to-have ; 4 | Streak integrity (mark missed days, lock past days) | 1 | 2.22% | 4.00 | 14453647912 argues unlimited back-dating makes streaks meaningless — an attack on the product's core promise, from a fan ; 5 | Statistics on the main screen | 1 | 2.22% | 4.00 | 13453953092 names it as a reason they are *"consider[ing] other options"* ; 6 | Apple Watch app | 1 | 2.22% | 4.00 | 13616264173; existence not verifiable here (§9.5) ; 7 | Apple Health / fitness integration | 1 | 2.22% | 2.00 | 14435767351 believed it was advertised — if so, it is an expectation mismatch, which is worse than a gap ; 8 | In-product explanation of options | 1 | 2.22% | 4.00 | 14421182094 — cheapest item on this list — rank 1 within-day granularity (count N times a day, multiple reminders a day, per-day values) — 4 reviews from 4 storefronts (dk, tj, in, za) across 8 months: 'Please make it possible to have reminders several times a day, so you can set a reminder to drink water or walk steps. One reminder a day is not enough' (RU, 3★); cannot count water multiple times a day (2★); store a value per day ('walked 5k, then 7k') and see it over time (4★); statistics on the main screen plus N-times-a-day (4★, considering alternatives) — 'the largest coherent feature gap in the corpus' making two described use cases (water, steps) serviceable for the first time; P1: within-day counting with sum at day end and more than one reminder per day; P5: per-day values / notes — the same data-model change

- **Where:** §3.5 table (verbatim); §8.3 P1, P5
- **This app does:** binary daily check only; one reminder a day
- **User reaction:** request
- **Magnitude:** 4 (8.89%) at 3.25★
- **Direction for us:** feature · **Report confidence:** high-priority (n=4) · **Generalisable:** generalisable
- **Review IDs:** `13453953092`, `13956421952`, `14061534070`, `14438650069`
- **Canonical:** C012 Week / month / year grid views; C014 Multiple reminders per habit; C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N; C172 Per-day / per-habit notes and journal text

### R62-023 — Cross-device sync is a revenue-blocking gap: 'looked really promising and reasonably priced, but does not let you sync between your Phone and iPad' (US, 1★) — a willing buyer who did not buy solely because of this; P3: iPhone ↔ iPad iCloud sync — 'one review, but it is a willing buyer who did not buy. Revenue-blocking, not cosmetic'

- **Where:** §3.5 rank 3; §5.6; §8.3 P3
- **This app does:** no iPhone–iPad sync
- **User reaction:** request
- **Magnitude:** 1 (2.22%); blocked a willing buyer
- **Direction for us:** feature · **Report confidence:** single review · **Generalisable:** generalisable
- **Review IDs:** `13742691466`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator

### R62-024 — Apple Watch app requested once (UZ, 4★, alongside a widget that should surface the next unfinished habit); treated as absent as of Jan 2026, existence not verifiable; P9: lowest priority of the set

- **Where:** §3.5 rank 6; §8.3 P9; §8.4 #5
- **This app does:** no Watch app (per reviewer)
- **User reaction:** request
- **Magnitude:** 1 (2.22%)
- **Direction for us:** feature · **Report confidence:** single review · **Generalisable:** app-specific
- **Review IDs:** `13616264173`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R62-034 — Product — what converts 4★ into 5★ and defends the moat (verbatim): # | Action | Evidence | Priority rationale ; P1 | Within-day counting: log a habit N times a day, sum at day end; allow more than one reminder per day | §3.5 rank 1 — 4 reviews, 4 storefronts, 8 months: 13453953092 (dk), 13956421952 (tj), 14061534070 (in), 14438650069 (za) | The largest coherent feature gap in the corpus, and it makes two described use cases (water, steps) serviceable for the first time ; P2 | Widget depth: dark theme, and a mode that surfaces the next *unfinished* habit | §3.5 rank 2 — 14191010644 (lifetime buyer), 13616264173 | Highest leverage per unit of work: the widget is the paid hook (M3) ; P3 | Cross-device sync (iPhone ↔ iPad, iCloud) | §3.5 rank 3 — 13742691466 (us, 1★): *"looked really promising and reasonably priced, but does not let you sync"* | One review, but it is a willing buyer who did not buy. Revenue-blocking, not cosmetic ; P4 | Streak integrity: mark missed days explicitly; optionally lock past days | §3.5 rank 4 — 14453647912 (in, 4★): unlimited back-dating makes *"streaks less meaningful"* | Defends the product's core promise, argued by a fan. Ship as an option (some users need back-fill) ; P5 | Per-day values / notes (walked 5k, then 7k) | 14438650069 (za, 4★) | Natural companion to P1 — same data model change ; P6 | Statistics reachable from the main screen without adding clutter | 13453953092 (dk, 4★) — named as a reason for considering alternatives | Also answers 14421182094's complaint that options are unexplained ; P7 | Explain the options in-product (one-line hints on first use) | 14421182094 (py, 4★) | Cheapest item in the report ; P8 | Give the dot grid a time axis — visible month / week / day framing | 13212775795 (it, 1★, *"a sea of dots"*) | Single reviewer, so run it as a design test, not a rewrite (§8.3 note) ; P9 | Apple Watch app / complication | 13616264173 (uz, 4★) | Lowest priority of the set: one request, and existence could not be verified here — every item opt-in, not default-on: P1 within-day counting and multiple reminders; P2 widget depth; P3 cross-device sync; P4 streak integrity; P5 per-day values / notes; P6 statistics reachable from the main screen without clutter; P7 explain the options; P8 a time axis on the dot grid; P9 Apple Watch

- **Where:** §8.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** request
- **Magnitude:** nine product actions
- **Direction for us:** feature · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13453953092`, `13956421952`, `14061534070`, `14438650069`, `14191010644`, `13616264173`, `13742691466`, `14453647912`, `14421182094`, `13212775795`
- **Canonical:** C012 Week / month / year grid views; C013 Cloud sync / multi-device as the paid differentiator; C022 Apple Watch app (done properly: timer, two-way sync); C048 Flexible units / partial progress; C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in; C107 Widget variants and customisation as the paid layer; C143 Intra-day completion: tap N times to fill N/N; C217 An unexplained metric reads as broken — explain the score on-screen; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

## Monetization

### R62-009 — The one named purchase trigger is the widget — and the widget is under-built: 'I bought the paid version of the app (single month), because I wanted to use the larger widget showing the entire heat map and i absolutely love it' (IN, 5★, 'Worth every penny') is the only review that states what it bought and why; the widget family is 4 (8.89%, mean 4.50) and splits cleanly — praise / purchase driver ('I use widgets for all my new habits. Without it I would underestimate the progress and tend to give up… I was able to successfully track and build new habits for the first time with this app' — the strongest outcome statement in the corpus credits the widget: 'the widget is not decoration, it is the retention mechanism') vs named gaps (a lifetime buyer: 'no dark themed widget? Widget so basic? Please step it up, I just paid for lifetime access'; it should surface the next unfinished habit); three of the six widget data points connect it to money or retention; widget mentions rise from nowhere to the centre of the corpus (1 → 1 → 2 by period, all tied to money or retention); working hypothesis: the widget is this product's paid hook and is under-built relative to its commercial importance; M3: make the widget the explicit centre of the paid offer; P2: widget depth — dark theme and a next-unfinished mode — 'highest leverage per unit of work'

- **Where:** §0.6; §5.2; §3.5 rank 2; §7.6; §8.2 M3; §8.3 P2
- **This app does:** large heat-map widget behind premium; no dark widget
- **User reaction:** purchase-driver
- **Magnitude:** widget 4 (8.89%) at 4.50★; 1 named trigger
- **Direction for us:** monetization · **Report confidence:** medium confidence · **Generalisable:** generalisable
- **Review IDs:** `13332648782`, `14394122206`, `14191010644`, `13616264173`
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app; C107 Widget variants and customisation as the paid layer

### R62-015 — Free / paid classification (verbatim): Tier | What reviewers place here | Evidence ; Free | Core habit tracking, capped at 3 habits; check-off; streaks; at least a basic widget; back-dating | 12547737504, 12634608390, 13610103490, 14251077324 (all four independently say 3); 14280213491 (ca, 5★) titles their review *"Free good tracking app"* ; Paid — subscription | Unlimited habits; the large heat-map widget | 13332648782 (bought "single month" *for* the widget); 12863807910 (monthly); 14134782126 ("premium") ; Paid — lifetime / one-time | Same, bought outright | 14191010644 (*"I just paid for lifetime access"*); 13314856744 (ES *"I already bought the app"*) ; Two subscription tiers, undifferentiated | Unknown — the reviewer cannot tell them apart | 14396613983 (sa, 5★): *"What is the difference between the 34 and 59 paid subscription?"* ; Unclear | Whether the large widget, statistics, or extra reminders sit behind the paywall or simply do not exist | Compare 13453953092 (stats not on main screen) with 13332648782 (widget is paid) — price points stated: '$10' (UA); two tiers '34' and '59' in an unstated currency ('What is the difference between the 34 and 59 paid subscription?' asked publicly in a 5★ review); three reviewers volunteer that the price is good ('The price is also very affordable considering the features it offers'; 'the subscription prices are very good'; 'reasonably priced' — from a 1★ who still did not buy because of the sync gap); the one-time-purchase request is probably already satisfied — asked for in Apr 2025, a lifetime purchase reported in Jun 2026 — 'a discoverability finding, not a roadmap one' (M4: surface the lifetime SKU more prominently, and confirm it exists); M2: differentiate the two subscription tiers on the paywall itself — one buyer had to publish a review to ask

- **Where:** §2.2 table (verbatim); §8.4 #1, #2
- **This app does:** monthly / two tiers / lifetime; 3 free habits
- **User reaction:** mixed
- **Magnitude:** classification table; 3 price-is-fair vs 2 objections
- **Direction for us:** monetization · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `12547737504`, `12634608390`, `13610103490`, `14251077324`, `14280213491`, `13332648782`, `12863807910`, `14134782126`, `14191010644`, `13314856744`, `14396613983`, `14136173462`, `13759855538`, `13926027561`, `13742691466`, `13453953092`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C064 Price level — where 'fair' turns into 'too expensive'; C133 Gate on capability, not on quantity; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R62-020 — Money — 12 negative (26.67%, mean 2.25) (verbatim): Sub-theme | n | % of 45 | Mean ★ | IDs ; 3-habit free cap | 4 | 8.89% | 2.75 | 12547737504, 12634608390, 13610103490, 14251077324 ; Post-purchase breakage | 3 | 6.67% | 2.33 | 14134782126, 14136173462, 14191010644 ; Entitlement failure (paid, not unlocked) | 2 | 4.44% | 3.00 | 12863807910, 13314856744 ; Objects to paying at all | 2 | 4.44% | 1.00 | 13990739214, 14259200458 ; Upsell pop-ups | 1 | 2.22% | 1.00 | 13680580523 — the two flat price objections are the thinnest reviews in the corpus ('It's paid' / 'It's paid'; 'Asked for a payment in simple app like this' — an objection to paying for simplicity, the flip side of the app's own positioning) and should not be over-read; against them three volunteer that the price is good — 'price level is not this app's problem; packaging (what the free tier contains) and delivery (whether the purchase works) are'; §8.2: repackage, do not reprice

- **Where:** §3.4.2 table (verbatim); §8.2
- **This app does:** n/a
- **User reaction:** downgrade
- **Magnitude:** 12 (26.67%) at 2.25★; objections 2 vs fair 3
- **Direction for us:** product-rule · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `13990739214`, `14259200458`, `13759855538`, `13926027561`, `13742691466`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C133 Gate on capability, not on quantity; C214 A bare checklist or task-slot paywall cannot carry a premium price — it is compared to Reminders, Notes, alarms and paper, free on every phone, and loses

### R62-028 — Paid-user context: not direct purchase evidence — a pre-purchase question about which tier to buy (intent), 'reasonably priced' but did not buy (blocked intent), the one-time-option request (preference for a SKU that may now exist), 'Free good tracking app' (satisfied non-payer); zero refunds, cancellations, billing errors; one churn event, a non-payer at the 3-habit cap, and one signalled ('considering other options' over statistics and within-day counting). Barriers to upgrading (verbatim): Barrier | n | IDs | Evidence ; Free tier too tight to prove value | 4 | 12547737504, 12634608390, 13610103490, 14251077324 | All four name 3 habits; one asks for exactly one more free habit ; A missing feature blocks a willing buyer | 1 | 13742691466 | *"looked really promising and reasonably priced, but does not let you sync between your Phone and iPad"* ; Cannot tell the tiers apart | 1 | 14396613983 | *"What is the difference between the 34 and 59 paid subscription?"* — asked publicly, in a review, because the paywall did not answer it ; Objects to paying at all | 2 | 13990739214, 14259200458 | Unlikely to convert at any price ; Upsell pressure during use | 1 | 13680580523 | *"Get one star for annoying me with pop-ups"* — competitive position: 'From what i have tested this one is the one i liked the most' (won a comparison shop); considering alternatives over statistics (losing one); the 'original Streaks' collision (losing on brand identity before the product is tried); implicit comparison against cross-device competitors; no competitor named other than the implied original

- **Where:** §5.1; §5.5; §5.6 table (verbatim); §5.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** barriers table; 1 won, 1 losing
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14396613983`, `13742691466`, `12547737504`, `14280213491`, `13610103490`, `13453953092`, `14212735361`, `13682484600`
- **Canonical:** C005 Know which competitors buyers compare against; C013 Cloud sync / multi-device as the paid differentiator; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C278 Do not name the app after an established competitor — a name collision makes the product 'the fake one' before it is tried, and the cost cannot be measured from reviews

## Tactics the app used

### R62-033 — Monetization — repackage, do not reprice (verbatim): # | Action | Evidence ; M1 | Raise the free habit allowance from 3 to 5, or make the 4th habit a time-limited trial rather than a wall | §0.4 / §3.4.2 — 4 reviews name the cap, rated 5★/3★/2★/1★; 12547737504 asks for *exactly one more*; 13610103490 uninstalled at the wall while praising the UI. The use cases described in §3.3.3 need 4–6 habits (14424678681 runs three religious habits alone) ; M2 | Differentiate the two subscription tiers on the paywall itself | §5.6, 14396613983 (sa) had to *publish a review* to ask what the difference between the two tiers was. Whatever that paywall says, one buyer could not read it ; M3 | Make the widget the explicit centre of the paid offer | §5.2 — the only named purchase trigger (13332648782, bought the month *for* the heat-map widget); the credited retention mechanism (14394122206); and the one thing a lifetime buyer publicly complains about (14191010644) ; M4 | Surface the lifetime / one-time SKU more prominently — and confirm it exists | §2.2: 12547737504 asked for it in Apr 2025; 14191010644 reports buying it in Jun 2026. If it exists and is still being asked for, that is discoverability, not roadmap (carried as a research question, §8.4) ; M5 | Cut the in-session upsell pop-ups, or cap their frequency | §3.4.2, 13680580523 (pl, 1★, *"Get one star for annoying me with pop-ups"*) — one review, but it cost a full star and it is a setting, not a build — M1 free allowance 3 → 5 or a time-limited 4th habit; M2 differentiate the two tiers on the paywall; M3 the widget at the centre of the paid offer; M4 surface the lifetime SKU and confirm it exists; M5 cut in-session upsell pop-ups

- **Where:** §8.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** downgrade
- **Magnitude:** five monetization actions
- **Direction for us:** tactic · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `12547737504`, `13610103490`, `14424678681`, `14396613983`, `13332648782`, `14394122206`, `14191010644`, `13680580523`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C093 No upsell nagging without a 'never ask again' option; C107 Widget variants and customisation as the paid layer; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

## Insights (the why)

### R62-006 — Every single 4★ review is a feature request with a rating attached — all 6 (13.33% of corpus, 100% of the band) contain a request, none reports a bug or complains about price; the cleanest conversion list in the corpus, six named people each with one bounded ask between them and 5★ (verbatim): Review ID | CC | The one ask ; 13453953092 | dk | Overall statistics on the main screen + count a habit N times a day ; 13616264173 | uz | Widget should show the *next unfinished* habit; Apple Watch app ; 14191010644 | uz | Dark-themed widget; richer widget (paid lifetime) ; 14421182094 | py | Explain what the options actually do ; 14438650069 | za | Store a value or note per day (walked 5k, then 7k) and see it over time ; 14453647912 | in | Mark *missed* days; lock past days so streaks stay honest — 3 of 6 praise simplicity in the same breath; one is a paying lifetime customer, one is explicitly considering leaving ('makes me consider other options… If these features appear, I will be ready to consider using the app again'); shipping against that list is the cheapest rating improvement available, with the constraint that every item be opt-in

- **Where:** §0.3 table (verbatim); §4.3; §8.3
- **This app does:** n/a
- **User reaction:** request
- **Magnitude:** 6 of 6 4★ are requests
- **Direction for us:** none · **Report confidence:** high-priority (n=6) · **Generalisable:** generalisable
- **Review IDs:** `13453953092`, `13616264173`, `14191010644`, `14421182094`, `14438650069`, `14453647912`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C107 Widget variants and customisation as the paid layer; C143 Intra-day completion: tap N times to fill N/N; C217 An unexplained metric reads as broken — explain the score on-screen; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

### R62-016 — What is NOT in this corpus — notable absences, each a real signal at this size: zero ads or ad complaints; zero privacy complaints; zero accessibility requests (though the June build was an accessibility failure in effect — an app that cannot be operated by tapping); zero refund requests, cancellations, billing errors or double charges — the two reviewers whose purchases failed ask for a fix, not a refund ('a genuine and reportable absence — in comparable corpora these categories are usually populated'); zero customer-support mentions — nobody reports contacting the developer, including the three whose app was broken after paying; zero AI requests; zero 'it asked me to pay before I saw the app' complaints — the one upsell complaint is about pop-ups during use; no review asks for sharing, friends, leaderboards or accountability partners and none describes breaking a bad habit despite the 'Atomic Goals & Accountability' subtitle; §8.5: do not build ads, do not chase the accountability positioning with social features, do not raise or cut prices

- **Where:** §2.2 absences; §5.5; §7.9; §8.5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** zero in each category
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** generalisable
- **Review IDs:** `12863807910`, `13314856744`, `14131374072`, `14135188688`, `13680580523`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back; C064 Price level — where 'fair' turns into 'too expensive'; C131 No default-on social feed in a personal tool; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R62-017 — Theme-family aggregates (verbatim): Family | n | % of 45 | Mean ★ | Signal | Direction ; Praise (any) | 18 | 40.00% | 4.67 | high-priority | positive ; Money (any mention) | 17 | 37.78% | 2.82 | high-priority | mixed ; Feature requests (any) | 12 | 26.67% | 3.75 | high-priority | constructive ; Money — negative | 12 | 26.67% | 2.25 | high-priority | negative ; Reliability (any) | 11 | 24.44% | 1.64 | high-priority | negative ; UX / design friction | 5 | 11.11% | 2.20 | high-priority | negative ; Churn stated or implied | 4 | 8.89% | 2.00 | high-priority | negative ; Within-day granularity gap | 4 | 8.89% | 3.25 | high-priority | unmet need ; Widget (any mention) | 4 | 8.89% | 4.50 | high-priority | mixed ; Trust damage | 3 | 6.67% | 1.00 | high-priority | negative — the two biggest families, praise and money, barely overlap; reliability is the lowest-rated family (1.64) and almost entirely one event. Master table — every theme sorted by count (verbatim): # | Theme | n | % of 45 | Mean ★ | Signal | Representative IDs ; 1 | praise_simplicity_minimal | 11 | 24.44% | 4.45 | high-priority | 12510217982, 13332648782, 13354961662, 13366854737, 13610103490, 13759855538, 13926027561, 14288307273, 14453647912 ; 2 | praise_general_with_caveat | 8 | 17.78% | 3.75 | high-priority | 12634608390, 13314856744, 13453953092, 13616264173, 14191010644, 14438650069, 14453647912, 14481733593 ; 3 | broken_build_jun2026_burst | 8 | 17.78% | 1.62 | high-priority | 14129863718, 14131374072, 14131709751, 14134782126, 14135188688, 14136118921, 14136173462, 14136346335 ; 4 | low_info_praise | 7 | 15.56% | 5.00 | high-priority | 12510217982, 13366854737, 14212735361, 14280213491, 14288307273, 14415660670, 14503535367 ; 5 | tap_unresponsive | 6 | 13.33% | 1.17 | high-priority | 14131374072, 14131709751, 14134782126, 14135188688, 14136118921, 14136173462 ; 6 | praise_ui_design | 6 | 13.33% | 4.17 | high-priority | 12547737504, 13332648782, 13610103490, 13759855538, 14421182094, 14453647912 ; 7 | paid_user | 6 | 13.33% | 3.00 | high-priority | 12863807910, 13314856744, 13332648782, 14134782126, 14136173462, 14191010644 ; 8 | rating_text_contradiction | 4 | 8.89% | 3.25 | high-priority | 13314856744, 14129863718, 14136346335, 14481733593 ; 9 | paywall_habit_cap_3 | 4 | 8.89% | 2.75 | high-priority | 12547737504, 12634608390, 13610103490, 14251077324 ; 10 | price_perceived_fair | 3 | 6.67% | 3.67 | high-priority | 13742691466, 13759855538, 13926027561 ; 11 | praise_progress_visualization | 3 | 6.67% | 4.67 | high-priority | 13332648782, 14394122206, 14421182094 ; 12 | praise_outcome_habit_formation | 3 | 6.67% | 5.00 | high-priority | 14394122206, 14424678681, 14503535367 ; 13 | post_purchase_breakage | 3 | 6.67% | 2.33 | high-priority | 14134782126, 14136173462, 14191010644 ; 14 | app_unusable_generic | 2 | 4.44% | 3.00 | very strong | 14129863718, 14136346335 ; 15 | churn_advises_avoid | 2 | 4.44% | 1.00 | very strong | 13682484600, 14131374072 ; 16 | entitlement_failure | 2 | 4.44% | 3.00 | very strong | 12863807910, 13314856744 ; 17 | paid_lifetime_or_onetime | 2 | 4.44% | 4.50 | very strong | 13314856744, 14191010644 ; 18 | paid_monthly | 2 | 4.44% | 3.00 | very strong | 12863807910, 13332648782 ; 19 | paid_unspecified_premium | 2 | 4.44% | 1.50 | very strong | 14134782126, 14136173462 ; 20 | praise_recommend | 2 | 4.44% | 5.00 | very strong | 13332648782, 13759855538 ; 21 | praise_widget | 2 | 4.44% | 5.00 | very strong | 13332648782, 14394122206 ; 22 | price_objection_any_payment | 2 | 4.44% | 1.00 | very strong | 13990739214, 14259200458 ; 23 | purchase_intent_blocked | 2 | 4.44% | 3.00 | very strong | 13742691466, 14396613983 ; 24 | regression_after_update | 2 | 4.44% | 1.50 | very strong | 14129863718, 14481733593 ; 25 | req_multi_count_per_day | 2 | 4.44% | 3.00 | very strong | 13453953092, 14061534070 ; 26 | ui_quality_complaint | 2 | 4.44% | 1.00 | very strong | 14131709751, 14135188688 ; 27 | usecase_fitness_sport | 2 | 4.44% | 4.50 | very strong | 14280213491, 14438650069 ; 28 | usecase_hydration_steps | 2 | 4.44% | 2.50 | very strong | 13956421952, 14061534070 ; 29 | churn_considering_alternatives | 1 | 2.22% | 4.00 | meaningful | 13453953092 ; 30 | churn_uninstalled | 1 | 2.22% | 2.00 | meaningful | 13610103490 ; 31 | clone_brand_confusion | 1 | 2.22% | 1.00 | meaningful | 13682484600 ; 32 | data_loss_total | 1 | 2.22% | 1.00 | meaningful (promoted — severe) | 13330819055 ; 33 | data_loss_partial | 1 | 2.22% | 2.00 | meaningful (promoted — severe) | 14481733593 ; 34 | healthkit_not_working | 1 | 2.22% | 2.00 | meaningful | 14435767351 ; 35 | longtime_user | 1 | 2.22% | 5.00 | meaningful | 13759855538 ; 36 | missing_stats_on_home | 1 | 2.22% | 4.00 | meaningful | 13453953092 ; 37 | onboarding_blocked | 1 | 2.22% | 1.00 | meaningful | 14136118921 ; 38 | options_unexplained | 1 | 2.22% | 4.00 | meaningful | 14421182094 ; 39 | performance_lag | 1 | 2.22% | 1.00 | meaningful | 14131374072 ; 40 | praise_comparative_preference | 1 | 2.22% | 5.00 | meaningful | 14212735361 ; 41 | praise_intuitive | 1 | 2.22% | 5.00 | meaningful | 13354961662 ; 42 | praise_outcome_focus | 1 | 2.22% | 5.00 | meaningful | 14415660670 ; 43 | pricing_confusion | 1 | 2.22% | 5.00 | meaningful | 14396613983 ; 44 | purchase_trigger_widget | 1 | 2.22% | 5.00 | meaningful | 13332648782 ; 45 | req_apple_watch | 1 | 2.22% | 4.00 | meaningful | 13616264173 ; 46 | req_continued_development | 1 | 2.22% | 5.00 | meaningful | 13926027561 ; 47 | req_explain_options | 1 | 2.22% | 4.00 | meaningful | 14421182094 ; 48 | req_icloud_cross_device_sync | 1 | 2.22% | 1.00 | meaningful | 13742691466 ; 49 | req_manual_improvement_unspecified | 1 | 2.22% | 5.00 | meaningful | 14212735361 ; 50 | req_missed_mark_and_lock_past_days | 1 | 2.22% | 4.00 | meaningful | 14453647912 ; 51 | req_more_free_habits | 1 | 2.22% | 5.00 | meaningful | 12547737504 ; 52 | req_multi_reminder_per_day | 1 | 2.22% | 3.00 | meaningful | 13956421952 ; 53 | req_onetime_purchase | 1 | 2.22% | 5.00 | meaningful | 12547737504 ; 54 | req_quantified_values_and_notes | 1 | 2.22% | 4.00 | meaningful | 14438650069 ; 55 | req_widget_dark_theme_richer | 1 | 2.22% | 4.00 | meaningful | 14191010644 ; 56 | req_widget_next_unfinished | 1 | 2.22% | 4.00 | meaningful | 13616264173 ; 57 | scam_suspicion | 1 | 2.22% | 1.00 | meaningful | 12863807910 ; 58 | ui_confusion_dots_calendar | 1 | 2.22% | 1.00 | meaningful | 13212775795 ; 59 | upsell_popups | 1 | 2.22% | 1.00 | meaningful | 13680580523 ; 60 | usecase_religious_practice | 1 | 2.22% | 5.00 | meaningful | 14424678681

- **Where:** §3.1 table (verbatim); §3.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 8 families; 60 themes
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R62-025 — Ratings: 17 / 6 / 2 / 5 / 15 (5★→1★), mean 3.111, bimodal — 37.78% at 5★, 33.33% at 1★, only 4.44% at 3★: 'people are either satisfied or blocked; almost nobody is lukewarm'. Theme × rating (verbatim): Rating | n | % of 45 | Money-neg | Reliability | UX friction | Praise | Feature request ; 5★ | 17 | 37.78% | 2 | 1 | 0 | 14 | 3 ; 4★ | 6 | 13.33% | 1 | 0 | 2 | 3 | 6 (100%) ; 3★ | 2 | 4.44% | 1 | 0 | 0 | 0 | 1 ; 2★ | 5 | 11.11% | 2 | 3 | 0 | 1 | 1 ; 1★ | 15 | 33.33% | 6 | 7 | 3 | 0 | 1 — 1★ reviews contain zero praise (the bottom band is not fans who got burned, with one past-tense exception 'It was good until the last update'); 1★ splits almost evenly between reliability (7) and money (6) — fix either and the band roughly halves; 4★ is 100% feature requests and 0% bugs — 'a to-do list, not a complaint'

- **Where:** §Part 4 intro; §4.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** bimodal 37.78% / 33.33%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14129863718`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C031 Crashes / launch failures

### R62-027 — Three stars (2): both single-issue — the cap, and 'One reminder a day is not enough' — neither criticises the product itself. Two stars (5) (verbatim): Review | Reason for 2★ ; 13610103490 (in) | Praises the UI, then uninstalls over the 3-habit cap ; 14061534070 (in) | Cannot count a habit multiple times per day (water) ; 14134782126 (tr) | Premium buyer, edit-previous-day buttons dead (June burst) ; 14435767351 (tr) | Apple Health / fitness link does not work — *"it said it did"* ; 14481733593 (kz) | *"Great app but unfortunately unreliable"* — weekly progress wiped twice on update — 'where paying and near-paying users land when something specific breaks or is missing'; four of five name one fixable thing. One star (15) — 6 of them are one bug (segment rates, denominator 15) (verbatim): Cause | n | % of the 15 (segment rate) | Global count / 45 | IDs ; June 2026 broken build | 6 | 40.0% | 13.33% | 14129863718, 14131374072, 14131709751, 14135188688, 14136118921, 14136173462 ; Monetization (cap, price, upsell, failed purchase) | 6 | 40.0% | 13.33% | 12863807910, 13680580523, 13990739214, 14251077324, 14259200458 (+14136173462, also in the burst) ; Data loss | 1 | 6.7% | 2.22% | 13330819055 ; Brand confusion / "fake" | 1 | 6.7% | 2.22% | 13682484600 ; Missing sync | 1 | 6.7% | 2.22% | 13742691466 ; Main-screen legibility | 1 | 6.7% | 2.22% | 13212775795 — 'two causes — one release regression and one packaging decision — account for 11 of the 15 one-star reviews (73.3% of the band, 24.4% of the corpus). Neither requires new product surface to address'

- **Where:** §4.4; §4.5 table (verbatim); §4.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 11 of 15 1★ from two causes
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `12634608390`, `13956421952`, `13610103490`, `14061534070`, `14134782126`, `14435767351`, `14481733593`, `12863807910`, `13212775795`, `13330819055`, `13680580523`, `13682484600`, `13742691466`, `13990739214`, `14251077324`, `14259200458`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C031 Crashes / launch failures; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R62-037 — A broken build is an accessibility failure in effect and an acquisition failure: two reviewers read the unresponsive-tap regression as bad design ('hire a designer'), counted in both reliability and UX; the build blocked first-run habit creation so it destroyed new-user acquisition for its duration; 'the regression is closed; the reviews it produced are not' — 1★ reviews from a 39-hour window are permanent on the listing

- **Where:** §7.3; §8.1 I3; §2.2 absences
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 2 read it as design; 1 onboarding blocked
- **Direction for us:** none · **Report confidence:** high confidence · **Generalisable:** generalisable
- **Review IDs:** `14131709751`, `14135188688`, `14136118921`
- **Canonical:** C031 Crashes / launch failures; C156 Content and event releases need a crash gate across device generations; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

## Audiences

### R62-018 — Outcome claims — 3 (6.67%, mean 5.00), the only reviews that describe a result: the widget-credited first successful habit formation; an Arabic reviewer who became consistent with morning adhkār, general dhikr and daily Qur'an reading ('even if just a page') and advises others building a habit to include remembrance of God — the only religious-practice use case and the most emotionally invested review; 'Useful, helps build good habits' (VI); 'Helps focus on daily tasks' (ES) — 'these four reviews are the marketing copy', and two show the app working for non-Western, non-fitness routines the store positioning does not address. Use cases (verbatim): Use case | IDs | Note ; Fitness / sport progress | 14280213491, 14438650069 | 14438650069 wants per-day distance values ; Hydration / step counts | 13956421952, 14061534070 | Both are the within-day counting gap — this use case is currently *unserved* ; Religious practice | 14424678681 | 3+ concurrent habits, i.e. already over the free cap ; Daily task focus | 14415660670 | — ; Quitting / breaking habits | — | Absent. Despite "accountability" positioning, no review describes breaking a bad habit — hydration / steps is currently unserved (within-day counting gap); religious practice already runs 3+ concurrent habits, i.e. over the free cap; quitting a bad habit is absent despite the accountability positioning

- **Where:** §3.3.2; §3.3.3 table (verbatim); §6.4; §6.5
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** outcomes 3 at 5.00★
- **Direction for us:** none · **Report confidence:** high-priority (n=3) · **Generalisable:** generalisable
- **Review IDs:** `14394122206`, `14424678681`, `14503535367`, `14415660670`, `14280213491`, `14438650069`, `13956421952`, `14061534070`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C107 Widget variants and customisation as the paid layer; C140 Market the generic-tracker use case

## Markets and languages

### R62-029 — No storefront qualifies for standalone analysis — the largest has 8 vs the 50 threshold; every Part 6 statement is [limited evidence] (verbatim): CC | Country | n | % of 45 | Mean ★ | Market group | Review IDs ; tr | Turkey | 8 | 17.78% | 3.50 | high-volume | 12510217982, 12634608390, 13366854737, 13759855538, 13926027561, 14134782126, 14136118921, 14435767351 ; in | India | 8 | 17.78% | 3.12 | high-volume | 12547737504, 13332648782, 13610103490, 13682484600, 14061534070, 14129863718, 14394122206, 14453647912 ; sa | Saudi Arabia | 3 | 6.67% | 5.00 | high-spend | 14136346335, 14396613983, 14424678681 ; ua | Ukraine | 2 | 4.44% | 1.00 | high-volume | 13330819055, 14136173462 ; us | United States | 2 | 4.44% | 3.00 | high-spend | 13354961662, 13742691466 ; uz | Uzbekistan | 2 | 4.44% | 4.00 | long-tail | 13616264173, 14191010644 ; pl | Poland | 2 | 4.44% | 1.00 | high-volume | 13680580523, 14259200458 ; ar | Argentina | 2 | 4.44% | 1.00 | high-volume | 14131374072, 14131709751 ; es | Spain | 2 | 4.44% | 3.00 | high-spend | 14135188688, 14212735361 ; py | Paraguay | 2 | 4.44% | 4.50 | long-tail | 14288307273, 14421182094 ; br | Brazil | 1 | 2.22% | 1.00 | high-volume | 12863807910 ; it | Italy | 1 | 2.22% | 1.00 | high-spend | 13212775795 ; ec | Ecuador | 1 | 2.22% | 5.00 | long-tail | 13314856744 ; dk | Denmark | 1 | 2.22% | 4.00 | high-spend | 13453953092 ; tj | Tajikistan | 1 | 2.22% | 3.00 | long-tail | 13956421952 ; mn | Mongolia | 1 | 2.22% | 1.00 | long-tail | 13990739214 ; ie | Ireland | 1 | 2.22% | 1.00 | high-spend | 14251077324 ; ca | Canada | 1 | 2.22% | 5.00 | high-spend | 14280213491 ; pe | Peru | 1 | 2.22% | 5.00 | high-volume | 14415660670 ; za | South Africa | 1 | 2.22% | 4.00 | high-volume | 14438650069 ; kz | Kazakhstan | 1 | 2.22% | 2.00 | long-tail | 14481733593 ; vn | Vietnam | 1 | 2.22% | 5.00 | high-volume | 14503535367 — 22 storefronts, 2.05 reviews per storefront; _state.json records 86 storefronts, 64 with zero reviews (GB, FR, NL, PT, FI, AU, NZ, KR, TW, SG, TH, PH, MX, RU, AE, IL); DE, JP, CN, SE, NO, CH, ID not probed at all. Market groups from the repository's markets.py tiering (a spend / volume proxy, not download data) (verbatim): Group | n | % of 45 | Mean ★ | Storefronts represented ; High-spend | 11 | 24.44% | 3.455 | ca, dk, es, ie, it, sa, us (7 of 27) ; High-review-volume | 26 | 57.78% | 2.846 | ar, br, in, pe, pl, tr, ua, vn, za (9 of 26) ; Long-tail | 8 | 17.78% | 3.500 | ec, kz, mn, py, tj, uz (6) — high-spend 3.455 vs high-volume 2.846, a 0.61 gap not to be over-read (largely the June burst and the Saudi artefact); cautious reading: high-spend reviewers ask for capability (sync, statistics, granularity — the two most concrete feature gaps, the legibility complaint) while high-volume and long-tail reviewers raise access (the free cap, paying at all); not one high-spend reviewer objects to the price — 'consistent with the corpus but not established by it; 11 reviews cannot support a segmentation strategy'

- **Where:** §6.1 table (verbatim); §6.2 table (verbatim); §6.3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** high-spend 11 at 3.455; high-volume 26 at 2.846
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `13742691466`, `13453953092`, `13212775795`, `14251077324`, `13990739214`, `14259200458`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R62-030 — Saudi Arabia n=3, mean 5.00 — and the mean is misleading: one substantive endorsement (the religious-practice review), one pricing question and one defect report, both 5★; the snapshot gives SA 36 public ratings at 4.78 so the storefront performs well but the written corpus cannot explain why. Turkey (8, 3.50) — most language-loyal (7 of 8 in Turkish), the clearest 'simple and useful' constituency and the only reviewers who volunteer the price is good; India (8, 3.12) — the most product-engaged storefront: both widget-outcome reviews, the streak-integrity request, the within-day counting request, the cap-driven uninstall, the brand-confusion 1★ — 'if any storefront deserves follow-up research, it is India'. Small storefronts (verbatim): Storefront | n | Observation ; Ukraine | 2 | Both 1★, and they are the two most severe non-burst defects in the corpus: total data loss (13330819055) and a $10 purchase that stopped working (14136173462). The repository snapshot gives UA 39 public ratings at 4.56 — the written reviews are the opposite tail of that storefront ; Argentina | 2 | Both 1★, both the June burst, both about taps not registering. One found the swipe workaround (14131709751) ; Poland | 2 | Both 1★, both monetization: upsell pop-ups (13680580523), *"It's paid"* (14259200458) ; Uzbekistan | 2 | Both widget requests, one from a lifetime buyer (14191010644, 13616264173) — the only storefront where both reviews point at the same feature ; Ecuador | 1 | The offline entitlement bug (13314856744) — highest-severity paid-user finding in the report ; Ireland | 1 | 14251077324, 1★ over the 3-habit cap. The repository snapshot shows IE has exactly 1 public rating, at 1.0 — i.e. this review *is* Ireland's entire App Store rating for this app ; Kazakhstan | 1 | Repeating weekly progress wipe on update (14481733593) ; Tajikistan | 1 | Multiple reminders per day (13956421952) ; Paraguay | 2 | Both positive (5★, 4★); 14421182094 asks for the options to be explained ; Denmark, South Africa | 1 each | The two "depth without complexity" requests: stats + within-day counting (13453953092), per-day values and notes (14438650069) ; Mongolia | 1 | *"Asked for a payment in simple app like this"* (13990739214) ; Brazil | 1 | Monthly subscription did not unlock; *"Is this scam?"* (12863807910) ; Italy | 1 | Main screen unreadable — *"a sea of dots"* (13212775795) ; US, Canada, Peru, Vietnam | 1–2 each | US: intuitive (13354961662) + no sync (13742691466). CA: *"Free good tracking app"* (14280213491). PE, VN: brief 5★ outcome praise — Ireland's one review is Ireland's entire App Store rating (1 public rating at 1.0). Written vs public by storefront (verbatim): CC | Public ratings | Public avg ★ | Written reviews here | Written mean ★ | Gap ; in | 64 | 4.17 | 8 | 3.12 | −1.05 ; ua | 39 | 4.56 | 2 | 1.00 | −3.56 ; sa | 36 | 4.78 | 3 | 5.00 | +0.22 ; tr | 36 | 4.56 | 8 | 3.50 | −1.06 ; es | 17 | 4.47 | 2 | 3.00 | −1.47 ; ar | 11 | 3.82 | 2 | 1.00 | −2.82 ; us | 10 | 4.50 | 2 | 3.00 | −1.50 ; za | 7 | 4.71 | 1 | 4.00 | −0.71 ; pe | 7 | 5.00 | 1 | 5.00 | 0.00 ; ca | 6 | 4.33 | 1 | 5.00 | +0.67 ; vn | 4 | 4.75 | 1 | 5.00 | +0.25 ; it | 3 | 3.33 | 1 | 1.00 | −2.33 ; ie | 1 | 1.00 | 1 | 1.00 | 0.00 ; Global | 536 | 4.52 | 45 | 3.111 | −1.41 — 'the written corpus is a complaint channel, not a satisfaction measure'; Argentina is the one place the gap shows in the public number too (3.82 on 11 ratings), consistent with the June burst hitting it hardest

- **Where:** §6.4; §6.5; §6.6 table (verbatim); §6.7 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** written 3.111 vs public 4.52; UA gap −3.56
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `14424678681`, `14396613983`, `14136346335`, `12510217982`, `13366854737`, `13926027561`, `13759855538`, `13332648782`, `14394122206`, `14453647912`, `14061534070`, `13610103490`, `12547737504`, `13682484600`, `14251077324`, `13330819055`, `14136173462`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

## Dated events and trends

### R62-031 — Three periods (verbatim): Period | Window | n | Mean ★ | Money-neg | Reliability | Praise | Requests | Paid users ; P1 | Apr 2025 – Dec 2025 | 11 | 3.64 | 4 | 1 | 5 | 2 | 3 ; P2 | Jan 2026 – May 2026 | 10 | 2.50 | 3 | 0 | 3 | 5 | 0 ; P3 | Jun 2026 – Sep 2026 | 24 | 3.12 | 5 | 10 | 10 | 5 | 3 — nothing here is a rate; direction-of-travel on named reviews. Trend 1: review volume more than doubled in the last four months — 24 of 45 in Jun–Sep 2026; June (10) exceeds all of 2025 H2; split between the defect burst (8 of June's 10) and genuine growth in Jul–Sep (14, mean 3.79); Aug–Sep (10, mean 4.10) the healthiest stretch. Trend 4: feature requests replaced monetization complaints as the main constructive theme — 2 → 5 → 5 (18% → 50% → 21% of period); P2 is the request-heavy and lowest-rated period (2.50) because the only things people wrote about were gaps — 'P2 is what this product's ceiling looks like when nothing is broken: people run into the edges of the feature set'. Trend 7: paid-user evidence 3 / 0 / 3 — sample noise, no trend claimed

- **Where:** §7.1 table (verbatim); §7.2; §7.5; §7.8
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** P1 11 at 3.64; P2 10 at 2.50; P3 24 at 3.12
- **Direction for us:** none · **Report confidence:** medium confidence · **Generalisable:** generalisable
- **Review IDs:** `14061534070`, `13616264173`, `13956421952`, `13610103490`, `13742691466`
- **Canonical:** C031 Crashes / launch failures; C143 Intra-day completion: tap N times to fill N/N

## Positioning

### R62-001 — Streaks – Daily Habit Tracker (App Store ID 6448960901; subtitle 'Atomic Goals & Accountability') by yusuf kildan (com.yusufkildan.habitTrackerApp) — a minimalist habit tracker with habit tiles and a dot / heat-map grid, streaks and home-screen widgets; free tier capped at 3 habits, premium sold monthly, as two undifferentiated subscription tiers, and as a lifetime unlock; 45 reviews (every one read), 22 storefronts, 6 Apr 2025 → 2 Sep 2026 (17 months), written-review mean 3.111 (17×5★, 6×4★, 2×3★, 5×2★, 15×1★); store-level context only from the repository's own snapshot Tools/habit_apps_ranked.json — 536 public ratings at 4.52, ranked in 50 storefronts, best rank 10, median 24 ('thin — ranks well but very few ratings'); Apple lookup API and listing egress-blocked

- **Where:** header lines 1-8
- **This app does:** minimal tracker; 3-habit free cap; widget as paid hook
- **User reaction:** mixed
- **Magnitude:** 45 reviews; mean 3.111; 536 public ratings at 4.52
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `13332648782`
- **Canonical:** C107 Widget variants and customisation as the paid layer; C278 Do not name the app after an established competitor — a name collision makes the product 'the fake one' before it is tried, and the cost cannot be measured from reviews

## Anti-patterns

### R62-007 — The 3-habit free tier is the most-named product boundary and it is costing 5★ reviewers: 4 of 45 (8.89%, high-priority, mean 2.75) name the 3-habit limit and all four agree on the number — 'Just a small suggestion to add one time payment option or add at least one more free task as we already have 3 but having 4 as free will give edge to the app' (5★); 'Nice, but you can only enter 3 habits; it wants a membership for more' (3★); 'the free version only allows tracking 3 habits, which feels very limiting, so I ended up uninstalling' (2★ — paragraph one unqualified praise, paragraph two an uninstall); 'Only 3?????? You can only have 3 habits at a time this app is useless' (1★); ratings run 5★, 3★, 2★, 1★ — 'the cap is not a complaint from people who dislike the app; it is a wall that people walk into on their way out'; 3 free habits is below the use cases reviewers describe (water and steps, walking, three concurrent religious practices) — a realistic starter set is 4–6 habits, so the cap bites before the product has proved itself; spread evenly across 17 months in four storefronts and the reported limit never changes; M1: raise the free allowance from 3 to 5, or make the 4th habit a time-limited trial rather than a wall

- **Where:** §0.4; §3.4.2; §5.6; §7.4; §8.2 M1
- **This app does:** free tier capped at 3 habits
- **User reaction:** downgrade
- **Magnitude:** 4 (8.89%) at 2.75★; ratings 5/3/2/1
- **Direction for us:** dont · **Report confidence:** high confidence · **Generalisable:** generalisable
- **Review IDs:** `12547737504`, `12634608390`, `13610103490`, `14251077324`, `13680580523`, `14424678681`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R62-012 — Trust: a name collision and a scam accusation — 3 (6.67%, mean 1.00): 'If you are planning to get such app based on online review them do not download this app. This is fake and similar name app to the original one. The og has orange colour logo' (IN, 1★) — in-repo corroboration for the collision: this repository's folder 23 is Streaks by Crunchy Bagel Pty Ltd (app ID 963034692, com.streaksapp.streak, 7,270 reviews vs this app's 45), so a user searching 'Streaks' meets both — the app is 'losing on brand identity before the product is even tried'; the icon-colour detail could not be verified; 'Is this scam?' from a paying customer whose subscription did not unlock; 'Avoid until they fix these massive performance issues'; how much the collision costs in installs cannot be measured from review text

- **Where:** §0.8; §5.7; §8.4 #8
- **This app does:** named after an established competitor
- **User reaction:** 1★-burst
- **Magnitude:** 3 (6.67%) at 1.00★
- **Direction for us:** dont · **Report confidence:** single review + in-repo corroboration · **Generalisable:** generalisable
- **Review IDs:** `13682484600`, `12863807910`, `14131374072`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C278 Do not name the app after an established competitor — a name collision makes the product 'the fake one' before it is tried, and the cost cannot be measured from reviews

## Things not to do

### R62-021 — In-session upsell pop-ups cost a full star: 'Get one star for annoying me with pop-ups' (PL, 1★, titled 'Limited option' — counted under upsell pressure, a disclosed boundary call); M5: cut the in-session upsell pop-ups or cap their frequency — 'one review, but it cost a full star and it is a setting, not a build'

- **Where:** §3.4.2; §5.6; §8.2 M5
- **This app does:** upsell pop-ups during use
- **User reaction:** complaint
- **Magnitude:** 1 (2.22%) at 1★
- **Direction for us:** dont · **Report confidence:** single review · **Generalisable:** generalisable
- **Review IDs:** `13680580523`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R62-036 — What not to change: do not add features to the main screen (11 praise simplicity, zero ask for a busier default view — every §8.3 item opt-in); do not raise prices and do not cut them (three unprompted 'the price is fair' against two one-line objections — the lever is packaging); do not build ads (zero ad complaints; a calm minimalist app has more to lose than to gain); do not chase the 'accountability' positioning with social features (no review asks for sharing, friends, leaderboards or partners, none describes breaking a bad habit); do not remove back-dating (make it lockable)

- **Where:** §8.5
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** five keep rules
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14453647912`, `14134782126`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C010 Backfill missed days / edit start date; C064 Price level — where 'fair' turns into 'too expensive'; C131 No default-on social feed in a personal tool; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

## Things to do

### R62-032 — Immediate — the evidence is unambiguous (verbatim): # | Action | Evidence | Why now ; I1 | Make the premium entitlement work offline. Cache the receipt/entitlement locally; never re-paywall a verified purchaser because the network is unavailable | §5.4, 13314856744 (ec, 5★ *despite* the bug, calls it *"critical"*) | A habit app is used at times of poor connectivity by design. This converts paid customers into public fraud accusations. Single reviewer, but the mechanism is specific, reproducible and severe ; I2 | Audit the purchase-unlock path end to end, including the case where a subscription is charged but the app still behaves as free | §5.4, 12863807910 (br, 1★, *"I paid for subscription monthly but still not working. Is this scam?"*) | Two of six self-identified payers (§5.1) had an entitlement failure. That is the worst ratio in this report ; I3 | Add a regression gate on tap/hit-testing before release, plus a fast rollback path | §7.3 — 8 reviews, 6 storefronts, 39 hours, 40% of all 1★ reviews, including a blocked first-run (14136118921) | The regression is already fixed, but nothing in this corpus suggests a process change prevented the next one. The cost of one bad build here was ~0.32 stars on the app's entire written history ; I4 | Stop wiping the last week's progress on update. Treat habit history as migration-critical data with an integrity check on upgrade | §3.4.1 / §7.7, 14481733593 (kz, reproduced twice), 13330819055 (ua, total loss) | Promoted above its 4.44% share under the severe-data-loss rule. In a streak product, destroyed history destroys the only thing the user has accumulated ; I5 | Either make the Apple Health / fitness link work, or remove the claim | §3.5 row 7, 14435767351 (tr, 2★, *"it said it did"*) | Expectation mismatch is worse than an absent feature; it is also the cheapest of these five to resolve — I1 offline entitlement; I2 purchase-unlock audit; I3 tap / hit-testing regression gate and fast rollback; I4 stop wiping the last week's progress on update; I5 make the Health link work or remove the claim

- **Where:** §8.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** five immediate fixes
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13314856744`, `12863807910`, `14136118921`, `14481733593`, `13330819055`, `14435767351`
- **Canonical:** C021 Apple Health integration; C033 Restore purchase and entitlements must work immediately; C139 Cache entitlements locally — never block a paid surface on a live server check; C156 Content and event releases need a crash gate across device generations; C175 Updates must not break function or wipe progress

## Contradictions

### R62-038 — Contradictions the report carries rather than resolves: the dot / heat-map grid is the feature one user paid for and another credits with their first successful habit, and the feature a third calls 'a sea of dots' they cannot read; a one-time purchase is requested in Apr 2025 while a lifetime purchase is reported in Jun 2026 (probably added in between — a discoverability finding); a 5★ whose whole body is 'App doesn't work' and a 5★ reporting a critical entitlement bug sit in the 5★ band; 'reasonably priced' from a 1★ who did not buy; 'Great app but unfortunately unreliable' at 2★ — four rating/text contradictions (8.89%) kept in both the band and the theme

- **Where:** §0.9; §2.2; §1.6 #5; §4.2
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 4 contradictions (8.89%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** generalisable
- **Review IDs:** `13332648782`, `14394122206`, `13212775795`, `12547737504`, `14191010644`, `14136346335`, `13314856744`, `13742691466`, `14481733593`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C217 An unexplained metric reads as broken — explain the score on-screen

## Data caveats and method

### R62-002 — Signal bands (verbatim): Band | Label | Meaning ; < 0.1% | Ignore | Not promoted unless safety/legal/data-loss ; 0.1 – 0.5% | Weak signal | Recorded, cautious wording ; 0.5 – 1% | Emerging | Worth investigating ; 1 – 3% | Meaningful | Strong candidate ; 3 – 5% | Very strong | Should shape roadmap ; > 5% | High-priority | Strong problem or opportunity — warnings: n = 45 so one review = 2.22% and lands in 'Meaningful' automatically, three clear 'high-priority' — the raw count is the primary unit and the percentage decoration; treat every finding as a hypothesis with named witnesses; no storefront reaches 50 (Turkey 8, India 8); the written corpus is not the rating base — 45 written vs 536 public ratings (8.40%), written mean 3.111 vs public 4.52, a 1.41-star gap that is the normal written-review negativity skew, so the corpus describes what makes people write, not what makes people rate; no external store data could be fetched — prices, SKUs, free-tier limit, version history and feature list are reconstructed from review text; 17 of 45 (37.78%) not in English (7 Turkish, 6 Spanish, Italian, Russian, Arabic, Vietnamese), read in the original. Files (verbatim): File | Role | Records ; App Store Reviews/62. Streaks – Daily Habit Tracker - Atomic Goals & Accountability/reviews.jsonl | Authoritative corpus. Every finding derives from this file. | 45 ; by_country/*.jsonl (22 files) | Reconciliation only, never a separate source | 45 across 22 files ; manifest.json | App ID, developer, bundle ID, per-country counts, rating distribution, mean, extraction timestamp | — ; _state.json | Crawl completion per storefront, including the storefronts that returned zero reviews | 86 storefronts recorded ; Tools/habit_apps_ranked.json | The only store-level figures used: public rating counts/averages and storefront ranks. Repository data, not a live external source. | — || Reconciliation (verbatim): Check | Result ; Records in reviews.jsonl | 45 ; Records read individually, in original language | 45 (100%) ; Unique review_id values | 45 — no duplicates ; Exact duplicate title+body pairs | 0 — no deduplication was necessary or performed ; by_country/*.jsonl row total | 45 — exact match ; by_country ID set vs merged ID set | symmetric difference 0 ; Per-country counts vs manifest.json | all 22 match exactly ; Rating distribution vs manifest.json | 17/6/2/5/15 — exact match ; Mean rating | 140 ÷ 45 = 3.1111 vs manifest 3.111 ✓ ; Reviews assigned to ≥1 theme | 45 / 45 — zero unassigned ; Unknown IDs in the theme map | 0 ; Intra-theme duplicate IDs | 0 ; Review IDs cited in this report that exist in reviews.jsonl | all (verified in §9.4) — 13 fields, no nulls, HTML unescaped, no two reviews share an author; method: parsed and dumped, read every review in full in the original language (no classifier, hence no classifier error estimate), hand-built 61-theme map, validated (zero unknown IDs, duplicates, unassigned), aggregated by script, Part 10 index generated from data + map, external verification attempted and blocked

- **Where:** §How to read this table (verbatim); Seven warnings 1, 2, 4, 5, 6; §1.1 table (verbatim); §1.2; §1.3 table (verbatim); §1.5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 45/45 read (100%)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R62-003 — Limitations: 18% of the corpus is one bug over 39 hours — eight reviews (17.78%) between 04:33 UTC 1 Jun and 19:16 UTC 2 Jun 2026 pull the mean down 0.32 (3.111 with, 3.432 without), both figures given where it matters; four reviews contradict their own star (8.89%) including a 5★ whose entire body is 'App doesn't work' and a 5★ reporting a critical entitlement bug — counted in both the band and the theme, disclosed not corrected because the star is what the store shows; engagement fields carry no signal (4 helpful votes, one is_edited); burst disclosure both directions — the June cluster is a defect burst (eight authors, six storefronts, no shared phrasing) and August 2026 (9 reviews, mean 4.00, 22 days, 7 storefronts, ratings 5,5,5,4,5,2,4,4,2) is not consistent with a solicited burst but a prompt cannot be excluded — flagged, not claimed; two reviews are not product feedback (a pre-purchase pricing question and a defect report, both 5★, both inflate the Saudi mean to 5.00). Month table (verbatim): Month | n | Mean | Month | n | Mean ; 2025-04 | 2 | 5.00 | 2026-01 | 4 | 2.00 ; 2025-05 | 1 | 3.00 | 2026-02 | 2 | 3.00 ; 2025-07 | 1 | 1.00 | 2026-04 | 3 | 3.00 ; 2025-10 | 4 | 3.00 | 2026-05 | 1 | 2.00 ; 2025-11 | 3 | 4.67 | 2026-06 | 10 | 2.20 ; |  |  | 2026-07 | 4 | 3.00 ; |  |  | 2026-08 | 9 | 4.00 ; |  |  | 2026-09 | 1 | 5.00 — 24 of 45 (53.33%) from Jun–Sep 2026, six months with no reviews; the corpus is strongly back-weighted

- **Where:** Seven warnings 3, 7; §1.6; §1.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** burst 8 (17.78%); contradictions 4 (8.89%)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** generalisable
- **Review IDs:** `14136346335`, `13314856744`, `14481733593`, `14129863718`, `14396613983`, `14191010644`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R62-026 — Five stars (17) — composition (verbatim): Why they gave 5★ | n | IDs ; Simplicity / minimalism | 7 | 12510217982, 13332648782, 13354961662, 13366854737, 13759855538, 13926027561, 14288307273 (plus 12547737504, which praises UI/UX rather than simplicity) ; Low-information praise ("Good", "👍🏻", "Excelente") | 7 | 12510217982, 13366854737, 14212735361, 14280213491, 14288307273, 14415660670, 14503535367 ; A concrete outcome they achieved | 4 | 14394122206, 14424678681, 14503535367, 14415660670 ; Widget / progress visualisation | 2 | 13332648782, 14394122206 (a third, 14421182094, sits in the 4★ band) ; Price is good | 2 | 13759855538, 13926027561 ; 5★ that are not actually praise | 3 | 14136346335 (*"App doesn't work"*), 14396613983 (a pricing question), 13314856744 (reports a critical entitlement bug) — three of the 17 (17.6% of the band) do not endorse the product: 'App doesn't work', a pricing question, a critical entitlement bug report; 'the public 5★ count overstates satisfaction by roughly that much'; two 5★ carry negatives that cost nothing to fix (a 4th free habit and a one-time SKU; the offline entitlement check)

- **Where:** §4.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 3 of 17 5★ not praise
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14136346335`, `14396613983`, `13314856744`, `12547737504`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R62-035 — Research questions the corpus cannot answer: (1) does a lifetime SKU exist today and is it discoverable; (2) what are the actual prices ('$10'; '34 and 59' in an unstated currency); (3) is the free limit still 3 habits (four reviewers over 17 months all say 3, most recent Jul 2026); (4) does the listing promise Apple Health integration; (5) does an Apple Watch app exist; (6) what caused the Jun 2026 regression and what shipped on 1 Jun (symptom window known to the minute, no version numbers); (7) is the Aug 2026 volume increase growth or a review prompt; (8) how much the 'Streaks' name collision costs in installs; (9) why 64 of 86 recorded storefronts have zero written reviews

- **Where:** §8.4 part 8 #1, part 8 #2, part 8 #3, part 8 #4, part 8 #5, part 8 #6, part 8 #7, part 8 #8, part 8 #9
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** nine open questions
- **Direction for us:** none · **Report confidence:** research question · **Generalisable:** generalisable
- **Canonical:** C003 Lead with a one-time lifetime purchase; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C278 Do not name the app after an established competitor — a name collision makes the product 'the fake one' before it is tried, and the cost cannot be measured from reviews
