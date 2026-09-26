# Cards — report 57

Source: `App Store Reports/57. Habit Tracker - DayStamp - Daily Routine, Streak & Widget (REPORT).md`  
114 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 4
- [Must-haves](#must-haves) — 6
- [Must never break](#must-never-break) — 17
- [Features](#features) — 8
- [Monetization](#monetization) — 10
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 14
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 12
- [Dated events and trends](#dated-events-and-trends) — 16
- [Positioning](#positioning) — 4
- [Anti-patterns](#anti-patterns) — 6
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 8

## Product rules

### R57-014 — What people love is restraint, in the same words for seven years: UX praise 198 (25.42%, high-priority, mean 4.753) — simplicity/minimalism 95 (12.20%), ease of use 81 (10.40%), visual design 69 (8.86%), colour customisation 22 (2.82%); vocabulary unchanged 2019 → 2026 — 깔끔 (clean), 심플, 직관적 (intuitive), 군더더기 없는 (no fat); 'other apps have too many features… this one has exactly what I want. Please don't add complexity — keep this leanness' (KR, 5★); 'It's extremely simple to use and does exactly what I want. Other apps tried to do way too much' (US, 5★) — every feature request must be weighed against this; the most-praised property is the absence of features

- **Where:** Executive summary 7; §3.5.1
- **This app does:** minimal UX
- **User reaction:** praise
- **Magnitude:** 198 (25.42%, 4.753); simplicity 95; ease 81; design 69; colour 22
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `6416619753`, `8241797483`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R57-107 — Structural 9: decide what 'lifetime' meant and honour it — eight bought explicitly because it was one-time (four American), one wrote three sentences on why subscriptions felt abusive before buying; a lifetime buyer now asked to subscribe posted 'DO NOT BUY IT' — the migration needs an explicit, published grandfathering policy: 'One public DO NOT BUY IT on the storefront costs more than the subscription it was protesting'

- **Where:** §8.2 #9
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 8 lifetime buyers
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `6636232220`, `14352377997`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C186 Never revoke what earlier buyers paid for when the model changes

### R57-110 — Structural 12: treat backup as a safety feature, not a paid one — 12 data-loss reports (8 since 2024, 6 at 1★), and two users discovered only at the moment of loss that backup required payment; 'Gating recovery behind a purchase converts a bug into a grievance' — at minimum an automatic local export or a one-time free restore after a detected data loss

- **Where:** §8.2 #12
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 12 data loss
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `11222810326`, `11103760055`
- **Canonical:** C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R57-113 — What not to change: do not add features to the main surface (95 praise minimalism; 'other routine apps are way too complicated'; the 267 requests should be read as settings, not surface); do not remove the stamp metaphor or the check-in sound (19 + 5 name them); do not add streak punishment (three chose the app because it doesn't punish a missed day, and the most detailed proposal asks for a skipped / failed distinction to preserve that); do not remove the lifetime option without a grandfathering statement; do not re-tighten the free tier before fixing the immediate issues — the last three tightenings produced the lowest-mean theme and the 2★ bucket

- **Where:** §8.5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 95; 19 + 5; 3
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `6416619753`, `9198233301`, `8241797483`, `13574542005`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C069 Check-off sound and haptic; C186 Never revoke what earlier buyers paid for when the model changes; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

## Must-haves

### R57-044 — Usability and discoverability — 71 (9.11%) (verbatim): cant_find_delete_edit 27 (3.47%, 3.630; 23 KR, 3 CA, 1 US); onboarding_no_guidance 23 (2.95%, 4.348; 18 KR, 4 JP, 1 SA); past_date_checkin_difficulty 13 (1.67%, 4.000, concentrated 2019–20); checkin_friction 5; localization_gap 5 (3.200; JP 2, CN 1, ES 1, KR 1); usability_negative 5 (2.200); accessibility_concern 1 (dark mode behind a paywall vs photosensitivity)

- **Where:** §3.3.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 779 | Signal | Mean ★ | Note ; cant_find_delete_edit | 27 | 3.47% | very strong | 3.630 | 23 Korean, 3 Canadian, 1 US ; onboarding_no_guidance | 23 | 2.95% | meaningful | 4.348 | 18 KR, 4 JP, 1 SA ; past_date_checkin_difficulty | 13 | 1.67% | meaningful | 4.000 | Concentrated 2019–2020; later reviewers praise the same feature ; checkin_friction | 5 | 0.64% | emerging | 4.200 | ; localization_gap | 5 | 0.64% | emerging | 3.200 | JP 2, CN 1, ES 1, KR 1 ; usability_negative (generic "hard to use / bad UI") | 5 | 0.64% | emerging | 2.200 | ; accessibility_concern | 1 | 0.13% | weak | 4.000 | Dark mode behind a paywall vs photosensitivity
- **Direction for us:** must-have · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free; C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R57-045 — cant_find_delete_edit is the cheapest fix in the report: 27 could not work out how to remove a habit — 'How on earth can you make a habit app and not be able to delete the habits after entering them? I've tried pressing every menu and holding down on the habits… It's like basic 101 of list apps' (US, 1★); 'how on earth do you delete a habit? It's not in settings. I got angry and deleted the app' (KR, 1★); 'there's no simple way to delete items and it makes me angry. I almost threw my phone' (KR, 2★) — the function exists (a 5★ reviewer documented it publicly), so purely a discoverability defect; 19 of 27 at 3★ or better — most stayed

- **Where:** §3.3.5 delete/edit
- **This app does:** delete exists but hidden
- **User reaction:** complaint
- **Magnitude:** 27 (3.47%, 3.630)
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `8773928024`, `7514522692`, `12665002271`, `7781598096`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free; C142 Surface existing features where users look

### R57-047 — Dark mode behind a paywall against a user's photosensitivity (accessibility_concern 1)

- **Where:** §3.3.5 accessibility
- **This app does:** paid: dark mode
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** generalisable
- **Canonical:** C080 Colour themes / dark mode; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R57-048 — Support and the developer relationship — 15 (1.93%, 2.333) (verbatim): support_unresponsive 8 (1.03%, 2.000); support_channel_unclear 6 (0.77%, 2.833); support_dismissive 1 — a reply that denied the user's experience; roadmap_promise_unmet 6 (0.77%, 4.000) — told 'planned', never shipped; support_responsive_praise 5 (0.64%, 5.000) — the counter-evidence; separated in time: praise 2019–2024 describes fast personal replies twice by KakaoTalk ('thank you for the kind guidance on my KakaoTalk enquiry'; 'got a reply the moment 9am hit'); unresponsive cluster later, half since 2024 — 'they told me to wait, but the issue was never fixed. They also ignored my follow-up email' (CA, 1★, 2026); 'I asked on KakaoTalk, they just read it and never replied. What a waste of money'; 'the support link goes to some Asian industrial company' (US, 2★) — support capacity did not scale, and payers notice hardest

- **Where:** §3.3.6 table (verbatim) and reading
- **This app does:** KakaoTalk support; broken support link
- **User reaction:** churn
- **Magnitude:** Theme | n | % | Mean ★ | IDs ; support_unresponsive — wrote in, got nothing | 8 | 1.03% | 2.000 | 6173955532, 6475747339, 8287496836, 10513784132, 11222810326, 12128022974, 13840622066, 14185972618 ; support_channel_unclear — could not find how to reach anyone | 6 | 0.77% | 2.833 | 6438394097, 7480839830, 9955688255, 11814795489, 12805909201, 13014831178 ; support_dismissive — got a reply that denied their experience | 1 | 0.13% | 2.000 | 12570234049 ; roadmap_promise_unmet — told "planned", never shipped | 6 | 0.77% | 4.000 | 11361971544, 11505457261, 11832774003, 12389229520, 13540816428, 13840622066 ; support_responsive_praise — the counter-evidence | 5 | 0.64% | 5.000 | 3971282028, 5621508960, 9511684630, 10644515708, 11603064365
- **Direction for us:** must-have · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `6173955532`, `6475747339`, `8287496836`, `10513784132`, `12128022974`, `13840622066`, `14185972618`, `6438394097`, `12805909201`, `12570234049`, `11361971544`, `11832774003`, `3971282028`, `10644515708`, `11603064365`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R57-104 — Fixes 5–6: make delete and edit discoverable — 27 could not find it, a user documented it publicly; 'deleting a habit is almost hidden — it should be a clear option when viewing the habit detailed view' (CA); a swipe action or visible button removes a theme with 5 one-stars and 10 four-stars; put a support link and an FAQ where Korean users are already asking — 49 questions in reviews, 6 couldn't find contact, 8 got no reply, 65 Korean reviewers (10.74%) asking for help, mostly 5★ about existing features

- **Where:** §8.1 #5, #6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 27; 49 / 6 / 8; 65 (10.74%)
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `9562235582`, `7781598096`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C073 Manual reordering, renaming and editing of habits/tasks — free; C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R57-108 — Structural 10: resolve cross-device — ship it or say clearly it will not ship; 72–84 reviewers across seven years, flat demand, one accusing the team of repeatedly saying 'planned'; if iCloud is Premium-gated and undiscoverable say so in the paywall copy, if partial the roadmap statement is overdue; an iPad build is a separate, cheaper ask (21, 18 Korean)

- **Where:** §8.2 #10
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 72–84; iPad 21
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C141 Native iPad layout

## Must never break

### R57-009 — The ad gate is unreliable, turning an annoyance into a dead end: 8 (1.03%, meaningful) report the required ad fails to appear or dismiss, leaving them unable to create a habit — 7 of 8 from 2024 on (a live defect): 'Can't add a task - no ads to show' (GB, 1★); 'I try to watch the ad to add one, but the ad doesn't load so I can't add anything at all' (KR, 3★, 24 Aug 2026); 'seven ads to add three goals… is this deliberate? I got angry trying to build good habits and deleted it' (KR); 'because of some lack of ads I cannot [add a habit]' (PL) — 'a monetization mechanic that can hard-block the product's core action is a reliability bug, not a pricing decision'

- **Where:** Executive summary 2
- **This app does:** ad gate blocks habit creation when no ad loads
- **User reaction:** churn
- **Magnitude:** 8 (1.03%); 7 from 2024
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `12589912745`, `14465530297`, `12548739794`, `10862244835`
- **Canonical:** C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

### R57-010 — The widget is simultaneously the most-loved feature and the largest defect surface: 129 (16.56%, high-priority) raise a widget problem — 90 (11.55%) a defect, 39 a design limit — against 30 (3.85%) praising it outright, several naming it why they installed; defects: 50 (6.42%) widget won't appear or goes blank, 25 (3.21%) doesn't reflect check-ins, 9 (1.16%) reports a live group as 'deleted', 6 (0.77%) clips items — 'so many widget errors, please stabilise it, I've used this for years' (KR, 1★); 'I absolutely love this app and I want to give it 5 stars, but the weekly widgets NEVER work' (US, 2★); 'every single update breaks the widget and reinstalling doesn't even fix it the first time' (KR, 1★); 23 of 99 payers (23.2%) report a widget problem — 'widget reliability is the product's load-bearing wall'

- **Where:** Executive summary 3; §3.3.2
- **This app does:** widgets praised and broken
- **User reaction:** 1★-burst
- **Magnitude:** 129 (16.56%); defects 90 (11.55%); not showing 50; payers 23 of 99
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `12572214309`, `13299429338`, `11223902869`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R57-011 — Paying does not stop the pain: 99 (12.71%) confirm they bought Premium and 31 (31.31% of payers) report a purchase-side failure — 22 post-purchase failure, 8 failed restore, 3 Premium not applying, 2 billing discrepancy, 1 claim not matching the listing; the share rose from 4 of 31 payers (2019–21) to 21 of 46 (2024–26, 45.7%) — 'I bought Premium and I still only get five habits. Why?!' (KR, 1★); 'This app advertised a weekly visual habit widget as part of the lifetime premium purchase, but the feature does not work. I contacted the developer… they told me to wait… They also ignored my follow-up email' (CA, 1★); 'I bought this app because in the premium option they said that it was compatible to share with family and now that I have paid it is not compatible' (MX, 1★); refunds are rare (8, 1.03%) because unhappy payers write a 1★ and stay broken

- **Where:** Executive summary 4; §5.4
- **This app does:** Premium failures
- **User reaction:** 1★-burst
- **Magnitude:** 31 of 99 payers (31.31%); 4/31 → 21/46 (45.7%); refunds 8
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `12020319439`, `14185972618`, `10724795076`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C037 Family plan; C065 Paying customers are the highest 1★ risk — every paid feature must work; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R57-022 — The in-app suggestion / bug-report form crashes on Submit (JP, 2026)

- **Where:** §2.1 bug-report form row
- **This app does:** feedback form crashes
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `13962223534`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R57-023 — Archiving a finished habit loses its record, per reviewers

- **Where:** §2.1 archive row
- **This app does:** archive loses history
- **User reaction:** complaint
- **Magnitude:** report gives none
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `8332637759`, `13064021764`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R57-024 — Apple Watch app praised by 8 but 26 report it hanging on 'Loading…'

- **Where:** §2.1 Watch row
- **This app does:** Watch app hangs
- **User reaction:** complaint
- **Magnitude:** 8 praise vs 26 hang
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `5621508960`, `6359087808`, `9537581546`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R57-032 — Listed ₩29,000 but the card was charged ₩44,000 (KR, Feb 2024); ₩3,994 charged after a redeem code (2019)

- **Where:** §2.2 billing discrepancy
- **This app does:** billing discrepancy
- **User reaction:** 1★-burst
- **Magnitude:** n=2
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `10959845967`, `4640684119`
- **Canonical:** C029 Billing must be exactly right

### R57-039 — Widget defects (verbatim): not_showing 50 (6.42%, 3.440, Apr 2020 → Jul 2026) — absent from the gallery, blank or black; not_updating 25 (3.21%, 4.080) — new habits never appear, check-ins never reflect; group_deleted 9 (1.16%, 3.556, Apr 2024 → Dec 2025) — a live group renders as 'deleted' in widget config (3 of 9 Premium, one reproduction described); layout 6 (0.77%) — items clipped; union 90 (11.55%) with 58 of 90 at 4–5★ — loyal users reporting a fault, invisible in the star average; chronic not episodic — not_showing 3.89% of E1 → 6.67% E2 → 10.80% E3, the only large defect that steadily worsens: 'every update breaks something that worked. Please just leave it alone'; 'only three months in and the widget bricks so often — I have to reinstall five or six times a month'; 'I paid for Premium but can't select a group in the widget — only all activities shows' (JP, 2★)

- **Where:** §3.3.2 table (verbatim) and chronic
- **This app does:** widget blank, stale, phantom-deleted group
- **User reaction:** complaint
- **Magnitude:** Defect | n | % of 779 | Signal | Mean ★ | Window | Character ; bug_widget_not_showing | 50 | 6.42% | high-priority | 3.440 | 2020-04-12 → 2026-07-26 | Widget absent from the gallery, blank, or black ; bug_widget_not_updating | 25 | 3.21% | very strong | 4.080 | 2019-10-14 → 2026-08-27 | New habits never appear; check-ins never reflect ; bug_widget_group_deleted | 9 | 1.16% | meaningful | 3.556 | 2024-04-29 → 2025-12-29 | A live group renders as "deleted" in widget config ; bug_widget_layout | 6 | 0.77% | emerging | 4.333 | 2019-08-28 → 2021-05-27 | Items clipped below the widget frame ; Union | 90 | 11.55% | high-priority | 3.689 | 2019-08-28 → 2026-08-27 | 1★ 11 · 2★ 6 · 3★ 15 · 4★ 26 · 5★ 32
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `11234179720`, `11241868525`, `11243086221`, `13567154644`, `12069773156`, `11214649198`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R57-041 — App and platform defects — 229 reviewers hit at least one (verbatim): update_regression 59 (7.57%, 3.729, every year, 53 Korean); bug_watch_loading 26 (3.34%, 3.577) — Watch stuck on 'Loading…', 19 of 26 in 2020–21; bug_keyboard_memo 22 (2.82%) — 21 of 22 in three days, a single release; bug_app_crash 18 (2.31%, 2.889) — Jun 2020 (8), Mar–Jun 2024 (5); bug_data_loss 12 (1.54%, 2.250) — 8 of 12 since 2024; bug_add_habit_fails 9 (1.16%, 2.778) — often entangled with the ad gate; bug_display_on_weekday 8 (1.03%) — 'Display on' ignores chosen weekdays, five-year-old fault; bug_ui_unresponsive 6; bug_reminder_time 4 (single iOS 14 cluster); bug_notifications 4; weak — stats report, badge count, colour picker, text contrast, battery drain, storage usage ('this app uses over 10GB of my storage', JP), backup restore, report crash

- **Where:** §3.3.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Defect | n | % of 779 | Signal | Mean ★ | Window | Note ; update_regression — "the update broke it" | 59 | 7.57% | high-priority | 3.729 | 2019-07-28 → 2026-05-04 | Present in every year; 53/59 Korean ; bug_watch_loading — Apple Watch stuck on "Loading…" / black | 26 | 3.34% | very strong | 3.577 | 2020-04-21 → 2026-04-03 | 19 of 26 in 2020–2021; tails off after 2023 ; bug_keyboard_memo — note keyboard will not appear | 22 | 2.82% | meaningful | 4.091 | 2020-09-17 → 2020-09-27 | 21 of 22 in three days. A single release ; bug_app_crash — app will not launch / crashes on save | 18 | 2.31% | meaningful | 2.889 | 2019-12-11 → 2024-06-04 | Two clusters: Jun 2020 (8), Mar–Jun 2024 (5) ; bug_data_loss — records disappeared | 12 | 1.54% | meaningful | 2.250 | 2019-05-21 → 2026-04-14 | 8 of 12 since 2024. See below ; bug_add_habit_fails — the add button errors out | 9 | 1.16% | meaningful | 2.778 | 2020-09-17 → 2026-08-24 | Often entangled with the ad gate ; bug_display_on_weekday — "Display on" ignores the chosen weekdays | 8 | 1.03% | meaningful | 4.375 | 2020-09-11 → 2025-06-23 | All 8 Korean; five-year-old fault ; bug_ui_unresponsive | 6 | 0.77% | emerging | 3.667 | 2020-07-20 → 2023-08-03 | ; bug_reminder_time | 4 | 0.51% | emerging | 3.500 | 2020-09-20 → 2020-09-23 | Single iOS 14 cluster ; bug_notifications | 4 | 0.51% | emerging | 3.750 | 2019-10-09 → 2024-10-09 | ; bug_stats_report, bug_badge_count, bug_color_picker, bug_text_contrast | 3, 2, 2, 2 | ≤0.39% | weak | — | — | ; bug_battery_drain, bug_storage_usage, bug_backup_restore, bug_report_crash, bug_misc | 1,1,1,1,5 | ≤0.64% | weak/emerging | — | — | 11805553961 (JP): *"this app uses over 10GB of my storage"*
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `11805553961`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C175 Updates must not break function or wipe progress

### R57-042 — bug_data_loss promoted above its 1.54% share under the severe-harm exception: 12 reviewers lost tracked history, 8 of 12 from 2024 onward, 6 at 1★ — 'The app is amazing but all of my data got erased!' (MX); 'today's update wiped all my previous data. If recovery is impossible, shouldn't you warn people before the update?' (KR, 1★); 'I adjusted the count on one habit, saved, and every other habit's check-ins collapsed to one' (KR, 1★, Apr 2026); compounded because backup is Premium-gated — the free users most likely to lose data are least able to recover it: 'in the end I learned for the first time that without paid Premium, backup and recovery are impossible'

- **Where:** §3.3.4 data loss
- **This app does:** update wipes data; backup paywalled
- **User reaction:** 1★-burst
- **Magnitude:** 12 (1.54%, 2.250); 8 since 2024
- **Direction for us:** must-never-break · **Report confidence:** meaningful (severe-harm exception) · **Generalisable:** generalisable
- **Review IDs:** `4184572783`, `6086077854`, `7437783396`, `10740823617`, `11074355880`, `11222810326`, `11343272903`, `12431372182`, `12513675383`, `12570234049`, `12676089427`, `13958683782`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R57-043 — 'Display on' per-weekday filter silently fails — 'no matter how many times I edit and recreate it, Display on doesn't work — I set Tue/Thu/Sat and it shows every day' (KR, 3★); 'even with Display on set it shows every day. It didn't used to' (KR, 4★); 16 requests + 8 defect reports = 24 reviewers — 'a shipped feature that silently fails is worse than a missing one: the request keeps arriving and the fix never lands'

- **Where:** §3.3.4 Display on
- **This app does:** Display on ignores weekdays
- **User reaction:** complaint
- **Magnitude:** 8 defects + 16 requests
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `11318555804`, `9672617646`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C142 Surface existing features where users look

### R57-051 — Accidental purchases: 6 reviewers (0.77%) paid by mistake and wanted out — excluded from the payer segment by design

- **Where:** §3.3.7 accidental purchase
- **This app does:** purchase too easy to trigger
- **User reaction:** 1★-burst
- **Magnitude:** 6 (0.77%)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** generalisable
- **Canonical:** C274 A close or dismiss control must never start a purchase — no fake X, no dismissal that lands on the payment sheet

### R57-075 — Post-purchase failure — the most important monetisation finding (verbatim): post_purchase_failure 22 (2.82%, 2.136); restore_purchase_failure 8 (1.03%, 3.125; 7 payers); premium_not_applied 3; purchase_failure 3; billing_error 2; misleading_premium_claims 1 (1.000); union 36 (4.62%, 2.528), 31 of 99 payers (31.31%); accelerating — 4 of 31 in E1 (12.9%) → 6 of 22 in E2 (27.3%) → 21 of 46 in E3 (45.7%); concrete failures: entitlement not applied ('the payment went through but it isn't applied'; 'nothing differs from before — I can't use the features shown in the screenshots'); restore fails on a new device or reinstall ('I changed phones and my Premium purchase is gone'; 'after reinstalling I get ads again'); a Premium feature fails ('the Premium-only widget doesn't update… Premium isn't cheap'); the promise did not match (Family Sharing advertised, didn't work — 'I do not think it is right that they lie', MX)

- **Where:** §5.4 table (verbatim) and failures
- **This app does:** Premium entitlement and restore broken
- **User reaction:** 1★-burst
- **Magnitude:** Failure mode | n (global) | % of 779 | Mean ★ | n among payers ; post_purchase_failure — paid, and a paid feature does not work | 22 | 2.82% | 2.136 | 22 ; restore_purchase_failure — purchase lost on reinstall / device change | 8 | 1.03% | 3.125 | 7 ; premium_not_applied — payment went through, entitlement did not | 3 | 0.39% | 2.667 | 3 ; purchase_failure — could not complete the purchase at all | 3 | 0.39% | 2.667 | 1 ; billing_error — charged an amount they did not expect | 2 | 0.26% | 3.500 | 2 ; misleading_premium_claims — the listing promised something Premium did not deliver | 1 | 0.13% | 1.000 | 1 ; Union | 36 | 4.62% | 2.528 | 31 (31.31% of payers)
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `5370880957`, `6887164010`, `8402874369`, `11753525633`, `11551843035`, `11814795489`, `12020319439`, `10747044142`, `13567154644`, `10724795076`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R57-081 — Upgrade barrier (e) the purchase itself failing — 3: 'There's an issue where you try to get premium but it had a connection issue' (AU, titled 'Would be fun if it allowed me to get premium'); 'I want to buy Premium to remove ads but it keeps failing with an unknown error' (1★); 'I want to buy but it tells me to wait because it's updating'

- **Where:** §5.6 (e)
- **This app does:** purchase flow errors
- **User reaction:** blocked-conversion
- **Magnitude:** 3
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `8245723501`, `8235594886`, `8254302702`
- **Canonical:** C077 Purchase and signup flow must not leak buyers

### R57-101 — Fix 1: close out the Premium-activation failure and say so publicly — verify 3.1.1 resolves it for users who reported otherwise and post responses on the affected reviews; six of eight are 1★ from paying customers, three ask for fast action and one offers to raise their rating — 'the cheapest rating recovery available in the entire corpus'

- **Where:** §8.1 #1
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 8 in 5 days
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14358584372`, `14340812621`, `14346556200`, `13014831178`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers

### R57-102 — Fix 2: fix the restore-purchase path — 8 lose their purchase on reinstall or device change, all from 2024 onward; 3 never had entitlement apply; 'a payer who loses their purchase and sees ads again is the worst experience this product can deliver'

- **Where:** §8.1 #2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** restore 8 (all 2024+); not applied 3
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `10774120558`, `11237191728`, `11551843035`, `11753525633`, `11814795489`, `5370880957`, `6887164010`, `8402874369`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R57-103 — Fixes 3–4: fix 'widget does not appear' (50, rising every era) and the phantom 'group deleted' (9, reproduction available); 58 of 90 widget-defect reviews are 4–5★ and recoverable; make 'Display on' actually filter or remove it — 8 report it ignoring selections 2020–2025, and 'a feature that silently fails keeps generating the request that produced it'

- **Where:** §8.1 #3, #4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** widget 50 + 9; Display on 8
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `12069773156`, `6417185599`, `8566400973`, `9511684630`, `9584258433`, `9672617646`, `11318555804`, `11929954675`, `12807350928`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C040 Widgets must not go blank, stale or disagree with the app

## Features

### R57-013 — Cross-device is the largest unmet need in the product's history and never resolved: 72 (9.24%, high-priority) ask for sync, an iPad build, a Mac build or usable backup — 44 (5.65%) iCloud/device sync, 21 (2.70%) iPad, 8 (1.03%) Mac, 17 (2.18%) backup/export; flat across all three eras (24 / 23 / 25) — 'please give us sync — I use iPad and iPhone and keep having to back up manually' (KR, 5★); 'No Syncing Across Devices… being restricted to one device makes this app useless to me' (US, 1★); 'people have been asking about iPad and Mac for years and you always say it's planned — is it ever actually happening?' (KR, 4★); one Japanese reviewer reports iCloud sync working (Sep 2024) yet six Korean reviewers after that date say it doesn't — either Premium-gated and undiscoverable, or partial

- **Where:** Executive summary 6; §3.4
- **This app does:** no reliable sync; no iPad or Mac build
- **User reaction:** complaint
- **Magnitude:** 72 (9.24%); sync 44; iPad 21; Mac 8; backup 17; eras 24/23/25
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `8942549944`, `10513784132`, `11361971544`, `11710806302`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C020 Data export / backup / CSV; C044 Mac / desktop / web app; C141 Native iPad layout

### R57-020 — Feature inventory derived from reviews with first-evidenced dates (verbatim): stamp check-in (2019, 19 praise the act); per-habit colour (2019, 22 praise, 4 want more); per-check-in notes (2019, 21 praise, 9 want notes on missed days); calendar with completion dots (2019, 11 praise, 4 want line rendering); weekly/monthly/yearly statistics and reports (2019, 24 praise; the yearly report called unique); reminders per weekday (2019, 10 praise, 5 want multiple per day); groups / categories (2020, 7 praise, Premium-gated in JP reading); home-screen widgets 3/6/14 slots small/medium/large (Oct 2020, 30 praise, 129 problems); Apple Watch app (Mar 2020, 8 praise, 26 report it hanging on 'Loading…'); streak counter (shipped Jan–Feb 2020); Dropbox backup/restore (Jan 2020, manual, 17 want more); iCloud sync (Sep 2024, only one review reports it working, 44 still ask); daily check-in count n per day (2023, capped at 5/day, later tier-restricted); archive for finished habits (2022, reviewers report losing the record when archiving); skip / rest-day (~mid-2024, eagerly awaited, only reachable from the calendar step); font selection (2024); photo attachment (2024, capped at 3 even with Premium); Shortcuts 'Check-in ID' (2025, undocumented); AI habit suggestion (Aug 2025 — both mentions say they cannot find it); in-app suggestion / bug-report form (2026, crashes on Submit); Family Sharing (advertised, did not work); requested and never evidenced: Android 13, Mac 8, iPad-native 21, working per-weekday filtering 16 + 8 defects, memo on a missed day 9, history of past reports 11, uncapped daily check-ins 24, habit-level notes 3, search 2, social 2, quit-habit tracking 1, Apple Health 1

- **Where:** §2.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Capability | First evidenced | Review evidence (IDs) | Notes from the corpus ; Habit / activity list with a "stamp" check-in | 2019-03-30 | 3948640864, 3960542933, 3968135443 | The core metaphor: *도장* (a seal/stamp). 19 reviewers praise the act itself. ; Per-habit colour selection | 2019-09-05 | 4731599171, 5419808409, 6861085361, 11676376793 | 22 reviewers praise it; 4 want more colours ; Per-check-in notes / memo | 2019-04-02 | 3968135443, 4519791548, 6522788831 | 21 reviewers praise; 9 want notes on *missed* days too ; Calendar view with completion dots | 2019-08-09 | 4591645326, 6437355632, 6061506881 | 11 praise; 4 want line/continuous rendering ; Weekly / monthly / yearly statistics and reports | 2019-03-31 | 3952930062, 7925046804, 13064021764 | 24 praise. 13064021764 calls the yearly report unique in the category ; Reminders / notifications, per weekday | 2019-09-06 | 4734681372, 6600719221, 13045863870 | 10 praise; 5 want multiple per day ; Groups / categories | 2020-06-04 | 6034586841, 7273860928, 9560536416 | 7 praise. Premium-gated in Japan's reading (8685490868) ; Home-screen widgets (3 / 6 / 14 slots, small / medium / large) | 2020-10-05 | 6502762176, 10887026952, 10356701753 | 30 praise; 129 raise a problem ; Apple Watch app | 2020-03-06 | 5621508960, 6359087808, 9537581546 | 8 praise; 26 report it hanging on "Loading…" ; Streak counter | 2020-02-11 | 5516233972 (thanks the dev for shipping it), 5360484203 (requested it) | Shipped between Jan and Feb 2020 ; Dropbox backup / restore | 2020-01-03 | 5353897655 (*"백업기능이 생겨서 너무 좋습니다"* / "so glad backup arrived"), 6160193157, 11338564382 | Manual, not automatic; 17 want more ; iCloud sync | 2024-09-10 | 11710806302 (JP) — the only review reporting it working | 44 reviewers still ask for it, several after that date ; Daily check-in count / "goal" (n times per day) | 2023-01-15 | 9511684630, 12095285181, 10887501928 | Capped at 5/day (11315669095, 10977856960); later restricted by tier (13169190954, 13386826119, 12570234049) ; Archive ("보관함") for finished habits | 2022-02-08 | 8332637759, 13064021764 | Reviewers report losing the record when archiving ; Skip / rest-day marking | 2024-06-22 | 11410069153 (*"Thank you for your continuous effort… I'm really pleased that I can use this feature, which I've been eagerly waiting for"*) | Shipped ~mid-2024; still only reachable from the calendar step ; Font selection | 2024-01-27 | 10869361826 (JP), 13034127559 (KR) | 2 praise ; Photo attachment | 2024-03-04 | 11005825245 (*"프리미엄을 구매해도 사진등록은 3개밖에 못하나요?"* / "even with Premium can I only attach 3 photos?") | Exists but capped; 9 reviewers request/expand it ; Shortcuts integration ("Check-in ID") | 2025-07-28 | 12946620398 (JP) — exists but undocumented | ; AI habit suggestion | 2025-08-05 | 12978533903, 13130410310 — both say they cannot find it | Shipped 2025; zero reviewers report using it successfully ; In-app suggestion / bug-report form | 2026-04-16 | 13962223534 (JP) — crashes on Submit | ; Family Sharing | 2023-12-21 | 10724795076 (MX) — advertised, did not work for them |
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `3948640864`, `4731599171`, `3968135443`, `4591645326`, `3952930062`, `4734681372`, `6034586841`, `6502762176`, `5621508960`, `5516233972`, `5353897655`, `11710806302`, `9511684630`, `8332637759`, `11410069153`, `10869361826`, `11005825245`, `12946620398`, `12978533903`, `13962223534`, `10724795076`
- **Canonical:** — (nuance register)

### R57-040 — Widget design limits (verbatim): widget_size_count_limits 23 (2.95%, 4.652) — only 3/6/14 slots, too large, wasted grey cells; widget_tap_opens_app 16 (2.05%, 4.750) — tapping launches the app instead of checking in; widget_order_random 6 (0.77%) — widget order doesn't match in-app order; widget_group_selection_request 4 — show one group; widget_tap_opens_app is a textbook regression — appears the week of the iOS 14 widget rewrite (Nov 2020) and stops dead after Dec 2023 (zero in 2024–26), consistent with a fix; all 16 Korean at 4.750 — 'if it's a widget the check should happen right there — why is the app launching?'; 'give us back checking from the widget'; 'since the update, checking in opens the app… I've used it well until now, so I'm giving five stars anyway'

- **Where:** §3.3.3 table (verbatim) and regression story
- **This app does:** widget tap opened app Nov 2020 – Dec 2023, then fixed
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 779 | Signal | Mean ★ | Window ; widget_size_count_limits — only 3/6/14 slots; too large; wasted grey cells | 23 | 2.95% | meaningful | 4.652 | 2020-10-05 → 2026-05-04 ; widget_tap_opens_app — tapping the widget launches the app instead of checking in | 16 | 2.05% | meaningful | 4.750 | 2020-11-04 → 2023-12-30 ; widget_order_random — widget order does not match in-app order | 6 | 0.77% | emerging | 4.333 | 2022-01-19 → 2024-04-14 ; widget_group_selection_request — let the widget show one group | 4 | 0.51% | emerging | 4.000 | 2020-11-12 → 2025-12-29
- **Direction for us:** build-free · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `6613303442`, `10138612858`, `6613226666`
- **Canonical:** C023 Interactive widget check-off

### R57-052 — Unmet needs — 267 (34.27%, 4.449, above corpus mean — 'a seven-year roadmap written by the user base') (verbatim): req_icloud_sync 44 (5.65%); req_multiple_checkins_day 24 (3.08%) — partially shipped as 'goal', then capped at 5 and tier-gated; req_ipad_version 21 (2.70%) — never shipped, 6 told it was planned; req_widget_improvements 20; req_backup_export 17 — Dropbox Jan 2020, still manual and Premium; req_weekday_display_filter 16 — shipped as 'Display on' and 8 report it broken; req_android_version 13 (all Korean); req_ui_tweak 13; req_past_report_history 11; req_memo_on_failed_day 9 (six years, not shipped); req_photo_attachment 9 (shipped, capped at 3); req_mac_version 8 (all Korean); req_interval_scheduling 7 (every N days, monthly, yearly, month-end); req_skip_rest_day 7 (shipped mid-2024, still requested after); req_todo_oneoff_tasks 7; req_archive_history 6 (keep the record when archiving); 12 requests at n=4–5 (reorder/sort, partial-completion mark, multiple reminders, watch, calendar view, goal %, memo aggregate, more colours, widget calendar, group selection, dark mode, journaling); 29 requests at n=1

- **Where:** §3.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Request | n | % of 779 | Signal | Mean ★ | Window | Status per the corpus ; req_icloud_sync — sync across devices | 44 | 5.65% | high-priority | 4.318 | 2019-05-11 → 2026-04-02 | 1 reviewer reports it working (2024, JP); 6 KR reviewers after that say it doesn't ; req_multiple_checkins_day — log a habit n times a day | 24 | 3.08% | very strong | 4.167 | 2019-04-24 → 2026-05-05 | Partially shipped as "goal"; then capped at 5 and tier-gated ; req_ipad_version — native iPad layout | 21 | 2.70% | meaningful | 4.667 | 2019-04-01 → 2026-07-12 | Never shipped; 6 reviewers say they were told it was planned ; req_widget_improvements — widget options generally | 20 | 2.57% | meaningful | 4.700 | 2019-03-31 → 2024-05-17 | ; req_backup_export | 17 | 2.18% | meaningful | 4.176 | 2019-04-02 → 2026-05-03 | Dropbox shipped Jan 2020; still manual and Premium-gated ; req_weekday_display_filter — show only today's habits | 16 | 2.05% | meaningful | 4.250 | 2019-09-06 → 2024-03-05 | Shipped as "Display on" — and 8 reviewers report it not working ; req_android_version | 13 | 1.67% | meaningful | 4.615 | 2020-06-17 → 2025-03-04 | All 13 Korean. Not shipped ; req_ui_tweak (misc. layout asks) | 13 | 1.67% | meaningful | 4.385 | 2019-10-12 → 2025-08-26 | ; req_past_report_history — see last week's/month's report | 11 | 1.41% | meaningful | 4.364 | 2020-01-31 → 2025-06-20 | Still current in 2025 ; req_memo_on_failed_day — write a note on a day you missed | 9 | 1.16% | meaningful | 4.556 | 2019-07-26 → 2025-09-13 | Requested for six straight years; not shipped ; req_photo_attachment | 9 | 1.16% | meaningful | 4.333 | 2019-07-09 → 2024-07-29 | Shipped but capped at 3 ; req_mac_version | 8 | 1.03% | meaningful | 4.500 | 2022-01-03 → 2025-03-26 | All 8 Korean ; req_interval_scheduling — every-N-days, monthly, yearly, month-end | 7 | 0.90% | emerging | 3.571 | 2020-01-16 → 2026-08-23 | ; req_skip_rest_day | 7 | 0.90% | emerging | 4.857 | 2020-12-06 → 2026-04-16 | Shipped mid-2024 (11410069153 thanks the dev) — but still requested after ; req_todo_oneoff_tasks | 7 | 0.90% | emerging | 4.714 | 2020-05-06 → 2024-12-28 | ; req_archive_history — keep the record when archiving | 6 | 0.77% | emerging | 4.500 | 2019-06-03 → 2025-08-26 | ; 12 requests at n = 4–5 | — | — | emerging | — | — | reorder/sort, partial-completion mark, multiple reminders, watch support, calendar view, goal %, memo aggregate, more colours, widget calendar, group selection, dark mode, journaling ; 29 requests at n = 1 | — | 0.13% each | weak | — | — | Enumerated by ID at §9.2 / §9.3. "One person said this."
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C141 Native iPad layout

### R57-054 — Notes on a missed day (9 requests, 2019–2025, three languages): the app only allows a note after a successful check-in — 'I want to write down why I couldn't do it on the days I failed' (KR, 5★); 'I couldn't write the reason for failing' (2025); 'enable memo added feature for non checked-in item… add in the reason for didn't checked it in as future reference' (MY) — unusually consistent wording, a real gap

- **Where:** §3.4 special 3
- **This app does:** notes only on success
- **User reaction:** complaint
- **Magnitude:** 9 (1.16%, 4.556)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `7474862382`, `13130410310`, `7765160326`
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R57-055 — Platform requests: Android 13 (all Korean, not shipped); Mac 8 (all Korean); iPad native 21 (never shipped)

- **Where:** §3.4 Android / Mac / iPad
- **This app does:** iPhone only
- **User reaction:** complaint
- **Magnitude:** 13 / 8 / 21
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C044 Mac / desktop / web app; C051 Android version; C141 Native iPad layout

### R57-056 — Smaller requests: interval scheduling — every N days, monthly, yearly, month-end (7, 3.571); skip / rest day shipped mid-2024 ('I'm really pleased that I can use this feature, which I've been eagerly waiting for') yet still requested after, only reachable from the calendar step; one-off to-dos (7); keep the record when archiving (6); history of past weekly / monthly reports (11); photo attachment capped at 3 even with Premium (9)

- **Where:** §3.4 skip / interval / archive
- **This app does:** partial
- **User reaction:** complaint
- **Magnitude:** 7 / 7 / 7 / 6 / 11 / 9
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `11410069153`, `11005825245`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency; C050 One-off to-dos alongside habits; C208 Photo / media / URL attached to a habit, memo or diary entry

### R57-059 — Named-feature praise 135 (17.33%, 4.785): widget 30; stats and reports 24; memo notes 21; stamp satisfaction 19 (4.947) — the emotional core, specific to the metaphor ('there's hardly a reward system more intuitive and efficient than stamps filling up'; 'I want to fill the calendar with pretty dots so I keep wanting to do things'); calendar view 11; reminders 10; Watch 8; grouping 7; feature shipped 7; sound feedback 5 ('a little thrill in the sound when you check a habit'); past-date check-in 4; non-punitive 3; goal count, backup added, iCloud sync added 1 each

- **Where:** §3.5.3
- **This app does:** free: stamp check-in with sound; stats; notes
- **User reaction:** praise
- **Magnitude:** 135 (17.33%, 4.785); stamp 19 (4.947)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `3968135443`, `5915290653`, `6437355632`, `6842138669`
- **Canonical:** C011 Weekly / monthly / yearly reports; C069 Check-off sound and haptic

## Monetization

### R57-025 — Free / paid / trial reconstructed from review text (verbatim): core tracking free ('I can't believe this is free'); creating a habit beyond the free cap ad-gated, then paywalled ('make three to-dos and an ad appears'; 'it won't let me without paying $30'; 'At first unlimited habits were free but now only three are for free?'); free-tier habit ceiling tightened over time — 20 reviewers (2.57%): 2020–21 3, 2023 1, 2024–26 16, one capped at 5 after paying; banner + interstitial ads free tier only, removed by Premium ('I want to buy Premium just to remove ads'; 'Paying for Premium is a definite must have - ads are extremely bothersome without it'); dark mode Premium in the US reading ('shell out $13 for premium just for dark mode'); groups Premium in the JP reading; backup/restore Premium ('you can't back up at all unless you buy — this is practically blackmail'); data retention beyond 30 days Premium from ~2026; multiple check-ins per day became Premium-gated (previously-free items retroactively capped to one); calendar / weekly widget Premium (a CA buyer bought lifetime for it); Premium model one-time lifetime → later subscription ('Love the idea of lifetime subscription'; 'a single payment with no subscription at all' ES; 'I subscribed'; 're-bought Premium annual'; 'how do I cancel the subscription?' 2022); free trial does not exist — 3 ask ('you only want to pay after trying it free')

- **Where:** §2.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Capability | Status per the corpus | Evidence ; Download and core tracking | Free | 9026380199 (*"Simple, easy, straightforward, no fuss. Free"*), 11031107771 (*"Easy to use and it's free"*), 5604731898 (*"이게 공짜라니"* / "I can't believe this is free") ; Creating a habit beyond the free cap | Ad-gated, then paywalled | 10476012561 (*"투두 세개만들면 광고가 떠요"* / "make three to-dos and an ad appears"), 12474152923 (*"3-4개인가 넘으면 목표 추가 하려고 시도할때마다 광고봐야함"*), 12446921299 (US, *"it won't let me without paying $30"*), 12795320709 (PK, *"At first unlimited habits were free but now only three are for free?"*) ; Free-tier habit ceiling | Tightened over time — 20 reviewers (2.57%) | 2020–2021: 3 reviews · 2023: 1 · 2024–2026: 16. 12020319439 reports being capped at 5 *after* paying ; Banner + interstitial ads | Free tier only; removed by Premium | 8235594886 (*"광고제거때문에 프리미엄 결제하고싶은데"* / "I want to buy Premium just to remove ads"), 8751577977 (*"Paying for Premium is a definite must have - ads are extremely bothersome without it"*) ; Dark mode | Premium (US reading) | 9239739610 (*"I have to shell out $13 for premium just for dark mode"*) ; Groups | Premium (JP reading) | 8685490868 (*"グループ分けはプレミアムのみの機能でした"* / "grouping turned out to be Premium-only") ; Backup / restore | Premium | 11103760055 (*"구매를 안 하면 아예 백업 안 된다~ 이러고 있네요^^.. 참나.. 협박도 아니고"* / "so you can't back up at all unless you buy — this is practically blackmail"), 11222810326, 10869361826 (JP) ; Data retention beyond 30 days | Premium, from ~2026 | 13592161917 (US, 1★, *"Changed the data retention policy to 30 days for the free version"*), 6181430289 (2020, wanted to buy precisely *"전체기록 보유하고 싶으니"* / "because I want to keep the full record") ; Multiple check-ins per day (>1) | Became Premium-gated | 13169190954 (JP, *"急にデイリーチェックインが有料機能になりましたか？"*), 13386826119 (SG), 12570234049 (KR, describes previously-free items being retroactively capped to one) ; Calendar / weekly widget | Premium | 9488882585 (*"프리미엄 달력위젯"*), 10747044142 (*"프리미엄 전용 위젯"*), 14185972618 (CA, bought lifetime for the weekly widget) ; Premium pricing model | One-time "lifetime" → later a subscription | Lifetime: 7106407718 (*"Love the idea of lifetime subscription"*), 8419383942 (*"Just bought the lifetime premium"*), 6636232220 (ES, *"el pago es único sin ningún tipo de suscripción"* / "a single payment with no subscription at all"), 9541183862 (*"바로 영구결제했어요"*). Subscription: 14346556200 (*"구독햇는데"* / "I subscribed"), 14351975658 (*"프리미엄 연간으로 재구매"* / "re-bought Premium annual"), 14352377997 (HK, *"I paid for the premium and now it asks for subscription??!"*), 9224244598 (2022, *"구독취소 어떻게 하나요?"* / "how do I cancel the subscription?") ; Free trial | Does not exist — 3 reviewers ask for one | 8301510290 (*"기간체험으로 만들어도 괜찮을 것 같습니다"* / "a time-limited trial would be good"), 10850332771 (*"무료 체험 2주 후 할인된 가격에 결제 이런거라든가"* / "how about a 2-week trial then a discounted price"), 12572214309 (*"무료 사용해보고 마음이 생겨야 유료로 바꿀 마음이 생기잖아요"* / "you only want to pay after trying it free")
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `9026380199`, `11031107771`, `5604731898`, `10476012561`, `12474152923`, `12446921299`, `12795320709`, `12020319439`, `8235594886`, `8751577977`, `9239739610`, `8685490868`, `11103760055`, `13592161917`, `6181430289`, `13169190954`, `12570234049`, `9488882585`, `14185972618`, `7106407718`, `6636232220`, `9224244598`, `8301510290`, `10850332771`, `12572214309`
- **Canonical:** — (nuance register)

### R57-029 — Dark mode Premium-gated (US reading): 'I have to shell out $13 for premium just for dark mode'

- **Where:** §2.2 dark mode paid
- **This app does:** paid: dark mode
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `9239739610`
- **Canonical:** C009 Basic widgets, icons and colours are free; C080 Colour themes / dark mode

### R57-030 — No free trial — 3 ask for one: 'a time-limited trial would be good'; 'how about a 2-week trial then a discounted price'; 'you only want to pay after trying it free'

- **Where:** §2.2 no trial
- **This app does:** no trial
- **User reaction:** blocked-conversion
- **Magnitude:** 3 reviews
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `8301510290`, `10850332771`, `12572214309`
- **Canonical:** C063 Free trial before purchase

### R57-050 — Monetisation friction 89 (11.42%, 2.989) headline counts: free_tier_cap 20 (2.57%); price_too_high 20 (2.57%); post_purchase_failure 22 (2.82%); monetization_model_change_complaint 10 (1.28%, mean 1.700 — lowest with n ≥ 5); paywall_feature_gating 8; refund_request 8; restore_purchase_failure 8; accidental_purchase 6 (0.77%); price_discount_request 6; subscription_objection 4; premium_not_applied 3; price_unbundling_request 3; purchase_failure 3; trial_request 3; billing_error 2; price_increase_complaint 2; reliability_blocks_purchase 2; misleading_premium_claims 1; subscription_request 1

- **Where:** §3.3.7
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 89 (2.989)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R57-065 — 3★ (n=72) is where price lives (verbatim): update regression 9, widget not showing 8, price_too_high 6 (8.3% vs 2.57% corpus, 3.2×), design / ads gate 5 each, intent / widget updating / watch / ads / free cap 4 each — the 'I would pay but not that much' bucket: 'adding a monthly payment plan would be so useful. The lifetime premium plan is not at all affordable to a wider audience' (PL); 'I want to purchase the app, please put a discount on it' (MX)

- **Where:** §4.3 table (verbatim)
- **This app does:** ₩29,000 lifetime
- **User reaction:** blocked-conversion
- **Magnitude:** Theme | n | % of the 72 ; update_regression | 9 | 12.5% ; bug_widget_not_showing | 8 | 11.1% ; price_too_high | 6 | 8.3% ; aesthetic_design / ads_gate_habit_creation | 5 each | 6.9% ; intent_to_purchase / bug_widget_not_updating / bug_watch_loading / ads_complaint / free_tier_cap | 4 each | 5.6%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `10639075443`, `10850332771`, `10683827705`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C025 Scholarship / hardship / discount program; C092 Regional pricing

### R57-071 — Purchase triggers (b) removing ads ('I want to buy Premium just to remove the ads'; 'Paying for Premium is a definite must have - ads are extremely bothersome without it') and (c) a specific gated feature already decided on — most often the weekly / calendar widget or backup ('I liked the week-at-a-glance widget so I bought it today'; 'I bought it for that one feature')

- **Where:** §5.2 (b), (c)
- **This app does:** paid: ad removal; calendar widget; backup
- **User reaction:** purchase-driver
- **Magnitude:** report gives none
- **Direction for us:** build-paid · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `8235594886`, `8751577977`, `14057836658`, `14185972618`, `13014831178`
- **Canonical:** C020 Data export / backup / CSV; C040 Widgets must not go blank, stale or disagree with the app; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R57-073 — Purchase trigger (e) the lifetime model itself: lifetime_purchase_praise 8 (1.03%, 4.875), 6 non-Korean, 4 US — 'Love the idea of lifetime subscription. Premium version is simple and great'; 'The one time fee for the premium version is also very worth it'; 'Better than the apps that charge hundreds of dollars a year'; 'payment is one-off with no subscription… charging monthly for a simple calendar or diary seems abusive to me' (ES, then bought)

- **Where:** §5.2 (e)
- **This app does:** one-time lifetime Premium
- **User reaction:** purchase-driver
- **Magnitude:** 8 (1.03%, 4.875)
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `7106407718`, `7678866168`, `8100714507`, `6636232220`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R57-074 — What payers value (segment of 99, verbatim): ease 11 (11.11%), simplicity 10, comparative best 9, design 8, price_fair_praise 6 (of 8 global), widget 6, lifetime praise 5, to-do use 4, stats / advocacy 4 each — price_fair_praise is the counterweight to price_too_high: 'Premium is worth it'; 'for someone who wants to be thorough about multiple habits, I think ¥4,500 is worth paying' (JP); 'I don't regret the money at all' — at the 2020–2022 price the value case was made easily; every price_too_high review from 2024 quotes the higher figure

- **Where:** §5.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of payers | Global n ; ease_of_use | 11 | 11.11% | 81 ; simplicity_minimal | 10 | 10.10% | 95 ; comparative_best | 9 | 9.09% | 69 ; aesthetic_design | 8 | 8.08% | 69 ; price_fair_praise | 6 | 6.06% | 8 ; widget_praise | 6 | 6.06% | 30 ; lifetime_purchase_praise | 5 | 5.05% | 8 ; todo_list_use | 4 | 4.04% | 8 ; stats_reports_praise / advocacy_recommend | 4 each | 4.04% | 24 / 24
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `10791311772`, `12332213705`, `11771136717`, `6144426625`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R57-078 — Upgrade barriers: (b) no trial — 3 ask, always because the free tier is too constrained to evaluate the paid one ('the Premium features don't land for me — a time-limited trial would be fine'; 'a two-week trial then a discount — I'd just pay under ₩20,000 but this is nearly ₩30,000'); (c) all-or-nothing bundling — 3 on three continents propose unbundling: 'I'd need only no-ads, and more groups, and more intervals. Would appreciate separating the features so I can pay for only the ones I want' (CA); 'a staged ~¥2,000 plan with ad removal, group unlocking and backup' (JP); 'adding a monthly payment plan would be so useful. The lifetime premium plan is not at all affordable to a wider audience' (PL)

- **Where:** §5.6 (b), (c)
- **This app does:** one bundle, lifetime only
- **User reaction:** blocked-conversion
- **Magnitude:** trial 3; unbundling 3
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `8301510290`, `10850332771`, `12572214309`, `7028234235`, `11510979900`, `10639075443`
- **Canonical:** C063 Free trial before purchase; C092 Regional pricing

### R57-109 — Structural 11: unbundle Premium or introduce a trial for price-resistant markets — price objection 8.05% outside Korea vs 0.99% inside, Japan 26.92%; three reviewers on three continents independently proposed a cheaper tier of ad removal + groups + backup, three more asked for a trial; the numbers reviewers name are ¥2,000 and 'under ₩20,000'

- **Where:** §8.2 #11
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 8.05% vs 0.99%; ¥2,000 / <₩20,000
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `7028234235`, `11510979900`, `10639075443`
- **Canonical:** C092 Regional pricing

## Tactics the app used

### R57-037 — The ad length escalated from 5 seconds (2021) to 29–30 seconds (from 2023) — 'the lifetime price was more than I expected so I stayed free — now you've put a 30-second ad on even creating a habit. The ads keep getting worse so I'm just leaving' (KR, 1★, Sep 2023); six reviewers accept the ads and every one gives 5★ — they describe the ad as short and confined to creation ('there are ads but they're short enough that I don't mind'; 'if you tolerate the full-screen ad only when adding a routine, day-to-day maintenance isn't disturbed') — 'the mechanic is survivable at 5 seconds and not at 30. The corpus contains the A/B result already'

- **Where:** §3.3.1 ad length
- **This app does:** interstitial 5s (2021) → 30s (2023+)
- **User reaction:** mixed
- **Magnitude:** ads_tolerable 6 (5.000) vs gate 26 (2.154)
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `7877990468`, `8110196858`, `10614381628`, `10353308106`, `11543927654`, `14240219624`, `7063081300`, `7108755746`, `10263515783`, `11042165108`, `11510979900`, `12224924926`
- **Canonical:** C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

### R57-111 — Experiments (verbatim): interstitial 30s vs 5s vs none on create (D1 retention + creation completion); gate moved from habit n=3 to n=8 (share of installs creating ≥3 habits); a ~40%-priced tier of ads + groups + backup in JP/US/EU (revenue per install, not conversion); 7-day full-feature trial (trial→paid and price_too_high review rate); in-app FAQ answering the five most-asked review questions (question_to_developer volume); proactive changelog + grandfathering notice before tier changes (1–2★ rate in the 30 days after)

- **Where:** §8.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Experiment | Hypothesis it tests | Findings behind it | Primary metric ; Interstitial length: 30s vs 5s vs none, on the create action | Tolerance is a function of duration, not existence | §3.3.1 — all six ads_tolerable reviewers describe a short ad | D1 retention + habit-creation completion rate ; Move the gate from habit *n=3* to *n=8* | The gate fires before the product has demonstrated value | 10476012561, 12474152923, 13878772549, 12446921299 | Share of installs that create ≥ 3 habits ; A ~40%-priced tier (ads + groups + backup only) in JP/US/EU | Bundling, not price, is the barrier | §5.6(c), three independent proposals | Revenue per install, not conversion rate ; 7-day full-feature trial | The free tier is too constrained to evaluate the paid one | 8301510290, 10850332771, 12572214309 | Trial→paid, and the price_too_high review rate ; In-app FAQ answering the five most-asked review questions | A measurable share of reviews are support tickets | §6.2(a) — 49 KR questions, mostly about existing features | Volume of question_to_developer reviews ; Proactive changelog + grandfathering notice before any tier change | Surprise, not price, drives the 1.700-mean theme | §7.3, §4.4 | 1–2★ rate in the 30 days after a tier change
- **Direction for us:** research · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `10476012561`, `12474152923`, `13878772549`, `12446921299`, `8301510290`, `10850332771`, `12572214309`
- **Canonical:** C063 Free trial before purchase; C092 Regional pricing; C104 Never ship a paywall or feature-removal change silently; C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

## Insights (the why)

### R57-036 — Ads sub-themes (verbatim): ads_complaint 31 (3.98%, 1.903); ads_gate_habit_creation 26 (3.34%, 2.154, from Jan 2021); ads_broken 8 (1.03%, 2.875); ads_tolerable 6 (0.77%, 5.000); union 47 (6.03%, 2.234) — rating distribution 1★ 23 · 2★ 7 · 3★ 8 · 4★ 1 · 5★ 8, half of every ads review a one-star; of 25 reviewers who state they deleted the app, 20 (80%) name ads (14 volume, 13 creation gate, 2 broken ad) — next largest cause 'can't find delete' at 2, zero stated deletions cite a crash or data loss; 'ads make you spend longer in the app so the efficiency disappears — deleted'; 'used it for years, deleting it now' (title 'wow, whose idea was it to put an ad on plan creation'); 'I downloaded this to help myself manage my adhd struggles but as soon as I made a single activity scheduled it gave me an add. Literally distracted me before I could get familiarized with the app' (US, 2★)

- **Where:** §3.3.1 table (verbatim) and churn link
- **This app does:** ads
- **User reaction:** churn
- **Magnitude:** Sub-theme | n | % of 779 | Signal | Mean ★ | Window ; ads_complaint — ads are too many / too intrusive | 31 | 3.98% | very strong | 1.903 | 2019-10-16 → 2026-06-29 ; ads_gate_habit_creation — you must watch an ad to create a habit | 26 | 3.34% | very strong | 2.154 | 2021-01-26 → 2026-08-24 ; ads_broken — the required ad fails, blocking creation entirely | 8 | 1.03% | meaningful | 2.875 | 2020-03-11 → 2026-08-24 ; ads_tolerable — ads exist but the reviewer accepts them | 6 | 0.77% | emerging | 5.000 | 2021-03-04 → 2025-01-24 ; Union (complaint ∪ gate ∪ broken) | 47 | 6.03% | high-priority | 2.234 | 2019-10-16 → 2026-08-24
- **Direction for us:** dont · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `5672929597`, `10346163428`, `10269881878`, `6914248951`
- **Canonical:** C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

### R57-057 — UX praise detail: simplicity 95 (4.779), ease 81 (4.901), design 69 (4.609), colour 22, fonts 2; phrasing stable across seven years and languages ('clean with no fat' 2019 → 'nothing is excessive, so very clean' 2025; 'less complicated compared to other apps with too many features' SG; 'minimalist and very useful' MX); but simplicity is the only major praise theme that declines steeply — 14.77% of E1 → 12.22% E2 → 7.51% E3 — while ease (10.36 → 11.11 → 9.86) and design (9.33 → 7.22 → 9.39) are flat: 'people still find it easy and still find it pretty. They have stopped calling it clean' — plausibly because the ad gate and paywall are now part of the experience

- **Where:** §3.5.1
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** simplicity 14.77% → 7.51%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `3948640864`, `12794891062`, `6262697602`, `9423831917`, `8049708812`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R57-060 — non_punitive_praise 3 — small but strategically loud: 'This is the only habit-building app that didn't make me feel like a failure for missing a day / breaking a streak'; 'there's no penalty or annoying reminder to do the goal, but when you check it off it gives you a big pop up with confetti and it gives me ALL the dopamine' (US); 'calm, non-judgmental approach to habit tracking' (RU)

- **Where:** §3.5.3 non-punitive
- **This app does:** no penalty; confetti on completion
- **User reaction:** praise
- **Magnitude:** 3 (0.39%)
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `8193352845`, `10887501928`, `13574542005`
- **Canonical:** C101 Milestones, achievements, celebration; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R57-061 — Outcomes 43 (5.52%, 4.930) — 'DayStamp is changing my life'; 'I've kept good habits going for over five months'; 'I have set a dozen mini goals so that no matter what kind of day I am having, I can do one or two mini goals and feel successful' (US) — falling sharply 7.25% of E1 → 5.56% E2 → 2.35% E3; advocacy 24 (4.917) and first_review_ever 7 (5.000) — 'I write food-delivery reviews but never app reviews — this was so good I came to the App Store specially'; developer appreciation 30 (4.933), 27 Korean, several by name ('Cheering for developer Donghyun!'; 'developer, may you sit on a cushion of money')

- **Where:** §3.5.4
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** outcome 43 (7.25% → 2.35%); advocacy 24; first review 7; appreciation 30
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `5604731898`, `7062715389`, `4280559577`, `8395300492`, `6861085361`, `10887501928`, `7004263966`, `5947186533`, `6842138669`
- **Canonical:** — (nuance register)

### R57-062 — Acquisition signals are thin: only 2 of 779 name how they found the app — 'I found it by asking GPT to recommend an app with the features I wanted' (KR, 2025, the only AI-discovery attribution) and 'found it while browsing and installed immediately' (KR, 2021); 'I can't believe it has so few downloads' (MX) — growth appears to be organic App Store discovery plus Korean word of mouth

- **Where:** §3.6
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 2 of 779
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `13560296828`, `6861085361`, `12018975480`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R57-063 — Distribution 5★ 450 (57.77%) · 4★ 156 (20.03%) · 3★ 72 (9.24%) · 2★ 29 (3.72%) · 1★ 72 (9.24%); 5★ table (verbatim): simplicity 76 (16.9%), ease 73 (16.2%), comparative best 62 (13.8%), paid 52 (11.6%), design 49, outcome 40, question to developer 35 (7.8%), feature completeness 32, req_icloud_sync 29 (6.4%), developer appreciation 28, update_regression 26 (5.8%), stats / widget / advocacy 22 each — the five-star complaint is the signature form ('just one genuinely disappointing thing — please give us sync'; 'suddenly the widget says my group was deleted'); a reviewer filed 1★ over a black widget and explicitly offered to raise the rating if fixed ('I bought it for that one feature')

- **Where:** Part 4; §4.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of the 450 ; simplicity_minimal | 76 | 16.9% ; ease_of_use | 73 | 16.2% ; comparative_best | 62 | 13.8% ; paid_premium_confirmed | 52 | 11.6% ; aesthetic_design | 49 | 10.9% ; outcome_behavior_change | 40 | 8.9% ; question_to_developer | 35 | 7.8% ; feature_completeness_praise | 32 | 7.1% ; req_icloud_sync | 29 | 6.4% ; developer_appreciation | 28 | 6.2% ; update_regression | 26 | 5.8% ; stats_reports_praise / widget_praise / advocacy_recommend | 22 each | 4.9%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `8942549944`, `12304194492`, `13014831178`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C040 Widgets must not go blank, stale or disagree with the app

### R57-064 — 4★ (n=156) is the payer's bucket (verbatim): paid 28 (17.9%), simplicity 17, design / widget not showing / question 14 each, update regression 12, can't find delete 10, ease / widget not updating 8 — 'I paid, I like it, and one specific thing is wrong' ('with a white background the text stays white'; 'Is it at all possible to be able to have unlimited widget options?')

- **Where:** §4.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of the 156 ; paid_premium_confirmed | 28 | 17.9% ; simplicity_minimal | 17 | 10.9% ; aesthetic_design / bug_widget_not_showing / question_to_developer | 14 each | 9.0% ; update_regression | 12 | 7.7% ; cant_find_delete_edit | 10 | 6.4% ; ease_of_use / bug_widget_not_updating | 8 each | 5.1%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `11159431115`, `10678560230`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R57-067 — 1★ (n=72) has two authors (verbatim: uninstalled 20 (27.8%), ads 18 (25.0%), paid 15 (20.8%), post-purchase failure 13 (18.1%), ads gate 13 (18.1%), update regression / widget not showing 9, crash 7, free cap / data loss 6, unresponsive support / model change / can't delete 5): (a) the new user who hit the ad gate and left — short (median 61 characters), fast and final, before seeing a single feature; (b) the paying customer whose purchase stopped working — payers are 12.71% of the corpus but 20.8% of one-stars ('why did I even pay'; 'bought the paid version, the widget doesn't work… KakaoTalk support just reads and doesn't reply. Waste of money') — they need opposite fixes: (a) positioning and pacing, (b) engineering and support

- **Where:** §4.5 table (verbatim) and two authors
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of the 72 ; churn_uninstalled | 20 | 27.8% ; ads_complaint | 18 | 25.0% ; paid_premium_confirmed | 15 | 20.8% ; post_purchase_failure | 13 | 18.1% ; ads_gate_habit_creation | 13 | 18.1% ; update_regression / bug_widget_not_showing | 9 each | 12.5% ; bug_app_crash | 7 | 9.7% ; free_tier_cap / bug_data_loss | 6 each | 8.3% ; support_unresponsive / monetization_model_change_complaint / cant_find_delete_edit | 5 each | 6.9%
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14351907761`, `12128022974`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

### R57-070 — Purchase trigger (a) a short self-directed free use — usually days, sometimes one: 'used it for one day, loved it, bought it immediately'; 'the moment I found it, it seemed convenient and good, so I bought Premium'; 'one more month and if I'm still using it I'll buy, because I want to keep the full record'; intent_to_purchase 30 (3.85%, 4.300)

- **Where:** §5.2 (a)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** intent 30 (3.85%, 4.300)
- **Direction for us:** do · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `6437355632`, `7585307830`, `5714521465`, `6181430289`
- **Canonical:** C147 Let people use the product before they pay

### R57-072 — Purchase trigger (d) gratitude and support with no feature attached: 'you made a good app, so I bought Premium'; 'Just bought the lifetime premium - I support the developers and kudos'; 'the purchase option is one-time rather than subscription, so I intend to pay soon as a gesture of thanks'; 'of course I paid; this is an I-bought-it-myself review'

- **Where:** §5.2 (d)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** report gives none
- **Direction for us:** do · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `5611409056`, `8419383942`, `11042165108`, `8672688722`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R57-076 — Refunds are rare and that is not good news: 8 (1.03%) request a refund, 6 of them accidental purchases from 2019–2023; only two refund requests come from genuine dissatisfaction (US 2022 widget ordering 'fixed or a refund'; KR July 2026 after re-buying and still broken) — unhappy payers write a one-star and remain broken; the absence of refund requests is not satisfaction

- **Where:** §5.4 refunds
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** refunds 8; 2 genuine
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `9349167270`, `14351975658`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R57-080 — Upgrade barrier (d) reliability — reliability_blocks_purchase 2 (0.26%, 1.500) state bugs are why they won't pay: 'aren't you going to fix the widget bug? You don't seem to take feedback or update often, so I'm hesitating about paying' (KR, 2★, Mar 2026) — the only theme stating the causal link between widget defects and revenue

- **Where:** §5.6 (d)
- **This app does:** bugs block purchase
- **User reaction:** blocked-conversion
- **Magnitude:** 2 (1.500)
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `13840622066`, `12572214309`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R57-100 — What did not change: the praise vocabulary (깔끔 / 심플 / 직관적 / simple / clean in 2019 and 2026); the request list (sync, iPad, multiple daily check-ins, notes on missed days, past reports); ease and design praise; question_to_developer (6.99% → 5.00% → 6.57%) — Koreans used the review box as a help desk for the product's whole life; update_regression (7.51% → 6.11% → 8.92%) — 'an update broke it' constant for seven years

- **Where:** §7.10
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** questions 6.99 → 6.57%; update regression 7.51 → 8.92%
- **Direction for us:** none · **Report confidence:** trend · **Generalisable:** app-specific
- **Canonical:** C175 Updates must not break function or wipe progress

### R57-112 — Research questions: 1 the actual conversion rate (12.71% of reviewers is not a user figure); 2 did the interstitial raise or lower revenue (20 uninstalls attributed vs 8 purchases to remove ads — not net); 3 why is Korea 77.66% (localisation, ASO, press, community or an Android gap — no channel attribution); 4 is iCloud sync shipped, Premium-gated or partial (one sentence from the team resolves it); 5 what happened to review volume (179 in 2020, 37 in 2026); 6 do 1★ ad reviewers ever come back (none describes reinstalling); 7 the current price and model (store metadata unreachable)

- **Where:** §8.4 part 8 #1, part 8 #2, part 8 #3, part 8 #4, part 8 #5, part 8 #6, part 8 #7
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

## Audiences

### R57-069 — Payers — paid_premium_confirmed 99 (12.71%): mean 4.010 (below corpus 4.134); 5★ 52 · 4★ 28 · 3★ 2 · 2★ 2 · 1★ 15; kr 78, us 11, jp 4, ca 2, mx 2, es 1, hk 1; by year 2019 4 · 2020 17 · 2021 10 · 2022 12 · 2023 10 · 2024 27 · 2025 7 · 2026 12 (32.4% of that year); by era E1 31 (4.258) · E2 22 (4.091) · E3 46 (3.804); excludes 6 accidental-purchase reviewers who paid by mistake; not a conversion rate

- **Where:** §5.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Property | Value ; n | 99 (12.71% of 779) ; Mean ★ | 4.010 (corpus 4.134 — payers rate *lower* than the corpus) ; Rating split | 5★ 52 · 4★ 28 · 3★ 2 · 2★ 2 · 1★ 15 ; Storefronts | kr 78 · us 11 · jp 4 · ca 2 · mx 2 · es 1 · hk 1 ; By year | 2019: 4 · 2020: 17 · 2021: 10 · 2022: 12 · 2023: 10 · 2024: 27 · 2025: 7 · 2026: 12 (32.4% of that year's 37 reviews) ; By era | E1 (2019–21) 31, mean 4.258 · E2 (2022–23) 22, mean 4.091 · E3 (2024–26) 46, mean 3.804
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `3982059993`, `5329161510`, `6288381604`, `6824956220`, `6829894423`, `9462337168`
- **Canonical:** — (nuance register)

## Markets and languages

### R57-016 — Korean users write support tickets in the review box: 50 (6.42%, high-priority) address a direct question to the developer, 49 of 50 Korean (8.10% of KR vs 0.57% of non-KR), mostly 5★ and mostly about things the app can already do (how to delete a habit, where widget settings are, whether iCloud works, what the archive is); 27 (3.47%) cannot find how to delete or edit a habit; 23 (2.95%) say there is no guidance at all; a Korean reviewer wrote a public how-to ('Everyone! For all the 1★ reviewers asking how to edit or delete — let me explain', 5★); six could not find how to contact the developer, eight say the developer never replied — an in-app help surface and a real support channel would remove a measurable share of negative reviews

- **Where:** Executive summary 9; §3.3.5
- **This app does:** no help surface; support hard to reach
- **User reaction:** complaint
- **Magnitude:** 50 (6.42%), KR 49 (8.10%); delete/edit 27; no guidance 23
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `7781598096`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C073 Manual reordering, renaming and editing of habits/tasks — free; C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R57-018 — Price resistance is real but almost entirely outside Korea: 20 (2.57%) say Premium is too expensive — 14 non-Korean (8.05% of 174) vs 6 Korean (0.99% of 605); Japan the epicentre — 7 of 26 (26.92%, limited evidence) object to the price, two to the ¥1,600 → ¥4,500 increase ('Premium has all these restrictions and ¥4,500 is steep, so I gave up. Another review mentions ¥1,600 — so it went up a lot'); '35$ for habit tracker is way too much' (UA); 'the buyout price is a bit expensive, could it come down?' (CN); three reviewers propose unbundling Premium (CA, JP, PL) and one asks for a monthly plan instead of lifetime

- **Where:** Executive summary 11; §5.6
- **This app does:** ₩29,000 / ¥4,500 / $30 lifetime
- **User reaction:** blocked-conversion
- **Magnitude:** 20 (2.57%); non-KR 14 (8.05%) vs KR 6 (0.99%); JP 7 of 26
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `10860902855`, `10562732428`, `5627754008`, `7028234235`, `11510979900`, `10639075443`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C092 Regional pricing

### R57-038 — Ads geography inverts: 2.48% of Korean reviews (15/605) vs 9.20% of non-Korean (16/174), a 3.7× difference; the US alone contributes 12 of the 47 (ads_complaint 15.15% of US reviews)

- **Where:** §3.3.1 geography
- **This app does:** same ads everywhere
- **User reaction:** churn
- **Magnitude:** KR 2.48% vs non-KR 9.20%; US 15.15%
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone; C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

### R57-079 — Upgrade barrier (a) price — 20 (2.57%), 14 non-Korean: 'I was going to buy at around ¥300, but ¥1,600 is a bit steep so I'm reluctantly giving up' (JP) — before the rise to ¥4,500

- **Where:** §5.6 (a)
- **This app does:** ¥1,600 → ¥4,500
- **User reaction:** blocked-conversion
- **Magnitude:** 20; JP would pay ¥300 / ¥2,000
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8685490868`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C092 Regional pricing

### R57-084 — Distribution (verbatim): Korea 605 (77.66%, 4.225); US 66 (8.47%, 3.727); Japan 26 (3.692); Canada 12 (4.083); Great Britain 10 (4.300); Mexico 7; Germany 6 (4.500); China 5; Brazil 4; AU, HK, IN, PL, RU, SA 3 each; CZ, ES, HU, MY, SG, VN 2 each; AT, DZ, IT, NZ, PE, PH, PK, UA 1 each — only Korea and the US clear 50; 'Korea is not a market segment in this corpus — it is the corpus'

- **Where:** §6.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Storefront | n | % of 779 | Mean ★ | 5★ | 4★ | 3★ | 2★ | 1★ | Eligible for standalone claims (≥50)? ; Korea | 605 | 77.66% | 4.225 | 367 | 126 | 45 | 15 | 52 | Yes ; United States | 66 | 8.47% | 3.727 | 33 | 10 | 6 | 6 | 11 | Yes ; Japan | 26 | 3.34% | 3.692 | 9 | 8 | 4 | 2 | 3 | ⚠️ No (n = 26) ; Canada | 12 | 1.54% | 4.083 | 6 | 4 | 0 | 1 | 1 | ⚠️ No ; Great Britain | 10 | 1.28% | 4.300 | 7 | 1 | 1 | 0 | 1 | ⚠️ No ; Mexico | 7 | 0.90% | 4.000 | 5 | 0 | 0 | 1 | 1 | ⚠️ No ; Germany | 6 | 0.77% | 4.500 | 4 | 1 | 1 | 0 | 0 | ⚠️ No ; China | 5 | 0.64% | 4.000 | 1 | 3 | 1 | 0 | 0 | ⚠️ No ; Brazil | 4 | 0.51% | 3.750 | 2 | 0 | 1 | 1 | 0 | ⚠️ No ; Australia, Hong Kong, India, Poland, Russia, Saudi Arabia | 3 each | 0.39% each | 3.667 / 3.000 / 5.000 / 3.667 / 3.667 / 3.333 | — | — | — | — | — | ⚠️ No ; Czechia, Spain, Hungary, Malaysia, Singapore, Vietnam | 2 each | 0.26% each | 3.000 / 3.500 / 3.500 / 4.000 / 3.500 / 4.000 | — | — | — | — | — | ⚠️ No ; Austria, Algeria, Italy, New Zealand, Peru, Philippines, Pakistan, Ukraine | 1 each | 0.13% each | — | — | — | — | — | — | ⚠️ No
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R57-085 — Korea n=605 (verbatim table vs non-KR): four findings — (a) Koreans use the review box as a support channel — question_to_developer 8.10% vs 0.57% (14×), and with can't-find-delete (23) and no-guidance (18) 65 distinct Korean reviewers (10.74%) are asking for help rather than reviewing; (b) Koreans notice releases — update_regression 8.76% vs 3.45% (older, tenured base — 17 of 23 long-tenure users Korean; feature_shipped_praise 5 of 7 Korean); (c) Koreans complain far less about money and far more about breakage — price 0.99% vs 8.05%, ads 2.48% vs 9.20%, free cap 1.65% vs 5.75% — plausibly tenure (already paid, 12.89%), not proven culture; (d) cross-device is a Korean demand — 37 of 44 sync, all 13 Android, all 8 Mac, 18 of 21 iPad ('please release this on Play Store so Galaxy users can use it too'; 'Korean apps really are the best — but having no Mac version, let alone iPad, is a fatal flaw')

- **Where:** §6.2 table (verbatim) and findings
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 605 | vs non-KR (n = 174) | Signal (KR denominator) ; paid_premium_confirmed | 78 | 12.89% | 12.07% | high-priority ; simplicity_minimal | 65 | 10.74% | 17.24% | high-priority ; ease_of_use | 60 | 9.92% | — | high-priority ; update_regression | 53 | 8.76% | 3.45% | high-priority ; question_to_developer | 49 | 8.10% | 0.57% | high-priority ; comparative_best | 48 | 7.93% | 12.07% | high-priority ; aesthetic_design | 47 | 7.77% | — | high-priority ; bug_widget_not_showing | 44 | 7.27% | — | high-priority ; req_icloud_sync | 37 | 6.12% | 4.02% | high-priority ; outcome_behavior_change | 30 | 4.96% | — | very strong ; developer_appreciation | 27 | 4.46% | — | very strong ; cant_find_delete_edit / bug_watch_loading | 23 each | 3.80% | — | very strong ; bug_keyboard_memo | 22 | 3.64% | 0.00% | very strong ; ads_complaint | 15 | 2.48% | 9.20% | meaningful ; ads_gate_habit_creation | 17 | 2.81% | 5.17% | meaningful ; free_tier_cap | 10 | 1.65% | 5.75% | meaningful ; price_too_high | 6 | 0.99% | 8.05% | emerging ; churn_uninstalled | 13 | 2.15% | 6.90% | meaningful
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `9091557818`, `9800909083`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C036 A support channel that exists, is reachable outside the app, and answers; C044 Mac / desktop / web app; C051 Android version; C141 Native iPad layout

### R57-086 — United States n=66 (verbatim table): bimodal — half the strongest advocacy in the dataset (18.18% best they've tried, 13.64% behaviour change, 15.15% has everything needed, 4 of 8 lifetime-model praises) and half the ad reaction (ads_complaint 15.15% and churn_uninstalled 15.15%, ~6× Korea; mean 3.727 vs 4.225); 'This app has every feature I was looking for' vs 'Ad vomit… I deleted this trash app immediately' — the US is where the free-tier experience decides the outcome and the ad gate decides it badly: 10 Americans uninstalled, 8 blame ads; both ADHD reviews are American and disagree — 2★ 'as soon as I made a single activity scheduled it gave me an add' vs 5★ 'The color coding and the variety of views has been amazingly functional for my ADHD' — same audience, opposite verdict, the difference is the ad

- **Where:** §6.3 table (verbatim) and reading
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Theme | n | % of 66 | vs KR | Signal (US denominator) ; simplicity_minimal | 13 | 19.70% | 10.74% | high-priority ; comparative_best | 12 | 18.18% | 7.93% | high-priority ; paid_premium_confirmed | 11 | 16.67% | 12.89% | high-priority ; ads_complaint | 10 | 15.15% | 2.48% | high-priority ; churn_uninstalled | 10 | 15.15% | 2.15% | high-priority ; feature_completeness_praise | 10 | 15.15% | 3.31% | high-priority ; outcome_behavior_change | 9 | 13.64% | 4.96% | high-priority ; aesthetic_design | 7 | 10.61% | 7.77% | high-priority ; ease_of_use / stats_reports_praise | 6 each | 9.09% | — | high-priority ; ads_gate_habit_creation | 5 | 7.58% | 2.81% | high-priority ; advocacy_recommend | 5 | 7.58% | 2.64% | high-priority ; lifetime_purchase_praise | 4 | 6.06% | 0.33% | high-priority ; free_tier_cap / free_praise / long_tenure_user | 4 each | 6.06% | — | high-priority ; monetization_model_change_complaint | 3 | 4.55% | 0.33% | very strong
- **Direction for us:** dont · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `9152772777`, `9783504520`, `6914248951`, `11929068665`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

### R57-087 — Japan n=26 (limited evidence) — the most monetisation-dense storefront: price_too_high 7 of 26 (26.92% vs 2.57% global), two documenting ¥1,600 → ¥4,500, one proposing a ¥2,000 tier, one would have paid ¥300; free_tier_cap 3 (11.54%), paywall gating 2, both price-increase reviews in the corpus; also the only cluster of onboarding_no_guidance (4, 15.38%) and localisation gaps — 'the suggestions that appear when you tap Ideas aren't in Japanese, and settings has English and Korean mixed in'; 'I can't understand explanations written in English. It'd be fine if the features were self-evident, but the screen is so minimal that they aren't' (1★) — most price-sensitive and least localised, unlikely independent; the only positive iCloud report and a 10GB storage report

- **Where:** §6.4
- **This app does:** partial Japanese localisation
- **User reaction:** blocked-conversion
- **Magnitude:** price 26.92%; onboarding 15.38%
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `10860902855`, `11879711185`, `11510979900`, `8685490868`, `11187701142`, `11379147577`, `11710806302`, `11805553961`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C027 Localise early — it unlocks revenue; C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R57-088 — Other sub-50 storefronts (verbatim): Canada 12 — 3 of 27 can't-find-delete and the most detailed unbundling proposal; Great Britain 10 — mean 4.300; Mexico 7 — data loss and the Family Sharing mis-sell; Germany 6 — praises the timeline/print feature as unique; China 5 — 3 of 5 ask for a lower buyout price, 1 incomplete Simplified Chinese; Russia 3 — the 1,941-character proposal (skipped-vs-failed day distinction, streak grouping); Singapore / Pakistan / Hong Kong — 3 of the 10 model-change complaints; Poland 3 — the only request for a subscription instead of lifetime; Austria / Czechia — the earliest non-Korean ad-gate uninstalls; India 3 — mean 5.000, all praising free-tier generosity in 2020–21 before the cap tightened

- **Where:** §6.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Storefront | n | Observation | IDs ; Canada | 12 | 3 of the corpus's 27 cant_find_delete_edit reviews — an unusually high share for 12 reviews; also the most detailed unbundling proposal | 8787931317, 9145622375, 9562235582, 7028234235 ; Great Britain | 10 | Mean 4.300, the highest of any storefront with n ≥ 10; one Korean-language review filed on the GB storefront | 11143057029 ; Mexico | 7 | Contains both a data-loss report and the Family-Sharing mis-sell | 10740823617, 10724795076 ; Germany | 6 | Mean 4.500; the only reviewer who praises the timeline/print feature as unique in the category | 12574741140 ; China | 5 | 3 of 5 ask for a lower buyout price; 1 reports incomplete Simplified Chinese | 5627754008, 6075694865, 10849290037, 11309205520 ; Russia | 3 | Supplies the corpus's longest and most structured feature proposal (1,941 characters) — skipped-vs-failed day distinction and streak grouping | 13574542005 ; Singapore / Pakistan / Hong Kong | 2 / 1 / 3 | Three of the ten monetization_model_change_complaint reviews come from these three tiny storefronts — the pattern is geographically wide even where counts are tiny | 13386826119, 12795320709, 14352377997 ; Poland | 3 | The only reviewer in the corpus who asks for a *subscription* instead of a lifetime price | 10639075443 ; Austria / Czechia | 1 / 2 | Both 1★ reviews are ad-gate uninstalls, the earliest non-Korean examples | 10767699701, 8077608265 ; India | 3 | Mean 5.000; all three praise the free tier's generosity in 2020–2021, before the cap tightened | 6115842538, 7063081300, 7925046804
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `8787931317`, `9145622375`, `9562235582`, `7028234235`, `11143057029`, `10740823617`, `10724795076`, `12574741140`, `5627754008`, `6075694865`, `10849290037`, `11309205520`, `13574542005`, `13386826119`, `12795320709`, `14352377997`, `10639075443`, `10767699701`, `8077608265`, `6115842538`, `7063081300`, `7925046804`
- **Canonical:** — (nuance register)

### R57-089 — High-spend group (external spend rankings: US, JP, GB, DE, FR, CA, AU, KR, CN) (verbatim): incl. KR 733 (94.10%, 4.158) — indistinguishable from the corpus; excluding KR 128 (16.43%, 3.844) — simplicity 18.8%, payers 13.3%, ads 9.4%, price 8.6%, uninstall 7.8%; rest of world 82 (3.927) — the group is useless unless Korea is removed; with Korea removed: more praise for simplicity, the same payer share and roughly triple the ads and price friction — 'the markets with the most money to spend are the markets where the free-tier experience is doing the most damage' — the strongest commercial argument for moving the interstitial

- **Where:** §6.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Group | n | % of 779 | Mean ★ | Notes ; High-spend group (incl. KR) | 733 | 94.10% | 4.158 | Indistinguishable from the corpus — because Korea is 83% of the group ; High-spend group excluding KR | 128 | 16.43% | 3.844 | simplicity_minimal 18.8% · paid_premium_confirmed 13.3% · ads_complaint 9.4% · price_too_high 8.6% · churn_uninstalled 7.8% ; Rest of world (not KR/US/JP) | 82 | 10.53% | 3.927 | simplicity_minimal 18.3% · ease_of_use 15.9% · aesthetic_design 14.6% · intent_to_purchase 7.3%
- **Direction for us:** dont · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

### R57-090 — High-review-volume group (≥25 reviews: KR, US, JP = 697, 89.47%) (verbatim): mean 4.225 / 3.727 / 3.692; payers 12.89% / 16.67% / 15.38%; ads 2.48% / 15.15% / 0.00%; price 0.99% / 1.52% / 26.92%; free cap 1.65% / 6.06% / 11.54%; uninstall 2.15% / 15.15% / 0.00%; questions 8.10% / 0.00% / 3.85%; comparative best 7.93% / 18.18% / 0.00%; cross-device 12.23% / 7.58% / 0.00% — three market problems, one product: Korea the tenured base worn down by regressions and nowhere to ask (quiet attrition); the US losing top-of-funnel to a 30-second ad; Japan a market that would convert at a lower tier converting at zero

- **Where:** §6.7 table (verbatim) and reading
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | KR (605) | US (66) | JP (26) ⚠️ ; Mean ★ | 4.225 | 3.727 | 3.692 ; Payer share | 12.89% | 16.67% | 15.38% ; Ads complaint | 2.48% | 15.15% | 0.00% ; Price too high | 0.99% | 1.52% | 26.92% ; Free-tier cap | 1.65% | 6.06% | 11.54% ; Stated uninstall | 2.15% | 15.15% | 0.00% ; Question to developer | 8.10% | 0.00% | 3.85% ; Comparative best | 7.93% | 18.18% | 0.00% ; Cross-device request (incl. Android/Mac) | 12.23% | 7.58% | 0.00%
- **Direction for us:** research · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R57-091 — Global comparison: uniform across storefronts ≥5 — praise for simplicity, ease and design; widget trouble; the wish for sync; not uniform (verbatim): question_to_developer KR 8.10% vs non-KR 0.57% (14.2×); price_too_high 0.99% vs 8.05% (0.12×); ads 2.48% vs 9.20% (0.27×); free cap 1.65% vs 5.75% (0.29×); uninstall 2.15% vs 6.90% (0.31×); update_regression 8.76% vs 3.45% (2.5×); simplicity 10.74% vs 17.24%; comparative best 7.93% vs 12.07% — 'outside Korea, people complain about what the app costs them; inside Korea, people complain about what the app broke'; a roadmap built on global numbers would optimise for the Korean failure mode and leave the international one untouched

- **Where:** §6.8 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | KR (605) | Non-KR (174) | Ratio ; question_to_developer | 8.10% | 0.57% | 14.2× ; price_too_high | 0.99% | 8.05% | 0.12× ; ads_complaint | 2.48% | 9.20% | 0.27× ; free_tier_cap | 1.65% | 5.75% | 0.29× ; churn_uninstalled | 2.15% | 6.90% | 0.31× ; update_regression | 8.76% | 3.45% | 2.5× ; simplicity_minimal | 10.74% | 17.24% | 0.62× ; comparative_best | 7.93% | 12.07% | 0.66×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

## Dated events and trends

### R57-004 — The product changed underneath the 7.4-year span (widgets absent in 2019, Watch 2020, ads ~2019–20 hardening into a habit-creation gate by 2021, free cap tightened from 2023, subscription in 2025–26) — no global percentage means 'what the app is like now'; the rating decline is real, monotonic and recent (verbatim year table): 2019 68 at 4.368; 2020 179 at 4.285; 2021 139 at 4.288; 2022 92 at 4.380 (peak); 2023 88 at 4.034; 2024 104 at 3.971; 2025 72 at 3.708; 2026 to 27 Aug 37 at 3.297 — a 1.07-star fall from 2022, sample shrinking alongside; 639 distinct review days; volume peaks 2020 then declines — 'a shrinking, angrier review stream is the corpus's overall trajectory'

- **Where:** §Ten warnings 3–4; §1.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Year | n | % of corpus | Mean ★ | 5★ | 4★ | 3★ | 2★ | 1★ ; 2019 (from 30 Mar) | 68 | 8.73% | 4.368 | 43 | 15 | 6 | 0 | 4 ; 2020 | 179 | 22.98% | 4.285 | 99 | 51 | 17 | 5 | 7 ; 2021 | 139 | 17.84% | 4.288 | 90 | 22 | 13 | 5 | 9 ; 2022 | 92 | 11.81% | 4.380 | 62 | 16 | 6 | 3 | 5 ; 2023 | 88 | 11.30% | 4.034 | 48 | 19 | 8 | 2 | 11 ; 2024 | 104 | 13.35% | 3.971 | 56 | 20 | 12 | 1 | 15 ; 2025 | 72 | 9.24% | 3.708 | 38 | 7 | 5 | 12 | 10 ; 2026 (to 27 Aug) | 37 | 4.75% | 3.297 | 14 | 6 | 5 | 1 | 11
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `3948640864`, `3943711457`, `14476535510`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R57-005 — Two review bursts, both defect bursts, not solicitation: 21 of 22 bug_keyboard_memo reviews land 17–19 Sep 2020 (11 + 9 + 1) — the note keyboard stopped appearing after an update, ratings 10×5★, 7×4★, 2×3★, 3×2★ ('the users were furious and still gave 5 stars'); 8 of 18 bug_app_crash reviews on 14–17 Jun 2020 (6 on 15 Jun) — the app would not launch after an update; plus the 24–28 Jul 2026 Premium-activation cluster (8 reviews in 5 days); max 12 reviews in a day (17 Sep 2020); no reviewer mentions being asked for a review, no rating-inflation pattern

- **Where:** §Ten warnings 5; §1.4 bursts
- **This app does:** update broke the note keyboard (Sep 2020); launch crash (Jun 2020)
- **User reaction:** 1★-burst
- **Magnitude:** 21 of 22 in 3 days; 8 of 18 in 3 days
- **Direction for us:** must-never-break · **Report confidence:** burst · **Generalisable:** generalisable
- **Canonical:** C175 Updates must not break function or wipe progress; C228 Text fields must handle IME composition — Hangul and CJK input

### R57-012 — A concentrated, externally corroborated Premium outage in July 2026 produced the worst week in the corpus: eight reviews 24–28 Jul 2026, six at 1★, all saying Premium was bought and does not work — 'why won't restore work?'; 'I subscribed but errors keep appearing and I can't configure the widget'; 'paid and the widget still won't configure… why did I even pay'; 'I was on Premium, it stopped working, I re-bought the annual Premium and it still doesn't work — refund please'; 'I paid for the premium and now it asks for subscription??! DO NOT BUY IT' (HK); 'still broken after updating to 3.1.1' — publicly reported release notes confirm a Premium-activation defect in 3.1.0 fixed in 3.1.1 ('Version 3.1.1 includes a fix for an issue related to applying Premium and restoring purchases') — 'one broken release, eight furious paying customers, in five days'

- **Where:** Executive summary 5; §5.5; §2.3
- **This app does:** 3.1.0 broke Premium activation and restore
- **User reaction:** 1★-burst
- **Magnitude:** 8 reviews in 5 days; 6 at 1★
- **Direction for us:** must-never-break · **Report confidence:** externally corroborated · **Generalisable:** generalisable
- **Review IDs:** `14340621141`, `14340812621`, `14346556200`, `14350226011`, `14351907761`, `14351975658`, `14352377997`, `14358584372`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C175 Updates must not break function or wipe progress; C186 Never revoke what earlier buyers paid for when the model changes

### R57-017 — The monetisation model changed at least three times and every change is visible as anger: 10 (1.28%, meaningful, mean 1.700 — the lowest mean of any theme with n ≥ 5) complain the terms changed under them; price points in date order ₩9,900 (Dec 2020) → ¥1,600 (May 2022) → $13 (Oct 2022) → $35 (Nov 2023, UA) → ₩29,000 (Jan 2024) → ¥4,500 (Jan 2024, noting the rise from ¥1,600) → $30 (Mar 2025); term changes — 'At first unlimited habits were free but now only three are for free?' (PK); 'Changed the data retention policy to 30 days for the free version' (US, 1★); 'did daily check-in suddenly become a paid feature? There was no announcement' (JP, 2★); 'Have been using this app for years and suddenly it's no longer possible to increase the interval for a daily goal (e. 3x a day)' (SG, 2★); 'I paid for the premium and now it asks for subscription??!' (HK, 1★) — each tightening applied silently to existing users; no example of an announced change

- **Where:** Executive summary 10
- **This app does:** silent re-scoping of free and paid tiers
- **User reaction:** 1★-burst
- **Magnitude:** 10 (1.28%, 1.700)
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `6810145127`, `8685490868`, `9239739610`, `10562732428`, `10807761181`, `10860902855`, `12446921299`, `12795320709`, `13592161917`, `13169190954`, `13386826119`, `14352377997`
- **Canonical:** C001 Never move a free feature behind the paywall; C104 Never ship a paywall or feature-removal change silently; C186 Never revoke what earlier buyers paid for when the model changes

### R57-031 — Observed price points in date order (verbatim): Aug 2019 KR ₩3,994 charged after a redeem code; Dec 2020 KR ₩9,900 lifetime; Oct 2021 KR 'I'd have paid ₩30,000' (willingness); May 2022 JP ¥1,600 (would pay ¥300); Oct 2022 US $13; Nov 2023 UA $35; Jan 2024 KR ₩29,000; Jan 2024 KR 'nearly ₩30,000', would pay under ₩20,000; Jan 2024 JP ¥4,500 (was ¥1,600); Feb 2024 KR listed ₩29,000 but card charged ₩44,000; Jul 2024 JP ¥4,500, proposes a ¥2,000 tier; Mar 2025 US $30 — consistent with ~3× lifetime price increase between 2020–22 and 2024, then a shift to subscription in 2025–26

- **Where:** §2.2 price table (verbatim)
- **This app does:** lifetime price roughly tripled
- **User reaction:** complaint
- **Magnitude:** Date | Storefront | Price quoted | Review ; 2019-08-19 | KR | ₩3,994 (charged after a redeem code) | 4640684119 ; 2020-12-30 | KR | ₩9,900 lifetime | 6810145127 ; 2021-10-28 | KR | *"3만원 주고라도 구입했을 정도"* / "I'd have paid ₩30,000" — willingness, not price | 7961745633 ; 2022-05-19 | JP | ¥1,600 (would pay ¥300) | 8685490868 ; 2022-10-31 | US | $13 | 9239739610 ; 2023-11-08 | UA | $35 | 10562732428 ; 2024-01-11 | KR | ₩29,000 | 10807761181 ; 2024-01-22 | KR | *"거의 3만원"* / "nearly ₩30,000"; would pay under ₩20,000 | 10850332771 ; 2024-01-25 | JP | ¥4,500 (notes it was ¥1,600) | 10860902855 ; 2024-02-20 | KR | listed ₩29,000, card charged ₩44,000 | 10959845967 ; 2024-07-19 | JP | ¥4,500; proposes a ¥2,000 tier | 11510979900 ; 2025-03-21 | US | $30 | 12446921299
- **Direction for us:** research · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `4640684119`, `6810145127`, `7961745633`, `8685490868`, `9239739610`, `10562732428`, `10807761181`, `10850332771`, `10860902855`, `10959845967`, `11510979900`, `12446921299`, `11879711185`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R57-046 — past_date_checkin_difficulty is a solved problem: all but two of 13 from 2019–20 ('So if you forget to track something you're just out of luck'); by 2020–22 past_date_checkin_praise appears (4, mean 5.000) — 'Compared to other apps, it's ridiculously easy to add data for previous dates'; 'I love that I can come back to previous day if I forget to tick something' — the one confirmed example of a top complaint fixed and turned into a differentiator

- **Where:** §3.3.5 past-date solved
- **This app does:** back-dating fixed ~2020
- **User reaction:** praise
- **Magnitude:** 13 difficulty (2019–20) → 4 praise (5.000)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `4901780444`, `6522788831`, `9179962294`
- **Canonical:** C010 Backfill missed days / edit start date

### R57-066 — 2★ (n=29) is where long-tenure users land when the terms change (verbatim): ads 5 (17.2%), widget not showing / watch / ads gate 4 each; update regression, model change, multiple check-ins, keyboard, sync, long tenure, uninstalled 3 each — long_tenure_user 10.3% vs 2.95% globally and model change 10.3% vs 1.28% (8×); the three 'it used to work this way' reviews: a years-long SG user whose daily-goal interval was removed, JP daily check-in became paid, and a KR user since launch whose 2× check-ins were collapsed to 1× and whose support reply denied it was possible — 'the price of silent tier changes, paid by the app's oldest users'

- **Where:** §4.4 table (verbatim)
- **This app does:** silent tier changes
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of the 29 ; ads_complaint | 5 | 17.2% ; bug_widget_not_showing / bug_watch_loading / ads_gate_habit_creation | 4 each | 13.8% ; update_regression / monetization_model_change_complaint / req_multiple_checkins_day / bug_keyboard_memo / req_icloud_sync / long_tenure_user / churn_uninstalled | 3 each | 10.3%
- **Direction for us:** product-rule · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `13386826119`, `13169190954`, `12570234049`
- **Canonical:** C001 Never move a free feature behind the paywall; C196 A subscription is a promise of continued delivery — back it with a visible cadence

### R57-077 — July 2026 Premium outage (verbatim table): 8 reviews 24–28 Jul 2026, six 1★, = 21.6% of everything written in 2026 (37); matches the 3.1.0 / 3.1.1 release notes on mechanism, symptom and version; consequences: 1 the last reviewer says 3.1.1 did not fix it for them (second defect or entitlement cache); 2 a lifetime buyer now asked to subscribe — a separable model-migration problem that produced 'DO NOT BUY IT' on a public storefront; 3 nobody in the cluster received a visible response, and the two 4★ asked for fast action

- **Where:** §5.5 table (verbatim) and consequences
- **This app does:** 3.1.0 activation defect; lifetime buyer asked to subscribe
- **User reaction:** 1★-burst
- **Magnitude:** Date | ID | Store | ★ | What it says ; 2026-07-24 | 14340621141 | KR | 1 | *"복구하기가 왜 되지 않나요?"* / "why won't restore work?" ; 2026-07-24 | 14340812621 | KR | 4 | *"프리미엄 구독 중인데 위젯에 표기가 안됩니다..계속 에러가 뜨는데"* / "I'm on Premium but the widget won't display — errors keep coming" ; 2026-07-25 | 14346556200 | KR | 4 | *"구독햇는데 자꾸 오류가 떠서 위젯설정이 안되네여"* / "I subscribed but errors keep stopping widget setup" ; 2026-07-26 | 14350226011 | KR | 1 | *"프리미엄 구독했는데 … 왜오류나냐고 뭐임"* / "I subscribed to Premium … why is it erroring, what is this" ; 2026-07-26 | 14351907761 | KR | 1 | *"유료구매했는데 위젯설정안됨 … 이럴거면 유료구매왜함"* ; 2026-07-26 | 14351975658 | KR | 1 | Re-bought Premium annual, still broken, asks for a refund ; 2026-07-27 | 14352377997 | HK | 1 | *"I paid for the premium and now it asks for subscription??! DO NOT BUY IT"* ; 2026-07-28 | 14358584372 | KR | 1 | *"3.1.1로 업뎃했는데도 안돼요 빨리 해결좀요"* / "still broken even after updating to 3.1.1, please fix fast"
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14340621141`, `14340812621`, `14346556200`, `14350226011`, `14351907761`, `14351975658`, `14352377997`, `14358584372`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C175 Updates must not break function or wipe progress; C186 Never revoke what earlier buyers paid for when the model changes

### R57-092 — Trend method: calendar years and three eras E1 Mar 2019 – Dec 2021 (386), E2 2022–23 (180), E3 Jan 2024 – Aug 2026 (213), era means 4.301 / 4.211 / 3.765; no version field; 2020 bursts inflate reliability; 2026 one review = 2.7 points; Trend 1 — the rating decline is real, recent and monotonic (verbatim year table): flat-to-rising for four years then four consecutive falls totalling 1.08 stars from the 2022 peak; 1★ share 5.9% (2019) → 29.7% (2026); 5★ share 63.2% → 37.8%; not driven by volume decay (2024 had more reviews than 2023 and a lower mean)

- **Where:** §7.1; §7.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Year | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 | 2026 ; Mean ★ | 4.368 | 4.285 | 4.288 | 4.380 | 4.034 | 3.971 | 3.708 | 3.297 ; n | 68 | 179 | 139 | 92 | 88 | 104 | 72 | 37
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R57-093 — Trend 2 — monetisation friction more than quadrupled (verbatim): any friction E1 20 (5.18%) → E2 19 (10.56%) → E3 50 (23.47%); free_tier_cap 3 → 1 → 16 (7.51%); price_too_high 2 → 6 → 12 (5.63%); post_purchase_failure 2 → 6 → 14 (6.57%); restore failure 0 → 0 → 8 (3.76%); model-change complaint 1 → 1 → 8 (3.76%); paid-user trouble 5 (1.30%) → 9 (5.00%) → 22 (10.33%) — nearly a quarter of every review since January 2024 contains a monetisation complaint, against one in twenty before 2022; the clearest available explanation for the rating decline (timing, direction and 1★ concentration align; not proof)

- **Where:** §7.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Family | E1 (386) | E2 (180) | E3 (213) ; Monetization friction (any) | 20 (5.18%) | 19 (10.56%) | 50 (23.47%) ; free_tier_cap | 3 (0.78%) | 1 (0.56%) | 16 (7.51%) ; price_too_high | 2 (0.52%) | 6 (3.33%) | 12 (5.63%) ; post_purchase_failure | 2 (0.52%) | 6 (3.33%) | 14 (6.57%) ; restore_purchase_failure | 0 | 0 | 8 (3.76%) ; monetization_model_change_complaint | 1 (0.26%) | 1 (0.56%) | 8 (3.76%) ; Paid-user trouble (union) | 5 (1.30%) | 9 (5.00%) | 22 (10.33%)
- **Direction for us:** product-rule · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set

### R57-094 — Trend 3 — the ad gate hardened and then started failing (verbatim): ads_complaint 10 → 11 → 10; creation gate 5 (1.30%) → 8 (4.44%) → 13 (6.10%); ads_broken 1 → 0 → 7 (3.29%); any ads 11 (2.85%) → 14 (7.78%) → 22 (10.33%); phases — 2019–2020 mostly banner, a Jan 2021 reviewer still praises 'no ads and it's great' (dating the interstitial); 2021–2023 the creation gate appears and lengthens from 5 seconds to 30 seconds (from Sep 2023); 2024–2026 the gate starts failing, the latest on 24 Aug 2026

- **Where:** §7.4 table (verbatim)
- **This app does:** banner → 5s interstitial → 30s → failing
- **User reaction:** churn
- **Magnitude:** Theme | E1 (386) | E2 (180) | E3 (213) ; ads_complaint | 10 (2.59%) | 11 (6.11%) | 10 (4.69%) ; ads_gate_habit_creation | 5 (1.30%) | 8 (4.44%) | 13 (6.10%) ; ads_broken | 1 (0.26%) | 0 | 7 (3.29%) ; Ads (any) | 11 (2.85%) | 14 (7.78%) | 22 (10.33%)
- **Direction for us:** dont · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `6934202676`, `7877990468`, `8110196858`, `10353308106`, `10614381628`, `14465530297`
- **Canonical:** C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

### R57-095 — Trend 4 — widget defects became the dominant reliability problem (verbatim): any defect 116 (30.05%) → 41 (22.78%) → 72 (33.80%); widget defects 33 (8.55%) → 18 (10.00%) → 39 (18.31%); widget not showing 15 → 12 → 23 (10.80%); group deleted 0 → 0 → 9; app crash 13 → 0 → 5; Watch loading 19 (4.92%) → 5 → 2 (0.94%); keyboard memo 22 → 0 → 0; data loss 3 → 1 → 8 (3.76%) — total defect rate roughly flat but its composition inverted: E1's app problems (crashes, keyboard, Watch) were fixed; E3's are the widget and data loss — 'this team demonstrably can fix hard defects… The widget is the one that has not been fixed'

- **Where:** §7.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Family | E1 (386) | E2 (180) | E3 (213) ; Any reliability defect | 116 (30.05%) | 41 (22.78%) | 72 (33.80%) ; Widget defects only | 33 (8.55%) | 18 (10.00%) | 39 (18.31%) ; bug_widget_not_showing | 15 (3.89%) | 12 (6.67%) | 23 (10.80%) ; bug_widget_group_deleted | 0 | 0 | 9 (4.23%) ; bug_app_crash | 13 (3.37%) | 0 | 5 (2.35%) ; bug_watch_loading | 19 (4.92%) | 5 (2.78%) | 2 (0.94%) ; bug_keyboard_memo | 22 (5.70%) | 0 | 0 ; bug_data_loss | 3 (0.78%) | 1 (0.56%) | 8 (3.76%)
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C040 Widgets must not go blank, stale or disagree with the app

### R57-096 — Trend 5 — advocacy and displacement collapsed (verbatim): comparative_best 40 (10.36%) → 20 (11.11%) → 9 (4.23%); outcome 28 (7.25%) → 10 (5.56%) → 5 (2.35%); simplicity 57 (14.77%) → 22 (12.22%) → 16 (7.51%); UX praise 109 (28.24%) → 48 (26.67%) → 41 (19.25%); named-feature praise 69 → 36 → 30 (14.08%) — 'the best habit app I've tried' more than halved and 'this changed my behaviour' fell by two-thirds — the two themes most tied to word of mouth — while the paid share rose; ease and design flat: users still find it easy and attractive but stopped calling it the best

- **Where:** §7.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Theme | E1 (386) | E2 (180) | E3 (213) ; comparative_best | 40 (10.36%) | 20 (11.11%) | 9 (4.23%) ; outcome_behavior_change | 28 (7.25%) | 10 (5.56%) | 5 (2.35%) ; simplicity_minimal | 57 (14.77%) | 22 (12.22%) | 16 (7.51%) ; UX praise (any) | 109 (28.24%) | 48 (26.67%) | 41 (19.25%) ; Named-feature praise (any) | 69 (17.88%) | 36 (20.00%) | 30 (14.08%)
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C005 Know which competitors buyers compare against

### R57-097 — Trend 6 — things genuinely fixed (verbatim): streaks shipped Jan–Feb 2020 ('the streak feature arrived! I love you, developer'); Dropbox backup ~Jan 2020; Apple Watch app ~Mar 2020 ('moved to see it on the Watch'); the custom widget restored after users complained (a reviewer edited their review); widget_tap_opens_app disappears after Dec 2023; past-date check-in went from top complaint to differentiator; keyboard and reminder-time bugs stop dead after Sep 2020; accidental purchases stop after Jan 2023; skip / rest day shipped mid-2024; iCloud sync worked for at least one user Sep 2024; a widget fix landed and a payer noticed Nov 2024 ('Recent update is a godsend. They fixed an issue with the widgets and this app is back to being one of my top 3 apps') — seven of the ten largest early complaints were addressed; since 2024 what shipped was monetisation tightening while widget, sync and data integrity did not move

- **Where:** §7.7 table (verbatim)
- **This app does:** responsive fixes 2020–2024
- **User reaction:** praise
- **Magnitude:** What changed | Evidence ; Streaks shipped, Jan–Feb 2020 | Requested 5360484203 (4 Jan 2020) → shipped and thanked 5516233972 (11 Feb 2020: *"streak 기능 생겼네요ㅜㅠ 개발자 님 사랑합니다"* / "the streak feature arrived! I love you, developer") ; Dropbox backup shipped, ~Jan 2020 | 5353897655: *"<6개월 사용> 백업기능이 생겨서 너무 좋습니다"* / "(6 months in) so glad backup arrived" ; Apple Watch app shipped, ~Mar 2020 | Requested 4858004385, 5216546907, 5591618893 → shipped and thanked 5621508960 (*"워치에 있는거 보고 감동"* / "moved to see it on the Watch") ; The custom widget was restored after users complained | 7224428696 edits their own review: *"(수정) 사용자화 다시 생겨서 너무 좋아욤!!! 감사합니당"* / "(edit) the custom widget is back, I love it, thank you" ; widget_tap_opens_app disappears after Dec 2023 | 8 reviews in E1, 8 in E2, 0 in E3 ; Past-date check-in went from top complaint to differentiator | past_date_checkin_difficulty 11 of 13 in 2019–2020 → past_date_checkin_praise 4 reviews, mean ★ 5.000, 2020–2022 (§3.3.5) ; bug_keyboard_memo and bug_reminder_time stop dead after Sept 2020 | 22 and 4 reviews, all within weeks; zero afterwards ; accidental_purchase stops after Jan 2023 | 6 reviews, all 2019–2023 — consistent with a purchase-sheet fix ; Skip/rest-day shipped, mid-2024 | 11410069153 (22 Jun 2024): *"I'm really pleased that I can use this feature, which I've been eagerly waiting for"* ; iCloud sync worked for at least one user, Sept 2024 | 11710806302 (JP) ; A widget fix landed and a payer noticed, Nov 2024 | 11929068665 (US, 5★): *"Recent update is a godsend. They fixed an issue with the widgets 🫶 and this app is back to being one of my top 3 apps"*
- **Direction for us:** do · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `5360484203`, `5516233972`, `5353897655`, `4858004385`, `5216546907`, `5591618893`, `5621508960`, `7224428696`, `11410069153`, `11710806302`, `11929068665`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R57-098 — Trend 7 — cross-device demand never moved (verbatim): union 29 (7.51%) → 28 (15.56%) → 27 (12.68%); req_icloud_sync 13 → 18 → 13 — 'twenty-nine, twenty-eight, twenty-seven'; first request May 2019 ('I wish backup/restore worked for linking iPad and iPhone'), last Apr 2026 from a Premium user ('I bought Premium and iPad doesn't seem to sync'); the only demand where a reviewer accuses the team of stalling

- **Where:** §7.8 table (verbatim)
- **This app does:** sync unresolved 7 years
- **User reaction:** complaint
- **Magnitude:** | E1 (386) | E2 (180) | E3 (213) ; Cross-device / platform gap (union) | 29 (7.51%) | 28 (15.56%) | 27 (12.68%) ; req_icloud_sync | 13 (3.37%) | 18 (10.00%) | 13 (6.10%)
- **Direction for us:** must-have · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `4135463077`, `13912612870`, `11361971544`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C071 Never ship and walk away

### R57-099 — Trend 8 — payers became a much larger share of reviewers (medium confidence): 31 of 386 (8.03%) → 22 of 180 (12.22%) → 46 of 213 (21.60%); 2026 12 of 37 (32.43%) — benign reading: the paywall works; adverse: the reason payers write shifted (12.9% of E1 payers reported a purchase failure, 45.7% of E3); in 2026 8 of 12 payers report a post-purchase failure — the rising payer share may be measuring anger, not adoption

- **Where:** §7.9
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 8.03% → 12.22% → 21.60%; 2026 8 of 12 failures
- **Direction for us:** must-never-break · **Report confidence:** medium confidence · **Generalisable:** generalisable
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

## Positioning

### R57-001 — Habit Tracker - DayStamp (App Store ID 1456241316; subtitle 'Daily Routine, Streak & Widget') by 동현 hwang, listed as 'hbull' (bundle com.hbull.daystamp) — a Korean app: 779 written reviews, 29 storefronts, 30 Mar 2019 → 27 Aug 2026 (7 years 5 months), mean 4.134, extracted 8 Sep 2026, analysed 12 Sep 2026; business model (review-derived): free download, ad-supported with an interstitial ad gate on habit creation, a free-tier habit cap, and a paid Premium first sold as a one-time lifetime purchase (₩9,900 → ₩29,000; ¥1,600 → ¥4,500; $13 → $30–35) and from late 2025 as a subscription; the stamp (도장) check-in is the core metaphor

- **Where:** header lines 1-8
- **This app does:** ad-supported free tier with habit cap; Premium lifetime → subscription
- **User reaction:** mixed
- **Magnitude:** 779 reviews; mean 4.134
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R57-015 — Displacement evidence is strong but decaying: 69 (8.86%, high-priority, mean 4.884) chose this app after trying the category — 'I'm a habit-tracker nomad, tried over ten and settled here' (KR); 'I've tried 10 habit tracking apps at this point, including most of the ones with 1k reviews. I think this one actually wins in for the insightful data' (US); 'after personally using and comparing countless goal apps, this one is the best' (KR); 'I've tried every habit app there is and keep coming back because this is the cleanest' (KR) — 10.36% of E1 reviews, 11.11% of E2, only 4.23% of E3 (2024–26)

- **Where:** Executive summary 8; §3.5.2
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 69 (8.86%, 4.884); E1 10.36% → E2 11.11% → E3 4.23%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `9520902510`, `6522788831`, `7119448731`, `6851822317`
- **Canonical:** C005 Know which competitors buyers compare against

### R57-058 — Displacement self-description 'nomad' (유목민) and 'settled' (정착) ('after two hours of installing and deleting apps I finally settled here — the best among habit apps that give unrestricted statistics'); competitor_feature_gap 5 (0.64%, 5.000) — five-star reviewers naming what a rival has: Apple Health ('habit apps like Streak and Habit Miner support it'); a per-habit motivation note (donhabit); incomplete-day marking ('add incomplete-day marking to the calendar and I'll pay immediately'); general journaling 'to compete with the other apps' (US); time tracking (runs a second app for it)

- **Where:** §3.5.2 competitor_feature_gap
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** competitor_feature_gap 5 (5.000)
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `10489526756`, `10509051172`, `8772322659`, `7176051984`, `4949407944`, `8157214041`, `10969192626`, `13538382083`, `6683329124`
- **Canonical:** C005 Know which competitors buyers compare against; C021 Apple Health integration

### R57-083 — Competitive position per payers: nine payers (9.09%) also carry comparative_best — payment follows a completed search ('I tried several apps, chose this one and bought it'; 'the best habit app I've ever used'; 'downloaded it, looked around, and bought the permanent version right away'); one Premium payer considering leaving: 'the UX/UI is so excellent that I paid for Premium. Having paid, I want to use it for a long time. But these three things are my only discomfort… because of them I'm considering switching' — all three asks are widget layouts

- **Where:** §5.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 9 of 99
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** generalisable
- **Review IDs:** `10489526756`, `9062339832`, `9541183862`, `11277951619`
- **Canonical:** C005 Know which competitors buyers compare against; C040 Widgets must not go blank, stale or disagree with the app

## Anti-patterns

### R57-008 — The interstitial ad on habit creation is the single most destructive mechanic and converts curiosity into deletion: 47 of 779 (6.03%, high-priority) complain about ads — 31 generally (3.98%), 26 specifically that creating a habit requires watching an ad (3.34%), 8 that the ad gate itself is broken (1.03%); ads family mean 2.234, the lowest large family; 20 of the 25 reviewers who state they deleted the app (80%) name ads — 'an ad every time I add a task lol… so annoying I'm deleting it' (KR, 1★); 'A full screen ad after just creating one habit? Wow, immediately uninstalled' (CZ, 1★); 'The developer is losing a lot of app sales because the full screen ads are so horrible that you will stop using the app before finding out if you like the functionality' (US, 1★); 'Ad vomit… Want to create a group? First watch an ad. Want to add an item to your group? Another ad' (US, 1★) — the gate is placed at the moment of highest intent (setup) and is the only mechanic that reliably produces a 1★ and an uninstall in one review

- **Where:** Executive summary 1; §3.3.1
- **This app does:** interstitial ad required to create a habit
- **User reaction:** churn
- **Magnitude:** ads 47 (6.03%, 2.234); gate 26 (3.34%); 20 of 25 deletions
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `8509076402`, `8077608265`, `12306162617`, `9783504520`
- **Canonical:** C147 Let people use the product before they pay; C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

### R57-021 — An AI habit-suggestion feature shipped in 2025 and the only two reviewers who mention it say they cannot find it; zero report using it successfully

- **Where:** §2.1 AI suggestion row
- **This app does:** shipped AI suggestion, undiscoverable
- **User reaction:** complaint
- **Magnitude:** 2 mentions, 0 successful uses
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `12978533903`, `13130410310`
- **Canonical:** C056 Don't build AI features on demand grounds; C142 Surface existing features where users look

### R57-026 — Backup / restore paywalled — 'so you can't back up at all unless you buy — this is practically blackmail' (KR)

- **Where:** §2.2 backup paywalled
- **This app does:** paid: backup
- **User reaction:** complaint
- **Magnitude:** report gives none
- **Direction for us:** product-rule · **Report confidence:** report gives none · **Generalisable:** generalisable
- **Review IDs:** `11103760055`, `11222810326`, `10869361826`
- **Canonical:** C020 Data export / backup / CSV; C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R57-027 — Free-tier data retention cut to 30 days (~2026): 'Changed the data retention policy to 30 days for the free version' (US, 1★) — earlier (2020) a reviewer wanted to buy precisely 'because I want to keep the full record'

- **Where:** §2.2 data retention
- **This app does:** free history limited to 30 days
- **User reaction:** 1★-burst
- **Magnitude:** report gives none
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `13592161917`, `6181430289`
- **Canonical:** C001 Never move a free feature behind the paywall; C176 Never let fear of losing history be the reason people pay

### R57-028 — Multiple check-ins per day became Premium-gated, with previously-free items retroactively capped to one — 'did daily check-in suddenly become a paid feature? There was no announcement' (JP); 'suddenly it's no longer possible to increase the interval for a daily goal (e. 3x a day)' (SG)

- **Where:** §2.2 multiple check-ins gated
- **This app does:** free → paid: multiple daily check-ins
- **User reaction:** 1★-burst
- **Magnitude:** report gives none
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `13169190954`, `13386826119`, `12570234049`
- **Canonical:** C001 Never move a free feature behind the paywall; C143 Intra-day completion: tap N times to fill N/N

### R57-053 — Multiple check-ins per day — the same request answered, then partially withdrawn, over seven years: asked from Apr 2019 ('could you add stamping three or four times a day, like for medication?') to May 2026; shipped as 'goal' / daily check-in ('the advantage that items needing three checks a day can be set via goal'), then capped at 5 ('Why is 5 times per day the maximum? I need 10', JP), then restricted by tier — producing the three angriest change complaints in the corpus (JP, SG, KR)

- **Where:** §3.4 special 1
- **This app does:** shipped, capped at 5, then tier-gated
- **User reaction:** 1★-burst
- **Magnitude:** 24 requests; 3 change complaints
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `4054464741`, `14031614226`, `12095285181`, `11315669095`, `13169190954`, `13386826119`, `12570234049`
- **Canonical:** C001 Never move a free feature behind the paywall; C143 Intra-day completion: tap N times to fill N/N

## Things not to do

### R57-049 — Told 'planned', never shipped: 6 reviewers (0.77%) say the developer promised iPad / Mac and it never arrived — 'people have been asking about iPad and Mac for years and you always say it's planned — is it ever actually happening?'

- **Where:** §3.3.6 roadmap promise
- **This app does:** roadmap promises unmet
- **User reaction:** complaint
- **Magnitude:** 6 (0.77%, 4.000)
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `11361971544`, `11505457261`, `11832774003`, `12389229520`, `13540816428`, `13840622066`
- **Canonical:** C071 Never ship and walk away

### R57-082 — Mis-taps that become refunds — 6 accidental_purchase (0.77%), all Korean, 2019–2023: 'I tapped to see what Premium was, pressed OK to close the sheet, and it bought it'; 'I pressed in-app purchase ad removal without knowing, please refund' — a purchase sheet that can be confirmed by a dismissal gesture generated six refund requests and at least two one-stars; all predate 2024, consistent with a fix

- **Where:** §5.6 (f)
- **This app does:** OK-to-close confirmed a purchase
- **User reaction:** 1★-burst
- **Magnitude:** 6 (0.77%)
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `6288381604`, `3982059993`
- **Canonical:** C274 A close or dismiss control must never start a purchase — no fake X, no dismissal that lands on the payment sheet

### R57-106 — Structural 8: move the interstitial off habit creation — the highest-value change and the most revenue risk: 47 complain at 2.234, 26 name the creation gate, 20 of 25 uninstalls cite ads, US 15.15% vs KR 2.48%, and all six ad-tolerant reviewers describe short ads confined to creation (all 5★); reviewers distinguish banner ads (accepted) from a 30-second interstitial at setup (rejected), and an ad on creation (tolerable at 5s) from an ad on every memo ('a 29-second ad every time I write a memo'); options in order: shorten back to ~5 seconds; move it to a session boundary; or gate after the nth habit rather than the 3rd–4th (the trigger point several name)

- **Where:** §8.2 #8
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 47 (2.234); 26; 20 of 25
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `11543927654`, `10476012561`, `12474152923`, `13878772549`
- **Canonical:** C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

## Things to do

### R57-019 — The cheapest high-value moves in evidence order: fix the Premium-activation and restore path and publish what happened in July 2026 → move the interstitial off habit creation (47 reviews, 2.23, 80% of stated uninstalls) → stabilise the widget starting with 'widget will not appear' and the phantom 'group deleted' → ship or clearly document cross-device sync and an iPad build (72, flat for 7 years) → make delete/edit discoverable and add in-app help and a support link (50 + 27 + 23, nearly all Korean 5★, free to fix) → announce monetisation changes before they land and grandfather existing behaviour (mean 1.700) → unbundle Premium or offer a trial for price-resistant non-Korean markets → do not add features to the main surface

- **Where:** Executive summary 12
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** as listed
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C013 Cloud sync / multi-device as the paid differentiator; C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C040 Widgets must not go blank, stale or disagree with the app; C073 Manual reordering, renaming and editing of habits/tasks — free; C092 Regional pricing; C104 Never ship a paywall or feature-removal change silently; C275 Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation

### R57-105 — Fix 7: ship an in-app changelog before the next tier change — the model-change theme has the lowest mean (1.700) and the common thread is surprise, not price ('there wasn't even an announcement — what's going on?'); 2★ reviews are 8× over-indexed on it and come from the oldest users

- **Where:** §8.1 #7
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** mean 1.700; 8× in 2★
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13169190954`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently

## Contradictions

### R57-114 — The same team that fixed seven of ten early complaints (keyboard, crashes, Watch, past-date check-in, widget tap) has left the widget, sync and data-integrity problems unmoved since 2024 while shipping monetisation tightening — contradicting the assumption that a rating decline signals an unresponsive developer: the decline tracks what was prioritised, not capability

- **Where:** §3.3.4 display filter; §8.1 #4; §7.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 7 of 10 fixed; widget 8.55% → 18.31%
- **Direction for us:** research · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

## Data caveats and method

### R57-002 — Method: all 779 reviews read individually in original language (Korean 605, English, Japanese 26, Chinese 4, German 3, Spanish 4, Portuguese 3, French 1, Hungarian 1); 163 hand-curated themes keyed by ordinal position so no review ID was transcribed by hand; validated 0 unknown IDs, 0 intra-theme duplicates, 0 unassigned, 0 empty themes, 0 unused; themes per review min 1 · max 10 · mean 2.44; after classification twelve keyword sweeps (ads, purchase, widget, sync, price, refund, watch, iPad, Android, data loss, delete, crash) plus a praise sweep run as an audit against the hand map found 19 genuine boundary errors, corrected; reconciliation exact against 29 by_country files, manifest (5:450 / 4:156 / 3:72 / 2:29 / 1:72; mean 4.13350) and _state.json (69 queried, all complete, 29 with reviews, 40 zero — fr, nl, se, dk, no, fi, ch, tr, id, th, ae, eg, il, cl, co, ar — real absence of written-review footprint); zero duplicates; denominator 779 (one review 0.13%, the ignore band is unreachable); 29 themes with n=1 labelled weak; HTML entities unescaped; body median 71 characters (5★ 75 · 4★ 69 · 3★ 68 · 2★ 82 · 1★ 61), min 1, max 1,941; external release notes via search summaries only (low–medium confidence; App Store and lookup egress-blocked); error bars widest on simplicity vs ease of use, widget-not-showing vs not-updating, payer excluding accidental purchases, question-to-developer

- **Where:** §How to read this; §1.1–1.3, §1.5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 779 (100%)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `9409544493`, `13574542005`
- **Canonical:** — (nuance register)

### R57-003 — A Korean app with a Korean corpus: 605 of 779 (77.66%) from Korea, rest of world 174 (22.34%) — every global percentage is dominated by Korea and several themes invert across that line (ads 2.48% KR vs 9.20% non-KR; price 0.99% KR vs 8.05% non-KR); only Korea (605) and the US (66) clear 50; Japan (26) is limited evidence though analytically the most interesting small storefront; every other storefront ≤12

- **Where:** §Ten warnings 1–2; §1.6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** KR 605 (77.66%); US 66; JP 26
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R57-006 — Data limits: vote data almost empty (61 of 779 = 7.83% have any vote_count, max 3; 49 vote_sum) — cannot detect clusters; 6 is_edited (0.77%, all Korean), two more edited in text without the flag ('(edit) the custom widget is back, I love it'; '(edit) solved!'); no version field — only two reviewers name a version ('still broken after updating to 3.1.1'); 'paid' means the reviewer said so — 99 (12.71%) state they bought Premium, not a conversion rate

- **Where:** §Ten warnings 6–7, 9; §1.2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** votes 61 (max 3); edited 6; payers 99
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `7224428696`, `11680260937`, `12135641738`, `14358584372`, `5875043124`, `8451895584`
- **Canonical:** — (nuance register)

### R57-007 — Rating and text disagree often: 162 of 450 five-star reviews (36.00%) carry at least one negative-direction theme — in Korean reviewing convention a bug report is frequently filed at 5★; every one of the 72 one-star reviews carries a negative theme — star rating is never used as a sentiment proxy

- **Where:** §Ten warnings 10
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 162 of 450 5★ (36.00%) negative
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

### R57-033 — External sources (search-engine summaries of the listing; App Store and lookup egress-blocked; low–medium confidence, corroboration only) (verbatim): developer 'hbull', free to download — matches; 'In version 3.1.0 Premium may not be activated correctly; fixed in 3.1.1. Version 3.1.1 includes a fix for an issue related to applying Premium and restoring purchases' — directly corroborates the July 2026 cluster, the strongest external–internal match; the listing leads with 'Simple and Powerful Widget Features' — matches the widget being top praise (30) and top defect surface (129); the listing says some in-app purchases and subscriptions may be shareable with Family Sharing — corroborates the subscription and the MX complaint that Family Sharing did not work

- **Where:** §2.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** External statement | Corpus agreement ; Developer "hbull"; app is free to download | Matches manifest.json (com.hbull.daystamp) and the free-download evidence in §2.2 ; "In version 3.1.0 Premium may not be activated correctly; fixed in 3.1.1. Version 3.1.1 includes a fix for an issue related to applying Premium and restoring purchases." | Directly corroborates the July 2026 cluster (§5.5): 8 reviews in 5 days about Premium not applying and restore failing, one of which names version 3.1.1 (14358584372). This is the strongest external–internal match in the report. ; Listing describes "Simple and Powerful Widget Features … various widgets … from your iOS home screen" as a headline capability | Matches the corpus: the widget is both the top-praised named feature (30) and the top defect surface (129) ; Listing states "some in-app purchases and subscriptions may be shareable with your family group when Family Sharing is enabled" | Corroborates both the subscription's existence (§2.2) and the specific complaint in 10724795076 (MX) that Family Sharing did not work as advertised
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `14358584372`, `10724795076`
- **Canonical:** C037 Family plan; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R57-034 — Theme-family aggregates (verbatim): any request 267 (34.27%, 4.449); any reliability defect 229 (29.40%, 3.690); UX praise 198 (25.42%, 4.753); named-feature praise 135 (17.33%, 4.785); widget trouble 129 (16.56%, 3.992); widget defects only 90 (11.55%, 3.689); monetisation friction 89 (11.42%, 2.989); cross-device / platform gap 84 (10.78%, 4.405); usability friction 71 (9.11%, 3.859); ads 47 (6.03%, 2.234); purchase intent 36 (4.62%, 4.361); paid-user trouble 36 (4.62%, 2.528); churn stated or risked 27 (3.47%, 1.593); monetisation positive 25 (3.21%, 4.800); support failure 15 (1.93%, 2.333) — the three lowest-rated families (churn, ads, paid-user trouble) are all monetisation mechanics, not features

- **Where:** §3.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Family | n | % of 779 | Signal | Mean ★ | What it contains ; Any request / unmet need | 267 | 34.27% | high-priority | 4.449 | 57 req_* themes + widget-group selection ; Any reliability defect | 229 | 29.40% | high-priority | 3.690 | 23 defect themes incl. update_regression ; UX praise (any) | 198 | 25.42% | high-priority | 4.753 | simplicity ∪ ease ∪ design ∪ colour ∪ font ; Named-feature praise (any) | 135 | 17.33% | high-priority | 4.785 | the 16 feature-praise themes ; Widget trouble (defect or design) | 129 | 16.56% | high-priority | 3.992 | 4 widget defects + 4 widget design limits ; Widget defects only | 90 | 11.55% | high-priority | 3.689 | not-showing ∪ not-updating ∪ group-deleted ∪ layout ; Monetization friction (any) | 89 | 11.42% | high-priority | 2.989 | 19 themes: price, cap, paywall, refund, purchase failure ; Cross-device / platform gap | 84 | 10.78% | high-priority | 4.405 | iCloud ∪ iPad ∪ Mac ∪ Android ∪ backup ; Usability friction (any) | 71 | 9.11% | high-priority | 3.859 | delete/edit ∪ onboarding ∪ past-date ∪ check-in ∪ localization ∪ accessibility ∪ generic ; Ads (any) | 47 | 6.03% | high-priority | 2.234 | complaint ∪ creation-gate ∪ broken ; Purchase intent (any) | 36 | 4.62% | very strong | 4.361 | stated intent ∪ purchase question ; Paid-user trouble | 36 | 4.62% | very strong | 2.528 | post-purchase ∪ restore ∪ not-applied ∪ billing ∪ purchase-failure ∪ misleading claim ; Churn (stated or risked) | 27 | 3.47% | very strong | 1.593 | 25 stated deletions + 2 stated switching risk ; Monetization positive (any) | 25 | 3.21% | very strong | 4.800 | free praise ∪ lifetime praise ∪ price-fair ∪ no-ads ; Support failure (any) | 15 | 1.93% | meaningful | 2.333 | unresponsive ∪ channel unclear ∪ dismissive
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R57-035 — Master table — the 50 largest of 163 themes (verbatim)

- **Where:** §3.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** # | Theme | Family | Direction | Count | % of 779 | Signal | Mean ★ | First → last | Top storefronts ; 1 | paid_premium_confirmed | Monetization - payer | neutral | 99 | 12.71% | high-priority | 4.010 | 2019-09-05 -> 2026-07-28 | kr:78, us:11, jp:4, ca:2 ; 2 | simplicity_minimal | Praise - UX | positive | 95 | 12.20% | high-priority | 4.779 | 2019-03-30 -> 2026-05-13 | kr:65, us:13, ca:5, gb:2 ; 3 | ease_of_use | Praise - UX | positive | 81 | 10.40% | high-priority | 4.901 | 2019-04-02 -> 2026-07-27 | kr:60, us:6, ca:3, de:2 ; 4 | aesthetic_design | Praise - UX | positive | 69 | 8.86% | high-priority | 4.609 | 2019-03-31 -> 2026-08-14 | kr:47, us:7, jp:3, de:2 ; 5 | comparative_best | Displacement | positive | 69 | 8.86% | high-priority | 4.884 | 2019-07-09 -> 2026-08-14 | kr:48, us:12, gb:2, de:1 ; 6 | update_regression | Reliability - release | negative | 59 | 7.57% | high-priority | 3.729 | 2019-07-28 -> 2026-05-04 | kr:53, br:2, gb:1, my:1 ; 7 | bug_widget_not_showing | Reliability - widget | negative | 50 | 6.42% | high-priority | 3.440 | 2020-04-12 -> 2026-07-26 | kr:44, jp:2, gb:1, hu:1 ; 8 | question_to_developer | Meta | neutral | 50 | 6.42% | high-priority | 4.680 | 2019-04-02 -> 2026-05-03 | kr:49, jp:1 ; 9 | req_icloud_sync | Request | mixed (unmet need) | 44 | 5.65% | high-priority | 4.318 | 2019-05-11 -> 2026-04-02 | kr:37, us:3, gb:2, ca:1 ; 10 | outcome_behavior_change | Outcome | positive | 43 | 5.52% | high-priority | 4.930 | 2019-04-02 -> 2026-07-27 | kr:30, us:9, au:1, gb:1 ; 11 | feature_completeness_praise | Praise - feature | positive | 36 | 4.62% | very strong | 4.861 | 2019-03-30 -> 2026-05-23 | kr:20, us:10, gb:2, jp:2 ; 12 | ads_complaint | Ads | negative | 31 | 3.98% | very strong | 1.903 | 2019-10-16 -> 2026-06-29 | kr:15, us:10, ca:2, at:1 ; 13 | developer_appreciation | Relationship | positive | 30 | 3.85% | very strong | 4.933 | 2019-08-09 -> 2025-06-20 | kr:27, ca:1, sa:1, us:1 ; 14 | intent_to_purchase | Monetization - intent | positive | 30 | 3.85% | very strong | 4.300 | 2019-12-04 -> 2026-07-19 | kr:21, ca:2, jp:2, mx:2 ; 15 | widget_praise | Praise - feature | positive | 30 | 3.85% | very strong | 4.667 | 2019-09-28 -> 2026-05-12 | kr:19, us:3, jp:2, au:1 ; 16 | cant_find_delete_edit | Usability | negative | 27 | 3.47% | very strong | 3.630 | 2019-10-27 -> 2025-05-17 | kr:23, ca:3, us:1 ; 17 | ads_gate_habit_creation | Ads | negative | 26 | 3.34% | very strong | 2.154 | 2021-01-26 -> 2026-08-24 | kr:17, us:5, ca:1, cz:1 ; 18 | bug_watch_loading | Reliability - watch | negative | 26 | 3.34% | very strong | 3.577 | 2020-04-21 -> 2026-04-03 | kr:23, jp:1, ph:1, us:1 ; 19 | bug_widget_not_updating | Reliability - widget | negative | 25 | 3.21% | very strong | 4.080 | 2019-10-14 -> 2026-08-27 | kr:20, au:1, ca:1, de:1 ; 20 | churn_uninstalled | Churn | negative | 25 | 3.21% | very strong | 1.360 | 2020-03-17 -> 2026-06-29 | kr:13, us:10, at:1, cz:1 ; 21 | advocacy_recommend | Outcome | positive | 24 | 3.08% | very strong | 4.917 | 2019-03-30 -> 2025-06-20 | kr:16, us:5, mx:2, nz:1 ; 22 | req_multiple_checkins_day | Request | mixed (unmet need) | 24 | 3.08% | very strong | 4.167 | 2019-04-24 -> 2026-05-05 | kr:17, us:3, de:1, in:1 ; 23 | stats_reports_praise | Praise - feature | positive | 24 | 3.08% | very strong | 4.917 | 2019-03-31 -> 2026-01-02 | kr:13, us:6, gb:2, ca:1 ; 24 | long_tenure_user | Segment | neutral | 23 | 2.95% | meaningful | 3.826 | 2020-01-03 -> 2026-04-21 | kr:17, us:4, jp:1, sg:1 ; 25 | onboarding_no_guidance | Usability | negative | 23 | 2.95% | meaningful | 4.348 | 2019-09-18 -> 2026-05-03 | kr:18, jp:4, sa:1 ; 26 | widget_size_count_limits | Widget design | negative | 23 | 2.95% | meaningful | 4.652 | 2020-10-05 -> 2026-05-04 | kr:21, us:2 ; 27 | bug_keyboard_memo | Reliability - app | negative | 22 | 2.82% | meaningful | 4.091 | 2020-09-17 -> 2020-09-27 | kr:22 ; 28 | color_customization_praise | Praise - UX | positive | 22 | 2.82% | meaningful | 4.818 | 2019-09-05 -> 2026-01-02 | kr:15, us:3, gb:2, ca:1 ; 29 | post_purchase_failure | Monetization - friction | negative | 22 | 2.82% | meaningful | 2.136 | 2021-07-21 -> 2026-07-27 | kr:15, jp:2, us:2, ca:1 ; 30 | memo_note_praise | Praise - feature | positive | 21 | 2.70% | meaningful | 4.952 | 2019-03-31 -> 2025-04-22 | kr:16, us:4, de:1 ; 31 | req_ipad_version | Request | mixed (unmet need) | 21 | 2.70% | meaningful | 4.667 | 2019-04-01 -> 2026-07-12 | kr:18, us:2, ca:1 ; 32 | free_tier_cap | Monetization - friction | negative | 20 | 2.57% | meaningful | 3.250 | 2020-07-10 -> 2026-03-23 | kr:10, us:4, jp:3, gb:1 ; 33 | low_info | Residual | neutral | 20 | 2.57% | meaningful | 4.800 | 2019-04-18 -> 2025-06-20 | kr:12, us:3, br:1, ca:1 ; 34 | price_too_high | Monetization - friction | negative | 20 | 2.57% | meaningful | 3.900 | 2020-03-07 -> 2026-04-22 | jp:7, kr:6, cn:3, mx:1 ; 35 | req_widget_improvements | Request | mixed (unmet need) | 20 | 2.57% | meaningful | 4.700 | 2019-03-31 -> 2024-05-17 | kr:18, it:1, us:1 ; 36 | stamp_satisfaction | Praise - feature | positive | 19 | 2.44% | meaningful | 4.947 | 2019-04-02 -> 2024-02-01 | kr:17, us:2 ; 37 | bug_app_crash | Reliability - app | negative | 18 | 2.31% | meaningful | 2.889 | 2019-12-11 -> 2024-06-04 | kr:18 ; 38 | req_backup_export | Request | mixed (unmet need) | 17 | 2.18% | meaningful | 4.176 | 2019-04-02 -> 2026-05-03 | kr:16, cn:1 ; 39 | req_weekday_display_filter | Request | mixed (unmet need) | 16 | 2.05% | meaningful | 4.250 | 2019-09-06 -> 2023-03-05 | kr:13, us:2, de:1 ; 40 | widget_tap_opens_app | Widget design | negative | 16 | 2.05% | meaningful | 4.750 | 2020-11-04 -> 2023-12-30 | kr:16 ; 41 | past_date_checkin_difficulty | Usability | negative | 13 | 1.67% | meaningful | 4.000 | 2019-09-06 -> 2021-06-27 | kr:10, us:2, ru:1 ; 42 | req_android_version | Request | mixed (unmet need) | 13 | 1.67% | meaningful | 4.615 | 2020-06-17 -> 2025-03-04 | kr:13 ; 43 | req_ui_tweak | Request | mixed (unmet need) | 13 | 1.67% | meaningful | 4.385 | 2019-10-12 -> 2025-08-26 | kr:13 ; 44 | bug_data_loss | Reliability - data | negative | 12 | 1.54% | meaningful | 2.250 | 2019-05-21 -> 2026-04-14 | kr:11, mx:1 ; 45 | free_praise | Monetization - positive | positive | 12 | 1.54% | meaningful | 4.750 | 2020-03-02 -> 2026-08-14 | us:4, kr:3, hk:2, ca:1 ; 46 | calendar_view_praise | Praise - feature | positive | 11 | 1.41% | meaningful | 4.909 | 2019-03-31 -> 2022-02-04 | kr:8, us:2, sg:1 ; 47 | req_past_report_history | Request | mixed (unmet need) | 11 | 1.41% | meaningful | 4.364 | 2020-01-31 -> 2025-06-20 | kr:9, my:1, ru:1 ; 48 | monetization_model_change_complaint | Monetization - friction | negative | 10 | 1.28% | meaningful | 1.700 | 2019-10-16 -> 2026-07-27 | us:3, jp:2, kr:2, hk:1 ; 49 | reminders_praise | Praise - feature | positive | 10 | 1.28% | meaningful | 4.700 | 2020-04-21 -> 2026-01-02 | kr:8, ca:1, gb:1 ; 50 | bug_add_habit_fails | Reliability - app | negative | 9 | 1.16% | meaningful | 2.778 | 2020-09-17 -> 2026-08-24 | kr:8, us:1
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R57-068 — Rating / text contradictions 4 (0.51%, weak) (verbatim): KR 5★ widget-regression complaint 'giving 5★ because of past service'; KR 3★ 'really great 👍'; HK 3★ 'finally got the app I wanted! And got all my needed features for free :)'; US 2★ 'I absolutely love this app and I want to give it 5 stars, but the weekly widgets NEVER work' — the broader pattern (162 five-stars with a negative theme) is the norm: the star rating measures loyalty and the body measures product state

- **Where:** §4.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ID | Store | ★ | What makes it contradictory ; 6613226666 | KR | 5 | A complaint about a widget regression, with the reviewer stating they are giving 5★ *because of past service*: *"그동안 잘 사용해 왔음으로 별5개 드립니다"* ; 7423763648 | KR | 3 | Body is *"정말 좋아요👍"* / "really great 👍" with no criticism at all ; 10245972595 | HK | 3 | Body is unambiguously delighted: *"After a long time of going through tons of habit tracking apps, finally got the app I wanted! And got all my needed features for free :)"* ; 13299429338 | US | 2 | *"I absolutely love this app and I want to give it 5 stars, but the weekly widgets NEVER work"*
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `6613226666`, `7423763648`, `10245972595`, `13299429338`
- **Canonical:** — (nuance register)
