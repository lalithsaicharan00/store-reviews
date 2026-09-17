# Cards — report 48

Source: `App Store Reports/48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist (REPORT).md`  
106 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 6
- [Must-haves](#must-haves) — 5
- [Must never break](#must-never-break) — 9
- [Features](#features) — 5
- [Monetization](#monetization) — 10
- [Tactics the app used](#tactics-the-app-used) — 3
- [Insights (the why)](#insights-the-why) — 23
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 12
- [Dated events and trends](#dated-events-and-trends) — 7
- [Positioning](#positioning) — 3
- [Anti-patterns](#anti-patterns) — 4
- [Things not to do](#things-not-to-do) — 2
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 13

## Product rules

### R48-024 — Ads: none in any era — 33 reviews praise the absence of ads and zero complain about ads; two reviewers propose ads instead of the paywall — 'a deliberate and well-received position'

- **Where:** §2.2 ads
- **This app does:** no ads ever
- **User reaction:** praised; some would take ads over a cap
- **Magnitude:** 33 praise; 0 complaints
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `8005170579`, `7555174284`
- **Canonical:** C082 Ads in the free tier; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R48-088 — Never reduce an existing user's free capacity again, and restore slots freed by deletion: 23 reviews (mean 2.22★) describe deleting a tracker and finding the slot gone, or the cap shrinking under a history already built — retroactive punishment landing on the longest-tenured users

- **Where:** Part 8 #2 — §8.1 fix 2 never reduce free capacity
- **This app does:** cap shrank under existing users; deleted slot not returned
- **User reaction:** retroactive punishment
- **Magnitude:** 23 (2.22★)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C191 Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled; C219 A free cap must be concurrent, never lifetime — deleting a habit frees a slot

### R48-092 — Raise the free tier to the point where the differentiator is demonstrable: the moat is multi-type tracking across several goals (485) and a 3-tracker tier cannot show it — 211 say so, the theme is the only growing negative (12.1% of the last 24 months), 43 state an intent to pay the current terms defeat; the corpus does not prove the right number but the 2015–18 era with a large free tier produced the highest ratings (4.62★), the most free-tier gratitude (7.82%) and a growing payer base

- **Where:** Part 8 #6 — §8.2 change 6 raise the free tier
- **This app does:** 3-tracker free tier too small to show a multi-goal product
- **User reaction:** cannot evaluate; would pay after trying
- **Magnitude:** 211; 43 willing
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C147 Let people use the product before they pay

### R48-095 — Treat log-entry friction as sacred: the 2021 history redesign cost ten reviews in three months from long-tenured paying users and its reversal was welcomed by name; simplicity of logging is praised in 817 reviews — 'the product's most load-bearing quality'

- **Where:** Part 8 #9 — §8.2 change 9 log-entry friction is sacred
- **This app does:** one-tap logging
- **User reaction:** n/a
- **Magnitude:** 817 praise; 10 complaints in the redesign window
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `7521539649`, `7540012549`
- **Canonical:** C159 Launch-to-core-action path with no interstitials; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R48-097 — Do not add ads: 33 praise their absence, zero complain; two reviewers proposing ads over paywalls 'is not endorsement of ads, it is hostility to the cap'

- **Where:** §8.3 do not add ads
- **This app does:** no ads
- **User reaction:** praised
- **Magnitude:** 33 vs 0
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C082 Ads in the free tier; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R48-098 — Do not simplify away the four tracker types — the single most-cited reason people choose it over rivals (485) and why benchmarking reviewers return (453)

- **Where:** §8.3 do not simplify away the tracker types
- **This app does:** four tracker types
- **User reaction:** n/a
- **Magnitude:** 485 + 453
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C265 Tracker types beyond yes/no — numeric target, rolling average and project milestones — as the reason people switch from binary habit apps

## Must-haves

### R48-044 — UX friction 346 (7.86%, 3.35★) led by confusing setup 118 (3.11★) — steady at 2–3% in every era, the most persistent usability complaint: how to configure a goal type, log a number, or where deletion lives; yes / no semantics (12) is its sharpest form — bad-habit logging where a tap's meaning is genuinely ambiguous; too many taps (31) spikes in mid-2021 with the history-logging redesign; no skip / pause (13) and weekday scheduling (21) are the two structural scoring complaints — a weekly goal still demands a daily answer and there is no vacation mode; dated UI (62) rises slowly to 1.68% of E5

- **Where:** §3.4.5 UX friction
- **This app does:** four tracker types with setup that confuses; no vacation mode; weekly goals scored daily
- **User reaction:** confused; scoring feels wrong
- **Magnitude:** 346 (7.86%)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `7506344777`, `9016389877`, `12374920319`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency; C057 Offer a non-pastel / premium design option; C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in; C136 When an item can be tracked more than one way, make the user choose the mode at creation; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R48-045 — Support failure 40 (0.91%, 1.57★): no response 29 and support only reachable in-app 14 — a structural trap that is growing (1.08% of E5): the only support route is inside the app, so users whose app will not launch cannot reach it; nine such reviews are 1★ reviews written as support tickets

- **Where:** §3.4.6 support failure
- **This app does:** support contact only inside the app
- **User reaction:** 1★ reviews used as support tickets
- **Magnitude:** 40; 14 in-app-only
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `9696594665`, `10162216990`, `11302947469`, `13576643207`, `12211893087`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R48-087 — Disclose the free-tracker limit before setup, on the store listing and at first run: 48 reviews (mean 1.65★, rising to 2.05% of E5) invested setup effort and only then met the wall — 'the cheapest 1★ in the corpus to eliminate: it costs one line of copy and removes a grievance that is about the surprise, not the price'

- **Where:** Part 8 #1 — §8.1 fix 1 disclose the limit
- **This app does:** limit not disclosed before setup
- **User reaction:** surprise at the wall
- **Magnitude:** 48 (1.65★)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R48-089 — Give support a route that works when the app does not: 14 reviews (1.08% of E5 and growing) are 1★ reviews written as support tickets because in-app help was unreachable; publish a support e-mail on the website and in the App Store listing; nine are from payers

- **Where:** Part 8 #3 — §8.1 fix 3 support route outside the app
- **This app does:** in-app-only support
- **User reaction:** 1★ as a ticket
- **Magnitude:** 14; 9 payers
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R48-096 — Ship weekday scheduling and a skip / pause mode: 21 describe weekly goals that still demand daily answers and weekend 'misses' for weekday habits; 13 want vacation / illness handling that does not destroy a streak or an average — scoring-correctness complaints from otherwise-happy users, sustained across all five eras

- **Where:** Part 8 #10 — §8.2 change 10 weekday scheduling and skip / pause
- **This app does:** no weekday schedule; no vacation mode
- **User reaction:** scoring feels wrong
- **Magnitude:** 21 + 13
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

## Must never break

### R48-008 — Reliability was existential twice and is now genuinely fixed: crash-family reviews run 76 in E1 and 115 in E2 — 29.55% of E2 could not open the app at all — then 31 in E3 and 24 in E5 (2.89%); the whole reliability family is 32.2% of E1, 52.6% of E2, and 8.3% of E5 — 'the clearest improvement in the corpus and it should be defended, not revisited'

- **Where:** §Executive summary 3
- **This app does:** crash-prone 2013–15, stable since
- **User reaction:** could not open the app
- **Magnitude:** reliability 52.6% of E2 → 8.3% of E5
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C030 Sync must work — and prove it; C031 Crashes / launch failures

### R48-010 — Paying customers are visible, satisfied and badly served when something breaks: 172 reviews (3.91%) show first-person purchase evidence at mean 3.92★ — below the corpus mean because 84 (48.8% of payers) also report a problem; 73 say the paid tier is worth it (4.97★) and 23 name a lifetime purchase; but 23 payers demand refunds, 12 report billing faults, 8 got no support reply, and support is only reachable inside an app that 9 payers say will not open (sup_only_reachable_in_app, rising to 1.08% of E5) — 'The paid experience fails at exactly the moments it matters'

- **Where:** §Executive summary 5
- **This app does:** support reachable only in-app
- **User reaction:** payer with a broken app cannot reach support
- **Magnitude:** 172 payers; 84 with a problem; 23 refunds
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C029 Billing must be exactly right; C036 A support channel that exists, is reachable outside the app, and answers; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R48-043 — Reliability sub-themes by era (E1–E5): crash / won't open 185 (1.88★: 41 / 91 / 17 / 22 / 14); crash on action 82 (35 / 18 / 11 / 9 / 9); wrong counts / stats 85 (22 / 8 / 26 / 20 / 9); notification bug 78 (17 / 15 / 20 / 17 / 9); data loss 58 (1.67★: 7 / 25 / 9 / 13 / 4); sync fail 48 (0 / 11 / 12 / 12 / 13); frozen 41 (3 / 9 / 3 / 25 / 1); duplicate entries 32 (1 / 20 / 4 / 5 / 2) — two crises: an iOS 8 / iPhone 6 era (late 2014, crash on adding a tracker and on the back button, 20 reviews Sep–Dec 2014) and the v3.0 sync rewrite (2015: crash on launch at 29.55% of E2, duplicated trackers, lost data), both fixed; reliability is 8.3% of E5 and the crash union 24 (2.89%); the one sub-theme that has not fallen is sync failure — flat at 11–13 per era since 2015 and now the most common reliability complaint

- **Where:** §3.4.4 reliability table
- **This app does:** two historical crises fixed; sync failures flat
- **User reaction:** n/a
- **Magnitude:** 583 (13.24%, 2.40★)
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C030 Sync must work — and prove it; C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C039 Reminders fire reliably, once; C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement

### R48-058 — 84 of 172 payer reviews (48.8%) also report a problem: price still objected 14 (of 266 global), billing problem 12 (of 23), confusing setup 10, stated churn 10, crash / won't open 9, refund request 8, no support response 8, better reports 7, sync fail 6, crash on action 6

- **Where:** §5.3 post-purchase failures table
- **This app does:** n/a
- **User reaction:** payers hurt after paying
- **Magnitude:** 84 of 172
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R48-059 — Billing is the fastest-growing monetisation fault: billing problem 1 in E2, 4 in E3, 6 in E4, 12 in E5 (1.44%) — charged $39.99 instead of the agreed $4.99; charged the full year at the start of a 7-day trial; charged twice after cancelling before the trial ended, blocking other App Store purchases (the final review in the corpus); 'there is another active subscriber using the same receipt'; paid subscription not recognised after an update (three)

- **Where:** §5.3 billing
- **This app does:** trial-start full charge; wrong amount; unrecognised subscription after update
- **User reaction:** refund demands; 1★
- **Magnitude:** 23 (12 in E5)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `8374607922`, `12011239688`, `14509426891`, `8191839172`, `4465653992`, `4724881241`, `7543156337`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C109 A free trial must be a real trial; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R48-060 — The support trap compounds billing: support is reachable only in-app, so a payer whose app will not open has no route — several one-star reviews are written explicitly as help requests

- **Where:** §5.3 support trap
- **This app does:** in-app-only support
- **User reaction:** 1★ as a help request
- **Magnitude:** 6 payer cases
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `9696594665`, `10162216990`, `11302947469`, `12211893087`, `13576643207`, `9559447782`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R48-061 — 23 refund requests at mean 1.04★ — the lowest-mean theme with n > 10 — concentrated in 2014–15 (paid-app buyers who felt the product failed) and 2019+ (trial and auto-renew disputes); 4 cancellation-difficulty reviews retained as compliance-adjacent

- **Where:** §5.4 refunds and cancellations
- **This app does:** auto-renew and trial disputes
- **User reaction:** 1.04★
- **Magnitude:** 23 + 4
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `1304732873`, `1410463210`, `4325565920`, `14509426891`
- **Canonical:** C029 Billing must be exactly right; C112 In-app cancellation; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R48-090 — Fix the billing edge cases: 23 billing-fault reviews, 12 in E5 — full-year charges at trial start, double charges after cancellation, purchases not recognised after update, 'another active subscriber using the same receipt' — averaging 2.3★ and escalating to refund demands and App Store disputes; the fastest-growing monetisation fault

- **Where:** Part 8 #4 — §8.1 fix 4 billing edge cases
- **This app does:** trial-start charge; double charge; unrecognised purchase
- **User reaction:** refunds and disputes
- **Magnitude:** 23 (12 in E5)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial

### R48-091 — Close out sync: sync failure is the only reliability theme that never improved (11 / 12 / 12 / 13 across E2–E5) and is now the most common reliability complaint in the current era

- **Where:** Part 8 #5 — §8.1 fix 5 close out sync
- **This app does:** iCloud sync failing at a flat rate
- **User reaction:** n/a
- **Magnitude:** 48 total; 13 in E5
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C030 Sync must work — and prove it

## Features

### R48-018 — Four tracker types — Habit (yes/no), Target (a number by a date), Average (rolling mean), Project (milestones, %) — are the defining feature: 485 praise reviews, 'not just the binary yes/no of traditional habit apps'; bad-habit / 'less is better' tracking (a limit, not a goal; red/green inverts) praised by 105 — one reviewer quit smoking after benchmarking 10+ rivals

- **Where:** §2.1 four tracker types
- **This app does:** four tracker types incl. numeric target, rolling average and project milestones; inverted bad-habit mode
- **User reaction:** the reason people choose it over yes/no trackers
- **Magnitude:** 485 (11.02%); 105 bad-habit
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `917379605`, `1370794562`, `1891448103`, `11461372218`, `13646840535`, `6553635234`
- **Canonical:** C019 Quit-habit / bad-habit mode; C048 Flexible units / partial progress; C108 Goals / targets; C265 Tracker types beyond yes/no — numeric target, rolling average and project milestones — as the reason people switch from binary habit apps

### R48-019 — Configurable streak targets ('don't break the chain') praised by 144 — a 507-day streak, 1,000 consecutive days with 3,497 tracked; multiple custom reminders per tracker with user-written message text praised by 224 — the reminder says the reviewer's own words; dashboard, charts, calendar and a pace line ('where you should be today') praised by 241 with goal pacing 56

- **Where:** §2.1 streaks and reminders
- **This app does:** several alerts per day per tracker, custom text; pace line
- **User reaction:** praised
- **Magnitude:** 144 / 224 / 241 / 56
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `11672096169`, `13989739905`, `3092522796`, `3026979984`
- **Canonical:** C008 Daily check-in and reminders are free — never paywall the reminder; C014 Multiple reminders per habit; C024 Streaks / gamification; C108 Goals / targets

### R48-020 — Apple Watch app and complication (24 praise, 12 Watch bugs, 5 complication requests); home / lock-screen widgets arrived ~2020 and interactivity was later removed (12 praise, 20 requests, 14 widget bugs); Apple Health and Siri Shortcuts auto-log steps / weight (17 praise, 3 sync bugs); a Mac app from ~March 2022 welcomed by long-term users; a web app 2015 – ~2019 that was discontinued and whose removal is still resented (69 multi-platform praise, 17 web / other-platform requests); CSV export premium, praised and occasionally broken (16 requests, 4 export bugs); a free goal-setting course / handbook repeatedly credited (27); iCloud sync replaced the 2015 account-based sync (48 sync failures when it misbehaves)

- **Where:** §2.1 platform capabilities
- **This app does:** Watch, widgets (interactivity removed), Health, Shortcuts, Mac, discontinued web app, CSV export, free course
- **User reaction:** web-app removal resented; widgets less interactive
- **Magnitude:** see counts
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `8407086509`, `8409343866`, `9053449079`, `12948472060`, `14500682632`
- **Canonical:** C009 Basic widgets, icons and colours are free; C013 Cloud sync / multi-device as the paid differentiator; C020 Data export / backup / CSV; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C023 Interactive widget check-off; C044 Mac / desktop / web app; C046 Shortcuts / Siri / URL scheme / API; C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R48-021 — Absent per reviewers: shared / partner accountability (22), true time-duration units HH:MM (8), an API or IFTTT / Zapier automation (9), a built-in timer (5), Android (a waitlist exists on the site), skip / vacation mode (13 ux_no_skip_or_pause), arbitrary cadences such as every-other-day (35 fr_flexible_frequency)

- **Where:** §2.1 capabilities asked for and absent
- **This app does:** none of these
- **User reaction:** requested
- **Magnitude:** 22 / 8 / 9 / 5 / 13 / 35
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C015 Shared / group habits; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency; C046 Shortcuts / Siri / URL scheme / API; C051 Android version; C066 Focus timer; C098 Time-unit flexibility for counters (hours → years)

### R48-037 — Streak motivation (144, mean 4.96★ — the highest of any theme with n > 100) is the purest motivation mechanic ('I can't bear to see it go'); visual progress (241) is the charts, calendar and red / green; goal pacing (56) is the quietly distinctive one — the projected-date and 'am I on pace' maths that only the Target and Project types provide

- **Where:** §3.3.5 streaks, visual progress, pacing
- **This app does:** pace line and projected completion date for numeric goals
- **User reaction:** praised
- **Magnitude:** 144 / 241 / 56
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `1630702511`, `6790034274`, `13917984452`
- **Canonical:** C024 Streaks / gamification; C108 Goals / targets; C265 Tracker types beyond yes/no — numeric target, rolling average and project milestones — as the reason people switch from binary habit apps

## Monetization

### R48-022 — Four monetisation regimes over 11 years: 2013 – Jan 2015 a paid app at roughly $2.99–$4.99 one-time, no account ('not really worth $2.99'; 'well worth $4.00'; '£2.49'); Jan – Sep 2015 subscription-only at $4.99/mo or $49.99/yr, account required, 30-day trial, prior purchasers told they were grandfathered and many say they were not; Oct 2015 – mid 2018 a freemium relaunch with a generous free tier (~10 trackers) and Plus adding tags, filters, notes, export, unlimited trackers ('free unlimited habits' announced); mid 2018 – present freemium with a tightening cap 10 → 7 (mid-2018) → 3 (the most-cited number from 2020 on) with Plus monthly / annual / lifetime

- **Where:** §2.2 four monetisation regimes table
- **This app does:** paid → subscription → generous freemium → tightening freemium
- **User reaction:** each regime change produced its own complaint family
- **Magnitude:** four regimes
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `926228901`, `974433082`, `1097369177`, `1132627055`, `1133263942`, `1136026653`, `1152141697`, `1153567265`, `1273838707`, `1311552630`, `1999423881`, `2957558274`, `3168367859`, `6021145901`, `12401006422`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C035 Account system from day one; C186 Never revoke what earlier buyers paid for when the model changes

### R48-023 — Free (current era): a small fixed number of trackers (most commonly 3) with all four tracker types, unlimited custom reminders, calendar / history, streaks, widgets, Watch app and no ads (248 'free is enough'; 33 no-ads praise); Plus: unlimited trackers, tags / filters / Today list, notes on goals, data export, cross-device sync, reports — 199 name the tracker cap as the paywall; unclear which report views are gated and whether notes are free (a reviewer and the developer disagree)

- **Where:** §2.2 free vs paid table
- **This app does:** capability-rich free tier gated only on tracker count
- **User reaction:** 248 say free is enough; 199 hit the cap
- **Magnitude:** 248 / 199 / 33
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `5435794858`, `6378721003`, `1647723891`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C045 Grouping / folders / categories / tags; C133 Gate on capability, not on quantity; C172 Per-day / per-habit notes and journal text

### R48-025 — Listing (12 Sep 2026): free with IAP, Strides Plus tiers at $4.99, $7.99, $9.99, $29.99, $39.99, $99.99 and $149.99; version 19.13 (16 Aug 2025); 4.8★ from ~19,000 ratings; iOS 17+; 10 languages; free tier stated as 3 trackers with Plus adding unlimited trackers, sync, tags / filters, Today list, export and goal notes; stridesapp.com confirms four tracker types, iPhone / iPad / Mac, advertises an Android waitlist, publishes no prices, no free-tier limit and no mention of the discontinued web app; the store's 3-tracker free tier matches what reviewers report since ~2020

- **Where:** §2.3 external sources
- **This app does:** 3 free trackers; seven Plus SKUs up to $149.99
- **User reaction:** n/a
- **Magnitude:** listing facts
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C003 Lead with a one-time lifetime purchase; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R48-039 — 'Free tier is enough' (248) is the load-bearing praise, overwhelmingly from E3–E4 when the tier was large (7.82% of E3 → 4.81% of E5); worth the price 73 (4.97★) and pay-to-support-dev 9 are the paid counterweight; free-tier satisfaction is falling as the cap tightens while cap complaints rise

- **Where:** §3.3.7 monetisation praise
- **This app does:** generous free tier 2015–18, tightened since
- **User reaction:** satisfaction falling with the cap
- **Magnitude:** 351 (7.97%, 4.77★)
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C001 Never move a free feature behind the paywall; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R48-040 — The free-tracker cap union (cap too low 199, cap reduced 23, raise the cap 15) is 211 reviews (4.79%, mean 2.68★): 0 in E1, 1 in E2, 28 in E3, 97 in E4, 85 in E5 — 32 in the last 24 months alone where it reaches 12.1% of all reviews; the only major negative theme whose rate is still climbing; three distinct complaints needing different fixes — (1) too small to evaluate the product (199: 'No one has just one habit they need to track'; 'I can't do much with just three free task'; 'you shouldn't make people feel like they can't have more than 3 unless they pay'), (2) the cap shrank retroactively (23, mean 2.22★ — users who built history on 10 or 7 trackers cannot re-add one after deleting it, 'punishment of existing users'), (3) the limit was not disclosed before setup effort (48, mean 1.65★ — 'I lost my time encoding 3 trackers for nothing'; 'Wish i knew before i downloaded and set everything up', rising 0.49% of E3 → 2.05% of E5)

- **Where:** §3.4.1 free-tracker cap
- **This app does:** 3-tracker cap, reduced from 10 → 7 → 3, undisclosed
- **User reaction:** cannot evaluate; punished; setup wasted
- **Magnitude:** 211 (4.79%); 12.1% of last 24 months
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12919506637`, `5260457163`, `8219828649`, `2946161512`, `2957558274`, `3168367859`, `4872544084`, `6652736923`, `12980575138`, `8794696710`, `11069487020`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C191 Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C219 A free cap must be concurrent, never lifetime — deleting a habit frees a slot; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R48-041 — Price union (too high 266, want one-time 58, subscription objection 48, lifetime too high 28) is 316 (7.18%, mean 2.74★) and fell from 21.43% of E2 to 4.69% of E5; what remains is driven by the subscription model ('I won't rent an app') and the lifetime price, quoted at $79.99–$149.99 and repeatedly called disproportionate for a tracker — while 73 say it is worth it at 4.97★

- **Where:** §3.4.2 price
- **This app does:** $4.99/mo; lifetime $79.99–$149.99
- **User reaction:** won't rent; lifetime disproportionate
- **Magnitude:** 316 (7.18%) falling
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `5466637763`, `7589358605`, `9942354598`, `13205964615`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors

### R48-056 — Purchase triggers in buyers' words, ranked: (1) hitting the tracker cap — the dominant mechanical trigger ('I'll probably upgrade to the paid version soon to get more trackers'); (2) sustained free use first, then payment as endorsement — 38 payers say worth the price, many after months or years free ('used the free plan… until yesterday I finally decided to switch to Pro to support the developers'); (3) cross-device sync — the paid feature most often named; (4) supporting the developer (9), typically after a support interaction; (5) the goal-setting course / book — 27 arrive via it and several convert

- **Where:** §5.2 purchase triggers
- **This app does:** cap as trigger; sync as the named paid feature; free course as funnel
- **User reaction:** pay after long free use, as endorsement
- **Magnitude:** 172 payers
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `3309224718`, `10413395300`, `12143126487`, `7091572225`, `4142865254`, `4180510540`, `11901589230`, `12948472060`, `14500682632`, `2049600866`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C061 Goodwill conversion — a generous free tier and 'support the devs'; C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C133 Gate on capability, not on quantity

### R48-057 — Would-be buyers blocked at the terms: 43 state an intention to pay that the current terms defeat (willing to pay, mean 4.12★) and 58 would pay a one-time fee but not a subscription; the clearest statement of the lost-conversion mechanism: 'I will pay for an app after I use it for a couple weeks and have grown to appreciate the app… You are not allowing a certain group of people try out your app'

- **Where:** §5.2 would-be buyers blocked
- **This app does:** 3-tracker cap blocks evaluation; subscription-only
- **User reaction:** would pay after trying; won't rent
- **Magnitude:** 43 + 58
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `8219828649`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C133 Gate on capability, not on quantity; C147 Let people use the product before they pay

### R48-063 — Four separately counted barriers: subscription as a model (48 reject recurring billing in principle); one-time preference (58, several naming $10–$20); lifetime price (28 accept the model but reject $79.99–$149.99 as disproportionate for a tracker); cannot evaluate before paying (48 undisclosed-paywall plus the cap complaints — never reached a purchase decision because the free surface was too small) — barriers 1–3 are preference, barrier 4 is fixable product design and the one that is growing

- **Where:** §5.5 barriers to upgrading
- **This app does:** 3-tracker free tier; lifetime $79.99–$149.99
- **User reaction:** n/a
- **Magnitude:** 48 / 58 / 28 / 48+
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R48-093 — Offer a cheap, narrow paid tier that only unlocks trackers: 58 want a one-time purchase, 48 reject subscriptions as a model, 28 accept the model but reject the lifetime figure; multiple reviewers propose exactly this split themselves — pay once for capacity, subscribe for sync / reports

- **Where:** Part 8 #7 — §8.2 change 7 cheap narrow tracker tier
- **This app does:** subscription or $79.99–$149.99 lifetime only
- **User reaction:** propose pay-once-for-capacity
- **Magnitude:** 58 + 48 + 28
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `2678777187`, `7031612228`, `12919506637`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

## Tactics the app used

### R48-011 — Support is a genuine differentiator, named person and all: 127 reviews (2.89%, mean 4.89★) praise support responsiveness, very often naming the CEO by first name, and 55 confirm a reported bug was actually fixed — rare in a 4,402-review corpus; it partially offsets pricing anger and several reviewers upgraded their rating explicitly after contact

- **Where:** §Executive summary 6
- **This app does:** founder answers support personally
- **User reaction:** rating upgraded after contact
- **Magnitude:** 127 (2.89%, 4.89★); 55 fixes confirmed
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R48-038 — 127 reviews praise support (4.89★), frequently naming the CEO; 103 praise shipped updates and the public feature-voting board; 55 confirm a specific fix (4.78★); several reviewers raise their rating in place after contact; US (3.38%) and GB (3.83%) over-index — 'In an 11-year corpus this is an unusually durable asset'

- **Where:** §3.3.6 support and developer responsiveness
- **This app does:** founder-fronted support; public feature-voting board
- **User reaction:** ratings raised in place after contact
- **Magnitude:** 127 + 103 + 55
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `1811801602`, `1957498454`, `2858976575`, `7540012549`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R48-101 — Experiments: a larger free tier measured on paid conversion rather than rating (E3 pairs the largest free tier with the highest ratings and a growing payer share, but that is correlation across eras); a tracker-only paid tier at a low one-time price tested against the 58 one-time requesters' $10–$20 range; onboarding that teaches goal-type selection — confusing setup stuck at 2–3% for a decade (118) concentrates on choosing Habit / Target / Average / Project, and the existing course credited by 27 could be surfaced at first run; reports / trends as the next paid feature (76 requests from satisfied users, still open Aug 2026)

- **Where:** §8.4 experiments
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** four experiments
- **Direction for us:** mixed · **Report confidence:** medium · **Generalisable:** general
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C011 Weekly / monthly / yearly reports; C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

## Insights (the why)

### R48-005 — Structurally loved, monetization-scarred: 72.38% of reviews (3,186) contain explicit praise of the product itself at mean 4.84★; 14.04% (618) attack how it is sold at mean 2.53★, and those 618 supply 51.0% of every 1–2★ review — 'Nothing in this corpus suggests users dislike Strides. A large, repeated minority dislikes the deal'

- **Where:** §Executive summary opening
- **This app does:** freemium habit + goal tracker with a tracker cap
- **User reaction:** praise 4.84★ vs monetisation friction 2.53★
- **Magnitude:** 3,186 praise (72.38%) vs 618 friction (14.04%)
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R48-007 — The live monetisation problem is the free-tracker cap, not price, and it is the only negative theme still growing: mf_free_cap_too_low 0.00% of E1 → 1.59% of E3 → 7.00% of E4 → 9.87% of E5 (2022+), and 12.1% of reviews in the last 24 months — the second-most-common theme of any kind behind generic praise; the cap union is 211 reviews (4.79%, very strong, mean 2.68★); price complaints fell from 21.43% of E2 to 4.69% of E5 — 'Users have stopped arguing that Strides is expensive and started arguing that they cannot evaluate it': 48 say the limit was not disclosed before they invested setup effort (mean 1.65★) and 16 say the cap shrank under them after they had built history on it

- **Where:** §Executive summary 2
- **This app does:** free tier capped at 3 trackers (from ~2020), not disclosed before setup, reduced retroactively
- **User reaction:** cannot evaluate the product; setup effort wasted
- **Magnitude:** 211 (4.79%); 48 undisclosed (1.65★); 16 reduced
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C191 Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R48-009 — What users love is specific and unusual, and it is the moat: flexible tracker types (485, 11.02%, mean 4.82★ — habit / target / average / project, 'not just yes/no'), simplicity (817, 18.56%), best of many tried (453, 10.29%, 4.89★ — reviewers who benchmarked rivals and returned), and behaviour change actually achieved (267, 6.07%, 4.95★ — weight lost, smoking quit, 1,000-day flossing streaks); 137 reviews identify as multi-year users, rising from 1.41% of E3 to 8.54% of E5 — the retained base is the strongest asset and its loudest cap-complainers are often the same people

- **Where:** §Executive summary 4
- **This app does:** four tracker types beyond yes/no
- **User reaction:** benchmarked rivals and returned; life outcomes
- **Magnitude:** 485 / 817 / 453 / 267; 137 multi-year
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C005 Know which competitors buyers compare against; C006 Stay minimal — every addition is opt-in or off by default; C134 Lead the store listing with what users actually love; C265 Tracker types beyond yes/no — numeric target, rolling average and project milestones — as the reason people switch from binary habit apps

### R48-013 — The remaining growth constraint is that the free tier is now too small to demonstrate the product's one genuine differentiator — multi-type tracking across several goals — to people who have not yet paid; the users' own fix: raise the trial surface, disclose it up front, and stop shrinking it retroactively

- **Where:** §Executive summary strategic read
- **This app does:** 3-tracker free tier vs a four-type multi-goal product
- **User reaction:** cannot try the differentiator
- **Magnitude:** cap union 211
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C147 Let people use the product before they pay

### R48-015 — January dominates for a goal-tracking app: 775 reviews (17.6%) were written in January — 2.3× the average month — consistent with New Year resolution behaviour; the largest month is January 2018 (144), the second January 2015 (125), which is the subscription crisis rather than resolution season

- **Where:** §1.4 January dominates
- **This app does:** goal / resolution tracker
- **User reaction:** n/a
- **Magnitude:** 775 (17.6%) in January
- **Direction for us:** none · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C032 New Year peak-season robustness — year-end report and January onboarding

### R48-027 — Top ten themes: generic positive 858 (19.49%, 4.90); simplicity 817 (18.56%, 4.84); flexible tracker types 485 (11.02%, 4.82); best of many 453 (10.29%, 4.89); low-information 416 (9.45%); behaviour change 267 (6.07%, 4.95); price too high 266 (6.04%, 2.74); free tier is enough 248 (5.63%, 4.82); visual progress 241 (5.47%, 4.86); reminders 224 (5.09%, 4.87) — all high-priority

- **Where:** §3.1 rows 1-10
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** top ten
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** C005 Know which competitors buyers compare against; C006 Stay minimal — every addition is opt-in or off by default; C265 Tracker types beyond yes/no — numeric target, rolling average and project milestones — as the reason people switch from binary habit apps

### R48-028 — Very strong and meaningful rows: design / aesthetic 212 (4.82%, 4.57); free cap too low 199 (4.52%, 2.65); crash / won't open 185 (4.20%, 1.88); customization 167 (3.79%, 4.87); paid premium 149 (3.38%, 3.83); streak motivation 144 (3.27%, 4.96); long-term user 137 (3.11%, 4.50); support responsive 127 (2.89%, 4.89); confusing setup 118 (2.68%, 3.11); accountability 110 (2.50%, 4.92); bad-habit tracking 105 (2.39%, 4.81); competitor named 105 (2.39%, 3.16); stated churn 105 (2.39%, 1.79); dev listens 103 (2.34%, 4.80)

- **Where:** §3.1 rows 11-24
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** rows 11-24
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** C005 Know which competitors buyers compare against; C007 Generous fixed habit cap (or unlimited) — never change it; C019 Quit-habit / bad-habit mode; C024 Streaks / gamification; C031 Crashes / launch failures; C036 A support channel that exists, is reachable outside the app, and answers; C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R48-029 — Meaningful rows: fitness / weight 95 (2.16%, 4.87); wrong counts / stats 85 (1.93%, 2.59); crash on action 82 (1.86%, 2.62); notification bug 78 (1.77%, 2.64); better reports 76 (1.73%, 4.07); worth the price 73 (1.66%, 4.97); paid-then-subscription 70 (1.59%, 1.51); multi-platform sync 69 (1.57%, 4.93); dated UI 62 (1.41%, 3.63); not worth it 61 (1.39%, 1.61); want one-time purchase 58 (1.32%, 2.83); data loss 58 (1.32%, 1.67); project milestones 56 (1.27%, 4.48); fix acknowledged 55 (1.25%, 4.78); paywall not disclosed 48 (1.09%, 1.65); subscription objection 48 (1.09%, 2.04); sync fail 48 (1.09%, 2.65)

- **Where:** §3.1 rows 25-41
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** rows 25-41
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** C003 Lead with a one-time lifetime purchase; C011 Weekly / monthly / yearly reports; C013 Cloud sync / multi-device as the paid differentiator; C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C039 Reminders fire reliably, once; C057 Offer a non-pastel / premium design option; C059 Be visibly responsive; fixes bring reviewers back; C067 Fitness / health tracking use case; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C186 Never revoke what earlier buyers paid for when the model changes

### R48-030 — Emerging rows: willing to pay 43 (0.98%, 4.12); finance segment 43 (4.72); frozen 41 (2.22); non-punitive 39 (0.89%, 4.90); forced account signup 39 (1.64, 2015–18); no localization 39 (3.79, US n 1); rating-text mismatch 37; flexible frequency 35 (3.97); business / sales segment 34 (4.79); goal pacing 33 (4.97); no ads 33 (4.85); duplicate entries 32 (2.31); can't edit / delete a log 32 (3.22); too many taps 31 (3.16); book / course 29 (4.93); no support response 29 (1.55); lifetime price too high 28 (2.46, US n 6); slow / lag 27; tags / categories 26 (4.12); trial terms 26 (1.65); log not registering 26; timezone / date bug 26 (3.35, 2014–22); Watch app praised 24 (4.67); health / medical 24; student 24; end date / archive 23 (4.09); billing problem 23 (2.52); free cap reduced 23 (2.22); refund request 23 (1.04); paid lifetime 23 (4.52, 2019–26); mental health 23 (4.78)

- **Where:** §3.1 rows 42-72
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** rows 42-72
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** C003 Lead with a one-time lifetime purchase; C020 Data export / backup / CSV; C022 Apple Watch app (done properly: timer, two-way sync); C027 Localise early — it unlocks revenue; C029 Billing must be exactly right; C035 Account system from day one; C036 A support channel that exists, is reachable outside the app, and answers; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C043 Flexible / custom frequency; C045 Grouping / folders / categories / tags; C061 Goodwill conversion — a generous free tier and 'support the devs'; C095 Neutral, non-judgemental tone on failure; C109 A free trial must be a real trial; C191 Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request; C223 Undo / un-complete is a visible button — never a gesture-only path; C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot; C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R48-031 — Weak and ignore rows: social accountability 22 (4.45); notes / journal praised 21 (4.95); login / account fail 21 (1.86); weekday scheduling 21 (3.57); widget requested 20 (4.00); health / shortcuts praised 17; gamification requested 17 (4.47); web / other platform 17; feature removed from free 17 (2.82); backup / export 16; raise free cap 15 (3.13); notes requested 14; grandfather broken 14 (1.64, 2015 only); widget bug 14 (3.07); backfill praised 13 (4.08); units 13; upsell nag 13 (2.08); ADHD 13 (3.77); support only reachable in-app 13 (1.69); no skip / pause 13 (3.69); widget praised 12 (5.00); Watch bug 12 (2.33); notification overload 12 (2.33); yes / no semantics 12 (3.08); API / automation 11; dark mode 11 (4.64); points system 10 (4.20, 2013–14); iPad app 9 (2013–15); review prompt nag 9 (2.22); time duration 8; Watch complication 8; faith 8 (5.00); no landscape iPad 8 (2.62); pay to support dev 7 (5.00); more free features 6; timer 6; accessibility 6 (3.50); cancel difficulty 4 (1.25); export bug 4; duplicate text 3; review prompt 3; fake-reviews claim 3 (1.33); Health sync bug 3; audio interrupt 2; day boundary 2

- **Where:** §3.1 rows 73-117
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** rows 73-117
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free; C015 Shared / group habits; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C020 Data export / backup / CSV; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C035 Account system from day one; C036 A support channel that exists, is reachable outside the app, and answers; C040 Widgets must not go blank, stale or disagree with the app; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C043 Flexible / custom frequency; C044 Mac / desktop / web app; C046 Shortcuts / Siri / URL scheme / API; C048 Flexible units / partial progress; C052 Points / rewards / wish list; C066 Focus timer; C073 Manual reordering, renaming and editing of habits/tasks — free; C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable; C080 Colour themes / dark mode; C093 No upsell nagging without a 'never ask again' option; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C104 Never ship a paywall or feature-removal change silently; C112 In-app cancellation; C123 Notifications are few and finely user-controllable — per-type settings, escalation opt-in, never spammy and never silently retuned; C136 When an item can be tracked more than one way, make the user choose the mode at creation; C141 Native iPad layout; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size; C172 Per-day / per-habit notes and journal text; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R48-032 — Families (union, % of 4,402, mean, share of the 681 1–2★): core praise 3,186 (72.38%, 4.84, 6.5%); monetisation friction 618 (14.04%, 2.53, 51.0%); reliability 583 (13.24%, 2.40, 49.5%); meta 454 (10.31%); segments 395 (8.97%, 4.65); monetisation praise 351 (7.97%, 4.77, 1.6%); UX friction 346 (7.86%, 3.35, 15.7%); feature gaps 321 (7.29%, 4.07, 5.7%); product-value criticism 250 (5.68%, 2.28, 24.4%); purchase evidence 172 (3.91%, 3.92, 6.0%); support 95 (2.16%, 3.43, 5.0%); any praise 3,296 (74.88%, 4.82, 7.9%) — core praise is 72% of the corpus but 6.5% of its 1–2★; monetisation friction is 14% of the corpus and 51% of them; reliability's 49.5% share is overwhelmingly historical while the monetisation damage is current

- **Where:** §3.2 family aggregates table
- **This app does:** n/a
- **User reaction:** praise does not coexist with low ratings; the deal does
- **Magnitude:** 3,186 vs 618 vs 583
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R48-033 — Simplicity is the most-cited concrete virtue and stable across every era (16.08% of E1, 21.52% of E3, 19.86% of E5): reviewers mean two things — fast to log ('open the app, click a check mark, exit') and uncluttered to look at — and it coexists with the app's depth rather than contradicting it: 'the most robust habit tracker without being bloated'

- **Where:** §3.3.1 simplicity
- **This app does:** depth (four tracker types) with a simple surface
- **User reaction:** praised
- **Magnitude:** 817 (18.56%, 4.84★)
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `2388561708`, `840926526`, `922451377`, `1124728275`, `2272547310`, `6127536025`, `9867363272`, `13646840535`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R48-034 — Flexible tracker types are the differentiator and the reason people switch to the app: reviewers arrive from yes/no apps and stay because it tracks numbers, averages, targets and projects — 'I don't want to reduce everything to the binary yes/no' (2013) repeated in structure eleven years later (2024); one lists seven rivals before 'Strides is the only app that does both'; highest in GB (13.79%), AU (14.52%), IN (16.90%) — 'This theme, not streaks or design, is why people switch to Strides'

- **Where:** §3.3.2 flexible tracker types
- **This app does:** numeric, average, target and project trackers alongside yes/no
- **User reaction:** switch and stay
- **Magnitude:** 485 (11.02%, 4.82★)
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `917379605`, `11461372218`, `1204359342`
- **Canonical:** C108 Goals / targets; C265 Tracker types beyond yes/no — numeric target, rolling average and project milestones — as the reason people switch from binary habit apps

### R48-036 — Behaviour change actually achieved is the highest-mean substantial theme (4.95★) and rising 3.51% of E1 → 6.17% of E3 → 8.18% of E5 — outcome claims, not feature praise: 80 lbs lost, 31 lbs and 26 inches, quit smoking (two), 1,000 consecutive days of flossing across a 3,497-day history, a business built, a degree finished; US over-indexes +1.5pp

- **Where:** §3.3.4 behaviour change
- **This app does:** long-run tracker
- **User reaction:** life outcomes credited
- **Magnitude:** 267 (6.07%, 4.95★)
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `10643597772`, `9461414147`, `1529693362`, `1629695797`, `13989739905`, `9693465813`, `5297074809`
- **Canonical:** C067 Fitness / health tracking use case; C134 Lead the store listing with what users actually love

### R48-046 — Four kinds of unmet need kept apart: genuine requests (fr_*, 321, 7.29%, mean 4.07★ — from satisfied users: better reports / trends 76, flexible cadences 35, tags / categories 26, end dates and archiving 23, shared accountability 22, widgets 20, web / Android 17, gamified rewards 17, export / backup 16, raise the free cap 15, notes 14, units 13, dark mode 11, API 9, time-duration HH:MM 8, timer 5); broken existing capabilities (rel_*, 583); misunderstandings (confusing setup 118 — capability exists, often resolved in-thread by support, hence mean 3.11★); pricing objections (mf_*, 618) never counted as feature gaps; the most valuable request signal is the pairing — better reports (76, 4.07★, still open Aug 2026) comes almost entirely from people who like the app, and shared accountability (22, 4.45★) includes a coach who would move 100 clients onto the app if it existed

- **Where:** §3.5 unmet needs kept apart
- **This app does:** reports still thin; no shared accountability
- **User reaction:** requests from satisfied users
- **Magnitude:** 321 requests
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `8597913328`
- **Canonical:** C011 Weekly / monthly / yearly reports; C015 Shared / group habits; C020 Data export / backup / CSV; C043 Flexible / custom frequency; C045 Grouping / folders / categories / tags; C046 Shortcuts / Siri / URL scheme / API; C080 Colour themes / dark mode; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes; C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot

### R48-048 — Five stars (3,057): generic positive 783 (25.6%), simplicity 726 (23.7%), flexible tracker types 420 (13.7%), best of many 415 (13.6%), low-information 379 (12.4%), behaviour change 256, free tier enough 216 (7.1%), visual progress 213, reminders 198; 12.4% of five-star reviews contain no product content so the evidentiary base is nearer 2,680; 89 five-star reviews are from payers and 216 from people saying the free tier suffices — the five-star band is not a paid band

- **Where:** §4.1 five stars
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 3,057
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C134 Lead the store listing with what users actually love

### R48-049 — Four stars (450) is the 'yes, but' band: price too high 38 (8.4%) and free cap 28 (6.2%) — pricing is the single largest reason a satisfied user withholds the fifth star; then confusing setup 22 (4.9%) and better reports 22 (4.9%): 'the product is right, the deal or the polish is not'

- **Where:** §4.2 four stars
- **This app does:** n/a
- **User reaction:** withholds the fifth star over the deal
- **Magnitude:** 450
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C002 Ratings follow the offer, not the feature set; C004 Price low and fair, anchored against subscription competitors

### R48-050 — Three stars (214): price 43 (20.1%), free cap 33 (15.4%), then a reliability cluster (notification bug 21, wrong counts 21, crash on action 20); stated churn 18 (8.4%) — at three stars people are already announcing departure

- **Where:** §4.3 three stars
- **This app does:** n/a
- **User reaction:** announcing departure
- **Magnitude:** 214
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C007 Generous fixed habit cap (or unlimited) — never change it

### R48-051 — Two stars (197): price 43 (21.8%), free cap 35 (17.8%), crash / won't open 30 (15.2%), stated churn 24 (12.2%), competitor named 23 (11.7%) — where pricing anger and a named competitor arrive together: 'these reviewers have done comparison shopping and lost'

- **Where:** §4.4 two stars
- **This app does:** n/a
- **User reaction:** compared and left
- **Magnitude:** 197
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C005 Know which competitors buyers compare against

### R48-052 — One star (484): crash / won't open 113 (23.3%), price 87 (18.0%), free cap 67 (13.8%), stated churn 57, paid-then-subscription 52 (10.7%), not worth it 37, data loss 36, paywall not disclosed 30, forced account 27, refund request 22, no support response 21; two causes own the band and are separable in time — 214 of 484 fall in 2014–15 (crash era and subscription conversion) and 270 across the other eleven years: 'The crash cause is spent; the monetization cause is not'; 31 one-star reviews are from self-identified payers — the most expensive failure mode in the corpus

- **Where:** §4.5 one star
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 484; 31 payers at 1★
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C031 Crashes / launch failures; C065 Paying customers are the highest 1★ risk — every paid feature must work; C186 Never revoke what earlier buyers paid for when the model changes

### R48-062 — Stated churn 105 (2.39%, 1.79★) by era 2.34% / 9.74% (E2) / 0.98% / 2.41% / 2.41% — running at ~2.4% and no longer driven by crashes: in E4 / E5 it pairs most often with the free cap and a named competitor; 105 name a competitor as cheaper or better — Streaks, Habitify, Productive, Way of Life, Done, HabitBull, Habit, Loop, TickTick — and the comparison is almost always about price model, not capability: reviewers concede Strides is more powerful and leave anyway

- **Where:** §5.4 churn and competitors
- **This app does:** more powerful, dearer model
- **User reaction:** leave for a cheaper model
- **Magnitude:** 105 + 105
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `3017109535`, `12023341090`, `4220820733`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C005 Know which competitors buyers compare against

### R48-084 — Self-identified multi-year users 0.00% → 0.65% → 1.41% → 3.19% → 8.54% (E5), 7.8% in the last 24 months — 5-, 8-, 10-year tenures and 500- to 3,497-day streaks; over-represented in the two most recent grievances (7 of the 2021 tap-friction reviews; repeatedly in cap-reduction and nag-screen complaints) — 'Strides' most loyal cohort is now its most exposed to packaging changes, because they are the ones who remember the earlier terms'

- **Where:** §7.8 trend 7 ageing base
- **This app does:** eleven-year-old base
- **User reaction:** loyal users remember the earlier terms
- **Magnitude:** 8.54% of E5
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13989739905`, `11672096169`, `13646840535`, `10571805250`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently; C191 Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled

### R48-086 — What did not change in eleven years: simplicity praise 16–22% in every era; confusing setup 2–3% in E1, E3, E4 and E5 — a decade of onboarding friction no redesign removed (2.89% of E5); reminders praised (224) and faulted (78) at a stable ratio; no ads ever (33 praise, 0 complaints); support quality holds — 3.51% of E1 and 3.61% of E5 with fix-acknowledged steady around 1.2%

- **Where:** §7.10 trend 9 what did not change
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** five constants
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C059 Be visibly responsive; fixes bring reviewers back; C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

## Audiences

### R48-104 — Segments in reviews: fitness / weight 95 (2.16%, mean 4.87 — 80 lbs lost, 31 lbs and 26 inches), finance 43 (4.72), business / sales 34 (4.79 — 'a business built'), goal-setting book / course arrivals 29 (4.93), health / medical 24 (4.62), students 24 (4.58), mental health 23 (4.78), ADHD 13 (3.77 — the lowest-rated segment), faith 8 (5.00); self-identified multi-year users 137 (3.11%, 4.50) rising to 8.54% of E5; US reviewers over-index on outcomes and accountability; a coach would move 100 clients onto the app if shared accountability existed

- **Where:** §3.1 segment rows; §6.2; §7.8
- **This app does:** goal tracker used for weight, money, sales, study, health and faith goals
- **User reaction:** outcome-oriented, long-tenured
- **Magnitude:** 395 segment reviews (8.97%)
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `10643597772`, `9461414147`, `9693465813`, `8597913328`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C067 Fitness / health tracking use case; C140 Market the generic-tracker use case

## Markets and languages

### R48-065 — Storefront distribution (90 storefronts; nine eligible holding 81.44%): Storefront | n | % of 4,402 | Mean ★ | 5/4/3/2/1 | Payers | First–last | Status ; United States (us) | 2485 | 56.45% | 4.24 | 1758/221/124/118/264 | 104 | 2013-07 – 2026-09 | eligible (≥50) ; Canada (ca) | 285 | 6.47% | 4.16 | 188/38/10/14/35 | 9 | 2013-12 – 2026-05 | eligible (≥50) ; United Kingdom (gb) | 261 | 5.93% | 4.13 | 181/18/11/16/35 | 17 | 2013-12 – 2026-09 | eligible (≥50) ; Australia (au) | 124 | 2.82% | 3.99 | 75/16/6/11/16 | 2 | 2013-07 – 2026-01 | eligible (≥50) ; Germany (de) | 119 | 2.70% | 3.96 | 77/9/3/11/19 | 6 | 2013-12 – 2026-06 | eligible (≥50) ; Brazil (br) | 88 | 2.00% | 4.59 | 72/7/3/1/5 | 2 | 2014-03 – 2026-07 | eligible (≥50) ; Russia (ru) | 79 | 1.79% | 4.14 | 49/8/13/2/7 | 3 | 2013-12 – 2025-09 | eligible (≥50) ; China mainland (cn) | 73 | 1.66% | 4.08 | 48/9/3/0/13 | 2 | 2013-12 – 2026-03 | eligible (≥50) ; India (in) | 71 | 1.61% | 4.42 | 53/9/1/2/6 | 3 | 2013-12 – 2025-08 | eligible (≥50) ; Mexico (mx) | 42 | 0.95% | 4.45 | 32/5/0/2/3 | 1 | 2014-01 – 2026-05 | limited evidence ; Netherlands (nl) | 41 | 0.93% | 3.76 | 21/6/5/1/8 | 3 | 2013-07 – 2025-11 | limited evidence ; France (fr) | 36 | 0.82% | 4.36 | 24/7/1/2/2 | 0 | 2015-01 – 2026-01 | limited evidence ; New Zealand (nz) | 33 | 0.75% | 4.06 | 22/1/4/2/4 | 1 | 2013-12 – 2026-09 | limited evidence ; Sweden (se) | 33 | 0.75% | 4.18 | 18/7/5/2/1 | 1 | 2014-07 – 2025-10 | limited evidence ; Spain (es) | 27 | 0.61% | 4.37 | 19/4/1/1/2 | 3 | 2014-10 – 2025-10 | limited evidence ; Italy (it) | 27 | 0.61% | 4.11 | 14/7/3/1/2 | 2 | 2014-07 – 2024-08 | limited evidence ; Singapore (sg) | 26 | 0.59% | 4.27 | 18/4/0/1/3 | 1 | 2013-12 – 2025-01 | limited evidence ; Thailand (th) | 26 | 0.59% | 4.12 | 17/4/0/1/4 | 0 | 2013-12 – 2023-09 | limited evidence ; Turkey (tr) | 26 | 0.59% | 4.12 | 14/7/2/0/3 | 0 | 2014-07 – 2026-05 | limited evidence ; South Korea (kr) | 24 | 0.55% | 4.54 | 19/2/1/1/1 | 2 | 2013-12 – 2026-08 | limited evidence ; Switzerland (ch) | 22 | 0.50% | 4.27 | 17/0/2/0/3 | 0 | 2014-05 – 2026-01 | limited evidence ; South Africa (za) | 22 | 0.50% | 4.45 | 16/4/0/0/2 | 0 | 2014-01 – 2026-03 | limited evidence ; Malaysia (my) | 19 | 0.43% | 4.58 | 14/4/0/0/1 | 0 | 2014-07 – 2025-03 | limited evidence ; Poland (pl) | 19 | 0.43% | 4.53 | 15/1/2/0/1 | 0 | 2016-04 – 2025-12 | limited evidence ; Hong Kong (hk) | 18 | 0.41% | 4.22 | 11/4/1/0/2 | 0 | 2014-02 – 2024-02 | limited evidence ; Japan (jp) | 18 | 0.41% | 4.33 | 12/3/1/1/1 | 0 | 2014-02 – 2025-02 | limited evidence ; Czechia (cz) | 16 | 0.36% | 4.44 | 12/2/0/1/1 | 0 | 2014-11 – 2024-09 | limited evidence ; Ireland (ie) | 16 | 0.36% | 4.88 | 14/2/0/0/0 | 0 | 2016-10 – 2026-08 | limited evidence ; Ukraine (ua) | 16 | 0.36% | 4.06 | 10/2/1/1/2 | 1 | 2014-01 – 2025-07 | limited evidence ; Vietnam (vn) | 16 | 0.36% | 4.31 | 11/2/1/1/1 | 1 | 2014-07 – 2024-07 | limited evidence ; Denmark (dk) | 15 | 0.34% | 4.00 | 8/4/0/1/2 | 0 | 2016-03 – 2026-05 | limited evidence ; Norway (no) | 15 | 0.34% | 3.80 | 8/2/2/0/3 | 1 | 2014-02 – 2023-01 | limited evidence ; UAE (ae) | 14 | 0.32% | 4.57 | 11/2/0/0/1 | 0 | 2015-02 – 2026-01 | limited evidence ; Philippines (ph) | 14 | 0.32% | 4.29 | 9/3/0/1/1 | 0 | 2016-05 – 2025-05 | limited evidence ; Taiwan (tw) | 14 | 0.32% | 4.79 | 12/1/1/0/0 | 0 | 2014-01 – 2025-01 | limited evidence ; Indonesia (id) | 13 | 0.30% | 3.08 | 6/1/0/0/6 | 0 | 2014-10 – 2026-01 | limited evidence ; Saudi Arabia (sa) | 12 | 0.27% | 4.25 | 9/1/0/0/2 | 0 | 2016-11 – 2026-03 | limited evidence ; Austria (at) | 11 | 0.25% | 4.18 | 8/1/0/0/2 | 0 | 2015-10 – 2026-03 | limited evidence ; Argentina (ar) | 10 | 0.23% | 4.40 | 8/0/1/0/1 | 0 | 2014-10 – 2026-04 | limited evidence ; Portugal (pt) | 10 | 0.23% | 4.30 | 5/3/2/0/0 | 1 | 2016-01 – 2023-11 | limited evidence ; Belgium (be) | 9 | 0.20% | 4.44 | 7/1/0/0/1 | 0 | 2014-04 – 2025-09 | limited evidence ; Colombia (co) | 9 | 0.20% | 4.78 | 7/2/0/0/0 | 0 | 2014-01 – 2025-01 | limited evidence ; Hungary (hu) | 9 | 0.20% | 3.56 | 5/1/0/0/3 | 0 | 2014-02 – 2022-11 | limited evidence ; KZ (kz) | 9 | 0.20% | 4.33 | 6/2/0/0/1 | 1 | 2013-12 – 2024-01 | limited evidence ; Egypt (eg) | 7 | 0.16% | 4.00 | 4/1/1/0/1 | 0 | 2016-11 – 2023-04 | limited evidence ; Finland (fi) | 7 | 0.16% | 3.86 | 5/0/0/0/2 | 0 | 2015-06 – 2025-04 | limited evidence ; Romania (ro) | 7 | 0.16% | 4.29 | 5/1/0/0/1 | 0 | 2017-01 – 2023-09 | limited evidence ; SK (sk) | 7 | 0.16% | 3.71 | 4/1/0/0/2 | 0 | 2014-01 – 2022-07 | limited evidence ; Chile (cl) | 5 | 0.11% | 4.20 | 4/0/0/0/1 | 0 | 2017-03 – 2022-07 | limited evidence ; DO (do) | 5 | 0.11% | 5.00 | 5/0/0/0/0 | 0 | 2017-05 – 2026-06 | limited evidence ; Israel (il) | 5 | 0.11% | 4.20 | 4/0/0/0/1 | 0 | 2014-12 – 2026-02 | limited evidence ; Nigeria (ng) | 5 | 0.11% | 5.00 | 5/0/0/0/0 | 0 | 2016-02 – 2026-01 | limited evidence ; Peru (pe) | 5 | 0.11% | 4.40 | 3/1/1/0/0 | 0 | 2018-12 – 2026-05 | limited evidence ; Pakistan (pk) | 5 | 0.11% | 4.60 | 3/2/0/0/0 | 0 | 2017-05 – 2026-01 | limited evidence ; CR (cr) | 4 | 0.09% | 5.00 | 4/0/0/0/0 | 0 | 2017-02 – 2020-07 | limited evidence ; HR (hr) | 4 | 0.09% | 4.00 | 3/0/0/0/1 | 0 | 2015-01 – 2019-07 | limited evidence ; UY (uy) | 4 | 0.09% | 4.50 | 3/0/1/0/0 | 2 | 2017-07 – 2023-10 | limited evidence ; BG (bg) | 3 | 0.07% | 5.00 | 3/0/0/0/0 | 0 | 2016-04 – 2026-05 | limited evidence ; BY (by) | 3 | 0.07% | 3.67 | 2/0/0/0/1 | 2 | 2020-10 – 2025-04 | limited evidence ; EC (ec) | 3 | 0.07% | 3.67 | 2/0/0/0/1 | 0 | 2015-01 – 2020-12 | limited evidence ; Greece (gr) | 3 | 0.07% | 4.67 | 2/1/0/0/0 | 0 | 2016-07 – 2020-05 | limited evidence ; GT (gt) | 3 | 0.07% | 3.67 | 2/0/0/0/1 | 0 | 2014-01 – 2024-08 | limited evidence ; LT (lt) | 3 | 0.07% | 4.00 | 2/0/0/1/0 | 0 | 2014-12 – 2022-05 | limited evidence ; SI (si) | 3 | 0.07% | 5.00 | 3/0/0/0/0 | 1 | 2016-01 – 2018-10 | limited evidence ; AZ (az) | 2 | 0.05% | 5.00 | 2/0/0/0/0 | 0 | 2017-02 – 2020-11 | limited evidence ; CY (cy) | 2 | 0.05% | 5.00 | 2/0/0/0/0 | 0 | 2023-09 – 2024-01 | limited evidence ; EE (ee) | 2 | 0.05% | 4.50 | 1/1/0/0/0 | 0 | 2018-02 – 2019-09 | limited evidence ; IS (is) | 2 | 0.05% | 5.00 | 2/0/0/0/0 | 0 | 2018-04 – 2021-07 | limited evidence ; JM (jm) | 2 | 0.05% | 5.00 | 2/0/0/0/0 | 0 | 2017-05 – 2017-06 | limited evidence ; KE (ke) | 2 | 0.05% | 5.00 | 2/0/0/0/0 | 0 | 2021-07 – 2023-07 | limited evidence ; KW (kw) | 2 | 0.05% | 5.00 | 2/0/0/0/0 | 0 | 2018-01 – 2020-06 | limited evidence ; LV (lv) | 2 | 0.05% | 5.00 | 2/0/0/0/0 | 0 | 2015-10 – 2022-06 | limited evidence ; MN (mn) | 2 | 0.05% | 5.00 | 2/0/0/0/0 | 0 | 2018-08 – 2025-08 | limited evidence ; SN (sn) | 2 | 0.05% | 5.00 | 2/0/0/0/0 | 0 | 2018-10 – 2020-08 | limited evidence ; TN (tn) | 2 | 0.05% | 3.50 | 0/1/1/0/0 | 0 | 2017-10 – 2020-10 | limited evidence ; TT (tt) | 2 | 0.05% | 3.00 | 0/1/0/1/0 | 0 | 2014-05 – 2018-02 | limited evidence ; UG (ug) | 2 | 0.05% | 5.00 | 2/0/0/0/0 | 0 | 2019-12 – 2026-02 | limited evidence ; AO (ao) | 1 | 0.02% | 5.00 | 1/0/0/0/0 | 0 | 2026-02 – 2026-02 | limited evidence ; BN (bn) | 1 | 0.02% | 5.00 | 1/0/0/0/0 | 0 | 2019-07 – 2019-07 | limited evidence ; CD (cd) | 1 | 0.02% | 4.00 | 0/1/0/0/0 | 0 | 2026-03 – 2026-03 | limited evidence ; LB (lb) | 1 | 0.02% | 4.00 | 0/1/0/0/0 | 0 | 2019-01 – 2019-01 | limited evidence ; LK (lk) | 1 | 0.02% | 1.00 | 0/0/0/0/1 | 0 | 2014-05 – 2014-05 | limited evidence ; MD (md) | 1 | 0.02% | 1.00 | 0/0/0/0/1 | 0 | 2015-01 – 2015-01 | limited evidence ; ME (me) | 1 | 0.02% | 5.00 | 1/0/0/0/0 | 0 | 2020-12 – 2020-12 | limited evidence ; MT (mt) | 1 | 0.02% | 5.00 | 1/0/0/0/0 | 0 | 2014-08 – 2014-08 | limited evidence ; PY (py) | 1 | 0.02% | 5.00 | 1/0/0/0/0 | 0 | 2024-12 – 2024-12 | limited evidence ; QA (qa) | 1 | 0.02% | 5.00 | 1/0/0/0/0 | 0 | 2016-05 – 2016-05 | limited evidence ; SV (sv) | 1 | 0.02% | 4.00 | 0/1/0/0/0 | 0 | 2019-12 – 2019-12 | limited evidence ; UZ (uz) | 1 | 0.02% | 5.00 | 1/0/0/0/0 | 0 | 2018-12 – 2018-12 | limited evidence ; XK (xk) | 1 | 0.02% | 5.00 | 1/0/0/0/0 | 0 | 2026-02 – 2026-02 | limited evidence

- **Where:** §6.1 distribution table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 90 storefronts
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R48-066 — Eligible storefronts: US 2,485 (56.45%, mean 4.24, 104 payers), Canada 285 (4.16, 9), UK 261 (4.13, 17), Australia 124 (3.99, 2), Germany 119 (3.96, 6), Brazil 88 (4.59, 2), Russia 79 (4.14, 3), China 73 (4.08, 2), India 71 (4.42, 3); the other 81 storefronts hold 18.56% and are pooled

- **Where:** §6.1 eligible storefronts
- **This app does:** English-first, US-dominated distribution
- **User reaction:** n/a
- **Magnitude:** nine eligible
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R48-067 — The US is the global picture; where it differs: over-indexes on behaviour change (+1.5pp, 7.61%), accountability (+1.0), visual progress (+1.0), reminders, streaks, tracker flexibility; under-indexes on design (−1.1), low-information (−1.0) and price (−0.9) — 'American reviewers talk about outcomes and accountability more than anyone else, and about aesthetics less'; supply 104 of 172 payers (60.5%) and 71 of 105 churn statements; cap complaints 4.14%, below Canada — the cap grievance is not US-specific

- **Where:** §6.2 United States
- **This app does:** n/a
- **User reaction:** outcome- and accountability-focused
- **Magnitude:** 2,485 (56.45%)
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C134 Lead the store listing with what users actually love

### R48-068 — Canada is the most price-sensitive eligible storefront: price too high 27 (9.47%, +3.4pp) and free cap 19 (6.67%, +2.1pp); stated churn 3.86% and competitor-named reviews at mean 1.38★; praise normal-to-strong (simplicity 21.40%) — 'a pure packaging objection: Canadians like the app and resent the deal more than anyone else'; only 9 payers (3.16%)

- **Where:** §6.3 Canada
- **This app does:** n/a
- **User reaction:** like the app, resent the deal
- **Magnitude:** 285 (6.47%)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R48-069 — The UK is the most paid-engaged storefront: 17 payers, 6.51% of its reviews vs 3.91% globally; over-indexes on simplicity (22.22%), tracker flexibility (13.79%), best of many (13.03%), dev listens (4.21%) and long-term users (4.98%); yet price too high 8.81% (+2.8pp) and free-cap reviews average 1.73★ — 'an engaged, paying, long-tenured base that is nonetheless vocal about price — the most valuable cohort to protect'

- **Where:** §6.4 United Kingdom
- **This app does:** n/a
- **User reaction:** paying and vocal about price
- **Magnitude:** 261 (5.93%)
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R48-070 — Australia is the lowest-rated eligible storefront (3.99): the highest dev-listens rate anywhere (6.45%, +4.1pp), bad-habit tracking +3.3pp, fitness 4.84%; against that price 9.68% (+3.6pp), crash / won't open 6.45%, competitor named 4.84% at 1.83★, data loss 3.23% — 'both the most developer-appreciative reviewers and the most competitor-aware ones'

- **Where:** §6.5 Australia
- **This app does:** n/a
- **User reaction:** appreciative and competitor-aware
- **Magnitude:** 124 (2.82%)
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R48-071 — Germany contests the terms, not the utility: forced account signup 6 (5.04%, +4.2pp — the strongest over-index of any theme in any eligible storefront), subscription objection 4.20% (+3.1pp), price 10.92% (+4.9pp); one 2016 review invokes German consumer law over the forced-sync conversion; also over-indexes on design (8.40%) and support (5.04%)

- **Where:** §6.6 Germany
- **This app does:** n/a
- **User reaction:** privacy and model objections
- **Magnitude:** 119 (2.70%)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `1314723695`
- **Canonical:** C035 Account system from day one; C096 Privacy and discretion stack; C209 No sign-up wall before first use

### R48-072 — Brazil (88, 4.59) is the highest-rated and least analytical — generic positive 34.09% (+14.6pp), low-information 21.59%, best-of-many 19.32% (+9.0pp) is real signal; Russia (79, 4.14) — no localization 10.13% (+9.2pp), Russian-language requests 2013–17 the clearest localization signal in the corpus; China (73, 4.08) — the sharpest split: no localization 12.33% and crash / won't open 12.33% (+8.1pp) against simplicity at mean 5.00★, a 2022 review celebrates Chinese localization arriving, price 10.96% with a lifetime plan priced near a quarter of a second-hand iPhone; India (71, 4.42) — tracker flexibility 16.90% (+5.9pp), free tier enough 7.04%, sensitive to the 2020 freeze bug (4.23%)

- **Where:** §6.7 Brazil, Russia, China, India
- **This app does:** n/a
- **User reaction:** localization asks in RU / CN; cost-of-living framing in CN
- **Magnitude:** 88 / 79 / 73 / 71
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `8249750576`, `4715636334`
- **Canonical:** C027 Localise early — it unlocks revenue; C092 Regional pricing; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R48-073 — High-spend group (US, JP, GB, DE, CA, AU, FR, KR, CN; 3,425, 77.81%, mean 4.21 vs rest 4.29): price too high 218 (6.36%) vs 48 (4.91%); want one-time 50 (1.46%) vs 8 (0.82%); paid-then-subscription 65 (1.90%) vs 5 (0.51%); free cap 149 (4.35%) vs 50 (5.12%); tracker flexibility 401 (11.71%) vs 84 (8.60%); support responsive 115 (3.36%) vs 12 (1.23%); no localization 18 (0.53%) vs 21 (2.15%); payers 142 (4.15%) vs 30 (3.07%) — high-spend markets contain 82.6% of identified payers, complain about price and the model more and about the cap less; rest-of-world is four times more likely to raise localization

- **Where:** §6.8 high-spend group table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 3,425 vs 977
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R48-074 — High-review-volume group (US, CA, GB, AU, DE, BR, RU, CN, IN; 3,585, 81.44%, mean 4.22; payers 4.13% vs 2.94%) — a review-volume proxy, not downloads; swapping in BR, RU, IN for JP, KR, FR raises localization complaints to 2.33% vs 0.56% and contributes fewer payers; Japan (18, 4.33) and Korea (24, 4.54) are absent from the eligible set despite being high-spend — a genuine distribution gap, not a sentiment problem, unlike other apps in this series where those storefronts dominate

- **Where:** §6.9 high-review-volume group
- **This app does:** no Japan / Korea presence
- **User reaction:** n/a
- **Magnitude:** JP 18, KR 24
- **Direction for us:** none · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R48-075 — Global vs country (simplicity / flexibility / behaviour change / price / cap / crash / localization / payers): global 18.56 / 11.02 / 6.07 / 6.04 / 4.52 / 4.20 / 0.89 / 3.91; US 18.39 / 11.67 / 7.61 / 5.19 / 4.14 / 3.90 / — / 4.19; CA 21.40 / 10.18 / 3.86 / 9.47 / 6.67 / 3.51 / — / 3.16; GB 22.22 / 13.79 / 7.66 / 8.81 / 4.21 / 4.21 / — / 6.51; AU 22.58 / 14.52 / 4.03 / 9.68 / 4.84 / 6.45 / — / 1.61; DE 21.01 / 13.45 / — / 10.92 / 4.20 / 6.72 / — / 5.04; BR 13.64 / 6.82 / 2.27 / 4.55 / 5.68 / — / 2.27 / 2.27; RU 6.33 / 8.86 / 6.33 / 6.33 / 2.53 / 6.33 / 10.13 / 3.80; CN 17.81 / 9.59 / — / 10.96 / — / 12.33 / 12.33 / 2.74; IN 15.49 / 16.90 / 5.63 / 2.82 / — / 5.63 / — / 4.23 — 'Praise is remarkably uniform; grievance is local': price sensitivity clusters in CA / AU / DE / CN and localization in RU / CN

- **Where:** §6.10 global vs country table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** nine storefronts
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R48-076 — Sub-50 storefronts (81, 817 reviews, 18.56%) carry no standalone claims; limited evidence: Indonesia (13, mean 3.08) is the lowest-rated with n > 10, driven by two long multilingual 1★ reviews about sync failure and ignored feedback; Ireland (16, 4.88), Taiwan (14, 4.79), Malaysia (19, 4.58) sit at the top

- **Where:** §6.11 sub-50 storefronts
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 817 pooled
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `11112816965`, `11918628097`
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

## Dated events and trends

### R48-006 — The January 2015 v3.0 conversion from a paid app to a $4.99/month subscription requiring an account produced the deepest collapse in any corpus in this ledger: the nine months that followed (E2, n = 308) averaged 2.21★ with 68.2% at 1–2★; February 2015 alone ran 1.66★ with 83.9% 1–2★; 92 reviews describe a broken bargain — they had bought the app and were now asked to rent it (paid-then-subscription 60; grandfather promise broken 14; forced account signup 25); the developer reversed course and from October 2015 (E3) the mean jumped to 4.62★ with monetisation friction down to 7.8% — 'The recovery is as clear as the crash. Both are in the same 12 months'

- **Where:** §Executive summary 1
- **This app does:** paid app → subscription + account in Jan 2015; reversed to freemium Oct 2015
- **User reaction:** 2.21★ for nine months; 1.66★ in Feb 2015
- **Magnitude:** 308 reviews at 68.2% 1–2★; 92 broken-bargain reviews
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C035 Account system from day one; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature; C104 Never ship a paywall or feature-removal change silently; C186 Never revoke what earlier buyers paid for when the model changes

### R48-014 — Yearly means: 2013 3.78 (46) · 2014 3.78 (296) · 2015 2.53 (366, 60.1% 1–2★) · 2016 4.63 (573) · 2017 4.62 (595) · 2018 4.65 (716, peak) · 2019 4.44 (329) · 2020 4.18 (377) · 2021 4.06 (273, 21.6% 1–2★) · 2022 4.22 (208) · 2023 4.28 (206) · 2024 4.25 (203) · 2025 4.01 (138) · 2026 4.43 (76 to 4 Sep); volume declining since 2018, reducing statistical power for recent findings; body median 117 characters; 382 bodies of 20 characters or fewer

- **Where:** §1.4 yearly table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 4,402
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `840926526`, `14509426891`, `11001358061`, `1647723891`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R48-078 — The 2015 collapse at monthly resolution: Dec 2014 2.31 (13) · Jan 2015 2.50 (125; 14 paid-then-sub, 14 price, 13 forced account, 52 crash) · Feb 1.66 (56, 83.9% 1–2★) · Mar 2.46 · Apr 2.10 · Jun 2.08 · Sep 2.10 · Oct 2015 4.14 (19.0% 1–2★) · Dec 4.37; the 19 Jan – 30 Sep window (n = 272) ran mean 2.06★ with 73.2% 1–2★; two failures compounded — the commercial change (60 paid-then-subscription, 25 forced account, 14 grandfather broken) and a simultaneously broken release (81 crash-on-launch, 25 data loss, 20 duplicate trackers): 'they were asked to start paying for an app that had just stopped working'; the recovery in October 2015 is equally abrupt and coincides with reviews announcing a free unlimited tier — 'I was very upset when I realised I could no longer access my data unless I paid… I appreciate the ability to continue using the app for free'

- **Where:** §7.2 trend 1 monthly table
- **This app does:** subscription + broken release in the same month; reversal nine months later
- **User reaction:** collapse then thanks for reversing
- **Magnitude:** 272 reviews at 2.06★
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `1273838707`, `1274461925`, `1274551764`
- **Canonical:** C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature; C104 Never ship a paywall or feature-removal change silently; C186 Never revoke what earlier buyers paid for when the model changes

### R48-079 — Free cap too low by era 0.00% → 0.32% → 1.59% → 7.00% → 9.87%, 12.1% in the last 24 months — no other negative theme is still climbing; the reported cap falls over time — 10 (2016–18), 7 (2018–19), 5–6 (2019–20), 3 (2020–26), a handful claiming 2 or 1 — and complaints move with it; cap reduced (23, mean 2.22★) is the most damaging variant — users who deleted a tracker to make room found the slot gone; 'free is enough' falls 7.82% of E3 → 4.81% of E5 — as the free tier shrank, satisfaction fell and complaints rose roughly in proportion

- **Where:** §7.3 trend 2 free cap rising
- **This app does:** cap tightened 10 → 7 → 5–6 → 3 over eight years
- **User reaction:** complaints track the cap
- **Magnitude:** 9.87% of E5; 12.1% of last 24 months
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C219 A free cap must be concurrent, never lifetime — deleting a habit frees a slot

### R48-080 — Price too high 0.58% (E1) → 21.43% (E2) → 4.89% → 6.15% → 4.69% (E5); paid-then-subscription effectively extinct after 2016 — 'pricing anger has migrated from "too expensive" to "I can't try it"'

- **Where:** §7.4 trend 3 price fell
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 4.69% of E5
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R48-081 — Crash union 76 (E1, 22.2%) → 115 (E2, 37.3%) → 31 (E3, 1.9%) → 52 (E4, 4.0%) → 24 (E5, 2.9%); reliability family 52.6% of E2 → 8.3% of E5; two residual pockets — a 2020 iOS 13 / 14-era freeze (25 reviews in E4, many storefronts) that then vanished, and sync failure that never improves (11 / 12 / 12 / 13 across E2–E5), now the most common reliability complaint

- **Where:** §7.5 trend 4 reliability fixed
- **This app does:** fixed crashes; sync flat
- **User reaction:** n/a
- **Magnitude:** 24 crash in E5; sync 13
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `5945320813`, `6081780984`, `6121865161`, `6282256453`, `6358108341`, `6534730756`, `13458071780`, `14042521389`, `11165592973`
- **Canonical:** C030 Sync must work — and prove it; C031 Crashes / launch failures

### R48-085 — Platform expansion landed well: multi-platform sync praise recovers 0.78% (E4) → 3.13% (E5) and Health / Shortcuts praise rises 0 → 0.31% → 1.56%, tracking the Mac app (Mar 2022), Apple Health automation, Siri Shortcuts and the Watch app (1.08% of E5); against that 17 still want the discontinued web app back or an Android build (rising to 0.84% of E5) — Windows users in particular lost access

- **Where:** §7.9 trend 8 platform expansion
- **This app does:** Mac app, Health, Shortcuts, Watch; web app discontinued
- **User reaction:** praised; web-app loss still felt
- **Magnitude:** 3.13% / 1.56% of E5
- **Direction for us:** positive · **Report confidence:** medium-high · **Generalisable:** general
- **Review IDs:** `8407086509`, `8409343866`, `9053449079`, `9541417489`, `10212102204`, `11416073129`, `12482915746`, `12544429258`
- **Canonical:** C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C155 Never remove a feature people bought the app for — add alongside, do not replace

## Positioning

### R48-001 — Strides: Habit Tracker + Goals (App Store ID 672401817; subtitle 'Goal Planner & Daily Checklist') by Goals LLC (bundle com.puresignal.strides) — 4,402 written App Store reviews across 90 storefronts, 22 July 2013 – 4 September 2026, extracted 2026-09-08, analysed 12 September 2026

- **Where:** header lines 1-8
- **This app does:** an eleven-year-old habit + goal tracker
- **User reaction:** mixed
- **Magnitude:** 4,402 reviews
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R48-035 — Explicit competitive benchmarking, often naming rivals, sustained across eras (203 in E3, 132 in E4, 80 in E5); when these reviewers name what won it is almost always tracker flexibility plus simplicity

- **Where:** §3.3.3 best of the many I tried
- **This app does:** flexibility + simplicity
- **User reaction:** chose it over named rivals
- **Magnitude:** 453 (10.29%, 4.89★)
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `954271910`, `1002953773`, `2540082589`, `6442694958`, `12143126487`, `14210458077`
- **Canonical:** C005 Know which competitors buyers compare against

### R48-064 — Reviewers who benchmark (453 best-of-many plus 105 competitor-named) describe a consistent trade: wins on tracking flexibility, loses on price model — 'free version is useless which limits to only 7 habits… I eventually settled with Habitify which costs one time $10 and has comparable features'; 'The corpus contains no evidence of a capability gap that is losing users. It contains repeated evidence of a packaging gap that is'

- **Where:** §5.6 competitive position
- **This app does:** flexibility vs subscription + cap
- **User reaction:** leave over packaging
- **Magnitude:** 558 benchmarkers
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `3017109535`, `4220820733`
- **Canonical:** C005 Know which competitors buyers compare against; C133 Gate on capability, not on quantity

## Anti-patterns

### R48-012 — The 2021 logging redesign is the one self-inflicted UX wound that persists: a mid-2021 change to history logging drew 10 reviews in three months complaining it took several times as many taps (ux_too_many_taps peaks at 1.09% of E4), from long-term users and payers, mean 3.86★ in that window; partially rolled back after user pressure — one reviewer documents the developer restoring the behaviour — but it cost ratings from the most loyal cohort

- **Where:** §Executive summary 7
- **This app does:** history-logging redesign adding taps (mid-2021), partly rolled back
- **User reaction:** loyal users and payers objected
- **Magnitude:** 10 reviews in three months
- **Direction for us:** negative · **Report confidence:** medium-high · **Generalisable:** general
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R48-042 — The 2015 conversion union (paid-then-subscription 70, forced account signup 39, grandfather broken 14) is 115 reviews (2.61%, mean 1.57★), 92 of them in E2 and essentially extinct after 2016 (3 in E5, all users returning after years away); the angriest texts in the corpus — 'bait and switch', 'SCAM', 'Rent what you've paid for'; 25 object specifically to being forced to create an account and go online for a local tracker — a privacy objection distinct from price

- **Where:** §3.4.3 2015 subscription conversion
- **This app does:** paid app converted to subscription + mandatory account, grandfathering promise not honoured
- **User reaction:** bait and switch; scam; rent what you paid for
- **Magnitude:** 115 (2.61%, 1.57★); 92 in E2
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `1190739692`, `1217176354`, `1256067864`, `1252178949`, `1136681651`, `1540297507`, `2113118458`
- **Canonical:** C035 Account system from day one; C096 Privacy and discretion stack; C104 Never ship a paywall or feature-removal change silently; C186 Never revoke what earlier buyers paid for when the model changes; C209 No sign-up wall before first use

### R48-082 — May–August 2021 (n = 78, mean 3.86★, 28.2% 1–2★): ten reviews complain a redesign of history logging multiplied the taps to back-fill days ('Latest update forces you to double click for every single activity'; 'turning a 10 second daily update to about 60', 2025) — disproportionately long-term users (7 of 78) and payers (6); the developer restored one-click behaviour in charts and the reinstatement is described explicitly; too many taps falls to 0.24% in E5 — 'the standing lesson is that log-entry friction is uniquely expensive for this product'

- **Where:** §7.6 trend 5 2021 logging redesign
- **This app does:** logging redesign added taps; rolled back
- **User reaction:** loyal payers objected; welcomed reversal
- **Magnitude:** 10 in three months; 3.86★ window
- **Direction for us:** negative · **Report confidence:** medium-high · **Generalisable:** general
- **Review IDs:** `7382413590`, `7390981774`, `7397956611`, `7412691840`, `7447645065`, `7585378241`, `7623220041`, `13025306978`, `7521539649`, `7540012549`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C229 A deliberate completion gesture — press-and-hold with haptic and sound, not a bare tap; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R48-083 — Upsell nag is 13 reviews total but 6 arrived in the three months from July 2024 — a full-screen or post-log upgrade prompt that did not previously exist; long-term free users state the nag reduced their willingness to pay: 'I might even consider paying money for the app. But I darn sure will not… as long as the nag screen is still in place'; one reports it was subsequently softened (updated to 4★) — 'the only monetization mechanic in the corpus that users say actively reduced their intent to pay'

- **Where:** §7.7 trend 6 upgrade nag 2024
- **This app does:** post-log full-screen upgrade prompt (Jul 2024), later softened
- **User reaction:** reduced intent to pay
- **Magnitude:** 6 in three months (medium confidence, small n)
- **Direction for us:** negative · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `11486930156`, `11606910612`, `11624276095`, `11652177792`, `11720024657`, `11757185028`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

## Things not to do

### R48-094 — Remove or soften the post-log upgrade prompt: 6 of 13 nag reviews arrived in three months of 2024 stating it reduced willingness to pay; one records it being softened and raised their rating — 'no evidence the prompt converted anyone and direct evidence it repelled people'

- **Where:** Part 8 #8 — §8.2 change 8 remove the post-log upgrade prompt
- **This app does:** post-log upgrade prompt
- **User reaction:** repelled would-be payers
- **Magnitude:** 6 in three months
- **Direction for us:** negative · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `11757185028`, `11624276095`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

### R48-099 — Do not redesign the interface for novelty: 62 call the UI dated and 14 explicitly praise its plainness ('does not include "cute" graphics'); the dated-UI complaint is real but small and stable (1.68% of E5) — the tap-count lesson is the larger risk

- **Where:** §8.3 do not redesign for novelty
- **This app does:** plain, dated UI
- **User reaction:** some want modern; loyal users want plain
- **Magnitude:** 62 vs 14
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `6670709795`
- **Canonical:** C057 Offer a non-pastel / premium design option; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

## Things to do

### R48-100 — Do not lose the support culture: 127 praise it, many by name; it demonstrably converts 1★ reviewers into 5★ reviewers

- **Where:** §8.3 do not lose the support culture
- **This app does:** founder-led support
- **User reaction:** 1★ → 5★ after contact
- **Magnitude:** 127
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `1811801602`, `2858976575`, `7540012549`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

## Contradictions

### R48-105 — The free-tier limit is contested inside the corpus: reviewers claim 10, 8, 7, 6, 5, 4, 3, 2 and 1 free trackers, sometimes in the same month, while the listing (12 Sep 2026) states 3; a reviewer and the developer disagree in-thread over whether notes are free; the report resolves only the direction (tightening) and lists the current number as a research question

- **Where:** §2.2 free tier; §2.3; §8.5 Q1
- **This app does:** 3 trackers per the listing; reviewer-reported numbers vary
- **User reaction:** confusion about what is free
- **Magnitude:** 199 cap reviews with inconsistent numbers
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `1647723891`, `2957558274`
- **Canonical:** C172 Per-day / per-habit notes and journal text; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R48-106 — Three tensions the report holds open: two reviewers propose ads instead of the paywall while 33 praise having none and zero complain — read as hostility to the cap, not endorsement of ads; 62 call the UI dated while 14 explicitly praise its plainness; and the 2015 reversal that reviewers thanked the developer for (free unlimited tier, Oct 2015) is the same free tier that was then tightened 10 → 7 → 3 over the following eight years and became the only growing grievance

- **Where:** §2.2 ads; §8.3 dated UI; §7.2 vs §3.4.3
- **This app does:** no ads; plain UI; a generous tier later withdrawn
- **User reaction:** split opinions
- **Magnitude:** 2 vs 33; 62 vs 14
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `8005170579`, `7555174284`, `6670709795`, `1273838707`
- **Canonical:** C057 Offer a non-pastel / premium design option; C082 Ads in the free tier; C186 Never revoke what earlier buyers paid for when the model changes

## Data caveats and method

### R48-002 — Method: all 4,402 records read individually in full in the original language (29 languages listed), hand-curated 117-theme taxonomy in 11 families keyed by working-file index and resolved deterministically to review_id, validated (0 unknown IDs, 0 duplicates, 0 unassigned, 8,804 assignments, mean 2.00 per review), tables generated mechanically, build refuses to write on any unfilled placeholder or failed count check, post-write verification that every cited ID exists; reconciliation exact against by_country/*.jsonl, manifest.json (4,402; 90 storefronts; rating distribution 3057/450/214/197/484; mean 4.226) and _state.json (145 storefronts complete, 55 empty); no deduplication (two near-identical pairs flagged, effect < 0.07pp); themes non-exclusive; denominators always stated; signal thresholds per the analysis prompt; author never reported; HTML entities unescaped for reading only; prices are reviewer claims; storefront ≠ nationality; dates are publication dates; sub-50 storefronts carry no standalone claims

- **Where:** §How to read this; §1.1-1.3, 1.5, 1.6
- **This app does:** written-review corpus of the vocal 23% (4,402 written vs ~19,000 ratings)
- **User reaction:** n/a
- **Magnitude:** 4,402 (100%)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `10499805369`, `10499821074`, `12631350374`, `12631366285`
- **Canonical:** — (nuance register)

### R48-003 — A written-review corpus of the strongly pleased and strongly aggrieved: 4.23★ written mean vs 4.8★ from ~19,000 ratings; 59% of reviews (2,592) predate 2019, so the 2015 subscription crisis dominates the negative history but describes a product and price that no longer exist; the last 24 months (Oct 2024 – Sep 2026) hold only 256 reviews (5.8%), so every current-state claim rests on that slice; the US is 56.45% (2,485) and nine storefronts clear the 50-review bar

- **Where:** §Nine warnings 1-4
- **This app does:** eleven-year corpus with thin recency
- **User reaction:** n/a
- **Magnitude:** 2,592 pre-2019; 256 in last 24 months
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R48-004 — No review states a verifiable price paid ($4.99/mo, $29.99–$79.99/yr, $49.99–$149.99 lifetime quoted across 11 years); payer identification is self-reported — 172 reviews (3.91%) are a floor on paid reviewers and support no conversion estimate; free-tier cap numbers are inconsistent across reviewers (10, 8, 7, 6, 5, 4, 3, 2 and 1 claimed, sometimes in the same month) so only the tightening direction is evidenced; 416 reviews (9.45%) contain no product content and are counted, never mined; 54 reviews rated 1–2★ contain genuine praise and 37 contradict their own star rating (meta_rating_text_mismatch) — disclosed, not dropped

- **Where:** §Nine warnings 5-9
- **This app does:** inconsistent reviewer-reported cap and prices
- **User reaction:** n/a
- **Magnitude:** 172 payers; 416 empty; 37 mismatches
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R48-016 — 3 reviews mention being asked to review and 2 complain the prompt appears too early (ux_review_prompt_nag 7 total; a prompt existed 2013–15 and around 2021); no burst or brigading pattern — the January 2015 spike spans 20 storefronts with unrelated texts tracking a documented version change; only 314 reviews (7.1%) carry any vote (max 36), votes not used to weight; 42 edited reviews, several visibly rewritten after developer contact, classified on final text

- **Where:** §1.6 prompted reviews / bursts / edits
- **This app does:** in-app review prompt, light
- **User reaction:** n/a
- **Magnitude:** 7 prompt complaints; 42 edited
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `1811801602`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R48-017 — Capability | What reviewers say it does | Evidence (reviews) ; Four tracker types — Habit (yes/no), Target (a number by a date), Average (rolling mean), Project (milestones, %) | The defining feature. "Not just the binary yes/no of traditional habit apps" | 485 praise cp_flexible_tracker_types; 917379605 1370794562 1891448103 11461372218 13646840535 ; Bad-habit / "less is better" tracking | Track a limit, not a goal; red/green inverts | 105 praise cp_bad_habit_tracking; 6553635234 (quit smoking, benchmarked 10+ rivals) ; Streaks and goal streaks | Configurable streak targets; "don't break the chain" | 144 cp_streak_motivation; 11672096169 (507-day streak), 13989739905 (1,000 consecutive days, 3,497 tracked) ; Multiple custom reminders per tracker, with user-written text | Several alerts/day; the message is the reviewer's own words | 224 cp_reminders; 3092522796 3026979984 ; Dashboard, charts, calendar, pace line | Progress bars, monthly calendar, "where you should be today" | 241 cp_visual_progress; 56 cp_goal_pacing ; Notes on each log | Per-entry journalling | 14 request, some praise cp_notes_journal ; Tags / filters / Today list | Grouping and filtering (premium) | 26 request fr_tags_categories ; Reports / trends | Added over time; still the top open request | 76 fr_better_reports ; Apple Watch app and complication | Praised when working, faulted when blank | 24 cp_watch_app; 12 rel_watch_bug; 5 fr_watch_complication ; Home-screen / lock-screen widgets | Arrived ~2020; interactivity later removed | 12 cp_widget; 20 fr_widget; 14 rel_widget_bug ; Apple Health integration and Siri Shortcuts | Auto-log steps/weight; voice logging | 17 cp_health_shortcuts; 3 rel_health_sync_bug ; Mac app (from ~March 2022) | Syncs with iOS; welcomed by long-term users | 8407086509 8409343866 9053449079 ; Web app (2015 – ~2019, discontinued) | Once a headline feature; its removal is still resented | 69 cp_multi_platform_sync; 17 fr_web_or_other_platform ; CSV export | Premium; praised and occasionally broken | 16 fr_backup_export; 4 rel_export_bug ; Goal-setting course / handbook | Free companion content, repeatedly credited | 27 seg_book_or_course; 12948472060 14500682632 ; iCloud sync across devices | Replaced the account-based sync of 2015 | 48 rel_sync_fail when it misbehaves

- **Where:** §2.1 feature inventory table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** n/a
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `917379605`, `1370794562`, `1891448103`, `11461372218`, `13646840535`, `6553635234`, `11672096169`, `13989739905`, `3092522796`, `3026979984`, `8407086509`, `8409343866`, `9053449079`, `12948472060`, `14500682632`
- **Canonical:** — (nuance register)

### R48-026 — Master theme table, denominator 4,402, with mean, US n, first–last year and signal: # | Theme | Family | Dir | n | % of 4,402 | Mean ★ | US n | First–last | Signal ; 1 | cp_generic_positive | Core praise | pos | 858 | 19.49% | 4.90 | 427 | 2013–2026 | high-priority ; 2 | cp_simplicity | Core praise | pos | 817 | 18.56% | 4.84 | 457 | 2013–2026 | high-priority ; 3 | cp_flexible_tracker_types | Core praise | pos | 485 | 11.02% | 4.82 | 290 | 2013–2026 | high-priority ; 4 | cp_best_of_many | Core praise | pos | 453 | 10.29% | 4.89 | 240 | 2013–2026 | high-priority ; 5 | meta_low_information | Meta | — | 416 | 9.45% | 4.85 | 211 | 2014–2026 | high-priority ; 6 | cp_behaviour_change | Core praise | pos | 267 | 6.07% | 4.95 | 189 | 2013–2026 | high-priority ; 7 | mf_price_too_high | Monetization friction | neg | 266 | 6.04% | 2.74 | 129 | 2013–2026 | high-priority ; 8 | mp_free_enough | Monetization praise | pos | 248 | 5.63% | 4.82 | 140 | 2015–2026 | high-priority ; 9 | cp_visual_progress | Core praise | pos | 241 | 5.47% | 4.86 | 160 | 2013–2026 | high-priority ; 10 | cp_reminders | Core praise | pos | 224 | 5.09% | 4.87 | 146 | 2013–2026 | high-priority ; 11 | cp_design_aesthetic | Core praise | pos | 212 | 4.82% | 4.57 | 92 | 2013–2026 | very strong ; 12 | mf_free_cap_too_low | Monetization friction | neg | 199 | 4.52% | 2.65 | 103 | 2015–2026 | very strong ; 13 | rel_crash_wont_open | Reliability | neg | 185 | 4.20% | 1.88 | 97 | 2013–2025 | very strong ; 14 | cp_customization | Core praise | pos | 167 | 3.79% | 4.87 | 105 | 2013–2026 | very strong ; 15 | mp_paid_premium | Purchase evidence | — | 149 | 3.38% | 3.83 | 91 | 2014–2026 | very strong ; 16 | cp_streak_motivation | Core praise | pos | 144 | 3.27% | 4.96 | 99 | 2014–2026 | very strong ; 17 | seg_long_term_user | Segments | — | 137 | 3.11% | 4.50 | 83 | 2015–2026 | very strong ; 18 | cp_support_responsive | Core praise | pos | 127 | 2.89% | 4.89 | 84 | 2013–2026 | meaningful ; 19 | ux_confusing_setup | UX friction | neg | 118 | 2.68% | 3.11 | 72 | 2013–2026 | meaningful ; 20 | cp_accountability | Core praise | pos | 110 | 2.50% | 4.92 | 88 | 2013–2026 | meaningful ; 21 | cp_bad_habit_tracking | Core praise | pos | 105 | 2.39% | 4.81 | 61 | 2014–2026 | meaningful ; 22 | neg_competitor_named | Product-value criticism | neg | 105 | 2.39% | 3.16 | 68 | 2013–2026 | meaningful ; 23 | neg_stated_churn | Product-value criticism | neg | 105 | 2.39% | 1.79 | 71 | 2013–2026 | meaningful ; 24 | cp_dev_listens | Core praise | pos | 103 | 2.34% | 4.80 | 65 | 2014–2026 | meaningful ; 25 | seg_fitness_weight | Segments | — | 95 | 2.16% | 4.87 | 66 | 2013–2026 | meaningful ; 26 | rel_wrong_counts_stats | Reliability | neg | 85 | 1.93% | 2.59 | 64 | 2013–2025 | meaningful ; 27 | rel_crash_on_action | Reliability | neg | 82 | 1.86% | 2.62 | 48 | 2013–2026 | meaningful ; 28 | rel_notification_bug | Reliability | neg | 78 | 1.77% | 2.64 | 45 | 2013–2025 | meaningful ; 29 | fr_better_reports | Feature gaps & requests | req | 76 | 1.73% | 4.07 | 42 | 2013–2026 | meaningful ; 30 | mp_worth_the_price | Monetization praise | pos | 73 | 1.66% | 4.97 | 45 | 2014–2026 | meaningful ; 31 | mf_paid_then_subscription | Monetization friction | neg | 70 | 1.59% | 1.51 | 43 | 2014–2026 | meaningful ; 32 | cp_multi_platform_sync | Core praise | pos | 69 | 1.57% | 4.93 | 33 | 2015–2025 | meaningful ; 33 | ux_dated_ui | UX friction | neg | 62 | 1.41% | 3.63 | 26 | 2014–2026 | meaningful ; 34 | neg_not_worth_it | Product-value criticism | neg | 61 | 1.39% | 1.61 | 40 | 2013–2026 | meaningful ; 35 | mf_want_one_time_purchase | Monetization friction | neg | 58 | 1.32% | 2.83 | 36 | 2015–2025 | meaningful ; 36 | rel_data_loss | Reliability | neg | 58 | 1.32% | 1.67 | 37 | 2014–2025 | meaningful ; 37 | cp_project_milestones | Core praise | pos | 56 | 1.27% | 4.48 | 39 | 2015–2026 | meaningful ; 38 | sup_fix_acknowledged | Support | pos | 55 | 1.25% | 4.78 | 42 | 2013–2026 | meaningful ; 39 | mf_paywall_not_disclosed | Monetization friction | neg | 48 | 1.09% | 1.65 | 28 | 2015–2025 | meaningful ; 40 | mf_subscription_objection | Monetization friction | neg | 48 | 1.09% | 2.04 | 26 | 2015–2025 | meaningful ; 41 | rel_sync_fail | Reliability | neg | 48 | 1.09% | 2.65 | 28 | 2015–2026 | meaningful ; 42 | mp_willing_to_pay | Monetization praise | pos | 43 | 0.98% | 4.12 | 20 | 2015–2026 | emerging ; 43 | seg_finance | Segments | — | 43 | 0.98% | 4.72 | 28 | 2013–2026 | emerging ; 44 | rel_frozen_unresponsive | Reliability | neg | 41 | 0.93% | 2.22 | 18 | 2013–2025 | emerging ; 45 | cp_non_punitive | Core praise | pos | 39 | 0.89% | 4.90 | 34 | 2016–2025 | emerging ; 46 | mf_forced_account_signup | Monetization friction | neg | 39 | 0.89% | 1.64 | 24 | 2015–2018 | emerging ; 47 | ux_no_localization | UX friction | neg | 39 | 0.89% | 3.79 | 1 | 2013–2026 | emerging ; 48 | meta_rating_text_mismatch | Meta | — | 37 | 0.84% | 3.86 | 16 | 2014–2025 | emerging ; 49 | fr_flexible_frequency | Feature gaps & requests | req | 35 | 0.80% | 3.97 | 18 | 2014–2025 | emerging ; 50 | seg_business_sales | Segments | — | 34 | 0.77% | 4.79 | 24 | 2013–2026 | emerging ; 51 | cp_goal_pacing | Core praise | pos | 33 | 0.75% | 4.97 | 23 | 2013–2026 | emerging ; 52 | cp_no_ads | Core praise | pos | 33 | 0.75% | 4.85 | 20 | 2016–2025 | emerging ; 53 | rel_duplicate_entries | Reliability | neg | 32 | 0.73% | 2.31 | 18 | 2014–2024 | emerging ; 54 | ux_cant_edit_delete_log | UX friction | neg | 32 | 0.73% | 3.22 | 19 | 2013–2024 | emerging ; 55 | ux_too_many_taps | UX friction | neg | 31 | 0.70% | 3.16 | 17 | 2013–2026 | emerging ; 56 | seg_book_or_course | Segments | — | 29 | 0.66% | 4.93 | 14 | 2014–2026 | emerging ; 57 | sup_no_response | Support | neg | 29 | 0.66% | 1.55 | 15 | 2014–2024 | emerging ; 58 | mf_lifetime_price_too_high | Monetization friction | neg | 28 | 0.64% | 2.46 | 6 | 2019–2025 | emerging ; 59 | rel_slow_lag | Reliability | neg | 27 | 0.61% | 2.26 | 15 | 2014–2025 | emerging ; 60 | fr_tags_categories | Feature gaps & requests | req | 26 | 0.59% | 4.12 | 13 | 2014–2025 | emerging ; 61 | mf_trial_terms | Monetization friction | neg | 26 | 0.59% | 1.65 | 14 | 2015–2026 | emerging ; 62 | rel_log_not_registering | Reliability | neg | 26 | 0.59% | 2.62 | 15 | 2014–2026 | emerging ; 63 | rel_timezone_date_bug | Reliability | neg | 26 | 0.59% | 3.35 | 13 | 2014–2022 | emerging ; 64 | cp_watch_app | Core praise | pos | 24 | 0.55% | 4.67 | 15 | 2018–2025 | emerging ; 65 | seg_health_medical | Segments | — | 24 | 0.55% | 4.62 | 19 | 2014–2024 | emerging ; 66 | seg_student | Segments | — | 24 | 0.55% | 4.58 | 16 | 2014–2026 | emerging ; 67 | fr_end_date_archive | Feature gaps & requests | req | 23 | 0.52% | 4.09 | 12 | 2014–2026 | emerging ; 68 | mf_billing_problem | Monetization friction | neg | 23 | 0.52% | 2.52 | 12 | 2015–2026 | emerging ; 69 | mf_free_cap_reduced | Monetization friction | neg | 23 | 0.52% | 2.22 | 15 | 2016–2025 | emerging ; 70 | mf_refund_request | Monetization friction | neg | 23 | 0.52% | 1.04 | 13 | 2014–2026 | emerging ; 71 | mp_paid_lifetime | Purchase evidence | — | 23 | 0.52% | 4.52 | 13 | 2019–2026 | emerging ; 72 | seg_mental_health | Segments | — | 23 | 0.52% | 4.78 | 13 | 2014–2025 | emerging ; 73 | fr_social_accountability | Feature gaps & requests | req | 22 | 0.50% | 4.45 | 16 | 2014–2026 | weak ; 74 | cp_notes_journal | Core praise | pos | 21 | 0.48% | 4.95 | 13 | 2017–2026 | weak ; 75 | rel_login_account_fail | Reliability | neg | 21 | 0.48% | 1.86 | 10 | 2015–2024 | weak ; 76 | ux_weekday_scheduling | UX friction | neg | 21 | 0.48% | 3.57 | 17 | 2014–2026 | weak ; 77 | fr_widget | Feature gaps & requests | req | 20 | 0.45% | 4.00 | 6 | 2014–2026 | weak ; 78 | cp_health_shortcuts | Core praise | pos | 17 | 0.39% | 4.76 | 6 | 2019–2026 | weak ; 79 | fr_gamification_reward | Feature gaps & requests | req | 17 | 0.39% | 4.47 | 11 | 2015–2026 | weak ; 80 | fr_web_or_other_platform | Feature gaps & requests | req | 17 | 0.39% | 4.06 | 10 | 2017–2025 | weak ; 81 | mf_feature_removed_free | Monetization friction | neg | 17 | 0.39% | 2.82 | 12 | 2015–2025 | weak ; 82 | fr_backup_export | Feature gaps & requests | req | 16 | 0.36% | 4.38 | 8 | 2013–2026 | weak ; 83 | fr_raise_free_cap | Feature gaps & requests | req | 15 | 0.34% | 3.13 | 10 | 2016–2026 | weak ; 84 | fr_notes | Feature gaps & requests | req | 14 | 0.32% | 4.36 | 8 | 2013–2024 | weak ; 85 | mf_grandfather_broken | Monetization friction | neg | 14 | 0.32% | 1.64 | 10 | 2015 | weak ; 86 | rel_widget_bug | Reliability | neg | 14 | 0.32% | 3.07 | 8 | 2018–2024 | weak ; 87 | cp_backfill_history | Core praise | pos | 13 | 0.30% | 4.08 | 9 | 2016–2024 | weak ; 88 | fr_units | Feature gaps & requests | req | 13 | 0.30% | 3.54 | 7 | 2014–2026 | weak ; 89 | mf_upsell_nag | Monetization friction | neg | 13 | 0.30% | 2.08 | 7 | 2015–2024 | weak ; 90 | seg_adhd | Segments | — | 13 | 0.30% | 3.77 | 11 | 2018–2026 | weak ; 91 | sup_only_reachable_in_app | Support | neg | 13 | 0.30% | 1.69 | 9 | 2015–2026 | weak ; 92 | ux_no_skip_or_pause | UX friction | neg | 13 | 0.30% | 3.69 | 9 | 2014–2026 | weak ; 93 | cp_widget | Core praise | pos | 12 | 0.27% | 5.00 | 8 | 2018–2026 | weak ; 94 | rel_watch_bug | Reliability | neg | 12 | 0.27% | 2.33 | 7 | 2016–2022 | weak ; 95 | ux_notification_overload | UX friction | neg | 12 | 0.27% | 2.33 | 9 | 2014–2026 | weak ; 96 | ux_yes_no_semantics | UX friction | neg | 12 | 0.27% | 3.08 | 5 | 2018–2024 | weak ; 97 | fr_api_automation | Feature gaps & requests | req | 11 | 0.25% | 4.18 | 5 | 2014–2024 | weak ; 98 | fr_dark_mode | Feature gaps & requests | req | 11 | 0.25% | 4.64 | 6 | 2016–2025 | weak ; 99 | ux_points_system | UX friction | neg | 10 | 0.23% | 4.20 | 7 | 2013–2014 | weak ; 100 | fr_ipad_app | Feature gaps & requests | req | 9 | 0.20% | 4.67 | 5 | 2013–2015 | weak ; 101 | ux_review_prompt_nag | UX friction | neg | 9 | 0.20% | 2.22 | 8 | 2013–2024 | weak ; 102 | fr_time_duration | Feature gaps & requests | req | 8 | 0.18% | 3.38 | 5 | 2016–2025 | weak ; 103 | fr_watch_complication | Feature gaps & requests | req | 8 | 0.18% | 3.62 | 4 | 2016–2023 | weak ; 104 | seg_faith | Segments | — | 8 | 0.18% | 5.00 | 7 | 2017–2026 | weak ; 105 | ux_no_landscape_ipad | UX friction | neg | 8 | 0.18% | 2.62 | 5 | 2015–2016 | weak ; 106 | mp_pay_to_support_dev | Monetization praise | pos | 7 | 0.16% | 5.00 | 3 | 2018–2023 | weak ; 107 | fr_more_free_features | Feature gaps & requests | req | 6 | 0.14% | 3.83 | 5 | 2016–2026 | weak ; 108 | fr_timer | Feature gaps & requests | req | 6 | 0.14% | 4.33 | 4 | 2014–2024 | weak ; 109 | ux_accessibility | UX friction | neg | 6 | 0.14% | 3.50 | 2 | 2014–2025 | weak ; 110 | mf_cancel_difficulty | Monetization friction | neg | 4 | 0.09% | 1.25 | 2 | 2015–2026 | ignore ; 111 | rel_export_bug | Reliability | neg | 4 | 0.09% | 3.25 | 4 | 2017–2023 | ignore ; 112 | meta_duplicate_text | Meta | — | 3 | 0.07% | 5.00 | 1 | 2023–2026 | ignore ; 113 | meta_review_prompt | Meta | — | 3 | 0.07% | 5.00 | 1 | 2016–2021 | ignore ; 114 | neg_fake_reviews_claim | Product-value criticism | neg | 3 | 0.07% | 1.33 | 2 | 2022–2024 | ignore ; 115 | rel_health_sync_bug | Reliability | neg | 3 | 0.07% | 1.67 | 1 | 2023–2024 | ignore ; 116 | rel_audio_interrupt | Reliability | neg | 2 | 0.05% | 4.00 | 0 | 2024 | ignore ; 117 | ux_day_boundary | UX friction | neg | 2 | 0.05% | 3.00 | 1 | 2019–2022 | ignore

- **Where:** §3.1 master table (all 117 themes)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 117 themes
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R48-047 — Distribution: 5★ 3,057 (69.45%) · 4★ 450 (10.22%) · 3★ 214 (4.86%) · 2★ 197 (4.48%) · 1★ 484 (11.00%); mean 4.23; strongly bimodal — 80% of reviews at the extremes, so the mean conceals both loyalty and anger

- **Where:** Part 4 distribution
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 4,402
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R48-053 — Theme × rating cross-tab (top 28): Theme | n | 5★ | 4★ | 3★ | 2★ | 1★ | Mean ; cp_generic_positive | 858 | 783 | 70 | 3 | 2 | 0 | 4.90 ; cp_simplicity | 817 | 726 | 70 | 10 | 7 | 4 | 4.84 ; cp_flexible_tracker_types | 485 | 420 | 50 | 11 | 3 | 1 | 4.82 ; cp_best_of_many | 453 | 415 | 30 | 6 | 2 | 0 | 4.89 ; cp_behaviour_change | 267 | 256 | 10 | 0 | 0 | 1 | 4.95 ; mf_price_too_high | 266 | 55 | 38 | 43 | 43 | 87 | 2.74 ; mp_free_enough | 248 | 216 | 25 | 4 | 0 | 3 | 4.82 ; cp_visual_progress | 241 | 213 | 25 | 2 | 0 | 1 | 4.86 ; cp_reminders | 224 | 198 | 25 | 0 | 0 | 1 | 4.87 ; cp_design_aesthetic | 212 | 168 | 18 | 12 | 7 | 7 | 4.57 ; mf_free_cap_too_low | 199 | 36 | 28 | 33 | 35 | 67 | 2.65 ; rel_crash_wont_open | 185 | 16 | 17 | 9 | 30 | 113 | 1.88 ; cp_customization | 167 | 147 | 18 | 2 | 0 | 0 | 4.87 ; mp_paid_premium | 149 | 89 | 13 | 8 | 10 | 29 | 3.83 ; cp_streak_motivation | 144 | 138 | 6 | 0 | 0 | 0 | 4.96 ; seg_long_term_user | 137 | 113 | 5 | 2 | 8 | 9 | 4.50 ; cp_support_responsive | 127 | 117 | 7 | 2 | 1 | 0 | 4.89 ; ux_confusing_setup | 118 | 34 | 22 | 15 | 17 | 30 | 3.11 ; cp_accountability | 110 | 102 | 7 | 1 | 0 | 0 | 4.92 ; cp_bad_habit_tracking | 105 | 89 | 13 | 2 | 1 | 0 | 4.81 ; neg_competitor_named | 105 | 35 | 14 | 11 | 23 | 22 | 3.16 ; neg_stated_churn | 105 | 5 | 1 | 18 | 24 | 57 | 1.79 ; cp_dev_listens | 103 | 89 | 11 | 0 | 2 | 1 | 4.80 ; seg_fitness_weight | 95 | 85 | 9 | 0 | 1 | 0 | 4.87 ; rel_wrong_counts_stats | 85 | 8 | 14 | 21 | 19 | 23 | 2.59 ; rel_crash_on_action | 82 | 11 | 12 | 20 | 13 | 26 | 2.62 ; rel_notification_bug | 78 | 8 | 12 | 21 | 18 | 19 | 2.64 ; fr_better_reports | 76 | 37 | 22 | 7 | 5 | 5 | 4.07

- **Where:** §4.6 cross-tab table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** top 28
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R48-054 — 37 reviews contradict their own rating (5★ 'What happened? … totally fails to deliver'; 5★ titled 'Crashing non stop'; 1★ 'Amazing app, unlimited habit list… One of my favourite apps'; 1★ 'Easy and convenient'); separately 54 reviews rated 1–2★ contain genuine praise — the 'I love this app, but' pattern that makes the low-star band worth reading

- **Where:** §4.7 stars vs text
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 37 + 54
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** general
- **Review IDs:** `922481870`, `1136292748`, `3596145485`, `5223935659`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R48-055 — Payers: 172 (3.91%) — paid premium 149 plus paid lifetime 23, non-overlapping — mean 3.92 (108/14/9/10/31 by star) vs 4.24 for the other 4,230 (2949/436/205/187/453); 41 payer reviews at 1–2★ — 'not dissatisfaction with the product — it is dissatisfaction with what happens to them after paying'; payers concentrated in recent eras (7 / 8 / 31 / 75 / 51 by era, 4.09–5.37% of recent reviews vs 1.89% of E3) — consistent with the tightening free tier; no conversion rate can be inferred; geography US 104, GB 17 (over-indexes at 6.51%), CA 9, DE 6

- **Where:** §5.1 payers table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 172 payers
- **Direction for us:** none · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R48-077 — Trend method — five eras cut at product events reviewers date themselves: E1 Jul 2013 – Dec 2014 (paid app; n 342, mean 3.78, 1–2★ 21.6%, monetisation friction 2.3%, reliability 32.2%); E2 Jan – Sep 2015 (v3.0 subscription + forced account; 308, 2.21, 68.2%, 50.0%, 52.6%); E3 Oct 2015 – Jun 2018 (freemium relaunch ~10 free trackers; 1,636, 4.62, 6.2%, 7.8%, 6.3%); E4 Jul 2018 – Dec 2021 (cap tightened 10 → 7 → 3; 1,285, 4.32, 12.8%, 14.4%, 10.8%); E5 Jan 2022 – Sep 2026 (3-tracker tier, Mac app, Health, lifetime; 831, 4.23, 15.9%, 17.2%, 8.3%); moving any boundary ±2 months changes no era mean by more than 0.08★

- **Where:** §7.1 era table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** five eras
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `1273838707`, `2957558274`
- **Canonical:** — (nuance register)

### R48-102 — Research questions: what is the actual free-tier limit today and when did each change ship (reviewers report 10 / 8 / 7 / 6 / 5 / 4 / 3 / 2 / 1 inconsistently); did the tightening cap raise revenue — the corpus shows the rating and sentiment cost, cannot see conversions, and the payer-share rise in E4 / E5 is equally explicable by composition change

- **Where:** Part 8 #1, Part 8 #2 — §8.5 research questions 1-2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** n/a
- **Direction for us:** none · **Report confidence:** open question · **Generalisable:** general
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R48-103 — Research questions: why are Japan and Korea nearly absent (18 and 24 reviews) despite being high-spend markets where the category performs well; how large is the prompt-driven share of the 379 five-star low-information reviews; did the 2024 upgrade prompt convert anyone — seven say it repelled them, the corpus cannot see the other side

- **Where:** Part 8 #3, Part 8 #4, Part 8 #5 — §8.5 research questions 3-5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** n/a
- **Direction for us:** none · **Report confidence:** open question · **Generalisable:** general
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C093 No upsell nagging without a 'never ask again' option; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire
