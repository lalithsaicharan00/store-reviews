# Cards — report 23

Source: `App Store Reports/23. Streaks - The habit-forming to-do list (REPORT).md`  
239 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 7
- [Must-haves](#must-haves) — 7
- [Must never break](#must-never-break) — 24
- [Features](#features) — 72
- [Monetization](#monetization) — 17
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 24
- [Audiences](#audiences) — 5
- [Markets and languages](#markets-and-languages) — 14
- [Dated events and trends](#dated-events-and-trends) — 15
- [Positioning](#positioning) — 6
- [Anti-patterns](#anti-patterns) — 3
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 14
- [Contradictions](#contradictions) — 4
- [Data caveats and method](#data-caveats-and-method) — 23

## Product rules

### R23-124 — Nobody in the 620 asks for the default to change — they ask for the ceiling to move; the request and the defence are compatible if extra capacity is an opt-in that leaves the default untouched

- **Where:** §4.1 Product implication — the request and the defence are compatible: move the ceiling, not the default
- **This app does:** cap is a hard default
- **User reaction:** mixed
- **Magnitude:** 620 ask vs 118 defend
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-156 — The reminder is framed as loss ('You will lose your streak of X days if you don't do this today'); reviewers in four languages ask for it to be reframed positively — one long German review calls it 'pedagogy from the early 20th century'; a cheap change with a clear rationale

- **Where:** §6.5 Reminder tone framed as loss — 'you will lose your streak of X days' — asked in four languages to reframe positively
- **This app does:** loss-framed reminder copy
- **User reaction:** complaint
- **Magnitude:** 4 reviews in 4 languages
- **Direction for us:** product-rule · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `7473616926`, `10648344883`, `11042287057`, `13098714560`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R23-201 — A hard cap on tracked habits is a durable, defensible product position — and a permanent 6–12% complaint tax; both halves are true; do not adopt a cap without a pressure valve

- **Where:** Part 10 #1 — a hard cap is a durable, defensible position and a permanent 6–12% complaint tax; do not adopt the cap without a pressure valve
- **This app does:** hard cap, no valve
- **User reaction:** mixed
- **Magnitude:** 6–12% complaint rate every year for twelve years
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-204 — Binary completion throws away the data users most want; ship a floor-without-ceiling goal model and a partial-progress calendar state

- **Where:** Part 10 #4 — binary completion throws away the data users most want; ship floor-without-ceiling and a partial-progress calendar state
- **This app does:** binary
- **User reaction:** complaint
- **Magnitude:** the two most-upvoted reviews in 7,270
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9145507788`, `8642992805`
- **Canonical:** C048 Flexible units / partial progress

### R23-205 — The Apple Watch is a purchase driver, not a feature: people buy for it and churn on it — if you ship a Watch app, its reliability budget is your main reliability budget

- **Where:** Part 10 #5 — the Apple Watch is a purchase driver, not a feature; its reliability budget is your main reliability budget
- **This app does:** Watch as purchase driver
- **User reaction:** churn
- **Magnitude:** ≥15 buy-for-Watch; 241 negative mentions
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R23-207 — Loss-framed notifications ('you will lose your streak') draw complaints in four languages — frame gains

- **Where:** Part 10 #7 — loss-framed notifications draw complaints in four languages; frame gains
- **This app does:** loss-framed copy
- **User reaction:** complaint
- **Magnitude:** 4 languages
- **Direction for us:** product-rule · **Report confidence:** limited evidence · **Generalisable:** yes
- **Canonical:** C095 Neutral, non-judgemental tone on failure

### R23-221 — P3: reframe reminder copy from loss to gain — one string change per locale

- **Where:** §11.3 P3 — reframe reminder copy from loss to gain; one string change per locale
- **This app does:** loss-framed
- **User reaction:** complaint
- **Magnitude:** 4 reviews
- **Direction for us:** product-rule · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `7473616926`, `10648344883`, `11042287057`, `13098714560`
- **Canonical:** C095 Neutral, non-judgemental tone on failure

## Must-haves

### R23-128 — The only undo is a shake gesture available immediately after the action; reviewers across 12 storefronts call this unacceptable, and several report the only workaround is resetting all history

- **Where:** §4.3 The undo problem — shake gesture only; workaround is resetting all history
- **This app does:** shake-to-undo only, time-limited
- **User reaction:** complaint
- **Magnitude:** 77 (1.06%, meaningful), 12 storefronts; mean 3.38
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1215117154`, `1303004020`, `3934671711`, `5528374045`, `5652418303`, `6499306517`, `7060772966`, `7273743439`, `8879991437`, `9212927813`, `9893956395`, `10535886439`, `10912008189`, `12894788718`, `13171890468`, `14245262334`, `14391501375`
- **Canonical:** C090 Destructive actions on widgets, quick surfaces and running routines need confirmation or undo; C223 Undo / un-complete is a visible button — never a gesture-only path

### R23-148 — An in-app backup/restore path (Settings > Manage Data > Backups) exists but is repeatedly discovered by support rather than the user; several reviewers upgrade their rating on learning it exists

- **Where:** §6.2 Mitigation exists and is under-surfaced — Settings > Manage Data > Backups discovered by support, not the user
- **This app does:** backup/restore exists, hidden
- **User reaction:** mixed
- **Magnitude:** 5 support-discovery reviews; 3 rating upgrades
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `8527464658`, `8553855848`, `10386986461`, `11764467723`, `12123846705`, `8123743895`
- **Canonical:** C142 Surface existing features where users look; C153 Automatic cloud backup on by default — never manual opt-in

### R23-209 — Undo must be a button — shake-to-undo produced 77 complaints, several of which end in deleting the app

- **Where:** Part 10 #9 — undo must be a button; shake-to-undo produced 77 complaints, several ending in deleting the app
- **This app does:** shake-only undo
- **User reaction:** churn
- **Magnitude:** 77 (1.06%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C223 Undo / un-complete is a visible button — never a gesture-only path

### R23-212 — R2: make automatic backups visible and recoverable from the first-run tutorial, not a support e-mail — converts a 1★ catastrophe into a 30-second recovery; several reviewers upgraded on learning the path existed

- **Where:** §11.1 R2 — make automatic backups visible and recoverable from the first-run tutorial, not from a support email
- **This app does:** backup hidden
- **User reaction:** mixed
- **Magnitude:** 4 reviews cited
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `8527464658`, `8553855848`, `10386986461`, `12123846705`
- **Canonical:** C142 Surface existing features where users look; C153 Automatic cloud backup on by default — never manual opt-in

### R23-216 — U1: add a visible Undo — keep shake-to-undo, add a button and a long-press-to-uncomplete path

- **Where:** §11.2 U1 — add a visible Undo: keep shake-to-undo, add a button and a long-press-to-uncomplete path
- **This app does:** shake only
- **User reaction:** complaint
- **Magnitude:** 77 reviews, mean 3.38, 12 storefronts
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C223 Undo / un-complete is a visible button — never a gesture-only path

### R23-217 — U2: add a discoverable Edit/Delete affordance on the task itself

- **Where:** §11.2 U2 — add a discoverable Edit/Delete affordance on the task itself
- **This app does:** hidden edit/delete
- **User reaction:** complaint
- **Magnitude:** 5 reviews cited within 250
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1428576781`, `3934184360`, `4219370308`, `9212927813`, `13176889519`
- **Canonical:** C142 Surface existing features where users look

### R23-218 — U3: replace the icon-only first run with a short text-labelled walkthrough covering add / complete / edit / delete / undo / pages — U1–U3 target the worst-rating-profile theme and require no change to the design language

- **Where:** §11.2 U3 — replace the icon-only first run with a short, text-labelled walkthrough covering add / complete / edit / delete / undo / pages
- **This app does:** icon-only tutorial
- **User reaction:** complaint
- **Magnitude:** 63 of 650 1★; 66-upvote review asks for exactly this
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `3225476511`, `10130810601`, `11129306077`, `13611667253`
- **Canonical:** C075 Skippable, replayable onboarding tour

## Must never break

### R23-067 — Sync — complaint-framed subset

- **Where:** §3.1 theme table #13 Sync — complaint-framed
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 223 (3.07%, very strong), mean 3.08, 1★ 23.3%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it

### R23-073 — Notifications broken / mistimed / annoying

- **Where:** §3.1 theme table #19 Notifications broken / mistimed / annoying
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 97 (1.33%, meaningful), mean 3.48, 1★ 18.6%, 5★ 38.1%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once

### R23-074 — Data loss

- **Where:** §3.1 theme table #20 Data loss
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 81 (1.11%, meaningful), mean 2.17, 1★ 45.7%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R23-082 — Widget — bug / regression subset

- **Where:** §3.1 theme table #28 Widget — bug / regression
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 57 (0.78%, emerging), mean 3.16, 1★ 12.3%, 5★ 17.5%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R23-087 — Watch — explicit bug wording subset

- **Where:** §3.1 theme table #33 Watch — explicit bug wording
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 49 (0.67%, emerging), mean 2.57, 1★ 36.7%, 5★ 20.4%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R23-089 — Crash / freeze / won't open

- **Where:** §3.1 theme table #35 Crash / freeze / won't open
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 46 (0.63%, emerging), mean 2.80, 1★ 34.8%, 5★ 26.1%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R23-096 — Tasks auto-completing without user action (11) and Health data not syncing/miscounting (9) — weak reliability signals around HealthKit automation

- **Where:** §3.1 #44 Auto-completing without user action; #45 Health data not syncing
- **This app does:** HealthKit auto-complete misfires
- **User reaction:** complaint
- **Magnitude:** 11 (0.15%, mean 3.00, 27.3% 1★); 9 (0.12%, mean 3.78)
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration

### R23-143 — Sync is the single largest reliability finding: complaint-framed sync runs at 1.42% of 2015–2017 reviews → ~3% 2018–2021 → 7.60% from Jan 2022 (135 of 1,776, mean 2.90); complaint volume by year 2015 (3) · 2016 (7) · 2017 (11) · 2018 (14) · 2019 (14) · 2020 (14) · 2021 (25) · 2022 (60) · 2023 (40) · 2024 (24) · 2025 (10) · 2026 (1); only 22 (0.30%) frame it as working well

- **Where:** §6.1 Sync — the single largest reliability finding; complaint volume by year
- **This app does:** iCloud sync; migrated to direct iCloud sync incl. Watch in Q1 2022
- **User reaction:** 1★-burst
- **Magnitude:** 348 (4.79%) mention; 223 (3.07%, very strong) complaint-framed, mean 3.08, 23.3% 1★; 22 (0.30%) positive; 1.42% → ~3% → 7.60%
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it; C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement

### R23-144 — Sync failure modes in reviewers' words: a device overwrites newer state with its own older state; deleted tasks resurrect and duplicates spawn; Watch completion never reaches the phone or reverts; a completion 'un-completes' seconds later; timers desync between devices

- **Where:** §6.1 Failure modes table (verbatim) — overwrite with older state, resurrecting deleted tasks, Watch completion never reaches phone, un-completes seconds later, timers desync
- **This app does:** last-writer-wins state replacement
- **User reaction:** complaint
- **Magnitude:** Failure mode | Evidence ; A device *overwrites* the newer state with its own older state | 8285279048, 9146983436, 9137837352, 9049751475, 10387927049, 11764467723, 12530776051, 13491181225 ; Deleted tasks resurrect; duplicates spawn | 8479907454, 8651289566, 8731274237, 8906562435, 9208912188, 9775440687, 10324021127, 10395558775, 11049048698, 12257280896 ; Watch completion never reaches phone (or reverts) | 8798302019, 8846625627, 9298414949, 10629577342, 11917241363, 12008652692, 12630378882, 12360238604 ; Completion "un-completes" seconds later | 10815885619, 10848160093, 11289290761, 13433485005 ; Timers desync between devices | 7353753973, 7461351458, 10258730446, 11753082193
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8285279048`, `9146983436`, `9137837352`, `9049751475`, `10387927049`, `11764467723`, `12530776051`, `13491181225`, `8479907454`, `8651289566`, `8731274237`, `8906562435`, `9208912188`, `9775440687`, `10324021127`, `10395558775`, `11049048698`, `12257280896`, `8798302019`, `8846625627`, `9298414949`, `10629577342`, `11917241363`, `12008652692`, `12630378882`, `12360238604`, `10815885619`, `10848160093`, `11289290761`, `13433485005`, `7353753973`, `7461351458`, `10258730446`, `11753082193`
- **Canonical:** C030 Sync must work — and prove it; C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement

### R23-147 — Data loss destroys customers with 3–8 years of history ('Loved for Years! But… today half of my tasks disappeared'; 'my 3+ years record to null'; 'It's like I'm a brand new user'; one jp reviewer edited three annual updates into the same review reporting the same unfixed bug); by year 2015 (2) · 2016 (1) · 2017 (2) · 2018 (2) · 2019 (1) · 2020 (7) · 2021 (6) · 2022 (17) · 2023 (10) · 2024 (22) · 2025 (8) · 2026 (3)

- **Where:** §6.2 Data loss — the theme that destroys long-tenure customers; by year
- **This app does:** history lost after sync/update
- **User reaction:** churn
- **Magnitude:** 81 (1.11%, meaningful), mean 2.17, 45.7% 1★; since Jan 2022 60 of 1,776 = 3.38%, mean 2.03; 2024 peak 22
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11174051475`, `11194503416`, `12257280896`, `9919429252`, `10325632518`, `8646756790`, `13219722364`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R23-150 — Explicit 'I bought this for the Watch and it doesn't work' reviews are the highest-value churn events in the corpus — the purchase intent and the failure are the same feature

- **Where:** §6.3 The Watch is also the reason people bought — 'I bought this for the Watch and it doesn't work' are the highest-value churn events
- **This app does:** Watch sold as differentiator, fails
- **User reaction:** churn
- **Magnitude:** 11 explicit reviews; ≥15 name the Watch as the reason to buy
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `4436945996`, `4727429074`, `5132838929`, `5982716099`, `6194996941`, `7629771235`, `8378091564`, `8004581061`, `11991690974`, `12444581527`, `13857668076`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C065 Paying customers are the highest 1★ risk — every paid feature must work; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R23-153 — Separately from the regression, widgets render blank or lose their configuration

- **Where:** §6.4 Widgets rendering blank or losing configuration
- **This app does:** widget blank/loses config
- **User reaction:** complaint
- **Magnitude:** explicit widget-bug theme 57 (0.78%, emerging), mean 3.16; 20 blank/config reviews cited
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `9387245377`, `9455902784`, `9641838960`, `9649773036`, `9792360211`, `10070473577`, `10100299749`, `10228970452`, `10841143428`, `10893470805`, `10911821923`, `11027982834`, `11192838845`, `11736228113`, `11849294138`, `12159511186`, `12415259889`, `13684634678`, `13156243989`, `12367233200`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R23-154 — Notifications don't fire; Thailand is a visible cluster at 4 of 22 Thai reviews (18.2%), the highest rate of any storefront (limited evidence, n=22)

- **Where:** §6.5 Notifications don't fire — Thailand cluster 4 of 22 (18.2%) [limited evidence]
- **This app does:** reminders silently fail
- **User reaction:** complaint
- **Magnitude:** 97 (1.33%, meaningful), mean 3.48, 18.6% 1★ (whole theme); Thailand 4/22 = 18.2%
- **Direction for us:** must-never-break · **Report confidence:** meaningful; Thailand limited evidence · **Generalisable:** yes
- **Review IDs:** `1509948676`, `3143064934`, `4150625737`, `4868602988`, `5254725068`, `5453539364`, `5918724806`, `5968862073`, `6036356305`, `6486871534`, `7397407229`, `11583805884`, `11836157878`, `12715249124`, `13747526653`, `3630312469`, `5608136878`, `5150089330`, `6825459841`, `7151647360`
- **Canonical:** C039 Reminders fire reliably, once

### R23-155 — Notifications fire wrongly: reminders for already-completed tasks, all firing at once at night, ignoring Do Not Disturb, and interrupting a meditation to tell you to meditate

- **Where:** §6.5 Notifications fire wrongly — reminding about completed tasks, all at once at night, ignoring Do Not Disturb, interrupting a meditation to say meditate
- **This app does:** smart reminders misfire
- **User reaction:** complaint
- **Magnitude:** within 97 (1.33%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `5902840519`, `3413523915`, `6107839995`, `8934368362`, `12696000566`, `12697390401`, `13060174375`, `1362498037`, `1452654162`, `1563725433`, `3658903640`, `13175015249`
- **Canonical:** C039 Reminders fire reliably, once

### R23-157 — Crashes cluster on three dated bugs — iPhone X freeze-on-close 2017–18, an iOS 14-era freeze, and a stuck-splash-screen bug 2023–26 — plus two device-heat and one CPU/battery report

- **Where:** §6.6 Crash / freeze — iPhone X freeze-on-close 2017–18, iOS 14-era freeze, stuck splash screen 2023–26; device heat
- **This app does:** dated crash bugs
- **User reaction:** complaint
- **Magnitude:** 46 (0.63%, emerging), mean 2.80, 34.8% 1★; heat 2, battery 1
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `2101542261`, `2111079436`, `2668847666`, `2378622100`, `6473643467`, `6478212597`, `6515761598`, `6695773000`, `10097034521`, `11103745511`, `11208612733`, `12303464340`, `12376090252`, `14346355348`, `7768856624`, `11902630521`, `13710105898`
- **Canonical:** C031 Crashes / launch failures

### R23-158 — Pausing a task and un-pausing it marks the paused days as missed and destroys the streak — defeating the feature's entire purpose; reported across 2023–2024 with no visible fix in later reviews

- **Where:** §6.7 Pause resets the streak — paused days marked as missed; reported 2023–2024 with no visible fix
- **This app does:** pause/vacation mode breaks the streak it exists to protect
- **User reaction:** complaint
- **Magnitude:** 57 (0.78%) mention archive/pause; 5 named defect reviews
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10656649260`, `10772984090`, `10709012497`, `11138802961`, `11219449203`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R23-171 — A small cluster says the price shown and the amount debited differed (au, ru, tr, mx) — most likely tax/VAT or currency conversion, not developer behaviour, but a recurring, avoidable trust event

- **Where:** §7.5 Charge-amount confusion — price shown vs amount debited differed (au, ru, tr, mx) [weak, n=7]
- **This app does:** displayed price ≠ charged amount in some storefronts
- **User reaction:** complaint
- **Magnitude:** 7 (0.10%, weak)
- **Direction for us:** must-never-break · **Report confidence:** weak (n=7) · **Generalisable:** yes
- **Review IDs:** `1821681612`, `2863100772`, `3565187204`, `4550475560`, `5452308394`, `12692528270`, `14197653464`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R23-177 — A genuine, fixable localisation defect specific to Korean: the task-title field mangles Hangul (typing 약 stores 야ㄱ; 랑 stores 라ㅇ) — an IME composition bug reported four separate times over five years, apparently never fixed, producing 1★–4★ reviews from otherwise-satisfied users

- **Where:** §8.4 Korean IME composition bug — task-title field mangles Hangul (약 → 야ㄱ); reported four times over five years, never fixed
- **This app does:** Hangul IME composition broken in text field
- **User reaction:** complaint
- **Magnitude:** 4 reports 2020-02 → 2020-10 (and later)
- **Direction for us:** must-never-break · **Report confidence:** limited evidence (n=4) · **Generalisable:** yes
- **Review IDs:** `5541895076`, `5747933646`, `5998909121`, `6586522274`
- **Canonical:** C027 Localise early — it unlocks revenue; C228 Text fields must handle IME composition — Hangul and CJK input

### R23-190 — A macOS-specific bug report says Streaks created millions of files in /private/var/folders and locked the reviewer out of their Mac — the most severe single technical claim in the corpus; unverified, n=1, recorded because a desktop app rendering a machine unusable clears the safety exception to the ignore threshold

- **Where:** §8.10 Denmark — macOS bug: Streaks creating millions of files in /private/var/folders, locking the reviewer out of their Mac (unverified, n=1, safety-class severity)
- **This app does:** Mac app runaway file creation
- **User reaction:** complaint
- **Magnitude:** 1 review (dk)
- **Direction for us:** must-never-break · **Report confidence:** single review, unverified, safety-class · **Generalisable:** yes
- **Review IDs:** `8567779004`
- **Canonical:** C044 Mac / desktop / web app

### R23-208 — Never let sync be last-writer-wins — a customer review spells out the correct architecture (append-only timestamped events, merged)

- **Where:** Part 10 #8 — never let sync be last-writer-wins
- **This app does:** last-writer-wins
- **User reaction:** complaint
- **Magnitude:** 223 sync complaints
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10815885619`
- **Canonical:** C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement

### R23-211 — R1: replace last-writer-wins iCloud sync with an append-only, timestamped event log — merge, never overwrite; addresses the largest post-2021 rating driver and its downstream data-loss theme

- **Where:** §11.1 R1 — replace last-writer-wins iCloud sync with an append-only, timestamped event log; merge, never overwrite
- **This app does:** last-writer-wins
- **User reaction:** complaint
- **Magnitude:** 223 reviews, mean 3.08; 7.60% of post-2022
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10815885619`, `13491181225`, `9146983436`, `11764467723`
- **Canonical:** C030 Sync must work — and prove it; C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement

### R23-213 — R3: fix the Watch completion round-trip and complication refresh and publish a Watch-first test matrix — protects the purchase driver in kr/jp and the highest-value churn segment

- **Where:** §11.1 R3 — fix the Watch completion round-trip and complication refresh; publish a Watch-first test matrix
- **This app does:** Watch round-trip broken
- **User reaction:** churn
- **Magnitude:** 241 negative, mean 3.13; 49 explicit bugs, mean 2.57
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12008652692`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R23-214 — R4: fix pause/archive so paused days are neutral, not missed — small, self-contained, currently defeats the feature entirely

- **Where:** §11.1 R4 — fix pause/archive so paused days are neutral, not missed
- **This app does:** pause marks missed
- **User reaction:** complaint
- **Magnitude:** 4 reviews cited
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10656649260`, `10772984090`, `11138802961`, `11219449203`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R23-215 — R5: fix the Korean Hangul composition bug — trivially cheap, five years unaddressed, hits the storefront with the worst refund rate

- **Where:** §11.1 R5 — fix the Korean Hangul composition bug in the task-title field
- **This app does:** IME bug
- **User reaction:** complaint
- **Magnitude:** 4 reports
- **Direction for us:** must-never-break · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `5541895076`, `5747933646`, `5998909121`, `6586522274`
- **Canonical:** C228 Text fields must handle IME composition — Hangul and CJK input

## Features

### R23-003 — Task capacity (more tasks/pages/screens) is the single largest product request over twelve years; the developer raised the cap 6 → 12 (Jul 2017) → 24 (Jul 2021) and the request simply re-anchored on the new number — it was the top request in every large market and every year

- **Where:** Executive summary #1 — capacity is the largest request in twelve years and raising the cap twice did not settle it
- **This app does:** hard cap on habit count: 6, then 12, then 24 — raised twice, never made optional
- **User reaction:** complaint
- **Magnitude:** 620 reviews (8.53%, high-priority) ask for more; 74 in 2015, 118 in 2016, 60 in 2021, 27 in 2024; 118 (1.62%) defend the limit
- **Direction for us:** undecided · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** the cap is a design constraint, not a paywall — everyone has paid
- **Review IDs:** `1210218319`, `1435204171`, `2118562647`, `3652626817`, `5996825854`, `6094260232`, `9405934613`, `12880039039`, `13458083376`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-007 — Apple Watch is the app's strongest differentiator and its most fragile surface — 38.5% of Watch mentions are negative and Watch sync/complication failure is the most commonly cited reason a five-year user leaves; in Japan and Korea the Watch is the dominant topic

- **Where:** Executive summary #4 — Apple Watch is the strongest differentiator and most fragile surface
- **This app does:** Apple Watch app with complications, included in the one-time price; sync/complication failures
- **User reaction:** mixed
- **Magnitude:** 626 reviews (8.61%, high-priority) mention the Watch; 241 (38.5%) negative, mean 3.13 vs 4.35 for the rest; Japan 13.3% of storefront, Korea 13.5%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `1352113408`, `3355577958`, `4640524404`, `7946379003`, `8798302019`, `10510343633`, `10741780773`, `11748040853`, `12008652692`, `13235319229`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R23-010 — A specific unbuilt feature is asked for in seven languages: record over-achievement or partial progress — the binary complete/incomplete model is named as demotivating and as the reason people keep a second app

- **Where:** Executive summary #7 — record effort beyond the goal, asked in seven languages
- **This app does:** absent — binary completion only; 'I read 90 minutes, my goal was 30, and it stops counting'; '4 of 8 glasses shows an ✗'
- **User reaction:** complaint
- **Magnitude:** 77 reviews (1.06%, meaningful)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1230386714`, `9145507788`, `9592238918`, `11936906855`, `12209604326`, `13566507177`, `11968580277`, `14106848070`
- **Canonical:** C048 Flexible units / partial progress; C201 A user-set partial-completion threshold — a 'good day' below 100%

### R23-019 — The second most-endorsed review in the corpus asks to connect consecutive completed days visually on the calendar

- **Where:** §1.6 community-endorsed — connect consecutive completed days visually (231 votes)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 231 net votes, cn, 5★, 2018-11-02
- **Direction for us:** undecided · **Report confidence:** single review, community-endorsed · **Generalisable:** yes
- **Review IDs:** `3372029447`
- **Canonical:** C012 Week / month / year grid views

### R23-020 — Community-endorsed requests: a habit with a floor but no ceiling (126 votes) and longer cycles — fortnightly, monthly, bimonthly (80 votes)

- **Where:** §1.6 community-endorsed — a habit with a floor but no ceiling (126 votes); longer cycles (80 votes)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 126 and 80 net votes, cn, 5★
- **Direction for us:** undecided · **Report confidence:** community-endorsed single reviews · **Generalisable:** yes
- **Review IDs:** `8642992805`, `2056232018`
- **Canonical:** C043 Flexible / custom frequency; C048 Flexible units / partial progress

### R23-021 — Community-endorsed: plain-language in-app instructions (66 votes, us, 3★) and a request to fix machine-translated Chinese help text (52 votes, cn, 4★)

- **Where:** §1.6 community-endorsed — plain-language in-app instructions (66 votes); machine-translated Chinese help text (52 votes)
- **This app does:** help text machine-translated in Chinese; no plain-language instructions
- **User reaction:** complaint
- **Magnitude:** 66 and 52 net votes
- **Direction for us:** must-have · **Report confidence:** community-endorsed single reviews · **Generalisable:** yes
- **Review IDs:** `3225476511`, `1933748530`
- **Canonical:** C027 Localise early — it unlocks revenue; C075 Skippable, replayable onboarding tour

### R23-023 — The product is up to N press-and-hold task circles arranged in colour-themed pages of 6 — N went 6 (2015–Jul 2017) → 12 (Jul 2017–Jul 2021) → 24 (Jul 2021–); pages went 1 → 2 → 4

- **Where:** §2.1 Up to N habit tasks as press-and-hold circles; pages/boards of 6
- **This app does:** hard cap on task count, raised twice; pages of 6
- **User reaction:** mixed
- **Magnitude:** cap 6 → 12 → 24; pages 1 → 2 → 4
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** app-specific
- **Review IDs:** `1207369743`, `14519191137`, `1702122919`, `7693289034`, `8299170626`
- **Canonical:** C045 Grouping / folders / categories / tags; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-024 — Completion is a deliberate press-and-hold with haptic and sound, not a tap — praised as physically satisfying and as a guard against accidental taps, and criticised by some

- **Where:** §2.1 Press-and-hold to complete (haptic + sound); §3.3 #2
- **This app does:** press-and-hold completion, included
- **User reaction:** mixed
- **Magnitude:** attested inside themes 1 and 3 (no separate count)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1233132153`, `1565085180`, `1787711554`, `1762948125`, `8699216106`, `11414032824`
- **Canonical:** C229 A deliberate completion gesture — press-and-hold with haptic and sound, not a bare tap

### R23-025 — Retroactive completion ('today or yesterday?', toggleable) and a calendar view with retroactive edit of history (added ~Mar 2016) — both included

- **Where:** §2.1 'Today or yesterday?' retroactive completion; calendar view + retroactive edit of history
- **This app does:** backfill via prompt and calendar, included
- **User reaction:** praise
- **Magnitude:** inventory rows; backfill theme 76 (1.05%)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1219787545`, `1276619599`, `11525453355`, `1341315616`, `1342117011`
- **Canonical:** C010 Backfill missed days / edit start date

### R23-026 — Per-task custom reminder times plus 'smart' auto reminders whose timing algorithm is widely disliked

- **Where:** §2.1 Per-task custom reminder times; 'smart' auto reminders — timing algorithm widely disliked
- **This app does:** custom + algorithmic reminders, included; algorithm disliked
- **User reaction:** complaint
- **Magnitude:** inventory row; see Part 6.5
- **Direction for us:** product-rule · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1276150206`, `1535900378`, `13111371180`
- **Canonical:** C039 Reminders fire reliably, once

### R23-027 — An app-badge count of outstanding tasks, with an active-hours window, is named by many as the core motivator

- **Where:** §2.1 App badge count of outstanding tasks with active-hours window — named as the core motivator
- **This app does:** badge count with active hours, included
- **User reaction:** praise
- **Magnitude:** inventory row
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1276454729`, `5393033193`
- **Canonical:** C226 App-icon badge count of outstanding habits, with an active-hours window

### R23-028 — HealthKit read (steps, flights, weight, sleep, mindful minutes, workouts, water, calories) auto-completes tasks — named repeatedly as the thing that removes the friction that killed every other habit app they tried

- **Where:** §2.1 Apple HealthKit read auto-completes tasks; §3.3 #4
- **This app does:** HealthKit auto-completion, included
- **User reaction:** praise
- **Magnitude:** 277 (3.81%, very strong), mean 4.35
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1212736010`, `1457370530`, `9466989950`, `1458766203`, `2423668555`, `3927825569`, `12539768742`
- **Canonical:** C021 Apple Health integration

### R23-029 — An Apple Watch app with complications has existed since watchOS 2 (2015), included in the price

- **Where:** §2.1 Apple Watch app + complications since watchOS 2 (2015)
- **This app does:** Watch app + complications, included
- **User reaction:** mixed
- **Magnitude:** 626 mentions (8.61%)
- **Direction for us:** build-paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1223650339`, `1261995475`, `13857668076`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R23-030 — The interactive Today-view widget (Jan 2017) was removed ~Sept 2020 and replaced by non-interactive Home/Lock-screen widgets (iOS 14+)

- **Where:** §2.1 Today-view widget (interactive) — removed ~Sept 2020; Home/Lock-screen widgets (non-interactive)
- **This app does:** interactive widget removed; non-interactive replacement
- **User reaction:** complaint
- **Magnitude:** inventory rows; widget theme 318 (4.37%)
- **Direction for us:** must-never-break · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1530309387`, `6442941072`, `12159511186`
- **Canonical:** C023 Interactive widget check-off; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R23-031 — Negative ('don't') tasks were added in v3.0, Jul 2017

- **Where:** §2.1 Negative ('don't') tasks — added v3.0, Jul 2017
- **This app does:** quit-habit mode, included
- **User reaction:** praise
- **Magnitude:** inventory row
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1698660564`, `1727430072`, `4088195832`
- **Canonical:** C019 Quit-habit / bad-habit mode

### R23-032 — Times-per-day, per-week and per-month scheduling exist; yearly is still absent

- **Where:** §2.1 Times-per-day / per-week / per-month scheduling — yearly still absent
- **This app does:** flexible frequency, partial
- **User reaction:** mixed
- **Magnitude:** inventory row; see Part 4.5
- **Direction for us:** must-have · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1295254379`, `2641215473`, `9405395737`
- **Canonical:** C043 Flexible / custom frequency

### R23-033 — Timed tasks and a built-in Pomodoro exist; the Pomodoro break cycle was reported broken in 2022

- **Where:** §2.1 Timed tasks + built-in Pomodoro — break cycle reported broken 2022
- **This app does:** timers included; Pomodoro break broken 2022
- **User reaction:** complaint
- **Magnitude:** inventory row
- **Direction for us:** must-never-break · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `3225476511`, `6332134320`, `8631830521`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C066 Focus timer

### R23-034 — Statistics (streak, best, 7-day, 30-day, all-time, graphs) exist; history depth is complained of

- **Where:** §2.1 Statistics: streak, best, 7-day, 30-day, all-time, graphs — history depth complained of
- **This app does:** stats included; shallow history
- **User reaction:** mixed
- **Magnitude:** inventory row; stats depth theme 46 (0.63%)
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1698329281`, `3627186417`, `9594705817`
- **Canonical:** C012 Week / month / year grid views

### R23-035 — CSV export exists and is included

- **Where:** §2.1 CSV export
- **This app does:** export included
- **User reaction:** praise
- **Magnitude:** inventory row
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1268393434`, `1313240975`, `8790139019`
- **Canonical:** C020 Data export / backup / CSV

### R23-036 — iCloud sync across iPhone, iPad, Watch and Mac has existed since Sept 2018; the Mac app was a separate purchase in some periods

- **Where:** §2.1 iCloud sync across iPhone / iPad / Watch / Mac (Sept 2018 →)
- **This app does:** sync included; Mac separately sold at times
- **User reaction:** mixed
- **Magnitude:** inventory row; sync theme 348 (4.79%)
- **Direction for us:** must-never-break · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `3240963794`, `13491181225`
- **Canonical:** C030 Sync must work — and prove it; C044 Mac / desktop / web app

### R23-037 — Siri Shortcuts, URL actions and NFC triggers exist and are a power-user favourite

- **Where:** §2.1 Siri Shortcuts / URL actions / NFC — power-user favourite
- **This app does:** automation included
- **User reaction:** praise
- **Magnitude:** theme 26: 72 (0.99%, emerging), mean 3.94
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1345417377`, `3206247831`, `9827682106`
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R23-038 — Custom app icons and theme colours are included and frequently cited as a delight — a small feature with an outsized response

- **Where:** §2.1 Custom app icon + theme colours — distinctive, cited as a delight; §3.3 #6
- **This app does:** customisation included
- **User reaction:** praise
- **Magnitude:** 324 (4.46%, very strong), mean 4.51
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1704396672`, `1841745643`, `12480462420`, `1819984390`, `3797909975`
- **Canonical:** C009 Basic widgets, icons and colours are free; C018 App-icon themes

### R23-039 — Archive/pause exists but a pause-resets-the-streak bug is reported

- **Where:** §2.1 Archive / pause tasks — pause-breaks-streak bug
- **This app does:** pause included, buggy
- **User reaction:** complaint
- **Magnitude:** theme 29: 57 (0.78%, emerging), mean 3.89
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `6565948711`, `8266328218`, `12490481767`, `10656649260`, `10772984090`, `11138802961`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R23-040 — Per-completion notes shipped ~Mar 2023 after being long requested; a later review asks for note navigation

- **Where:** §2.1 Per-completion notes — shipped ~Mar 2023 after long request
- **This app does:** notes shipped 2023
- **User reaction:** praise
- **Magnitude:** theme 37: 43 (0.59%, emerging), mean 4.00
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `9681201325`, `13439093120`
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R23-041 — Task sharing / accountability partner exists but is described as weak and one-way

- **Where:** §2.1 Task sharing / accountability partner — weak / one-way
- **This app does:** sharing included, weak
- **User reaction:** complaint
- **Magnitude:** theme 38: 28 (0.39%, weak), mean 4.07
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `9210832228`, `11023193240`, `10201893958`, `14513963633`
- **Canonical:** C015 Shared / group habits

### R23-044 — 'Break It Down' AI step generation (May 2026) is mentioned once — and the reviewer asks for it to be removed

- **Where:** §2.1 'Break It Down' AI step generation — only mention asks for it to be removed
- **This app does:** AI feature added 2026
- **User reaction:** complaint
- **Magnitude:** 1 review
- **Direction for us:** dont · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `14069398191`
- **Canonical:** C056 Don't build AI features on demand grounds

### R23-045 — A medication tracker (Sep 2025) is mentioned once

- **Where:** §2.1 Medication tracker — single mention
- **This app does:** medication tracker added 2025
- **User reaction:** none
- **Magnitude:** 1 review
- **Direction for us:** research · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `13180845529`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R23-056 — Design / beauty praised

- **Where:** §3.1 theme table #2 Design / beauty praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 945 (13.00%, high-priority), mean 4.38, 1★ 4.2%, 5★ 68.1%
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C134 Lead the store listing with what users actually love

### R23-059 — Apple Watch mentioned (all framings)

- **Where:** §3.1 theme table #5 Apple Watch mentioned
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 626 (8.61%, high-priority), mean 3.88, 1★ 12.1%, 5★ 52.7%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R23-060 — Capacity — asks for more tasks/pages

- **Where:** §3.1 theme table #6 Capacity: asks for more tasks/pages
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 620 (8.53%, high-priority), mean 3.96, 1★ 6.9%, 5★ 40.3%
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-062 — Sync mentioned (all framings)

- **Where:** §3.1 theme table #8 Sync mentioned
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 348 (4.79%, very strong), mean 3.51, 1★ 16.1%, 5★ 37.9%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it

### R23-063 — Customisation praised

- **Where:** §3.1 theme table #9 Customisation (icons, colours, app icon) praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 324 (4.46%, very strong), mean 4.51, 1★ 1.9%, 5★ 69.8%
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free

### R23-064 — Widget mentioned (all framings)

- **Where:** §3.1 theme table #10 Widget mentioned
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 318 (4.37%, very strong), mean 3.84, 1★ 8.2%, 5★ 42.1%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app

### R23-065 — Apple Health integration praised

- **Where:** §3.1 theme table #11 Apple Health integration praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 277 (3.81%, very strong), mean 4.35, 1★ 5.4%, 5★ 66.8%
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration

### R23-068 — Rewards / badges / gamification requested — by happy users

- **Where:** §3.1 theme table #14 Rewards / badges / gamification requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 136 (1.87%, meaningful), mean 4.43, 1★ 1.5%, 5★ 61.8%
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C024 Streaks / gamification; C101 Milestones, achievements, celebration

### R23-071 — Multiple-times-per-day / partial increments (largely shipped 2016; residual is partial-progress display)

- **Where:** §3.1 theme table #17 Multiple-times-per-day / partial increments
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 111 (1.53%, meaningful), mean 3.90, 1★ 2.7%, 5★ 37.8%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N

### R23-072 — Frequency flexibility (weekly/monthly/yearly/every-N)

- **Where:** §3.1 theme table #18 Frequency flexibility (weekly/monthly/yearly/every-N)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 101 (1.39%, meaningful), mean 4.06, 1★ 5.0%, 5★ 45.5%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency

### R23-076 — Undo / unmark impossible

- **Where:** §3.1 theme table #22 Undo / unmark impossible
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 77 (1.06%, meaningful), mean 3.38, 1★ 14.3%, 5★ 32.5%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C223 Undo / un-complete is a visible button — never a gesture-only path

### R23-077 — Record beyond goal / partial progress

- **Where:** §3.1 theme table #23 Record beyond goal / partial progress
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 77 (1.06%, meaningful), mean 4.00, 1★ 3.9%, 5★ 39.0%
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C048 Flexible units / partial progress

### R23-078 — Backfill older days

- **Where:** §3.1 theme table #24 Backfill older days
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 76 (1.05%, meaningful), mean 3.75, 1★ 9.2%, 5★ 40.8%
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C010 Backfill missed days / edit start date

### R23-080 — Siri / Shortcuts / automation

- **Where:** §3.1 theme table #26 Siri / Shortcuts / automation
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 72 (0.99%, emerging), mean 3.94, 1★ 9.7%, 5★ 55.6%
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R23-083 — Archive / pause / vacation mode

- **Where:** §3.1 theme table #29 Archive / pause / vacation mode
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 57 (0.78%, emerging), mean 3.89, 1★ 5.3%, 5★ 42.1%
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R23-084 — Day-boundary / midnight reset (a configurable day boundary)

- **Where:** §3.1 theme table #30 Day-boundary / midnight reset
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 54 (0.74%, emerging), mean 4.02, 1★ 3.7%, 5★ 44.4%
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C170 Configurable day boundary and hemisphere seasons

### R23-085 — More / custom icons requested

- **Where:** §3.1 theme table #31 More / custom icons
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 54 (0.74%, emerging), mean 4.20, 1★ 1.9%, 5★ 53.7%
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free

### R23-088 — Statistics depth / year view requested

- **Where:** §3.1 theme table #34 Statistics depth / year view
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 46 (0.63%, emerging), mean 3.93, 1★ 6.5%, 5★ 50.0%
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views

### R23-090 — List view / more per page / smaller icons (density control)

- **Where:** §3.1 theme table #36 List view / more per page / smaller icons
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 45 (0.62%, emerging), mean 3.56, 1★ 8.9%, 5★ 24.4%
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R23-091 — Notes / journal per completion

- **Where:** §3.1 theme table #37 Notes / journal per completion
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 43 (0.59%, emerging), mean 4.00, 1★ 11.6%, 5★ 51.2%
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R23-095 — Accessibility/VoiceOver (19) and iPad layout (8) are weak themes

- **Where:** §3.1 #40 Accessibility / VoiceOver; #46 iPad layout not optimised
- **This app does:** VoiceOver gaps; iPad layout not optimised
- **User reaction:** complaint
- **Magnitude:** 19 (0.26%, mean 3.79); 8 (0.11%, mean 4.25)
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C141 Native iPad layout; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R23-102 — The Watch complication, when it works, is a top-rated strength — the positive subset is large and highly rated

- **Where:** §3.3 #5 Apple Watch complication when it works — positive subset
- **This app does:** Watch complication
- **User reaction:** praise
- **Magnitude:** positive subset 385 reviews, mean 4.35
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1264562226`, `1536186077`, `3546399508`, `9673544391`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R23-103 — The gold-theme completion state (all tasks done turns the screen gold) is named specifically by 5★ reviewers — a delight moment

- **Where:** §3.3 #7 The gold-theme completion state
- **This app does:** gold completion state
- **User reaction:** praise
- **Magnitude:** 80 5★ reviews (1.7% of 5★)
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1457647167`, `1566830363`, `5578733348`, `7894034801`, `11813889503`
- **Canonical:** C101 Milestones, achievements, celebration

### R23-106 — Rewards, badges, milestones and levels are requested — by satisfied users (mean 4.43)

- **Where:** §3.4 Rewards, badges, milestones, levels requested
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 136 (1.87%, meaningful), mean 4.43
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1210125866`, `1509518865`, `1523739770`, `3720818929`, `4001139449`, `8657817540`, `9466333042`
- **Canonical:** C024 Streaks / gamification; C101 Milestones, achievements, celebration

### R23-107 — Multiple-per-day / partial increments was largely shipped in 2016; residual complaints are about how partial progress is displayed

- **Where:** §3.4 Multiple-per-day / partial increments — largely shipped 2016; residual is partial-progress display
- **This app does:** shipped 2016; partial display remains
- **User reaction:** complaint
- **Magnitude:** 111 (1.53%, meaningful)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1265283854`, `1298183337`, `1389005299`, `1949109997`, `5852474728`
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N

### R23-108 — Frequency flexibility requested: yearly, every-N-weeks, specific dates

- **Where:** §3.4 Frequency flexibility — yearly, every-N-weeks, specific dates
- **This app does:** absent for yearly / every-N-weeks / specific dates
- **User reaction:** complaint
- **Magnitude:** 101 (1.39%, meaningful)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1397447028`, `2056232018`, `3596141272`, `9405395737`, `10397702118`, `11315859157`, `12537226420`, `14320549167`
- **Canonical:** C043 Flexible / custom frequency

### R23-109 — Notes per completion were requested from 2015 and shipped ~2023; the residual request is navigation between notes

- **Where:** §3.4 Notes / journal per completion — shipped ~2023; note navigation requested
- **This app does:** shipped ~2023
- **User reaction:** praise
- **Magnitude:** 43 (0.59%, emerging)
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1233211017`, `3524837176`, `5856256123`, `8267273982`, `9721628471`, `13439093120`
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R23-110 — A list view or density control (more per page, smaller icons) is requested

- **Where:** §3.4 List view / density control
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 45 (0.62%, emerging)
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1277986745`, `4179487203`, `8299170626`, `10475031837`, `11548743644`, `13528143060`, `14156553445`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R23-111 — Longer history and a year heat-map view are requested

- **Where:** §3.4 Longer history / year heat-map
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 46 (0.63%, emerging)
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1384736153`, `3911574614`, `9579170708`, `10796378002`, `13611043861`, `13647744905`, `13991866349`
- **Canonical:** C012 Week / month / year grid views

### R23-112 — A social / accountability-partner layer is requested (existing sharing is weak)

- **Where:** §3.4 Social / accountability partner
- **This app does:** weak sharing exists
- **User reaction:** complaint
- **Magnitude:** 28 (0.39%, weak)
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `1210438949`, `3634054860`, `6893100721`, `8009347972`, `9210832228`, `14513963633`
- **Canonical:** C015 Shared / group habits

### R23-113 — An end-date, countdown or long-term goal is requested by very happy users

- **Where:** §3.4 End-date / countdown / long-term goal
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 17 (0.23%, weak), mean 4.76, 0% 1★
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `2190673897`, `3219243457`, `5234693852`, `7442733954`, `11136317227`
- **Canonical:** C099 Countdown / 'days until' mode

### R23-118 — Extra capacity is wanted for time-of-day segmentation: morning / work / evening / bedtime routines, one page each

- **Where:** §4.1 What people want the extra slots for #1 — time-of-day segmentation
- **This app does:** pages exist but capped
- **User reaction:** complaint
- **Magnitude:** 9 representative reviews
- **Direction for us:** undecided · **Report confidence:** high-priority (sub-reason) · **Generalisable:** yes
- **Review IDs:** `1420887296`, `2210300778`, `3628077362`, `5451202886`, `6744050161`, `8299170626`, `10431684079`, `13631874444`, `14265126334`
- **Canonical:** C045 Grouping / folders / categories / tags; C053 Custom time-of-day segments

### R23-119 — Extra capacity is wanted for life-domain segmentation: health / work / relationships / creative

- **Where:** §4.1 #2 — life-domain segmentation
- **This app does:** absent grouping
- **User reaction:** complaint
- **Magnitude:** 6 representative reviews
- **Direction for us:** undecided · **Report confidence:** high-priority (sub-reason) · **Generalisable:** yes
- **Review IDs:** `1276552134`, `3401507494`, `4845782428`, `5860788478`, `9592334909`, `10655113870`
- **Canonical:** C045 Grouping / folders / categories / tags

### R23-121 — A once-a-month or once-a-week habit consumes one of the 24 daily slots — non-daily items eat capacity

- **Where:** §4.1 #4 — non-daily items eat daily slots
- **This app does:** non-daily habits count against the cap
- **User reaction:** complaint
- **Magnitude:** 5 representative reviews
- **Direction for us:** undecided · **Report confidence:** high-priority (sub-reason) · **Generalisable:** yes
- **Review IDs:** `1424093667`, `3480265806`, `5230479351`, `6050921044`, `10096479510`
- **Canonical:** C043 Flexible / custom frequency; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-130 — Over-achievement is discarded: a timed or counted goal stops recording at the target

- **Where:** §4.4 Over-achievement is discarded — 'goal 30 minutes, read 90, it stops at 30'
- **This app does:** counts stop at goal
- **User reaction:** complaint
- **Magnitude:** 17 representative reviews within the 77
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1230386714`, `2749205687`, `6753878706`, `7249290170`, `7353753973`, `7622168499`, `8341383590`, `8847760481`, `10504293132`, `11851969749`, `11936906855`, `12190462519`, `12209604326`, `12750955556`, `13211973709`, `14106848070`, `14472714750`
- **Canonical:** C048 Flexible units / partial progress

### R23-131 — Partial progress is shown as failure: 6 of 8 glasses renders as an ✗ on the calendar

- **Where:** §4.4 Partial progress is shown as failure — '6 of 8 glasses shows an ✗'
- **This app does:** binary complete/incomplete
- **User reaction:** complaint
- **Magnitude:** 13 representative reviews within the 77
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1451333906`, `2547471027`, `6317641073`, `8112114156`, `8164065134`, `9227205533`, `9613837462`, `10204901614`, `10320667734`, `10914768023`, `12169314722`, `13566507177`, `11968580277`
- **Canonical:** C048 Flexible units / partial progress; C201 A user-set partial-completion threshold — a 'good day' below 100%

### R23-133 — Frequency shipped incrementally (times-per-week late 2015, times-per-day 2016, times-per-month, every-N-days); still absent at the last review: yearly goals, arbitrary intervals such as every 6 weeks / quarterly / a Korean shift worker's 4–5-day rotation, and specific dates of the month

- **Where:** §4.5 Frequency — shipped over time; still absent: yearly, arbitrary intervals (every 6 weeks / quarterly / 4–5-day shift rotation), specific dates of the month
- **This app does:** partial frequency model
- **User reaction:** complaint
- **Magnitude:** 101 (1.39%, meaningful)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1295254379`, `1450537959`, `5358836760`, `9436431103`, `10397702118`, `11891384654`, `12537226420`, `13735945699`, `11315859157`, `14320549167`, `9989040594`, `8577016754`, `9939580410`, `6914988991`
- **Canonical:** C043 Flexible / custom frequency

### R23-134 — Statistics are limited to the current and previous month; the most-requested visualisation is a year heat-map / GitHub contribution grid

- **Where:** §4.5 History depth — statistics limited to current and previous month; year heat-map / GitHub grid most requested
- **This app does:** two-month history depth
- **User reaction:** complaint
- **Magnitude:** 46 (0.63%, emerging)
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1384736153`, `1463992819`, `1499824611`, `3911574614`, `8409036350`, `9579170708`, `10287328470`, `11032222087`, `13136255685`, `13611043861`, `13647744905`, `10674342410`, `6494025558`, `5393033193`, `13991866349`
- **Canonical:** C012 Week / month / year grid views

### R23-180 — Chinese feature asks are distinctive and consistent: count-up timers and recording beyond the goal (including the corpus's most-upvoted review), notes/annotations, and longer cycles

- **Where:** §8.5 China — distinctive, consistent feature asks: count-up timers and record beyond goal, notes/annotations, longer cycles
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 6 + 3 + 3 representative reviews
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9145507788`, `8642992805`, `8019547720`, `10249897584`, `12776433938`, `10956685084`, `3524837176`, `1702798894`, `6099167705`, `2056232018`, `9405395737`, `11315859157`
- **Canonical:** C043 Flexible / custom frequency; C048 Flexible units / partial progress; C172 Per-day / per-habit notes and journal text

### R23-219 — P1: optional capacity beyond 24, off by default, behind a setting that states the rationale — the default must not change; the 118 defenders are the reason the other 1,780 like the product

- **Where:** §11.3 P1 — optional capacity beyond 24, off by default, behind a setting that states the rationale; the default must not change
- **This app does:** hard cap
- **User reaction:** complaint
- **Magnitude:** 620 asks (8.53%) + 118 defenders
- **Direction for us:** undecided · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** opt-in only; default untouched
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-220 — P2: floor-without-ceiling goals and a partial-progress calendar state — a goal of 8 glasses should record 12; a 6-of-8 day should render as a partial ring, not ✗; do not change the streak rule, only what is recorded and shown

- **Where:** §11.3 P2 — floor-without-ceiling goals + partial-progress calendar state; do not change the streak rule, only what is recorded and shown
- **This app does:** binary
- **User reaction:** complaint
- **Magnitude:** 77 reviews + the two most-upvoted
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** streak rule unchanged
- **Review IDs:** `9145507788`, `8642992805`
- **Canonical:** C048 Flexible units / partial progress; C201 A user-set partial-completion threshold — a 'good day' below 100%

### R23-222 — P4: restore an interactive widget path (iOS 17+ App Intents) and stop the blank-widget regressions

- **Where:** §11.3 P4 — restore an interactive widget path (iOS 17+ App Intents) and stop blank-widget regressions
- **This app does:** no interactive widget since 2020
- **User reaction:** complaint
- **Magnitude:** 36 named requests over five years; 20 blank-widget reports
- **Direction for us:** undecided · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C023 Interactive widget check-off

### R23-223 — P5: a year heat-map and history beyond two months — the single most-named competitor feature gap (Habitify)

- **Where:** §11.3 P5 — year heat-map and history beyond two months; the single most-named competitor feature gap (Habitify)
- **This app does:** two-month history
- **User reaction:** complaint
- **Magnitude:** 46 reviews
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13647744905`, `11032222087`, `13136255685`, `6494025558`
- **Canonical:** C012 Week / month / year grid views

### R23-224 — P6: yearly and arbitrary-interval scheduling — every N weeks, quarterly, specific dates of the month

- **Where:** §11.3 P6 — yearly and arbitrary-interval scheduling (every N weeks, quarterly, specific dates of month)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 101 frequency reviews
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9436431103`, `11315859157`, `12537226420`, `9989040594`, `14320549167`
- **Canonical:** C043 Flexible / custom frequency

### R23-225 — P7: optional density control — a list view or 3×4 layout, per page, opt-in only: 8.9% of that theme's reviews are 1★ precisely because the app changed on them

- **Where:** §11.3 P7 — optional density control: a list view or 3×4 layout per page; opt-in only because 8.9% of that theme's reviews are 1★ precisely because the app changed on them
- **This app does:** fixed 2×3 grid
- **User reaction:** complaint
- **Magnitude:** 45 reviews
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** opt-in only
- **Review IDs:** `10475031837`, `11548743644`, `13528143060`, `14156553445`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

## Monetization

### R23-009 — 'No subscription / one-time purchase' is a genuine, repeatedly stated purchase reason that grows as a share over time (3.61% pre-2017 → 8.00% post-2021); the price objection is small, and named prices rose ~2.5× over eleven years without the objection rate rising with it

- **Where:** Executive summary #6 — the one-time price is a stated purchase reason; the objection is small and shrinking
- **This app does:** one-time purchase; price $3.99 (2015–16) → ~$5 (2017–21) → $7.99–$8 (2019–24) → $9.99–$10 (2024–26)
- **User reaction:** purchase-driver
- **Magnitude:** 398 (5.47%, high-priority) praise one-time, mean 4.43; 3.61% E1 → 8.00% E3; 123 (1.69%, meaningful) object to price, mean 2.21, 50.4% 1★; objection rate 1.75% E1 → 2.21% E3
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors

### R23-042 — Family Sharing is supported on the one-time purchase

- **Where:** §2.1 Family Sharing
- **This app does:** Family Sharing on
- **User reaction:** praise
- **Magnitude:** inventory row
- **Direction for us:** do · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1925820330`, `9367716405`
- **Canonical:** C037 Family plan

### R23-043 — A macOS app exists; it was reported as a separate purchase in 2020–2021, then included in the universal purchase from late 2021 — a real, dated model change; the strict classifier caught 1 'Mac charged separately' review but manual reading found at least 8 (weak, ~0.11%)

- **Where:** §2.1 macOS app — separately purchased at times; §2.2 Mac app model change
- **This app does:** Mac app separate purchase 2020–21 → universal purchase late 2021
- **User reaction:** complaint
- **Magnitude:** ≥8 reviews (~0.11%, weak; classifier row 49 shows 1 — a known miss)
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `5894140234`, `8319272939`, `12530776051`, `6674999158`, `6647868915`, `6853278337`, `7723975238`, `5960818396`, `5924527558`, `8094189480`, `9007693160`, `9443737606`, `6946517071`, `7212017077`
- **Canonical:** C044 Mac / desktop / web app

### R23-047 — Paid up-front, one-time — no subscription, no consumable IAP, no ads; every feature is behind the price and there is no free or premium tier; a handful wrongly believed it was free (promo redemptions or confusion)

- **Where:** §2.2 Model — paid up-front, one-time; everything behind the price; no free tier
- **This app does:** paid-only one-time purchase
- **User reaction:** purchase-driver
- **Magnitude:** 398 (5.47%) name the model as a reason to buy; 3 reviews believed it was free
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10028224650`, `7641339972`, `8274159929`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R23-049 — Streaks is sold in a bundle with the developer's Streaks Workout and HealthFace apps

- **Where:** §2.2 Bundle — Streaks + Streaks Workout (+ HealthFace)
- **This app does:** app-family bundle
- **User reaction:** none
- **Magnitude:** 4 reviews cited
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `1519665903`, `2130326760`, `7992811619`, `10781985066`
- **Canonical:** C060 Cross-sell an app family on brand trust

### R23-050 — Named price ladder from review text: 2015–16 $3.99 / £2.99 / €3.99 / ¥15–18 / ₽15 · 2017–21 $4.99–5.99 / £4.99 / €5.49 / ¥25–30 / ₩5,900 / ₺14 / ₹250 / A$7.99 · 2022–24 $7.99–8 / €6 / CA$9–10 / R$25 · 2025–26 $9.99–10 / £6 / A$9.99 / €6 — roughly 2.5× nominal over eleven years with no rise in the price-objection rate

- **Where:** §2.2 Named price ladder 2015→2026; ~2.5× with no rise in objection rate
- **This app does:** one-time price raised ~2.5× 2015→2026
- **User reaction:** mixed
- **Magnitude:** ~2.5× price; objection rate E1 1.75% → E3 2.21%
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1209935398`, `1223253220`, `1312829048`, `1863150756`, `1821681612`, `3674856943`, `5190340051`, `9608304681`, `11438051593`, `12868795563`, `12687610729`, `13288491780`, `14469956788`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R23-051 — Refund requests are the lowest-mean theme; Apple, not the developer, controls refunds on a paid-up-front app, and several reviewers are addressing Apple through the review field

- **Where:** §2.2 Refund friction — Apple controls it; reviewers address Apple through the review field
- **This app does:** paid-up-front — refunds via Apple only
- **User reaction:** complaint
- **Magnitude:** 79 (1.09%, meaningful), mean 1.75, 70.9% 1★
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11474891367`, `11478493003`, `9789072827`, `10238906445`
- **Canonical:** C029 Billing must be exactly right

### R23-061 — One-time purchase / no subscription praised

- **Where:** §3.1 theme table #7 One-time purchase / no subscription praised
- **This app does:** see §3.1
- **User reaction:** purchase-driver
- **Magnitude:** 398 (5.47%, high-priority), mean 4.43, 1★ 4.8%, 5★ 71.4%
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R23-069 — Price objection

- **Where:** §3.1 theme table #15 Price objection
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 123 (1.69%, meaningful), mean 2.21, 1★ 50.4%, 5★ 13.8%
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R23-075 — Refund requested / billing confusion

- **Where:** §3.1 theme table #21 Refund requested / billing confusion
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 79 (1.09%, meaningful), mean 1.75, 1★ 70.9%, 5★ 13.9%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right

### R23-094 — 'No free trial' on a paid-up-front app is a weak theme with a bad rating profile

- **Where:** §3.1 #43 No free trial — weak, 40% 1★
- **This app does:** no trial — paid before use
- **User reaction:** blocked-conversion
- **Magnitude:** 15 (0.21%, weak), mean 2.40, 1★ 40.0%
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C063 Free trial before purchase

### R23-160 — Named purchase triggers in evidence order: no subscription (398); Apple Watch (named as the reason in ≥15); Apple Health (277 mentions); recommendation from a person (28 therapist/coach/doctor/physio, mean 4.50); Atomic Habits / habit literature (14, mean 4.79); media / Apple editorial (17, mean 2.53); Starbucks promo (13, mean 4.62); podcast/blog (12, mean ~4.6)

- **Where:** §7.2 Purchase triggers table (verbatim)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Trigger | n / evidence | Note ; No subscription | 398 (5.47%) | The single clearest stated purchase reason. 5227808774, 6957986652, 7271400285, 7632443555, 8575876614, 9592334909, 10725318285, 12642801382, 13920320198, 13681908485 ; Apple Watch support | Named as *the* reason in ≥15 reviews | 4727429074, 5132838929, 5982716099, 6194996941, 7629771235, 8378091564, 12345694464, 13634662993 ; Apple Health integration | 277 mentions | 3226175029, 5352820364, 6651711303, 12539768742 ; Recommendation from a person | 28 mention therapist/coach/doctor/physio (mean 4.50) | 1458069420, 5578733348, 7140084696, 10055294004 (a psychologist recommending it to ADHD clients), 11221418136, 11941219130 (recommended by a therapist), 13400151593 ; Atomic Habits / habit literature | 14 name *Atomic Habits* (mean 4.79) | 5482928002, 6683980837, 8295352711, 8551272137, 9594186310, 9984193559, 13036198091, 13587842405. Also *Mini Habits* (1496269982), *Power of Habit* (1797731097), *Deep Work* (1733290107), *The Power of Full Engagement* (1437821189) ; Media / Apple editorial | 17 mention Apple Design Award or editorial placement — mean 2.53 | 1400446995, 1526417758, 2186911032, 3658903640, 4651536264, 5132838929, 9496499610, 9558726188 ; Starbucks free promo (2015–16) | 13, mean 4.62 | See 2.2 ; Podcast / blog (Daring Fireball, MacBreak Weekly, Do By Friday, Diary of a CEO) | 12, mean ~4.6 | 1390169236, 1390723056, 1417753375, 1328979417, 1783173167, 9469351381
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `5227808774`, `6957986652`, `7271400285`, `7632443555`, `8575876614`, `9592334909`, `10725318285`, `12642801382`, `13920320198`, `13681908485`, `4727429074`, `5132838929`, `5982716099`, `6194996941`, `7629771235`, `8378091564`, `12345694464`, `13634662993`, `3226175029`, `5352820364`, `6651711303`, `12539768742`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R23-166 — 'Worth it / worth every penny' outnumbers 'not worth it' 3.2 : 1 — the cleanest value read in the corpus

- **Where:** §7.3 'Worth it' vs 'not worth it' — 3.2 : 1 in favour
- **This app does:** one-time price judged worth it
- **User reaction:** purchase-driver
- **Magnitude:** 136 (1.87%) worth it, mean 4.72; 42 (0.58%) not worth it, mean 1.69; ratio 3.2:1
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `7177668861`, `7743170609`, `7894034801`, `8643437714`, `9057932829`, `9344624735`, `11510502627`, `11968241720`, `12642801382`, `13647744905`, `1420547074`, `1466396959`, `1712407241`, `1922531600`, `2100236937`, `3339756991`, `4592779297`, `7199898184`, `10383442127`, `10451316703`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R23-167 — Price objection distribution: us 41, au 18, ca 12, de 12, gb 12, cn 10, nz 3, es/ru/se 2; rate by storefront au 5.7% (highest of any 50+ storefront), de 3.8%, ca 3.6%, gb 2.6%, cn 2.5%, us 1.3%; by era E1 1.75% → E2 2.41% → E3 2.21% — flat despite a ~2.5× nominal price rise

- **Where:** §7.4 Price objection examined — by storefront and era; flat despite ~2.5× price rise
- **This app does:** raised the one-time price ~2.5×
- **User reaction:** complaint
- **Magnitude:** 123 (1.69%, meaningful), mean 2.21, 50.4% 1★; au 5.7%
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C092 Regional pricing

### R23-170 — The second refund source is expectation mismatch — the buyer discovers the cap or the 'it's a checklist' reality after paying and wants the money back

- **Where:** §7.5 Refunds — expectation mismatch: buyer discovers the cap or the 'checklist' reality
- **This app does:** paid before use, no trial
- **User reaction:** blocked-conversion
- **Magnitude:** 8 representative reviews within 79
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9540311476`, `10238906445`, `11450516665`, `11474891367`, `11478493003`, `12595616102`, `12277830068`, `12729571609`
- **Canonical:** C063 Free trial before purchase; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R23-197 — 'No subscription' praise rose 3.61% → 5.55% → 8.00% across eras — as the category subscription-ised, an eleven-year-old one-time purchase became the reason to choose it; the one competitive position that strengthened

- **Where:** §9.6 Trend 5 — the pricing model becomes a stronger differentiator over time [very strong]: 3.61% → 5.55% → 8.00%
- **This app does:** one-time purchase held for eleven years
- **User reaction:** purchase-driver
- **Magnitude:** 3.61% → 5.55% → 8.00%
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R23-228 — S3: consider a time-limited trial or a demo mode — 15 reviews name the absence of a trial (mean 2.40) and it appears as a stated regret in refund reviews; counter-evidence: 'There's no trial because it doesn't need one'

- **Where:** §11.4 S3 — consider a time-limited trial or demo mode; counter-evidence 'There's no trial because it doesn't need one'
- **This app does:** no trial
- **User reaction:** blocked-conversion
- **Magnitude:** 15 (0.21%, weak), mean 2.40
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10455680816`
- **Canonical:** C063 Free trial before purchase

## Tactics the app used

### R23-048 — A Starbucks 'Pick of the Week' free promo in 2015–2016 drew reviewers at mean 4.62, and one of them is still using the app in July 2025 — ten-year retention from a free promo

- **Where:** §2.2 Free acquisition promo — Starbucks 'Pick of the Week' 2015–2016; ten-year retention
- **This app does:** one-off free promotion via Starbucks
- **User reaction:** praise
- **Magnitude:** 13 reviews (0.18%, weak), mean 4.62; one still active Jul 2025
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `1276154024`, `1305108155`, `1311263979`, `1313390731`, `1343836916`, `1374387287`, `1389903668`, `1391137306`, `12871227227`
- **Canonical:** C225 A one-off free promotion (App of the Week, partner promo) acquires durable users

## Insights (the why)

### R23-004 — A minority of users actively defend the task cap as the reason the app works — the constraint itself is a value proposition for them

- **Where:** Executive summary #1 — 118 reviews actively defend the limit
- **This app does:** hard cap defended by users
- **User reaction:** praise
- **Magnitude:** 118 reviews (1.62%, meaningful) defend the limit vs 620 asking for more
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1223740791`, `1465200157`, `6819955202`, `10779334259`, `13400151593`
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-005 — Simplicity/minimalism is the highest-volume positive theme by a wide margin, and it is the same property that generates the capacity complaint — the constraint is the value proposition and the top objection at once; any capacity change must be an opt-in that leaves the default untouched

- **Where:** Executive summary #2 — simplicity is the moat and generates the capacity complaint
- **This app does:** minimal, constrained design
- **User reaction:** praise
- **Magnitude:** 1,780 reviews (24.48%, high-priority) praise simplicity, mean 4.58, 76.9% 5★
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** capacity beyond the default must be opt-in, default untouched
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-014 — Several of the 12 edited reviews are visible rating upgrades after a developer fix — fixes bring reviewers back

- **Where:** §1.3 Coverage — is_edited records are visible upgrades after a developer fix
- **This app does:** developer fixes cause reviewers to edit ratings upward
- **User reaction:** praise
- **Magnitude:** 12 is_edited records
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `9775440687`, `8551938079`, `3964933428`, `8545693662`, `11583805884`, `11475255452`, `11266371820`, `11217881769`, `8631829289`, `8547420011`, `8545368780`, `1853307561`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R23-055 — Simplicity/minimalism praised — the highest-volume theme

- **Where:** §3.1 theme table #1 Simplicity / minimalism praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 1,780 (24.48%, high-priority), mean 4.58, 1★ 3.1%, 5★ 76.9%
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R23-057 — Streak psychology works — the highest-satisfaction theme; reviewers describe getting out of bed to preserve a streak

- **Where:** §3.1 theme table #3 Streak motivation / accountability works; §3.3 #3
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 902 (12.41%, high-priority), mean 4.75, 1★ 0.7%, 5★ 81.2%
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C024 Streaks / gamification

### R23-058 — 'It works' / changed my behaviour

- **Where:** §3.1 theme table #4 'It works' / changed my behaviour
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 762 (10.48%, high-priority), mean 4.77, 1★ 1.0%, 5★ 84.1%
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-070 — Capacity limit defended as a feature

- **Where:** §3.1 theme table #16 Capacity limit defended as a feature
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 118 (1.62%, meaningful), mean 4.22, 1★ 5.9%, 5★ 57.6%
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-099 — Two distinct churn mechanisms with different timing: UX confusion churns people in week one ('wasted several hours'; 'deleted after 20 minutes'); data loss and Watch sync churn people in year three-to-eight ('used Streaks for some years… deeply, deeply disappointed')

- **Where:** §3.2 Interpretation — two churn mechanisms with different timing
- **This app does:** new-user churn via UX; long-tenure churn via data loss/sync
- **User reaction:** churn
- **Magnitude:** UI 250 mean 2.66; data loss 81 mean 2.17; Watch bug 49 mean 2.57
- **Direction for us:** must-never-break · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `11125249667`, `9212927813`, `12257280896`, `11194503416`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R23-101 — Streak psychology is the highest-satisfaction theme — reviewers describe getting out of bed to preserve a streak

- **Where:** §3.3 #3 Streak psychology — reviewers get out of bed to preserve a streak
- **This app does:** streaks as the core mechanic
- **User reaction:** praise
- **Magnitude:** 902 (12.41%), mean 4.75, 0.7% 1★
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `1303004020`, `1537030013`, `2434415319`, `10359178881`
- **Canonical:** C024 Streaks / gamification

### R23-120 — The single most persuasive argument for more capacity, made repeatedly: people want to keep tracking a habit that has become automatic while starting a new one — a 'graduated' state

- **Where:** §4.1 #3 — graduated habits: keep tracking an automatic habit while starting a new one
- **This app does:** no graduated/automatic state; a mastered habit still occupies a slot
- **User reaction:** complaint
- **Magnitude:** 4 representative reviews; 'most persuasive argument in the corpus'
- **Direction for us:** undecided · **Report confidence:** high-priority (sub-reason) · **Generalisable:** yes
- **Review IDs:** `1417118522`, `4011854670`, `6522763838`, `10527629911`
- **Canonical:** C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot

### R23-123 — The 118 defenders make a substantive argument: the cap is the reason the app works ('Limiting to only six … is a feature, not an area for improvement'); one credits the four-page structure with segmenting the day

- **Where:** §4.1 Counter-evidence — defenders say the cap is the reason the app works; four-page structure segments the day
- **This app does:** cap as feature
- **User reaction:** praise
- **Magnitude:** 118 (1.62%, meaningful)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1223740791`, `1262758739`, `1324612441`, `1421300604`, `1509068759`, `3229553941`, `6819955202`, `10779334259`, `13400151593`, `13312978008`
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-132 — The most articulate statement of the psychology: a habit stated as 'do 30 push-ups' breaks on a 25-push-up day, whereas 'push-ups per day' would have recorded a 25 and preserved momentum; a jp 5★ review sets out five specific sub-requests

- **Where:** §4.4 Why it matters psychologically — 'do 30 push-ups' breaks on a 25 day; 'push-ups per day' would record 25 and preserve momentum
- **This app does:** binary model demotivates on near-miss days
- **User reaction:** complaint
- **Magnitude:** 2 named reviews; 2 of the 3 most-upvoted reviews in the corpus (313, 126 votes)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11968580277`, `9592238918`, `9145507788`, `8642992805`
- **Canonical:** C048 Flexible units / partial progress

### R23-136 — 5.5% of 5★ reviews contain a capacity complaint and 2.9% a sync caveat — the app's advocates telling it what to fix; treating 5★ as unqualified approval would discard the highest-quality feedback in the corpus

- **Where:** §5.1 Notable — 5.5% of 5★ contain a capacity complaint and 2.9% a sync caveat: advocates telling it what to fix
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 250 of 4,586 (5.5%) capacity; 132 (2.9%) sync; 133 (2.9%) 'changed my life' verbatim
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `1210218319`, `2008517387`, `5946603412`, `9474096582`, `12231562082`, `7461351458`, `8639765578`, `8746727569`, `10511894011`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R23-137 — 4★ is overwhelmingly 'five stars minus the cap': capacity is 17.9% of all 4★, just behind simplicity (20.2%), and dozens say so in the title ('Remove the limit and it gets 5 stars instead of 4') — a mechanically identifiable ~207-review block of ratings uplift from one change

- **Where:** §5.2 4★ is 'five stars minus the cap' — 207 reviews = 17.9% of 4★; a mechanically identifiable uplift block
- **This app does:** hard cap
- **User reaction:** complaint
- **Magnitude:** 207 of 1,154 4★ (17.9%); simplicity 233 (20.2%); other 4★: Watch 94 (8.1%), widget 74 (6.4%), sync 64 (5.5%), rewards 35 (3.0%), multiple-per-day 33 (2.9%), frequency 32 (2.8%)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1230386714`, `1351860446`, `1417249455`, `2065457103`, `3624120327`, `4927142814`, `5365517703`, `7445407807`, `8975182976`, `12868795563`
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-138 — 3★ is 'beautiful but': capacity leads (17.3%) with design praise (16.4%) appearing together, then Watch, widget, sync and UX confusion

- **Where:** §5.3 3★ is the 'beautiful but' band — capacity and design praise appear together
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=538: capacity 93 (17.3%), design 88 (16.4%), Watch 75 (13.9%), widget 60 (11.2%), sync 57 (10.6%), UX 47 (8.7%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `1416743063`, `2076300664`, `3303247598`, `5348667492`, `6613034447`, `9522443552`, `10327827837`, `13180845529`
- **Canonical:** — (nuance register)

### R23-139 — 2★ is where UX and reliability overtake capacity: non-standard interface, sync/data destruction, price/value mismatch, Watch failure, and the 'it's only a checklist' argument

- **Where:** §5.4 2★ — UX and reliability overtake capacity
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** n=342 read in full
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `2256538710`, `2178770367`, `9176441512`, `11812335594`, `12995797717`, `8591937731`, `8657672267`, `9146983436`, `11738653741`, `13491181225`, `1307823162`, `2082928612`, `2074625050`, `12989179143`, `1928204873`, `8537067616`, `8846625627`, `12008652692`, `1922531600`, `8489597297`, `11243132812`
- **Canonical:** — (nuance register)

### R23-145 — A reviewer describes the correct sync architecture: immutable timestamped events applied in order rather than last-writer-wins state replacement; another reaches the same conclusion and recommends abandoning iCloud entirely

- **Where:** §6.1 The most technically precise diagnosis — immutable timestamped events applied in order, not last-writer-wins
- **This app does:** last-writer-wins iCloud sync
- **User reaction:** complaint
- **Magnitude:** 2 named reviews (us Jan 2024; ca Dec 2025)
- **Direction for us:** must-never-break · **Report confidence:** single reviews, technically precise · **Generalisable:** yes
- **Review IDs:** `10815885619`, `13491181225`
- **Canonical:** C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement

### R23-163 — Reviews that name the Apple Design Award or editorial placement have the lowest mean of any acquisition channel — every one is 'I trusted the award and was disappointed'; award-driven traffic arrives calibrated to 'best app', not to a deliberately constrained tracker, and converts into the 'no value' 1★ block (hypothesis, n=17)

- **Where:** §7.2 Apple editorial / Design Award traffic has the lowest mean of any channel (2.53) — 'I trusted the award and was disappointed' [weak, n=17]
- **This app does:** won an Apple Design Award; featured editorially
- **User reaction:** churn
- **Magnitude:** 17 reviews, mean 2.53 — weak, hypothesis
- **Direction for us:** do · **Report confidence:** weak (n=17) · **Generalisable:** yes
- **Review IDs:** `1400446995`, `1526417758`, `2186911032`, `3658903640`, `4651536264`, `5132838929`, `9496499610`, `9558726188`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C134 Lead the store listing with what users actually love

### R23-168 — The price objection is consistently feature-per-dollar, not the absolute number, and is usually paired with the capacity cap or with 'Reminders does this free' — the pricing power is real; what is missing is justification at the point of purchase, because the listing does not pre-empt the two objections that produce almost all price complaints

- **Where:** §7.4 The objection is almost never about the absolute number — it is feature-per-dollar, paired with the cap or 'Reminders does this free'; '12 tasks for ¥610 — are you making fun of users?'
- **This app does:** listing does not pre-empt the cap and the 'checklist' objection
- **User reaction:** complaint
- **Magnitude:** all 123 read
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1213415787`, `1273715314`, `1398416447`, `1400446995`, `2074625050`, `3606167716`, `5190340051`, `6598286675`, `9484848485`, `12456594252`, `12687610729`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R23-185 — There is no high-spend/low-spend product split in this corpus: the two defined groups are indistinguishable from each other (4.22) and only marginally better than the rest of the world (4.12) — what varies by country is which complaint dominates, not how much people complain

- **Where:** §8.8 Finding — the two groups are statistically indistinguishable and only marginally better than the rest of the world; what varies by country is which complaint dominates, not how much
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 4.22 vs 4.22 vs 4.12
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R23-189 — The corpus's single most thoughtful negative review (dk, 2★, previously 5★) argues from behavioural psychology that habit apps cannot substitute for a visible physical cue and recommends pen and paper

- **Where:** §8.10 Denmark (n=30) — the single most thoughtful negative review argues habit apps cannot substitute for a visible physical cue
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 1 review
- **Direction for us:** research · **Report confidence:** single review · **Generalisable:** yes
- **Review IDs:** `8489597297`
- **Canonical:** — (nuance register)

### R23-202 — Press-and-hold beats tap: reviewers describe the deliberate friction as the source of satisfaction and as accident-proofing — copying 'tap to complete' loses something real

- **Where:** Part 10 #2 — press-and-hold beats tap; copying 'tap to complete' loses something real
- **This app does:** press-and-hold
- **User reaction:** praise
- **Magnitude:** attested inside themes 1 and 3
- **Direction for us:** build-free · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C229 A deliberate completion gesture — press-and-hold with haptic and sound, not a bare tap

### R23-203 — HealthKit auto-completion is the single highest-leverage integration in this category — it removes the friction that killed every other habit app the reviewer tried

- **Where:** Part 10 #3 — HealthKit auto-completion is the single highest-leverage integration in the category
- **This app does:** HealthKit auto-complete
- **User reaction:** praise
- **Magnitude:** 277 reviews
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration

### R23-206 — One-time pricing is a growing wedge, not a legacy handicap — 398 reviews name it and the rate more than doubled across eleven years

- **Where:** Part 10 #6 — one-time pricing is a growing wedge, not a legacy handicap
- **This app does:** one-time
- **User reaction:** purchase-driver
- **Magnitude:** 398; 3.61% → 8.00%
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

## Audiences

### R23-012 — Self-identified ADHD, autism, executive dysfunction, depression, memory-injury and PTSD users are a growing, high-satisfaction segment the app never marketed to; several arrive on a therapist's or doctor's recommendation

- **Where:** Executive summary #9 — neurodivergent users are a growing, high-satisfaction segment the app was not marketed to
- **This app does:** not marketed to neurodivergent users; the constrained design suits them
- **User reaction:** praise
- **Magnitude:** 73 (1.00%, meaningful), mean 4.45, 68.5% 5★; 0.66% E1 → 0.70% E2 → 1.90% E3; 28 mention therapist/coach/doctor/physio, mean 4.50
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8577993480`, `8266328218`, `9514806382`, `10779334259`, `11121463145`, `11285333857`, `12845331532`, `13274948716`, `13528928858`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R23-079 — ADHD / autism / mental-health use

- **Where:** §3.1 theme table #25 ADHD / autism / mental-health use
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 73 (1.00%, meaningful), mean 4.45, 1★ 5.5%, 5★ 68.5%
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R23-122 — Extra capacity is wanted to track a child's chores alongside one's own — family/multi-person use inside one account

- **Where:** §4.1 #5 — family / multi-person use: a child's chores alongside your own
- **This app does:** no profiles
- **User reaction:** complaint
- **Magnitude:** 3 representative reviews
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `1784849811`, `11003956267`, `11316685590`
- **Canonical:** C068 Parents tracking kids; C174 Multiple profiles (me, kids, pet, work)

### R23-161 — A professional recommendation (therapist, coach, doctor, physio) is a named purchase trigger with high satisfaction; one review is a psychologist recommending it to ADHD clients

- **Where:** §7.2 Recommendation from a person — therapist / coach / doctor / physio; a psychologist recommending it to ADHD clients
- **This app does:** recommended by clinicians
- **User reaction:** purchase-driver
- **Magnitude:** 28 mention therapist/coach/doctor/physio, mean 4.50
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1458069420`, `5578733348`, `7140084696`, `10055294004`, `11221418136`, `11941219130`, `13400151593`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R23-198 — Neurodivergent self-identification rose 0.66% → 0.70% → 1.90%, concentrated in 2022–2026 (mean 4.45); several of these reviews double as the strongest capacity complaints because task decomposition is exactly what executive-function support requires — one is an explicit accusation of ableism against the help-page wording

- **Where:** §9.7 Trend 6 — neurodivergent adoption nearly triples [meaningful]; several double as the strongest capacity complaints because task decomposition is what executive-function support requires; an explicit accusation of ableism
- **This app does:** cap hurts the segment most suited to the product
- **User reaction:** mixed
- **Magnitude:** 0.66% → 0.70% → 1.90%; 17 reviews 2022–26 cited; mean 4.45
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8266328218`, `8428275405`, `8432447980`, `8577993480`, `9514806382`, `9822595740`, `9855154146`, `10779334259`, `11121463145`, `11141541374`, `11285333857`, `11390335993`, `12333316832`, `12845331532`, `13274948716`, `13528928858`, `14469956788`, `5516647636`, `6888486242`, `8975182976`, `12523694361`, `13180845529`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

## Markets and languages

### R23-017 — 93 storefronts; 21 clear the 50-review threshold (us, gb, cn, ca, de, au, ru, kr, jp, mx, es, fr, it, br, nl, se, in, tr, ch, tw, pl) and account for 92.01% of the corpus

- **Where:** §1.6 Corpus composition — storefronts
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 21 storefronts = 6,689 of 7,270 (92.01%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-169 — Accidental purchases drive refund requests in Korea (14 refund reviews, 6.5% of that storefront — the highest anywhere) and China (5); several describe Touch ID / one-tap purchase with no confirmation; ~19 accidental-purchase reviews by reading vs 6 by strict regex

- **Where:** §7.5 Refunds — accidental purchase: Korea 14 (6.5% of storefront, highest anywhere) and China 5; Touch ID / one-tap purchase with no confirmation
- **This app does:** paid-up-front with one-tap purchase
- **User reaction:** complaint
- **Magnitude:** Korea 14 (6.5%); China 5; ~19 by reading
- **Direction for us:** research · **Report confidence:** meaningful (Korea) · **Generalisable:** yes
- **Review IDs:** `1949276046`, `2310465385`, `5759175647`, `6723289341`, `6731172815`, `7538677717`, `1835478035`, `1837678339`, `8207366467`
- **Canonical:** C063 Free trial before purchase

### R23-174 — Per-storefront n, mean, 5★%, 1★% and theme rates (cap-ask, UX, sync, watch, widget, price, refund, data-loss, notif, simple, one-time) for 21 storefronts plus global; rating distributions are language-neutral and should carry the weight

- **Where:** §8.2 All 21 eligible storefronts table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** cc | n | mean | 5★% | 1★% | cap-ask | UX | sync | watch | widget | price | refund | data-loss | notif | simple | one-time ; us | 3,141 | 4.33 | 67.0 | 6.8 | 9.8 | 3.2 | 4.3 | 6.8 | 4.1 | 1.1 | 0.8 | 1.1 | 14.9 | 28.1 | 1.4 ; gb | 460 | 4.26 | 64.1 | 7.4 | 10.2 | 4.6 | 4.8 | 7.6 | 5.0 | 2.8 | 0.9 | 1.3 | 8.3 | 28.5 | 1.5 ; cn | 404 | 4.27 | 67.1 | 10.6 | 2.0 | 0.0 | 3.7 | 5.9 | 2.7 | 2.0 | 1.2 | 0.5 | 1.2 | 9.9 | 0.5 ; ca | 337 | 3.93 | 54.6 | 11.0 | 10.7 | 5.6 | 5.6 | 9.2 | 5.3 | 3.0 | 1.2 | 0.9 | 8.0 | 22.8 | 3.3 ; de | 319 | 3.62 | 43.6 | 16.6 | 3.4 | 2.8 | 10.0 | 7.5 | 6.3 | 2.8 | 0.0 | 2.8 | 2.8 | 23.2 | 1.6 ; au | 317 | 4.17 | 64.0 | 10.1 | 8.8 | 4.1 | 2.2 | 7.6 | 1.6 | 5.4 | 0.9 | 0.6 | 9.5 | 30.3 | 0.9 ; ru | 252 | 4.13 | 62.7 | 9.9 | 4.4 | 0.8 | 6.7 | 7.9 | 6.7 | 0.8 | 0.8 | 0.8 | 4.4 | 13.1 | 0.8 ; kr | 215 | 3.98 | 60.9 | 14.0 | 8.4 | 4.7 | 2.8 | 13.5 | 4.2 | 0.5 | 6.5 | 0.9 | 5.1 | 4.2 | 0.5 ; jp | 210 | 4.06 | 57.1 | 11.0 | 3.8 | 1.4 | 4.3 | 13.3 | 4.3 | 0.0 | 0.0 | 1.4 | 5.2 | 19.5 | 0.0 ; mx | 104 | 4.20 | 64.4 | 10.6 | 3.8 | 1.9 | 3.8 | 5.8 | 6.7 | 0.0 | 0.0 | 0.0 | 4.8 | 13.5 | 1.0 ; es | 99 | 3.83 | 54.5 | 14.1 | 0.0 | 0.0 | 10.1 | 12.1 | 4.0 | 2.0 | 2.0 | 1.0 | 5.1 | 24.2 | 1.0 ; fr | 97 | 4.24 | 62.9 | 6.2 | 2.1 | 0.0 | 3.1 | 7.2 | 3.1 | 0.0 | 0.0 | 0.0 | 3.1 | 26.8 | 0.0 ; it | 92 | 3.93 | 54.3 | 15.2 | 3.3 | 4.3 | 4.3 | 8.7 | 2.2 | 0.0 | 0.0 | 0.0 | 2.2 | 18.5 | 1.1 ; br | 91 | 3.88 | 53.8 | 16.5 | 2.2 | 2.2 | 7.7 | 16.5 | 4.4 | 0.0 | 1.1 | 0.0 | 2.2 | 15.4 | 0.0 ; nl | 76 | 4.00 | 55.3 | 10.5 | 2.6 | 5.3 | 6.6 | 7.9 | 10.5 | 1.3 | 0.0 | 0.0 | 10.5 | 14.5 | 0.0 ; se | 72 | 4.03 | 48.6 | 5.6 | 4.2 | 2.8 | 9.7 | 11.1 | 4.2 | 2.8 | 0.0 | 1.4 | 4.2 | 16.7 | 1.4 ; in | 64 | 4.33 | 67.2 | 7.8 | 9.4 | 1.6 | 3.1 | 4.7 | 9.4 | 1.6 | 0.0 | 1.6 | 10.9 | 20.3 | 3.1 ; tr | 58 | 3.95 | 60.3 | 13.8 | 6.9 | 0.0 | 5.2 | 5.2 | 0.0 | 1.7 | 3.4 | 0.0 | 0.0 | 6.9 | 0.0 ; ch | 57 | 4.07 | 52.6 | 5.3 | 1.8 | 3.5 | 8.8 | 7.0 | 3.5 | 0.0 | 1.8 | 0.0 | 8.8 | 26.3 | 3.5 ; tw | 55 | 4.42 | 69.1 | 7.3 | 7.3 | 0.0 | 3.6 | 9.1 | 1.8 | 0.0 | 0.0 | 1.8 | 0.0 | 10.9 | 0.0 ; pl | 54 | 3.93 | 53.7 | 11.1 | 9.3 | 0.0 | 1.9 | 5.6 | 9.3 | 0.0 | 0.0 | 1.9 | 3.7 | 14.8 | 0.0 ; Global | 7,270 | 4.19 | 63.1 | 8.9 | 7.6 | 2.9 | 4.8 | 8.1 | 4.4 | 1.5 | 0.9 | 1.0 | 9.6 | 23.2 | 1.3
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-175 — Germany is the corpus's worst-performing large market, on three readable drivers: price-to-value objection from launch (€3.99 in 2015 — '99Ct wären OK'; rate 3.8% vs 1.3% US), bad German localisation ('Die Übersetzung ins Deutsche ist total fehlgeschlagen'; de and de-adjacent storefronts supply half of all 16 localisation complaints), and the highest sync-complaint (10.0%, 32 of 319) and data-loss (2.8%) rates of any large storefront — a market where a specific quality signal, the translation, undercut the premium price and the reliability regression landed hardest

- **Where:** §8.3 Germany — the worst-performing large market: n=319, mean 3.62, 16.6% 1★
- **This app does:** poor German translation; sync regression hit hardest
- **User reaction:** complaint
- **Magnitude:** n=319, mean 3.62 (global 4.19), 16.6% 1★ (global 8.94%), 43.6% 5★ (63.1%); price 3.8%; sync 10.0%; data loss 2.8%
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1221572381`, `1239810635`, `1272590102`, `1273715314`, `1274167690`, `1274902707`, `1275317903`, `1276435627`, `1296694168`, `1342979911`, `1343618828`, `1272924985`, `3626095782`, `1670054290`, `8119544330`, `8119556510`, `8479907454`, `8607950930`, `8651289566`, `8906562435`, `10702725657`, `10817334727`, `11215332179`, `11495964400`
- **Canonical:** C027 Localise early — it unlocks revenue; C030 Sync must work — and prove it; C064 Price level — where 'fair' turns into 'too expensive'

### R23-176 — Korea is the refund market: refund mentions at 6.5% (14 reviews, mean 2.29) are 7× the global 0.9%, several explicitly accidental ('my sibling bought it by mistake'); Korea also has the highest Apple Watch mention rate in the corpus (13.5%) and Watch failure is the most common substantive complaint

- **Where:** §8.4 Korea — the refund market: 6.5% refund mentions, 7× global; accidental purchases; highest Watch mention rate 13.5%
- **This app does:** one-tap purchase; Watch-heavy market
- **User reaction:** complaint
- **Magnitude:** n=215, mean 3.98, 14.0% 1★; refund 14 (6.5%), mean 2.29; Watch 13.5%
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1228688696`, `1231568108`, `1232238147`, `1236584204`, `1238317691`, `1394260689`, `2310465385`, `5759175647`, `6709863020`, `6723289341`, `6731172815`, `8004581061`, `11607282717`, `14374110006`, `5087160831`, `5518344768`, `6194996941`, `6518706183`, `6705225971`, `7421311142`, `7507001345`, `8367240361`, `8451072345`, `8491758578`, `8632520605`, `8707802136`, `10510343633`, `11750944106`, `13235319229`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C063 Free trial before purchase

### R23-178 — China has above-global satisfaction (mean 4.27, 67.1% 5★) but 10.6% 1★; capacity is barely an issue (2.0% vs 7.6% global) and Chinese reviewers are the most likely to endorse the constraint ('克制的设计' — restrained design)

- **Where:** §8.5 China — high satisfaction, different objection: capacity barely an issue (2.0%), Chinese reviewers endorse the constraint ('克制的设计')
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** n=404, mean 4.27, 67.1% 5★, 10.6% 1★; cap-ask 2.0%
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `1313100486`, `1323530662`, `1518162248`, `6716888329`
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-179 — In China price is the objection — ¥25–30 recurs as the number, and the 1★ Chinese reviews are almost uniformly '¥25/30 for a reminder'

- **Where:** §8.5 China — price is the objection: '¥25/30 for a reminder'
- **This app does:** ¥25–30 one-time
- **User reaction:** complaint
- **Magnitude:** price objection cn 2.5%; 10 representative reviews
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `1313100486`, `1555665144`, `1617189453`, `1627725138`, `1649879883`, `1710160223`, `1770999373`, `1826051424`, `1882392612`, `3337964650`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R23-181 — Machine-translated Chinese help text was flagged with 52 net upvotes in 2017 and is still cited in 2024

- **Where:** §8.5 China — machine-translated Chinese help text ('直接机翻？'), 52 net upvotes, still cited in 2024
- **This app does:** machine-translated help text
- **User reaction:** complaint
- **Magnitude:** 52 net upvotes; cited 2017 and 2024
- **Direction for us:** do · **Report confidence:** community-endorsed · **Generalisable:** yes
- **Review IDs:** `1933748530`, `11977883967`
- **Canonical:** C027 Localise early — it unlocks revenue

### R23-182 — Japanese reviewers write the corpus's most explicit endorsements of the design philosophy ('they understand human psychology well') and the most structured feature requests (a bilingual five-point specification for over-achievement); Watch mention 13.3% (highest with Korea); failure modes are Watch↔iPhone sync and data loss

- **Where:** §8.6 Japan — the Watch market and the most reflective reviews: explicit endorsements of the design philosophy ('人の心理がよく分かってる'), most structured feature requests
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=210, mean 4.06; Watch 13.3%
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `1282229433`, `1375644270`, `1376474685`, `1450613496`, `1450678791`, `1451144582`, `9592238918`, `3355577958`, `4640524404`, `7957667076`, `8794032644`, `8994058429`, `10661343816`, `10670030117`, `10912008189`, `12143544557`, `12293062476`, `1861463137`, `1873446324`, `11200491931`, `11286414449`, `12257280896`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R23-183 — Group A (eight highest-volume storefronts): n=5,445 (74.9%), mean 4.22, 5★ 64.0%, 1★ 8.6%; cap-ask 5.23%, price 1.69%, sync 4.39%, refund 1.05%

- **Where:** §8.7 Group A high-review-volume markets (us, gb, cn, ca, de, au, ru, kr) — n=5,445 (74.9%), mean 4.22
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=5,445 (74.9%), mean 4.22, 5★ 64.0%, 1★ 8.6%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-184 — Group B (high-spend, an external-knowledge definition — no spend or download figure exists in the data): n=5,500 (75.7%), mean 4.22, 5★ 63.8%, 1★ 8.6%, cap-ask 5.07%, price 1.64%, sync 4.25%, refund 1.00%; everything else (72 storefronts, n=1,518, 20.9%): mean 4.12, 5★ 60.6%, 1★ 10.1%, cap-ask 2.96%, price 0.79%, sync 4.81%, refund 0.66%

- **Where:** §8.8 Group B high-spend markets (us, cn, jp, gb, de, fr, ca, au, kr) — external-knowledge definition; n=5,500 (75.7%), mean 4.22; rest of world 4.12
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Group B 4.22 vs rest 4.12
- **Direction for us:** none · **Report confidence:** corpus-level fact (definition disclosed) · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-186 — By-country patterns: price-to-value objection au 5.4% / de 3.8% / ca 3.6% / cn 2.5% vs us 1.3%; refunds/accidental purchase kr 6.5% / cn 1.2% vs 0.9%; Watch centrality kr 13.5% / jp 13.3% vs 8.1%; sync failure de 10.0% / es 10.1% / se 9.7% vs 4.8%; capacity request us 9.8% / gb 10.2% / ca 10.7% / in 9.4% / pl 9.3% / kr 8.4% vs cn 2.0% / es 0.0% / fr 2.1%; localisation-quality complaints de, ru, se, kr, cn, tw, jp (plus es: mixed EN/ES notifications, untranslated elements, English-only icon search); notifications not firing th 18.2% (limited evidence)

- **Where:** §8.9 What genuinely varies by country (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Pattern | Where | Evidence ; Price-to-value objection | au 5.4%, de 3.8%, ca 3.6%, cn 2.5% vs us 1.3% | 8.3, 8.5 ; Refunds / accidental purchase | kr 6.5%, cn 1.2% vs global 0.9% | 8.4 ; Apple Watch centrality | kr 13.5%, jp 13.3% vs global 8.1% | 8.4, 8.6 ; Sync failure | de 10.0%, es 10.1%, se 9.7% vs global 4.8% | 8.3 ; Capacity request | us 9.8%, gb 10.2%, ca 10.7%, in 9.4%, pl 9.3%, kr 8.4% vs cn 2.0%, es 0.0%, fr 2.1% | 8.2 ; Localisation quality complaints | de, ru, se, kr, cn, tw, jp | 1381246799, 1381337082, 1899009447, 4323411409, 5215358938, 1933748530, 11977883967, 7847112518 (es, mixed EN/ES notifications), 12020722847 (es, untranslated elements + English-only icon search) ; Notifications not firing | th 18.2% [limited evidence, n=22] | 6.5
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `1381246799`, `1381337082`, `1899009447`, `4323411409`, `5215358938`, `1933748530`, `11977883967`, `7847112518`, `12020722847`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R23-187 — Localisation-quality complaints span seven storefronts: poor or machine translation (de, ru, se, kr, cn, tw, jp) and in Spanish mixed EN/ES notifications, untranslated elements and an English-only icon search

- **Where:** §8.9 Localisation quality complaints — untranslated elements, mixed-language notifications, English-only icon search (es); machine/poor translation in de, ru, se, kr, cn, tw, jp
- **This app does:** partial, low-quality localisation
- **User reaction:** complaint
- **Magnitude:** 16 (0.22%, weak) global; de supplies half
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `1381246799`, `1381337082`, `1899009447`, `4323411409`, `5215358938`, `7847112518`, `12020722847`
- **Canonical:** C027 Localise early — it unlocks revenue

### R23-188 — Thailand (n=22) names notification failure in 4 reviews (18.2%) — the highest rate anywhere; limited evidence

- **Where:** §8.10 Sub-50 storefronts — Thailand (n=22) notification failure 18.2% [limited evidence]
- **This app does:** reminders not firing in Thailand
- **User reaction:** complaint
- **Magnitude:** 4 of 22 (18.2%), limited evidence
- **Direction for us:** must-never-break · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `3630312469`, `5608136878`, `6036356305`, `6825459841`, `7151647360`, `2942900673`, `3917861651`
- **Canonical:** C039 Reminders fire reliably, once

## Dated events and trends

### R23-006 — The rating decline is a post-2021 reliability story: annual mean fell 4.58 (2016) → 4.02 (2021) → 3.92 (2022) → 3.81 (2024) → 3.71 (2025) → 3.29 (2026), tracked by sync complaints (1.4% of 2015–17 reviews → 7.60% of reviews from Jan 2022, mean 2.90) and data loss (60 of 81 total after the iCloud sync rewrite, 3.38% of post-2022 reviews, mean 2.03)

- **Where:** Executive summary #3 — reliability, not pricing, turned the ratings curve down; post-2021
- **This app does:** iCloud sync rewrite (2021) followed by sync and data-loss regressions
- **User reaction:** 1★-burst
- **Magnitude:** annual mean 4.58 → 4.02 → 3.92 → 3.81 → 3.71 → 3.29; sync 135 of 1,776 post-Jan-2022 reviews (7.60%, mean 2.90); data loss 81 (1.11%) total, 60 (3.38% since Jan 2022, mean 2.03)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8479907454`, `8646756790`, `8851969812`, `10125490424`, `11174051475`, `11217881769`, `11764467723`, `12257280896`, `13219722364`, `14156559364`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change

### R23-011 — The interactive Today-view widget was lost around iOS 14 (Sept 2020) and users asked for it back through 2026 — a capability regression tracked for four years

- **Where:** Executive summary #8 — widget capability regressed and users noticed for four years
- **This app does:** interactive Today-view widget removed ~Sept 2020; non-interactive replacement
- **User reaction:** complaint
- **Magnitude:** 318 (4.37%) mention the widget; 134 (42%) negative, mean 3.40
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `6448871007`, `6472011768`, `6540711760`, `6935238940`, `7824788952`, `9100003341`, `10006367703`, `11748639117`, `13580820001`, `13909346620`
- **Canonical:** C023 Interactive widget check-off; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R23-016 — Per-year volume, mean, 5★ share and 1★ share, 2015–2026: three golden years (2015–17, mean 4.51–4.58) then a step down in 2018 (3.96, 1★ 12.4%) and a slow slide to 3.29 with 24.6% 1★ in 2026

- **Where:** §1.6 Corpus composition — by-year table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | mean | 5★ % | 1★ % ; 2015 | 868 | 4.51 | 66.9 | 2.6 ; 2016 | 1,347 | 4.58 | 74.8 | 3.0 ; 2017 | 1,185 | 4.52 | 76.5 | 5.3 ; 2018 | 468 | 3.96 | 55.6 | 12.4 ; 2019 | 491 | 3.98 | 55.8 | 10.8 ; 2020 | 631 | 3.89 | 52.6 | 14.4 ; 2021 | 504 | 4.02 | 54.6 | 9.9 ; 2022 | 487 | 3.92 | 58.9 | 14.6 ; 2023 | 469 | 3.92 | 55.4 | 13.2 ; 2024 | 419 | 3.81 | 52.5 | 15.3 ; 2025 | 283 | 3.71 | 49.5 | 16.3 ; 2026 (to 6 Sep) | 118 | 3.29 | 36.4 | 24.6
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R23-081 — Updates praised or blamed

- **Where:** §3.1 theme table #27 Updates (praised or blamed)
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 62 (0.85%, emerging), mean 3.84, 1★ 16.1%, 5★ 56.5%
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-117 — Capacity requests by year against the cap at the time: each cap increase produces a visible drop in the complaint rate (8.76% → 5.06% around the 12-task release; 11.90% → 6.16% around the 24-task release) that then partially rebounds; the rate never goes below ~6% — raising the cap works and is never sufficient

- **Where:** §4.1 Capacity by-year table (verbatim)
- **This app does:** cap raised twice
- **User reaction:** complaint
- **Magnitude:** Year | asks-for-more | that year's n | rate | the cap at the time ; 2015 | 74 | 868 | 8.53% | 6 ; 2016 | 118 | 1,347 | 8.76% | 6 ; 2017 | 60 | 1,185 | 5.06% | 6 → 12 (Jul) ; 2018 | 57 | 468 | 12.18% | 12 ; 2019 | 55 | 491 | 11.20% | 12 ; 2020 | 72 | 631 | 11.41% | 12 ; 2021 | 60 | 504 | 11.90% | 12 → 24 (Jul) ; 2022 | 30 | 487 | 6.16% | 24 ; 2023 | 36 | 469 | 7.68% | 24 ; 2024 | 27 | 419 | 6.44% | 24 ; 2025 | 23 | 283 | 8.13% | 24 ; 2026 | 8 | 118 | 6.78% | 24 ; ratio asks:defends 5.3:1
- **Direction for us:** undecided · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-125 — Simplicity praise as a share of the period's reviews fell E1 32.30% → E2 20.80% → E3 18.36% while UI-confusion complaints rose E1 0.69% → E2 4.93% → E3 5.33% — the property that produced 1,780 positive reviews is being spent one feature at a time to answer requests from a minority

- **Where:** §4.2 Simplicity is measurable and it degrades — E1 32.30% → E2 20.80% → E3 18.36%; UI confusion E1 0.69% → E2 4.93% → E3 5.33%
- **This app does:** adds features over time (negative tasks, pages, sounds, themes, stats, timers, notes, AI)
- **User reaction:** churn
- **Magnitude:** simplicity 32.30% → 20.80% → 18.36%; UI confusion 0.69% → 4.93% → 5.33%
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R23-126 — The v3.0 update (late Jul 2017: negative tasks, second page, sounds, themes, statistics) split reviewers the same week — delighted vs alarmed ('The new UI is confusing, annoying, inefficient… all in the service of aesthetics'; 'The great thing used to be having to pare down'; 'like they dipped a pickle in chocolate'); later waves repeat it in 2022 ('Feature overload ruined core functionality'), 2023 ('adding complexity for the sake of complexity') and 2025

- **Where:** §4.2 v3.0 late July 2017 — reaction splits the same week: delighted vs alarmed at loss of simplicity
- **This app does:** feature-expansion release
- **User reaction:** mixed
- **Magnitude:** 6 delighted, 6 alarmed cited at v3.0; 5 later-wave reviews 2022–2025
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1698329281`, `1700895077`, `1702216092`, `1708201423`, `1723164061`, `1762432110`, `1699860194`, `1704290647`, `1706842643`, `1708307755`, `1244333793`, `3554375156`, `8872999798`, `9132739356`, `9522443552`, `9974958402`, `12133468213`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R23-146 — The developer communicated a migration to direct iCloud sync (including Watch) in Mar 2022; the complaint spike is the same quarter, with visible recoveries within weeks (several edited reviews upgraded after a fix) — a migration with a long, damaging tail, not a permanent break

- **Where:** §6.1 Dated context — a Q1 2022 migration to direct iCloud sync, complaint spike the same quarter, visible recoveries within weeks; a migration with a long damaging tail
- **This app does:** sync migration Q1 2022
- **User reaction:** 1★-burst
- **Magnitude:** 2022 sync complaints 60 (peak year); 5 visible recoveries
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8482253962`, `8547420011`, `8533524002`, `8545693662`, `8602070916`, `8603884304`
- **Canonical:** C030 Sync must work — and prove it; C175 Updates must not break function or wipe progress

### R23-149 — Watch failure clusters: 2016 crashes/blank on launch; watchOS 7 (Sept 2020) crashes on Series 3 (fixed — reviewer edited); 2021–22 completion state not filling/mirroring; watchOS 10 (Sept 2023) complications stop working, scrolling lags; 2024–26 blank widget/complication persists

- **Where:** §6.3 Apple Watch — dated failure clusters table (verbatim)
- **This app does:** Watch app breaks on each watchOS generation
- **User reaction:** complaint
- **Magnitude:** Period | Failure | Evidence ; 2016 | Watch app crashes / blank on launch | 1352113408, 1449725752, 1466396959 ; watchOS 7 (Sept 2020) | App crashes on Series 3 | 6441670191, 6446009730 (fixed — reviewer edited), 6440060785, 6476714883, 6542874341, 6541375195 ; 2021–22 | Completion state not filling / not mirroring | 7946379003, 8233725311, 8367240361, 8388284847, 8632520605, 8707802136, 8798302019 ; watchOS 10 (Sept 2023) | Complications stop working; scrolling lags | 10404405452, 10478388756, 10553775551, 10661343816, 10741780773, 10788221893 ; 2024–26 | Blank widget/complication persists | 10933686853, 11031307784, 11985122698, 12765977300, 13235319229, 14342620356, 13857668076, 13817900785 ; 626 mentions; 241 negative mean 3.13; 385 positive mean 4.35; explicit-bug 49 mean 2.57, 36.7% 1★
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1352113408`, `1449725752`, `1466396959`, `6441670191`, `6446009730`, `6440060785`, `6476714883`, `6542874341`, `6541375195`, `7946379003`, `8233725311`, `8367240361`, `8388284847`, `8632520605`, `8707802136`, `8798302019`, `10404405452`, `10478388756`, `10553775551`, `10661343816`, `10741780773`, `10788221893`, `10933686853`, `11031307784`, `11985122698`, `12765977300`, `13235319229`, `14342620356`, `13857668076`, `13817900785`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C031 Crashes / launch failures

### R23-152 — The interactive Today-view widget shipped Jan 2017 to enthusiastic reviews and disappeared around iOS 14 (Sept 2020); the corpus asks for it back continuously for five years — partly an Apple platform change, but a five-year gap during which it is one of the top three reasons for a downgrade from a previously-happy user

- **Where:** §6.4 Widget — interactive Today widget shipped Jan 2017 to enthusiasm, lost ~Sept 2020 (iOS 14), asked back for five years
- **This app does:** interactive widget lost at iOS 14, never restored
- **User reaction:** complaint
- **Magnitude:** 318 (4.37%) mention; 134 (42%) negative, mean 3.40; 36 ask-for-it-back reviews cited 2020–2026
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1530309387`, `1531472191`, `1531881769`, `1536414302`, `6448871007`, `6450707909`, `6455100488`, `6468889405`, `6472011768`, `6479919170`, `6497553818`, `6513983000`, `6540711760`, `6578603034`, `6612962225`, `6631801383`, `6935238940`, `6984267893`, `6997151494`, `7674489529`, `7824788952`, `7840251545`, `7988574963`, `8342488137`, `8765021191`, `9088972747`, `9096741812`, `9100003341`, `10006367703`, `10314758774`, `10755555945`, `11504358422`, `11748639117`, `11809717150`, `11837678069`, `12024208955`, `12445413324`, `13580820001`, `13909346620`, `13817900785`
- **Canonical:** C023 Interactive widget check-off; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R23-192 — Mean falls 4.56 → 4.08 → 3.83 across three eras (n ≥ 1,950 each); the themes rising in lockstep are sync (1.42% → 10.15%, 7.1×), data loss (0.33% → 4.62%, 14×) and widget bugs (0.04% → 2.10%, 52×); price is flat and capacity falls after each release — neither explains the decline

- **Where:** §9.2 Trend 1 — the rating decline is real, dated, driven by reliability [very strong]: sync 7.1×, data loss 14×, widget bugs 52×; price flat, capacity falls after each release
- **This app does:** reliability regressed post-2021
- **User reaction:** churn
- **Magnitude:** mean 4.56 → 4.08 → 3.83; sync 7.1×; data loss 14×; widget bug 52×
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change; C040 Widgets must not go blank, stale or disagree with the app

### R23-194 — The iCloud sync migration (Mar 2022) is the sharpest single event: sync complaints 25 (2021) → 60 (2022) → 40 (2023) → 24 (2024), rate 1.42% (2015–17) → 7.60% (Jan 2022 on); data loss 6 (2021) → 17 (2022) → 22 (2024); the tail is still visible in 2026

- **Where:** §9.3 Trend 2 — the iCloud sync migration is the sharpest single event [very strong]: sync 25 (2021) → 60 (2022) → 40 → 24; data loss 6 → 17 → 22 (2024); tail visible in 2026
- **This app does:** sync migration 2022
- **User reaction:** 1★-burst
- **Magnitude:** sync 25 → 60 → 40 → 24; data loss 6 → 17 → 22
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8482253962`, `13491181225`, `13319734610`, `14156559364`
- **Canonical:** C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change

### R23-195 — Capacity complaints fall after each cap release and then rebound — 8.76% (2016, cap 6) → 5.06% (2017, raised) → 12.18% (2018, cap 12) → 11.90% (2021, raised) → 6.16% (2022, cap 24) → 8.13% (2025); each release buys roughly three years

- **Where:** §9.4 Trend 3 — capacity complaints fall after each release then rebound; each release buys roughly three years [very strong]
- **This app does:** raised cap twice
- **User reaction:** complaint
- **Magnitude:** 8.76 → 5.06 → 12.18 → 11.90 → 6.16 → 8.13%
- **Direction for us:** undecided · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R23-196 — Simplicity praise fell 32.30% → 20.80% → 18.36% (a 43% relative decline) while UI-confusion complaints rose nearly 8×; reviewers date the loss to the July 2017 feature expansion

- **Where:** §9.5 Trend 4 — simplicity praise is being spent [very strong]: 43% relative decline while UI confusion rises ~8×
- **This app does:** feature accretion
- **User reaction:** churn
- **Magnitude:** 32.30 → 20.80 → 18.36%; UI confusion ~8×
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R23-199 — Monthly volume 2024–2026 fell 59 (Jan 24) → 25 (Dec 24) → 34 (Jan 25) → 12 (Dec 25) → 26 (Jan 26) → 6 (Sep 26, partial); the trailing twelve months supply 156 reviews (2.15%); 2026 is the worst year on record — mean 3.29, 24.6% 1★, 36.4% 5★ (n=118, meaningful but small)

- **Where:** §9.8 Trend 7 — the corpus is drying up [very strong]: trailing twelve months 156 reviews (2.15%); 2026 is the worst year on record (mean 3.29, 24.6% 1★, n=118)
- **This app does:** declining review volume
- **User reaction:** churn
- **Magnitude:** TTM 156 (2.15%); 2026 mean 3.29, 24.6% 1★, n=118
- **Direction for us:** none · **Report confidence:** very strong (volume); meaningful but small (2026) · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

## Positioning

### R23-001 — Streaks — The habit-forming to-do list (App Store ID 963034692) — a paid-up-front, one-time-purchase habit tracker with no subscription, no IAP and no ads; a healthy corpus (mean 4.19, 63% 5★) whose story is product limits and post-2021 reliability regression, not monetisation abuse

- **Where:** header lines 1-9; §12.4 External sources
- **This app does:** developer of record Crunchy Bagel Pty Ltd (Adelaide, Australia); bundle com.streaksapp.streak; extracted 8 Sep 2026; analysis 10 Sep 2026; store rank 23; paid-up-front one-time purchase, never free except promotions
- **User reaction:** praise
- **Magnitude:** 7,270 reviews · 93 storefronts · 1 Jun 2015 → 6 Sep 2026; mean 4.194; 5★ 4,586 (63.08%) / 4★ 1,154 (15.87%) / 3★ 538 (7.40%) / 2★ 342 (4.70%) / 1★ 650 (8.94%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-053 — The one-time model is a competitive asset, not a liability: dozens chose Streaks over a better-featured competitor because rivals were subscriptions, and an entire cohort arrived after a competitor revoked already-purchased premium features

- **Where:** §2.2 Interpretation — the pricing model is a competitive asset; a cohort arrived after a competitor revoked purchased premium features
- **This app does:** one-time purchase as the positioning against subscription rivals
- **User reaction:** purchase-driver
- **Magnitude:** 8 representative reviews; cohort event in 6957986652
- **Direction for us:** build-paid · **Report confidence:** interpretation · **Generalisable:** yes
- **Side effects:** the revocation event in report 20 (Habit — Daily Tracker, Jan 2021) is visible from the receiving side here
- **Review IDs:** `5227808774`, `6957986652`, `7271400285`, `7632443555`, `8575876614`, `10725318285`, `12642801382`, `13920320198`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C186 Never revoke what earlier buyers paid for when the model changes

### R23-100 — The most-repeated sentence pattern in the corpus is a variant of 'it does one thing and does it well' — constraint is the feature

- **Where:** §3.3 #1 Constraint as a feature — 'it does one thing and does it well'
- **This app does:** deliberately constrained
- **User reaction:** praise
- **Magnitude:** 1,780 (24.48%), mean 4.58
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `1223740791`, `1298650488`, `1421300604`, `1509068759`, `1512340737`, `1853756058`, `6819955202`, `9491330601`, `11820002198`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R23-115 — Competitors named: Momentum 14 (4.64, 'switched from'); Strides 13 (3.38, both directions — some leave to Strides over the cap); Productive 6 (4.67, 'Streaks is simpler / not a subscription'); Habitify 5 (4.20, year calendar view Streaks lacks); Habitica 3 (4.67, reward economy Streaks lacks); Apple Reminders 9 (3.67, 'Reminders does this free'); Way of Life / HabitBull / Coach.me / Lift / Done / Balanced / Haby / BlockyTime / Force of Habit ≤2 each

- **Where:** §3.5 Competitors named table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Named | n | mean ★ of those reviews | Context ; Momentum | 14 | 4.64 | Usually "I switched from" ; Strides | 13 | 3.38 | Both directions — some leave *to* Strides over the cap (6958109120) ; Productive | 6 | 4.67 | Usually "Streaks is simpler / not a subscription" (8791401709, 9827682106) ; Habitify | 5 | 4.20 | Cited for the year calendar view Streaks lacks (6494025558) ; Habitica | 3 | 4.67 | Cited for the reward economy Streaks lacks (4001139449) ; Apple Reminders (built-in) | 9 | 3.67 | The 1★ argument: "Reminders does this free" (9606373591, 11837678069) ; Way of Life / HabitBull / Coach.me / Lift / Done / Balanced / Haby / BlockyTime / Force of Habit | ≤2 each | — | 10302560850, 1757402194, 1518802719, 5054446330, 13301938915, 11926602326, 11968580277
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `6958109120`, `8791401709`, `9827682106`, `6494025558`, `4001139449`, `9606373591`, `11837678069`, `10302560850`, `1757402194`, `1518802719`, `5054446330`, `13301938915`, `11926602326`, `11968580277`
- **Canonical:** C005 Know which competitors buyers compare against

### R23-116 — The competitive frame is not other habit apps — it is Apple's own Reminders on the low end ('does this free') and subscription rivals on the high end; Streaks wins the second comparison decisively and loses the first to a specific segment

- **Where:** §3.5 Interpretation — the competitive frame is Apple Reminders below and subscription rivals above
- **This app does:** one-time paid vs free built-in vs subscription rivals
- **User reaction:** mixed
- **Magnitude:** Reminders named 9 (mean 3.67); subscription-rival switchers dozens
- **Direction for us:** do · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `9606373591`, `11837678069`
- **Canonical:** C005 Know which competitors buyers compare against; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R23-141 — 68 one-star reviews make a coherent, non-frivolous case: this is a checklist, iOS Reminders does it free, and it cost me money — a positioning failure: the listing does not set the expectation that the value is streak psychology plus HealthKit automation, not the checklist

- **Where:** §5.5 The 'no value / it's just a reminder' argument — a positioning failure, not a product failure
- **This app does:** listing sells a checklist
- **User reaction:** complaint
- **Magnitude:** 68 of 650 1★ (10.5%; 0.94% of corpus, emerging)
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1358168074`, `3606167716`, `5393057080`, `8489597297`, `11243132812`, `12687610729`, `10919386441`, `11277169610`, `12133468213`
- **Canonical:** C134 Lead the store listing with what users actually love; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Anti-patterns

### R23-008 — The UI is described as unintuitive, confusing or undiscoverable — the worst rating profile in the corpus; three actions recur: deleting a task, editing a task, and undoing an accidental completion; 'shake to undo' is named as unacceptable across a dozen markets

- **Where:** Executive summary #5 — the interface wins design awards and loses users
- **This app does:** gesture-driven, undiscoverable delete/edit/undo; shake-to-undo
- **User reaction:** complaint
- **Magnitude:** 250 reviews (3.44%, very strong), mean 2.66, 31.6% 1★
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1946127158`, `3241868349`, `3801615694`, `5374792981`, `9143311516`, `10130810601`, `11129306077`, `12074352723`, `13091898748`, `13176889519`
- **Canonical:** C075 Skippable, replayable onboarding tour; C142 Surface existing features where users look; C223 Undo / un-complete is a visible button — never a gesture-only path

### R23-066 — UI unintuitive / undiscoverable — worst rating profile

- **Where:** §3.1 theme table #12 UI unintuitive / undiscoverable
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 250 (3.44%, very strong), mean 2.66, 1★ 31.6%, 5★ 18.4%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C142 Surface existing features where users look; C223 Undo / un-complete is a visible button — never a gesture-only path

### R23-127 — All 250 UI-confusion reviews resolve into three actions: deleting a task, editing/renaming/moving a task, and undoing an accidental completion — not diffuse, not architectural

- **Where:** §4.3 Three specific interactions carry the entire UX complaint (verbatim table)
- **This app does:** gesture-hidden delete/edit; shake-only undo
- **User reaction:** complaint
- **Magnitude:** 250 (3.44%), mean 2.66; undo 77 (1.06%)
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1428576781`, `1736489826`, `3627060299`, `3813274742`, `3934184360`, `3969877398`, `4219370308`, `5503321016`, `5453294830`, `9212927813`, `13176889519`, `1347730758`, `3772828822`, `3821585068`, `3931904391`, `4515004865`, `8435327387`, `12670297933`, `13127255768`, `14243139067`
- **Canonical:** C142 Surface existing features where users look; C223 Undo / un-complete is a visible button — never a gesture-only path

## Things not to do

### R23-093 — Review-prompt nagging is a weak theme with a bad rating profile

- **Where:** §3.1 #39 Review-prompt nagging — weak but 40% 1★
- **This app does:** in-app review prompt nags
- **User reaction:** complaint
- **Magnitude:** 25 (0.34%, weak), mean 2.72, 1★ 40.0%
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R23-097 — Ads for the developer's other apps drew a handful of complaints

- **Where:** §3.1 #48 Ads for developer's other apps
- **This app does:** cross-promotes own apps
- **User reaction:** complaint
- **Magnitude:** 4 (0.06%, ignore), mean 3.00
- **Direction for us:** dont · **Report confidence:** ignore · **Generalisable:** yes
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R23-210 — Machine-translated help text is visible and expensive — German, Chinese, Russian, Swedish, Korean and Taiwanese reviewers all name it, and it lands hardest in the markets already objecting to price

- **Where:** Part 10 #10 — machine-translated help text is visible and expensive; lands hardest in markets already objecting to price
- **This app does:** machine-translated help
- **User reaction:** complaint
- **Magnitude:** 6 languages
- **Direction for us:** dont · **Report confidence:** weak but cross-market · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

## Things to do

### R23-013 — Cheapest unshipped wins in evidence order: fix iCloud/Watch sync integrity → optional capacity beyond 24 → an undo button that is not a shake gesture → record-beyond-goal / partial progress → restore an interactive widget → plain-language onboarding for delete/edit → longer history and a year view

- **Where:** Executive summary #10 — cheapest unshipped wins in evidence order
- **This app does:** none of these shipped as of Sep 2026
- **User reaction:** complaint
- **Magnitude:** report gives none (ranked list)
- **Direction for us:** do · **Report confidence:** summary ranking · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views; C023 Interactive widget check-off; C048 Flexible units / partial progress; C075 Skippable, replayable onboarding tour; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes; C223 Undo / un-complete is a visible button — never a gesture-only path; C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement

### R23-086 — Support praised (theme also catches no-response complaints)

- **Where:** §3.1 theme table #32 Support praised
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 49 (0.67%, emerging), mean 3.88, 1★ 16.3%, 5★ 57.1%
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R23-104 — Support responsiveness is praised (developer answers, fixes bring edited upgrades) but the theme also catches genuine no-response failures, which depress its mean

- **Where:** §3.3 #8 Support responsiveness — genuine praise and genuine failures
- **This app does:** developer support usually answers; some silences
- **User reaction:** mixed
- **Magnitude:** 49 (0.67%), mean 3.88
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1281532474`, `1456207719`, `3410092782`, `4899831817`, `8545693662`, `10386986461`, `11330947652`, `13295337482`, `2168151281`, `3324443697`, `6513442179`, `7429308689`, `11693785508`, `12008652692`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R23-129 — A single visible 'Edit / Delete / Undo' affordance and an in-app text explanation would address the majority of 250 reviews carrying a 2.66 mean — the gap is not architectural

- **Where:** §4.3 Interpretation — these three actions are the entire gap between 4.19 and higher; one Edit/Delete/Undo affordance plus in-app text
- **This app does:** hidden affordances
- **User reaction:** complaint
- **Magnitude:** 250 reviews, mean 2.66
- **Direction for us:** must-have · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C142 Surface existing features where users look

### R23-162 — Habit literature is an acquisition channel: 14 name Atomic Habits (mean 4.79); others name Mini Habits, The Power of Habit, Deep Work and The Power of Full Engagement

- **Where:** §7.2 Atomic Habits / habit literature — 14 name Atomic Habits (mean 4.79); Mini Habits, Power of Habit, Deep Work, Power of Full Engagement
- **This app does:** not marketed on the books
- **User reaction:** purchase-driver
- **Magnitude:** 14 Atomic Habits, mean 4.79; 4 other books
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `5482928002`, `6683980837`, `8295352711`, `8551272137`, `9594186310`, `9984193559`, `13036198091`, `13587842405`, `1496269982`, `1797731097`, `1733290107`, `1437821189`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C070 Use the language users use: Atomic Habits, 75 Hard

### R23-164 — Podcast and blog mentions (Daring Fireball, MacBreak Weekly, Do By Friday, Diary of a CEO) are a small high-satisfaction acquisition channel

- **Where:** §7.2 Podcast / blog channel — Daring Fireball, MacBreak Weekly, Do By Friday, Diary of a CEO
- **This app does:** earned media
- **User reaction:** purchase-driver
- **Magnitude:** 12, mean ~4.6
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `1390169236`, `1390723056`, `1417753375`, `1328979417`, `1783173167`, `9469351381`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R23-226 — S1: state the task cap in the App Store description — reviewers explicitly say it is not disclosed and asked for refunds on that basis

- **Where:** §11.4 S1 — state the task cap in the App Store description; reviewers say it is not disclosed and asked for refunds on that basis
- **This app does:** cap undisclosed in listing
- **User reaction:** blocked-conversion
- **Magnitude:** 4 reviews cited
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `9540311476`, `5996825854`, `12880039039`, `2277807179`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R23-227 — S2: lead the listing with the streak mechanism and HealthKit automation, not 'to-do list' — the 68 'no value / just a checklist' 1★ reviews are an expectation failure, not a product failure

- **Where:** §11.4 S2 — lead the listing with the streak mechanism + HealthKit automation, not 'to-do list'
- **This app does:** listing says to-do list
- **User reaction:** complaint
- **Magnitude:** 68 1★ (0.94%)
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C134 Lead the store listing with what users actually love; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R23-229 — S4: fix German, Chinese, Russian, Swedish and Korean help text and notification strings

- **Where:** §11.4 S4 — fix German, Chinese, Russian, Swedish and Korean help text and notification strings
- **This app does:** poor localisation
- **User reaction:** complaint
- **Magnitude:** see 8.3, 8.5, 8.9
- **Direction for us:** do · **Report confidence:** weak but cross-market · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R23-230 — S5: recognise the neurodivergent segment explicitly in the listing and in the capacity rationale — it is the fastest-growing high-satisfaction segment (0.66% → 1.90%), arrives on clinical recommendation, and its members are the ones most hurt by the cap; handle carefully: one review calls the current help-page wording ableist

- **Where:** §11.4 S5 — recognise the neurodivergent segment explicitly in the listing and in the capacity rationale; handle carefully — current help-page wording called ableist
- **This app does:** not addressed
- **User reaction:** mixed
- **Magnitude:** 0.66% → 1.90%
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `5516647636`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R23-231 — Experiment 1: capacity valve A/B — unlock pages 5–8 behind a setting for a random cohort and measure 90-day retention and rating delta against the constrained cohort; the corpus predicts the complaint falls but cannot say whether retention falls

- **Where:** §11.5 Part 11 #1 — capacity valve A/B: unlock pages 5–8 for a cohort; measure 90-day retention and rating delta
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (experiment)
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-232 — Experiment 2: onboarding rewrite — measure day-3 deletion rate against the current icon-only tutorial; the corpus predicts a large effect on the 1★ rate

- **Where:** §11.5 Part 11 #2 — onboarding rewrite: measure day-3 deletion rate against the icon-only tutorial
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (experiment)
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-233 — Experiment 3: notification copy loss-framed vs gain-framed — measure completion rate and notification-disable rate

- **Where:** §11.5 Part 11 #3 — notification copy: loss-framed vs gain-framed; measure completion and notification-disable rate
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (experiment)
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-234 — Experiment 4: partial-progress rendering — does replacing ✗ with a partial ring change 30-day retention after a missed goal?

- **Where:** §11.5 Part 11 #4 — partial-progress rendering: does replacing ✗ with a partial ring change 30-day retention after a missed goal?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (experiment)
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** — (nuance register)

## Contradictions

### R23-236 — Contradiction with the ledger's rich-market weighting: in this corpus the high-spend and high-volume storefront groups are statistically indistinguishable from each other (4.22) and only marginally better than the rest of the world (4.12) — there is no high-spend/low-spend product split; what differs by country is which complaint dominates

- **Where:** §8.8 Finding; §8.9 — contradiction with the 'weight rich English-speaking markets' assumption
- **This app does:** one-time paid app with no free tier
- **User reaction:** none
- **Magnitude:** Group A 4.22 · Group B 4.22 · rest 4.12
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** unknown
- **Conditions:** may hold only where everyone pays the same one-time price — no free tier to separate markets by conversion
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R23-237 — Contradiction with the assumption that raising the price raises the objection rate: the one-time price rose ~2.5× nominal over eleven years ($3.99 → $9.99) and the objection rate stayed flat (1.75% → 2.41% → 2.21%); objections are about feature-per-dollar and the cap, not the number

- **Where:** §2.2 / §7.4 / §9.9 — contradiction with the price-sensitivity assumption: ~2.5× price rise, flat objection rate
- **This app does:** raised one-time price ~2.5×
- **User reaction:** mixed
- **Magnitude:** objection 1.75% → 2.41% → 2.21% across a 2.5× rise
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Conditions:** one-time purchase at single-digit dollars; no subscription anchor
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R23-238 — Contradiction with the assumption that an Apple award or editorial feature is pure upside: reviews that name the award or editorial placement are the lowest-mean acquisition channel (2.53) — award traffic arrives expecting 'best app' and meets a deliberately constrained tracker

- **Where:** §7.2 — contradiction: Apple Design Award / editorial traffic is the worst-rated acquisition channel [weak, n=17]
- **This app does:** won an Apple Design Award
- **User reaction:** churn
- **Magnitude:** 17 reviews, mean 2.53
- **Direction for us:** do · **Report confidence:** weak (n=17), hypothesis · **Generalisable:** unknown
- **Review IDs:** `1400446995`, `1526417758`, `2186911032`, `3658903640`, `4651536264`, `5132838929`, `9496499610`, `9558726188`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C134 Lead the store listing with what users actually love

### R23-239 — Contradiction with the reading that simplicity is table stakes rather than a differentiator: here simplicity is the moat — the highest-volume positive theme at 24.48% (mean 4.58) — and measurably degrades as features are added (32.30% → 18.36%); constraint itself is the product

- **Where:** Executive summary #2 / §3.3 #1 — contradiction: 'simple is table stakes' vs simplicity as the moat
- **This app does:** deliberately constrained product
- **User reaction:** praise
- **Magnitude:** 1,780 (24.48%), mean 4.58; 32.30% → 20.80% → 18.36%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** holds for a paid-up-front app whose listing sells constraint; the loss appears when features are added to answer a minority
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

## Data caveats and method

### R23-002 — Method: 7,270/7,270 read in full in 30 batches, country-then-date order, original language; 50-theme multilingual regex classifier validated by reading, three over-matching patterns corrected before use (crash 138→46 because 'hang' matched inside 'changing'; price 153→123 to explicit objection wording; limit 724 split into 620 asking-for-more and 118 defending); watch/widget/sync split into mention / negative / positive subsets; corpus is front-weighted (2015–2017 = 3,400 = 46.8%; 2025–26 = 401 = 5.5%) so recent findings rest on small samples; theme rates under-count in Japanese, Korean, Chinese, Thai and Russian — country comparisons lead with rating distributions; the app changed shape three times (cap 6 → 12 in v3.0 late Jul 2017 → 24 in v7 late Jul 2021) so 'only N tasks' is the same complaint against three products; no version field; 'paid evidence' ≠ paying customers because everyone paid — Part 7 isolates people who talk about the transaction; storefront ≠ nationality ≠ language (Catalan in es, Spanish in ar, Russian/Ukrainian in hr/pl); no download/revenue/retention data; rating is not a feature preference (457 of 620 capacity requests are 4–5★); signal bands <0.1% ignore … >5% high-priority

- **Where:** How to read this; Six warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations; §12.1 counting rules; §12.3 validation
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 7,270/7,270; 93 storefronts; 0 empty bodies; 2 duplicate title+body groups (6 records) kept; is_edited 12 (several are visible upgrades after a developer fix); 1,221 (16.80%) with community votes; 21 storefronts ≥50 = 6,689 (92.01%)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-015 — Rating distribution table

- **Where:** §1.6 Corpus composition — ratings table (verbatim)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Rating | n | % ; 5★ | 4,586 | 63.08% ; 4★ | 1,154 | 15.87% ; 3★ | 538 | 7.40% ; 2★ | 342 | 4.70% ; 1★ | 650 | 8.94% ; Mean |  | 4.194
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-018 — The community-endorsement ranking is dominated by feature requests from satisfied 5★ users; the top two (313 and 231 net votes, both cn) are about recording effort the binary model discards — an independent signal for Part 4.4

- **Where:** §1.6 Most community-endorsed reviews table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** net votes | ID | cc | ★ | date | what it asks for ; 313 | 9145507788 | cn | 5 | 2022-10-03 | count-up timer + record progress beyond goal ; 231 | 3372029447 | cn | 5 | 2018-11-02 | connect consecutive completed days visually ; 169 | 2100236937 | au | 5 | 2018-01-18 | (pure endorsement — "seriously motivating") ; 131 | 3721242401 | it | 4 | 2019-02-01 | (endorsement + Health/Watch praise) ; 126 | 8642992805 | cn | 5 | 2022-05-06 | a habit with a floor but no ceiling ; 87 | 3524837176 | cn | 4 | 2018-12-13 | notes / reflection on each completion ; 80 | 2056232018 | cn | 5 | 2018-01-04 | longer cycles (fortnightly, monthly, bimonthly) ; 80 | 2429989150 | tr | 5 | 2018-04-16 | (endorsement) ; 74 | 6592885718 | fr | 5 | 2020-10-31 | (endorsement) ; 67 | 4899831817 | de | 5 | 2019-10-06 | (praises support responsiveness) ; 66 | 3225476511 | us | 3 | 2018-09-24 | plain-language in-app instructions ; 52 | 1933748530 | cn | 4 | 2017-11-20 | fix the machine-translated Chinese help text
- **Direction for us:** undecided · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `9145507788`, `3372029447`, `2100236937`, `3721242401`, `8642992805`, `3524837176`, `2056232018`, `2429989150`, `6592885718`, `4899831817`, `3225476511`, `1933748530`
- **Canonical:** C048 Flexible units / partial progress

### R23-022 — Feature inventory attested in reviews, with earliest/latest IDs — everything is behind the one-time price

- **Where:** §2.1 Feature inventory table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence | Notes ; Up to N habit "tasks" as press-and-hold circles | 1207369743 → 14519191137 | N = 6 (2015–Jul 2017), 12 (Jul 2017–Jul 2021), 24 (Jul 2021–) ; Pages/boards of 6 tasks each, colour-themed | 1702122919, 7693289034, 8299170626 | 1 page → 2 → 4 ; Press-and-hold to complete (haptic + sound) | 1233132153, 1565085180, 11414032824 | Deliberately *not* a tap; praised and criticised ; "Today or yesterday?" retroactive completion | 1219787545, 1276619599, 11525453355 | Added early; toggleable later ; Calendar view + retroactive edit of history | 1341315616, 1342117011, 11525453355 | Added ~March 2016 ; Per-task custom reminder times; "smart" auto reminders | 1276150206, 1535900378, 13111371180 | Timing algorithm widely disliked (Part 6.7) ; App badge count of outstanding tasks, with active-hours window | 1276454729, 5393033193 | Named as the core motivator by many ; Apple HealthKit read (steps, flights, weight, sleep, mindful minutes, workouts, water, calories) | 1212736010, 1457370530, 9466989950 | Auto-completes tasks ; Apple Watch app + complications | 1223650339, 1261995475, 13857668076 | Present since watchOS 2 (2015) ; Today-view widget (interactive) | 1530309387 (Jan 2017) | Removed ~Sept 2020 ; Home/Lock-screen widgets (non-interactive) | 6442941072, 12159511186 | iOS 14+ ; Negative ("don't") tasks | 1698660564, 1727430072, 4088195832 | Added v3.0, Jul 2017 ; Times-per-day / times-per-week / times-per-month scheduling | 1295254379, 2641215473, 9405395737 | Yearly still absent (Part 4.5) ; Timed tasks + built-in Pomodoro | 3225476511, 6332134320, 8631830521 | Pomodoro break cycle reported broken 2022 ; Statistics: streak, best, 7-day, 30-day, all-time, graphs | 1698329281, 3627186417, 9594705817 | History depth complained of (Part 4.5) ; CSV export | 1268393434, 1313240975, 8790139019 | ; iCloud sync across iPhone / iPad / Watch / Mac | 3240963794 (Sept 2018) → 13491181225 | Mac app is a separate purchase in some periods ; Siri Shortcuts / URL actions / NFC | 1345417377, 3206247831, 9827682106 | Power-user favourite ; Custom app icon + theme colours | 1704396672, 1841745643, 12480462420 | Distinctive; frequently cited as a delight ; Archive / pause tasks | 6565948711, 8266328218, 12490481767 | Pause-breaks-streak bug reported 10656649260, 10772984090, 11138802961 ; Per-completion notes | 9681201325 (Mar 2023) | Long-requested (Part 4.5); shipped ~2023 ; Task sharing / accountability partner | 9210832228, 11023193240, 10201893958 | Weak/one-way per 10201893958, 14513963633 ; Family Sharing | 1925820330, 9367716405 | ; macOS app | 5894140234, 8319272939, 12530776051 | Separately purchased at times (6674999158, 6947..., 6647868915) ; "Break It Down" AI step generation | 14069398191 (May 2026) | Only mention in corpus; the reviewer asks for it to be removed ; Medication tracker | 13180845529 (Sep 2025) | Only mention in corpus
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-046 — Monetisation table

- **Where:** §2.2 Monetisation model table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Aspect | What the corpus shows ; Model | Paid up-front, one-time. No subscription, no consumable IAP, no ads. 398 reviews (5.47%) name this explicitly as a reason to buy. ; Everything behind the price | Every feature. There is no free tier and no premium tier in this corpus. A handful of reviewers wrongly believed it was free (10028224650, 7641339972, 8274159929) — these are promo redemptions or confusion. ; Free acquisition promo | Starbucks "Pick of the Week", 2015–2016: 13 reviews (0.18%, weak) name it, mean 4.62 (1276154024, 1305108155, 1311263979, 1313390731, 1343836916, 1374387287, 1389903668, 1391137306, 12871227227). One of these, 12871227227, is still using the app in July 2025 — a ten-year retention from a free promo. ; Bundle | Streaks + Streaks Workout (+ HealthFace) sold as a bundle: 1519665903, 2130326760, 7992811619, 10781985066. ; Mac app | Reported as a separate purchase in 2020–2021 (6674999158, 6647868915, 6853278337, 7723975238, 5960818396, 5924527558), then as included in the universal purchase from late 2021 (8094189480, 9007693160, 9443737606). This is a real, dated model change. ; Named price ladder (from review text) | 2015–16: $3.99 / £2.99 / €3.99 / ¥15–18 / ₽15 · 2017–21: $4.99–5.99 / £4.99 / €5.49 / ¥25–30 / ₩5,900 / ₺14 / ₹250 / A$7.99 · 2022–24: $7.99–8 / €6 / CA$9–10 / R$25 · 2025–26: $9.99–10 / £6 / A$9.99 / €6. Sources: 1209935398, 1223253220, 1312829048, 1697..., 1695..., 1863150756, 1821681612, 3674856943, 5190340051, 9608304681, 11438051593, 12868795563, 12687610729, 13288491780, 14469956788. ; Rough magnitude | ~2.5× nominal price increase 2015→2026, with no rise in the price-objection rate (E1 1.75% → E3 2.21%). ; Refund friction | 79 reviews (1.09%) mention refunds, mean 1.75, 70.9% of them 1★. Apple, not the developer, controls this; several reviewers are addressing Apple through the review field (11474891367, 11478493003, 9789072827, 10238906445). ; Accidental purchase | 6 reviews (0.08%, ignore-by-default) describe buying by mistake — 4 kr, 2 cn (1949276046, 2310465385, 5759175647, 6723289341, 6731172815, 7538677717). Below threshold; recorded because it clusters.
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-052 — Accidental purchases are below threshold but cluster geographically (4 Korea, 2 China)

- **Where:** §2.2 Accidental purchase — 6 reviews, 4 kr 2 cn, below threshold but clusters
- **This app does:** paid-up-front buy-by-mistake
- **User reaction:** complaint
- **Magnitude:** 6 (0.08%, ignore-by-default)
- **Direction for us:** research · **Report confidence:** below threshold · **Generalisable:** yes
- **Review IDs:** `1949276046`, `2310465385`, `5759175647`, `6723289341`, `6731172815`, `7538677717`
- **Canonical:** C063 Free trial before purchase

### R23-054 — Master theme table, 49 themes, denominator 7,270

- **Where:** §3.1 Complete ranked theme table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | n | % | Signal | mean ★ | 1★ % | 5★ % ; 1 | Simplicity / minimalism praised | 1,780 | 24.48% | high-priority | 4.58 | 3.1 | 76.9 ; 2 | Design / beauty praised | 945 | 13.00% | high-priority | 4.38 | 4.2 | 68.1 ; 3 | Streak motivation / accountability works | 902 | 12.41% | high-priority | 4.75 | 0.7 | 81.2 ; 4 | "It works" / changed my behaviour | 762 | 10.48% | high-priority | 4.77 | 1.0 | 84.1 ; 5 | Apple Watch mentioned | 626 | 8.61% | high-priority | 3.88 | 12.1 | 52.7 ; 6 | Capacity: asks for more tasks/pages | 620 | 8.53% | high-priority | 3.96 | 6.9 | 40.3 ; 7 | One-time purchase / no subscription praised | 398 | 5.47% | high-priority | 4.43 | 4.8 | 71.4 ; 8 | Sync mentioned | 348 | 4.79% | very strong | 3.51 | 16.1 | 37.9 ; 9 | Customisation (icons, colours, app icon) praised | 324 | 4.46% | very strong | 4.51 | 1.9 | 69.8 ; 10 | Widget mentioned | 318 | 4.37% | very strong | 3.84 | 8.2 | 42.1 ; 11 | Apple Health integration praised | 277 | 3.81% | very strong | 4.35 | 5.4 | 66.8 ; 12 | UI unintuitive / undiscoverable | 250 | 3.44% | very strong | 2.66 | 31.6 | 18.4 ; 13 | Sync — complaint-framed | 223 | 3.07% | very strong | 3.08 | 23.3 | — ; 14 | Rewards / badges / gamification requested | 136 | 1.87% | meaningful | 4.43 | 1.5 | 61.8 ; 15 | Price objection | 123 | 1.69% | meaningful | 2.21 | 50.4 | 13.8 ; 16 | Capacity limit defended as a feature | 118 | 1.62% | meaningful | 4.22 | 5.9 | 57.6 ; 17 | Multiple-times-per-day / partial increments | 111 | 1.53% | meaningful | 3.90 | 2.7 | 37.8 ; 18 | Frequency flexibility (weekly/monthly/yearly/every-N) | 101 | 1.39% | meaningful | 4.06 | 5.0 | 45.5 ; 19 | Notifications broken / mistimed / annoying | 97 | 1.33% | meaningful | 3.48 | 18.6 | 38.1 ; 20 | Data loss | 81 | 1.11% | meaningful | 2.17 | 45.7 | — ; 21 | Refund requested / billing confusion | 79 | 1.09% | meaningful | 1.75 | 70.9 | 13.9 ; 22 | Undo / unmark impossible | 77 | 1.06% | meaningful | 3.38 | 14.3 | 32.5 ; 23 | Record beyond goal / partial progress | 77 | 1.06% | meaningful | 4.00 | 3.9 | 39.0 ; 24 | Backfill older days | 76 | 1.05% | meaningful | 3.75 | 9.2 | 40.8 ; 25 | ADHD / autism / mental-health use | 73 | 1.00% | meaningful | 4.45 | 5.5 | 68.5 ; 26 | Siri / Shortcuts / automation | 72 | 0.99% | emerging | 3.94 | 9.7 | 55.6 ; 27 | Updates (praised or blamed) | 62 | 0.85% | emerging | 3.84 | 16.1 | 56.5 ; 28 | Widget — bug / regression | 57 | 0.78% | emerging | 3.16 | 12.3 | 17.5 ; 29 | Archive / pause / vacation mode | 57 | 0.78% | emerging | 3.89 | 5.3 | 42.1 ; 30 | Day-boundary / midnight reset | 54 | 0.74% | emerging | 4.02 | 3.7 | 44.4 ; 31 | More / custom icons | 54 | 0.74% | emerging | 4.20 | 1.9 | 53.7 ; 32 | Support praised | 49 | 0.67% | emerging | 3.88 | 16.3 | 57.1 ; 33 | Watch — explicit bug wording | 49 | 0.67% | emerging | 2.57 | 36.7 | 20.4 ; 34 | Statistics depth / year view | 46 | 0.63% | emerging | 3.93 | 6.5 | 50.0 ; 35 | Crash / freeze / won't open | 46 | 0.63% | emerging | 2.80 | 34.8 | 26.1 ; 36 | List view / more per page / smaller icons | 45 | 0.62% | emerging | 3.56 | 8.9 | 24.4 ; 37 | Notes / journal per completion | 43 | 0.59% | emerging | 4.00 | 11.6 | 51.2 ; 38 | Social / sharing / accountability partner | 28 | 0.39% | weak | 4.07 | 10.7 | 42.9 ; 39 | Review-prompt nagging | 25 | 0.34% | weak | 2.72 | 40.0 | 32.0 ; 40 | Accessibility / VoiceOver | 19 | 0.26% | weak | 3.79 | 15.8 | 52.6 ; 41 | End-date / long-term goal | 17 | 0.23% | weak | 4.76 | 0.0 | 76.5 ; 42 | Localisation / translation quality | 16 | 0.22% | weak | 3.38 | 12.5 | 25.0 ; 43 | No free trial | 15 | 0.21% | weak | 2.40 | 40.0 | 13.3 ; 44 | Auto-completing without user action | 11 | 0.15% | weak | 3.00 | 27.3 | 27.3 ; 45 | Health data not syncing / miscounting | 9 | 0.12% | weak | 3.78 | 11.1 | 33.3 ; 46 | iPad layout not optimised | 8 | 0.11% | weak | 4.25 | 0.0 | 50.0 ; 47 | Battery drain / device heat | 4 | 0.06% | ignore | 2.00 | 50.0 | 0.0 ; 48 | Ads for developer's other apps | 4 | 0.06% | ignore | 3.00 | 50.0 | 50.0 ; 49 | Mac charged separately | 1* | 0.01% | ignore | — | — | —
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-092 — Weak and ignore-band themes: social/accountability partner 28 (0.39%, mean 4.07); review-prompt nagging 25 (0.34%, mean 2.72, 40% 1★); accessibility/VoiceOver 19 (0.26%, mean 3.79); end-date/long-term goal 17 (0.23%, mean 4.76, 0% 1★); localisation/translation quality 16 (0.22%, mean 3.38); no free trial 15 (0.21%, mean 2.40, 40% 1★); auto-completing without user action 11 (0.15%, mean 3.00); Health data not syncing/miscounting 9 (0.12%, mean 3.78); iPad layout not optimised 8 (0.11%, mean 4.25); battery drain/device heat 4 (0.06%, mean 2.00); ads for developer's other apps 4 (0.06%, mean 3.00)

- **Where:** §3.1 theme table #38–#48 weak/ignore rows
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 11 weak/ignore rows as listed
- **Direction for us:** none · **Report confidence:** weak/ignore · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-098 — Worst-rating-profile themes: refund 79 (1.75, 70.9% 1★ — Korea/China accidental or expectation-mismatch purchases); price objection 123 (2.21, 50.4% — AU/CA/DE and the 'just a checklist' argument, not the level); data loss 81 (2.17, 45.7% — the only theme that destroys a long-tenure customer outright); UI unintuitive 250 (2.66, 31.6% — the largest destroyer of new customers, kills before day 3); Watch bug 49 (2.57, 36.7% — kills the customers who bought for the Watch)

- **Where:** §3.2 Five findings with the worst rating profile (verbatim table)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Theme | n | mean ★ | 1★ share | Read ; Refund requested | 79 | 1.75 | 70.9% | Mostly Korea/China accidental or mismatch-of-expectation purchases; a small, geographically concentrated leak. ; Price objection | 123 | 2.21 | 50.4% | Concentrated in AU/CA/DE and in the "it's just a checklist" argument, not in the price *level*. ; Data loss | 81 | 2.17 | 45.7% | The only theme in the corpus that destroys a long-tenure customer outright. ; UI unintuitive | 250 | 2.66 | 31.6% | The largest destroyer of *new* customers. Kills before day 3. ; Watch bug (explicit) | 49 | 2.57 | 36.7% | Kills the customers who bought the app *for* the Watch.
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R23-105 — Unmet needs (never-existed requests) separated from bugs

- **Where:** §3.4 Unmet needs table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Request | n | % | Signal | Evidence ; More tasks / pages beyond the current cap | 620 | 8.53% | high-priority | 1210218319, 2118562647, 5996825854, 6094260232, 9405934613, 13458083376, 13604525915 ; Rewards, badges, milestones, levels | 136 | 1.87% | meaningful | 1210125866, 1509518865, 1523739770, 3720818929, 4001139449, 8657817540, 9466333042 ; Multiple-per-day / partial increments (originally) | 111 | 1.53% | meaningful | 1265283854, 1298183337, 1389005299, 1949109997, 5852474728 — *largely shipped 2016; residual complaints are about partial-progress display* ; Frequency flexibility (yearly, every-N-weeks, specific dates) | 101 | 1.39% | meaningful | 1397447028, 2056232018, 3596141272, 9405395737, 10397702118, 11315859157, 12537226420, 14320549167 ; Record beyond goal / show partial progress | 77 | 1.06% | meaningful | 1230386714, 8642992805, 9145507788, 9592238918, 11936906855, 12209604326, 13566507177, 14106848070 ; Notes / journal per completion | 43 | 0.59% | emerging | 1233211017, 3524837176, 5856256123, 8267273982, 9721628471 — *shipped ~2023; 13439093120 asks for note navigation* ; List view / density control | 45 | 0.62% | emerging | 1277986745, 4179487203, 8299170626, 10475031837, 11548743644, 13528143060, 14156553445 ; Longer history / year heat-map | 46 | 0.63% | emerging | 1298..., 1384736153, 3911574614, 9579170708, 10796378002, 13611043861, 13647744905, 13991866349 ; Social / accountability partner | 28 | 0.39% | weak | 1210438949, 3634054860, 6893100721, 8009347972, 9210832228, 14513963633 ; End-date / countdown / long-term goal | 17 | 0.23% | weak | 2190673897, 3219243457, 5234693852, 7442733954, 11136317227
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-114 — The report separates bugs (sync, Watch complications, widgets, notifications, pause-resets-streak, timers, crash-on-launch) from unmet needs and analyses them in Part 6

- **Where:** §3.4 Broken things are bugs, not unmet needs — sync, Watch, widgets, notifications, pause, timers, crash
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (taxonomy note)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-135 — What 5★ reviewers say, denominator 4,586

- **Where:** §5.1 5★ drivers table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Driver | n | % of 5★ | IDs ; Simplicity / minimalism | 1,368 | 29.8% | 1258150191, 1512340737, 6023179036, 9412936687, 12417692392 ; Streak motivation | 732 | 16.0% | 1272281889, 1421095517, 6560669097, 9109199642, 12480165426 ; Design / beauty | 644 | 14.0% | 1298436176, 1501407454, 3797909975, 9736813561, 13830764814 ; "It works" / behaviour changed | 641 | 14.0% | 1417122973, 1829003380, 5633516312, 9504519839, 13762496717 ; Apple Watch | 330 | 7.2% | 1264562226, 1536186077, 3546399508, 9673544391 ; Asks for more capacity anyway | 250 | 5.5% | 1210218319, 2008517387, 5946603412, 9474096582, 12231562082 ; One-time / no subscription | 284 | 6.2% | 3650471870, 7632443555, 10665322346, 13920320198 ; Customisation | 226 | 4.9% | 1704396672, 1819984390, 8241888458 ; Health integration | 185 | 4.0% | 1458766203, 3927825569, 12539768742 ; Mentions sync (mostly as a caveat) | 132 | 2.9% | 7461351458, 8639765578, 8746727569, 10511894011 ; "Changed my life" verbatim | 133 | 2.9% | 1712133587, 2307688610, 8532802290, 9775572407, 12547475151 ; Gold-theme completion state | 80 | 1.7% | 1457647167, 5578733348, 11813889503
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `1258150191`, `1272281889`, `1298436176`, `1417122973`, `1264562226`, `1210218319`, `3650471870`, `1704396672`, `1458766203`, `7461351458`, `1712133587`, `1457647167`
- **Canonical:** — (nuance register)

### R23-140 — What drives 1★, denominator 650

- **Where:** §5.5 1★ drivers table (verbatim)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Driver | n | % of 1★ | % of corpus | IDs ; Mentions sync or Apple Watch (mostly failure) | 100 | 15.4% | 1.38% | 1823336677, 1869849987, 5132838929, 5982716099, 7429308689, 8378091564, 10788221893, 12697390401 ; "No value / it's just a reminder" | 68 | 10.5% | 0.94% | 1358168074, 3606167716, 5132838929, 10919386441, 11277169610, 12133468213, 12687610729 ; UI confusing / can't operate | 63 | 9.7% | 0.87% | 1772778535, 3317081904, 3339756991, 12001043575, 12377981887, 13940202198 ; Price / not worth it | 62 | 9.5% | 0.85% | 1213415787, 1358168074, 3606167716, 3979151493, 4592779297, 7199898184, 10383442127 ; Notifications broken / intrusive | 50 | 7.7% | 0.69% | 1369851749, 1384399238, 3658903640, 5846397266, 9606373591, 12696000566 ; Refund request | 49 | 7.5% | 0.67% | 1228688696, 1315739671, 1844808692, 5846397266, 7174509755, 11450516665, 12692528270 ; Capacity cap | 43 | 6.6% | 0.59% | 1213415787, 1222021317, 2118562647, 3463334680, 3652626817, 7060873731, 9540311476 ; Data loss | 29 | 4.5% | 0.40% | 1869849987, 5656583902, 8539670819, 8646756790, 8789907313, 11200491931, 11379255315, 13404336916 ; Widget broken | 21 | 3.2% | 0.29% | 1756115186, 6984267893, 6995147748, 9387245377, 9618815433, 11300138584, 13684634678 ; Crash / won't open | 16 | 2.5% | 0.22% | 2045708512, 2304429841, 2378622100, 6473643467, 9198217952
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `1823336677`, `1869849987`, `5132838929`, `5982716099`, `7429308689`, `8378091564`, `10788221893`, `12697390401`, `1772778535`, `3317081904`, `3339756991`, `12001043575`, `12377981887`, `13940202198`, `1213415787`, `3979151493`, `4592779297`, `7199898184`, `10383442127`, `1369851749`, `1384399238`, `3658903640`, `5846397266`, `12696000566`, `1228688696`, `1315739671`, `1844808692`, `7174509755`, `11450516665`, `12692528270`, `1222021317`, `3463334680`, `7060873731`, `9540311476`, `5656583902`, `8539670819`, `8789907313`, `11200491931`, `11379255315`, `13404336916`, `1756115186`, `6984267893`, `6995147748`, `9387245377`, `9618815433`, `11300138584`, `13684634678`, `2045708512`, `2304429841`, `2378622100`, `6473643467`, `9198217952`
- **Canonical:** — (nuance register)

### R23-142 — Capacity (40.3% 5★ / 6.9% 1★) is a request not a grievance; Watch (52.7/12.1) and widget (42.1/8.2) are bimodal — the best and worst experiences share a surface; sync (37.9/16.1) tilts negative but many 5★ flag it as a caveat; rewards (61.8/1.5) and record-beyond-goal (39.0/3.9) are purely aspirational from fans; UI confusion (18.4/31.6), price objection (13.8/50.4) and refund (13.9/70.9) are almost purely destructive

- **Where:** §5.6 Themes that cut across the rating line (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 5★ share of its reviews | 1★ share | Read ; Capacity | 40.3% | 6.9% | A request, not a grievance ; Apple Watch | 52.7% | 12.1% | Bimodal — the best and worst experiences share a surface ; Widget | 42.1% | 8.2% | Same ; Sync | 37.9% | 16.1% | Tilts negative but many 5★ users flag it as a caveat ; Rewards wanted | 61.8% | 1.5% | Purely aspirational; from fans ; Record-beyond-goal | 39.0% | 3.9% | Purely aspirational; from fans ; UI confusion | 18.4% | 31.6% | Almost purely destructive ; Price objection | 13.8% | 50.4% | Almost purely destructive ; Refund | 13.9% | 70.9% | Purely destructive
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-151 — One reviewer says support implied they don't have an Apple Watch for testing — unverifiable, but if even partly accurate it explains the multi-year persistence of the Watch pattern

- **Where:** §6.3 Support quote — 'inferring they don't have an Apple Watch for testing'
- **This app does:** possible lack of device testing
- **User reaction:** complaint
- **Magnitude:** 1 review (gb, 2★, Nov 2024)
- **Direction for us:** must-never-break · **Report confidence:** single review, unverifiable · **Generalisable:** yes
- **Review IDs:** `12008652692`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R23-159 — Every reviewer paid or redeemed a promo — no free tier, trial, upgrade path or subscription; the useful segmentation is reviewers who explicitly discuss the transaction versus everyone else, and talking about money in a paid-app review signals dissonance (unusual satisfaction or regret), not a payment problem

- **Where:** §7.1 Framing — everyone paid; the useful split is transaction-discussing reviewers (735, mean 3.52) vs everyone else (mean 4.27); the gap is dissonance, not a payment problem
- **This app does:** paid-only
- **User reaction:** mixed
- **Magnitude:** 735 (10.11%), mean 3.52 vs 6,535, mean 4.27 — 0.75-point gap
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R23-165 — Within the 735 transaction-discussing reviews: simplicity 173 (23.5%), design 137 (18.6%), price objection 115 (15.6% vs 2.10% global broad regex), no subscription 102 (13.9%), capacity 96 (13.1%), Watch 80 (10.9%), refund 54 (7.3% vs 1.09% global)

- **Where:** §7.3 What buyers value once they've paid (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | n | % of segment | global n | global % ; Simplicity | 173 | 23.5% | 1,780 | 24.48% ; Design | 137 | 18.6% | 945 | 13.00% ; Price objection | 115 | 15.6% | 153* | 2.10% ; No subscription | 102 | 13.9% | 398 | 5.47% ; Capacity request | 96 | 13.1% | 620 | 8.53% ; Watch | 80 | 10.9% | 626 | 8.61% ; Refund | 54 | 7.3% | 79 | 1.09%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R23-172 — Nothing in the corpus supports a claim of deceptive billing: the developer takes one payment through Apple, and the refund friction reviewers describe is Apple's process — several reviewers say so

- **Where:** §7.5 Nothing supports a claim of deceptive billing — one payment through Apple; refund friction is Apple's process
- **This app does:** single Apple payment
- **User reaction:** none
- **Magnitude:** report gives none (non-claim)
- **Direction for us:** none · **Report confidence:** non-claim · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right

### R23-173 — 21 storefronts clear the 50-review threshold (6,689, 92.01%); the other 72 (581, 7.99%) are in global numbers but standalone claims are labelled limited evidence

- **Where:** §8.1 Eligibility — 21 storefronts ≥50 reviews = 92.01%; 72 sub-50 storefronts 581 reviews (7.99%) labelled limited evidence
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 21 / 6,689 (92.01%); 72 / 581 (7.99%)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-191 — Trend method: calendar year and product era, cut at the two capacity releases reviewers themselves date — E1 1 Jun 2015–24 Jul 2017 (6 tasks, n=2,743, 37.7%), E2 25 Jul 2017–27 Jul 2021 (12 tasks, n=2,577, 35.4%), E3 28 Jul 2021–6 Sep 2026 (24 tasks, n=1,950, 26.8%); era boundaries inferred from review text, not metadata; every per-era metric carried verbatim

- **Where:** §9.1 Method — two lenses: calendar year and product era cut at the two capacity releases (E1 6 tasks n=2,743; E2 12 tasks n=2,577; E3 24 tasks n=1,950); era table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n | 2,743 | 2,577 | 1,950 ; Mean rating | 4.56 | 4.08 | 3.83 ; 5★ | 73.1% | 59.5% | 53.7% ; 1★ | 3.2% | 10.5% | 15.0% ; Simplicity praised | 32.30% | 20.80% | 18.36% ; UI confusion | 0.69% | 4.93% | 5.33% ; Capacity request | 10.72% | 11.80% | 6.46% ; Sync mention | 1.42% | 4.31% | 10.15% ; Data loss | 0.33% | 1.40% | 4.62% ; Widget bug | 0.04% | 0.58% | 2.10% ; Crash | 1.31% | 2.25% | 2.26% ; Watch mention | 6.71% | 9.55% | 10.05% ; Price objection | 1.75% | 2.41% | 2.21% ; One-time praised | 3.61% | 5.55% | 8.00% ; Refund | 0.44% | 1.24% | 1.79% ; ADHD / neurodivergent | 0.66% | 0.70% | 1.90% ; Notifications | 0.98% | 1.82% | 1.18%
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Review IDs:** `1698329281`, `1702122919`, `1706205633`, `7636542975`, `7641339972`, `7668026683`, `7693289034`, `7713133373`
- **Canonical:** — (nuance register)

### R23-193 — Confounder acknowledged: the 2017 review-prompt API change mechanically reduced low-effort 5★ reviews across all apps (volume 1,185 in 2017 → 468 in 2018), so part of the 2017→2018 step is a platform artefact — but the 2021→2026 continuation is not: volume is roughly flat 2021–2023 while the mean keeps falling and sync/data-loss keeps rising

- **Where:** §9.2 Confounder — the 2017 App Store review-prompt API change reduced low-effort 5★ volume (1,185 → 468); part of the 2017→2018 step is a platform artefact, but the 2021→2026 continuation is not
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 2017 1,185 → 2018 468
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R23-200 — Trends not claimed: no pricing-damage trend (objections flat across a 2.5× rise); no monetisation-abuse trend (no subscription, paywall shift or revocation in 7,270 reviews); no AI trend (one review, asking for removal); no support-collapse trend (praise 49 and failures appear across all eras without direction); no competitor-displacement trend (≤14 mentions each)

- **Where:** §9.9 Trends explicitly NOT claimed — no pricing-damage, monetisation-abuse, AI, support-collapse or competitor-displacement trend
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (non-claims)
- **Direction for us:** none · **Report confidence:** non-claim · **Generalisable:** yes
- **Review IDs:** `14069398191`, `2168151281`, `3324443697`, `6513442179`, `7429308689`, `10450266476`, `11693785508`, `12008652692`
- **Canonical:** — (nuance register)

### R23-235 — Open research questions: what fraction of buyers never review; actual retention and whether the cap raises or lowers it; how many refunds were granted; whether the 2017 and 2021 capacity releases moved revenue or only sentiment; whether the 2022 sync spike is a code regression or an iOS/CloudKit platform change; whether the Apple Design Award still drives installs and at what quality

- **Where:** §11.6 Research questions this corpus cannot answer
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (questions)
- **Direction for us:** research · **Report confidence:** open questions · **Generalisable:** yes
- **Canonical:** — (nuance register)
