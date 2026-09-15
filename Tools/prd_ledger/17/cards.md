# Cards — report 17

Source: `App Store Reports/17. Daily Routine - Organise your time into blocks (REPORT).md`  
58 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 5
- [Must-haves](#must-haves) — 2
- [Must never break](#must-never-break) — 5
- [Features](#features) — 9
- [Monetization](#monetization) — 5
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 8
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 2
- [Dated events and trends](#dated-events-and-trends) — 8
- [Positioning](#positioning) — 3
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 1
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 4

## Product rules

### R17-005 — The largest negative theme: you cannot try the app at all — 'Was excited to use this just to find out that I can't because it's not free??'; 'I couldn't get out of the payment subscription page'; 'the free trial is entirely unusable without going through payment confirmation. Can't even look at the settings or examine how the app will handle cancelation' — none of the seven describes the product; they rated an app they never saw; the 'Free · In-App Purchases' label sets the expectation; a user who cannot inspect the cancellation flow before committing must trust blind a developer who already abandoned once

- **Where:** Part 0 §3 The single largest negative theme: you cannot try the app at all
- **This app does:** hard paywall on first launch; trial gated behind payment confirmation
- **User reaction:** 1★-burst
- **Magnitude:** 7 (18.42%) mean 1.14, 6 of 7 1★ — lowest-rated theme
- **Direction for us:** product-rule · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `8863711662`, `10621025077`, `10024637302`, `12167506108`, `9992175230`, `9471017050`, `9289248731`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C147 Let people use the product before they pay; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R17-007 — Five reviewers object to the shift from one-time purchase to subscription — 'you broke functionality and ditched support for the old classic version I bought; to make this version that costs considerably more up-front, forcing people to subscribe… That is disgusting' — and one alleges the classic app was deliberately broken ('a special dialog: Crashing in 5 seconds'); treated as reported perception, not established fact, but a paying customer publicly concluded the developer sabotaged a product they had bought

- **Where:** Part 0 §4 5 reviewers object to the shift from one-time purchase to subscription; sabotage allegation (reported perception, not fact)
- **This app does:** one-time → subscription; classic left broken
- **User reaction:** 1★-burst
- **Magnitude:** sub-model objection 5 (13.16%) mean 1.40; sabotage allegation n=1
- **Direction for us:** product-rule · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `8874399635`, `9289248731`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C186 Never revoke what earlier buyers paid for when the model changes

### R17-043 — Open a real free tier or a genuinely inspectable trial — let users build a schedule before any payment wall, and make the cancellation flow visible before payment details are taken; 5 of 12 one-star reviews come from people who never saw the product

- **Where:** §8.1 I1 Open a real free tier or a genuinely inspectable trial — cancellation flow visible before payment details are taken
- **This app does:** hard paywall
- **User reaction:** blocked-conversion
- **Magnitude:** N1 7 (18.42%) mean 1.14; payers 3.63 vs blocked 1.14
- **Direction for us:** product-rule · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `9289248731`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C112 In-app cancellation; C147 Let people use the product before they pay

### R17-052 — Offer classic buyers something even now — a discount, a credit or a free year (the reviewer listed three remedies; none done; the omission produced the angriest cluster from the most loyal historical customers); and never break a legacy app you are migrating away from — a paying customer publicly concluded the developer sabotaged a product they owned, and that perception is permanent

- **Where:** §8.3 M2 Offer classic buyers something, even now — a discount, a credit, or a free year; M3 Never break a legacy app you are migrating away from
- **This app does:** no migration offer; classic left broken
- **User reaction:** 1★-burst
- **Magnitude:** N4 6 (15.79%) mean 1.17
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `11033875205`, `9289248731`, `8776556254`, `7849996761`
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

### R17-053 — Tie subscription pricing to a visible delivery cadence — 'If we can get iPad and watch apps along with more regular debugging, I will keep paying'; subscribers here believe they are funding development, and when it stops the subscription has no story

- **Where:** §8.3 M4 Tie subscription pricing to a visible delivery cadence — subscribers believe they are funding development
- **This app does:** subscription without delivery
- **User reaction:** churn
- **Magnitude:** N6 5 (13.16%); N8 4
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13441826130`
- **Canonical:** C196 A subscription is a promise of continued delivery — back it with a visible cadence

## Must-haves

### R17-012 — The product is hard to learn and the corpus names the words that confuse people — 'what is a sequence? What is a block? What is an activity? What's the difference between them?'; 'I deleted it after trying to make it work for a good 30 minutes'; satisfied users confirm the curve is real but surmountable ('takes a day of experimenting'; 'very different UI than all the other apps… once you get it you'll love it') so the problem is onboarding, not design — a day of experimenting is what the product asks, and a hard paywall demands payment before that day

- **Where:** Part 0 §7 The product is hard to learn, and the corpus says exactly which words confuse people; a day of experimenting vs a hard paywall
- **This app does:** unique block/sequence/activity model; no tutorial; paywall before learning
- **User reaction:** complaint
- **Magnitude:** learning curve 7 (18.42%) mean 3.43 (2★–5★); no tutorial 3 (7.89%)
- **Direction for us:** must-have · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `8827339965`, `8644242601`, `8013032927`, `7866331165`, `7988825337`, `8557538403`
- **Canonical:** C075 Skippable, replayable onboarding tour; C147 Let people use the product before they pay

### R17-044 — Ship an onboarding tutorial that defines block, activity and sequence — one reviewer wrote the content brief; the curve is real but surmountable ('a day of experimenting') and a paywall that demands payment before that day is fatal

- **Where:** §8.1 I2 Ship an onboarding tutorial that defines block, activity and sequence — use the reviewer's content brief verbatim
- **This app does:** no tutorial; unique vocabulary
- **User reaction:** complaint
- **Magnitude:** N3 7 (18.42%); N9 3 (7.89%)
- **Direction for us:** must-have · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `8827339965`, `7866331165`, `8644242601`
- **Canonical:** C075 Skippable, replayable onboarding tour

## Must never break

### R17-008 — The most consequential finding: abandoned once, relaunched on a subscription, abandoned again while still charging — current version 1.1.4 released 9 Jan 2023, more than three and a half years without an update; 'I'm getting tired of the paywall with zero app updates. If we can get iPad and watch apps along with more regular debugging, I will keep paying. Otherwise, I am switching to Blocos when they develop a calendar integration' (the single most actionable review: continued payment contingent on continued development, competitor and trigger feature named); the corpus closes on 'Obsolete. Where's the updates? I want my Daily Routine Classic back'

- **Where:** Part 0 §5 The app was abandoned once, relaunched on a subscription, and has now been abandoned again — while still charging
- **This app does:** subscription charged on an app unupdated for 3.5+ years
- **User reaction:** churn
- **Magnitude:** abandonment 4 (10.53%); last release 9 Jan 2023
- **Direction for us:** must-never-break · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `13193213543`, `13441826130`, `13120304447`, `14384355988`, `7849996761`
- **Canonical:** C071 Never ship and walk away; C196 A subscription is a promise of continued delivery — back it with a visible cadence

### R17-017 — Two precise structural defects, each reported independently by two engaged 4★ users: a single instance of a repeating block cannot be edited or deleted ('I can only change ALL workout blocks in the sequence for today and everyday going forward'), and editing a block in reality view does not cascade to following blocks ('getting ready for work will overlap with the workout block, rather than being pushed to 7:16am') — both break the promise the app is sold on: a time-blocking app whose blocks cannot absorb a real day's slippage fails when most needed; 'If these two features are added it is definitely 5⭐️'

- **Where:** §2.1 Two precise structural defects — a single instance of a repeating block cannot be edited or deleted; editing in 'reality' view does not cascade
- **This app does:** no single-instance edit; no cascade on slip
- **User reaction:** complaint
- **Magnitude:** 2 (5.26%) mean 4.00, both 4★
- **Direction for us:** must-never-break · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `7780256223`, `8557538403`
- **Canonical:** C198 Edit one instance of a repeating block without changing the series; a slipped block pushes the ones after it

### R17-034 — The corpus documents a complete churn cycle among payers — paid and waited ('I kept my subscription going for a few months hoping it would approach quality of legacy app'), paid and could not learn it, still paying while evaluating a competitor, loved it and watching it decay; churn driver #1 is non-delivery of continued development, not a product defect — users bought a trajectory and the trajectory stopped; notably absent in all 38: any refund request, charge-after-cancel, failed restore or billing error — the payment plumbing works, the value proposition behind it does not; the one support interaction converted perfectly — the problem is not capability or care, it is sustained capacity

- **Where:** §5.4 Post-purchase experience and churn — a complete churn cycle; churn driver #1 is non-delivery of continued development; the payment plumbing works
- **This app does:** subscription with no delivery; billing clean
- **User reaction:** churn
- **Magnitude:** 4 churn narratives; 0 billing complaints of 38; 1 support interaction → 5★
- **Direction for us:** must-never-break · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `8776556254`, `8827339965`, `13441826130`, `13193213543`, `8244932708`
- **Canonical:** C029 Billing must be exactly right; C059 Be visibly responsive; fixes bring reviewers back; C196 A subscription is a promise of continued delivery — back it with a visible cadence

### R17-045 — Fix single-instance editing of repeating blocks and make reality edits cascade to later blocks — two independent, precisely specified reports from 4★ users; a time-blocking app whose blocks can't absorb slippage fails at its core promise

- **Where:** §8.1 I3 Fix single-instance editing of repeating blocks, and make 'reality' edits cascade
- **This app does:** no single-instance edit; no cascade
- **User reaction:** complaint
- **Magnitude:** N11 2 (5.26%), both 4★
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `7780256223`, `8557538403`
- **Canonical:** C198 Edit one instance of a repeating block without changing the series; a slipped block pushes the ones after it

### R17-046 — Ship something — a dated changelog and a public roadmap immediately: charging a monthly subscription against a 3.5-year-old build is the central credibility problem; and decide the app's future honestly and say so publicly — if development cannot resume, stop selling the $64.99 'lifetime' tier, which compounds the exact grievance that produced five one-star reviews

- **Where:** §8.1 I4 Ship something. Anything. A dated changelog and a public roadmap; §8.1 I5 Decide the app's future honestly — stop selling the lifetime tier if development cannot resume
- **This app does:** subscription + lifetime sold on a dormant build
- **User reaction:** churn
- **Magnitude:** N8 4 (4 of last 6 reviews); N5 5; last release 9 Jan 2023
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `13441826130`, `7849996761`
- **Canonical:** C071 Never ship and walk away; C196 A subscription is a promise of continued delivery — back it with a visible cadence

## Features

### R17-010 — The one capability named as unique to this app is global schedule shifting — 'there is no other app that allows you to easily globally shift a schedule, rather than moving all tasks individually. Invaluable for my erratic work and sleep schedule… jet lag or sleep problems'; the one competitor that came close (Sorted) failed because it collected unchecked tasks and froze — this is the product's moat, stated once, and it appears nowhere in the store listing

- **Where:** Part 0 §6 The one capability named as unique: global schedule shifting — the product's moat, stated once, absent from the listing
- **This app does:** global schedule shift (shift the whole day at once)
- **User reaction:** praise
- **Magnitude:** n=1 (2.63%), high-value
- **Direction for us:** must-have · **Report confidence:** n=1 · **Generalisable:** yes
- **Review IDs:** `7886496270`
- **Canonical:** C197 Shift the whole day's schedule at once (global schedule shift)

### R17-015 — Feature inventory: timeline day view of time blocks; 'blocks', 'activities' and 'sequences' as core objects; repeatable sequences; global schedule shift; colour categories + emoji; per-block alarms; a 'reality' view of what actually happened vs planned; 'planning eras'; schedule separate from system calendar; absent or removed: calendar integration (present in classic, removed — still blocking in 2025), iPad, Mac, Apple Watch, iCloud sync, in-app tutorial

- **Where:** §2.1 Feature inventory derived from reviews table (verbatim); confirmed absent or removed
- **This app does:** see table
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence | Confidence ; Timeline day view — schedule laid out as time blocks | `7859394020`, `9504102829`, `10884354864`, `13441826130`, `11035825108` | High ; "Blocks", "activities" and "sequences" as the core objects | `8557538403`, `8827339965`, `10884354864` | High ; Repeatable sequences (e.g. a morning routine) duplicated across days | `8557538403`, `10884354864`, `7780256223` | High ; Global schedule shift — move an entire schedule at once | `7886496270` | Medium (single source, but detailed) ; Colour categorisation + emoji bullets for activity types | `7859394020` | Medium ; Per-block configurable alarms / notifications | `8557538403`, `9504102829`, `10884354864` | High ; "Reality" view — what actually happened vs what was planned | `8557538403` | Medium (single source, detailed) ; "Planning eras" | `10884354864` | Low (single source) ; Schedule kept separate from the system calendar | `7859394020` | Medium ; absent: calendar integration, iPad, Mac, Watch, iCloud sync, tutorial
- **Direction for us:** research · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `7859394020`, `9504102829`, `10884354864`, `8557538403`, `8827339965`, `7780256223`, `7886496270`, `7780256223`, `8275228824`, `9957602682`, `13441826130`, `11035825108`, `8013032927`
- **Canonical:** — (nuance register)

### R17-016 — Calendar integration was present in the classic version and removed in the relaunch ('the calendar integration is no more. I loved seeing my appointments, too') — and in 2025 it is the named trigger for switching to a competitor

- **Where:** §2.1 Calendar integration — present in the classic version, removed in this one, still blocking in 2025
- **This app does:** removed calendar integration
- **User reaction:** churn
- **Magnitude:** 2 reviews across 2021–2025
- **Direction for us:** must-have · **Report confidence:** n=2 · **Generalisable:** yes
- **Review IDs:** `7780256223`, `13441826130`
- **Canonical:** C199 System calendar integration — see appointments inside the plan

### R17-020 — Design praised; per-block notifications that cue the next activity praised (both 5★); bugs, crashes and black screens across the lifespan

- **Where:** §3.1 P3 Design, look and feel; P5 Per-block notifications cue the next activity; N2 Bugs, crashes, black screens
- **This app does:** timeline with per-block cues
- **User reaction:** mixed
- **Magnitude:** P3 6 (15.79%) 4.17; P5 2 (5.26%) 5.00; N2 7 (18.42%) 2.14
- **Direction for us:** must-never-break · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `9504102829`, `10884354864`, `9086558708`, `9244113250`, `8776556254`, `13193213543`
- **Canonical:** C031 Crashes / launch failures; C039 Reminders fire reliably, once; C120 Sequential routine timer with spoken next step and live finish-time estimate

### R17-022 — Every request: iPad app (3), edit/delete a single instance of a repeating block (2), restore calendar integration (2), Apple Watch (2), in-app tutorial (3), Mac app, iCloud sync, cascading time adjustment in reality view, auto-calculate latest start time for a sequence, larger timeline showing time remaining, restore unspecified classic features

- **Where:** §3.3 Unmet needs — every request in the corpus table (verbatim)
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 8 (21.05%) mean 4.12; Request | n | IDs ; iPad app | 3 | `8275228824`, `9957602682`, `13441826130` ; Edit/delete a single instance of a repeating block | 2 | `7780256223`, `8557538403` ; Calendar integration (restore) | 2 | `7780256223`, `13441826130` ; Apple Watch app | 2 | `11035825108`, `13441826130` ; In-app tutorial | 3 | `8013032927`, `8644242601`, `8827339965` ; Mac app | 1 | `7859394020` ; iCloud sync | 1 | `9957602682` ; Cascading time adjustment in "reality" view | 1 | `8557538403` ; Auto-calculate the latest start time for a sequence | 1 | `8557538403` ; Larger timeline showing time remaining in current activity | 1 | `11035825108` ; Restore unspecified classic features | 1 | `8013032927`
- **Direction for us:** research · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `8275228824`, `9957602682`, `13441826130`, `7780256223`, `8557538403`, `11035825108`, `8013032927`, `8644242601`, `8827339965`, `7859394020`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C075 Skippable, replayable onboarding tour; C120 Sequential routine timer with spoken next step and live finish-time estimate; C141 Native iPad layout; C198 Edit one instance of a repeating block without changing the series; a slipped block pushes the ones after it; C199 System calendar integration — see appointments inside the plan

### R17-023 — The most product-original idea in the corpus: backward scheduling from a fixed anchor — 'say I want to fall asleep by 10pm. I have a pre-sleep routine set in a sequence… I would like for the app to calculate the latest I would have to start my pre-sleep routine before it overlaps with my sleep activity' — a genuine differentiator for a timeline app, requested unprompted by a paying user

- **Where:** §3.3 Auto-calculate the latest start time for a sequence — backward scheduling from a fixed anchor, the most product-original idea in the corpus
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** n=1 (2.63%), paying 4★ user
- **Direction for us:** research · **Report confidence:** n=1, high-value · **Generalisable:** yes
- **Review IDs:** `8557538403`
- **Canonical:** C120 Sequential routine timer with spoken next step and live finish-time estimate

### R17-047 — iPad is the most-requested single item (2022, 2023, 2025; continued payment contingent on it); Watch, Mac and iCloud sync are 1–2 reviewers each but together the platform story behind five reviews all rated 3★+

- **Where:** §8.2 B1 iPad app; B5 Apple Watch, Mac, iCloud sync
- **This app does:** iPhone only; no sync
- **User reaction:** blocked-conversion
- **Magnitude:** iPad 3; Watch 2; Mac 1; iCloud 1; N7 5 (13.16%) mean 4.20
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `8275228824`, `9957602682`, `13441826130`, `11035825108`, `7859394020`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C141 Native iPad layout

### R17-048 — Restore calendar integration — a capability the classic app had and this one removed; the only thing keeping the most recent paying reviewer from switching to Blocos, a competitor gap that closes on its own timeline

- **Where:** §8.2 B2 Restore calendar integration — the only thing keeping the last paying reviewer from switching to Blocos
- **This app does:** removed at relaunch
- **User reaction:** churn
- **Magnitude:** N10 2 (5.26%)
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `7780256223`, `13441826130`
- **Canonical:** C199 System calendar integration — see appointments inside the plan

### R17-050 — Build backward scheduling from a fixed anchor (auto-calculate the latest start time for a sequence) — a natural extension of a timeline-first model; and test positioning explicitly for time blindness / ADHD, a specific underserved clinical use case a timeline-first scheduler suits

- **Where:** §8.2 B4 Build backward scheduling from a fixed anchor; B6 Position explicitly for time blindness / ADHD
- **This app does:** absent; unpositioned
- **User reaction:** praise
- **Magnitude:** n=1 each
- **Direction for us:** research · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `8557538403`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C120 Sequential routine timer with spoken next step and live finish-time estimate

## Monetization

### R17-006 — Pricing is the second trust problem: Monthly $1.99, Annual $19.99, One-Time $64.99 — the lifetime is 3.25 years of the annual, asking users to bet on the longevity of a developer who already broke that bet once ('A one-time purchase is available for three times the price of a premium word processor… all future versions are free. Until the next pricing model'; 'Is there a chance that I buy the new version and they aren't going to drop it in couple years again?' — answered by events)

- **Where:** Part 0 §4 The pricing is the second trust problem, and the numbers are now public; price table (verbatim)
- **This app does:** $64.99 lifetime vs $19.99/yr
- **User reaction:** complaint
- **Magnitude:** price objection 5 (13.16%) mean 1.60; Option | Price ; Monthly Subscription | $1.99 ; Annual Subscription | $19.99 ; One-Time Purchase | $64.99
- **Direction for us:** product-rule · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `9289248731`, `7849996761`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C196 A subscription is a promise of continued delivery — back it with a visible cadence

### R17-018 — Monetisation: Free label hard-gated in practice, no functional free tier, a trial gated behind payment confirmation, $1.99/mo, $19.99/yr, $64.99 lifetime; the classic app was a one-time purchase, discontinued with no migration path; the grievance group's core complaint is explicit — 'Without grandfathering the existing customers or even offering a discount so they could buy the lifetime at a discounted price. Or could have at least left the old app in a working state' — three asks, none done, every one cheaper than the six 1–2★ reviews it produced

- **Where:** §2.2 Monetisation model table (verbatim); the migration failure is explicit — grandfathering, a loyalty discount, or not breaking the old app
- **This app does:** no grandfathering, no discount, classic left broken
- **User reaction:** 1★-burst
- **Magnitude:** Element | Classification | Evidence ; Download | Free label, hard-gated in practice | Listing; `8863711662`, `10621025077`, `12167506108` ; Any use of the app | Paid — no functional free tier | 7 reviews, §0.3 ; Free trial | Exists but gated behind payment confirmation | `9289248731`: *"the free trial is entirely unusable without going through payment confirmation"* ; Monthly subscription | Paid — $1.99 | Listing; `9471017050` ; Annual subscription | Paid — $19.99 | Listing; `8013032927` (*"instantly subscribed to the yearly"*) ; One-time "lifetime" purchase | Paid — $64.99 | Listing; `8557538403`, `9289248731` ; Classic (predecessor) app | One-time purchase, discontinued, no migration path | `7849996761`, `8874399635`, `11033875205` ; legacy grievance 6 (15.79%) mean 1.17
- **Direction for us:** product-rule · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `8863711662`, `10621025077`, `12167506108`, `9289248731`, `9471017050`, `8013032927`, `8557538403`, `7849996761`, `8874399635`, `11033875205`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C147 Let people use the product before they pay; C186 Never revoke what earlier buyers paid for when the model changes

### R17-031 — Paid evidence is substantial for a small corpus: 11 state they paid (8 for this app, 3 for classic only and refused this one); confirmed payers of this app average 3.63 against 1.14 for those blocked at the paywall — people who get inside rate it more than two and a half stars higher; directional (n=8 vs 7), but the strongest argument in the corpus for letting people in

- **Where:** §5.1 The evidence base table (verbatim); people who get inside this product rate it more than two and a half stars higher than people who don't
- **This app does:** hard paywall
- **User reaction:** mixed
- **Magnitude:** Group | n | % of 38 | Mean ★ ; States they paid (bought outright or subscribed, this app or classic) | 11 | 28.95% | 3.18 ; — of whom paid for this app | 8 | 21.05% | 3.63 ; — of whom paid for classic only, and refused this one | 3 | 7.89% | 1.00 ; Refused to pay or hesitant | 6 | 15.79% | 1.50 ; Blocked at the paywall without paying | 7 | 18.42% | 1.14 ; payers of this app 8 (21.05%) mean 3.63: 5★ 3, 4★ 3, 3★ 1, 2★ 2
- **Direction for us:** product-rule · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `7886496270`, `8417841619`, `10884354864`, `7859394020`, `8013032927`, `8557538403`, `13441826130`, `8776556254`, `8827339965`
- **Canonical:** C147 Let people use the product before they pay; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R17-033 — Five barriers in order: no way to evaluate before paying (the largest theme); the $64.99 lifetime price (3.25-year payback demanded up front from a developer with an abandonment history); subscription-model rejection (being asked to rent what they previously owned); no grandfathering for classic buyers; bug level vs price ('I hesitate to buy/subscribe. The price of one-time purchase is too expensive for the app with many bugs' — a positive-leaning user talking themselves out of a purchase)

- **Where:** §5.3 What stopped people from paying — five barriers in order
- **This app does:** hard paywall; $64.99 lifetime; no grandfathering
- **User reaction:** blocked-conversion
- **Magnitude:** paywall 7 (18.42%) 1.14; price 5 (13.16%) 1.60; sub model 5 (13.16%) 1.40; grandfathering 3; bugs-vs-price 1
- **Direction for us:** product-rule · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `8874399635`, `11033875205`, `13120304447`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C147 Let people use the product before they pay; C186 Never revoke what earlier buyers paid for when the model changes

### R17-051 — Retire or reprice the $64.99 lifetime tier — 3.25 years of the $19.99 annual demanded up front from a developer who has abandoned a paid app once; the tier generates objections and its credibility depends on a promise the release history contradicts

- **Where:** §8.3 M1 Retire or reprice the $64.99 lifetime tier
- **This app does:** $64.99 lifetime vs $19.99/yr
- **User reaction:** complaint
- **Magnitude:** N5 5 (13.16%) mean 1.60
- **Direction for us:** undecided · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `9289248731`
- **Canonical:** C003 Lead with a one-time lifetime purchase

## Tactics the app used

### R17-058 — Tactic that converted: the developer personally emailed a reviewer when the feature they asked for was implemented — 'This is above and beyond. This thing is a work of art' — the only support interaction in the corpus and a 5★; a developer who, when engaged, delights people

- **Where:** Part 0 §6 Support that converts; §7.6 Trend 5; §8.3 M5
- **This app does:** personal follow-up email on shipped request
- **User reaction:** praise
- **Magnitude:** n=1 (2.63%) → 5★
- **Direction for us:** do · **Report confidence:** n=1 · **Generalisable:** yes
- **Review IDs:** `8244932708`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

## Insights (the why)

### R17-021 — Only 1 review in 38 is a 3★ — users either find the product irreplaceable or cannot get into it at all; 8 of the 20 four- and five-star reviews still carry a criticism or request: engaged users specifying what to build (single-instance edit, calendar, iPad, Mac, tutorial, iCloud, Watch, auto-calculated start times)

- **Where:** §3.2 The corpus is bimodal; 8 of the 20 four- and five-star reviews still carry a criticism or request
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Population | n | % | Mean ★ | Rating spread ; Pure praise, no criticism or request | 12 | 31.58% | 5.00 | 5★12 ; Carries ≥1 criticism or request | 26 | 68.42% | 2.27 | 5★2 / 4★6 / 3★1 / 2★5 / 1★12 ; 8 of 20 4–5★ (40.00%) with a request
- **Direction for us:** do · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `7780256223`, `7859394020`, `8013032927`, `8275228824`, `8557538403`, `9957602682`, `11035825108`, `13120304447`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R17-025 — 5★ is driven by the relaunch itself ('So glad to see this is back!'; 'Thank god, it's back! I've been using it for 10 years'; 'My sole purpose for buying an iPhone so that I could use this app'), the timeline model working, and uniqueness; two 5★ are not straightforward endorsements (a bare 'support ipad icloud'; praise for the relaunch decision — 'It's worth the money'); 9 of the 14 five-star reviews come from before 2023 — disproportionately returning classic users in the first 16 months

- **Where:** §4.1 5★ — three drivers: the relaunch itself, the timeline model, uniqueness; 9 of 14 five-star reviews predate 2023
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 5★ 14 (36.84%); relaunch 9 of 14; pre-2023 9 of 14
- **Direction for us:** none · **Report confidence:** band analysis · **Generalisable:** app-specific
- **Review IDs:** `7883987615`, `9316304222`, `7775035126`, `7850343184`, `9504102829`, `10884354864`, `14333713628`, `7886496270`, `7988825337`, `9957602682`, `8417841619`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C120 Sequential routine timer with spoken next step and live finish-time estimate

### R17-026 — Every 4★ review is 'great product, specific gap' — 'I need iPad and Mac versions yesterday'; 'If these two features are added it is definitely 5⭐️'; 'Once that happens… I have no doubt it'll be 5 stars'; 'still in the beta' — two state the exact condition for a 5★ and neither was met

- **Where:** §4.1 4★ — every single 4★ review is 'great product, specific gap'; table (verbatim); two state the exact condition for a 5★, neither met
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 4★ 6 (15.79%); ID | Ctry | The gap ; `7780256223` | de | Single-instance repeat editing + calendar integration — *"If these two features are added it is definitely 5⭐️"* ; `7859394020` | us | *"I need iPad and Mac versions yesterday"* + remaining bugs ; `8013032927` | us | Old features + tutorial — *"Once that happens… I have no doubt it'll be 5 stars"* ; `8275228824` | us | *"I wish it was more built for the iPad"* ; `8557538403` | us | Single-instance editing, cascading time, backward scheduling ; `13120304447` | de | *"still in the beta"*, too expensive for the bug level
- **Direction for us:** build-free · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `7780256223`, `7859394020`, `8013032927`, `8275228824`, `8557538403`, `13120304447`
- **Canonical:** C044 Mac / desktop / web app; C075 Skippable, replayable onboarding tour; C141 Native iPad layout; C198 Edit one instance of a repeating block without changing the series; a slipped block pushes the ones after it; C199 System calendar integration — see appointments inside the plan

### R17-027 — The corpus's only 3★ is its most operationally useful review: loves the product ('maps out time so beautifully'), is paying, is tired of 'the paywall with zero app updates', names the retention condition (iPad + Watch + debugging) and the churn destination (Blocos, pending calendar integration)

- **Where:** §4.1 3★ — the corpus's only middle rating and its most operationally useful review
- **This app does:** abandoned while charging
- **User reaction:** churn
- **Magnitude:** 3★ n=1 (2.63%)
- **Direction for us:** must-never-break · **Report confidence:** n=1 · **Generalisable:** yes
- **Review IDs:** `13441826130`
- **Canonical:** C196 A subscription is a promise of continued delivery — back it with a visible cadence; C199 System calendar integration — see appointments inside the plan

### R17-028 — 2★ splits between complexity and disappointment against the classic — 'For a subscription user face should not be this bad' (a paying user); deleted after 30 minutes; kept a subscription for months hoping it would reach classic quality ('Please fix legacy app… now. Then come back to this version'); trapped on the payment screen; loved it, now abandoned and crashing — 3 of 5 are or were paying customers, not tyre-kickers

- **Where:** §4.1 2★ — split between complexity and disappointment against the classic; 3 of 5 are or were paying customers
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 2★ 5 (13.16%); 3 of 5 payers
- **Direction for us:** must-have · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `8827339965`, `8644242601`, `8776556254`, `10024637302`, `13193213543`
- **Canonical:** C075 Skippable, replayable onboarding tour; C196 A subscription is a promise of continued delivery — back it with a visible cadence

### R17-029 — 10 of the 12 one-star reviews are about money and trust, not product quality — five never used the app (paywall), five used its predecessor and feel cheated; only 2 of 38 reviews are one-star ratings from someone judging this app's actual functionality: the product is not what earns the bad ratings, the commercial model and the migration are

- **Where:** §4.1 1★ — the largest band; table (verbatim); 10 of 12 are about money and trust, not product quality — the central asymmetry
- **This app does:** paywall + migration
- **User reaction:** 1★-burst
- **Magnitude:** 1★ 12 (31.58%); paywall 5, legacy 5, technical 2 (5.26% of all); Cause | n | IDs ; Blocked by the paywall, never used the app | 5 | `8863711662`, `9471017050`, `9992175230`, `10621025077`, `12167506108` ; Legacy betrayal (paid for classic) | 5 | `7849996761`, `8874399635`, `9289248731`, `11033875205`, `14384355988` ; Hard technical failure | 2 | `9086558708` (crash on blank timeline), `9244113250` (black screen after iOS update)
- **Direction for us:** product-rule · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `8863711662`, `9471017050`, `9992175230`, `10621025077`, `12167506108`, `7849996761`, `8874399635`, `9289248731`, `11033875205`, `14384355988`, `9086558708`, `9244113250`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C147 Let people use the product before they pay; C186 Never revoke what earlier buyers paid for when the model changes

### R17-032 — Purchase driver #1 is the classic app's reputation cashed in immediately — payment as patronage before evaluating the new product ('I instantly subscribed to the yearly subscription to give my full support'; 'I put both feet in and bought the full version'; 'I am happy to support your efforts!'; 'My hope is that… the developer will continue to meet our needs') — the most fragile revenue there is, advanced against a promise of continued development that stopped in Jan 2023; driver #2 is no alternative ('It's worth the money'; 'I am a loyal subscriber and I hope this app is here to stay')

- **Where:** §5.2 What made people pay — the classic app's reputation cashed in immediately (patronage); no alternative; the most fragile revenue there is
- **This app does:** relaunch on legacy goodwill
- **User reaction:** purchase-driver
- **Magnitude:** 3 patronage payers; 2 no-alternative payers
- **Direction for us:** product-rule · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `8013032927`, `7859394020`, `7886496270`, `8417841619`, `10884354864`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C196 A subscription is a promise of continued delivery — back it with a visible cadence

### R17-042 — Persisted unchanged over five years: the core value proposition (praised Sep 2021 → Jul 2026 with no erosion), the unmet iPad ask (2022, 2023, 2025, still absent), and calendar integration removed at relaunch and still the blocking gap four years later

- **Where:** §7.7 What persisted unchanged — the core value proposition; the unmet platform asks; calendar integration
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** value praised 5 dates; iPad 3 dates; calendar 2021 + 2025
- **Direction for us:** must-have · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `7866331165`, `9504102829`, `10884354864`, `13441826130`, `14333713628`, `8275228824`, `9957602682`, `7780256223`
- **Canonical:** C120 Sequential routine timer with spoken next step and live finish-time estimate; C141 Native iPad layout; C199 System calendar integration — see appointments inside the plan

## Audiences

### R17-011 — Two more value signals: 'I experience time blindness and this app helps manage that immensely' — a specific clinical use case for a timeline-first scheduler; and support that converts — 'I asked for a feature and the dev emailed me personally when they implemented it. This is above and beyond' — the only support interaction, a 5★

- **Where:** Part 0 §6 Time blindness / ADHD; Support that converts
- **This app does:** timeline scheduler; personal dev email
- **User reaction:** praise
- **Magnitude:** n=1 each (2.63%)
- **Direction for us:** do · **Report confidence:** n=1 · **Generalisable:** yes
- **Review IDs:** `8557538403`, `8244932708`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C059 Be visibly responsive; fixes bring reviewers back; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

## Markets and languages

### R17-013 — Major markets including GB, AU, FR, IT, JP and KR returned zero written reviews; with an English-only listing this suggests effectively no reach outside a handful of markets — an observation, not a finding

- **Where:** §1.3 Note on the empty storefronts — GB, AU, FR, IT, JP, KR returned zero written reviews
- **This app does:** English only; no reach
- **User reaction:** none
- **Magnitude:** 18 of 30 crawled storefronts empty
- **Direction for us:** research · **Report confidence:** observation · **Generalisable:** app-specific
- **Canonical:** C027 Localise early — it unlocks revenue

### R17-035 — Limited-evidence market notes: the US holds nearly half of reviews and every other storefront has 4 or fewer; 18 of 30 crawled storefronts returned nothing (GB, AU, FR, IT, JP, KR) — with an English-only listing and no iPad build the reach appears narrow; India's 4 reviews are 3 negative (noise, n=4); the 3 non-English reviews are all positive and two ask for features

- **Where:** Part 6 MARKET AND LANGUAGE NOTES (limited evidence)
- **This app does:** English only; narrow reach
- **User reaction:** mixed
- **Magnitude:** us 18 (47.37%); in 4 (3 negative); non-English 3 all 5★
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `8644242601`, `9992175230`, `11033875205`, `7850343184`, `8417841619`, `11035825108`, `14333713628`
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R17-003 — A relaunch-migration corpus: more than half of reviews reference the predecessor 'Daily Routine Classic' — a paid app that built a devoted following, went years without maintenance, became unusable, was pulled, and was relaunched Sep 2021 on a subscription; the legacy base splits into returning users delighted by the relaunch (mean 4.46) and legacy buyers who feel betrayed (mean 1.17) — a 3.29-star gap inside the same user base over the same event, separated not by the product but by whether they had paid for the original

- **Where:** Part 0 §1 This is not a habit-tracker corpus. It is a relaunch-migration corpus; population table (verbatim)
- **This app does:** abandoned one-time app relaunched as subscription with no migration
- **User reaction:** mixed
- **Magnitude:** classic references 20 of 38 (52.63%); Population | n | % of 38 | Mean ★ ; Returning users delighted by the relaunch | 13 | 34.21% | 4.46 ; Legacy buyers who feel betrayed by it | 6 | 15.79% | 1.17
- **Direction for us:** product-rule · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C186 Never revoke what earlier buyers paid for when the model changes

### R17-004 — The relaunch bought a quarter of goodwill then spent it: relaunch euphoria (mean 4.30, 9 of 10 reference the classic) → first full year 2.62 as new users with no nostalgia hit a paywall on first launch — a 1.68-star drop; the opening ratings were a loan against the classic app's reputation, not a measure of the new product

- **Where:** Part 0 §2 The relaunch bought roughly one quarter of goodwill, then spent it; era table (verbatim)
- **This app does:** relaunch on legacy goodwill
- **User reaction:** mixed
- **Magnitude:** Era | Window | n | % | Mean ★ | Rating spread ; 1. Relaunch euphoria | 5 Sep – 31 Dec 2021 | 10 | 26.32% | 4.30 | 5★6 / 4★3 / 1★1 ; 2. First full year | 2022 | 13 | 34.21% | 2.62 | 5★3 / 4★2 / 2★3 / 1★5 ; 3. After the final update | ≥ 9 Jan 2023 | 14 | 36.84% | 2.93 | 5★5 / 4★1 / 3★1 / 2★2 / 1★5
- **Direction for us:** product-rule · **Report confidence:** counts · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C147 Let people use the product before they pay

### R17-036 — Time-trend method anchored on the relaunch (Sep 2021) and the final release (9 Jan 2023): before the final update mean 3.25 (n=24), after 2.93 (n=14)

- **Where:** §7.1 Method — two anchors: relaunch Sep 2021 and final release 1.1.4 (9 Jan 2023); period table (verbatim); by year
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Period | n | % | Mean ★ ; Era 1 — relaunch, Sep–Dec 2021 | 10 | 26.32% | 4.30 ; Era 2 — 2022, first full year | 13 | 34.21% | 2.62 ; Era 3 — after the final update (≥9 Jan 2023) | 14 | 36.84% | 2.93 ; Before the final update (<9 Jan 2023) | 24 | 63.16% | 3.25 ; by year 2021 10 (4.30) · 2022 13 (2.62) · 2023 6 (2.50) · 2024 3 (3.67) · 2025 4 (2.50) · 2026 2 (3.00)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R17-037 — The goodwill was spent within 16 months — Era 1 → Era 2 is a 1.68-star fall: 9 of 10 Era 1 reviews reference the classic and 6 of 10 celebrate the return; in Era 2 paywall complaints appear for the first time and legacy grievance turns hostile — the reviewers changed before the app did: Era 1 was the existing fanbase, Era 2 the general public meeting a hard paywall

- **Where:** §7.2 Trend 1 — The goodwill was spent within 16 months; the reviewers changed before the app did
- **This app does:** relaunch goodwill then hard paywall
- **User reaction:** 1★-burst
- **Magnitude:** 4.30 (n=10) → 2.62 (n=13)
- **Direction for us:** product-rule · **Report confidence:** largest movement · **Generalisable:** yes
- **Review IDs:** `8863711662`, `8874399635`, `9289248731`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C147 Let people use the product before they pay

### R17-038 — Abandonment did not exist as a theme before 2025 and now dominates: four of the corpus's last six reviews are about the app not being updated, and the listing confirms the cause (last release 9 Jan 2023) — the clearest and most recent trend, forecasting the churn of the remaining paying base

- **Where:** §7.3 Trend 2 — Emerging and now dominant: abandonment, again; table (verbatim)
- **This app does:** no release since Jan 2023
- **User reaction:** churn
- **Magnitude:** Window | Abandonment reviews | Share of window ; Sep 2021 – Dec 2024 | 0 | 0 of 32 (0.00%) ; Jan 2025 – Aug 2026 | 4 | 4 of 6 (66.67%)
- **Direction for us:** must-never-break · **Report confidence:** clear, recent · **Generalisable:** yes
- **Review IDs:** `13120304447`, `13193213543`, `13441826130`, `14384355988`
- **Canonical:** C071 Never ship and walk away; C196 A subscription is a promise of continued delivery — back it with a visible cadence

### R17-039 — Paywall complaints are a steady drip from Jul 2022 to Jan 2025, unchanged by anything the developer did; zero in Era 1 because those reviewers already knew what the app was and wanted to pay — the theme begins the moment the audience widens

- **Where:** §7.4 Trend 3 — Persistent: paywall complaints, from 2022 to 2025; zero in Era 1 because those reviewers already knew what the app was
- **This app does:** hard paywall
- **User reaction:** 1★-burst
- **Magnitude:** 7 across Jul 2022 – Jan 2025; 0 in Era 1
- **Direction for us:** product-rule · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `8863711662`, `9289248731`, `9471017050`, `9992175230`, `10024637302`, `10621025077`, `12167506108`
- **Canonical:** C147 Let people use the product before they pay

### R17-040 — Bug reports span the full corpus — 'Since the latest iOS update, opening the app results in just a black screen' — the same OS-transition fragility, and after Jan 2023 there is no longer anyone shipping fixes for it

- **Where:** §7.5 Trend 4 — Persistent: bugs across the whole lifespan; OS-transition fragility with nobody shipping fixes after Jan 2023
- **This app does:** black screen after iOS update; no fixes
- **User reaction:** 1★-burst
- **Magnitude:** 2021 (2), 2022 (3), 2025 (2)
- **Direction for us:** must-never-break · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `7849996761`, `7859394020`, `8776556254`, `9086558708`, `9244113250`, `13120304447`, `13193213543`
- **Canonical:** C031 Crashes / launch failures; C071 Never ship and walk away

### R17-041 — The one counter-trend: early 2022 shows a developer actively shipping and personally engaging ('the dev emailed me personally when they implemented it'), with 4★ reviews anticipating 5★ once features land; that capacity is gone by 2023 — the corpus documents not an absence of ability but its exhaustion, a resourcing or business-viability problem behind every other finding

- **Where:** §7.6 Trend 5 — Fixed, briefly: responsive development in early 2022 — the corpus documents not an absence of ability but its exhaustion
- **This app does:** responsive dev, then dormant
- **User reaction:** praise
- **Magnitude:** Jan 2022 window: 1 support 5★, 2 anticipatory 4★
- **Direction for us:** do · **Report confidence:** counter-trend · **Generalisable:** yes
- **Review IDs:** `8244932708`, `7780256223`, `8013032927`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C071 Never ship and walk away

## Positioning

### R17-001 — Daily Routine (App Store ID 1580007457) — 'Organise your time into blocks' — is a timeline / time-blocking day scheduler relaunched in Sep 2021 on a subscription after its beloved one-time-purchase predecessor 'Daily Routine Classic' was abandoned and pulled; the decision it informs is how to relaunch a beloved, abandoned paid app on a subscription

- **Where:** header lines 1-10; §1.6 External source table (verbatim)
- **This app does:** developer Daily Routine Pty Ltd; bundle com.dailyroutine.bundle-id.daily-routine-apple-universal; Free label with Monthly $1.99 / Annual $19.99 / One-Time $64.99; v1.1.4 released 9 Jan 2023; English only; iPhone only; store rank 17
- **User reaction:** mixed
- **Magnitude:** 38 written reviews, 12 storefronts, 5 Sep 2021 → 3 Aug 2026; written mean 3.132; store 3.4★ from 41 ratings; Field | Value ; Name / subtitle | Daily Routine — Organise your time into blocks ; Developer | Daily Routine Pty Ltd ; Price label | "Free · In-App Purchases" ; In-app purchases | "Monthly Subscription $1.99" · "Annual Subscription $19.99" · "One-Time Purchase $64.99" ; Current version | 1.1.4, released 9 January 2023 ; Store rating | 3.4★ from 41 ratings ; Category | Productivity ; Requirements | iOS 14.0 or later · 57.3 MB ; Languages | English only ; Platforms | Designed for iPhone; no dedicated iPad UI; "Not verified for macOS"
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R17-009 — Nearly a quarter of the corpus says they searched for a replacement and failed ('I was searching for routine/habits app that would fill the void, but honestly none of apps could'; 'I've been using it for 10 years, even when it degraded to a buggy app… still the best and the only one perfect for my needs'); the timeline / time-blocking model itself is praised ('The only app in the store that queues up duties as the time approaches… Epic, a major health care app… has a Brains timeline. This is what Daily Routine has achieved')

- **Where:** Part 0 §6 What people actually love: the timeline, and one feature no competitor has — no alternative exists; timeline model praised
- **This app does:** timeline-first time-blocking scheduler
- **User reaction:** praise
- **Magnitude:** no alternative 9 (23.68%) mean 4.22; timeline praised 8 (21.05%) mean 4.50
- **Direction for us:** must-have · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `7988825337`, `8013032927`, `7775035126`, `9504102829`
- **Canonical:** C005 Know which competitors buyers compare against; C120 Sequential routine timer with spoken next step and live finish-time estimate

### R17-024 — Competitive position is favourable and fragile at once: Sorted was the only rival with global schedule shifting and was rejected for task pile-up and freezing; Blocos is named as the destination if the app doesn't improve, blocked only by calendar integration; Epic's 'Brains' timeline is the analogy for what the app achieves; nearly a quarter say nothing else does this and the most recent paying user says a named competitor is one feature away

- **Where:** §3.4 Competitive position — favourable and fragile at once: Sorted, Blocos, Epic
- **This app does:** unique timeline; abandoned
- **User reaction:** mixed
- **Magnitude:** competitor named 3 (7.89%) mean 4.33; no alternative 9 (23.68%)
- **Direction for us:** product-rule · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `7886496270`, `13441826130`, `9504102829`
- **Canonical:** C005 Know which competitors buyers compare against; C197 Shift the whole day's schedule at once (global schedule shift); C199 System calendar integration — see appointments inside the plan

## Anti-patterns

### R17-056 — Anti-pattern with a measured cost: relaunching an abandoned one-time-purchase app as a subscription with no grandfathering, no discount and the old app left broken — it split one loyal base into delighted returners (mean 4.46) and betrayed buyers (mean 1.17), a 3.29-star gap over the same event, and produced the corpus's angriest cluster from its most loyal historical customers

- **Where:** Part 0 §1; Part 0 §4; §2.2; §8.3 M2–M3
- **This app does:** no migration path for classic buyers
- **User reaction:** 1★-burst
- **Magnitude:** legacy grievance 6 (15.79%) mean 1.17 vs relaunch joy 13 (34.21%) mean 4.46
- **Direction for us:** dont · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `11033875205`, `8874399635`, `9289248731`, `7849996761`
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

## Things not to do

### R17-057 — Do not keep charging a subscription — or selling a $64.99 'lifetime' tier — against a build nobody is updating: four of the last six reviews are about abandonment, and the one paying 3★ has named the competitor and the feature that will trigger the switch

- **Where:** Part 0 §5; §8.1 I4–I5; §8.3 M1, M4
- **This app does:** subscription + lifetime sold on a 3.5-year-old build
- **User reaction:** churn
- **Magnitude:** abandonment 4 (10.53%); last release 9 Jan 2023
- **Direction for us:** dont · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `13441826130`, `13193213543`, `14384355988`, `13120304447`
- **Canonical:** C071 Never ship and walk away; C196 A subscription is a promise of continued delivery — back it with a visible cadence

## Things to do

### R17-049 — Market global schedule shifting as the headline differentiator — the one capability a user says no competitor matches, absent from the store listing; nine reviewers searched for an alternative and failed and the listing does not tell prospects why they will fail too

- **Where:** §8.2 B3 Market global schedule shifting as the headline differentiator — absent from the listing
- **This app does:** moat unmarketed
- **User reaction:** praise
- **Magnitude:** P6 n=1; P1 9 (23.68%)
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `7886496270`
- **Canonical:** C134 Lead the store listing with what users actually love; C197 Shift the whole day's schedule at once (global schedule shift)

### R17-054 — Keep doing personal support — the single support interaction produced a 5★ and the phrase 'a work of art'; highest return per unit of effort available

- **Where:** §8.3 M5 Keep doing personal support — highest return per unit of effort
- **This app does:** personal dev email
- **User reaction:** praise
- **Magnitude:** n=1 → 5★
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `8244932708`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

## Contradictions

### R17-030 — Both-sides themes: the relaunch (mean 4.46 vs 1.17), the learning curve (the same friction produces 5★ and 2★ — what separates them is whether the user got through the first day, an onboarding variable fully within the developer's control), pricing ('It's worth the money'; 'instantly subscribed… to give my full support' vs three 1★), bugs ('There are still bugs but there is no other app like this')

- **Where:** §4.2 Themes appearing on both sides of the rating line table (verbatim); the learning-curve split is the most actionable line
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | Positive appearance | Negative appearance ; The relaunch | 13 reviews, mean 4.46 (`7883987615`, `9316304222`, `7775035126`) | 6 reviews, mean 1.17 (`8874399635`, `11033875205`, `9289248731`) ; Learning curve | `7866331165` (5★, *"takes a day… then I got hooked"*), `7988825337` (5★), `8557538403` (4★, *"certainly learnable"*) | `8644242601` (2★, deleted at 30 min), `8827339965` (2★), `8776556254` (2★) ; Pricing | `8417841619` (5★, *"It's worth the money"*), `8013032927` (4★, *"instantly subscribed… to give my full support"*) | `9289248731`, `9471017050`, `8874399635` (all 1★), `13120304447` (4★) ; Bugs | `7859394020` (4★, *"There are still bugs but there is no other app like this"*) | `9086558708`, `9244113250` (1★), `13193213543` (2★)
- **Direction for us:** must-have · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `7866331165`, `7988825337`, `8557538403`, `8644242601`, `8827339965`, `8776556254`, `8417841619`, `8013032927`, `7859394020`
- **Canonical:** C031 Crashes / launch failures; C061 Goodwill conversion — a generous free tier and 'support the devs'; C075 Skippable, replayable onboarding tour

## Data caveats and method

### R17-002 — Method: n=38 so one review = 2.63% and 'high-priority' is 3 reviews — counts are the honest unit; but reviews are unusually substantial (median body 236 chars, ~4× other small corpora) so the corpus supports mechanism findings better than rates; no country reaches 50 (US 18), global only; 18 of 30 crawled storefronts (incl. GB, AU, FR, IT, JP, KR) returned zero reviews; selection bias runs to both poles — nostalgic returners and blocked non-buyers — the quiet paying middle is under-represented; 12 pure-praise (all 5★) vs 26 with criticism (mean 2.27), almost no middle; judgement calls: a 1★ containing its own pasted prior 5★ counted once; the sabotage allegation coded as grievance not defect; a 5★ reading 'support ipad icloud' coded as a request; store 3.4★ vs written 3.13 are close because written reviews are nearly the whole rating population

- **Where:** How to read this; ⚠️ Three warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Limitations and judgement calls; §9.1 counting rules
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 38/38 read; 0 duplicates; 12 storefronts reconcile; 5★14 / 4★6 / 3★1 / 2★5 / 1★12; vote_count non-zero on 12; is_edited false on all (understated); 3 non-English (2 ES, 1 DE)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `9244113250`, `9289248731`, `9957602682`, `13120304447`
- **Canonical:** — (nuance register)

### R17-014 — A strongly bimodal distribution — 68.42% of reviews are 5★ or 1★, only one 3★; the product does not produce moderate opinions

- **Where:** §1.7 Corpus composition ratings table (verbatim); bimodal; storefronts; language; volume by year
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ★ | Count | Share ; 5 | 14 | 36.84% ; 4 | 6 | 15.79% ; 3 | 1 | 2.63% ; 2 | 5 | 13.16% ; 1 | 12 | 31.58% ; storefronts us 18 · in 4 · ca 3 · de 3 · mx 2 · ru 2 · ch 1 · cn 1 · cy 1 · pl 1 · ro 1 · se 1; EN 35, ES 2, DE 1; by year 2021 10 · 2022 13 · 2023 6 · 2024 3 · 2025 4 · 2026 2
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R17-019 — All themes ranked: eight positive, eleven negative, seven cross-cutting

- **Where:** §3.1 Positive themes table (verbatim); Negative themes table (verbatim); Cross-cutting table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** POS: # | Theme | n | % | Signal | Mean ★ | Representative IDs ; P1 | No alternative exists — searched and failed to replace it | 9 | 23.68% | High-priority | 4.22 | `7775035126`, `7859394020`, `7886496270`, `7988825337`, `8013032927`, `8275228824`, `9244113250`, `9504102829`, `10884354864` ; P2 | Timeline / time-blocking model works | 8 | 21.05% | High-priority | 4.50 | `7859394020`, `7866331165`, `7886496270`, `8557538403`, `9504102829`, `10884354864`, `13441826130`, `14333713628` ; P3 | Design, look and feel | 6 | 15.79% | High-priority | 4.17 | `7780256223`, `7886496270`, `8275228824`, `8557538403`, `13441826130`, `14333713628` ; P4 | Relaunch itself — gratitude that it's back | 13 | 34.21% | High-priority | 4.46 | `7775035126`, `7850343184`, `7883987615`, `7886496270`, `7988825337`, `8013032927`, `8275228824`, `8417841619`, `9316304222`, `10884354864` ; P5 | Per-block notifications cue the next activity | 2 | 5.26% | High-priority | 5.00 | `9504102829`, `10884354864` ; P6 | Global schedule shift — named as unique | 1 | 2.63% | Meaningful | 5.00 | `7886496270` ; P7 | Developer support above and beyond | 1 | 2.63% | Meaningful | 5.00 | `8244932708` ; P8 | Helps with time blindness / ADHD | 1 | 2.63% | Meaningful | 4.00 | `8557538403` ;; NEG: # | Theme | n | % | Signal | Mean ★ | Representative IDs ; N1 | Cannot try the app without paying | 7 | 18.42% | High-priority | 1.14 | `8863711662`, `9289248731`, `9471017050`, `9992175230`, `10024637302`, `10621025077`, `12167506108` ; N2 | Bugs, crashes, black screens | 7 | 18.42% | High-priority | 2.14 | `7849996761`, `7859394020`, `8776556254`, `9086558708`, `9244113250`, `13120304447`, `13193213543` ; N3 | Complexity / steep learning curve | 7 | 18.42% | High-priority | 3.43 | `7866331165`, `7988825337`, `8013032927`, `8557538403`, `8644242601`, `8776556254`, `8827339965` ; N4 | Legacy grievance — betrayed by the relaunch | 6 | 15.79% | High-priority | 1.17 | `7849996761`, `8776556254`, `8874399635`, `9289248731`, `11033875205`, `14384355988` ; N5 | Price too high | 5 | 13.16% | High-priority | 1.60 | `8874399635`, `9289248731`, `9471017050`, `9992175230`, `13120304447` ; N6 | Objection to the subscription model itself | 5 | 13.16% | High-priority | 1.40 | `8874399635`, `9289248731`, `9471017050`, `11033875205`, `13441826130` ; N7 | Missing platforms (iPad / Mac / Watch / iCloud) | 5 | 13.16% | High-priority | 4.20 | `7859394020`, `8275228824`, `9957602682`, `11035825108`, `13441826130` ; N8 | App abandoned again / no updates | 4 | 10.53% | High-priority | 2.50 | `13120304447`, `13193213543`, `13441826130`, `14384355988` ; N9 | No in-app tutorial (explicit) | 3 | 7.89% | High-priority | 2.67 | `8013032927`, `8644242601`, `8827339965` ; N10 | Calendar integration removed | 2 | 5.26% | High-priority | 3.50 | `7780256223`, `13441826130` ; N11 | Single instance of a repeating block can't be edited | 2 | 5.26% | High-priority | 4.00 | `7780256223`, `8557538403` ;; CROSS: Theme | n | % | Signal | Mean ★ | Note ; References the classic/legacy version | 20 | 52.63% | High-priority | 3.45 | Majority of the corpus ; States they paid (bought or subscribed) | 11 | 28.95% | High-priority | 3.18 | See Part 5 ; Refused to pay / hesitant to pay | 6 | 15.79% | High-priority | 1.50 | See Part 5 ; Any explicit feature request | 8 | 21.05% | High-priority | 4.12 | 7 of 8 rated 3★+ ; Names a competitor | 3 | 7.89% | High-priority | 4.33 | Sorted, Blocos, Epic (analogy) ; Carries ≥1 criticism or request | 26 | 68.42% | — | 2.27 | — ; Pure praise, no criticism | 12 | 31.58% | — | 5.00 | All 12 are 5★
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R17-055 — Research questions: is the developer still operating (every recommendation is conditional on this); actual free→paid conversion and silent paywall bounce; did the classic app genuinely ship a deliberate crash dialog; how many classic buyers migrated vs churned; would a functional free tier convert better than the hard gate (the 3.63-vs-1.14 gap is the clearest A/B candidate)

- **Where:** §8.4 Research questions this corpus cannot answer; part 8 #1; part 8 #2; part 8 #3; part 8 #4; part 8 #5
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 5 questions
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** yes
- **Review IDs:** `9289248731`
- **Canonical:** — (nuance register)
