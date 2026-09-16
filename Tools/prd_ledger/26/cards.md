# Cards — report 26

Source: `App Store Reports/26. Eden - Daily Routine Planner - Self care habit tracker, to do (REPORT).md`  
125 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 6
- [Must-haves](#must-haves) — 7
- [Must never break](#must-never-break) — 10
- [Features](#features) — 28
- [Monetization](#monetization) — 14
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 14
- [Audiences](#audiences) — 6
- [Markets and languages](#markets-and-languages) — 7
- [Dated events and trends](#dated-events-and-trends) — 10
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 2
- [Things to do](#things-to-do) — 3
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 10

## Product rules

### R26-009 — The all-or-nothing reward rule is the sharpest design critique and it comes from engaged users: the garden only grows if every habit is checked that day, so partial completion earns nothing — 'If I miss only one out of 6 of my habits, nothing happens. Behaviourally this means people will say it's not worth trying to do any'; 'doing 90% should be rewarded, not the opposite'; 'this goes against self growth as perfection isn't possible everyday'; 'No room for off days… I'm human'; counter-evidence: 25 reviews (mean 4.76) praise Eden precisely for being gentle and streak-free — the gentleness is a positioning win, the all-or-nothing gate contradicts it, and partial credit reconciles the two

- **Where:** Executive summary #4 — the all-or-nothing reward rule is the sharpest design critique, from engaged users: the garden only grows if every habit is checked ('If I miss only one out of 6… nothing happens… people will say it's not worth trying'); 25 praise it for being gentle and streak-free; partial credit reconciles the two
- **This app does:** growth requires 100% daily completion
- **User reaction:** complaint
- **Magnitude:** 20 verified (0.52%, emerging), mean 2.80; gentle/streak-free praised 25 (0.65%, mean 4.76)
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12599605564`, `10748238279`, `12023585537`, `8885523614`, `8807578550`, `10259102511`, `10573227883`, `10646722648`, `11911619291`, `12251741381`, `12811356742`, `12124622329`, `14317196415`, `10056813574`, `12393951903`, `13781551382`, `13823192383`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C201 A user-set partial-completion threshold — a 'good day' below 100%; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R26-054 — All-or-nothing reward rule (verified)

- **Where:** §3.1 theme table All-or-nothing reward rule
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 20 (0.52%, emerging), mean 2.80
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C201 A user-set partial-completion threshold — a 'good day' below 100%; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R26-070 — Eden does not have a pricing problem; it has an evaluation-window problem — the free tier gives enough to fall in love with the aesthetic and not enough to test the product, and it terminates the most visible feedback signal (garden growth) without saying so; 'You get about 5 days free to make one flower then you have to pay'; 'the flower stops growing once you reach 17%, which I finished in about 2 weeks. makes the app pretty pointless now'; one user writes the product hypothesis — 'I'd have been more invested if 1 garden was given as part of the free version (plus ads if needed). That would probably get me intrigued enough to get a subscription eventually'

- **Where:** §3.3 Interpretation — an evaluation-window problem, not a pricing problem: 'You get about 5 days free to make one flower then you have to pay'; 'the flower stops growing once you reach 17%, which I finished in about 2 weeks'; a user writes the product hypothesis: give 1 garden free plus ads and 'that would probably get me intrigued enough to get a subscription'
- **This app does:** free tier ends before evaluation
- **User reaction:** blocked-conversion
- **Magnitude:** 3 named reviews; 436 (11.36%)
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `9502925206`, `9715657325`, `9879336314`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R26-109 — F1: explain the free growth ceiling in-app at the moment it is hit — when the garden stops at ~17%, say so and say why; users currently file a paywall as a bug and rate accordingly; a pure copy change with no feature work that removes the corpus's most persistent 1–3★ misattribution

- **Where:** §9.1 F1 — explain the free growth ceiling in-app at the moment it is hit; pure copy change, removes the corpus's most persistent 1–3★ misattribution
- **This app does:** silent ceiling
- **User reaction:** complaint
- **Magnitude:** 17 naming 17% over 3.5 years; 50 not-growing, mean 2.96
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8554382470`, `13464035283`
- **Canonical:** C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R26-116 — E1: make the free tier evaluable — test (a) time-boxed full access (7–14 days) vs (b) a habit cap of 8–10 vs (c) letting the free tier grow one garden to 100%; cap 148 and paywall 281 vastly exceed price objection 29 and price-defenders outnumber objectors ~2:1; users propose (c) themselves; high-spend markets show 15.4% friction vs 8.6% elsewhere; risk: may cut near-term conversion from impulse buyers who purchase on aesthetics within minutes — measure revenue, not just sentiment

- **Where:** §9.2 E1 — make the free tier evaluable: test time-boxed full access (7–14 days) vs cap 8–10 vs one garden to 100%; users propose (c) themselves; risk: may cut impulse conversion — measure revenue, not sentiment
- **This app does:** 3–6 habit cap; 17% ceiling
- **User reaction:** blocked-conversion
- **Magnitude:** 148 + 281 vs 29; 2:1 defenders
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9879336314`, `9502925206`, `9848844147`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R26-117 — E2: add partial credit for partial completion with full completion still rewarded more — 20 reviews (mean 2.80) with a consistently behavioural argument; it contradicts the design intent some praise, so ship it as a setting, not a replacement — Eden already has a 'no wither' option, the precedent exists

- **Where:** §9.2 E2 — partial credit for partial completion, full completion still rewarded more; ship as a setting, not a replacement — the 'no wither' option is the precedent
- **This app does:** all-or-nothing
- **User reaction:** complaint
- **Magnitude:** 20 (0.52%), mean 2.80
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12599605564`, `10748238279`, `12023585537`, `8885523614`, `8015528155`, `9065775099`
- **Canonical:** C201 A user-set partial-completion threshold — a 'good day' below 100%; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

## Must-haves

### R26-060 — Support unreachable (verified)

- **Where:** §3.1 theme table Support unreachable
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 13 (0.34%, weak), mean 2.77
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R26-065 — No sync / no account

- **Where:** §3.1 theme table No sync / no account
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 7 (0.18%, weak), mean 3.57
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C035 Account system from day one

### R26-076 — Accessibility is weak by rate but promoted on legal/inclusion grounds: a detailed, actionable VoiceOver defect report — images without alt text, focus loss during navigation, elements announced only as 'botão' with no function (Brazil, June 2026) — plus larger text size, a low-contrast report later resolved by the developer, and praise for dynamic type being added

- **Where:** §3.4 Accessibility — promoted on legal/inclusion grounds: a detailed, actionable VoiceOver defect report (images without alt text, focus loss, elements announced only as 'botão'); larger text; low contrast later fixed; dynamic type added and praised
- **This app does:** VoiceOver defects; dynamic type shipped
- **User reaction:** complaint
- **Magnitude:** 5 (0.13%, weak)
- **Direction for us:** must-have · **Report confidence:** weak, promoted · **Generalisable:** yes
- **Review IDs:** `14231051461`, `10416666181`, `9959396034`, `14068662243`
- **Canonical:** C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R26-087 — There is no account system, so a device change, a reinstall, or a support-recommended reinstall destroys both progress and entitlement — 'The support told me to delete and reinstall the app which of course deletes all the lovely growth you have achieved… It also deletes the purchase price of the app if you bought it as there is no account to sign into'; absent accounts, every other entitlement bug becomes unrecoverable — the root cause behind the top paid-user complaint

- **Where:** §5.2 No account system — a device change, reinstall or support-recommended reinstall destroys both progress and entitlement ('deletes all the lovely growth… It also deletes the purchase price… as there is no account'); absent accounts every other entitlement bug becomes unrecoverable — the root cause
- **This app does:** no account, no sync
- **User reaction:** churn
- **Magnitude:** sync/account 7 (0.18%); 3 named reviews
- **Direction for us:** must-have · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `9280888384`, `13358263218`, `10653056353`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one

### R26-110 — F2: fix entitlement restore and add an account — the top paid-user complaint (24 lost-purchase reviews, 12 from explicit payers, 16.7% segment rate); without accounts every other entitlement bug is unrecoverable and support's own advice to reinstall destroys progress and purchase

- **Where:** §9.1 F2 — fix entitlement restore and add an account; without accounts every entitlement bug is unrecoverable and support's own advice (reinstall) causes data loss
- **This app does:** no account
- **User reaction:** 1★-burst
- **Magnitude:** 24; 12/72 (16.7%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10653056353`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C035 Account system from day one

### R26-114 — F6: ship VoiceOver support — sub-threshold by volume, promoted on inclusion/legal grounds; one review contains the entire bug list

- **Where:** §9.1 F6 — ship VoiceOver support; one review contains the entire bug list; promoted on inclusion/legal grounds
- **This app does:** VoiceOver defects
- **User reaction:** complaint
- **Magnitude:** 5 (0.13%)
- **Direction for us:** must-have · **Report confidence:** weak, promoted · **Generalisable:** yes
- **Review IDs:** `14231051461`, `10416666181`, `9959396034`
- **Canonical:** C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R26-115 — F7: make the calendar/statistics view discoverable and allow resetting stats — the rate returned to 4.26% of substantive 2026 reviews ('the calendar could be more easily accessible, I currently have to search for it'); a cheap discoverability fix on already-built functionality

- **Where:** §9.1 F7 — make the calendar/statistics view discoverable and allow resetting stats; something shipped and users still can't find it
- **This app does:** shipped feature hidden
- **User reaction:** complaint
- **Magnitude:** 4.26% substantive 2026
- **Direction for us:** must-have · **Report confidence:** medium · **Generalisable:** yes
- **Review IDs:** `14468283183`, `13624817679`
- **Canonical:** C012 Week / month / year grid views; C142 Surface existing features where users look

## Must never break

### R26-011 — Among the 72 explicit payers (1.88%, mean 3.56) the top failure is purchase lost or not delivered (12/72 = 16.7% segment rate; global 24, 0.63%); second is a trial/billing dispute (6/72 = 8.3%; global 23, 0.60%, mean 1.48 — the lowest-rated theme in the corpus), naming one mechanism repeatedly — a '3-day free trial' that charges immediately; two reviewers could not find any way to unsubscribe

- **Where:** Executive summary #6 — paid reviewers' most common problem is losing what they bought (12/72 = 16.7%); second is a '3-day free trial' that charges immediately (6/72; global mean 1.48, the lowest-rated theme); two could not find any way to unsubscribe
- **This app does:** purchase not honoured; trial charges at once; no in-app cancel
- **User reaction:** 1★-burst
- **Magnitude:** purchase lost 12/72 (16.7%; global 24, 0.63%); billing 6/72 (global 23, 0.60%, mean 1.48)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9091405863`, `9100759613`, `9110825123`, `9125973744`, `9171397848`, `9201257502`, `11035873886`, `11261841935`, `11704889459`, `11998240319`, `12455426263`, `12754805799`, `10909221823`, `11504294876`, `12370651672`, `12404082975`, `11234070366`, `13526453417`, `12128361462`, `11617459927`, `11858690687`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C109 A free trial must be a real trial; C112 In-app cancellation

### R26-045 — Crash / launch failure

- **Where:** §3.1 theme table Crash / launch failure
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 33 (0.86%, emerging), mean 2.79; 1★ 12
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R26-051 — Purchase lost / not delivered

- **Where:** §3.1 theme table Purchase lost / not delivered
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 24 (0.63%, emerging), mean 2.71; 1★ 7
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R26-052 — Trial / billing dispute — the lowest-rated theme

- **Where:** §3.1 theme table Trial / billing dispute
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 23 (0.60%, emerging), mean 1.48; 1★ 17
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial

### R26-056 — Music fault — can't disable / won't play (verified)

- **Where:** §3.1 theme table Music fault (can't disable / won't play)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 16 (0.42%, weak), mean 2.94
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C175 Updates must not break function or wipe progress

### R26-085 — Within 72 payers: purchase lost or not delivered 12 (16.7%; global 24, 0.63%); paywall friction after paying 17 (23.6%); trial/billing dispute 6 (8.3%; global 23); habit cap still felt after paying 8 (11.1%); flower not growing 4 (5.6%); crash 3 (4.2%); support unreachable 3 (4.2%); defends the price anyway 7 (9.7%)

- **Where:** §5.2 What goes wrong for people who paid (verbatim table) — purchase lost 16.7%; paywall friction after paying 23.6%; billing 8.3%; cap still felt 11.1%; flower not growing 5.6%; crash 4.2%; support unreachable 4.2%; defends the price anyway 9.7%
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Problem | Segment rate | Global count / % | Evidence IDs ; Purchase lost or not delivered | 12/72 = 16.7% | 24 / 0.63% | 9091405863, 9100759613, 9110825123, 9125973744, 9171397848, 9201257502, 11035873886, 11261841935, 11704889459, 11998240319, 12455426263, 12754805799 ; Paywall friction after paying | 17/72 = 23.6% | 281 / 7.32% | 8460123418, 8904827978, 9832692472, 10180446556, 12305193972 ; Trial / billing dispute | 6/72 = 8.3% | 23 / 0.60% | 8807578550, 9171397848, 9659384900, 10180446556, 11805806530, 11961817820 ; Habit cap still felt after paying | 8/72 = 11.1% | 148 / 3.86% | 8460123418, 8630163595, 9273659264 ; Flower not growing | 4/72 = 5.6% | 50 / 1.30% | 9012190142, 9791630979, 11261841935, 11346819935 ; Crash / launch failure | 3/72 = 4.2% | 33 / 0.86% | 9125973744, 9659384900, 10661952185 ; Support unreachable | 3/72 = 4.2% | 13 / 0.34% | 9012190142, 9510970460, 10081166801 ; Defends the price anyway | 7/72 = 9.7% | 57 / 1.49% | 8823685044, 9023289235, 10899320628
- **Direction for us:** must-never-break · **Report confidence:** meaningful; small n · **Generalisable:** yes
- **Review IDs:** `8460123418`, `8904827978`, `9832692472`, `10180446556`, `12305193972`, `8807578550`, `9659384900`, `11805806530`, `11961817820`, `8630163595`, `9273659264`, `9012190142`, `11346819935`, `10661952185`, `9510970460`, `10081166801`, `8823685044`, `9023289235`, `10899320628`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R26-086 — The dominant paid-user failure is losing what they bought, by three mechanisms: the 2022 repricing withdrew a purchased unlock; restore-purchases fails or the restore button is dead (incl. Korea); payment succeeded but premium never activated (one resolved by support)

- **Where:** §5.2 Three mechanisms for losing what they bought — the 2022 repricing withdrew a purchased unlock; restore-purchases fails or the button is dead; payment succeeded but premium never activated
- **This app does:** entitlement fragile
- **User reaction:** 1★-burst
- **Magnitude:** 8 + 8 + 8 IDs
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9091405863`, `9171397848`, `9199616690`, `9126251428`, `9201257502`, `10780468727`, `12116109329`, `12754805799`, `9110825123`, `10081166801`, `10607202811`, `10820076320`, `11037255753`, `12455426263`, `12189296095`, `10101213721`, `8936510590`, `9100759613`, `11704889459`, `11793200692`, `11998240319`, `12438244732`, `12087503101`, `11440749807`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C186 Never revoke what earlier buyers paid for when the model changes

### R26-091 — Trial/billing disputes (23, 0.60%, mean 1.48): '3 days free' then charged immediately (incl. a lifetime tier charged instantly with no trial disclosed); cancelled before trial end, charged anyway; renewal with no advance notice; cannot find how to cancel / no in-app cancellation ('well hidden there is a way to contact support… but the button is not enabled'); refund requested and support unreachable

- **Where:** §5.5 Refund and cancellation friction — '3 days free' then charged immediately (lifetime tier charged instantly with no trial disclosed); cancelled before trial end, charged anyway; renewal with no notice; cannot find how to cancel ('the support button is not enabled'); refund requested, support unreachable
- **This app does:** trial charges at once; no in-app cancel
- **User reaction:** 1★-burst
- **Magnitude:** 23 (0.60%), mean 1.48; 7 + 3 + 2 + 3 + 4 IDs
- **Direction for us:** must-never-break · **Report confidence:** emerging, lowest mean · **Generalisable:** yes
- **Review IDs:** `10909221823`, `11504294876`, `12370651672`, `12404082975`, `11234070366`, `13526453417`, `12128361462`, `9541684420`, `11805806530`, `10971264763`, `14097593436`, `11858690687`, `11617459927`, `11961817820`, `9449546415`, `9510970460`, `13523628780`, `10180446556`
- **Canonical:** C109 A free trial must be a real trial; C112 In-app cancellation; C221 A receipt with a working product link after every charge, and a renewal reminder before it

### R26-111 — F3: make the trial-to-charge sequence explicit and put cancellation in-app — 23 disputes at mean 1.48, the lowest-rated theme, incl. a lifetime tier charged instantly with no trial; generates the corpus's only accusations of deception ('scam', 'estafadores', '引君入甕'); reputational and potentially compliance-relevant

- **Where:** §9.1 F3 — make the trial-to-charge sequence explicit and put cancellation in-app; the lowest-rated theme, generates the corpus's only accusations of deception; potentially compliance-relevant
- **This app does:** trial charges immediately; no in-app cancel
- **User reaction:** 1★-burst
- **Magnitude:** 23, mean 1.48
- **Direction for us:** must-never-break · **Report confidence:** emerging, lowest mean · **Generalisable:** yes
- **Review IDs:** `13526453417`, `11617459927`, `11858690687`
- **Canonical:** C109 A free trial must be a real trial; C112 In-app cancellation

### R26-112 — F4: verify the 2026 crash cluster against crash telemetry for RU/iOS before it becomes a trend — n=4, three Russian, two paying

- **Where:** §9.1 F4 — verify the 2026 crash cluster (n=4, 3 Russian, 2 paying) against telemetry before it becomes a trend
- **This app does:** possible regression
- **User reaction:** complaint
- **Magnitude:** 4
- **Direction for us:** must-never-break · **Report confidence:** low–medium · **Generalisable:** app-specific
- **Review IDs:** `13776796955`, `13917160052`, `13958209159`, `14150331209`
- **Canonical:** C031 Crashes / launch failures

## Features

### R26-014 — Biggest unshipped features in evidence order: statistics/history/calendar (40 verified, 1.04%, meaningful) → partial-credit growth (20, 0.52%) → backfill and a configurable day boundary (29, 0.76%) → habit reordering / per-habit gardens (18, 0.47%) → flexible recurrence such as '3× per week' (12, 0.31%) → Apple Watch (8, 0.21%) → multi-count per day for water/pages (7, 0.18%)

- **Where:** Executive summary #9 — biggest unshipped features in evidence order: statistics/history/calendar 40 → partial-credit growth 20 → backfill + configurable day boundary 29 → habit reordering / per-habit gardens 18 → flexible recurrence '3× per week' 12 → Apple Watch 8 → multi-count per day 7
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 40 / 20 / 29 / 18 / 12 / 8 / 7
- **Direction for us:** undecided · **Report confidence:** meaningful to weak · **Generalisable:** yes
- **Canonical:** C010 Backfill missed days / edit start date; C012 Week / month / year grid views; C022 Apple Watch app (done properly: timer, two-way sync); C043 Flexible / custom frequency; C073 Manual reordering, renaming and editing of habits/tasks — free; C143 Intra-day completion: tap N times to fill N/N; C201 A user-set partial-completion threshold — a 'good day' below 100%

### R26-019 — The daily checklist is free but capped — 3, 4, 5 or 6 free habits reported over time, 5 dominant

- **Where:** §2.1 Daily habit/task checklist — free but capped (3 / 4 / 5 / 6 reported; 5 dominant)
- **This app does:** free cap ~5
- **User reaction:** complaint
- **Magnitude:** cap 148 (3.86%)
- **Direction for us:** free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8233610259`, `9186134212`, `11801356965`, `13840613528`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R26-020 — The flower/garden grows free to ~17% then is gated; multiple gardens (4 reported) are paid

- **Where:** §2.1 Growing flower / garden — free to ~17%, then gated; multiple gardens (4) paid
- **This app does:** growth ceiling; extra gardens paid
- **User reaction:** mixed
- **Magnitude:** 50 not-growing reviews
- **Direction for us:** paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8554382470`, `9316992889`, `9339556961`, `9715657325`, `9193385982`, `10460446079`, `12370205487`, `13272780198`
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C133 Gate on capability, not on quantity; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R26-021 — Background music and nature sounds — several tracks free, more paid — with background audio playing outside the app, and free daily quotes

- **Where:** §2.1 Background music / nature sounds (several free, more paid); background audio outside the app free; daily quotes free
- **This app does:** ambience free with paid extras
- **User reaction:** praise
- **Magnitude:** music praised 559 (14.57%, mean 4.68)
- **Direction for us:** free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11188463546`, `12006559790`, `10124533614`, `8824331514`, `10886909914`, `11258319859`, `9279698557`, `10023340564`, `13248521083`
- **Canonical:** C009 Basic widgets, icons and colours are free; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R26-022 — Themes, backgrounds, seasons and app icons are partly free with more paid

- **Where:** §2.1 Themes / backgrounds / seasons / app icons — partly free, more paid
- **This app does:** cosmetics partly paid
- **User reaction:** praise
- **Magnitude:** inventory row
- **Direction for us:** paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `12079233152`, `11801356965`, `13272780198`
- **Canonical:** C009 Basic widgets, icons and colours are free; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R26-023 — A garden-view home-screen widget, reminders/notifications, a built-in timer and per-habit day-of-week scheduling are all free

- **Where:** §2.1 Home-screen widget (garden view) free; reminders free; built-in timer free; day-of-week scheduling per habit free
- **This app does:** core utilities free
- **User reaction:** praise
- **Magnitude:** inventory rows
- **Direction for us:** free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8794895153`, `9462643279`, `11626437199`, `11239625943`, `12356065455`, `9186134212`, `10056813574`, `9740265256`, `11189660127`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C009 Basic widgets, icons and colours are free; C043 Flexible / custom frequency; C066 Focus timer

### R26-024 — A 'no wither' / Zen mode (the garden does not decay) is reported as premium

- **Where:** §2.1 'No wither' / Zen mode — reported as premium
- **This app does:** forgiveness mode paid
- **User reaction:** mixed
- **Magnitude:** 3 reviews
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11701576961`, `10679138445`, `11996446174`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R26-025 — Calendar/statistics were absent for most of the corpus and appear to have shipped ~late 2024

- **Where:** §2.1 Calendar / statistics — absent for most of the corpus, appears ~late 2024
- **This app does:** shipped late 2024
- **User reaction:** mixed
- **Magnitude:** 40 requests (1.04%)
- **Direction for us:** free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `10006259845`, `12204175553`, `12244017370`, `14227614235`
- **Canonical:** C012 Week / month / year grid views; C142 Surface existing features where users look

### R26-026 — There is no account or cloud sync and no Apple Watch app at any point in the corpus

- **Where:** §2.1 Account / cloud sync — absent throughout; Apple Watch — absent throughout
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** sync 5 IDs; Watch 8 (0.21%)
- **Direction for us:** must-have · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `9052145225`, `9280888384`, `10958830676`, `12042680917`, `11655204052`, `8628572813`, `9237768812`, `10073204122`, `11420767261`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C035 Account system from day one

### R26-030 — Aesthetic / design praised

- **Where:** §3.1 theme table Aesthetic / design praise
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 1,068 (27.83%, high-priority), mean 4.64; 1★ 10 · 5★ 812
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal and ad-free; C057 Offer a non-pastel / premium design option

### R26-031 — Music / calm / ambience praised

- **Where:** §3.1 theme table Music / calm / ambience praise
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 559 (14.57%, high-priority), mean 4.68; 5★ 446
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R26-039 — Daily quotes praised

- **Where:** §3.1 theme table Quotes praise
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 58 (1.51%, meaningful), mean 4.74; 5★ 48
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R26-044 — No statistics / history / calendar (verified)

- **Where:** §3.1 theme table No statistics / history / calendar
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 40 (1.04%, meaningful), mean 3.83; 4★ 16
- **Direction for us:** free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views

### R26-048 — No backfill / configurable day boundary (verified)

- **Where:** §3.1 theme table No backfill / day boundary
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 29 (0.76%, emerging), mean 3.03; 3★ 11
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C010 Backfill missed days / edit start date; C170 Configurable day boundary and hemisphere seasons

### R26-053 — Widget mentions

- **Where:** §3.1 theme table Widget (mentions)
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 21 (0.55%, emerging), mean 4.14
- **Direction for us:** free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free

### R26-055 — Reorder / group / per-habit garden

- **Where:** §3.1 theme table Reorder / group / per-habit garden
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 18 (0.47%, weak), mean 4.06
- **Direction for us:** free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C045 Grouping / folders / categories / tags; C073 Manual reordering, renaming and editing of habits/tasks — free

### R26-058 — Flexible recurrence (N×/week)

- **Where:** §3.1 theme table Flexible recurrence (N×/week)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 12 (0.31%, weak), mean 3.50
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency

### R26-062 — Custom habits not creatable (verified) — preset-only onboarding

- **Where:** §3.1 theme table Custom habits not creatable
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 (0.21%, weak), mean 2.50
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R26-063 — Apple Watch requested

- **Where:** §3.1 theme table Apple Watch requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 (0.21%, weak), mean 4.00
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R26-064 — Multi-count per day

- **Where:** §3.1 theme table Multi-count per day
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 7 (0.18%, weak), mean 4.14
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N

### R26-066 — Accessibility incl. VoiceOver

- **Where:** §3.1 theme table Accessibility (incl. VoiceOver)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 5 (0.13%, weak — promoted on inclusion grounds), mean 4.00
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R26-072 — Statistics, history and a per-habit calendar are the top unmet need — 'this is a cosmetic habit tracker, it does not offer really understanding of progress'; a calendar appears to have shipped ~late 2024

- **Where:** §3.4 Statistics / history / calendar per habit — the top unmet need; 'this is a cosmetic habit tracker, it does not offer really understanding of progress'
- **This app does:** no per-habit stats for most of the corpus
- **User reaction:** complaint
- **Magnitude:** 40 verified (1.04%, meaningful), mean 3.83, 16 4★
- **Direction for us:** free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12251741381`, `12265166141`, `10006259845`, `14443983125`
- **Canonical:** C012 Week / month / year grid views

### R26-073 — Backfill of the previous day and a configurable day boundary (midnight reset) are requested

- **Where:** §3.4 Backfill previous day / configurable day boundary
- **This app does:** no backfill; midnight cut-off
- **User reaction:** complaint
- **Magnitude:** 29 verified (0.76%, emerging), mean 3.03
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `8874333151`, `8875094753`, `9274330602`, `9449546415`, `10108096197`, `11176218907`
- **Canonical:** C010 Backfill missed days / edit start date; C170 Configurable day boundary and hemisphere seasons

### R26-074 — Reordering habits, per-habit gardens or categories (18), flexible recurrence such as '3× per week' plus a vacation mode (12), and multi-count per day for water or pages (7) are requested

- **Where:** §3.4 Reorder habits / per-habit gardens / categories; flexible recurrence ('3× per week') and vacation mode; multi-count per day (5 glasses, 10 pages)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 18 (0.47%); 12 (0.31%); 7 (0.18%)
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `8772022784`, `10206828410`, `8296733263`, `9267531151`, `9906136301`, `10388741373`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency; C073 Manual reordering, renaming and editing of habits/tasks — free; C143 Intra-day completion: tap N times to fill N/N

### R26-075 — An interactive widget to tick from the home screen (~5) and a journal / gratitude note (~4) are requested

- **Where:** §3.4 Interactive widget (tick from home screen) ~5; journal / gratitude note ~4
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** ~5; ~4
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `9608846258`, `10103075953`, `13648793040`, `8475403176`, `9085913110`, `11932654664`, `12921283639`
- **Canonical:** C023 Interactive widget check-off; C172 Per-day / per-habit notes and journal text

### R26-118 — E3: allow backfill and a user-set day boundary — 29 reviews; night-owl and after-midnight complaints recur across five years; a partial backfill already exists (the next-day 'did you do it?' prompt) and is praised — this extends it

- **Where:** §9.2 E3 — allow backfill and a user-set day boundary; a partial backfill (next-day 'did you do it?' prompt) already exists and is praised
- **This app does:** next-day prompt only
- **User reaction:** complaint
- **Magnitude:** 29 (0.76%)
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10108096197`, `12137473742`, `12531678334`, `12646839757`, `13080138566`, `11425077076`, `9156524322`
- **Canonical:** C010 Backfill missed days / edit start date; C170 Configurable day boundary and hemisphere seasons

### R26-119 — E4: expand garden/flower content and add per-habit gardens — garden-motivation praise is declining 7.93% → 3.76% and content-exhaustion reviews recur; content cost, but this is the retention mechanism; per-habit gardens also partially solve the all-or-nothing problem without changing the reward rule

- **Where:** §9.2 E4 — expand garden/flower content and add per-habit gardens; the retention mechanism's decline is the most strategically important soft signal; per-habit gardens partially solve E2 without changing the reward rule
- **This app does:** finite content; one shared garden
- **User reaction:** churn
- **Magnitude:** 10 exhaustion + 5 per-habit requests
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `9501729733`, `11848653184`, `13393242871`, `12137473742`, `11873650347`, `12932219546`, `12057271899`, `14317196415`, `11639800309`
- **Canonical:** C045 Grouping / folders / categories / tags; C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R26-120 — E5: flexible recurrence (N× per week) and a vacation/pause mode ('exception periods' while travelling) — 12 reviews; low risk, but it adds configuration surface to a product whose main virtue is simplicity, so keep it behind an advanced toggle

- **Where:** §9.2 E5 — flexible recurrence (N× per week) and vacation/pause mode ('exception periods' while travelling); keep behind an advanced toggle to protect simplicity
- **This app does:** daily-only; no pause
- **User reaction:** complaint
- **Magnitude:** 12 (0.31%)
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `8296733263`, `9267531151`, `9846065416`, `11563266717`, `12520372421`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency

## Monetization

### R26-007 — The free-tier gate is the single largest negative fact and mostly a trial-design problem, not a price problem: monetisation gating themes are 63 of 109 one-star reviews (57.8%) and 196 of 404 one-to-three-star (48.5%) — numeric habit cap 148 (3.86%, mean 3.51), general paywall friction 281 (7.32%, mean 3.55) — but outright price objection is only 29 (0.76%), while 57 (mean 4.18) actively defend the price as fair and 45 (mean 4.49) praise the free tier as generous; reviewers are not saying Eden is too expensive, they are saying the free tier ends before they can judge it

- **Where:** Executive summary #2 — the free-tier gate is the largest negative fact and mostly a trial-design problem, not a price problem: 57.8% of 1★; price objection only 0.76% while 57 defend the price and 45 praise the free tier
- **This app does:** hard free cap + growth ceiling
- **User reaction:** blocked-conversion
- **Magnitude:** 436 (11.36%, high-priority, mean 3.42); 57.8% of 1★; cap 148 (3.86%); paywall 281 (7.32%); price objection 29 (0.76%); price defended 57 (1.49%, 4.18); free tier praised 45 (1.17%, 4.49)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `7996943615`, `8233610259`, `8505526778`, `9467741672`, `10682566057`, `11005479210`, `12298596229`, `12514072590`, `13253044306`, `13819382131`, `14371694907`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R26-027 — Price history as reviewers report it: Nov 2021–mid 2022 $5, $6, $6.99, $7, €6, €6.99 one-time full unlock; late 2022 onward $25 lifetime / $19.99 yr / $4.99–5 mo; 2024 $25 lifetime, €24.99, R$99.90, ₽799; 2025–26 ₽700, R$9/mo, €40, $15

- **Where:** §2.2 Price history table (verbatim) — $5–7 / €6–7 one-time (2021–mid 2022) → $25 lifetime / $19.99 yr / $4.99 mo (late 2022) → $25 / €24.99 / R$99.90 / ₽799 (2024) → ₽700 / R$9 mo / €40 / $15 (2025–26)
- **This app does:** one-time → subscription+lifetime; lifetime ~5× over four years
- **User reaction:** mixed
- **Magnitude:** Period | Prices named in reviews | Evidence ; Nov 2021 – mid 2022 | $5, $6, $6.99, $7, €6, €6.99 — one-time full unlock | 7996943615, 8336251610, 8727837706, 8807243801, 8888351571, 9023289235, 9062393771, 9171397848, 9199616690 ; Late 2022 onward | $25 lifetime / $19.99 yr / $4.99–5 mo | 9273659264, 9541684420, 9734071502, 9740265256, 10157689409, 10231187604, 10378314260 ; 2024 | $25 lifetime, €24.99, R$99.90, ₽799 | 10883132862, 10899320628, 11145970025, 11163433251, 11348756546, 11704889459 ; 2025–2026 | ₽700, R$9/mo, €40, $15 | 12215344678, 13129357689, 14074701122, 14139725862
- **Direction for us:** build-paid · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `7996943615`, `8336251610`, `8727837706`, `8807243801`, `8888351571`, `9023289235`, `9062393771`, `9273659264`, `9541684420`, `9734071502`, `9740265256`, `10157689409`, `10231187604`, `10378314260`, `10883132862`, `10899320628`, `11145970025`, `11163433251`, `11348756546`, `12215344678`, `13129357689`, `14074701122`, `14139725862`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C186 Never revoke what earlier buyers paid for when the model changes

### R26-028 — One-time pricing is a genuine, repeatedly praised differentiator — 57 reviews (1.49%, mean 4.18) defend the price, most specifically because it is not a subscription; Eden monetises against the grain of its category and reviewers reward it; the 2022 migration spent some of that goodwill and the €40 2026 price point risks spending more

- **Where:** §2.2 Interpretation — one-time pricing is a genuine, repeatedly praised differentiator (57 defend the price, most because it is not a subscription); Eden monetises against the grain of its category; the 2022 migration spent goodwill and the €40 2026 price risks more
- **This app does:** lifetime option kept; price rising
- **User reaction:** purchase-driver
- **Magnitude:** 57 (1.49%), mean 4.18
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8336140876`, `8772348836`, `10695074415`, `12157437413`, `12407593622`, `12771044340`, `13499175461`, `14139725862`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors

### R26-033 — Any monetisation gating (union)

- **Where:** §3.1 theme table Any monetisation gating
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 436 (11.36%, high-priority), mean 3.42; 1★ 63 · 2★ 51 · 3★ 82 · 4★ 121 · 5★ 119
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R26-034 — General paywall friction

- **Where:** §3.1 theme table Paywall friction (general)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 281 (7.32%, high-priority), mean 3.55; 1★ 31
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R26-036 — Free habit-count cap complaint

- **Where:** §3.1 theme table Free habit-count cap
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 148 (3.86%, very strong), mean 3.51; 4★ 47 · 5★ 40
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R26-038 — Explicit payer segment

- **Where:** §3.1 theme table Explicit payer
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 72 (1.88%, meaningful), mean 3.56; 1★ 11 · 5★ 30
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R26-040 — Defends the price

- **Where:** §3.1 theme table Defends the price
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 57 (1.49%, meaningful), mean 4.18; 5★ 38
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'

### R26-041 — Garden/flower count cap — 'my reward stopped'

- **Where:** §3.1 theme table Garden/flower count cap
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 53 (1.38%, meaningful), mean 3.13; 3★ 17
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C133 Gate on capability, not on quantity; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R26-043 — Praises the free tier as generous

- **Where:** §3.1 theme table Praises the free tier
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 45 (1.17%, meaningful), mean 4.49; 5★ 33
- **Direction for us:** free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R26-047 — Price objection — the smallest of the four monetisation objections

- **Where:** §3.1 theme table Price objection
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 29 (0.76%, emerging), mean 2.76; 1★ 9
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R26-057 — Cannot complete purchase — willing buyers blocked

- **Where:** §3.1 theme table Cannot complete purchase
- **This app does:** see §3.1
- **User reaction:** blocked-conversion
- **Magnitude:** 16 (0.42%, weak), mean 4.06; 5★ 10
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK)

### R26-069 — Monetisation gating is 11.36% of all reviews and 21.2% of substantive ones (380/1,791) — roughly one in five reviewers who write more than a sentence raises the paywall; what they object to: habit-count cap 148 ('I can't fit my routine in'), general paywall 281 ('too much is locked'), garden/flower cap 53 ('my reward stopped'), price too high only 29 (mean 2.76); against this 57 defend the price and 45 praise the free tier — defenders to objectors roughly 2:1 in favour of the price

- **Where:** §3.3 The negative core — monetisation: 21.2% of substantive reviews raise the paywall; objection breakdown table (verbatim): cap 148, general 281, garden cap 53, price too high 29; price-defenders to price-objectors ~2:1
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Objection | n | % of corpus | Mean | Reading ; Habit-count cap | 148 | 3.86% | 3.51 | "I can't fit my routine in" ; General paywall friction | 281 | 7.32% | 3.55 | "too much is locked" ; Garden/flower cap | 53 | 1.38% | 3.13 | "my reward stopped" ; Price is too high | 29 | 0.76% | 2.76 | the smallest of the four ; substantive 380/1,791 = 21.2%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C064 Price level — where 'fair' turns into 'too expensive'

### R26-088 — Purchase triggers: the aesthetic within minutes of install ('I bought premium within the first couple minutes of downloading'; 'bought the full version five minutes into trying it'; 'as soon as I saw the visuals and music I bought premium'); one-time pricing specifically (11 IDs); hitting the habit cap ('got premium for more tasks and was worth it for $6.99'); supporting the developer ('bought premium right away just to support the developers'); wanting more gardens after finishing one ('If more are added I'll probably subscribe forever'); intent stated but not completed because of the payment rail

- **Where:** §5.3 What triggers a purchase (verbatim table) — the aesthetic within minutes of install ('I bought premium within the first couple minutes'); one-time pricing; hitting the cap ('worth it for $6.99'); supporting the developer; wanting more gardens; intent stated but blocked by the rail
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Trigger | Evidence ; The aesthetic, within minutes of install | "I bought premium within the first couple minutes of downloading" (8529349059); "Compré la versión completa a las cinco minutos de probarla" (9538949221); "acabei fazendo a compra sem querer no automático" (9278204636); "indirip görselleri ve müzikleri… görür görmez premium satın aldım" (10980121651); also 12517241963, 13088087272, 13014264724 ; One-time pricing specifically (not a subscription) | 8336140876, 8772348836, 9062393771, 10399539290, 10695074415, 12157437413, 12407593622, 12771044340, 13499175461, 14139725862, 14450189261 ; Hitting the habit cap | 8336251610 ("got premium for more tasks and was worth it for $6.99"), 9763250548, 11754786694 ; Supporting the developer | "ho acquistato subito la versione premium anche solo per sostenere gli sviluppatori" (10433282734); 10056813574 ; Wanting more gardens after finishing one | 9501729733 ("If more are added I'll probably subscribe forever"), 11848653184 ; Intent stated but not completed (see 5.4) | 8542291903, 10394231453, 11145405840, 12206803821, 12594654731
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8529349059`, `9538949221`, `9278204636`, `10980121651`, `12517241963`, `13088087272`, `13014264724`, `8336140876`, `8772348836`, `9062393771`, `10399539290`, `10695074415`, `12157437413`, `12407593622`, `12771044340`, `13499175461`, `14139725862`, `14450189261`, `8336251610`, `9763250548`, `11754786694`, `10433282734`, `10056813574`, `9501729733`, `11848653184`, `8542291903`, `10394231453`, `11145405840`, `12206803821`, `12594654731`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C057 Offer a non-pastel / premium design option; C061 Goodwill conversion — a generous free tier and 'support the devs'; C185 Aesthetic and a polished onboarding convert; they do not retain

## Tactics the app used

### R26-003 — Tactic and outcome: the app rewards a review with a cosmetic unlock (background, wallpaper, theme, song, flower) and reviewers say so in writing — 'they said if I write this review I'd get to change the look of my flower'; 'I'm just doing this to get the backgrounds 😋 I haven't even used the app at all'; 'devo cuorarla per avere un certo colore di sfondo'; one pre-emptively writes '(I'm NOT a bot btw)' — a rating-inflation mechanism and the single most important methodological fact in the corpus; 0.34% is the floor

- **Where:** Warning #1 — the app rewards reviews with cosmetic unlocks and reviewers say so: 'I'm just doing this to get the backgrounds 😋 I haven't even used the app at all'
- **This app does:** review-for-cosmetic reward
- **User reaction:** 5★-burst
- **Magnitude:** 13 (0.34%, weak — floor), mean 4.77
- **Direction for us:** dont · **Report confidence:** weak (floor), high consequence · **Generalisable:** yes
- **Review IDs:** `12132143279`, `12272181443`, `13061382481`, `11882600620`, `11659462958`, `13025206367`, `8304651472`, `11284478723`, `11717197486`, `12520666753`, `12984118431`, `13965948642`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R26-059 — Review incentivised by unlock

- **Where:** §3.1 theme table Review incentivised by unlock
- **This app does:** see §3.1
- **User reaction:** 5★-burst
- **Magnitude:** 13 (0.34%, weak — floor), mean 4.77
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

## Insights (the why)

### R26-005 — The post-2023 improvement is real, not purely an artefact: restricting to substantive reviews the mean still rises 4.175 (2023, n=343) → 4.512 (2024, n=633) and monetisation friction still falls 27.70% → 19.43%; both the prompt effect and the product improvement are present

- **Where:** Warning #3 — the improvement after 2023 is nevertheless real: substantive mean 4.175 (2023) → 4.512 (2024); substantive monetisation friction 27.70% → 19.43%
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 4.175 → 4.512; 27.70% → 19.43% (substantive)
- **Direction for us:** none · **Report confidence:** very strong · **Generalisable:** app-specific
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R26-032 — Simplicity / ease praised

- **Where:** §3.1 theme table Simplicity / ease praise
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 411 (10.71%, high-priority), mean 4.70; 5★ 334
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal and ad-free

### R26-035 — Garden-growth metaphor as motivation

- **Where:** §3.1 theme table Garden-growth motivation praise
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 229 (5.97%, high-priority), mean 4.68; 5★ 180
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C024 Streaks / gamification; C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R26-049 — Praises gentleness / no streak

- **Where:** §3.1 theme table Praises gentleness / no streak
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 25 (0.65%, emerging), mean 4.76; 5★ 20
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R26-067 — Aesthetic and calm are not decoration; reviewers describe them as the mechanism — other trackers overwhelmed me → this one is beautiful and quiet → therefore I keep opening it → therefore the habit stuck ('Most other habit tracking apps are too technical… Growing a garden feels like growing myself'; 'they are all really aggressively focussed on being productive… it's so gentle' from a reviewer almost entirely bedbound; 'It's not just an app it's a piece of art')

- **Where:** §3.2 The positive core — aesthetic and calm are the mechanism: other trackers overwhelmed me → this one is beautiful and quiet → I keep opening it → the habit stuck ('Growing a garden feels like growing myself'; 'It's not just an app it's a piece of art')
- **This app does:** calm aesthetic as retention mechanism
- **User reaction:** praise
- **Magnitude:** aesthetic 1,068; 14 representative reviews
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8809983265`, `13024796099`, `12393951903`, `9280888384`, `8788448563`, `9062177143`, `9945145056`, `10084378650`, `10023340564`, `11064426818`, `12157437413`, `13291395738`, `13781551382`, `14068662243`
- **Canonical:** C006 Stay minimal and ad-free; C057 Offer a non-pastel / premium design option

### R26-068 — Gentleness specifically, as against streaks: 'it doesn't work on building a streak because then when you break a streak you feel dispirited and give up'; 'because you don't have a streak it is purely for your own benefit'; 'accountability and motivation without the shame' — Eden's defensible position is calm, non-punitive, beautiful, and every recommendation is filtered through whether it protects that

- **Where:** §3.2 Gentleness as against streaks — 'when you break a streak you feel dispirited and give up'; 'accountability and motivation without the shame'
- **This app does:** no streaks
- **User reaction:** praise
- **Magnitude:** 25 (0.65%), mean 4.76
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10056813574`, `13772603777`, `13781551382`, `9204099812`, `12192324803`, `13178231487`, `13823192383`, `13291395738`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R26-078 — 5★ (75.53%) has two populations — a substantive one (aesthetic + calm + garden + simplicity) and the ≤25-character tier (1,181 reviews, 30.78% of the corpus, overwhelmingly 5★, almost no product information, inflated by the review reward); 82 five-star reviews still raise the paywall and 40 the habit cap — users who love the app and flag the gate

- **Where:** §4.1 5★ — two populations; the ≤25-char tier is 1,181 reviews (30.78%) inflated by the review reward; 82 five-star reviews still raise the paywall and 40 the cap
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 1,181 (30.78%) ≤25 chars; 82 paywall + 40 cap inside 5★
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11201646002`, `11567448179`, `12494163107`, `13081671996`, `14368304623`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R26-079 — 4★ (13.94%) is the 'one thing away' band and the most commercially informative: the single most common reason for withholding the fifth star is the cap — 47 of 535 (8.8%) — with a near-identical sentence across languages, 'amazing app, but you can only add 5'; widening or time-boxing the free tier converts a measurable slice of 4★ to 5★ with no feature work

- **Where:** §4.1 4★ is the 'one thing away' band — the cap is the single most common reason for withholding the fifth star (47 of 535, 8.8%): 'amazing app, but you can only add 5'; widening or time-boxing the free tier converts 4★ to 5★ with no feature work
- **This app does:** free cap
- **User reaction:** complaint
- **Magnitude:** 47 of 535 (8.8%)
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8568171880`, `10231187604`, `11531054327`, `12179799133`, `13036834858`, `14086191609`, `14371694907`, `14514107557`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R26-080 — 3★ (5.42%) is the diagnostic band: paywall (55) and cap (26) dominate but the product critiques concentrate here — flower not growing (16), backfill (11), missing stats ('a cosmetic habit tracker'), partial credit, onboarding with preset-only habits, VoiceOver; reviewers are engaged and specific

- **Where:** §4.1 3★ is the diagnostic band — paywall and cap dominate but product critiques concentrate here: flower not growing, backfill, missing stats, partial credit, preset-only onboarding, VoiceOver
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** n=208
- **Direction for us:** must-have · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `12251741381`, `12599605564`, `12265166141`, `13260660833`, `14231051461`
- **Canonical:** C012 Week / month / year grid views; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R26-081 — The characteristic 2★ is 'beautiful but I can't use it' — 20 of 87 still compliment the design alongside the cap and the growth failure

- **Where:** §4.1 2★ — 'beautiful but I can't use it': 20 of 87 still compliment the design
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 20 of 87
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13395181371`, `12298596229`, `13931019513`, `13967376763`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R26-082 — 1★ (2.84%): 63 of 109 (57.8%) carry a monetisation theme and the distinctive content is transactional, not feature-based — 17 billing disputes (mean 1.48, the lowest-rated theme), 12 crashes, 7 lost purchases; the angriest language is reserved for charges: 'Scam company. Impossible to cancel and tricks you into renewing'; 'Estafadores'; '故意引君入甕'; 'Деньги на ветер'

- **Where:** §4.1 1★ — 57.8% carry a monetisation theme; the distinctive content is transactional: 17 billing disputes (mean 1.48), 12 crashes, 7 lost purchases; angriest language reserved for charges ('Scam company. Impossible to cancel and tricks you into renewing')
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 63/109; billing 17; crash 12; lost purchase 7
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11858690687`, `14097593436`, `13526453417`, `9659384900`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C109 A free trial must be a real trial

### R26-089 — Eden converts on beauty and on the absence of a subscription, fast, and often before the user has evaluated the functionality — which explains both the high purchase velocity and the payer dissatisfaction: people buy in minutes on aesthetics, then discover the missing statistics, the all-or-nothing rule or the lost entitlement; 'I bought this one a little too soon I think, I wish I had waited to use it a while before spending money on it'

- **Where:** §5.3 Interpretation — Eden converts on beauty and on the absence of a subscription, fast, often before evaluating functionality; that explains both purchase velocity and payer dissatisfaction ('I bought this one a little too soon I think')
- **This app does:** aesthetic-led impulse conversion
- **User reaction:** mixed
- **Magnitude:** payers mean 3.56 vs 4.570
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `11435151688`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C185 Aesthetic and a polished onboarding convert; they do not retain

### R26-107 — Four themes show no meaningful improvement across five years — the all-or-nothing rule (1.20% → 0.63%), backfill/day boundary (1.68% → 0.94%), trial/billing disputes (1.20% → 0.63%) and, after the 2024 improvement, monetisation friction flat at 19.43% → 19.00% → 18.44% of substantive reviews for three years — Eden fixed its engineering problems and has not touched its design and commercial ones

- **Where:** §8.4 What persisted — no improvement across five years in the all-or-nothing rule (1.20% → 0.63%), backfill/day boundary (1.68% → 0.94%), trial/billing (1.20% → 0.63%) and, after 2024, monetisation friction flat at 19.43% → 19.00% → 18.44% of substantive reviews: Eden fixed its engineering problems and has not touched its design and commercial ones
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** friction 19.43 → 19.00 → 18.44% (substantive)
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R26-108 — Garden-motivation praise declines monotonically (7.93% → 8.41% → 5.65% → 5.03% → 3.76%) while aesthetic praise strengthens to 34.17%, so it is not general affect drift; reviewers report running out of gardens — 'when I grew all the gardens, there is nothing to do. I'd like new gardens'; 'when I plant all the gardens… I'll get bored if more aren't added'; 'YOU NEED MORE GARDEN DESIGNS!!'; 'I'm afraid that after a while motivation drops if it's the same flowers already seen' — the core reward loop has a content ceiling and long-term users are hitting it; for a product whose entire retention mechanism is the garden, the most strategically important soft signal

- **Where:** §8.5 One weakening positive — garden-motivation praise declines monotonically 7.93% → 8.41% → 5.65% → 5.03% → 3.76% while aesthetic praise strengthens; reviewers report running out of gardens ('when I grew all the gardens, there is nothing to do'; 'YOU NEED MORE GARDEN DESIGNS!!'): the core reward loop has a content ceiling — the most strategically important soft signal
- **This app does:** finite garden content
- **User reaction:** churn
- **Magnitude:** 7.93% → 3.76%; 10 content-exhaustion reviews
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11848653184`, `9501729733`, `13393242871`, `12137473742`, `9752337057`, `9988825300`, `11467616368`, `12263431554`, `13826711840`, `13272780198`
- **Canonical:** C024 Streaks / gamification; C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

## Audiences

### R26-037 — ADHD / autism / OCD self-identified — mixed

- **Where:** §3.1 theme table ADHD / autism / OCD self-ID
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 81 (2.11%, meaningful), mean 3.84; 1★ 5 · 5★ 33
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R26-046 — Mental-health context

- **Where:** §3.1 theme table Mental-health context
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 32 (0.83%, emerging), mean 4.66; 5★ 26
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R26-050 — Teen / child / student

- **Where:** §3.1 theme table Teen / child / student
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 25 (0.65%, emerging), mean 4.16
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C068 Parents tracking kids

### R26-097 — ADHD/neurodivergent users (81, 2.11%, mean 3.84; 1★ 5 · 2★ 8 · 3★ 15 · 4★ 20 · 5★ 33), concentrated in English-language storefronts (us 48, gb 12, ca 9, au 5 — partly a framing/language difference, do not read as prevalence): when Eden works for them it works because of the simplicity, not the features ('every routine / daily planner / to-do list app has been deleted within a day because it's too complicated… this was perfect immediately'; 'the only app that's helped me keep a routine for any length of time'; a Japanese reviewer who tried 10+ task apps) — but this is the segment the cap hits hardest because the same review that praises simplicity says five habits cannot hold a morning routine ('with only 5 slots i can only just get my mornings together'); the lowest mean of any positively-framed segment; era share 3.37% → 4.57% → 1.45% → 1.64% → 0.94% with mean falling 4.50 (2024) → 3.47 → 2.33 (2026, n=3) — too small to call, flagged for monitoring

- **Where:** §7.1 ADHD / neurodivergent — 81 (2.11%, mean 3.84), concentrated in English storefronts (us 48, gb 12, ca 9, au 5 — a framing/language difference, not prevalence); when Eden works it is because of simplicity ('every routine app has been deleted within a day because it's too complicated… this was perfect immediately'); the cap hits this segment hardest ('with only 5 slots i can only just get my mornings together'); the lowest mean of any positively-framed segment
- **This app does:** simple, capped
- **User reaction:** mixed
- **Magnitude:** 81 (2.11%), mean 3.84 vs 4.570; us 48 / gb 12 / ca 9 / au 5
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11104027675`, `11031909897`, `11060956986`, `8204423986`, `10242008479`, `11099108717`, `11190072439`, `11244034733`, `11620390853`, `13178231487`, `13198235435`, `9861016027`
- **Canonical:** C006 Stay minimal and ad-free; C007 Generous fixed habit cap (or unlimited) — never change it; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R26-098 — Mental-health context (32, 0.83%, mean 4.66) holds the highest-affect reviews in the corpus — 'Summed up, this app helped me fix my severe depression'; a detailed account of three years clean; 'I'm very unwell and almost entirely bedbound'; 'it got me out of a depression pit'; 'Because of the situation in the world I had terrible anxiety… This app helped me return to life' — the segment validates the gentle, non-punitive positioning more strongly than any other evidence and is the clearest argument against making the all-or-nothing rule any harsher

- **Where:** §7.2 Mental-health context — 32 (0.83%, mean 4.66), the highest-affect reviews: 'this app helped me fix my severe depression'; three years clean; 'almost entirely bedbound'; 'got me out of a depression pit'; anxiety from the situation in the world — validates the gentle, non-punitive positioning and is the clearest argument against a harsher all-or-nothing rule
- **This app does:** gentle, non-punitive
- **User reaction:** praise
- **Magnitude:** 32 (0.83%, emerging), mean 4.66
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12671925870`, `11440858154`, `12393951903`, `13967376763`, `8619185317`, `9797391833`, `10899320628`, `12374360834`, `12895478797`, `13024796099`, `13368937314`, `13395134922`, `13735925988`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R26-099 — Teens, children and students (25, 0.65%, mean 4.16; self-identified ages 10 to 21 — 'I am 10', 'a 12 year old girl', 'just started 5th grade', 'as a 6th grader'; one bought it for an elderly parent, one for their children, one recommends it to therapy clients) cannot pay and say so ('I'm a teenager and would like to do stuff without spending my money'; 'as a high schooler, I don't exactly have cash to spare'); three independently ask for a rewarded-ad path to extra habits ('I will watch ads all day long if I have to'; 'I'd rather watch a few adds for the extra reminders') — a signal that a non-payment unlock has demand in a segment converting at zero, but it conflicts directly with the 7 reviews (mean 5.00) that praise Eden for having no ads

- **Where:** §7.3 Teens, children and students — 25 (0.65%, mean 4.16), ages 10 to 21; one bought for an elderly parent, one for children, one recommends it to therapy clients; the segment cannot pay ('I'm a teenager and would like to do stuff without spending my money'); three independently ask for a rewarded-ad path ('I will watch ads all day long if I have to') — conflicts with 7 reviews (mean 5.00) praising no ads
- **This app does:** no ad-supported path; no ads at all
- **User reaction:** blocked-conversion
- **Magnitude:** 25 (0.65%), mean 4.16; 3 rewarded-ad requests; 7 no-ads praise (mean 5.00)
- **Direction for us:** research · **Report confidence:** emerging / weak · **Generalisable:** yes
- **Review IDs:** `10205271464`, `11048519270`, `10526326100`, `13269559552`, `11015185830`, `8988155521`, `11056305629`, `11240268188`, `9583109346`, `12095870875`, `11089804053`, `10640916403`, `9461024196`, `9686727861`, `9484164891`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C068 Parents tracking kids; C082 Ads in the free tier; C238 A rewarded-ad unlock path for users who cannot pay (teens, students)

## Markets and languages

### R26-013 — Russia is 19.2% of the corpus (736 reviews) and behaves differently from every Western market: mean 4.697, 85.3% 5★ — the highest satisfaction of any eligible market — with monetisation friction 7.34% against 14.29% (US), 19.83% (DE), 20.37% (FR), 18.52% (AU); it supplies the highest rate of missing-statistics requests (2.58% vs 1.04%) and a distinct payment-rail problem — 8 of the 16 'cannot complete purchase' reviews are Russian, describing an unresponsive buy button or unlinkable cards; Eden's largest non-US market is willing to pay and structurally unable to — an addressable revenue leak

- **Where:** Executive summary #8 — Russia is 19.2% of the corpus, the highest-satisfaction market (mean 4.697, 85.3% 5★, friction 7.34% vs 14–20% in Western markets), the highest statistics-request rate, and 8 of 16 'cannot complete purchase' reviews — willing to pay and structurally unable to
- **This app does:** no working payment rail in Russia
- **User reaction:** blocked-conversion
- **Magnitude:** n=736 (19.2%), mean 4.697, 85.3% 5★, friction 7.34%; 8/16 purchase-blocked
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10454824450`, `10635690558`, `11145405840`, `12774568544`, `13926278152`, `8478822922`, `10156327013`, `11704889459`
- **Canonical:** C012 Week / month / year grid views; C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C062 Weight English-speaking rich markets; volume ≠ revenue

### R26-090 — 16 reviews (0.42%, mean 4.06) describe wanting to pay and being unable to — unconverted willing buyers, not complaints: Russia 8 ('won't let me link a card'; 'the trial button is not clickable… possibly because I live in Russia'), China/Taiwan 3 ('tap subscribe and nothing happens… want to buy but can't'; a ¥38 tier shown on the App Store with no in-app purchase path), Vietnam 2 (requests ShopeePay / MoMo), plus GB (buy button not working), TR (price not displayed, button dead), DE (persistent error); Russia is 19.18% of the corpus and the highest-satisfaction market and supplies half of all 'I cannot pay you' reviews — the highest-yield-per-unit-effort monetisation item because the demand is already qualified

- **Where:** §5.4 Purchase blocked by the payment rail — 16 willing buyers (mean 4.06) unable to pay: Russia 8 ('the button to start the trial is not clickable… possibly because I live in Russia'), China/Taiwan 3 (App Store shows a ¥38 tier with no in-app path), Vietnam 2 (ShopeePay / MoMo), GB / TR / DE — the highest-yield-per-effort monetisation item
- **This app does:** no working purchase path in RU/CN/VN
- **User reaction:** blocked-conversion
- **Magnitude:** 16 (0.42%), mean 4.06; ru 8, cn/tw 3, vn 2
- **Direction for us:** do · **Report confidence:** weak globally, high yield · **Generalisable:** yes
- **Review IDs:** `8478822922`, `10156327013`, `10454824450`, `10635690558`, `11145405840`, `12774568544`, `13926278152`, `11704889459`, `11049310428`, `11440793102`, `13287745467`, `12761795981`, `13461522997`, `11037255753`, `11460280739`, `11793200692`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C089 Promos, giveaways and gift codes must work exactly as advertised

### R26-092 — Fourteen storefronts ≥50 (us 987, ru 736, br 347, gb 161, mx 154, vn 136, de 121, ca 109, fr 108, tr 88, it 83, au 81, cn 64, es 52 = 3,227, 84.10%) with mean, 5★, 1★, monetisation, cap, paywall, flower-not-growing, no-stats and aesthetic rates; the cn aesthetic figure (3.12%) is a coverage artefact — Chinese reviews are overwhelmingly design-praising

- **Where:** §6.1 Eligible markets table (verbatim) — 14 storefronts, 3,227 reviews, 84.10%; the cn aesthetic figure (3.12%) is a classifier-coverage artefact
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** cc | n | % corpus | Mean | 5★ | 1★ | Monetisation | Habit cap | Paywall | Flower not growing | No stats | Aesthetic* ; us | 987 | 25.72% | 4.526 | 72.3% | 3.3% | 14.29% | 6.69% | 9.42% | 1.42% | 0.61% | 25.33% ; ru | 736 | 19.18% | 4.697 | 85.3% | 2.4% | 7.34% | 1.49% | 3.53% | 1.77% | 2.58% | 38.72% ; br | 347 | 9.04% | 4.663 | 81.3% | 1.7% | 8.65% | 3.46% | 4.90% | 0.86% | 1.15% | 17.87% ; gb | 161 | 4.20% | 4.416 | 70.2% | 5.6% | 12.42% | 4.35% | 8.70% | 2.48% | 0.62% | 21.12% ; mx | 154 | 4.01% | 4.675 | 77.3% | 1.9% | 7.79% | 2.60% | 4.55% | 0.65% | 0.00% | 27.92% ; vn | 136 | 3.54% | 4.824 | 86.8% | 1.5% | 5.15% | 2.21% | 2.94% | 0.00% | 0.00% | 23.53% ; de | 121 | 3.15% | 4.347 | 63.6% | 2.5% | 19.83% | 4.13% | 12.40% | 1.65% | 0.83% | 46.28% ; ca | 109 | 2.84% | 4.413 | 67.9% | 2.8% | 15.60% | 10.09% | 8.26% | 0.92% | 0.00% | 21.10% ; fr | 108 | 2.81% | 4.593 | 69.4% | 0.0% | 20.37% | 3.70% | 15.74% | 1.85% | 3.70% | 22.22% ; tr | 88 | 2.29% | 4.523 | 75.0% | 4.5% | 7.95% | 1.14% | 5.68% | 1.14% | 1.14% | 46.59% ; it | 83 | 2.16% | 4.494 | 68.7% | 3.6% | 13.25% | 4.82% | 10.84% | 3.61% | 1.20% | 48.19% ; au | 81 | 2.11% | 4.370 | 64.2% | 4.9% | 18.52% | 4.94% | 9.88% | 2.47% | 0.00% | 33.33% ; cn | 64 | 1.67% | 4.547 | 76.6% | 3.1% | 4.69% | 0.00% | 3.12% | 0.00% | 0.00% | 3.12%* ; es | 52 | 1.36% | 4.173 | 59.6% | 7.7% | 17.31% | 7.69% | 9.62% | 0.00% | 1.92% | 30.77% ; *(73 other storefronts)* | 610 | 15.90% | 4.544 | — | — | — | — | — | — | — | —
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `8138417101`, `8510444265`, `11126881810`, `11139121493`, `12693171490`, `13974486249`
- **Canonical:** — (nuance register)

### R26-093 — Top five by volume (us 987, ru 736, br 347, gb 161, mx 154 = 2,385, 62.16%): the US is the volume and friction anchor (mean 4.526, cap 6.69% — second-highest — and most of the articulate paywall arguments); Russia is the anomaly worth a decision (highest 5★ share 85.3%, lowest large-market paywall friction 7.34%, highest statistics-request rate 2.58% and half of all blocked-payment reviews; Russian reviewers are the corpus's most engaged, constructive feature critics — about tracking depth, not price); Brazil (4.663) mirrors Russia and supplies the one substantive accessibility report; Great Britain underperforms (4.416, 1★ 5.6%); Mexico (4.675) tracks the Latin-American pattern

- **Where:** §6.2 High-review-volume markets — us, ru, br, gb, mx = 62.16%; US is the volume and friction anchor (cap 6.69%, second-highest); Russia the anomaly (85.3% 5★, friction 7.34%, stats requests 2.58%, most engaged feature critics); Brazil mirrors Russia; GB underperforms (4.416, 1★ 5.6%); Mexico high satisfaction low friction
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** us 25.72% / 4.526 / cap 6.69%; ru 19.18% / 4.697 / 85.3% 5★ / friction 7.34% / stats 2.58%; br 9.04% / 4.663; gb 4.20% / 4.416; mx 4.01% / 4.675
- **Direction for us:** none · **Report confidence:** very strong · **Generalisable:** app-specific
- **Review IDs:** `9467741672`, `9502925206`, `10682566057`, `12298596229`, `12514072590`, `13263518147`, `9843813677`, `10006259845`, `10282667264`, `11497891805`, `12104864958`, `12204175553`, `12265166141`, `14231051461`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C062 Weight English-speaking rich markets; volume ≠ revenue

### R26-094 — High-spend markets (us, gb, de, fr, ca, au = 1,567, 40.84%; a stated assumption, Japan excluded at 49 reviews) vs the rest (2,270): mean 4.489 vs 4.626; 5★ 70.5% vs 79.0%; monetisation friction 15.3% vs 8.7%; habit-cap mentions 6.2% vs 2.2% — the markets that generate the most revenue per user complain most about the paywall and rate the app lowest: Germany 19.83% friction and 63.6% 5★ (the lowest of any eligible market), France 20.37% and the highest general-paywall rate 15.74%, Australia 18.52%, Canada 15.60% with the highest cap rate 10.09%; Germany and France are also where price-defence arguments are most articulate — markets willing to pay, frustrated by the trial, not the price

- **Where:** §6.3 High-spend markets (us, gb, de, fr, ca, au = 40.84%; stated assumption): mean 4.489 vs 4.626 rest; friction 15.3% vs 8.7%; cap 6.2% vs 2.2% — the free-tier design is costing most where the money is; Germany 63.6% 5★ (lowest), France 20.37% friction, Australia 18.52%, Canada cap 10.09%
- **This app does:** free-tier design costs most in rich markets
- **User reaction:** complaint
- **Magnitude:** Metric | High-spend group (n=1,567) | Rest of corpus (n=2,270) ; Mean rating | 4.489 | 4.626 ; 5★ share | 70.5% | 79.0% ; Monetisation friction | 15.3% | 8.7% ; Habit-cap mentions | 6.2% | 2.2%
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8823685044`, `10378314260`, `11348756546`, `12157437413`, `11188463546`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R26-095 — Sub-50 storefront observations: localisation requests in Arabic (BH, SA), Thai and Spanish (pre-localisation); Russian localisation quality was criticised in 2023 ('hire a competent localiser') and praised by 2025–26; the German store listing carried a typo — 'Eden-Gewohnheitstrinker' (habit drinker) instead of 'Gewohnheitstracker'; Android absence asked repeatedly (CN, FR, SE)

- **Where:** §6.4 Limited-evidence — localisation requests (Arabic, Thai, Spanish pre-localisation); Russian localisation quality criticised in 2023 then praised 2025–26; a German store-listing typo ('Gewohnheitstrinker'); Android asked repeatedly
- **This app does:** partial localisation; listing typo
- **User reaction:** complaint
- **Magnitude:** limited evidence, single-digit
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `9318303655`, `12573706028`, `8528954369`, `10342152227`, `9729004144`, `12432281757`, `13903218376`, `12947041033`, `11704807174`, `9834028008`, `12588547810`, `12198340554`
- **Canonical:** C027 Localise early — it unlocks revenue; C051 Android version; C218 Store listing and paywall copy stay true — never advertise a feature you removed, lack, or don't integrate

### R26-096 — Eight Chinese-language reviews believe Eden is or resembles a discontinued Android app, '种子习惯' (Seed Habit), and ask for its community features back; one asks specifically for iCloud sync, weekly/monthly check-ins and lock-screen shortcuts — limited evidence but a coherent, unusually specific feature brief from one market

- **Where:** §6.4 Chinese '种子习惯' (Seed Habit) lineage — eight Chinese reviews believe Eden is or resembles a discontinued Android app and ask for its community features back; one asks for iCloud sync, weekly/monthly check-ins and lock-screen shortcuts — a coherent feature brief from one market
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 8 reviews (limited evidence)
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `8250985466`, `9204502880`, `10317747510`, `10395456352`, `11042032558`, `12216305359`, `12712075548`, `13476543118`
- **Canonical:** C005 Know which competitors buyers compare against; C015 Shared / group habits; C027 Localise early — it unlocks revenue

## Dated events and trends

### R26-010 — A visible engineering turnaround happened in 2024 and the data supports crediting it: crash/launch failure 3.37% (2021–22) → 2.01% (2023) → 0.13% (2024) → 0.19% (2025); 'music can't be turned off' 2.88% → 0.00% → 0.07% (the cluster is entirely 2022 and then stops); mean 4.339 → 4.346 → 4.675; 1★ share 7.0% → 4.9% → 1.5%; a calendar/history feature appears to have shipped ~late 2024 ('Thanks for adding the calendar', Jan 2025; 'analytics of past habits', 2026) — the 2022-era reliability and audio bugs were genuinely fixed; the monetisation complaints were not

- **Where:** Executive summary #5 — a visible engineering turnaround in 2024: crash 3.37% (2021–22) → 2.01% → 0.13% → 0.19%; 'music can't be turned off' 2.88% → 0.00%; mean 4.339 → 4.346 → 4.675; 1★ 7.0% → 4.9% → 1.5%; a calendar/history feature shipped ~late 2024 ('Спасибо, что добавили календарь'); the monetisation complaints were not fixed
- **This app does:** fixed reliability and audio, shipped calendar
- **User reaction:** praise
- **Magnitude:** crash 3.37% → 0.13%; music 2.88% → 0.00%; mean 4.339 → 4.675; 1★ 7.0% → 1.5%
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8655424484`, `8807243801`, `8868778397`, `8899067436`, `8902349870`, `9116351698`, `9121762212`, `9241525509`, `9263941862`, `9300714052`, `12244017370`, `14227614235`
- **Canonical:** C012 Week / month / year grid views; C031 Crashes / launch failures; C059 Be visibly responsive; fixes bring reviewers back; C175 Updates must not break function or wipe progress

### R26-012 — The late-2022 repricing broke a cohort of lifetime buyers: prices moved from $5–$7 / €6–€7 one-time (2021 → mid-2022) to $25 lifetime / $19.99 yr / $4.99 mo (late 2022) to €40 (2026); seven reviewers in Sept–Oct 2022 report the unlock they had already bought withdrawn — 'most of the features I had access to (which I paid for) were no longer accessible… now I would have to pay a subscription fee'; 'the premium version I bought was taken away from me… I consider that a breach of contract' — and the grievance recurs in 2024–2025; a trust liability with a long tail and why 'already paid, asked to pay again' is the top paid-user complaint

- **Where:** Executive summary #7 — the late-2022 repricing broke a cohort of lifetime buyers: $5–7 / €6–7 one-time → $25 lifetime / $19.99 yr / $4.99 mo (late 2022) → €40 (2026); seven reviewers in Sept–Oct 2022 report the unlock they had bought withdrawn ('Ich empfinde das als Vertragsbruch'); the grievance recurs years later
- **This app does:** revoked one-time unlock at model change
- **User reaction:** 1★-burst
- **Magnitude:** 7 reviews Sept–Oct 2022 + 3 later; price $5–7 → $25 → €40
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9091405863`, `9171397848`, `9199616690`, `9100759613`, `9125973744`, `9126251428`, `9201257502`, `10780468727`, `12754805799`, `12116109329`, `14074701122`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C186 Never revoke what earlier buyers paid for when the model changes

### R26-084 — Explicit payers (72, 1.88%; 1★ 11 · 2★ 8 · 3★ 13 · 4★ 10 · 5★ 30) rate Eden a full point below the corpus (3.56 vs 4.570); by era 3.67 (2021–22, n=21) → 3.41 (2023, 22) → 3.47 (2024, 15) → 3.69 (2025, 13) → 4.00 (2026, 1) — no meaningful trend; payer satisfaction is flat and consistently below the corpus mean across five years, and the 2024 quality turnaround does not show up in it

- **Where:** §5.1 The explicit-payer segment — 72 (1.88%), mean 3.56, a full point below the corpus; by era 3.67 → 3.41 → 3.47 → 3.69 → 4.00 (n=21/22/15/13/1): flat and consistently below; the 2024 turnaround does not show up in payer satisfaction
- **This app does:** paid experience flat while free experience improved
- **User reaction:** mixed
- **Magnitude:** Era | n | Mean ; 2021–22 | 21 | 3.67 ; 2023 | 22 | 3.41 ; 2024 | 15 | 3.47 ; 2025 | 13 | 3.69 ; 2026 | 1 | 4.00 ; mean 3.56 vs 4.570
- **Direction for us:** must-never-break · **Report confidence:** meaningful; small n · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R26-100 — Eras (calendar years, 2021–22 combined): E1 n=416, mean 4.339 (substantive 4.115), 5★ 70.7%, 1★ 7.0%, ≤25-char 20.9%; E2 2023 547, 4.346 (4.175), 67.6%, 4.9%, 16.5%; E3 2024 1,521, 4.675 (4.512), 79.0%, 1.5%, 35.0%; E4 2025 1,034, 4.629 (4.375), 76.4%, 1.9%, 35.7%; E5 2026 319, 4.574 (4.390), 76.2%, 3.1%, 32.3% — every rate given twice because the short-review share nearly doubles mid-corpus

- **Where:** §8.1 Era table (verbatim) — E1 2021–22 416 / 4.339 (subst. 4.115) / 1★ 7.0% / ≤25-char 20.9%; E2 2023 547 / 4.346 (4.175) / 4.9% / 16.5%; E3 2024 1,521 / 4.675 (4.512) / 1.5% / 35.0%; E4 2025 1,034 / 4.629 (4.375) / 1.9% / 35.7%; E5 2026 319 / 4.574 (4.390) / 3.1% / 32.3%
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era | n (all) | n (substantive) | Mean (all) | Mean (substantive) | 5★ (all) | 1★ (all) | ≤25-char share ; E1 2021–22 | 416 | 253 | 4.339 | 4.115 | 70.7% | 7.0% | 20.9% ; E2 2023 | 547 | 343 | 4.346 | 4.175 | 67.6% | 4.9% | 16.5% ; E3 2024 | 1,521 | 633 | 4.675 | 4.512 | 79.0% | 1.5% | 35.0% ; E4 2025 | 1,034 | 421 | 4.629 | 4.375 | 76.4% | 1.9% | 35.7% ; E5 2026 | 319 | 141 | 4.574 | 4.390 | 76.2% | 3.1% | 32.3%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R26-101 — Theme rates by era, all reviews: any monetisation gating 14.42% → 19.74% → 9.47% → 8.80% → 10.34% (improved, then flat); habit cap 5.29 → 7.68 → 2.76 → 3.48 → 1.88; paywall general 7.69 → 12.25 → 6.77 → 5.71 → 6.27; price objection 1.68 → 2.01 → 0.20 → 0.58 → 0.63; garden cap 2.64 → 3.66 → 0.53 → 0.87 → 1.57; flower not growing 3.12 → 2.38 → 0.85 → 0.58 → 1.57 (ticking back up); crash 3.37 → 2.01 → 0.13 → 0.19 → 1.25 (fixed, then regressing); music can't be disabled 2.88 → 0.00 → 0.07 → 0.10 → 0.63 (fixed); support unreachable 1.68 → 0.37 → 0.00 → 0.29 → 0.31; no statistics 2.16 → 1.83 → 0.46 → 0.68 → 2.19 (returned); backfill 1.68 → 0.91 → 0.46 → 0.68 → 0.94 (persistent); all-or-nothing 1.20 → 0.91 → 0.33 → 0.29 → 0.63 (persistent); trial/billing 1.20 → 0.91 → 0.53 → 0.29 → 0.63 (persistent); aesthetic 28.37 → 28.88 → 26.04 → 27.76 → 34.17 (strengthening); music praise 18.03 → 13.79 (stable); garden motivation 7.93 → 8.41 → 5.65 → 5.03 → 3.76 (weakening); gentleness 0.96 → 0.73 → 0.20 → 0.87 → 1.57 (strengthening)

- **Where:** §8.2 Theme rates by era — all reviews (verbatim table): monetisation 14.42% → 19.74% → 9.47% → 8.80% → 10.34% (improved then flat); cap 5.29 → 7.68 → 2.76 → 3.48 → 1.88; crash 3.37 → 2.01 → 0.13 → 0.19 → 1.25 (fixed then regressing); music can't disable 2.88 → 0.00 (fixed); no stats 2.16 → 1.83 → 0.46 → 0.68 → 2.19 (returned); aesthetic 28.37 → 34.17 (strengthening); garden motivation 7.93 → 3.76 (weakening); gentleness 0.96 → 1.57
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 2021–22 | 2023 | 2024 | 2025 | 2026 | Direction ; Any monetisation gating | 14.42% | 19.74% | 9.47% | 8.80% | 10.34% | improved, then flat ; Habit cap | 5.29% | 7.68% | 2.76% | 3.48% | 1.88% | improved ; Paywall general | 7.69% | 12.25% | 6.77% | 5.71% | 6.27% | improved ; Price objection | 1.68% | 2.01% | 0.20% | 0.58% | 0.63% | improved ; Garden cap | 2.64% | 3.66% | 0.53% | 0.87% | 1.57% | improved ; Flower not growing | 3.12% | 2.38% | 0.85% | 0.58% | 1.57% | improved, ticking back up ; Crash / launch failure | 3.37% | 2.01% | 0.13% | 0.19% | 1.25% | fixed, then regressing ; Music can't be disabled | 2.88% | 0.00% | 0.07% | 0.10% | 0.63% | fixed ; Support unreachable | 1.68% | 0.37% | 0.00% | 0.29% | 0.31% | improved ; No statistics / history | 2.16% | 1.83% | 0.46% | 0.68% | 2.19% | improved, returned ; Backfill / day boundary | 1.68% | 0.91% | 0.46% | 0.68% | 0.94% | persistent ; All-or-nothing | 1.20% | 0.91% | 0.33% | 0.29% | 0.63% | persistent ; Trial / billing dispute | 1.20% | 0.91% | 0.53% | 0.29% | 0.63% | persistent ; Aesthetic praise | 28.37% | 28.88% | 26.04% | 27.76% | 34.17% | stable / strengthening ; Music praise | 18.03% | 16.27% | 14.00% | 13.35% | 13.79% | stable ; Garden motivation praise | 7.93% | 8.41% | 5.65% | 5.03% | 3.76% | weakening ; Gentleness praise | 0.96% | 0.73% | 0.20% | 0.87% | 1.57% | strengthening
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R26-102 — Substantive reviews only (controls for the prompt effect): any monetisation gating 22.13% → 27.70% → 19.43% → 19.00% → 18.44%; habit cap 7.91 → 11.66 → 6.16 → 8.31 → 4.26; paywall general 12.25 → 17.49 → 13.11 → 11.88 → 9.93; flower not growing 4.35 → 3.21 → 1.90 → 1.43 → 3.55; crash 4.35 → 2.92 → 0.32 → 0.48 → 2.13; no statistics 3.56 → 2.92 → 1.11 → 1.66 → 4.26

- **Where:** §8.2 Theme rates by era — substantive reviews only (verbatim table): monetisation 22.13 → 27.70 → 19.43 → 19.00 → 18.44%; cap 7.91 → 11.66 → 6.16 → 8.31 → 4.26; paywall 12.25 → 17.49 → 13.11 → 11.88 → 9.93; flower not growing 4.35 → 3.55; crash 4.35 → 0.32 → 2.13; no stats 3.56 → 1.11 → 4.26
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 2021–22 | 2023 | 2024 | 2025 | 2026 ; Any monetisation gating | 22.13% | 27.70% | 19.43% | 19.00% | 18.44% ; Habit cap | 7.91% | 11.66% | 6.16% | 8.31% | 4.26% ; Paywall general | 12.25% | 17.49% | 13.11% | 11.88% | 9.93% ; Flower not growing | 4.35% | 3.21% | 1.90% | 1.43% | 3.55% ; Crash / launch failure | 4.35% | 2.92% | 0.32% | 0.48% | 2.13% ; No statistics / history | 3.56% | 2.92% | 1.11% | 1.66% | 4.26%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R26-103 — The 2024 quality step-change is real: mean 4.346 → 4.675 and 1★ 4.9% → 1.5% between 2023 and 2024; the short-review share also jumps (16.5% → 35.0%) so part is the review prompt, but the substantive-only mean rises too (4.175 → 4.512) and the defect themes fall independently of review length — crashes 2.92% → 0.32% of substantive reviews, monetisation friction 27.70% → 19.43%

- **Where:** §8.3 Trend 1 — the 2024 quality step-change is real (high confidence): mean 4.346 → 4.675, 1★ 4.9% → 1.5%; substantive mean 4.175 → 4.512; substantive crashes 2.92% → 0.32%; friction 27.70% → 19.43% — both the prompt effect and the product improvement are present
- **This app does:** fixed reliability 2024
- **User reaction:** praise
- **Magnitude:** 4.346 → 4.675; 4.175 → 4.512; crash 2.92% → 0.32%
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set; C059 Be visibly responsive; fixes bring reviewers back

### R26-104 — The background-music defect (music cannot be turned off) is a clean, closed defect: all ten reviews fall in May–Nov 2022, the rate is 0.00% across all of 2023 and never exceeds 0.63% again; the three later mentions are the inverse problem — music won't play

- **Where:** §8.3 Trend 2 — the background-music defect was fixed and the fix is datable (high confidence): all 10 'can't turn the music off' reviews in 2022, 0.00% across 2023; later mentions are the inverse (music won't play)
- **This app does:** fixed 2022 audio bug
- **User reaction:** praise
- **Magnitude:** 10 in 2022 → 0 in 2023; 3 inverse later
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8655424484`, `8807243801`, `8868778397`, `8899067436`, `8902349870`, `9116351698`, `9121762212`, `9241525509`, `9263941862`, `9300714052`, `13163415628`, `13629469356`, `13817513437`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C175 Updates must not break function or wipe progress

### R26-105 — Statistics/history was addressed around late 2024 and then regressed or re-emerged as demand: complaints fall from 2.16%/1.83% (2021–23) to 0.46% (2024), a reviewer thanks the team for adding a calendar in January 2025, a 2026 reviewer praises 'analytics of past habits' and another can see 'a yearly outline' — but the rate returns to 2.19% (all) / 4.26% (substantive) in 2026 (can't reset statistics; 'the calendar could be more easily accessible, I currently have to search for it'); something shipped and it is either insufficient or insufficiently discoverable

- **Where:** §8.3 Trend 3 — statistics/history addressed ~late 2024 then re-emerged (medium confidence): complaints 2.16%/1.83% → 0.46% (2024), 'thanks for adding the calendar' (Jan 2025), 'a yearly outline' — but back to 2.19% / 4.26% substantive in 2026 (can't reset stats; calendar hard to find): something shipped and is insufficient or undiscoverable
- **This app does:** shipped calendar, undiscoverable
- **User reaction:** mixed
- **Magnitude:** 0.46% (2024) → 2.19% / 4.26% (2026)
- **Direction for us:** must-have · **Report confidence:** medium · **Generalisable:** yes
- **Review IDs:** `12244017370`, `14227614235`, `14477621410`, `13624817679`, `13837922277`, `14443983125`, `14468283183`
- **Canonical:** C012 Week / month / year grid views; C142 Surface existing features where users look

### R26-106 — Crashes returned in 2026: 0.13% (2024) → 0.19% (2025) → 1.25% (2026), 2.13% of substantive 2026 reviews — only four records, three of them Russian and two from paying users (a long-term premium subscriber whose app crashes on the onboarding screen after reinstall, with support unresponsive for months; 'for the last week the flower does not grow and does not respond'); n=4 cannot support a rate claim but the cluster is recent, geographically concentrated and hits paid users — flagged for crash telemetry

- **Where:** §8.3 Trend 4 — crashes returned in 2026 (low–medium confidence, n=4): 0.13% → 0.19% → 1.25% (2.13% substantive); three of four Russian, two paying users (a long-term premium subscriber crashing on the onboarding screen after reinstall, support unresponsive for months) — flagged for telemetry, not asserted
- **This app does:** possible 2026 regression
- **User reaction:** complaint
- **Magnitude:** 4 records; 1.25% / 2.13%
- **Direction for us:** must-never-break · **Report confidence:** low–medium · **Generalisable:** app-specific
- **Review IDs:** `13776796955`, `13917160052`, `13958209159`, `14150331209`
- **Canonical:** C031 Crashes / launch failures

## Positioning

### R26-001 — Eden — Daily Routine Planner · Self care habit tracker, to do (App Store ID 1589243137) — a calm, aesthetic garden-metaphor habit tracker: free download, hard cap on free habits (3→5→6 over time), free garden growth ceiling at ~17%, then monthly / annual / lifetime IAP; no ads; model changed from one-time unlock to subscription+lifetime in late 2022

- **Where:** header lines 1-9; §10.5 External sources
- **This app does:** developer of record Millefeuille Agency; bundle com.mfagency.nurture; extracted 8 Sep 2026; analysis 11 Sep 2026; store rank 26; freemium with cap + growth ceiling
- **User reaction:** praise
- **Magnitude:** 3,837 reviews · 87 storefronts · 6 Nov 2021 → 6 Sep 2026; mean 4.570; 5★ 2,898 / 4★ 535 / 3★ 208 / 2★ 87 / 1★ 109
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R26-006 — Eden is an aesthetics-and-calm product first and that is an unusually dominant, durable moat: design/aesthetic (27.83%, mean 4.64), music and ambience (14.57%, 4.68), simplicity (10.71%, 4.70) and the garden-growth metaphor as motivation (5.97%, 4.68) are the largest themes by a wide margin and stable across all five years (aesthetic 28.4% → 28.9% → 26.0% → 27.8% → 34.2%); the recurring sentence is that other trackers are too busy — 'This app is like a warm hug'

- **Where:** Executive summary #1 — an aesthetics-and-calm product first: an unusually dominant, durable moat ('other trackers are too busy… This app is like a warm hug'); aesthetic 28.4% → 34.2% stable across five years
- **This app does:** calm garden-metaphor tracker with music
- **User reaction:** praise
- **Magnitude:** aesthetic 1,068 (27.83%, high-priority, 4.64); music 559 (14.57%, 4.68); simplicity 411 (10.71%, 4.70); garden metaphor 229 (5.97%, 4.68)
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8788448563`, `9062177143`, `9945145056`, `10023340564`, `11064426818`, `12157437413`, `13024796099`, `13291395738`, `14068662243`
- **Canonical:** C006 Stay minimal and ad-free; C057 Offer a non-pastel / premium design option; C095 Neutral, non-judgemental tone on failure

## Anti-patterns

### R26-008 — The free growth ceiling reads to users as a bug, not a paywall — a distinct, fixable reputational problem: 50 verified reviews report the flower or garden not growing, 17 of them naming the same number, 17%, spanning April 2022 → December 2025 (a further 10 name 2%/3%/6%); reviewers file these as defects ('Glitches 🙄', 'Awaria', 'Bug', 'Fake Flowers') and several say support told them it was intentional; 'I thought even with the free version you could grow at least 1 flower all the way' — the free tier silently stops a visible progress bar without explaining why; a one-line in-app explanation converts a 1–3★ 'it's broken' review into a legible upgrade prompt

- **Where:** Executive summary #3 — the free growth ceiling reads as a bug, not a paywall: 17 reviewers name the same number, 17%, Apr 2022 → Dec 2025 ('Glitches 🙄'; 'Fake Flowers'); support told them it was intentional; a one-line in-app explanation is the cheapest high-value fix
- **This app does:** silent progress ceiling at ~17% on the free tier
- **User reaction:** complaint
- **Magnitude:** 50 (1.30%, meaningful), mean 2.96; 17 name 17%, mean 3.00; Apr 2022 → Dec 2025
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8554382470`, `8935137072`, `9316992889`, `9339556961`, `9543524696`, `9551243735`, `9634054918`, `9715657325`, `9791630979`, `9987971914`, `10424061096`, `11114333413`, `11311247050`, `11543624190`, `11697507657`, `13116410045`, `13464035283`, `10370754063`, `13523628780`, `8571919972`
- **Canonical:** C133 Gate on capability, not on quantity; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R26-042 — Flower/garden not growing (verified)

- **Where:** §3.1 theme table Flower/garden not growing
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 50 (1.30%, meaningful), mean 2.96; 3★ 16
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C236 A free-tier limit must announce itself — never silently stop a visible progress signal

## Things not to do

### R26-122 — Do not reward reviews with cosmetic unlocks: it produces reviewers who say in writing that they have not used the app ('I'm just doing this to get the backgrounds 😋 I haven't even used the app at all'), doubles the share of contentless ≤25-character 5★ reviews to ~35%, makes the true rating unmeasurable, and carries App Store policy exposure

- **Where:** Warning #1 / §9.3 #1 — dont: never reward a review with an in-app unlock
- **This app does:** review-for-cosmetic reward
- **User reaction:** 5★-burst
- **Magnitude:** 13 explicit (floor); ≤25-char share 16.5% → 35.0%
- **Direction for us:** dont · **Report confidence:** weak (floor), high consequence · **Generalisable:** yes
- **Review IDs:** `12272181443`, `12132143279`, `13061382481`, `13965948642`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R26-123 — Do not withdraw a purchased one-time unlock when moving to a subscription model: seven buyers of the €6.99/$5–7 unlock said in Sept–Oct 2022 that it was taken away ('I consider that a breach of contract'), the grievance recurs for years, and it is why 'already paid, asked to pay again' is the top paid-user complaint

- **Where:** §2.2 / Executive summary #7 — dont: never withdraw a one-time unlock people already bought when the model changes
- **This app does:** revoked purchased unlock at repricing
- **User reaction:** 1★-burst
- **Magnitude:** 7 (Sept–Oct 2022) + 3 later
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9091405863`, `9171397848`, `9199616690`, `9100759613`, `9125973744`, `9126251428`, `9201257502`
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

## Things to do

### R26-015 — Cheapest unshipped wins: explain the 17% ceiling in-app → partial credit for partial completion → make the trial-to-charge sequence explicit and put cancellation in-app → fix 'already paid, asked to pay again' → allow backfill and a user-set day boundary → widen the free cap or time-box full access → fix the Russian/Chinese/Vietnamese payment rails → ship VoiceOver accessibility

- **Where:** Executive summary #10 — cheapest unshipped wins in evidence order
- **This app does:** none shipped as of Sep 2026
- **User reaction:** complaint
- **Magnitude:** report gives none (ranked list)
- **Direction for us:** do · **Report confidence:** summary ranking · **Generalisable:** yes
- **Review IDs:** `14231051461`
- **Canonical:** C010 Backfill missed days / edit start date; C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C033 Restore purchase and entitlements must work immediately; C109 A free trial must be a real trial; C147 Let people use the product before they pay; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size; C201 A user-set partial-completion threshold — a 'good day' below 100%; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R26-061 — Support praised — all 5★

- **Where:** §3.1 theme table Support praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 10 (0.26%, weak), mean 5.00
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R26-113 — F5: fix the payment rails in Russia, China and Vietnam — 16 reviews at mean 4.06, 8 Russian, are qualified buyers who cannot pay; the highest revenue-per-unit-effort item in the report

- **Where:** §9.1 F5 — fix the payment rails in RU / CN / VN; qualified buyers who cannot pay; highest revenue-per-unit-effort item
- **This app does:** no payment path
- **User reaction:** blocked-conversion
- **Magnitude:** 16, mean 4.06
- **Direction for us:** do · **Report confidence:** weak globally, high yield · **Generalisable:** yes
- **Review IDs:** `11145405840`, `11049310428`, `13287745467`, `12761795981`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK)

## Contradictions

### R26-124 — Internal contradiction: Eden is praised precisely for being gentle and streak-free ('when you break a streak you feel dispirited and give up'; 'motivation without the shame' — 25, mean 4.76) while its garden only grows on 100% daily completion, which engaged users call the opposite of self-growth (20, mean 2.80); partial credit reconciles the two

- **Where:** Executive summary #4 / §3.2 — contradiction inside the product: gentle, streak-free positioning (25, mean 4.76) vs an all-or-nothing daily reward rule (20, mean 2.80)
- **This app does:** gentle framing, punitive mechanic
- **User reaction:** mixed
- **Magnitude:** 25 (4.76) vs 20 (2.80)
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10056813574`, `13781551382`, `12599605564`, `12023585537`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R26-125 — Contradiction with the assumption that paywall complaints mean the price is too high: price-defenders outnumber price-objectors roughly 2:1 (57 vs 29) and 45 call the free tier generous, yet monetisation friction is 11.36% overall and 15.3% in high-spend markets (vs 8.7% elsewhere), where the app also rates lowest (4.489 vs 4.626) — the rich markets are willing to pay and frustrated by the trial design, not the price

- **Where:** §3.3 / §6.3 — contradiction with the 'freemium trackers are too expensive' reading: price-defenders outnumber price-objectors 2:1, yet the highest-ARPU markets rate lowest because of the free-tier gate
- **This app does:** cap + growth ceiling before evaluation
- **User reaction:** mixed
- **Magnitude:** 57 vs 29; friction 15.3% vs 8.7%; mean 4.489 vs 4.626
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8823685044`, `10378314260`, `11348756546`, `12157437413`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C064 Price level — where 'fair' turns into 'too expensive'; C147 Let people use the product before they pay

## Data caveats and method

### R26-002 — Method: 3,837/3,837 read in five passes (all 196 1–2★, all 208 3★, all 1,174 4–5★ over 80 chars, all 2,259 remaining), no sampling; multilingual regex taxonomy (ru/pt/es/de/fr/it/tr/vi/ja patterns; thin for zh/ko/th/ar/pl — aesthetic praise reads 3.12% in China vs 46–48% in Italy/Germany/Turkey, a coverage gap); classifier error measured not assumed — cap classifier 6.7% false positives on a 45-review sample, ~7% recall miss; seven negative themes exhaustively verified record-by-record with 32 false positives removed (flower_not_growing 56→50, all_or_nothing 30→20, no_backfill_midnight 32→29, no_stats_history 46→40, music_cannot_disable 19→16, support_unreachable 14→13, custom_habits_missing 11→8); ADHD respecified (87→81) after bare 'add' matched the verb; all counts are floors; no version field; corpus volume-uneven (2024 = 39.6%) with a collection gap in Dec 2025 (13) / Jan 2026 (10) — do not read that dip as a product event; 'paid evidence' 72 (1.88%) self-selecting, never infer conversion; 9 repeated title+body pairs across 38 records are independent short reviews, none removed; votes (91) and is_edited (74) too sparse to use; no external source consulted

- **Where:** How to read this; Eight warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Deduplication; §1.5 Classification method and measured error; §1.6 Limitations; §10.1 counting rules
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 3,837/3,837; 87 storefronts; 0 empty; 14 storefronts ≥50 = 3,227 (84.10%); substantive (>60 chars) n=1,791
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R26-004 — Reviews with a body of ≤25 characters rose from 20.9% of 2021–22 (87/416) and 16.5% of 2023 (90/547) to 35.0% of 2024 (532/1,521), 35.7% of 2025 (369/1,034) and 32.3% of 2026 (103/319), and 83–91% of them are 5★ in every era; every aggregate is restated for substantive reviews (>60 chars, n=1,791)

- **Where:** Warning #2 — short reviews nearly doubled: ≤25-char bodies 20.9% (2021–22) → 16.5% (2023) → 35.0% (2024) → 35.7% (2025) → 32.3% (2026), 83–91% of them 5★
- **This app does:** review reward + prompt
- **User reaction:** 5★-burst
- **Magnitude:** 20.9% → 16.5% → 35.0% → 35.7% → 32.3%; 83–91% 5★
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R26-016 — Rating distribution: 5★ 2,898 · 4★ 535 · 3★ 208 · 2★ 87 · 1★ 109; mean 4.5705; date range 2021-11-06 → 2026-09-06

- **Where:** §1.3 Coverage — rating distribution 5★ 2,898 · 4★ 535 · 3★ 208 · 2★ 87 · 1★ 109; computed mean 4.5705
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Check | Result ; Lines in reviews.jsonl | 3,837 ; Unique review_id | 3,837 (no ID duplication) ; Sum of all 87 by_country/*.jsonl | 3,837 — exact match ; manifest.json total_reviews | 3,837 — exact match ; Records with empty body | 0 ; Records with empty title | 0 ; Rating distribution vs manifest | 5★ 2,898 · 4★ 535 · 3★ 208 · 2★ 87 · 1★ 109 — exact match ; Computed mean vs manifest (4.57) | 4.5705 — match ; Date range | 2021-11-06 → 2026-09-06
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R26-017 — Classifier validation: cap precision 6.7% FP on 45; recall ~7% miss on 35; 7 negative themes exhaustively reviewed with 32 FPs removed; ADHD 87→81

- **Where:** §1.5 Validation table (verbatim)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Check | Method | Result ; cap_habit_limit precision | Random 45-review sample, manual read | 3 false positives = 6.7% ; cap_habit_limit recall | 35-review probe of unmatched reviews containing a paywall token | ~2–3 missed = ~7% under-count ; 7 negative themes | Exhaustive manual review of every match | 32 false positives removed; counts now exact for the matched set ; adhd_neuro | Re-specified after audit found bare \badd\b matching the verb "add" | 87 → 81 (2.11%)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R26-018 — Feature inventory with gating as reviewers report it

- **Where:** §2.1 Feature inventory table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Gating as reviewers report it | Evidence ; Daily habit/task checklist | Free, but capped (3 / 4 / 5 / 6 reported; 5 dominant) | 8233610259, 9186134212, 11801356965, 13840613528 ; Growing flower / garden | Free to ~17%, then gated | 8554382470, 9316992889, 9339556961, 9715657325 ; Multiple gardens (4 reported) | Paid | 9193385982, 10460446079, 12370205487, 13272780198 ; Background music / nature sounds | Free, several tracks; more paid | 11188463546, 12006559790, 10124533614 ; Background audio outside the app | Free | 8824331514, 10886909914, 11258319859 ; Daily quotes | Free | 9279698557, 10023340564, 13248521083 ; Themes / backgrounds / seasons / app icons | Partly free, more paid | 12079233152, 11801356965, 13272780198 ; Home-screen widget (garden view) | Free | 8794895153, 9462643279, 11626437199 ; Reminders / notifications | Free | 11239625943, 12356065455 ; Built-in timer | Free | 9186134212, 10056813574 ; "No wither" / Zen mode | Reported as premium by one reviewer | 11701576961, 10679138445, 11996446174 ; Day-of-week scheduling per habit | Free | 9740265256, 11189660127 ; Calendar / statistics | Absent for most of corpus; appears ~late 2024 | absent: 10006259845, 12204175553; added: 12244017370, 14227614235 ; Account / cloud sync | Absent throughout | 9052145225, 9280888384, 10958830676, 12042680917, 11655204052 ; Apple Watch app | Absent throughout | 8628572813, 9237768812, 10073204122, 11420767261
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R26-029 — Master theme table, denominator 3,837, with per-band counts

- **Where:** §3.1 Verified theme table (verbatim), 37 themes with per-star counts
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | Direction | n | % | Mean | 1★ | 2★ | 3★ | 4★ | 5★ | Signal ; Aesthetic / design praise | + | 1,068 | 27.83% | 4.64 | 10 | 20 | 61 | 165 | 812 | high-priority ; Music / calm / ambience praise | + | 559 | 14.57% | 4.68 | 8 | 8 | 25 | 72 | 446 | high-priority ; Simplicity / ease praise | + | 411 | 10.71% | 4.70 | 6 | 6 | 16 | 49 | 334 | high-priority ; Any monetisation gating | – | 436 | 11.36% | 3.42 | 63 | 51 | 82 | 121 | 119 | high-priority ; Paywall friction (general) | – | 281 | 7.32% | 3.55 | 31 | 30 | 55 | 83 | 82 | high-priority ; Garden-growth motivation praise | + | 229 | 5.97% | 4.68 | 2 | 4 | 10 | 33 | 180 | high-priority ; Free habit-count cap | – | 148 | 3.86% | 3.51 | 16 | 19 | 26 | 47 | 40 | very strong ; ADHD / autism / OCD self-ID | mixed | 81 | 2.11% | 3.84 | 5 | 8 | 15 | 20 | 33 | meaningful ; Explicit payer | mixed | 72 | 1.88% | 3.56 | 11 | 8 | 13 | 10 | 30 | meaningful ; Quotes praise | + | 58 | 1.51% | 4.74 | 0 | 1 | 3 | 6 | 48 | meaningful ; Defends the price | + | 57 | 1.49% | 4.18 | 5 | 4 | 5 | 5 | 38 | meaningful ; Garden/flower count cap | – | 53 | 1.38% | 3.13 | 5 | 10 | 17 | 15 | 6 | meaningful ; Flower/garden not growing | – | 50 | 1.30% | 2.96 | 9 | 10 | 16 | 4 | 11 | meaningful ; Praises the free tier | + | 45 | 1.17% | 4.49 | 2 | 1 | 3 | 6 | 33 | meaningful ; No statistics / history / calendar | – | 40 | 1.04% | 3.83 | 1 | 5 | 6 | 16 | 12 | meaningful ; Crash / launch failure | – | 33 | 0.86% | 2.79 | 12 | 4 | 3 | 7 | 7 | emerging ; Mental-health context | + | 32 | 0.83% | 4.66 | 0 | 2 | 1 | 3 | 26 | emerging ; Price objection | – | 29 | 0.76% | 2.76 | 9 | 3 | 4 | 12 | 1 | emerging ; No backfill / day boundary | – | 29 | 0.76% | 3.03 | 6 | 1 | 11 | 8 | 3 | emerging ; Praises gentleness / no streak | + | 25 | 0.65% | 4.76 | 0 | 0 | 1 | 4 | 20 | emerging ; Teen / child / student | + | 25 | 0.65% | 4.16 | 1 | 0 | 4 | 9 | 11 | emerging ; Purchase lost / not delivered | – | 24 | 0.63% | 2.71 | 7 | 4 | 6 | 3 | 4 | emerging ; Trial / billing dispute | – | 23 | 0.60% | 1.48 | 17 | 3 | 2 | 0 | 1 | emerging ; Widget (mentions) | mixed | 21 | 0.55% | 4.14 | 0 | 2 | 3 | 6 | 10 | emerging ; All-or-nothing reward rule | – | 20 | 0.52% | 2.80 | 4 | 4 | 6 | 4 | 2 | emerging ; Reorder / group / per-habit garden | – | 18 | 0.47% | 4.06 | 0 | 2 | 2 | 7 | 7 | weak ; Music fault (can't disable / won't play) | – | 16 | 0.42% | 2.94 | 5 | 2 | 3 | 1 | 5 | weak ; Cannot complete purchase | – | 16 | 0.42% | 4.06 | 1 | 2 | 2 | 1 | 10 | weak ; Flexible recurrence (N×/week) | – | 12 | 0.31% | 3.50 | 2 | 1 | 1 | 5 | 3 | weak ; Review incentivised by unlock | ⚠ | 13 | 0.34% | 4.77 | 0 | 0 | 0 | 3 | 10 | weak ; Support unreachable | – | 13 | 0.34% | 2.77 | 4 | 2 | 1 | 5 | 1 | weak ; Support praised | + | 10 | 0.26% | 5.00 | 0 | 0 | 0 | 0 | 10 | weak ; Custom habits not creatable | – | 8 | 0.21% | 2.50 | 3 | 1 | 2 | 1 | 1 | weak ; Apple Watch requested | – | 8 | 0.21% | 4.00 | 0 | 1 | 1 | 3 | 3 | weak ; Multi-count per day | – | 7 | 0.18% | 4.14 | 0 | 0 | 2 | 2 | 3 | weak ; No sync / no account | – | 7 | 0.18% | 3.57 | 1 | 0 | 2 | 2 | 2 | weak ; Accessibility (incl. VoiceOver) | – | 5 | 0.13% | 4.00 | 0 | 0 | 2 | 1 | 2 | weak
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R26-071 — Unmet needs ranked: statistics/history/calendar per habit 40 (1.04%); backfill previous day / configurable day boundary 29 (0.76%); partial credit 20 (0.52%); reorder habits / per-habit gardens / categories 18 (0.47%); flexible recurrence ('3× per week'), vacation mode 12 (0.31%); Apple Watch 8; multi-count per day (5 glasses of water, 10 pages) 7; account / cloud sync 7; interactive widget ~5; journal / gratitude note ~4

- **Where:** §3.4 Unmet needs table (verbatim) — stats/history/calendar 40; backfill/day boundary 29; partial credit 20; reorder/per-habit gardens/categories 18; flexible recurrence/vacation 12; Watch 8; multi-count 7; account/sync 7; interactive widget ~5; journal/gratitude ~4
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Rank | Need | n | % | Signal | Representative IDs ; 1 | Statistics / history / calendar per habit | 40 | 1.04% | meaningful | 8558719429, 8836532479, 8933857624, 9085912312, 9441258136, 9509282059, 9843813677, 10006259845, 10282667264, 11497891805, 12104864958, 12251741381, 12265166141, 14443983125, 14477621410 ; 2 | Backfill previous day / configurable day boundary | 29 | 0.76% | emerging | 8874333151, 8875094753, 9274330602, 9449546415, 10108096197, 11176218907, 12104864958, 12137473742, 12531678334, 12646839757, 13080138566, 13819651033 ; 3 | Partial credit for partial completion | 20 | 0.52% | emerging | 8885523614, 10573227883, 10646722648, 10748238279, 12023585537, 12599605564, 12811356742 ; 4 | Reorder habits / per-habit gardens / categories | 18 | 0.47% | weak | 8628572813, 8772022784, 8807578550, 8999474738, 10206828410, 11189660127, 11873650347, 12057271899, 12932219546, 14317196415, 14468283183 ; 5 | Flexible recurrence ("3× per week"), vacation mode | 12 | 0.31% | weak | 8296733263, 8999474738, 9267531151, 9846065416, 11563266717, 12263431554, 12520372421, 12629745864 ; 6 | Apple Watch app | 8 | 0.21% | weak | 8628572813, 9237768812, 10028179642, 10073204122, 10661938586, 10828145441, 10970096330, 11420767261 ; 7 | Multi-count per day (5 glasses of water, 10 pages) | 7 | 0.18% | weak | 9906136301, 10388741373, 11370282796, 12254996375, 12404001288 ; 8 | Account / cloud sync across devices | 7 | 0.18% | weak | 9052145225, 9280888384, 10958830676, 11162718591, 11655204052, 12042680917, 13358263218 ; 9 | Interactive widget (tick from home screen) | ~5 | 0.13% | weak | 9608846258, 10103075953, 12254996375, 13648793040, 14468283183 ; 10 | Journal / gratitude note | ~4 | 0.10% | weak | 8475403176, 9085913110, 11932654664, 12921283639
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `8558719429`, `8836532479`, `8933857624`, `9085912312`, `9441258136`, `9509282059`, `9843813677`, `10006259845`, `10282667264`, `11497891805`, `12104864958`, `12251741381`, `12265166141`, `14443983125`, `14477621410`, `8874333151`, `8875094753`, `9274330602`, `9449546415`, `10108096197`, `11176218907`, `12137473742`, `12531678334`, `12646839757`, `13080138566`, `13819651033`, `8628572813`, `8772022784`, `8807578550`, `8999474738`, `10206828410`, `11189660127`, `11873650347`, `12057271899`, `12932219546`, `14317196415`, `14468283183`, `8296733263`, `9267531151`, `9846065416`, `11563266717`, `12263431554`, `12520372421`, `12629745864`, `9237768812`, `10028179642`, `10073204122`, `10661938586`, `10828145441`, `10970096330`, `11420767261`, `9906136301`, `10388741373`, `11370282796`, `12254996375`, `12404001288`, `9052145225`, `9280888384`, `10958830676`, `11162718591`, `11655204052`, `12042680917`, `13358263218`, `9608846258`, `10103075953`, `13648793040`, `8475403176`, `9085913110`, `11932654664`, `12921283639`
- **Canonical:** — (nuance register)

### R26-077 — Per-band dominant themes: 5★ 2,898 (75.53%) aesthetic 812 · music 446 · simplicity 334 · garden 180 · paywall 82; 4★ 535 (13.94%) aesthetic 165 · paywall 83 · habit cap 47; 3★ 208 (5.42%) aesthetic 61 · paywall 55 · cap 26 · garden cap 17 · flower not growing 16 · backfill 11; 2★ 87 (2.27%) paywall 30 · aesthetic 20 · cap 19 · flower not growing 10; 1★ 109 (2.84%) paywall 31 · billing 17 · cap 16 · crash 12 · payer 11 · price 9 · flower not growing 9

- **Where:** Part 4 Ratings table (verbatim) — dominant themes per band
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Rating | n | % of corpus | Dominant themes (count within band) ; 5★ | 2,898 | 75.53% | aesthetic 812 · music 446 · simplicity 334 · garden motivation 180 · paywall 82 · quotes 48 · defends price 38 ; 4★ | 535 | 13.94% | aesthetic 165 · paywall 83 · music 72 · simplicity 49 · habit cap 47 · garden motivation 33 · no stats 16 ; 3★ | 208 | 5.42% | aesthetic 61 · paywall 55 · habit cap 26 · music 25 · garden cap 17 · flower not growing 16 · backfill 11 ; 2★ | 87 | 2.27% | paywall 30 · aesthetic 20 · habit cap 19 · garden cap 10 · flower not growing 10 · no stats 5 ; 1★ | 109 | 2.84% | paywall 31 · billing dispute 17 · habit cap 16 · crash 12 · explicit payer 11 · price 9 · flower not growing 9
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R26-083 — A handful of reviews carry positive text with a 1–2★ rating ('Me encanta 😍' 1★; 'очень крутое приложение' 1★; 'perfect app!!' 2★) and are left at their stated rating — do not treat star rating alone as a preference signal

- **Where:** §4.1 Rating/text mismatches disclosed — positive text with 1–2★ ('Me encanta 😍' 1★; 'perfect app!!' 2★) left at stated rating; do not treat star rating alone as a preference signal
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5 named
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `11707621415`, `13338337959`, `12271851798`, `14098241981`, `13123175238`
- **Canonical:** — (nuance register)

### R26-121 — Research questions: what the review-reward mechanism does to the rating (13 volunteer it; the ≤25-char share doubled to ~35% when it appears to have been introduced; true 5★ inflation unmeasurable; App Store policy exposure); do impulse buyers retain (cross-reference time-to-purchase with 30/90-day retention and refunds); why payer satisfaction is flat at ~3.5 across five years while the corpus rose 4.34 → 4.68; is Russia's low paywall friction a pricing effect or a payment-availability effect (if users cannot reach the paywall, low friction is not satisfaction); did a statistics/calendar feature ship and is 2026 a regression or discoverability failure; would a rewarded-ad unlock path work for the under-18 segment without damaging the no-ads praise

- **Where:** §9.3 Research questions Part 9 #1, Part 9 #2, Part 9 #3, Part 9 #4, Part 9 #5, Part 9 #6 — what the review-reward mechanism does to the rating (App Store policy exposure); do impulse buyers retain; why payer satisfaction is flat at ~3.5 while the corpus rose; is Russia's low friction a pricing or payment-availability effect; did stats ship and is 2026 a regression or discoverability; would a rewarded-ad unlock work for under-18s
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (questions)
- **Direction for us:** research · **Report confidence:** open questions · **Generalisable:** yes
- **Canonical:** — (nuance register)
