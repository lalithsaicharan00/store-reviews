# Cards — report 12

Source: `App Store Reports/12. That Girl - Routine Planner - Cute Daily Calendar Schedule (REPORT).md`  
85 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 3
- [Must-haves](#must-haves) — 4
- [Must never break](#must-never-break) — 9
- [Features](#features) — 8
- [Monetization](#monetization) — 7
- [Tactics the app used](#tactics-the-app-used) — 3
- [Insights (the why)](#insights-the-why) — 8
- [Audiences](#audiences) — 4
- [Markets and languages](#markets-and-languages) — 6
- [Dated events and trends](#dated-events-and-trends) — 14
- [Positioning](#positioning) — 3
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 4
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 8

## Product rules

### R12-005 — This is a paywall corpus: nearly half of everything written was written by people who never used the app — they hit the payment gate and did not pay; the paywall complaint is the largest thing in the corpus in every one of five time periods ('Didn't even get to see the app. Told me I had to pay'; 'it's listed here as a free download')

- **Where:** Part 0 §1 This is not a habit-tracker review corpus. It is a paywall corpus.
- **This app does:** hard paywall; nothing usable before payment
- **User reaction:** blocked-conversion
- **Magnitude:** 188 of 404 (46.53%, HIGH-PRIORITY) complain about the gate — paywall_block 162 (40.10%) mean 1.30 (134 are 1★) + no_trial 62 (15.35%); 172 (42.57%) hit the gate and did not pay, mean 1.31
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8192594330`, `8916870417`, `8933371666`, `9375776581`, `12185804645`, `12691620078`, `13726769977`, `14284089819`, `14337005478`
- **Canonical:** C147 Let people use the product before they pay; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R12-079 — Let people see the planner before the paywall — 13 reviewers who got in say it is not differentiated from Apple Calendar, so the current gate is protecting a proposition that cannot survive inspection; fixing that is a product problem, and hiding it is not a solution

- **Where:** Part 9 Monetization #15 Let people see the planner before the paywall — the gate is protecting a proposition that cannot survive inspection
- **This app does:** hard paywall over an undifferentiated product
- **User reaction:** churn
- **Magnitude:** 13 (3.22%) mean 1.38
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R12-082 — For a competitor: a hard paywall with no trial produces a 61.63% one-star written-review base — the mechanism is not price sensitivity, it is the inability to evaluate; ship an evaluable free tier and you differentiate on the axis 188 reviewers named; aesthetic alone does not retain (11 of 17 design-praisers rated 1–2★)

- **Where:** Part 9 For a competitor entering this category — #1 hard paywall with no trial produces a 61.63% one-star base; #5 aesthetic alone does not retain
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** 1★ 249 of 404 (61.63%); 188 blocked; 11 of 17 aesthetic at 1–2★
- **Direction for us:** product-rule · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Canonical:** C147 Let people use the product before they pay; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable; C185 Aesthetic and a polished onboarding convert; they do not retain

## Must-haves

### R12-009 — Support is a dead end — five reviewers say the listed support email does not exist or bounces, one of them a 5★ whose entire text is a plea for help — and refunds are the second-order damage: the angriest cluster in the corpus, a quarter of paying reviewers; the chain is mechanical and repeats across countries: hard paywall → entitlement failure → no support → refund attempt → 1★ 'scam'

- **Where:** Part 0 §4 Support is a dead end, and refunds are the second-order damage
- **This app does:** support email bounces; refunds denied or unroutable
- **User reaction:** 1★-burst
- **Magnitude:** support unreachable 15 (3.71%, VERY STRONG), 5 bounce; refunds 21 (5.20%, HIGH-PRIORITY) mean 1.05 (20 of 21 1★), 25.00% of 80 paid; 'scam' or equivalent 42 (10.40%)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12162547099`, `12122344254`, `13194937352`, `13812177642`, `11839685862`, `12013949215`, `12192898307`, `11617090482`, `8560736398`, `12630584133`, `14335809799`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers

### R12-031 — Privacy / data-harvesting concerns appear at emerging band, all 1★

- **Where:** Part 3 #29 Privacy / data-harvesting concern
- **This app does:** questionnaire collects personal data pre-paywall
- **User reaction:** complaint
- **Magnitude:** 3 (0.74%, EMERGING) mean 1.00
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C085 Address tracking / privacy visibly

### R12-068 — Make the support address work and publish it in-app — an unreachable address converts recoverable bugs into 1★ 'scam' reviews and refund requests

- **Where:** Part 9 Immediate — billing integrity #2 Make the support address work and publish it in-app
- **This app does:** support email bounces
- **User reaction:** 1★-burst
- **Magnitude:** 15 (3.71%); 5 say the address does not exist
- **Direction for us:** must-have · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R12-076 — Stop forcing the food photo, let preset daily tasks be disabled, allow unit choice in the water tracker — the most detailed feature critique is the specification

- **Where:** Part 9 Near-term product #12 Stop forcing the food photo; let preset daily tasks be disabled; allow unit choice in the water tracker
- **This app does:** forced defaults, no unit choice
- **User reaction:** complaint
- **Magnitude:** 13 customisation reviewers, 10 US
- **Direction for us:** must-have · **Report confidence:** recommendation (near-term) · **Generalisable:** yes
- **Review IDs:** `10037371405`
- **Canonical:** C048 Flexible units / partial progress; C118 Preset routines / templates / programs

## Must never break

### R12-007 — Every reviewer who says they paid is unhappy: zero five-star reviews among 80 self-identified paying customers is the most consequential single fact — whatever drives the 4.83 store average, it is not paying customers writing about the product they bought; the people who love the app and the people who bought it are almost entirely different people (none of the 22 sustained-outcome reviewers is in the paid group)

- **Where:** Part 0 §2 Every reviewer who says they paid is unhappy. Not most — every one.; table (verbatim)
- **This app does:** hard paywall subscription
- **User reaction:** churn
- **Magnitude:** 80 paid (19.80%); 5★ 0 · 4★ 2 · 3★ 7 · 2★ 5 · 1★ 66 (82.50%); segment mean 1.31; praise_outcome 22 mean 4.95, 0 paid; 8 of 91 praise reviewers paid (8.79%); Rating | Count | Segment share ; 5★ | 0 | 0.00% ; 4★ | 2 | 2.50% ; 3★ | 7 | 8.75% ; 2★ | 5 | 6.25% ; 1★ | 66 | 82.50%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R12-008 — The number-one thing paying customers report is that payment did not grant access: paywall re-appears immediately after paying, 'no subscription found', Restore Purchase fails or redirects to the privacy policy, login error HTTP 400 after paying, cannot create account / crash at sign-in after paying, re-purchase demanded on a new device, charged and never gained access — a billing-integrity regression that did not exist early and grew

- **Where:** Part 0 §3 The number-one thing paying customers report is that payment did not grant access; failure-mode table (verbatim)
- **This app does:** entitlement / login failures after payment
- **User reaction:** 1★-burst
- **Magnitude:** 33 (8.17%, HIGH-PRIORITY) mean 1.15 (31 of 33 1★); 32 of 33 also state they paid → 40.00% of 80 paid; 3.4% (2022) → 8.0% (2024) → 12.6% (2025) → 7.9% (2026); Failure mode | IDs ; Paid, paywall re-appears immediately | `8923490272`, `11633047802`, `11660635922`, `11687779674`, `12351538776`, `11666538419`, `12841789013` ; "No subscription found" / no active subscription | `12320146758`, `11685577263`, `8981146108` ; Restore Purchase fails or redirects to the privacy policy | `12608420898`, `14151717931`, `12136171638`, `12706384367`, `11614195867` ; Login error `HTTP 400` after paying | `13718655958` (es), `12265074054` (jp) ; Cannot create account / crash at sign-in after paying | `13716961590`, `12265001830`, `13822556056` ; Re-purchase demanded on a new device | `12383283769` ; Charged, never gained access at all | `9145314921`, `12842761978`, `12199885547`, `13713833072`, `12602582289`
- **Direction for us:** must-never-break · **Report confidence:** high-priority, rising · **Generalisable:** yes
- **Review IDs:** `8923490272`, `11633047802`, `12320146758`, `12608420898`, `14151717931`, `13718655958`, `12265074054`, `13716961590`, `12383283769`, `9145314921`, `12842761978`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R12-014 — Reliability is the growth complaint and it is accelerating: edits/tasks not saved and data lost; setting a task time crashes or rewrites the other time with no AM/PM (military-time only) — the cleanest bug report in the corpus, still open; recurring/repeat tasks broken or absent; calendar sync (Google/Apple/Family Sharing) does not work; app closes at the end of the intro

- **Where:** Part 0 §8 Reliability is the growth complaint, and it is accelerating; defect table (verbatim)
- **This app does:** multiple open defects
- **User reaction:** 1★-burst
- **Magnitude:** 52 (12.87%, HIGH-PRIORITY); 11.4% (2022) → 3.8% (2023) → 9.0% (2024) → 16.5% (2025) → 17.5% (2026); Defect | n | % of 404 | Label | IDs ; Edits/tasks not saved; data lost | 11 | 2.72% | Meaningful | `8980705761`, `14029446237`, `9070379702`, `12261239323`, `12722697888`, `8965419740`, `12334061531`, `12015877548`, `12236526000`, `13746755144`, `14146221545` ; Setting/editing a task time crashes or rewrites the other time; no AM/PM, military-time only | 8 | 1.98% | Meaningful | `12111794304`, `14056969118`, `12215752061`, `11943045550`, `12251347318`, `12765812399`, `14082922244`, `14329102917` ; Recurring/repeat tasks broken or absent | 8 | 1.98% | Meaningful | `12111794304`, `12334061531`, `13194937352`, `8913316700`, `8927844988`, `8983147178`, `9110981116`, `14082922244` ; Calendar sync (Google/Apple/Family Sharing) does not work | 8 | 1.98% | Meaningful | `12178849529`, `12383283769`, `14151717931`, `12021381513`, `13812177642`, `12137887256`, `12247978715`, `12276664447` ; App closes/restarts at the end of the intro | 4 | 0.99% | Emerging | `8608302704`, `8638483109`, `8606816193`, `8614602501`
- **Direction for us:** must-never-break · **Report confidence:** high-priority, rising · **Generalisable:** yes
- **Review IDs:** `8980705761`, `14029446237`, `12111794304`, `14056969118`, `8913316700`, `12178849529`, `8608302704`
- **Canonical:** C030 Sync must work — and prove it; C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C043 Flexible / custom frequency

### R12-029 — A promotional 'free lifetime' giveaway was not honoured — a bounded, closed incident (Jul 2024 – May 2025)

- **Where:** Part 3 #19 Promotional 'free lifetime' not honoured; §8 Trend 9
- **This app does:** promo promised lifetime access, not delivered
- **User reaction:** 1★-burst
- **Magnitude:** 8 (1.98%, MEANINGFUL) mean 1.50; 2024-07 → 2025-05
- **Direction for us:** must-never-break · **Report confidence:** meaningful, closed · **Generalisable:** yes
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised

### R12-055 — Two single-review severity flags: a Belarus review with the full failure chain in one record (paid, charged, blocked, support unreachable), and a Malaysia review — 'has events that does not belong to my email' — the only record suggesting cross-account data leakage, flagged for triage because a data-boundary defect is a security concern regardless of frequency

- **Where:** §7.7 Small-storefront caveat — two single-review observations recorded as limited evidence: full failure chain; cross-account data leakage
- **This app does:** possible cross-account data leak (n=1)
- **User reaction:** 1★-burst
- **Magnitude:** n=1 each [limited evidence]; 52 of 58 storefronts <20 reviews, 22 exactly one
- **Direction for us:** must-never-break · **Report confidence:** limited evidence / security carve-out · **Generalisable:** yes
- **Review IDs:** `11614195867`, `13812177642`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C085 Address tracking / privacy visibly

### R12-067 — Fix the paid-access path end to end — subscription recognition, Restore Purchase, account login (HTTP 400), new-device restore; every other monetization improvement is worthless while a paid user can be locked out

- **Where:** Part 9 Immediate — billing integrity #1 Fix the paid-access path end to end
- **This app does:** entitlement failures
- **User reaction:** 1★-burst
- **Magnitude:** 33 (8.17% global / 41.25% of paid) mean 1.15, rising through 2025
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R12-069 — Fix Restore Purchase redirecting to the privacy policy — named identically by two GB reviewers a year apart, a specific reproducible defect

- **Where:** Part 9 Immediate — billing integrity #3 Fix 'Restore Purchase' redirecting to the privacy policy
- **This app does:** restore button mis-wired
- **User reaction:** 1★-burst
- **Magnitude:** 2 identical reports a year apart
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `12608420898`, `14151717931`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R12-070 — Triage the report of events appearing from another account — a data-boundary defect warrants investigation regardless of frequency

- **Where:** Part 9 Immediate — billing integrity #4 Triage the cross-account events report
- **This app does:** possible data leak
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `13812177642`
- **Canonical:** C085 Address tracking / privacy visibly

### R12-075 — Fix time editing (start/end overwriting each other, no AM/PM toggle, military-time lock), fix recurring tasks including weekday-only repeats and reminders that carry day to day (the oldest unfixed request, 3y10m), and make Google/Apple Calendar sync actually work or stop advertising it ('it said it was doing it but just kept loading')

- **Where:** Part 9 Near-term product #9 Fix time editing; #10 Fix recurring tasks incl. weekday-only repeats; #11 Make calendar sync work or stop advertising it
- **This app does:** three open defects
- **User reaction:** complaint
- **Magnitude:** time 8 (repro still open 2026); recurring 8 over 3y10m; sync 8
- **Direction for us:** must-never-break · **Report confidence:** recommendation (near-term) · **Generalisable:** yes
- **Review IDs:** `14056969118`, `12021381513`
- **Canonical:** C030 Sync must work — and prove it; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C043 Flexible / custom frequency; C072 Writes to shared system stores (calendar, health) must be exact and reversible

## Features

### R12-015 — The clearest, cheapest unmet need is a home-screen widget — asked by otherwise-happy paying users ('Love it but needs widgets… I forget all the time to use this app cause I don't have a widget'); the highest-mean complaint theme (retained users, not churned prospects); every request is dated 2024 or later; it names the exact retention mechanism the app lacks — a passive surface that reminds people the app exists

- **Where:** Part 0 §9 The clearest, cheapest unmet need is a widget
- **This app does:** no widget
- **User reaction:** complaint
- **Magnitude:** 9 (2.23%, MEANINGFUL) mean 2.44; 1 in 2024, 7 in 2025, 1 in 2026
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13550565309`, `12667337121`, `11973399697`, `14357143421`, `12178849529`, `12722697888`, `12215752061`, `12341288794`, `12892920714`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R12-021 — Feature inventory from reviews: narrated onboarding + questionnaire (the only free part); day/week/month calendar with time blocks, task list, reminders, habit/streak tracking, preset 'that girl' morning/night routines, water tracker, food log with MANDATORY photo, focus timer, affirmations/journal (possibly removed), Google Calendar sync (advertised, reported broken), account + cross-device restore (reported broken), themes/'vibe' picker — all paid; widgets, Apple Watch and iPad absent; free tier: none — no reviewer describes using any core feature without paying

- **Where:** §2.3 Feature inventory derived from reviews table (verbatim); Free tier: none
- **This app does:** everything paid except onboarding
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence it exists | Gating | IDs ; Narrated onboarding + personalisation questionnaire | Very high | Free (pre-paywall) | `11396873201`, `12809171419`, `10913036513`, `13096698945` ; Day/week/month calendar with time blocks | High | Paid | `13606114222`, `12276664447`, `12137887256`, `14056969118` ; Task / to-do list | High | Paid | `8252268729`, `12137887256`, `13937741808`, `14109640681` ; Reminders & notifications | High | Paid | `8913316700`, `8927844988`, `14005091328` ; Habit / streak tracking | Medium | Paid | `13746755144`, `14146221545` ; Preset "that girl" routines (morning/night) | Medium | Paid | `9102457965`, `10037371405`, `11146629279` ; Water tracker | Medium | Paid | `8983147178`, `10037371405`, `12676240767`, `11901631540` ; Food/meal log with mandatory photo | Medium | Paid | `10037371405`, `10907660652`, `11511872399` ; Productivity/focus timer | Low | Paid | `8983147178` ; Affirmations / motivational quotes / emotional journal | Low | Paid, possibly removed | `10118932887`, `11901631540` ; Google Calendar sync | Medium (advertised, reported broken) | Paid | `12021381513`, `12276664447` ; Account + cross-device restore | High (reported broken) | Paid | `12383283769`, `14151717931`, `12136171638` ; Themes / colour "vibe" picker | Low | Paid | `13366086371`, `12236526000` ; Widgets | Absent — 9 requests, 0 confirmations | n/a | `13550565309`, `12892920714`, `12215752061` ; Apple Watch app | Absent — 3 requests, 0 confirmations | n/a | `9852078271`, `12425415800`, `12178849529` ; iPad app | Absent (confirmed externally: iPhone-only listing) | n/a | `11678330257`, `14151717931`
- **Direction for us:** research · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13606114222`, `8252268729`, `8913316700`, `13746755144`, `9102457965`, `8983147178`, `10037371405`, `10118932887`, `12021381513`, `12383283769`, `13366086371`, `9852078271`, `11678330257`
- **Canonical:** C147 Let people use the product before they pay

### R12-022 — The food/meal log requires a photo — a mandatory step reviewers name as friction

- **Where:** §2.3 Food/meal log with mandatory photo
- **This app does:** mandatory photo to log a meal
- **User reaction:** complaint
- **Magnitude:** 3 cited reviews
- **Direction for us:** dont · **Report confidence:** low · **Generalisable:** yes
- **Review IDs:** `10037371405`, `10907660652`, `11511872399`
- **Canonical:** C048 Flexible units / partial progress

### R12-023 — Apple Watch and iPad apps are absent — Watch requested 3 times, iPad confirmed missing externally (iPhone-only listing)

- **Where:** §2.3 Apple Watch app absent — 3 requests; iPad app absent (iPhone-only listing)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** Apple Watch / iPad requested 7 (1.73%, MEANINGFUL) mean 3.14
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9852078271`, `12425415800`, `12178849529`, `11678330257`, `14151717931`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C141 Native iPad layout

### R12-028 — Mid-size complaint themes: customisation too limited; English text quality / typos (2022–Feb 2023 only, since fixed); notifications missing or unreliable; app not available in the user's language; cannot plan ahead / calendar depth

- **Where:** Part 3 #15 Customisation too limited; #16 English text quality / typos; #25 Notifications missing or unreliable; #26 Language not available (non-EN); #27 Cannot plan ahead / calendar depth
- **This app does:** limited customisation; English only; shallow calendar
- **User reaction:** complaint
- **Magnitude:** customisation 13 (3.22%, VERY STRONG) mean 1.92; typos 12 (2.97%) mean 1.58, 2022-01 → 2023-02; notifications 6 (1.49%) mean 2.83; language 5 (1.24%) mean 2.60; plan-ahead 5 (1.24%) mean 3.80
- **Direction for us:** build-free · **Report confidence:** meaningful–very strong · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views; C027 Localise early — it unlocks revenue; C039 Reminders fire reliably, once; C059 Be visibly responsive; fixes bring reviewers back

### R12-045 — A missing platform is the stated reason not to buy — 'Im not gonna pay for it. Because there is no apple watch version'; 'Please make an iPad version so I can buy the lifetime subscription!' — a rare clean willingness-to-pay signal naming the same lever as the widget requests: presence on surfaces outside the app

- **Where:** §6.3 Two reviewers state a missing platform is the reason they will not upgrade
- **This app does:** no Watch, no iPad
- **User reaction:** blocked-conversion
- **Magnitude:** n=1 each (0.25%)
- **Direction for us:** build-paid · **Report confidence:** weak by count, clean by content · **Generalisable:** yes
- **Review IDs:** `9852078271`, `11678330257`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C141 Native iPad layout

### R12-074 — Ship a home-screen widget — the highest-value-per-effort item on the list

- **Where:** Part 9 Near-term product #8 Ship a home-screen widget
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 9 requests, all 2024+, mean 2.44, one 5★
- **Direction for us:** build-free · **Report confidence:** recommendation (near-term) · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free

### R12-077 — Ship an iPad layout — currently iPhone-only; 'Please make an iPad version so I can buy the lifetime subscription!' is a stated purchase blocker

- **Where:** Part 9 Near-term product #13 Ship an iPad layout
- **This app does:** iPhone only
- **User reaction:** blocked-conversion
- **Magnitude:** n=1 stated blocker; 7 Watch/iPad requests
- **Direction for us:** build-paid · **Report confidence:** recommendation (near-term) · **Generalisable:** yes
- **Review IDs:** `11678330257`
- **Canonical:** C141 Native iPad layout

## Monetization

### R12-019 — The price ladder has ten SKUs: three 'Weekly Subscription' at $7.00 / $6.99 / $2.99, three yearly at $24.00 / $5.99 / $4.00, two 'One-Time Payment' at $9.00 / $4.99, plus Monthly $8.00 and 12 Weeks $29.99 — external corroboration of what reviewers describe from inside: a price that changes when you try to leave

- **Where:** §2.2 The price ladder, from Apple's own IAP list table (verbatim); three separate 'Weekly Subscription' SKUs
- **This app does:** 10 SKUs with duplicate names; weekly / monthly / yearly / one-time
- **User reaction:** 1★-burst
- **Magnitude:** SKU name | Price ; Weekly Subscription | $7.00 ; Weekly Subscription | $6.99 ; Weekly Subscription | $2.99 ; Monthly Subscription | $8.00 ; 12 Weeks Subscription | $29.99 ; Yearly app access | $24.00 ; 1 Year Plan | $5.99 ; Yearly app access for sale | $4.00 ; One-Time Payment | $9.00 ; One-Time Payment | $4.99
- **Direction for us:** dont · **Report confidence:** external + 8 reviews · **Generalisable:** yes
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

### R12-026 — No free trial / can't test first is the fourth-largest theme

- **Where:** Part 3 #4 No free trial / can't test first
- **This app does:** no trial (early corpus); a trial later appeared and broke
- **User reaction:** blocked-conversion
- **Magnitude:** no_trial 62 (15.35%, HIGH-PRIORITY) mean 1.35; 2022-01 → 2026-07
- **Direction for us:** undecided · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay

### R12-027 — Price objection is a high-priority theme in its own right ('$14.99 this is crazy… $30.00 per month that is more than the lifetime option'; 'it costs 5$/permonth')

- **Where:** Part 3 #6 Price objection
- **This app does:** weekly $2.99–$7, monthly $8, yearly $4–$24, one-time $4.99–$9
- **User reaction:** complaint
- **Magnitude:** price objection 50 (12.38%, HIGH-PRIORITY) mean 1.72
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11588201167`, `11453056321`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R12-041 — Four purchase triggers and only one is product value: coercion — the gate is the only way forward ('I paid 699 so I could test it for one week because the app wouldn't let me do anything unless I did'); exit-offer discount (several felt manipulated and declined); onboarding persuasion / aesthetic ('The set up process is so intelligent and impressive, I opted for a paid subscription'); a promotional 'free lifetime' giveaway (all 5 report it was not honoured); no reviewer in 404 says they paid because of a feature seen working — the product cannot be evaluated before purchase, so no purchase is evidence-based, so no purchase is durable

- **Where:** §6.1 What actually triggers a purchase table (verbatim); No reviewer says they paid because of a specific feature they had seen working
- **This app does:** hard paywall; exit discount; promo code
- **User reaction:** purchase-driver
- **Magnitude:** Trigger | Evidence | Segment n | Notes ; Coercion — the gate is the only way forward | `10875709898`: *"I paid 699 so I could test it for one week because the app wouldn't let me do anything unless I did."* Also `12074673305`, `9114009603`, `13810250486`, `8939762875` | ~5 explicit | Purchases made *in order to evaluate*, not because value was established ; Exit-offer discount | `13817544776`, `12242542425`, `13638785503`, `13279632399`, `12134476768` | 5 | Price anchoring; several state the anchor felt manipulative and they declined ; Onboarding persuasion / aesthetic | `11914052843` (mx): *"Admito que es una aplicación que parece vale la pena pagar por ella… Aún así, la compraré"*; `12841067761`: *"The set up process is so intelligent and impressive, I opted for a paid subscription."* | 2 explicit | The intro is a genuinely effective conversion asset ; Promotional "free lifetime" giveaway | `12136171638` used code "appadvice"; `11514752409`, `12015499097`, `12060522005`, `11513929479` | 5 | All 5 report the entitlement was not honoured or was later charged
- **Direction for us:** product-rule · **Report confidence:** n≈17 across triggers · **Generalisable:** yes
- **Review IDs:** `10875709898`, `12074673305`, `9114009603`, `13810250486`, `8939762875`, `11914052843`, `12841067761`, `12136171638`, `11514752409`, `12015499097`, `12060522005`, `11513929479`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable; C185 Aesthetic and a polished onboarding convert; they do not retain

### R12-043 — The ceiling of buyer satisfaction visible in the corpus: two 4★ and seven 3★ payers report the product working well enough to keep using — 'I pay a yearly subscription and find it very helpful' followed immediately by a restore-purchases bug

- **Where:** §6.2 Value actually delivered to buyers — the ceiling of buyer satisfaction
- **This app does:** subscription
- **User reaction:** mixed
- **Magnitude:** 9 of 80 payers at 3–4★; 0 at 5★
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `14151717931`, `12137887256`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R12-044 — Upgrade barriers: cannot evaluate before paying (largest), price relative to perceived value, cannot afford / is a minor, reviews already warn them, missing platform (Watch, iPad) blocks purchase

- **Where:** §6.3 Upgrade barriers table (verbatim)
- **This app does:** hard paywall; no Watch/iPad
- **User reaction:** blocked-conversion
- **Magnitude:** Barrier | n | Segment/global | IDs ; Cannot evaluate before paying | 62 | 15.35% global | `8944662701`, `10060470838`, `9013967197`, `13012628695`, `11643747902`, `10947869335` ; Price relative to perceived value | 50 | 12.38% global | `8889252037`, `11588201167`, `11936194643`, `12984794266`, `8225991201` ; Cannot afford / is a minor (hand-identified subset of themes 1+6) | 5 | 1.24% global | `11446516100`, `14335809799`, `10331647142`, `11933820778`, `11819217162` ; Reviews already warn them | 3 | 0.74% global | `11575597852`, `13817544776`, `11146629279` ; Missing platform (Watch) blocks purchase | 1 | 0.25% global | `9852078271`: *"Im not gonna pay for it. Because there is no apple watch version"* ; Missing platform (iPad) blocks purchase | 1 | 0.25% global | `11678330257`: *"Please make an iPad version so I can buy the lifetime subscription!"*
- **Direction for us:** research · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8944662701`, `10060470838`, `8889252037`, `11446516100`, `14335809799`, `11575597852`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C064 Price level — where 'fair' turns into 'too expensive'; C141 Native iPad layout; C147 Let people use the product before they pay

### R12-078 — Introduce a genuinely functional free tier or a working trial — the single largest lever in the corpus: 188 blocked, 172 left without paying; even a 3-day trial that WORKS addresses the 2025–26 complaint shape

- **Where:** Part 9 Monetization #14 Introduce a genuinely functional free tier or a working trial — the single largest lever
- **This app does:** hard paywall, broken trial
- **User reaction:** blocked-conversion
- **Magnitude:** 188 (46.53%); 172 never paid
- **Direction for us:** build-free · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay

## Tactics the app used

### R12-042 — The narrated, personalised onboarding is a genuinely effective conversion asset — reviewers say they subscribed because of it — even as it fails to retain

- **Where:** §6.1 The intro is a genuinely effective conversion asset
- **This app does:** long narrated onboarding before paywall
- **User reaction:** purchase-driver
- **Magnitude:** 2 explicit; 9 of 77 5★ praise onboarding pre-use
- **Direction for us:** undecided · **Report confidence:** n=2 · **Generalisable:** yes
- **Review IDs:** `11914052843`, `12841067761`
- **Canonical:** C075 Skippable, replayable onboarding tour; C185 Aesthetic and a polished onboarding convert; they do not retain

### R12-054 — In es/mx the app is listed gender-neutral as 'Daily Routine Planner Schedule' and those two storefronts carry the two highest store averages in the set (es 4.84, mx 4.78) — causation not established, but four reviewers object to the gendered brand ('not just for girls'; 'I don't think a todo app should be targeted at one certain gender'; 'Scam app preying on young girls'), so the rename is a deliberate, testable positioning decision already made in one market pair

- **Where:** §7.6 Storefront naming — an ASO fact; gendered brand objection
- **This app does:** gendered brand; neutral rename in es/mx
- **User reaction:** mixed
- **Magnitude:** gender objection 4 (0.99%); es 4.84, mx 4.78
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13702266709`, `13546083732`, `12412345383`, `9741292848`
- **Canonical:** C184 Gendered branding narrows the audience; a neutral name is already tested

### R12-081 — Reconsider the gendered brand in more markets — the developer already ships a gender-neutral name in es/mx, the two highest-rated storefronts sampled; treat that as an existing A/B result worth extending and measuring

- **Where:** Part 9 Monetization #17 Reconsider the gendered brand in more markets — treat the es/mx rename as an existing A/B result
- **This app does:** gendered brand with a neutral variant in two storefronts
- **User reaction:** mixed
- **Magnitude:** es 4.84, mx 4.78
- **Direction for us:** research · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C184 Gendered branding narrows the audience; a neutral name is already tested

## Insights (the why)

### R12-006 — The listing does disclose the paywall in body text ('fully paid and purchase is required to access any content') but the price label still reads Free — 162 reviewers hit an expectation gap the listing technically closes, which makes this a discovery and framing failure fixable at the top of the funnel, not in the product

- **Where:** Part 0 §1 The listing does disclose it — a discovery and framing failure, not an honesty failure
- **This app does:** 'Free' label + paid-only disclosure buried in description
- **User reaction:** blocked-conversion
- **Magnitude:** 162 paywall_block reviews despite disclosure
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C181 If the app is paid-only, say so in the subtitle and first screenshot

### R12-013 — When people do get in, the app is judged as a worse version of the calendar they already have — 'a glamourized version of the FREE Reminders app', 'fewer features than Apple's free Calendar app', 'There are no routines or trackers in the app. It's just a calendar/to do list. they charge you before you can see that' — the single most dangerous finding for the paid proposition: a paywall is defensible only if what is behind it is differentiated

- **Where:** Part 0 §7 When people do get in, the app is judged as a worse version of the calendar they already have
- **This app does:** calendar/to-do behind a hard paywall
- **User reaction:** churn
- **Magnitude:** 13 (3.22%, VERY STRONG) mean 1.38
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8985632836`, `12236900050`, `13766147453`, `13937741808`, `12558262311`, `8252268729`, `9975565509`, `9314712194`, `12033069615`, `14005091328`, `11586279561`, `12982453369`, `14329102917`
- **Canonical:** C005 Know which competitors buyers compare against; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R12-016 — What people genuinely love is being told what their day looks like — 'the day is planned for me, so I stop losing track of it' — 'I suffer with autism… I lose track of time… but that girl made sure I DID have a plan'; 'I have adhd and this app is literally helping me'; 'I used to be rushed… now with everything organised it feels like a breeze'

- **Where:** Part 0 §10 What people genuinely love: being told what their day looks like
- **This app does:** pre-planned day schedule
- **User reaction:** praise
- **Magnitude:** praise 91 (22.52%); praise_outcome 22 (5.45%, HIGH-PRIORITY) mean 4.95
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12286335035`, `13203951770`, `13936002411`, `11585180763`, `10283941160`, `14135703563`, `13949586588`, `11755587287`, `9333260206`, `10972036961`, `11142925263`, `11418401764`, `11429621110`, `11540185663`, `11561379247`, `12566742489`, `12980084882`, `14118054672`, `11513175352`, `13108916516`, `12599834461`, `13563108066`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R12-017 — Beauty is real and it is not sufficient: 4 of the 17 reviewers who praise the aesthetic rated 1★ and 7 rated 2★ — 'Super cute app, with a beautiful introduction and you can really see the thought put into it. But then it costs 5$/permonth'

- **Where:** Part 0 §10 17 reviewers praise the aesthetic explicitly — beauty is real and it is not sufficient
- **This app does:** aesthetic-led product
- **User reaction:** mixed
- **Magnitude:** 17 (4.21%) praise aesthetic; 4 are 1★, 7 are 2★
- **Direction for us:** insight · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11453056321`
- **Canonical:** C185 Aesthetic and a polished onboarding convert; they do not retain

### R12-033 — Complaint types: pricing objection is 51% of the corpus (the product working, the gate rejected — does not say the product is bad); broken existing capability 22.5% (defect tickets, not roadmap); genuine new-capability requests 5.9% (widgets, Watch/iPad, non-English, plan-ahead depth); expectation gap ~162 (fixable with store copy, not engineering); trust/integrity 15.8%

- **Where:** §3.1 Unmet needs, cleanly separated from broken features table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Type | Themes | n (union) | Notes ; Pricing objection (product works, price/gate rejected) | 1, 4, 6, 20 | 207 | 51.24% of corpus. Largest bucket by far. Does not tell you the product is bad. ; Broken existing capability | 5, 7, 17, 21, 22, 23, 25 | 91 | 22.52%. Everything here is a defect ticket, not a roadmap item. ; Genuine new-capability request | 18, 24, 26, 27 | 24 | 5.94%. Widgets, Watch/iPad, non-English, plan-ahead depth. ; Misunderstanding / expectation gap | listing says "Free"; users expect freemium | ~162 overlap with 1 | Addressable with copy and store presentation, not engineering. ; Trust / integrity | 8, 10, 13, 19, 29 | 64 | 15.84%. The reputational layer.
- **Direction for us:** none · **Report confidence:** classification · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R12-038 — Not a single 4★ review is unqualified praise — no Apple Watch, restore broken on iPad, to-do can't be un-checked and won't import from Apple Reminders, intro too long, delays and double entry, can't plan ahead, rated 4★ because the app demanded a review before use, price, gender framing; for a competitor 4★ is a specification: nine shippable items each named by a retained user

- **Where:** §5.2 4★ — Every one names a specific gap; 4★ here is a specification
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 4★ n=14 (3.47%)
- **Direction for us:** build-free · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `9852078271`, `12425415800`, `14151717931`, `12137887256`, `11557928395`, `11561379247`, `14029446237`, `8965419740`, `10905116935`, `8836955574`, `13702266709`, `14427888328`, `11146629279`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C075 Skippable, replayable onboarding tour; C141 Native iPad layout; C184 Gendered branding narrows the audience; a neutral name is already tested

### R12-039 — 3★ splits cleanly — 7 are paywall objections from people who never got in, the rest are detailed bug reports from people who did; this is the cohort a support function would save

- **Where:** §5.3 3★ — The most useful reviews in the corpus; this is the cohort a support function would save
- **This app does:** no support function
- **User reaction:** complaint
- **Magnitude:** 3★ n=31 (7.67%); 7 (22.6%) paywall
- **Direction for us:** must-have · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `14056969118`, `12111794304`, `11943045550`, `12251347318`, `12276664447`, `12247978715`, `12341288794`, `12667337121`, `10907660652`, `12619802360`, `13898871047`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R12-040 — 2★ is the 'you almost had me' band — 7 of 17 aesthetic-praise reviews are 2★, nearly half are paywall complaints, and the typo complaints (all 2022–23) sit here; five 1★ reviews still contain praise — people who liked the idea enough to be angry

- **Where:** §5.4 2★ — 'Beautiful, but.'; §5.5 Five 1★ reviews still contain a praise component
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2★ n=33: 16 (48.5%) paywall, 5 (15.2%) typos; 7 of 17 aesthetic at 2★; 5 of 249 1★ with praise
- **Direction for us:** none · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `12215752061`, `8989214254`, `11586279561`, `12611951529`, `13937741808`
- **Canonical:** C185 Aesthetic and a polished onboarding convert; they do not retain

## Audiences

### R12-030 — A gender-targeting objection exists at emerging band — and the developer renamed the app gender-neutral in Spanish storefronts

- **Where:** Part 3 #28 Gender targeting objection; §2.1 gender-neutral rename in Spanish storefronts
- **This app does:** 'That Girl' branding; renamed in es/mx
- **User reaction:** complaint
- **Magnitude:** 4 (0.99%, EMERGING) mean 2.00
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** app-specific
- **Canonical:** C184 Gendered branding narrows the audience; a neutral name is already tested

### R12-032 — ADHD / autism users name the pre-planned day as the benefit

- **Where:** Part 3 #30 ADHD / autism use case
- **This app does:** structured day plan
- **User reaction:** praise
- **Magnitude:** 3 (0.74%, EMERGING) mean 3.67
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12286335035`, `13203951770`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R12-035 — Corpus segments: blocked-never-paid-never-used 172 (mean 1.31); self-identified payers 80 (1.31); sustained users 22 (4.95); praised-onboarding-only pre-use 9 (5.00); content-free 8; 16 reviews are in both the blocked and paid groups — people who complained about the gate and paid anyway ('Even so, I'll buy it because it looks very attractive')

- **Where:** Part 4 WHO IS IN THIS CORPUS table (verbatim); overlap note — 16 reviews in both blocked and paid groups
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Segment | n | % of 404 | Mean ★ | What defines it ; Blocked, never paid, never used | 172 | 42.57% | 1.31 | Hit the paywall or asked for a trial; no purchase evidence ; Self-identified paying customers | 80 | 19.80% | 1.31 | States they paid / subscribed / were charged / sought refund ; Users describing sustained use | 22 | 5.45% | 4.95 | Names an outcome over time ; Praised onboarding only, pre-use | 9 | 2.23% | 5.00 | 5★ text refers only to the intro ; Content-free / uninterpretable | 8 | 1.98% | — | No evaluable content ("Mwah", "Submitted", "Yo") ; overlap 16
- **Direction for us:** none · **Report confidence:** segments · **Generalisable:** app-specific
- **Review IDs:** `11914052843`, `11500680241`, `13817502722`, `12982453369`, `11586279561`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C147 Let people use the product before they pay

### R12-046 — A subset of blocked users cannot afford it or are minors without a card — the 'That Girl' aesthetic pulls a young audience into a hard paywall

- **Where:** §6.3 Cannot afford / is a minor
- **This app does:** hard paywall aimed at a young audience
- **User reaction:** blocked-conversion
- **Magnitude:** 5 (1.24%)
- **Direction for us:** research · **Report confidence:** hand-identified · **Generalisable:** app-specific
- **Review IDs:** `11446516100`, `14335809799`, `10331647142`, `11933820778`, `11819217162`
- **Canonical:** C025 Scholarship / hardship / discount program; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

## Markets and languages

### R12-049 — Only the US clears 50 (135, 33.42%); US distribution and theme divergences vs global

- **Where:** §7.1 Eligibility; §7.2 United States table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** US n=135 mean 2.26; 1★ 76 (56.30%), 2★ 13, 3★ 11, 4★ 5, 5★ 30 (22.22%); Theme | US n | % of 135 | Global % | Divergence ; Paywall blocks access | 46 | 34.07% | 40.10% | Lower ; Any praise | 41 | 30.37% | 22.52% | Higher ; Paying customer | 26 | 19.26% | 19.80% | Same ; No free trial | 21 | 15.56% | 15.35% | Same ; Bugs / crashes | 17 | 12.59% | 12.87% | Same ; Price objection | 13 | 9.63% | 12.38% | Lower ; Sustained-outcome praise | 12 | 8.89% | 5.45% | Higher ; Onboarding friction | 11 | 8.15% | 5.20% | Higher ; Customisation limits | 10 | 7.41% | 3.22% | Higher ; English text quality | 9 | 6.67% | 2.97% | Higher ; Entitlement failure | 8 | 5.93% | 8.17% | Lower ; Promo not honoured | 6 | 4.44% | 1.98% | Higher ; Rating prompt | 2 | 1.48% | 5.69% | Much lower
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R12-050 — US reviewers evaluate the product, not just the gate (10 of 13 customisation and 9 of 12 typo complaints; the most detailed feature critique — water tracker locked to litres, food log requiring a photo, preset daily tasks that cannot be turned off); US carries 6 of 8 promo-not-honoured reviews (the AppAdvice giveaway was a US-channel event) and 11 of 21 onboarding fights; the 5★-prompt complaint is nearly absent in the US (2 of 23) — a real divergence of unknown cause, not evidence the prompt is not shown

- **Where:** §7.2 What is genuinely US-specific
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** US paywall 34.07% vs 40.10% global; praise 30.37% vs 22.52%; outcome praise 8.89% vs 5.45%; customisation 7.41% vs 3.22%; rating prompt 1.48% vs 5.69%
- **Direction for us:** research · **Report confidence:** eligible (n=135) · **Generalisable:** app-specific
- **Review IDs:** `10037371405`, `12136171638`, `12015499097`, `12060522005`, `11514752409`, `11514719694`, `11513929479`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R12-051 — Top-8 written-review storefronts (US, GB, DE, AU, CA, FR, BR, IT) vs rest of world: the one material difference is that refund and support failures are roughly twice as prevalent outside the top 8 — small-storefront users are more likely to be charged and stranded (UA alone contributes 4 of 21 refund complaints from 9 reviews)

- **Where:** §7.3 High-review-volume markets table (verbatim); refund and support failures are roughly twice as prevalent outside the top-8
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Metric | Group | Rest of world ; n | 267 (66.09%) | 137 (33.91%) ; Mean ★ | 2.01 | 2.27 ; Paywall block | 41.57% | 37.23% ; Paying customer | 18.35% | 22.63% ; Entitlement failure | 7.87% | 8.76% ; Refund | 3.75% | 8.03% ; Support unreachable | 3.00% | 5.11% ; Price objection | 11.24% | 14.60% ; Any praise | 21.72% | 24.09%
- **Direction for us:** research · **Report confidence:** small denominators · **Generalisable:** app-specific
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C062 Weight English-speaking rich markets; volume ≠ revenue

### R12-052 — The high-spend group (US, GB, DE, CA, AU, FR, JP) is not more forgiving and not less blocked — slightly more payers and slightly more entitlement failures, so the revenue markets are where the billing defect does the most damage; JP's only two reviews are both negative (HTTP 400 after subscribing; 'Pure fishing app'); every one of thirteen sampled storefronts shows a store average between 4.63 and 4.84 — the 2.10 written mean diverges in all thirteen

- **Where:** §7.4 High-spend markets table (verbatim); the markets that generate the most revenue are also where the billing defect does the most damage; JP limited evidence; store averages 4.63–4.84 in all thirteen
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Metric | High-spend group | Global ; n | 246 (60.89%) | 404 ; Mean ★ | 2.06 | 2.10 ; Paywall block | 39.02% | 40.10% ; No trial | 17.07% | 15.35% ; Paying customer | 20.33% | 19.80% ; Entitlement failure | 8.94% | 8.17% ; Bugs | 13.82% | 12.87% ; Any praise | 22.76% | 22.52% ; ratings US 5,825 · GB 1,576 · DE 961 · CA 841 · AU 670 · FR 637 · IT 529 · MX 397 · ES 380 · NL 369 · PL 234 · BR 245 · UA 120
- **Direction for us:** research · **Report confidence:** group · **Generalisable:** app-specific
- **Review IDs:** `12265074054`, `12602582289`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C062 Weight English-speaking rich markets; volume ≠ revenue

### R12-053 — The app declares English only, yet 16% of reviews are written in another language; five reviewers explicitly ask for their language (a 5★ whose entire review is the Simplified Chinese request; a 1★ partly because 'the interface is English only') and one names the trade directly: 'If the app would be a little bit cheaper and it would be in german too I would buy it' — English-only shipping is costing paying customers in DE, BR, FR, IT, TW and CN storefronts holding ~2,800 of the 12,784 ratings sampled; counter-evidence: one ES 5★ praises the English as clear enough

- **Where:** §7.5 Localisation — a structural finding, not a country finding
- **This app does:** English only
- **User reaction:** blocked-conversion
- **Magnitude:** 64 of 404 (15.84%) non-English: de 15, pt 13, fr 12, es 8, it 7, zh 5, sv 1, nl 1, ru/uk 1, ko 1; explicit asks 5 (1.24%, MEANINGFUL) mean 2.60
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9014887127`, `8161641833`, `10906821521`, `10911615115`, `10923103793`, `11635792003`
- **Canonical:** C027 Localise early — it unlocks revenue

### R12-080 — Localise to DE, PT-BR, ES, FR, IT, ZH-Hant — 16% of reviews are non-English against an English-only build; one reviewer names localisation + price as a conditional purchase

- **Where:** Part 9 Monetization #16 Localise to DE, PT-BR, ES, FR, IT, ZH-Hant
- **This app does:** English only
- **User reaction:** blocked-conversion
- **Magnitude:** 64 of 404 (15.84%)
- **Direction for us:** build-free · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `9014887127`
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R12-012 — The unskippable-onboarding complaint peaked in 2024 and dropped to one review in 2025 — the corpus's clearest evidence of a fix that landed

- **Where:** Part 0 §6 The onboarding complaint peaked in 2024 and drops to 1 review in 2025 — the corpus's clearest evidence of a fix that landed; §8 Trend 4
- **This app does:** onboarding made skippable (inferred)
- **User reaction:** praise
- **Magnitude:** 16 of 21 in 2024 (16.0% of 2024 reviews) → 1 in 2025
- **Direction for us:** do · **Report confidence:** clear · **Generalisable:** yes
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C075 Skippable, replayable onboarding tour

### R12-024 — One documented regression: 'It had a water tracker, motivational quotes, food tracker, emotional journal, task tracker, and the calendar… once it was updated all those features were gone' (Nov 2024) — n=1, weak, but consistent with the 2026 'just a calendar/to do list' and 'no routines or trackers' complaints; flagged as a research question, not a finding

- **Where:** §2.4 One product regression is documented (feature removal after update)
- **This app does:** features removed in an update (n=1)
- **User reaction:** churn
- **Magnitude:** 1 (0.25%, WEAK)
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** app-specific
- **Review IDs:** `11901631540`, `13937741808`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace

### R12-047 — Churn and refund drivers among payers, in order: entitlement failure 40%, bugs after paying 32.5%, refund sought 25%, support unreachable 13.75%, value disappointment 7.5%; the archetype of locked-in churn: 'i paid for the year so im stuck with it until then but honestly its pretty bad ill probably delete it'

- **Where:** §6.4 Churn and refund drivers table (verbatim); locked-in churn archetype
- **This app does:** annual lock-in with no value
- **User reaction:** churn
- **Magnitude:** Driver | n | Segment rate (of 80) | IDs ; Entitlement failure after paying | 32 | 40.00% | see §0.3 ; Refund sought | 20 | 25.00% | see §0.4 ; Bugs after paying | 26 | 32.50% | `12431370019`, `13746755144`, `14082922244`, `12611951529`, `12841789013`, `12033069615` ; Support unreachable | 11 | 13.75% | see §0.4 ; Value disappointment after paying (hand-identified subset, not a formal theme) | 6 | 7.50% | `12067724293`, `11586279561`, `12982453369`, `14329102917`, `13898871047`, `12135855134`
- **Direction for us:** must-never-break · **Report confidence:** segment (n=80) · **Generalisable:** yes
- **Review IDs:** `14329102917`, `12431370019`, `13746755144`, `14082922244`, `12611951529`, `12841789013`, `12033069615`, `12067724293`, `12982453369`, `13898871047`, `12135855134`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R12-056 — Five periods (2021 folded into 2022; 2026 partial to 16 Aug): the mean rose from 1.68 (P1) and 1.46 (P2) to 2.29 / 2.19 / 2.48 as the 5★ share stepped up from 6.8% to 24–27% from 2024

- **Where:** Part 8 TIME-TREND method; period table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Period | n | Mean ★ | 1★ | 5★ ; P1 2021-12 → 2022-12 | 88 | 1.68 | 60 (68.2%) | 6 (6.8%) ; P2 2023 | 26 | 1.46 | 19 (73.1%) | 1 (3.8%) ; P3 2024 | 100 | 2.29 | 57 (57.0%) | 24 (24.0%) ; P4 2025 | 127 | 2.19 | 78 (61.4%) | 29 (22.8%) ; P5 2026 (to Aug) | 63 | 2.48 | 35 (55.6%) | 17 (27.0%)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R12-057 — The paywall complaint never goes away: it falls after 2023 but never drops below a third of all reviews in any period — the longest-running unresolved theme, unresolved by design

- **Where:** §8 Trend 1 — The paywall complaint never goes away
- **This app does:** hard paywall by design
- **User reaction:** 1★-burst
- **Magnitude:** 52.3% → 61.5% → 36.0% → 33.9% → 33.3%
- **Direction for us:** product-rule · **Report confidence:** persistent · **Generalisable:** yes
- **Canonical:** C147 Let people use the product before they pay

### R12-058 — 'No free trial' collapses after 2022 and then a trial appears and breaks: the 2022 cohort is unanimous that no trial exists; from 2025 reviewers describe a trial that shows as subscribed but 'doesn't move past the subscription screen', 'once i got the 3 day free trial it just glitched and won't move forward', 'They gave a free trial but it doesn't work' — the complaint changed shape from 'there is none' to 'it doesn't work'

- **Where:** §8 Trend 2 — 'No free trial' collapses after 2022; a trial appears and then breaks
- **This app does:** 3-day trial introduced 2023–25, does not reliably grant access
- **User reaction:** 1★-burst
- **Magnitude:** 35.2% → 23.1% → 8.0% → 6.3% → 14.3%
- **Direction for us:** must-never-break · **Report confidence:** trend · **Generalisable:** yes
- **Review IDs:** `8944662701`, `8992840051`, `9380396109`, `8988433850`, `9086515342`, `12608420898`, `12605461922`, `12601413294`
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

### R12-059 — Entitlement failure is the growth defect: 2025 is the worst year on record for paid users locked out of what they bought, and the last shipped version (15 May 2025) carries release notes reading only 'Bug fix.'

- **Where:** §8 Trend 3 — Entitlement failure is the growth defect. Worsening.
- **This app does:** entitlement defect unfixed
- **User reaction:** 1★-burst
- **Magnitude:** 3.4% → 0% → 8.0% → 12.6% → 7.9%; absolute 3 → 0 → 8 → 16 → 5
- **Direction for us:** must-never-break · **Report confidence:** trend · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R12-060 — The onboarding was fixed — a 16-review spike Feb–Aug 2024 then near-silence, most likely a skip control — the corpus's one clear win; the cost of the delay: the spike coincides with the arrival of a large negative 2024 cohort

- **Where:** §8 Trend 4 — The onboarding was fixed. The corpus's one clear win; note the cost of the delay
- **This app does:** skip control added mid-2024 (inferred)
- **User reaction:** praise
- **Magnitude:** 0 → 1 → 16 (16.0% of 2024) → 1 (0.8%) → 3 (4.8%)
- **Direction for us:** must-have · **Report confidence:** clear · **Generalisable:** yes
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C075 Skippable, replayable onboarding tour

### R12-061 — The 5-star prompt first appears Feb 2024 and is more discussed in 2026 than ever; the 5★ count steps up in exactly the same period (1 in 2023, then 24, 29, 17) — correlated in time, but the corpus cannot establish causation; both are also consistent with a genuine 2024 product improvement

- **Where:** §8 Trend 5 — The 5-star prompt appears in 2024 and is more discussed in 2026 than ever; correlation with 5★ count not causal
- **This app does:** pre-use rating prompt since 2024
- **User reaction:** mixed
- **Magnitude:** 0 → 0 → 9 (9.0%) → 7 (5.5%) → 7 (11.1%); 5★ 1 → 24 → 29 → 17
- **Direction for us:** dont · **Report confidence:** trend, non-causal · **Generalisable:** yes
- **Review IDs:** `10905116935`, `14210464046`, `13960253250`, `14138334719`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C150 Never ask for a rating before the user has used the app

### R12-062 — Reliability is getting worse: two sub-themes new since Dec 2024 and still open in mid-2026 — calendar-sync failure and time-editing/12h-format bugs

- **Where:** §8 Trend 6 — Reliability is getting worse, not better; calendar-sync and time-editing bugs new since 2024 and still open
- **This app does:** unfixed 2024 regressions
- **User reaction:** 1★-burst
- **Magnitude:** bugs 11.4% → 3.8% → 9.0% → 16.5% → 17.5%; sync first 2024-12 latest 2026-06; time bug first 2024-12 latest 2026-07
- **Direction for us:** must-never-break · **Report confidence:** trend · **Generalisable:** yes
- **Review IDs:** `12021381513`, `13812177642`, `14329102917`
- **Canonical:** C030 Sync must work — and prove it; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C175 Updates must not break function or wipe progress

### R12-063 — The typo problem ('everywhere it is meant to say lunch, it instead says launch'; 'gonna gonna gonna I can't take it serious') was fixed and has not returned — a genuine completed remediation that took roughly 13 months and cost 12 reviews at mean 1.58

- **Where:** §8 Trend 7 — The typo problem was fixed and has not returned; it took roughly 13 months
- **This app does:** English text quality fixed by Feb 2023
- **User reaction:** complaint
- **Magnitude:** 12 complaints 2022-01 → 2023-02, then 0 across 259 reviews
- **Direction for us:** do · **Report confidence:** closed · **Generalisable:** yes
- **Review IDs:** `8200241804`, `9525710586`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R12-064 — Widget demand is new: zero requests before Nov 2024, then 1 / 7 / 1 — current, from retained users

- **Where:** §8 Trend 8 — Widgets became a demand only after 2024
- **This app does:** no widget
- **User reaction:** complaint
- **Magnitude:** 0 before 2024-11; 1 (2024), 7 (2025), 1 (2026); group mean 2.44
- **Direction for us:** build-free · **Report confidence:** trend · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free

### R12-065 — The lifetime-access promo giveaway (AppAdvice code) is a bounded, closed incident with two failure modes — the offer never appeared, or the entitlement was granted then lost or charged — no occurrences after May 2025

- **Where:** §8 Trend 9 — The promo giveaway is a bounded, closed incident
- **This app does:** promo entitlement not honoured
- **User reaction:** 1★-burst
- **Magnitude:** 8 reviews 2024-07-20 → 2025-05-28
- **Direction for us:** must-never-break · **Report confidence:** closed · **Generalisable:** yes
- **Review IDs:** `11514752409`, `12136171638`, `12060522005`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised

### R12-066 — Persistent unfixed themes across all periods: paywall, price, bugs, recurring tasks broken, notifications unreliable, parity with the built-in calendar; a request for weekday-specific repeating reminders in Jul 2022 recurs as 'no ability to have things repeat only on weekdays' in May 2026 — three years and ten months, same gap

- **Where:** §8 What persisted, unfixed, across the entire window table (verbatim); weekday-only repeat gap three years and ten months
- **This app does:** no weekday-only repeat
- **User reaction:** complaint
- **Magnitude:** Persistent theme | First | Last | Periods present ; Paywall blocks access | 2022-01-01 | 2026-08-05 | all 5 ; Price objection | 2021-12-28 | 2026-08-06 | all 5 ; Bugs / crashes | 2022-01-04 | 2026-06-05 | all 5 ; Recurring tasks broken | 2022-07-26 | 2026-05-19 | 4 of 5 ; Notifications unreliable | 2022-07-26 | 2026-04-28 | 3 of 5 ; Parity with built-in calendar | 2022-01-17 | 2026-07-21 | all 5
- **Direction for us:** must-have · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `8927844988`, `14082922244`
- **Canonical:** C039 Reminders fire reliably, once; C043 Flexible / custom frequency; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

## Positioning

### R12-001 — That Girl: Routine Planner (App Store ID 1597753705) — 'Cute Daily Calendar Schedule' — a hard-paywall, onboarding-heavy aesthetic routine/day planner; the report's decision question is whether that model is viable and what a competitor entering this space should build, price and avoid

- **Where:** header lines 1-10
- **This app does:** developer Solowei Group LTD (artistId 1683543614); Productivity (secondary Health & Fitness); hard paywall — 'fully paid and purchase is required to access any content'; store rank 12
- **User reaction:** 1★-burst
- **Magnitude:** 404 written reviews, 58 storefronts, 18 Dec 2021 → 16 Aug 2026; written mean 2.10 vs store aggregate 4.83 across 5,825 US ratings
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R12-018 — Store facts: v4.3.8 (15 May 2025, release notes 'Bug fix.'), first release 15 Dec 2021, English only, iPhone only (no iPad), iOS 17+, 79.5 MB, price label Free with IAPs; description states 'fully paid and purchase is required to access any content… Continued use requires an active subscription, which can be one-time, monthly or yearly'; Spanish storefronts renamed gender-neutral 'Daily Routine Planner Schedule'

- **Where:** §2.1 Store facts table (verbatim)
- **This app does:** see table
- **User reaction:** none
- **Magnitude:** Attribute | Value ; Version | 4.3.8 (current version released 2025-05-15) ; First release | 2021-12-15 ; Release notes (current) | "Bug fix." ; Category | Productivity (primary); Health & Fitness ; Age rating | 4+ ; Declared languages | English only ; Device support | iPhone only (no iPad listing); requires iOS 17.0+ ; Size | 79.5 MB ; Download price | Free; In-App Purchases: Yes ; Description (verbatim) | *"That Girl app is fully paid and purchase is required to access any content."* … *"That Girl is free to download. Continued use requires an active subscription, which can be one-time, monthly or yearly."* ; Storefront naming | `us/gb/de/au/ca/fr/br/it/ua/pl/nl` → "That Girl: Routine Planner"; `es`/`mx` → "Daily Routine Planner Schedule" (gender-neutral rename in Spanish-language storefronts)
- **Direction for us:** none · **Report confidence:** external · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R12-034 — One unique positioning gap: 'I was expecting a community where I could connect with like minded girls. It's just another habit tracker' — the 'That Girl' brand promises a social identity; the product delivers a solo planner

- **Where:** §3.1 One expectation gap is unique — expected a community
- **This app does:** brand implies community; product is solo
- **User reaction:** complaint
- **Magnitude:** n=1 (0.25%, WEAK)
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** app-specific
- **Review IDs:** `9078005343`
- **Canonical:** C015 Shared / group habits

## Anti-patterns

### R12-085 — The whole funnel is one anti-pattern with a measured cost: hard paywall with nothing evaluable → pre-use 5★ instruction → exit-offer discount ladder → entitlement failure → bouncing support address → refund denied → 1★ 'scam'; the cost is a 61.63% one-star written base and a 2.10 written mean under a 4.83 store average that reviewers publicly call out

- **Where:** Part 0 §4 the chain is mechanical; §2.2; §6.1; Part 9 For a competitor #1
- **This app does:** hard paywall + coerced rating + exit discounts + broken entitlements + no support
- **User reaction:** 1★-burst
- **Magnitude:** 1★ 249 of 404 (61.63%); 'scam' 42 (10.40%); paid 5★ 0 of 80; written 2.10 vs store 4.83
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11586279561`, `13638785503`, `12242542425`, `14329102917`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C150 Never ask for a rating before the user has used the app; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

## Things not to do

### R12-010 — The in-app 5-star prompt during onboarding is a compliance and data-integrity risk that is getting more visible: 'It said I had to give them 5 starts so here I am xx' (5★); reviewers draw the inference publicly — 'it makes you rate the app 5 stars which is probably why the ratings are good'; two independent reviewers in different countries named the exact 4.8 aggregate; concentrated in GB, PL, IT, CA, NL, MX and almost absent from the US; not proof of a guideline violation, but a material share perceive the request as coerced and the 4.83 vs 2.10 gap is visible to prospects

- **Where:** Part 0 §5 The in-app 5-star prompt is a compliance and data-integrity risk, and it is getting more visible
- **This app does:** asks for 5★ during onboarding before use
- **User reaction:** 1★-burst
- **Magnitude:** 23 (5.69%, HIGH-PRIORITY); 0% (2022–23) → 9.0% (2024) → 5.5% (2025) → 11.1% (2026); 2 of 23 in US
- **Direction for us:** dont · **Report confidence:** high-priority, rising · **Generalisable:** yes
- **Review IDs:** `13814071134`, `13279632399`, `11586279561`, `13638785503`, `13096698945`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C150 Never ask for a rating before the user has used the app

### R12-020 — Exit-offer / discount-ladder pricing: 'just to make you pay a life time… for 17,99. Then, when you are about to close the app… it says Wait don't go and changes the offer to 5.99'; '90% off from $4,990 to $499… then when you try to leave… suddenly the price drops to $89. It just feels so gross'; 'the wait don't go have it for £4 per year like that isn't another major red flag'; a countdown timer that still does not grant access; a 10× regional price change ($0.49 → $5/week); a hidden one-time offer found by swiping from the bottom-left; and a 5★ who left because of the exit discount

- **Where:** §2.2 price_dark_pattern — exit-offer / discount-ladder pricing
- **This app does:** 'wait don't go' exit discount, timers, hidden offers
- **User reaction:** 1★-burst
- **Magnitude:** price_dark_pattern 8 (1.98%, MEANINGFUL) mean 2.00; 2022-07 → 2026-03
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12242542425`, `13638785503`, `13817544776`, `12134476768`, `11588201167`, `8840832305`, `12573300694`, `13279632399`
- **Canonical:** C092 Regional pricing; C113 One stable, disclosed price — no discount wheels; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

### R12-072 — Move any rating request to after first meaningful use, using only the standard SKStoreReviewController flow with no incentive, no instruction and no gating

- **Where:** Part 9 Immediate — disclosure #6 Move any rating request to after first meaningful use; standard SKStoreReviewController only
- **This app does:** pre-use 5★ instruction
- **User reaction:** 1★-burst
- **Magnitude:** 23 (5.69%), 11.1% of 2026
- **Direction for us:** dont · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R12-073 — Collapse the SKU ladder — three weekly and three yearly SKUs at different prices are visible to every prospect on the store page and read as manipulation

- **Where:** Part 9 Immediate — disclosure #7 Collapse the SKU ladder
- **This app does:** 10 SKUs, duplicate names
- **User reaction:** 1★-burst
- **Magnitude:** 8 describe exit-offer; 42 use 'scam'
- **Direction for us:** dont · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

## Things to do

### R12-071 — Move 'purchase required to access any content' from the description body into the first screenshot and the subtitle — the sentence already exists; nobody reads it in place

- **Where:** Part 9 Immediate — disclosure #5 Move 'purchase required to access any content' into the first screenshot and the subtitle
- **This app does:** disclosure buried in description
- **User reaction:** blocked-conversion
- **Magnitude:** 162 (40.10%)
- **Direction for us:** do · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C181 If the app is paid-only, say so in the subtitle and first screenshot

### R12-083 — For a competitor: the praised job is narrow and clear — 'plan my day for me so I stop losing track of it', disproportionately voiced by ADHD and autistic users — build for that explicitly; narrated personalisation converts and unskippability cost 21 reviews, so ship both narrated and skippable; widgets, Watch, iPad, weekday-repeat, working sync and 12-hour time are a backlog someone else has already validated

- **Where:** Part 9 For a competitor #2 The praised job-to-be-done is narrow and clear — plan my day for me; #3 onboarding: ship narrated AND skippable; #4 six named unmet requests
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** outcome praise 22 mean 4.95; onboarding 21 against; 6 named requests
- **Direction for us:** do · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `12286335035`, `13203951770`, `9013967197`
- **Canonical:** C009 Basic widgets, icons and colours are free; C022 Apple Watch app (done properly: timer, two-way sync); C043 Flexible / custom frequency; C075 Skippable, replayable onboarding tour; C141 Native iPad layout; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

## Contradictions

### R12-011 — The onboarding — a narrated, unskippable explainer plus questionnaire — is the best-loved and most-hated part of the product: 'making them unskippable is insane', 'perky American reading everything out, you can't swipe through it faster' vs 'I love the way it has music at the start and it speaks!'; nine of 77 five-star reviews praise the onboarding while implying they have not used the product — the onboarding converts, the product does not retain ('The intro before you purchase seems to have more thought put into it then the actual app itself')

- **Where:** Part 0 §6 The onboarding is the best-loved and most-hated part of the product; the onboarding converts, the product does not retain
- **This app does:** long narrated unskippable onboarding with questionnaire
- **User reaction:** mixed
- **Magnitude:** against 21 (5.20%, HIGH-PRIORITY); for 5 cited; 9 of 77 5★ (11.69%) praise onboarding pre-use
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11396873201`, `10913036513`, `11500680241`, `11512469934`, `11511872399`, `11626061734`, `10923103793`, `11193945325`, `13096698945`, `10907144601`, `14337005478`, `12809171419`, `12663975904`, `10978019411`, `11652586176`, `14118054672`, `12990607438`, `11538597964`, `13366086371`, `13691510671`, `11513175352`, `11586279561`
- **Canonical:** C075 Skippable, replayable onboarding tour; C185 Aesthetic and a polished onboarding convert; they do not retain

## Data caveats and method

### R12-002 — Method: denominator 404, non-exclusive themes (one review can carry six labels), standard bands; full manual read of all 404 records in original language with a regex classifier run independently and disagreements adjudicated record-by-record in favour of the manual reading; only the US (135) clears 50 (next GB 40, DE 20, AU 18, CA 17); 0 duplicate pairs, 0 empty bodies, is_edited true for 1; vote_sum 94 total (too sparse); reconciliation exact

- **Where:** How to read this; Part 1 SCOPE AND METHOD table (verbatim); §10.3–10.5 method
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Item | Value ; Files read | `reviews.jsonl` (404 records), `by_country/*.jsonl` (58 files, 404 records), `manifest.json` ; Records read | 404 / 404 (100%) — every record read in full, in original language ; Reconciliation | Merged file ↔ union of 58 country files: identical sets, 0 discrepancies. `manifest.reviews_per_country` matches per-file counts exactly. `manifest.rating_distribution` matches computed distribution exactly. ; Unique review IDs | 404 / 404 (no duplicates) ; Exact-duplicate (title+body) pairs | 0 — no deduplication was applied or needed; denominator is 404 throughout ; Empty review bodies | 0 ; Date range | 2021-12-18 → 2026-08-16 (4 years 8 months) ; Storefronts | 58 ; Countries ≥ 50 reviews (eligible for standalone analysis) | US only (135). Next: GB 40, DE 20, AU 18, CA 17 ; Schema fields used | `review_id`, `country`, `country_name`, `rating`, `title`, `body`, `date`, `vote_count`, `vote_sum`, `is_edited`, `author`, `app_id`, `app_name` ; Fields present but not used analytically | `author` (PII-adjacent, no analytic value), `app_id`/`app_name` (constant), `vote_sum` (94 total votes across corpus — too sparse to weight) ; `is_edited` | True for 1 record only — no version-of-record ambiguity ; Method | Full manual read of all 404 records in country/date order, producing hand-assigned theme membership; a regex classifier was run independently and its disagreements with the manual pass were adjudicated record-by-record in favour of the manual reading. Aggregation, cross-tabs and the audit index were generated programmatically from the hand-assigned ID lists.
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R12-003 — The star rating is not a clean sentiment measure: 23 reviewers describe an in-app prompt asking for 5 stars during onboarding before use; two of the 77 five-star reviews say in plain text they rated 5 because they were told to; 14 of 77 five-star reviews carry text contradicting the rating — treat 5★ counts as an upper bound on satisfaction

- **Where:** ⚠️ Two warnings — 1. The star rating in this corpus is not a clean sentiment measure for this app
- **This app does:** rating prompt inside onboarding
- **User reaction:** mixed
- **Magnitude:** 23 (5.69%); 2 of 77 coerced; 14 of 77 (18.18% of 5★) contradict
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13814071134`, `13279632399`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C150 Never ask for a rating before the user has used the app

### R12-004 — Written reviews are ~2.4% of ratings; written reviewers skew to complainers AND, for this app, to people who escaped the onboarding rating prompt — the 4.83 store average and the 2.10 written mean describe two different populations, and neither alone describes the product

- **Where:** ⚠️ Two warnings — 2. Written reviews are ~2.4% of ratings
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 12,784 ratings vs 309 written across 13 storefronts (2.42%); 4.83 vs 2.10
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R12-025 — Thirty-one themes ranked with direction, n, %, signal, mean and window

- **Where:** Part 3 GLOBAL FINDINGS all themes ranked table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | Dir. | n | % | Signal | Mean ★ | Window ; 1 | Paywall blocks all access | − | 162 | 40.10% | High-priority | 1.30 | 2021-12 → 2026-08 ; 2 | Any praise component | + | 91 | 22.52% | High-priority | 4.31 | 2021-12 → 2026-08 ; 3 | Self-identified paying customer | − | 80 | 19.80% | High-priority | 1.31 | 2022-04 → 2026-08 ; 4 | No free trial / can't test first | − | 62 | 15.35% | High-priority | 1.35 | 2022-01 → 2026-07 ; 5 | Bugs, crashes, freezes | − | 52 | 12.87% | High-priority | 1.60 | 2022-01 → 2026-06 ; 6 | Price objection | − | 50 | 12.38% | High-priority | 1.72 | 2021-12 → 2026-08 ; 7 | Paid but no access (entitlement) | − | 33 | 8.17% | High-priority | 1.15 | 2022-07 → 2026-03 ; 8 | Coerced 5-star rating prompt | − | 23 | 5.69% | High-priority | 1.57 | 2024-02 → 2026-06 ; 9 | Sustained outcome praised | + | 22 | 5.45% | High-priority | 4.95 | 2022-11 → 2026-06 ; 10 | Refund sought / denied | − | 21 | 5.20% | High-priority | 1.05 | 2022-04 → 2026-04 ; 11 | Onboarding friction (long/unskippable/voice) | − | 21 | 5.20% | High-priority | 1.76 | 2023-08 → 2026-07 ; 12 | Aesthetic praised | + | 17 | 4.21% | Very strong | 2.59 | 2022-08 → 2026-04 ; 13 | Support unreachable / email invalid | − | 15 | 3.71% | Very strong | 1.47 | 2024-08 → 2026-06 ; 14 | No differentiation vs built-in calendar | − | 13 | 3.22% | Very strong | 1.38 | 2022-01 → 2026-07 ; 15 | Customisation too limited | − | 13 | 3.22% | Very strong | 1.92 | 2022-07 → 2026-04 ; 16 | English text quality / typos | − | 12 | 2.97% | Meaningful | 1.58 | 2022-01 → 2023-02 ; 17 | Data loss / edits not saved | − | 11 | 2.72% | Meaningful | 1.82 | 2022-08 → 2026-06 ; 18 | Widget requested | − | 9 | 2.23% | Meaningful | 2.44 | 2024-11 → 2026-07 ; 19 | Promotional "free lifetime" not honoured | − | 8 | 1.98% | Meaningful | 1.50 | 2024-07 → 2025-05 ; 20 | Exit-offer / discount-ladder pricing | − | 8 | 1.98% | Meaningful | 2.00 | 2022-07 → 2026-03 ; 21 | Calendar sync broken | − | 8 | 1.98% | Meaningful | 2.25 | 2024-12 → 2026-06 ; 22 | Recurring tasks broken/absent | − | 8 | 1.98% | Meaningful | 2.62 | 2022-07 → 2026-05 ; 23 | Time editing / 12h format bug | − | 8 | 1.98% | Meaningful | 2.62 | 2024-12 → 2026-07 ; 24 | Apple Watch / iPad requested | − | 7 | 1.73% | Meaningful | 3.14 | 2023-04 → 2026-06 ; 25 | Notifications missing or unreliable | − | 6 | 1.49% | Meaningful | 2.83 | 2022-07 → 2026-04 ; 26 | Language not available (non-EN) | − | 5 | 1.24% | Meaningful | 2.60 | 2021-12 → 2024-04 ; 27 | Cannot plan ahead / calendar depth | − | 5 | 1.24% | Meaningful | 3.80 | 2022-08 → 2025-02 ; 28 | Gender targeting objection | − | 4 | 0.99% | Emerging | 2.00 | 2023-03 → 2026-02 ; 29 | Privacy / data-harvesting concern | − | 3 | 0.74% | Emerging | 1.00 | 2022-07 → 2025-01 ; 30 | ADHD / autism use case | + | 3 | 0.74% | Emerging | 3.67 | 2022-08 → 2025-09 ; 31 | Feature removal after update | − | 1 | 0.25% | Weak | 1.00 | 2024-11
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R12-036 — Band meanings and 1★ causes: 5★ not reliable as praise; 4★ 'I like it, but one named gap'; 3★ half paywall objection, half specific bug; 2★ 'beautiful but paywalled'; 1★ paywall 53.8%, bugs 14.9%, price 13.3%, entitlement 12.4%, no trial 19.3%, refund 8.0%, rating prompt 7.2%

- **Where:** Part 5 RATINGS ANALYSIS band table (verbatim); §5.5 1★ four causes table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ★ | n | % of 404 | What it means in this corpus ; 5 | 77 | 19.06% | Not reliable as praise — see §5.1 ; 4 | 14 | 3.47% | Almost entirely "I like it, but one named gap" ; 3 | 31 | 7.67% | Split: half paywall objection, half specific bug ; 2 | 33 | 8.17% | "Beautiful but paywalled" — the aesthetic-praise cluster lives here ; 1 | 249 | 61.63% | Paywall (53.8%), bugs (14.9%), price (13.3%), entitlement (12.4%) ;; 1★: Cause | n | % of 1★ ; Paywall / cannot use without paying | 134 | 53.82% ; Bugs, crashes, freezes | 37 | 14.86% ; Price too high | 33 | 13.25% ; Paid but no access | 31 | 12.45% ; No trial | 48 | 19.28% ; Refund | 20 | 8.03% ; Rating prompt | 18 | 7.23%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R12-037 — The 5★ population audited line by line: only 51 of 404 (12.62%) are 5★ ratings supported by post-use praise; 9 praise the onboarding pre-use; 14 have text contradicting the rating ('Super faulty i can't add a to do list without it just freezing' at 5★; 'Don't download!!' at 5★); 3 content-free

- **Where:** §5.1 The 5★ population, audited line by line table (verbatim); Only 51 of 404 reviews are 5★ ratings supported by post-use praise
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Category | n | % of 5★ | IDs ; Praise from actual sustained use | 51 | 66.23% | incl. `12286335035`, `13936002411`, `11585180763`, `13203951770`, `13949586588`, `11755587287`, `9333260206`, `10972036961` ; Praise of the onboarding, pre-use | 9 | 11.69% | `12990607438`, `12809171419`, `12663975904`, `10978019411`, `11538597964`, `11652586176`, `13366086371`, `13691510671`, `11513175352` ; Text contradicts the 5★ rating | 14 | 18.18% | `12558262311`, `10906821521`, `13814071134`, `14109640681`, `12162547099`, `13279632399`, `11516189475`, `12573300694`, `8365324787`, `9110981116`, `11446516100`, `11513929479`, `12765812399`, `13550565309` ; Content-free | 3 | 3.90% | `14377536260`, `12890217553`, `12754890042`
- **Direction for us:** none · **Report confidence:** audit · **Generalisable:** app-specific
- **Review IDs:** `14109640681`, `12558262311`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C150 Never ask for a rating before the user has used the app

### R12-048 — Cannot be claimed: conversion rate, revenue split by SKU, refund rate (21 mentions is a floor), or a causal claim that the rating prompt produced the 4.83 average (one documented contributor among several)

- **Where:** §6.5 What cannot be claimed from this corpus
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** n/a
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R12-084 — Research questions: did the 2024 5★ step-change come from the rating prompt, a product improvement, or both; was the water/food/journal set actually removed in 2024 or did the reviewer lose access via the entitlement bug; why is the rating-prompt complaint 1.48% in the US vs 5.69% globally; actual trial→paid and refund rates; does the ES/MX gender-neutral rename outperform controlling for market; is 'WSTR: Daily Planner Schedule' (same developer, ID 6478762880) the 'exact same app with another name' a reviewer alleges

- **Where:** Part 9 Research questions this corpus cannot answer; part 9 #1; part 9 #2; part 9 #3; part 9 #4; part 9 #5; part 9 #6
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 6 questions
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** yes
- **Review IDs:** `11901631540`, `12215752061`
- **Canonical:** — (nuance register)
