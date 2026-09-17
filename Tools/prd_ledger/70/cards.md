# Cards — report 70

Source: `App Store Reports/70. Habit - Daily routine tracker - Goal planner & Streaks (REPORT).md`  
36 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 2
- [Must-haves](#must-haves) — 3
- [Must never break](#must-never-break) — 2
- [Features](#features) — 4
- [Monetization](#monetization) — 2
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 3
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 2
- [Dated events and trends](#dated-events-and-trends) — 4
- [Positioning](#positioning) — 1
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 1
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 6

## Product rules

### R70-004 — The product works by subtraction — one small goal, one tap, thirty days: PR_SIMPLE 448 (19.56%, high-priority, mean 4.90, 2016 → 2026), PR_CONCEPT 262 (11.44%, 4.87), PR_ONE_GOAL 148 (6.46%, 4.87); ONE_GOAL_CONVERT 28 (1.22%) disliked the one-goal rule at first and came to agree with it: 'At first I thought it was hard to use, with too many restrictions, but I realised they are firmly based on the maker's philosophy of how to keep going'; 'At first I was saying let me add another goal!, but as I kept going I came to think this is how it should be'; the setup flow that pushes goals to five minutes or less is praised as a feature: 'I was really grateful that the app itself asked me, can you really do that in 5 minutes?'; 'just sit at the desk' — the small goal overflows (that reviewer now studies about two hours a day); the most-voted review (354 votes): 「信じてください。続きます。」 ('Believe me. It sticks.'); §8.9 keep the guided setup that shrinks goals, one goal, one tap

- **Where:** §0.1; §3.2 design of small commitments; §8.9
- **This app does:** one goal; ≤5-minute guided setup; 30-day ring
- **User reaction:** 5★-burst
- **Magnitude:** PR_SIMPLE 448 (19.56%) 4.90; PR_CONCEPT 262; PR_ONE_GOAL 148; ONE_GOAL_CONVERT 28; top review 354 votes
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `1558166349`, `13314939713`, `5953466116`, `5555608923`, `11834726322`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes; C290 Guide every new goal down to something doable on a bad day — a setup that asks 'can you really do that in 5 minutes?' is a feature users thank

### R70-019 — Free, no ads, no data: PR_FREE 149 (6.51%, high-priority, mean 4.87), rising from 1.4% of E1 to 11.2% of E3 as reviewers contrast ad-supported and subscription-first apps they tried (CMP_OTHER_APPS 60); PR_PRIVACY 4 add that it collects no personal data; 「このアプリ全然お金の匂いがしないんです。」 ('This app doesn't smell of money at all'); §8.9 keep no ads, no data collection and no forced payment — 'named as reasons to trust and to pay'

- **Where:** §3.2 free, no ads, no data
- **This app does:** free, no ads, no personal data
- **User reaction:** praise
- **Magnitude:** PR_FREE 149 (6.51%) 4.87; 1.4% → 11.2%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `5893755217`, `1757827408`, `13157065902`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C085 Address tracking / privacy visibly; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

## Must-haves

### R70-007 — The same voice alienates a minority, loudly: tone and notification complaints NEG_COMMENT_TONE 7 ∪ NEG_NOTIF_ANNOY 9 = 14 (0.61%, emerging, mean 2.50, 2018-03-09 → 2025-06-20) — 3 before 2023, 11 from 2023, 9 in E4: 「これじゃ893と変わらないんですけど。」 ('This is no different from the yakuza', 18 votes); 'I definitely turned notifications off, yet they keep coming'; 'The jokey tone is way too cringey'; 'The cheerleading energy and jokiness give me goosebumps'; a flippant 'only when you reeeeally need to' warning; 'the badge makes me feel blamed all day and weighs on me' (5★); a long-term user asks for exactly the missing control — 'please let me switch the encouragement comments fully off'; the wellbeing audience makes it sensitive — 'a pushy tone that motivates one user can shame another'; §8.3: a quiet mode — one setting that switches the encouragement line, the 'are you sure' jokes and the badge to plain neutral text, keeping the voice as default

- **Where:** §0.2 tone; §3.6; §8.3
- **This app does:** no off switch for the voice
- **User reaction:** 1★-burst
- **Magnitude:** 14 (0.61%) 2.50; 11 of 14 since 2023
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `7553106036`, `10598709745`, `10527702382`, `10317633924`, `10058846156`, `12796168055`, `11568521715`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C123 Notifications are few and finely user-controllable — per-type settings, escalation opt-in, never spammy and never silently retuned; C289 An app with a personality voice needs one 'quiet mode' switch — encouragement lines, jokes and badges to plain neutral text — while the voice stays the default

### R70-009 — The rules are strict and real life breaks them: U_RULE_FRICTION 114 (4.98%, very strong, mean 4.06) — the two-day reset, fixed 30-day cycle and day boundary are the discipline; PR_RESET_TENSION 40 (1.75%) praise it; hurt when illness, a menstrual period or a school trip interrupts (REQ_PAUSE 10, NEG_RESET_RULE 14): 'sometimes you can't do it when you're unwell' (1★); 「生理が来ると、2日くらいお休みしたい人も中にはいるのです。」 ('When our period comes, some of us want about two days off'); strength-training users: rest days are part of training (REQ_FREQ 8); rule friction codes (verbatim): Code | Meaning | n | % of 2,290 | Band | Mean ★ ; REQ_MULTI | Wants more than one habit | 44 | 1.92% | Meaningful signal | 4.39 ; NEG_RESET_RULE | Dislikes the 2-day reset | 14 | 0.61% | Emerging signal | 3.21 ; REQ_RESET_BACK | Wants the automatic reset back (or optional) | 13 | 0.57% | Emerging signal | 4.08 ; REQ_PERIOD | Wants shorter / custom periods | 13 | 0.57% | Emerging signal | 4.69 ; NEG_DAYBOUNDARY | Day rollover time is a problem | 11 | 0.48% | Weak signal | 3.45 ; NEG_PREVDAY_FLOW | Previous-day entry / backfill is awkward | 11 | 0.48% | Weak signal | 3.45 ; NEG_RULES_UNCLEAR | Rules not explained in the app | 9 | 0.39% | Weak signal | 4.11 ; REQ_DAYBOUNDARY_SET | Wants to set the day-change / reset time | 6 | 0.26% | Weak signal | 3.83 ; NEG_PERIOD_FIXED | Fixed challenge lengths | 5 | 0.22% | Weak signal | 3.40 ; NEG_90_REMOVED | Objects to losing the 90-day option | 3 | 0.13% | Weak signal | 4.67 ; REQ_PAUSE | Wants to pause / skip days (illness, period, travel) | 10 | 0.44% | Weak signal | 4.00 ; REQ_FREQ | Wants non-daily frequency | 8 | 0.35% | Weak signal | 4.38 — most still rate 4–5★ and ask for flexibility, not removal; §8.6: a limited honest rest day (e.g. two per cycle) plus an optional strict mode for those who want it — 'Both camps have existed since 2018, so a single rule will keep losing one of them'

- **Where:** §0.4; §3.3 table (verbatim); §8.6
- **This app does:** 2-day reset; fixed 30 days; no pause
- **User reaction:** mixed
- **Magnitude:** RULE_FRICTION 114 (4.98%) 4.06; PAUSE 10; RESET_RULE 14 (3.21)
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `1712808912`, `11522188751`, `1663994021`, `12884112714`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R70-011 — Day boundary, cycle length and visible dates: night workers and late studiers get caught between midnight and 3 a.m. ('if I record at 15:00 one day, I can't record at 10:00 the next'; NEG_DAYBOUNDARY 11, REQ_DAYBOUNDARY_SET 6) while a night-shift worker values choosing yesterday or today after midnight; people who finish 30 days want to keep counting ('I want to see how far I can extend the record beyond 30 days!'; REQ_PERIOD 13); no visible dates — 'because no dates are shown, from about day 3 I lost track of whether I'd recorded or not, got confused and uninstalled'; §8.1: show the date being recorded on the ring — most day-boundary confusion comes from not seeing which day a tap counts for

- **Where:** §3.3 day boundary / longer cycles / no dates; §8.1
- **This app does:** no date on the ring; 3 a.m. boundary
- **User reaction:** churn
- **Magnitude:** DAYBOUNDARY 11 (3.45); PREVDAY_FLOW 11; PERIOD 13; RULES_UNCLEAR 9
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `6059617063`, `14505391902`, `12910203779`, `8693987085`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C170 Configurable day boundary and hemisphere seasons; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

## Must never break

### R70-012 — Defects hit the one action that matters, recording today's success: U_BUG_ANY 104 (4.54%, very strong, mean 3.29), 24 of 50 1★ (48.00%) carry a defect code (verbatim): Code | Meaning | n | % of 2,290 | Band | Mean ★ ; BUG_NOTIF | Wrong / unwanted / missing notifications | 38 | 1.66% | Meaningful signal | 3.42 ; BUG_INPUT | Cannot record a day | 20 | 0.87% | Emerging signal | 2.75 ; BUG_COUNT | Day count wrong | 12 | 0.52% | Emerging signal | 2.83 ; BUG_DISPLAY | Wrong label / display glitch | 13 | 0.57% | Emerging signal | 4.15 ; BUG_RESET | Unexpected reset | 7 | 0.31% | Weak signal | 3.43 ; BUG_CRASH | Crashes | 5 | 0.22% | Weak signal | 1.80 ; BUG_IAP | In-app purchase stuck / not restored | 4 | 0.17% | Weak signal | 3.25 ; BUG_KEYBOARD | Keyboard hides button in setup | 3 | 0.13% | Weak signal | 3.33 ; BUG_LANG | Language switched unexpectedly after update | 2 | 0.09% | Ignore by default | 5.00 ; BUG_GENERIC | Stopped working (unspecified bug) | 2 | 0.09% | Ignore by default | 3.00 ; BUG_BATTERY | Battery drain | 1 | 0.04% | Ignore by default | 1.00 — recording blocked: tapping the ring shows the undo hint instead of recording, often from day 2 or 3 — 'A pop-up saying cancel with the top-right button appears; when I reluctantly delete it I'm back to day one' (BUG_INPUT 20, 2.75, reported 2017 → 2026); 'my five minutes of effort couldn't be recorded and went to waste'; 'There is a serious bug that, fairly often, wipes out the previous day's record'; wrong counts and phantom resets (counts stuck at 7 or 4, unrecorded flags on unscheduled weekdays); a user of several of the developer's apps: 'after a few months, all of them start producing an absurd run of bugs'; defect share falls 7.6% (E1) → 1.9% (E5) but recording defects persist a decade — 'For a product whose whole promise is an unbroken record, a lost day is the worst possible failure'; §8.1: eliminate the undo-hint loop, phantom resets and erased days; log every tap so a lost day can be restored

- **Where:** §0.5 table (verbatim); §3.4 table (verbatim); §8.1
- **This app does:** recording taps lost
- **User reaction:** 1★-burst
- **Magnitude:** U_BUG_ANY 104 (4.54%) 3.29; 48% of 1★; BUG_INPUT 20; BUG_COUNT 12; BUG_RESET 7
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `5861217675`, `7136283910`, `13935906932`, `7566282416`, `1553783592`, `10172688755`
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement

### R70-013 — Notifications that do not obey: BUG_NOTIF 38 (1.66%, meaningful, mean 3.42) — missing, duplicated after a new cycle, continuing for a deleted goal, or arriving after being switched off; §8.2: honour notifications-off, remove notifications for deleted or completed goals, prevent duplicates on a new cycle; allow weekday / weekend reminder times and later edits (REQ_NOTIF_EDIT 10)

- **Where:** §3.4 notifications; §8.2
- **This app does:** notifications after off / deleted goal
- **User reaction:** complaint
- **Magnitude:** BUG_NOTIF 38 (1.66%) 3.42; REQ_NOTIF_EDIT 10
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `10598709745`, `1960898756`
- **Canonical:** C039 Reminders fire reliably, once; C123 Notifications are few and finely user-controllable — per-type settings, escalation opt-in, never spammy and never silently retuned

## Features

### R70-006 — The encouragement layer keeps people coming back: PR_COMMENTS 428 (18.69%, high-priority, mean 4.93) — the daily one-line comment from the stick figure; PR_NOTIF 203 (8.86%, 4.84) the reminder that says 「やったれ！」 ('go for it!'); PR_HUMOR 106 (4.63%); PR_TIPS 102 (4.45%) — named more often than any feature except simplicity; many continue in order to see tomorrow's line: 'For someone starved of praise like me, this feature is truly the best'; 'The second notification arrived at a moment as if it had seen through my laziness'; §8.9 keep the encouragement line and humour as the default

- **Where:** §0.2; §3.2 encouragement; §8.9
- **This app does:** free encouragement voice
- **User reaction:** praise
- **Magnitude:** PR_COMMENTS 428 (18.69%) 4.93; PR_NOTIF 203 (8.86%); PR_HUMOR 106; PR_TIPS 102
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `5316192055`, `8737413152`, `11117049969`, `1549417557`
- **Canonical:** C039 Reminders fire reliably, once; C117 Mascot / companion character

### R70-008 — The top feature request collides with the core design: REQ_MULTI 44 (1.92%, meaningful, mean 4.39) against PR_ONE_GOAL 148 praising the limit; growing — 4.7% of E5, the highest of any era; narrower than 'many habits': keep a habit already completed while starting the next — 'Once you complete 30 days and start a new habit, the old habit is no longer notified' (3★); 'Please let me record about three goals in parallel'; 'I wish if I can add just one more task, it would be so good 2 tasks a day'; reviewers volunteer the compromise — unlock a second goal only after a first 30-day cycle; §8.5: after a cycle offer 'keep tracking this quietly' alongside 'set the next goal' — one active goal with reminders and encouragement, graduated habits kept as a low-key streak; answers most of REQ_MULTI and REQ_PERIOD (13) without giving up the discipline 148 credit; test on 60- and 90-day continuation, not goals created

- **Where:** §0.3; §3.5; §8.5
- **This app does:** one goal; finished habit fades
- **User reaction:** mixed
- **Magnitude:** REQ_MULTI 44 (1.92%) 4.39; 4.7% of E5
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `12651030354`, `14519088452`, `12157880557`, `1399663066`, `13760782567`
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes; C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot

### R70-023 — Unmet needs — U_REQ_ANY 212 (9.26%, high-priority, mean 4.28), rising 7.0% of E1 → 14.2% of E5 (verbatim): Code | Meaning | n | % of 2,290 | Band | Mean ★ ; REQ_MULTI | Wants more than one habit | 44 | 1.92% | Meaningful signal | 4.39 ; REQ_MORE_COMMENTS | Wants more encouragement messages | 21 | 0.92% | Emerging signal | 4.67 ; REQ_WIDGET | Wants a widget | 17 | 0.74% | Emerging signal | 4.76 ; REQ_PERIOD | Wants shorter / custom periods | 13 | 0.57% | Emerging signal | 4.69 ; REQ_RESET_BACK | Wants the automatic reset back (or optional) | 13 | 0.57% | Emerging signal | 4.08 ; REQ_IPAD | iPad layout / landscape | 13 | 0.57% | Emerging signal | 3.92 ; REQ_NOTIF_EDIT | Wants to change notification time later | 10 | 0.44% | Weak signal | 4.10 ; REQ_PAUSE | Wants to pause / skip days (illness, period, travel) | 10 | 0.44% | Weak signal | 4.00 ; REQ_CALENDAR | Wants a calendar view | 9 | 0.39% | Weak signal | 3.67 ; REQ_FREQ | Wants non-daily frequency | 8 | 0.35% | Weak signal | 4.38 ; REQ_HISTORY | Wants a history / done list / time log | 7 | 0.31% | Weak signal | 3.86 ; REQ_MEMO | Wants a note per check-in | 7 | 0.31% | Weak signal | 4.43 ; REQ_DAYBOUNDARY_SET | Wants to set the day-change / reset time | 6 | 0.26% | Weak signal | 3.83 ; REQ_TIMER | Wants a timer | 6 | 0.26% | Weak signal | 3.83 ; REQ_MULTI_PER_DAY | Wants multiple check-ins per day | 5 | 0.22% | Weak signal | 4.20 ; REQ_RENAME | Wants to edit / change the goal | 5 | 0.22% | Weak signal | 3.60 ; REQ_WATCH | Wants an Apple Watch version | 5 | 0.22% | Weak signal | 4.40 ; REQ_RECORD_MISS | Wants to record a missed day | 4 | 0.17% | Weak signal | 4.00 ; REQ_REPEAT_GOAL | Wants to restart with the same settings / choose start date | 4 | 0.17% | Weak signal | 4.50 ; REQ_GAMIFY | Wants a growing character / game element | 4 | 0.17% | Weak signal | 3.25 ; REQ_SYNC | Wants device sync / backup | 4 | 0.17% | Weak signal | 4.00 ; REQ_STATS | Wants progress visualised | 3 | 0.13% | Weak signal | 4.67 ; REQ_THEME | Wants custom background / theme | 3 | 0.13% | Weak signal | 4.67 ; REQ_LOCK | Wants a passcode lock | 2 | 0.09% | Ignore by default | 4.00 ; REQ_LANG_SELECT | Wants in-app language choice | 2 | 0.09% | Ignore by default | 4.50 ; REQ_RESTART | Wants a manual restart / delete of the current goal | 2 | 0.09% | Ignore by default | 3.50 ; REQ_TIPS | Wants more tips content | 1 | 0.04% | Ignore by default | 5.00 ; REQ_NOTIF_ACTION | Wants to record from the notification | 1 | 0.04% | Ignore by default | 4.00 ; REQ_SOCIAL | Wants social sharing / likes | 1 | 0.04% | Ignore by default | 5.00 ; REQ_CUSTOM_NOTIF | Wants to write own notification text | 1 | 0.04% | Ignore by default | 5.00 — more encouragement messages (21), widget (17), custom periods (13), reset back (13), iPad layout / landscape (13), later notification edit (10), pause (10), calendar view (9), non-daily frequency (8), history / done list (7), a note per check-in (7), day-change time (6), a timer (6), multiple check-ins per day (5), rename the goal (5), Apple Watch (5 — 'will make it 5★ if Apple Watch is supported'), record a missed day (4), restart with the same settings (4), a growing character (4), sync / backup (4); requests that conflict with the design (multiple goals, no reset, custom periods) sit beside praise of that design — §8 treats them as options, not replacements

- **Where:** §3.5 table (verbatim)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** REQ_ANY 212 (9.26%) 4.28; 7.0% → 14.2%
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `1399663066`, `12157880557`
- **Canonical:** C012 Week / month / year grid views; C013 Cloud sync / multi-device as the paid differentiator; C022 Apple Watch app (done properly: timer, two-way sync); C141 Native iPad layout; C172 Per-day / per-habit notes and journal text; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R70-034 — Capability-table positives that carry their own counts: the one-tap record with the previous day recordable until 3 a.m. is praised as forgiving (PR_GRACE 41) and fast (PR_FAST 7) against NEG_DAYBOUNDARY 11 and NEG_PREVDAY_FLOW 11; the History of completed cycles is praised (PR_HISTORY 31) while others want a calendar view (REQ_CALENDAR 9, mean 3.67), a done list / time log (REQ_HISTORY 7, 3.86) and a note per check-in (REQ_MEMO 7, 4.43); a passcode lock exists and is valued (PR_PRIVACY 4) with REQ_LOCK 2; developer essays in release notes are content (PR_RELNOTES 28) with one finding them too long (NEG_RELNOTES_LONG 1)

- **Where:** §2.1 table rows: one-tap record, History, passcode lock (blind pass)
- **This app does:** free: 3 a.m. grace, History, passcode lock
- **User reaction:** praise
- **Magnitude:** PR_GRACE 41; PR_FAST 7; PR_HISTORY 31; REQ_CALENDAR 9; REQ_HISTORY 7; REQ_MEMO 7; PR_PRIVACY 4
- **Direction for us:** build-free · **Report confidence:** meaningful / weak · **Generalisable:** generalisable
- **Review IDs:** `14505391902`, `8693987085`
- **Canonical:** C012 Week / month / year grid views; C017 Passcode lock; C170 Configurable day boundary and hemisphere seasons; C172 Per-day / per-habit notes and journal text

## Monetization

### R70-014 — Money comes from patronage: the JP listing says the app is completely free and in-app purchase is 'only for people who want to support' it; MON_PAID_EXPLICIT 54 (2.36%, mean 4.76) bought the add-on; MON_WILL_PAY 90 (3.93%, 4.89) intend to ('after 30 days', 'when I have money'); MON_SUPPORT_DEV 39 (1.70%) frame paying as supporting the developer, not unlocking a function — 「自分も男気をみせて課金したりました」; 'I felt guilty about using it for free'; purchase triggers within 54 buyers: support for the developer 14 (25.93%; with any developer-bond code 19, 35.19%), a completed milestone as reward 22 (40.74%: '30日続けることができたので無駄機能買いました'; 'I'll buy the useless feature if I last a month'), more or different encouragement 14 (the free lines repeat every 30-day cycle), paying as a commitment device (MON_PAY_COMMIT 3: 'paying creates more sense of obligation'); free / paid (verbatim): Capability or offer | Classification | Basis ; Core tracker: goal, reminders, recording, History, columns | Free, no ads | PR_FREE 149; listing (§2.2) ; Alternative message packs 「無駄機能」 (incl. 中二病 voice) | Paid add-on, optional | MON_PAID_EXPLICIT 54; e.g. "中二病コメントシステムを課金して買いました" *(I paid for the chūnibyō comment system)* (#858, 3667119040, jp, 4★) ; Add-on billing | One-off ¥960–980 (2017–2021), monthly from 2022 per reviewers | §9.G; MON_SUBSCRIPTION 7 ; Donation link | Unclear / intermittent | "寄付" named in 23 reviews; #1425 (2020) says donations were not being accepted at the time ; Trial | None described | no reviewer mentions a trial — no trial described; a donation link unclear / intermittent (named in 23 reviews; in 2020 donations were not being accepted)

- **Where:** §0.6; §2.3 table (verbatim); §5.1; §5.2
- **This app does:** free core; ¥960–980 message-pack add-on
- **User reaction:** purchase-driver
- **Magnitude:** PAID 54 (2.36%) 4.76; WILL_PAY 90 (3.93%); SUPPORT_DEV 39 (1.70%)
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `1834959691`, `8317723251`, `6581562527`, `5246053794`, `3598813740`, `3667119040`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C097 A tip / donate option; C137 Show the paywall at the moment of need, not on app open

### R70-016 — Price is the barrier to patronage: MON_PRICE_HIGH 20 (0.87%, mean 4.65) and MON_NO_PAY 17 (0.74%, 5.00 — students, minors, tight budgets: 'my family says no in-app purchases'); the add-on cost ¥960–980 as a one-off (2017–2021) and since May 2022 reviewers describe it as monthly (MON_SUBSCRIPTION 7, first 2022-05-15): '¥980 is far too much. I'd happily pay around ¥300'; 'It's ¥980 a month as of April 2023, which feels a bit expensive'; 'Please add a way to donate ¥100 at a time, as often as I like'; 'it seems it used to be a one-off purchase and has changed to monthly, which is a shame'; 'a one-time purchase option would be nice too'; named thresholds ¥100–300, ¥500, repeatable ¥100 donations; non-monetary support offered — 'how about adding a watch an ad button to the menu?' and two bought the developer's book as support; barriers (verbatim): Code | Meaning | n | % of 2,290 | Band | Mean ★ ; MON_PRICE_HIGH | IAP price too high | 20 | 0.87% | Emerging signal | 4.65 ; MON_NO_PAY | Cannot or will not pay | 17 | 0.74% | Emerging signal | 5.00 ; MON_SUBSCRIPTION | Add-on is (now) a monthly subscription / wants annual plan | 7 | 0.31% | Weak signal | 4.71 ; NEG_UPSELL_NAG | Repeated purchase prompts | 5 | 0.22% | Weak signal | 1.40 ; MON_ACCIDENTAL | Accidental / unwanted purchase | 2 | 0.09% | Ignore by default | 1.00 — §8.7: a small repeatable tip (¥100–300) or a one-time pack alongside the monthly plan, offered at the moment reviewers already choose to pay — completing a 30-day cycle; refresh the free message set between cycles or say plainly that a second cycle repeats it

- **Where:** §0.6 price; §5.5 table (verbatim); §8.7
- **This app does:** ¥980 one-off → monthly
- **User reaction:** blocked-conversion
- **Magnitude:** PRICE_HIGH 20 (0.87%); NO_PAY 17; SUBSCRIPTION 7
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `5601520030`, `9872904162`, `13157065902`, `10068902732`, `8886936066`, `5441799315`, `12677032119`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'; C097 A tip / donate option

## Tactics the app used

### R70-018 — The developer's voice is a differentiator that is fading from the reviews: U_DEV_BOND 364 (15.90%, high-priority, mean 4.92) — praise for the developer's attitude, essays and release notes (PR_DEV 311, 13.58%; PR_RELNOTES 28, 1.22% — release notes read as content) and installs of the developer's other apps (XSELL_OTHER_APP 78, 3.41%; from 2018-06 the sister app 「集中」 'Focus'); 'It's also the first app I've seen that replies to every review one by one'; outcome: this goodwill is what the purchase model runs on (developer-bond among 35.19% of purchasers); PR_DEV falls 18.5% of E2 → 5.2% of E5 (sensitivity: dev bond 15.9% all vs 8.9% in E4 + E5); unanswered support mail SUP_NONE 5 (0.22%) about purchases, a notification defect or a feature request ('I sent an email. But there was no reply'); §8.9 keep the developer's voice — 'It is what purchasers say they are paying for'

- **Where:** §0.7; §3.1 U_DEV_BOND
- **This app does:** replies to every review; essay release notes
- **User reaction:** praise
- **Magnitude:** U_DEV_BOND 364 (15.90%) 4.92; PR_DEV 18.5% → 5.2%; XSELL 78
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `1767172314`, `6986884299`, `1544232487`, `2246132063`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back; C060 Cross-sell an app family on brand trust

### R70-035 — Naming the paid add-on 「無駄機能」 ('useless feature') and the listing line 'In-app purchase is only for people who want to support us; you lose nothing without it' — a self-deprecating, no-pressure framing of the only paid item; outcome: 44 reviews name the 無駄機能 (MON_MUDA_AWARE), purchasers treat buying it as a reward and a thank-you ('I kept it up for 30 days, so I bought the useless feature'), purchaser mean 4.76, and support-the-developer is the top purchase driver (lift 15.22×) — while those who dislike the model's later monthly billing still frame their objection as wanting to support once

- **Where:** §2.1; §2.3; §5.2 (blind pass)
- **This app does:** paid pack named 'useless feature'
- **User reaction:** purchase-driver
- **Magnitude:** MON_MUDA_AWARE 44; purchasers 54 @ 4.76
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `6581562527`, `3667119040`, `13983476429`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C097 A tip / donate option

## Insights (the why)

### R70-005 — The outcome evidence is broad: U_OUTCOME 992 (43.32%, high-priority, mean 4.92) — streaks OUT_STREAK 617 (26.94%), chronic quitters who finally continued OUT_QUITTER 299 (13.06%; the 三日坊主 'three-day monk' identity appears in 343 reviews), behaviour that became automatic OUT_HABIT 194 (8.47%), concrete life results OUT_RESULT 157 (6.86%) (verbatim): Code | Meaning | n | % of 2,290 | Band | Mean ★ ; OUT_STREAK | Reports a streak / period completed | 617 | 26.94% | High-priority signal | 4.92 ; OUT_QUITTER | Chronic quitter now continues ('三日坊主' overcome) | 299 | 13.06% | High-priority signal | 4.95 ; OUT_HABIT | Behaviour became a habit | 194 | 8.47% | High-priority signal | 4.93 ; OUT_RESULT | Concrete life result | 157 | 6.86% | High-priority signal | 4.96 ; USE_FITNESS | Exercise / strength training / stretching | 192 | 8.38% | High-priority signal | 4.92 ; USE_STUDY | Study / exams / language learning | 89 | 3.89% | Very strong signal | 4.93 ; USE_DIET | Diet / weight | 52 | 2.27% | Meaningful signal | 4.94 ; USE_HOUSEHOLD | Cleaning / tidying / chores | 37 | 1.62% | Meaningful signal | 4.86 ; USE_DIARY | Diary / journaling / reading | 27 | 1.18% | Meaningful signal | 5.00 ; USE_WELLBEING | Mental health / ADHD / illness / caregiving context | 25 | 1.09% | Meaningful signal | 4.92 ; USE_HOBBY | Hobby / art / music / writing | 16 | 0.70% | Emerging signal | 4.94 ; USE_QUIT | Quitting something | 12 | 0.52% | Emerging signal | 4.58 — streaks of 500 days, 1,000 days, a year or more; ordinary goals (sit-ups, one page, one minute of tidying, brushing teeth) with real change: 「無事に合格しました。」 ('I passed'); 'I'm a 54-year-old man, and I kept up 20 push-ups a day for a month'

- **Where:** §0.1 outcomes; §3.2 outcomes table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** U_OUTCOME 992 (43.32%) 4.92
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `12259513979`, `8674571685`, `9679972581`, `1783528882`
- **Canonical:** C101 Milestones, achievements, celebration; C290 Guide every new goal down to something doable on a bad day — a setup that asks 'can you really do that in 5 minutes?' is a feature users thank

### R70-015 — Segment rates among 54 purchasers (verbatim): Theme | n in segment | % of segment | % of all 2,290 | Lift ; MON_SUPPORT_DEV | 14 | 25.9% | 1.7% | 15.22× ; U_DEV_BOND | 19 | 35.2% | 15.9% | 2.21× ; OUT_STREAK | 22 | 40.7% | 26.9% | 1.51× ; PR_COMMENTS | 14 | 25.9% | 18.7% | 1.39× ; PR_TIPS | 7 | 13.0% | 4.5% | 2.91× ; PR_FREE | 7 | 13.0% | 6.5% | 1.99× ; OUT_RESULT | 7 | 13.0% | 6.9% | 1.89× ; USE_FITNESS | 7 | 13.0% | 8.4% | 1.55× ; REV_MILESTONE | 3 | 5.6% | 0.5% | 10.60× ; CHURN_RETURN | 3 | 5.6% | 0.9% | 6.06× ; U_BUG_ANY | 3 | 5.6% | 4.5% | 1.22× ; MON_PAID_DISAPPOINT | 2 | 3.7% | 0.1% | 42.41× ; SUP_NONE | 2 | 3.7% | 0.2% | 16.96× — support-for-developer lift 15.22×; most purchasers satisfied (mean 4.76) and value variety and fun, especially the 中二病 voice ('I love that paying upgrades the comments a little. Paying was the right call!'); 4 of 54 unhappy name specific failures — content that felt no different before and after paying, quotations taken from famous people rather than original lines, the purchase still advertised after buying, and recording that broke after buying with no reply from support

- **Where:** §5.3 table (verbatim); §5.4
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 54 purchasers @ 4.76; SUPPORT_DEV lift 15.22×
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** generalisable
- **Review IDs:** `5906598071`, `7262494547`, `6173882157`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps

### R70-021 — Recording is itself a habit the app asks for, and for some users it is the one that fails: U_CHURN 20 (0.87%, emerging, mean 1.90); NEG_NOT_FOR_ME 9; 「わたしは「このアプリを毎日継続して開くこと」すらできませんでした。」 ('I couldn't even keep up opening this app every day', 12 votes); 'I stopped keeping up with opening the app to record' (a 5★ titled 'reading now sticks, but…' — the habit survived and the app did not); 'This is no different from a game's daily login bonus'; widget requesters (REQ_WIDGET 17, 0.74%, mean 4.76, 0.3% of E1 → 2.4% of E5) ask for the same thing — a way to keep the goal visible without opening the app, one citing another app's widget doing exactly that; §8.8: home- and lock-screen widgets showing today's status and recording from the notification (REQ_NOTIF_ACTION 1) — hypothesis: users are lost at the 'open app' step

- **Where:** §3.7; §8.8
- **This app does:** app must be opened to record
- **User reaction:** churn
- **Magnitude:** U_CHURN 20 (0.87%) 1.90; REQ_WIDGET 17 (0.74%) 4.76
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `7788169534`, `13609275319`, `12319745941`, `11071967308`
- **Canonical:** C023 Interactive widget check-off; C252 Complete a habit from the notification — an actionable reminder is part of the one-tap loop

## Audiences

### R70-020 — Mental health and self-care context: USE_WELLBEING 25 (1.09%, meaningful, mean 4.92) — depression, ADHD, anxiety, autonomic disorders and binge eating named with recovery stories: 'My depression has eased and I've been able to return to work'; 'When I managed to brush my teeth every morning for 30 days, I felt a little closer to normal and was really happy'; 'It's day 15 since the stress-driven late-night binge eating I'd suffered for about eight years stopped' — 'This is a sensitive audience… a pushy tone that motivates one user can shame another'

- **Where:** §3.2 mental health; §3.6
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** USE_WELLBEING 25 (1.09%) 4.92
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8115938123`, `12055574930`, `14089761799`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

## Markets and languages

### R70-026 — Storefront table (verbatim): Storefront | Reviews | % of 2,290 | Mean ★ | Praise % | Outcome % | Defect % | Request % | Eligible ; jp | 2,259 | 98.65% | 4.73 | 75.4% | 43.6% | 4.5% | 9.1% | ✅ ; cn | 11 | 0.48% | 4.91 | 90.9% | 36.4% | 0.0% | 18.2% | ; tw | 7 | 0.31% | 5.00 | 100.0% | 0.0% | 0.0% | 28.6% | ; us | 6 | 0.26% | 4.33 | 100.0% | 16.7% | 33.3% | 16.7% | ; au | 1 | 0.04% | 5.00 | 100.0% | 100.0% | 0.0% | 100.0% | ; ch | 1 | 0.04% | 5.00 | 100.0% | 0.0% | 0.0% | 0.0% | ; my | 1 | 0.04% | 5.00 | 100.0% | 0.0% | 0.0% | 0.0% | ; ca | 1 | 0.04% | 4.00 | 100.0% | 0.0% | 0.0% | 100.0% | ; hk | 1 | 0.04% | 5.00 | 100.0% | 0.0% | 0.0% | 0.0% | ; be | 1 | 0.04% | 5.00 | 100.0% | 0.0% | 0.0% | 0.0% | ; de | 1 | 0.04% | 5.00 | 100.0% | 100.0% | 0.0% | 0.0% | — only jp clears 50 (2,259); JP (verbatim) Code | Meaning | n | % of 2,259 jp | Band | Mean ★ ; OUT_STREAK | Reports a streak / period completed | 613 | 27.14% | High-priority signal | 4.92 ; PR_SIMPLE | Simple / easy to use | 439 | 19.43% | High-priority signal | 4.90 ; PR_COMMENTS | Encouragement message after each tap | 426 | 18.86% | High-priority signal | 4.93 ; PR_DEV | Praises / thanks the developer | 308 | 13.63% | High-priority signal | 4.93 ; OUT_QUITTER | Chronic quitter now continues ('三日坊主' overcome) | 299 | 13.24% | High-priority signal | 4.95 ; PR_CONCEPT | Concept / philosophy (small, sustainable goals) | 262 | 11.60% | High-priority signal | 4.87 ; PR_NOTIF | Reminders / notifications help | 203 | 8.99% | High-priority signal | 4.84 ; USE_FITNESS | Exercise / strength training / stretching | 192 | 8.50% | High-priority signal | 4.92 ; OUT_HABIT | Behaviour became a habit | 191 | 8.46% | High-priority signal | 4.93 ; PR_GENERIC | Generic praise | 163 | 7.22% | High-priority signal | 4.87 ; PR_RECOMMEND | Recommends it to others | 160 | 7.08% | High-priority signal | 4.95 ; OUT_RESULT | Concrete life result | 156 | 6.91% | High-priority signal | 4.96 ; PR_ONE_GOAL | Praises the one-goal-at-a-time limit | 147 | 6.51% | High-priority signal | 4.87 ; PR_FREE | Free / no ads | 141 | 6.24% | High-priority signal | 4.86 — 'Japan is the corpus': the Japanese-specific vocabulary and voice (三日坊主 in 343 reviews; the 中二病 message pack is a local cultural joke purchasers cite); Japan-specific rule friction is the late-night day boundary for students and shift workers; JP public 4.78 on 53,106

- **Where:** §6.1 table (verbatim); §6.2; §6.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** jp 2,259 @ 4.73
- **Direction for us:** none · **Report confidence:** high (JP) · **Generalisable:** app-specific
- **Review IDs:** `1397468700`, `1978538181`, `3906218337`
- **Canonical:** C027 Localise early — it unlocks revenue; C062 Weight English-speaking rich markets; volume ≠ revenue

### R70-027 — High-spend proxy and high-volume groups (verbatim): Group | Reviews | Mean ★ | Praise % | Outcome % | Defect % | Request % | Paid signal % ; jp (both groups) | 2,259 | 4.73 | 75.4% | 43.6% | 4.5% | 9.1% | 6.8% ; cn + us + tw (proxy group, limited evidence) | 24 | 4.79 | 95.8% | 20.8% | 8.3% | 20.8% | 4.2% ; All non-jp storefronts | 31 | 4.81 | 96.8% | 22.6% | 6.5% | 22.6% | 3.2% ; Global | 2,290 | 4.73 | 75.7% | 43.3% | 4.5% | 9.3% | 6.7% — international listings are localised (Chinese and English titles; cn 4.88 on 99, us 4.92 on 60, tw 4.96 on 49) and rated as highly as Japan, but the base outside Japan is too small; storefront is not language (verbatim) Language | Storefronts (reviews) ; ja | jp (2,258), ch (1), us (1), cn (1), my (1), be (1), de (1) ; zh | cn (10), tw (7), hk (1) ; en | us (4), au (1), jp (1), ca (1) ; ru | us (1) — cn (11, 4.91), tw (7, 5.00), us (6, 4.33) and single-review storefronts are limited evidence; cn and tw reviews from 2024 repeat the Japanese praise (free, no ads, clean interface) and the same two requests — multiple habits and a widget; research #5: how cn and tw audiences retain compared with Japan

- **Where:** §6.4 table (verbatim); §6.5 table (verbatim); §6.6
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** non-jp 31 @ 4.81
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `1833817077`, `11193954393`, `1447646172`, `12157880557`, `14429804441`
- **Canonical:** C027 Localise early — it unlocks revenue; C062 Weight English-speaking rich markets; volume ≠ revenue

## Dated events and trends

### R70-010 — The reset has split users since 2018: a March 2018 update removed the automatic reset — PR_RESET_REMOVED 6 (0.26%) welcomed it ('I'm personally glad this update abolished the reset') and REQ_RESET_BACK 13 (0.57%, mean 4.08) asked for it back as late as 2024 ('For some people motivation drops sharply without the reset'); the same update removed a 90-day option (NEG_90_REMOVED 3); reviews from 2020 again describe a two-day reset prompt with a 'don't reset' choice — whether the removal was later reversed in full could not be established

- **Where:** §0.4 reset split; §7.1 E1 → E2
- **This app does:** reset removed Mar 2018
- **User reaction:** mixed
- **Magnitude:** PR_RESET_REMOVED 6; REQ_RESET_BACK 13 (0.57%) 4.08; NEG_90_REMOVED 3
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `2304355241`, `2306392656`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R70-028 — Eras cut where reviewers describe a product change — E1 → E2 at 2018-03-14 (reset removed, 90-day option lost), E2 → E3 a calendar cut at 2020, E3 → E4 at 2022-05-01 (first review describing the add-on as monthly), E4 → E5 a calendar cut at 2025 (verbatim): Era | Name | Dates | Reviews | Mean ★ | 1–2★ % | 5★ % ; E1 | Launch rules (reset + 90-day option) | 2016-06-20 → 2018-03-12 | 356 | 4.65 | 4.8% | 80.9% ; E2 | Reset removed, peak volume | 2018-03-14 → 2019-12-31 | 844 | 4.76 | 2.8% | 85.5% ; E3 | 2020 → spring 2022 | 2020-01-01 → 2022-04-29 | 563 | 4.77 | 3.0% | 87.2% ; E4 | Add-on billed monthly | 2022-05-01 → 2024-12-30 | 316 | 4.72 | 3.8% | 85.1% ; E5 | Recent | 2025-01-02 → 2026-09-06 | 211 | 4.71 | 2.8% | 84.4% — theme movement (verbatim): Theme | E1 | E2 | E3 | E4 | E5 ; U_PRAISE_ANY | 278 (78.1%) | 670 (79.4%) | 408 (72.5%) | 224 (70.9%) | 153 (72.5%) ; PR_SIMPLE | 91 (25.6%) | 184 (21.8%) | 91 (16.2%) | 44 (13.9%) | 38 (18.0%) ; PR_COMMENTS | 72 (20.2%) | 132 (15.6%) | 114 (20.2%) | 79 (25.0%) | 31 (14.7%) ; PR_NOTIF | 34 (9.6%) | 46 (5.5%) | 50 (8.9%) | 48 (15.2%) | 25 (11.8%) ; PR_DEV | 42 (11.8%) | 156 (18.5%) | 79 (14.0%) | 23 (7.3%) | 11 (5.2%) ; PR_FREE | 5 (1.4%) | 37 (4.4%) | 63 (11.2%) | 22 (7.0%) | 22 (10.4%) ; PR_TIPS | 9 (2.5%) | 27 (3.2%) | 28 (5.0%) | 22 (7.0%) | 16 (7.6%) ; OUT_STREAK | 115 (32.3%) | 210 (24.9%) | 156 (27.7%) | 90 (28.5%) | 46 (21.8%) ; OUT_RESULT | 8 (2.2%) | 44 (5.2%) | 46 (8.2%) | 38 (12.0%) | 21 (10.0%) ; USE_FITNESS | 8 (2.2%) | 51 (6.0%) | 64 (11.4%) | 45 (14.2%) | 24 (11.4%) ; USE_DIET | 1 (0.3%) | 12 (1.4%) | 15 (2.7%) | 14 (4.4%) | 10 (4.7%) ; XSELL_OTHER_APP | 0 (0.0%) | 25 (3.0%) | 38 (6.7%) | 10 (3.2%) | 5 (2.4%) ; U_PAID | 17 (4.8%) | 52 (6.2%) | 59 (10.5%) | 18 (5.7%) | 8 (3.8%) ; MON_PAID_EXPLICIT | 11 (3.1%) | 16 (1.9%) | 21 (3.7%) | 5 (1.6%) | 1 (0.5%) ; MON_WILL_PAY | 5 (1.4%) | 34 (4.0%) | 34 (6.0%) | 12 (3.8%) | 5 (2.4%) ; MON_PRICE_HIGH | 3 (0.8%) | 7 (0.8%) | 4 (0.7%) | 5 (1.6%) | 1 (0.5%) ; U_BUG_ANY | 27 (7.6%) | 30 (3.6%) | 33 (5.9%) | 10 (3.2%) | 4 (1.9%) ; BUG_NOTIF | 10 (2.8%) | 11 (1.3%) | 14 (2.5%) | 2 (0.6%) | 1 (0.5%) ; U_RULE_FRICTION | 23 (6.5%) | 34 (4.0%) | 23 (4.1%) | 18 (5.7%) | 16 (7.6%) ; U_REQ_ANY | 25 (7.0%) | 64 (7.6%) | 46 (8.2%) | 47 (14.9%) | 30 (14.2%) ; REQ_MULTI | 5 (1.4%) | 16 (1.9%) | 8 (1.4%) | 5 (1.6%) | 10 (4.7%) ; REQ_WIDGET | 1 (0.3%) | 1 (0.1%) | 3 (0.5%) | 7 (2.2%) | 5 (2.4%) ; REQ_PAUSE | 0 (0.0%) | 0 (0.0%) | 3 (0.5%) | 5 (1.6%) | 2 (0.9%) ; NEG_COMMENT_TONE | 1 (0.3%) | 0 (0.0%) | 0 (0.0%) | 5 (1.6%) | 1 (0.5%) ; NEG_NOTIF_ANNOY | 0 (0.0%) | 1 (0.1%) | 1 (0.2%) | 6 (1.9%) | 1 (0.5%) ; U_CHURN | 4 (1.1%) | 2 (0.2%) | 6 (1.1%) | 5 (1.6%) | 3 (1.4%) — E1: early setup crashes (all four 1★ crash reports 2017), awkward backfill, defects 7.6% (peak), simplicity praise at its peak 25.6%; E2: the reset split, volume peak 2018-05/06, developer relationship strongest (PR_DEV 18.5%), sister app 'Focus' installs; E3: pandemic-era reviews, free / ad-free praise peaks 11.2%, cross-use 6.7%, paid signal highest 10.5%; E4: monthly billing appears and explicit purchases fall 3.7% → 1.6% while intent stays (directional; causation not shown), tone and notification backlash concentrates (9 of 14), fitness 14.2% and concrete results 12.0%; E5: requests 14.2% led by multiple goals 4.7% and widget 2.4%, developer praise lowest 5.2%, the developer's book appears, and new acquisition routes — a YouTube appearance and an AI assistant's recommendation: 'I asked an AI to recommend apps like this and picked from those'

- **Where:** §7.1 table (verbatim); §7.2 table (verbatim); §7.4
- **This app does:** reset removal 2018; monthly add-on 2022
- **User reaction:** mixed
- **Magnitude:** era means 4.65/4.76/4.77/4.72/4.71; explicit purchases 3.7% → 1.6%
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `14219888171`, `2304355241`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C059 Be visibly responsive; fixes bring reviewers back; C104 Never ship a paywall or feature-removal change silently

### R70-029 — Yearly series (verbatim): Year | Reviews | Mean ★ | 1–2★ | Defect | Rule friction | Requests | Paid signal | Tone/notif. ; 2016 | 14 | 4.21 | 1 | 0 | 7 | 5 | 0 | 0 ; 2017 | 253 | 4.64 | 15 | 18 | 14 | 16 | 9 | 0 ; 2018 | 552 | 4.75 | 16 | 20 | 24 | 39 | 30 | 1 ; 2019 | 381 | 4.78 | 9 | 19 | 12 | 29 | 30 | 1 ; 2020 | 308 | 4.80 | 6 | 16 | 12 | 27 | 29 | 0 ; 2021 | 194 | 4.69 | 9 | 15 | 9 | 14 | 24 | 1 ; 2022 | 155 | 4.85 | 4 | 4 | 7 | 19 | 10 | 0 ; 2023 | 108 | 4.56 | 7 | 6 | 4 | 12 | 8 | 7 ; 2024 | 114 | 4.75 | 3 | 2 | 9 | 21 | 6 | 2 ; 2025 | 122 | 4.75 | 3 | 0 | 8 | 19 | 5 | 2 ; 2026 | 89 | 4.65 | 3 | 4 | 8 | 11 | 3 | 0 — persisted: core praise in 70.9–79.4% of every era, recording and notification defects 2017-12-15 → 2026-08-14, the reset argument 2016-10-18 → 2026-09-04, price sensitivity to the add-on in every era; sensitivity (verbatim) Headline share | All 2,290 | Excluding E2 | E4 + E5 only ; U_PRAISE_ANY | 75.7% | 73.5% | 71.5% ; U_OUTCOME | 43.3% | 45.4% | 48.4% ; PR_COMMENTS | 18.7% | 20.5% | 20.9% ; U_DEV_BOND | 15.9% | 13.3% | 8.9% ; U_BUG_ANY | 4.5% | 5.1% | 2.7% ; U_RULE_FRICTION | 5.0% | 5.5% | 6.5% ; U_REQ_ANY | 9.3% | 10.2% | 14.6% ; REQ_MULTI | 1.9% | 1.9% | 2.8% ; U_PAID | 6.7% | 7.1% | 4.9% — praise and outcomes stable under every cut; requests and the multiple-goal ask larger in the recent period, developer bond smaller; volume peaked 2018 (552) and fell to 89 in 2026 (8 months)

- **Where:** §7.3 table (verbatim); §7.5; §7.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** reviews/yr 552 (2018) → 89 (2026)
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `5953466116`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C071 Never ship and walk away

### R70-036 — 2023 is the low year of the decade: mean 4.56 (the lowest since 2016's 14 reviews) on 108 reviews, the same year tone / notification complaints reach 7 (of 14 in the whole corpus) and the year after the add-on is first described as monthly (2022-05); defects that year 6, paid signal 8; 2024 recovers to 4.75 with tone complaints 2 — the yearly means 4.21 (2016), 4.64, 4.75, 4.78, 4.80, 4.69, 4.85, 4.56, 4.75, 4.75, 4.65 (2026) show no other dip below 4.6 after launch

- **Where:** §7.3 yearly series (blind pass)
- **This app does:** monthly add-on 2022; tone backlash 2023
- **User reaction:** complaint
- **Magnitude:** 2023: 108 reviews @ 4.56; tone/notif 7
- **Direction for us:** research · **Report confidence:** directional · **Generalisable:** app-specific
- **Review IDs:** `10317633924`, `10527702382`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C071 Never ship and walk away; C289 An app with a personality voice needs one 'quiet mode' switch — encouragement lines, jokes and badges to plain neutral text — while the voice stays the default

## Positioning

### R70-001 — Habit: Daily routine tracker / 継続する技術 (App Store ID 1120239484; 'Goal planner & Streaks') by bondavi Inc. (info.todice.habit) — a single-habit tracker: one goal guided down to five minutes or less, days and a reminder time, one tap on a ring that fills over a 30-day cycle, a stick-figure character's encouragement line after each tap, a two-day-miss reset prompt, previous day recordable until 3 a.m., a History of cycles, columns and developer essays; an optional add-on 「無駄機能」 ('useless feature') unlocks alternative message packs including a 中二病 voice; 2,290 reviews (every one read and hand-coded), 11 storefronts, 4 languages (Japanese 2,264, Chinese 18, English 7, Russian 1), 2016-06-20 → 2026-09-06, mean 4.73; listing (lookup API 2026-09-14): Health & Fitness, 4+, released 2016-06-18, version 1.34.3 dated 2026-09-10, free, 33 declared language codes; JP: 「完全無料。（アプリ内課金は、応援したい人だけのものです。なくても全く困りません）」 and 「広告なし。（そのため、清々しいほど儲かりません）」 (no ads, 'that is why we make refreshingly little money'); claims 12,000 people a month complete 30 days and input takes 'three seconds a day'; US: 'the app only allows you to set one goal at a time'; the current JP release note is a serialised essay about writing a novel; capabilities (verbatim): Capability | Positive evidence | Friction evidence ; One goal at a time, guided small-goal setup | PR_ONE_GOAL 148, PR_CONCEPT 262, ONE_GOAL_CONVERT 28 | REQ_MULTI 44 ; 30-day cycle | OUT_STREAK 617 | NEG_PERIOD_FIXED 5, REQ_PERIOD 13, REQ_REPEAT_GOAL 4, NEG_90_REMOVED 3 ; One-tap record; previous day until 3 a.m. | PR_SIMPLE 448, PR_GRACE 41, PR_FAST 7 | NEG_DAYBOUNDARY 11, NEG_PREVDAY_FLOW 11, BUG_INPUT 20 ; Two-day reset prompt | PR_RESET_TENSION 40 | NEG_RESET_RULE 14, REQ_RESET_BACK 13, REQ_PAUSE 10 ; Encouragement line after each tap | PR_COMMENTS 428, PR_HUMOR 106 | REQ_MORE_COMMENTS 21, NEG_COMMENT_TONE 7 ; Reminder notifications | PR_NOTIF 203 | BUG_NOTIF 38, NEG_NOTIF_ANNOY 9, REQ_NOTIF_EDIT 10 ; History of cycles | PR_HISTORY 31 | REQ_CALENDAR 9, REQ_HISTORY 7, REQ_MEMO 7 ; Columns and developer essays | PR_TIPS 102, PR_RELNOTES 28 | NEG_RELNOTES_LONG 1 ; Passcode lock | PR_PRIVACY 4 | REQ_LOCK 2 ; Paid message packs (無駄機能) | MON_PAID_EXPLICIT 54, MON_MUDA_AWARE 44 | MON_PRICE_HIGH 20, MON_SUBSCRIPTION 7, BUG_IAP 4, MON_PAID_DISAPPOINT 2 ; Not present: widget, Apple Watch, iPad landscape, sync | — | REQ_WIDGET 17, REQ_WATCH 5, REQ_IPAD 13, REQ_SYNC 4 || listings (verbatim): Storefront | Listing title | Public mean ★ | Ratings ; jp | 継続する技術｜ダイエットも筋トレも記録・習慣化で目標達成 | 4.78 | 53,106 ; cn | 持续：习惯打卡与目标记录 | 4.88 | 99 ; us | Habit: Goal & Streak Tracker | 4.92 | 60 ; tw | 持續：習慣養成・生活習慣・目標管理 | 4.96 | 49

- **Where:** header lines 1-5; §2.1 table (verbatim); §2.2 table (verbatim)
- **This app does:** free, no ads; optional patronage add-on
- **User reaction:** praise
- **Magnitude:** 2,290 reviews; mean 4.73; JP public 4.78 on 53,106
- **Direction for us:** none · **Report confidence:** header · **Generalisable:** app-specific
- **Review IDs:** `5953466116`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C062 Weight English-speaking rich markets; volume ≠ revenue; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

## Anti-patterns

### R70-032 — Encouragement that ignores the user's settings: notifications that continue after being switched off, remain for deleted goals and duplicate on a new cycle, plus a badge that 'makes me feel blamed all day' — on an audience that includes depression, ADHD and binge-eating recovery — turned the app's most-praised mechanic into its harshest reviews ('This is no different from the yakuza', 18 votes); cost: tone / notification complaints concentrated 11 of 14 since 2023 at mean 2.50 and 7 of 50 1★

- **Where:** §8.1–§8.8; §8.9
- **This app does:** voice + notifications without an off switch
- **User reaction:** 1★-burst
- **Magnitude:** 14 @ 2.50; 7 of 50 1★
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `7553106036`, `10598709745`, `12796168055`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C123 Notifications are few and finely user-controllable — per-type settings, escalation opt-in, never spammy and never silently retuned; C289 An app with a personality voice needs one 'quiet mode' switch — encouragement lines, jokes and badges to plain neutral text — while the voice stays the default

## Things not to do

### R70-017 — No purchase screen that can be tapped by accident: only 2 ask for money back — 'I couldn't work out how to turn the useless feature off' (then charged ¥960) and a paid feature not delivered with no reply; unwanted purchase prompts produce the harshest words: 「しかも誤課金しやすい画面。970円も誤課金した。」 ('the screen makes mis-purchases easy. I mistakenly paid ¥970'); 「いきなりの金銭要求。」 ('a sudden demand for money'), calling the app 「詐欺に近い」 (close to fraud); MON_ACCIDENTAL 2, NEG_UPSELL_NAG 5 (mean 1.40), BUG_IAP 4 purchase stuck / not restored; post-purchase and purchase-prompt complaints 11 (mean 2.18); §8.4: require explicit confirmation on the add-on, stop showing it to people who already bought, add a clear way to turn a pack off

- **Where:** §5.6; §8.4
- **This app does:** easy mis-purchase; prompt after buying
- **User reaction:** 1★-burst
- **Magnitude:** ACCIDENTAL 2 @ 1.00; UPSELL_NAG 5 @ 1.40; BUG_IAP 4
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `3554026149`, `6572812402`, `3209298921`, `12643702172`, `7262494547`
- **Canonical:** C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request; C285 Never charge a one-off add-on on a single tap against the authorisation just given for a trial — the add-on shows its price on the button, asks its own confirmation, defaults to 'no thanks' and ignores repeat taps

## Things to do

### R70-033 — Immediate fixes and experiments, as things to do: never lose a recorded day and show the date on the ring (§8.1); notifications that obey off, deleted goals and new cycles, with weekday / weekend times (§8.2); a quiet mode switching the voice, jokes and badge to neutral text while keeping the voice as default (§8.3); no purchase screen that can be tapped by accident (§8.4); let a finished habit stay as a quiet streak beside one active goal (§8.5); an honest limited rest day plus an optional strict mode (§8.6); a repeatable ¥100–300 tip or one-time pack offered at a completed 30-day cycle, and a refreshed free message set between cycles (§8.7); widgets and record-from-notification so the goal is visible without opening the app (§8.8)

- **Where:** §8.1–§8.8 immediate fixes and experiments
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** BUG_INPUT 20; BUG_NOTIF 38; tone 14; REQ_MULTI 44; REQ_PAUSE 10; PRICE_HIGH 20; REQ_WIDGET 17
- **Direction for us:** do · **Report confidence:** mixed · **Generalisable:** generalisable
- **Review IDs:** `7136283910`, `10598709745`, `11568521715`, `12651030354`, `11522188751`, `13157065902`, `7788169534`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C023 Interactive widget check-off; C097 A tip / donate option; C123 Notifications are few and finely user-controllable — per-type settings, escalation opt-in, never spammy and never silently retuned; C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot; C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement; C285 Never charge a one-off add-on on a single tap against the authorisation just given for a trial — the add-on shows its price on the button, asks its own confirmation, defaults to 'no thanks' and ignores repeat taps; C289 An app with a personality voice needs one 'quiet mode' switch — encouragement lines, jokes and badges to plain neutral text — while the voice stays the default

## Contradictions

### R70-031 — A cap that users defend: in most habit apps a limit on the number of habits is the paywall and the top complaint; here the one-goal limit is free, deliberate, and praised by 148 (6.46%) — 28 say they resented it at first and came around — while REQ_MULTI (44) asks for more, and reviewers themselves propose the middle path (a second goal only after completing a 30-day cycle); the voice that 428 praise is what 14 find cringey or shaming — the same feature is both the strongest retention mechanic and the loudest 1★ trigger

- **Where:** §0.1; §0.3; §8.5
- **This app does:** one-goal limit free and by design
- **User reaction:** mixed
- **Magnitude:** PR_ONE_GOAL 148 vs REQ_MULTI 44; PR_COMMENTS 428 vs tone 14
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `1558166349`, `14519088452`, `7553106036`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes; C289 An app with a personality voice needs one 'quiet mode' switch — encouragement lines, jokes and badges to plain neutral text — while the voice stays the default

## Data caveats and method

### R70-002 — Method and limits: non-exclusive counts; IDs plus date-order index; read in 23 batches of up to 100 in original language; per-batch re-assertion of IDs and, from batch 10, of every quoted fragment — this caught drifted IDs in early batches; unknown codes rejected, 9 unions; build refuses non-verbatim quotations and asserts trend directions; files (verbatim) File | Role | Records ; App Store Reviews/70. Habit - Daily routine tracker - Goal planner & Streaks/reviews.jsonl | the corpus; every claim resolves here | 2,290 ; by_country/*.jsonl | 11 per-storefront files | 2,290 (union) ; manifest.json | extraction metadata, per-country counts, rating distribution | — ; _state.json | collection state per polled storefront | — ; Apple iTunes Lookup API (external, 2026-09-14) | public rating, listing text, version, languages | 4 storefronts; schema (verbatim) Field | Used for | Notes ; review_id | primary key | 2,290 distinct; zero duplicates ; country, country_name | §6 | 11 storefronts ; rating | §4 | integers 1–5 only ; title, body | read in full for every record | median body length 64 characters ; author | authenticity tests only (§9.H) | zero repeated names ; date | §7 | 2016-06-20 → 2026-09-06 ; vote_count, vote_sum | §9.H | 227 reviews have votes; max 354 ; is_edited | §9.H | 11 edited ; app_id, app_name | constant (1120239484, Habit: Daily routine tracker) |; reconciliation: 2,290 distinct IDs, no duplicates, 11 country files match, manifest {1: 50, 2: 26, 3: 64, 4: 202, 5: 1948}, mean 4.7345, 38 storefronts probed all complete, 11 edited, 227 with votes (max 354), 8 short generic bodies recur across authors years apart and are kept; bands (verbatim) Share of reviews | Label ; < 0.1% | Ignore by default ; 0.1% – < 0.5% | Weak signal ; 0.5% – < 1% | Emerging signal ; 1% – < 3% | Meaningful signal ; 3% – 5% | Very strong signal ; > 5% | High-priority signal; a Japanese corpus (jp 2,259 = 98.65%; no other storefront reaches 50); overwhelmingly positive (5★ 85.07%, 1–2★ 3.32%) so a 1% theme is ~23 reviews; the corpus agrees with the public rating (4.73 vs 4.78 on 53,106; written ≈ 4.3% of JP ratings); outcomes self-reported (one claims 10 kg in a week); codes hand judgement; limitations: selection toward people who succeeded, one market, no version data, prices from reviewers, thin late period (E5 211)

- **Where:** How to read this; Warnings 1, 2, 3, 5, 8; §1.1 table (verbatim); §1.2 table (verbatim); §1.3; §1.4; §1.5 table (verbatim); §1.6
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 2,290 read; 1 eligible storefront
- **Direction for us:** research · **Report confidence:** method · **Generalisable:** generalisable
- **Review IDs:** `5953466116`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R70-003 — Reviewers are mostly people for whom it worked: many reviews mark a milestone (REV_MILESTONE) and the app has an in-app 'rate this app' menu item; people who quietly gave up rarely return to write — the few who did are FAIL_ADMIT 37 (1.62%, mean 4.14), usually blaming themselves; the corpus 'measures what satisfied users value and what breaks for engaged users; it does not measure how many people quit silently'

- **Where:** Warning 4; §9.H in-app rate menu; §3.7
- **This app does:** rate-this-app menu item; milestone reviews
- **User reaction:** praise
- **Magnitude:** FAIL_ADMIT 37 (1.62%) 4.14
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `7788169534`, `13609275319`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R70-022 — The prioritised picture (verbatim): Rank | Theme | Dir | n | % of 2,290 | Band | Mean ★ | Dates ; 1 | U_PRAISE_ANY Any praise code | + | 1733 | 75.68% | High-priority signal | 4.88 | 2016-06-20 → 2026-09-06 ; 2 | U_OUTCOME Any reported outcome (streak, quitter, habit, result) | + | 992 | 43.32% | High-priority signal | 4.92 | 2016-07-17 → 2026-09-06 ; 3 | PR_SIMPLE Simple / easy to use | + | 448 | 19.56% | High-priority signal | 4.90 | 2016-06-20 → 2026-09-06 ; 4 | PR_COMMENTS Encouragement message after each tap | + | 428 | 18.69% | High-priority signal | 4.93 | 2017-02-21 → 2026-09-06 ; 5 | U_DEV_BOND Relationship with the developer (praise, replies, release notes) | + | 364 | 15.90% | High-priority signal | 4.92 | 2017-02-14 → 2026-09-04 ; 6 | PR_CONCEPT Concept / philosophy (small, sustainable goals) | + | 262 | 11.44% | High-priority signal | 4.87 | 2016-08-27 → 2026-07-23 ; 7 | U_REQ_ANY Any feature request | − | 212 | 9.26% | High-priority signal | 4.28 | 2016-06-24 → 2026-09-06 ; 8 | PR_NOTIF Reminders / notifications help | + | 203 | 8.86% | High-priority signal | 4.84 | 2016-06-20 → 2026-09-03 ; 9 | U_PAID Any purchase / willingness-to-pay signal | + | 154 | 6.72% | High-priority signal | 4.84 | 2017-03-18 → 2026-08-08 ; 10 | PR_FREE Free / no ads | + | 149 | 6.51% | High-priority signal | 4.87 | 2017-08-29 → 2026-08-10 ; 11 | PR_ONE_GOAL Praises the one-goal-at-a-time limit | + | 148 | 6.46% | High-priority signal | 4.87 | 2016-11-18 → 2026-05-30 ; 12 | U_RULE_FRICTION Friction with the app's rules (reset, day boundary, backfill, period, one goal) | − | 114 | 4.98% | Very strong signal | 4.06 | 2016-06-24 → 2026-09-06 ; 13 | U_BUG_ANY Any reliability defect | − | 104 | 4.54% | Very strong signal | 3.29 | 2017-02-27 → 2026-08-14 ; 14 | XSELL_OTHER_APP Uses / found the developer's other apps | + | 78 | 3.41% | Very strong signal | 4.90 | 2018-06-27 → 2026-04-02 ; 15 | REQ_MULTI Wants more than one habit | − | 44 | 1.92% | Meaningful signal | 4.39 | 2016-06-24 → 2026-09-06 ; 16 | BUG_NOTIF Wrong / unwanted / missing notifications | − | 38 | 1.66% | Meaningful signal | 3.42 | 2017-10-22 → 2026-08-14 ; 17 | FAIL_ADMIT Admits they did not keep it up | ~ | 37 | 1.62% | Meaningful signal | 4.14 | 2016-10-01 → 2026-09-04 ; 18 | U_CHURN Any churn signal | − | 20 | 0.87% | Emerging signal | 1.90 | 2017-06-30 → 2026-06-19 ; 19 | MON_PRICE_HIGH IAP price too high | − | 20 | 0.87% | Emerging signal | 4.65 | 2017-11-20 → 2025-09-19

- **Where:** §3.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** U_PRAISE_ANY 1,733 (75.68%) 4.88
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `5953466116`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R70-024 — Distribution (verbatim): ★ | Reviews | % of 2,290 | Mean length of body (chars) ; 5 | 1,948 | 85.07% | 90 ; 4 | 202 | 8.82% | 98 ; 3 | 64 | 2.79% | 97 ; 2 | 26 | 1.14% | 74 ; 1 | 50 | 2.18% | 83 ; mean | 4.73 |  | — 5★ (verbatim) Code | Meaning | n | % of 5★ reviews | Segment band ; OUT_STREAK | Reports a streak / period completed | 574 | 29.47% | High-priority signal ; PR_SIMPLE | Simple / easy to use | 410 | 21.05% | High-priority signal ; PR_COMMENTS | Encouragement message after each tap | 403 | 20.69% | High-priority signal ; PR_DEV | Praises / thanks the developer | 296 | 15.20% | High-priority signal ; OUT_QUITTER | Chronic quitter now continues ('三日坊主' overcome) | 284 | 14.58% | High-priority signal ; PR_CONCEPT | Concept / philosophy (small, sustainable goals) | 235 | 12.06% | High-priority signal ; OUT_HABIT | Behaviour became a habit | 183 | 9.39% | High-priority signal ; PR_NOTIF | Reminders / notifications help | 178 | 9.14% | High-priority signal ; USE_FITNESS | Exercise / strength training / stretching | 177 | 9.09% | High-priority signal ; PR_RECOMMEND | Recommends it to others | 156 | 8.01% | High-priority signal — simplicity, the daily encouragement line and the reviewer's own streak, often written on a milestone day; the developer's attitude and the absence of ads and forced payment next; 5★ also carry requests, 'so a request is not a complaint here'; 4★ (verbatim) Code | Meaning | n | % of 4★ reviews | Segment band ; OUT_STREAK | Reports a streak / period completed | 38 | 18.81% | High-priority signal ; PR_SIMPLE | Simple / easy to use | 31 | 15.35% | High-priority signal ; PR_CONCEPT | Concept / philosophy (small, sustainable goals) | 23 | 11.39% | High-priority signal ; PR_COMMENTS | Encouragement message after each tap | 22 | 10.89% | High-priority signal ; PR_NOTIF | Reminders / notifications help | 19 | 9.41% | High-priority signal ; OUT_QUITTER | Chronic quitter now continues ('三日坊主' overcome) | 15 | 7.43% | High-priority signal ; USE_FITNESS | Exercise / strength training / stretching | 14 | 6.93% | High-priority signal ; PR_ONE_GOAL | Praises the one-goal-at-a-time limit | 14 | 6.93% | High-priority signal ; PR_GENERIC | Generic praise | 13 | 6.44% | High-priority signal ; BUG_NOTIF | Wrong / unwanted / missing notifications | 11 | 5.45% | High-priority signal — the same praise plus one missing thing: multiple goals, notification reliability, iPad landscape, a pause

- **Where:** §4.1 table (verbatim); §4.2 5★ and 4★ tables (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 5★ 1,948 (85.07%); 4★ 202 (8.82%)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `1397468700`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R70-025 — 3★ (verbatim) Code | Meaning | n | % of 3★ reviews | Segment band ; CONTRA_RATING | Star rating contradicts text | 13 | 20.31% | High-priority signal ; BUG_NOTIF | Wrong / unwanted / missing notifications | 7 | 10.94% | High-priority signal ; NEG_RESET_RULE | Dislikes the 2-day reset | 6 | 9.38% | High-priority signal ; REQ_MULTI | Wants more than one habit | 6 | 9.38% | High-priority signal ; PR_SIMPLE | Simple / easy to use | 6 | 9.38% | High-priority signal ; PR_NOTIF | Reminders / notifications help | 5 | 7.81% | High-priority signal ; NEG_DAYBOUNDARY | Day rollover time is a problem | 4 | 6.25% | High-priority signal ; OUT_STREAK | Reports a streak / period completed | 4 | 6.25% | High-priority signal ; PR_FREE | Free / no ads | 4 | 6.25% | High-priority signal ; PR_DEV | Praises / thanks the developer | 4 | 6.25% | High-priority signal — a defect or rule friction held against a liked product, or positive text under a middling star; 2★ (verbatim) Code | Meaning | n | % of 2★ reviews | Segment band ; BUG_NOTIF | Wrong / unwanted / missing notifications | 5 | 19.23% | High-priority signal ; NEG_PREVDAY_FLOW | Previous-day entry / backfill is awkward | 4 | 15.38% | High-priority signal ; BUG_INPUT | Cannot record a day | 3 | 11.54% | High-priority signal ; NEG_HOWTO | Cannot work out how to use it | 3 | 11.54% | High-priority signal ; CONTRA_RATING | Star rating contradicts text | 3 | 11.54% | High-priority signal ; FAIL_ADMIT | Admits they did not keep it up | 3 | 11.54% | High-priority signal ; BUG_COUNT | Day count wrong | 2 | 7.69% | High-priority signal ; NEG_SHALLOW | Too basic to be worth it | 2 | 7.69% | High-priority signal ; REQ_RESET_BACK | Wants the automatic reset back (or optional) | 2 | 7.69% | High-priority signal ; JUST_STARTED | Reviews after only days of use | 1 | 3.85% | Very strong signal — early input / backfill problems, notification defects, reset or single goal unworkable; 1★ (verbatim) Code | Meaning | n | % of 1★ reviews | Segment band ; CHURN_DELETE | Deleted / stopped | 10 | 20.00% | High-priority signal ; BUG_INPUT | Cannot record a day | 7 | 14.00% | High-priority signal ; NEG_NOT_FOR_ME | Not for me / no appeal | 6 | 12.00% | High-priority signal ; BUG_NOTIF | Wrong / unwanted / missing notifications | 5 | 10.00% | High-priority signal ; NEG_UPSELL_NAG | Repeated purchase prompts | 4 | 8.00% | High-priority signal ; NEG_NOTIF_ANNOY | Notification sound / nagging annoying | 4 | 8.00% | High-priority signal ; BUG_CRASH | Crashes | 4 | 8.00% | High-priority signal ; BUG_COUNT | Day count wrong | 4 | 8.00% | High-priority signal ; NEG_COMMENT_TONE | Encouragement messages annoying | 4 | 8.00% | High-priority signal ; FAIL_ADMIT | Admits they did not keep it up | 4 | 8.00% | High-priority signal — defects 24 of 50 (48.00%), tone / notification 7 (14.00%), purchase or upsell 6 (12.00%), not for me or failure 8, left or deleted 12; contradictions CONTRA_RATING 17 (0.74%) — all 1–3★ with wholly positive text ('easy to use, easy to keep going 👍🏼' under 1★), CONTRA_TEXT 1

- **Where:** §4.2 3★, 2★, 1★ tables (verbatim); §4.3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 1★ 50: defect 48%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `2537509206`, `1800248685`, `14505391902`
- **Canonical:** C230 Sync merges an append-only, timestamped event log — never last-writer-wins state replacement; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R70-030 — Research questions the corpus cannot answer: (1) what share of new users complete a first 30-day cycle, and where the rest stop — setup, day 2–3 recording, or after the first reset; (2) how explicit purchases and cancellations changed when the add-on moved to monthly billing; (3) whether users who finish a cycle and set no new goal keep the habit; (4) how often the recording defect occurs per active user and on which OS versions and devices; (5) how cn and tw audiences retain vs Japan; also not establishable: the exact IAP list and current prices, when monthly billing started beyond the first review (2022-05), whether the 2018 reset removal was reversed; no conversion, retention or revenue figure derivable

- **Where:** §8.10 #1–#5; part 8 #1; part 8 #2; part 8 #3; part 8 #4; part 8 #5; §2.4; §5.7
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** research · **Generalisable:** generalisable
- **Review IDs:** `13935906932`
- **Canonical:** C003 Lead with a one-time lifetime purchase
