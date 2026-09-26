# Cards — report 16

Source: `App Store Reports/16. Atoms - from Atomic Habits - The official Atomic Habits app (REPORT).md`  
83 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 8
- [Must-haves](#must-haves) — 1
- [Must never break](#must-never-break) — 8
- [Features](#features) — 11
- [Monetization](#monetization) — 8
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 8
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 11
- [Dated events and trends](#dated-events-and-trends) — 8
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 1
- [Things to do](#things-to-do) — 3
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 9

## Product rules

### R16-003 — The most monetisation-damaged corpus in the set: Atoms is not a broken app, it is a well-built app whose packaging destroyed its written reception — nearly three of four 1★ reviews are about the price not the product, and over a quarter of price objectors praise the app in the same review ('the best looking habit tracking app I've downloaded… However, due to the ridiculous subscription fee it was a very quick uninstall'; 'it really was making a difference')

- **Where:** Part 0 §1 This is the most monetisation-damaged corpus in the set, and the damage is a single decision; band table (verbatim)
- **This app does:** subscription; $120/yr at launch
- **User reaction:** 1★-burst
- **Magnitude:** money 457 (39.13%) mean 2.38; price objection 392 (33.56%, HIGH-PRIORITY) mean 2.18, 65.3% 1–2★; Band | n | % of band that objects to price ; 1★ | 208 | 153 (73.6%) ; 2★ | 142 | 103 (72.5%) ; 3★ | 135 | 76 (56.3%) ; 4★ | 102 | 31 (30.4%) ; 5★ | 581 | 29 (5.0%) ; 109 of 392 objectors praise the app; 43 of 208 1★ (20.7%) contain praise; only 15 1★ about loading, 12 about logging
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10995055502`, `11090232087`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C064 Price level — where 'fair' turns into 'too expensive'; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R16-004 — The free tier is one habit and that single number is the mechanism: 'a habit tracker that tracks one habit is not a habit tracker' — 'This is useless for me, I have more than 3 habits to track before I have breakfast'; 'the free version would better be renamed to Atom'; the cap has been 1 continuously for 27 months; because the free tier is unusable it cannot do trial work — every other habit app in the folder converts through a usable free tier

- **Where:** Part 0 §2 The free tier is one habit — and that single number is the mechanism
- **This app does:** free tier = 1 habit
- **User reaction:** blocked-conversion
- **Magnitude:** 76 (6.51%, HIGH-PRIORITY) mean 2.22, 61.8% 1–2★, 7.9% 5★; 24 Feb 2024 → 14 May 2026 unchanged
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10984314443`, `11340151425`, `12199586867`, `11400713510`, `10975917055`, `14064134860`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C147 Let people use the product before they pay

### R16-005 — The PAID tier is capped too: Pro was 3 habits at launch, raised to 6 in the second week of March 2024 ('They went from 3 to 6 habits for pro at $100+/yr?! That's your fix? Absolutely not. Deleted' — the most-voted cap complaint), and paying customers are still hitting the ceiling in 2026 ('A paid user pays $5/month or $40/year just to create only 6 habits simultaneously? Other similar apps use hard limit to incentivize in-app purchase, not locking them down'); combined the two caps are the single largest addressable product decision in the corpus

- **Where:** Part 0 §3 The paid tier is capped too — and that is the finding nobody expects; cap table (verbatim)
- **This app does:** Pro capped at 3 → 6 habits
- **User reaction:** churn
- **Magnitude:** 75 (6.42%, HIGH-PRIORITY) mean 2.57, 57.3% 1–2★; Cap | First dated reviewer report | Last dated reviewer report | Span | Mentions ; Pro = 3 habits | `10975518449`(US,1★, 24 Feb 2024) | `11883256863`(US,1★, 28 Oct 2024) | — | 48 ; Pro = 6 habits | `11033626383`(US,1★, 11 Mar 2024) | `14287877372`(US,2★, 10 Jul 2026) | 2y 4m | 26 ; both caps combined 135 (11.56%) mean 2.44, 57.8% 1–2★
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10975518449`, `11883256863`, `11033626383`, `14287877372`, `13573785597`, `13222746779`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C191 Never cap the tier someone has already paid for

### R16-027 — The paid feature reviewers most resent losing is not habit slots but the Mindset content, because they correctly identify it as material they already bought — 'since I already read the book which only cost me $15 one time why would I pay anywhere close to that monthly to get the same information'; 'Shameful that they're taking away features and driving away loyal supporters' — the core packaging error: Atoms paywalls the two things its audience already owns (the ideas, and the willingness to track) and gives away the one thing that costs nothing to give (a second habit slot)

- **Where:** §2.2 The paid feature reviewers most resent losing is the Mindset content — material they already bought; the core packaging error stated plainly
- **This app does:** Mindset content paywalled after being free at launch; habit slots gated
- **User reaction:** 1★-burst
- **Magnitude:** 3 cited IDs; Mindset 59 mentions
- **Direction for us:** product-rule · **Report confidence:** argued from corpus · **Generalisable:** yes
- **Review IDs:** `11010361389`, `11097642923`, `12819752757`
- **Canonical:** C133 Gate on capability, not on quantity; C194 Do not paywall content the user already bought elsewhere

### R16-066 — Raise the free tier from 1 habit to 3 — the number reviewers repeatedly propose; the constraint's defenders defend a limit of 3–6, not 1, so raising the free tier keeps the philosophy and removes the objection; the single highest-leverage change and a configuration value

- **Where:** §8.1 #1 Raise the free tier from 1 habit to 3
- **This app does:** free = 1
- **User reaction:** blocked-conversion
- **Magnitude:** 76 reviews mean 2.22, 61.8% 1–2★; defenders 20 mean 4.60
- **Direction for us:** product-rule · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `10975505569`, `10988610880`, `11749997696`, `13838905269`, `10986199056`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R16-067 — Remove the 6-habit cap from the paid tier or raise it to 12–15 — a cap on the tier someone has already paid for has no monetisation function (there is no higher tier to drive to); it only produces angry reviews, and two of three payers who bought to escape a cap rated 3★ after hitting the next one

- **Where:** §8.1 #2 Remove the 6-habit cap from the paid tier, or raise it to 12–15 — a cap on the tier someone has already paid for has no monetisation function
- **This app does:** Pro = 6
- **User reaction:** churn
- **Magnitude:** 75 reviews mean 2.57, 29 months unchanged
- **Direction for us:** product-rule · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14287877372`, `13573785597`, `13222746779`
- **Canonical:** C191 Never cap the tier someone has already paid for

### R16-072 — Stop paywalling the Mindset content or unbundle it — paywalling the ideas from a book the user already bought is the packaging decision reviewers find hardest to forgive, and Mindset praise fell 6.78% → 1.20% once it went behind the wall; the content is a differentiator generating more resentment than revenue — consider content free, habit slots paid, the exact inverse of today

- **Where:** §8.2 #7 Stop paywalling the Mindset content, or unbundle it — content free, habit slots paid, the exact inverse of today
- **This app does:** content paywalled, slots gated
- **User reaction:** complaint
- **Magnitude:** Mindset praise 6.78% → 1.20%
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `11010361389`, `11097642923`, `12819752757`
- **Canonical:** C194 Do not paywall content the user already bought elsewhere

### R16-075 — Redesign the trial's ending, not its length — the trial itself is well-liked (no auto-charge); what breaks is the cliff; options the corpus supports: taper (keep 3 habits free forever), warn earlier and in-app rather than by email (two reviewers never saw it coming), or preserve the streak read-only after expiry

- **Where:** §8.2 #10 Redesign the trial's ending, not its length — taper, warn earlier in-app, preserve the streak read-only
- **This app does:** hard cliff at day 28, email-only warning
- **User reaction:** 1★-burst
- **Magnitude:** bait-and-switch tripled to 7.23%
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13616010098`, `14046766451`
- **Canonical:** C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

## Must-haves

### R16-070 — Answer the seven support-failure and five billing reviewers and publish a support address in the app — two reviewers could not find any contact route and wrote the review instead; refunds refused on auto-renewals the customer did not use are producing the angriest writing and are cheap to reverse

- **Where:** §8.1 #5 Answer the support-failure and billing reviewers, and publish a support address in the app; refunds refused on unused auto-renewals are cheap to reverse
- **This app does:** no in-app support address; refunds refused
- **User reaction:** 1★-burst
- **Magnitude:** support 7 mean 2.14; billing 7 mean 1.43 (lowest theme)
- **Direction for us:** must-have · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `10977940087`, `10992497041`, `11011057187`, `12988241997`, `11990095414`, `12165173158`
- **Canonical:** C029 Billing must be exactly right; C036 A support channel that exists, is reachable outside the app, and answers

## Must never break

### R16-008 — Losing the subscription does not return you to a usable free tier: a former payer who deleted 3 of 4 habits 'still can't edit my 1 remaining habit, view detailed history, or even mark it completed. It's my habit for walking my dog, who is recently deceased… I guess the app is bricked for me now'; 'The copywriting even says we wouldn't leave you hanging! But then they left me hanging' — a churn mechanic that destroys the goodwill of the people most likely to come back

- **Where:** Part 0 §4 Losing the subscription does not return you to a usable free tier — 'the app is bricked for me now'
- **This app does:** lapsed subscription locks even the one free habit
- **User reaction:** 1★-burst
- **Magnitude:** 2 cited (one confirmed former payer)
- **Direction for us:** must-never-break · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `13573892543`, `11150554851`
- **Canonical:** C176 Never let fear of losing history be the reason people pay; C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

### R16-009 — Confirmed payers are the angriest group: they rate 1.21 stars below everyone else and are twice as likely to leave 1–2★ — every buyer already got past the price objection and a majority still wrote a negative review; five of the seven billing complaints in the whole corpus come from the seventeen who paid — 'I have now subscribed three separate times ($360 in total)… every day it says I do not have a paid account'; 'auto-charged for an annual renewal with no reminder and no warning… told it was my fault'; 'It looks like you are signing up for a free subscription of 28 days but they actually charge you right away'

- **Where:** Part 0 §5 Confirmed payers are the angriest group in the corpus; comparison table (verbatim); complaint table (verbatim)
- **This app does:** entitlement not recognised; auto-renewal without warning; refunds refused
- **User reaction:** 1★-burst
- **Magnitude:** 17 payers (1.46%) mean 2.41 vs 3.62; 1–2★ 58.8% vs 29.5%; 5★ 17.6% vs 50.2%; Complaint | In paid cohort | Global count of that theme ; Price / value still not justified | 10 (58.8%) | 392 ; Billing, refund or auto-renewal problem | 5 (29.4%) | 7 — 5 of the 7 are payers ; The 6-habit Pro cap | 4 (23.5%) | 75 ; Logging or sync broke while paying | 3 (17.6%) | 12 ; Data loss | 3 (17.6%) | 9
- **Direction for us:** must-never-break · **Report confidence:** meaningful, segment · **Generalisable:** yes
- **Review IDs:** `11015185142`, `12988241997`, `11990095414`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C065 Paying customers are the highest 1★ risk — every paid feature must work; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R16-017 — Reliability is worsening and is now the second story — the rate more than doubled; launch bugs were fixed within days ('There's no bug! Those were old reviews before the app was launched'), but 2025–26 failures are core-loop failures: the app freezes and will not get past habit creation (a live, unresolved onboarding failure fifteen months old, zero 5★), logging silently fails (including a payer: 'Randomly stopped updating when I tracked my habits. I pay for this app'), data/history loss (a payer lost a week of logs for all 6 habits), repeated forced logout after a two-factor change, and the app requires a live internet connection to tick a box ('I work in remote areas… I can't use the app')

- **Where:** Part 0 §10 Reliability is getting worse, not better — and it is now the second story; rate table (verbatim)
- **This app does:** network-required logging; onboarding freeze; silent log failure; forced logouts
- **User reaction:** 1★-burst
- **Magnitude:** 103 (8.82%, HIGH-PRIORITY) mean 2.45, 59.2% 1–2★; Period | Reliability-complaint rate ; P1 launch (Feb–Mar 2024) | 6.19% ; P2 rest of 2024 | 9.68% ; P3 2025 | 14.74% ; P4 2026 | 14.46% ; freeze at creation 31 (2.65%) mean 1.90, 0 5★, 15 dated 2025+; logging fails 12 (1.03%) mean 2.00; data loss 9 (0.77%) mean 2.78; forced logout 10 (0.86%) mean 2.10; needs internet 9 (0.77%) mean 2.56
- **Direction for us:** must-never-break · **Report confidence:** high-priority, rising · **Generalisable:** yes
- **Review IDs:** `10976173296`, `12492982373`, `12515484177`, `12539170479`, `13453138963`, `13724948462`, `13837724169`, `11858415210`, `13732701636`, `11928001093`, `10977084069`, `11339178421`
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one; C075 Skippable, replayable onboarding tour; C188 The app must open offline — never block launch on a network call

### R16-033 — Reliability and trust tail: account creation / sign-in broken (mean 1.50), widget problems, notification problems, support unreachable, privacy concern, US-centric date/time formats (no 24-hour clock, Sunday week start)

- **Where:** §3.1 #23 Account creation / sign-in broken; #26 Widget problems; #32 Notification problems; #34 Support unreachable; #36 Privacy concern; #37 US-centric date/time formats
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** sign-in 12 (1.03%) mean 1.50, 83.3% 1–2★; widget 11 (0.94%) 3.00; notifications 8 (0.68%); support 7 (0.60%) 2.14; privacy 5 (0.43%); date formats 3 (0.26%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful–weak · **Generalisable:** yes
- **Review IDs:** `10983726873`, `11001435276`, `11835036235`
- **Canonical:** C028 Culturally complete icon set and calendars; C035 Account system from day one; C036 A support channel that exists, is reachable outside the app, and answers; C039 Reminders fire reliably, once; C040 Widgets must not go blank, stale or disagree with the app; C077 Purchase and signup flow must not leak buyers; C085 Address tracking / privacy visibly

### R16-049 — At least 7 of 17 payers describe a broken post-purchase experience — entitlement not applied, charged unexpectedly / refund refused, data wiped while subscribed, locked out of the free tier after cancelling, price halved shortly after paying full; support is the aggravating factor in all of them, and the one counter-case is instructive: 'Update - Many thanks to dev team for reaching out!' — when support arrives, the review is edited upward; stated churn names Streaks, Apple Reminders or paper

- **Where:** §5.4 Post-purchase experience and churn table (verbatim); support is the aggravating factor in all of them; when support arrives the review is edited upward
- **This app does:** post-purchase failures; support unreachable
- **User reaction:** churn
- **Magnitude:** 7 of 17 (41.2% segment; 0.60% corpus); Failure | Payers | IDs ; Entitlement not applied after payment | 1 | `11015185142` (paid 3×, $360) ; Charged unexpectedly / refund refused | 3 | `11990095414` `12165173158` `12988241997` ; Data or history wiped while subscribed | 2 | `11858415210` `13837724169` ; Locked out of the free tier after cancelling | 1 | `13573892543` ; Price halved shortly after paying full price | 1 | `11846275530` ; support unreachable 7 (0.60%) mean 2.14; churn 55 (4.71%) mean 2.00, 10 name the alternative
- **Direction for us:** must-have · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `11015185142`, `11990095414`, `12165173158`, `12988241997`, `11858415210`, `13837724169`, `13573892543`, `11846275530`, `11011057187`
- **Canonical:** C029 Billing must be exactly right; C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back; C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

### R16-068 — Fix the freeze-on-first-habit-creation bug — ten dated instances describe the identical screen; it kills users at the moment of first value, before they have anything to lose, which is why it produces no partial credit

- **Where:** §8.1 #3 Fix the freeze-on-first-habit-creation bug — kills users at the moment of first value
- **This app does:** onboarding freeze
- **User reaction:** 1★-burst
- **Magnitude:** 31 mean 1.90, 74.2% 1–2★, zero 5★
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C075 Skippable, replayable onboarding tour

### R16-069 — Give the free tier back to cancelled subscribers and stop deleting their history — a cancelled subscriber who keeps a read-only history is a candidate for resubscription; one whose data is hostage is a 2★ review and a permanent loss

- **Where:** §8.1 #4 Give the free tier back to cancelled subscribers, and stop deleting their history
- **This app does:** lapsed payers locked out
- **User reaction:** churn
- **Magnitude:** n=1 (whole case)
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `13573892543`
- **Canonical:** C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

### R16-078 — Make logging work offline — a habit tracker that cannot tick a box on a plane, on a hike, or on patchy service is failing at its only job

- **Where:** §8.3 #13 Make logging work offline — a habit tracker that cannot tick a box on a plane is failing at its only job
- **This app does:** internet required to log
- **User reaction:** complaint
- **Magnitude:** 9 mean 2.56, zero 5★
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `10977084069`, `11339178421`, `13090001429`
- **Canonical:** C188 The app must open offline — never block launch on a network call

## Features

### R16-015 — The press-and-hold haptic completion loop is the product's genuine, defensible craft asset — 'Surprisingly satisfying to hold and fill the circle'; 'a satisfying hold while the circle expands ending with a vibrate reward… Pavlovian in a good way'; 'I'm beginning to crave that feeling' — and praise for it is decaying fast after a 2024 redesign replaced the floating circles with a list; three reviewers name the loss directly

- **Where:** Part 0 §8 The haptic completion loop is the product's genuine, defensible craft asset — and praise for it is decaying fast after a redesign
- **This app does:** press-and-hold fill + haptic; floating circles replaced by a list
- **User reaction:** praise
- **Magnitude:** 45 (3.85%) mean 4.02; 4.87% (P1) → 4.15% (P2) → 1.05% (P3) → 1.20% (P4)
- **Direction for us:** must-have · **Report confidence:** very strong, decaying · **Generalisable:** yes
- **Review IDs:** `10979085353`, `10989132915`, `10992749538`, `11343906321`, `11814577640`, `11390526677`, `11368755180`
- **Canonical:** C069 Check-off sound and haptic; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R16-018 — The two cheapest missing features, both sitting in the 3★/4★ band and neither shipped in 31 months: no dark mode — a high-goodwill request, the fastest-growing, framed by two reviewers as accessibility ('some of us can't read a blinding white screen… with such shoddy accessibility I would never pay'; 'My eyes hurt'); and no back-logging beyond yesterday — reviewers lose streaks they actually earned ('I accidentally lost my streak because I forgot to log my activity 2 days ago… permanently reset'; 'Especially for someone with ADHD who struggles with admin'; support refused to help create a habit in the past)

- **Where:** Part 0 §11 The two cheapest missing features: no dark mode (accessibility); no back-logging
- **This app does:** no dark mode; log only today and yesterday
- **User reaction:** complaint
- **Magnitude:** dark mode 21 (1.80%, MEANINGFUL) mean 3.76, 9.5% 1–2★, 0.29% → 2.76% → 5.26% → 3.61%; back-logging 33 (2.83%, MEANINGFUL) mean 3.39, 21.2% 1–2★
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11936034388`, `14138142114`, `11049027904`, `11245427777`, `12909615292`, `11572795669`
- **Canonical:** C010 Backfill missed days / edit start date; C080 Colour themes / dark mode; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R16-022 — Feature inventory: guided habit template ('I will [X] at [time] at [place] so I can become [identity]') free for 1 habit; press-and-hold haptic logging free; reminders free; further habits Pro (cap 6, 3 before ~11 Mar 2024); Mindset tab Pro (free at launch, paywalled by late Mar 2024); accountability partner Pro; widget widely buggy; detailed history Pro; focus session/timer from ~Sep 2024; Hall of Fame with no removal path; Spotify link; does not exist at any tier: back-logging beyond yesterday, undo/unlog, dark mode, any non-English language, iPad/Watch/Mac/Android, offline logging; Family Sharing asked once

- **Where:** §2.1 Feature inventory derived from reviews table (verbatim)
- **This app does:** see table
- **User reaction:** mixed
- **Magnitude:** Capability | Status in reviews | Evidence ; Create a habit via a guided template — *"I will [X] at [time] at [place] so I can become [identity]"* | Free (1 habit) | `10976218757` `14237890130` `11359141766` ; Log a habit by press-and-hold on a filling circle, with haptic feedback | Free | `10979085353` `10989132915` `10992749538` ; Reminders / notifications per habit | Free | `10976048976` `11291850970` ; A second and further habits | Pro — hard cap 6 (3 before ~11 Mar 2024) | `10975917055` `11033626383` `14287877372` ; Mindset tab — daily lesson, article library, Atoms 101, deep dives | Pro (free at launch, paywalled by late Mar 2024) | `10992375879` `11010361389` `11097642923` `12819752757` ; Accountability partner (invite a friend) | Pro | `11108307273` `11129229740` `13019922003` ; Home-screen widget | Free tier unclear; widely reported buggy | `10992039334` `11099243811` `12697625866` `13624195792` ; Progress tab, streak count, weekly calendar strip | Free for the one free habit; detailed history is Pro | `12959086974` `13573892543` ; Focus session / timer | Present from ~Sep 2024, tier unclear | `11749997696` `13596132382` ; "Hall of Fame" (archived completed habits) | Present, no removal path | `12430398320` ; Spotify link in focus mode | Present | `12554662027` `12135884025` ; Log a past day beyond yesterday | Does not exist at any tier | 33 reviews, §0.11 ; Undo / unlog a completion | Does not exist | 9 reviews, `11094114464` `11113140619` ; Dark mode | Does not exist | 21 reviews, §0.11 ; Any language other than English | Does not exist | 36 reviews, §6.3 ; iPad-native layout, Apple Watch app, Mac app, Android | None exist | `10990662644` `11039055527` `11518976489` `11207909936` `13453138963` ; Offline logging | Does not exist — a live connection is required to tick a box | 9 reviews, §0.10 ; Family Sharing | Not present; asked for once | `10983856203`
- **Direction for us:** research · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `10976218757`, `10979085353`, `10976048976`, `10975917055`, `10992375879`, `11108307273`, `10992039334`, `12959086974`, `11749997696`, `12430398320`, `12554662027`, `11094114464`, `10990662644`, `11207909936`, `10983856203`
- **Canonical:** — (nuance register)

### R16-023 — Smaller inventory findings: a guided implementation-intention template for creating a habit; an accountability partner (invite a friend) behind Pro; a 'Hall of Fame' archive with no removal path; no undo/unlog of a completion

- **Where:** §2.1 Guided habit template — 'I will [X] at [time] at [place] so I can become [identity]'; Accountability partner (Pro); Hall of Fame with no removal path; Undo / unlog does not exist
- **This app does:** template free; partner Pro; no undo
- **User reaction:** mixed
- **Magnitude:** undo 9 reviews; partner 3 IDs; hall of fame 1
- **Direction for us:** research · **Report confidence:** small · **Generalisable:** yes
- **Review IDs:** `10976218757`, `11108307273`, `11129229740`, `13019922003`, `12430398320`, `11094114464`, `11113140619`
- **Canonical:** C015 Shared / group habits; C041 Editing a habit never wipes its history

### R16-030 — The habit model is too rigid: time-locked habits, no habit stacking, no 'X times a week on any day', no bad-habit/quit mode, no end dates, no multiple logs per day

- **Where:** §3.1 #11 Habit model too rigid (time-locked, no stacking, no flexible frequency); §3.3 #7 A flexible habit model
- **This app does:** one time-locked daily habit template
- **User reaction:** complaint
- **Magnitude:** 39 (3.34%, VERY STRONG) mean 3.21, 33.3% 1–2★
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C019 Quit-habit / bad-habit mode; C043 Flexible / custom frequency; C143 Intra-day completion: tap N times to fill N/N; C173 Sub-tasks / sub-routines nested inside a habit or routine

### R16-031 — UX themes: confusing / over-designed; weak progress visualisation — 'Reading a sentence about my progress doesn't feel as rewarding as seeing a visual tracker'; wants colour and reordering customisation; animation/loading friction

- **Where:** §3.1 #14 Confusing / over-designed UX; #21 Weak progress visualisation / no real calendar; #22 Wants customisation; #33 Animation / loading friction
- **This app does:** sentence-based progress; heavy animation
- **User reaction:** complaint
- **Magnitude:** confusing 35 (3.00%) mean 2.80; visualisation 15 (1.28%) mean 2.67; customisation 14 (1.20%) mean 3.64; animation friction 7 (0.60%) mean 2.57
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11052153505`, `11007997431`, `13681275543`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C012 Week / month / year grid views; C057 Offer a non-pastel / premium design option

### R16-032 — The accountability partner (invite a friend, Pro) is praised and its limits complained about — multiple partners, seeing a partner's recent progress, random matching

- **Where:** §3.1 #20 Accountability-partner limits; positive #10 Accountability partner; §3.3 #11 More / better accountability partners
- **This app does:** one partner, Pro
- **User reaction:** mixed
- **Magnitude:** limits 15 (1.28%) mean 3.27; positive 13 (1.11%) mean 3.62
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11129229740`, `13276061916`, `11749997696`
- **Canonical:** C015 Shared / group habits

### R16-038 — Every request ranked: raise the free cap 1 → 3 (repeatedly three, not 'free everything'), raise the Pro cap 6 → unlimited (several name 10–15), a one-time/lifetime SKU (the most-repeated counter-proposal), a cheaper tier, localisation (Spanish 14, Turkish 4, Russian 3, French 3, German 2…), back-logging, a flexible habit model, dark mode, customisation, a real calendar, better accountability partners, offline logging, undo, iPad/Watch/Mac/Android, integrations (Health, Garmin, Spotify), 24-hour clock / non-Sunday week start

- **Where:** §3.3 Unmet needs — every request in the corpus, ranked table (verbatim); free cap 1 → 3 is what they ask for, not free everything
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** Rank | Request | n | Mean | What they actually want ; 1 | Raise or remove the free cap (1 → 3) | 76 | 2.22 | Not "free everything" — repeatedly, three: `10975505569` `10988610880` `11749997696` `13838905269` ; 2 | Raise or remove the Pro cap (6 → unlimited) | 75 | 2.57 | Several name 10–15; `13573785597` wants 15, `13709994614` wants "6/area" ; 3 | A one-time / lifetime purchase SKU | 37 | 2.16 | The single most-repeated monetisation counter-proposal ; 4 | A cheaper or intermediate tier | 53 | 2.36 | Explicit proposals: mid tier (`10983501760`), student plan (`13456206729`), scholarship (`11095912492`), regional (`11001435276`) ; 5 | Localisation | 36 | 3.44 | Spanish (14), Turkish (4), Russian (3), French (3), German (2), Arabic, Thai, Chinese, Italian, Portuguese ; 6 | Back-logging past days | 33 | 3.39 | Log any past date; import an existing streak ; 7 | A flexible habit model | 39 | 3.21 | Habit stacking, "X times a week on any day", no forced time, bad-habit/quit mode, end dates, multiple logs per day ; 8 | Dark mode | 21 | 3.76 | Cheapest goodwill in the corpus ; 9 | Customisation — colours, reordering | 14 | 3.64 | `11007997431` `13681275543` ; 10 | Better progress visualisation / a real calendar | 15 | 2.67 | `11052153505`: *"Reading a sentence about my progress doesn't feel as rewarding as seeing a visual tracker"* ; 11 | More / better accountability partners | 15 | 3.27 | Multiple partners (`11129229740`), see partner's recent progress (`13276061916`), random matching (`11749997696`) ; 12 | Offline logging | 9 | 2.56 | Should be table stakes for a habit tracker ; 13 | Undo a logged completion | 9 | 3.11 | ; 14 | iPad / Watch / Mac / Android | 10 | 3.50 | iPad 4, Watch 4, Android 1, Mac 1 ; 15 | Integrations (Health, Garmin, Spotify, other trackers) | 6 | 3.83 | `10984353099` `13076289855` `12135884025` ; 16 | 24-hour clock / non-Sunday week start | 3 | 2.33 | `10983726873` `11001435276` `11835036235`
- **Direction for us:** build-free · **Report confidence:** verbatim · **Generalisable:** yes
- **Review IDs:** `10975505569`, `10988610880`, `11749997696`, `13838905269`, `13573785597`, `13709994614`, `10984353099`, `13076289855`, `12135884025`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C010 Backfill missed days / edit start date; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C027 Localise early — it unlocks revenue; C043 Flexible / custom frequency; C080 Colour themes / dark mode; C141 Native iPad layout; C188 The app must open offline — never block launch on a network call; C191 Never cap the tier someone has already paid for

### R16-076 — Ship back-logging — a request from people who mostly still like the app, in the two bands where ratings are cheapest to move; reviewers also want to import an existing streak

- **Where:** §8.3 #11 Ship back-logging and streak import
- **This app does:** log today/yesterday only
- **User reaction:** complaint
- **Magnitude:** 33 mean 3.39, 21.2% 1–2★; 9.8% of 4★, 7.4% of 3★
- **Direction for us:** build-free · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `12014435210`, `12259757598`, `11128803895`
- **Canonical:** C010 Backfill missed days / edit start date

### R16-077 — Ship dark mode — the fastest-growing feature request, framed as accessibility by two reviewers; one setting

- **Where:** §8.3 #12 Ship dark mode — one setting
- **This app does:** no dark mode
- **User reaction:** complaint
- **Magnitude:** 21 mean 3.76
- **Direction for us:** build-free · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C080 Colour themes / dark mode

### R16-079 — Loosen the habit model — the third-fastest-growing negative: allow 'X times a week, any day', habits with no fixed time, multiple logs per day, habit STACKING (which the book is famous for and the app does not implement), and editable identity phrasing

- **Where:** §8.3 #14 Loosen the habit model — X times a week any day, no fixed time, multiple logs per day, habit stacking, editable identity phrasing
- **This app does:** time-locked daily template; no stacking
- **User reaction:** complaint
- **Magnitude:** 39 (3.34%); 2.51% → 7.23%
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `11569901162`, `14201996700`, `11018442332`, `11007001740`, `14237890130`, `11015467978`, `11087707385`, `11383246654`, `13517748845`, `11490817427`, `11402101270`, `11764648914`, `12228073166`
- **Canonical:** C043 Flexible / custom frequency; C143 Intra-day completion: tap N times to fill N/N; C173 Sub-tasks / sub-routines nested inside a habit or routine

## Monetization

### R16-010 — The price fell by roughly two-thirds ($16.99/mo and $119.99/yr at launch → $69.99/yr Jun 2024 → $40/yr 2026) and the price-objection rate barely moved; only 6 reviews acknowledge the drop and five of those are still 1–2★ ('$70 a year still seems over priced') — the objection is not to the number, it is to the shape: 'I will not rent a checklist'

- **Where:** Part 0 §6 The price came down twice and the corpus barely noticed; price table (verbatim)
- **This app does:** $119.99/yr → $69.99 → $40; monthly $16.99 → $4.99–6
- **User reaction:** complaint
- **Magnitude:** Period | Monthly | Annual | Evidence ; Feb–Mar 2024 (launch) | $16.99 / £17.99 / €20 / A$25 | $119.99 / £119.99 / €129 / A$200 / C$150 / CHF 120 | `10960582078` `10975518449` `10983462054` `10985727014` `11002040769` `10983076235` ; Jun 2024 (announced by email, 4 Jun) | $9.99 / €9.99 | $69.99 | `11345550974` `11346837271` `11438714327` ; Late 2024 | $4.99 seen | $70–80 · ¥10,000 (JP, halved from ¥18,000) | `12006236731` `11846275530` `12073746265` ; 2025 | ~$6 / £6 | $70 / £70 / €80 | `12545506654` `12600470632` `13116954440` `13182902229` ; 2026 | ~$5 / £10 | $40 / £70 / ~€100 | `14287877372` `13853134874` `13655994377` `14089377229` ; price-objection 30.97% (P1) → 50.69% (P2) → 24.74% (P3) → 30.12% (P4); 6 (0.51%) acknowledge drop, 5 still 1–2★
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10960582078`, `10975518449`, `11345550974`, `11346837271`, `11438714327`, `12006236731`, `12545506654`, `14287877372`, `11980741663`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R16-011 — Reviewers ask for a different shape, not a lower number: a one-time or lifetime purchase ('I would gladly pay a one-time $20 for just the habit tracking, but that's not an option'; 'Procreate is a one time purchase of £12… Built once, pay once. £10 per month is insane'; 'WHY isn't there a lifetime subscription option??? Pay 125$ once') and a cheaper tier, student rate or discount

- **Where:** Part 0 §6 37 reviews ask for a one-time or lifetime purchase; 53 ask for a cheaper tier, student rate or discount
- **This app does:** subscription only
- **User reaction:** blocked-conversion
- **Magnitude:** one-time 37 (3.17%, VERY STRONG) mean 2.16; cheaper tier / student / discount 53 (4.54%, VERY STRONG)
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13613868361`, `12356777390`, `11685719155`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C025 Scholarship / hardship / discount program; C064 Price level — where 'fair' turns into 'too expensive'

### R16-024 — Two things are genuinely well designed and reviewers say so: the 28-day full-Pro trial requires no card and does not auto-charge ('I respect that the app doesn't force you to subscribe to get the free trial… Moral behavior is noticed and appreciated!'), and there is almost no upsell nagging — an unusually low rate for a subscription app

- **Where:** §2.2 Monetisation model — the trial does not auto-charge; there is almost no upsell nagging
- **This app does:** no-card 28-day trial; no nag
- **User reaction:** praise
- **Magnitude:** nag complaints only 8 (0.68%); 3 cited praise IDs
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10986971491`, `11061933855`, `10985371106`
- **Canonical:** C063 Free trial before purchase; C093 No upsell nagging without a 'never ask again' option

### R16-026 — Highest reported prices: A$200/yr, £215/yr if billed monthly, C$150/yr, CHF 120/yr, ¥18,000/yr; lowest: $40/yr (Mar 2026) and $5/mo (Jul 2026); no one-time purchase has ever existed

- **Where:** §2.2 Prices reported by reviewers — highest and lowest
- **This app does:** subscription only, monthly or annual
- **User reaction:** complaint
- **Magnitude:** 6 cited IDs
- **Direction for us:** research · **Report confidence:** reported · **Generalisable:** app-specific
- **Review IDs:** `11002040769`, `10985301089`, `11113968468`, `10990115203`, `11846275530`, `13853134874`, `14287877372`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R16-029 — The subscription model itself draws a high-priority objection and stated churn is very strong, while a small group says the price is fair — every one of them 5★

- **Where:** §3.1 #2 Subscription model objection; #7 Stated churn / uninstall; #9 Price is fair / good value (positive)
- **This app does:** subscription only
- **User reaction:** mixed
- **Magnitude:** sub objection 136 (11.64%) mean 2.32; churn 55 (4.71%) mean 2.00, 76.4% 1–2★; price fair 17 (1.46%) mean 5.00
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R16-044 — The confirmed-payer cohort, line by line: two 5★ brand-trust buyers, one who paid three times ($360) and never got the entitlement, buyers who hit the 6-cap, a £/¥ buyer whose price halved shortly after ('the only benefit I received was three extra months'), a yearly buyer whose week of history was wiped, refund refusals, an auto-renewal with no warning, a cancelled user bricked out of the free tier, a payer whose logging stopped, and a monthly payer expecting 'some content other than the content of the book'

- **Where:** §5.1 The confirmed-payer cohort — 17 reviewers table (verbatim); cohort statistics; by period; by storefront
- **This app does:** subscription
- **User reaction:** churn
- **Magnitude:** 17 (1.46%) mean 2.41; 5★ 3 · 4★ 1 · 3★ 3 · 2★ 3 · 1★ 7 (41.2%); by period 0.44% → 2.76% → 3.16% → 2.41%; US 11, GB 2, DE 1, IN 1, JP 1, MX 1; high-spend 1.80% vs 0.60%; ID | Country | ★ | Date | What they said ; `10983459334` | US | 5 | 2024-02-27 | *"I've already signed up for PRO version because I know this will get daily use"* ; `11001807368` | US | 5 | 2024-03-03 | *"I didn't need to wait to upgrade to the Pro, where I can add & track 2 more habits"* ; `11015185142` | US | 1 | 2024-03-06 | Paid three times ($360), entitlement never applied, could not reach anyone ; `11335015431` | US | 3 | 2024-06-02 | *"So I signed up for premium… I tried to add more habits after that. I couldn't."* ; `11440730982` | GB | 2 | 2024-06-30 | *"I actually did pay for a while but… I ended up cancelling my monthly subscription"* ; `11846275530` | JP | 1 | 2024-10-18 | Paid ¥18,000/yr at launch; price halved to ¥10,000; *"the only benefit I received was three extra months"* ; `11858415210` | GB | 5 | 2024-10-21 | Bought yearly within weeks of launch; app then wiped a week of history across all 6 habits ; `11990095414` | US | 1 | 2024-11-25 | Charged immediately, refused refund ; `12102686500` | IN | 2 | 2024-12-25 | Bought at ~$75/yr, cancelled, saw renewal offered at half price, did not renew ; `12165173158` | US | 1 | 2025-01-10 | *"I asked for a refund and was denied"* ; `12555745003` | US | 1 | 2025-04-18 | *"I paid the outrageous premium price… It's also extremely buggy"* ; `12859435506` | MX | 3 | 2025-07-06 | Paid a few months, stopped: *"it's too expensive to keep paying"* ; `12988241997` | US | 1 | 2025-08-07 | Auto-renewed a year later with no warning, refund refused, disputing the charge ; `13573785597` | US | 3 | 2025-12-30 | Bought premium specifically for more habits, hit the 6 cap ; `13573892543` | US | 2 | 2025-12-30 | Cancelled, then locked out of the free tier entirely — *"the app is bricked for me now"* ; `13837724169` | US | 1 | 2026-03-11 | *"Randomly stopped updating when I tracked my habits. I pay for this app"* ; `14201996700` | DE | 4 | 2026-06-19 | Paying monthly; the app works; *"The Ugly: I'm paying… so I'm expecting some content other than the content of the book"*
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10983459334`, `11001807368`, `11015185142`, `11335015431`, `11440730982`, `11846275530`, `11858415210`, `11990095414`, `12102686500`, `12165173158`, `12555745003`, `12859435506`, `12988241997`, `13573785597`, `13573892543`, `13837724169`, `14201996700`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

### R16-046 — Reviewers' own reservation prices cluster far below every price Atoms has charged: $8–$30 one-time, $2–$5 a month, $15–$60 a year — the modal counter-offer is a one-time purchase between $10 and $30, which Atoms has never offered

- **Where:** §5.3 Barrier 1 — the annual price at every price point; stated willingness-to-pay table (verbatim); the modal counter-offer is a one-time purchase between $10 and $30
- **This app does:** $40–120/yr subscription
- **User reaction:** blocked-conversion
- **Magnitude:** Stated willingness to pay | Reviewers ; $8–$30 one-time | `10989617169`($12/yr or $30 once) `11089032952`($20 lifetime) `12600470632`($8 once) `13613868361`($20 once) `12073746265`(€15 lifetime) `12119950937`($20) ; $2–$5 / month | `10985973020` `11090921707`($5) `11112458066`(€3–5) `11749997696`($3) `10993506021`(€2) `11054245890`($0.99–1.99) ; $15–$60 / year | `11260133910`($25–29) `11494012970`(<$60) `11369268665`($50) `12377474964`($15) `13395934202`($20–30) `11000421781`($60) `11108307273`($50)
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10989617169`, `11089032952`, `12600470632`, `13613868361`, `12073746265`, `12119950937`, `10985973020`, `11090921707`, `11112458066`, `11749997696`, `10993506021`, `11054245890`, `11260133910`, `11494012970`, `11369268665`, `12377474964`, `13395934202`, `11000421781`, `11108307273`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R16-071 — Ship a one-time / lifetime SKU — the price has already fallen ~67% with no measurable effect on the objection rate, the strongest available evidence that the problem is the shape not the number; reviewer-stated reservation prices cluster at $10–$30 one-time, a band testable immediately

- **Where:** §8.2 #6 Ship a one-time / lifetime SKU — the problem is the shape, not the number
- **This app does:** subscription only
- **User reaction:** blocked-conversion
- **Magnitude:** 37 (3.17%) mean 2.16; Streaks named 8×; objection 30.97% → 30.12%
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

## Tactics the app used

### R16-073 — Recognise book buyers with a code, a barcode scan, a discount or a free month — reviewers propose the mechanism themselves; no reviewer bought the book and felt the app respected that, eighteen felt the opposite

- **Where:** §8.2 #8 Recognise book buyers — a code, a barcode scan, a discount or free month
- **This app does:** no book-buyer recognition
- **User reaction:** blocked-conversion
- **Magnitude:** 18 (1.54%) mean 2.61
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** app-specific
- **Review IDs:** `11097642923`, `12513582477`, `10983993222`
- **Canonical:** C025 Scholarship / hardship / discount program; C060 Cross-sell an app family on brand trust

## Insights (the why)

### R16-013 — What people love is content and craft, not tracking: simplicity (zero 1–2★), design/animation, the James Clear brand halo (mean 4.90 when 4–5★), the Mindset tab / daily lessons / articles, identity framing ('cast a vote for the person you want to become'), life change

- **Where:** Part 0 §8 What people actually love — and it is not the tracker: simplicity; design; the James Clear brand halo; Mindset tab; identity framing; life change
- **This app does:** brand-led content + crafted UI
- **User reaction:** praise
- **Magnitude:** simplicity 183 (15.67%) mean 4.73, 82.0% 5★, zero 1–2★; design 179 (15.33%) mean 3.49; brand references 435 (37.24%), halo 268 (22.95%) mean 4.90, 90.3% 5★; Mindset 59 (5.05%) mean 4.07; haptics 45 (3.85%) 4.02; identity 35 (3.00%) 4.43; life change 72 (6.16%) 4.49
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C070 Use the language users use: Atomic Habits, 75 Hard; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R16-014 — Design praise is the most rating-agnostic theme: 31% of design-praise reviews are 1–2★ — people complimenting the craft on the way out the door ('It's a beautifully designed app with some lovely haptic elements. However it's light on substance, especially for the price')

- **Where:** Part 0 §8 Design praise is the most rating-agnostic theme — people complimenting the craft on the way out the door
- **This app does:** beautiful UI behind a resented paywall
- **User reaction:** mixed
- **Magnitude:** 56 of 179 design-praise reviews 1–2★ (31.3%); design + price objection 85 reviews mean 2.36
- **Direction for us:** insight · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10993476523`, `10984334544`
- **Canonical:** C185 Aesthetic and a polished onboarding convert; they do not retain

### R16-025 — Both assets are destroyed by the shape of the drop-off: a no-pressure trial that ends in an unusable free tier reads to reviewers as a WORSE trick than a nagging one, because they only discover the wall after three weeks of investment

- **Where:** §2.2 Both assets are destroyed by the shape of the drop-off — a no-pressure trial that ends in an unusable free tier reads as a worse trick than a nagging one
- **This app does:** 28-day trial → 1-habit tier
- **User reaction:** 1★-burst
- **Magnitude:** bait-and-switch 41 (3.51%)
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

### R16-037 — The corpus is bimodal and the middle is hollow: half the corpus is a five and 30% is a one-or-two; the 4★ band is the smallest — the signature of a product where the decision is binary (accept the model and love it, or hit the wall and reject it); Atoms has 3.8× HabitKit's one-star rate on a product reviewers describe as better-designed

- **Where:** §3.2 The corpus is bimodal, and the middle is hollow; contrast with HabitKit
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★ 49.74%, 4★ 8.73% (smallest), 1–2★ 29.97%; HabitKit 78.5% 5★ / 4.7% 1★ mean 4.56
- **Direction for us:** product-rule · **Report confidence:** structural · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C147 Let people use the product before they pay

### R16-041 — The 5★ recipe is 'I love Atomic Habits, this is the official app, it's beautiful and simple, and it works' — brand trust is doing 42% of the work; a 5★ here is not evidence of a healthy product: 29 five-star reviews still object to the price, 13 still hit the Pro cap, and 9 believe the app is free ('I can't believe all of it's been free?' — a user who has not yet reached day 28)

- **Where:** §4.1 5★ — brand trust is doing 42% of the work; a 5★ here is not evidence of a healthy product
- **This app does:** brand-led
- **User reaction:** praise
- **Magnitude:** 5★ n=581; brand halo 242 (41.7% of 5★); simplicity 150 (25.8%); price objection 29; Pro cap 13; believes free 9
- **Direction for us:** none · **Report confidence:** band analysis · **Generalisable:** app-specific
- **Review IDs:** `13019922003`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C070 Use the language users use: Atomic Habits, 75 Hard

### R16-042 — The 4★ band is not 'one missing feature' but 'I would give five but for the price' ('Love this atomic app - but too rich for my budget'); 3★ is a price band not a quality band (only 15% about the app working badly); 2★ is 72.5% price; more than seven in ten 1★ reviews are a packaging decision, not a product defect

- **Where:** §4.1 4★ — the smallest band, and it is a pricing band; 3★ — almost entirely money; 2★; 1★ — more than seven in ten are a packaging decision
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 4★ price 31 (30.4%); 3★ price 76 (56.3%), broken 20 of 135 (14.8%); 2★ price 103 (72.5%); 1★ price 153 (73.6%), cash-grab 50 (24.0%), freeze 15 (7.2%), design praise inside 1★ 26 (12.5%)
- **Direction for us:** product-rule · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `10988655507`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C064 Price level — where 'fair' turns into 'too expensive'

### R16-045 — Only four purchase triggers: brand trust bought sight-unseen (the only trigger producing 5★ — subscribed on day 3); hitting the 1-habit wall — and both such buyers then hit the 6-cap and rated 3★ (buying to escape a cap and finding another cap is the clearest conversion trap); sunk cost after the trial ('I had gotten so invested… it felt like a let down'); a price drop (exactly one upgraded rating); there is no trigger in the shape 'I tried the free tier for weeks and then decided to buy' — a 1-habit tier cannot produce it

- **Where:** §5.2 What made people pay — four triggers, three weak; no 'tried the free tier for weeks then bought' trigger exists
- **This app does:** brand trust; cap escape; sunk cost
- **User reaction:** purchase-driver
- **Magnitude:** 17 payers; 2 brand 5★; 2 cap-escape 3★; 1 price-drop
- **Direction for us:** product-rule · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10983459334`, `11858415210`, `13573785597`, `11335015431`, `12482534390`, `13616010098`, `11980741663`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C060 Cross-sell an app family on brand trust; C191 Never cap the tier someone has already paid for; C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

### R16-047 — Subscription aversion is a category position, not generic grumbling: reviewers argue a habit app specifically should not be a subscription because it has no running cost — 'Subscriptions make sense if there is running cost associated with an application but this isn't the case here'; 'the app is built once and from then only needs basic maintenance'; 'The irony in that the book encourages you to cancel subscriptions yet pushes its own'

- **Where:** §5.3 Barrier 2 — subscription aversion as a category position: a habit app specifically should not be a subscription because it has no ongoing cost
- **This app does:** subscription
- **User reaction:** complaint
- **Magnitude:** 136 (11.64%) mean 2.32
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13182902229`, `11685719155`, `11667634559`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'

## Audiences

### R16-036 — ADHD / neurodivergent / depression self-identification is rare in this corpus

- **Where:** §3.1 cross-cutting ADHD / neurodivergent / depression self-identified [limited evidence]
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 7 (0.60%) mean 3.86 [limited evidence]
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `11572795669`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

## Markets and languages

### R16-034 — A regional pricing / purchasing-power objection exists at emerging band — explicit proposals for a mid tier, student plan, scholarship and regional pricing

- **Where:** §3.1 #25 Regional pricing / purchasing-power objection
- **This app does:** single global price
- **User reaction:** complaint
- **Magnitude:** 11 (0.94%, emerging) mean 2.73
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10983501760`, `13456206729`, `11095912492`, `11001435276`
- **Canonical:** C025 Scholarship / hardship / discount program; C092 Regional pricing

### R16-048 — Regional pricing objections are the most detailed in the corpus — a Peruvian reviewer computes that 69.90 PEN is 6.82% of the minimum wage and the PPP-adjusted price should be ~16.42 PEN; an Indian reviewer tried 30–40 times to subscribe via UPI and could not (a lost sale from someone who wanted to pay); book buyers expected recognition

- **Where:** §5.3 Barrier 5 — regional pricing; Barrier 6 — a willing buyer could not complete the purchase (UPI); Barrier 7 — no book-buyer recognition
- **This app does:** single global price; UPI payments fail
- **User reaction:** blocked-conversion
- **Magnitude:** regional 11 (0.94%); UPI n=1 [limited evidence]; book-buyer 18 (1.54%)
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11001435276`, `10983856203`, `10996090984`, `12513582477`, `13456206729`, `11390526677`, `11261255351`
- **Canonical:** C025 Scholarship / hardship / discount program; C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C092 Regional pricing

### R16-051 — The four eligible storefronts compared on 18 themes, with country-level signal labels

- **Where:** §6.1 The four eligible storefronts table (verbatim); Signal labels applied at country level table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | US | GB | CA | AU | Global ; n (% of corpus) | 542 (46.4%) | 103 (8.8%) | 73 (6.3%) | 52 (4.5%) | 1,168 ; Mean rating | 3.71 | 3.20 | 3.21 | 3.50 | 3.60 ; 1–2★ | 28.8% | 42.7% | 37.0% | 32.7% | 30.0% ; 5★ | 55.0% | 37.9% | 38.4% | 51.9% | 49.7% ; Price objection | 27.68% | 49.51% | 50.68% | 34.62% | 33.56% ; Cash-grab / moral language | 5.90% | 4.85% | 15.07% | 7.69% | 5.91% ; Subscription objection | 8.86% | 16.50% | 16.44% | 9.62% | 11.64% ; Free 1-habit cap | 7.01% | 10.68% | 12.33% | 3.85% | 6.51% ; Pro cap | 7.75% | 7.77% | 5.48% | 3.85% | 6.42% ; Wants one-time purchase | 2.77% | 3.88% | 6.85% | 1.92% | 3.17% ; Wants a cheaper tier | 3.87% | 6.80% | 9.59% | 0.00% | 4.54% ; Bait-and-switch | 3.87% | 3.88% | 6.85% | 1.92% | 3.51% ; Stated churn | 4.24% | 8.74% | 8.22% | 7.69% | 4.71% ; Brand betrayal | 1.66% | 0.97% | 0.00% | 5.77% | 1.37% ; Design praise | 13.47% | 25.24% | 8.22% | 19.23% | 15.33% ; Simplicity praise | 16.05% | 15.53% | 20.55% | 26.92% | 15.67% ; Mindset content praise | 6.83% | 3.88% | 4.11% | 1.92% | 5.05% ; Confirmed payers | 2.03% | 1.94% | 0.00% | 0.00% | 1.46% ;; Finding | US (n=542) | GB (n=103) | CA (n=73) | AU (n=52) ; Price objection | 27.68% HIGH | 49.51% HIGH | 50.68% HIGH | 34.62% HIGH ; Subscription objection | 8.86% HIGH | 16.50% HIGH | 16.44% HIGH | 9.62% HIGH ; Free 1-habit cap | 7.01% HIGH | 10.68% HIGH | 12.33% HIGH | 3.85% VERY STRONG ; Pro cap | 7.75% HIGH | 7.77% HIGH | 5.48% HIGH | 3.85% VERY STRONG ; Cash-grab language | 5.90% HIGH | 4.85% VERY STRONG | 15.07% HIGH | 7.69% HIGH ; Stated churn | 4.24% VERY STRONG | 8.74% HIGH | 8.22% HIGH | 7.69% HIGH ; Wants one-time purchase | 2.77% MEANINGFUL | 3.88% VERY STRONG | 6.85% HIGH | 1.92% MEANINGFUL ; Brand betrayal | 1.66% MEANINGFUL | 0.97% Emerging | 0.00% — none | 5.77% HIGH ; Freeze / stuck loading | 2.95% MEANINGFUL | 3.88% VERY STRONG | 1.37% MEANINGFUL | 1.92% MEANINGFUL
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R16-052 — US is the biggest and least price-hostile eligible market — highest 5★, highest Mindset praise, the only market with a meaningful confirmed-payer population, and the source of nearly every back-logging, dark-mode and habit-model request; its friction is feature-shaped as much as price-shaped, though 68 of the 153 price-driven 1★ are American

- **Where:** §6.1 US — the least price-hostile eligible market; friction is feature-shaped as much as price-shaped
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** US 542: mean 3.71, 5★ 55.0%, price 27.68% vs GB 49.5% / CA 50.7%, Mindset 6.83%, payers 11 of 17
- **Direction for us:** research · **Report confidence:** eligible · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R16-053 — GB is the worst eligible market — lowest mean, highest 1–2★, lowest 5★ — and simultaneously the market with the highest design praise anywhere: British reviewers like the app more and buy it less than anyone; the GBP launch price was the harshest reported (£17.99/month, £215/year billed monthly) and GB reviewers quote it more precisely than any other market

- **Where:** §6.1 GB — the worst eligible market; British reviewers like the app more and buy it less than anyone
- **This app does:** £17.99/mo launch price
- **User reaction:** 1★-burst
- **Magnitude:** GB 103: mean 3.20, 1–2★ 42.7%, 5★ 37.9%, design praise 25.24%, price 49.51%
- **Direction for us:** research · **Report confidence:** eligible · **Generalisable:** app-specific
- **Review IDs:** `10985301089`, `10983462054`, `10984285648`, `10984727994`, `10988031483`, `10995055502`, `11013822277`, `11043323186`, `11051827720`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C064 Price level — where 'fair' turns into 'too expensive'

### R16-054 — Canada is the moral-objection market: highest price-objection and cash-grab rates (2.5× global), highest lifetime-purchase and cheaper-tier demand, highest bait-and-switch, lowest design praise — Canadians are least likely to soften criticism with a compliment; the two most-voted reviews in the corpus are Canadian (a structured three-point business critique; 'Don't get Pro… Buy the Atomic Habits book and use the free version alongside it'); zero confirmed payers in 73 reviews

- **Where:** §6.1 CA — the moral-objection market; the two most-voted reviews in the corpus are Canadian
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** CA 73: price 50.68%, cash-grab 15.07%, one-time 6.85%, cheaper tier 9.59%, bait-and-switch 6.85%, design praise 8.22%, payers 0
- **Direction for us:** research · **Report confidence:** eligible · **Generalisable:** app-specific
- **Review IDs:** `10979802836`, `10978295534`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C062 Weight English-speaking rich markets; volume ≠ revenue

### R16-055 — Australia is the brand-damage market: highest simplicity praise and a healthy 5★ share, but the highest brand-betrayal rate anywhere (HIGH-PRIORITY at country level, including 'How to ruin your brand overnight'); A$200/year is the highest annual figure in any currency; zero cheaper-tier requests — Australians did not negotiate, they left

- **Where:** §6.1 AU — the brand-damage market; Australians did not negotiate, they left
- **This app does:** A$200/yr launch price
- **User reaction:** churn
- **Magnitude:** AU 52: simplicity 26.92%, 5★ 51.9%, brand betrayal 5.77% (3 of 16 global), cheaper-tier 0.00%
- **Direction for us:** research · **Report confidence:** eligible · **Generalisable:** app-specific
- **Review IDs:** `11044837304`, `11002040769`, `10983653724`, `10990130470`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C195 Premium pricing on a trust-based personal brand spends the brand

### R16-056 — Three findings, the first counter-intuitive: the price backlash is STRONGER in high-spend markets — not affordability but value comparison (high-spend reviewers price Atoms against Netflix, Spotify, Notion, Procreate and Streaks by name and say 'not worth it at any price'; lower-spend markets say 'too expensive for my country'); the rest of the world's complaint is language (8.8× the localisation rate); buyers are 3× concentrated in high-spend markets (directional only)

- **Where:** §6.2 High-spend markets table (verbatim); the price backlash is stronger in high-spend markets — a value-comparison effect; rest of world's complaint is language
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | High-spend (n=835, 71.5%) | Rest of world (n=333, 28.5%) ; Mean | 3.53 | 3.78 ; 1–2★ | 32.8% | 22.8% ; 5★ | 49.1% | 51.4% ; Price objection | 35.33% | 29.13% ; Cash-grab language | 6.71% | 3.90% ; Free 1-habit cap | 7.54% | 3.90% ; Pro cap | 7.19% | 4.50% ; Wants one-time purchase | 3.59% | 2.10% ; Wants a cheaper tier | 4.91% | 3.60% ; Stated churn | 5.63% | 2.40% ; Regional-pricing objection | 0.36% | 2.40% ; Localisation request | 0.96% | 8.41% ; Confirmed payers | 1.80% | 0.60%
- **Direction for us:** product-rule · **Report confidence:** group (labelled assumption) · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue; C062 Weight English-speaking rich markets; volume ≠ revenue; C064 Price level — where 'fair' turns into 'too expensive'

### R16-057 — The 66 small storefronts rate Atoms 0.22 stars higher, complain about price less, and are the overwhelming majority of the language problem: all 36 localisation requests — Spanish 14, Turkish 4 (a Turkish 5★ that is only a request for Turkish is the 5th most-voted review), Russian 3, French 3, German 2, plus singles; a Spanish user uninstalled over it; the book is published in ~60 languages and the app in one — the single widest gap between brand reach and product reach in the corpus

- **Where:** §6.3 High-review-volume storefronts table (verbatim); the localisation gap is a market-access problem; the book is in ~60 languages, the app in one
- **This app does:** English only
- **User reaction:** blocked-conversion
- **Magnitude:** top-10 923 (79.0%) vs other 66 245; | Top-10 volume (n=923) | Other 66 storefronts (n=245) ; Mean | 3.56 | 3.78 ; 1–2★ | 31.9% | 22.9% ; 5★ | 49.3% | 51.4% ; Price objection | 34.89% | 28.57% ; Free 1-habit cap | 7.15% | 4.08% ; Pro cap | 6.83% | 4.90% ; Cash-grab language | 6.18% | 4.90% ; Localisation request | 1.84% | 7.76% ; Freeze / stuck loading | 2.49% | 3.27% ; localisation 36 (3.08%)
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10983171894`, `11292115448`, `12184498108`, `13352260332`, `10984029494`, `12668682597`, `13399884794`, `14276815734`
- **Canonical:** C027 Localise early — it unlocks revenue

### R16-058 — Sub-50 notes [limited evidence]: Germany is the worst-rated storefront of any size ('nothing more than an alarm clock providing statistics on how often it rings… does not justify a price higher than a full-fledged office suite'; store rating 4.59, lowest of the large markets); FR/NL/CH/PL/TR all price-dominated, Poland zero 5★; PH/SE/BR/CO/NZ almost purely positive with zero 1–2★; China: 2 of 3 reviews are storefront-specific sign-up failures (verification code rejected); India just under threshold with the only failed-purchase report (UPI) and 3 regional-pricing objections

- **Where:** §6.4 Sub-50 storefronts — limited-evidence notes: DE worst-rated of any size; FR/NL/CH/PL/TR price-dominated; PH/SE/BR/CO/NZ purely positive; CN login broken; IN UPI failure
- **This app does:** CN sign-up broken; €20/mo in DE
- **User reaction:** mixed
- **Magnitude:** DE 39: mean 2.92, 1–2★ 46.2%, 5★ 17.9%, 14 quote €20/mo or €129/yr; PL 9 mean 2.56, 0 5★; CN 3; IN 41 mean 3.90
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `10985727014`, `11755036634`, `12630024377`, `11261255351`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C027 Localise early — it unlocks revenue; C035 Account system from day one; C092 Regional pricing

### R16-081 — Localise, starting with Spanish — 14 of 36 requests; the book exists in ~60 languages; the widest brand-reach-to-product-reach gap and the cheapest new market available

- **Where:** §8.4 #16 Localise, starting with Spanish — the cheapest new market available
- **This app does:** English only
- **User reaction:** blocked-conversion
- **Magnitude:** 36 (3.08%), Spanish 14, 7.76% of tail storefronts
- **Direction for us:** build-free · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R16-021 — Corpus composition by period and quarter: launch P1 mean 3.88 then a post-launch floor around 3.0–3.4; all post-launch reviews combined mean 3.22; the 27 Feb 2024 spike (171 reviews) is the largest single day and where the price backlash peaks

- **Where:** §1.7 Corpus composition — by period table (verbatim); by quarter table (verbatim); launch-day detail
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Period | n | % of corpus | Mean | 1–2★ | 5★ ; P1 — launch, 15 Feb – 31 Mar 2024 | 678 | 58.05% | 3.88 | 24.2% | 59.7% ; P2 — rest of 2024, Apr–Dec | 217 | 18.58% | 3.00 | 42.9% | 28.6% ; P3 — 2025 | 190 | 16.27% | 3.38 | 34.2% | 41.6% ; P4 — 2026, Jan–Sep | 83 | 7.11% | 3.42 | 33.7% | 42.2% ;; Quarter | n | Mean | 1★ | 5★ ; 2024 Q1 | 678 | 3.88 | 14.7% | 59.7% ; 2024 Q2 | 115 | 2.94 | 25.2% | 27.8% ; 2024 Q3 | 49 | 3.14 | 20.4% | 30.6% ; 2024 Q4 | 53 | 2.98 | 28.3% | 28.3% ; 2025 Q1 | 69 | 3.13 | 18.8% | 27.5% ; 2025 Q2 | 62 | 3.56 | 24.2% | 53.2% ; 2025 Q3 | 31 | 3.65 | 19.4% | 54.8% ; 2025 Q4 | 28 | 3.32 | 14.3% | 35.7% ; 2026 Q1 | 38 | 2.97 | 28.9% | 31.6% ; 2026 Q2 | 30 | 3.60 | 16.7% | 43.3% ; 2026 Q3 (partial, to 4 Sep) | 15 | 4.20 | 0.0% | 66.7% ; post-launch n=490 mean 3.22, 22.0% 1★, 35.9% 5★; 24 Feb 69 (4.49), 25 Feb 74 (4.47), 26 Feb 70 (3.94), 27 Feb 171 (3.84), 28 Feb 71 (4.08), 29 Feb 44 (3.80); US 542 (46.4%), GB 103, CA 73, AU 52 = 65.4%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R16-059 — The launch bought a rating and spent it in six weeks: the mean fell 0.88 stars from the launch window to the following nine months and never returned; the floor since April 2024 (mean 3.22, 22.0% one-star) is the app's written steady state; within the launch window 24 Feb 4.49 → 27 Feb 3.84 as the price became widely known

- **Where:** §7.1 Method — four cohorts; §7.2 Trend 1 — The launch bought a rating and then spent it in six weeks; table (verbatim)
- **This app does:** $120/yr revealed after launch buzz
- **User reaction:** 1★-burst
- **Magnitude:** Period | n | Mean | 5★ | 1★ ; P1 launch | 678 | 3.88 | 59.7% | 14.7% ; P2 rest of 2024 | 217 | 3.00 | 28.6% | 24.9% ; P3 2025 | 190 | 3.38 | 41.6% | 20.0% ; P4 2026 | 83 | 3.42 | 42.2% | 19.3% ; P1 678 / P2 217 / P3 190 / P4 83
- **Direction for us:** product-rule · **Report confidence:** trend · **Generalisable:** yes
- **Review IDs:** `10976398063`, `10979802836`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R16-060 — Reliability is worsening and unresolved — more than doubled; the launch bugs were fixed, the 2025 bugs were not; the freeze-on-habit-creation cluster is documented at ten dates between Apr 2025 and Feb 2026 and still producing 1★ eight weeks before the corpus ends — the only story unambiguously getting worse

- **Where:** §7.3 Trend 2 — Worsening and unresolved: reliability; table (verbatim)
- **This app does:** onboarding freeze unfixed since Apr 2025
- **User reaction:** 1★-burst
- **Magnitude:** Theme | P1 | P2 | P3 | P4 | Read ; Any reliability complaint | 6.19% | 9.68% | 14.74% | 14.46% | More than doubled ; Freeze / stuck loading | 2.36% | 1.84% | 4.21% | 3.61% | Returned in 2025 and stayed ; Bug reported (generic) | 2.65% | 2.30% | 6.32% | 4.82% | ; Repeated forced logout | 0.15% | 0.92% | 2.11% | 1.20% | Peaked 2024-11 → 2025-06
- **Direction for us:** must-never-break · **Report confidence:** trend · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C075 Skippable, replayable onboarding tour

### R16-061 — Brand damage and bait-and-switch framing are worsening: bait-and-switch tripled from launch to 2026 — as the launch cohort's memory fades, a new cohort discovers the wall for the first time; rigid-habit-model complaints also nearly tripled

- **Where:** §7.4 Trend 3 — Worsening: brand damage and the paywall framing; table (verbatim)
- **This app does:** trial cliff unchanged
- **User reaction:** 1★-burst
- **Magnitude:** Theme | P1 | P2 | P3 | P4 ; Brand betrayal | 0.88% | 1.84% | 1.58% | 3.61% ; Bait-and-switch framing | 2.36% | 5.07% | 4.21% | 7.23% ; Rigid habit model | 2.51% | 4.61% | 3.16% | 7.23%
- **Direction for us:** dont · **Report confidence:** trend · **Generalisable:** yes
- **Review IDs:** `14302077000`, `13613868361`
- **Canonical:** C043 Flexible / custom frequency; C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff; C195 Premium pricing on a trust-based personal brand spends the brand

### R16-062 — Price and cap complaints improved only relatively: P2 (Apr–Dec 2024) is the trough — half of everything written was a price objection, in the period containing the June 2024 cut; price objection is still 30.12% in 2026, essentially the launch rate, at roughly one-third of the launch price; the Pro-cap complaint has not moved in 30 months

- **Where:** §7.5 Trend 4 — Improving, but only relatively: price and cap complaints; table (verbatim); P2 is the trough
- **This app does:** price cut ~67%; caps unchanged
- **User reaction:** complaint
- **Magnitude:** Theme | P1 | P2 | P3 | P4 ; Price objection | 30.97% | 50.69% | 24.74% | 30.12% ; Free 1-habit cap | 5.75% | 8.76% | 7.37% | 4.82% ; Pro cap | 5.75% | 7.37% | 7.37% | 7.23% ; Wants cheaper tier | 3.54% | 8.29% | 4.74% | 2.41% ; Wants one-time purchase | 2.06% | 5.99% | 3.16% | 4.82% ; Cash-grab language | 5.16% | 9.22% | 5.26% | 4.82%
- **Direction for us:** product-rule · **Report confidence:** trend · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'; C191 Never cap the tier someone has already paid for

### R16-063 — Every positive theme is falling and the two most specific — Mindset content and the haptic loop — fell by three-quarters: Mindset praise fell as the content moved behind the paywall (people cannot praise what they cannot see), haptic praise fell after the mid-2024 list redesign; nobody has defended the habit constraint since 2025 — the app's most distinctive idea has stopped being described as a virtue by anyone

- **Where:** §7.6 Trend 5 — Decaying: everything that made the launch reviews good; table (verbatim); people cannot praise what they cannot see; nobody has defended the constraint since 2025
- **This app does:** content paywalled; circles replaced by list
- **User reaction:** complaint
- **Magnitude:** Theme | P1 | P2 | P3 | P4 | Change ; Brand halo | 30.53% | 10.14% | 16.84% | 8.43% | −22 pts ; Simplicity praise | 19.62% | 11.52% | 10.53% | 6.02% | −13.6 pts ; Design praise | 17.85% | 15.67% | 8.42% | 9.64% | −8.2 pts ; Mindset content praise | 6.78% | 4.15% | 1.58% | 1.20% | −5.6 pts ; Haptic loop praise | 4.87% | 4.15% | 1.05% | 1.20% | −3.7 pts ; Defends the constraint | 2.51% | 0.92% | 0.53% | 0.00% | gone
- **Direction for us:** product-rule · **Report confidence:** trend · **Generalisable:** yes
- **Review IDs:** `11343906321`, `11814577640`, `11390526677`, `11368755180`
- **Canonical:** C069 Check-off sound and haptic; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C194 Do not paywall content the user already bought elsewhere

### R16-064 — Dark mode is the emerging request: 16 of 21 requests are dated after Nov 2024, from happy users — the highest-goodwill unmet need in the corpus

- **Where:** §7.7 Trend 6 — Emerging: dark mode
- **This app does:** no dark mode
- **User reaction:** complaint
- **Magnitude:** 0.29% → 2.76% → 5.26% → 3.61%; 21 total mean 3.76, 9.5% 1–2★
- **Direction for us:** build-free · **Report confidence:** trend · **Generalisable:** yes
- **Canonical:** C080 Colour themes / dark mode

### R16-065 — Seven themes reported in the first 72 hours of general availability and still producing reviews in 2026: free tier = 1 habit, Pro cap, no back-logging, English only, no dark mode, rigid time-locked model, requires internet to log

- **Where:** §7.8 What persisted unchanged across the whole 31 months table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | First seen | Last seen | Span | Total ; Free tier = 1 habit | `10975917055` (US, 24 Feb 2024) | `14064134860` (US, 14 May 2026) | 27 months | 76 ; Pro cap (3 → 6, never removed) | `10975518449` (US, 24 Feb 2024) | `14287877372` (US, 10 Jul 2026) | 29 months | 75 ; No back-logging past yesterday | `10976218757` (US, 24 Feb 2024) | `13717258566` (US, 5 Feb 2026) | 23 months | 33 ; English only | `10983171894` (ES, 26 Feb 2024) | `14276815734` (TR, 8 Jul 2026) | 29 months | 36 ; No dark mode | `10983131171` (US, 26 Feb 2024) | `14163695377` (NL, 9 Jun 2026) | 27 months | 21 ; Rigid time-locked habit model | `10975577608` (US, 24 Feb 2024) | `14287877372` (US, 10 Jul 2026) | 29 months | 39 ; Requires internet to log | `10977084069` (US, 25 Feb 2024) | `13792185404` (US, 26 Feb 2026) | 24 months | 9
- **Direction for us:** product-rule · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `10975917055`, `14064134860`, `10975518449`, `14287877372`, `10976218757`, `13717258566`, `10983171894`, `14276815734`, `10983131171`, `14163695377`, `10975577608`, `10977084069`, `13792185404`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C010 Backfill missed days / edit start date; C027 Localise early — it unlocks revenue; C043 Flexible / custom frequency; C080 Colour themes / dark mode; C188 The app must open offline — never block launch on a network call; C191 Never cap the tier someone has already paid for

## Positioning

### R16-001 — Atoms — from Atomic Habits (App Store ID 6474421906) is the official James Clear / Atomic Habits app: a beautifully crafted, brand-led habit tracker whose packaging (one free habit, a capped paid tier, a 28-day trial ending in a wall, launch pricing of $120/yr) destroyed its written reception

- **Where:** header lines 1-9
- **This app does:** developer Atomic Development Inc.; bundle app.getatoms.ios; English-only; iPhone-only (no iPad, Watch, Mac or Android); subscription; store rank 16
- **User reaction:** mixed
- **Magnitude:** 1,168 written reviews, 76 storefronts, 15 Feb 2024 → 4 Sep 2026; mean 3.604; 5★ 581 (49.74%) · 4★ 102 (8.73%) · 3★ 135 (11.56%) · 2★ 142 (12.16%) · 1★ 208 (17.81%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R16-039 — 86 reviews name an alternative and naming a competitor is a churn signal: Streaks (eight times, every mention for its one-time purchase), pen and paper ('$200 buys a lot of habit journals'), Apple Reminders/Calendar, (Not Boring) Habits (cheaper, lifetime; 'essentially a clone'), Fabulous, Notion/Sheets, HabitKit ('$16 for lifetime use'), Miracle Morning ('only $39'), Duolingo as the streak benchmark — Atoms is not losing on features, it is losing to a one-time price

- **Where:** §3.4 Competitors reviewers name, and why table (verbatim); Atoms is not losing on features, it is losing to a one-time price
- **This app does:** subscription only vs one-time rivals
- **User reaction:** churn
- **Magnitude:** 86 (7.36%, HIGH-PRIORITY) mean 2.52; Named alternative | Reviews | Stated reason ; Streaks | `10986293973` `11094114464` `11489179909` `11547941829` `11667634559` `11126042765` `10991760676` `11110393035` | One-time purchase, more habits, more customisation — the most-cited replacement ; Pen & paper / notebook / bullet journal | `10975598929` `11002040769` `11005522402` `11091064430` `11113968468` `11115332333` `12134613832` `13820590722` | "$200 buys a lot of habit journals" (`10983893115`) ; Apple Reminders / Calendar | `10997695352` `11054245890` `11058475292` `12165173158` `12199586867` `14046766451` | Free and already installed ; (Not Boring) Habits | `11110393035` `14046766451` `14089377229` | Cheaper, has a lifetime option; `11110393035` calls Atoms *"essentially a clone"* ; Fabulous | `10975525747` `10990153656` `11115332333` | Cheaper, science-based ; Notion / Google Sheets / Excel | `10989617169` `11768920099` `12303875627` `11478257355` | Free and more flexible ; HabitKit | `10984314402` | *"Habitkit is $16 for lifetime use"* ; Miracle Morning | `11177029172` | *"The free app has a wealth of features and the paid version is amazing and only $39"* ; Duolingo | `11737855300` `11951514881` | Cited as the streak-mechanic benchmark Atoms should match ; Headspace, TickTick, Todoist, Habitica, Structured, Waking Up, Setapp, Procreate | `10983800932` `11350561511` `11313605240` `11459001845` `11685719155` | Price/value comparisons
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10986293973`, `11094114464`, `11489179909`, `10983893115`, `12199586867`, `11110393035`, `14046766451`, `10975525747`, `10989617169`, `10984314402`, `11177029172`, `11737855300`, `11685719155`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C005 Know which competitors buyers compare against

## Anti-patterns

### R16-016 — The brand is being spent: 16 reviews attack James Clear personally or say the app damaged the book for them — the lowest-rated theme, not one above 3★ ('How to ruin your brand overnight… just another hypocrit selling himself out'; 'changed my view of James'; 'Please don't become greedy') and the only negative theme worse in 2026 than at launch; 69 reviews use explicitly moral language ('cash grab', 'greedy', 'predatory', 'scam') — the only theme with a zero 5★ rate; 18 frame a broken bargain with book buyers ('although I bought the book it did nothing… maybe a discount or even a free membership'; 'scan the barcode and get a special price')

- **Where:** Part 0 §9 The brand is being spent, and 16 reviewers say so explicitly; moral language; broken bargain with book buyers
- **This app does:** premium pricing on a trust-based personal brand; no book-buyer recognition
- **User reaction:** 1★-burst
- **Magnitude:** brand damage 16 (1.37%) mean 1.38, 93.8% 1–2★, 0.88% (P1) → 3.61% (P4); moral language 69 (5.91%, HIGH-PRIORITY) mean 1.38, 91.3% 1–2★, 0 5★; book-buyer bargain 18 (1.54%)
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11044837304`, `10993434698`, `11197168795`, `13558310210`, `14136029170`, `10983993222`, `12513582477`, `11097642923`
- **Canonical:** C025 Scholarship / hardship / discount program; C195 Premium pricing on a trust-based personal brand spends the brand

## Things not to do

### R16-007 — The 28-day all-features trial is experienced as a trap: the app encourages you to build a streak, then removes the ability to log it — 'the trial model is a bit sly in that it encourages people to start habits and continue them for three weeks and then hits you with a steep bill. It's counter to the mission'; 'I feel like this is manipulative from James Clear'; 'Being suddenly locked out and charged is NOT the principles the book taught'; the only major negative still growing

- **Where:** Part 0 §4 The 28-day trial is experienced as a trap, and it is producing the app's angriest reviews
- **This app does:** 28-day trial → wall; streak built then locked
- **User reaction:** 1★-burst
- **Magnitude:** 41 (3.51%, VERY STRONG) mean 2.44, 58.5% 1–2★; 2.36% (P1) → 5.07% (P2) → 4.21% (P3) → 7.23% (P4)
- **Direction for us:** dont · **Report confidence:** very strong, rising · **Generalisable:** yes
- **Review IDs:** `12482534390`, `13613868361`, `12600470632`, `14302077000`, `13882025149`
- **Canonical:** C109 A free trial must be a real trial; C147 Let people use the product before they pay; C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

## Things to do

### R16-074 — Introduce regional pricing (a Peruvian reviewer does the PPP arithmetic) and a student tier — rest-of-world reviewers ask 6.7× more often than high-spend-market reviewers

- **Where:** §8.2 #9 Introduce regional pricing and a student tier
- **This app does:** single global price
- **User reaction:** blocked-conversion
- **Magnitude:** 11 regional; student asks 4 IDs
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `11001435276`, `13456206729`, `10983993222`, `10984142146`, `11105451365`
- **Canonical:** C025 Scholarship / hardship / discount program; C092 Regional pricing

### R16-080 — Restore the satisfying completion loop — the most-praised piece of craft should not be a casualty of density; offer the circle view as an option

- **Where:** §8.3 #15 Restore the satisfying completion loop — offer the circle view as an option
- **This app does:** circles replaced by compact list
- **User reaction:** complaint
- **Magnitude:** haptic praise 4.87% → 1.20%; 4 reviewers name the change
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `11343906321`, `11814577640`, `11390526677`, `11368755180`
- **Canonical:** C069 Check-off sound and haptic; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R16-082 — Say what the free tier is in the listing before download — eight reviewers had no idea the app was paid; a clear '1 free habit, Pro for more' line converts a 1★ ambush into a 3★ informed decision, and converts far better paired with a 3-habit free tier

- **Where:** §8.4 #17 Say what the free tier is, in the listing, before download — converts a 1★ ambush into a 3★ informed decision
- **This app does:** listing does not state the free tier
- **User reaction:** 1★-burst
- **Magnitude:** 8 reviewers
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `11562525291`, `12250461429`, `12482534390`, `12591641304`, `12959086974`, `13616010098`, `13807288552`, `14046766451`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C181 If the app is paid-only, say so in the subtitle and first screenshot

## Contradictions

### R16-006 — The counter-case is real: 20 reviews defend the constraint at mean 4.60 — 'you can only add a second habit after you've done your first at least 3 times. It forces you to slow down'; 'People complain about only 6 habits but they're missing the point'; 'the gamification that rewards you with ability to record more habits by recording habits' — the constraint is loved at 3–6 habits and hated at 1; the design principle survives raising the free tier, it does not survive a free tier of one

- **Where:** Part 0 §3 The counter-case is real — 20 reviews defend the constraint; loved at 3–6 habits and hated at 1
- **This app does:** earn-a-slot constraint
- **User reaction:** praise
- **Magnitude:** 20 (1.71%, MEANINGFUL) mean 4.60, 80% 5★
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** works at 3–6 habits, fails at 1
- **Review IDs:** `10950990017`, `12115363939`, `13329955083`, `10980656747`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C024 Streaks / gamification

### R16-043 — Both-sides themes: design praise (complimented on the way out), the habit constraint (loved at 3–6, hated at 1), price (a loud paying-willing minority), the brand (earns and destroys reviews), Mindset content (praised when free, resented when paywalled)

- **Where:** §4.2 Themes that appear on both sides of the rating line table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 5★ instances | 1–2★ instances | Reading ; Design praise | 78 | 56 | The craft is not in dispute; it is being complimented on the way out ; The habit constraint | 16 defend it | 135 complain about a cap | The principle is loved at 3–6, hated at 1 ; Price mentioned | 29 (incl. 17 who call it fair) | 249 | The paying-willing minority exists and is loud ; Brand / the book | 242 halo | 71 in 1★ | The brand both earns and destroys reviews ; Mindset content | 39 praise it | 12 resent it being paywalled | Same feature, opposite sign, decided by tier
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C185 Aesthetic and a polished onboarding convert; they do not retain; C194 Do not paywall content the user already bought elsewhere

## Data caveats and method

### R16-002 — Method: denominator 1,168, non-exclusive themes, standard bands; segment rates always labelled with segment denominator; only four storefronts clear 50 (US 542, GB 103, CA 73, AU 52); external facts marked [external] — live App Store lookup was blocked by network policy (403 at egress proxy) so store ratings come from Tools/habit_apps_ranked.json cached 9 Sep 2026; the corpus is 58% launch-week, so global percentages are not a picture of the app today; 100% of records read individually, perfect reconciliation, zero duplicates

- **Where:** How to read this; §1.1–1.5 files, schema, coverage, method, limitations; §1.6 External sources; §9.1 counting rules; §9.3 method audit trail
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 1,168 / 1,168; 76 storefronts; launch-week 58%; 5.6% of raters write (1,168 of 20,857)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R16-012 — The public rating is 1.21 stars above the written mean — the largest gap in the folder; only 5.6% of raters write; the 4.81 is real and not the whole story: the people motivated enough to write are, two-to-one, writing about money — do not read it as 'the app is secretly a 3.6'

- **Where:** Part 0 §7 The public rating is 1.21 stars higher than what people write — the largest gap in this folder; table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | Store rating (all taps) | Store rating count | This corpus (written) | n | Gap ; Global | 4.81 | 20,857 | 3.60 | 1,168 | −1.21 ; US | 4.83 | 10,650 | 3.71 | 542 | −1.12 ; GB | 4.70 | 1,389 | 3.20 | 103 | −1.50 ; CA | 4.74 | 1,362 | 3.21 | 73 | −1.53 ; AU | 4.79 | 1,015 | 3.50 | 52 | −1.29 ; IN | 4.83 | 848 | 3.90 | 41 | −0.93 ; DE | 4.59 | 388 | 2.92 | 39 | −1.67 ; MX | 4.90 | 353 | 3.94 | 16 | −0.96 ; ES | 4.74 | 240 | 3.90 | 21 | −0.84 ; NL | 4.62 | 165 | 3.10 | 21 | −1.52 ; FR | 4.69 | 172 | 3.00 | 15 | −1.69
- **Direction for us:** none · **Report confidence:** external + corpus · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R16-019 — Files, schema, reconciliation and method detail: 57 themes built from a full chronological read in 12 batches; hybrid classification — praise themes by multilingual regex, every high-stakes theme hand-audited review by review with recorded add/remove sets; the price theme uses proximity logic (8 false positives removed, 32 misses added by hand); the paid cohort audited line by line (146 candidates → 19 removed as book/journal/competitor purchases, 3 ambiguous excluded); purchase intent excluded throughout

- **Where:** §1.1 Files used table (verbatim); §1.2 Schema; §1.3 Coverage and reconciliation table (verbatim); §1.4 Processing method; §1.6 External sources table (verbatim)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** File | Rows | Use ; `reviews.jsonl` | 1,168 | Primary corpus. Every record read. ; `by_country/*.jsonl` (76 files) | 1,168 | Reconciliation only. Perfect 1:1 match with the merged file. ; `manifest.json` | — | App id, developer, bundle id, extraction timestamp (2026-09-08T11:43:19Z), per-country counts, rating distribution, mean ; `_state.json` | — | Per-storefront crawl completeness; all 76 marked `complete: true`, `collected == total` on every storefront ;; Check | Result ; Records in `reviews.jsonl` | 1,168 ; Records analysed | 1,168 (100%) ; Unique `review_id` values | 1,168 — zero duplicates, no deduplication applied ; Duplicate `title`+`body` pairs | 0 ; Records in `by_country/*.jsonl` | 1,168 across 76 files ; In country files but not merged | 0 ; In merged but not country files | 0 ; Per-country counts vs manifest | Exact match, all 76 storefronts ; Empty `body` | 0 ; Empty `title` | 0 ; Manifest rating distribution vs computed | Exact match (581 / 102 / 135 / 142 / 208) ; Manifest mean (3.604) vs computed | Exact match (3.6045) ; Date range | 2024-02-15T14:54:18Z → 2026-09-04T01:50:47Z ; Reviews marked edited | 10 (0.86%) ; Reviews with ≥1 helpful vote | 201 (17.21%) ;; Source | Basis | Used for ; `Tools/habit_apps_ranked.json` (this repo, committed 9 Sep 2026) | App Store search-ranking + ratings crawl across 57 Atoms storefronts | §0.7 store-rating comparison, global 4.81 / 20,857 ratings, per-storefront rating counts, market-tier labels used in §6.2 ; `Tools/play_habit_apps_ranked.json` (this repo) | Google Play crawl, 146 habit apps | Negative evidence: Atoms does not appear in the Play ranking set, consistent with the corpus's Android request (`11207909936`) and the absence of any Android reviewer ; Apple iTunes Lookup API | Not available | Blocked by session egress policy (403). No live listing, price, version or language data was obtained.
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `10975681427`, `10983622751`, `12616174078`, `10983135069`, `11054245890`, `10980935471`, `11489179909`
- **Canonical:** — (nuance register)

### R16-020 — Limitations: launch-window dominance is the biggest (58.05% of reviews in the first six weeks — where a finding depends on the app today, use the P4 2026 column); a launch-day review-solicitation campaign is visible — a reviewer alleges the beta list was asked to 'overcome outdated reviews', 23 reviews self-identify as beta testers and are strongly bimodal; no version field; no live store data; 72 of 76 storefronts under 50; hand-curated small themes are floors

- **Where:** §1.5 Limitations — launch-window dominance; selection bias; a launch-day review-solicitation campaign is visible; no version field; external data not refreshed; small samples; language coverage; small themes are floors
- **This app does:** beta testers asked to post reviews at launch
- **User reaction:** mixed
- **Magnitude:** 678 of 1,168 (58.05%) launch; beta testers 23 (1.97%), 47.8% 5★ / 47.8% 1–2★; regex praise themes ±3–5%
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `10977084069`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R16-028 — All 57 themes ranked: 37 negative, 12 positive, 5 cross-cutting

- **Where:** §3.1 All themes, ranked — Negative themes table (verbatim); Positive themes table (verbatim); Cross-cutting table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** NEG: # | Theme | n | % | Mean | 1–2★% | Signal ; 1 | Price / value objection | 392 | 33.56% | 2.18 | 65.3% | HIGH-PRIORITY ; 2 | Subscription model objection (all valences) | 136 | 11.64% | 2.32 | 59.6% | HIGH-PRIORITY ; 3 | Competitor named as better or cheaper | 86 | 7.36% | 2.52 | 58.1% | HIGH-PRIORITY ; 4 | Free tier = 1 habit | 76 | 6.51% | 2.22 | 61.8% | HIGH-PRIORITY ; 5 | Pro tier capped (3 → 6 habits) | 75 | 6.42% | 2.57 | 57.3% | HIGH-PRIORITY ; 6 | Moral objection — "cash grab", "greed", "predatory" | 69 | 5.91% | 1.38 | 91.3% | HIGH-PRIORITY ; 7 | Stated churn / uninstall | 55 | 4.71% | 2.00 | 76.4% | VERY STRONG ; 8 | Asks for a cheaper tier / student rate / discount | 53 | 4.54% | 2.36 | 64.2% | VERY STRONG ; 9 | Trial-to-paywall bait-and-switch | 41 | 3.51% | 2.44 | 58.5% | VERY STRONG ; 10 | Bug reported (generic) | 39 | 3.34% | 2.95 | 48.7% | VERY STRONG ; 11 | Habit model too rigid (time-locked, no stacking, no flexible frequency) | 39 | 3.34% | 3.21 | 33.3% | VERY STRONG ; 12 | Asks for one-time / lifetime purchase | 37 | 3.17% | 2.16 | 62.2% | VERY STRONG ; 13 | Asks for a language other than English | 36 | 3.08% | 3.44 | 30.6% | VERY STRONG ; 14 | Confusing / over-designed UX | 35 | 3.00% | 2.80 | 42.9% | MEANINGFUL ; 15 | Cannot back-log past days | 33 | 2.83% | 3.39 | 21.2% | MEANINGFUL ; 16 | App freezes / stuck on loading | 31 | 2.65% | 1.90 | 74.2% | MEANINGFUL ; 17 | No dark mode | 21 | 1.80% | 3.76 | 9.5% | MEANINGFUL ; 18 | Book buyers expected recognition | 18 | 1.54% | 2.61 | 55.6% | MEANINGFUL ; 19 | Brand betrayal — attacks James Clear directly | 16 | 1.37% | 1.38 | 93.8% | MEANINGFUL ; 20 | Accountability-partner limits | 15 | 1.28% | 3.27 | 26.7% | MEANINGFUL ; 21 | Weak progress visualisation / no real calendar | 15 | 1.28% | 2.67 | 60.0% | MEANINGFUL ; 22 | Wants customisation (colour, order) | 14 | 1.20% | 3.64 | 28.6% | MEANINGFUL ; 23 | Account creation / sign-in broken | 12 | 1.03% | 1.50 | 83.3% | MEANINGFUL ; 24 | Logging silently fails | 12 | 1.03% | 2.00 | 83.3% | MEANINGFUL ; 25 | Regional pricing / purchasing-power objection | 11 | 0.94% | 2.73 | 45.5% | Emerging ; 26 | Widget problems | 11 | 0.94% | 3.00 | 36.4% | Emerging ; 27 | Repeated forced logout | 10 | 0.86% | 2.10 | 70.0% | Emerging ; 28 | Missing platform (iPad / Watch / Mac / Android) | 10 | 0.86% | 3.50 | 30.0% | Emerging ; 29 | Data or history loss | 9 | 0.77% | 2.78 | 55.6% | Emerging ; 30 | Requires internet to log | 9 | 0.77% | 2.56 | 44.4% | Emerging ; 31 | Cannot undo / unlog | 9 | 0.77% | 3.11 | 22.2% | Emerging ; 32 | Notification problems | 8 | 0.68% | 3.12 | 25.0% | Emerging ; 33 | Animation / loading friction | 7 | 0.60% | 2.57 | 57.1% | Emerging ; 34 | Support unreachable | 7 | 0.60% | 2.14 | 71.4% | Emerging ; 35 | Billing / refund / auto-renewal problem | 7 | 0.60% | 1.43 | 85.7% | Emerging ; 36 | Privacy concern | 5 | 0.43% | 2.40 | 60.0% | Weak ; 37 | US-centric date/time formats | 3 | 0.26% | 2.33 | 33.3% | Weak ;; POS: # | Theme | n | % | Mean | 5★% | Signal ; 1 | Brand halo (4–5★ reviews citing Clear or the book) | 268 | 22.95% | 4.90 | 90.3% | HIGH-PRIORITY ; 2 | Simplicity / ease of use | 183 | 15.67% | 4.73 | 82.0% | HIGH-PRIORITY ; 3 | Design / UI / visual craft (all ratings) | 179 | 15.33% | 3.49 | 43.6% | HIGH-PRIORITY ; 4 | Life change / "best app" | 72 | 6.16% | 4.49 | 77.8% | HIGH-PRIORITY ; 5 | Mindset content / daily lessons / articles | 59 | 5.05% | 4.07 | 66.1% | HIGH-PRIORITY ; 6 | Haptic press-and-hold completion loop | 45 | 3.85% | 4.02 | 64.4% | VERY STRONG ; 7 | Identity framing / "cast a vote" | 35 | 3.00% | 4.43 | 71.4% | MEANINGFUL ; 8 | Defends the habit constraint | 20 | 1.71% | 4.60 | 80.0% | MEANINGFUL ; 9 | Price is fair / good value | 17 | 1.46% | 5.00 | 100% | MEANINGFUL ; 10 | Accountability partner (positive) | 13 | 1.11% | 3.62 | 46.2% | MEANINGFUL ; 11 | Believes the app is free / praises free access | 10 | 0.86% | 4.80 | 90.0% | Emerging ; 12 | Focus timer | 2 | 0.17% | 3.50 | — | Weak ;; CROSS: Theme | n | % | Mean | Note ; Any monetisation theme | 457 | 39.13% | 2.38 | Two-fifths of everything written about this app is about money ; Any reliability theme | 103 | 8.82% | 2.45 | 59.2% are 1–2★; rate has doubled since launch ; Any habit-cap complaint (free or Pro) | 135 | 11.56% | 2.44 | 57.8% are 1–2★ ; Beta testers | 23 | 1.97% | 3.13 | Bimodal: 47.8% 5★, 47.8% 1–2★ ; ADHD / neurodivergent / depression self-identified | 7 | 0.60% | 3.86 | `[limited evidence]`
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R16-035 — Ten reviewers believe the app is free or praise free access — reviews written inside the trial window before the wall

- **Where:** §3.1 positive #11 Believes the app is free / praises free access; §5.5
- **This app does:** 28-day trial reads as free
- **User reaction:** praise
- **Magnitude:** 10 (0.86%) mean 4.80, 90.0% 5★
- **Direction for us:** none · **Report confidence:** emerging · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R16-040 — Per-band theme tables for all five bands

- **Where:** §4.1 5★ table (verbatim); 4★ table (verbatim); 3★ table (verbatim); 2★ table (verbatim); 1★ table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★: Theme | n in band | % of 5★ ; Brand halo (Clear / the book) | 242 | 41.7% ; Simplicity / ease of use | 150 | 25.8% ; Design praise | 78 | 13.4% ; Life change / best app | 56 | 9.6% ; Mindset content | 39 | 6.7% ; Haptic completion loop | 29 | 5.0% ; Price objection (still) | 29 | 5.0% ; Identity framing | 25 | 4.3% ; Price is fair | 17 | 2.9% ; Defends the habit constraint | 16 | 2.8% ; Pro cap complaint | 13 | 2.2% ;; 4★: Theme | n | % of 4★ ; Price objection | 31 | 30.4% ; Brand halo | 26 | 25.5% ; Simplicity praise | 17 | 16.7% ; Design praise | 14 | 13.7% ; Rigid habit model | 11 | 10.8% ; Cannot back-log | 10 | 9.8% ; Localisation | 8 | 7.8% ; Free 1-habit cap | 7 | 6.9% ; No dark mode | 7 | 6.9% ; Wants a lifetime option | 6 | 5.9% ;; 3★: Theme | n | % of 3★ ; Price objection | 76 | 56.3% ; Design praise | 31 | 23.0% ; Subscription objection | 31 | 23.0% ; Free 1-habit cap | 16 | 11.9% ; Pro cap | 15 | 11.1% ; Competitor named | 14 | 10.4% ; Confusing UX | 11 | 8.1% ; Cannot back-log | 10 | 7.4% ; Bait-and-switch | 9 | 6.7% ;; 2★: Theme | n | % of 2★ ; Price objection | 103 | 72.5% ; Subscription objection | 33 | 23.2% ; Design praise (in a 2★) | 30 | 21.1% ; Pro cap | 24 | 16.9% ; Competitor named | 20 | 14.1% ; Stated churn | 18 | 12.7% ; Free 1-habit cap | 16 | 11.3% ; Cash-grab language | 13 | 9.2% ; Bait-and-switch | 10 | 7.0% ; Freeze / stuck loading | 8 | 5.6% ;; 1★: Cause | n | % of 1★ ; Price / value | 153 | 73.6% ; Cash-grab / greed / predatory framing | 50 | 24.0% ; Subscription model | 48 | 23.1% ; Free 1-habit cap | 31 | 14.9% ; Competitor is better/cheaper | 30 | 14.4% ; Design praise inside a 1★ | 26 | 12.5% ; Stated churn | 24 | 11.5% ; Pro cap | 19 | 9.1% ; Wants a cheaper tier | 19 | 9.1% ; Wants a lifetime option | 18 | 8.7% ; App freezes / won't load | 15 | 7.2% ; Bait-and-switch | 14 | 6.7% ; Confirmed payer | 13 | 6.2%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R16-050 — Ten reviews praise Atoms for being free ('I can't believe all of it's been free? … a gift from James to his worldwide community'); nine are dated 2025–26 — users still inside the 28-day trial; every one is a 5★ that has not yet met the paywall, the clearest measure of how much rating value the trial generates before it is spent

- **Where:** §5.5 The people who think it is free — every one is a 5★ that has not yet met the paywall
- **This app does:** 28-day trial
- **User reaction:** praise
- **Magnitude:** 10 (0.86%) mean 4.80, 90% 5★; 9 dated 2025–26
- **Direction for us:** none · **Report confidence:** emerging · **Generalisable:** app-specific
- **Review IDs:** `13019922003`, `14186561740`, `12858987458`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R16-083 — Research questions: actual conversion rate and whether the two price cuts moved it; do 1★ price reviewers ever become buyers at a lower price (one observed); how much of the 4.81 tap-rating is trial-period sentiment (an in-app prompt fired before vs after day 28 would answer it); is the freeze bug device-, OS- or storefront-specific; would a 3-habit free tier cannibalise Pro; is the review-solicitation campaign still running

- **Where:** §8.5 Research questions this corpus cannot answer
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 6 questions
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** yes
- **Review IDs:** `11980741663`, `10977084069`
- **Canonical:** — (nuance register)
