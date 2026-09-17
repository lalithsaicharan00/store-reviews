# Cards — report 36

Source: `App Store Reports/36. (Not Boring) Habits - Science-backed habit tracker (REPORT).md`  
230 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 17
- [Must-haves](#must-haves) — 6
- [Must never break](#must-never-break) — 12
- [Features](#features) — 43
- [Monetization](#monetization) — 24
- [Tactics the app used](#tactics-the-app-used) — 6
- [Insights (the why)](#insights-the-why) — 29
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 18
- [Dated events and trends](#dated-events-and-trends) — 17
- [Positioning](#positioning) — 7
- [Anti-patterns](#anti-patterns) — 3
- [Things not to do](#things-not-to-do) — 4
- [Things to do](#things-to-do) — 7
- [Contradictions](#contradictions) — 5
- [Data caveats and method](#data-caveats-and-method) — 30

## Product rules

### R36-009 — No streak shame and restrained notifications are praised as reasons to stay: 11 (2.04%) praise that a missed day does not punish — 'As an easily discouraged perfectionist, I LOVE that if you miss a day (or a week) that it doesn't become the app of shame' (20 helpful votes); notification restraint 12 (2.22%) — 'the #1 reason I've deleted other habit apps was that they spammed me'

- **Where:** Executive summary #1 — not punishing you: 11 (2.04%) praise the absence of streak shame ('it doesn't become the app of shame', 20 votes); notification restraint 12 (2.22%) ('the #1 reason I've deleted other habit apps was that they spammed me')
- **This app does:** no streak reset shame; few notifications
- **User reaction:** praise
- **Magnitude:** no-shame 11 (2.04%); restraint 12 (2.22%); 20 votes
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9122428340`, `13967987039`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C253 Notification restraint — few, finely controllable notifications keep the users that spammy rivals lose

### R36-012 — A capability taken away from the free tier reads as a withdrawal, not a price: REGRESS 19 reviews (3.52%, mean 1.95, zero 5★, nine 1★) — 'Never expect rewards for loyalty … I've been using the app for 3 years and all my history is on there'; 'Bait and switch'; 'Redução das features do plano free'

- **Where:** Executive summary #2 — it reads as a withdrawal, not a price: REGRESS 19 (3.52%), mean 1.95, zero 5★, nine 1★ — 'Never expect rewards for loyalty … 3 years and all my history is on there'; 'Bait and switch'
- **This app does:** free capabilities removed
- **User reaction:** 1★-burst
- **Magnitude:** 19 (3.52%), mean 1.95; 0 5★; 9 1★
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13780647190`, `13770142251`, `13777493217`
- **Canonical:** C001 Never move a free feature behind the paywall; C104 Never ship a paywall or feature-removal change silently

### R36-051 — Gate cosmetics, not function: reviewers draw a bright line between cosmetic gating (accepted) and functional gating (rejected) — fine with paying, 'it was a bummer to see that the widgets are only available to paid members'; 'Pay for the skins. I am fine with widget restrictions but 59$?'; skins-only gate mean 2.77 vs widgets 2.64 vs habit cap 2.30

- **Where:** §2.3 The clearest single product insight — reviewers draw a bright line between cosmetic gating (accepted) and functional gating (rejected)
- **This app does:** skins paid (accepted); widgets and habits paid (rejected)
- **User reaction:** mixed
- **Magnitude:** skins 2.77 vs widgets 2.64 vs cap 2.30
- **Direction for us:** product-rule · **Report confidence:** clearest insight (report's own) · **Generalisable:** yes
- **Review IDs:** `11486217313`, `14174554457`, `11130442867`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free; C133 Gate on capability, not on quantity; C167 Cosmetic and colour variety as the paid layer

### R36-104 — Make polarising content switchable rather than rewriting it: MSG- 4 reviews dislike the very text 13 others rate 5★ — 'the daily messaging puzzling, as it is strangely negative — talking about destruction or a kind of wasteland' (5★, considering leaving); 'I don't care for the cryptic messages you get with every check. Wish I could disable those'

- **Where:** §3.5 Taste disagreements — MSG- 4 dislike the text QUOTES+ 13 love: 'strangely negative — talking about destruction or a kind of wasteland' (5★, considering leaving); 'Wish I could disable those' — make the messages switchable, don't rewrite them
- **This app does:** daily messages not switchable
- **User reaction:** mixed
- **Magnitude:** MSG- 4 (4.00) vs QUOTES+ 13 (5.00)
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11737716154`, `13670415847`
- **Canonical:** C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

### R36-111 — A new cap on existing users reads as punishing loyalty — grandfather them: 'Just another company cashing out on the loyalty of longtime users' (qa, 1★); 'I've used this app for years … I was hit with a paywall. And the prices are higher than what I remember'

- **Where:** §4.1 It reads as punishing loyalty — 'Just another company cashing out on the loyalty of longtime users'; 'I've used this app for years … I was hit with a paywall. And the prices are higher than what I remember'
- **This app does:** cap applied to existing users
- **User reaction:** 1★-burst
- **Magnitude:** 2 quotes (REGRESS 19, mean 1.95)
- **Direction for us:** product-rule · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `13780647190`, `13625458345`
- **Canonical:** C001 Never move a free feature behind the paywall; C186 Never revoke what earlier buyers paid for when the model changes

### R36-116 — Widgets are load-bearing for the habit itself, so gating them removes the reason to pay: 'Just hit 62 days in a row of my morning routine. It wouldn't be possible without this app and it's widgets' (5★ payer); 'just add the widgets to your Home Screen and you will never miss a day'; 'Ojalá los widget fueran gratuitos eso mejoraría el apego' ('I wish the widgets were free, it would improve adherence') — gating the widget removes the mechanism that keeps the streak alive, which then removes the reason to pay

- **Where:** §4.2 Why it matters — widgets are load-bearing for the habit itself: '62 days in a row … wouldn't be possible without this app and it's widgets'; 'add the widgets … you will never miss a day'; 'Ojalá los widget fueras gratuitos eso mejoraría el apego'
- **This app does:** widgets paid
- **User reaction:** complaint
- **Magnitude:** WIDGETGATE 14 (2.64); WIDGET+ 7 (4.29)
- **Direction for us:** build-free · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `13462331422`, `11562816267`, `14445365483`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R36-124 — Resolve the privacy-vs-sync tension with private end-to-end sync: local-only is praised ('respecting your privacy and not harvesting your data'; 'the developers don't collect your data') while sync is the top request — a private end-to-end sync keeps the privacy claim

- **Where:** §4.3 But local-only is also praised (PRIVACY+ 2, NOADS 6); the tension is real and a private end-to-end sync would resolve it without giving up the privacy claim
- **This app does:** local-only
- **User reaction:** mixed
- **Magnitude:** PRIVACY+ 2, NOADS 6 vs R_SYNC 34
- **Direction for us:** build-free · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `9206039207`, `13670415847`
- **Canonical:** C030 Sync must work — and prove it; C085 Address tracking / privacy visibly

### R36-129 — Extend the reward beyond the first run: 17 distinct reviews (mean 2.76) name the identical journey per habit and the hard stop at 60 days, from 5★ fans and the most analytical critic alike — the least price-sensitive improvement and the one most likely to extend lifetime value

- **Where:** §4.5 Cluster 5 — The 60-day ceiling: BORING- 8 + R_BEYOND60 6 + GAME- 4 = 17 distinct, mean 2.76; least price-sensitive improvement and most likely to extend lifetime value
- **This app does:** 60-day ceiling
- **User reaction:** churn
- **Magnitude:** 17 distinct, mean 2.76
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14471085224`, `13572306369`, `9098509320`
- **Canonical:** C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R36-153 — Never trap a loyal user between their history and a new paywall: the most dangerous customer is the multi-year free user who changed device or ran out of habits in 2026 (CAP + REGRESS + long tenure) — 3 years of history 'stuck'; '5 habits on the old phone, 1 on the new'; 'I've used this app for years'; 'I preferred the old version'; 'I loved this app but no more'; 'péssima mudança' — LOCKIN (1) is the canary: data in the app, no export, no sync, so they cannot leave cleanly and cannot continue without paying

- **Where:** §6.7 The most dangerous customer — the multi-year free user who upgraded their device or ran out of habits in 2026 (CAP + REGRESS + long tenure); '5 habits on the old phone, 1 on the new'; LOCKIN 1 is the canary: data in the app, no export and no sync, cannot leave cleanly and cannot continue without paying
- **This app does:** cap on reinstall / new device; no export or sync
- **User reaction:** 1★-burst
- **Magnitude:** 6 reviews; LOCKIN 1 (1.00)
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `13780647190`, `13871290077`, `13625458345`, `13594356619`, `13624027434`, `13777493217`
- **Canonical:** C001 Never move a free feature behind the paywall; C176 Never let fear of losing history be the reason people pay

### R36-187 — Cosmetic gating is tolerated; functional gating is not — a competitor can charge for skins and give away widgets and habit counts, and this corpus predicts the reaction

- **Where:** Part 9 #4
- **This app does:** competitor lesson
- **User reaction:** mixed
- **Magnitude:** competitor lesson (see body)
- **Direction for us:** product-rule · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `11016580901`, `11486217313`, `14174554457`
- **Canonical:** C001 Never move a free feature behind the paywall; C133 Gate on capability, not on quantity; C167 Cosmetic and colour variety as the paid layer

### R36-189 — Local-only storage is simultaneously an asset and the top churn cause: 2 praise privacy, 34 want sync, 3 lost data — private end-to-end sync captures both

- **Where:** Part 9 #6
- **This app does:** competitor lesson
- **User reaction:** mixed
- **Magnitude:** competitor lesson (see body)
- **Direction for us:** build-free · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it; C085 Address tracking / privacy visibly

### R36-191 — Habit-count caps below 3 are a rating liability: three separate reviewers volunteer three as the fair number

- **Where:** Part 9 #8
- **This app does:** competitor lesson
- **User reaction:** mixed
- **Magnitude:** competitor lesson (see body)
- **Direction for us:** product-rule · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `14109551956`, `14236390341`, `12556296093`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R36-192 — Raise the free habit cap to at least 3, and exclude archived / completed habits from the count

- **Where:** §10.1 action 1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** CAP 30 (2.30), 26.9% of E5; REGRESS 19 (1.95); three name three
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `14109551956`, `14236390341`, `12556296093`, `13577681414`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C219 A free cap must be concurrent, never lifetime — deleting a habit frees a slot

### R36-193 — Grandfather every pre-December-2025 user at their previous habit count — removes the 'punishing loyalty' narrative that produces 1★ rather than 3★

- **Where:** §10.1 action 2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 6 long-tenure 1–3★ reviews
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13780647190`, `13871290077`, `13625458345`, `13594356619`, `13624027434`, `13777493217`
- **Canonical:** C001 Never move a free feature behind the paywall; C186 Never revoke what earlier buyers paid for when the model changes

### R36-203 — Make the daily messages switchable; do not rewrite them — 13 reviews rate them 5★

- **Where:** §10.2 action 12
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** MSG- 4 vs QUOTES+ 13
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11737716154`, `13670415847`, `10099628404`, `12097852488`
- **Canonical:** C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

### R36-204 — Move the gate line back to cosmetics: free widgets and a usable habit count; charge for skins, themes and the suite

- **Where:** §10.3 action 13 (Make)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** WIDGETGATE 14 (2.64) + CAP 30 (2.30) vs accepted skin gating
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11130442867`, `11016580901`, `11486217313`, `14174554457`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free; C167 Cosmetic and colour variety as the paid layer

### R36-209 — Never retract a free capability again; if a tier must change, change it for new users only — the corpus's two rating troughs are both retractions (Oct 2023, Dec 2025)

- **Where:** §10.3 action 18 (Policy)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** REGRESS mean 1.95, zero 5★
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall

## Must-haves

### R36-053 — Support responsiveness is attested both ways: a requested feature shipped the same week and 'Support very responsive to a question I had' (the only SUPPORT+) vs 'contacted the developer twice … I waited too long for a reply and I have now paid. Service matters' and 'the developer said they are a small company and cannot solve problems in mainland China' — both SUPPORT- records are payers

- **Where:** §2.4 Responsiveness attested in both directions — a requested feature shipped the same week; 'Support very responsive'; vs 'contacted the developer twice … waited too long … Service matters'; 'small company and cannot solve problems in mainland China'
- **This app does:** small team support
- **User reaction:** mixed
- **Magnitude:** SUPPORT+ 1; SUPPORT- 2 (both payers)
- **Direction for us:** must-have · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `13572606322`, `11938623754`, `9506691039`, `12524757331`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C215 Support reply time must be shorter than any cancellation deadline it serves

### R36-076 — An unconventional interface needs onboarding: ONBOARD- 16 (2.96%, mean 1.81, 12 of 16 1–2★, 7.9% of E1 → 1.9% of E5) — 'Is there no manual?'; 'I've wasted enough time trying to figure out how to use this silly app'; 'I didn't understand how to play??'; 'Is it a game or some kind of something else?'

- **Where:** §3.2 ONBOARD- 16, mean 1.81, 12 of 16 1–2★ — 'Is there no manual?'; 'I've wasted enough time trying to figure out how to use this silly app'
- **This app does:** no onboarding at launch; improved
- **User reaction:** complaint
- **Magnitude:** 16 (2.96%), mean 1.81
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8777347712`, `8252766990`, `8606455193`, `8676576820`, `9724439104`
- **Canonical:** C075 Skippable, replayable onboarding tour

### R36-125 — A gesture-driven one-habit screen breaks down exactly for power users: habit navigation (27 distinct, 5.00%, mean 3.56, mostly 4–5★) asked for continuously from Dec 2021 to Apr 2026 (one review 45 votes; one entire body '.'); the centre check button swallows horizontal swipes ('most anywhere on the screen that we touch presses the center checkmark button'); names sit in a small strip at the top ('quite a reach to get to the top of the phone'); and it gets worse with more habits — i.e. for the paying user ('I have to swipe through 16 habits. That alone is enough for me to not want to use this app anymore'; 'switching between habits and having a lot of them is painful')

- **Where:** §4.4 Cluster 4 — habit navigation 27 distinct (5.00%), mean 3.56; asked continuously from Dec 2021 to Apr 2026 (a 45-vote review); the centre check button swallows horizontal swipes; worse with more habits — precisely for the paying user
- **This app does:** one habit per screen; small top strip
- **User reaction:** churn
- **Magnitude:** 27 distinct (5.00%), 3.56; SWITCH- 20 (3.90); REACH- 6 (4.17)
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `8185571470`, `8253563602`, `8258517590`, `8562867284`, `9189055798`, `9750074711`, `10016530116`, `10622250811`, `10662024022`, `10713355484`, `10738443241`, `10968040090`, `11276612751`, `12079206553`, `12102232868`, `12153499058`, `12294811087`, `13670415847`, `13948551648`
- **Canonical:** C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R36-199 — Finish habit navigation: reliable horizontal swipe anywhere except the check button, plus an all-habits overview screen

- **Where:** §10.2 action 8
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 27 reviews (3.56); 45-vote review names the conflict
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9750074711`, `13670415847`, `13948551648`
- **Canonical:** C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R36-200 — Make habit delete / rename obvious, and lift the name character limit

- **Where:** §10.2 action 9
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** DELETE- 10 (3.00); NAMELEN 3
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `8757312048`, `9021270886`, `11245244275`, `11280034510`, `8774281298`, `13670415847`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R36-202 — Respect the silence switch; add a global audio toggle — one of two sound complaints was an uninstall

- **Where:** §10.2 action 11
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** SOUND- 2 (2.50)
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12435909620`, `14020824924`
- **Canonical:** C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

## Must never break

### R36-025 — A subscription must unlock on every device of the buyer: entitlement not travelling across devices is a payer complaint (and the developer did not reply in time: 'contacted the developer twice … I waited too long for a reply and I have now paid. Service matters')

- **Where:** Executive summary #7 — entitlement not travelling across devices
- **This app does:** entitlement per device
- **User reaction:** complaint
- **Magnitude:** 2 reviews
- **Direction for us:** must-never-break · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `9506691039`, `8757837312`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R36-027 — Bundle billing must charge once: a Chinese reviewer reports five annual fees charged after buying the bundle membership, recovering only two refunds (1★); the developer said they are a small company and cannot solve problems in mainland China

- **Where:** Executive summary #8 — a Chinese reviewer charged five annual fees after buying the bundle membership, recovered only two refunds (1★); developer said they are a small company and cannot solve problems in mainland China
- **This app does:** suite membership billed per app
- **User reaction:** 1★-burst
- **Magnitude:** n=1, 1★
- **Direction for us:** must-never-break · **Report confidence:** anecdotal; high consequence · **Generalisable:** yes
- **Review IDs:** `12524757331`
- **Canonical:** C029 Billing must be exactly right

### R36-066 — Other bugs 8 (1.48%, mean 2.88)

- **Where:** §3.1 theme table BUG
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 (1.48%), 2.88
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C175 Updates must not break function or wipe progress

### R36-102 — Broken capabilities: reliability union 23 (4.26%, mean 2.74) — widget stopped working / shows 'unlock' (3); layout overflow, clipping or wrong zoom (6, 4 of them in E5, incl. a pop-up blocking an iPhone 13 mini); reminders not firing (2); data lost with no backup (3); a crash (1); other bugs (8)

- **Where:** §3.5 Broken existing capabilities U_RELIABILITY 23 (4.26%), mean 2.74 — WIDGETBUG 3; UIBUG 6 (4 of 6 in E5); NOTIF- 2; DATALOSS 3; CRASH 1; BUG 8
- **This app does:** various
- **User reaction:** complaint
- **Magnitude:** 23 (4.26%), 2.74; UIBUG 6 (4 in E5)
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10610214785`, `11178506784`, `13140722107`, `9567517609`, `11870684099`, `13631929530`, `13652246359`, `13701793930`, `14160954678`, `8845345016`, `12392171682`, `9978275210`, `10674087870`, `13624027434`, `8159941067`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C039 Reminders fire reliably, once; C040 Widgets must not go blank, stale or disagree with the app; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C175 Updates must not break function or wipe progress

### R36-121 — Entitlements must travel across the buyer's devices and say so: 'it would be great to access skins this way as well instead of unlocking them on each device'; a payer still did not know whether the subscription covered one device only

- **Where:** §4.3 Entitlements don't travel either (ENT 2) — 'access skins this way as well instead of unlocking them on each device'; paid and still does not know whether the subscription is one device only
- **This app does:** per-device unlock
- **User reaction:** complaint
- **Magnitude:** ENT 2 (3.50)
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `8757837312`, `9506691039`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R36-123 — Local-only data vanishes with the device or on delete: 'everything you save and track is reset when the app is deleted … I do not recommend' (tr, 1★); 'I lost all my progress because of that'; 'No history remains once deleted' — DATALOSS 3 (mean 1.67)

- **Where:** §4.3 Consequence when a device is lost — 'everything you save and track is reset when the app is deleted … I do not recommend'; 'I lost all my progress because of that'; 'No history remains once deleted'
- **This app does:** local-only, no backup
- **User reaction:** 1★-burst
- **Magnitude:** DATALOSS 3 (1.67)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `9978275210`, `10674087870`, `13624027434`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R36-135 — Billing failures carry a consumer-protection dimension and must be triaged regardless of share: all 3 BILLING reviews (0.56%) are 1★ — 'Dark pattern: roach motel … Clicking on link In email returns Cannot cancel subscription'; a disabled reviewer reporting an unauthorised annual charge; five annual charges for one bundle purchase with two refunds denied

- **Where:** §5.5 A third, small, high-consequence group: billing — all 3 BILLING 1★: 'Dark pattern: roach motel … Clicking on link In email returns Cannot cancel subscription'; a disabled reviewer reporting an unauthorised annual charge; five annual charges for one bundle purchase, two refunds denied — triage regardless of 0.56% share
- **This app does:** cancellation link fails; unauthorised / multiple charges
- **User reaction:** 1★-burst
- **Magnitude:** 3 (0.56%), mean 1.00
- **Direction for us:** must-never-break · **Report confidence:** safety exception · **Generalisable:** yes
- **Review IDs:** `9580841951`, `10658186053`, `12524757331`
- **Canonical:** C029 Billing must be exactly right; C112 In-app cancellation

### R36-150 — After payment, ranked: no iCloud sync 9 of 34 (26.5%); monetisation friction even after paying 8 (23.5% — price high for one device, will switch to a flat-fee app, no trial, five charges, the bundle, value); usability / navigation 7 (20.6%); 'not worth it' 3 (8.8%; 'I can't believe I paid for this'; 'My money down the drain'); explicit non-renewal 3 (8.8%; 'after this month, I'll be using something like Streaks'); billing 2 (cancellation link fails; five charges); support did not answer 2 (100% of SUPPORT-); entitlement not across devices 2; bugs hitting payers 2 (paid wallpaper download does nothing; 'please fix the bugs (paying user)', font clipped on iPhone SE3); the top post-purchase problem is sync, not price — three payers name it as their reason to stop paying

- **Where:** §6.5 What goes wrong after payment (verbatim table) — no iCloud sync 9 (26.5%); usability 7 (20.6%); monetisation friction even after paying 8 (23.5%); not worth it 3 (8.8%); non-renewal 3; billing 2; support did not answer 2 (100% of SUPPORT-); entitlement 2; bugs 2 ('please fix the bugs (paying user)', font clipped on iPhone SE3)
- **This app does:** post-purchase failures
- **User reaction:** churn
- **Magnitude:** Problem | Payers affected | Segment rate | Global n | Evidence ; No iCloud sync | 9 | 26.5% | 34 | 9076528710, 9506691039, 10498701164, 10771936163, 12155806021, 12339917492, 12367187835, 12800428077, 13681998290 ; Usability / navigation | 7 | 20.6% | 68 | 11064158160, 11206570486, 11344820966, 12155806021, 12417677947, 13572606322, 12339917492 ; Monetisation friction even after paying | 8 | 23.5% | 121 | 9506691039 (price high for one device), 9647917670 (will switch to a flat-fee app), 11344820966 (no trial), 12524757331 (five charges), 9313935543 / 12524757331 (the bundle), 11064158160 / 12417677947 (value) ; "Not worth it" after purchase | 3 | 8.8% | 21 | 11064158160 (1★) "I can't believe I paid for this"; 12417677947 (1★) "My money down the drain"; 11344820966 (2★) ; Explicit non-renewal / churn | 3 | 8.8% | 20 | 9647917670 "after this month, I'll be using something like Streaks"; 10771936163 "I do not plan to [renew]"; 12155806021 "Switching back to that" ; Billing and refunds | 2 | 5.9% | 3 | 9580841951 (1★) cancellation link fails; 12524757331 (1★) charged five annual fees for one bundle membership, Apple refunded two, developer said it cannot help with mainland China ; Support did not answer | 2 | 100% of SUPPORT- | 2 | 9506691039 "contacted the developer twice … I waited too long for a reply and I have now paid. Service matters"; 12524757331 ; Entitlement does not travel across devices | 2 | 5.9% | 2 | 9506691039 (cannot find out if it is one device only); 8757837312 (skins must be unlocked per device) ; Bugs hitting paying users | 2 | 5.9% | 23 | 8969889060 (cn) paid tier's wallpaper download does nothing; 13631929530 (cn) "修一修bug吧（付费用户）" — *"please fix the bugs (paying user)"*, font clipped on iPhone SE3 after an update
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `9076528710`, `9506691039`, `10498701164`, `10771936163`, `12155806021`, `12339917492`, `12367187835`, `12800428077`, `13681998290`, `11064158160`, `11206570486`, `11344820966`, `12417677947`, `13572606322`, `9647917670`, `12524757331`, `9313935543`, `9580841951`, `8757837312`, `8969889060`, `13631929530`
- **Canonical:** C029 Billing must be exactly right; C030 Sync must work — and prove it; C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R36-154 — A new device must not re-apply a stricter free tier to an existing user: '5 habits on the old phone, 1 on the new' — with local-only data, a phone upgrade becomes a downgrade

- **Where:** §6.7 '5 habits on the old phone, 1 on the new' — a new device applies the new cap to an existing user
- **This app does:** cap applied on reinstall
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `13871290077`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C034 Data must never be lost on update, reinstall or phone change

### R36-182 — Test layouts on every device size before release: reliability 3.5 → 4.4 → 3.0 → 4.8 → 6.5% by era, now layout bugs — 4 of 6 UIBUG records in E5 (3.7%): font clipped on iPhone SE3 after an update (a payer), schedule options overflowing on iPhone 13 Plus / iOS 26.2 (an immediate first-run uninstall), a habit overview 'zoomed in like it was designed for desktop', reminder-picker scaling glitches — a 2026 layout / scaling regression across device sizes

- **Where:** §8.8 Trend 7 — Reliability is low but rising slightly, and it is now layout bugs: U_RELIABILITY 3.5 → 4.4 → 3.0 → 4.8 → 6.5%; UIBUG 4 of 6 in E5 (3.7%): font clipped iPhone SE3, schedule options overflowing iPhone 13 Plus / iOS 26.2, overview 'zoomed in like it was designed for desktop', reminder picker scaling; a 2026 layout/scaling regression; two caused an immediate uninstall or a payer complaint
- **This app does:** 2026 layout regression
- **User reaction:** churn
- **Magnitude:** reliability 3.5 → 6.5%; UIBUG 4/6 in E5 (3.7%)
- **Direction for us:** must-never-break · **Report confidence:** very strong in E5 · **Generalisable:** yes
- **Review IDs:** `13631929530`, `13701793930`, `14160954678`, `13652246359`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R36-197 — Triage the three billing reports individually — cancellation link fails, unauthorised charge on a disabled reviewer, five annual charges with two refunds denied; the only consumer-protection records, promote regardless of share

- **Where:** §10.1 action 6
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** BILLING 3 (0.56%)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9580841951`, `10658186053`, `12524757331`
- **Canonical:** C029 Billing must be exactly right

### R36-198 — Fix the 2026 layout / scaling regression on small and large displays (font clipping, schedule picker overflow, zoomed overview)

- **Where:** §10.2 action 7
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** UIBUG 6, 4 in E5
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13631929530`, `13701793930`, `14160954678`, `13652246359`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

## Features

### R36-006 — Haptics, sound and music are a differentiator almost no competitor is credited with: 57 reviews (10.56%, mean 4.61) — 'very satisfying to hold down a button … and get actual physical feedback from my phone … Much nicer than just tapping a complete button'; 'the music is absolutely gorgeous, please upload it to Spotify'

- **Where:** Executive summary #1 — haptics, sound and music 57 (10.56%), mean 4.61 — a differentiator almost no competitor is credited with
- **This app does:** hold-to-check with haptics, sound, music — free
- **User reaction:** praise
- **Magnitude:** 57 (10.56%), mean 4.61
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8139278712`, `12323195954`
- **Canonical:** C069 Check-off sound and haptic; C229 A deliberate completion gesture — press-and-hold with haptic and sound, not a bare tap

### R36-007 — A 60-day build — a 3D monument assembling one piece per completed day — drives return visits through curiosity: 74 reviews (13.70%, mean 4.69) — 'I can't stop because I'm curious about what the next reward is the next day'; 'I needed to finish the campsite or the summit and see today's design' (quitting alcohol)

- **Where:** Executive summary #1 — the 60-day monument build 74 (13.70%), mean 4.69 — 'I can't stop because I'm curious about what the next reward is'
- **This app does:** free 60-day monument
- **User reaction:** praise
- **Magnitude:** 74 (13.70%), mean 4.69
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10492156673`, `13127746442`
- **Canonical:** C024 Streaks / gamification; C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R36-021 — A one-habit-per-screen canvas needs an all-habits list and easy switching: SWITCH- 20 (3.70%) + NOLIST 12 (2.22%) + REACH- 6 (1.11%) = 27 distinct reviews (mean 3.56) — 'I have to swipe through 16 habits … then every time you swipe to a different habit, it brings you back to the checkmark screen'; a Dec 2025 update improved it ('literally that same week they rolled out an update with those exact features')

- **Where:** Executive summary #5 — the one unfixed piece is navigating between habits: SWITCH- 20 (3.70%) + NOLIST 12 (2.22%) + REACH- 6 (1.11%); 27 distinct, mean 3.56; Dec 2025 update improved it
- **This app does:** one habit per screen; no list view
- **User reaction:** complaint
- **Magnitude:** 27 distinct, mean 3.56
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13670415847`, `13572606322`
- **Canonical:** C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R36-023 — iCloud / cross-device sync is the #1 request and the #1 payer complaint: 34 reviews (6.30%, high-priority, mean 3.59), present in every era (7.0 / 8.8 / 7.2 / 6.0 / 2.8%) and asked continuously for 4.7 years (Jan 2022 → Aug 2026); 9 of 34 explicit payers raise it (26.5%, the highest issue in that group) — 'I did end up buying the 1 year subscription, but … it doesn't sync across devices in iCloud … I do not plan to [renew]'; 'Comprei no IPad … não sincroniza com o iPhone'; 'the one-time price for a single app is already ¥398 — why is there no multi-device sync?'

- **Where:** Executive summary #6 — iCloud sync is the #1 request and #1 complaint of paying customers: R_SYNC 34 (6.30%), mean 3.59, every era (7.0 / 8.8 / 7.2 / 6.0 / 2.8%), Jan 2022 → Aug 2026; 9 of 34 payers (26.5%)
- **This app does:** local only, no sync, no account
- **User reaction:** churn
- **Magnitude:** 34 (6.30%), 3.59; 9/34 payers (26.5%); 4.7 years
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8210628761`, `14450598724`, `10771936163`, `13681998290`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C030 Sync must work — and prove it; C153 Automatic cloud backup on by default — never manual opt-in

### R36-036 — One habit at a time on a full-screen canvas (not a list), with a small name at the top to switch between habits — free; the source of the navigation complaints

- **Where:** §2.1 One-habit-at-a-time full-screen canvas — free; a name in small text at the top switches between habits
- **This app does:** free
- **User reaction:** mixed
- **Magnitude:** inventory
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** app-specific
- **Review IDs:** `8185571470`, `10662024022`, `13670415847`
- **Canonical:** C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R36-037 — A hold-to-check button that fills up with haptics and sound is free and is the praised completion gesture

- **Where:** §2.1 Hold-to-check button with haptics + sound — free ('the marker that fills up')
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** haptics/sound/music 57 (10.56%)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8139278712`, `13678372106`, `12145055029`
- **Canonical:** C069 Check-off sound and haptic; C229 A deliberate completion gesture — press-and-hold with haptic and sound, not a bare tap

### R36-038 — The 60-day monument is free: a 3D object (mountain, iceberg, campsite, summit, sword, bridge, statue) assembles one piece per completed day for 60 days

- **Where:** §2.1 60-day monument / structure build — free; a 3D object (mountain, iceberg, campsite, summit, sword, bridge, statue) assembles one piece per day for 60 days
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** 74 (13.70%)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `9411396337`, `10010716282`, `10832733374`, `13127746442`
- **Canonical:** C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R36-039 — A daily line of motivational text per completion ('narrative progression') is free

- **Where:** §2.1 Daily motivational text / quotes — free; reviewers call it 'narrative progression'
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** inventory
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `9464371564`, `13596302845`, `11085313395`
- **Canonical:** C095 Neutral, non-judgemental tone on failure

### R36-040 — Calendar / month / year history views (swipe up from the check screen; a year grid) and schedule by weekday are free; archived habits count against the free cap

- **Where:** §2.1 Calendar / month / year history views — free (swipe up; a year grid); schedule by weekday — free; archive a habit — counts against the free cap
- **This app does:** free
- **User reaction:** mixed
- **Magnitude:** inventory
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8803885432`, `11318979286`, `11980712489`, `13594356619`, `9898093006`, `13701793930`, `13577681414`
- **Canonical:** C012 Week / month / year grid views; C043 Flexible / custom frequency; C219 A free cap must be concurrent, never lifetime — deleting a habit frees a slot

### R36-041 — Skins / themes / wallpapers — default dark plus ~10 premium skins — are paid for the whole window, and this gate is broadly accepted

- **Where:** §2.1 Skins / themes / wallpapers — paid whole window (default dark plus ~10 premium skins)
- **This app does:** paid
- **User reaction:** mixed
- **Magnitude:** inside PAYWALL 31 (5.74%), mean 2.77
- **Direction for us:** build-paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8777283339`, `13670415847`, `9504356434`
- **Canonical:** C167 Cosmetic and colour variety as the paid layer

### R36-042 — Absent per reviewers: iCloud / cross-device sync; any account or login; Apple Watch app; interactive widget; multiple completions per day or quantity; flexible schedules (every N days, N times per week/month); notes on a habit; statistics or counts; Apple Health; a timer / pomodoro; progression beyond 60 days; a light mode; landscape / a real iPad layout (early era)

- **Where:** §2.1 Capabilities reviewers say do NOT exist — iCloud / cross-device sync; account / login; Apple Watch; interactive widget; multiple completions per day / quantity; flexible schedules (every N days, N per week/month); notes; statistics or counts; Apple Health; timer/pomodoro; progression beyond 60 days; a light mode; landscape / real iPad layout (early era)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** see §3.5
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8777283339`
- **Canonical:** C011 Weekly / monthly / yearly reports; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C023 Interactive widget check-off; C030 Sync must work — and prove it; C035 Account system from day one; C043 Flexible / custom frequency; C048 Flexible units / partial progress; C066 Focus timer; C080 Colour themes / dark mode; C141 Native iPad layout; C172 Per-day / per-habit notes and journal text; C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R36-067 — Visualisation / history views praised 8 (1.48%, mean 4.62)

- **Where:** §3.1 theme table VIZ+
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 8 (1.48%), 4.62
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views

### R36-069 — Widgets praised 7 (1.30%, mean 4.29)

- **Where:** §3.1 theme table WIDGET+
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 7 (1.30%), 4.29
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free

### R36-086 — Well-written, never guilt-inducing motivational text: QUOTES+ 13 (2.41%), mean 5.00, every single one 5★ — 'It's easy to overlook how well written the text is in this app. The motivational phrases are encouraging but never guilt inducing'

- **Where:** §3.4 #6 Writing quality — QUOTES+ 13 (2.41%), mean 5.00, every one 5★ — 'The motivational phrases are encouraging but never guilt inducing'
- **This app does:** daily motivational line
- **User reaction:** praise
- **Magnitude:** 13 (2.41%), mean 5.00
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9464371564`
- **Canonical:** C095 Neutral, non-judgemental tone on failure

### R36-089 — Statistics / counts / charts requested 10 (1.85%, mean 3.90)

- **Where:** §3.5 R_STATS
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 10 (1.85%), 3.90
- **Direction for us:** build-free · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `9551247141`, `9567517609`, `10832733374`, `12155806021`, `12367187835`, `13608349245`, `13902720788`, `13945742048`, `13948551648`
- **Canonical:** C011 Weekly / monthly / yearly reports; C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells

### R36-090 — Apple Watch app requested 9 (1.67%, mean 4.11)

- **Where:** §3.5 R_WATCH
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 9 (1.67%), 4.11
- **Direction for us:** research · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `9102170206`, `11311247837`, `11499453960`, `12118518558`, `12339917492`, `12438446023`, `12912075467`, `13556614835`, `13624027434`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R36-091 — Flexible schedules — every N days, N×/week or month — 7 (1.30%, mean 4.00); habits shown on days they are not scheduled SCHEDDAY- 3 (all 4–5★)

- **Where:** §3.5 R_FLEX
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** R_FLEX 7, 4.00; SCHEDDAY- 3
- **Direction for us:** build-free · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `8383787890`, `8774281298`, `8840784226`, `9898093006`, `10793530840`, `11280034510`, `12065767176`, `10945684076`, `11815224356`, `12152046240`
- **Canonical:** C043 Flexible / custom frequency

### R36-092 — More / repeated / snoozable reminders 7 (1.30%, mean 3.86); reminders not firing NOTIF- 2 (1.50)

- **Where:** §3.5 R_NOTIF
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** R_NOTIF 7, 3.86; NOTIF- 2
- **Direction for us:** build-free · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `9091830635`, `10358584157`, `12102232868`, `12759861353`, `13279758046`, `13348454083`, `13401743740`, `8845345016`, `12392171682`
- **Canonical:** C039 Reminders fire reliably, once; C253 Notification restraint — few, finely controllable notifications keep the users that spammy rivals lose

### R36-094 — Widget improvements — titles, colours, streak display — 6 (1.11%, mean 3.67)

- **Where:** §3.5 R_WIDGET
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 6 (1.11%), 3.67
- **Direction for us:** build-free · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `9098509320`, `11694919799`, `12544966110`, `13162761819`, `13462331422`, `13902720788`
- **Canonical:** C107 Widget variants and customisation as the paid layer

### R36-095 — Account / login requested 5 (0.93%, mean 3.00) — mostly Chinese-market; '希望可以登陆' (17 votes, third most-voted)

- **Where:** §3.5 R_ACCOUNT
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 5 (0.93%), 3.00
- **Direction for us:** must-have · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `8664069478`, `9076528710`, `11067586008`, `11301370583`, `13624027434`
- **Canonical:** C035 Account system from day one

### R36-096 — Landscape / rotation 5 (0.93%, mean 4.40) and a real iPad layout 4 (0.74%, mean 4.00), early era

- **Where:** §3.5 R_LANDSCAPE / R_IPAD
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 5 + 4
- **Direction for us:** must-have · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `8622721501`, `8632947214`, `8757837312`, `8759804137`, `8782357563`, `8727604239`
- **Canonical:** C141 Native iPad layout

### R36-097 — Multiple completions per day / quantity 5 (0.93%, mean 3.60)

- **Where:** §3.5 R_MULTI
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 5 (0.93%), 3.60
- **Direction for us:** build-free · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `11486217313`, `11523323203`, `12065767176`, `12367187835`, `13162761819`
- **Canonical:** C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N

### R36-098 — Interactive / tappable widget 4 (0.74%, mean 3.75) — 'instead of taking advantage of the iOS 17 update with interactive widgets, they preferred to make that option paid'

- **Where:** §3.5 R_IWIDGET
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 4 (0.74%), 3.75
- **Direction for us:** build-free · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `10777840197`, `11523323203`, `11694919799`, `12326839720`
- **Canonical:** C023 Interactive widget check-off

### R36-099 — Timer / pomodoro / duration 4 (0.74%, mean 2.50) — one expected a timer because a screenshot showed a habit named 'Run 15 minutes'

- **Where:** §3.5 R_TIMER
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 4 (0.74%), 2.50
- **Direction for us:** research · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `9898093006`, `10358584157`, `11388263305`, `12167197066`
- **Canonical:** C066 Focus timer

### R36-100 — Apple Health 3 (3.00); notes on a habit 3 (4.00); grouping habits 2 (4.00)

- **Where:** §3.5 R_HEALTH / R_NOTES / R_ORG
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 3 / 3 / 2
- **Direction for us:** research · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `10793530840`, `10964238644`, `13902720788`, `9567517609`, `11980712489`, `9898093006`, `12090899566`, `13061585954`
- **Canonical:** C021 Apple Health integration; C045 Grouping / folders / categories / tags; C172 Per-day / per-habit notes and journal text

### R36-101 — Weak single requests: individually buyable / more free themes; a to-do list; habit-stacking method guidance; the music as a soundscape / on Spotify; a quit-a-habit inverse mode

- **Where:** §3.5 R_THEME / R_TODO / R_ADVICE / R_MUSIC / R_QUIT
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 1 each
- **Direction for us:** none · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `9567517609`, `8769392731`, `12097852488`, `12323195954`, `14510762767`
- **Canonical:** C019 Quit-habit / bad-habit mode; C050 One-off to-dos alongside habits

### R36-105 — A reward journey that is identical for every habit and ends at 60 days runs out: BORING- 8 (2.50) + R_BEYOND60 6 + GAME- 4 (1.75) = 17 distinct reviews (mean 2.76) — 'the story is repeated for all habits … if you have one habit that's ahead, you know the story … pretty boring' (3★, 8 votes, the most analytically precise negative review); 'the haptics is quite fun at first but it's the same for every habit … the novelty decreases'; 'please add different journeys'; 'it's a shame that it lasts only 60 days … I could have built something infinitely'; 'the art only goes up to 60 … wouldn't hurt to add more especially when you're paying money'

- **Where:** §3.6 The one structural criticism — BORING- 8 (1.48%, 2.50) + R_BEYOND60 6 (1.11%) + GAME- 4 (0.74%): the monument is the same journey for every habit and ends at 60 days
- **This app does:** same 60-day journey per habit
- **User reaction:** churn
- **Magnitude:** 17 distinct, mean 2.76
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9098509320`, `13594356619`, `14471085224`, `13572306369`, `10043311417`
- **Canonical:** C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R36-118 — Sync is the polite ask of fans: sync demand union 34 (6.30%, mean 3.59), 11 at 4★ and 10 at 5★ — 'Almost perfect! … It's just missing one thing - sync between devices'; 'Only thing missing is the sync between devices'; 'iCloud sync would seal the deal for me'

- **Where:** §4.3 Cluster 3 — U_SYNC_DEMAND (R_SYNC + R_ACCOUNT + ENT) 34 (6.30%), mean 3.59; the ask is polite from fans (11 at 4★, 10 at 5★) — 'Almost perfect! … It's just missing one thing - sync between devices'; 'iCloud sync would seal the deal for me'
- **This app does:** no sync
- **User reaction:** blocked-conversion
- **Magnitude:** 34 (6.30%), 3.59
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8272945413`, `8748825608`, `11318709831`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C030 Sync must work — and prove it

### R36-126 — Provide an all-habits overview to check off in one place: NOLIST 12 (2.22%, mean 3.17) — 'no consolidated list / calendar view of all of your habits'; 'a way to see your habits on a list that you can check off one by one'; 'A multi-habit view mode would go a long way'; 'an aggregate view with all my progressions across all habits'; 'view all the habits in a single page to check or uncheck'

- **Where:** §4.4 The missing view is an all-habits overview (NOLIST 12, mean 3.17) — 'no consolidated list / calendar view of all of your habits'; 'A multi-habit view mode would go a long way'; 'view all the habits in a single page to check or uncheck'
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 12 (2.22%), 3.17
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8182905997`, `11659987897`, `12153499058`, `13948551648`, `14510762767`
- **Canonical:** C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R36-128 — Basic habit management gaps: cannot delete or rename a habit (DELETE- 10, 1.85%, mean 3.00); habit-name character limit (NAMELEN 3); habits shown on days they are not scheduled (SCHEDDAY- 3, all 4–5★)

- **Where:** §4.4 Adjacent — cannot delete/rename a habit DELETE- 10 (3.00); habit-name character limit NAMELEN 3; habits shown on unscheduled days SCHEDDAY- 3 (all 4–5★)
- **This app does:** delete/rename hard; name length; schedule display
- **User reaction:** complaint
- **Magnitude:** DELETE- 10 (3.00); NAMELEN 3 (3.33); SCHEDDAY- 3 (4.33)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8757312048`, `8964135829`, `9021270886`, `9098509320`, `10738443241`, `10945684076`, `11224445709`, `11245244275`, `11280034510`, `12339917492`, `8774281298`, `13010314496`, `13670415847`, `11815224356`, `12152046240`
- **Canonical:** C043 Flexible / custom frequency; C073 Manual reordering, renaming and editing of habits/tasks — free

### R36-148 — Let buyers preview a paid skin before buying: a would-be buyer notes skins can't be previewed ('even if I can't preview it')

- **Where:** §6.3 a skin preview — 'even if I can't preview it'
- **This app does:** no skin preview
- **User reaction:** blocked-conversion
- **Magnitude:** n=1
- **Direction for us:** build-paid · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `8668843555`
- **Canonical:** C167 Cosmetic and colour variety as the paid layer

### R36-201 — Hide habits on days they are not scheduled — a pure polish win (all 4–5★ reviewers)

- **Where:** §10.2 action 10
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** SCHEDDAY- 3
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10945684076`, `11815224356`, `12152046240`
- **Canonical:** C043 Flexible / custom frequency

### R36-210 — Private iCloud / CloudKit sync, keeping the no-account, no-harvesting posture — also fixes data loss and entitlements across devices

- **Where:** §10.4 roadmap 1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** R_SYNC 34, 26.5% of payers, ≥2 non-renewals, ≥1 refusal to buy
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10771936163`, `9745264915`
- **Canonical:** C030 Sync must work — and prove it; C085 Address tracking / privacy visibly

### R36-211 — Vary the journeys and remove the 60-day ceiling — the main retention lever, price-independent

- **Where:** §10.4 roadmap 2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 17 distinct, mean 2.76
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9098509320`, `13594356619`, `14471085224`, `13572306369`, `10043311417`
- **Canonical:** C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R36-212 — An all-habits overview (same as fix #8) — also unlocks multi-habit use, i.e. the paid use case

- **Where:** §10.4 roadmap 3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** NOLIST 12
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R36-213 — Statistics / counts / a year-in-review — rising (4.6% of E5); one reviewer counts completions per month by hand

- **Where:** §10.4 roadmap 4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** R_STATS 10
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12367187835`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R36-214 — Apple Watch app — pure upside, asked for by fans; one wants the haptics on the wrist

- **Where:** §10.4 roadmap 5
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** R_WATCH 9 (4.11)
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12438446023`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R36-215 — Interactive widget plus widget titles and colours — a 2★ specifically because iOS 17 interactive widgets were not adopted

- **Where:** §10.4 roadmap 6
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** R_IWIDGET 4 + R_WIDGET 6
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12326839720`
- **Canonical:** C023 Interactive widget check-off; C107 Widget variants and customisation as the paid layer

### R36-216 — Optional streaks / reps and a 'don't skip twice' rule — must stay optional (NOSHAME 11 praise their absence); one reviewer proposes the exact mechanic

- **Where:** §10.4 roadmap 7
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** R_STREAK 7
- **Direction for us:** undecided · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13967987039`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R36-217 — Multiple completions per day / quantity targets (water in ounces)

- **Where:** §10.4 roadmap 8
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** R_MULTI 5
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11486217313`, `12065767176`, `13162761819`
- **Canonical:** C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N

### R36-218 — More / repeated / snoozable reminders — opt-in so it does not compromise notification restraint

- **Where:** §10.4 roadmap 9
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** R_NOTIF 7, clustered in E4
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once; C253 Notification restraint — few, finely controllable notifications keep the users that spammy rivals lose

### R36-219 — Apple Health integration — a 10,000-step habit that auto-completes

- **Where:** §10.4 roadmap 10
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** R_HEALTH 3 (emerging)
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10964238644`
- **Canonical:** C021 Apple Health integration

### R36-220 — Notes on a completion · habit grouping · individually buyable skins · a quit-a-habit mode — weak signals, log, do not schedule

- **Where:** §10.4 roadmap 11
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** R_NOTES 3 · R_ORG 2 · R_THEME 1 · R_QUIT 1
- **Direction for us:** none · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** — (nuance register)

## Monetization

### R36-011 — The free cap tightened in steps: 2 habits in Dec 2025 – Feb 2026, then 1 habit from March 2026 (one reviewer remembers three, another five) — each step on existing users

- **Where:** Executive summary #2 — the cap also tightened: 2 habits Dec 2025 – Feb 2026, 1 habit from March 2026; one remembers three, another five
- **This app does:** unlimited → 2 → 1
- **User reaction:** complaint
- **Magnitude:** 2 (4 reviews) → 1 (5 reviews)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13577681414`, `13594173870`, `13604432669`, `13710833763`, `13871290077`, `13971171093`, `14183623397`, `14302616144`, `14433892949`, `13625458345`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R36-015 — Monetisation friction is the largest negative cluster: 121 reviews (22.41%, high-priority, mean 2.53) — in 41 of 66 1★ (62.1%) and 20 of 29 2★ (69.0%) but only 10 of 327 5★ (3.1%)

- **Where:** Executive summary #4 — monetisation friction U_MON_FRICTION 121 (22.41%, high-priority), mean 2.53; 41 of 66 1★ (62.1%), 20 of 29 2★ (69.0%), 10 of 327 5★ (3.1%)
- **This app does:** subscription + gates
- **User reaction:** complaint
- **Magnitude:** 121 (22.41%), 2.53; 62.1% of 1★; 69.0% of 2★; 3.1% of 5★
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R36-016 — Rejection of subscription as a model is separate from price: 35 reviews (6.48%, mean 2.60), a consistent ~6% in every era — 'Nothing about this app that should require a subscription. I would be more than happy to pay for it outright, but that is not an option. So, I'm not gonna be paying anything at all'

- **Where:** Executive summary #4 — subscription-as-a-model rejection 35 (6.48%), mean 2.60 — 'I would be more than happy to pay for it outright, but that is not an option. So, I'm not gonna be paying anything at all'
- **This app does:** subscription only
- **User reaction:** blocked-conversion
- **Magnitude:** 35 (6.48%), mean 2.60
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11598093250`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R36-017 — Willing buyers ask for a one-time / lifetime unlock and currently convert to nothing: 24 reviews (4.44%, mean 3.42, only 1 of 24 1★) — 'I'd love to pay the creator £5 for it'; 'I'd absolutely pay a flat price to own the app, even $20 or 30 bucks'; 'flat fee + micro transactions = hell yeah'; 'ich würde 5€ oder auch 7,99€ einmalig zahlen'

- **Where:** Executive summary #4 — asks for a one-time / lifetime option 24 (4.44%), mean 3.42, only 1 of 24 1★ — '£5'; 'even $20 or 30 bucks'; 'flat fee + micro transactions = hell yeah'; 'ich würde 5€ oder auch 7,99€ einmalig zahlen'
- **This app does:** no one-time option (except ¥398 CN 2026)
- **User reaction:** blocked-conversion
- **Magnitude:** 24 (4.44%), mean 3.42; 1 1★
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `9800669659`, `9647917670`, `13384969940`, `14249690007`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R36-018 — The price objection is about ratio to perceived substance, not absolute money: price level 36 (6.67%, mean 2.31) — '$15 for permission to buy a $10 skin. Scam!'; '就这点功能还要订阅？' ('this little functionality needs a subscription?')

- **Where:** Executive summary #4 — price level 36 (6.67%), mean 2.31 — ratio to perceived substance: '$15 for permission to buy a $10 skin. Scam!'; 'this little functionality needs a subscription?'
- **This app does:** ~$15/yr → $59–70
- **User reaction:** complaint
- **Magnitude:** 36 (6.67%), mean 2.31
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9271651117`, `9373070993`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R36-047 — Price points reviewers name (unverified): $14.99–$15/year Habits alone; ~$30/year 5-app suite; €15–18/year; €35/year; $59 / $70 / €70 (2026); '$15 a month' (likely misreading annual); $70/year 'if you want any decent skins'; ¥398 one-time single app (CN, Aug 2026); ₹499/year (IN, Mar 2026); '$15 for permission to buy a $10 skin'

- **Where:** §2.2 Price points reviewers actually name (verbatim table)
- **This app does:** ~$15/yr → $59–70
- **User reaction:** mixed
- **Magnitude:** Claim | Reviews ; $14.99–$15 / year, Habits alone | 10713355484, 10817577185, 11486217313, 8905583877 ; ~$30 / year, 5-app suite | 10713355484, 11016580901 ; €15–18 / year | 8210628761, 10900786783 ; €35 / year | 11705166238 ; $59 / $70 / €70 | 14174554457, 14465422602 ; "$15 a month" (likely a misreading of the annual price) | 8804881126, 9647917670, 13384969940 ; $70 / year "if you want any decent skins" | 9504356434 ; ¥398 one-time for a single app (CN, Aug 2026) | 14450598724 ; ₹499 / year (IN, Mar 2026) | 13902720788 ; "$15 for permission to buy a $10 skin" | 9271651117
- **Direction for us:** research · **Report confidence:** reviewer claims · **Generalisable:** app-specific
- **Review IDs:** `10713355484`, `10817577185`, `11486217313`, `8905583877`, `11016580901`, `8210628761`, `10900786783`, `11705166238`, `14174554457`, `14465422602`, `8804881126`, `9647917670`, `13384969940`, `9504356434`, `14450598724`, `13902720788`, `9271651117`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R36-050 — Gate reactions ranked: habits beyond the free limit CAP 30 (5.56%, mean 2.30) worst — reads as a retraction; widgets WIDGETGATE 14 (2.59%, 2.64) second — same retraction dynamic; skins / themes / colours inside PAYWALL 31 (5.74%, 2.77) broadly accepted when it is the only gate ('So far the app is mostly free aside from cosmetics (understandable)'; 'I can understand locking skins behind a paywall but ALL widgets???'); subscription as such SUB- 35 (6.48%, 2.60) rejected on principle by ~6% every era

- **Where:** §2.3 What is gated, and how reviewers react to each gate (verbatim table) — habits CAP 30 (2.30) worst; widgets 14 (2.64) second; skins inside PAYWALL 31 (5.74%, 2.77) broadly accepted; subscription model SUB- 35 (6.48%, 2.60)
- **This app does:** habits / widgets / skins / subscription
- **User reaction:** mixed
- **Magnitude:** Gate | Reviews naming it | Mean | Reaction ; Habits beyond the free limit | CAP 30 (5.56%) | 2.30 | Worst. Reads as a retraction; drives the 2026 collapse ; Widgets | WIDGETGATE 14 (2.59%) | 2.64 | Second worst. Same retraction dynamic in Oct 2023 ; Skins / themes / colours | inside PAYWALL 31 (5.74%) | 2.77 | Broadly accepted when it is the *only* gate: "So far the app is mostly free aside from cosmetics (understandable)" (11130442867); "I can understand locking skins behind a paywall but ALL widgets???" (11016580901) ; The subscription model as such | SUB- 35 (6.48%) | 2.60 | Rejected on principle by a consistent ~6% of reviewers in every era
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11130442867`, `11016580901`
- **Canonical:** C001 Never move a free feature behind the paywall; C133 Gate on capability, not on quantity; C167 Cosmetic and colour variety as the paid layer

### R36-061 — 'Not worth the money' 21 (3.89%, mean 2.24, zero 5★, 12 of 21 1–2★) — often tied to SUITE-: paying for four apps to get one good one

- **Where:** §3.1 theme table VALUE-
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 21 (3.89%), 2.24; 0/3/6/5/7
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R36-063 — Price praised / worth it 20 (3.70%, mean 4.80) — satisfied buyers

- **Where:** §3.1 theme table PRICE+
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 20 (3.70%), 4.80
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R36-064 — Conditional purchase intent 10 (1.85%, mean 4.70)

- **Where:** §3.1 theme table BUYIF
- **This app does:** see §3.1
- **User reaction:** blocked-conversion
- **Magnitude:** 10 (1.85%), 4.70
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R36-079 — A tiny free tier hides the paid product's real problems until after purchase: TRIAL 7 (1.30%, mean 2.43) — 'these issues aren't readily apparent from the free version when you only have two habits to look at'

- **Where:** §3.3 TRIAL 7, mean 2.43 — 'these issues aren't readily apparent from the free version when you only have two habits to look at'
- **This app does:** no real trial; 1–2 free habits
- **User reaction:** blocked-conversion
- **Magnitude:** 7 (1.30%), mean 2.43
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13670415847`
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay

### R36-109 — Archived / completed habits must not count against a free cap: 'when I went to archive one of my completed habits and tried to make a new one it wouldn't let me … seems like kind of a ripoff'

- **Where:** §4.1 Archived habits count against the cap — 'when I went to archive one of my completed habits and tried to make a new one it wouldn't let me … seems like kind of a ripoff'
- **This app does:** archived habits count
- **User reaction:** complaint
- **Magnitude:** n=1 (4★, edited)
- **Direction for us:** product-rule · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `13577681414`
- **Canonical:** C219 A free cap must be concurrent, never lifetime — deleting a habit frees a slot

### R36-112 — Reviewers volunteer the acceptable free cap: three — 'Three would be reasonable for a paywall but only one??'; 'Ein Cap bei 3 Gewohnheiten hätte ich in Ordnung gefunden'; 'it was actually good when we could 3-4 habits'

- **Where:** §4.1 Reviewers volunteer the acceptable number: three — 'Three would be reasonable for a paywall but only one??'; 'Ein Cap bei 3 Gewohnheiten hätte ich in Ordnung gefunden'; 'it was actually good when we could 3-4 habits'
- **This app does:** cap 1
- **User reaction:** blocked-conversion
- **Magnitude:** 3 reviews name 3; one 3–4
- **Direction for us:** product-rule · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `14109551956`, `14236390341`, `13825736968`, `12556296093`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R36-119 — No sync is a stated reason not to buy and not to renew: 'I won't end up using it or purchasing a membership unless it has the ability to sync' (au); 'I did end up buying the 1 year subscription, but the app was largely unused … I'd be renewing, but I do not plan to. If iCloud sync is ever supported I will be back'

- **Where:** §4.3 It is a stated reason not to buy or not to renew — 'I won't end up using it or purchasing a membership unless it has the ability to sync'; 'If iCloud sync is ever supported I will be back'
- **This app does:** no sync
- **User reaction:** churn
- **Magnitude:** 2 non-renewal / non-purchase
- **Direction for us:** must-have · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `9745264915`, `10771936163`
- **Canonical:** C030 Sync must work — and prove it; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R36-141 — The top purchase trigger is proof first — the free app worked, then they paid: 6 of 34 payers (17.6%) — 'Have been having it for free until today and decided to purchase'; 'MAKING MY LIFE SO MUCH BETTER!!! … The subscription is a small price to pay'; 'I tried out the paid version on a whim and I can't believe it was actually worth it'; 'I don't typically like paying for subscriptions but this one is definitely worth it'

- **Where:** §6.3 Proof first — the free app worked, then they paid: 6 (17.6%) — 'Have been having it for free until today and decided to purchase'; 'I tried out the paid version on a whim and I can't believe it was actually worth it'
- **This app does:** generous free tier then subscription
- **User reaction:** purchase-driver
- **Magnitude:** 6/34 (17.6%)
- **Direction for us:** build-free · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8882707067`, `8148224036`, `12660421508`, `10008304313`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C147 Let people use the product before they pay

### R36-142 — Patronage converts: 5 of 34 payers (14.7%) paid to support an indie maker — 'I bought a paid subscription to support the developer'; 'had to support them with a membership'; 'l'idée de payer 15€ par an pour féliciter, soutenir et remercier le travail d'une équipe indépendante'; 'how do you thank the dev? Buy a beautiful skin'

- **Where:** §6.3 Patronage — paying to support an indie maker: 5 (14.7%) — 'I bought a paid subscription to support the developer'; 'l'idée de payer 15€ par an pour féliciter, soutenir et remercier le travail d'une équipe indépendante'; 'how do you thank the dev? Buy a beautiful skin'
- **This app does:** indie maker
- **User reaction:** purchase-driver
- **Magnitude:** 5/34 (14.7%)
- **Direction for us:** do · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8742019793`, `11234189426`, `8210628761`, `8736830661`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R36-143 — A low annual price anchored against rivals converts: 4 of 34 payers (11.8%) — 'Subscription price is reasonable, and actually cheaper than the previous habit tracker I was using'; '$14.99 … less than a quarter of the price for competitor habit trackers'; vs Atoms at '£17.99 a month' — an anchor that the 2026 rise to $59–70 removes

- **Where:** §6.3 Price anchoring against competitors: 4 (11.8%) — 'actually cheaper than the previous habit tracker I was using'; '$14.99 … less than a quarter of the price for competitor habit trackers'; vs Atoms at '£17.99 a month'
- **This app does:** $14.99/yr (2022–25)
- **User reaction:** purchase-driver
- **Magnitude:** 4/34 (11.8%)
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8868694307`, `11486217313`, `11125368439`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R36-145 — Cosmetic skins are a (smaller) purchase trigger: 3 of 34 payers (8.8%) — 'the skins are very fun too'; 'I'd be very happy to buy new skins'; 'Plenty of skins to choose from'

- **Where:** §6.3 The skins / cosmetics themselves: 3 (8.8%) — 'the skins are very fun too'; 'I'd be very happy to buy new skins'; 'Plenty of skins to choose from'
- **This app does:** skins paid
- **User reaction:** purchase-driver
- **Magnitude:** 3/34 (8.8%)
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `12903468865`, `8668843555`, `11562816267`
- **Canonical:** C167 Cosmetic and colour variety as the paid layer

### R36-147 — The cheapest conversions available name their condition: BUYIF 10 (1.85%, mean 4.70) — sync ('I'd suggest adding another pricing tier to add this feature. I'd pay it'), more themes and encouragement text ('then I would definitely pay'), a skin preview before buying ('even if I can't preview it'), the app proving itself, a more motivating mood ('I want to buy the subscription but currently it lacks certain things'), and simply affording it ('I hope to buy the pro version soon')

- **Where:** §6.3 BUYIF 10 (1.85%, mean 4.70) name their own condition: sync ('I'd suggest adding another pricing tier to add this feature. I'd pay it'); more themes and encouragement text; a skin preview; the app proving itself; a more motivating mood; being able to afford it
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** 10 (1.85%), mean 4.70
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9745264915`, `8757837312`, `10010716282`, `8668843555`, `8803885432`, `10135990177`, `11704920604`, `13556614835`, `14486511768`
- **Canonical:** C030 Sync must work — and prove it; C167 Cosmetic and colour variety as the paid layer

### R36-188 — There is a live market of one-time buyers with money in hand: 24 reviews (mean 3.42, one 1★) would pay a flat fee and not a subscription, naming prices £5, $20–30, €5–7.99, ¥50, ~$100

- **Where:** Part 9 #5
- **This app does:** competitor lesson
- **User reaction:** mixed
- **Magnitude:** competitor lesson (see body)
- **Direction for us:** build-paid · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `9800669659`, `9647917670`, `14249690007`, `9895154481`, `10358584157`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R36-205 — Ship a one-time / lifetime unlock alongside the subscription (price point unknown); if the ¥398 China SKU exists, the problem is discoverability, not product

- **Where:** §10.3 action 14 (Test)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** ONETIME 24 (3.42) + SUB- 35; prices £5, $20–30, €5–7.99, ¥50, ~$100
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9800669659`, `9647917670`, `14249690007`, `9895154481`, `10358584157`, `14450598724`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R36-206 — Sell Habits standalone, prominently — stop making people buy four apps to get one

- **Where:** §10.3 action 15 (Make)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** SUITE- 9 (3.22)
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9504356434`, `9895154481`, `11084742467`, `8865115966`, `11245244275`, `13646358981`, `9313935543`
- **Canonical:** C060 Cross-sell an app family on brand trust; C247 Never make a sibling-app bundle the only way to buy this app's own premium

### R36-207 — Give a real evaluation path — a time-boxed full-feature trial, or enough free surface that the app can be judged ('any sort of trial period — even just an hour')

- **Where:** §10.3 action 16 (Test)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** TRIAL 7 (2.43)
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11344820966`, `13670415847`, `14405082563`
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

### R36-208 — Introduce regional pricing — weak-to-emerging signal, treat as a hypothesis

- **Where:** §10.3 action 17 (Test)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** REGIONAL 2 + IN ₹499 vs cheaper local rival + AFFORD 5
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10847370901`, `12524757331`, `13902720788`
- **Canonical:** C092 Regional pricing

## Tactics the app used

### R36-026 — Outcome of selling a multi-app suite membership: the cross-sell works — SUITE+ 34 (6.30%, mean 4.41), 'I purchased the S2 for the weather app, but Habits is really the star for me' — but SUITE- 9 (1.67%, mean 3.22) says the bundle is why the price feels wrong ('Theoretically it includes 3 other apps, but this is the only good one … the calculator app is great until it lags while you type a 3 digit number'; 'I only want to buy this one'; 'Me gustaría que vendieran el premium de solo esta app')

- **Where:** Executive summary #8 — the suite is a halo and a liability: SUITE+ 34 (6.30%), mean 4.41 — 'I purchased the S2 for the weather app, but Habits is really the star for me'
- **This app does:** 5-app suite membership
- **User reaction:** mixed
- **Magnitude:** SUITE+ 34 (6.30%), 4.41; SUITE- 9 (1.67%), 3.22
- **Direction for us:** undecided · **Report confidence:** very strong / meaningful · **Generalisable:** yes
- **Conditions:** weakest app in the bundle drags the perceived value of the price
- **Review IDs:** `11980712489`, `9504356434`, `11084742467`
- **Canonical:** C060 Cross-sell an app family on brand trust; C247 Never make a sibling-app bundle the only way to buy this app's own premium

### R36-045 — An App Store Awards / Apple Design Award feature drove discovery at launch (Jun 2022) — but raised the expectation bar (see §2.4 AWARD)

- **Where:** §2.2 App Store Awards feature drives discovery (Jun 2022)
- **This app does:** editorial feature
- **User reaction:** praise
- **Magnitude:** AWARD 4 (0.74%)
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `8803885432`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R36-144 — A suite brings buyers in through other apps: 4 of 34 payers (11.8%) bought for the suite — S2 bought for the weather app, 'Bought the 5 app package', a recommendation to buy the whole bundle — while another bought Habits alone as 'the only app in the pack truly worth it'

- **Where:** §6.3 The suite, not Habits: 4 (11.8%) — bought S2 for the weather app; 'Bought the 5 app package'; recommends the whole bundle; bought Habits alone as 'the only app in the pack truly worth it'
- **This app does:** suite membership
- **User reaction:** purchase-driver
- **Magnitude:** 4/34 (11.8%)
- **Direction for us:** undecided · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `11980712489`, `11938623754`, `9503462497`, `9313935543`
- **Canonical:** C060 Cross-sell an app family on brand trust

### R36-158 — Professionals recommending the app to clients is a discovery channel: a professional coach prescribes the app to clients (US)

- **Where:** §7.2 US #1 — a professional coach prescribing it to clients
- **This app does:** coach referral
- **User reaction:** praise
- **Magnitude:** n=1
- **Direction for us:** do · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `10832302556`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R36-221 — Release the music (e.g. on Spotify) — one review, zero cost, pure brand value

- **Where:** §10.4 roadmap 12
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** R_MUSIC 1
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12323195954`
- **Canonical:** — (nuance register)

### R36-230 — Experiments with the metric each moves: free cap 1 vs 3 vs 5 habits → paid conversion and 1★ rate jointly; widgets free vs gated → day-30 retention then conversion; lifetime SKU at ~$25–30 beside annual → incremental revenue from non-subscribers; upsell once-per-week vs every launch → conversion held constant, rating recovery; varied 60-day journeys → day-60 and day-120 retention; private iCloud sync → renewal among multi-device users; store-page disclosure → first-session 1★ rate

- **Where:** §10.6 Experiments worth running (verbatim table) — free cap 1 vs 3 vs 5 (conversion and 1★ jointly); widgets free vs gated (D30 retention then conversion); lifetime ~$25–30 alongside annual (incremental revenue from non-subscribers); upsell once-per-week vs every launch (conversion held, rating recovery); varied journeys (D60 / D120 retention); private iCloud sync (renewal among multi-device users); store-page disclosure (first-session 1★ rate)
- **This app does:** experiments
- **User reaction:** none
- **Magnitude:** Experiment | Hypothesis from the corpus | Primary metric ; Free cap at 1 vs 3 vs 5 habits | 3+ removes the grievance without losing the upgrade trigger (14109551956, 14236390341) | Paid conversion and 1★ rate, jointly ; Widgets free vs gated | Widgets drive adherence, and adherence drives willingness to pay (13462331422, 14445365483, 11562816267) | Day-30 retention, then conversion ; Lifetime SKU at ~$25–30 alongside the annual plan | 24 reviewers refuse the subscription and name flat prices in this band | Incremental revenue from non-subscribers ; Upsell once-per-week vs every launch | The screen costs ratings; its conversion may be near zero (12200644346, 11870684099) | Conversion held constant, rating recovery ; Varied 60-day journeys vs one journey | Novelty decay at ~60 days is the stated cause of drop-off (9098509320, 13594356619) | Day-60 and day-120 retention ; Private iCloud sync | The top request for 4.7 years and the top payer complaint | Renewal rate among multi-device users ; Store-page disclosure of the free limit | Converts day-one 1★ into informed non-installs (13971171093, 14197628877) | 1★ rate in the first session cohort
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `14109551956`, `14236390341`, `13462331422`, `14445365483`, `11562816267`, `12200644346`, `11870684099`, `9098509320`, `13594356619`, `13971171093`, `14197628877`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free; C030 Sync must work — and prove it; C093 No upsell nagging without a 'never ask again' option; C181 If the app is paid-only, say so in the subtitle and first screenshot; C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

## Insights (the why)

### R36-005 — The product wins on craft, praised in unusually specific terms: core praise 331 (61.30%, high-priority, mean 4.59); design / visuals 151 (27.96%, mean 4.54) — 'the best designed app i've come across in 18 years'; 'Monument Valley meets habit tracking'; 'it feels like Monument Valley' (Chinese)

- **Where:** Executive summary #1 — the product wins on craft: core praise 331 (61.30%, high-priority), mean 4.59
- **This app does:** 3D crafted design
- **User reaction:** praise
- **Magnitude:** core 331 (61.30%), 4.59; design 151 (27.96%), 4.54
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13678372106`, `8905583877`, `13191623782`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C069 Check-off sound and haptic

### R36-008 — Concrete outcomes 58 (10.74%, mean 4.95, zero below 4★): flossing 60 days, quit smoking, quit alcohol, reading 30 min/day, cold showers, 62-day morning routine

- **Where:** Executive summary #1 — concrete outcomes 58 (10.74%), mean 4.95, zero below 4★
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 58 (10.74%), mean 4.95
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8974979165`, `11412952836`, `13127746442`, `9519619698`, `12072516110`, `13462331422`
- **Canonical:** — (nuance register)

### R36-022 — The 2026 rating drop is a monetisation event, not usability: the cap arrived in the same window as the navigation fix, and usability complaints are at their lowest ever (6.5%) in the era with the worst ratings (E5 3.722)

- **Where:** Executive summary #5 — Interpretation: the cap arrived in the same window as the navigation fix, so the ratings drop is not explained by usability; U_USABILITY at its lowest in the era with the worst ratings
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** usability E5 6.5% vs E5 mean 3.722
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R36-024 — Paying customers are the least satisfied identifiable group: 34 explicit payers (6.30%) average 3.794 (below the 4.039 corpus mean), only 17 of 34 are 5★ and 8 of 34 (23.5%) rate 1–2★, while the 24 who praise the free tier average 4.88 with none below 4★ — money buys exposure to the real limits (no sync, entitlement not travelling across devices, billing problems, bugs); both support-failure records are payers

- **Where:** Executive summary #7 — paying customers are the least satisfied identifiable group: 34 payers (6.30%), mean 3.794 < 4.039; 17 of 34 5★; 8 of 34 1–2★ (23.5%); FREE+ 24 mean 4.88, zero below 4★
- **This app does:** subscription
- **User reaction:** complaint
- **Magnitude:** payers 34, 3.794, 23.5% 1–2★; FREE+ 24, 4.88
- **Direction for us:** must-never-break · **Report confidence:** meaningful (self-selected) · **Generalisable:** yes
- **Review IDs:** `9506691039`, `8757837312`, `9580841951`, `12524757331`, `10658186053`, `8969889060`, `13631929530`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R36-044 — Users warned in advance which free capability they valued: 'you can still get limitless habits w/ the free version — please keep it that way' (Jul 2023), two and a half years before the cap; the generous free tier was the praised selling point ('even the free version is so well made'; '0 ad clutter. 0 monthly charges')

- **Where:** §2.2 'you can still get limitless habits w/ the free version — please keep it that way' (Jul 2023)
- **This app does:** unlimited free habits
- **User reaction:** praise
- **Magnitude:** FREE+ 24, mean 4.88
- **Direction for us:** product-rule · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `10135990177`, `8733565149`, `8736830661`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R36-052 — A craft reputation attached to a named maker is an asset that thins as monetisation tightens: developer praise 27 (5.00%, very strong, mean 4.81) — 'Well done Andy!'; 'Love Andy's toys'; 'This app is made with a ton of passion' — falling 8.8% (E1) → 7.4 → 4.2 → 2.4 → 2.8% (E5)

- **Where:** §2.4 DEV+ 27 (5.00%, very strong), mean 4.81 — 'Well done Andy!'; 'Love Andy's toys'; falling 8.8% E1 → 7.4 → 4.2 → 2.4 → 2.8% E5
- **This app does:** named indie maker
- **User reaction:** praise
- **Magnitude:** 27 (5.00%), 4.81; 8.8 → 2.8%
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `9715331511`, `12800428077`, `12948428968`, `13948551648`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R36-054 — Editorial recognition raises the bar the paywall then violates: 4 reviews (0.74%) cite the Apple Design Award / App Store feature, two use it against the app — 'I don't understand how an app that annoys its users every single day with a full page popup … can win an Apple Design Award' (1★); 'For an Apple award winner, that's pretty disappointing' (2★)

- **Where:** §2.4 AWARD 4 (0.74%) — two use the Apple Design Award against the app: 'how an app that annoys its users every single day with a full page popup … can win an Apple Design Award' (1★); 'For an Apple award winner, that's pretty disappointing' (2★); editorial recognition raises the expectation bar that the paywall then violates
- **This app does:** award winner with daily upsell
- **User reaction:** complaint
- **Magnitude:** 4 (0.74%); 2 negative (1★, 2★)
- **Direction for us:** dont · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `10759740711`, `12167197066`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R36-056 — Simplicity as restraint 80 (14.81%, mean 4.75, zero 1★) — 'Other habit trackers have too much other gunk like blogs or media that don't actually add any value'

- **Where:** §3.1 theme table SIMPLE
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 80 (14.81%), 4.75; 66/9/4/1/0
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `8868694307`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R36-058 — Motivating 47 (8.70%, mean 4.83)

- **Where:** §3.1 theme table MOTIV
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 47 (8.70%), 4.83
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R36-060 — Useful 21 (3.89%, mean 4.90)

- **Where:** §3.1 theme table USEFUL
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 21 (3.89%), 4.90
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R36-062 — Explicit churn — deleted / switched / will not renew — 20 (3.70%, mean 2.05, 11 1★)

- **Where:** §3.1 theme table CHURN
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 20 (3.70%), 2.05
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R36-070 — No ads 6 (1.11%, mean 4.33); privacy praised 2 (0.37%) — 'Does what it's meant to do while respecting your privacy and not harvesting your data'; 'There's no ads and the developers don't collect your data'

- **Where:** §3.1 theme table NOADS / PRIVACY+
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** NOADS 6, 4.33; PRIVACY+ 2
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `9206039207`, `13670415847`
- **Canonical:** C085 Address tracking / privacy visibly; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R36-077 — U_MON_FRICTION (121) split by what people want: 'give me a one-time price' ONETIME 24 (3.42) — to buy, only 1 of 24 1★, 10 are 4★, the most salvageable; 'don't take away what I had' REGRESS 19 (1.95) — grandfathering, anger at the change not the price; 'the cap is too tight to evaluate or use' CAP 30 (2.30) — 3+ free habits (three name three, one 3–4); 'don't gate function, gate cosmetics' WIDGETGATE 14 + PAYWALL 31 (2.64 / 2.77); 'stop asking me every launch' POPUP 24 (2.67) — frequency capping; 'I can't judge it before paying' TRIAL 7 (2.43); 'the price doesn't match the substance' VALUE- 21 (2.24), often SUITE-; 'I genuinely cannot pay' AFFORD 5 (2.20); 'price isn't localised' REGIONAL 2 (2.00); 'it's worth it' PRICE+ 20 (4.80)

- **Where:** §3.3 Reading the monetisation objection correctly (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Sub-objection | n | Mean | What they actually want ; "Give me a one-time price" | ONETIME 24 | 3.42 | To buy. Only 1 of 24 is 1★; 10 are 4★. These are the most salvageable reviewers in the corpus ; "Don't take away what I had" | REGRESS 19 | 1.95 | Grandfathering. The anger is about the change, not the price ; "The cap is too tight to evaluate or use" | CAP 30 | 2.30 | 3+ free habits. Three reviewers name three explicitly (14109551956, 14236390341, 12556296093); one names 3–4 (13825736968) ; "Don't gate function, gate cosmetics" | WIDGETGATE 14 + PAYWALL 31 | 2.64 / 2.77 | A line between decoration and capability (2.3) ; "Stop asking me every launch" | POPUP 24 | 2.67 | Frequency capping. One 5★ reviewer calls the app "Unusable" because of it (11870684099) ; "I can't judge it before paying" | TRIAL 7 | 2.43 | A trial, or enough free surface to evaluate. Sharpest version: "these issues aren't readily apparent from the free version when you only have two habits to look at" (13670415847) ; "The price doesn't match the substance" | VALUE- 21 | 2.24 | More capability, or less money. Often tied to SUITE-: paying for four apps to get one good one ; "I genuinely cannot pay" | AFFORD 5 | 2.20 | Two are on disability (10658186053, 14179888590), one a student (11803536707), one names the demographic directly: "there is no way I can afford it without being part of the demographic which can drop 60$ on a reminder app" (14174554457) ; "Price isn't localised" | REGIONAL 2 | 2.00 | Regional pricing (10847370901 TR) and a China-specific billing failure (12524757331) ; "It's worth it" | PRICE+ 20 | 4.80 | Nothing — these are satisfied buyers (Part 6)
- **Direction for us:** product-rule · **Report confidence:** qualitative split · **Generalisable:** yes
- **Review IDs:** `14109551956`, `14236390341`, `12556296093`, `13825736968`, `11870684099`, `13670415847`, `10658186053`, `14179888590`, `11803536707`, `14174554457`, `10847370901`, `12524757331`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C025 Scholarship / hardship / discount program; C063 Free trial before purchase; C064 Price level — where 'fair' turns into 'too expensive'; C092 Regional pricing; C093 No upsell nagging without a 'never ask again' option; C167 Cosmetic and colour variety as the paid layer

### R36-078 — Roughly half of the monetisation friction is willingness to pay the model cannot accept — one-time buyers, people who would pay if the gate were cosmetic, people who would pay after a fair evaluation: a packaging problem, not a price problem

- **Where:** §3.3 Interpretation — roughly half of the monetisation friction is willingness to pay that the current model cannot accept; a packaging problem, not a price problem
- **This app does:** subscription-only, functional gates
- **User reaction:** blocked-conversion
- **Magnitude:** ~half of 121
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C147 Let people use the product before they pay

### R36-082 — Sensory feedback is the reward and the hardest thing to copy: haptic / sound praise is the most specific in the corpus (57, mean 4.61) — reviewers describe the physical act, not the feature — 'a small dose of dopamine every time you check something off' (from a 3★ critic); '手机也会给你不错的震动回饋'; even a 2★ reviewer says 'I love the sounds'

- **Where:** §3.4 #1 Sensory feedback as the reward — the most specific praise and the hardest for a competitor to copy; 'a small dose of dopamine every time you check something off' (a 3★ critic); a 2★ reviewer 'I love the sounds'
- **This app does:** hold-to-complete haptics and sound
- **User reaction:** praise
- **Magnitude:** 57 (10.56%), mean 4.61
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8139278712`, `13670415847`, `14045271461`, `14334631638`
- **Canonical:** C069 Check-off sound and haptic

### R36-083 — Curiosity about tomorrow's reward is a retention loop: the monument is a reason to return — 'I almost want to keep my habits just for the app'; 'I can't stop because I'm curious about what the next reward is the next day'

- **Where:** §3.4 #2 Curiosity as the retention loop — the monument is a reason to return tomorrow; 'I almost want to keep my habits just for the app'
- **This app does:** daily unveiled piece
- **User reaction:** praise
- **Magnitude:** GAME+ 74 (13.70%), mean 4.69
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10492156673`, `12219094304`, `13127746442`
- **Canonical:** C024 Streaks / gamification; C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R36-084 — Streak shame is why perfectionists delete habit apps: 'As an easily discouraged perfectionist … if you miss a day (or a week) … it doesn't become the app of shame. I never know if I should start over or quit. So I put my tail between my legs and delete it' (20 helpful votes) — the corpus's clearest competitive wedge (NOSHAME 11 + FLEX+ 2)

- **Where:** §3.4 #4 Kindness after a missed day — NOSHAME 11 + FLEX+ 2; 'I never know if I should start over or quit. So I put my tail between my legs and delete it'
- **This app does:** no punishment for missed days
- **User reaction:** praise
- **Magnitude:** NOSHAME 11 (2.04%), 4.55; FLEX+ 2; 20 votes
- **Direction for us:** product-rule · **Report confidence:** small count, disproportionate weight · **Generalisable:** yes
- **Review IDs:** `9122428340`, `9261590460`, `11943524242`, `12937403561`, `11085313395`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R36-107 — A finite novelty reward retains early and churns later: the thing that brings people back on day 3 is what makes them leave around day 60–120 — the clearest retention finding, independent of price; the least price-sensitive improvement and the one most likely to extend lifetime value

- **Where:** §3.6 Interpretation — what makes people return on day 3 makes them leave around day 60–120; the clearest retention finding, independent of price
- **This app does:** 60-day ceiling
- **User reaction:** churn
- **Magnitude:** 17 distinct (mean 2.76)
- **Direction for us:** research · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R36-110 — A 1-habit free tier destroys evaluability: 'you can't really test the app without paying'; 'these issues aren't readily apparent from the free version when you only have two habits'; one German reviewer uninstalled and went to an AI chatbot instead

- **Where:** §4.1 It destroys evaluability — 'you can't really test the app without paying'; one uninstalled and went to an AI chatbot instead
- **This app does:** 1–2 habit cap
- **User reaction:** churn
- **Magnitude:** 3 reviews
- **Direction for us:** product-rule · **Report confidence:** qualitative · **Generalisable:** yes
- **Side effects:** a general AI chatbot is named as the substitute
- **Review IDs:** `14405082563`, `13670415847`, `14236390341`
- **Canonical:** C056 Don't build AI features on demand grounds; C147 Let people use the product before they pay

### R36-120 — For payers missing sync becomes indignation: 'As a paid subscription, sync across devices must be made available as basic'; 'habits not syncing between devices in 25 is a quite not-so-good-looking bummer'; '¥398 — why is there no multi-device sync?'

- **Where:** §4.3 For payers it becomes indignation — 'As a paid subscription, sync across devices must be made available as basic'; 'habits not syncing between devices in 25 is a quite not-so-good-looking bummer'
- **This app does:** paid without sync
- **User reaction:** complaint
- **Magnitude:** 9/34 payers (26.5%)
- **Direction for us:** must-have · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10498701164`, `12800428077`, `14450598724`
- **Canonical:** C030 Sync must work — and prove it; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R36-131 — 4★ is the 'one thing short' band and the most actionable: 38.2% carry a feature request and 36.8% a monetisation objection, in a constructive tone (R_SYNC 16.2%, PAYWALL 14.7%, ONETIME 14.7%, SUB- 12.8%, SWITCH- 11.8%, CAP 8.8%) — 'Almost perfect! … It's just missing one thing - sync between devices'; 'If you had a left/right swap between habits, I would give you 5'; 'I'd be happy to pay for it on that basis. What I don't understand is why this is subscription based … so I've docked it a star for that' (7 votes)

- **Where:** §5.2 4★ — n = 68 (verbatim table) — the 'one thing short' band, most actionable: 38.2% request, 36.8% monetisation objection, constructive tone; 'If you had a left/right swap between habits, I would give you 5'; 'why this is subscription based … so I've docked it a star for that' (7 votes)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n in band | % of 68 ; Core praise | 40 | 58.8% ; U_MON_FRICTION | 25 | 36.8% ; U_UNMET | 26 | 38.2% ; DESIGN | 20 | 29.4% ; R_SYNC | 11 | 16.2% ; PAYWALL | 10 | 14.7% ; ONETIME | 10 | 14.7% ; SUB- | 9 | 12.8% ; CAP | 6 | 8.8% ; SWITCH- | 8 | 11.8%
- **Direction for us:** research · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8272945413`, `10016530116`, `9647405291`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C030 Sync must work — and prove it; C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R36-132 — 3★ is 'beautiful but': monetisation friction 50.0%, requests 40.0%, usability 32.0%, price 20.0%, sync 14.0%, UX- 14.0%, cap / SUB- 12.0% each, no-list 10.0%; the two most substantial reviews sit here — the repeated-story critique and a 700-word structured review concluding 'It's solid, dependable … But if it really wants to stand out, it needs to embrace the deeper psychology of habit formation' — plus the most detailed bundle critique

- **Where:** §5.3 3★ — n = 50 (verbatim table) — 'beautiful but': half money objection, a third navigation; the two most substantial reviews sit here (repeated-story critique; 700-word review 'it needs to embrace the deeper psychology of habit formation')
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n in band | % of 50 ; U_MON_FRICTION | 25 | 50.0% ; U_UNMET | 20 | 40.0% ; Core praise | 18 | 36.0% ; U_USABILITY | 16 | 32.0% ; DESIGN | 11 | 22.0% ; PRICE- | 10 | 20.0% ; R_SYNC | 7 | 14.0% ; UX- | 7 | 14.0% ; CAP / SUB- | 6 / 6 | 12.0% each ; NOLIST | 5 | 10.0%
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `9098509320`, `12097852488`, `9504356434`
- **Canonical:** — (nuance register)

### R36-133 — 2★ is where money and usability co-occur and the reviewer feels cheated: friction 69.0%, usability 31.0%, UX- 27.6%, price 27.6%, paywall 24.1%, SUB- / VALUE- / CAP 17.2% each, REGRESS 13.8% — 'Great Concept. Poor Usability.'; 'Beautiful Dissapointment'; 'Antes: Excelente. Ahora: Pésima'; 'Super bummer only one habit'; 'Everything is about the $$$'; zero 2★ reviews contain an outcome — nobody who reports real behaviour change rates 2★ or below

- **Where:** §5.4 2★ — n = 29 (verbatim table) — money and usability co-occur; 'Great Concept. Poor Usability.'; 'Beautiful Dissapointment'; 'Antes: Excelente. Ahora: Pésima'; 'Super bummer only one habit'; 'Everything is about the $$$'; zero 2★ contain OUTCOME
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n in band | % of 29 ; U_MON_FRICTION | 20 | 69.0% ; U_USABILITY | 9 | 31.0% ; UX- | 8 | 27.6% ; PRICE- | 8 | 27.6% ; PAYWALL | 7 | 24.1% ; SUB- / VALUE- / CAP | 5 each | 17.2% each ; REGRESS | 4 | 13.8%
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8182905997`, `10358584157`, `12326839720`, `14405082563`, `14179888590`
- **Canonical:** — (nuance register)

### R36-136 — 1★ as a protest vote: eight 1★ reviews still praise the app — 'There are some amazing things about this app … but the interface is so hard to use that I had to delete the app'; 'would've used this app everyday if not for your stupid subscriptions'; 'si on enlève le prix c'est la meilleure application d'habitudes' ('take away the price and it's the best habit app')

- **Where:** §5.5 Eight 1★ reviews still praise the app — the rating is a protest vote: 'the interface is so hard to use that I had to delete the app'; 'would've used this app everyday if not for your stupid subscriptions'; 'si on enlève le prix c'est la meilleure application d'habitudes'
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 8 of 66 1★ (12.1%)
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8784451516`, `13911270164`, `14034266336`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R36-146 — Social proof converts but does not retain: 'looking at one of my friend use this app, I paid for yearly subscription' — and then regretted it and switched back (1 of 34)

- **Where:** §6.3 Social proof from a real person: 1 (2.9%) — 'looking at one of my friend use this app, I paid for yearly subscription' — and then regretted it
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 1/34 (2.9%)
- **Direction for us:** none · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `12155806021`
- **Canonical:** — (nuance register)

### R36-149 — What satisfied payers value: core praise 21 of 34 (61.8%), price praised 8 (23.5%), design 8 (23.5%), simple 6, suite 6, game 5, outcome 5, haptic 4, developer 4 — the model payer review praises design, the 60-day journey as 'an epic journey', the writing, and three concrete outcomes (daily meditation, handstand progress, cut doomscrolling): 'I can't believe it was actually worth it, but for me it was genuinely helpful'

- **Where:** §6.4 What buyers value once they have paid — core praise 21 (61.8%), PRICE+ 8 (23.5%), DESIGN 8, SIMPLE 6, GAME+ 5, OUTCOME 5, SUITE+ 6, HAPTIC+ 4, DEV+ 4; satisfied payer: 'an epic journey', writing, meditation, handstand, cut doomscrolling — 'I can't believe it was actually worth it'
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** segment rates on 34
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `12660421508`
- **Canonical:** — (nuance register)

### R36-152 — Non-payer barriers: subscription refusal SUB- 35 (2.60) — a willing buyer who will not rent, 24 of them also ask for one-time; no one-time SKU ONETIME 24 (3.42) — the most convertible group; functional gating WIDGETGATE 14 + CAP 30 (2.64 / 2.30) — destroys the trust to pay and the surface to evaluate; cannot evaluate TRIAL 7 (2.43) — 'any sort of trial period — even just an hour — before you blow $15'; price vs substance PRICE- 36 + VALUE- 21 (2.31 / 2.24) — often a suite problem; launch upsell fatigue POPUP 24 (2.67) — converts ambivalence into hostility; inability to pay AFFORD 5 (2.20); undisclosed limits DISCLOSE 6 (1.67) — 1★ on day one before any product judgement

- **Where:** §6.6 Upgrade barriers among non-payers (verbatim table) — SUB- 35 (24 also ONETIME); ONETIME 24; functional gating WIDGETGATE 14 + CAP 30; TRIAL 7 ('any sort of trial period — even just an hour — before you blow $15'); PRICE- 36 + VALUE- 21 (often SUITE-); POPUP 24 converts ambivalence into hostility; AFFORD 5; DISCLOSE 6 produces 1★ on day one
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** Barrier | n | Mean | What it blocks ; Subscription-as-model refusal | SUB- 35 | 2.60 | A willing buyer who will not rent. 24 of these also ask for ONETIME ; No one-time / lifetime SKU | ONETIME 24 | 3.42 | The most convertible group in the corpus; only 1 of 24 is 1★ ; Functional gating (widgets, then habits) | WIDGETGATE 14 + CAP 30 | 2.64 / 2.30 | Destroys the trust needed to pay, and the evaluation surface needed to decide ; Cannot evaluate before paying | TRIAL 7 | 2.43 | "It would be nice for it to have any sort of trial period — even just an hour — before you blow $15" (11344820966) ; Price level relative to substance | PRICE- 36 + VALUE- 21 | 2.31 / 2.24 | Often really a SUITE- problem: paying for four apps to get one good one (9504356434, 9895154481, 11084742467) ; Launch upsell fatigue | POPUP 24 | 2.67 | Converts ambivalence into hostility: "I said no already, please respect that" (12200644346) ; Genuine inability to pay | AFFORD 5 | 2.20 | Not addressable by packaging alone ; Undisclosed limits | DISCLOSE 6 | 1.67 | Produces 1★ on day one, before any product judgement is possible
- **Direction for us:** product-rule · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `11344820966`, `9504356434`, `9895154481`, `11084742467`, `12200644346`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free; C025 Scholarship / hardship / discount program; C063 Free trial before purchase; C093 No upsell nagging without a 'never ask again' option; C181 If the app is paid-only, say so in the subtitle and first screenshot

### R36-181 — Once a feature costs money, users expect it to do more: after widgets were paywalled, widget-improvement demand peaked (E4 3.6%) — titles, colours, streak display, interactivity

- **Where:** §8.7 widget demand post-gate — 'now that widgets cost money, people want them to do more'
- **This app does:** widgets paid
- **User reaction:** complaint
- **Magnitude:** E4 3.6%
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C107 Widget variants and customisation as the paid layer

### R36-190 — Gamification has a 60-day half-life: 17 reviews describe the identical-journey / hard-stop problem; varied or endless progression addresses a documented complaint

- **Where:** Part 9 #7
- **This app does:** competitor lesson
- **User reaction:** mixed
- **Magnitude:** competitor lesson (see body)
- **Direction for us:** research · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Canonical:** C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

## Audiences

### R36-071 — Kids / family use 3 (0.56%, mean 4.67)

- **Where:** §3.1 theme table KIDS
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 3 (0.56%), 4.67
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C068 Parents tracking kids

### R36-080 — People who cannot pay are shut out as the price rises: AFFORD 5 (0.93%, mean 2.20) — two on disability, one student, and 'there is no way I can afford it without being part of the demographic which can drop 60$ on a reminder app'

- **Where:** §3.3 AFFORD 5, mean 2.20 — two on disability, one a student, 'there is no way I can afford it without being part of the demographic which can drop 60$ on a reminder app'
- **This app does:** $59–70 price
- **User reaction:** blocked-conversion
- **Magnitude:** 5 (0.93%), mean 2.20
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10658186053`, `14179888590`, `11803536707`, `14174554457`
- **Canonical:** C025 Scholarship / hardship / discount program

## Markets and languages

### R36-028 — Localisation demand was early, sharp and then answered: R_LANG 9 (1.67%), 8 of 9 in E1 (7.0% of that era), six from the Chinese market plus MX 1★ ('solo esté en inglés me hace perder el interés'); after Sep 2022 it almost stops (one pt-BR Feb 2024) — localisation probably shipped; China (cn 38, mean 3.605) remains second-worst on price and sync, not language

- **Where:** Executive summary #9 — localisation demand R_LANG 9 (1.67%), 8 of 9 in E1 (7.0%), six Chinese-market; MX 1★ 'solo esté en inglés me hace perder el interés'; after Sep 2022 almost stops; localisation probably shipped; China (38, 3.605) second-worst on price and sync, not language
- **This app does:** English at launch; probably localised later
- **User reaction:** complaint
- **Magnitude:** 9 (1.67%); 8 in E1 (7.0%); cn 38 mean 3.605
- **Direction for us:** build-free · **Report confidence:** meaningful in E1 · **Generalisable:** yes
- **Review IDs:** `8660174556`, `8772660358`, `8787860020`, `8804471876`, `8815511952`, `8744602982`, `8778158271`, `8771578171`, `10911777454`
- **Canonical:** C027 Localise early — it unlocks revenue

### R36-081 — Price not localised: regional pricing complaint from Turkey and a China-specific billing failure (REGIONAL 2, mean 2.00)

- **Where:** §3.3 REGIONAL 2, mean 2.00 — regional pricing (TR) and a China-specific billing failure
- **This app does:** one global price
- **User reaction:** complaint
- **Magnitude:** 2 (0.37%), mean 2.00
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10847370901`, `12524757331`
- **Canonical:** C092 Regional pricing

### R36-122 — Chinese-market users ask for an account / login specifically: '希望可以登陆 / 登陆' ('hope we can log in') has 17 helpful votes, the third most-voted review in the corpus

- **Where:** §4.3 There is no account at all, and Chinese-market reviewers ask for login specifically — '希望可以登陆 / 登陆' (17 helpful votes, third most-voted)
- **This app does:** no account
- **User reaction:** complaint
- **Magnitude:** R_ACCOUNT 5; 17 votes
- **Direction for us:** research · **Report confidence:** limited evidence (CN) · **Generalisable:** yes
- **Review IDs:** `8664069478`, `9076528710`, `11067586008`, `11301370583`, `13624027434`
- **Canonical:** C035 Account system from day one

### R36-156 — US themes (252): design 25.40% (4.44), generic 16.67%, game 16.27%, simple 15.48%, outcome 15.08% (4.95), haptic 12.30%, comp 9.13%, motivation 8.73%, UX- 8.73% (1.95), suite+ 6.75%, payer 6.75% (3.88), price- 6.75% (2.24), developer 6.35%, paywall 5.95%, best 5.95%, SUB- 5.56%, CAP 5.56% (2.64), price+ 4.76%, onboarding 4.76% (1.50), useful 4.37%, switch 4.37%, value- 4.37%, one-time 4.37% (3.00), notif+ 3.97%, popup 3.97% (2.40), free+ 3.57%, churn 3.17%, quotes 3.17%, regress 3.17%, no-list 2.78%, sync 2.38%

- **Where:** §7.2 United States — n = 252, mean 4.095 (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 252 | Signal (US denominator) | Mean ; DESIGN | 64 | 25.40% | high-priority | 4.44 ; GEN+ | 42 | 16.67% | high-priority | 4.95 ; GAME+ | 41 | 16.27% | high-priority | 4.76 ; SIMPLE | 39 | 15.48% | high-priority | 4.85 ; OUTCOME | 38 | 15.08% | high-priority | 4.95 ; HAPTIC+ | 31 | 12.30% | high-priority | 4.61 ; COMP | 23 | 9.13% | high-priority | 4.00 ; MOTIV | 22 | 8.73% | high-priority | 4.91 ; UX- | 22 | 8.73% | high-priority | 1.95 ; SUITE+ | 17 | 6.75% | high-priority | 4.59 ; PAYER | 17 | 6.75% | high-priority | 3.88 ; PRICE- | 17 | 6.75% | high-priority | 2.24 ; DEV+ | 16 | 6.35% | high-priority | 4.75 ; PAYWALL | 15 | 5.95% | high-priority | 2.87 ; BEST | 15 | 5.95% | high-priority | 4.73 ; SUB- | 14 | 5.56% | high-priority | 2.71 ; CAP | 14 | 5.56% | high-priority | 2.64 ; PRICE+ | 12 | 4.76% | very strong | 4.83 ; ONBOARD- | 12 | 4.76% | very strong | 1.50 ; USEFUL | 11 | 4.37% | very strong | 5.00 ; SWITCH- | 11 | 4.37% | very strong | 3.82 ; VALUE- | 11 | 4.37% | very strong | 2.18 ; ONETIME | 11 | 4.37% | very strong | 3.00 ; NOTIF+ | 10 | 3.97% | very strong | 4.60 ; POPUP | 10 | 3.97% | very strong | 2.40 ; FREE+ | 9 | 3.57% | very strong | 5.00 ; CHURN | 8 | 3.17% | very strong | 2.50 ; QUOTES+ | 8 | 3.17% | very strong | 5.00 ; REGRESS | 8 | 3.17% | very strong | 2.38 ; NOLIST | 7 | 2.78% | meaningful | 3.00 ; R_SYNC | 6 | 2.38% | meaningful | 3.50
- **Direction for us:** none · **Report confidence:** US standalone · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R36-157 — The US is the outcome market: outcomes 15.08% of US reviews vs 6.94% non-US — narrative before-and-after reviews (flossing, quitting smoking, 5am discipline, softball training) and a professional coach prescribing the app to clients

- **Where:** §7.2 US #1 — it is the outcome market: OUTCOME 15.08% vs 6.94% non-US; flossing, quitting smoking, 5am discipline, softball training, a professional coach prescribing it to clients
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 15.08% vs 6.94%
- **Direction for us:** none · **Report confidence:** US high-priority · **Generalisable:** yes
- **Review IDs:** `8974979165`, `11412952836`, `14087244075`, `10832302556`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R36-159 — The US is also the comparison-shopping market: competitors named 9.13% vs 5.90% non-US; 'best' 5.95%; one review benchmarks against seven named apps

- **Where:** §7.2 US #2 — comparison-shopping market: COMP 9.13% vs 5.90%; BEST 5.95%; one benchmarks against seven named apps
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 9.13% vs 5.90%
- **Direction for us:** none · **Report confidence:** US high-priority · **Generalisable:** yes
- **Review IDs:** `11697727372`
- **Canonical:** C005 Know which competitors buyers compare against

### R36-160 — US reviewers are 3.4× more likely to say they could not work out how to use it: onboarding complaints 4.76% vs 1.39% non-US; UX- 8.73% vs 4.17%; usability 15.87% vs 9.72%

- **Where:** §7.2 US #3 — usability complaints concentrate in the US: UX- 8.73% vs 4.17%; ONBOARD- 4.76% vs 1.39% (3.4×); U_USABILITY 15.87% vs 9.72%
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** ONBOARD- 4.76 vs 1.39; UX- 8.73 vs 4.17
- **Direction for us:** must-have · **Report confidence:** US very strong · **Generalisable:** yes
- **Canonical:** C075 Skippable, replayable onboarding tour

### R36-161 — Sync demand is 4× higher outside the US (9.72% vs 2.38%), the largest US/non-US divergence — more likely what each market writes about than a real preference; do not read it as 'US users don't want sync'

- **Where:** §7.2 US #4 — cares least about sync: R_SYNC 2.38% vs 9.72% non-US (4×, largest divergence) — more likely reflects what each market writes about; do not read it as 'US users don't want sync'
- **This app does:** no sync
- **User reaction:** complaint
- **Magnitude:** 2.38% vs 9.72%
- **Direction for us:** must-have · **Report confidence:** US very strong (interpretation) · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it; C062 Weight English-speaking rich markets; volume ≠ revenue

### R36-162 — Friction is equal in size but different in kind: US 21.03% vs non-US 23.61%; the US supplies one-time requests (4.37%) and 'not worth it' (4.37%) — a packaging argument — while non-US reviewers supply more free-tier praise (5.21% vs 3.57%) and principled subscription refusal (7.29% vs 5.56%)

- **Where:** §7.2 US #5 — monetisation friction at global level (21.03% vs 23.61%) but composition differs: US supplies ONETIME 4.37% and VALUE- 4.37% (packaging); non-US more FREE+ (5.21% vs 3.57%) and SUB- (7.29% vs 5.56%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 21.03 vs 23.61; ONETIME/VALUE- 4.37 US; FREE+ 5.21 vs 3.57; SUB- 7.29 vs 5.56
- **Direction for us:** research · **Report confidence:** US standalone · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C062 Weight English-speaking rich markets; volume ≠ revenue

### R36-163 — The habit cap upset every market equally: CAP 5.56% in the US and 5.56% outside it

- **Where:** §7.2 US #6 — the US habit-cap reaction is exactly proportional: CAP 5.56% US vs 5.56% non-US; this change upset everyone equally
- **This app does:** cap
- **User reaction:** complaint
- **Magnitude:** 5.56% vs 5.56%
- **Direction for us:** product-rule · **Report confidence:** US high-priority · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R36-164 — Notification restraint and the writing are US talking points: NOTIF+ 3.97% vs 0.69% non-US; QUOTES+ 3.17% vs 1.74%

- **Where:** §7.2 US #7 — notification restraint is a US talking point (NOTIF+ 3.97% vs 0.69%), as is the writing (QUOTES+ 3.17% vs 1.74%)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 3.97 vs 0.69; 3.17 vs 1.74
- **Direction for us:** none · **Report confidence:** US very strong · **Generalisable:** yes
- **Canonical:** C253 Notification restraint — few, finely controllable notifications keep the users that spammy rivals lose

### R36-165 — US vs non-US: outcome 15.08 vs 6.94% (US writes results, others impressions); sync 2.38 vs 9.72%; onboarding 4.76 vs 1.39%; UX- 8.73 vs 4.17%; unmet requests 11.90 vs 25.69% (non-US reviews are feature-request-shaped); notification praise 3.97 vs 0.69%; design 25.40 vs 30.21%; misrate 0.79 vs 2.43%; 'repetitive' 0.40 vs 2.43% (mostly non-US); cap · paywall · price 5.56 · 5.95 · 6.75% vs 5.56 · 5.56 · 6.60% — essentially identical: the monetisation problem is global

- **Where:** §7.3 Global vs US — what genuinely differs (verbatim table); U_UNMET 11.90% vs 25.69% (non-US reviews are feature-request-shaped); DESIGN 25.40 vs 30.21; MISRATE 0.79 vs 2.43; BORING- 0.40 vs 2.43; CAP · PAYWALL · PRICE- essentially identical — the monetisation problem is global
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | US (n=252) | non-US (n=288) | Read ; OUTCOME | 15.08% | 6.94% | US writes results; others write impressions ; R_SYNC | 2.38% | 9.72% | Biggest divergence in the corpus ; ONBOARD- | 4.76% | 1.39% | US reports confusion far more ; UX- | 8.73% | 4.17% | Same ; U_UNMET | 11.90% | 25.69% | Non-US reviews are feature-request-shaped ; NOTIF+ | 3.97% | 0.69% | US-specific appreciation ; DESIGN | 25.40% | 30.21% | Design praise is slightly more non-US ; MISRATE | 0.79% | 2.43% | Star/text mismatch is more common outside the US ; BORING- | 0.40% | 2.43% | The "it's repetitive" critique is mostly non-US ; CAP · PAYWALL · PRICE- | 5.56% · 5.95% · 6.75% | 5.56% · 5.56% · 6.60% | Essentially identical — the monetisation problem is global
- **Direction for us:** research · **Report confidence:** US standalone · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R36-166 — UK (n = 42, mean 3.690, limited evidence): subscription-model objections (SUB- 7) are most articulate here and half of all 'repetitive' critiques (BORING- 4) come from the UK; a student names Streaks at £5.99 one-time

- **Where:** §7.4 United Kingdom — n = 42, mean 3.690 (limited evidence): SUB- 7, BORING- 4 (half of all); the most articulate subscription-model objections; a student naming Streaks at £5.99 one-time
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 42, mean 3.690; SUB- 7; BORING- 4
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `9647405291`, `9800669659`, `10666079618`, `13384969940`, `11803536707`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R36-167 — China (n = 38, mean 3.605, lowest of the top six, limited evidence): three consistent themes — design loved ('it feels like Monument Valley'; '设计满分！'), the subscription rejected with a buyout asked for ('应该控制在50元内买断' — buy-out under ¥50; '希望要么换回买断' — switch back to buy-out), and sync and login wanted (17-vote login request); plus the only multi-charge billing failure with a region dimension; early localisation demand concentrated here and then stopped

- **Where:** §7.4 China — n = 38, mean 3.605 (limited evidence): R_SYNC 7, DESIGN 7, PRICE- 7, R_LANG 4, R_ACCOUNT 3; design loved ('设计满分！'); price/model rejected and buyout asked ('应该控制在50元内买断'; '希望要么换回买断'); sync and login wanted; multi-charge billing failure; early localisation demand stopped
- **This app does:** subscription; ¥398 one-time by Aug 2026
- **User reaction:** mixed
- **Magnitude:** 38, mean 3.605; R_SYNC 7; PRICE- 7; R_LANG 4; R_ACCOUNT 3; ONETIME 3
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13191623782`, `8831096266`, `9895154481`, `12162017884`, `8664069478`, `12524757331`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C027 Localise early — it unlocks revenue; C030 Sync must work — and prove it; C035 Account system from day one

### R36-168 — India (n = 32, mean 3.906, limited evidence): design-led praise with sync as the blocker (R_SYNC 6), and an explicit price-per-feature comparison with a local-priced rival — 'Dayrise is better at this price range … only gamified 3D animations at ₹499/yr'

- **Where:** §7.4 India — n = 32, mean 3.906: DESIGN 11, R_SYNC 6; 'Dayrise is better at this price range … only gamified 3D animations at ₹499/yr'
- **This app does:** ₹499/yr
- **User reaction:** mixed
- **Magnitude:** 32, mean 3.906; DESIGN 11; R_SYNC 6
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13902720788`
- **Canonical:** C030 Sync must work — and prove it; C092 Regional pricing

### R36-169 — Canada (n = 21, mean 4.000, limited evidence): design 7, simple 6, payer 3, suite 3; includes the 'roach motel' cancellation report, 'Bait and switch', and the only positive support record

- **Where:** §7.4 Canada — n = 21, mean 4.000: includes the 'roach motel' cancellation report, 'Bait and switch', and the only SUPPORT+
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 21, mean 4.000
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `9580841951`, `13770142251`, `11938623754`
- **Canonical:** C112 In-app cancellation

### R36-170 — Germany (n = 15, mean 3.667, limited evidence): three reviewers left or uninstalled (→ Onrise, → an AI chatbot, won't continue long-term) and three complain about the one-habit cap; Germany supplies the most precise one-time-price offers — 'ich würde 5€ oder auch 7,99€ einmalig zahlen'; '€18/year … there are no ongoing running costs so I don't see why there isn't a one-time purchase option'

- **Where:** §7.4 Germany — n = 15, mean 3.667: SUB- 3, CHURN 3, CAP 3; three left (→ Onrise, → an AI chatbot, won't continue); most precise one-time-price offers ('ich würde 5€ oder auch 7,99€ einmalig zahlen'; '€18/year … there are no ongoing running costs so I don't see why there isn't a one-time purchase option')
- **This app does:** subscription
- **User reaction:** churn
- **Magnitude:** 15, mean 3.667; SUB- 3; CHURN 3; CAP 3; ONETIME 2
- **Direction for us:** build-paid · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13689787553`, `14236390341`, `10900786783`, `14249690007`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it

### R36-171 — France (n = 13, mean 4.308, highest of the top six, limited evidence): the most design-forgiving block and the only review arguing for paying indie developers on principle; one 1★ on the cap and one on disclosure

- **Where:** §7.4 France — n = 13, mean 4.308: most design-forgiving; the only review arguing for paying indie developers on principle; one 1★ cap, one disclosure
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 13, mean 4.308; DESIGN 6
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `8210628761`, `14034266336`, `14197628877`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

## Dated events and trends

### R36-010 — Introducing a habit cap on a previously unlimited free tier broke the ratings: CAP 30 reviews (5.56%, high-priority, mean 2.30), 29 of them in E5 (Dec 2025 → Sep 2026) where it is 26.9% of all reviews; before December 2025 it is essentially absent (0 of 114 E1, 0 of 68 E2, 0 of 167 E3, 1 ambiguous in E4); 2026 mean 3.636 with 27.3% 1–2★ against 2024's 4.312 / 9.9%; E5 mean 3.722, 25.0% 1–2★ — the worst era, worse than the rough launch

- **Where:** Executive summary #2 — the December 2025 free-tier habit cap broke the ratings: CAP 30 (5.56%), mean 2.30; 29 of 30 in E5 (26.9% of E5); before Dec 2025 essentially absent
- **This app does:** unlimited free habits → capped Dec 2025
- **User reaction:** 1★-burst
- **Magnitude:** CAP 30 (5.56%), 2.30; 29/30 in E5 (26.9%); 2026 3.636 / 27.3% vs 2024 4.312 / 9.9%; E5 3.722 / 25.0%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R36-013 — Gating free widgets in October 2023 produced the same retraction backlash: three 1★ reviews from three storefronts inside 36 hours — 'the widget … now shows Tap to Unlock … I am deleting the widget and the app' (US); 'After making the Home Screen widgets paid (they were on the free version) you deserve an uninstall' (EG); 'Widget Removed. Pretty Useless Now' (IN); then 'widgets used to be free, now they cost' (CN); WIDGETGATE 14 (2.59%, mean 2.64), 10 in E3; 2023 H2 mean 3.56

- **Where:** Executive summary #3 — the same mechanism had already been run once, in October 2023: WIDGETGATE 14 (2.59%), mean 2.64, 10 in E3; three 1★ from three storefronts inside 36 hours
- **This app does:** widgets free → paid ~4 Oct 2023
- **User reaction:** 1★-burst
- **Magnitude:** 14 (2.59%), mean 2.64; 10 in E3; 3 1★ in 36h
- **Direction for us:** product-rule · **Report confidence:** very strong in E3 · **Generalisable:** yes
- **Review IDs:** `10436306704`, `10438409618`, `10439795484`, `10672228882`, `10610214785`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free

### R36-020 — An unconventional UI starts as the main complaint and can be fixed: usability 68 (12.59%, high-priority, mean 2.96) fell from 21.9% of E1 → 8.8% E2 → 12.0% E3 → 12.0% E4 → 6.5% E5; UX- 14.9% → 2.8%; ONBOARD- 7.9% → 1.9% — 2021–22: 'Ambiguous icons without labels, unintuitive swipes … no consolidated list / calendar view of all of your habits' (8 votes); 'Is there no manual? Or user guide? I see no way to add new items like a + sign'

- **Where:** Executive summary #5 — usability was the original problem and most of it was fixed: U_USABILITY 68 (12.59%), mean 2.96; 21.9% E1 → 8.8 → 12.0 → 12.0 → 6.5% E5; UX- 14.9% → 2.8%; ONBOARD- 7.9% → 1.9%
- **This app does:** unlabeled icons, swipe UI, fixed over time
- **User reaction:** complaint
- **Magnitude:** 68 (12.59%), 2.96; 21.9 → 6.5%
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8182905997`, `8777347712`
- **Canonical:** C075 Skippable, replayable onboarding tour

### R36-031 — Per-year n, mean and 1–2★ share: 2021 8 (4.000, 25.0%) · 2022 122 (3.959, 20.5%) · 2023 78 (3.936, 17.9%) · 2024 141 (4.312, 9.9%) · 2025 92 (4.250, 14.1%) · 2026 99 (3.636, 27.3%)

- **Where:** §1.6 By year (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | Mean | 1–2★ share ; 2021 (from 15 Dec) | 8 | 4.000 | 25.0% ; 2022 | 122 | 3.959 | 20.5% ; 2023 | 78 | 3.936 | 17.9% ; 2024 | 141 | 4.312 | 9.9% ; 2025 | 92 | 4.250 | 14.1% ; 2026 (to 4 Sep) | 99 | 3.636 | 27.3%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R36-032 — Half-year series — n / mean / 1–2★ / friction / CAP / launch upsell / usability / core praise: 2021 H2 8 / 4.00 / 25.0 / 0.0 / 0.0 / 0.0 / 25.0 / 62.5; 2022 H1 67 / 3.76 / 23.9 / 13.4 / 0 / 1.5 / 26.9 / 64.2; 2022 H2 55 / 4.20 / 16.4 / 21.8 / 0 / 3.6 / 10.9 / 60.0; 2023 H1 46 / 4.20 / 10.9 / 21.7 / 0 / 4.3 / 10.9 / 71.7; 2023 H2 32 / 3.56 / 28.1 / 34.4 / 0 / 9.4 / 12.5 / 56.2; 2024 H1 79 / 4.37 / 8.9 / 17.7 / 0 / 2.5 / 11.4 / 59.5; 2024 H2 62 / 4.24 / 11.3 / 17.7 / 0 / 4.8 / 11.3 / 66.1; 2025 H1 50 / 4.16 / 16.0 / 18.0 / 2.0 / 2.0 / 16.0 / 66.0; 2025 H2 42 / 4.36 / 11.9 / 14.3 / 2.4 / 9.5 / 7.1 / 76.2; 2026 H1 79 / 3.56 / 29.1 / 36.7 / 30.4 / 3.8 / 6.3 / 45.6; 2026 H2 20 / 3.95 / 20.0 / 50.0 / 20.0 / 15.0 / 5.0 / 50.0 — two troughs (2023 H2 widgets, 2026 H1 cap), both monetisation events with usability near its low

- **Where:** §1.6 By half-year — the shape of the story in one table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Period | n | Mean | 1–2★ | Monetisation friction | CAP | Launch upsell | Usability | Core praise ; 2021 H2 | 8 | 4.00 | 25.0% | 0.0% | 0.0% | 0.0% | 25.0% | 62.5% ; 2022 H1 | 67 | 3.76 | 23.9% | 13.4% | 0.0% | 1.5% | 26.9% | 64.2% ; 2022 H2 | 55 | 4.20 | 16.4% | 21.8% | 0.0% | 3.6% | 10.9% | 60.0% ; 2023 H1 | 46 | 4.20 | 10.9% | 21.7% | 0.0% | 4.3% | 10.9% | 71.7% ; 2023 H2 | 32 | 3.56 | 28.1% | 34.4% | 0.0% | 9.4% | 12.5% | 56.2% ; 2024 H1 | 79 | 4.37 | 8.9% | 17.7% | 0.0% | 2.5% | 11.4% | 59.5% ; 2024 H2 | 62 | 4.24 | 11.3% | 17.7% | 0.0% | 4.8% | 11.3% | 66.1% ; 2025 H1 | 50 | 4.16 | 16.0% | 18.0% | 2.0% | 2.0% | 16.0% | 66.0% ; 2025 H2 | 42 | 4.36 | 11.9% | 14.3% | 2.4% | 9.5% | 7.1% | 76.2% ; 2026 H1 | 79 | 3.56 | 29.1% | 36.7% | 30.4% | 3.8% | 6.3% | 45.6% ; 2026 H2 (to 4 Sep) | 20 | 3.95 | 20.0% | 50.0% | 20.0% | 15.0% | 5.0% | 50.0%
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set

### R36-043 — Timeline: Dec 2021 → mid 2022 launch, subscription from the start and sometimes defended ('The subscription is a small price to pay'), a 7-day trial mentioned once, widgets appear to lock after a week for free users (Jun 2022, 1★), App Store Awards feature drives discovery; mid 2022 → Sep 2023 free tier genuinely generous — unlimited habits, everything but cosmetics ('0 ad clutter. 0 monthly charges'; 'you can still get limitless habits w/ the free version — please keep it that way'), ~$15/yr single, ~$30/yr five; ~4 Oct 2023 widgets move behind the paywall ('Tap to Unlock'); Oct 2023 → Nov 2025 stable, ratings recover to the high (2024 H1 4.37); ~Dec 2025 free tier capped at 2 habits, archived habits count, simultaneous navigation update; ~Mar → Sep 2026 cap 1 habit, prices $59–$70, ¥398 one-time CN

- **Where:** §2.2 Timeline of the business (verbatim table)
- **This app does:** subscription from launch; two retractions
- **User reaction:** mixed
- **Magnitude:** Period | State | Key evidence ; Dec 2021 → mid 2022 | Launch. Subscription exists from the start and is sometimes *defended*: "The subscription is a small price to pay" (8148224036, Dec 2021). A 7-day trial is mentioned once (8804881126). Widgets appear to lock after a week for free users (8797076855, Jun 2022, 1★). App Store Awards feature drives discovery (8803885432, Jun 2022). | 8148224036, 8337984672, 8797076855, 8803885432 ; mid 2022 → Sep 2023 | Free tier described as genuinely generous — unlimited habits, everything but cosmetics. "even the free version is so well made" (8733565149); "0 ad clutter. 0 monthly charges" (8736830661); "you can still get limitless habits w/ the free version — please keep it that way" (10135990177, Jul 2023). Tiers ~$15/yr single app, ~$30/yr for five. | 8733565149, 8736830661, 10135990177, 10713355484 ; ~4 Oct 2023 | Widgets move behind the paywall. Existing widgets start showing "Tap to Unlock". Three 1★ reviews from us/eg/in within 36 hours. | 10436306704, 10438409618, 10439795484, 10610214785, 10672228882 ; Oct 2023 → Nov 2025 | Stable: unlimited free habits, paid skins + widgets, a recurring launch upsell. Ratings recover to the corpus high (2024 H1 mean 4.37). Single-app tier ~$15/yr; suite ~$30/yr. | 11499453960, 11704920604, 10817577185, 10900786783 ; ~Dec 2025 | Free tier capped at 2 habits. Archived/completed habits count against the cap. A simultaneous update improves habit switching and tracking detail. | 13577681414 (31 Dec), 13594173870, 13604432669, 13572606322 (the update) ; ~Mar 2026 → Sep 2026 | Cap tightened to 1 habit, and prices reported higher ($59–$70; ¥398 one-time in CN). | 13871290077, 13971171093, 14183623397, 14302616144, 14174554457, 14465422602, 14450598724
- **Direction for us:** product-rule · **Report confidence:** inference from review text · **Generalisable:** app-specific
- **Review IDs:** `8148224036`, `8337984672`, `8797076855`, `8803885432`, `8804881126`, `8733565149`, `8736830661`, `10135990177`, `10713355484`, `10436306704`, `10438409618`, `10439795484`, `10610214785`, `10672228882`, `11499453960`, `11704920604`, `10817577185`, `10900786783`, `13577681414`, `13594173870`, `13604432669`, `13572606322`, `13871290077`, `13971171093`, `14183623397`, `14302616144`, `14174554457`, `14465422602`, `14450598724`
- **Canonical:** C001 Never move a free feature behind the paywall

### R36-108 — Cap cluster evidence: before Dec 2025 unlimited free habits repeatedly praised ('you get unlimited habits and all non-cosmetic features other than the widgets. Fenomenal value', Jul 2024; 'not restricted to a amount of habits', Sep 2024); first 2-habit reports from 31 Dec 2025 (4★ edited; 4 Jan 1★; 4 Jan gb 2★; 7 Jan 1★; 12 Jan in 1★; 14 Jan id 4★; 4 Feb 4★ 9 votes); tightened to 1 habit from ~Mar 2026 (21 Mar ae; 18 Apr; 6 May fr; 17 May; 26 May; 10 Jun; 14 Jun; 28 Jun de ×2; 14 Jul at; 9 Aug; 16 Aug gb)

- **Where:** §4.1 Cluster 1 — The free habit cap (verbatim evidence table)
- **This app does:** unlimited → 2 → 1
- **User reaction:** 1★-burst
- **Magnitude:** What | Evidence ; Before Dec 2025: unlimited free habits, repeatedly praised | 10135990177 (Jul 2023) "you can still get limitless habits w/ the free version — please keep it that way"; 11499453960 (Jul 2024) "you get unlimited habits and all non-cosmetic features other than the widgets. Fenomenal value"; 11704920604 (Sep 2024) "not restricted to a amount of habits" ; First cap reports: 2 habits, from 31 Dec 2025 | 13577681414 (31 Dec, 4★, edited), 13594173870 (4 Jan, 1★), 13594356619 (4 Jan, gb, 2★), 13604432669 (7 Jan, 1★), 13624027434 (12 Jan, in, 1★), 13632154898 (14 Jan, id, 4★), 13710833763 (4 Feb, 4★, 9 votes) ; Tightened to 1 habit, from ~Mar 2026 | 13871290077 (21 Mar, ae), 13971171093 (18 Apr), 14034266336 (6 May, fr), 14073702229 (17 May), 14109551956 (26 May), 14164387323 (10 Jun), 14183623397 (14 Jun), 14235507906 (28 Jun, de), 14236390341 (28 Jun, de), 14302616144 (14 Jul, at), 14405082563 (9 Aug), 14433892949 (16 Aug, gb) ; Archived habits count against the cap | 13577681414 "when I went to archive one of my completed habits and tried to make a new one it wouldn't let me … seems like kind of a ripoff" ; It destroys evaluability | 14405082563 "you can't really test the app without paying"; 13670415847 "these issues aren't readily apparent from the free version when you only have two habits to look at"; 14236390341 uninstalled and went to an AI chatbot instead ; It reads as punishing loyalty | 13780647190 (qa, 1★) "Just another company cashing out on the loyalty of longtime users"; 13625458345 "I've used this app for years … I was hit with a paywall. And the prices are higher than what I remember" ; Reviewers volunteer the acceptable number: three | 14109551956 "Three would be reasonable for a paywall but only one??"; 14236390341 "Ein Cap bei 3 Gewohnheiten hätte ich in Ordnung gefunden"; 13825736968 "it was actually good when we could 3-4 habits" ; One 2026 reviewer mistakes the cap for a bug | 14235507906 (de, 1★) "App is extremely bugged. I cannot add a second habit"
- **Direction for us:** product-rule · **Report confidence:** high-priority in E5 · **Generalisable:** yes
- **Review IDs:** `10135990177`, `11499453960`, `11704920604`, `13577681414`, `13594173870`, `13594356619`, `13604432669`, `13624027434`, `13632154898`, `13710833763`, `13871290077`, `13971171093`, `14034266336`, `14073702229`, `14109551956`, `14164387323`, `14183623397`, `14235507906`, `14236390341`, `14302616144`, `14405082563`, `14433892949`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R36-114 — Cap rating consequence: 2026 H1 mean 3.56, 29.1% 1–2★, CAP present in 30.4% of all reviews in the half-year, and core praise at 45.6% — its lowest in the corpus — in the same window

- **Where:** §4.1 Rating consequence — 2026 H1 mean 3.56, 29.1% 1–2★, CAP in 30.4% of all reviews; core praise falls to 45.6%, its lowest
- **This app does:** cap
- **User reaction:** 1★-burst
- **Magnitude:** 2026 H1 3.56; 29.1%; CAP 30.4%; core praise 45.6%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set

### R36-115 — Widget retraction aftershocks: users read the gate as a bug for months — 'for the last 2 months the widget app has not been working properly … says that I have to unlock it' (21 Nov 2023, 4★); 'widgets used to be free, now they cost' (CN, 9 Dec); 'the widgets stopped working at the same time' (Apr 2024); REGRESS contributes 6 in E3

- **Where:** §4.2 Cluster 2 — the October 2023 widget retraction: aftershocks 'for the last 2 months the widget app has not been working properly … says that I have to unlock it'; 'the widgets stopped working at the same time'
- **This app does:** widget gate
- **User reaction:** complaint
- **Magnitude:** WIDGETGATE 14; REGRESS 6 in E3
- **Direction for us:** product-rule · **Report confidence:** very strong in E3 · **Generalisable:** yes
- **Review IDs:** `10610214785`, `10672228882`, `11178506784`
- **Canonical:** C009 Basic widgets, icons and colours are free; C104 Never ship a paywall or feature-removal change silently

### R36-127 — Navigation partially fixed in Dec 2025 — a payer saw requested switching and deeper tracking ship 'literally that same week'; 'The recent upgrades only made it even more useful!' — but Jan and Apr 2026 complaints show the fix is incomplete, and it shipped in the same window as the habit cap

- **Where:** §4.4 Partially shipped Dec 2025 — 'literally that same week they rolled out an update with those exact features'; 'The recent upgrades only made it even more useful!'; still complaints Jan and Apr 2026
- **This app does:** navigation update Dec 2025
- **User reaction:** mixed
- **Magnitude:** UPDATE+ 2; complaints continue
- **Direction for us:** do · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `13572606322`, `13681211961`, `13670415847`, `13948551648`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R36-134 — 1★ has exactly two causes that changed place over time: 2021–22 'I can't work out how to use it' (ONBOARD- 9 of its 16 at 1★, all in E1); 2023–26 'you took something away / it's not really free' (CAP 12, REGRESS 9, WIDGETGATE 4, DISCLOSE 4); 11 of the 20 churn reviews are 1★; 1★ composition — friction 62.1%, usability 25.8%, UX- 21.2%, CAP / PRICE- / SUB- 18.2% each, churn 16.7%, onboarding 13.6%, REGRESS 13.6%, reliability 12.1%, POPUP 12.1%, core praise still 12.1%, GRAPHICS- 7.6%, DISCLOSE 6.1%

- **Where:** §5.5 1★ — n = 66 (verbatim table) — exactly two causes that changed place: 2021–22 'I can't work out how to use it' (ONBOARD- 9 of 16 at 1★, E1 holds 9); 2023–26 'you took something away / it's not really free' (CAP 12, REGRESS 9, WIDGETGATE 4, DISCLOSE 4); 11 of 20 CHURN are 1★
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n in band | % of 66 ; U_MON_FRICTION | 41 | 62.1% ; U_USABILITY | 17 | 25.8% ; UX- | 14 | 21.2% ; CAP / PRICE- / SUB- | 12 each | 18.2% each ; CHURN | 11 | 16.7% ; ONBOARD- | 9 | 13.6% ; REGRESS | 9 | 13.6% ; U_RELIABILITY | 8 | 12.1% ; POPUP | 8 | 12.1% ; Core praise (still present) | 8 | 12.1% ; GRAPHICS- | 5 | 7.6% ; DISCLOSE | 4 | 6.1%
- **Direction for us:** product-rule · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8252766990`, `8676576820`, `8777347712`, `8779668476`, `8617674000`
- **Canonical:** C001 Never move a free feature behind the paywall; C075 Skippable, replayable onboarding tour

### R36-175 — The product did not get worse; the offer did: E3 → E4 → E5 mean 4.162 → 4.205 → 3.722; 1–2★ 13.2 → 15.7 → 25.0%; monetisation friction 21.0 → 16.9 → 37.0% (more than doubles); CAP 0.0 → 1.2 → 26.9%; REGRESS 3.6 → 2.4 → 10.2%; core praise 60.5 → 69.9 → 49.1%; design praise 31.1 → 32.5 → 13.9%; usability complaints 12.0 → 12.0 → 6.5% (halve) — design praise collapsing is the symptom to watch: reviewers stopped writing about what the app is best at because they were writing about the paywall

- **Where:** §8.2 Trend 1 — The 2026 rating collapse is real and it is a monetisation event (verbatim table): E3 / E4 / E5 mean 4.162 / 4.205 / 3.722; 1–2★ 13.2 / 15.7 / 25.0; friction 21.0 / 16.9 / 37.0; CAP 0.0 / 1.2 / 26.9; REGRESS 3.6 / 2.4 / 10.2; core praise 60.5 / 69.9 / 49.1; DESIGN 31.1 / 32.5 / 13.9; usability 12.0 / 12.0 / 6.5
- **This app does:** cap
- **User reaction:** 1★-burst
- **Magnitude:** Metric | E3 (widget-gate era) | E4 (stable) | E5 (cap era) ; Mean rating | 4.162 | 4.205 | 3.722 ; 1–2★ share | 13.2% | 15.7% | 25.0% ; Monetisation friction | 21.0% | 16.9% | 37.0% ; CAP | 0.0% | 1.2% | 26.9% ; REGRESS | 3.6% | 2.4% | 10.2% ; Core praise | 60.5% | 69.9% | 49.1% ; DESIGN | 31.1% | 32.5% | 13.9% ; Usability complaints | 12.0% | 12.0% | 6.5%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set

### R36-176 — A generous free tier is an acquisition asset users advertise for you — until it is withdrawn: free-tier praise E1 4.4 → E2 1.5 → E3 6.6 → E4 6.0 → E5 1.9%; CAP 0 → 0 → 0 → 1.2 → 26.9%; in E3–E4 reviewers promoted the developer ('It's FREE and so pretty honestly just get all there apps'; 'Thanks Not Boring Team, for making your apps free to use'; 'unlimited habits and all non-cosmetic features other than the widgets. Fenomenal value') and in E5 the same surface produces CAP 26.9% and REGRESS 10.2% — the single clearest before/after in the corpus

- **Where:** §8.3 Trend 2 — The free tier went from selling point to grievance: FREE+ 4.4 / 1.5 / 6.6 / 6.0 / 1.9%; CAP 0 / 0 / 0 / 1.2 / 26.9%; in E3–E4 free tier was an acquisition asset reviewers advertised ('It's FREE and so pretty honestly just get all there apps'; 'Thanks Not Boring Team, for making your apps free to use'); the single clearest before/after
- **This app does:** unlimited free → capped
- **User reaction:** mixed
- **Magnitude:** | E1 | E2 | E3 | E4 | E5 ; FREE+ (free tier praised) | 4.4% | 1.5% | 6.6% | 6.0% | 1.9% ; CAP (free limit as friction) | 0.0% | 0.0% | 0.0% | 1.2% | 26.9%
- **Direction for us:** product-rule · **Report confidence:** high-priority, direction reversed · **Generalisable:** yes
- **Review IDs:** `11190741469`, `11734980268`, `11499453960`
- **Canonical:** C001 Never move a free feature behind the paywall; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R36-177 — Usability solved over time, residual cases severe: usability E1 21.9 → 8.8 → 12.0 → 12.0 → 6.5%; UX- 14.9 → 1.5 → 4.8 → 6.0 → 2.8; onboarding 7.9 → 1.5 → 1.2 → 2.4 → 1.9; delete/rename 3.5 → 0 → 3.0 → 1.2 → 0; landscape + iPad 6.1 → 0 → 1.8 → 3.6 → 1.9 — nine reviewers in E1's ten months could not work out how to use it; onboarding complaints still average 1.81, e.g. a Feb 2026 first run failing at the first screen because the schedule picker overflows the display — first-run comprehension is now a device / OS edge case, not a design problem

- **Where:** §8.4 Trend 3 — Usability was the original problem and it was largely solved (verbatim table): U_USABILITY 21.9 / 8.8 / 12.0 / 12.0 / 6.5; UX- 14.9 / 1.5 / 4.8 / 6.0 / 2.8; ONBOARD- 7.9 / 1.5 / 1.2 / 2.4 / 1.9; DELETE- 3.5 / 0 / 3.0 / 1.2 / 0; landscape+iPad 6.1 / 0 / 1.8 / 3.6 / 1.9; residual ONBOARD- still mean 1.81 — first-run fails at the first screen because the schedule picker overflows (Feb 2026)
- **This app does:** UI iterated
- **User reaction:** complaint
- **Magnitude:** | E1 | E2 | E3 | E4 | E5 ; U_USABILITY | 21.9% | 8.8% | 12.0% | 12.0% | 6.5% ; UX- | 14.9% | 1.5% | 4.8% | 6.0% | 2.8% ; ONBOARD- | 7.9% | 1.5% | 1.2% | 2.4% | 1.9% ; DELETE- | 3.5% | 0.0% | 3.0% | 1.2% | 0.0% ; R_LANDSCAPE + R_IPAD | 6.1% | 0.0% | 1.8% | 3.6% | 1.9%
- **Direction for us:** must-have · **Report confidence:** very strong, improving · **Generalisable:** yes
- **Review IDs:** `13701793930`
- **Canonical:** C075 Skippable, replayable onboarding tour; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R36-178 — A launch upsell never spikes and never stops: POPUP by era 2.6 → 2.9 → 4.8 → 6.0 → 5.6%, peaking at 15.0% of 2026 H2 and 9.5% of 2025 H2 (mean 2.67), spanning 2022 to 2026; it is the only negative theme regularly in 5★ reviews (4 of 24) — people who like the app and are worn down: 5★ titled 'Unusable'; 'no problems except for the constant upgrade adds'; 'For an app that prides itself on design quality, this is really jarring and irritating' — a frequency cap is the lowest-cost, lowest-risk intervention in the report

- **Where:** §8.5 Trend 4 — The upsell screen is a slow, persistent leak: POPUP 2.6 / 2.9 / 4.8 / 6.0 / 5.6% by era; peaks 15.0% in 2026 H2, 9.5% in 2025 H2; mean 2.67; spans 2022–2026; only negative theme regularly in 5★ (4 of 24) — 'no problems except for the constant upgrade adds'; 'For an app that prides itself on design quality, this is really jarring and irritating'; a frequency cap is the lowest-cost, lowest-risk intervention
- **This app does:** full-page upsell every launch
- **User reaction:** complaint
- **Magnitude:** 2.6 → 5.6% by era; 15.0% 2026 H2; mean 2.67; 4 of 24 at 5★
- **Direction for us:** dont · **Report confidence:** very strong, worsening · **Generalisable:** yes
- **Review IDs:** `8337984672`, `14465422602`, `11870684099`, `13064092562`, `14306277069`, `9800669659`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R36-179 — Localisation demand stopped after mid-2022: R_LANG E1 7.0% (8 reviews) → 0.0 → 0.6% (1) → 0.0 → 0.0; six of the eight E1 requests Chinese-market, all May–June 2022, plus MX 1★; the only later one pt-BR Feb 2024 — consistent with localisation shipping in mid/late 2022 (not confirmed); China's mean stays low on price and sync, not language

- **Where:** §8.6 Trend 5 — Localisation demand arrived early, concentrated, and then stopped: R_LANG 7.0% (E1, 8) → 0.0 → 0.6 (1) → 0.0 → 0.0; six Chinese-market May–June 2022 + MX 1★; later only pt-BR Feb 2024; consistent with localisation shipping mid/late 2022, cannot confirm; China stays 3.605 on price and sync
- **This app does:** probably localised 2022
- **User reaction:** complaint
- **Magnitude:** 7.0 → 0.0 → 0.6 → 0.0 → 0.0
- **Direction for us:** build-free · **Report confidence:** meaningful in E1 only · **Generalisable:** yes
- **Review IDs:** `8660174556`, `8772660358`, `8787860020`, `8804471876`, `8815511952`, `8744602982`, `8778158271`, `8771578171`, `10911777454`
- **Canonical:** C027 Localise early — it unlocks revenue

### R36-180 — Requests rotate as the product moves: landscape / iPad peak E1 6.1% (probably addressed); localisation E1 7.0%; flexible schedules E1 2.6 → E3 1.8 → 0.0 in E4/E5 (probably addressed, none since Dec 2024); sync every era 7.0 / 8.8 / 7.2 / 6.0 / 2.8 — never addressed, the E5 dip is crowding-out by CAP (still asked Aug 2026); more / snoozable reminders cluster in E4 (4.8%); widget demand peaks E4 (3.6%) after the gate — now that widgets cost money people want them to do more; statistics are the newest rising request (E5 4.6%); beyond-60-days at E2 2.9% and E5 1.9% from long-tenure users

- **Where:** §8.7 Trend 6 — Requests rotated as the platform moved (verbatim table): landscape/iPad E1 6.1% probably addressed; R_LANG E1; R_FLEX E1 2.6 → E3 1.8 → 0.0 E4/E5 probably addressed; R_SYNC every era never addressed (E5 dip is crowding-out by CAP); R_NOTIF E4 4.8%; widget demand E4 3.6% post-gate ('now that widgets cost money, people want them to do more'); R_STATS E5 4.6% newest rising; R_BEYOND60 E2 2.9% and E5 1.9%
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Request | Peak era | Reading ; R_LANDSCAPE / R_IPAD | E1 (6.1%) | An early-2022 iPad-layout complaint that fades — probably addressed ; R_LANG | E1 (7.0%) | See 8.6 ; R_FLEX (flexible schedules) | E1 (2.6%) → E3 (1.8%) → 0.0% in E4/E5 | Probably addressed; nobody has asked since Dec 2024 ; R_SYNC | Every era, 7.0 / 8.8 / 7.2 / 6.0 / 2.8% | Never addressed. The E5 dip is crowding-out by CAP, not resolution — 14450598724 still asks in Aug 2026 ; R_NOTIF (more/snoozable reminders) | E4 (4.8%) | A 2025 cluster: 12102232868, 12759861353, 13279758046, 13348454083 ; U_WIDGET_DEMAND | E4 (3.6%) | Post-gate: now that widgets cost money, people want them to do more ; R_STATS | E5 (4.6%) | Newest rising request: 13608349245, 13902720788, 13945742048, 13948551648, 13572606322 ; R_BEYOND60 | E2 (2.9%) and E5 (1.9%) | The 60-day ceiling is raised by long-tenure users at both ends
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14450598724`, `12102232868`, `12759861353`, `13279758046`, `13348454083`, `13608349245`, `13902720788`, `13945742048`, `13948551648`, `13572606322`
- **Canonical:** — (nuance register)

## Positioning

### R36-001 — (Not Boring) Habits (App Store ID 1593891243, 'Science-backed habit tracker') by Not Boring Software LLC — reviewers call the maker 'Andy' / 'Andy Works' / 'the Not Boring team'; bundle com.andyworks.streaks (began as a streak app, no rename mentioned); free download with a 'Not Boring' membership subscription — tiers named Believer (信赖者), Plus, Super, S2 — ~$15/£15/€18 a year for Habits alone and ~$30/year for the 5-app suite, rising to $59–$70 by 2026 and ¥398 one-time in China; gated: skins/themes, widgets (from Oct 2023) and, from ~Dec 2025, habits beyond the free limit (unlimited → 2 → 1); no ads; data local to the device, no account, no iCloud sync; Apple Design Award winner

- **Where:** header lines 1-10
- **This app does:** developer Not Boring Software LLC; bundle com.andyworks.streaks; extracted 8 Sep 2026; analysed 11 Sep 2026; store rank 36
- **User reaction:** mixed
- **Magnitude:** 540 written reviews · 60 storefronts · 15 Dec 2021 → 4 Sep 2026; mean 4.0389; US 252 only storefront ≥ 50 (gb 42, cn 38, in 32)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Side effects:** part of a 4–5 app suite (Habits, Calculator, Timer/Countdown, Weather, Calendar, later !Camera)
- **Review IDs:** `8202026507`, `9715331511`, `12800428077`, `11734980268`, `8969889060`, `9076528710`, `13572606322`, `12339917492`, `11980712489`, `10713355484`, `14174554457`, `14465422602`, `14450598724`
- **Canonical:** C060 Cross-sell an app family on brand trust

### R36-059 — 'Best' claims 34 (6.30%, mean 4.65)

- **Where:** §3.1 theme table BEST
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 34 (6.30%), 4.65
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R36-068 — 'Science-backed' framing praised 7 (1.30%, mean 4.86); doubted 2 (0.37%, mean 1.50)

- **Where:** §3.1 theme table SCIENCE+ / SCIENCE-
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** SCIENCE+ 7, 4.86; SCIENCE- 2, 1.50
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R36-087 — Wins on feel, loses on price model: competitors named (COMP 40, 7.41%, mean 4.05) — Streaks, Atoms / James Clear, Me+, Onrise, Dayrise, Habitica, Things, Fantastical, Notion, Habit Grid, Apple Reminders, and a generic 'Habit' app with lifetime pricing; one review names both the win on feel and the loss on price model

- **Where:** §3.4 #8 A credible competitive position — BEST 34, COMP 40 (7.41%, 4.05); competitors Streaks, Atoms / James Clear, Me+, Onrise, Dayrise, Habitica, Things, Fantastical, Notion, Habit Grid, Apple Reminders, a generic 'Habit' app with lifetime pricing; wins on feel, loses on price model
- **This app does:** subscription vs one-time rivals
- **User reaction:** mixed
- **Magnitude:** COMP 40 (7.41%), 4.05; BEST 34 (6.30%)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9647917670`, `11697727372`, `11803536707`, `11125368439`, `10917221776`, `13689787553`, `13902720788`, `10203658744`, `12830821232`, `9461859645`
- **Canonical:** C005 Know which competitors buyers compare against

### R36-151 — Subscription payers leave for one-time-priced rivals: 'after this month, I'll be using something like Streaks' (a payer); a UK student names Streaks at £5.99 one-time

- **Where:** §6.5 'after this month, I'll be using something like Streaks' — a payer switching to a flat-fee app
- **This app does:** subscription
- **User reaction:** churn
- **Magnitude:** 2 reviews
- **Direction for us:** build-paid · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `9647917670`, `11803536707`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C005 Know which competitors buyers compare against

### R36-184 — Feel is a moat and almost nobody builds it: 57 reviews praise haptics, sound and music, several say it is why they kept this app after abandoning others; competitors are described as 'gunk', 'too busy', 'overwhelming', 'spam'

- **Where:** Part 9 #1
- **This app does:** competitor lesson
- **User reaction:** mixed
- **Magnitude:** competitor lesson (see body)
- **Direction for us:** build-free · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `8139278712`, `13678372106`, `12957083253`, `8868694307`, `12189025964`, `12948428968`, `13967987039`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C069 Check-off sound and haptic

### R36-185 — 'No streak shame' is an unclaimed positioning: 11 praise it and one (20 votes) explains why streak-reset mechanics make people delete habit apps; 7 ask for streaks — so optional, not absent

- **Where:** Part 9 #2
- **This app does:** competitor lesson
- **User reaction:** mixed
- **Magnitude:** competitor lesson (see body)
- **Direction for us:** product-rule · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `9122428340`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

## Anti-patterns

### R36-014 — Ship free, build the habit, then gate what people already use — run twice (widgets Oct 2023, habits Dec 2025) and both times it produced the corpus's worst-rated reviews and a half-year rating trough (2023 H2 3.56; 2026 H1 3.56)

- **Where:** Executive summary #3 — Interpretation: a repeated pattern — ship free, build the habit, then gate what people already use — produces the corpus's worst-rated reviews both times
- **This app does:** two retractions
- **User reaction:** 1★-burst
- **Magnitude:** WIDGETGATE 2.64; CAP 2.30; REGRESS 1.95
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall

### R36-049 — Selling skins separately on top of a paid membership reads as double-charging: '$15 for permission to buy a $10 skin. Scam!'; '$70 / year if you want any decent skins'

- **Where:** §2.2 Paid skins sold on top of a membership — '$15 for permission to buy a $10 skin'; '$70 / year if you want any decent skins'
- **This app does:** membership + separately priced skins
- **User reaction:** complaint
- **Magnitude:** 2 quotes
- **Direction for us:** dont · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `9271651117`, `9504356434`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C167 Cosmetic and colour variety as the paid layer

### R36-117 — Monetising a surface instead of improving it: 'instead of taking advantage of the iOS 17 update with interactive widgets, they preferred to make that option paid' (cl, 2★, Feb 2025)

- **Where:** §4.2 An interactive widget was asked for instead and not delivered — 'instead of taking advantage of the iOS 17 update with interactive widgets, they preferred to make that option paid'
- **This app does:** widgets paywalled, not made interactive
- **User reaction:** complaint
- **Magnitude:** n=1 (2★); R_IWIDGET 4
- **Direction for us:** dont · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `12326839720`
- **Canonical:** C001 Never move a free feature behind the paywall; C023 Interactive widget check-off

## Things not to do

### R36-019 — Do not show a subscribe screen on every launch: launch upsell complaints 24 (4.44%, mean 2.67), a steady drumbeat across every era — 'everytime i open the app its asking me to subscribe. i said no already, please respect that'; 'Can't use the app on my iPhone 13 mini because of a freaking pop up' (the pop-up could not be dismissed on a small screen)

- **Where:** Executive summary #4 — launch upsell screen 24 (4.44%), mean 2.67 — 'everytime i open the app its asking me to subscribe. i said no already, please respect that'; 'Can't use the app on my iPhone 13 mini because of a freaking pop up'
- **This app does:** full-page upsell on launch
- **User reaction:** complaint
- **Magnitude:** 24 (4.44%), mean 2.67
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12200644346`, `11870684099`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C137 Show the paywall at the moment of need, not on app open; C145 Every promotional or onboarding modal must be dismissible on the smallest screen

### R36-046 — Do not let a free feature silently lock after a week: widgets appeared to lock after a week for free users in Jun 2022 (1★) — a trial nobody was told was a trial

- **Where:** §2.2 Widgets appear to lock after a week for free users (Jun 2022, 1★); a 7-day trial mentioned once
- **This app does:** widgets lock after 7 days
- **User reaction:** 1★-burst
- **Magnitude:** n=1 (1★); 7-day trial mentioned once
- **Direction for us:** dont · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `8797076855`, `8804881126`
- **Canonical:** C009 Basic widgets, icons and colours are free; C104 Never ship a paywall or feature-removal change silently

### R36-113 — An unexplained cap is reported as a bug: 'App is extremely bugged. I cannot add a second habit' (de, 1★, 2026)

- **Where:** §4.1 One 2026 reviewer mistakes the cap for a bug — 'App is extremely bugged. I cannot add a second habit'
- **This app does:** silent cap
- **User reaction:** 1★-burst
- **Magnitude:** n=1 (1★)
- **Direction for us:** dont · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `14235507906`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R36-194 — Cap the upsell screen at once per week, and never before the first habit is created — the cheapest single change in the report

- **Where:** §10.1 action 3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** POPUP 24 (2.67), 15.0% of 2026 H2; 4 of 24 at 5★
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11870684099`, `13064092562`, `14306277069`, `9800669659`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C137 Show the paywall at the moment of need, not on app open

## Things to do

### R36-029 — Cheapest wins in evidence order: (1) restore a usable free tier (3+ habits; 'three would be reasonable'); (2) never retract what is already in use — grandfather existing users; (3) ship iCloud sync (34 requests over 4.7 years, 26.5% of payers, at least two non-renewals); (4) sell a one-time / lifetime unlock alongside the subscription (24 willing buyers, mean 3.42); (5) disclose the limit on the store page and cap the upsell to once (DISCLOSE 6 mean 1.67; POPUP 24 mean 2.67); (6) finish habit navigation — all-habits overview and reliable swipe (27, mean 3.56); (7) then Apple Watch (9), interactive widget (4), multiple completions per day (5), progression beyond 60 days (6), statistics (10)

- **Where:** Executive summary #10 — cheapest wins, in evidence order (1–7)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as stated
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `14109551956`, `14236390341`, `12556296093`, `10771936163`, `9745264915`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C030 Sync must work — and prove it; C093 No upsell nagging without a 'never ask again' option; C181 If the app is paid-only, say so in the subtitle and first screenshot; C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R36-075 — Disclose the paywall on the store page: DISCLOSE 6 reviews, mean 1.67, 5 of 6 1–2★ — 'It's not free. You can't do more than 1 habit without paying'; 'Si c'est payant mettez le là c'est caché après avoir téléchargé' ('if it's paid put it there, it's hidden until after downloading')

- **Where:** §3.2 DISCLOSE 6, mean 1.67, 5 of 6 1–2★ — 'It's not free. You can't do more than 1 habit without paying'; 'Si c'est payant mettez le là c'est caché après avoir téléchargé'
- **This app does:** cap not disclosed before download
- **User reaction:** 1★-burst
- **Magnitude:** 6 (1.11%), mean 1.67
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13971171093`, `14197628877`
- **Canonical:** C181 If the app is paid-only, say so in the subtitle and first screenshot; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R36-085 — Give fine-tuned control over notifications and send few: NOTIF+ 12 (2.22%, mean 4.67) framed as why they left other apps — 'fine-tuned control over the notifications you receive — probably the #1 reason I've deleted other habit apps was that they spammed me with a billion distracting notifications'

- **Where:** §3.4 #5 Notification restraint NOTIF+ 12 (2.22%), mean 4.67 — fine-tuned control over notifications; 'spammed me with a billion distracting notifications'
- **This app does:** restrained, configurable notifications
- **User reaction:** praise
- **Magnitude:** 12 (2.22%), mean 4.67
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13967987039`
- **Canonical:** C253 Notification restraint — few, finely controllable notifications keep the users that spammy rivals lose

### R36-103 — Screenshots set feature expectations: a reviewer expected a built-in timer because a store screenshot showed a habit named 'Run 15 minutes' — a store-listing clarity problem, not a missing feature

- **Where:** §3.5 Misunderstandings — a store-listing clarity problem: expected a built-in timer because a screenshot showed a habit named 'Run 15 minutes'
- **This app does:** example habit name in screenshot
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** do · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `12167197066`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R36-186 — Notification restraint wins switchers: notification spam named as the #1 reason for deleting other habit apps

- **Where:** Part 9 #3
- **This app does:** competitor lesson
- **User reaction:** mixed
- **Magnitude:** competitor lesson (see body)
- **Direction for us:** do · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `13967987039`
- **Canonical:** C253 Notification restraint — few, finely controllable notifications keep the users that spammy rivals lose

### R36-195 — State the free-tier limit on the store page and in the first run — converts day-one 1★ protests into informed non-installs

- **Where:** §10.1 action 4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** DISCLOSE 6 (1.67, 4 of 6 1★)
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13971171093`, `14197628877`, `8337984672`, `8804881126`, `11110698797`, `12167197066`
- **Canonical:** C181 If the app is paid-only, say so in the subtitle and first screenshot; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R36-196 — Fix the store listing's implied timer (a screenshot habit named 'Run 15 minutes') — a one-line fix that removes a refund-shaped complaint

- **Where:** §10.1 action 5
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** n=1 (2★)
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12167197066`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Contradictions

### R36-048 — Plan availability contradicts: monthly-and-yearly only and no one-time option vs a ¥398 one-time price in China in Aug 2026 — either a lifetime tier appeared late or pricing differs by storefront; unresolved

- **Where:** §2.2 Contradiction — monthly-and-yearly only, no one-time option vs ¥398 one-time in China Aug 2026; either lifetime appeared late or pricing differs by storefront
- **This app does:** plans differ by storefront/time
- **User reaction:** mixed
- **Magnitude:** 5 reviews
- **Direction for us:** research · **Report confidence:** unresolved · **Generalisable:** yes
- **Review IDs:** `11178506784`, `11802063933`, `10713355484`, `11016580901`, `14450598724`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R36-074 — The same 3D, musical style that wins most users repels a minority completely: GRAPHICS- 6 reviews, mean 1.17, all 1–2★ — 'loaded with useless graphics and an annoying piano soundtrack' (a payer); 'Leider viel zu verspielt und nicht alltagstauglich' ('far too playful and not suitable for everyday use')

- **Where:** §3.2 GRAPHICS- 6, mean 1.17, 6 of 6 1–2★ — the style itself is the objection: 'loaded with useless graphics and an annoying piano soundtrack' (a payer); 'Leider viel zu verspielt und nicht alltagstauglich'
- **This app does:** heavy visual/sound style
- **User reaction:** churn
- **Magnitude:** 6, mean 1.17, 6/6 1–2★
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** taste split: design praise 151 vs style rejection 6
- **Review IDs:** `11064158160`, `13689787553`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C057 Offer a non-pastel / premium design option

### R36-093 — Some ask for streaks, reps or loss-on-break 7 (1.30%, mean 3.71) — including the 45-vote review — while NOSHAME praises the absence of streak punishment

- **Where:** §3.5 R_STREAK
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 7 (1.30%), 3.71 vs NOSHAME 11
- **Direction for us:** undecided · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `9750074711`, `10358584157`, `10662024022`, `12097852488`, `12544966110`, `13162761819`, `13967987039`
- **Canonical:** C024 Streaks / gamification; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R36-106 — Some question the game mechanic itself: 'focusing the entire app experience on building a 3D model (how does this help?)'; 'The UI is more about playing with random shapes then actually figuring out your habits!!'

- **Where:** §3.6 Questioning the mechanic outright — 'focusing the entire app experience on building a 3D model (how does this help?)'; 'more about playing with random shapes then actually figuring out your habits!!'
- **This app does:** 3D monument central
- **User reaction:** complaint
- **Magnitude:** 2 quotes (GAME- 4, mean 1.75)
- **Direction for us:** undecided · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `8182905997`, `9128391997`
- **Canonical:** C024 Streaks / gamification

### R36-139 — Payers rate below non-payers — the opposite of the usual pattern in this project: payers 34, mean 3.794 (5★ 50.0%, 1–2★ 23.5%) vs corpus 4.039 (60.6% / 17.6%), FREE+ 24 at 4.88 (87.5% 5★, zero 1–2★), PRICE+ 20 at 4.80; payers sit 0.245★ below average and nearly a full star below free-tier praisers; payer share 7.0% (E1) → 8.8 → 5.4 → 8.4 → 3.7% (E5, 4 of 108) — paying moves you from the best surface (a beautiful free tool that asks nothing) onto the worst (no sync, entitlements that don't travel, billing edge cases, and £15/yr that buys little more than skins); the free tier is the marketing, the paid tier is where disappointments live

- **Where:** §6.2 The headline: payers are less satisfied than non-payers (verbatim table) — payers 34 mean 3.794, 5★ 50.0%, 1–2★ 23.5%; corpus 4.039; FREE+ 24 4.88, 0 1–2★; PRICE+ 20 4.80; payer share 7.0% E1 → 8.8 → 5.4 → 8.4 → 3.7% E5 (4 of 108); opposite of the usual pattern
- **This app does:** subscription buys skins, widgets, habits
- **User reaction:** complaint
- **Magnitude:** Group | n | Mean | 5★ | 1–2★ ; Explicit payers | 34 | 3.794 | 17 (50.0%) | 8 (23.5%) ; Whole corpus | 540 | 4.039 | 327 (60.6%) | 95 (17.6%) ; Reviewers praising the free tier (FREE+) | 24 | 4.88 | 21 (87.5%) | 0 ; Reviewers defending the price (PRICE+) | 20 | 4.80 | 17 (85.0%) | 0
- **Direction for us:** product-rule · **Report confidence:** segment (interpretation labelled) · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

## Data caveats and method

### R36-002 — Method: all 540 reviews read in full in date order in 6 batches of 90, in every language (English, Chinese, German, French, Spanish, Portuguese, Italian, Turkish, Russian, Ukrainian, Arabic, Vietnamese, Czech, Slovak, Hungarian), hand-coded by one analyst against a 102-code codebook plus 10 unions; every review carries ≥1 code; 33-pattern multilingual recall sweep afterwards across 9 scripts, 11 corrections; signal bands <0.1 ignore · 0.1–0.5 weak · 0.5–1 emerging · 1–3 meaningful · 3–5 very strong · >5 high-priority; denominators 540, eras E1 114 · E2 68 · E3 167 · E4 83 · E5 108, US 252; one review is 0.19% (weak), three 0.56% (emerging), six 1.11% (meaningful) — treat n < 5 as anecdotal; no version field, release events inferred from review text and bracketed by first/last mention — only the Oct 2023 widget gate and Dec 2025 habit cap are stated as events (multiple storefronts, near-identical dates); payers self-selected (34, 6.30%), no conversion / renewal / refund rate; votes non-zero on 143, top 9750074711 (45, a 5★ feature request), 9122428340 (20), 8664069478 (17, CN login request), 8148224036 (16), 8757837312 (14), 8828400666 (12) — context only; is_edited on 5 (8852296975 revised upward; 13577681414 the 4★ cap complaint); reconciliation exact — 540 = unique IDs = sum of 60 by_country = manifest; ratings {5:327, 4:68, 3:50, 2:29, 1:66}; mean 4.0389; 0 empty fields; 0 duplicate text; written reviews only, self-selecting (delight moments or billing shocks); no version, cohort or revenue data; no external source consulted (so high-spend market membership not used)

- **Where:** How to read this; Seven warnings #2 #3 #5 #6 #7; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 540/540 coded once; 11 recall corrections; 143 voted; 5 edited
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `9750074711`, `9122428340`, `8664069478`, `8148224036`, `8757837312`, `8828400666`, `8632947214`, `8852296975`, `9849611173`, `12417677947`, `13577681414`
- **Canonical:** — (nuance register)

### R36-003 — This corpus is unusually negative for a habit tracker: 60.6% 5★ but 12.2% 1★ and 17.6% (95 reviews) 1–2★; mean 4.039 against a 4.5–4.6 norm across the other apps in the project — negative themes rest on real counts

- **Where:** Seven warnings #1 — unusually negative for a habit tracker: 60.6% 5★, 12.2% 1★, 17.6% (95) 1–2★; mean 4.039 vs 4.5–4.6 norm elsewhere in the set
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★ 60.6%; 1★ 12.2%; 1–2★ 95 (17.6%); mean 4.039 vs 4.5–4.6
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R36-004 — The free tier changed twice (unlimited → 2 → 1 habits) so 'the free tier' is not one thing: a 2024 reviewer praising 'unlimited habits' and a 2026 reviewer raging about 'ONE habit' are both accurate for their moment; cross-period free-tier comparisons must respect this

- **Where:** Seven warnings #4 — the free tier changed twice during the window, so 'the free tier' is not one thing ('unlimited habits' 2024 vs 'ONE habit' 2026)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** limitation · **Generalisable:** yes
- **Review IDs:** `11499453960`, `14183623397`
- **Canonical:** — (nuance register)

### R36-030 — Rating distribution, denominator 540

- **Where:** §1.6 By rating (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Stars | n | % of 540 | Cumulative ; 5★ | 327 | 60.56% | 60.56% ; 4★ | 68 | 12.59% | 73.15% ; 3★ | 50 | 9.26% | 82.41% ; 2★ | 29 | 5.37% | 87.78% ; 1★ | 66 | 12.22% | 100%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R36-033 — Storefronts: us 252 (4.095, eligible); gb 42 (3.690), cn 38 (3.605), in 32 (3.906), ca 21 (4.000), de 15 (3.667), fr 13 (4.308) as limited-evidence snapshots; au 9, br 7, tr 7, mx 6, it 5, ch 5, hk 5, at 5; 45 further storefronts 1–4 each

- **Where:** §1.6 By storefront (verbatim table) — us 252 (4.095) eligible; gb 42 (3.690), cn 38 (3.605), in 32 (3.906), ca 21 (4.000), de 15 (3.667), fr 13 (4.308) limited-evidence; au 9 · br 7 · tr 7 · mx 6 · it 5 · ch 5 · hk 5 · at 5; 45 further 1–4 each
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | Mean | Eligible for standalone analysis ; us | 252 | 4.095 | Yes (Part 7.2) ; gb | 42 | 3.690 | No — limited-evidence snapshot (7.4) ; cn | 38 | 3.605 | No — limited-evidence snapshot (7.4) ; in | 32 | 3.906 | No — limited-evidence snapshot (7.4) ; ca | 21 | 4.000 | No — limited-evidence snapshot (7.4) ; de | 15 | 3.667 | No — limited-evidence snapshot (7.4) ; fr | 13 | 4.308 | No — limited-evidence snapshot (7.4) ; au 9 · br 7 · tr 7 · mx 6 · it 5 · ch 5 · hk 5 · at 5 | ≤9 | — | No ; 45 further storefronts | 1–4 each | — | No
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R36-034 — The more someone writes, the more likely money is the subject: 86 short reviews (≤ 25 chars, 15.9%) average 4.198 while 376 substantive reviews (> 60 chars) average 3.939 and carry monetisation friction at 26.3%; median body 113 chars, longest 2,373 (a US feature-request essay)

- **Where:** §1.6 Length — median body 113 chars; longest 2,373 (a US feature-request essay); 86 (15.9%) ≤ 25 chars, mean 4.198; 376 substantive (> 60) mean 3.939 with friction 26.3% — the more someone writes, the more likely money is the subject
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** short 86 (15.9%) 4.198; substantive 376 3.939, friction 26.3%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `10662024022`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R36-035 — Feature inventory with gating as reviewers report it

- **Where:** §2.1 Feature inventory derived from reviews (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | What reviewers describe | Evidence | Gating as reviewers report it ; One-habit-at-a-time full-screen canvas | You see a single habit, not a list; a name in small text at the top switches between them | 8185571470, 10662024022, 13670415847 | Free ; Hold-to-check button with haptics + sound | "hold down a button … and get actual physical feedback"; "the marker that fills up" | 8139278712, 13678372106, 12145055029 | Free ; 60-day monument / structure build | A 3D object (mountain, iceberg, campsite, summit, sword, bridge, statue) assembles one piece per completed day, for 60 days | 9411396337, 10010716282, 10832733374, 13127746442 | Free ; Daily motivational text / quotes | A line of text per completion; reviewers call it "narrative progression" | 9464371564, 13596302845, 11085313395 | Free ; Reminders / notifications | Per-habit time reminder; widely praised for *restraint* | 9459762276, 13967987039, 12602575597 | Free ; Calendar / month / year history views | Swipe up from the check screen; a year grid | 8803885432, 11318979286, 11980712489, 13594356619 | Free ; Schedule by weekday | Choose which days of the week a habit runs | 9898093006, 13701793930 | Free ; Archive a habit | Referenced once, and it counts against the free cap | 13577681414 | Free ; Skins / themes / wallpapers | Default dark plus ~10 premium skins; non-dark skins are paid | 8777283339, 13670415847, 9504356434 | Paid (whole window) ; Home Screen widgets | Month calendar and progress widgets | 8983069441, 11562816267, 13462331422 | Free until ~Oct 2023, paid after ; More than N habits | Unlimited in the free tier until ~Dec 2025; then 2; then 1 | 11499453960, 11704920604 → 13594173870 → 13971171093 | Paid from ~Dec 2025 ; The 4–5 app "Not Boring" suite | Habits, Calculator, Timer/Countdown, Weather, Calendar, later !Camera | 9504356434, 9895154481, 13646358981, 11938623754 | Bundled in the membership
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R36-055 — Master theme table, denominator 540, with 5/4/3/2/1 split

- **Where:** §3.1 Complete ranked theme table (verbatim), 102 codes
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | Dir | n | % of 540 | Signal | Mean | 5/4/3/2/1 ; DESIGN | + | 151 | 27.96% | high-priority | 4.54 | 112/20/11/4/4 ; SIMPLE | + | 80 | 14.81% | high-priority | 4.75 | 66/9/4/1/0 ; GEN+ | + | 75 | 13.89% | high-priority | 4.93 | 70/5/0/0/0 ; GAME+ | + | 74 | 13.70% | high-priority | 4.69 | 59/10/3/1/1 ; OUTCOME | + | 58 | 10.74% | high-priority | 4.95 | 55/3/0/0/0 ; HAPTIC+ | + | 57 | 10.56% | high-priority | 4.61 | 44/7/3/3/0 ; MOTIV | + | 47 | 8.70% | high-priority | 4.83 | 41/4/2/0/0 ; COMP | ± | 40 | 7.41% | high-priority | 4.05 | 27/3/1/3/6 ; PRICE- | − | 36 | 6.67% | high-priority | 2.31 | 1/5/10/8/12 ; SUB- | − | 35 | 6.48% | high-priority | 2.60 | 3/9/6/5/12 ; BEST | + | 34 | 6.30% | high-priority | 4.65 | 27/4/2/0/1 ; PAYER | + | 34 | 6.30% | high-priority | 3.79 | 17/6/3/3/5 ; R_SYNC | ± | 34 | 6.30% | high-priority | 3.59 | 10/11/7/1/5 ; SUITE+ | + | 34 | 6.30% | high-priority | 4.41 | 26/3/1/1/3 ; UX- | − | 34 | 6.30% | high-priority | 2.21 | 4/1/7/8/14 ; PAYWALL | − | 31 | 5.74% | high-priority | 2.77 | 1/10/7/7/6 ; CAP | − | 30 | 5.56% | high-priority | 2.30 | 1/6/6/5/12 ; DEV+ | + | 27 | 5.00% | very strong | 4.81 | 24/2/0/1/0 ; FREE+ | + | 24 | 4.44% | very strong | 4.88 | 21/3/0/0/0 ; ONETIME | ± | 24 | 4.44% | very strong | 3.42 | 3/10/6/4/1 ; POPUP | − | 24 | 4.44% | very strong | 2.67 | 4/4/4/4/8 ; USEFUL | + | 21 | 3.89% | very strong | 4.90 | 19/2/0/0/0 ; VALUE- | − | 21 | 3.89% | very strong | 2.24 | 0/3/6/5/7 ; CHURN | − | 20 | 3.70% | very strong | 2.05 | 1/3/3/2/11 ; PRICE+ | + | 20 | 3.70% | very strong | 4.80 | 17/2/1/0/0 ; SWITCH- | − | 20 | 3.70% | very strong | 3.90 | 6/8/5/0/1 ; REGRESS | − | 19 | 3.52% | very strong | 1.95 | 0/2/4/4/9 ; ONBOARD- | − | 16 | 2.96% | meaningful | 1.81 | 1/0/3/3/9 ; WIDGETGATE | − | 14 | 2.59% | meaningful | 2.64 | 1/4/2/3/4 ; QUOTES+ | + | 13 | 2.41% | meaningful | 5.00 | 13/0/0/0/0 ; JUNK | ± | 12 | 2.22% | meaningful | 4.83 | 11/0/1/0/0 ; NOLIST | ± | 12 | 2.22% | meaningful | 3.17 | 3/1/5/1/2 ; NOTIF+ | + | 12 | 2.22% | meaningful | 4.67 | 9/2/1/0/0 ; NOSHAME | + | 11 | 2.04% | meaningful | 4.55 | 9/1/0/0/1 ; BUYIF | + | 10 | 1.85% | meaningful | 4.70 | 7/3/0/0/0 ; DELETE- | − | 10 | 1.85% | meaningful | 3.00 | 2/2/2/2/2 ; R_STATS | ± | 10 | 1.85% | meaningful | 3.90 | 5/3/0/0/2 ; MISRATE | ± | 9 | 1.67% | meaningful | 4.44 | 7/0/1/1/0 ; R_LANG | ± | 9 | 1.67% | meaningful | 3.78 | 5/1/1/0/2 ; R_WATCH | ± | 9 | 1.67% | meaningful | 4.11 | 5/2/1/0/1 ; SUITE- | − | 9 | 1.67% | meaningful | 3.22 | 3/1/2/1/2 ; BORING- | − | 8 | 1.48% | meaningful | 2.50 | 1/0/3/2/2 ; BUG | − | 8 | 1.48% | meaningful | 2.88 | 3/0/1/1/3 ; VIZ+ | + | 8 | 1.48% | meaningful | 4.62 | 7/0/0/1/0 ; R_FLEX | ± | 7 | 1.30% | meaningful | 4.00 | 3/1/3/0/0 ; R_NOTIF | ± | 7 | 1.30% | meaningful | 3.86 | 2/3/1/1/0 ; R_STREAK | ± | 7 | 1.30% | meaningful | 3.71 | 2/2/2/1/0 ; SCIENCE+ | + | 7 | 1.30% | meaningful | 4.86 | 6/1/0/0/0 ; TRIAL | − | 7 | 1.30% | meaningful | 2.43 | 1/0/2/2/2 ; WIDGET+ | + | 7 | 1.30% | meaningful | 4.29 | 4/1/2/0/0 ; DISCLOSE | − | 6 | 1.11% | meaningful | 1.67 | 0/1/0/1/4 ; GRAPHICS- | − | 6 | 1.11% | meaningful | 1.17 | 0/0/0/1/5 ; NOADS | ± | 6 | 1.11% | meaningful | 4.33 | 3/2/1/0/0 ; REACH- | − | 6 | 1.11% | meaningful | 4.17 | 2/3/1/0/0 ; R_BEYOND60 | ± | 6 | 1.11% | meaningful | 4.00 | 3/2/0/0/1 ; R_WIDGET | ± | 6 | 1.11% | meaningful | 3.67 | 2/2/1/0/1 ; UIBUG | − | 6 | 1.11% | meaningful | 3.67 | 2/2/1/0/1 ; AFFORD | − | 5 | 0.93% | emerging | 2.20 | 0/1/1/1/2 ; GEN- | − | 5 | 0.93% | emerging | 1.20 | 0/0/0/1/4 ; R_ACCOUNT | ± | 5 | 0.93% | emerging | 3.00 | 1/2/0/0/2 ; R_LANDSCAPE | ± | 5 | 0.93% | emerging | 4.40 | 2/3/0/0/0 ; R_MULTI | ± | 5 | 0.93% | emerging | 3.60 | 0/3/2/0/0 ; AWARD | + | 4 | 0.74% | emerging | 3.25 | 2/0/0/1/1 ; GAME- | − | 4 | 0.74% | emerging | 1.75 | 0/0/1/1/2 ; MSG- | − | 4 | 0.74% | emerging | 4.00 | 2/0/2/0/0 ; R_IPAD | ± | 4 | 0.74% | emerging | 4.00 | 1/2/1/0/0 ; R_IWIDGET | ± | 4 | 0.74% | emerging | 3.75 | 2/0/1/1/0 ; R_TIMER | ± | 4 | 0.74% | emerging | 2.50 | 0/0/2/2/0 ; BILLING | − | 3 | 0.56% | emerging | 1.00 | 0/0/0/0/3 ; CONTRAST- | − | 3 | 0.56% | emerging | 2.67 | 0/1/1/0/1 ; DATALOSS | − | 3 | 0.56% | emerging | 1.67 | 0/0/1/0/2 ; KIDS | + | 3 | 0.56% | emerging | 4.67 | 2/1/0/0/0 ; NAMELEN | − | 3 | 0.56% | emerging | 3.33 | 1/0/1/1/0 ; R_HEALTH | ± | 3 | 0.56% | emerging | 3.00 | 1/0/1/0/1 ; R_NOTES | ± | 3 | 0.56% | emerging | 4.00 | 1/1/1/0/0 ; SCHEDDAY- | − | 3 | 0.56% | emerging | 4.33 | 1/2/0/0/0 ; WIDGETBUG | − | 3 | 0.56% | emerging | 3.00 | 0/1/1/1/0 ; ADHD | + | 2 | 0.37% | weak | 5.00 | 2/0/0/0/0 ; ENT | − | 2 | 0.37% | weak | 3.50 | 0/1/1/0/0 ; FLEX+ | + | 2 | 0.37% | weak | 5.00 | 2/0/0/0/0 ; MOTIV- | − | 2 | 0.37% | weak | 3.00 | 0/1/0/1/0 ; NOTIF- | − | 2 | 0.37% | weak | 1.50 | 0/0/0/1/1 ; ONBOARD+ | + | 2 | 0.37% | weak | 5.00 | 2/0/0/0/0 ; PRIVACY+ | + | 2 | 0.37% | weak | 4.00 | 1/0/1/0/0 ; REGIONAL | − | 2 | 0.37% | weak | 2.00 | 0/0/1/0/1 ; R_ORG | ± | 2 | 0.37% | weak | 4.00 | 1/0/1/0/0 ; SCIENCE- | − | 2 | 0.37% | weak | 1.50 | 0/0/0/1/1 ; SOUND- | − | 2 | 0.37% | weak | 2.50 | 0/0/1/1/0 ; SUPPORT- | − | 2 | 0.37% | weak | 2.00 | 0/0/1/0/1 ; UPDATE+ | + | 2 | 0.37% | weak | 5.00 | 2/0/0/0/0 ; WIDGET- | − | 2 | 0.37% | weak | 4.00 | 1/0/1/0/0 ; ACCESS- | − | 1 | 0.19% | weak | 3.00 | 0/0/1/0/0 ; CRASH | − | 1 | 0.19% | weak | 1.00 | 0/0/0/0/1 ; LOCKIN | − | 1 | 0.19% | weak | 1.00 | 0/0/0/0/1 ; MISPLACED | ± | 1 | 0.19% | weak | 5.00 | 1/0/0/0/0 ; REVIEWDOUBT | ± | 1 | 0.19% | weak | 2.00 | 0/0/0/1/0 ; R_ADVICE | ± | 1 | 0.19% | weak | 3.00 | 0/0/1/0/0 ; R_MUSIC | ± | 1 | 0.19% | weak | 5.00 | 1/0/0/0/0 ; R_QUIT | ± | 1 | 0.19% | weak | 5.00 | 1/0/0/0/0 ; R_THEME | ± | 1 | 0.19% | weak | 4.00 | 0/1/0/0/0 ; R_TODO | ± | 1 | 0.19% | weak | 5.00 | 1/0/0/0/0 ; SUPPORT+ | + | 1 | 0.19% | weak | 5.00 | 1/0/0/0/0
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R36-057 — Generic positive 75 (13.89%, 4.93); generic negative 5 (0.93%, 1.20); junk 12 (2.22%, 4.83)

- **Where:** §3.1 theme table GEN+ / GEN- / JUNK
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** GEN+ 75; GEN- 5; JUNK 12
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R36-065 — Rating contradicts text 9 (1.67%, mean 4.44) — e.g. a 5★ calling the app 'Unusable' because of the launch pop-up; 'I didn't understand how to play??' at 5★

- **Where:** §3.1 theme table MISRATE
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 9 (1.67%), 4.44
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Review IDs:** `11870684099`, `8606455193`
- **Canonical:** — (nuance register)

### R36-072 — Weak rows (n ≤ 2): ADHD 2 (5.00); ENT 2 (3.50); FLEX+ 2 (5.00); MOTIV- 2 (3.00); NOTIF- 2 (1.50); ONBOARD+ 2 (5.00); PRIVACY+ 2 (4.00); REGIONAL 2 (2.00); R_ORG 2 (4.00); SCIENCE- 2 (1.50); SOUND- 2 (2.50); SUPPORT- 2 (2.00); UPDATE+ 2 (5.00); WIDGET- 2 (4.00); ACCESS- 1; CRASH 1 (1.00); LOCKIN 1 (1.00); MISPLACED 1; REVIEWDOUBT 1 (2.00); R_ADVICE 1; R_MUSIC 1; R_QUIT 1; R_THEME 1; R_TODO 1; SUPPORT+ 1

- **Where:** §3.1 theme table weak rows
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** ≤2 each (≤0.37%)
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R36-073 — Worst rating profile (n ≥ 5): GRAPHICS- 1.17 (6/6 1–2★), DISCLOSE 1.67, ONBOARD- 1.81, REGRESS 1.95, CHURN 2.05, UX- 2.21, VALUE- 2.24, CAP 2.30, PRICE- 2.31, AFFORD 2.20, BORING- 2.50, SUB- 2.60, WIDGETGATE 2.64, POPUP 2.67; mirror — QUOTES+ 13 mean 5.00 every one 5★; OUTCOME 58 4.95 zero below 4★; USEFUL 21 4.90; FREE+ 24 4.88; MOTIV 47 4.83; DEV+ 27 4.81; PRICE+ 20 4.80; SIMPLE 80 4.75 zero 1★; GAME+ 74 4.69

- **Where:** §3.2 The findings with the worst rating profile (verbatim table) and the mirror image
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | Mean | 1–2★ inside the theme | What it is ; GRAPHICS- | 6 | 1.17 | 6 of 6 | The style itself is the objection: "loaded with useless graphics and an annoying piano soundtrack" (11064158160, a payer); "Leider viel zu verspielt und nicht alltagstauglich" (13689787553) ; DISCLOSE | 6 | 1.67 | 5 of 6 | "It's not free. You can't do more than 1 habit without paying" (13971171093); "Si c'est payant mettez le là c'est caché après avoir téléchargé" (14197628877) ; ONBOARD- | 16 | 1.81 | 12 of 16 | "Is there no manual?" (8777347712); "I've wasted enough time trying to figure out how to use this silly app" (8252766990) ; REGRESS | 19 | 1.95 | 13 of 19 | Something free was taken away (2.2) ; CHURN | 20 | 2.05 | 13 of 20 | Explicitly deleted / switched / will not renew ; UX- | 34 | 2.21 | 22 of 34 | Navigation and interaction model ; VALUE- | 21 | 2.24 | 12 of 21 | "not worth the money" — zero 5★ ; CAP | 30 | 2.30 | 17 of 30 | The free habit limit ; PRICE- | 36 | 2.31 | 20 of 36 | The price level ; AFFORD | 5 | 2.20 | 3 of 5 | Explicit inability to pay (3.4) ; BORING- | 8 | 2.50 | 4 of 8 | The progression repeats identically for every habit ; SUB- | 35 | 2.60 | 17 of 35 | Subscriptions as a model ; WIDGETGATE | 14 | 2.64 | 7 of 14 | Widgets behind the paywall ; POPUP | 24 | 2.67 | 12 of 24 | The launch upsell screen
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `11064158160`, `13689787553`, `13971171093`, `14197628877`, `8777347712`, `8252766990`
- **Canonical:** — (nuance register)

### R36-088 — Requests for things that did not exist for that reviewer at that time

- **Where:** §3.5 Unmet needs table (verbatim) — U_UNMET 104 (19.26%, high-priority), mean 3.90
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Request | n | % of 540 | Signal | Mean | Representative IDs ; iCloud / cross-device sync | R_SYNC 34 | 6.30% | high-priority | 3.59 | 8210628761 8272945413 8748825608 8792588653 9978275210 10002968610 10674087870 10771936163 11301370583 11928826699 12931845361 13681998290 14450598724 ; Statistics / counts / charts | R_STATS 10 | 1.85% | meaningful | 3.90 | 9551247141 9567517609 10832733374 12155806021 12367187835 13608349245 13902720788 13945742048 13948551648 13572606322 ; Apple Watch app | R_WATCH 9 | 1.67% | meaningful | 4.11 | 9102170206 11311247837 11499453960 12118518558 12339917492 12438446023 12912075467 13556614835 13624027434 ; Localisation | R_LANG 9 | 1.67% | meaningful | 3.78 | 8660174556 8744602982 8771578171 8772660358 8778158271 8787860020 8804471876 8815511952 10911777454 ; Flexible schedules (every N days, N×/week or month) | R_FLEX 7 | 1.30% | meaningful | 4.00 | 8383787890 8774281298 8840784226 9898093006 10793530840 11280034510 12065767176 ; More / repeated / snoozable reminders | R_NOTIF 7 | 1.30% | meaningful | 3.86 | 9091830635 10358584157 12102232868 12759861353 13279758046 13348454083 13401743740 ; Streaks, reps, or loss-on-break | R_STREAK 7 | 1.30% | meaningful | 3.71 | 9750074711 10358584157 10662024022 12097852488 12544966110 13162761819 13967987039 ; Progression beyond 60 days / more journeys | R_BEYOND60 6 | 1.11% | meaningful | 4.00 | 10010716282 10043311417 10832733374 12997129235 13572306369 14471085224 ; Widget improvements (titles, colours, streak display) | R_WIDGET 6 | 1.11% | meaningful | 3.67 | 9098509320 11694919799 12544966110 13162761819 13462331422 13902720788 ; Account / login | R_ACCOUNT 5 | 0.93% | emerging | 3.00 | 8664069478 9076528710 11067586008 11301370583 13624027434 ; Landscape / rotation | R_LANDSCAPE 5 | 0.93% | emerging | 4.40 | 8622721501 8632947214 8757837312 8759804137 8782357563 ; Multiple completions per day / quantity | R_MULTI 5 | 0.93% | emerging | 3.60 | 11486217313 11523323203 12065767176 12367187835 13162761819 ; A real iPad layout | R_IPAD 4 | 0.74% | emerging | 4.00 | 8632947214 8727604239 8759804137 8782357563 ; Interactive / tappable widget | R_IWIDGET 4 | 0.74% | emerging | 3.75 | 10777840197 11523323203 11694919799 12326839720 ; Timer / pomodoro / duration | R_TIMER 4 | 0.74% | emerging | 2.50 | 9898093006 10358584157 11388263305 12167197066 ; Apple Health integration | R_HEALTH 3 | 0.56% | emerging | 3.00 | 10793530840 10964238644 13902720788 ; Notes on a habit | R_NOTES 3 | 0.56% | emerging | 4.00 | 9567517609 11980712489 9898093006 ; Grouping / organising habits | R_ORG 2 | 0.37% | weak | 4.00 | 12090899566 13061585954 ; Individually buyable / more free themes | R_THEME 1 | 0.19% | weak | 4.00 | 9567517609 ; To-do list | R_TODO 1 | 0.19% | weak | 5.00 | 8769392731 ; Habit-stacking / deeper method guidance | R_ADVICE 1 | 0.19% | weak | 3.00 | 12097852488 ; The music as a soundscape / on Spotify | R_MUSIC 1 | 0.19% | weak | 5.00 | 12323195954 ; A quit-a-habit inverse mode | R_QUIT 1 | 0.19% | weak | 5.00 | 14510762767
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `8272945413`, `8748825608`, `8792588653`, `9978275210`, `10002968610`, `10674087870`, `11301370583`, `11928826699`, `12931845361`, `9551247141`, `9567517609`, `12155806021`, `12367187835`, `13608349245`, `13945742048`
- **Canonical:** — (nuance register)

### R36-130 — 5★ band (327): core praise 78.3%, design 34.3%, generic 21.4%, simple 20.2%, game 18.0%, outcome 16.8%, haptic 13.5%, motivation 12.5%, best / comp 8.3% each, developer 7.3%, free praised 6.4%, useful 5.8%, payer 5.2%, price praised 5.2%, quotes 4.0%; only 10 of 327 (3.1%) contain monetisation friction — several love the app and hate the pop-up ('would be nice to not to ask every time'); 44 (13.5%) are generic-only ('Peak', 'AMAZING wowww', 'C bien') and 11 junk — the least informative band

- **Where:** §5.1 5★ — n = 327 (verbatim table); only 10 of 327 (3.1%) contain monetisation friction; 44 (13.5%) generic-only and 11 JUNK — the least informative band
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n in band | % of 327 ; Core praise | 256 | 78.3% ; DESIGN | 112 | 34.3% ; GEN+ (praise only) | 70 | 21.4% ; SIMPLE | 66 | 20.2% ; GAME+ | 59 | 18.0% ; OUTCOME | 55 | 16.8% ; HAPTIC+ | 44 | 13.5% ; MOTIV | 41 | 12.5% ; BEST / COMP | 27 / 27 | 8.3% / 8.3% ; DEV+ | 24 | 7.3% ; FREE+ | 21 | 6.4% ; USEFUL | 19 | 5.8% ; PAYER | 17 | 5.2% ; PRICE+ | 17 | 5.2% ; QUOTES+ | 13 | 4.0%
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** app-specific
- **Review IDs:** `11870684099`, `13064092562`
- **Canonical:** — (nuance register)

### R36-137 — Cross-band themes: sync 10 / 11 / 7 / 1 / 5 by star (mostly fans, occasionally a reason to quit); payer 17 at 5★ but 5 at 1★ and 3 at 2★ (paying does not predict satisfaction); pop-up 4 at 5★, 8 at 1★; haptic praise 3 of 57 at 2★; competitor comparison 27 at 5★ and 9 at 1–2★ ('Dayrise is better at this price range'; 'Ich bin jetzt zu Onrise gewechselt'); 9 star/text mismatches both ways (5★ 'Unusable', 5★ 'UX is on the low level', 5★ reporting a UI bug, 5★ complaining sync is missing, 2★ 'I love the app too', 3★ 'This is fabulous!') — star ratings are noisy per review; theme counts are the reliable signal

- **Where:** §5.6 Themes that cut across the rating line — R_SYNC 10/11/7/1/5; PAYER 17 at 5★ but 5 at 1★ and 3 at 2★; POPUP 4 at 5★, 8 at 1★; HAPTIC+ 3 of 57 at 2★; COMP 27 at 5★ and 9 at 1–2★ ('Dayrise is better at this price range'; 'Ich bin jetzt zu Onrise gewechselt'); MISRATE 9 both directions — star ratings noisy individually, theme counts reliable
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** report gives none beyond per-star splits
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13902720788`, `13689787553`, `11870684099`, `11280034510`, `13652246359`, `10498701164`, `14334631638`, `11125368439`
- **Canonical:** — (nuance register)

### R36-138 — Payer framing: 34 reviewers (6.30%) state first-person payment or membership in any language ('I bought a paid subscription'; 'I'm on the yearly subscription'; 'activated Believer'; 'I bough the Super membership'; 'Bought the 5 app package'; 'subscribed to plus'; 'Comprei no IPad'); conditional 'I'd buy if…' coded BUYIF (10) and excluded; not a customer sample — quietly content payers are missing; no conversion, renewal, refund or ARPU stated

- **Where:** §6.1 Framing — 34 payers (6.30%); narrowest reliable denominator; segment rates; not a sample of customers; inclusion rule first-person payment/membership in any language; BUYIF 10 excluded
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 34 (6.30%)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Review IDs:** `8742019793`, `9091830635`, `8969889060`, `12339917492`, `11938623754`, `13572606322`, `13681998290`
- **Canonical:** — (nuance register)

### R36-140 — Purchase triggers with segment rates on 34 payers

- **Where:** §6.3 What makes people buy (verbatim table)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Purchase trigger | Payers | Segment rate | Evidence ; Proof first — the free app worked, then they paid | 6 | 17.6% | 8882707067 "Have been having it for free until today and decided to purchase"; 8148224036 "MAKING MY LIFE SO MUCH BETTER!!! … The subscription is a small price to pay"; 12660421508 "I tried out the paid version on a whim and I can't believe it was actually worth it"; 10008304313 "I don't typically like paying for subscriptions but this one is definitely worth it" ; Patronage — paying to support an indie maker | 5 | 14.7% | 8742019793 "I bought a paid subscription to support the developer"; 11234189426 "had to support them with a membership"; 8210628761 (fr) "l'idée de payer 15€ par an pour féliciter, soutenir et remercier le travail d'une équipe indépendante"; 8736830661 "how do you thank the dev? Buy a beautiful skin" ; Price anchoring against competitors | 4 | 11.8% | 8868694307 "Subscription price is reasonable, and actually cheaper than the previous habit tracker I was using"; 11486217313 "$14.99 … less than a quarter of the price for competitor habit trackers"; 11125368439 vs Atoms at "£17.99 a month" ; The suite, not Habits | 4 | 11.8% | 11980712489 "I purchased the S2 for the weather app, but Habits is really the star for me"; 11938623754 "Bought the 5 app package"; 9503462497 recommends buying the whole bundle; 9313935543 bought Habits *alone* because it is "the only app in the pack truly worth it" ; The skins / cosmetics themselves | 3 | 8.8% | 12903468865 "the skins are very fun too"; 8668843555 "I'd be very happy to buy new skins"; 11562816267 "Plenty of skins to choose from" ; Social proof from a real person | 1 | 2.9% | 12155806021 "looking at one of my friend use this app, I paid for yearly subscription" — and then regretted it
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** app-specific
- **Review IDs:** `8882707067`, `8148224036`, `12660421508`, `10008304313`, `8742019793`, `11234189426`, `8210628761`, `8736830661`, `8868694307`, `11486217313`, `11125368439`, `11980712489`, `11938623754`, `9503462497`, `9313935543`, `12903468865`, `8668843555`, `11562816267`, `12155806021`
- **Canonical:** — (nuance register)

### R36-155 — Country scope: only the US (252) reaches 50; all 540 reviews in global numbers; high-spend markets not used (no external source; review volume never used as a spend proxy or called downloads); high-review-volume storefronts us 252 (46.7%), gb 42 (7.8%), cn 38 (7.0%), in 32 (5.9%), ca 21 (3.9%) = 385 of 540 (71.3%) — a property of this corpus only

- **Where:** §7.1 Eligibility and scope — threshold 50: only US (252); all 540 in global numbers; high-spend markets NOT USED (no external source; review volume never a spend proxy); high-review-volume markets us 252 (46.7%), gb 42 (7.8%), cn 38 (7.0%), in 32 (5.9%), ca 21 (3.9%) = 385 of 540 (71.3%)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** us 252 (46.7%) … 385/540 (71.3%)
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R36-172 — Everything else: 54 storefronts with 1–9 reviews each (155 reviews) in global numbers with no standalone claims; two single records flagged under the safety / consumer exception — cn multi-charge billing and a US disabled reviewer reporting an unauthorised charge

- **Where:** §7.4 Everything else — 54 storefronts with 1–9 reviews, 155 reviews; two notable single records flagged for safety/consumer exceptions (cn multi-charge billing; us disabled reviewer unauthorised charge)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 54 storefronts, 155 reviews
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `12524757331`, `10658186053`
- **Canonical:** — (nuance register)

### R36-173 — Reviews appear in at least 15 languages; non-English reviews are not shorter or less useful — the Chinese and German blocks contain some of the most specific pricing and sync feedback; two Chinese reviews came from the US storefront and one Russian from Germany — storefront is not nationality

- **Where:** §7.5 A language note — at least 15 languages; non-English reviews not shorter or less useful (Chinese and German blocks most specific on pricing and sync); Chinese from the us storefront and Russian from de; storefront is not nationality
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 15+ languages
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `10010716282`, `13330978540`, `13281010624`
- **Canonical:** — (nuance register)

### R36-174 — Eras cut at events multiple reviews attest: E1 15 Dec 2021 → 28 Sep 2022, 114, mean 3.921, 1–2★ 21.9% (launch and first-year shakeout); E2 16 Oct 2022 → 11 Sep 2023, 68, 4.235, 11.8% (mature free tier); E3 4 Oct 2023 → 29 Dec 2024, 167, 4.162, 13.2% (widgets paywalled); E4 3 Jan → 15 Nov 2025, 83, 4.205, 15.7% (stable year); E5 1 Dec 2025 → 4 Sep 2026, 108, 3.722, 25.0% (capped at 2, then 1); a trend is claimed only if it holds in both era and half-year tables; E3 long because no attested event splits it

- **Where:** §8.1 Method — five eras cut at multi-review attested events (verbatim table): E1 2021-12-15 → 2022-09-28 114 3.921 21.9% launch; E2 → 2023-09-11 68 4.235 11.8% mature free tier; E3 2023-10-04 → 2024-12-29 167 4.162 13.2% widgets paywalled; E4 2025-01-03 → 2025-11-15 83 4.205 15.7% stable; E5 2025-12-01 → 2026-09-04 108 3.722 25.0% capped; trend only if era and half-year both hold
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Era | Window | n | Mean | 1–2★ | Defined by ; E1 | 2021-12-15 → 2022-09-28 | 114 | 3.921 | 21.9% | Launch and first-year shakeout ; E2 | 2022-10-16 → 2023-09-11 | 68 | 4.235 | 11.8% | Mature free tier, before the widget gate ; E3 | 2023-10-04 → 2024-12-29 | 167 | 4.162 | 13.2% | Widgets behind the paywall (from 4 Oct 2023) ; E4 | 2025-01-03 → 2025-11-15 | 83 | 4.205 | 15.7% | Stable year before the habit cap ; E5 | 2025-12-01 → 2026-09-04 | 108 | 3.722 | 25.0% | Free tier capped at 2 habits, then 1
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R36-183 — Non-claims: ratings did not decline steadily (E1 3.92 → 4.24 → 4.16 → 4.21 → 3.72 — rough start, three good years, a sharp 2026 break); no installs, revenue, conversion, renewal or refund rates; no feature ship date except multi-review attested ones (Oct 2023 widget gate; Dec 2025 habit cap; Dec 2025 switching improvement); no trend from 2026 H2 alone (n = 20); exactly one review mentions AI, as a substitute ('doing it with AI daily tasks until I find an alternative', 0.19%); CAP in 26.9% of E5 while E5 falls 0.48★ is a strong dated multi-storefront association, not proof

- **Where:** §8.9 Trends explicitly NOT claimed — no steady decline (3.92 → 4.24 → 4.16 → 4.21 → 3.72: rough start, three good years, sharp 2026 break); no installs/revenue/conversion/renewal/refund; no feature ship dates except multi-review attested (Oct 2023 widget gate; Dec 2025 cap; Dec 2025 switching); no 2026 H2 trend (n = 20); AI mentioned once only as a substitute (0.19%); no causal claim from CAP 26.9% vs E5 −0.48★
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** AI 1 (0.19%); 2026 H2 n=20
- **Direction for us:** none · **Report confidence:** explicit non-claims · **Generalisable:** yes
- **Review IDs:** `14236390341`
- **Canonical:** C056 Don't build AI features on demand grounds

### R36-222 — Research question: Did the December 2025 cap increase revenue enough to justify a 0.48-star drop and a 25% 1–2★ rate? Requires conversion and retention data

- **Where:** Part 10 #1 (§10.5 research question 1)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R36-223 — Research question: How many free users ever had more than 1–3 habits? Determines whether the cap converts or merely blocks

- **Where:** Part 10 #2 (§10.5 research question 2)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R36-224 — Research question: Is a lifetime SKU live in some storefronts (¥398 one-time in China vs none in US/EU)? Needs a store-config audit

- **Where:** Part 10 #3 (§10.5 research question 3)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R36-225 — Research question: What is the actual current price ladder per storefront? Reviewer reports span $15–$70/yr over four years

- **Where:** Part 10 #4 (§10.5 research question 4)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R36-226 — Research question: Where do users actually stop? The corpus suggests around day 60 but has no retention curve

- **Where:** Part 10 #5 (§10.5 research question 5)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R36-227 — Research question: Does the upsell screen convert at all? 24 reviews say it repels; its conversion rate is the only thing that could justify keeping it

- **Where:** Part 10 #6 (§10.5 research question 6)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R36-228 — Research question: Is the 2026 layout bug device-specific or OS-specific? Four reviews name four combinations

- **Where:** Part 10 #7 (§10.5 research question 7)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R36-229 — Research question: Did localisation actually ship in 2022? Inferred from the complaint stopping, never confirmed

- **Where:** Part 10 #8 (§10.5 research question 8)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)
