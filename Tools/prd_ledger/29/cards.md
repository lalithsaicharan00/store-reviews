# Cards — report 29

Source: `App Store Reports/29. Habit Tracker - Daily Goals - Motivation & Accountability (REPORT).md`  
125 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 2
- [Must-haves](#must-haves) — 9
- [Must never break](#must-never-break) — 15
- [Features](#features) — 24
- [Monetization](#monetization) — 9
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 16
- [Audiences](#audiences) — 3
- [Markets and languages](#markets-and-languages) — 10
- [Dated events and trends](#dated-events-and-trends) — 13
- [Positioning](#positioning) — 3
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 12

## Product rules

### R29-089 — A defensible monetisation test, stated as hypotheses because n=2 on willingness to pay: sell the widget, not the tracker — the one explicit payment offer is attached to the widget, it is the most-requested feature (16), and the only absent feature with demonstrated substitution to a competitor, so a one-time unlock for widget + dark mode + flexible frequency touches nothing any existing reviewer currently has; never cap habit count — 12 praise the uncapped list by name and it wins comparison shoppers; make the web-indexing choice explicit, reversible and clearly explained, and never a gate on first launch — both users who rejected it did so at the opening screen before seeing the product, so moving the ask to after first successful use and describing it plainly costs nothing and is the only change in this section supported by direct evidence rather than inference

- **Where:** §6.6 A defensible monetisation test (hypotheses, n=2 on willingness) — sell the widget, not the tracker (the one payment offer is attached to it, it is the most-requested feature, and the only absent feature with substitution to a competitor; a one-time unlock for widget + dark mode + flexible frequency touches nothing existing users have); never cap habit count; make the web-indexing choice explicit, reversible, plainly explained and never a gate on first launch — move the ask to after first successful use
- **This app does:** free; SDK gate at launch
- **User reaction:** mixed
- **Magnitude:** n=2 willingness; 16 widget; 12 no-cap; 3 SDK 1★
- **Direction for us:** build-paid · **Report confidence:** hypothesis · **Generalisable:** yes
- **Review IDs:** `12003653249`, `12043735920`, `14103247613`, `14391211979`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-107 — Fix #1: decide and publicly disclose the web-indexing policy — move the ask off the launch screen to after first successful use; describe in plain language what is shared; make it reversible in Settings; ensure declining costs the user nothing they currently have; 3 reviews, 100% 1★, 2 of 3 churned before first use, plus 1 unprompted privacy question — protects the 46.99% zero-cost reputation that is this app's only durable asset

- **Where:** §9.1 #1 — decide and publicly disclose the web-indexing policy: move the ask off the launch screen to after first successful use; describe plainly what is shared; make it reversible in Settings; ensure declining costs the user nothing they currently have — protects the 46.99% zero-cost reputation
- **This app does:** SDK gate at launch
- **User reaction:** 1★-burst
- **Magnitude:** 3 (100% 1★) + 1
- **Direction for us:** product-rule · **Report confidence:** emerging — severity · **Generalisable:** yes
- **Review IDs:** `14092044479`, `14103247613`, `14391211979`, `13506372310`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

## Must-haves

### R29-012 — Support is effectively unreachable: 5 reviews (1.37%, meaningful, mean 2.00) report contacting the developer with no reply or a broken support path — 'I contacted the dev twice but got no response'; 'I emailed developers twice today with no response.. I am asking why?'; 'Submitted issue to developers- so far nothing'; 'o suporte é fraco, não da retorno'; 'I went to their customer support link, but it takes you to a super-sketch website, circumventing Apple's privacy settings'; a sixth pleads publicly ('Someone from support please do this soon'); with no account and no backup, the review page is the only support channel users have — which is why bug reports here are written as public 1★ posts rather than tickets

- **Where:** Executive summary #10 — support is effectively unreachable: 5 (1.37%, mean 2.00) contacted the developer with no reply or hit a broken path ('I contacted the dev twice but got no response'; 'the customer support link takes you to a super-sketch website, circumventing Apple's privacy settings'); a sixth pleads publicly; with no account and no backup the review page is the only support channel, which is why bug reports arrive as public 1★ posts
- **This app does:** no working support path
- **User reaction:** complaint
- **Magnitude:** 5 (1.37%, meaningful), mean 2.00
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11676955165`, `12837138619`, `12959121316`, `12493412514`, `13084927585`, `12225388457`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R29-044 — Support unreachable or unanswered

- **Where:** §3.1 Master table #20 Support unreachable or unanswered
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 5 (1.37%, meaningful), mean 2.00
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R29-075 — Where the calendar bug turns into data loss: the sequence is consistent — the date breaks → the user tries delete-and-reinstall as a workaround → the history is gone because there is no backup — 'I tried restarting the app and my phone, and even deleted/redownloaded it and reentered all my habits. No luck' (2★); 'I tried deleting it and adding habits again but still stuck on 1/30… Update- waited til the next day and app was back to normal just sad I lost my data from uninstalling it' (5★); 'I just wish I didn't have to delete and reinstalled it every 30 days for the calendar to work' (4★); 'When I manually moved it to July, it did not keep track of my habits and I would've had to re-enter them all again' (3★); the most actionable inference in the report: the app's own reviews taught users that reinstalling fixes the date, reinstalling destroys their data, and the bug fix alone does not close this loop — an export or backup path does, and three independent reviewers requested one

- **Where:** §4.4 Where it turns into data loss — the sequence: the date breaks → the user reinstalls as a workaround → history gone because there is no backup ('deleted/redownloaded it and reentered all my habits. No luck'; 'Update- waited til the next day and app was back to normal just sad I lost my data from uninstalling it'; 'I just wish I didn't have to delete and reinstall it every 30 days for the calendar to work'); the reviews taught users that reinstalling fixes the date, and reinstalling destroys their data — the bug fix alone does not close the loop, an export/backup path does (three independent requests)
- **This app does:** reinstall workaround wipes local-only data
- **User reaction:** churn
- **Magnitude:** 9 data-loss; 4 reinstall narratives; 3 backup requests
- **Direction for us:** must-have · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `12604107314`, `12257572119`, `11789546578`, `12961148231`, `13276697912`, `13721332313`, `13987910930`
- **Canonical:** C020 Data export / backup / CSV; C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R29-108 — Fix #2: ship a Home Screen widget — 16 reviews (4.37%, very strong), 1 explicit payment offer, 1 named competitor substitution; directly addresses 6 of the 41 4★ reviews; the only absent feature with proven substitution behaviour

- **Where:** §9.1 #2 — ship a Home Screen widget: 16 reviews, 1 explicit payment offer, 1 named competitor substitution; addresses 6 of 41 4★; the only absent feature with proven substitution behaviour
- **This app does:** no widget
- **User reaction:** churn
- **Magnitude:** 16; 1 pay offer; 1 substitution
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12003653249`, `12043735920`
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app

### R29-109 — Fix #3: ship dark mode following the system setting — 15 reviews (4.10%, very strong, mean 4.67), India 8.77%; the highest-satisfaction request group in the corpus — delighted users naming one thing

- **Where:** §9.1 #3 — ship dark mode following the system setting: 15 reviews (mean 4.67), India 8.77% — the highest-satisfaction request group, delighted users naming one thing
- **This app does:** no dark mode
- **User reaction:** complaint
- **Magnitude:** 15, mean 4.67
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C080 Colour themes / dark mode

### R29-110 — Fix #4: add flexible frequency — x times per week untethered from weekdays, every-other-n, monthly, and multiple completions per day; 14 reviews including the corpus's only feature-driven 1★ and a 2★ driven purely by a missing capability class; closes the one structural product gap that has persisted across all five half-years

- **Where:** §9.1 #4 — add flexible frequency (x/week untethered from weekdays, every-other-n, monthly, multiple completions per day); closes the one structural gap persisting across all five half-years, incl. the only feature-driven 1★
- **This app does:** weekday checkboxes only
- **User reaction:** complaint
- **Magnitude:** 14 (3.83%)
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11700402770`
- **Canonical:** C043 Flexible / custom frequency

### R29-111 — Fix #5: add a local export / backup (CSV or JSON to Files) and, separately, optional iCloud backup — keep it account-free; 9 data-loss reports (mean 2.11) + 3 sync requests + the documented 'reinstall to fix the date' loop; converts the worst-outcome bug class into a recoverable event and costs nothing against the no-account praise if it stays local-first

- **Where:** §9.1 #5 — add a local export / backup (CSV or JSON to Files) and, separately, optional iCloud backup, keeping it account-free; converts the worst-outcome bug class into a recoverable event without costing the no-account praise if it stays local-first
- **This app does:** no export, no backup
- **User reaction:** churn
- **Magnitude:** 9 + 3
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13625278409`
- **Canonical:** C020 Data export / backup / CSV; C153 Automatic cloud backup on by default — never manual opt-in; C209 No sign-up wall before first use

### R29-116 — Fix #10: publish a working support address and answer it — 5 reviews (mean 2.00), one reporting a support link they judged unsafe; with no account and no backup the review page is currently the only support channel, which is why bug reports arrive as public 1★

- **Where:** §9.1 #10 — publish a working support address and answer it; with no account and no backup the review page is the only support channel, which is why bug reports arrive as public 1★
- **This app does:** no working support
- **User reaction:** complaint
- **Magnitude:** 5
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13084927585`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R29-118 — E2: optional iCloud backup, off by default, no account required — backup is the top latent need behind data loss (9 data-loss + 3 sync requests) but the no-account property is itself praised (1 explicit); the trade-off between the two is untested in this corpus

- **Where:** §9.2 E2 — optional iCloud backup, off by default, no account required: backup is the top latent need behind data loss but the no-account property is itself praised; the trade-off is untested
- **This app does:** no backup
- **User reaction:** mixed
- **Magnitude:** 9 + 3 vs 1
- **Direction for us:** must-have · **Report confidence:** hypothesis · **Generalisable:** yes
- **Review IDs:** `13625278409`
- **Canonical:** C035 Account system from day one; C153 Automatic cloud backup on by default — never manual opt-in

## Must never break

### R29-005 — The 'web indexing' monetisation prompt is the highest-risk item in the corpus and every reviewer who hit it gave 1★: 3 reviews (0.82%, emerging, mean 1.00), all post-dating 22 May 2026 — 'This app now interrupts use unless you agree to run a malware proxy downloader' (GB); 'Didn't get past the opening screen of being asked to enable web indexing to get the ad-less version. Basically your phone acts as the middleman for the apps partners to use your IP address to silently download and access free data found on the web. No thanks' (US); 'You PAID for this free app… Your phone would act as an intermediary between the app and its partners, using your IP address… What a free app.' (US); a fourth reviewer had asked the question unprompted in December 2025 ('I also appreciate that there's no subscription fees or ads. Am I trading off data privacy for this? I'd love to know.' — 5★); the only theme with a 100% 1★ rate, it directly contradicts the no-cost reputation, and two of the three abandoned the app at the opening screen — promoted above its raw count under the safety/legal/security carve-out

- **Where:** Executive summary #3 — the 'web indexing' prompt is the highest-risk item and every reviewer who hit it gave 1★: 'interrupts use unless you agree to run a malware proxy downloader'; 'Didn't get past the opening screen of being asked to enable web indexing to get the ad-less version… your phone acts as the middleman for the apps partners to use your IP address… No thanks'; 'You PAID for this free app'; a fourth had asked unprompted in Dec 2025 'Am I trading off data privacy for this?'; promoted above its count under the safety/legal/security carve-out
- **This app does:** internet-sharing SDK opt-in for ad-free
- **User reaction:** 1★-burst
- **Magnitude:** 3 (0.82%, emerging), mean 1.00, 100% 1★; all after 22 May 2026
- **Direction for us:** dont · **Report confidence:** emerging — promoted on severity · **Generalisable:** yes
- **Review IDs:** `14092044479`, `14103247613`, `14391211979`, `13506372310`
- **Canonical:** C085 Address tracking / privacy visibly; C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-007 — The dominant functional defect was a month-boundary date bug, now largely fixed — but it cost roughly a full star for two years: 37 reviews (10.11%, high-priority, mean 2.95 vs 4.73 for the rest) report the calendar showing the wrong date, refusing to advance, reverting to an earlier month, or misaligning weekday headers against dates; the fingerprint is unambiguous — 29 of 37 (78.4%) were filed on days 28–31 or 1–3 of a month against a 27.6% baseline; era rate 2024 9.1% → 2025 17.7% → 2026 2.6%; a single rollover/day-of-week arithmetic fault, not a class of instability, substantially resolved but with four reports surviving into 2026, the most recent 22 July 2026

- **Where:** Executive summary #5 — the dominant functional defect was a month-boundary date bug, now largely fixed but it cost roughly a full star for two years: 37 (10.11%, mean 2.95 vs 4.73) report the calendar showing the wrong date, refusing to advance, reverting to an earlier month or misaligning weekday headers; 29 of 37 (78.4%) filed on days 28–31 or 1–3 vs a 27.6% baseline; 2024 9.1% → 2025 17.7% → 2026 2.6%; four reports survive into 2026 (latest 22 Jul 2026)
- **This app does:** month-rollover date arithmetic bug
- **User reaction:** 1★-burst
- **Magnitude:** 37 (10.11%, high-priority), mean 2.95 vs 4.73; 78.4% at month boundary vs 27.6%; 9.1% → 17.7% → 2.6%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11676955165`, `11782200229`, `12127449842`, `12130015583`, `12252902482`, `12253630488`, `12254692368`, `12286885201`, `12299968183`, `12602757554`, `12603431541`, `12715196508`, `12835530003`, `12961148231`, `13084927585`, `13261739634`, `13337918653`, `13460543209`, `13577309961`, `13579197540`, `13594048622`, `14195919004`, `14332675510`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R29-008 — Data loss is the part of the calendar bug that has not been forgiven: 9 reviews (2.46%, meaningful, mean 2.11 — the lowest-rated theme of any size) report habits or history erased — 'It deleted my habits twice' (1★); 'all my habits populated and data dissapeared' (1★); 'zerou meu histórico, perdi tudo' (BR, 1★); 'it updated yesterday and lost ALL my Habits' (3★); 'The month ended and the habits aren't there any more, I'll have to create everything again' (BR, 1★); there is no account, no cloud backup and no export, so when the local store breaks the user's entire history is unrecoverable — three of the nine describe re-entering everything by hand; the absence of a backup path converts a bug into a total loss

- **Where:** Executive summary #6 — data loss is the part of the calendar bug that has not been forgiven: 9 (2.46%, mean 2.11, the lowest-rated theme of any size) report habits or history erased ('It deleted my habits twice'; 'it zeroed my history, I lost everything'; 'it updated yesterday and lost ALL my Habits'; 'The month ended and the habits aren't there any more'); with no account, no cloud backup and no export, a local-store break is a total loss — three re-entered everything by hand
- **This app does:** no account, no backup, no export
- **User reaction:** churn
- **Magnitude:** 9 (2.46%, meaningful), mean 2.11
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11673002290`, `12253431387`, `12493412514`, `12959121316`, `13337918653`, `12257572119`, `12604107314`, `12837138619`, `12961148231`
- **Canonical:** C020 Data export / backup / CSV; C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R29-031 — Any functional defect

- **Where:** §3.1 Master table #7 Any functional defect
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 46 (12.57%, HIGH), mean 2.89
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R29-035 — Calendar / date engine defect

- **Where:** §3.1 Master table #11 Calendar / date engine defect
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 37 (10.11%, HIGH), mean 2.95
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R29-042 — Data / history loss — the lowest-rated theme of any size

- **Where:** §3.1 Master table #18 Data / history loss
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 9 (2.46%, meaningful), mean 2.11
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R29-043 — Notification / reminder defect

- **Where:** §3.1 Master table #19 Notification / reminder defect
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 6 (1.64%, meaningful), mean 3.17
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once

### R29-045 — Cannot edit a habit after creation (2024 only)

- **Where:** §3.1 Master table #21 Cannot edit a habit after creation
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 (1.09%, meaningful), mean 2.00
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C073 Manual reordering, renaming and editing of habits/tasks — free

### R29-054 — 'Web indexing' opt-in rejected — 100% 1★

- **Where:** §3.1 Master table #30 'Web indexing' opt-in rejected
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 3 (0.82%, emerging), mean 1.00
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-066 — Notification/reminder lifecycle (6, 1.64%, meaningful, mean 3.17): three distinct faults in one subsystem — reminders never fire ('Notification will not go off even though they are turned on in my phone setting and app. Defeats the purpose. Completed waste of time', 1★; 'I set the reminder but app doesn't remind me'); deleted reminders keep firing ('I deleted a reminder time… I still get a notification then. Deleting the habit and remaking it doesn't fix this'; 'Have tried delete/reinstall but it still keeps sending notifications for tasks no longer on my list'); changed times don't take ('the notifications continue to ping at the original time after I've changed it, then turned them off'; 'So painful'); a further 3 (0.82%, mean 5.00) ask to stop reminding about a habit already marked done; these nine records describe one coherent problem — the notification schedule is written once and never reconciled against the habit's current state — and two faults surviving a delete-and-reinstall point at scheduled local notifications not being cancelled

- **Where:** §3.3 N3 — notification lifecycle: three faults in one subsystem — reminders never fire ('Defeats the purpose. Completed waste of time', 1★); deleted reminders keep firing ('Deleting the habit and remaking it doesn't fix this'; survives delete/reinstall); changed times don't take ('continue to ping at the original time after I've changed it'); plus 3 requests to stop reminding after completion — the schedule is written once and never reconciled against the habit's state; two faults surviving reinstall points at scheduled local notifications not being cancelled
- **This app does:** notification schedule not reconciled with habit state
- **User reaction:** complaint
- **Magnitude:** 6 (1.64%), mean 3.17 + 3 requests (mean 5.00)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12615584327`, `12735108537`, `13684390333`, `13853485546`, `13599829482`, `14164366682`, `11725303303`, `12945403197`, `14072264089`
- **Canonical:** C039 Reminders fire reliably, once

### R29-067 — Cannot edit a habit after creation (4, 1.09%, mean 2.00): 'Useless app, once you add a habit you can't edit it anymore or set the end of challenge or even find it in the app' (GB, 1★); 'You can't even edit the name of a habit after you create it' (US, 1★); 'the lack of habit editing' (2★); 'I just wish I could edit the habits I already entered' (4★); all four dated 14 July → 7 November 2024, and a May 2025 reviewer says the opposite ('easy to navigate and easy to edit each habit/task') — a real 2024 gap that appears fixed, retained because it cost four early ratings, two of them 1★, and shows the pattern the app repeats: a fix ships, but the reviews it caused remain on the store page forever

- **Where:** §3.3 N5 — cannot edit a habit after creation: 4 reviews, all between 14 Jul and 7 Nov 2024 ('once you add a habit you can't edit it anymore'; 'You can't even edit the name of a habit after you create it'), two of them 1★; a May 2025 reviewer says the opposite — a real 2024 gap that was fixed, retained because it cost four early ratings and shows the pattern: a fix ships, but the reviews it caused remain on the store page forever
- **This app does:** editing missing at launch, later added
- **User reaction:** 1★-burst
- **Magnitude:** 4 (1.09%), mean 2.00; Jul–Nov 2024
- **Direction for us:** must-never-break · **Report confidence:** meaningful (historical) · **Generalisable:** yes
- **Review IDs:** `11782815253`, `11673002290`, `11490852349`, `11922911236`, `12622290066`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C073 Manual reordering, renaming and editing of habits/tasks — free

### R29-073 — The month-boundary fingerprint: 29 of 37 calendar-bug reports (78.4%) were filed on days 30, 31, 1, 2, 3 (and 28–29) against 101 of 366 reviews (27.6%) overall — the strongest single piece of forensic evidence in the report; reviewers name the mechanism themselves — 'It doesn't seem to know how to account for whether a month has 30 or 31 days… I currently have the 31st listed twice for a month'; 'On the last day of every month, the app has no idea what day it is… I opened the app this morning (April 30) and the app defaulted to Feb 28'; 'at the end of every month the days are off by one day'; 'It goes Monday thru Sunday instead of Sunday thru Saturday but the dates go Sunday thru Saturday'; 'when the month changed for me it went backwards into April instead of forwards into July'; 'a small bug on the last day of each month where I'm unable to track my habits directly on the day' (Jul 2026) — one defect with two visible faces: a month-length rollover fault and a weekday-header offset

- **Where:** §4.2 The month-boundary fingerprint (verbatim table) — 29 of 37 (78.4%) filed on days 28–31 / 1–3 vs 27.6% of all reviews; reviewers name the mechanism ('doesn't know whether a month has 30 or 31 days… the 31st listed twice'; 'On the last day of every month the app has no idea what day it is… April 30 defaulted to Feb 28'; 'at the end of every month the days are off by one'; 'Monday thru Sunday instead of Sunday thru Saturday but the dates go Sunday thru Saturday'; 'went backwards into April instead of forwards into July') — one defect with two faces: month-length rollover and weekday-header offset
- **This app does:** month-length and weekday-offset date arithmetic
- **User reaction:** 1★-burst
- **Magnitude:** Day of month the review was filed | Calendar-bug reports | All reviews ; 30, 31, 1, 2, 3 (and 28–29) | 29 (78.4%) | 101 (27.6%) ; All other days | 8 (21.6%) | 265 (72.4%)
- **Direction for us:** must-never-break · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `13460543209`, `12603431541`, `12299968183`, `12715196508`, `12835530003`, `14332675510`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R29-086 — The actual monetisation and the reaction: a launch-screen prompt asking users to enable 'web indexing' — routing third-party web requests through their device and IP — for an ad-free experience; GB, 22 May 2026, an existing user now blocked ('now interrupts use unless you agree'); US, 25 May 2026, never got past the opening screen; US, 5 Aug 2026, never got past the opening screen ('You PAID for this free app'); three things make it larger than 0.82% — it is the only theme with a 100% 1★ rate (nothing else, not data loss at 2.11 nor the calendar bug at 2.95, produces uniform bottom-rating); two of three churned before first use, and a review corpus cannot see the silent version of that cohort; and it inverts the app's entire public value proposition ('You PAID for this free app' is the opposite of the 172 zero-cost reviews; 'No thanks.')

- **Where:** §6.4 The actual monetisation and the reaction (verbatim table) — GB 22 May 2026 existing user now blocked ('now interrupts use unless you agree'); US 25 May never got past the opening screen; US 5 Aug never got past the opening screen ('You PAID for this free app'); larger than 0.82% because it is the only theme with a 100% 1★ rate, two of three churned before first use (the silent version of that cohort is invisible), and it inverts the app's entire value proposition
- **This app does:** bandwidth-sharing SDK gate on first launch
- **User reaction:** 1★-burst
- **Magnitude:** ID | Country | Date | Stage reached | Key phrase ; 14092044479 | GB | 22 May 2026 | Existing user, now blocked | *"now interrupts use unless you agree"* ; 14103247613 | US | 25 May 2026 | Never got past the opening screen | *"Didn't get past the opening screen"* ; 14391211979 | US | 5 Aug 2026 | Never got past the opening screen | *"You PAID for this free app"*
- **Direction for us:** dont · **Report confidence:** emerging — severity · **Generalisable:** yes
- **Review IDs:** `14092044479`, `14103247613`, `14391211979`
- **Canonical:** C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-112 — Fix #6: close the residual month-boundary bug, specifically the weekday-header offset — four 2026 reports, latest 22 July 2026; removes the last 2.5–3.2% drag, and each such review currently costs ~2 stars

- **Where:** §9.1 #6 — close the residual month-boundary bug, specifically the weekday-header offset; each such review currently costs ~2 stars
- **This app does:** weekday offset residual
- **User reaction:** complaint
- **Magnitude:** 4 in 2026
- **Direction for us:** must-never-break · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `13579197540`, `13594048622`, `14195919004`, `14332675510`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R29-113 — Fix #7: fix notification lifecycle — cancel scheduled notifications when a habit is deleted or its reminder removed; honour reminder-time changes; stop the day's remaining reminders once a habit is checked off; 6 bugs (mean 3.17) + 3 requests, and two of the six faults survive delete-and-reinstall, costing ratings from users who tried to fix it themselves

- **Where:** §9.1 #7 — fix notification lifecycle: cancel scheduled notifications when a habit or reminder is deleted, honour time changes, stop the day's remaining reminders once checked off; two faults survive delete-and-reinstall
- **This app does:** stale scheduled notifications
- **User reaction:** complaint
- **Magnitude:** 6 + 3
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once

## Features

### R29-009 — Two features are requested repeatedly, are absent, and are both already table stakes in the category — a Home Screen widget (16, 4.37%, very strong, mean 4.19) and dark mode (15, 4.10%, very strong, mean 4.67) — both asked for by otherwise-delighted users, and in three cases the absence is stated as the exact reason a star was withheld ('Does the job, 1 star removed as widget is not available' — IN, 4★; 'It would be unbeatable if the app had dark mode… it's what's missing for 5 stars' — ES, 4★; 'Please add a widget function for ios then 6 stars' — GB, 5★); the two cheapest rating-points in the corpus, and neither requires a business-model decision

- **Where:** Executive summary #7 — two absent table-stakes features are requested repeatedly by delighted users: a Home Screen widget (16, 4.37%, mean 4.19) and dark mode (15, 4.10%, mean 4.67); in three cases the absence is the stated reason a star was withheld ('1 star removed as widget is not available'; 'what's missing for 5 stars'; 'add a widget then 6 stars') — the two cheapest rating-points available, neither needs a business-model decision
- **This app does:** no widget, no dark mode
- **User reaction:** complaint
- **Magnitude:** widget 16 (4.37%, mean 4.19); dark mode 15 (4.10%, mean 4.67)
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11725303303`, `12003653249`, `12043735920`, `12080359258`, `12133227404`, `12204928662`, `12269062164`, `12290197598`, `12410625311`, `13628525201`, `13674503459`, `13683386039`, `13764364876`, `13772306021`, `14257995934`, `14381720374`, `11723366610`, `12509751174`, `12548926052`, `12919657449`, `13730591333`, `13877425702`, `13987910930`, `14001397712`, `14024707633`, `14254134741`, `14332675510`, `14500436553`
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app; C080 Colour themes / dark mode

### R29-010 — Flexible scheduling is the largest genuine capability gap and the only unmet need that materially depresses ratings: 14 reviews (3.83%, very strong, mean 4.14) ask for a frequency model beyond 'pick specific weekdays' — x times per week without naming days ('I might want to practice golf 3 times a week but it doesn't matter on which days'), every other day or every other week ('My off days Fri, Sat, Sun every other week. The app dont have every other week. And its frustrating' — the only 1★ in the corpus driven purely by a missing feature), more than once per day ('As someone who takes medication twice a day it would be incredibly helpful to mark the same habit done twice a day'), monthly, and arbitrary custom intervals; the weekday-checkbox model is the app's one real product constraint — users with shift work, alternating schedules or twice-daily medication cannot represent their lives in it

- **Where:** Executive summary #8 — flexible scheduling is the largest genuine capability gap and the only unmet need that materially depresses ratings: 14 (3.83%, mean 4.14) want x times per week without naming days ('practice golf 3 times a week but it doesn't matter on which days'), every other day/week ('My off days Fri, Sat, Sun every other week… its frustrating' — the only 1★ driven purely by a missing feature), more than once per day ('medication twice a day'), monthly, custom intervals; the weekday-checkbox model is the one real product constraint
- **This app does:** weekday-checkbox scheduling only
- **User reaction:** complaint
- **Magnitude:** 14 (3.83%, very strong), mean 4.14; one 1★
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12085036764`, `12128407177`, `13614313384`, `12097192081`, `11700402770`, `12133227404`, `12504800201`, `12605709792`, `13480035328`, `14297251498`, `12141452926`, `12204928662`, `12699325873`, `13624270960`
- **Canonical:** C043 Flexible / custom frequency; C143 Intra-day completion: tap N times to fill N/N

### R29-019 — The product: a habit list with daily check-off, per-habit weekday selection, unlimited habit count, colour coding, categories/grouping, reminders with custom time and sound, a completion sound (one complaint it can't be muted), a calendar/month view with per-day history, statistics (bar graph, pie chart, weekly analytics), completed-days progress rings, a monthly overview, start/end dates on a habit (with a request to allow 'no end'), streaks, and no account/email/login named as a feature — all free

- **Where:** §2.1 Habit list with daily check-off; per-habit weekday selection; unlimited habit count; colour coding; categories/grouping; reminders with custom time and sound; completion sound (one can't mute it); calendar/month view; statistics (bar, pie, weekly); completed-days rings; monthly overview; start/end date on a habit; streaks; no account/email/login named as a feature
- **This app does:** everything free
- **User reaction:** praise
- **Magnitude:** inventory rows
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `12269619388`, `13627010760`, `14072264089`, `12152186871`, `13480035328`, `12781234520`, `13821769895`, `14493599797`, `12112287971`, `12286885201`, `13506372310`, `12296659841`, `12171965613`, `14011499566`, `13684390333`, `12920818324`, `11673002290`, `12253630488`, `13460543209`, `13261739634`, `12089896129`, `13143629702`, `12528474609`, `13628332072`, `13922902193`, `13577309961`, `12656091993`, `13276697912`, `13625278409`
- **Canonical:** C009 Basic widgets, icons and colours are free; C012 Week / month / year grid views; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C209 No sign-up wall before first use

### R29-020 — Not present anywhere in 366 reviews: a Home Screen widget (16 requests), dark mode (15), iCloud/cloud sync (3), data export (1), per-habit notes (2), quantity/unit tracking (4), habit reordering (4), gamification or rewards (1), social/shared habits (1), a bad-habit/quit mode (1), multiple languages beyond the store list (1)

- **Where:** §2.1 Not present anywhere in 366 reviews — widget (16 requests), dark mode (15), iCloud/cloud sync (3), data export (1), per-habit notes (2), quantity/unit tracking (4), habit reordering (4), gamification/rewards (1), social/shared habits (1), bad-habit/quit mode (1), more languages (1)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 16 / 15 / 3 / 1 / 2 / 4 / 4 / 1 / 1 / 1 / 1
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Canonical:** C020 Data export / backup / CSV; C030 Sync must work — and prove it; C040 Widgets must not go blank, stale or disagree with the app; C048 Flexible units / partial progress; C073 Manual reordering, renaming and editing of habits/tasks — free; C080 Colour themes / dark mode; C172 Per-day / per-habit notes and journal text

### R29-029 — Any feature request

- **Where:** §3.1 Master table #5 Any feature request
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 60 (16.39%, HIGH), mean 4.35
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R29-032 — UI / visual design praised

- **Where:** §3.1 Master table #8 UI / visual design praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 45 (12.30%, HIGH), mean 4.64
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C057 Offer a non-pastel / premium design option

### R29-037 — Home Screen widget requested

- **Where:** §3.1 Master table #13 Home Screen widget requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 16 (4.37%, very strong), mean 4.19
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app

### R29-038 — Dark mode requested

- **Where:** §3.1 Master table #14 Dark mode requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 15 (4.10%, very strong), mean 4.67
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C080 Colour themes / dark mode

### R29-039 — Flexible frequency requested

- **Where:** §3.1 Master table #15 Flexible frequency requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 14 (3.83%, very strong), mean 4.14
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency

### R29-041 — Statistics / charts praised

- **Where:** §3.1 Master table #17 Statistics / charts praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 10 (2.73%, meaningful), mean 4.60
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views

### R29-046 — Cannot reorder / sort habits

- **Where:** §3.1 Master table #22 Cannot reorder / sort habits
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 (1.09%, meaningful), mean 4.00
- **Direction for us:** free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R29-047 — More colours / customisation requested

- **Where:** §3.1 Master table #23 More colours / customisation requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 (1.09%, meaningful), mean 4.75
- **Direction for us:** free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free

### R29-048 — Quantity / unit tracking requested

- **Where:** §3.1 Master table #24 Quantity / unit tracking requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 (1.09%, meaningful), mean 4.50
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C048 Flexible units / partial progress

### R29-049 — End-date / no-end-date control requested

- **Where:** §3.1 Master table #25 End-date / no-end-date control requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 (1.09%, meaningful), mean 4.00
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R29-052 — Stop reminders after completion (request)

- **Where:** §3.1 Master table #28 Stop reminders after completion (request)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 3 (0.82%, emerging), mean 5.00
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once

### R29-056 — iCloud sync / account / backup requested

- **Where:** §3.1 Master table #32 iCloud sync / account / backup requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 3 (0.82%, emerging), mean 4.67
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it; C153 Automatic cloud backup on by default — never manual opt-in

### R29-057 — Richer statistics views requested

- **Where:** §3.1 Master table #33 Richer statistics views requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 3 (0.82%, emerging), mean 4.00
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views

### R29-060 — Notes per habit (2), time ordering / timestamps (2), explicitly willing to pay or donate (2)

- **Where:** §3.1 Master table #36 Notes per habit requested; #37 time ordering / timestamps requested; #38 explicitly willing to pay or donate
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 2 / 2 / 2 (0.55%, emerging)
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C097 A tip / donate option; C172 Per-day / per-habit notes and journal text

### R29-065 — Statistics (10, 2.73%, mean 4.60) is the one 'advanced' surface users praise unprompted — 'the bar graphs, pie chart the individual and total analysis sooo damn perfect' (IN); 'its statical measure of my progress is also easy to interpret' (UG); 'Completed days rings are great' (AU); 'even shows stats!' — and three separate reviewers want more of it (all-time records, a monthly/yearly grid, a graph widget); the safest place to add depth without violating the simplicity promise

- **Where:** §3.2 P6 — statistics: the one 'advanced' surface users praise unprompted ('bar graphs, pie chart the individual and total analysis sooo damn perfect'; 'Completed days rings are great') and ask to be extended (all-time records, monthly/yearly grid, a graph widget) — the safest place to add depth without violating the simplicity promise
- **This app does:** free stats: bar, pie, rings, weekly
- **User reaction:** praise
- **Magnitude:** 10 (2.73%), mean 4.60; 3 want more
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13143629702`, `12308098235`, `13628332072`, `12430964746`, `12089896129`, `12204928662`, `12528474609`, `12604107314`, `13922902193`, `13970235286`, `13460543209`, `14297251498`, `13764364876`
- **Canonical:** C012 Week / month / year grid views

### R29-068 — Cannot reorder or sort (4, 1.09%, mean 4.00): 'This could be my perfect habit tracker if I could only reorder the list of tasks. How could something so simple be overlooked? Without it the app is virtually useless' (US, 2★); 'Would it be possible to re-shuffle the habits once we've written them down?' (5★); 'the habits aren't arranged with respect to time. Give an option to arrange the habits based on time' (IN, 5★); 'Add sort by feature' (IN, 4★); two of the four ask specifically for time ordering, not drag-and-drop — sorting a day's list by reminder time would satisfy three of these four and needs no new data model

- **Where:** §3.3 N6 — cannot reorder or sort: 'This could be my perfect habit tracker if I could only reorder the list of tasks. How could something so simple be overlooked? Without it the app is virtually useless' (2★); two of four ask specifically for time ordering ('arrange the habits based on time') — sorting a day's list by reminder time satisfies three of four and needs no new data model
- **This app does:** no reorder, no sort
- **User reaction:** complaint
- **Magnitude:** 4 (1.09%), mean 4.00
- **Direction for us:** free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14052990828`, `12587757164`, `12072423999`, `13987910930`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R29-071 — The widget request has the lowest mean of any request theme (4.19) and is the only one that produced a 2★ — from a user who uses a competitor, 'Check Me', precisely because it has a widget and is waiting ('I don't use this app right now, but it has the potential to get me switch from check me. I will wait for sometime for the widget to arrive'); two more withhold stars for it; the widget is the only absent feature in this corpus with demonstrated substitution behaviour attached — a user naming a competitor they are using instead

- **Where:** §3.4 The widget has the lowest mean of any request (4.19) and the only 2★, from a user on a competitor ('Check Me') precisely because it has a widget, waiting to switch — the only absent feature with demonstrated substitution behaviour attached
- **This app does:** no widget
- **User reaction:** churn
- **Magnitude:** 16; one 2★; 2 withhold stars
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12043735920`, `12204928662`, `13628525201`
- **Canonical:** C005 Know which competitors buyers compare against; C040 Widgets must not go blank, stale or disagree with the app

### R29-115 — Fix #9: add habit reordering, and specifically sort-by-reminder-time — 4 reviews including a 2★ calling the app 'virtually useless' without it; 2 of the 4 ask for time ordering specifically; sorting by existing reminder time satisfies 3 of 4 and needs no new data model

- **Where:** §9.1 #9 — add habit reordering and specifically sort-by-reminder-time; satisfies 3 of 4 with no new data model
- **This app does:** no reorder
- **User reaction:** complaint
- **Magnitude:** 4
- **Direction for us:** free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14052990828`, `12072423999`, `13987910930`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R29-120 — E4: extend statistics rather than adding features — all-time records, a monthly/yearly grid, export; statistics is the only 'advanced' surface users praise and ask to extend, so depth added there does not violate the simplicity promise; 10 praise (mean 4.60) + 3 extension + 1 export request — directionally safe rather than proven

- **Where:** §9.2 E4 — extend statistics rather than adding features (all-time records, monthly/yearly grid, export): the only advanced surface praised and asked to be extended, so depth there does not violate the simplicity promise
- **This app does:** basic stats
- **User reaction:** praise
- **Magnitude:** 10 + 3 + 1
- **Direction for us:** build-free · **Report confidence:** hypothesis · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views

### R29-121 — E5: quantity / unit tracking (steps, litres, reps) as an optional habit type — 4 reviews, one proposing a slider interaction; a minority want measurement not just a checkbox; risks the simplicity that 119 reviewers came for if it appears in the default flow

- **Where:** §9.2 E5 — quantity / unit tracking (steps, litres, reps) as an optional habit type, one proposing a slider; risks the simplicity 119 came for if it appears in the default flow
- **This app does:** checkbox only
- **User reaction:** complaint
- **Magnitude:** 4
- **Direction for us:** undecided · **Report confidence:** hypothesis · **Generalisable:** yes
- **Review IDs:** `12204928662`, `12699325873`, `13240818406`, `13730591333`
- **Canonical:** C048 Flexible units / partial progress

## Monetization

### R29-011 — Removing the habit-count cap is a live differentiator and reviewers name competitors' caps explicitly: 12 reviews (3.28%, very strong, mean 4.92) praise the absence of a habit limit — 'they all made me pay for more than 3 habits'; 'the only habit tracker i've tried… where you can actually track a decent amount of habits without having to upgrade'; 'lets you have more than 6 habits'; 'I could add up to 15 to 20 habits without getting charged'; 'the only app that doesn't limit my habits'; counter-evidence flagged: one 3★ reports the opposite — 'it would only let me add one habit' (US, Jun 2026); the uncapped list is the specific mechanism by which this app wins comparison shoppers, and any future monetisation touching habit count attacks the exact thing 12 reviewers came for

- **Where:** Executive summary #9 — removing the habit-count cap is a live differentiator and reviewers name competitors' caps: 12 (3.28%, mean 4.92) praise no limit ('they all made me pay for more than 3 habits'; 'lets you have more than 6 habits'; 'up to 15 to 20 habits without getting charged'; 'the only app that doesn't limit my habits'); counter-evidence: one 3★ says 'it would only let me add one habit'; any monetisation touching habit count attacks the exact thing 12 came for
- **This app does:** unlimited habits free
- **User reaction:** praise
- **Magnitude:** 12 (3.28%, very strong), mean 4.92; 1 counter
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12152186871`, `11939963526`, `12781234520`, `14493599797`, `14495210194`, `12080359258`, `12257572119`, `12509751174`, `12528474609`, `12797457738`, `13595335326`, `13821769895`, `14163084101`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R29-021 — Free/paid: the habit-tracking core loop, unlimited habit count, reminders, colours, categories, statistics and calendar are all free with no reviewer reporting a gate on any of them; the ad-free experience is conditional — traded for a 'web indexing' opt-in from ~May 2026; no purchase evidence exists (0 of 366 report paying; the listing shows no IAP); listing (accessed 11 Sep 2026): price Free, In-App Purchases none, Productivity, 4+, version 1.1.0, 36.8 MB, languages English/French/German/Italian/Japanese/Portuguese/Simplified and Traditional Chinese, privacy disclosure 'data not linked to identity — user IDs, product interaction, crash and performance data — for analytics and diagnostics' at 99apps.me/privacy

- **Where:** §2.2 Free / paid classification table (verbatim) — core loop free; unlimited habits free; reminders, colours, categories, statistics, calendar free; ad-free experience conditional — traded for 'web indexing' opt-in from ~May 2026; no purchase evidence exists; listing: Free, no IAP, v1.1.0, 36.8 MB, 8 languages, privacy disclosure 'data not linked to identity… for analytics and diagnostics' at 99apps.me/privacy
- **This app does:** free; ad-free traded for bandwidth
- **User reaction:** mixed
- **Magnitude:** Capability | Status | Basis ; Habit tracking core loop | Free | Store listing price "Free"; 121 reviewers state it is free ; Unlimited habit count | Free | 12 reviewers explicitly confirm no cap (12781234520, 14493599797, 13821769895) ; Reminders, colours, categories, statistics, calendar | Free | No reviewer anywhere reports a gate on any of these ; Ad-free experience | Conditional — traded for "web indexing" opt-in, from ~May 2026 | 14092044479, 14103247613, 14391211979 ; Anything at all | No purchase evidence exists | 0 of 366 reviews report paying; store listing shows no in-app purchases
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C001 Never move a free feature behind the paywall; C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-025 — Zero cost cited as a reason for satisfaction

- **Where:** §3.1 Master table #1 Zero cost cited as a reason for satisfaction
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 172 (46.99%, HIGH), mean 4.83
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall

### R29-026 — Praises 'free'

- **Where:** §3.1 Master table #2 — of which: praises 'free'
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 121 (33.06%, HIGH), mean 4.78
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall

### R29-028 — Praises absence of ads

- **Where:** §3.1 Master table #4 — of which: praises absence of ads
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 60 (16.39%, HIGH), mean 4.90
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C082 Ads in the free tier

### R29-033 — Praises absence of subscription/IAP — the highest mean of any theme of size

- **Where:** §3.1 Master table #9 — of which: praises absence of subscription/IAP
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 44 (12.02%, HIGH), mean 4.98
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase

### R29-040 — No habit-count cap praised

- **Where:** §3.1 Master table #16 No habit-count cap praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 12 (3.28%, very strong), mean 4.92
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R29-084 — Two reviews (0.55%, emerging, mean 5.00) express willingness to pay: 'Absolutely amazing app. Just please add widget support happy to pay for a lifetime subscription ❤️' (GB, 5★) — conditional on the single most-requested missing feature and naming a lifetime structure rather than recurring; 'Great app and love to be able to contribute to use it' (US, 5★) — framed as a contribution in a review whose title is a bug report; two data points cannot support a pricing decision, but they support a hypothesis worth testing — the willingness that exists is for a one-time or tip-style payment attached to a visible new capability, not a subscription attached to existing functionality — with a third signal: the highest-mean sub-theme in the report is 'praises the absence of a subscription' (4.98 across 44)

- **Where:** §6.2 What users say they would pay for — 2 (0.55%, mean 5.00): 'Just please add widget support happy to pay for a lifetime subscription' (conditional on the most-requested missing feature, and lifetime not recurring); 'love to be able to contribute' (in a review titled with a bug); hypothesis: willingness here is for a one-time or tip-style payment attached to a visible new capability, not a subscription on existing functionality — supported by 'no subscription' being the highest-mean sub-theme (4.98)
- **This app does:** no paid tier
- **User reaction:** purchase-driver
- **Magnitude:** 2 (0.55%), mean 5.00
- **Direction for us:** build-paid · **Report confidence:** emerging (n=2) · **Generalisable:** yes
- **Review IDs:** `12003653249`, `13459746040`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C097 A tip / donate option

### R29-117 — E1: a one-time 'Pro' unlock for widget + dark mode + flexible frequency — never touch habit count, never touch the existing free surface; hypothesis: new capability can be sold to this audience, existing capability cannot; support: the only payment offer is conditional on the widget and names a lifetime structure, another offers to 'contribute', and 'no subscription' is the highest-mean sub-theme at 4.98; not a fix — n=2 on willingness to pay

- **Where:** §9.2 E1 — a one-time 'Pro' unlock for widget + dark mode + flexible frequency, never touching habit count or the existing free surface: new capability can be sold to this audience, existing capability cannot (n=2 on willingness — a hypothesis)
- **This app does:** free, no paid tier
- **User reaction:** purchase-driver
- **Magnitude:** n=2
- **Direction for us:** build-paid · **Report confidence:** hypothesis · **Generalisable:** yes
- **Review IDs:** `12003653249`, `13459746040`
- **Canonical:** C003 Lead with a one-time lifetime purchase

## Tactics the app used

### R29-013 — Tactic and outcome: the rating prompt fires on the first interaction and is visibly manufacturing uninformed 5★ reviews — 3 direct complaints (0.82%, mean 4.00: 'Used the app for 2 minutes then a reminder popped up for me to rate the app. -1 star for not giving me enough time to use the app'; 'It asks for you to review it the moment you check one thing off'; 'Kept prompting rating and review so here I am, on day 1'), and the structural evidence is larger — 39 reviews (10.66%) carry no theme at all, median 27 characters, all 39 5★; 84 (23.0%) are ≤50 characters at mean 4.80; multiple reviewers state they are reviewing on day one or after two minutes; the 4.552 mean is partly a prompt-timing artefact that inflates the store rating and simultaneously starves the developer of usable feedback — people are asked before they have an opinion

- **Where:** Executive summary #11 — the rating prompt fires on the first interaction and is visibly manufacturing uninformed 5★ reviews: 3 direct complaints ('Used the app for 2 minutes then a reminder popped up for me to rate the app. -1 star'; 'It asks for you to review it the moment you check one thing off'; 'so here I am, on day 1'); structurally 39 (10.66%) contentless reviews, all 5★, median 27 chars; 84 (23.0%) ≤50 chars at mean 4.80; multiple reviewing on day one — the 4.552 mean is partly a prompt-timing artefact that also starves the developer of usable feedback
- **This app does:** rating prompt on first check-off
- **User reaction:** 5★-burst
- **Magnitude:** 3 direct (0.82%); 39 (10.66%) contentless all 5★; 84 (23.0%) ≤50 chars mean 4.80
- **Direction for us:** dont · **Report confidence:** emerging (direct) / structural · **Generalisable:** yes
- **Review IDs:** `13598041567`, `13848623635`, `13059723695`, `13172589582`, `12512584748`, `14459698931`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

## Insights (the why)

### R29-003 — 'It is actually free' is not a feature of this product — it is the product: 172 of 366 reviews (46.99%, high-priority, mean 4.83) cite zero cost as a reason for their rating — 121 (33.06%) say 'free', 60 (16.39%) praise the absence of ads, 44 (12.02%) the absence of a subscription or paywall — and they average 4.83 against 4.31 for every other review ('Yes it really is free!'; 'no fuss, no adds, no subscription which is rare to find'; 'apps with full service and no in app purchases are so rare'; 'Genuinely surprised to find an app nowadays without something behind a paywall'); the single most valuable asset this app owns is a reputation for not charging, so any monetisation change is not a pricing decision — it is an identity change

- **Where:** Executive summary #1 — 'it is actually free' is not a feature, it is the product: 172 (46.99%, mean 4.83 vs 4.31 for every other review) cite zero cost — 121 'free', 60 no ads, 44 no subscription/paywall ('Yes it really is free!'; 'Genuinely surprised to find an app nowadays without something behind a paywall'); the single most valuable asset is a reputation for not charging, so any monetisation change is an identity change
- **This app does:** entirely free, no IAP
- **User reaction:** purchase-driver
- **Magnitude:** 172 (46.99%, high-priority), mean 4.83 vs 4.31; free 121 (33.06%), no ads 60 (16.39%), no sub 44 (12.02%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11668806995`, `14001397712`, `13490562375`, `14253731512`, `11444836560`, `11455984176`, `12266898528`, `12867479846`, `13044013224`, `13595921255`, `13661448098`, `14041180742`, `14302347258`, `14497877998`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase

### R29-027 — Simplicity / clean UI / ease of use

- **Where:** §3.1 Master table #3 Simplicity / clean UI / ease of use
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 119 (32.51%, HIGH), mean 4.80
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R29-034 — Concrete behaviour change reported

- **Where:** §3.1 Master table #10 Concrete behaviour change reported
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 38 (10.38%, HIGH), mean 4.87
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R29-036 — Explicit recommendation to others

- **Where:** §3.1 Master table #12 Explicit recommendation to others
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 27 (7.38%, HIGH), mean 4.81
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R29-050 — Anxiety that the app will stop being free

- **Where:** §3.1 Master table #26 Anxiety that the app will stop being free
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 4 (1.09%, meaningful), mean 5.00
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall

### R29-062 — Zero cost is the defining theme, in three overlapping sub-themes — the word 'free' (121, 33.06%), the absence of ads (60, 16.39%, mean 4.90), the absence of a subscription/IAP/paywall (44, 12.02%, mean 4.98 — the highest mean of any theme of size) — framed as relief and disbelief rather than satisfaction: 'Yes it really is free!'; 'I'm just here to say this app is so perfect and free, I feel like they're losing money…'; 'too goood to be true'; 'Can't believe it's free'; 'this app has not gone the way of capitalism and sold out'; 'Thank the Lord for this app'; 'Kostenlos und voll umfänglich' — a brand promise, not a feature list

- **Where:** §3.2 P1 — zero cost: three overlapping sub-themes ('free' 121, no ads 60 at mean 4.90, no subscription/IAP 44 at mean 4.98 — the highest mean of any theme of size); the framing is relief and disbelief ('I feel like they're losing money…'; 'too goood to be true'; 'this app has not gone the way of capitalism and sold out'; 'Thank the Lord for this app') — a brand promise, not a feature list
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** 172 (46.99%); no-sub sub-theme mean 4.98
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11668806995`, `13478561515`, `13719409474`, `13628332072`, `11813083900`, `13664505292`, `11402735091`, `11444836560`, `12174401255`, `12266898528`, `12354816211`, `12569356304`, `12829927902`, `12965689848`, `13044013224`, `13415167873`, `13490562375`, `13595921255`, `13613572970`, `13706027522`, `13838754294`, `13908186370`, `13962928441`, `14041958995`, `14253731512`, `14302347258`, `14349454186`, `14412953614`, `14432719449`, `14471259071`, `14497877998`
- **Canonical:** C001 Never move a free feature behind the paywall

### R29-063 — Simplicity (119, 32.51%, mean 4.80) is consistently framed as the absence of things reviewers have been subjected to elsewhere — onboarding quizzes, upsell screens, feature bloat: 'I finally found a habit tracker app which doesn't bombard you with stupid questions and a billion pop ups' (AU); 'No BS app without too many unnecessary complications'; 'simple to use for us folks who get overwhelmed with too many customization options'; 'Everything that you need, nothing that you don't'; 'no bells and whistles'; one 4★ reads the same trait as a limitation ('It's VERY basic, so if you're looking for more options in an app, it's not for you'); simplicity and zero cost are the same story told twice — both read as 'this app is not trying to extract something from me' — so any added complexity carries reputational cost beyond its UX cost

- **Where:** §3.2 P2 — simplicity is framed as the absence of things users were subjected to elsewhere ('doesn't bombard you with stupid questions and a billion pop ups'; 'No BS app'; 'for us folks who get overwhelmed with too many customization options'; 'Everything that you need, nothing that you don't'); one 4★ reads the same trait as a limitation ('It's VERY basic'); simplicity and zero cost are the same story — 'this app is not trying to extract something from me' — so any added complexity carries reputational cost beyond UX cost
- **This app does:** no quiz, no upsell, no bloat
- **User reaction:** praise
- **Magnitude:** 119 (32.51%), mean 4.80
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13246295251`, `13627010760`, `13631120155`, `13390452161`, `11624371093`, `11922911236`, `11581883661`, `12337158790`, `12856070826`, `12930469783`, `12972332540`, `13236988214`, `13513275431`, `13595335326`, `13877425702`, `14181244719`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R29-064 — Behaviour change (38, 10.38%, mean 4.87): checkable outcomes rather than generic satisfaction — 'Kept me motivated and in only 3 months I had a great basketball body… I never forget anymore'; 'It has truly changed my life. I remember scrambling day to day, unfocused, & ungrounded'; 'helped me rebuild my good habits while breaking my bad ones'; 'I actually stick to my routines more, which is a miracle tbh'; 'Without this game I was always late to work'; 'It's been less than a week and I see a change forming'; the pattern is deliberately inclusive, for magnitude not precision

- **Where:** §3.2 P4 — behaviour change: checkable outcomes ('in only 3 months I had a great basketball body… I never forget anymore'; 'I remember scrambling day to day, unfocused, & ungrounded'; 'Without this game I was always late to work'; 'less than a week and I see a change forming'); deliberately inclusive pattern, magnitude not precision
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 38 (10.38%), mean 4.87
- **Direction for us:** none · **Report confidence:** high (context) · **Generalisable:** yes
- **Review IDs:** `13724677117`, `12079225449`, `13435869648`, `13933385748`, `11765500247`, `12097192081`, `11492021762`, `11568840222`, `11628196381`, `11931278202`, `12269619388`, `12361078445`, `12481241464`, `13153646941`, `13279086279`, `13505454774`, `13664505292`, `13731135008`, `13832226279`, `14162234071`, `14368828196`
- **Canonical:** — (nuance register)

### R29-074 — Calendar-bug rating impact: 7 of 16 1★ (43.8%), 6 of 9 2★ (66.7%), 10 of 16 3★ (62.5%), 10 of 41 4★ (24.4%), 4 of 284 5★ (1.4%); mean 2.95 vs 4.73 for every other review; four 5★ reviewers reported the bug anyway — 'A month of awesome, but then it wouldn't show me today's date'; a review titled 'No dates available after Nov29 2025' whose body says 'Great app and love to be able to contribute to use it' — the product is liked, the defect is separable, and the most loyal users say both at once

- **Where:** §4.3 Rating impact (verbatim table) — calendar bug is 43.8% of all 1★, 66.7% of 2★, 62.5% of 3★, 24.4% of 4★, 1.4% of 5★; mean 2.95 vs 4.73; four 5★ reviewers reported it anyway ('A month of awesome, but then it wouldn't show me today's date'; title 'No dates available after Nov29 2025' with 'Great app') — the product is liked, the defect separable, loyal users say both
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Rating | Calendar-bug reports | % of that rating band ; 1★ | 7 | 43.8% of all 1★ (n = 16) ; 2★ | 6 | 66.7% of all 2★ (n = 9) ; 3★ | 10 | 62.5% of all 3★ (n = 16) ; 4★ | 10 | 24.4% of all 4★ (n = 41) ; 5★ | 4 | 1.4% of all 5★ (n = 284)
- **Direction for us:** must-never-break · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `12255251536`, `12257572119`, `13459746040`, `14332675510`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R29-078 — 5★ (n=284): 153 (53.9%) praise zero cost, 105 (37.0%) simplicity, 48 (16.9%) arrived from another tracker, 36 (12.7%) the design; only 4 (1.4%) report any bug; the band has a quality problem — 39 of 284 (13.7%) carry no theme (median 27 characters: 'Amazing', 'Wow / And wow', 'Good app', 'It good trust') and a further group state they have barely used the app ('Only used for 2 minutes'; 'So far so good, but first day using it'; 'One day in'; 'I've just downloaded it and already love it'); 34 of the 284 (12.0%) still ask for something, most often dark mode (10) or a widget (7) — delighted users naming the exact next thing, the highest-value reviews in the corpus; an anomaly the other way: a 1★ whose entire text is 'Best :: simple and free' is almost certainly a mis-tap, the clearest reason not to read the 1★ band (n=16) as 16 dissatisfied users

- **Where:** §5.1 5★ — 153 (53.9%) praise zero cost, 105 (37.0%) simplicity, 48 (16.9%) arrived from another tracker, 36 (12.7%) design; only 4 (1.4%) report a bug; 39 (13.7%) contentless (median 27 chars: 'Amazing', 'Wow / And wow', 'It good trust') and several barely used it ('Only used for 2 minutes'; 'One day in'); 34 (12.0%) still ask for something — dark mode (10), widget (7) — the highest-value reviews; one 1★ whose text is 'Best :: simple and free' is almost certainly a mis-tap
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 153 / 105 / 48 / 36; 4 bugs; 39 contentless; 34 still ask
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11509187562`, `13594303114`, `13677716681`, `13575726176`, `13250604014`, `14058540814`, `13172589582`, `12512584748`, `14459698931`, `14141227686`, `11700084840`, `14001397712`, `13890862557`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R29-079 — 4★ (n=41) is the 'one thing away' band — 19 of 41 (46.3%) contain a feature request and 13 (31.7%) report a bug, the highest request rate of any band; three name the exact star they withhold and why ('1 star removed as widget is not available'; dark mode 'is what's missing for 5 stars'; '-1 star for not giving me enough time to use the app before rating'); wants: widget 6, flexible frequency 8, dark mode 5, notification fixes 3, calendar fix 10 — 4★ is where this product's roadmap is written: a widget, dark mode and flexible frequency address 19 of the 41 directly

- **Where:** §5.2 4★ — the 'one thing away' band: 19 of 41 (46.3%) request a feature and 13 (31.7%) report a bug; three name the exact withheld star (widget; dark mode 'what's missing for 5 stars'; rating prompt too early); wants: widget 6, flexible frequency 8, dark mode 5, notification fixes 3, calendar fix 10 — shipping widget, dark mode and flexible frequency addresses 19 of 41 four-star reviews directly
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 19/41 requests; 13/41 bugs
- **Direction for us:** must-have · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `12204928662`, `14024707633`, `13598041567`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app; C043 Flexible / custom frequency; C080 Colour themes / dark mode

### R29-080 — 3★ (n=16): 13 (81.3%) report a bug and 10 (62.5%) the calendar bug specifically — an almost pure bug-report channel from users who like the app ('I really love this app. The calendar has a glitch'; 'I LOVE this app, BUT it updated yesterday and lost ALL my Habits'; 'Love it but stopped working'; 'now it is stuck in January'); the three non-bug 3★ are a missing widget, the rating prompt plus multi-part tasks, and a habit-add failure; there is no 'meh' segment in this corpus — 3★ means 'I like this and it broke'

- **Where:** §5.3 3★ — 13 of 16 (81.3%) report a bug, 10 the calendar bug: an almost pure bug-report channel from users who like the app ('I really love this app. The calendar has a glitch'; 'I LOVE this app, BUT it updated yesterday and lost ALL my Habits'); there is no 'meh' segment — 3★ means 'I like this and it broke'
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 13/16 bugs; 10/16 calendar
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13261739634`, `12959121316`, `13579197540`, `12252902482`, `13628525201`, `13848623635`, `14163084101`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R29-081 — 2★ (n=9): six are the calendar bug; the other three are a missing widget with a named competitor ('Check Me'), missing editing plus missing rewards, and missing reordering ('Without it the app is virtually useless'); 3 of the 9 still praise zero cost in the same review, and one adds the support-path complaint

- **Where:** §5.4 2★ — six of nine are the calendar bug; the other three: a missing widget with a named competitor, missing editing plus rewards, missing reordering ('Without it the app is virtually useless'); 3 of the 9 still praise zero cost in the same review
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 6/9 calendar; 3/9 still praise free
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11676955165`, `12604107314`, `12835530003`, `12837138619`, `13084927585`, `13577309961`, `12043735920`, `11490852349`, `14052990828`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C040 Widgets must not go blank, stale or disagree with the app; C073 Manual reordering, renaming and editing of habits/tasks — free

### R29-085 — Four reviews (1.09%, meaningful, mean 5.00) pre-emptively warn against monetising, unprompted, while giving 5★ — 'I will continue to use this app as long as it doesn't try to mark up the price from free' (US); 'I hope that it will last free of ads and subscriptions ☀️' (FR); 'I haven't been forced into a subscription to use it and as long as this continues I'm gonna use this app every day' (US); 'Only app to have no ads or subscriptions!! Love the work never change' (AU) — the clearest statement of the commercial trap: the most enthusiastic users have publicly conditioned their loyalty on the absence of monetisation, a strong asset and a hard ceiling at the same time

- **Where:** §6.3 What users say they will not tolerate — 4 (1.09%, mean 5.00) pre-emptively warn against monetising while giving 5★ ('I will continue to use this app as long as it doesn't try to mark up the price from free'; 'I hope that it will last free of ads and subscriptions'; 'as long as this continues I'm gonna use this app every day'; 'Love the work never change') — its most enthusiastic users have publicly conditioned their loyalty on the absence of monetisation: a strong asset and a hard ceiling
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** 4 (1.09%), mean 5.00
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11813083900`, `11639983783`, `14041958995`, `12965689848`
- **Canonical:** C001 Never move a free feature behind the paywall

### R29-088 — Anything sold here must survive four things the corpus already establishes: (1) the reputation — 172 reviews (46.99%) built on 'no cost, no ads, no subscription', so a paywall converts the app's largest asset into its largest liability and the review page becomes where it happens; (2) the grievance comparison shoppers arrived with — 52 named paywalls and habit caps as why they left the last app ('they all made me pay for more than 3 habits'), so a habit cap would be the exact betrayal they are primed to punish; (3) no account and no sync — no identity layer, so no restore path, no cross-device entitlement, no way to make a purchase feel durable, and one reviewer praises exactly that ('the fact I didn't even have to list my email sold me'), so adding an account for billing has its own cost; (4) a support channel that does not work — five report no reply and one an unsafe support link; charging money without a working support address converts every billing question into a public 1★ review

- **Where:** §6.5 Barriers to any future upgrade — (1) the reputation itself: 172 built on no cost, a paywall converts the largest asset into the largest liability on the review page; (2) the grievance comparison shoppers arrived with — paywalls and habit caps ('they all made me pay for more than 3 habits'); (3) no account and no sync — no restore path, no cross-device entitlement, and adding an account costs the no-email praise ('I didn't even have to list my email sold me'); (4) a support channel that does not work — charging without a working support address converts every billing question into a public 1★
- **This app does:** free, no account, no support
- **User reaction:** blocked-conversion
- **Magnitude:** 172; 52; 1; 5
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `12152186871`, `13625278409`, `13084927585`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C036 A support channel that exists, is reachable outside the app, and answers; C209 No sign-up wall before first use

### R29-106 — What did not change: zero cost as the dominant value driver (42–61% in every half-year); simplicity as the second driver; flexible frequency as the top unresolved capability gap, requested in every period 2024H2 → 2026H2; the absence of any purchase evidence in every period; and no widget and no dark mode — requested continuously for 26 months and present in zero reviews

- **Where:** §8.9 What did not change — zero cost the dominant driver in every half-year (42–61%); simplicity steady; flexible frequency the top unresolved gap in every period; zero purchase evidence in every period; no widget and no dark mode, requested continuously for 26 months
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 26 months
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C040 Widgets must not go blank, stale or disagree with the app; C043 Flexible / custom frequency; C080 Colour themes / dark mode

## Audiences

### R29-051 — Student / child / budget context

- **Where:** §3.1 Master table #27 Student / child / budget context
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 4 (1.09%, meaningful), mean 5.00
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R29-058 — Mental-health / recovery context

- **Where:** §3.1 Master table #34 Mental-health / recovery context
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 3 (0.82%, emerging), mean 4.67
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R29-059 — ADHD / neurodivergence context

- **Where:** §3.1 Master table #35 ADHD / neurodivergence context
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 3 (0.82%, emerging), mean 4.33
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

## Markets and languages

### R29-014 — India is the growth market and it behaves nothing like the US: n=57 (15.6%), mean 4.895, 89.5% 5★, and zero calendar-bug reports, vs the US n=201, mean 4.443, 73.6% 5★, 14.43% calendar-bug; Indian reviews are shorter (median 71 vs 123 characters) and skew toward gratitude for free access — 'You're doing a great service to students who cannot afford to spend on applications'; 'even paid apps cannot compete with this… if i had power i would nominate u for noble prize'; 'God will bless you one day'; India's distinctive request profile is dark mode (5/57 = 8.77% vs 2.99% US) and flexible frequency (7.02% vs 2.99%); the US/India gap is best explained by review length and recency (93% of Indian reviews post-date 2024), not by a different product experience — treating 4.895 as higher satisfaction would over-read the data

- **Where:** Executive summary #12 — India is the growth market and behaves nothing like the US: n=57, mean 4.895, 89.5% 5★, zero calendar-bug reports vs US 4.443 / 73.6% / 14.43%; Indian reviews shorter (median 71 vs 123 chars) and gratitude-framed ('a great service to students who cannot afford to spend on applications'; 'God will bless you one day'); India's distinctive requests are dark mode (8.77% vs 2.99%) and flexible frequency (7.02% vs 2.99%); the gap is best explained by review length and recency, not a different product experience
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** IN n=57, 4.895, 89.5% 5★, 0 calendar bug; US n=201, 4.443, 73.6%, 14.43%
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `12133935681`, `13143629702`, `13490562375`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C080 Colour themes / dark mode

### R29-090 — Storefront distribution: US 201 (54.9%, mean 4.443) and India 57 (15.6%, 4.895) are the only two ≥50; GB 26 (4.577), CA 19 (4.526), AU 13 (4.769), BR 9 (3.778), DE 6 (4.167), KE 3 (4.667); CL, CN, MX, NG, PH, RU, VN 2 each; AE, AR, AT, CH, EG, ES, FR, IL, IT, JP, KR, MN, PT, SA, UA, UG, UZ, ZA 1 each — 33 storefronts

- **Where:** §7.1 Distribution (verbatim table) — US 201 (4.443), IN 57 (4.895) eligible; GB 26, CA 19, AU 13, BR 9 (3.778), DE 6, KE 3, seven with 2, eighteen with 1; 33 storefronts, only two clear 50
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Country | n | % of corpus | Mean | Eligible for standalone analysis (n ≥ 50)? ; United States | 201 | 54.9% | 4.443 | Yes ; India | 57 | 15.6% | 4.895 | Yes ; United Kingdom | 26 | 7.1% | 4.577 | No ; Canada | 19 | 5.2% | 4.526 | No ; Australia | 13 | 3.6% | 4.769 | No ; Brazil | 9 | 2.5% | 3.778 | No ; Germany | 6 | 1.6% | 4.167 | No ; Kenya | 3 | 0.8% | 4.667 | No ; CL, CN, MX, NG, PH, RU, VN | 2 each | 0.5% each | — | No ; AE, AR, AT, CH, EG, ES, FR, IL, IT, JP, KR, MN, PT, SA, UA, UG, UZ, ZA | 1 each | 0.3% each | — | No
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R29-091 — United States (n=201, 54.9%, mean 4.443): zero-cost praise 48.26% (≈ global), simplicity 33.83%, comparison shopping 17.41% (above 14.21%), any bug 17.41% (above 12.57%), calendar bug 14.43% (above 10.11%), behaviour change 13.43%, UI praise 12.94%, requests 13.43% (below 16.39%), widget 4.48%, habit-cap praise 4.48%, data loss 2.49%, dark mode 2.99% (below); the US carries 29 of 37 calendar-bug reports (78.4%) against a 54.9% corpus share and has the longest median body (123 characters); the over-index is most plausibly reporting behaviour rather than a US-specific defect — the bug is locale-independent date arithmetic and Brazil and Chile reported it too; the US mean is the lowest of any large storefront as a direct arithmetic consequence of carrying 29 calendar-bug reviews at 2.95

- **Where:** §7.2 United States (verbatim table) — n=201, mean 4.443 (lowest eligible); zero-cost 48.26%; comparison shopping 17.41%; any bug 17.41%; calendar bug 14.43% — 29 of 37 global reports (78.4%) vs a 54.9% corpus share; median body 123 chars; the over-index is most plausibly reporting behaviour, not a US-specific defect (date arithmetic is locale-independent; Brazil and Chile reported it too)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 201 | vs global ; Zero-cost praise | 97 | 48.26% | ≈ global (46.99%) ; Simplicity praise | 68 | 33.83% | ≈ global ; Comparison shopping | 35 | 17.41% | above global (14.21%) ; Any bug | 35 | 17.41% | above global (12.57%) ; Calendar bug | 29 | 14.43% | above global (10.11%) ; Behaviour change | 27 | 13.43% | above global ; UI praise | 26 | 12.94% | ≈ global ; Any request | 27 | 13.43% | below global (16.39%) ; Widget | 9 | 4.48% | ≈ global ; Habit-cap praise | 9 | 4.48% | above global (3.28%) ; Data loss | 5 | 2.49% | ≈ global ; Dark mode | 6 | 2.99% | below global (4.10%)
- **Direction for us:** none · **Report confidence:** very strong · **Generalisable:** app-specific
- **Review IDs:** `12225388457`, `12493412514`, `13337918653`, `13594048622`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R29-092 — India (n=57, 15.6%, mean 4.895, 89.5% 5★ vs 73.6% US; median body 71 vs 123 characters; 53 of 57 post-2024): zero-cost praise 47.37%, simplicity 29.82%, requests 21.05% (above 16.39%), UI praise 15.79%, dark mode 8.77% (2.9× global), flexible frequency 7.02% (1.8×), comparison shopping 5.26% (below), stats praise 5.26%, any bug 0.00%, calendar bug 0.00%; the voice is gratitude framed around access ('Thank you for making it free! You're doing a great service to students who cannot afford to spend on applications'; 'this good deed of urs for humanity is outstanding'; 'Salute to the developer'; 'thank you to developers for creating this masterpiece'); the single most detailed feature request in the corpus is Indian — dark mode/themes, stats export to PNG/PDF/Sheets, sort-by, and social sign-in; India's zero bug reports should not be read as India experiencing no bugs (shorter, post-fix-era reviews; no mechanism by which date arithmetic spares one storefront), so 4.895 is not comparable to the US 4.443 as satisfaction — but India is comparable as a demand signal, and its dark-mode rate is the single strongest country-level feature signal in the report

- **Where:** §7.3 India (verbatim table) — n=57, mean 4.895, 89.5% 5★, median 71 chars, 93% post-2024; zero bugs; dark mode 8.77% (2.9× global), flexible frequency 7.02%; gratitude framed around access ('Salute to the developer'; 'this masterpiece'); the single most detailed feature request (dark mode/themes, stats export to PNG/PDF/Sheets, sort-by, social sign-in); India's zero bugs should not be read as no bugs — not comparable as satisfaction, but its dark-mode rate is the single strongest country-level feature signal
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of 57 | vs global ; Zero-cost praise | 27 | 47.37% | ≈ global ; Simplicity praise | 17 | 29.82% | ≈ global ; Any request | 12 | 21.05% | above global (16.39%) ; UI praise | 9 | 15.79% | above global (12.30%) ; Dark mode | 5 | 8.77% | 2.9× global (4.10%) ; Flexible frequency | 4 | 7.02% | 1.8× global (3.83%) ; Comparison shopping | 3 | 5.26% | below global (14.21%) ; Statistics praise | 3 | 5.26% | above global (2.73%) ; Any bug | 0 | 0.00% | vs 12.57% global ; Calendar bug | 0 | 0.00% | vs 10.11% global
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `12133935681`, `13143629702`, `13490562375`, `13922902193`, `13788344889`, `13897083789`, `13681701955`, `12568250547`, `12461644084`, `11723366610`, `12548926052`, `12919657449`, `13987910930`, `14254134741`, `12204928662`, `12699325873`, `13480035328`, `13624270960`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C080 Colour themes / dark mode

### R29-093 — High-spend markets (defined a priori from conventional high-ARPU storefronts — US, GB, CA, AU, DE, JP, FR, KR, CH, AT, IT, ES, IL, SA, AE; not derived from the data): n=275 (75.1%), mean 4.484, any bug 15.3%, zero-cost praise 48.0%, requests 14.9% vs all other markets n=91 (24.9%), mean 4.758, bug 4.4%, zero-cost 44.0%, requests 20.9% — high-spend markets rate the app 0.27 stars lower and report bugs 3.5× more often while praising the zero-cost model at a nearly identical rate; the zero-cost appeal is not a low-income-market phenomenon, it is uniform — what differs is the willingness to file a detailed complaint; for a product whose commercial question is 'can anything be sold here', the uniformity across income bands is the more consequential half

- **Where:** §7.4 High-spend group (US, GB, CA, AU, DE, JP, FR, KR, CH, AT, IT, ES, IL, SA, AE; a priori) n=275 (75.1%), mean 4.484, any bug 15.3%, zero-cost 48.0% vs rest n=91, mean 4.758, bug 4.4%, zero-cost 44.0% — high-spend markets rate 0.27 lower and report bugs 3.5× more while praising zero cost at a nearly identical rate: the zero-cost appeal is not a low-income-market phenomenon, it is uniform
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Group | n | % of corpus | Mean | Any bug % | Zero-cost praise % | Any request % ; High-spend markets | 275 | 75.1% | 4.484 | 15.3% | 48.0% | 14.9% ; All other markets | 91 | 24.9% | 4.758 | 4.4% | 44.0% | 20.9%
- **Direction for us:** product-rule · **Report confidence:** group-level · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C062 Weight English-speaking rich markets; volume ≠ revenue

### R29-094 — Top five storefronts by review count (a disclosed proxy for market presence, not downloads): US 201 (4.443, bug 17.4%, zero-cost 48.3%, requests 13.4% — carries 78.4% of calendar-bug reports); IN 57 (4.895, 0.0%, 47.4%, 21.1% — dark mode 8.77%); GB 26 (4.577, 3.8%, 46.2%, 19.2% — highest simplicity rate 42.3%); CA 19 (4.526, 15.8%, 42.1%, 15.8% — data loss 10.5%, 2 of 19); AU 13 (4.769, 15.4%, 69.2%, 15.4% — comparison shopping 53.8%, 7 of 13) = 316 (86.3%); the zero-cost theme is present at 42–69% in every one of the top five — the most consistent finding in the report, holding across every income level, language and review-length profile

- **Where:** §7.5 High-review-volume group (verbatim table) — top five US, IN, GB, CA, AU = 316 (86.3%, a disclosed proxy, not downloads); GB highest simplicity 42.3%; CA data loss 10.5% (2 of 19); AU zero-cost 69.2% and comparison shopping 53.8%; the zero-cost theme is 42–69% in every one of the top five — the most consistent finding in the report
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Storefront | n | Mean | Bug % | Zero-cost % | Request % | Distinctive ; US | 201 | 4.443 | 17.4% | 48.3% | 13.4% | Carries 78.4% of all calendar-bug reports ; IN | 57 | 4.895 | 0.0% | 47.4% | 21.1% | Dark mode 8.77%; zero bug reports ; GB | 26 | 4.577 | 3.8% | 46.2% | 19.2% | Highest simplicity rate (42.3%) ; CA | 19 | 4.526 | 15.8% | 42.1% | 15.8% | Data loss 10.5% (2 of 19) ; AU | 13 | 4.769 | 15.4% | 69.2% | 15.4% | Comparison shopping 53.8% (7 of 13) ; 316 of 366 (86.3%)
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** app-specific
- **Canonical:** C001 Never move a free feature behind the paywall

### R29-095 — Limited evidence: Brazil (n=9) is the lowest-rated storefront of any size at 3.778, with 3 of its 9 reviews reporting the calendar bug and 2 total data loss (one signs off '(Brasil)' as if flagging a regional problem, one asks support to act) — Portuguese is supported per the listing so this is not a localisation failure, and n=9 could be chance; Australia (n=13) shows the corpus's highest comparison-shopping rate (53.8%, 7 of 13) alongside the highest zero-cost praise (69.2%), every review post-dating 2025 — if real, the app is winning an active search market there; n=13 cannot establish it

- **Where:** §7.6 Sub-50 limited evidence — Brazil (n=9) lowest-rated storefront at 3.778 with 3 of 9 calendar-bug reports and 2 total data losses, Portuguese is supported so not localisation; Australia (n=13) comparison shopping 53.8% and zero-cost 69.2%, all post-2025 — possibly winning an active search market
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** br n=9, 3.778, 3 calendar, 2 data loss; au n=13, 53.8% comparison, 69.2% free
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `12225388457`, `12493412514`, `13337918653`, `12205032693`, `13172589582`, `13246295251`, `13628332072`, `13980761590`, `14001397712`, `14381720374`
- **Canonical:** — (nuance register)

### R29-096 — Language coverage (limited evidence, n=1 each): the store lists 8 languages and excludes Spanish, Russian, Hindi, Arabic, Korean and Vietnamese; a reviewer on the Uzbekistan storefront writing in Spanish asks 'No puedo cambiar la lengua, ayuden me por favor' (5★); Spanish-language reviews also come from CL, MX, AR, ES and even the US storefront — 8 Spanish-language reviews in total against zero Spanish localisation; Russian appears twice, both 5★ — the cheapest defensible localisation case in the report, made from 8 records

- **Where:** §7.6 Language coverage (limited evidence) — the store lists 8 languages and excludes Spanish, Russian, Hindi, Arabic, Korean, Vietnamese; 8 Spanish-language reviews (UZ, CL, MX, AR, ES, US) against zero Spanish localisation, one blocked ('No puedo cambiar la lengua, ayuden me por favor'); Russian twice, both 5★ — the cheapest defensible localisation case, made from 8 records
- **This app does:** no Spanish/Russian localisation
- **User reaction:** blocked-conversion
- **Magnitude:** 8 Spanish-language reviews; 2 Russian; 1 blocked
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `14030455237`, `13463203990`, `13594048622`, `13962928441`, `14370833112`, `14305710033`, `14024707633`, `13883547720`, `11597240211`, `13688018749`
- **Canonical:** C027 Localise early — it unlocks revenue

### R29-097 — Global vs US vs India: zero cost 46.99% / 48.26% / 47.37% — universal; simplicity 32.51 / 33.83 / 29.82 — no divergence; any bug 12.57 / 17.41 / 0.00 — reporting behaviour, not incidence; requests 16.39 / 13.43 / 21.05 — India asks for more; dark mode 4.10 / 2.99 / 8.77 — India 2.9× global; widget 4.37 / 4.48 / 1.75 — a US/UK/AU concern; comparison shopping 14.21 / 17.41 / 5.26 — Anglophone markets

- **Where:** §7.7 Global comparison summary (verbatim table) — zero cost universal (46.99 / 48.26 / 47.37); simplicity none; any bug 12.57 / 17.41 / 0.00 (reporting behaviour, not incidence); requests India asks more; dark mode India 2.9×; widget a US/UK/AU concern (IN 1.75%); comparison shopping Anglophone (IN 5.26%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | Global | US | IN | Notable divergence ; Zero cost | 46.99% | 48.26% | 47.37% | None — this is universal ; Simplicity | 32.51% | 33.83% | 29.82% | None ; Any bug | 12.57% | 17.41% | 0.00% | Reporting behaviour, not incidence (7.3) ; Any request | 16.39% | 13.43% | 21.05% | India asks for more ; Dark mode | 4.10% | 2.99% | 8.77% | India 2.9× global ; Widget | 4.37% | 4.48% | 1.75% | US/UK/AU concern ; Comparison shopping | 14.21% | 17.41% | 5.26% | Anglophone markets
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R29-119 — E3: Spanish localisation first, then Russian — non-listed-language markets are served in English today and at least one user is actively blocked; 8 Spanish-language reviews across UZ/CL/MX/AR/ES/US against zero Spanish support; limited evidence (8 records)

- **Where:** §9.2 E3 — Spanish localisation first, then Russian: non-listed-language markets are served in English and at least one user is blocked (8 Spanish-language reviews; limited evidence)
- **This app does:** no Spanish
- **User reaction:** blocked-conversion
- **Magnitude:** 8
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `14030455237`
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R29-006 — The prompt has not yet reached most users — which is exactly why the window to change it is open: of the 62 reviews dated 1 May 2026 or later, 3 mention the web-indexing prompt and 28 (45.2%) still praise the app for having no ads or no subscription ('I love that there are no overbearing ads', 17 Jul 2026, through 1 Sep 2026); post-May-2026 mean 4.516, indistinguishable from the corpus; the rollout appears partial, geo-limited or skippable for most users — the corpus cannot tell which — but the app still enjoys its no-cost reputation four months after the prompt appeared, alongside three reviewers who experienced it as a bait-and-switch; both things are currently true

- **Where:** Executive summary #4 — the prompt has not yet reached most users, which is why the window to change it is open: of 62 reviews from 1 May 2026, 3 mention it and 28 (45.2%) still praise no ads / no subscription; post-May-2026 mean 4.516; the rollout appears partial, geo-limited or skippable — the app still enjoys its no-cost reputation alongside three reviewers who experienced a bait-and-switch
- **This app does:** partial rollout of the SDK prompt
- **User reaction:** mixed
- **Magnitude:** 3 of 62 hit it; 28 of 62 (45.2%) still praise free; post-May mean 4.516
- **Direction for us:** dont · **Report confidence:** interpretation · **Generalisable:** app-specific
- **Review IDs:** `14312607560`, `14381720374`, `14432719449`, `14437514738`, `14493599797`, `14497877998`
- **Canonical:** C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-016 — Per year: 2024 (from 20 Jun) n=55 (15.0%), mean 4.473, 5★ 76.4%, 1★ 5.5%; 2025 n=158 (43.2%), 4.487, 75.3%, 5.7%; 2026 (to 2 Sep) n=153 (41.8%), 4.647, 80.4%, 2.6%; first review 20 Jun 2024 (AT, 5★ — 'Kostenlos und voll umfänglich' / 'Free and fully complete'); last 2 Sep 2026; span 2 years 2.4 months

- **Where:** §1.4 Date range and shape — per-year table (verbatim): 2024 (from 20 Jun) 55 / 4.473 / 1★ 5.5%; 2025 158 / 4.487 / 5.7%; 2026 (to 2 Sep) 153 / 4.647 / 2.6%; first review 'Kostenlos und voll umfänglich' (AT)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Period | n | % of corpus | Mean rating | 5★ share | 1★ share ; 2024 (from 20 Jun) | 55 | 15.0% | 4.473 | 76.4% | 5.5% ; 2025 | 158 | 43.2% | 4.487 | 75.3% | 5.7% ; 2026 (to 2 Sep) | 153 | 41.8% | 4.647 | 80.4% | 2.6%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `11402735091`, `14500436553`
- **Canonical:** — (nuance register)

### R29-017 — By half-year: 2024H1 n=2 (never used for a claim); 2024H2 53, mean 4.45, 5★ 75.5%, calendar bug 9.4%, any bug 11.3%, zero-cost praise 47.2%, any request 26.4%; 2025H1 94, 4.39, 70.2%, 20.2%, 22.3%, 44.7%, 14.9%; 2025H2 64, 4.62, 82.8%, 14.1%, 14.1%, 42.2%, 14.1%; 2026H1 122, 4.66, 80.3%, 2.5%, 6.6%, 46.7%, 13.1%; 2026H2 31, 4.61, 80.6%, 3.2%, 6.5%, 61.3%, 22.6%

- **Where:** §1.4 Half-year table (verbatim) — 2024H2 53 / 4.45 / calendar bug 9.4% / any bug 11.3% / zero-cost 47.2%; 2025H1 94 / 4.39 / 20.2% / 22.3% / 44.7%; 2025H2 64 / 4.62 / 14.1% / 14.1% / 42.2%; 2026H1 122 / 4.66 / 2.5% / 6.6% / 46.7%; 2026H2 31 / 4.61 / 3.2% / 6.5% / 61.3%; 2024H1 n=2 never used
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2024H1 | 2 | 5.00 | 100.0 | 0.0 | 0.0 | 100.0 | 0.0 ; 2024H2 | 53 | 4.45 | 75.5 | 9.4 | 11.3 | 47.2 | 26.4 ; 2025H1 | 94 | 4.39 | 70.2 | 20.2 | 22.3 | 44.7 | 14.9 ; 2025H2 | 64 | 4.62 | 82.8 | 14.1 | 14.1 | 42.2 | 14.1 ; 2026H1 | 122 | 4.66 | 80.3 | 2.5 | 6.6 | 46.7 | 13.1 ; 2026H2 | 31 | 4.61 | 80.6 | 3.2 | 6.5 | 61.3 | 22.6
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C059 Be visibly responsive; fixes bring reviewers back

### R29-076 — Calendar-bug time trend: by year 2024 5/55 (9.1%) → 2025 28/158 (17.7%) → 2026 4/153 (2.6%); by half-year 2024H2 9.4% → 2025H1 20.2% → 2025H2 14.1% → 2026H1 2.5% → 2026H2 3.2%; the corpus mean tracks the fix — 4.473 → 4.487 → 4.647; the rollover fault appears substantially fixed between 2025H2 and 2026H1 (~8× reduction), but the weekday-offset face is not fully fixed — 2026 survivors on 1 Jan, 4 Jan (CL, 'está desfasado' / 'it's offset'), 18 Jun (AU, 'the dates/days in the calendar don't line up') and 22 Jul (US, 'the last day of each month'); high confidence on the trend, medium on attributing it to a specific release (no version field)

- **Where:** §4.5 Time trend (verbatim tables) — 2024 9.1% → 2025 17.7% → 2026 2.6%; half-year 9.4% → 20.2% → 14.1% → 2.5% → 3.2%; ~8× reduction between 2025H2 and 2026H1 as the corpus mean rose 4.473 → 4.487 → 4.647; 2026 survivors (Jan, Jan 'está desfasado', Jun 'dates/days don't line up', Jul 'last day of each month') show the weekday-offset face not fully fixed
- **This app does:** rollover fixed ~2026H1; offset residual
- **User reaction:** praise
- **Magnitude:** Period | Calendar-bug reports | n | Rate ; 2024 (from 20 Jun) | 5 | 55 | 9.1% ; 2025 | 28 | 158 | 17.7% ; 2026 (to 2 Sep) | 4 | 153 | 2.6% ; 2024H2 | 9.4% ; 2025H1 | 20.2% ; 2025H2 | 14.1% ; 2026H1 | 2.5% ; 2026H2 | 3.2%
- **Direction for us:** must-never-break · **Report confidence:** high (trend) / medium (cause) · **Generalisable:** yes
- **Review IDs:** `13579197540`, `13594048622`, `14195919004`, `14332675510`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C059 Be visibly responsive; fixes bring reviewers back

### R29-082 — 1★ (n=16): calendar bug 7; data loss 4 (overlapping); 'web indexing' privacy prompt 3; cannot edit habit 2; notifications never fire 1; missing frequency option 1; app will not launch 1 ('Lässt sich nichtmal öffnen' / 'It won't even open', DE); apparent mis-rating with positive text 1; two structural observations — not one 1★ in 366 records is about price (there is no price to object to), and the composition changed completely between eras: all 11 one-star reviews from 2024–2025 are functional (9 bugs, 2 missing capabilities), while of the 5 one-star reviews in 2026, 3 are the privacy prompt, 1 a launch failure and 1 the apparent mis-tap — the app fixed its way out of one 1★ driver and introduced another

- **Where:** §5.5 1★ table (verbatim) — calendar bug 7, data loss 4 (overlapping), web-indexing privacy prompt 3, cannot edit habit 2, notifications never fire 1, missing frequency option 1, app will not launch 1 ('Lässt sich nichtmal öffnen'), apparent mis-rating 1; not one 1★ is about price; all 11 one-stars in 2024–25 are functional, and of 5 in 2026, 3 are the privacy prompt — the app fixed its way out of one 1★ driver and introduced another
- **This app does:** fixed calendar bug; added bandwidth-sharing prompt
- **User reaction:** 1★-burst
- **Magnitude:** Cause | n | IDs ; Calendar bug | 7 | 12130015583, 12132074900, 12253431387, 12254692368, 12493412514, 12602757554, 13337918653 ; Data loss (overlapping with above) | 4 | 11673002290, 12253431387, 12493412514, 13337918653 ; "Web indexing" privacy prompt | 3 | 14092044479, 14103247613, 14391211979 ; Cannot edit habit | 2 | 11673002290, 11782815253 ; Notifications never fire | 1 | 12615584327 ; Missing frequency option | 1 | 11700402770 ; App will not launch | 1 | 14402480049 (DE, *"Lässt sich nichtmal öffnen"* / "It won't even open") ; Apparent mis-rating (positive text) | 1 | 13890862557
- **Direction for us:** dont · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `12130015583`, `12132074900`, `12253431387`, `12254692368`, `12493412514`, `12602757554`, `13337918653`, `11673002290`, `14092044479`, `14103247613`, `14391211979`, `11782815253`, `12615584327`, `11700402770`, `14402480049`, `13890862557`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-098 — Headline half-year series: 2024H2 n=53, mean 4.45, 5★ 75.5%, calendar bug 9.4%, any bug 11.3%, zero-cost 47.2%, requests 26.4%; 2025H1 94, 4.39, 70.2%, 20.2%, 22.3%, 44.7%, 14.9%; 2025H2 64, 4.62, 82.8%, 14.1%, 14.1%, 42.2%, 14.1%; 2026H1 122, 4.66, 80.3%, 2.5%, 6.6%, 46.7%, 13.1%; 2026H2 31, 4.61, 80.6%, 3.2%, 6.5%, 61.3%, 22.6%; 2024H1 (n=2) never used

- **Where:** Part 8 method; §8.1 headline half-year series (verbatim table) — 2024H2 53 / 4.45 / calendar 9.4 / bug 11.3 / zero-cost 47.2 / requests 26.4; 2025H1 94 / 4.39 / 20.2 / 22.3 / 44.7 / 14.9; 2025H2 64 / 4.62 / 14.1 / 14.1 / 42.2 / 14.1; 2026H1 122 / 4.66 / 2.5 / 6.6 / 46.7 / 13.1; 2026H2 31 / 4.61 / 3.2 / 6.5 / 61.3 / 22.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Half-year | n | Mean | 5★ % | Calendar bug % | Any bug % | Zero-cost % | Requests % ; 2024H2 | 53 | 4.45 | 75.5 | 9.4 | 11.3 | 47.2 | 26.4 ; 2025H1 | 94 | 4.39 | 70.2 | 20.2 | 22.3 | 44.7 | 14.9 ; 2025H2 | 64 | 4.62 | 82.8 | 14.1 | 14.1 | 42.2 | 14.1 ; 2026H1 | 122 | 4.66 | 80.3 | 2.5 | 6.6 | 46.7 | 13.1 ; 2026H2 | 31 | 4.61 | 80.6 | 3.2 | 6.5 | 61.3 | 22.6
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R29-099 — Trend 1 (improving, high confidence): the calendar bug peaked in 2025H1 and was substantially fixed by 2026H1 — 20.2% → 14.1% → 2.5%, an ~8× reduction, with the corpus mean rising in step 4.39 → 4.62 → 4.66; four residual reports survive in 2026, two of them the weekday-offset face rather than the rollover face — a partial rather than complete fix; medium confidence on attributing it to a specific release

- **Where:** §8.2 Trend 1 — the calendar bug peaked in 2025H1 and was substantially fixed by 2026H1 (improving, high confidence): 20.2 → 14.1 → 2.5%, ~8×; mean 4.39 → 4.62 → 4.66; two residual 2026 reports are the weekday-offset face — a partial fix
- **This app does:** partial date-bug fix
- **User reaction:** praise
- **Magnitude:** 20.2% → 2.5%
- **Direction for us:** must-never-break · **Report confidence:** high · **Generalisable:** app-specific
- **Review IDs:** `14195919004`, `14332675510`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C059 Be visibly responsive; fixes bring reviewers back

### R29-100 — Trend 2 (improving, high confidence): any-bug rate 11.3% (2024H2) → 22.3% (2025H1) → 14.1% → 6.6% → 6.5%; the 1★ share fell from 5.5% (2024) and 5.7% (2025) to 2.6% (2026)

- **Where:** §8.3 Trend 2 — overall bug reporting fell by two-thirds (11.3 → 22.3 → 14.1 → 6.6 → 6.5%); 1★ share 5.5% (2024) / 5.7% (2025) → 2.6% (2026)
- **This app does:** stabilised
- **User reaction:** praise
- **Magnitude:** 22.3% → 6.5%; 1★ 5.7% → 2.6%
- **Direction for us:** none · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** C031 Crashes / launch failures; C059 Be visibly responsive; fixes bring reviewers back

### R29-101 — Trend 3 (fixed, medium confidence): all four 'cannot edit a habit' reports fall 14 July → 7 November 2024 and a May 2025 reviewer states the opposite ('easy to edit each habit/task'); medium because absence of complaint is weaker than presence of praise, n=4

- **Where:** §8.4 Trend 3 — the 'cannot edit a habit' complaint appears only in 2024 (14 Jul–7 Nov) and vanishes; a May 2025 reviewer says 'easy to edit each habit/task' (fixed, medium confidence)
- **This app does:** editing added after launch
- **User reaction:** praise
- **Magnitude:** 4 in 2024, 0 after
- **Direction for us:** none · **Report confidence:** medium · **Generalisable:** app-specific
- **Review IDs:** `11490852349`, `11673002290`, `11782815253`, `11922911236`, `12622290066`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C073 Manual reordering, renaming and editing of habits/tasks — free

### R29-102 — Trend 4 (emerging): the 'web indexing' monetisation prompt is new — zero mentions before 22 May 2026, three after (22 May, 25 May, 5 Aug), all 1★; high confidence it exists and is new (three independent reviewers in two countries describe the same specific mechanic in near-identical terms, not a coincidence pattern); low confidence on its reach

- **Where:** §8.5 Trend 4 — the 'web indexing' prompt is new and confined to 2026 (emerging; high confidence on existence — three independent reviewers in two countries describe the same mechanic in near-identical terms — low on scale)
- **This app does:** SDK prompt shipped May 2026
- **User reaction:** 1★-burst
- **Magnitude:** 0 before → 3 after, all 1★
- **Direction for us:** dont · **Report confidence:** high (existence) / low (scale) · **Generalisable:** yes
- **Review IDs:** `14092044479`, `14103247613`, `14391211979`
- **Canonical:** C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-103 — Trend 5 (persistent, medium confidence): zero-cost praise 47.2% → 44.7% → 42.2% → 46.7% → 61.3% (2026H2, n=31 — do not over-read the spike); the durable finding is that the theme held between 42% and 49% for two full years with no downward drift despite the arrival of the web-indexing prompt in the same period

- **Where:** §8.6 Trend 5 — zero-cost praise is not fading and spiked in the latest half-year (47.2 → 44.7 → 42.2 → 46.7 → 61.3%, n=31); durable finding: 42–49% for two full years with no downward drift despite the web-indexing prompt arriving
- **This app does:** free reputation intact
- **User reaction:** praise
- **Magnitude:** 42–49% for two years; 61.3% latest
- **Direction for us:** product-rule · **Report confidence:** medium · **Generalisable:** app-specific
- **Canonical:** C001 Never move a free feature behind the paywall

### R29-104 — Trend 6 (persistent theme, changing content, medium confidence): 2024H2 had the highest request rate (26.4%) dominated by structural gaps — editing 4, frequency 5, widget 4; 2026 requests are dominated by polish — 8 of the 15 dark-mode requests and 7 of the 16 widget requests are 2026; flexible-frequency requests persist in every period (2024H2 5, 2025 6, 2026 3) and are the only request theme that never resolves

- **Where:** §8.7 Trend 6 — the request mix shifted from 'make it work' (2024H2: editing 4, frequency 5, widget 4) to 'make it nicer' (2026: 8 of 15 dark-mode and 7 of 16 widget requests); flexible frequency persists in every period and is the only request theme that never resolves
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 26.4% → 13–22%; dark mode 8/15 in 2026; widget 7/16
- **Direction for us:** must-have · **Report confidence:** medium · **Generalisable:** app-specific
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app; C043 Flexible / custom frequency; C080 Colour themes / dark mode

### R29-105 — Trend 7 (emerging, low confidence): all three rating-prompt complaints (Aug 2025, Jan 2026, Mar 2026) fall in the last 13 months; the share of ≤50-character 5★ reviews is broadly flat across eras, so the corpus cannot confirm prompting increased — only that complaints about it are recent

- **Where:** §8.8 Trend 7 — rating-prompt complaints are all recent (Aug 2025, Jan 2026, Mar 2026); the ≤50-char 5★ share is broadly flat so the corpus cannot confirm prompting increased (low confidence, n=3)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 3 in 13 months
- **Direction for us:** dont · **Report confidence:** low · **Generalisable:** app-specific
- **Review IDs:** `13059723695`, `13598041567`, `13848623635`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

## Positioning

### R29-001 — Habit Tracker – Daily Goals — 'Motivation & Accountability' (App Store ID 6480042457, Uniqo Lab FZC) — a young (Jun 2024→) free tracker with no IAP listed and no reviewer anywhere reporting having paid; monetised off-ledger from May 2026 via an in-app prompt to enable 'web indexing' (a bandwidth/IP-sharing opt-in) in exchange for an ad-free experience — the central commercial fact

- **Where:** header lines 1-9; §10.6 External sources
- **This app does:** developer of record Uniqo Lab FZC; bundle uniqo.habit; extracted 8 Sep 2026; analysis 11 Sep 2026; store rank 29; free, no IAP, internet-sharing SDK prompt
- **User reaction:** mixed
- **Magnitude:** 366 reviews · 33 storefronts · 20 Jun 2024 → 2 Sep 2026; mean 4.552; 5★ 284 (77.6%) / 4★ 41 / 3★ 16 / 2★ 9 / 1★ 16
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R29-004 — The users are comparison shoppers who arrived pre-annoyed at the category's pricing: 52 reviews (14.21%, high-priority, mean 4.83) explicitly describe having tried, downloaded or rejected other habit trackers, and 34 of those 52 (65.4% segment; 9.29% global) also praise zero cost — 'I've in the past 2 months downloaded 20 habit tracking apps and none was satisfactory'; 'I have gone through a couple apps and they all made me pay for more than 3 habits'; 'they're all like premium this, subscription that… here it's just free, like properly FREE'; 'Took some time to find this on the App Store'; 'took me forever to find one of this quality'; this app wins a bake-off it never enters — its acquisition channel is competitor paywall fatigue, so competitors' pricing decisions, not this app's marketing, drive its installs

- **Where:** Executive summary #2 — users are comparison shoppers who arrived pre-annoyed at the category's pricing: 52 (14.21%, mean 4.83) tried or rejected other trackers and 34 of those 52 (65.4%) also praise zero cost ('downloaded 20 habit tracking apps and none was satisfactory'; 'they all made me pay for more than 3 habits'; 'premium this, subscription that… here it's just free, like properly FREE'; 'took me forever to find one of this quality'); the app wins a bake-off it never enters — competitors' pricing decisions drive its installs
- **This app does:** free in a paywalled category
- **User reaction:** purchase-driver
- **Magnitude:** 52 (14.21%), mean 4.83; 34 of 52 also praise free
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12308098235`, `12152186871`, `13933385748`, `14001397712`, `13980761590`, `11406684047`, `11939963526`, `12169274305`, `12269619388`, `12509751174`, `12859184477`, `12920818324`, `12930469783`, `13172589582`, `13246295251`, `13513275431`, `13706946367`, `13832226279`, `14041180742`, `14181244719`, `14381720374`
- **Canonical:** C005 Know which competitors buyers compare against; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R29-030 — Arrived after rejecting other trackers

- **Where:** §3.1 Master table #6 Arrived after rejecting other trackers
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 52 (14.21%, HIGH), mean 4.83
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

## Anti-patterns

### R29-124 — Anti-pattern and cost: a free app whose whole reputation is 'no cost' put a launch-screen prompt asking users to let their device route third-party web traffic for an ad-free experience; everyone who wrote about it gave 1★, two of three quit at the opening screen before using the product, and it turned the 1★ band from functional bugs (2024–25) into a privacy complaint (3 of 5 one-stars in 2026) — 'You PAID for this free app'

- **Where:** Executive summary #3 / §5.5 / §6.4 — anti-pattern: gating first launch behind a bandwidth/IP-sharing opt-in in a free app whose reputation is 'actually free'
- **This app does:** internet-sharing SDK gate at launch
- **User reaction:** 1★-burst
- **Magnitude:** 3 (100% 1★); 3 of 5 2026 one-stars
- **Direction for us:** dont · **Report confidence:** emerging — severity · **Generalisable:** yes
- **Review IDs:** `14092044479`, `14103247613`, `14391211979`
- **Canonical:** C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-125 — Anti-pattern and cost: with no account, no cloud backup and no export, users discovered that reinstalling cleared the calendar bug — and reinstalling deleted everything; 9 data-loss reports at mean 2.11, the lowest-rated theme, three describing re-entering all habits by hand ('just sad I lost my data from uninstalling it')

- **Where:** §4.4 — anti-pattern: a local-only data store with no export makes 'reinstall' the workaround users teach each other, and the workaround destroys the history
- **This app does:** local-only store, no export
- **User reaction:** churn
- **Magnitude:** 9 (2.46%), mean 2.11
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12257572119`, `12604107314`, `11789546578`
- **Canonical:** C020 Data export / backup / CSV; C034 Data must never be lost on update, reinstall or phone change

## Things not to do

### R29-053 — Rating prompt fires too early

- **Where:** §3.1 Master table #29 Rating prompt fires too early
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 3 (0.82%, emerging), mean 4.00
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R29-114 — Fix #8: delay the rating prompt to day 7 or after ~10 completions — 3 direct complaints + 39 contentless 5★ (median 27 chars, 100% 5★) + multiple day-one reviews; trades a small amount of rating volume for reviews that actually contain information — the developer currently has almost no diagnostic feedback despite 366 reviews

- **Where:** §9.1 #8 — delay the rating prompt to day 7 or after ~10 completions; trades a little rating volume for reviews that contain information — the developer has almost no diagnostic feedback despite 366 reviews
- **This app does:** prompt on first check-off
- **User reaction:** 5★-burst
- **Magnitude:** 3 + 39
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R29-123 — What not to change: do not cap habit count — 12 reviews praise the uncapped list by name and 52 comparison shoppers arrived because a competitor capped them, the single most protected property in the corpus; do not add features to the main flow — 119 praise simplicity, 3 call it too basic, 40:1; do not require an account — one names its absence as the deciding factor, so any backup must be optional and local-first; do not introduce a subscription — 'no subscription' is the highest-rated sub-theme (44 reviews, mean 4.98) and 4 reviewers have publicly conditioned their loyalty on its absence

- **Where:** §9.4 What not to change — do not cap habit count (the most protected property: 12 praise it, 52 arrived because a competitor capped them); do not add features to the main flow (simplicity 119 vs 'too basic' 3, 40:1); do not require an account; do not introduce a subscription ('no subscription' is the highest-rated sub-theme at 4.98 and 4 reviewers conditioned their loyalty on its absence)
- **This app does:** free, uncapped, simple, account-free
- **User reaction:** praise
- **Magnitude:** 12 / 52 / 119 vs 3 / 44 at 4.98 / 4
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13625278409`
- **Canonical:** C001 Never move a free feature behind the paywall; C006 Stay minimal — every addition is opt-in or off by default; C007 Generous fixed habit cap (or unlimited) — never change it; C209 No sign-up wall before first use

## Things to do

### R29-015 — Cheapest high-value actions in evidence order: decide and disclose the web-indexing policy before it scales (3, all 1★) → ship a Home Screen widget (16) → ship dark mode (15) → add flexible frequency: x/week, every-other-n, monthly, multi-per-day (14) → add local export/backup so a date bug can never again mean total loss (9) → close out the residual month-rollover tail (4 in 2026) → delay the rating prompt past day 7 (3 direct + 39 contentless 5★) → fix notification lifecycle: stop reminders for completed and deleted habits (6 bugs + 3 requests) → add habit reordering/sorting (4) → open a working support address (5)

- **Where:** Executive summary #13 — cheapest high-value actions in evidence order
- **This app does:** none shipped as of Sep 2026
- **User reaction:** complaint
- **Magnitude:** report gives none (ranked list)
- **Direction for us:** do · **Report confidence:** summary ranking · **Generalisable:** yes
- **Canonical:** C020 Data export / backup / CSV; C036 A support channel that exists, is reachable outside the app, and answers; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C039 Reminders fire reliably, once; C040 Widgets must not go blank, stale or disagree with the app; C043 Flexible / custom frequency; C073 Manual reordering, renaming and editing of habits/tasks — free; C080 Colour themes / dark mode; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

## Contradictions

### R29-055 — Too basic vs competitors — the mirror image of the largest positive theme

- **Where:** §3.1 Master table #31 Too basic vs competitors
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 3 (0.82%, emerging), mean 3.00
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R29-069 — 'Too basic vs competitors' (3, 0.82%, mean 3.00): 'the app needs more features that other trackers have such as the ability to get rewards' (2★); 'It's VERY basic' (4★); 'It's built like a check list so you can't make a multi part task' (3★); a fourth frames it as a caveat while giving 5★ ('the simpleness of the app could be a turn off for people who want something more, but for me it's perfect'); the smallest negative theme in the corpus and the direct mirror image of the largest positive one — three people want more; 119 are here because there is less; the clearest 'do not fix' signal in the report

- **Where:** §3.3 N9 — 'too basic': 3 reviews (mean 3.00) want rewards, a multi-part task, 'more'; a 5★ frames it as a caveat ('could be a turn off for people who want something more, but for me it's perfect'); the smallest negative theme and the direct mirror of the largest positive one — three want more, 119 are here because there is less: the clearest 'do not fix' signal in the report
- **This app does:** minimal by design
- **User reaction:** mixed
- **Magnitude:** 3 (mean 3.00) vs 119 (mean 4.80)
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11490852349`, `11922911236`, `13848623635`, `13513275431`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

## Data caveats and method

### R29-002 — Method: 366/366 read chronologically in four files in the original language (24 non-English: pt 8, es 8, de 3, ru 2, zh 2, it 1); multilingual regex candidate sets then every candidate list manually audited — calendar/date pattern 55 → 37 (18 removed as end-date requests or unrelated 'stuck'/'month', 3 added), mental_health 9 → 3, adhd 4 → 3, stats_praise 16 → 10, comparison_shopping refined twice, behaviour_change 40 → 38 + 3, the three web-indexing reviews explicitly excluded from free/no-ads/no-sub praise; small themes hand-built with boundary rules; re-inspection of 30 borderline records gave ±2 error band on the two largest themes; cross-tabulation by rating, storefront, year, half-year and day-of-month (which identified the calendar bug's fingerprint); small corpus (0.27% per review, anything under ~4 is an anecdote); positive side nearly monothematic (46.99% zero-cost praise); zero direct purchase evidence (regex sweep 0 of 366); dominant defect largely historical; US 54.9%; only US (201) and IN (57) reach 50; written reviews only, 23.0% ≤50 chars and 90.5% of those 5★ — an early rating prompt; no version field; 2 years 2 months so no launch-vs-mature comparison; votes 0 on 357 records, is_edited 1; the web-indexing finding rests on 3 records and is promoted on severity, a disclosed judgement call; one external source (Proxyway) describes the SDK category only and is not evidence about this app

- **Where:** How to read this; Eight warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.5 Processing method; §1.6 Limitations and known biases; §10.4 counting rules; §10.5 corpus shape
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 366/366; 33 storefronts; 0 duplicates; 0 empty; 327 (89.3%) carry ≥1 theme, 39 contentless all 5★
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `11492021762`, `11624371093`, `11922911236`, `12656091993`, `13276697912`, `13480035328`, `13614313384`, `14341833236`, `14495210194`, `12132074900`, `12834935164`, `12961148231`, `11581026715`, `12016317906`, `14011499566`, `14466743179`, `11521506590`, `13675284721`, `13506372310`, `13460543209`, `13764364876`, `13897083789`, `13987910930`, `14297251498`, `11463686907`, `12043735920`, `12080359258`, `12174401255`, `12587757164`, `12829927902`, `13624270960`, `11765500247`, `12097192081`, `12481241464`, `12257572119`
- **Canonical:** — (nuance register)

### R29-018 — Feature inventory as users experience it

- **Where:** §2.1 Feature inventory table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence that users experience it | Example IDs ; Habit list with daily check-off | Universal | 12269619388, 13627010760, 14072264089 ; Per-habit weekday selection (pick which days) | Named repeatedly | 12152186871, 12269619388, 13480035328 ; Unlimited (or very high) habit count | Named with numbers | 12781234520, 13821769895, 14493599797 ; Colour coding per habit | Named | 12112287971, 12286885201, 13506372310 ; Categories / grouping | Named | 12296659841, 13506372310 ; Reminders / notifications with custom time and sound | Named | 12171965613, 14011499566, 13684390333 ; Completion sound effect | Named (and one complaint it can't be muted) | 12920818324, 11673002290 ; Calendar / month view with per-day history | Named constantly, mostly in bug reports | 12253630488, 13460543209, 13261739634 ; Statistics: bar graph, pie chart, weekly analytics | Named | 12089896129, 13143629702, 12528474609 ; "Completed days" progress rings | Named | 13628332072 ; Monthly overview | Named | 13922902193 ; Start date / end date on a habit | Named (and requested to allow "no end") | 13577309961, 12656091993, 13276697912 ; Streaks | Named (in a bug report about miscounting) | 12253630488 ; No account, no email, no login | Named as a feature | 13625278409 ; Rating prompt | Named by three reviewers | 13059723695, 13598041567, 13848623635 ; "Web indexing" opt-in prompt on launch screen | Named by three reviewers, all from May 2026 onward | 14092044479, 14103247613, 14391211979
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R29-022 — Three things follow from the listing and each is contradicted or complicated by the corpus: (1) 'no in-app purchases' is consistent with zero payment reports but one reviewer believes 'There's a premium, but you probably don't need it' — a single misreading, no other reviewer mentions a premium tier; (2) the listed language set omits Spanish, Russian, Hindi, Arabic, Korean and Vietnamese, yet reviews come from CL, MX, AR, ES, UZ, RU, IN, SA, EG, KR and VN — 'I can't change the language, please help me' (Spanish, from the Uzbekistan storefront, 5★); (3) the privacy disclosure ('product interaction data… for analytics and diagnostics') does not obviously cover routing third-party web traffic through a user's device and IP address — either the prompt is a separately-consented feature outside the analytics disclosure, or the listing's privacy summary is stale; two reviewers read the prompt as the app's real price and said so at 1★

- **Where:** §2.2 Three things follow from the listing, each complicated by the corpus — (1) one reviewer believes 'There's a premium, but you probably don't need it' (a single misreading, no paid tier exists); (2) the listed language set omits Spanish, Russian, Hindi, Arabic, Korean, Vietnamese yet reviews come from CL, MX, AR, ES, UZ, RU, IN, SA, EG, KR, VN ('No puedo cambiar la lengua, ayuden me por favor'); (3) the privacy disclosure does not obviously cover routing third-party web traffic through the user's device and IP — either a separately-consented feature or a stale summary
- **This app does:** listing languages incomplete; privacy label may be stale
- **User reaction:** complaint
- **Magnitude:** 1 + 1 + 3 reviews
- **Direction for us:** must-never-break · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `13625278409`, `14030455237`, `14103247613`, `14391211979`
- **Canonical:** C027 Localise early — it unlocks revenue; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-023 — External context, clearly separated from review evidence: the mechanic the three reviewers describe — an ad-free experience in exchange for sharing idle bandwidth and IP address with third-party clients — is an established category of app monetisation known as an 'internet sharing SDK' (Proxyway, accessed 11 Sep 2026); the source describes the category only, does not name this app, and nothing in it identifies which vendor, if any, this app uses

- **Where:** §2.2 External context — the mechanic the three reviewers describe (ad-free in exchange for sharing idle bandwidth and IP with third-party clients) is an established category, 'internet sharing SDKs' (Proxyway); the source describes the category only and does not identify this app's vendor
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 1 external source, category-level
- **Direction for us:** none · **Report confidence:** external context · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R29-024 — Master theme table, denominator 366

- **Where:** §3.1 Master table (verbatim), 55 themes
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | Direction | n | % of 366 | Signal | Mean ★ ; 1 | Zero cost cited as a reason for satisfaction | Positive | 172 | 46.99% | HIGH | 4.83 ; 2 | — of which: praises "free" | Positive | 121 | 33.06% | HIGH | 4.78 ; 3 | Simplicity / clean UI / ease of use | Positive | 119 | 32.51% | HIGH | 4.80 ; 4 | — of which: praises absence of ads | Positive | 60 | 16.39% | HIGH | 4.90 ; 5 | Any feature request | Unmet need | 60 | 16.39% | HIGH | 4.35 ; 6 | Arrived after rejecting other trackers | Positive | 52 | 14.21% | HIGH | 4.83 ; 7 | Any functional defect | Negative | 46 | 12.57% | HIGH | 2.89 ; 8 | UI / visual design praised | Positive | 45 | 12.30% | HIGH | 4.64 ; 9 | — of which: praises absence of subscription/IAP | Positive | 44 | 12.02% | HIGH | 4.98 ; 10 | Concrete behaviour change reported | Positive | 38 | 10.38% | HIGH | 4.87 ; 11 | Calendar / date engine defect | Negative | 37 | 10.11% | HIGH | 2.95 ; 12 | Explicit recommendation to others | Positive | 27 | 7.38% | HIGH | 4.81 ; 13 | Home Screen widget requested | Unmet need | 16 | 4.37% | very strong | 4.19 ; 14 | Dark mode requested | Unmet need | 15 | 4.10% | very strong | 4.67 ; 15 | Flexible frequency requested | Unmet need | 14 | 3.83% | very strong | 4.14 ; 16 | No habit-count cap praised | Positive | 12 | 3.28% | very strong | 4.92 ; 17 | Statistics / charts praised | Positive | 10 | 2.73% | meaningful | 4.60 ; 18 | Data / history loss | Negative | 9 | 2.46% | meaningful | 2.11 ; 19 | Notification / reminder defect | Negative | 6 | 1.64% | meaningful | 3.17 ; 20 | Support unreachable or unanswered | Negative | 5 | 1.37% | meaningful | 2.00 ; 21 | Cannot edit a habit after creation | Negative | 4 | 1.09% | meaningful | 2.00 ; 22 | Cannot reorder / sort habits | Negative | 4 | 1.09% | meaningful | 4.00 ; 23 | More colours / customisation requested | Unmet need | 4 | 1.09% | meaningful | 4.75 ; 24 | Quantity / unit tracking requested | Unmet need | 4 | 1.09% | meaningful | 4.50 ; 25 | End-date / no-end-date control requested | Unmet need | 4 | 1.09% | meaningful | 4.00 ; 26 | Anxiety that the app will stop being free | Mixed | 4 | 1.09% | meaningful | 5.00 ; 27 | Student / child / budget context | Positive | 4 | 1.09% | meaningful | 5.00 ; 28 | Stop reminders after completion (request) | Unmet need | 3 | 0.82% | emerging | 5.00 ; 29 | Rating prompt fires too early | Negative | 3 | 0.82% | emerging | 4.00 ; 30 | "Web indexing" opt-in rejected | Negative | 3 | 0.82% | emerging | 1.00 ; 31 | Too basic vs competitors | Negative | 3 | 0.82% | emerging | 3.00 ; 32 | iCloud sync / account / backup requested | Unmet need | 3 | 0.82% | emerging | 4.67 ; 33 | Richer statistics views requested | Unmet need | 3 | 0.82% | emerging | 4.00 ; 34 | Mental-health / recovery context | Positive | 3 | 0.82% | emerging | 4.67 ; 35 | ADHD / neurodivergence context | Mixed | 3 | 0.82% | emerging | 4.33 ; 36 | Notes per habit requested | Unmet need | 2 | 0.55% | emerging | 4.50 ; 37 | Time ordering / timestamps requested | Unmet need | 2 | 0.55% | emerging | 5.00 ; 38 | Explicitly willing to pay or donate | Mixed | 2 | 0.55% | emerging | 5.00 ; 39 | App will not launch | Negative | 1 | 0.27% | weak | 1.00 ; 40 | Completion sound cannot be muted | Negative | 1 | 0.27% | weak | 1.00 ; 41 | Could not add more than one habit | Negative | 1 | 0.27% | weak | 3.00 ; 42 | Asks whether data is the hidden price | Mixed | 1 | 0.27% | weak | 5.00 ; 43 | Believes a premium tier exists | Mixed | 1 | 0.27% | weak | 5.00 ; 44 | No account / no email praised | Positive | 1 | 0.27% | weak | 5.00 ; 45 | Per-habit streaks requested | Unmet need | 1 | 0.27% | weak | 5.00 ; 46 | Stats export requested | Unmet need | 1 | 0.27% | weak | 4.00 ; 47 | Shared habits for accountability requested | Unmet need | 1 | 0.27% | weak | 5.00 ; 48 | In-app rewards requested | Unmet need | 1 | 0.27% | weak | 2.00 ; 49 | Emoji on habits requested | Unmet need | 1 | 0.27% | weak | 4.00 ; 50 | Bad-habit / quit mode requested | Unmet need | 1 | 0.27% | weak | 4.00 ; 51 | Cannot change app language | Unmet need | 1 | 0.27% | weak | 5.00 ; 52 | Back-dating habits requested | Unmet need | 1 | 0.27% | weak | 4.00 ; 53 | Daily mood / wellbeing rating requested | Unmet need | 1 | 0.27% | weak | 5.00 ; 54 | Font disliked | Negative | 1 | 0.27% | weak | 5.00 ; 55 | Public plea for support to respond | Negative | 1 | 0.27% | weak | 4.00
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R29-061 — Single-record rows: app will not launch (1★); completion sound cannot be muted (1★); could not add more than one habit (3★); asks whether data is the hidden price (5★); believes a premium tier exists (5★); no account / no email praised (5★); per-habit streaks requested; stats export requested (4★); shared habits for accountability; in-app rewards (2★); emoji on habits; bad-habit / quit mode; cannot change app language (5★); back-dating habits; daily mood / wellbeing rating; font disliked (5★); public plea for support to respond (4★)

- **Where:** §3.1 Master table #39–#55 weak rows (1 each) — app will not launch (1★); completion sound cannot be muted (1★); could not add more than one habit (3★); asks whether data is the hidden price; believes a premium tier exists; no account / no email praised; per-habit streaks; stats export; shared habits; in-app rewards (2★); emoji on habits; bad-habit mode; cannot change app language; back-dating habits; daily mood rating; font disliked; public plea for support
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 17 single-record rows
- **Direction for us:** none · **Report confidence:** weak (anecdotes) · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R29-070 — Unmet needs ranked, with the cheapest satisfying change: Home Screen widget 16 (4.37%, mean 4.19 — a small/medium widget showing today's list; one wants a graph widget); dark mode 15 (4.10%, 4.67 — system-following); flexible frequency 14 (3.83%, 4.14 — x/week untethered from weekdays, every-other-n, monthly, multiple completions per day); more colours / customisation 4 (custom colours); quantity/unit tracking 4 (numeric targets: steps, litres, reps); end-date control 4 ('no end date' option, changeable later); stop reminding after completion 3 (cancel the day's remaining reminders on check-off); iCloud sync/backup/sign-in 3 (optional iCloud backup — trades against praise for no account); richer stats views 3 (all-time records; monthly/yearly grid); notes per habit 2; time ordering/timestamps 2 (sort the day by reminder time); one each: per-habit streaks, stats export, shared/social habits, in-app rewards, emoji icons, bad-habit mode, app language switch, back-dating, daily mood rating

- **Where:** §3.4 Unmet needs table (verbatim) — widget 16 (small/medium today's list; one wants a graph widget); dark mode 15 (system-following); flexible frequency 14; more colours 4 (custom colours); quantity/unit tracking 4 (steps, litres, reps); end-date control 4 ('no end date', change later); stop reminding after completion 3; iCloud sync/backup/sign-in 3 (trades against no-account praise); richer stats 3; notes per habit 2; time ordering 2; 1-each: per-habit streaks, stats export, shared habits, rewards, emoji, bad-habit mode, language switch, back-dating, mood rating
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Rank | Request | n | % | Signal | Mean ★ | Cheapest satisfying change ; 1 | Home Screen widget | 16 | 4.37% | very strong | 4.19 | Small/medium widget showing today's list; one reviewer specifically wants a graph widget (13764364876) ; 2 | Dark mode | 15 | 4.10% | very strong | 4.67 | System-following dark theme ; 3 | Flexible frequency | 14 | 3.83% | very strong | 4.14 | *x*/week untethered from weekdays; every-other-*n*; monthly; multiple completions per day ; 4 | More colours / customisation | 4 | 1.09% | meaningful | 4.75 | Wider palette; custom colours (12141452926) ; 5 | Quantity / unit tracking | 4 | 1.09% | meaningful | 4.50 | Numeric targets (steps, litres, reps) rather than done/not-done ; 6 | End-date control | 4 | 1.09% | meaningful | 4.00 | "No end date" option, and the ability to change it later ; 7 | Stop reminding after completion | 3 | 0.82% | emerging | 5.00 | Cancel the day's remaining reminders on check-off ; 8 | iCloud sync / backup / sign-in | 3 | 0.82% | emerging | 4.67 | Optional iCloud backup — note this trades against 13625278409's praise for no account ; 9 | Richer stats views | 3 | 0.82% | emerging | 4.00 | All-time records; monthly/yearly grid ; 10 | Notes per habit | 2 | 0.55% | emerging | 4.50 | Free-text note attached to a habit or a day ; 11 | Time ordering / timestamps | 2 | 0.55% | emerging | 5.00 | Sort the day's list by reminder time ; 12–19 | Per-habit streaks · stats export · shared/social habits · in-app rewards · emoji icons · bad-habit mode · app language switch · back-dating · daily mood rating | 1 each | 0.27% | weak | — | Recorded for completeness; see Part 10.3
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13764364876`, `12141452926`
- **Canonical:** — (nuance register)

### R29-072 — Calendar-bug counting rule: the reviewer reports the app displaying a wrong date, refusing to advance to the current day, reverting to an earlier month, misaligning weekday headers against dates, or blocking check-off for today because of any of these; requests for date-related features (end dates, monthly frequency, back-dating) and unrelated 'stuck'/'month' excluded — 18 regex candidates removed, 3 added by hand; final 37 (10.11%)

- **Where:** §4.1 Counting rules — calendar_bug counts wrong date, refusing to advance, reverting to an earlier month, misaligned weekday headers, or blocked check-off for today; date feature requests excluded; 18 removed, 3 added; final 37 (10.11%)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 37 of 366
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R29-077 — Per-band dominant drivers: 5★ 284 (77.6%) — zero cost (53.9% of band) and simplicity (37.0%); 4★ 41 (11.2%) — a specific missing feature (46.3%) or a bug (31.7%) against an otherwise-liked app; 3★ 16 (4.4%) — bugs, overwhelmingly (81.3%); 2★ 9 (2.5%) — bugs (66.7%), one pure missing-feature case; 1★ 16 (4.4%) — bugs (62.5%) and, in 2026, the privacy prompt (18.8%)

- **Where:** Part 5 ratings table (verbatim) — 5★ 77.6% (zero cost 53.9% of band, simplicity 37.0%); 4★ 11.2% (a missing feature 46.3% or a bug 31.7%); 3★ 4.4% (bugs 81.3%); 2★ 2.5% (bugs 66.7%, one pure missing feature); 1★ 4.4% (bugs 62.5%, and in 2026 the privacy prompt 18.8%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Rating | n | % of corpus | Dominant driver ; 5★ | 284 | 77.6% | Zero cost (53.9% of band) and simplicity (37.0%) ; 4★ | 41 | 11.2% | A specific missing feature (46.3%) or a bug (31.7%) against an otherwise-liked app ; 3★ | 16 | 4.4% | Bugs, overwhelmingly (81.3% of band) ; 2★ | 9 | 2.5% | Bugs (66.7%), one pure missing-feature case ; 1★ | 16 | 4.4% | Bugs (62.5%) and, in 2026, the privacy prompt (18.8%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R29-083 — Nobody in the corpus is identifiable as a payer — 0 of 366; a sweep for 'i paid', 'i bought', 'i purchased', 'i subscribed', 'my subscription', 'refund', 'restore purchase' and 'bought the' returns zero hits and the listing confirms no in-app purchases exist; this is not a gap in the data — it is the finding: the app has no observable revenue relationship with any of its 366 reviewers, and no conversion, ARPU or refund rate is computed or estimable

- **Where:** §6.1 Who is identifiable as a payer — nobody: 0 of 366 (sweep for paid/bought/purchased/subscribed/refund/restore returns zero); the listing confirms no IAP — this is not a gap in the data, it is the finding: no observable revenue relationship with any reviewer
- **This app does:** free, no IAP
- **User reaction:** none
- **Magnitude:** 0 of 366
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R29-087 — Counter-evidence stated with equal force: across the 62 reviews dated 1 May 2026 or later only 3 mention the prompt while 28 (45.2%) praise the absence of ads or subscriptions — including six posted in August and September 2026 and one in July — and post-May mean is 4.516 against 4.552; either the prompt is rolled out to a subset, or it is skippable and most skip it without comment, or it is geo-limited — the corpus cannot resolve it; what it does establish is that everyone who hit it rated 1★, two abandoned immediately, and as of September 2026 the public reputation is still 'actually free' — both conditions hold simultaneously, which is exactly the situation in which a disclosure decision is cheapest to make

- **Where:** §6.4 Counter-evidence with equal force — across 62 reviews from 1 May 2026 only 3 mention the prompt while 28 (45.2%) praise no ads / no subscription, including six in Aug–Sep 2026; post-May mean 4.516 vs 4.552; either a subset rollout, skippable, or geo-limited — the corpus cannot resolve it; both conditions hold simultaneously, which is exactly when a disclosure decision is cheapest
- **This app does:** partial rollout
- **User reaction:** mixed
- **Magnitude:** 3 of 62 vs 28 of 62 (45.2%); 4.516 vs 4.552
- **Direction for us:** research · **Report confidence:** interpretation · **Generalisable:** app-specific
- **Review IDs:** `14381720374`, `14403840586`, `14432719449`, `14437514738`, `14493599797`, `14497877998`, `14312607560`
- **Canonical:** C242 Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in

### R29-122 — Research questions: what fraction of users see the web-indexing prompt, whether declining degrades the app, whether it is geo-limited — the highest-value instrumentation question; whether the rating recovers after the prompt scales (post-May 4.516 is not yet informative at partial rollout); whether the India/US satisfaction gap is real or a review-length and recency artefact; whether a one-time unlock would convert (zero purchase evidence, untested); how many users hit the calendar bug and silently deleted the app, losing their history on the way out via the reinstall loop; whether prompt timing explains the 77.6% 5★ share

- **Where:** §9.3 Research questions Part 9 #1, Part 9 #2, Part 9 #3, Part 9 #4, Part 9 #5, Part 9 #6 — what fraction see the web-indexing prompt and what do they do (the highest-value instrumentation question); does the rating recover after it scales; is the India/US gap real or a length/recency artefact; would a one-time unlock convert; how many hit the calendar bug and silently deleted (losing history on the way out); does prompt timing explain the 77.6% 5★ share
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (questions)
- **Direction for us:** research · **Report confidence:** open questions · **Generalisable:** yes
- **Canonical:** — (nuance register)
