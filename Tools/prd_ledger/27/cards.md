# Cards — report 27

Source: `App Store Reports/27. Goal Streak - Habit Tracker - Build a growth mindset, daily (REPORT).md`  
84 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 4
- [Must-haves](#must-haves) — 6
- [Must never break](#must-never-break) — 8
- [Features](#features) — 15
- [Monetization](#monetization) — 6
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 15
- [Markets and languages](#markets-and-languages) — 4
- [Dated events and trends](#dated-events-and-trends) — 9
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 1
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 9

## Product rules

### R27-073 — Fix #7: restore the full-year grid as a selectable view and restore backfill from it — the app is literally named after this view ('Goal Streak Calendar'), four early reviewers praised it, and a 5★ reviewer still said 'I loved it before the previous update'

- **Where:** §8.1 Part 8 #7 — restore the full-year grid as a selectable view and restore backfill from it; the app is literally named after this view; a 5★ reviewer still said 'I loved it before the previous update'
- **This app does:** demoted signature view
- **User reaction:** complaint
- **Magnitude:** 2 regression + 4 praise
- **Direction for us:** product-rule · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `13077199701`, `13215630472`, `8819961417`, `10477776521`, `10787472094`, `12944050597`
- **Canonical:** C012 Week / month / year grid views; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R27-074 — Fix #8: restore one-tap note export and the day-tap record popup — the corpus's only 2★; a power-user workflow removal; one reviewer represents a workflow, not a preference

- **Where:** §8.1 Part 8 #8 — restore one-tap note export and the day-tap record popup; the corpus's only 2★; one reviewer represents a workflow, not a preference
- **This app does:** removed export
- **User reaction:** churn
- **Magnitude:** 1 (CN, 2★)
- **Direction for us:** product-rule · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `13178799590`
- **Canonical:** C020 Data export / backup / CSV; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R27-081 — Monetisation #16: do not gate any existing capability — no habit cap, no subscription for current features, no ads, no required account; 47 free-praise (34.06%), 13 competitor-price rejections, 4 keep-free pleas, 3 unlimited-habits praises, 12 no-ads praises, 4 privacy praises, and one user already watching ('No ads (yet, but I don't think there are any)'); the highest-risk action available — it would invalidate the stated reason 34% of reviewers chose the app, in a corpus where 9.42% arrived specifically to escape paywalls

- **Where:** §8.3 Part 8 #16 — do not gate any existing capability: no habit cap, no subscription for current features, no ads, no required account; the highest-risk action available — it would invalidate the stated reason 34% chose the app, in a corpus where 9.42% arrived specifically to escape paywalls; one user is already watching
- **This app does:** free, ungated
- **User reaction:** praise
- **Magnitude:** 47 + 13 + 4 + 3 + 12 + 4
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11085682019`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C082 Ads in the free tier; C209 No sign-up wall before first use

### R27-082 — Monetisation #17: if paid capability is ever needed, attach it only to something that does not exist today — an Apple Watch app, Health sync, a macOS app, or advanced analytics — and never move an existing feature behind it; platform requests exist (Watch, Health, macOS) and advanced-stats appetite too; moderate risk; even this should be A/B'd and framed as 'new, optional', not 'premium'

- **Where:** §8.3 Part 8 #17 — if paid capability is ever needed, attach it only to something that does not exist today (Watch, Health, macOS, advanced analytics) and never move an existing feature behind it; even this should be A/B'd and framed as 'new, optional', not 'premium'
- **This app does:** no paid tier yet
- **User reaction:** mixed
- **Magnitude:** 3 platform + 3 stats requests
- **Direction for us:** paid · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `14001830867`, `13999741050`, `10655126869`, `13807267873`, `12146188261`, `13987574053`
- **Canonical:** C001 Never move a free feature behind the paywall; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app

## Must-haves

### R27-011 — Data durability is an unspoken anxiety and one reviewer has already left over it: one lost all progress in the November 2025 crash ('guess its time for a new app'); one asks outright 'if my device gets reset all the data will be gone or I can recover it?'; one will not reorder habits because 'I think I will lose my data if I do that'; one found moving to a new phone 'a bit tedious'; against this, 'seamless iCloud syncing' is praised once and the listing states iCloud storage with no account — iCloud sync exists but is not legible to users; three reviewers across 2024–2025 fear data loss or ask for cross-device sync (iPad; 'wish my goals were synced across my devices'); probably shipped, definitely under-communicated

- **Where:** Executive summary #9 — data durability is an unspoken anxiety and one reviewer has left over it: lost all progress in the Nov 2025 crash; 'if my device gets reset all the data will be gone?'; will not reorder habits for fear of losing data; moving phone 'a bit tedious'; iCloud sync exists ('seamless iCloud syncing', listing confirms) but is not legible — three reviewers fear data loss or ask for sync; probably shipped, definitely under-communicated
- **This app does:** iCloud sync exists, invisible
- **User reaction:** complaint
- **Magnitude:** durability 4 (2.90%, meaningful [THIN]), mean 3.75; sync gap 3 (2.17%)
- **Direction for us:** must-have · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `13444084049`, `13491588986`, `11762567349`, `13481955817`, `10655126869`, `11937614517`, `12900579642`
- **Canonical:** C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one; C153 Automatic cloud backup on by default — never manual opt-in

### R27-046 — Onboarding has a real first-run comprehension cost: four of the five confused reviewers got past it and still rated 5★ or 4★ ('Took me a little while to figure out how to put in the streaks'; 'a lil hard to figure out at first but now super easy'; 'It took a few minutes for me to figure out how to navigate the different fields'), the fifth did not and gave 1★ — survivable for motivated users and fatal for the impatient; a 30-second first-run explainer is a low-risk fix that does not compromise minimalism

- **Where:** §4.3 Onboarding — a real first-run comprehension cost: four of five confused reviewers got past it and still rated 4–5★ ('a lil hard to figure out at first but now super easy'), the fifth did not and gave 1★; survivable for the motivated, fatal for the impatient; a 30-second first-run explainer is a low-risk fix that does not compromise minimalism
- **This app does:** no first-run explainer
- **User reaction:** mixed
- **Magnitude:** 5 (3.62%), mean 4.00; 4 recovered, 1 did not
- **Direction for us:** must-have · **Report confidence:** very strong (n=5) · **Generalisable:** yes
- **Review IDs:** `10477776521`, `12146867601`, `13220635530`, `12128390503`, `13414248154`
- **Canonical:** C075 Skippable, replayable onboarding tour

### R27-067 — Fix #1: make the widget show real data and update — at minimum current streak count, today's completion state and a colour change when done, then make it tappable to check off; reviewers gave the spec ('a small widget that just showed the current streak count for a single goal'; 'a streak counter on the widget like duolingo'; 'a grayed out version if it's still to do and a coloured version if it's done'); the only feature to generate a 1★ on its own ('Just says 0% ALL the time'), requested in every one of the four years; in a streak app the widget is the retention surface

- **Where:** §8.1 Part 8 #1 — make the widget show real data and update (current streak, today's completion, colour change when done), then make it tappable to check off; explicit specs from reviewers ('a small widget that just showed the current streak count'; 'a streak counter like duolingo'; 'grayed out if still to do and coloured if done'); the only feature to generate a 1★ on its own; requested every year
- **This app does:** static, sometimes blank widget
- **User reaction:** complaint
- **Magnitude:** 9 (6.52%, high-priority)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8865309570`, `9631112670`, `10197682121`, `11272404025`, `11937614517`, `13111651177`, `13255216161`, `13414248154`, `14088668819`
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app

### R27-072 — Fix #6: fix the dead website link in Settings ('it leads to an inactive domain') — minutes of work, reported by a 5★ promoter, and it currently breaks the only support path

- **Where:** §8.1 Part 8 #6 — fix the dead website link in Settings; minutes of work, reported by a promoter, and it currently breaks the support path entirely
- **This app does:** support link dead
- **User reaction:** complaint
- **Magnitude:** 1 (CA, 5★)
- **Direction for us:** must-have · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `11393669723`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C142 Surface existing features where users look

### R27-076 — Feature #10: make iCloud sync and backup visible and verifiable in-app — a Settings line 'Backed up to iCloud · last synced <time>' plus an explicit restore path; the listing confirms iCloud storage exists but users cannot tell it is working; one churned over presumed data loss and another asks the question directly in a 5★ review; a communication fix, not an engineering one

- **Where:** §8.2 Part 8 #10 — make iCloud sync and backup visible and verifiable in-app ('Backed up to iCloud · last synced <time>' plus an explicit restore path); users cannot tell a shipped feature is working; one churned over presumed data loss; a communication fix, not an engineering one
- **This app does:** invisible sync
- **User reaction:** complaint
- **Magnitude:** 4 + 3 sync
- **Direction for us:** must-have · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `11762567349`, `13444084049`, `13481955817`, `13491588986`, `10655126869`, `11937614517`, `12900579642`
- **Canonical:** C030 Sync must work — and prove it; C153 Automatic cloud backup on by default — never manual opt-in

### R27-078 — Feature #12: add a 30-second first-run explainer that can be skipped — four of five confused reviewers survived and stayed, one gave 1★; keep it skippable because minimalism is the product (52 reviews)

- **Where:** §8.2 Part 8 #12 — a 30-second skippable first-run explainer; four of five survived the confusion, one gave 1★; keep it skippable — minimalism is the product
- **This app does:** no onboarding
- **User reaction:** mixed
- **Magnitude:** 5 (3.62%)
- **Direction for us:** must-have · **Report confidence:** very strong (n=5) · **Generalisable:** yes
- **Review IDs:** `10477776521`, `12128390503`, `12146867601`, `13220635530`, `13414248154`
- **Canonical:** C075 Skippable, replayable onboarding tour

## Must never break

### R27-022 — Reminders are free but fire even after the goal is marked done; widgets are read-only, non-interactive and sometimes blank; habit reordering shipped by Aug 2025 and the order does not stick ('they keep getting jumbled up and going back to the wrong spots'); tags cannot be selected from existing ones and duplicates don't group

- **Where:** §2.1 Reminders free but fire even after completion; widgets read-only, non-interactive, sometimes blank; habit reordering shipped by Aug 2025 but the order does not stick; tags — cannot select existing, duplicates don't group
- **This app does:** small defects in the 2025 window
- **User reaction:** complaint
- **Magnitude:** reminder 1; widget 9; reorder 3; tags 2
- **Direction for us:** must-never-break · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `13923424034`, `14165879048`, `14088668819`, `12973708986`, `13118792795`, `11762567349`, `13608165763`, `13243690627`, `13491426055`
- **Canonical:** C039 Reminders fire reliably, once; C040 Widgets must not go blank, stale or disagree with the app; C045 Grouping / folders / categories / tags; C073 Manual reordering, renaming and editing of habits/tasks — free

### R27-033 — Habit order does not persist: reordering shipped between Sept 2024 and Aug 2025 (praised 'the feature to reorganize your habits in a list of your preferred sequence') and behaved unreliably one month later ('they keep getting jumbled up and going back to the wrong spots in the list'); one user cannot reorder and fears data loss from delete-and-re-add; one wants grouping by the time a habit is set for

- **Where:** §3.3 Defect 3 — habit order does not persist (3 [THIN]): reordering shipped between Sept 2024 and Aug 2025 (praised) and behaved unreliably one month later ('they keep getting jumbled up'); one user cannot reorder and fears data loss from delete-and-re-add; one wants categorisation by time set
- **This app does:** reorder shipped, unreliable
- **User reaction:** complaint
- **Magnitude:** 3 (2.17% [THIN]), mean 4.00
- **Direction for us:** must-never-break · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `13118792795`, `11762567349`, `13608165763`, `12973708986`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R27-034 — Tags: 'Every time, it just gives the option to add new tag but never the option to select from an old tag' (IN, 3★) and 'Tags not working, same tags doesn't group in one' (RU, 4★) — two reviewers, two storefronts, two months apart, describing the same bug from different angles

- **Where:** §3.3 Defect 4 — tags: 'it just gives the option to add new tag but never the option to select from an old tag'; 'same tags doesn't group in one' — two reviewers, two storefronts, two months apart, same bug
- **This app does:** tag selection broken
- **User reaction:** complaint
- **Magnitude:** 2 (1.45% [THIN]), mean 3.50
- **Direction for us:** must-never-break · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `13243690627`, `13491426055`
- **Canonical:** C045 Grouping / folders / categories / tags

### R27-051 — The one observed churn event — 'It doesnt open with the update, ive lost all my progress, guess its time for a new app. Thanks btw.' — is a reliability-plus-data-loss event, not a price event; with 'this was one of the best apps I have had now it just doesn't work', the corpus shows the app's churn risk is concentrated entirely in release quality and data durability, not in monetisation

- **Where:** §5.4 The one observed churn event — 'It doesnt open with the update, ive lost all my progress, guess its time for a new app' — a reliability-plus-data-loss event, not a price event; churn risk is concentrated entirely in release quality and data durability
- **This app does:** update broke launch and lost data
- **User reaction:** churn
- **Magnitude:** 1 stated churn; 4 1★ all reliability
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13444084049`, `13240874103`
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change

### R27-068 — Fix #2: fix habit ordering so the chosen order persists — a shipped feature that silently fails; one user avoids it entirely for fear of data loss

- **Where:** §8.1 Part 8 #2 — fix habit ordering so the chosen order persists; a shipped feature that silently fails, one user avoids it for fear of data loss
- **This app does:** reorder does not stick
- **User reaction:** complaint
- **Magnitude:** 3 + 1 confirming
- **Direction for us:** must-never-break · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `11762567349`, `13118792795`, `13608165763`, `12973708986`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R27-069 — Fix #3: make existing tags selectable and group duplicates — two storefronts, two months apart, the same bug, both cost stars

- **Where:** §8.1 Part 8 #3 — make existing tags selectable and group duplicates; two storefronts, two months apart, same bug, both cost stars
- **This app does:** tag picker broken
- **User reaction:** complaint
- **Magnitude:** 2
- **Direction for us:** must-never-break · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `13243690627`, `13491426055`
- **Canonical:** C045 Grouping / folders / categories / tags

### R27-070 — Fix #4: stop the reminder firing for a goal already marked complete today — a notification that contradicts app state actively trains users to ignore notifications

- **Where:** §8.1 Part 8 #4 — stop the reminder firing for a goal already marked complete today; a notification that contradicts app state trains users to ignore notifications
- **This app does:** reminder fires after completion
- **User reaction:** complaint
- **Magnitude:** 1 (DE, 4★)
- **Direction for us:** must-never-break · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `14088668819`
- **Canonical:** C039 Reminders fire reliably, once

### R27-071 — Fix #5: fix the icon/symbol edit reverting to the original — a write that silently fails, in the same release window as the crash cluster

- **Where:** §8.1 Part 8 #5 — fix the icon/symbol edit reverting to the original; a write that silently fails, same release window as the crashes
- **This app does:** edit reverts
- **User reaction:** complaint
- **Magnitude:** 1 (CA, 3★)
- **Direction for us:** must-never-break · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `13498254162`
- **Canonical:** C009 Basic widgets, icons and colours are free

## Features

### R27-009 — The widget is the app's most consistently under-delivering surface and the only surface that produced a 1★ on its own — 'Widget does and shows absolutely nothing… Just says 0% ALL the time'; 9 gap/defect reviews (6.52%, mean 4.33) spanning 2022–2026 ask for a widget at all, more sizes, a streak-count widget, a Duolingo-style streak counter, an interactive check-off widget, progression shown, and colour reflecting today's completion, against 5 (3.62%) who praise it; it is read-only, static, and at least sometimes broken — in a streak app the widget is the retention surface; the highest-value engineering gap in the corpus

- **Where:** Executive summary #7 — the widget is the most consistently under-delivering surface and the only one that produced a 1★ on its own ('Widget does and shows absolutely nothing… Just says 0% ALL the time'): 9 gap/defect reviews across four years (no widget, more sizes, streak count, Duolingo-style counter, interactive check-off, doesn't show progression, colour should reflect completion) vs 5 praising it; read-only, static, sometimes broken — in a streak app the widget is the retention surface; the highest-value engineering gap
- **This app does:** read-only static widget, sometimes blank
- **User reaction:** complaint
- **Magnitude:** gap/defect 9 (6.52%, high-priority), mean 4.33; praise 5 (3.62%); one 1★
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8865309570`, `9631112670`, `10197682121`, `11272404025`, `11937614517`, `13111651177`, `13255216161`, `14088668819`, `13414248154`, `8819961417`, `10765907509`, `11088501172`, `13919778285`, `14179666010`
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app

### R27-010 — A monthly view / monthly summary is the second-largest unmet need — requested five times over four years (2022 '希望能增加月视图' → 2026 'a monthly overview of your progress'; 'I can't summarize by week or by month'), never shipped; two of the five are 3★, the only feature request in the corpus that repeatedly costs stars; the app has daily, weekly and yearly views and the month is the missing rung

- **Where:** Executive summary #8 — the second-largest unmet need is a monthly view, requested five times over four years and never shipped; two of these are 3★ — the only feature request that repeatedly costs stars; the app has daily, weekly and yearly views and the month is the missing rung
- **This app does:** day/week/year views, no month
- **User reaction:** complaint
- **Magnitude:** 5 (3.62%, very strong), mean 4.00; 2 3★
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8918509405`, `13155678708`, `13463476864`, `13642789952`, `14239313970`
- **Canonical:** C012 Week / month / year grid views

### R27-017 — Habit creation with custom name, colour and icon, app icon change and colour themes are all free; there is no fine-grained theme tuner, and the icon/symbol edit sometimes instantly reverts (a data-write defect in the crash window)

- **Where:** §2.1 Habit creation with custom name, colour, icon; app icon change; themes (no fine-grained tuner); icon edit sometimes reverts
- **This app does:** free customisation; icon edit reverts
- **User reaction:** mixed
- **Magnitude:** customisation praised 10 (7.25%, mean 4.80); 1 revert defect
- **Direction for us:** free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `12132900869`, `13923424034`, `14196975012`, `11346385680`, `12973708986`, `13233606022`, `12041030739`, `12877783902`, `13498254162`, `13919778285`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R27-018 — The year-at-a-glance calendar grid is a signature feature that the 2025 update demoted behind a per-habit tap; daily list and weekly review exist; a monthly view is absent and requested five times

- **Where:** §2.1 Year-at-a-glance calendar grid — a signature feature, demoted in the 2025 update; daily list; weekly review; monthly view absent (requested 5×)
- **This app does:** day/week/year, no month; year grid demoted
- **User reaction:** mixed
- **Magnitude:** grid praised 4; regression 2; monthly 5
- **Direction for us:** must-have · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8819961417`, `10477776521`, `10787472094`, `12944050597`, `8918509405`, `13077199701`, `13215630472`, `11346385680`, `10639973409`, `13463476864`, `10966990397`
- **Canonical:** C012 Week / month / year grid views; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R27-019 — Backfill by tapping past dates is praised (and broke for the annual grid in 2025); mark-all-goals-for-a-date exists; multiple completions per day shipped ~Aug 2025 ('the multiple check-ins per day feature works well'); flexible frequency (a few times a week) shipped and is praised; per-weekday scheduling (skip Sat/Sun) is requested and not confirmed

- **Where:** §2.1 Backfill by tapping past dates — praised, broke for the annual grid in 2025; multi-tap / mark all goals for a date; multiple completions per day shipped ~Aug 2025; flexible frequency (x per week) shipped; per-weekday scheduling requested, not confirmed
- **This app does:** backfill, multi-count, N×/week free
- **User reaction:** praise
- **Magnitude:** flexible frequency praised 3 (2.17%, mean 4.67)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11346385680`, `13077199701`, `13987574053`, `13903934801`, `12944050597`
- **Canonical:** C010 Backfill missed days / edit start date; C043 Flexible / custom frequency; C143 Intra-day completion: tap N times to fill N/N

### R27-020 — Streaks are the core, praised feature (streak length is hard to see from the day list); a streak freeze is on the listing but zero reviewers mention it; statistics and data export are praised ('Love all the stats it records'; 'export data for nerdy kind') and the one-tap note export was removed in 2025

- **Where:** §2.1 Streaks are the core feature; streak length hard to see from the list; streak freeze is on the listing but zero reviewers mention it; statistics and data export praised ('export data for nerdy kind'); one-tap note export removed 2025
- **This app does:** streaks, stats, export free
- **User reaction:** praise
- **Magnitude:** 5 streak IDs; stats/export praised 3 (2.17%, mean 5.00)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `10477776521`, `10780603796`, `12582425991`, `14099500769`, `14179666010`, `11088501172`, `13807267873`, `13987574053`, `12146188261`, `13178799590`
- **Canonical:** C020 Data export / backup / CSV; C024 Streaks / gamification; C142 Surface existing features where users look

### R27-021 — Journal / daily memo prompts exist and their value is disputed — 'simply yet engaging daily memo questions' vs 'the note taking doesn't really have a point to it'; a fuller daily log is wanted

- **Where:** §2.1 Journal / notes / daily memo prompts — value disputed ('simply yet engaging daily memo questions' vs 'the note taking doesn't really have a point to it'); a fuller daily log wanted
- **This app does:** notes exist, shallow
- **User reaction:** mixed
- **Magnitude:** notes/journal gap 3 (2.17%, [THIN]), mean 3.33
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `12136156984`, `13761980153`, `12473008094`
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R27-023 — iCloud sync is confirmed once ('seamless iCloud syncing') then invisible; a goal end date and habit archiving are on the listing but a Dec 2025 reviewer asked for exactly those as missing; dark mode is listed with no comments; Apple Health, Apple Watch and macOS are absent and requested once each; a Monday week start is requested twice

- **Where:** §2.1 iCloud sync confirmed once then invisible; goal end date and archiving are on the listing but a Dec 2025 reviewer asked for exactly those as missing; dark mode listed; Apple Health, Apple Watch, macOS absent and requested once each; Monday week start requested twice
- **This app does:** listed features not discoverable
- **User reaction:** complaint
- **Magnitude:** sync 1+4; end date/archive 1; Health 1; Watch 1; Mac 1; Monday 2
- **Direction for us:** must-have · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `10655126869`, `11937614517`, `12900579642`, `13481955817`, `13491588986`, `13498254162`, `13999741050`, `14001830867`, `10795403293`, `10966990397`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C142 Surface existing features where users look; C153 Automatic cloud backup on by default — never manual opt-in; C170 Configurable day boundary and hemisphere seasons

### R27-024 — No account or login is required and it is praised as a feature (4, mean 5.00); no ads (12 praise, 8.70%, mean 4.83); no IAP; the website link in Settings points at an inactive domain

- **Where:** §2.1 No account required — praised as a feature; no ads (12 praise); no IAP; the website link in Settings points at an inactive domain
- **This app does:** no account, no ads, dead link
- **User reaction:** praise
- **Magnitude:** privacy/no-account 4 (2.90%); no-ads 12 (8.70%)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `12146188261`, `13490755611`, `13974276382`, `12023192028`, `10787472094`, `11085682019`, `11756328020`, `11762567349`, `12418040350`, `12926444561`, `12944050597`, `12973708986`, `13487801599`, `13933124385`, `14037309039`, `11393669723`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C082 Ads in the free tier; C085 Address tracking / privacy visibly; C209 No sign-up wall before first use

### R27-029 — Onboarding confusion runs at 5 (3.62%, very strong, mean 4.00, mixed direction) — including accidental habit creation when tapping a day on the main screen

- **Where:** §3.1 onboarding_confusion 5 (3.62%, mean 4.00, mixed); accidental habit-add when tapping a day (1)
- **This app does:** no guided onboarding
- **User reaction:** mixed
- **Magnitude:** 5 (3.62%), mean 4.00
- **Direction for us:** must-have · **Report confidence:** very strong (n=5) · **Generalisable:** yes
- **Review IDs:** `12023192028`
- **Canonical:** C075 Skippable, replayable onboarding tour

### R27-036 — Two reviewers want to backfill or import an existing streak by start date — carrying a streak in from another app or a previous phone

- **Where:** §3.4 #9 Backfill / import an existing streak by start date — 'moving to a new phone a bit tedious'; carrying a streak in from elsewhere
- **This app does:** no streak import
- **User reaction:** complaint
- **Magnitude:** 2 (1.45% [THIN]), mean 4.50
- **Direction for us:** build-free · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `13077199701`, `13481955817`
- **Canonical:** C010 Backfill missed days / edit start date

### R27-038 — A goal end date so that a completed goal stops repeating but stays visible — asked for by a 3★ reviewer who also could not find archiving, both of which the listing claims

- **Where:** §3.5 A goal end date so completed goals stop repeating but stay visible — one reviewer, 3★, Dec 2025 (listed as a feature, not found)
- **This app does:** listed but not findable
- **User reaction:** complaint
- **Magnitude:** 1 (0.72%)
- **Direction for us:** research · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `13498254162`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C142 Surface existing features where users look

### R27-075 — Feature #9: ship a monthly view and a monthly summary — the app has daily, weekly and yearly and the month is missing; the only feature request that repeatedly costs stars (2 of the 6 3★), open for four years across four storefronts

- **Where:** §8.2 Part 8 #9 — ship a monthly view and monthly summary; the only feature request that repeatedly costs stars (2 of 6 3★); open four years across four storefronts
- **This app does:** no month view
- **User reaction:** complaint
- **Magnitude:** 5 (3.62%, very strong)
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8918509405`, `13155678708`, `13463476864`, `13642789952`, `14239313970`
- **Canonical:** C012 Week / month / year grid views

### R27-077 — Feature #11: per-weekday scheduling ('I want to run 1 mile per day during the week, and skip Saturday + Sunday') and streak import by start date ('setting a start date and the streak being automatically completed from that date, moving to a new phone was a bit tedious') — both concrete, bounded, asked by 5★ users; weekly-frequency support already partially exists

- **Where:** §8.2 Part 8 #11 — per-weekday scheduling ('run 1 mile per day during the week, and skip Saturday + Sunday') and streak import by start date ('the streak being automatically completed from that date'); both concrete, bounded, asked by 5★ users
- **This app does:** no weekday schedule; no streak import
- **User reaction:** complaint
- **Magnitude:** 1 + 1
- **Direction for us:** must-have · **Report confidence:** single reviews · **Generalisable:** yes
- **Review IDs:** `12944050597`, `13481955817`, `13903934801`
- **Canonical:** C010 Backfill missed days / edit start date; C043 Flexible / custom frequency

### R27-079 — Feature #13: make the streak length readable from the day list — the streak is the core metric and currently requires drilling in (a full interaction spec given); Feature #14: a Monday week-start setting — two requests in early 2024 and none since, so verify whether it already shipped before building

- **Where:** §8.2 Part 8 #13 — make the streak length readable from the day list (a full interaction spec given); #14 — a Monday week-start setting (two early-2024 requests, none since — verify whether it shipped)
- **This app does:** streak hidden in list; week start fixed
- **User reaction:** complaint
- **Magnitude:** 1; 2
- **Direction for us:** must-have · **Report confidence:** single / [THIN] · **Generalisable:** yes
- **Review IDs:** `11088501172`, `10795403293`, `10966990397`
- **Canonical:** C142 Surface existing features where users look; C170 Configurable day boundary and hemisphere seasons

## Monetization

### R27-012 — There is demand to pay — voluntarily — and demand not to be charged, and both come from the same people: tip jar / donation requests 2 (1.45%) — 'Keep the free app, consider adding a tip jar for users who are thankful'; 'it would be nice to donate to the dev since it's a free app'; pleas to stay free 4 (2.90%) — 'i urge you to please keep the app free as long as possible'; 'Please keep this free'; and 'Please don't take it down or anything because I will cry'; the only monetisation the corpus endorses is non-coercive — a tip jar, a donation, a paid cosmetic; any gate on existing functionality would attack the exact attribute 47 reviewers named as the reason they are here — the central commercial finding

- **Where:** Executive summary #10 — demand to pay voluntarily and demand not to be charged come from the same people: tip-jar/donation requests 2 ('Keep the free app, consider adding a tip jar'); pleas to stay free 4 ('i urge you to please keep the app free as long as possible'); 'Please don't take it down or anything because I will cry' — the only monetisation the corpus endorses is non-coercive; any gate on existing functionality would attack the attribute 47 reviewers named as why they are here; the central commercial finding
- **This app does:** no monetisation; tip jar requested
- **User reaction:** purchase-driver
- **Magnitude:** tip jar 2 (1.45%, [THIN]), mean 5.00; keep-free pleas 4 (2.90%), mean 5.00
- **Direction for us:** product-rule · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `10787472094`, `11393669723`, `11937614517`, `12944050597`, `14383016940`, `13989106663`
- **Canonical:** C001 Never move a free feature behind the paywall; C097 A tip / donate option

### R27-025 — Everything is free and habit count is explicitly unlimited ('unlimited habit tracking without ads'; 'has no limitations'; 'i didn't need to pay to use a certain amount of habits'); nothing is paid, trial-gated, subscription-gated or one-time-gated, and no reviewer in four years reports a paywall, upsell, trial prompt or locked feature; the listing (Free, no IAP, no data collected, local + iCloud, no account, 14.5 MB, v2026.36.0) corroborates exactly

- **Where:** §2.2 Monetisation classification table (verbatim) — free: everything, unlimited habits ('has no limitations'); paid / trial / subscription / one-time / unclear: nothing; [LISTING] Free, no IAP, no data collected, iCloud with no account — corroborates the reviews exactly
- **This app does:** free, unlimited
- **User reaction:** praise
- **Magnitude:** Classification | Features ; Free | Everything above that reviewers confirm. Habit count is explicitly unlimited: "unlimited habit tracking without ads" (14037309039), "has no limitations" (12926444561), "i didn't need to pay to use a certain amount of habits" (14196975012). ; Paid | *Nothing.* ; Trial-gated | *Nothing.* ; Subscription-gated | *Nothing.* ; One-time-purchase-gated | *Nothing.* ; Unclear | *Nothing.* No reviewer in four years reports encountering a paywall, an upsell, a trial prompt, or a locked feature.
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `14037309039`, `12926444561`, `14196975012`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it

### R27-026 — Monetisation-adjacent signals: praises free/no-IAP 47 (34.06%, mean 4.89); contrasts with paid competitors 13 (9.42%, 4.92); praises absence of ads 12 (8.70%, 4.83); praises unlimited habits 3 (2.17%, 5.00); asks the developer to keep it free 4 (2.90%, 5.00); offers to pay voluntarily 2 (1.45%, 5.00); praises no-account/privacy 4 (2.90%, 5.00); claims to have paid 0 — 'a small number would volunteer money, and a comparable number would experience a mandatory charge as a breach'; one reviewer writes both sentences: 'Keep the free app, consider adding a tip jar for users who are thankful'

- **Where:** §2.2 Monetisation-adjacent signals table (verbatim) — free/no-IAP 47 (34.06%); competitor price contrast 13 (9.42%); no ads 12 (8.70%); unlimited habits 3; keep-free pleas 4; tip jar 2; no-account/privacy 4; claims to have paid 0
- **This app does:** free; tip jar the only endorsed monetisation
- **User reaction:** purchase-driver
- **Magnitude:** Signal | n | % of 138 | Label | Mean | IDs ; Praises free / no-IAP / no-subscription / no-paywall | 47 | 34.06% | HIGH-PRIORITY | 4.89 | see Part 10.4 ; Contrasts with paid/expensive competitors | 13 | 9.42% | HIGH-PRIORITY | 4.92 | 10765907509, 11085682019, 11527965143, 13069916662, 13086712965, 13233606022, 13571505007, 13587881498, 13919778285, 13974276382, 14037309039, 14118395021, 14281981627 ; Praises absence of ads | 12 | 8.70% | HIGH-PRIORITY | 4.83 | 10787472094, 11085682019, 11756328020, 11762567349, 12418040350, 12926444561, 12944050597, 12973708986, 13487801599, 13490755611, 13933124385, 14037309039 ; Praises unlimited habits specifically | 3 | 2.17% | meaningful [THIN] | 5.00 | 12926444561, 14037309039, 14196975012 ; Asks the developer to keep it free | 4 | 2.90% | meaningful [THIN] | 5.00 | 10787472094, 11937614517, 12944050597, 14383016940 ; Offers to pay voluntarily (tip jar / donation) | 2 | 1.45% | meaningful [THIN] | 5.00 | 10787472094, 11393669723 ; Praises no-account / privacy | 4 | 2.90% | meaningful [THIN] | 5.00 | 12023192028, 12146188261, 13490755611, 13974276382 ; Claims to have paid for Goal Streak | 0 | 0.00% | — | — | none
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `10787472094`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C082 Ads in the free tier; C097 A tip / donate option; C209 No sign-up wall before first use

### R27-048 — Exactly two reviews (1.45%, [THIN], mean 5.00) volunteer money without being asked — 'Keep the free app, consider adding a tip jar for users who are thankful' and 'it would be nice to donate to the dev since it's a free app'; both Canadian, both 5★, both frame payment as gratitude, both pair it with keeping the app free, and neither asks for a feature in return — the entire direct evidence base for willingness to pay, and it points at one mechanism only: a voluntary tip jar

- **Where:** §5.1 What would trigger a purchase — exactly 2 reviews volunteer money unprompted (both Canadian, both 5★, both frame payment as gratitude, both pair it with keeping the app free, neither asks for a feature in return): the entire direct evidence base points at one mechanism, a voluntary tip jar
- **This app does:** no tip jar
- **User reaction:** purchase-driver
- **Magnitude:** 2 (1.45% [THIN]), mean 5.00
- **Direction for us:** do · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `10787472094`, `11393669723`
- **Canonical:** C097 A tip / donate option

### R27-050 — Monetisation options ranked by corpus support: a tip jar / one-off 'buy me a coffee' — 2 direct requests, 10 developer-gratitude reviews, no risk observed: the only option the corpus positively endorses; paid cosmetic extras (themes, icon packs) — 10 customisation-praise reviews, low risk if existing themes stay free: plausible, untested; paid new capability (Watch, Health, macOS, advanced stats) — 4 singleton platform requests, moderate risk: defensible if and only if nothing existing moves behind it; a habit cap on the free tier — zero support, 3 praise unlimited, 47 praise free, 13 fled competitors' caps: directly attacks the stated reason users are here; subscription for existing features — zero support, 4 keep-free pleas, 13 competitor-price rejections: the highest-risk option; advertising — contradicted by 12 no-ads reviews; data monetisation / required account — contradicted by 4 privacy reviews and the listing's no-data label

- **Where:** §5.3 Monetisation options ranked (verbatim table) — tip jar: the only option positively endorsed; paid cosmetics: plausible, untested; paid new capability (Watch, Health, Mac, advanced stats): defensible iff nothing existing moves behind it; habit cap on free: directly attacks the reason users are here; subscription for existing features: highest risk; advertising: contradicted by 12 no-ads reviews; data/required account: contradicted by evidence and the listing
- **This app does:** free; forward options
- **User reaction:** mixed
- **Magnitude:** Option | Corpus support | Corpus risk | Verdict from evidence ; Tip jar / one-off "buy me a coffee" | 2 direct requests (10787472094, 11393669723); 10 developer-gratitude reviews (7.25%) name Emily personally | None observed — both requesters paired it with "keep the app free" | The only option the corpus positively endorses. ; Paid cosmetic extras (extra themes, icon packs) | 10 customisation-praise reviews (7.25%); 12973708986 wants a colour tuner; 12877783902 wants better icons | Low, if existing themes stay free | Plausible; untested by the corpus ; Paid new capability (Watch app, Health sync, macOS, advanced stats) | 4 singleton requests for platform expansion | Moderate — 11085682019 is already watching for IAP | Defensible if and only if nothing existing moves behind it ; Habit cap on the free tier | Zero support | 3 reviews praise unlimited habits by name; 47 praise free; 13 fled competitors' caps | Directly attacks the stated reason users are here. ; Subscription for existing features | Zero support | 4 explicit "keep it free" pleas; 13 competitor-price rejections | Highest-risk option in the corpus. ; Advertising | Zero support | 12 reviews praise the absence of ads | Contradicted by evidence ; Data monetisation / required account | Zero support | 4 privacy-praise reviews; [LISTING] privacy label states no data collected | Contradicted by evidence and by the listing
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C022 Apple Watch app (done properly: timer, two-way sync); C097 A tip / donate option

### R27-080 — Monetisation #15: add a tip jar / 'buy the developer a coffee' — optional, non-blocking, dismissible, with no feature attached; two direct requests plus 10 developer-gratitude reviews (all 5★) and 'made this with joy, not for money'; low risk — both requesters paired it with 'keep the app free', and gratitude is already the dominant emotional register of the 5★ band

- **Where:** §8.3 Part 8 #15 — add a tip jar / 'buy the developer a coffee': optional, non-blocking, dismissible, no feature attached; low risk — both requesters paired it with 'keep the app free'; gratitude is already the dominant register of the 5★ band
- **This app does:** no tip jar
- **User reaction:** purchase-driver
- **Magnitude:** 2 + 10
- **Direction for us:** do · **Report confidence:** meaningful [THIN] · **Generalisable:** yes
- **Review IDs:** `10787472094`, `11393669723`, `12936194802`
- **Canonical:** C097 A tip / donate option; C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal

## Tactics the app used

### R27-013 — Tactic and outcome: the solo developer is part of the product — 10 reviews (7.25%, all 5★, mean 5.00) thank or celebrate her personally ('Thanks Emily'; 'The story of how this app was built is really wholesome and relatable'; 'It's clear that someone made this with joy, not for money'; 'built/maintained by an individual female developer— THANK YOU'; 'Definitely designed by a woman, love the themes'; 'you are a hero'); the origin story in the listing is doing measurable work — and it is a constraint: a trust-based relationship is what makes a paywall feel like a betrayal rather than a transaction

- **Where:** Executive summary #11 — the solo developer is part of the product: 10 (7.25%, all 5★) thank her personally ('Thanks Emily'; 'The story of how this app was built is really wholesome'; 'someone made this with joy, not for money'; 'built/maintained by an individual female developer— THANK YOU'; 'you are a hero'); the origin story in the listing does measurable work — and a trust-based relationship is what makes a paywall feel like a betrayal
- **This app does:** personal origin story in the listing
- **User reaction:** praise
- **Magnitude:** 10 (7.25%, high-priority), mean 5.00, every one 5★
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10787472094`, `13136686944`, `9983242833`, `12936194802`, `13933124385`, `13919778285`, `13989106663`, `11393669723`, `12146188261`, `13583086435`
- **Canonical:** C134 Lead the store listing with what users actually love; C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal

## Insights (the why)

### R27-003 — 'Free with no in-app purchases' is not a pricing detail — it is the product's primary stated reason for existing and the largest theme: 47 reviews (34.06%, mean 4.89) volunteer that the app is free / no IAP / no subscription / no paywall, in a register of relief and disbelief ('How is this free?'; 'I Still dont believe i found this app'; 'In a world where literally every service is locked behind a pay wall, this is like a breath of fresh air'; 'i've been through SO many of these apps until i finally found a free one'); users are not choosing it over a cheaper tracker — they are choosing it after being exhausted by the category's paywalls; the free tier is the acquisition channel

- **Where:** Executive summary #1 — 'free with no in-app purchases' is the product's primary reason for existing and the largest theme; the register is relief and disbelief ('How is this free?'); users choose it after being exhausted by the category's paywalls — the free tier is the acquisition channel
- **This app does:** entirely free, no IAP
- **User reaction:** purchase-driver
- **Magnitude:** 47 (34.06%, high-priority), mean 4.89 (a floor — implied cases excluded)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10765907509`, `10942093874`, `11085682019`, `11393669723`, `11699207962`, `11756328020`, `11937614517`, `12926444561`, `13233606022`, `13587881498`, `13878955116`, `14037309039`, `14118395021`, `14196975012`, `14383016940`, `14471275362`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R27-005 — Simplicity is the second pillar and the largest theme by count — 52 (37.68%, mean 4.90) praise minimalism, clarity or absence of clutter ('cuts straight to the point, no fluff'; 'example of best minimal app. no clutter'; 'No other shinannigans'), stable across eras (33.3% → 44.8% → 41.8% → 28.6%); two reviewers name the absence of gamification as the differentiator — 'There's not pets to take care of, there's no flashy graphics or anything, and that is just perfect for me'; 'it removes a direct emphasis on urgency and/or self-competition' — in a category converging on pets, gardens and streak anxiety, deliberate plainness is a defensible position, and one that any future monetisation must not contradict

- **Where:** Executive summary #3 — simplicity is the second pillar and the most durable theme (33.3% → 44.8% → 41.8% → 28.6%); two reviewers name the absence of gamification as the differentiator ('There's not pets to take care of… that is just perfect for me'; 'removes a direct emphasis on urgency and/or self-competition') — deliberate plainness is a defensible position any monetisation must not contradict
- **This app does:** deliberately plain, no gamification
- **User reaction:** praise
- **Magnitude:** 52 (37.68%, high-priority), mean 4.90; 33.3% → 44.8% → 41.8% → 28.6%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11868354054`, `12180873299`, `12146188261`, `13305332766`, `13114310284`, `12173158756`, `12406443450`, `13463476864`, `13590630295`, `13609880038`, `13807267873`, `13933124385`
- **Canonical:** C006 Stay minimal and ad-free; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R27-028 — Positive themes beyond the pillars: design/aesthetic 19 (13.77%, mean 4.89 — about restraint, not decoration: 'Lovely clean UI, not cluttered with loads of bells and whistles. From one developer to another — nice piece of work'; 'plain… beautifully designed… focuses on the streaks, without unnecessary extras'); generic-only praise 12; customisation 10 (7.25%, 4.80); behaviour-change outcomes 10 (7.25%, 4.70); long-range view 4; unlimited habits 3; stats/export 3; reminders 2

- **Where:** §3.1 praise_design_aesthetic 19 (13.77%, mean 4.89); praise_generic_only 12; praise_customization 10 (7.25%, 4.80); outcome_behaviour_change 10 (7.25%, 4.70); praise_long_range_view 4; praise_unlimited_habits 3; praise_stats_export 3; praise_reminders 2
- **This app does:** restrained design
- **User reaction:** praise
- **Magnitude:** 19 / 12 / 10 / 10 / 4 / 3 / 3 / 2
- **Direction for us:** do · **Report confidence:** high-priority to [THIN] · **Generalisable:** yes
- **Review IDs:** `12173158756`, `10780603796`, `9631112670`, `12101720347`, `13903934801`, `14001830867`, `12132900869`, `12973708986`, `13233606022`, `13919778285`
- **Canonical:** C006 Stay minimal and ad-free; C009 Basic widgets, icons and colours are free; C057 Offer a non-pastel / premium design option

### R27-030 — Real outcomes claimed (10, 7.25%, mean 4.70): 'I've been using Goal Streak for about two years now and I grown into a much much much better person'; 'my house is much cleaner'; 'I'm on a 9 day vacuuming streak!'; 'i'm convinced this is the only way i can actually be consistent doing things'; daily piano, daily workouts, Bible reading with activity rings, stopping bad habits, exercise and water intake — the product working, not just pleasing

- **Where:** §3.2 Supporting evidence of real outcomes — 'using Goal Streak for about two years now and I grown into a much much much better person'; 'my house is much cleaner'; 'I'm on a 9 day vacuuming streak!'; 'the only way i can actually be consistent'; piano, workouts, Bible reading, stopping bad habits
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 10 (7.25%), mean 4.70
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13761980153`, `13220635530`, `12582425991`, `14099500769`, `12571822998`, `11482185421`, `12900579642`, `13923424034`, `14281981627`, `14239313970`
- **Canonical:** C024 Streaks / gamification

### R27-032 — Even the 2023 crash reviewer rated 4★ and added 'but! it's a good app, most importantly it's free and intuitive' — the free position buys tolerance for defects

- **Where:** §3.3 Defect 1 — launch crash: even the 2023 crash reviewer rated 4★ and added 'but! it's a good app, most importantly it's free and intuitive'
- **This app does:** free buys tolerance
- **User reaction:** mixed
- **Magnitude:** 1 review
- **Direction for us:** none · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `10639973409`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R27-040 — All four 1★ reviews fall between 8 Oct and 26 Nov 2025 and are about a broken build — won't open after the update ('this was one of the best apps I have had now it just doesn't work'), immediate crash on iOS 26, a widget showing 0% permanently ('If I'm missing something, then it's not very intuitive'), and won't open with all progress lost (the only stated churn); not one 1★ is about price, features, ads or the developer — Goal Streak has no structural sources of one-star reviews; its entire downside risk is release quality

- **Where:** §4.2 1★ table (verbatim) — 4 reviews, 100% about a broken build in a five-week window (won't open after update; iOS 26 crash; widget 0% permanently; won't open and all progress lost); not one 1★ is about price, features, ads or the developer — the entire downside risk is release quality
- **This app does:** free app; only defects produce 1★
- **User reaction:** 1★-burst
- **Magnitude:** ID | Country | Date | Cause ; 13240874103 | IN | 2025-10-08 | App will not open after the update. Explicitly regretful: "this was one of the best apps I have had now it just doesn't work" ; 13338573061 | US | 2025-10-31 | Immediate crash on launch after upgrading to iOS 26 ; 13414248154 | US | 2025-11-18 | Widget shows 0% permanently and is not discoverable: "If I'm missing something, then it's not very intuitive" ; 13444084049 | MX | 2025-11-26 | Won't open after update and all progress lost — the only stated churn in the corpus
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13240874103`, `13338573061`, `13414248154`, `13444084049`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C031 Crashes / launch failures

### R27-042 — All six 3★ reviews are 'good app, one specific gap' — the iOS 26 crash (opening with 'Good app. Does its job.'), cannot select an existing tag, symbol edit reverts plus a goal end date that preserves history, habits categorised by time of day, 'I can't summarize by week or by month', 'Only con is it would be nice if there was a monthly overview'; two of the six are the monthly-view gap — the only feature request that repeatedly costs stars, making the monthly view the highest-leverage feature on the list

- **Where:** §4.2 3★ table (verbatim) — six reviews, all 'good app, one specific gap': iOS 26 crash ('Good app. Does its job.'), cannot select an existing tag, symbol edit reverts + goal end date, categorise by time of day, 'can't summarize by week or by month', 'Only con is… a monthly overview'; two of six are the monthly view — the highest-leverage feature
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** ID | Country | Date | Ask ; 13169445559 | US | 2025-09-22 | iOS 26 crash — but opens with "Good app. Does its job." ; 13243690627 | IN | 2025-10-09 | Cannot select an existing tag ; 13498254162 | CA | 2025-12-10 | Symbol edit reverts; needs a goal end date that preserves history rather than deleting ; 13608165763 | US | 2026-01-08 | Wants habits categorised / ordered by time of day ; 13642789952 | PH | 2026-01-17 | "I can't summarize by week or by month" ; 14239313970 | US | 2026-06-29 | Otherwise positive; "Only con is it would be nice if there was a monthly overview"
- **Direction for us:** must-have · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13169445559`, `13243690627`, `13498254162`, `13608165763`, `13642789952`, `14239313970`
- **Canonical:** C012 Week / month / year grid views

### R27-043 — Every one of the 18 4★ reviews contains explicit praise plus exactly one named improvement — titles alone tell it: 'Almost perfect', 'Great for a free app! One small fix…', '9/10 highly recommend', 'Would be perfect with watch support', 'Nice app, but two things I would recommend to add', 'Good app but would like to see apple health integration', 'great app, hoping a month view can be added'; the asks in full: Monday start, streak visibility, reorder, onboarding difficulty, journal log, better icons, theme tuner, restore the annual grid, widget progression, tags, note-taking purpose, Health, Watch, reminder logic + widget state, monthly view, year-progress %, crash, and 'found a good one among who ask so much' — a fully specified product backlog written by people who like the app; 17 of 18 would plausibly become 5★ on a single shipped item

- **Where:** §4.2 4★ — the 'one small fix' band: every 4★ contains explicit praise plus exactly one named improvement ('Almost perfect'; 'Would be perfect with watch support'; 'Good app but would like to see apple health integration'); a fully specified backlog from people who like the app — 17 of 18 would plausibly become 5★ on a single shipped item
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 18 (13.0%); 18 named asks
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11088501172`, `11762567349`, `12973708986`, `14001830867`, `14088668819`, `13999741050`, `8882537119`, `8918509405`, `10795403293`, `12128390503`, `12473008094`, `12877783902`, `13077199701`, `13255216161`, `13491426055`, `13761980153`, `10639973409`, `11527965143`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R27-044 — 5★ dominant reasons (segment rate of 109 / global of 138): simplicity 47 (43.1% / 34.06%), free/no IAP 42 (38.5% / 30.43%), design 17 (15.6%), came from a worse or paid competitor 11 (10.1%), no ads 10 (9.2%), developer gratitude 10 (9.2%), stated behavioural outcome 8 (7.3%), generic-only 12 (11.0%); twenty-one of the 109 five-star reviewers still asked for something (weekday scheduling, widget, monthly view, streak import, backup recovery, dead link + donation, interactive widget + iPad sync + stay free, the 365-dot view, accidental tap) — 5★ here means 'I am grateful', not 'I have no needs'; treat the 5★ band as a requirements source, not a satisfaction ceiling

- **Where:** §4.2 5★ reasons table (verbatim, segment rates against 109) — simplicity 43.1%, free/no IAP 38.5%, design 15.6%, came from a worse/paid competitor 10.1%, no ads 9.2%, developer gratitude 9.2%, behavioural outcome 7.3%, generic 11.0%; 21 of 109 five-star reviewers still asked for something — 5★ means 'I am grateful', not 'I have no needs'; treat the 5★ band as a requirements source
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Reason | n | % of 109 (segment rate) | % of 138 (global) ; Simplicity / minimalism | 47 | 43.1% | 34.06% ; Free / no IAP | 42 | 38.5% | 30.43% ; Design / aesthetics | 17 | 15.6% | 12.32% ; Came from a worse/paid competitor | 11 | 10.1% | 7.97% ; No ads | 10 | 9.2% | 7.25% ; Developer gratitude | 10 | 9.2% | 7.25% ; Stated behavioural outcome | 8 | 7.3% | 5.80% ; Generic praise only ("nice", "great app", "🤗") | 12 | 11.0% | 8.70%
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `12944050597`, `13111651177`, `13463476864`, `13481955817`, `13491588986`, `11393669723`, `11937614517`, `13215630472`, `12023192028`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C006 Stay minimal and ad-free

### R27-049 — The indirect evidence against a gate is much larger than the evidence for a purchase: 47 chose the app because it is free (the acquisition reason, not a perk); 13 explicitly rejected a competitor over its paywall (already refused to pay in this category); 4 asked the developer to keep it free (anticipatory anxiety); 3 praised unlimited habits by name (the specific gate they fled); 4 praised no-account/no-data (rules out ad- or data-funded models); 12 praised no ads (rules out an ad tier); the most explicit refusals — 'Don't get streaks for $6. Get this! No ads (yet, but I don't think there are any)' (this user is watching for monetisation); 'no BS subscriptions'; 'without asking for my personal details and trying to get me to buy stuff'; 'doesn't pressure you to go premium' — a self-selected anti-paywall cohort; the users who chose to write about Goal Streak chose it specifically to escape paying, and a retroactive gate on existing free functionality would land on precisely this population

- **Where:** §5.2 What would block a purchase (verbatim table) — chose it because free 47; rejected a competitor over price 13; asked to keep it free 4; praised unlimited habits 3; praised no-account 4; praised no ads 12 — a self-selected anti-paywall cohort; one user is watching for monetisation ('No ads (yet, but I don't think there are any)'); a retroactive gate would land on precisely this population
- **This app does:** free with no gate
- **User reaction:** praise
- **Magnitude:** Signal | n | % of 138 | What it implies about monetisation ; Chose this app *because* it is free / has no IAP | 47 | 34.06% | The free tier is the acquisition reason, not a perk ; Explicitly rejected a competitor over its price/paywall | 13 | 9.42% | These users have already refused to pay in this category ; Explicitly asked the developer to keep it free | 4 | 2.90% | Anticipatory anxiety — they expect monetisation and are pre-empting it ; Praised unlimited habits with no cap | 3 | 2.17% | A habit cap is the specific gate they fled ; Praised no-account / no-data-collection | 4 | 2.90% | Rules out ad-funded or data-funded models ; Praised no ads | 12 | 8.70% | Rules out an ad tier
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11085682019`, `14037309039`, `14118395021`, `13974276382`, `13086712965`, `11699207962`, `12146188261`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C082 Ads in the free tier; C209 No sign-up wall before first use

### R27-056 — Price sensitivity is uniform, not regional — free-praise appears in 12 of the 23 storefronts spanning AE, AU, CA, CZ, DE, GB, IN, NG, NL, RU, TH and US with no high-income/low-income split; the anti-paywall stance is a category-wide attitude, not a market-specific one; localisation is not an issue (not one review complains about language, translation, currency or formatting; seven non-English reviews mention no defect; the two Monday-week-start complaints are the only regional-convention issue); support is not an issue anywhere because no reviewer in any market mentions support at all

- **Where:** §6.5 Global vs country — price sensitivity is uniform not regional (free-praise in 12 of 23 storefronts across AE, AU, CA, CZ, DE, GB, IN, NG, NL, RU, TH, US; no high-/low-income split — the anti-paywall stance is category-wide); localisation is not an issue (zero complaints; seven non-English reviews, none mentions a defect; the two week-start complaints are the only regional-convention issue); support is not an issue anywhere because nobody mentions it
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 12 of 23 storefronts; 0 localisation complaints; 0 support mentions
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `10795403293`, `10966990397`
- **Canonical:** C027 Localise early — it unlocks revenue; C062 Weight English-speaking rich markets; volume ≠ revenue

### R27-063 — Trend 5 [moderate]: the competitive-escape narrative is strengthening — switched-from-competitor 0.0% → 10.3% → 5.5% → 16.7%, competitor price contrast 8.3% → 6.9% → 7.3% → 14.3%; 2026 reviews increasingly open by describing the alternatives ('I must have tried almost all the habit trackers on the App Store'; 'I've tried dozens upon dozens of apps and this is literally unmatched'; 'Most apps like this are really bad'; 'unlike other apps it's free') — as the category monetises harder, Goal Streak's position sharpens without the app changing; market drift working in its favour, and entirely contingent on staying free

- **Where:** §7.3 Trend 5 — the competitive-escape narrative is strengthening [moderate]: switched 0 → 10.3 → 5.5 → 16.7%; price contrast 8.3 → 14.3%; 2026 reviews increasingly open by describing the alternatives ('I must have tried almost all the habit trackers on the App Store'; 'literally unmatched') — as the category monetises harder, Goal Streak's position sharpens without the app changing; market drift working in its favour, entirely contingent on staying free
- **This app does:** free in a subscription-ising category
- **User reaction:** purchase-driver
- **Magnitude:** 16.7% + 14.3% in 2026
- **Direction for us:** product-rule · **Report confidence:** moderate · **Generalisable:** yes
- **Review IDs:** `13903934801`, `13989106663`, `13974276382`, `14037309039`, `14118395021`, `13846689652`, `14281981627`
- **Canonical:** C005 Know which competitors buyers compare against; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R27-064 — Trend 6 [moderate]: reviewers increasingly report actual behaviour change rather than app quality — outcomes 0.0% → 3.4% → 7.3% → 11.9%, with the 2026 examples the strongest in the corpus (two years of use producing 'a much much much better person'; 'the only way i can actually be consistent'; 'it holds you accountable') — a retention signal: the cohort that has used the app for years is writing about outcomes, not features; the review base is maturing, not churning

- **Where:** §7.3 Trend 6 — reviewers increasingly report actual behaviour change, not just app quality [moderate]: 0 → 3.4 → 7.3 → 11.9%; the cohort using the app for years now writes about outcomes rather than features — a retention signal; the review base is maturing, not churning
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 0.0 → 3.4 → 7.3 → 11.9%
- **Direction for us:** none · **Report confidence:** moderate · **Generalisable:** app-specific
- **Review IDs:** `13761980153`, `14099500769`, `13923424034`
- **Canonical:** C024 Streaks / gamification

### R27-065 — Persisted unchanged across four years: free/no-IAP praise present in every era (never absent); simplicity praise the most stable theme; the monthly-view gap asked in 2022, 2025 and 2026 — four years, five reviewers, still open; the widget gap asked in every single year 2022–2026; and zero support mentions, zero ad complaints, zero paywall encounters across 138 reviews in 23 countries

- **Where:** §7.4 What persisted unchanged across four years — free praise in every era; simplicity the most stable theme; the monthly-view gap asked in 2022, 2025, 2026 (four years, five reviewers, still open); the widget gap asked every single year; zero support mentions, zero ad complaints, zero paywall encounters
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** monthly 5 across 4 years; widget 9 across 5 years
- **Direction for us:** must-have · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `8918509405`, `13155678708`, `13463476864`, `13642789952`, `14239313970`, `8865309570`, `9631112670`, `10197682121`, `11272404025`, `11937614517`, `13111651177`, `13255216161`, `13414248154`, `14088668819`
- **Canonical:** C012 Week / month / year grid views; C023 Interactive widget check-off

### R27-066 — One thing to watch: simplicity praise fell 41.8% (2025) → 28.6% (2026) while switched-from-competitor rose 5.5% → 16.7% (counts 23→12 and 3→7, may be nothing) — but the two reviews marking the boundary of the minimalism virtue are both recent ('still a bit simple', Feb 2026; 'Limited featuees', 3★, Jan 2026); hypothesis: as the app attracts more refugees from feature-rich paid apps, expectations rise and 'pleasantly minimal' starts shading into 'missing things' — the monthly view is the first place this shows

- **Where:** §7.5 One thing to watch — simplicity praise fell 41.8% → 28.6% while switched-from-competitor rose 5.5% → 16.7%; both boundary-of-minimalism reviews are recent ('still a bit simple'; 'Limited featuees' at 3★): as the app attracts refugees from feature-rich paid apps, expectations rise and 'pleasantly minimal' shades into 'missing things'; the monthly view is the first place this shows
- **This app does:** minimal product meeting power-user refugees
- **User reaction:** mixed
- **Magnitude:** 41.8% → 28.6%; 5.5% → 16.7%
- **Direction for us:** research · **Report confidence:** hypothesis · **Generalisable:** yes
- **Review IDs:** `13784793079`, `13642789952`
- **Canonical:** C006 Stay minimal and ad-free

## Markets and languages

### R27-052 — No storefront reaches the 50-review threshold (US 43, IN 19, CA 15, AU 11, CN 7, GB 7, DE 6, PH 4, SE 4, MX 3, six with 2, seven with 1) so the report is global-only; every country observation is limited evidence presented for a future larger extraction to test

- **Where:** §6.1 Eligibility — no country qualifies (US max 43); §6.2 Full storefront table (verbatim, all 23, all limited evidence)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Country | n | % of 138 | Mean ★ | Rating spread | Free-praise n | Status ; US | 43 | 31.16% | 4.53 | 5★32 4★6 3★3 1★2 | 13 (30%) | Limited evidence (below 50) ; IN | 19 | 13.77% | 4.58 | 5★15 4★2 3★1 1★1 | 6 (32%) | Limited evidence ; CA | 15 | 10.87% | 4.87 | 5★14 3★1 | 6 (40%) | Limited evidence ; AU | 11 | 7.97% | 4.82 | 5★9 4★2 | 6 (55%) | Limited evidence ; CN | 7 | 5.07% | 4.00 | 5★2 4★4 2★1 | 2 (29%) | Limited evidence ; GB | 7 | 5.07% | 4.86 | 5★6 4★1 | 2 (29%) | Limited evidence ; DE | 6 | 4.35% | 4.83 | 5★5 4★1 | 3 (50%) | Limited evidence ; PH | 4 | 2.90% | 4.50 | 5★3 3★1 | 1 | Too small for any observation ; SE | 4 | 2.90% | 5.00 | 5★4 | 0 | Too small ; MX | 3 | 2.17% | 3.67 | 5★2 1★1 | 0 | Too small ; AE, CZ, JP, NG, NO, RU | 2 each | 1.45% each | 5.00, 5.00, 5.00, 5.00, 4.50, 4.50 | — | — | Too small ; BR, FR, HK, NL, PK, TH, ZM | 1 each | 0.72% each | 5.00 each | — | — | Too small
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R27-053 — Limited-evidence observations on the four ≥10-review markets: the US carries the corpus's dissatisfaction — 5 of the 11 sub-4★ reviews, the lowest mean (4.53), and 5 of the 9 widget complaints; India is the most simplicity-first market (47% vs 26% US) with zero design-aesthetic praise and zero outcome statements — short, functional, price-aware reviews ('Thanks a lot for making it free'; 'Found a good one among who ask so much'); Canada is the most satisfied (4.87, 14 of 15 at 5★) and the only source of both tip-jar requests — where a voluntary-payment experiment should start; Australia has the highest free-praise (55%) and design-praise (36%) rates and zero complaints

- **Where:** §6.3 High-volume markets (≥10 reviews: US, IN, CA, AU = 88, 63.77%) table (verbatim) — the US carries the dissatisfaction (5 of 11 sub-4★, lowest mean 4.53, 5 of 9 widget complaints); India most simplicity-first (47%), zero design or outcome praise, short price-aware reviews; Canada most satisfied (4.87) and the only source of both tip-jar requests; Australia highest free-praise (55%) and design-praise (36%), zero complaints
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | US (43) | IN (19) | CA (15) | AU (11) ; Free / no-IAP praise | 13 (30%) | 6 (32%) | 6 (40%) | 6 (55%) ; Simplicity praise | 11 (26%) | 9 (47%) | 4 (27%) | 6 (55%) ; Design praise | 6 (14%) | 0 (0%) | 2 (13%) | 4 (36%) ; Switched from a competitor | 2 (5%) | 2 (11%) | 0 (0%) | 2 (18%) ; Widget gap or defect | 5 (12%) | 2 (11%) | 0 (0%) | 0 (0%) ; Stated behavioural outcome | 6 (14%) | 0 (0%) | 1 (7%) | 2 (18%) ; Mean rating | 4.53 | 4.58 | 4.87 | 4.82
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `13169445559`, `13338573061`, `13414248154`, `13608165763`, `14239313970`, `10942093874`, `11527965143`, `13463476864`, `10787472094`, `11393669723`
- **Canonical:** — (nuance register)

### R27-054 — High-spend markets (US 43 + CA 15 + AU 11 + CN 7 + GB 7 + DE 6 + JP 2 + FR 1 = 92, 66.67%, mean 4.641) against all other storefronts (46, mean 4.652) are indistinguishable — Goal Streak is not rated differently in high-spend markets; per market: US 4.53 (lowest, all widget complaints), CA 4.87 (both tip-jar requests), AU 4.82 (zero complaints), CN 4.00 (lowest of any market with ≥5), GB 4.86 (one regression), DE 4.83 (both Monday-week-start requests German-market or German-language), JP 5.00 (one switched from Streaks), FR 5.00

- **Where:** §6.4 High-spend markets (US, JP, GB, CA, AU, DE, FR, CN = 92, 66.67%, mean 4.641) vs rest (46, mean 4.652) — indistinguishable; the app is not rated differently in high-spend markets; per-market table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Market | n | Mean ★ | Notable ; US | 43 | 4.53 | Lowest mean; all widget complaints cluster here ; CA | 15 | 4.87 | Both tip-jar requests ; AU | 11 | 4.82 | Zero complaints ; CN | 7 | 4.00 | Lowest mean of any market with ≥5 reviews ; GB | 7 | 4.86 | One regression complaint (13215630472) ; DE | 6 | 4.83 | Both Monday-week-start requests are German-market or German-language (10966990397 DE, 10795403293 AU) ; JP | 2 | 5.00 | 13903934801 switched from Streaks ; FR | 1 | 5.00 | —
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `13215630472`, `10966990397`, `10795403293`, `13903934801`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R27-055 — China (n=7, mean 4.00 — the lowest of any market with ≥5 reviews): 4★×4, 5★×2, 2★×1, and 4 of the 7 are feature requests or regression complaints — month view, year-progress %, a 2023 crash, the note-export regression and workflow loss, the annual-grid demotion and backfill loss; only two are pure praise; Chinese reviewers engage with the app as power users — naming specific views, export workflows and backfill mechanics — and are the group most damaged by the 2025 restructure; a hypothesis for a larger extraction, not a finding

- **Where:** §6.4 China — the most interesting limited-evidence signal: all 7 Chinese reviews are 4★ or below on average (4.00) and 4 of 7 are feature requests or regression complaints (month view, year-progress %, crash, note-export regression, annual-grid demotion + backfill loss); Chinese reviewers engage as power users and are the group most damaged by the 2025 restructure — a hypothesis, not a finding
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** n=7, mean 4.00; 4 of 7 requests/regressions
- **Direction for us:** research · **Report confidence:** limited evidence (n=7) · **Generalisable:** app-specific
- **Review IDs:** `8918509405`, `8882537119`, `10639973409`, `13178799590`, `13077199701`, `9631112670`, `14165879048`
- **Canonical:** — (nuance register)

## Dated events and trends

### R27-006 — The single largest quality event is a September–November 2025 update-and-iOS-26 regression that accounts for almost every bad rating the app has ever received: all 4 one-star reviews, the only 2★ and 4 of 6 3★ fall between 22 Sep 2025 and 17 Jan 2026 — window n=37, mean 4.162, 10 sub-4★ vs all other periods n=101, mean 4.822, 1 sub-4★; the failures are launch crashes ('Ever since I updated to iOS 26 the app immediately crashes when I try to open'; 'Please fix it for iOS 26. Instantly crashes!'; 'It doesnt open with the update, ive lost all my progress, guess its time for a new app') plus one 2023 tap-crash

- **Where:** Executive summary #4 — the largest quality event is a Sept–Nov 2025 update-and-iOS-26 regression that accounts for almost every bad rating ever: all 4 1★, the only 2★ and 4 of 6 3★ fall 22 Sep 2025 → 17 Jan 2026; window mean 4.162 (n=37, 10 sub-4★) vs 4.822 elsewhere (n=101, 1 sub-4★); launch crashes ('Ever since I updated to iOS 26 the app immediately crashes'; 'ive lost all my progress, guess its time for a new app')
- **This app does:** iOS 26 launch crash after an update
- **User reaction:** 1★-burst
- **Magnitude:** crash 5 (3.62%, very strong), mean 2.00 — lowest-rated theme; window 4.162 vs 4.822
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13338573061`, `13169445559`, `13240874103`, `13444084049`, `10639973409`
- **Canonical:** C031 Crashes / launch failures; C175 Updates must not break function or wipe progress

### R27-007 — The app recovered and the recovery is visible in the data: from 1 Feb 2026 n=35, mean 4.829, zero 1★, zero 2★, one 3★; crash mentions 7.3% of 2025 (4/55) → 0.0% of 2026 (0/42); regression mentions 9.1% → 0.0%; the iOS 26 break was real, cost the app its entire negative-rating history, and was fixed — the lesson is exposure, not competence: a solo-developer app with no paid support channel absorbs an OS-transition break entirely through its public rating

- **Where:** Executive summary #5 — the app recovered and the recovery is visible: 2026-02-01 onward n=35, mean 4.829, zero 1★/2★; crash mentions 7.3% (2025) → 0.0% (2026); the lesson is exposure — a solo-developer app with no paid support channel absorbs an OS-transition break entirely through its public rating
- **This app does:** fixed the iOS 26 crash
- **User reaction:** praise
- **Magnitude:** post-Feb-2026 mean 4.829 (n=35); crash 7.3% → 0.0%
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C059 Be visibly responsive; fixes bring reviewers back

### R27-031 — Free/no-IAP praise runs 25.0% (2022–23) → 51.7% (2024) → 21.8% (2025) → 40.5% (2026) — the 2025 dip coincides exactly with the crash window, when reviewers had other things to write about; one reviewer marks the boundary of the simplicity virtue: 'still a bit simple, but it feels good to use'

- **Where:** §3.2 Pillar 1 era pattern — free/no-IAP praise 25.0% (2022–23) → 51.7% (2024) → 21.8% (2025) → 40.5% (2026); the 2025 dip coincides with the crash window; one reviewer marks the boundary of the simplicity virtue ('still a bit simple, but it feels good to use')
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 25.0% → 51.7% → 21.8% → 40.5%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `14153452499`, `14211137939`, `13784793079`, `13481955817`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C006 Stay minimal and ad-free

### R27-057 — Eras by calendar year (2022 and 2023 merged): 2022–23 n=12 (8.70%), mean 4.750, 5★ 75.0%; 2024 n=29, 4.828, 82.8%; 2025 n=55, 4.436, 74.5% with all four 1★; 2026 (to 25 Aug) n=42, 4.762, 83.3%; review volume roughly doubles each year — 5 (2022) → 7 (2023) → 29 (2024) → 55 (2025) → 42 in eight months of 2026 (≈63 annualised) — the app is growing and the growth is accelerating in 2026 despite the 2025 quality dip

- **Where:** §7.1 Era table (verbatim) — 2022–23 n=12 mean 4.750; 2024 29 / 4.828; 2025 55 / 4.436 (1★ 4); 2026 42 / 4.762; volume roughly doubles each year (5 → 7 → 29 → 55 → ~63 annualised) — the app is growing and the growth is accelerating in 2026 despite the 2025 dip
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Era | n | % of corpus | Mean ★ | 5★ share | Rating spread ; 2022–2023 | 12 | 8.70% | 4.750 | 75.0% | 5★9 4★3 ; 2024 | 29 | 21.01% | 4.828 | 82.8% | 5★24 4★5 ; 2025 | 55 | 39.86% | 4.436 | 74.5% | 5★41 4★6 3★3 2★1 1★4 ; 2026 (to 25 Aug) | 42 | 30.43% | 4.762 | 83.3% | 5★35 4★4 3★3
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R27-058 — Theme rates by era (2022–23 / 2024 / 2025 / 2026): simplicity 33.3% → 44.8% → 41.8% → 28.6% (persistent, softening); free/no-IAP 25.0 → 51.7 → 21.8 → 40.5 (persistent, volatile); design 16.7 → 20.7 → 9.1 → 14.3; switched from competitor 0.0 → 10.3 → 5.5 → 16.7 (rising); competitor price contrast 8.3 → 6.9 → 7.3 → 14.3 (rising); behaviour-change outcomes 0.0 → 3.4 → 7.3 → 11.9 (rising); crash 8.3 → 0.0 → 7.3 → 0.0 (spiked then fixed); regression 0 → 0 → 9.1 → 0 (spiked then stopped); data-durability 0 → 3.4 → 5.5 → 0; onboarding confusion 8.3 → 3.4 → 5.5 → 0; widget gap 25.0 → 6.9 → 5.5 → 2.4 (declining); widget praise 16.7 → 3.4 → 0 → 4.8; flexible frequency, unlimited habits, stats/export and reminders praise all new in 2025–26 (features shipped); monthly view 8.3 → 0 → 3.6 → 4.8 (persistent, unresolved); Monday week start 0 → 6.9 → 0 → 0 (stopped, may be fixed); tip jar 0 → 6.9 → 0 → 0; long-range view 16.7 → 3.4 → 1.8 → 0.0 (declining)

- **Where:** §7.2 Theme rate by era table (verbatim) — simplicity 33.3 → 44.8 → 41.8 → 28.6 (softening); free 25.0 → 51.7 → 21.8 → 40.5 (volatile); switched-from-competitor 0 → 10.3 → 5.5 → 16.7 (rising); price contrast 8.3 → 14.3 (rising); outcomes 0 → 11.9 (rising); crash 8.3 → 0 → 7.3 → 0 (spiked, fixed); regression 0 → 9.1 → 0; widget gap 25.0 → 6.9 → 5.5 → 2.4 (declining); flexible frequency / unlimited / stats / reminders new in 2025–26; monthly view persistent; long-range view 16.7 → 0 (declining)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 2022–23 (12) | 2024 (29) | 2025 (55) | 2026 (42) | Direction ; praise_simplicity_minimal | 4 / 33.3% | 13 / 44.8% | 23 / 41.8% | 12 / 28.6% | Persistent, softening ; praise_free_no_iap | 3 / 25.0% | 15 / 51.7% | 12 / 21.8% | 17 / 40.5% | Persistent, volatile ; praise_design_aesthetic | 2 / 16.7% | 6 / 20.7% | 5 / 9.1% | 6 / 14.3% | Persistent ; switched_from_competitor | 0 / 0.0% | 3 / 10.3% | 3 / 5.5% | 7 / 16.7% | Rising ; competitor_price_contrast | 1 / 8.3% | 2 / 6.9% | 4 / 7.3% | 6 / 14.3% | Rising ; outcome_behaviour_change | 0 / 0.0% | 1 / 3.4% | 4 / 7.3% | 5 / 11.9% | Rising ; bug_crash_launch | 1 / 8.3% | 0 / 0.0% | 4 / 7.3% | 0 / 0.0% | Spiked then fixed ; regression_after_update | 0 / 0.0% | 0 / 0.0% | 5 / 9.1% | 0 / 0.0% | Spiked then stopped ; data_durability_concern | 0 / 0.0% | 1 / 3.4% | 3 / 5.5% | 0 / 0.0% | Spiked then stopped ; onboarding_confusion | 1 / 8.3% | 1 / 3.4% | 3 / 5.5% | 0 / 0.0% | Possibly improving ; widget_gap_or_defect | 3 / 25.0% | 2 / 6.9% | 3 / 5.5% | 1 / 2.4% | Declining ; praise_widget | 2 / 16.7% | 1 / 3.4% | 0 / 0.0% | 2 / 4.8% | Flat/low ; praise_flexible_frequency | 0 | 0 | 1 / 1.8% | 2 / 4.8% | New (feature shipped) ; praise_unlimited_habits | 0 | 0 | 1 / 1.8% | 2 / 4.8% | New ; praise_stats_export | 0 | 0 | 1 / 1.8% | 2 / 4.8% | New ; praise_reminders | 0 | 0 | 0 | 2 / 4.8% | New ; want_monthly_view_or_summary | 1 / 8.3% | 0 | 2 / 3.6% | 2 / 4.8% | Persistent, unresolved ; week_start_monday | 0 | 2 / 6.9% | 0 | 0 | Stopped (may be fixed) ; tip_jar_donate | 0 | 2 / 6.9% | 0 | 0 | Stopped ; praise_long_range_view | 2 / 16.7% | 1 / 3.4% | 1 / 1.8% | 0 / 0.0% | Declining — see Trend 4
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R27-059 — Trend 1 [strong]: a reliability collapse in autumn 2025 and complete recovery by 2026 — the window 1 Sep 2025 → 31 Jan 2026 holds 37 reviews at mean 4.162 with 10 of the corpus's 11 sub-4★ reviews; every other period combined holds 101 at mean 4.822 with 1 sub-4★; from 1 Feb 2026, 35 reviews at 4.829 with zero 1★ and zero 2★; this single window explains the entire negative history of the app — an update landing around September 2025, colliding with the iOS 26 transition, broke launch on some devices and removed or relocated features, fixed within roughly four months; a solo-developer app with no in-app support channel pays for such a break entirely in public rating

- **Where:** §7.3 Trend 1 — a reliability collapse in autumn 2025 and a complete recovery by 2026 [strong]: 2025-09-01 → 2026-01-31 holds 37 reviews, mean 4.162, 10 of the 11 sub-4★; every other period 101 reviews, mean 4.822, 1 sub-4★; from 2026-02-01 35 reviews, mean 4.829, zero 1★/2★ — this single window explains the entire negative history; a solo-developer app with no in-app support pays for such a break entirely in public rating
- **This app does:** OS-transition break, no support channel
- **User reaction:** 1★-burst
- **Magnitude:** 37 / 4.162 / 10 sub-4★ vs 101 / 4.822 / 1; post-Feb 35 / 4.829
- **Direction for us:** must-never-break · **Report confidence:** strong · **Generalisable:** yes
- **Review IDs:** `13169445559`, `13178799590`, `13240874103`, `13243690627`, `13338573061`, `13414248154`, `13444084049`, `13498254162`, `13608165763`, `13642789952`
- **Canonical:** C031 Crashes / launch failures; C036 A support channel that exists, is reachable outside the app, and answers

### R27-060 — Trend 2 [strong]: the 2025 update was a net feature restructure and reviewers reported both sides — gained: multiple check-ins per day ('the multiple check-ins per day feature is very handy'; 'I can adjust and see as much times I can do something in the day'), flexible weekly frequency ('tasks that can be completed a few times a week rather than everyday'), habit reordering; lost: one-tap note export, the day-tap record popup, the single-screen annual overview, backfill from the annual grid, a selectable 365-dot view; the same reviewer reports a gain and a loss in one review — 'the recent update is cool… but I noticed the annual overview that used to be on the same screen has disappeared'

- **Where:** §7.3 Trend 2 — the 2025 update was a net feature restructure and reviewers reported both sides [strong]: gained multiple check-ins per day, flexible weekly frequency, habit reordering; lost one-tap note export, the day-tap record popup, the single-screen annual overview, backfill from the annual grid, a selectable 365-dot view; one reviewer reports a gain and a loss in one review ('the recent update is cool… but the annual overview that used to be on the same screen has disappeared')
- **This app does:** restructure with removals
- **User reaction:** mixed
- **Magnitude:** gained 3 features (4 IDs); lost 5 (3 IDs)
- **Direction for us:** product-rule · **Report confidence:** strong · **Generalisable:** yes
- **Review IDs:** `13077199701`, `13987574053`, `13903934801`, `12973708986`, `13178799590`, `13215630472`
- **Canonical:** C043 Flexible / custom frequency; C143 Intra-day completion: tap N times to fill N/N; C155 Never remove a feature people bought the app for — add alongside, do not replace; C175 Updates must not break function or wipe progress

### R27-061 — Trend 3 [moderate]: requested features do get shipped, on a 6–18 month lag — per-weekday flexibility requested July 2025 → weekly-frequency praise March 2026; habit reordering complained about Sept 2024 → praised as shipped Aug 2025; Monday week start asked twice in Jan–Feb 2024 → never asked again in 29 months (plausibly shipped, not confirmed); goal end date asked Dec 2025 → the listing now lists countdown visualizations for goal end dates and habit archiving; caveat: absence of repeat complaints is weak evidence of a fix in a 138-review corpus — verify against the changelog

- **Where:** §7.3 Trend 3 — requested features do get shipped on a 6–18 month lag [moderate]: per-weekday flexibility (Jul 2025 → Mar 2026 praise); reordering (Sept 2024 complaint → Aug 2025 praise); Monday week start asked twice in early 2024 then never again (plausibly shipped); goal end date asked Dec 2025 → listing now lists countdown visualizations and archiving; absence of repeat complaints is weak evidence in a 138-review corpus
- **This app does:** solo developer ships requests
- **User reaction:** praise
- **Magnitude:** 4 request→ship pairs
- **Direction for us:** do · **Report confidence:** moderate · **Generalisable:** yes
- **Review IDs:** `12944050597`, `13903934801`, `11762567349`, `12973708986`, `10795403293`, `10966990397`, `13498254162`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R27-062 — Trend 4 [moderate]: the year-at-a-glance grid, once a headline differentiator, has stopped being praised — 16.7% (2022–23) → 3.4% → 1.8% → 0.0% (2026), counts 2, 1, 1, 0; the two earliest reviews in the corpus are about it ('I love how you can see the progress of an entire year, helps me keep to my goals!'; 'Most apps does not let me see the progress of my habits over the months') and by late 2025 it appears only as a loss; the 'Goal Streak Calendar' year grid — what the bundle ID is still named after — is being quietly de-emphasised and the users who valued it most are the ones who noticed; counts small, treat as hypothesis

- **Where:** §7.3 Trend 4 — the year grid, once a headline differentiator, has stopped being praised [moderate]: 16.7% → 3.4% → 1.8% → 0.0%; the corpus's first review is about it ('I love how you can see the progress of an entire year'); by late 2025 it appears only as a loss; the thing the bundle ID is still named after (goalStreakCalendar) is being quietly de-emphasised and the users who valued it most noticed
- **This app does:** signature view demoted
- **User reaction:** churn
- **Magnitude:** 16.7% → 0.0%; counts 2/1/1/0
- **Direction for us:** product-rule · **Report confidence:** moderate (small n) · **Generalisable:** yes
- **Review IDs:** `8819961417`, `10477776521`, `13077199701`, `13215630472`
- **Canonical:** C012 Week / month / year grid views; C155 Never remove a feature people bought the app for — add alongside, do not replace

## Positioning

### R27-001 — Goal Streak: Habit Tracker — 'Build a growth mindset, daily' (App Store ID 1630626343) — a solo-developer (Emily Cheroske / Swifty Bits LLC) tracker that is entirely free: no IAP, no subscription, no ads, unlimited habits, no account; confirmed by the store listing and by 47 reviewers unprompted; monetisation is a forward question

- **Where:** header lines 1-9; §9.5 External sources
- **This app does:** developer of record Swifty Bits LLC (Emily Cheroske); bundle com.emilycheroske.goalStreakCalendar.Goal-Streak-Calendar; extracted 8 Sep 2026; analysis 11 Sep 2026; store rank 27; free with no IAP
- **User reaction:** praise
- **Magnitude:** 138 reviews · 23 storefronts · 28 Jun 2022 → 25 Aug 2026; mean 4.645; 5★ 109 (79.0%) / 4★ 18 / 3★ 6 / 2★ 1 / 1★ 4
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R27-004 — 13 reviews (9.42%, mean 4.92) name the competitive paywall explicitly — 'Don't get streaks for $6. 👎 Get this!'; 'way better than those paid apps'; 'so many habit apps are expensive and require an account'; 'they all have ads or limited usage that's behind paywall' — and 13 (9.42%, mean 4.85) say they came from other trackers ('I have tried like 20+ apps including notion, atoms'; 'replaced Streaks'; 'I've tried dozens upon dozens of apps'); Goal Streak is a net receiver of category churn and its competitive position is defined by rivals' monetisation, not by its own features

- **Where:** Executive summary #2 — 13 name the competitive paywall ('Don't get streaks for $6. Get this!'; 'they all have ads or limited usage that's behind paywall') and 13 came from other trackers ('tried like 20+ apps including notion, atoms'; 'replaced Streaks') — a net receiver of category churn; its position is defined by rivals' monetisation, not its features
- **This app does:** free in a paywalled category
- **User reaction:** purchase-driver
- **Magnitude:** price contrast 13 (9.42%, mean 4.92); switched 13 (9.42%, mean 4.85)
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11085682019`, `13571505007`, `13919778285`, `13974276382`, `14037309039`, `10765907509`, `11527965143`, `13069916662`, `13086712965`, `13233606022`, `13587881498`, `14118395021`, `14281981627`, `11937614517`, `13903934801`, `13989106663`, `11088501172`, `13807267873`, `13846689652`
- **Canonical:** C005 Know which competitors buyers compare against; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

## Anti-patterns

### R27-008 — That same update also removed things users valued and three reviewers said so independently: the one-tap note export was removed and the day-record popup changed (CN, 2★ — 'the overall usability after the update is worse by more than a little'); the single-screen annual overview moved behind a per-habit tap and backfilling from the annual grid stopped working (CN, 4★); 'I loved it before the previous update' with a request to choose the 365-dot view (GB, still 5★); the year-at-a-glance grid is a signature feature and demoting it cost goodwill even from people who still rated 5★ — feature removals in this app are more expensive than feature absences

- **Where:** Executive summary #6 — the same update removed things users valued: one-tap note export removed, day-record popup changed, the single-screen annual overview moved behind a per-habit tap and backfilling from the annual grid stopped working ('the overall usability after the update is worse by more than a little'); demoting the signature year-at-a-glance grid cost goodwill even from 5★ reviewers — feature removals are more expensive than feature absences
- **This app does:** demoted the year grid; removed note export
- **User reaction:** complaint
- **Magnitude:** regression 5 (3.62%, very strong), mean 2.60; 3 feature-loss
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13178799590`, `13077199701`, `13215630472`, `8819961417`, `10477776521`, `10787472094`, `12944050597`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C155 Never remove a feature people bought the app for — add alongside, do not replace; C175 Updates must not break function or wipe progress

### R27-041 — The only 2★ is a feature removal — the one-tap note export was removed, forcing day-by-day copying, and tapping a day no longer pops up that day's record ('the overall usability after the update is worse by more than a little'): a power user losing a workflow, not a beginner failing to onboard

- **Where:** §4.2 2★ — one review, a feature removal: a power user losing a workflow (one-tap note export removed; day-tap popup gone), not a beginner failing to onboard
- **This app does:** removed export in an update
- **User reaction:** churn
- **Magnitude:** 1 (0.72%)
- **Direction for us:** product-rule · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `13178799590`
- **Canonical:** C020 Data export / backup / CSV; C155 Never remove a feature people bought the app for — add alongside, do not replace

## Things not to do

### R27-084 — What not to do: do not add gamification — two reviewers name its absence as the reason they chose this app ('There's not pets to take care of, there's no flashy graphics'; 'removes a direct emphasis on urgency and/or self-competition') and 52 praise minimalism; do not add ads, even a single interstitial (12 praise their absence by name); do not require an account (4 praise its absence; the no-data-collection privacy label is part of the positioning); do not remove features in updates without an opt-out (the 2025 restructure produced the only 2★ and cost goodwill from 5★ users); do not over-build — 'this app does everything you need it to do with very little drama' is the product spec: ship the widget, the month view and the sync assurance; resist the rest

- **Where:** §8.5 What not to do — do not add gamification (two name its absence as why they chose it; 52 praise minimalism); do not add ads, even one interstitial (12 praise their absence); do not require an account (4 praise; no-data privacy label is part of the positioning); do not remove features without an opt-out (the 2025 restructure produced the only 2★ and cost 5★ goodwill); do not over-build ('does everything you need it to do with very little drama' is the product spec)
- **This app does:** minimal, free, ad-free, account-free
- **User reaction:** praise
- **Magnitude:** 52 + 12 + 4; 1 2★ + 1 5★ regression
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13807267873`, `13933124385`, `13215630472`
- **Canonical:** C006 Stay minimal and ad-free; C082 Ads in the free tier; C155 Never remove a feature people bought the app for — add alongside, do not replace; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek; C209 No sign-up wall before first use

## Things to do

### R27-014 — Cheapest high-value fixes in evidence order: make the widget live and interactive (9) → ship a monthly view (5) → make iCloud sync and backup visible in-app (4) → restore or offer the full-year grid as a selectable view (3) → fix habit reordering so the order sticks (3) → add per-weekday scheduling and fix the reminder-after-completion bug (2) → make existing tags selectable (2) → add a Monday week-start setting (2) → fix the dead website link in Settings (1) → add a tip jar (2)

- **Where:** Executive summary #12 — cheapest high-value fixes in evidence order: live interactive widget (9) → monthly view (5) → visible iCloud sync/backup (4) → full-year grid as a selectable view (3) → habit reordering that sticks (3) → per-weekday scheduling and reminder-after-completion fix (2) → selectable existing tags (2) → Monday week start (2) → dead website link (1) → tip jar (2)
- **This app does:** none shipped as of Sep 2026
- **User reaction:** complaint
- **Magnitude:** report gives none (ranked list)
- **Direction for us:** do · **Report confidence:** summary ranking · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views; C023 Interactive widget check-off; C036 A support channel that exists, is reachable outside the app, and answers; C039 Reminders fire reliably, once; C043 Flexible / custom frequency; C045 Grouping / folders / categories / tags; C073 Manual reordering, renaming and editing of habits/tasks — free; C097 A tip / donate option; C153 Automatic cloud backup on by default — never manual opt-in; C155 Never remove a feature people bought the app for — add alongside, do not replace; C170 Configurable day boundary and hemisphere seasons

## Contradictions

### R27-045 — Themes that cut both ways: the widget (5 praise vs 9 missing/static/blank); simplicity (52 praise vs 'still a bit simple', 'Limited featuees' at 3★, 'the note taking doesn't really have a point'); notes/journal ('simply yet engaging daily memo questions' vs pointless / export removed / wants more); the 2025 update ('the recent update is cool' for multi-check-in, in the same review that reports the year-grid regression, plus the crash cluster); ease of use (52 simplicity reviews vs 5 onboarding-confusion reviews)

- **Where:** §4.3 Themes in both directions (verbatim table) — widget 5 praise vs 9 gaps; simplicity 52 vs 'still a bit simple' / 'Limited featuees'; notes/journal engaging vs pointless; the 2025 update 'cool' (multi-check-in) vs the crash cluster and removals; ease of use vs 5 onboarding-confusion reviews
- **This app does:** minimal by design
- **User reaction:** mixed
- **Magnitude:** Theme | Positive side | Negative side ; Widget | 5 reviews praise it (8819961417, 10765907509, 11088501172, 13919778285, 14179666010) | 9 reviews find it missing, static, blank or uninformative ; Simplicity | 52 reviews praise it | 13784793079 ("still a bit simple"), 13642789952 (3★, "Limited featuees"), 13761980153 ("the note taking doesn't really have a point") ; Notes / journal | 12136156984 ("simply yet engaging daily memo questions") | 13761980153 (pointless), 13178799590 (export removed), 12473008094 (wants more) ; The 2025 update | 13077199701 ("最近的更新很酷" — "the recent update is cool", multi-check-in praised) | The same review, plus 13215630472, 13178799590, and the crash cluster ; Ease of use | 52 simplicity reviews | 5 onboarding-confusion reviews (10477776521, 12128390503, 12146867601, 13220635530, 13414248154)
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13784793079`, `13642789952`, `13761980153`, `12136156984`, `13077199701`, `13215630472`, `13178799590`
- **Canonical:** C006 Stay minimal and ad-free; C040 Widgets must not go blank, stale or disagree with the app; C172 Per-day / per-habit notes and journal text

## Data caveats and method

### R27-002 — Method: 138/138 read individually in a single pass (rating ascending, then date), exhaustive manual assignment to 33 non-exclusive themes with written boundary rules — no regex classifier, no language recall gap (seven non-English records translated in place); at N=138 one review = 0.72% (formally 'meaningful'), so the raw count is printed first and themes with n<5 are flagged [THIN]; no storefront reaches 50 (US max 43) so no standalone country conclusions; 79.0% 5★ and 70.3% from 2025–26, only 12 reviews in the first 19 months; one reviewer discloses a review prompt ('Saw the message and had to rate'), no evidence of reward-for-review; zero paying customers by construction (regex probe for paid/bought/subscribed/refund returns 0); no support-quality analysis possible (not one review mentions contacting support or a developer reply); the App Store listing was consulted and every claim from it labelled [LISTING]; collection gaps June 2025, and July–Aug 2026 hold 1 and 2 records; votes 4 records, is_edited 2 — not used; zero duplicate title+body pairs

- **Where:** How to read this; Six warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Deduplication; §1.5 Classification method and error risk; §1.6 Limitations; §9.1 counting rules
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 138/138; 23 storefronts; 0 empty; 100% assigned to ≥1 theme; mean 2.3 themes/record; 49 request-bearing reviews (35.51%, mean 4.02) vs 89 pure praise (64.49%, mean 4.99)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `12023192028`, `11699207962`, `13240874103`, `14153452499`
- **Canonical:** — (nuance register)

### R27-015 — Coverage exact on all checks (138 / 23 storefronts / rating 109·18·6·1·4 / mean 4.6449); known error risk: assignment judgement on the two largest themes, applied conservatively so both headline numbers are floors; small-n instability (0.72pp per record); positivity skew (the only observed churn is one review); collection gaps (June 2025 empty; July–Aug 2026 1 and 2 records — do not read the tail as decline); era imbalance (2022–23 only 12 records)

- **Where:** §1.3 Coverage table (verbatim); §1.5 Known error risk table (verbatim) — assignment judgement is the largest risk; the two headline numbers are floors; small-n instability; positivity skew (only observed churn is one review); collection gaps; era imbalance
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Risk | Assessment ; Assignment judgement | The largest risk. Boundary calls on praise_simplicity_minimal (52 records) and praise_free_no_iap (47) materially move the two biggest numbers. Both were applied conservatively: a review counts for praise_free_no_iap only if it names free/no-IAP/no-subscription/no-paywall/price explicitly. Reviews that merely *imply* it by contrast with expensive rivals (13571505007, 13919778285, 13974276382) were excluded from that theme and counted only under competitor_price_contrast. Both headline numbers are therefore floors. ; Small-n instability | At n=138, each record moves any rate by 0.72pp. Themes with n<5 are flagged [THIN] and should be read as anecdotes. ; Positivity skew | 79.0% of records are 5★. App Store reviews are self-selected; silent churn is invisible. The only churn actually observed in the corpus is 13444084049 ("time for a new app"). ; Collection gaps | Two months inside the active period have zero reviews: June 2025 and — with an extraction date of 8 September 2026 — the corpus ends 25 August 2026. July 2026 has only 1 record and August 2026 only 2. Do not read the 2026 tail as a decline. ; Era imbalance | 2022–23 carries only 12 records (8.7%) against 55 for 2025 and 42 for 2026. All era comparisons lead with the later, better-populated eras.
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R27-016 — Feature inventory, review-derived with [LISTING] items

- **Where:** §2.1 Feature inventory table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Feature | Status in reviews | Evidence IDs ; Habit / goal creation with custom name | Confirmed, free | 12132900869, 13923424034, 14196975012 ; Custom colour per habit | Confirmed, free | 11346385680, 12132900869, 12973708986, 13233606022 ; Custom icon / symbol per habit | Confirmed, free; edit sometimes reverts | 12041030739, 12132900869, 12877783902 (wants better icons), 13498254162 (reverts — defect) ; App icon change | Confirmed, free | 12041030739 ; Theme / colour theme | Confirmed, free; no fine-grained tuner | 11346385680, 13919778285, 12973708986 (wants a tuner) ; Year-at-a-glance calendar grid | Confirmed; demoted in the 2025 update | 8819961417, 10477776521, 10787472094, 12944050597, 8918509405; regression: 13077199701, 13215630472 ; Daily list / day view | Confirmed, free | 11346385680, 12944050597, 10639973409 ; Weekly view / weekly review | Confirmed, free | 13463476864 ("existing weekly and yearly reviews"), 10966990397 ; Monthly view | Absent — requested 5 times, never shipped | 8918509405, 13155678708, 13463476864, 13642789952, 14239313970 ; Backfill — tap past dates to mark complete | Confirmed and praised; broke for the annual grid in 2025 | 11346385680; regression: 13077199701 ; Multi-tap / mark all goals for a date | Confirmed, praised | 11346385680 ; Multiple completions per day | Shipped ~Aug 2025, praised | 13077199701 ("每天多次打卡功能很好用"), 13987574053 ; Flexible frequency (x times per week) | Shipped, praised | 13903934801 ("tasks that can be completed a few times a week rather than everyday") ; Per-weekday scheduling (skip Sat/Sun) | Requested, not confirmed shipped | 12944050597 ; Streaks / streak counter | Core feature, praised | 10477776521, 10780603796, 12582425991, 14099500769, 14179666010 ; Streak length visible from list | Hard to see | 11088501172 ; Streak freeze | [LISTING] — listed by the developer; zero reviewers mention it | — ; Statistics | Confirmed, praised | 13807267873 ("Love all the stats it records"), 13987574053, 12146188261 ; Data export | Confirmed; one-tap note export removed in 2025 | 12146188261 ("export data for nerdy kind"); regression: 13178799590 ; Journal / notes / daily memo prompts | Confirmed; value disputed | 12136156984 ("simply yet engaging daily memo questions"); 13761980153 ("the note taking doesn't really have a point to it"); 12473008094 (wants a fuller daily log) ; Reminders / notifications | Confirmed, free; fire even after completion | 13923424034, 14165879048; defect: 14088668819 ; Widgets | Confirmed, free; read-only, non-interactive, sometimes blank | Praise 8819961417, 10765907509, 11088501172, 13919778285, 14179666010; gaps 8865309570, 9631112670, 10197682121, 11272404025, 11937614517, 13111651177, 13255216161, 13414248154, 14088668819 ; Habit reordering | Shipped by Aug 2025; order does not stick | 12973708986 (praises it); defects 13118792795, 11762567349, 13608165763 ; Tags | Confirmed; cannot select existing tags; duplicates don't group | 13243690627, 13491426055 ; iCloud sync | Confirmed once, then invisible | 10655126869 ("seamless iCloud syncing"); gaps 11937614517, 12900579642, 13481955817, 13491588986 ; Goal end date / countdown | [LISTING] — listed; requested by a reviewer in Dec 2025 as missing | 13498254162 ; Habit archiving | [LISTING] — listed; the Dec 2025 reviewer asked for exactly this and did not have it | 13498254162 ; Dark mode | [LISTING]; no reviewer comments | — ; Apple Health integration | Absent, requested | 13999741050 ; Apple Watch app | Absent, requested | 14001830867 ; macOS app | Absent, requested | 10655126869 ; Monday week start | Absent, requested twice | 10795403293, 10966990397 ; Accounts / login | None required — praised as a feature | 12146188261, 13490755611, 13974276382, 12023192028 ; Ads | None | 10787472094, 11085682019, 11756328020, 11762567349, 12418040350, 12926444561, 12944050597, 12973708986, 13487801599, 13490755611, 13933124385, 14037309039 ; In-app purchases | None | 47 reviews, see 2.2 ; Website link in Settings | Broken — points at an inactive domain | 11393669723
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R27-027 — Master theme table (denominator 138) with rating spreads; aggregate split: 49 reviews (35.51%, mean 4.02) carry at least one request, gap or defect and 89 (64.49%, mean 4.99) are pure praise; of the 49, 21 are 5★ and 17 are 4★ — 38 of 49 (77.6%) of the people asking for something still rated 4★ or 5★; the request backlog is a wish list from satisfied users, not a complaint queue, and unusually safe to prioritise from

- **Where:** §3.1 Verified theme table (verbatim), 32 rows + singletons; aggregate split 49 request-bearing (35.51%, mean 4.02) vs 89 pure praise (64.49%, mean 4.99); 38 of 49 askers still rated 4–5★ — a wish list from satisfied users, unusually safe to prioritise from
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | Direction | n | % of 138 | Signal | Mean ★ | Rating spread ; 1 | praise_simplicity_minimal | positive | 52 | 37.68% | HIGH-PRIORITY | 4.90 | 5★47 4★5 ; 2 | praise_free_no_iap | positive | 47 | 34.06% | HIGH-PRIORITY | 4.89 | 5★42 4★5 ; 3 | praise_design_aesthetic | positive | 19 | 13.77% | HIGH-PRIORITY | 4.89 | 5★17 4★2 ; 4 | competitor_price_contrast | positive | 13 | 9.42% | HIGH-PRIORITY | 4.92 | 5★12 4★1 ; 5 | switched_from_competitor | positive | 13 | 9.42% | HIGH-PRIORITY | 4.85 | 5★11 4★2 ; 6 | praise_no_ads | positive | 12 | 8.70% | HIGH-PRIORITY | 4.83 | 5★10 4★2 ; 7 | praise_generic_only | positive | 12 | 8.70% | HIGH-PRIORITY | 5.00 | 5★12 ; 8 | praise_customization | positive | 10 | 7.25% | HIGH-PRIORITY | 4.80 | 5★8 4★2 ; 9 | praise_developer_trust | positive | 10 | 7.25% | HIGH-PRIORITY | 5.00 | 5★10 ; 10 | outcome_behaviour_change | positive | 10 | 7.25% | HIGH-PRIORITY | 4.70 | 5★8 4★1 3★1 ; 11 | widget_gap_or_defect | negative | 9 | 6.52% | HIGH-PRIORITY | 4.33 | 5★6 4★2 1★1 ; 12 | praise_widget | positive | 5 | 3.62% | very strong | 4.80 | 5★4 4★1 ; 13 | want_monthly_view_or_summary | negative (gap) | 5 | 3.62% | very strong | 4.00 | 5★2 4★1 3★2 ; 14 | bug_crash_launch | negative | 5 | 3.62% | very strong | 2.00 | 4★1 3★1 1★3 ; 15 | regression_after_update | negative | 5 | 3.62% | very strong | 2.60 | 5★1 4★1 2★1 1★2 ; 16 | onboarding_confusion | mixed | 5 | 3.62% | very strong | 4.00 | 5★3 4★1 1★1 ; 17 | keep_free_plea | positive/risk | 4 | 2.90% | meaningful [THIN] | 5.00 | 5★4 ; 18 | praise_long_range_view | positive | 4 | 2.90% | meaningful [THIN] | 5.00 | 5★4 ; 19 | data_durability_concern | negative | 4 | 2.90% | meaningful [THIN] | 3.75 | 5★2 4★1 1★1 ; 20 | praise_privacy_no_account | positive | 4 | 2.90% | meaningful [THIN] | 5.00 | 5★4 ; 21 | sync_multi_device_gap | negative (gap) | 3 | 2.17% | meaningful [THIN] | 5.00 | 5★3 ; 22 | reorder_or_organise_habits | negative | 3 | 2.17% | meaningful [THIN] | 4.00 | 5★1 4★1 3★1 ; 23 | notes_journal_gap | mixed | 3 | 2.17% | meaningful [THIN] | 3.33 | 4★2 2★1 ; 24 | praise_flexible_frequency | positive | 3 | 2.17% | meaningful [THIN] | 4.67 | 5★2 4★1 ; 25 | praise_unlimited_habits | positive | 3 | 2.17% | meaningful [THIN] | 5.00 | 5★3 ; 26 | praise_stats_export | positive | 3 | 2.17% | meaningful [THIN] | 5.00 | 5★3 ; 27 | tip_jar_donate | positive/opportunity | 2 | 1.45% | meaningful [THIN] | 5.00 | 5★2 ; 28 | tags_problem | negative | 2 | 1.45% | meaningful [THIN] | 3.50 | 4★1 3★1 ; 29 | week_start_monday | negative (gap) | 2 | 1.45% | meaningful [THIN] | 4.50 | 5★1 4★1 ; 30 | backfill_or_import_streaks | negative (gap) | 2 | 1.45% | meaningful [THIN] | 4.50 | 5★1 4★1 ; 31 | praise_reminders | positive | 2 | 1.45% | meaningful [THIN] | 5.00 | 5★2 ; 32 | Singleton requests (12 distinct, see 3.5) | negative (gaps) | 12 | 8.70% | HIGH-PRIORITY (aggregate) | 4.25 | 5★4 4★7 3★1
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R27-035 — Unmet needs ranked with first/last ask dates: live/interactive widget 9 (2022-07-12 → 2026-05-21); monthly view 5 (2022-07-27 → 2026-06-29); visible backup & cross-device sync 4 (+3 sync) (2023-12 → 2025-12); reliable ordering/grouping 3; restore the full-year grid as a selectable view 3 (incl. a year-progress % display); richer journal/daily log 3; selectable existing tags 2; Monday week start 2 (2024-01 → 2024-02); backfill/import an existing streak by start date 2; tip jar/donation 2

- **Where:** §3.4 Unmet needs table (verbatim) — widget 9 (2022-07 → 2026-05); monthly view 5 (2022-07 → 2026-06); backup & sync 4+3; reliable ordering 3; full-year grid restore 3; richer journal 3; tags 2; Monday week start 2; backfill/import a streak by start date 2; tip jar 2
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Rank | Need | n | % of 138 | Signal | IDs | First asked | Last asked ; 1 | Live / interactive / informative widget | 9 | 6.52% | HIGH-PRIORITY | 8865309570, 9631112670, 10197682121, 11272404025, 11937614517, 13111651177, 13255216161, 13414248154, 14088668819 | 2022-07-12 | 2026-05-21 ; 2 | Monthly view / monthly summary | 5 | 3.62% | very strong | 8918509405, 13155678708, 13463476864, 13642789952, 14239313970 | 2022-07-27 | 2026-06-29 ; 3 | Visible, trustworthy backup & cross-device sync | 4 (+3 sync) | 2.90% / 2.17% | meaningful [THIN] | 11762567349, 13444084049, 13481955817, 13491588986; sync 10655126869, 11937614517, 12900579642 | 2023-12-04 | 2025-12-08 ; 4 | Reliable habit ordering / grouping | 3 | 2.17% | meaningful [THIN] | 11762567349, 13118792795, 13608165763 | 2024-09-25 | 2026-01-08 ; 5 | Restore the full-year grid as a selectable view | 3 | 2.17% | meaningful [THIN] | 13077199701, 13215630472, 8882537119 (year-progress %) | 2022-07-17 | 2025-10-02 ; 6 | Richer journal / daily log | 3 | 2.17% | meaningful [THIN] | 12473008094, 13178799590, 13761980153 | 2025-03-28 | 2026-02-18 ; 7 | Selectable existing tags + tag grouping | 2 | 1.45% | meaningful [THIN] | 13243690627, 13491426055 | 2025-10-09 | 2025-12-08 ; 8 | Monday week start (configurable) | 2 | 1.45% | meaningful [THIN] | 10795403293, 10966990397 | 2024-01-07 | 2024-02-22 ; 9 | Backfill / import an existing streak by start date | 2 | 1.45% | meaningful [THIN] | 13077199701, 13481955817 | 2025-08-30 | 2025-12-06 ; 10 | Tip jar / donation | 2 | 1.45% | meaningful [THIN] | 10787472094, 11393669723 | 2024-01-05 | 2024-06-18
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `8882537119`, `12473008094`, `13178799590`, `13761980153`, `13077199701`, `13481955817`
- **Canonical:** — (nuance register)

### R27-037 — Twelve singleton requests (each n=1, 0.72%), listed in full because suppressing them at this corpus size would discard real product information: per-weekday scheduling (skip Sat/Sun); Apple Health (exercise, water, steps, sleep); Apple Watch; macOS; a goal end date so completed goals stop repeating but stay visible; suppress the reminder once the goal is marked done; streak length readable from the day list; a fine-grained theme-colour tuner; more realistic icons; day-of-year and '% of the year elapsed'; prevent accidental habit-add when tapping a day; fix the dead website link in Settings — 'a five-minute fix reported by a 5★ reviewer'

- **Where:** §3.5 Singleton requests table (verbatim) — per-weekday scheduling; Apple Health; Apple Watch; macOS; goal end date so completed goals stop repeating but stay visible; suppress reminder once done; streak length readable from the list; theme-colour tuner; more realistic icons; day-of-year and % of year elapsed; prevent accidental habit-add; fix the dead website link (a five-minute fix reported by a 5★ reviewer)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Request | ID | Country | ★ | Date ; Per-weekday scheduling ("run Mon–Fri, skip Sat/Sun") | 12944050597 | US | 5 | 2025-07-27 ; Apple Health integration (exercise, water, steps, sleep) | 13999741050 | US | 4 | 2026-04-26 ; Apple Watch app | 14001830867 | US | 4 | 2026-04-27 ; macOS app | 10655126869 | US | 5 | 2023-12-04 ; Goal end date so completed goals stop repeating but stay visible | 13498254162 | CA | 3 | 2025-12-10 ; Suppress the reminder once the goal is already marked done | 14088668819 | DE | 4 | 2026-05-21 ; Streak length readable from the day list without drilling in | 11088501172 | NO | 4 | 2024-03-26 ; Fine-grained theme-colour tuner for the main interface | 12973708986 | US | 4 | 2025-08-04 ; More realistic habit icons | 12877783902 | IN | 4 | 2025-07-11 ; Day-of-year and "% of the year elapsed" display | 8882537119 | CN | 4 | 2022-07-17 ; Prevent accidental habit-add when tapping a day on the main screen | 12023192028 | US | 5 | 2024-12-04 ; Fix the dead website link in Settings | 11393669723 | CA | 5 | 2024-06-18
- **Direction for us:** none · **Report confidence:** single reviews · **Generalisable:** yes
- **Review IDs:** `12944050597`, `13999741050`, `14001830867`, `10655126869`, `13498254162`, `14088668819`, `11088501172`, `12973708986`, `12877783902`, `8882537119`, `12023192028`, `11393669723`
- **Canonical:** — (nuance register)

### R27-039 — Rating distribution 5★ 109 (79.0%) · 4★ 18 (13.0%) · 3★ 6 (4.3%) · 2★ 1 (0.7%) · 1★ 4 (2.9%), mean 4.645; restricting to substantive reviews (>60 chars, n=101) the mean is 4.594 — essentially unchanged; there is no short-review inflation problem (12 records ≤25 chars vs 101 over 60): a corpus of people who wrote something

- **Where:** §4.1 Distribution table (verbatim) — 5★ 109 (79.0%), 4★ 18, 3★ 6, 2★ 1, 1★ 4; substantive mean 4.594 vs 4.645; no short-review inflation (only 12 ≤25 chars, 101 >60) — a corpus of people who wrote something
- **This app does:** no aggressive review prompt
- **User reaction:** praise
- **Magnitude:** Rating | n | % of 138 | Cumulative ; 5★ | 109 | 79.0% | 79.0% ; 4★ | 18 | 13.0% | 92.0% ; 3★ | 6 | 4.3% | 96.4% ; 2★ | 1 | 0.7% | 97.1% ; 1★ | 4 | 2.9% | 100.0%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R27-047 — This app has never had a paid tier and there are zero paid users in the corpus: a direct probe for 'I paid / I bought / I subscribed / my subscription / refund' across all 138 records returns 0 matches; no trial, paywall, refund, cancellation, restore-purchase failure or billing dispute appears anywhere in four years of reviews

- **Where:** Part 5 intro — zero paid users by construction: a probe for purchase language returns 0 matches across 138 records; no trial, paywall, refund, cancellation, restore failure or billing dispute anywhere in four years
- **This app does:** free, no IAP
- **User reaction:** none
- **Magnitude:** 0 of 138
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R27-083 — Research questions: did the September 2025 update cause the crash or did iOS 26 (two reviewers blame each — crash logs would settle it and change the release-process fix); is iCloud sync actually working for everyone (opt-in, silently failing, or just invisible); did Monday week-start, goal end date and archiving ship (the listing suggests the latter two); why does China rate lowest (4.00, n=7) while writing the most technically detailed reviews; would a tip jar cannibalise goodwill (both requests Canadian, both 2024, none since — a limited rollout with rating monitoring); what does the silent majority think (138 reviews over four years is a thin record); is the year-grid de-emphasis deliberate (if so, the trade-off was under-priced)

- **Where:** §8.4 Research questions Part 8 #1–#7 — did the Sept 2025 update or iOS 26 cause the crash; is iCloud sync working for everyone (opt-in, silently failing, or invisible); did Monday start, goal end date and archiving ship; why does China rate lowest while writing the most detailed reviews; would a tip jar cannibalise goodwill; what does the silent majority think; is the year-grid de-emphasis deliberate
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (questions)
- **Direction for us:** research · **Report confidence:** open questions · **Generalisable:** yes
- **Review IDs:** `13240874103`, `13444084049`, `13338573061`, `13169445559`, `10655126869`
- **Canonical:** — (nuance register)
