# Cards — report 46

Source: `App Store Reports/46. everyday - Habit Tracker - Daily Routine Checklist (REPORT).md`  
172 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 11
- [Must-haves](#must-haves) — 11
- [Must never break](#must-never-break) — 14
- [Features](#features) — 22
- [Monetization](#monetization) — 20
- [Tactics the app used](#tactics-the-app-used) — 4
- [Insights (the why)](#insights-the-why) — 17
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 19
- [Dated events and trends](#dated-events-and-trends) — 15
- [Positioning](#positioning) — 5
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 7
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 21

## Product rules

### R46-029 — Do not paywall dark mode, and never move it behind the paywall in an update: 'pagar isso só pra ter modo escuro ou off-line' (BR, 2020); 'Dark mode under paywall?' (CZ); 'New update moved dark mode behind a paywall' (US, Jun 2024)

- **Where:** §2.2 Dark mode paywalled — in 2020 ('pay this just to have dark mode or offline') and again in June 2024 ('New update moved dark mode behind a paywall'; 'Dark mode under paywall?')
- **This app does:** dark mode paid (2020, 2024)
- **User reaction:** complaint
- **Magnitude:** 3 reviews
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `6139789378`, `11054384115`, `11382464605`
- **Canonical:** C001 Never move a free feature behind the paywall; C080 Colour themes / dark mode; C104 Never ship a paywall or feature-removal change silently

### R46-030 — Do not gate offline check-off: free users need a connection to tick a habit — 'ticking off habits while offline are locked behind a paywall' (4 reviews) — the mechanism behind China's 'offline mode' cluster

- **Where:** §2.2 Offline use requires a connection unless paid — 'ticking off habits while offline are locked behind a paywall'
- **This app does:** offline paid
- **User reaction:** complaint
- **Magnitude:** 4 reviews
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `9029601554`, `10143971103`, `10618466787`, `13460787737`
- **Canonical:** C188 The app must open offline — never block launch on a network call

### R46-061 — Offline use blocked for free users 7 (0.32%, 2.14); paywalled capability (dark mode, offline) 8 (2.12)

- **Where:** §3.1 master table #79 rel_offline_use_blocked / #76 mf_paywalled_capability
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 7 + 8
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C188 The app must open offline — never block launch on a network call

### R46-076 — Size the free tier to the product's own display unit: the home-screen widget holds four rows and the free tier allows three habits — 'when I use the widget (which fits 4 habits) it leaves the 4th row blank because i can only have 3 and it bothers me so much' (4★); 'makes many widgets appear broken as they tend to have a multiple of 4 rows' (1★)

- **Where:** §3.4.1 The widget defect — the home-screen widget holds four rows, the free tier allows three: 'it leaves the 4th row blank… it bothers me so much'; 'makes many widgets appear broken as they tend to have a multiple of 4 rows' — the free tier is sized below the product's own display unit
- **This app does:** 3 habits vs 4-row widget
- **User reaction:** complaint
- **Magnitude:** 2 reviews
- **Direction for us:** product-rule · **Report confidence:** concrete defect · **Generalisable:** yes
- **Review IDs:** `9997347192`, `12334331759`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R46-081 — Gating dark mode is small-revenue, high-irritation, and shows up as 1★ at the exact moment it changes: paywalled capabilities other than habit count 8 (0.37%, mean 2.12) — dark mode ('New update moved dark mode behind a paywall. Immediate deletion') and offline use

- **Where:** §3.4.2 Paywalled capabilities other than habit count (8, mean 2.12) — dark mode ('New update moved dark mode behind a paywall. Immediate deletion') and offline use — gating dark mode is a small-revenue, high-irritation choice that shows up in 1★ and 2★ at the moment it changes
- **This app does:** dark mode + offline paid
- **User reaction:** 1★-burst
- **Magnitude:** 8 (2.12)
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `6139789378`, `11054384115`, `11382464605`, `10143971103`, `10618466787`, `13460787737`, `10448268225`
- **Canonical:** C001 Never move a free feature behind the paywall; C080 Colour themes / dark mode; C188 The app must open offline — never block launch on a network call

### R46-146 — Return dark mode to the free tier — small revenue, high irritation, lands in reviews the week it changes

- **Where:** §8.1 #7
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** paywalled capability 8 (2.12)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11382464605`, `11054384115`, `6139789378`
- **Canonical:** C001 Never move a free feature behind the paywall; C080 Colour themes / dark mode

### R46-148 — Raise the free tier from 3 to 4 habits — the smallest change that fixes the 4-row widget defect and answers the modal counter-offer (every reviewer who names a number names 4–7), without touching the habit-science argument 66 make for a small tier; report 43 shows a loosened cap removing the theme within two years

- **Where:** §8.2 #9
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** cap 180 (2.43), 41.0% of 1★; more free 29
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9997347192`, `12334331759`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R46-153 — Allow offline check-off in the free tier, syncing when back online — requiring a connection to tap a square reads as a paywall on the core loop

- **Where:** §8.2 #14
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** offline blocked 7 (2.14)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `7098518884`, `9029601554`, `10143971103`, `13460787737`
- **Canonical:** C188 The app must open offline — never block launch on a network call

### R46-155 — Do not add complexity to justify the price — simplicity 425 rising every era; 'pls dont do that'; justify price with ownership options and colour, not features

- **Where:** §8.3 #16
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** simplicity 425; no gamification 3 (5.00)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12631375398`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R46-156 — Do not remove or harden the forgiving skip — the neurodivergent segment's named mechanism ('neutral data instead of a personal failing')

- **Where:** §8.3 #17
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** skip forgiving 41 (4.93)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10483508663`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R46-158 — Do not gate further existing capabilities — each dark-mode episode produced immediate 1–2★ reviews

- **Where:** §8.3 #19
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** paywalled capability 2.12
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall

## Must-haves

### R46-044 — Design dated or clunky 34 (1.56%, mean 3.56) — non-native controls, a webview on desktop

- **Where:** §3.1 master table #29 ux_design_dated_or_clunky
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 34 (1.56%), 3.56
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C057 Offer a non-pastel / premium design option; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R46-050 — Onboarding confusion 19 (0.87%, mean 3.95)

- **Where:** §3.1 master table #47 ux_onboarding_confusion
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 19 (0.87%), 3.95
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R46-062 — Locked out after the trial 4 (0.18%, 3.75) — free users unable to archive or delete after a trial

- **Where:** §3.1 master table #93 mf_locked_out_after_trial
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 (0.18%), 3.75
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `9243772066`
- **Canonical:** C109 A free trial must be a real trial; C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

### R46-064 — Account deletion requested 3 (2020, 2.00); no Family Sharing 2 (2.00); review pressure from the developer 2 (2.50)

- **Where:** §3.1 master table #98 fr_account_deletion / #105 mf_no_family_sharing / #106 sup_review_pressure
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 3 + 2 + 2
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `5869846139`, `6518400889`, `6643634090`
- **Canonical:** C037 Family plan; C189 Public review replies answer the specific complaint — never canned, never argue price, never press a reviewer to change the rating; C249 Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot

### R46-086 — Explain the marks with a legend the user can find again: the half-square and triangle skip marks confuse a minority for seven years — '颜色只有半格是什么意思啊？' ('What does a half-filled square mean?', 2019); '半个格到底是什么意思啊，没看见介绍再也找不着了' ('I missed the intro and can't find it again'); 'What does the triangle and squares mean?????' (1★); 'Why would they make me have to put a half triangle for a habit that is only supposed to be done weekly? So demoralizing… I signed up for the yearly but will cancel until this is fixed' (subscriber, 2★); 'Nu prea înțeleg rostul acelor triunghiuri' (Feb 2026) — a one-screen legend fixes it (19, 0.87%, mean 3.79)

- **Where:** §3.4.4 ux_symbols_confusing 19 — seven years of the same question from the first-run screen: 'What does a half-filled square mean?' (CN 2019); 'I missed the intro and can't find it again'; 'What does the triangle and squares mean?????' (1★); 'Why would they make me have to put a half triangle for a habit that is only supposed to be done weekly? So demoralizing… will cancel until this is fixed' (subscriber); 'I don't really understand the point of those triangles' (Feb 2026) — a one-screen legend fixes it
- **This app does:** unexplained skip symbols
- **User reaction:** complaint
- **Magnitude:** 19 (0.87%), 3.79
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `4850070969`, `4869150597`, `7384017889`, `10257601209`, `13762762742`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

### R46-087 — A shared web-view UI reads as non-native on every platform, and an unrequested completion animation cost a subscriber: design dated / clunky 34 (1.56%, mean 3.56) — 'It really looks like they have tried to shoehorn the webview into a smaller screen' (2019); 'the desktop UI is too heavily shaped by the mobile UI' (KR); 'no sigue ningún patrón de diseño esperado en iOS' (MX); the December 2022 completion animation — 'please remove the new animation whenever u log a day it's so annoying'; 'Special FX update unnecessary… I'll not renew' (2★, subscriber)

- **Where:** §3.4.4 ux_design_dated_or_clunky 34 — non-native controls, a mobile layout on desktop ('shoehorn the webview into a smaller screen'; 'the desktop UI is too heavily shaped by the mobile UI'; 'follows none of the expected iOS design patterns'); the Dec 2022 completion animation regression ('please remove the new animation whenever u log a day it's so annoying'; 'Special FX update unnecessary… I'll not renew', subscriber)
- **This app does:** webview UI; forced animation
- **User reaction:** complaint
- **Magnitude:** 34 (1.56%), 3.56
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `3642699474`, `10906751585`, `10932557854`, `9443080997`, `9462122321`
- **Canonical:** C057 Offer a non-pastel / premium design option; C069 Check-off sound and haptic; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R46-089 — Support sub-themes: responsive praise 53 (2.43%, mean 4.94); unresponsive 7 (0.32%, 1.57 — 'Leider keine zeitnahe Antwort auf Anfrage wegen eines Fehlers'; 'sent 3 different email… Not a single reply'; four of the seven 2024–2026 and two paying customers with unresolved data loss or an unrecognised subscription); hostile developer reply 6 (0.28%, 1.33); review pressure 2 (2.50)

- **Where:** §3.4.5 Support and the developer's public voice (verbatim table) — responsive praise 53 (4.94); unresponsive 7 (1.57; 'sent 3 different email… Not a single reply'; four of seven 2024–26, two paying); hostile reply 6 (1.33); review pressure 2 (2.50)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Sub-theme | n | % | Mean ★ | Signal | Period ; sup_responsive_praise | 53 | 2.43% | 4.94 | meaningful | 2019–2026 ; sup_unresponsive | 7 | 0.32% | 1.57 | weak | 2022–2026 ; sup_dev_reply_hostile | 6 | 0.28% | 1.33 | weak | 2021–2026 ; sup_review_pressure | 2 | 0.09% | 2.50 | ignore by count; stated because it concerns review integrity | 2023–2024
- **Direction for us:** must-have · **Report confidence:** very strong (union) · **Generalisable:** yes
- **Review IDs:** `8285529014`, `8409233319`, `9525145329`, `11089487551`, `13298363427`, `13765557194`, `14423487007`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C189 Public review replies answer the specific complaint — never canned, never argue price, never press a reviewer to change the rating

### R46-095 — When a trial ends, the user must be able to delete or archive the habits above the free cap: 'after the trial I can't delete the extra habits — they're locked' (DE, 4★); free users report being unable to archive or delete after a trial (locked out after trial 4)

- **Where:** §4.2 after the trial the extra habits are locked and cannot be deleted — 'Jedoch kann ich sie nicht löschen'
- **This app does:** post-trial lockout
- **User reaction:** complaint
- **Magnitude:** 4 + 1
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `8681575995`, `9243772066`
- **Canonical:** C109 A free trial must be a real trial; C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

### R46-145 — Add a one-screen legend for the half-square, triangle and faded marks, reachable from the grid — seven years of the same question; a subscriber threatening to cancel over it

- **Where:** §8.1 #6
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** symbols confusing 19
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `4850070969`, `13762762742`, `10257601209`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R46-147 — After a trial ends, let the user choose which 3 habits stay active and archive — not lock — the rest ('I can't delete them… it falsifies the statistics'; 'a bunch of habits on my screen now that I can't get rid of') — the post-trial first impression for every non-converter

- **Where:** §8.1 #8
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** locked out after trial 4
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `5695267165`, `6154641193`, `8681575995`, `9243772066`
- **Canonical:** C109 A free trial must be a real trial; C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

### R46-157 — Keep the interactive widget but add a lock / view-only mode to stop accidental taps

- **Where:** §8.3 #18
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** widget 66 (4.79) vs accidental tap 3
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10386394785`, `11108703405`, `13783066497`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app; C090 Destructive actions on widgets, quick surfaces and running routines need confirmation or undo

## Must never break

### R46-013 — For an app whose value is an unbroken visual record, silently rewritten history is the highest-severity failure: data loss 24 reviews (1.10%, mean 2.12), doubling across halves (0.73% → 1.47%), 13 of 24 in 2024–26 and 8 of 24 paying customers; all four 2026 cases are Russian, 7 Feb → 1 Mar 2026 ('marks from a couple of days or even a week ago disappear'; 'it can wipe the last 3–4 days. With a subscription'; 'nobody was going to refund me… minus ₽1000') — a live incident until release logs say otherwise; elsewhere 'I used this app for two months and it suddenly reset and lost all my data. What am I paying $29.99/year for…? I want a refund'; 'every 1 or 2 months it suddenly loses almost all progress'; 'the results for habit one are somehow already displayed for habit three… essentially nonfunctional' (paid); 'The widgets constantly display wrong info and the app itself just randomly changes input. I REALLY regret buying this' (€99 lifetime); the data-integrity union (loss, sync, stale widgets, accidental taps) is 56 (2.57%)

- **Where:** Executive summary #6 — data loss is the most severe defect and rising: 24 (1.10%, mean 2.12), 0.73% → 1.47%, 13 of 24 in 2024–26, 8 of 24 payers; all four 2026 cases from the Russian storefront 7 Feb → 1 Mar 2026 ('marks from a couple of days or even a week ago disappear'; 'it can wipe the last 3–4 days. With a subscription'; 'nobody was going to refund me… minus ₽1000'); 'suddenly reset and lost all my data. What am I paying $29.99/year for'; 'every 1 or 2 months it suddenly loses almost all progress'; 'results for habit one are somehow already displayed for habit three'; 'widgets constantly display wrong info… I REALLY regret buying this' (€99 lifetime); data-integrity union 56 (2.57%)
- **This app does:** history rewritten / wiped
- **User reaction:** churn
- **Magnitude:** 24 (1.10%), 2.12; 0.73 → 1.47%; 8 payers; RU cluster 4 (Feb 2026); union 56 (2.57%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful; highest severity · **Generalisable:** yes
- **Review IDs:** `13721978399`, `13741293681`, `13765557194`, `13802922048`, `11748480154`, `13339379159`, `13416396839`, `12356330098`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C040 Widgets must not go blank, stale or disagree with the app; C153 Automatic cloud backup on by default — never manual opt-in

### R46-015 — A subscription with a trial has more ways to fail at the exact moment money moves, and this corpus shows each: 97 payers (4.45%; 74 subscribers, 16 lifetime, 13 charged) average 3.95 vs 4.35 for the rest, 12.4% of them at 1★ vs 7.4%; 21 of 97 (21.6%) hit a reliability defect after paying (8 data loss, 6 sync); 13 billing failures (0.60%, mean 2.31) — charged on day one of the 7-day trial ('Offerred 7 day trial, but I got charged the same day', twice), the subscription not recognised ('$29 and it won't even recognize the paid subscription. I reached out to Joan via email and didn't get a response', Aug 2026; premium on iPad but not on iPhone), a wrong amount ('charged CHF 40.45 instead of CHF 29.95'), three refund requests — against 2 refund references in 638 for report 43's one-time app

- **Where:** Executive summary #8 — payers rate lower (97 payers 4.45%: 74 subscribers, 16 lifetime, 13 charged; mean 3.95 vs 4.35; 12.4% 1★ vs 7.4%); 21 of 97 (21.6%) hit a defect after paying (8 data loss, 6 sync); 13 billing failures (0.60%, 2.31): charged on day one of a 7-day trial ×2; subscription not recognised ('$29 and it won't even recognize the paid subscription. I reached out to Joan… no response', Aug 2026; premium on iPad not iPhone); wrong amount (CHF 40.45 vs 29.95); 3 refund requests — a subscription with a trial has more ways to fail at the moment money moves
- **This app does:** 7-day trial → subscription
- **User reaction:** churn
- **Magnitude:** payers 3.95 vs 4.35; defect 21/97 (21.6%); billing 13 (2.31)
- **Direction for us:** must-never-break · **Report confidence:** very strong (segment) · **Generalisable:** yes
- **Review IDs:** `11022906761`, `12285802750`, `6866992048`, `14423487007`, `6863161594`, `10373652027`, `6593564259`, `11748480154`, `13765557194`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C109 A free trial must be a real trial

### R46-047 — Crash / freeze 25 (1.15%, 3.04), 2019–2024; misc bugs 23 (1.06%, 3.17)

- **Where:** §3.1 master table #39 rel_crash_freeze / #42 rel_misc_bug
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 25 + 23
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C175 Updates must not break function or wipe progress

### R46-053 — Layout / scroll bug 13 (3.38); Mac performance 9 (3.78) — 'The Mac app is slow and clunky'; notifications broken 7 (3.14)

- **Where:** §3.1 master table #57 rel_layout_scroll_bug / #71 rel_mac_performance / #78 rel_notifications_broken
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 13 + 9 + 7
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once; C044 Mac / desktop / web app; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R46-058 — Login / sign-up failures 9 (0.41%, mean 1.89), concentrated in the account-required era — the first review could not sign up; a password reset never arrives; a Sign in with Apple loop; account not recognised, data gone

- **Where:** §3.1 master table #70 rel_login_signup_fail
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 9 (0.41%), 1.89
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `3038410981`, `5051054298`, `8409233319`, `10771638093`, `10988898467`
- **Canonical:** C035 Account system from day one; C077 Purchase and signup flow must not leak buyers

### R46-082 — Reliability shrank in rate (12.63% → 10.22% → 4.38% → 4.55% by era; union 151, 6.93%, mean 3.05) but worsened in kind — early defects were outages that recovered, recent ones are silent corruption of the record: crash / freeze 25 (3.04); data loss 24 (2.12); misc 23; widget broken 21 (3.33); offline-mode bug 17 (3.53); sync 15 (3.13); layout / scroll 13; login / sign-up 9 (1.89); Mac performance 9; notifications broken 7; offline use blocked 7 (2.14); accidental tap 3

- **Where:** §3.4.3 Reliability (verbatim sub-theme table) — 151 (6.93%, mean 3.05): crash / freeze 25; data loss 24; misc 23; widget broken 21; offline-mode bug 17; sync 15; layout / scroll 13; login / signup 9 (1.89); Mac performance 9; notifications 7; offline use blocked 7; accidental tap 3; the rate falls 12.63% → 10.22% → 4.38% → 4.55% but the composition worsened — early defects were outages, recent ones are silent corruption of the record
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Sub-theme | n | % of 2,178 | Mean ★ | Signal | Period ; rel_crash_freeze | 25 | 1.15% | 3.04 | meaningful | 2019–2024 ; rel_data_loss | 24 | 1.10% | 2.12 | meaningful | 2020–2026 ; rel_misc_bug | 23 | 1.06% | 3.17 | meaningful | 2019–2026 ; rel_widget_broken | 21 | 0.96% | 3.33 | emerging | 2021–2025 ; rel_offline_mode_bug | 17 | 0.78% | 3.53 | emerging | 2019–2023 ; rel_sync_issues | 15 | 0.69% | 3.13 | emerging | 2020–2026 ; rel_layout_scroll_bug | 13 | 0.60% | 3.38 | emerging | 2019–2025 ; rel_login_signup_fail | 9 | 0.41% | 1.89 | weak | 2018–2024 ; rel_mac_performance | 9 | 0.41% | 3.78 | weak | 2020–2025 ; rel_notifications_broken | 7 | 0.32% | 3.14 | weak | 2019–2023 ; rel_offline_use_blocked | 7 | 0.32% | 2.14 | weak | 2021–2025 ; rel_accidental_tap | 3 | 0.14% | 3.67 | weak | 2023–2026
- **Direction for us:** must-never-break · **Report confidence:** high-priority (union) · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change

### R46-084 — Widgets and sync show wrong or stale data and interactive widgets record taps nobody meant: widget broken 21 (0.96%, mean 3.33 — 'After January ended I deleted the Dry January task but the widget still shows it'; '每天都会发生主屏幕小组件色块混乱的情况'; 'The widget is the heart of the application', 1★ still failing after contact); sync 15 (0.69% — 'finished goals on the watch won't show up on the phone and vice versa… a deal breaker'; 'The Mac app is slow and clunky. Does not sync with my phone app in a timely manner. I paid a hefty price to sync with all my devices', subscriber); accidental tap 3 ('If touched accidentally it marks the completion of that day by mistake as well. Not great for a paid app'; 'Make separate view and edit modes for the board') — the data-integrity union (loss ∪ sync ∪ widget ∪ accidental tap) is 56 (2.57%, mean 2.91), rising 1.08% → 2.95%

- **Where:** §3.4.3 Recent era — the record itself becomes unreliable: widget broken 21 ('After January ended I deleted the Dry January task but the widget still shows it'; 'every day the home-screen widget colour blocks get scrambled'; 'The widget is the heart of the application', 1★ after contact); sync 15 ('finished goals on the watch won't show up on the phone and vice versa… a deal breaker'; 'The Mac app is slow and clunky. Does not sync… I paid a hefty price to sync with all my devices'); accidental taps on the interactive widget ('marks the completion of that day by mistake… Not great for a paid app'; 'Make separate view and edit modes for the board'); data-integrity union 56 (2.57%, mean 2.91), 1.08% → 2.95%
- **This app does:** widget / sync integrity
- **User reaction:** churn
- **Magnitude:** widget 21; sync 15; tap 3; union 56 (2.57%), 1.08 → 2.95%
- **Direction for us:** must-never-break · **Report confidence:** meaningful, rising · **Generalisable:** yes
- **Review IDs:** `12294579474`, `12473456800`, `11527532536`, `10277533659`, `13459643027`, `10386394785`, `13783066497`
- **Canonical:** C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change; C040 Widgets must not go blank, stale or disagree with the app

### R46-099 — Every payer at 1★ is a delivery or billing failure, none a design objection: 12 of 166 (7.2%) — crashes on an iOS 9 iPad mini; premium activated on iPad not recognised on iPhone (TW); a trial not recognised; a $40 annual whose history 'vanishes' (moved to Done); a stale widget with accidental taps; squares erased; a lifetime that keeps resetting; charged on day one of the trial (twice); all data lost with a refund demand; results reassigned between habits; a subscription not recognised with no reply

- **Where:** §4.5 12 of 166 one-star reviews (7.2%) are payers — crashes on an iOS 9 iPad mini; premium not recognised on iPhone (TW); trial not recognised; $40 annual, history 'vanishes', moved to Done; widget stale + accidental taps; squares erased; lifetime keeps resetting; charged on day one of the trial ×2; all data lost, refund; results reassigned between habits; subscription not recognised, no reply — every one a delivery or billing failure, none objects to the design
- **This app does:** post-purchase failures
- **User reaction:** churn
- **Magnitude:** 12/166 1★ (7.2%)
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `5138933764`, `6863161594`, `6866992048`, `6998451648`, `10386394785`, `10514724470`, `10951679021`, `11022906761`, `11748480154`, `12285802750`, `13416396839`, `14423487007`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R46-108 — Entitlement must sync across devices and accounts, because failure at the moment of purchase produces the lowest-rated reviews a payer can write: post-purchase failures among 97 payers — any reliability defect 21 (21.6%); billing failure 13 (13.4%); data loss 8 (8.2%); sync failure 6 (6.2%); subscription or trial not recognised 4 ('Subscribed to free trial, have email confirmation from Apple. App does not recognize it and won't let me add more than three habits, even after refreshing the subscription with the provided link. On to the next app...'; '明明都在pad己開通高級版，Iphone上卻不給用'; one resolved only by refund and re-purchase); refund sought 4; widget broken after paying 3; crash 3; charged on day one of a 'free trial' 2; wrong amount 1 (CHF 40.45 for 29.95); support unanswered 2

- **Where:** §5.4 Post-purchase failures (verbatim table) — any defect 21 (21.6%); billing 13 (13.4%); data loss 8; sync 6; subscription / trial not recognised 4; refund 4; widget broken 3; crash 3; charged on day one of a trial 2; wrong amount 1; support unanswered 2; the subscription-recognition cluster fails at the moment of purchase: 'App does not recognize it and won't let me add more than three habits, even after refreshing the subscription with the provided link. On to the next app...'; premium on iPad not on iPhone; one resolved by refund and re-purchase — entitlement sync across devices and accounts is fragile
- **This app does:** entitlement recognition; trial billing
- **User reaction:** churn
- **Magnitude:** Failure mode | Payers affected | Segment rate (n=97) | Global | IDs ; Any reliability defect after paying | 21 | 21.6% | 0.96% | 4864820069 5138933764 6269178985 6832692292 6863161594 6998451648 7422190770 9059567695 9445697089 9822343856 10036343519 10386394785 10514724470 10951679021 11016476901 11748480154 12356330098 13416396839 13459643027 13741293681 13765557194 ; Billing failure | 13 | 13.4% | 0.60% | 6593564259 6863161594 6866992048 9059567695 9977790318 10373652027 11022906761 11462388063 11748480154 12285802750 13765557194 14054333465 14423487007 ; Data loss | 8 | 8.2% | 0.37% | 6998451648 10514724470 10951679021 11748480154 12356330098 13416396839 13741293681 13765557194 ; Sync failure (phone/Watch/Mac/iPad) | 6 | 6.2% | 0.28% | 6863161594 9822343856 11016476901 13459643027 13741293681 13765557194 ; Subscription / trial not recognised | 4 | 4.1% | 0.18% | 6863161594 6866992048 11462388063 14423487007 ; Refund sought or given | 4 | 4.1% | 0.18% | 6593564259 11462388063 (refunded) 11748480154 13765557194 (refused) ; Widget broken after paying | 3 | 3.1% | 0.14% | 7422190770 10386394785 12356330098 ; Crash / won't open | 3 | 3.1% | 0.14% | 5138933764 9059567695 9445697089 ; Charged on day one of a "free trial" | 2 | 2.1% | 0.09% | 11022906761 12285802750 ; Charged the wrong amount | 1 | 1.0% | 0.05% | 10373652027 (CHF 40.45 instead of 29.95) ; Support did not answer | 2 | 2.1% | 0.09% | 13765557194 14423487007
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6866992048`, `6863161594`, `11462388063`, `14423487007`, `4864820069`, `6269178985`, `9059567695`, `9445697089`, `10036343519`, `9977790318`, `14054333465`, `10373652027`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R46-109 — Subscription billing generates conflict a one-time model does not: 4 refund references (0.18% — 'Not worth the $$ I wish I could get a refund for my annual purchase'; 'Lost all data!!! How do I get a refund?'; 'nobody was going to refund the money for a defective product'; one refunded after a failed activation, then re-bought) and 6 cancellations threatened or described ('i must unsubscribe'; 'I'll not renew'; 'will cancel until this is fixed'; cancelled on the last day of the trial after a developer reply; 'I just cancelled the subscription. That's $29 down the drain'; 'Wasted $30') — 13 billing failures against none in report 43's one-time corpus; the two 'charged on day one of the trial' reviews describe what reviewers elsewhere call a trial trap

- **Where:** §5.5 Refunds, cancellations and billing — 4 refund references (0.18%) vs 2 of 638 in report 43: 'Not worth the $$ I wish I could get a refund for my annual purchase'; 'Lost all data!!! How do I get a refund?'; 'nobody was going to refund the money for a defective product'; one refunded then re-bought; cancellations threatened or described in 6 ('cancelled on the last day of the 7-day trial after a developer reply'; 'I just cancelled the subscription. That's $29 down the drain'; 'Wasted $30'); 13 billing failures vs none — the two 'charged on day one of the trial' describe a trial trap
- **This app does:** 7-day trial billing
- **User reaction:** churn
- **Magnitude:** refunds 4; cancellations 6; billing 13
- **Direction for us:** must-never-break · **Report confidence:** weak count; structural · **Generalisable:** yes
- **Review IDs:** `6593564259`, `11748480154`, `13765557194`, `11462388063`, `9059567695`, `9462122321`, `10257601209`, `13298363427`, `14423487007`, `9977790318`, `11022906761`, `12285802750`
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial; C112 In-app cancellation

### R46-128 — A deleted habit's notification kept firing — the most-voted review in the corpus (IT, 4★, 25 votes); and a VoiceOver regression on iOS 15 (IT) is the only screen-reader report

- **Where:** §6.16 Italy — the most-voted review in the corpus (25 votes): a notification that keeps firing after the habit is deleted; the only VoiceOver regression (iOS 15)
- **This app does:** ghost notification; VoiceOver
- **User reaction:** complaint
- **Magnitude:** 25 votes; n=1 each
- **Direction for us:** must-never-break · **Report confidence:** weak count, high votes · **Generalisable:** yes
- **Review IDs:** `6181587486`, `7846657472`
- **Canonical:** C039 Reminders fire reliably, once; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R46-141 — Treat the Feb–Mar 2026 Russian data-loss cluster as an incident; ship a per-habit change history with one-tap restore ('undo last 7 days'); make cross-device conflict resolution never delete a completed mark — the highest-severity finding, still live

- **Where:** §8.1 #2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** data loss 24 (2.12), 0.73 → 1.47%; 8 payers; 4 RU in 23 days; integrity union 56
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13721978399`, `13741293681`, `13765557194`, `13802922048`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R46-142 — Audit trial and entitlement flows end-to-end: no charge on trial start; one entitlement across iPhone, iPad, Watch, Mac and web; a visible 'restore purchase' and 'subscription status' screen — each failure is a paying customer lost at the moment of payment, two describe a trial trap

- **Where:** §8.1 #3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** billing 13 (2.31)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11022906761`, `12285802750`, `6863161594`, `6866992048`, `14423487007`, `11462388063`, `10373652027`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C109 A free trial must be a real trial

### R46-144 — Remove 'free forever' from the listing and website, and add one screenshot of the free tier's actual 3-habit view — a copy change targeting the angriest cluster in the corpus

- **Where:** §8.1 #5
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** misleading free 27 (1.85, lowest n>20)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `5534964979`, `6856428999`, `8680118578`, `10931667412`, `11692689432`, `12132723234`
- **Canonical:** C181 If the app is paid-only, say so in the subtitle and first screenshot; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Features

### R46-011 — A colour-saturation grid — squares that deepen with each consecutive completion — is the product and the reason people choose it over named rivals: 228 reviews (10.47%, mean 4.86) say the colour system itself motivates, with streak motivation 44, the forgiving skip mark 41 (4.93) and competitive displacement 198 (9.09%, 4.92) — 'Le système des couleurs qui évoluent en fonction de la réussite des habitudes est hyper motivant' (2018); '因为不想让渐变色断开，所以每天会有动力去完成打卡' ('Because I don't want the gradient to break, I'm motivated to check in every day'); 'Instead of filling in the rectangle, it puts a triangle in that space, and that feels like neutral data instead of a personal failing' (ADHD, a year of use); 'Anybody that like seeing a git commit graph will love this app' — the moat is a visual mechanic, not a feature list, which is why the same product is 'revolutionary' to one and 'a bunch of coloured blocks' to another

- **Where:** Executive summary #4 — the colour-saturation grid is the product: 228 (10.47%, mean 4.86) say the colour system motivates; streak motivation 44; forgiving skip 41 (4.93); competitive displacement 198 (9.09%, 4.92); 'The colour system that evolves with your success is hugely motivating' (2018); 'Because I don't want the gradient to break, I'm motivated to check in every day'; 'a triangle in that space… feels like neutral data instead of a personal failing' (ADHD); 'Anybody that like seeing a git commit graph will love this app'; the moat is a visual mechanic — 'revolutionary' vs 'a bunch of coloured blocks'
- **This app does:** saturation grid, free up to 3 habits
- **User reaction:** purchase-driver
- **Magnitude:** 228 (10.47%), 4.86; displacement 198 (4.92); skip 41 (4.93)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `3499180279`, `5595638800`, `10483508663`, `9567101427`, `7033733479`, `6998451648`
- **Canonical:** C005 Know which competitors buyers compare against; C012 Week / month / year grid views; C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R46-012 — More colours is the top feature request and the only in-app purchase the corpus asks for unprompted: 59 reviews (2.71%, mean 4.36; 35 at 5★, 15 at 4★), the top request in every era after 2020 — a hex-code picker ('I would love very much to have the option to enter a hex code… I will pay for this feature!!', tracking 21 habits), pastel and neutral palettes, 'more (than 7) default colors', colours for 21 habits, 'I would totally splurge a buck 99 for a rain themed color pallete'; four say long streaks go muddy ('Yellow disappears completely and turns red. Red turns brown. Green turns olive')

- **Where:** Executive summary #5 — the most-requested feature is more colours, the cheapest to satisfy: 59 (2.71%, mean 4.36), 35 5★ + 15 4★, the top request every era after 2020; a hex-code picker ('I will pay for this feature!!', tracking 21 habits), pastel / neutral palettes, more than 7 defaults, colours for 21 habits, 'I would totally splurge a buck 99 for a rain themed color pallete'; long streaks turn muddy ('Yellow disappears completely and turns red. Red turns brown. Green turns olive') — a palette pack is the only IAP the corpus asks for unprompted
- **This app does:** 7 default colours; no picker
- **User reaction:** blocked-conversion
- **Magnitude:** 59 (2.71%), 4.36; muddy 4
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9952382181`, `11699632553`, `9944097015`, `10745919163`, `8194661184`, `8634977816`, `11366056883`, `11794827684`, `12101755389`, `13866974245`
- **Canonical:** C080 Colour themes / dark mode; C261 A colour palette users can extend — more defaults, a hex picker, softer sets — because colour is the reward surface

### R46-018 — Every-N-days and X-per-week scheduling is the longest-running functional request, from 4–5★ users hitting a model limit: 34 reviews (1.56%, mean 4.09) plus 12 for a habit completable several times a day and 9 for numeric targets (glasses, steps, pages), present every era (1.08% → 2.00% → 1.71% → 1.48%) — 'I have a medicine I must use every other day and I can't put it on this app, which I use for virtually every other reminder' (5★, 8 votes); 'I'm a shift worker and don't always know which days I'll be able to perform a specific task… this could potentially be a deal breaker' (on trial); 'most of my habit are repeated every 3 days… Apple reminders is WAY more efficient' (2★, churned)

- **Where:** Executive summary #11 — scheduling flexibility is the longest-running functional request: 34 (1.56%, mean 4.09) every-other-day, every-3-days, X-per-week, monthly; +12 multiple completions per day, +9 numeric targets; every era 1.08 → 2.00 → 1.71 → 1.48%; 'a medicine I must use every other day and I can't put it on this app' (8 votes); 'I'm a shift worker… this could potentially be a deal breaker' (on trial); 'most of my habit are repeated every 3 days… Apple reminders is WAY more efficient' (churned)
- **This app does:** daily or fixed weekdays only
- **User reaction:** complaint
- **Magnitude:** 34 (1.56%), 4.09; multi 12; numeric 9
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10205085824`, `10429962976`, `8804092407`, `10557854207`, `12128364084`
- **Canonical:** C043 Flexible / custom frequency; C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N

### R46-024 — Skip marks — a half-square on a second tap and a triangle for a scheduled skip — with a 'don't skip twice' rule and weekday-only habits ('no weekends') are free and praised (41, mean 4.93), while their semantics confuse a minority

- **Where:** §2.1 Skip marks: half-square (tap twice) and triangle; a 'don't skip twice' rule; scheduled skip days / weekday-only habits; semantics confuse a minority
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** skip forgiving 41 (4.93)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `4172950287`, `6703493891`, `8634199924`, `10483508663`, `14503999008`, `4997111034`, `7162864243`, `9068859445`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R46-025 — A habit-breaking mode (colour fades when the bad habit is logged) and a 0–10 numeric count per day exist, but their effect on the colour grid is unclear to some reviewers

- **Where:** §2.1 Habit-breaking mode (colour fades when a bad habit is logged) — logic unclear to some; numeric count per day (0–10 scale) — effect on colour unclear
- **This app does:** present, unclear
- **User reaction:** mixed
- **Magnitude:** 2 + 2 confused
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `6735020315`, `7651641484`, `10073584696`, `14091755398`, `11107406485`, `11402316703`, `11625636896`
- **Canonical:** C019 Quit-habit / bad-habit mode; C048 Flexible units / partial progress

### R46-026 — Inventory notes: a Learn tab (articles, videos, James Clear / Atomic Habits material) and a 7-day e-mail course, strongly praised by early users and English-only; a web app and Chrome new-tab extension that pre-date the iPhone app, a Safari plugin by 2024; iPhone, iPad and Mac (the Mac build criticised as slow); Watch app and complications by Mar 2021 with unreliable phone sync; interactive home-screen widgets from iOS 14 (the widget fits 4 habits, the free tier allows 3); journal notes and calendar view (v3, Dec 2023); folders / habit groups (Aug 2025 — 'The new habit folder feature is — chef's kiss'); archive; Shortcuts ('one of the few that has shortcuts integration'); localised UI including Catalan, Arabic and Turkish

- **Where:** §2.1 Learn tab — articles, videos, James Clear / Atomic Habits material, a 7-day e-mail course; web app and Chrome new-tab extension pre-dating the iPhone app; Safari plugin by 2024; iPhone, iPad, Mac (Mac build criticised as slow); Watch app and complications by Mar 2021 (sync unreliable); interactive widgets from iOS 14; journal / notes and calendar (v3, Dec 2023); folders (Aug 2025, 'chef's kiss'); archive; Shortcuts ('one of the few'); Catalan, Arabic, Turkish UI
- **This app does:** broad surface
- **User reaction:** praise
- **Magnitude:** inventory
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `12987527653`, `11399804236`, `10906751585`, `11387719561`
- **Canonical:** C009 Basic widgets, icons and colours are free; C022 Apple Watch app (done properly: timer, two-way sync); C027 Localise early — it unlocks revenue; C044 Mac / desktop / web app; C045 Grouping / folders / categories / tags; C046 Shortcuts / Siri / URL scheme / API; C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C172 Per-day / per-habit notes and journal text

### R46-027 — Absent per reviewers: every-N-days, X-per-week without fixed days, monthly / quarterly schedules; multiple completions per day; numeric targets (glasses, steps); a distinct 'not recorded' vs 'missed' mark; a gentler colour decay on a miss; hex-code / custom palettes; social / accountability-partner features; Health, Calendar and NFC integration; data export; subtasks; per-habit timers; an Android app; Family Sharing; a passcode or Face ID lock

- **Where:** §2.1 Capabilities asked for with no evidence — every-N-days / X-per-week / monthly; multiple completions per day; numeric targets; a 'not recorded' vs 'missed' mark; gentler colour decay on a miss; hex / custom palettes; social / accountability partner; Health, Calendar, NFC; export; subtasks; per-habit timers; Android; Family Sharing; passcode / Face ID
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** see §3.5
- **Direction for us:** research · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `10205085824`, `10429962976`, `6556598422`, `8843217741`, `11083555963`, `10028161100`, `10033156686`, `11596204633`, `10089231057`, `12065748660`, `13783066497`, `5916248950`, `12126118988`, `5590306018`, `6640963989`, `6142793012`, `10002828775`, `10900370698`, `10935764674`, `7104448711`, `11524750177`, `8035713017`, `12138888788`, `6574668956`, `10994959286`, `12130976479`, `10144327227`, `11059131741`, `10404136654`
- **Canonical:** C017 Passcode lock; C020 Data export / backup / CSV; C021 Apple Health integration; C037 Family plan; C043 Flexible / custom frequency; C048 Flexible units / partial progress; C051 Android version; C066 Focus timer; C143 Intra-day completion: tap N times to fill N/N; C173 Sub-tasks / sub-routines nested inside a habit or routine; C202 A light social layer that is explicitly not a social network; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which; C261 A colour palette users can extend — more defaults, a hex picker, softer sets — because colour is the reward surface

### R46-039 — Cross-platform praised 72 (3.31%, mean 4.82) — iPhone, iPad, Mac, Watch, web, Chrome extension

- **Where:** §3.1 master table #13 cp_cross_platform
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 72 (3.31%), 4.82
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator

### R46-046 — Customisation praised 31 (1.42%, mean 4.94)

- **Where:** §3.1 master table #32 cp_customization
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 31 (1.42%), 4.94
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C080 Colour themes / dark mode

### R46-048 — Reminders praised 24 (1.10%, mean 4.92); finer reminder control requested 9 (4.56)

- **Where:** §3.1 master table #40 cp_reminders
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 24 (4.92); request 9
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C008 Daily check-in and reminders are free — never paywall the reminder; C039 Reminders fire reliably, once

### R46-054 — Journal / notes praised 12 (0.55%, 4.67) since v3 (Dec 2023)

- **Where:** §3.1 master table #59 cp_journal_notes
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 12 (0.55%), 4.67
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R46-057 — Cannot reorder habits 10 (0.46%, 4.10); history view limited 9 (0.41%, 3.44)

- **Where:** §3.1 master table #65 ux_cannot_reorder / #72 ux_history_view_limited
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 10 + 9
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R46-059 — Accessibility requests 8 (0.37%, 3.75) — font size, VoiceOver, reading needs

- **Where:** §3.1 master table #73 fr_accessibility
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 (0.37%), 3.75
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `3752302042`, `7242762638`, `7846657472`, `12136286563`
- **Canonical:** C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R46-069 — Why the grid works — three mechanics: streak motivation (44, mean 4.80 — 'the pain of losing my streak is more painful than the exercise'), the forgiving skip (41, 4.93 — 'you don't want to break a streak, so you keep going'; 'no punishment other than a break in the color gradient') and stats (54, 4.91 — 'With this app I found out that I exercised 60% of the time, wrote 80% of the time, never went more than three days without flossing'); two reviewers call it a GitHub contribution graph; against it, 19 find the half-square / triangle marks confusing and 4 say long streaks turn colours muddy

- **Where:** §3.3.3 The colour grid's supporting mechanics — streak motivation 44 (4.80; 'the pain of losing my streak is more painful than the exercise'); forgiving skip 41 (4.93; 'no punishment other than a break in the color gradient'); stats 54 (4.91; 'I exercised 60% of the time, wrote 80% of the time, never went more than three days without flossing'); two call it a GitHub contribution graph; against: symbols confusing 19, muddy colours 4
- **This app does:** colour grid + skip + stats, free
- **User reaction:** praise
- **Magnitude:** 44 + 41 + 54; confusing 19; muddy 4
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9516585789`, `6549805388`, `6703493891`, `10483508663`, `9567101427`, `10843646833`
- **Canonical:** C011 Weekly / monthly / yearly reports; C012 Week / month / year grid views; C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R46-072 — Educational content is a reason early users stay, and it is under-used later: the Learn tab, 7-day e-mail course and James Clear material — 'Content alone is like a life changing book. I didn't even start using the habit tracker in that app, and am already so amazed by the content'; 'the dev eats his own dogfood… surprisingly useful and inspirational content in the form of documentation'; 'The picks are high quality, motivating, and have a time estimate for how long they'll consume' — 107 (4.91%, mean 4.82), falling 11.02% → 3.30% by era; five say the content and e-mails are English-only

- **Where:** §3.3.6 Learn content — 'Content alone is like a life changing book. I didn't even start using the habit tracker'; 'the dev eats his own dogfood… useful and inspirational content in the form of documentation'; 'high quality, motivating, and have a time estimate'; rate falls 11.02% → 3.30%; five say content and e-mails are English-only
- **This app does:** free Learn tab + e-mail course
- **User reaction:** praise
- **Magnitude:** 107 (4.91%), 4.82; 11.02 → 3.30%
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `5355179743`, `5280954299`, `10802899909`, `6821437095`, `6821741061`, `8985834449`, `9992608962`, `11171579515`
- **Canonical:** C027 Localise early — it unlocks revenue; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R46-073 — The surface people live on moved from a Chrome new-tab page to the home-screen widget: early users valued the web app and Chrome extension ('I have it as my default Chrome tab page so I am constantly getting reminded'; 'I am not allowed my phone at work, at all. We can use computers that are hardwired') — 23 reviews, 2.15% → 0.23%; later users value the interactive widget ('The widget is exactly what I was looking for, I barely even open the app'; 'Не везде можно одним тыком с экрана домой отметить привычки') — widget praise 66 (3.03%, mean 4.79), rising 0.81% → 3.98%; cross-platform praised 72 (3.31%, 4.82)

- **Where:** §3.3.7 Cross-platform 72 (4.82), widgets 66 (4.79), web / extension users 23 — 'I have it as my default Chrome tab page so I am constantly getting reminded'; 'I am not allowed my phone at work… computers that are hardwired'; 'The widget is exactly what I was looking for, I barely even open the app'; 'Not every app lets you check habits with one tap from the home screen'; widget praise 0.81% → 3.98%
- **This app does:** web + extension + widget
- **User reaction:** praise
- **Magnitude:** 72 + 66 + 23; widget 0.81 → 3.98%
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `9779787899`, `8664752373`, `10864658754`, `13116954771`
- **Canonical:** C009 Basic widgets, icons and colours are free; C044 Mac / desktop / web app

### R46-090 — Feature requests come from people who like the product, and four have visibly shipped: union 197 (9.04%, mean 4.17), only 17 (8.6%) at 1–2★ — more / custom colours 59 (4.36); flexible frequency 34 (4.09); several completions per day 12; richer statistics 11 (4.55); folders / tags 10 (shipped 2025); numeric targets 9 (4.56); notes / journal 9 (shipped Dec 2023); finer reminder control 9 (4.56); Health / Calendar / Shortcuts / NFC / API 9 (3.44); accessibility 8 (3.75); widget 8 (shipped Sep 2020); 'missed' distinct from 'not recorded' and gentler decay 6 (4.67); social / accountability 6 (4.50); Apple Watch 5 (shipped 2021); calendar month view 5; sounds 5; landscape 4; timer 4 (4.75); account deletion 3 (2.00); backfill 3; export / backup 3; subtasks, to-dos, Android, app lock, desktop < 0.1% each — in each shipped case the request theme stops and a praise theme starts; the two largest open requests sit closest to the colour grid

- **Where:** §3.5 Unmet needs (verbatim table) — colours 59; flexible frequency 34; several completions per day 12; richer stats 11 (4.55); folders 10 (shipped 2025); numeric targets 9 (4.56); notes / journal 9 (shipped Dec 2023); reminder control 9 (4.56); integrations 9; accessibility 8; widget 8 (shipped 2020); missed vs not-recorded 6 (4.67); social 6; Watch 5 (shipped 2021); calendar view 5; sounds 5; landscape 4; timer 4; account deletion 3; backfill 3; export 3; ignore-level 7; union 197 (9.04%, mean 4.17), only 17 at 1–2★; four requests visibly shipped and each turned into praise; the two largest open requests (colours, scheduling) sit closest to the grid
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Need | n | % of 2,178 | Mean ★ | Signal | Representative IDs ; More / custom / softer colours; hex picker; palettes | 59 | 2.71% | 4.36 | meaningful | 9952382181 11699632553 10745919163 8634977816 12101755389 13609624617 ; Flexible frequency: every N days, X per week, monthly | 34 | 1.56% | 4.09 | meaningful | 10205085824 10429962976 8804092407 11621928088 12538810872 13545758308 ; Several completions per day for one habit | 12 | 0.55% | 4.08 | emerging | 6556598422 8843217741 10028161100 11083555963 12396079528 ; Richer statistics, charts, month-over-month | 11 | 0.51% | 4.55 | emerging | 8840066046 9976175371 11806786855 12065748660 ; Folders, tags, categories | 10 | 0.46% | 4.10 | weak | 5370510052 10138466871 12203038510 12787788005 (folders shipped by 2025: 12987527653) ; Numeric targets (glasses, steps, minutes) | 9 | 0.41% | 4.56 | weak | 10028161100 10722097050 11596204633 13308951396 14075724873 ; Notes / journal per day (shipped Dec 2023) | 9 | 0.41% | 3.89 | weak | 5467797637 9429596011 9956145572 12323464588 ; Finer reminder control (per day, stop once done, text) | 9 | 0.41% | 4.56 | weak | 10417193488 11083555963 13830788651 ; Health / Calendar / Shortcuts / NFC / API integration | 9 | 0.41% | 3.44 | weak | 5589772391 6142793012 10002828775 10900370698 10935764674 ; Accessibility: font size, VoiceOver, reading needs | 8 | 0.37% | 3.75 | weak | 3752302042 7242762638 7846657472 12136286563 ; Home-screen widget (shipped Sept 2020) | 8 | 0.37% | 4.38 | weak | 5502215122 5920784515 6146989015 7659788023 ; "Missed" distinct from "not recorded"; gentler decay | 6 | 0.28% | 4.67 | weak | 5916248950 10089231057 12126118988 13783066497 ; Social / accountability partner / sharing | 6 | 0.28% | 4.50 | weak | 5590306018 6640963989 11399804236 12947425631 ; Apple Watch (shipped by 2021) | 5 | 0.23% | 4.00 | weak | 6251602461 6538626252 6678694569 9598702560 ; Calendar month view | 5 | 0.23% | 3.40 | weak | 6998451648 7932158545 9949919182 12161870457 ; Sounds / stronger completion feedback | 5 | 0.23% | 4.20 | weak | 6031666122 10335217459 10823584337 ; Landscape / wider view | 4 | 0.18% | 4.00 | weak | 8150206420 8519517678 8971421965 10838117345 ; Timer / time logging / Pomodoro | 4 | 0.18% | 4.75 | weak | 6574668956 10762490298 10994959286 11190606798 ; Account deletion (2020) | 3 | 0.14% | 2.00 | weak | 5869846139 6518400889 6643634090 ; Backfill further into the past | 3 | 0.14% | 3.67 | weak | 5835675354 5858521702 9194639863 ; Export / backup / print | 3 | 0.14% | 4.33 | weak | 6108616821 7104448711 11524750177 ; Subtasks; one-off to-dos; Android; app lock; desktop (2020) | 7 | — | — | ignore individually (<0.1% each) | 8035713017 12138888788 10321301833 10365841453 12130976479 10404136654 5655839185
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13609624617`, `11621928088`, `12538810872`, `13545758308`, `12396079528`, `8840066046`, `9976175371`, `11806786855`, `5370510052`, `10138466871`, `12203038510`, `12787788005`, `10722097050`, `13308951396`, `14075724873`, `5467797637`, `9429596011`, `9956145572`, `12323464588`, `10417193488`, `13830788651`, `5589772391`, `5502215122`, `5920784515`, `6146989015`, `7659788023`, `12947425631`, `6251602461`, `6538626252`, `6678694569`, `9598702560`, `7932158545`, `9949919182`, `12161870457`, `6031666122`, `10335217459`, `10823584337`, `8150206420`, `8519517678`, `8971421965`, `10838117345`, `11190606798`, `5835675354`, `5858521702`, `9194639863`, `6108616821`, `10321301833`, `10365841453`
- **Canonical:** C037 Family plan; C043 Flexible / custom frequency; C059 Be visibly responsive; fixes bring reviewers back; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size; C261 A colour palette users can extend — more defaults, a hex picker, softer sets — because colour is the reward surface

### R46-091 — A distinct mark for 'missed' vs 'not recorded', and a gentler colour decay on a miss, are requested by 6 (mean 4.67) — the one request that touches the forgiving-skip mechanism the neurodivergent segment relies on, so it must be tested against them first

- **Where:** §3.5 'Missed' distinct from 'not recorded'; gentler colour decay on a miss — 6 (4.67) — the request that touches the ADHD segment's forgiving-skip mechanism
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 6 (0.28%), 4.67
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `5916248950`, `10089231057`, `12126118988`, `13783066497`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C101 Milestones, achievements, celebration; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

### R46-149 — Ship a larger palette, a hex custom-colour picker and softer / pastel sets; consider a one-time palette pack as a paid add-on — the most-requested feature, on the differentiator, and the only unprompted IAP idea in the corpus

- **Where:** §8.2 #10
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** more colours 59 (4.36; 50 at 4–5★); muddy 4; 2 volunteer to pay
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9952382181`, `12101755389`
- **Canonical:** C261 A colour palette users can extend — more defaults, a hex picker, softer sets — because colour is the reward surface

### R46-150 — Add every-N-days, X-times-per-week (any days) and monthly schedules; allow several completions a day and numeric targets — requested every era; mean 4.09 makes it retention, not acquisition

- **Where:** §8.2 #11
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** frequency 34 (4.09); multi 12; counter 9
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10205085824`, `10429962976`, `8804092407`
- **Canonical:** C043 Flexible / custom frequency; C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N

### R46-151 — Distinguish 'missed' from 'not recorded' and offer an optional one-step colour decay instead of a full reset on a miss — but test it with the neurodivergent segment first; it must not make a miss feel more like failure

- **Where:** §8.2 #12
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** missed vs blank 6 (4.67); segment 30 (4.83)
- **Direction for us:** undecided · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `5916248950`, `10089231057`, `12065748660`, `12126118988`, `13783066497`
- **Canonical:** C101 Milestones, achievements, celebration; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

### R46-154 — Offer Family Sharing on the annual and lifetime plans — ignore-level by count but a StoreKit setting, and one reviewer names five family members

- **Where:** §8.2 #15
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** no Family Sharing 2
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10144327227`, `11059131741`
- **Canonical:** C037 Family plan

## Monetization

### R46-008 — A 3-habit cap held unchanged for eight years stays the largest negative while a 3-habit tier cannot even fill the product's own 4-row widget: 180 complaints (8.26%, mean 2.43), 68 of 166 one-stars (41.0%) and 29 of 84 two-stars, unbroken from Jan 2019 ('I found that I could set up only 3 entries') to Apr 2026 ('why only 3 habits? Just to make more money ?'); the annual count barely moved (26 / 32 / 22 / 18 in 2022–25) while the rate fell 16.2% → 5.2% only because prompted volume tripled; the paywall union is 204 (9.37%, mean 2.47) — trial too limited to evaluate 32, 'free' misleading 27 (mean 1.85), 4–6 free habits requested 29 — 'By the time you discover that you can only track 3 habits with the free version, you've already spent 20 minutes or more setting it up' (US, 1★, 16 votes); '3 hábitos y pasar por caja. Borrada' (ES, 1★); 'please at the very least increase it from 3 habits limit to 4… when I use the widget (which fits 4 habits) it leaves the 4th row blank' (US, 4★); against this 66 (3.03%, mean 4.92) say three is enough

- **Where:** Executive summary #1 — the 3-habit free tier is the defining negative and never loosened: 180 (8.26%, mean 2.43), 68 of 166 1★ (41.0%), 29 of 84 2★; unbroken Jan 2019 → Apr 2026; count 26 / 32 / 22 / 18 (2022–25) while the rate fell 16.2% → 5.2% only because prompted volume tripled; paywall union 204 (9.37%, 2.47) with trial-too-limited 32, misleading-free 27 (1.85), 4–6 free habits requested 29; 'By the time you discover that you can only track 3 habits… you've already spent 20 minutes or more setting it up' (16 votes); '3 hábitos y pasar por caja. Borrada'; the free tier cannot fill the product's own 4-row widget
- **This app does:** 3 free habits, 2019–2026
- **User reaction:** complaint
- **Magnitude:** 180 (8.26%), 2.43; 41.0% of 1★; union 204 (9.37%); 4–6 asked 29; three-is-enough 66 (4.92)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `3621518582`, `13938765242`, `8247232385`, `6035060089`, `9997347192`, `5655839185`, `12334331759`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay; C181 If the app is paid-only, say so in the subtitle and first screenshot; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R46-010 — Shipping a lifetime tier answered the one-time ask and moved the objection to its price — with an unusually specific willingness-to-pay anchor: one-time-purchase requests fell 6.99% (2018–20) → 4.74% → 0.38% → 0.68% (2024–26) after the first lifetime purchase (May 2021), while 'lifetime price too high' appeared in its place — 27 reviews (1.24%, mean 3.00), none before July 2022, 0.46% → 2.02% across halves; reviewers converge on $30–70 against $99.99 — 'I have never seen someone charge more than $30 for it… I will be happy to pay $30 for life-time'; 'Would probably buy it lifetime if it was 30 or less'; 'make it a one time $30 lifetime cost… asking for almost $100 for lifetime is GREEDY' (a multi-year subscriber); '69.99 and I probably would have paid' (took annual instead); 'Among apps that charge ¥30 for lifetime, this one wants ¥328 — I really don't dare buy it, in case it disappears'; the tier converts — 16 lifetime buyers (0.73%, mean 4.56): 'I didn't pay because there was no lifetime option. Now there is, so I bought it straight away'

- **Where:** Executive summary #3 — the one-time ask was answered with a lifetime tier and its price became the objection: one-time request 53 (2.43%, 3.32) runs 6.99% (2018–20) → 0.68% (2024–26); first lifetime purchase May 2021; lifetime-price-too-high 27 (1.24%, 3.00), 0 before Jul 2022, 0.46% → 2.02%; reviewers converge on $30–70 ('never seen someone charge more than $30… happy to pay $30'; 'Would probably buy it lifetime if it was 30 or less'; 'asking for almost $100 for lifetime is GREEDY' — a multi-year subscriber; '69.99 and I probably would have paid'; '¥30 lifetime elsewhere, this wants ¥328 — I don't dare buy it in case it disappears'); 16 bought lifetime (mean 4.56; 'now there is a lifetime option, so I bought it straight away')
- **This app does:** lifetime $99.99 (CAD $129.99)
- **User reaction:** blocked-conversion
- **Magnitude:** one-time ask 53 (6.99% → 0.68%); lifetime price 27 (3.00); lifetime buyers 16 (4.56); anchor $30–70
- **Direction for us:** build-paid · **Report confidence:** high confidence · **Generalisable:** yes
- **Review IDs:** `7299054449`, `10650959929`, `11735469517`, `10453985829`, `12101755389`, `11206877099`, `12237402875`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C186 Never revoke what earlier buyers paid for when the model changes

### R46-028 — Free / paid: the grid, colour system, skips, stats and reminders are free up to 3 habits (cap unchanged Jan 2019 → Apr 2026; one outlier says 4, one 2); unlimited habits paid by subscription or lifetime; a 7-day trial that auto-renews; a paywall on first open for some ('Meteen abonnement nemen of het beginscherm bekijken. Meer is er niet'; 'You are immediately prompted with a paywall when opening'); dark mode paywalled in 2020 and again in June 2024 ('New update moved dark mode behind a paywall'); offline check-off locked behind the paywall; cross-device sync / iCloud backup paid in the early era (an upgrade to see data on the Watch); widgets mostly free ('comes with widgets on free version… surprising') but contested; Learn content and the e-mail course free; no ads; an account required 2018–2022 (8 complaints, last Oct 2022) and optional by 2024; no Family Sharing (a 1★)

- **Where:** §2.2 Free / paid classification (verbatim table) — grid, colours, skips, stats, reminders free up to 3 habits; cap 3 unchanged 2019 → 2026 (two outliers say 4 and 2); unlimited paid (subscription or lifetime); 7-day trial auto-renews; paywall on first open ('Take a subscription straight away or look at the start screen. That's all'; 'immediately prompted with a paywall'); dark mode paid (2020 and again Jun 2024); offline use paid; cross-device sync paid early; widgets free (contested); Learn free; no ads; account required 2018–22, optional by 2024; no Family Sharing
- **This app does:** 3 habits; dark mode, offline, sync paid
- **User reaction:** mixed
- **Magnitude:** Capability | Status | Basis ; App download | Free | Store listing + all reviews ; Grid, colour system, skips, stats, reminders | Free, up to 3 habits | 7128048673 10443301487 13247499575 ; Habit count | Capped at 3 in the free tier, 2019 → 2026, unchanged | 180 mf_free_cap_3habits reviews from 3621518582 (Jan 2019) to 13941461433 (Apr 2026); listing: *"Free version limited to 3 habits"*. Two outliers: 9571465485 (ES, Feb 2023) says 4, 10783719941 (BO, Jan 2024) says 2 ; Unlimited habits | Paid — subscription or lifetime | 6832692292 7258835816 12573082987 ; 7-day free trial | Exists; auto-renews into a paid plan | 6494192486 7141552433 12097572756 13298363427 ; Paywall shown on first open | Reported | 9949749611 (NL, *"Meteen abonnement nemen of het beginscherm bekijken. Meer is er niet"* / "Take a subscription straight away or look at the start screen. That's all"), 11552543931 (US, *"You are immediately prompted with a paywall when opening"*) ; Dark mode | Paid (2020 and again 2024) | 6139789378 (BR, 2020, *"pagar isso só pra ter modo escuro ou off-line"* / "pay this just to have dark mode or offline"), 11054384115 (CZ, *"Dark mode under paywall?"*), 11382464605 (US, Jun 2024, *"New update moved 'dark mode' behind a paywall"*) ; Offline use | Requires a connection unless paid | 9029601554, 10143971103 (*"ticking off habits while offline are locked behind a paywall"*), 10618466787, 13460787737 ; Cross-device sync / iCloud backup | Paid in the early era | 5375632517 (FR, 2020, *"pas de synchro entre les devices"* in free), 6425991977 (premium "unlocking iCloud back up"); 9822343856 upgraded to see data on the Watch ; Widgets | Free (mostly) — contested | 12407091400 (*"comes with widgets on free version… surprising"*), 13671662317; against: 10618466787 ("access to basic widgets" as a paid item), 7422190770 (2021, widget absent even after paying) ; Learn content, email course | Free | 5225703797 6156303621 8813861255 ; Ads | None | 8218647869 8307840272 13368773804 ; Account | Required 2018–2022; optional by 2024 | 8 mf_account_required complaints, last Oct 2022 (9193209910); then 11481910041 (DE, 2024, *"Zugang auch ohne Registrierung"* / "access without registration") and 13247499575 (US, 2025, *"an account isn't required"*) ; Family Sharing | Not supported | 10144327227 (DE, 1★), 11059131741 (US, 3★)
- **Direction for us:** product-rule · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `7128048673`, `10443301487`, `13247499575`, `13941461433`, `9571465485`, `10783719941`, `6832692292`, `7258835816`, `12573082987`, `6494192486`, `7141552433`, `12097572756`, `13298363427`, `9949749611`, `11552543931`, `6139789378`, `11054384115`, `11382464605`, `9029601554`, `10143971103`, `10618466787`, `13460787737`, `5375632517`, `6425991977`, `9822343856`, `12407091400`, `13671662317`, `7422190770`, `5225703797`, `6156303621`, `8813861255`, `8218647869`, `8307840272`, `13368773804`, `9193209910`, `11481910041`, `10144327227`, `11059131741`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free; C030 Sync must work — and prove it; C035 Account system from day one; C037 Family plan; C063 Free trial before purchase; C080 Colour themes / dark mode; C188 The app must open offline — never block launch on a network call

### R46-033 — Price ladder: 2019 $12/year on the website and more in-app ('$12 a year is a steal'; 'всего $12 в год (на сайте, в приложении больше)'); late 2019–2020 $4.99/month, ~$30 / €30 / €25 per year, Brazil R$17.90/mo and R$107.90/yr, China ¥118–198/yr; 2021 the lifetime option appears, CAD $40/yr; 2023–2026 $7.49/month, $29.99/year, $99.99 lifetime (CAD $9.99 / $39.99 / $129.99), matching the listing

- **Where:** §2.2 Price as reviewers report it (verbatim table) — 2019 $12/year on the web, more in-app ('$12 a year is a steal'); late 2019–2020 $4.99/mo, ~$30 / €30 / €25 per year, BR R$17.90/mo, CN ¥118–198/yr; 2021 lifetime appears, CAD $40/yr; 2023–26 $7.49/mo, $29.99/yr, $99.99 lifetime; CAD $9.99 / $39.99 / $129.99 — the listing matches
- **This app does:** $12/yr → $29.99/yr + $99.99 lifetime
- **User reaction:** mixed
- **Magnitude:** Period | Price named | Review IDs ; 2019 | $12/year (web); more in-app | 4172950287 (*"$12 a year is a steal"*), 4306125740 (RU, *"всего $12 в год (на сайте, в приложении больше)"* / "only $12 a year on the website, more in the app") ; Late 2019 – 2020 | $4.99/month; ~$30 / €30 / €25 / 30€ per year; BR R$17.90/mo, R$107.90/yr; CN ¥118–198/yr | 5111990858, 5327847333, 5352678797, 5420624098, 5471831095, 6139789378, 6251316091, 5483060991 ; 2021 | Lifetime option appears; $40/yr CAD | 7299054449 (first lifetime purchase, May 2021), 6914413184, 6998451648 ; 2023 – 2026 | $7.49/month, $29.99/year, $99.99 lifetime; CAD $9.99 / $39.99 / $129.99 | 9882563220, 10453985829, 10772502203, 10931421643, 11486272259
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `4172950287`, `4306125740`, `5111990858`, `5327847333`, `5352678797`, `5420624098`, `5471831095`, `6251316091`, `5483060991`, `7299054449`, `6914413184`, `6998451648`, `9882563220`, `10453985829`, `10772502203`, `10931421643`, `11486272259`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'

### R46-040 — Free tier sufficient 66 (3.03%, mean 4.92) — 'shouldn't be tracking more than three in the first place'

- **Where:** §3.1 master table #15 mp_free_tier_sufficient
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 66 (3.03%), 4.92
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `5655839185`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R46-041 — Worth the money 51 (2.34%, 4.94); price reasonable 20 (0.92%, 4.80)

- **Where:** §3.1 master table #20 mp_worth_the_money / #46 mp_price_reasonable
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 51 + 20
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R46-052 — Supporting an indie developer as a reason to pay 13 (0.60%, 4.92), 12 of 13 before Jul 2023

- **Where:** §3.1 master table #56 mp_support_indie
- **This app does:** see §3.1
- **User reaction:** purchase-driver
- **Magnitude:** 13 (0.60%), 4.92
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R46-060 — Regional pricing 8 (0.37%, 3.50, all non-US); discount request 6 (3.67); price increase 5 (2.20)

- **Where:** §3.1 master table #77 mf_regional_pricing / #83 mf_discount_request / #89 mf_price_increase
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 + 6 + 5
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C025 Scholarship / hardship / discount program; C064 Price level — where 'fair' turns into 'too expensive'; C092 Regional pricing

### R46-075 — Four shapes of the cap objection: discovered after setup ('please consider it before spending the next 15 minutes to set up everything just to find out that this is useless unless you purchase a preminum'); too small to evaluate (32, mean 1.88 — 'With only 3 habits it's not possible to test the app — I'd have to subscribe before even trying it'; 'give people the possibility to try it for 30 days without limitation'); the listing says free (27, mean 1.85, the lowest theme with n > 20 — 'Potential but FREE FOREVER description is misleading'; 'The free version (Everyday will be free forever!) is limited to just three ( = 3!!) items' (7 votes); 'the developer's website claims this app will be free forever… IS NOT A FREE APP'; 'Every picture shows a bunch of colorful habit trackers, not a one shows what the free version looks like'); and a modest counter-offer (29, mean 3.69) naming 4, 5, 5–6, 6 or 7 — nobody asks for unlimited: 'raise the free tier from 3 to at least 6 so users get attached and then subscribe'

- **Where:** §3.4.1 four recurring shapes — discovered after setup ('spend the next 15 minutes to set up everything just to find out that this is useless unless you purchase'); too small to evaluate (32, mean 1.88: 'I'd have to subscribe before even trying it'; 'give people the possibility to try it for 30 days without limitation'); the listing says free (27, mean 1.85 — the lowest n>20: 'FREE FOREVER description is misleading'; 'Everyday will be free forever! is limited to just three ( = 3!!) items' (7 votes); 'the developer's website claims this app will be free forever… IS NOT A FREE APP'; 'not a one [screenshot] shows what the free version looks like'); a modest counter-offer (29, mean 3.69 — 4, 5, 5–6, 6, 7; nobody asks for unlimited: 'raise the free tier from 3 to at least 6 so users get attached and then subscribe')
- **This app does:** 3-habit cap; 'free forever' claim
- **User reaction:** 1★-burst
- **Magnitude:** trial too limited 32 (1.88); misleading free 27 (1.85); more free habits 29 (3.69)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8476763345`, `6859946614`, `9663261021`, `5534964979`, `6856428999`, `11692689432`, `12132723234`, `12505242555`, `11416426448`, `8334841669`, `11904537006`, `12134015424`, `10900370698`, `9520604649`, `6163200202`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C063 Free trial before purchase; C147 Let people use the product before they pay; C181 If the app is paid-only, say so in the subtitle and first screenshot

### R46-078 — Pricing sub-themes: price too high 163 (7.48%, 2.84); one-time wanted 53 (2.43%, 3.32); anti-subscription 41 (1.88%, 2.44); competitor cheaper 28 (1.29%, 2.25); lifetime too high 27 (1.24%, 3.00; 2022–26); regional pricing 8 (3.50); paywalled capability 8 (2.12); discount request 6 (3.67); price increase 5 (2.20); longevity doubt 5 (4.20); no Family Sharing 2 (2.00)

- **Where:** §3.4.2 Price and pricing model (verbatim sub-theme table) — price too high 163; one-time wanted 53; anti-subscription 41 (2.44); competitor cheaper 28 (2.25); lifetime too high 27; regional 8; paywalled capability 8; discount 6; price increase 5; longevity doubt 5; no Family Sharing 2
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Sub-theme | n | % | Mean ★ | Signal | Period ; mf_price_too_high | 163 | 7.48% | 2.84 | high-priority | 2019–2026 ; mf_want_one_time_purchase | 53 | 2.43% | 3.32 | meaningful | 2019–2025 ; mf_anti_subscription | 41 | 1.88% | 2.44 | meaningful | 2019–2026 ; mf_competitor_cheaper | 28 | 1.29% | 2.25 | meaningful | 2019–2025 ; mf_lifetime_price_too_high | 27 | 1.24% | 3.00 | meaningful | 2022–2026 ; mf_regional_pricing | 8 | 0.37% | 3.50 | weak | 2020–2026 ; mf_paywalled_capability | 8 | 0.37% | 2.12 | weak | 2020–2025 ; mf_discount_request | 6 | 0.28% | 3.67 | weak | 2021–2026 ; mf_price_increase | 5 | 0.23% | 2.20 | weak | 2020–2025 ; mf_longevity_doubt | 5 | 0.23% | 4.20 | weak | 2019–2025 ; mf_no_family_sharing | 2 | 0.09% | 2.00 | ignore by count; stated because it is a clear product gap | 2023–2024
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R46-079 — The subscription objection is about renting, not paying: 'Pero una cosa es COMPRAR un producto y otra ALQUILAR… Ponme un precio fijo establecido con un periodo de prueba inicial para probar la app, no una suscripción y me tienes' (ES, 2★); 'Ich kaufe gerne eine App aber, ich hasse es ständig gemolken zu werden' (DE, 4★); 'I'm willing to pay for it, but I'm not willing to subscribe to it forever' (US, 1★) — anti-subscription 41 (1.88%, mean 2.44); once the lifetime tier appeared the ask moved from 'sell it once' to 'sell it once for less'

- **Where:** §3.4.2 The subscription objection is about renting, not paying — 'Buying a product is one thing, renting it is another… Give me a fixed price with an initial trial, not a subscription, and you've got me'; 'I'm happy to buy an app, but I hate being milked constantly'; 'I'm willing to pay for it, but I'm not willing to subscribe to it forever'; the ask moved from 'sell it once' to 'sell it once for less' once lifetime appeared
- **This app does:** subscription + $99.99 lifetime
- **User reaction:** blocked-conversion
- **Magnitude:** anti-subscription 41 (2.44); one-time 53 (3.32)
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `6119755511`, `6258595511`, `8309866369`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R46-102 — A week of full use converts — the trial is the top purchase trigger: 'I paid for the full version after the trial because I could see how much it had helped in just a week'; 'Absolutely did not hesitate to purchase after the week trial'; 'I tried it and a week later paid the anual subscription. It is worth it'; 'I have used this app for 6 days and fully expected to delete it before the free trial ended. However… I will be subscribing for the year if not more' (tracking medication to share with a health-care team); 'after two weeks it was working so well for me that I did the yearly subscription'; 'j'ai voulu attendre une semaine avant de m'abonner pour être sûr de la qualité' (2019)

- **Where:** §5.2 trigger 1 — the trial worked: 'I paid for the full version after the trial because I could see how much it had helped in just a week'; 'Absolutely did not hesitate to purchase after the week trial'; 'I tried it and a week later paid the anual subscription'; 'used this app for 6 days and fully expected to delete it before the free trial ended… I will be subscribing for the year' (medication tracked for a health-care team); 'after two weeks it was working so well… I did the yearly'; 'I waited a week before subscribing to be sure of the quality' (2019)
- **This app does:** 7-day trial
- **User reaction:** purchase-driver
- **Magnitude:** trigger #1 of 5
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `9959381704`, `11333501919`, `14285579446`, `9486286103`, `11397647494`, `4861726026`
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

### R46-103 — The fourth habit converts users who succeeded with three: 'The 3 free habits wasn't enough for me. so I've paid £30 for the year'; 'Habe mir die Premiumversion geholt, weil ich mehr als 3 habits eintragen möchte… Das sind gerade mal 2,50 im Monat'; 'I've been using the free version of this app for a couple of months to track medication management… I went ahead with the upgrade today so that I could track other habits as well'

- **Where:** §5.2 trigger 2 — a fourth habit: 'The 3 free habits wasn't enough for me. so I've paid £30 for the year'; 'I got premium because I want more than 3 habits… it's just 2.50 a month'; 'using the free version for a couple of months to track medication management… upgrade today so that I could track other habits as well'
- **This app does:** 3-habit cap
- **User reaction:** purchase-driver
- **Magnitude:** trigger #2
- **Direction for us:** undecided · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6832692292`, `7258835816`, `12573082987`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R46-104 — Cross-device access is a paid trigger: 'I did upgrade so the data could be shown and updated on my watch' (3★); 'this has worked great between my windows desktop, iPad, and iPhone… Signed up for a year and it was worth every dollar'; 'For someone who loves data, this app is totally worth the yearly subscription… The web interface is great too'

- **Where:** §5.2 trigger 3 — cross-device access: 'I did upgrade so the data could be shown and updated on my watch' (3★); 'worked great between my windows desktop, iPad, and iPhone… worth every dollar'; 'For someone who loves data… The web interface is great too'
- **This app does:** sync paid
- **User reaction:** purchase-driver
- **Magnitude:** trigger #3
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `9822343856`, `5233752821`, `9951354980`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C030 Sync must work — and prove it

### R46-105 — Patronage and the lifetime option are the remaining triggers: supporting an independent developer 13 (0.60%, mean 4.92; 12 of 13 before July 2023) — 'I paid the subscription fee because it's a great app with a developer who obviously cares' (ADHD); 'Koupil jsem si abych podpořil vývojáře'; and a lifetime option finally existing — 'I had the app for one year on the annual plan, and after missing it for a couple of months, I bought the lifetime plan'; 'Mag keine Abomodelle und habe den Lifetime-Kauf gewählt. Klar, ist teuer, aber ich unterstütze gerne gute Umsetzungen'

- **Where:** §5.2 trigger 4 — supporting an independent developer (13, 0.60%, mean 4.92; 12 of 13 before Jul 2023): 'a developer who obviously cares' (ADHD); 'I bought it to support the developer' (CZ); trigger 5 — a lifetime option finally existing: 'after missing it for a couple of months, I bought the lifetime plan'; 'I don't like subscriptions so I chose lifetime. Sure, it's expensive, but I'm glad to support good work'
- **This app does:** indie dev; lifetime
- **User reaction:** purchase-driver
- **Magnitude:** indie 13 (4.92); lifetime 16 (4.56)
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `4997111034`, `11246800859`, `12237402875`, `9980580786`, `12695851528`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R46-110 — Upgrade barriers in descending frequency — rarely 'no money': (1) the subscription shape (one-time 53 + anti-subscription 41 — 'I'm not subscribing to ANOTHER subscription'), largely answered by the lifetime tier whose $99.99 price is the new barrier; (2) a free tier too small to judge (32, mean 1.88); (3) a named cheaper alternative (28 — 'Habit Tracker (€7) oder Streaks (€6) sind aber deutlich günstiger und ähnlich gut… 9,99€ wären doch ok als Einmalkauf'; 'Awesome Habits is $22.99 for a LIFETIME license. Habit Tracker (by Davetech Co) is $4.99'; '习惯口袋… 直接买断只要45'); (4) regional price level (8, all non-US — Turkey ×3 'premium 179 ₺ çok pahallı', Saudi '١٠٩ ريال سنويا !!', Vietnam suggesting ~30,000₫/month, Latin America 'demasiado cara', Israel cannot buy online at all, Kazakhstan); (5) students and minors (4 + 6 — '学生党真的伤不起'; 'the only money i get is chore money and i have to wash the windows for it' (5★); 'I go to Cambridge on a partially paid scholarship'; 'please offer discount for students' (Apr 2026); 'Is there a discount code for lifetime?'); (6) fear the app will disappear (5, all CN); (7) no Family Sharing ('there's no Family Sharing for the subscription; for that, €29 a year is too expensive'; 'It would be too expensive to have 5 subscriptions so my entire family could use the tool')

- **Where:** §5.6 Barriers to upgrading — (1) the subscription shape (53 + 41; 'I'm not subscribing to ANOTHER subscription'), now largely answered by lifetime whose price is the new barrier; (2) a free tier too small to judge (32, 1.88); (3) a named cheaper alternative (28: 'Habit Tracker (€7) or Streaks (€6) are much cheaper and similarly good… €9.99 one-time would be fine'; 'Awesome Habits is $22.99 for a LIFETIME license. Habit Tracker (by Davetech Co) is $4.99'; 'Habit Pocket… buyout is only ¥45'); (4) regional price (8, all non-US — Turkey ×3, Saudi '109 riyals a year!!', Vietnam ~30,000₫/month, Latin America, Israel cannot buy online, Kazakhstan); (5) students and minors (4 + 6: 'the only money i get is chore money and i have to wash the windows for it'; 'Cambridge on a partially paid scholarship'; 'please offer discount for students'; 'Is there a discount code for lifetime?'); (6) fear the app will disappear (5, CN); (7) no Family Sharing ('for that, €29 a year is too expensive'; 'too expensive to have 5 subscriptions so my entire family could use the tool')
- **This app does:** subscription $29.99 / lifetime $99.99
- **User reaction:** blocked-conversion
- **Magnitude:** 53 + 41; 32; 28; 8; 10; 5; 2
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8962574447`, `9863653291`, `8226941128`, `8679013164`, `6905795652`, `10491720133`, `9410319036`, `6775992927`, `7470203097`, `7936681479`, `9171626582`, `13689294667`, `5483060991`, `9723519853`, `10909796403`, `14014439909`, `14104386064`, `10144327227`, `11059131741`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C005 Know which competitors buyers compare against; C025 Scholarship / hardship / discount program; C037 Family plan; C092 Regional pricing; C147 Let people use the product before they pay; C186 Never revoke what earlier buyers paid for when the model changes

### R46-159 — Experiment: lifetime price test at $49 and $69 against the $99.99 control in a subset of storefronts — reviewers independently name $30–70 as the price at which they would buy; measure lifetime conversion × price and lifetime-price complaints

- **Where:** §8.4 E1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** lifetime price 27, rising; anchor $30–70
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10650959929`, `11735469517`, `10453985829`, `12101755389`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R46-161 — Experiment: 4-habit vs 3-habit free tier as a cohort test — whether rec. 9 costs conversions; measure trial starts, conversion and paywall-union language

- **Where:** §8.4 E3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** cap 180
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R46-162 — Experiment: a paid palette pack (one-time IAP) — whether colour demand is monetisable outside the subscription; measure attach rate and colour-request incidence

- **Where:** §8.4 E4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** more colours 59
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C261 A colour palette users can extend — more defaults, a hex picker, softer sets — because colour is the reward surface

### R46-163 — Experiment: a student / youth discount — 'students really can't afford it'; 'chore money'; a Cambridge scholarship student; 'please offer discount for students'; '₺30 a month is a lot'

- **Where:** §8.4 E5
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** student 4 + discount 6
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `5483060991`, `9723519853`, `10909796403`, `14014439909`, `10389679638`
- **Canonical:** C025 Scholarship / hardship / discount program

## Tactics the app used

### R46-005 — Outcome of an aggressive in-app rating prompt (from May 2023): review volume tripled (2023 alone is 28.0% of the corpus), the yearly mean stepped from 3.86 (2022) to 4.42 (2023) and climbed to 4.61 (2026) — partly a composition effect of shorter, happier, prompted reviews — at the cost of 50 prompt complaints (2.30%, mean 3.22) including 10 one-stars, 17 reviews written only to make it stop, and rating-as-punishment ('you keep asking me for a review? → I'm punishing you', IT, 1★, body 'miao'; 'J'aime everyday. Je n'aime pas qu'on me force la main pour laisser un avis', FR, 1★); 'fixed' in June 2023 per one reviewer, yet 19 more complaints followed in 2024–2026 and it is still live in Aug 2026

- **Where:** Eight warnings #3 / #7 — tactic outcome: an aggressive in-app rating prompt from May 2023 tripled review volume (2023 = 28.0% of the corpus) and lifted the yearly mean from 3.86 (2022) to 4.42 (2023) → 4.61 (2026), while generating 50 prompt complaints incl. 10 one-stars, 17 'writing only to make it stop', and 1★ punishments ('you keep asking me for a review? → I'm punishing you')
- **This app does:** rating prompt every few actions
- **User reaction:** 5★-burst
- **Magnitude:** 297 burst; 2022 3.86 → 2023 4.42; nag 50 (3.22, 10 1★); solicited 17
- **Direction for us:** dont · **Report confidence:** high confidence · **Generalisable:** yes
- **Review IDs:** `9975055378`, `11090018321`, `8258958104`, `10008701823`, `14423865619`, `12129865860`, `11474568668`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

### R46-034 — A cheaper web price than in-app was noticed and shared by reviewers: 'всего $12 в год (на сайте, в приложении больше)' ('only $12 a year on the website, more in the app', RU, 2019)

- **Where:** §2.2 web price cheaper than in-app — 'only $12 a year on the website, more in the app' (RU, 2019)
- **This app does:** web vs in-app price
- **User reaction:** praise
- **Magnitude:** n=1
- **Direction for us:** research · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `4306125740`
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R46-106 — Outcome of honouring an expired discount: a US reviewer who missed a December discount was given it anyway by the developer and wrote a 5★ ('Joan still hooked me up with the discounted subscription'); a Black Friday €15 price is noted (3★); free users state their purchase condition — 'If it helps me build three habits, I'll come back and pay!'; 'I am really close to paying for it so I can add a 4th habit' (nearly a year of use); 'I'm about to pay for the lifetime membership'

- **Where:** §5.2 Two promotional triggers — a Black Friday price ('the Black Friday deal (which right now is 15 euro)') and a discount honoured after it expired ('I must have missed it, but Joan still hooked me up with the discounted subscription'); stated intent: 'If it helps me build three habits, I'll come back and pay!'; 'I am really close to paying for it so I can add a 4th habit' (nearly a year of use); 'I'm about to pay for the lifetime membership'
- **This app does:** Black Friday; honoured discount
- **User reaction:** purchase-driver
- **Magnitude:** 2 promo + 3 intent
- **Direction for us:** do · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `6694266981`, `5959721651`, `13535076908`, `12197567600`, `13390939473`
- **Canonical:** C025 Scholarship / hardship / discount program; C089 Promos, giveaways and gift codes must work exactly as advertised

### R46-135 — Outcome of working the request queue — each shipped request stops and a praise theme starts: home-screen widgets (requests 4 → 4 → 0 → 0; praise 0.81% → 3.24% → 2.86% → 3.98%; Sept 2020, iOS 14); Apple Watch (3 → 2 → 0 → 0; Mar 2021); journal / notes / calendar (praise 0 → 0.19% → 1.25%; Dec 2023 – Feb 2024); folders / groups (Aug 2025); no-account use (8 complaints, none after Oct 2022, then praise); Chinese and Turkish UI (UI requests end 2021; Turkish praised Dec 2022); China connectivity (two instances after 2020) — the two largest open requests, colours and scheduling, are the next candidates

- **Where:** §7.7 Trend 6 — shipped requests closed and turned into praise (verbatim table): widgets (request 4 → 4 → 0 → 0; praise 0.81% → 3.98%; Sept 2020 iOS 14); Apple Watch (request 3 → 2 → 0 → 0; Mar 2021); journal / notes / calendar (praise 0 → 1.25%; Dec 2023 – Feb 2024); folders (Aug 2025); no-account use (8 complaints, none after Oct 2022); Chinese / Turkish UI (requests end 2021; Dec 2022); China connectivity (two instances after 2020) — the developer works the request queue and the corpus records the payoff each time; colours and scheduling are the next candidates
- **This app does:** ships requests
- **User reaction:** praise
- **Magnitude:** Capability | Request theme | Praise theme | Evidence of shipping ; Home-screen widgets | fr_widget: 4 → 4 → 0 → 0 | cp_widget: 0.81% → 3.24% → 2.86% → 3.98% | 6455669260 (Sept 2020, iOS 14 widgets) ; Apple Watch | fr_apple_watch: 3 → 2 → 0 → 0 | named in cp_cross_platform | 7142563934 (Mar 2021) ; Journal / notes / calendar | fr_notes_journal mostly pre-2024 | cp_journal_notes: 0 → 0 → 0.19% → 1.25% | 10762490298, 10940916205 (Dec 2023 – Feb 2024) ; Folders / groups | fr_grouping_tags 2020–2025 | folder praise 2025 | 12987527653 (Aug 2025), 13116954771 ; No-account use | mf_account_required: 8 complaints, none after Oct 2022 | no-account praise | 11481910041 (2024), 13247499575 (2025) ; Chinese / Turkish UI | ux_localization_gap UI requests end 2021 | — | 9410319036 (Dec 2022); listing ; China connectivity | rel_offline_mode_bug | — | two instances after 2020
- **Direction for us:** do · **Report confidence:** improving, high confidence · **Generalisable:** yes
- **Review IDs:** `6455669260`, `7142563934`, `10762490298`, `10940916205`, `12987527653`, `13116954771`, `11481910041`, `13247499575`, `9410319036`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

## Insights (the why)

### R46-009 — A product marketed on 'simple' invites 'simple things should be cheap': 163 reviews (7.48%, mean 2.84) call the price or subscription too high, the pricing-model union is 212 (9.73%, 2.92) — '$4.99 a month is too much to ask for the ability to electronically check a box'; 'for an app that is essentially a checkbox $30 (a year) is way too much'; '350 for a year for a considerably basic app… can just go do it in a spreadsheet' — benchmarked against Spotify ('R$17,90 is twice the Spotify subscription'), Adobe Lightroom, 200 GB of iCloud and Microsoft Office, 1Password, Notion and (Not Boring) Habits, with 28 naming a cheaper tracker they moved to (mean 2.25); the corpus records the rise: 'Price went from $1/month to $5/month, or from $12/year to $30/year. Most of the worth it reviews reflect the original pricing' (Jan 2020, 12 votes) — the same simplicity 425 people praise is the argument 163 use against paying

- **Where:** Executive summary #2 — price judged against simplicity: 163 (7.48%, mean 2.84) say the price / subscription is too high; pricing-model union 212 (9.73%, 2.92); '$4.99 a month is too much to ask for the ability to electronically check a box'; 'for an app that is essentially a checkbox $30 (a year) is way too much'; benchmarked against Spotify, Lightroom, 200 GB iCloud + Office, 1Password, Notion, (Not Boring) Habits; cheaper competitor 28 (2.25); 'Price went from $1/month to $5/month… Most of the worth it reviews reflect the original pricing' (12 votes) — a positioning problem as much as price
- **This app does:** $7.49/mo, $29.99/yr for a 'simple' app
- **User reaction:** complaint
- **Magnitude:** 163 (7.48%), 2.84; union 212 (9.73%), 2.92; cheaper competitor 28
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `5111990858`, `7060353342`, `6379337258`, `6162571234`, `6248048625`, `6859946614`, `8226941128`, `9882563220`, `5471831095`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C006 Stay minimal — every addition is opt-in or off by default; C064 Price level — where 'fair' turns into 'too expensive'

### R46-036 — Ease of use 185 (8.49%, mean 4.87) — 'I spend literally 10 seconds a day on it'

- **Where:** §3.1 master table #7 cp_ease_of_use
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 185 (8.49%), 4.87
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `10907874412`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R46-042 — Long-time users 42 (1.93%, mean 4.86)

- **Where:** §3.1 master table #24 seg_longtime_user
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 42 (1.93%), 4.86
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R46-045 — Value scepticism 32 (1.47%, 2.16); too basic 17 (0.78%, 3.18); stagnant development 5 (1.60)

- **Where:** §3.1 master table #31 neg_value_scepticism / #50 neg_too_basic / #90 neg_stagnant_development
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 32 + 17 + 5
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R46-051 — Reliable praised 16 (0.73%, mean 4.69)

- **Where:** §3.1 master table #52 cp_reliable
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 16 (0.73%), 4.69
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R46-055 — 'First review I've ever written' 12 (0.55%, mean 4.58)

- **Where:** §3.1 master table #61 seg_first_review_ever
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 12 (0.55%), 4.58
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R46-056 — No ads praised 10 (0.46%, 4.90); no gamification praised 3 (5.00) — 'habitica but without the stupid game mechanics'

- **Where:** §3.1 master table #64 mp_no_ads / #97 cp_no_gamification
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 10 + 3
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `9978469609`
- **Canonical:** C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R46-066 — Family aggregates: core praise 1,412 (64.83%, mean 4.82; 15 of 250 1–2★); monetisation friction 373 (17.13%, 2.80; 166 of 250 = 66.4%); feature gaps 197 (9.04%, 4.17; 17); UX friction 158 (7.25%, 3.49; 40 = 16.0%); reliability 151 (6.93%, 3.05; 55 = 22.0%); monetisation praise 151 (6.93%, 4.91; 0); purchase evidence 89 (4.12); support 66 (4.26); product-value criticism 53 (2.43%, 2.45; 29 = 11.6%); any praise 1,461 (67.08%) — (a) monetisation friction is 2.5× monetisation praise, the opposite of report 43's one-time app, so the pricing model is a net liability in the record; (b) friction covers two-thirds of bad reviews and is live in every era (70% of 2018–20 low-star reviews, 73% of 2021–early 2023, 51% of May–Dec 2023, 63% of 2024–26); (c) praise almost never coexists with a low rating — when the product loses a reviewer it is the paywall, the price or lost data, not the grid

- **Where:** §3.2 Theme-family aggregates (verbatim table) — core praise 1,412 (64.83%, 4.82) → 15 of 250 1–2★; monetisation friction 373 (17.13%, 2.80) → 166 (66.4%); meta 250; feature gaps 197 (9.04%, 4.17) → 17; UX friction 158 (7.25%, 3.49) → 40; reliability 151 (6.93%, 3.05) → 55 (22.0%); monetisation praise 151 (6.93%, 4.91) → 0; segments 108; purchase evidence 89 (4.12); support 66; product-value criticism 53 (2.43%, 2.45) → 29; any praise 1,461 (67.08%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Family | Themes | Reviews (union) | % of 2,178 | Mean ★ | Share of the 250 1–2★ reviews | Signal ; Core praise | 21 | 1412 | 64.83% | 4.82 | 15/250 (6.0%) | high-priority ; Monetization friction | 18 | 373 | 17.13% | 2.80 | 166/250 (66.4%) | high-priority ; Meta | 3 | 250 | 11.48% | 4.57 | 16/250 (6.4%) | high-priority ; Feature gaps & requests | 26 | 197 | 9.04% | 4.17 | 17/250 (6.8%) | high-priority ; UX friction | 10 | 158 | 7.25% | 3.49 | 40/250 (16.0%) | high-priority ; Reliability | 12 | 151 | 6.93% | 3.05 | 55/250 (22.0%) | high-priority ; Monetization praise | 5 | 151 | 6.93% | 4.91 | 0/250 (0.0%) | high-priority ; Segments | 5 | 108 | 4.96% | 4.75 | 5/250 (2.0%) | very strong ; Purchase evidence | 2 | 89 | 4.09% | 4.12 | 17/250 (6.8%) | very strong ; Support | 4 | 66 | 3.03% | 4.26 | 12/250 (4.8%) | very strong ; Product-value criticism | 3 | 53 | 2.43% | 2.45 | 29/250 (11.6%) | meaningful ; Any praise (core + monetization praise + support praise) | — | 1461 | 67.08% | 4.82 | 15/250 (6.0%) | high-priority
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C003 Lead with a one-time lifetime purchase

### R46-067 — Simplicity is the retention asset and the pricing liability at the same time: praised by 425 (19.51%, mean 4.87), the top theme and rising every era (16.40% → 17.71% → 19.62% → 21.59%) — 'I don't want to build a new habit of wasting time while tracking habits'; 'Most habit trackers are themselves distracting, this one is simple'; 'I'm really sick of apps with a million features and AI just to convolute things' (Apr 2026); 'A lot of great apps start this way, then they start adding weird features that nobody wants… pls dont do that'; 'I spend literally 10 seconds a day on it' — and the same word is used against the price ('Simple and overpriced… for an app that is essentially a checkbox $30 (a year) is way too much'); the fix is not to add complexity to justify the price but to change what the price is compared against

- **Where:** §3.3.1 Simplicity 425 (19.51%, mean 4.87), the top theme and still rising 16.40% → 17.71% → 19.62% → 21.59%; 'I don't want to build a new habit of wasting time while tracking habits'; 'Most habit trackers are themselves distracting'; 'I'm really sick of apps with a million features and AI just to convolute things' (Apr 2026); 'A lot of great apps start this way, then they start adding weird features that nobody wants… pls dont do that'; the same word used against the product: 'Simple and overpriced… essentially a checkbox $30 (a year)' — simplicity is the retention asset and the pricing liability at once
- **This app does:** minimal
- **User reaction:** praise
- **Magnitude:** 425 (19.51%), 4.87; rising
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `3392010074`, `4306125740`, `8200705711`, `10011917752`, `13943168290`, `12631375398`, `10907874412`, `7060353342`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C006 Stay minimal — every addition is opt-in or off by default

### R46-068 — The core loop produces outcomes: behaviour change 283 (12.99%, mean 4.93) — 'I started with 25 [words a day]… now a 40+ days streak, and I almost always write more than my goal'; 'me permitió encadenar hasta ahora cerca de 700 días!!'; 'a super lazy person managed to do over 1k pushups in 2025!'; 'killed my social media addiction, become much more resistant to procrastination, got free from caffeine dependency'; '62h d'expérience accumulés en 30 jours' of Blender; the habit-breaking mode is its own sub-theme (42, mean 4.98 — alcohol reduction, added sugar, screen time)

- **Where:** §3.3.2 Behaviour change 283 (12.99%, mean 4.93, joint-highest n>50): 'I've maintained a 40+ days streak, and I almost always write more than my goal'; 'nearly 700 days'; 'a super lazy person managed to do over 1k pushups in 2025'; 'killed my social media addiction… free from caffeine dependency'; '62h of Blender in 30 days'; habit-breaking 42 (1.93%, mean 4.98) — alcohol, sugar, screen time
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 283 (12.99%), 4.93; breaking 42 (4.98)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9952583686`, `9942715625`, `13606203965`, `11621928088`, `14343402459`, `10490353599`, `9728139886`, `11657479158`
- **Canonical:** C019 Quit-habit / bad-habit mode

### R46-070 — Beautiful design is often the first clause of a price complaint: design praise 227 (10.42%, mean 4.63 — the lowest-rated large praise theme, 23 at 1–3★: 'Beautiful app except the free version is useless'); pure praise — 'eye candy matters… Color and graphics make it so much easier to assimilate data and Everyday positively EXCELS at this'; 'people who are looking at my screen with me always — always! — ask what the app is because the cascading colors look so cool'

- **Where:** §3.3.4 Design and aesthetics 227 (10.42%, mean 4.63) — the lowest-rated large praise theme because it is often the first clause of a price complaint (23 of 227 at 1–3★: 'Beautiful app except the free version is useless'); 'eye candy matters… Everyday positively EXCELS'; 'people who are looking at my screen with me always ask what the app is because the cascading colors look so cool'
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 227 (10.42%), 4.63; 23 at 1–3★
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `5378982782`, `5280954299`, `9952382181`
- **Canonical:** C185 Aesthetic and a polished onboarding convert; they do not retain

### R46-080 — A checkbox priced like software is compared to a spreadsheet: value scepticism 32 (1.47%, mean 2.16) — 'You click squares and colours appear… college project'; 'una checklist con esteroides'; '$5 a month for a spreadsheet. No thanks'; 'The app doesn't actually DO anything… would need to actually complete the tasks for me to make the $30 subscription worth it'; a smaller cluster says the app stood still ('just quite minimal, basic and finished app on life-support… identical to how it was like 5+ years ago'; 'From 1.9.19 last year to 2.4.1, I see no changes') while long-time users say the opposite ('This app gets better and better overtime'; 'small updates periodically that makes sense but don't overwhelm')

- **Where:** §3.4.2 The value comparison — value scepticism 32 (1.47%, mean 2.16): 'You click squares and colours appear… college project'; 'una checklist con esteroides'; '$5 a month for a spreadsheet. No thanks'; 'The app would need to actually complete the tasks for me to make the $30 subscription worth it'; stagnant development 5 (1.60): 'on life-support… identical to how it was like 5+ years ago' vs 'This app gets better and better overtime'; 'small updates periodically that makes sense but don't overwhelm'
- **This app does:** $29.99/yr for a grid
- **User reaction:** complaint
- **Magnitude:** 32 (1.47%), 2.16; stagnant 5 (1.60)
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `5382735835`, `6391262502`, `8919460787`, `9466251748`, `13689294667`, `7830233665`, `13380357043`, `13749734782`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R46-093 — Why people give 5★: it is simple, it looks good, the colours pull them back, and it changed a behaviour — simplicity 24.9% of the band, behaviour change 17.6%, colour system 13.1%, competitive displacement 12.1%, design 11.7%, ease of use 11.0%, learn content 6.0%, cross-platform 4.2%, free tier sufficient 4.0%, widget 3.7%, support 3.3%, stats 3.2%; 219 of 1,532 come from the May–June 2023 burst and 169 are contentless, leaving 1,363 substantive 5★ (62.6% of the corpus); twenty 5★ contradict their text (won't open or connect, or protesting the rating prompt)

- **Where:** §4.1 Five stars (verbatim table) — simplicity 24.9%, behaviour change 17.6%, colour system 13.1%, displacement 12.1%, design 11.7%, low-info 11.0%, ease 11.0%, generic 10.8%, learn 6.0%, cross-platform 4.2%, free tier sufficient 4.0%, widget 3.7%, support 3.3%, stats 3.2%; 219 of 1,532 from the May–June 2023 burst, 169 contentless; 1,363 substantive 5★ (62.6%); twenty 5★ are contradictions — won't open / connect or protesting the prompt
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of 5★ ; cp_simplicity | 381 | 24.9% ; cp_behaviour_change | 269 | 17.6% ; cp_visual_colour_system | 200 | 13.1% ; cp_competitive_displacement | 185 | 12.1% ; cp_beautiful_design | 180 | 11.7% ; meta_low_information | 169 | 11.0% ; cp_ease_of_use | 168 | 11.0% ; cp_generic_positive | 165 | 10.8% ; cp_learn_content | 92 | 6.0% ; cp_cross_platform | 64 | 4.2% ; mp_free_tier_sufficient | 61 | 4.0% ; cp_widget | 57 | 3.7% ; sup_responsive_praise | 50 | 3.3% ; cp_stats | 49 | 3.2%
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `4836234866`, `4839785600`, `6436882098`, `6437984231`, `6440260322`, `8993455225`, `9917968507`, `9941031361`, `9955874108`, `10007869022`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R46-094 — 4★ is 'I love it but…' with the 'but' split evenly between monetisation and colour / scheduling requests: cap 13.0% of the band, price 11.9%, more colours 5.9%, one-time 5.5%, flexible frequency 4.7%, more free habits 4.3% — 'Only reason I gave it 4 starts is because it would be so great to have a share/compete with friends'; 'minus 1 star for me because it's kind of upsetting that you can only add 3 habits before having to pay'; 'the only reason I'm not leaving a five star review is because I feel like the App Store presentation of the app is misleading'; 'No 5 stars, because after the trial I can't delete the extra habits — they're locked' (DE); China supplies 37 of 253 (14.6% vs 6.2% of the corpus), rating 4★ while naming the price or the offline bug

- **Where:** §4.2 Four stars (verbatim table) — where the price of the fifth star is named: simplicity 13.0%, cap 13.0%, price 11.9%, design 9.5%, colour 9.1%, more colours 5.9%, one-time 5.5%, flexible frequency 4.7%, more free habits 4.3%; 'Only reason I gave it 4 starts is because it would be so great to have a share/compete with friends'; 'minus 1 star… you can only add 3 habits before having to pay'; 'the App Store presentation of the app is misleading'; 'after the trial I can't delete the extra habits — they're locked'; China contributes 37 of 253 (14.6% vs 6.2%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 4★ ; cp_simplicity | 33 | 13.0% ; mf_free_cap_3habits | 33 | 13.0% ; mf_price_too_high | 30 | 11.9% ; meta_low_information | 27 | 10.7% ; cp_beautiful_design | 24 | 9.5% ; cp_visual_colour_system | 23 | 9.1% ; fr_more_colours | 15 | 5.9% ; mf_want_one_time_purchase | 14 | 5.5% ; fr_flexible_frequency | 12 | 4.7% ; mf_more_free_habits_request | 11 | 4.3%
- **Direction for us:** research · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6640963989`, `9997347192`, `12132723234`, `8681575995`, `4808959996`, `5624585393`, `5753851503`, `6563915292`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C043 Flexible / custom frequency; C261 A colour palette users can extend — more defaults, a hex picker, softer sets — because colour is the reward surface

### R46-096 — 3★ is capped satisfaction and the cap is literal: free cap 35 of 143 (24.5%), price 32 (22.4%), design 13, one-time 11, review prompt 11 (7.7% — the prompt actively caps ratings it was designed to raise), simplicity 10; anti-subscription, paid subscription, lifetime price, trial too limited, more free habits, value scepticism 7–8 each — 'Serían 5 Estrellas si la versión free te deja poner mas de 3 hábitos'; '3 stars for the limitations of the free version'; 'I might have given five stars with use, but because of the insistence on a rating… it's only 3'; 'The rating will change when there's a landscape mode'

- **Where:** §4.3 Three stars (verbatim table) — the cap is literal: cap 24.5%, price 22.4%, design 9.1%, one-time 7.7%, review prompt 7.7%, simplicity 7.0%; 'It would be 5 stars if the free version let you add more than 3 habits'; '3 stars for the limitations of the free version'; 'I might have given five stars with use, but because of the insistence on a rating… it's only 3'; 'The rating will change when there's a landscape mode'; 11 of 143 (7.7%) are prompt complaints — the prompt is capping ratings it was designed to raise
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 3★ ; mf_free_cap_3habits | 35 | 24.5% ; mf_price_too_high | 32 | 22.4% ; cp_beautiful_design | 13 | 9.1% ; mf_want_one_time_purchase | 11 | 7.7% ; ux_review_prompt_nag | 11 | 7.7% ; cp_simplicity | 10 | 7.0% ; mf_anti_subscription / mp_paid_subscription / mf_lifetime_price_too_high / mf_trial_too_limited / mf_more_free_habits_request / neg_value_scepticism | 7–8 each | 4.9–5.6%
- **Direction for us:** product-rule · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10103326762`, `10022293641`, `10892779579`, `8971421965`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R46-097 — 2★ is the paywall band plus the unhappy-subscriber band: cap 29 of 84 (34.5%), price 26 (31.0%), trial too limited 8, paid subscription 8, review prompt / cheaper competitor / value scepticism / lifetime price 7 each, data loss / sync / anti-subscription 6 each; 10 of 84 (11.9%) are payers — the highest payer density of any band — complaining of Watch sync, Mac sync, data loss (three), the skip symbols, an unwanted animation, a widget missing after paying, reminders that could not be set after paying, and an annual plan wanted refunded

- **Where:** §4.4 Two stars (verbatim table) — the paywall band plus the unhappy-subscriber band: cap 34.5%, price 31.0%, trial too limited 9.5%, paid subscription 9.5%; 10 of 84 (11.9%) are payers, the highest density of any band — Watch sync, Mac sync, data loss ×3, the skip symbols, an unwanted animation, a widget missing after paying, reminders that could not be set after paying, an annual plan wanted refunded
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 2★ ; mf_free_cap_3habits | 29 | 34.5% ; mf_price_too_high | 26 | 31.0% ; mf_trial_too_limited | 8 | 9.5% ; mp_paid_subscription | 8 | 9.5% ; ux_review_prompt_nag / mf_competitor_cheaper / neg_value_scepticism / mf_lifetime_price_too_high | 7 each | 8.3% ; rel_data_loss / rel_sync_issues / mf_anti_subscription | 6 each | 7.1%
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `11016476901`, `13459643027`, `12356330098`, `13741293681`, `13765557194`, `10257601209`, `9462122321`, `7422190770`, `4864820069`, `6593564259`
- **Canonical:** C030 Sync must work — and prove it; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R46-107 — Payers justify the price by outcome, not by comparison: among 60 payers at 5★ — colour system 15, competitive displacement 14, worth the money 14, simplicity 13, behaviour change 11; price reasonableness only 2 of 97; longevity is distinctive ('订阅两年了，最爱用的习惯追踪app'; 'Will renew my annual subscription at the end of the month'; 'Paid customer for several years now') — 'Best ROI on your money of pretty much anything in life I can think of'; '$29/year for what this app is giving me in terms of mental health is an absolute steal'

- **Where:** §5.3 What paid users value — colour system 15, displacement 14, worth the money 14, simplicity 13, behaviour change 11; longevity ('Subscribed for two years — my favourite habit tracker'; 'Will renew my annual subscription'; 'Paid customer for several years now'); payers justify the price by outcome, not comparison — 'Best ROI on your money of pretty much anything in life'; '$29/year for what this app is giving me in terms of mental health is an absolute steal'
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 60/97 payers at 5★
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `9183960986`, `9945464712`, `13973660306`, `12116178936`, `6703493891`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

## Audiences

### R46-019 — Neurodivergent and chronically ill users (ADHD, OCD, autism, dyslexia, bipolar; 30 reviews, 1.38%, mean 4.83; 23 US; growing 0.54% → 1.70%) name the forgiving skip mark and the widget as what works: 'the ability to still log the days you don't do something… that feels like neutral data instead of a personal failing'; 'With my brain, if I don't see something I forget it exists… The widgets are my favorite part'; 'I've got chronic pain and having something forgiving is very nice. Completely functional without paying! No ads!'; 'as an individual affected by dyslexia… the progress… simply shown by diluted or intensified colors' — any change to how misses are displayed must be tested against this segment first

- **Where:** Executive summary #12 — ADHD / neurodivergent / chronic-illness users 30 (1.38%, mean 4.83; 23 US; 0.54% → 1.70%); the mechanisms named are the forgiving skip and the widget: 'log the days you don't do something… neutral data instead of a personal failing'; 'if I don't see something I forget it exists… The widgets are my favorite part'; 'chronic pain and having something forgiving is very nice. Completely functional without paying! No ads!'; 'dyslexia… progress simply shown by diluted or intensified colors' — any change to how misses display must be tested against this segment
- **This app does:** skip marks, colour grid, widget
- **User reaction:** praise
- **Magnitude:** 30 (1.38%), 4.83; 23 US; 0.54 → 1.70%
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10483508663`, `9961143974`, `12222718804`, `11918274646`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R46-126 — The neurodivergent segment has the highest mean of any segment and rests on three mechanics — the forgiving skip, the widget and minimal input: 30 reviews (1.38%, mean 4.83; 23 US) naming ADHD (18), OCD (2), neurodivergence (2), dyslexia, bipolar II, BPD, chronic illness or pain (2) and executive-function, CBT or medication uses; growing 0.54% → 0.75% → 1.90% → 1.70% by era — 'I have chronic illnesses where I can't always do everything. It's really encouraging to know that one off day doesn't kill your streak'; 'Love that it also has good Apple Watch app and iPhone widget integration'; 'It makes tracking habits a simple yes/no input, which is perfect for me and my ADHD because I've quickly become burnt out by decision fatigue on other apps'; 'Literally 3 click options: Did you do it? Tap. Did you do some of it? Tap. Tap.' (who also asks for font controls for 'unique reading needs'); only 3 of 30 are confirmed payers

- **Where:** §6.15 The ADHD / neurodivergent / chronic-illness segment — 30 (1.38%, mean 4.83), 23 US; ADHD 18, OCD 2, neurodivergent 2, dyslexia 1, bipolar II 1, BPD 1, chronic illness / pain 2, plus executive-function / CBT / medication uses; growth 0.54% → 0.75% → 1.90% → 1.70%; three mechanisms: the forgiving skip ('one off day doesn't kill your streak'), the widget ('good Apple Watch app and iPhone widget integration'), minimal input ('a simple yes/no input, which is perfect for me and my ADHD because I've quickly become burnt out by decision fatigue on other apps'; 'Literally 3 click options: Did you do it? Tap. Did you do some of it? Tap. Tap.' — who also asks for font controls); only 3 of 30 confirmed payers
- **This app does:** skip, widget, one-tap
- **User reaction:** praise
- **Magnitude:** 30 (1.38%), 4.83; 23 US; payers 3/30
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `4997111034`, `6703493891`, `6877373050`, `9486286103`, `9678067897`, `9942356920`, `9943686378`, `9952382181`, `9957115619`, `9961143974`, `9997347192`, `9997985968`, `10483508663`, `10506700189`, `10730081960`, `10778721049`, `10878622009`, `11153160723`, `11433849366`, `11694795267`, `11839292996`, `11915235002`, `11918274646`, `12129775211`, `12136286563`, `12222718804`, `12515196712`, `12701597104`, `13943168290`, `14091755398`
- **Canonical:** C009 Basic widgets, icons and colours are free; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

## Markets and languages

### R46-017 — China (n = 136) has its own defect, its own purchase preference and its own fear: (a) 16 of the corpus's 17 'app shows offline mode while online' reports are Chinese (11.76% of CN), nine of them in the nine days 20–28 Sep 2019 and five more in Mar–Apr 2020 — consistent with the sync backend being intermittently unreachable from the mainland, not recurring at volume since 2020; (b) 15 of 53 one-time-purchase requests are Chinese (28.3%; 11.03% of CN) — '如果有一次性完整付费，我会更愿意掏钱'; (c) all 5 reviews that hesitate to pay for fear the app will vanish are Chinese, using 跑路 ('run off') — '之前用过一个类似的软件还支付了费用，结果跑路了，希望你们别跑'

- **Where:** Executive summary #10 — China (136, 6.24%) is distinct: (a) 16 of 17 'offline mode while online' reports are Chinese (11.76% of CN), nine in 20–28 Sep 2019 and five in Mar–Apr 2020 — sync backend intermittently unreachable from the mainland; (b) 15 of 53 one-time-purchase requests are Chinese (11.03% of CN; 'If there were a one-time full purchase, I'd be more willing to pay'); (c) all 5 longevity doubts are Chinese — 跑路 ('I paid for a similar app before and it ran off — I hope you don't')
- **This app does:** account sync backend; subscription
- **User reaction:** complaint
- **Magnitude:** CN 136 (6.24%), 4.23; offline 16/17 (11.76% of CN); one-time 15/53; longevity 5/5
- **Direction for us:** research · **Report confidence:** CN standalone · **Generalisable:** yes
- **Review IDs:** `4808959996`, `4848868262`, `5912213663`, `5210358729`, `4836234866`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C186 Never revoke what earlier buyers paid for when the model changes; C188 The app must open offline — never block launch on a network call; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R46-088 — Localise the content, not just the UI — a missing-language content library blocks a subscription: 'Lo malo es que todo el soporte: consejos, ayuda, videos, reto de 7 días... está en inglés, para mi sorpresa, pues el desarrollador es español. Si estuviera en español, me plantearía suscribirme' (ES, 4★); 'ينقصه أمر واحد فقط.. وهو ترجمة الكتب والمقاطع التعليمية' (KW, 4★) — 13 reviews (0.60%, mean 4.08); earlier UI requests were answered — Turkish (16 votes, Jul 2020) praised in Turkish by Dec 2022, both Chinese scripts now listed

- **Where:** §3.4.4 ux_localization_gap 13 — the UI is in 15 languages, the remaining gap is content: 'all the support — tips, help, videos, 7-day challenge — is in English, which surprised me because the developer is Spanish. If it were in Spanish, I'd consider subscribing'; 'It lacks only one thing — translating the books and instructional videos' (KW); earlier UI requests (Turkish 16 votes Jul 2020; Chinese) were answered — Turkish praised by Dec 2022, both Chinese scripts listed
- **This app does:** UI 15 languages; content English
- **User reaction:** blocked-conversion
- **Magnitude:** 13 (0.60%), 4.08
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `8985834449`, `11171579515`, `6164086392`, `5999679530`, `7999081675`, `9410319036`
- **Canonical:** C027 Localise early — it unlocks revenue

### R46-112 — Storefront distribution: US 728 (33.43%, mean 4.34, 44 payers), China 136 (6.24%, 4.23, 7), Spain 127 (5.83%, 4.33, 2), Canada 99 (4.55%, 4.32, 4), Germany 84 (3.86%, 3.95 — the lowest eligible), UK 84 (3.86%, 4.33), Russia 74 (3.40%, 4.43), Brazil 67 (3.08%, 4.28), India 58 (2.66%, 4.52 — the highest), Turkey 54 (2.48%, 4.35); France 48 (4.60), Mexico 48 (4.69), Australia 47 (4.45), Italy 46 (4.11) limited; 17 storefronts with 10–26, 41 with 2–9, 21 with 1; the US mean (4.34) and non-US mean (4.33) are identical

- **Where:** §6.1 Distribution (verbatim table) — US 728 (4.34, 44 payers), CN 136 (4.23), ES 127 (4.33), CA 99 (4.32), DE 84 (3.95, lowest), GB 84 (4.33), RU 74 (4.43), BR 67 (4.28), IN 58 (4.52, highest), TR 54 (4.35); FR 48 (4.60), MX 48 (4.69), AU 47, IT 46 limited; 17 with 10–26; 41 with 2–9; 21 with 1; US 4.34 and non-US 4.33 identical
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | % of 2,178 | Mean ★ | 5/4/3/2/1 | Payers | Eligible? ; United States | 728 | 33.43% | 4.34 | 544/53/33/33/65 | 44 | Yes ; China | 136 | 6.24% | 4.23 | 73/37/17/2/7 | 7 | Yes ; Spain | 127 | 5.83% | 4.33 | 93/11/5/8/10 | 2 | Yes ; Canada | 99 | 4.55% | 4.32 | 73/10/1/5/10 | 4 | Yes ; Germany | 84 | 3.86% | 3.95 | 48/9/10/9/8 | 2 | Yes ; United Kingdom | 84 | 3.86% | 4.33 | 57/13/4/5/5 | 4 | Yes ; Russia | 74 | 3.40% | 4.43 | 56/6/4/4/4 | 5 | Yes ; Brazil | 67 | 3.08% | 4.28 | 45/8/8/0/6 | 1 | Yes ; India | 58 | 2.66% | 4.52 | 44/7/2/3/2 | 3 | Yes ; Turkey | 54 | 2.48% | 4.35 | 35/9/7/0/3 | 1 | Yes ; France | 48 | 2.20% | 4.60 | 38/4/4/1/1 | 4 | No — limited evidence ; Mexico | 48 | 2.20% | 4.69 | 38/7/2/0/1 | 1 | No — limited evidence ; Australia | 47 | 2.16% | 4.45 | 32/8/5/0/2 | 3 | No — limited evidence ; Italy | 46 | 2.11% | 4.11 | 27/7/7/0/5 | 1 | No — limited evidence ; 17 storefronts with 10–26 reviews (PL, CO, KR, CZ, CH, CL, SE, JP, NL, TW, BE, AR, TH, VN, UA, IL, SA) | 284 | 13.04% | — | — | — | No ; 41 storefronts with 2–9 reviews | 173 | 7.94% | — | — | — | No ; 21 storefronts with 1 review | 21 | 0.96% | — | — | — | No
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R46-113 — US (n = 728, mean 4.34): simplicity 24.31%, colour system 15.11% (well above global), displacement 12.77%, cap 7.28% (below), price 6.87% (below), payer 4.53%, review prompt 4.26% (1.9× global), ADHD / neurodivergent 3.16% (2.3×), misleading free 1.65%, one-time purchase 1.24% (half), data loss 0.55% (half) — four distinctively American things: the rating prompt is felt hardest here (31 of 50 complaints, 62%), the ADHD segment is American (23 of 30), Americans ask for a one-time purchase far less (9 of 53) and data loss is under-represented (4 of 24); the highest payer rate of any eligible storefront (6.04%) and the most detailed comparison shopping (a reviewer pricing Awesome Habits and Habit Tracker lifetime licences against this subscription)

- **Where:** §6.2 United States — n = 728, mean 4.34 (verbatim table): simplicity 24.31%, colour 15.11% (well above), displacement 12.77%, cap 7.28% (below), price 6.87%, payer 4.53%, review prompt 4.26% (1.9×), ADHD 3.16% (2.3×), misleading free 1.65%, one-time 1.24% (half), data loss 0.55% (half); four American things — the prompt felt hardest (62% of complaints), the ADHD segment American (76.7%), one-time asked far less (17% of requests), data loss under-represented; highest payer rate 6.04%; the most detailed comparison shopping
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 728 | Signal (US) | vs global ; cp_simplicity | 177 | 24.31% | high-priority | above global 19.51% ; cp_visual_colour_system | 110 | 15.11% | high-priority | well above global 10.47% ; cp_competitive_displacement | 93 | 12.77% | high-priority | above global 9.09% ; mf_free_cap_3habits | 53 | 7.28% | high-priority | below global 8.26% ; mf_price_too_high | 50 | 6.87% | high-priority | below global 7.48% ; mp_paid_subscription | 33 | 4.53% | very strong | above global 3.40% ; ux_review_prompt_nag | 31 | 4.26% | very strong | 1.9× global 2.30% ; seg_adhd_neuro_health | 23 | 3.16% | very strong | 2.3× global 1.38% ; mf_misleading_free_claim | 12 | 1.65% | meaningful | above global 1.24% ; mf_want_one_time_purchase | 9 | 1.24% | meaningful | half global 2.43% ; rel_data_loss | 4 | 0.55% | emerging | half global 1.10%
- **Direction for us:** research · **Report confidence:** US standalone · **Generalisable:** yes
- **Review IDs:** `8226941128`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C062 Weight English-speaking rich markets; volume ≠ revenue; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R46-114 — China (n = 136, mean 4.23) objects to the payment shape, not the cap: price 12.50% (1.7× global), offline-mode bug 11.76% (15×), design 11.76%, one-time purchase 11.03% (4.5×), simplicity 10.29% (half), rating mismatch 5.15%, crash 4.41%, longevity doubt 3.68% (all 5 in the corpus), cap 2.94% (a third of global) — '感觉价格好贵，有没一次性买断，不喜欢订阅暗扣' ('is there a one-time buyout? I don't like subscription auto-deductions'); '其他时间计划管理类的app永久买断制的大多¥12，了不起就是¥18，你这只是包年就一百多' ('Other planning apps with a permanent buyout are mostly ¥12, ¥18 at most — yours is over ¥100 for a single year', 5★); '希望通过降低价格，一次性买断，吸引更多用户，来提高收益'; 4★ is China's modal complaint rating (37 of 136, 27.2% vs 11.6% globally) — Chinese reviewers rate generously while stating a defect; half of CN reviews are from 2018–2020, only 27 in 2024–26

- **Where:** §6.3 China — n = 136, mean 4.23 (verbatim table): price 12.50% (1.7×), offline-mode bug 11.76% (15×), design 11.76%, one-time 11.03% (4.5×), simplicity 10.29% (half), mismatch 5.15%, crash 4.41%, longevity doubt 3.68% (all 5), cap 2.94% (a third) — Chinese reviewers object to the payment shape, not the cap ('is there a one-time buyout? I don't like subscription auto-deductions'; 'Other planning apps with a permanent buyout are mostly ¥12, ¥18 at most — yours is over ¥100 for a single year'; 'Lower the price and offer a one-time buyout to attract more users and raise revenue'); 4★ is China's modal complaint rating (27.2% vs 11.6%); half of CN reviews are 2018–20
- **This app does:** subscription; ¥118–198/yr
- **User reaction:** blocked-conversion
- **Magnitude:** Theme | n | % of 136 | Signal (CN) | vs global ; mf_price_too_high | 17 | 12.50% | high-priority | 1.7× global ; rel_offline_mode_bug | 16 | 11.76% | high-priority | 15× global 0.78% ; cp_beautiful_design | 16 | 11.76% | high-priority | similar ; mf_want_one_time_purchase | 15 | 11.03% | high-priority | 4.5× global 2.43% ; cp_simplicity | 14 | 10.29% | high-priority | half global 19.51% ; meta_rating_text_mismatch | 7 | 5.15% | high-priority | 3.6× global ; rel_crash_freeze | 6 | 4.41% | very strong | 3.8× global ; mf_longevity_doubt | 5 | 3.68% | very strong | all 5 in the corpus ; mf_free_cap_3habits | 4 | 2.94% | meaningful | a third of global 8.26%
- **Direction for us:** build-paid · **Report confidence:** CN standalone · **Generalisable:** yes
- **Review IDs:** `4888630106`, `7151302123`, `5753851503`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C188 The app must open offline — never block launch on a network call; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R46-115 — Spain (n = 127, mean 4.33) is the developer's home market and reads like one — warm and harsh at once: behaviour change 18.90% (1.5× global), simplicity 18.11%, ease of use 13.39%, cap 11.81% (1.4×, and at mean 2.00 the harshest cap objection anywhere — 'Solo te deja crear 3 hábitos sin pagar. Instalada, probada y desinstalada en menos de 2 minutos'), price 7.09%, anti-subscription 3.94% (2.1×); at least 11 reviews are written entirely in Catalan, two praising the Catalan localisation by name ('A més està totalment en català'; 'En català!'); reviewers address the developer directly ('Enhorabuena Joan!!'; 'Felicitats Joan per aquesta app'); the Spanish reviewer who would 'consider subscribing' if the Learn content were in Spanish is the clearest localisation-to-revenue statement in the corpus

- **Where:** §6.4 Spain — n = 127, mean 4.33 (verbatim table): behaviour change 18.90% (1.5×), simplicity 18.11%, ease 13.39%, cap 11.81% (1.4×, mean 2.00 — harsher than anywhere), price 7.09%, anti-subscription 3.94% (2.1×), support praise 3.15%; the developer's home market — ≥ 11 reviews entirely in Catalan, two praising the Catalan localisation by name ('A més està totalment en català'); reviewers address the developer ('Enhorabuena Joan!!'; 'Felicitats Joan'); 'Installed, tried and uninstalled in under 2 minutes'; the content gap lands hardest here
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 127 | Signal (ES) | vs global ; cp_behaviour_change | 24 | 18.90% | high-priority | 1.5× global ; cp_simplicity | 23 | 18.11% | high-priority | similar ; cp_ease_of_use | 17 | 13.39% | high-priority | 1.6× global ; mf_free_cap_3habits | 15 | 11.81% | high-priority | 1.4× global; mean 2.00 ; mf_price_too_high | 9 | 7.09% | high-priority | similar ; mf_anti_subscription | 5 | 3.94% | very strong | 2.1× global ; sup_responsive_praise | 4 | 3.15% | very strong | above global
- **Direction for us:** research · **Report confidence:** ES standalone · **Generalisable:** yes
- **Review IDs:** `3221329083`, `4252095651`, `5833679942`, `6528345270`, `6935333300`, `9956172746`, `10309159252`, `10404136654`, `10485601208`, `12834595865`, `13432563724`, `6204835609`, `7935648962`, `6389890469`, `8985834449`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C027 Localise early — it unlocks revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R46-116 — Canada (n = 99, mean 4.32): simplicity 20.20%, cap 10.10%, Learn content 9.09% (1.9× global), price 7.07%, cross-platform 6.06%, data loss 3.03% (2.8×, all three 1★ — 'both my habits are missing and all of my progress'; a $40 annual payer; an account not recognised), lifetime price too high 3.03% (2.4×) — Canadian-dollar prices sharpen the objection: 'It's like $40/year just to track more than 3 habits. Are you out of your mind???' (4★); '$9.99 a month · $39.99 per year · $129.99 life time… the prices are not anywhere close to worth it' (1★); 'The price for 129.99$ CAD is way too high for a lifetime purchase' (1★)

- **Where:** §6.5 Canada — n = 99, mean 4.32 (verbatim table): simplicity 20.20%, cap 10.10%, learn content 9.09% (1.9×), price 7.07%, cross-platform 6.06%, data loss 3.03% (2.8×, mean 1.00), lifetime price 3.03% (2.4×); CAD prices sharpen objections ('It's like $40/year just to track more than 3 habits. Are you out of your mind???'; '$9.99 a month · $39.99 per year · $129.99 life time… not anywhere close to worth it'; 'The price for 129.99$ CAD is way too high for a lifetime purchase'); all three CA data-loss reviews 1★
- **This app does:** CAD $39.99 / $129.99
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 99 | Signal (CA) | vs global ; cp_simplicity | 20 | 20.20% | high-priority | similar ; mf_free_cap_3habits | 10 | 10.10% | high-priority | 1.2× global ; cp_learn_content | 9 | 9.09% | high-priority | 1.9× global 4.91% ; mf_price_too_high | 7 | 7.07% | high-priority | similar ; cp_cross_platform | 6 | 6.06% | high-priority | 1.8× global ; rel_data_loss | 3 | 3.03% | very strong | 2.8× global; mean 1.00 ; mf_lifetime_price_too_high | 3 | 3.03% | very strong | 2.4× global
- **Direction for us:** research · **Report confidence:** CA standalone (data loss n=3) · **Generalisable:** yes
- **Review IDs:** `6914413184`, `10772502203`, `10356458728`, `6519048624`, `6998451648`, `10988898467`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C064 Price level — where 'fair' turns into 'too expensive'

### R46-117 — Germany (n = 84, mean 3.95, the lowest eligible storefront) loves the product and dislikes the business model in equal measure: simplicity 21.43% at a perfect 5.00, design 14.29%, yet every monetisation theme runs at two to four times its global rate — price 17.86% (2.4×), cap 16.67% (2.0×), one-time purchase 7.14% (2.9×), anti-subscription 7.14% (3.8×), more colours 7.14% (2.6×), localisation gap 3.57% (6×) — 'bis man gezwungen wird… völlig überteuerten Abo-Preis von 4.99 Euro abzuschließen… wo soll man in der heutigen Zeit denn noch alles ein Abo abschließen??? … Dann lieber ein Notizblock für 5 Euro kaufen' (2★); 'Gäbe es statt eines Abos die Möglichkeit den vollen Umfang mit einer einmaligen Zahlung zu bekommen, wäre es… eine Überlegung auf jeden Fall wert' (3★); the most precise articulation of the colour mechanic in any language ('keine Häkchen zum abhaken sondern Flächen die sich in schönen Farben füllen. Dh ich fühle mich nicht gestresst dadurch etwas nicht zu schaffen'); two say they cannot use it because they do not read English (2020, Dec 2023) although German is listed — the market where a one-time or lifetime price test would be most informative

- **Where:** §6.6 Germany — n = 84, mean 3.95, the lowest eligible (verbatim table): simplicity 21.43% (mean 5.00), price 17.86% (2.4×), cap 16.67% (2.0×), design 14.29% (mean 3.92), one-time 7.14% (2.9×), anti-subscription 7.14% (3.8×), more colours 7.14% (2.6×), localisation gap 3.57% (6×); the subscription model argued against most intensely ('how many subscriptions are we supposed to have these days??? … Better to buy a €5 notepad'; 'If there were a one-time payment for the full version instead of a subscription, it would definitely be worth considering'); the most precise articulation of the colour mechanic ('not ticks to check off but areas that fill with beautiful colours — so I don't feel stressed about not managing something'); two cannot use it without German (2020, Dec 2023) though German is listed — loved and disliked in equal measure; the market for a one-time / lifetime price test
- **This app does:** subscription €4.99/mo
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 84 | Signal (DE) | vs global ; cp_simplicity | 18 | 21.43% | high-priority | similar; mean 5.00 ; mf_price_too_high | 15 | 17.86% | high-priority | 2.4× global ; mf_free_cap_3habits | 14 | 16.67% | high-priority | 2.0× global ; cp_beautiful_design | 12 | 14.29% | high-priority | above global; mean 3.92 ; mf_want_one_time_purchase | 6 | 7.14% | high-priority | 2.9× global ; mf_anti_subscription | 6 | 7.14% | high-priority | 3.8× global ; fr_more_colours | 6 | 7.14% | high-priority | 2.6× global ; ux_localization_gap | 3 | 3.57% | very strong | 6× global
- **Direction for us:** build-paid · **Report confidence:** DE standalone · **Generalisable:** yes
- **Review IDs:** `7922529530`, `6140095778`, `10144327227`, `8314270653`, `5973806674`, `10678104377`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C012 Week / month / year grid views; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone; C255 An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language

### R46-118 — UK (n = 84, mean 4.33) is the clearest design-led switcher market: simplicity 20.24%, design 16.67% (1.6× global), competitive displacement 14.29% (1.6×), cap 9.52%, price 9.52%, flexible frequency 4.76% (3×), review prompt 4.76% (2×) — 'For me this beats the many overdesigned and over complicated competitor habit tracking apps out there'; 'By far the best habit tracker I've ever used (and I've been through them all)'; also the corpus's most concrete affordability barrier (a Cambridge scholarship student, 2★) and an early iOS-update wipe ('The new IOS update has wiped all of my historical and tracking data', 1★, Sep 2022)

- **Where:** §6.7 United Kingdom — n = 84, mean 4.33 (verbatim table): simplicity 20.24%, design 16.67% (1.6×), displacement 14.29% (1.6×), cap 9.52%, price 9.52%, flexible frequency 4.76% (3×), review prompt 4.76% (2×); the clearest design-led switcher market ('beats the many overdesigned and over complicated competitor habit tracking apps'; 'By far the best habit tracker I've ever used (and I've been through them all)'); the Cambridge scholarship student; an iOS-update wipe (Sep 2022, 'The new IOS update has wiped all of my historical and tracking data')
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of 84 | Signal (GB) | vs global ; cp_simplicity | 17 | 20.24% | high-priority | similar ; cp_beautiful_design | 14 | 16.67% | high-priority | 1.6× global ; cp_competitive_displacement | 12 | 14.29% | high-priority | 1.6× global ; mf_free_cap_3habits | 8 | 9.52% | high-priority | similar ; mf_price_too_high | 8 | 9.52% | high-priority | similar ; fr_flexible_frequency | 4 | 4.76% | very strong | 3× global ; ux_review_prompt_nag | 4 | 4.76% | very strong | 2× global
- **Direction for us:** none · **Report confidence:** GB standalone · **Generalisable:** yes
- **Review IDs:** `7811166928`, `11059537057`, `10909796403`, `9061668857`
- **Canonical:** C005 Know which competitors buyers compare against; C025 Scholarship / hardship / discount program; C175 Updates must not break function or wipe progress

### R46-119 — Russia (n = 74, mean 4.43) is the mirror image of Germany on price and the epicentre of the recent data-loss cluster: price reasonable 8.11% (8.8× global — 'по адекватной цене'; 'за скромные деньги'; 'абсолютно адекватная цена'; 'подписка стоит своих денег') against zero Russian lifetime-price objections — consistent with regional price tiers landing well; data loss 8.11% (7.4×, mean 2.17 — 6 of the corpus's 24 and all four 2026 cases, 7 Feb → 1 Mar 2026, plus two of the storefront's three sync complaints; earlier 'Widgets doesn't not work now. Progress in not saved' (Oct 2023) and a new habit erased within minutes (Mar 2024)); more colours 9.46% (3.5× — 'I'm really waiting for new colours, or the ability to set colours by code'); displacement 14.86%; paid subscription 6.76% — limited by count (n = 6) but one storefront, one month, the same symptom from four independent reviewers is itself the finding

- **Where:** §6.8 Russia — n = 74, mean 4.43 (verbatim table): simplicity 18.92%, displacement 14.86%, more colours 9.46% (3.5×), price reasonable 8.11% (8.8×: 'at a reasonable price'; 'for modest money'; 'an absolutely reasonable price'; 'the subscription is worth the money' — zero lifetime-price objections; consistent with regional tiers landing well), data loss 8.11% (7.4×, mean 2.17 — 6 of 24 and all four 2026 cases), paid subscription 6.76%, sync 4.05% (5.9×); earlier: 'Widgets doesn't not work now. Progress in not saved' (Oct 2023); a new habit erased within minutes (Mar 2024) — the mirror image of Germany on price and the epicentre of the data-loss cluster
- **This app does:** regional price; data loss cluster
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 74 | Signal (RU) | vs global ; cp_simplicity | 14 | 18.92% | high-priority | similar ; cp_competitive_displacement | 11 | 14.86% | high-priority | 1.6× global ; fr_more_colours | 7 | 9.46% | high-priority | 3.5× global ; mp_price_reasonable | 6 | 8.11% | high-priority | 8.8× global 0.92% ; rel_data_loss | 6 | 8.11% | high-priority | 7.4× global 1.10%; mean 2.17 ; mp_paid_subscription | 5 | 6.76% | high-priority | 2× global ; rel_sync_issues | 3 | 4.05% | very strong | 5.9× global
- **Direction for us:** must-never-break · **Report confidence:** RU standalone · **Generalisable:** yes
- **Review IDs:** `7823007976`, `12155849294`, `12814788584`, `13112620591`, `13741293681`, `13765557194`, `10429731916`, `10995769246`, `11699632553`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C092 Regional pricing; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone; C261 A colour palette users can extend — more defaults, a hex picker, softer sets — because colour is the reward surface

### R46-120 — Brazil (n = 67, mean 4.28): the objection is the cap plus the local price — cap 14.93% (1.8× global), price 5.97%, behaviour change 17.91% (1.4×), simplicity 16.42%, design dated 4.48% (2.9×) — 'pagar 17,90 POR MÊS ou 107,90 POR ANO, eu acho desnecessário… só pra ter modo escuro ou off-line' (3★); 'R$17,90 is twice the Spotify subscription' (4★); 'Praticamente, não possui versão gratuita… é 20 reais por mês o premium' (1★); one confirmed payer (1.49%), the lowest payer rate of any eligible storefront

- **Where:** §6.9 Brazil — n = 67, mean 4.28 (verbatim table): behaviour change 17.91% (1.4×), simplicity 16.42%, cap 14.93% (1.8×), price 5.97%, design dated 4.48% (2.9×); the cap plus local price ('paying R$17.90 A MONTH or R$107.90 A YEAR seems unnecessary… just to get dark mode or offline'; 'R$17,90 is twice the Spotify subscription'; 'Practically, there's no free version… premium is R$20 a month'); one confirmed payer (1.49%), the lowest of any eligible storefront
- **This app does:** R$17.90/mo, R$107.90/yr
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 67 | Signal (BR) | vs global ; cp_behaviour_change | 12 | 17.91% | high-priority | 1.4× global ; cp_simplicity | 11 | 16.42% | high-priority | similar ; mf_free_cap_3habits | 10 | 14.93% | high-priority | 1.8× global ; mf_price_too_high | 4 | 5.97% | high-priority | similar ; ux_design_dated_or_clunky | 3 | 4.48% | very strong | 2.9× global
- **Direction for us:** research · **Report confidence:** BR standalone · **Generalisable:** yes
- **Review IDs:** `6139789378`, `6162571234`, `11109081304`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C064 Price level — where 'fair' turns into 'too expensive'

### R46-121 — India (n = 58, mean 4.52, the highest eligible storefront) negotiates rather than objects: the cap itself appears only twice (3.45%) while the request for a few more free habits appears five times (8.62%, 6.5× global) — 'Can add 3 habits in free version at least give option of 7' (2★); 'Just 1 thing I wish the developer gives 1 more extra space for adding another habit in free version' (5★); 'I hope the free version of the app allows a user to add 5 to 6 habits' (5★); 'please make it cheaper or give option to add few more habits in the free plan' (4★); simplicity 27.59% (1.4×); the 2020 widget requests (5.17%) closed when widgets shipped

- **Where:** §6.10 India — n = 58, mean 4.52, the highest eligible (verbatim table): simplicity 27.59% (1.4×), more free habits request 8.62% (6.5×), widget 5.17% (2020 only), cap 3.45% (below) — Indian reviewers negotiate rather than object ('at least give option of 7'; 'gives 1 more extra space for adding another habit in free version' (5★); 'allows a user to add 5 to 6 habits' (5★); 'please make it cheaper or give option to add few more habits'); the 2020 widget requests closed when widgets shipped
- **This app does:** 3-habit cap
- **User reaction:** blocked-conversion
- **Magnitude:** Theme | n | % of 58 | Signal (IN) | vs global ; cp_simplicity | 16 | 27.59% | high-priority | 1.4× global ; mf_more_free_habits_request | 5 | 8.62% | high-priority | 6.5× global 1.33% ; fr_widget | 3 | 5.17% | high-priority | 14× global (2020 only) ; mf_free_cap_3habits | 2 | 3.45% | very strong | below global 8.26%
- **Direction for us:** product-rule · **Report confidence:** IN standalone · **Generalisable:** yes
- **Review IDs:** `6163200202`, `6314748920`, `10900370698`, `12761421173`, `5502215122`, `6146989015`, `7265168578`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R46-122 — Turkey (n = 54, mean 4.35) is the clearest regional-price market and the best-documented localisation success: cap 14.81% (1.8× global), price 11.11% (1.5×), regional pricing 5.56% (15× — 'premium 179 ₺ çok pahallı'; 'your prices for Turkey are quite high'; 'Öğrenci indirimi olsa iyi olurdu. Aylık 30 tl çok bence'), more free habits 5.56% (4.2×), low-information 16.67%; a Turkish-language request with 16 helpful votes (Jul 2020) is followed by 'Aradığım özellikler gayet sade ve Türkçe olarak bir araya getirilmiş' (5★, Dec 2022)

- **Where:** §6.11 Turkey — n = 54, mean 4.35 (verbatim table): low-information 16.67%, cap 14.81% (1.8×), price 11.11% (1.5×), regional pricing 5.56% (15×), more free habits 5.56% (4.2×); the clearest regional-price market ('premium at ₺179 is very expensive'; 'your prices for Turkey are quite high'; 'A student discount would be nice. ₺30 a month is a lot'); the best-documented localisation success — a Turkish-language request with 16 votes (Jul 2020) followed by 'The features I was looking for are brought together simply and in Turkish' (5★, Dec 2022)
- **This app does:** ₺179 / ₺30 per month
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 54 | Signal (TR) | vs global ; meta_low_information | 9 | 16.67% | high-priority | 1.8× global ; mf_free_cap_3habits | 8 | 14.81% | high-priority | 1.8× global ; mf_price_too_high | 6 | 11.11% | high-priority | 1.5× global ; mf_regional_pricing | 3 | 5.56% | high-priority | 15× global 0.37% ; mf_more_free_habits_request | 3 | 5.56% | high-priority | 4.2× global
- **Direction for us:** do · **Report confidence:** TR standalone · **Generalisable:** yes
- **Review IDs:** `6905795652`, `10491720133`, `10389679638`, `6164086392`, `9410319036`
- **Canonical:** C027 Localise early — it unlocks revenue; C092 Regional pricing

### R46-123 — High-spend markets (US, JP, CN, GB, DE, KR, CA, AU, FR; 1,265 reviews, 58.08%, mean 4.32 vs 4.34): the payer rate is twice as high inside (5.61% vs 2.85%) — the only large behavioural difference; the cap objection is the same inside and outside (7.91% vs 8.76%) so it is not a price-sensitivity artefact; every regional-price complaint is outside the group; high-spend reviewers are more likely to call the price too high (8.46% vs 6.13%, driven by Germany and China) while also paying more; one-time asks 2.85% vs 1.86%; review prompt 3.16% vs 1.10%; simplicity 21.34% vs 16.98%; colour 12.09% vs 8.21%; the group is 57.5% US and Japan (17), Korea (22), France (48) support no standalone conclusion

- **Where:** §6.12 High-spend market group (verbatim table) — US, JP, CN, GB, DE, KR, CA, AU, FR = 1,265 (58.08%), mean 4.32 vs 4.34; payers 5.61% vs 2.85% (2×); cap 7.91% vs 8.76% (same — not a price-sensitivity artefact); price too high 8.46% vs 6.13% (driven by Germany and China); one-time 2.85% vs 1.86%; regional pricing 0 vs 8 (all outside); review prompt 3.16% vs 1.10%; simplicity 21.34% vs 16.98%; colour 12.09% vs 8.21%; 57.5% US; JP, KR, FR contribute 87
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Metric | High-spend group | Rest of world ; Storefronts present | 9 of 9 | 84 ; Reviews | 1,265 (58.08%) | 913 (41.92%) ; Mean rating | 4.32 | 4.34 ; Payers | 71 (5.61%) | 26 (2.85%) ; mf_free_cap_3habits | 100 (7.91%) | 80 (8.76%) ; mf_price_too_high | 107 (8.46%) | 56 (6.13%) ; mf_want_one_time_purchase | 36 (2.85%) | 17 (1.86%) ; mf_regional_pricing | 0 (0.00%) | 8 (0.88%) ; ux_review_prompt_nag | 40 (3.16%) | 10 (1.10%) ; cp_simplicity | 270 (21.34%) | 155 (16.98%) ; cp_visual_colour_system | 153 (12.09%) | 75 (8.21%)
- **Direction for us:** research · **Report confidence:** group (external definition) · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R46-124 — The cap complaint is a global constant of this product: the ten ≥ 50-review storefronts (1,511, 69.38%) vs the rest (667) — cap 8.27% vs 8.25%, identical; mean 4.32 vs 4.37; payers 4.83% vs 3.60%; price 7.88% vs 6.60%; simplicity 21.05% vs 16.04% — the groups differ on almost nothing else (review-volume proxy only, not downloads)

- **Where:** §6.13 High-review-volume market group (verbatim table) — the ten ≥ 50 storefronts 1,511 (69.38%) vs 667: mean 4.32 vs 4.37; payers 4.83% vs 3.60%; cap 8.27% vs 8.25% — identical, a global constant of this product; price 7.88% vs 6.60%; simplicity 21.05% vs 16.04%
- **This app does:** 3-habit cap
- **User reaction:** complaint
- **Magnitude:** Metric | High-volume group | Rest ; Reviews | 1,511 (69.38%) | 667 (30.62%) ; Mean rating | 4.32 | 4.37 ; Payers | 73 (4.83%) | 24 (3.60%) ; mf_free_cap_3habits | 125 (8.27%) | 55 (8.25%) ; mf_price_too_high | 119 (7.88%) | 44 (6.60%) ; cp_simplicity | 318 (21.05%) | 107 (16.04%)
- **Direction for us:** product-rule · **Report confidence:** group · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R46-125 — Non-English markets like the product as much and ask twice as often to own it outright: English-primary storefronts (1,046, 48.03%, mean 4.37) vs all others (1,132, 51.97%, 4.30) — simplicity praise 23.71% vs 15.64%; colour praise 13.58% vs 7.60%; review-prompt complaints 3.63% vs 1.06% (3.4×); one-time purchase requests 1.53% vs 3.27% (others 2.1×); localisation gap and the offline bug only outside English markets; payers 5.64% vs 3.36% (1.7×) — the market case for offering the lifetime tier at a lower regional price rather than lowering the subscription

- **Where:** §6.14 English-primary vs other storefronts (verbatim table) — 1,046 (48.03%, 4.37) vs 1,132 (51.97%, 4.30): simplicity 23.71% vs 15.64%; colour 13.58% vs 7.60%; review prompt 3.63% vs 1.06% (3.4×); one-time purchase 1.53% vs 3.27% (others 2.1×); localisation gap 0 vs 1.15%; offline bug 0 vs 1.50%; payers 5.64% vs 3.36% (1.7×) — English reviewers articulate the design and pay; non-English like it as much by rating but ask twice as often to own it outright — the market case for a lower regional lifetime price rather than a lower subscription
- **This app does:** subscription-first; lifetime $99.99
- **User reaction:** blocked-conversion
- **Magnitude:** Theme | English-primary | Other storefronts | Direction ; cp_simplicity | 23.71% | 15.64% | English praises simplicity 1.5× more ; cp_visual_colour_system | 13.58% | 7.60% | English praises the colour grid 1.8× more ; ux_review_prompt_nag | 3.63% | 1.06% | English complains about the prompt 3.4× more ; mf_want_one_time_purchase | 1.53% | 3.27% | Others ask for a one-time purchase 2.1× more ; ux_localization_gap | 0.00% | 1.15% | Others only ; rel_offline_mode_bug | 0.00% | 1.50% | Others only (China) ; Payers | 5.64% | 3.36% | English pays 1.7× more
- **Direction for us:** build-paid · **Report confidence:** group · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C062 Weight English-speaking rich markets; volume ≠ revenue

### R46-127 — Sub-50 observations (limited evidence): France 48 (mean 4.60; 4 payers, 8.3% — the highest payer density of any storefront with n ≥ 40; 'Je l'utilise tous les jours et je vais payer les 30 euros annuel'); Mexico 48 (4.69, the highest of any storefront n > 20); Australia 47 (4.45; Learn content 17.0%, 3.5× global); Italy 46 (4.11; price 15.2%; holds the most-voted review — a deleted habit's notification still firing, 25 votes — and the only VoiceOver regression, iOS 15); Japan 17 (4.71; three praise Mac / Watch / iPhone integration); Taiwan 16 (price and one-time requests); Saudi Arabia + Kuwait 12 (the Arabic UI praised from 2020; the gap is translated Learn content and price, 109 SAR a year); Kazakhstan 7 (the sharpest 'stagnant product' argument and a hostile-reply report, Jan 2026)

- **Where:** §6.16 Sub-50 storefronts (verbatim table) — France 48 (4.60; 4 payers, 8.3%, the highest density n ≥ 40; 'I use it every day and I'm going to pay the 30 euros annual'); Mexico 48 (4.69, the highest n > 20; ease and design); Australia 47 (4.45; Learn content 17.0%, 3.5×); Italy 46 (4.11; price 15.2%; the most-voted review — a deleted habit's notification still firing, 25 votes; the only VoiceOver regression, iOS 15); Japan 17 (4.71; Mac / Watch / iPhone integration); Taiwan 16 (price and one-time requests); Saudi + Kuwait 12 (Arabic UI praised from 2020; the gap is translated Learn content and price, 109 SAR/yr); Kazakhstan 7 (the sharpest 'stagnant product' argument and a hostile-reply report)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | Observation | Warning ; France | 48 | Mean 4.60; 4 confirmed payers (8.3%, the highest payer density of any storefront with n≥40). *"Je l'utilise tous les jours et je vais payer les 30 euros annuel"* (5352678797) | n=48, just below threshold ; Mexico | 48 | Mean 4.69, the highest of any storefront with n>20; dominated by ease-of-use and design praise | n=48 ; Australia | 47 | Mean 4.45; Learn content is 8 of 47 (17.0%, 3.5× global) | n=47 ; Italy | 46 | Mean 4.11; price 7 of 46 (15.2%); holds the most-voted review (6181587486, 25 votes, a deleted habit's notification still firing) and the only VoiceOver regression (7846657472, iOS 15) | n=46 ; Japan | 17 | Mean 4.71; three of seventeen praise Mac/Watch/iPhone integration (5397749343, 13868477388) | n=17 ; Taiwan | 16 | Price and one-time-purchase requests (7271634175, 7783358394, 11429249513, 12732679231) | n=16 ; Saudi Arabia + Kuwait | 12 combined | The Arabic UI is praised from 2020 (6775992927, 6862775837); the gap is translated Learn content (11171579515) and price (6775992927, 109 SAR/year) | n=12 across 2 storefronts ; Kazakhstan | 7 | 13689294667 (2★, Jan 2026) — the corpus's sharpest "stagnant product" argument, and a hostile-reply report | n=7
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `5352678797`, `6181587486`, `7846657472`, `5397749343`, `13868477388`, `7271634175`, `7783358394`, `11429249513`, `12732679231`, `6775992927`, `6862775837`, `11171579515`, `13689294667`
- **Canonical:** C027 Localise early — it unlocks revenue; C092 Regional pricing; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R46-152 — Localise the Learn content, the 7-day e-mail course and the videos — Spanish first; the UI is in 15 languages, the content early users praised most is not; Spain is the developer's home market

- **Where:** §8.2 #13
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** localisation gap 13
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `8985834449`, `9992608962`, `11171579515`, `6821741061`, `6821437095`
- **Canonical:** C027 Localise early — it unlocks revenue; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R46-160 — Experiment: regional lifetime pricing for Turkey, Brazil, Latin America, Vietnam, China, Saudi Arabia — non-English storefronts ask for one-time purchase 2.1× more and Russia, apparently on a lower tier, calls the price fair

- **Where:** §8.4 E2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** regional 8 (all non-US)
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C092 Regional pricing

## Dated events and trends

### R46-020 — A prompt-driven review base dilutes the early-adopter voice: four themes tied to the 2018–2020 users all fall — Learn-tab articles, videos and the 7-day e-mail course (107, 4.91%, mean 4.82) 11.02% → 5.24% → 3.05% → 3.30%; web-app / Chrome-extension users 2.15% → 0.23%; praise for responsive support 4.30% → 1.82%; 'supporting an indie developer' as a reason to pay 12 of 13 before July 2023 — the early user was desktop-heavy, newsletter-reading and developer-contacting, the post-2023 user is mobile, widget-first and prompt-driven; the content library is under-used rather than disliked and English-only (13 reviews, incl. a Spanish reviewer surprised because 'el desarrollador es español')

- **Where:** Executive summary #13 — the early-adopter community is being diluted: Learn-tab content and the 7-day email course 107 (4.91%, 4.82) fall 11.02% → 5.24% → 3.05% → 3.30%; web / Chrome-extension users 2.15% → 0.23%; support praise 4.30% → 1.82%; 'support an indie developer' as a reason to pay 12 of 13 before Jul 2023; the early user was desktop-heavy, newsletter-reading, developer-contacting; the post-2023 user is mobile, widget-first, prompt-driven; the content library is under-used and English-only (13 reviews; 'el desarrollador es español')
- **This app does:** Learn content, e-mail course, web app
- **User reaction:** mixed
- **Magnitude:** learn 107 (4.91%), 11.02 → 3.30%; web 2.15 → 0.23%; indie 12/13 pre-Jul 2023; English-only 13
- **Direction for us:** research · **Report confidence:** medium confidence · **Generalisable:** yes
- **Review IDs:** `8985834449`, `4651655959`, `5355179743`
- **Canonical:** C044 Mac / desktop / web app; C061 Goodwill conversion — a generous free tier and 'support the devs'; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R46-022 — Flat then stepped, not a decline: yearly means 2018 4.67 (12) · 2019 3.87 (86) · 2020 4.08 (274) · 2021 4.09 (177) · 2022 3.86 (140) · 2023 4.42 (609, 28.0% of the corpus) · 2024 4.46 (444) · 2025 4.54 (290) · 2026 4.61 (146); 3.86–4.09 every year 2019–2022 then a step to 4.42 coinciding with the May 2023 rating-prompt burst and a steady climb — partly a composition effect (more prompted, shorter, happier reviews), not purely product improvement; the first review (Aug 2018) could not sign up; 2018 reviewers describe a web app preceding the iPhone release

- **Where:** §1.4 Date range and shape (verbatim year table) — first review 9 Aug 2018 1★ 'Unable to log in or sign up… submit button is inactive'; last 4 Sep 2026 (MN, 3★ 'It's good'); 2018 12 (4.67) · 2019 86 (3.87) · 2020 274 (4.08) · 2021 177 (4.09) · 2022 140 (3.86) · 2023 609 (4.42, 28.0%) · 2024 444 (4.46) · 2025 290 (4.54) · 2026 146 (4.61); flat-then-stepped, the step coinciding with the May 2023 prompt burst — partly a composition effect
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | % of corpus | Mean ★ | 5★ | 4★ | 3★ | 2★ | 1★ ; 2018 | 12 | 0.6% | 4.67 | 11 | 0 | 0 | 0 | 1 ; 2019 | 86 | 3.9% | 3.87 | 48 | 10 | 11 | 3 | 14 ; 2020 | 274 | 12.6% | 4.08 | 160 | 43 | 28 | 18 | 25 ; 2021 | 177 | 8.1% | 4.09 | 113 | 17 | 16 | 12 | 19 ; 2022 | 140 | 6.4% | 3.86 | 73 | 22 | 15 | 12 | 18 ; 2023 | 609 | 28.0% | 4.42 | 432 | 86 | 42 | 13 | 36 ; 2024 | 444 | 20.4% | 4.46 | 349 | 32 | 15 | 16 | 32 ; 2025 | 290 | 13.3% | 4.54 | 230 | 27 | 11 | 5 | 17 ; 2026 | 146 | 6.7% | 4.61 | 116 | 16 | 5 | 5 | 4
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `3038410981`, `14509933384`, `3197455014`, `3200513030`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R46-032 — Making the account optional ended the complaint: an account was required 2018–2022 (8 complaints, the corpus's first review 'Unable to log in or sign up… the submit button is inactive', the last Oct 2022) and optional by 2024 ('Zugang auch ohne Registrierung'; 'an account isn't required') — no complaint since

- **Where:** §2.2 Account required 2018–2022 (8 complaints, last Oct 2022; the first review could not sign up), optional by 2024 ('Zugang auch ohne Registrierung'; 'an account isn't required') — the complaint stopped when the requirement did
- **This app does:** account required → optional
- **User reaction:** praise
- **Magnitude:** 8 complaints, 0 after Oct 2022
- **Direction for us:** product-rule · **Report confidence:** dated · **Generalisable:** yes
- **Review IDs:** `3038410981`, `9193209910`, `11481910041`, `13247499575`
- **Canonical:** C035 Account system from day one; C209 No sign-up wall before first use

### R46-074 — A cap complaint whose count never fell while its rate was diluted by prompted volume: by year 2019 10/86 (11.6%) → 2020 38/274 (13.9%) → 2021 28/177 (15.8%) → 2022 26/140 (18.6%) → 2023 32/609 (5.3%) → 2024 22/444 (5.0%) → 2025 18/290 (6.2%) → 2026 6/146 (4.1%); the share of each year's one-stars carrying the cap 29% → 52% → 58% → 44% → 28% → 31% → 65% → 25%; the listing still states the cap

- **Where:** §3.4.1 The 3-habit free tier by year (verbatim table) — 2019 10/86 (11.6%) → 2020 38/274 (13.9%) → 2021 28/177 (15.8%) → 2022 26/140 (18.6%) → 2023 32/609 (5.3%) → 2024 22/444 (5.0%) → 2025 18/290 (6.2%) → 2026 6/146 (4.1%); share of that year's 1★ carrying the cap 29% → 52% → 58% → 44% → 28% → 31% → 65% → 25%; the rate fell in 2023, the count did not
- **This app does:** 3-habit cap unchanged
- **User reaction:** complaint
- **Magnitude:** Year | Reviews | Cap reviews | Cap rate | 1★ reviews that year | …of which carry the cap ; 2019 | 86 | 10 | 11.6% | 14 | 4 (29%) ; 2020 | 274 | 38 | 13.9% | 25 | 13 (52%) ; 2021 | 177 | 28 | 15.8% | 19 | 11 (58%) ; 2022 | 140 | 26 | 18.6% | 18 | 8 (44%) ; 2023 | 609 | 32 | 5.3% | 36 | 10 (28%) ; 2024 | 444 | 22 | 5.0% | 32 | 10 (31%) ; 2025 | 290 | 18 | 6.2% | 17 | 11 (65%) ; 2026 (to 4 Sep) | 146 | 6 | 4.1% | 4 | 1 (25%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C054 Never run incentivised / review-for-premium campaigns

### R46-083 — Two early outage clusters that recovered: China 'offline mode while online' — nine reviews in the nine days 20–28 Sep 2019 ('为什么总说我连不上网？明明连着的呀'; '根本用不了') and a second wave Mar–Apr 2020 on iPad 1.9.19, 16 of 17 Chinese, only two later instances (2023); 'won't open after the update' — six reviews in three days 16–18 Sep 2020 from five storefronts ('I can't even open the app anymore ever since I updated it!!'; '疯狂闪退！'), coinciding with the iOS 14 release window (OS or app cause unresolvable); a smaller June 2020 freeze cluster — none recurred at scale

- **Where:** §3.4.3 Early era outages — China 'offline mode' (Sep 2019 – Apr 2020): 14 of 17 in 2019–20, 16 of 17 Chinese, nine in 20–28 Sep 2019 ('Why does it keep saying I'm offline? I'm clearly connected'; 'Completely unusable'), a second wave Mar–Apr 2020 (iPad 1.9.19); 'won't open after the update' 16–18 Sep 2020 — six reviews in three days from five storefronts, coinciding with the iOS 14 window; a June 2020 freeze cluster — all resolved
- **This app does:** backend unreachable from CN; iOS 14 update
- **User reaction:** 1★-burst
- **Magnitude:** offline 14 in 2019–20; won't-open 6 in 3 days
- **Direction for us:** must-never-break · **Report confidence:** dated, resolved · **Generalisable:** yes
- **Review IDs:** `4808959996`, `4810179733`, `4812186865`, `4834666537`, `4835179226`, `4839785600`, `4842624645`, `4848868262`, `5612974809`, `5624585393`, `5699845268`, `5766390109`, `5770490572`, `9917968507`, `10451430334`, `9744876901`, `6436513011`, `6436882098`, `6437368606`, `6437984231`, `6438265463`, `6440260322`, `6045093199`, `6054354621`, `6064279767`, `6057607224`
- **Canonical:** C031 Crashes / launch failures; C175 Updates must not break function or wipe progress; C188 The app must open offline — never block launch on a network call

### R46-098 — The one-star band kept its character for eight years and grew a new tail: monetisation friction carries 70% of 1–2★ in 2018–20, 73% in 2021–Apr 2023, 51% in May–Dec 2023, 63% in 2024–26; the share carrying a data-integrity theme rises 5% → 8% → 11% → 15% and UX friction (mostly the rating prompt) 7% → 13% → 31% → 19% — a 2026 one-star review is still most likely about the paywall, but twice as likely as in 2020 to be about lost data or the prompt; 1★ composition: cap 68 (41.0%), price 45 (27.1%), anti-subscription 16, trial too limited 15, misleading free 14, value scepticism 13, cheaper competitor 12, one-time 11, review prompt 10, data loss 10, crash 8, mismatch 8

- **Where:** §4.5 One star (verbatim table) — cap 41.0%, price 27.1%, anti-subscription 9.6%, trial too limited 9.0%, misleading free 8.4%, value scepticism 7.8%, cheaper competitor 7.2%, one-time 6.6%, review prompt / data loss 6.0% each, crash / mismatch 4.8% each; unlike report 43 the band did not change character — friction 70% (2018–20), 73% (2021–Apr 2023), 51% (May–Dec 2023), 63% (2024–26); the tail changed: data integrity 5% → 8% → 11% → 15%, UX friction (the prompt) 7% → 13% → 31% → 19% — a 2026 1★ is still most likely the paywall but twice as likely as 2020 to be lost data or the prompt
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of 1★ ; mf_free_cap_3habits | 68 | 41.0% ; mf_price_too_high | 45 | 27.1% ; mf_anti_subscription | 16 | 9.6% ; mf_trial_too_limited | 15 | 9.0% ; mf_misleading_free_claim | 14 | 8.4% ; neg_value_scepticism | 13 | 7.8% ; mf_competitor_cheaper | 12 | 7.2% ; mf_want_one_time_purchase | 11 | 6.6% ; ux_review_prompt_nag / rel_data_loss | 10 each | 6.0% ; rel_crash_freeze / meta_rating_text_mismatch | 8 each | 4.8%
- **Direction for us:** product-rule · **Report confidence:** segment · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C034 Data must never be lost on update, reinstall or phone change; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R46-130 — Prompted praise can halve a complaint's share without changing its count: the paywall union runs 13.44% (E1) → 16.96% (E2) → 5.14% (E3) → 6.70% (E4), halves 12.30% → 6.43%; the cap 12.90% → 16.21% → 4.00% → 5.23%; by year the cap count is 10, 38, 28, 26, 32, 22, 18, 6 and the rate 11.6% → 13.9% → 15.8% → 18.6% (2022 peak) → 5.3% → 5.0% → 6.2% → 4.1% — the fall in 2023 is the year total review volume quadrupled (140 → 609) under the rating prompt; the product fact (three free habits) is unchanged from the first complaint to the listing — nothing was fixed, the complaint is being out-shouted

- **Where:** §7.2 Trend 1 — paywall friction: the share halved, the count did not (verbatim tables): paywall union 13.44% → 16.96% → 5.14% → 6.70% (halves 12.30% → 6.43%); cap 12.90% → 16.21% → 4.00% → 5.23%; by year count 10, 38, 28, 26, 32, 22, 18, 6 and rate 11.6 → 13.9 → 15.8 → 18.6 (2022) → 5.3 → 5.0 → 6.2 → 4.1%; the cap peaked as a share in 2022 and fell in 2023 when volume quadrupled (140 → 609); 'nothing was fixed. The complaint is being out-shouted by prompted praise'
- **This app does:** 3-habit cap + rating prompt
- **User reaction:** complaint
- **Magnitude:** Cut | E1 | E2 | E3 | E4 ; Paywall union (cap ∪ trial too limited ∪ misleading ∪ more-free ask) | 13.44% | 16.96% | 5.14% | 6.70% ; mf_free_cap_3habits | 12.90% | 16.21% | 4.00% | 5.23% ; Halves (paywall union) | H1 12.30% | — | — | H2 6.43%
- **Direction for us:** product-rule · **Report confidence:** persistent, high confidence · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C054 Never run incentivised / review-for-premium campaigns

### R46-131 — A lifetime tier replaces 'sell it once' with 'sell it once for less': one-time-purchase requests fell 6.99% (E1) → 4.74% → 0.38% → 0.68% (halves 4.22% → 0.64%) after the first lifetime purchase (May 2021), while 'lifetime price too high' rose 0.00% → 0.75% → 1.52% → 1.82% (0.46% → 2.02%) from its first appearance in July 2022 ('唯一让我犹豫的就是买断的价格偏贵了'), and lifetime buyers grew 0.00% → 1.14%; by 2024–26 lifetime-price objections outnumber one-time requests 16 to 6 — every cut agrees

- **Where:** §7.3 Trend 2 — the one-time ask was answered; its price became the objection (verbatim table): one-time request 6.99% → 4.74% → 0.38% → 0.68% (4.22% → 0.64%); lifetime price too high 0.00% → 0.75% → 1.52% → 1.82% (0.46% → 2.02%); paid lifetime 0.00% → 0.50% → 0.76% → 1.14%; first lifetime purchase May 2021; first lifetime-price objection Jul 2022 ('the only thing making me hesitate is that the buyout price is on the high side', CN); by 2024–26 lifetime-price objections outnumber one-time requests 16 to 6
- **This app does:** lifetime $99.99 from 2021
- **User reaction:** mixed
- **Magnitude:** Theme | E1 | E2 | E3 | E4 | H1 → H2 ; mf_want_one_time_purchase | 6.99% | 4.74% | 0.38% | 0.68% | 4.22% → 0.64% ; mf_lifetime_price_too_high | 0.00% | 0.75% | 1.52% | 1.82% | 0.46% → 2.02% ; mp_paid_lifetime | 0.00% | 0.50% | 0.76% | 1.14% | 0.46% → 1.01%
- **Direction for us:** build-paid · **Report confidence:** replaced, high confidence · **Generalisable:** yes
- **Review IDs:** `7299054449`, `8838040946`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R46-132 — Price objections spike with each price change and are fading: by count 9 (2019), 36 (2020 — following the January 2020 rise from $12 to $30 a year), 22 (2021), 17 (2022), 41 (2023 — the $7.49 / $29.99 / $99.99 structure first appears in reviews in May 2023, inflated by burst volume), 25 (2024), 9 (2025), 4 (2026); five reviews record the ladder in their own words — 'too expensive compared to it's past rate' (2021); 'it went from $12/year to $3/month to $5/month and now it's almost $8/month and $30/year' (2023); 'Leider inzwischen viel zu teuer'; 'the monthly (not annual) price has gone up to $7 and some change' (2025); the 2025–2026 fall is real in both count and rate

- **Where:** §7.4 Trend 3 — price objections tracked the price structure: by count 9 (2019), 36 (2020, after the Jan 2020 rise $12 → $30/yr), 22, 17, 41 (2023, the $7.49 / $29.99 / $99.99 structure first appears May 2023, plus burst volume), 25, 9, 4; price_increase 5 records the ladder ('it went from $12/year to $3/month to $5/month and now it's almost $8/month and $30/year'; 'the monthly price has gone up to $7 and some change', 2025); the 2025–26 fall is real in count and rate
- **This app does:** $12/yr → $30/yr (2020) → $7.49/mo (2023)
- **User reaction:** complaint
- **Magnitude:** 36 (2020); 41 (2023); 4 (2026)
- **Direction for us:** research · **Report confidence:** persistent, medium · **Generalisable:** yes
- **Review IDs:** `5471831095`, `7751115272`, `10453985829`, `10540999641`, `12403355389`, `9882563220`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R46-133 — The product became more stable to open and less trustworthy to rely on — the worse direction for an app whose value is an unbroken record: the reliability family fell 12.63% (E1) → 10.22% → 4.38% → 4.55% as the outage defects vanished (offline-mode bug 3.76% → 0.00%; crash / freeze 3.76% → 0.34%), while data loss rose 0.81% → 1.00% → 0.76% → 1.48% (halves 0.73% → 1.47%) and the data-integrity union 1.08% → 3.99% → 1.90% → 2.95% (2.11% → 3.03%) despite prompt dilution — so the true rise is larger; data loss by count 0, 3, 2, 1, 5, 5, 4, 4 (2019–2026), and 2026's four in 146 reviews (2.7%) is the highest annual rate in the corpus

- **Where:** §7.5 Trend 4 — outages resolved, data integrity worse (verbatim table): reliability 12.63% → 10.22% → 4.38% → 4.55% (8.91% → 4.96%); offline-mode bug 3.76% → 0.00%; crash 3.76% → 0.34%; data loss 0.81% → 1.00% → 0.76% → 1.48% (0.73% → 1.47%); data-integrity union 1.08% → 3.99% → 1.90% → 2.95% (2.11% → 3.03%) despite dilution — true rise larger; data loss by count 0, 3, 2, 1, 5, 5, 4, 4; 2026's four in 146 (2.7%) is the highest annual rate — more stable to open, less trustworthy to rely on
- **This app does:** silent history corruption
- **User reaction:** churn
- **Magnitude:** Theme | E1 | E2 | E3 | E4 | H1 → H2 ; Reliability family | 12.63% | 10.22% | 4.38% | 4.55% | 8.91% → 4.96% ; rel_offline_mode_bug | 3.76% | 0.25% | 0.38% | 0.00% | 1.47% → 0.09% ; rel_crash_freeze | 3.76% | 1.50% | 0.38% | 0.34% | 1.93% → 0.37% ; rel_data_loss | 0.81% | 1.00% | 0.76% | 1.48% | 0.73% → 1.47% ; Data-integrity union | 1.08% | 3.99% | 1.90% | 2.95% | 2.11% → 3.03%
- **Direction for us:** must-never-break · **Report confidence:** worsening in severity, medium-high · **Generalisable:** yes
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C040 Widgets must not go blank, stale or disagree with the app

### R46-134 — A rating prompt that is reduced but not bounded keeps producing complaints and contentless reviews: prompt complaints 0.00% (E1) → 0.25% → 5.71% (E3) → 2.16% (E4), halves 2.20% → 2.39%; low-information reviews 3.76% → 6.23% → 16.00% → 9.32%; 'writing only to make it stop' 0.00% → 0.00% → 1.52% → 1.02%; the first complaint is January 2022, the wave arrives with the May 2023 burst, and it has not decayed to zero — 8 complaints in 2024, 7 in 2025, 4 in the first eight months of 2026

- **Where:** §7.6 Trend 5 — the rating prompt (verbatim table): nag 0.00% → 0.25% → 5.71% → 2.16% (2.20% → 2.39%); low-information 3.76% → 6.23% → 16.00% → 9.32%; solicited 0.00% → 0.00% → 1.52% → 1.02%; first Jan 2022, then the May 2023 burst; not decayed to zero — 8 complaints in 2024, 7 in 2025, 4 in eight months of 2026; frequency reduced after mid-2023 but not bounded — a small steady stream of complaints and a large stream of low-information reviews
- **This app does:** rating prompt
- **User reaction:** complaint
- **Magnitude:** Theme | E1 | E2 | E3 | E4 | H1 → H2 ; ux_review_prompt_nag | 0.00% | 0.25% | 5.71% | 2.16% | 2.20% → 2.39% ; meta_low_information | 3.76% | 6.23% | 16.00% | 9.32% | 9.09% → 9.73% ; meta_solicited | 0.00% | 0.00% | 1.52% | 1.02% | 0.46% → 1.10%
- **Direction for us:** dont · **Report confidence:** active, high confidence · **Generalisable:** yes
- **Review IDs:** `8258958104`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R46-136 — The early web-first, content-reading, developer-contacting community was replaced by a mobile, widget-first audience: Learn content 11.02% → 5.24% → 3.05% → 3.30% (halves 6.61% → 3.21%); web / extension users 2.15% → 2.24% → 0.76% → 0.23% (counts 8, 9, 4, 2); responsive-support praise 4.30% → 3.49% → 1.33% → 1.82%; supporting the indie developer 12 of 13 in the first half; 'free tier sufficient' 5.11% → 2.84% — the counts fall too, so this is not only prompt dilution; the Learn library is still there and still praised when found

- **Where:** §7.8 Trend 7 — the early-adopter voice faded: learn content 11.02% → 5.24% → 3.05% → 3.30%; web / extension users 2.15% → 2.24% → 0.76% → 0.23% (counts 8, 9, 4, 2); support praise 4.30% → 3.49% → 1.33% → 1.82%; support-indie 12 of 13 in H1; free tier sufficient 5.11% → 2.84%; counts fall too, so not only dilution — a web-first, content-reading, developer-contacting community replaced by a mobile, widget-first audience; the Learn library is still praised when found
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** learn 11.02 → 3.30%; web 2.15 → 0.23%
- **Direction for us:** research · **Report confidence:** medium confidence · **Generalisable:** yes
- **Canonical:** C044 Mac / desktop / web app; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R46-137 — Neurodivergent use grew in every cut: 0.54% (E1) → 0.75% → 1.90% → 1.70% (halves 1.10% → 1.65%; counts 2, 3, 10, 15); the first ADHD mention is October 2019 (n = 30, medium confidence)

- **Where:** §7.9 Trend 8 — neurodivergent use grew: 0.54% → 0.75% → 1.90% → 1.70% (halves 1.10% → 1.65%; counts 2, 3, 10, 15); first ADHD mention Oct 2019
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 0.54 → 1.70%; counts 2 → 15
- **Direction for us:** do · **Report confidence:** emerging, medium · **Generalisable:** yes
- **Review IDs:** `4997111034`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R46-138 — Friction with the developer's public voice is recent and low-rated: hostile replies 0, 1, 0, 5 across the four eras; review pressure 2 (May 2023, Sep 2024); unresponsive 0, 3, 0, 4 — n = 15 across three themes, all but two of them 1★ or 2★ (low-medium confidence)

- **Where:** §7.10 Trend 9 — friction with the developer's public voice appeared late: hostile replies 0, 1, 0, 5 across eras; review pressure 2 (May 2023, Sep 2024); unresponsive 0, 3, 0, 4; all but two of the fifteen are 1★ or 2★
- **This app does:** public replies
- **User reaction:** complaint
- **Magnitude:** hostile 0/1/0/5; unresponsive 0/3/0/4
- **Direction for us:** dont · **Report confidence:** worsening, low-medium · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C189 Public review replies answer the specific complaint — never canned, never argue price, never press a reviewer to change the rating

### R46-139 — What held for eight years: the free tier at 3 habits (Jan 2019 → the listing in Sep 2026); simplicity the top theme in every era and rising (16.40% → 21.59%); the colour grid praised at a near-constant rate (9.68% → 10.22% → 11.62% → 10.23%); behaviour change reported at a near-constant rate (11.56% → 13.97% → 14.10% → 12.50%, mean 4.93); more colours requested every era since 2020 (1.61% → 3.74% → 3.43% → 2.27%); flexible scheduling requested every era (1.08% → 2.00% → 1.71% → 1.48%; Sep 2019 → Jul 2026); the skip-symbol confusion seven years old (Sep 2019 → Feb 2026)

- **Where:** §7.11 What did not change — the free tier 3 habits (Jan 2019 → the listing 11 Sep 2026); simplicity top every era and rising 16.40 → 21.59%; the colour grid near-constant 9.68 → 10.22 → 11.62 → 10.23%; behaviour change near-constant 11.56 → 13.97 → 14.10 → 12.50% (4.93); more colours every era since 2020 (1.61 → 3.74 → 3.43 → 2.27%); flexible scheduling every era (1.08 → 2.00 → 1.71 → 1.48%; Sep 2019 → Jul 2026); the skip-symbol confusion seven years old (Sep 2019 → Feb 2026)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** eight years
- **Direction for us:** product-rule · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `4841212766`, `14316211160`, `4850070969`, `13762762742`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C007 Generous fixed habit cap (or unlimited) — never change it; C012 Week / month / year grid views; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency; C261 A colour palette users can extend — more defaults, a hex picker, softer sets — because colour is the reward surface

## Positioning

### R46-001 — everyday – Habit Tracker (App Store ID 1394150432, 'Daily Routine Checklist') by Everyday Growth S.L. (bundle app.everyday), an independent developer in Barcelona reviewers call 'Joan' — free download with a 3-habit free tier, a 7-day trial, auto-renewing subscriptions and a lifetime unlock; listing (US, 11 Sep 2026) ED Premium Monthly $7.49, Everyday Premium Year $29.99, ED Full Year Access $29.99, Everyday Premium Lifetime $99.99; price ladder $12/year (2019) → $4.99/mo or $30/yr (Jan 2020) → $7.49 / $29.99 / $99.99 lifetime (2023 on); the 3-habit cap never changed across eight years; a web app and Chrome new-tab extension preceded the iPhone app; listing 4.7★ from 4.5K US ratings; version 3.9.9; 15 languages; iPhone, iPad, Mac, Watch, Vision

- **Where:** header lines 1-8; How to read this (developer 'Joan', Barcelona indie)
- **This app does:** developer Everyday Growth S.L.; bundle app.everyday; extracted 8 Sep 2026; analysed 11 Sep 2026; store rank 46
- **User reaction:** praise
- **Magnitude:** 2,178 written reviews · 93 storefronts · 9 Aug 2018 → 4 Sep 2026; mean 4.332; 5:1532 / 4:253 / 3:143 / 2:84 / 1:166
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C003 Lead with a one-time lifetime purchase; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R46-043 — Replaces paper / bullet journal 37 (1.70%, mean 4.81)

- **Where:** §3.1 master table #27 cp_replaces_paper
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 37 (1.70%), 4.81
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R46-049 — Atomic Habits / James Clear framing praised 21 (0.96%, mean 4.90)

- **Where:** §3.1 master table #44 cp_atomic_habits
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 21 (0.96%), 4.90
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C070 Use the language users use: Atomic Habits, 75 Hard

### R46-071 — Wins on design plus simplicity against every named paid rival and loses on price to free or cheaper ones: 198 reviews (9.09%, mean 4.92) chose it after trying others — 'nearly every habit tracker in the App Store all the way back to Chains.cc'; 'Fabulous and Done. Those were either overly and unnecessarily complicated (and expensive) or too simple'; 'This is so much better than Streaks!!!! It's not even close'; 'Basically it's habitica but without the stupid game mechanics'; 'I tried EVERY habit app and THIS is the best'; named alternatives — Streaks, Productive, Fabulous, Done, Habitica, HabitShare, Habit, Finch, Momentum, Way of Life, mem:o, TickTick, (Not Boring) Habits, Awesome Habits, Habitty, Onrise, 习惯口袋, Apple Reminders, Excel / Google Sheets, paper

- **Where:** §3.3.5 Competitive displacement 198 (9.09%, mean 4.92) — 'nearly every habit tracker in the App Store all the way back to Chains.cc'; 'Fabulous and Done… overly complicated (and expensive) or too simple'; 'so much better than Streaks!!!! It's not even close'; 'habitica but without the stupid game mechanics'; 'I tried EVERY habit app and THIS is the best'; named: Streaks, Productive, Fabulous, Done, Habitica, HabitShare, Habit, Finch, Momentum, Way of Life, mem:o, TickTick, (Not Boring) Habits, Awesome Habits, Habitty, Onrise, 习惯口袋, Apple Reminders, spreadsheets, paper — wins on design + simplicity, loses on price to free / cheaper alternatives
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 198 (9.09%), 4.92
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `5352400235`, `8871861613`, `12001038041`, `9978469609`, `10949381982`
- **Canonical:** C005 Know which competitors buyers compare against

### R46-111 — The product has no design competitor in this corpus, only price competitors: chosen for design plus simplicity (198), left for price — a spreadsheet, a notebook or Apple Reminders, a cheaper lifetime tracker, or a bundle ('Done app gave me SIX different apps full feature for only $25 for the year'; '(Not Boring) Habits… costs only $15 per year with the package of the company's other 3 apps'); no reviewer in 2,178 leaves because a rival's design or feature set is better; one returned after trying a free alternative — 'within two weeks switched back to Everyday. Yes, it costs a bit of money. However, I realized that a tool that actually motivates me to stick with my habits is worth it'

- **Where:** §5.7 Competitive position — chosen for design plus simplicity, left for price: a spreadsheet, a notebook or Apple Reminders; a cheaper lifetime tracker; a bundle ('Done app gave me SIX different apps full feature for only $25 for the year'; '(Not Boring) Habits… $15 per year with the package of the company's other 3 apps'); no reviewer in 2,178 leaves because a rival's design or features are better; one returned after a free alternative ('within two weeks switched back… a tool that actually motivates me to stick with my habits is worth it') — no design competitor, only price competitors
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 198 chose; price-only departures; 1 return
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `6154641193`, `6258595511`, `8804092407`, `10931667412`, `11040174280`, `11488397934`, `6998451648`, `9882563220`, `7398777101`
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R46-172 — Two self-inflicted patterns with measured costs: (1) a 3-habit cap held for eight years under a 'free forever' listing — 180 cap complaints (mean 2.43), 41.0% of all one-stars, 27 'misleading free' reviews at mean 1.85 (the angriest cluster), while the product's own widget holds four rows; (2) an unbounded in-app rating prompt from May 2023 that tripled review volume with contentless 5★ (297 in 44 days), generated 50 complaints including 10 one-stars and 17 reviews written only to make it stop, and diluted every later negative-theme rate so that 'nothing was fixed; the complaint is being out-shouted by prompted praise'

- **Where:** Exec #1 / #7 / §8.1 — the compounding anti-pattern: a 3-habit cap that never moved under a 'free forever' listing, plus an unbounded rating prompt that tripled review volume with contentless 5★ while generating 1★ protests and diluting every later signal
- **This app does:** 3-cap + 'free forever' + rating prompt
- **User reaction:** 1★-burst
- **Magnitude:** cap 180 (2.43); misleading 27 (1.85); prompt 50 (3.22); burst 297
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8247232385`, `6856428999`, `12129865860`, `9975055378`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C054 Never run incentivised / review-for-premium campaigns; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C181 If the app is paid-only, say so in the subtitle and first screenshot

## Things not to do

### R46-014 — A rating prompt with no 'don't ask again' generates one-star reviews and degrades the corpus it inflates: 50 complaints (2.30%, mean 3.22, 10 one-stars) from Jan 2022 ('keeps nagging me to rate it… even though I've rated it about five times already') through the May 2023 burst (30 of 50 in May–Dec 2023) to Aug 2026 ('i already submitted 5 stars stop asking me pls') — 'App asks me to review 4 times in 10 minutes. I haven't even setup 2 habits yet. Only option is Not now… Think twice before adding dark patterns into your app' (2★); 'Every 3 actions it asks me to rate the app. I've been using it for 5 minutes! Chill' (1★); one was told in June 2023 it was fixed, 19 more complaints followed; 17 (0.78%) say outright they are writing only to make it stop

- **Where:** Executive summary #7 — the in-app rating prompt is the largest self-inflicted problem: 50 (2.30%, mean 3.22, 10 one-stars); first Jan 2022 ('rated it about five times already'); 30 of 50 in May–Dec 2023; still live Aug 2026 ('i already submitted 5 stars stop asking me pls'); 'App asks me to review 4 times in 10 minutes. I haven't even setup 2 habits yet. Only option is Not now… Think twice before adding dark patterns'; 'Every 3 actions… I've been using it for 5 minutes! Chill'; 17 (0.78%) write only to make it stop — the fix is a 'don't ask again' state
- **This app does:** rating prompt every few actions; no opt-out
- **User reaction:** 1★-burst
- **Magnitude:** 50 (2.30%), 3.22, 10 1★; solicited 17 (0.78%)
- **Direction for us:** dont · **Report confidence:** meaningful; live · **Generalisable:** yes
- **Review IDs:** `8258958104`, `14423865619`, `12129865860`, `11474568668`, `9975055378`, `10008701823`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R46-016 — Never argue price in a public reply — it converts 'too expensive' into 'and the developer is hostile', a reputational cost no pricing change recovers: 6 reviews (0.28%, mean 1.33, all 2021 or later, five in 2024–26) — 'snarky remarks about working for free and making an overpriced app isn't the way to do it'; 'developer takes any criticism with such a nasty attitude'; 'After reading developer's response I am degrading rating to 1 star from 2… 5/5 rating for app but 0/5 for your behaviour' — plus 2 pressured to change their review ('the developer keeps contacting me to pressure me into changing my review') and 7 never answered (mean 1.57); against 53 (2.43%, mean 4.94) who praise personal support ('reach out to Joan and received a response in less than 30 minutes'; 'Joan helped me add my previous habit data from a different app') and eight ratings raised after contact

- **Where:** Executive summary #9 — support praised 53 (2.43%, mean 4.94: 'reach out to Joan and received a response in less than 30 minutes'; 'Joan helped me add my previous habit data from a different app'; eight ratings raised after contact) but public replies to price criticism convert critics to 1★: 6 (0.28%, 1.33) say a reply was rude or defensive, all 2021+, five in 2024–26 ('snarky remarks about working for free'; 'takes any criticism with such a nasty attitude'; 'After reading developer's response I am degrading rating to 1 star from 2… 5/5 for app but 0/5 for your behaviour'); 2 say the developer pressed them to change their review; 7 (1.57) never answered — reply policy on price reviews is a zero-cost fix
- **This app does:** public replies arguing price
- **User reaction:** 1★-burst
- **Magnitude:** hostile 6 (1.33) + pressured 2 + unanswered 7 (1.57) vs praise 53 (4.94)
- **Direction for us:** dont · **Report confidence:** weak count; reputational · **Generalisable:** yes
- **Review IDs:** `7232471445`, `12948882804`, `5385110766`, `5972193537`, `9360709496`, `9667767203`, `10074816469`, `12349381251`, `14054333465`, `11034917382`, `11113145328`, `13298363427`, `11709301622`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back; C189 Public review replies answer the specific complaint — never canned, never argue price, never press a reviewer to change the rating

### R46-031 — A paywall on first open: 'Meteen abonnement nemen of het beginscherm bekijken. Meer is er niet' ('Take a subscription straight away or look at the start screen. That's all', NL); 'You are immediately prompted with a paywall when opening' (US)

- **Where:** §2.2 Paywall shown on first open — 'Take a subscription straight away or look at the start screen. That's all' (NL); 'You are immediately prompted with a paywall when opening' (US)
- **This app does:** paywall at launch
- **User reaction:** complaint
- **Magnitude:** 2 reviews
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `9949749611`, `11552543931`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C137 Show the paywall at the moment of need, not on app open

### R46-063 — Upsell prompt nag 4 (0.18%, 1.50) — 'the upgrade to premium screen appears and has to be x multiple times'; e-mail spam 3 (1.67, 2020–23, resolved — 'You can turn them off')

- **Where:** §3.1 master table #96 ux_upsell_prompt_nag / #102 ux_email_spam
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 + 3
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `10762802152`, `5910868374`, `6200581271`, `7128048673`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C250 Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts

### R46-085 — UX friction 158 (7.25%, mean 3.49): the review prompt 50 (62% US, 28 at 1–3★) — no 'don't ask again', asked during first-run setup ('It's asking whether I like the app just as I downloaded it!'; 'every other time I marked a habit as complete the app popped up a window asking me to rate it'), asked of subscribers ('Nice app and I'm a subscriber but it continually asks you to provide reviews'), asked across platforms ('I already submitted a feedback but it kept on asking across all platform!'); its paywall twin the upsell nag 4 (mean 1.50 — 'everytiime I try to add a new habit or move between screens the upgrade to premium screen appears and has to be x multiple times'); design dated 34; onboarding 19; symbols 19; localisation 13; reorder 10; history view 9; muddy colours 4; e-mail spam 3

- **Where:** §3.4.4 UX friction (verbatim sub-theme table) — review prompt 50; design dated / clunky 34; onboarding 19; symbols confusing 19; localisation gap 13 (4.08); cannot reorder 10; history view limited 9; colours muddy 4; upsell nag 4 (1.50); e-mail spam 3 — review prompt 62% US, 28 of 50 at 1–3★: no 'don't ask again'; asking during first-run setup ('It's asking whether I like the app just as I downloaded it!'; 'every other time I marked a habit as complete'); asking payers; asking across platforms
- **This app does:** prompts without opt-out
- **User reaction:** complaint
- **Magnitude:** Sub-theme | n | % | Mean ★ | Signal ; ux_review_prompt_nag | 50 | 2.30% | 3.22 | meaningful ; ux_design_dated_or_clunky | 34 | 1.56% | 3.56 | meaningful ; ux_onboarding_confusion | 19 | 0.87% | 3.95 | emerging ; ux_symbols_confusing | 19 | 0.87% | 3.79 | emerging ; ux_localization_gap | 13 | 0.60% | 4.08 | emerging ; ux_cannot_reorder | 10 | 0.46% | 4.10 | weak ; ux_history_view_limited | 9 | 0.41% | 3.44 | weak ; ux_colour_gets_muddy | 4 | 0.18% | 3.50 | weak ; ux_upsell_prompt_nag | 4 | 0.18% | 1.50 | weak ; ux_email_spam | 3 | 0.14% | 1.67 | weak
- **Direction for us:** dont · **Report confidence:** high-priority (union) · **Generalisable:** yes
- **Review IDs:** `12129865860`, `10056037504`, `10053587799`, `9982660905`, `9995971461`, `10762802152`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R46-140 — Bound the in-app rating prompt: never in the first week or first N check-ins, never twice per app version, never again after the user has rated or dismissed it once, never for subscribers, never on a second device — the cheapest fix; the prompt lowers the rating it exists to raise and filled the 2023–26 corpus with contentless reviews

- **Where:** §8.1 #1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** nag 50 (3.22, 10 1★, 11 3★); solicited 17; live Aug 2026
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `14423865619`, `10008701823`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R46-143 — Adopt a reply policy for price reviews: thank, state the free tier and lifetime option factually, never argue value, never ask a reviewer to change their rating — zero cost; every one of these reviews became worse after the developer engaged (a 2★ downgraded to 1★ because of the reply)

- **Where:** §8.1 #4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** hostile 6 (1.33); pressure 2
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13298363427`, `11709301622`
- **Canonical:** C189 Public review replies answer the specific complaint — never canned, never argue price, never press a reviewer to change the rating

## Things to do

### R46-021 — Cheapest high-value moves in evidence order: add a permanent 'don't ask again' to the rating prompt (50 complaints, 10 one-stars, live Aug 2026) → treat the Feb 2026 Russian data-loss cluster as an incident and ship a visible history-integrity check (24 data-loss, 8 payers) → fix trial billing and subscription recognition (13 billing reports, two 'charged on day one') → stop arguing price in public replies (6 hostile-reply reviews, all 1–2★) → raise the free tier to 4 habits so it fills the 4-row widget (29 requests for 4–6) → ship more colours or a paid palette pack (59, mean 4.36) → test a lifetime price near the $30–70 band (27 objections) → add every-N-days and X-per-week scheduling (34)

- **Where:** Executive summary #14 — the cheapest high-value moves, in evidence order
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as stated
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9997347192`, `12334331759`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C029 Billing must be exactly right; C034 Data must never be lost on update, reinstall or phone change; C043 Flexible / custom frequency; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C189 Public review replies answer the specific complaint — never canned, never argue price, never press a reviewer to change the rating; C261 A colour palette users can extend — more defaults, a hex picker, softer sets — because colour is the reward surface

### R46-164 — Experiment: resurface the Learn tab after the first 14 days of use, not only at onboarding — praise fell 11.02% → 3.30% while its per-mention mean stayed 4.82; measure Learn-tab opens after day 14 and day-60 retention

- **Where:** §8.4 E6
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** learn 107 (4.82)
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

## Contradictions

### R46-077 — The same 3-habit cap is defended by 66 reviewers (3.03%, mean 4.92) on habit-science grounds — 'only using the free version (so ltd to 3 habits). But 3 habits is a lot on some days!'; 'Since you shouldn't take on too much, I manage fine with the three free habits'; 'I think the limit is beneficial since it kept me from piling expectations onto myself' — and 15 of the 180 cap reviews are 5★; the defensible version of the cap is the argument these users make, the indefensible version is discovering it after setup or seeing it contradicted by a 'free forever' listing

- **Where:** §3.4.1 Two facts cut the other way — 66 (3.03%, mean 4.92) say three is enough ('3 habits is a lot on some days!'; 'Since you shouldn't take on too much, I manage fine with the three'; 'the limit is beneficial since it kept me from piling expectations onto myself'); 15 of 180 cap reviews are 5★ — the defensible cap is the habit-science argument users make themselves; the indefensible one is discovered after setup or contradicted by the listing
- **This app does:** 3-habit cap
- **User reaction:** praise
- **Magnitude:** 66 (3.03%), 4.92 vs 180 (2.43)
- **Direction for us:** undecided · **Report confidence:** very strong · **Generalisable:** yes
- **Conditions:** defensible when disclosed up front and framed as focus; indefensible when discovered after setup
- **Review IDs:** `5368045613`, `13367736199`, `13247499575`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

## Data caveats and method

### R46-002 — Method: all 2,178 records read individually in full in date order in their original languages (English, Simplified and Traditional Chinese, Spanish, Catalan (≥ 11), German, Russian, Ukrainian, Portuguese, Turkish, French, Italian, Dutch, Korean, Japanese, Polish, Czech, Arabic, Persian, Swedish, Danish, Thai, Vietnamese, Romanian, Croatian, Slovenian, Indonesian); 109 hand-assigned themes across 11 families, 4,234 assignments (1.94 per review), as an explicit review_id → themes map (Temp/46-review-classification.py); eight themes introduced mid-read and back-applied, 22 records patched with reasons listed; programmatic validation (zero unknown IDs, duplicate keys, unassigned records, duplicated or orphan themes); every cited ID verified, every §3.1 count recomputed; bands <0.1 ignore · 0.1–0.5 weak · 0.5–1 emerging · 1–3 meaningful · 3–5 very strong · >5 high-priority; denominator 2,178 (each eligible storefront its own); 205 records (9.41%) contentless and never used as evidence; reconciliation exact (2,178 = parsed = unique = 93 country files; manifest 2,178 / 93 / 4.332 / 5:1532 4:253 3:143 2:84 1:166 reproduced); 3 exact-text duplicate groups ('Good' ×7, 'good app' ×3, 'hao' ×2) retained; 50 of 143 queried storefronts returned zero; votes 89.03% zero — top a 25-vote 'notification keeps firing after the habit is deleted' (IT), a 16-vote Turkish request, a 16-vote 3-habit cap discovered after 20 minutes of setup, a 12-vote Jan 2020 price rise — votes did not surface the May 2023 burst, date clustering did; is_edited 67 (3.08%), verdict changes noted in-line; body median 93.5 chars; the store aggregate 4.7 (4.5K US) sits 0.37 above the 4.332 written mean (written ≈ one rating in six on the US storefront); the least US-concentrated corpus in the series (33.43% US; 51.97% non-English-primary storefronts); storefront ≠ language; no version field; 66 of 109 themes below 1% never promoted; 97 payers (4.45%) self-selected, no conversion rate; external sources — the US listing and public consumer-spend rankings, never mixed into counts

- **Where:** How to read this; Eight warnings #2 #5 #6 #8; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.5 Processing method; §1.6 Limitations; §2.3 External sources
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 2,178/2,178; 109 themes / 11 families; 4,234 assignments; 22 patches
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `6181587486`, `6164086392`, `8247232385`, `6735020315`, `6198632744`, `5471831095`, `5385110766`, `9667767203`, `6998451648`, `10014155915`, `9772705531`
- **Canonical:** — (nuance register)

### R46-003 — An overwhelmingly positive corpus: 81.96% of written reviews are 4–5★ (1,532 5★, 253 4★) and only 250 (11.48%) are 1–2★; findings about what is wrong rest on much smaller counts

- **Where:** Eight warnings #1 — overwhelmingly positive: 1,532 5★ (70.34%), 253 4★ — 81.96% 4–5★; 250 (11.48%) 1–2★
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 5★ 1,532 (70.34%); 1–2★ 250 (11.48%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R46-004 — An aggressive in-app rating prompt produced a 297-review burst (13.64% of the corpus) in 44 days, 18 May → 30 Jun 2023 (24 on 19 May, 24 on 21 May) — 5.4× richer in prompt complaints (7.7% vs 1.4%), 2.5× richer in contentless reviews (19.5% vs 7.8%), mean 4.58 vs 4.29 for the rest; the global mean is 4.332 with it, 4.293 without (n = 1,881), 4.251 without it and all contentless reviews; permitted by Apple, not evidence of fake reviews, but post-May-2023 theme rates are diluted by short, prompted 5★ reviews and trends are corrected for it

- **Where:** Eight warnings #3 — a solicited-review burst: 297 reviews (13.64%) in 44 days, 18 May → 30 Jun 2023 (24 on 19 May, 24 on 21 May), coinciding with an aggressive in-app rating prompt; the window is 5.4× richer in prompt complaints (7.7% vs 1.4%) and 2.5× richer in contentless reviews (19.5% vs 7.8%); mean 4.58 vs 4.29; without it 4.293 (n=1,881), without contentless too 4.251 — permitted by Apple, not fake, but post-May-2023 rates are diluted
- **This app does:** in-app rating prompt
- **User reaction:** 5★-burst
- **Magnitude:** 297 (13.64%) in 44 days; 4.58 vs 4.29
- **Direction for us:** none · **Report confidence:** disclosed · **Generalisable:** yes
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R46-006 — Ten storefronts clear 50 reviews — US 728, China 136, Spain 127, Canada 99, Germany 84, UK 84, Russia 74, Brazil 67, India 58, Turkey 54 — with France 48, Mexico 48, Australia 47, Italy 46 just short (limited evidence); the US is only 33.43% and 51.97% of reviews come from non-English-primary storefronts

- **Where:** Eight warnings #4 #5 — ten storefronts clear 50: US 728, CN 136, ES 127, CA 99, DE 84, GB 84, RU 74, BR 67, IN 58, TR 54; FR 48, MX 48, AU 47, IT 46 just short; the least US-concentrated corpus (33.43%); 51.97% non-English-primary
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 10 eligible; US 33.43%
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R46-007 — Rating vs text mismatches: 31 (1.42%) — seven Chinese 5★ reviews (5.15% of that storefront) reporting the app cannot connect ('显示离线模式，不让记录'), 1★ reviews that praise the app ('Love this app! This app is keeping me true to my goals'), and 1★ reviews that punish the review prompt; ~1.4% noise in rating-only analysis

- **Where:** Eight warnings #7 — 31 rating/text mismatches (1.42%): seven Chinese 5★ reporting 'Shows offline mode, won't let me record'; 1★ 'Love this app!'; 1★ punishing the review prompt
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 31 (1.42%); 7 CN 5★
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `4836234866`, `11259213795`, `11090018321`
- **Canonical:** — (nuance register)

### R46-023 — Feature inventory with representative IDs and notes

- **Where:** §2.1 Feature inventory derived from reviews (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence (review IDs) | Notes ; Habit × day grid; tap a square to mark done | 8634199924 9567101427 11785968517 | The whole product surface in one sentence: *"You tick a box to show you did the thing"* (11785968517) ; Colour saturation that deepens with each consecutive completion | 3499180279 5595638800 7033733479 8292480771 11275754602 | The signature mechanic; resets on a miss (5916248950, 12126118988 ask for gentler decay) ; Skip marks: half-square (tap twice) and triangle; "don't skip twice" rule | 4172950287 6703493891 8634199924 10483508663 14503999008 | Semantics confuse a minority (§3.4.4) ; Scheduled skip days / weekday-only habits ("no weekends") | 4997111034 7162864243 9068859445 | No every-N-days or X-per-week (§3.5) ; Habit-breaking mode (colour fades when a bad habit is logged) | 6735020315 7651641484 10073584696 14091755398 | Its logic is unclear to some (10073584696, 11107406485) ; Per-habit reminders | 6054523389 6181587486 8981807643 11099569599 | One reminder time per habit; multi-time reminders requested ; Statistics: success rate, streak counts, week/month/year totals | 3476503599 8764353845 8834659754 10483508663 | 6269178985 reports month/year counts computing wrongly (2020) ; Learn tab: articles, videos, James Clear / Atomic Habits material; 7-day email course | 4651655959 5355179743 6653048529 8270477610 10802899909 | Strongly praised by early users; English-only per 5 reviewers ; Web app and Chrome new-tab extension | 3392010074 7252450338 8270477610 9779787899 11040174280 | Pre-dates the iPhone app (3197455014); Safari plugin by 2024 (10906751585) ; iPhone, iPad, Mac app | 6644249759 8270477610 9936613465 12285019784 | Mac build criticised as slow (11387719561, 13459643027) ; Apple Watch app and complications | 7142563934 9241651061 9433419102 12283194838 | Present by March 2021; sync with the phone reported unreliable (§3.4.3) ; Home-screen widgets (interactive check-off) | 6455669260 7066647015 9938815588 10988047541 13116954771 | From iOS 14 (Sept 2020); widget fits 4 habits, free tier allows 3 ; Journal / per-day notes and calendar view (v3, from Dec 2023) | 10762490298 10940916205 11568277514 11433849366 | Named as a new update in 10762490298 and 10940916205 ; Folders / habit groups | 12872024539 12987527653 13116954771 | *"The new habit folder feature is — chef's kiss"* (12987527653, Aug 2025) ; Numeric count per day (0–10 scale) | 11402316703 11625636896 | Its effect on colour is unclear (11625636896) ; Archive habits | 8849839986 11433849366 14295805634 | Free users report being unable to archive or delete after a trial (9243772066) ; Shortcuts integration | 11399804236 | *"one of the few that has shortcuts integration"* ; Dark mode | 5233752821 8239685970 | Reported paywalled in 2020 and again in June 2024 (§2.2) ; Account / sign-in (including Sign in with Apple) | 3038410981 10771638093 | Required in early years; optional by 2024 (§2.2) ; Data import with developer help | 12948882804 | *"Joan helped me add my previous habit data from a different app"* ; Localized UI incl. Catalan, Arabic, Turkish | 9956172746 6775992927 6862775837 9410319036 | Learn content and emails remain English (§3.5) ; In-app rating prompt | 50 ux_review_prompt_nag reviews | §3.4.4
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Review IDs:** `8634199924`, `11785968517`, `8292480771`, `11275754602`, `4172950287`, `6703493891`, `14503999008`, `4997111034`, `7162864243`, `9068859445`, `6735020315`, `7651641484`, `10073584696`, `14091755398`, `6054523389`, `8981807643`, `11099569599`, `3476503599`, `8764353845`, `8834659754`, `6269178985`, `6653048529`, `8270477610`, `10802899909`, `3392010074`, `7252450338`, `9779787899`, `11040174280`, `10906751585`, `6644249759`, `9936613465`, `12285019784`, `11387719561`, `13459643027`, `7142563934`, `9241651061`, `9433419102`, `12283194838`, `6455669260`, `7066647015`, `9938815588`, `10988047541`, `13116954771`, `10762490298`, `10940916205`, `11568277514`, `11433849366`, `12872024539`, `12987527653`, `11402316703`, `11625636896`, `8849839986`, `14295805634`, `9243772066`, `11399804236`, `5233752821`, `8239685970`, `10771638093`, `9956172746`, `6775992927`, `6862775837`, `9410319036`
- **Canonical:** — (nuance register)

### R46-035 — Master theme table, denominator 2,178, with US n and period

- **Where:** §3.1 Master table — all 109 themes (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | Family | Dir | n | % of 2,178 | Mean ★ | US n | Period | Signal ; 1 | cp_simplicity | Core praise | pos | 425 | 19.51% | 4.87 | 177/425 | 2018–2026 | high-priority ; 2 | cp_behaviour_change | Core praise | pos | 283 | 12.99% | 4.93 | 115/283 | 2018–2026 | high-priority ; 3 | cp_visual_colour_system | Core praise | pos | 228 | 10.47% | 4.86 | 110/228 | 2018–2026 | high-priority ; 4 | cp_beautiful_design | Core praise | pos | 227 | 10.42% | 4.63 | 83/227 | 2018–2026 | high-priority ; 5 | meta_low_information | Meta | — | 205 | 9.41% | 4.75 | 49/205 | 2019–2026 | high-priority ; 6 | cp_competitive_displacement | Core praise | pos | 198 | 9.09% | 4.92 | 93/198 | 2018–2026 | high-priority ; 7 | cp_ease_of_use | Core praise | pos | 185 | 8.49% | 4.87 | 73/185 | 2018–2026 | high-priority ; 8 | mf_free_cap_3habits | Monetization friction | neg | 180 | 8.26% | 2.43 | 53/180 | 2019–2026 | high-priority ; 9 | cp_generic_positive | Core praise | pos | 176 | 8.08% | 4.93 | 43/176 | 2018–2026 | high-priority ; 10 | mf_price_too_high | Monetization friction | neg | 163 | 7.48% | 2.84 | 50/163 | 2019–2026 | high-priority ; 11 | cp_learn_content | Core praise | pos | 107 | 4.91% | 4.82 | 44/107 | 2019–2026 | very strong ; 12 | mp_paid_subscription | Purchase evidence | — | 74 | 3.40% | 4.04 | 33/74 | 2019–2026 | very strong ; 13 | cp_cross_platform | Core praise | pos | 72 | 3.31% | 4.82 | 29/72 | 2018–2026 | very strong ; 14 | cp_widget | Core praise | pos | 66 | 3.03% | 4.79 | 29/66 | 2020–2026 | very strong ; 15 | mp_free_tier_sufficient | Monetization praise | pos | 66 | 3.03% | 4.92 | 19/66 | 2019–2026 | very strong ; 16 | fr_more_colours | Feature gaps & requests | req | 59 | 2.71% | 4.36 | 19/59 | 2020–2026 | meaningful ; 17 | cp_stats | Core praise | pos | 54 | 2.48% | 4.91 | 31/54 | 2019–2026 | meaningful ; 18 | mf_want_one_time_purchase | Monetization friction | neg | 53 | 2.43% | 3.32 | 9/53 | 2019–2025 | meaningful ; 19 | sup_responsive_praise | Support | pos | 53 | 2.43% | 4.94 | 24/53 | 2019–2026 | meaningful ; 20 | mp_worth_the_money | Monetization praise | pos | 51 | 2.34% | 4.94 | 33/51 | 2018–2026 | meaningful ; 21 | ux_review_prompt_nag | UX friction | neg | 50 | 2.30% | 3.22 | 31/50 | 2022–2026 | meaningful ; 22 | cp_streak_motivation | Core praise | pos | 44 | 2.02% | 4.80 | 23/44 | 2018–2026 | meaningful ; 23 | cp_habit_breaking | Core praise | pos | 42 | 1.93% | 4.98 | 17/42 | 2018–2026 | meaningful ; 24 | seg_longtime_user | Segments | — | 42 | 1.93% | 4.86 | 18/42 | 2020–2026 | meaningful ; 25 | cp_skip_forgiving | Core praise | pos | 41 | 1.88% | 4.93 | 21/41 | 2019–2026 | meaningful ; 26 | mf_anti_subscription | Monetization friction | neg | 41 | 1.88% | 2.44 | 9/41 | 2019–2026 | meaningful ; 27 | cp_replaces_paper | Core praise | pos | 37 | 1.70% | 4.81 | 20/37 | 2019–2026 | meaningful ; 28 | fr_flexible_frequency | Feature gaps & requests | req | 34 | 1.56% | 4.09 | 10/34 | 2019–2026 | meaningful ; 29 | ux_design_dated_or_clunky | UX friction | neg | 34 | 1.56% | 3.56 | 7/34 | 2019–2026 | meaningful ; 30 | mf_trial_too_limited | Monetization friction | neg | 32 | 1.47% | 1.88 | 7/32 | 2020–2026 | meaningful ; 31 | neg_value_scepticism | Product-value criticism | neg | 32 | 1.47% | 2.16 | 14/32 | 2019–2026 | meaningful ; 32 | cp_customization | Core praise | pos | 31 | 1.42% | 4.94 | 21/31 | 2018–2026 | meaningful ; 33 | meta_rating_text_mismatch | Meta | — | 31 | 1.42% | 3.71 | 8/31 | 2019–2025 | meaningful ; 34 | seg_adhd_neuro_health | Segments | — | 30 | 1.38% | 4.83 | 23/30 | 2019–2026 | meaningful ; 35 | mf_more_free_habits_request | Monetization friction | neg | 29 | 1.33% | 3.69 | 6/29 | 2019–2026 | meaningful ; 36 | mf_competitor_cheaper | Monetization friction | neg | 28 | 1.29% | 2.25 | 10/28 | 2019–2025 | meaningful ; 37 | mf_lifetime_price_too_high | Monetization friction | neg | 27 | 1.24% | 3.00 | 10/27 | 2022–2026 | meaningful ; 38 | mf_misleading_free_claim | Monetization friction | neg | 27 | 1.24% | 1.85 | 12/27 | 2019–2026 | meaningful ; 39 | rel_crash_freeze | Reliability | neg | 25 | 1.15% | 3.04 | 6/25 | 2019–2024 | meaningful ; 40 | cp_reminders | Core praise | pos | 24 | 1.10% | 4.92 | 8/24 | 2019–2026 | meaningful ; 41 | rel_data_loss | Reliability | neg | 24 | 1.10% | 2.12 | 4/24 | 2020–2026 | meaningful ; 42 | rel_misc_bug | Reliability | neg | 23 | 1.06% | 3.17 | 5/23 | 2019–2026 | meaningful ; 43 | seg_web_or_extension_user | Segments | — | 23 | 1.06% | 4.70 | 14/23 | 2018–2025 | meaningful ; 44 | cp_atomic_habits | Core praise | pos | 21 | 0.96% | 4.90 | 8/21 | 2020–2026 | emerging ; 45 | rel_widget_broken | Reliability | neg | 21 | 0.96% | 3.33 | 7/21 | 2021–2025 | emerging ; 46 | mp_price_reasonable | Monetization praise | pos | 20 | 0.92% | 4.80 | 7/20 | 2019–2026 | emerging ; 47 | ux_onboarding_confusion | UX friction | neg | 19 | 0.87% | 3.95 | 6/19 | 2020–2025 | emerging ; 48 | ux_symbols_confusing | UX friction | neg | 19 | 0.87% | 3.79 | 6/19 | 2019–2026 | emerging ; 49 | meta_solicited | Meta | — | 17 | 0.78% | 3.47 | 12/17 | 2023–2026 | emerging ; 50 | neg_too_basic | Product-value criticism | neg | 17 | 0.78% | 3.18 | 7/17 | 2021–2026 | emerging ; 51 | rel_offline_mode_bug | Reliability | neg | 17 | 0.78% | 3.53 | 0/17 | 2019–2023 | emerging ; 52 | cp_reliable | Core praise | pos | 16 | 0.73% | 4.69 | 6/16 | 2019–2026 | emerging ; 53 | mp_paid_lifetime | Purchase evidence | — | 16 | 0.73% | 4.56 | 7/16 | 2021–2026 | emerging ; 54 | rel_sync_issues | Reliability | neg | 15 | 0.69% | 3.13 | 8/15 | 2020–2026 | emerging ; 55 | mf_billing_problem | Monetization friction | neg | 13 | 0.60% | 2.31 | 6/13 | 2020–2026 | emerging ; 56 | mp_support_indie | Monetization praise | pos | 13 | 0.60% | 4.92 | 6/13 | 2019–2024 | emerging ; 57 | rel_layout_scroll_bug | Reliability | neg | 13 | 0.60% | 3.38 | 7/13 | 2019–2025 | emerging ; 58 | ux_localization_gap | UX friction | neg | 13 | 0.60% | 4.08 | 0/13 | 2020–2024 | emerging ; 59 | cp_journal_notes | Core praise | pos | 12 | 0.55% | 4.67 | 6/12 | 2023–2025 | emerging ; 60 | fr_multiple_per_day | Feature gaps & requests | req | 12 | 0.55% | 4.08 | 4/12 | 2020–2025 | emerging ; 61 | seg_first_review_ever | Segments | — | 12 | 0.55% | 4.58 | 6/12 | 2020–2025 | emerging ; 62 | fr_more_stats | Feature gaps & requests | req | 11 | 0.51% | 4.55 | 5/11 | 2020–2025 | emerging ; 63 | fr_grouping_tags | Feature gaps & requests | req | 10 | 0.46% | 4.10 | 2/10 | 2020–2025 | weak ; 64 | mp_no_ads | Monetization praise | pos | 10 | 0.46% | 4.90 | 5/10 | 2020–2025 | weak ; 65 | ux_cannot_reorder | UX friction | neg | 10 | 0.46% | 4.10 | 3/10 | 2019–2026 | weak ; 66 | fr_automation_integration | Feature gaps & requests | req | 9 | 0.41% | 3.44 | 2/9 | 2020–2024 | weak ; 67 | fr_counter_quantity | Feature gaps & requests | req | 9 | 0.41% | 4.56 | 1/9 | 2019–2026 | weak ; 68 | fr_notes_journal | Feature gaps & requests | req | 9 | 0.41% | 3.89 | 2/9 | 2020–2026 | weak ; 69 | fr_notification_control | Feature gaps & requests | req | 9 | 0.41% | 4.56 | 3/9 | 2020–2026 | weak ; 70 | rel_login_signup_fail | Reliability | neg | 9 | 0.41% | 1.89 | 5/9 | 2018–2024 | weak ; 71 | rel_mac_performance | Reliability | neg | 9 | 0.41% | 3.78 | 5/9 | 2020–2025 | weak ; 72 | ux_history_view_limited | UX friction | neg | 9 | 0.41% | 3.44 | 3/9 | 2020–2025 | weak ; 73 | fr_accessibility | Feature gaps & requests | req | 8 | 0.37% | 3.75 | 4/8 | 2019–2025 | weak ; 74 | fr_widget | Feature gaps & requests | req | 8 | 0.37% | 4.38 | 1/8 | 2019–2022 | weak ; 75 | mf_account_required | Monetization friction | neg | 8 | 0.37% | 1.50 | 1/8 | 2019–2022 | weak ; 76 | mf_paywalled_capability | Monetization friction | neg | 8 | 0.37% | 2.12 | 4/8 | 2020–2025 | weak ; 77 | mf_regional_pricing | Monetization friction | neg | 8 | 0.37% | 3.50 | 0/8 | 2020–2026 | weak ; 78 | rel_notifications_broken | Reliability | neg | 7 | 0.32% | 3.14 | 2/7 | 2019–2023 | weak ; 79 | rel_offline_use_blocked | Reliability | neg | 7 | 0.32% | 2.14 | 3/7 | 2021–2025 | weak ; 80 | sup_unresponsive | Support | neg | 7 | 0.32% | 1.57 | 1/7 | 2022–2026 | weak ; 81 | fr_missed_vs_blank | Feature gaps & requests | req | 6 | 0.28% | 4.67 | 2/6 | 2020–2026 | weak ; 82 | fr_social_accountability | Feature gaps & requests | req | 6 | 0.28% | 4.50 | 5/6 | 2020–2025 | weak ; 83 | mf_discount_request | Monetization friction | neg | 6 | 0.28% | 3.67 | 2/6 | 2021–2026 | weak ; 84 | sup_dev_reply_hostile | Support | neg | 6 | 0.28% | 1.33 | 3/6 | 2021–2026 | weak ; 85 | fr_apple_watch | Feature gaps & requests | req | 5 | 0.23% | 4.00 | 1/5 | 2020–2023 | weak ; 86 | fr_calendar_view | Feature gaps & requests | req | 5 | 0.23% | 3.40 | 1/5 | 2021–2025 | weak ; 87 | fr_sounds_haptics | Feature gaps & requests | req | 5 | 0.23% | 4.20 | 1/5 | 2020–2024 | weak ; 88 | mf_longevity_doubt | Monetization friction | neg | 5 | 0.23% | 4.20 | 0/5 | 2019–2025 | weak ; 89 | mf_price_increase | Monetization friction | neg | 5 | 0.23% | 2.20 | 4/5 | 2020–2025 | weak ; 90 | neg_stagnant_development | Product-value criticism | neg | 5 | 0.23% | 1.60 | 1/5 | 2020–2026 | weak ; 91 | fr_landscape | Feature gaps & requests | req | 4 | 0.18% | 4.00 | 1/4 | 2021–2024 | weak ; 92 | fr_timer | Feature gaps & requests | req | 4 | 0.18% | 4.75 | 0/4 | 2020–2024 | weak ; 93 | mf_locked_out_after_trial | Monetization friction | neg | 4 | 0.18% | 3.75 | 2/4 | 2020–2022 | weak ; 94 | seg_student | Segments | — | 4 | 0.18% | 3.75 | 2/4 | 2020–2026 | weak ; 95 | ux_colour_gets_muddy | UX friction | neg | 4 | 0.18% | 3.50 | 1/4 | 2022–2026 | weak ; 96 | ux_upsell_prompt_nag | UX friction | neg | 4 | 0.18% | 1.50 | 2/4 | 2023–2024 | weak ; 97 | cp_no_gamification | Core praise | pos | 3 | 0.14% | 5.00 | 1/3 | 2023–2026 | weak ; 98 | fr_account_deletion | Feature gaps & requests | req | 3 | 0.14% | 2.00 | 0/3 | 2020 | weak ; 99 | fr_backfill_history | Feature gaps & requests | req | 3 | 0.14% | 3.67 | 1/3 | 2020–2022 | weak ; 100 | fr_export_backup | Feature gaps & requests | req | 3 | 0.14% | 4.33 | 1/3 | 2020–2024 | weak ; 101 | rel_accidental_tap | Reliability | neg | 3 | 0.14% | 3.67 | 0/3 | 2023–2026 | weak ; 102 | ux_email_spam | UX friction | neg | 3 | 0.14% | 1.67 | 0/3 | 2020–2023 | weak ; 103 | fr_subtasks | Feature gaps & requests | req | 2 | 0.09% | 4.50 | 2/2 | 2021–2025 | ignore ; 104 | fr_todo_tasks | Feature gaps & requests | req | 2 | 0.09% | 4.50 | 0/2 | 2023 | ignore ; 105 | mf_no_family_sharing | Monetization friction | neg | 2 | 0.09% | 2.00 | 1/2 | 2023–2024 | ignore ; 106 | sup_review_pressure | Support | neg | 2 | 0.09% | 2.50 | 2/2 | 2023–2024 | ignore ; 107 | fr_android | Feature gaps & requests | req | 1 | 0.05% | 5.00 | 1/1 | 2025 | ignore ; 108 | fr_app_lock | Feature gaps & requests | req | 1 | 0.05% | 2.00 | 0/1 | 2023 | ignore ; 109 | fr_desktop_app | Feature gaps & requests | req | 1 | 0.05% | 5.00 | 1/1 | 2020 | ignore
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R46-037 — Generic positive 176 (8.08%, 4.93); low-information 205 (9.41%, 4.75)

- **Where:** §3.1 master table #9 cp_generic_positive / #5 meta_low_information
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 176 + 205
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R46-038 — Paid subscription 74 (3.40%, mean 4.04); paid lifetime 16 (0.73%, 4.56) — purchase evidence, not praise

- **Where:** §3.1 master table #12 mp_paid_subscription / #53 mp_paid_lifetime
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 74 + 16
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R46-065 — Ignore-level (< 0.1%): subtasks 2; one-off to-dos 2; Family Sharing 2; review pressure 2; Android 1; app lock 1; desktop app 1 (2020)

- **Where:** §3.1 master table #103–#109 ignore-level rows
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** ≤2 each
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R46-092 — Distribution: 5★ 1,532 (70.34%) · 4★ 253 (11.62%) · 3★ 143 (6.57%) · 2★ 84 (3.86%) · 1★ 166 (7.62%); 81.96% 4–5★

- **Where:** Part 4 distribution — 5★ 1,532 (70.34%) · 4★ 253 (11.62%) · 3★ 143 (6.57%) · 2★ 84 (3.86%) · 1★ 166 (7.62%); strongly top-heavy with a thin negative tail; the 4★ and 3★ bands (18.2%) are where the corpus explains what is missing
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as stated
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R46-100 — Cross-tab (top 20): simplicity 381/33/10/1/0; behaviour change 269/11/1/0/2; colour system 200/23/5/0/0; design 180/24/13/5/5; low-info 169/27/5/2/2; displacement 185/11/2/0/0; ease 168/12/3/2/0; cap 15/33/35/29/68; generic 165/10/1/0/0; price 30/30/32/26/45; learn 92/11/4/0/0; paid subscription 47/5/7/8/7; cross-platform 64/5/2/0/1; widget 57/6/2/0/1; free sufficient 61/5/0/0/0; more colours 35/15/5/3/1; stats 49/5/0/0/0; one-time 14/14/11/3/11; support praise 50/3/0/0/0; worth it 48/3/0/0/0 — the cap appears at 5★ fifteen times ('It let's me track 3 habit for free and really more than that is too much to start all at once anyway!'), price too high at 5★ thirty times ('挺好用的，就是有点贵'; 'quite expensive but I suppose that's the price you have to pay'), beautiful design at 1★ and 2★ always as the opening clause of a paywall complaint, and contentless reviews are 82% 5★ with 41% in the 2023 prompt era

- **Where:** §4.6 Theme × rating cross-tabulation (verbatim table, top 20) — the cap at 5★ fifteen times ('really more than that is too much to start all at once anyway!'); price too high at 5★ thirty times ('Very useful, just a bit expensive'; 'quite expensive but I suppose that's the price you have to pay'); beautiful design at 1★ five and 2★ five times, always the opening clause of a paywall complaint; low-information 82% 5★ and 41% in the 2023 prompt era — contentless reviews are overwhelmingly prompted praise
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | 5★ | 4★ | 3★ | 2★ | 1★ | Mean ; cp_simplicity | 425 | 381 | 33 | 10 | 1 | 0 | 4.87 ; cp_behaviour_change | 283 | 269 | 11 | 1 | 0 | 2 | 4.93 ; cp_visual_colour_system | 228 | 200 | 23 | 5 | 0 | 0 | 4.86 ; cp_beautiful_design | 227 | 180 | 24 | 13 | 5 | 5 | 4.63 ; meta_low_information | 205 | 169 | 27 | 5 | 2 | 2 | 4.75 ; cp_competitive_displacement | 198 | 185 | 11 | 2 | 0 | 0 | 4.92 ; cp_ease_of_use | 185 | 168 | 12 | 3 | 2 | 0 | 4.87 ; mf_free_cap_3habits | 180 | 15 | 33 | 35 | 29 | 68 | 2.43 ; cp_generic_positive | 176 | 165 | 10 | 1 | 0 | 0 | 4.93 ; mf_price_too_high | 163 | 30 | 30 | 32 | 26 | 45 | 2.84 ; cp_learn_content | 107 | 92 | 11 | 4 | 0 | 0 | 4.82 ; mp_paid_subscription | 74 | 47 | 5 | 7 | 8 | 7 | 4.04 ; cp_cross_platform | 72 | 64 | 5 | 2 | 0 | 1 | 4.82 ; cp_widget | 66 | 57 | 6 | 2 | 0 | 1 | 4.79 ; mp_free_tier_sufficient | 66 | 61 | 5 | 0 | 0 | 0 | 4.92 ; fr_more_colours | 59 | 35 | 15 | 5 | 3 | 1 | 4.36 ; cp_stats | 54 | 49 | 5 | 0 | 0 | 0 | 4.91 ; mf_want_one_time_purchase | 53 | 14 | 14 | 11 | 3 | 11 | 3.32 ; sup_responsive_praise | 53 | 50 | 3 | 0 | 0 | 0 | 4.94 ; mp_worth_the_money | 51 | 48 | 3 | 0 | 0 | 0 | 4.94
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `5284889566`, `6451462235`, `10897862527`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R46-101 — Payers: 97 (4.45%) — 74 subscribers, 16 lifetime buyers, 13 charged — average 3.95 vs 4.35 for 2,081 non-payers; 5★ 61.9% vs 70.7%; 2★ 10.3% vs 3.6% (2.9×); 1★ 12.4% vs 7.4% (1.7×); the payer rate is higher on the US storefront (44 of 728, 6.04%) than elsewhere (53 of 1,450, 3.66%) — a weak signal consistent with a price-sensitivity gap; by era 3.76% (2018–20) → 6.48% (2021–Apr 2023) → 3.62% (May–Dec 2023) → 4.32% (2024–26); lifetime buyers appear only from May 2021, 10 of 16 in 2024–26

- **Where:** §5.1 Who is identifiable as a payer (verbatim table) — 97 (4.45%): 74 subscribers, 16 lifetime, 13 charged; payers 3.95 vs 4.35; 5★ 61.9% vs 70.7%; 2★ 10.3% vs 3.6% (2.9×); 1★ 12.4% vs 7.4% (1.7×); payer rate US 6.04% vs 3.66% elsewhere (weak); by era 3.76% → 6.48% → 3.62% → 4.32%; lifetime buyers only from May 2021, 10 of 16 in 2024–26
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Metric | Payers (n=97) | Non-payers (n=2,081) ; Mean rating | 3.95 | 4.35 ; 5★ | 60 (61.9%) | 1,472 (70.7%) ; 4★ | 6 (6.2%) | 247 (11.9%) ; 3★ | 9 (9.3%) | 134 (6.4%) ; 2★ | 10 (10.3%) | 74 (3.6%) ; 1★ | 12 (12.4%) | 154 (7.4%)
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R46-129 — Trend method: calendar year; four eras cut around the one structural event (the rating-prompt burst) — E1 9 Aug 2018 → 31 Dec 2020 (n 372, mean 4.05), E2 1 Jan 2021 → 30 Apr 2023 (401, 4.01), E3 1 May → 31 Dec 2023 (525, 4.47, the burst), E4 1 Jan 2024 → 4 Sep 2026 (880, 4.51); halves split at the median record (9 Jul 2023, 1,089 each); a trend is labelled only if it holds in two cuts; every negative-theme rate after April 2023 is biased downward by prompted short positive reviews, so annual counts are shown beside rates

- **Where:** §7.1 Method — calendar year (2018 holds 12); four eras around the prompt burst: E1 Aug 2018 – Dec 2020 (372, 4.05) · E2 Jan 2021 – Apr 2023 (401, 4.01) · E3 May – Dec 2023 (525, 4.47, contains the burst) · E4 Jan 2024 – Sep 2026 (880, 4.51); halves at the median record (9 Jul 2023, 1,089 each); a trend only if it holds in two cuts; every post-April-2023 negative rate is biased downward by prompted reviews so counts are shown alongside
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R46-165 — Research question: What changed for Russian users in February 2026? Four independent data-loss reports in 23 days from one storefront — resolvable from sync-server and release logs

- **Where:** Part 8 #1 (§8.5 research question 1)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `13721978399`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R46-166 — Research question: Was the 2019–2020 China 'offline mode' cluster a network-reachability issue? 16 of 17 Chinese, two waves — resolvable from connection telemetry by region

- **Where:** Part 8 #2 (§8.5 research question 2)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** C188 The app must open offline — never block launch on a network call

### R46-167 — Research question: What is the trial-to-paid conversion rate and what share of payers choose lifetime? 97 writers say they paid — no conversion claim made

- **Where:** Part 8 #3 (§8.5 research question 3)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R46-168 — Research question: Did the May 2023 rating prompt move the store's displayed rating? 297 reviews at mean 4.58 in 44 days — the ratings-only population is invisible

- **Where:** Part 8 #4 (§8.5 research question 4)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R46-169 — Research question: Does free-tier size change conversion? Report 43's app loosened its cap and the complaint vanished; this app did not — resolvable only by experiment E3

- **Where:** Part 8 #5 (§8.5 research question 5)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R46-170 — Research question: Why is the payer rate twice as high in high-spend markets (5.61% vs 2.85%) and highest in the US (6.04%)? Price tiers or reporting behaviour — resolvable from per-storefront revenue

- **Where:** Part 8 #6 (§8.5 research question 6)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R46-171 — Research question: When exactly was dark mode gated? Paywalled in 2020 and 'moved behind a paywall' again in June 2024 — resolvable from release notes

- **Where:** Part 8 #7 (§8.5 research question 7)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `6139789378`, `11382464605`
- **Canonical:** C080 Colour themes / dark mode
