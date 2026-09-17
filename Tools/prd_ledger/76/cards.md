# Cards — report 76

Source: `App Store Reports/76. Way of Life - Habit Tracker - Build a better, stronger you (REPORT).md`  
117 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 2
- [Must-haves](#must-haves) — 2
- [Must never break](#must-never-break) — 6
- [Features](#features) — 23
- [Monetization](#monetization) — 11
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 15
- [Audiences](#audiences) — 3
- [Markets and languages](#markets-and-languages) — 17
- [Dated events and trends](#dated-events-and-trends) — 10
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 7
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 3
- [Data caveats and method](#data-caveats-and-method) — 10

## Product rules

### R76-004 — Asking the developer NOT to add features is recent and comes from veterans: PR_KEEP_SIMPLE 64 (0.82%), 61 of them in E5–E6; E6 reviewers include many long-term users — TENURE_LONG 187 of 906 E6 reviews (20.6%) vs 2.1% in E2; 'Please do not change a single thing' (#6164, de, 5★).

- **Where:** §0.1 (keep simple); §3.5
- **This app does:** kept simple over 16 years
- **User reaction:** praise
- **Magnitude:** PR_KEEP_SIMPLE 64 / 0.82%, 61 in E5–E6; TENURE_LONG 20.6% of E6 vs 2.1% of E2
- **Direction for us:** product-rule · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Conditions:** the request to freeze the product grows with tenure
- **Review IDs:** `6379998517`, `7243490138`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R76-112 — §8.8 what the corpus says to keep: the three-state grid, good/bad inversion and skip; the charts and at-a-glance overview; a free tier that works for three habits — some say the limit helps them focus (#7013, #4439); one-person, responsive development thanked by name.

- **Where:** §8.8; part 8 #8
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** PR_SIMPLE 1532; PR_INSIGHTS 838; PR_FREE 249; PR_DEV 268
- **Direction for us:** must-never-break · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `10969791376`, `1399309366`, `4420297480`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C007 Generous fixed habit cap (or unlimited) — never change it; C012 Week / month / year grid views; C155 Never remove a feature people bought the app for — add alongside, do not replace

## Must-haves

### R76-063 — Support (verbatim): Code | Dir | Meaning | n | % of 7,764 | Band | Mean ★ | Dates ; PR_SUPPORT | + | Support responsive | 68 | 0.88% | Emerging signal | 4.79 | 2011-01-23 → 2026-03-23 ; SUP_NONE | - | Support did not reply | 20 | 0.26% | Weak signal | 2.05 | 2016-03-18 → 2026-01-23 ; NEG_SLOW_DEV | - | Not updated / slow development | 20 | 0.26% | Weak signal | 3.50 | 2012-09-02 → 2026-02-08 ; NEG_DEV_PROMISE | - | Promised feature never came | 6 | 0.08% | Ignore by default | 3.00 | 2013-10-20 → 2026-03-21 ; MON_QUESTION | ~ | Asks how something works | 13 | 0.17% | Weak signal | 4.23 | 2015-02-01 → 2026-04-25 — through 2016 praised for speed ('developer emailed me back in less than 5 minutes'; 'innerhalb von einem Tag gelöst'); silence reported from 2016 and most frequent in E6 (9 of 20) alongside restore failures and a contact form that does not work ('secção de Contact no website não funciona', pt 1★); 'I think they are just one person, so be patient'.

- **Where:** §3.8 table (verbatim); §3.8; §8.3
- **This app does:** solo developer; support fast early, silent later
- **User reaction:** mixed
- **Magnitude:** PR_SUPPORT 68 (0.88%, 4.79); SUP_NONE 20 (0.26%, 2.05), 9 in E6; NEG_SLOW_DEV 20; NEG_DEV_PROMISE 6; MON_QUESTION 13
- **Direction for us:** must-have · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Conditions:** support silence coincides with the subscription switch
- **Review IDs:** `504207844`, `1390768771`, `13244707998`, `8458663871`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R76-107 — §8.3 immediate fix — a support route that answers: a working in-app contact form and an auto-reply with restore steps (SUP_NONE 20, 9 in E6; #7352 broken website contact section).

- **Where:** §8.3; part 8 #3
- **This app does:** contact form broken; silence in E6
- **User reaction:** complaint
- **Magnitude:** SUP_NONE 20, 9 in E6
- **Direction for us:** must-have · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `13244707998`, `13009268502`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

## Must never break

### R76-010 — Local-only data: loved for privacy, lost on updates and new phones — U_DATA_RISK 123 (1.58%, mean 3.04★, Meaningful): BUG_DATA_LOSS 38 (0.49%), NEG_BACKUP_MANUAL 13, BUG_BACKUP 10, NEG_DROPBOX_BLOCKED 18; the corresponding request is the second most frequent — REQ_SYNC 139 (1.79%, mean 4.01★, Meaningful) + REQ_AUTO_BACKUP 12; the same design is praised by others: PR_PRIVACY 12. Some losses are long histories gone after an update or a phone change because backup was manual: 'using Way of Life daily for over four years' … 'I downloaded an update and all of my data disappeared' (2★); 'for the third time, I've lost my data because I forgot to backup my data' (3★); 'I lost all my habits when I got a new phone even though I paid for the app' (5★).

- **Where:** §0.5; §3.4; §3.6 (sync); §8.2
- **This app does:** local-only storage; manual backup (Dropbox early); backup to cloud premium until 4.3.0 made it free
- **User reaction:** complaint
- **Magnitude:** U_DATA_RISK 123 / 1.58% / mean 3.04; BUG_DATA_LOSS 38; REQ_SYNC 139 / 1.79% / mean 4.01; REQ_AUTO_BACKUP 12; PR_PRIVACY 12
- **Direction for us:** must-never-break · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Side effects:** privacy praise and data-loss complaints come from the same design
- **Review IDs:** `1798965025`, `13557616119`, `1488838993`, `493729635`, `1033888911`, `1106982038`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one; C085 Address tracking / privacy visibly; C153 Automatic cloud backup on by default — never manual opt-in; C176 Never let fear of losing history be the reason people pay; C209 No sign-up wall before first use; C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement

### R76-046 — Defect codes (verbatim): Code | Dir | Meaning | n | % of 7,764 | Band | Mean ★ | Dates ; BUG_UPDATE_BROKE | - | Update broke the app | 54 | 0.70% | Emerging signal | 2.80 | 2012-05-18 → 2025-12-26 ; BUG_PURCHASE | - | Purchase not restored / not credited | 54 | 0.70% | Emerging signal | 2.69 | 2011-12-11 → 2026-06-18 ; BUG_CRASH | - | Crashes | 39 | 0.50% | Emerging signal | 2.08 | 2012-05-18 → 2024-12-22 ; BUG_DATA_LOSS | - | Data lost | 38 | 0.49% | Weak signal | 2.92 | 2012-07-29 → 2025-12-26 ; BUG_OTHER | - | Other bug | 26 | 0.33% | Weak signal | 3.15 | 2012-11-20 → 2026-04-25 ; BUG_LANG | - | Translation errors | 15 | 0.19% | Weak signal | 3.60 | 2012-07-25 → 2022-04-21 ; BUG_REMINDER | - | Reminder defect | 14 | 0.18% | Weak signal | 2.86 | 2011-11-05 → 2022-02-17 ; BUG_SLOW | - | Slow / laggy | 10 | 0.13% | Weak signal | 4.20 | 2012-05-20 → 2019-05-08 ; BUG_OS_UPDATE | - | New iOS / device not supported | 10 | 0.13% | Weak signal | 3.50 | 2011-11-05 → 2022-09-28 ; BUG_BACKUP | - | Backup/restore fails | 10 | 0.13% | Weak signal | 2.70 | 2014-11-28 → 2024-04-18 ; BUG_PASSCODE | - | Passcode / Face ID problem | 7 | 0.09% | Ignore by default | 3.29 | 2011-12-24 → 2024-10-27 ; BUG_NOTES | - | Notes defect | 5 | 0.06% | Ignore by default | 4.40 | 2014-07-26 → 2016-06-01 ; BUG_CHART | - | Stats wrong | 5 | 0.06% | Ignore by default | 3.20 | 2013-01-16 → 2022-01-08 ; BUG_BADGE | - | Badge count defect | 5 | 0.06% | Ignore by default | 4.60 | 2011-10-21 → 2015-11-14 ; BUG_LAUNCH | - | Won't open | 4 | 0.05% | Ignore by default | 2.25 | 2015-10-08 → 2024-04-18 ; BUG_ONBOARDING_LOOP | - | Tutorial stuck | 3 | 0.04% | Ignore by default | 2.67 | 2014-11-05 → 2018-12-17 ; BUG_NOTES_LOST | - | Notes disappear | 2 | 0.03% | Ignore by default | 2.50 | 2014-07-06 → 2016-06-10 ; BUG_DATE | - | Entries on wrong day | 2 | 0.03% | Ignore by default | 3.00 | 2012-05-28 → 2012-06-22 ; BUG_WEEK_START | - | Week-start setting ignored | 1 | 0.01% | Ignore by default | 4.00 | 2015-09-28 → 2015-09-28 ; BUG_LOGIN | - | Repeated login | 1 | 0.01% | Ignore by default | 2.00 | 2014-02-21 → 2014-02-21 ; BUG_EXPORT | - | Export defect | 1 | 0.01% | Ignore by default | 5.00 | 2016-06-08 → 2016-06-08 — purchase not restored BUG_PURCHASE 54 (0.70%, mean 2.69★, 2011-12-11 → 2026-06-18: 'Es hiess ich müsse wieder premium holen' — it said I had to buy premium again, ch 1★); crashes cluster in two waves (BUG_CRASH 39: 11 on cn in 2015-01 after buying premium, 10 in 2016-05 after an update); passcode lock-outs rare but severe ('LOCKED OUT OF APP', ca 1★).

- **Where:** §3.4 table (verbatim); §3.4 bullets
- **This app does:** several defect classes over 16 years
- **User reaction:** complaint
- **Magnitude:** U_BUG_ANY 257 (3.31%, 2.99); BUG_UPDATE_BROKE 54; BUG_PURCHASE 54 / 2.69; BUG_CRASH 39 / 2.08; BUG_DATA_LOSS 38; BUG_LANG 15; BUG_REMINDER 14; BUG_BACKUP 10; BUG_PASSCODE 7
- **Direction for us:** must-never-break · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Review IDs:** `5616625936`, `11882060257`
- **Canonical:** C017 Passcode lock; C031 Crashes / launch failures; C033 Restore purchase and entitlements must work immediately; C175 Updates must not break function or wipe progress

### R76-047 — Purchase not restored / not credited runs the whole corpus and rises in the subscription era: BUG_PURCHASE 54 (0.70%, mean 2.69★, 2011-12-11 → 2026-06-18), 14 in E6 (1.55%) vs 0.91% E5 — 'Es hiess ich müsse wieder premium holen' (1★).

- **Where:** §3.4 (purchase restore)
- **This app does:** restore purchase fails, esp. after model change
- **User reaction:** complaint
- **Magnitude:** BUG_PURCHASE 54 / 0.70% / 2.69; E6 1.55% vs E5 0.91%
- **Direction for us:** must-never-break · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `5616625936`, `13889612885`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R76-048 — Passcode lock-outs are rare but severe: BUG_PASSCODE 7 (mean 3.29★) — 'LOCKED OUT OF APP' (#7122, ca, 1★).

- **Where:** §3.4 (passcode)
- **This app does:** passcode/Face ID lock
- **User reaction:** complaint
- **Magnitude:** BUG_PASSCODE 7 / 3.29
- **Direction for us:** must-never-break · **Report confidence:** Ignore by default · **Generalisable:** generalisable
- **Review IDs:** `11882060257`
- **Canonical:** C017 Passcode lock; C096 Privacy and discretion stack

### R76-105 — §8.1 immediate fix — honour every one-time and lifetime purchase: restore premium for any App Store receipt of the old unlock, on any device, without a subscription prompt (BUG_PURCHASE 54, 14 in E6; MON_SUBSCRIPTION 40); show a single, stable price per region and say on the paywall whether it is monthly, annual or lifetime (MON_DISCLOSURE 33; #7322 '$29 then $99').

- **Where:** §8.1 #1; §8.1 #2; part 8 #1
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** BUG_PURCHASE 54; MON_SUBSCRIPTION 40; MON_DISCLOSURE 33
- **Direction for us:** product-rule · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `13006973106`, `13889612885`, `13811353277`, `13025777165`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C113 One stable, disclosed price — no discount wheels; C186 Never revoke what earlier buyers paid for when the model changes; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

### R76-106 — §8.2 immediate fix — make data loss impossible by default: automatic, silent iCloud backup on by default, and a restore check before any update migrates data (U_DATA_RISK 123; NEG_BACKUP_MANUAL 13); the 4.3.0 note that Backup & Restore is free addresses cost, not the default.

- **Where:** §8.2; part 8 #2
- **This app does:** manual backup; cloud backup was premium until 4.3.0
- **User reaction:** complaint
- **Magnitude:** U_DATA_RISK 123; NEG_BACKUP_MANUAL 13; BUG_DATA_LOSS 38
- **Direction for us:** must-never-break · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Conditions:** backup must be on by default, not merely free
- **Review IDs:** `1798965025`, `13557616119`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

## Features

### R76-005 — The one structural request for fifteen years — habits that are not daily yes/no: U_FLEX_REQ 347 (4.47%, mean 4.13★, 2011-08-14 → 2026-06-03, Very strong) = REQ_FREQUENCY 214 (2.76%: specific weekdays, N times a week, weekly/monthly goals) + REQ_COUNT 129 (1.66%: quantities, several times a day) + NEG_YESNO 36 (0.46%: a partial/'yellow' state); the most frequent code in 4★ after generic praise (96 of 1,281 4★); appears in 15 of 16 calendar years 2011–2026; users work around it with skip, which distorts the percentages they value (NEG_CHART 38); a 2016 reviewer was already waiting for 'promised weekly/monthly options' (#4129); #5130 (cn, 2017) among the most-voted (6 votes). 'In my life things aren't always yes or no'; 'I try to only use skips for actual exceptions to habits, not as a scheduling method' (3★).

- **Where:** §0.2; §3.6 (frequency); §8.4
- **This app does:** absent for 15 years (daily yes/no only)
- **User reaction:** complaint
- **Magnitude:** U_FLEX_REQ 347 / 4.47% / mean 4.13 / Very strong; REQ_FREQUENCY 214 / 2.76%; REQ_COUNT 129 / 1.66%; NEG_YESNO 36; 96 of 1,281 4★; 15 of 16 years
- **Direction for us:** must-have · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Side effects:** skip used as a scheduling workaround corrupts the stats users prize
- **Conditions:** a promised feature (2016) still unmet ten years later
- **Review IDs:** `1705374517`, `2382746040`, `1364445247`, `1489797918`, `1804926052`, `453081285`, `642979041`
- **Canonical:** C043 Flexible / custom frequency; C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which; C265 Tracker types beyond yes/no — numeric target, rolling average and project milestones — as the reason people switch from binary habit apps

### R76-014 — Users want it everywhere — sync, iPad, Watch, widgets: U_PLATFORM_REQ 332 (4.28%, mean 4.14★, Very strong): REQ_SYNC 139 (1.79%), REQ_IPAD 123 (1.58%), REQ_WATCH 54 (0.70%), REQ_WIDGET 41 (0.53%), REQ_MAC 23, REQ_WEB 14, REQ_ANDROID 3; the iPad request dominates the early years (E1 4.7%); Watch and widget requests replace it from 2016 (E5 1.8% and 1.3%); several make the fifth star conditional on it (REV_STAR_TACTIC 19): 'A five star app without iCloud support is a one star app' (gb 1★); 'Five stars if I could open the app on any device and see my data' (3★); 'at this point I would pay to sync' (5★).

- **Where:** §0.7; §3.6 (platforms); §8.5
- **This app does:** absent: no sync, no iPad, no Watch; widgets only from iOS 17
- **User reaction:** complaint
- **Magnitude:** U_PLATFORM_REQ 332 / 4.28% / mean 4.14; REQ_SYNC 139; REQ_IPAD 123; REQ_WATCH 54; REQ_WIDGET 41; REQ_MAC 23; REQ_WEB 14; REV_STAR_TACTIC 19; iPad E1 4.7% → Watch E5 1.8%, widget 1.3%
- **Direction for us:** build-paid · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Side effects:** 'I would pay to sync' — sync is a stated purchase driver
- **Conditions:** which platform is asked for shifts with the decade
- **Review IDs:** `13872213199`, `6948006897`, `7628237879`, `430397979`, `651493208`, `772915802`
- **Canonical:** C009 Basic widgets, icons and colours are free; C013 Cloud sync / multi-device as the paid differentiator; C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C051 Android version; C141 Native iPad layout

### R76-017 — Capability inventory with positive and friction counts (verbatim): Capability | Positive evidence | Friction evidence ; Daily yes/no/skip grid | PR_SIMPLE 1532, PR_EASY 1359, PR_FAST 197, PR_YESNO 73, PR_SKIP 99 | NEG_YESNO 36, NEG_BACKFILL 39, NEG_TWO_TAPS 4, NEG_UI_CONFUSING 81 ; Charts, trends, overview | PR_INSIGHTS 838 | NEG_CHART 38, REQ_STATS 72, REQ_DATE_RANGE 22, BUG_CHART 5 ; Chains and streaks (from 2015-11) | PR_CHAINS 129, PR_MOTIVATION 509 | REQ_STREAKS 21, REQ_GAMIFY 16 ; Reminders and badge | PR_REMINDERS 351 | REQ_REMINDER_PER_ITEM 51, BUG_REMINDER 14, NEG_BADGE 13, BUG_BADGE 5, NEG_NOTIF 11 ; Notes / journal text | PR_NOTES 174 | REQ_NOTES_VIEW 13, REQ_NOTES 21, BUG_NOTES 5, BUG_NOTES_LOST 2, NEG_NOTES_UX 4, REQ_PHOTO 9 ; Tags, archive, reorder | PR_TAGS 35, PR_ARCHIVE 14 | REQ_REORDER 16, REQ_CATEGORIES 37, NEG_ARCHIVE_UX 5, REQ_ARCHIVE 10 ; Export, backup, restore | PR_EXPORT 50, PR_BACKUP 29, PR_PRIVACY 12 | BUG_DATA_LOSS 38, NEG_BACKUP_MANUAL 13, BUG_BACKUP 10, NEG_DROPBOX_BLOCKED 18, REQ_SYNC 139, REQ_AUTO_BACKUP 12 ; Frequency and quantities | — | REQ_FREQUENCY 214, REQ_COUNT 129, NEG_WEEKLY_GOAL 2 ; Platforms | — | REQ_IPAD 123, REQ_WATCH 54, REQ_WIDGET 41, REQ_MAC 23, REQ_WEB 14, REQ_ANDROID 3, NEG_LOST_FEATURE 7 ; Themes, dark mode (from 2019) | PR_THEMES 14, PR_DESIGN 602 | REQ_THEMES 54, NEG_DESIGN 70, NEG_UPDATE_WORSE 17 ; Tutorial | PR_ONBOARDING 48 | NEG_ONBOARDING 6, BUG_ONBOARDING_LOOP 3, NEG_LEARNING_CURVE 17 ; Passcode, Face ID | PR_PASSCODE 7 | BUG_PASSCODE 7, REQ_PASSCODE 3 ; Free tier, premium, tip jar | PR_FREE 249, MON_VALUE 342, MON_TIP 15 | MON_FREE_LIMIT 250, MON_PRICE 306, NEG_ADS 54, MON_UPSELL 13, MON_SUBSCRIPTION 40, BUG_PURCHASE 54 ; Developer and support | PR_DEV 268, PR_SUPPORT 68, PR_UPDATE 255 | SUP_NONE 20, NEG_SLOW_DEV 20, NEG_DEV_PROMISE 6, BUG_UPDATE_BROKE 54 ; Languages | PR_LANG 7 | BUG_LANG 15, REQ_LANG 13, NEG_LANG 1

- **Where:** §2.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** table of 15 capability rows
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C012 Week / month / year grid views; C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells

### R76-018 — Charts, trends, overview are the second-largest praise (PR_INSIGHTS 838, 10.79%) with friction: NEG_CHART 38, REQ_STATS 72, REQ_DATE_RANGE 22, BUG_CHART 5.

- **Where:** §2.1 table row: charts/trends
- **This app does:** free: bar/pie/trend charts, weekly/monthly overview
- **User reaction:** praise
- **Magnitude:** PR_INSIGHTS 838 / 10.79%; NEG_CHART 38; REQ_STATS 72; REQ_DATE_RANGE 22; BUG_CHART 5
- **Direction for us:** build-free · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C011 Weekly / monthly / yearly reports; C012 Week / month / year grid views; C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells

### R76-019 — Chains and streaks (from 2015-11): PR_CHAINS 129, PR_MOTIVATION 509; friction REQ_STREAKS 21, REQ_GAMIFY 16.

- **Where:** §2.1 table row: chains
- **This app does:** free chains since 2015-11
- **User reaction:** praise
- **Magnitude:** PR_CHAINS 129; PR_MOTIVATION 509; REQ_STREAKS 21; REQ_GAMIFY 16
- **Direction for us:** build-free · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C024 Streaks / gamification

### R76-020 — Reminders and badge: PR_REMINDERS 351; friction REQ_REMINDER_PER_ITEM 51, BUG_REMINDER 14, NEG_BADGE 13, BUG_BADGE 5, NEG_NOTIF 11.

- **Where:** §2.1 table row: reminders
- **This app does:** free reminders; per-item reminders requested
- **User reaction:** mixed
- **Magnitude:** PR_REMINDERS 351; REQ_REMINDER_PER_ITEM 51; BUG_REMINDER 14; NEG_BADGE 13; BUG_BADGE 5; NEG_NOTIF 11
- **Direction for us:** build-free · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C008 Daily check-in and reminders are free — never paywall the reminder; C014 Multiple reminders per habit; C123 Notifications are few and finely user-controllable — per-type settings, escalation opt-in, never spammy and never silently retuned

### R76-021 — Notes / journal text: PR_NOTES 174; friction REQ_NOTES_VIEW 13, REQ_NOTES 21, BUG_NOTES 5, BUG_NOTES_LOST 2, NEG_NOTES_UX 4, REQ_PHOTO 9.

- **Where:** §2.1 table row: notes
- **This app does:** free per-day notes
- **User reaction:** praise
- **Magnitude:** PR_NOTES 174; REQ_NOTES_VIEW 13; REQ_NOTES 21; REQ_PHOTO 9
- **Direction for us:** build-free · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C172 Per-day / per-habit notes and journal text; C205 Aggregated, searchable journal / diary across days; C208 Photo / media / URL attached to a habit, memo or diary entry

### R76-022 — Tags, archive, reorder: PR_TAGS 35, PR_ARCHIVE 14; friction REQ_REORDER 16, REQ_CATEGORIES 37, NEG_ARCHIVE_UX 5, REQ_ARCHIVE 10.

- **Where:** §2.1 table row: tags/archive/reorder
- **This app does:** free tags and archive
- **User reaction:** mixed
- **Magnitude:** PR_TAGS 35; PR_ARCHIVE 14; REQ_REORDER 16; REQ_CATEGORIES 37; REQ_ARCHIVE 10
- **Direction for us:** build-free · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C045 Grouping / folders / categories / tags; C073 Manual reordering, renaming and editing of habits/tasks — free; C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot

### R76-023 — Export, backup, restore: PR_EXPORT 50, PR_BACKUP 29, PR_PRIVACY 12; friction BUG_DATA_LOSS 38, NEG_BACKUP_MANUAL 13, BUG_BACKUP 10, NEG_DROPBOX_BLOCKED 18, REQ_SYNC 139, REQ_AUTO_BACKUP 12.

- **Where:** §2.1 table row: export/backup
- **This app does:** CSV/Excel export free; cloud backup premium until 4.3.0
- **User reaction:** mixed
- **Magnitude:** PR_EXPORT 50; PR_BACKUP 29; BUG_DATA_LOSS 38; REQ_SYNC 139
- **Direction for us:** must-have · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C020 Data export / backup / CSV; C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R76-024 — Themes, dark mode (from 2019): PR_THEMES 14, PR_DESIGN 602; friction REQ_THEMES 54, NEG_DESIGN 70, NEG_UPDATE_WORSE 17; dark mode locked behind a paid upgrade drew a 3★ ('this app keeps its dark mode theme locked behind a paid upgrade').

- **Where:** §2.1 table row: themes
- **This app does:** some themes free, some sold (MON_BUY_ITEMS 27)
- **User reaction:** mixed
- **Magnitude:** PR_DESIGN 602; PR_THEMES 14; REQ_THEMES 54; NEG_DESIGN 70; MON_BUY_ITEMS 27
- **Direction for us:** undecided · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `6734062162`
- **Canonical:** C080 Colour themes / dark mode; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C167 Cosmetic and colour variety as the paid layer

### R76-025 — Tutorial / walkthrough: PR_ONBOARDING 48; friction NEG_ONBOARDING 6, BUG_ONBOARDING_LOOP 3, NEG_LEARNING_CURVE 17.

- **Where:** §2.1 table row: tutorial
- **This app does:** interactive walkthrough
- **User reaction:** mixed
- **Magnitude:** PR_ONBOARDING 48; NEG_LEARNING_CURVE 17; BUG_ONBOARDING_LOOP 3
- **Direction for us:** build-free · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R76-026 — Passcode / Face ID: PR_PASSCODE 7; BUG_PASSCODE 7; REQ_PASSCODE 3.

- **Where:** §2.1 table row: passcode
- **This app does:** free passcode lock
- **User reaction:** mixed
- **Magnitude:** PR_PASSCODE 7; BUG_PASSCODE 7; REQ_PASSCODE 3
- **Direction for us:** build-free · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C017 Passcode lock; C096 Privacy and discretion stack

### R76-027 — Developer and support: PR_DEV 268, PR_SUPPORT 68, PR_UPDATE 255; friction SUP_NONE 20, NEG_SLOW_DEV 20, NEG_DEV_PROMISE 6, BUG_UPDATE_BROKE 54. Languages: PR_LANG 7; BUG_LANG 15, REQ_LANG 13, NEG_LANG 1.

- **Where:** §2.1 table row: developer/support; §2.1 table row: languages
- **This app does:** responsive developer in most eras
- **User reaction:** mixed
- **Magnitude:** PR_DEV 268; PR_UPDATE 255; SUP_NONE 20; NEG_SLOW_DEV 20; BUG_LANG 15; REQ_LANG 13
- **Direction for us:** do · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C027 Localise early — it unlocks revenue; C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R76-037 — Skip without guilt — a third state that keeps the chain: PR_SKIP 99 (1.28%, mean 4.66★); REQ_SKIP (7, 2011-10-05 → 2011-11-28) ends before skip praise begins (2012-05-18) — shipping killed the request; but the same state is misused as a scheduling workaround for missing frequency (see U_FLEX_REQ).

- **Where:** §3.2 (skip); §2.1; §3.6 (requests that stop)
- **This app does:** free skip state since 2012
- **User reaction:** praise
- **Magnitude:** PR_SKIP 99 / 1.28% / 4.66; REQ_SKIP 7 ended 2011-11
- **Direction for us:** build-free · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `1430830624`, `2382746040`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

### R76-038 — Good AND bad habits in one grid, colours inverting for habits to avoid: PR_YESNO 73 (0.94%) — 'it reverses the red/green colours for yes and no' (gb 5★); REQ_NEUTRAL_HABIT 5 want a neutral kind.

- **Where:** §3.2 (good/bad habits)
- **This app does:** free good/bad habit types
- **User reaction:** praise
- **Magnitude:** PR_YESNO 73 / 0.94% / 4.84; REQ_NEUTRAL_HABIT 5
- **Direction for us:** build-free · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `2033057159`
- **Canonical:** C019 Quit-habit / bad-habit mode

### R76-052 — Hard to log past days: NEG_BACKFILL 39 (0.50%, mean 3.79★, 2012-03-02 → 2024-03-23) against PR_BACKFILL 8 (5.00★) once it was possible; REQ_FUTURE_ENTRY 9 want to mark future days; REQ_DAY_ROLLOVER 9 want a custom day end.

- **Where:** §3.5 (backfill)
- **This app does:** backfill possible but awkward
- **User reaction:** complaint
- **Magnitude:** NEG_BACKFILL 39 / 0.50% / 3.79; PR_BACKFILL 8 / 5.00; REQ_FUTURE_ENTRY 9; REQ_DAY_ROLLOVER 9
- **Direction for us:** must-have · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C010 Backfill missed days / edit start date; C053 Custom time-of-day segments; C170 Configurable day boundary and hemisphere seasons

### R76-054 — Unmet needs — the request list (verbatim): Code | Dir | Meaning | n | % of 7,764 | Band | Mean ★ | Dates ; REQ_FREQUENCY | ~ | Weekly / specific-day frequency | 214 | 2.76% | Meaningful signal | 4.09 | 2011-08-14 → 2026-06-03 ; REQ_SYNC | ~ | Sync across devices / iCloud | 139 | 1.79% | Meaningful signal | 4.01 | 2012-01-07 → 2026-05-07 ; REQ_COUNT | ~ | Counts / quantities | 129 | 1.66% | Meaningful signal | 4.22 | 2011-09-12 → 2026-03-24 ; REQ_IPAD | ~ | iPad version | 123 | 1.58% | Meaningful signal | 4.10 | 2011-05-21 → 2026-05-07 ; REQ_STATS | ~ | More statistics | 72 | 0.93% | Emerging signal | 4.19 | 2011-07-06 → 2026-02-22 ; REQ_WATCH | ~ | Apple Watch app | 54 | 0.70% | Emerging signal | 4.30 | 2015-08-15 → 2026-06-20 ; REQ_THEMES | ~ | Colours / dark mode | 54 | 0.70% | Emerging signal | 4.22 | 2011-01-13 → 2026-04-23 ; REQ_REMINDER_PER_ITEM | ~ | Per-habit reminders | 51 | 0.66% | Emerging signal | 4.00 | 2011-04-27 → 2019-03-15 ; REQ_WIDGET | ~ | Widget | 41 | 0.53% | Emerging signal | 4.20 | 2014-11-04 → 2025-10-20 ; REQ_CATEGORIES | ~ | Groups / sections | 37 | 0.48% | Weak signal | 4.27 | 2011-01-13 → 2024-05-20 ; REQ_CALENDAR | ~ | Calendar view | 29 | 0.37% | Weak signal | 3.93 | 2011-11-03 → 2024-01-06 ; REQ_GOALS | ~ | Goals / targets | 25 | 0.32% | Weak signal | 4.20 | 2011-11-10 → 2025-12-20 ; REQ_SOCIAL | ~ | Share with friends | 23 | 0.30% | Weak signal | 4.30 | 2013-01-12 → 2026-04-22 ; REQ_MAC | ~ | Mac / desktop | 23 | 0.30% | Weak signal | 4.52 | 2012-08-19 → 2026-06-09 ; REQ_DATE_RANGE | ~ | Other time ranges | 22 | 0.28% | Weak signal | 4.23 | 2011-11-14 → 2025-06-04 ; REQ_STREAKS | ~ | Streak features | 21 | 0.27% | Weak signal | 4.24 | 2010-11-21 → 2022-12-17 ; REQ_NOTES | ~ | Notes features | 21 | 0.27% | Weak signal | 4.00 | 2011-05-30 → 2023-02-13 ; REQ_BACKUP | ~ | Backup options | 21 | 0.27% | Weak signal | 4.19 | 2011-06-04 → 2026-02-15 ; REQ_REORDER | ~ | Reorder / sort | 16 | 0.21% | Weak signal | 4.12 | 2011-08-23 → 2025-12-19 ; REQ_GAMIFY | ~ | Rewards / achievements | 16 | 0.21% | Weak signal | 4.06 | 2013-04-02 → 2025-02-05 ; REQ_WEB | ~ | Web version | 14 | 0.18% | Weak signal | 4.43 | 2012-05-21 → 2025-04-06 ; REQ_LAYOUT | ~ | Layout changes | 14 | 0.18% | Weak signal | 3.93 | 2012-06-04 → 2023-04-09 ; REQ_INTEGRATION | ~ | Integrations | 14 | 0.18% | Weak signal | 4.29 | 2012-05-20 → 2026-04-22 ; REQ_EXPORT | ~ | Export | 14 | 0.18% | Weak signal | 4.36 | 2011-02-03 → 2021-04-19 ; REQ_NOTES_VIEW | ~ | Search / view notes | 13 | 0.17% | Weak signal | 4.15 | 2013-07-17 → 2026-02-22 ; REQ_LANG | ~ | Another language | 13 | 0.17% | Weak signal | 4.00 | 2012-11-28 → 2026-07-13 ; REQ_AUTO_BACKUP | ~ | Automatic backup | 12 | 0.15% | Weak signal | 4.00 | 2015-02-23 → 2026-04-23 ; REQ_ARCHIVE | ~ | Keep data of removed habits | 10 | 0.13% | Weak signal | 4.50 | 2011-11-14 → 2024-02-09 ; REQ_REMINDER_REPEAT | ~ | Repeating reminders | 9 | 0.12% | Weak signal | 4.67 | 2012-12-26 → 2015-12-01 ; REQ_PHOTO | ~ | Photos in notes | 9 | 0.12% | Weak signal | 4.67 | 2014-07-04 → 2023-04-07 ; REQ_LANDSCAPE | ~ | Landscape | 9 | 0.12% | Weak signal | 3.44 | 2012-09-03 → 2025-06-15 ; REQ_FUTURE_ENTRY | ~ | Mark future days | 9 | 0.12% | Weak signal | 4.22 | 2013-04-25 → 2020-05-31 ; REQ_DAY_ROLLOVER | ~ | Custom day end | 9 | 0.12% | Weak signal | 4.22 | 2014-05-11 → 2024-10-17 ; REQ_BULK_ENTRY | ~ | Bulk or quicker entry | 9 | 0.12% | Weak signal | 4.44 | 2012-04-21 → 2026-04-22 ; REQ_REMINDER_SCHEDULE | ~ | Reminder scheduling | 8 | 0.10% | Weak signal | 4.75 | 2012-04-23 → 2024-02-17 ; REQ_CONTENT | ~ | Guidance content | 8 | 0.10% | Weak signal | 4.12 | 2014-02-09 → 2026-02-22 ; REQ_CHART_CUSTOM | ~ | Chart customisation | 8 | 0.10% | Weak signal | 4.38 | 2013-08-05 → 2016-03-12 ; REQ_SKIP | ~ | Neutral / skip state | 7 | 0.09% | Ignore by default | 4.00 | 2011-10-05 → 2011-11-28 ; REQ_EDIT_HISTORY | ~ | Edit history | 7 | 0.09% | Ignore by default | 4.14 | 2011-03-07 → 2014-08-09 ; REQ_SUBTASKS | ~ | To-dos / subtasks | 6 | 0.08% | Ignore by default | 4.33 | 2014-02-23 → 2018-12-20 ; REQ_NOTIF_ACTION | ~ | Complete from notification | 6 | 0.08% | Ignore by default | 3.83 | 2015-02-11 → 2025-06-05 ; REQ_IMPORT | ~ | Import | 6 | 0.08% | Ignore by default | 3.83 | 2012-07-02 → 2014-03-07 ; REQ_TIMER | ~ | Timer | 5 | 0.06% | Ignore by default | 3.20 | 2012-12-09 → 2021-04-21 ; REQ_PRIORITY | ~ | Priority / points | 5 | 0.06% | Ignore by default | 4.40 | 2012-10-08 → 2017-09-29 ; REQ_NEUTRAL_HABIT | ~ | Neutral habits | 5 | 0.06% | Ignore by default | 4.40 | 2016-02-22 → 2023-04-26 ; REQ_DAY_VIEW | ~ | Single-day view | 5 | 0.06% | Ignore by default | 4.00 | 2012-12-13 → 2022-01-06 — plus 23 codes under 5 (REQ_TRIAL 4, REQ_SHARE 4, REQ_SCORE 4, REQ_PASSCODE 3, REQ_ICONS 3, REQ_CUSTOM 3, REQ_ANDROID 3, REQ_WEEK_START 2, REQ_OS_UPDATE 2, REQ_ONE_HABIT 2, REQ_LIBRARY 2, REQ_FONT 2, REQ_TIERED_PRICE 1, REQ_TAG_FILTER 1, REQ_SUBSCRIPTION 1, REQ_SKIP_LIMIT 1, REQ_ROLLING_VIEW 1, REQ_PRINT 1, REQ_GEO 1, REQ_COLORBLIND 1, REQ_BULK_NOTE 1, REQ_AUTO_NO 1, REQ_ALTERNATIVES 1).

- **Where:** §3.6 table (verbatim); §3.6 tail
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** U_REQ_ANY 1080 (13.91%); REQ_STATS 72; REQ_THEMES 54; REQ_REMINDER_PER_ITEM 51; REQ_CATEGORIES 37; REQ_CALENDAR 29; REQ_GOALS 25; REQ_SOCIAL 23; REQ_DATE_RANGE 22; REQ_STREAKS 21; REQ_NOTES 21; REQ_BACKUP 21; REQ_REORDER 16; REQ_GAMIFY 16; REQ_LAYOUT 14; REQ_INTEGRATION 14; REQ_EXPORT 14
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C011 Weekly / monthly / yearly reports; C045 Grouping / folders / categories / tags; C046 Shortcuts / Siri / URL scheme / API; C080 Colour themes / dark mode; C202 A light social layer that is explicitly not a social network

### R76-056 — Per-habit reminders were requested for eight years then shipped: REQ_REMINDER_PER_ITEM 51 (0.66%, mean 4.00★, 2011-04-27 → 2019-03-15), zero after 2019; REQ_REMINDER_REPEAT 9, REQ_REMINDER_SCHEDULE 8, REQ_NOTIF_ACTION 6 (complete from notification).

- **Where:** §3.6 (per-item reminders)
- **This app does:** per-item reminders shipped ~2019
- **User reaction:** complaint
- **Magnitude:** REQ_REMINDER_PER_ITEM 51 / 0.66%; REQ_NOTIF_ACTION 6
- **Direction for us:** must-have · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C008 Daily check-in and reminders are free — never paywall the reminder; C014 Multiple reminders per habit; C252 Complete a habit from the notification — an actionable reminder is part of the one-tap loop

### R76-057 — More statistics and other time ranges: REQ_STATS 72 (0.93%, 4.19★), REQ_DATE_RANGE 22, REQ_CHART_CUSTOM 8, REQ_CALENDAR 29 (calendar view, 3.93★), REQ_GOALS 25 (targets), REQ_DAY_VIEW 5.

- **Where:** §3.6 (stats/date ranges)
- **This app does:** charts exist; ranges limited
- **User reaction:** complaint
- **Magnitude:** REQ_STATS 72 / 0.93%; REQ_CALENDAR 29; REQ_GOALS 25; REQ_DATE_RANGE 22
- **Direction for us:** build-free · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C011 Weekly / monthly / yearly reports; C098 Time-unit flexibility for counters (hours → years); C108 Goals / targets

### R76-058 — Colours / dark mode requested across the whole span: REQ_THEMES 54 (0.70%, 4.22★, 2011-01-13 → 2026-04-23); PR_THEMES 14 after themes shipped 2019-07; dark mode locked behind a paid upgrade drew a 3★.

- **Where:** §3.6 (themes/dark mode)
- **This app does:** themes from 2019, some paid
- **User reaction:** complaint
- **Magnitude:** REQ_THEMES 54 / 0.70%; PR_THEMES 14; MON_BUY_ITEMS 27
- **Direction for us:** undecided · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `6734062162`
- **Canonical:** C080 Colour themes / dark mode; C261 A colour palette users can extend — more defaults, a hex picker, softer sets — because colour is the reward surface

### R76-059 — Smaller requests: groups/sections REQ_CATEGORIES 37 (0.48%), share with friends REQ_SOCIAL 23 (0.30%), integrations REQ_INTEGRATION 14, reorder/sort REQ_REORDER 16, rewards REQ_GAMIFY 16, export REQ_EXPORT 14, search/view notes REQ_NOTES_VIEW 13, another language REQ_LANG 13, auto backup REQ_AUTO_BACKUP 12, keep data of removed habits REQ_ARCHIVE 10, photos in notes REQ_PHOTO 9, landscape 9, bulk entry 9, guidance content REQ_CONTENT 8.

- **Where:** §3.6 (categories, reorder, social, integrations)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** see counts; all Weak
- **Direction for us:** research · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C020 Data export / backup / CSV; C027 Localise early — it unlocks revenue; C045 Grouping / folders / categories / tags; C046 Shortcuts / Siri / URL scheme / API; C050 One-off to-dos alongside habits; C073 Manual reordering, renaming and editing of habits/tasks — free; C099 Countdown / 'days until' mode; C101 Milestones, achievements, celebration; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size; C173 Sub-tasks / sub-routines nested inside a habit or routine; C202 A light social layer that is explicitly not a social network; C205 Aggregated, searchable journal / diary across days; C208 Photo / media / URL attached to a habit, memo or diary entry; C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot

### R76-108 — §8.4 experiment — flexible frequency without losing the grid: let a journal be scheduled on weekdays or N times per week, non-scheduled days rendered neutral and excluded from percentages — hypothesis: converts the most common 4★ reason into 5★ and reduces skip-as-workaround (U_FLEX_REQ 347; REQ_FREQUENCY 96 of 4★); measure star rating of adopters and skip usage; test an optional count per day as a separate journal type, keeping yes/no default (REQ_COUNT 129; NEG_YESNO 36); guard against the bloat users reject (PR_KEEP_SIMPLE 64).

- **Where:** §8.4 #1; §8.4 #2; part 8 #4
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** U_FLEX_REQ 347; REQ_FREQUENCY 96 of 1,281 4★; REQ_COUNT 129; NEG_YESNO 36
- **Direction for us:** must-have · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Conditions:** keep yes/no as the default; add scheduling and counts without bloat
- **Review IDs:** `1705374517`, `2382746040`, `1489797918`
- **Canonical:** C043 Flexible / custom frequency; C048 Flexible units / partial progress; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which; C265 Tracker types beyond yes/no — numeric target, rolling average and project milestones — as the reason people switch from binary habit apps

### R76-109 — §8.5 experiment — sync and a second device: ship iCloud sync to iPad before a Watch app — hypothesis: sync is the paid feature reviewers say they would pay for (REQ_SYNC 139; 'at this point I would pay to sync'), and iPad is the second device most named (REQ_IPAD 123).

- **Where:** §8.5; part 8 #5
- **This app does:** absent
- **User reaction:** purchase-driver
- **Magnitude:** REQ_SYNC 139; REQ_IPAD 123; REQ_WATCH 54
- **Direction for us:** build-paid · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Conditions:** iPad before Watch
- **Review IDs:** `13872213199`, `7628237879`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C022 Apple Watch app (done properly: timer, two-way sync); C141 Native iPad layout

## Monetization

### R76-006 — The one-time unlock: praised as fair by buyers, resisted at $4.99 by non-buyers — premium was a one-time purchase ('$4.99', '30块' in China) over a free version limited to three items; MON_VALUE 342 (4.40%, mean 4.90★, 2011-06-24 → 2026-06-20, Very strong): 'it is a one time charge and it unlocks the full capabilities of the app' (4★); U_PRICE_OBJECTION 579 (7.46%, mean 3.58★, High-priority) led by MON_PRICE 306 (3.94%) and MON_FREE_LIMIT 250 (3.22%); the objection peaked when the app was young and the free tier had ads — MON_PRICE 6.7% of E2 and 6.5% of E3 vs 1.6% of E5.

- **Where:** §0.3; §3.3; §5.2
- **This app does:** paid one-time unlock $4.99 (later $7) for unlimited items; free = 3 items
- **User reaction:** mixed
- **Magnitude:** MON_VALUE 342 / 4.40% / mean 4.90; U_PRICE_OBJECTION 579 / 7.46% / mean 3.58; MON_PRICE 306 / 3.94%; MON_FREE_LIMIT 250 / 3.22%; MON_PRICE 6.7% E2, 6.5% E3, 1.6% E5
- **Direction for us:** build-paid · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Conditions:** objection rate fell as the app matured and ads left the free tier
- **Review IDs:** `1397593168`, `631326858`, `430397979`, `704025459`, `773266098`, `927494488`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C064 Price level — where 'fair' turns into 'too expensive'; C082 Ads in the free tier

### R76-028 — Listing marks two features '(*) requires premium' — unlimited items and backup to cloud; release notes for 4.3.0: 'Backup & Restore is now free for all users'. Free / paid classification (verbatim): Capability or offer | Classification | Basis ; Grid, charts, notes, reminders, chains for up to 3 items | Free | listing; PR_FREE 249; "I actually think three habits is enough" (#6073, 5995182767, se, 5★) ; Unlimited items | Paid — one-time purchase in most of the corpus ("$4.99", "30块", later $7); subscription reviewed from 2023 ($30/year, £30/year, a monthly option) | listing; MON_PAID 349; MON_SUBSCRIPTION 40; §9.G ; Ads in the free version, removed on purchase | Free tier with ads in the early years; ads gone from the free version by 2018; a 2020-01 bundle promotion shown to paying users | NEG_ADS 54 (2011-11-20 → 2020-01-15); "Now without ads even in free version" (#5335, 3004389251, ru, 5★); "Ads now constantly appear in paid version" (#5881, 5387293660, us, 4★) ; Extra themes | Mixed — some free, some sold | MON_BUY_ITEMS 27; PR_THEMES 14; "this app keeps its dark mode theme locked behind a paid upgrade" (#6252, 6734062162, us, 3★) ; Tip jar | Optional payment, from 2018 | MON_TIP 15 (2018-11-29 → 2026-04-25) ; Backup to cloud | Premium in the listing; Backup & Restore free from 4.3.0 (external) | PR_BACKUP 29; NEG_BACKUP_MANUAL 13 ; Trial | Free trial on the subscription (E6) | "My trial ends Saturday" (#6910, 10469255765, us, 2★) ; Lifetime purchase honoured after the subscription switch | Unclear — some grandfathered, others asked to pay again | BUG_PURCHASE 14 in E6; #7420 vs #7572

- **Where:** §2.2 bullets (listing gates); §2.3 table (verbatim)
- **This app does:** free: grid, charts, notes, reminders, chains for 3 items; paid: unlimited items (one-time $4.99 / 30块 / later $7; subscription from 2023 at $30/year, £30/year, monthly); ads in early free tier gone by 2018; themes mixed; tip jar from 2018; cloud backup premium until 4.3.0; trial on subscription
- **User reaction:** mixed
- **Magnitude:** MON_PAID 349; MON_SUBSCRIPTION 40; NEG_ADS 54 (2011-11-20 → 2020-01-15); MON_BUY_ITEMS 27; MON_TIP 15 (2018-11-29 → 2026-04-25); BUG_PURCHASE 14 in E6
- **Direction for us:** undecided · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `5995182767`, `3004389251`, `5387293660`, `6734062162`, `10469255765`, `13764730892`, `13889612885`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C063 Free trial before purchase; C082 Ads in the free tier; C097 A tip / donate option; C153 Automatic cloud backup on by default — never manual opt-in

### R76-031 — Tip jar (optional payment from 2018): MON_TIP 15, 2018-11-29 → 2026-04-25.

- **Where:** §2.3 (tip jar row)
- **This app does:** tip jar
- **User reaction:** praise
- **Magnitude:** MON_TIP 15
- **Direction for us:** research · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C097 A tip / donate option

### R76-043 — Monetization codes (verbatim): Code | Dir | Meaning | n | % of 7,764 | Band | Mean ★ | Dates ; MON_PAID | ~ | States a purchase | 349 | 4.50% | Very strong signal | 4.29 | 2011-04-29 → 2026-04-25 ; MON_VALUE | + | Worth the money | 342 | 4.40% | Very strong signal | 4.90 | 2011-06-24 → 2026-06-20 ; MON_PRICE | - | Too expensive | 306 | 3.94% | Very strong signal | 3.71 | 2011-06-04 → 2026-05-07 ; MON_FREE_LIMIT | - | Free limit (3 items) too low | 250 | 3.22% | Very strong signal | 3.53 | 2011-05-21 → 2026-07-14 ; MON_INTENT | ~ | Intends to buy | 93 | 1.20% | Meaningful signal | 4.65 | 2011-11-29 → 2026-04-15 ; MON_WONT_PAY | - | Won't pay | 55 | 0.71% | Emerging signal | 3.53 | 2011-06-15 → 2026-07-14 ; MON_SUBSCRIPTION | - | Subscription model objection | 40 | 0.52% | Emerging signal | 2.70 | 2023-05-19 → 2026-06-08 ; MON_DISCLOSURE | - | Price or limit not clear upfront | 33 | 0.43% | Weak signal | 2.06 | 2012-06-11 → 2026-03-03 ; MON_BUY_ITEMS | ~ | Paid add-ons / themes | 27 | 0.35% | Weak signal | 4.44 | 2011-04-29 → 2023-01-05 ; MON_PAYWALL | - | Features behind paywall | 22 | 0.28% | Weak signal | 2.68 | 2013-02-17 → 2022-06-19 ; MON_REGRET | - | Regrets buying | 21 | 0.27% | Weak signal | 1.52 | 2013-07-18 → 2025-03-02 ; MON_TIP | ~ | Tip jar | 15 | 0.19% | Weak signal | 4.60 | 2018-11-29 → 2026-04-25 ; MON_UPSELL | - | Upsell nags | 13 | 0.17% | Weak signal | 2.85 | 2014-05-31 → 2023-04-06 ; MON_QUESTION | ~ | Asks how something works | 13 | 0.17% | Weak signal | 4.23 | 2015-02-01 → 2026-04-25 ; MON_REFUND | - | Refund / cancel charge | 9 | 0.12% | Weak signal | 1.89 | 2015-11-14 → 2025-09-11 ; MON_PRICE_MISMATCH | - | Paid but missing features | 9 | 0.12% | Weak signal | 2.56 | 2014-01-21 → 2020-02-12 ; MON_SALE | ~ | Discount | 3 | 0.04% | Ignore by default | 5.00 | 2020-05-26 → 2021-03-01 ; MON_PAID_TWICE | - | Had to pay again | 3 | 0.04% | Ignore by default | 3.00 | 2013-01-31 → 2017-04-06 ; MON_FAMILY_SHARING | ~ | Family sharing / gifting | 3 | 0.04% | Ignore by default | 3.67 | 2015-01-11 → 2025-05-06 ; MON_FREE_CUT | - | Free version reduced | 2 | 0.03% | Ignore by default | 3.00 | 2011-11-11 → 2016-05-10 — ads in the free version were the main 2013–2016 irritant and briefly appeared for paying users after the 2015-11 update ('Ads when already paid', 2★); paying twice across devices or accounts reported 3 times ('you have to pay for each iPhone or iPad you use', 1★).

- **Where:** §3.3 table (verbatim); §3.3
- **This app does:** one-time unlock → subscription; ads early; tip jar; paid themes
- **User reaction:** mixed
- **Magnitude:** MON_PAID 349 (4.50%); MON_VALUE 342 (4.90); MON_PRICE 306 (3.71); MON_FREE_LIMIT 250 (3.53); MON_INTENT 93; MON_WONT_PAY 55; MON_SUBSCRIPTION 40 (2.70); MON_DISCLOSURE 33 (2.06); MON_BUY_ITEMS 27; MON_PAYWALL 22 (2.68); MON_REGRET 21 (1.52); MON_TIP 15; MON_UPSELL 13; MON_REFUND 9 (1.89); MON_PRICE_MISMATCH 9; MON_PAID_TWICE 3; MON_FAMILY_SHARING 3; MON_FREE_CUT 2
- **Direction for us:** undecided · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `1289364973`, `741004355`
- **Canonical:** C001 Never move a free feature behind the paywall; C064 Price level — where 'fair' turns into 'too expensive'; C065 Paying customers are the highest 1★ risk — every paid feature must work; C082 Ads in the free tier; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps

### R76-044 — Regret after buying is the lowest-rated money code: MON_REGRET 21 (0.27%, mean 1.52★, 2013-07-18 → 2025-03-02); MON_REFUND 9 (mean 1.89★); MON_PRICE_MISMATCH 9 'paid but missing features' (2.56★).

- **Where:** §3.3 (regret)
- **This app does:** one-time purchase
- **User reaction:** churn
- **Magnitude:** MON_REGRET 21 / 1.52; MON_REFUND 9 / 1.89; MON_PRICE_MISMATCH 9 / 2.56
- **Direction for us:** none · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `1289364973`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R76-074 — What purchasers report: 294 of 349 (84.2%) rate 4–5★; 40 (11.5%) 1–2★; satisfied buyers name value and permanence; dissatisfied buyers a purchase that did not unlock, was lost, or was not enough (verbatim): Code | Dir | Meaning | n | % of 7,764 | Band | Mean ★ | Dates ; MON_PAID | ~ | States a purchase | 349 | 4.50% | Very strong signal | 4.29 | 2011-04-29 → 2026-04-25 ; MON_VALUE | + | Worth the money | 342 | 4.40% | Very strong signal | 4.90 | 2011-06-24 → 2026-06-20 ; MON_REGRET | - | Regrets buying | 21 | 0.27% | Weak signal | 1.52 | 2013-07-18 → 2025-03-02 ; MON_PRICE_MISMATCH | - | Paid but missing features | 9 | 0.12% | Weak signal | 2.56 | 2014-01-21 → 2020-02-12 ; BUG_PURCHASE | - | Purchase not restored / not credited | 54 | 0.70% | Emerging signal | 2.69 | 2011-12-11 → 2026-06-18 ; MON_PAID_TWICE | - | Had to pay again | 3 | 0.04% | Ignore by default | 3.00 | 2013-01-31 → 2017-04-06 ; MON_REFUND | - | Refund / cancel charge | 9 | 0.12% | Weak signal | 1.89 | 2015-11-14 → 2025-09-11 ; MON_SUBSCRIPTION | - | Subscription model objection | 40 | 0.52% | Emerging signal | 2.70 | 2023-05-19 → 2026-06-08 ; MON_TIP | ~ | Tip jar | 15 | 0.19% | Weak signal | 4.60 | 2018-11-29 → 2026-04-25 ; MON_BUY_ITEMS | ~ | Paid add-ons / themes | 27 | 0.35% | Weak signal | 4.44 | 2011-04-29 → 2023-01-05 — 'money were taken but nothing had changed' (ru 1★); 'es gebe nichts zum wiederherstellen' (there was nothing to restore, de 1★); 'features missing that I would expect to see in a paid app' (fr 3★); 'Ich würde die 5€ nicht nochmal für die App bezahlen' (de 2★).

- **Where:** §5.4 table (verbatim); §5.4 bullets
- **This app does:** one-time unlock
- **User reaction:** mixed
- **Magnitude:** 84.2% of purchasers 4–5★; 11.5% 1–2★; MON_VALUE 342 / 4.90; MON_REGRET 21 / 1.52
- **Direction for us:** none · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Review IDs:** `1553833734`, `13364421716`, `1505307158`, `1481286486`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C077 Purchase and signup flow must not leak buyers

### R76-075 — Upgrade barriers among non-buyers (verbatim): Code | Dir | Meaning | n | % of 7,764 | Band | Mean ★ | Dates ; MON_PRICE | - | Too expensive | 306 | 3.94% | Very strong signal | 3.71 | 2011-06-04 → 2026-05-07 ; MON_FREE_LIMIT | - | Free limit (3 items) too low | 250 | 3.22% | Very strong signal | 3.53 | 2011-05-21 → 2026-07-14 ; MON_WONT_PAY | - | Won't pay | 55 | 0.71% | Emerging signal | 3.53 | 2011-06-15 → 2026-07-14 ; MON_PAYWALL | - | Features behind paywall | 22 | 0.28% | Weak signal | 2.68 | 2013-02-17 → 2022-06-19 ; MON_DISCLOSURE | - | Price or limit not clear upfront | 33 | 0.43% | Weak signal | 2.06 | 2012-06-11 → 2026-03-03 ; MON_UPSELL | - | Upsell nags | 13 | 0.17% | Weak signal | 2.85 | 2014-05-31 → 2023-04-06 ; MON_SUBSCRIPTION | - | Subscription model objection | 40 | 0.52% | Emerging signal | 2.70 | 2023-05-19 → 2026-06-08 ; MON_FREE_CUT | - | Free version reduced | 2 | 0.03% | Ignore by default | 3.00 | 2011-11-11 → 2016-05-10 ; REQ_TRIAL | ~ | Trial | 4 | 0.05% | Ignore by default | 1.75 | 2013-12-30 → 2020-08-29 ; REQ_TIERED_PRICE | ~ | Tiered pricing | 1 | 0.01% | Ignore by default | 4.00 | 2016-03-03 → 2016-03-03 ; MON_INTENT | ~ | Intends to buy | 93 | 1.20% | Meaningful signal | 4.65 | 2011-11-29 → 2026-04-15 — three items is too few to evaluate ('только купив поймете нужно ли оно вам' — only by buying will you know if you need it, ua 2★; 'This is not a Free app with in-app purchases. This is a $7 app', 1★); three items is a feature for some ('forced me to prioritize the three most important tasks by paywalling more than 3', 5★); a price they would pay ('gladly pay .99 for an extra goal', 4★; 'Купил бы полную версию если бы стоило хотя бы 200р' — would buy at 200 roubles, ru 5★); subscription refusal ('I'm not paying a yearly subscription', 3★; 'happy to pay up to £50 even for lifetime access', gb 3★); discount timing ('only offer a reduced price in the first days after installation', br 5★).

- **Where:** §5.5 table (verbatim); §5.5 bullets
- **This app does:** 3-item cap; one-time then subscription
- **User reaction:** blocked-conversion
- **Magnitude:** MON_PRICE 306; MON_FREE_LIMIT 250; MON_WONT_PAY 55; MON_PAYWALL 22; MON_DISCLOSURE 33; MON_UPSELL 13; MON_SUBSCRIPTION 40; REQ_TRIAL 4 (1.75★); REQ_TIERED_PRICE 1; MON_INTENT 93
- **Direction for us:** undecided · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Review IDs:** `6252563047`, `7749376108`, `10969791376`, `1342032100`, `6767712579`, `13656328254`, `13795648107`, `7054076524`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C064 Price level — where 'fair' turns into 'too expensive'; C093 No upsell nagging without a 'never ask again' option; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C113 One stable, disclosed price — no discount wheels; C147 Let people use the product before they pay

### R76-078 — Prices users volunteer: 'gladly pay .99 for an extra goal' (4★) — a per-item micro-purchase; 'would buy the full version if it cost at least 200 roubles' (ru 5★); China 12 yuan; 'happy to pay up to £50 even for lifetime access' (gb 3★) — lifetime demand persists in the subscription era.

- **Where:** §5.5 (per-item micro-price; regional price)
- **This app does:** one-time $4.99 / $7; later $30/yr
- **User reaction:** blocked-conversion
- **Magnitude:** stated willingness: $0.99/item, 200 RUB, 12 CNY, £50 lifetime
- **Direction for us:** research · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `1342032100`, `6767712579`, `795518082`, `13795648107`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C025 Scholarship / hardship / discount program; C064 Price level — where 'fair' turns into 'too expensive'

### R76-080 — Subscription refusal with a lifetime alternative wanted: 'I'm not paying a yearly subscription' (us 3★); 'happy to pay up to £50 even for lifetime access' (gb 3★); REQ_SUBSCRIPTION 1 the other way; §8.6 experiment: a lifetime price alongside the subscription.

- **Where:** §5.5 (subscription refusal); §8.6
- **This app does:** subscription only (E6)
- **User reaction:** blocked-conversion
- **Magnitude:** MON_SUBSCRIPTION 40 / 2.70; MON_WONT_PAY 55
- **Direction for us:** build-paid · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `13656328254`, `13795648107`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

### R76-081 — Refund and churn after purchase: MON_REFUND 9 (0.12%, mean 1.89★, 2015-11-14 → 2025-09-11) — drivers: a purchase that did not work (BUG_PURCHASE), an unexpected subscription charge (MON_SUBSCRIPTION + MON_DISCLOSURE), or a product that did not meet the price ('got my money back', ch 1★); among purchasers U_CHURN is 3 (0.9%).

- **Where:** §5.6
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** MON_REFUND 9 / 1.89; purchaser churn 3 of 349 (0.9%)
- **Direction for us:** must-never-break · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `1557935950`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R76-110 — §8.6 experiment — a lifetime price alongside the subscription at a published price — hypothesis: recovers buyers who state a lifetime amount they would pay (#7539 'up to £50') without reducing subscription revenue from those who accept it (#7590); measure purchase mix and 1★ share among new users.

- **Where:** §8.6; part 8 #6
- **This app does:** subscription only in E6
- **User reaction:** blocked-conversion
- **Magnitude:** MON_SUBSCRIPTION 40; stated lifetime willingness £50
- **Direction for us:** build-paid · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `13795648107`, `13980873344`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

## Tactics the app used

### R76-062 — Press and podcasts are the named acquisition source: MKT_PRESS 51 (0.66%, mean 4.94★, 2014-01-13 → 2026-02-23), 26 in E4 — mainly Tim Ferriss's podcast with Kevin Rose and Ezra Klein's show ('Tim Ferriss Show podcast from Kevin Rose'; 'Thanks for the rec, Ezra Klein'), later Atomic Habits, and in Russia/Kazakhstan Margulan Seisembay ('Спасибо Маргулану Сейсембаю', ru 5★); the listing cites the same press; MKT_WOM 28 (4.82★); MKT_REVIEWS 2; MKT_SEARCH 1.

- **Where:** §3.7 (press); §2.2 bullet (press)
- **This app does:** earned press mentions; listing cites them
- **User reaction:** purchase-driver
- **Magnitude:** MKT_PRESS 51 / 0.66% / 4.94, 26 in E4; MKT_WOM 28
- **Direction for us:** do · **Report confidence:** Emerging · **Generalisable:** app-specific
- **Side effects:** a single podcast mention shows up for years in reviews
- **Conditions:** influencer-driven acquisition in ru/kz via a local figure
- **Review IDs:** `1312703881`, `1353940535`, `5583547111`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C070 Use the language users use: Atomic Habits, 75 Hard; C134 Lead the store listing with what users actually love; C225 A one-off free promotion (App of the Week, partner promo) acquires durable users

### R76-071 — A tip jar (from 2018-11) draws voluntary payment from grateful long-term users: MON_TIP 15 (mean 4.60★) — 'jumped at the chance to tip the developers' (#5508, au, 5★); 'Supporting the developer' is a named purchase trigger.

- **Where:** §5.2 #5; §2.3 tip jar row
- **This app does:** tip jar alongside the unlock
- **User reaction:** purchase-driver
- **Magnitude:** MON_TIP 15 / 0.19% / 4.60, 2018-11-29 → 2026-04-25
- **Direction for us:** do · **Report confidence:** Weak · **Generalisable:** generalisable
- **Conditions:** works where the developer is personally known to users
- **Review IDs:** `3520578395`
- **Canonical:** C097 A tip / donate option

## Insights (the why)

### R76-003 — Simplicity is the product, and long-term users say so explicitly: U_PRAISE_ANY 6357 (81.88%, mean 4.80★); U_SIMPLICITY 1682 (21.66%) — PR_SIMPLE 1532 (19.73%), PR_EASY 1359 (17.50%), PR_FAST 197 (2.54%); at-a-glance picture PR_INSIGHTS 838 (10.79%); the mechanism — a grid of green/red/grey cells, three states (yes, no, skip), good or bad habits — is what users say other trackers lack: PR_BETTER_THAN 428 (5.51%), PR_YESNO 73 (0.94%), PR_SKIP 99 (1.28%). 'I've possibly tried every habit app, and keep coming back to this one' (#6339, the most-voted review, 20 votes, 2021); 'Product Managers should study this app'; 'nämlich drei Optionen anzubieten: erledigt, nicht erledigt, übersprungen'.

- **Where:** §0.1; §3.2 (simplicity)
- **This app does:** free, core mechanic
- **User reaction:** praise
- **Magnitude:** U_PRAISE_ANY 6357 / 81.88% / mean 4.80; U_SIMPLICITY 1682 / 21.66%; PR_BETTER_THAN 428 / 5.51%; PR_YESNO 73; PR_SKIP 99; High-priority
- **Direction for us:** build-free · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `7243490138`, `13769488285`, `13775690190`, `371487225`, `706035312`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C012 Week / month / year grid views; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R76-013 — Fast fixes turn regression reviewers around: PR_SUPPORT 68 and REV_UPDATED 74 include several who returned to raise their stars — 'Has been fixed - good response' (#992, us, 5★).

- **Where:** §0.6 (fast fixes); §3.8
- **This app does:** fixes crashes quickly (in some eras)
- **User reaction:** praise
- **Magnitude:** PR_SUPPORT 68; REV_UPDATED 74
- **Direction for us:** do · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `719847792`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R76-030 — Three free items is enough for some: 'I actually think three habits is enough' (#6073, se, 5★); PR_FREE 249 praise the free tier.

- **Where:** §2.3 (free tier row)
- **This app does:** 3-item free tier
- **User reaction:** praise
- **Magnitude:** PR_FREE 249
- **Direction for us:** build-free · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `5995182767`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C061 Goodwill conversion — a generous free tier and 'support the devs'; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R76-035 — What users value (verbatim): Code | Dir | Meaning | n | % of 7,764 | Band | Mean ★ | Dates ; PR_SIMPLE | + | Simple / minimal | 1532 | 19.73% | High-priority signal | 4.83 | 2010-11-21 → 2026-09-02 ; PR_EASY | + | Easy / intuitive | 1359 | 17.50% | High-priority signal | 4.82 | 2011-01-23 → 2026-08-16 ; PR_GENERIC | + | General praise | 1105 | 14.23% | High-priority signal | 4.79 | 2011-03-07 → 2026-06-13 ; PR_INSIGHTS | + | Charts, trends, overview | 838 | 10.79% | High-priority signal | 4.80 | 2011-01-13 → 2026-05-29 ; PR_DESIGN | + | Design and interface | 602 | 7.75% | High-priority signal | 4.78 | 2010-11-21 → 2026-08-09 ; PR_BEST | + | Best / favourite | 548 | 7.06% | High-priority signal | 4.91 | 2010-12-07 → 2026-09-06 ; PR_MOTIVATION | + | Motivating | 509 | 6.56% | High-priority signal | 4.85 | 2010-11-21 → 2026-08-17 ; PR_RECOMMEND | + | Recommends it | 503 | 6.48% | High-priority signal | 4.94 | 2011-04-29 → 2026-09-02 ; PR_ACCOUNTABILITY | + | Accountability and discipline | 477 | 6.14% | High-priority signal | 4.86 | 2010-11-08 → 2026-09-02 ; PR_BETTER_THAN | + | Better than alternatives | 428 | 5.51% | High-priority signal | 4.86 | 2010-12-07 → 2026-08-17 ; PR_TRACKING | + | Habit tracking | 362 | 4.66% | Very strong signal | 4.81 | 2010-11-28 → 2026-06-05 ; PR_REMINDERS | + | Reminders | 351 | 4.52% | Very strong signal | 4.83 | 2011-06-04 → 2026-06-01 ; PR_STICKY | + | Daily use / indispensable | 325 | 4.19% | Very strong signal | 4.89 | 2011-06-30 → 2026-07-24 ; PR_DEV | + | Thanks the developer | 268 | 3.45% | Very strong signal | 4.96 | 2011-01-13 → 2026-06-04 ; PR_UPDATE | + | Updates improve it | 255 | 3.28% | Very strong signal | 4.91 | 2012-05-17 → 2026-08-01 ; PR_FREE | + | Free version is enough | 249 | 3.21% | Very strong signal | 4.72 | 2011-05-23 → 2026-08-06 ; PR_CUSTOM | + | Flexible / customisable | 206 | 2.65% | Meaningful signal | 4.86 | 2011-07-16 → 2026-08-01 ; PR_FAST | + | Quick to log | 197 | 2.54% | Meaningful signal | 4.81 | 2011-04-29 → 2026-07-25 ; PR_PERF | + | Reliable / works | 185 | 2.38% | Meaningful signal | 4.83 | 2012-01-05 → 2026-05-29 ; PR_NOTES | + | Notes / journal | 174 | 2.24% | Meaningful signal | 4.86 | 2012-05-18 → 2026-05-07 ; PR_CHAINS | + | Chains and streaks | 129 | 1.66% | Meaningful signal | 4.89 | 2012-06-20 → 2026-04-27 ; PR_SKIP | + | Skip days | 99 | 1.28% | Meaningful signal | 4.66 | 2012-05-18 → 2026-02-22 ; PR_YESNO | + | Good and bad habits, yes/no | 73 | 0.94% | Emerging signal | 4.84 | 2011-09-14 → 2026-04-26 ; PR_SUPPORT | + | Support responsive | 68 | 0.88% | Emerging signal | 4.79 | 2011-01-23 → 2026-03-23 ; PR_KEEP_SIMPLE | + | No bloat — keep it this way | 64 | 0.82% | Emerging signal | 4.98 | 2011-11-09 → 2026-05-29 ; PR_CONCEPT | + | Good concept | 62 | 0.80% | Emerging signal | 4.16 | 2011-11-10 → 2024-02-29 ; PR_ALLINONE | + | Has everything needed | 60 | 0.77% | Emerging signal | 4.88 | 2011-05-27 → 2026-04-22 ; PR_EXPORT | + | Export | 50 | 0.64% | Emerging signal | 4.84 | 2011-12-24 → 2026-02-20 ; PR_ONBOARDING | + | Tutorial / walkthrough | 48 | 0.62% | Emerging signal | 4.79 | 2011-07-05 → 2025-06-11 ; PR_TAGS | + | Tags / categories | 35 | 0.45% | Weak signal | 4.77 | 2014-06-01 → 2025-06-07 ; PR_BACKUP | + | Backup | 29 | 0.37% | Weak signal | 4.76 | 2012-10-05 → 2026-04-23 ; PR_GRACE | + | Non-judgemental | 17 | 0.22% | Weak signal | 4.82 | 2011-11-30 → 2016-06-02 ; PR_THEMES | + | Themes | 14 | 0.18% | Weak signal | 4.86 | 2019-07-03 → 2026-06-08 ; PR_ARCHIVE | + | Archive / pause habits | 14 | 0.18% | Weak signal | 4.93 | 2014-05-29 → 2026-04-22 ; PR_PRIVACY | + | Local data, no account | 12 | 0.15% | Weak signal | 4.92 | 2013-03-04 → 2018-12-20 ; PR_LIBRARY | + | Suggested habits | 11 | 0.14% | Weak signal | 4.82 | 2013-01-25 → 2026-02-21 ; PR_BACKFILL | + | Can fill in past days | 8 | 0.10% | Weak signal | 5.00 | 2016-09-30 → 2025-06-03 ; PR_PASSCODE | + | Passcode / privacy lock | 7 | 0.09% | Ignore by default | 5.00 | 2013-12-06 → 2026-02-22 ; PR_LANG | + | Localisation | 7 | 0.09% | Ignore by default | 4.43 | 2012-10-05 → 2022-10-30 ; PR_WEEK_START | + | Week start setting | 1 | 0.01% | Ignore by default | 4.00 | 2016-02-11 → 2016-02-11 ; PR_PRIVACY_CONCERN | ~ | Hopes privacy is respected | 1 | 0.01% | Ignore by default | 5.00 | 2016-05-11 → 2016-05-11 — why it works: logging costs seconds so it survives ('almost 9 years since my last review and 13 since the first'; 'I track 30+ items in under 2 minutes'); honesty through colour ('keeps me from fooling myself into thinking I did better than I really did'; 'I hate to break a winning steak'); good and bad habits in one grid ('it reverses the red/green colours for yes and no'); skip without guilt ('skip option for when you have days where you need to skip without breaking your chain'); chains from 2015-11 (PR_CHAINS 129, 56 in E4: 'Chains is going to change my life'); the developer (PR_DEV 268, 3.45%, rising 2.1% E1 → 6.7% E6, named and thanked for a decade of maintenance: 'Through steady updates, this continues to be the best habit/task tracking app').

- **Where:** §3.2 table (verbatim); §3.2 bullets
- **This app does:** free core loop
- **User reaction:** praise
- **Magnitude:** 41 praise codes; PR_STICKY 325 (4.19%); PR_BEST 548 (7.06%); PR_RECOMMEND 503 (6.48%); PR_UPDATE 255 (3.28%); PR_DEV 2.1% E1 → 6.7% E6
- **Direction for us:** build-free · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `10961979664`, `1618497915`, `1501749022`, `6656271875`, `2033057159`, `1430830624`, `1290249480`, `4420297480`
- **Canonical:** C012 Week / month / year grid views; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C019 Quit-habit / bad-habit mode; C024 Streaks / gamification; C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R76-036 — Honesty through colour is the motivator — the red cell, not a reward: 'keeps me from fooling myself into thinking I did better than I really did' (5★); 'I hate to break a winning steak' (gb 5★); PR_ACCOUNTABILITY 477 (6.14%, mean 4.86★).

- **Where:** §3.2 (red cell honesty)
- **This app does:** shows 'no' days in red on a grid
- **User reaction:** praise
- **Magnitude:** PR_ACCOUNTABILITY 477 / 6.14% / 4.86; PR_MOTIVATION 509 / 6.56%
- **Direction for us:** build-free · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `1501749022`, `6656271875`
- **Canonical:** C012 Week / month / year grid views; C024 Streaks / gamification; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R76-039 — A named, thanked solo developer is part of the product: PR_DEV 268 (3.45%, mean 4.96★) rising 2.1% E1 → 6.7% E6; PR_UPDATE 255 (3.28%: 'Updates improve it'); 'I think they are just one person, so be patient' (5★); 'Through steady updates, this continues to be the best habit/task tracking app out there for me'.

- **Where:** §3.2 (developer); §3.8
- **This app does:** one developer maintaining for 16 years
- **User reaction:** praise
- **Magnitude:** PR_DEV 268 / 3.45% / 4.96; PR_UPDATE 255 / 3.28% / 4.91
- **Direction for us:** do · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Review IDs:** `4420297480`, `8458663871`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C196 A subscription is a promise of continued delivery — back it with a visible cadence; C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal

### R76-049 — Product negatives (verbatim): Code | Dir | Meaning | n | % of 7,764 | Band | Mean ★ | Dates ; NEG_UI_CONFUSING | - | Confusing / hard to use | 81 | 1.04% | Meaningful signal | 3.36 | 2012-05-02 → 2026-04-22 ; NEG_DESIGN | - | Dated or ugly design | 70 | 0.90% | Emerging signal | 3.74 | 2011-01-23 → 2023-05-21 ; NEG_ADS | - | Ads | 54 | 0.70% | Emerging signal | 3.06 | 2011-11-20 → 2020-01-15 ; NEG_SIMPLE | - | Too basic | 43 | 0.55% | Emerging signal | 2.98 | 2012-03-02 → 2025-03-02 ; NEG_BACKFILL | - | Hard to log past days | 39 | 0.50% | Emerging signal | 3.79 | 2012-03-02 → 2024-03-23 ; NEG_CHART | - | Stats limited or misleading | 38 | 0.49% | Weak signal | 3.58 | 2011-12-10 → 2024-02-12 ; NEG_YESNO | - | Yes/no too binary | 36 | 0.46% | Weak signal | 3.86 | 2011-12-03 → 2026-02-14 ; NEG_GENERIC | - | General negative | 26 | 0.33% | Weak signal | 3.35 | 2012-05-22 → 2025-12-12 ; NEG_SLOW_DEV | - | Not updated / slow development | 20 | 0.26% | Weak signal | 3.50 | 2012-09-02 → 2026-02-08 ; NEG_DROPBOX_BLOCKED | - | Dropbox backup unusable in China | 18 | 0.23% | Weak signal | 4.00 | 2014-07-18 → 2016-09-27 ; NEG_UPDATE_WORSE | - | Redesign made it worse | 17 | 0.22% | Weak signal | 3.47 | 2012-05-20 → 2026-02-22 ; NEG_LEARNING_CURVE | - | Learning curve | 17 | 0.22% | Weak signal | 4.65 | 2012-06-08 → 2022-09-18 ; NEG_POINTLESS | - | Not worth it / pointless | 15 | 0.19% | Weak signal | 2.53 | 2012-04-30 → 2022-09-02 ; NEG_FORGET | - | Forgets to log | 14 | 0.18% | Weak signal | 4.14 | 2012-09-17 → 2016-06-12 ; NEG_BADGE | - | Badge nags | 13 | 0.17% | Weak signal | 4.38 | 2012-04-23 → 2020-12-12 ; NEG_BACKUP_MANUAL | - | Backup is manual | 13 | 0.17% | Weak signal | 2.77 | 2016-02-07 → 2025-12-26 ; NEG_NOTIF | - | Notification annoyance | 11 | 0.14% | Weak signal | 2.27 | 2012-12-31 → 2019-11-23 ; NEG_LOST_FEATURE | - | Feature removed | 7 | 0.09% | Ignore by default | 2.86 | 2014-07-01 → 2025-01-30 ; NEG_ONBOARDING | - | Tutorial unwelcome | 6 | 0.08% | Ignore by default | 3.17 | 2012-11-25 → 2025-05-30 ; NEG_DEV_PROMISE | - | Promised feature never came | 6 | 0.08% | Ignore by default | 3.00 | 2013-10-20 → 2026-03-21 ; NEG_NO_DATES | - | Dates not shown | 5 | 0.06% | Ignore by default | 4.20 | 2015-02-21 → 2019-07-13 ; NEG_ARCHIVE_UX | - | Cannot find archived items | 5 | 0.06% | Ignore by default | 4.80 | 2014-06-04 → 2017-10-26 ; NEG_TWO_TAPS | - | Too many taps | 4 | 0.05% | Ignore by default | 3.75 | 2012-07-24 → 2020-06-27 ; NEG_NOTES_UX | - | Notes hard to reach | 4 | 0.05% | Ignore by default | 4.25 | 2012-08-15 → 2017-04-30 ; NEG_EXPORT_FORMAT | - | Export format poor | 4 | 0.05% | Ignore by default | 4.00 | 2012-07-02 → 2019-11-01 ; NEG_EDIT_NAME | - | Cannot edit items | 3 | 0.04% | Ignore by default | 3.33 | 2012-12-09 → 2015-11-12 ; NEG_WEEKLY_GOAL | - | Weekly goal default wrong | 2 | 0.03% | Ignore by default | 3.00 | 2016-06-01 → 2017-02-21 ; NEG_NAME | - | Name or text field issue | 2 | 0.03% | Ignore by default | 4.50 | 2011-01-13 → 2016-08-11 ; NEG_SOCIAL | - | Unwanted social sharing | 1 | 0.01% | Ignore by default | 5.00 | 2012-05-21 → 2012-05-21 ; NEG_MARKETING | - | Marketing ask | 1 | 0.01% | Ignore by default | 2.00 | 2011-06-04 → 2011-06-04 ; NEG_LIBRARY | - | Poor preset habits | 1 | 0.01% | Ignore by default | 5.00 | 2016-03-11 → 2016-03-11 ; NEG_LANG | - | Not in their language | 1 | 0.01% | Ignore by default | 4.00 | 2014-07-09 → 2014-07-09 — confusing on first use, simple once learned: NEG_UI_CONFUSING 81 and NEG_LEARNING_CURVE 17 sit beside 48 praising the tutorial ('depois do excelente porém extenso tutorial, a gente pega a manha' — after the excellent but long tutorial you get the hang of it, br 4★); too basic for some: NEG_SIMPLE 43 and NEG_POINTLESS 15 ('Ich kann das gleiche auch mit einer einfachen Strichliste machen' — I can do the same with a simple tally sheet, de 2★).

- **Where:** §3.5 table (verbatim); §3.5 bullets
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** NEG_UI_CONFUSING 81 (1.04%, 3.36); NEG_DESIGN 70 (0.90%); NEG_SIMPLE 43 (2.98); NEG_BACKFILL 39; NEG_CHART 38; NEG_YESNO 36; NEG_SLOW_DEV 20; NEG_LEARNING_CURVE 17 (4.65); NEG_POINTLESS 15; NEG_FORGET 14; NEG_BADGE 13
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `1532756806`, `1481286486`
- **Canonical:** C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in; C185 Aesthetic and a polished onboarding convert; they do not retain; C214 A bare checklist or task-slot paywall cannot carry a premium price — it is compared to Reminders, Notes, alarms and paper, free on every phone, and loses

### R76-055 — Requests that stop once shipped — a natural experiment: REQ_REMINDER_PER_ITEM (51, 2011-04-27 → 2019-03-15) disappears after 2019 consistent with per-item reminders shipping; REQ_SKIP (7) ends before skip praise begins (2012-05-18); REQ_STREAKS (21) is 18 before the 2015-11 chains release and 3 after; REQ_FREQUENCY and REQ_COUNT never stop.

- **Where:** §3.6 (requests that stop)
- **This app does:** shipped per-item reminders (2019), skip (2012), chains (2015-11); never shipped flexible frequency
- **User reaction:** mixed
- **Magnitude:** REQ_REMINDER_PER_ITEM 51 → 0 after 2019; REQ_STREAKS 18 pre / 3 post 2015-11; REQ_SKIP 7 ended 2011-11
- **Direction for us:** insight · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `1290249480`
- **Canonical:** C014 Multiple reminders per habit; C024 Streaks / gamification; C043 Flexible / custom frequency; C071 Never ship and walk away

### R76-061 — Boomerang users: CHURN_RETURN 60 (0.77%, mean 4.95★) outnumber U_CHURN 55 — people try heavier apps and come back to the simplicity; 'I've possibly tried every habit app, and keep coming back to this one' (20 votes).

- **Where:** §3.7 (return)
- **This app does:** simplicity as retention
- **User reaction:** praise
- **Magnitude:** CHURN_RETURN 60 / 0.77% / 4.95 vs U_CHURN 55 / 2.69
- **Direction for us:** insight · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `13984329659`, `7243490138`
- **Canonical:** C005 Know which competitors buyers compare against; C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R76-067 — 1★ is where purchases go wrong: among 181 1★ — MON_PAID 30 (16.57%), BUG_PURCHASE 21 (11.60%), MON_SUBSCRIPTION 15 (8.29%), MON_REGRET 13 (7.18%), MON_DISCLOSURE 14 (7.73%), SUP_NONE 11 (6.08%) — beside the free limit 34 (18.78%) and update crashes 19 (10.50%); purchasers who rate 1–2★ are 40 of 349 (11.5%).

- **Where:** §4.2 Reading (1★ composition)
- **This app does:** paid unlock; restore failures; subscription switch
- **User reaction:** 1★-burst
- **Magnitude:** 1★ n=181: money-after-purchase codes ~40%; BUG_PURCHASE lift in 1★ 11.60% vs 0.70%
- **Direction for us:** must-never-break · **Report confidence:** High-priority (segment) · **Generalisable:** generalisable
- **Review IDs:** `13889612885`, `5616625936`, `1553833734`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R76-070 — What triggers a purchase (segment rates within 349 purchasers): 1) hitting the three-item limit after the free version worked — PR_FREE 26 (7.4%), MON_BUY_ITEMS 20 (5.7%), MON_FREE_LIMIT 7: 'found myself wanting to add more and shelled out the $5'; 'bought the upgrade to have more than three lines to track' (nz 4★); 2) the charts and the grid — PR_INSIGHTS 50 (14.3%): 'This is the only app I bought the paid version for, and I regret it not at all'; 3) removing ads (to ~2018) — NEG_ADS 16 (4.6%): 'Worth the upgrade to get rid of the ads'; 4) a press recommendation — MKT_PRESS 6: 'Used for one day then upgraded to the paid'; 5) supporting the developer — MON_TIP 15: 'jumped at the chance to tip the developers' (au 5★).

- **Where:** §5.2
- **This app does:** 3-item cap → one-time unlock
- **User reaction:** purchase-driver
- **Magnitude:** PR_FREE 7.4%, PR_INSIGHTS 14.3%, NEG_ADS 4.6% of 349; MON_TIP 15; MKT_PRESS 6
- **Direction for us:** build-paid · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Side effects:** the cap converts only after the free tier has delivered value
- **Review IDs:** `1346355361`, `485881908`, `1566334421`, `670251014`, `1312703881`, `3520578395`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C012 Week / month / year grid views; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C061 Goodwill conversion — a generous free tier and 'support the devs'; C082 Ads in the free tier; C097 A tip / donate option

### R76-073 — Purchasers ask for frequency and sync more than the corpus: REQ_FREQUENCY 6.6% of purchasers (2.39×), REQ_SYNC 4.9% (2.72×) — the paid tier does not resolve the two biggest unmet needs, it unlocks more of the same.

- **Where:** §5.3 (purchasers still ask)
- **This app does:** premium = unlimited items only
- **User reaction:** complaint
- **Magnitude:** REQ_FREQUENCY 23 of 349 (2.39×); REQ_SYNC 17 of 349 (2.72×)
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** generalisable
- **Review IDs:** `1705374517`, `13872213199`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C043 Flexible / custom frequency; C133 Gate on capability, not on quantity

### R76-077 — Three items is too few to evaluate the product before paying: 'only by buying will you know if you need it' (ua 2★); 'This is not a Free app with in-app purchases. This is a $7 app' (1★); REQ_TRIAL 4 (mean 1.75★).

- **Where:** §5.5 (too few to evaluate)
- **This app does:** 3-item cap, no trial on the one-time unlock
- **User reaction:** blocked-conversion
- **Magnitude:** REQ_TRIAL 4 / 1.75; MON_DISCLOSURE 33 / 2.06
- **Direction for us:** research · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `6252563047`, `7749376108`
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R76-103 — What persisted in every era: PR_SIMPLE 17.0–22.5% (2010–2026); REQ_FREQUENCY 1.8–4.5% (2011-08-14 → 2026-06-03); REQ_SYNC 0.9–2.8% (2012-01-07 → 2026-05-07); MON_FREE_LIMIT 1.5–6.1% (2011-05-21 → 2026-07-14); REQ_COUNT 0.8–2.9% (2011-09-12 → 2026-03-24).

- **Where:** §7.5
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** five codes present in all six eras
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Conditions:** the two never-built requests persisted for 15 years
- **Review IDs:** `1705374517`, `13872213199`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C007 Generous fixed habit cap (or unlimited) — never change it; C013 Cloud sync / multi-device as the paid differentiator; C043 Flexible / custom frequency

### R76-113 — §8.9 research questions the corpus cannot answer: 1) how many lifetime buyers lost premium when the subscription launched and how many restored it; 2) what share of active users have ever lost data and on which path (update, new phone, reinstall); 3) what proportion rely on skip to emulate weekly habits and how that distorts their statistics; 4) does the three-item free tier convert better or worse than a time-limited full trial; 5) how do veterans prompted after updates differ in retention from first-month users.

- **Where:** §8.9 #1, #2, #3, #4, #5; part 8 #9
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `13889612885`, `2382746040`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C043 Flexible / custom frequency; C147 Let people use the product before they pay; C186 Never revoke what earlier buyers paid for when the model changes

## Audiences

### R76-040 — Outcomes and use contexts (verbatim): Code | Dir | Meaning | n | % of 7,764 | Band | Mean ★ | Dates ; TENURE_LONG | ~ | Long-term user | 543 | 6.99% | High-priority signal | 4.85 | 2011-01-25 → 2026-09-06 ; OUT_HABIT | + | Built or broke habits | 517 | 6.66% | High-priority signal | 4.88 | 2011-05-28 → 2026-08-29 ; OUT_LIFE | + | Changed their life | 249 | 3.21% | Very strong signal | 4.94 | 2011-05-25 → 2026-07-25 ; OUT_AWARENESS | + | Self-awareness | 181 | 2.33% | Meaningful signal | 4.80 | 2011-06-24 → 2026-02-19 ; JUST_STARTED | ~ | Just started | 164 | 2.11% | Meaningful signal | 4.63 | 2011-07-06 → 2026-09-02 ; USE_FITNESS | ~ | Exercise / meditation | 98 | 1.26% | Meaningful signal | 4.80 | 2011-11-07 → 2026-05-26 ; OUT_PRODUCTIVE | + | More productive / organised | 79 | 1.02% | Meaningful signal | 4.97 | 2012-06-06 → 2026-04-22 ; USE_HEALTH | ~ | Health, medication, sleep | 71 | 0.91% | Emerging signal | 4.89 | 2011-06-21 → 2026-04-21 ; USE_DIET | ~ | Diet | 56 | 0.72% | Emerging signal | 4.84 | 2011-06-21 → 2026-04-27 ; USE_ADDICTION | ~ | Quitting / sobriety | 46 | 0.59% | Emerging signal | 4.96 | 2011-06-24 → 2026-09-02 ; USE_MENTAL | ~ | Mental-health context | 27 | 0.35% | Weak signal | 4.81 | 2012-06-16 → 2026-06-08 ; USE_ADHD | ~ | ADHD / executive function | 23 | 0.30% | Weak signal | 4.91 | 2012-05-22 → 2026-06-20 ; OUT_RESULT | + | Reached goals | 22 | 0.28% | Weak signal | 4.91 | 2012-11-19 → 2026-05-03 ; USE_COACH | ~ | Coach / clinician recommends | 20 | 0.26% | Weak signal | 4.95 | 2012-01-02 → 2026-03-17 ; USE_STUDY | ~ | Study / languages | 18 | 0.23% | Weak signal | 4.67 | 2012-06-16 → 2025-07-01 ; OUT_HEALTH | + | Health improved | 16 | 0.21% | Weak signal | 5.00 | 2013-02-20 → 2026-09-02 ; USE_WORK | ~ | Work | 16 | 0.21% | Weak signal | 4.81 | 2012-11-17 → 2026-02-22 ; USE_FAMILY | ~ | Family / faith | 13 | 0.17% | Weak signal | 4.77 | 2012-05-19 → 2025-07-01 ; OUT_MENTAL | + | Mental wellbeing | 4 | 0.05% | Ignore by default | 5.00 | 2013-03-04 → 2021-08-07 ; USE_SOCIAL | ~ | Group use | 4 | 0.05% | Ignore by default | 4.75 | 2012-05-25 → 2024-02-19 — health and addiction: 'go from 210 pounds to 164 pounds'; 'Today marks 1 month clean'; 'quit smoking, developed daily yoga practice'; mental health and ADHD: 'someone who lives with a mood disorder'; 'I used this to get me out of a rough depression'; 'recently Diagnosed with ADHD'.

- **Where:** §3.2 Outcomes table (verbatim); §3.2 outcome bullets
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** TENURE_LONG 543 (6.99%); OUT_HABIT 517 (6.66%, 4.88); OUT_LIFE 249 (3.21%, 4.94); OUT_AWARENESS 181; USE_FITNESS 98; USE_HEALTH 71; USE_DIET 56; USE_ADDICTION 46 (4.96); USE_MENTAL 27; USE_ADHD 23 (4.91); USE_COACH 20 (4.95)
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `3519155951`, `13775206884`, `14502250642`, `1458418292`, `5141809689`, `7387923706`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C067 Fitness / health tracking use case; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C140 Market the generic-tracker use case

### R76-041 — Coaches and clinicians recommend it to clients: USE_COACH 20 (0.26%, mean 4.95★) — 'I recommend this to clients often' (#7524, ca, 5★).

- **Where:** §3.2 (coaches)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** USE_COACH 20 / 0.26% / 4.95
- **Direction for us:** do · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `13784077317`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R76-042 — Long-term users are a large, high-rating cohort: TENURE_LONG 543 (6.99%, mean 4.85★) — 'almost 9 years since my last review and 13 since the first' (ca 5★); OUT_LIFE 249 (3.21%, mean 4.94★) 'changed their life'.

- **Where:** §3.2 (tenure)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** TENURE_LONG 543 / 6.99% / 4.85; OUT_LIFE 249 / 3.21% / 4.94
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `10961979664`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

## Markets and languages

### R76-007 — China resists the $4.99 / 30-yuan price and names its buying price: China carries 82 of the 306 price objections (26.8%) and price is 15.5% of cn reviews; several name the price at which they would buy — '价格太贵了，要是12块我就买了' (the price is too high; at 12 yuan I would buy it, 5★); '30块也是最贵的' (at 30 yuan also the most expensive, 5★); one cn 5★ says the free three-habit limit is actually better ('免费版三个习惯的设定反而更好').

- **Where:** §0.3 (China); §6.4
- **This app does:** one-time unlock 30 yuan
- **User reaction:** complaint
- **Magnitude:** 82 of 306 price objections (26.8%) from cn; price 15.5% of 528 cn reviews; stated buy-price 12 yuan
- **Direction for us:** research · **Report confidence:** High-priority · **Generalisable:** app-specific
- **Conditions:** cn storefront, early eras
- **Review IDs:** `631326858`, `795518082`, `1399309366`
- **Canonical:** C025 Scholarship / hardship / discount program; C062 Weight English-speaking rich markets; volume ≠ revenue; C092 Regional pricing

### R76-011 — In China, where Dropbox is unreachable, the backup was unusable: 17 of the 18 NEG_DROPBOX_BLOCKED complaints are from cn (2014-07-18 → 2016-03-08), the other from sg — 'Dropbox中国区都屏蔽了吧' (Dropbox is blocked in China, isn't it; 3★).

- **Where:** §0.5 (China Dropbox); §6.4
- **This app does:** Dropbox-only backup
- **User reaction:** blocked-conversion
- **Magnitude:** 17 of 18 Dropbox complaints from cn, 2014-07 → 2016-03
- **Direction for us:** dont · **Report confidence:** Weak · **Generalisable:** generalisable
- **Conditions:** a backup provider must be reachable in every market sold to
- **Review IDs:** `1030287079`
- **Canonical:** C132 Do not sell in a storefront where the app cannot function; C295 Backup and sync must run on infrastructure reachable in every storefront the app is sold in — a blocked provider makes the app's data unsafe in that market

### R76-082 — Storefront table (verbatim): Storefront | Reviews | % of 7,764 | Mean ★ | Public ★ (ratings) | Praise % | Price objection % | Flex request % | Platform request % | Data risk % | E6 share % | Eligible ; us | 3,115 | 40.12% | 4.70 | 4.82 (5,247) | 85.7% | 4.8% | 4.9% | 4.1% | 1.1% | 11.3% | ✅ ; cn | 528 | 6.80% | 4.53 | 4.77 (293) | 65.2% | 24.1% | 2.8% | 5.5% | 4.9% | 2.7% | ✅ ; ru | 480 | 6.18% | 4.51 | 4.82 (1,265) | 70.8% | 8.1% | 6.0% | 7.1% | 3.3% | 14.0% | ✅ ; gb | 415 | 5.35% | 4.67 | 4.72 (681) | 87.2% | 5.8% | 4.3% | 4.3% | 1.0% | 11.1% | ✅ ; ca | 412 | 5.31% | 4.59 | 4.76 (768) | 85.0% | 5.8% | 5.1% | 3.4% | 1.5% | 13.3% | ✅ ; au | 294 | 3.79% | 4.56 | 4.76 (510) | 84.0% | 3.4% | 4.8% | 4.8% | 0.0% | 7.8% | ✅ ; jp | 283 | 3.65% | 4.45 | 4.48 (673) | 83.4% | 13.1% | 2.5% | 3.2% | 1.8% | 5.3% | ✅ ; kr | 282 | 3.63% | 4.67 | 4.69 (374) | 78.4% | 9.6% | 2.5% | 2.8% | 1.4% | 4.3% | ✅ ; de | 210 | 2.70% | 4.60 | 4.67 (709) | 82.9% | 11.4% | 9.0% | 3.3% | 1.9% | 23.8% | ✅ ; br | 160 | 2.06% | 4.49 | 4.77 (465) | 74.4% | 11.9% | 5.6% | 3.8% | 1.2% | 10.0% | ✅ ; dk | 152 | 1.96% | 4.46 | 4.55 (192) | 84.2% | 5.3% | 6.6% | 0.0% | 1.3% | 7.9% | ✅ ; fr | 117 | 1.51% | 4.61 | 4.66 (359) | 81.2% | 6.0% | 8.5% | 9.4% | 0.9% | 27.4% | ✅ ; se | 90 | 1.16% | 4.52 | 4.65 (296) | 86.7% | 6.7% | 2.2% | 2.2% | 1.1% | 14.4% | ✅ ; nl | 87 | 1.12% | 4.64 | 4.70 (188) | 80.5% | 5.7% | 3.4% | 4.6% | 1.1% | 10.3% | ✅ ; mx | 86 | 1.11% | 4.63 | 4.78 (203) | 83.7% | 4.7% | 3.5% | 1.2% | 1.2% | 16.3% | ✅ ; ch | 65 | 0.84% | 4.75 | 4.69 (181) | 92.3% | 3.1% | 1.5% | 0.0% | 1.5% | 16.9% | ✅ ; es | 65 | 0.84% | 4.40 | 4.67 (167) | 83.1% | 15.4% | 6.2% | 6.2% | 0.0% | 10.8% | ✅ ; tw | 64 | 0.82% | 4.44 | 4.82 (117) | 76.6% | 7.8% | 0.0% | 9.4% | 1.6% | 7.8% | ✅ ; in | 61 | 0.79% | 4.52 | 4.69 (177) | 78.7% | 8.2% | 4.9% | 9.8% | 1.6% | 9.8% | ✅ ; ua | 54 | 0.70% | 4.67 | 4.87 (334) | 79.6% | 3.7% | 0.0% | 7.4% | 1.9% | 25.9% | ✅ ; pl | 51 | 0.66% | 4.73 | 4.79 (143) | 82.4% | 3.9% | 0.0% | 2.0% | 2.0% | 21.6% | ✅ ; kz | 50 | 0.64% | 4.76 | 4.88 (561) | 72.0% | 6.0% | 2.0% | 0.0% | 4.0% | 42.0% | ✅ ; 61 other storefronts | 643 | 8.28% | 4.61 | — | 80.6% | 5.9% | 2.6% | 4.2% | 1.4% | 15.6% | ; Global | 7,764 | 100% | 4.62 | — | 81.9% | 7.5% | 4.5% | 4.3% | 1.6% | 11.7% | — 22 storefronts ≥50 reviews are eligible; 'distinctive' = lift ≥1.8 and ≥5 reviews; 61 other storefronts hold 643 (8.28%).

- **Where:** §6.1 table (verbatim); §6.2; Warning 5
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** us 3,115 (40.12%, 4.70); cn 528 (4.53, price obj 24.1%); ru 480 (4.51, platform req 7.1%); gb 415; ca 412; au 294; jp 283 (price obj 13.1%); kr 282; de 210 (flex 9.0%, E6 23.8%); br 160; dk 152; fr 117 (platform 9.4%, E6 27.4%); kz 50 (E6 42.0%)
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-083 — US — 3,115 reviews (40.12%), mean 4.70★, 1–2★ 2.6%, public 4.82★ from 5,247 (verbatim): Code | Meaning | n | % of us | Segment band | % global | Lift ; PR_SIMPLE | Simple / minimal | 674 | 21.6% | High-priority signal | 19.7% | 1.10× ; PR_EASY | Easy / intuitive | 561 | 18.0% | High-priority signal | 17.5% | 1.03× ; PR_INSIGHTS | Charts, trends, overview | 409 | 13.1% | High-priority signal | 10.8% | 1.22× ; PR_GENERIC | General praise | 339 | 10.9% | High-priority signal | 14.2% | 0.76× ; PR_ACCOUNTABILITY | Accountability and discipline | 312 | 10.0% | High-priority signal | 6.1% | 1.63× ; PR_DESIGN | Design and interface | 271 | 8.7% | High-priority signal | 7.8% | 1.12× ; TENURE_LONG | Long-term user | 263 | 8.4% | High-priority signal | 7.0% | 1.21× ; OUT_HABIT | Built or broke habits | 243 | 7.8% | High-priority signal | 6.7% | 1.17× — distinctive REQ_SKIP 7 (2.49×, all 2011), NEG_DEV_PROMISE 5 (2.08×); the US sets the global profile; accountability praise above global (1.63×), price objections below (4.8% vs 7.5%).

- **Where:** §6.3 table (verbatim); §6.3
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** us n=3,115; PR_ACCOUNTABILITY 10.0% (1.63×); price objection 4.8%
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `366961974`, `680662691`, `772694461`, `1026483062`, `388018098`, `736555317`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R76-084 — CN — 528 reviews, mean 4.53★, 1–2★ 4.4%, E6 share only 2.7% (verbatim): Code | Meaning | n | % of cn | Segment band | % global | Lift ; PR_GENERIC | General praise | 114 | 21.6% | High-priority signal | 14.2% | 1.52× ; MON_PRICE | Too expensive | 82 | 15.5% | High-priority signal | 3.9% | 3.94× ; PR_EASY | Easy / intuitive | 66 | 12.5% | High-priority signal | 17.5% | 0.71× ; PR_SIMPLE | Simple / minimal | 61 | 11.6% | High-priority signal | 19.7% | 0.59× ; MON_FREE_LIMIT | Free limit (3 items) too low | 49 | 9.3% | High-priority signal | 3.2% | 2.88× ; MON_PAID | States a purchase | 47 | 8.9% | High-priority signal | 4.5% | 1.98× ; PR_DESIGN | Design and interface | 37 | 7.0% | High-priority signal | 7.8% | 0.90× ; PR_FREE | Free version is enough | 28 | 5.3% | High-priority signal | 3.2% | 1.65× — distinctive NEG_DROPBOX_BLOCKED 17 (13.89×), BUG_BACKUP 5 (7.35×), REQ_BACKUP 9 (6.30×), BUG_CRASH 14 (5.28×), NEG_SLOW_DEV 6 (4.41×), MON_PRICE 82 (3.94×), MON_WONT_PAY 14 (3.74×), MON_FREE_LIMIT 49 (2.88×), REQ_WIDGET 7, MON_INTENT 15 (2.37×), MON_PAID 47 (1.98×), BUG_UPDATE_BROKE 7; China is the price-sensitive market and the backup-blocked market; 2015-01 crash-after-purchase wave; 246 of 528 reviews in E3 (2014-06 → 2015-10); after 2018 never exceeds 12 reviews a year.

- **Where:** §6.4 table (verbatim); §6.4
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** cn n=528; MON_PRICE 15.5% (3.94×); MON_FREE_LIMIT 9.3% (2.88×); Dropbox 17 (13.89×); BUG_CRASH 14 (5.28×); E3 246/528; ≤12/yr after 2018
- **Direction for us:** research · **Report confidence:** High-priority · **Generalisable:** app-specific
- **Side effects:** the market effectively went dark after 2018
- **Review IDs:** `631326858`, `838739355`, `1029527651`, `1033534686`, `1140754481`, `1372754997`, `13811353277`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C092 Regional pricing; C132 Do not sell in a storefront where the app cannot function; C295 Backup and sync must run on infrastructure reachable in every storefront the app is sold in — a blocked provider makes the app's data unsafe in that market

### R76-085 — RU — 480 reviews, mean 4.51★, 1–2★ 8.3% (global 3.7%), 82 in English (verbatim): Code | Meaning | n | % of ru | Segment band | % global | Lift ; PR_GENERIC | General praise | 87 | 18.1% | High-priority signal | 14.2% | 1.27× ; PR_EASY | Easy / intuitive | 65 | 13.5% | High-priority signal | 17.5% | 0.77× ; PR_BEST | Best / favourite | 47 | 9.8% | High-priority signal | 7.1% | 1.39× ; PR_SIMPLE | Simple / minimal | 46 | 9.6% | High-priority signal | 19.7% | 0.49× ; PR_INSIGHTS | Charts, trends, overview | 39 | 8.1% | High-priority signal | 10.8% | 0.75× ; PR_DEV | Thanks the developer | 33 | 6.9% | High-priority signal | 3.5% | 1.99× ; TENURE_LONG | Long-term user | 32 | 6.7% | High-priority signal | 7.0% | 0.95× ; MON_PAID | States a purchase | 29 | 6.0% | High-priority signal | 4.5% | 1.34× — distinctive REQ_INTEGRATION 5 (5.78×), BUG_PURCHASE 11 (3.29×), MON_SUBSCRIPTION 7 (2.83×), BUG_CRASH 6, NEG_DESIGN 10 (2.31×), REQ_REMINDER_PER_ITEM 7, REQ_WATCH 7, BUG_UPDATE_BROKE 7, PR_DEV 33 (1.99×), REQ_WIDGET 5, REQ_IPAD 15 (1.97×), REQ_COUNT 15 (1.88×); Russia over-indexes on purchase/restore failures, subscription objections, design complaints and thanks to the developer.

- **Where:** §6.5 table (verbatim); §6.5
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ru n=480; 1–2★ 8.3%; BUG_PURCHASE 3.29×; MON_SUBSCRIPTION 2.83×; PR_DEV 6.9%
- **Direction for us:** research · **Report confidence:** High-priority · **Generalisable:** app-specific
- **Side effects:** payment rails / restore problems concentrate in ru
- **Review IDs:** `444033822`, `928657103`, `1144066303`, `518814923`, `1129098490`, `14205671630`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C033 Restore purchase and entitlements must work immediately

### R76-086 — GB — 415 reviews, mean 4.67★ (verbatim): Code | Meaning | n | % of gb | Segment band | % global | Lift ; PR_SIMPLE | Simple / minimal | 117 | 28.2% | High-priority signal | 19.7% | 1.43× ; PR_EASY | Easy / intuitive | 80 | 19.3% | High-priority signal | 17.5% | 1.10× ; PR_INSIGHTS | Charts, trends, overview | 56 | 13.5% | High-priority signal | 10.8% | 1.25× ; PR_GENERIC | General praise | 39 | 9.4% | High-priority signal | 14.2% | 0.66× ; PR_MOTIVATION | Motivating | 34 | 8.2% | High-priority signal | 6.6% | 1.25× ; PR_BEST | Best / favourite | 33 | 8.0% | High-priority signal | 7.1% | 1.13× ; TENURE_LONG | Long-term user | 33 | 8.0% | High-priority signal | 7.0% | 1.14× ; PR_DESIGN | Design and interface | 32 | 7.7% | High-priority signal | 7.8% | 0.99× — distinctive PR_SUPPORT 10 (2.75×), NEG_CHART 5, MKT_PRESS 6 (2.20×), REQ_THEMES 6, REV_UPDATED 8, PR_CHAINS 13 (1.89×); over-indexes on support praise and podcast acquisition; PR_SIMPLE 28.2% (1.43×).

- **Where:** §6.6 table (verbatim); §6.6
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** gb n=415; PR_SIMPLE 28.2%; PR_SUPPORT 2.75×; MKT_PRESS 2.20×
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `403353943`, `670898387`, `432804595`, `886204865`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C059 Be visibly responsive; fixes bring reviewers back

### R76-087 — CA — 412 reviews, mean 4.59★, 1–2★ 4.9% (verbatim): Code | Meaning | n | % of ca | Segment band | % global | Lift ; PR_EASY | Easy / intuitive | 98 | 23.8% | High-priority signal | 17.5% | 1.36× ; PR_SIMPLE | Simple / minimal | 84 | 20.4% | High-priority signal | 19.7% | 1.03× ; PR_INSIGHTS | Charts, trends, overview | 55 | 13.3% | High-priority signal | 10.8% | 1.24× ; TENURE_LONG | Long-term user | 42 | 10.2% | High-priority signal | 7.0% | 1.46× ; PR_GENERIC | General praise | 41 | 10.0% | High-priority signal | 14.2% | 0.70× ; PR_DESIGN | Design and interface | 39 | 9.5% | High-priority signal | 7.8% | 1.22× ; PR_MOTIVATION | Motivating | 36 | 8.7% | High-priority signal | 6.6% | 1.33× ; PR_ACCOUNTABILITY | Accountability and discipline | 35 | 8.5% | High-priority signal | 6.1% | 1.38× — distinctive MON_WONT_PAY 8 (2.74×), USE_HEALTH 10 (2.65×), CHURN_RETURN 8 (2.51×), BUG_DATA_LOSS 5 (2.48×), BUG_UPDATE_BROKE 6, PR_ONBOARDING 5; TENURE_LONG 10.2% (1.46×).

- **Where:** §6.7 table (verbatim); §6.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ca n=412; TENURE_LONG 10.2%; MON_WONT_PAY 2.74×; BUG_DATA_LOSS 2.48×
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `371487225`, `700341791`, `779435004`, `1286333467`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R76-088 — AU — 294 reviews, mean 4.56★ (verbatim): Code | Meaning | n | % of au | Segment band | % global | Lift ; PR_SIMPLE | Simple / minimal | 65 | 22.1% | High-priority signal | 19.7% | 1.12× ; PR_EASY | Easy / intuitive | 58 | 19.7% | High-priority signal | 17.5% | 1.13× ; PR_INSIGHTS | Charts, trends, overview | 33 | 11.2% | High-priority signal | 10.8% | 1.04× ; PR_DESIGN | Design and interface | 29 | 9.9% | High-priority signal | 7.8% | 1.27× ; PR_MOTIVATION | Motivating | 27 | 9.2% | High-priority signal | 6.6% | 1.40× ; PR_GENERIC | General praise | 26 | 8.8% | High-priority signal | 14.2% | 0.62× ; PR_BEST | Best / favourite | 25 | 8.5% | High-priority signal | 7.1% | 1.20× ; TENURE_LONG | Long-term user | 24 | 8.2% | High-priority signal | 7.0% | 1.17× — distinctive PR_ONBOARDING 9 (4.95×), MKT_PRESS 6 (3.11×), NEG_SIMPLE 5, CONTRA_RATING 5, PR_EXPORT 5, BUG_UPDATE_BROKE 5, NEG_UI_CONFUSING 7, REV_TIP 5, OUT_LIFE 18 (1.91×); over-indexes on tutorial praise and press acquisition.

- **Where:** §6.8 table (verbatim); §6.8
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** au n=294; PR_ONBOARDING 4.95×; MKT_PRESS 3.11×; OUT_LIFE 1.91×
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `474570912`, `691882580`, `477706346`, `758549241`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R76-089 — JP — 283 reviews, mean 4.45★, price objection 13.1% (verbatim): Code | Meaning | n | % of jp | Segment band | % global | Lift ; PR_EASY | Easy / intuitive | 81 | 28.6% | High-priority signal | 17.5% | 1.64× ; PR_SIMPLE | Simple / minimal | 58 | 20.5% | High-priority signal | 19.7% | 1.04× ; PR_GENERIC | General praise | 38 | 13.4% | High-priority signal | 14.2% | 0.94× ; PR_INSIGHTS | Charts, trends, overview | 29 | 10.2% | High-priority signal | 10.8% | 0.95× ; OUT_HABIT | Built or broke habits | 28 | 9.9% | High-priority signal | 6.7% | 1.49× ; PR_MOTIVATION | Motivating | 25 | 8.8% | High-priority signal | 6.6% | 1.35× ; PR_FREE | Free version is enough | 22 | 7.8% | High-priority signal | 3.2% | 2.42× ; MON_PAID | States a purchase | 21 | 7.4% | High-priority signal | 4.5% | 1.65× — distinctive NEG_BACKFILL 6 (4.22×), PR_FREE 22 (2.42×), MON_FREE_LIMIT 20 (2.19×), COMP_MENTION 8, PR_SKIP 7; concentrated in E2 (143 of 283, 117 in 2013); praises ease and the free version, objects to the 3-item limit; logging past days a distinctive friction; lowest public rating among eligible (4.48).

- **Where:** §6.9 table (verbatim); §6.9
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** jp n=283; MON_FREE_LIMIT 2.19×; NEG_BACKFILL 4.22×; E2 143/283
- **Direction for us:** research · **Report confidence:** High-priority · **Generalisable:** app-specific
- **Review IDs:** `375991586`, `730340451`, `473298936`, `757671827`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C010 Backfill missed days / edit start date

### R76-090 — KR — 282 reviews, mean 4.67★, 1–2★ 1.8% (verbatim): Code | Meaning | n | % of kr | Segment band | % global | Lift ; PR_GENERIC | General praise | 70 | 24.8% | High-priority signal | 14.2% | 1.74× ; PR_SIMPLE | Simple / minimal | 54 | 19.1% | High-priority signal | 19.7% | 0.97× ; PR_EASY | Easy / intuitive | 48 | 17.0% | High-priority signal | 17.5% | 0.97× ; MON_PAID | States a purchase | 29 | 10.3% | High-priority signal | 4.5% | 2.29× ; PR_INSIGHTS | Charts, trends, overview | 19 | 6.7% | High-priority signal | 10.8% | 0.62× ; MON_VALUE | Worth the money | 15 | 5.3% | High-priority signal | 4.4% | 1.21× ; NOISE | No usable content | 15 | 5.3% | High-priority signal | 0.9% | 5.82× ; PR_RECOMMEND | Recommends it | 15 | 5.3% | High-priority signal | 6.5% | 0.82× — distinctive NOISE 15 (5.82×), MON_INTENT 13 (3.85×), MON_PAID 29 (2.29×); concentrated in E3–E4 (201 of 282); stated purchases and intent to buy above global.

- **Where:** §6.10 table (verbatim); §6.10
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** kr n=282; MON_INTENT 3.85×; MON_PAID 2.29×; NOISE 5.82×
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** app-specific
- **Review IDs:** `390768471`, `992799631`, `1129322087`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R76-091 — DE — 210 reviews, mean 4.60★, E6 share 23.8%, 63 in English (verbatim): Code | Meaning | n | % of de | Segment band | % global | Lift ; PR_SIMPLE | Simple / minimal | 43 | 20.5% | High-priority signal | 19.7% | 1.04× ; PR_GENERIC | General praise | 34 | 16.2% | High-priority signal | 14.2% | 1.14× ; PR_EASY | Easy / intuitive | 32 | 15.2% | High-priority signal | 17.5% | 0.87× ; PR_INSIGHTS | Charts, trends, overview | 26 | 12.4% | High-priority signal | 10.8% | 1.15× ; PR_BEST | Best / favourite | 24 | 11.4% | High-priority signal | 7.1% | 1.62× ; TENURE_LONG | Long-term user | 22 | 10.5% | High-priority signal | 7.0% | 1.50× ; PR_RECOMMEND | Recommends it | 19 | 9.0% | High-priority signal | 6.5% | 1.40× ; PR_DESIGN | Design and interface | 18 | 8.6% | High-priority signal | 7.8% | 1.11× — distinctive PR_KEEP_SIMPLE 8 (4.62×), REQ_FREQUENCY 15 (2.59×), OUT_PRODUCTIVE 5; Germany asks to keep the app simple more than any other storefront and asks for frequency at over twice the global rate; 124 of 210 from E5–E6.

- **Where:** §6.11 table (verbatim); §6.11
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** de n=210; PR_KEEP_SIMPLE 4.62×; REQ_FREQUENCY 2.59×; flex 9.0%
- **Direction for us:** research · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `393953278`, `921083230`, `1095046630`, `8818753273`, `14138530409`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C043 Flexible / custom frequency

### R76-092 — BR — 160, 4.49★, 1–2★ 6.9%: distinctive PR_ALLINONE 5 (4.04×), MON_FREE_LIMIT 10 (1.94×) (verbatim) Code | Meaning | n | % of br | Segment band | % global | Lift ; PR_GENERIC | General praise | 38 | 23.8% | High-priority signal | 14.2% | 1.67× ; PR_SIMPLE | Simple / minimal | 23 | 14.4% | High-priority signal | 19.7% | 0.73× ; PR_EASY | Easy / intuitive | 17 | 10.6% | High-priority signal | 17.5% | 0.61× ; OUT_HABIT | Built or broke habits | 16 | 10.0% | High-priority signal | 6.7% | 1.50× ; PR_INSIGHTS | Charts, trends, overview | 11 | 6.9% | High-priority signal | 10.8% | 0.64× ; MON_VALUE | Worth the money | 11 | 6.9% | High-priority signal | 4.4% | 1.56× ; MON_FREE_LIMIT | Free limit (3 items) too low | 10 | 6.2% | High-priority signal | 3.2% | 1.94× ; PR_BEST | Best / favourite | 10 | 6.2% | High-priority signal | 7.1% | 0.89× || DK — 152, 4.46★, the developer's home market, 81 of 152 in E1–E2: OUT_AWARENESS 16 (4.52×), PR_CUSTOM 9, PR_REMINDERS 15 (2.18×), REQ_COUNT 5 (verbatim) Code | Meaning | n | % of dk | Segment band | % global | Lift ; PR_EASY | Easy / intuitive | 30 | 19.7% | High-priority signal | 17.5% | 1.13× ; PR_GENERIC | General praise | 28 | 18.4% | High-priority signal | 14.2% | 1.29× ; PR_INSIGHTS | Charts, trends, overview | 24 | 15.8% | High-priority signal | 10.8% | 1.46× ; PR_SIMPLE | Simple / minimal | 20 | 13.2% | High-priority signal | 19.7% | 0.67× ; OUT_AWARENESS | Self-awareness | 16 | 10.5% | High-priority signal | 2.3% | 4.52× ; PR_REMINDERS | Reminders | 15 | 9.9% | High-priority signal | 4.5% | 2.18× ; PR_MOTIVATION | Motivating | 14 | 9.2% | High-priority signal | 6.6% | 1.40× ; PR_RECOMMEND | Recommends it | 10 | 6.6% | High-priority signal | 6.5% | 1.02× || FR — 117, 4.61★, E6 share 27.4%: REQ_SYNC 6 (2.86×), REQ_COUNT 5 (2.57×), REQ_FREQUENCY 6 (1.86×) (verbatim) Code | Meaning | n | % of fr | Segment band | % global | Lift ; PR_SIMPLE | Simple / minimal | 29 | 24.8% | High-priority signal | 19.7% | 1.26× ; PR_GENERIC | General praise | 22 | 18.8% | High-priority signal | 14.2% | 1.32× ; PR_EASY | Easy / intuitive | 21 | 17.9% | High-priority signal | 17.5% | 1.03× ; PR_DESIGN | Design and interface | 14 | 12.0% | High-priority signal | 7.8% | 1.54× ; PR_INSIGHTS | Charts, trends, overview | 11 | 9.4% | High-priority signal | 10.8% | 0.87× ; PR_MOTIVATION | Motivating | 10 | 8.5% | High-priority signal | 6.6% | 1.30× ; OUT_HABIT | Built or broke habits | 9 | 7.7% | High-priority signal | 6.7% | 1.16× ; PR_RECOMMEND | Recommends it | 8 | 6.8% | High-priority signal | 6.5% | 1.06×

- **Where:** §6.12 table (verbatim); §6.12; §6.13 table (verbatim); §6.13; §6.14 table (verbatim); §6.14
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** br MON_FREE_LIMIT 1.94×; dk OUT_AWARENESS 4.52×; fr REQ_SYNC 2.86×
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `517741429`, `574001937`, `424263889`, `442941722`, `481743677`, `531616481`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C048 Flexible units / partial progress

### R76-093 — Smaller eligible storefronts (50–90 reviews), praise profiles close to global, non-praise codes indicative only — SE 90 (4.52★, 1–2★ 7.8%; PR_STICKY 2.12×) Code | Meaning | n | % of se | Segment band | % global | Lift ; PR_SIMPLE | Simple / minimal | 19 | 21.1% | High-priority signal | 19.7% | 1.07× ; PR_EASY | Easy / intuitive | 17 | 18.9% | High-priority signal | 17.5% | 1.08× ; PR_GENERIC | General praise | 15 | 16.7% | High-priority signal | 14.2% | 1.17× ; PR_INSIGHTS | Charts, trends, overview | 9 | 10.0% | High-priority signal | 10.8% | 0.93× ; PR_MOTIVATION | Motivating | 9 | 10.0% | High-priority signal | 6.6% | 1.53× ; OUT_HABIT | Built or broke habits | 9 | 10.0% | High-priority signal | 6.7% | 1.50× ; PR_STICKY | Daily use / indispensable | 8 | 8.9% | High-priority signal | 4.2% | 2.12× ; PR_BEST | Best / favourite | 7 | 7.8% | High-priority signal | 7.1% | 1.10× || NL 87 (4.64★; PR_FREE 2.15×) Code | Meaning | n | % of nl | Segment band | % global | Lift ; PR_SIMPLE | Simple / minimal | 22 | 25.3% | High-priority signal | 19.7% | 1.28× ; PR_GENERIC | General praise | 12 | 13.8% | High-priority signal | 14.2% | 0.97× ; PR_EASY | Easy / intuitive | 11 | 12.6% | High-priority signal | 17.5% | 0.72× ; PR_BEST | Best / favourite | 9 | 10.3% | High-priority signal | 7.1% | 1.47× ; TENURE_LONG | Long-term user | 9 | 10.3% | High-priority signal | 7.0% | 1.48× ; PR_TRACKING | Habit tracking | 7 | 8.0% | High-priority signal | 4.7% | 1.73× ; PR_MOTIVATION | Motivating | 7 | 8.0% | High-priority signal | 6.6% | 1.23× ; OUT_HABIT | Built or broke habits | 7 | 8.0% | High-priority signal | 6.7% | 1.21× || MX 86 (4.63★; PR_TRACKING 2.00×) Code | Meaning | n | % of mx | Segment band | % global | Lift ; PR_GENERIC | General praise | 21 | 24.4% | High-priority signal | 14.2% | 1.72× ; PR_SIMPLE | Simple / minimal | 16 | 18.6% | High-priority signal | 19.7% | 0.94× ; PR_EASY | Easy / intuitive | 15 | 17.4% | High-priority signal | 17.5% | 1.00× ; PR_RECOMMEND | Recommends it | 10 | 11.6% | High-priority signal | 6.5% | 1.79× ; PR_TRACKING | Habit tracking | 8 | 9.3% | High-priority signal | 4.7% | 2.00× ; PR_BEST | Best / favourite | 4 | 4.7% | Very strong signal | 7.1% | 0.66× ; PR_DESIGN | Design and interface | 4 | 4.7% | Very strong signal | 7.8% | 0.60× ; PR_REMINDERS | Reminders | 3 | 3.5% | Very strong signal | 4.5% | 0.77× || CH 65 (4.75★, praise 92.3%; PR_PERF 3.87×) Code | Meaning | n | % of ch | Segment band | % global | Lift ; PR_SIMPLE | Simple / minimal | 18 | 27.7% | High-priority signal | 19.7% | 1.40× ; PR_GENERIC | General praise | 13 | 20.0% | High-priority signal | 14.2% | 1.41× ; PR_EASY | Easy / intuitive | 11 | 16.9% | High-priority signal | 17.5% | 0.97× ; PR_DESIGN | Design and interface | 8 | 12.3% | High-priority signal | 7.8% | 1.59× ; PR_RECOMMEND | Recommends it | 6 | 9.2% | High-priority signal | 6.5% | 1.42× ; PR_BEST | Best / favourite | 6 | 9.2% | High-priority signal | 7.1% | 1.31× ; PR_PERF | Reliable / works | 6 | 9.2% | High-priority signal | 2.4% | 3.87× ; TENURE_LONG | Long-term user | 5 | 7.7% | High-priority signal | 7.0% | 1.10× || ES 65 (4.40★; PR_PERF 3.87×, MON_FREE_LIMIT 6 (2.87×), MON_PRICE 5) Code | Meaning | n | % of es | Segment band | % global | Lift ; PR_GENERIC | General praise | 13 | 20.0% | High-priority signal | 14.2% | 1.41× ; PR_INSIGHTS | Charts, trends, overview | 10 | 15.4% | High-priority signal | 10.8% | 1.43× ; PR_SIMPLE | Simple / minimal | 10 | 15.4% | High-priority signal | 19.7% | 0.78× ; TENURE_LONG | Long-term user | 8 | 12.3% | High-priority signal | 7.0% | 1.76× ; PR_BEST | Best / favourite | 7 | 10.8% | High-priority signal | 7.1% | 1.53× ; PR_PERF | Reliable / works | 6 | 9.2% | High-priority signal | 2.4% | 3.87× ; MON_FREE_LIMIT | Free limit (3 items) too low | 6 | 9.2% | High-priority signal | 3.2% | 2.87× ; MON_PRICE | Too expensive | 5 | 7.7% | High-priority signal | 3.9% | 1.95× || TW 64 (4.44★; PR_GENERIC 1.98×) Code | Meaning | n | % of tw | Segment band | % global | Lift ; PR_GENERIC | General praise | 18 | 28.1% | High-priority signal | 14.2% | 1.98× ; PR_EASY | Easy / intuitive | 17 | 26.6% | High-priority signal | 17.5% | 1.52× ; PR_SIMPLE | Simple / minimal | 7 | 10.9% | High-priority signal | 19.7% | 0.55× ; OUT_HABIT | Built or broke habits | 4 | 6.2% | High-priority signal | 6.7% | 0.94× ; MON_VALUE | Worth the money | 4 | 6.2% | High-priority signal | 4.4% | 1.42× ; PR_BEST | Best / favourite | 3 | 4.7% | Very strong signal | 7.1% | 0.66× ; PR_INSIGHTS | Charts, trends, overview | 3 | 4.7% | Very strong signal | 10.8% | 0.43× ; PR_ACCOUNTABILITY | Accountability and discipline | 3 | 4.7% | Very strong signal | 6.1% | 0.76× || IN 61 (4.52★, 1–2★ 6.6%; PR_BEST 2.09×, MON_VALUE 1.86×) Code | Meaning | n | % of in | Segment band | % global | Lift ; PR_SIMPLE | Simple / minimal | 13 | 21.3% | High-priority signal | 19.7% | 1.08× ; PR_EASY | Easy / intuitive | 11 | 18.0% | High-priority signal | 17.5% | 1.03× ; PR_INSIGHTS | Charts, trends, overview | 11 | 18.0% | High-priority signal | 10.8% | 1.67× ; PR_BEST | Best / favourite | 9 | 14.8% | High-priority signal | 7.1% | 2.09× ; PR_DESIGN | Design and interface | 6 | 9.8% | High-priority signal | 7.8% | 1.27× ; PR_TRACKING | Habit tracking | 5 | 8.2% | High-priority signal | 4.7% | 1.76× ; TENURE_LONG | Long-term user | 5 | 8.2% | High-priority signal | 7.0% | 1.17× ; MON_VALUE | Worth the money | 5 | 8.2% | High-priority signal | 4.4% | 1.86× || UA 54 (4.67★, E6 25.9%; PR_DEV 2.68×, PR_BEST 2.10×) Code | Meaning | n | % of ua | Segment band | % global | Lift ; PR_SIMPLE | Simple / minimal | 12 | 22.2% | High-priority signal | 19.7% | 1.13× ; PR_EASY | Easy / intuitive | 10 | 18.5% | High-priority signal | 17.5% | 1.06× ; PR_BEST | Best / favourite | 8 | 14.8% | High-priority signal | 7.1% | 2.10× ; PR_GENERIC | General praise | 6 | 11.1% | High-priority signal | 14.2% | 0.78× ; PR_DEV | Thanks the developer | 5 | 9.3% | High-priority signal | 3.5% | 2.68× ; PR_BETTER_THAN | Better than alternatives | 5 | 9.3% | High-priority signal | 5.5% | 1.68× ; PR_INSIGHTS | Charts, trends, overview | 4 | 7.4% | High-priority signal | 10.8% | 0.69× ; PR_RECOMMEND | Recommends it | 4 | 7.4% | High-priority signal | 6.5% | 1.14× || PL 51 (4.73★, E6 21.6%; PR_RECOMMEND 2.72×) Code | Meaning | n | % of pl | Segment band | % global | Lift ; PR_GENERIC | General praise | 12 | 23.5% | High-priority signal | 14.2% | 1.65× ; PR_RECOMMEND | Recommends it | 9 | 17.6% | High-priority signal | 6.5% | 2.72× ; PR_EASY | Easy / intuitive | 8 | 15.7% | High-priority signal | 17.5% | 0.90× ; PR_DESIGN | Design and interface | 7 | 13.7% | High-priority signal | 7.8% | 1.77× ; PR_SIMPLE | Simple / minimal | 7 | 13.7% | High-priority signal | 19.7% | 0.70× ; PR_BEST | Best / favourite | 6 | 11.8% | High-priority signal | 7.1% | 1.67× ; PR_BETTER_THAN | Better than alternatives | 5 | 9.8% | High-priority signal | 5.5% | 1.78× ; PR_INSIGHTS | Charts, trends, overview | 3 | 5.9% | High-priority signal | 10.8% | 0.54× || KZ 50 (4.76★, E6 42.0%, public 4.88 from 561; PR_DEV 7 (4.06×)) Code | Meaning | n | % of kz | Segment band | % global | Lift ; PR_GENERIC | General praise | 12 | 24.0% | High-priority signal | 14.2% | 1.69× ; PR_SIMPLE | Simple / minimal | 9 | 18.0% | High-priority signal | 19.7% | 0.91× ; PR_DEV | Thanks the developer | 7 | 14.0% | High-priority signal | 3.5% | 4.06× ; PR_BEST | Best / favourite | 6 | 12.0% | High-priority signal | 7.1% | 1.70× ; PR_RECOMMEND | Recommends it | 5 | 10.0% | High-priority signal | 6.5% | 1.54× ; NOISE | No usable content | 4 | 8.0% | High-priority signal | 0.9% | 8.75× ; PR_DESIGN | Design and interface | 3 | 6.0% | High-priority signal | 7.8% | 0.77× ; PR_EASY | Easy / intuitive | 3 | 6.0% | High-priority signal | 17.5% | 0.34×

- **Where:** §6.15 table (verbatim); §6.15; §6.16 table (verbatim); §6.16; §6.17 table (verbatim); §6.17; §6.18 table (verbatim); §6.18; §6.19 table (verbatim); §6.19; §6.20 table (verbatim); §6.20; §6.21 table (verbatim); §6.21; §6.22 table (verbatim); §6.22; §6.23 table (verbatim); §6.23; §6.24 table (verbatim); §6.24
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** se 90; nl 87; mx 86; ch 65; es 65; tw 64; in 61; ua 54; pl 51; kz 50
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `557387124`, `430977478`, `465335448`, `431878578`, `602558441`, `520589375`, `434015786`, `712022151`, `628746327`, `1317905877`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R76-094 — High-spend and high-volume groups (no spend dataset fetched; public-ratings count as install-base proxy) (verbatim): Group | Reviews | Mean ★ | Praise % | Price objection % | Flex request % | Platform request % | Data risk % | Subscription objection % | E6 share % ; High-spend proxy: us + ru + ca + de + gb + jp | 4,915 | 4.65 | 84.1% | 6.1% | 5.0% | 4.3% | 1.4% | 0.5% | 11.9% ; High-volume: us + cn + ru + gb + ca + au + jp + kr + de | 6,019 | 4.64 | 82.2% | 7.7% | 4.7% | 4.3% | 1.6% | 0.5% | 10.5% ; us only | 3,115 | 4.70 | 85.7% | 4.8% | 4.9% | 4.1% | 1.1% | 0.4% | 11.3% ; cn + tw + jp + kr (East Asia) | 1,157 | 4.54 | 73.5% | 16.9% | 2.5% | 4.5% | 3.1% | 0.3% | 4.0% ; ru + ua + kz (Russian-speaking) | 584 | 4.55 | 71.7% | 7.5% | 5.1% | 6.5% | 3.3% | 1.5% | 17.5% ; de + dk + se + nl + ch + fr + es (continental Europe, eligible) | 786 | 4.56 | 83.8% | 7.9% | 6.2% | 3.6% | 1.3% | 0.5% | 17.0% ; Global | 7,764 | 4.62 | 81.9% | 7.5% | 4.5% | 4.3% | 1.6% | 0.5% | 11.7% — price objection concentrated in East Asia (16.9%), driven by China; high-spend proxy and US below global; Russian-speaking group asks for other platforms (6.5%) and reports data risk (3.3%) at ~1.5–2× global and carries the highest subscription-objection share (1.5%) on few reviews; continental Europe asks most for flexible frequency (6.2%); subscription objections too few in any group to rank markets.

- **Where:** §6.25 table (verbatim); §6.25
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** East Asia price obj 16.9% vs 7.5% global; ru-speaking platform 6.5%, data risk 3.3%, subscription 1.5%; Europe flex 6.2%
- **Direction for us:** research · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `631326858`, `13006973106`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C043 Flexible / custom frequency; C092 Regional pricing

### R76-095 — Storefront is not language (verbatim): Language | Reviews | Storefronts (reviews) ; English (en) | 5344 | us (3098), gb (412), ca (400), au (294), ru (82), de (63), in (61), nl (52) ; Chinese (zh) | 538 | cn (498), tw (37), us (2), mo (1) ; Russian (ru) | 466 | ru (398), kz (25), ua (23), by (4), us (3), uz (3), pl (2), az (2) ; Korean (ko) | 263 | kr (260), us (2), vn (1) ; Japanese (ja) | 251 | jp (250), vn (1) ; German (de) | 179 | de (145), ch (23), at (9), fr (1), es (1) ; Spanish (es) | 144 | mx (71), es (36), co (12), us (8), cl (5), ar (4), pe (2), uy (1) ; Portuguese (pt) | 133 | br (127), pt (4), us (2) ; Danish (da) | 115 | dk (114), se (1) ; French (fr) | 107 | fr (83), ca (12), ch (9), be (2), cg (1) ; Swedish (sv) | 48 | se (48) ; Dutch (nl) | 35 | nl (34), be (1) ; Italian (it) | 28 | it (27), ch (1) ; Polish (pl) | 24 | pl (23), gb (1) ; Norwegian (no) | 20 | no (20) ; Turkish (tr) | 20 | tr (19), az (1) ; Ukrainian (uk) | 12 | ua (11), pl (1) ; Arabic (ar) | 8 | sa (6), eg (1), il (1) ; Czech (cs) | 7 | cz (7) ; Finnish (fi) | 6 | fi (6) ; Catalan (ca) | 4 | es (4) ; Romanian (ro) | 4 | ro (2), fr (1), de (1) ; Thai (th) | 3 | th (3) ; Hebrew (he) | 2 | il (2) ; Zulu (zu) | 1 | gb (1) ; Persian (fa) | 1 | gb (1) ; Indonesian (id) | 1 | id (1) — English is the review language of 78 storefronts; Russian written from 14, Chinese from 4; reviewers ask for Chinese, Russian, Japanese, Korean, Kazakh and Galician interfaces or a working language switch (REQ_LANG 13, 2012-11-28 → 2026-07-13); translation errors reported in 8 languages (BUG_LANG 15).

- **Where:** §6.26 table (verbatim); §6.26
- **This app does:** 25 declared languages; not Kazakh or Galician
- **User reaction:** complaint
- **Magnitude:** REQ_LANG 13; BUG_LANG 15; en 5,344 across 78 storefronts
- **Direction for us:** do · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C027 Localise early — it unlocks revenue; C255 An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language

### R76-096 — Storefronts below 50 reviews — limited evidence (verbatim): Storefront | Reviews | Mean ★ | E6 | Top codes | IDs (up to 3) ; no | 42 | 4.69 | 4 | PR_SIMPLE 11, PR_EASY 8, PR_INSIGHTS 7, PR_GENERIC 7 | 405627521, 1286190459, 13989742414 ; it | 39 | 4.31 | 4 | PR_SIMPLE 9, OUT_HABIT 6, MON_PRICE 5, MON_FREE_LIMIT 4 | 478458299, 2751806168, 13517885229 ; nz | 38 | 4.47 | 5 | PR_SIMPLE 14, PR_EASY 7, PR_RECOMMEND 4, PR_TRACKING 4 | 485881908, 1374806636, 13992673575 ; sg | 33 | 4.64 | 0 | PR_SIMPLE 9, PR_EASY 8, PR_DESIGN 5, PR_INSIGHTS 4 | 482404411, 1102144526, 9788063931 ; ie | 32 | 4.75 | 3 | PR_SIMPLE 10, PR_EASY 8, PR_INSIGHTS 6, PR_GENERIC 5 | 798596125, 1313584166, 13980790575 ; th | 29 | 4.83 | 1 | PR_GENERIC 8, PR_EASY 7, PR_RECOMMEND 5, PR_DESIGN 3 | 542748509, 1127311655, 11910793474 ; at | 28 | 4.79 | 3 | PR_SIMPLE 8, PR_BETTER_THAN 5, PR_GENERIC 3, PR_BEST 3 | 482396275, 1949611550, 12514279904 ; tr | 24 | 4.29 | 3 | PR_GENERIC 4, MON_FREE_LIMIT 4, REQ_FREQUENCY 3, PR_EASY 2 | 1275536253, 3513007843, 12866508311 ; my | 21 | 4.48 | 2 | PR_GENERIC 5, PR_SIMPLE 4, PR_EASY 3, PR_DESIGN 3 | 574895068, 1396519669, 10425144524 ; ro | 20 | 4.85 | 3 | PR_GENERIC 9, PR_BEST 5, PR_EASY 4, REQ_IPAD 2 | 616481382, 1520674747, 12937522481 ; vn | 20 | 4.80 | 4 | PR_GENERIC 6, PR_REMINDERS 2, PR_EASY 2, NOISE 2 | 837656386, 5918209633, 14518278104 ; cz | 20 | 4.75 | 5 | PR_GENERIC 4, PR_RECOMMEND 4, PR_BEST 2, PR_SIMPLE 2 | 953887937, 6376719423, 13983178097 ; co | 19 | 4.68 | 3 | PR_SIMPLE 5, PR_EASY 4, OUT_HABIT 4, PR_GENERIC 3 | 505729266, 4507554820, 10975942862 ; be | 19 | 4.47 | 3 | PR_EASY 6, PR_DESIGN 4, PR_BETTER_THAN 3, PR_SIMPLE 3 | 555134835, 1353281488, 14003607864 ; hk | 17 | 4.65 | 1 | PR_SIMPLE 5, PR_INSIGHTS 4, PR_TRACKING 3, PR_EASY 2 | 653238331, 1190940680, 13754210137 ; il | 16 | 4.38 | 2 | PR_DESIGN 5, PR_SIMPLE 4, PR_GENERIC 4, PR_EASY 3 | 480618894, 1286540403, 14004715417 ; za | 16 | 4.62 | 3 | OUT_HABIT 4, PR_SIMPLE 3, PR_EASY 3, PR_INSIGHTS 3 | 592699501, 3054076635, 13987598821 ; fi | 16 | 4.88 | 0 | PR_EASY 3, PR_SIMPLE 2, PR_FREE 2, PR_UPDATE 2 | 749984962, 1416268252, 9788475166 ; sa | 15 | 4.40 | 2 | PR_GENERIC 4, OUT_HABIT 2, PR_RECOMMEND 2, MON_PAYWALL 2 | 768067385, 8354477660, 13777979524 ; eg | 12 | 4.67 | 3 | PR_TRACKING 3, PR_SIMPLE 3, PR_BEST 2, PR_GENERIC 2 | 435980498, 1401954075, 14072314814 ; ar | 12 | 4.33 | 2 | PR_GENERIC 4, OUT_HABIT 3, PR_BEST 2, NEG_GENERIC 1 | 503370820, 1760651629, 13985322973 ; ph | 12 | 4.42 | 1 | PR_FREE 3, PR_DESIGN 3, PR_GENERIC 3, PR_EASY 2 | 599461206, 1324598373, 14131670963 ; id | 12 | 4.75 | 3 | PR_SIMPLE 4, PR_RECOMMEND 2, PR_EASY 2, PR_FREE 2 | 705599648, 6540085351, 13093629183 ; pt | 11 | 4.09 | 3 | PR_EASY 3, PR_SIMPLE 2, TENURE_LONG 2, NEG_CHART 1 | 1261541414, 3599632991, 13984286015 ; ae | 10 | 4.80 | 2 | PR_SIMPLE 4, TENURE_LONG 3, PR_BEST 2, PR_REMINDERS 2 | 1143687873, 1434967583, 13927444484 ; by | 10 | 4.50 | 3 | PR_GENERIC 2, PR_BEST 2, PR_DEV 1, MON_FREE_LIMIT 1 | 1341885916, 6486663782, 14146364080 ; cl | 8 | 4.38 | 1 | PR_ALLINONE 2, PR_SIMPLE 1, REQ_FREQUENCY 1, PR_GENERIC 1 | 606519595, 1380080006, 13983307174 ; is | 8 | 4.88 | 0 | PR_GENERIC 3, OUT_HABIT 2, JUST_STARTED 1, PR_BETTER_THAN 1 | 693972513, 901226743, 5496854232 ; lv | 6 | 4.67 | 1 | PR_SIMPLE 2, PR_MOTIVATION 1, OUT_LIFE 1, REQ_WEB 1 | 935936331, 3511564071, 13981001292 ; gr | 6 | 4.67 | 0 | PR_GENERIC 2, PR_DESIGN 2, MON_FREE_LIMIT 1, NEG_ADS 1 | 1064216327, 1163697717, 9786428862 ; hu | 6 | 4.50 | 1 | PR_MOTIVATION 2, PR_SIMPLE 2, PR_BEST 1, NEG_CHART 1 | 1129066171, 1434271860, 12767065725 ; sk | 6 | 4.67 | 0 | PR_SIMPLE 3, PR_INSIGHTS 2, BUG_REMINDER 1, CONTRA_RATING 1 | 1147002966, 4629361554, 9807568416 ; uz | 6 | 4.83 | 4 | PR_GENERIC 3, MON_PAID 1, REQ_SYNC 1, REQ_IPAD 1 | 7361725220, 11485786487, 13776530408 ; lt | 5 | 5.00 | 3 | PR_TRACKING 1, PR_DESIGN 1, PR_STICKY 1, PR_SIMPLE 1 | 759268422, 13747669352, 14120452152 ; az | 5 | 5.00 | 3 | BUG_PURCHASE 1, CONTRA_RATING 1, NOISE 1, PR_EASY 1 | 5063082574, 10191901782, 14128629134 ; si | 4 | 4.50 | 1 | PR_GENERIC 1, REQ_SYNC 1, MON_PRICE 1, BUG_CRASH 1 | 591732687, 1450878966, 13997946512 ; cr | 4 | 5.00 | 2 | PR_SIMPLE 1, PR_FAST 1, OUT_LIFE 1, PR_BEST 1 | 926236360, 10958062991, 12734832171 ; gt | 4 | 4.75 | 3 | PR_EASY 1, PR_TRACKING 1, PR_INSIGHTS 1, PR_SIMPLE 1 | 1125164985, 12904900001, 13959420014 ; hr | 3 | 5.00 | 2 | PR_BEST 2, OUT_HABIT 1, PR_ACCOUNTABILITY 1, PR_CONCEPT 1 | 695539391, 12733892252, 13769707774 ; pe | 2 | 5.00 | 1 | PR_BEST 1, PR_TRACKING 1, PR_GENERIC 1 | 588145121, 13060295739 ; ke | 2 | 4.50 | 1 | PR_SIMPLE 1, REQ_IPAD 1, PR_STICKY 1 | 595377399, 10977287983 ; md | 2 | 5.00 | 0 | OUT_LIFE 1, MON_PAID 1, PR_EASY 1, TENURE_LONG 1 | 1008779656, 1364363921 ; mo | 2 | 5.00 | 0 | REQ_COUNT 1, REQ_THEMES 1, PR_EASY 1, OUT_HABIT 1 | 1054097033, 1143780885 ; ee | 2 | 3.00 | 1 | PR_EASY 1, OUT_HABIT 1, MON_PRICE 1 | 8318782700, 13477159326 ; ng | 2 | 5.00 | 1 | PR_FREE 1, MON_PAID 1, TENURE_LONG 1, PR_SIMPLE 1 | 9823675500, 12745706469 ; kg | 2 | 5.00 | 2 | TENURE_LONG 1, PR_STICKY 1, PR_DESIGN 1, OUT_HABIT 1 | 13986102488, 14055241111 ; uy | 1 | 5.00 | 0 | PR_GENERIC 1 | 722120142 ; jo | 1 | 5.00 | 0 | PR_BEST 1, OUT_PRODUCTIVE 1 | 739193098 ; tn | 1 | 4.00 | 0 | PR_INSIGHTS 1, PR_MOTIVATION 1 | 994880791 ; mt | 1 | 4.00 | 0 | PR_MOTIVATION 1, PR_INSIGHTS 1, PR_STICKY 1 | 1188519064 ; gh | 1 | 3.00 | 0 | PR_FREE 1, MON_INTENT 1 | 1312571003 ; lu | 1 | 5.00 | 0 | OUT_LIFE 1, PR_BEST 1 | 3195078992 ; ec | 1 | 4.00 | 0 | PR_GENERIC 1 | 5510415012 ; bg | 1 | 4.00 | 0 | REQ_DATE_RANGE 1 | 7499812396 ; lk | 1 | 5.00 | 0 | OUT_PRODUCTIVE 1, PR_DEV 1 | 7577476743 ; ge | 1 | 5.00 | 0 | PR_MOTIVATION 1, PR_RECOMMEND 1 | 9434000049 ; tz | 1 | 5.00 | 1 | PR_GENERIC 1 | 12461783791 ; cg | 1 | 5.00 | 1 | NOISE 1 | 13135944253 ; bs | 1 | 5.00 | 1 | PR_ACCOUNTABILITY 1 | 13985344951 ; tj | 1 | 5.00 | 1 | PR_SIMPLE 1 | 13986024615 ; do | 1 | 5.00 | 1 | PR_GENERIC 1 | 14004181289 — no small storefront shows a material pattern of its own.

- **Where:** §6.27 table (verbatim); §6.27
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 61 storefronts, 643 reviews; it 39 (4.31, MON_PRICE 5); tr 24 (4.29, MON_FREE_LIMIT 4)
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `405627521`, `478458299`, `485881908`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

## Dated events and trends

### R76-009 — The move to a subscription broke a promise to lifetime buyers: MON_SUBSCRIPTION 40 (0.52%, mean 2.70★, 2023-05-19 → 2026-06-08, Emerging) — all 40 in E6 where they are 4.42% of 906 (Very strong within the era) and 15 of the 181 1★ in the corpus; BUG_PURCHASE 14 of 906 E6 (1.55%) vs 0.91% in E5. Three distinct complaints: lifetime buyers told they no longer have premium ('Ich hab mir die App 2015 oder so als voll Version gekauft', 1★; '之前永久内购没了？重新订阅？', 1★; 'purchased the Premium version of Way of Life as a one-time payment, not a subscription', kz 1★); new users who expected the one-time price older reviews describe ('reviews said it was a one time payment', 3★); prices differing between weeks, platforms or regions ('last week the price was $29, this week is $99', 4★). Not every veteran objects: 'grandfathered into the new system' (5★); 'no qualms about the subscription, completely worth it' (gb 5★). Support silence compounds restore failures: SUP_NONE 9 E6 — 'received no response at all' (1★).

- **Where:** §0.4; §3.3; §8.1
- **This app does:** moved one-time premium to subscription in 2023; grandfathering inconsistent
- **User reaction:** 1★-burst
- **Magnitude:** MON_SUBSCRIPTION 40 / 0.52% / mean 2.70; 4.42% of 906 E6; 15 of 181 1★; BUG_PURCHASE 1.55% E6 vs 0.91% E5; SUP_NONE 9 E6
- **Direction for us:** product-rule · **Report confidence:** Emerging (Very strong within E6) · **Generalisable:** generalisable
- **Side effects:** old reviews advertising a one-time price become a liability once the model changes
- **Conditions:** E6 (2023–2026) only
- **Review IDs:** `13889612885`, `13006973106`, `10825421057`, `13025777165`, `13811353277`, `13764730892`, `13980873344`, `13009268502`, `9942870809`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C104 Never ship a paywall or feature-removal change silently; C113 One stable, disclosed price — no discount wheels; C186 Never revoke what earlier buyers paid for when the model changes; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

### R76-012 — Two update failures account for most breakage; crash waves arrive within days: U_UPDATE_REGRESSION 84 (1.08%, mean 3.08★, Meaningful); BUG_UPDATE_BROKE 54 (0.70%, mean 2.80★) — 21 of 54 from 2012-11/12 (a release that left the app unusable or corrupted data: 'latest release has left this application unusable', 1★) and 12 from 2016-05/06 (crash on 'updating journal' at launch; reviews from mx, ru, se, au, cn and us within two days: 'идет обновление журнала, и тут же приложение вылетает'); on cn 11 reviews 2015-01-23 → 2015-01-30 report crashing immediately after buying premium ('钱扣了就开始闪退，无限闪退' — the money was taken and it started crashing, endlessly; 1★). Smaller clusters: a 2014-06 redesign some called awful and greedy (NEG_UPDATE_WORSE 17: 'new version (3.0) looks awful'), a 2017-07 release that wiped some histories ('Latest update deleted my entire history', 5★), the 2023 removal of the old Today widget (NEG_LOST_FEATURE 7: 'Any updates on when the widget will be fixed?').

- **Where:** §0.6; §3.4; §7.4
- **This app does:** several update regressions over 16 years
- **User reaction:** 1★-burst
- **Magnitude:** U_UPDATE_REGRESSION 84 / 1.08%; BUG_UPDATE_BROKE 54 / 0.70% / mean 2.80: 21 in 2012-11/12, 12 in 2016-05/06; 11 cn crash-after-purchase 2015-01-23→30; NEG_UPDATE_WORSE 17; NEG_LOST_FEATURE 7
- **Direction for us:** must-never-break · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `694264101`, `1384706437`, `1001936975`, `1677344652`, `10369119753`, `1134555630`, `478785615`, `693910077`
- **Canonical:** C031 Crashes / launch failures; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C155 Never remove a feature people bought the app for — add alongside, do not replace; C175 Updates must not break function or wipe progress

### R76-029 — Ads in the free version, removed on purchase — ad complaints 2011-11-20 → 2020-01-15 (NEG_ADS 54); ads gone from the free version by 2018 ('Now without ads even in free version', ru 5★); the last ad complaint is a 2020-01 bundle promotion shown to paying users ('Ads now constantly appear in paid version', 4★).

- **Where:** §2.3 (ads row); Warning 2
- **This app does:** ads in free tier early; removed by 2018; a promo shown to payers in 2020
- **User reaction:** complaint
- **Magnitude:** NEG_ADS 54, 2011-11-20 → 2020-01-15
- **Direction for us:** dont · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Conditions:** never show promotions to paying users
- **Review IDs:** `3004389251`, `5387293660`
- **Canonical:** C082 Ads in the free tier; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R76-034 — Subscription-era (E6, 906 reviews) segment rates diverge from the corpus: MON_SUBSCRIPTION 4.4% (0.52% overall), PR_DEV 6.7% (3.45%), PR_CHAINS 3.2% (1.66%), BUG_PURCHASE 1.5% (0.70%), SUP_NONE 1.0% (0.26%); while MON_PRICE fell to 2.0% (3.94%), MON_FREE_LIMIT 1.5% (3.22%), U_NEG_PRODUCT 3.3% (6.62%), REQ_IPAD 0.7% (1.58%), NEG_ADS 0.0%.

- **Where:** §3.1 (E6 shifts)
- **This app does:** product matured; subscription introduced
- **User reaction:** mixed
- **Magnitude:** E6 n=906; see rates
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Conditions:** E6 2023–2026
- **Review IDs:** `13889612885`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

### R76-097 — Six eras cut at dated product changes (verbatim): Era | Name | Dates | Reviews | Per month | Mean ★ | 1–2★ % | 5★ % ; E1 | Launch and paid unlock | 2010-11-08 → 2012-10-31 | 682 | 28 | 4.51 | 2.2% | 65.0% ; E2 | Growth and the Nov-2012 update | 2012-11-02 → 2014-05-31 | 1,452 | 76 | 4.55 | 2.8% | 66.5% ; E3 | Version 3, ads, China backup | 2014-06-01 → 2015-10-31 | 1,331 | 78 | 4.60 | 3.6% | 73.6% ; E4 | Chains and the podcast wave | 2015-11-01 → 2017-12-28 | 1,751 | 67 | 4.66 | 3.4% | 78.4% ; E5 | Quiet years: themes, tip jar, no ads | 2018-01-02 → 2023-04-30 | 1,642 | 26 | 4.67 | 4.5% | 82.1% ; E6 | Subscription era | 2023-05-01 → 2026-09-06 | 906 | 22 | 4.70 | 5.2% | 87.2% — E1→E2 2012-11-01 (release that broke entry; first month >140 reviews); E2→E3 2014-06-01 (v3.0 flat redesign called awful and greedy; first China Dropbox complaints 2014-07); E3→E4 2015-11-01 (chains ship; ads briefly show to paying users); E4→E5 2018-01-01 (after 2016–17 update and data-loss clusters; ads leave free tier 2018, tip jar 2018-11, themes 2019-07, Watch/widget replace iPad requests); E5→E6 2023-05-01 (first subscription objection 2023-05-19). Mean rises every era 4.51 → 4.70 while 1–2★ share also rises 2.2% → 5.2% — polarisation.

- **Where:** §7.1 table (verbatim); §7.1 bullets
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** E1 682 (4.51, 1–2★ 2.2%, 5★ 65.0%); E2 1,452 (4.55); E3 1,331 (4.60); E4 1,751 (4.66); E5 1,642 (4.67, 26/month); E6 906 (4.70, 1–2★ 5.2%, 5★ 87.2%, 22/month)
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `694264101`, `1001936975`, `1290249480`, `13889612885`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-098 — Theme movement across eras (verbatim): Theme | E1 | E2 | E3 | E4 | E5 | E6 ; U_PRAISE_ANY | 602 (88.3%) | 1254 (86.4%) | 1092 (82.0%) | 1424 (81.3%) | 1265 (77.0%) | 720 (79.5%) ; PR_SIMPLE | 137 (20.1%) | 258 (17.8%) | 226 (17.0%) | 370 (21.1%) | 337 (20.5%) | 204 (22.5%) ; PR_EASY | 129 (18.9%) | 284 (19.6%) | 235 (17.7%) | 331 (18.9%) | 245 (14.9%) | 135 (14.9%) ; PR_INSIGHTS | 76 (11.1%) | 167 (11.5%) | 147 (11.0%) | 198 (11.3%) | 157 (9.6%) | 93 (10.3%) ; PR_REMINDERS | 45 (6.6%) | 89 (6.1%) | 62 (4.7%) | 87 (5.0%) | 52 (3.2%) | 16 (1.8%) ; PR_SKIP | 8 (1.2%) | 24 (1.7%) | 26 (2.0%) | 29 (1.7%) | 7 (0.4%) | 5 (0.6%) ; PR_CHAINS | 2 (0.3%) | 3 (0.2%) | 7 (0.5%) | 56 (3.2%) | 32 (1.9%) | 29 (3.2%) ; PR_DEV | 14 (2.1%) | 27 (1.9%) | 33 (2.5%) | 46 (2.6%) | 87 (5.3%) | 61 (6.7%) ; PR_UPDATE | 24 (3.5%) | 26 (1.8%) | 55 (4.1%) | 40 (2.3%) | 64 (3.9%) | 46 (5.1%) ; PR_KEEP_SIMPLE | 1 (0.1%) | 0 (0.0%) | 0 (0.0%) | 2 (0.1%) | 32 (1.9%) | 29 (3.2%) ; PR_THEMES | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 9 (0.5%) | 5 (0.6%) ; TENURE_LONG | 7 (1.0%) | 30 (2.1%) | 55 (4.1%) | 119 (6.8%) | 145 (8.8%) | 187 (20.6%) ; U_OUTCOME | 74 (10.9%) | 136 (9.4%) | 156 (11.7%) | 282 (16.1%) | 231 (14.1%) | 118 (13.0%) ; MON_PAID | 19 (2.8%) | 63 (4.3%) | 76 (5.7%) | 97 (5.5%) | 62 (3.8%) | 32 (3.5%) ; MON_VALUE | 23 (3.4%) | 66 (4.5%) | 50 (3.8%) | 88 (5.0%) | 79 (4.8%) | 36 (4.0%) ; MON_PRICE | 39 (5.7%) | 98 (6.7%) | 86 (6.5%) | 38 (2.2%) | 27 (1.6%) | 18 (2.0%) ; MON_FREE_LIMIT | 19 (2.8%) | 60 (4.1%) | 81 (6.1%) | 39 (2.2%) | 37 (2.3%) | 14 (1.5%) ; NEG_ADS | 5 (0.7%) | 13 (0.9%) | 14 (1.1%) | 16 (0.9%) | 6 (0.4%) | 0 (0.0%) ; MON_SUBSCRIPTION | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 40 (4.4%) ; BUG_PURCHASE | 2 (0.3%) | 1 (0.1%) | 9 (0.7%) | 13 (0.7%) | 15 (0.9%) | 14 (1.5%) ; REQ_FREQUENCY | 31 (4.5%) | 37 (2.5%) | 47 (3.5%) | 48 (2.7%) | 35 (2.1%) | 16 (1.8%) ; REQ_COUNT | 20 (2.9%) | 25 (1.7%) | 30 (2.3%) | 28 (1.6%) | 19 (1.2%) | 7 (0.8%) ; REQ_SYNC | 17 (2.5%) | 40 (2.8%) | 12 (0.9%) | 26 (1.5%) | 28 (1.7%) | 16 (1.8%) ; REQ_IPAD | 32 (4.7%) | 36 (2.5%) | 9 (0.7%) | 15 (0.9%) | 25 (1.5%) | 6 (0.7%) ; REQ_WATCH | 0 (0.0%) | 0 (0.0%) | 2 (0.2%) | 12 (0.7%) | 30 (1.8%) | 10 (1.1%) ; REQ_WIDGET | 0 (0.0%) | 0 (0.0%) | 3 (0.2%) | 8 (0.5%) | 22 (1.3%) | 8 (0.9%) ; REQ_REMINDER_PER_ITEM | 6 (0.9%) | 27 (1.9%) | 7 (0.5%) | 9 (0.5%) | 2 (0.1%) | 0 (0.0%) ; BUG_UPDATE_BROKE | 1 (0.1%) | 21 (1.4%) | 4 (0.3%) | 18 (1.0%) | 4 (0.2%) | 6 (0.7%) ; BUG_DATA_LOSS | 2 (0.3%) | 5 (0.3%) | 2 (0.2%) | 13 (0.7%) | 9 (0.5%) | 7 (0.8%) ; NEG_DROPBOX_BLOCKED | 0 (0.0%) | 0 (0.0%) | 16 (1.2%) | 2 (0.1%) | 0 (0.0%) | 0 (0.0%) ; NEG_UPDATE_WORSE | 1 (0.1%) | 1 (0.1%) | 8 (0.6%) | 1 (0.1%) | 3 (0.2%) | 3 (0.3%) ; SUP_NONE | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 7 (0.4%) | 4 (0.2%) | 9 (1.0%) ; REV_SOLICITED | 1 (0.1%) | 4 (0.3%) | 2 (0.2%) | 10 (0.6%) | 1 (0.1%) | 0 (0.0%) ; MKT_PRESS | 0 (0.0%) | 1 (0.1%) | 2 (0.2%) | 26 (1.5%) | 14 (0.9%) | 8 (0.9%) ; U_DATA_RISK | 4 (0.6%) | 6 (0.4%) | 29 (2.2%) | 32 (1.8%) | 28 (1.7%) | 24 (2.6%) ; U_CHURN | 5 (0.7%) | 12 (0.8%) | 7 (0.5%) | 14 (0.8%) | 10 (0.6%) | 7 (0.8%) ; NOISE | 0 (0.0%) | 6 (0.4%) | 17 (1.3%) | 16 (0.9%) | 18 (1.1%) | 14 (1.5%)

- **Where:** §7.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** TENURE_LONG 1.0% → 20.6%; PR_DEV 2.1% → 6.7%; PR_KEEP_SIMPLE 0.1% → 3.2%; MON_PRICE 5.7/6.7/6.5 → 2.2/1.6/2.0; MON_FREE_LIMIT peak 6.1% E3 → 1.5% E6; NEG_ADS 1.1% E3 → 0.0% E6; REQ_IPAD 4.7% E1 → 0.7% E6; REQ_WATCH 0 → 1.8% E5; PR_REMINDERS 6.6% → 1.8%; PR_CHAINS 0.3% → 3.2% E4; MKT_PRESS 1.5% E4
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R76-099 — Praise for reminders fades across eras as they become table stakes: PR_REMINDERS 6.6% E1 → 6.1% E2 → 4.7% E3 → 5.0% E4 → 3.2% E5 → 1.8% E6; PR_SKIP likewise 2.0% E3 → 0.4% E5; while PR_SIMPLE holds 17.0–22.5% in every era.

- **Where:** §7.2 (praise for reminders fades)
- **This app does:** reminders present throughout
- **User reaction:** praise
- **Magnitude:** PR_REMINDERS 6.6% → 1.8%; PR_SKIP 2.0% → 0.6%; PR_SIMPLE 17.0–22.5%
- **Direction for us:** insight · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C008 Daily check-in and reminders are free — never paywall the reminder

### R76-100 — Yearly series (verbatim): Year | Reviews | Mean ★ | 1–2★ | 5★ | Price objection | Flex request | Platform request | Data risk | Burst-day reviews ; 2010 | 4 | 5.00 | 0 | 4 | 0 | 0 | 0 | 0 | 0 ; 2011 | 156 | 4.51 | 2 | 98 | 13 | 16 | 7 | 1 | 0 ; 2012 | 834 | 4.52 | 29 | 559 | 58 | 48 | 47 | 6 | 50 ; 2013 | 835 | 4.54 | 18 | 540 | 118 | 36 | 42 | 3 | 0 ; 2014 | 872 | 4.61 | 29 | 631 | 77 | 39 | 20 | 19 | 0 ; 2015 | 933 | 4.59 | 35 | 683 | 106 | 50 | 21 | 14 | 96 ; 2016 | 1202 | 4.70 | 32 | 961 | 56 | 53 | 33 | 17 | 125 ; 2017 | 380 | 4.57 | 19 | 286 | 21 | 24 | 17 | 11 | 0 ; 2018 | 322 | 4.69 | 11 | 260 | 10 | 11 | 21 | 6 | 0 ; 2019 | 329 | 4.74 | 11 | 277 | 14 | 13 | 21 | 4 | 0 ; 2020 | 399 | 4.69 | 16 | 330 | 22 | 14 | 16 | 4 | 0 ; 2021 | 234 | 4.47 | 21 | 179 | 14 | 9 | 26 | 5 | 0 ; 2022 | 181 | 4.65 | 10 | 148 | 8 | 6 | 15 | 7 | 0 ; 2023 | 237 | 4.63 | 14 | 193 | 15 | 10 | 13 | 5 | 49 ; 2024 | 216 | 4.65 | 11 | 182 | 15 | 4 | 6 | 3 | 0 ; 2025 | 251 | 4.63 | 18 | 212 | 13 | 6 | 18 | 14 | 57 ; 2026 | 379 | 4.86 | 9 | 357 | 19 | 8 | 9 | 4 | 143 || months with ≥100 reviews (verbatim): Month | Reviews | Mean ★ | 1–2★ | 5★ | Update breakage | Long-term users ; 2012-06 | 105 | 4.55 | 3 | 72 | 0 | 2 ; 2012-11 | 141 | 4.38 | 12 | 90 | 18 | 6 ; 2012-12 | 171 | 4.67 | 4 | 128 | 3 | 3 ; 2013-01 | 222 | 4.64 | 2 | 156 | 0 | 0 ; 2013-02 | 124 | 4.56 | 2 | 81 | 0 | 1 ; 2013-03 | 130 | 4.54 | 2 | 83 | 0 | 1 ; 2014-01 | 144 | 4.54 | 5 | 94 | 0 | 8 ; 2014-06 | 127 | 4.62 | 6 | 99 | 1 | 8 ; 2014-07 | 148 | 4.61 | 4 | 108 | 0 | 4 ; 2015-01 | 148 | 4.36 | 14 | 100 | 1 | 7 ; 2015-02 | 175 | 4.61 | 4 | 123 | 0 | 6 ; 2015-10 | 134 | 4.75 | 1 | 107 | 1 | 10 ; 2015-11 | 113 | 4.59 | 6 | 84 | 1 | 7 ; 2016-01 | 138 | 4.65 | 3 | 104 | 0 | 5 ; 2016-03 | 220 | 4.69 | 7 | 172 | 0 | 15 ; 2016-04 | 131 | 4.86 | 0 | 115 | 0 | 5 ; 2016-05 | 101 | 4.45 | 10 | 75 | 10 | 7 ; 2016-06 | 151 | 4.78 | 2 | 125 | 2 | 15 ; 2016-09 | 132 | 4.76 | 2 | 110 | 0 | 13 ; 2019-07 | 108 | 4.87 | 1 | 97 | 0 | 14 ; 2023-04 | 132 | 4.82 | 3 | 118 | 0 | 21 ; 2024-02 | 106 | 4.79 | 2 | 93 | 0 | 21 ; 2025-06 | 119 | 4.93 | 1 | 114 | 0 | 35 ; 2026-02 | 149 | 4.93 | 0 | 141 | 0 | 50 ; 2026-04 | 124 | 4.94 | 1 | 120 | 0 | 27 — peak year 2016 (1,202 reviews, 4.70★); volume fell to 380 in 2017 and 181 in 2022 (lowest); 2026 is the highest-rated year (4.86, 379 reviews, 143 on burst days); lowest-rated 2021 (4.47); 2012-11 (4.38, 18 breakage) and 2015-01 (4.36, 14 1–2★) are the worst months; 2026-02 the best (4.93, 0 1–2★, 50 long-term users).

- **Where:** §7.3 yearly table (verbatim); §7.3 months table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2016 peak 1,202; 2022 trough 181; 2026 4.86; 2021 4.47; 2012-11 4.38; 2015-01 4.36; 2026-02 4.93
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `694264101`, `1134555630`
- **Canonical:** C175 Updates must not break function or wipe progress; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-101 — What changed by era — E1 (682, 4.51★): small enthusiastic base, praise 88.3% (highest), asking for iPad 4.7%, frequency 4.5%, quantities 2.9%; price objection starts 5.7%. E2 (1,452, 4.55★): volume 28 → 76/month; 2012-11 release breaks entry (21 breakage reviews in two months); price objection peaks 6.7%; sync 2.8%, per-habit reminders peak 1.9%. E3 (1,331, 4.60★): flat redesign divides users (NEG_UPDATE_WORSE 8 of 17); China becomes a major source (246) and cannot back up (16); free-limit objection peaks 6.1%. E4 (1,751, 4.66★): chains ship 2015-11 and become praise 3.2%; press/podcasts bring users (26 of 51 MKT_PRESS); outcome statements peak 16.1%; rating prompt draws most REV_SOLICITED (10 of 18); 2016-05 crash wave (12). E5 (1,642, 4.67★): ads leave the free version (2020-01 bundle promo to payers draws 5 complaints); themes and tip jar arrive; requests move iPad → Watch 1.8% / widgets 1.3%; price objection lowest 1.6%; keep-it-simple appears (32). E6 (906, 4.70★): highest era mean carried by veterans (TENURE_LONG 20.6%) and developer praise 6.7%, bursts after 2025–26 updates; alongside subscription objections 4.4%, restore failures 1.5%, support silence 1.0%.

- **Where:** §7.4 E1; §7.4 E2; §7.4 E3; §7.4 E4; §7.4 E5; §7.4 E6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** see per-era figures
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `1290249480`, `1312703881`, `13889612885`, `5387293660`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C024 Streaks / gamification; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C082 Ads in the free tier

### R76-102 — Shipping chains (2015-11) turned a request into praise: PR_CHAINS 0.3% E1 → 0.5% E3 → 3.2% E4 (56 reviews) → 1.9% E5 → 3.2% E6; REQ_STREAKS fell from 18 to 3; 'Chains is going to change my life' (gb 5★).

- **Where:** §7.4 E4 (chains → praise)
- **This app does:** chains shipped 2015-11 free
- **User reaction:** praise
- **Magnitude:** PR_CHAINS 3.2% E4; REQ_STREAKS 18 → 3
- **Direction for us:** build-free · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `1290249480`
- **Canonical:** C024 Streaks / gamification

## Positioning

### R76-001 — Way of Life - Habit Tracker (App Store ID 393159800) by Way of Life ApS (com.larsparendt.wayoflife), Health & Fitness / Productivity, released 2010-11-07, current version 4.3.2 (2026-04-20), min iOS 15.6 — a daily habit journal: items ('journals') marked green (done) / red (not done) / skip per day with optional note, read as bar/pie charts, trend lines and weekly/monthly overview; items can be good or bad (colours invert); chains/streaks from late 2015; reminders, tags, CSV/Excel export, manual backup (Dropbox early), passcode/Face ID; free tier = 3 items, premium unlimited; premium was a one-time unlock for most of its history, a subscription from 2023; listing cites press incl. Tim Ferriss's podcast with Kevin Rose; declared 25 languages but not Kazakh (#7041) or Galician (#4576); public mean above corpus mean in 21 of 22 storefronts by up to 0.38 (tw). Storefront table (verbatim): Storefront | Public mean ★ | Ratings | Corpus reviews | Corpus mean ★ | Corpus mean ★ in E6 ; us | 4.82 | 5,247 | 3115 | 4.70 | 4.80 ; ru | 4.82 | 1,265 | 480 | 4.51 | 4.39 ; ca | 4.76 | 768 | 412 | 4.59 | 4.65 ; de | 4.67 | 709 | 210 | 4.60 | 4.70 ; gb | 4.72 | 681 | 415 | 4.67 | 4.80 ; jp | 4.48 | 673 | 283 | 4.45 | 4.20 ; kz | 4.88 | 561 | 50 | 4.76 | 4.67 ; au | 4.76 | 510 | 294 | 4.56 | 4.65 ; br | 4.77 | 465 | 160 | 4.49 | 4.69 ; kr | 4.69 | 374 | 282 | 4.67 | 4.92 ; fr | 4.66 | 359 | 117 | 4.61 | 4.75 ; ua | 4.87 | 334 | 54 | 4.67 | 4.21 ; se | 4.65 | 296 | 90 | 4.52 | 4.62 ; cn | 4.77 | 293 | 528 | 4.53 | 4.36 ; mx | 4.78 | 203 | 86 | 4.63 | 4.71 ; dk | 4.55 | 192 | 152 | 4.46 | 4.67 ; nl | 4.70 | 188 | 87 | 4.64 | 4.78 ; ch | 4.69 | 181 | 65 | 4.75 | 5.00 ; in | 4.69 | 177 | 61 | 4.52 | 4.33 ; es | 4.67 | 167 | 65 | 4.40 | 5.00 ; pl | 4.79 | 143 | 51 | 4.73 | 4.36 ; tw | 4.82 | 117 | 64 | 4.44 | 4.60

- **Where:** header lines 1-6; §2.1; §2.2 table (verbatim); §2.2 bullets
- **This app does:** free 3-item tier; premium one-time → subscription (2023)
- **User reaction:** mixed
- **Magnitude:** 7,764 reviews, 2010-11-08 → 2026-09-06, 83 storefronts, 27 languages (English 5,344, Chinese 538, Russian 466, Korean 263, Japanese 251, German 179, Spanish 144, Portuguese 133), corpus mean 4.62★; 5★ 5,900 (75.99%), 1–2★ 285 (3.67%)
- **Direction for us:** none · **Report confidence:** header · **Generalisable:** app-specific
- **Conditions:** sixteen-year corpus spanning several product eras
- **Review IDs:** `7243490138`, `13775690190`
- **Canonical:** C134 Lead the store listing with what users actually love; C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal

### R76-060 — Churn, switching and competition (verbatim): Code | Dir | Meaning | n | % of 7,764 | Band | Mean ★ | Dates ; CHURN_RETURN | + | Came back | 60 | 0.77% | Emerging signal | 4.95 | 2012-11-22 → 2026-06-20 ; CHURN_RISK | - | May stop using | 26 | 0.33% | Weak signal | 3.31 | 2011-11-28 → 2025-07-08 ; CHURN_DELETE | - | Deleted | 18 | 0.23% | Weak signal | 1.78 | 2012-03-02 → 2025-06-23 ; CHURN_SWITCHED | - | Switched away | 12 | 0.15% | Weak signal | 2.75 | 2012-03-02 → 2025-12-26 ; COMP_MENTION | ~ | Names a competitor | 113 | 1.46% | Meaningful signal | 4.29 | 2010-12-07 → 2026-04-26 ; MKT_PRESS | ~ | Press, podcast or book | 51 | 0.66% | Emerging signal | 4.94 | 2014-01-13 → 2026-02-23 ; MKT_WOM | ~ | Word of mouth | 28 | 0.36% | Weak signal | 4.82 | 2012-01-28 → 2026-04-21 ; MKT_REVIEWS | ~ | App Store reviews | 2 | 0.03% | Ignore by default | 5.00 | 2013-01-24 → 2016-09-24 ; MKT_SEARCH | ~ | Search | 1 | 0.01% | Ignore by default | 5.00 | 2011-07-05 → 2011-07-05 — returning users are reported alongside leavers: CHURN_RETURN 60 vs U_CHURN 55; leavers name data loss, price or the subscription; returners name the simplicity after trying heavier apps: 'I just always end up coming back to the simplicity of Way of Life' (gb 5★); COMP_MENTION 113 (1.46%).

- **Where:** §3.7 table (verbatim); §3.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** CHURN_RETURN 60 (0.77%, 4.95); CHURN_RISK 26; CHURN_DELETE 18 (1.78); CHURN_SWITCHED 12; COMP_MENTION 113 (1.46%); MKT_PRESS 51; MKT_WOM 28
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `13984329659`
- **Canonical:** C005 Know which competitors buyers compare against; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

## Anti-patterns

### R76-114 — Switching a 13-year-old one-time unlock to a subscription without a visible, automatic grandfather path: lifetime buyers from 2015 told to subscribe again ('Ich hab mir die App 2015 oder so als voll Version gekauft', 1★; '之前永久内购没了？重新订阅？', 1★), new users misled by a decade of reviews that say 'one time payment', and a price seen at $29 one week and $99 the next — cost: MON_SUBSCRIPTION 40 at mean 2.70★ = 15 of 181 corpus 1★, restore failures up 0.91% → 1.55%, support silence 9 in E6; some were grandfathered ('grandfathered into the new system', 5★) so the path existed but was not reliable.

- **Where:** §0.4; §2.4; §8.1; §7.4 E6
- **This app does:** subscription switch 2023 with inconsistent grandfathering
- **User reaction:** 1★-burst
- **Magnitude:** MON_SUBSCRIPTION 40 / 2.70★ / 4.42% of E6; 15 of 181 1★; BUG_PURCHASE E6 1.55%
- **Direction for us:** dont · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Side effects:** old reviews advertising the one-time price keep recruiting users who then feel misled
- **Review IDs:** `13889612885`, `13811353277`, `10825421057`, `13025777165`, `13764730892`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently; C186 Never revoke what earlier buyers paid for when the model changes; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

### R76-115 — Showing promotions to paying users: after the 2015-11 update ads briefly appeared for people who had paid ('Ads when already paid', 2★), and a 2020-01 bundle promotion shown to paying users drew 5 complaints ('Ads now constantly appear in paid version', 4★) — the last ad complaints in the corpus come from payers, not free users.

- **Where:** §2.3 ads row; §3.3; §7.4 E5
- **This app does:** promo/bundle ads shown to premium users
- **User reaction:** complaint
- **Magnitude:** NEG_ADS 54 total; 2020-01 promo 5 complaints; 2015-11 payers saw ads
- **Direction for us:** dont · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `1289364973`, `5387293660`
- **Canonical:** C082 Ads in the free tier; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps

## Things not to do

### R76-008 — The three-item limit was not always clear before download: MON_DISCLOSURE 33 (0.43%) — 'not particularly clear in the iTunes store that the free app allows for only three categories' (#415, us, 2★).

- **Where:** §0.3 (disclosure); §5.5
- **This app does:** cap not disclosed in listing
- **User reaction:** complaint
- **Magnitude:** MON_DISCLOSURE 33 / 0.43% / Weak
- **Direction for us:** dont · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `600217716`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C236 A free-tier limit must announce itself before the user invests — at install, at setup and at the wall — never silently stop a visible progress signal

### R76-016 — Rating prompts annoy and are badly timed: 'Quit bugging me with review me review me crap' (#1338, us, 1★); 'app solicited a review 3 days in, after I paid for the premium version' (#3668, us, 4★) — §8.7 prompt less, and never right after a purchase.

- **Where:** §0.8 (prompt backlash); §8.7
- **This app does:** prompts for a rating soon after purchase
- **User reaction:** complaint
- **Magnitude:** REV_SOLICITED 18; two quoted objections
- **Direction for us:** dont · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `760754071`, `1313359649`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

### R76-045 — Paying twice across devices or accounts: MON_PAID_TWICE 3 — 'you have to pay for each iPhone or iPad you use' (#1212, us, 1★); MON_FAMILY_SHARING 3 (family sharing / gifting).

- **Where:** §3.3 (paid twice)
- **This app does:** no universal purchase across devices in early years
- **User reaction:** complaint
- **Magnitude:** MON_PAID_TWICE 3 / 3.00; MON_FAMILY_SHARING 3
- **Direction for us:** dont · **Report confidence:** Ignore by default · **Generalisable:** generalisable
- **Review IDs:** `741004355`
- **Canonical:** C037 Family plan; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R76-053 — Badge nags and notification annoyance: NEG_BADGE 13 (4.38★), NEG_NOTIF 11 (2.27★), NEG_FORGET 14 'forgets to log' (4.14★) — the reminder that nags and the one that is missed sit side by side.

- **Where:** §3.5 (badge/notif nags)
- **This app does:** badge count and reminders
- **User reaction:** complaint
- **Magnitude:** NEG_BADGE 13; NEG_NOTIF 11 / 2.27; NEG_FORGET 14
- **Direction for us:** dont · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C123 Notifications are few and finely user-controllable — per-type settings, escalation opt-in, never spammy and never silently retuned; C226 App-icon badge count of outstanding habits, with an active-hours window

### R76-064 — Promised features that never came are remembered for a decade: NEG_DEV_PROMISE 6 (2013-10-20 → 2026-03-21); a 2016 reviewer 'Can't wait for the promised weekly/monthly options' — still absent in 2026.

- **Where:** §3.8 (broken promise)
- **This app does:** promised flexible frequency, never shipped
- **User reaction:** complaint
- **Magnitude:** NEG_DEV_PROMISE 6; REQ_FREQUENCY 15 of 16 years
- **Direction for us:** dont · **Report confidence:** Ignore by default · **Generalisable:** generalisable
- **Review IDs:** `1364445247`
- **Canonical:** C043 Flexible / custom frequency; C071 Never ship and walk away

### R76-079 — Discount only in the first days after install penalises evaluators: 'only offer a reduced price in the first days after installation' (#6304, br, 5★); MON_SALE 3.

- **Where:** §5.5 (discount timing)
- **This app does:** intro discount window
- **User reaction:** complaint
- **Magnitude:** n=1 quoted; MON_SALE 3
- **Direction for us:** dont · **Report confidence:** Ignore by default · **Generalisable:** generalisable
- **Review IDs:** `7054076524`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised; C113 One stable, disclosed price — no discount wheels

### R76-111 — §8.7 experiment — prompt less, and never right after a purchase: suppress the rating prompt for 30 days after a purchase or a crash-free launch following a failure (REV_SOLICITED 18; #3668) — hypothesis: fewer resentful reviews with no loss of 5★ volume from veterans.

- **Where:** §8.7; part 8 #7
- **This app does:** prompts soon after purchase
- **User reaction:** complaint
- **Magnitude:** REV_SOLICITED 18
- **Direction for us:** dont · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `1313359649`, `760754071`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

## Things to do

### R76-116 — Answer fast and fix fast — it converts 1★ back to 5★: through 2016 support was praised for speed ('developer emailed me back in less than 5 minutes'; 'innerhalb von einem Tag gelöst'); PR_SUPPORT 68 (4.79★) and REV_UPDATED 74 include reviewers who returned to raise their stars after a regression was fixed ('Has been fixed - good response', 5★); gb over-indexes on support praise 2.75×.

- **Where:** §0.6 (fast fixes); §3.8; §6.6
- **This app does:** fast personal support in early eras
- **User reaction:** praise
- **Magnitude:** PR_SUPPORT 68 / 0.88% / 4.79; REV_UPDATED 74
- **Direction for us:** do · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `504207844`, `1390768771`, `719847792`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R76-117 — Cite earned press in the listing and let it compound: the listing names Tim Ferriss's podcast with Kevin Rose; reviewers cite the same source for a decade (MKT_PRESS 51, 4.94★, 26 in E4) and some convert on it the same day ('Used for one day then upgraded to the paid'); local figures do the same job in ru/kz (Margulan Seisembay).

- **Where:** §2.2 bullets (press); §3.7; §5.2 #4
- **This app does:** listing cites press
- **User reaction:** purchase-driver
- **Magnitude:** MKT_PRESS 51 / 0.66% / 4.94; 6 purchasers cite press
- **Direction for us:** do · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `1312703881`, `5583547111`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C134 Lead the store listing with what users actually love; C225 A one-off free promotion (App of the Week, partner promo) acquires durable users

## Contradictions

### R76-050 — The 'simple' app is confusing on first use: NEG_UI_CONFUSING 81 (1.04%, mean 3.36★) + NEG_LEARNING_CURVE 17 (mean 4.65★) beside PR_ONBOARDING 48 praising the tutorial — a long tutorial is tolerated when it pays off ('excelente porém extenso tutorial').

- **Where:** §3.5 (learning curve)
- **This app does:** interactive walkthrough
- **User reaction:** mixed
- **Magnitude:** NEG_UI_CONFUSING 81 / 1.04% / 3.36; NEG_LEARNING_CURVE 17 / 4.65; PR_ONBOARDING 48; NEG_ONBOARDING 6
- **Direction for us:** do · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `1532756806`
- **Canonical:** C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R76-051 — Too basic for some: NEG_SIMPLE 43 (0.55%, mean 2.98★) and NEG_POINTLESS 15 (2.53★) — 'I can do the same with a simple tally sheet' (de 2★) — against PR_SIMPLE 1532; simplicity is the main value and the main reason a minority leave.

- **Where:** §3.5 (too basic)
- **This app does:** minimal feature set
- **User reaction:** churn
- **Magnitude:** NEG_SIMPLE 43 / 0.55% / 2.98; NEG_POINTLESS 15 / 2.53 vs PR_SIMPLE 1532
- **Direction for us:** none · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `1481286486`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek; C214 A bare checklist or task-slot paywall cannot carry a premium price — it is compared to Reminders, Notes, alarms and paper, free on every phone, and loses

### R76-076 — The three-item cap is a feature for some non-buyers: 'forced me to prioritize the three most important tasks by paywalling more than 3' (#7013, us, 5★); 'I actually think three habits is enough' (se 5★); cn: 'the free version's limit of three habits is actually better' — against MON_FREE_LIMIT 250 who call it too low.

- **Where:** §5.5 (cap as feature)
- **This app does:** 3-item free cap
- **User reaction:** mixed
- **Magnitude:** PR_FREE 249 (4.72★) vs MON_FREE_LIMIT 250 (3.53★)
- **Direction for us:** undecided · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Review IDs:** `10969791376`, `5995182767`, `1399309366`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

## Data caveats and method

### R76-002 — Method and limits: every one of 7,764 reviews read and hand-coded in date order in batches of 100 (78 classification files), each line quoting the text behind its codes; 223 hand codes, 15 unions; 1,286 checks, 0 failures; build script refuses to write if any quotation is not verbatim; no technical duplicates (0), 26 authors on >1 storefront, 163 edited, 202 with votes (max 20). Warnings: praise corpus (any-praise 81.88%, 1–2★ 3.67%, so a Meaningful complaint is dozens not hundreds); sixteen years / several products (E6 subscription era only 906 reviews); 1,777 bodies (22.89%) ≤30 chars; NOISE 71; no version, purchase, developer-response or device fields; survivorship (E6 over-represents long-term users, TENURE_LONG ~a fifth of E6); English 5,344 vs 2,420 in 26 other languages. Signal bands (verbatim): Share of reviews | Label ; < 0.1% | Ignore by default ; 0.1% – < 0.5% | Weak signal ; 0.5% – < 1% | Emerging signal ; 1% – < 3% | Meaningful signal ; 3% – 5% | Very strong signal ; > 5% | High-priority signal

- **Where:** How to read this; Seven warnings 1, 2, 4, 7; §1.1 table (verbatim); §1.2 table (verbatim); §1.3; §1.4; §1.5 table (verbatim); §1.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 7,764/7,764 read (100%); 223 codes; 1,286 checks; 0.1% ≈ 8 reviews, 1% ≈ 78, 5% ≈ 388
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-015 — Five-star bursts follow updates and rating prompts; they are not a campaign: 20 days carry 20+ reviews — 2026-04-22 (41), 2015-02-08 (34), 2025-06-05 (32), 2016-03-02 (30), 2026-02-20 (30), 2023-04-04 (29), 2012-11-19 (28), 2016-03-18 (28) and 12 more — 520 reviews (6.70%), 86.15% 5★; REV_SOLICITED 18 (0.23%, mean 4.06★, 2012-08-16 → 2018-12-09, 7 between 2015-10 and 2016-03): 'they requested that I provide a review'; the 2025–2026 bursts lean to long-term users (TENURE_LONG 65 of 200 burst reviews). No campaign marks: no generated-looking names, 2 duplicate-body groups (5 short generic reviews), 26 cross-storefront authors who are long-term users reviewing years apart; §7.6 shows the headlines hold without burst days.

- **Where:** Warning 3; §0.8; §1.6; §7.6
- **This app does:** in-app rating prompts after updates
- **User reaction:** 5★-burst
- **Magnitude:** 20 days ≥20 reviews = 520 (6.70%), 86.15% 5★; REV_SOLICITED 18 / 0.23%; TENURE_LONG 65 of 200 burst reviews 2025–26
- **Direction for us:** none · **Report confidence:** Weak · **Generalisable:** generalisable
- **Review IDs:** `1341572559`, `693544347`, `1143627439`, `1263625007`, `1341728315`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-032 — What could not be established: the date premium became a subscription and whether lifetime buyers were migrated automatically; current prices by region (one reviewer saw $29 then $99 in consecutive weeks of 2025); whether 2025–2026 rating prompts were in-app requests or release-note appeals; how many users ever lost data.

- **Where:** §2.4
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `13025777165`
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

### R76-033 — Prioritised theme table with E6 segment rates (verbatim): Rank | Theme | Dir | n | % of 7,764 | Band | Mean ★ | Dates | n in E6 | % of E6 ; 1 | U_PRAISE_ANY Any praise code | + | 6357 | 81.88% | High-priority signal | 4.80 | 2010-11-08 → 2026-09-06 | 720 | 79.5% ; 2 | U_SIMPLICITY Simplicity as the value | + | 1682 | 21.66% | High-priority signal | 4.83 | 2010-11-21 → 2026-09-02 | 232 | 25.6% ; 3 | U_REQ_ANY Any request | ~ | 1080 | 13.91% | High-priority signal | 4.18 | 2010-11-21 → 2026-07-13 | 88 | 9.7% ; 4 | U_OUTCOME Any positive outcome | + | 997 | 12.84% | High-priority signal | 4.89 | 2011-05-25 → 2026-09-02 | 118 | 13.0% ; 5 | PR_INSIGHTS Charts, trends, overview | + | 838 | 10.79% | High-priority signal | 4.80 | 2011-01-13 → 2026-05-29 | 93 | 10.3% ; 6 | U_UPGRADE_SIGNAL Paid, intends to pay, or says it is worth it | + | 732 | 9.43% | High-priority signal | 4.58 | 2011-04-29 → 2026-06-20 | 72 | 7.9% ; 7 | PR_DESIGN Design and interface | + | 602 | 7.75% | High-priority signal | 4.78 | 2010-11-21 → 2026-08-09 | 63 | 7.0% ; 8 | U_PRICE_OBJECTION Price, paywall or free-limit objection | − | 579 | 7.46% | High-priority signal | 3.58 | 2011-05-21 → 2026-07-14 | 57 | 6.3% ; 9 | U_NEG_PRODUCT Any product-quality negative | − | 514 | 6.62% | High-priority signal | 3.60 | 2011-01-13 → 2026-04-22 | 30 | 3.3% ; 10 | PR_MOTIVATION Motivating | + | 509 | 6.56% | High-priority signal | 4.85 | 2010-11-21 → 2026-08-17 | 43 | 4.7% ; 11 | PR_ACCOUNTABILITY Accountability and discipline | + | 477 | 6.14% | High-priority signal | 4.86 | 2010-11-08 → 2026-09-02 | 39 | 4.3% ; 12 | PR_BETTER_THAN Better than alternatives | + | 428 | 5.51% | High-priority signal | 4.86 | 2010-12-07 → 2026-08-17 | 49 | 5.4% ; 13 | U_FLEX_REQ Wants beyond daily yes/no | ~ | 347 | 4.47% | Very strong signal | 4.13 | 2011-08-14 → 2026-06-03 | 24 | 2.6% ; 14 | U_PLATFORM_REQ Wants other platforms or sync | ~ | 332 | 4.28% | Very strong signal | 4.14 | 2011-05-21 → 2026-06-20 | 40 | 4.4% ; 15 | MON_PRICE Too expensive | − | 306 | 3.94% | Very strong signal | 3.71 | 2011-06-04 → 2026-05-07 | 18 | 2.0% ; 16 | PR_DEV Thanks the developer | + | 268 | 3.45% | Very strong signal | 4.96 | 2011-01-13 → 2026-06-04 | 61 | 6.7% ; 17 | U_BUG_ANY Any defect | − | 257 | 3.31% | Very strong signal | 2.99 | 2011-10-21 → 2026-06-18 | 38 | 4.2% ; 18 | MON_FREE_LIMIT Free limit (3 items) too low | − | 250 | 3.22% | Very strong signal | 3.53 | 2011-05-21 → 2026-07-14 | 14 | 1.5% ; 19 | REQ_FREQUENCY Weekly / specific-day frequency | ~ | 214 | 2.76% | Meaningful signal | 4.09 | 2011-08-14 → 2026-06-03 | 16 | 1.8% ; 20 | REQ_SYNC Sync across devices / iCloud | ~ | 139 | 1.79% | Meaningful signal | 4.01 | 2012-01-07 → 2026-05-07 | 16 | 1.8% ; 21 | PR_CHAINS Chains and streaks | + | 129 | 1.66% | Meaningful signal | 4.89 | 2012-06-20 → 2026-04-27 | 29 | 3.2% ; 22 | U_DATA_RISK Data loss, backup or restore problem | − | 123 | 1.58% | Meaningful signal | 3.04 | 2011-12-11 → 2026-06-18 | 24 | 2.6% ; 23 | REQ_IPAD iPad version | ~ | 123 | 1.58% | Meaningful signal | 4.10 | 2011-05-21 → 2026-05-07 | 6 | 0.7% ; 24 | U_UPDATE_REGRESSION An update broke or worsened something | − | 84 | 1.08% | Meaningful signal | 3.08 | 2011-11-05 → 2026-02-22 | 9 | 1.0% ; 25 | NEG_UI_CONFUSING Confusing / hard to use | − | 81 | 1.04% | Meaningful signal | 3.36 | 2012-05-02 → 2026-04-22 | 8 | 0.9% ; 26 | PR_SUPPORT Support responsive | + | 68 | 0.88% | Emerging signal | 4.79 | 2011-01-23 → 2026-03-23 | 5 | 0.6% ; 27 | U_CHURN States leaving | − | 55 | 0.71% | Emerging signal | 2.69 | 2011-11-28 → 2025-12-26 | 7 | 0.8% ; 28 | NEG_ADS Ads | − | 54 | 0.70% | Emerging signal | 3.06 | 2011-11-20 → 2020-01-15 | 0 | 0.0% ; 29 | BUG_PURCHASE Purchase not restored / not credited | − | 54 | 0.70% | Emerging signal | 2.69 | 2011-12-11 → 2026-06-18 | 14 | 1.5% ; 30 | REQ_WATCH Apple Watch app | ~ | 54 | 0.70% | Emerging signal | 4.30 | 2015-08-15 → 2026-06-20 | 10 | 1.1% ; 31 | MON_SUBSCRIPTION Subscription model objection | − | 40 | 0.52% | Emerging signal | 2.70 | 2023-05-19 → 2026-06-08 | 40 | 4.4% ; 32 | SUP_NONE Support did not reply | − | 20 | 0.26% | Weak signal | 2.05 | 2016-03-18 → 2026-01-23 | 9 | 1.0% — praise and a price objection share 304 reviews (3.92%): 'great app, too expensive / three items is too few' is the typical 3–4★ review; negatives outside monetization U_NEG_PRODUCT 514 + U_BUG_ANY 257 touch 732 (9.43%).

- **Where:** §3.1 table (verbatim); §3.1
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 32 ranked themes; praise∩price 304 (3.92%); non-money negatives 732 (9.43%)
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-065 — Rating distribution with E6 and body length (verbatim): ★ | Reviews | % of 7,764 | In E6 | % of E6 | Mean body length (chars) ; 5 | 5,900 | 75.99% | 790 | 87.20% | 121 ; 4 | 1,281 | 16.50% | 48 | 5.30% | 150 ; 3 | 298 | 3.84% | 21 | 2.32% | 186 ; 2 | 104 | 1.34% | 8 | 0.88% | 185 ; 1 | 181 | 2.33% | 39 | 4.30% | 148 ; mean | 4.62 |  | 4.70 |  | — 5★ 75.99%, 1–2★ 3.67%; E6 mean 4.70 vs 4.62 overall, with 1★ 4.30% of E6 vs 2.33% overall (polarised); 3★ reviews are the longest (186 chars): they argue a case, usually price or a missing capability.

- **Where:** §4.1 table (verbatim); §4.1
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★ 5,900 (75.99%), 4★ 1,281, 3★ 298, 2★ 104, 1★ 181; E6 5★ 87.20%, 1★ 4.30%; mean 4.62 / E6 4.70
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-066 — Themes by star band (verbatim) — 5★: Code | Meaning | n | % of 5★ reviews | Segment band | % of all 7,764 ; PR_SIMPLE | Simple / minimal | 1300 | 22.03% | High-priority signal | 19.73% ; PR_EASY | Easy / intuitive | 1137 | 19.27% | High-priority signal | 17.50% ; PR_GENERIC | General praise | 900 | 15.25% | High-priority signal | 14.23% ; PR_INSIGHTS | Charts, trends, overview | 689 | 11.68% | High-priority signal | 10.79% ; PR_BEST | Best / favourite | 501 | 8.49% | High-priority signal | 7.06% ; PR_DESIGN | Design and interface | 498 | 8.44% | High-priority signal | 7.75% ; TENURE_LONG | Long-term user | 483 | 8.19% | High-priority signal | 6.99% ; PR_RECOMMEND | Recommends it | 473 | 8.02% | High-priority signal | 6.48% ; OUT_HABIT | Built or broke habits | 458 | 7.76% | High-priority signal | 6.66% ; PR_MOTIVATION | Motivating | 442 | 7.49% | High-priority signal | 6.56% ; PR_ACCOUNTABILITY | Accountability and discipline | 413 | 7.00% | High-priority signal | 6.14% ; PR_BETTER_THAN | Better than alternatives | 374 | 6.34% | High-priority signal | 5.51% || 4★: Code | Meaning | n | % of 4★ reviews | Segment band | % of all 7,764 ; PR_SIMPLE | Simple / minimal | 210 | 16.39% | High-priority signal | 19.73% ; PR_EASY | Easy / intuitive | 206 | 16.08% | High-priority signal | 17.50% ; PR_GENERIC | General praise | 182 | 14.21% | High-priority signal | 14.23% ; PR_INSIGHTS | Charts, trends, overview | 136 | 10.62% | High-priority signal | 10.79% ; MON_PRICE | Too expensive | 100 | 7.81% | High-priority signal | 3.94% ; REQ_FREQUENCY | Weekly / specific-day frequency | 96 | 7.49% | High-priority signal | 2.76% ; PR_DESIGN | Design and interface | 83 | 6.48% | High-priority signal | 7.75% ; MON_FREE_LIMIT | Free limit (3 items) too low | 81 | 6.32% | High-priority signal | 3.22% ; MON_PAID | States a purchase | 68 | 5.31% | High-priority signal | 4.50% ; PR_ACCOUNTABILITY | Accountability and discipline | 62 | 4.84% | Very strong signal | 6.14% ; REQ_SYNC | Sync across devices / iCloud | 62 | 4.84% | Very strong signal | 1.79% ; PR_TRACKING | Habit tracking | 60 | 4.68% | Very strong signal | 4.66% || 3★: Code | Meaning | n | % of 3★ reviews | Segment band | % of all 7,764 ; MON_PRICE | Too expensive | 70 | 23.49% | High-priority signal | 3.94% ; MON_FREE_LIMIT | Free limit (3 items) too low | 36 | 12.08% | High-priority signal | 3.22% ; REQ_FREQUENCY | Weekly / specific-day frequency | 27 | 9.06% | High-priority signal | 2.76% ; REQ_SYNC | Sync across devices / iCloud | 23 | 7.72% | High-priority signal | 1.79% ; PR_GENERIC | General praise | 22 | 7.38% | High-priority signal | 14.23% ; PR_SIMPLE | Simple / minimal | 20 | 6.71% | High-priority signal | 19.73% ; REQ_IPAD | iPad version | 18 | 6.04% | High-priority signal | 1.58% ; REQ_COUNT | Counts / quantities | 18 | 6.04% | High-priority signal | 1.66% ; NEG_SIMPLE | Too basic | 16 | 5.37% | High-priority signal | 0.55% ; PR_EASY | Easy / intuitive | 15 | 5.03% | High-priority signal | 17.50% ; MON_PAID | States a purchase | 15 | 5.03% | High-priority signal | 4.50% ; NEG_ADS | Ads | 15 | 5.03% | High-priority signal | 0.70% || 2★: Code | Meaning | n | % of 2★ reviews | Segment band | % of all 7,764 ; MON_FREE_LIMIT | Free limit (3 items) too low | 26 | 25.00% | High-priority signal | 3.22% ; MON_PRICE | Too expensive | 22 | 21.15% | High-priority signal | 3.94% ; NEG_UI_CONFUSING | Confusing / hard to use | 13 | 12.50% | High-priority signal | 1.04% ; MON_PAID | States a purchase | 10 | 9.62% | High-priority signal | 4.50% ; MON_DISCLOSURE | Price or limit not clear upfront | 7 | 6.73% | High-priority signal | 0.43% ; BUG_CRASH | Crashes | 7 | 6.73% | High-priority signal | 0.50% ; REQ_FREQUENCY | Weekly / specific-day frequency | 7 | 6.73% | High-priority signal | 2.76% ; MON_PAYWALL | Features behind paywall | 7 | 6.73% | High-priority signal | 0.28% ; PR_DESIGN | Design and interface | 6 | 5.77% | High-priority signal | 7.75% ; BUG_UPDATE_BROKE | Update broke the app | 6 | 5.77% | High-priority signal | 0.70% ; NEG_SIMPLE | Too basic | 6 | 5.77% | High-priority signal | 0.55% ; MON_WONT_PAY | Won't pay | 6 | 5.77% | High-priority signal | 0.71% || 1★: Code | Meaning | n | % of 1★ reviews | Segment band | % of all 7,764 ; MON_FREE_LIMIT | Free limit (3 items) too low | 34 | 18.78% | High-priority signal | 3.22% ; MON_PAID | States a purchase | 30 | 16.57% | High-priority signal | 4.50% ; MON_PRICE | Too expensive | 22 | 12.15% | High-priority signal | 3.94% ; BUG_PURCHASE | Purchase not restored / not credited | 21 | 11.60% | High-priority signal | 0.70% ; BUG_CRASH | Crashes | 19 | 10.50% | High-priority signal | 0.50% ; BUG_UPDATE_BROKE | Update broke the app | 19 | 10.50% | High-priority signal | 0.70% ; MON_SUBSCRIPTION | Subscription model objection | 15 | 8.29% | High-priority signal | 0.52% ; MON_DISCLOSURE | Price or limit not clear upfront | 14 | 7.73% | High-priority signal | 0.43% ; NEG_ADS | Ads | 13 | 7.18% | High-priority signal | 0.70% ; MON_REGRET | Regrets buying | 13 | 7.18% | High-priority signal | 0.27% ; BUG_DATA_LOSS | Data lost | 12 | 6.63% | High-priority signal | 0.49% ; SUP_NONE | Support did not reply | 11 | 6.08% | High-priority signal | 0.26% — Reading: 5★ are simplicity, ease and charts; 4★ the same praise with one missing thing — frequency (96), price (100), the free limit (81) or sync (62); 3★ led by price (70 of 298); 2★ the free limit and confusion; 1★ purchases gone wrong (MON_PAID 30, BUG_PURCHASE 21, MON_SUBSCRIPTION 15), update crashes (BUG_UPDATE_BROKE 19) and the free limit (34).

- **Where:** §4.2 5★ table (verbatim); §4.2 4★ table (verbatim); §4.2 3★ table (verbatim); §4.2 2★ table (verbatim); §4.2 1★ table (verbatim); §4.2 Reading
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 1★: MON_FREE_LIMIT 18.78%, MON_PAID 16.57%, BUG_PURCHASE 11.60%, BUG_CRASH 10.50%, BUG_UPDATE_BROKE 10.50%, MON_SUBSCRIPTION 8.29%, MON_DISCLOSURE 7.73%; 3★: MON_PRICE 23.49%; 2★: MON_FREE_LIMIT 25.00%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-068 — Rating-versus-text contradictions: CONTRA_RATING 47 (0.61%) — 29 are 4–5★ whose text reports a problem (BUG_UPDATE_BROKE 6, BUG_DATA_LOSS 6, TENURE_LONG 4, MON_PRICE 4: 'DO NOT BUY UNTIL ITS FIXED', 4★; 'it should have been free', in 5★); 7 are 1–2★ whose text is praise ('I absolutely love this app', au 1★); the rest 3★; all kept and coded by text.

- **Where:** §4.3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** CONTRA_RATING 47 / 0.61%: 29 high-star-negative, 7 low-star-positive
- **Direction for us:** none · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `694696960`, `7995883622`, `13984571428`, `588079580`, `1488838993`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-069 — Paid populations and what they are not: MON_PAID 349 (4.50%, mean 4.29★); U_PAID (purchase, refund or restore problem) 388 (5.00%, 4.15★); MON_INTENT 93 (1.20%, 4.65★); MON_VALUE not in MON_PAID 278; U_PRICE_OBJECTION 579 (7.46%, 3.58★) — none is a conversion rate; cannot claim the share who buy, how many lifetime buyers lost access 2023–2026, whether regional prices differ or whether $29/$99 are monthly, annual or lifetime, or whether refunds were granted.

- **Where:** §5.1; §5.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** MON_PAID 349 / 4.50%; U_PAID 388 / 5.00%; MON_INTENT 93; MON_VALUE-only 278
- **Direction for us:** none · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Review IDs:** `1346355361`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-072 — Segment rates among 349 purchasers (verbatim): Theme | n in segment | % of segment | % of all 7,764 | Lift ; MON_VALUE | 64 | 18.3% | 4.4% | 4.16× ; PR_EASY | 61 | 17.5% | 17.5% | 1.00× ; PR_SIMPLE | 55 | 15.8% | 19.7% | 0.80× ; PR_INSIGHTS | 50 | 14.3% | 10.8% | 1.33× ; TENURE_LONG | 35 | 10.0% | 7.0% | 1.43× ; PR_BETTER_THAN | 28 | 8.0% | 5.5% | 1.46× ; MON_PRICE | 28 | 8.0% | 3.9% | 2.04× ; PR_DESIGN | 26 | 7.4% | 7.8% | 0.96× ; PR_FREE | 26 | 7.4% | 3.2% | 2.32× ; PR_MOTIVATION | 25 | 7.2% | 6.6% | 1.09× ; PR_RECOMMEND | 23 | 6.6% | 6.5% | 1.02× ; REQ_FREQUENCY | 23 | 6.6% | 2.8% | 2.39× ; BUG_PURCHASE | 23 | 6.6% | 0.7% | 9.48× ; PR_ACCOUNTABILITY | 21 | 6.0% | 6.1% | 0.98× ; PR_BEST | 21 | 6.0% | 7.1% | 0.85× ; MON_BUY_ITEMS | 20 | 5.7% | 0.3% | 16.48× ; OUT_HABIT | 20 | 5.7% | 6.7% | 0.86× ; PR_UPDATE | 20 | 5.7% | 3.3% | 1.74× ; PR_REMINDERS | 19 | 5.4% | 4.5% | 1.20× ; REQ_SYNC | 17 | 4.9% | 1.8% | 2.72× ; NEG_ADS | 16 | 4.6% | 0.7% | 6.59× ; PR_CUSTOM | 13 | 3.7% | 2.7% | 1.40× ; OUT_AWARENESS | 12 | 3.4% | 2.3% | 1.47× ; JUST_STARTED | 12 | 3.4% | 2.1% | 1.63× ; PR_NOTES | 12 | 3.4% | 2.2% | 1.53× ; COMP_MENTION | 11 | 3.2% | 1.5% | 2.17× ; MON_REGRET | 11 | 3.2% | 0.3% | 11.65× ; PR_PERF | 10 | 2.9% | 2.4% | 1.20× ; PR_DEV | 10 | 2.9% | 3.5% | 0.83× — highest lifts: MON_BUY_ITEMS 16.48×, MON_REGRET 11.65×, BUG_PURCHASE 9.48×, NEG_ADS 6.59×, MON_VALUE 4.16×, REQ_SYNC 2.72×, REQ_FREQUENCY 2.39×, PR_FREE 2.32×, COMP_MENTION 2.17×, MON_PRICE 2.04×.

- **Where:** §5.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** MON_VALUE 18.3% (4.16×); BUG_PURCHASE 6.6% (9.48×); REQ_FREQUENCY 6.6% (2.39×); REQ_SYNC 4.9% (2.72×); NEG_ADS 4.6% (6.59×); MON_REGRET 3.2% (11.65×)
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `1346355361`
- **Canonical:** C133 Gate on capability, not on quantity; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R76-104 — Sensitivity (verbatim): Headline share | All 7,764 | Without burst days (7,244) | Without E6 (6,858) | E6 only (906) ; U_PRAISE_ANY | 81.9% | 81.6% | 82.2% | 79.5% ; U_SIMPLICITY | 21.7% | 21.2% | 21.1% | 25.6% ; PR_INSIGHTS | 10.8% | 10.5% | 10.9% | 10.3% ; U_FLEX_REQ | 4.5% | 4.4% | 4.7% | 2.6% ; U_PRICE_OBJECTION | 7.5% | 7.7% | 7.6% | 6.3% ; U_PLATFORM_REQ | 4.3% | 4.3% | 4.3% | 4.4% ; U_DATA_RISK | 1.6% | 1.6% | 1.4% | 2.6% ; U_UPDATE_REGRESSION | 1.1% | 1.1% | 1.1% | 1.0% ; MON_SUBSCRIPTION | 0.5% | 0.6% | 0.0% | 4.4% ; MON_VALUE | 4.4% | 4.4% | 4.5% | 4.0% ; U_CHURN | 0.7% | 0.8% | 0.7% | 0.8% ; mean ★ | 4.62 | 4.61 | 4.61 | 4.70 — removing the 20 burst days (520 reviews) moves no headline by more than 0.4 points; the subscription objection exists only in E6 by construction; every other Part 0 finding holds with and without E6.

- **Where:** §7.6 table (verbatim); §7.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** max shift 0.4 pp without bursts; U_DATA_RISK 1.4% without E6 vs 2.6% E6; U_FLEX_REQ 4.7% vs 2.6% E6
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `7243490138`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings
