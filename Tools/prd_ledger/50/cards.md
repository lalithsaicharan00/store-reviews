# Cards — report 50

Source: `App Store Reports/50. HelloHabit - Habit Tracker - Tasks, Routines, & Streaks (REPORT).md`  
100 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 5
- [Must-haves](#must-haves) — 5
- [Must never break](#must-never-break) — 9
- [Features](#features) — 8
- [Monetization](#monetization) — 6
- [Tactics the app used](#tactics-the-app-used) — 5
- [Insights (the why)](#insights-the-why) — 14
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 12
- [Dated events and trends](#dated-events-and-trends) — 11
- [Positioning](#positioning) — 3
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 13

## Product rules

### R50-024 — An unusually clean freemium model: reviewers do not report reminders, statistics, history or scheduling being individually paywalled — the only gate anyone describes is the habit-slot count; 'the entire monetization surface is one number. That makes it simple to reason about — and it makes a change to that number, as in 2026, unusually high-stakes'

- **Where:** §2.2 one-number monetisation surface
- **This app does:** only habit slots gated
- **User reaction:** clean; cap change high-stakes
- **Magnitude:** 0 feature-gate complaints
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C133 Gate on capability, not on quantity

### R50-031 — The tone difference is as informative as the count — at 5 habits reviewers argue for the cap: 'Tienes 5 hábitos por elegir gratis lo que considero perfecto ya que te hace ser prioritario' ('5 free habits… perfect since it makes you prioritise', ES, 5★); '5 x free habits is a great option for new habit trackers' (AU, 5★); 'The only thing is max of 5 habits, but that's pretty good, I have 5 and it's all I need, when I get a job I will actually buy a subscription to support the devs' (UA, 5★); at 3 nobody defends it: '3 hábitos gratis es una mierda' (MX, 1★); 'Great concept, however if you want to track more than 3 habits you must pay for a subscription :(' (AU, 2★); 'De manera gratuita 3 hábitos es súper poco, la versión gratuita debería ser funcional' ('the free version should be functional', MX, 1★) — interpretation: five habits was above the threshold at which a user can demonstrate a routine to themselves and was experienced as a deliberate focusing constraint; three is below it; reviewers who had been marketing the free tier (12 praise it, 4.92) were replaced by refusal — caveat: 5 reviews, 2026 H2 only 17 records

- **Where:** §3.3.1 tone at 5 vs 3
- **This app does:** cap of 5 (defended) vs 3 (refused)
- **User reaction:** 5 = focus; 3 = not functional
- **Magnitude:** 12 free-tier praise at 4.92
- **Direction for us:** mixed · **Report confidence:** medium-high · **Generalisable:** general
- **Review IDs:** `13677250370`, `12150735964`, `12224150168`, `14455227817`, `14344428965`, `14464763405`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C191 Never cap the tier someone has already paid for

### R50-055 — The documented purchase path runs through free use first: three of four intent-to-pay reviewers use the free tier and then decide (a month of free use; waiting until employed; waiting until the habits are internalised), the fourth accepts sight-unseen; two actual payers state the sequence (six months, then pro; a couple of months, then trial); one upgraded almost immediately — 'This is precisely the mechanism that a cap cut from 5 to 3 interferes with', and the clearest pay-after-proof statement was written about the 5-habit cap on 26 January 2026, less than four months before the first 3-habit report

- **Where:** §5.3 pay-after-proof path vs the cap cut
- **This app does:** cap cut blocks the free-use-first path
- **User reaction:** n/a
- **Magnitude:** 3 of 4 intent-to-pay
- **Direction for us:** negative · **Report confidence:** medium-high · **Generalisable:** general
- **Review IDs:** `12118292051`, `12224150168`, `13677250370`, `14258735288`, `12934824261`, `14310174846`, `13927542460`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R50-088 — S1 (the central recommendation): reverse, grandfather or fully disclose the 5 → 3 free-cap cut — nine who experienced 5 average 3.78 and three wrote 5★ reviews defending it; five who experienced 3 average 2.20 and none defends it; friction 18.9% → 35.3%; every documented purchase trigger runs through sustained free use first, so the cut 'attacks the only conversion path the corpus evidences'; options in order of support: (1) revert to 5 — users publicly argue for the cap at 5 ('te hace ser prioritario'); (2) grandfather existing free users at 5 and apply 3 to new installs — the angriest reviews are from people who lost capacity they already had; (3) if 3 stays, disclose it before install — four say they were not told, and one states the alternative: 'la versión gratuita debería ser funcional y la versión de paga debería agregarle un plus… en ese caso o pongamos de paga desde 0' ('the free version should be functional and the paid version should add a plus… otherwise just make it paid from zero'); magnitude not yet measurable

- **Where:** §8.2 S1 reverse, grandfather or disclose the cap cut
- **This app does:** cap cut on existing free users
- **User reaction:** loss, not a low starting cap
- **Magnitude:** 9 at 3.78 vs 5 at 2.20
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13677250370`, `14455227817`, `14074582574`, `14464763405`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C104 Never ship a paywall or feature-removal change silently; C191 Never cap the tier someone has already paid for; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R50-097 — What not to change: do not add features to raise the rating (40 feature-gap reviewers average 4.38 and supply 2 of 25 bad reviews — the rating lever is monetisation and billing); do not sacrifice simplicity for depth (simplicity 20 and flexibility 14 held simultaneously — 'Nothing comes close to the ease in navigation, creativity, options, and customizability'); do not redesign the UI again without a migration path ('counter intuitive to create an app about routine and habits and make your users keep adjusting to new layouts and programming'); do not treat support as a cost centre (17 praise, one negative, one recovered sale); do not paywall anything currently free — more reviewers praise the monetisation than complain (31 vs 26) and nothing individually gated: 'That clean one-gate model is worth protecting — and §7.2 shows what happens when the one gate moves'

- **Where:** §8.5 what not to change
- **This app does:** one gate; simple + flexible; responsive support
- **User reaction:** keep
- **Magnitude:** five keeps
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13627490790`, `12244698035`, `14310174846`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C036 A support channel that exists, is reachable outside the app, and answers; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C133 Gate on capability, not on quantity

## Must-haves

### R50-036 — UX / onboarding friction 18 (8.78%, 3.00): review prompt during onboarding 2 (both 1★); UI-redesign backlash 3 (10 Jan – 18 Feb 2025, all US, all churn-risk, none since); general design criticism 7 (3.41%, 3.14 — 'impossible to use because of terrible UI. Nothing is intuitive'; 'The UI still needs refinement (not to be confused with buggy, it's stable). Do not be discouraged by how it looks' at 5★; Korean 5★ wants it 'a bit more intuitive and easier to read' — mostly constructive feedback from fans); onboarding bimodal — confusion 4 (2.75) vs praised 3 (5.00, 'The onboarding and habit creation are straight to the point'); support praised 8, criticised once ('sometimes customer service give is not very caring')

- **Where:** §3.3.4 UX and onboarding friction
- **This app does:** n/a
- **User reaction:** constructive fans; bimodal onboarding
- **Magnitude:** 18
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13528988161`, `14237389387`, `12167788858`, `12244698035`, `12326982290`, `11028018606`, `11505876342`, `11573749562`, `14178676113`, `11599845195`, `13231582387`, `13835821016`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C075 Skippable, replayable onboarding tour; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R50-037 — The journal prompt after every task cannot be switched off — 2 reviews (0.98%, emerging, both 5★): 'I dont like that it tries to make me do a journal after every task'; 'I don't use the journaling feature and wish there were a way to turn off the prompt which is a little annoying if you don't use it' — a settings toggle neutralises both: 'Cheapest fix in the report'

- **Where:** §3.3.4 journal prompt cannot be switched off
- **This app does:** journal prompt after each completion, no toggle
- **User reaction:** annoying for non-journalers
- **Magnitude:** 2 (5★)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12178169249`, `13157545064`
- **Canonical:** C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R50-084 — F4: make the journal prompt dismissible in settings — 2 reviews, both 5★ ('I don't use the journaling feature and wish there were a way to turn off the prompt'); a single toggle neutralises both — 'Lowest-cost item in this report'

- **Where:** §8.1 F4 journal prompt toggle
- **This app does:** post-completion journal prompt, no toggle
- **User reaction:** annoyed fans
- **Magnitude:** 2 (5★)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12178169249`, `13157545064`
- **Canonical:** C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R50-087 — F7: reconcile the store listing with the product — three discrepancies: journal-app sync 'as advertised' that does not work (2★), templates the listing 'promises' ('I hope vote templates are coming as it promises', 4★), and the listing's 5-habit free cap against five reviewers reporting 3 — two reviewers rated down specifically because the app did not do what the listing said

- **Where:** §8.1 F7 reconcile listing with product
- **This app does:** listing claims: 5 free habits, journal-app sync, templates
- **User reaction:** rated down for broken promises
- **Magnitude:** 3 discrepancies
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13472233675`, `14386354700`
- **Canonical:** C181 If the app is paid-only, say so in the subtitle and first screenshot; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R50-091 — S4: treat streak-freeze / pause / archive as a retention feature and ship them together — five reviewers across three themes (pause 3, archive 2), all 3–5★, all describing the moment a streak breaks: illness, vacation, one missed day, a completed short-term goal cluttering the screen — 'If those two features were added it would be a perfect 5 stars to me!' — 'these reviewers are describing churn mechanics, not preferences'

- **Where:** §8.2 S4 streak freeze, pause, archive together
- **This app does:** no freeze, pause or archive
- **User reaction:** churn moment
- **Magnitude:** 5
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13086329598`, `12605109904`, `13956867783`, `12250094565`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot

## Must never break

### R50-009 — Billing correctness is the most severe defect class and a three-year-old unresolved pattern: 3 reviews (1.46%, meaningful, mean 1.00 — all 1★) were charged an amount that does not match what they were shown — quoted $14.99/yr, bank declined $31.01 (US, Aug 2024); no trial-expiry reminder, charged ~$50 for a year (AU, Mar 2025); quoted $14.99, charged $30 before the trial ended (US, Jan 2026) — two name the same ~$15 advertised vs ~$30 charged mismatch 17 months apart; a further 2 (0.98%, 1.00) cannot pay at all ('The app does not accept any of my cards', IT) — elevated above its share under the severe-harm exception: 'a refund, chargeback and App Store compliance exposure, not a satisfaction problem'

- **Where:** §Executive summary 4
- **This app does:** displayed annual price ≠ charged price; no trial-end reminder
- **User reaction:** all 1★
- **Magnitude:** 3 + 2
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `11673631454`, `12403255909`, `13653714543`, `12291537832`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C109 A free trial must be a real trial; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R50-012 — The notes text editor is broken in a way three users independently described, the only defect with a repeat pattern: 3 reviews (1.46%, mean 3.33) — keyboard covers the cursor and the cursor jumps back to top, 'Would be 5Stars from me if this bug was fixed' (GB, 4★, Jan 2025); 'the letters will glitch and suddenly there's always a letter by my cursor and the letter will not leave' (US, 3★, Jan 2026); 'my second sentence somehow gets pieced into my first and then none of it makes sense… since notes on progress is really what i have the app for, it really bothers me' (US, 3★, Apr 2026) — sixteen months apart; 'the cheapest rating repair available', two name it as the withheld star

- **Where:** §Executive summary 7
- **This app does:** journal text editor garbles input
- **User reaction:** withholds the fifth star
- **Magnitude:** 3 (3.33)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12208608692`, `13675051713`, `13980463198`
- **Canonical:** C228 Text fields must handle IME composition — Hangul and CJK input; C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R50-032 — Billing and trial-to-charge failures (3, 1.46%, mean 1.00, 17 months, two storefronts): 31 Aug 2024 US — quoted '$14.99 for the yearly membership' after a 'week free trial', payment declined and a bank fraud alert for $31.01; 10 Mar 2025 AU — 'They absolutely DONT SEND THE REMINDER when the trial is about to finish. That's why I just payed 50 dollars (yes, they charge you automatically the whole year)… not worthy for the price'; 20 Jan 2026 US — 'said to be $14.99 after the free trial but I was charged $30 before my free trial was up. This app is a scam'; related scam accusation 3, trial trap 2, no trial reminder 1, payment failed 2 ('The app does not accept any of my cards :(') — the only defect class producing a 1.00 mean with zero exceptions, with legal and App Store-policy exposure, and the mechanism by which a satisfied-payer base can start producing 1★

- **Where:** §3.3.2 billing table
- **This app does:** ~$15 advertised, ~$30 charged; charge before trial end; no reminder
- **User reaction:** scam; 1★
- **Magnitude:** 3 + 2
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `11673631454`, `12403255909`, `13653714543`, `12291537832`, `13528988161`
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R50-033 — Reliability 21 (10.24%, 2.81) across 17 sub-themes, none above 4 — thin and scattered: notes editor bug 3 (3.33); UI bug general 3 (2.00); regression after update 4 (3.25); data loss 2 (3.00); outage / crash 2 (1.00); stats bug 2; check-off, notification and Watch app broken 1 each (all one review); login failure 1; device unrecognised 1; perf lag 1 (5★); widget lag 1 (5★); Health sync bug after update 1 (5★); reorder bug 1; vibration control missing 1 (1★); feature removed in update 1 (4★)

- **Where:** §3.3.3 reliability table
- **This app does:** n/a
- **User reaction:** no dominant defect
- **Magnitude:** 21
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12208608692`, `13675051713`, `13980463198`, `11028018606`, `11505876342`, `14451696132`, `11116232544`, `12176154518`, `14042013960`, `14453158436`, `13927542460`, `12143541323`, `12379374379`, `12593508808`, `12605109904`, `12662311740`, `12766734680`, `10991359016`, `13089863548`, `12326982290`, `11686840765`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C073 Manual reordering, renaming and editing of habits/tasks — free; C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R50-034 — Data loss has occurred twice, once to a paying customer, and no reviewer mentions a backup or restore capability: 'I was going on months of tracking, the app just pushed an update and erased all my data without any warning or options to save' (CA, 1★, May 2026); 'a good chunk of my (to-do) Activity Entries were lost and they couldn't be recovered, but the Support Team was quick to reply and note it down' (CA, 5★, Premium, Apr 2026) — elevated above its 0.98% share under the severe-data-loss exception

- **Where:** §3.3.3 data loss
- **This app does:** update erased data; no backup / restore
- **User reaction:** months of tracking lost
- **Magnitude:** 2 (0.98%)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `14042013960`, `13927542460`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in; C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement

### R50-081 — F1: fix the trial-to-charge price mismatch and send a trial-expiry reminder — 3 reviews (1.46%, mean 1.00, every one 1★, Aug 2024 → Jan 2026): ~$15 advertised vs ~$30 charged 17 months apart, one charge landing before the trial ended, one ~$50 annual charge with no expiry warning — the only theme with a 1.00 mean and no exceptions, carrying refund, chargeback and App Store-policy exposure; elevated under the severe-harm exception

- **Where:** §8.1 F1 trial-to-charge price mismatch
- **This app does:** price shown ≠ price charged; no trial-end reminder
- **User reaction:** all 1★
- **Magnitude:** 3
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `11673631454`, `12403255909`, `13653714543`
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R50-082 — F2: fix the notes text editor — the only repeat defect (3, 1.46%, 3.33, Jan 2025 → Apr 2026), unresolved 16 months, on the second-largest differentiator (the journal, 19); two reviewers say it is the only withheld star — 'Cheapest rating repair in the report'

- **Where:** §8.1 F2 notes text editor
- **This app does:** journal editor corrupts text
- **User reaction:** withheld star
- **Magnitude:** 3
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12208608692`, `13675051713`, `13980463198`
- **Canonical:** C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R50-085 — F5: restore editing and deleting a single occurrence of a recurring habit — a capability that existed and was removed in an August 2026 update, reported by a self-described fan ('I love this but I was really disappointed in the update that took away ability…', 4★, 21 Aug 2026) — the most recent regression; a straight revert (1 review, weak)

- **Where:** §8.1 F5 restore single-occurrence editing
- **This app does:** feature removed in update
- **User reaction:** disappointed fan
- **Magnitude:** 1
- **Direction for us:** negative · **Report confidence:** low · **Generalisable:** general
- **Review IDs:** `14453158436`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R50-086 — F6: ship a visible backup / restore path and stop destructive migrations — 'the app just pushed an update and erased all my data without any warning or options to save'; a paying customer's entries could not be recovered; no reviewer in 205 mentions a backup capability — elevated under the severe-data-loss exception (2, both 2026)

- **Where:** §8.1 F6 backup / restore and no destructive migrations
- **This app does:** no backup / restore; update erased data
- **User reaction:** months lost
- **Magnitude:** 2
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `14042013960`, `13927542460`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

## Features

### R50-011 — The journal is a primary reason people choose and keep the app: 19 reviews (9.27%, high-priority, mean 4.74) praise built-in journaling / notes on habits, several saying it let them delete other apps — 'I love that there is a journaling feature embedded within it' (AE); 'I can put details of the exercise, and then I can review those notes… in a diary-like view. To me this is gold, and the best implementation I've seen of this feature' (AU); 'it let me delete a couple other apps I used to use' (US) — but its text editor is the most-reported functional bug: 'the highest-value differentiator and the worst-quality surface are the same feature'

- **Where:** §Executive summary 6
- **This app does:** notes on habits reviewable in a diary view
- **User reaction:** gold; replaced other apps
- **Magnitude:** 19 (9.27%, 4.74)
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `14009851946`, `13448518959`, `12400743554`
- **Canonical:** C172 Per-day / per-habit notes and journal text; C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R50-014 — The most-requested missing capability is pausing a habit without losing the streak — a retention feature: 3 (1.46%, mean 4.33) ask for streak freeze / habit pause and explain the mechanism — 'It makes me feel guilty for losing my streaks, but like sometimes your routine has to change for a few days!' (sickness / vacation); 'the option to "freeze" your streaks if you accidentally miss a day… it's much easier for me to continue a streak when it's large rather than from ground zero'; a fourth wants skipped days visually distinct; two more ask to archive completed habits — every one an engaged 3–5★ user describing the exact moment they are most likely to churn

- **Where:** §Executive summary 9
- **This app does:** no pause, freeze or archive
- **User reaction:** guilt; churn moment
- **Magnitude:** 3 + 1 + 2
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13086329598`, `13956867783`, `12605109904`, `12548136363`, `12250094565`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

### R50-015 — Health-integration gaps are the most common request among satisfied US users and all the same request: 5 (2.44%, mean 4.60; 4.50% of US) want data already in Apple Health to flow in automatically — weight ('frustrating when i need to put my weight manually while it can be synced from the apple health app'), mindful minutes, sleep, Apple Fitness workout types, a third-party fitness app — while 7 (3.41%, 4.71) praise the integration that exists ('I love the automatic tracking of steps, calories, etc. via health and Apple Watch especially! I loaded that up and it picked up historical data') — extension work on a shipped feature

- **Where:** §Executive summary 10
- **This app does:** Health sync for steps / calories / distance / exercise, not weight / sleep / mindful minutes
- **User reaction:** delight where it works; named gap where it stops
- **Magnitude:** 5 want; 7 praise
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13696241769`, `13089863548`, `13598469223`, `12244752465`, `11833620378`, `10993489379`
- **Canonical:** C021 Apple Health integration

### R50-021 — A broad bundle, all reportedly free within the habit cap: build and quit / reduce habits (reset-on-relapse counter — trichotillomania, drinking), journal / notes on habits with a diary view, filters and word count, tasks and lists, a day schedule with 15-minute time blocks, weekly / monthly / yearly reports with a grid map, success percentage and consistency (not only streaks), Apple Health auto-tracking with historical import, an Apple Watch app (shipped Jan–May 2025 after requests), iPhone / iPad / Mac with one account, check-off widgets (requested Mar 2024, present by Nov 2024), per-habit reminders, stopwatch and countdown, mood and body-weight trackers, colour coding, app-wide font, text size, dark mode, week-start day, per-habit units, habit templates, data export, sharing with friends and an official Reddit, in-app support chat, guided onboarding; sign-in required and limited to Sign in with Apple or Google

- **Where:** §2.1 breadth of the bundle
- **This app does:** habits + quit mode + journal + tasks + time blocks + stats + Health + Watch + Mac
- **User reaction:** breadth praised
- **Magnitude:** see inventory
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12029606193`, `13157545064`, `12662311740`, `11969962134`, `11192482249`, `12766734680`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C019 Quit-habit / bad-habit mode; C020 Data export / backup / CSV; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C023 Interactive widget check-off; C036 A support channel that exists, is reachable outside the app, and answers; C044 Mac / desktop / web app; C047 Cumulative totals and total-days counter; C049 Mood tracker; C050 One-off to-dos alongside habits; C080 Colour themes / dark mode; C118 Preset routines / templates / programs; C120 Sequential routine timer with spoken next step and live finish-time estimate; C144 Habits, focus timer and journal in one simple app; C209 No sign-up wall before first use

### R50-022 — Absent per reviewers: streak freeze / habit pause · habit archiving · Google or Apple Calendar sync · Health sync for weight, sleep and mindful minutes · Apple Fitness session types · decimal-value tracking · 'at least N times per week' goals · recurring journal templates · Pomodoro / focus music · Korean and other localisations · vision board · badges / achievements · custom hex colours · an interactive check-off widget

- **Where:** §2.1 capabilities that do not exist
- **This app does:** none of these
- **User reaction:** requested
- **Magnitude:** 14 gaps
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C021 Apple Health integration; C023 Interactive widget check-off; C027 Localise early — it unlocks revenue; C043 Flexible / custom frequency; C080 Colour themes / dark mode; C101 Milestones, achievements, celebration; C120 Sequential routine timer with spoken next step and live finish-time estimate; C199 System calendar integration — see appointments inside the plan; C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot

### R50-041 — Unmet needs (mostly 4–5★): Health-sync gaps 5 (4.60); scheduling flexibility 4 (4.00 — 15-minute increments, future start date, every-other-day, edit one occurrence); calendar integration (Apple / Google) 3 (4.67); streak freeze / pause 3 (4.33); customisation limits 3 (hex colours, habit-title length, hide streak, capitalised units); localisation 3 (5.00 — Korean twice); widget improvements 3 (interactive check-off, quick-append journal, compact, weekly progress); habit archiving 2 (3.50); recurring journal templates 2; multi-count / 'at least N per week' goals 2 (5.00); Apple Watch app before it shipped 2; Pomodoro / focus music with the timer 2 (5.00); referral or discount programme 2 (5.00); advertised feature not delivered 2 (journal-app sync; templates); singletons — decimal values, badges, vision board, time-of-day graph, richer report presentation, countdown seconds, iBooks / GitHub sync, skipped-day colour, check-off friction on duration goals, data export on downgrade

- **Where:** §3.5 unmet needs table
- **This app does:** n/a
- **User reaction:** requests from fans
- **Magnitude:** 14 needs + singletons
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `11833620378`, `12244752465`, `13089863548`, `13598469223`, `13696241769`, `11505876342`, `12112656400`, `13589666568`, `14453158436`, `11916670042`, `12383596987`, `13614269822`, `12605109904`, `13086329598`, `13956867783`, `11168412118`, `12160005173`, `13366668018`, `13894914750`, `14178676113`, `11057451287`, `13939936171`, `14451696132`, `12250094565`, `14386354700`, `13448518959`, `13618737734`, `11931971404`, `12250249874`, `10998733465`, `13388345084`, `13677250370`, `14032245863`, `13472233675`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C021 Apple Health integration; C023 Interactive widget check-off; C027 Localise early — it unlocks revenue; C043 Flexible / custom frequency; C080 Colour themes / dark mode; C118 Preset routines / templates / programs; C120 Sequential routine timer with spoken next step and live finish-time estimate; C181 If the app is paid-only, say so in the subtitle and first screenshot; C199 System calendar integration — see appointments inside the plan; C225 A one-off free promotion (App of the Week, partner promo) acquires durable users; C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot

### R50-042 — Weekly 'at least N' goals are missing though per-day multiple counts exist: 'I want to do Habit A *at least* four times a week. But ideally more!… if I track Habit A as being done Mon-Thurs, that habit is now marked as complete for the week and I can't track that I also did it Friday and Sunday' (US); the same gap described by an AU power user; 'multiple incidences per day' listed as existing — the gap is specifically the weekly 'at least' case (2, mean 5.00)

- **Where:** §3.5 at-least-N-per-week goals
- **This app does:** weekly goal closes at target; extra completions not recordable
- **User reaction:** can't log over-achievement
- **Magnitude:** 2 (5.00)
- **Direction for us:** negative · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `13618737734`, `13448518959`, `13803069187`
- **Canonical:** C043 Flexible / custom frequency

### R50-092 — S5: extend Apple Health sync to weight, sleep and mindful minutes and add Apple Fitness session types — 5 reviews (2.44%, 4.60; 4.50% of US, the joint-largest US request cluster) hand-entering data that already exists in Health, one saying weight sync would move the rating to 5; 7 praise the integration that exists — 'extension of a proven-delightful shipped feature'

- **Where:** §8.2 S5 extend Health sync
- **This app does:** Health sync partial
- **User reaction:** 5★ if extended
- **Magnitude:** 5 + 7
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13696241769`
- **Canonical:** C021 Apple Health integration

## Monetization

### R50-023 — Free / paid reconstructed from reviews: download free; habit slots capped — 5 through 26 Jan 2026, 3 by 17 May 2026; a 7-day trial ('Download, 7day free trial, then u gotta subscribe'); monthly ~$5 (US, Jan 2026), €5.99 (DE, Aug 2026), ≈$2.99 (AR, Aug 2026); annual $14.99 advertised (US, Aug 2024 and Jan 2026), $20 (US, Jan 2025), ≈$50 charged (AU, Mar 2025), $30 charged (US, Jan 2026); a lifetime tier existed by Mar 2024 ('I have lifetime access') and was still promoted in Aug 2025 ('Love that there is a lifetime membership so I don't have to pay monthly') but later reviewers ask for one as if absent ('Do you guys have lifetime subscription… I would like purchase', Nov 2025; 'I'd love to see a referral program or lifetime (larger charge) offer', May 2026; 'maybe a one time price?'); journal, stats, widgets, Health, timer, Watch, macOS and support appear free within the cap ('Has everything that u need and even more for free'); no ads (five confirm)

- **Where:** §2.2 free / paid table
- **This app does:** one gate: the habit-slot count
- **User reaction:** n/a
- **Magnitude:** 14 cap statements
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12150735964`, `11104064094`, `13677250370`, `13617932313`, `12224150168`, `11614737639`, `13590957194`, `13675051713`, `13623760288`, `14074582574`, `14344428965`, `14441435311`, `14455227817`, `14464763405`, `13616341190`, `11673631454`, `14310174846`, `13617480117`, `14451148045`, `14464639355`, `12250094565`, `12403255909`, `13653714543`, `11057451287`, `13058573989`, `13446856492`, `14032245863`, `11969620942`, `13775983529`, `13909144503`, `11844795366`, `12197163858`, `12151265942`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C007 Generous fixed habit cap (or unlimited) — never change it; C061 Goodwill conversion — a generous free tier and 'support the devs'; C063 Free trial before purchase; C127 Never show ads to paying subscribers; C133 Gate on capability, not on quantity

### R50-030 — Cap groups: states the free cap is 5 — 9 (4.39%, very strong, mean 3.78), 30 Mar 2024 → 26 Jan 2026; states 3 — 5 (2.44%, meaningful, 2.20), 17 May 2026 → 24 Aug 2026; paywall cap overall 14 (6.83%, 2.43, rating split 0/3/5/1/5 — no 5★ carries it); free cap reduced 2 (0.98%) — 'La versión gratuita redujo de 5 hábitos a 3, lo cual es una basura para planear días o en general para mí que tengo tdh y tengo que poner todas mis tareas domésticas. Lo recomiendo 0' (MX, 1★, ADHD) and 'I liked that I could add an unlimited number of habits. But then I realised it was only unlimited for the first few days. Then a screen appeared saying I had to buy a subscription or keep only three habits' (TR storefront in Russian, 4★)

- **Where:** §3.3.1 cap groups table
- **This app does:** cap 5 → 3; unlimited for the first few days then a cap screen
- **User reaction:** garbage; locked out
- **Magnitude:** 9 vs 5
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `11104064094`, `11614737639`, `12150735964`, `12224150168`, `13590957194`, `13617932313`, `13623760288`, `13675051713`, `13677250370`, `14074582574`, `14344428965`, `14441435311`, `14455227817`, `14464763405`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C219 A free cap must be concurrent, never lifetime — deleting a habit frees a slot; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R50-054 — Purchase triggers in buyers' words: extended free use first, then upgrade ('I've been using the free version for about a month and I'm going to be upgrading to premium'; 'using this for over 6 months now, I upgraded to the pro subscription'); trial → in-app one-time discount offer, lost by an accidental click and recovered by support ('Reached out to support and they immediately responded and were able to re-send that offer and I was able to accept' — support closed a sale the checkout lost); supporting the developers ('when I get a job I will actually buy a subscription to support the devs for this!!!'; 'developers have expenses, so I believe the price justifies the Premium features'); price judged low relative to the category ('relatively low compared to similar services'; 'priced the same as (or lower than) most subscription-based habit trackers'; 'Honestly would pay more for this'); the product proving itself first ('Una vez internalizados estaré encantada de pagar por más opciones'; 'if I have to pay, genuinely, so be it')

- **Where:** §5.3 purchase triggers table
- **This app does:** free use → trial → discount offer
- **User reaction:** pay after proof
- **Magnitude:** four intent-to-pay; 13 payers
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12118292051`, `12934824261`, `12732788132`, `12224150168`, `14310174846`, `13927542460`, `12144497715`, `11573749562`, `11724888497`, `13677250370`, `14258735288`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C036 A support channel that exists, is reachable outside the app, and answers; C061 Goodwill conversion — a generous free tier and 'support the devs'; C147 Let people use the product before they pay

### R50-057 — Upgrade barriers: free cap too low to evaluate or use 14 (6.83%); billing / trial charge mismatch 3 (elevated); subscription model as such 4 (1.95% — 'maybe a one time price?'); price too high for the value 3 (AU; FR student wants €2.99; DE €5.99/mo); not told the terms before installing 4 (1.95%); paywall shown almost immediately 1 ('it takes 15 Seconds to ask you for 5,99 every month', DE); upgrade nagging during normal use 2 ('a pop up insisting I pay for premium every time I open the app… it stops me from just being able to use the app', GB 1★ — the only report of the paywall obstructing ongoing free use); cannot complete payment 2; own statistics locked after hitting the cap 1 (TR)

- **Where:** §5.5 barriers table
- **This app does:** cap; nag pop-up on open; immediate paywall; stats locked at cap
- **User reaction:** n/a
- **Magnitude:** 9 barrier types
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `11969620942`, `13616341190`, `13665289168`, `14451148045`, `12403255909`, `13702978912`, `13617932313`, `14074582574`, `14464763405`, `14044173090`, `12151265942`, `12291537832`, `11673631454`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C007 Generous fixed habit cap (or unlimited) — never change it; C029 Billing must be exactly right; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R50-058 — The lifetime tier existed ('I have lifetime access', Mar 2024; 'Love that there is a lifetime membership so I don't have to pay monthly', Aug 2025) but three reviewers ask for one as though absent, two after August 2025 — 'Do you guys have lifetime subscription… I would like purchase a lifetime access subscription for this' (4★, Nov 2025); 'I'd love to see a referral program or lifetime (larger charge) offer' (5★, May 2026); 'maybe a one time price?' (3★, Nov 2024) — either withdrawn or not discoverable in the purchase flow; 'the demand signal is a 4★ reviewer explicitly saying they want to hand over money' (weak-to-meaningful, external prices unobtainable)

- **Where:** §5.5 lifetime question
- **This app does:** lifetime tier invisible to later users
- **User reaction:** asking to pay once
- **Magnitude:** 3 (want lifetime)
- **Direction for us:** negative · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `11057451287`, `13058573989`, `13446856492`, `14032245863`, `11969620942`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R50-089 — S2: make the lifetime tier discoverable or reinstate it — it existed (Mar 2024, Aug 2025) but three reviewers ask for it as if absent, one a 4★ whose entire review is 'I would like purchase a lifetime access subscription for this' — 'demand asking to be met'; it also addresses the four subscription-model objectors (mean 2.00), whose objection is to recurring billing, not to paying

- **Where:** §8.2 S2 lifetime tier discoverable
- **This app does:** lifetime not visible in the purchase flow
- **User reaction:** want to pay once
- **Magnitude:** 3 + 4
- **Direction for us:** negative · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `11057451287`, `13058573989`, `13446856492`, `14032245863`, `11969620942`
- **Canonical:** C003 Lead with a one-time lifetime purchase

## Tactics the app used

### R50-013 — Developer responsiveness is a measurable differentiator: 11 (5.37%, 4.91) praise the developers' responsiveness and 8 (3.90%, 5.00) praise support — 17 unique reviewers (8.29%) — 'the developer implemented what I asked and more - he pretty much filled all the gaps I identified'; 'they actually listen to feedback - even going the extra mile, crowdsourcing feature ideas from the community(!!!)'; 'Reached out to support and they immediately responded and were able to re-send that offer' (converted a lost checkout into a sale); a documented fix — 'be able to reorder habits without scheduling (*this was updated very soon, thank you)'; only one review negative on support — 'support is currently converting revenue and generating 5★ reviews. It is an asset to protect as the user base grows, not a cost centre to optimise'

- **Where:** §Executive summary 8
- **This app does:** fast in-app support; community-sourced features
- **User reaction:** trust; conversion; 5★
- **Magnitude:** 17 unique (8.29%)
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13448518959`, `12781523260`, `14310174846`, `12160005173`, `13835821016`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R50-059 — Two 5★ reviewers ask for a referral / discount programme — 'Me gustaría obtener recompensas por recomendar la aplicación a mis amistades i/o familiares en forma de descuentos' ('rewards for recommending the app to friends and family, as discounts'); 'I'd love to see a referral program' — with 37 comparison reviewers evangelising the app against competitors, 'an unbuilt referral mechanism is leaving the corpus's strongest asset uncaptured'

- **Where:** §5.5 referral programme
- **This app does:** no referral programme
- **User reaction:** evangelists without a capture mechanism
- **Magnitude:** 2 ask; 37 evangelise
- **Direction for us:** positive · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `13677250370`, `14032245863`
- **Canonical:** C225 A one-off free promotion (App of the Week, partner promo) acquires durable users

### R50-060 — Where users came from (small counts, consistent direction): Instagram ad 2 (5.00 — 'this app found me through an instagram ad'; one became a payer); Reddit 2 (5.00 — 'I'm also in their community on Reddit and you can tell this care about their product and people'; 'i saw this on reddit wondering which app it was because the monthly report format the person had was so pretty' — acquired by a screenshot of the monthly report); App Store search 1 ('I need a habit tracker… shopped the App Store') — the Reddit community does double duty as support and acquisition channel, and a shareable monthly report is a directly actionable marketing observation

- **Where:** §5.6 acquisition channels table
- **This app does:** Instagram ads; official Reddit; shareable monthly report
- **User reaction:** 5★ acquisitions
- **Magnitude:** 2 / 2 / 1
- **Direction for us:** positive · **Report confidence:** low · **Generalisable:** general
- **Review IDs:** `12240393741`, `13927542460`, `13321505837`, `12160005173`, `13157545064`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C134 Lead the store listing with what users actually love

### R50-090 — S3: build a referral programme — 37 comparison reviewers (18.05%, 4.89) evangelise the product unprompted and two explicitly ask for a referral mechanism: 'The corpus's strongest asset currently has no capture mechanism'

- **Where:** §8.2 S3 referral programme
- **This app does:** no referral
- **User reaction:** evangelists
- **Magnitude:** 37 + 2
- **Direction for us:** positive · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `13677250370`, `14032245863`
- **Canonical:** C225 A one-off free promotion (App of the Week, partner promo) acquires durable users

### R50-094 — Experiments: A/B the free cap at 3 vs 5 vs 7 measuring paid conversion, 30-day retention and rating ('Give me like 6 or 7 free habits and I'll be happy'); grandfather-vs-migrate on the existing free base (is the anger about the number or about losing something held); move the review prompt to a 7-day or first-streak milestone and measure rating and volume; surface the lifetime tier in the paywall and measure take-up vs monthly / annual (price objection or model objection); localise into Korean and measure KR install-to-paid; instrument checkout for price displayed vs price charged per storefront

- **Where:** §8.3 experiments table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** six experiments
- **Direction for us:** none · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `13623760288`, `14455227817`, `14074582574`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C027 Localise early — it unlocks revenue; C029 Billing must be exactly right; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C191 Never cap the tier someone has already paid for

## Insights (the why)

### R50-008 — Paying customers are not the problem — the people who never get to pay are: 9 reviewers (4.39%, very strong) give explicit purchase evidence at mean 4.11 (7 of 9 at 5★); adding 4 strongly implied payers gives 13 (6.34%) at 4.23 vs 4.27 for the 192 non-payers; only two payers are unhappy and both were hurt by billing, not the product — no trial-end reminder and auto-charged ~$50/yr (AU); 'I was charged $30 before my free trial was up' against an advertised $14.99 (US) — 'this product does not generate angry buyers. Post-purchase satisfaction is a genuine asset. The monetization risk here is entirely at the top of the funnel, at the free cap and the trial-to-charge transition'

- **Where:** §Executive summary 3
- **This app does:** freemium with a clean paid tier
- **User reaction:** payers satisfied
- **Magnitude:** 9 + 4 payers at 4.11–4.23
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12403255909`, `13653714543`
- **Canonical:** C029 Billing must be exactly right; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R50-026 — Families (n, %, mean, share of the 25 1–2★): praise (any) 135 (65.85%, 4.84, 1 of 25); feature gaps / unmet needs 40 (19.51%, 4.38, 2 of 25); monetisation positive 31 (15.12%, 4.87, 0 of 25); monetisation friction 26 (12.68%, 2.42, 12 of 25 = 48.0%); reliability defects 21 (10.24%, 2.81, 8 = 32.0%); UX / support friction 18 (8.78%, 3.00, 7 = 28.0%) — feature gaps are not a complaint channel (satisfied users writing wish-lists: 'do not treat the feature backlog as a rating-recovery lever. It is a retention and depth lever'); monetisation friction is where the bad ratings live; and more reviewers praise the monetisation than complain about it, none at 1–2★ — 'this product's pricing reputation was, until 2026, a net asset. §7.2 shows that asset being spent down'

- **Where:** §3.1 family table
- **This app does:** n/a
- **User reaction:** pricing praised more than criticised until 2026
- **Magnitude:** 31 praise vs 26 friction
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C002 Ratings follow the offer, not the feature set; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R50-028 — Praise rows: comparison (best of those tried) 37 (18.05%, 4.89); ease of use 32 (15.61%, 4.88); customisation 25 (12.20%, 4.80); design 25 (12.20%, 4.80); stats 23 (11.22%, 4.83); motivation 20 (9.76%, 4.90); simplicity 20 (9.76%, 4.90); journaling 19 (9.27%, 4.74); all-in-one 17 (8.29%, 4.94); behaviour change 16 (7.80%, 5.00); price positive 16 (7.80%, 4.81); flexibility 14 (6.83%, 5.00); free tier 12 (5.85%, 4.92); dev responsiveness 11 (5.37%, 4.91); reminders 10 (4.88%); long tenure 9 (5.00); support 8 (5.00); ADHD user 7 (4.29); Health integration 7 (4.71); bad-habit tracking 6; scheduling 6; no ads 5; intent to pay 4 (5.00); mental health 4 (5.00); widgets 4 (5.00); onboarding positive 3; performance 3; New Year use case 3

- **Where:** §3.2 master table praise rows
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 28 praise / factual rows
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** C005 Know which competitors buyers compare against; C006 Stay minimal — every addition is opt-in or off by default; C047 Cumulative totals and total-days counter; C144 Habits, focus timer and journal in one simple app

### R50-029 — Negative and mixed rows: paywall cap 14 (6.83%, 2.43, 0/3/5/1/5 — the only high-priority negative); cap 5 stated 9 (3.78); paid direct 9 (4.11); design criticism 7 (3.14); churn risk 5 (2.80); cap 3 stated 5 (2.20); Health sync gaps 5 (4.60); deceptive free 4 (2.25); other requests 4; paid probable 4 (4.50); regression after update 4 (3.25); scheduling flexibility missing 4 (4.00); subscription objection 4 (2.00); UX confusion 4 (2.75); billing unexpected charge 3 (1.00); calendar integration missing 3 (4.67); customisation missing 3; localisation missing 3 (5.00); notes editor bug 3 (3.33); price objection 3 (1.67); rating-text contradiction 3; scam accusation 3 (1.00); streak pause missing 3 (4.33); UI bug general 3 (2.00); UI regression complaint 3 (2.67); want lifetime 3 (4.00); widget improvements 3 (4.00); low-info 26 (12.68%, 4.65)

- **Where:** §3.2 master table negative and mixed rows
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 28 rows
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C021 Apple Health integration; C029 Billing must be exactly right; C043 Flexible / custom frequency

### R50-039 — Praise and what it means: comparison 37 — the differentiator (36 of 37 at 5★); ease of use 32 — depth without a learning cliff; customisation 25 — colours, fonts, units, week start, per-habit settings; design 25 — named independently of usability; stats 23 — grid view, weekly / monthly / yearly reports, consistency not just streaks; motivation 20; simplicity 20 held simultaneously with flexibility 14 — 'both at once is rare'; journaling 19 — second differentiator, replaced a separate app; all-in-one 17 (4.94) — habits + tasks + schedule + journal + mood + weight; behaviour change 16 (5.00); dev responsiveness 11 — third differentiator; support 8 (5.00) — in-app chat that recovered a sale; bad-habit tracking 6 (4.83) — quit / reduce mode valued; mental health 4 (5.00) — depression, bipolar 1, memory loss, low mood; ADHD self-identified 7 (4.29; the one exception is the 3-habit cap)

- **Where:** §3.4 praise and differentiators table
- **This app does:** n/a
- **User reaction:** three differentiators
- **Magnitude:** 15 praise themes
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C005 Know which competitors buyers compare against; C006 Stay minimal — every addition is opt-in or off by default; C019 Quit-habit / bad-habit mode; C036 A support channel that exists, is reachable outside the app, and answers; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C144 Habits, focus timer and journal in one simple app; C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R50-040 — Behaviour change 16 (7.80%, mean 5.00 — the only theme above 15 with a perfect mean): 'Helping me beat Trichotillomania… The fact that I have to reset the tracker every time I "fall back" gives me the more motivation' (UG); 'I've read more in 10 days than I have in 10 years'; 'it offers habits that you want to reduce. That has really helped me a lot to be more conscious of things I would like to be doing less like drinking'; 'I suffer with low mood/depression… having something to visually track whether I've done them really helps me' (GB); '루틴 설정 자유도도 높고… 실제로 효과본거 이게 유일합니다' ('the only one I've actually seen results from', KR); 'I've been so happy to be so disciplined because of this app' (CA) — 'the core loop demonstrably works… Every risk identified in this report is upstream of the value — at the free cap, the trial, the sign-in gate and the review prompt — or downstream of it, in the notes editor and Health sync'

- **Where:** §3.4 behaviour change verbatim
- **This app does:** reduce / quit mode with reset-on-relapse; visual tracking
- **User reaction:** life outcomes
- **Magnitude:** 16 (5.00)
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12029606193`, `13894845076`, `13157545064`, `12591713285`, `13938288598`, `13321505837`
- **Canonical:** C019 Quit-habit / bad-habit mode; C067 Fitness / health tracking use case

### R50-045 — Five stars (142): comparison 36 (25.4%), ease of use 29, low-info 22 (15.5%), design 22, customisation 21, stats 20, motivation 19, simplicity 18, all-in-one 16, behaviour change 16, journaling 15, price positive 14 (9.9%) — distinctively, 14 five-stars volunteer that the pricing is fair unprompted; quality caveat: 22 low-info and 27 ≤ 60 characters, so a meaningful share was asked to rate before forming a judgement; 5★ reviews carrying a complaint: 'Great app but the paywall annoys me', Health sync broken after update, widget lag, forced journal prompt (2), slow launch (CN)

- **Where:** §4.1 five stars
- **This app does:** n/a
- **User reaction:** fair price volunteered
- **Magnitude:** 142
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12151265942`, `12176154518`, `13089863548`, `12178169249`, `13157545064`, `10991359016`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R50-046 — Four stars (20) is a feature backlog written by fans — 14 of 20 name exactly one missing thing as the withheld star: notes-editor bug ('Would be 5Stars from me if this bug was fixed 👍'); streak pause plus once-only check-off for a duration goal ('If those two features were added it would be a perfect 5 stars to me!'); a Watch app ('almost perfect, it just needs a watch app'); journal templates, hide streak count, capitalised units; the August 2026 update that took away editing or deleting a single recurring occurrence; calendar integration; future start date; badges; archive / pause; skipped-day colour; templates; hex colours; free-tier limits ('Give me like 6 or 7 free habits and I'll be happy') — 'the cheapest star in the corpus to buy'

- **Where:** §4.2 four stars
- **This app does:** n/a
- **User reaction:** one blocker each
- **Magnitude:** 20
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12208608692`, `13086329598`, `12250249874`, `13366668018`, `14453158436`, `12383596987`, `12112656400`, `12339986976`, `12605109904`, `12548136363`, `14386354700`, `11168412118`, `13229869611`, `13623760288`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C022 Apple Watch app (done properly: timer, two-way sync); C073 Manual reordering, renaming and editing of habits/tasks — free; C199 System calendar integration — see appointments inside the plan; C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R50-047 — Three stars (18) is the paywall band: cap 5 (27.8%), cap-5 stated 5, churn risk 3 — five people who like the product and hit the cap, every one structured praise → cap → rating, none objecting to the price as an amount ('I like it so far but you have to pay for it if you want to use the app for ever because there's only 5 tasks'; 'easy to use and well designed… However you can only set FIVE habits/goals'; 'Muy buena app pero, tenemos que pagar después de poner 3 hábitos y eso es una TONTERÍA, si no fuera de pagar sería perfecta!') — 'the closest thing in this corpus to a conversion opportunity that the current cap is destroying rather than capturing'; the rest: notes-editor bug, UI regression, countdown seconds, weight sync, calendar count bug, price ('2,99€/month would be fair. I'm a student', FR), subscription-model objection (2), execution quality, support tone, device bug

- **Where:** §4.3 three stars
- **This app does:** cap stalls convinced users
- **User reaction:** praise then cap
- **Magnitude:** 18
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `11104064094`, `11614737639`, `13590957194`, `13617932313`, `14441435311`, `13702978912`, `11969620942`, `13665289168`, `11505876342`, `13835821016`, `11116232544`, `12994318961`, `13696241769`, `12593508808`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R50-048 — Two stars (5), no two sharing a product theme: forced Apple / Google sign-in privacy refusal (GB, Apr 2024); 'doesn't sync with journal app as advertised' (CA, Dec 2025); a rating / text contradiction ('It's really good', AU); the 3-habit cap (AU, Jul 2026); 'No sirve la.seccion "Lista"' plus widget requests (MX, Aug 2026) — n = 5, no pattern claimed; three of five are 2026

- **Where:** §4.4 two stars table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 5
- **Direction for us:** negative · **Report confidence:** low · **Generalisable:** app-specific
- **Review IDs:** `11192482249`, `13472233675`, `13720825762`, `14344428965`, `14451696132`
- **Canonical:** — (nuance register)

### R50-049 — One star (20) by root cause: free cap / paywall 5 (25.0% — CH, GB, DE, MX, MX); billing / trial / payment 4 (20.0%); app does not run / cannot sign in 4 (20.0% — IN, US, GB, KZ); review prompt during onboarding 2; UI quality 2; data loss 1; pay-before-try 1 ('Pay before trying won't help'); product-fit rejection 1 — nine of twenty (45%) are about money; four of the five cap-driven 1★ were written on or after 9 May 2026 and none of the 2024 one-stars is about the cap; four (20%) never used the product — 'the cheapest 1★ reviews to prevent and the most damaging, because the reviewer has no offsetting experience'

- **Where:** §4.5 one star root causes table
- **This app does:** n/a
- **User reaction:** money and never-used
- **Magnitude:** 20
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13616341190`, `14044173090`, `14451148045`, `14455227817`, `14464763405`, `11673631454`, `12291537832`, `12403255909`, `13653714543`, `12143541323`, `12379374379`, `12766734680`, `11686840765`, `13528988161`, `14237389387`, `11028018606`, `12167788858`, `14042013960`, `14248080020`, `12662311740`
- **Canonical:** C001 Never move a free feature behind the paywall; C029 Billing must be exactly right; C031 Crashes / launch failures; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R50-053 — Payers are happy — the opposite of the usual freemium pattern where buyers rate below browsers 'because they have paid for the right to be disappointed': payer mean 4.23 vs 4.27; both unhappy payers were hurt by billing, not the product; zero payers say the paid product lacks features, was ruined by bugs or was not worth it on its merits — a Premium user who lost data still wrote a 2,020-character defence of the app and its price; 'Protect it. Every monetization change should be evaluated against whether it risks converting this segment into the angry-payer segment that most competitors have'

- **Where:** §5.2 payers are happy
- **This app does:** clean paid tier, nothing individually gated
- **User reaction:** satisfied payers
- **Magnitude:** 13 at 4.23
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12403255909`, `13653714543`, `13927542460`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R50-056 — What payers value after buying: statistics depth ('receiving weekly, monthly, and annual updates on my habit progresses are extremely satisfying… a plethora of different statistics in each individual habit'); support access (three payers name it — 'they respond as soon as they can AND they actually listen to feedback'); sustained streaks and discipline ('still using it daily'); Health automation ('the apple Health integration has made my gym habit tracking basically automatic… even though I have lifetime access, I believe this is well worth the money'); 4 of 13 payers are long-tenure (≥ 6 months) and all 9 long-tenure reviewers rate 5★

- **Where:** §5.4 what paid users value
- **This app does:** stats, support, Health automation
- **User reaction:** worth it
- **Magnitude:** 4 of 13 long-tenure; long tenure 9 at 5.00
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13927542460`, `12781523260`, `14310174846`, `12934824261`, `13321505837`, `11057451287`
- **Canonical:** C021 Apple Health integration; C036 A support channel that exists, is reachable outside the app, and answers; C047 Cumulative totals and total-days counter

### R50-080 — Constants: comparison praise present in every half-year (37, 4.89) — the competitive advantage has not eroded; payer satisfaction stable (nine direct payers Mar 2024 → Jul 2026, the two 1★ payers either side of six 5★); the billing defect stable and unresolved (Aug 2024, Mar 2025, Jan 2026 — same failure mode); the notes-editor bug stable and unresolved (Jan 2025, Jan 2026, Apr 2026); January seasonality stable (22, 26)

- **Where:** §7.9 what did not change
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** five constants
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C005 Know which competitors buyers compare against; C029 Billing must be exactly right; C065 Paying customers are the highest 1★ risk — every paid feature must work; C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

## Audiences

### R50-098 — Self-identified audiences: ADHD 7 (3.41%, 4.29; 5 US at 4.80 — the one 1★ is an ADHD user whose household-task list no longer fits in 3 free habits); mental health 4 (5.00 — depression, bipolar 1, memory loss, low mood); trichotillomania and drinking reduction via the quit mode; long-tenure users 9 (all 5★); a student asking for €2.99; New Year resolvers (3; 48 January reviews); productivity-app nomads who tried 'almost every habit tracking app'

- **Where:** §3.4 adhd_user; §6.2; §8.4 Q7
- **This app does:** habits + journal + quit mode
- **User reaction:** neurodivergent and mental-health users rate it highly
- **Magnitude:** 7 + 4 + 9
- **Direction for us:** positive · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `14455227817`, `12029606193`, `13157545064`, `13702978912`, `13448518959`
- **Canonical:** C019 Quit-habit / bad-habit mode; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

## Markets and languages

### R50-043 — Localisation: two Korean reviewers ask for Korean — one wrote a detailed 5★ review in Korean and still cannot use the app in Korean; a US reviewer asks for 'other language' support; Korea produces 4 reviews, all 5★, two asking for localisation — the strongest per-capita localisation signal (limited evidence, n = 4)

- **Where:** §3.5 Korean localisation
- **This app does:** English-only UI
- **User reaction:** 5★ while asking for Korean
- **Magnitude:** 3 (5.00)
- **Direction for us:** mixed · **Report confidence:** limited evidence · **Generalisable:** general
- **Review IDs:** `13598469223`, `13894914750`, `14178676113`
- **Canonical:** C027 Localise early — it unlocks revenue

### R50-061 — Storefront distribution (28 storefronts): Storefront | n | % of 205 | Mean ★ | 5/4/3/2/1 | Eligible for standalone claims? ; United States | 111 | 54.15% | 4.477 | 83/12/9/0/7 | Yes — the only storefront ≥50 ; Canada | 16 | 7.80% | 3.812 | 7/4/2/1/2 | ⚠️ Limited evidence ; Great Britain | 16 | 7.80% | 3.875 | 9/3/0/1/3 | ⚠️ Limited evidence ; Australia | 12 | 5.85% | 4.167 | 9/0/0/2/1 | ⚠️ Limited evidence ; India | 6 | 2.93% | 4.333 | 5/0/0/0/1 | No ; Spain | 5 | 2.44% | 5.000 | 5/0/0/0/0 | No ; Mexico | 5 | 2.44% | 2.400 | 1/0/1/1/2 | ⚠️ Labelled callout only — §6.7 ; Korea | 4 | 1.95% | 5.000 | 4/0/0/0/0 | No — §6.8 ; Ukraine | 4 | 1.95% | 5.000 | 4/0/0/0/0 | No ; Germany | 3 | 1.46% | 3.667 | 2/0/0/0/1 | No ; UAE · China · France · Italy · Philippines | 2 each | 0.98% each | 5.00 / 4.00 / 4.00 / 2.00 / 5.00 | — | No ; AR · AT · CH · CZ · EG · KZ · NG · PL · RO · RU · SA · TR · UG | 1 each | 0.49% each | — | — | No — Japan returned zero written reviews (queried, complete, collected 0); the US is 54.15% so every global percentage is substantially a US percentage

- **Where:** §6.1 distribution table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 28 storefronts
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R50-062 — US top themes (denominator 111): Theme | n | % of 111 | Signal (US scope) | Mean ★ ; praise_comparison | 23 | 20.72% | high-priority | 4.83 ; praise_customization | 20 | 18.02% | high-priority | 4.75 ; praise_ease_of_use | 17 | 15.32% | high-priority | 4.88 ; low_info | 15 | 13.51% | high-priority | 4.93 ; praise_journaling | 15 | 13.51% | high-priority | 4.67 ; praise_motivation | 13 | 11.71% | high-priority | 4.85 ; praise_design | 12 | 10.81% | high-priority | 4.83 ; praise_stats | 12 | 10.81% | high-priority | 4.75 ; praise_behaviour_change | 10 | 9.01% | high-priority | 5.00 ; praise_simplicity | 10 | 9.01% | high-priority | 4.90 ; praise_all_in_one | 9 | 8.11% | high-priority | 4.89 ; praise_flexibility | 9 | 8.11% | high-priority | 5.00 ; price_positive | 9 | 8.11% | high-priority | 4.78 ; praise_dev_responsiveness | 7 | 6.31% | high-priority | 4.86 ; adhd_user | 5 | 4.50% | very strong | 4.80 ; health_sync_gaps | 5 | 4.50% | very strong | 4.60 ; paid_direct | 5 | 4.50% | very strong | 4.20 ; praise_health_integration | 5 | 4.50% | very strong | 4.60 ; praise_scheduling | 5 | 4.50% | very strong | 5.00 ; paywall_cap | 4 | 3.60% | very strong | 3.50 ; free_cap_5_stated | 4 | 3.60% | very strong | 3.25

- **Where:** §6.2 United States top themes table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 111
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R50-063 — The US (111, 54.15%, 4.477 — the highest-rated storefront with n ≥ 12, +0.21) differs in four ways: the paywall bites much less (cap 3.60% vs 10.64% of the 94 non-US; monetisation friction 9.0% vs 17.0%; no US reviewer states a 3-habit cap — all four say 5, the latest 25 Jan 2026 — either the US was not affected in the window or the price converts rather than repels there); Health and Apple-ecosystem integration is a US conversation (all 5 Health-sync gaps, 5 of 7 Health praise, both cross-platform praise); ADHD is a US-led self-identified segment (5 of 7, mean 4.80 — 'ADHD life saver ❤️'; 'This has been the best app to help me with my crazy ADHD'; 'ADD/ADHD/OCD me Loves You!!!'); the US supplies all three UI-regression complaints — where product-change risk shows up first; its 7 one-stars (6.31%, the lowest 1★ rate) are UI, billing ×2, UI regression, won't initialise, product-fit rejection and the review prompt — not one about the cap

- **Where:** §6.2 United States reading
- **This app does:** n/a
- **User reaction:** US insulated from the cap change
- **Magnitude:** 111 (4.477)
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13939936171`, `13089863548`, `13366668018`, `14361061479`, `12282629280`, `11028018606`, `11673631454`, `12167788858`, `12379374379`, `12662311740`, `13653714543`, `14237389387`
- **Canonical:** C021 Apple Health integration; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C062 Weight English-speaking rich markets; volume ≠ revenue; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R50-064 — Canada (16, 3.812, limited evidence) carries the two most severe reliability events — both data-loss reviews (May 2026 1★ 'erased all my data'; Apr 2026 Premium 5★ entries lost), almost certainly not a Canada-specific defect — and the most recent regression ('the update that took away ability to modify time or delete single reoccurring events in a day', 4★, Aug 2026); also the most detailed positive review and pricing defence; its one cap review states 5; no standalone conclusion

- **Where:** §6.3 Canada
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 16
- **Direction for us:** mixed · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `14042013960`, `13927542460`, `14453158436`, `11104064094`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C073 Manual reordering, renaming and editing of habits/tasks — free

### R50-065 — Great Britain (16, 3.875, highest 1★ rate among n ≥ 12 at 18.8%, limited evidence) is where the sign-in gate and the review prompt both fail: both sign-in problems (privacy refusal 'Stay clear.'; 'failed to register using any of the suggested methods') — two of GB's four bad reviews never got past account creation; the review-prompt complaint; the upsell-nag complaint ('a pop up insisting I pay for premium every time I open the app… it stops me from just being able to use the app', May 2026 — the only report of the paywall obstructing ongoing free use); the first notes-editor report; strong positives — depression / low mood, price vs category, a report-presentation proposal, 'Genuinely the best habit app I've ever used'

- **Where:** §6.4 Great Britain
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 16
- **Direction for us:** mixed · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `11192482249`, `12766734680`, `13528988161`, `14044173090`, `12208608692`, `12591713285`, `12144497715`, `13504655784`, `11830070878`
- **Canonical:** C035 Account system from day one; C062 Weight English-speaking rich markets; volume ≠ revenue; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R50-066 — Australia (12, 4.167, limited evidence) supplies both ends of the cap story — '5 x free habits is a great option for new habit trackers' (5★, Jan 2025) and 'if you want to track more than 3 habits you must pay for a subscription :(' (2★, Jul 2026): same storefront, 18 months apart, opposite verdicts; the most severe billing failure (auto-charged ~$50 with no trial-expiry notice); the most thorough long-tenure endorsement (a year of use, developer implemented their requests) and an Instagram ad → widget acquisition path

- **Where:** §6.5 Australia
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 12
- **Direction for us:** mixed · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `12150735964`, `14344428965`, `12403255909`, `13448518959`, `12240393741`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C029 Billing must be exactly right

### R50-067 — US (111) vs non-US (94): mean 4.477 vs 4.011 (+0.466); monetisation friction 10 (9.0%) vs 16 (17.0%) (−8.0pp); any praise 81 (73.0%) vs 54 (57.4%) (+15.6pp); states a 3-habit cap 0 vs 5 (5.3%) — every 3-cap report is non-US (Turkey, Australia, Mexico ×3); could be price sensitivity, local price points, a staged rollout or sample noise — the corpus cannot distinguish; 'US-only dashboards would not have surfaced finding 1 at all'

- **Where:** §6.6 US vs rest of world table
- **This app does:** cap change visible only outside the US
- **User reaction:** friction twice as common outside the US
- **Magnitude:** 9.0% vs 17.0%
- **Direction for us:** negative · **Report confidence:** medium · **Generalisable:** general
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R50-068 — Mexico (5, 2.400, callout only): Nov 2024 5★ 'Me encantó! Es lo que buscaba, una app completa y funcional'; 18 Aug 2026 3★ 3-habit cap 'eso es una TONTERÍA'; 20 Aug 2026 2★ broken 'Lista' section plus widget requests; 21 Aug 2026 1★ cap reduced 5 → 3, ADHD user, 'Lo recomiendo 0'; 24 Aug 2026 1★ 3-habit cap 'la versión gratuita debería ser funcional' — four of five in a seven-day window, three about the cap, corroborating the Turkey (17 May) and Australia (25 July) reports; hypothesis (untestable here): the cap change lands hardest where the subscription price is high relative to local purchasing power

- **Where:** §6.7 Mexico table
- **This app does:** 3-habit cap
- **User reaction:** recent 1–3★
- **Magnitude:** 5 (2.40)
- **Direction for us:** negative · **Report confidence:** limited evidence · **Generalisable:** general
- **Review IDs:** `11926906947`, `14441435311`, `14451696132`, `14455227817`, `14464763405`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R50-069 — Korea (4, all 5★, limited evidence): two of four ask for Korean — 'my only personal wish is that Korean still isn't supported, and that the UI design were a bit more intuitive and easier to read' (written in Korean) and a review whose whole text is 'Add korean'; a third asks for every-other-day scheduling — a perfect 5.00 mean with a 50% localisation-request rate is the cleanest unmet-demand signal from any small storefront, and localisation cost is knowable in advance

- **Where:** §6.8 Korea
- **This app does:** English-only
- **User reaction:** 5★ asking for Korean
- **Magnitude:** 4
- **Direction for us:** positive · **Report confidence:** limited evidence · **Generalisable:** general
- **Review IDs:** `14178676113`, `13894914750`, `13589666568`
- **Canonical:** C027 Localise early — it unlocks revenue

### R50-070 — High-spend group (US, JP, CN, GB, DE, CA, FR, KR, AU; externally defined): 166 (81.0%), mean 4.319, monetisation friction 18 (10.8%) vs all other storefronts 39 (19.0%), 4.026, 8 (20.5%) — friction roughly twice as common outside the group; but JP contributes 0 and CN / FR / KR 2 / 2 / 4, so the group is 155 of 166 US + GB + CA + AU and should be read as an English-language-storefront group (155, 75.6%, 4.323); high-review-volume group (storefronts ≥ 10: US, CA, GB, AU) is the same 155 — review volume, not downloads — making explicit that three-quarters of the evidence is four English-language storefronts while the central finding is driven by the remaining quarter (Turkey, Mexico, Italy, Switzerland, Germany) plus Australia

- **Where:** §6.9, §6.10 market groups
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 166 / 155
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R50-071 — 24 storefronts ≤ 6 reviews carry no standalone conclusion; three single observations are cited because material: the earliest and most detailed account of the 5 → 3 cap change plus the only report of a user locked out of their own statistics (TR); 'The app does not accept any of my cards' — a total payment failure (IT); vibration cannot be disabled — 'especially for a (supposedly) peace-of-mind application' (KZ)

- **Where:** §6.11 small-storefront caveats
- **This app does:** stats locked at cap; cards rejected; no vibration toggle
- **User reaction:** n/a
- **Magnitude:** 3 single reviews
- **Direction for us:** negative · **Report confidence:** limited evidence · **Generalisable:** general
- **Review IDs:** `14074582574`, `12291537832`, `11686840765`
- **Canonical:** C029 Billing must be exactly right; C069 Check-off sound and haptic; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

## Dated events and trends

### R50-006 — The free habit cap was cut from 5 to 3 in 2026 H1 and the review record dates it to a 16-week window: fourteen reviewers state the cap — nine say 5 (the last 26 January 2026) and five say 3 (the first 17 May 2026), zero overlap; two describe the cut as it happened — 'La versión gratuita redujo de 5 hábitos a 3, lo cual es una basura' ('The free version went down from 5 habits to 3, which is garbage', MX, 1★, 21 Aug 2026) and a Turkish-storefront reviewer who had unlimited habits for a few days then was told to 'купить подписку либо оставить только три привычки' ('buy a subscription or keep only three habits', 4★); the 5-cap group averages 3.78, the 3-cap group 2.20 — 'the clearest causal chain in the corpus… five independent reviewers in four countries writing in three languages'

- **Where:** §Executive summary 1
- **This app does:** free cap 5 → 3 (Jan–May 2026)
- **User reaction:** rating drop; 'garbage'
- **Magnitude:** 9 say 5 (3.78) vs 5 say 3 (2.20)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13677250370`, `14074582574`, `14455227817`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C104 Never ship a paywall or feature-removal change silently; C191 Never cap the tier someone has already paid for; C219 A free cap must be concurrent, never lifetime — deleting a habit frees a slot

### R50-007 — The consequences concentrate in August 2026 — the worst month by a wide margin: 9 reviews at mean 2.89 (5 of 9 at 1–2★) against a corpus mean of 4.263; monetisation-friction reviews rise from 3.1% of 2024 H1 to 35.3% of 2026 H2 (6 of 17) — an eleven-fold rise, monotonic in four of five steps (3.1% → 9.4% → 6.1% → 13.6% → 18.9% → 35.3%) — 'recent, accelerating, and specific to monetization. It is not a general decline in product quality'

- **Where:** §Executive summary 2
- **This app does:** after the cap cut
- **User reaction:** worst month
- **Magnitude:** Aug 2026 2.89; friction 35.3% of 2026 H2
- **Direction for us:** negative · **Report confidence:** medium · **Generalisable:** general
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set

### R50-019 — Half-years: 2024 H1 (from 29 Feb) 32 reviews, mean 4.594 (26/2/2/1/1) · 2024 H2 32, 4.531 · 2025 H1 49, 4.163 (7 at 1★) · 2025 H2 22, 4.409 · 2026 H1 53, 4.189 (5 at 1★) · 2026 H2 (to 4 Sep) 17, 3.471 (4 at 1★); first review 29 Feb 2024 ('Just got it, but love it so far!'), last 4 Sep 2026 ('I'm usually very anti-paying for app subscriptions but this one has been AWESOME'); January dominates (48 of 205 in two months); August 2026 (9, 2.89) the worst month — December 2025 (3, 2.67) and February 2026 (3, 3.33) too small to carry a claim

- **Where:** §1.4 half-year table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** six half-years
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** app-specific
- **Review IDs:** `10993489379`, `14510402052`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C032 New Year peak-season robustness — year-end report and January onboarding

### R50-072 — Half-year method (31 months, severe January seasonality, monthly only where n ≥ 9) and series (n, mean, monetisation friction, praise, reliability): 2024 H1 32, 4.594, 3.1%, 75.0%, 9.4% · 2024 H2 32, 4.531, 9.4%, 59.4%, 6.2% · 2025 H1 49, 4.163, 6.1%, 67.3%, 18.4% · 2025 H2 22, 4.409, 13.6%, 77.3%, 4.5% · 2026 H1 53, 4.189, 18.9%, 66.0%, 7.5% · 2026 H2 17, 3.471, 35.3%, 41.2%, 11.8% — 2026 H2 n = 17 and every claim on it labelled

- **Where:** §7.1 half-year table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** six buckets
- **Direction for us:** mixed · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R50-073 — Monetisation friction 3.1% → 9.4% → 6.1% → 13.6% → 18.9% → 35.3% — the strongest and most consistent trend, monotonic in four of five steps (the 2025 H1 reversal a January-heavy bucket of new enthusiastic users), not accompanied by any rise in reliability (9.8% vs 10.7% by halves) or UX complaints (8.8% vs 8.7%) — 'the deterioration is specific to money, not to quality'; the 35.3% endpoint is 6 of 17

- **Where:** §7.2 trend 1 monetisation friction eleven-fold
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 3.1% → 35.3%
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set

### R50-074 — The cap cut is the causal event (high confidence): a clean partition of fourteen reviewers — last '5' on 26 Jan 2026, first '3' on 17 May 2026, zero overlap, means 3.78 vs 2.20; the trends line up — monetisation friction 18.9% in the bucket containing the change and 35.3% in the first full bucket after it, where every friction review but one ('Pay before trying won't help') is cap-related

- **Where:** §7.3 trend 2 the causal event
- **This app does:** cap 5 → 3
- **User reaction:** n/a
- **Magnitude:** 14 reviewers
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `14248080020`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R50-075 — August 2026 (n = 9, mean 2.89) — the only month with n ≥ 9 and a mean below 3.5 — five of nine at 1–2★, composed exactly of the trends: immediate paywall + €5.99/mo (DE, 1★), broken list section (MX, 2★), cap 5 → 3 (MX, 1★), 3-habit cap (MX, 1★), 3-habit cap (MX, 3★), feature removed in update (CA, 4★)

- **Where:** §7.4 trend 3 August 2026
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 9 reviews, 2.89
- **Direction for us:** negative · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `14451148045`, `14451696132`, `14455227817`, `14464763405`, `14441435311`, `14453158436`
- **Canonical:** C001 Never move a free feature behind the paywall; C073 Manual reordering, renaming and editing of habits/tasks — free

### R50-076 — Praise-any 75.0% → 59.4% → 67.3% → 77.3% → 66.0% → 41.2%: the first five buckets fluctuate around ~69% with no trend, 2026 H2 is the only bucket outside and is 7 of 17 — 'Do not cite this as a finding until a later extraction adds records'; if it holds it marks the point at which the monetisation change began costing the product its advocates

- **Where:** §7.5 trend 4 praise fell
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 41.2% (7 of 17)
- **Direction for us:** negative · **Report confidence:** low · **Generalisable:** general
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R50-077 — Reliability flat and thin — 9.4% → 6.2% → 18.4% → 4.5% → 7.5% → 11.8%, 9.8% vs 10.7% by halves, no defect above 4 reviews in 31 months; 2025 H1 at 18.4% (9 of 49) is unrelated defects in a January-heavy bucket (UI-regression trio, first notes-editor report, Health-sync break after update, launch failure, login failure, calendar count bug), no regression event claimed — 'a well-built app and it has stayed well-built… the rating risk identified in this report cannot be engineered away'; exceptions: the notes editor (16 months unresolved) and the two 2026 data-loss reports

- **Where:** §7.6 trend 5 reliability flat
- **This app does:** stable engineering
- **User reaction:** n/a
- **Magnitude:** ~10% flat
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Canonical:** C031 Crashes / launch failures

### R50-078 — The UI-redesign backlash was a contained five-week event (10 Jan – 18 Feb 2025; three US reviews, all churn-risk, mean 2.67) with no recurrence in 19 months — 'a real regression shipped, users objected loudly, and it did not recur', corroborated by developer-responsiveness praise (11)

- **Where:** §7.7 trend 6 UI-redesign backlash contained
- **This app does:** redesign early 2025, not repeated
- **User reaction:** objected; resolved
- **Magnitude:** 3
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12167788858`, `12244698035`, `12326982290`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R50-079 — Requests shifted from 'does it exist' to 'does it go deep enough': 2024 asked for widgets (Mar 2024), an Apple Watch app (Nov 2024, Jan 2025), to-do lists (May 2024), calendar integration (Nov 2024) — widgets praised by Nov 2024 and the Watch app reviewed as existing by May 2025; 2025–26 asks are refinements — Health sync for weight / sleep / mindful minutes, recurring journal templates, interactive check-off widgets, streak freeze, 'at least N per week' goals — 'the product cleared its table-stakes gap list within roughly 18 months, and its backlog is now depth work driven by long-tenure users'

- **Where:** §7.8 trend 7 requests deepened
- **This app does:** widgets and Watch shipped inside the window
- **User reaction:** requests deepen
- **Magnitude:** two phases
- **Direction for us:** positive · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `11057451287`, `11931971404`, `12250249874`, `11258026649`, `11916670042`, `11969962134`, `12662311740`, `13696241769`, `13598469223`, `13089863548`, `13366668018`, `14386354700`, `13939936171`, `13618737734`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C023 Interactive widget check-off; C059 Be visibly responsive; fixes bring reviewers back

## Positioning

### R50-001 — HelloHabit — Habit Tracker (App Store ID 6476824223; subtitle 'Habit Tracker · Tasks, Routines, & Streaks'; search summaries now list it as 'HelloHabit — Daily Planner') by RightLife, Inc. (bundle com.studio.hellohabit) — 205 written reviews, 28 storefronts, 29 February 2024 → 4 September 2026, mean 4.263, extracted 8 September 2026, analysed 12 September 2026; business model free download, freemium with a hard cap on free habits, a 7-day trial and monthly / annual / lifetime tiers; the free cap was cut from 5 to 3 between late January and mid-May 2026, established from review text alone — 'the single most consequential fact in this report'

- **Where:** header lines 1-10
- **This app does:** freemium habit tracker capped on habit slots
- **User reaction:** mixed
- **Magnitude:** 205 reviews
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R50-010 — Loved for breadth plus restraint: 37 reviews (18.05%, high-priority, mean 4.89; 36 of 37 at 5★) compare it to other trackers and rank it first — the largest theme in the corpus — 'I reckon I've tried almost every habit tracking app on the App Store, and this is the one I've settled on' (AU); 'I've been trying different habit trackers since 2018 and HelloHabit is the only one that stuck' (PH); '여태껏 생산성 앱 유목민으로서… 이거는 많이 땡김' ('as a productivity-app nomad… this one really pulls me in', KR); simplicity praised by 20 (9.76%) and flexibility by 14 (6.83%) — two things usually in tension — 'the moat is that the app is both deep and uncluttered. Every roadmap decision should be tested against whether it preserves that'

- **Where:** §Executive summary 5
- **This app does:** deep but uncluttered
- **User reaction:** chose it over every other tracker
- **Magnitude:** 37 (18.05%); 20 + 14
- **Direction for us:** positive · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13448518959`, `12781523260`, `14178676113`
- **Canonical:** C005 Know which competitors buyers compare against; C006 Stay minimal — every addition is opt-in or off by default

### R50-035 — The corpus's only structured 'why not just use Apple Reminders' objection (single review, weak, not promoted): 'Setting up individual tasks is cumbersome and marking them "done" is problematic, especially on the iPhone (it's somewhat better on iPad). The new watch app is useless. It's impossible to add a Habit complication to the watch face… and notifications don't work. So far as I can see HelloHabit has no reason to exist. Reminders, Things, etc, all do a much better job' (US, 1★, May 2025) — the watch-complication and notification claims are specific enough to verify

- **Where:** §3.3.3 negative teardown
- **This app does:** new Watch app without complication
- **User reaction:** Reminders / Things do it better
- **Magnitude:** 1 (0.49%)
- **Direction for us:** negative · **Report confidence:** low · **Generalisable:** general
- **Review IDs:** `12662311740`
- **Canonical:** C005 Know which competitors buyers compare against; C022 Apple Watch app (done properly: timer, two-way sync)

## Anti-patterns

### R50-004 — The in-app review prompt fires before the user has used the product, and two reviewers documented it: 'I don't even star using this app and you ask me for a review so it's my review one start' (GB, 1★, Dec 2025); 'This app tries to take advantage of [participant reactivity bias] plus peer pressure by showing users a page of positive reviews less than two minutes after I opened the app and am going through the intro' (US, 1★, Jun 2026); 27 of 142 five-star reviews (19.0%) have bodies ≤ 60 characters and 22 (15.5%) carry no product signal — interpretation: the 4.263 mean is inflated by a prompt that fires during onboarding; treat the positive tail as weaker evidence than the uniformly specific, long-form negative tail

- **Where:** §Eight warnings 4
- **This app does:** review prompt plus a page of positive reviews during onboarding
- **User reaction:** 1★ from people with no opinion yet; inflated positive tail
- **Magnitude:** 2 documented; 27 short 5★
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13528988161`, `14237389387`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R50-017 — Repeated UI redesigns drew three long-term US users in a five-week window (10 Jan – 18 Feb 2025; 1.46%, mean 2.67, all churn-risk): 'the consistent and routine updates that makes the UI worse and worse… Update after update I'm being pushed a little more to uninstall this app' (1★); 'it's also counter intuitive to create an app about routine and habits and make your users keep adjusting to new layouts' (4★); 'this was perfect as it was when I first downloaded it! It was simple and effective, and now it's messy' (3★) — no recurrence in the 19 months since; the argument that UI churn contradicts a habit app's own premise is worth adopting internally

- **Where:** §Executive summary 12
- **This app does:** repeated layout changes early 2025
- **User reaction:** churn risk from long-term users
- **Magnitude:** 3 (2.67)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `12167788858`, `12244698035`, `12326982290`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

## Things not to do

### R50-016 — Two reviewers (0.98%, both 1★) were driven away by the review prompt itself — reviews about nothing except being asked before using the app; 'the prompt is a rating liability as well as an evidentiary one… the fix — fire the prompt after a streak milestone rather than during onboarding — costs nothing'

- **Where:** §Executive summary 11
- **This app does:** prompt during onboarding
- **User reaction:** 1★ with no opinion formed
- **Magnitude:** 2 (1.00)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13528988161`, `14237389387`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R50-038 — Sign-in is mandatory before first use and restricted to Apple or Google — 2 reviews (0.98%, 1.50), both GB: 'Looks like an amazing app but can only Sign in with Apple or Google account. Why would I want to expose every aspect of my life to data mining in this way? Stay clear' (2★) and 'failed to register using any of the suggested methods. Error: unable to login with apple. etc.' (1★) — one privacy refusal and one hard failure at the same gate: 'a conversion risk and a single point of failure'; the second never saw the product

- **Where:** §3.3.4 mandatory sign-in
- **This app does:** mandatory Apple / Google sign-in before use
- **User reaction:** privacy refusal; locked out
- **Magnitude:** 2 (1.50)
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `11192482249`, `12766734680`
- **Canonical:** C035 Account system from day one; C209 No sign-up wall before first use

### R50-093 — S6: reduce the cost of the sign-in gate — a mandatory Apple / Google account before first use is a single point of failure in front of the whole product (2, 1.50, both GB: 'Why would I want to expose every aspect of my life to data mining in this way? Stay clear.'; 'unable to login with apple'); consider a local-first trial mode, or at minimum instrument the failure rate (emerging)

- **Where:** §8.2 S6 cost of the sign-in gate
- **This app does:** mandatory account before first use
- **User reaction:** privacy refusal; hard failure
- **Magnitude:** 2
- **Direction for us:** negative · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `11192482249`, `12766734680`
- **Canonical:** C035 Account system from day one; C209 No sign-up wall before first use

## Things to do

### R50-018 — Cheapest high-value moves in evidence order: reverse or grandfather the 5 → 3 cap cut or disclose it before install (5 reviewers, 2.20, all in the last four months) → fix the trial-to-charge price mismatch and add a trial-expiry reminder (3, all 1★, 17 months) → fix the notes text editor (3, 16 months apart) → move the review prompt behind a usage milestone (2, both 1★) → ship streak-freeze / pause / archive (5, all 3–5★) → extend Health sync to weight, sleep and mindful minutes (5, 4.60) → restore editing or deleting a single occurrence of a recurring habit, removed in an August 2026 update → resolve listing-vs-product conflicts on the free cap, on journal-app sync ('doesn't sync with journal app as advertised', CA, 2★) and templates ('I hope vote templates are coming as it promises', GB, 4★)

- **Where:** §Executive summary 13
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** eight moves
- **Direction for us:** none · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `14453158436`, `13472233675`, `14386354700`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C021 Apple Health integration; C029 Billing must be exactly right; C073 Manual reordering, renaming and editing of habits/tasks — free; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C181 If the app is paid-only, say so in the subtitle and first screenshot; C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R50-083 — F3: move the review prompt behind a usage milestone — it fires during the intro before any use, generating 1★ from people with no opinion (2, mean 1.00; one calls it 'Absolutely disgusting' and names participant reactivity bias); the fix costs one conditional and would also stop inflating the corpus

- **Where:** §8.1 F3 review prompt behind a milestone
- **This app does:** prompt during onboarding
- **User reaction:** 1★; inflated 5★ tail
- **Magnitude:** 2
- **Direction for us:** negative · **Report confidence:** high · **Generalisable:** general
- **Review IDs:** `13528988161`, `14237389387`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

## Contradictions

### R50-025 — External search summaries (low confidence; listings egress-blocked) vs the corpus: summaries say free tier = 5 habits, 1 reminder per habit, 3 journal notes per day — the corpus says 5 until 26 Jan 2026 and 3 from 17 May 2026 (5 reviewers, 4 storefronts, 3 languages), and no reviewer mentions a reminder or notes cap — corpus wins, and either the listing is stale or the cap varies by cohort / storefront: 'Either way this is a disclosure problem' (two say they were not told the terms up front); IAP €2.09–€54.99 and a 7-day trial broadly consistent, no lifetime price stated; listing now 'HelloHabit — Daily Planner' vs corpus 'HelloHabit - Habit Tracker' — possible repositioning, noted not used; no claim in Parts 3–8 rests on an external source

- **Where:** §2.3 external sources table
- **This app does:** listing says 5 free habits; users report 3
- **User reaction:** not told the terms
- **Magnitude:** 5 vs 3
- **Direction for us:** negative · **Report confidence:** medium · **Generalisable:** general
- **Review IDs:** `14464763405`, `14074582574`, `13616341190`, `11673631454`
- **Canonical:** C181 If the app is paid-only, say so in the subtitle and first screenshot; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Data caveats and method

### R50-002 — Method: all 205 records read individually in full in their original languages (English, Spanish, German, French, Korean, Chinese, Arabic, Russian); hand-curated 110-theme map saved to Temp/50-review-classification.py, no regex or clustering; validated — 0 unknown IDs, 0 intra-theme duplicates, 0 unassigned records, 0 empty themes, 205/205 with ≥ 1 theme, 2.88 themes per review (max 10); appendix tables machine-generated so no ID transcribed by hand; reconciliation exact against by_country/*.jsonl (28 files), manifest.json (205; 5:142 / 4:20 / 3:18 / 2:5 / 1:20; mean 4.2634) and _state.json (zero-review storefronts including jp were queried and returned nothing); no deduplication needed (zero title+body duplicates); count, percentage, denominator (205), scope, period, signal label and review IDs on every finding; themes non-exclusive; signal thresholds <0.1% ignore · 0.1–0.5% weak · 0.5–1% emerging · 1–3% meaningful · 3–5% very strong · >5% high-priority; facts vs labelled interpretation; fields used review_id, country, rating, title, body, date; author never named; votes (138 of 205 zero, max 11, 22 net-negative) and is_edited (2) used only as integrity checks; HTML entities unescaped; body median 161 characters (min 1, max 2,020); known error risk in paid_direct vs paid_probable, low_info (26) and the two Korean and two Chinese reviews; no version field; no conversion rate inferable

- **Where:** §How to read this; §1.1, 1.2, 1.3, 1.5; §1.6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 205 (100%)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `11057451287`, `12379374379`, `12160005173`, `13472233675`, `13927542460`
- **Canonical:** — (nuance register)

### R50-003 — Small (205) and heavily positive: 142 at 5★ (69.3%), only 25 at 1–2★ (12.2%) — the inverse shape of most habit-tracker corpora, so the largest negative theme is 14 reviews and a 'high-priority' negative at 6.83% is 14 people ('read the direction and the dates, not the magnitude'); short span (2 years 6 months, young app, half-year buckets, 2026 H2 n = 17); only the US clears 50 (111, 54.15%) — Canada 16, Great Britain 16, Australia 12 limited evidence; Mexico (5) the one labelled sub-50 callout because 4 of 5 are recent and concentrated on the central finding

- **Where:** §Eight warnings 1-3
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 205; US 111
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R50-005 — No review burst (max 4 per day; 5 days with ≥ 3; largest 7-day window 12 reviews on 5–11 January 2026 — New Year seasonality; votes unremarkable) — the corpus is organically distributed; seasonality is extreme — 48 of 205 (23.4%) fall in a January (22 in Jan 2025, 26 in Jan 2026) against a 6.6-per-month baseline, so month-over-month comparisons straddling January are meaningless; classification hand-curated, not blind-automated; external sources weak — App Store and Google Play listings egress-blocked, only search summaries obtainable, and they contradict the corpus (5-habit cap and €2.09–€54.99 IAP range vs five 2026 reviewers in four storefronts reporting 3) — every price and limit is sourced to a review ID

- **Where:** §Eight warnings 5-8
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 48 in January
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R50-020 — Capability | What reviewers say it does | Evidence ; Habit tracking (build) | Core loop: create habits, check off daily, keep streaks | 13909144503 12934824261 13627490790 ; Habit tracking (quit / reduce) | Separate mode for habits you want to stop or limit; reset-on-relapse counter | 12029606193 (trichotillomania) 12732788132 13157545064 (drinking) 13939936171 ; Journal / notes on habits | Free-text notes attached to a habit, reviewable in a diary-like view, filterable by activity or category; word count | 13448518959 13402470183 12030900755 14208008885 ; Tasks / to-dos and lists | Task list and "Lista" sections distinct from habits | 14451696132 13660183912 11258026649 ; Schedule / calendar / time blocking | Day schedule with time blocks; 15-minute increments | 12240393741 11651293605 11505876342 ; Statistics and reports | Weekly / monthly / yearly habit reports, grid ("map") view, success percentage, consistency (not only streaks), graphs | 13372300873 12238726378 13939936171 13402470183 ; Apple Health integration | Auto-tracks steps, calories, distance, exercise duration; imports historical data | 10993489379 11057451287 12244752465 ; Apple Watch app | Shipped between Jan and May 2025 (requested 12250249874 Jan 2025, 11931971404 Nov 2024; reviewed as existing 12662311740 May 2025) | 12662311740 ; macOS / iPad / web companion | Same account across iPhone, iPad and Mac | 12400743554 13157545064 ; Home-screen widgets | Check-off from the widget; requested in Mar 2024, present by Nov 2024 | 11057451287 (missing) → 11969962134 12240393741 13089863548 ; Reminders / notifications | Per-habit reminders | 11057451287 11940484980 13582301378 ; Timer / stopwatch / countdown | Stopwatch and countdown for duration-based habits | 10998733465 13803069187 ; Mood tracker · body-weight tracker | Additional trackers bundled in | 12808131665 13157545064 ; Customisation | Colour coding, app-wide font choice, text size, dark mode, week start day, per-habit units | 11940484980 14282402476 10993489379 13366668018 ; Habit templates / suggestions | Pre-written habits offered at setup | 11844795366 12126987573 ; Data export | Reviewer describes "easy data export" | 13402470183 ; Social / community | Share habits with friends; an official Reddit community | 13803069187 13321505837 ; In-app support chat | Support reachable inside the app; reviewers report fast replies | 13927542460 14032245863 14310174846 ; Onboarding guides | A guided setup flow after sign-in | 12143541323 11573749562 ; Account sign-in | Required, and limited to Sign in with Apple or Google | 11192482249 12766734680

- **Where:** §2.1 feature inventory table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** n/a
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `13909144503`, `12934824261`, `13627490790`, `12029606193`, `12732788132`, `13157545064`, `13939936171`, `13448518959`, `13402470183`, `12030900755`, `14208008885`, `14451696132`, `13660183912`, `11258026649`, `12240393741`, `11651293605`, `11505876342`, `13372300873`, `12238726378`, `10993489379`, `11057451287`, `12244752465`, `12250249874`, `11931971404`, `12662311740`, `12400743554`, `11969962134`, `13089863548`, `11940484980`, `13582301378`, `10998733465`, `13803069187`, `12808131665`, `14282402476`, `13366668018`, `11844795366`, `12126987573`, `13321505837`, `13927542460`, `14032245863`, `14310174846`, `12143541323`, `11573749562`, `11192482249`, `12766734680`
- **Canonical:** — (nuance register)

### R50-027 — Master theme table, denominator 205 (theme | direction | n | % | signal | mean | 5/4/3/2/1): Theme | Direction | n | % of 205 | Signal | Mean ★ | 5/4/3/2/1 ; praise_comparison | positive | 37 | 18.05% | high-priority | 4.89 | 36/0/0/0/1 ; praise_ease_of_use | positive | 32 | 15.61% | high-priority | 4.88 | 29/2/1/0/0 ; low_info | neutral | 26 | 12.68% | high-priority | 4.65 | 22/1/1/2/0 ; praise_customization | positive | 25 | 12.20% | high-priority | 4.80 | 21/3/1/0/0 ; praise_design | positive | 25 | 12.20% | high-priority | 4.80 | 22/1/2/0/0 ; praise_stats | positive | 23 | 11.22% | high-priority | 4.83 | 20/2/1/0/0 ; praise_motivation | positive | 20 | 9.76% | high-priority | 4.90 | 19/0/1/0/0 ; praise_simplicity | positive | 20 | 9.76% | high-priority | 4.90 | 18/2/0/0/0 ; praise_journaling | positive | 19 | 9.27% | high-priority | 4.74 | 15/3/1/0/0 ; praise_all_in_one | positive | 17 | 8.29% | high-priority | 4.94 | 16/1/0/0/0 ; praise_behaviour_change | positive | 16 | 7.80% | high-priority | 5.00 | 16/0/0/0/0 ; price_positive | positive | 16 | 7.80% | high-priority | 4.81 | 14/1/1/0/0 ; paywall_cap | negative | 14 | 6.83% | high-priority | 2.43 | 0/3/5/1/5 ; praise_flexibility | positive | 14 | 6.83% | high-priority | 5.00 | 14/0/0/0/0 ; praise_free_tier | positive | 12 | 5.85% | high-priority | 4.92 | 11/1/0/0/0 ; praise_dev_responsiveness | positive | 11 | 5.37% | high-priority | 4.91 | 10/1/0/0/0 ; praise_reminders | positive | 10 | 4.88% | very strong | 4.90 | 9/1/0/0/0 ; free_cap_5_stated | factual | 9 | 4.39% | very strong | 3.78 | 3/1/5/0/0 ; long_tenure | factual | 9 | 4.39% | very strong | 5.00 | 9/0/0/0/0 ; paid_direct | factual | 9 | 4.39% | very strong | 4.11 | 7/0/0/0/2 ; praise_support | positive | 8 | 3.90% | very strong | 5.00 | 8/0/0/0/0 ; adhd_user | factual | 7 | 3.41% | very strong | 4.29 | 5/1/0/0/1 ; design_criticism | negative | 7 | 3.41% | very strong | 3.14 | 2/1/2/0/2 ; praise_health_integration | positive | 7 | 3.41% | very strong | 4.71 | 6/0/1/0/0 ; praise_bad_habit_tracking | positive | 6 | 2.93% | meaningful | 4.83 | 5/1/0/0/0 ; praise_scheduling | positive | 6 | 2.93% | meaningful | 5.00 | 6/0/0/0/0 ; churn_risk | negative | 5 | 2.44% | meaningful | 2.80 | 0/1/3/0/1 ; free_cap_3_stated | negative | 5 | 2.44% | meaningful | 2.20 | 0/1/1/1/2 ; health_sync_gaps | mixed | 5 | 2.44% | meaningful | 4.60 | 4/0/1/0/0 ; praise_no_ads | positive | 5 | 2.44% | meaningful | 5.00 | 5/0/0/0/0 ; deceptive_free | negative | 4 | 1.95% | meaningful | 2.25 | 0/1/1/0/2 ; feature_requests_other | mixed | 4 | 1.95% | meaningful | 4.25 | 2/1/1/0/0 ; intent_to_pay | positive | 4 | 1.95% | meaningful | 5.00 | 4/0/0/0/0 ; paid_probable | factual | 4 | 1.95% | meaningful | 4.50 | 3/0/1/0/0 ; praise_mental_health | positive | 4 | 1.95% | meaningful | 5.00 | 4/0/0/0/0 ; praise_widgets | positive | 4 | 1.95% | meaningful | 5.00 | 4/0/0/0/0 ; regression_after_update | negative | 4 | 1.95% | meaningful | 3.25 | 1/1/1/0/1 ; scheduling_flexibility_missing | mixed | 4 | 1.95% | meaningful | 4.00 | 1/2/1/0/0 ; subscription_objection | negative | 4 | 1.95% | meaningful | 2.00 | 0/0/2/0/2 ; ux_confusion | negative | 4 | 1.95% | meaningful | 2.75 | 1/1/0/0/2 ; billing_unexpected_charge | negative | 3 | 1.46% | meaningful | 1.00 | 0/0/0/0/3 ; calendar_integration_missing | mixed | 3 | 1.46% | meaningful | 4.67 | 2/1/0/0/0 ; customization_missing | mixed | 3 | 1.46% | meaningful | 4.33 | 1/2/0/0/0 ; localization_missing | mixed | 3 | 1.46% | meaningful | 5.00 | 3/0/0/0/0 ; new_year_use_case | factual | 3 | 1.46% | meaningful | 5.00 | 3/0/0/0/0 ; notes_editor_bug | negative | 3 | 1.46% | meaningful | 3.33 | 0/1/2/0/0 ; onboarding_positive | positive | 3 | 1.46% | meaningful | 5.00 | 3/0/0/0/0 ; praise_performance | positive | 3 | 1.46% | meaningful | 5.00 | 3/0/0/0/0 ; price_objection | negative | 3 | 1.46% | meaningful | 1.67 | 0/0/1/0/2 ; rating_text_contradiction | meta | 3 | 1.46% | meaningful | 3.67 | 1/1/0/1/0 ; scam_accusation | negative | 3 | 1.46% | meaningful | 1.00 | 0/0/0/0/3 ; streak_pause_missing | mixed | 3 | 1.46% | meaningful | 4.33 | 1/2/0/0/0 ; ui_bug_general | negative | 3 | 1.46% | meaningful | 2.00 | 0/0/1/1/1 ; ui_regression_complaint | negative | 3 | 1.46% | meaningful | 2.67 | 0/1/1/0/1 ; want_lifetime | mixed | 3 | 1.46% | meaningful | 4.00 | 1/1/1/0/0 ; widget_improvements_wanted | mixed | 3 | 1.46% | meaningful | 4.00 | 2/0/0/1/0

- **Where:** §3.2 master table (every theme ≥ 1%)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 56 themes ≥ 1% (110 total)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R50-044 — Distribution: 5★ 142 (69.3%) · 4★ 20 (9.8%) · 3★ 18 (8.8%) · 2★ 5 (2.4%) · 1★ 20 (9.8%); mean 4.263 — a J-curve with a thin negative tail, not the bimodal split of most freemium trackers; the 3★ band is where the diagnostic reviews sit; body length by rating 5★ 156 · 4★ 262 (longest — engaged users itemising what is missing) · 3★ 143 · 2★ 97 · 1★ 184

- **Where:** Part 4 distribution and shape
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 205
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R50-050 — Rating / text contradictions 3 (1.46%), retained: 2★ 'It's really good' (AU); 5★ whose body is entirely a complaint '软件打开很缓慢，请及时优化' (the software opens very slowly, CN); 4★ that is a sustained complaint about the cap cut and being locked out of her own statistics with one clause of praise (TR) — rating-only analysis carries ~1.5% noise and the 4★ band can hide a severe complaint

- **Where:** §4.6 contradictions table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 3
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** general
- **Review IDs:** `13720825762`, `10991359016`, `14074582574`
- **Canonical:** — (nuance register)

### R50-051 — Theme × rating key themes: Theme | 5★ | 4★ | 3★ | 2★ | 1★ | Mean ★ | Reading ; paywall_cap | 0 | 3 | 5 | 1 | 5 | 2.43 | Never appears in a 5★ review. Spread evenly across 1–4★ ; free_cap_5_stated | 3 | 1 | 5 | 0 | 0 | 3.78 | A cap of 5 still produced three 5★ reviews ; free_cap_3_stated | 0 | 1 | 1 | 1 | 2 | 2.20 | A cap of 3 produced none ; billing_unexpected_charge | 0 | 0 | 0 | 0 | 3 | 1.00 | Absolute ; scam_accusation | 0 | 0 | 0 | 0 | 3 | 1.00 | Absolute ; review_prompt_too_early | 0 | 0 | 0 | 0 | 2 | 1.00 | Absolute ; outage_crash | 0 | 0 | 0 | 0 | 2 | 1.00 | Absolute ; notes_editor_bug | 0 | 1 | 2 | 0 | 0 | 3.33 | Costs one to two stars, never all five ; streak_pause_missing | 1 | 2 | 0 | 0 | 0 | 4.33 | A fan's request ; health_sync_gaps | 4 | 0 | 1 | 0 | 0 | 4.60 | A fan's request ; price_positive | 14 | 1 | 1 | 0 | 0 | 4.81 | Volunteered, unprompted ; praise_comparison | 36 | 0 | 0 | 0 | 1 | 4.89 | The one exception is 12662311740, comparing *against* ; paid_direct | 7 | 0 | 0 | 0 | 2 | 4.11 | Both unhappy payers were hurt by billing, not the product ; adhd_user | 5 | 1 | 0 | 0 | 1 | 4.29 | The one 1★ is the 3-habit cap (14455227817)

- **Where:** §4.7 cross-tab table
- **This app does:** n/a
- **User reaction:** paywall cap never appears in a 5★; cap of 5 still produced three 5★, cap of 3 none; billing, scam, early prompt and outage absolute at 1★; notes bug costs one to two stars; streak pause and Health gaps are fans' requests; price positive volunteered; both unhappy payers hurt by billing
- **Magnitude:** 14 themes
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `12662311740`, `14455227817`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C029 Billing must be exactly right

### R50-052 — Payer tiers kept separate: paid_direct 9 (4.39%, very strong, 4.11, 7/0/0/0/2 — lifetime US; ~$50/yr AU; 'One of my favorite purchases ever' PH; 'I upgraded to the pro subscription'; 'I've never spent so much money on an app'; 'Well worth the $5 a month'; charged $30; 'Premium user for almost 4 months'; trial → discounted annual); paid_probable 4 (1.95%, 4.50 — 'is worth the $20 for the year'; 'Love that there is a lifetime membership so I don't have to pay monthly'; 'si hay que pagar pero para q sean 2.99 el mes vale mucho la pena'; 'I'm usually very anti-paying for app subscriptions but this one has been AWESOME'); combined 13 (6.34%, 4.23, 10/0/1/0/2) vs everyone else 192 (4.27); no conversion rate claimed

- **Where:** §5.1 payer segment table
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 13 payers
- **Direction for us:** none · **Report confidence:** high · **Generalisable:** app-specific
- **Review IDs:** `11057451287`, `12403255909`, `12781523260`, `12934824261`, `13321505837`, `13617480117`, `13653714543`, `13927542460`, `14310174846`, `12250094565`, `13058573989`, `14464639355`, `14510402052`
- **Canonical:** — (nuance register)

### R50-095 — Research questions: did the 5 → 3 cut increase net revenue (the corpus sees friction only — the question the whole report turns on); was the cap change rolled out globally or by storefront (zero US 3-cap reports; staged rollout, price-tier policy or sampling artefact); why is monetisation friction twice as high outside the US (17.0% vs 9.0%; 20.5% vs 10.8%) — local prices, purchasing power or noise; what is the actual lifetime tier status (external verification impossible, reviewer evidence conflicts)

- **Where:** Part 8 #1, Part 8 #2, Part 8 #3, Part 8 #4 — §8.4 research questions 1-4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** n/a
- **Direction for us:** none · **Report confidence:** open question · **Generalisable:** general
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C062 Weight English-speaking rich markets; volume ≠ revenue

### R50-096 — Research questions: what is the install-to-trial-to-paid funnel (13 payers support no estimate); are the two 2026 Canadian data-loss reports a migration defect or isolated incidents (server logs would settle it in minutes); how large is the ADHD segment really (7 self-identified, 3.41%, 4.29, 5 US — if it holds in the install base it is a positioning decision)

- **Where:** Part 8 #5, Part 8 #6, Part 8 #7 — §8.4 research questions 5-7
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** n/a
- **Direction for us:** none · **Report confidence:** open question · **Generalisable:** general
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R50-099 — Top themes per rating band with shares — 5★ (142): comparison 36 (25.4%) · ease of use 29 (20.4%) · low-info 22 (15.5%) · design 22 (15.5%) · customisation 21 (14.8%) · stats 20 (14.1%) · motivation 19 (13.4%) · simplicity 18 (12.7%) · all-in-one 16 (11.3%) · behaviour change 16 (11.3%) · journaling 15 (10.6%) · price positive 14 (9.9%); 4★ (20): paywall cap 3 (15.0%) · journaling 3 · customisation 3 · streak pause missing 2 · templates missing 2 · scheduling flexibility missing 2 · customisation missing 2 · stats 2 · ease of use 2 · simplicity 2; 3★ (18): paywall cap 5 (27.8%) · cap-5 stated 5 (27.8%) · churn risk 3 (16.7%) · subscription objection 2 · design criticism 2 · notes editor bug 2; 1★ (20): paywall cap 5 (25.0%) · scam accusation 3 (15.0%) · billing unexpected charge 3 (15.0%) · design criticism 2 · cap-3 stated 2 · review prompt too early 2 · outage / crash 2 · trial trap 2 · paid direct 2 · payment failed 2 · deceptive free 2 · subscription objection 2

- **Where:** §4.1, §4.2, §4.3, §4.5 band top-theme lists (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** four bands
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R50-100 — Two numbers the narrative cards dropped: across 31 months the monthly mean falls below 4.0 in only five months other than August 2026 (2.89); non-English reviews read in the original — Spanish 5, Korean 2, Chinese 2, Arabic 1, Russian 1, German 2, French 3, plus mixed — with translations marked as the analyst's

- **Where:** §Executive summary 2; §1.5 step 3
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 5 other sub-4.0 months; 16+ non-English
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)
