# Cards — report 56

Source: `App Store Reports/56. Dots - Habit Tracker Widget - Daily Routine, Goal & Planner (REPORT).md`  
76 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 5
- [Must-haves](#must-haves) — 1
- [Must never break](#must-never-break) — 7
- [Features](#features) — 11
- [Monetization](#monetization) — 4
- [Tactics the app used](#tactics-the-app-used) — 4
- [Insights (the why)](#insights-the-why) — 12
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 7
- [Dated events and trends](#dated-events-and-trends) — 6
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 9

## Product rules

### R56-012 — Simplicity and restraint 39 (58.21%, dominant, 4.92), from the first review to the last and consistent across storefronts (US 54.2%, rest 60.5%) — reviewers praise absence, not features: 'Great app that knows what it wants to do and does exactly that and nothing more' (DE); 'i like that dots does not try to do so much' (US); 'Dots stuck because it doesn't try to do too much… zero bloat' (US); 'no ads or unnecessary features'; 'track their habits without the faff' (GB); 'I lose interest in things if they're too complicated… This was pleasantly straight forward' (US — complexity makes this user abandon trackers); 'its simplicity is its greatest strength, it's impossible to get lost' — simplicity is the retention feature, and every request in the backlog is a request to add something that 39 reviewers pre-emptively vote against

- **Where:** §3.3.1
- **This app does:** minimal feature set
- **User reaction:** praise
- **Magnitude:** 39 (58.21%, 4.92)
- **Direction for us:** product-rule · **Report confidence:** dominant · **Generalisable:** generalisable
- **Review IDs:** `14122888123`, `14148473814`, `13853268363`, `14428584045`, `14472221855`, `14440814553`, `14401566211`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R56-022 — No account, no sign-in wall, no onboarding questionnaire — named as the reason users switched: 'I tried a couple of them on the App Store and hated them immediately. They usually ask 20 questions just to get started' (US); 'no sign-in wall' (US)

- **Where:** §3.3.9 P_NOSIGNUP; §8.5
- **This app does:** no account, no onboarding quiz
- **User reaction:** praise
- **Magnitude:** 2 (2.99%)
- **Direction for us:** product-rule · **Report confidence:** corroborated · **Generalisable:** generalisable
- **Review IDs:** `13853268363`, `14504042664`
- **Canonical:** C209 No sign-up wall before first use

### R56-043 — Upgrade barriers — the inverse finding: 35 of 67 (52.24%) volunteered praise for the absence of monetisation, and for 9 a competitor's monetisation is why they are here; introducing a paywall over any currently-free capability — unlimited habits, widgets, all view formats, no ads — would contradict the promise that produced half the positive sentiment

- **Where:** §5.3
- **This app does:** fully free
- **User reaction:** praise
- **Magnitude:** 35 (52.24%); 9 competitor-paywall
- **Direction for us:** product-rule · **Report confidence:** dominant · **Generalisable:** generalisable
- **Canonical:** C001 Never move a free feature behind the paywall

### R56-066 — D2: do not paywall anything that is free today — 35 (52.24%) praised the absence of monetisation, 9 (13.43%) name a competitor's paywall as the reason they left; the four capabilities praised as free-unlike-competitors are unlimited habits, widgets, all view formats and no ads; the appeal is flat across high-spend and other markets (47.1% vs 43.8%), so it cannot be paywalled in rich storefronts; 'a statement about acquisition mechanics, not about virtue' — search-end reviewers (15, rising) are actively shopping and rejecting paid options, and a paywall would remove the reason they stopped shopping; it does not say Dots cannot be monetised, only that paywalling existing free capability attacks the documented acquisition path

- **Where:** §8.2 D2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 35 (52.24%); 9 (13.43%)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14151336984`, `14392368857`, `14109432526`, `14148473814`, `14472221855`, `14400919999`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R56-073 — What not to change (verbatim): do not add an onboarding questionnaire or account wall ('20 questions just to get started'; 'no sign-in wall'); do not add ads (9; 'instantly' delete apps over ads); do not cap the habit count (4 name unlimited, 3 left competitors over caps); do not gate widgets, views or reminders; do not add streak pressure, scores or gamification (only 1 asked for streaks; 'no subscription, no guilt'; the absence of 'faff'; 39 praise restraint — a streak-loss mechanic is the pressure they left other apps to escape); do not add social, sharing or AI features (zero requested; 'does exactly that and nothing more'); do not build the deadline feature into scheduling; do not treat 4.91★ as proof of product health

- **Where:** §8.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Do not | Because ; Add an onboarding questionnaire or account wall | 14504042664 left competitors over *"20 questions just to get started"*; 13853268363 names *"no sign-in wall"* as why Dots stuck ; Add ads | 9 reviewers (13.43%) name ad-freeness; 14160827585 deletes apps *"instantly"* over ads ; Cap the habit count | 4 reviewers name unlimited habits; 3 of them left competitors specifically over caps ; Gate widgets, views, or reminders behind a paywall | 14148473814 left a competitor over gated widgets; 14472221855 pairs "no paywall" with the three view formats ; Add streaks pressure, scores, or gamification | Only 1 reviewer asked for streaks (14174214597). Against it: 14461677979 praises *"no subscription, no guilt"*; 14472221855 praises the absence of *"faff"*; 39 reviewers praise restraint. A streak-loss mechanic is exactly the pressure they left other apps to escape ; Add social, sharing, or AI features | Zero reviewers requested any. 14122888123: *"does exactly that and nothing more"* ; Build the "deadline" feature into the scheduling work | Different product model, n=1 (§8.2 D1) ; Treat 4.91★ as proof of product health | Zero 1★/2★ across 199 days indicates selection bias, not the absence of problems (warning 2)
- **Direction for us:** product-rule · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14504042664`, `13853268363`, `14160827585`, `14148473814`, `14472221855`, `14174214597`, `14461677979`, `14122888123`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C007 Generous fixed habit cap (or unlimited) — never change it; C024 Streaks / gamification; C209 No sign-up wall before first use; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

## Must-haves

### R56-057 — Generalised finding — a feature-discoverability problem, not a feature-absence problem, with three independent instances: reminders requested twice after shipping; back-dating requested in June while called 'super easy' in August and 'a little hard' in July; widget transparency visible in the store preview and unfindable in the app — 'Shipping a feature is not the same as retiring its request'; F6: audit discoverability app-wide with entry points on primary surfaces (not a redesign) — the cheapest unrealised value in the corpus; E3: add reminder and back-date entry points and measure whether requests for shipped features fall to zero, as happened for reorder

- **Where:** §7.4 generalised finding; §8.1 F6
- **This app does:** shipped features not found
- **User reaction:** complaint
- **Magnitude:** 3 instances
- **Direction for us:** do · **Report confidence:** high confidence · **Generalisable:** generalisable
- **Review IDs:** `14392368857`, `14444070845`, `14226473114`, `14461677979`, `14262513041`, `14210943801`, `13958079059`
- **Canonical:** C142 Surface existing features where users look

## Must never break

### R56-031 — Negative surface — six reviewers (8.96%), none below 4★ (verbatim): B_SYNC_DATALOSS 'I think the recent update about sync made my habits disappear, is there anyway I can get them back??' (PH, 4★, 4 Jul); B_CALENDAR_OFFSET 'the calendar is a day out so when you complete a dot on the Monday it highlights the Sunday before' (GB, 5★); B_LANGUAGE 'today it randomly switched to chinese' (DE, 5★); B_WIDGET_TAP 'the widget… often opens the app instead of progress the habit' (BE, 4★; fixed in v2.3.2); B_CAL_DISAPPEAR calendar of each habit disappears on leaving the app (US, 4★); F_UI_MENUBAR 'The menu bar at the bottom blocks views if you have 9+ habits' (US, 4★); F_DISCOVERABILITY 'where do I set the widget transparency feature like the one in the preview?' (KR, 5★) — severity by consequence, not frequency: 1 sync data loss (silent history loss from an update; promoted regardless of share); 2 calendar off-by-one silently corrupts the record; 3 widget tap misfire breaks the most-praised interaction; 4 menu-bar occlusion at 9+ habits — the unlimited-habits differentiator leads directly into the bug; 5 language switch and calendar disappearing are annoyances; 6 discoverability — third instance of 'the capability exists; the user cannot find it'; forgiveness caveat — defect reporters average 4.50 and wrap complaints in praise; the corpus cannot measure impact because those driven away did not review

- **Where:** §3.5 table (verbatim) and severity ranking
- **This app does:** sync update deleted habits; date off by one; widget tap misfire; menu bar blocks list at 9+ habits
- **User reaction:** complaint
- **Magnitude:** Theme | n | % | Tier | ★ | ID | Detail ; B_SYNC_DATALOSS | 1 | 1.49% | single | 4 | 14260223015 | Data loss. *"I think the recent update about sync made my habits disappear, is there anyway I can get them back??"* (PH, 2026-07-04) ; B_CALENDAR_OFFSET | 1 | 1.49% | single | 5 | 14201101389 | Off-by-one date bug. *"the calendar is a day out so when you complete a dot on the Monday it highlights the Sunday before"* (GB, 2026-06-19) ; B_LANGUAGE | 1 | 1.49% | single | 5 | 14194139904 | Locale switched unprompted. *"today it randomly switched to chinese and I wonder if there is a way to change that back?"* (DE, 2026-06-17) ; B_WIDGET_TAP | 1 | 1.49% | single | 4 | 14422180050 | Widget tap misfires. *"the widget… often opens the app instead of progress the habit"* (BE, 2026-08-13) ; B_CAL_DISAPPEAR | 1 | 1.49% | single | 4 | 14262513041 | View state lost. *"every time I left the app to look at my data in screenshots the calendar of each habit would disappear (not the data)"* (US, 2026-07-04) ; F_UI_MENUBAR | 1 | 1.49% | single | 4 | 14262513041 | Layout occlusion at scale. *"The menu bar at the bottom blocks views if you have 9+ habits"* (US, 2026-07-04) ; F_DISCOVERABILITY | 1 | 1.49% | single | 5 | 14210943801 | Store preview promises what the user cannot find. *"미리보기에 있는 것처럼 위젯 투명도를 설정하는 기능은 어디서 설정하면 될까요?"* — "where do I set the widget transparency feature like the one in the preview?" (KR, 2026-06-22)
- **Direction for us:** must-never-break · **Report confidence:** single (each) · **Generalisable:** generalisable
- **Review IDs:** `14260223015`, `14201101389`, `14194139904`, `14422180050`, `14262513041`, `14210943801`
- **Canonical:** C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C040 Widgets must not go blank, stale or disagree with the app; C083 Performance must not degrade with habit count; C142 Surface existing features where users look

### R56-032 — Menu bar occludes the habit list at 9+ habits — a scale bug that triggers exactly where 'unlimited habits' invites users; one reviewer set up 8 habits, one below the threshold

- **Where:** §3.5 menu bar at 9+ habits
- **This app does:** layout breaks at 9+ habits
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** single · **Generalisable:** generalisable
- **Review IDs:** `14262513041`, `14440814553`
- **Canonical:** C083 Performance must not degrade with habit count

### R56-033 — The app UI switched to Chinese unprompted on a German storefront and the user could not find how to change it back

- **Where:** §3.5 locale switch
- **This app does:** locale switched unprompted
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** single · **Generalisable:** generalisable
- **Review IDs:** `14194139904`
- **Canonical:** C255 An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language

### R56-044 — Issues that would become refund triggers if a paid tier existed (verbatim): sync data loss ('losing paid-for habit history is a refund trigger, not a 4★'); calendar off-by-one ('a paying user will not rate a visibly wrong record 5★'); widget tap misfire (the headline feature); menu-bar occlusion at 9+ habits (hits the power users most likely to pay); feature discoverability — reminders, back-dating, widget transparency ('a paying user who cannot find the feature they paid for asks for money back')

- **Where:** §5.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Item | ID | Why it changes under payment ; Sync data loss | 14260223015 | Losing paid-for habit history is a refund trigger, not a 4★ ; Calendar off-by-one | 14201101389 | A paying user will not rate a visibly wrong record 5★ ; Widget tap misfire | 14422180050 | The widget is the headline feature; broken headline features drive refunds ; Menu-bar occlusion at 9+ habits | 14262513041 | Hits precisely the power users most likely to pay ; Feature discoverability (reminders, back-dating, widget transparency) | 14210943801, 14226473114, 14392368857, 14444070845 | A paying user who cannot find the feature they paid for asks for money back
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14260223015`, `14201101389`, `14422180050`, `14262513041`, `14210943801`, `14226473114`, `14392368857`, `14444070845`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R56-062 — F1: investigate and close out the sync data-loss report — whether the habits were recoverable, whether the fault is fixed, whether anyone else was affected; add a local pre-sync snapshot and a visible restore path — the only severe defect; one unanswered 'is there anyway I can get them back??' is one public data-loss story

- **Where:** §8.1 F1
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14260223015`
- **Canonical:** C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change

### R56-063 — F2: fix the calendar off-by-one — verify week-start and timezone handling across locales (report from GB Europe/London while feed dates are UTC); silently displays a wrong record, rated 5★ so it will not surface through ratings monitoring

- **Where:** §8.1 F2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14201101389`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R56-064 — F3: fix the menu bar occluding the habit list at 9+ habits — the unlimited-habits differentiator leads into the defect; F5: confirm the widget-tap fix landed (v2.3.2 claims 'widget taps land every time'; a failure reported 13 Aug) — verify rather than assume

- **Where:** §8.1 F3, F5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** n=1 each
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14262513041`, `14422180050`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app; C083 Performance must not degrade with habit count

## Features

### R56-007 — Feature inventory derived from reviews (verbatim): habit list with tap-to-complete dots; home-screen widgets in multiple designs (9 name widgets as a reason); widget tap completes a habit without opening the app; card, list, calendar and heat-map views (5); unlimited habits, no cap (4); custom icons (limited — 5 ask for more); custom colours (limited — 2 ask for more); back-logging past entries (praised once, requested once); reminders, habit reordering and optional iCloud sync shipped during the corpus window; dark / OLED-friendly design; no account, no sign-in, no onboarding questionnaire (2); no advertising (9); no data collection (2); iPad implied; localisation (Korean, Chinese) confirmed by a defect; looked for and not found: non-daily scheduling, per-habit notes, multi-habit widget, Apple Watch, streaks, analytics, separate lists, export (since shipped), light mode, back-dating a missed day

- **Where:** §2.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Capability | Evidence in corpus | Reviewer IDs (representative) ; Habit list with tap-to-complete dots | Core mechanic, referenced throughout | 13853268363, 14439891694, 14226473114 ; Home Screen widgets (multiple designs) | 9 reviewers name widgets as a reason to use/keep | 14067204894, 14148473814, 14370026168, 14400919999, 14472221855 ; Widget tap completes a habit without opening the app | Stated explicitly | 14472221855; failure mode in 14422180050 ; Multiple view formats — card, list, calendar, heat map | 5 reviewers name specific views | 14472221855 (card/list/calendar), 14268546710 (heat map), 14504042664 (calendar) ; Unlimited habits, no cap | 4 reviewers name the absence of a cap | 14109432526, 14151336984, 14272015279, 14392368857 ; Custom icons for habits | Present but limited — 5 reviewers ask for more | 13842468107, 14109432526, 14461677979 ; Custom colours | Present but limited — 2 reviewers ask for more | 13842468107, 14109432526 ; Back-logging / editing past entries | Praised once, requested once (see §2.3) | praised 14461677979; requested 14226473114 ; Reminders / notifications | Shipped during the corpus window | absent then present: 14363670791 ; Habit reordering | Shipped during the corpus window | absent then present: 14363670791 ; Optional iCloud sync | Shipped during the corpus window | 14408586581 ("optional icloud sync") ; Dark appearance / OLED-friendly design | Requested 13784066083 (Feb), praised 14272015279 (Jul) | see §7.3 ; No account, no sign-in, no onboarding questionnaire | 2 reviewers name this explicitly | 13853268363 ("no sign-in wall"), 14504042664 ("ask 20 questions just to get started") ; No advertising | 9 reviewers name ad-freeness | 14173024754, 14189254547, 14428584045, 14444070845 ; No data collection | 2 reviewers name privacy | 14294687098 ("No recopila datos"), 14408586581 ; iPad availability | Implied — one user wants iPhone↔iPad sync | 14235241668 ; Localization (Korean, Chinese at minimum) | Confirmed by a *defect*: app switched to Chinese unprompted | 14194139904
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `13853268363`, `14067204894`, `14148473814`, `14472221855`, `14268546710`, `14109432526`, `13842468107`, `14461677979`, `14363670791`, `14408586581`, `14272015279`, `14504042664`, `14173024754`, `14294687098`, `14235241668`, `14194139904`
- **Canonical:** — (nuance register)

### R56-017 — Widgets 9 (13.43%, pattern, 5.00) — a reason to choose and to stay: 'free apps often have chopped widgets, or widgets just gated behind a subscription. thank you dots' (US); 'the best part is being able to put up a widget per goal' (KR, title); 'add the widget to your home screen so you can cross habits off during the day without having to open the app' (GB); 'the empty dots on my home screen guilt trip me into being productive and honestly? it works' (US) — the home-screen dot is the behaviour-change nudge itself; 'great tracker and convenient widgets… I maintain discipline' (KZ); widgets also generate the most upward demand (3 want more, 1 bug)

- **Where:** §3.3.6
- **This app does:** free: widgets per habit with one-tap completion
- **User reaction:** praise
- **Magnitude:** 9 (13.43%, 5.00)
- **Direction for us:** build-free · **Report confidence:** pattern · **Generalisable:** generalisable
- **Review IDs:** `14148473814`, `14370026168`, `14472221855`, `13853268363`, `14227146007`
- **Canonical:** C023 Interactive widget check-off

### R56-024 — Unmet needs — complete backlog, 26 requesters (38.81%, mean 4.85) (verbatim): reminders / notifications 6 (8.96%, 5.00, Apr → Aug 2026); non-daily scheduling 6 (8.96%, 4.67, Feb → Aug); more icons / custom emoji 5 (7.46%, 4.60); reorder habits 4 (5.97%, 4.75, May → Jul); per-habit description / notes 3 (4.48%, 4.67); more / richer widgets (multi-habit, >4, transparency) 3 (4.48%, 5.00); more colours 2; cross-device iPhone ↔ iPad sync 1; data export JSON/CSV 1; Apple Watch 1; dark mode 1; light mode 1; streaks 1; analytics / charts 1; back-date a missed day 1; separate lists / habit groups 1; donation / tip option 1 — three already answered (reminders and reorder shipped by 29 Jul, export in v2.3.0, icons to 42 in v2.3.0); dark mode (Feb) and light mode (Jul) are opposite requests five months apart

- **Where:** §3.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Rank | Request | n | % of 67 | Signal label | Tier | Mean ★ | Window | Review IDs ; 1= | Reminders / notifications | 6 | 8.96% | high-priority | pattern | 5.00 | 2026-04-14 → 2026-08-18 | 13958079059, 14235241668, 14239464502, 14363670791, 14392368857, 14444070845 ; 1= | Non-daily scheduling (weekly / monthly / x-per-week / select days / deadline) | 6 | 8.96% | high-priority | pattern | 4.67 | 2026-02-20 → 2026-08-11 | 13770961885, 13996707039, 14239464502, 14272015279, 14392368857, 14414692804 ; 3 | More icons / custom emoji | 5 | 7.46% | high-priority | pattern | 4.60 | 2026-03-13 → 2026-08-23 | 13842468107, 14109432526, 14260223015, 14354352389, 14461677979 ; 4 | Reorder habits | 4 | 5.97% | high-priority | pattern | 4.75 | 2026-05-08 → 2026-07-29 | 14040460063, 14122888123, 14260223015, 14363670791 ; 5= | Per-habit description / notes | 3 | 4.48% | very strong | corroborated | 4.67 | 2026-05-26 → 2026-08-09 | 14109432526, 14272015279, 14405635940 ; 5= | More / richer widgets (multi-habit, >4, transparency) | 3 | 4.48% | very strong | corroborated | 5.00 | 2026-06-22 → 2026-08-08 | 14210943801, 14330479445, 14400919999 ; 7 | More colours | 2 | 2.99% | meaningful | corroborated | 4.50 | 2026-03-13 → 2026-05-26 | 13842468107, 14109432526 ; 8= | Cross-device sync (iPhone ↔ iPad) | 1 | 1.49% | meaningful | single | 5.00 | 2026-06-28 | 14235241668 ; 8= | Data export (JSON / CSV) | 1 | 1.49% | meaningful | single | 5.00 | 2026-07-21 | 14330479445 ; 8= | Apple Watch app | 1 | 1.49% | meaningful | single | 5.00 | 2026-06-19 | 14201304150 ; 8= | Dark mode | 1 | 1.49% | meaningful | single | 5.00 | 2026-02-24 | 13784066083 ; 8= | Light mode | 1 | 1.49% | meaningful | single | 4.00 | 2026-07-04 | 14260223015 ; 8= | Streaks | 1 | 1.49% | meaningful | single | 5.00 | 2026-06-12 | 14174214597 ; 8= | More analytics / charts | 1 | 1.49% | meaningful | single | 5.00 | 2026-08-23 | 14461677979 ; 8= | Back-date a missed day | 1 | 1.49% | meaningful | single | 5.00 | 2026-06-25 | 14226473114 ; 8= | Separate lists / habit groups | 1 | 1.49% | meaningful | single | 5.00 | 2026-06-12 | 14173024754 ; 8= | Donation / tip option | 1 | 1.49% | meaningful | single | 5.00 | 2026-08-18 | 14444070845
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `13958079059`, `14235241668`, `14239464502`, `14363670791`, `14392368857`, `14444070845`
- **Canonical:** — (nuance register)

### R56-025 — Non-daily scheduling is qualitatively the most important request: the oldest (review #2 of the corpus, 20 Feb 2026), the only one still recurring unanswered at the end (11 Aug), and the only request with a rating penalty — the corpus's only 3★: 'Great daily but no weekly… I love the daily tracking for free with no premium version, but I feel like we need a weekly/monthly/select days option!' (GB, 25 Apr) — praising the free model and docking two stars in one sentence; forms requested: 'goal schedule' (KR), weekly / monthly / select days (GB), once a week / once a month (PH), x times per week (US), daily or weekly (AR), deadline (TW); five of six reduce to 'this habit is not daily'; D1: ship per-habit frequency (daily / specific weekdays / N per week) as one field defaulting to daily, invisible to the 58% who want daily-only; keep the deadline request out — a time-bounded goal is a different product

- **Where:** §3.4 scheduling; §4.3; §8.2 D1; part 8
- **This app does:** daily-only habits
- **User reaction:** complaint
- **Magnitude:** 6 (8.96%, 4.67); 6 storefronts; the only 3★
- **Direction for us:** must-have · **Report confidence:** pattern · **Generalisable:** generalisable
- **Review IDs:** `13770961885`, `13996707039`, `14239464502`, `14272015279`, `14392368857`, `14414692804`
- **Canonical:** C043 Flexible / custom frequency

### R56-026 — Scheduling forms requested (verbatim table)

- **Where:** §3.4 table form rows (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Form requested | Reviewer | Storefront ; "goal schedule" (목표 일정) | 13770961885 | KR ; weekly / monthly / select days | 13996707039 | GB ; once a week, once a month | 14239464502 | PH ; x times per week | 14272015279 | US ; daily *or* weekly habits | 14392368857 | AR ; deadline | 14414692804 | TW
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R56-027 — A deadline — a time-bounded goal rather than a recurring habit — requested once (TW); a different product model and UI from recurring habits, kept out of scheduling work

- **Where:** §3.4 deadline
- **This app does:** absent: deadlines
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** research · **Report confidence:** single · **Generalisable:** generalisable
- **Review IDs:** `14414692804`
- **Canonical:** C099 Countdown / 'days until' mode

### R56-028 — Cosmetic requests: more icons / custom or system emoji 5 (7.46%), more colours 2 (2.99%), per-habit description / notes 3 (4.48%) — one note request ('notes/comments… to help track progress') is closer to journaling than labelling

- **Where:** §3.4 icons, colours, notes
- **This app does:** limited icons and colours; no notes
- **User reaction:** complaint
- **Magnitude:** 5 / 2 / 3
- **Direction for us:** build-free · **Report confidence:** pattern · **Generalisable:** generalisable
- **Review IDs:** `13842468107`, `14109432526`, `14354352389`, `14461677979`, `14405635940`
- **Canonical:** C009 Basic widgets, icons and colours are free; C172 Per-day / per-habit notes and journal text

### R56-029 — More / richer widgets 3 (4.48%, 5.00): a multi-habit widget designed in detail — a grid with dates across the top and habits down the side, or 4 habits in one calendar widget; more than 4 widgets; widget transparency (may already exist)

- **Where:** §3.4 widgets
- **This app does:** per-habit widgets, max 4
- **User reaction:** complaint
- **Magnitude:** 3 (4.48%)
- **Direction for us:** build-free · **Report confidence:** corroborated · **Generalisable:** generalisable
- **Review IDs:** `14400919999`, `14330479445`, `14210943801`
- **Canonical:** C023 Interactive widget check-off

### R56-030 — Single requests: iPhone ↔ iPad sync; data export (answered in v2.3.0); Apple Watch app; dark mode (Feb) and light mode (Jul) — opposite requests, likely because the app shipped light-first and later became dark-default; streaks (1); analytics / charts; back-date a missed day; separate lists / habit groups

- **Where:** §3.4 singles
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 1 each
- **Direction for us:** research · **Report confidence:** single · **Generalisable:** generalisable
- **Review IDs:** `14235241668`, `14330479445`, `14201304150`, `13784066083`, `14260223015`, `14174214597`, `14461677979`, `14226473114`, `14173024754`
- **Canonical:** C010 Backfill missed days / edit start date; C011 Weekly / monthly / yearly reports; C013 Cloud sync / multi-device as the paid differentiator; C022 Apple Watch app (done properly: timer, two-way sync); C024 Streaks / gamification; C045 Grouping / folders / categories / tags; C080 Colour themes / dark mode

### R56-068 — D4: finish the cosmetic backlog — cheap and demonstrably buys stars: R_ICONS 5, R_COLORS 2, R_DESC 3; 'i would have a 5 star rating if a few small changes could be made'; two of four 4★ are cosmetic; remaining items are custom / system emoji (not more presets), more colours and a per-habit description; ship the short label first and treat journaling-style notes as a separate question

- **Where:** §8.2 D4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** R_ICONS 5; R_COLORS 2; R_DESC 3
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14109432526`, `14354352389`, `14405635940`, `14260223015`
- **Canonical:** C009 Basic widgets, icons and colours are free; C172 Per-day / per-habit notes and journal text

### R56-069 — D5: invest in widgets — the differentiator and the growth surface: P_WIDGET 9 name them as a reason to choose or stay; two name free + widgets as the combination not found elsewhere; the home-screen widget is described as the behaviour-change mechanism; buildable upward requests — a multi-habit widget (a grid with dates across and habits down, or 4 habits in one calendar widget), more than 4 widgets, widget transparency; E4 measures widget install rate and whether requests recur

- **Where:** §8.2 D5; §8.3 E4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** P_WIDGET 9; R_WIDGET_MORE 3
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14067204894`, `14400919999`, `14504042664`, `13853268363`, `14330479445`, `14210943801`
- **Canonical:** C023 Interactive widget check-off

## Monetization

### R56-008 — Free / paid / trial classification — 'the shortest monetization table in this report series, and that is the finding' (verbatim): habit tracking and unlimited habits free (4 state it, none contradict); widgets free — contrasted with competitors whose 'widgets [are] just gated behind a subscription'; all view formats free ('There's no paywall'); reminders, reordering, iCloud sync free; ads none (9 confirm, zero report one); nobody reports paying for anything; explicit non-findings — 0/67 mention a subscription, trial, one-time unlock, renewal, price, currency amount or refund; 0/67 a paywall complaint about Dots (9 about other apps); 0/67 a price objection; 1/67 asks for a way to pay ('Eager next for notification and donation options') — a fully free product whose free-ness is its primary differentiator, restated in 35 of 67 (52.24%)

- **Where:** §2.2 table (verbatim) and non-findings
- **This app does:** fully free
- **User reaction:** praise
- **Magnitude:** Capability | Gating observed in reviews ; Habit tracking, unlimited habits | Free — stated by 4 reviewers explicitly, contradicted by none ; Widgets | Free — 14148473814 contrasts this with competitors whose "widgets [are] just gated behind a subscription" ; All view formats (card / list / calendar / heat map) | Free — 14472221855 lists all three formats with "There's no paywall" in the same review ; Reminders, reordering, iCloud sync | Free — 14363670791, 14408586581; no reviewer reports paying for them ; Ads | None — 9 reviewers confirm; zero reviewers report seeing an ad ; Anything at all | No reviewer reports paying for anything. M_PAID_EVIDENCE = 0 / 67
- **Direction for us:** product-rule · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14148473814`, `14472221855`, `14363670791`, `14408586581`, `14444070845`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free; C097 A tip / donate option; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R56-013 — Free, and specifically 'actually free' 31 (46.27%, dominant, 4.90) — unqualified free-ness: no trial, no cap, no gated widget — 'No obnoxious free-trial trick. Actually free' (GB); 'really free, no false promises' (AR); 'Best free no strings app' (GB); 'an aesthetic widget that is free, which is rare to see now. free apps often have chopped widgets, or widgets just gated behind a subscription' (US); 'Thank God a decent habit tracker app that is free without all the in app purchases' (CA); flat across time (P1 58.8%, P2 39.3%, P3 45.5%) and markets (high-spend 47.1%, rest 43.8%; US 45.8% vs rest 46.5%) — not a price-sensitivity artefact of poorer storefronts

- **Where:** §3.3.2
- **This app does:** fully free, no trial trick
- **User reaction:** praise
- **Magnitude:** 31 (46.27%, 4.90); US 45.8% vs rest 46.5%
- **Direction for us:** build-free · **Report confidence:** dominant · **Generalisable:** generalisable
- **Review IDs:** `14363670791`, `14389211332`, `13982923679`, `14148473814`, `14209620370`, `13897912337`
- **Canonical:** C001 Never move a free feature behind the paywall; C147 Let people use the product before they pay

### R56-040 — The paid segment is empty (verbatim): explicit payers 0 (0.00%); trialists 0; refund / cancel requests 0; reviewers complaining about another app's paywall 9 (13.43%); praising Dots' absence of payment 31 (46.27%); asking for a way to give money 1 (1.49%) — a hand search in original language for payment, purchase, subscription, premium, pro, upgrade, unlock, trial, renewal, refund, cancel, price, currency and non-English equivalents found only absence-of-payment in Dots or payment in other apps; 'This is not a data gap. It is the finding'; no conversion rate, ARPU or willingness-to-pay may be inferred

- **Where:** §5.1 table (verbatim); §5.4
- **This app does:** no commercial surface
- **User reaction:** praise
- **Magnitude:** Segment | n | % of 67 | Status ; Explicit payers of Dots | 0 | 0.00% | empty ; Explicit trialists of Dots | 0 | 0.00% | empty ; Explicit refund/cancel requests for Dots | 0 | 0.00% | empty ; Reviewers who complain about *another app's* paywall | 9 | 13.43% | M_COMPETITOR_PAYWALL ; Reviewers who praise Dots' *absence* of payment | 31 | 46.27% | P_FREE ; Reviewers asking for a way to give money | 1 | 1.49% | R_DONATE — 14444070845
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `14444070845`
- **Canonical:** C001 Never move a free feature behind the paywall

### R56-041 — The single piece of direct inbound demand: 'Simple Pretty Flexible and Shill-free. Thank you. Eager next for notification and donation options' (US, 5★, 18 Aug 2026) — one reviewer unprompted asked to donate; zero asked for a premium tier, pro unlock or paid features; supported by unusually high goodwill (13 thank the developer) — 'plausibility is not evidence, and one request is one request'

- **Where:** §5.2 donation request
- **This app does:** no tip option
- **User reaction:** purchase-driver
- **Magnitude:** R_DONATE 1; P_GRATITUDE 13
- **Direction for us:** research · **Report confidence:** single · **Generalisable:** generalisable
- **Review IDs:** `14444070845`, `14210943801`, `14173024754`, `14504042664`, `14067204894`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C097 A tip / donate option

## Tactics the app used

### R56-021 — A visible solo developer earns unusual goodwill: 13 of 67 (19.40%) thank the developer explicitly, several by name ('Hello developer!'; 'Thank you, dev!'; 'Huge thanks to the developer!!!'); 'criminally underrated' — the profile of an audience that would plausibly tip

- **Where:** §3.3.9 P_GRATITUDE
- **This app does:** indie developer presence
- **User reaction:** praise
- **Magnitude:** 13 (19.40%)
- **Direction for us:** do · **Report confidence:** dominant · **Generalisable:** generalisable
- **Review IDs:** `14210943801`, `14173024754`, `14504042664`, `14067204894`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R56-058 — Visible shipping speed converts: a reviewer states two previously missing features (reminders, reordering) had shipped and raised their verdict — 'It didn't have options for reminders & shuffling the order of your habits, but it does now! -Even more happy with it' (GB, 29 Jul 2026)

- **Where:** §7.4 shipping visibly
- **This app does:** shipped requested features within months
- **User reaction:** praise
- **Magnitude:** P_DEVRESPONSIVE 1
- **Direction for us:** do · **Report confidence:** single (high significance) · **Generalisable:** generalisable
- **Review IDs:** `14363670791`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R56-067 — D3: the one monetisation path the corpus supports is voluntary payment — R_DONATE n=1 (thin, stated as thin) supported by P_GRATITUDE 13 and 'criminally underrated'; zero asked for a premium tier, zero objected to donating, and a tip jar gates nothing so it is the only option not contradicting D2; test before building (E1: an unobtrusive tip jar in Settings — no gating, no prompt, no nag; measure tip rate and watch for any negative review mentioning it, because one 'now it's asking for money' review is meaningful where 52.24% praise the absence of monetisation); a second asset — no ads, no data, no accounts — is itself a differentiator and the credibility that makes a donation ask land

- **Where:** §8.2 D3; §8.3 E1
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** R_DONATE 1; P_GRATITUDE 13
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14444070845`, `14067204894`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C096 Privacy and discretion stack; C097 A tip / donate option

### R56-071 — Experiments (verbatim): E1 unobtrusive tip jar in Settings (tip rate; any negative mention); E2 non-daily frequency as one field defaulting to daily (adoption; whether simplicity praise holds ≥50%); E3 reminder and back-date entry points on primary surfaces (requests for shipped features → zero, as for reorder); E4 multi-habit widget (install rate; whether requests recur); E5 listing rewritten in the corpus's language (store conversion; search-end share)

- **Where:** §8.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** # | Experiment | Tests | Success measure ; E1 | Ship an unobtrusive tip jar in Settings — no gating, no prompt, no nag | D3 | Tip rate; watch for any negative review mentioning it. A single "now it's asking for money" review is a meaningful negative signal in a corpus where 52.24% praise the absence of monetization ; E2 | Non-daily frequency as one field in the habit editor, defaulting to daily | D1 vs the simplicity constraint | Adoption among new habits; whether P_SIMPLE praise holds at ≥50% in later reviews ; E3 | Add reminder and back-date entry points to primary surfaces (as v2.3.2 did for reminders), then measure whether the *requests* stop | §7.4 / F6 | Requests for already-shipped features → zero, as happened for reorder ; E4 | Multi-habit widget per 14400919999's specification | D5 | Widget install rate; whether R_WIDGET_MORE recurs ; E5 | Rewrite the store listing in the corpus's own language ("actually free, no strings") | D6 | Store conversion rate; whether P_SEARCH_END share keeps rising
- **Direction for us:** research · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

## Insights (the why)

### R56-006 — Dots has no monetisation, and 'free' is the single most-cited reason people choose it and stay (verbatim table): 1 zero purchase evidence (M_PAID_EVIDENCE 0/67); 2 'free' is the #2 named attribute and #1 acquisition trigger — 31/67 (46.27%) praise being free, 9/67 (13.43%) name a competitor's paywall as why they left; 3 simplicity is the retention mechanic — 39/67 (58.21%); 4 15/67 (22.39%) arrived by rejecting a competitor — a displacement market; 5 only one reviewer asked for a way to give money (a donation option, 18 Aug 2026); 6 the request backlog is small and shippable — 26/67 (38.81%) made a request at mean 4.85 (requests come from happy users); top reminders 6, non-daily scheduling 6, more icons 5, reorder 4; 7 non-daily scheduling is the oldest and most damaging gap and produced the only 3★; 8 defects rare (6/67, 8.96%, mean 4.50) but one is data loss; 9 shipping speed is visible and converting; 10 some 'missing feature' requests are discoverability failures — the decision: growth is powered by a promise (actually free, no ads, no paywall, unlimited habits) that 35/67 (52.24%) restate; any monetisation that contradicts it attacks the acquisition engine; the one non-contradictory path is voluntary payment

- **Where:** Executive summary table (verbatim) and decision
- **This app does:** fully free
- **User reaction:** praise
- **Magnitude:** # | Finding | Evidence ; 1 | Zero purchase evidence exists. No reviewer in 67 mentions paying, subscribing, trialling, renewing or refunding. | M_PAID_EVIDENCE n=0 / 67 ; 2 | "Free" is the #2 named attribute and the #1 acquisition trigger. 31 / 67 (46.27%) praise being free explicitly; 9 / 67 (13.43%) name a *competitor's* paywall as why they left that app. | P_FREE, M_COMPETITOR_PAYWALL ; 3 | Simplicity is the retention mechanic, not a nice-to-have. 39 / 67 (58.21%) name simplicity/minimalism; the phrase "doesn't try to do too much" recurs almost verbatim. | P_SIMPLE ; 4 | 22.39% (15 / 67) arrived by rejecting a competitor. Dots is winning a displacement market, not a greenfield one. | P_SEARCH_END ; 5 | Only one reviewer in 67 asked for a way to give money — a donation option (14444070845, 2026-08-18). That is the corpus's *entire* inbound monetization demand. | R_DONATE n=1 ; 6 | The request backlog is small, concrete and shippable. 26 / 67 (38.81%) made at least one request; their mean rating is 4.85 — requests come from *happy* users. Top four: reminders (6), non-daily scheduling (6), more icons (5), reorder (4). | R_* union ; 7 | Non-daily scheduling is the oldest and most damaging gap. Requested from day 1 of the corpus (2026-02-20) through 2026-08-11, and it produced the corpus's *only* 3★ (13996707039). | R_SCHEDULE n=6 ; 8 | Defects are rare but one is data loss. 6 / 67 (8.96%) report any defect; 14260223015 reports habits disappearing after the sync update. Mean rating of defect-reporters is 4.50 — they are forgiving, for now. | B_*/F_* union ; 9 | Shipping speed is visible and is converting. 14363670791 (2026-07-29) states two previously-missing features (reminders, reordering) had shipped, and raised its verdict accordingly. | P_DEVRESPONSIVE ; 10 | Some "missing feature" requests are discoverability failures. Reminders existed by 2026-07-29 yet two later reviews still asked for them; the developer's own v2.3.2 note describes making reminders "easier to reach". | §7.4
- **Direction for us:** product-rule · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14444070845`, `13996707039`, `14260223015`, `14363670791`
- **Canonical:** C001 Never move a free feature behind the paywall; C006 Stay minimal — every addition is opt-in or off by default; C043 Flexible / custom frequency; C061 Goodwill conversion — a generous free tier and 'support the devs'; C142 Surface existing features where users look

### R56-009 — One apparent contradiction resolved — back-dating is both praised and requested: 'I wish there was a feature to go back one day or two to tick my task as done' (GB, 25 Jun); back-logging possible but 'a little hard' because the per-habit calendar disappeared on re-entry (US, 4 Jul); 'it's super easy to back-log past entries' (SG, 23 Aug) — a discoverability arc, not a missing feature; the same pattern as reminders and 'the most transferable lesson in this corpus'

- **Where:** §2.3
- **This app does:** back-dating existed but was hard to find
- **User reaction:** mixed
- **Magnitude:** 3 reviews
- **Direction for us:** must-have · **Report confidence:** single · **Generalisable:** generalisable
- **Review IDs:** `14226473114`, `14461677979`, `14262513041`
- **Canonical:** C010 Backfill missed days / edit start date; C142 Surface existing features where users look

### R56-014 — Competitor paywall rejection 9 (13.43%, pattern, 5.00) — the acquisition mechanism stated: 'how many apps I have had to download and instantly delete bc it has ads or a subscription. Those other apps are pretty much useless unless you pay' (US); 'it doesn't ask you to pay anything, you can set unlimited habits, unlike other apps that ask you to pay' (AR); 'Everything else similar to this app has some kind of subscription model attached' (US); 'without limiting me to preset habits or a specific number without paying first' (AR); 'tried countless apps that claim to help neurodivergent people… They end up being made for quick cash grabs' (GB) — 'the highest-leverage finding for the monetization decision': these users arrived because of pricing, having already churned from a paid competitor once

- **Where:** §3.3.3
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 9 (13.43%, 5.00)
- **Direction for us:** product-rule · **Report confidence:** pattern · **Generalisable:** generalisable
- **Review IDs:** `14160827585`, `14151336984`, `14040460063`, `14392368857`, `14472221855`
- **Canonical:** C001 Never move a free feature behind the paywall; C005 Know which competitors buyers compare against

### R56-015 — Design and aesthetics 20 (29.85%, dominant, 4.95) — clean, minimal, 'aesthetic', OLED-friendly; runs higher outside the US (34.9% vs 20.8%): 'lean and minimalist way possible. UX designer gets a big shout out' (GB); 'Cool OLED and Minimal Design' (US); 'a clean, minimal main screen and above all a variety of widget designs' (KR); 'such a beautiful, simple and aesthetic layout' (AU)

- **Where:** §3.3.4
- **This app does:** minimal design
- **User reaction:** praise
- **Magnitude:** 20 (29.85%, 4.95); US 20.8% vs rest 34.9%
- **Direction for us:** none · **Report confidence:** dominant · **Generalisable:** generalisable
- **Review IDs:** `13982923679`, `14272015279`, `14370026168`, `14518114843`, `14439891694`
- **Canonical:** — (nuance register)

### R56-018 — No ads / no interruptions 9 (13.43%, pattern, 4.89): 'no random pop ups—just put your habits in and track them'; title 'Simple Pretty Flexible and Shill-free'; 'simple and without ads' (AR) — rising P1 5.9% → P2 14.3% → P3 18.2%, most likely compositional as more reviewers arrive by rejecting monetised competitors

- **Where:** §3.3.7
- **This app does:** no ads
- **User reaction:** praise
- **Magnitude:** 9 (13.43%, 4.89); 5.9% → 14.3% → 18.2%
- **Direction for us:** product-rule · **Report confidence:** pattern · **Generalisable:** generalisable
- **Review IDs:** `14189254547`, `14444070845`, `14174214597`
- **Canonical:** C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R56-019 — Reported outcomes 10 (14.93%, dominant, 5.00): 'I'm embracing a new life with new habits'; 'I'm tracking no alcohol, no peanut butter, daily crunches… fun and helpful to see success'; 'really helps me… especially during exam season' (DE); 'perfect for tracking tasks and evaluating project progress' (ES — a non-habit use case: project tracking); 'helps you see whether you're really progressing'; 'I maintain discipline' (KZ); US 25.0% vs rest 9.3% (6 vs 4, observation only)

- **Where:** §3.3.8
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 10 (14.93%, 5.00)
- **Direction for us:** none · **Report confidence:** dominant · **Generalisable:** generalisable
- **Review IDs:** `13838078059`, `14268546710`, `14194139904`, `14294687098`, `14401566211`, `14227146007`
- **Canonical:** — (nuance register)

### R56-020 — Smaller positives (verbatim): P_GRATITUDE 13 (19.40%, dominant) — several address the developer directly ('Hello developer!'), a perceived solo/indie developer and high goodwill, an asset for a donation model; P_ADVOCACY 7 (10.45%) — '100/10', 'highly recommend'; P_VIEWS 5 (7.46%, mean 4.60 — the lowest-rated positive theme because view-heavy users hit layout bugs); P_UNLIMITED 4 (5.97%) — always stated against competitors; P_NOSIGNUP 2 — 'ask 20 questions just to get started'; P_PRIVACY 2 — corroborated by the listing's 'does not collect any data'; P_DOTS 2; P_BACKLOG 1; P_DEVRESPONSIVE 1 (shipped what was asked)

- **Where:** §3.3.9 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % | Tier | Notes ; P_GRATITUDE — explicit thanks to the developer | 13 | 19.40% | dominant | Several address the developer directly (14210943801: *"안녕하세요 개발자님!"* — "Hello developer!"). Indicates a perceived solo/indie developer and high goodwill — an asset for a donation model (§8.2 D3). ; P_ADVOCACY — explicit recommendation | 7 | 10.45% | pattern | 14401566211: *"100/10"*; 14518114843: *"highly recommend"* ; P_VIEWS — multiple view formats | 5 | 7.46% | pattern | Mean ★ 4.60 — the *lowest-rated* positive theme, because view-heavy users also hit the layout bugs (14262513041) ; P_UNLIMITED — no habit cap | 4 | 5.97% | pattern | Always stated in contrast to competitors ; P_NOSIGNUP — no account / no onboarding quiz | 2 | 2.99% | corroborated | 14504042664: *"ask 20 questions just to get started"* ; P_PRIVACY — no data collection | 2 | 2.99% | corroborated | 14294687098, 14408586581; corroborated by the listing's "does not collect any data" ; P_DOTS — the dot mechanic itself | 2 | 2.99% | corroborated | 14439891694: *"loves seeing the progress day by day, the dots are great"* ; P_BACKLOG — easy back-logging | 1 | 1.49% | single | 14461677979; see §2.3 ; P_DEVRESPONSIVE — shipped what was asked | 1 | 1.49% | single | 14363670791 — but see §7.4, its significance exceeds its count
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `14210943801`, `14401566211`, `14518114843`, `14262513041`, `14504042664`, `14294687098`, `14408586581`, `14439891694`, `14461677979`, `14363670791`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R56-023 — No data collection named as a value: 'No recopila datos' (ES — privacy as the primary value); 'Simple, free, privacy friendly - optional icloud sync' (HU); corroborated by the listing's 'does not collect any data'

- **Where:** §3.3.9 P_PRIVACY
- **This app does:** no data collection
- **User reaction:** praise
- **Magnitude:** 2 (2.99%)
- **Direction for us:** do · **Report confidence:** corroborated · **Generalisable:** generalisable
- **Review IDs:** `14294687098`, `14408586581`
- **Canonical:** C085 Address tracking / privacy visibly; C096 Privacy and discretion stack

### R56-035 — 5★ n=62 (92.54%) drivers (verbatim): simplicity 36 (58.06%); free / no paywall 29 (46.77%); design 19 (30.65%); search ended at Dots 14 (22.58%); thanks to the developer 13 (20.97%) — the modal 5★ is short (median 119 characters) and names 'it's simple' and 'it's free' ('Great, simple and free habit tracker! I love it!'); 23 of 62 five-stars (37.10%) still contain a request — 5★ means 'nothing is wrong', not 'nothing is missing'

- **Where:** §4.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Driver | n within 5★ | % of 62 ; Simplicity / minimalism | 36 | 58.06% ; Free / no paywall | 29 | 46.77% ; Design / aesthetics | 19 | 30.65% ; Search ended at Dots | 14 | 22.58% ; Thanks to the developer | 13 | 20.97%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `14376181527`
- **Canonical:** — (nuance register)

### R56-036 — 4★ n=4, each with a specific cause and each still praising (verbatim): ZA — 'i would have a 5 star rating if a few small changes could be made' (custom/system emoji, more colours, per-habit description — three cosmetic requests cost one star); PH — reorder, light mode, icons plus the data-loss report as an in-text update; US — menu-bar occlusion at 9+ habits and calendar view disappearing ('Just some minor drawbacks'); BE — widget tap opens the app instead of completing — 2 of 4 lost a star to cosmetic limits, 2 to defects; nothing about pricing or the core mechanic

- **Where:** §4.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ID | Storefront | Date | Why not 5★ ; 14109432526 | ZA | 2026-05-26 | States it explicitly: *"i would have a 5 star rating if a few small changes could be made"* — custom/system emoji, more colours, per-habit description. Three cosmetic requests cost one star. ; 14260223015 | PH | 2026-07-04 | Requests (reorder, light mode, icons) plus the data-loss report appended as an in-text *"update:"*. ; 14262513041 | US | 2026-07-04 | Two defects: menu bar occlusion at 9+ habits, calendar view disappearing. *"Just some minor drawbacks."* ; 14422180050 | BE | 2026-08-13 | One defect: widget tap opens the app instead of completing the habit.
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `14109432526`, `14260223015`, `14262513041`, `14422180050`
- **Canonical:** — (nuance register)

### R56-037 — Cosmetic limits demonstrably cost stars: half the 4★ reviews name icons, colours or descriptions as the only thing between them and 5★ — cheap to fix and partly fixed already (42 icons in v2.3.0)

- **Where:** §4.2 cosmetic requests cost a star
- **This app does:** limited cosmetics
- **User reaction:** complaint
- **Magnitude:** 2 of 4 4★
- **Direction for us:** build-free · **Report confidence:** single · **Generalisable:** generalisable
- **Review IDs:** `14109432526`, `14260223015`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R56-072 — Research questions: 1 why did 24 of 43 polled storefronts return zero reviews when the app claims Japanese localisation — distribution, listing or install volume (resolve against install data); 2 does an in-app purchase surface exist (an aggregator says yes, 67 reviewers saw nothing); 3 what do the 92.5% who never review do — churn causes are invisible, and adding analytics would contradict the 'does not collect any data' claim 2 reviewers value; 4 how many users hit the 9+ habit occlusion bug; 5 was the lost data recoverable and was anyone else affected; 6 would the donation audience actually pay (only E1 answers); 7 is the P2 defect cluster real; 8 is the deadline request a real adjacent need (n=1)

- **Where:** §8.4 part 8 #1, part 8 #2, part 8 #3, part 8 #4, part 8 #5, part 8 #6, part 8 #7, part 8 #8
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

## Audiences

### R56-049 — The ADHD / neurodivergent signal, n=1 (GB, 5★, 26 Aug 2026), quoted because it articulates the implied positioning: 'The minimalism is absolutely perfect for people who actually want to track their habits without the faff. My ADHD makes organisation challenging and over the year I've tried countless apps that claim to help neurodivergent people or be perfect for those who procrastinate. They end up being made for quick cash grabs or having a wildly confusing interface that is overwhelming and challenging to navigate. With Dots, you get exactly what you download' — joins competitor paywall rejection, interface overwhelm and 'you get exactly what you download' into one causal chain; the category advertises heavily to this audience and Dots serves it without claiming it — a hypothesis, not market sizing; D6: do not claim the ADHD positioning on this evidence — earn it by staying simple

- **Where:** §6.9
- **This app does:** no ADHD claim in positioning
- **User reaction:** praise
- **Magnitude:** S_ADHD 1 (1.49%)
- **Direction for us:** research · **Report confidence:** single · **Generalisable:** generalisable
- **Review IDs:** `14472221855`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

## Markets and languages

### R56-045 — The 50-review threshold — zero storefronts qualify (verbatim): US 24 (35.82%, 4.96); GB 8 (4.75); AR 5 (5.00); DE 5 (5.00); KR 5 (5.00); PH 3 (4.67); BR, CA, ES, IN 2 each; AU, BE, HU, KZ, NL, RU, SG, TW, ZA 1 each — no standalone country claim

- **Where:** §6.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Storefront | Reviews | % of 67 | Mean ★ | Window | ≥50? ; US United States | 24 | 35.82% | 4.96 | 2026-03-11 → 2026-09-03 | ❌ ; GB United Kingdom | 8 | 11.94% | 4.75 | 2026-04-21 → 2026-08-26 | ❌ ; AR Argentina | 5 | 7.46% | 5.00 | 2026-04-02 → 2026-08-05 | ❌ ; DE Germany | 5 | 7.46% | 5.00 | 2026-02-24 → 2026-08-01 | ❌ ; KR South Korea | 5 | 7.46% | 5.00 | 2026-02-20 → 2026-07-31 | ❌ ; PH Philippines | 3 | 4.48% | 4.67 | 2026-06-29 → 2026-07-29 | ❌ ; BR Brazil | 2 | 2.99% | 5.00 | 2026-08-15 → 2026-08-31 | ❌ ; CA Canada | 2 | 2.99% | 5.00 | 2026-03-28 → 2026-08-17 | ❌ ; ES Spain | 2 | 2.99% | 5.00 | 2026-07-12 → 2026-08-22 | ❌ ; IN India | 2 | 2.99% | 5.00 | 2026-07-21 → 2026-08-05 | ❌ ; AU, BE, HU, KZ, NL, RU, SG, TW, ZA | 1 each | 1.49% each | — | — | ❌
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R56-046 — United States n=24 (limited evidence), mean 4.96 (verbatim table: simple 54.2% vs rest 60.5%; free 45.8% vs 46.5%; gratitude 29.2% vs 14.0%; outcome 25.0% vs 9.3%; search-end 20.8% vs 23.3%; design 20.8% vs 34.9%; widget 16.7% vs 11.6%; no ads 16.7% vs 11.6%; notifications request 12.5% vs 7.0%; competitor paywall 12.5% vs 14.0%; no-signup 8.3% vs 0.0%; scheduling request 4.2% vs 11.6%) — hypotheses only: US reviewers describe outcomes more and praise design less; the US supplies both no-signup reviews, both describing onboarding friction at competitors as the reason for switching

- **Where:** §6.2 table (verbatim) and hypotheses
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | US n | US % of 24 | Rest-of-world % of 43 ; P_SIMPLE | 13 | 54.2% | 60.5% ; P_FREE | 11 | 45.8% | 46.5% ; P_GRATITUDE | 7 | 29.2% | 14.0% ; P_OUTCOME | 6 | 25.0% | 9.3% ; P_SEARCH_END | 5 | 20.8% | 23.3% ; P_DESIGN | 5 | 20.8% | 34.9% ; P_WIDGET | 4 | 16.7% | 11.6% ; P_NOADS | 4 | 16.7% | 11.6% ; R_NOTIF | 3 | 12.5% | 7.0% ; M_COMPETITOR_PAYWALL | 3 | 12.5% | 14.0% ; P_NOSIGNUP | 2 | 8.3% | 0.0% ; R_SCHEDULE | 1 | 4.2% | 11.6%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `14268546710`, `13838078059`, `14354352389`, `13853268363`, `14504042664`
- **Canonical:** — (nuance register)

### R56-047 — Small storefronts (severely limited evidence): GB n=8 mean 4.75, the only 3★ (scheduling) and the most detailed review (ADHD); AR n=5 all 5★, 4 of 5 name free-ness or a competitor's paywall and two specifically reject competitors' habit-count caps (not generalisable to price sensitivity); DE n=5 all 5★ and all five written in English — the only multi-review non-anglophone storefront where nobody wrote in the local language; contains the locale bug and the earliest dark-mode request; KR n=5 all 5★, 4 in Korean, the only storefront where widget design headlines the review, source of the transparency report, the earliest review and earliest scheduling request (both 20 Feb 2026); PH n=3 mean 4.67, the data-loss report and a scheduling request

- **Where:** §6.3, §6.4, §6.5, §6.6, §6.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** GB 8; AR 5; DE 5; KR 5; PH 3
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `13996707039`, `14472221855`, `14201101389`, `13914688458`, `14151336984`, `14389211332`, `14392368857`, `13784066083`, `14122888123`, `14173024754`, `14194139904`, `14376181527`, `14370026168`, `14210943801`, `13768486794`, `13770961885`, `14260223015`, `14239464502`
- **Canonical:** — (nuance register)

### R56-048 — Storefronts with 1–2 reviews — 22 reviews (32.84%), callouts only (verbatim table): GB the ADHD review; SG 'No subscription, no guilt', only back-log praise and only analytics request; NL Spanish text on a Netherlands storefront; IN only export and only '>4 widgets' requests, both answered in v2.3.0; ES the only review naming privacy as the primary value and the only non-habit use case (project tracking); HU the only review naming optional iCloud sync as a design decision; KZ the only Russian-language outcome report; TW the only deadline request; BE the only widget-tap defect; ZA the most explicit rating rationale

- **Where:** §6.8 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** ID | Storefront | Why it is worth reading despite n=1 ; 14472221855 | GB | The ADHD review — the single most detailed review in the corpus (§6.9) ; 14461677979 | SG | Only P_BACKLOG praise; only R_ANALYTICS request; *"No subscription, no guilt"* ; 14401566211 | NL | Spanish text on a Netherlands storefront — storefront ≠ nationality (warning 7) ; 14330479445 | IN | Only export request; only ">4 widgets" request. Both answered in v2.3.0 ; 14294687098 | ES | Only review naming privacy as the *primary* value; only non-habit use case (project tracking) ; 14408586581 | HU | Only review naming *optional* iCloud sync — the design decision, not just the feature ; 14227146007 | KZ | Only Russian-language outcome report: *"соблюдаю дисциплину"* ; 14414692804 | TW | Only "deadline" request — a different product need from recurring habits (§3.4) ; 14422180050 | BE | Only widget-tap defect ; 14109432526 | ZA | Most explicit rating rationale in the corpus: names exactly what would make it 5★
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `14472221855`, `14461677979`, `14401566211`, `14330479445`, `14294687098`, `14408586581`, `14227146007`, `14414692804`, `14422180050`, `14109432526`
- **Canonical:** — (nuance register)

### R56-050 — High-spend group (conventional proxy, not measured: US, GB, CA, AU, DE, KR, TW, SG, NL, BE, ES) 51 reviews (76.12%, 4.922) vs other 16 (23.88%, 4.875) (verbatim): P_FREE 47.1% vs 43.8%; P_SIMPLE 56.9% vs 62.5%; competitor paywall 11.8% vs 18.8%; widget 11.8% vs 18.8%; design 35.3% vs 12.5% (least reliable, 2 reviews) — the finding that matters: praise for free-ness is essentially flat between high-spend and other markets, so 'free' is not a low-ARPU phenomenon that could be paywalled away in rich storefronts

- **Where:** §6.10 tables (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Group | Reviews | % of 67 | Mean ★ ; High-spend group (11 storefronts) | 51 | 76.12% | 4.922 ; All other storefronts (AR, BR, HU, IN, KZ, PH, RU, ZA) | 16 | 23.88% | 4.875 || Theme | High-spend % of 51 | Other % of 16 ; P_FREE | 47.1% (24) | 43.8% (7) ; P_SIMPLE | 56.9% (29) | 62.5% (10) ; M_COMPETITOR_PAYWALL | 11.8% (6) | 18.8% (3) ; P_WIDGET | 11.8% (6) | 18.8% (3) ; P_DESIGN | 35.3% (18) | 12.5% (2)
- **Direction for us:** product-rule · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C001 Never move a free feature behind the paywall

### R56-051 — High-review-volume group (review volume only, not downloads: US 24, GB 8, AR 5, DE 5, KR 5) 47 (70.15%, 4.936) vs other 14 storefronts 20 (4.850) (verbatim); 24 of 43 polled storefronts returned zero reviews, including Japan, France, Italy, Mexico, Turkey, Poland, Portugal, Thailand, Indonesia, Vietnam and Ukraine — speculative distribution reading: traction concentrated in US/UK plus AR, DE, KR and absent from most of Europe, Latin America outside Argentina and Brazil, Japan and Southeast Asia; the Japanese zero is most striking because the listing claims Japanese localisation — check against install data

- **Where:** §6.11 table (verbatim) and reading
- **This app does:** claims Japanese localisation; zero Japanese reviews
- **User reaction:** n/a
- **Magnitude:** Group | Reviews | % of 67 | Mean ★ ; Top-5 volume storefronts | 47 | 70.15% | 4.936 ; All other 14 storefronts | 20 | 29.85% | 4.850
- **Direction for us:** research · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** C027 Localise early — it unlocks revenue

### R56-052 — Global comparison: uniform — zero complaints about Dots' own monetisation in all 19 storefronts; 14 of 19 storefronts mean exactly 5.00 (exceptions US 4.96, GB 4.75, PH 4.67, BE 4.00, ZA 4.00, each explained by a specific fixable cause); every top theme drawn from simplicity, free-ness or design; aggregate uniformity is not storefront uniformity (verbatim scatter table: P_SIMPLE / P_FREE — US 54% / 46%, GB 62% / 75%, AR 20% / 80%, DE 80% / 40%, KR 60% / 20%, PH 67% / 0%) — noise on 3–8 reviews, not national character; not uniform (hypotheses): scheduling requests skew non-US (5 of 6), design praise non-US and high-spend, outcome narration US, widget-as-headline KR; localisation: 16 non-English reviews (Spanish 8, Korean 4, Portuguese 2, Russian 1, Traditional Chinese 1) rate 5.000 vs English 4.882

- **Where:** §6.12 table (verbatim) and localisation
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Storefront | n | P_SIMPLE | P_FREE ; US | 24 | 54% (13) | 46% (11) ; GB | 8 | 62% (5) | 75% (6) ; AR | 5 | 20% (1) | 80% (4) ; DE | 5 | 80% (4) | 40% (2) ; KR | 5 | 60% (3) | 20% (1) ; PH | 3 | 67% (2) | 0% (0)
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R56-005 — Reviews by month (verbatim): Feb 2026 3 (5.00); Mar 5 (5.00); Apr 4 (4.50); May 5 (4.80); Jun 16 (5.00); Jul 12 (4.83); Aug 20 (4.95); Sep to the 6th 2 (5.00) — volume roughly tripled: 17 reviews in the first 101 days (5.1/month) vs 50 in the next 98 (15.5/month); burst check — no day above 3 reviews, all 67 authors distinct, the 5 Aug trio spans AR and IN with unrelated texts — no review burst, farm or coordinated solicitation; the 5★ skew is genuine satisfaction plus prompt timing

- **Where:** §1.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Month | Reviews | % of 67 | Mean ★ ; 2026-02 | 3 | 4.48% | 5.00 ; 2026-03 | 5 | 7.46% | 5.00 ; 2026-04 | 4 | 5.97% | 4.50 ; 2026-05 | 5 | 7.46% | 4.80 ; 2026-06 | 16 | 23.88% | 5.00 ; 2026-07 | 12 | 17.91% | 4.83 ; 2026-08 | 20 | 29.85% | 4.95 ; 2026-09 (partial, to the 6th) | 2 | 2.99% | 5.00
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `14389211332`, `14392368857`, `14391385102`
- **Canonical:** — (nuance register)

### R56-054 — Trend 1 — search-driven acquisition rising (emerging, medium confidence): P_SEARCH_END P1 17.6% (3) → P2 17.9% (5) → P3 31.8% (7) — 'Tried many apps'; 'tried a couple… hated them immediately'; 'After looking around for a free app'; 'the app I was looking for' — found by searchers more than before, consistent with improving store visibility

- **Where:** §7.2
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 3 → 5 → 7
- **Direction for us:** none · **Report confidence:** medium confidence · **Generalisable:** app-specific
- **Review IDs:** `14461677979`, `14504042664`, `14518114843`, `14457759095`
- **Canonical:** — (nuance register)

### R56-055 — Trend 2 — ratings and volume both improving (improving, medium confidence): mean 4.824 → 4.929 → 4.955 while monthly volume roughly quadrupled (~4.3/month → ~16/month) — rising volume with rising satisfaction is the healthy pattern; improvement of 0.13 stars driven by the disappearance of the 3★ and two 4★; ceiling effects apply

- **Where:** §7.3
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 4.824 → 4.955; ~4.3 → ~16/month
- **Direction for us:** none · **Report confidence:** medium confidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R56-056 — Trend 3 — two top requests shipped mid-corpus and the requests kept coming (high confidence) (verbatim arc): notifications requested 14 Apr ('if there is and I just haven't found it yet my apologies'); reorder 8 May, 30 May; per-habit reminders and iPad sync 28 Jun; reminders 29 Jun; reorder 4 Jul; 29 Jul 'It didn't have options for reminders & shuffling the order of your habits, but it does now! -Even more happy with it'; notifications still requested 5 Aug and 18 Aug — reorder requests stopped dead after the ship date (4 before, 0 after) while notification requests did not (2 more in three weeks); reordering is visible in the list UI, a reminder setting buried in the habit editor is not; the developer's v2.3.2 (25 Aug) added a bell icon on the habit screen and every row to make reminders 'easier to reach'

- **Where:** §7.4 table (verbatim)
- **This app does:** reminders shipped but buried in the editor
- **User reaction:** mixed
- **Magnitude:** Date | ID | Storefront | Evidence ; 2026-04-14 | 13958079059 | US | Requests notifications — *and hedges*: "if there is and I just haven't found it yet my apologies" ; 2026-05-08 | 14040460063 | US | Requests reorder ; 2026-05-30 | 14122888123 | DE | Requests reorder ; 2026-06-28 | 14235241668 | US | Requests per-habit notification reminders, and iPad sync ; 2026-06-29 | 14239464502 | PH | Requests reminders ; 2026-07-04 | 14260223015 | PH | Requests reorder ; 2026-07-29 | 14363670791 | GB | *"It didn't have options for reminders & shuffling the order of your habits, but it does now! -Even more happy with it."* ; 2026-08-05 | 14392368857 | AR | Still requests notifications — *"si le agregarán notificaciones"* ; 2026-08-18 | 14444070845 | US | Still requests notifications — *"Eager next for notification… options"*
- **Direction for us:** must-have · **Report confidence:** high confidence · **Generalisable:** generalisable
- **Review IDs:** `13958079059`, `14040460063`, `14122888123`, `14235241668`, `14239464502`, `14260223015`, `14363670791`, `14392368857`, `14444070845`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free; C142 Surface existing features where users look

### R56-059 — Trend 4 — the sync arc: requested → broke → praised (verbatim): 28 Jun US requests iPhone ↔ iPad sync; 4 Jul PH 'the recent update about sync made my habits disappear' — data loss, 4★; 10 Aug HU titles a review 'Simple, free, privacy friendly - optional icloud sync' — 5★; six days from request to a data-loss report, five weeks later the feature headlines a positive review and is praised for being optional — the only evidence of a shipped feature causing user harm, and it involves the habit history 10 outcome reviewers keep the app for

- **Where:** §7.5 table (verbatim)
- **This app does:** optional iCloud sync shipped Jun–Jul 2026
- **User reaction:** mixed
- **Magnitude:** Date | ID | Event ; 2026-06-28 | 14235241668 | US requests iPhone ↔ iPad sync ; 2026-07-04 | 14260223015 | PH: *"the recent update about sync made my habits disappear"* — data loss, rating drops to 4★ ; 2026-08-10 | 14408586581 | HU: title is *"Simple, free, privacy friendly - optional icloud sync"* — 5★
- **Direction for us:** must-never-break · **Report confidence:** medium confidence · **Generalisable:** generalisable
- **Review IDs:** `14235241668`, `14260223015`, `14408586581`
- **Canonical:** C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change; C175 Updates must not break function or wipe progress

### R56-060 — Trends 5–8: ad-freeness praise P1 5.9% (1) → P2 14.3% (4) → P3 18.2% (4) — compositional (low confidence); simplicity praise P1 58.8% (10) → P2 50.0% (14) → P3 68.2% (15), never below half — the most stable theme and safest basis for decisions; free-ness praise P1 58.8% (10) → P2 39.3% (11) → P3 45.5% (10), absolute count constant at 10–11 — no evidence the 'it's free' novelty is wearing off; defects cluster in P2 — five of six reports Jun–Jul, one in P3, none in P1 — a buggier build cycle around the sync rollout or a small-bucket artefact (observation only)

- **Where:** §7.6, §7.7, §7.8, §7.9
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as listed
- **Direction for us:** none · **Report confidence:** low–medium confidence · **Generalisable:** app-specific
- **Review IDs:** `14194139904`, `14201101389`, `14210943801`, `14260223015`, `14262513041`, `14422180050`
- **Canonical:** — (nuance register)

## Positioning

### R56-001 — Dots: Habit Tracker Widget (App Store ID 6758730376; subtitle 'Daily Routine, Goal & Planner') by Juyong Bak (bundle net.sundragon.dotsapp) — 67 reviews, 19 storefronts, 20 Feb → 6 Sep 2026 (199 days), mean 4.910, extracted 8 Sep 2026, analysed 12 Sep 2026; a young, fully free habit tracker (unlimited habits, home-screen widgets, card / list / calendar / heat-map views, no ads, no account, no data collection) with no evidenced monetisation — 'free' is the single most-cited reason people choose it and stay; listing (search snippets) requires iOS 17.6+, iPadOS, Korean and Japanese

- **Where:** header lines 1-6
- **This app does:** fully free; no paid tier; no ads
- **User reaction:** praise
- **Magnitude:** 67 reviews; mean 4.910
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R56-016 — Search ended / displacement 15 (22.39%, dominant, all 5★): 'i've uninstalled like 5 habit trackers this year lol… the one i actually kept'; 'Tried many apps, but decided to stick with this one'; 'I tried a couple of them on the App Store and hated them immediately. They usually ask 20 questions just to get started'; 'Was looking for a free minimalist habit tracker app with widgets and ended up with this gem' (RU); 'Free and has widgets… I have not found others that have both' — the two named search criteria together define the positioning: free and widgets; accelerating P1 17.6% → P2 17.9% → P3 31.8%

- **Where:** §3.3.5
- **This app does:** free + widgets
- **User reaction:** praise
- **Magnitude:** 15 (22.39%); 17.6% → 17.9% → 31.8%
- **Direction for us:** do · **Report confidence:** dominant · **Generalisable:** generalisable
- **Review IDs:** `13853268363`, `14461677979`, `14504042664`, `14067204894`, `14400919999`, `14518114843`
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R56-034 — A store preview shows a widget-transparency setting the user cannot find in the app (KR) — the listing promises what the user cannot locate

- **Where:** §3.5 store preview discoverability
- **This app does:** preview shows unreachable setting
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** dont · **Report confidence:** single · **Generalisable:** generalisable
- **Review IDs:** `14210943801`
- **Canonical:** C142 Surface existing features where users look; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Things not to do

### R56-042 — What reviewers said they would not tolerate, drawn from what made them leave competitors (verbatim): subscription required for core use — caused them to delete the competitor; habit-count cap behind a paywall — explicitly rejected, 'unlimited' is why they stayed; widgets gated behind a subscription — rejected; free-trial-then-charge ('no obnoxious free-trial trick'; 'no false promises') — rejected; ads — caused instant deletion of competitors

- **Where:** §5.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Monetization pattern | Named by | Verdict in corpus ; Subscription required for core use | 14040460063, 14160827585, 14151336984 | Caused them to delete the competitor ; Habit-count cap behind a paywall | 14151336984, 14392368857, 14109432526 | Explicitly rejected; "unlimited" is why they stayed ; Widgets gated behind a subscription | 14148473814 | Explicitly rejected ; Free-trial-then-charge pattern | 14363670791 ("no obnoxious free-trial trick"), 14389211332 ("sin promesas falsas") | Explicitly rejected ; Ads | 14160827585, plus 8 more praising ad-freeness | Caused instant deletion of competitors
- **Direction for us:** dont · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14040460063`, `14160827585`, `14151336984`, `14392368857`, `14109432526`, `14148473814`, `14363670791`, `14389211332`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R56-074 — Do not add streak pressure, scores or gamification in a product chosen for restraint — only one reviewer asked for streaks, while 'no subscription, no guilt' and 39 restraint reviews argue that a streak-loss mechanic is exactly the pressure users left other apps to escape

- **Where:** §8.5 streaks
- **This app does:** no streaks
- **User reaction:** praise
- **Magnitude:** R_STREAK 1 vs P_SIMPLE 39
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14174214597`, `14461677979`
- **Canonical:** C024 Streaks / gamification

### R56-075 — Do not add social, sharing or AI features — zero of 67 requested any ('does exactly that and nothing more')

- **Where:** §8.5 AI and social
- **This app does:** none
- **User reaction:** praise
- **Magnitude:** 0 requests
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14122888123`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C056 Don't build AI features on demand grounds

## Things to do

### R56-065 — F4: reply to the four unanswered in-review support questions — data recovery, widget transparency (in Korean), language reset, back-dating — all answerable in one sentence; 13 reviewers already thank the developer by name

- **Where:** §8.1 F4
- **This app does:** support questions left unanswered in reviews
- **User reaction:** n/a
- **Magnitude:** 4 questions
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14260223015`, `14210943801`, `14194139904`, `14226473114`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R56-070 — D6: claim the positioning the corpus already gives — users describe it as free with no strings, simple, no ads, no account, no data collection, unlimited, beautiful, with widgets; 'With Dots, you get exactly what you download'; the listing leads with the category's language ('simplicity, clarity, and daily consistency') while the corpus's language is 'actually free, no strings, nothing extra' — positioning against the category, which is how the 15 search-end reviewers found it; E5: rewrite the listing in the corpus's own words and watch store conversion and search-end share; do not claim the ADHD positioning (n=1, and that reviewer's complaint is that competitors claim it hollowly)

- **Where:** §8.2 D6; §8.3 E5
- **This app does:** listing uses category language
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14472221855`
- **Canonical:** C134 Lead the store listing with what users actually love

## Contradictions

### R56-076 — A 4.91★ corpus with zero 1★ and zero 2★ in 199 days contradicts the usual reading of high ratings as product health: defect reporters average 4.50 and wrap complaints in praise, two 5★ reviews report functional defects, and the users driven away wrote nothing — theme counts, not the star average, must judge health

- **Where:** §3.5 forgiveness; §4.4; §8.4 Q3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 0 1★ / 0 2★; defect reporters 4.50
- **Direction for us:** research · **Report confidence:** method statement · **Generalisable:** generalisable
- **Review IDs:** `14201101389`, `14194139904`, `14422180050`
- **Canonical:** C002 Ratings follow the offer, not the feature set

## Data caveats and method

### R56-002 — Method: all 67 reviews read individually in original language (Spanish 8, Korean 4, Portuguese 2, Russian 1, Traditional Chinese 1); 46 hand-assigned themes, no automated classifier, clustering, keyword rule or LLM batch labelling; validated PASS — zero unknown IDs, zero intra-theme duplicates, zero unassigned, unique IDs, country-file reconciliation; 13 fields, no nulls; 67 unique IDs, 67 distinct authors; no deduplication needed; manifest match {5:62, 4:4, 3:1, 2:0, 1:0}, mean 4.9104; body median 123 characters; only 2 reviews have votes, 3 edited; six bodies with raw HTML entities decoded when read; no version, device, subscription or purchase fields; 43 storefronts polled per _state.json, 24 returned zero reviews (jp, fr, se, no, it, nz, ae, mx, id, vn, th, tr, co, cl, pe, pl, ua, my, ro, pt, dz, ee, ma, tn) — confirmed empty, not a collection gap; every aggregate computed by script; an absolute-count confidence tier (single / corroborated / pattern / dominant) printed beside every signal label because percentages inflate at n=67

- **Where:** §How to read this; §1.1–1.3, §1.5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 67 (100%)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `13853268363`, `14173024754`, `14262513041`, `14354352389`, `14362641244`, `14363670791`
- **Canonical:** — (nuance register)

### R56-003 — Warnings: n=67 — one review is 1.4925%, a single reviewer scores 'meaningful' and four score 'high-priority', so labels are mechanically inflated and no percentage may be quoted without its count; no storefront reaches 50 (US 24), every country section limited evidence; volunteers skew positive and prompt timing hides silent churners; the corpus is young — 199 days, 50 of 67 (74.63%) on or after 1 Jun 2026, trends directional only; storefront ≠ nationality (Spanish text on the Netherlands storefront); 16 of 67 (23.88%) non-English; single-analyst classification; external facts lower-confidence (apps.apple.com egress-blocked)

- **Where:** §Seven warnings 1, 3, 5–7; §1.6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** one review = 1.49%
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `14401566211`
- **Canonical:** — (nuance register)

### R56-004 — The rating distribution is extreme and one-sided: 62×5★ (92.54%), 4×4★ (5.97%), 1×3★ (1.49%), zero 2★, zero 1★ across 199 days and 19 storefronts — the corpus documents why people love the app and contains almost no evidence about why anyone leaves; do not read the absence of complaints as the absence of problems; a 4.91★ is selection bias, not proof of product health

- **Where:** §Seven warnings 2; Part 4 table; §4.4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Rating | n | % of 67 | Cumulative ; 5★ | 62 | 92.54% | 92.54% ; 4★ | 4 | 5.97% | 98.51% ; 3★ | 1 | 1.49% | 100% ; 2★ | 0 | 0.00% | — ; 1★ | 0 | 0.00% | —
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** generalisable
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R56-010 — External sources (search-result snippets of the listing, retrieved 12 Sep 2026; apps.apple.com egress-blocked; lower confidence than reviews, used only for corroboration) (verbatim): 'Dots is a free habit tracker designed for simplicity, clarity, and daily consistency', log from the heatmap widget with one tap; 'The developer does not collect any data from this app'; iOS 17.6+, iPadOS, Korean and Japanese; v2.3.0 added export/import to a single JSON file and expanded icons to 42 including pets (answers the export request and icon requests); v2.3.2 (25 Aug 2026) 'reminders are easier to reach and widget taps land every time' with a bell icon on the habit screen and every row (answers the reminder-discoverability finding and the widget-tap bug); one aggregator says 'in-app purchases are accessible within Dots' — low confidence, contradicted by the corpus, flagged as an open question — the v2.3.2 note shows the developer independently reached the conclusion that the reminder problem was discoverability

- **Where:** §2.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** External claim | Source | Confidence | Corroborates ; "Dots is a free habit tracker designed for simplicity, clarity, and daily consistency"; log habits from the heatmap widget with one tap without opening the app | App Store listing (apps.apple.com/us/app/dots-habit-tracker-widget/id6758730376), accessed 2026-09-12 | Medium | P_FREE, P_SIMPLE, P_WIDGET ; "The developer does not collect any data from this app" | same | Medium | P_PRIVACY (14294687098, 14408586581) ; Requires iOS 17.6+; iPadOS; Korean and Japanese language support | same | Medium | iPad request 14235241668; Chinese-language defect 14194139904 is *not* explained by this ; v2.3.0 added habit export/import to a single JSON file, and expanded the icon set to 42 icons including pets | same | Medium | Directly answers R_EXPORT (14330479445, 2026-07-21) and R_ICONS (5 reviewers) ; v2.3.2 (updated 2026-08-25): "reminders are easier to reach and widget taps land every time" — a bell icon on the habit screen and on every habit row | same | Medium | Directly answers the reminder-discoverability finding (§7.4) and B_WIDGET_TAP (14422180050, 2026-08-13) ; One aggregator states "in-app purchases are accessible within Dots" | third-party aggregator snippet, accessed 2026-09-12 | Low — treat as unverified | Contradicted by the corpus: 0 / 67 reviewers mention any purchase, and 9 praise the *absence* of IAP. Flagged as an open question in §8.4, not used as a finding.
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `14330479445`, `14422180050`
- **Canonical:** — (nuance register)

### R56-011 — Theme-family aggregates, unique reviewers (verbatim): UX family (simple ∪ design ∪ views ∪ dots) 42 (62.69%, 4.93); free-value family (free ∪ no ads ∪ unlimited ∪ competitor paywall) 35 (52.24%, 4.91); pure praise — no request, no defect 37 (55.22%, 5.00); any request 26 (38.81%, 4.85); any defect or friction 6 (8.96%, 4.50) — in this corpus requesting is a form of engagement, not dissatisfaction; only one requester rated below 4; the 46-theme master table is in §9.5

- **Where:** §3.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Family | Unique reviewers | % of 67 | Signal label | Confidence tier | Mean ★ ; UX family (P_SIMPLE ∪ P_DESIGN ∪ P_VIEWS ∪ P_DOTS) | 42 | 62.69% | high-priority | dominant | 4.93 ; Free-value family (P_FREE ∪ P_NOADS ∪ P_UNLIMITED ∪ M_COMPETITOR_PAYWALL) | 35 | 52.24% | high-priority | dominant | 4.91 ; Pure praise — no request, no defect | 37 | 55.22% | high-priority | dominant | 5.00 ; Any request (R_* union) | 26 | 38.81% | high-priority | dominant | 4.85 ; Any defect or friction (B_* ∪ F_* union) | 6 | 8.96% | high-priority | pattern | 4.50
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `13996707039`
- **Canonical:** — (nuance register)

### R56-038 — Rating / text contradictions (verbatim): a 5★ reporting a date-rendering bug ('the calendar is a day out… would be perfect if fixed'); a 5★ reporting the UI switching language unprompted — both inflate the mean; with zero 1★/2★ they support the conclusion that star ratings systematically understate friction: use theme counts, not the star average

- **Where:** §4.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ID | Rating | Contradiction ; 14201101389 | 5★ | Body reports a date-rendering bug: *"the calendar is a day out… would be perfect if fixed."* A functional defect, rated 5★. ; 14194139904 | 5★ | Body reports the UI switching language unprompted and asks how to undo it. A functional defect, rated 5★.
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14201101389`, `14194139904`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R56-039 — How themes differ by rating: P_FREE in 29 of 62 five-stars and in both non-5★ reviews that mention money — praise for the free model is rating-independent; P_SIMPLE 58.06% of 5★ and 3 of 5 non-5★; R_ICONS splits 3 / 2 between 5★ and lower — the same request costs a star for some and not others; every defect other than the two contradictions appears in a 4★ — defects move the rating, requests mostly do not

- **Where:** §4.6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

### R56-053 — Trend method (verbatim): P1 early Feb → May 2026 17 reviews (25.37%, 4.824); P2 middle Jun → Jul 28 (41.79%, 4.929); P3 recent Aug → 6 Sep 22 (32.84%, 4.955) — one review moves a rate 3.6–5.9 points; no trend below a ~15-point swing is distinguishable from noise; no version field, attribution only via external release notes

- **Where:** §7.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Period | Months | Reviews | % of 67 | Mean ★ ; P1 — early | 2026-02 → 2026-05 | 17 | 25.37% | 4.824 ; P2 — middle | 2026-06 → 2026-07 | 28 | 41.79% | 4.929 ; P3 — recent | 2026-08 → 2026-09-06 | 22 | 32.84% | 4.955
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R56-061 — What the corpus cannot tell about time: nothing about churn (no 1★/2★ in any period); nothing about build regressions (no version field); nothing before 20 Feb 2026 (launch or crawl horizon unknown); nothing about retention (3 edited reviews plus one in-text update — four longitudinal data points); nothing about September (2 reviews)

- **Where:** §7.10
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 4 longitudinal data points
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `14268546710`, `14272015279`, `14354352389`, `14260223015`
- **Canonical:** — (nuance register)
