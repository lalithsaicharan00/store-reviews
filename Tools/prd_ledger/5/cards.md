# Cards — report 5

Source: `App Store Reports/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD (REPORT).md`  
110 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 2
- [Must-haves](#must-haves) — 5
- [Must never break](#must-never-break) — 13
- [Features](#features) — 21
- [Monetization](#monetization) — 8
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 17
- [Audiences](#audiences) — 4
- [Markets and languages](#markets-and-languages) — 10
- [Dated events and trends](#dated-events-and-trends) — 8
- [Positioning](#positioning) — 1
- [Anti-patterns](#anti-patterns) — 6
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 3
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 5

## Product rules

### R05-092 — Ship — and prominently surface — the lifetime purchase; asked for continuously 2020–2026 (46 reviews at 3.76, from fans); 2026 reviews suggest it exists but is under-marketed; one bought within five minutes of finding it

- **Where:** Part 9 #9
- **This app does:** lifetime SKU shipped 2026, under-marketed
- **User reaction:** purchase-driver
- **Magnitude:** 46 (1.38%)
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-020, R05-031
- **Review IDs:** `13987336109`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R05-094 — Remove ads for paying subscribers unconditionally, including reward-gated features like streak savers — a 30-second unskippable ad to a subscriber produced the most damaging recent payer review; not a revenue trade-off, a trust liability

- **Where:** Part 9 #11
- **This app does:** ads shown to payers
- **User reaction:** 1★-burst
- **Magnitude:** ads 5.8% of payers
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-019, R05-028, R05-033
- **Review IDs:** `14021959851`
- **Canonical:** C127 Never show ads to paying subscribers

## Must-haves

### R05-058 — Data loss — 91 (2.72%), mean 3.42 — routines vanishing, usually after an update: 'all my routines disappeared… ~40 items in one routine' (restored after dev contact); 'third time everything vanished'; turning on Sync deleted all routines; 'make sure you create an account — I did not, and lost my account + my 135 days streak' — local-first with no default account = data loss by design

- **Where:** §4.3
- **This app does:** local-first, account optional, sync can wipe data
- **User reaction:** 1★-burst
- **Magnitude:** 91 (2.72%), mean 3.42
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** several discovered only after the fact that nothing was backed up
- **Conditions:** the account must be default-on or backup must be automatic; 'Sync' must never be destructive
- **Review IDs:** `12925478996`, `13049897248`, `13365456673`, `11500955921`, `8120137325`, `13760050939`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one

### R05-059 — 'No way to contact support' — 97 (2.90%), mean 3.70 — the review page is being used as a helpdesk; a vicious loop: the only support channel is inside an app that won't open; the support link is 'hidden behind a lone cryptic icon'; three unanswered emails while developers reply to public reviews same-day

- **Where:** §4.4
- **This app does:** support email only reachable in-app; emails unanswered while reviews get replies
- **User reaction:** complaint
- **Magnitude:** 97 (2.90%), mean 3.70
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** prioritising public review replies over private email is noticed and reads badly
- **Conditions:** a support path must exist outside the app (web page, listing) and be answered
- **Review IDs:** `8229765673`, `8512899266`, `9654996405`, `13469367908`, `13769267096`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R05-085 — Make the notification escalation ladder user-configurable (once / escalating / until-started, per routine) and stop silently retuning it — some depend on the un-dismissable buzz, others are driven out by it

- **Where:** Part 9 #2
- **This app does:** one global alarm behaviour
- **User reaction:** mixed
- **Magnitude:** 5 IDs
- **Direction for us:** must-have · **Report confidence:** clear mechanism · **Generalisable:** yes
- **Conditions:** evidence: R05-057
- **Review IDs:** `13667837214`, `14371016110`, `14447685280`, `12780143141`
- **Canonical:** C123 Notification escalation must be user-configurable, never silently retuned

### R05-088 — Guarantee data durability: prompt for account creation BEFORE the first routine is saved; make sync non-destructive; add a visible manual backup/restore

- **Where:** Part 9 #5
- **This app does:** account optional; sync destructive
- **User reaction:** 1★-burst
- **Magnitude:** 91 (2.72%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-058
- **Review IDs:** `8120137325`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one; C153 Automatic cloud backup on by default — never manual opt-in

### R05-090 — Put an in-app, localised support and cancellation path one tap from the home screen — and make it reachable when the app fails to launch (a web fallback); this alone would materially clean up Korea's review page

- **Where:** Part 9 #7
- **This app does:** support hidden, in-app only
- **User reaction:** 1★-burst
- **Magnitude:** 97 (2.90%) + KR 57 billing tickets
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R05-059, R05-073
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C112 In-app cancellation

## Must never break

### R05-029 — Billing integrity: 91 reviews (2.72%, mean 2.31, 64.8% 1–2★) — refund demanded 52 (1.56%), 'free trial' charged immediately / annual instead 31 (0.93%, mean 1.55, 87.1% 1–2★), unexpected/auto-renewal charge 26, cannot cancel 12, 1+1 gift-code promo not honoured 12 — small globally, concentrated in Korea, severe where it lands; 'It said free trial but billed me instantly. I tried to get a refund 60 seconds later'; still occurring Sep 2026

- **Where:** §1.4 opening + table
- **This app does:** trial charges immediately for some; cancellation and refunds fail
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of 3,342 | Mean | 1–2★ | Band ; Refund demanded | 52 | 1.56% | 2.25 | 67.3% | Meaningful ; "Free trial" charged immediately / annual instead | 31 | 0.93% | 1.55 | 87.1% | Emerging ; Unexpected / auto-renewal charge | 26 | 0.78% | 1.96 | 76.9% | Emerging ; Cannot cancel | 12 | 0.36% | 2.08 | 66.7% | Weak ; 1+1 gift-code promo not honoured | 12 | 0.36% | 3.75 | 25.0% | Weak
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** trial/billing reviews average 1.55 stars — the single most reliable generator of 1★ in the corpus; some describe cancelling and still being charged (defect), others misreading the plan screen
- **Conditions:** same shape as report 4 at a fifth of the rate
- **Review IDs:** `11422332321`, `11674221985`, `13666735555`, `12852521520`, `11919502264`, `12403701027`, `12379919405`, `13878515388`, `14509669820`, `12213361997`, `12448354189`, `12477311939`, `12394473219`
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial

### R05-047 — Crash / won't open / infinite loading — 135 (4.04%), mean 2.91, 43.7% 1–2★

- **Where:** Part 4 row 5
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 135 (4.04%)
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R05-049 — Cross-device sync failure — 107 (3.20%), mean 3.83; 3.1× over-represented among payers

- **Where:** Part 4 row 9
- **This app does:** sync unreliable
- **User reaction:** complaint
- **Magnitude:** 107 (3.20%)
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it

### R05-051 — Lag / freeze / unresponsive — 69 (2.06%), mean 3.03, 39.1% 1–2★

- **Where:** Part 4 row 16
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 69 (2.06%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C083 Performance must not degrade with habit count

### R05-055 — Battery drain and overheating — 62 reviews (1.86%), mean 2.94, 43.5% 1–2★ — the highest-severity engineering complaint by rating impact: 30–90% of daily battery, device heating, because the timer runs in the background; '5× Instagram? no way'; a brand-new iPhone losing 15% in one hour of morning tasks — and that reviewer will not renew; partially fixed once, then regressed

- **Where:** §4.1
- **This app does:** background timer drains battery
- **User reaction:** 1★-burst
- **Magnitude:** 62 (1.86%), mean 2.94; peaks 2023 (22) and 2025 (17), live in 2026 (5)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** a timer app that is 'currently unusable' because of battery is losing subscribers who otherwise love it
- **Review IDs:** `11515721909`, `10098317714`, `13376641175`, `13249089782`, `14491246957`, `14493761177`, `9502486128`, `9764474844`, `10239716747`, `9958518584`, `10135282986`, `9759386345`, `11125731785`, `13091482216`, `13195777384`, `13520796132`
- **Canonical:** C122 Background battery and thermals

### R05-056 — Notifications not firing — 99 (2.96%), mean 3.53 — a total-loss failure for an app whose core loop is 'the app tells you to start': 'as someone with adhd the notifications are the main purpose of it'; 'this app won't work for me if the onus is on me to remember to launch it'

- **Where:** §4.2 not firing
- **This app does:** notifications silent
- **User reaction:** 1★-burst
- **Magnitude:** 99 (2.96%), mean 3.53
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13318004023`, `10337926884`, `12327812271`, `13446802332`, `13830916795`, `13982523131`, `9219301950`, `11903518291`
- **Canonical:** C039 Reminders fire reliably, once

### R05-062 — The undo gap — 42 (1.26%): tapping 'done' by accident is unrecoverable and the buttons sit close together; first reported Jan 2020 ('pause and done should be further apart'), still described in 2026 — six and a half years

- **Where:** §4.7
- **This app does:** no undo; adjacent pause/done buttons
- **User reaction:** complaint
- **Magnitude:** 42 (1.26%), mean 3.52
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** the same shape as report 3's accidental widget reset: an irreversible tap on a high-frequency surface
- **Review IDs:** `12069182383`, `5432864399`, `13702441710`, `11580842783`, `11217088616`, `12629348274`, `9980992196`
- **Canonical:** C090 Destructive actions on widgets, quick surfaces and running routines need confirmation or undo

### R05-063 — The midnight boundary breaks night routines — 14 (0.42%): a routine started 23:30 and finished 00:30 is logged to the next day and the starting day recorded blank, destroying streaks for late-night users; a 'day ends at 5am' setting was not honoured — fixed within three weeks after a developer reply (a documented win)

- **Where:** §4.8
- **This app does:** day boundary at midnight; custom day-end setting buggy then fixed
- **User reaction:** complaint
- **Magnitude:** 14 (0.42%)
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** a configurable day-end (e.g. 5am) is required for night routines and shift workers
- **Review IDs:** `13490673673`, `13283851839`, `13317314197`, `13057963564`, `12949429540`, `13175278334`, `14367123124`, `13715558049`, `13203062194`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

### R05-084 — Kill the notification loop — 33 lifetime reports, 12 in May 2026, mean 3.00; punishes the exact trait the product sells to; the biggest rating delta for the least work

- **Where:** Part 9 #1
- **This app does:** notification loop regression
- **User reaction:** 1★-burst
- **Magnitude:** 33; 12 in one month
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R05-010
- **Canonical:** C039 Reminders fire reliably, once

### R05-086 — Fix background battery and thermals — mean 2.94, 43.5% 1–2★, the worst non-billing theme; at least one reviewer will not renew because of it; audit the background timer, consider Live Activity instead of a wake-locked foreground timer

- **Where:** Part 9 #3
- **This app does:** background timer
- **User reaction:** 1★-burst
- **Magnitude:** 62 (1.86%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-055
- **Canonical:** C122 Background battery and thermals

### R05-087 — Add a first-class undo/back on the running routine and separate the pause and done buttons — reported continuously since January 2020, trivially fixable

- **Where:** Part 9 #4
- **This app does:** no undo
- **User reaction:** complaint
- **Magnitude:** 42 (1.26%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-062
- **Canonical:** C090 Destructive actions on widgets, quick surfaces and running routines need confirmation or undo

### R05-089 — Fix day-boundary handling for night routines — log to the day the routine STARTED and honour the user's 'day ends at' setting

- **Where:** Part 9 #6
- **This app does:** midnight boundary
- **User reaction:** complaint
- **Magnitude:** 14 (0.42%)
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R05-063
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

### R05-095 — Fix the trial→charge flow — make the trial state explicit, send a pre-charge reminder email (none is sent), never bill on login to a pre-existing account

- **Where:** Part 9 #12
- **This app does:** trial ambiguity; no pre-charge email; billed on login
- **User reaction:** 1★-burst
- **Magnitude:** 31 at 1.55
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** evidence: R05-029
- **Review IDs:** `14438727762`, `13666735555`
- **Canonical:** C109 A free trial must be a real trial

## Features

### R05-006 — The single feature that makes the app work is the live finish-time estimate: 277 reviews (8.29%, mean 4.16) praise the timer/countdown/'all ends by' ETA — it removes the need to hold a schedule in working memory and tells you continuously whether you are still on time; 'an ETA that gets pushed back whenever I take longer on a task is just revolutionary for my severe lack of time concept'

- **Where:** Part 0 §3
- **This app does:** sequential timer + live ETA, free
- **User reaction:** praise
- **Magnitude:** 277 (8.29%), mean 4.16, high-priority
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 'Cure for Time Blindness' — the same description across seven years and every language
- **Review IDs:** `8204342733`, `9183771774`, `9017685503`, `10925188822`, `14115048883`, `11130087506`, `8382971100`, `6883027790`, `7510768204`, `8016986126`, `9228861293`, `9499393403`, `10746011966`
- **Canonical:** C120 Sequential routine timer with spoken next step and live finish-time estimate

### R05-013 — Creating routines with unlimited steps/tasks is free — 'you make routines with unlimited steps and checklists'

- **Where:** §1.1 row 1
- **This app does:** unlimited steps free; routines capped at 2
- **User reaction:** praise
- **Magnitude:** 2 IDs
- **Direction for us:** build-free · **Report confidence:** stated · **Generalisable:** yes
- **Conditions:** the cap is on the number of ROUTINES, not tasks — quantity gating at a coarser grain than report 4's task cap
- **Review IDs:** `12470101467`, `13361043130`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R05-014 — The sequential timer, voice/TTS announcements and live ETA are free — the core value is not gated

- **Where:** §1.1 row 3
- **This app does:** core timer free
- **User reaction:** praise
- **Magnitude:** 3 IDs
- **Direction for us:** build-free · **Report confidence:** stated · **Generalisable:** yes
- **Review IDs:** `13503431066`, `12470101467`, `11640510418`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C120 Sequential routine timer with spoken next step and live finish-time estimate

### R05-015 — The full icon/emoji library is partly paywalled — 17 reviews (0.51%): 'one of them were freaking ICONS'

- **Where:** §1.1 row 4
- **This app does:** icons partly paid
- **User reaction:** complaint
- **Magnitude:** 17 (0.51%)
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** report 1 and 2 gave icons free and it drove 5★; gating icons draws a 1★ here
- **Review IDs:** `11079201751`, `10203934956`, `9775758576`, `12257661729`, `13261964716`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R05-016 — Analytics / statistics are paywalled — 'statistics being a paid service?' (KR, 1★)

- **Where:** §1.1 row 5
- **This app does:** stats paid
- **User reaction:** complaint
- **Magnitude:** 3 IDs
- **Direction for us:** build-paid · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `9189599066`, `9264877129`, `11486140970`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R05-017 — Custom reminder sounds and satisfaction notes are paywalled

- **Where:** §1.1 row 6
- **This app does:** paid
- **User reaction:** complaint
- **Magnitude:** 1 ID
- **Direction for us:** undecided · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `11486140970`
- **Canonical:** C074 Customisable, louder reminder sounds; C172 Per-day / per-habit notes and journal text

### R05-041 — Timer, countdown and live ETA — 277 (8.29%), mean 4.16 — the lower mean is because the theme also appears in complaints about the timer being MANDATORY (§4.6)

- **Where:** Part 3 §4
- **This app does:** timer always on
- **User reaction:** mixed
- **Magnitude:** 277 (8.29%), mean 4.16
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C120 Sequential routine timer with spoken next step and live finish-time estimate; C121 Untimed / checklist mode as a per-routine toggle

### R05-042 — Streaks, plants and gamification — 80 (2.39%, mean 4.44): the plant → tree → forest badge system lands — 'when I see that plant turn into a tree, I wanna keep going'; '215 jours… je compte bien devenir une forêt'; streak-restore tickets praised

- **Where:** Part 3 §6
- **This app does:** plant-growth streak badges; streak savers
- **User reaction:** praise
- **Magnitude:** 80 (2.39%), mean 4.44
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** a growth metaphor (plant→forest) works as a streak visual; streak-restore tickets are liked until ad-gated (R05-019)
- **Review IDs:** `12268271071`, `13126347470`, `13459034679`, `12842116546`, `9326484636`, `12359093778`
- **Canonical:** C024 Streaks / gamification

### R05-045 — Recommended / celebrity / community routines — 19 (0.57%, mean 4.37) — genuinely mixed: liked by some, 'the Dwayne Johnson and Kim Kardashian routine examples are cringey' to others

- **Where:** Part 3 §9
- **This app does:** celebrity routine templates
- **User reaction:** mixed
- **Magnitude:** 19 (0.57%), mean 4.37
- **Direction for us:** research · **Report confidence:** weak, mixed · **Generalisable:** yes
- **Conditions:** templates from named celebrities polarise; community routines are safer
- **Review IDs:** `8619714804`, `12109193143`, `13951195485`, `11984464052`, `13094268733`
- **Canonical:** C118 Preset routines / templates / programs

### R05-046 — Top complaints and unmet needs, 30 rows — full table

- **Where:** Part 4 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** # | Theme | n | % | Mean | 1–2★ | Band ; 1 | Any reliability defect (umbrella) | 609 | 18.22% | 3.36 | 30.9% | High-priority ; 2 | Any monetization theme (umbrella) | 585 | 17.50% | 3.50 | 27.7% | High-priority ; 3 | Subscription model objection | 255 | 7.63% | 3.47 | 29.4% | High-priority ; 4 | Free 2-routine cap named | 168 | 5.03% | 3.92 | 12.5% | High-priority ; 5 | Crash / won't open / infinite loading | 135 | 4.04% | 2.91 | 43.7% | Very strong ; 6 | Must-pay-to-use perception | 130 | 3.89% | 3.52 | 25.4% | Very strong ; 7 | Generic bug report | 124 | 3.71% | 3.16 | 36.3% | Very strong ; 8 | Apple Watch defect | 109 | 3.26% | 3.62 | 22.0% | Very strong ; 9 | Cross-device sync failure | 107 | 3.20% | 3.83 | 17.8% | Very strong ; 10 | Notifications don't fire / no sound | 99 | 2.96% | 3.53 | 25.3% | Meaningful ; 11 | No way to reach support | 97 | 2.90% | 3.70 | 29.9% | Meaningful ; 12 | Data loss (routines/records deleted) | 91 | 2.72% | 3.42 | 29.7% | Meaningful ; 13 | Billing integrity (umbrella) | 91 | 2.72% | 2.31 | 64.8% | Meaningful ; 14 | Widget missing/broken/limited | 92 | 2.75% | 4.02 | 10.9% | Meaningful ; 15 | Wants untimed checklist mode | 69 | 2.06% | 4.26 | 7.2% | Meaningful ; 16 | Lag / freeze / unresponsive | 69 | 2.06% | 3.03 | 39.1% | Meaningful ; 17 | Battery drain / overheating | 62 | 1.86% | 2.94 | 43.5% | Meaningful ; 18 | Refund demanded | 52 | 1.56% | 2.25 | 67.3% | Meaningful ; 19 | Ads | 49 | 1.47% | 3.41 | 32.7% | Meaningful ; 20 | Wants one-time/lifetime purchase | 46 | 1.38% | 3.76 | 17.4% | Meaningful ; 21 | Wants undo / go-back on a completed task | 42 | 1.26% | 3.52 | 26.2% | Meaningful ; 22 | Wants ≥3 free routines | 42 | 1.26% | 4.10 | 4.8% | Meaningful ; 23 | Wants Shortcuts / auto-start | 37 | 1.11% | 4.08 | 10.8% | Meaningful ; 24 | Wants per-task day scheduling | 36 | 1.08% | 3.72 | 16.7% | Meaningful ; 25 | Notification loop / spam | 33 | 0.99% | 3.00 | 36.4% | Emerging ; 26 | Voice can't be disabled / too loud | 25 | 0.75% | 3.88 | 16.0% | Emerging ; 27 | Voice sounds robotic/creepy | 30 | 0.90% | 3.67 | 16.7% | Emerging ; 28 | Bad translation | 26 | 0.78% | 2.73 | 50.0% | Emerging ; 29 | China: app will not open at all | 23 | 0.69% | 2.52 | 56.5% | Emerging ; 30 | Minors visible in social feed (safety) | 23 | 0.69% | 3.52 | 30.4% | Emerging
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R05-050 — Widget missing / broken / limited — 92 (2.75%), mean 4.02, only 10.9% 1–2★ — fans asking; Lock Screen, Live Activity and watch complication requested to 'run the routine without opening the app'

- **Where:** Part 4 row 14
- **This app does:** widgets weak
- **User reaction:** complaint
- **Magnitude:** 92 (2.75%), mean 4.02
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free; C023 Interactive widget check-off

### R05-052 — Shortcuts / auto-start / URL triggers — 37 (1.11%), mean 4.08 — 'remove the last manual step (opening the app)'

- **Where:** Part 4 row 23
- **This app does:** no automation hooks
- **User reaction:** complaint
- **Magnitude:** 37 (1.11%), mean 4.08
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R05-053 — The TTS voice: 25 (0.75%) say it can't be disabled or is too loud; 30 (0.90%) say it sounds robotic/creepy

- **Where:** Part 4 rows 26–27
- **This app does:** voice guidance always on
- **User reaction:** complaint
- **Magnitude:** 25 + 30
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** a signature feature still needs an off switch and a better voice
- **Canonical:** C120 Sequential routine timer with spoken next step and live finish-time estimate

### R05-061 — The timer is mandatory and a real minority needs it not to be: 69 (2.06%, mean 4.26) ask for an untimed/checklist mode and 15 (0.45%) say the timer causes anxiety — 'you cannot simply mark a habit as done; you are forced to start a timer… turn off the timer and you'll earn 5 stars'; 'I need a dumb mode'; an AuDHD user: 'the time component brings me severe anxiety… I just want the reminder to do the thing. Not the count down' — a checklist shipped ~late 2025 but as a SEPARATE object, not a per-routine mode, which is not what was asked

- **Where:** §4.6
- **This app does:** timer-only routines; separate checklist added late 2025
- **User reaction:** complaint
- **Magnitude:** 69 (2.06%), mean 4.26; 15 (0.45%) anxiety
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** the signature feature is also an anxiety source for part of the target audience; the fix is an option, not a new object
- **Conditions:** fans asking for an option — high mean; shipping the wrong shape of the feature does not close the request
- **Review IDs:** `10507135013`, `10746011966`, `13073278557`, `12700460272`, `11972917376`, `9952706862`, `9677875961`, `13657298374`, `13442141220`, `8848686558`, `10004061679`, `13329626963`, `13520796132`, `13648621463`
- **Canonical:** C121 Untimed / checklist mode as a per-routine toggle

### R05-068 — Feature requests ranked with the underlying job — full table (widgets 92; untimed mode 69; ≥3 free routines 42; undo 42; Shortcuts 37; per-task day scheduling 36; more icons/search 27; dark mode 16 — shipped ~Jan 2025; anytime routines 15; Mac/web 15; sub-routines 12 at 4.42; calendar integration 9 at 4.44; family sharing 5; Android 6)

- **Where:** Part 6 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Request | n | % | Mean | The job it serves ; Better/more widgets, Lock Screen, Live Activity, watch complication | 92 | 2.75% | 4.02 | Run the routine without opening the app ; Untimed / checklist mode | 69 | 2.06% | 4.26 | Use the app on low-energy or variable days ; ≥3 free routines | 42 | 1.26% | 4.10 | Weekday vs weekend vs sick-day variants ; Undo / back / uncheck | 42 | 1.26% | 3.52 | Recover from a misclick without restarting ; Shortcuts / auto-start / URL triggers | 37 | 1.11% | 4.08 | Remove the last manual step (opening the app) ; Per-task day/interval scheduling | 36 | 1.08% | 3.72 | "Shower every other day", "bins on Tuesday", "meds biweekly" ; More icons / icon search | 27 | 0.81% | 4.41 | Setup speed; several say icon-hunting blocks routine creation ; Dark mode | 16 | 0.48% | 4.06 | Night routines — shipped ~Jan 2025 (`12243693467` CH 5★) ; Anytime / unscheduled routines | 15 | 0.45% | 4.27 | Shift workers, nurses, flight attendants, students ; Mac / web / desktop | 15 | 0.45% | 4.13 | Build routines on a big screen; use at work ; Sub-routines / nested routines | 12 | 0.36% | 4.42 | "Shower routine" reused inside "morning routine" ; Calendar integration | 9 | 0.27% | 4.44 | Merge fixed appointments with flexible routines ; Family sharing | 5 | 0.15% | 4.20 | Blocked purchases ; Android | 6 | 0.18% | 3.67 | Cross-platform households
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12243693467`
- **Canonical:** — (nuance register)

### R05-069 — Two requests deserve outsized attention: sub-routines (12, mean 4.42 — 'shower routine' reused inside 'morning routine') and per-task day/interval scheduling (36 — 'trash to the curb only on trash day', biweekly meds, showering every other day); both address the same problem — the app forces you to duplicate an entire routine to vary one step — which is also what drives users into the 2-routine cap; fixing task-level variability would reduce cap pressure and increase value simultaneously

- **Where:** Part 6 sub-routines + task-level days
- **This app does:** routines are monolithic; no per-step schedule; no nesting
- **User reaction:** complaint
- **Magnitude:** 12 at 4.42; 36 at 3.72; 4.6× over-represented among payers
- **Direction for us:** must-have · **Report confidence:** meaningful, highest-rating askers · **Generalisable:** yes
- **Side effects:** a structural feature that relieves the monetisation wall at the same time
- **Review IDs:** `9017685503`, `13624660676`, `13942902589`, `14182637597`, `12613639721`, `9392564396`, `8795874884`, `10093805316`, `9262998416`, `12911127629`, `7734088825`, `13257733003`, `12116433368`
- **Canonical:** C043 Flexible / custom frequency; C173 Sub-tasks / sub-routines nested inside a habit or routine

### R05-070 — Smaller asks with clear jobs: anytime/unscheduled routines for shift workers, nurses, flight attendants (15, 4.27); more icons / icon search because icon-hunting blocks routine creation (27, 4.41); calendar integration to merge fixed appointments with flexible routines (9, 4.44); Mac/web to build on a big screen (15); Android for cross-platform households (6)

- **Where:** Part 6 rows: anytime routines, more icons, calendar
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 15 / 27 / 9 / 15 / 6
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C044 Mac / desktop / web app; C051 Android version

### R05-098 — Ship an untimed/checklist mode as a per-routine TOGGLE (not a separate object) — 69 reviews at 4.26 plus 15 who say the timer causes anxiety; directly addresses the 'almost' band

- **Where:** Part 9 #15
- **This app does:** checklist as separate object
- **User reaction:** complaint
- **Magnitude:** 69 + 15
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-061
- **Canonical:** C121 Untimed / checklist mode as a per-routine toggle

### R05-099 — Ship per-task day/interval scheduling and sub-routines together — 48 combined reviews at 3.72/4.42; they solve the same root problem (forced whole-routine duplication to vary one step) which is also what pushes people into the routine cap; the highest-leverage feature work in the report

- **Where:** Part 9 #16
- **This app does:** monolithic routines
- **User reaction:** complaint
- **Magnitude:** 48 combined
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-069
- **Canonical:** C043 Flexible / custom frequency; C173 Sub-tasks / sub-routines nested inside a habit or routine

### R05-100 — Deliver the widget / Lock Screen / Live Activity story properly — 92 reviews and the largest over-index in the 3–4★ band; users want to run the routine without opening the app; today the widget frequently renders blank or fails to advance

- **Where:** Part 9 #17
- **This app does:** widget blank / stuck
- **User reaction:** complaint
- **Magnitude:** 92 (2.75%)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-050
- **Review IDs:** `12811011494`, `14018416858`, `13253617539`, `11264671674`, `10696429419`, `14191150102`
- **Canonical:** C009 Basic widgets, icons and colours are free; C023 Interactive widget check-off

### R05-101 — Finish Shortcuts/auto-start — 37 reviews; several users built alarm→routine automations and then LOST them to an update; the last manual step in an app whose thesis is removing manual steps

- **Where:** Part 9 #18
- **This app does:** automation hooks regressed
- **User reaction:** complaint
- **Magnitude:** 37 (1.11%)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-052
- **Review IDs:** `12956851447`, `13186621588`
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

## Monetization

### R05-009 — The 2-routine free cap is the most-named limitation (168 reviews, 5.03%) but a CONVERSION problem, not a rating problem: 70 of the 168 are 5★, mean 3.92, only 12.5% 1–2★ — 'praise, then I just wish I could make more than two'; 'that's enough for your morning & night routine'; 42 more (1.26%, mean 4.10) ask for 3–5 free routines

- **Where:** Part 0 §5 + table
- **This app does:** free tier = 2 routines
- **User reaction:** mixed
- **Magnitude:** 168 (5.03%), mean 3.92, 12.5% 1–2★; Band | n mentioning the cap ; 5★ | 70 ; 4★ | 46 ; 3★ | 31 ; 2★ | 15 ; 1★ | 6 ; 42 (1.26%) ask for 3–5 free
- **Direction for us:** undecided · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** inference: the cap is a wall people notice but it does not convert, because two routines (morning + night) already deliver the core value — the cap gates the wrong axis
- **Conditions:** a quantity cap that lands above the point of core value produces polite wishes, not 1★; below it (report 1's 3-habit cap) it produces anger
- **Review IDs:** `11641543092`, `13503431066`, `8605738567`, `12342952953`, `13333169396`, `12641178359`, `12658956308`, `11308909258`, `13348548274`, `13863035457`, `12283384934`, `8081966389`, `6423136829`, `9059742505`, `11420765116`, `13666386966`, `7235894863`, `12613639721`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R05-012 — The model as reconstructed from reviews: free vs paywalled elements with evidence — full table

- **Where:** §1.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Element | Status | Evidence ; Create routines with unlimited steps/tasks | Free | `12470101467`, `13361043130` (AU, 5★): *"you make routines with unlimited steps and checklists"* ; Maximum 2 routines | Paywalled beyond 2 | 168 reviews, §0.5 ; Sequential timer, voice/TTS announcements, live ETA | Free | `13503431066`, `12470101467`, `11640510418` ; Full icon/emoji library | Partly paywalled | 17 reviews (0.51%): `11079201751` (US, 1★, *"one of them were freaking ICONS"*), `10203934956`, `9775758576`, `12257661729`, `13261964716` (ES, 5★) ; Analytics / statistics | Paywalled | `9189599066` (KR, 1★): *"통계가 유료서비스라니"* — *[statistics being a paid service?]*; `9264877129` (KR, 3★), `11486140970` (US, 3★) ; Custom reminder sounds, satisfaction notes | Paywalled | `11486140970` (US, 3★) ; Routine duplication, archiving | Became paywalled ~2025 | `13100664783` (KE, 4★): *"Making duplicate routine premium and then archive routines is now inconvenient"*; `13502501341` (US, 1★) ; Streak savers | Ad-gated for subscribers (2025) | `13099883499` (US, 2★): *"it won't let me use my accumulated streak savers without watching an ad? I'm a paid subscriber to the annual plan"* ; Lifetime / one-time purchase | Appears to have launched ~2026 | `13987336109` (US, 5★, Apr 2026): *"5 minutes in and I've already snagged the lifetime"*; `14216125689` (US, 5★, Jun 2026); `14375560440` (US, 5★, Aug 2026): *"I purchased it for life"*; `14365784546` (KR, 5★, Jul 2026) ; Ads | Introduced ~2023, escalated 2025 | §1.6
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R05-021 — Prices named: $2.99–$5/mo; $20–$36/yr US; ₩35,000/yr KR; £25–30/yr; €30–45/yr; ¥4,000–4,200/yr; 339 kr/yr SE; one nonsensical '$52/month' display (2021) — a likely price-display bug

- **Where:** §1.1 prices line
- **This app does:** subscription ~$20–36/yr
- **User reaction:** mixed
- **Magnitude:** prices as reported
- **Direction for us:** research · **Report confidence:** indicative · **Generalisable:** yes
- **Review IDs:** `11104661863`, `12319574416`, `9224882379`, `10800331235`, `8941948970`, `9465428819`, `13863035457`, `14239220013`, `12354215582`, `7390930425`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R05-031 — The subscription-vs-one-time debate is real but stable and mostly polite: 255 reviews (7.63%, mean 3.47) discuss the model; 46 (1.38%, mean 3.76) explicitly ask for a one-time/lifetime purchase — 'I would gladly pay a one-time fee, but don't pay for subscriptions on apps like this'; 'LIFETIME access… I'd be willing to go up to maybe $60'; requests spread evenly 2020–2026 (the demand never went away) and the 2026 lifetime reviews suggest it was finally answered — six years overdue

- **Where:** §1.5
- **This app does:** subscription until ~2026
- **User reaction:** blocked-conversion
- **Magnitude:** 255 (7.63%); 46 (1.38%) one-time asks at 3.76; by year 10/6/6/10/2/6/6
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a stated preference from people who otherwise like the app, not a churn event; willingness to pay MORE for lifetime than the typical app price
- **Review IDs:** `8984943439`, `6461798867`, `9197464713`, `12433331798`, `7590856614`, `13823849345`, `14239220013`, `11308909258`, `9465428819`, `10800331235`, `12432503704`, `13645079984`, `13987336109`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R05-043 — The free tier is generous — 68 reviews (2.03%, mean 4.54) say so with NO offsetting complaint (a deliberately conservative floor): 'Its free, unless you need a third routine'; 'the free version is sufficient and not a scam'

- **Where:** Part 3 §7
- **This app does:** 2 routines + full timer free
- **User reaction:** praise
- **Magnitude:** 68 (2.03%), mean 4.54
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11640510418`, `9914706305`, `6389137165`, `7696360486`, `13939498558`, `14349836021`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R05-048 — 'Must pay to use' perception — 130 (3.89%), mean 3.52

- **Where:** Part 4 row 6
- **This app does:** 2-routine cap read as paywall
- **User reaction:** complaint
- **Magnitude:** 130 (3.89%)
- **Direction for us:** research · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R05-091 — Stop gating on routine count; gate on capability — the cap is named by 168 reviewers of whom 116 rate 4–5★: visible, accepted, and NOT converting because morning+night satisfies the core job; move the wall to analytics/history, cross-device sync, Apple Watch, widgets, icon library, family sharing; raise the free cap to 3–4 and take the goodwill

- **Where:** Part 9 #8
- **This app does:** gates on quantity (2 routines)
- **User reaction:** mixed
- **Magnitude:** 168 named; 116 at 4–5★; 42 ask for 3–4
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 'repackage, don't reprice' — the report's clearest monetisation directive; matches Research Reports/Feature Gating vs Quantity.md
- **Conditions:** evidence: R05-009, R05-023
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R05-093 — Ship a family plan — five reviews, every one an explicitly blocked purchase, plus a parent segment rating 4.40; lowest-volume / highest-intent request in the corpus

- **Where:** Part 9 #10
- **This app does:** no family plan
- **User reaction:** blocked-conversion
- **Magnitude:** 5 (0.15%)
- **Direction for us:** research · **Report confidence:** weak count, highest intent · **Generalisable:** yes
- **Conditions:** evidence: R05-067
- **Canonical:** C037 Family plan

## Tactics the app used

### R05-044 — Developer responsiveness — 37 (1.11%, mean 4.14): the founder/CEO personally answers email ('a very thoughtful email from the CEO completely addressing my concerns'); NINE reviews are visible star-upgrades after developer contact — a strong argument for treating review replies as a retention channel

- **Where:** Part 3 §8
- **This app does:** CEO answers support email; replies to reviews
- **User reaction:** 5★-burst
- **Magnitude:** 37 (1.11%); 9 visible star-upgrades
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13641280121`, `12405974062`, `13718226517`, `12734597961`, `13661473607`, `14075143379`, `14061240049`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R05-106 — Treat review replies as the retention channel they demonstrably are (nine visible star-upgrades, 37 praising responsiveness) — but public replies are fast while email goes unanswered for months: a channel imbalance to correct, not a virtue to lean on

- **Where:** Part 9 #23
- **This app does:** fast public replies, slow email
- **User reaction:** mixed
- **Magnitude:** 9 upgrades; 37 praise; 1 damning comparison
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-044, R05-059
- **Review IDs:** `13769267096`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

## Insights (the why)

### R05-003 — The product thesis — a sequential timer that speaks the next task aloud and continuously recalculates your finish time — is the strongest and most defensible in the category; 12.90% of reviewers identify as ADHD/neurodivergent and rate it 4.47; what drags the rating is engineering reliability (50.3% of every 2★), not price or the paywall

- **Where:** Part 0 summary line
- **This app does:** sequential spoken timer with live ETA
- **User reaction:** praise
- **Magnitude:** ADHD 12.90% at 4.47; reliability in 50.3% of 2★
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C120 Sequential routine timer with spoken next step and live finish-time estimate

### R05-005 — Reliability, not money, produces 2★ and 3★: any-reliability theme in 9.4% of 5★ → 50.3% of 2★ (peaks at 2★, not 1★ — the signature of users who like the product and are frustrated); 609 reviews (18.22%) report a defect at mean 3.36; monetization 585 (17.50%) at 3.50 peaks at 1★ (37.9%) — money produces the loudest 1★s, engineering produces the volume of 2–3★s

- **Where:** Part 0 §2 + table
- **This app does:** reliable enough to love, unreliable enough to lose stars
- **User reaction:** complaint
- **Magnitude:** reliability 609 (18.22%), mean 3.36, 30.9% 1–2★; monetization 585 (17.50%), mean 3.50; Band | n | Any reliability theme ; 5★ | 2,074 | 9.4% ; 4★ | 511 | 24.1% ; 3★ | 277 | 37.2% ; 2★ | 163 | 50.3% ; 1★ | 317 | 33.4%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 2★ is the most recoverable unhappiness in the corpus
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R05-007 — 162 reviews (4.85%, very strong, mean 4.46) independently report the commercially important outcome: they stopped being late — 'I would barely make it out the door at 6:30. Now I am ready to leave at 6:00'

- **Where:** Part 0 §3 outcome
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 162 (4.85%), mean 4.46
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Side effects:** a concrete life outcome (punctuality) is the marketing claim the reviews themselves supply
- **Review IDs:** `8305228306`, `7719936293`, `11628572335`, `11994505654`, `12283999607`, `13442882939`, `14083519489`
- **Canonical:** C120 Sequential routine timer with spoken next step and live finish-time estimate

### R05-022 — 120 reviews (3.59%) contain self-reported purchase evidence; the dominant path by far: the free tier worked first and they upgraded to scale it — 'two routines for free… enough to be worthwhile but I paid for the subscription right away'; 'Bought it finally after a year of use'; 'used it well for years, so I bought the annual'; three and four years free then premium

- **Where:** §1.2 opening + #1
- **This app does:** generous free tier converts over years
- **User reaction:** purchase-driver
- **Magnitude:** 120 (3.59%); path #1
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Side effects:** conversion here is earned over years of free use, not forced at onboarding — the opposite of report 4
- **Conditions:** do not read a conversion rate from this: 3.59% is reviewers who mention paying
- **Review IDs:** `13093885049`, `8448464887`, `12444613825`, `13891754512`, `13595999311`, `12900411902`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R05-023 — Purchase path #2: needing more than two routines — the cap converts when the user has genuinely outgrown morning+night: 'the subscription has no restrictions on the quantity of routines (I have tons now)'

- **Where:** §1.2 #2
- **This app does:** 2-routine cap
- **User reaction:** purchase-driver
- **Magnitude:** 3 IDs
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11776189779`, `12899184203`, `14497138417`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R05-024 — Purchase path #3: Apple Watch capability — several Korean reviewers bought a WATCH because of this app, then subscribed: '루티너리 쓰려고 워치 샀어요' (I bought a Watch to use Routinery)

- **Where:** §1.2 #3
- **This app does:** Watch app as a hardware-driving feature
- **User reaction:** purchase-driver
- **Magnitude:** 4 IDs
- **Direction for us:** build-paid · **Report confidence:** weak, striking · **Generalisable:** yes
- **Side effects:** a Watch experience good enough to drive hardware purchases is a premium feature by definition
- **Review IDs:** `6633721289`, `7046987901`, `9607295246`, `7621728149`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R05-025 — Purchase path #4: price framed as trivially small — 'if I can build a habit for 100 won a day'; 'it's only $2/month to feel like a normal human'

- **Where:** §1.2 #4
- **This app does:** ~$2–3/mo
- **User reaction:** purchase-driver
- **Magnitude:** 2 IDs
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `6669295549`, `11392402930`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R05-026 — Purchase path #5: demonstrated outcome after a streak — a ~300-day-streak user: 'I'm paying real life human dollars for this app and it is worth every penny'

- **Where:** §1.2 #5
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 1 ID
- **Direction for us:** do · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `12625991801`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R05-027 — Confirmed payers (n=120) rate 3.48 vs 4.16, 30.0% 1–2★ vs 14.4%; over-represented among payers: refund 4.8×, gift/promo dispute 9.2×, nagging 5.2×, ads 3.9×, sync failure 3.1×, Watch defect 2.1×, data loss 2.5×, task-level day scheduling 4.6× — paying users are the ones who hit sync, watch, data-loss and advanced-scheduling limits, AND the ones being shown ads and upsells

- **Where:** §1.3 tables
- **This app does:** payers hit the limits and see the ads
- **User reaction:** churn
- **Magnitude:** | n | mean | 1–2★ | 5★ ; Confirmed payers | 120 | 3.48 | 30.0% | 41.7% ; Whole corpus | 3,342 | 4.16 | 14.4% | 62.1% ; Refund requested | 7.5% | 1.56% | 4.8× ; Gift/promo dispute | 3.3% | 0.36% | 9.2× ; Upsell/review nagging | 4.2% | 0.81% | 5.2× ; Ads complaint | 5.8% | 1.47% | 3.9× ; Sync failure | 10.0% | 3.20% | 3.1× ; Apple Watch defect | 6.7% | 3.26% | 2.1× ; Data loss | 6.7% | 2.72% | 2.5× ; Task-level day scheduling wanted | 5.0% | 1.08% | 4.6×
- **Direction for us:** must-never-break · **Report confidence:** high-priority (directional, n=120) · **Generalisable:** yes
- **Side effects:** the most commercially important finding in the report
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R05-035 — What produces 5★ (n=2,074): simple/clean/cute design 15.9%, ADHD fit 14.7%, life change 13.1%, timer+ETA 7.5%, any reliability defect (still 5★) 9.4%, any monetization 11.1%; 305 reviews (9.13%, mean 4.82, 2.0% 1–2★) are unqualified life-change endorsements — the rating engine

- **Where:** Part 2 5★ table (verbatim)
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** Theme | Share of 5★ reviews ; Simple / clean / cute design | 15.9% ; ADHD / neurodivergence fit | 14.7% ; Strong endorsement, life change | 13.1% ; Timer + live ETA | 7.5% ; Any reliability defect *(still 5★)* | 9.4% ; Any monetization theme | 11.1%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R05-036 — The 1★ band is money + total failure: any monetization 37.9%, any reliability 33.4%, subscription objection 16.4%, billing integrity 16.1%, crash/won't open 12.3%, refund 9.5%, trial charged 7.3%, confirmed payer 7.3%

- **Where:** Part 2 1★ table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | Share of 1★ ; Any monetization theme | 37.9% ; Any reliability defect | 33.4% ; Subscription objection | 16.4% ; Billing integrity (trial/charge/refund/cancel) | 16.1% ; Crash / won't open | 12.3% ; Refund demanded | 9.5% ; Trial charged immediately | 7.3% ; Confirmed payer | 7.3%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R05-037 — The recoverable band: reliability 50.3% of 2★ / 37.2% of 3★; crash 12.3%/8.3%; battery drain 9.8%/5.1%; data loss 8.0%/5.1%; Watch 6.7%/6.5%; notifications not firing 6.1%/6.1%; free routine cap 6.1%/11.2%; bad translation 4.3%/1.8%; ADHD user 8.0%/13.4% — 788 reviews (23.58%) sit in the 3–4★ band, where six themes over-index vs global: free cap (9.8% vs 5.03%), widget gaps (5.5% vs 2.75%), Watch (6.0% vs 3.26%), notifications-not-firing (4.9% vs 2.96%), bug reports (5.7% vs 3.71%), untimed-checklist requests (3.3% vs 2.06%) — 'the specific price of the missing 0.5 stars'

- **Where:** Part 2 2–3★ table (verbatim) + bold
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | 2★ | 3★ ; Any reliability defect | 50.3% | 37.2% ; Crash / won't open | 12.3% | 8.3% ; Battery drain | 9.8% | 5.1% ; Data loss | 8.0% | 5.1% ; Apple Watch defect | 6.7% | 6.5% ; Notifications not firing | 6.1% | 6.1% ; Free routine cap | 6.1% | 11.2% ; Bad translation | 4.3% | 1.8% ; ADHD user | 8.0% | 13.4%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R05-038 — Design and simplicity — 458 (13.70%, mean 4.48): minimal, clean, intuitive, cute, NOT overwhelming — for an ADHD-targeted product this is a functional claim, not an aesthetic one

- **Where:** Part 3 §1
- **This app does:** minimal, calm UI
- **User reaction:** praise
- **Magnitude:** 458 (13.70%), mean 4.48
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 'not overwhelming' is the design requirement for a neurodivergent audience
- **Review IDs:** `8357131715`, `7929555373`, `5703729632`, `7776908865`, `9080607016`, `7512377032`, `12689118359`, `12710625570`, `13116003380`
- **Canonical:** C006 Stay minimal and ad-free

### R05-039 — The ADHD mechanism reviewers name is always the same: removal of decision load, not motivation — 'This app doesn't orient itself around should but is'; 'I just need to decide to start the routine, the rest is decided'

- **Where:** Part 3 §2
- **This app does:** sequential, pre-decided routine
- **User reaction:** praise
- **Magnitude:** 431 (12.90%), mean 4.47
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** for ADHD users the product is a decision-remover, not a motivator — motivational copy and streak pressure are the wrong lever
- **Review IDs:** `12118266764`, `14371526010`
- **Canonical:** C006 Stay minimal and ad-free; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R05-040 — Life change / strong endorsement — 305 (9.13%), mean 4.82 — '人生変わった' (my life changed)

- **Where:** Part 3 §3
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 305 (9.13%), mean 4.82
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `14168412445`, `13782913025`, `12842116546`, `12490763542`, `14497946151`, `13259393688`
- **Canonical:** — (nuance register)

### R05-057 — The persistent, un-dismissable notification is a deliberate feature several users LOVE ('it doesn't let me ignore it! Hella annoying — but effective'), and when the app removed the buzzing alarm in 2026 it broke wake-ups for loyal subscribers ('They ruined it… I'm canceling after being a loyal customer for years') — the escalation ladder IS the product; it needs to be user-configurable, not silently retuned

- **Where:** §4.2 design note
- **This app does:** retuned the alarm escalation silently
- **User reaction:** 1★-burst
- **Magnitude:** 2 loving IDs; 3 2026 1–2★ from removal
- **Direction for us:** must-never-break · **Report confidence:** weak count, clear mechanism · **Generalisable:** yes
- **Side effects:** a behaviour some users depend on cannot be changed without a setting; another instance of removing something users had
- **Conditions:** pairs with the notification loop (R05-010): both extremes of the same ladder
- **Review IDs:** `13667837214`, `13166666978`, `14371016110`, `14447685280`, `14499455292`
- **Canonical:** C001 Never move a free feature behind the paywall; C123 Notification escalation must be user-configurable, never silently retuned

### R05-082 — The AI objection is new (9 reviews, 0.27%, all 2025–26) and specific: not anti-AI in general but about AI features added to a product chosen for its RESTRAINT — 'Recent AI features are disappointing, wish I could turn them off'; 'a horoscope in a routine app? terrible… looks like it's to boost engagement'; the horoscope feature launched two unskippable 30-second ads for a lifetime-premium holder

- **Where:** §8.3 AI objection
- **This app does:** added AI features and a horoscope
- **User reaction:** complaint
- **Magnitude:** 9 (0.27%), 2025–26
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Side effects:** engagement features bolted onto a minimalist tool read as betrayal; cf. report 1 (0.011% AI demand)
- **Conditions:** if AI features ship, they must be optional and off by default
- **Review IDs:** `14264972849`, `14279579894`, `14022962408`, `14049946488`
- **Canonical:** C056 Don't build AI features on demand grounds; C093 No upsell nagging without a 'never ask again' option

## Audiences

### R05-008 — ADHD is the actual user base, not a marketing angle: 431 reviews (12.90%) mention ADHD/ADD/AuDHD/autism+ADHD/executive dysfunction/time blindness at mean 4.47 vs 4.11 for everyone else, 6.0% 1–2★, 70.5% 5★; autism 14 (0.42%) at 4.64 with zero 1–2★; depression/anxiety/bipolar/OCD/PTSD/burnout 95 (2.84%) at 4.52; ADHD share grew 6.8% (2020) → 18.0% (2022) → 15.4% (2026); therapists recommend it; 'as important as medication for my ADHD'

- **Where:** Part 0 §4
- **This app does:** designed around time blindness
- **User reaction:** praise
- **Magnitude:** 431 (12.90%) at 4.47; most-voted review (42 votes) is a neurodivergent recommendation
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 'Life changing Assistive tech… no mental load at all' — positioning as assistive technology, not productivity
- **Conditions:** the 17+ age rating on a product full of 10–15-year-olds and parents is flagged (§9)
- **Review IDs:** `9655374699`, `13224248600`, `12876052388`, `13503431066`, `12384933589`, `13632583017`, `12769141712`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R05-064 — Safety: two reviews report the social tab surfaced identifiable minors (a 17-year-old girl, a 16-year-old boy) to an adult account — 'Parents please tell your children to avoid this app' — and the corpus contains many self-identified children aged 9–13 on a product rated 17+ with an opt-out-by-default public feed; 12 (0.36%) ask for the social tab to be removable ('We don't need another dumb social platform shoved down our throats')

- **Where:** §4.9
- **This app does:** public social feed on by default, mixing minors and adults; 17+ rating not enforced
- **User reaction:** 1★-burst
- **Magnitude:** 2 safety reports; ≥9 self-identified minors; 12 remove-social requests
- **Direction for us:** dont · **Report confidence:** below threshold, child-safety · **Generalisable:** yes
- **Side effects:** a social feed in a routine app is unwanted by a vocal minority and a child-safety liability; one subscriber just wants a hide option
- **Conditions:** if there is a feed it must be opt-in and age-gated; the team shipped another share option instead of fixing a known widget bug — noticed
- **Review IDs:** `13030062439`, `13866789200`, `12171510092`, `10184385950`, `12619331115`, `12922302831`, `9337913065`, `13860429738`, `12740246107`, `12476018972`, `14079774351`, `11717198512`, `13364876886`, `13373809432`, `12811011494`
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C131 No default-on social feed in a personal tool

### R05-066 — Audiences: ADHD 431 (12.90%, 4.47, 70.5% 5★); students 226 (6.76%, 4.43, heavy KR + US teens); mental-health 95 (2.84%, 4.52 — highest); parents 30 (0.90%, 4.40); autism 14 (0.42%, 4.64, zero 1–2★)

- **Where:** Part 5 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Audience | n | % | Mean | Note ; ADHD / neurodivergent / executive dysfunction | 431 | 12.90% | 4.47 | Core segment; 70.5% 5★ ; Students / school / university | 226 | 6.76% | 4.43 | Heavy KR + US teen presence ; Mental-health (depression, anxiety, bipolar, OCD, PTSD, burnout) | 95 | 2.84% | 4.52 | Highest-satisfaction cohort ; Parents managing family routines | 30 | 0.90% | 4.40 | Commercially interesting, under-served ; Autism / ASD specifically | 14 | 0.42% | 4.64 | Zero 1–2★ reviews
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R05-067 — Parents are the clearest unserved commercial segment: they ask for FAMILY SHARING (5 reviews, 0.15%) and every one is an explicitly blocked purchase — 'my kids could benefit but I can't afford the full price for all of us'; 'no family sharing, so I gave up on paying'; parent outcomes are strong: 'As a mom with ADHD trying to get kids with ADHD out the door… a life saver'; 'It was not uncommon for me to leave the house in tears'

- **Where:** Part 5 parents
- **This app does:** no family plan
- **User reaction:** blocked-conversion
- **Magnitude:** 5 (0.15%), mean 4.20 — 'the highest intent quality in the corpus'; parent outcomes 6 IDs
- **Direction for us:** research · **Report confidence:** weak count, highest intent · **Generalisable:** yes
- **Side effects:** a family plan is money left on the table from the happiest cohort
- **Review IDs:** `11745385532`, `9400943406`, `9830120067`, `9907503193`, `7985033621`, `13624963931`, `11628572335`, `12598922221`, `14087664268`, `12915068929`, `13121738980`
- **Canonical:** C037 Family plan; C068 Parents tracking kids

## Markets and languages

### R05-032 — Price objection proper is small (19, 0.57%, mean 2.74), concentrated in KR, IN, GB, with one explicit purchasing-power argument: 'India is a poor country and you charge us more for a subscription than those in the USA'

- **Where:** §1.5 price objection
- **This app does:** higher price in India than the US
- **User reaction:** complaint
- **Magnitude:** 19 (0.57%), mean 2.74
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `8911150255`
- **Canonical:** C092 Regional pricing

### R05-054 — China: the app will not open at all at the storefront level — 23 reviews (0.69%), mean 2.52, 56.5% 1–2★

- **Where:** Part 4 row 29
- **This app does:** broken in CN
- **User reaction:** 1★-burst
- **Magnitude:** 23 (0.69%)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** app-specific
- **Conditions:** see §7.5
- **Canonical:** C132 Do not sell in a storefront where the app cannot function

### R05-060 — Localisation: 26 translation-QUALITY complaints (0.78%, mean 2.73, 50% 1–2★) — unusually harsh: 'idiot-German produced by some algorithm'; 'my eyes are bleeding'; 'a good app ruined'; even the ENGLISH copy is broken ('routines reduce your energy about what to do when'; 'give any English speaker $20 and they could finish the job in 20 minutes') — plus 16 missing-language requests (BR-PT 7, Chinese 3+, Russian 2, Arabic, TW, IT, TR); the listing says English-only while the app ships machine-translated DE/FR/PT/JA/KO, push notifications arrive in Chinese, and a German user sees German, Dutch and English mixed — the worst of both worlds

- **Where:** §4.5
- **This app does:** machine-translated UI in several languages; English copy itself poor
- **User reaction:** 1★-burst
- **Magnitude:** 26 (0.78%), mean 2.73; 16 (0.48%) missing-language
- **Direction for us:** do · **Report confidence:** emerging, harsh tone · **Generalisable:** yes
- **Side effects:** bad translation rates a full star lower than missing translation; a non-native English base copy compounds it
- **Conditions:** ship a language properly or not at all; get the source-language copy right first
- **Review IDs:** `9814965554`, `12869846755`, `10515742946`, `9070949448`, `7566936697`, `13898345640`, `11659281945`, `10865092345`
- **Canonical:** C027 Localise early — it unlocks revenue

### R05-072 — The nine eligible storefronts: n, mean, 1–2★, 5★ and 14 theme rates — full table

- **Where:** §7.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** CC | n | Mean | 1–2★ | 5★ | Cap | Sub-obj | Crash | Watch | Battery | Notif-none | Data loss | ADHD | Timer | Life-chg | Support | Sync | Paid ; US | 1,354 | 4.22 | 12.5% | 64.6% | 6.6% | 7.9% | 3.2% | 1.6% | 1.7% | 3.2% | 1.6% | 20.8% | 9.5% | 12.6% | 4.1% | 1.9% | 2.9% ; KR | 637 | 4.18 | 14.6% | 63.9% | 2.5% | 12.7% | 6.9% | 7.4% | 1.6% | 4.7% | 2.5% | 0.8% | 5.7% | 3.1% | 6.5%† | 6.1% | 6.9% ; JP | 221 | 3.77 | 21.3% | 44.8% | 1.8% | 0.0% | 3.2% | 5.0% | 4.1% | 3.6% | 9.0% | 19.0% | 12.7% | 8.1% | 0.9% | 6.3% | 5.0% ; GB | 186 | 4.16 | 14.0% | 60.2% | 7.0% | 6.5% | 4.8% | 2.2% | 1.6% | 1.6% | 0.5% | 10.8% | 8.6% | 11.3% | 6.5% | 2.7% | 1.1% ; CA | 153 | 4.20 | 12.4% | 58.2% | 5.2% | 6.5% | 2.0% | 3.3% | 4.6% | 2.6% | 1.3% | 20.9% | 9.8% | 8.5% | 4.6% | 2.6% | 2.6% ; AU | 98 | 4.49 | 7.1% | 72.4% | 9.2% | 6.1% | 2.0% | 2.0% | 0.0% | 2.0% | 0.0% | 15.3% | 10.2% | 18.4% | 4.1% | 3.1% | 2.0% ; DE | 68 | 3.84 | 23.5% | 48.5% | 8.8% | 8.8% | 7.4% | 2.9% | 4.4% | 0.0% | 4.4% | 2.9% | 5.9% | 5.9% | 1.5% | 5.9% | 2.9% ; FR | 67 | 4.18 | 13.4% | 64.2% | 3.0% | 6.0% | 1.5% | 4.5% | 0.0% | 3.0% | 0.0% | 11.9% | 10.4% | 4.5% | 0.0% | 1.5% | 3.0% ; MX | 56 | 4.39 | 12.5% | 71.4% | 3.6% | 3.6% | 3.6% | 1.8% | 3.6% | 0.0% | 0.0% | 3.6% | 8.9% | 1.8% | 0.0% | 0.0% | 0.0%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R05-073 — Korea is not a review market, it is an unstaffed support desk: 19.06% of the corpus but 62.6% of all billing-integrity complaints (57 of 91) because Korean users post refund and cancellation requests directly into the App Store review — often while rating 5★; 'I was charged by mistake and looked everywhere for where to ask, but there's no way to find it' — an in-app, Korean-language, self-service cancel/refund path would remove the majority of Korea's negative reviews at a stroke; Korea is also the lead-user market (deepest Watch/sync/crash feedback, most detailed feature specs) and should be the beta cohort

- **Where:** §7.2
- **This app does:** no in-app support/refund path; KR users use reviews as tickets
- **User reaction:** 1★-burst
- **Magnitude:** KR 637 reviews (19.06%); 57/91 billing complaints; 9 refund-request-at-5★ IDs
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a channel artifact: KR billing numbers overstate KR-specific defects and understate them elsewhere — disclosed
- **Conditions:** the home market of a non-US developer can behave as its support channel; treat it as the beta cohort
- **Review IDs:** `11462945038`, `11729876017`, `11850519257`, `11940731530`, `13449732100`, `13548970666`, `11360391292`, `10174413491`, `8102214925`, `10940540257`, `13449391599`, `9712944707`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C112 In-app cancellation; C130 Use the lead-user market as the beta cohort

### R05-074 — Japan is the worst eligible storefront (3.77, 21.3% 1–2★) despite the highest ADHD-identification rate outside North America (19.0%) and strong timer praise — the gap is entirely engineering and language: data loss 9.0% (3.3× global), battery 4.1%, translation 3.6% (4.6×), Watch 5.0%; Japanese reviewers write the longest, most technically precise defect reports (a five-revision running log of regressions) — 'Japan is telling you exactly what is broken and rating you accordingly'

- **Where:** §7.3 Japan
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** JP n=221, mean 3.77; data loss 9.0%, translation 3.6%
- **Direction for us:** must-never-break · **Report confidence:** high-priority (in-market) · **Generalisable:** yes
- **Review IDs:** `13323018578`, `12925478996`
- **Canonical:** C027 Localise early — it unlocks revenue; C034 Data must never be lost on update, reinstall or phone change

### R05-075 — Germany has the highest 1–2★ rate of any eligible market (23.5%, mean 3.84): crashes 7.4% (highest), translation 7.4% (9.5× global), subscription objection 8.8%, cap 8.8% — and a cheap, sharp, six-year-old locale gripe: no 24-hour time format, week starting Sunday, unchangeable date format (2020 → still unfixed Feb 2026)

- **Where:** §7.3 Germany
- **This app does:** no 24h clock, Sunday week start, fixed date format
- **User reaction:** complaint
- **Magnitude:** DE n=68, 1–2★ 23.5%; locale gripe 2020–2026
- **Direction for us:** do · **Report confidence:** meaningful (in-market) · **Generalisable:** yes
- **Side effects:** the same EU locale asks as report 1 (week-start, date format); six years is the cost of ignoring them
- **Review IDs:** `6799961112`, `13799067782`
- **Canonical:** C027 Localise early — it unlocks revenue

### R05-076 — Australia (4.49, 7.1% 1–2★, 72.4% 5★, life-change 18.4% — 2× global) and Mexico (4.39, 71.4% 5★, essentially zero reliability complaints) are the healthy markets — and AU ALSO has the highest cap-mention rate (9.2%): further proof that naming the cap is not the same as churning over it

- **Where:** §7.4
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** AU n=98; MX n=56
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8810965416`, `12459764181`, `13763004001`
- **Canonical:** — (nuance register)

### R05-077 — China: the app does not work at the storefront level — 23 reviews (0.69%) report it will not open, register, or shows a network error, continuously Aug 2021 → Jan 2026; CN mean 2.77, 46.7% 1–2★ on 30 reviews; a backend/auth endpoint unreachable from the mainland — and 'paid and it's completely unusable, always shows no network': the app is taking money in a market where it cannot function; enter properly or withdraw

- **Where:** §7.5
- **This app does:** backend unreachable from mainland China; still sold there
- **User reaction:** 1★-burst
- **Magnitude:** 23 (0.69%); CN 30 reviews at 2.77
- **Direction for us:** dont · **Report confidence:** limited evidence, seven-year single-cause pattern · **Generalisable:** yes
- **Side effects:** selling in a storefront where the app cannot connect is a billing-integrity issue as well as a reliability one
- **Review IDs:** `7716753605`, `9542524738`, `9642437584`, `9708023091`, `10359901346`, `11157656351`, `11607673178`, `11810774152`, `12541720254`, `12661622269`, `12748667037`, `12966673910`, `13128697638`, `13216388903`, `9567925230`
- **Canonical:** C132 Do not sell in a storefront where the app cannot function

### R05-105 — Decide about China — seven years of 'the app will not open', plus at least one user charged where the product does not function; fix endpoint reachability and localise, or geo-restrict the storefront

- **Where:** Part 9 #22
- **This app does:** sold where it cannot connect
- **User reaction:** 1★-burst
- **Magnitude:** 23 (0.69%)
- **Direction for us:** dont · **Report confidence:** limited evidence, coherent · **Generalisable:** yes
- **Conditions:** evidence: R05-077
- **Canonical:** C132 Do not sell in a storefront where the app cannot function

## Dated events and trends

### R05-010 — Three dated engineering incidents: a launch-failure crisis in 2023 Q2 (17.0% of that quarter's reviews, quarter mean 3.25 — worst in corpus); a screen-flicker outage on 2–3 Jul 2025 (13 reviews in ~48 hours, identical symptom across five languages — 7 of 13 still rated 5★ while reporting a total outage); a notification-loop regression 2–30 May 2026 (12 of 33 lifetime notification-spam reviews in four weeks, 8.4% of 2026 Q2) — 'sending notifications every two seconds for a routine I have finished… I deleted the routine and it kept sending them'

- **Where:** Part 0 §6 + table
- **This app does:** three shipped regressions, one still open
- **User reaction:** 1★-burst
- **Magnitude:** Incident | Window | Evidence ; Launch-failure crisis | 2023 Q2 | 18 of 106 reviews that quarter (17.0%) report the app won't open; quarter mean fell to 3.25, the worst in the corpus (vs 3.83 the prior quarter) ; Screen-flicker outage | 2–3 Jul 2025 | 13 reviews in ~48 hours across CZ/KR/JP/US/AU, all describing the same strobing/blinking launch screen ; Notification loop regression | 2 – 30 May 2026 | 12 of the 33 lifetime notification-spam reviews land in a 4-week window; 8.4% of all 2026 Q2 reviews
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the goodwill in this user base is extraordinary (5★ during an outage) and should not be spent casually; a notification loop punishes exactly the trait the app sells to
- **Conditions:** release-day review clusters are clean forensic evidence of a regression
- **Review IDs:** `12845169896`, `12845170672`, `12845182717`, `12845201048`, `12845212130`, `12845278815`, `12845293413`, `12845331141`, `12845383837`, `12845433586`, `12845443933`, `12845461318`, `12845938596`, `14026780569`, `14025543075`, `14027904982`, `14020050534`, `14026381495`, `14031389102`, `14039388760`, `14039999029`, `14040436929`, `14061240049`, `14073080620`, `14124723476`, `14028544588`
- **Canonical:** C031 Crashes / launch failures; C039 Reminders fire reliably, once

### R05-011 — Apple Watch is a FIXED problem — the proof this team can fix things: Watch defect reports fell from 8.8% of 2021 reviews and 7.7% of 2022 to 0.2% in 2026; for two years it was the single most-cited defect, now 'seamlessly functional between phone and watch'

- **Where:** Part 0 §7 + table
- **This app does:** fixed the Watch app over 2023–2025
- **User reaction:** praise
- **Magnitude:** Year | Watch defect reports | % of year ; 2020 | 7 | 4.0% ; 2021 | 28 | 8.8% ; 2022 | 32 | 7.7% ; 2023 | 19 | 3.8% ; 2024 | 13 | 2.9% ; 2025 | 9 | 0.9% ; 2026 | 1 | 0.2%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the same discipline applied to notifications and launch reliability would move the rating
- **Review IDs:** `7040840149`, `7088596981`, `8728078244`, `9272132912`, `9439258779`, `9886812490`, `10179113941`, `11760598486`, `13259002296`, `14408847759`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C059 Be visibly responsive; fixes bring reviewers back

### R05-020 — A lifetime / one-time purchase appears to have launched ~2026 — '5 minutes in and I've already snagged the lifetime' (Apr 2026); 'I purchased it for life' (Aug 2026)

- **Where:** §1.1 row 9
- **This app does:** shipped lifetime SKU in 2026
- **User reaction:** purchase-driver
- **Magnitude:** 4 IDs Apr–Aug 2026
- **Direction for us:** product-rule · **Report confidence:** weak count, clear signal · **Generalisable:** yes
- **Side effects:** the corpus says lifetime was six years overdue (§1.5) and converted within five minutes of being seen
- **Review IDs:** `13987336109`, `14216125689`, `14375560440`, `14365784546`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R05-071 — Dark mode requested by 16 (0.48%) for night routines — shipped ~Jan 2025

- **Where:** Part 6 row dark mode
- **This app does:** shipped dark mode Jan 2025
- **User reaction:** praise
- **Magnitude:** 16 (0.48%)
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12243693467`
- **Canonical:** C080 Colour themes / dark mode

### R05-079 — Reviews by year 2019–2026 with mean, 1–2★, 5★ — the story is a V: quality degraded from 2020 (4.45) to a floor in 2023 (3.76; 2023 Q2 at 3.25), then recovered and held ~4.2 for three years; volume more than doubled in 2025 (review prompt and/or Forbes/App-of-the-Day exposure)

- **Where:** §8.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | Mean | 1–2★ | 5★ ; 2019 | 3 | 5.00 | 0.0% | 100% ; 2020 | 176 | 4.45 | 6.2% | 69.9% ; 2021 | 317 | 4.29 | 9.5% | 65.9% ; 2022 | 416 | 4.08 | 14.2% | 56.0% ; 2023 | 500 | 3.76 | 23.4% | 48.0% ; 2024 | 442 | 4.17 | 14.5% | 64.0% ; 2025 | 980 | 4.22 | 13.3% | 65.1% ; 2026 (to 6 Sep) | 508 | 4.26 | 13.6% | 67.9%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Side effects:** a recovery from a 3.25 quarter to a stable 4.2 is achievable — reliability work shows in rating
- **Canonical:** — (nuance register)

### R05-080 — Themes that genuinely improved: Watch defects 8.8% → 0.2% (solved); crash 7.9% → 2.0%; subscription objection 12.5% → 5.9% (halved — the free tier is doing its job); free-cap complaints 7.3% → 4.1%; refund requests 3.4% → 0.6%; dark mode requests 2.2% → 0.2% (shipped); bad translation 2.0% → 0.2% (improved, not fixed)

- **Where:** §8.2 table (verbatim)
- **This app does:** fixed Watch, crashes, dark mode; softened cap and refunds
- **User reaction:** praise
- **Magnitude:** Theme | Peak | Now (2026) | Read ; Apple Watch defects | 8.8% (2021) | 0.2% | Solved ; Crash / won't open | 7.9% (2021), 7.2% (2023) | 2.0% | Largely solved ; Subscription objection | 12.5% (2020) | 5.9% | Halved — free tier is doing its job ; Free-cap complaints | 7.3% (2021) | 4.1% | Softened ; Refund requests | 3.4% (2024) | 0.6% | Sharply down ; Dark mode requests | 2.2% (2022) | 0.2% | Shipped Jan 2025 ; Bad translation | 2.0% (2023) | 0.2% | Improved, not fixed
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a generous free tier halves subscription objections over time
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C022 Apple Watch app (done properly: timer, two-way sync)

### R05-081 — Themes that worsened or emerged: notification loop ~0% → 3.7% (new regression, currently the top defect); widget gaps 2.4% → 3.9% (shipped but under-deliver); ads 0.6% → 1.6% (peak 2.6% 2025); AI-features objection 0% → 1.0% (new); social tab objection new; battery fixed once, regressed twice

- **Where:** §8.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | Then | 2026 | Read ; Notification loop / spam | ~0% pre-2025 | 3.7% | New regression, currently the top defect ; Widget gaps | 2.4% (2022) | 3.9% | Growing — widgets shipped but under-deliver ; Ads | 0.6% (2022) | 1.6% (peaked 2.6% in 2025 Q2/Q3) | Introduced and escalating ; AI features objection | 0% pre-2025 | 1.0% | New ; Social tab objection | 0% pre-2023 | 0.2% | New, low volume, safety-adjacent ; Battery drain | 1.1% (2021) | 1.0% (peaked 4.4% in 2023) | Fixed once, regressed twice
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C175 Updates must not break function or wipe progress

### R05-083 — The persistent five, unfixed across the life of the app: no undo / accidental done (Jan 2020 → Feb 2026); icon skin-tone diversity (Jun 2020 → Jun 2026); 24-hour clock / week-start / date format (Dec 2020 → Feb 2026); untimed checklist mode (Nov 2020 → Jan 2026); routine start-order / reordering bugs (Jan 2020 → Nov 2025)

- **Where:** §8.4 table (verbatim)
- **This app does:** five six-year-old open items
- **User reaction:** complaint
- **Magnitude:** Theme | First reported | Still reported ; No undo / accidental "done" | `5432864399` (KR, Jan 2020) | `13702441710` (US, Feb 2026) ; Icon skin-tone diversity | `6063452130` (US, Jun 2020) | `14221471353` (US, Jun 2026, 1★) ; 24-hour clock / week-start / date format | `6799961112` (DE, Dec 2020) | `13799067782` (CH, Feb 2026) ; Untimed / checklist-only mode | `6661289869` (PH, Nov 2020) | `13657298374` (KR, Jan 2026) ; Routine start-order / reordering bugs | `5415561492` (KR, Jan 2020) | `13433400135` (KR, Nov 2025)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** small, cheap items left open for six years accumulate into a rating ceiling
- **Review IDs:** `5432864399`, `13702441710`, `6063452130`, `14221471353`, `6799961112`, `13799067782`, `6661289869`, `13657298374`, `5415561492`, `13433400135`
- **Canonical:** C002 Ratings follow the offer, not the feature set

## Positioning

### R05-001 — Routinery is a Korean-built sequential routine timer (speaks the next task aloud, recalculates finish time) with a 4.72 US store rating on 17,825 ratings, 6,710 KR ratings at 4.74, English-only listing, 17+ age rating, and marketing claims of '2026 App of the Day', 'Best ADHD App by Forbes Health 2025', '5 million users'

- **Where:** header line 3-6
- **This app does:** developer Routinery Corp., bundle com.alt.goodmorning; KR listing 갓생 루틴 루티너리; voice/TTS-guided timers, plant-badge streaks, widgets, watch; v3.29.36 (5 Sep 2026)
- **User reaction:** praise
- **Magnitude:** 3,342 reviews, 86 storefronts, Apr 2019 → Sep 2026; JP 3,342 ratings at 4.62, GB 2,111 at 4.64
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Conditions:** a routine-timer app, not a checklist — the timer is the product
- **Canonical:** — (nuance register)

## Anti-patterns

### R05-018 — Routine duplication and archiving became paywalled ~2025 — 'Making duplicate routine premium and then archive routines is now inconvenient'

- **Where:** §1.1 row 7
- **This app does:** re-paywalled duplicate/archive in 2025
- **User reaction:** complaint
- **Magnitude:** 2 IDs
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Side effects:** another instance of moving a free capability behind the paywall
- **Review IDs:** `13100664783`, `13502501341`
- **Canonical:** C001 Never move a free feature behind the paywall

### R05-019 — Streak savers became ad-gated even for subscribers in 2025 — 'it won't let me use my accumulated streak savers without watching an ad? I'm a paid subscriber to the annual plan'

- **Where:** §1.1 row 8
- **This app does:** ads gate a feature for payers
- **User reaction:** 1★-burst
- **Magnitude:** 1 ID (2★)
- **Direction for us:** dont · **Report confidence:** single review, severe · **Generalisable:** yes
- **Review IDs:** `13099883499`
- **Canonical:** C001 Never move a free feature behind the paywall; C127 Never show ads to paying subscribers

### R05-028 — A subscriber who is shown an ad churns loudly: 'multiple back-to-back, full-screen unskippable, LONG brainrot ads before you can proceed. Even as a paying subscriber'; 'even on the premium version I am bombarded with ads'; a lifetime buyer still got banner ads (later fixed); an annual subscriber gets a full-screen 'change plan' pop-up on every open because prices went up

- **Where:** §1.3 quotes
- **This app does:** ads and upsells shown to payers
- **User reaction:** 1★-burst
- **Magnitude:** 4 quoted IDs; ads 5.8% of payers
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** ads to payers is the most reliable way to turn an advocate into a 1★
- **Review IDs:** `14021959851`, `13382239088`, `14049946488`, `13726548501`
- **Canonical:** C127 Never show ads to paying subscribers

### R05-030 — The 1+1 gift-code promo is a distinct self-inflicted wound: users bought 'buy one year, get one year', then found the second code could not be used by themselves and expired in 3 months — the restriction was in light-grey fine print on white (39-vote review); one received 1 month instead of 12; still unresolved Mar 2026

- **Where:** §1.4 1+1 promo
- **This app does:** promo whose terms contradict its name
- **User reaction:** 1★-burst
- **Magnitude:** 12 (0.36%), mean 3.75; 9.2× over-represented among payers
- **Direction for us:** dont · **Report confidence:** weak count, clear mechanism · **Generalisable:** yes
- **Side effects:** a promo that reads one way and works another is a billing-integrity complaint, not a marketing one
- **Review IDs:** `8142666759`, `9512372663`, `12273106669`, `6913284885`, `8195028670`, `9530513755`, `9557023526`, `13901606439`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised

### R05-033 — Ads were introduced ~2023 and escalated in 2025 (2→3→2→9→6→19→8 complaints by year; 49 total, 1.47%, mean 3.41): '45 seconds of ads… I even recommended this to people, now I have to go apologise'; 'the ad section is bigger than the routine section now'; and from a 5★ user: 'the addition of in app ads lately has been really annoying. I think limiting us to two routines is fine enough' — the cap is accepted; the ads are not

- **Where:** §1.6
- **This app does:** added ads to a previously ad-free app, escalated them
- **User reaction:** complaint
- **Magnitude:** 49 (1.47%), mean 3.41, 32.7% 1–2★; 19 in 2025
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** the whole trade-off in one sentence from a five-star user: users tolerate a quantity cap and reject ads
- **Conditions:** adding ads to an established ad-free app is a form of re-paywalling
- **Review IDs:** `12961330080`, `13032976287`, `13186195934`, `13502501341`, `13551456063`, `10598751597`
- **Canonical:** C001 Never move a free feature behind the paywall; C082 Ads in the free tier

### R05-034 — Review-prompt and upsell nagging — 27 reviews (0.81%, mean 3.52) — fires on routine completion, the app's highest-frequency event, so it feels like harassment: 'after every routine the app asks me to review it'; 'they continue even after I say no'; 'even on the paid subscription it opens the App Store without asking… I'm looking for another app'; several reviewers say they only reviewed to make it stop

- **Where:** §1.7
- **This app does:** review prompt on every routine completion, even for payers
- **User reaction:** complaint
- **Magnitude:** 27 (0.81%), mean 3.52
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Side effects:** prompting at the highest-frequency event inflates review volume and makes the corpus MORE representative of daily users — a selection-bias caveat
- **Conditions:** fire the prompt on a milestone, not on every completion; never on payers who said no
- **Review IDs:** `12140481975`, `12152542435`, `14390918053`, `12809291422`, `11693253776`, `13814479381`, `14037700755`, `12863665218`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

## Things not to do

### R05-096 — Retire or fully honour the 1+1 gift promo — twelve reviews, six years, still generating disputes in 2026; the fine print is the problem

- **Where:** Part 9 #13
- **This app does:** misleading promo
- **User reaction:** 1★-burst
- **Magnitude:** 12 (0.36%)
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R05-030
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised

### R05-097 — Move the review prompt off routine-completion — it fires at the highest-frequency event and generates 1★s from people who already reviewed

- **Where:** Part 9 #14
- **This app does:** prompt on every completion
- **User reaction:** complaint
- **Magnitude:** 27 (0.81%)
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** evidence: R05-034
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R05-104 — Make the social feed opt-in, hideable and adult-only — or remove it; two credible reports of minors surfaced to adult accounts on a 17+ app full of self-identified 9–13-year-olds; the one finding with regulatory as well as product risk

- **Where:** Part 9 #21
- **This app does:** public feed default-on with minors
- **User reaction:** 1★-burst
- **Magnitude:** 2 reports + ≥9 self-identified minors
- **Direction for us:** dont · **Report confidence:** child-safety · **Generalisable:** yes
- **Conditions:** evidence: R05-064
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C131 No default-on social feed in a personal tool

## Things to do

### R05-065 — Icon representation — 'the ones showing people shouldn't all be white. Representation matters' (2020) — raised four times over six years, never fixed; by 2026 a 1★: 'Pale skin is default for emojis… My review will remain 1 star until I see some sort of remedy'

- **Where:** §4.10
- **This app does:** pale-skin default for people icons
- **User reaction:** complaint
- **Magnitude:** 4 reviews 2020–2026
- **Direction for us:** do · **Report confidence:** weak, zero-ambiguity · **Generalisable:** yes
- **Side effects:** a zero-ambiguity, low-cost fix ignored for the life of the app; cf. report 1's missing Islamic icons
- **Review IDs:** `6063452130`, `9323411983`, `13658574051`, `14221471353`
- **Canonical:** C028 Culturally complete icon set and calendars

### R05-102 — Human-translate the UI, or ship English-only honestly — translation complaints average 2.73 stars; priority DE, JA, PT-BR, FR; and fix the DE/CH locale basics: 24-hour clock, Monday week start, system date format — six years old, cheap, disproportionately punished

- **Where:** Part 9 #19
- **This app does:** machine translation; no locale settings
- **User reaction:** 1★-burst
- **Magnitude:** 26 at 2.73; locale gripe 2020–2026
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R05-060, R05-075
- **Canonical:** C027 Localise early — it unlocks revenue

### R05-103 — Add icon skin-tone variants — four reviews over six years, one a standing 1★; cheap; no defensible reason it is still open

- **Where:** Part 9 #20
- **This app does:** pale-skin default icons
- **User reaction:** complaint
- **Magnitude:** 4
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R05-065
- **Canonical:** C028 Culturally complete icon set and calendars

## Contradictions

### R05-109 — The app's two signature behaviours are each loved and hated by different parts of the same audience: the persistent un-dismissable alarm ('Hella annoying — but effective' vs 'They ruined it' when removed) and the mandatory timer (the life-changing ETA vs 'severe anxiety… I just want the reminder, not the count down') — in both cases the resolution is a per-routine setting, not a global choice

- **Where:** §4.2 + §4.6 (timer/notification as both asset and liability)
- **This app does:** global defaults for alarm escalation and timer
- **User reaction:** mixed
- **Magnitude:** timer praise 277 (8.29%) vs untimed-mode asks 69 + 15 anxiety; alarm lovers 2 vs removal complaints 3
- **Direction for us:** must-have · **Report confidence:** clear mechanism · **Generalisable:** yes
- **Conditions:** a neurodivergent audience is heterogeneous — options beat retuning
- **Review IDs:** `13667837214`, `14371016110`, `13073278557`, `10507135013`
- **Canonical:** C121 Untimed / checklist mode as a per-routine toggle; C123 Notification escalation must be user-configurable, never silently retuned

### R05-110 — A quantity cap of 2 routines here draws polite wishes (mean 3.92, 70 of 168 at 5★) while report 4's task cap of 4–7 reversed a two-year recovery and report 1's 3-habit cap was the #1 complaint — the difference is whether the cap sits ABOVE the point of core value (morning + night is enough here) and whether it was there from the start or imposed on tenured users

- **Where:** §0.5 vs report 4 Part 0 §5 vs report 1 §1.2
- **This app does:** 2-routine cap from the start
- **User reaction:** mixed
- **Magnitude:** here 12.5% 1–2★ among cap mentions; report 4: 4.29 → 3.61 quarter; report 1: 296 complaints, ×7.5 on 2★
- **Direction for us:** undecided · **Report confidence:** cross-report · **Generalisable:** yes
- **Conditions:** a cap is tolerated when it is original, generous relative to the core job, and gates quantity the user does not need — and it still does not convert
- **Review IDs:** `11641543092`, `13503431066`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

## Data caveats and method

### R05-002 — Method: bands against all 3,342 and separately against each of 9 storefronts with ≥50 reviews (2,840, 85.0%); 77 storefronts hold 502 (15.0%, mean 4.06, 17.3% 1–2★); one review = 0.030%; non-exclusive themes

- **Where:** How to read this
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 9 eligible storefronts
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R05-004 — The written corpus is NOT much angrier than the tap rating (4.16 vs 4.72, a 0.56 gap — small for this category): negative reviews are specific defect reports from people who still want the app to work, not refugees from a predatory funnel — so fixing defects converts directly into rating

- **Where:** Part 0 §1 + table
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | Value ; App Store rating (US, all ratings incl. tap-only) | 4.72 (17,825 ratings) ; Mean of all 3,342 written reviews | 4.16 ; 5★ share of written reviews | 62.06% (2,074) ; 4★ share | 15.29% (511) ; 3★ share | 8.29% (277) ; 2★ share | 4.88% (163) ; 1★ share | 9.49% (317)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the tap-vs-written gap is a diagnostic: large gap = funnel anger, small gap = defect reports
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R05-078 — 77 storefronts under 50 reviews hold 502 (15.0%, mean 4.06, 17.3% 1–2★); no standalone claims except disclosed exceptions: the CN cluster, the NL sync-deletes-data report, SE/TH/PL Watch reports, single-review language requests

- **Where:** §7.6
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 502 (15.0%)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R05-107 — Open questions: is the trial→immediate-charge a billing defect or a plan-selection UX failure; does raising the free cap to 3–4 raise or lower paid conversion; what share of 5★ users would pay for family sharing; did the 2026 lifetime plan cannibalise subscriptions or expand the payer base (only three reviews mention it)

- **Where:** Part 9 research questions
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 4 research questions
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R05-108 — Method per the appendix: 3,342 records, full reconciliation, hand-validated multilingual themes across KR/JP/DE/FR/ES/PT/NL and others; payer cohort n=120 is a segment rate; KR billing figures are a channel artifact; CN and single-review language findings flagged limited evidence

- **Where:** Part 10 method and limitations (skimmed)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 3,342 reviews; 86 storefronts; 9 eligible
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)
