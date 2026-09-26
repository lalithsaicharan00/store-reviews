# Cards — report 54

Source: `App Store Reports/54. Avocation - Habit Tracker - Daily planner & ADHD organizer (REPORT).md`  
124 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 5
- [Must-haves](#must-haves) — 4
- [Must never break](#must-never-break) — 12
- [Features](#features) — 20
- [Monetization](#monetization) — 16
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 14
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 16
- [Dated events and trends](#dated-events-and-trends) — 12
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 4
- [Things not to do](#things-not-to-do) — 1
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 11

## Product rules

### R54-015 — The 'no streaks, no shame' design is a genuine differentiator and under-exploited: 12 (3.25%, very strong, mean 4.75) praise the deliberate absence of streaks and punishment — 'the first habit tracking app I have stuck with, most likely because it does not track streaks (which my black and white brain reads as failure if I am not perfect) … I work in mental health and I appreciate the compassion… I am not broken' (US, 5★); 'I have adhd and using streaks has always resulted in beating myself up at the end of the week'; 'Fear-based, don't break the chain or streak methods never worked for me'; one downloaded because a review said it doesn't track streaks; against that 7 (1.90%) ask for streaks or a calendar of dots — 'do not add streaks. Add the evidence of consistency people are actually asking for (history, per-habit records) without the punishment semantics — the two are separable and the corpus proves users distinguish them'

- **Where:** Executive summary 7; §3.3.3
- **This app does:** no streaks by design
- **User reaction:** praise
- **Magnitude:** 12 (3.25%, 4.75); streak requests 7 (1.90%)
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `6534235105`, `8266460563`, `6458113686`, `7597717527`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R54-035 — Simplicity and restraint 60 (16.26%, high-priority, mean 4.50), defined negatively — 'Unlike some other apps which include too many unnecessary settings, this app has just what you need' (ES); 'Other apps feel overwhelming… cluttered with lists, graphs, and other features that can be anxiety producing. Avocation is minimalist, without being boring' (US); 'they're too complex and… get you to overcommit and overachieve' (DE) — 'this is the constraint on every feature request': 60 praise the absence of features while 58 request platform features and 44 habit-modelling features; anything shipped must not be visible to the 60

- **Where:** §3.3.2
- **This app does:** minimal feature set
- **User reaction:** praise
- **Magnitude:** 60 (16.26%, 4.50) vs 58 + 44 requesters
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `9624026814`, `5839377039`, `12549329908`, `8150960736`, `8198366622`, `10851094567`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R54-111 — F4: reconcile the paid tier's copy with its contents — build the 'Advanced Statistics' or delete the claim; a one-day copy change that removes the corpus's angriest single grievance (12 value-gap reviews, 2.58, 10 payers, 3 quote the phrase)

- **Where:** §8.1 F4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 12 (2.58); 10 payers
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `12680052718`, `9622751603`, `10904975030`, `9633840491`
- **Canonical:** C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R54-117 — D4: build the consistency record for the 48 (13.01%) — pick one habit and see how consistently it was done over months; not streaks-with-punishment (12 chose the product because it refuses streaks); 'the evidence of consistency and the punishment for breaking it are separable, and this user base wants the first without the second' — colour-density calendars, per-habit completion counts and monthly totals deliver it; a streak counter with a reset does not

- **Where:** §8.2 D4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 48 (13.01%, 3.83)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `10209487543`, `7597717527`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R54-122 — What not to change: do not add streaks with penalties (12 chose the product for their absence; ship the consistency record instead); do not add features that are visible (60 praise restraint; everything in §8.2 must ship without the home screen getting busier); do not redesign (128 praise the design and no 1★ criticises it — the moat); do not move to a subscription (14 advocates at 4.93, zero detractors of the model as opposed to the price); do not remove the plant (35 motivated; fix it and extend it with a garden or shelf, 9 requests)

- **Where:** §8.5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 12 / 60 / 128 / 14 / 35
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `7597717527`, `9624026814`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C006 Stay minimal — every addition is opt-in or off by default; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C273 The reward mechanic must never silently stall — a plant, pet or garden that stops growing reads as the app taking the reward away

## Must-haves

### R54-049 — iCloud sync / backup / cross-device 8 (2.17%, meaningful, 4.12) — 'I don't give it 5 stars because it lacks iCloud sync' (ES); 'lack of backup' (GB)

- **Where:** §3.4 #11
- **This app does:** absent: sync and backup
- **User reaction:** complaint
- **Magnitude:** 8 (2.17%, 4.12)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `10946192676`, `9597316193`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C153 Automatic cloud backup on by default — never manual opt-in

### R54-061 — onboarding_confusion 10 (2.71%, meaningful, mean 3.70) — three mechanics unexplained: the water jar ('I haven't figured out how my water goes up, it didn't give me instructions'), repotting ('I don't know what repot your plant means… Will it restart all my progress?'), adding a second habit ('I got lost about where to go to add more', BR); one asks directly for a tutorial

- **Where:** §3.5.5 onboarding
- **This app does:** unexplained mechanics
- **User reaction:** complaint
- **Magnitude:** 10 (2.71%, 3.70)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `7870742641`, `9195522591`, `10209487543`, `7227126878`, `10112849044`
- **Canonical:** C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R54-062 — accessibility_issues 3 (0.81%, emerging, mean 3.67): a detailed VoiceOver report — 'not accessible for blind and visually impaired people… many fields and buttons, and some text, are unreadable under VoiceOver' (DE, 1★, offering to re-review once fixed); Dynamic Type text cut off ('the words didn't fit within the boxes… due to settings I have in place', US, 5★); light sensitivity driving the dark-mode request — below 1% but flagged under the standing accessibility exception and cheap to fix

- **Where:** §3.5.5 accessibility
- **This app does:** VoiceOver, Dynamic Type broken
- **User reaction:** complaint
- **Magnitude:** 3 (0.81%, 3.67)
- **Direction for us:** must-have · **Report confidence:** emerging (accessibility exception) · **Generalisable:** generalisable
- **Review IDs:** `7967680944`, `5896104170`, `9074539295`
- **Canonical:** C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R54-112 — F5: restore a working support channel and say so in the listing — 6 reviewers, mean 1.50; five of six were solvable by a reply; 'there's no app support to write any of this to… which I feel like should be a thing if you have to pay for an app'

- **Where:** §8.1 F5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 6 (1.50)
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14383965056`, `10209487543`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

## Must never break

### R54-011 — Post-purchase failure is the most damaging thing in the corpus and nearly invisible in aggregate: 12 reviewers (3.25%, very strong) report a completed purchase did not work, mean 1.083 — the lowest of any theme; Pro never unlocks 6 (1.63%, mean 1.17) and Pro cannot be restored after reinstall or device change 7 (1.90%, mean 1.000 — all seven one-star), across seven storefronts and six years (2021→2026): 'I paid for the app and absolutely nothing. It's exactly as it was before' (AU); 'I bought the NT$490 permanent unlock and it doesn't work at all and they won't refund — this is simply fraud' (TW); 'I bought Lifetime Membership for ฿399 … after deleting and reinstalling, the Lifetime membership does not work' (TH, quoting an order ID); 5 (1.36%) ask for a refund in the body, all one-star — 'for a one-time-purchase product, restore-purchases is not a feature, it is the product's warranty'

- **Where:** Executive summary 3; §3.5.3
- **This app does:** lifetime Pro fails to unlock or restore
- **User reaction:** 1★-burst
- **Magnitude:** 12 (3.25%, 1.083); never unlocks 6 (1.17); restore 7 (1.000); refund 5
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `9025109463`, `6759577812`, `12201812878`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R54-016 — The plant is the emotional engine and when it breaks the product stops working: 59 (15.99%, high-priority) discuss the plant — 35 (9.49%) motivated by it, 10 (2.71%) find it underwhelming, 5 (1.36%) report it stuck or dead, 9 (2.44%) want a collection or garden, 9 (2.44%) want more game; 'Growing my plant has 100% been the thing that has kept me on track' (US, 5★); when it stalls: 'my plant says infinity days until next growth … It makes me want to stop using the app, since the little reward of growing the plant has been taken away' (US, 3★, payer); 'the plant stopped growing after 67 days of watering — why is there this strange limit?' (ES); 'Sadly the plant's growth doesn't continue … even though I bought the Pro version' (DE, 1★, the most recent German review) — 'infinity days until next growth' appears in three reviews across three storefronts: the highest-leverage bug in the report

- **Where:** Executive summary 8; §3.3.3
- **This app does:** plant growth stalls ('infinity days until next growth')
- **User reaction:** churn
- **Magnitude:** 59 (15.99%); motivated 35 (9.49%); stuck 5 (1.36%)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `5839377039`, `8956070679`, `10138813839`, `14161103908`, `10078139554`, `7793589747`
- **Canonical:** C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users; C273 The reward mechanic must never silently stall — a plant, pet or garden that stops growing reads as the app taking the reward away

### R54-055 — Reliability 31 unique (8.40%, high-priority, mean 2.677) (verbatim): bug_calendar_stats_wrong 9 (2.44%, 2.56, 2022-07 → 2024-12); bug_notifications 6 (1.63%, 2.50); bug_plant_not_growing 5 (1.36%, 2.40, 2021-09 → 2026-06); bug_crash_lag 3 (0.81%, 3.00); bug_data_loss 3 (0.81%, 2.33, 2020-12 → 2026-08); bug_water_tracker 2; bug_layout_text 2; bug_habit_creation 1; bug_timezone 1

- **Where:** §3.5.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Bug theme | n | % of 369 | Signal | Mean ★ | Window ; bug_calendar_stats_wrong | 9 | 2.44% | meaningful | 2.56 | 2022-07-22 → 2024-12-28 ; bug_notifications | 6 | 1.63% | meaningful | 2.50 | 2020-12-09 → 2023-08-10 ; bug_plant_not_growing | 5 | 1.36% | meaningful | 2.40 | 2021-09-11 → 2026-06-09 ; bug_crash_lag | 3 | 0.81% | emerging | 3.00 | 2020-07-17 → 2022-02-05 ; bug_data_loss | 3 | 0.81% | emerging | 2.33 | 2020-12-19 → 2026-08-03 ; bug_water_tracker | 2 | 0.54% | emerging | 3.00 | 2020-05-20 → 2020-08-13 ; bug_layout_text | 2 | 0.54% | emerging | 4.50 | 2020-05-03 → 2024-02-03 ; bug_habit_creation | 1 | 0.27% | weak | 2.00 | 2024-03-22 ; bug_timezone | 1 | 0.27% | weak | 3.00 | 2023-02-23
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-056 — The calendar/statistics defect is the most-reported bug and strikes the paid surface — five of nine reporters are payers: 'The calendar feature just spins and does not pull in any data. Paid $9.99 to see if that would make it work but it didn't' (US, 1★); 'the advanced statistic calendar hasn't been working… the statistics and the filters and the amount that the circles get filled in on the calendar are all wrong' (US, 5★ — a five-star review containing a paid-feature defect); 'although I had done 3/4 of my habits, only a 1/4 of my ring closed' (US, 2★); 'If I undo a habit's progress (long press), it isn't undone in the calendar view' (DE, 2★) — two reporters independently connect the corruption to the undo gesture, 'a reproducible defect hypothesis handed to the developer for free by two users on two continents'

- **Where:** §3.5.2 calendar defect
- **This app does:** paid calendar spins or shows wrong rings; undo not propagated
- **User reaction:** 1★-burst
- **Magnitude:** 9 (2.44%, 2.56); 5 payers
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `9104887436`, `8986983542`, `10209487543`, `12115176508`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R54-057 — The plant-stall defect has a signature string: 'my plant says infinity days until next growth' (US, 3★) and 'Says infinite days until new growth. Does this mean my tree is dead?' (ZA, 3★), seven weeks apart, plus three more reports of growth stopping (US; ES at 67 days; DE 2026) — all five at 3★ or below, three confirmed payers

- **Where:** §3.5.2 plant stall string
- **This app does:** reward mechanic stalls permanently
- **User reaction:** churn
- **Magnitude:** 5 (1.36%, 2.40); 3 payers
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8956070679`, `10078139554`, `7793589747`, `10138813839`, `14161103908`
- **Canonical:** C273 The reward mechanic must never silently stall — a plant, pet or garden that stops growing reads as the app taking the reward away

### R54-058 — Post-purchase failure evidence: purchase_not_unlocked 6 (1.63%, 1.17) — KR 2020 ('Still telling me Become a habit pro!'), AU 2022, TW 2020, US 2021, US 2023 ('the app never acknowledged the payment; putting in a help ticket went unanswered'), DE 2026; restore_purchase_failure 7 (1.90%, 1.000, every one 1★) — BR 2023 changed phone, ES 2023 bought on Google Play and must rebuy on App Store, GR 2026, TH 2025, UA 2021, UA 2024 changed phone, US 2021; refund_request 5 (1.36%, 1.000) — GR, KR, TH, TW, US; restore failures P1 0.9% → P2 0.7% → P3 4.2%, a five-fold rise, the two most recent also reporting support unreachable — 'not a legacy problem being fixed. It is getting worse while the support channel closes'

- **Where:** §3.5.3
- **This app does:** Pro unlock and restore broken
- **User reaction:** 1★-burst
- **Magnitude:** not unlocked 6; restore 7 (P3 4.2%); refund 5
- **Direction for us:** must-never-break · **Report confidence:** very strong (union) · **Generalisable:** generalisable
- **Review IDs:** `5481306690`, `9025109463`, `6759577812`, `7253435778`, `9633840491`, `14161103908`, `10370795766`, `10684528679`, `14383965056`, `12201812878`, `7866822037`, `11201859512`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R54-070 — 1★ (n=31): 'the dominant cause of a one-star review is not the paywall — it is a payment that did not work' (verbatim table: paid_confirmed 12 38.7%; restore_purchase_failure 7 22.6%; free_habit_limit 6 19.4%; purchase_not_unlocked 5; free_version_useless 5; refund_request 5 16.1%; price / abandonment / support 3 each; low-info, calendar bug, notifications 2 each) — of the 12 payers, 7 could not restore, 5 never had it unlock, 5 asked for a refund; only 6 of 31 are 'I won't pay'; two attach payment evidence (an order ID; NT$490) and two accuse the developer of fraud or theft — every one 'the most expensive possible outcome of a sale'

- **Where:** §4.5 table (verbatim) and reading
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of 31 ; paid_confirmed | 12 | 38.7% ; restore_purchase_failure | 7 | 22.6% ; free_habit_limit_complaint | 6 | 19.4% ; purchase_not_unlocked | 5 | 16.1% ; free_version_useless | 5 | 16.1% ; refund_request | 5 | 16.1% ; price_too_high / abandonment_no_updates / support_unresponsive | 3 each | 9.7% each ; low_information_negative / bug_calendar_stats_wrong / bug_notifications | 2 each | 6.5% each
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `12201812878`, `6759577812`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R54-081 — Refund and churn drivers among payers: 5 refund requests (1.36% global, 11.4% of payers, all 1★) — every one caused by a failed entitlement, not dissatisfaction with the feature set (GR purchase lost after reinstall + support down; KR never unlocked; TH lifetime lost after reinstall; TW lifetime unusable; US won't add habits and won't restore); payer churn — plant stalled ('It makes me want to stop using the app'), lost access on phone change (BR), could not migrate progress (UA), Pro features stopped working and developer unreachable (DE) — 'engineering problems with known solutions, and the affected users repeatedly say they want to keep using the product'

- **Where:** §5.5
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 5 refunds (11.4% of payers)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `14383965056`, `5481306690`, `12201812878`, `6759577812`, `7253435778`, `8956070679`, `10370795766`, `11201859512`, `14161103908`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R54-091 — Reminder defects (GB): no badge, nagging after the habit is completed, wrong sound — bug_notifications 6 (1.63%, mean 2.50, 2020-12 → 2023-08)

- **Where:** §6.4 reminder defects
- **This app does:** notifications defective
- **User reaction:** complaint
- **Magnitude:** 6 (1.63%, 2.50)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8306365770`
- **Canonical:** C039 Reminders fire reliably, once

### R54-108 — F1: fix restore-purchases and make it a visible, labelled button — the single largest source of one-star reviews (38.7% of the 1★ bucket are payers); oldest Feb 2020, newest Aug 2026 — 6½ years unresolved; every instance a completed sale converted into a public accusation, two use the word fraud

- **Where:** §8.1 F1
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 12 (1.083); 7 restore all 1★; 5 refunds all 1★
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `5481306690`, `14383965056`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R54-109 — F2: fix the plant 'infinity days until next growth' state — 5 reviewers, mean 2.40, 3 payers; the plant is the motivation engine (35); two users report the identical string, one growth stopping at exactly 67 days

- **Where:** §8.1 F2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 5 (2.40)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `8956070679`, `10078139554`, `7793589747`, `10138813839`, `14161103908`
- **Canonical:** C273 The reward mechanic must never silently stall — a plant, pet or garden that stops growing reads as the app taking the reward away

### R54-110 — F3: fix the calendar/statistics data corruption and start with the undo gesture — two reviewers on two continents hypothesise the same cause ('It might have happened because I undid a habit'; undo not reflected in the calendar); 9 reviewers, mean 2.56, 5 payers, on the paid surface

- **Where:** §8.1 F3
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 9 (2.56); 5 payers
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `8986983542`, `12115176508`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

## Features

### R54-014 — Widgets are the most-requested missing capability and demand is accelerating: 41 reviewers (11.11%, high-priority, mean 4.29) ask for a home- or lock-screen widget, P1 7.5% → P2 8.3% → P3 17.6% — the steepest rise of any theme; framed as retention, not nicety — 'with my adhd, once it's closed i never use it and the reminders are too easy to ignore' (CA); 'NEED a widget option! i forget to click the app if i can't see it. i'm autistic' (GB); 'the ones that have stuck with me are the ones that show my streak/progress on a widget' (PH); and it blocks revenue — 5 (1.36%) say a missing capability stops them buying, 3 of 5 name the widget ('I'm not sure to buy… since I've noticed this app doesn't have a widget', CO; 'If there were a home-screen widget I'd open it far more often — then I'd be more willing to buy', TW); asked for since October 2020

- **Where:** Executive summary 6; §3.4
- **This app does:** absent: widget
- **User reaction:** blocked-conversion
- **Magnitude:** 41 (11.11%, 4.29); P1 7.5% → P2 8.3% → P3 17.6%; 3 of 5 purchase blockers
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `8214584771`, `10104424067`, `11512811846`, `10307040667`, `8179279036`, `6534928843`
- **Canonical:** C023 Interactive widget check-off; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R54-017 — Habits that are not daily cannot be modelled — the largest functional gap after the paywall: 24 (6.50%, high-priority, mean 3.79) need a frequency the app cannot express, 'X times a week without naming the days' dominating — 'I'd like to work out 3 days a week. I don't care or know when those days will be but this app makes you designate them … making This app unusable for me' (US, 4★); 'Because my job and shifts differ every day… the app is unfortunately unusable for me' (DE, 3★); 15 (4.07%) cannot backfill a missed day — 'deleted on the second day because of the issue' (UA, 2★); 37 unique between them (10.03%) — two reviewers call a scheduling model 'unusable', converting satisfied users into churn

- **Where:** Executive summary 9; §3.4
- **This app does:** fixed weekdays only; backfill only yesterday
- **User reaction:** churn
- **Magnitude:** frequency 24 (6.50%, 3.79); backfill 15 (4.07%); union 37 (10.03%)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `9511531312`, `6407176617`, `10955907409`
- **Canonical:** C010 Backfill missed days / edit start date; C043 Flexible / custom frequency

### R54-021 — Feature inventory derived from reviews (verbatim): habit list as coloured circles/bubbles, not rows (praised as the reason for adoption); time-of-day grouping morning / afternoon / evening / any time (10, 2.71%, named as a differentiator); growing plant / tree watered by completing habits, repotting, multiple pot designs (59); avocado mascot 'Sr. avocato' with facial expressions (9); no streaks, no punishment for a missed day (12); water-intake jar (7 praise, 2 broken, 3 couldn't work out how it fills); habit-science lessons / articles (15 praise, English-only); reminders multiple per habit (8 praise; multiple reminders appear Pro-gated); weekly bar chart and a calendar with progress rings (the ceiling of the insight surface); custom name, colour, icon, weekdays, time of day, times-per-day ('creative freedom'); iPhone only (7 report no iPad/Mac); German UI ('the only habit tracker in German')

- **Where:** §2.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Capability | Evidence it exists | Representative IDs ; Habit list rendered as coloured circles/bubbles, not rows | Praised explicitly as the reason for adoption | 9195522591, 5839377039 ; Time-of-day grouping — morning / afternoon (midday) / evening / any time | 10 reviewers (2.71%) name it as a differentiator | 6290688308, 8416681749, 9289083496, 6842229487 ; Growing plant / tree, watered by completing habits; repotting; multiple pot designs | Core mechanic, 59 reviewers discuss it | 8528259165, 5839377039, 10209487543 ; Avocado mascot ("Sr. avocato") with facial expressions | 9 reviewers name the character | 7388700617, 6914153469, 8518969458 ; No streaks, no punishment for a missed day | Stated as deliberate design by 12 reviewers | 6534235105, 8266460563, 9289083496 ; Water intake tracker (a jar that fills) | 7 reviewers praise it; 2 report it broken; 3 could not work out how it fills | 9305249528, 6313715961, 7870742641 ; Habit-science lessons / articles | 15 reviewers praise them; content described as English-only | 6842651950, 8929450936, 10801492320 ; Reminders / notifications, multiple per habit, per-time-of-day | 8 praise; multiple reminders appear to be Pro-gated | 8324458354, 8715445509, 8924643400 ; Weekly review / bar chart, and a calendar with progress rings | Named as the ceiling of the current insight surface | 8311227875, 9622751603, 10209487543 ; Custom habit name, colour, icon, weekdays, time of day, times-per-day | Named explicitly as "creative freedom" | 8896732201, 9195522591 ; iPhone only | 7 reviewers report no iPad/tablet/Mac support | 7079498863, 9287226781, 10896516639 ; German UI (at least) | One reviewer calls it "the only habit tracker in German" | 8518969458
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `9195522591`, `5839377039`, `6290688308`, `8528259165`, `7388700617`, `6534235105`, `9305249528`, `6842651950`, `8324458354`, `8311227875`, `8896732201`, `7079498863`, `8518969458`
- **Canonical:** — (nuance register)

### R54-022 — Capabilities established as absent by repeated first-hand report: home/lock-screen widget (41, 2020-10 → 2026-05), Apple Watch app (9), iPad/Mac app (7), dark mode (5), iCloud/cross-device sync or backup (8), 'X times per week' frequency (24), backfilling a day older than yesterday (15), habit reordering (13), long-range or per-habit statistics (28 + 16), quit-a-bad-habit tracking (4), Health-app or Fitbit integration (2), notes/journal per habit (3), Arabic or full Chinese localisation (3)

- **Where:** §2.1 capabilities that do NOT exist
- **This app does:** absent: widget, Watch, iPad/Mac, dark mode, sync, frequency, backfill, reorder, stats, quit, Health, notes, some localisation
- **User reaction:** complaint
- **Magnitude:** as listed
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-023 — Time-of-day grouping (morning / afternoon / evening / any time) named as a differentiator by 10 (2.71%)

- **Where:** §2.1 time-of-day grouping
- **This app does:** free: time-of-day sections
- **User reaction:** praise
- **Magnitude:** 10 (2.71%)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `6290688308`, `8416681749`, `9289083496`, `6842229487`
- **Canonical:** C053 Custom time-of-day segments

### R54-024 — Habit-science lessons / articles praised by 15 (4.07%), content described as English-only

- **Where:** §2.1 lessons row
- **This app does:** free: in-app habit lessons (English only)
- **User reaction:** praise
- **Magnitude:** 15 praise
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `6842651950`, `8929450936`, `10801492320`
- **Canonical:** C027 Localise early — it unlocks revenue; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R54-025 — Water-intake tracker (a jar that fills): 7 praise, 2 report it broken, 3 could not work out how it fills

- **Where:** §2.1 water tracker row
- **This app does:** free: water jar
- **User reaction:** mixed
- **Magnitude:** 7 / 2 / 3
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `9305249528`, `6313715961`, `7870742641`
- **Canonical:** — (nuance register)

### R54-036 — plant_growth_motivation 35 (9.49%, high-priority, mean 4.43): 'the idea that completing a task will grow a virtual plant is so motivating. No other task/habit app has that'; 'As you complete habits, you water a plant that grows into a tree. What a beautiful, creative, and almost poetic concept'; 'excited for the little plant's next growth' (AT) — praised by 35 and criticised by 15 (underwhelming 10 + not growing 5): 'a mechanic that carries this much emotional weight cannot be allowed to silently stop'

- **Where:** §3.3.3 plant
- **This app does:** free: plant grows as habits are completed
- **User reaction:** praise
- **Magnitude:** 35 (9.49%, 4.43); criticised 15
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `5839377039`, `8528259165`, `9792081107`
- **Canonical:** C117 Mascot / companion character; C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R54-037 — avocado_mascot 9 (2.44%, meaningful, mean 4.78): 'the little avocado characters really motivate me' (GB); 'the avocado with the face and the loving drawings are really adorable' (DE); 'I love avacation because I love avacados' (CA)

- **Where:** §3.3.3 avocado
- **This app does:** mascot character
- **User reaction:** praise
- **Magnitude:** 9 (2.44%, 4.78)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `5817310051`, `8518969458`, `10012226525`
- **Canonical:** C117 Mascot / companion character

### R54-042 — Unmet needs ranked (verbatim): widget 41 (11.11%, 4.29, 2020-10-14 → 2026-05-27); longer-range history / monthly / yearly stats 28 (7.59%, 3.96); X times per week 24 (6.50%, 3.79); more icons / colours / pots / themes 17 (4.61%, 4.35); per-habit statistics 16 (4.34%, 4.19); backfill a missed past day 15 (4.07%, 3.67); reorder / drag 13 (3.52%, 4.54); Apple Watch 9 (2.44%, 4.22); more plants / garden / collection 9 (2.44%, 4.33); more gamification / richer plant behaviour 9 (2.44%, 4.33); iCloud sync / backup 8 (2.17%, 4.12); more / flexible reminders 8 (2.17%, 3.62); iPad / Mac 7 (1.90%, 4.57); streaks or calendar of dots 7 (1.90%, 4.00); dark mode 5 (1.36%, 4.40); more / updated lessons 6 (1.63%, 3.83); quit tracking 4 (1.08%, 4.00); undo / uncheck 3 (0.81%, 3.00); notes per habit 3 (0.81%, 4.67); Arabic / full Chinese 3 (0.81%); Health / Fitbit, units, in-app timer 2 each; one-time tasks, screenshot sharing 1 each

- **Where:** §3.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Rank | Request | n | % of 369 | Signal | Mean ★ | First asked | Last asked ; 1 | Home/lock-screen widget | 41 | 11.11% | high-priority | 4.29 | 2020-10-14 | 2026-05-27 ; 2 | Longer-range history / monthly / yearly stats | 28 | 7.59% | high-priority | 3.96 | 2020-04-02 | 2026-03-05 ; 3 | "X times per week" / flexible frequency | 24 | 6.50% | high-priority | 3.79 | 2020-08-28 | 2024-12-29 ; 4 | More icons / colours / pots / themes | 17 | 4.61% | very strong | 4.35 | 2020-04-20 | 2026-08-19 ; 5 | Per-habit statistics / individual habit history | 16 | 4.34% | very strong | 4.19 | 2020-04-02 | 2024-02-02 ; 6 | Backfill a missed past day | 15 | 4.07% | very strong | 3.67 | 2020-04-20 | 2024-02-19 ; 7 | Reorder / drag habits | 13 | 3.52% | very strong | 4.54 | 2020-11-27 | 2023-11-21 ; 8 | Apple Watch app | 9 | 2.44% | meaningful | 4.22 | 2020-07-18 | 2023-08-05 ; 9 | More plants / a garden or shelf / collection | 9 | 2.44% | meaningful | 4.33 | 2021-07-10 | 2026-03-23 ; 10 | More gamification / richer plant behaviour | 9 | 2.44% | meaningful | 4.33 | 2020-04-07 | 2025-07-12 ; 11 | iCloud sync / backup / cross-device | 8 | 2.17% | meaningful | 4.12 | 2021-07-20 | 2025-02-25 ; 12 | More / more flexible reminders | 8 | 2.17% | meaningful | 3.62 | 2020-07-12 | 2024-02-22 ; 13 | iPad / Mac / tablet app | 7 | 1.90% | meaningful | 4.57 | 2021-03-08 | 2025-02-25 ; 14 | Streaks or a calendar of completion dots | 7 | 1.90% | meaningful | 4.00 | 2020-04-20 | 2024-07-20 ; 15 | Dark mode | 5 | 1.36% | meaningful | 4.40 | 2022-06-24 | 2025-02-25 ; 16 | More / updated lessons | 6 | 1.63% | meaningful | 3.83 | 2020-07-17 | 2024-01-09 ; 17 | Track habits to quit (negative habits) | 4 | 1.08% | meaningful | 4.00 | 2020-08-29 | 2024-06-24 ; 18 | Undo / uncheck a habit | 3 | 0.81% | emerging | 3.00 | 2020-08-29 | 2024-12-28 ; 19 | Notes / journal per habit | 3 | 0.81% | emerging | 4.67 | 2022-06-02 | 2025-07-17 ; 20 | Arabic / full Chinese localisation | 3 | 0.81% | emerging | 4.00 | 2021-03-31 | 2023-06-03 ; 21 | Health app / Fitbit sync · units (ml, minutes) · in-app timer | 2 each | 0.54% | emerging | 5.00 / 4.00 / 3.50 | 2020-04-20 | 2023-12-14 ; 22 | One-time (non-recurring) tasks · sharing a screenshot | 1 each | 0.27% | weak | 4.00 | 2021-03-29 | 2022-10-26
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-044 — Requests 2, 5, 6 and 14 are one need wearing four hats: req_history_stats 28 + req_per_habit_stats 16 + req_streaks_calendar 7 + stats_too_basic 8 = 48 unique reviewers (13.01%, high-priority, mean 3.83) who want proof that they have been consistent, over a period longer than a week, for a habit they can name — the second-largest product need after the paywall, ahead of the widget: 'It's a bit difficult to see if you are making great progress… when there's only a weekly review' (CA); 'important when you want to look back and enjoy the successes of the last weeks or months' (DE); 'look back on progress…. That seems to be a major point of tracking, right?' (US, 2★)

- **Where:** §3.4 observation (b)
- **This app does:** weekly bar chart and calendar only
- **User reaction:** complaint
- **Magnitude:** 48 unique (13.01%, 3.83)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `8311227875`, `6370677225`, `10209487543`
- **Canonical:** C011 Weekly / monthly / yearly reports; C012 Week / month / year grid views; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R54-045 — More icons / colours / pots / themes 17 (4.61%, very strong, mean 4.35, 2020-04 → 2026-08)

- **Where:** §3.4 #4
- **This app does:** cosmetics partly Pro-gated
- **User reaction:** complaint
- **Magnitude:** 17 (4.61%, 4.35)
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** generalisable
- **Canonical:** C009 Basic widgets, icons and colours are free

### R54-046 — Reorder / drag habits 13 (3.52%, very strong, mean 4.54); 5 of 13 are payers (11.4% segment rate); 'not be able to rearranging the habits makes me give 4 star'

- **Where:** §3.4 #7
- **This app does:** absent: reordering
- **User reaction:** complaint
- **Magnitude:** 13 (3.52%, 4.54)
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `9597316193`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R54-047 — Apple Watch app 9 (2.44%, 4.22); iPad / Mac 7 (1.90%, 4.57); dark mode 5 (1.36%, 4.40) — all absent

- **Where:** §3.4 #8, #13, #15
- **This app does:** absent: Watch, iPad/Mac, dark mode
- **User reaction:** complaint
- **Magnitude:** 9 / 7 / 5
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C080 Colour themes / dark mode; C141 Native iPad layout

### R54-048 — More plants / a garden or shelf / collection 9 (2.44%, 4.33) and more gamification / richer plant behaviour 9 (2.44%, 4.33) — the reward loop needs more runway

- **Where:** §3.4 #9, #10
- **This app does:** one plant
- **User reaction:** complaint
- **Magnitude:** 9 + 9
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R54-050 — Smaller requests: more / flexible reminders 8 (2.17%, 3.62); more / updated lessons 6 (1.63%, 3.83); quit tracking 4 (1.08%); undo / uncheck 3 (0.81%, 3.00); notes per habit 3 (0.81%, 4.67); Arabic / full Chinese localisation 3; Health app / Fitbit, units (ml, minutes), in-app timer 2 each; one-time tasks, screenshot sharing 1 each

- **Where:** §3.4 #12, #16–#22
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** as listed
- **Direction for us:** research · **Report confidence:** meaningful–weak · **Generalisable:** generalisable
- **Canonical:** C019 Quit-habit / bad-habit mode; C021 Apple Health integration; C027 Localise early — it unlocks revenue; C172 Per-day / per-habit notes and journal text

### R54-067 — No way to adjust a habit's start date — named as the reason for 4 instead of 5 stars (US)

- **Where:** §4.2 start date
- **This app does:** absent: edit start date
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** build-free · **Report confidence:** band quote · **Generalisable:** generalisable
- **Review IDs:** `6066741542`
- **Canonical:** C010 Backfill missed days / edit start date

### R54-089 — plant_underwhelming 10 (2.71%) — half from Germany: the reward mechanic reads as thin to some adult users

- **Where:** §6.3 plant_underwhelming
- **This app does:** plant mechanic
- **User reaction:** complaint
- **Magnitude:** 10; DE 5
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `6281818718`, `6370677225`, `7994144814`, `9704771391`, `10904975030`
- **Canonical:** C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R54-116 — D3: ship a widget as a completion surface, not a display surface — 41 (11.11%), P1 7.5% → P3 17.6%, open since Oct 2020, 19 of 41 five-star, 3 of 5 purchase-blockers; users want to tap it ('being able to tap the widget to update/complete a habit') because the app is otherwise out of sight (ADHD, autism, forgetting the app exists) — a read-only widget solves discovery and misses logging

- **Where:** §8.2 D3
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 41 (11.11%); 19 five-star
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `12792214076`, `8214584771`, `10104424067`, `11512811846`
- **Canonical:** C023 Interactive widget check-off

### R54-118 — D5: let habits be non-daily — (a) a frequency type 'N times per week/month, any day'; (b) allow editing any past day, not just yesterday, arguably a bug (a UA user deleted the app on day two over it); they compound: if you can only schedule Mon/Wed/Thu and actually worked out Tuesday, you cannot record it at all (37 unique, 10.03%; two say 'unusable')

- **Where:** §8.2 D5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 37 unique (10.03%)
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `10955907409`, `8900579113`, `9511531312`, `6407176617`
- **Canonical:** C010 Backfill missed days / edit start date; C043 Flexible / custom frequency

## Monetization

### R54-010 — The 3-habit free cap is the most-discussed product decision and reads as a wall rather than a sample: 44 reviewers (11.92%, high-priority, mean 3.16) complain about the free habit limit, anger concentrated at the moment of collision — 'I was having fun setting up my habits until I maxed out my 3 free habits before being required to pay $15 … Deleted immediately' (US, 2★); 'Only three free habits — early to bed, early to rise, exercise, and all three are used up' (TW, 3★); 'Never imagined you could only list three habits. Deleted it straight away' (TW, 1★); a further 11 (2.98%, meaningful, mean 1.91) call the free tier useless ('A paid app disguised as free') — 'three habits is below the minimum viable habit set that users arrive with… The cap does not demonstrate the product; it terminates the trial'

- **Where:** Executive summary 2; §3.5.1
- **This app does:** free: 3 habits
- **User reaction:** blocked-conversion
- **Magnitude:** cap 44 (11.92%, 3.16); useless free tier 11 (2.98%, 1.91)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `6883715554`, `7892340081`, `7165608219`, `10579933045`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R54-019 — The one-time purchase model is a real asset users defend unprompted: 14 (3.79%, very strong, mean 4.93) praise the lifetime/one-time model; 16 (4.34%, mean 4.69) call the price fair against 16 (4.34%, mean 2.75) too high — 'I love the honesty of a pricier lifetime membership versus the subscription model that so many extortionists are using now' (US); 'Pretty, lean, no subscription… I don't like subscriptions' (DE); 'I like that it's a one-off payment because subscriptions totally stress me out' (DE); 4 (1.08%) bought to support the developer; price objections cluster in lower-ARPU storefronts (CN, TW, PH, TR, CO: 9 of 16) while model praise clusters in US/DE — 'do not convert this to a subscription. The pricing complaint is about the gate, not the model'

- **Where:** Executive summary 11; §3.3.6
- **This app does:** one-time lifetime Pro
- **User reaction:** purchase-driver
- **Magnitude:** one-time praise 14 (4.93); fair 16 (4.69) vs high 16 (2.75); 9 of 16 objections lower-ARPU
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `8528259165`, `8150960736`, `11652337363`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R54-026 — Free / paid / trial classification (verbatim): free — habit tracking, the plant, the water jar, at least one reminder, the weekly bar chart, a subset of colours (3 reported) and icons, capped at 3 habits (high, 44 describe it); Pro / 'lifetime' / 'habit pro' — more habits, more colours and icons, more pot designs, multiple reminders per habit, an advertised 'Advanced Statistics' calendar (low confidence on Advanced Statistics: 3 payers say it doesn't exist as described); trial — none, 7 (1.90%) ask for one; subscription — none, but 5 (1.36%) believe there is one; ads — none, 7 (1.90%) praise the absence

- **Where:** §2.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Tier | What reviewers report | Confidence ; Free | Habit tracking, the plant, the water jar, at least one reminder, the weekly bar chart, and a subset of colours (3 reported) and icons — capped at 3 habits | High — 44 reviewers describe the cap directly ; Pro / "lifetime" / "habit pro" | More habits (unlimited or a higher cap), more colours and icons, more pot designs, multiple reminders per habit, and an advertised "Advanced Statistics" calendar | High on the gating; low on Advanced Statistics, which 3 payers say does not exist as described ; Trial | None. 7 reviewers (1.90%) ask for one; nobody reports having had one | High ; Subscription | None — but 5 reviewers (1.36%) believe there is one, and one reports the App Store listing advertised a €2.50 subscription that the app did not offer | Model: high. The confusion: documented, unresolved ; Ads | None. 7 reviewers (1.90%) praise the absence; zero reviewers mention seeing an ad | High
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-027 — No trial: 7 reviewers (1.90%) ask for a free trial of Pro; nobody reports having had one

- **Where:** §2.2 trial row
- **This app does:** absent: trial
- **User reaction:** blocked-conversion
- **Magnitude:** 7 (1.90%)
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C063 Free trial before purchase

### R54-029 — Pro gates more habits, more colours and icons, more pot designs and multiple reminders per habit, plus 'Advanced Statistics'

- **Where:** §2.2 Pro row
- **This app does:** paid: habits, cosmetics, pots, multi-reminders
- **User reaction:** mixed
- **Magnitude:** report gives none
- **Direction for us:** build-paid · **Report confidence:** high (gating) · **Generalisable:** generalisable
- **Canonical:** C009 Basic widgets, icons and colours are free; C014 Multiple reminders per habit

### R54-032 — The subscription confusion is real: the product is a one-time purchase yet 5 reviewers (1.36%, meaningful) refer to a subscription ('unless you pay for the plus subscription … it's $9.99 one time' — contradicting themselves in one sentence; 'the one time fee for a whole year'; asking how to dismiss 'das Abo'; 'is the ¥68 membership a one-off lifetime buyout price?'); one reports the App Store listing advertised a €2.50 subscription the app did not sell — 'Sadly the only option is to buy lifetime for €17. But the App Store says there would be a €2.50 subscription. I'd book that immediately, of course' (DE, 4★, 2021) — the 'no subscription' asset is not landing cleanly, and at least one user would have paid a smaller recurring price

- **Where:** §2.2 subscription confusion
- **This app does:** one-time purchase misread as subscription; listing mentioned €2.50 subscription
- **User reaction:** blocked-conversion
- **Magnitude:** 5 (1.36%)
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8850800577`, `8266988041`, `9061891888`, `11111798656`, `7477741748`
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R54-040 — Positive monetisation signals 42 unique (11.38%, high-priority, mean 4.76): price_fair_praise 16 (4.34%, 4.69); onetime_purchase_praise 14 (3.79%, 4.93); free_tier_praise 10 (2.71%, 4.70); no_ads 7 (1.90%, 5.00); willing_to_support_dev 4 (1.08%, 5.00); willing_to_pay_intent 4 (1.08%, 4.75) — 'make a high quality product, offer it for free without junky ads, and without high pressure sales tactics. Let the app speak for itself' (US, payer); 'A one time payment for all the benefits of the app?? It's very affordable and generous'; 'The base version is completely free and ad-free. For a one-off €10 you can unlock extra content. Clear recommendation' (AT); 'supporting the creators… not being pressured into it with annoying ads and sign ups' — the model has advocates; the problem is that paying does not reliably work

- **Where:** §3.3.6 table (verbatim)
- **This app does:** one-time Pro, no ads, free tier
- **User reaction:** purchase-driver
- **Magnitude:** Sub-theme | n | % of 369 | Signal | Mean ★ ; price_fair_praise | 16 | 4.34% | very strong | 4.69 ; onetime_purchase_praise | 14 | 3.79% | very strong | 4.93 ; free_tier_praise | 10 | 2.71% | meaningful | 4.70 ; no_ads | 7 | 1.90% | meaningful | 5.00 ; willing_to_support_dev | 4 | 1.08% | meaningful | 5.00 ; willing_to_pay_intent | 4 | 1.08% | meaningful | 4.75
- **Direction for us:** build-paid · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7597717527`, `8896732201`, `8724044306`, `8285826726`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C061 Goodwill conversion — a generous free tier and 'support the devs'; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R54-041 — free_tier_praise 10 (2.71%, meaningful, mean 4.70) — some reviewers find the free tier generous even as 44 complain about the 3-habit cap

- **Where:** §3.3.6 free_tier_praise
- **This app does:** free tier
- **User reaction:** praise
- **Magnitude:** 10 (2.71%, 4.70)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R54-051 — The paywall complex 85 unique (23.04%, high-priority, mean 3.106) (verbatim): free_habit_limit_complaint 44 (11.92%, 3.16); price_too_high 16 (4.34%, 2.75); paywall_value_gap 12 (3.25%, 2.58); free_version_useless 11 (2.98%, 1.91); nonhabit_gating_complaint 8 (2.17%, 3.00) — colours, pots, reminders gated; no_trial_requested 7 (1.90%, 3.43); paywall_objection_general 6 (1.63%, 3.83); missing_feature_blocks_purchase 5 (1.36%, 4.20); paywall_prompt_friction 5 (1.36%, 2.80) — upgrade nag, incl. after paying; subscription_confusion 5 (1.36%, 4.00); listing_mismatch 2 (0.54%, 4.50); upgrade_flow_broken 1 (0.27%, 1.00) — told to upgrade, no way to

- **Where:** §3.5.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** Sub-theme | n | % of 369 | Signal | Mean ★ | What it is ; free_habit_limit_complaint | 44 | 11.92% | high-priority | 3.16 | The 3-habit cap, named ; price_too_high | 16 | 4.34% | very strong | 2.75 | The amount is wrong ; paywall_value_gap | 12 | 3.25% | very strong | 2.58 | Paid, didn't get what was promised ; free_version_useless | 11 | 2.98% | meaningful | 1.91 | The free tier isn't a product ; nonhabit_gating_complaint | 8 | 2.17% | meaningful | 3.00 | Colours, pots, reminders gated ; no_trial_requested | 7 | 1.90% | meaningful | 3.43 | Wants to try before paying ; paywall_objection_general | 6 | 1.63% | meaningful | 3.83 | "It costs money" ; missing_feature_blocks_purchase | 5 | 1.36% | meaningful | 4.20 | Would pay if X existed ; paywall_prompt_friction | 5 | 1.36% | meaningful | 2.80 | Upgrade nag, incl. after paying ; subscription_confusion | 5 | 1.36% | meaningful | 4.00 | Thinks it's a subscription ; listing_mismatch | 2 | 0.54% | emerging | 4.50 | Store listing ≠ app ; upgrade_flow_broken | 1 | 0.27% | weak | 1.00 | Told to upgrade, no way to
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-052 — The cap complaint's shape: the reviewer is enjoying themselves, hits three habits, and stops — 'I am on to making my fourth on and you have a pay for it!! Why!!!!!' (US, 4★); 'I was super happy starting my habits… went to make the 4th… it ruined it all for me' (CO, 2★); 'at least 5–7 habits free' (UA, 2★); reviewers propose their own number and agree — 5 (US, UA), 5–7 (US), 7–8 (US), 8 (CA), 9 (MX: '3 in the morning, 3 in the afternoon and 3 in the evening', mapping exactly onto the app's time-of-day structure), 10 (GB) — the modal ask is 5–8 free; nobody asks for the app to be free, 44 ask for the sample to be big enough to prove the product

- **Where:** §3.5.1 cap shape and counter-offers
- **This app does:** free: 3 habits
- **User reaction:** blocked-conversion
- **Magnitude:** counter-offers 5, 5–7, 7–8, 8, 9, 10; modal 5–8
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10112849044`, `6866535908`, `8784039212`, `7824596230`, `8285309663`, `6249084137`, `12197119033`, `6039511469`, `7076973873`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R54-059 — A buyer who paid on Google Play must rebuy on the App Store (ES, 1★, Dec 2023) — no cross-platform entitlement

- **Where:** §3.5.3 cross-platform purchase
- **This app does:** per-store purchase
- **User reaction:** 1★-burst
- **Magnitude:** n=1
- **Direction for us:** product-rule · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `10684528679`
- **Canonical:** C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R54-073 — Trigger (a) the free tier ran out — 'I ended up just getting the full version bc there were too many limitations on the free version for the amount of tasks I have' (US, 4★); 'a day later the Pro version because it won me over' (DE)

- **Where:** §5.2 (a)
- **This app does:** paid: unlock habits
- **User reaction:** purchase-driver
- **Magnitude:** report gives none
- **Direction for us:** build-paid · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `9201251285`, `8324458354`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R54-076 — Trigger (d) the one-time model itself: 'I love the honesty of a pricier lifetime membership versus the subscription model'; 'I even paid the one time fee forever because I am so excited for this app!'; '100% worth the life membership… the color scheme and visuals… made me choose this one over the others'

- **Where:** §5.2 (d)
- **This app does:** one-time lifetime
- **User reaction:** purchase-driver
- **Magnitude:** report gives none
- **Direction for us:** build-paid · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `8528259165`, `7617114746`, `8986983542`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R54-079 — Upgrade barriers (verbatim): the free tier too small to prove the product (44 cap + 11 useless = 50 unique, 13.55%); no trial and the price too high to gamble (7, 1.90% — 'It's kind of expensive to buy the premium to see if I will like it', PH; 'use the app fully for 2–3 months before spending the twenty', DE); price wrong for the market (16, 4.34%; 9 of 16 CN/TW/PH/TR/CO); a missing capability blocks the decision (5, 3 widget); reputation — purchase may not work (12, 2 alleging fraud); reputation — app may be abandoned (9, 'I'd happily support with Pro, but that such a basic bug is still not fixed is really not on', DE)

- **Where:** §5.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** Barrier | Evidence | n | Global % ; The free tier is too small to prove the product | 44 cap complaints + 11 "free version is useless" | 50 unique | 13.55% ; No trial, and the price is too high to gamble | *"It's kind of expensive to buy the premium to see if I will like it"* (7755528602, PH); *"Die App erstmal 2-3 Monat voll nutzen bevor ich den Zwanni ausgebe"* / "I'd like to use the app fully for 2–3 months before spending the twenty" (7477741748, DE); *"Wieso sollte man ohne zu wissen, ob die App wirklich was taugt, die Vollversion herunterladen?!"* (9384744042, DE) | 7 | 1.90% ; Price is wrong for the market | 9 of 16 price objections are CN/TW/PH/TR/CO. *"付费版真的太贵了，可以像其他app一样的会员版，隔壁小日常会员3元一个月"* / "The paid version is really too expensive — you could do a membership like other apps; the one next door is ¥3 a month" (7157687565, CN, 4★) | 16 | 4.34% ; A missing capability blocks the decision | 5 named conditions, 3 of them the widget (§3.5.1) | 5 | 1.36% ; Reputation: purchase may not work | 12 public post-purchase failures, 2 alleging fraud | 12 | 3.25% ; Reputation: app may be abandoned | *"Ich unterstütze gerne mit Pro aber dass so ein Basic Fehler … immer noch nicht gefixt ist, geht echt nicht"* / "I'd happily support with Pro, but that such a basic bug is still not fixed is really not on" (12115176508, DE, 2★) | 9 | 2.44%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `7755528602`, `7477741748`, `9384744042`, `7157687565`, `12115176508`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C063 Free trial before purchase; C092 Regional pricing

### R54-114 — D1: raise the free habit cap to 5–8 — 50 unique (13.55%) cap or useless-free-tier reviewers; reviewers name the number (5, 5–7, 7–8, 8, 9 as 3×3 across time-of-day sections, 10); counter-argument stated fairly (the cap is the conversion mechanism) but the corpus argues against it — of the 44 complainants 23 rated 1–3★ (11×3★, 6×2★, 6×1★), two deleted immediately on contact, two call the free tier unusable; the strongest conversion stories got enough free room (two weeks, one week, a few minutes with the whole feature set visible) — 'the cap currently terminates evaluation rather than gating it'; do it as a measured experiment (6 in a subset of storefronts; purchase rate and 30-day retention)

- **Where:** §8.2 D1
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 50 unique (13.55%); 23 of 44 at 1–3★
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `7165608219`, `6883715554`, `7892340081`, `10772046188`, `10801492320`, `10851094567`, `8528259165`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R54-115 — D2: keep the one-time purchase and fix its price geography — do not move to a subscription (14 advocates at 4.93, subscription fatigue named); introduce storefront-tiered pricing because a ¥98 one-time price competes against a ¥3/month anchor (same for TW NT$490, PH, TR, CO); price objections 3.1× more frequent outside high-spend storefronts (8.3% vs 2.7%); also fix the subscription confusion — a listing advertising a €2.50 subscription the app did not sell, whose reader would have bought it immediately

- **Where:** §8.2 D2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 8.3% vs 2.7%; 9 of 16 low-ARPU
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `7157687565`, `7477741748`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C092 Regional pricing; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

## Tactics the app used

### R54-075 — Trigger (c) patronage: willing_to_support_dev 4 (1.08%), all 5★, three confirmed payers — 'I went ahead and paid for the lifetime pro bc it's such a great app and I want to support the developers'; 'supporting the creators of this app feels good to give back'; 'worth a 5★ review and the coffee to me' (DE)

- **Where:** §5.2 (c)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 4 (1.08%, 5.00)
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `7597717527`, `8285309663`, `8285826726`, `7972862635`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R54-120 — Experiments worth running (verbatim): free cap 3 → 6 in matched storefronts (purchase rate, D30 retention, 1★ rate); storefront-tiered pricing in CN/TW/PH/TR/BR (purchase rate per storefront); interactive vs read-only widget (DAU, completion rate, review mentions); explicit 'Restore purchase' entry point on the paywall — some purchase failures are discovery failures (support volume, 1★ rate); onboarding for the water jar and repotting (feature engagement, onboarding_confusion rate)

- **Where:** §8.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Experiment | Hypothesis from the corpus | Measure ; Free cap 3 → 6 in matched storefronts | The cap terminates evaluation rather than gating it (D1) | Purchase rate, D30 retention, 1★ rate ; Storefront-tiered pricing in CN/TW/PH/TR/BR | Price objection is an anchor problem, not a willingness problem (D2, §6.5) | Purchase rate per storefront ; Interactive widget vs read-only widget | Users want to log, not just look (D3) | DAU, completion rate, review mentions ; Explicit "Restore purchase" entry point on the paywall | Some purchase failures are discovery failures, not entitlement failures (F1) | Support volume, 1★ rate ; Onboarding for the water jar and repotting | 10 reviewers (2.71%) could not work out three specific mechanics (§3.5.5) | Feature engagement, onboarding_confusion rate in new reviews
- **Direction for us:** research · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

## Insights (the why)

### R54-009 — A beautiful product with a monetisation wound, and the two facts are the same size: 128 of 369 (34.69%, high-priority, mean 4.36) praise the visual design — the largest theme by a factor of two — while 85 (23.04%, high-priority, mean 3.106) raise paywall or pricing friction; not separate populations — 9 of 23 two-star and a third of three-star reviews praise the design in the same breath ('Very cute, but — you only get two habits, if you want more you have to pay 25', BR, 1★) — 'design is not the constraint on this business. The shape of the free tier is'

- **Where:** Executive summary 1; §3.3.1
- **This app does:** design-led app with a 3-habit gate
- **User reaction:** mixed
- **Magnitude:** design 128 (34.69%, 4.36); paywall 85 (23.04%, 3.106)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10137074917`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R54-013 — The confirmed-payer segment is the angriest cohort: 44 (11.92%) state they bought Pro, mean 3.091 vs corpus 3.981, distribution 12×5★ / 10×4★ / 4×3★ / 6×2★ / 12×1★ — payers 3.3× more likely to leave one star (27.3% vs 8.4%); segment rates — value gap 22.7%, basic statistics 13.6%, purchase never unlocked 13.6%, restore failure 13.6%, calendar/stats bugs 11.4%, refund requested 11.4%, support unresponsive 9.1% — 'paying is currently a risk transfer from the developer to the user. The 22 payers who rated 1–3★ are not disappointed by price — they are disappointed by delivery'

- **Where:** Executive summary 5; §5.1
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 44 (3.091); 1★ 27.3% vs 8.4%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R54-028 — No ads: 7 reviewers (1.90%) praise the absence; zero mention seeing an ad

- **Where:** §2.2 ads row; §3.3.6
- **This app does:** no ads
- **User reaction:** praise
- **Magnitude:** 7 (1.90%)
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R54-034 — Design and aesthetics 128 (34.69%, high-priority, mean 4.36, all 43 storefronts, 2019-12-21 → 2026-05-27), star split 76/31/12/9/0 — no 1★ praises the design, nine 2★ do; the largest theme by more than 2:1, the reason people download and stay attached while complaining: 'The most beautifully designed habit tracker I've used. I have deleted all of my other habit trackers' (CA); 'a e s t h e t i c … The cute format definitely makes me want to achieve my goals' (CA); 'I am a very visual person and this made a huge difference' (US) — design is the moat, and it makes every other failure more expensive ('beautiful but')

- **Where:** §3.3.1
- **This app does:** illustrated bubble UI
- **User reaction:** praise
- **Magnitude:** 128 (34.69%, 4.36); 76/31/12/9/0
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `5840396610`, `6067098127`, `8260945041`, `8528259165`, `9195522591`, `8518969458`, `8724044306`, `5426364387`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R54-039 — Outcomes 49 (13.28%, high-priority, mean 4.78, 2020-04 → 2025-02) — concrete behaviour change: 'This app has made me so healthy I lost 60 pounds!'; 'increase how often I do at least two of them in only a few weeks'; 'even with a little inconsistency my laundry pile shrinks more than it grows… my house… is starting to feel more like a home and less like a noose'; 'It got me to start drinking more water'

- **Where:** §3.3.5
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 49 (13.28%, 4.78)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `9915898673`, `6534235105`, `10851094567`, `6024882686`, `9305249528`, `8537570240`, `9812162219`, `10130351801`
- **Canonical:** — (nuance register)

### R54-053 — missing_feature_blocks_purchase 5 (1.36%, meaningful, mean 4.20) — the most commercially useful theme despite n=5, five named auditable conversion conditions (not a conversion rate): widget (CO), widget (TW), widget + one month of proof (US), Apple Watch ('lemme know if you're working on the watch app and I'll be the first one to buy this app', PK), more things / details (ES)

- **Where:** §3.5.1 missing_feature_blocks_purchase
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** 5 (1.36%, 4.20); 3 widget
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `10307040667`, `8179279036`, `9285390908`, `9424982566`, `8419692438`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C023 Interactive widget check-off

### R54-060 — Abandonment and support 14 unique: abandonment_no_updates 9 (2.44%, 2.33) and support_unresponsive 6 (1.63%, 1.50), both concentrated in P3 (5.0% and 4.2%); the most damaging record is a 4★ volunteering a second purchase — 'I would pay for the premium version again in a heartbeat!' — blocked only by the perception of abandonment: 'the cheapest revenue in this report'

- **Where:** §3.5.4
- **This app does:** unmaintained
- **User reaction:** churn
- **Magnitude:** 9 (2.33) + 6 (1.50); P3 5.0% / 4.2%
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `10462417239`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C071 Never ship and walk away

### R54-064 — churn_stated 7 (1.90%, meaningful, mean 2.86) — seven reasons, seven people: no Apple Watch ('now I'm forced to use another app', DE), no widget (PH), the 3-habit cap (TW, US), no backfill (UA), the plant stalling (US), no 'X days a week' (US) — the churn is not caused by one thing

- **Where:** §3.5.5 churn_stated
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 7 (1.90%, 2.86)
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8902552282`, `11512811846`, `7165608219`, `6883715554`, `10955907409`, `8956070679`, `9511531312`
- **Canonical:** — (nuance register)

### R54-066 — 4★ (n=101) is the 'one thing away' bucket (verbatim table: aesthetic 31 30.7%; free_habit_limit 17 16.8%; req_widget 16 15.8%; simplicity 15; req_history_stats 14 13.9%; ease 13; req_per_habit_stats 11; plant 11; paid 10; req_flexible_frequency 10 9.9%) — 'then you get 5 stars from me' (DE, Watch or widget); 'I'd give avocation 5 stars if I had the ability to look back at my progress over the past month' (GB); 'no way to adjust your start date for habits' (US); 'lacks iCloud sync' (ES); 'lack of backup and not be able to rearranging the habits' (GB) — named features concentrate in widget (16), history/per-habit stats (25), habit cap (17), flexible frequency (10): 'the reviewers have done the prioritising'

- **Where:** §4.2 table (verbatim) and reading
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 101 ; aesthetic_design | 31 | 30.7% ; free_habit_limit_complaint | 17 | 16.8% ; req_widget | 16 | 15.8% ; simplicity_minimalism | 15 | 14.9% ; req_history_stats | 14 | 13.9% ; ease_of_use | 13 | 12.9% ; req_per_habit_stats | 11 | 10.9% ; plant_growth_motivation | 11 | 10.9% ; paid_confirmed | 10 | 9.9% ; req_flexible_frequency | 10 | 9.9%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `8048932602`, `5751972817`, `6066741542`, `10946192676`, `9597316193`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C011 Weekly / monthly / yearly reports; C023 Interactive widget check-off; C043 Flexible / custom frequency

### R54-068 — 3★ (n=41) is where 'beautiful but thin' lives (verbatim table: aesthetic 12 29.3%; free_habit_limit 11 26.8%; req_flexible_frequency 8 19.5%; simplicity 6; req_history_stats 6; limited_features_general 6 14.6%; req_widget 5; paid 4; several at 3 each) — 'Very nice app graphically… It would be useful to monitor task progress with charts' (IT); 'I fell for the attractive visuals… after a week I realised there's nothing here besides the picture' (UA); 'Very nicely designed… but this app's feature scope is very small' (DE)

- **Where:** §4.3 table (verbatim) and reading
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 41 ; aesthetic_design | 12 | 29.3% ; free_habit_limit_complaint | 11 | 26.8% ; req_flexible_frequency | 8 | 19.5% ; simplicity_minimalism | 6 | 14.6% ; req_history_stats | 6 | 14.6% ; limited_features_general | 6 | 14.6% ; req_widget | 5 | 12.2% ; paid_confirmed | 4 | 9.8% ; onboarding_confusion / price_too_high / paywall_prompt_friction / plant_underwhelming / req_more_customization / bug_plant_not_growing / nonhabit_gating_complaint / bug_notifications | 3 each | 7.3% each
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `8652140855`, `7987837235`, `6370677225`
- **Canonical:** — (nuance register)

### R54-069 — 2★ (n=23) is the disappointed-buyer bucket (verbatim table: aesthetic 9 39.1%; paid_confirmed 6 26.1%; paywall_value_gap 6 26.1%; free_habit_limit 6; price_too_high 5 21.7%; stats_too_basic 4; free_version_useless 4; backfill / calendar bug / support / limited features 3 each) — people who like it, paid for it and feel short-changed: 'Although I bought Pro there are no advanced statistics… The look is beautiful, but what use is it with so little practical usability?' (DE); 'Trash app with appealing interface… had me spend on upgraded version which costs $13 for nothing' (US)

- **Where:** §4.4 table (verbatim) and reading
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 23 ; aesthetic_design | 9 | 39.1% ; paid_confirmed | 6 | 26.1% ; paywall_value_gap | 6 | 26.1% ; free_habit_limit_complaint | 6 | 26.1% ; price_too_high | 5 | 21.7% ; stats_too_basic | 4 | 17.4% ; free_version_useless | 4 | 17.4% ; req_backfill_past / bug_calendar_stats_wrong / support_unresponsive / limited_features_general | 3 each | 13.0% each
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `10904975030`, `7793589747`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R54-074 — Trigger (b) a short self-imposed trial converted — the free tier working as designed when it lasts long enough: 'I tried Avocation for two weeks and checked whether I used it daily before buying Pro' (DE, 5★); 'I had the app for about a week before I realized that this could revolutionize my life… lifetime membership' (US); 'I used it a few minutes and took a chance' (US); 'immediately availed the Pro after testing it out for like 5 mins' (PH)

- **Where:** §5.2 (b)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** report gives none
- **Direction for us:** do · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `10801492320`, `10851094567`, `8528259165`, `12351796564`
- **Canonical:** C147 Let people use the product before they pay

### R54-078 — What paying buys, per payers (segment rates of 44, verbatim): aesthetic 15 (34.1%); paywall_value_gap 10 (22.7% vs 3.25% global); stats_too_basic 6; purchase_not_unlocked 6; restore_purchase_failure 6; plant motivation 6; simplicity 6; flexible frequency 5; reorder 5; calendar bug 5; refund 5; per-habit stats 4; widget 4; abandonment 4; plant not growing 4; support unresponsive 4; one-time praise 4 — the payer segment contains nearly the entire global population of six themes (10 of 12 value gap, 6 of 6 not unlocked, 6 of 7 restore, 6 of 8 stats too basic, 5 of 5 refunds, 4 of 5 plant stall, 4 of 6 support) — 'Free users complain about the gate; paying users complain about the goods'

- **Where:** §5.3 table (verbatim) and reading
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme among payers | n (of 44) | Segment rate | Global n | Global % ; aesthetic_design | 15 | 34.1% | 128 | 34.69% ; paywall_value_gap | 10 | 22.7% | 12 | 3.25% ; stats_too_basic | 6 | 13.6% | 8 | 2.17% ; purchase_not_unlocked | 6 | 13.6% | 6 | 1.63% ; restore_purchase_failure | 6 | 13.6% | 7 | 1.90% ; plant_growth_motivation | 6 | 13.6% | 35 | 9.49% ; simplicity_minimalism | 6 | 13.6% | 60 | 16.26% ; req_flexible_frequency | 5 | 11.4% | 24 | 6.50% ; req_reorder_habits | 5 | 11.4% | 13 | 3.52% ; bug_calendar_stats_wrong | 5 | 11.4% | 9 | 2.44% ; refund_request | 5 | 11.4% | 5 | 1.36% ; req_per_habit_stats | 4 | 9.1% | 16 | 4.34% ; req_widget | 4 | 9.1% | 41 | 11.11% ; abandonment_no_updates | 4 | 9.1% | 9 | 2.44% ; bug_plant_not_growing | 4 | 9.1% | 5 | 1.36% ; support_unresponsive | 4 | 9.1% | 6 | 1.63% ; onetime_purchase_praise | 4 | 9.1% | 14 | 3.79%
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R54-121 — Research questions: 1 what is the actual free-tier cap today and has it changed (five incompatible answers in six years); 2 are restore failures a regional entitlement bug or a behavioural artefact — receipts data settles it in an hour; 3 do cap complainants convert or churn; 4 why did review volume fall 91% from 2022; 5 did any bugs get fixed; 6 what does the App Store listing actually promise — Advanced Statistics, the €2.50 subscription and the 5-habit free tier are three reviewer-reported listing/product disagreements, unverifiable here and cheap to check

- **Where:** §8.4 part 8 #1, part 8 #2, part 8 #3, part 8 #4, part 8 #5, part 8 #6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

## Audiences

### R54-072 — paid_confirmed 44 (11.92%, high-priority) — stated completed purchases in many languages, ambiguous phrasing excluded (a floor), not a conversion rate; corpus vs payers: mean 3.981 vs 3.091; 5★ 46.88% vs 27.3% (12); 4★ 27.37% vs 22.7% (10); 3★ 11.11% vs 9.1% (4); 2★ 6.23% vs 13.6% (6); 1★ 8.40% vs 27.3% (12) — payers 3.3× more likely to leave one star; by year 2020 3, 2021 5, 2022 16, 2023 8, 2024 6, 2025 4, 2026 2; by storefront US 19, DE 5, AU/CA/ES/MX/TW 2 each, 10 more at 1 — 17 storefronts, not a single-market artefact

- **Where:** §5.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | Corpus | Confirmed payers ; n | 369 | 44 ; Mean ★ | 3.981 | 3.091 ; 5★ | 46.88% | 27.3% (12) ; 4★ | 27.37% | 22.7% (10) ; 3★ | 11.11% | 9.1% (4) ; 2★ | 6.23% | 13.6% (6) ; 1★ | 8.40% | 27.3% (12)
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `8175155082`
- **Canonical:** — (nuance register)

### R54-119 — D6: claim the shame-free and neurodivergent positioning already held — 12 (3.25%, 4.75) praise the absence of streaks, 8 American; 7 (1.90%, meaningful) self-identify as ADHD, autistic or anxious, all 4–5★; the recorded subtitle is 'Daily planner & ADHD organizer' yet no reviewer mentions having been sold on that — every one discovers the fit themselves; 'These are skills. Skills can be learned. I am not broken' (a mental-health worker) is the positioning statement

- **Where:** §8.2 D6
- **This app does:** subtitle names ADHD; users discover the fit
- **User reaction:** praise
- **Magnitude:** no-streak 12 (4.75); ND self-ID 7 (1.90%), all 4–5★
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `6534235105`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C134 Lead the store listing with what users actually love; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

## Markets and languages

### R54-063 — language_barrier 3 (0.81%, emerging): lessons are English-only inside localised UIs — 'this software is all in English' (CN); 'too much English' (CN); 'English texts are not translated' (DE); against this a DE 5★ says the English articles don't bother them; plus 3 req_localization (Arabic, full Chinese); a German reviewer calls it 'the only habit tracker in German'

- **Where:** §3.5.5 language
- **This app does:** UI localised, content English-only
- **User reaction:** complaint
- **Magnitude:** 3 (0.81%) + 3 requests
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `6903942728`, `7026803455`, `6281818718`, `11652337363`, `8518969458`
- **Canonical:** C027 Localise early — it unlocks revenue

### R54-080 — In CN/TW the one-time model competes against a subscription price anchor an order of magnitude lower: 'The paid version is really too expensive — you could do a membership like other apps; the one next door is ¥3 a month' (CN, 4★) against Avocation's ¥98 one-time — 'a pricing-architecture problem, not a price-point problem'

- **Where:** §5.4 CN price anchor
- **This app does:** ¥98 one-time vs ¥3/month competitor (小日常)
- **User reaction:** blocked-conversion
- **Magnitude:** 9 of 16 price objections CN/TW/PH/TR/CO
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `7157687565`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C025 Scholarship / hardship / discount program; C092 Regional pricing

### R54-082 — The 50-review threshold — one storefront qualifies (verbatim): US 119 (32.25%, 4.294); Germany 36 (3.944); Great Britain 31 (4.065); China 24 (3.792); Ukraine 18 (3.389); Spain 17 (4.000); Canada 16 (3.938); Taiwan 11 (3.545); Australia, Brazil 10 each (3.800); Mexico 9; Italy, Turkey 7; Austria 6 (4.833); Philippines 5; Poland, Vietnam 4; Netherlands, Saudi Arabia 3; Colombia, Czechia, Oman, Pakistan, South Africa 2; 19 storefronts with 1 each (mean 3.000; 5/5/1/1/7)

- **Where:** §6.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Storefront | n | % of 369 | Mean ★ | 5/4/3/2/1 | Standalone claims allowed? ; United States | 119 | 32.25% | 4.294 | 68/32/9/6/4 | Yes — §6.2 ; Germany | 36 | 9.76% | 3.944 | 18/8/3/4/3 | No — limited evidence ; Great Britain | 31 | 8.40% | 4.065 | 11/14/4/1/1 | No — limited evidence ; China | 24 | 6.50% | 3.792 | 11/5/3/2/3 | No — limited evidence ; Ukraine | 18 | 4.88% | 3.389 | 6/4/2/3/3 | No — limited evidence ; Spain | 17 | 4.61% | 4.000 | 9/3/3/0/2 | No — limited evidence ; Canada | 16 | 4.34% | 3.938 | 4/9/2/0/1 | No — limited evidence ; Taiwan | 11 | 2.98% | 3.545 | 3/4/2/0/2 | No — limited evidence ; Australia · Brazil | 10 each | 2.71% each | 3.800 each | 6/1/0/1/2 · 5/2/1/0/2 | No — limited evidence ; Mexico | 9 | 2.44% | 4.000 | 2/5/2/0/0 | No ; Italy · Turkey | 7 each | 1.90% each | 4.143 · 4.000 | — | No ; Austria | 6 | 1.63% | 4.833 | 5/1/0/0/0 | No ; Philippines | 5 | 1.36% | 3.600 | 1/2/1/1/0 | No ; Poland · Vietnam | 4 each | 1.08% each | 4.250 · 4.000 | — | No ; Netherlands · Saudi Arabia | 3 each | 0.81% each | 4.333 · 4.000 | — | No ; Colombia · Czechia · Oman · Pakistan · South Africa | 2 each | 0.54% each | 2.500 / 5.000 / 3.500 / 4.500 / 3.000 | No ; 19 storefronts with 1 review each | 19 | 5.15% | 3.000 | 5/5/1/1/7 | No
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-083 — United States n=119 (32.25%), mean 4.294, 2020-04-20 → 2026-08-19 — theme table with difference from global (verbatim)

- **Where:** §6.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | n | % of 119 | Signal (US) | vs global % ; aesthetic_design | 48 | 40.34% | high-priority | +5.65pp ; simplicity_minimalism | 29 | 24.37% | high-priority | +8.11pp ; outcome_behavior_change | 29 | 24.37% | high-priority | +11.09pp ; ease_of_use | 21 | 17.65% | high-priority | +5.73pp ; paid_confirmed | 19 | 15.97% | high-priority | +4.05pp ; plant_growth_motivation | 18 | 15.13% | high-priority | +5.64pp ; free_habit_limit_complaint | 14 | 11.76% | high-priority | −0.16pp ; comparative_best | 12 | 10.08% | high-priority | +0.59pp ; advocacy_recommend | 11 | 9.24% | high-priority | +4.09pp ; req_widget | 10 | 8.40% | high-priority | −2.71pp ; req_more_customization · req_flexible_frequency · req_per_habit_stats · onetime_purchase_praise | 9 each | 7.56% each | high-priority | — ; no_streak_shame_free | 8 | 6.72% | high-priority | +3.47pp ; price_fair_praise | 7 | 5.88% | high-priority | +1.54pp ; req_backfill_past · time_of_day_structure · req_history_stats · req_plant_variety_collection · bug_calendar_stats_wrong | 6 each | 5.04% each | high-priority | — ; paywall_value_gap · paywall_objection_general · req_reorder_habits · free_tier_praise · water_tracker_praise · reminders_praise · onboarding_confusion · customization_praise | 5 each | 4.20% each | very strong | —
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-084 — US is the outcome market: outcome_behavior_change 24.37% in the US vs 13.28% globally (+11.09pp) — reviewers describe results (weight loss, a cleaner house, hydration, consistency), not features — 'the US corpus contains this product's best marketing copy, written by its users'

- **Where:** §6.2 finding 1
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 24.37% vs 13.28%
- **Direction for us:** do · **Report confidence:** high-priority (US) · **Generalisable:** app-specific
- **Review IDs:** `9915898673`, `10851094567`, `10130351801`, `6534235105`
- **Canonical:** C134 Lead the store listing with what users actually love

### R54-085 — US is where the anti-streak positioning lands: 8 of 12 global no_streak_shame_free are American (6.72% US vs 3.25% global), all 4–5★ — resonates most in the largest market and is not claimed in positioning anywhere the corpus can see

- **Where:** §6.2 finding 2
- **This app does:** no streaks
- **User reaction:** praise
- **Magnitude:** 8 of 12; 6.72% vs 3.25%
- **Direction for us:** do · **Report confidence:** high-priority (US) · **Generalisable:** generalisable
- **Canonical:** C134 Lead the store listing with what users actually love; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R54-086 — US is the payer market and payers are relatively satisfied: 19 of 44 confirmed payers (43.2%) are American; US payers average 3.737 (9/3/2/3/2) against 2.600 for 25 non-US payers (3/7/2/3/10) — non-US payers 3.5× more likely to leave one star; US one-star bucket 4 (3.36% vs 8.40% globally); 10 of 12 one-star payer reviews come from outside the US

- **Where:** §6.2 finding 3
- **This app does:** entitlement failures concentrated outside US
- **User reaction:** mixed
- **Magnitude:** US payers 3.737 vs non-US 2.600; 10 of 12 1★ payers non-US
- **Direction for us:** must-never-break · **Report confidence:** high-priority (US) · **Generalisable:** generalisable
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C062 Weight English-speaking rich markets; volume ≠ revenue

### R54-087 — US widget demand real but below global (8.40% vs 11.11%) — strongest widget language is Taiwanese, Italian, Ukrainian and Filipino; US price sentiment net positive — price_fair 7 + onetime praise 9 + free_tier praise 5 = 21 positive against price_too_high 1 and value gap 5: 'The US does not have a price problem. It has a delivery problem'; US 4.294 vs 3.981, 57.14% five-star (global 46.88%), 3.36% one-star (global 8.40%)

- **Where:** §6.2 findings 4–5; US distribution
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 21 positive vs 1 price_too_high
- **Direction for us:** none · **Report confidence:** high-priority (US) · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-088 — Germany n=36 (limited evidence), mean 3.944 — the most articulate storefront (longest, multi-point critiques); plant_underwhelming 5, half the global total; paid 5; history stats 4; flexible frequency 4; the corpus's only accessibility report, only store-listing price mismatch, and 'The only habit tracker in German!' — not a standalone claim (one review = 2.8%)

- **Where:** §6.3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=36; plant_underwhelming 5 of 10
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `6370677225`, `8324458354`, `12115176508`, `12549329908`, `6281818718`, `9704771391`, `7967680944`, `7477741748`, `8518969458`
- **Canonical:** — (nuance register)

### R54-090 — Great Britain n=31 (limited evidence), mean 4.065, the most 4★-heavy storefront (14 of 31 = 45.2%); aesthetic 10, plant motivation 6, history stats 5, comparative best 5, outcome 5; the most detailed reminder-defect report (no badge, nagging after completion, wrong sound) and the most explicit paywall-tone complaint ('The paywall is so obtrusive … but £9 for a habit and tracker app?')

- **Where:** §6.4
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=31; 45.2% 4★
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `8306365770`, `9467299912`
- **Canonical:** — (nuance register)

### R54-092 — China n=24 (limited evidence), mean 3.792 — the most price-sensitive storefront: 4 of 24 (16.7%) call the price too high vs 4.34% globally; prices ¥100, ¥98, ¥68; benchmarked against a ¥3/month competitor; req_ipad_mac 3 of 7 global; language_barrier 2 of 3; req_localization 2 of 3 (full Chinese UI and Chinese lock-screen notifications) — objection is to a one-time price set against a market anchored on cheap subscriptions; a hypothesis to test, not act on

- **Where:** §6.5
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** price 16.7% vs 4.34%
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `7157687565`
- **Canonical:** C092 Regional pricing

### R54-093 — Ukraine n=18 (limited evidence) — the lowest mean of any storefront with n ≥ 10 (3.389), 6 at 1–2★; two of seven restore-purchase failures; 'besides the picture there's nothing here'; 2 widget requests, 1 Watch request

- **Where:** §6.6
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** n=18; 3.389
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `7866822037`, `11201859512`, `7987837235`
- **Canonical:** — (nuance register)

### R54-094 — Spain (17, 4.000): aesthetic 9, widget 4, the cross-platform purchase failure and the 67-day plant stall; Canada (16, 3.938): the most request-dense storefront — history stats 4, flexible frequency 3, widget 3, only 4 five-star of 16, and the most detailed single feature critique (lag, water tracker, lesson completion state, plant-growth mechanics, 5★); Taiwan (11, 3.545): 4 of 11 (36.4%) request a widget — the highest rate — two tie it to willingness to buy; 3 cap complaints and the NT$490 unlock failure

- **Where:** §6.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** TW widget 36.4%
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `10684528679`, `10138813839`, `6209435279`, `8179279036`, `6801246699`, `6759577812`
- **Canonical:** — (nuance register)

### R54-096 — High-spend group (disclosed proxy: 15 developed-market storefronts US, GB, DE, CA, AU, AT, NL, SE, NO, FI, SG, KR, TW, IT, ES) n=261 (70.73%), mean 4.103 vs rest of world 3.685 (n=108) (verbatim table): aesthetic 37.9% vs 26.9%; simplicity 19.9% vs 7.4% (+12.5pp); outcome 16.9% vs 4.6% (+12.3pp); paid 13.0% vs 9.3%; widget 12.3% vs 8.3%; history 9.2% vs 3.7%; cap complaint 10.7% vs 14.8% (−4.1pp); price too high 2.7% vs 8.3% (−5.6pp); restore failure 0.8% vs 4.6% (−3.8pp) — 1 price resistance 3.1× higher outside the group, the single global price is mispriced for the long tail, regional price the obvious experiment; 2 restore failures 6× more concentrated outside (BR, GR, TH, UA×2 vs ES, US) — regional entitlement problem, device-change behaviour or sampling artefact, check against receipts; 3 deep engagement language (outcomes, simplicity, long-range history) is overwhelmingly high-spend — understood as a behaviour-change tool in developed markets and a cute utility elsewhere, a positioning and localisation gap

- **Where:** §6.9 table (verbatim) and findings
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | High-spend % (n=261) | Rest of world % (n=108) | Difference ; aesthetic_design | 37.9% | 26.9% | +11.0pp ; simplicity_minimalism | 19.9% | 7.4% | +12.5pp ; outcome_behavior_change | 16.9% | 4.6% | +12.3pp ; ease_of_use | 13.0% | 9.3% | +3.7pp ; paid_confirmed | 13.0% | 9.3% | +3.7pp ; req_widget | 12.3% | 8.3% | +4.0pp ; req_history_stats | 9.2% | 3.7% | +5.5pp ; free_habit_limit_complaint | 10.7% | 14.8% | −4.1pp ; price_too_high | 2.7% | 8.3% | −5.6pp ; restore_purchase_failure | 0.8% | 4.6% | −3.8pp
- **Direction for us:** research · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C027 Localise early — it unlocks revenue; C062 Weight English-speaking rich markets; volume ≠ revenue; C092 Regional pricing

### R54-097 — High-review-volume group (disclosed proxy: 7 storefronts ≥15 reviews — US, DE, GB, CN, UA, ES, CA) n=261 (70.73%), mean 4.069 (verbatim table): paid_confirmed 11.9% vs 11.92% global — identical; free_habit_limit_complaint 11.9% vs 11.92% — identical; aesthetic 37.5% vs 34.69%; simplicity 17.6%; outcome 15.7%; widget 10.3%; history 9.2%; frequency 8.0% — the two highest-signal themes appear at identical rates, so they are properties of the product, not market phenomena

- **Where:** §6.10 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | High-volume % (n=261) | Global % | Reading ; aesthetic_design | 37.5% | 34.69% | Uniform ; simplicity_minimalism | 17.6% | 16.26% | Uniform ; outcome_behavior_change | 15.7% | 13.28% | Slightly concentrated ; paid_confirmed | 11.9% | 11.92% | Identical ; free_habit_limit_complaint | 11.9% | 11.92% | Identical ; req_widget | 10.3% | 11.11% | Uniform ; req_history_stats | 9.2% | 7.59% | Concentrated ; req_flexible_frequency | 8.0% | 6.50% | Concentrated
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R54-098 — Uniform vs not (verbatim): uniform across every storefront with n ≥ 10 — design praise top or second in all ten, cap complaint in eight of ten, widget requests in eight of ten; not uniform — price objection CN (16.7%), PH, TW, TR, CO vs US (0.8%), DE; restore/entitlement failure BR, ES, GR, TH, UA, KR, TW vs US (1 of 7); outcome language US (24.4%) vs CN (0), TW (0), UA (1); widget demand TW (36.4%), IT (57%, n=7), UA, PH; iPad demand CN (3 of 24), TW vs US (0 of 119); localisation demand CN (full Chinese), SA (Arabic), DE (lesson translation); anti-streak appreciation US (8 of 12)

- **Where:** §6.11 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Dimension | Concentrated in | Absent or weak in | Evidence ; Price objection | CN (16.7%), PH, TW, TR, CO | US (0.8%), DE | 9 of 16 price complaints in 5 low-ARPU storefronts ; Restore/entitlement failure | BR, ES, GR, TH, UA, KR, TW | US (1 of 7) | §3.5.3 ; Outcome / behaviour-change language | US (24.4%) | CN (0), TW (0), UA (1) | §6.9 finding 3 ; Widget demand | TW (36.4%), IT (57%, n=7), UA, PH | — | §6.7 ; iPad / tablet demand | CN (3 of 24), TW | US (0 of 119) | req_ipad_mac ; Localisation demand | CN (full Chinese), SA (Arabic), DE (lesson translation) | Anglophone storefronts | req_localization, language_barrier ; Anti-streak appreciation | US (8 of 12) | Everywhere else | §6.2 finding 2
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

## Dated events and trends

### R54-004 — Volume and rating by year (verbatim): 2019 1 (5.000); 2020 60 (4.233); 2021 85 (3.847); 2022 104 (4.212); 2023 64 (3.766); 2024 30 (3.933); 2025 16 (3.625); 2026 to 19 Aug 9 (3.111); volume peaked in 2022 and fell ~91% by 2026 — ambiguous (declining installs, Apple's prompt behaviour, developer no longer prompting) and used as evidence for nothing; the product changed inside the span (free cap, price, maintenance status), so period percentages are preferred for trend claims; 2,433 days, 324 distinct review days; busiest month January 2022 (19); busiest day 4 (2021-01-23, 2022-01-21)

- **Where:** §Eight warnings 2–3; §1.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Year | Reviews | Mean ★ | 5/4/3/2/1 ; 2019 (10 days) | 1 | 5.000 | 1/0/0/0/0 ; 2020 | 60 | 4.233 | 33/15/7/3/2 ; 2021 | 85 | 3.847 | 31/30/11/6/7 ; 2022 | 104 | 4.212 | 59/25/10/3/7 ; 2023 | 64 | 3.766 | 23/20/10/5/6 ; 2024 | 30 | 3.933 | 13/10/1/4/2 ; 2025 | 16 | 3.625 | 9/0/2/2/3 ; 2026 (to 19 Aug) | 9 | 3.111 | 4/1/0/0/4
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-018 — The app is visibly unmaintained and users say so: 9 (2.44%, meaningful, mean 2.33) state it is no longer updated and 6 (1.63%, mean 1.50) that support does not answer; abandonment P1 0.9% → P2 1.4% → P3 5.0%, support-unresponsive P1 0.0% → P2 0.7% → P3 4.2%; 'that such a basic bug still isn't fixed after apparently a year (last update) is really not on' (DE, 2★); 'I know from Reddit that you aren't spending much time on this app anymore, but please fix this small necessary thing! I would pay for the premium version again in a heartbeat!' (US, 4★ — a user volunteering to pay again, blocked by a maintenance state); 'Your support pages and email are down' (GR, 1★, Aug 2026); 2026 mean 3.111 with 4 of 9 at one star

- **Where:** Executive summary 10; §3.5.4
- **This app does:** no updates for a year+; support pages down
- **User reaction:** churn
- **Magnitude:** abandon 9 (2.33); support 6 (1.50); P3 5.0% / 4.2%; 2026 3.111
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `12115176508`, `10462417239`, `14383965056`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C071 Never ship and walk away

### R54-031 — Observed price points verbatim from review text: US $15 (Jan 2021) → $13 (Sep 2021) → $14.00 (Apr 2021) → $9.99–$10 (mid-2022); GB £9 (2023); DE/AT €9.99 (2021), €10 (2022), €14.99 (Dec 2024), €15 (2025), €17 (Jun 2021); CN ¥100/¥98 (2021) → ¥68 (2022–24); TW NT$490 (2020); TH ฿399 (2025); BR R$25 (2023) — prices changed repeatedly in both directions in at least three currencies, so the 16 'too high' complaints are not comparable across years

- **Where:** §2.2 price table (verbatim) and reading
- **This app does:** one-time price varied $9.99–$15, €9.99–17
- **User reaction:** mixed
- **Magnitude:** Storefront | Price stated | ID · date ; US | $9.99 | 8850800577 (2022-07-07), 9104887436 (2022-09-20) ; US | $10 | 8896732201 (2022-07-21) ; US | $13 | 7793589747 (2021-09-11) ; US | $14.00 | 7253435778 (2021-04-23) ; US | $15 | 6883715554 (2021-01-18) ; GB | £9 | 9467299912 (2023-01-03) ; DE/AT | €9.99 | 7994144814 (2021-11-06) ; AT | €10 | 8724044306 (2022-05-30) ; DE | €14.99 | 12115176508 (2024-12-28) ; DE | €15 | 12549329908 (2025-04-16) ; DE | €17 | 7477741748 (2021-06-18) ; CN | ¥98 | 7250041973 (2021-04-22) ; CN | ¥100 | 6903744920 (2021-01-23) ; CN | ¥68 | 9023391633 (2022-08-27), 11111798656 (2024-04, asks if ¥68 is lifetime) ; TW | NT$490 | 6759577812 (2020-12-16) ; TH | ฿399 | 12201812878 (2025-01-19) ; BR | R$25 | 10137074917 (2023-07-13)
- **Direction for us:** research · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `6883715554`, `7793589747`, `7253435778`, `8850800577`, `9467299912`, `7994144814`, `12115176508`, `12549329908`, `7477741748`, `7250041973`, `9023391633`, `6759577812`, `12201812878`, `10137074917`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C113 One stable, disclosed price — no discount wheels

### R54-043 — The top three requests have been open for five to six years: the widget first asked 14 Oct 2020 (CN, 'may I ask if a widget feature could be added later?') and still on 27 May 2026 (US); long-range statistics first 2 Apr 2020 (GB) and again 5 Mar 2026 (CN) — not emerging needs but a six-year backlog, and reviewers have noticed

- **Where:** §3.4 observation (a)
- **This app does:** requests unanswered for six years
- **User reaction:** churn
- **Magnitude:** widget 2020-10 → 2026-05; stats 2020-04 → 2026-03
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `6534928843`, `14113474824`, `5751972817`, `13816292871`
- **Canonical:** C071 Never ship and walk away

### R54-095 — Severity callouts from single-review storefronts: TH (only Thai review, 1★) lifetime lost after reinstall with order ID and refund request; GR (only Greek, 3 Aug 2026, second-most-recent review) purchase lost, habit plans gone, 'Your support pages and email are down'; KR (only Korean, 3 Feb 2020, fifth-oldest) membership never unlocked, refund demanded — 'the purchase-entitlement failure is the oldest unresolved problem in this corpus (February 2020) and also the most recent (August 2026)'; Austria (6, 4.833) highest-rated, Colombia (2, 2.500) lowest — noise; 19 single-review storefronts mean 3.000, 7 of 19 one-star — ordinary long-tail behaviour, not a market signal

- **Where:** §6.8
- **This app does:** entitlement failure unresolved Feb 2020 → Aug 2026
- **User reaction:** 1★-burst
- **Magnitude:** Feb 2020 → Aug 2026; 19 single-review storefronts 3.000
- **Direction for us:** must-never-break · **Report confidence:** severity exception · **Generalisable:** generalisable
- **Review IDs:** `12201812878`, `14383965056`, `5481306690`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R54-100 — Trend 1 — widget demand more than doubled (emerging, high confidence): P1 8 (7.5%) → P2 12 (8.3%) → P3 21 (17.6%), the only request theme whose absolute count rises in P3 despite fewer reviews per month; tracks the platform — iOS 14 home-screen widgets Sep 2020, lock-screen widgets iOS 16 (2022), first widget request 14 Oct 2020, one month after iOS 14 — now a platform expectation

- **Where:** §7.2
- **This app does:** absent: widget
- **User reaction:** complaint
- **Magnitude:** 8 → 12 → 21 (7.5% → 8.3% → 17.6%)
- **Direction for us:** must-have · **Report confidence:** high confidence · **Generalisable:** generalisable
- **Canonical:** C023 Interactive widget check-off

### R54-101 — Trend 2 — the paid segment grew, then soured (meaningful, high confidence): paid_confirmed P1 5 (4.7%) → P2 19 (13.2%) → P3 20 (16.8%); over the same span paywall_value_gap 0 → 5 (3.5%) → 7 (5.9%); stats_too_basic 0 → 1 (0.7%) → 7 (5.9%); bug_calendar_stats_wrong 0 → 3 (2.1%) → 6 (5.0%); restore_purchase_failure 1 (0.9%) → 1 (0.7%) → 5 (4.2%) — four independent themes move together: as the installed base of payers grew, failures only payers can experience became a larger share; 'these are not launch problems, they are accumulated-base problems'; the P2 → P3 rating decline (4.139 → 3.739) is largely this

- **Where:** §7.3
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** paid 4.7% → 13.2% → 16.8%; value gap 0 → 3.5% → 5.9%
- **Direction for us:** must-never-break · **Report confidence:** high confidence · **Generalisable:** generalisable
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R54-102 — Trend 3 — abandonment signals appeared and define the recent period (meaningful, high confidence): abandonment_no_updates P1 1 (0.9%) → P2 2 (1.4%) → P3 6 (5.0%); support_unresponsive 0 → 1 (0.7%) → 5 (4.2%); escalation in specificity — 2023 'I know from Reddit that you aren't spending much time on this app anymore' → Dec 2024 'after apparently a year since the last update' → Jul 2025 'I dont think they are updating the app anymore. I reported an error over email and heard nothing back' → Jun 2026 'the provider doesn't respond / can't be reached' → Aug 2026 'Your support pages and email are down' — reviewers moved from inferring neglect to reporting a closed support channel; 2026 (n=9) four one-star, mean 3.111, the lowest year

- **Where:** §7.4
- **This app does:** support channel closed
- **User reaction:** churn
- **Magnitude:** abandon 0.9% → 1.4% → 5.0%; support 0 → 0.7% → 4.2%
- **Direction for us:** do · **Report confidence:** high confidence · **Generalisable:** generalisable
- **Review IDs:** `10462417239`, `12115176508`, `12871248376`, `14161103908`, `14383965056`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C071 Never ship and walk away

### R54-103 — Trend 4 — design praise declining as a share but not in kind (persistent, medium confidence): aesthetic_design P1 48 (45.3%) → P2 49 (34.0%) → P3 31 (26.1%), a 19-point fall — composition, not deterioration: no P3 reviewer says the design got worse and three say it is still excellent while rating 1–2★

- **Where:** §7.5
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 45.3% → 34.0% → 26.1%
- **Direction for us:** none · **Report confidence:** medium confidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-104 — Trend 5 — the habit-cap complaint softened (changing, medium confidence): free_habit_limit_complaint P1 15 (14.2%) → P2 18 (12.5%) → P3 11 (9.2%); price_too_high 7.5% → 2.8% → 3.4%; two candidate explanations the corpus cannot separate — the US price fell ~$15 (2021) → $9.99–10 (2022), or later reviewers are existing users who already resolved the paywall decision; runs opposite to the rating decline, reinforcing that the P3 drop is post-purchase failure, not pricing

- **Where:** §7.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** cap 14.2% → 12.5% → 9.2%; price 7.5% → 2.8% → 3.4%
- **Direction for us:** none · **Report confidence:** medium confidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-105 — Trend 6 — displacement wins declining (changing, medium confidence): comparative_best P1 12 (11.3%) → P2 17 (11.8%) → P3 6 (5.0%); same direction in no_streak_shame_free (3.8% → 4.2% → 1.7%) and req_apple_watch (1.9% → 4.2% → 0.8%) — consistent with competitors closing the design gap and a product that stopped shipping; 6 reviews in 44 months, a signal to watch

- **Where:** §7.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 11.3% → 11.8% → 5.0%
- **Direction for us:** none · **Report confidence:** medium confidence · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

### R54-106 — Trend 7 — outcome reports peaked in P2 (persistent, medium confidence): outcome_behavior_change P1 10 (9.4%) → P2 24 (16.7%) → P3 15 (12.6%), never below 9%, third-largest theme in every period — 'whatever is wrong with this product in P3, it is not that the app stopped helping people build habits'

- **Where:** §7.8
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 9.4% → 16.7% → 12.6%
- **Direction for us:** none · **Report confidence:** medium confidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

## Positioning

### R54-001 — Avocation - Habit Tracker (App Store ID 1479581895; subtitle 'Daily planner & ADHD organizer') by David Joech (bundle app.avocation.avocation) — 369 written reviews, 43 storefronts, 21 Dec 2019 → 19 Aug 2026, mean 3.981, extracted 8 Sep 2026, analysed 12 Sep 2026; business model (review-derived): free download, hard free-tier cap of 3 habits (reported inconsistently), one-time 'lifetime' Pro unlock, no subscription, no ads; Pro prices in review text span $9.99–$15 / £9 / €9.99–17 / ¥68–98 / NT$490 / ฿399 / R$25; 44 reviewers (11.92%) state they paid; a beautiful product (coloured bubbles, a growing plant watered by habits, an avocado mascot, no streaks) with a monetisation wound

- **Where:** header lines 1-8
- **This app does:** free 3 habits; one-time lifetime Pro; no ads
- **User reaction:** mixed
- **Magnitude:** 369 reviews; 44 payers (11.92%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-038 — Displacement 35 (9.49%, high-priority, mean 4.83, 2020-01 → 2025-08): 'I literally downloaded 30 different habit/productivity/tracker apps… and this is the only one that came remotely close'; 'I was coming from using one of the most popular habit forming applications available and not being very satisfied'; 'I have tried veeeery many such apps and this is my absolute favourite' (AT); 'A very beautiful app that doesn't crash like most habit tracker on the app store' (GB) — 35 churned into this product; it wins the evaluation

- **Where:** §3.3.4
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 35 (9.49%, 4.83)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `9195522591`, `8528259165`, `8724044306`, `5437542593`, `8416681749`, `12549329908`, `9289083496`, `10397650094`, `6005898826`, `8266492113`
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R54-012 — 'Advanced Statistics' is a promise the Pro tier does not keep: 12 reviewers (3.25%, very strong, mean 2.58) describe a gap between what they paid for and what they got, 10 of 12 confirmed payers (22.7% of the payer segment); three quote the marketing phrase back — 'I bought this app bcs it stated advanced statistics for paid version. But I can not call these statistics even basic' (AL, 2★); 'pro which I paid for touts Advanced Statistics but all I see is a calendar' (AU, 4★); 'Although I bought Pro, there are no advanced statistics' (DE, 2★); 8 (2.17%) call the statistics too basic and 28 (7.59%, high-priority) request longer-range history — a copy-versus-product mismatch that converts buyers into detractors rather than churners, 'which is worse, because they review'

- **Where:** Executive summary 4; §5.3
- **This app does:** paid tier advertises 'Advanced Statistics' that is a calendar
- **User reaction:** 1★-burst
- **Magnitude:** value gap 12 (3.25%, 2.58), 10 payers (22.7%); basic stats 8; history 28 (7.59%)
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `12680052718`, `9622751603`, `10904975030`
- **Canonical:** C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R54-030 — The free-tier cap is reported inconsistently, and that is a finding (verbatim table): 3 habits the majority (18 IDs across AU, CA, CO, DE, GB, KZ, PH, UA, US); 5 habits 3 (KR 2020-02, MX 2020-06, US 2020-07); 6 tasks 1 (US 2021-11); 2 habits 2 (CN 2020-12 reports the cap reduced from 3 to 2 — 'my three habits got cut down to two', 2★; BR 2023-07); 1 habit 3 (DE 2021, US 2023, GB 2023); listing said 5, app gave 3 — 'I thought the free account supports 5 habits? Seems like it would not let me create more than 3… the app description' (CA, 2020-09, the load-bearing record); parsimonious reading: the cap was reduced over time (5 in early-to-mid 2020 → 3 from late 2020), with 1–2 a further restriction, a bug or a specific gated thing

- **Where:** §2.2 free-cap inconsistency table (verbatim) and reading
- **This app does:** free cap cut 5 → 3 (late 2020); listing disagreed with app
- **User reaction:** complaint
- **Magnitude:** Stated free cap | Reviews | IDs ; 3 habits | majority | 13322355351(AU), 12197119033(CA), 6866535908(CO), 8650917907(DE), 9384744042(DE), 7076973873(GB), 9467299912(GB), 12216535984(KZ), 7755528602(PH), 8512814711(UA), 8784039212(UA), 6883715554(US), 8285309663(US), 8539804473(US), 8850800577(US), 8924643400(US), 9785525158(US), 9923863917(US) ; 5 habits | 3 | 5481306690(KR, 2020-02), 6039511469(MX, 2020-06), 6249084137(US, 2020-07) ; 6 tasks | 1 | 8079025146(US, 2021-11) ; 2 habits | 2 | 6769790710(CN, 2020-12 — reports the cap being *reduced* from 3 to 2), 10137074917(BR, 2023-07) ; 1 habit / 1 goal | 3 | 7203350768(DE, 2021-04), 9681921999(US, 2023-03), 10626782902(GB, 2023-11) ; Listing said 5, app gave 3 | 1 | 6429113832(CA, 2020-09) — *"I thought the free account supports 5 habits? Seems like it would not let me create more than 3. Just an consistency of app function and the app description."*
- **Direction for us:** product-rule · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `6769790710`, `6429113832`, `5481306690`, `6039511469`, `6249084137`, `10137074917`, `7203350768`
- **Canonical:** C001 Never move a free feature behind the paywall; C191 Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R54-077 — Trigger (e) the advertised Pro feature: two payers bought specifically for statistics and both were disappointed — the only trigger with a 100% dissatisfaction rate (n=2, not a rate to generalise)

- **Where:** §5.2 (e)
- **This app does:** bought for Advanced Statistics
- **User reaction:** 1★-burst
- **Magnitude:** 2 of 2 disappointed
- **Direction for us:** product-rule · **Report confidence:** segment note · **Generalisable:** generalisable
- **Review IDs:** `12680052718`, `9633840491`
- **Canonical:** C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R54-123 — Three separate listing-versus-product disagreements reported by reviewers: 'Advanced Statistics' that is a calendar; a €2.50 subscription on the listing the app did not sell; a 5-habit free tier on the listing when the app gave 3 (listing_mismatch 2, 0.54%)

- **Where:** §8.2 D2 listing mismatch; §2.2
- **This app does:** listing out of sync with product
- **User reaction:** blocked-conversion
- **Magnitude:** 3 disagreements
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `12680052718`, `7477741748`, `6429113832`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Things not to do

### R54-054 — Upgrade nag including after paying (paywall_prompt_friction 5, 1.36%, 2.80); non-habit gating of colours, pots and reminders resented (nonhabit_gating_complaint 8, 2.17%, 3.00); told to upgrade with no way to (upgrade_flow_broken 1)

- **Where:** §3.5.1 paywall_prompt_friction; nonhabit gating
- **This app does:** upgrade prompts; cosmetic gates
- **User reaction:** complaint
- **Magnitude:** 5 / 8 / 1
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C009 Basic widgets, icons and colours are free; C093 No upsell nagging without a 'never ask again' option; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps

## Things to do

### R54-020 — The cheapest high-value moves in evidence order: fix restore-purchases and make it discoverable (12, mean 1.083, every one recoverable) → fix or remove the 'infinity days until next growth' plant state → build the 'Advanced Statistics' the paid tier advertises or stop advertising it (12, 10 payers) → raise the free cap from 3 to 5–7, the range reviewers themselves propose (four name 5–8) → ship a widget (41, rising, a named purchase blocker) → add 'X times per week' frequency and past-day backfill (37, 10.03%) → publish a maintenance signal of any kind

- **Where:** Executive summary 12
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** as listed
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `8285309663`, `8784039212`, `7824596230`, `6249084137`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C010 Backfill missed days / edit start date; C023 Interactive widget check-off; C033 Restore purchase and entitlements must work immediately; C043 Flexible / custom frequency; C071 Never ship and walk away; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature; C273 The reward mechanic must never silently stall — a plant, pet or garden that stops growing reads as the app taking the reward away

### R54-113 — F6: publish any maintenance signal at all — abandonment P1 0.9% → P3 5.0%; a 4★ offers to pay again and is blocked only by believing the app is abandoned; a single update with a changelog changes the most damaging recent theme

- **Where:** §8.1 F6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 0.9% → 5.0%
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `10462417239`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C071 Never ship and walk away

## Contradictions

### R54-124 — The corpus contradicts the assumption that a tight free cap drives conversion: the payer and cap-complaint rates are identical in high-volume markets (11.9% each), cap complaints soften over time while the rating falls, and 1★ reviews are dominated by people who paid, not by people who refused to pay — the rating damage is post-purchase delivery, not the gate

- **Where:** §3.4 #3 + §8.2 D5; §3.5.5 churn; §6.11
- **This app does:** 3-habit cap
- **User reaction:** mixed
- **Magnitude:** paid 11.9% = cap 11.9%; 1★ 38.7% payers vs 19.4% cap
- **Direction for us:** research · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C065 Paying customers are the highest 1★ risk — every paid feature must work

## Data caveats and method

### R54-002 — Method: all 369 records read individually in full in original language (English, German 36, Simplified Chinese 24, Traditional Chinese 11, Spanish 17 + Latin America, Ukrainian and Russian 18, Portuguese 10, Italian 7, Turkish 7, Polish 4, Arabic 3, Thai 1, Vietnamese 4, French 1) in nine passes of ~40; 47 (12.74%) non-Latin script; 90 hand-curated themes, 1,079 assignments, mean 2.92 per review (max 11, 90 with exactly one), no regex or clustering; validated 0 unknown indices, 0 intra-theme duplicates, every theme with a family, 0 unassigned; reconciliation exact against 43 by_country files and manifest (5★ 173 / 4★ 101 / 3★ 41 / 2★ 23 / 1★ 31; mean 3.9810); 0 duplicate title+body pairs; 53 of 96 queried storefronts returned zero reviews (jp, hk, ie, ch among them — absence of written reviews, not of the app); census as of 8 Sep 2026; keyword sweep for price tokens and cap statements used as an audit of the hand map, not a classifier; every cited ID verified (§9.7); denominator 369 (one review = 0.27%); signal bands <0.1% ignore · 0.1–0.5% weak · 0.5–1% emerging · 1–3% meaningful · 3–5% very strong · >5% high-priority; HTML entities not decoded in source; known error risk at request vs complaint, paid_confirmed (a floor — ambiguous 'I highly recommend the paid version' excluded) and translation nuance

- **Where:** §How to read this; §1.1–1.3, §1.5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 369 (100%)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `8175155082`, `6901836301`, `6231173329`
- **Canonical:** — (nuance register)

### R54-003 — Only one storefront clears 50 reviews: US 119 (32.25%); next Germany 36, Great Britain 31, China 24, Ukraine 18, Spain 17, Canada 16 — exactly one standalone country claim (US); every other storefront limited evidence, percentages for shape only

- **Where:** §Eight warnings 1; §1.6 #2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** US 119 (32.25%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-005 — No review burst, vote manipulation or duplicate authors: 369 reviews across 324 days, busiest day 4, no author name twice; 53 (14.36%) carry a helpfulness vote, max vote_sum 6; is_edited true on 3 but a US review contains a literal EDIT block while flagged false, so is_edited is unreliable and unused; no reviewer mentions being asked or paid for a review

- **Where:** §Eight warnings 4; §1.6 #5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 53 voted (14.36%); max vote 6
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `9061891888`, `6980535429`, `7624659981`, `8986983542`
- **Canonical:** — (nuance register)

### R54-006 — The corpus over-weights the moment of first contact with the paywall: median body 164 characters, 82 of 369 (22.22%) at 60 characters or shorter; the most common complaint (3-habit cap) is hit in the first session — the corpus says a lot about why people do and do not convert and much less about why people stay; retention evidence is limited to 9 reviewers (2.44%) who state a duration of use

- **Where:** §Eight warnings 5; §1.6 #1
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** median 164 chars; 82 ≤60 (22.22%); 9 duration statements
- **Direction for us:** none · **Report confidence:** interpretation · **Generalisable:** generalisable
- **Canonical:** C147 Let people use the product before they pay

### R54-007 — No external source usable: itunes lookup (HTTP 403 from proxy) and apps.apple.com (EGRESS_BLOCKED) both refused on 12 Sep 2026 and no cached listing in the repo — every statement about price, cap, feature set and Pro contents is derived from review text, a reconstruction of what users believed they were buying; contradictions reported, not resolved; no version field, so bugs cannot be tied to builds and 'fixed' cannot be distinguished from 'stopped being reported'

- **Where:** §Eight warnings 7; §2.3; §1.6 #3
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-008 — Star rating is not a feature preference: aesthetic_design (128) appears in 9 two-star reviews; confirmed payers average 3.091 against a corpus mean of 3.981; eleven reviews at 4★ or better report a defect, value gap or abandonment signal

- **Where:** §Eight warnings 8; §1.6 #8
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 9 two-star design praise; payers 3.091 vs 3.981
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

### R54-033 — Theme-family aggregates, unique reviewers (verbatim): praise UX 167 (45.26%); any paywall or pricing friction 85 (23.04%); praise core mechanic 68 (18.43%); product friction (bugs excluded) 66 (17.89%); request platform 58 (15.72%); request content/delight 58 (15.72%); outcome 55 (14.91%); request habit modelling 44 (11.92%); confirmed payers 44 (11.92%); request insight/history 43 (11.65%); monetisation positive 42 (11.38%); displacement 35 (9.49%); any bug 31 (8.40%, mean 2.677); post-purchase failure 12 (3.25%, mean 1.083 — the lowest); the 90-theme master table is reproduced in §9.2 rather than here

- **Where:** §3.1 table (verbatim); §3.2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Family | Unique reviewers | % of 369 | Signal | Reading ; Praise — UX | 167 | 45.26% | high-priority | Design, simplicity and ease of use are what the corpus is mostly about ; Any paywall or pricing friction | 85 | 23.04% | high-priority | Almost one reviewer in four raises money ; Praise — core mechanic (plant, avocado, no-streaks, lessons, water, reminders) | 68 | 18.43% | high-priority | The differentiators land ; Product friction (bugs excluded) | 66 | 17.89% | high-priority | Thin statistics, unmaintained, confusing onboarding ; Request — platform (widget, watch, iPad, dark mode, sync, Health) | 58 | 15.72% | high-priority | The largest single request bloc ; Request — content/delight | 58 | 15.72% | high-priority | Reordering, icons, plants, reminders ; Outcome (behaviour change, sustained use) | 55 | 14.91% | high-priority | Direct evidence the product works when it works ; Request — habit modelling | 44 | 11.92% | high-priority | Frequency, backfill, quitting, undo ; Confirmed payers | 44 | 11.92% | high-priority | The segment analysed in Part 5 ; Request — insight/history | 43 | 11.65% | high-priority | Statistics, per-habit records, streaks ; Monetization — positive | 42 | 11.38% | high-priority | One-time model, fair price, generous free tier, no ads ; Displacement (tried others, chose this) | 35 | 9.49% | high-priority | Comparative, therefore strong, evidence ; Any bug reported | 31 | 8.40% | high-priority | Mean ★ 2.677 ; Post-purchase failure | 12 | 3.25% | very strong | Mean ★ 1.083 — the lowest in the report
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-065 — Distribution 5★ 173 (46.88%) · 4★ 101 (27.37%) · 3★ 41 (11.11%) · 2★ 23 (6.23%) · 1★ 31 (8.40%), genuinely spread; 5★ table (verbatim): aesthetic_design 76 (43.9%), outcome_behavior_change 40 (23.1%), simplicity_minimalism 38 (22.0%), comparative_best 30 (17.3%), ease_of_use 29 (16.8%), generic_praise 21 (12.1%), plant_growth_motivation 20 (11.6%), req_widget 19 (11.0%), advocacy 17 (9.8%), price_fair 14 (8.1%), onetime_purchase_praise 13 (7.5%), paid_confirmed 12 (6.9%) — why people give five stars: beautiful, changed a behaviour, not overwhelming, beat the alternatives; the anomaly — 19 five-star reviewers ask for a widget, plus customisation 9 (5.2%), plant variety 3, long-range stats 7

- **Where:** Part 4 distribution; §4.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of 173 ; aesthetic_design | 76 | 43.9% ; outcome_behavior_change | 40 | 23.1% ; simplicity_minimalism | 38 | 22.0% ; comparative_best | 30 | 17.3% ; ease_of_use | 29 | 16.8% ; generic_praise_no_detail | 21 | 12.1% ; plant_growth_motivation | 20 | 11.6% ; req_widget | 19 | 11.0% ; advocacy_recommend | 17 | 9.8% ; price_fair_praise | 14 | 8.1% ; onetime_purchase_praise | 13 | 7.5% ; paid_confirmed | 12 | 6.9%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-071 — Rating / text contradictions 11 (2.98%, meaningful), all 4★ or 5★ carrying a serious negative, none the other way (verbatim table: paid Advanced Statistics not delivered, AU 4★; not sure it's worth the premium, CA 4★; €9.99 doesn't buy enough, DE 4★; forced to switch apps — no Watch, DE 4★; won't stick — no widget, PH 4★; plants gone, pages broken, 'please update', UA 4★; free version not useful, US 5★; paid statistics calendar all wrong, US 5★; 'unusable for me', US 4★; no longer maintained, US 4★; statistics filters incorrect, US 4★) — the star rating systematically understates severity; a rating-only dashboard would miss every one

- **Where:** §4.6 table (verbatim) and reading
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ID | Store | ★ | Date | Contradiction ; 9622751603 | AU | 4 | 2023-02-16 | Paid, "Advanced Statistics" not delivered ; 9926867882 | CA | 4 | 2023-05-14 | Bought it, "not sure it's worth the premium price" ; 7994144814 | DE | 4 | 2021-11-06 | €9.99 doesn't buy enough function ; 8902552282 | DE | 4 | 2022-07-23 | Forced to switch apps (no Apple Watch) ; 11512811846 | PH | 4 | 2024-07-20 | Will not stick with it (no widget) ; 11914776863 | UA | 4 | 2024-11-05 | Plants gone, pages broken, "please update" ; 8285309663 | US | 5 | 2022-01-26 | "the free version is pretty much not useful" ; 8986983542 | US | 5 | 2022-08-17 | Paid-tier statistics calendar "all wrong" ; 9511531312 | US | 4 | 2023-01-15 | "making This app unusable for me" ; 10462417239 | US | 4 | 2023-10-11 | App no longer maintained ; 10586770261 | US | 4 | 2023-11-15 | Statistics filters incorrect
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `9622751603`, `9926867882`, `7994144814`, `8902552282`, `11512811846`, `11914776863`, `8285309663`, `8986983542`, `9511531312`, `10462417239`, `10586770261`
- **Canonical:** — (nuance register)

### R54-099 — Trend method — three contiguous periods of comparable size (verbatim): P1 2019-12-21 → 2021-06-30 n=106 (28.73%) mean 4.038; P2 2021-07-01 → 2022-12-31 n=144 (39.02%) 4.139; P3 2023-01-01 → 2026-08-19 n=119 (32.25%) 3.739; limits — P3 covers 44 months against 19 and 18; no version field; a 2-point move is 2–3 reviews and not a trend; every trend labelled with confidence

- **Where:** §7.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Period | Window | n | % of corpus | Mean ★ | 5/4/3/2/1 ; P1 | 2019-12-21 → 2021-06-30 | 106 | 28.73% | 4.038 | 51/27/15/7/6 ; P2 | 2021-07-01 → 2022-12-31 | 144 | 39.02% | 4.139 | 73/43/13/5/10 ; P3 | 2023-01-01 → 2026-08-19 | 119 | 32.25% | 3.739 | 49/31/13/11/15
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R54-107 — What the corpus cannot tell about time: nothing tied to a release; whether anything was fixed (bug_water_tracker last Aug 2020, bug_crash_lag last Feb 2022 — fix or nobody reporting); whether the 2026 rating collapse is real (n=9; individually meaningful one-stars, not a measurement); why volume fell 91% 2022 → 2026

- **Where:** §7.9
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 2026 n=9
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Canonical:** — (nuance register)
