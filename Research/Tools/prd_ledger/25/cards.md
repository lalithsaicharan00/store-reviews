# Cards — report 25

Source: `App Store Reports/25. Grit - Daily Habit Tracker - Routines & Goals ADHD Planner (REPORT).md`  
196 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 9
- [Must-haves](#must-haves) — 2
- [Must never break](#must-never-break) — 29
- [Features](#features) — 36
- [Monetization](#monetization) — 17
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 19
- [Audiences](#audiences) — 4
- [Markets and languages](#markets-and-languages) — 21
- [Dated events and trends](#dated-events-and-trends) — 14
- [Positioning](#positioning) — 8
- [Anti-patterns](#anti-patterns) — 3
- [Things not to do](#things-not-to-do) — 7
- [Things to do](#things-to-do) — 5
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 19

## Product rules

### R25-034 — From November 2025 editing an existing habit — including the starter habits the onboarding creates — is reported as paid ('Tengo 3 hábitos, y ya ni siquiera me deja editarlos'; 'You need to get the premium to edit habits (even the ones they start you out with)'); five 1–2★ reviews, zero before Nov 2025 — weak by rate, high by consequence: the free tier stops being a reduced product and becomes a demo; flagged as a verification question, not a confirmed regression

- **Where:** §2.1 / §2.3 Habit editing — reported as paid from Nov 2025, including the starter habits onboarding creates: 'You need to get the premium to edit habits (even the ones they start you out with)'
- **This app does:** editing gated behind premium (2025-11+)
- **User reaction:** 1★-burst
- **Magnitude:** 5 (0.38%, weak), all 1–2★, all after Nov 2025
- **Direction for us:** product-rule · **Report confidence:** weak-by-rate, high-by-consequence · **Generalisable:** yes
- **Review IDs:** `13428241426`, `13585132870`, `14339204663`, `14277782327`, `14067453636`
- **Canonical:** C133 Gate on capability, not on quantity; C200 Never meter the completion action — a free cap may limit habits, never check-offs; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R25-093 — Price level and price fairness are net positives for this product; the paywall's position — at habit 4, before any statistics, with editing also gated — is the liability; a reader should not conclude 'lower the price'

- **Where:** §3.3 Interpretation — price level and fairness are net positives; the paywall's position (habit 4, before any statistics, editing gated) is the liability; do not conclude 'lower the price'
- **This app does:** gate placement, not price
- **User reaction:** mixed
- **Magnitude:** 64 praise vs 55 object; ~31 of 55 are gate objections
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R25-111 — The core argument: the cap prevents a purchase decision, not just usage — 'at least give a free trial period to get to know it'

- **Where:** §4.2 (b) The evaluation problem — the cap prevents a purchase decision, not just usage ('mínimo den un periodo de prueba gratis para conocerla')
- **This app does:** no evaluable free tier
- **User reaction:** blocked-conversion
- **Magnitude:** 8 representative reviews
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13392619767`, `13557314925`, `13927978729`, `12609243324`, `13785386255`, `11676088428`, `14483086667`, `13607697398`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R25-164 — A 3-habit free cap on a 'plan your whole day' product generates more 1★ reviews than every feature defect combined — 169 of 302 one-star reviews; any competitor offering 8–10 free habits can quote this corpus as its positioning

- **Where:** Part 10 #1 — a 3-habit free cap on a 'plan your whole day' product generates more 1★ reviews than every feature defect combined (169 of 302); a competitor offering 8–10 free habits can quote this corpus as positioning
- **This app does:** 3-habit cap
- **User reaction:** 1★-burst
- **Magnitude:** 169 of 302 1★ (56.0%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R25-171 — Statistics behind a paywall removes the motivation loop the category sells — five reviewers name it and one explains it exactly: for someone at rock bottom, free statistics are the motivation

- **Where:** Part 10 #8 — statistics behind a paywall removes the motivation loop the category sells: for someone at rock bottom, free statistics are the motivation
- **This app does:** stats paywalled
- **User reaction:** 1★-burst
- **Magnitude:** 5, mean 1.40
- **Direction for us:** free · **Report confidence:** weak, high consequence · **Generalisable:** yes
- **Review IDs:** `13636020247`
- **Canonical:** C011 Weekly / monthly / yearly reports; C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells

### R25-177 — Raise or time-box the cap — the corpus names its own acceptable number (8–10 habits) or full access for a fixed window; the argument to answer is not 'make it free' but 'let me see what I'd be buying'; 138 cap reviews, 163 general-paywall reviews and 64 price-praise reviews say the price itself is not the obstacle

- **Where:** §11.2 Part 11 #5 — raise or time-box the cap: the corpus names its own acceptable number, 8–10 habits, or full access for a fixed window; the argument is 'let me see what I'd be buying', not 'make it free'
- **This app does:** 3-habit cap
- **User reaction:** blocked-conversion
- **Magnitude:** 138 + 163; 64 praise; median acceptable 8–10
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R25-178 — Unlock statistics read-only on the free tier — mean 1.40 on the reviews that name it; it is the feature that makes the product motivating, and gating it removes the reason to upgrade rather than creating one

- **Where:** §11.2 Part 11 #6 — unlock statistics read-only on the free tier; gating it removes the reason to upgrade rather than creating one
- **This app does:** stats paywalled
- **User reaction:** 1★-burst
- **Magnitude:** 5, mean 1.40
- **Direction for us:** free · **Report confidence:** weak, high consequence · **Generalisable:** yes
- **Canonical:** C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells

### R25-179 — Never gate editing of habits the onboarding created — 5 reviews, mean 1.20, all after Nov 2025; if real, this makes the free tier a demo and is almost certainly net-negative on conversion

- **Where:** §11.2 Part 11 #7 — never gate editing of habits the onboarding created; if real, this makes the free tier a demo and is almost certainly net-negative on conversion
- **This app does:** editing gated
- **User reaction:** 1★-burst
- **Magnitude:** 5, mean 1.20
- **Direction for us:** product-rule · **Report confidence:** weak-by-rate, high-by-consequence · **Generalisable:** yes
- **Canonical:** C133 Gate on capability, not on quantity; C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R25-181 — Move the paywall to after first value, not after the onboarding survey — 6 reviews at mean 1.17 describe spending 5–10 minutes on a questionnaire and being charged at the end of it

- **Where:** §11.2 Part 11 #9 — move the paywall to after first value, not after the onboarding survey
- **This app does:** survey → paywall
- **User reaction:** 1★-burst
- **Magnitude:** 6, mean 1.17
- **Direction for us:** product-rule · **Report confidence:** weak, high consequence · **Generalisable:** yes
- **Canonical:** C137 Show the paywall at the moment of need, not on app open; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

## Must-haves

### R25-174 — Add a first-run failure escape hatch — four reviewers say reinstalling does not help and then delete the app; a 'skip setup / continue offline' path and a visible error state would convert some of those into support tickets instead of 1★ reviews

- **Where:** §11.1 Part 11 #2 — add a first-run failure escape hatch: 'skip setup / continue offline' and a visible error state, converting 1★ reviews into support tickets
- **This app does:** no escape from a stuck first run
- **User reaction:** 1★-burst
- **Magnitude:** 4 reinstall-fails
- **Direction for us:** must-have · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C188 The app must open offline — never block launch on a network call; C235 A first-run failure escape hatch — skip setup / continue offline, with a visible error state

### R25-183 — Put subscription management in the app — two reviewers could not find it and one asked publicly whether its absence is legal

- **Where:** §11.3 Part 11 #11 — put subscription management in the app; one asked publicly whether its absence is legal
- **This app does:** no in-app subscription management
- **User reaction:** complaint
- **Magnitude:** 2–3
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12250584386`
- **Canonical:** C112 In-app cancellation

## Must never break

### R25-008 — An un-fixed launch/interaction blocker is the fastest-growing negative theme: the app freezes on or just after the onboarding screen and the main screen stops responding to touch — iPhone 11, iPhone 14 Pro Max, iPhone 16 Pro / iOS 26.5, iOS 26.1; one reviewer says the freeze survived two updates over a month

- **Where:** Executive summary #4 — an un-fixed launch/interaction blocker is the fastest-growing negative theme: freezes on or after onboarding, main screen stops responding to touch; 1.3% → 2.9% → 5.8%
- **This app does:** freeze at onboarding / unresponsive touch
- **User reaction:** 1★-burst
- **Magnitude:** 51 (3.90%, very strong), mean 1.63, 33 1★; 1.3% (E1) → 2.9% (E2) → 5.8% (E3)
- **Direction for us:** must-never-break · **Report confidence:** very strong, rising · **Generalisable:** yes
- **Review IDs:** `14156928722`, `14228794250`, `14269477606`, `13970830961`, `14102414142`, `14065834606`, `13448927787`, `14147118069`, `13637569981`, `14021915764`, `14112998455`, `14183996590`, `14262738292`, `14308159391`, `14312587468`, `14097129502`, `14336842171`, `14121146392`, `14049857126`
- **Canonical:** C031 Crashes / launch failures; C235 A first-run failure escape hatch — skip setup / continue offline, with a visible error state

### R25-010 — Billing disputes are a dated, growing, reputationally expensive cluster (~5× step after 2024): a 7-day trial renews into the annual plan rather than the plan the user chose, a charge lands during the trial window, a charge arrives with no recollection of consent, and two reviewers could not find subscription settings in-app at all

- **Where:** Executive summary #6 — billing disputes are a dated, growing cluster: 0.8% → 3.9% → 3.9%; a 7-day trial renews into the annual plan rather than the plan chosen; charged during the trial; no recollection of consent; subscription settings not findable in-app
- **This app does:** trial → annual auto-convert; no in-app subscription management
- **User reaction:** 1★-burst
- **Magnitude:** 44 (3.36%, very strong), mean 1.59, 32 1★; 0.8% (E1) → 3.9% (E2) → 3.9% (E3)
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13431450922`, `14075475519`, `13749925993`, `13588325969`, `13926135435`, `12470598228`, `12956024975`, `13424912655`, `14512117424`, `13608769744`, `13860427881`, `12250584386`, `12941350904`
- **Canonical:** C109 A free trial must be a real trial; C112 In-app cancellation; C163 Visible monthly plan — annual-default trials drive billing disputes

### R25-052 — Launch / interaction blocker

- **Where:** §3.1 theme table #10 Launch / interaction blocker (freeze, unresponsive)
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 51 (3.90%, very strong), mean 1.63, 5★ 1, 1★ 33
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R25-054 — Billing dispute / unwanted charge / refund

- **Where:** §3.1 theme table #12 Billing dispute / unwanted charge / refund
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 44 (3.36%, very strong), mean 1.59, 1★ 32
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial

### R25-058 — Bug / glitch / error (generic)

- **Where:** §3.1 theme table #16 Bug / glitch / error (generic)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 33 (2.52%, meaningful), mean 3.09
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R25-072 — Sync between devices failing

- **Where:** §3.1 theme table #30 Sync between devices failing
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 14 (1.07%, meaningful), mean 3.29
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it

### R25-073 — Data loss / reset

- **Where:** §3.1 theme table #31 Data loss / reset
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 12 (0.92%, emerging), mean 3.00
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R25-075 — Lag / slowness

- **Where:** §3.1 theme table #33 Lag / slowness
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 10 (0.76%, emerging), mean 3.80
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C083 Performance must not degrade with habit count

### R25-078 — Apple Health data wrong / incomplete

- **Where:** §3.1 theme table #36 Apple Health data wrong / incomplete
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 9 (0.69%, emerging), mean 3.33
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration; C072 Writes to shared system stores (calendar, health) must be exact and reversible

### R25-079 — Already paid, asked to pay again

- **Where:** §3.1 theme table #37 Already paid, asked to pay again
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 8 (0.61%, emerging), mean 1.50, 5★ 0, 1★ 5
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R25-083 — Over-achievement / carry-over behaviour wrong

- **Where:** §3.1 theme table #41 Over-achievement / carry-over behaviour wrong
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 7 (0.53%, emerging), mean 3.29
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C019 Quit-habit / bad-habit mode; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R25-101 — Broken existing capabilities: cross-device sync not updating (14, 1.07%); data loss / reset to zero (12); habit/group order resets itself (5); Apple Health values wrong — steps off by 568, weight read as an entry-count, running only in minutes (9); widget stopped working / not interactive / font fixed (6); archive/delete destroys history (4); over-achievement carries into the next day or rewards a bad habit at 200% (7); Watch app removed / limited / date lags / advertised on the listing but not installable (5); notifications wrong or silent (3); Vision Pro support withdrawn (1)

- **Where:** §3.5 Broken table (verbatim) — sync not updating 14; data loss 12; order resets 5; Health values wrong 9 (steps off by 568, weight read as entry-count); widget stopped/not interactive/font fixed 6; archive/delete destroys history 4; over-achievement carries over / rewards a bad habit at 200% 7; Watch removed/limited/advertised but not installable 5; notifications 3; Vision Pro withdrawn 1
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Problem | n | % | Signal | Evidence ; Launch / interaction blocker | 51 | 3.90% | very strong | Part 4.1 ; Cross-device sync not updating | 14 | 1.07% | meaningful | 10774713901, 11451647276, 12127905359, 13766076691, 14443285061, 14051521559 ; Data loss / reset to zero | 12 | 0.92% | emerging | 11792724852, 12184884069, 12611547585, 13602107796, 13605590169, 13957262391, 14283671611, 14422160795 ; Habit/group order resets itself | 5 | 0.38% | weak | 12657367016, 12658607281, 12762998535, 13346806948 ; Apple Health values wrong (steps off by 568; weight read as entry-count; running only in minutes) | 9 | 0.69% | emerging | 11278083369, 13502878041, 12918071192, 12158005240, 13925995344, 11154294245 ; Widget stopped working / not interactive / font fixed | 6 | 0.46% | weak | 11845505516, 11841522005, 11504006411, 13410996727, 12377678039, 12030551048 ; Archive/delete destroys history | 4 | 0.31% | weak | 10971903648, 12201042880, 12697696657 ; Over-achievement carries into the next day / rewards a bad habit at 200% | 7 | 0.53% | emerging | 14074498392, 12778092747, 14277782327, 13195716771, 11066420925 ; Apple Watch app removed / limited / date lags | 5 | 0.38% | weak | 13316944137, 12013649134, 12659238964, 14051521559, 12865760230 (Watch advertised on the listing but not installable) ; Notifications wrong or silent | 3 | 0.23% | weak | 12575813099, 12580317312, 12720268465 ; Vision Pro support withdrawn | 1 | 0.08% | ignore | 13531929434
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `10774713901`, `11451647276`, `12127905359`, `13766076691`, `14443285061`, `14051521559`, `11792724852`, `12184884069`, `12611547585`, `13602107796`, `13605590169`, `13957262391`, `14283671611`, `14422160795`, `12657367016`, `12658607281`, `12762998535`, `13346806948`, `11278083369`, `13502878041`, `12918071192`, `12158005240`, `13925995344`, `11154294245`, `11845505516`, `11841522005`, `11504006411`, `13410996727`, `12377678039`, `12030551048`, `10971903648`, `12201042880`, `12697696657`, `14074498392`, `12778092747`, `14277782327`, `13195716771`, `11066420925`, `13316944137`, `12013649134`, `12659238964`, `14051521559`, `12865760230`, `12575813099`, `12580317312`, `12720268465`, `13531929434`
- **Canonical:** C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C040 Widgets must not go blank, stale or disagree with the app; C041 Editing a habit never wipes its history; C073 Manual reordering, renaming and editing of habits/tasks — free

### R25-102 — Over-achievement carries into the next day, and logging a bad habit at 200% is rewarded as success — the carry-over and bad-habit arithmetic are wrong

- **Where:** §3.5 Over-achievement carries into the next day / a bad habit logged at 200% is rewarded
- **This app does:** carry-over arithmetic wrong
- **User reaction:** complaint
- **Magnitude:** 7 (0.53%, emerging), mean 3.29
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `14074498392`, `12778092747`, `14277782327`, `13195716771`, `11066420925`
- **Canonical:** C019 Quit-habit / bad-habit mode; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R25-103 — The Watch app was reported removed or limited, advertised on the listing but not installable, and Vision Pro support was withdrawn

- **Where:** §3.5 Apple Watch advertised on the listing but not installable; Watch app removed / limited; Vision Pro support withdrawn
- **This app does:** platform surfaces withdrawn
- **User reaction:** complaint
- **Magnitude:** 5 (0.38%) + 1
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13316944137`, `12013649134`, `12659238964`, `14051521559`, `12865760230`, `13531929434`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R25-107 — The launch blocker is specifically post-onboarding: the user completes the questionnaire, reaches the main screen, and it does not respond to touch ('the Let's go button is unresponsive'; 'Sofort nach dem set up ist sie komplett eingefroren… Zwei mal gelöscht und neu installiert. Nichts geht.'); four say reinstalling does not fix it and one names iCloud sync as the stuck state — pointing at a first-run data/iCloud path rather than rendering; the only negative theme whose rate more than quadruples, it lands on brand-new users, and it survived two release cycles

- **Where:** §4.1 Cluster 1 — the launch blocker: post-onboarding main screen does not respond to touch, consistent across nine languages; reinstalling does not fix it; one names iCloud sync as the stuck state
- **This app does:** first-run freeze, likely iCloud path
- **User reaction:** 1★-burst
- **Magnitude:** 51 (3.90%), mean 1.63, 33 1★, 9 2★; 1.3% → 2.9% → 5.8% (high-priority within E3)
- **Direction for us:** must-never-break · **Report confidence:** very strong, rising · **Generalisable:** yes
- **Review IDs:** `14156928722`, `14097129502`, `13637569981`, `14183996590`, `14121146392`, `14147118069`
- **Canonical:** C031 Crashes / launch failures; C188 The app must open offline — never block launch on a network call; C235 A first-run failure escape hatch — skip setup / continue offline, with a visible error state

### R25-115 — Billing mechanisms: trial renews into the annual plan not the plan chosen (~6: 'You can't choose to be renewed to the 1 month subscription'; 'charged 25,000 pesos when I had chosen the monthly option'); charged during the trial window (~5: 'it says cost 0 in the trial selector and they charged me 1,500 pesos'); charge with no recalled consent / card linked at install (~7: 'when I changed my card on my Apple account it suddenly charged a whole year'); amount charged ≠ displayed (~3: $24.99 shown, $42 charged; €29.99 lifetime then two further €6.99 charges); cannot find cancel / subscription settings (~3: 'I looked for five minutes… Is that even legal?'); refund requested/refused (~6); accidental purchase from a notification (1)

- **Where:** §4.3 Cluster 3 — billing mechanisms table (verbatim): trial → annual not chosen plan ~6; charged during trial ~5; no recalled consent / card linked at install ~7; amount ≠ displayed ~3; cannot find cancel ~3; refund refused ~6; accidental purchase from a notification 1
- **This app does:** trial→annual mapping; no in-app subscription management
- **User reaction:** 1★-burst
- **Magnitude:** Mechanism | n (manual) | Evidence ; Trial renews into the annual plan, not the plan chosen | ~6 | 13431450922 ("You can't chose to be renewed to the 1 month subskription"), 14075475519, 13749925993, 13731572727 ("Me cobraron 25mil pesos cuando yo habia elegido la opción de hacer un pago mensual"), 14177608913, 13424912655 ; Charged during the trial window | ~5 | 13588325969, 13926135435 ("Sale costo 0 en el selector para prueba gratuita y me cobraron 1500 pesos"), 12470598228, 13150343490, 12774315241 ; Charge with no recalled consent / card linked at install | ~7 | 12956024975, 13608769744, 13860427881, 14512117424 ("Cuándo cambié mi tarjeta de la cuenta de Apple se cobró repentinamente todo un año"), 12532935939, 12473482266, 14347782489 ; Amount charged ≠ amount displayed | ~3 | 12386056078 ($24.99 shown, $42 charged), 13605686247 (€29.99 lifetime then two further €6.99 charges), 13831002940 ; Cannot find cancel / subscription settings | ~3 | 12250584386 ("I looked for five minutes and couldn't find the subscription settings in the app. Is that even legal?"), 12941350904, 13830108707 ; Refund requested / refused | ~6 | 12532935939, 12774315241, 13528421192, 13728803756, 14379122842, 12470598228 ; Accidental purchase from a notification | 1 | 14329860383 ; 44 (3.36%), mean 1.59, 32 1★; 0.8% → 3.9% → 3.9%
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13431450922`, `14075475519`, `13749925993`, `13731572727`, `14177608913`, `13424912655`, `13588325969`, `13926135435`, `12470598228`, `13150343490`, `12774315241`, `12956024975`, `13608769744`, `13860427881`, `14512117424`, `12532935939`, `12473482266`, `14347782489`, `12386056078`, `13605686247`, `13831002940`, `12250584386`, `12941350904`, `13830108707`, `13528421192`, `13728803756`, `14379122842`, `14329860383`
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial; C112 In-app cancellation; C113 One stable, disclosed price — no discount wheels; C163 Visible monthly plan — annual-default trials drive billing disputes

### R25-116 — Already paid, asked to pay again: 8 reviews across a 16-month window (Mar 2025 → Jul 2026) — 'every time I enter the app it tells me to remove them or to buy the subscription to keep my habits'; 'this is the second time this has happened'; 'I've tried restoring my purchase, but it still doesn't recognize my lifetime subscription' — emerging by rate, severe by kind: it attacks booked revenue and the persistence argues against a one-off outage; checkable against StoreKit logic

- **Where:** §4.3 Already-paid-asked-to-pay-again — 8 across a 16-month window (Mar 2025 → Jul 2026): 'every time I enter the app it tells me to remove them or buy the subscription to keep my habits'; 'restoring my purchase still doesn't recognize my lifetime subscription'
- **This app does:** entitlement not recognised; lifetime purchase lost
- **User reaction:** 1★-burst
- **Magnitude:** 8 (0.61%, emerging), mean 1.50, 0 5★; 16-month window
- **Direction for us:** must-never-break · **Report confidence:** emerging, severe · **Generalisable:** yes
- **Review IDs:** `12379398566`, `12473304418`, `13128982971`, `13178225257`, `13184003965`, `13528421192`, `13599650667`, `14355199654`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R25-132 — Within the 57 payers: billing dispute/refund 8 (14.0%, mean 1.12); purchase no longer recognised 5 (8.8%, 1.40); reliability failure after paying 5 (8.8%, 1.80); feature gap but still positive 4 (7.0%, 4.50); explicit praise 24 (42.1%, 4.38) — segment rates on a 57-review denominator

- **Where:** §6.5 What goes wrong after payment (verbatim table) — billing 14.0% (1.12); purchase not recognised 8.8% (1.40); reliability after paying 8.8% (1.80); feature gap 7.0% (4.50); explicit praise 42.1% (4.38)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Problem | n (within 57 payers) | % of payers | Mean | Evidence ; Billing dispute / refund | 8 | 14.0% | 1.12 | 12386056078, 12473304418, 13299143006, 13731572727, 14177608913, 14379122842 ; Purchase no longer recognised | 5 | 8.8% | 1.40 | 12379398566, 13178225257, 13184003965, 13599650667, 14355199654 ; Reliability failure after paying | 5 | 8.8% | 1.80 | 12315242035, 13358500440, 14132304435, 13728803756, 12445721095 ; Feature gap (asked for, still positive) | 4 | 7.0% | 4.50 | 12682799984, 13162425122, 12152603849 ; Explicit praise | 24 | 42.1% | 4.38 | 11694650718, 13093563693, 13811962013, 14139271437
- **Direction for us:** must-never-break · **Report confidence:** meaningful; small n · **Generalisable:** yes
- **Review IDs:** `12386056078`, `12473304418`, `13299143006`, `13731572727`, `14177608913`, `14379122842`, `12379398566`, `13178225257`, `13184003965`, `13599650667`, `14355199654`, `12315242035`, `13358500440`, `14132304435`, `13728803756`, `12445721095`, `12682799984`, `13162425122`, `12152603849`, `11694650718`, `13093563693`, `13811962013`, `14139271437`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C139 Cache entitlements locally — never block a paid surface on a live server check

### R25-133 — Three independent reports in three storefronts say the app stopped working immediately after payment — two French 1★ three weeks apart, and a Dutch 1★ a week after an annual purchase — specific enough to reproduce against the entitlement code path

- **Where:** §6.5 The sharpest single data point — three independent reports in three storefronts (fr, fr, nl) that the app stopped working immediately after payment
- **This app does:** breaks right after purchase
- **User reaction:** 1★-burst
- **Magnitude:** 3 reviews, 3 storefronts
- **Direction for us:** must-never-break · **Report confidence:** limited evidence, specific · **Generalisable:** yes
- **Review IDs:** `13358500440`, `13299143006`, `12315242035`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C139 Cache entitlements locally — never block a paid surface on a live server check

### R25-173 — Reproduce and fix the post-onboarding freeze — start with iPhone 11 and iOS 26.x and the iCloud-sync-stuck state; 51 reviews, mean 1.63, rate quadrupling, Colombia 18%, Germany 7.8%; every one of these users got zero value

- **Where:** §11.1 Part 11 #1 — reproduce and fix the post-onboarding freeze; start with iPhone 11 / iOS 26.x and the iCloud-sync-stuck state
- **This app does:** first-run freeze
- **User reaction:** 1★-burst
- **Magnitude:** 51, mean 1.63
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `14097129502`
- **Canonical:** C031 Crashes / launch failures

### R25-175 — Fix purchase recognition — 8 reviews over 16 months say a completed purchase, including lifetime, stopped being honoured; audit the entitlement/restore path

- **Where:** §11.1 Part 11 #3 — fix purchase recognition; audit the entitlement/restore path; 14355199654 is a clean repro
- **This app does:** entitlement lost
- **User reaction:** 1★-burst
- **Magnitude:** 8 over 16 months
- **Direction for us:** must-never-break · **Report confidence:** emerging, severe · **Generalisable:** yes
- **Review IDs:** `14355199654`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R25-176 — Investigate the three independent 'broke right after payment' reports

- **Where:** §11.1 Part 11 #4 — investigate the three independent 'broke right after payment' reports
- **This app does:** post-purchase breakage
- **User reaction:** 1★-burst
- **Magnitude:** 3
- **Direction for us:** must-never-break · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13299143006`, `13358500440`, `12315242035`
- **Canonical:** C139 Cache entitlements locally — never block a paid surface on a live server check

### R25-182 — Make trial→plan mapping explicit and let the user pick the post-trial plan — the most specific repeated claim in the corpus is renewal into the annual plan when monthly was selected

- **Where:** §11.3 Part 11 #10 — make trial→plan mapping explicit and let the user pick the post-trial plan; the most specific repeated claim is renewal into annual when monthly was selected
- **This app does:** trial converts to annual
- **User reaction:** 1★-burst
- **Magnitude:** ~6
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13431450922`, `13731572727`, `14075475519`
- **Canonical:** C163 Visible monthly plan — annual-default trials drive billing disputes

### R25-184 — Show the local currency unambiguously on the paywall — four Mexican and two other reviewers cannot tell pesos from dollars; a trust leak at the moment of purchase

- **Where:** §11.3 Part 11 #12 — show the local currency unambiguously on the paywall; pesos vs dollars is a trust leak at the moment of purchase
- **This app does:** ambiguous currency display
- **User reaction:** blocked-conversion
- **Magnitude:** 6
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C092 Regional pricing; C113 One stable, disclosed price — no discount wheels

### R25-185 — Confirm the displayed price equals the charged price — $24.99 shown and $42 charged; €29.99 lifetime then two further €6.99 charges

- **Where:** §11.3 Part 11 #13 — confirm the displayed price equals the charged price ($24.99 → $42; €29.99 + 2×€6.99)
- **This app does:** price mismatch
- **User reaction:** 1★-burst
- **Magnitude:** ~3
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12386056078`, `13605686247`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R25-190 — Stop order/group reshuffling and make reordering a drag gesture — 11 reviews; two long-term users left over it

- **Where:** §11.4 Part 11 #18 — stop order/group reshuffling and make reordering a drag gesture; two long-term users left over it
- **This app does:** order resets itself
- **User reaction:** churn
- **Magnitude:** 11 (0.84%)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12657367016`, `12658607281`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R25-191 — Preserve history through archive and restore — 4 reviews; archive losing history defeats the point of archiving

- **Where:** §11.4 Part 11 #19 — preserve history through archive and restore; archive-losing-history defeats the point of archiving
- **This app does:** archive destroys history
- **User reaction:** complaint
- **Magnitude:** 4 (0.31%)
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12201042880`
- **Canonical:** C041 Editing a habit never wipes its history

### R25-192 — Fix Apple Health mappings that are demonstrably wrong — weight read as entry count, steps off by 568, running only measurable in minutes, step counting starting at 04:00

- **Where:** §11.4 Part 11 #20 — fix Apple Health mappings that are demonstrably wrong: weight read as entry count, steps off by 568, running only in minutes, step counting starting at 04:00
- **This app does:** Health mapping bugs
- **User reaction:** complaint
- **Magnitude:** 9 (0.69%)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13502878041`, `11278083369`, `12918071192`, `12158005240`
- **Canonical:** C021 Apple Health integration; C072 Writes to shared system stores (calendar, health) must be exact and reversible

### R25-193 — Make over-achievement and bad-habit semantics coherent — exceeding a goal should not pre-complete tomorrow, and exceeding a bad-habit limit should not award 200%

- **Where:** §11.4 Part 11 #21 — make over-achievement and bad-habit semantics coherent: exceeding a goal should not pre-complete tomorrow; exceeding a bad-habit limit should not award 200%
- **This app does:** carry-over semantics wrong
- **User reaction:** complaint
- **Magnitude:** 7 (0.53%)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `14074498392`, `12778092747`
- **Canonical:** C019 Quit-habit / bad-habit mode; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

## Features

### R25-013 — The biggest unshipped feature is time-of-day scheduling — a specific clock time per habit with a notification at that time, not a generic reminder — requested by satisfied users; three requests cluster with it: one-off non-repeating tasks (10), recurring intra-day reminders every N minutes, and a calendar/agenda view (22 mention calendar)

- **Where:** Executive summary #9 — the biggest unshipped feature is a specific clock time per habit with a notification at that time, requested by satisfied users; clusters with one-off tasks, every-N-minutes reminders, calendar/agenda view
- **This app does:** no per-habit clock time; no one-off tasks; no agenda view
- **User reaction:** complaint
- **Magnitude:** 29 (2.22%, meaningful), mean 3.41, 17 4–5★; one-off 10 (0.76%); calendar 22 (1.68%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10975371211`, `11185726438`, `11512786062`, `11830672328`, `12559128903`, `12647535093`, `12682799984`, `12889328356`, `13846488281`, `14092149470`, `14303953237`, `14437910533`, `13466380366`, `13082959947`, `12152603849`, `13711288403`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C014 Multiple reminders per habit; C050 One-off to-dos alongside habits; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R25-024 — Habit creation with custom name, icon and colour including hex input is free up to 3 habits, then paid

- **Where:** §2.1 Habit creation with custom name, icon, colour (incl. hex input) — free up to 3 habits, then paid
- **This app does:** 3 free habits
- **User reaction:** mixed
- **Magnitude:** 138 cap complaints (10.54%)
- **Direction for us:** free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11694650718`, `13467469049`, `12382945489`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free

### R25-025 — A 'bad habit' / quit-habit mode exists, paid beyond the cap

- **Where:** §2.1 'Bad habit' / quit-habit mode — paid beyond the cap
- **This app does:** quit mode counts against cap
- **User reaction:** mixed
- **Magnitude:** inventory row
- **Direction for us:** research · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `10381805436`, `11353433253`, `13605094837`, `12778092747`
- **Canonical:** C019 Quit-habit / bad-habit mode

### R25-026 — Track-only habits with no goal number, measurement units (count, minutes, distance, custom steps) and a built-in timer that runs past the goal — the timer is praised at mean 4.60

- **Where:** §2.1 Track-only habits with no goal number; measurement units count / minutes / distance / custom; built-in timer that runs past the goal
- **This app does:** flexible units + timer, included
- **User reaction:** praise
- **Magnitude:** timer 15 (1.15%, mean 4.60)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `10785911508`, `10305734583`, `10381805436`, `12584418650`, `12918071192`, `10346042202`, `12889328356`, `13528811393`
- **Canonical:** C048 Flexible units / partial progress; C066 Focus timer

### R25-027 — Groups and sub-groups exist and are paid — a reviewer reports group creation locked

- **Where:** §2.1 Groups and sub-groups — paid (groups locked)
- **This app does:** grouping paid
- **User reaction:** mixed
- **Magnitude:** customisation/groups praised 65 (4.97%, mean 4.49); 1 locked report
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `12184038268`, `13207258224`, `12652539241`, `13585132870`
- **Canonical:** C045 Grouping / folders / categories / tags

### R25-028 — Statistics of any kind — success %, graphs, per-habit calendar, performance charts — are paywalled in every era, and by 2026 the calendar view too ('Pay to even look at calendar')

- **Where:** §2.1 / §2.3 Statistics (success %, graphs, per-habit calendar, performance charts) — paywalled in all eras; calendar view 'Pay to even look at calendar'
- **This app does:** stats and calendar paid
- **User reaction:** complaint
- **Magnitude:** 5 dated reviews 2024-05 → 2026-06
- **Direction for us:** free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `10305734583`, `12404912935`, `13601387355`, `11282934508`, `13318920074`, `13603068257`, `13636020247`, `14225842901`
- **Canonical:** C011 Weekly / monthly / yearly reports; C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells

### R25-029 — Streaks with a fire symbol, gamified achievements, confetti and a completion sound — one reviewer wants the celebration off

- **Where:** §2.1 Streaks with fire symbol; gamified achievements, confetti, completion sound (one wants it off)
- **This app does:** streaks + celebrations
- **User reaction:** mixed
- **Magnitude:** inventory rows
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `14129450366`, `13261289225`, `13543602021`, `12352612203`, `13879673780`, `13301076677`
- **Canonical:** C024 Streaks / gamification; C101 Milestones, achievements, celebration

### R25-030 — Apple-platform depth: two-way Apple Health, a Watch app with complications, Home-screen / Lock Screen / Control Center widgets, a Mac app (and formerly Vision Pro), iCloud sync across iPhone/iPad/Watch/Mac, Siri Shortcuts and calendar integration — all included

- **Where:** §2.1 Apple Health two-way integration; Apple Watch app + complications; Home/Lock Screen/Control Center widgets; Mac app (formerly Vision Pro); iCloud sync; Siri Shortcuts; calendar integration
- **This app does:** full Apple platform surface
- **User reaction:** praise
- **Magnitude:** Health 32 (2.44%); Watch 21 (1.60%, 4.48); widgets 30 (2.29%, 4.43)
- **Direction for us:** build-paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `10081083127`, `11399786219`, `12201042880`, `13543602021`, `10054970793`, `11965539196`, `12659238964`, `12584418650`, `12320067097`, `13197146903`, `13905166366`, `10899816769`, `11656905076`, `12539663591`, `13531929434`, `11057930335`, `12199187753`, `11248554918`, `13278531866`, `13472318627`, `12585991664`, `10569395314`, `13927028841`, `13937721688`
- **Canonical:** C009 Basic widgets, icons and colours are free; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C030 Sync must work — and prove it; C044 Mac / desktop / web app; C046 Shortcuts / Siri / URL scheme / API

### R25-031 — Vacation/pause, skip-a-day ('Jump'), mark-not-done ('Cancel') and archive exist

- **Where:** §2.1 'Vacation' / pause habits; 'Jump' and 'Cancel' / skip a day, mark not-done; archive habits
- **This app does:** pause/skip/archive included
- **User reaction:** praise
- **Magnitude:** inventory rows
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `13811962013`, `12176241214`, `13543602021`, `10468572229`, `12191332041`, `10971903648`, `12201042880`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R25-032 — CSV export exists but is described as weak

- **Where:** §2.1 Data export (CSV) — described as weak
- **This app does:** weak export
- **User reaction:** complaint
- **Magnitude:** inventory row
- **Direction for us:** free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `12849182179`, `12355886317`, `12264249799`
- **Canonical:** C020 Data export / backup / CSV

### R25-033 — An onboarding questionnaire suggests starter habits (free); a day-start time setting exists for shift workers but is capped at 11:45

- **Where:** §2.1 Onboarding questionnaire → suggested habits (free); day-start time setting for shift workers, capped at 11:45
- **This app does:** questionnaire onboarding; day boundary capped
- **User reaction:** mixed
- **Magnitude:** inventory rows
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `13162172214`, `13627235273`, `14341726601`, `14509705008`, `12659238964`, `11007220268`, `12014982215`
- **Canonical:** C170 Configurable day boundary and hemisphere seasons; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R25-035 — Not present per reviewers: Android and Windows versions, accounts/login independent of iCloud, social/accountability features, per-habit clock time, one-off tasks, landscape mode, and Turkish/Russian/Korean/Chinese/Italian UI

- **Where:** §2.1 Not present — Android/Windows, accounts independent of iCloud, social/accountability, per-habit clock time, one-off tasks, landscape, Turkish/Russian/Korean/Chinese/Italian UI
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** inventory note
- **Direction for us:** research · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `12936939329`, `13801191230`, `12208303239`, `13595608629`, `11680828081`, `13085696025`, `14000988461`
- **Canonical:** C015 Shared / group habits; C027 Localise early — it unlocks revenue; C035 Account system from day one; C051 Android version; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R25-048 — Customisation, groups, colours, icons praised

- **Where:** §3.1 theme table #6 Customisation, groups, colours, icons
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 65 (4.97%, very strong), mean 4.49, 5★ 47
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free; C045 Grouping / folders / categories / tags

### R25-050 — Interface / visual design praised

- **Where:** §3.1 theme table #8 Interface / visual design praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 62 (4.74%, very strong), mean 4.42
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C057 Offer a non-pastel / premium design option

### R25-059 — Apple Health integration praised

- **Where:** §3.1 theme table #17 Apple Health integration praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 32 (2.44%, meaningful), mean 3.97
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration

### R25-060 — Widgets mentioned — positively

- **Where:** §3.1 theme table #18 Widgets (mention)
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 30 (2.29%, meaningful), mean 4.43, 1★ 0
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free

### R25-061 — Wants per-habit clock time + timed notification

- **Where:** §3.1 theme table #19 Wants per-habit clock time + timed notification
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 29 (2.22%, meaningful), mean 3.41
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R25-064 — Calendar mention / integration ask

- **Where:** §3.1 theme table #22 Calendar (mention / integration ask)
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 22 (1.68%, meaningful), mean 3.68
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C199 System calendar integration — see appointments inside the plan

### R25-067 — Apple Watch mentioned — positively

- **Where:** §3.1 theme table #25 Apple Watch (mention)
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 21 (1.60%, meaningful), mean 4.48, 1★ 0
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R25-071 — Built-in timer praised

- **Where:** §3.1 theme table #29 Timer praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 15 (1.15%, meaningful), mean 4.60
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C066 Focus timer

### R25-074 — Wants reorder / order resets itself

- **Where:** §3.1 theme table #32 Wants reorder / order resets itself
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 11 (0.84%, emerging), mean 3.55
- **Direction for us:** free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R25-076 — Wants one-off, non-repeating tasks

- **Where:** §3.1 theme table #34 Wants one-off, non-repeating tasks
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 10 (0.76%, emerging), mean 3.90
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C050 One-off to-dos alongside habits

### R25-077 — Wants friends / accountability / leaderboard — from fans

- **Where:** §3.1 theme table #35 Wants friends / accountability / leaderboard
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 10 (0.76%, emerging), mean 4.80, 5★ 8
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C015 Shared / group habits

### R25-080 — Statistics weak / unreadable

- **Where:** §3.1 theme table #38 Statistics weak / unreadable
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 8 (0.61%, emerging), mean 4.00
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views

### R25-082 — Mac / desktop / Vision Pro

- **Where:** §3.1 theme table #40 Mac / desktop / Vision Pro
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 8 (0.61%, emerging), mean 4.00
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C044 Mac / desktop / web app

### R25-084 — Wants notes / journal / mood field

- **Where:** §3.1 theme table #42 Wants notes / journal / mood field
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 7 (0.53%, emerging), mean 4.43
- **Direction for us:** free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C049 Mood tracker; C172 Per-day / per-habit notes and journal text

### R25-085 — Wants long-term goals above habits

- **Where:** §3.1 theme table #43 Wants long-term goals above habits
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 7 (0.53%, emerging), mean 4.71
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C108 Goals / targets

### R25-096 — Flexible scheduling primitives are a stated reason to choose the app: an every-N-days reminder ('the ONLY APP I've found'), N×/week, skip, vacation mode and a custom day-start time for shift workers

- **Where:** §3.4 Flexible scheduling primitives — every-3-days reminder 'the ONLY APP I've found'; custom day start for shift workers; vacation mode
- **This app does:** every-N-days, custom day start, vacation
- **User reaction:** praise
- **Magnitude:** 4 named reviews
- **Direction for us:** must-have · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `12615038002`, `12659238964`, `13811962013`, `10468572229`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency; C170 Configurable day boundary and hemisphere seasons

### R25-099 — A layer of long-term goals sitting above habits is requested by very satisfied users

- **Where:** §3.5 Long-term goals sitting above habits — requested by very satisfied users (mean 4.71)
- **This app does:** habits only, no goal layer
- **User reaction:** complaint
- **Magnitude:** 7 (0.53%, emerging), mean 4.71
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11656905076`, `12008425939`, `12605136142`, `12617239758`, `13674254597`, `13758062522`
- **Canonical:** C108 Goals / targets

### R25-100 — Three reviewers want habits linked to Screen Time

- **Where:** §3.5 Screen-time-linked habits — a habit that reads device screen time
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 3 (0.23%, weak)
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11154294245`, `11965539196`, `13739990490`
- **Canonical:** — (nuance register)

### R25-118 — The scheduling gap is one coherent product gap — Grit models whether a habit happened, not when — uniting per-habit clock time (29), one-off tasks (10), intra-day recurrence (4), calendar/agenda view (4) and long-term goals (7); it is the only large negative-direction theme whose mean sits above 3 and the only one dominated by satisfied users ('a notification giving me the start and the end'; 'an agenda view hour by hour' from a paying user; 'I can't get a notification as to when I need to because I can't add the time'); one 1★ reviewer frames a fixed time per habit as an ADHD need ('doesn't give you a cue for when to start')

- **Where:** §4.4 Cluster 4 — the scheduling gap: Grit models whether a habit happened, not when; a coherent gap uniting clock time, one-off tasks, intra-day recurrence, agenda view and long-term goals; the only large negative theme dominated by satisfied users
- **This app does:** no time dimension
- **User reaction:** complaint
- **Magnitude:** 29 (2.22%), mean 3.41, 17 4–5★; + 10 + 4 + 4 + 7
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12559128903`, `12647535093`, `12682799984`, `11185726438`, `14303953237`, `12608048200`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C014 Multiple reminders per habit; C050 One-off to-dos alongside habits; C108 Goals / targets; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R25-167 — There is a clear, named, unbuilt feature with demand from satisfied users — per-habit clock time with a notification at that time (29, 17 of them 4–5★); whoever ships routine scheduling rather than routine checking takes the ADHD-planner positioning

- **Where:** Part 10 #4 — a clear, named, unbuilt feature with demand from satisfied users: per-habit clock time with a notification; whoever ships routine scheduling rather than routine checking takes the ADHD-planner positioning
- **This app does:** checking, not scheduling
- **User reaction:** complaint
- **Magnitude:** 29, 17 4–5★
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R25-186 — Per-habit clock time with a notification at that time — 29 reviews, 17 from 4–5★ users; the top request in the 4★ band at 9.0%

- **Where:** §11.4 Part 11 #14 — per-habit clock time with a notification at that time; the top request in the 4★ band at 9.0%
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 29; 4★ band 9.0%
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R25-187 — One-off, non-repeating tasks in a separate list or tab — 10 reviews, 7 of them 4★

- **Where:** §11.4 Part 11 #15 — one-off, non-repeating tasks in a separate list or tab (10; 7 of them 4★)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 10; 7 4★
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C050 One-off to-dos alongside habits

### R25-188 — Optional intra-day recurring reminders (every N minutes until completed) — 4 reviews including a paying user with a medication use case

- **Where:** §11.4 Part 11 #16 — optional intra-day recurring reminders (every N minutes until completed), including a paying user's medication use case
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 4
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12152603849`
- **Canonical:** C014 Multiple reminders per habit

### R25-189 — Rework the statistics screen around 'why did I miss it' — a detailed review edited down from 5★ to 3★ and a mood/energy-tracker proposal are effectively a free design brief

- **Where:** §11.4 Part 11 #17 — rework the statistics screen around 'why did I miss it'; two reviews are effectively a free design brief
- **This app does:** stats show what, not why
- **User reaction:** complaint
- **Magnitude:** 2 detailed reviews; stats weak 8 (0.61%)
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13976982513`, `14139271437`
- **Canonical:** C012 Week / month / year grid views; C049 Mood tracker

## Monetization

### R25-005 — The 3-habit free cap is the single largest fact in the corpus and the first thing most new users meet; widened to all monetisation friction (cap, paywall, upsell pop-ups, price, paywalled statistics, survey-then-paywall) it is 22.77% of reviews at mean 1.99 and 56.0% of all 1★ reviews

- **Where:** Executive summary #1 — the 3-habit free cap is the single largest fact and the first thing most new users meet; all monetisation friction = 56.0% of all 1★
- **This app does:** hard 3-habit free cap with paywalled stats
- **User reaction:** 1★-burst
- **Magnitude:** cap 138 (10.54%, high-priority), mean 2.13, 68 1★; all friction 298 (22.77%), mean 1.99, 169 1★ (56.0% of 1★)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11344752179`, `11580010213`, `12038603986`, `12418313250`, `12594456123`, `13570261114`, `13653480657`, `13759652099`, `14119383340`, `14452682730`, `14500984459`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R25-036 — Three plans: monthly ($1.08, 40 MXN, R$5, €2.99, €1.25, $10, $13, €9.90, €10), annual (€35, A$19.99, ₹1,299, R$199.90, 299.99 MXN, $33, $42 charged against a $24.99 expectation), lifetime (£25 → £29.99, $24.99–25 rising to $49 / 50€ / $29.99 / MXN 500 from mid-2025, ~23–30€ promotional)

- **Where:** §2.2 Monetisation — three plans named consistently: monthly ($1.08–$13, €1.25–€10), annual (€35, A$19.99, ₹1,299, R$199.90, 299.99 MXN, $33, $42 vs $24.99 expected), lifetime (£25 → £29.99, $24.99–25 rising to $49 / 50€ / MXN 500 by mid-2025)
- **This app does:** monthly / annual / lifetime
- **User reaction:** mixed
- **Magnitude:** 30+ figures in 12 currencies
- **Direction for us:** build-paid · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `12230465395`, `11856825871`, `11975068830`, `12830065250`, `13612032880`, `13405360163`, `11100933308`, `13493408148`, `13391520278`, `11185726438`, `14132304435`, `14244904942`, `13605094837`, `13927028841`, `12956024975`, `14164700184`, `13424912655`, `12386056078`, `11422195516`, `12407220130`, `13418259698`, `11007220268`, `11461120524`, `12045596500`, `11122925794`, `12904556624`, `13660452698`, `13299143006`, `14379122842`, `13582066669`, `12478039620`, `12348445268`, `14167301638`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'

### R25-037 — The lifetime/one-time option is a named purchase driver — 'good option that u can just buy the app you dont have to do subscription stuff thank you' — and one Brazilian reviewer could not find it and thought only a monthly plan existed

- **Where:** §2.2 The one-time option is a named purchase driver ('you dont have to do subscription stuff thank you'); one reviewer could not find it
- **This app does:** lifetime offered alongside subscription
- **User reaction:** purchase-driver
- **Magnitude:** 44 (3.36%) mention lifetime, mean 3.95
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11248554918`, `12178717768`, `13547124162`, `12199187753`, `12486962813`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R25-038 — The lifetime price roughly doubles between early 2024 ($24.99/£25) and mid-2025 onward ($49/50€) while monthly/annual spread rather than rise; price objection does not rise with it (3.8% E1 → 4.9% E2 → 3.8% E3) — the objection is to the gate, not the number

- **Where:** §2.2 Direction of travel — lifetime price roughly doubles ($24.99 → $49) between early 2024 and mid-2025 while price objection does not rise (3.8% → 4.9% → 3.8%)
- **This app does:** lifetime price doubled
- **User reaction:** mixed
- **Magnitude:** $24.99 → $49; objection 3.8% → 4.9% → 3.8%
- **Direction for us:** build-paid · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R25-043 — Monetisation friction union — cap, paywall, pop-ups, price, paywalled stats, survey-then-paywall

- **Where:** §3.1 theme table #1 Monetisation friction (union)
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 298 (22.77%, high-priority), mean 1.99, 5★ 31, 1★ 169
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R25-044 — General paywall complaint — 'can't use it free'

- **Where:** §3.1 theme table #2 General paywall complaint ('can't use it free')
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 163 (12.45%, high-priority), mean 2.01, 1★ 90
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C147 Let people use the product before they pay

### R25-045 — The 3-habit free-tier cap complaint

- **Where:** §3.1 theme table #3 Free-tier habit cap (the '3 habits' complaint)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 138 (10.54%, high-priority), mean 2.13, 5★ 16, 1★ 68
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R25-049 — Price praised as cheap / fair

- **Where:** §3.1 theme table #7 Price praised as cheap / fair
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 64 (4.89%, very strong), mean 4.31, 5★ 45
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R25-051 — Price objection

- **Where:** §3.1 theme table #9 Price objection ('too expensive')
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 55 (4.20%, very strong), mean 1.76, 1★ 35
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R25-053 — Lifetime / one-time purchase discussed

- **Where:** §3.1 theme table #11 Lifetime / one-time purchase discussed
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 44 (3.36%, very strong), mean 3.95, 5★ 27, 1★ 8
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R25-065 — Trial discussed — net negative

- **Where:** §3.1 theme table #23 Trial discussed
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 21 (1.60%, meaningful), mean 2.62, 1★ 10
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

### R25-091 — About seven reviewers ask for the app to be paid up front instead of 'fake-free' — an honest paid listing is preferred to a free download that gates at habit four

- **Where:** §3.3 'Make it a paid app instead of fake-free' — ~7 reviewers would rather pay up front than meet a disguised paywall
- **This app does:** free download, gated at 4
- **User reaction:** blocked-conversion
- **Magnitude:** ~7 of 55
- **Direction for us:** research · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `13734318899`, `14218926067`, `13897905905`, `12085816881`, `14509705008`
- **Canonical:** C181 If the app is paid-only, say so in the subtitle and first screenshot; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R25-092 — 64 reviews (4.89%, mean 4.31) praise the price — 'less than 30 euros for life', 'for as little as 2.30 euros', 'Premium is 1000% worth it' — and 19 (1.45%) defend the cap itself: 'I don't mind the limit of only 3 habits since it helps me to only keep track of what is the most important to me'

- **Where:** §3.3 Against the 55 sit 64 praising the price ('por menos de 30 euros la tienes de por vida'; 'Premium is 1000% worth it') and 19 defending the cap ('helps me to only keep track of what is the most important')
- **This app does:** price fair; cap defended by some
- **User reaction:** praise
- **Magnitude:** 64 (4.89%), mean 4.31; 19 (1.45%)
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12348445268`, `11694650718`, `13963611699`, `12651898098`, `10960460814`, `11592867713`, `12488599791`, `12299954486`, `11391330335`, `10380895839`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R25-110 — The cap is stated the same way in every market — three is too few to plan a day, which the app's own title promises ('con esas 3 solo puedo poner desayunar, comer y cenar'; 'If a baby could use this app properly, even they'd have at least five'); reviewers name the number they would accept — 5–6, 6, 8, 10, 10–15, 16–17, 20 — median 8–10

- **Where:** §4.2 (a) The cap itself — three is too few to plan a day, which the title promises; acceptable numbers named: 5–6, 6, 8, 10, 10–15, 16–17, 20; median acceptable 8–10
- **This app does:** 3-habit cap
- **User reaction:** complaint
- **Magnitude:** 138; median acceptable 8–10
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11772475330`, `12715120271`, `13570261114`, `13670572794`, `13681645142`, `13570666268`, `14122841864`, `12038603986`, `11924553891`, `12384352203`, `11831643030`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R25-128 — Purchase triggers: a lifetime option instead of another subscription (8 IDs); trying it and finding it beats everything else ('I will subscribe as soon as my free trial ends'); developer responsiveness observed before purchase ('After testing the app and interacting with the developer… I've decided to pay without any hesitation'); low absolute price or discount (A$19.99/yr 'amazing', 20% off, €23 promo); Apple Health/Watch/Mac coverage; paying after being annoyed by the cap ('the app was so beautiful I had to subscribe… WITH SUBSCRIPTION'); an Instagram / TikTok / Reels ad

- **Where:** §6.3 What makes people buy (verbatim table) — lifetime instead of another subscription; beats everything tried; developer responsiveness observed before purchase; low price / discount; Health/Watch/Mac; paid after being annoyed by the cap; Instagram/TikTok/Reels ad
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Trigger | Evidence ; A lifetime option instead of another subscription | 11248554918, 12178717768, 12199187753, 12486962813, 13093563693, 13874254043, 14167301638, 12904556624 ; Trying it and finding it beats everything else tried | 10346042202 ("I will subscribe as soon as my free trial ends"), 12427277456, 13064873599, 13941722253, 12184038268 ; Developer responsiveness observed before purchase | 12168338279 ("After testing the app and interacting with the developer… I've decided to pay for Grit without any hesitation"), 11793376300 ; Low absolute price / discount offer | 13605094837 (A$19.99/yr "amazing"), 13874254043 (20% off), 12478039620 (€23 promo), 13989162794 ; Apple Health / Watch / Mac coverage | 12584418650, 11687820487, 12539663591 ; Paid *after* being annoyed by the cap | 13679257824 (it, 4★) — "era così bella quest app che ho dovuto far l'abbonamento… CON ABBONAMENTO CON ABBONAMENTO" ; Instagram / TikTok / Reels ad | 12605136142, 13612032880, 14007797685, 11840566735, 14054848356
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11248554918`, `12178717768`, `12199187753`, `12486962813`, `13093563693`, `13874254043`, `14167301638`, `12904556624`, `10346042202`, `12427277456`, `13064873599`, `13941722253`, `12184038268`, `12168338279`, `11793376300`, `13605094837`, `12478039620`, `13989162794`, `12584418650`, `11687820487`, `12539663591`, `13679257824`, `12605136142`, `13612032880`, `14007797685`, `11840566735`, `14054848356`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C021 Apple Health integration; C036 A support channel that exists, is reachable outside the app, and answers; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R25-134 — The trial is a net-negative topic (mean 2.62, 10 of 21 1★ — the second-worst monetisation sub-theme): card required up front, renewal into the wrong plan, charging inside the window, and uncertainty about whether cancelling is possible ('Can I take the free trial and then not pay after the week?'); positive trial outcomes exist ('tried it 1 day, paid the 2nd'; 'purchased a lifetime subscription after trying it out for free') and every one describes having had enough product access to form a judgement

- **Where:** §6.6 Trial reaction is net-negative — card required up front, renewal into the wrong plan, charging inside the window, uncertainty whether cancelling is possible; every positive trial review describes enough access to form a judgement
- **This app does:** 7-day trial with card, auto-converts
- **User reaction:** blocked-conversion
- **Magnitude:** 21 (1.60%), mean 2.62, 10 1★
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12238496089`, `13431450922`, `14075475519`, `13588325969`, `13926135435`, `13808012088`, `10346042202`, `12168338279`, `13989162794`, `13941722253`
- **Canonical:** C109 A free trial must be a real trial; C147 Let people use the product before they pay; C163 Visible monthly plan — annual-default trials drive billing disputes

### R25-168 — A lifetime purchase option is a stated, repeated reason people buy — 44 reviews, 8 naming it as the deciding factor; subscription fatigue is explicit in German, French and US reviews

- **Where:** Part 10 #5 — a lifetime purchase option is a stated, repeated reason people buy (44; 8 name it as deciding); subscription fatigue explicit in German, French and US reviews
- **This app does:** lifetime offered
- **User reaction:** purchase-driver
- **Magnitude:** 44; 8 deciding
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

## Tactics the app used

### R25-129 — Tactic and outcome: a solo developer answering e-mails and shipping requests within a day converts prospects — 'After testing the app and interacting with the developer… I've decided to pay for Grit without any hesitation'

- **Where:** §6.3 Developer responsiveness observed before purchase is a named purchase trigger
- **This app does:** fast personal support pre-purchase
- **User reaction:** purchase-driver
- **Magnitude:** 2 named reviews; support praise 20 (mean 4.10) thinning 3.0% → 0.9%
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `12168338279`, `11793376300`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R25-135 — Tactic and outcome: an in-app review prompt fired during onboarding — 8 direct complaints ('Me pide evaluar la app sin haberla usado'; 'Why won't it progress without me writing a review?'; 'in the middle of the onboarding questions the app interrupts me to ask me to rate and review') — and much larger indirect evidence: ≤25-character reviews 7.2% → 13.8% → 33.4% (150 of 196 5★ in E3), median body length 156 → 107 → 53 characters, 'haven't used it yet' 3.0% → 2.9% → 3.8%; all-records mean 3.87 → 3.66 → 3.60 vs substantive 3.83 → 3.51 → 3.10; a 4★ from Australia says the app would not let them proceed without writing a review — if that gate existed in any build, the 5★ share is not a satisfaction measurement for that period

- **Where:** Part 7 — the review-prompt problem: 8 direct complaints ('Why won't it progress without me writing a review?'; 'in the middle of the onboarding questions the app interrupts me to ask me to rate'); indirect evidence table (verbatim): ≤25-char reviews 7.2% → 13.8% → 33.4%, median body 156 → 107 → 53 chars; substantive mean 3.83 → 3.51 → 3.10
- **This app does:** onboarding review prompt, possibly gating progress
- **User reaction:** 5★-burst
- **Magnitude:** Metric | E1 | E2 | E3 ; Reviews with body ≤ 25 characters | 17 (7.2%) | 67 (13.8%) | 196 (33.4%) ; …of which 5★ | 11 | 59 | 150 ; Median body length (chars) | 156 | 107 | 53 ; Mean body length (chars) | 214 | 171 | 99 ; "Haven't used it yet" reviews | 7 (3.0%) | 14 (2.9%) | 22 (3.8%) ; All-records mean | 3.87 | 3.66 | 3.60 ; Substantive-records mean (>60 chars) | 3.83 | 3.51 | 3.10 ; 8 direct (0.61%, mean 2.00)
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12424719394`, `12591004629`, `12957806563`, `13411399713`, `13419192067`, `13386578145`, `13764701322`, `12876930985`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

## Insights (the why)

### R25-006 — The complaint is not 'too expensive' — it is 'I could not evaluate the product': three habits is not enough to test a habit tracker ('impossibile da capire se effettivamente é utile senza pagare'; 'how do you expect me to subscribe without trying anything??'); price objection alone is only 4.20%, 64 reviews (mean 4.31) praise the price as cheap or fair and 19 (mean 4.32) defend the cap on principle — the pricing level is not the problem, the trial design is; the cheapest high-value fix available

- **Where:** Executive summary #2 — the complaint is not 'too expensive', it is 'I could not evaluate the product'; 64 praise the price as fair; 19 defend the cap; the pricing level is not the problem, the trial design is
- **This app does:** 3-habit cap prevents evaluation; price itself judged fair
- **User reaction:** blocked-conversion
- **Magnitude:** price objection 55 (4.20%); price praised 64 (4.89%, mean 4.31); cap defended 19 (1.45%, mean 4.32)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13392619767`, `13557314925`, `13927978729`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C064 Price level — where 'fair' turns into 'too expensive'; C147 Let people use the product before they pay

### R25-017 — 43 of the 138 cap complaints are 3★ or better, 27 are 4★ or better and 16 are 5★ — people who like the app and object to the gate

- **Where:** §1.5 — rating is not a feature preference: 43 of 138 cap complaints are 3★+, 27 4★+, 16 5★ — people who like the app and object to the gate
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 43 / 27 / 16 of 138
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R25-046 — Simplicity / ease of use praised

- **Where:** §3.1 theme table #4 Simplicity / ease of use
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 126 (9.63%, high-priority), mean 4.20, 5★ 89
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R25-047 — Motivation / streaks / accountability works

- **Where:** §3.1 theme table #5 Motivation / streaks / accountability works
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 84 (6.42%, high-priority), mean 4.58, 5★ 64, 1★ 1
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C024 Streaks / gamification

### R25-069 — Free cap actively defended

- **Where:** §3.1 theme table #27 Free cap actively defended
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 19 (1.45%, meaningful), mean 4.32
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R25-070 — 'Life-changing' / major life outcome claimed

- **Where:** §3.1 theme table #28 'Life-changing' / major life outcome claimed
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 19 (1.45%, meaningful), mean 4.84, 1★ 0
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R25-089 — The twelve worst-rated themes (n ≥ 8): survey→paywall 1.17; editing gated 1.20; statistics paywalled 1.40; already paid asked again 1.50; billing dispute 1.59; launch blocker 1.63; price objection 1.76; upsell pop-ups 1.80; general paywall 2.01; free cap 2.13; trial 2.62; confusing UX 2.70 — every one is monetisation-mechanics or reliability; no feature gap appears; that is where the rating risk lives

- **Where:** §3.2 Worst rating profile table (verbatim) — every one of the twelve worst-rated themes is monetisation-mechanics or reliability; no feature gap appears
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | Mean | % 1★ | Why it matters ; Onboarding survey → instant paywall | 6 | 1.17 | 83.3% | The whole first-run experience is spent, then gated ; Editing gated behind premium | 5 | 1.20 | 80.0% | Converts the free tier into a demo ; Statistics paywalled | 5 | 1.40 | 60.0% | Removes the motivation loop the product sells ; Already paid, asked to pay again | 8 | 1.50 | 62.5% | Attacks existing revenue, not prospects ; Billing dispute | 44 | 1.59 | 72.7% | Reputational, and Apple-visible ; Launch / interaction blocker | 51 | 1.63 | 64.7% | Zero-value first session ; Price objection | 55 | 1.76 | 63.6% | Mostly a gate objection in disguise (Part 3.3) ; Upsell pop-ups | 35 | 1.80 | 57.1% | Directly contradicts the ADHD positioning ; General paywall complaint | 163 | 2.01 | 55.2% | The volume theme ; Free-tier cap | 138 | 2.13 | 49.3% | The volume theme ; Trial discussed | 21 | 2.62 | 47.6% | Trial is a net-negative topic in this corpus ; Confusing UX | 27 | 2.70 | 40.7% | Second-order: people who got in and got lost
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R25-090 — The 55 price objections split by argument: ~31 'I can't evaluate it on 3 habits' (a gate objection), ~12 'too high for this category' ('£25 for a basic box checker'; 'an app you could build yourself in a few days'), ~8 'I cannot afford it' (a student, a child, 'no está diseñado para personas con bajo presupuesto'), ~7 'make it a paid app instead of fake-free', ~5 'self-improvement should be free'

- **Where:** §3.3 Reading the price objection correctly (verbatim table) — ~31 'can't evaluate on 3 habits', ~12 'too high for category', ~8 'cannot afford', ~7 'make it a paid app instead of fake-free', ~5 'self-improvement should be free'
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Argument | n | Example IDs ; "I can't evaluate it on 3 habits" (gate, not price) | ~31 | 13392619767, 13557314925, 13927978729, 12384352203, 12609243324, 11676088428, 14483086667, 13681645142 ; "The price is too high for this category" | ~12 | 12407220130 ("£25 for a basic box checker"), 13567924370 ("40$??? it's a simple app"), 14244904942 ("eine App die man in wenigen Tagen selber bauen könnte"), 13405360163, 12428670326 ; "I cannot afford it" (stated constraint, not valuation) | ~8 | 12993678135 ("i'm broke"), 12709066735, 13723968661 ("Je ne suis qu'un enfant"), 14193180633 ("étudiante et sans emploi"), 14239812567 ("no está diseñado para personas con bajo presupuesto") ; "Make it a paid app instead of fake-free" | ~7 | 13734318899, 14218926067, 13897905905, 12085816881, 14509705008 ; "Self-improvement should be free" (principle) | ~5 | 12113656689, 11917804472, 12347768247 (inverse), 13386578145
- **Direction for us:** product-rule · **Report confidence:** qualitative split · **Generalisable:** yes
- **Review IDs:** `13392619767`, `13557314925`, `13927978729`, `12384352203`, `12609243324`, `11676088428`, `14483086667`, `13681645142`, `12407220130`, `13567924370`, `14244904942`, `13405360163`, `12428670326`, `12993678135`, `12709066735`, `13723968661`, `14193180633`, `14239812567`, `13734318899`, `14218926067`, `13897905905`, `12085816881`, `14509705008`, `12113656689`, `11917804472`, `12347768247`, `13386578145`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C147 Let people use the product before they pay

### R25-097 — Reviewers claim measurable outcomes — 45 kg lost over eight months, recovery from depression — at the highest mean of any theme

- **Where:** §3.4 Measurable real-world outcomes claimed — 45 kg lost over 8 months; recovery from depression
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 19 (1.45%), mean 4.84, 0 1★
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13848909054`, `14308003772`, `11694650718`, `12627746599`, `13751037946`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R25-104 — Product-comprehension failures worth designing against: how bad-habit logging should be structured ('smoked' or 'didn't smoke'), whether a weekly habit can be pinned to a chosen day, how to stop a task repeating, whether the app is iOS-only, and the currency of the displayed price

- **Where:** §3.5 Misunderstandings worth designing against — how to structure a bad habit ('smoked' or 'didn't smoke'), pinning a weekly habit to a day, stopping a repeat, iOS-only, currency of the price
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 5 clusters
- **Direction for us:** must-have · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `12778092747`, `11312965919`, `12201453432`, `12549275458`, `13688911525`, `12319455814`, `13290152980`, `14164700184`
- **Canonical:** C019 Quit-habit / bad-habit mode; C075 Skippable, replayable onboarding tour

### R25-114 — Counter-evidence: 64 praise the price, 19 defend the cap, and at least two reviewers tell other readers to ignore the paywall complaints ('Don't follow the everything-free crowd complaining in the comments'; 'nothing is really free'); the product converts and converts happily — the question is not whether to charge but whether the gate sits before or after the user can see what they would be buying

- **Where:** §4.2 Counter-evidence — two reviewers tell others to ignore the paywall complaints ('Ne suivez pas les adeptes du tout gratuit'; 'nothing is really free'); the question is not whether to charge but whether the gate is before or after the user can see what they would buy
- **This app does:** gate placement
- **User reaction:** mixed
- **Magnitude:** 64 + 19 + 2
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `12158111543`, `12488599791`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R25-117 — Nothing establishes intent and Apple mediates all transactions, so part of the billing volume is the ordinary background rate of App Store subscription confusion; two things are not ordinary — the specific, repeated claim that the trial maps to a plan the user did not pick, and the 16-month persistence of purchase-recognition failures — both checkable against the developer's own StoreKit logic

- **Where:** §4.3 Interpretation — Apple mediates every transaction so part of this is background subscription confusion; what is not ordinary is the specific repeated trial → wrong-plan claim and 16-month purchase-recognition failures, both checkable in the developer's StoreKit logic
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** ~6 wrong-plan; 8 recognition failures
- **Direction for us:** must-never-break · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C163 Visible monthly plan — annual-default trials drive billing disputes

### R25-121 — 4★ (n=122) is the feature-request band: monetisation friction 19.7%, motivation and customisation 9.0% each, per-habit clock time 9.0% (vs 2.22% globally), free cap 9.0%, calendar 6.6%, Watch/Health 5.7% each, one-off tasks 5.7% (vs 0.76%) — engaged users telling the developer exactly what stands between 4 and 5

- **Where:** §5.2 4★ is the feature-request band — clock time peaks at 9.0% (vs 2.22% globally), one-off tasks 5.7% (vs 0.76%): engaged users saying what stands between 4 and 5
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 4★ ; Monetisation friction | 24 | 19.7% ; Motivation / customisation (each) | 11 | 9.0% ; Wants per-habit clock time | 11 | 9.0% ; Free cap | 11 | 9.0% ; Calendar mention | 8 | 6.6% ; Apple Watch / Health (each) | 7 | 5.7% ; Wants one-off tasks | 7 | 5.7%
- **Direction for us:** must-have · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `12206675017`, `13162425122`, `12574249594`, `12682799984`, `12659238964`, `11185726438`
- **Canonical:** C050 One-off to-dos alongside habits; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R25-122 — 3★ (n=79): monetisation friction 30.4%, general paywall / free cap 20.3% each, clock time 7.6%, widget / localisation / launch blocker 6.3% each — the 'good app, wrong gate' band; it holds the most detailed negative statistics feedback in the corpus, an edited review downgraded from 5★ for non-responsiveness

- **Where:** §5.3 3★ is the 'good app, wrong gate' band; holds the most detailed statistics feedback — an edited review downgraded from 5★ for non-responsiveness
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 3★ ; Monetisation friction | 24 | 30.4% ; General paywall / free cap (each) | 16 | 20.3% ; Wants clock time | 6 | 7.6% ; Widget / localisation / launch blocker (each) | 5 | 6.3%
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11750095859`, `13607697398`, `13211525138`, `11819157242`, `13065644863`, `12543917496`, `13976982513`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C012 Week / month / year grid views

### R25-123 — 2★ (n=84): monetisation friction 59.5%, general paywall / free cap 32.1% each, price 11.9%, launch blocker 10.7%, pop-ups 8.3%, billing 7.1% — almost purely monetisation

- **Where:** §5.4 2★ is almost purely monetisation — 59.5% of the band carries a money complaint
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 2★ ; Monetisation friction | 50 | 59.5% ; General paywall / free cap (each) | 27 | 32.1% ; Price objection | 10 | 11.9% ; Launch blocker | 9 | 10.7% ; Pop-ups | 7 | 8.3% ; Billing dispute | 6 | 7.1% ; pop-ups 7 (8.3%) ; billing 6 (7.1%)
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11821254670`, `12186632093`, `12857706647`, `13031241797`, `13726240792`, `14070190668`, `14245772006`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R25-131 — Once paid, buyers value statistics and charts, configurability and groups, the timer, cross-device continuity and the absence of ads; some frame the value as stress reduction — 'reduces my mental load'

- **Where:** §6.4 What buyers value once paid — statistics and charts, configurability and groups, the timer, cross-device continuity, the absence of ads; 'reduces my mental load'
- **This app does:** paid depth
- **User reaction:** praise
- **Magnitude:** 13 representative reviews
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11694650718`, `12404912935`, `13601387355`, `12184038268`, `12592966841`, `12889328356`, `12199187753`, `13197146903`, `12299954486`, `14117808358`, `13963611699`, `14198639512`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C045 Grouping / folders / categories / tags; C066 Focus timer

### R25-136 — Consequences: use the substantive series (3.83 → 3.51 → 3.10, a 0.73-point fall, not 0.27); the 1★ series is comparatively uncontaminated — almost no one writes a one-word 1★ under a prompt they resent — so 1★ share rising 16.1% → 22.2% → 26.6% is the most trustworthy single trend line; a store rating propped up by prompt-driven 5★ reviews while substantive sentiment falls is a fragile asset that inflates install volume into a product currently failing a measurable share of new users at launch

- **Where:** Part 7 Consequences — use the substantive series (3.83 → 3.51 → 3.10, a 0.73 fall not 0.27); the 1★ share 16.1% → 22.2% → 26.6% is the most trustworthy trend line; a rating propped up by prompt-driven 5★ is a fragile asset feeding installs into a product failing new users at launch
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 1★ 16.1% → 22.2% → 26.6%; substantive 3.83 → 3.10
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13386578145`, `13764701322`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R25-146 — The seven high-volume storefronts (n=820, 62.6%, mean 3.73, 5★ 54.9%, 1★ 20.7%; cap 10.9%, friction 22.1%, billing 3.0%, blocker 3.3%, ADHD 4.4%, simple 11.2%) are statistically indistinguishable from the high-spend group (3.74) and only marginally better than the 84-storefront tail — there is no high-value/low-value split; Grit's problems are uniform across market tiers and only their mix changes

- **Where:** §8.10 Group B high-review-volume (us, mx, br, fr, gb, de, ca) n=820, mean 3.73 — indistinguishable from high-spend (3.74); no high-value/low-value split; problems uniform across tiers, only the mix changes
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 3.73 vs 3.74 vs 3.62
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R25-165 — 'I couldn't evaluate it' is a stronger churn driver than 'it's too expensive' — only ~12 of 55 price objections are genuinely about the price level

- **Where:** Part 10 #2 — 'I couldn't evaluate it' is a stronger churn driver than 'it's too expensive'; only ~12 of 55 price objections are about price level
- **This app does:** gate before evaluation
- **User reaction:** blocked-conversion
- **Magnitude:** ~31 gate vs ~12 level of 55
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C147 Let people use the product before they pay

## Audiences

### R25-012 — ADHD is the app's strongest positioning and its strongest satisfaction signal — 41 self-identify ADHD/autism/Asperger's/OCD at mean 4.44 (32 5★), a further 24 (mean 4.67) describe procrastination, forgetfulness, task paralysis or depression without a diagnosis, three arrive via a clinician including a psychologist who recommends it to clients — but the same segment supplies the sharpest paywall anger: 'It is just another app trying to profit off of your disability'

- **Where:** Executive summary #8 — ADHD is the strongest positioning and strongest satisfaction signal (mean 4.44, 32 of 41 5★) — and supplies the sharpest paywall anger ('profit off of your disability')
- **This app does:** ADHD positioning delivered on product, undercut by paywall
- **User reaction:** mixed
- **Magnitude:** 41 (3.13%, very strong), mean 4.44, 32 5★; 24 (1.83%, mean 4.67); 3 clinician referrals
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12404912935`, `11680828081`, `13158925619`, `13742936226`, `11544311590`, `11831643030`, `11809645737`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

### R25-055 — ADHD / autism / OCD self-identified

- **Where:** §3.1 theme table #13 ADHD / autism / OCD self-identified
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 41 (3.13%, very strong), mean 4.44, 5★ 32
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R25-063 — Executive-function difficulty without a named diagnosis

- **Where:** §3.1 theme table #21 Executive-function difficulty, no diagnosis named
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 24 (1.83%, meaningful), mean 4.67, 5★ 20
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R25-169 — ADHD users are the highest-satisfaction segment (41 at mean 4.44) and they notice hostile monetisation more than anyone else — the most cutting paywall criticism in the corpus comes from that same group

- **Where:** Part 10 #6 — ADHD users are the highest-satisfaction segment and notice hostile monetisation more than anyone else
- **This app does:** ADHD positioning
- **User reaction:** mixed
- **Magnitude:** 41, mean 4.44
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13742936226`, `13493408148`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

## Markets and languages

### R25-022 — 91 storefronts; seven clear 50 reviews (us 310, mx 203, br 100, fr 53, gb 53, de 51, ca 50) = 820 (62.64%); the other 84 hold 489 (37.36%)

- **Where:** §1.6 Storefronts — 91; seven ≥50 (us 310, mx 203, br 100, fr 53, gb 53, de 51, ca 50) = 820 (62.64%)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 7 storefronts = 820 (62.64%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R25-066 — Localisation request

- **Where:** §3.1 theme table #24 Localisation request
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 21 (1.60%, meaningful), mean 3.90
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R25-108 — The launch blocker is geographically skewed: Colombia 7/39 = 18.0%, Germany 4/51 = 7.8%, France 3/53 = 5.7%, Brazil 4/100 = 4.0%, Mexico 7/203 = 3.4%, US 8/310 = 2.6%, Great Britain 0/53; Latin American storefronts 25/458 = 5.5% against 2.9% in the high-spend group; device models skew to iPhone 11 and recent iOS 26.x

- **Where:** §4.1 Geography of the launch blocker — Colombia 18.0%, Germany 7.8%, France 5.7%, Brazil 4.0%, Mexico 3.4%, US 2.6%, GB 0.0%; Latin America 5.5% vs 2.9% high-spend
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** co 18.0% · de 7.8% · fr 5.7% · br 4.0% · mx 3.4% · us 2.6% · gb 0.0%
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** app-specific
- **Canonical:** C031 Crashes / launch failures

### R25-137 — Seven storefronts ≥50 (us 310, mx 203, br 100, fr 53, gb 53, de 51, ca 50 = 820, 62.64%) with per-storefront n, mean, 5★%, 1★% and theme rates (cap, monetisation friction, pop-ups, price objection, price praise, billing, blocker, confusing, ADHD, simple, UI, lifetime, time-of-day); rating distributions carry the weight, theme rates for non-English storefronts are lower bounds

- **Where:** §8.1 Eligibility; §8.2 All 7 eligible storefronts table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** cc | n | mean | 5★% | 1★% | cap | mon-friction | pop-ups | price-obj | price-praise | billing | blocker | confusing | ADHD | simple | UI | lifetime | time-of-day ; us | 310 | 3.77 | 54.5 | 19.7 | 13.9 | 23.2 | 3.5 | 5.5 | 7.1 | 2.9 | 2.6 | 2.6 | 5.8 | 11.9 | 6.5 | 4.2 | 2.3 ; mx | 203 | 3.82 | 60.6 | 20.2 | 6.9 | 16.7 | 2.0 | 4.9 | 2.0 | 3.0 | 3.4 | 2.0 | 2.0 | 6.9 | 1.0 | 1.0 | 2.5 ; br | 100 | 3.62 | 53.0 | 21.0 | 14.0 | 28.0 | 4.0 | 4.0 | 9.0 | 4.0 | 4.0 | 5.0 | 2.0 | 13.0 | 3.0 | 3.0 | 5.0 ; fr | 53 | 3.25 | 39.6 | 30.2 | 11.3 | 30.2 | 5.7 | 1.9 | 3.8 | 3.8 | 5.7 | 3.8 | 5.7 | 17.0 | 5.7 | 1.9 | 5.7 ; gb | 53 | 4.06 | 60.4 | 13.2 | 3.8 | 17.0 | 1.9 | 1.9 | 11.3 | 1.9 | 0.0 | 0.0 | 9.4 | 18.9 | 15.1 | 9.4 | 0.0 ; de | 51 | 3.53 | 49.0 | 25.5 | 2.0 | 17.6 | 5.9 | 5.9 | 2.0 | 2.0 | 7.8 | 3.9 | 3.9 | 5.9 | 5.9 | 7.8 | 0.0 ; ca | 50 | 3.62 | 54.0 | 22.0 | 18.0 | 26.0 | 0.0 | 6.0 | 6.0 | 4.0 | 2.0 | 4.0 | 4.0 | 12.0 | 6.0 | 6.0 | 2.0 ; GLOBAL | 1,309 | 3.67 | 55.2 | 23.1 | 10.5 | 22.8 | 2.7 | 4.2 | 4.9 | 3.4 | 3.9 | 2.1 | 3.1 | 9.6 | 4.7 | 3.4 | 2.2
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R25-138 — The US (23.7% of reviews) is the most articulate market in both directions: highest cap-complaint rate of any large market (13.9%), highest price objection (5.5%, and the highest figures named — $13/mo, $49 lifetime, '$40???'), highest ADHD rate (5.8%, sub-group mean 4.5+), most of the corpus's deep feature feedback (statistics critique, bad-habit modelling, Health weight read as entry count, every-N-days reminders), and 1★ at 19.7% below the global 23.1% — simultaneously the most demanding and the least hostile large market

- **Where:** §8.3 United States — n=310, mean 3.77: highest cap complaint (13.9%), price objection (5.5%, highest figures named), ADHD (5.8%); most of the deep feature feedback; 1★ 19.7% below global — most demanding and least hostile
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=310, mean 3.77; cap 13.9%; price 5.5%; ADHD 5.8%; 1★ 19.7%
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `11344752179`, `11580010213`, `12038603986`, `12205388546`, `12237531738`, `12594456123`, `12752860443`, `13318920074`, `13591778534`, `13680547908`, `11100933308`, `12407220130`, `12428670326`, `13567924370`, `12993678135`, `11419872344`, `12083216920`, `12320067097`, `12473059347`, `12563804333`, `13158925619`, `13751037946`, `13874254043`, `11694650718`, `12584418650`, `13976982513`, `12778092747`, `13502878041`, `12615038002`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C064 Price level — where 'fair' turns into 'too expensive'

### R25-139 — Mexico (15.5% of the corpus) is behaviourally distinct: cap complaints half the US rate (6.9% vs 13.9%), UI praise almost absent (1.0% vs 6.5%), 110 of 203 reviews (54.2%) ≤60 characters — short, affective, outcome-framed ('me cambió la vida', '10/10'); price confusion is a Mexico-specific repeated issue — three reviewers cannot tell whether the displayed price is pesos or dollars, others name MXN 500 lifetime, 40/month, 300/month, 599 charged, 299.99/yr — a pricing-display problem that is cheap to fix; launch blocker 3.4% with iPhone 11 named; billing 3.0% including 'No domicilien su tarjeta'

- **Where:** §8.4 Mexico — n=203, mean 3.82: cap complaints half the US rate, UI praise almost absent, 54.2% of reviews ≤60 chars, short affective outcome-framed reviews; price confusion pesos vs dollars is a Mexico-specific repeated issue — a pricing-display problem, cheap to fix
- **This app does:** price shown without a clear currency
- **User reaction:** mixed
- **Magnitude:** n=203, mean 3.82; cap 6.9%; UI 1.0%; 54.2% ≤60 chars; 8 price-figure reviews
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12319455814`, `13290152980`, `14164700184`, `13582066669`, `11856825871`, `12426258734`, `13150343490`, `14228794250`, `13970830961`, `14512117424`
- **Canonical:** C092 Regional pricing; C113 One stable, disclosed price — no discount wheels

### R25-140 — Brazil: highest monetisation-friction rate of any eligible storefront (28.0%) and joint-highest cap (14.0%), yet also the highest price-praise outside gb (9.0%) and a strong power-user contingent (one benchmarks Grit against Strides, Done, Habitify and Streaks and picks Grit); highest time-of-day request rate (5.0%) with the clearest intra-day-reminder requests; confusing-UX 5.0% with two asking for a tutorial video; one unverified severe single claim that the app 'contaminates' iOS, recorded and not promoted

- **Where:** §8.5 Brazil — n=100, mean 3.62: highest monetisation friction (28.0%), joint-highest cap (14.0%), highest price praise outside gb (9.0%), highest time-of-day request (5.0%), highest confusing-UX (5.0%) with two asking for a tutorial video; one unverified 'contaminating iOS' claim recorded not promoted
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=100, mean 3.62; friction 28.0%; cap 14.0%; price praise 9.0%; time-of-day 5.0%; confusing 5.0%
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `13516169817`, `12652539241`, `12592966841`, `13601387355`, `14394846065`, `13466380366`, `13082959947`, `12735223010`, `13640099595`, `12074101853`
- **Canonical:** C075 Skippable, replayable onboarding tour; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R25-141 — France is the worst-performing eligible market (mean 3.25, 5★ 39.6%, 1★ 30.2%, monetisation friction 30.2%, pop-ups 5.7%, blocker 5.7%) — where every negative mechanism appears at once and is described most precisely: 10 pop-ups in 20 seconds; the single most useful negative review (pop-ups opening on top of each other, €9.90 monthly vs €4.99 expectation, a forced €35 annual for a 7-day trial, a colour-transparency defect, the editor losing text, and the observation that explosive pop-ups are actively harmful for ADHD users); two independent post-payment breakages three weeks apart; a purchaser asking others whether they also cannot open the app — against strong advocacy ('ça a changé ma vie'; bought as a Christmas present; a UX/UI designer's endorsement); not a market with different tastes but the highest-information subset for debugging

- **Where:** §8.6 France — n=53, mean 3.25, the worst eligible market: every negative mechanism at once, documented most precisely; the single most useful negative review (pop-ups stacking, €9.90 vs €4.99, forced €35 annual for a 7-day trial, transparency defect, editor losing text, pop-ups harmful for ADHD); treat French reviews as the highest-information subset for debugging
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** n=53, mean 3.25, 5★ 39.6%, 1★ 30.2%, friction 30.2%
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `13469881270`, `13493408148`, `13299143006`, `13358500440`, `12445721095`, `12158111543`, `13541796215`, `12617239758`, `13479000146`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C139 Cache entitlements locally — never block a paid surface on a live server check

### R25-142 — Great Britain is the best-performing eligible market (mean 4.06, 1★ 13.2%, zero launch-blocker and zero confusing-UX reports, highest price praise 11.3%, UI praise 15.1%, lifetime mention 9.4%, ADHD 9.4%, lowest cap complaint 3.8%) — what the product looks like when the paywall and the blocker are not in the way; it still carries two purchase-recognition failures and the starkest expression of the motivational-design risk: 'I clicked, paid £29.99 and I don't even know why… I get to see all the things I haven't done and feel bad'

- **Where:** §8.7 Great Britain — n=53, mean 4.06, the best eligible market: zero blocker, zero confusing-UX, highest price praise (11.3%), UI praise (15.1%), lifetime (9.4%), ADHD (9.4%), lowest cap complaint (3.8%) — what the product looks like when the paywall and the blocker are not in the way
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** n=53, mean 4.06, 1★ 13.2%; blocker 0.0%
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `10305734583`, `12178717768`, `13093563693`, `13162425122`, `12352612203`, `13295518495`, `14070420374`, `12421210064`, `13178225257`, `13184003965`, `13418259698`
- **Canonical:** C095 Neutral, non-judgemental tone on failure

### R25-143 — Germany: highest launch-blocker rate of any eligible storefront (7.8%, plus a purchase sheet that shows no price at all), joint-highest pop-up rate (5.9%), lowest cap rate (2.0%) — German reviewers object to the principle of subscription rather than the cap number ('One-time payment €50 or subscription. No, on principle') — and a strong lifetime-buyer contingent (7.8%)

- **Where:** §8.8 Germany — n=51, mean 3.53: highest launch-blocker (7.8%), purchase sheet shows no price at all, joint-highest pop-ups (5.9%), lowest cap rate (2.0%) — Germans object to the principle of subscription not the number ('Einmalzahlung 50€ oder abo. nö aus prinzip nicht'); strong lifetime-buyer contingent (7.8%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=51, mean 3.53; blocker 7.8%; pop-ups 5.9%; cap 2.0%; lifetime 7.8%
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `12511628434`, `14049857126`, `14121146392`, `14058780350`, `13660452698`, `14244904942`, `14402453472`, `12199187753`, `12478039620`, `13811962013`, `12486962813`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C031 Crashes / launch failures; C113 One stable, disclosed price — no discount wheels

### R25-144 — Canada has the highest cap-complaint rate in the corpus (18.0%, 9/50), the corpus's only clinician endorsement from a practising psychologist, and the worst single support interaction

- **Where:** §8.8 Canada — n=50, mean 3.62: highest cap-complaint rate in the corpus (18.0%); the only practising-psychologist endorsement and the worst single support interaction
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=50, mean 3.62; cap 18.0%
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `11313871020`, `12160653252`, `12178208955`, `12370423568`, `12507825966`, `12975736508`, `13285849912`, `13680836881`, `13759652099`, `12404912935`, `14422160795`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R25-145 — Group A high-spend markets (external-knowledge definition; no spend figure in the data): n=551 (42.1%), mean 3.74, 5★ 53.9%, 1★ 20.1%; cap 11.6%, friction 22.5%, price objection 4.7%, price praise 6.5%, billing 2.7%, blocker 2.9%, ADHD 5.8%, UI praise 7.1%, lifetime 5.1% — rest of world (82 storefronts, n=758): mean 3.62, 5★ 56.1%, 1★ 25.2%, cap 9.8%, friction 23.0%, price 3.8%, praise 3.7%, billing 3.8%, blocker 4.6%, ADHD 1.2%, UI 3.0%, lifetime 2.1%; the groups are close on sentiment and identical on monetisation friction — the paywall objection is global, not a low-income-market phenomenon; high-spend markets are 1.75× more likely to praise the price and 2.4× to discuss lifetime, the rest 1.6× more likely to hit the blocker and 1.4× to report billing; ADHD self-identification 4.8× higher in high-spend markets is a vocabulary/diagnosis-prevalence difference, not a needs difference

- **Where:** §8.9 Group A high-spend (us, cn, jp, gb, de, fr, ca, au, kr; external-knowledge definition) n=551 (42.1%), mean 3.74 vs rest of world n=758, mean 3.62: identical monetisation friction (22.5% vs 23.0%) — the paywall objection is global; high-spend 1.75× price praise, 2.4× lifetime, 4.8× ADHD vocabulary; rest of world 1.6× blocker, 1.4× billing
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 3.74 vs 3.62; friction 22.5% vs 23.0%; ADHD 5.8% vs 1.2%
- **Direction for us:** research · **Report confidence:** corpus-level fact (definition disclosed) · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C062 Weight English-speaking rich markets; volume ≠ revenue

### R25-147 — Spanish-language storefronts as a block (mx, ar, co, cl, pe, es, uy, py, bo, cr, do, hn, sv, ai; n=396, 30.3%, mean 3.65, 5★ 57.6%, 1★ 25.0%; friction 23.2%, cap 10.4%, blocker 5.3%, billing 3.8%, price 4.0%): the launch blocker is 36% more common than globally and the paywall register markedly more hostile; Spain itself (n=37, limited evidence) is the positive outlier — mean 3.84, 5★ 67.6%, the highest cap-complaint rate in the block (30%) but four lifetime buyers and the corpus's biggest claimed outcome (45 kg lost)

- **Where:** §8.11 Spanish-language storefronts as a block — n=396 (30.3%), mean 3.65: launch blocker 36% more common (5.3% vs 3.9%), markedly more hostile paywall register; Spain (n=37) the positive outlier — mean 3.84, cap complaint 30% but four lifetime buyers and the biggest claimed outcome (45 kg)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=396; blocker 5.3% vs 3.9%; es 3.84
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `13848909054`
- **Canonical:** C031 Crashes / launch failures; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R25-148 — Argentina (n=40, limited evidence) is the most hostile storefront in the corpus — mean 2.95, 1★ 45.0%, monetisation friction 40.0%, billing disputes 10.0% — a rating profile so far from global (2.95 vs 3.67) that it warrants a look at Argentine pricing display and trial mechanics specifically

- **Where:** §8.12 Argentina (n=40, mean 2.95, 1★ 45.0%) — the most hostile storefront: monetisation friction 40.0%, billing 10.0% [limited evidence]; warrants a look at Argentine pricing display and trial mechanics
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** n=40, mean 2.95, 1★ 45.0%, friction 40.0%, billing 10.0%
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `14108338899`, `13785386255`, `14354427615`, `14412839520`, `14499643643`, `14509705008`, `13731572727`, `14177608913`, `14329860383`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R25-150 — Colombia (n=39, limited evidence) has the highest launch-blocker rate anywhere — 7/39 = 18.0%, all between May and July 2026; seven independent same-symptom reports in three months is a strong hint the bug localises (region, locale or device mix)

- **Where:** §8.12 Colombia (n=39) — the highest launch-blocker rate anywhere: 18.0% (7/39), all May–Jul 2026, seven independent same-symptom reports in three months — a strong localisation-of-the-bug hint
- **This app does:** first-run freeze concentrated in one storefront
- **User reaction:** 1★-burst
- **Magnitude:** 7/39 = 18.0%, May–Jul 2026
- **Direction for us:** must-never-break · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `14021915764`, `14112998455`, `14183996590`, `14262738292`, `14280631397`, `14308159391`, `14312587468`
- **Canonical:** C031 Crashes / launch failures

### R25-151 — Kazakhstan (n=11, mean 2.27, 1★ 54.5%) and the Philippines (n=12, mean 2.50, 1★ 58.3%) are the two worst small storefronts, both dominated by paywall complaints; Kazakhstan adds a Russian-language request and a freeze report on iPhone 16 Pro / iOS 26.5

- **Where:** §8.12 Kazakhstan (n=11, mean 2.27, 1★ 54.5%) and Philippines (n=12, mean 2.50, 1★ 58.3%) — worst small storefronts, dominated by paywall complaints; Kazakhstan adds a Russian-language request and an iPhone 16 Pro / iOS 26.5 freeze
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** kz 2.27 (n=11); ph 2.50 (n=12)
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `13665509275`, `14065834606`
- **Canonical:** — (nuance register)

### R25-152 — Korea (n=4) and China (n=4) are 100% 5★ and 75%/50% localisation requests — 'PLS ADD KOREAN'; a lifetime buyer who cannot get Korean time or language; 'If there is Chinese, it will definitely be loved by the Chinese market' — tiny samples, unanimous sentiment, zero complaints about anything else; these storefronts are currently reached only by users tolerant of an English UI

- **Where:** §8.12 Korea (n=4) and China (n=4) — 100% 5★ and 75%/50% localisation requests ('PLS ADD KOREAN'; 'If there is Chinese, it will definitely be loved by the Chinese market'); reached only by users tolerant of an English UI
- **This app does:** no Korean / Chinese localisation
- **User reaction:** complaint
- **Magnitude:** kr 3/4; cn 2/4; all 5★
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `14031771936`, `13851595402`, `13726894767`, `13516376674`, `14196537060`
- **Canonical:** C027 Localise early — it unlocks revenue

### R25-153 — Russia (n=12, mean 4.67, 91.7% 5★), Vietnam (n=11, 4.73) and the Netherlands (n=11, 4.45) are the best small storefronts; the Russian set includes the most detailed design critique in the corpus — a lifetime buyer with ADHD who compares Grit favourably to Habitica, asks for a minimal heat-map widget like HabitKit/Ripples, and argues the statistics screen should answer why a habit failed via a mood/energy tracker

- **Where:** §8.12 Russia (n=12, mean 4.67), Vietnam (n=11, 4.73), Netherlands (n=11, 4.45) — best small storefronts; the Russian set holds the most detailed design critique: a lifetime buyer with ADHD asks for a minimal heat-map widget like HabitKit/Ripples and argues statistics should answer why a habit failed via a mood/energy tracker
- **This app does:** no heat-map widget; stats do not explain failure
- **User reaction:** praise
- **Magnitude:** ru 4.67 (n=12); vn 4.73; nl 4.45
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `14139271437`
- **Canonical:** C009 Basic widgets, icons and colours are free; C012 Week / month / year grid views; C049 Mood tracker

### R25-154 — By-country patterns: launch blocker co 18.0% / de 7.8% / fr 5.7% / Spanish block 5.3% vs gb 0.0%; cap complaint ca 18.0% / us 13.9% / br 14.0% / es 30% vs de 2.0% / gb 3.8%; price praise & lifetime appetite gb 11.3%/9.4%, br 9.0%, de 7.8% vs mx 2.0%; billing ar 10.0%, id 27% (n=11), br 4.0% vs gb 1.9%; localisation demand tr 41%, kr 75%, cn 50%, it 17%, ru/ua; currency/price-display confusion mx (4), in (1), pe (1); pop-up hostility fr 5.7%, de 5.9%; ADHD vocabulary gb 9.4%, us 5.8%, fr 5.7% vs rest 1.2%; short affective reviews mx (49.8% ≤60 chars); no cultural generalisation drawn

- **Where:** §8.13 What genuinely varies by country (verbatim table) — blocker, cap complaint, price praise / lifetime appetite, billing, localisation demand, currency confusion, pop-up hostility, ADHD vocabulary, short affective reviews; no cultural generalisation drawn
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Pattern | Where | Section ; Launch blocker | co 18.0%, de 7.8%, fr 5.7%, Spanish block 5.3% vs gb 0.0% | 4.1, 8.12 ; Cap complaint | ca 18.0%, us 13.9%, br 14.0%, es 30% vs de 2.0%, gb 3.8% | 8.2 ; Price praise / lifetime appetite | gb 11.3%/9.4%, br 9.0%, de 7.8% vs mx 2.0% | 8.2 ; Billing dispute | ar 10.0%, id 27% [n=11], br 4.0% vs gb 1.9% | 4.3, 8.12 ; Localisation demand | tr 41%, kr 75%, cn 50%, it 17%, ru/ua | 8.12 ; Currency/price-display confusion | mx (4 reviews), in (1), pe (1) | 8.4 ; Pop-up hostility | fr 5.7%, de 5.9% | 4.2 ; ADHD vocabulary | gb 9.4%, us 5.8%, fr 5.7% vs rest-of-world 1.2% | 8.9 ; Short affective reviews | mx (49.8% of reviews ≤60 chars) | 8.4
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R25-170 — Localisation is cheap share — Turkey, Korea, China, Italy and the Russian-speaking storefronts are asking, and the Turkish case proves the review stream responds

- **Where:** Part 10 #7 — localisation is cheap share: Turkey, Korea, China, Italy and Russian-speaking storefronts are asking, and the Turkish case proves the review stream responds
- **This app does:** partial localisation
- **User reaction:** complaint
- **Magnitude:** 21 requests; 1 shipped
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R25-194 — Ship Russian, Korean, Chinese and Italian (Turkish has shipped) — 21 requests, rising; Korean and Chinese storefronts are currently 100% 5★ and effectively ask for nothing else

- **Where:** §11.5 Part 11 #22 — ship Russian, Korean, Chinese and Italian (Turkish has shipped); Korean and Chinese storefronts are 100% 5★ and ask for nothing else
- **This app does:** partial localisation
- **User reaction:** complaint
- **Magnitude:** 21 requests
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R25-007 — Paid-reviewer satisfaction is collapsing — the business-critical trend: explicit payers E1 (2023-05→2024-12) n=13 mean 4.23 → E2 (2025) n=25 mean 3.16 → E3 (2026) n=19 mean 2.68; within the 57 explicit payers 8 (14.0%) raise a billing dispute (mean 1.12), 5 (8.8%) report losing access to something already bought (mean 1.40), 5 (8.8%) report reliability failure (mean 1.80)

- **Where:** Executive summary #3 — paid-reviewer satisfaction is collapsing: explicit payers E1 mean 4.23 → E2 3.16 → E3 2.68; 14% raise a billing dispute, 8.8% lost access to something bought, 8.8% reliability failure
- **This app does:** paid experience degrading
- **User reaction:** churn
- **Magnitude:** 4.23 → 3.16 → 2.68 (n=13/25/19); 14.0% billing; 8.8% lost access; 8.8% reliability
- **Direction for us:** must-never-break · **Report confidence:** meaningful; small n · **Generalisable:** yes
- **Review IDs:** `12379398566`, `12473304418`, `13178225257`, `13184003965`, `13528421192`, `13599650667`, `13605686247`, `14355199654`, `14132304435`, `14379122842`, `14486983673`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R25-015 — Several of the 11 edited reviews are visible downward revisions from formerly loyal users

- **Where:** §1.3 is_edited — several are visible rating revisions downward ('Moved to 3 stars because they're not listening'; 'I did love this app, but now looking for another')
- **This app does:** loyal users revising down
- **User reaction:** churn
- **Magnitude:** 11 is_edited
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `11312965919`, `12152603849`, `12247101227`, `12394918811`, `12658607281`, `12839381685`, `13410996727`, `13660452698`, `13976982513`, `14045743771`, `14122841864`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R25-019 — Per year: 2023 n=21 mean 4.67 (substantive 4.56); 2024 215 / 3.79 (3.76); 2025 487 / 3.66 (3.51); 2026 586 / 3.60 (3.10) — the substantive series falls three times faster than the headline

- **Where:** §1.6 By year table (verbatim) — all-records mean 4.67 → 3.79 → 3.66 → 3.60 vs substantive 4.56 → 3.76 → 3.51 → 3.10
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Year | n | mean | 5★ % | 1★ % | substantive n | substantive mean ; 2023 (from 22 May) | 21 | 4.67 | 76.2 | 0.0 | 16 | 4.56 ; 2024 | 215 | 3.79 | 52.6 | 17.7 | 175 | 3.76 ; 2025 | 487 | 3.66 | 54.0 | 22.2 | 339 | 3.51 ; 2026 (to 6 Sep) | 586 | 3.60 | 56.3 | 26.6 | 271 | 3.10
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R25-021 — Eras chosen from corpus volume: E1 (2023-05-22 → 2024-12-31, n=236, 18.03%, mean 3.87, substantive 3.83); E2 (2025, n=487, 37.20%, 3.66 / 3.51); E3 (2026 to 6 Sep, n=586, 44.77%, 3.60 / 3.10)

- **Where:** §1.6 Eras table (verbatim) — E1 2023-05→2024-12 n=236 mean 3.87 / substantive 3.83; E2 2025 n=487 3.66 / 3.51; E3 2026 n=586 3.60 / 3.10
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Era | Window | n | % of corpus | mean | substantive mean ; E1 | 2023-05-22 → 2024-12-31 | 236 | 18.03% | 3.87 | 3.83 ; E2 | 2025-01-01 → 2025-12-31 | 487 | 37.20% | 3.66 | 3.51 ; E3 | 2026-01-01 → 2026-09-06 | 586 | 44.77% | 3.60 | 3.10
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R25-109 — Monetisation friction appears to fall across eras in the all-records series (27.1% → 24.0% → 20.0%) only because the E3 flood of short prompt-driven 5★ reviews dilutes the denominator; among substantive reviews it is flat-to-rising (29.8% → 27.7% → 31.7%) — the cleaner statement

- **Where:** §4.2 Cluster 2 — the paywall architecture: era share falls 27.1% → 24.0% → 20.0% in all records but is flat-to-rising among substantive reviews 29.8% → 27.7% → 31.7%
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 298 (22.77%); substantive 57/191 → 94/339 → 86/271
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R25-127 — Explicit payers: E1 13 (5.5% of era, mean 4.23) → E2 25 (5.1%, 3.16) → E3 19 (3.2%, 2.68) — a 1.55-point drop in the segment that pays while the headline mean falls 0.27; small n makes the magnitude uncertain but the direction matches every other paid-side metric (premium-lost all E2/E3; billing 5×; support praise halves)

- **Where:** §6.2 Explicit payers by era (verbatim table) — 13 / 25 / 19; mean 4.23 → 3.16 → 2.68, a 1.55-point drop while the headline falls 0.27
- **This app does:** paid experience degrading
- **User reaction:** churn
- **Magnitude:** Era | Explicit payers | % of era | Mean ; E1 (2023-05→2024-12) | 13 | 5.5% | 4.23 ; E2 (2025) | 25 | 5.1% | 3.16 ; E3 (2026) | 19 | 3.2% | 2.68
- **Direction for us:** must-never-break · **Report confidence:** meaningful; small n · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R25-149 — Turkey (n=22, mean 3.05): localisation is the dominant theme at 41%, and the corpus contains both the complaint and its resolution — eight Turkish-language requests across Jan–Jun 2026 followed on 27 Jul 2026 by 'Turkish language support at laaast! 🌟' — the clearest shipped-fix-visible-in-reviews event in the corpus; Turkish paywall hostility nonetheless remains high afterwards ('Paragöz uygulama')

- **Where:** §8.12 Turkey (n=22) — localisation is 41% of reviews; eight requests Jan–Jun 2026 then 'Türkçe dil desteği sonundaaa! 🌟' (27 Jul 2026): the clearest shipped-fix-visible-in-reviews event; paywall hostility remains high afterwards
- **This app does:** shipped Turkish localisation Jul 2026
- **User reaction:** praise
- **Magnitude:** 9 of 22 (41%); 8 requests → 1 celebration; 3 later paywall complaints
- **Direction for us:** do · **Report confidence:** limited evidence, dated event · **Generalisable:** yes
- **Review IDs:** `13594690935`, `13626281388`, `13773963617`, `13879600636`, `14000487655`, `14086642042`, `14113669784`, `14185006535`, `14353986952`, `14464596970`, `14495136368`, `14518961910`
- **Canonical:** C027 Localise early — it unlocks revenue; C059 Be visibly responsive; fixes bring reviewers back

### R25-156 — Substantive sentiment falls three times faster than the headline: all records 3.87 → 3.66 → 3.60 (−0.27) vs substantive 3.83 → 3.51 → 3.10 (−0.73); 1★ share all 16.1% → 22.2% → 26.6% (+10.5pp) vs substantive 16.2% → 23.3% → 35.1% (+18.9pp); substantive 5★ 51.3% → 47.5% → 39.9% — among people who write more than a sentence, one in three now leaves one star

- **Where:** §9.2 Trend 1 — substantive sentiment falls three times faster than the headline [very strong] (verbatim table): all 3.87 → 3.66 → 3.60 (−0.27) vs substantive 3.83 → 3.51 → 3.10 (−0.73); substantive 1★ 16.2% → 23.3% → 35.1%; substantive 5★ 51.3% → 39.9% — one in three substantive reviewers now leaves one star
- **This app does:** review prompt masks deterioration
- **User reaction:** churn
- **Magnitude:** Series | E1 | E2 | E3 | Δ ; All records | 3.87 | 3.66 | 3.60 | −0.27 ; Substantive (>60 chars) | 3.83 | 3.51 | 3.10 | −0.73 ; 1★ share (all) | 16.1% | 22.2% | 26.6% | +10.5pp ; 1★ share (substantive) | 16.2% | 23.3% | 35.1% | +18.9pp ; 5★ share (substantive) | 51.3% | 47.5% | 39.9% | −11.4pp
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R25-157 — The launch blocker is the fastest-rising theme — 1.3% → 2.9% → 5.8%, high-priority within 2026, with 27 of the 34 E3 reports concentrated in May–July 2026 and in Colombia, Mexico, Germany, France; the first thing to fix

- **Where:** §9.3 Trend 2 — the launch blocker is the fastest-rising theme [very strong]: 1.3% → 2.9% → 5.8%; 27 of 34 E3 reports in May–Jul 2026; the first thing to fix
- **This app does:** first-run freeze
- **User reaction:** 1★-burst
- **Magnitude:** 3/236 → 14/487 → 34/586; 27 of 34 May–Jul 2026
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R25-158 — Billing disputes stepped up ~5× after 2024 and stayed — 0.8% (2/236) → 3.9% (19/487) → 3.9% (23/586); the E1 baseline of two reviews in 19 months is the important comparator: this is not a constant background rate

- **Where:** §9.4 Trend 3 — billing disputes stepped up ~5× after 2024 and stayed [very strong]: 0.8% → 3.9% → 3.9%; the E1 baseline of 2 reviews in 19 months shows this is not a constant background rate
- **This app does:** billing mechanics changed 2025
- **User reaction:** 1★-burst
- **Magnitude:** 2 → 19 → 23; 0.8% → 3.9% → 3.9%
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial

### R25-159 — Paid-reviewer satisfaction falls faster than anything else — mean 4.23 → 3.16 → 2.68 across 13/25/19 explicit payers — supported independently by premium-lost reviews existing only in E2/E3 (0 → 6 → 2), the billing step-up, and support praise halving (3.0% → 1.6% → 0.9%)

- **Where:** §9.5 Trend 4 — paid-reviewer satisfaction falls faster than anything else [meaningful; small n]: 4.23 → 3.16 → 2.68; premium-lost only in E2/E3 (0 → 6 → 2); support praise halving
- **This app does:** paid experience degrading
- **User reaction:** churn
- **Magnitude:** 4.23 → 3.16 → 2.68; premium-lost 0 → 6 → 2
- **Direction for us:** must-never-break · **Report confidence:** meaningful; small n · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R25-160 — Every praise theme falls across eras — simplicity 13.6% → 11.7% → 6.3%, interface 8.1 → 5.7 → 2.6%, customisation 6.8 → 7.8 → 1.9%, motivation 9.7 → 7.8 → 3.9%, Apple Health 5.5 → 2.9 → 0.9%, widgets 5.1 → 2.7 → 0.9%, Watch 3.0 → 2.1 → 0.7%, price praised 8.5 → 6.4 → 2.2%, support 3.0 → 1.6 → 0.9%, competitor abandoned 4.2 → 3.7 → 1.5% — the platform-integration themes fall hardest (80–85%); part is mechanical (shorter reviews name fewer features) but the drop is steeper than length alone and not matched by any specific feature complaint rising — the corpus is shifting from evaluative users who explored the product to prompt-driven users who never got past the first screens

- **Where:** §9.6 Trend 5 — praise vocabulary thins across every dimension [very strong] (verbatim table): simplicity 13.6 → 6.3%, interface 8.1 → 2.6%, customisation 6.8 → 1.9%, motivation 9.7 → 3.9%, Health 5.5 → 0.9%, widgets 5.1 → 0.9%, Watch 3.0 → 0.7%, price praised 8.5 → 2.2%, support 3.0 → 0.9%, competitor abandoned 4.2 → 1.5%; platform-integration themes fall 80–85%
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Praise theme | E1 | E2 | E3 ; Simplicity | 13.6% | 11.7% | 6.3% ; Interface | 8.1% | 5.7% | 2.6% ; Customisation | 6.8% | 7.8% | 1.9% ; Motivation / streaks | 9.7% | 7.8% | 3.9% ; Apple Health | 5.5% | 2.9% | 0.9% ; Widgets | 5.1% | 2.7% | 0.9% ; Apple Watch | 3.0% | 2.1% | 0.7% ; Price praised | 8.5% | 6.4% | 2.2% ; Support / developer | 3.0% | 1.6% | 0.9% ; Competitor abandoned for Grit | 4.2% | 3.7% | 1.5%
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R25-161 — The cap complaint is being replaced by a broader, angrier one: cap-specific complaints fall 17.4% → 11.9% → 6.7% while general 'you can't use it without paying' holds 16.9% → 10.5% → 12.3% and survey-then-paywall appears only in E2/E3 (0 → 0.2% → 0.9%); read with editing gated from Nov 2025, reviewers are increasingly describing the whole app as locked rather than a habit limit — whether a real tightening or an accumulation of paywall surfaces is the highest-priority verification question

- **Where:** §9.7 Trend 6 — the cap complaint is being replaced by a broader, angrier one [meaningful]: cap-specific 17.4% → 11.9% → 6.7% while general 'can't use it without paying' holds 16.9% → 10.5% → 12.3% and survey-then-paywall appears 0 → 0.2% → 0.9%; reviewers increasingly describe the whole app as locked
- **This app does:** paywall surfaces accumulating
- **User reaction:** 1★-burst
- **Magnitude:** 17.4 → 11.9 → 6.7% vs 16.9 → 10.5 → 12.3%; 0 → 0.2 → 0.9%
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R25-162 — Localisation demand is new and growing — 0% (0/236) → 1.0% (5/487) → 2.7% (16/586), driven by Turkish (9), Korean (3), Chinese (2), Italian (3), Russian/Ukrainian (3), Japanese (1) — and one request was answered: Turkish arrived ~July 2026, the corpus's proof that shipping a request changes the review stream

- **Where:** §9.8 Trend 7 — localisation demand is new and growing [meaningful]: 0% → 1.0% → 2.7%, Turkish 9, Korean 3, Chinese 2, Italian 3, Russian/Ukrainian 3, Japanese 1; one request answered (Turkish ~Jul 2026) — proof that shipping a request changes the review stream
- **This app does:** shipped Turkish; others pending
- **User reaction:** mixed
- **Magnitude:** 0 → 5 → 16; 21 total (1.60%)
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14353986952`
- **Canonical:** C027 Localise early — it unlocks revenue; C059 Be visibly responsive; fixes bring reviewers back

## Positioning

### R25-001 — Grit — Daily Habit Tracker · Routines & Goals ADHD Planner (App Store ID 6446997766) — a young (May 2023→) single-developer freemium tracker with a hard 3-habit free cap, then monthly / annual / lifetime IAP, no ads; a monetisation corpus, not a feature corpus

- **Where:** header lines 1-9; §12.4 External sources
- **This app does:** developer of record GrittyApps (a single maker, 'Stephan'); bundle stoope.Grit; extracted 8 Sep 2026; analysis 11 Sep 2026; store rank 25; free 3-habit cap → monthly/annual/lifetime
- **User reaction:** mixed
- **Magnitude:** 1,309 reviews · 91 storefronts · 22 May 2023 → 6 Sep 2026; mean 3.671; 5★ 722 (55.16%) / 4★ 122 (9.32%) / 3★ 79 (6.04%) / 2★ 84 (6.42%) / 1★ 302 (23.07%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R25-009 — The product's genuine moat is configurability plus Apple-platform depth, stated in unusually specific terms — simplicity/ease (mean 4.20), customisation/groups/colours (4.49), interface (4.42), Apple Health, widgets (4.43), Apple Watch (4.48), built-in timer (4.60); 37 reviews arrive after explicitly abandoning Streaks, Habitify, Habitica, HabitKit, Strides, Done, Me+, Ripples, Tiimo or Habit — 'I have tried them all and this is the one'

- **Where:** Executive summary #5 — the genuine moat is configurability plus Apple-platform depth; 37 arrive after abandoning a named competitor ('I have tried them all and this is the one')
- **This app does:** deep customisation + Health/Watch/widgets/Mac
- **User reaction:** purchase-driver
- **Magnitude:** simplicity 126 (9.63%, 4.20); customisation 65 (4.97%, 4.49); interface 62 (4.74%, 4.42); Health 32 (2.44%); widgets 30 (2.29%, 4.43); Watch 21 (1.60%, 4.48); timer 15 (1.15%, 4.60); switchers 37 (2.83%)
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10653626434`, `11656905076`, `12427277456`, `12584418650`, `13191422909`, `13470655832`, `13516169817`, `14342011720`, `14394846065`
- **Canonical:** C005 Know which competitors buyers compare against; C009 Basic widgets, icons and colours are free; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C134 Lead the store listing with what users actually love

### R25-056 — Competitor named — switched from / compared

- **Where:** §3.1 theme table #14 Competitor named (switched from / compared)
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 37 (2.83%, meaningful), mean 4.16, 5★ 24
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against

### R25-095 — Reviewers say the app feels first-party — 'went back to check if the app was made by apple'; ''Apple' design all over it'

- **Where:** §3.4 Feels like a first-party Apple app ('went back to check if the app was made by apple'; ''Apple' design all over it')
- **This app does:** native Apple design language
- **User reaction:** praise
- **Magnitude:** 4 named reviews
- **Direction for us:** do · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `11543202644`, `11656905076`, `12191332041`, `12752790900`
- **Canonical:** C057 Offer a non-pastel / premium design option; C134 Lead the store listing with what users actually love

### R25-105 — Competitors named (37, 2.83%), almost all as the app they left: Streaks 6 (outgrew it), Habitify 4 (too cluttered / no widget completion), Habitica 3 (over-complex, became work), Strides 3 (dull colours, weak sound), Done 2 (became buggy), HabitKit/Ripples 2 (better heat-map widget), Me+ 1, Tiimo 1 (better calendar import), Apple Reminders/Health/Notes/paper ~9 as the free alternative in paywall complaints

- **Where:** §3.6 Competitors named table (verbatim) — Streaks 6 (outgrew), Habitify 4 (cluttered / no widget completion), Habitica 3 (became work), Strides 3 (dull, weak sound), Done 2 (buggy), HabitKit/Ripples 2 (better heat-map widget), Me+ 1, Tiimo 1 (calendar import), Apple Reminders/Health/Notes/paper ~9 as the free alternative
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Competitor | Mentions | Direction ; Streaks | 6 | Outgrew it (11424393777, 11432101846, 13516169817, 10468572229, 10545731685) ; Habitify | 4 | Too cluttered / no widget completion (12778092747, 13516169817, 12357300364) ; Habitica | 3 | Over-complex, became work (12715120271, 14139271437, 13516169817) ; Strides | 3 | Dull colours, weak sound (10468572229, 12617239758, 13516169817) ; Done | 2 | Became buggy (12427277456, 13516169817) ; HabitKit / Ripples | 2 | Better heat-map widget (14139271437) ; Me+ | 1 | Switched to Grit (11055146979) ; Tiimo | 1 | Better calendar import (12904899932) ; Apple Reminders / Health / Notes / paper | ~9 | Named as the *free alternative* in paywall complaints (11735599652, 11839202129, 12405675497, 13731487622, 13291399300, 13759652099, 14486983673)
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11424393777`, `11432101846`, `13516169817`, `10468572229`, `10545731685`, `12778092747`, `12357300364`, `12715120271`, `14139271437`, `12617239758`, `12427277456`, `11055146979`, `12904899932`, `11735599652`, `11839202129`, `12405675497`, `13731487622`, `13291399300`, `13759652099`, `14486983673`
- **Canonical:** C005 Know which competitors buyers compare against

### R25-106 — Two competitive frames: among people who paid or intended to, the comparison set is other habit apps and Grit wins on configurability; among people who hit the paywall, the comparison set is Apple's own free apps and a paper notebook — a far harder frame (nine reviews make it explicitly)

- **Where:** §3.6 Two distinct competitive statements — payers compare other habit apps and Grit wins on configurability; paywall-hitters compare Apple's free apps and a paper notebook
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 9 free-alternative comparisons
- **Direction for us:** do · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R25-119 — The app is titled and marketed as a Routine / Planner for ADHD; reviewers who bought that promise expect time structure and find a checklist — 'Just a to-do list app'; 'it's a list of aims for the day, I get to see all the things I haven't done and feel bad' (a £29.99 purchaser) — the scheduling gap is the mechanism by which the positioning over-promises

- **Where:** §4.4 Why it is strategically significant — titled a Routine / Planner for ADHD, buyers expect time structure and find a checklist ('Just a to-do list app'; 'a list of aims for the day, I get to see all the things I haven't done and feel bad' — a £29.99 purchaser)
- **This app does:** 'planner' positioning without time
- **User reaction:** churn
- **Magnitude:** 3 named reviews
- **Direction for us:** do · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `14483086667`, `13418259698`
- **Canonical:** C183 A pre-planned, structured day is the outcome ADHD and autistic users praise; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R25-166 — The comparison set for a gated user is Apple Reminders and a paper notebook, not other habit apps (nine reviews say so explicitly) — a free tier must beat Reminders, not beat Streaks

- **Where:** Part 10 #3 — the comparison set for a gated user is Apple Reminders and a paper notebook, not other habit apps; a free tier must beat Reminders, not beat Streaks
- **This app does:** free tier below Reminders
- **User reaction:** churn
- **Magnitude:** 9 reviews
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

## Anti-patterns

### R25-062 — Confusing / unintuitive / no guidance

- **Where:** §3.1 theme table #20 Confusing / unintuitive / no guidance
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 27 (2.06%, meaningful), mean 2.70, 1★ 11
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C075 Skippable, replayable onboarding tour

### R25-087 — An onboarding survey followed by an immediate paywall — the whole first-run experience is spent, then gated

- **Where:** §3.1 #44 Onboarding survey then immediate paywall — mean 1.17, 83.3% 1★: the whole first-run experience is spent, then gated
- **This app does:** survey → paywall
- **User reaction:** 1★-burst
- **Magnitude:** 6 (0.46%, weak), mean 1.17, 83.3% 1★
- **Direction for us:** dont · **Report confidence:** weak, lowest mean · **Generalisable:** yes
- **Canonical:** C137 Show the paywall at the moment of need, not on app open; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R25-113 — The survey-then-paywall sequence — 'I did the whole survey and at the end I had to pay'; 'first 10 minutes of test… then it turns out you need a subscription' — is weak by rate but it is the highest-intent moment in the funnel and every one of these reviewers left 1★ or 2★, all in E2/E3

- **Where:** §4.2 (d) The survey-then-paywall sequence — '10 minutes of test… then it turns out you need a subscription'; the highest-intent moment in the funnel, every reviewer left 1–2★
- **This app does:** questionnaire → paywall
- **User reaction:** 1★-burst
- **Magnitude:** 6 (0.46%), mean 1.17
- **Direction for us:** dont · **Report confidence:** weak, high consequence · **Generalisable:** yes
- **Review IDs:** `14509705008`, `14383580728`, `14402453472`, `14440720875`, `12536378705`, `14156928722`
- **Canonical:** C137 Show the paywall at the moment of need, not on app open; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

## Things not to do

### R25-011 — The paywall is also a UX interruption that breaks the app's own audience promise: repeated full- or half-screen upsell pop-ups block ordinary navigation ('en 20 secondes j'ai eu 10 popup'; 'jedes Mal mit der Premium Version geworben… erst die App wieder schließen'; 'Eine Gewohnheitsapp die gleich mal mit dark pattern anfängt'), and one reviewer names it as 'hyper désagréable et malvenu pour des TDAH' in an app marketed to ADHD users

- **Where:** Executive summary #7 — the paywall is also a UX interruption and breaks the app's ADHD promise: repeated full/half-screen upsell pop-ups blocking navigation ('en 20 secondes j'ai eu 10 popup'; 'hyper désagréable et malvenu pour des TDAH')
- **This app does:** frequent upsell interstitials
- **User reaction:** complaint
- **Magnitude:** 35 (2.67%, meaningful), mean 1.80
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13469881270`, `12795905617`, `14130753059`, `13493408148`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

### R25-041 — Against: 4 of the 20 developer/support reviews are 1★, including a serious service failure — when contacted about habits not saving, 'the developer preferred to argue about what I could see on my end', and the reviewer cancelled their trial; 'Service client qui ne fait rien' after a €50 purchase

- **Where:** §2.4 Against — 4 of 20 are 1★; 'the developer preferred to argue about what I could see on my end' (cancelled trial); 'Service client qui ne fait rien' after €50
- **This app does:** argumentative support reply
- **User reaction:** churn
- **Magnitude:** 4 of 20 1★
- **Direction for us:** dont · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `14422160795`, `13299143006`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C189 Never post canned public replies — answer the specific complaint or don't reply

### R25-057 — Upsell pop-ups interrupt use

- **Where:** §3.1 theme table #15 Upsell pop-ups interrupt use
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 35 (2.67%, meaningful), mean 1.80, 1★ 20
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R25-081 — Review prompt fired before use

- **Where:** §3.1 theme table #39 Review prompt fired before use
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 (0.61%, emerging), mean 2.00, 1★ 5
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R25-112 — Navigation-blocking upsell: '10 popups in 20 seconds which kills the use'; 'freezes on the purchase screen every time I try any action'; 'not even my first second on the app 4 ads asking for payment'; a 5-second forced delay on the premium prompt; 'dark pattern'

- **Where:** §4.2 (c) Navigation-blocking upsell — '10 popups in 20 seconds'; 'trava na tela de compra toda vez que eu tento fazer qualquer ação'; 'not even my first second on the app 4 ads asking for payment'; a 5-second forced delay on the premium prompt
- **This app does:** interstitial paywall on every action
- **User reaction:** 1★-burst
- **Magnitude:** 35 (2.67%), mean 1.80
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13469881270`, `12795905617`, `13493408148`, `13148239554`, `13180600699`, `14130753059`, `14118775757`, `13843824722`, `14182312705`, `13219025626`, `11583743133`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R25-172 — An in-app review prompt at first launch buys a store rating and costs you your own telemetry — the headline mean is 0.22 points above the substantive mean and the gap is widening

- **Where:** Part 10 #9 — an in-app review prompt at first launch buys a store rating and costs your own telemetry; headline mean 0.22 above substantive and the gap widening
- **This app does:** first-launch review prompt
- **User reaction:** 5★-burst
- **Magnitude:** 3.60 vs 3.10 in E3 (0.50 gap); 0.22 overall
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R25-180 — Stop blocking navigation with upsell sheets — cap the prompt to one dismissible surface per session; 35 reviews, mean 1.80; the clearest conflict with the app's ADHD positioning

- **Where:** §11.2 Part 11 #8 — stop blocking navigation with upsell sheets; cap the prompt to one dismissible surface per session; the clearest conflict with the ADHD positioning
- **This app does:** interstitial upsells
- **User reaction:** complaint
- **Magnitude:** 35, mean 1.80
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13493408148`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

## Things to do

### R25-014 — Cheapest unshipped wins in evidence order: fix the launch freeze → make the free tier evaluable (time-boxed full access, or ~8–10 habits, and unlock read-only statistics) → make trial-to-paid-plan mapping explicit and put subscription management in-app → fix 'already paid, asked to pay again' → per-habit clock time with notification → stop blocking navigation with upsell pop-ups → ship Turkish, Russian, Korean, Chinese, Italian localisation

- **Where:** Executive summary #10 — cheapest unshipped wins in evidence order
- **This app does:** none shipped as of Sep 2026
- **User reaction:** complaint
- **Magnitude:** report gives none (ranked list)
- **Direction for us:** do · **Report confidence:** summary ranking · **Generalisable:** yes
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C027 Localise early — it unlocks revenue; C031 Crashes / launch failures; C033 Restore purchase and entitlements must work immediately; C093 No upsell nagging without a 'never ask again' option; C147 Let people use the product before they pay; C163 Visible monthly plan — annual-default trials drive billing disputes

### R25-040 — A responsive single-maker operation is unusually strong evidence in E1–E2 — feature requests implemented 'in less than 24hrs', an update within a day of an e-mail, a bug fixed 'within half a day', a suggestion shipped 'after merely a week', a subscription problem resolved 'sem burocracia', 'I can't believe one developer made this' (developer's first name Stephan appears) — but the praise-support rate thins 3.0% → 1.6% → 0.9% across eras, coinciding with the launch-blocker rise and the paid-satisfaction collapse

- **Where:** §2.4 Signals about the developer — responsive single-maker: requests implemented 'in less than 24hrs', update within a day of an e-mail, bug fixed 'within half a day', 'I can't believe one developer made this'; praise-support rate 3.0% → 1.6% → 0.9%
- **This app does:** solo developer, fast turnaround early, thinning
- **User reaction:** praise
- **Magnitude:** 20 (1.53%, mean 4.10); 3.0% → 1.6% → 0.9%
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10305734583`, `10590265798`, `12490332504`, `11793376300`, `12863353889`, `12171554899`, `12168338279`, `12404912935`, `13806651974`, `11061261761`, `12585991664`, `12152603849`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back; C071 Never ship and walk away

### R25-068 — Support / developer responsiveness

- **Where:** §3.1 theme table #26 Support / developer responsiveness
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 20 (1.53%, meaningful), mean 4.10
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R25-130 — Instagram, TikTok and Reels ads are a stated acquisition channel for buyers

- **Where:** §6.3 Instagram / TikTok / Reels ads are a stated acquisition channel
- **This app does:** paid social
- **User reaction:** purchase-driver
- **Magnitude:** 5 named reviews
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `12605136142`, `13612032880`, `14007797685`, `11840566735`, `14054848356`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R25-196 — Experiments: cap 3 vs 8 vs 7-day-unlimited measuring trial start, paid conversion, D7 retention and 1★-review rate; paywall after first habit completion vs after the onboarding survey; statistics free vs gated measuring upgrade rate — the corpus predicts free statistics increase conversion, testable and counter-intuitive; review prompt at day 7 vs first launch measuring store rating, review length and 1★ share

- **Where:** §11.7 Experiments Part 11 #29, Part 11 #30, Part 11 #31, Part 11 #32 — cap 3 vs 8 vs 7-day-unlimited (trial start, conversion, D7, 1★ rate); paywall after first habit completion vs after survey; statistics free vs gated (the corpus predicts free stats increase conversion); review prompt at day 7 vs first launch
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (experiments)
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** — (nuance register)

## Contradictions

### R25-125 — Cross-band: free cap 27 / 16 / 95 (a fifth from people who like the app); lifetime 32 / 3 / 9 (the 9 are purchase-recognition failures); Apple Health 24 / 2 / 6 (the 6 are data-accuracy bugs); widgets 24 / 5 / 1 (almost purely positive); confusing UX 10 / 4 / 13 (the same complexity power users praise); bug 15 / 4 / 14 (5★ reviewers report bugs in apps they love); support 16 / 0 / 4 — the single most important cross-cutting fact: complexity is both the top praise and a top complaint (126 praise simplicity, 27 call it confusing; 65 praise customisation depth, others say 'so many options and no guidance that you get lost in configuration', too many icons); any simplification must be opt-in

- **Where:** §5.6 Cross-band table (verbatim) — the single most important cross-cutting fact: complexity is both the top praise and a top complaint; any simplification must be opt-in
- **This app does:** deep configurability
- **User reaction:** mixed
- **Magnitude:** Theme | 5★+4★ | 3★ | 2★+1★ | Reading ; Free cap | 27 | 16 | 95 | Mostly hostile, but a fifth of it comes from people who like the app ; Lifetime purchase | 32 | 3 | 9 | Net positive — but the 9 are purchase-recognition failures ; Apple Health | 24 | 2 | 6 | Net positive; the 6 are data-accuracy bugs ; Widgets | 24 | 5 | 1 | Almost purely positive ; Confusing UX | 10 | 4 | 13 | Genuinely mixed — same complexity that power users praise ; Bug (generic) | 15 | 4 | 14 | Mixed: 5★ reviewers report bugs in apps they love ; Support / developer | 16 | 0 | 4 | Strongly positive with a small, sharp negative tail
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `12993093192`, `13596855184`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

## Data caveats and method

### R25-002 — Method: 1,309/1,309 read in full in 12 batches of 110, country-then-date order; 52-theme multilingual regex classifier with four disclosed corrections (free-cap 176→138 by requiring a limit-context word; 'ai' matched French j'ai → 1 genuine AI review, no AI finding; freeze regex inflated by Spanish 'nada' → reliability cluster hand-curated from 126 candidates to 51 launch-blocker + 12 data-loss IDs; ADHD split into adhd_named 41 and exec_difficulty 24); ambiguous surfaces split into mention/positive/problem; every aggregate computed twice — all 1,309 and the 801 substantive records (body > 60 chars) — because an in-app review prompt inflates the headline; corpus is small and back-weighted (44.8% in the 8 months of 2026); only 7 storefronts ≥50 (820, 62.64%); the free cap is not a constant (2–5 reported, 3 dominant); no version field; paid evidence self-selecting (57, 4.35%); 43 first-impression reviews (3.28%, mean 4.21, 31 5★) from people who have not used it; storefront ≠ language (French in mx, Spanish/Arabic in us); price claims not reconcilable (30+ figures, 12 currencies, pesos-vs-dollars confusion); no external source consulted; vote fields too sparse to weight (139)

- **Where:** How to read this; Seven warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations; §12.1 counting rules; §12.3 validation; §12.5 Reproduction
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 1,309/1,309; 91 storefronts; 0 empty; 3 duplicate groups (7 records) kept; is_edited 11 (several visible downgrades — 'Moved to 3 stars because they're not listening'); substantive n=801
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `13992368997`, `14461664452`, `14252109539`, `10930050142`, `13421495866`, `13433865029`, `13630801788`, `14368847160`, `13672090254`, `12319455814`, `13290152980`, `14164700184`, `13976982513`, `12658607281`
- **Canonical:** — (nuance register)

### R25-003 — The headline rating is inflated by an in-app review prompt and the inflation grows: reviews with a body of ≤25 characters rise from 7.2% of 2023–24 (17/236) to 13.8% of 2025 (67/487) to 33.4% of 2026 (196/586), 150 of those 196 are 5★, and eight reviewers explicitly complain the app asked for a review before they had used it

- **Where:** Warning #1 — the headline rating is inflated by an in-app review prompt, and the inflation grows: ≤25-char reviews 7.2% (E1) → 13.8% (2025) → 33.4% (2026), 150 of 196 5★; eight reviewers say it asked before they had used it
- **This app does:** early, aggressive review prompt
- **User reaction:** 5★-burst
- **Magnitude:** 7.2% → 13.8% → 33.4%; 150/196 5★; 8 explicit complaints
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12424719394`, `12591004629`, `12876930985`, `12957806563`, `13386578145`, `13411399713`, `13419192067`, `13764701322`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R25-004 — The free cap is not a constant — reviewers report 2, 3, 4 or 5 free habits ('2 goals', 'solo 2 habitos', 'more than one task', 'four tasks', '3-5 alışkanlık'); three is dominant, so a 2024 and a 2026 '3 habits' complaint may be about different builds and paywall placements

- **Where:** Warning #5 — the free cap is not a constant: reviewers report 2, 3, 4 or 5 free habits; three dominant
- **This app does:** cap varied across builds
- **User reaction:** complaint
- **Magnitude:** 5 reviews naming different caps
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Review IDs:** `11855794951`, `12293948829`, `13693237309`, `14200651675`, `14118452913`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R25-016 — 43 reviews (3.28%, mean 4.21, 31 of them 5★) are first-impression reviews from people who say they have not used the product yet ('Aún estoy por probarla'; 'Just downloaded') — marketing-response signal, not product signal

- **Where:** §1.5 — 43 first-impression reviews (3.28%, mean 4.21, 31 5★) from people who say they have not used the product yet — marketing-response signal, not product signal
- **This app does:** review prompt fires pre-use
- **User reaction:** 5★-burst
- **Magnitude:** 43 (3.28%), mean 4.21, 31 5★
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13992368997`, `14461664452`, `14252109539`, `10930050142`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R25-018 — The distribution is bimodal (55.16% 5★, 23.07% 1★, 21.78% in the middle three bands) — two populations reviewing two products: people who got past the paywall and people who did not

- **Where:** §1.6 Ratings table (verbatim) — bimodal: 55.16% 5★, 23.07% 1★, 21.78% middle; two populations — people who got past the paywall and people who did not
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Rating | n | % ; 5★ | 722 | 55.16% ; 4★ | 122 | 9.32% ; 3★ | 79 | 6.04% ; 2★ | 84 | 6.42% ; 1★ | 302 | 23.07% ; Mean |  | 3.671
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R25-020 — 2026 by month (n 135 / 79 / 51 / 44 / 82 / 58 / 64 / 60 / 13; means 3.69 → 3.72 → 3.53 → 3.84 → 3.26 → 3.59 → 3.56 → 3.73 → 3.38) shows the volatility a 1,309-record corpus has at month level — none of these months alone supports a trend claim

- **Where:** §1.6 By month 2026 table (verbatim) — month-level volatility; no single month supports a trend claim
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Month | n | mean | 5★ % | 1★ % ; 2026-01 | 135 | 3.69 | 55.6 | 23.7 ; 2026-02 | 79 | 3.72 | 58.2 | 22.8 ; 2026-03 | 51 | 3.53 | 54.9 | 31.4 ; 2026-04 | 44 | 3.84 | 59.1 | 15.9 ; 2026-05 | 82 | 3.26 | 48.8 | 36.6 ; 2026-06 | 58 | 3.59 | 58.6 | 25.9 ; 2026-07 | 64 | 3.56 | 57.8 | 26.6 ; 2026-08 | 60 | 3.73 | 61.7 | 26.7 ; 2026-09 (6 days) | 13 | 3.38 | 53.8 | 38.5
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R25-023 — Feature inventory attested by review text with free/paid state

- **Where:** §2.1 Feature inventory table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Attested by | Free / Paid as reviewers describe it ; Habit creation with custom name, icon, colour (incl. hex input) | 11694650718, 13467469049, 12382945489 | Free up to 3 habits, then paid ; "Bad habit" / quit-habit mode | 10381805436, 11353433253, 13605094837, 12778092747 | Paid beyond the cap ; Track-only habits with no goal number | 10785911508, 10305734583 | — ; Measurement units: count, minutes, distance, custom steps | 10381805436, 12584418650, 12918071192 | — ; Built-in timer (runs past the goal) | 10346042202, 12889328356, 12584418650, 13528811393 | — ; Groups and sub-groups | 12184038268, 13207258224, 12652539241 | Paid (13585132870 reports groups locked) ; Statistics: success %, graphs, per-habit calendar, performance charts | 10305734583, 12404912935, 13601387355 | Paywalled — 11282934508, 13318920074, 13603068257, 13636020247, 14225842901 ; Streaks with fire symbol | 14129450366, 13261289225 | — ; Apple Health two-way integration | 10081083127, 11399786219, 12201042880, 13543602021 | — ; Apple Watch app + complications | 10054970793, 11965539196, 12659238964, 12584418650 | — ; Home-screen, Lock Screen and Control Center widgets | 12320067097, 13197146903, 13905166366, 10899816769 | — ; Mac app (and formerly Vision Pro) | 11656905076, 12539663591, 13197146903, 13531929434 | — ; iCloud sync across iPhone / iPad / Watch / Mac | 11057930335, 12199187753, 11248554918, 13278531866 | — ; Siri Shortcuts | 13472318627, 12585991664, 10569395314 (requesting) | — ; Calendar integration | 13543602021, 13927028841, 13937721688 | — ; "Vacation" / pause habits | 13811962013, 12176241214 | — ; "Jump" and "Cancel" / skip a day, mark not-done | 13543602021, 10468572229, 12191332041 | — ; Archive habits | 10971903648, 12201042880 | — ; Gamified achievements, confetti, completion sound | 13543602021, 12352612203, 13879673780, 13301076677 (wants it off) | — ; Data export (CSV) | 12849182179, 12355886317, 12264249799 | Described as weak ; Onboarding questionnaire → suggested habits | 13162172214, 13627235273, 14341726601, 14509705008 | Free ; Day-start time setting (for shift workers) | 12659238964, 11007220268, 12014982215 | Capped at 11:45 per 11007220268 ; Habit editing | 13428241426, 14339204663, 14277782327, 14067453636 | Reported as paid in 2026 — see 2.3
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R25-039 — What is gated and when: more than ~3 habits (138, all eras); statistics of any kind (all eras); calendar view (E3); editing an existing habit including starter habits (Nov 2025 onward); group creation (E3)

- **Where:** §2.3 Gates table (verbatim) — >3 habits all eras; statistics all eras; calendar E3; editing from Nov 2025; group creation E3
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Gate | Evidence | Period ; More than ~3 habits | 138 reviews | All eras ; Statistics of any kind | 11282934508 (2024-05), 13318920074 (2025-10), 13603068257, 13636020247 (2026-01), 14225842901 (2026-06) | All eras ; Calendar view | 14225842901 "Pay to even look at calendar" | E3 ; Editing an existing habit — including the starter habits the onboarding creates | 13428241426 (mx, 1★, 2025-11) "Tengo 3 hábitos, y ya ni siquiera me deja editarlos"; 13585132870 (se, 1★, 2026-01) "only gets you started with features can cannot be changed without paying"; 14339204663 (pe, 2★, 2026-07) "como editar un hábito y hasta agregar uno"; 14277782327 (us, 1★, 2026-07) "You need to get the premium to edit habits (even the ones they start you out with)"; 14067453636 (tr, 1★, 2026-05) "Sen kendin eklemek isteyince ücretli abone olmalısın" | Appears only from Nov 2025 onward ; Group creation | 13585132870 | E3
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C133 Gate on capability, not on quantity

### R25-042 — Master theme table, denominator 1,309

- **Where:** §3.1 Complete ranked theme table (verbatim), 52 themes
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | n | % | Signal | Dir | Mean | 5★ | 1★ ; 1 | Monetisation friction (union) | 298 | 22.77% | high-priority | neg | 1.99 | 31 | 169 ; 2 | General paywall complaint ("can't use it free") | 163 | 12.45% | high-priority | neg | 2.01 | 15 | 90 ; 3 | Free-tier habit cap (the "3 habits" complaint) | 138 | 10.54% | high-priority | neg | 2.13 | 16 | 68 ; 4 | Simplicity / ease of use | 126 | 9.63% | high-priority | pos | 4.20 | 89 | 16 ; 5 | Motivation / streaks / accountability works | 84 | 6.42% | high-priority | pos | 4.58 | 64 | 1 ; 6 | Customisation, groups, colours, icons | 65 | 4.97% | very strong | pos | 4.49 | 47 | 4 ; 7 | Price praised as cheap / fair | 64 | 4.89% | very strong | pos | 4.31 | 45 | 6 ; 8 | Interface / visual design praised | 62 | 4.74% | very strong | pos | 4.42 | 45 | 4 ; 9 | Price objection ("too expensive") | 55 | 4.20% | very strong | neg | 1.76 | 5 | 35 ; 10 | Launch / interaction blocker (freeze, unresponsive) | 51 | 3.90% | very strong | neg | 1.63 | 1 | 33 ; 11 | Lifetime / one-time purchase discussed | 44 | 3.36% | very strong | mixed | 3.95 | 27 | 8 ; 12 | Billing dispute / unwanted charge / refund | 44 | 3.36% | very strong | neg | 1.59 | 4 | 32 ; 13 | ADHD / autism / OCD self-identified | 41 | 3.13% | very strong | pos | 4.44 | 32 | 4 ; 14 | Competitor named (switched from / compared) | 37 | 2.83% | meaningful | pos | 4.16 | 24 | 4 ; 15 | Upsell pop-ups interrupt use | 35 | 2.67% | meaningful | neg | 1.80 | 1 | 20 ; 16 | Bug / glitch / error (generic) | 33 | 2.52% | meaningful | neg | 3.09 | 10 | 8 ; 17 | Apple Health integration praised | 32 | 2.44% | meaningful | pos | 3.97 | 17 | 4 ; 18 | Widgets (mention) | 30 | 2.29% | meaningful | pos | 4.43 | 20 | 0 ; 19 | Wants per-habit clock time + timed notification | 29 | 2.22% | meaningful | unmet | 3.41 | 6 | 5 ; 20 | Confusing / unintuitive / no guidance | 27 | 2.06% | meaningful | neg | 2.70 | 6 | 11 ; 21 | Executive-function difficulty, no diagnosis named | 24 | 1.83% | meaningful | pos | 4.67 | 20 | 1 ; 22 | Calendar (mention / integration ask) | 22 | 1.68% | meaningful | mixed | 3.68 | 8 | 4 ; 23 | Trial discussed | 21 | 1.60% | meaningful | neg | 2.62 | 6 | 10 ; 24 | Localisation request | 21 | 1.60% | meaningful | unmet | 3.90 | 11 | 2 ; 25 | Apple Watch (mention) | 21 | 1.60% | meaningful | pos | 4.48 | 12 | 0 ; 26 | Support / developer responsiveness | 20 | 1.53% | meaningful | mixed | 4.10 | 14 | 4 ; 27 | Free cap actively defended | 19 | 1.45% | meaningful | pos | 4.32 | 11 | 1 ; 28 | "Life-changing" / major life outcome claimed | 19 | 1.45% | meaningful | pos | 4.84 | 17 | 0 ; 29 | Timer praised | 15 | 1.15% | meaningful | pos | 4.60 | 12 | 1 ; 30 | Sync between devices failing | 14 | 1.07% | meaningful | neg | 3.29 | 4 | 1 ; 31 | Data loss / reset | 12 | 0.92% | emerging | neg | 3.00 | 3 | 3 ; 32 | Wants reorder / order resets itself | 11 | 0.84% | emerging | mixed | 3.55 | 5 | 3 ; 33 | Lag / slowness | 10 | 0.76% | emerging | neg | 3.80 | 4 | 0 ; 34 | Wants one-off, non-repeating tasks | 10 | 0.76% | emerging | unmet | 3.90 | 1 | 0 ; 35 | Wants friends / accountability / leaderboard | 10 | 0.76% | emerging | unmet | 4.80 | 8 | 0 ; 36 | Apple Health data wrong / incomplete | 9 | 0.69% | emerging | neg | 3.33 | 3 | 1 ; 37 | Already paid, asked to pay again | 8 | 0.61% | emerging | neg | 1.50 | 0 | 5 ; 38 | Statistics weak / unreadable | 8 | 0.61% | emerging | mixed | 4.00 | 4 | 1 ; 39 | Review prompt fired before use | 8 | 0.61% | emerging | neg | 2.00 | 1 | 5 ; 40 | Mac / desktop / Vision Pro | 8 | 0.61% | emerging | mixed | 4.00 | 4 | 1 ; 41 | Over-achievement / carry-over behaviour wrong | 7 | 0.53% | emerging | mixed | 3.29 | 3 | 2 ; 42 | Wants notes / journal / mood field | 7 | 0.53% | emerging | unmet | 4.43 | 3 | 0 ; 43 | Wants long-term goals above habits | 7 | 0.53% | emerging | unmet | 4.71 | 5 | 0 ; 44 | Onboarding survey then immediate paywall | 6 | 0.46% | weak | neg | 1.17 | 0 | 5 ; 45 | Statistics paywalled (named explicitly) | 5 | 0.38% | weak | neg | 1.40 | 0 | 3 ; 46 | Editing gated behind premium | 5 | 0.38% | weak-by-rate | neg | 1.20 | 0 | 4 ; 47 | Privacy / tracking concern | 4 | 0.31% | weak | mixed | 3.00 | 2 | 2 ; 48 | Archive loses history | 4 | 0.31% | weak | neg | 3.75 | 1 | 0 ; 49 | Wants Android / Windows | 3 | 0.23% | weak | unmet | 4.67 | 2 | 0 ; 50 | Arrived via clinician recommendation | 3 | 0.23% | weak | pos | 4.67 | 2 | 0 ; 51 | Export / CSV inadequate | 3 | 0.23% | weak | neg | 4.33 | 2 | 0 ; 52 | Notifications wrong / absent | 3 | 0.23% | weak | neg | 3.00 | 0 | 1
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R25-086 — Weak rows: onboarding survey then immediate paywall 6 (0.46%, mean 1.17); statistics paywalled named 5 (0.38%, 1.40); editing gated 5 (0.38%, 1.20); privacy/tracking 4 (0.31%, 3.00); archive loses history 4 (0.31%, 3.75); wants Android/Windows 3 (0.23%, 4.67); arrived via clinician 3 (0.23%, 4.67); export/CSV inadequate 3 (0.23%, 4.33); notifications wrong/absent 3 (0.23%, 3.00)

- **Where:** §3.1 theme table #44–#52 weak rows
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 9 weak rows as listed
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R25-088 — Looked for and not found: AI expectations (1), accessibility beyond neurodivergence (0), family sharing (1), Shortcuts gaps (1); notably, ads-as-alternative-to-paywall is requested rather than complained about — six reviewers volunteer 'show me ads instead'

- **Where:** §3.1 Below-threshold themes recorded — AI (1), accessibility (0), family sharing (1), Shortcuts gaps (1); six reviewers volunteer 'show me ads instead' of a paywall
- **This app does:** no ads
- **User reaction:** mixed
- **Magnitude:** 6 'show me ads instead' reviews
- **Direction for us:** research · **Report confidence:** below threshold · **Generalisable:** yes
- **Review IDs:** `13516169817`, `12263453452`, `13009063073`, `12903710049`, `13065644863`, `14122841864`, `13607579176`, `11913092460`, `10569395314`
- **Canonical:** C082 Ads in the free tier

### R25-094 — Strengths: configurability without bloat (65, mean 4.49); feels like a first-party Apple app ('went back to check if the app was made by apple'); iPhone+iPad+Watch+Mac+widgets+Shortcuts+Health coverage (3.97–4.48); the timer that keeps counting past the goal (15, 4.60); flexible scheduling primitives — every N days ('the ONLY APP I've found'), N×/week, skip, vacation, custom day start for shift workers; motivating statistics once paid ('I can visually see what my weakest days of the week are'); good and bad habits in one model; responsive solo developer (20, 4.10); measurable outcomes claimed (19, 4.84 — 45 kg lost over 8 months, recovery from depression)

- **Where:** §3.4 What the product does well (verbatim table) — configurability without bloat; feels like a first-party Apple app; ecosystem coverage; timer past goal; flexible scheduling primitives; motivating stats (paid); good and bad habits in one model; responsive developer; real-world outcomes
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Strength | n | % | Mean | Evidence ; Configurability without bloat | 65 | 4.97% | 4.49 | 11694650718, 12584418650, 12652539241, 13467469049, 12454642037, 12592966841 ; Feels like a first-party Apple app | — | — | — | 11543202644 ("went back to check if the app was made by apple"), 11656905076 ("'Apple' design all over it"), 12191332041, 12752790900 ; Apple-ecosystem coverage: iPhone + iPad + Watch + Mac + widgets + Shortcuts + Health | 32 / 30 / 21 / 8 | — | 3.97–4.48 | 10653626434, 11687820487, 12539663591, 13197146903, 13905166366, 12584418650 ; The timer that keeps counting past the goal | 15 | 1.15% | 4.60 | 10346042202, 12889328356, 12584418650 ; Flexible scheduling primitives (every N days, N×/week, skip, vacation, custom day start) | — | — | — | 12615038002 (every-3-days reminder — "the ONLY APP I've found"), 12659238964 (shift workers), 13811962013 (vacation mode), 10468572229 ; Statistics that motivate (when the user has paid) | — | — | — | 11694650718 ("I can visually *see* what my weakest days of the week are"), 12404912935, 13601387355 ; Both good and bad habits in one model | — | — | — | 10381805436, 12510281974, 13605094837, 14070420374 ; Responsive solo developer | 20 | 1.53% | 4.10 | Part 2.4 ; Measurable real-world outcomes claimed | 19 | 1.45% | 4.84 | 13848909054 (45 kg lost over 8 months), 14308003772, 11694650718 (recovery from depression), 12627746599, 13751037946
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11694650718`, `12584418650`, `12652539241`, `13467469049`, `12454642037`, `12592966841`, `11543202644`, `11656905076`, `12191332041`, `12752790900`, `10653626434`, `11687820487`, `12539663591`, `13197146903`, `13905166366`, `10346042202`, `12889328356`, `12615038002`, `12659238964`, `13811962013`, `10468572229`, `12404912935`, `13601387355`, `10381805436`, `12510281974`, `13605094837`, `14070420374`, `13848909054`, `14308003772`, `12627746599`, `13751037946`
- **Canonical:** C134 Lead the store listing with what users actually love

### R25-098 — Requests (capability does not exist): per-habit clock time + notification 29 (2.22%); one-off tasks / to-do tab 10; friends/accountability/leaderboard 10; notes/journal/mood 7; long-term goals above habits 7; intra-day every-N-minutes reminder 4; hour-by-hour agenda 4; Android/Windows 3; screen-time-linked habits 3; landscape 1

- **Where:** §3.5 Requests table (verbatim) — clock time 29; one-off tasks 10; friends/leaderboard 10; notes/mood 7; long-term goals 7; every-N-minutes 4; hour-by-hour agenda 4; Android/Windows 3; screen-time-linked habits 3; landscape 1
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Request | n | % | Signal | Evidence ; Per-habit clock time + notification at that time | 29 | 2.22% | meaningful | 10975371211, 11185726438, 11512786062, 11830672328, 12559128903, 12608048200, 12647535093, 12682799984, 12889328356, 13846488281, 14092149470, 14303953237, 14437910533, 13995532158 ; One-off / non-repeating tasks, or a separate to-do tab | 10 | 0.76% | emerging | 12042009982, 12205846471, 12206675017, 12478039620, 13085696025, 13095424176, 13162425122, 13581933240, 14044102396, 14331081664 ; Friends / accountability / leaderboard | 10 | 0.76% | emerging | 11419872344, 11680828081, 12022893185, 12124549306, 13085696025, 14092271366, 14225345969, 12352612203 ; Notes / journal / mood field per day | 7 | 0.53% | emerging | 10546108041, 10547933356, 11557982016, 13716543684, 13735539068, 14139271437 ; Long-term goals sitting above habits | 7 | 0.53% | emerging | 11656905076, 12008425939, 12605136142, 12617239758, 13674254597, 13758062522 ; Intra-day recurring reminder (every N minutes until done) | 4 | 0.31% | weak | 12152603849, 13082959947, 13466380366, 13711288403 ; Calendar/agenda view with hour-by-hour layout | 4 | 0.31% | weak | 12608048200, 12682799984, 12904899932, 13256668642 ; Android / Windows | 3 | 0.23% | weak | 12936939329, 13801191230, 12208303239 ; Screen-time-linked habits | 3 | 0.23% | weak | 11154294245, 11965539196, 13739990490 ; Landscape mode | 1 | 0.08% | ignore | 14000988461
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `12608048200`, `13995532158`, `12042009982`, `12205846471`, `12206675017`, `12478039620`, `13085696025`, `13095424176`, `13162425122`, `13581933240`, `14044102396`, `14331081664`, `11419872344`, `11680828081`, `12022893185`, `12124549306`, `14092271366`, `14225345969`, `12352612203`, `10546108041`, `10547933356`, `11557982016`, `13716543684`, `13735539068`, `14139271437`, `11656905076`, `12008425939`, `12605136142`, `12617239758`, `13674254597`, `13758062522`, `12904899932`, `13256668642`, `11154294245`, `11965539196`, `13739990490`, `14000988461`
- **Canonical:** — (nuance register)

### R25-120 — 5★ (n=722): simplicity 12.3%, paid evidence 9.6%, motivation 8.9%, customisation 6.5%, price praised 6.2%, interface 6.2%, ADHD 4.4%, monetisation friction 4.3%, lifetime 3.7%, competitor abandoned 3.3%; two sub-populations — converted power users writing long, specific, comparative reviews naming the price they paid, and prompt-driven 5★ with no content (150 of 722 ≤25 characters; 31 say they have not used the app) to be read as distribution signal; 31 five-star reviews also complain about money — people who like the product and dislike the gate ('Buena app, lástima q es de pago… Pero a la vez es comprensible')

- **Where:** §5.1 5★ themes table (verbatim) — two sub-populations: converted power users vs prompt-driven 5★ with no content (150 of 722 ≤25 chars; 31 have not used it); 31 five-star reviews also complain about money
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 5★ ; Simplicity / ease | 89 | 12.3% ; Paid evidence (any) | 69 | 9.6% ; Motivation / streaks work | 64 | 8.9% ; Customisation / groups | 47 | 6.5% ; Price praised | 45 | 6.2% ; Interface praised | 45 | 6.2% ; ADHD named | 32 | 4.4% ; Monetisation friction | 31 | 4.3% ; Lifetime purchase discussed | 27 | 3.7% ; Competitor abandoned for Grit | 24 | 3.3%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11694650718`, `12584418650`, `13064873599`, `12168338279`, `13543602021`, `11656905076`, `14115921718`, `13690775199`, `13570030453`, `12293948829`, `12347614892`, `14050904443`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R25-124 — 1★ (n=302): monetisation friction 56.0%, general paywall 29.8%, free cap 22.5%, paid evidence 17.2%, price 11.6%, launch blocker 10.9%, billing 10.6%, pop-ups 6.6%, confusing 3.6%, trial 3.3% — money and the app not starting account for roughly two-thirds of the worst ratings; 52 of 302 (17.2%) show paid evidence — failed customers, not non-buyers venting; the band contains sustained accusations of fraud and extortion in six languages ('RATAS… COBRAN POR AÑADIR UN 4TO HÁBITO'; 'Greedy… money money money'; 'Paragöz uygulama'), which affects store-page conversion

- **Where:** §5.5 1★ table (verbatim) — 56% about money, 10.9% the app not starting; 17.2% of 1★ show paid evidence (failed customers, not non-buyers venting); sustained fraud/extortion accusations in six languages
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of 1★ ; Monetisation friction | 169 | 56.0% ; General paywall | 90 | 29.8% ; Free cap | 68 | 22.5% ; Paid evidence (any) | 52 | 17.2% ; Price objection | 35 | 11.6% ; Launch blocker | 33 | 10.9% ; Billing dispute | 32 | 10.6% ; Pop-ups | 20 | 6.6% ; Confusing UX | 11 | 3.6% ; Trial discussed | 10 | 3.3%
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `14108338899`, `14122841864`, `14337724472`, `14495136368`, `13871446961`, `14244904942`, `13660452698`, `13886293406`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R25-126 — Three nested denominators never substituted: explicit payers 57 (4.35%, mean 3.25); paid-adjacent evidence (lifetime, trial, billing, price-praise, lost premium) 152 (11.61%, mean 3.24); global 1,309 (3.671); no conversion rate is claimed

- **Where:** §6.1 Three nested denominators (verbatim table) — explicit payers 57 (4.35%, mean 3.25); paid-adjacent 152 (11.61%, 3.24); global 1,309 (3.671); no conversion rate claimed
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Group | Definition | n | % of corpus | Mean ; Explicit payers | Reviewer states they paid / bought / subscribed | 57 | 4.35% | 3.25 ; Paid-adjacent evidence | Mentions lifetime, trial, billing, price-praise, or lost premium | 152 | 11.61% | 3.24 ; Global | All reviews | 1,309 | 100% | 3.671
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R25-155 — Trend method: three eras defined on volume plus a substantive-only series; because short prompt-driven 5★ reviews grow from 7.2% to 33.4% of the corpus, the all-records series understates every deterioration — both series are given for every trend and no trend is claimed from monthly data alone

- **Where:** §9.1 Method — three eras on volume plus a substantive-only series; the all-records series understates every deterioration; no trend from monthly data
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (method)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R25-163 — Not claimed: a price-increase→objection trend (lifetime roughly doubles, objection 3.8% → 4.9% → 3.8% — do not claim the price rise hurt ratings); a data-loss trend (1 → 5 → 6, ~1% flat); a sync trend (2.1% → 0.8% → 0.9%, within noise for n=14); an Apple Watch trend (21 mentions; one 'suddenly they removed the Apple Watch app' report in Oct 2025, recorded not asserted); a monthly trend (nine 2026 months 3.26–3.84 on n=13–135); a confusing-UX trend (0.4% → 2.9% → 2.0%, the E1 figure rests on one review)

- **Where:** §9.9 Trends explicitly NOT claimed — no price-increase→objection trend (lifetime doubles, objection flat); no data-loss trend (1 → 5 → 6); no sync trend (2.1 → 0.8 → 0.9%); no Watch trend (one 'suddenly they removed the Apple Watch app' report, Oct 2025); no monthly trend; no confusing-UX trend
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (non-claims)
- **Direction for us:** none · **Report confidence:** non-claim · **Generalisable:** yes
- **Review IDs:** `13316944137`
- **Canonical:** — (nuance register)

### R25-195 — Verification questions the corpus cannot answer, ranked: did the free tier tighten after ~Nov 2025 to include editing and groups (checkable in one minute against entitlement config); is there or was there a review prompt that blocks progress until a review is written (if yes, the store rating is not a measurement); the device/OS distribution of the freeze; does the trial genuinely renew into annual when monthly was selected; was the Apple Watch app withdrawn around Oct 2025; does raising the free cap to 8–10 increase or decrease paid conversion — an A/B test and the most valuable one available

- **Where:** §11.6 Verification questions Part 11 #23, Part 11 #24, Part 11 #25, Part 11 #26, Part 11 #27, Part 11 #28 — did the free tier tighten after Nov 2025 (editing, groups); is there a review prompt that blocks progress; device/OS distribution of the freeze; does the trial renew into annual when monthly was selected; was the Watch app withdrawn Oct 2025; does raising the cap to 8–10 raise or lower conversion (the most valuable A/B)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (questions)
- **Direction for us:** research · **Report confidence:** open questions · **Generalisable:** yes
- **Review IDs:** `12591004629`, `13316944137`, `12865760230`
- **Canonical:** — (nuance register)
