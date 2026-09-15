# Cards — report 4

Source: `App Store Reports/4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker (REPORT).md`  
111 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 2
- [Must-haves](#must-haves) — 7
- [Must never break](#must-never-break) — 11
- [Features](#features) — 20
- [Monetization](#monetization) — 7
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 14
- [Audiences](#audiences) — 8
- [Markets and languages](#markets-and-languages) — 8
- [Dated events and trends](#dated-events-and-trends) — 10
- [Positioning](#positioning) — 3
- [Anti-patterns](#anti-patterns) — 6
- [Things not to do](#things-not-to-do) — 4
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 6

## Product rules

### R04-039 — The mid-2025 free task cap turned tenured free users into detractors

- **Where:** §1.7 #3
- **This app does:** free cap introduced
- **User reaction:** 1★-burst
- **Magnitude:** 57 reviews; mean fell 4.29 → 3.61 that quarter
- **Direction for us:** product-rule · **Report confidence:** high-priority (timing) · **Generalisable:** yes
- **Conditions:** evidence: R04-008
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C001 Never move a free feature behind the paywall

### R04-096 — Reconsider the free daily-task cap, or raise it well above 6 — it reversed a two-year rating recovery and produced the 'got greedy' vocabulary now in 286 reviews

- **Where:** Part 8 #8
- **This app does:** cap of 4–7
- **User reaction:** 1★-burst
- **Magnitude:** 286 (1.40%) 'used to be better'
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R04-008, R04-085
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C001 Never move a free feature behind the paywall

## Must-haves

### R04-032 — Paying users who change phones cannot restore — account portability is the complaint payers make that free users do not; small counts but every one is a paying customer at risk

- **Where:** §1.4 'what paying users complain about'
- **This app does:** no reliable restore / account portability
- **User reaction:** complaint
- **Magnitude:** 6 IDs, all payers
- **Direction for us:** must-have · **Report confidence:** weak, all payers · **Generalisable:** yes
- **Review IDs:** `10951060325`, `11052130385`, `10343032731`, `10850211623`, `13249657539`, `10786069222`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one

### R04-033 — Cancellation and support are the compounding failure: 169 (0.83%) cannot cancel (mean 1.22); 48 (0.23%, mean 1.29) say support never replied — 'there is literally NO WAY to cancel'; 'emailed you three times over a month'; 'I am engaging a lawyer'

- **Where:** §1.5
- **This app does:** cancel-by-email only; unanswered support
- **User reaction:** 1★-burst
- **Magnitude:** 169 (0.83%) mean 1.22; 48 (0.23%) mean 1.29, 89.6% 1–2★
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Side effects:** 'cancel anytime' promised, cancel-by-email delivered, no reply — the worst experiences in the corpus
- **Review IDs:** `11171231611`, `8951936828`, `10121356710`, `10859158478`, `10455594542`, `9504313939`, `9954546989`, `11181234690`, `9982043369`, `11052130385`
- **Canonical:** C112 In-app cancellation; C036 A support channel that exists and answers

### R04-040 — Cancellation and support are dead ends, converting recoverable disputes into permanent 1★ and legal threats

- **Where:** §1.7 #4
- **This app does:** no cancel path, no support replies
- **User reaction:** 1★-burst
- **Magnitude:** 169 + 48
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** evidence: R04-033
- **Canonical:** C112 In-app cancellation; C036 A support channel that exists and answers

### R04-058 — Account portability and data safety — 154 sync/login (0.75%) + 115 backup (0.56%) + 55 data loss (0.27%): 'everything was gone GONE'; 'the Data Recovery they added doesn't recover anything'; 'There's no cloud backup'; a 200+ day streak lost — small individually, catastrophic per user, hits payers hardest

- **Where:** Part 4 #4
- **This app does:** no cloud backup; a 'Data Recovery' feature that doesn't recover
- **User reaction:** 1★-burst
- **Magnitude:** 154 + 115 + 55
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10992217262`, `9795027359`, `9796249391`, `9790985374`, `9731639217`, `13965631601`, `10285166374`, `10996599524`, `10951060325`, `11052130385`, `10850211623`, `13249657539`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one

### R04-090 — Make the paywall's dismiss control unmissable — a full-width 'Continue with the free version' button, not a corner X

- **Where:** Part 8 #2
- **This app does:** corner X
- **User reaction:** 1★-burst
- **Magnitude:** up to a material share of 1,903 (9.30%)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R04-007
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R04-092 — Put in-app cancellation and a working support path in the app — 169 cancellation + 48 no-response reviews at mean ~1.2, several escalating to lawyers and denied Apple refunds

- **Where:** Part 8 #4
- **This app does:** cancel by email; no replies
- **User reaction:** 1★-burst
- **Magnitude:** 169 + 48
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** evidence: R04-033, R04-034
- **Canonical:** C112 In-app cancellation; C036 A support channel that exists and answers

### R04-094 — Ship iCloud backup / account restore on new device — disproportionately hits payers

- **Where:** Part 8 #6
- **This app does:** no backup/restore
- **User reaction:** 1★-burst
- **Magnitude:** 154 + 115 + 55
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** evidence: R04-032, R04-058
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one

## Must never break

### R04-005 — The billing-integrity cluster is the most severe finding: 1,247 reviews (6.09%, mean 1.32, 91.3% 1–2★) allege a broken trial, unexpected charge, refused refund or impossible cancellation — 'free trial' charged immediately 789 (3.86%), unauthorised charge 429, refund demanded 551, scam accusation 583, cannot cancel 169

- **Where:** Part 0 §3 + table
- **This app does:** '7-day free trial' that many users say charged them at once
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of 20,465 | Mean | 1–2★ | Band ; "Free trial" charged immediately / trial does not exist | 789 | 3.86% | 1.35 | 90.6% | Very strong ; Unexpected / unauthorised charge | 429 | 2.10% | 1.20 | 94.4% | Meaningful ; Refund demanded | 551 | 2.69% | 1.22 | 94.0% | Meaningful ; Scam / fraud / misleading accusation | 583 | 2.85% | 1.29 | 93.0% | Meaningful
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** consistent across five years and dozens of countries: user selects a plan expecting to be billed after seven days and is billed within minutes
- **Review IDs:** `10885363042`, `10930935136`, `11235083153`, `11419095674`, `11021690984`, `10848781536`, `11064050589`, `10845950237`, `12294261448`, `11757840008`, `13687854445`, `9913482153`
- **Canonical:** C109 A free trial must be a real trial; C029 Billing must be exactly right

### R04-027 — Accidental purchases — a trial they did not intend: 'Comprei sem querer', 'Accidentally subscribed for a year', 'Accidental purchase too easy'

- **Where:** §1.3 trigger row 5
- **This app does:** purchase too easy to trigger
- **User reaction:** 1★-burst
- **Magnitude:** 6 IDs, mostly 1★
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11452497897`, `9915339274`, `11095996568`, `10972171193`, `10373609190`, `9891617898`
- **Canonical:** C109 A free trial must be a real trial; C029 Billing must be exactly right

### R04-034 — Several reviewers report Apple refunds being DENIED — which turns a billing dispute into a permanent 1★

- **Where:** §1.5 Apple refunds
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 5 IDs
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Side effects:** when the platform refund fails, the app's own refund path is the last chance to avoid a 1★
- **Review IDs:** `10336428805`, `9896180923`, `13949866906`, `9913482153`, `10859158478`
- **Canonical:** C029 Billing must be exactly right

### R04-037 — The trial/plan-selection screen bills people who believed they had 7 days — 789 reviews, mean 1.35; nothing else is close

- **Where:** §1.7 #1
- **This app does:** trial misfires
- **User reaction:** 1★-burst
- **Magnitude:** 789 (3.86%), mean 1.35
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R04-005, R04-006
- **Canonical:** C109 A free trial must be a real trial

### R04-055 — Reliability of reminders and alarms — 212 reviews (1.04%, mean 2.82): 'I never get the notifications on my iPhone or my iWatch… what is the point of paying for this app'; 'the alarm doesn't sound if the app is closed'; 846 (4.13%) discuss notifications in any sentiment

- **Where:** Part 4 row 4 + #1
- **This app does:** notifications silent or absent, esp. app closed
- **User reaction:** 1★-burst
- **Magnitude:** 212 (1.04%), mean 2.82; 846 (4.13%) all-sentiment
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** 'we remind you' is the core promise; three of the quoted complainers are paying
- **Review IDs:** `10778781877`, `10934193537`, `11660101678`, `10358615519`, `9341354191`, `11341912770`, `10584691475`, `9783610640`, `11583930736`, `11628266726`, `8491078677`
- **Canonical:** C039 Reminders fire reliably, once

### R04-059 — Update regressions — 286 'used to be better' (1.40%) + 42 explicit update complaints: 'The app was everything I dreamt of… then Boom… updated! Now the interface is simply ugly, the progress is gone'

- **Where:** Part 4 #5
- **This app does:** updates that change layout and lose progress
- **User reaction:** complaint
- **Magnitude:** 286 (1.40%), mean 3.01; 42 (0.21%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10800043782`, `10905831477`, `10760745572`, `10936736844`, `13748454414`, `10763028336`, `13705509114`
- **Canonical:** C119 Updates must not regress layout or lose progress

### R04-066 — Bugs / crashes / not working — 444 (2.17%), mean 2.66

- **Where:** Part 4 row 7
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 444 (2.17%), mean 2.66
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R04-089 — Rebuild the trial/plan-selection screen so '7-day free trial' and 'charged now' cannot be confused — show the exact charge date and amount on the confirmation

- **Where:** Part 8 #1
- **This app does:** ambiguous trial screen
- **User reaction:** 1★-burst
- **Magnitude:** 789 (3.86%) directly; 1,247 (6.09%) cluster
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R04-005, R04-006
- **Canonical:** C109 A free trial must be a real trial

### R04-091 — Fix Brazilian (and LatAm/APAC) trial provisioning as a P0 — BR runs 7–11× the global billing-complaint rate

- **Where:** Part 8 #3
- **This app does:** per-storefront billing defect
- **User reaction:** 1★-burst
- **Magnitude:** 7–11× global
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R04-075
- **Canonical:** C109 A free trial must be a real trial

### R04-093 — Fix notification and alarm delivery, including sound and app-closed behaviour — it breaks the core promise for paying and ADHD users alike

- **Where:** Part 8 #5
- **This app does:** unreliable notifications
- **User reaction:** 1★-burst
- **Magnitude:** 212, mean 2.82
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R04-055, R04-069
- **Canonical:** C039 Reminders fire reliably, once

### R04-097 — Stabilise the price and retire the spin-wheel — users report $19.99–$59.99 for the same thing; that inconsistency is what 'scam' language attaches to

- **Where:** Part 8 #9
- **This app does:** variable price + gimmick
- **User reaction:** 1★-burst
- **Magnitude:** ≥9 price points; 583 scam accusations
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R04-014, R04-036
- **Canonical:** C113 One stable, disclosed price — no discount wheels

## Features

### R04-015 — More than ~4–7 daily tasks/habits is paywalled from mid-2025

- **Where:** §1.2 table row 1
- **This app does:** free task cap 4–7/day
- **User reaction:** 1★-burst
- **Magnitude:** 6 IDs; see R04-008
- **Direction for us:** build-free · **Report confidence:** meaningful (timing) · **Generalisable:** yes
- **Review IDs:** `13492344866`, `13684033797`, `14279264893`, `13028782607`, `13595977240`, `14496354181`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R04-016 — Preset routines / templates / 'programs' are paywalled

- **Where:** §1.2 table row 2
- **This app does:** templates paid
- **User reaction:** complaint
- **Magnitude:** 4 IDs
- **Direction for us:** build-paid · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13905359641`, `12941236061`, `10338746865`, `12946905191`
- **Canonical:** C118 Preset routines / templates / programs

### R04-017 — Workout, meditation, course and reflection/journal content is paywalled — the content library is the paid layer

- **Where:** §1.2 table row 3-4
- **This app does:** content library paid
- **User reaction:** purchase-driver
- **Magnitude:** 3 + 1 IDs; content is a stated purchase reason (§1.3)
- **Direction for us:** build-paid · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** a routine app that bundles a content library has something to sell that is not the core loop
- **Review IDs:** `10338746865`, `12363238702`, `12009622937`
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R04-018 — Themes, backgrounds and icons are paywalled

- **Where:** §1.2 table row 5
- **This app does:** cosmetics paid
- **User reaction:** complaint
- **Magnitude:** 1 ID
- **Direction for us:** build-paid · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `11996279048`
- **Canonical:** C018 App-icon themes

### R04-019 — Renaming and reordering tasks is paywalled — reported by two PAYING users as still restricted

- **Where:** §1.2 table row 6
- **This app does:** rename/reorder gated
- **User reaction:** complaint
- **Magnitude:** 2 paying-user IDs
- **Direction for us:** build-free · **Report confidence:** weak, severe · **Generalisable:** yes
- **Side effects:** gating basic editing of the user's own tasks is felt even by subscribers
- **Review IDs:** `10080398097`, `9690694863`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R04-020 — Confirmed usable free: creating your own routine within the cap, check-offs, streaks, mood check-ins, water tracking, alarms, sleep sounds, some quizzes — 'I did all of this without even buying premium'; 'o gratuito tem tudo'

- **Where:** §1.2 'usable free' line
- **This app does:** free core loop plus mood/water/alarms/sleep sounds
- **User reaction:** praise
- **Magnitude:** 5 IDs
- **Direction for us:** build-free · **Report confidence:** stated · **Generalisable:** yes
- **Review IDs:** `11808709309`, `10932819511`, `11104177160`, `11602799352`, `11881173938`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C008 Daily check-in and one basic reminder per habit are free

### R04-028 — Purchase trigger: the content library (sleep scoring, soundscapes, meditation)

- **Where:** §1.3 trigger row 6
- **This app does:** content library paid
- **User reaction:** purchase-driver
- **Magnitude:** 1 ID
- **Direction for us:** build-paid · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `10490388620`
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R04-050 — Motivation and streaks — 790 (3.86%), mean 4.32

- **Where:** Part 3 §5
- **This app does:** streaks + motivational loop
- **User reaction:** praise
- **Magnitude:** 790 (3.86%), mean 4.32
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12165876117`, `11439226063`, `12231145076`, `11795008246`
- **Canonical:** C024 Streaks / gamification

### R04-051 — The content library — workouts 484 (2.37%, 4.23), sleep 148 (0.72%, 4.08), journal/mood 259 (1.27%, 4.17) — is a real differentiator against pure habit trackers and the paid layer's substance

- **Where:** Part 3 §6
- **This app does:** bundled workouts, meditation, sleep sounds, journal, mood
- **User reaction:** praise
- **Magnitude:** 484 + 148 + 259
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** a paid tier needs something beyond the core loop to sell; content is one answer
- **Review IDs:** `12787145374`, `11500466306`, `12396370842`, `11626250981`, `12952812019`, `10490388620`
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R04-053 — The mascot / character — 50 (0.24%), mean 3.94 — weak but pure: 'there's this very sweet chick that helps you'

- **Where:** Part 3 §8
- **This app does:** a chick mascot
- **User reaction:** praise
- **Magnitude:** 50 (0.24%), mean 3.94
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12251793690`, `13558821605`
- **Canonical:** C117 Mascot / companion character

### R04-054 — Top complaints and unmet needs, 25 rows — full table

- **Where:** Part 4 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** # | Theme | n | % | Mean | Band | Direction ; 1 | Must pay to use / paywall blocks core action | 1,903 | 9.30% | 2.69 | High-priority | Negative ; 2 | Feature requests ("wish it could…") | 1,352 | 6.61% | 3.68 | High-priority | Mixed ; 3 | Trial charged immediately | 789 | 3.86% | 1.35 | Very strong | Negative ; 4 | Notifications / reminders (all sentiment) | 846 | 4.13% | 3.63 | Very strong | Mixed ; 5 | Scam / misleading accusation | 583 | 2.85% | 1.29 | Meaningful | Negative ; 6 | Refund demanded | 551 | 2.69% | 1.22 | Meaningful | Negative ; 7 | Bugs / crashes / not working | 444 | 2.17% | 2.66 | Meaningful | Negative ; 8 | Unexpected charge | 429 | 2.10% | 1.20 | Meaningful | Negative ; 9 | Upsell pop-ups / nagging | 417 | 2.04% | 3.11 | Meaningful | Negative ; 10 | Customisation limits (rename, reorder, edit) | 399 | 1.95% | 3.08 | Meaningful | Negative ; 11 | Localisation / language missing | 454 | 2.22% | 3.26 | Meaningful | Negative ; 12 | "More free features please" | 369 | 1.80% | 3.21 | Meaningful | Mixed ; 13 | Price too high | 324 | 1.58% | 2.37 | Meaningful | Negative ; 14 | "It used to be better / used to be free" | 286 | 1.40% | 3.01 | Meaningful | Negative ; 15 | Confusing / hard to learn | 275 | 1.34% | 2.73 | Meaningful | Negative ; 16 | Long onboarding quiz | 256 | 1.25% | 1.98 | Meaningful | Negative ; 17 | Notifications/alarms don't fire | 212 | 1.04% | 2.82 | Meaningful | Negative ; 18 | Cannot cancel | 169 | 0.83% | 1.22 | Emerging | Negative ; 19 | Sync / login / new-device loss | 154 | 0.75% | 2.43 | Emerging | Negative ; 20 | Ad ≠ app (advertised features absent) | 126 | 0.62% | 2.42 | Emerging | Negative ; 21 | Scheduling flexibility (weekly/monthly/repeat) | 332 | 1.62% | 2.77 | Meaningful | Negative ; 22 | Backup / iCloud / export | 115 | 0.56% | 3.67 | Emerging | Negative ; 23 | Editing future days blocked | 112 | 0.55% | 3.12 | Emerging | Negative ; 24 | Data loss | 55 | 0.27% | 2.40 | Weak | Negative ; 25 | Free daily-task cap | 57 | 0.28% | 2.58 | Weak | Negative
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R04-056 — Scheduling flexibility — 332 (1.62%, mean 2.77): weekly, monthly, every-other-day, X-times-per-week, time windows; the most-voted product-feedback review in the corpus (109 votes) asks for it; declined 2.49% (2023) → 0.67% (2026) — partially addressed, not solved

- **Where:** Part 4 #2
- **This app does:** daily-only routines; partial improvement
- **User reaction:** complaint
- **Magnitude:** 332 (1.62%), mean 2.77; 2.49% → 0.67%
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10518775457`, `11002520527`, `9693649611`, `10490388620`, `10033970966`, `13153079287`, `10339253592`
- **Canonical:** C043 Flexible / custom frequency

### R04-057 — Editing and reordering — 399 customisation reviews (1.95%) + 112 future-day-editing reviews (0.55%): the future-day block was a 2023 problem (1.35% → 0.22%) and looks fixed; renaming and reordering are not — three paying users complain

- **Where:** Part 4 #3
- **This app does:** cannot rename or reorder tasks; future-day editing fixed
- **User reaction:** complaint
- **Magnitude:** 399 (1.95%), mean 3.08; 112 (0.55%)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** an AuDHD user on a layout regression — layout changes hit neurodivergent users hardest
- **Review IDs:** `10080398097`, `9690694863`, `10278130819`, `9774990643`, `10311098663`, `10763448380`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R04-060 — Customisation limits (rename, reorder, edit) — 399 (1.95%), mean 3.08

- **Where:** Part 4 row 10
- **This app does:** editing gated/limited
- **User reaction:** complaint
- **Magnitude:** 399 (1.95%), mean 3.08
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R04-063 — Confusing / hard to learn — 275 (1.34%), mean 2.73

- **Where:** Part 4 row 15
- **This app does:** complex UI
- **User reaction:** complaint
- **Magnitude:** 275 (1.34%), mean 2.73
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C075 Skippable, replayable onboarding tour; C006 Stay minimal and ad-free

### R04-100 — Full task editing: rename, reorder, drag, duplicate — 399 reviews (1.95%) and the top complaint among PAYING users

- **Where:** Part 8 #12
- **This app does:** editing gated/limited
- **User reaction:** complaint
- **Magnitude:** 399 (1.95%)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R04-019, R04-057, R04-060
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R04-101 — Finish flexible scheduling: weekly, monthly, every-N-days, X-times-per-week, time windows — improving but still 0.67% of 2026 reviews at mean 2.77

- **Where:** Part 8 #13
- **This app does:** partially shipped
- **User reaction:** complaint
- **Magnitude:** 332 (1.62%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R04-056
- **Canonical:** C043 Flexible / custom frequency

### R04-102 — Ship the widget properly and let users check off from it — 151 reviews (0.74%, mean 3.79, 39.1% 5★), currently a POSITIVE theme with a clear ask: 'make you cross off the tasks directly from the widget' (35 votes)

- **Where:** Part 8 #14
- **This app does:** widget exists, not interactive
- **User reaction:** mixed
- **Magnitude:** 151 (0.74%), mean 3.79
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10220454829`, `12010228356`
- **Canonical:** C023 Interactive widget check-off; C009 Basic widgets, icons and colours are free

### R04-103 — Apple Watch — 34 reviews (0.17%, weak) but mean 3.68 and asked for by payers

- **Where:** Part 8 #15
- **This app does:** no Watch app
- **User reaction:** complaint
- **Magnitude:** 34 (0.17%), mean 3.68
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `14294898131`, `10778781877`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R04-105 — Keep the content library — workouts, meditation, soundscapes, sleep — it is what separates Me+ from 'a fancy Reminders app'

- **Where:** Part 8 #17
- **This app does:** content library
- **User reaction:** praise
- **Magnitude:** 484 + 148 + 259
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R04-051, R04-072
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

## Monetization

### R04-011 — Free download with a subscription-gated 'VIP' tier at $39.99/year or $9.99/month

- **Where:** §1.1 bullet 1
- **This app does:** subscription only
- **User reaction:** mixed
- **Magnitude:** listing text 2026-09-09
- **Direction for us:** research · **Report confidence:** external source · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R04-012 — No advertising business: only 55 reviews (0.27%) complain about ads and most mean subscription pop-ups; 67 (0.33%, mean 4.45, 74.6% 5★) explicitly praise the absence of ads

- **Where:** §1.1 bullet 2
- **This app does:** no third-party ads
- **User reaction:** praise
- **Magnitude:** 55 (0.27%) complaints; 67 (0.33%) praise at 4.45
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10558237535`, `10144485344`, `11808709309`
- **Canonical:** C006 Stay minimal and ad-free; C082 Ads in the free tier

### R04-014 — The price spread is the finding: users in the same market and period report $19.99, $29.99, $30, $39.99, $44 and $59.99; combined with the discount wheel nobody can tell another user what the app costs — exactly the condition under which 'scam' language spreads; 'I selected 1 month at 69.90 and 89.90 was debited'

- **Where:** §1.1 price table + bold
- **This app does:** inconsistent, undisclosed pricing; discount wheel
- **User reaction:** 1★-burst
- **Magnitude:** $30 | 50 | `10623112709`, `10568183655`, `12305346345`, `11444190900` ; $40 | 45 | `12867585648`, `13462407141`, `10674600761` ; $20 | 32 | `11465293117`, `12192965094`, `10213537631` ; $60 | 24 | `10449883273`, `9915339274`, `13130109012` ; $29.99 | 19 | `14400482233`, `12824631044`, `14492111472` ; $39.99 | 18 | `10874510575`, `10780491946`, `10635080982` ; $19.99 | 17 | `12419775649`, `11843514371`, `10336428805` ; $12.99 / $13 monthly | 16 | `11534848272`, `12864390376`, `11995827805` ; £26.99 · £12.99 | 16 | `13045944281`, `11330094474`, `13613637863` ; R$167,90 · R$219 · R$107 | 13+ | `14511513737`, `12916905050`, `10531986957`, `11005436107` ; $45.99 · $44 · $43 · $32.09 | 21 | `11235083153`, `12305346345`, `10405795762`, `10930935136`
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a single, stable, disclosed price is a trust feature
- **Review IDs:** `10623112709`, `10568183655`, `12305346345`, `11444190900`, `12867585648`, `13462407141`, `10674600761`, `11465293117`, `12192965094`, `10213537631`, `10449883273`, `9915339274`, `13130109012`, `14400482233`, `12824631044`, `14492111472`, `10874510575`, `10780491946`, `10635080982`, `12419775649`, `11843514371`, `10336428805`, `11534848272`, `12864390376`, `11995827805`, `13045944281`, `11330094474`, `13613637863`, `14511513737`, `12916905050`, `10531986957`, `11005436107`, `11235083153`, `10405795762`, `10930935136`, `10483361084`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R04-042 — No one-time / lifetime option — only 20 reviews (0.10%) ask for one, but the ask is unanimous where it appears

- **Where:** §1.7 #6
- **This app does:** subscription only
- **User reaction:** blocked-conversion
- **Magnitude:** 20 (0.10%)
- **Direction for us:** product-rule · **Report confidence:** ignore-band, unanimous · **Generalisable:** yes
- **Review IDs:** `10930935136`, `12009622937`, `11483126752`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R04-061 — 'More free features please' — 369 (1.80%), mean 3.21

- **Where:** Part 4 row 12
- **This app does:** thin free tier (post-cap)
- **User reaction:** complaint
- **Magnitude:** 369 (1.80%), mean 3.21
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R04-062 — Price too high — 324 (1.58%), mean 2.37

- **Where:** Part 4 row 13
- **This app does:** $39.99/yr
- **User reaction:** complaint
- **Magnitude:** 324 (1.58%), mean 2.37
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R04-098 — Add a one-time / lifetime SKU — small explicit demand (20) but it is the standard objection format in this category and would convert the 'I'd pay, just not monthly' segment

- **Where:** Part 8 #10
- **This app does:** subscription only
- **User reaction:** blocked-conversion
- **Magnitude:** 20 (0.10%)
- **Direction for us:** product-rule · **Report confidence:** ignore-band, category norm · **Generalisable:** yes
- **Conditions:** evidence: R04-042
- **Canonical:** C003 Lead with a one-time lifetime purchase

## Tactics the app used

### R04-013 — A 7-day trial exists on at least one plan, and a discount wheel / 'limited time offer' mechanic runs throughout 2022–2026

- **Where:** §1.1 bullet 3
- **This app does:** trial on one plan; spin-the-wheel discounts
- **User reaction:** mixed
- **Magnitude:** present 2022–2026
- **Direction for us:** dont · **Report confidence:** stated · **Generalisable:** yes
- **Conditions:** the wheel is named in 26 reviews and reported rigged or broken by several (§1.6)
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C109 A free trial must be a real trial

### R04-024 — Purchase trigger: a discount / sale converted them — 'I bought the yearly subscription when it was on sale'

- **Where:** §1.3 trigger row 2
- **This app does:** sales and discount offers
- **User reaction:** purchase-driver
- **Magnitude:** 3 IDs
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10833842651`, `11189969039`, `10456692189`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

## Insights (the why)

### R04-004 — Money, not product quality, produces one-star reviews: 57.1% of 1★ reviews mention a monetization theme (vs 4.9% of 5★); 3,805 reviews (18.59%) touch monetization at mean 2.30 and 62.2% 1–2★ — nothing else in the corpus is remotely this large or this negative

- **Where:** Part 0 §2 + table
- **This app does:** aggressive subscription funnel
- **User reaction:** 1★-burst
- **Magnitude:** 3,805 (18.59%), mean 2.30, 62.2% 1–2★; Band | n | Any monetization theme ; 5★ | 12,308 | 4.9% ; 4★ | 2,288 | 19.7% ; 3★ | 1,421 | 27.5% ; 2★ | 1,010 | 39.7% ; 1★ | 3,438 | 57.1%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R04-010 — The product underneath is genuinely good — 26.46% discuss organisation outcomes (mean 4.29), 17.82% are strong endorsements ('changed my life', mean 4.77, 2.1% 1–2★), 6.96% are ADHD/anxiety/depression/OCD/autism users (4.14), 5.40% praise design; the most-voted English review (178 votes) praises a free tier that later reviewers say no longer exists

- **Where:** Part 0 §7
- **This app does:** good routine planner under an aggressive funnel
- **User reaction:** praise
- **Magnitude:** 5,416 (26.46%) at 4.29; 3,646 (17.82%) at 4.77; 1,424 (6.96%) at 4.14; 1,106 (5.40%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 'Unlike countless other planner apps out there you don't have to pay to actually be able to use the app' — the review that carried the app is three years old
- **Review IDs:** `10234553092`, `9856023384`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C001 Never move a free feature behind the paywall

### R04-021 — 413 reviews (2.02%) 'praise' the free tier at a mean of only 3.43 because the same vocabulary is used by people saying 'it's free' and people saying 'it says free but isn't' — the clearest evidence that the free/paid boundary is not legible to users

- **Where:** §1.2 bold
- **This app does:** illegible free/paid boundary
- **User reaction:** mixed
- **Magnitude:** 413 (2.02%), mean 3.43
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** legibility of what is free is itself a product requirement
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R04-022 — 319 reviews (1.56%) contain first-person purchase evidence in six languages; full list in §9.8

- **Where:** §1.3 opening
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 319 (1.56%)
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R04-023 — Purchase trigger: wanted the full routine after the free cap blocked them

- **Where:** §1.3 trigger row 1
- **This app does:** cap → upgrade
- **User reaction:** purchase-driver
- **Magnitude:** 3 IDs
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** the cap does convert some — but see R04-008 for what it costs
- **Review IDs:** `13249657539`, `12938776811`, `10080398097`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R04-025 — Purchase trigger: gratitude — the free tier already worked: 'I subscribed to VIP only out of gratitude, because the free version has everything'

- **Where:** §1.3 trigger row 3
- **This app does:** generous free tier
- **User reaction:** purchase-driver
- **Magnitude:** 2 IDs
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** yes
- **Side effects:** generosity converts through goodwill — the same mechanism as report 2's 'support the developer'
- **Review IDs:** `11104177160`, `11808709309`
- **Canonical:** C061 'Support the devs' goodwill converts; C007 Generous fixed habit cap (or unlimited) — never change it

### R04-029 — Confirmed payers (n=319) vs corpus: mean 1.87 vs 3.93; 1★ 60.8% vs 16.80%; refund demanded 23.5%; trial-deception 19.7%; scam 13.5%; cancellation difficulty 9.7%; unexpected charge 8.5%; bugs 6.6%; strong endorsement 2.8%

- **Where:** §1.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** | Confirmed payers (n = 319) | Whole corpus (n = 20,465) ; Mean rating | 1.87 | 3.93 ; 1★ | 60.8% | 16.80% ; 5★ | 6.9% | 60.14% ; Refund demanded | 23.5% | 2.69% ; Trial-deception claim | 19.7% | 3.86% ; Scam accusation | 13.5% | 2.85% ; Cancellation difficulty | 9.7% | 0.83% ; Unexpected charge | 8.5% | 2.10% ; Any bug complaint | 6.6% | 2.17% ; Strong endorsement | 2.8% | 17.82%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R04-031 — The 45 positive payers (4–5★, mean 4.49, zero 1–2★) value the OUTCOME, not the feature list — 'I DID ALL OF MY TASKS USING ME+'; 'I don't mind paying the small amount'

- **Where:** §1.4 positive payers
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 45 payers, mean 4.49
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10874402938`, `11572989949`, `10833842651`, `11808709309`, `10490388620`, `11110151999`, `9715195066`, `10327263723`, `11104177160`, `11996279048`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R04-043 — What produces 5★ (n=12,308): organisation outcome 30.7%, strong endorsement 25.1%, mental-health context 7.8%, design 4.6%, motivation/streaks 4.4%, ADHD 4.7%, workout/meditation content 2.5%, free tier 1.6%, any monetization 4.9% — 5★ reviews are short, emotional, about outcomes

- **Where:** Part 2 5★ table (verbatim)
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** Theme | n | % of 5★ ; Organisation / routine / productivity outcome | 3,774 | 30.7% ; Strong endorsement ("best app", "changed my life") | 3,090 | 25.1% ; Mental-health / neurodivergence context | 960 | 7.8% ; Design / cuteness / aesthetic | 563 | 4.6% ; Motivation, streaks, accountability | 541 | 4.4% ; ADHD specifically | 575 | 4.7% ; Workout / meditation content | 306 | 2.5% ; Free tier praised | 195 | 1.6% ; Any monetization theme | 599 | 4.9%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12165876117`, `11471121244`, `10402434611`, `12146411524`, `11002598099`, `10814031887`, `12070744997`
- **Canonical:** — (nuance register)

### R04-044 — The 1★ band is a billing-complaints channel: must-pay 21.4%, trial charged 18.9%, scam 14.8%, refund 14.2%, unexpected charge 11.3%, cannot cancel 4.4%; only 4.4% of 1★ are about the app breaking; 2★ is where disappointed users sit (bugs 6.5%, nagging 5.4%), 1★ is where charged users sit

- **Where:** Part 2 1–2★ table (verbatim) + bold
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | 1★ n | % of 1★ | 2★ n | % of 2★ ; Must pay to use | 735 | 21.4% | 219 | 21.7% ; Trial charged immediately | 650 | 18.9% | 65 | 6.4% ; Scam / fraud / misleading | 509 | 14.8% | 33 | 3.3% ; Refund demanded | 489 | 14.2% | 29 | 2.9% ; Unexpected charge | 389 | 11.3% | 16 | 1.6% ; I paid (and regret it) | 194 | 5.6% | 41 | 4.1% ; Long onboarding quiz | 150 | 4.4% | 34 | 3.4% ; Cannot cancel | 151 | 4.4% | 7 | 0.7% ; Bugs / crashes / not working | 151 | 4.4% | 66 | 6.5% ; Price too high | 145 | 4.2% | 41 | 4.1%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 1★ = charged; 2★ = disappointed — two different fixes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R04-045 — 3–4★ is one coherent message: 'great app, but the paywall and a few missing capabilities stop me giving it five' — feature requests 16.3% of 3★ / 14.9% of 4★, must-pay 17.9% / 12.9%, notifications 7.2% / 5.0%, language 5.1% / 4.4%; 1,352 reviews (6.61%, high-priority) contain an explicit feature request

- **Where:** Part 2 3–4★ table (verbatim) + bold
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | 3★ % | 4★ % ; Feature request / "wish it had…" | 16.3% | 14.9% ; Must pay to use | 17.9% | 12.9% ; Notifications / reminders discussed | 7.2% | 5.0% ; Language request | 5.1% | 4.4% ; Bugs | 5.8% | 3.1% ; Upsell nagging | 4.1% | 3.6% ; Customisation limits | 3.9% | 2.8% ; Regression ("used to be better") | 3.2% | 2.1%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R04-046 — Getting organised — 26.46% at mean 4.29 — the core loop works: 'on days where I didn't complete my tasks it would just drive me to complete them the next day'

- **Where:** Part 3 §1
- **This app does:** daily routine checklist
- **User reaction:** praise
- **Magnitude:** 5,416 (26.46%), mean 4.29
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12165876117`, `11002598099`, `10334087672`, `12363238702`, `10790031201`, `11026211815`, `12732230801`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R04-047 — Strong endorsement / life change — 17.82% at mean 4.77, only 2.1% 1–2★

- **Where:** Part 3 §2
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 3,646 (17.82%), mean 4.77
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10932819511`, `11471121244`, `12146411524`, `12630538551`, `11477431119`, `12886388716`, `13546357208`
- **Canonical:** — (nuance register)

### R04-052 — Ease of use — 479 (2.34%), mean 3.89 — and no ads 67 (0.33%), mean 4.45

- **Where:** Part 3 §7
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 479 (2.34%); 67 (0.33%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11808709309`, `10938043754`, `10558237535`
- **Canonical:** C006 Stay minimal and ad-free

## Audiences

### R04-026 — Purchase trigger: the ADHD outcome was worth paying for — 'I have severe ADHD and this is a game changer… it triggers my dopamine like crazy'

- **Where:** §1.3 trigger row 4
- **This app does:** ADHD-friendly routine loop
- **User reaction:** purchase-driver
- **Magnitude:** 2 IDs
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10874402938`, `11572989949`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R04-048 — Mental-health and neurodivergence fit is the app's strongest defensible position: 1,424 (6.96%, mean 4.14), 922 (4.51%) name ADHD specifically and 62.4% of ADHD reviews are 5★

- **Where:** Part 3 §3
- **This app does:** routine planner marketed to and adopted by ADHD/anxiety/depression/OCD/autism users
- **User reaction:** praise
- **Magnitude:** 1,424 (6.96%) at 4.14; ADHD 922 (4.51%), 575 5★
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10234553092`, `10144485344`, `11009832175`, `10603862753`, `10514993532`, `11097971505`, `13030561157`, `12952812019`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R04-067 — 89 reviews (0.43%, mean 2.60) raise shame, guilt, body image, weight-loss framing or disordered-eating risk — promoted despite the 0.5% bar because the app is rated 4+, heavily used by teenagers, and markets 'weight loss' and 'anti-aging'; 'Promotes shame and disordered eating behaviours' (46 votes); 'Suppress my hunger?? Why? This isn't a diet app'; 'It compared an ADHD brain to a NORMAL brain'; 'a money mill for anxious teens'

- **Where:** Part 4 'safety-adjacent' theme
- **This app does:** diet/weight/anti-aging framing in the quiz and content
- **User reaction:** 1★-burst
- **Magnitude:** 89 (0.43%), mean 2.60; one 46-vote review
- **Direction for us:** dont · **Report confidence:** weak count, safety · **Generalisable:** yes
- **Side effects:** a quiz that probes anxieties or hunger, in a 4+ app used by teens, is a reputational risk beyond its count
- **Conditions:** daily mood check-ins can read as 'depressing' to the users they target
- **Review IDs:** `10163266248`, `10568183655`, `9893977621`, `10776165546`, `10093089650`, `11198749049`, `9683736698`, `10852967602`, `11628266726`
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R04-068 — 455 reviews (2.22%, mean 4.08) are by or about children and teenagers — and the paywall lands on them directly: 'I'm just a kid and I don't have the money'; 'I am ten years old'

- **Where:** Part 4 teens paragraph
- **This app does:** 4+ rated, teen-heavy audience, subscription paywall
- **User reaction:** mixed
- **Magnitude:** 455 (2.22%), mean 4.08
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** a teen audience cannot pay — a paywall on them produces 1★ with no revenue
- **Review IDs:** `11275052684`, `13111676999`, `9847060220`, `10294858917`, `10740385550`, `10402434611`
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R04-069 — ADHD / neurodivergent / mental-health users (6.96%, mean 4.14) are the highest-affinity segment, already targeted by TikTok ADHD advertising, and describe the app as external executive function — but they are also the MOST sensitive to the two core failures: 'The notifications were too small and quiet'; 'Would have been the perfect app for my adhd… Such a let down'; 'it literally had 10 X my ADHD'

- **Where:** Part 5 Audience 1
- **This app does:** markets to ADHD via TikTok
- **User reaction:** mixed
- **Magnitude:** 1,424 (6.96%), mean 4.14
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the audience with the highest affinity has the lowest tolerance for quiet notifications and monetisation friction
- **Conditions:** 'I get the impression that it was not done appropriately with a person with ADHD' — targeting an audience without designing for it is noticed
- **Review IDs:** `9761650498`, `10234553092`, `10144485344`, `11009832175`, `10603862753`, `10874402938`, `13030561157`, `11737896926`, `11966341472`, `12351646655`, `13546357208`, `11912129408`, `13763732961`, `10093089650`, `14382272365`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R04-070 — Students and teenagers — 587 student (2.87%, mean 4.29) + 455 kid/teen (2.22%, mean 4.08) — overwhelmingly positive, structurally unable to pay: 'I am a school student and I don't really have any money'

- **Where:** Part 5 Audience 2
- **This app does:** subscription paywall on a teen/student audience
- **User reaction:** praise
- **Magnitude:** 587 + 455
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11758706305`, `10355048847`, `11575208811`, `10849775714`, `10431447166`
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R04-071 — Parents managing family routines — 77 reviews (0.38%, mean 4.14) — weak but commercially interesting; the free cap broke exactly this use case ('a free daily app to put my kids chores on')

- **Where:** Part 5 Audience 3
- **This app does:** no family/kids mode; cap blocks multi-kid chore lists
- **User reaction:** mixed
- **Magnitude:** 77 (0.38%), mean 4.14
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10775929289`, `11671331301`, `12949351767`, `10568183655`
- **Canonical:** C068 Parents tracking kids

### R04-104 — Lead with ADHD / executive-function support — 4.51% of the corpus, 62.4% 5★, and the segment that pays for outcomes

- **Where:** Part 8 #16
- **This app does:** already markets ADHD via TikTok
- **User reaction:** purchase-driver
- **Magnitude:** 922 (4.51%), 62.4% 5★
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R04-048, R04-069
- **Review IDs:** `10874402938`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

## Markets and languages

### R04-073 — All 43 storefronts with ≥50 reviews: n, mean, 1–2★, 5★, trial, charged, refund, scam, paywall, price, nag, quiz, lang, bug, endorse, organ, adhd — full table

- **Where:** Part 6 country table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** cc | Country | n | Mean | 1–2★ | 5★ | trial | charged | refund | scam | paywall | price | nag | quiz | lang | bug | endorse | organ | adhd ; us | United States | 9338 | 3.98 | 20.6% | 61.7% | 3.1% | 1.3% | 1.9% | 2.3% | 9.7% | 1.6% | 2.6% | 1.6% | 0.2% | 2.4% | 22.4% | 29.6% | 5.9% ; gb | United Kingdom | 1925 | 4.08 | 17.9% | 64.2% | 2.8% | 0.9% | 1.5% | 1.9% | 9.1% | 1.8% | 2.4% | 1.5% | 0.2% | 1.5% | 19.5% | 31.0% | 7.2% ; ca | Canada | 948 | 3.68 | 28.1% | 52.7% | 7.0% | 1.5% | 3.6% | 7.5% | 11.3% | 2.5% | 2.0% | 1.5% | 0.7% | 1.8% | 18.1% | 24.7% | 4.7% ; au | Australia | 927 | 4.01 | 19.0% | 59.2% | 3.0% | 1.1% | 1.5% | 1.9% | 9.0% | 1.8% | 3.0% | 1.2% | 0.1% | 1.8% | 20.9% | 31.2% | 5.6% ; br | Brazil | 843 | 3.55 | 33.8% | 56.1% | 13.8% | 14.5% | 14.8% | 5.7% | 11.2% | 0.7% | 0.2% | 0.5% | 2.7% | 1.9% | 4.7% | 22.4% | 0.7% ; mx | Mexico | 708 | 4.21 | 15.1% | 68.9% | 2.8% | 2.3% | 2.3% | 2.0% | 7.3% | 2.5% | 0.4% | 0.0% | 4.0% | 2.1% | 5.4% | 25.4% | 0.3% ; fr | France | 464 | 3.87 | 19.4% | 51.5% | 2.6% | 2.2% | 0.6% | 2.6% | 17.9% | 1.3% | 1.3% | 1.3% | 12.1% | 3.0% | 19.4% | 25.9% | 4.1% ; es | Spain | 287 | 3.61 | 30.3% | 52.3% | 6.3% | 2.1% | 4.5% | 7.3% | 16.0% | 1.0% | 0.7% | 0.0% | 6.6% | 2.4% | 5.9% | 25.1% | 0.7% ; de | Germany | 286 | 3.73 | 25.5% | 51.0% | 1.4% | 4.2% | 1.0% | 2.8% | 5.6% | 2.4% | 1.7% | 0.7% | 4.2% | 3.8% | 17.8% | 23.4% | 3.1% ; tr | Turkey | 234 | 3.72 | 24.8% | 51.7% | 8.1% | 0.9% | 3.0% | 2.6% | 8.5% | 1.3% | 0.9% | 0.9% | 19.7% | 1.7% | 7.3% | 10.7% | 0.4% ; co | Colombia | 210 | 4.01 | 19.0% | 62.9% | 2.9% | 5.2% | 3.3% | 1.4% | 9.0% | 1.4% | 1.0% | 0.0% | 6.2% | 2.9% | 7.6% | 27.1% | 0.0% ; cl | Chile | 194 | 3.23 | 41.2% | 46.9% | 10.8% | 7.7% | 6.7% | 10.8% | 13.4% | 6.2% | 0.5% | 3.6% | 6.7% | 4.6% | 2.6% | 18.6% | 2.6% ; nl | Netherlands | 176 | 3.34 | 36.9% | 46.0% | 5.7% | 1.1% | 1.7% | 4.0% | 8.5% | 1.1% | 0.6% | 2.3% | 11.4% | 0.0% | 14.2% | 14.2% | 1.7% ; do | Dominican Rep. | 154 | 4.35 | 12.3% | 74.0% | 1.9% | 1.9% | 0.6% | 0.0% | 4.5% | 1.3% | 0.0% | 0.6% | 7.1% | 0.0% | 14.3% | 28.6% | 0.6% ; se | Sweden | 151 | 3.91 | 20.5% | 55.0% | 0.7% | 0.0% | 0.0% | 0.7% | 7.9% | 0.0% | 5.3% | 0.7% | 1.3% | 4.6% | 12.6% | 14.6% | 4.0% ; za | South Africa | 137 | 4.22 | 17.5% | 68.6% | 2.2% | 0.7% | 0.0% | 0.7% | 8.0% | 1.5% | 3.6% | 0.7% | 0.7% | 1.5% | 21.2% | 24.8% | 1.5% ; in | India | 131 | 3.24 | 41.2% | 47.3% | 4.6% | 4.6% | 7.6% | 3.8% | 6.9% | 2.3% | 0.8% | 2.3% | 0.0% | 1.5% | 19.1% | 21.4% | 3.8% ; be | Belgium | 119 | 3.95 | 20.2% | 58.0% | 0.0% | 2.5% | 3.4% | 1.7% | 6.7% | 1.7% | 0.8% | 2.5% | 1.7% | 1.7% | 21.0% | 14.3% | 1.7% ; nz | New Zealand | 118 | 3.45 | 31.4% | 47.5% | 14.4% | 5.1% | 6.8% | 5.9% | 11.9% | 0.8% | 2.5% | 0.8% | 0.0% | 0.8% | 16.9% | 20.3% | 6.8% ; no | Norway | 117 | 4.23 | 13.7% | 65.0% | 1.7% | 0.0% | 0.0% | 0.9% | 11.1% | 0.0% | 0.0% | 0.9% | 0.9% | 1.7% | 17.1% | 25.6% | 3.4% ; ar | Argentina | 115 | 3.58 | 32.2% | 51.3% | 1.7% | 2.6% | 4.3% | 6.1% | 10.4% | 0.9% | 0.9% | 0.0% | 2.6% | 2.6% | 2.6% | 24.3% | 0.9% ; it | Italy | 110 | 3.75 | 22.7% | 50.9% | 1.8% | 0.0% | 1.8% | 2.7% | 2.7% | 0.9% | 1.8% | 0.0% | 2.7% | 2.7% | 7.3% | 29.1% | 2.7% ; ru | Russia | 104 | 3.99 | 13.5% | 50.0% | 0.0% | 0.0% | 0.0% | 0.0% | 3.8% | 0.0% | 0.0% | 1.0% | 51.9% | 1.0% | 3.8% | 2.9% | 0.0% ; pl | Poland | 102 | 3.29 | 36.3% | 39.2% | 7.8% | 2.0% | 2.0% | 2.9% | 3.9% | 1.0% | 3.9% | 0.0% | 13.7% | 2.0% | 11.8% | 19.6% | 2.0% ; dk | Denmark | 101 | 3.63 | 26.7% | 46.5% | 2.0% | 0.0% | 1.0% | 2.0% | 11.9% | 3.0% | 0.0% | 2.0% | 1.0% | 0.0% | 14.9% | 11.9% | 0.0% ; ch | Switzerland | 100 | 3.69 | 27.0% | 52.0% | 3.0% | 3.0% | 1.0% | 1.0% | 11.0% | 3.0% | 0.0% | 1.0% | 3.0% | 2.0% | 10.0% | 19.0% | 1.0% ; ph | Philippines | 98 | 3.74 | 23.5% | 54.1% | 7.1% | 3.1% | 8.2% | 8.2% | 5.1% | 2.0% | 0.0% | 0.0% | 0.0% | 1.0% | 18.4% | 18.4% | 2.0% ; vn | Vietnam | 92 | 3.68 | 26.1% | 50.0% | 3.3% | 2.2% | 9.8% | 3.3% | 1.1% | 0.0% | 1.1% | 0.0% | 14.1% | 0.0% | 3.3% | 7.6% | 1.1% ; ie | Ireland | 90 | 4.18 | 16.7% | 72.2% | 3.3% | 2.2% | 2.2% | 2.2% | 12.2% | 2.2% | 2.2% | 0.0% | 0.0% | 1.1% | 20.0% | 33.3% | 1.1% ; il | Israel | 88 | 3.89 | 20.5% | 54.5% | 2.3% | 0.0% | 1.1% | 2.3% | 3.4% | 0.0% | 3.4% | 0.0% | 1.1% | 1.1% | 9.1% | 10.2% | 2.3% ; ae | UAE | 87 | 4.32 | 11.5% | 74.7% | 4.6% | 1.1% | 5.7% | 3.4% | 9.2% | 0.0% | 1.1% | 0.0% | 0.0% | 0.0% | 18.4% | 20.7% | 5.7% ; my | Malaysia | 87 | 3.94 | 24.1% | 63.2% | 3.4% | 1.1% | 3.4% | 3.4% | 5.7% | 1.1% | 3.4% | 0.0% | 0.0% | 2.3% | 10.3% | 18.4% | 4.6% ; pe | Peru | 75 | 3.93 | 21.3% | 62.7% | 2.7% | 4.0% | 1.3% | 4.0% | 12.0% | 1.3% | 0.0% | 0.0% | 6.7% | 2.7% | 6.7% | 29.3% | 0.0% ; sa | Saudi Arabia | 75 | 4.20 | 16.0% | 69.3% | 1.3% | 1.3% | 2.7% | 1.3% | 4.0% | 1.3% | 1.3% | 1.3% | 16.0% | 1.3% | 10.7% | 14.7% | 2.7% ; pt | Portugal | 74 | 3.45 | 31.1% | 41.9% | 4.1% | 5.4% | 2.7% | 0.0% | 5.4% | 0.0% | 0.0% | 0.0% | 14.9% | 4.1% | 5.4% | 8.1% | 1.4% ; ec | Ecuador | 65 | 4.05 | 20.0% | 69.2% | 4.6% | 6.2% | 3.1% | 3.1% | 4.6% | 1.5% | 0.0% | 0.0% | 7.7% | 0.0% | 10.8% | 20.0% | 0.0% ; at | Austria | 60 | 3.53 | 28.3% | 46.7% | 1.7% | 5.0% | 1.7% | 3.3% | 5.0% | 5.0% | 0.0% | 0.0% | 0.0% | 5.0% | 16.7% | 20.0% | 3.3% ; eg | Egypt | 60 | 4.02 | 20.0% | 63.3% | 5.0% | 0.0% | 3.3% | 5.0% | 3.3% | 1.7% | 0.0% | 0.0% | 1.7% | 0.0% | 26.7% | 26.7% | 0.0% ; fi | Finland | 55 | 4.05 | 20.0% | 65.5% | 3.6% | 0.0% | 0.0% | 1.8% | 12.7% | 0.0% | 1.8% | 0.0% | 0.0% | 3.6% | 10.9% | 10.9% | 7.3% ; sg | Singapore | 55 | 4.18 | 12.7% | 65.5% | 0.0% | 0.0% | 0.0% | 1.8% | 5.5% | 0.0% | 0.0% | 0.0% | 0.0% | 3.6% | 20.0% | 32.7% | 3.6% ; ua | Ukraine | 55 | 3.45 | 32.7% | 45.5% | 5.5% | 3.6% | 5.5% | 9.1% | 9.1% | 0.0% | 3.6% | 5.5% | 9.1% | 1.8% | 3.6% | 5.5% | 1.8% ; ro | Romania | 52 | 4.15 | 15.4% | 69.2% | 3.8% | 3.8% | 5.8% | 3.8% | 7.7% | 1.9% | 1.9% | 1.9% | 0.0% | 3.8% | 23.1% | 28.8% | 5.8% ; pk | Pakistan | 51 | 4.18 | 19.6% | 70.6% | 0.0% | 0.0% | 0.0% | 2.0% | 0.0% | 0.0% | 3.9% | 0.0% | 0.0% | 7.8% | 23.5% | 31.4% | 3.9%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R04-074 — Market groups: Anglophone core 13,483 (65.9%, 3.98); high-spend 15,677 (76.6%, 3.95); Latin America 2,446 (12.0%, 3.85, trial 7.2%, charged 7.3%, refund 7.0%); top-6 volume 14,689 (71.8%); sub-50 storefronts 1,147 (5.6%, 4.03)

- **Where:** §6.1 market-group table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Group | n | share | Mean | 1–2★ | trial | charged | refund | scam | paywall | lang | endorse ; Anglophone core (US GB CA AU NZ IE ZA) | 13,483 | 65.9% | 3.98 | 20.7% | 3.4% | 1.3% | 1.9% | 2.6% | 9.7% | 0.3% | 21.5% ; High-spend markets (defined below) | 15,677 | 76.6% | 3.95 | 21.1% | 3.3% | 1.3% | 1.9% | 2.7% | 9.8% | 1.1% | 20.5% ; Latin America (BR MX CO CL AR PE EC DO GT CR) | 2,446 | 12.0% | 3.85 | 25.0% | 7.2% | 7.3% | 7.0% | 4.0% | 9.4% | 4.2% | 5.9% ; High-review-volume top 6 (US GB CA AU BR MX) | 14,689 | 71.8% | 3.96 | 21.1% | 3.9% | 2.0% | 2.7% | 2.7% | 9.6% | 0.6% | 19.8% ; Sub-50 storefronts (93 of them) | 1,147 | 5.6% | 4.03 | 19.5% | 2.7% | 1.6% | 2.8% | 2.5% | 5.8% | 3.7% | 11.9% ; high-spend = US GB CA AU DE FR IT ES NL SE DK NO CH IE NZ FI AT BE SG IL AE SA; review volume is an engagement proxy only
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R04-075 — Brazil is a billing emergency, not a review-tone difference: 843 reviews, mean 3.55, 33.8% 1–2★, with unexpected-charge 14.5%, refund 14.8% and trial-deception 13.8% — 7 to 11× the global rate; 41 of 319 confirmed payers (12.9%) on 4.1% of the corpus; 'R$89,90 charged after selecting R$69,90' — the highest-yield single market fix in the corpus

- **Where:** §6.2
- **This app does:** trial provisioning or localised plan screen broken in BR
- **User reaction:** 1★-burst
- **Magnitude:** BR n=843, mean 3.55; charged 14.5%, refund 14.8%, trial 13.8%; reported Brazilian amounts R$167,90, R$219, R$107, R$339, R$89,90 charged after selecting R$69,90 (interpretation, inference: BR trial provisioning broken or the localised plan screen worse than the English one)
- **Direction for us:** must-never-break · **Report confidence:** high-priority (in-market) · **Generalisable:** yes
- **Side effects:** Chile (10.8% trial, 10.8% scam, mean 3.23 — lowest eligible market), Philippines, Vietnam, India, Ukraine show the same shape: a Global-South billing problem systematically worse than the US
- **Conditions:** billing/trial behaviour must be verified per storefront, not just in the US
- **Review IDs:** `10483361084`, `10531986957`, `10806565111`, `10941969952`, `10941523544`, `11005436107`, `11108259409`, `10863840021`, `13949866906`, `11482610207`, `10915214872`, `11021690984`, `13196254082`, `13687854445`, `11340759446`, `12212305667`, `10802505019`, `13149362320`, `10859158478`, `12811338830`
- **Canonical:** C109 A free trial must be a real trial

### R04-076 — Canada (mean 3.68, scam accusations 7.5% — 3× the US) and New Zealand (trial-deception 14.4%, the highest of any eligible market) are the Anglophone outliers; multiple NZ reviewers report their Apple accounts blocked by the unpaid charge; 'Predatory scam' (34 votes); 'how are struggling people expected to afford this during a recession'

- **Where:** §6.3
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** CA n=948 scam 7.5%; NZ n=118 trial 14.4%
- **Direction for us:** must-never-break · **Report confidence:** meaningful (in-market) · **Generalisable:** yes
- **Review IDs:** `10147463845`, `10217126190`, `10998909966`, `10428470955`, `9827046632`, `11534199589`, `14382272365`, `11757840008`, `10214812939`, `11521172768`, `10859204080`, `9827545800`, `10335300190`, `11487653096`, `10886918557`, `11006362767`, `9896180923`, `12547182143`
- **Canonical:** C109 A free trial must be a real trial

### R04-077 — France is the paywall-friction market: 17.9% paywall-block rate, highest of any eligible market, yet mean 3.87 and 19.4% strong endorsement — French users like the app and resent the wall

- **Where:** §6.4 France
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** FR n=464, paywall 17.9%, endorse 19.4%
- **Direction for us:** research · **Report confidence:** meaningful (in-market) · **Generalisable:** yes
- **Review IDs:** `12917436383`, `12009622937`, `12858504773`, `13092753937`, `12175940750`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R04-078 — Germany is the price market: highest unexpected-charge rate in Europe (4.2%) and 2.4% price complaints — 'Achtung Abofalle' (subscription trap); the clearest pricing advice in the corpus: 'I'd lower the yearly price a bit and show it at the very beginning'

- **Where:** §6.4 Germany
- **This app does:** price hidden until after the quiz
- **User reaction:** complaint
- **Magnitude:** DE n=286, charged 4.2%, price 2.4%
- **Direction for us:** do · **Report confidence:** meaningful (in-market) · **Generalisable:** yes
- **Side effects:** show the price up front — a 5★ user's own recommendation
- **Review IDs:** `12725840440`, `10825116155`, `11981627164`, `13752329188`, `12051819932`
- **Canonical:** C111 No long quiz before the price; show the price up front; C064 Price level — where 'fair' turns into 'too expensive'

### R04-079 — Localisation is a solved problem in five languages and an open one in six: shipping ES/PT/FR/DE eliminated the complaint in those markets within one year (France 26.4% → 1.9%, Spanish 31.5% → 0.0%, German 15.6% → 0.0%) — the single cleanest cause-and-effect in the dataset; unserved markets are loud: Russian is 51.9% of all Russian reviews and the two most-voted reviews in the entire corpus (180 and 98 votes) are Russian language requests; Turkish 27.8% (2025), Polish 20%, Vietnamese 14.1%, Dutch 11.4%, Arabic 16.0%, plus Japanese, Korean, Indonesian

- **Where:** §6.5 + table
- **This app does:** ships EN/FR/DE/PT/ES; not RU/TR/NL/PL/VI/AR/JA/KO/ID
- **User reaction:** blocked-conversion
- **Magnitude:** 454 (2.22%), mean 3.26; Market | 2023 | 2024 | 2025 | 2026 ; France (FR/BE/CH) | 26.4% | 6.8% | 3.4% | 1.9% ; Germany (DE/AT) | 15.6% | 1.4% | 0.0% | 0.0% ; Spanish markets | 31.5% | 3.2% | 1.1% | 0.0% ; Portuguese (BR/PT) | 16.7% | 3.1% | 3.1% | 0.9% ; Russia / Ukraine | 31.8% | 45.1% | 32.0% | 0.0% ; Turkey | 16.9% | 22.9% | 27.8% | 9.4% ; Netherlands | 10.9% | 13.2% | 5.6% | 9.1% ; Poland | 9.5% | 17.9% | 13.3% | 20.0%
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** non-Latin-script reviews are only 1.69% of the corpus — the under-representation of unserved markets is itself evidence of the gap
- **Review IDs:** `11898653184`, `10341079349`, `11297466959`, `10215708190`, `11668948355`, `13430297128`, `12537734671`, `11759403751`, `10810076621`, `12166286849`, `10944912059`, `10985642638`, `10864745478`, `12397000495`, `10912344506`, `12208216179`
- **Canonical:** C027 Localise early — it unlocks revenue

### R04-099 — Introduce regional pricing for LatAm, India, Turkey, SE Asia — Chile's 6.2% price-complaint rate and India's 41.2% 1–2★ rate both point here

- **Where:** Part 8 #11
- **This app does:** single global price
- **User reaction:** blocked-conversion
- **Magnitude:** CL price 6.2%; IN 1–2★ 41.2%
- **Direction for us:** do · **Report confidence:** meaningful (in-market) · **Generalisable:** yes
- **Conditions:** evidence: R04-073, R04-075
- **Canonical:** C092 Regional pricing

## Dated events and trends

### R04-008 — Mid-2025 a hard cap on free daily tasks (typically 4–7) was introduced and reversed a two-year rating recovery: cap complaints 6 in 2022–24 → 15 in 2025 Q3 (2.04%); overall mean fell 4.29 (2025 Q2) → 3.61 (2025 Q3) and paywall complaints 6.8% → 15.4%; 'I used to have at least 15'

- **Where:** Part 0 §5 + table
- **This app does:** introduced a free task cap of 4–7/day in mid-2025
- **User reaction:** 1★-burst
- **Magnitude:** 57 (0.28%), mean 2.58; Period | n | % of that period's reviews ; 2022 – 2024 | 6 | 0.03% ; 2025 Q2 | 4 | 0.52% ; 2025 Q3 | 15 | 2.04% ; 2025 Q4 | 10 | 1.65% ; 2026 Q1 | 11 | 1.32% ; 2026 Q2–Q3 | 11 | ~1.1%
- **Direction for us:** product-rule · **Report confidence:** weak count, unambiguous timing · **Generalisable:** yes
- **Side effects:** the cap converted a 'free app with paid extras' into a 'trial app'; carried disproportionately by long-tenure users so it reads as betrayal, not a price objection
- **Conditions:** one paying user lost the capability too
- **Review IDs:** `13492344866`, `13684033797`, `13323699685`, `14279264893`, `14251626693`, `14426594797`, `13028782607`, `14518936346`, `13037009395`, `13595977240`, `13877919125`, `14496354181`, `13249657539`, `12837015409`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C001 Never move a free feature behind the paywall

### R04-065 — 'It used to be better / used to be free' — 286 (1.40%), mean 3.01

- **Where:** Part 4 row 14
- **This app does:** regressions and re-gating
- **User reaction:** complaint
- **Magnitude:** 286 (1.40%), mean 3.01
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall

### R04-081 — Reviews by year: 2022 269 (3.26); 2023 5,788 (3.71); 2024 8,954 (4.00); 2025 3,660 (4.10); 2026 1,794 (4.03) — volume peaked Jan 2024 (1,514 in one month) and fell to a fifth; either acquisition slowed or review prompting changed

- **Where:** §7.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | Reviews | Mean ; 2022 (from 18 Jan) | 269 | 3.26 ; 2023 | 5,788 | 3.71 ; 2024 | 8,954 | 4.00 ; 2025 | 3,660 | 4.10 ; 2026 (to 7 Sep) | 1,794 | 4.03
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R04-082 — Quarterly n, mean, 1–2★, billing cluster, paywall block, trial deception 2022–2026 Q3 — full table

- **Where:** §7.2 quarterly table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Quarter | n | Mean | 1–2★ | Billing cluster | Paywall block | Trial deception ; 2022 Q1–Q4 | 269 | 3.26 | 37.5% | 10.8% | 5.6% | 5.6% ; 2023 Q1 | 473 | 3.04 | 43.1% | 10.4% | 10.6% | 6.3% ; 2023 Q2 | 702 | 2.73 | 51.4% | 13.0% | 13.2% | 7.5% ; 2023 Q3 | 2,033 | 3.79 | 24.2% | 5.6% | 11.9% | 3.5% ; 2023 Q4 | 2,580 | 4.04 | 19.1% | 4.4% | 7.6% | 2.6% ; 2024 Q1 | 3,142 | 3.71 | 27.8% | 10.2% | 9.5% | 6.7% ; 2024 Q2 | 2,162 | 4.00 | 21.0% | 8.4% | 9.4% | 5.5% ; 2024 Q3 | 2,141 | 4.19 | 15.6% | 4.9% | 8.2% | 3.2% ; 2024 Q4 | 1,509 | 4.33 | 12.1% | 2.3% | 8.3% | 1.2% ; 2025 Q1 | 1,545 | 4.38 | 11.4% | 2.3% | 6.7% | 1.5% ; 2025 Q2 | 775 | 4.29 | 12.6% | 5.3% | 6.8% | 3.0% ; 2025 Q3 | 734 | 3.61 | 27.2% | 5.2% | 15.4% | 3.3% ; 2025 Q4 | 606 | 3.76 | 24.9% | 5.9% | 10.6% | 4.0% ; 2026 Q1 | 834 | 3.99 | 19.4% | 3.0% | 10.6% | 2.2% ; 2026 Q2 | 565 | 4.01 | 18.6% | 4.1% | 8.8% | 2.8% ; 2026 Q3 (partial) | 395 | 4.12 | 15.7% | 3.8% | 8.4% | 2.5%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R04-083 — Event A — the 2023 Q2 trough (mean 2.73, 51.4% 1–2★): paywall 13.2%, billing 13.0% and quiz 4.8% complaints all peaked together; whatever the app did in Q3 2023 — volume jumped 3× and the mean recovered to 3.79 — worked

- **Where:** §7.2 Event A
- **This app does:** unknown fix in 2023 Q3
- **User reaction:** 1★-burst
- **Magnitude:** 2.73 → 3.79 in one quarter
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Side effects:** a monetisation funnel can be fixed fast enough to show in one quarter
- **Canonical:** — (nuance register)

### R04-084 — Event B — the Jan–Feb 2024 billing spike: monthly billing-cluster 4.2% (Dec) → 8.1% (Jan) → 15.1% (Feb) → 8.5%; trial-deception 9.3% of all February 2024 reviews — a discrete regression, not a trend

- **Where:** §7.2 Event B
- **This app does:** a billing/trial regression shipped ~Jan 2024
- **User reaction:** 1★-burst
- **Magnitude:** 15.1% billing cluster in Feb 2024
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** billing regressions are shippable bugs — monitor the trial→charge path per release
- **Review IDs:** `10930935136`, `10933044729`, `10983020319`, `11005436107`, `10941969952`, `10941523544`, `10915214872`, `10869856053`, `10863840021`, `10885363042`, `10802505019`
- **Canonical:** C109 A free trial must be a real trial; C029 Billing must be exactly right

### R04-085 — Event C — the mid-2025 free-tier tightening: mean 4.29 → 3.61 in one quarter; paywall-block 6.8% → 15.4%; free task cap 0.5% → 2.0% of reviews and above 1% since; fourteen months later the mean has recovered only to 4.12, still below the 4.38 peak

- **Where:** §7.2 Event C
- **This app does:** free cap introduced mid-2025
- **User reaction:** 1★-burst
- **Magnitude:** 4.29 → 3.61; not recovered to peak after 14 months
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C001 Never move a free feature behind the paywall

### R04-086 — Improved: billing cluster 13.0% (2023 Q2) → 3.8% (2026 Q3) with the 2024 Q1 relapse; localisation eliminated in ES/PT/FR/DE; 'can't edit future days' 1.35% → 0.22%; scheduling flexibility 2.49% → 0.67%; quiz complaints 4.8% → 0.3%

- **Where:** §7.3
- **This app does:** several real fixes shipped
- **User reaction:** praise
- **Magnitude:** five themes improved
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a shorter quiz and a fixed future-day editor both show as near-elimination of the complaint
- **Canonical:** C027 Localise early — it unlocks revenue; C043 Flexible / custom frequency; C111 No long quiz before the price; show the price up front

### R04-087 — Worsened: free task cap 0.03% → 1.32–2.04%; 'used to be better/free' 3.2% of 3★ and 3.6% of 2★ post-2025; paywall-block never returned to its 2025 Q1 low (6.7% → 8.4–10.6%); unserved-language requests (RU, TR, PL, NL, VI) flat or rising while served languages went to zero

- **Where:** §7.4
- **This app does:** tightened free tier; stopped localising
- **User reaction:** complaint
- **Magnitude:** four themes worsened
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C027 Localise early — it unlocks revenue

### R04-088 — Persisted unchanged for five years: notification/alarm reliability (0.9–1.3% every year), backup / iCloud / account portability (0.28–1.12%), upsell pop-ups (1.0–6.3% every quarter, never absent)

- **Where:** §7.5
- **This app does:** never fixed
- **User reaction:** complaint
- **Magnitude:** three chronic themes
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** chronic reliability themes at ~1% per year are a permanent rating tax
- **Canonical:** C039 Reminders fire reliably, once; C034 Data must never be lost on update, reinstall or phone change; C093 No upsell nagging without a 'never ask again' option

## Positioning

### R04-001 — Me+ is a subscription-first routine planner with a 4.80 store rating on 247,686 US ratings whose 20,465 written reviews average 3.93; localised in EN, FR, DE, PT, ES; VIP at $39.99/yr and $9.99/mo

- **Where:** header line 3-6
- **This app does:** developer ENERJOY PTE. LTD., bundle alarm.smart.awake.sleep.health; free download; auto-renewing 'VIP' subscription; content library (workouts, meditation, sleep sounds); mascot; age rating 4+
- **User reaction:** mixed
- **Magnitude:** 20,465 reviews, 136 storefronts, Jan 2022 → Sep 2026; v2.8.9 (29 Jun 2026); first released 7 Jan 2022
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R04-049 — Design and cuteness — 5.40% at mean 3.85 — appears MORE in 4★ (8.8%) and 3★ (8.0%) than in 5★ (4.6%): it is frequently the 'but' clause — beautiful app, shame about the paywall

- **Where:** Part 3 §4
- **This app does:** cute, aesthetic design with a mascot
- **User reaction:** mixed
- **Magnitude:** 1,106 (5.40%), mean 3.85
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** design earns the 'almost' rating, not the 5★; it does not offset a monetisation grievance
- **Conditions:** contrast report 1 where 'too feminine/cute' was a complaint from men — cute design is audience-dependent
- **Review IDs:** `13573494472`, `10716291473`, `13558821605`, `9673450918`
- **Canonical:** C057 Offer a non-pastel / premium design option

### R04-072 — General self-improvement adults (the 26.46% organisation theme) risk substitution: 'I could just use Apple Reminders' — 'it is basically a fancy looking reminders list' (16 votes)

- **Where:** Part 5 Audience 4
- **This app does:** checklist that resembles Reminders
- **User reaction:** complaint
- **Magnitude:** 6 IDs
- **Direction for us:** do · **Report confidence:** repeated · **Generalisable:** yes
- **Side effects:** a routine app must be visibly more than a reminders list or the paid tier has no justification
- **Review IDs:** `11001127837`, `10670725080`, `11045284287`, `11088318709`, `11483126752`, `9893977621`
- **Canonical:** C005 Know which competitors buyers compare against; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

## Anti-patterns

### R04-006 — The likely mechanic: the 7-day trial is attached to only one plan, and selecting a different plan bills at once — 'In order to use the free trial you have to subscribe'; whether a billing defect or a deliberately ambiguous plan-selection screen, the outcome is identical and it costs roughly one in six written reviews

- **Where:** Part 0 §3 'two competing readings'
- **This app does:** trial attached to one SKU only; plan picker ambiguous
- **User reaction:** 1★-burst
- **Magnitude:** ~1 in 6 written reviews
- **Direction for us:** dont · **Report confidence:** high-priority (inference labelled) · **Generalisable:** yes
- **Conditions:** a trial must apply to whatever plan the user picks, or the picker must say which plan carries it
- **Review IDs:** `12547182143`, `10970088378`, `10073412863`
- **Canonical:** C109 A free trial must be a real trial

### R04-007 — The paywall has a dismiss button users cannot find — 75 reviews (0.37%, 46.7% 5★) exist only to teach others 'press the cross in the top right corner' — direct evidence that a material share of the 1,903 (9.30%, mean 2.69) 'you must pay to use it' reviews are a discoverability failure, not a pricing decision; one user read those reviews and still could not proceed

- **Where:** Part 0 §4
- **This app does:** hard-to-find X on the paywall; no correction of 'it's not free' claims
- **User reaction:** complaint
- **Magnitude:** 75 (0.37%) tutorials; 1,903 (9.30%) 'must pay' at mean 2.69, 50.1% 1–2★
- **Direction for us:** dont · **Report confidence:** high-priority (by consequence) · **Generalisable:** yes
- **Side effects:** users are doing the app's onboarding job in the reviews; the app never corrected the belief that it is paid-only
- **Conditions:** a visible, obvious 'continue free' path is a rating decision
- **Review IDs:** `10797845407`, `11976134626`, `11993331188`, `10564522089`, `11593006260`, `11193769864`, `12262785068`, `14349334637`, `10970386222`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R04-009 — The onboarding quiz amplifies every monetization complaint: 256 reviews (1.25%, mean 1.98, 71.9% 1–2★), never 'the quiz is bad' but always 'the quiz took my time and then asked for money' — '20 minutes to find out it's not free'; only 30 of 12,308 5★ reviews mention it

- **Where:** Part 0 §6
- **This app does:** 15–20 minute personalisation quiz before the paywall
- **User reaction:** 1★-burst
- **Magnitude:** 256 (1.25%), mean 1.98, 71.9% 1–2★; 0.2% of 5★
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** a long quiz before a paywall is 'almost purely a churn amplifier' — sunk time turns a price objection into anger
- **Review IDs:** `9810435432`, `11180746949`, `10037507184`, `10399986849`, `12092842548`, `10918157672`, `13307691745`, `9611806730`, `10934136621`, `10740385550`, `10990423353`
- **Canonical:** C111 No long quiz before the price; show the price up front

### R04-035 — Upsell pressure — pop-ups, spin-the-wheel offers, constant premium prompts, even push notifications that turn out to be upsells — 417 reviews (2.04%, mean 3.11) spread across ALL star bands (5.4% of 2★, 3.6% of 4★, 0.9% of 5★): an irritant that caps ratings rather than a cause of 1★; 'Every time I even ATTEMPT to add a habit, it gives me an ad pop up to buy premium'

- **Where:** §1.6
- **This app does:** aggressive in-app upsell incl. notification bait
- **User reaction:** complaint
- **Magnitude:** 417 (2.04%), mean 3.11
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** 'I'm broke dude, I am using a free app to try and get better mentally' — upsells on a mental-health surface read as cruelty
- **Conditions:** push notifications that open an upsell instead of the task are a specific betrayal
- **Review IDs:** `10027403829`, `9336675533`, `12965568824`, `13092753937`, `13587281349`, `9590692794`, `11981627164`, `10422172003`, `9254743485`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R04-036 — 26 reviews name the spin-the-wheel discount specifically; several report it rigged or broken

- **Where:** §1.6 wheel
- **This app does:** gamified discount wheel
- **User reaction:** complaint
- **Magnitude:** 26 reviews
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Side effects:** a gimmick that fails is worse than no gimmick; it feeds the 'scam' vocabulary
- **Review IDs:** `10319071373`, `10795829089`, `10422172003`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R04-064 — Ad ≠ app — advertised features absent — 126 (0.62%), mean 2.42

- **Where:** Part 4 row 20
- **This app does:** ads show features the app lacks
- **User reaction:** complaint
- **Magnitude:** 126 (0.62%), mean 2.42
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Side effects:** marketing that oversells creates a 'scam' cohort before the app is even opened
- **Canonical:** C114 Ads must match the app

## Things not to do

### R04-038 — The paywall's dismiss affordance is invisible — 1,903 'must pay' reviews vs 75 explaining the X exists

- **Where:** §1.7 #2
- **This app does:** hidden X
- **User reaction:** 1★-burst
- **Magnitude:** 1,903 vs 75
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R04-007
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R04-041 — Price is inconsistent and undisclosed until after a 10–20 minute quiz

- **Where:** §1.7 #5
- **This app does:** price hidden behind quiz; varies
- **User reaction:** 1★-burst
- **Magnitude:** ≥9 price points; 256 quiz complaints
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R04-009, R04-014
- **Canonical:** C111 No long quiz before the price; show the price up front; C113 One stable, disclosed price — no discount wheels

### R04-095 — Show the price before the quiz, not after it — the quiz theme has a 1.98 mean and 71.9% 1–2★; every one of those reviews is a wasted acquisition

- **Where:** Part 8 #7
- **This app does:** price after a 10–20 min quiz
- **User reaction:** 1★-burst
- **Magnitude:** 256, mean 1.98
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R04-009, R04-078
- **Canonical:** C111 No long quiz before the price; show the price up front

### R04-106 — Review the 4+ age rating against the weight-loss and shame framing — 455 kid/teen reviews and 89 shame/ED reviews, with a 46-vote 1★ leading on it

- **Where:** Part 8 #18
- **This app does:** 4+ rating with diet framing
- **User reaction:** 1★-burst
- **Magnitude:** 455 + 89
- **Direction for us:** dont · **Report confidence:** meaningful (safety) · **Generalisable:** yes
- **Conditions:** evidence: R04-067, R04-068
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

## Things to do

### R04-109 — TikTok ADHD advertising is the acquisition channel and it works (a reviewer confirms it; ADHD is 4.51% of the corpus at 62.4% 5★) — but the ad must match the app: 126 reviews (0.62%, mean 2.42) say advertised features are absent

- **Where:** Part 5 Audience 1 + Part 4 row 20
- **This app does:** paid social ads targeting ADHD; some ads oversell
- **User reaction:** mixed
- **Magnitude:** ADHD 922 (4.51%); ad≠app 126 (0.62%), mean 2.42
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R04-064, R04-069
- **Review IDs:** `9761650498`
- **Canonical:** C114 Ads must match the app; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

## Contradictions

### R04-110 — Cute / aesthetic design is a 5.40% praise theme here (teen- and ADHD-heavy audience) but a repeated complaint from men and premium-seeking users in report 1 — design tone is audience-dependent, not universally good or bad

- **Where:** Part 3 §4 vs report 1 Part 8 #21
- **This app does:** cute mascot, pastel aesthetic
- **User reaction:** mixed
- **Magnitude:** here 1,106 (5.40%), mean 3.85; report 1: 'too feminine/childish' recurring
- **Direction for us:** research · **Report confidence:** cross-report · **Generalisable:** yes
- **Conditions:** pick the tone for the audience you target; offer an alternative theme for the rest
- **Review IDs:** `13573494472`
- **Canonical:** C057 Offer a non-pastel / premium design option

### R04-111 — The free task cap does convert some users ('wanted the full routine after the cap blocked them') — and it reversed a two-year rating recovery (4.29 → 3.61); the report's resolution is 'reconsider the cap or raise it well above 6'

- **Where:** §1.3 trigger row 1 vs Part 0 §5
- **This app does:** cap 4–7/day since mid-2025
- **User reaction:** mixed
- **Magnitude:** 3 conversion IDs vs 57 cap complaints and a 0.68-point quarterly drop
- **Direction for us:** undecided · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** a cap set on tenured free users is a re-paywall; a cap set at launch is a free-tier decision
- **Review IDs:** `13249657539`, `13323699685`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

## Data caveats and method

### R04-002 — Method: bands against all 20,465 and separately against each of 43 storefronts with ≥50 reviews (19,318, 94.4%); 93 storefronts hold 1,147 (5.6%, mean 4.03) with no standalone claims; one review = 0.0049%; non-exclusive themes

- **Where:** How to read this
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 43 eligible storefronts
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R04-003 — The gap between the store rating (4.80 on 247,686 tap ratings) and the written corpus (3.93; 60.1% 5★, 16.8% 1★) is the story: people who tap five stars say nothing, people who write do so because something happened — here, overwhelmingly a charge

- **Where:** Part 0 summary + §1 table
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | Value ; App Store rating (US, all ratings incl. tap-only) | 4.80 (247,686 ratings) ; Mean of all 20,465 written reviews | 3.93 ; 5★ share of written reviews | 60.14% (12,308) ; 1★ share of written reviews | 16.80% (3,438) ; 2★ share | 4.94% (1,010)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a 4.8 store rating can coexist with one in six written reviews being 1★
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R04-030 — The payer cohort is severely selection-biased: people state 'I paid' mainly when angry about having paid; read it as 'when a subscriber writes about the subscription it is almost always about billing', not 'subscribers are unhappy'

- **Where:** §1.4 disclosure
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** segment rate, not population rate
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Side effects:** applies to every payer table in this ledger: the direction is robust, the level is not
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R04-080 — 93 storefronts under 50 reviews hold 1,147 (5.6%) at mean 4.03; no standalone claims; quotes flagged [limited evidence]

- **Where:** §6.6
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 1,147 (5.6%), 4.03
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `13026729877`, `12874373355`, `11979793558`, `13307354054`, `10294858917`
- **Canonical:** — (nuance register)

### R04-107 — Open questions the corpus cannot answer: is the immediate charge a billing defect or intended non-trial-plan behaviour; what is the actual free cap today; does the discount wheel raise net revenue or mostly generate refunds; why did review volume fall ~80% from its 2024 Q1 peak

- **Where:** Part 8 research questions
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 4 research questions
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R04-108 — Method: 20,465 records, 100% reconciliation, 62-theme multilingual regex taxonomy (non-exclusive, 1.44 themes/review), ~260 matched reviews manually validated (precision ≥90% billing/onboarding/localisation, ~85% broad topics); 30.01% matched no theme (short generic praise, mean 4.24); non-English recall is lower (unclassified 26.5% EN vs 34–45% other) so non-English rates are conservative floors; payer cohort is a segment rate; events are inferred from review timing, not release notes; 13 fake-review accusations (0.06%) recorded but the 4.80-vs-3.93 gap is fully explained by written-review selection bias

- **Where:** Part 9.2–9.4 method and limitations
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 20,465 reviews; 1 exact-duplicate pair retained; is_edited 79 (0.39%); 1,119 (5.47%) with helpful votes; one external source accessed 2026-09-09
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Conditions:** report 4 is the first in this run with the newer Part 9 appendix structure; the classification was regex-based with manual validation rather than fully hand-curated
- **Review IDs:** `12064894359`, `10143443853`, `10990838221`, `10996599524`, `10311098663`
- **Canonical:** — (nuance register)
