# Cards — report 8

Source: `App Store Reports/8. Onrise - Habit Tracker & Focus - Build habits, focus & journal (REPORT).md`  
134 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 4
- [Must-haves](#must-haves) — 5
- [Must never break](#must-never-break) — 14
- [Features](#features) — 30
- [Monetization](#monetization) — 5
- [Tactics the app used](#tactics-the-app-used) — 3
- [Insights (the why)](#insights-the-why) — 11
- [Audiences](#audiences) — 5
- [Markets and languages](#markets-and-languages) — 12
- [Dated events and trends](#dated-events-and-trends) — 8
- [Positioning](#positioning) — 4
- [Anti-patterns](#anti-patterns) — 3
- [Things not to do](#things-not-to-do) — 1
- [Things to do](#things-to-do) — 3
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 24

## Product rules

### R08-024 — 20 reviewers volunteered money to a product with no way to take it and 12 warned against taking it — read together they describe the one permitted move: an optional one-time tip or a paid add-on tier, with everything that exists today staying free forever; a subscription that gates existing capability is the one move this corpus rules out

- **Where:** Part 0 §8 read together they describe a precise permitted move; Part 9 #14
- **This app does:** free, nothing paid
- **User reaction:** mixed
- **Magnitude:** 20 (2.35%) volunteer money; 12 (1.41%) fear monetization
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** applies to an app whose whole position is 'free'; the gate must be additive, never subtractive
- **Review IDs:** `13920667278`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase

### R08-039 — No nag, no interstitial, no upgrade prompt in 850 reviews — and reviewers cite it favourably: 'it doesn't bug me everyday to upgrade to premium'; 'no in-app purchases or premium version nag pop ups'; 'they don't [nag] you with their premium plans'; the only nag in the corpus is non-commercial (the widget-onboarding overlay)

- **Where:** §1.5 Upsell pressure is zero — and reviewers name that as a feature
- **This app does:** zero upsell
- **User reaction:** praise
- **Magnitude:** 0 upsell complaints; 3 quoted praise
- **Direction for us:** product-rule · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `14281675824`, `10908785407`, `12223448511`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R08-123 — If a paid tier is ever built, make it a one-time purchase or an additive add-on — never a gate on anything that is free today

- **Where:** Part 9 #14 If a paid tier is ever built, make it a one-time purchase or an additive add-on
- **This app does:** free
- **User reaction:** mixed
- **Magnitude:** 6 of 13 WTP one-time/add-on vs 1 subscription; 12 fear monetization
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-021, R08-024
- **Review IDs:** `13920667278`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase

### R08-125 — Do not gate the widget, unlimited habits, the journal or the focus timer — ever: they are the reason 32 reviewers left paid competitors, and gating any converts the corpus's strongest asset into the category's standard complaint

- **Where:** Part 9 #16 Do not gate the widget, unlimited habits, the journal, or the focus timer. Ever.
- **This app does:** all free
- **User reaction:** praise
- **Magnitude:** free 33.53%, unlimited 4.35%, journal 7.65%, focus 7.18% of the corpus
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-004, R08-027, R08-028
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free

## Must-haves

### R08-034 — A data-access request left unanswered for seven months: 'I wrote the support to ask for a data export in March! They ignored my email and didn't even refuse to offer an export of my data' (1★) — below threshold at n=1 but promoted because an unanswered data-rights request is a reputational and regulatory exposure that costs nothing to close

- **Where:** §3.1 One counter-case, and it is severe; Part 9 #6
- **This app does:** support email unanswered
- **User reaction:** 1★-burst
- **Magnitude:** 1 (1★, EG, Oct 2025; asked Mar 2025)
- **Direction for us:** must-have · **Report confidence:** promoted despite n = 1 · **Generalisable:** yes
- **Review IDs:** `13311871983`
- **Canonical:** C020 Data export / backup / CSV; C036 A support channel that exists, is reachable outside the app, and answers

### R08-059 — Backup and device migration, not multi-device convenience, is the need: 'I recently reset my iPhone. Now after installing the app, there is no login option. All my habit records are gone'; 'If the app is uninstalled all the user data will be lost'; 'I just wish it has icloud saving but I realize if something is free like this, the devs cant afford such' — a local encrypted backup file plus iCloud Drive document sync answers it without a server, an account or a revenue model

- **Where:** §4.3 sync/backup/device migration; Part 6 #5; Part 9 #11
- **This app does:** local-only, no backup, no account
- **User reaction:** churn
- **Magnitude:** want_sync_backup_account 37 (4.35%, VERY STRONG), mean 4.30, 5.4% 1–2★; 4★ band 13 (7.9%); + 12 export + 9 data loss; 4.6% of 2025 → 2.7% of 2026
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Conditions:** free, no-account app — the fix must not need a server
- **Review IDs:** `10544874717`, `12874016631`, `13668962217`, `11943323917`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R08-070 — Custom habits existed but a prominent preset picker hid the free-text path for three years — 'Wieso kann ich keine eigene Gewohnheit abtippen?… Daher nur 1 Stern, weil unbrauchbar' (the only 1★ of 2023); 'i just wish i could write in my own habit… learning a language isn't an option' — cost at least one 1★, one 2★ and eleven withheld stars for a feature that already existed

- **Where:** §4.7 'You can only pick from preset habits' — a discoverability failure, not a missing feature
- **This app does:** preset picker prominent; custom path hidden 2023–2025, fixed ~late 2025
- **User reaction:** 1★-burst
- **Magnitude:** custom_habit_blocked 13 (1.53%, MEANINGFUL), mean 3.77, 15.4% 1–2★; 2.5% of 2025 → 0.7% of 2026
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10105619469`, `12355873345`, `10153674169`, `11590224125`, `13581401872`
- **Canonical:** C142 Surface existing features where users look

### R08-074 — UI/UX confusion (forced reminders, notification nagging, layout, janky animations) is the worst-profile complaint — no reviewer carrying it gives 5★

- **Where:** Part 4 ui_confusion; Part 2 2★
- **This app does:** layout / flow friction
- **User reaction:** 1★-burst
- **Magnitude:** ui_confusion 11 (1.29%, MEANINGFUL), mean 2.91, 45.5% 1–2★, 0.0% 5★; 2★ band 5 of 20 (25.0%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9386826805`, `12547660463`, `11904827409`
- **Canonical:** C075 Skippable, replayable onboarding tour

### R08-115 — Answer the user who asked for their data in March 2025 and was still unanswered in October — whatever the export roadmap, an unanswered data-access request is exposure that costs nothing to close

- **Where:** Part 9 #6 Answer the unanswered data-export request
- **This app does:** unanswered
- **User reaction:** 1★-burst
- **Magnitude:** 1 review
- **Direction for us:** must-have · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R08-034
- **Review IDs:** `13311871983`
- **Canonical:** C020 Data export / backup / CSV; C036 A support channel that exists, is reachable outside the app, and answers

## Must never break

### R08-009 — The worst quarter was hard functional failures in a nine-week window: 'It doesn't allow me to confirm the creation of habits'; a white screen on open; 'the widget isn't showing my habits anymore'; 'it does not save the marks. The next day all boxes are empty'; 'I hit the create button and nothing happens'

- **Where:** Part 0 §3 2025Q3 is the worst quarter in the app's history
- **This app does:** create flow, launch, widget and save paths broke in 2025
- **User reaction:** 1★-burst
- **Magnitude:** 2025Q3 n=49, mean 4.184, 12.2% 1–2★; 5 of its 6 1–2★ are hard functional failures (6 Aug – 10 Sep 2025); bug_white_screen 4 (0.47%), 2.25; bug_cannot_create 4 (0.47%), 2.00
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12982290428`, `13032792258`, `13089378849`, `13098030502`, `13120591145`, `12002553577`, `13343619642`
- **Canonical:** C031 Crashes / launch failures; C175 Updates must not break function or wipe progress

### R08-019 — Users cannot mark a habit complete on the day they did it — 'I can only select tomorrow'; 'couldn't mark my gym task as completed because it was after the reminder'; 'If I do something on Monday it'll show that I did it on Tuesday' — a timezone / day-boundary defect or reminder-gated logging window that breaks the product's only core action, still reported Apr 2026 after the fix wave; the highest-severity open item

- **Where:** Part 0 §7 This is the highest-severity open item in the corpus; Part 2 1★; §8.6; Part 9 #1
- **This app does:** day-boundary / logging-window defect
- **User reaction:** 1★-burst
- **Magnitude:** 11 (1.29%, MEANINGFUL), mean 2.73, 45.5% 1–2★ (second-worst rating profile); 6 of 11 dated Jan 2025 – Apr 2026; 3 of 11 in a 14-day Jan 2025 window; 1★ band 3 of 22 (13.6%)
- **Direction for us:** must-never-break · **Report confidence:** highest severity · **Generalisable:** yes
- **Review IDs:** `12164874968`, `12189113218`, `12214950748`, `12219310786`, `13990708296`, `12919299992`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R08-057 — The flagship 2026 feature shipped with an off-by-one: the monthly summary never includes the last day of the month — 'I completed all my habits for January, but according to this new feature I completed only 30 of 31 days… Maybe you just missed a line in the code?' (1★); 'even if you do the habit all 30 days… it always says 29/30 or 97%' — almost certainly a one-line date-range bug that turned the flagship feature into a 1★

- **Where:** §4.2 But the shipped feature has an off-by-one defect, reported twice independently; Part 9 #2
- **This app does:** month summary excludes last day
- **User reaction:** 1★-burst
- **Magnitude:** 2 independent reports 3 months apart (Feb 2026 1★, May 2026 4★); bug_monthly_summary 2 (0.24%), mean 2.50
- **Direction for us:** must-never-break · **Report confidence:** weak, trust-critical · **Generalisable:** yes
- **Review IDs:** `13742512516`, `14018076544`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R08-061 — Data loss is the worst-rated reliability theme — 'it does not save the marks. The next day all boxes are empty'; a 1★ who lost data twice

- **Where:** Part 4 data_loss
- **This app does:** local storage lost
- **User reaction:** 1★-burst
- **Magnitude:** data_loss 9 (1.06%, MEANINGFUL), mean 2.67, 66.7% 1–2★; 2★ band 5 of 20 (25.0%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13098030502`, `14021302236`, `10544874717`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R08-066 — The focus-timer alarm does not fire when another app is opened, the screen is off or the ringer is silent, and one timer resets when backgrounded — 'sometimes the focus/break timer doesn't go off if I open another app or if I turn off the screen despite the volume being turned on' — an audio-session / notification-category configuration, not a feature

- **Where:** §4.5 The alarm-doesn't-sound cluster; Part 9 #4
- **This app does:** alarm silent in background
- **User reaction:** complaint
- **Magnitude:** 7 reviews Jan 2024 → Aug 2026; resets on backgrounding 14397732532 (IN, 2★, Aug 2026)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10808472591`, `12031614206`, `12187537484`, `10562486460`, `9878233995`, `11099294310`, `14397732532`
- **Canonical:** C039 Reminders fire reliably, once

### R08-068 — The widget shipped a placeholder-string leak for three years: it renders the word 'habit' in several languages instead of data — 'Leider funktioniert das widget nicht und zeigt nur das Wort Gewohnheit in verschiedenen Sprachen an'; 'Shows no data, mo datos, keine daten'

- **Where:** §4.6 This is a placeholder-string leak in the widget timeline that survived three years; Part 9 #3
- **This app does:** widget timeline shows localized placeholder
- **User reaction:** complaint
- **Magnitude:** widget_broken 13 (1.53%, MEANINGFUL), mean 3.62, 15.4% 1–2★; Dec 2022 → Jan 2026; IN 4 (5.13%, HIGH)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9436912627`, `9586149656`, `10256806517`, `10275032045`, `10967037964`, `11029352763`, `11093636426`, `11783886827`, `11971548857`, `13089378849`, `13098030502`, `13274217621`, `13609169075`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R08-071 — Reminders fail three ways: they silently stop arriving after a few days ('then they suddenly disappear and I completely forget all about the app. this cycle keeps happening'), ghost notifications keep firing for deleted habits, and AM/PM cannot be set ('instead of it ringing at a.m. it rings at p.m.' — a 1★ from an enthusiastic user)

- **Where:** §4.8 Notifications
- **This app does:** reminder delivery and 12/24h picker defects
- **User reaction:** 1★-burst
- **Magnitude:** notif_problem 19 (2.24%, MEANINGFUL), mean 3.47, 15.8% 1–2★; 3★ band 5 (11.9%); 4★ band 8 (4.8%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12544716257`, `12664737710`, `14051523206`, `11980385792`, `12954786100`, `14096147270`, `14430310526`, `11311660298`, `11997469592`, `13724690797`
- **Canonical:** C039 Reminders fire reliably, once

### R08-087 — Streak and count miscounts erode trust — 'You track 4 times you did a habit, it'll show 6'

- **Where:** Part 4 streak_bug_confusion
- **This app does:** count / streak display errors
- **User reaction:** 1★-burst
- **Magnitude:** streak_bug_confusion 7 (0.82%, EMERGING), mean 3.71, 14.3% 1–2★; praise_streak 36 (4.24%), mean 4.36
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `8922203790`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R08-088 — Lag and crashes are the single worst-rated theme — every reviewer carrying it gives 1–2★ — and three of the four are Canadian

- **Where:** Part 4 perf_lag_crash; §7.1 CA
- **This app does:** lag / crashes
- **User reaction:** 1★-burst
- **Magnitude:** perf_lag_crash 4 (0.47%, Weak), mean 1.50, 100.0% 1–2★; CA 3 of 4 (3.37% of CA)
- **Direction for us:** must-never-break · **Report confidence:** weak, maximal severity · **Generalisable:** yes
- **Review IDs:** `11648694059`, `8021289450`
- **Canonical:** C031 Crashes / launch failures; C083 Performance must not degrade with habit count

### R08-110 — Fix the day-boundary / 'can't log today' defect — it breaks the product's only core action; highest severity in the corpus

- **Where:** Part 9 #1 Immediate — Fix the day-boundary / can't log today defect
- **This app does:** defect open Apr 2026
- **User reaction:** 1★-burst
- **Magnitude:** 11 reviews, mean 2.73, 45.5% 1–2★, concentrated in January
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R08-019
- **Review IDs:** `13990708296`
- **Canonical:** C032 New Year peak-season robustness — year-end report and January onboarding; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R08-111 — Fix the monthly-summary off-by-one — the last day of the month is excluded; almost certainly a one-line date-range bug

- **Where:** Part 9 #2 Fix the monthly-summary off-by-one
- **This app does:** summary excludes last day
- **User reaction:** 1★-burst
- **Magnitude:** 2 independent reports
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R08-057
- **Review IDs:** `13742512516`, `14018076544`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R08-112 — Fix the widget placeholder-string leak ('no data / mo datos / keine daten') — reported as recently as Jan 2026

- **Where:** Part 9 #3 Fix the widget placeholder-string leak
- **This app does:** localized placeholder instead of data
- **User reaction:** complaint
- **Magnitude:** 13 reviews across three years
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R08-068
- **Review IDs:** `13609169075`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R08-113 — Make the focus-timer alarm fire when backgrounded or silenced and stop the timer resetting on backgrounding — an audio-session / notification-category configuration

- **Where:** Part 9 #4 Make the focus-timer alarm fire when backgrounded or silenced
- **This app does:** alarm silent / timer resets
- **User reaction:** complaint
- **Magnitude:** 7 reviews Jan 2024 → Aug 2026
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R08-066
- **Review IDs:** `14397732532`
- **Canonical:** C039 Reminders fire reliably, once

### R08-114 — Audit the reminder time picker for 12/24-hour locales — a user could not set AM, which cost a full star from an enthusiastic user

- **Where:** Part 9 #5 Audit the reminder time picker for 12/24-hour locales
- **This app does:** AM/PM picker defect
- **User reaction:** 1★-burst
- **Magnitude:** 1 (1★, US, Feb 2026)
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R08-071
- **Review IDs:** `13724690797`
- **Canonical:** C039 Reminders fire reliably, once

## Features

### R08-015 — Monthly / yearly summaries ('At a Glance', 'Wrapped') shipped free ~Jan 2026 and halved stats requests — 'Love the update that brought us the monthly and yearly summaries. Very cool and enjoy the data!'

- **Where:** Part 0 §5 Monthly / yearly summaries row; §4.2; §8.3
- **This app does:** free, shipped ~Jan 2026
- **User reaction:** praise
- **Magnitude:** stats requests 6.8% of 2025 → 3.4% of 2026
- **Direction for us:** build-free · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `13742512516`, `14254399815`, `14359179692`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R08-016 — The #1 unmet need is intra-day completion and it is the only theme getting louder: the app asks for a frequency, then gives one binary tick — 'It asks how many time you want to a habit… but then this serves no function. You still only get one tick box'; 'I can't mark done 1/4 and then increase that through the day'; 'it would be great if the habit checkbox would increment with each click until you hit your target'; one explicit uninstall ('it wouldn't let me break the habit into small units — mark each glass of water drunk')

- **Where:** Part 0 §6 (The #1 unmet need is intra-day completion — and it is the only theme getting *louder*) year table; Part 6 #1; Part 9 #7
- **This app does:** one binary tick per day regardless of target
- **User reaction:** churn
- **Magnitude:** 36 (4.24%, VERY STRONG), mean 3.94, 27.8% 5★; Year | n | Rate ; 2022 | 2 | 3.9% ; 2023 | 6 | 3.7% ; 2024 | 9 | 3.9% ; 2025 | 7 | 3.0% ; 2026 | 12 | 8.2%; 4★ band 17 of 165 (10.3%, #2); 3★ band 7 of 42 (16.7%, #2); rating penalty −0.59; US 7.98% vs DE 0.88% vs IN 0.00%
- **Direction for us:** must-have · **Report confidence:** very strong, rising · **Generalisable:** yes
- **Review IDs:** `11761511083`, `13752957984`, `14329423801`, `13748024897`, `13440800887`, `13501714015`, `9035653031`, `14516137596`
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N

### R08-017 — Log how much was done, not just that it was done — 'having 5 minutes of something as the minimum, but logging 15 minutes for the day bc you felt like doing extra'

- **Where:** Part 0 §6 want_log_quantity sibling cluster; Part 6 #12
- **This app does:** binary only
- **User reaction:** praise
- **Magnitude:** want_log_quantity 9 (1.06%, MEANINGFUL), mean 4.56, 0% 1–2★
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8326639521`, `8529598311`, `10765406993`, `10841977769`, `10942821621`, `11507981724`, `12766580589`, `13651287093`, `13803466455`
- **Canonical:** C048 Flexible units / partial progress

### R08-027 — The 3-in-1 bundle (habit tracker + Pomodoro focus timer + journal) is load-bearing, not decoration, and none of its three parts draws a 1–2★: 'It has only 3 functions… All 3 are built with the greatest simplicity'; 'nice to have several apps in one… keep your home screen tidy without switching between 3 apps'; 'No cutesy cartoons, no advice I didn't ask for, no gratuitous cheerleading, no reminders I don't want'

- **Where:** Part 0 §10 The bundle is genuinely load-bearing; Part 3 praise_journal, praise_focus_pomodoro, praise_allinone
- **This app does:** free habits + focus timer + journal
- **User reaction:** praise
- **Magnitude:** journal 65 (7.65%), mean 4.68, 0.0% 1–2★; focus/Pomodoro 61 (7.18%), 4.67, 0.0% 1–2★; all-in-one 58 (6.82%), 4.72, 0.0% 1–2★; high-spend journal 9.60%, all-in-one 8.40%
- **Direction for us:** undecided · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10115617410`, `14051428806`, `11590224125`
- **Canonical:** C066 Focus timer; C144 Habits, focus timer and journal in one simple app; C172 Per-day / per-habit notes and journal text

### R08-031 — Unlimited habits free, confirmed continuously 2021 → 2026, praised explicitly with zero 1–2★ — users arrive expecting the category's 3–5-habit cap and are surprised it never appears

- **Where:** §1.1 Unlimited habits Free row; Part 3 praise_unlimited
- **This app does:** free unlimited habits
- **User reaction:** praise
- **Magnitude:** praise_unlimited 37 (4.35%, VERY STRONG), mean 4.84, 0.0% 1–2★, 86.5% 5★
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `7804733382`, `11533284738`, `14060433155`, `10972915619`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R08-032 — A free widget is itself remarkable to users — 'the first habit tracking app that I don't have to pay for and can have a widget'

- **Where:** §1.1 Home-screen widget Free row
- **This app does:** free widget
- **User reaction:** praise
- **Magnitude:** 1 quoted (5★, CA); widget_positive_only 28 (3.29%), mean 4.61
- **Direction for us:** build-free · **Report confidence:** quoted · **Generalisable:** yes
- **Review IDs:** `11170921819`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R08-033 — Data export / CSV does not exist and is requested; one user asked support for an export and was ignored

- **Where:** §1.1 Data export / CSV does not exist row; Part 4 want_export; Part 6 #5
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** want_export 12 (1.41%, MEANINGFUL), mean 4.08, 8.3% 1–2★
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13311871983`
- **Canonical:** C020 Data export / backup / CSV

### R08-054 — Backfill is capped at roughly six or seven days and history is hard to see — 'Derzeit kann ich sie nur 6 Tage rückwirkend abhaken'; 'Please add ability to backfill missed check in the calendar beyond one week'; 'Every week is a new week, you can't go back and see how your habits have been tracked so far' — the lowest mean of any request theme; the summary partly fixed viewing, editing remains open

- **Where:** §4.1 History and backfill: the second-biggest structural gap; Part 6 #2; Part 9 #9
- **This app does:** backfill window ~7 days
- **User reaction:** complaint
- **Magnitude:** want_backfill_past 27 (3.18%, VERY STRONG), mean 3.52, 14.8% 5★, 14.8% 1–2★; rating penalty −1.01; 5.5% of 2025 → 2.7% of 2026; 3★ band 7 of 42 (16.7%); 1★ band 2
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12248277514`, `11587754660`, `13922090666`, `13237495965`, `14159912572`, `14516137596`, `13182431485`
- **Canonical:** C010 Backfill missed days / edit start date

### R08-056 — Stats and analytics are the classic withheld-star request (low 5★ share, zero 1–2★): the shipped monthly/yearly summary helped, but users still want graphs and heat maps — 'a heat map for the past 365 days'; 'a graphical representation of all the habits like in Obsidian'; 'a graph view'

- **Where:** §4.2 Stats and analytics: shipped, but not finished; Part 6 #3
- **This app does:** tables / summaries, no graphs
- **User reaction:** complaint
- **Magnitude:** want_stats_analytics 47 (5.53%, HIGH), mean 4.11, 29.8% 5★, 0.0% 1–2★; 4★ band 24 (14.5%); 3★ band 9 (21.4%); penalty −0.42; oldest Feb 2021, newest Aug 2026
- **Direction for us:** undecided · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `6940011305`, `14212944580`, `14461713243`, `12380782408`, `13591528677`, `13241851409`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R08-063 — Show circles only on days a habit is actually scheduled: the flexible-frequency model is praised by the users it fits ('the only habit tracker I have found that is able to handle my 3 day a week (but ANY day of the week) habits') and opaque to fixed-schedule users ('a weekly habit must be set to every 7 days, which isn't totally intuitive') — a rendering change, not a model change

- **Where:** §4.4 segmentation problem, not a bug — fix is display, not logic; Part 6 #6; Part 9 #8
- **This app does:** seven circles shown regardless of schedule
- **User reaction:** complaint
- **Magnitude:** frequency_confusion 25 (2.94%, MEANINGFUL), mean 3.76, 12.0% 1–2★, 16.0% 5★; penalty −0.77; 4★ band 14 (8.5%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14254399815`, `13813008711`, `14045501473`, `11475373489`
- **Canonical:** C043 Flexible / custom frequency; C142 Surface existing features where users look

### R08-065 — The focus timer is liked and wants finishing: arbitrary durations (not just 5/15/25/60), a Live Activity / Lock Screen / Dynamic Island countdown, auto-start break, keep the screen awake, a stopwatch/flowmodoro mode, per-habit focus stats

- **Where:** §4.5 focus timer requests; Part 6 #7
- **This app does:** presets only; no Live Activity
- **User reaction:** praise
- **Magnitude:** focus_timer_issue 32 (3.76%, VERY STRONG), mean 4.34; 4★ band 14 (8.5%); 4.2% of 2025 → 1.4% of 2026; emerging markets 5.42%
- **Direction for us:** undecided · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10320051165`, `11497359189`, `12427747362`, `10730989325`, `11575357275`, `8306583064`, `10278427560`, `11298218335`, `10102584778`
- **Canonical:** C066 Focus timer

### R08-067 — The widget is the best-loved surface and the biggest defect surface at once; the dominant ask is to show more than one habit — 'you can only track one habit from it. If the dev can provide a more up front view of all of your habits on the widget, this would be my daily used app!' — plus lock-screen widgets and more sizes (tap-to-tick now shipped); a pure-upside request going back to Jan 2021

- **Where:** §4.6 The widget: best-loved surface and biggest defect surface at once; Part 6 #4; Part 9 #10
- **This app does:** free single-habit widget; tap-to-tick shipped mid-2026
- **User reaction:** praise
- **Magnitude:** widget mentions 86 (10.12%), mean 4.40; positive-only 28 (3.29%), 4.61; want_widget_better 41 (4.82%, VERY STRONG), mean 4.56, 0.0% 1–2★, penalty +0.03; widget requests 4.6% of 2025 → 2.1% of 2026; emerging markets 13.86% mentions, 6.02% requests
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12155711592`, `11746712561`, `10269783945`, `11116741104`, `12171578935`, `10076496123`, `10371841156`, `10832112045`, `13539393763`, `6862625618`, `14502932053`
- **Canonical:** C009 Basic widgets, icons and colours are free; C107 Widget variants and customisation as the paid layer

### R08-075 — A habit's colour cannot be changed after creation — you must delete the habit and lose all its history to recolour it: data loss disguised as a settings limitation

- **Where:** Part 4 want_colors_custom; Part 6 #8; Part 9 #12
- **This app does:** colour fixed at creation
- **User reaction:** complaint
- **Magnitude:** want_colors_custom 20 (2.35%, MEANINGFUL), mean 4.35, 0.0% 1–2★; penalty −0.18
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12470711816`
- **Canonical:** C041 Editing a habit never wipes its history

### R08-076 — The Apple Watch app is the best paid-add-on candidate in the corpus: additive, pure upside (zero 1–2★), and the only feature two reviewers independently volunteered to pay for — 'Mit Apple Watch Integration würde ich hierfür auch sehr gerne Geld zahlen'; 'You can make this a premium feature as I know this is not an easy task'

- **Where:** Part 4 want_apple_watch; Part 6 #9; Part 9 #15
- **This app does:** absent
- **User reaction:** purchase-driver
- **Magnitude:** want_apple_watch 18 (2.12%, MEANINGFUL), mean 4.61, 0.0% 1–2★, 66.7% 5★; penalty +0.08; SE 2 of 18
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8082446036`, `10117160205`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R08-077 — iPad-native / macOS apps are wanted, most in Germany; one user's iPad landscape layout broke after an update

- **Where:** Part 4 want_ipad_mac; Part 6 #10
- **This app does:** absent; iPad landscape regressed
- **User reaction:** complaint
- **Magnitude:** want_ipad_mac 11 (1.29%, MEANINGFUL), mean 4.45, 0.0% 1–2★; DE 6 (5.26%, HIGH)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12082430684`, `13676828438`
- **Canonical:** C044 Mac / desktop / web app; C141 Native iPad layout

### R08-078 — Folders / routines / lists for sorting habits — named in the corpus's only subscription-price statement ($4.99/month for folders and daily journal prompts)

- **Where:** Part 4 want_folders_groups; Part 6 #11
- **This app does:** absent
- **User reaction:** purchase-driver
- **Magnitude:** want_folders_groups 9 (1.06%, MEANINGFUL), mean 4.22, 0.0% 1–2★; penalty −0.31
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14359179692`
- **Canonical:** C045 Grouping / folders / categories / tags

### R08-079 — Shared habits / accountability buddy: a 'Habit Buddy' invite exists but does not report back, so users still ask for it

- **Where:** Part 4 want_social_share; Part 6 #13
- **This app does:** Habit Buddy invite that doesn't report progress
- **User reaction:** complaint
- **Magnitude:** want_social_share 9 (1.06%, MEANINGFUL), mean 4.33, 0.0% 1–2★; 4★ band 6 (3.6%)
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9083174395`, `6903454353`
- **Canonical:** C015 Shared / group habits

### R08-080 — A to-do list for non-repeating tasks alongside habits — 'I hope to see maybe a todo list app from devs'

- **Where:** Part 4 want_todo_list; Part 6 #14
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** want_todo_list 7 (0.82%, EMERGING), mean 4.71, 71.4% 5★
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `14001076337`
- **Canonical:** C050 One-off to-dos alongside habits

### R08-081 — Skip day / vacation mode / streak freeze is requested

- **Where:** Part 4 want_skip_vacation; Part 6 #15
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** want_skip_vacation 7 (0.82%, EMERGING), mean 4.29, 28.6% 5★
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R08-082 — Reordering habits was requested and shipped by Jul 2026 — 'very customizable even down to the color, order, frequency'

- **Where:** Part 4 want_reorder; Part 6 #16
- **This app does:** shipped by Jul 2026
- **User reaction:** praise
- **Magnitude:** want_reorder 6 (0.71%, EMERGING), mean 4.50
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `14326501421`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R08-083 — A Monday week start is requested (FR, AT) — and one user saw their week start on a Wednesday

- **Where:** Part 4 want_week_start; Part 6 #17
- **This app does:** week start not configurable
- **User reaction:** complaint
- **Magnitude:** want_week_start 6 (0.71%, EMERGING), mean 4.33, 16.7% 1–2★
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12137639810`, `14363873344`, `10029070611`
- **Canonical:** — (nuance register)

### R08-084 — Apple Health integration is a small request — and power-user integrations are largely absent from this corpus

- **Where:** Part 4 want_health_integration; Part 6 #18
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** want_health_integration 5 (0.59%, EMERGING), mean 4.20; penalty −0.33
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration

### R08-085 — A mood tracker inside the journal is asked only by 5★ users

- **Where:** Part 4 want_mood_tracker; Part 6 #19
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** want_mood_tracker 3 (0.35%, Weak), mean 5.00, 100% 5★; penalty +0.47
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C049 Mood tracker

### R08-086 — Face ID / passcode lock is a tiny request

- **Where:** Part 4 want_app_lock; Part 6 #20
- **This app does:** absent
- **User reaction:** none
- **Magnitude:** want_app_lock 2 (0.24%, Weak), mean 4.50
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C017 Passcode lock

### R08-116 — Ship intra-day completion — tap the checkbox N times to fill N/N — paired with quantity logging

- **Where:** Part 9 #7 Product — converts 4★ into 5★ — Ship intra-day completion: tap the checkbox N times to fill N/N
- **This app does:** one tick per day
- **User reaction:** churn
- **Magnitude:** 36 reviews, mean 3.94, 8.2% of 2026, #2 blocker in 4★ and 3★ bands, one stated uninstall
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-016, R08-017
- **Review IDs:** `13440800887`
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N

### R08-117 — Show circles only on scheduled days — a rendering change that keeps the praised flexible-frequency logic and removes the confusion

- **Where:** Part 9 #8 Show circles only on days a habit is actually scheduled
- **This app does:** seven circles always
- **User reaction:** complaint
- **Magnitude:** 25 reviews, mean 3.76
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-063
- **Review IDs:** `14254399815`, `13813008711`
- **Canonical:** C043 Flexible / custom frequency; C142 Surface existing features where users look

### R08-118 — Extend backfill from ~7 days to an unbounded calendar — the 7-day wall makes the app feel like it 'starts over'

- **Where:** Part 9 #9 Extend backfill from ~7 days to an unbounded calendar
- **This app does:** ~7-day window
- **User reaction:** complaint
- **Magnitude:** 27 reviews, mean 3.52 (worst request mean)
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-054
- **Review IDs:** `13237495965`, `13182431485`
- **Canonical:** C010 Backfill missed days / edit start date

### R08-119 — Ship a multi-habit widget and lock-screen widgets — zero 1–2★, above-corpus mean, pure upside with no simplicity risk

- **Where:** Part 9 #10 Ship a multi-habit widget and lock-screen widgets
- **This app does:** single-habit widget
- **User reaction:** praise
- **Magnitude:** 41 reviews; oldest Jan 2021
- **Direction for us:** build-free · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-067
- **Review IDs:** `6862625618`
- **Canonical:** C009 Basic widgets, icons and colours are free; C107 Widget variants and customisation as the paid layer

### R08-120 — Local encrypted backup plus iCloud Drive document sync — no account, no server — preserving the no-account privacy posture while closing the largest reliability anxiety

- **Where:** Part 9 #11 Local encrypted backup + iCloud Drive document sync — no account, no server
- **This app does:** no backup
- **User reaction:** churn
- **Magnitude:** 37 sync + 12 export + 9 data-loss; India 14.10%
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-059, R08-060
- **Review IDs:** `9853721563`, `10309724588`, `11943323917`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R08-121 — Let users change a habit's colour after creation — today recolouring means deleting the habit and losing all history

- **Where:** Part 9 #12 Let users change a habit's colour after creation
- **This app does:** colour fixed
- **User reaction:** complaint
- **Magnitude:** 20 reviews
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-075
- **Review IDs:** `12470711816`
- **Canonical:** C041 Editing a habit never wipes its history

## Monetization

### R08-021 — Willingness to pay is tip-shaped, not subscription-shaped: of 13 statements, 6 name a one-time purchase, a tip or a premium add-on and exactly one names a subscription ($4.99/month, only for features that don't exist yet); one reviewer states the trade-off in a sentence — 'If there would be some subs I wouldn't use it, but I could buy it for 5-10 bucks if it provided the full experience forever'

- **Where:** Part 0 §8 Read the shape, not just the volume
- **This app does:** nothing to buy
- **User reaction:** purchase-driver
- **Magnitude:** wtp_explicit 13 (1.53%, MEANINGFUL), mean 4.85, 84.6% 5★; 6 one-time/tip/add-on vs 1 subscription; DE 5 of 13
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13920667278`, `9979231109`, `10153094810`, `14051428806`, `14359179692`, `10117160205`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R08-022 — Users ask for a donate / tip button that does not exist — 'Würde dem Dev gern einen Kaffee spendieren'; 'give us a way to support you, developer'; 'Would consider donating a few bucks if option existed on the app' — a tip jar gates nothing, carries zero rating risk, and gives the product a visible reason to exist

- **Where:** Part 0 §8 Donate requests; §1.4 friction 1; Part 9 #13
- **This app does:** no donation mechanism
- **User reaction:** blocked-conversion
- **Magnitude:** want_donate 7 (0.82%, EMERGING), all 5★, mean 5.00; DE 3 of 7; 6 of 7 from high-spend storefronts
- **Direction for us:** build-paid · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `7389309906`, `9108984672`, `9735019567`, `10529311558`, `10814895538`, `12356113785`, `13440800887`
- **Canonical:** C097 A tip / donate option

### R08-023 — An equal and opposite cohort warns against monetizing — every one 5★: 'I hope this app will never go on the payment route'; 'I pray that this app stays free and the same!'; 'Pls keep this free!!'; 'I just hope that you won't turn this app into a money pool'

- **Where:** Part 0 §8 an equal and opposite cohort that explicitly fears monetization; §8.4
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** fear_monetization 12 (1.41%, MEANINGFUL), mean 5.00, 100% 5★; appeared from 2023, peaked 2025 (2.5%) when the app looked abandoned
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9748794188`, `11340230450`, `11504152895`, `11928071645`, `12123545257`, `12136485316`, `12138446509`, `12254605947`, `12370363395`, `13140531683`, `13920667278`
- **Canonical:** C001 Never move a free feature behind the paywall

### R08-122 — Add a tip jar / 'buy the developer a coffee' one-time IAP — zero rating risk because it gates nothing, and it answers the abandonment anxiety by giving the product a visible reason to exist

- **Where:** Part 9 #13 Monetization — the permitted moves, and the forbidden one — Add a tip jar / buy the developer a coffee one-time IAP
- **This app does:** no tip option
- **User reaction:** blocked-conversion
- **Magnitude:** 7 asked unprompted (all 5★); 13 more would pay
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-022, R08-038
- **Canonical:** C097 A tip / donate option

### R08-124 — Make the Apple Watch app the paid add-on — demand and willingness to pay are attached to the same additive feature, and it does not touch the free tier

- **Where:** Part 9 #15 The Apple Watch app is the best paid-add-on candidate in the corpus
- **This app does:** absent
- **User reaction:** purchase-driver
- **Magnitude:** 18 requests, mean 4.61, zero 1–2★; 2 volunteered to pay
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-076
- **Review IDs:** `8082446036`, `10117160205`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

## Tactics the app used

### R08-014 — Tactic: the developer made reminders optional after review feedback — 'They've made notifications optional and added a widget after getting feedback from reviews'. Outcome: the app's #1 friction theme went to literally zero and stayed there — the strongest evidence in the corpus that shipping against review feedback works

- **Where:** Part 0 §5 The optional-reminders fix; §8.3 Trend 2 — shipping against reviews demonstrably works here
- **This app does:** forced reminders → optional (~mid-2023)
- **User reaction:** praise
- **Magnitude:** forced-reminder complaints 17.6% of 2022 (9/51) → 0.6% of 2023 → 0.0% of 2025–26 (0/383); forced_reminder (historical) 11 (1.29%), mean 4.36; DE 5.26%
- **Direction for us:** do · **Report confidence:** strongest single evidence · **Generalisable:** yes
- **Review IDs:** `8492731197`, `9494382068`, `10420089265`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R08-052 — A clinician recommends the app to clients because it is free and ad-free — 'I'm a therapist and I recommend this app for clients. Harnessing the power of having visual signals of progress is important… PLUS it's free and no ads' — a distribution channel the free position created

- **Where:** §3.3 a therapist recommending it to clients
- **This app does:** free, no ads
- **User reaction:** 5★-burst
- **Magnitude:** 1 (5★, CA)
- **Direction for us:** do · **Report confidence:** quoted (n = 1) · **Generalisable:** yes
- **Review IDs:** `10841075611`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R08-128 — Re-request reviews from the 2025 cohort: the trough was caused by defects that are now fixed, but the written corpus prospective users read still carries 17 functional-failure reports from a version that no longer exists

- **Where:** Part 9 #19 Re-request reviews from the 2025 cohort
- **This app does:** defects fixed, reviews stale
- **User reaction:** complaint
- **Magnitude:** 17 functional-failure reports in 2025; store aggregate 4.83 on 7,184 ratings across 13 storefronts
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-010, R08-104
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

## Insights (the why)

### R08-006 — Not one of the 42 one- and two-star reviews is a price complaint — remove the paywall and rating damage does not disappear, it relocates entirely to reliability (42.9%) and capability (31.0%); in the seven other apps in this set monetization is the dominant source of rating damage

- **Where:** Part 0 §2 Interpretation — the headline finding
- **This app does:** no price
- **User reaction:** 1★-burst
- **Magnitude:** 42 1–2★ (4.94%): broken 18 (42.9%), missing capability 13 (31.0%), UI friction 7 (16.7%), off-topic 3 (7.1%), price 0 (0.0%), paywall misconception 1 (2.4%)
- **Direction for us:** product-rule · **Report confidence:** headline · **Generalisable:** yes
- **Conditions:** free apps still get 1★s — for reliability and missing capability; monetization choices move ratings in paid apps
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R08-026 — The praise stack is unusually coherent: simplicity, the money position, design, no ads, the developer, and the 3-in-1 bundle — the app does three things and gets out of the way

- **Where:** Part 0 §10 (What people actually love: it does three things and gets out of the way)
- **This app does:** minimal, free, no ads
- **User reaction:** praise
- **Magnitude:** simplicity 363 (42.71%), mean 4.70, 77.7% 5★; free 285 (33.53%), 4.81; design 229 (26.94%), 4.64; no ads 88 (10.35%), 4.78, 84.1% 5★; developer 67 (7.88%), 4.79; all-in-one 58 (6.82%), 4.72, zero 1–2★
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R08-038 — A free app with no visible revenue creates abandonment anxiety: users correctly infer there is no business model sustaining it, and the abandonment-concern reviews are its direct product

- **Where:** §1.4 friction 3 — the free position creates abandonment anxiety
- **This app does:** free, no revenue
- **User reaction:** mixed
- **Magnitude:** abandonment_concern 7 (0.82%); fear_monetization peaked 2025 (2.5%)
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Side effects:** a tip jar both answers the users who want to pay and signals the product is sustained
- **Review IDs:** `11504152895`, `12936436921`
- **Canonical:** C071 Never ship and walk away; C097 A tip / donate option

### R08-041 — The 5★ formula is exact: the app is simple, it looks good, it costs nothing, it never nags, and it does habits + focus + journal 'without asking me to be anyone' — 'a testament of the less is more philosophy… It's not littered with ads or stripped down to encourage a premium purchase'

- **Where:** Part 2 5★ The 5★ formula is exact
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** 5★ n = 601 (70.71%)
- **Direction for us:** product-rule · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `12159330464`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R08-042 — Everyone describing a concrete life outcome gives 5★ — title 'Depression Buster'; 'far more successful in stopping bad habits (alcohol and flower)'; 'I'm a Stroke and Aphasia survivor… this definitely helps me be a better version of myself'

- **Where:** Part 2 5★ praise_effect_outcome
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** praise_effect_outcome 20 (2.35%, MEANINGFUL), mean 5.00, 100% 5★
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12738414001`, `12136485316`, `7177041505`
- **Canonical:** — (nuance register)

### R08-043 — The 4★ band is where the roadmap is written: stats dominated historically and has now shipped (2026 rate halved), so the live 4★ blockers are multi-daily check-in, frequency modelling and sync

- **Where:** Part 2 4★ — n = 165 (19.41%) — the 'one missing thing' band table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Blocker named | n | % of 4★ band ; want_stats_analytics | 24 | 14.5% ; want_multi_daily_checkin | 17 | 10.3% ; focus_timer_issue | 14 | 8.5% ; frequency_confusion | 14 | 8.5% ; want_sync_backup_account | 13 | 7.9% ; want_backfill_past | 12 | 7.3% ; want_widget_better | 12 | 7.3% ; notif_problem | 8 | 4.8% ; want_colors_custom | 7 | 4.2% ; want_social_share | 6 | 3.6%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-044 — 3★ is capability gaps stated calmly — the canonical 3★ names three at once: 'if I forget to document my tracking… I can't go back and track the day before. I also don't have a snapshot of the entire week or month… Every time I feel like I'm starting over with zero credit for previous accomplishments. I'm fishing for another app'

- **Where:** Part 2 3★ — n = 42 (4.94%) — capability gaps, stated calmly table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 3★ band ; want_stats_analytics | 9 | 21.4% ; want_multi_daily_checkin | 7 | 16.7% ; want_backfill_past | 7 | 16.7% ; notif_problem | 5 | 11.9% ; frequency_confusion | 4 | 9.5% ; widget_broken | 3 | 7.1%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13182431485`
- **Canonical:** — (nuance register)

### R08-045 — 2★ is 'I want to love this and cannot use it': 7 of 20 praise the design in the same review — 'It looks awesome, I'd love to use it but a pop up comes up over the whole screen… and the button at the bottom to get rid of it is just cut off enough so I can't register a tap'

- **Where:** Part 2 2★ — n = 20 (2.35%) — data loss and UI dead-ends table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 2★ band ; ui_confusion | 5 | 25.0% ; data_loss | 5 | 25.0% ; frequency_confusion | 3 | 15.0% ; perf_lag_crash | 2 | 10.0% ; bug_cannot_log_today | 2 | 10.0% ; 7 of 20 (35%) praise design in the same review
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `11904827409`
- **Canonical:** — (nuance register)

### R08-049 — The developer is a named asset — '¡Gracias Maximilian!'; 'Bless developers like Maximilian Munker' — with documented responsiveness ('the developer actually takes people's feedback into consideration!'; 'Auch der Support ist sehr schnell und freundlich!')

- **Where:** §3.1 The developer is a named asset
- **This app does:** solo developer, responsive
- **User reaction:** praise
- **Magnitude:** praise_developer 67 (7.88%, HIGH), mean 4.79, 89.6% 5★
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12117330361`, `8306583064`, `11869217620`, `9494382068`, `10399402927`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R08-072 — Informative absences: zero price/paywall objections, zero ad complaints, zero account/login complaints, zero AI mentions or AI demand in a 2026 productivity corpus, and almost zero gamification demand — several praise that streaks and rewards can be turned off ('No cutesy cartoons… no gratuitous cheerleading'; 'I just wanted a simple ticker and didn't care about streaks and rewards, and you can turn all of that off')

- **Where:** §4.9 What is *not* in this corpus — and that is informative
- **This app does:** no AI, optional gamification
- **User reaction:** praise
- **Magnitude:** 0 price, 0 ads, 0 AI; gamification wish 1
- **Direction for us:** dont · **Report confidence:** absence · **Generalisable:** yes
- **Review IDs:** `11824366215`, `11590224125`, `10121460935`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C056 Don't build AI features on demand grounds; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R08-092 — Power users are missing: almost no demand for tags, dependencies, habit stacking (1), Shortcuts/automation (2) or Health integration (5) — Onrise's users are not the users who would pay for the kind of Pro tier competitors sell

- **Where:** Part 5 Who is missing: power users
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** habit stacking 1; Shortcuts 2; Health 5
- **Direction for us:** research · **Report confidence:** observed · **Generalisable:** yes
- **Conditions:** a free app selects for minimalists and escapees; a Pro tier built for power users would have no buyers here
- **Review IDs:** `13724827992`, `8529598311`, `14004377053`
- **Canonical:** — (nuance register)

## Audiences

### R08-050 — ADHD users are a small, perfect-scoring segment and the mechanism they name is flexible completion without guilt — 'it provides the flexibility in the task completions within a week/month so I don't feel the pressure of my todos' — precisely what frequency confusion breaks for fixed-schedule users: same feature, two populations, opposite outcomes

- **Where:** §3.2 ADHD is a small, perfect-scoring segment
- **This app does:** flexible X-per-period completion
- **User reaction:** praise
- **Magnitude:** adhd 5 (0.59%, EMERGING), all 5★, mean 5.00; +3 procrastination / executive-function
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13846753254`, `14385616593`, `13203214681`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R08-051 — Students are the largest named use case and the Pomodoro timer is the reason — 'a wonderful thing for me - a college student'; also fitness, mental health, quitting, medication, chores, ADHD

- **Where:** §3.3 What people actually track table (verbatim); Part 5 The student
- **This app does:** focus timer bundled free
- **User reaction:** praise
- **Magnitude:** Use case | Reviews | Examples ; Study / school / exams | 35 | `10288751850`(US) `13089862446`(IN) `12339105908`(VN) ; Fitness / gym | 14 | `12459196344`(CA) `13825204148`(AU) `10942821621`(DE, push-up counts) ; Mental health / meditation / self-care | 12 | `12738414001`(US) `11816718155`(US) `10841075611`(CA, a therapist recommending it to clients) ; Quitting / sobriety / bad habits | 11 | `12136485316`(US, alcohol) `14406483115`(US, days without a drink) `13848651353`(GB) ; Medication / vitamins | 4 | `9568937085`(US) `11174344440`(US) ; Household / chores | 4 | `13226885529`(DE) `14508260728`(CA) ; ADHD / neurodivergent / procrastination | 8 | see §3.2
- **Direction for us:** do · **Report confidence:** keyword scan · **Generalisable:** yes
- **Review IDs:** `10288751850`, `13089862446`, `12339105908`, `12459196344`, `12738414001`, `12136485316`, `14406483115`, `9568937085`, `13226885529`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C066 Focus timer

### R08-089 — The escapee: has downloaded 5–50 habit trackers and hit a paywall in each — 'I tried around 50 apps but either they were too expensive or bad ui, this app is literal gold'

- **Where:** Part 5 WHO ACTUALLY USES THIS — The escapee
- **This app does:** free alternative
- **User reaction:** 5★-burst
- **Magnitude:** 32 explicit (switched_from_paid), mean 4.94, 93.8% 5★
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10435965488`
- **Canonical:** — (nuance register)

### R08-090 — The minimalist actively wants fewer features — 'The developers understand that unnecessary features are a detractor to the app and should be minimized'

- **Where:** Part 5 The minimalist
- **This app does:** minimal
- **User reaction:** praise
- **Magnitude:** praise_simplicity 363 (42.71%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11926768986`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R08-091 — The cost-constrained cannot pay at all — 'thank you for making the app accessible and free for those who… cannot afford to pay a monthly fee'; 'In my country I can't use credit cards and almost every habit tracker on the App Store requires a premium account' — for them free is access, not value-for-money

- **Where:** Part 5 The cost-constrained
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** several quoted; emerging markets 166 reviews at mean 4.602
- **Direction for us:** do · **Report confidence:** quoted · **Generalisable:** yes
- **Review IDs:** `11770290555`, `10640982313`, `11504152895`, `12339105908`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK)

## Markets and languages

### R08-058 — Sync/backup demand by market group: India 14.10%, emerging group 9.64%, high-volume group 5.13%, US 2.66%

- **Where:** §4.3 Sync, backup, and device migration: the top gap in emerging markets table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Market group | n | Rate ; India (standalone) | 11 / 78 | 14.10% ; Emerging-market group (IN, PH, VN, ID, MX, BR, TR, EG, NG, PK, LK, ZA) | 16 / 166 | 9.64% ; High-review-volume group (US, DE, CA, IN, AU, GB) | 28 / 546 | 5.13% ; US (standalone) | 5 / 188 | 2.66%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-060 — India is the sync/backup market: device reset and replacement wipe habit history, and India's only 1★ is exactly this ('Unable to send tracker that I created to a different device')

- **Where:** §4.3 India names this at 5.3× the US rate; §7.1 finding 1
- **This app does:** no device transfer
- **User reaction:** 1★-burst
- **Magnitude:** IN 11 / 78 (14.10%, HIGH) vs US 5 / 188 (2.66%) — 5.3×; emerging group 16 / 166 (9.64%)
- **Direction for us:** must-have · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** yes
- **Review IDs:** `12874016631`, `10544874717`, `13668962217`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R08-073 — Unlocalized markets are not complaining, they are just smaller: only 5 localization requests despite 8 shipped languages — French requested although FR is listed (shipped in between, or the in-app language switch is not discoverable), plus Russian, Chinese, and a user who wanted to contribute a translation and couldn't; RU, ZH, TR, PT, PL, JA, KO are absent from the listing yet contributed 46 reviews at mean 4.72

- **Where:** §4.9 Only 5 localization requests despite 8 shipped languages
- **This app does:** 8 listing languages
- **User reaction:** none
- **Magnitude:** want_localization 5 (0.59%, EMERGING), mean 4.40; unlocalized storefronts 46 reviews at 4.72
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** contrast reports 1–5, where missing localisation blocked revenue — in a free app it blocks nothing
- **Review IDs:** `12266958159`, `13599411580`, `13115546891`, `12680364504`, `10640982313`
- **Canonical:** C027 Localise early — it unlocks revenue

### R08-094 — US / DE / CA / IN rating distributions against the 63 other storefronts

- **Where:** §7.1 The four eligible storefronts (≥50 reviews) table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | % corpus | Mean | 5★ | 4★ | 3★ | 2★ | 1★ ; US | 188 | 22.12% | 4.516 | 69.1% | 21.3% | 4.8% | 1.6% | 3.2% ; DE | 114 | 13.41% | 4.535 | 70.2% | 20.2% | 5.3% | 1.8% | 2.6% ; CA | 89 | 10.47% | 4.416 | 70.8% | 11.2% | 9.0% | 6.7% | 2.2% ; IN | 78 | 9.18% | 4.500 | 64.1% | 26.9% | 5.1% | 2.6% | 1.3% ; *All others (63 storefronts)* | 381 | 44.82% | 4.575 | — | — | — | — | —
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-095 — Canada is the weakest eligible storefront and it is a 2★ problem — every CA two-star is a usability or reliability failure (crashes, notification nagging, preset-habits-only, frequency options, trapped widget popup, janky animations, can't log today), none about price — while Canada also leads on praising no ads and the free position: the most price-position-aware and least tolerant of jank

- **Where:** §7.1 Canada is the weakest eligible storefront (4.416) and it is a 2★ problem specifically; finding 4
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** CA 89: mean 4.416; 2★ 6.7% (3× corpus 2.35%); perf_lag_crash 3 of 4; no ads 19.10%; free 41.57%
- **Direction for us:** none · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `8021289450`, `9386826805`, `10967703803`, `11083479860`, `11904827409`, `12547660463`, `13990708296`
- **Canonical:** — (nuance register)

### R08-096 — Country-level signal labels for simplicity, free, design, no ads, sync, multi-daily, stats, iPad/Mac, forced reminder, widget broken, WTP, switched from paid

- **Where:** §7.1 Signal labels applied at country level table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | US (n=188) | DE (n=114) | CA (n=89) | IN (n=78) ; praise_simplicity | 85 / 45.21% HIGH | 59 / 51.75% HIGH | 34 / 38.20% HIGH | 32 / 41.03% HIGH ; praise_free_nopaywall | 64 / 34.04% HIGH | 29 / 25.44% HIGH | 37 / 41.57% HIGH | 18 / 23.08% HIGH ; praise_design | 55 / 29.26% HIGH | 39 / 34.21% HIGH | 21 / 23.60% HIGH | 27 / 34.62% HIGH ; praise_no_ads | 12 / 6.38% HIGH | 11 / 9.65% HIGH | 17 / 19.10% HIGH | 12 / 15.38% HIGH ; want_sync_backup_account | 5 / 2.66% MEANINGFUL | 3 / 2.63% MEANINGFUL | 6 / 6.74% HIGH | 11 / 14.10% HIGH ; want_multi_daily_checkin | 15 / 7.98% HIGH | 1 / 0.88% Emerging | 3 / 3.37% V.STRONG | 0 / 0.00% — ; want_stats_analytics | 9 / 4.79% V.STRONG | 1 / 0.88% Emerging | 4 / 4.49% V.STRONG | 5 / 6.41% HIGH ; want_ipad_mac | 1 / 0.53% Emerging | 6 / 5.26% HIGH | 0 / 0.00% — | 2 / 2.56% MEANINGFUL ; forced_reminder (historical) | 3 / 1.60% MEANINGFUL | 6 / 5.26% HIGH | 1 / 1.12% MEANINGFUL | 0 / 0.00% — ; widget_broken | 0 / 0.00% — | 2 / 1.75% MEANINGFUL | 1 / 1.12% MEANINGFUL | 4 / 5.13% HIGH ; wtp_explicit | 4 / 2.13% MEANINGFUL | 5 / 4.39% V.STRONG | 0 / 0.00% — | 0 / 0.00% — ; switched_from_paid | 13 / 6.91% HIGH | 2 / 1.75% MEANINGFUL | 4 / 4.49% V.STRONG | 2 / 2.56% MEANINGFUL
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-097 — Germany is the willingness-to-pay market: 5 of the 13 WTP statements and 3 of 7 donate requests are German; DE also most wants iPad/Mac, historically drove the forced-reminder complaint, and writes the longest, most structured feedback (one 14-item numbered feature list)

- **Where:** §7.1 finding 2 — Germany is the willingness-to-pay market
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** DE 114: wtp_explicit 5 (4.39%, VERY STRONG); donate 3 of 7; want_ipad_mac 6 (5.26%); forced_reminder 6 (5.26%); simplicity 51.75%
- **Direction for us:** do · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `11593270170`, `8082446036`, `9011596308`, `14051428806`
- **Canonical:** C097 A tip / donate option

### R08-098 — The US is where the intra-day completion gap is felt — and where competitor-switching is most narrated

- **Where:** §7.1 finding 3 — The US is where the intra-day gap is felt
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** US 188: want_multi_daily_checkin 15 (7.98%, HIGH) vs DE 0.88% vs IN 0.00%; switched_from_paid 13 (6.91%)
- **Direction for us:** none · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N

### R08-099 — High-spend markets (US, JP, GB, DE, CA, FR, AU, KR, CN — a market-definition choice) rate Onrise lower than the rest of the world and complain more, but all 13 WTP statements and 6 of 7 donate requests come from them: if a paid add-on is ever built, DE and US are where the demand was voiced

- **Where:** §7.2 High-spend markets table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | High-spend group | Rest of world ; n | 500 (58.82%) | 350 ; Mean | 4.502 | 4.577 ; 5★ | 69.6% | 72.6% ; 1–2★ | 5.4% | 4.3% ; over-index: simplicity 45.20%, design 28.60%, journal 9.60%, all-in-one 8.40%; WTP 13 of 13 and donate 6 of 7 from high-spend (UA, IT the only exceptions)
- **Direction for us:** research · **Report confidence:** definitional grouping · **Generalisable:** yes
- **Conditions:** contrast report 7, where high-spend markets rated higher
- **Canonical:** — (nuance register)

### R08-100 — The markets that write the most rate the lowest (gap 0.11); GB is the weakest of the six (4.297, [limited evidence]) with the corpus's largest store-vs-written gap (−0.46) — review volume is an engaged-writer proxy, not downloads

- **Where:** §7.3 High-review-volume storefronts table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | High-volume group | Rest of world ; n | 546 (64.24%) | 304 ; Mean | 4.493 | 4.605 ; 5★ | 68.3% | 75.0% ; 1–2★ | 5.3% | 4.3%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-101 — Emerging markets are the most satisfied group and use the app differently: on older or replaced devices (device-migration data loss), relying heavily on the widget, without the journal/focus extras — and framing free as access, not value-for-money

- **Where:** §7.4 Emerging markets
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** IN, PH, VN, ID, MX, BR, TR, EG, NG, PK, LK, ZA = 166 (19.5%), mean 4.602, 1–2★ 3.0%; sync 9.64% vs 4.35%; widget requests 6.02% vs 4.82%; widget mentions 13.86% vs 10.12%; focus issues 5.42% vs 3.76%
- **Direction for us:** research · **Report confidence:** grouping · **Generalisable:** yes
- **Review IDs:** `11504152895`, `12339105908`
- **Canonical:** — (nuance register)

### R08-102 — Sub-50 notes [limited evidence]: Sweden produced the only 1★ over the can't-log-today defect and 2 of 18 Watch requests; France holds both French localization requests although FR is a listed language (a five-minute check of the in-app language switch); Vietnam and Italy are the only storefronts where the written mean meets or exceeds the store rating

- **Where:** §7.5 Sub-50 storefronts — limited-evidence notes
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 63 storefronts, 381 reviews (44.82%), mean 4.575; SE 19 (4.526); FR 25 (4.600); VN 13; IT 16
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `12164874968`, `12266958159`, `13599411580`
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R08-008 — By year and by quarter: 1★ rate went from ~1% in 2023–2024 to 4.2–4.8% in 2025–2026 (~4×); 2025Q3 is the worst quarter in the app's history

- **Where:** Part 0 §3 (The rating decline is a reliability story with a clear trough and a clear recovery) period and quarter tables (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Period | n | Mean | 5★ | 1★ | 1–2★ ; P1 — 2021 | 25 | 4.680 | 76.0% | 0.0% | 4.0% ; P2 — 2022 | 51 | 4.608 | 78.4% | 2.0% | 7.8% ; P3 — 2023 | 162 | 4.636 | 74.7% | 0.6% | 3.1% ; P4 — 2024 | 229 | 4.590 | 73.4% | 1.3% | 3.5% ; P5 — 2025 | 237 | 4.418 | 65.0% | 4.2% | 6.3% ; P6 — 2026 (Jan–Sep) | 146 | 4.466 | 67.8% | 4.8% | 6.2% || Quarter | n | Mean | 1–2★ ; 2025Q1 | 84 | 4.488 | 4.8% ; 2025Q2 | 54 | 4.574 | 3.7% ; 2025Q3 | 49 | 4.184 | 12.2% ; 2025Q4 | 50 | 4.360 | 6.0% ; 2026Q1 | 66 | 4.455 | 6.1% ; 2026Q2 | 46 | 4.435 | 8.7% ; 2026Q3 (partial) | 34 | 4.529 | 2.9%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-010 — The app broke and was then fixed: the functional-failure cluster (create failure, white screen, data loss, widget dead, can't-log-today, crashes/lag) tracks the rating curve, and 2026 has the lowest rate in five years — the rating has not yet recovered to match

- **Where:** Part 0 §3 functional-failure cluster table (verbatim)
- **This app does:** stalled then resumed development
- **User reaction:** 1★-burst
- **Magnitude:** 43 (5.06%), mean 2.79, 48.8% 1–2★; Year | Functional-failure reports | Rate ; 2021 | 1 / 25 | 4.0% ; 2022 | 2 / 51 | 3.9% ; 2023 | 7 / 162 | 4.3% ; 2024 | 12 / 229 | 5.2% ; 2025 | 17 / 237 | 7.2% ; 2026 | 4 / 146 | 2.7%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C071 Never ship and walk away

### R08-013 — What shipped and when, with the effect on complaint rates: optional reminders, monthly/yearly summaries, custom habit names, tick from the widget

- **Where:** Part 0 §5 (Development resumed in 2026 and reviewers noticed — this is measurable) table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Capability | First "it's missing" | First "it exists" | Effect in corpus ; Optional (not forced) reminders | `8492731197`(DE,2★, Mar 2022) | `9494382068`(CA,5★, Jan 2023) *"They've made notifications optional and added a widget after getting feedback from reviews"*; `10420089265`(DE,5★, Sep 2023) *"Der Feature-Wunsch, Erinnerungen optional… zu machen, wurde neulich umgesetzt"* | forced-reminder complaints 17.6% of 2022 → 0.6% of 2023 → 0.0% of 2025–26 ; Monthly / yearly summaries | `7893057575`(US,4★, Oct 2021) | `13742512516`(US, Feb 2026) *"Then they released their monthly At a Glance feature"*; `14254399815`(US,5★, Jul 2026) *"Love the update that brought us the monthly and yearly summaries"* | stats requests 6.8% of 2025 → 3.4% of 2026 ; Custom (non-preset) habit names | `10105619469`(DE,1★, Jul 2023) | `13581401872`(US,4★, Jan 2026) *"I like the choices of goals and that you can add custom goals"*; `14326501421`(US,5★, Jul 2026) *"very customizable even down to the color, order, frequency"* | "only preset habits" 2.5% of 2025 → 0.7% of 2026 ; Tick a habit from the widget | `11940800533`(DE,3★, Nov 2024) *"Can't tick the habits from the widget"* | `14502932053`(US,4★, Sep 2026) *"Really appreciate the ease of adding ticks from the homepage widget"* | widget requests 4.6% of 2025 → 2.1% of 2026
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `8492731197`, `9494382068`, `10420089265`, `7893057575`, `13742512516`, `14254399815`, `10105619469`, `13581401872`, `14326501421`, `11940800533`, `14502932053`
- **Canonical:** — (nuance register)

### R08-104 — The causal chain: development stalled (last update ~mid-2024) → iOS moved on → widget, create flow, day-boundary and launch paths broke → functional failures rose to 7.2% of 2025 → 2025Q3 mean fell to 4.184 with 12.2% 1–2★ → development resumed → functional failures fell to 2.7% of 2026, the lowest in five years; abandonment concern appears only in 2024–2025 and is absent from all 146 reviews of 2026

- **Where:** §8.2 Trend 1 — a real quality regression in 2025, and a real recovery in 2026
- **This app does:** paused development ~mid-2024 → resumed 2026
- **User reaction:** 1★-burst
- **Magnitude:** functional failures 5.2% (2024) → 7.2% (2025) → 2.7% (2026); 2025Q3 4.184 / 12.2%; abandonment 7 in 2024–25, 0 in 2026
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a pause is not neutral: OS updates break a frozen app
- **Canonical:** C071 Never ship and walk away

### R08-105 — Four fixes and their before/after complaint rates — the forced-reminder theme, the single largest friction in 2022, was eliminated to zero and stayed there for two years and 383 reviews

- **Where:** §8.3 Trend 2 — shipping against reviews demonstrably works here table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Fix | Complaint rate before | Complaint rate after ; Optional (not forced) reminders, ~mid-2023 | 17.6% of 2022 (9/51) | 0.6% of 2023 → 0.0% of 2025–26 (0/383) ; Monthly / yearly summaries, ~Jan 2026 | 6.8% of 2025 | 3.4% of 2026 ; Custom habit names / colours / ordering, ~late 2025 | 2.5% of 2025 | 0.7% of 2026 ; Widget tap-to-tick, ~mid-2026 | 4.6% of 2025 | 2.1% of 2026
- **Direction for us:** do · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R08-106 — Five years in, the free position is praised at the highest rate in the app's history — no fatigue effect, no sign it stopped being remarkable — while fear of monetization appeared only from 2023 and peaked in 2025, when the app looked abandoned

- **Where:** §8.4 Trend 3 — the free position has held constant and never eroded
- **This app does:** free since 2021
- **User reaction:** praise
- **Magnitude:** praise_free_nopaywall 4.0% (2021) → 29.4% → 32.1% → 36.7% → 32.1% → 39.0% (2026); fear_monetization peak 2.5% (2025)
- **Direction for us:** product-rule · **Report confidence:** observed · **Generalisable:** app-specific
- **Canonical:** C001 Never move a free feature behind the paywall

### R08-107 — 2025 → 2026: functional failures, stats, custom habits, backfill and focus-timer complaints all fell; sync held; multi-daily check-in is the only complaint theme rising; design and simplicity praise are declining monotonically (design 60.0% in 2021 → 15.1%; simplicity peak 48.8% in 2023 → 34.2%) — partly novelty decay and reviewer-base broadening, while the app added a summary, colours, ordering and an iOS 26 redesign

- **Where:** §8.5 Trend 4 — the residual complaint is now capability, not reliability table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 2025 rate | 2026 rate | Direction ; Functional failures (aggregate) | 7.2% | 2.7% | ✅ resolved ; want_stats_analytics | 6.8% | 3.4% | ✅ improving ; custom_habit_blocked | 2.5% | 0.7% | ✅ resolved ; want_backfill_past | 5.5% | 2.7% | ✅ improving ; want_sync_backup_account | 4.6% | 2.7% | ↔ still open ; focus_timer_issue | 4.2% | 1.4% | ✅ improving ; want_multi_daily_checkin | 3.0% | 8.2% | ❌ worsening ; praise_design | 19.4% | 15.1% | ❌ declining ; praise_simplicity | 40.9% | 34.2% | ❌ declining
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-109 — New Year seasonality is large and the January cohort judges onboarding, not retention: reviews are written in the first days ('I'm only on my second day'; 'I have never written a review before this one'), so every onboarding defect — create flow, preset picker, can't-log-today, widget overlay — is amplified ~2× in January; the can't-log-today cluster itself sits in January 2025

- **Where:** §8.6 Trend 5 — New Year seasonality is real and large
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** January reviews 2021: 7 · 2022: 1 · 2023: 20 · 2024: 21 · 2025: 49 · 2026: 31; Jan 2025 = 20.7% of 2025; can't-log-today 3 of 11 in a 14-day Jan 2025 window
- **Direction for us:** do · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `13581401872`, `12138019597`
- **Canonical:** C032 New Year peak-season robustness — year-end report and January onboarding

## Positioning

### R08-001 — Onrise — Habit Tracker & Focus (App Store ID 1547137474) is a solo-indie habit tracker + Pomodoro focus timer + journal that is completely free — no in-app purchases, no subscription, no ads, no account, no server-side data; 850 written reviews at mean 4.533

- **Where:** header lines 1-8
- **This app does:** developer Maximilian Munker (solo indie); bundle me.onrise; site onrise.me; Productivity; 4+; original release 3 Jan 2021; v1.1.9 25 Aug 2026 ('Refreshed for iOS 26 with Liquid Glass navigation, redesigned Wrapped stories'); iOS 13.0+, 20.5 MB; listing languages NL, EN, FR, DE, HI, IT, ES, SV; store rank 8 in this set
- **User reaction:** praise
- **Magnitude:** 850 reviews, 67 storefronts, 9 Jan 2021 → 6 Sep 2026 (5 yr 8 mo); 5★ 601 (70.71%) · 4★ 165 (19.41%) · 3★ 42 (4.94%) · 2★ 20 (2.35%) · 1★ 22 (2.59%); US store 4.836 on 2,547 ratings
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-004 — 'Free' is the product's entire market position, not a pricing decision: reviewers say the absence of a paywall is the reason they chose it — 'The app is completely free, I can't even find its premium version'; '(3) doesn't push you to pay for a premium version since it doesn't exist!'; the most-voted review: 'I created a few quick habits expecting to see that pop up after 5 habits but it never did… I wasn't sure if there was a catch' — a business-model position in a category where every competitor gates 3–5 habits behind a subscription, doing all the acquisition work, and the single most fragile asset in the product

- **Where:** Part 0 §1 ('Free' is not a pricing decision here — it is the product's entire market position); §8.4
- **This app does:** free, no paywall, no subscription, no IAP
- **User reaction:** praise
- **Magnitude:** praise_free_nopaywall 285 (33.53%, HIGH-PRIORITY), mean 4.81, 88.4% 5★; money talk 308 (36.24%) — second-largest theme behind simplicity (42.71%), ahead of design (26.94%); 274 of 601 5★ (45.6% segment rate); free praise by year 4.0% (2021) → 29.4% → 32.1% → 36.7% → 32.1% → 39.0% (2026), no fatigue
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Conditions:** only a differentiator while competitors paywall; it cannot be walked back without converting praise into the category's standard complaint
- **Review IDs:** `11533284738`, `12534773715`, `10972915619`, `12502921315`
- **Canonical:** C001 Never move a free feature behind the paywall

### R08-028 — Users abandon paid competitors for Onrise — the purest positive signal in the corpus — including one who left a competitor the moment it added a paywall: 'definitely #2 behind Emphasis (which I don't use anymore because they added a paywall)'

- **Where:** Part 0 §10 32 reviews explicitly describe abandoning a paid competitor; Part 3 switched_from_paid
- **This app does:** free alternative
- **User reaction:** 5★-burst
- **Magnitude:** switched_from_paid 32 (3.76%, VERY STRONG), mean 4.94, 93.8% 5★, zero 1–2★; US 13 (6.91%)
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Side effects:** a competitor's re-paywall is a user-acquisition event for a free rival
- **Review IDs:** `10278427560`
- **Canonical:** C001 Never move a free feature behind the paywall; C005 Know which competitors buyers compare against

### R08-029 — Onrise wins on a category-level objection ('they all charge'), not head-to-head comparison: the competitive set is described generically ('50 apps', 'a bunch of habit trackers'); named mentions are rare

- **Where:** Part 0 §10 Notably, reviewers almost never name competitors
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** named mentions: Atomic Habits/Atoms 5, Fabulous 2, Emphasis, TickTick, Notion, Obsidian, Study Bunny, InnerGrow, Loop 1 each
- **Direction for us:** none · **Report confidence:** observed · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R08-007 — Category norms are so strong that a user assumed a free cap that does not exist and left 1★ — 'Because you should let us make more routines for free' — a positioning failure: the app's biggest differentiator (no paywall) is absent from the store listing

- **Where:** Part 0 §2 The one apparent exception — a positioning failure; Part 9 #17
- **This app does:** no cap, but listing never says so
- **User reaction:** 1★-burst
- **Magnitude:** 1 (1★, HR, Jan 2026)
- **Direction for us:** do · **Report confidence:** quoted (n = 1) · **Generalisable:** yes
- **Review IDs:** `13650696629`
- **Canonical:** C134 Lead the store listing with what users actually love

### R08-011 — Staleness is visible to users and they say so with dates: 'a shame nothing has been updated for a long time'; 'last version update was a year ago'; title 'Hope you're still working on it'; 'Must be outdated and should be removed from Apple Apps listings' (1★); 'i dont know how creators of this app make money but I hope you don't delete or abandon this app' — clustered exactly in the 2024–2025 trough, then zero in 2026

- **Where:** Part 0 §4 (The staleness is documented by reviewers, in their own words, with dates); §8.2
- **This app does:** no updates ~mid-2024 → resumed 2026
- **User reaction:** mixed
- **Magnitude:** abandonment_concern 7 (0.82%, EMERGING), mean 4.29, 14.3% 1–2★; Jul 2024 – Dec 2025; 0 of 146 in 2026
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11867322000`, `12146578302`, `12600586522`, `12936436921`, `13343619642`, `13486858510`, `11504152895`
- **Canonical:** C071 Never ship and walk away

### R08-069 — A promotional widget-onboarding modal blocked the app on small screens for at least 20 months: a full-screen 'Never miss a habit again. Add widgets to your Home Screen' prompt with an unreachable dismiss button — 'I can't x out the ad… and I can't use the app now'; 'The Never miss a habit again screen is literally causing me to do just that'

- **Where:** §4.6 trapped by the widget-onboarding overlay
- **This app does:** undismissable full-screen promo on small screens
- **User reaction:** 1★-burst
- **Magnitude:** bug_widget_popup 4 (0.47%, Weak), mean 3.75, 25.0% 1–2★; Apr 2023 → Nov 2024
- **Direction for us:** dont · **Report confidence:** weak, blocking · **Generalisable:** yes
- **Review IDs:** `9874416341`, `11040279138`, `11904827409`, `9667803845`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C145 Every promotional or onboarding modal must be dismissible on the smallest screen

## Things not to do

### R08-012 — Never leave dated, year-branded content live: a 'Wrapped 2022' button still in settings in a July 2025 build dated the product by three years inside its own settings screen — 'I only hope this isn't a failed project nobody cares about any more'

- **Where:** Part 0 §4 The Wrapped 2022 button — the single most damning artefact
- **This app does:** Wrapped 2022 button live in 2025
- **User reaction:** complaint
- **Magnitude:** 1 review (5★, DE, Jul 2025); 'the single most damning artefact in the corpus'
- **Direction for us:** dont · **Report confidence:** quoted (n = 1) · **Generalisable:** yes
- **Review IDs:** `12936436921`
- **Canonical:** C071 Never ship and walk away

## Things to do

### R08-037 — A free app with no visible business model invites suspicion: 'I'm aware that you need to get money from somewhere since this app is 100% free… but I wish there was more transparency' (asked whether journal entries are collected, could not find it in the privacy policy); 'i dont know how creators of this app make money'; a 1★ escalated it to a tracking accusation — 'it is constantly on and running watching my every move' — publish a one-line in-app note on how the app is funded and what data it collects

- **Where:** §1.4 friction 2 — the free position invites suspicion; Part 4 privacy_concern; Part 9 #18
- **This app does:** no funding / data statement
- **User reaction:** 1★-burst
- **Magnitude:** 3 reviews speculate; privacy_concern 2 (0.24%), mean 2.50; praise_privacy 6 (0.71%), mean 4.00
- **Direction for us:** do · **Report confidence:** weak, cheap · **Generalisable:** yes
- **Review IDs:** `10309724588`, `11504152895`, `14220350355`
- **Canonical:** C085 Address tracking / privacy visibly

### R08-126 — Say 'free forever, no subscription, no ads, no account' in the App Store subtitle and first description line — the listing leads with behaviour-design language and never mentions the price model, so a third of reviewers discover it by surprise and one assumed a paywall

- **Where:** Part 9 #17 Positioning — Say free forever, no subscription, no ads, no account in the App Store subtitle
- **This app does:** listing silent on price model
- **User reaction:** praise
- **Magnitude:** 33.53% free praise; 1 paywall misconception 1★
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-004, R08-007
- **Review IDs:** `10972915619`, `13650696629`
- **Canonical:** C134 Lead the store listing with what users actually love

### R08-127 — Publish a one-line 'how this app is funded / what data it collects' note in-app — three reviewers speculated publicly and one escalated to a 1★ tracking accusation

- **Where:** Part 9 #18 Publish a one-line how this app is funded / what data it collects note in-app
- **This app does:** no statement
- **User reaction:** 1★-burst
- **Magnitude:** 3 reviews
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R08-037
- **Review IDs:** `14220350355`
- **Canonical:** C085 Address tracking / privacy visibly

## Contradictions

### R08-055 — A bounded backfill window (~7 days) is report 8's worst-rated request (mean 3.52) — against report 1, where users accepted a bounded free backfill window

- **Where:** §4.1 backfill 7-day wall vs report 1 bounded backfill
- **This app does:** ~7-day backfill in a free app
- **User reaction:** complaint
- **Magnitude:** 27 at 3.52 (penalty −1.01)
- **Direction for us:** must-have · **Report confidence:** cross-report tension · **Generalisable:** yes
- **Conditions:** report 8's users also lack stats/history views, so the window is the only way back; report 1 paired a bounded window with rich history views and a paid unlock
- **Canonical:** C010 Backfill missed days / edit start date

### R08-108 — Onrise's Aug 2026 iOS 26 Liquid Glass refresh drew zero complaints — against report 7, where HabitKit's Aug 2026 compact-list redesign produced a dated 1★/2★ backlash within weeks

- **Where:** §8.5 There is no design *backlash* in the corpus — zero reviews complain about the Aug 2026 Liquid Glass refresh
- **This app does:** platform-native visual refresh (Liquid Glass navigation, redesigned Wrapped stories)
- **User reaction:** none
- **Magnitude:** 0 redesign complaints
- **Direction for us:** none · **Report confidence:** absence · **Generalisable:** yes
- **Conditions:** a platform-native refresh that keeps layout and density differs from a redesign that changes text size, density and labels (report 7)
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

## Data caveats and method

### R08-002 — Method: denominator 850, non-exclusive themes; only US (188), DE (114), CA (89), IN (78) clear 50 — 469 reviews (55.2%), the other 63 storefronts (381) are [limited evidence]; hybrid classification — 15 broad praise themes by multilingual regex (±3–5%; 1–2★ members inspected, ~0.3% observed error), every request, bug and money theme hand-curated (the multi-daily regex returned 38 candidates of which 22 were genuine; rebuilt from the read to 36); no version, device or OS field; only 9.4% of raters write; many reviews written in the first days of use (over-measures onboarding, under-measures retention); 2021 (n=25) and 2022 (n=51) swing on 1–2 reviews; only 3 stated uninstalls — silent churn invisible; market-group definitions are external judgements

- **Where:** How to read this; Part 10 method (skimmed)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 850 records, 0 duplicates, reconciles with by_country and manifest; 62 themes; bands <0.1% ignore … >5% high-priority
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R08-003 — Onrise has no monetization at all, confirmed three ways — listing price Free, zero of 850 reviews report paying, subscribing, restoring or refunding, and all 27 'premium/pro/upgrade' mentions describe a competitor's paywall or note that Onrise has none — so this report is a natural experiment in what a habit tracker's reviews look like with price off the table; Part 1 analyses unmonetized willingness to pay and the acquisition engine 'free' buys

- **Where:** ⚠️ Read this before anything else: Onrise has no monetization at all
- **This app does:** free, no IAP, no subscription, no ads, no donation mechanism
- **User reaction:** none
- **Magnitude:** 0 of 850 paid; 27 premium mentions all about competitors
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-005 — Reasons behind all 42 one- and two-star reviews, read individually

- **Where:** Part 0 §2 (Not one of the 42 one- and two-star reviews is a price complaint) table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1–2★ reason | n | of 42 ; App is functionally broken (won't open, can't create, data lost, can't log, widget dead, crashes/lag) | 18 | 42.9% ; Missing capability (multi-daily check-in, stats, frequency options, custom habits, export) | 13 | 31.0% ; UI/UX confusion or friction (forced reminders, notification nagging, layout) | 7 | 16.7% ; Off-topic / philosophical / rating-text mismatch | 3 | 7.1% ; Price / paywall objection | 0 | 0.0% ; Paywall *misconception* (believes a free cap exists that does not) | 1 | 2.4%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13650696629`
- **Canonical:** — (nuance register)

### R08-018 — The eleven 'can't check off today' reports with country, rating, date and quote

- **Where:** Part 0 §7 ('I can't check off today' is a small, sharp, high-severity usability failure) table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** ID | CC | ★ | Date | What they say ; `12164874968` | SE | 1 | 2025-01-09 | *"I have to click on done the day before and not on the day that I'm going the things"* ; `12189113218` | SG | 1 | 2025-01-15 | *"not able to log it into the app once the time passes. and i've actually done it"* ; `12214950748` | HU | 2 | 2025-01-22 | *"couldn't mark my gym task as completed because it was after the reminder"* ; `12219310786` | ID | 4 | 2025-01-23 | *"the app only let me checklist something tomorrow… doesn't allow me checklist something I've done for today"* ; `12683838260` | AU | 4 | 2025-05-22 | *"Why I can't record I did the thing… on the same day of setting up the habit?"* ; `12919299992` | US | 3 | 2025-07-21 | *"If I do something on Monday it'll show that I did it on Tuesday"* ; `13990708296` | CA | 2 | 2026-04-24 | *"I am not able to select today's slot for any task. I can only select tomorrow."* ; `10029070611` | AU | 5 | 2023-06-13 | *"not sure why my days of the week up the top start on a Wednesday?"* ; `10759265147` | US | 4 | 2023-12-29 | *"it just reverted me to the week prior… and has me missing a day"* ; `11240015364` | US | 3 | 2024-05-06 | *"after the first day of having it I realized that they were right"* (about tracking not registering) ; `8922203790` | US | 1 | 2022-07-29 | *"You track 4 times you did a habit, it'll show 6"*
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `12164874968`, `12189113218`, `12214950748`, `12219310786`, `12683838260`, `12919299992`, `13990708296`, `10029070611`, `10759265147`, `11240015364`, `8922203790`
- **Canonical:** — (nuance register)

### R08-020 — The thirteen explicit willingness-to-pay statements with date and what was offered

- **Where:** Part 0 §8 (There is real, articulate, unmonetized willingness to pay — but it is tip-shaped, not subscription-shaped) table (verbatim)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** ID | CC | ★ | Date | What they offered ; `8082446036` | DE | 5 | 2021-12 | *"Mit Apple Watch Integration würde ich hierfür auch sehr gerne Geld zahlen"* — would pay for a Watch app ; `9011596308` | DE | 4 | 2022-08 | *"kein Abo Modell obwohl ich hierfür tatsächlich Geld bezahlen würde"* ; `9473744662` | US | 5 | 2023-01 | *"you guys should definitely start charging 4.99 or smth… bc I would buy this app"* ; `9853721563` | DE | 5 | 2023-04 | *"diese app ist mindestens ein paar euro wert"* ; `9979231109` | US | 5 | 2023-05 | *"this app is worth a fee. A one time fee to get the app."* ; `10066041778` | US | 5 | 2023-06 | *"I wish the developer of this app charged a small fee because I would like to support the ongoing development"* ; `10117160205` | US | 5 | 2023-07 | *"it would be very nice if there is an app on Apple Watch too. You can make this a premium feature as I know this is not an easy task"* ; `10153094810` | AU | 5 | 2023-07 | *"No up front cost but I would so pay a once-off for this"* ; `10529311558` | UA | 5 | 2023-10 | *"ready to even buy, but it is also free"* ; `13920667278` | UA | 5 | 2026-04 | *"If there would be some subs I wouldn't use it, but I could buy it for 5-10 bucks if it provided the full experience forever"* ; `14051428806` | DE | 5 | 2026-05 | *"Hier wäre es sogar in Ordnung ein paar Euro in die Hand zu nehmen (wenn es ein Einmalkauf wäre)"* ; `14359179692` | US | 4 | 2026-07 | *"would be willing to pay up to 4.99 a month for more features, e.g. folders for sorting habits, daily journal prompts"* ; `14491074038` | DE | 5 | 2026-08 | *"I would love to have more features so I can buy a premium version or VIP version for more features in the future"*
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `8082446036`, `9011596308`, `9473744662`, `9853721563`, `9979231109`, `10066041778`, `10117160205`, `10153094810`, `10529311558`, `13920667278`, `14051428806`, `14359179692`, `14491074038`
- **Canonical:** — (nuance register)

### R08-025 — Written reviews sit below tap-only ratings in 11 of 13 storefronts (the two exceptions are the smallest); only 9.4% of raters write (677 written vs 7,184 ratings); the public 4.8 is collected at moments of satisfaction — the written corpus says 4.47 for 2026

- **Where:** Part 0 §9 (The public rating is 0.14–0.46 stars above what people write) table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | Store rating (all ratings) | Store rating count | This corpus (written only) | n | Gap | Written as % of ratings ; US | 4.836 | 2,547 | 4.516 | 188 | −0.32 | 7.4% ; DE | 4.807 | 1,081 | 4.535 | 114 | −0.27 | 10.5% ; CA | 4.808 | 924 | 4.416 | 89 | −0.39 | 9.6% ; IN | 4.814 | 903 | 4.500 | 78 | −0.31 | 8.6% ; AU | 4.810 | 431 | 4.600 | 40 | −0.21 | 9.3% ; GB | 4.762 | 311 | 4.297 | 37 | −0.46 | 11.9% ; FR | 4.792 | 250 | 4.600 | 25 | −0.19 | 10.0% ; MX | 4.918 | 232 | 4.783 | 23 | −0.14 | 9.9% ; SE | 4.726 | 124 | 4.526 | 19 | −0.20 | 15.3% ; NL | 4.780 | 91 | 4.556 | 18 | −0.22 | 19.8% ; PH | 4.891 | 110 | 4.706 | 17 | −0.19 | 15.5% ; IT | 4.724 | 116 | 4.750 | 16 | +0.03 | 13.8% ; VN | 5.000 | 64 | 5.000 | 13 | +0.00 | 20.3%
- **Direction for us:** do · **Report confidence:** observed · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R08-030 — Everything is free — unlimited habits, multiple reminders, widget, focus timer, journal, streaks, summaries, custom names/colours; nothing paid exists; export, iCloud sync/backup/account, Apple Watch, iPad-native and macOS do not exist

- **Where:** Part 1 intro; §1.1 The model, reconstructed from the corpus + listing; Free / paid split as reviewers experience it table (verbatim)
- **This app does:** free: price 0.0, no subscription, no IAP, no ads, no account, no server-side data
- **User reaction:** praise
- **Magnitude:** 308 reviews (36.24%) touch money; Capability | Status in reviews | Evidence ; Unlimited habits | Free (confirmed continuously 2021→2026) | 37 reviews (`praise_unlimited`), e.g. `7804733382` `11533284738` `14060433155` ; Habit reminders (multiple per day) | Free | `10477081447` `11753781965` ; Home-screen widget | Free | `11170921819`(CA,5★) *"the first habit tracking app that I don't have to pay for and can have a widget"* ; Pomodoro / focus timer + break timer | Free | 61 reviews ; Journal, per-habit notes | Free | 65 reviews ; Streaks, counts, calendar view | Free | `10400204219` `13469873434` ; Monthly / yearly summaries ("At a Glance", "Wrapped") | Free, shipped ~Jan 2026 | `13742512516` `14254399815` `14359179692` ; Custom habit names, colours, ordering | Free, discoverability problems 2023–2025 | `14326501421` `13581401872` ; Anything paid | Does not exist | 0 of 850 ; Data export / CSV | Does not exist (12 requests) | `13311871983`(EG,1★) ; iCloud sync / backup / account | Does not exist (37 requests) | `12874016631`(IN,1★) ; Apple Watch / iPad-native / macOS | Does not exist (18 + 11 requests) | `12082430684`(SE,4★)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `7804733382`, `11533284738`, `14060433155`, `10477081447`, `11753781965`, `11170921819`, `10400204219`, `13469873434`, `13742512516`, `14254399815`, `14359179692`, `14326501421`, `13581401872`, `13311871983`, `12874016631`, `12082430684`
- **Canonical:** — (nuance register)

### R08-035 — The money-aware cohort (308) rates far higher than the rest — but it is a selection artefact as much as a satisfaction one: people who write about the price being zero liked it enough to notice; it establishes a positioning fact (a third of writers spend their review on the free position), not that free causes satisfaction

- **Where:** §1.2 There is no paid cohort — so here is the cohort that matters instead table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** | Money-aware (n=308) | Rest of corpus (n=542) ; Mean rating | 4.82 | 4.36 ; 5★ | 89.0% | 60.3% ; 1–2★ | 1.9% | 6.6%
- **Direction for us:** none · **Report confidence:** segment rate caution · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-036 — Stated purchase triggers (intentions only): Apple Watch app 2, folders + journal prompts 1 (the only $/month statement), 'the full experience forever' 1 ($5–10 one-time), unspecified more features 2, support the dev 7, 'worth a fee' 5 — do not read conversion into this: 20 of 850 writers is sentiment, and writers are ~9.4% of raters self-selected for enthusiasm

- **Where:** §1.3 What would trigger a purchase — stated in reviewers' own words table (verbatim)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Named trigger | Reviews | Evidence ; Apple Watch app | 2 | `8082446036`(DE) *"Mit Apple Watch Integration würde ich hierfür auch sehr gerne Geld zahlen"*; `10117160205`(US) *"You can make this a premium feature"* ; Folders / sorting + journal prompts | 1 | `14359179692`(US) — the only stated *subscription* price point in the corpus ($4.99/mo) ; "The full experience forever" | 1 | `13920667278`(UA) — $5–10 one-time ; Unspecified "more features" | 2 | `14491074038`(DE) `14051428806`(DE) ; Pure gratitude / support the dev | 7 | the `want_donate` cluster ; Nothing specific — "worth a fee" | 5 | `9473744662` `9853721563` `9979231109` `10066041778` `10153094810`
- **Direction for us:** research · **Report confidence:** stated intentions only · **Generalisable:** app-specific
- **Review IDs:** `8082446036`, `10117160205`, `14359179692`, `13920667278`, `14491074038`, `14051428806`, `9473744662`, `9853721563`, `9979231109`, `10066041778`, `10153094810`
- **Canonical:** — (nuance register)

### R08-040 — 5★ themes (segment rates of 601): simplicity 46.9%, money / free position 45.6%, design 27.6%, no ads 12.3%, developer 10.0%, journal 8.0%, all-in-one 7.2%, focus 7.2%, unlimited 5.3%, switched from paid 5.0%

- **Where:** Part 2 5★ — n = 601 (70.71%) table (verbatim)
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** Theme | n | % of 5★ band ; praise_simplicity | 282 | 46.9% ; money / free position | 274 | 45.6% ; praise_design | 166 | 27.6% ; praise_no_ads | 74 | 12.3% ; praise_developer | 60 | 10.0% ; journal | 48 | 8.0% ; all-in-one bundle | 43 | 7.2% ; focus/Pomodoro | 43 | 7.2% ; unlimited habits | 32 | 5.3% ; switched from a paid competitor | 30 | 5.0%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-046 — 1★ causes: can't log today 3, can't create 3, lag/crash 2, white screen 2, no backfill 2 — money/price objection 0; full chronological list of 22 with cause

- **Where:** Part 2 1★ — n = 22 (2.59%) — broken, not expensive table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of 1★ band ; bug_cannot_log_today | 3 | 13.6% ; bug_cannot_create | 3 | 13.6% ; perf_lag_crash | 2 | 9.1% ; bug_white_screen | 2 | 9.1% ; want_backfill_past | 2 | 9.1% ; money/price objection | 0 | 0.0%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `8922203790`, `10105619469`, `11648694059`, `12002553577`, `12122331747`, `12164874968`, `12189113218`, `12874016631`, `12982290428`, `13032792258`, `13089378849`, `13120591145`, `13311871983`, `13343619642`, `13344176512`, `13633911646`, `13650696629`, `13724690797`, `13742512516`, `14021302236`, `14051523206`, `14220350355`
- **Canonical:** — (nuance register)

### R08-047 — Rating/text mismatches inflate the 2026 1★ rate: three of seven 2026 one-stars contain net-positive text — one is unbroken praise ('The perfect habit tracker with reminders and an helpful widget… super cool that it's free too'); the true 2026 defect-driven 1★ rate is closer to 4/146 (2.7%) than 7/146 (4.8%)

- **Where:** Part 2 1★ Three of the seven 2026 one-star reviews contain net-positive text
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 2026 1★ 7/146 (4.8%) → defect-driven 4/146 (2.7%)
- **Direction for us:** none · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `13633911646`, `13724690797`
- **Canonical:** — (nuance register)

### R08-048 — Twenty praise themes with n, %, mean, 1–2★%, 5★% and signal

- **Where:** Part 3 WHAT PEOPLE PRAISE (full table) (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of 850 | Mean | 1–2★% | 5★% | Signal ; praise_simplicity | 363 | 42.71% | 4.70 | 1.7% | 77.7% | HIGH ; money_any (all money talk) | 308 | 36.24% | 4.82 | 1.9% | 89.0% | HIGH ; praise_free_nopaywall | 285 | 33.53% | 4.81 | 2.1% | 88.4% | HIGH ; praise_design | 229 | 26.94% | 4.64 | 3.1% | 72.5% | HIGH ; praise_no_ads | 88 | 10.35% | 4.78 | 2.3% | 84.1% | HIGH ; praise_developer | 67 | 7.88% | 4.79 | 3.0% | 89.6% | HIGH ; praise_journal | 65 | 7.65% | 4.68 | 0.0% | 73.8% | HIGH ; praise_reminders (any mention) | 64 | 7.53% | 4.23 | 9.4% | 53.1% | HIGH ; praise_focus_pomodoro | 61 | 7.18% | 4.67 | 0.0% | 70.5% | HIGH ; praise_allinone | 58 | 6.82% | 4.72 | 0.0% | 74.1% | HIGH ; praise_unlimited | 37 | 4.35% | 4.84 | 0.0% | 86.5% | VERY STRONG ; praise_streak | 36 | 4.24% | 4.36 | 5.6% | 50.0% | VERY STRONG ; switched_from_paid | 32 | 3.76% | 4.94 | 0.0% | 93.8% | VERY STRONG ; widget_positive_only | 28 | 3.29% | 4.61 | 3.6% | 71.4% | VERY STRONG ; praise_effect_outcome | 20 | 2.35% | 5.00 | 0.0% | 100.0% | MEANINGFUL ; fear_monetization | 12 | 1.41% | 5.00 | 0.0% | 100.0% | MEANINGFUL ; want_donate | 7 | 0.82% | 5.00 | 0.0% | 100.0% | EMERGING ; praise_privacy | 6 | 0.71% | 4.00 | 16.7% | 50.0% | EMERGING ; adhd | 5 | 0.59% | 5.00 | 0.0% | 100.0% | EMERGING ; praise_no_account | 4 | 0.47% | 4.00 | 25.0% | 50.0% | Weak
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-053 — Thirty-seven complaint / request themes; 32.1% of reviews (273) carry at least one feature request, 16.2% (138) report a bug, defect or confusion, 55.6% (473) are pure praise with neither

- **Where:** Part 4 COMPLAINTS AND UNMET NEEDS (full table) (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 850 | Mean | 1–2★% | 5★% | Signal ; want_stats_analytics | 47 | 5.53% | 4.11 | 0.0% | 29.8% | HIGH ; want_widget_better | 41 | 4.82% | 4.56 | 0.0% | 63.4% | VERY STRONG ; want_sync_backup_account | 37 | 4.35% | 4.30 | 5.4% | 51.4% | VERY STRONG ; want_multi_daily_checkin | 36 | 4.24% | 3.94 | 5.6% | 27.8% | VERY STRONG ; focus_timer_issue | 32 | 3.76% | 4.34 | 3.1% | 46.9% | VERY STRONG ; want_backfill_past | 27 | 3.18% | 3.52 | 14.8% | 14.8% | VERY STRONG ; frequency_confusion | 25 | 2.94% | 3.76 | 12.0% | 16.0% | MEANINGFUL ; want_colors_custom | 20 | 2.35% | 4.35 | 0.0% | 50.0% | MEANINGFUL ; notif_problem | 19 | 2.24% | 3.47 | 15.8% | 15.8% | MEANINGFUL ; want_apple_watch | 18 | 2.12% | 4.61 | 0.0% | 66.7% | MEANINGFUL ; custom_habit_blocked | 13 | 1.53% | 3.77 | 15.4% | 30.8% | MEANINGFUL ; widget_broken | 13 | 1.53% | 3.62 | 15.4% | 23.1% | MEANINGFUL ; want_export | 12 | 1.41% | 4.08 | 8.3% | 41.7% | MEANINGFUL ; want_ipad_mac | 11 | 1.29% | 4.45 | 0.0% | 54.5% | MEANINGFUL ; forced_reminder (historical) | 11 | 1.29% | 4.36 | 9.1% | 54.5% | MEANINGFUL ; ui_confusion | 11 | 1.29% | 2.91 | 45.5% | 0.0% | MEANINGFUL ; bug_cannot_log_today | 11 | 1.29% | 2.73 | 45.5% | 9.1% | MEANINGFUL ; want_log_quantity | 9 | 1.06% | 4.56 | 0.0% | 55.6% | MEANINGFUL ; data_loss | 9 | 1.06% | 2.67 | 66.7% | 11.1% | MEANINGFUL ; want_folders_groups | 9 | 1.06% | 4.22 | 0.0% | 44.4% | MEANINGFUL ; want_social_share | 9 | 1.06% | 4.33 | 0.0% | 33.3% | MEANINGFUL ; want_todo_list | 7 | 0.82% | 4.71 | 0.0% | 71.4% | EMERGING ; want_skip_vacation | 7 | 0.82% | 4.29 | 0.0% | 28.6% | EMERGING ; abandonment_concern | 7 | 0.82% | 4.29 | 14.3% | 71.4% | EMERGING ; streak_bug_confusion | 7 | 0.82% | 3.71 | 14.3% | 14.3% | EMERGING ; want_reorder | 6 | 0.71% | 4.50 | 0.0% | 50.0% | EMERGING ; want_week_start | 6 | 0.71% | 4.33 | 16.7% | 83.3% | EMERGING ; want_localization | 5 | 0.59% | 4.40 | 0.0% | 60.0% | EMERGING ; want_health_integration | 5 | 0.59% | 4.20 | 0.0% | 40.0% | EMERGING ; bug_white_screen | 4 | 0.47% | 2.25 | 75.0% | 25.0% | Weak ; bug_cannot_create | 4 | 0.47% | 2.00 | 75.0% | 25.0% | Weak ; bug_widget_popup | 4 | 0.47% | 3.75 | 25.0% | 25.0% | Weak ; perf_lag_crash | 4 | 0.47% | 1.50 | 100.0% | 0.0% | Weak ; want_mood_tracker | 3 | 0.35% | 5.00 | 0.0% | 100.0% | Weak ; bug_monthly_summary | 2 | 0.24% | 2.50 | 50.0% | 0.0% | Weak ; want_app_lock | 2 | 0.24% | 4.50 | 0.0% | 50.0% | Weak ; privacy_concern | 2 | 0.24% | 2.50 | 50.0% | 0.0% | Weak
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-062 — Five frequency walls: seven circles for a 1×/3×-a-week habit; no 'every N days'; no weekday-only habits; weekly units expressed only in days; the x-per-y setting has no visible effect

- **Where:** §4.4 The frequency model is the most-misunderstood part of the product table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Complaint | Reviews ; Seven circles shown for a habit due once or 3× a week | `11475373489`(PA,3★) `12694560233`(US,4★) `13411041482`(CA,4★) `13522897637`(NL,4★) `12544035274`(TR,5★) `12961057018`(NL,4★) ; No "every N days" option | `11401964014`(DE,3★) `12013003790`(DE,4★) `11083479860`(CA,2★) ; No weekday-only / specific-weekday habits | `11234227951`(DE,4★) `12142373319`(CA,4★) `11246565899`(US,5★) ; Weekly/monthly units expressed only in days | `14045501473`(US,4★) *"a weekly habit must be set to every '7 days', which isn't totally intuitive"*; `14359179692`(US,4★) ; The x-per-y setting has no visible effect | `11552052382`(US,3★) `11761511083`(CA,3★) `11507981724`(US,4★)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `11475373489`, `12694560233`, `13411041482`, `13522897637`, `12544035274`, `12961057018`, `11401964014`, `12013003790`, `11083479860`, `11234227951`, `12142373319`, `11246565899`, `14045501473`, `14359179692`, `11552052382`, `11761511083`, `11507981724`
- **Canonical:** — (nuance register)

### R08-064 — Focus-timer asks ranked: custom durations, alarm doesn't sound, Live Activity / Lock Screen countdown, resets when backgrounded, auto-start break, screen sleeps, stopwatch/flowmodoro, per-habit focus stats

- **Where:** §4.5 Focus timer: the most-requested small fixes table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Ask | Reviews ; Custom / arbitrary durations (not just 5/15/25/60) | `10320051165` `11497359189` `12427747362` `13294761477` `13829383560` `12176433052` `9427359864` ; Timer alarm doesn't sound (silent ringer, screen off, background) | `10808472591` `12031614206` `12187537484` `10562486460` `9878233995` `11099294310` `14397732532` ; Live Activity / Lock Screen / Dynamic Island countdown | `10730989325` `11575357275` `12499700289` `12552714583` `13089328530` ; Timer resets when backgrounded | `14397732532`(IN,2★, Aug 2026) ; Auto-start break after focus | `8306583064` ; Screen sleeps during timer | `10278427560` ; Stopwatch / flowmodoro mode | `11298218335` ; Per-habit focus stats | `10102584778` `12089133132` `12481758518` `12805985659`
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-093 — Requests ranked by volume, rating penalty and inferred cost; the two pure-upside clusters (zero 1–2★, above-corpus mean) are the multi-habit widget (41) and the Apple Watch app (18) — both additive, neither risks simplicity, and Watch is the most-named paid add-on candidate

- **Where:** Part 6 WHAT THE FEATURE REQUESTS ACTUALLY SAY table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Rank | Request | n | % | Mean | Rating penalty vs 4.53 | Notes ; 1 | Multi-completion per day / intra-day counter | 36 | 4.24% | 3.94 | −0.59 | Rising: 8.2% of 2026. One stated uninstall. ; 2 | Backfill / edit past days beyond ~7 | 27 | 3.18% | 3.52 | −1.01 | Worst mean of any request ; 3 | Graphs / heat map (beyond the shipped summary) | 47 | 5.53% | 4.11 | −0.42 | Partly shipped Jan 2026 ; 4 | Multi-habit widget + more sizes | 41 | 4.82% | 4.56 | +0.03 | Zero 1–2★; pure upside ; 5 | Backup / export / device migration | 37 + 12 | 4.35% + 1.41% | 4.30 / 4.08 | −0.23 | India 14.1% ; 6 | Show circles only on scheduled days | 25 | 2.94% | 3.76 | −0.77 | Display fix, not logic ; 7 | Custom focus durations + reliable alarm | 32 | 3.76% | 4.34 | −0.19 | Many small fixes ; 8 | Change habit colour after creation | 20 | 2.35% | 4.35 | −0.18 | `12470711816`(AU): must delete and lose all progress to recolour ; 9 | Apple Watch app | 18 | 2.12% | 4.61 | +0.08 | Named as a paid-feature candidate twice ; 10 | iPad-native / macOS | 11 | 1.29% | 4.45 | −0.08 | `13676828438`(DE): iPad landscape broke after an update ; 11 | Folders / routines / lists | 9 | 1.06% | 4.22 | −0.31 | Named in the only $/mo WTP statement ; 12 | Log a quantity, not just a tick | 9 | 1.06% | 4.56 | +0.03 | Sibling of #1 ; 13 | Shared habits / accountability buddy | 9 | 1.06% | 4.33 | −0.20 | A "Habit Buddy" invite exists but doesn't report back: `9083174395`(DE) `6903454353`(ES) ; 14 | To-do list for non-repeating tasks | 7 | 0.82% | 4.71 | +0.18 | `14001076337`(CA): *"I hope to see maybe a todo list app from devs"* ; 15 | Skip day / vacation mode / streak freeze | 7 | 0.82% | 4.29 | −0.24 | ; 16 | Reorder habits | 6 | 0.71% | 4.50 | −0.03 | Shipped by Jul 2026 per `14326501421` ; 17 | Week starts Monday | 6 | 0.71% | 4.33 | −0.20 | `12137639810`(FR) `14363873344`(AT) ; 18 | Health app integration | 5 | 0.59% | 4.20 | −0.33 | ; 19 | Mood tracker in journal | 3 | 0.35% | 5.00 | +0.47 | ; 20 | Face ID / passcode lock | 2 | 0.24% | 4.50 | −0.03 |
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R08-103 — Time method: yearly buckets (2021 n=25, 2022 n=51, 2023 n=162, 2024 n=229, 2025 n=237, 2026 n=146), quarterly only from 2024 (34–84 per quarter); 2021–2022 reported as counts; Sep 2026 partial (4 reviews); no version field — release attribution from dated reviewer reports plus current release notes

- **Where:** §8.1 Method
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 2021 25 · 2022 51 · 2023 162 · 2024 229 · 2025 237 · 2026 146
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R08-129 — Research: retention is unmeasured — 55.6% of reviews are pure praise and many are written on day 1–3 ('second day', 'my first day', 'After testing it out for 5mins'); the corpus measures first impressions, not habit formation

- **Where:** Part 9 Research questions — What is retention?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 473 pure praise (55.6%)
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Review IDs:** `13581401872`, `11638684551`, `12146578302`
- **Canonical:** — (nuance register)

### R08-130 — Research: would a tip jar actually convert? 20 volunteers among 850 writers (9.4% of raters) is sentiment, not a demand curve

- **Where:** Part 9 Research questions — Would a tip jar actually convert?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 20 / 850
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C097 A tip / donate option

### R08-131 — Research: is the can't-log-today bug timezone-related? Symptoms come from SE, SG, HU, ID, AU, US, CA but no devices, locales or timezones — needs instrumentation, not more reviews

- **Where:** Part 9 Research questions — Is the can't log today bug timezone-related?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 7 storefronts
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R08-132 — Research: how many users hit the preset-habit picker and left without reviewing? 13 wrote about it; the silent cohort is unmeasurable here

- **Where:** Part 9 Research questions — How many users hit the preset-habit picker and left without reviewing?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 13 (floor)
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C142 Surface existing features where users look

### R08-133 — Research: does the widget failure correlate with a specific iOS version? No version field exists

- **Where:** Part 9 Research questions — Does the widget failure correlate with a specific iOS version?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R08-134 — Research: what did the 2024–2025 development pause cost in installs? Review volume actually rose in 2025 (237 vs 229), so the corpus cannot see it

- **Where:** Part 9 Research questions — What did the 2024–2025 development pause cost in installs?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 2024 229 → 2025 237
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C071 Never ship and walk away
