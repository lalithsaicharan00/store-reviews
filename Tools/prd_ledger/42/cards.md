# Cards — report 42

Source: `App Store Reports/42. Daily Habit & Routine Tracker - Goals planner. Productive days (REPORT).md`  
130 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 4
- [Must-haves](#must-haves) — 4
- [Must never break](#must-never-break) — 14
- [Features](#features) — 6
- [Monetization](#monetization) — 19
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 17
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 13
- [Dated events and trends](#dated-events-and-trends) — 12
- [Positioning](#positioning) — 4
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 10
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 20

## Product rules

### R42-021 — Retroactive paywalling of an installed base produces the angriest reviews from the longest-tenured users: 'I've used the app a long time, until today's subscription screen appeared… forcing subscription, disabling buttons… If it continues like this, I and those around me will stop using it and stop recommending it' (TR, 1★, Dec 2024); 'An app I used to love… but everything has become paid' (TR, 1★, Jan 2026); 'after the update, only useful in the paid version' (PL, 3★, Mar 2025)

- **Where:** Executive summary #12 — features taken away retroactively, in churn language: 'I've used the app a long time, until today's subscription screen appeared… forcing subscription, disabling buttons… I and those around me will stop using it and stop recommending it' (TR, 1★, Dec 2024); 'An app I used to love… but everything has become paid' (TR, Jan 2026); 'after the update, only useful in the paid version' (PL, 3★, Mar 2025)
- **This app does:** free features paywalled on update
- **User reaction:** churn
- **Magnitude:** retroactive_paywall 3 (1.46%), 1.67
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12021785730`, `13595332155`, `12472128598`
- **Canonical:** C001 Never move a free feature behind the paywall; C186 Never revoke what earlier buyers paid for when the model changes

### R42-079 — Never make reminders the headline paid feature — it moves the comparison to the free clock app: three reviewers independently conclude the phone already does it — 'better to use the native Lista app on iPhone, it's practically the same thing, doesn't freeze and is free' (BR); 'the paid version adds a reminder — you can set that in the calendar too' (RU); 'Your alarm or reminder on your phone can do everything this app does. Wasted $20!' (US)

- **Where:** §5.7 Three reviewers say the phone's built-in tools already do the job when reminders are the paid feature — 'better to use the native Lista app on iPhone… doesn't freeze and is free'; 'the paid version adds a reminder — you can set that in the calendar too'; 'Your alarm or reminder on your phone can do everything this app does' — the losing frame; the strongest argument against paywalling reminders
- **This app does:** reminders paid
- **User reaction:** churn
- **Magnitude:** competitor_native 3 (1.46%), 2.33
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11540202999`, `6313215651`, `10305077033`
- **Canonical:** C257 Never paywall reminders — it moves the comparison from 'which habit tracker' to 'why pay for an alarm'

### R42-111 — Raise the free-habit cap and move the wall off the thing the product is named after — cap history depth, statistics depth or reminder count rather than habit count; magnitude uncertain (the one clean conversion paid on design, not on hitting a wall)

- **Where:** §8.2 S1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** paywall_cap 55 (1.96); 37 of 83 1–2★ (44.6%)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10991854727`, `11319751646`, `8568438754`, `10804399038`, `11186327600`, `11447879577`, `6695360237`, `10832301711`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R42-112 — Stop paywalling reminders — the most defensible single paywall change: praised reminders average 5.00 and paid reminders reframe the purchase as 'why pay for an alarm', the one comparison the product cannot win

- **Where:** §8.2 S2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** reminders_paywalled 5 vs praise_reminders 6 (5.00); competitor_native 3
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `5990760352`, `7588653687`, `7762886727`, `6026946756`, `9671666294`, `7968248707`, `10305077033`, `6313215651`, `11540202999`
- **Canonical:** C257 Never paywall reminders — it moves the comparison from 'which habit tracker' to 'why pay for an alarm'

## Must-haves

### R42-029 — A widget is category baseline by 2023–24: all three mentions frame its absence competitively — 'it has no widgets, so it loses against the rest of similar apps' (ES, 1★); 'It's a paid app, so I have higher requirements than other free apps. PLEASE add a WIDGET section on the main screen and lock screen' (VN, payer); 'doesn't have widgets, which is inconvenient' (UA)

- **Where:** §2.1 Widgets do not exist — all three mentions say they are absent; the widget gap is scored against the category baseline: 'no tiene widgets, por lo que pierde frente al resto de apps similares'; 'It's a paid app, so I have higher requirements… PLEASE add a WIDGET section on the main screen and lock screen' (payer)
- **This app does:** no widgets
- **User reaction:** complaint
- **Magnitude:** 3 (1.46%), 2.67
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10155196420`, `9615589336`, `10774694629`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R42-030 — Support must not depend on a configured Mail app, and replies must be specific: the in-app contact is mailto: only — 'it says mail is not connected, but there's no section in the app to connect it' (RU payer); e-mail support is contested — 'Great customer service' vs 'Apenas respondem a mesma coisa para todos' ('they just reply the same thing to everyone')

- **Where:** §2.1 In-app support contact broken — mailto: only ('it says mail is not connected, but there's no section in the app to connect it'); email support exists, quality contested ('Great customer service' vs 'they just reply the same thing to everyone')
- **This app does:** mailto: only; canned replies
- **User reaction:** complaint
- **Magnitude:** 3 reviews
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11826835199`, `7700270494`, `10991854727`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R42-109 — Give paying users an in-app support path that does not depend on the Mail app — a paying customer with data loss had no route to a human or a refund; also mitigates canned identical replies

- **Where:** §8.1 F7
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** support_channel_broken 1 (severe)
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11826835199`, `10991854727`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R42-114 — Ship home-screen and lock-screen widgets — all three mentions frame the absence as a competitive deficit (2023–2024)

- **Where:** §8.2 S4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** widget_missing 3
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10155196420`, `9615589336`, `10774694629`
- **Canonical:** C009 Basic widgets, icons and colours are free

## Must never break

### R42-015 — Performance must not degrade with habit count or be blocked by a celebration modal: lag / freezing 12 reviews (5.83%, mean 2.58), 9 Brazilian (16.4% of BR) and 4 payers — 'Every time you mark something, a trophy pops up which freezes everything even more! … It takes me at least 5 minutes to mark two tasks as done' (payer, 2★); 'every time the congratulation pops up it won't let you press continue right away… it pops up far too often' (RU, 3★); 'the more goals you add the slower it gets' (BR, 2★) — it strikes engaged, long-tenured, paying users specifically

- **Where:** Executive summary #6 — performance degradation is Brazil- and payer-concentrated: perf_lag 12 (5.83%, mean 2.58), 9 of 12 Brazilian (16.4% of BR), 4 of 12 payers; the trophy / congratulations animation freezes everything ('Demoro pelo menos uns 5 minutos para conseguir colocar duas tarefas como feitas'); 'quanto mais metas coloca mais lerdo ele fico'
- **This app does:** blocking trophy modal; slows with data
- **User reaction:** churn
- **Magnitude:** 12 (5.83%), 2.58; 9 BR; 4 payers
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11164675946`, `11476120833`, `10777125663`
- **Canonical:** C083 Performance must not degrade with habit count; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

### R42-019 — Never list a language the app does not deliver: the listing names 36 languages including Hebrew and Ukrainian, yet 5 reviews (2.43%, mean 2.60) report them missing — 'They present it as if it's in Hebrew. In practice there's no option for a Hebrew interface' (IL, 1★); 'How to switch to Ukrainian/English interface? Preview on AppStore was on Ukrainian, I don't like that it's on russian at the moment' (UA, 4★); 'hasn't had Ukrainian for how many years now'; 'Add Ukrainian' — three of Ukraine's eight reviews; a Ukrainian user defaulting to a Russian interface in 2024 is a market-specific risk beyond ordinary localisation debt

- **Where:** Executive summary #10 — the store listing claims Hebrew and Ukrainian support the app does not deliver: localisation_missing 5 (2.43%, mean 2.60); 'They present it as if it's in Hebrew. In practice there's no option for a Hebrew interface'; 'Preview on AppStore was on Ukrainian, I don't like that it's on russian'; 'hasn't had Ukrainian for how many years now'; three of Ukraine's eight reviews
- **This app does:** 36 languages listed; Hebrew/Ukrainian absent
- **User reaction:** complaint
- **Magnitude:** 5 (2.43%), 2.60; 3 of 8 UA
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `7882790956`, `11620239635`, `10774694629`, `12362076952`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C255 An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language

### R42-033 — The price shown must be the price charged: a Brazilian buyer was shown a promotional R$39.90/year that became R$99.90 at the point of purchase (1★) — the one hard pricing-mechanics bug — amid seven live SKUs with five near-identical names at $39.99 and $59.99, the signature of cohort price testing

- **Where:** §2.2 The pricing surface — seven live IAP SKUs; five near-identically-named at $39.99 / $59.99 is the signature of active price testing; a BR buyer shown a promotional R$39.90/year that became R$99.90 at purchase — the one hard pricing-mechanics bug
- **This app does:** 7 SKUs; promo price not honoured
- **User reaction:** 1★-burst
- **Magnitude:** n=1 (1★); 7 SKUs
- **Direction for us:** must-never-break · **Report confidence:** anecdotal; high consequence · **Generalisable:** yes
- **Review IDs:** `12815733039`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R42-034 — A trial must be visible to prospects and never feel like a trap: no reviewer describes completing a free trial, fourteen ask for one they could not find, and the two who hit it call it a trap — 'Don't fall for the free-trial trap.. you won't get a refund even if you cancel two minutes after' (BR, 1★); 'Auto-selected a package and charged me… lost 499k and don't understand why, and hadn't even tried it' (VN, 1★) — invisible and trap-like are not mutually exclusive

- **Where:** §2.2 Trial — no reviewer describes completing a free trial; two caught by one: 'Nao caiam na cilada de período gratis.. vc nao conseguirao o reembolso nem se cancelar dois minutos depois'; 'Auto-selected a package and charged me… lost 499k… hadn't even tried it'; fourteen ask for a trial they could not find — invisible to prospects or experienced as a trap
- **This app does:** trial hidden; auto-selected package
- **User reaction:** 1★-burst
- **Magnitude:** trial_trap 2 (1.00); billing_unexpected_charge 3 (1.00); no_trial 14
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13555244418`, `13143403370`
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R42-040 — Worse after an update 8 (3.88%, mean 2.50), spread 2020–2025

- **Where:** §3.1 master table #12 regression_after_update
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 (3.88%), 2.50
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C175 Updates must not break function or wipe progress

### R42-046 — Statistics wrong or gone 3 (2.00); stats too thin 2 (2.00); a specific statistics miscalculation 2 (3.50)

- **Where:** §3.1 master table #30 stats_broken / #37 stats_insufficient / #38 stats_bug
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 3 / 2 / 2
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C011 Weekly / monthly / yearly reports; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R42-057 — Reliability sub-themes: lag 12 (5.83%, 2.58; 9 BR, 4 payers); regression after update 8 (3.88%, 2.50, spread 2020–2025); won't open / launch crash 7 (3.40%, 1.71; 5 RU Dec 2024 – Jan 2025); data loss 6 (2.91%, 1.33); statistics broken 3 (2.00); check-off bug 2 (4.00, paying users reporting politely); stats bug 2 (3.50); reorder bug 1; badge bug 1

- **Where:** §3.3.4 Reliability (verbatim sub-theme table) — perf_lag 12 (9 BR, 4 payers); regression_after_update 8; outage_crash 7 (5 RU Dec 2024 – Jan 2025); data_loss 6 (highest severity); stats_broken 3; checkoff_bug 2; stats_bug 2; reorder_bug 1; badge_bug 1
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Sub-theme | n | % | Mean ★ | Notes ; perf_lag | 12 | 5.83% | 2.58 | 9 of 12 Brazilian; 4 of 12 payers ; regression_after_update | 8 | 3.88% | 2.50 | spread 2020–2025 ; outage_crash | 7 | 3.40% | 1.71 | 5 of 7 Russian, all Dec 2024 – Jan 2025 ; data_loss | 6 | 2.91% | 1.33 | highest-severity theme in the report ; stats_broken | 3 | 1.46% | 2.00 | ; checkoff_bug | 2 | 0.97% | 4.00 | both from paying users reporting politely ; stats_bug | 2 | 0.97% | 3.50 | ; reorder_bug | 1 | 0.49% | 5.00 | ; badge_bug | 1 | 0.49% | 5.00 |
- **Direction for us:** must-never-break · **Report confidence:** high-priority (union) · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C083 Performance must not degrade with habit count; C175 Updates must not break function or wipe progress

### R42-058 — Updates must never truncate or wipe history: data loss 6 reviews (2.91%, mean 1.33), acted on regardless of share — 'last night it updated. I woke up this morning and there is nothing in the app anymore 😩 All my data and tracking… is gone' (US, Feb 2020); 'I created a habit, it disappeared, created another, it disappeared too' (RU payer, Oct 2024); 'I tried to restart the app and… everything was wiped, both progress and the habits themselves' (RU, 3★, a 3+ month user asking for help); 'I used it for many years… After the last update progress isn't visible. Only manual counting… looking for a replacement' (RU, Nov 2024); 'I had 90 days of progress on every habit, now it's all gone and became 9 days' (RU, Jun 2026); 'all the data is lost!' (UA, ambiguous with paywalled history) — four of six Russian, four inside Oct 2024 – Jun 2026; update / restart / history truncated to a recent window recurs — consistent with a migration or retention bug

- **Where:** §3.3.4 Data loss merits action regardless of 2.91% — 'last night it updated… All my data and tracking that I've done is gone' (US 2020); habits created then vanishing (RU payer 2024); restart wiped progress and habits (3+ months user asking for help); 'I used it for many years… After the last update progress isn't visible… looking for a replacement'; '90 days of progress… became 9 days' (Jun 2026); pattern update / restart / history truncated to a recent window — a migration or retention bug; four of six Russian in Oct 2024 – Jun 2026
- **This app does:** history truncated after updates
- **User reaction:** churn
- **Magnitude:** 6 (2.91%), 1.33
- **Direction for us:** must-never-break · **Report confidence:** severity escalation · **Generalisable:** yes
- **Review IDs:** `5510835449`, `11826835199`, `12018343239`, `11966692895`, `14165208412`, `11447879577`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R42-073 — What payers buy must work: 9 of 29 payers (31.0%; 4.37% of corpus) hit a reliability defect after paying — paid for a year, app stopped opening at month three ('Give my money back, crooks'); 'I bought the paid version to have access to everything… but it freezes SO MUCH. It takes me at least 5 minutes to mark two tasks as done!… I'm only using it because I paid, but I want my money back!'; habits disappearing plus no way to reach support plus no refund, stacked on one payer; a two-year subscriber freezing; 'I have the premium version, but the statistics for habits that aren't daily-frequency don't calculate the correct percentage' — the premium feature people buy for, miscalculating

- **Where:** §5.4 Post-purchase failures — 9 of 29 payers (31.0%; 4.37% global) hit by a reliability defect after paying; paid for a year, won't open at month three; 'Only using it because I paid, but I want my money back!' (freezing); habits disappearing + no support + no refund stacked; two-year subscriber freezing; premium statistics miscalculating non-daily habits ('the premium feature people buy for, miscalculating')
- **This app does:** post-purchase defects
- **User reaction:** churn
- **Magnitude:** 9/29 (31.0%)
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `9673984947`, `10474969732`, `10834187654`, `11164675946`, `11501115720`, `11764301384`, `11826835199`, `12017526630`, `12160321648`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R42-075 — Refund requests are the highest-intensity payer signal and three describe unauthorised charges: 11 of 29 payers (37.9%, mean 1.27) — bought by mistake ('Comprei o app por engano, solicito reembolso'); charged without intending ('I downloaded the app to test out the free version and was immediately charged for a subscription upon opening the app for the first time', US; 'auto-selected a package and deducted money', VN; promo R$39.90 became R$99.90, BR); product didn't do what they bought it for (multi-count ×2; 'It doesn't set reoccurring reminders'; value); defect after purchase (freezing, data loss, won't open); trial converted and refund refused ('you won't get the refund even if you cancel two minutes after'); two cancelled; one cannot pay from Russia at all — the unauthorised-charge cluster is a store-compliance and chargeback risk, which is why the trial mechanism needs inspecting before the free cap

- **Where:** §5.5 Refunds, cancellations and billing — 11 of 29 payers (37.9%; 5.34% global, mean 1.27), the highest-intensity segment rate; causes: bought by mistake; charged without intending ('immediately charged for a subscription upon opening the app for the first time'; auto-selected package; promo price not honoured); product didn't do what bought for (multi-count; 'It doesn't set reoccurring reminders'; value); defect after purchase; trial converted and refund refused
- **This app does:** trial / purchase flow charges unexpectedly
- **User reaction:** 1★-burst
- **Magnitude:** 11/29 (37.9%), 1.27; 3 unauthorised; 1 refusal
- **Direction for us:** must-never-break · **Report confidence:** high-priority (segment) · **Generalisable:** yes
- **Review IDs:** `10053567444`, `7348111127`, `13143403370`, `12815733039`, `7113224515`, `7669054186`, `7295269143`, `12317660239`, `11164675946`, `11826835199`, `12160321648`, `13555244418`, `12413759685`, `14165208412`
- **Canonical:** C029 Billing must be exactly right; C112 In-app cancellation; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R42-107 — Fix the launch-crash path and add visible backup / restore — data loss justifies action below 3% under the severity-escalation rule; a single recurrence costs a multi-year user

- **Where:** §8.1 F5
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** outage_crash 7 (1.71); data_loss 6 (1.33)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12160321648`, `5510835449`, `12018343239`, `14165208412`, `11966692895`
- **Canonical:** C031 Crashes / launch failures; C153 Automatic cloud backup on by default — never manual opt-in

### R42-108 — Correct the Hebrew and Ukrainian claims on the store listing — either ship the localisations or remove them from the language list; currently a factual misstatement on a public listing

- **Where:** §8.1 F6
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** localization_missing 5
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `7882790956`, `11620239635`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R42-110 — Fix the promotional-price mismatch at checkout — price shown ≠ price charged is a store-compliance exposure; the reviewer offered to raise their rating on fix ('Aguardo para ajustar a avaliação do app')

- **Where:** §8.1 F8
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** pricing_bug 1 (1★)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12815733039`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised

### R42-115 — Fix the performance degradation that scales with habit count, starting with Brazil — hit at 15 habits; the users most affected are the ones who bought the app to have more than three habits

- **Where:** §8.2 S5
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** perf_lag 12 (2.58); 9 BR; 4 payers
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10777125663`, `10474969732`, `11164675946`
- **Canonical:** C083 Performance must not degrade with habit count

## Features

### R42-018 — If the app markets water, meals and health habits it must count multiple completions per day: 6 reviews (2.91%, mean 1.50), all US (13.0% of US) — 'Track your food? Great - you can track it ONCE/day. Um, even people trying to lose weight eat more than once/day'; 'A habit app that has water and meals should provide more than one opportunity a day… This defeats my purpose for buying' (payer, refund requested); 'I don't see any way to set a reminder for more than one time a day. So you're going to eat or drink water just once a day?' (payer, refund requested); 'I can't put down how many glasses of water or what I ate'; 'you really have to have me pay money to get 4 habits per day, or change the amount of reps I do?' — the mismatch produces refund-seeking buyers

- **Where:** Executive summary #9 — multiple completions per day missing: 6 (2.91%, meaningful, mean 1.50), all US (13.0% of US); 'Track your food? Great - you can track it ONCE/day'; 'This defeats my purpose for buying' (payer, refund); 'So you're going to eat or drink water just once a day?' (payer, refund); the marketing surface (water, meals) promises a counter, the product delivers a binary daily checkbox
- **This app does:** binary daily checkbox; water/meal templates
- **User reaction:** churn
- **Magnitude:** 6 (2.91%), 1.50; 2 refund-seeking payers
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9838731003`, `7113224515`, `7669054186`, `8568438754`, `8778350918`, `6905654687`
- **Canonical:** C048 Flexible units / partial progress; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature; C143 Intra-day completion: tap N times to fill N/N

### R42-028 — Free and praised: a 'habit power' progress metric ('The idea with habit power is wonderful'), ready-made habit templates ('a great starting point'), colour coding by habit or category, dark mode, motivational quotes, a 'MyDay' section; the completion celebration modal cannot be disabled

- **Where:** §2.1 'Habit power' progress metric, ready-made templates, colour coding / categories, dark mode, motivational quotes, 'MyDay' — free; completion celebration modal free, not disableable
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** inventory
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `6312219230`, `12310659183`, `6026946756`, `7242515179`, `9375609371`, `7318342988`
- **Canonical:** C080 Colour themes / dark mode; C118 Preset routines / templates / programs

### R42-031 — Absent per reviewers: notes / photos on an entry (2); a time tracker (1); shifting a habit from one day to another (1); a shared account across iPhone / Mac / iPad (1); in-app social / mutual challenge — done informally ('I and my mom challenge each other each day') (1); flexible scheduling like 'Tue & Thu' (2); deeper customisation of a created habit (1); 'goal for the day' as advertised (1); focus on more than one habit at a time (1)

- **Where:** §2.1 Does not exist — notes / photos on an entry; time tracker; shift a habit to another day; cross-device account (iPhone + Mac + iPad); in-app social / mutual challenge ('I and my mom challenge each other each day' done informally)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 1–2 each
- **Direction for us:** research · **Report confidence:** weak / emerging · **Generalisable:** yes
- **Review IDs:** `7700270494`, `7318342988`, `13760625758`, `11105940631`, `7347301738`, `7194589305`, `6422725217`, `8653967908`, `10104662745`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C172 Per-day / per-habit notes and journal text; C202 A light social layer that is explicitly not a social network

### R42-041 — Progress %, charts, statistics praised 7 (3.40%, mean 4.71)

- **Where:** §3.1 master table #13 praise_stats
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 7 (3.40%), 4.71
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C011 Weekly / monthly / yearly reports

### R42-044 — Net-new capability requested 5 (2.43%, all 5★)

- **Where:** §3.1 master table #22 feature_requests_other
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 5 (2.43%), 5.00
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-113 — Build multi-completion-per-day counting (water, meals, reps) — structural, not a feature request: the positioning promises a counter and delivers a daily checkbox, in the highest-spend market

- **Where:** §8.2 S3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** multi_count_missing 6 (1.50), all US, 2 refund-seeking payers
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `7113224515`, `7669054186`, `9838731003`
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N

## Monetization

### R42-009 — Heavy price testing is visible to reviewers: quoted prices $39.99/yr (US 2021), $20 (US 2023), R$79.90 for 12 weeks (BR 2023), ¥6,900/yr (JP 2024), 500₽/yr (RU 2024), R$99.90/yr (BR 2025), 499k₫ (VN 2025), £9.99 (GB 2020); seven concurrent IAP SKUs from $4.99 to $59.99, five near-identically named at $39.99 and $59.99

- **Where:** Nine warnings #8 — prices vary enormously: $39.99/yr (US 2021), $20 (US 2023), R$79.90/12 weeks (BR 2023), ¥6,900/yr (JP 2024), 500₽/yr (RU 2024), R$99.90/yr (BR 2025), 499k₫ (VN 2025), £9.99 (GB 2020); seven concurrent SKUs $4.99 → $59.99 consistent with heavy price testing
- **This app does:** 7 concurrent SKUs
- **User reaction:** complaint
- **Magnitude:** 8 price points; 7 SKUs
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R42-011 — A free tier where only 3 habits and the habit title are free is read as a broken product, not a price: 55 reviews (26.70%, mean 1.96) — more than one in four — the top theme in every band below 4★ (28 of 67 1★, 9 of 16 2★, 13 of 28 3★); 'when you join, you can only make 3 habits'; 'Everything is paid! Writing a routine, only the title is free, because the time is paid, the date, etc.' (BR, 2★); 'after creating 3 habits I couldn't create more; when I press plus it asks for membership' (TR); 'There is no reason to subscribe to the app to only have 3 habits' (NZ) — at three habits a habit tracker cannot demonstrate what it is for; most never reach a price judgement

- **Where:** Executive summary #2 — the 3-habit free cap is the largest theme: 55 (26.70%, high-priority, mean 1.96), top theme in every band below 4★ (28/67 1★, 9/16 2★, 13/28 3★); read as the product being broken; 'Tudo é pago! Anotar uma rotina só o título é grátis, pq horário é pago, data, etc.'
- **This app does:** 3 habits free; time, date, reminders, repetition paid
- **User reaction:** 1★-burst
- **Magnitude:** 55 (26.70%), 1.96; 3/2/13/9/28
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10918059435`, `12798927312`, `11316242500`, `11319751646`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R42-012 — No trial is named as the reason for refusing to pay: 14 reviews (6.80%, mean 1.29 — the lowest of any theme), and reviewers name the mechanism — 'it should give a month's trial to test before charging $20 for something you don't know how it works'; 'you should at least put 3 days trial'; 'they should give a 1-day free trial'; 'not even a 7 day trial or letting me preview the app before spending $40'; 'I'm not ready to pay without seeing what's in there'; four report the paywall before any use at all — 'Literally two seconds after downloading the app it asks me to upgrade'

- **Where:** Executive summary #3 — no trial named as the reason for refusing to pay: 14 (6.80%, high-priority, mean 1.29 — lowest of any theme); reviewers name the length ('a month's trial'; '3 days trial'; '1-day free trial'; 'not even a 7 day trial… before spending $40'; 'I'm not ready to pay without seeing what's in there'); four saw the paywall before any use ('Literally two seconds after downloading the app it asks me to upgrade')
- **This app does:** no trial visible; paywall at launch for some
- **User reaction:** blocked-conversion
- **Magnitude:** 14 (6.80%), 1.29; 4 immediate paywall
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12666033997`, `11051247830`, `9003408900`, `8757372166`, `9925506606`, `8868385470`, `10824739497`
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R42-025 — Do not paywall reminders: reminders sit behind the paywall and are the single feature most often named as the thing behind the wall (5 reviews, 2.43%, mean 2.60 — 'I just wanted to use the habit reminder feature and that would cost me 40 a year? Come on. That's insane!'), while reminders that work are praised by 6 (all 5★)

- **Where:** §2.1 Reminders / notifications — paid ('reminders_paywalled' 5, 2.43%, mean 2.60) — the single feature most often named behind the wall; praised when present (6, all 5★)
- **This app does:** reminders paid
- **User reaction:** complaint
- **Magnitude:** paywalled 5 (2.60); praised 6 (5.00)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `6704352732`, `10901396387`, `9730373479`, `6881986270`, `6313215651`, `5990760352`, `7588653687`, `7762886727`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C257 Never paywall reminders — it moves the comparison from 'which habit tracker' to 'why pay for an alarm'

### R42-026 — Scheduling basics — time of day, date, which days, weekly / monthly / yearly repetition — are Premium: 'タスクの繰り返しが有料プランのみ' ('task repetition is paid-plan only'); 'only the title is free, because the time is paid, the date'

- **Where:** §2.1 Scheduling — specific days / weekly / monthly / yearly — paid; repetition / frequency paid ('task repetition is paid-plan only'); time of day and date paid
- **This app does:** scheduling paid
- **User reaction:** complaint
- **Magnitude:** within cap 55
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8559036422`, `12798927312`, `12388272937`, `7194589305`, `11948614593`, `8778350918`
- **Canonical:** C043 Flexible / custom frequency

### R42-027 — History is capped for free users: past-month results hidden unless paying ('Если не заплатить то не увидишь свой результат в прошлом месяце'), 'No historical data', 'can't go back more than 2 weeks', backfill at most to last week (history_backfill_limit 4, mean 2.25); detailed statistics are Premium and one payer says 'The detailed stats in premium version are worth it'

- **Where:** §2.1 Statistics partly free, detail paid ('The detailed stats in premium version are worth it'); historical data beyond recent days paid / capped ('if you don't pay you won't see last month's result'; 'can't go back more than 2 weeks'); backfill capped at last week
- **This app does:** history + detailed stats paid
- **User reaction:** mixed
- **Magnitude:** backfill limit 4 (2.25); stats praise 7 (4.71)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `6695360237`, `11447879577`, `11186327600`, `11120549627`, `11476120833`, `12310659183`
- **Canonical:** C011 Weekly / monthly / yearly reports; C020 Data export / backup / CSV; C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells

### R42-032 — Free vs paid as reviewers describe it: free — create up to 3 habits, check them off, basic progress and 'habit power', colour-code, dark mode, messages, templates; paid — habits 4+, reminders / notifications, time of day, which days / dates, repetition and frequency, detailed statistics, history beyond the recent window; absent at any tier — widgets, notes / photos, multiple completions per day, time tracking, cross-device account, day shifting, in-app social

- **Where:** §2.2 Free / paid classification — free: up to 3 habits, check off, basic progress, habit power, colour-code, dark mode, messages, templates; paid: habits 4+, reminders, time of day, days / dates, repetition, detailed stats, history; does not exist: widgets, notes / photos, multi-count, time tracking, cross-device, day-shifting, social
- **This app does:** 3 habits + title free
- **User reaction:** complaint
- **Magnitude:** report gives none
- **Direction for us:** product-rule · **Report confidence:** inventory · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R42-039 — Paid and it wasn't worth it 9 (4.37%, mean 2.11; 1/0/3/0/5)

- **Where:** §3.1 master table #11 value_insufficient
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 9 (4.37%), 2.11
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R42-052 — What the wall blocks, by frequency: habits 4 and beyond (dominant, 15 IDs), reminders / notifications (5), time of day / dates / days of week (3), repetition / frequency (2), viewing past months (1); present in 16 of 26 storefronts; even 5★ reviewers object — 'I loved this app but didn't like the paid areas'; 'Good app, but a shame that it's paid'; 'Although some things require payment, the effects and reminders are very motivating'

- **Where:** §3.3.1 Free-tier cap — present in 16 of 26 storefronts; three 5★ records like the app but object to the wall ('Adorei esse aplicativo mas não gostei de áreas pagas'; 'Dobrá apka, ale škoda že placená'); named behind the wall in descending frequency: habits 4+, reminders, time / dates / days, repetition, past months
- **This app does:** 3-habit cap + paid basics
- **User reaction:** complaint
- **Magnitude:** 55; 16/26 storefronts; 28/9/13/2/3
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `7987636680`, `8102592409`, `7968248707`, `10918059435`, `8757084304`, `9976210363`, `10754787779`, `12133174175`, `11364850554`, `10194166127`, `12008088495`, `11120549627`, `10086792760`, `13256129945`, `11316242500`, `11051247830`, `9775946178`, `11319751646`, `6704352732`, `10901396387`, `9730373479`, `6881986270`, `6313215651`, `12798927312`, `12388272937`, `8559036422`, `11948614593`, `8778350918`, `11447879577`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C043 Flexible / custom frequency; C257 Never paywall reminders — it moves the comparison from 'which habit tracker' to 'why pay for an alarm'

### R42-054 — Price objection is about price vs delivered substance and tracks local price: 18 reviews (8.74%, mean 1.67, zero at 4–5★) quote $39.99/yr ('I just wanted to use the habit reminder feature and that would cost me 40 a year? Come on. That's insane!'), $20, R$79.90 for 12 weeks ('Loved it… but it's very expensive'), ¥6,900/yr, 'shocked when i saw that you pay that much for barely any technology'; the one positive price signal ('costs 500₽ a year, that's nothing') comes from the market with the lowest local price — consistent with the price being mis-set for high-income markets relative to the feature set

- **Where:** §3.3.2 price_objection 18 (8.74%, mean 1.67, zero 4–5★), reviewers quote figures: $39.99/yr ('I just wanted to use the habit reminder feature and that would cost me 40 a year? … insane!'); $20; R$79.90 / 12 weeks ('Amei… mas é muito caro'); ¥6,900/yr; 'shocked… you pay that much for barely any technology'; one positive — 500₽ a year 'that's nothing' in the lowest-price market
- **This app does:** $39.99/yr US vs 500₽ RU
- **User reaction:** complaint
- **Magnitude:** 18 (8.74%), 1.67
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `6881986270`, `8757372166`, `10305077033`, `12666033997`, `9479819359`, `11948614593`, `6552567684`, `10989878670`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R42-055 — Subscription-model objections: 4 (1.94%, mean 1.50) — 'Нет перманентной, только подписка на год' ('No permanent option, only a yearly subscription', the only explicit lifetime request); 'They don't mention the ongoing subscription fee!'; 'make using the app more easy without the user having to spend money and have the premium be a better version of the app, not have the app very limited and then make the premium unlimited'

- **Where:** §3.3.2 subscription_objection 4 (1.94%) — 'No permanent option, only a yearly subscription' (the only explicit lifetime request); 'They don't mention the ongoing subscription fee!'; 'have the premium be a better version of the app, not have the app very limited and then make the premium unlimited'
- **This app does:** yearly subscription only
- **User reaction:** complaint
- **Magnitude:** 4 (1.94%), 1.50
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9950651418`, `7148080715`, `8778350918`, `12021785730`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R42-056 — A time-boxed full trial is the cheaper answer than a bigger free tier: 'no trial' asks for temporary full product while the cap complaint asks for more free product, and fourteen asked for the former (mean 1.29); category shoppers ready to spend were lost — 'I am in the process of trying to find a HabitBull alternative after years of use. Your app had some of the features I was looking for. Unfortunately: I couldn't move around or familiarize myself enough to justify paying to unlock integral features' (FR, 2★); 'Free version too simple to allow evaluating the premium purchase. And… no widgets, so it loses against the rest of similar apps' (ES, 1★)

- **Where:** §3.3.3 No trial — 14 (lowest mean 1.29, 11 1★, none above 3★); a migrating HabitBull power user lost at the wall ('I couldn't move around or familiarize myself enough to justify paying to unlock integral features'); 'Free version too simple to allow evaluating… and no widgets'; no_trial ≠ paywall_cap — a trial asks for temporary full product and is strictly cheaper to grant
- **This app does:** no trial
- **User reaction:** blocked-conversion
- **Magnitude:** 14 (6.80%), 1.29
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12666033997`, `8559036422`, `9003408900`, `10804399038`, `10498159047`, `11051247830`, `10155196420`, `10495503059`, `9925506606`, `10824739497`, `12008088495`, `8757372166`, `8868385470`, `8568438754`
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay

### R42-071 — Statistics are the actual premium value proposition: of six named purchase triggers, three are statistics — 'Seeing the progress percentage of habits and which days they were done was a feature I was looking for; because I found it in this app I bought the premium version' (TR); 'The detailed stats in premium version are worth it if you're serious about tracking your growth and daily goals' (US); plus minimalist design after a long search (RU, 15 minutes), unlimited habits (US), a low local price ('500₽ a year, that's nothing', RU), and motivation to start a routine — 'I was very motivated to build exercise habits and subscribed on the very first day' (BR, 2★, disappointed two weeks later); the same feature is also a defect surface (praise_stats 7 at 4.71 vs stats defects 7 at 2.43)

- **Where:** §5.2 What triggers a purchase (verbatim table) — minimalist design + search fatigue; progress % + per-day visibility ('because I found it in this app I bought the premium version'); detailed statistics ('worth it if you're serious about tracking'); unlimited habits; low local price (500₽); motivation to start a routine (bought on day one, disappointed two weeks later)
- **This app does:** detailed stats premium
- **User reaction:** purchase-driver
- **Magnitude:** Trigger | ID | Evidence ; Minimalist design + search fatigue | 10832301711 (RU, 5★) | *"я очень долго искала идеальное приложение, а здесь оформила годовую подписку в первые 15 минут"* / "I searched a long time for the perfect app, and here I took out a yearly subscription in the first 15 minutes" ; Progress % + per-day visibility | 13760625758 (TR, 5★) | *"Alışkanlıkların ilerleme yüzdesini ve hangi günler yapıldığını görmek aradığım bir özellikti bu uygulamada bulduğum için premium sürümünü aldım"* / "Seeing the progress percentage of habits and which days they were done was a feature I was looking for; because I found it in this app I bought the premium version" ; Detailed statistics | 12310659183 (US, 5★) | *"The detailed stats in premium version are worth it if you're serious about tracking your growth and daily goals"* ; Unlimited habits | 6307010280 (US, 5★) | *"I use a premium version and I like that I can create as many habits as I want"* ; Low local price | 10989878670 (RU, 5★) | *"стоит 500 руб за год, ерунда"* / "costs 500₽ a year, that's nothing" ; Motivation to start a routine | 11446221021 (BR, 2★) | *"Estava bem motivada em criar hábitos de esporte e assinei a versao paga logo no primeiro dia"* / "I was very motivated to build exercise habits and subscribed on the very first day" — bought on intent, disappointed two weeks later
- **Direction for us:** build-paid · **Report confidence:** segment (6 buyers) · **Generalisable:** yes
- **Review IDs:** `10832301711`, `13760625758`, `12310659183`, `6307010280`, `10989878670`, `11446221021`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R42-077 — People willing to pay were blocked by evaluation, not price: a HabitBull migrant who could not evaluate enough to unlock; 'I was ready to pay, but it has to be reasonable… I'm sure if you lower the price, revenue will grow' (RU, 3★); 'It has potential but it should give a month's trial' (AR); 'I wanted to know if the app would meet my current goal needs, but there's no way, every tab I open to poke around is locked' (BR, 1★); free version too thin to evaluate plus no widgets (ES) — the common request is 'let me see it working first'

- **Where:** §5.6 Barriers to upgrading — every one an evaluation failure, not a price failure: migrating HabitBull user; 'I was ready to pay, but it has to be reasonable… I'm sure if you lower the price, revenue will grow'; 'It has potential but it should give a month's trial'; 'every tab I open to poke around is locked'
- **This app does:** everything locked, no trial
- **User reaction:** blocked-conversion
- **Magnitude:** 5 reviews
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10495503059`, `5629089340`, `10155196420`, `12666033997`, `9003408900`
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay

### R42-103 — Ship a time-boxed full-feature trial — reviewers asked for 1 day, 3 days, 7 days and 1 month; the shortest that demonstrates a routine is the right answer; the 14 who asked are a floor, the 55 cap reviewers describe the same evaluation failure

- **Where:** §8.1 F1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** no_trial 14 (1.29) + paywall_immediate 4 (1.00)
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12666033997`, `11051247830`, `9003408900`, `8757372166`
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

### R42-116 — Experiment: free-cap ladder 3 vs 6 vs 10 habits against trial-start rate, D7 retention, paid conversion and written-review rating — two reviewers argue a lower barrier would raise revenue

- **Where:** §8.3 E1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** paywall_cap 55
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10991854727`, `5629089340`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R42-117 — Experiment: trial length — 7-day full-feature vs paywall-first; primary paid conversion, secondary (more important per corpus) 1★ rate

- **Where:** §8.3 E2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** no_trial 14
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C063 Free trial before purchase

### R42-118 — Experiment: in high-spend markets (worst-rated at 2.587, cap only 11.1% — capability not price) test a lower-priced tier unlocking only habits + reminders vs the current $39.99–$59.99 all-or-nothing SKUs

- **Where:** §8.3 E3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** high-spend 2.587
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C064 Price level — where 'fair' turns into 'too expensive'

### R42-119 — Experiment: statistics as the premium anchor — position the paywall on analytics depth rather than habit count, after fixing the non-daily-frequency percentage bug

- **Where:** §8.3 E4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 3 of 6 triggers statistics
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9673984947`
- **Canonical:** C011 Weekly / monthly / yearly reports; C133 Gate on capability, not on quantity

## Tactics the app used

### R42-006 — Outcome of apparent solicited / seeded review bursts (US Aug 2020 with inflated helpful votes; Canada May 2021): they added 17 5★ reviews but did not hold the written-review mean — it fell every year from 3.96 (2020) to 2.69 (2025) and 1.57 (2026), and Canada's burst left the market otherwise unmeasurable (12 reviews)

- **Where:** Nine warnings #3 — review bursts as a tactic: vote-inflated nonsense-title 5★ cluster (US 2020) and a Canada 5★ burst (2021)
- **This app does:** review bursts
- **User reaction:** 5★-burst
- **Magnitude:** 17 reviews; decline continued
- **Direction for us:** dont · **Report confidence:** suspected · **Generalisable:** yes
- **Review IDs:** `6306860426`, `6312219230`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R42-072 — Outcome of shipping performance and statistics fixes: a churned subscriber came back — 'Thanks for the update, it helped remove the lag. I'll bring my subscription back.' (RU, 5★, Oct 2023, edited) — and a year-long subscriber praised the improvement — 'how much the app has improved in that time! Progress details, results info, charts — the dev team is doing great' (RU, Jul 2025); both recoveries are about statistics and performance, from the same market suffering crashes — the market responds measurably to remediation

- **Where:** §5.3 What paid users value after buying — stats 3, simplicity 2, perf_improved 2, gamification 1, design 1, templates 1, unlimited 1; 'Thanks for the update, it helped remove the lag. I'll bring my subscription back' — a churned subscriber returning because a performance fix shipped; 'how much the app has improved… Progress details, results info, charts' — both RU, statistics and performance win people back
- **This app does:** fixes shipped
- **User reaction:** 5★-burst
- **Magnitude:** 2 payers; perf_improved 2 (5.00)
- **Direction for us:** do · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10474969732`, `12890217155`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

## Insights (the why)

### R42-010 — When the paywall is the problem, fixing bugs recovers little: monetisation friction (cap, price, no trial, deceptive free, immediate paywall, nagging, paywalled reminders, retroactive paywall, paywalled history, subscription objection, trial traps, unexpected charges, refunds, cancellations, insufficient value) is 87 reviews (42.23%, mean 1.85) producing 61 of 83 1–2★ (73.5%; 49 of 67 1★, 12 of 16 2★); every reliability defect together is 31 (15.05%, mean 2.45) producing 17 of 83 (20.5%) — fixing every bug recovers about a fifth of the bad reviews, fixing the paywall three-quarters

- **Where:** Executive summary #1 — the rating is set entirely at the paywall: monetisation friction union (18 themes) 87 (42.23%, mean 1.85) → 61 of 83 1–2★ (73.5%; 49 of 67 1★, 12 of 16 2★); reliability union 31 (15.05%, 2.45) → 17 of 83 (20.5%); fixing every bug recovers a fifth, fixing the paywall three-quarters
- **This app does:** 3-habit cap + paid basics + no trial
- **User reaction:** 1★-burst
- **Magnitude:** 87 (42.23%), 1.85 → 73.5% of 1–2★; reliability 31 → 20.5%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R42-013 — A paywall that converts people into dissatisfied buyers is more expensive than one that blocks them: 29 payers (14.08%) average 2.72 vs 3.20 for 177 non-payers; 11 of 29 (37.9%; 5.34% of the corpus) request or reference a refund; 9 of 29 (31.0%) hit a reliability defect after paying; 5 of 29 (17.2%) say it wasn't worth it — 'I paid for premium and it's worthless'; 'Your alarm or reminder on your phone can do everything this app does. Wasted $20!'; 'I paid more than what it offers as premium. No exceptional features. Very basic.'

- **Where:** Executive summary #4 — paying customers rate worse than non-payers: 29 payers (14.08%) mean 2.72 vs 3.20 non-payers; 11 of 29 (37.9%; 5.34% global) request a refund; 9 of 29 (31.0%) hit a reliability defect after paying; 5 of 29 (17.2%) not worth the money ('Your alarm or reminder on your phone can do everything this app does. Wasted $20!'; 'Basicão')
- **This app does:** annual subscription $39.99
- **User reaction:** churn
- **Magnitude:** payers 2.72 vs 3.20; refunds 11/29 (37.9%); defect 9/29; not worth 5/29
- **Direction for us:** must-never-break · **Report confidence:** high-priority (segment) · **Generalisable:** yes
- **Review IDs:** `10053567444`, `7113224515`, `7295269143`, `7348111127`, `7669054186`, `11164675946`, `11826835199`, `12160321648`, `12317660239`, `12413759685`, `13555244418`, `6276118032`, `10305077033`
- **Canonical:** C029 Billing must be exactly right; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R42-017 — The value proposition works when people get past the wall: simplicity praise 22 (10.68%, mean 4.68) stable across seven years and languages (Russian 6, US 5, BR 3, CA 3, UA 2, BY, LV, VN) — 'Very simple and clear interface… nothing extra'; 'there is no any unnecessary tools for me'; 'the most comprehensive application without fluff'; 'It's not over-engineered'; behaviour change 14 (6.80%, mean 4.93) — losing weight, quitting alcohol, daily meditation, tracking expenses, brushing teeth

- **Where:** Executive summary #8 — simplicity praise stable across seven years and every language: 22 (10.68%, mean 4.68) — 'ничего лишнего'; 'no any unnecessary tools'; 'without fluff'; 'It's not over-engineered'; behaviour change 14 (6.80%, mean 4.93) — the core loop works but is locked behind a wall
- **This app does:** simple tracker
- **User reaction:** praise
- **Magnitude:** simplicity 22 (10.68%), 4.68; behaviour 14 (6.80%), 4.93
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `5995999324`, `10387592776`, `7318341303`, `7700270494`, `5110718900`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R42-035 — No ads, yet upsell interstitials play the role of ads: zero mentions of in-app advertising in 206 reviews; the complaint is the upsell interstitial — 'the popups for premium are annoying and difficult to click out of' (upsell_nag 3, mean 1.67)

- **Where:** §2.2 Advertising — zero mentions of in-app advertising; the complaint is never ads, it is the upsell interstitial
- **This app does:** no ads; upsell pop-ups
- **User reaction:** complaint
- **Magnitude:** ads 0; upsell_nag 3 (1.67)
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9838731003`, `12193961715`, `8868385470`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R42-038 — App motivates / keeps me going 10 (4.85%, all 5★)

- **Where:** §3.1 master table #10 praise_motivation
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 10 (4.85%), 5.00
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-043 — States intent to leave / stop recommending 6 (2.91%, mean 1.83)

- **Where:** §3.1 master table #19 churn_risk
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 6 (2.91%), 1.83
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-047 — Visual design praised 3 (1.46%, all 5★)

- **Where:** §3.1 master table #32 praise_design
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 3 (1.46%), 5.00
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-051 — Families: monetisation friction 87 (42.23%, mean 1.85) → 61 / 83 1–2★ (73.5%); reliability 31 (15.05%, 2.45) → 17 (20.5%); feature gaps 27 (13.11%, 2.85) → 11 (13.3%); UX & support friction 12 (5.83%, 2.33) → 6 (7.2%); praise 50 (24.27%, 4.82) → 1 (1.2%); monetisation and reliability overlap on only 7 records (independent populations); 75 of 206 (36.4%) carry no negative theme — monetisation is 2.8× larger than reliability and produces 3.6× as many bad ratings; an engineering-led remediation plan would address the smaller problem

- **Where:** §3.2 Theme-family aggregates (verbatim table) — monetisation 87 (42.23%, 1.85) → 73.5% of 1–2★; reliability 31 (15.05%, 2.45) → 20.5%; feature gaps 27 (13.11%, 2.85) → 13.3%; UX & support 12 (5.83%, 2.33) → 7.2%; praise 50 (24.27%, 4.82) → 1.2%; monetisation and reliability overlap on only 7; 75 of 206 carry no negative theme; monetisation 2.8× larger and 3.6× as many bad ratings — an engineering-led plan addresses the smaller problem
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Family | n | % of 206 | Signal | Mean ★ | Share of all 83 one-/two-star reviews ; Monetization friction (18 themes) | 87 | 42.23% | high-priority | 1.85 | 61 / 83 = 73.5% ; Reliability defects (9 themes) | 31 | 15.05% | high-priority | 2.45 | 17 / 83 = 20.5% ; Feature gaps & requests (10 themes) | 27 | 13.11% | high-priority | 2.85 | 11 / 83 = 13.3% ; UX & support friction (7 themes) | 12 | 5.83% | high-priority | 2.33 | 6 / 83 = 7.2% ; Praise of any kind (15 themes) | 50 | 24.27% | high-priority | 4.82 | 1 / 83 = 1.2%
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R42-053 — A too-thin free tier is a negative demo, not a funnel: four reviewers independently — 'through it, all you manage to prove is that there's no reason to subscribe. There is absolutely nothing attractive to make me pay' (BR, 3★, the longest review, 10 helpful votes); 'There is absolutely nothing attractive that would make me pay the high price charged' (NZ, 1★); 'The free version is barely a taste of what can be done. And there are free apps out there that let you track so much more' (US, 3★); 'this doesn't even allow a test to see whether it's actually worth paying' (BR, 2★) — three habits is below the threshold at which a routine can be represented at all

- **Where:** §3.3.1 Four reviewers make the same structural argument — the free tier is so thin it functions as an anti-advertisement: 'through it, all you manage to prove is that there's no reason to subscribe' (BR, 3★, longest review, 10 votes); 'The free version is barely a taste… there are free apps out there that let you track so much more'; 'this doesn't even allow a test to see whether it's actually worth paying' — a negative demo
- **This app does:** 3-habit free tier
- **User reaction:** blocked-conversion
- **Magnitude:** 4 reviews
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `10991854727`, `11319751646`, `8568438754`, `10804399038`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R42-064 — The conversion path working as designed, described once in 206 reviews: 'a very simple and convenient app, all functions are clear, nothing extra, beautiful minimalist design (as a web designer this mattered especially to me), I searched a long time for the perfect app, and here I took out a yearly subscription in the first 15 minutes of use' (RU, 5★); 5★ drivers — simplicity 18 (21.7%), behaviour change 13 (15.7%), motivation 10, stats 6, reminders 6, design 3; but 28 of 83 are low_info and 17 are burst records, leaving 42 substantive 5★

- **Where:** §4.1 Five stars — simplicity 18 (21.7%), behaviour change 13, motivation 10, stats 6, reminders 6, design 3; 28 of 83 low_info and 17 burst — substantive 5★ content 42; the most informative 5★: 'I searched a long time for the perfect app, and here I took out a yearly subscription in the first 15 minutes of use' (a web designer, minimalism)
- **This app does:** minimal design converts in 15 minutes
- **User reaction:** purchase-driver
- **Magnitude:** substantive 5★ 42 of 83
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10832301711`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C185 Aesthetic and a polished onboarding convert; they do not retain

### R42-065 — The 4★ band lists the blockers between the product and enthusiasm — and is nearly empty: 12 reviews, ten naming one blocker (free cap 2, missing language 2, widget, paywalled reminders, stats bug, stats broken, regression, congrats pop-up, focus limit, missing advertised feature), 3 Ukrainian and 3 Russian — 'the app is great, light, minimalist, convenient, but it hasn't had Ukrainian for years and doesn't have widgets'

- **Where:** §4.2 Four stars — 12, ten name one blocker (paywall_cap 2, localisation 2, widget 1, reminders_paywalled 1, stats_bug 1, stats_broken 1, regression 1, congrats_popup 1, focus_habit_limit 1, missing_advertised_feature 1); 3 of 12 Ukrainian and 3 Russian; 'the app is great, light, minimalist, convenient, but it hasn't had Ukrainian for years and doesn't have widgets'
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 4★ 12 (5.8%)
- **Direction for us:** research · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10774694629`
- **Canonical:** — (nuance register)

### R42-066 — The 3★ band is the audience the paywall is losing — people who tried it, liked it and stopped: free cap 13 of 28 (46.4%), price 5, competitor 5, lag 4, payer 4, not worth it 3; 16 of 28 Brazilian (57.1%) — 'Right away I loved the app but I went to add one more habit and I couldn't'; 'The app is great but I'd like to be able to set a reminder without having to pay'; 'It's good, but you have to pay to do the basics'

- **Where:** §4.3 Three stars — overwhelmingly monetisation: paywall_cap 13 (46.4%), price 5, competitor 5, perf_lag 4, paid 4, value 3; 16 of 28 Brazilian (57.1%); 'Right away I loved the app but I went to add one more habit and I couldn't'; 'I'd like to be able to set a reminder without having to pay'; 'you have to pay to do the basics' — the audience the paywall is losing
- **This app does:** 3-habit cap; paid reminders
- **User reaction:** blocked-conversion
- **Magnitude:** 3★ 28; cap 46.4%; BR 57.1%
- **Direction for us:** product-rule · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10754787779`, `10901396387`, `12486211287`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C257 Never paywall reminders — it moves the comparison from 'which habit tracker' to 'why pay for an alarm'

### R42-067 — 2★ is the 3★ band plus performance problems: free cap 9 of 16 (56.3%), lag 4 (25.0%), subscription objection 2, price 2, payer 2, no trial 2, competitor 2; eight of 16 Brazilian; four pair the paywall or a purchase with freezing — including a two-year payer: 'I have the paid version, for the second year! To the administrators, if you could take a look, I'd appreciate it! I wouldn't want to migrate to another app'

- **Where:** §4.4 Two stars — paywall_cap 9 (56.3%), perf_lag 4 (25.0%); eight of sixteen Brazilian; the 3★ band with performance problems added; two-year payer 'I have the paid version, for the second year! … I wouldn't want to migrate to another app'
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 2★ 16; cap 56.3%; lag 25.0%
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10777125663`, `10980265104`, `11164675946`, `11501115720`
- **Canonical:** C083 Performance must not degrade with habit count

### R42-068 — 1★ splits into populations that need opposite fixes: never used the product (≈20, blocked at the paywall or the onboarding questionnaire) needs to see more before paying — a trial; paid and regret it (13) needs the product to be worth what it cost — multi-count, widgets, reliability; long-term users hit by a defect or a retroactive paywall (≈8); low-info venting (8); 49 of 67 1★ (73.1%) carry monetisation friction, 12 (17.9%) a reliability defect

- **Where:** §4.5 One star — 49 of 67 (73.1%) monetisation, 12 (17.9%) reliability; four populations: never used the product (~20), paid and regret it (13), long-term users hit by a defect or retroactive paywall (~8), low-info venting (8); populations 1 and 2 need opposite fixes — a trial for the first, multi-count / widgets / reliability for the second
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1★ 67; monetisation 73.1%; reliability 17.9%
- **Direction for us:** product-rule · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `10918059435`, `11319751646`, `8757372166`, `8868385470`, `11484449412`, `10824739497`, `9925506606`, `12452078000`, `11051247830`, `6276118032`, `7113224515`, `7295269143`, `7348111127`, `7669054186`, `10305077033`, `8668570025`, `12317660239`, `11826835199`, `12160321648`, `13143403370`, `13555244418`, `10053567444`, `11966692895`, `12018343239`, `14165208412`, `12021785730`, `13595332155`, `5510835449`, `9020161145`, `12023625574`, `11908917158`, `6525652247`, `13873441414`, `13995345240`, `7852240625`, `7023381511`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C147 Let people use the product before they pay

### R42-069 — There is no such thing as a mildly satisfied paying customer here: payers split 10×5★ vs 13×1★ with zero 4★; price objection never appears above 3★; lag centres on 2–3★ (it costs stars from people still trying, not abandonment); the congrats pop-up is an engaged-user annoyance (0/1/2/1/0), not a rage trigger; behaviour change (13/1/0/0/0) is the purest positive signal

- **Where:** §4.6 Theme × rating cross-tabulation (verbatim table) — price_objection never above 3★; paid_direct bimodal (10×5★, 13×1★) — no mildly satisfied paying customer; perf_lag centred on 2–3★ (frustrates people still trying); congrats_popup an engaged-user annoyance, not a rage trigger
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 5★ | 4★ | 3★ | 2★ | 1★ | Mean | Read ; paywall_cap | 3 | 2 | 13 | 9 | 28 | 1.96 | Dominates every band below 4★ ; price_objection | 0 | 0 | 5 | 2 | 11 | 1.67 | Never appears above 3★ ; no_trial | 0 | 0 | 1 | 2 | 11 | 1.29 | Lowest mean in the report ; paid_direct | 10 | 0 | 4 | 2 | 13 | 2.72 | Bimodal — payers love it or hate it ; refund_request | 0 | 0 | 1 | 1 | 9 | 1.27 | ; perf_lag | 1 | 1 | 4 | 4 | 2 | 2.58 | Centred on 2–3★, not 1★ ; outage_crash | 1 | 0 | 0 | 1 | 5 | 1.71 | ; data_loss | 0 | 0 | 1 | 0 | 5 | 1.33 | ; congrats_popup | 0 | 1 | 2 | 1 | 0 | 3.00 | An engaged-user annoyance, not a rage trigger ; localization_missing | 0 | 2 | 1 | 0 | 2 | 2.60 | ; multi_count_missing | 0 | 0 | 1 | 1 | 4 | 1.50 | ; praise_simplicity | 18 | 2 | 1 | 1 | 0 | 4.68 | ; praise_behaviour_change | 13 | 1 | 0 | 0 | 0 | 4.93 | Purest positive signal in the corpus ; praise_motivation | 10 | 0 | 0 | 0 | 0 | 5.00 | ; praise_stats | 6 | 0 | 1 | 0 | 0 | 4.71 |
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R42-074 — A premium that only unlocks quantity feels like nothing was bought: 5 of 29 payers (17.2%) say it wasn't worth it — 'I paid for the premium content, you can input habits, that's it, you can't adapt or customise them, I wasted 9.99 on this' (GB, rated 5★)

- **Where:** §5.4 5 of 29 payers (17.2%) say the paid product was not worth it — 'I paid for the premium content, you can input habits, that's it, you can't adapt or customise them, I wasted 9.99 on this'
- **This app does:** premium = more habits + basics
- **User reaction:** churn
- **Magnitude:** 5/29 (17.2%)
- **Direction for us:** research · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6276118032`, `6422725217`, `10305077033`, `12317660239`, `8668570025`
- **Canonical:** C133 Gate on capability, not on quantity; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R42-084 — Users accept subscribing but not a price out of line with delivery, and not canned replies: 'Do you realise that your audience's biggest dissatisfaction is the free tier, and even so it's notable that you haven't tried to improve on it. You just reply the same thing to everyone… As soon as a better app appears you'll lose the audience. I don't think it's wrong to have to subscribe, but the subscription price is unreal for what the app delivers.' (BR, 3★, 10 helpful votes, the second-most-upvoted review)

- **Where:** §6.2 The most strategically useful Brazilian review (3★, 10 votes, second-most-upvoted): 'your audience's biggest dissatisfaction is the free tier, and even so… you haven't tried to improve on it. You just reply the same thing to everyone… As soon as a better app appears you'll lose the audience. I don't think it's wrong to have to subscribe, but the subscription price is unreal for what the app delivers'
- **This app does:** canned replies; price vs value
- **User reaction:** churn
- **Magnitude:** n=1, 10 votes
- **Direction for us:** product-rule · **Report confidence:** anecdotal (high-signal) · **Generalisable:** yes
- **Review IDs:** `10991854727`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C064 Price level — where 'fair' turns into 'too expensive'

## Audiences

### R42-127 — High-income-market buyers reject the price on substance while a low-local-price market calls it trivial: '500₽ a year, that's nothing' (RU) vs '¥6,900 a year is expensive' (JP, both JP reviews 1★ on price), '$40 a year? … insane!' (US), 'R$79.90 for only 12 weeks' (BR) — the same product priced per storefront produces opposite audiences

- **Where:** §3.3.2 / §6.6 — price rejection differs by purchasing power: 500₽/yr 'that's nothing' (RU) vs ¥6,900 'expensive' (JP), $39.99 'insane' (US), R$79.90/12 weeks 'muito caro' (BR)
- **This app does:** per-storefront pricing
- **User reaction:** mixed
- **Magnitude:** RU 1 positive vs JP 2, US 2, BR 1 negative
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `10989878670`, `11948614593`, `13458230922`, `6881986270`, `9479819359`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C092 Regional pricing

### R42-128 — Paying customers here are concentrated in Brazil (10 of 29) and Russia (6) — and each market's payers hit a different failure: Brazilian payers freezing on the trophy modal, Russian payers a launch crash and wiped statistics, US payers a capability gap (multi-count)

- **Where:** §5.2 / §6.2 — payers are a Brazil- and Russia-heavy population: BR 10 · US 8 · RU 6 · VN 3; BR payers freezing, RU payers crashing
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** BR 10 · US 8 · RU 6 · VN 3 · TR 1 · GB 1
- **Direction for us:** research · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `11164675946`, `11501115720`, `12160321648`, `11826835199`, `7113224515`, `7669054186`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

## Markets and languages

### R42-076 — Russian users cannot pay at all — 'оплатить из рф способа нет' ('there's no way to pay from Russia', Jun 2026) — in the market with the worst defect exposure

- **Where:** §5.5 'there's no way to pay from Russia'
- **This app does:** no payment rail in RU
- **User reaction:** blocked-conversion
- **Magnitude:** n=1
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `14165208412`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK)

### R42-080 — Storefront distribution: Brazil 55 (26.70%, 2.818; 15/0/16/8/16) the only eligible; US 46 (2.913; 19/1/3/3/20) and Russia 36 (3.194) limited evidence; Vietnam 14 (3.714), Canada 12 (5.000, burst-contaminated), Türkiye 11 (3.364), Ukraine 8 (3.625); AR, BY, JP, PL, TH 2 each; 14 storefronts with 1; DE, AU, CN, TW, HK, SG queried with zero; BR + US + RU = 137 (66.5%)

- **Where:** §6.1 Distribution (verbatim table) — BR 55 (2.818; 15/0/16/8/16) eligible; US 46 (2.913), RU 36 (3.194) limited; VN 14 (3.714), CA 12 (5.000, burst), TR 11 (3.364), UA 8 (3.625); AR, BY, JP, PL, TH 2 each; 14 storefronts 1 each; DE, AU, CN, TW, HK, SG zero; BR + US + RU = 137 (66.5%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Country | n | % of corpus | Mean ★ | 5/4/3/2/1 | Eligible for standalone claims? ; 🇧🇷 Brazil | 55 | 26.70% | 2.818 | 15/0/16/8/16 | Yes (n ≥ 50) ; 🇺🇸 United States | 46 | 22.33% | 2.913 | 19/1/3/3/20 | No — limited evidence, near threshold ; 🇷🇺 Russia | 36 | 17.48% | 3.194 | 15/3/4/2/12 | No — limited evidence ; 🇻🇳 Vietnam | 14 | 6.80% | 3.714 | 7/2/2/0/3 | No — limited evidence ; 🇨🇦 Canada | 12 | 5.83% | 5.000 | 12/0/0/0/0 | No — and contaminated by a burst ; 🇹🇷 Türkiye | 11 | 5.34% | 3.364 | 5/2/0/0/4 | No — limited evidence ; 🇺🇦 Ukraine | 8 | 3.88% | 3.625 | 3/3/0/0/2 | No ; 🇦🇷 AR, 🇧🇾 BY, 🇯🇵 JP, 🇵🇱 PL, 🇹🇭 TH | 2 each | 0.97% each | — | — | No ; 🇦🇲 AM, 🇧🇴 BO, 🇨🇭 CH, 🇨🇴 CO, 🇨🇿 CZ, 🇩🇴 DO, 🇪🇸 ES, 🇫🇷 FR, 🇬🇧 GB, 🇮🇱 IL, 🇰🇷 KR, 🇱🇻 LV, 🇳🇴 NO, 🇳🇿 NZ | 1 each | 0.49% each | — | — | No ; 🇩🇪 DE, 🇦🇺 AU, 🇨🇳 CN, 🇹🇼 TW, 🇭🇰 HK, 🇸🇬 SG | 0 | — | — | — | Queried, returned nothing
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-081 — Brazil (n = 55, mean 2.818, the only eligible market) — no 4★ at all and the largest 3★ band (16 of the corpus's 28): free cap 23 (41.82% vs 26.70% global); payer 10 (18.18%); lag 9 (16.36% — 9 of the global 12); price 8 (14.55%); refund 5 (9.09%); deceptive free 4 (7.27%); value 3; churn 3; no trial 3; simplicity 3; praise 6 (10.91% vs 24.27%)

- **Where:** §6.2 Brazil — n = 55, mean 2.818 (verbatim table) — no 4★ at all; paywall_cap 23 (41.82%, +15.1pp); perf_lag 9 (16.36%, 9 of global 12); price 14.55%; refund 9.09%; deceptive_free 7.27%; praise 10.91% vs 24.27%
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of BR's 55 | vs global ; paywall_cap | 23 | 41.82% | 26.70% — +15.1pp ; paid_direct | 10 | 18.18% | 14.08% ; perf_lag | 9 | 16.36% | 5.83% — +10.5pp, 9 of the global 12 ; price_objection | 8 | 14.55% | 8.74% ; refund_request | 5 | 9.09% | 5.34% ; deceptive_free | 4 | 7.27% | 3.40% ; value_insufficient | 3 | 5.45% | 4.37% ; churn_risk | 3 | 5.45% | 2.91% ; no_trial | 3 | 5.45% | 6.80% ; praise_simplicity | 3 | 5.45% | 10.68% ; Praise of any kind | 6 | 10.91% | 24.27%
- **Direction for us:** research · **Report confidence:** BR standalone · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-082 — Brazilian users love the product and write complaints about access and freezing: the paywall complaint is loudest in Brazil (23 of 55, steady 2020 → 2026, 41.8% of the whole theme from a market that is 26.7% of the corpus); the characteristic 3★ is 'I love it, but' — 'I love the app. I paid to get more use of the pro features but it freezes so muuuuuch'; praise is only 10.9% because Brazilian reviewers are writing complaints, not because they dislike the app

- **Where:** §6.2 (a) Brazil is where the paywall complaint is loudest — 23 of 55, steady 2020 → 2026; (c) the most affectionate complaints ('Amo o app. Paguei para ter mais uso das funções pro só que ele trava demaaaaaaais') — praise only 10.9% because Brazilians write complaints, not because they dislike the product
- **This app does:** 3-habit cap; lag
- **User reaction:** mixed
- **Magnitude:** BR cap 41.8%; 16 of 28 3★
- **Direction for us:** product-rule · **Report confidence:** BR standalone · **Generalisable:** yes
- **Review IDs:** `6704352732`, `13890946850`, `10754787779`, `10901396387`, `12486211287`, `12133174175`, `11364850554`, `10834187654`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R42-083 — Performance problems concentrated in one market: 9 of the 12 lag reports are Brazilian, spanning Oct 2023 – Sep 2024 with a dense Jan–Jul 2024 cluster, four from payers — more consistent with a device-mix or network effect than a universal code path, but the corpus has no device field (research question)

- **Where:** §6.2 (b) Brazil is where the app runs badly — 9 of 12 perf_lag, Oct 2023 – Sep 2024, dense Jan–Jul 2024, 4 payers; more consistent with a device-mix or network effect than a universal code path — research question (no device field)
- **This app does:** lag
- **User reaction:** complaint
- **Magnitude:** 9 of 12 (BR 16.4%)
- **Direction for us:** research · **Report confidence:** BR standalone; interpretation labelled · **Generalisable:** yes
- **Review IDs:** `10460927334`, `11719440762`, `10777125663`, `10834187654`, `10980265104`, `11164675946`, `11501115720`, `11540202999`
- **Canonical:** C083 Performance must not degrade with habit count; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R42-085 — The US profile is the inverse of Brazil's (n = 46, limited evidence): complaints about what the product cannot do and how it behaves before use, not the cap — multi-count missing 6 (13.04%, all six global instances), onboarding length / upsell interstitials / premature rating prompts 7 combined (review prompt too early both global instances; upsell nag 6.52%), refund 8.70%, paywall cap only 10.87% (−15.8pp), price 4.35%, reliability 2; the most bimodal market (39 of 46 at an extreme) with only 8 substantive 5★; mean 2.913 → 2.600 without the burst

- **Where:** §6.3 United States — n = 46, mean 2.913, limited evidence (verbatim table) — most bimodal (39 of 46 at an extreme); substantive 5★ only 8; mean without burst 2.600 (n=40); multi_count_missing 6 (13.04%, all global); paywall_cap 5 (10.87%, −15.8pp); refund 8.70%; upsell_nag 6.52%; review_prompt_too_early both global; onboarding_long 2; reliability 2
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of US's 46 | vs global ; paid_direct | 8 | 17.39% | 14.08% ; multi_count_missing | 6 | 13.04% | 2.91% — all 6 global instances are US ; praise_simplicity | 5 | 10.87% | 10.68% ; paywall_cap | 5 | 10.87% | 26.70% — −15.8pp ; refund_request | 4 | 8.70% | 5.34% ; upsell_nag | 3 | 6.52% | 1.46% ; no_trial | 3 | 6.52% | 6.80% ; value_insufficient | 3 | 6.52% | 4.37% ; review_prompt_too_early | 2 | 4.35% | 0.97% — both global instances are US ; onboarding_long | 2 | 4.35% | 1.46% ; price_objection | 2 | 4.35% | 8.74% ; perf_lag / reliability | 2 | 4.35% | 15.05%
- **Direction for us:** research · **Report confidence:** limited evidence (n=46) · **Generalisable:** yes
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R42-086 — US written-review volume collapsed: 12 (2020) → 14 (2021) → 8 → 6 → 4 → 2 (2025) → 0 (2026) — reduced US acquisition or reduced prompting, unresolvable; the highest-spend market has produced two written reviews since the start of 2025

- **Where:** §6.3 US review volume is collapsing — 12 (2020) → 14 → 8 → 6 → 4 → 2 → 0 (2026); reduced acquisition or reduced prompting; the highest-spend market produced two written reviews since 2025
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 12 → 0
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-087 — Russia (n = 36, mean 3.194, limited evidence) is the most appreciative and most damaged market: praise 11 of 36 (30.6%) — reminders, minimalism, replacing paper notebooks, tracking expenses, colour-coded categories; launch crash 5 of the global 7 and data loss 4 of the global 6 — eight consecutive Russian reviews from 12 Oct 2024 to 11 Jan 2025 are defect reports (habits disappearing, check-off dead then total wipe, progress invisible, won't open); users cannot pay from Russia at all, so it should not be receiving paywall tightening; Russian-language support was the original wedge ('the competitor has no Russian'); two Russian reviewers raised their ratings after fixes

- **Where:** §6.4 Russia — n = 36, mean 3.194, limited evidence (verbatim table) — highest mean of the three majors and worst reliability; outage_crash 5 of 7; data_loss 4 of 6; praise 30.6% (reminders, minimalism, replacing paper notebooks, tracking expenses, colour categories); eight consecutive Russian reviews 12 Oct 2024 – 11 Jan 2025 are defect reports; cannot pay from Russia — should not be receiving paywall-tightening; Russian-language support was the original differentiator; two returned to raise ratings after fixes
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of RU's 36 | vs global ; paywall_cap | 7 | 19.44% | 26.70% ; praise_simplicity | 6 | 16.67% | 10.68% ; paid_direct | 6 | 16.67% | 14.08% ; outage_crash | 5 | 13.89% | 3.40% — 5 of the global 7 ; competitor_mention | 5 | 13.89% | 6.31% ; data_loss | 4 | 11.11% | 2.91% — 4 of the global 6 ; regression_after_update | 3 | 8.33% | 3.88% ; praise_reminders | 3 | 8.33% | 2.91% ; praise_behaviour_change | 3 | 8.33% | 6.80%
- **Direction for us:** research · **Report confidence:** limited evidence (n=36) · **Generalisable:** yes
- **Review IDs:** `5995999324`, `5110718900`, `6026946756`, `12023625574`, `12135350485`, `12144367844`, `12160321648`, `12172502326`, `11826835199`, `12018343239`, `11966692895`, `14165208412`, `5629089340`, `10474969732`, `12890217155`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C027 Localise early — it unlocks revenue; C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change

### R42-089 — A $39.99–$59.99 app barely present in high-spend markets, and rated worst there: US 46, CA 12, JP 2, GB 1, FR 1, KR 1 (Germany, Australia, China zero) = 63 (30.58%), 58 from US + Canada (one a burst); excluding bursts the group averages 2.587 (n = 46) vs a burst-adjusted 2.968 global; free-cap share only 11.1% (vs 33.6% elsewhere) and reliability 3.2% (vs 20.3%) — high-spend users are not price-blocked, they evaluate against category expectations (multi-count logging, widgets, customisation) and reject on capability

- **Where:** §6.6 High-spend market group (verbatim table) — US 46, CA 12, JP 2, GB 1, FR 1, KR 1; DE, AU, CN zero; 63 (30.58%); mean 3.238, excluding bursts 2.587 (n=46) — the worst-rated segment; paywall_cap 11.1% vs 33.6%; reliability 3.2% vs 20.3%; payer 14.3% vs 14.0% — barely present in high-spend markets; high-spend users reject on capability (multi-count, widgets, customisation), not price
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Metric | High-spend group | Rest of corpus ; Present in corpus | US 46, CA 12, JP 2, GB 1, FR 1, KR 1 — DE, AU, CN: zero | ; n | 63 (30.58%) | 143 (69.42%) ; Mean ★ | 3.238 | 3.091 ; Mean ★ excluding both bursts | 2.587 (n=46) | — ; 5/4/3/2/1 | 32/1/3/4/23 | 51/11/25/12/44 ; Monetization friction | 22 (34.9%) | 65 (45.5%) ; paywall_cap | 7 (11.1%) | 48 (33.6%) ; price_objection | 4 (6.3%) | 14 (9.8%) ; Reliability | 2 (3.2%) | 29 (20.3%) ; paid_direct | 9 (14.3%) | 20 (14.0%)
- **Direction for us:** research · **Report confidence:** group (external definition) · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R42-090 — Japan (n = 2, limited evidence): both reviews 1★, both about price — 'task repetition is paid-plan only and ¥6,900 a year is expensive'; 'ふざけてる :: たかい' ('Ridiculous :: Expensive') — worth a look for a top-three spend market, no finding claimed

- **Where:** §6.6 Japan (n=2, limited evidence) — both 1★ and both about price: 'task repetition is paid-plan only and ¥6,900 a year is expensive'; 'Ridiculous :: Expensive'
- **This app does:** ¥6,900/yr
- **User reaction:** complaint
- **Magnitude:** 2 (both 1★)
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `11948614593`, `13458230922`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R42-091 — Where the app has no scale, first contact is the paywall and the outcome is a 1★: the 20 long-tail storefronts (32 records) show free-cap complaints 46.9% (vs 23.0% in the six ≥ 10-review storefronts), monetisation friction 56.3% (vs 39.7%), price 15.6% (vs 7.5%), payer evidence 1 of 32 (3.1%, who regrets it, vs 16.1%) and mean 2.906 (vs 3.178) — an uncontrolled A/B test of paywall-first onboarding with no trial

- **Where:** §6.7 High-review-volume market group (verbatim table) — BR, US, RU, VN, CA, TR = 174 (84.47%); mean 3.178 vs 2.906; the 20 long-tail storefronts (32 records) are almost purely a paywall story: paywall_cap 46.9%, one payer (who regrets it) — an uncontrolled A/B test of paywall-first onboarding with no trial, result 2.906
- **This app does:** paywall-first, no trial
- **User reaction:** 1★-burst
- **Magnitude:** Metric | High-volume group (n=174) | Rest of world (n=32) ; Mean ★ | 3.178 | 2.906 ; Monetization friction | 69 (39.7%) | 18 (56.3%) ; paywall_cap | 40 (23.0%) | 15 (46.9%) ; price_objection | 13 (7.5%) | 5 (15.6%) ; Reliability | 28 (16.1%) | 3 (9.4%) ; paid_direct | 28 (16.1%) | 1 (3.1%)
- **Direction for us:** product-rule · **Report confidence:** limited evidence per country, consistent across 20 · **Generalisable:** yes
- **Review IDs:** `12452078000`, `10086792760`, `8102592409`, `11051247830`, `10155196420`, `10495503059`, `9775946178`, `11319751646`, `13256129945`, `12472128598`, `10498159047`, `12666033997`, `11186327600`, `11948614593`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C147 Let people use the product before they pay

### R42-092 — Serving a Russian interface to Ukrainian users while the listing claims Ukrainian is a market-specific risk: three of Ukraine's eight reviews (37.5%) raise it (Jan 2024 – Feb 2025) — 'Preview on AppStore was on Ukrainian, I don't like that it's on russian at the moment'; 'Add Ukrainian' — corroborated by the listing claiming Ukrainian, and by Israel reporting the same for Hebrew

- **Where:** §6.8 Ukraine — limited evidence (n=8), one material finding: three of eight (37.5%) say the interface is not available in Ukrainian and at least one is served Russian; corroborated externally — the listing lists Ukrainian (and Hebrew) — a listing accuracy issue with two confirmed languages, not a localisation backlog
- **This app does:** listing claims Ukrainian
- **User reaction:** complaint
- **Magnitude:** 3/8 UA (37.5%)
- **Direction for us:** must-never-break · **Report confidence:** limited evidence + external corroboration · **Generalisable:** yes
- **Review IDs:** `10774694629`, `11620239635`, `12362076952`, `7882790956`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C255 An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language

### R42-093 — Other storefronts (limited evidence): Vietnam 14 (mean 3.714; 7 one-word reviews; a payer asking for widgets; a 499k₫ charge without trialling); Türkiye 11 (3.364; both retroactive-paywall reports and a clear statistics purchase trigger); Poland 2 (both paywall, one post-update); single-review storefronts used only in global aggregates

- **Where:** §6.9 Other sub-50 storefronts — Vietnam (14, 3.714; 7 low_info; payer widget request; charged 499k₫ without trialling); Türkiye (11, 3.364; both retroactive_paywall reports; a clear purchase trigger); Poland (2, both paywall, one post-update); singles recorded in §9.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** VN 14; TR 11; PL 2
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `9615589336`, `13143403370`, `12021785730`, `13595332155`, `13760625758`, `12472128598`
- **Canonical:** — (nuance register)

## Dated events and trends

### R42-014 — A launch-blocking regression stayed visible for five weeks: 7 reviews (3.40%, mean 1.71) report the app not opening, 5 of them Russian inside 40 days (4 Dec 2024 'Second day the app doesn't work!' → 11 Jan 2025 'iPhone 13 pro max, ios 17.6.1 app crashes on start'), including a payer three months into an annual subscription — 'Three months passed and the app doesn't open at all. Give my money back, crooks.' (1★, edited); Russia is also the market where users report being unable to pay at all

- **Where:** Executive summary #5 — launch-blocking regression Dec 2024 – Jan 2025: outage_crash 7 (3.40%, very strong, mean 1.71), 5 of 7 Russian inside 40 days; a payer three months into an annual subscription ('Три месяца и приложение не открывается вообще. Верните деньги, жулики'); Russia also where users cannot pay at all
- **This app does:** launch crash Dec 2024 – Jan 2025
- **User reaction:** 1★-burst
- **Magnitude:** 7 (3.40%), 1.71; 5 RU in 40 days
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12023625574`, `12135350485`, `12144367844`, `12160321648`, `12172502326`, `14165208412`
- **Canonical:** C031 Crashes / launch failures; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R42-020 — A tightening paywall and falling engineering quality compound: mean by year 2020 3.96 → 2021 3.68 → 2022 3.32 → 2023 3.00 → 2024 2.73 → 2025 2.69 → 2026 1.57 (n = 7, directional); 2019–2022 (n = 89) 3.67 vs 2023–2026 (n = 117) 2.73; across the split paywall complaints 15.7% → 35.0%, reliability complaints 2.2% → 24.8%, praise of any kind 38.2% → 13.7% — neither trend reversed

- **Where:** Executive summary #11 — everything got worse after 2022, monotonic: 2020 3.96 → 2021 3.68 → 2022 3.32 → 2023 3.00 → 2024 2.73 → 2025 2.69 → 2026 1.57 (n=7); 2019–2022 (89) 3.67 vs 2023–2026 (117) 2.73; paywall 15.7% → 35.0%; reliability 2.2% → 24.8%; praise 38.2% → 13.7%
- **This app does:** tightening paywall + regressions
- **User reaction:** 1★-burst
- **Magnitude:** 3.67 → 2.73; paywall 15.7 → 35.0%; reliability 2.2 → 24.8%; praise 38.2 → 13.7%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set

### R42-023 — Year table: 2019 1 (5.00); 2020 26 (3.96; 17/1/3/0/5); 2021 37 (3.68; 24/0/1/1/11); 2022 25 (3.32); 2023 33 (3.00); 2024 48 (2.73; 23.3% of corpus); 2025 29 (2.69); 2026 7 (1.57; 6 of 7 1★); excluding the bursts 2020 3.65 (n = 20) and 2021 3.12 (n = 26) — the decline is real but shallower at the start and steeper at the end

- **Where:** §1.4 Date range and shape (verbatim year table) — first review 9 Nov 2019 'I trained myself to track my spending daily'; last 10 Jun 2026 statistics wiped + cannot pay from Russia; excluding bursts 2020 3.65, 2021 3.12 — decline real but shallower at start, steeper at end
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | % of corpus | Mean ★ | 5★ | 4★ | 3★ | 2★ | 1★ ; 2019 (from 9 Nov) | 1 | 0.5% | 5.00 | 1 | 0 | 0 | 0 | 0 ; 2020 | 26 | 12.6% | 3.96 | 17 | 1 | 3 | 0 | 5 ; 2021 | 37 | 18.0% | 3.68 | 24 | 0 | 1 | 1 | 11 ; 2022 | 25 | 12.1% | 3.32 | 9 | 4 | 4 | 2 | 6 ; 2023 | 33 | 16.0% | 3.00 | 11 | 3 | 5 | 3 | 11 ; 2024 | 48 | 23.3% | 2.73 | 12 | 3 | 9 | 8 | 16 ; 2025 | 29 | 14.1% | 2.69 | 8 | 1 | 6 | 2 | 12 ; 2026 (to 10 Jun) | 7 | 3.4% | 1.57 | 1 | 0 | 0 | 0 | 6
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `5110718900`, `14165208412`
- **Canonical:** — (nuance register)

### R42-094 — Two-era split at 1 Jan 2023 (89 vs 117): mean 3.67 → 2.73 (−0.94); free cap 15.7% → 35.0% (+19.3pp); price 6.7% → 10.3%; monetisation friction 32.6% → 49.6% (+17.0pp); reliability 2.2% → 24.8% (+22.6pp); praise 38.2% → 13.7% (−24.5pp); payers 9.0% → 17.9%; no trend claimed where n < 10 in either period

- **Where:** §7.1 Method — annual series plus a two-era split at 1 Jan 2023 (89 vs 117) (verbatim table): mean 3.67 → 2.73 (−0.94); paywall_cap 15.7 → 35.0% (+19.3pp); price 6.7 → 10.3%; monetisation friction 32.6 → 49.6% (+17.0pp); reliability 2.2 → 24.8% (+22.6pp); praise 38.2 → 13.7% (−24.5pp); paid_direct 9.0 → 17.9%; no trend where n < 10
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Metric | 2019–2022 (n=89) | 2023–2026 (n=117) | Change ; Mean rating | 3.67 | 2.73 | −0.94 ; paywall_cap | 14 (15.7%) | 41 (35.0%) | +19.3pp ; price_objection | 6 (6.7%) | 12 (10.3%) | +3.6pp ; Monetization friction (union) | 29 (32.6%) | 58 (49.6%) | +17.0pp ; Reliability (union) | 2 (2.2%) | 29 (24.8%) | +22.6pp ; Praise (union) | 34 (38.2%) | 16 (13.7%) | −24.5pp ; paid_direct | 8 (9.0%) | 21 (17.9%) | +8.9pp
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-095 — The most robust trend: every year lower than the last — 2020 3.96 → 2021 3.68 → 2022 3.32 → 2023 3.00 → 2024 2.73 → 2025 2.69 → 2026 1.57 (one flat year), n ≥ 25 each year 2020–2025; burst adjustment (3.65, 3.12) removes early steepness, not direction; driven by paywall and reliability moving together

- **Where:** §7.2 Trend 1 — rating decline monotonic across six years (3.96 → 3.68 → 3.32 → 3.00 → 2.73 → 2.69 → 1.57); burst-adjusted 2020 3.65, 2021 3.12 removes early steepness but not direction; driven by two independent themes moving together — the most robust trend
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 3.96 → 1.57
- **Direction for us:** product-rule · **Report confidence:** worsening, high confidence · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R42-096 — Progressive free-tier tightening: paywall complaints as a share of each year 2020 7.7% (2/26) → 2021 13.5% → 2022 28.0% → 2023 33.3% → 2024 35.4% → 2025 31.0% → 2026 57.1% (4/7, directional), above 28% for five consecutive years; three eyewitnesses name features moving from free to paid (TR Dec 2024, PL Mar 2025, TR Jan 2026 — a returning lapsed user) — consistent with tightening rather than falling tolerance (no version history to exclude it)

- **Where:** §7.3 Trend 2 — paywall complaint more than doubled: 7.7% (2020) → 13.5 → 28.0 → 33.3 → 35.4 → 31.0 → 57.1% (2026, 4/7); above 28% for five years; three eyewitnesses name features moving from free to paid (the last a returning lapsed user) — consistent with progressive tightening, no version history to exclude falling tolerance
- **This app does:** free tier tightened
- **User reaction:** complaint
- **Magnitude:** 7.7 → 35.4 → 57.1%
- **Direction for us:** product-rule · **Report confidence:** worsening, high confidence · **Generalisable:** yes
- **Review IDs:** `12021785730`, `12472128598`, `13595332155`
- **Canonical:** C001 Never move a free feature behind the paywall

### R42-097 — A reliability collapse in 2024 partly recovered: reliability share 2020 3.8% → 2021 0.0% → 2022 4.0% → 2023 9.1% → 2024 39.6% (19 of 48) → 2025 20.7% → 2026 14.3%; 2024 holds both the Brazilian lag cluster (Jan–Sep) and the start of the Russian launch-crash cluster (Oct 2024 – Jan 2025); two payers document fixes landing and returned — a specific bad period rather than terminal decay, yet the newest review (Jun 2026) is still a data-loss report

- **Where:** §7.4 Trend 3 — reliability collapsed after 2023: 3.8% (2020) → 0.0 → 4.0 → 9.1 → 39.6% (2024, 19/48) → 20.7 → 14.3%; 2024 holds the Brazilian lag cluster and the start of the Russian crash cluster; two payers document fixes landing — a bad period rather than terminal decay, but the newest review (Jun 2026) is still data loss
- **This app does:** 2024 regressions
- **User reaction:** 1★-burst
- **Magnitude:** 9.1% → 39.6% → 20.7%
- **Direction for us:** must-never-break · **Report confidence:** high confidence · **Generalisable:** yes
- **Review IDs:** `10474969732`, `12890217155`, `14165208412`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C175 Updates must not break function or wipe progress

### R42-098 — Praise did not disappear, the negative population tripled around it: praise share 2020 50.0% → 2021 40.5% → 2022 20.0% → 2023 12.1% → 2024 14.6% → 2025 13.8% → 2026 14.3% (burst-adjusted 2020 40.0%, 2021 30.8%) — the cliff is between 2021 and 2022, then flat at 12–15% for four years

- **Where:** §7.5 Trend 4 — praise collapsed: 50.0% (2020) → 40.5 → 20.0 → 12.1 → 14.6 → 13.8 → 14.3%; burst-adjusted 2020 40.0%, 2021 30.8%; cliff between 2021 and 2022; flat at 12–15% four years — the positive population stabilised at one in seven, the negative population tripled around it
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 50.0 → 14.3%
- **Direction for us:** none · **Report confidence:** high confidence · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-099 — Payer complaints are current and rising, not legacy: payer share of reviewers 2020 11.5% → 10.8 → 4.0 → 15.2 → 16.7 → 2025 24.1% → 2026 14.3% (era 9.0% → 17.9%); 16 of 29 payer reviews (55%) are from 2024 or later — consistent with aggressive monetisation pulling people through the purchase or a free tier so thin only buyers stay long enough to form an opinion

- **Where:** §7.6 Trend 5 — direct payers a growing share of reviewers: 11.5% → 10.8 → 4.0 → 15.2 → 16.7 → 24.1% (2025) → 14.3%; era 9.0 → 17.9%; consistent with more aggressive monetisation pulling people through or a free tier so thin only buyers stay; 16 of 29 payer reviews (55%) from 2024 or later — current, not legacy
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 9.0% → 17.9%; 55% since 2024
- **Direction for us:** research · **Report confidence:** emerging, medium · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R42-100 — Refund requests arrived by two routes five years apart: 2021's four were all capability gaps ('the product doesn't do what I bought it for' — multi-count, recurring reminders, an unexpected charge); 2024–25's six were all 'the product broke after I paid' or 'the trial trapped me' — a reliability and billing-mechanics gap

- **Where:** §7.7 Trend 6 — refund-seeking: 4 in 2021 (all 'the product doesn't do what I bought it for' — multi-count, recurring reminders, unexpected charge), 1 in 2023, 3 in 2024–25 and 3 in 2025 (all 'broke after I paid' or 'the trial trapped me') — the same outcome by two routes five years apart: a capability gap, then a reliability and billing-mechanics gap
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 2021 4; 2023 1; 2024–25 6
- **Direction for us:** must-never-break · **Report confidence:** worsening, medium · **Generalisable:** yes
- **Review IDs:** `7113224515`, `7295269143`, `7348111127`, `7669054186`, `11164675946`, `11826835199`, `12160321648`, `12317660239`, `12413759685`, `13555244418`
- **Canonical:** C029 Billing must be exactly right; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R42-101 — The review base moved from the US to Brazil and Russia: US reviews by year 12, 14, 8, 6, 4, 2, 0; Brazil 1, 3, 10, 9, 18, 12, 2; Russia 8 (2020), 1, 1, 5, 13, 6, 1 — the US led through 2021, Brazil from 2022, Russia second in 2024; by 2025 the US was 2 of 29 (6.9%); the recent corpus where all the reliability and paywall evidence lives is a Brazilian and Russian experience (could be where prompts fire)

- **Where:** §7.8 Trend 7 — geographic centre of gravity moved to Brazil and Russia: US 12, 14, 8, 6, 4, 2, 0; BR 1, 3, 10, 9, 18, 12, 2; RU 8, 1, 1, 5, 13, 6, 1; the recent corpus (all the reliability and paywall evidence) describes a predominantly Brazilian and Russian experience
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** US 12 → 0; BR 1 → 18 → 12
- **Direction for us:** research · **Report confidence:** persistent, high confidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-102 — What held: simplicity praise across seven years and six languages ('nothing extra', 'no fluff', 'not over-engineered') — the durable asset; the number 3 cited as the cap every year 2022–2026 — four years of the same complaint about the same number; behaviour-change stories in every era — 'We live in a world of scrolls, 15-second videos and endless content. Downloading this app was a find for my routine' (BR, 2025)

- **Where:** §7.9 What did not change — simplicity praise stable across seven years and six languages ('nothing extra', 'no fluff', 'not over-engineered') — the durable asset; the 3-habit number never changes (cited 2022–2026); behaviour-change stories every era ('We live in a world of scrolls, 15-second videos and endless content. Downloading this app was a find for my routine')
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** seven years
- **Direction for us:** product-rule · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `5995999324`, `6026946756`, `7318341303`, `7192572245`, `8315962338`, `10832301711`, `13138307431`, `8757084304`, `10194166127`, `10918059435`, `11120549627`, `12133174175`, `12388272937`, `13852099012`, `12611253383`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C007 Generous fixed habit cap (or unlimited) — never change it

## Positioning

### R42-001 — Daily Habit & Routine Tracker (App Store ID 1477345602, 'Goals planner. Productive days') by CREATIVE TECHNOLOGIES LLC — freemium with a hard 3-habit free cap plus paywalls on reminders, scheduling, repetition and history; listing (11 Sep 2026) shows seven IAPs — Habit Tracker Pro $39.99, Habit Tracker Premium $39.99, Habit Tracker Pro $59.99, Habit tracker $59.99, Habit tracker $39.99, Habits of Health Pro $9.99, My challenge tracker + $4.99; no lifetime tier identifiable; listing aggregate 4.6★ from 4.7K ratings; 36 languages listed

- **Where:** header lines 1-8
- **This app does:** developer CREATIVE TECHNOLOGIES LLC; bundle net.habittracker; extracted 8 Sep 2026; analysed 11 Sep 2026; store rank 42; listing latest version 4.7.1 (22 Aug 2025)
- **User reaction:** complaint
- **Magnitude:** 206 written reviews · 26 storefronts · 9 Nov 2019 → 10 Jun 2026; mean 3.136; 5:83 / 4:12 / 3:28 / 2:16 / 1:67
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C003 Lead with a one-time lifetime purchase; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R42-037 — Competitor named or implied 13 (6.31%, mean 2.54; 2/0/5/2/4) — including a HabitBull migrant lost at the wall

- **Where:** §3.1 master table #7 competitor_mention
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 13 (6.31%), 2.54
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against

### R42-048 — 'My phone already does this' 3 (1.46%, mean 2.33) — 'Your alarm or reminder on your phone can do everything this app does'

- **Where:** §3.1 master table #34 competitor_native
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 3 (1.46%), 2.33
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone; C257 Never paywall reminders — it moves the comparison from 'which habit tracker' to 'why pay for an alarm'

### R42-078 — Competitive frame: 13 references (6.31%, mean 2.54) — an active HabitBull migrant; 'they copied the program from habit tracker (which has no Russian)' identifies Russian-language support as the original wedge in Russia; generic free competitors ('there are loads like this and free'; 'there are free apps out there that let you track so much more'); only 2 chose it after testing others ('I tried maybe a dozen different apps and settled on this one', one inside the Canadian burst)

- **Where:** §5.7 Competitive position — 13 (6.31%, mean 2.54): HabitBull migrant; 'they copied the program from habit tracker (which has no Russian)' — Russian support was the original wedge; generic free competitors ('there are loads like this and free'); 2 chose this app after testing others ('I tried maybe a dozen different apps and settled on this one')
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 13 (6.31%), 2.54; praise_comparison 2
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10495503059`, `5629089340`, `10858646325`, `8568438754`, `7318347522`, `13138307431`
- **Canonical:** C005 Know which competitors buyers compare against; C027 Localise early — it unlocks revenue

## Anti-patterns

### R42-130 — A stacked monetisation design with a measured cost: a 3-habit cap with reminders, time, date and repetition paid; no visible trial and a paywall 'two seconds after downloading'; a ~15–30-screen unskippable onboarding quiz with a rating prompt inside it; packages auto-selected and charged, a promotional price not honoured at checkout, a trial that converts with refunds refused; and free features later paywalled on an installed base — together 87 reviews (42.23%, mean 1.85) and 73.5% of all 1–2★, with 37.9% of writing payers asking for refunds and a written-review mean that fell from 3.96 to 2.69

- **Where:** §2.2 / §3.3.5 / §5.5 — the whole monetisation design as an anti-pattern: 3-habit cap + paid reminders/time/date + no visible trial + immediate paywall + ~30-screen onboarding quiz + rating prompt before use + auto-selected package charges + promo price not honoured + retroactive paywalling
- **This app does:** stacked friction
- **User reaction:** 1★-burst
- **Magnitude:** 87 (42.23%), 1.85; 73.5% of 1–2★; refunds 11/29
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8868385470`, `11484449412`, `9489050651`, `7348111127`, `13143403370`, `12815733039`, `13555244418`, `12021785730`
- **Canonical:** C001 Never move a free feature behind the paywall; C029 Billing must be exactly right; C147 Let people use the product before they pay

## Things not to do

### R42-016 — Never force a celebration modal on every check-off — make it optional: 4 reviews (1.94%, mean 3.00) — 'Please let the user manage that Congrats popup in settings… there is some annoying popup where I have to press Continue just to close that stupid popup' (UA, 4★); frequency and blocking (RU); performance (BR); 'The congratulations messages are not coherent!!!' (BR) — a settings toggle neutralises all four, the lowest-cost improvement in the report

- **Where:** Executive summary #7 — the congratulations modal is a standalone UX defect: 4 (1.94%, meaningful, mean 3.00) — 'Please let the user manage that Congrats popup in settings… I have to press Continue just to close that stupid popup'; 'The congratulations messages are not coherent!!!'; a settings toggle neutralises all four — the lowest-cost improvement
- **This app does:** mandatory congrats popup
- **User reaction:** complaint
- **Magnitude:** 4 (1.94%), 3.00
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9211593813`, `11476120833`, `11164675946`, `8890054521`
- **Canonical:** C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

### R42-042 — 'Free' listing felt misleading 7 (3.40%, mean 1.43; 5 1★) — 'They don't mention the ongoing subscription fee!'

- **Where:** §3.1 master table #15 deceptive_free
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 7 (3.40%), 1.43
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C181 If the app is paid-only, say so in the subtitle and first screenshot; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R42-045 — Repeated upgrade interstitials 3 (1.46%, mean 1.67)

- **Where:** §3.1 master table #29 upsell_nag
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 3 (1.46%), 1.67
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R42-059 — Never make onboarding an unskippable questionnaire: 3 reviews, all 1★ — 'I have never had so many setup screens trying to get an app open before. Endless screens asking unnecessary questions with no option to skip. I deleted the app after about 15 non-shippable screens, never got to use it' (US); 'it asks so many annoying questions (about 30 before I gave up) that I abandoned the program without managing to test it' (BR); premium pop-ups 'annoying and difficult to click out of' (US, 3★, with a text-size accessibility complaint)

- **Where:** §3.3.5 Onboarding and the review prompt — 3 + 2 reviews, all 1★ (mean 1.00): 'Endless screens asking unnecessary questions with no option to skip. I deleted the app after about 15 non-shippable screens, never got to use it'; 'about 30 [questions] before I gave up'
- **This app does:** long onboarding quiz
- **User reaction:** 1★-burst
- **Magnitude:** onboarding_long 3 (1.00)
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11484449412`, `8559036422`, `12193961715`
- **Canonical:** C075 Skippable, replayable onboarding tour; C111 No long quiz before the price; show the price up front

### R42-060 — A rating prompt before use manufactures 1★ reviews: 'I'm still answering the questions and a window pop up asking if I'm enjoying the app? Really?' (US, 1★); 'Asking for a rating the first time I log in? How could I possibly know. But, since I'm being asked I must give it a one star.' (US, 1★) — the clearest causal chain in the corpus

- **Where:** §3.3.5 The review prompt during onboarding — 'I'm still answering the questions and a window pop up asking if I'm enjoying the app? Really?'; 'Asking for a rating the first time I log in? How could I possibly know. But, since I'm being asked I must give it a one star' — the review-prompt trigger is directly manufacturing one-star reviews
- **This app does:** rating prompt during onboarding
- **User reaction:** 1★-burst
- **Magnitude:** review_prompt_too_early 2 (1.00)
- **Direction for us:** dont · **Report confidence:** emerging; causal · **Generalisable:** yes
- **Review IDs:** `9547322919`, `9489050651`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R42-062 — Do not advertise a feature the product lacks: a reviewer looked for the 'goal for the day' shown in marketing and could not find it (1)

- **Where:** §3.4 'Goal for the day' as advertised — a feature promised in marketing not found
- **This app does:** advertised feature absent
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `8653967908`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R42-104 — Make the completion-celebration modal dismissible and add a settings toggle — the cheapest item in the report, and it removes a documented contributor to the Brazilian performance complaints

- **Where:** §8.1 F2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** congrats_popup 4 (3.00)
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9211593813`, `11476120833`, `11164675946`, `8890054521`
- **Canonical:** C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

### R42-105 — Remove the review prompt from the onboarding flow — it directly manufactures 1★ reviews at zero product cost to fix

- **Where:** §8.1 F3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** review_prompt_too_early 2, both 1★
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9489050651`, `9547322919`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R42-106 — Cut the onboarding questionnaire and add a skip control — three reviewers were lost before first use (~15 and ~30 screens, independently verifiable)

- **Where:** §8.1 F4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** onboarding_long 3 (1.00)
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11484449412`, `8559036422`
- **Canonical:** C111 No long quiz before the price; show the price up front

### R42-126 — Do not respond to a paywall problem with engineering or features: don't add features to the core loop (simplicity praise 22, mean 4.68, stable seven years — complaints are about access, reliability and two missing primitives, not the app being too simple); don't treat a 4.6★ aggregate as evidence all is fine; don't read a burst-inflated market as a win; don't fix bugs first and call it a turnaround — reliability is 20.5% of bad ratings, monetisation friction 73.5%

- **Where:** §8.5 What not to change — don't add features to the core loop (simplicity 22, mean 4.68, seven years, six languages; the complaints are about access, reliability and two missing primitives, not about the app being too simple); don't treat the 4.6★ aggregate as evidence this is fine; don't read Canada's 5.00 as a market win; don't fix bugs first and call it a turnaround (reliability 20.5% of bad ratings vs monetisation 73.5%)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** reliability 20.5% vs monetisation 73.5%
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `5995999324`, `10387592776`, `7318341303`, `7700270494`, `13138307431`, `6026946756`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C006 Stay minimal — every addition is opt-in or off by default

## Things to do

### R42-022 — Cheapest high-value moves in evidence order: ship a real time-boxed full-feature trial (14 name its absence, mean 1.29) → raise the free cap from 3 to a number where a routine is demonstrable (55) → add multi-count-per-day for water / meals / reps (6, 2 refund-seeking payers) → make the congratulations modal dismissible / optional (4, cheapest) → fix the launch-crash and data-loss path with visible backup / restore (7 crash + 6 data loss) → fix or remove the Hebrew and Ukrainian listing claims (5, a factual misstatement) → stop paywalling reminders specifically (5, the single feature most often named behind the wall) → give payers an in-app support path that does not require the Mail app

- **Where:** Executive summary #13 — the cheapest high-value moves, in evidence order
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as stated
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11826835199`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C031 Crashes / launch failures; C036 A support channel that exists, is reachable outside the app, and answers; C063 Free trial before purchase; C143 Intra-day completion: tap N times to fill N/N; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap; C257 Never paywall reminders — it moves the comparison from 'which habit tracker' to 'why pay for an alarm'

## Contradictions

### R42-129 — The store aggregate contradicts the written corpus: 4.6★ from 4.7K ratings vs a 3.136 written-review mean (2.968 without the two bursts) falling every year from 3.96 to 2.69 — the prompted-rating flow and the written-review flow sample different populations; the aggregate must not be read as evidence the product is fine

- **Where:** Warning 2 / §8.5 — a 4.6★ store aggregate from 4.7K ratings coexisting with a 3.136 written-review mean (2.968 burst-adjusted) and a monotonic decline
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 4.6 (4.7K) vs 3.136 (206)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** — (nuance register)

## Data caveats and method

### R42-002 — Method: all 206 reviews read individually in full, sorted by country then date, in their original languages (Portuguese 55, Russian ~36, Vietnamese 14, Turkish 11, Ukrainian 8, plus Spanish, Japanese, Hebrew, Korean, Thai, Czech, Polish, Norwegian, French); 71 product themes + 3 meta labels hand-assigned as explicit ID lists, validated programmatically (zero unknown IDs, zero intra-theme duplicates, zero unassigned); every theme with n ≥ 4 re-read after aggregation; bands <0.1 ignore · 0.1–0.5 weak · 0.5–1 emerging · 1–3 meaningful · 3–5 very strong · >5 high-priority, denominator 206 (one review = 0.49%, n=2 already 'emerging', nothing below n=5 carries a recommendation alone); 39 records only low_info; reconciliation exact (206 lines = parsed = unique = country files; manifest 206 / 26 / 3.136 / 5:83 4:12 3:28 2:16 1:67 reproduced); one exact text duplicate pair ('Ok'/'Ok', VN, 16 months apart) retained; votes — 156 zero, non-zero median 1 (used only to detect the Aug 2020 cluster); is_edited on 3; body median 92 chars; zero-review storefronts cn, de, au, tw, hk, sg confirmed queried; boundary risk between paywall_cap and price_objection (9 carry both; union 64, 31.07% stable); no version field (listing 4.7.1 predates the last seven reviews); refund reports one-sided; translation risk in short Vietnamese / Thai / Turkish reviews; 29 payers (14.08%) self-selected, no conversion rate; external sources — listing and public consumer-spend rankings, labelled

- **Where:** How to read this; Nine warnings #6 #9; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.5 Processing method; §1.6 Limitations
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 206/206; 74 ID lists; 0 unknown IDs
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `8908949865`, `10670396735`, `10474969732`, `12160321648`, `13138307431`
- **Canonical:** — (nuance register)

### R42-003 — A small, bimodal corpus: 83 reviews 5★ (40.3%) and 67 1★ (32.5%) — 150 of 206 (72.8%) at an extreme, only 12 (5.8%) 4★; the signal is which population each pole represents, not the average

- **Where:** Nine warnings #1 — small (206) and bimodal: 83 5★ (40.3%), 67 1★ (32.5%), 150 at the extremes (72.8%), only 12 4★ (5.8%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★ 83 (40.3%); 1★ 67 (32.5%); 4★ 12 (5.8%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-004 — Written reviews can tell a very different story from the star aggregate: corpus mean 3.136 vs the store's 4.6 from 4.7K ratings — the 206 written reviews are ~4% of ratings, skewed to people motivated to type; read as 'among people who bothered to write, the split is this bad'

- **Where:** Nine warnings #2 — corpus mean 3.136 far below the store aggregate 4.6 from 4.7K ratings; written reviews a ~4% sliver skewed to the motivated
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 3.136 vs 4.6 (4.7K)
- **Direction for us:** none · **Report confidence:** limitation · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-005 — Two solicited-looking bursts inflate the positive side: six US 5★ reviews posted 11–13 Aug 2020 carrying 13–30 helpful votes each (the rest of the corpus maxes at 10 with a non-zero median of 1) with nonsense titles ('Hgfgg', 'H', 'Bdbdbd', 'The'); eleven of Canada's twelve reviews are 5★ generic English praise posted 9–21 May 2021, nine inside eight days — Canada's perfect 5.00 is an artifact; removing both moves the mean from 3.136 to 2.968 (n = 189); 2020 3.96 → 3.65 and 2021 3.68 → 3.12 without them

- **Where:** Nine warnings #3 — two review bursts: six US 5★ 11–13 Aug 2020 with 13–30 helpful votes each (rest max 10, median 1) and nonsense titles ('Hgfgg', 'H', 'Bdbdbd', 'The'); eleven of Canada's twelve 5★ generic English praise 9–21 May 2021 (nine inside eight days); Canada's 5.00 is an artifact; without both the mean is 2.968 (n=189)
- **This app does:** suspected solicited reviews
- **User reaction:** 5★-burst
- **Magnitude:** 17 reviews (8.25%); mean 3.136 → 2.968
- **Direction for us:** none · **Report confidence:** disclosed, excluded from market conclusions · **Generalisable:** yes
- **Review IDs:** `6306860426`, `6307010280`, `6308178252`, `6308196493`, `6312219230`, `6316224959`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R42-007 — Only Brazil (55) clears 50 reviews; US (46) and Russia (36) are limited evidence; every other storefront ≤ 14; Germany, Australia and China have zero reviews (queried, returned none)

- **Where:** Nine warnings #4 #5 — only Brazil (55) clears 50; US 46 and Russia 36 limited evidence; Germany, Australia and China zero reviews (complete: true, collected: 0)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** BR 55; US 46; RU 36; DE/AU/CN 0
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-008 — Rating vs text contradictions, 5 (2.43%): 5★ 'I wasted 9.99 on this. I regret subscribing… I would avoid it'; 1★ '별이 다섯 :: 쏘굿' ('five stars :: so good'); 5★ 'The app won't open'; 5★ 'I bought it and it just freezes'; 5★ bug report

- **Where:** Nine warnings #7 — at least five rating/text contradictions (2.43%): 5★ 'I wasted 9.99 on this. I regret subscribing'; 1★ 'five stars :: so good'; 5★ 'The app won't open'; 5★ 'I bought it and it just freezes'; 5★ bug report
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5 (2.43%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `6422725217`, `7023381511`, `12144367844`, `11764301384`, `12017526630`
- **Canonical:** — (nuance register)

### R42-024 — Feature inventory with review-derived access tier

- **Where:** §2.1 Feature inventory derived from reviews (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence (review IDs) | Access tier per reviewers ; Create and check off daily habits | 6312219230, 9158190393, 5995999324, 7318346238 | Free, capped at 3 ; More than 3 habits | 10918059435, 11316242500, 8757084304, 12133174175, 10194166127 | Paid ; Reminders / notifications | 5990760352, 7588653687, 7762886727 (praise); 6704352732, 10901396387, 9730373479, 6881986270, 6313215651 (paywalled) | Paid ; Scheduling — specific days / weekly / monthly / yearly | 7318341303, 7368905234 (praise); 8559036422, 12798927312, 12388272937, 7194589305 (paywalled) | Paid ; Repetition / frequency settings | 11948614593 (*"タスクの繰り返しが有料プランのみ"* / "task repetition is paid-plan only"), 8778350918 (reps) | Paid ; Statistics / progress percentage / charts | 7405651148, 7242515179, 12890217155, 6552567684, 13760625758, 12310659183 | Partly free, detail is paid (12310659183: *"The detailed stats in premium version are worth it"*) ; Historical data beyond recent days | 6695360237 (*"No historical data"*), 11447879577 (*"Если не заплатить то не увидишь свой результат в прошлом месяце"* / "if you don't pay you won't see last month's result"), 11186327600 (*"can't go back more than 2 weeks"*) | Paid / capped ; Backfilling a missed day | 11120549627 (*"можно задать привычку… максимум с прошлой недели"* / "you can set a habit back at most to last week"), 11476120833 | Capped ; "Habit power" progress metric | 6312219230 (*"The idea with habit power is wonderful"*) | Free ; Ready-made habit templates | 12310659183 (*"The ready-made habits are a great starting point"*) | Free ; Custom habits | 12310659183, 7192572245 | Free (within cap) ; Colour coding / categories | 6026946756 (*"Можно отметить каждую конкретным цветом… Или выделять по цвету целую категорию"*) | Free ; Dark mode | 7242515179 | Free ; Motivational quotes / messages | 9375609371, 13138307431, 8890054521 (incoherent) | Free ; Completion celebration modal ("trophy"/"congratulations") | 9211593813, 11476120833, 11164675946, 8890054521 | Free, not disableable ; "MyDay" section | 7318342988 | Free ; Apple Watch reminders | 7762886727 | Unclear (single mention) ; Widgets (home/lock screen) | 10155196420, 10774694629, 9615589336 — all three say they are absent | Does not exist (as of those reviews) ; Notes / photos on an activity | 7700270494 (requested), 7318342988 (requested) | Does not exist ; Multiple completions per day (water, meals, reps) | 9838731003, 7113224515, 7669054186, 8568438754, 8778350918, 6905654687 | Does not exist ; Cross-device / shared account (iPhone + Mac + iPad) | 11105940631 (requested) | Does not exist / unclear ; Time tracker | 7318342988 (requested) | Does not exist ; Shifting a habit from one day to another | 13760625758 (requested) | Does not exist ; Social / mutual challenge | 7347301738 (*"I and my mom challenge each other each day"* — done informally, not in-app) | Does not exist in-app ; In-app support contact | 11826835199 (*"пишет не подключена почта, но в приложении нет раздела, где ее можно подключить"* / "it says mail is not connected, but there's no section in the app to connect it") | Broken — mailto: only ; Email support (working) | 7700270494 (*"Great customer service"*), 10991854727 (*"Apenas respondem a mesma coisa para todos"* / "they just reply the same thing to everyone") | Exists, quality contested
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Review IDs:** `6312219230`, `9158190393`, `5995999324`, `7318346238`, `5990760352`, `7588653687`, `7762886727`, `7318341303`, `7368905234`, `11948614593`, `7405651148`, `7242515179`, `12890217155`, `6552567684`, `13760625758`, `12310659183`, `6695360237`, `11447879577`, `11186327600`, `11120549627`, `6026946756`, `9375609371`, `13138307431`, `7318342988`, `10155196420`, `10774694629`, `9615589336`, `11105940631`, `7347301738`, `10991854727`
- **Canonical:** — (nuance register)

### R42-036 — Master theme table, denominator 206

- **Where:** §3.1 Master table (verbatim), 45 themes + 26 weak + meta labels
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | Dir. | n | % | Signal | Mean ★ | 5/4/3/2/1 ; 1 | paywall_cap — free tier unusable / 3-habit cap / basics paid | – | 55 | 26.70% | high-priority | 1.96 | 3/2/13/9/28 ; 2 | paid_direct — first-person evidence of having paid | mixed | 29 | 14.08% | high-priority | 2.72 | 10/0/4/2/13 ; 3 | praise_simplicity — minimal, clean, "nothing extra" | + | 22 | 10.68% | high-priority | 4.68 | 18/2/1/1/0 ; 4 | price_objection — price too high for value | – | 18 | 8.74% | high-priority | 1.67 | 0/0/5/2/11 ; 5 | praise_behaviour_change — real outcome described | + | 14 | 6.80% | high-priority | 4.93 | 13/1/0/0/0 ; 6 | no_trial — cannot evaluate before paying | – | 14 | 6.80% | high-priority | 1.29 | 0/0/1/2/11 ; 7 | competitor_mention — names or implies an alternative | – | 13 | 6.31% | high-priority | 2.54 | 2/0/5/2/4 ; 8 | perf_lag — freezing, lag, slowness | – | 12 | 5.83% | high-priority | 2.58 | 1/1/4/4/2 ; 9 | refund_request — asks for or references a refund | – | 11 | 5.34% | high-priority | 1.27 | 0/0/1/1/9 ; 10 | praise_motivation — app motivates / keeps me going | + | 10 | 4.85% | very strong | 5.00 | 10/0/0/0/0 ; 11 | value_insufficient — paid and it wasn't worth it | – | 9 | 4.37% | very strong | 2.11 | 1/0/3/0/5 ; 12 | regression_after_update — worse after an update | – | 8 | 3.88% | very strong | 2.50 | 1/1/2/1/3 ; 13 | praise_stats — progress %, charts, statistics | + | 7 | 3.40% | very strong | 4.71 | 6/0/1/0/0 ; 14 | outage_crash — won't open / crashes on launch | – | 7 | 3.40% | very strong | 1.71 | 1/0/0/1/5 ; 15 | deceptive_free — "free" listing felt misleading | – | 7 | 3.40% | very strong | 1.43 | 0/0/1/1/5 ; 16 | praise_reminders — reminders work and help | + | 6 | 2.91% | meaningful | 5.00 | 6/0/0/0/0 ; 17 | multi_count_missing — can't log >1× per day | – | 6 | 2.91% | meaningful | 1.50 | 0/0/1/1/4 ; 18 | data_loss — lost habits, history or progress | – | 6 | 2.91% | meaningful | 1.33 | 0/0/1/0/5 ; 19 | churn_risk — states intent to leave / stop recommending | – | 6 | 2.91% | meaningful | 1.83 | 0/0/2/1/3 ; 20 | reminders_paywalled — reminders specifically behind the wall | – | 5 | 2.43% | meaningful | 2.60 | 0/1/2/1/1 ; 21 | localization_missing — language absent | – | 5 | 2.43% | meaningful | 2.60 | 0/2/1/0/2 ; 22 | feature_requests_other — net-new capability requested | ~ | 5 | 2.43% | meaningful | 5.00 | 5/0/0/0/0 ; 23 | rating_text_contradiction — stars ≠ text | ~ | 5 | 2.43% | meaningful | 4.20 | 4/0/0/0/1 ; 24 | subscription_objection — objects to the model, not the price | – | 4 | 1.94% | meaningful | 1.50 | 0/0/0/2/2 ; 25 | paywall_immediate — paywall before any use | – | 4 | 1.94% | meaningful | 1.00 | 0/0/0/0/4 ; 26 | history_backfill_limit — can't go back far enough | – | 4 | 1.94% | meaningful | 2.25 | 0/0/2/1/1 ; 27 | congrats_popup — celebration modal is intrusive | – | 4 | 1.94% | meaningful | 3.00 | 0/1/2/1/0 ; 28 | widget_missing — no widget | – | 3 | 1.46% | meaningful | 2.67 | 0/1/1/0/1 ; 29 | upsell_nag — repeated upgrade interstitials | – | 3 | 1.46% | meaningful | 1.67 | 0/0/1/0/2 ; 30 | stats_broken — statistics wrong or gone | – | 3 | 1.46% | meaningful | 2.00 | 0/1/0/0/2 ; 31 | retroactive_paywall — was free, now paid | – | 3 | 1.46% | meaningful | 1.67 | 0/0/1/0/2 ; 32 | praise_design — visual design / aesthetics | + | 3 | 1.46% | meaningful | 5.00 | 3/0/0/0/0 ; 33 | onboarding_long — too many setup screens | – | 3 | 1.46% | meaningful | 1.00 | 0/0/0/0/3 ; 34 | competitor_native — "my phone already does this" | – | 3 | 1.46% | meaningful | 2.33 | 0/0/2/0/1 ; 35 | billing_unexpected_charge — charged without intent | – | 3 | 1.46% | meaningful | 1.00 | 0/0/0/0/3 ; 36 | trial_trap — trial converted, refund refused | – | 2 | 0.97% | emerging | 1.00 | 0/0/0/0/2 ; 37 | stats_insufficient — stats exist but are too thin | – | 2 | 0.97% | emerging | 2.00 | 0/0/1/0/1 ; 38 | stats_bug — a specific statistics miscalculation | – | 2 | 0.97% | emerging | 3.50 | 0/1/1/0/0 ; 39 | scheduling_flexibility_missing — can't express my schedule | – | 2 | 0.97% | emerging | 3.00 | 1/0/0/0/1 ; 40 | review_prompt_too_early — rating prompt during onboarding | – | 2 | 0.97% | emerging | 1.00 | 0/0/0/0/2 ; 41 | praise_scheduling_flexibility | + | 2 | 0.97% | emerging | 5.00 | 2/0/0/0/0 ; 42 | praise_comparison — chose this over others tried | + | 2 | 0.97% | emerging | 5.00 | 2/0/0/0/0 ; 43 | perf_improved — performance got better | + | 2 | 0.97% | emerging | 5.00 | 2/0/0/0/0 ; 44 | checkoff_bug — can't mark a habit complete | – | 2 | 0.97% | emerging | 4.00 | 1/0/1/0/0 ; 45 | cancellation — states they cancelled | – | 2 | 0.97% | emerging | 2.00 | 0/0/1/0/1 ; 46–71 | 26 weak-signal themes, each n=1 (0.49%) | ~ | 26 | — | weak | — | see §9.2 ; — | low_info — no extractable product signal | ~ | 39 | 18.93% | — | 4.08 | 28/2/1/0/8 ; — | us_2020_burst — suspected solicited cluster | ~ | 6 | 2.91% | — | 5.00 | 6/0/0/0/0 ; — | ca_2021_burst — suspected solicited cluster | ~ | 11 | 5.34% | — | 5.00 | 11/0/0/0/0
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-049 — Emerging: praise_scheduling_flexibility 2 (5.00); praise_comparison 2 (5.00); perf_improved 2 (5.00); checkoff_bug 2 (4.00, both paying users reporting politely); cancellation 2 (2.00)

- **Where:** §3.1 master table #41–#45 emerging positives and small bugs
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 2 each
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-050 — 26 weak themes n=1 each (0.49%, see §9.2); low_info 39 (18.93%, mean 4.08; 28/2/1/0/8); us_2020_burst 6 (5.00); ca_2021_burst 11 (5.00)

- **Where:** §3.1 master table #46–71 weak themes and meta labels
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** n=1 each; low_info 39
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-061 — Unmet needs: multiple completions per day 6 (2.91%); longer history / backfill further than ~1–2 weeks 4 (1.94%); widgets 3 (1.46%); flexible scheduling ('Tue & Thu', shift a day) 2; notes / photos on an entry 2; shared account across iPhone / Mac / iPad 1; time tracker 1; deeper customisation of a created habit 1; 'goal for the day' as advertised 1; focus on more than one habit at a time 1; in-app social / mutual challenge 1

- **Where:** §3.4 Unmet needs (verbatim table) — multi-count 6; widgets 3; longer history / backfill 4; flexible scheduling 2; notes / photos 2; shared account 1; time tracker 1; deeper customisation 1; 'goal for the day' as advertised 1; focus on more than one habit 1; in-app social 1
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Need | n | % | Signal | IDs ; Multiple completions per day (water / meals / reps) | 6 | 2.91% | meaningful | 6905654687, 7113224515, 7669054186, 8568438754, 8778350918, 9838731003 ; Widgets (home + lock screen) | 3 | 1.46% | meaningful | 10155196420, 10774694629, 9615589336 ; Longer history / backfill further than ~1–2 weeks | 4 | 1.94% | meaningful | 11186327600, 11120549627, 11476120833, 6695360237 ; Flexible scheduling ("Tue & Thu", shift a day) | 2 | 0.97% | emerging | 7194589305, 13760625758 ; Notes / photos on an entry | 2 | 0.97% | emerging | 7700270494, 7318342988 ; Shared account across iPhone / Mac / iPad | 1 | 0.49% | weak | 11105940631 ; Time tracker | 1 | 0.49% | weak | 7318342988 ; Deeper customization of a created habit | 1 | 0.49% | weak | 6422725217 ; "Goal for the day" as advertised | 1 | 0.49% | weak | 8653967908 ; Focus on more than one habit at a time | 1 | 0.49% | weak | 10104662745 ; In-app social / mutual challenge | 1 | 0.49% | weak | 7347301738 (done manually with a family member)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-063 — Distribution: 5★ 83 (40.3%) · 4★ 12 (5.8%) · 3★ 28 (13.6%) · 2★ 16 (7.8%) · 1★ 67 (32.5%); 72.8% at an extreme, the 4★ band nearly empty

- **Where:** Part 4 distribution — 5★ 83 · 4★ 12 · 3★ 28 · 2★ 16 · 1★ 67; 72.8% at 1★ or 5★; 4★ nearly empty — this app does not produce mild opinions
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as stated
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-070 — Payers: 29 (14.08%) mean 2.72 vs 177 non-payers 3.20; 1★ 13 (44.8%) vs 54 (30.5%) — ~1.5× as likely to give one star; no payer gave 4★; BR 10 · US 8 · RU 6 · VN 3 · TR 1 · GB 1; by year 2020 3, 2021 4, 2022 1, 2023 5, 2024 8, 2025 7, 2026 1 — not declining, a live population; a self-selected sample of writers, not buyers

- **Where:** §5.1 Who is identifiable as a payer (verbatim table) — 29 (14.08%), payers 2.72 vs non-payers 3.20; 1★ 44.8% vs 30.5% (~1.5×); no payer gave 4★; BR 10 · US 8 · RU 6 · VN 3 · TR 1 · GB 1; by year 3/4/1/5/8/7/1 — a live, current population
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Metric | Payers (n=29) | Non-payers (n=177) ; Mean rating | 2.72 | 3.20 ; 5★ | 10 (34.5%) | 73 (41.2%) ; 4★ | 0 (0.0%) | 12 (6.8%) ; 3★ | 4 (13.8%) | 24 (13.6%) ; 2★ | 2 (6.9%) | 14 (7.9%) ; 1★ | 13 (44.8%) | 54 (30.5%)
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R42-088 — Canada (n = 12, all 5★) is excluded: eleven reviews 9–21 May 2021, nine inside eight days, generic English, zero votes — useful only as a negative control: uniform, unspecific, dateless praise is what makes the feature- and outcome-specific Russian and US praise credible; two Canadian records with product content are used with the caveat (flexible scheduling; photos on notes, time tracker, customisation)

- **Where:** §6.5 Canada — n = 12, mean 5.000, excluded: all 5★, eleven 9–21 May 2021 (nine inside eight days), generic English, distinct authors, zero votes; useful only as a negative control — uniform, unspecific, dateless praise vs feature-specific praise elsewhere
- **This app does:** suspected burst
- **User reaction:** 5★-burst
- **Magnitude:** 12/12 5★; 11 in 13 days
- **Direction for us:** none · **Report confidence:** excluded · **Generalisable:** app-specific
- **Review IDs:** `7762886727`, `7318341303`, `7318342988`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R42-120 — Research question: Why is performance so much worse in Brazil? No device, OS or network field — needs telemetry

- **Where:** Part 8 #1 (§8.4 research question 1)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `10777125663`
- **Canonical:** — (nuance register)

### R42-121 — Research question: Did the free tier actually tighten over time, or did tolerance fall? Three eyewitnesses say it tightened; no version field

- **Where:** Part 8 #2 (§8.4 research question 2)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `12021785730`, `12472128598`, `13595332155`
- **Canonical:** C001 Never move a free feature behind the paywall

### R42-122 — Research question: What is the real refund rate? Eleven of twenty-nine writing payers asked for one; App Store Connect can answer directly

- **Where:** Part 8 #3 (§8.4 research question 3)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-123 — Research question: Why has US written-review volume gone to near zero (12 in 2020, 0 in 2026)? Acquisition decline, prompt-configuration change, or both

- **Where:** Part 8 #4 (§8.4 research question 4)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-124 — Research question: What are the seven concurrent IAP SKUs doing? Five near-identical names at $39.99 / $59.99 suggest live price testing; the corpus shows only the symptoms

- **Where:** Part 8 #5 (§8.4 research question 5)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R42-125 — Research question: Is the store aggregate (4.6★, 4.7K) diverging from written reviews over time? If written reviews fell 3.96 → 2.69 while the aggregate held, the prompted-rating flow and written-review flow sample very different populations

- **Where:** Part 8 #6 (§8.4 research question 6)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)
