# Cards — report 2

Source: `App Store Reports/2. Daily Habits - Habit Tracker - Habit List and Routine Tracker (REPORT).md`  
123 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 3
- [Must-haves](#must-haves) — 1
- [Must never break](#must-never-break) — 20
- [Features](#features) — 35
- [Monetization](#monetization) — 8
- [Tactics the app used](#tactics-the-app-used) — 3
- [Insights (the why)](#insights-the-why) — 15
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 9
- [Dated events and trends](#dated-events-and-trends) — 7
- [Positioning](#positioning) — 5
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 7

## Product rules

### R02-103 — Keep the one-time purchase — 19 reviews at mean 4.84 name it as the reason to buy; the app's only durable competitive weapon against subscription rivals

- **Where:** Part 8 #6
- **This app does:** one-time Pro
- **User reaction:** purchase-driver
- **Magnitude:** 19 (3.68%), mean 4.84
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Conditions:** evidence: R02-020, R02-094
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R02-104 — Do not gate the habit cap — unlimited-free is the highest-rated theme in the corpus (mean 4.97) and earns the word-of-mouth a tiny marketing budget cannot buy

- **Where:** Part 8 #7
- **This app does:** unlimited habits free
- **User reaction:** 5★-burst
- **Magnitude:** mean 4.97, 29/30 5★
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R02-037, R02-047; contrast report 1 (cap of 6+ held constant)
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R02-105 — Make the paid tier things that actually work — this app charged for sync, calendar and stats, shipped all three broken, and paying users ended a full star below free ones; ship the paid feature before you sell it

- **Where:** Part 8 #8
- **This app does:** sold broken paid features
- **User reaction:** 1★-burst
- **Magnitude:** payers 3.10 vs 4.15
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R02-017, R02-024, R02-031
- **Canonical:** C078 Ship the paid feature working before you sell it

## Must-haves

### R02-119 — A support path that actually responds: early users praised a kept 48-hour response promise and upgraded ratings; later users found 'App Support' did nothing and paying users lost data with no reply

- **Where:** Part 7 'Support flipped' + §1.4 + Part 4
- **This app does:** support answered 2016–18, then nothing
- **User reaction:** 1★-burst
- **Magnitude:** 6 positive support IDs (2016–18) vs 3 unanswered later; 'no support reply' inside the 1★ payer list
- **Direction for us:** must-have · **Report confidence:** clear mechanism · **Generalisable:** yes
- **Review IDs:** `1520975020`, `6682336849`, `6467272815`, `5403701988`
- **Canonical:** C036 A support channel that exists and answers

## Must never break

### R02-027 — Refund / regret language appears in 8 reviews (1.55%) with a mean rating of exactly 1.00

- **Where:** §1.4 refund line
- **This app does:** no refund path visible
- **User reaction:** 1★-burst
- **Magnitude:** 8 (1.55%), mean 1.00
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `3313222571`, `5403701988`, `9488272822`, `1816542296`, `1639153995`, `9929028369`, `1695627701`, `2109039905`
- **Canonical:** C029 Billing must be exactly right; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R02-028 — 8 reviews (1.55%) describe people who tried to pay and could not, or were confused out of it: purchase errors, signup that rejects a valid custom-domain email, 'impossible to create an account', a launch promo that failed to apply

- **Where:** §1.5 opening + bullets
- **This app does:** purchase and signup flow leak buyers
- **User reaction:** blocked-conversion
- **Magnitude:** 8 (1.55%); one says 'I'm happy to pay for this app (solely to remove the ads)' and is blocked by the signup form
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** account creation that fails 'same as all this developer's other apps' — a shared backend bug leaks across the app family
- **Conditions:** iPad accepted payment but would not sync it back to iPhone
- **Review IDs:** `2127688409`, `6152405859`, `1520975020`, `1477051291`, `5819047278`, `1483218187`, `1482736956`, `1484186051`
- **Canonical:** C077 Purchase and signup flow must not leak buyers

### R02-031 — Every paid feature is broken — sync, calendar, stats — the entire Pro bundle (6.77% of all reviews)

- **Where:** §1.6 #1
- **This app does:** Pro bundle fails
- **User reaction:** 1★-burst
- **Magnitude:** 6.77%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R02-013..017
- **Canonical:** C078 Ship the paid feature working before you sell it

### R02-034 — The purchase and signup flow itself leaks buyers (1.55%), including a user who says outright he wants to pay

- **Where:** §1.6 #4
- **This app does:** purchase/signup errors
- **User reaction:** blocked-conversion
- **Magnitude:** 1.55%
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R02-028
- **Canonical:** C077 Purchase and signup flow must not leak buyers

### R02-039 — What produces 1★ (n=47) and 2★ (n=31): crashes 14/4 (29.8% of 1★), data loss 11/6 (23.4%), confirmed payer 10/2, refund language 8/0, reminders don't fire 6/3, Watch broken 5/3, calendar damage 1/4

- **Where:** Part 2 1–2★ table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Driver | In 1★ | In 2★ | Signal ; Crashes / freezes / unusable | 14 | 4 | Dominant cause of 1★ — 29.8% of all one-star reviews ; Data loss / progress reset | 11 | 6 | 23.4% of one-star reviews ; Confirmed payer | 10 | 2 | Paying then failing is the worst outcome ; Refund / waste-of-money language | 8 | 0 | Pure churn ; Reminders don't fire | 6 | 3 | Breaks the only job that matters ; Apple Watch broken | 5 | 3 | Concentrated, disproportionate anger ; Calendar sync damage | 1 | 4 | Includes calendar *corruption*, not just failure
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R02-040 — Crashes / freezes / unusable are the dominant cause of 1★ — 29.8% of all one-star reviews

- **Where:** Part 2 1★ row 1
- **This app does:** crashes; iOS 14 crash regression
- **User reaction:** 1★-burst
- **Magnitude:** 14 of 47 1★, 4 of 31 2★; 28 total (5.42%, mean 2.11, Part 4)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R02-041 — Data loss / progress reset is the #2 cause of 1★ — 23.4% of one-star reviews

- **Where:** Part 2 1★ row 2
- **This app does:** data lost on relaunch, on iOS upgrade, at random
- **User reaction:** 1★-burst
- **Magnitude:** 11 of 47 1★, 6 of 31 2★; 22 total (4.26%, mean 1.95, Part 4)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R02-042 — Apple Watch broken draws concentrated, disproportionate anger — 5 of 47 1★ and 3 of 31 2★

- **Where:** Part 2 1★ row 6
- **This app does:** Watch app shows 'No actions', wrong day, won't sync back
- **User reaction:** 1★-burst
- **Magnitude:** 5 1★ + 3 2★; 12 negative of 15 mentions (2.32%, mean 2.33)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R02-054 — Complaint themes: crashes 28 (5.42%, 2.11); data loss 22 (4.26%, 1.95); broken Pro 35 (6.77%, 2.83); date off by one 14 (2.71%); Watch broken 12 (2.32%, 2.33); sync broken 12 (2.32%); reminders don't fire 10 (1.93%, 1.50); calendar damage 9 (1.74%, 2.11); abandonware 9 (1.74%); onboarding confusion 10 (1.93%, 3.30); slow/laggy 7 (1.35%); dated design 6 (1.16%, 3.67); ads 6 (1.16%, 3.67); rating-prompt & cross-promo spam 4 (0.77%)

- **Where:** Part 4 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % | Band | Mean ; Crashes / freezes / unusable | 28 | 5.42% | HIGH-PRIORITY | 2.11 ; Data loss / progress reset | 22 | 4.26% | VERY STRONG | 1.95 ; Broken Pro feature (any) | 35 | 6.77% | HIGH-PRIORITY | 2.83 ; Date off by one day | 14 | 2.71% | MEANINGFUL | 2.71 ; Apple Watch broken | 12 | 2.32% | MEANINGFUL | 2.33 ; Cross-device sync broken | 12 | 2.32% | MEANINGFUL | 2.92 ; Reminders don't fire | 10 | 1.93% | MEANINGFUL | 1.50 ; Calendar sync damage | 9 | 1.74% | MEANINGFUL | 2.11 ; Abandonware / no updates | 9 | 1.74% | MEANINGFUL | 2.89 ; Onboarding confusion | 10 | 1.93% | MEANINGFUL | 3.30 ; Slow / laggy | 7 | 1.35% | MEANINGFUL | 2.57 ; Dated or unattractive design | 6 | 1.16% | MEANINGFUL | 3.67 ; Ads in free version | 6 | 1.16% | MEANINGFUL | 3.67 ; Rating-prompt & cross-promo spam | 4 | 0.77% | EMERGING | 3.00
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R02-055 — 56 reviews (10.83%, mean 2.05) report a stability failure — data loss, crash, freeze or crippling lag; one review in nine

- **Where:** Part 4 combined line
- **This app does:** unstable
- **User reaction:** 1★-burst
- **Magnitude:** 56 (10.83%), mean 2.05
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change

### R02-056 — Data loss reads the same in every language and never got fixed across 2016–2023: entries gone on next launch, a month reset to incomplete, six months wiped, all habits gone after iOS 14.5 — one user about to buy Pro didn't

- **Where:** Part 4 'Data loss is the app-killer'
- **This app does:** local data lost on relaunch / iOS upgrade / at random; no developer response
- **User reaction:** 1★-burst
- **Magnitude:** 22 (4.26%), mean 1.95
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** data loss blocks conversion as well as causing churn: 'There's no point keeping a log'
- **Review IDs:** `1511065444`, `1538217704`, `1543097703`, `5423974093`, `5726080829`, `5891978522`, `6379792275`, `7271771390`, `9488272822`, `5403701988`, `1777981808`, `1816542296`, `8106352419`, `1560960588`, `5548521598`, `1580919614`, `1542809054`, `1519202196`, `4089300870`, `3518102228`, `3313222571`, `1481301722`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R02-057 — The off-by-one date bug (app/widget/Watch shows tomorrow as today) was reported in the first two weeks after launch, fixed once in Nov 2016 — two users raised their ratings to 5★ for the fast turnaround — then came back and stayed for years

- **Where:** Part 4 'off-by-one date bug'
- **This app does:** timezone/date bug, regressed
- **User reaction:** complaint
- **Magnitude:** 14 (2.71%), mean 2.71; reported 2016–2019
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** a fast fix earns upgraded ratings; a regression of the same bug earns years of complaints
- **Review IDs:** `1479044283`, `1480026316`, `1483978534`, `1484186051`, `1775022964`, `1581035694`, `3496905165`, `4115836897`, `1490259621`, `1490152355`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

### R02-059 — Calendar sync is the most severe individual complaint class: blank undeletable events, ~20 copies of each item, infinite duplicates, a phantom 2001 event, every habit written as a one-hour block — one user spent hours with Apple support restoring their phone

- **Where:** Part 4 'Calendar sync damages the calendar'
- **This app does:** paid calendar sync writes bad events into the system calendar
- **User reaction:** 1★-burst
- **Magnitude:** 9 (1.74%), mean 2.11
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** a feature that damages data outside the app produces 'I've never left a bad app review before' reviews
- **Conditions:** writing to shared system stores (calendar, health) needs the highest reliability bar
- **Review IDs:** `1650678342`, `1508808010`, `1639153995`, `4494723296`, `1484435569`, `2493571137`, `1816432913`, `9974150902`, `5683048621`
- **Canonical:** C072 Writes to shared system stores (calendar, health) must be exact and reversible

### R02-060 — Reminders not firing is the lowest-mean complaint theme (1.50) — it breaks the only job that matters

- **Where:** Part 4 table row 'Reminders don't fire'
- **This app does:** reminders sometimes fail
- **User reaction:** 1★-burst
- **Magnitude:** 10 (1.93%), mean 1.50
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once

### R02-062 — Slow / laggy (5+ seconds per tap in one paid case) draws 7 reviews at mean 2.57

- **Where:** Part 4 table row 'Slow / laggy'
- **This app does:** performance lag
- **User reaction:** complaint
- **Magnitude:** 7 (1.35%), mean 2.57
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C083 Performance must not degrade with habit count

### R02-098 — Local-first, durable storage with a restore path — data loss is 4.26% at mean 1.95 and is what turned paying customers into refund requests; no feature matters more

- **Where:** Part 8 #1
- **This app does:** no durable storage / restore path
- **User reaction:** 1★-burst
- **Magnitude:** 4.26%, mean 1.95
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R02-041, R02-056
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R02-099 — Never let the app freeze on check-off; tap latency must not grow with habit count — Japan's payers waited 5+ seconds

- **Where:** Part 8 #2
- **This app does:** crashes; lag grows with habit count
- **User reaction:** 1★-burst
- **Magnitude:** crashes 14 of 47 1★; 3 lag IDs
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R02-040, R02-062, R02-086
- **Review IDs:** `1639153995`, `1664490322`, `3488095225`
- **Canonical:** C031 Crashes / launch failures; C083 Performance must not degrade with habit count

### R02-100 — Get the date right in every surface and every timezone — widget, Watch and app must agree; this developer solved it once

- **Where:** Part 8 #3
- **This app does:** date bug across surfaces
- **User reaction:** complaint
- **Magnitude:** 2.71%
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R02-057, R02-092
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

### R02-102 — Never write to the user's calendar without exact, reversible, correctly-sized events — one user needed Apple support to repair their phone

- **Where:** Part 8 #5
- **This app does:** calendar sync corrupts the calendar
- **User reaction:** 1★-burst
- **Magnitude:** 1.74%, mean 2.11
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R02-059
- **Review IDs:** `1650678342`
- **Canonical:** C072 Writes to shared system stores (calendar, health) must be exact and reversible

### R02-106 — Fix the purchase flow — 1.55% of all reviews are people who tried to give money and couldn't

- **Where:** Part 8 #9
- **This app does:** purchase/signup errors
- **User reaction:** blocked-conversion
- **Magnitude:** 1.55%
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R02-028
- **Review IDs:** `5819047278`
- **Canonical:** C077 Purchase and signup flow must not leak buyers

## Features

### R02-013 — Cross-sync between iOS devices is a paid Pro feature and is reported broken by 12 reviews (2.32%, mean 2.92)

- **Where:** §1.2 table row 1
- **This app does:** paid; broken
- **User reaction:** 1★-burst
- **Magnitude:** 12 (2.32%), mean 2.92
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** the Pro headline feature; 6 buyers name it as the reason they paid (§1.3)
- **Review IDs:** `1520975020`, `1709883514`, `1517984752`, `1519202196`, `3626745558`, `11151750805`, `10872403505`, `10424885681`, `1816542296`, `1777981808`, `3385244633`, `1856430373`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C030 Sync must work — and prove it

### R02-014 — Calendar-app sync is a paid Pro feature reported broken by 9 reviews (1.74%) at the lowest mean in the table (2.11) — and it damages the user's calendar

- **Where:** §1.2 table row 2
- **This app does:** paid; broken; spawns duplicate / phantom events
- **User reaction:** 1★-burst
- **Magnitude:** 9 (1.74%), mean 2.11
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** Part 4: infinite duplicate events, a phantom '2001' event — a paid feature that harms data outside the app
- **Review IDs:** `1650678342`, `1508808010`, `1484435569`, `4494723296`, `1639153995`, `2493571137`, `1816432913`, `9974150902`, `5683048621`
- **Canonical:** C072 Writes to shared system stores (calendar, health) must be exact and reversible

### R02-015 — Extended statistics is a paid Pro feature reported deficient by 13 reviews (2.51%, mean 3.31) — the most-complained-about Pro item

- **Where:** §1.2 table row 3
- **This app does:** paid; deficient
- **User reaction:** complaint
- **Magnitude:** 13 (2.51%), mean 3.31
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** per-habit analytics locked in free is a paywall-friction complaint (§1.5)
- **Review IDs:** `4733959513`, `5078666035`, `1570623231`, `3654077349`, `3687308474`, `1512585333`, `8194482136`, `11707492556`, `1534636069`, `1526282800`, `1508808010`, `1891116934`, `2380499734`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R02-016 — Passcode lock with Touch ID is a paid Pro feature; one user had the app crash on launch with passcode set and had to delete it, losing everything; another reports a Touch ID 'peek' leak

- **Where:** §1.2 table row 4
- **This app does:** paid; buggy
- **User reaction:** complaint
- **Magnitude:** 2 (0.39%), mean 3.00
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Side effects:** a lock that crashes the app is a data-loss path
- **Review IDs:** `5747344195`, `3342902073`
- **Canonical:** C017 Passcode lock

### R02-018 — Free-tier capabilities confirmed working: unlimited habits, per-habit reminders, morning/afternoon/evening/night grouping, custom icons and personal photos, habit library/presets, break-a-bad-habit mode, archive, streaks and % completion, Today Widget + 3D Touch, Apple Watch app, groups/sharing

- **Where:** §1.2 free-tier list
- **This app does:** all of these free
- **User reaction:** praise
- **Magnitude:** list from listing + reviews; no counts
- **Direction for us:** build-free · **Report confidence:** stated · **Generalisable:** yes
- **Conditions:** this is an unusually rich free tier: Watch app, bad-habit mode, photos as icons and sharing are paid elsewhere
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C008 Daily check-in and one basic reminder per habit are free; C009 Icons, colours and basic widgets are free; C019 Quit-habit / bad-habit mode; C022 Apple Watch app (done properly: timer, two-way sync); C015 Shared / group habits; C079 Personal photos as habit icons

### R02-021 — Cross-device sync is the #2 stated reason to pay (6 buyers) — and it is the Pro feature that breaks

- **Where:** §1.3 table row 2
- **This app does:** paid; broken
- **User reaction:** purchase-driver
- **Magnitude:** 6 of 30 buyers
- **Direction for us:** build-paid · **Report confidence:** moderate · **Generalisable:** yes
- **Review IDs:** `1816542296`, `3626745558`, `1520975020`, `1777981808`, `4402829597`, `11151750805`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C030 Sync must work — and prove it

### R02-043 — The 'almost' band (3★ n=36, 4★ n=89): stats too thin 2/7, reminder sound too quiet 1/7, not in my language 5/5, can't schedule '3× a week' 2/5, date off by one 5/3, sync unreliable 3/4, can't reorder 3/0

- **Where:** Part 2 3–4★ table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Blocker | 3★ | 4★ ; Statistics too thin / wrong | 2 | 7 ; Reminder sound too quiet, not customisable | 1 | 7 ; Not in my language | 5 | 5 ; Can't schedule "3× a week" | 2 | 5 ; Date off by one day | 5 | 3 ; Cross-device sync unreliable | 3 | 4 ; Can't reorder habits | 3 | 0
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** fixing the sound, the stats, flexible scheduling and reordering would move a large share of 125 near-miss reviews upward — none require new product surface
- **Canonical:** — (nuance register)

### R02-044 — Reminder sound too quiet and not customisable is a 4★ blocker — the cheapest win in the list, asked by happy users

- **Where:** Part 2 3–4★ row 2
- **This app does:** one fixed quiet sound
- **User reaction:** complaint
- **Magnitude:** 1 3★ + 7 4★; 10 requests (1.93%, mean 4.10, Part 5)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C074 Customisable, louder reminder sounds

### R02-048 — Reminders that work are a high-priority praise theme (5.80%, mean 4.77)

- **Where:** Part 3 row 3
- **This app does:** per-habit reminders, free
- **User reaction:** praise
- **Magnitude:** 30 (5.80%), mean 4.77
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C039 Reminders fire reliably, once

### R02-049 — Customisation — icons and personal photos — is the second-largest praise theme (6.58%)

- **Where:** Part 3 row 6
- **This app does:** custom icons + own photos, free
- **User reaction:** praise
- **Magnitude:** 34 (6.58%), mean 4.35
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C009 Icons, colours and basic widgets are free

### R02-050 — Personal photos on habits is a small but distinctive delight that no competitor mentioned in this corpus offers

- **Where:** Part 3 'personal photos' paragraph
- **This app does:** own photo as a habit icon, free
- **User reaction:** praise
- **Magnitude:** 6 IDs; 'the visual really keeps me motivated'
- **Direction for us:** undecided · **Report confidence:** small, distinctive · **Generalisable:** yes
- **Review IDs:** `5559605362`, `1508808010`, `11920843498`, `4502143627`, `3511211105`, `1485913018`
- **Canonical:** C079 Personal photos as habit icons

### R02-051 — Today Widget / 3D Touch is praised at 'very strong' band but with the lowest mean of the praise items (4.00)

- **Where:** Part 3 row 7
- **This app does:** Today widget + 3D Touch, free; no iOS 14+ widget
- **User reaction:** praise
- **Magnitude:** 17 (3.29%), mean 4.00
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Conditions:** modern iOS 14+ widget requested (Part 5) — the old widget aged with the app
- **Canonical:** C009 Icons, colours and basic widgets are free

### R02-052 — Calendar integration is praised when it works (0.97%) — and damages calendars when it doesn't

- **Where:** Part 3 row 8
- **This app does:** calendar sync, paid
- **User reaction:** mixed
- **Magnitude:** 5 (0.97%), mean 4.00 praise vs 9 (1.74%), mean 2.11 damage
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C072 Writes to shared system stores (calendar, health) must be exact and reversible

### R02-058 — The Apple Watch app is broken for most who mention it (12 negative of 15) — 'No actions' while the phone is full, wrong day, no sync back — yet it is a purchase driver when it works ('far superior to other habit trackers')

- **Where:** Part 4 'Apple Watch'
- **This app does:** Watch app exists, free, unreliable
- **User reaction:** mixed
- **Magnitude:** 12 negative of 15 mentions (2.32%), mean 2.33
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** 'I'd advise Apple Watch users not to buy'
- **Review IDs:** `1856430373`, `3313222571`, `3032470486`, `4115836897`, `1816542296`, `3385244633`, `11151750805`, `3297361804`, `3496905165`, `4402829597`, `7515450312`, `1777981808`, `1482775394`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R02-061 — Onboarding confusion draws 10 reviews (1.93%) at mean 3.30

- **Where:** Part 4 table row 'Onboarding confusion'
- **This app does:** confusing first run
- **User reaction:** complaint
- **Magnitude:** 10 (1.93%), mean 3.30
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C075 Skippable, replayable onboarding tour

### R02-066 — Feature requests: deeper statistics 13 (2.51%, 3.31); 'X times per week' 12 (2.32%, 3.42); louder/custom reminder sounds 10 (1.93%, 4.10); localisation 14 (2.71%, 3.50); reorder habits 9 (1.74%, 4.33); journal/notes 8 (1.55%, 3.62); colour themes/dark mode 5 (0.97%, 3.60); cross-app integration 10 (1.93%, 3.10); modern iOS 14+ widget 5 (0.97%, 3.00)

- **Where:** Part 5 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Request | n | % | Band | Mean | Read as ; Better / deeper statistics | 13 | 2.51% | MEANINGFUL | 3.31 | Weekly-monthly-yearly review, per-habit charts, month/year calendar ; "X times per week" scheduling | 12 | 2.32% | MEANINGFUL | 3.42 | Fixed weekdays only; the #1 model complaint ; Louder / customisable reminder sounds | 10 | 1.93% | MEANINGFUL | 4.10 | Cheapest win in the list — asked by happy users ; Localization | 14 | 2.71% | MEANINGFUL | 3.50 | See Part 6 ; Reorder habits manually | 9 | 1.74% | MEANINGFUL | 4.33 | Last-added jumps to the top; asked by 5★ users ; Journal/notes improvements | 8 | 1.55% | MEANINGFUL | 3.62 | Comments vanish; note field too small; no search ; Colour themes / dark mode | 5 | 0.97% | EMERGING | 3.60 | *"is only green, more colors needed"* ; Cross-app integration with *Be Focused* / *Focus Matrix* | 10 | 1.93% | MEANINGFUL | 3.10 | Assumed to exist; its absence caused 1★ reviews ; Modern iOS 14+ widget | 5 | 0.97% | EMERGING | 3.00 | Ties directly to abandonment
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R02-067 — Better / deeper statistics is the #1 request: weekly-monthly-yearly review, per-habit charts, month/year calendar

- **Where:** Part 5 row 1
- **This app does:** stats thin; extended stats paid and deficient
- **User reaction:** complaint
- **Magnitude:** 13 (2.51%), mean 3.31
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** the paid stats are what users find thin — a paid reports feature must be substantial
- **Canonical:** C011 Weekly / monthly / yearly reports

### R02-068 — 'X times per week' scheduling is the highest-value missing capability — fixed weekdays only is 'the #1 model complaint'; '3 times a week on random days and keep the streak… this is the clue of keeping the habit'

- **Where:** Part 5 row 2 + paragraph
- **This app does:** specific weekdays only
- **User reaction:** complaint
- **Magnitude:** 12 (2.32%), mean 3.42; also 2-weekly / 2-monthly asks
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8509313946`, `3826839521`, `1644836488`, `3654077349`, `1543097703`, `1663634672`, `12040349741`, `7580228017`, `4502143627`, `5960513517`, `3604096686`, `1534636069`
- **Canonical:** C043 Flexible / custom frequency

### R02-069 — Louder / customisable reminder sounds — asked by happy users (mean 4.10); the cheapest win in the list

- **Where:** Part 5 row 3
- **This app does:** one quiet fixed sound
- **User reaction:** complaint
- **Magnitude:** 10 (1.93%), mean 4.10
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C074 Customisable, louder reminder sounds

### R02-070 — Manual reordering of habits is the best effort-to-goodwill ratio in the corpus — mean 4.33, requested across six countries over eight years, never shipped; last-added jumps to the top

- **Where:** Part 5 row 5 + paragraph
- **This app does:** no manual reorder
- **User reaction:** complaint
- **Magnitude:** 9 (1.74%), mean 4.33
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1534483238`, `1488986466`, `1700631660`, `4874970421`, `11247319482`, `7897418954`, `4025884406`, `4204815325`, `3537709874`
- **Canonical:** C073 Manual habit reordering

### R02-071 — Journal / notes improvements: comments vanish, note field too small, no search

- **Where:** Part 5 row 6
- **This app does:** notes exist but lossy and small
- **User reaction:** complaint
- **Magnitude:** 8 (1.55%), mean 3.62
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C049 Mood tracker / journal / habit notes

### R02-072 — Colour themes / dark mode — 'is only green, more colors needed'

- **Where:** Part 5 row 7
- **This app does:** single green theme
- **User reaction:** complaint
- **Magnitude:** 5 (0.97%), mean 3.60
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C080 Colour themes / dark mode

### R02-073 — Cross-app integration with the developer's Be Focused / Focus Matrix is requested by 10 (1.93%) and assumed to exist — its absence caused 1★ reviews

- **Where:** Part 5 row 8
- **This app does:** none
- **User reaction:** complaint
- **Magnitude:** 10 (1.93%), mean 3.10
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Canonical:** C087 Never imply cross-app integration you don't have

### R02-074 — A modern iOS 14+ widget is requested — ties directly to abandonment

- **Where:** Part 5 row 9
- **This app does:** legacy Today widget only
- **User reaction:** complaint
- **Magnitude:** 5 (0.97%), mean 3.00
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C009 Icons, colours and basic widgets are free; C071 Never ship and walk away

### R02-077 — Onboarding is a US-specific weakness (6.12%) not seen elsewhere: 'very complicated interface', 'too many steps compared to its competition', 'the UI is pretty inscrutable at first', asks for tutorials and a replayable intro

- **Where:** §6.1 note 2
- **This app does:** no tutorial; swipe-to-complete and break-a-habit toggle undiscoverable
- **User reaction:** complaint
- **Magnitude:** 6 US (6.12%) HIGH-PRIORITY
- **Direction for us:** must-have · **Report confidence:** high-priority (US) · **Generalisable:** yes
- **Conditions:** Part 8 #15: skippable, replayable tour
- **Review IDs:** `1494919328`, `6485340419`, `1835255000`, `2459382527`, `5288840112`, `3297361804`
- **Canonical:** C075 Skippable, replayable onboarding tour

### R02-081 — Groups / accountability is a 'very strong' US theme (3.06%)

- **Where:** §6.1 table row 'Groups / accountability'
- **This app does:** groups/sharing exist, free
- **User reaction:** praise
- **Magnitude:** 3 US (3.06%)
- **Direction for us:** research · **Report confidence:** very strong (US), n=3 · **Generalisable:** yes
- **Canonical:** C015 Shared / group habits

### R02-084 — German users report reminders firing per time-of-day instead of per habit

- **Where:** §6.2 table row Germany
- **This app does:** reminders grouped by time block
- **User reaction:** complaint
- **Magnitude:** 2 IDs [limited evidence]
- **Direction for us:** must-never-break · **Report confidence:** limited evidence · **Generalisable:** yes
- **Conditions:** per-habit reminder times are the expectation
- **Review IDs:** `2165186932`, `1962124981`
- **Canonical:** C039 Reminders fire reliably, once

### R02-101 — If you ship an Apple Watch app, it must actually sync — 12 of 15 Watch mentions are failures at mean 2.33, and it was a stated purchase reason

- **Where:** Part 8 #4
- **This app does:** Watch app broken
- **User reaction:** 1★-burst
- **Magnitude:** 12/15 negative, mean 2.33
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R02-042, R02-058
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R02-107 — 'X times per week' scheduling — the single most-requested model change and a churn cause on its own

- **Where:** Part 8 #10
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 2.32%
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R02-068
- **Review IDs:** `8509313946`
- **Canonical:** C043 Flexible / custom frequency

### R02-108 — Manual habit reordering — trivial to build, requested for eight straight years, mean 4.33

- **Where:** Part 8 #11
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 1.74%, mean 4.33
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R02-070
- **Canonical:** C073 Manual habit reordering

### R02-109 — Customisable, louder reminder sounds — the cheapest 5★ upgrade available

- **Where:** Part 8 #12
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 1.93%, mean 4.10
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R02-044, R02-069
- **Canonical:** C074 Customisable, louder reminder sounds

### R02-110 — Weekly / monthly / yearly review screens — the top 4★ blocker

- **Where:** Part 8 #13
- **This app does:** stats thin
- **User reaction:** complaint
- **Magnitude:** 2.51%
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R02-067
- **Canonical:** C011 Weekly / monthly / yearly reports

### R02-111 — Keep personal photos on habits — rare, loved, and no competitor in this corpus offers it

- **Where:** Part 8 #14
- **This app does:** own photos as icons
- **User reaction:** praise
- **Magnitude:** 6 IDs
- **Direction for us:** undecided · **Report confidence:** small, distinctive · **Generalisable:** yes
- **Conditions:** evidence: R02-050
- **Canonical:** C079 Personal photos as habit icons

### R02-112 — Onboarding — a skippable, replayable tour of swipe-to-complete and the break-a-habit toggle

- **Where:** Part 8 #15
- **This app does:** no tour
- **User reaction:** complaint
- **Magnitude:** 6.12% of US
- **Direction for us:** must-have · **Report confidence:** high-priority (US) · **Generalisable:** yes
- **Conditions:** evidence: R02-077
- **Canonical:** C075 Skippable, replayable onboarding tour

### R02-123 — Completion feedback is locked in the free tier — a user who otherwise liked the app left 3★ because free gives no feedback on completing a habit

- **Where:** §1.5 paywall friction (8194482136)
- **This app does:** completion feedback paid
- **User reaction:** complaint
- **Magnitude:** 1 review (US, 3★)
- **Direction for us:** build-free · **Report confidence:** single review · **Generalisable:** yes
- **Conditions:** core-loop feedback (the reward for checking off) gated behind Pro reads as a broken free tier
- **Review IDs:** `8194482136`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free

## Monetization

### R02-010 — Free download, ad-supported, with an unusually generous free tier — unlimited habits — which is the app's single strongest differentiator and is given away

- **Where:** §1.1 bullet 1
- **This app does:** unlimited habits free; ads in free tier
- **User reaction:** praise
- **Magnitude:** unlimited-habits praise is the top theme (5.80%, Part 3)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** report calls the free tier 'too good relative to a broken Pro' (§1.6 #3) — the problem is Pro, not the free tier
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R02-011 — Pro is a one-time in-app purchase — US $3.99 (2016), ~$4 CAD, €1 in a promo — repeatedly described as 'minuscule' / 'cheap'

- **Where:** §1.1 bullet 2
- **This app does:** one-time Pro at ~$4
- **User reaction:** purchase-driver
- **Magnitude:** price points from 5 reviews; 19 buyers cite one-time fee (§1.3)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `1484186051`, `9175173155`, `5727003954`, `10949884121`, `2911210521`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors

### R02-023 — Removing ads is a stated reason to pay for 3 buyers

- **Where:** §1.3 table row 4
- **This app does:** ads in free tier; Pro removes them
- **User reaction:** purchase-driver
- **Magnitude:** 3 of 30 buyers
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** one buyer says 'paying only removes the ads, I didn't feel much benefit' (§1.5)
- **Review IDs:** `5819047278`, `5727003954`, `4025884406`
- **Canonical:** C082 Ads in the free tier

### R02-030 — Paywall friction — 6 reviews (1.16%, mean 2.67): 'quite restricted', no completion feedback in free, per-habit analytics and stats locked, and 'paying only removes the ads, I didn't feel much benefit'

- **Where:** §1.5 paywall friction
- **This app does:** per-habit stats and completion feedback locked; Pro perceived as an ad-removal fee
- **User reaction:** complaint
- **Magnitude:** 6 (1.16%), mean 2.67
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** from the user's seat Pro reads as an ad-removal fee because its three real features don't work
- **Conditions:** locking per-habit stats in the free tier draws 3★ from otherwise-positive users
- **Review IDs:** `4064205077`, `5378260946`, `8194482136`, `5548521598`, `1534636069`, `4025884406`
- **Canonical:** C011 Weekly / monthly / yearly reports; C007 Generous fixed habit cap (or unlimited) — never change it

### R02-033 — The free tier is too good relative to a broken Pro — unlimited habits free is the top praise theme (5.80%) and Pro adds nothing that reliably works

- **Where:** §1.6 #3
- **This app does:** unlimited free; Pro broken
- **User reaction:** mixed
- **Magnitude:** 5.80% praise for unlimited habits
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** the report's framing is that Pro must offer something that works, not that the free tier should shrink
- **Canonical:** C078 Ship the paid feature working before you sell it; C007 Generous fixed habit cap (or unlimited) — never change it

### R02-037 — Unlimited habits / a generous free tier is the single biggest 5★ engine

- **Where:** Part 2 5★ row 1
- **This app does:** unlimited habits free
- **User reaction:** 5★-burst
- **Magnitude:** 29 of 314 5★ reviews
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R02-047 — The unlimited free tier is the most positively-charged theme in the corpus (mean 4.97; 29 of 30 mentions 5★) and it is what people tell their friends about

- **Where:** Part 3 row 2 + bold paragraph
- **This app does:** no habit limit in free
- **User reaction:** 5★-burst
- **Magnitude:** 30 (5.80%), mean 4.97, 29/30 5★
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 'Other apps only let you enter 3 habits for free and with this one you have no limits'; 'I'm just going to get the premium version to support the developers' — generosity converts to goodwill purchases
- **Conditions:** unlimited reminders are praised in the same breath
- **Review IDs:** `8188213087`, `5875158296`, `9216520052`, `10643933062`, `9636902294`, `3609568795`, `1520986091`, `6950869104`, `7740420763`, `4840822821`, `2911210521`, `3655435197`, `13629753462`, `12571415671`, `4317482186`, `3651405499`, `3338942850`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R02-064 — Ads in the free version draw 6 complaints (1.16%, mean 3.67) and are a stated reason for 3 purchases

- **Where:** Part 4 table row 'Ads'
- **This app does:** ads in free tier
- **User reaction:** complaint
- **Magnitude:** 6 (1.16%), mean 3.67
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** report 1's 'no ads' was the best-rated topic — ads are a mild negative here, not a 1★ driver
- **Canonical:** C082 Ads in the free tier; C006 Stay minimal and ad-free

## Tactics the app used

### R02-022 — 'Support the developer / already own their other apps' is the #3 reason to pay (5 buyers) — brand trust from sibling apps Be Focused and Focus Matrix converts

- **Where:** §1.3 table row 3
- **This app does:** publishes an app family
- **User reaction:** purchase-driver
- **Magnitude:** 5 of 30 buyers
- **Direction for us:** do · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** but two of these buyers assumed cross-app integration that does not exist and left 1★ (§1.6 #5)
- **Review IDs:** `1481812475`, `8731669029`, `13788341591`, `7232398007`, `2109039905`
- **Canonical:** C060 Cross-sell an app family on brand trust

### R02-096 — Support flipped: every positive support mention is from 2016–2018 ('kept the promise of responding in 48 hours', 'support persisted with me and it worked'); every negative one is later or unanswered ('I click on App Support, nothing happens')

- **Where:** Part 7 'Support flipped'
- **This app does:** responsive support early, none later
- **User reaction:** mixed
- **Magnitude:** 6 positive IDs (2016–18) vs 3 negative (later)
- **Direction for us:** must-have · **Report confidence:** clear mechanism · **Generalisable:** yes
- **Side effects:** a 48-hour response promise, kept, earns rating upgrades; an App Support link that does nothing is noticed
- **Review IDs:** `1490152355`, `1490259621`, `1488986466`, `1520975020`, `3504776374`, `6682336849`, `1650678342`, `5403701988`, `6467272815`
- **Canonical:** C036 A support channel that exists and answers; C059 Be visibly responsive; fixes bring reviewers back

### R02-122 — A free-Pro giveaway ran at launch (Nov 2016); it inflated early sentiment, and for at least three users the promo failed to apply — one paid the $3.99 anyway

- **Where:** Part 0 §5 + §1.5
- **This app does:** launch giveaway of Pro
- **User reaction:** mixed
- **Magnitude:** 3 giveaway IDs; 3 'promo failed to apply' IDs
- **Direction for us:** research · **Report confidence:** weak count · **Generalisable:** yes
- **Side effects:** a promo that does not apply reliably produces 2–3★ from people who wanted the product
- **Review IDs:** `1483240079`, `1482736956`, `1484186051`, `1483218187`
- **Canonical:** C089 Launch promos / free-Pro giveaways

## Insights (the why)

### R02-003 — A well-liked, genuinely differentiated free habit tracker was killed by data loss, crashes and five years of silence — and its headline rating went UP while it died

- **Where:** Part 0 summary line
- **This app does:** stopped development May 2021
- **User reaction:** churn
- **Magnitude:** executive summary; supporting numbers in R02-004..008
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a rising store rating can hide a dying product
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R02-009 — The honest read is ~3.8–4.0 among engaged Western users, and the decline is entirely self-inflicted through reliability, not competition

- **Where:** Part 0 'what this means'
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** synthesis of Part 0
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R02-017 — Every single feature you are asked to pay for is a documented failure point — 35 reviews (6.77%, HIGH-PRIORITY, mean 2.83) report a broken or deficient Pro capability; the free tier is the part that works

- **Where:** §1.2 bold sentence
- **This app does:** Pro = sync + calendar + stats + passcode, all failing
- **User reaction:** 1★-burst
- **Magnitude:** 35 reviews (6.77%), mean 2.83
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** paid features carry a higher reliability bar than free ones
- **Canonical:** C078 Ship the paid feature working before you sell it; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R02-019 — 30 reviews (5.80%, HIGH-PRIORITY) confirm a purchase

- **Where:** §1.3 line 92
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 30 (5.80%)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R02-020 — The #1 stated reason to pay is the one-time fee, not a subscription — 19 buyers (3.68%) at mean 4.84; 'the strongest and cleanest thing this product has'

- **Where:** §1.3 table row 1
- **This app does:** one-time ~$4 Pro
- **User reaction:** purchase-driver
- **Magnitude:** 19 (3.68% global), mean 4.84; 19 of 30 buyers
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Side effects:** 'compared to the other 2 dozen habit apps I looked at that charge that fee on a monthly basis'; 'available for a fraction of the price' of the Atomic Habits app; KR: habit apps are overpriced for what they do — this one is usable free and cheap paid
- **Review IDs:** `5902712831`, `9923794823`, `4874970421`, `5460594340`, `8188213087`, `10949884121`, `5727003954`, `10424885681`, `2911210521`, `9175173155`, `3606113071`, `5263275131`, `1667083196`, `7418712220`, `12488497405`, `13550599009`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R02-024 — Paying reduces satisfaction by more than a full star: confirmed payers rate 3.10 vs 4.15, 40% of payers leave 1–2★ (vs 15.1%), 10 of 30 payers left one star — 'the most consequential finding in the dataset'

- **Where:** §1.4 table + bold
- **This app does:** Pro features fail
- **User reaction:** churn
- **Magnitude:** payers n=30: mean 3.10, 1–2★ 40.0%, 5★ 33.3%; corpus: 4.15, 15.1%, 60.7%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R02-025 — 47% of confirmed payers (14/30) report a broken feature or stability failure: 37% hit data loss, crashes or crippling lag; 23% hit a broken Pro feature specifically

- **Where:** §1.4 line 120
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 14/30 broken; 11/30 data loss/crash/lag; 7/30 broken Pro feature
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R02-032 — Paying makes people angrier, not happier — payers rate 3.10 vs 4.15

- **Where:** §1.6 #2
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 3.10 vs 4.15
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R02-024
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R02-036 — What produces 5★ (n=314): unlimited habits 29 ('the single biggest 5★ engine'), simple/clean 103, reminders that work 22, 'compared and chose this' 21, one-time cheap price 16

- **Where:** Part 2 5★ table (verbatim)
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** Driver | Count in 5★ | Read as ; Unlimited habits / generous free tier | 29 | The single biggest 5★ engine ; Simple, clean, uncluttered | 103 | Table stakes and the reason they stay ; Reminders that work | 22 | The core job ; "I compared it against others and chose this" | 21 | Genuine preference, not default ; One-time cheap price | 16 | Converts goodwill into money
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R02-045 — Praise themes: simple/clean 140 (27.08%, 4.56); unlimited habits free 30 (5.80%, 4.97); reminders that work 30 (5.80%, 4.77); chose over competitors 31 (6.00%, 4.29); one-time price 19 (3.68%, 4.84); customisation incl. own photos 34 (6.58%, 4.35); widget/3D Touch 17 (3.29%, 4.00); calendar integration when it works 5 (0.97%, 4.00)

- **Where:** Part 3 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % | Band | Mean ; Simple / clean / easy | 140 | 27.08% | HIGH-PRIORITY | 4.56 ; Unlimited habits free | 30 | 5.80% | HIGH-PRIORITY | 4.97 ; Reminders that work | 30 | 5.80% | HIGH-PRIORITY | 4.77 ; Chose it over competitors | 31 | 6.00% | HIGH-PRIORITY | 4.29 ; One-time cheap price | 19 | 3.68% | VERY STRONG | 4.84 ; Customisation (icons, own photos) | 34 | 6.58% | HIGH-PRIORITY | 4.35 ; Widget / 3D Touch | 17 | 3.29% | VERY STRONG | 4.00 ; Calendar integration (when it works) | 5 | 0.97% | EMERGING | 4.00
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R02-046 — Simple / clean / easy is the dominant praise — 27.08% of all reviews at mean 4.56

- **Where:** Part 3 row 1
- **This app does:** minimal design
- **User reaction:** praise
- **Magnitude:** 140 (27.08%), mean 4.56
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C006 Stay minimal and ad-free

### R02-076 — The US buys at double the global rate (7.14% vs 5.80%) and rates lowest (3.80) — the commercially damaging combination

- **Where:** §6.1 note 1
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** US confirmed purchase 7.14% vs 5.80% global; US mean 3.80 vs 4.15
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the market most willing to pay is the one most hurt by broken paid features
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C062 Weight English-speaking rich markets; volume ≠ revenue

### R02-080 — One unrebutted privacy objection: 'That's a whole lotta tracking going on by the developer… not to have my data sold'

- **Where:** §6.1 note 5
- **This app does:** tracking/analytics SDKs visible to the user
- **User reaction:** complaint
- **Magnitude:** 1 review (2022, 1★)
- **Direction for us:** do · **Report confidence:** single review · **Generalisable:** yes
- **Side effects:** in an abandoned app nobody answers privacy concerns; a privacy statement in-app pre-empts this
- **Review IDs:** `9189481747`
- **Canonical:** C085 Address tracking / privacy visibly

### R02-094 — After abandonment the only reasons anyone writes about the app are the two pricing themes — unlimited-free (3.0% → 8.2%) and cheap-one-time (0.6% → 8.2%); long-term users value the free tier and buy-once price and have made peace with the rest

- **Where:** Part 7 'Grew as everything else shrank'
- **This app does:** unlimited free + one-time price
- **User reaction:** praise
- **Magnitude:** unlimited-free 8.2%, one-time 8.2% in era D; one user has updated the same review since 2017
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** generous free tier + one-time price is what keeps a product alive with zero development
- **Review IDs:** `13629753462`, `12145789866`, `13550599009`, `13955224346`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it

### R02-097 — No AI-related expectation appears anywhere in the corpus — zero mentions across 517 reviews and 11 years

- **Where:** Part 7 'No AI'
- **This app does:** no AI
- **User reaction:** none
- **Magnitude:** 0 of 517
- **Direction for us:** dont · **Report confidence:** negative evidence · **Generalisable:** yes
- **Canonical:** C056 Don't build AI features on demand grounds

## Audiences

### R02-078 — ADHD framing exists but is marginal here (3 reviews, 3.06% of US) versus 7.08% in report 1's app — this product was never positioned for that audience

- **Where:** §6.1 note 3
- **This app does:** not positioned for ADHD
- **User reaction:** praise
- **Magnitude:** 3 US (3.06%)
- **Direction for us:** do · **Report confidence:** very strong (US) but small n · **Generalisable:** yes
- **Side effects:** audience share follows positioning, not just product fit
- **Review IDs:** `9175173155`, `8207109946`, `8106352419`, `3713698872`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

## Markets and languages

### R02-006 — The US — the largest and richest market — is the worst-rated one (3.80 vs 4.15 global, 23.5% 1–2★ vs 15.1%); Japan worse still at 3.30; the highest-rating markets write the shortest reviews

- **Where:** Part 0 §3
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** US mean 3.80, 23.5% 1–2★; global 4.15, 15.1%; JP 3.30 [limited evidence n=20]; BR 4.65, GB 4.45 with shortest reviews
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** engaged Western users are the honest signal
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R02-029 — One explicit localisation-gated purchase: a Peruvian user would buy today if the app were in Spanish

- **Where:** §1.5 localisation line
- **This app does:** English only
- **User reaction:** blocked-conversion
- **Magnitude:** 1 review
- **Direction for us:** do · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `4316991688`
- **Canonical:** C027 Localise early — it unlocks revenue

### R02-075 — US store themes (n=98, mean 3.80, 23.5% 1–2★) — full table

- **Where:** §6.1 US table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | Count | % of US | Band ; Crashes / freezes | 8 | 8.16% | HIGH-PRIORITY ; Compared against competitors | 8 | 8.16% | HIGH-PRIORITY ; Reminders praised | 7 | 7.14% | HIGH-PRIORITY ; Confirmed purchase | 7 | 7.14% | HIGH-PRIORITY ; Onboarding confusion | 6 | 6.12% | HIGH-PRIORITY ; Statistics too thin | 5 | 5.10% | HIGH-PRIORITY ; Unlimited free habits | 5 | 5.10% | HIGH-PRIORITY ; Data loss | 4 | 4.08% | VERY STRONG ; Date off by one | 4 | 4.08% | VERY STRONG ; Calendar sync damage | 4 | 4.08% | VERY STRONG ; Apple Watch (any) | 4 | 4.08% | VERY STRONG ; ADHD / neurodivergent | 3 | 3.06% | VERY STRONG ; Groups / accountability | 3 | 3.06% | VERY STRONG ; Developer-ecosystem integration | 3 | 3.06% | VERY STRONG ; Colour/dark-mode gap | 3 | 3.06% | VERY STRONG
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R02-079 — Localisation is a non-issue for the US (0%)

- **Where:** §6.1 note 4
- **This app does:** English
- **User reaction:** none
- **Magnitude:** 0% of US
- **Direction for us:** none · **Report confidence:** ignore (US) · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R02-083 — High-review-volume markets [limited evidence below n=50] — full table

- **Where:** §6.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Market | n | Mean | 1–2★ | Dominant local signal ; US | 98 | 3.80 | 23.5% | Crashes, onboarding, purchases — see 6.1 ; Mexico | 36 | 4.31 | 13.9% | Freezing (`2493571137`, `5938382344`, `7232398007`); free tier praised ; Germany | 34 | 4.18 | 17.6% | Data loss (`5423974093`, `5726080829`) and reminders firing per time-of-day instead of per habit (`2165186932`, `1962124981`) ; United Kingdom | 29 | 4.45 | 6.9% | Calendar corruption (`1650678342`), Pro/Watch failure (`1816542296`), abandonware (`10872403505`) ; Canada | 28 | 4.00 | 17.9% | Data loss + freezing (`5891978522`, `5403701988`, `1520975020`, `5229271933`) ; Brazil | 20 | 4.65 | 0.0% | Portuguese localization (`2008072626`, `7897418954`); notification sound too quiet (`2188276454`, `3693806025`) ; Japan | 20 | 3.30 | 25.0% | Worst-rated market: date offset, severe lag, data loss, no Japanese
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** yes
- **Side effects:** review volume is a disclosed engagement proxy, not download or spend data
- **Review IDs:** `2493571137`, `5938382344`, `7232398007`, `5423974093`, `5726080829`, `2165186932`, `1962124981`, `1650678342`, `1816542296`, `10872403505`, `5891978522`, `5403701988`, `1520975020`, `5229271933`, `2008072626`, `7897418954`, `2188276454`, `3693806025`
- **Canonical:** — (nuance register)

### R02-085 — Brazil is the best-rated market (4.65, 0% 1–2★) and asks for Portuguese and a louder notification sound

- **Where:** §6.2 table row Brazil
- **This app does:** no Portuguese
- **User reaction:** praise
- **Magnitude:** n=20 [limited evidence]
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `2008072626`, `7897418954`, `2188276454`, `3693806025`
- **Canonical:** C027 Localise early — it unlocks revenue; C074 Customisable, louder reminder sounds

### R02-086 — Japan is the clearest market-level failure (3.30, 25% 1–2★): four complaint classes stack — off-by-one date, tap latency growing with habit count, data loss, missing Japanese — yet Japanese users still tried it after testing ~10 rivals and praised the buy-once model

- **Where:** §6.2 Japan paragraph
- **This app does:** no Japanese; date bug; lag; data loss
- **User reaction:** 1★-burst
- **Magnitude:** n=20 [limited evidence], mean 3.30
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Side effects:** tap latency that grows with habit count is a performance bug that hits the most engaged users hardest
- **Review IDs:** `1479044283`, `1480026316`, `1597898439`, `4115836897`, `1639153995`, `1664490322`, `3488095225`, `1543097703`, `1560960588`, `4089300870`, `1489024032`, `6376581104`, `9966969216`, `3562883708`, `3825826319`, `10424885681`
- **Canonical:** C027 Localise early — it unlocks revenue; C083 Performance must not degrade with habit count; C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone); C034 Data must never be lost on update, reinstall or phone change

### R02-087 — No spend or revenue data was available, so the high-ARPU market group is a qualitative grouping only — it holds 53.4% of reviews at mean 3.99 vs 4.33 for the rest; the people most able to pay are the least satisfied

- **Where:** §6.3
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 276 of 517 (53.4%) at 3.99 vs 4.33 for 241; [group defined by convention, not data — directional]
- **Direction for us:** must-never-break · **Report confidence:** directional · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R02-088 — Localisation: 14 requests (2.71%, mean 3.50) across 8 languages — Japanese 4, Spanish 3, Russian 3, Portuguese 2, French 2; the app never shipped a non-English UI; 'localization is very desirable, since you are selling the app in the Russian App Store'

- **Where:** §6.4 + table
- **This app does:** English only
- **User reaction:** blocked-conversion
- **Magnitude:** 14 (2.71%), mean 3.50; Language | Count | Review IDs ; Japanese | 4 | `1489024032`, `6376581104`, `9966969216`, `4089300870` ; Spanish | 3 | `2087834366`, `4316991688`, `6185785453` ; Russian | 3 | `1481301722`, `1517984752`, `1482400655` ; Portuguese | 2 | `2008072626`, `7897418954` ; French | 2 | `1785316005`, `2182349196`
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1489024032`, `6376581104`, `9966969216`, `4089300870`, `2087834366`, `4316991688`, `6185785453`, `1481301722`, `1517984752`, `1482400655`, `2008072626`, `7897418954`, `1785316005`, `2182349196`
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R02-004 — Development stopped in May 2021 — 5 years 4 months without an update — and reviewers had been noticing since 2019

- **Where:** Part 0 §1
- **This app does:** no update since v1.5.1, 18 May 2021
- **User reaction:** complaint
- **Magnitude:** 9 explicit abandonment complaints (1.74%, mean 2.89), from 2019 (DE, NI) to 2026 (IT)
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** users read silence as abandonment years before the store listing shows it
- **Review IDs:** `5229271933`, `5080536455`, `6185785453`, `10872403505`, `13788341591`
- **Canonical:** C071 Never ship and walk away

### R02-026 — The ten one-star payers, in full — what each paid for and what happened

- **Where:** §1.4 one-star payer table (verbatim)
- **This app does:** Watch sync failed then wiped the app; habits vanished twice; 5+ s lag + infinite calendar duplicates; crashed permanently after an hour of setup; bought for cross-app integration that does not exist; Watch never synced; calendar sync failed then all data disappeared with no support reply; progress wiped twice losing six months; crashes on iOS 14; all habits gone on day two
- **User reaction:** 1★-burst
- **Magnitude:** ID | Market | Date | What they paid for, and what happened ; `1816542296` | GB | 2017-09 | Bought Pro for Watch sync; it didn't sync, then wiped the phone app ; `1777981808` | CA | 2017-09 | *"I just bought your app"* → habits vanished twice; Watch shows tomorrow ; `1639153995` | JP | 2017-06 | Bought Pro → 5+ second lag per tap; calendar sync spawned infinite duplicate events and a phantom "2001" event; asks for a refund ; `1695627701` | US | 2017-07 | Bought, spent an hour entering habits, app then crashed permanently ; `2109039905` | US | 2018-01 | Bought assuming integration with the developer's *Focus Matrix* / *Be Focused*; there is none; *"regret the purchase"* ; `4402829597` | US | 2019-07 | *"Doesn't sync with iwatch. Paid to upgrade, still doesn't sync."* ; `5403701988` | CA | 2020-01 | Paid for calendar sync, it didn't sync, then all data disappeared; no support reply ; `6379792275` | RU | 2020-08 | Paid; progress wiped twice — once losing nearly six months ; `7232398007` | MX | 2021-04 | Bought *because* they liked *Be Focused* and *Focus Matrix*; crashes on both iPad and iPhone under iOS 14 ; `8106352419` | US | 2021-12 | Upgraded to Pro on day one *because the developer's other apps work*; all habits gone on day two
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** this list IS the churn analysis; the common thread is data loss after paying
- **Review IDs:** `1816542296`, `1777981808`, `1639153995`, `1695627701`, `2109039905`, `4402829597`, `5403701988`, `6379792275`, `7232398007`, `8106352419`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C034 Data must never be lost on update, reinstall or phone change

### R02-090 — Four eras: A 2016–17 launch n=164 mean 3.97 19.5% 1–2★; B 2018–19 maturity 161/4.19/13.0%; C 2020–21 final updates 107/4.21/14.0%; D 2022–26 post-abandonment 85/4.31/11.8%

- **Where:** Part 7 era table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era | n | Mean | 1–2★ ; A 2016–17 launch | 164 | 3.97 | 19.5% ; B 2018–19 maturity | 161 | 4.19 | 13.0% ; C 2020–21 final updates | 107 | 4.21 | 14.0% ; D 2022–26 post-abandonment | 85 | 4.31 | 11.8%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R02-091 — Theme share by era (% of that era's reviews) — full table

- **Where:** Part 7 theme-by-era table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | A 2016-17 | B 2018-19 | C 2020-21 | D 2022-26 ; Crashes / freezes | 6.7% | 3.7% | 8.4% | 2.4% ; Data loss | 6.1% | 1.9% | 7.5% | 1.2% ; Date off by one | 6.7% | 1.9% | 0.0% | 0.0% ; Apple Watch broken | 1.8% | 4.3% | 0.9% | 1.2% ; Calendar sync damage | 3.0% | 1.2% | 0.9% | 1.2% ; Compared vs competitors | 11.0% | 3.7% | 3.7% | 3.5% ; Unlimited free habits | 3.0% | 7.5% | 5.6% | 8.2% ; One-time cheap price | 0.6% | 2.5% | 6.5% | 8.2% ; Abandonware | 0.0% | 2.5% | 2.8% | 2.4% ; Localization | 3.7% | 2.5% | 2.8% | 1.2%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R02-092 — The off-by-one date bug is the one clear engineering win: 6.7% → 1.9% → 0.0%, gone after 2019 and never mentioned again

- **Where:** Part 7 'Fixed'
- **This app does:** fixed the date bug by 2019
- **User reaction:** praise
- **Magnitude:** 6.7% (A) → 1.9% (B) → 0.0% (C, D)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone); C059 Be visibly responsive; fixes bring reviewers back

### R02-093 — Crashes (6.7% → 3.7% → 8.4%) and data loss (6.1% → 1.9% → 7.5%) spiked in 2020–21 with iOS 14 / 14.5; the drop to ~2% afterwards is not a fix — it is the sound of users having left

- **Where:** Part 7 'Got worse, then went quiet'
- **This app does:** iOS 14 regressions never fixed; last code change May 2021
- **User reaction:** 1★-burst
- **Magnitude:** era C crashes 8.4%, data loss 7.5%; era D 85 reviews vs 164 in era A
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** an unmaintained app becomes an OS-release liability; falling complaint share after abandonment is attrition, not repair
- **Review IDs:** `7232398007`, `7580228017`, `7271771390`, `6734756659`
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C071 Never ship and walk away

### R02-095 — Discovery-stage competitive comparison collapsed from 11.0% (2016–17) to 3.5% — the app stopped being evaluated by new shoppers around 2018

- **Where:** Part 7 'competitive scrutiny collapsed'
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 11.0% → 3.7% → 3.7% → 3.5%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Side effects:** comparison mentions are a proxy for new-user acquisition
- **Canonical:** — (nuance register)

## Positioning

### R02-001 — Daily Habits is an abandoned free habit tracker: last updated 18 May 2021 (v1.5.1), 517 reviews across 61 storefronts, 299 US ratings at 4.40

- **Where:** header line 3-6
- **This app does:** developer Olha Ievenko / XWaveSoft, bundle com.xwavesoft.habits; sibling apps Be Focused and Focus Matrix; free download, ad-supported, one-time Pro
- **User reaction:** mixed
- **Magnitude:** 517 reviews, 61 storefronts, Nov 2016 → Aug 2026; 299 US ratings at 4.40; last update 18 May 2021
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R02-038 — 'I compared it against others and chose this' appears in 21 5★ reviews — genuine preference, not default

- **Where:** Part 2 5★ row 4
- **This app does:** wins head-to-head comparisons
- **User reaction:** praise
- **Magnitude:** 21 of 314 5★; 6.00% of corpus (Part 3)
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against

### R02-053 — 6.00% of reviewers actively shopped before choosing this app — tried 10, a dozen, '20 hours testing' — so the product wins on merit when compared, beating Productive and Way of Life

- **Where:** Part 3 'shop before choosing' paragraph
- **This app does:** wins comparisons on free tier + simplicity
- **User reaction:** praise
- **Magnitude:** 31 (6.00%), mean 4.29
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `3562883708`, `9489418687`, `1663634672`, `7562844763`, `1509521731`, `1641223556`, `1673348075`, `1683318031`, `1485799388`, `1492916849`, `1835187375`, `2069816938`
- **Canonical:** C005 Know which competitors buyers compare against

### R02-063 — Dated or unattractive design draws 6 reviews (1.16%, mean 3.67) — 'doesn't look as nice as the Atomic Habits app'

- **Where:** Part 4 table row 'Dated design'
- **This app does:** design frozen since 2021; 'only green'
- **User reaction:** complaint
- **Magnitude:** 6 (1.16%), mean 3.67
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12488497405`
- **Canonical:** C057 Offer a non-pastel / premium design option

### R02-082 — In the US, 'compared against competitors' ties crashes as the top theme (8.16%)

- **Where:** §6.1 table row 'Compared against competitors'
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 8 US (8.16%)
- **Direction for us:** do · **Report confidence:** high-priority (US) · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R02-035 — Cross-app integration was implied by the sibling apps and never delivered — it drove at least two purchases and both ended in 1★, and three more reviews ask for it

- **Where:** §1.6 #5
- **This app does:** no integration between Daily Habits, Be Focused and Focus Matrix
- **User reaction:** 1★-burst
- **Magnitude:** 2 purchases → 1★; 3 further requests
- **Direction for us:** dont · **Report confidence:** weak count, clear mechanism · **Generalisable:** yes
- **Side effects:** an app family raises expectations of integration; either deliver it or say plainly it does not exist
- **Review IDs:** `2109039905`, `7232398007`, `8731669029`, `6467272815`, `9974150902`
- **Canonical:** C087 Never imply cross-app integration you don't have

### R02-065 — Rating-prompt and cross-promo spam (promoting the developer's other apps) draws 4 complaints

- **Where:** Part 4 table row 'Rating-prompt & cross-promo spam'
- **This app does:** in-app prompts for ratings and sibling apps
- **User reaction:** complaint
- **Magnitude:** 4 (0.77%), mean 3.00
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C088 No rating-prompt or cross-promo spam, especially to payers

## Things not to do

### R02-115 — Do not ship and walk away — abandonment is visible to users within about a year and the app becomes an iOS-release liability for paying users with no recourse

- **Where:** Part 8 #18
- **This app does:** abandoned May 2021
- **User reaction:** complaint
- **Magnitude:** abandonware 1.74%; iOS 14 broke it for payers
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R02-004, R02-093
- **Review IDs:** `6185785453`
- **Canonical:** C071 Never ship and walk away

### R02-116 — Do not spam rating prompts or cross-promote to paying customers

- **Where:** Part 8 #19
- **This app does:** rating prompts + cross-promo
- **User reaction:** complaint
- **Magnitude:** 3 IDs
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** evidence: R02-065
- **Review IDs:** `1484050413`, `3342902073`, `7598926605`
- **Canonical:** C088 No rating-prompt or cross-promo spam, especially to payers

### R02-117 — Do not seed launch reviews — two users spotted it in week one and said so publicly, and it permanently contaminates your own analytics baseline

- **Where:** Part 8 #20
- **This app does:** possibly seeded launch
- **User reaction:** complaint
- **Magnitude:** 2 IDs
- **Direction for us:** dont · **Report confidence:** inference · **Generalisable:** yes
- **Conditions:** evidence: R02-008
- **Review IDs:** `1479044283`, `1484864417`
- **Canonical:** C076 Never seed launch reviews

## Things to do

### R02-113 — Lead with 'unlimited habits, free, no subscription' — it is what every advocate in this corpus says unprompted

- **Where:** Part 8 #16
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** the two era-D themes at 8.2% each
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R02-047, R02-094
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it

### R02-114 — If you have sibling apps, integrate them or say plainly that you don't — assumed integration drove purchases that ended in 1★

- **Where:** Part 8 #17
- **This app does:** no integration
- **User reaction:** 1★-burst
- **Magnitude:** 2 purchases → 1★
- **Direction for us:** do · **Report confidence:** weak count, clear mechanism · **Generalisable:** yes
- **Conditions:** evidence: R02-035, R02-073
- **Review IDs:** `2109039905`, `7232398007`
- **Canonical:** C087 Never imply cross-app integration you don't have; C060 Cross-sell an app family on brand trust

## Contradictions

### R02-120 — The Apple Watch app is simultaneously a stated purchase driver ('far superior to other habit trackers') and 80% broken (12 of 15 mentions negative, mean 2.33) — same feature, both directions, decided by reliability alone

- **Where:** Part 4 'Apple Watch' + §1.3
- **This app does:** Watch app exists, unreliable
- **User reaction:** mixed
- **Magnitude:** purchase reason for 2+ buyers; 12/15 negative
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1482775394`, `1856430373`, `4402829597`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R02-121 — This report says 'do not gate the habit cap' (unlimited free, mean 4.97); report 1 says 'set the cap generously (6+) and leave it alone' because unlimited is its #2 purchase reason — the two apps resolve the free-cap question differently

- **Where:** Part 8 #7 vs report 1 Part 8 #9
- **This app does:** unlimited habits free
- **User reaction:** mixed
- **Magnitude:** here: unlimited-free 5.80% at 4.97; report 1: cap complaints ×7.5 on 2★ but 'unlimited' #2 purchase reason
- **Direction for us:** undecided · **Report confidence:** cross-report · **Generalisable:** yes
- **Conditions:** what both agree on: never change the cap once set; see Research Reports/Feature Gating vs Quantity.md
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

## Data caveats and method

### R02-002 — Method: signal bands applied against two denominators only (all 517, and the US n=98 — the only storefront over the 50-review bar); one review = 0.19%, so every band boundary is soft

- **Where:** How to read this
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 60 other storefronts hold 419 reviews (mean 4.23) — counted globally, no standalone claims; bands <0.1 ignore / 0.1–0.5 weak / 0.5–1 emerging / 1–3 meaningful / 3–5 very strong / >5 high-priority
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Conditions:** a five-review swing moves a theme a full band
- **Canonical:** — (nuance register)

### R02-005 — Review volume fell 96% (100/yr in 2019 → 4 in 2026) while the mean rose from 4.19 to 4.31 — survivorship, not recovery; nothing shipped after May 2021

- **Where:** Part 0 §2 + year table
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2017 | 99 | 3.74 | 25.3% | 48.5% ; 2018 | 61 | 3.87 | 18.0% | 45.9% ; 2019 | 100 | 4.39 | 10.0% | 68.0% ; 2020 | 62 | 4.10 | 16.1% | 59.7% ; 2021 | 45 | 4.38 | 11.1% | 75.6% ; 2022 | 32 | 4.25 | 15.6% | 68.8% ; 2023 | 20 | 4.20 | 15.0% | 65.0% ; 2024 | 15 | 4.27 | 6.7% | 46.7% ; 2025 | 14 | 4.50 | 7.1% | 78.6% ; 2026 | 4 | 4.75 | 0.0% | 75.0%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** do not read a rising average as improvement when volume collapses
- **Conditions:** 2017 was the worst year: mean 3.74, 25.3% 1–2★
- **Canonical:** — (nuance register)

### R02-007 — A quarter of the corpus carries almost no product information: 132 reviews (25.5%) under 40 characters averaging 4.52 — short reviews inflate the rating; Vietnam is 14 reviews, 13 of them 5★, mostly 'Good' / 'Ok'

- **Where:** Part 0 §4
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 132 (25.5%) under 40 chars, mean 4.52 vs corpus 4.15; VN 14 reviews, 13 5★, mean 4.93
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `4088257905`, `4173137456`, `4707702065`, `5720578554`, `1634520759`
- **Canonical:** — (nuance register)

### R02-008 — The launch window (Nov–Dec 2016) looks partly seeded: generic non-native 5★ reviews within days of release, two reviewers called it out, and a free-Pro giveaway ran at launch

- **Where:** Part 0 §5
- **This app does:** possibly seeded launch reviews + free-Pro giveaway at launch
- **User reaction:** mixed
- **Magnitude:** Nov–Dec 2016 = 65 reviews at 4.32 / 66.2% 5★ vs 4.12 / 60.0% for the rest; inference from style and timing, not proof
- **Direction for us:** dont · **Report confidence:** flagged with caution · **Generalisable:** yes
- **Side effects:** 'the obviously machine-translated 5-star reviews actually make a bad impression' (JP); 'the positive reviews are LIES' (RU) — seeded reviews are noticed and cost trust
- **Conditions:** discount the first two months rather than treating them as baseline
- **Review IDs:** `1478551952`, `1478933026`, `1485661227`, `1478389236`, `1478560873`, `1479031508`, `1478508225`, `1478967168`, `1478263216`, `1479044283`, `1484864417`, `1483240079`, `1482736956`, `1484186051`
- **Canonical:** C076 Never seed launch reviews

### R02-012 — One reviewer calls it a subscription; isolated and contradicted by the listing and by 18 other reviewers praising the one-time fee — treat as reviewer error

- **Where:** §1.1 bullet 3
- **This app does:** one-time purchase
- **User reaction:** none
- **Magnitude:** 1 vs 18
- **Direction for us:** none · **Report confidence:** isolated · **Generalisable:** yes
- **Review IDs:** `7418712220`
- **Canonical:** — (nuance register)

### R02-089 — 60 of 61 storefronts fall below the 50-review threshold (419 reviews, mean 4.23); no standalone conclusion is drawn from any of them

- **Where:** §6.5
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 60 storefronts, 419 reviews, mean 4.23
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R02-118 — Method: 517 records, zero duplicates, 100% reconciliation with by_country and manifest; all reviews read in full in 17 languages; regex candidates then hand-curated ID lists (false positives: 'add' vs ADHD, 'productive' vs the app); non-exclusive theme membership; one external source (Apple lookup API, 2026-09-09); n=517 is small (one review = 0.19%); only the US clears 50; eras have shrinking samples (164/161/107/85)

- **Where:** Appendix — method
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 517 reviews; 5★ 314 / 4★ 89 / 3★ 36 / 2★ 31 / 1★ 47; mean 4.145; is_edited true on 4
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Conditions:** report 2 uses the older part structure (Parts 0–8 + Appendix, no Part 9)
- **Review IDs:** `1816542296`
- **Canonical:** — (nuance register)
