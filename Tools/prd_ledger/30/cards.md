# Cards — report 30

Source: `App Store Reports/30. Habit Tracker - Simple&Powerful - Goal,task & Routine Planner (REPORT).md`  
92 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 2
- [Must-haves](#must-haves) — 4
- [Must never break](#must-never-break) — 15
- [Features](#features) — 9
- [Monetization](#monetization) — 14
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 13
- [Markets and languages](#markets-and-languages) — 5
- [Dated events and trends](#dated-events-and-trends) — 9
- [Positioning](#positioning) — 1
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 1
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 12

## Product rules

### R30-042 — The free habit cap in detail: 12 reviews in the 2-habit era and 3 in the 3-habit era; rating spread 1★8 · 2★3 · 3★1 · 4★2 · 5★1 — the 4★ and 5★ are people who like the app and dock it anyway ('Замечательное приложение… Из минусов — в бесплатной версии можно добавить только 2 привычки', 5★; 'La app es buenísima. Peero, para añadir más de tres hábitos hay que pagar… te ves obligado a pagar para medir más hábitos', 4★); two reviewers propose the fix themselves — 5 free habits (KZ) and 'Quer cobrar? Coloque algumas versões na versão pro. Não faz sentido deixar cadastrar 2 habitos' ('Want to charge? Put some features in the pro version. It makes no sense to allow only 2 habits', BR); 'It would be smarter to create attractive features that persuade the user to pay rather than limiting tracking to a mere two' (TR); the cap is set below the point where the user can experience the product at all — nobody forms a habit portfolio of two, and the cap converts evaluation into rejection

- **Where:** §3.3 Free habit cap — 15 IDs split by era (12 in the 2-habit era, 3 in the 3-habit era); rating spread 1★8 · 2★3 · 3★1 · 4★2 · 5★1 — people who like the app and dock it anyway ('Wonderful app… minus: the free version allows only 2 habits'; 'La app es buenísima. Peero, para añadir más de tres hábitos hay que pagar'); two propose the fix — 5 free habits, and 'put some features in pro instead'; 'Nobody forms a habit portfolio of two. The cap converts evaluation into rejection'
- **This app does:** 2 → 3 habit cap
- **User reaction:** 1★-burst
- **Magnitude:** 15; 1★8 · 2★3 · 3★1 · 4★2 · 5★1
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13015082250`, `13057771438`, `13078324005`, `13139338718`, `13283076453`, `13286447070`, `13441364320`, `13487320234`, `13678734774`, `13679689890`, `13707712022`, `13710940338`, `14007543484`, `14262833547`, `14438894096`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C147 Let people use the product before they pay

### R30-078 — F2: raise the free cap to at least 5 habits and move monetisation to depth — widget, sync, themes, history, stats — instead of count; evidence: 15 cap reviews (9.04%, high-priority, mean 2.00), all 3 two-star reviews, 8 of 19 one-star, and users' own proposals (5 free habits; 'put some features in pro instead'); the single highest-leverage change in the report, which also neutralises most of the price objection

- **Where:** §8.1 F2 — raise the free cap to at least 5 habits and move monetisation to depth (widget, sync, themes, history, stats) instead of count; the single highest-leverage change, and it also neutralises most of the price objection
- **This app does:** 2–3 habit cap
- **User reaction:** 1★-burst
- **Magnitude:** 15; 3/3 2★; 8/19 1★
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13139338718`, `13441364320`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

## Must-haves

### R30-031 — Cannot find edit / delete / pause — discoverability, not a missing feature

- **Where:** §3.1 Master table #14 Cannot find edit / delete / pause
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 3 (1.81%, meaningful), mean 3.33
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C142 Surface existing features where users look

### R30-045 — Cannot find edit / delete / pause (3): 'Como pausa um hábito? como edita? Já procurei por tudo e não consigo editar' ('how do you pause a habit? how do you edit? I've looked everywhere', BR, 4★); 'I couldn't find a place to edit or remove a habit' (IL, 1★); 'только не могу понять как удалить или изменить привычку' (RU, 5★); the capability exists (another reviewer edits within the current month) — a discoverability defect, not a missing feature, and it costs a 1★

- **Where:** §3.3 Cannot find edit / delete / pause — 'how do you pause a habit? how do you edit? I've looked everywhere' (4★); 'I couldn't find a place to edit or remove a habit' (1★); the capability exists — a discoverability defect costing a 1★
- **This app does:** hidden edit/delete/pause
- **User reaction:** complaint
- **Magnitude:** 3 (1.81%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13324437553`, `13576406218`, `13449993538`, `13085435338`
- **Canonical:** C142 Surface existing features where users look

### R30-080 — F4: make edit / delete / pause discoverable — the feature exists and three reviewers across three countries could not find it, one of them rating 1★; pure UX that removes a 1★ cause with no new functionality

- **Where:** §8.1 F4 — make edit / delete / pause discoverable: the feature exists; three reviewers in three countries could not find it, one rating 1★; pure UX, no new functionality
- **This app does:** hidden controls
- **User reaction:** complaint
- **Magnitude:** 3
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13324437553`, `13576406218`, `13449993538`
- **Canonical:** C142 Surface existing features where users look

### R30-084 — B1: non-daily scheduling — per-habit frequency (days of week, x per week, weekly, monthly), an end-date, and Skip that preserves the daily completion ring — one coherent feature closing unmet needs #1, #2, #3 and #5 simultaneously and stopping the history loss on delete; 4 storefronts, 4 languages (n=4, 2.41%); the only feature build the corpus supports; explicitly do not build in response to 'the app is too basic' — all 4 who say it also object to price, a value complaint wearing a feature costume, and adding surface area would attack the product's one proven strength (simplicity 23 + convenience 12 + outcomes 7)

- **Where:** §8.2 B1 — the only build item: non-daily scheduling (days of week, x per week, weekly, monthly) + an end-date + Skip that preserves the daily completion ring — one coherent feature closing unmet needs #1, #2, #3 and #5 and stopping the data loss; explicitly do not build in response to 'too basic' — all 4 also object to price, a value complaint wearing a feature costume that would attack the one proven strength
- **This app does:** daily-only; no end date
- **User reaction:** complaint
- **Magnitude:** 4 (2.41%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13032875149`, `13176696608`, `13249103798`, `13705764332`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

## Must never break

### R30-005 — The purchase experience itself is broken in four distinct, separately-evidenced ways: (a) charged, premium never unlocked ('Списаны деньги за подписку, премиум функция не открылась', RU, 1★); (b) the monthly SKU cannot be bought ('не могу приобрести про версию на месяц, выдает оплату за год' — 'can't buy the monthly pro version, it charges for a year', RU, 4★); (c) 'lifetime' sold as lifetime and delivered as annual ('Te dicen que es de por vida el plan y es solo para un año', ES, 1★) — matching a store shelf carrying both a $59.99 Lifetime and a $44.99 Yearly SKU; (d) no trial before a full annual charge ('I paid the anual subscription… It doesn't have a trial version and it wasn't what I was looking for', AR, 1★; UA, 1★); plus a refund dead end (MX, 1★); these are five of the six reviewers in the whole corpus who reached the payment step, and five of six had a bad outcome — the highest-severity finding, invisible in the star average

- **Where:** Executive summary #3 — the purchase experience is broken four separately-evidenced ways: (a) charged, premium never unlocked; (b) the monthly SKU cannot be bought ('it charges for a year'); (c) 'lifetime' sold as lifetime, delivered as annual ('Te dicen que es de por vida el plan y es solo para un año') on a shelf carrying both $59.99 Lifetime and $44.99 Yearly; (d) no trial before a full annual charge ('I paid the anual subscription… It doesn't have a trial version and it wasn't what I was looking for'); plus a refund dead end — five of the six reviewers who reached payment had a bad outcome; the highest-severity finding, invisible in the star average
- **This app does:** ambiguous SKU shelf; entitlement and billing failures
- **User reaction:** 1★-burst
- **Magnitude:** 5 of 6 payers bad outcome
- **Direction for us:** must-never-break · **Report confidence:** high-severity, small n · **Generalisable:** yes
- **Review IDs:** `13670832453`, `13678734774`, `13705764332`, `13680381966`, `13679689890`, `14264524351`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C063 Free trial before purchase; C113 One stable, disclosed price — no discount wheels; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R30-025 — Any functional defect (union)

- **Where:** §3.1 Master table #5 Any functional defect (union)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 12 (7.23%, HIGH), sub. 25.5%, mean 3.00
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R30-033 — Billing failure — charge without entitlement / wrong SKU

- **Where:** §3.1 Master table #17 Billing failure (charge / wrong SKU)
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 2 (1.20%, meaningful), mean 2.50
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R30-035 — Crash / won't open (Jul 2025 only)

- **Where:** §3.1 Master table #19 Crash / won't open
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 2 (1.20%, meaningful), mean 3.50
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R30-036 — Name-entry bug (Arabic locale)

- **Where:** §3.1 Master table #20 Name-entry bug (Arabic locale)
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 2 (1.20%, meaningful), mean 1.00
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C228 Text fields must handle IME composition — Hangul and CJK input

### R30-046 — Billing failures are the highest-severity records: money taken with premium never unlocked (RU, 1★); the monthly SKU cannot be purchased and the flow charges annually instead (RU, 4★); adjacent — an accidental subscription with no route to a refund (MX, 1★) and 'lifetime' delivered as annual (ES, 1★); of the 6 reviewers who reached the payment step anywhere in the corpus, 5 report a bad outcome and the sixth (AR) paid and complains everything is still gated — segment rate 5 of 6 on a tiny denominator, but every single one is a 1★-or-downgrade event and three are potential store-policy issues

- **Where:** §3.3 Billing failures — the highest-severity records: charged, premium never unlocked; monthly SKU cannot be purchased, flow charges annually; adjacent accidental subscription with no refund route and 'lifetime' delivered as annual; 5 of the 6 who reached payment report a bad outcome, the sixth paid and complains everything is still gated — every one a 1★-or-downgrade event, three potential store-policy issues
- **This app does:** purchase flow defects
- **User reaction:** 1★-burst
- **Magnitude:** 5 of 6 payers
- **Direction for us:** must-never-break · **Report confidence:** meaningful — high severity · **Generalisable:** yes
- **Review IDs:** `13670832453`, `13678734774`, `14264524351`, `13705764332`, `13680381966`, `13882804582`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R30-047 — Name-entry bug in the Arabic locale (2, mean 1.00): 'مو راضي يدخل الا باسم معين و كذا مره جربت اقتراحاته و لسه بعد' ('it won't let me in except with a particular name; I tried its suggestions several times and still nothing'); 'مو راضي يقبل اي إسم' ('it won't accept any name'); 2 of the 3 Saudi-storefront reviews are this same onboarding blocker — the app is unusable at step one for these users; limited evidence by count, promoted because it is a hard-block defect with an identifiable locale fingerprint

- **Where:** §3.3 Name-entry bug (Arabic locale) — 'it won't let me in except with a particular name; I tried its suggestions several times'; 'it won't accept any name'; 2 of the 3 SA-storefront reviews — the app is unusable at step one; promoted because it is a hard-block defect with a locale fingerprint
- **This app does:** onboarding name field rejects Arabic input
- **User reaction:** 1★-burst
- **Magnitude:** 2 of 3 SA reviews, mean 1.00
- **Direction for us:** must-never-break · **Report confidence:** limited, promoted — hard block · **Generalisable:** yes
- **Review IDs:** `13511113509`, `13596102043`
- **Canonical:** C228 Text fields must handle IME composition — Hangul and CJK input

### R30-048 — Crash / won't open (2): 'Вылетает' (RU, 3★) and 'Скачала его, но так и не смогла войти. Оно просто не открывается. Причем проблема как на iOS 18.5, так и на бете IOS 26' ('downloaded it and could never get in… on iOS 18.5 and on the iOS 26 beta', RU, 4★ — 'I don't want to spoil your rating, but please update the app'); both 12–13 July 2025, days after launch; no crash report anywhere in the subsequent 13 months — treat as resolved

- **Where:** §3.3 Crash / won't open — both 12–13 Jul 2025, days after launch ('It just doesn't open… on iOS 18.5 and on the iOS 26 beta'; 'I don't want to spoil your rating, but please update the app'); no crash report in the subsequent 13 months — resolved
- **This app does:** launch-week crash, fixed
- **User reaction:** complaint
- **Magnitude:** 2, Jul 2025 only
- **Direction for us:** must-never-break · **Report confidence:** meaningful (historical) · **Generalisable:** yes
- **Review IDs:** `12883902100`, `12886833369`
- **Canonical:** C031 Crashes / launch failures

### R30-049 — Scroll-jump and list density (1 each, the most detailed review in the corpus, GB, 3★): with more than 10 habits the list jumps back to the top after each tick, forcing a re-scroll for every habit, and rows cannot be made smaller; this defect only manifests above ~10 habits — i.e. only for paying users — a paid-tier quality problem hiding behind a free-tier cap

- **Where:** §3.3 Scroll-jump + list density — with more than 10 habits the list jumps back to the top after each tick and rows cannot be made smaller (GB, 3★, the most detailed review); this defect only manifests above ~10 habits, i.e. only for paying users — a paid-tier quality problem hiding behind a free-tier cap
- **This app does:** list resets scroll on tick
- **User reaction:** complaint
- **Magnitude:** 1 review
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13032875149`
- **Canonical:** C083 Performance must not degrade with habit count; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R30-051 — A habit end-date is missing, so deleting a finished habit wipes its history; using Skip breaks the daily completion ring so users feel they failed a day they completed; per-habit and per-day percentages are absent — one diagnostic 4★ from Chile

- **Where:** §3.4 Habit end-date + Skip preserving the completion ring + per-habit percentages — deleting a finished habit wipes its history and skipping breaks the ring
- **This app does:** no end date; skip breaks ring
- **User reaction:** complaint
- **Magnitude:** 1 review (emerging)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13176696608`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C041 Editing a habit never wipes its history

### R30-058 — Six reviewers (3.61%) reach the payment step: AR 1★ 'I paid the anual subscription' — regret, no trial, product not as expected; RU 1★ 'Списаны деньги за подписку' — charged, premium did not unlock; MX 1★ 'quise cancelar suscripción… no puedo recuperar el dinero' — accidental purchase, refund refused; ES 1★ 'Te dicen que es de por vida el plan y es solo para un año' — mis-sold plan term; AR 1★ 'Para todas las opciones tenes que tener la versión paga' — still gated after paying; RU 4★ 'не могу приобрести про версию на месяц, выдает оплату за год' — cannot buy the SKU they want; 5 of 6 are 1★ and not one describes a satisfactory purchase (the one happy widget user does not state they paid); review corpora over-sample unhappy payers so this is not a satisfaction rate, but four of the six are distinct, reproducible purchase-flow defects — a failed entitlement, an unpurchasable SKU, an ambiguous plan label and a missing trial — facts about the flow, not sentiment

- **Where:** §5.1 Who is identifiable as a payer (verbatim table) — 6 (3.61%): annual with no trial → regret; charged, premium did not unlock; accidental purchase, refund refused; mis-sold plan term; still gated after paying; cannot buy the monthly SKU; 5 of 6 are 1★ and not one describes a satisfactory purchase; four are distinct reproducible purchase-flow defects — facts about the flow, not sentiment
- **This app does:** broken purchase flow
- **User reaction:** 1★-burst
- **Magnitude:** ID | Country | ★ | Evidence | Outcome ; 13680381966 | AR | 1 | *"I paid the anual subscription"* | Regret — no trial, product not as expected ; 13670832453 | RU | 1 | *"Списаны деньги за подписку"* | Charged; premium did not unlock ; 14264524351 | MX | 1 | *"quise cancelar suscripción… no puedo recuperar el dinero"* | Accidental purchase, refund refused ; 13705764332 | ES | 1 | *"Te dicen que es de por vida el plan y es solo para un año"* | Mis-sold plan term ; 13882804582 | AR | 1 | *"Para todas las opciones tenes que tener la versión paga"* | Still gated after paying ; 13678734774 | RU | 4 | *"не могу приобрести про версию на месяц, выдает оплату за год"* | Cannot buy the SKU they want
- **Direction for us:** must-never-break · **Report confidence:** high severity, n=6 · **Generalisable:** yes
- **Review IDs:** `13680381966`, `13670832453`, `14264524351`, `13705764332`, `13882804582`, `13678734774`, `14107277631`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R30-061 — Refund, cancellation and store-policy exposure: an accidental subscription the user could not recover money from (MX, 1★ — normally an Apple-side flow, but the reviewer blames the app); a 'lifetime' plan that lasted a year (ES, 1★) on a shelf listing both a $59.99 Lifetime and a $44.99 Yearly — whether mis-selling or misreading, ambiguous enough to reliably generate this complaint, the class that attracts store review; 'in app have paid offers, but this is not writes in a Appstore' (UA, 1★) — the US listing does disclose IAP, so either the storefront presentation differs or the disclosure is not visible at the decision point; paid with no entitlement (RU, 1★) — 'unambiguously a bug and should be treated as a P0 incident, not a review'

- **Where:** §5.4 Refund, cancellation and store-policy exposure — accidental subscription with no money back (normally Apple-side, the reviewer blames the app); a 'lifetime' plan that lasted a year on a shelf listing both Lifetime and Yearly — the class of complaint that attracts store review; 'in app have paid offers, but this is not writes in a Appstore' — disclosure not visible at the decision point; paid with no entitlement — 'unambiguously a bug and should be treated as a P0 incident, not a review'
- **This app does:** ambiguous SKUs; entitlement failure; disclosure not seen
- **User reaction:** 1★-burst
- **Magnitude:** 4 reviews
- **Direction for us:** must-never-break · **Report confidence:** high severity · **Generalisable:** yes
- **Review IDs:** `14264524351`, `13705764332`, `13864202916`, `13670832453`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C112 In-app cancellation; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R30-077 — F1: audit the purchase flow end to end — entitlement delivery, the monthly SKU, and the Lifetime-vs-Yearly labelling — and treat the paid-no-unlock report as a P0 incident; 5 of the 6 identifiable payers had a bad outcome across 4 distinct defects; removes the highest-severity and most store-policy-exposed failures and directly affects revenue realisation

- **Where:** §8.1 F1 — audit the purchase flow end to end: entitlement delivery, the monthly SKU and the Lifetime-vs-Yearly labelling; treat paid-no-unlock as a P0 incident; removes the highest-severity, most store-policy-exposed failures and directly affects revenue realisation
- **This app does:** broken purchase flow
- **User reaction:** 1★-burst
- **Magnitude:** 5 of 6 payers; 4 defects
- **Direction for us:** must-never-break · **Report confidence:** high severity · **Generalisable:** yes
- **Review IDs:** `13670832453`, `13678734774`, `13705764332`, `14264524351`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R30-079 — F3: fix the Arabic-locale name-entry blocker — 2 of 3 Saudi reviews, both 1★; a hard block at first launch for an entire locale, a small fix with total impact for affected users

- **Where:** §8.1 F3 — fix the Arabic-locale name-entry blocker: a hard block at first launch for an entire locale, small fix, total impact for affected users
- **This app does:** onboarding name field
- **User reaction:** 1★-burst
- **Magnitude:** 2 of 3 SA
- **Direction for us:** must-never-break · **Report confidence:** limited, hard block · **Generalisable:** yes
- **Review IDs:** `13511113509`, `13596102043`
- **Canonical:** C228 Text fields must handle IME composition — Hangul and CJK input

### R30-083 — F7: fix the scroll-jump-to-top bug and add a compact list density — it only manifests above ~10 habits, i.e. it degrades the paid experience specifically; fix it before F2 raises habit counts

- **Where:** §8.1 F7 — fix the scroll-jump-to-top bug and add a compact list density; it only manifests above ~10 habits so it degrades the paid experience specifically — fix it before F2 raises habit counts
- **This app does:** list scroll resets on tick
- **User reaction:** complaint
- **Magnitude:** 1 (GB, 3★)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13032875149`
- **Canonical:** C083 Performance must not degrade with habit count; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

## Features

### R30-008 — The Home Screen widget is paywalled and it is costing installs to competitors — only 2 reviews (1.20%, meaningful) name it but one is an explicit documented switch to a rival: 'скачивала только ради виджета. Оказалось, это платная фича… У конкурентов эта фича входит в бесплатную версию — ушла туда' ('I downloaded it only for the widget. Turned out it's a paid feature… competitors include it free — I went there', RU, 4★); the other is a 5★ whose only negative sentence is the same fact; a third reviewer reports the widget shown in the store screenshots is not the widget the app provides (UY, 5★); the one reviewer who has the widget is unreservedly positive (KR, 5★); low count, high diagnostic value — the widget is both an acquisition promise and a paywall, and the screenshots write a cheque the free tier does not honour

- **Where:** Executive summary #6 — the Home Screen widget is paywalled and costing installs to competitors: 'I downloaded it only for the widget. Turned out it's a paid feature… competitors include it free — I went there' (4★); a 5★ whose only negative is the same fact; the widget in the store screenshots is not the widget the app provides; the one user who has it is unreservedly positive — an acquisition promise and a paywall at once, screenshots writing a cheque the free tier does not honour
- **This app does:** widget paid; screenshots show a different widget
- **User reaction:** churn
- **Magnitude:** 2 (1.20%) + 1 mismatch + 1 praise
- **Direction for us:** free · **Report confidence:** meaningful — high diagnostic · **Generalisable:** yes
- **Review IDs:** `13081229555`, `13130702696`, `13706323164`, `14107277631`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app; C107 Widget variants and customisation as the paid layer; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R30-009 — Scheduling flexibility is the only genuine feature gap with multi-market evidence: 4 reviews (2.41%, meaningful) from 4 storefronts ask for habits that are not every-day — day-of-week selection (KZ, CL), weekly/monthly habits (GB), frequency configuration (ES); the CL 4★ documents the downstream damage precisely: using Skip breaks the daily completion ring, and deleting a finished habit destroys its history because there is no end-date; the one build-it item on the list, and it is small — a frequency field plus an end-date field

- **Where:** Executive summary #7 — scheduling flexibility is the only genuine feature gap with multi-market evidence: 4 (2.41%) from 4 storefronts want non-daily habits — day-of-week, weekly/monthly, frequency configuration; Skip breaks the daily completion ring, and deleting a finished habit destroys its history because there is no end-date — a frequency field plus an end-date field
- **This app does:** daily-only habits; no end date
- **User reaction:** complaint
- **Magnitude:** 4 (2.41%) from 4 storefronts
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13249103798`, `13176696608`, `13032875149`, `13705764332`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C041 Editing a habit never wipes its history; C043 Flexible / custom frequency

### R30-014 — Creating and checking off daily habits is free but capped at 2, then 3; unlimited habits and the Home Screen widget are the paid unlock; the interactive/streak widget shown in the screenshots does not match the app's actual widget

- **Where:** §2.1 Create + check off daily habits free, capped at 2 then 3; unlimited habits paid; Home Screen widget paid; the interactive/streak widget in screenshots mismatches the app's actual widget
- **This app does:** cap + paid widget
- **User reaction:** complaint
- **Magnitude:** inventory rows
- **Direction for us:** free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `13015082250`, `14262833547`, `13441364320`, `13707712022`, `14007543484`, `14107277631`, `13130702696`, `13081229555`, `13706323164`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C040 Widgets must not go blank, stale or disagree with the app; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R30-015 — Reminders exist (an alarm is requested as an upgrade on them); progress/streak tracking and a daily completion ring are free; history editing works inside the current month but not for prior months; edit/delete/pause exist but users cannot find them; Skip exists and breaks the daily completion ring; there is no habit end-date, so deleting is the only way out and it wipes history; there is no day-of-week / weekly / monthly frequency and no per-habit or per-day percentages

- **Where:** §2.1 Reminders present (an alarm requested as an upgrade); progress/streak tracking and a daily completion ring free; within-month history editing works but not to prior months; edit/delete/pause exist but users cannot find them; Skip exists and breaks the completion ring; no habit end-date (deleting wipes history); no day-of-week/weekly/monthly frequency; no per-habit/per-day percentages
- **This app does:** basic free core with discoverability gaps
- **User reaction:** complaint
- **Magnitude:** inventory rows
- **Direction for us:** must-have · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `13267951780`, `12950173104`, `13176696608`, `13710940338`, `13085435338`, `13324437553`, `13576406218`, `13449993538`, `13249103798`, `13032875149`, `13705764332`
- **Canonical:** C010 Backfill missed days / edit start date; C012 Week / month / year grid views; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C039 Reminders fire reliably, once; C043 Flexible / custom frequency; C142 Surface existing features where users look

### R30-016 — Localisation works in ES, RU, KO, AR, PT, FR, DE, NL, IT, HE, JA, TR and UK; name/profile entry at onboarding is broken for Arabic-locale users; colour themes and iCloud sync appear on the store page only — no reviewer mentions either, which for a paid-feature list is itself notable

- **Where:** §2.1 Localisation in 13 languages functioning; name/profile entry at onboarding broken for Arabic-locale users; colour themes and iCloud sync on the store page only — no reviewer mentions either
- **This app does:** broad localisation; Arabic onboarding bug
- **User reaction:** complaint
- **Magnitude:** 2 name-entry bug reviews
- **Direction for us:** must-never-break · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `13941632555`, `14107277631`, `13511113509`, `13596102043`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C027 Localise early — it unlocks revenue; C228 Text fields must handle IME composition — Hangul and CJK input

### R30-027 — Any feature request (union)

- **Where:** §3.1 Master table #7 Any feature request (union)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 (4.82%, very strong), sub. 17.0%, mean 3.88
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R30-028 — UI / visual design praised

- **Where:** §3.1 Master table #9 UI / visual design praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 6 (3.61%, very strong), mean 4.83
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C057 Offer a non-pastel / premium design option

### R30-086 — E2: widget free vs paid — hypothesis: the widget is an acquisition driver being used as a paywall; a documented, completed switch to a competitor with a free widget, and the widget is the engagement loop for the happiest user in the corpus; read-out: install → activation and churn to competitors

- **Where:** §8.3 E2 — widget free vs paid: the widget is an acquisition driver being used as a paywall — a documented completed switch to a free-widget competitor, and the widget is the engagement loop for the happiest user; read-out install→activation and churn to competitors
- **This app does:** widget paid
- **User reaction:** churn
- **Magnitude:** experiment
- **Direction for us:** free · **Report confidence:** hypothesis · **Generalisable:** yes
- **Review IDs:** `13081229555`, `14107277631`
- **Canonical:** C005 Know which competitors buyers compare against; C040 Widgets must not go blank, stale or disagree with the app; C107 Widget variants and customisation as the paid layer

### R30-088 — E4: alarm-style reminders — users are setting a second alarm in the system Clock app because the notification is not strong enough ('assim a pessoa recebe um alarme com o próprio app e não precisa fazer outro alarme no celular'); read-out: notification → completion rate

- **Where:** §8.3 E4 — alarm-style reminders: users set a second alarm in the system Clock because the notification is not strong enough ('receives an alarm from the app itself and doesn't need another alarm'); read-out notification → completion rate
- **This app does:** notification only
- **User reaction:** complaint
- **Magnitude:** 1 (BR, 4★)
- **Direction for us:** research · **Report confidence:** hypothesis · **Generalisable:** yes
- **Review IDs:** `13267951780`
- **Canonical:** C039 Reminders fire reliably, once

## Monetization

### R30-003 — The free-tier habit cap is this product's defining problem: 15 of 166 reviews (9.04%, high-priority, mean 2.00) name the free-habit limit as the reason for their rating — 31.9% of the 47 substantive reviews, 8 of 19 one-star reviews, and all 3 two-star reviews — 'Se o app é de habitos, deixar cadastrar somente 2 é demais' ('if the app is about habits, allowing only 2 is too much', BR, 2★); 'yeah your premium plan not so expensive, but it should be at least 5 free habit entry' (KZ, 1★); 'It would be smarter to create attractive features that persuade the user to pay rather than limiting tracking to a mere two' (TR, 1★); 'Всего 2 бесплатные привычки…' (RU, 1★); a 2–3 habit cap is below the minimum viable unit of the job — a habit tracker with three habits is a to-do list, users say so, and the cap does not convert them: it produces a 1★ review and an uninstall

- **Where:** Executive summary #1 — the free-tier habit cap is the defining problem: 15 (9.04%, HIGH, mean 2.00) name it — 31.9% of the 47 substantive reviews, 8 of 19 one-stars, all 3 two-stars ('if the app is about habits, allowing only 2 is too much'; 'your premium plan not so expensive, but it should be at least 5 free habit entry'; 'It would be smarter to create attractive features that persuade the user to pay rather than limiting tracking to a mere two'); a 2–3 habit cap is below the minimum viable unit of the job — it produces a 1★ and an uninstall, not a conversion
- **This app does:** 2-then-3 free habits
- **User reaction:** 1★-burst
- **Magnitude:** 15 (9.04%, high-priority), mean 2.00; 15/47 substantive (31.9%); 8/19 1★; 3/3 2★
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13441364320`, `13139338718`, `13286447070`, `13015082250`, `13057771438`, `13078324005`, `13283076453`, `13487320234`, `13678734774`, `13679689890`, `13707712022`, `13710940338`, `14007543484`, `14262833547`, `14438894096`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R30-007 — The price complaint is a value complaint and the corpus contains its own counter-evidence: 5 reviews (3.01%, very strong, mean 1.40) object to price, but two of the harshest sceptics say the price itself is fine — 'ce n'est pas cher' (FR, still 2★ because of the cap) and 'your premium plan not so expensive, but…' (KZ, 1★) — and a 5★ volunteers 'также понравилась цена!' ('I also liked the price'); the objection is always price ÷ what you get free — 'Una app muy cara para tan poco… Es un check list CARÍSIMO' (AR, 1★); 'The price is too high for this quality' (JP, 1★); 'para ser de pago es demasiado simple' (ES, 1★); raising the free cap is a cheaper fix than cutting the price and the corpus predicts it would neutralise most of the price objection too

- **Where:** Executive summary #5 — the price complaint is a value complaint with its own counter-evidence: 5 (3.01%, mean 1.40) object — but harsh sceptics say the price is fine ('ce n'est pas cher' still 2★ because of the cap; 'your premium plan not so expensive, but…') and a 5★ likes the price; the objection is always price ÷ what you get free ('a very expensive app for so little… a VERY EXPENSIVE checklist'; 'too simple for a paid app') — raising the free cap is cheaper than cutting price and would neutralise most price objection
- **This app does:** $5.99/mo, $29.99–44.99/yr, $59.99 lifetime
- **User reaction:** complaint
- **Magnitude:** 5 (3.01%, very strong), mean 1.40; 2 say price is fine; 1 5★ likes price
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13487320234`, `13139338718`, `12933316146`, `13755696898`, `13625113466`, `13705764332`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C133 Gate on capability, not on quantity

### R30-017 — Store listing (US, accessed 11 Sep 2026): Monthly Premium $5.99, Yearly Premium $44.99, Yearly Premium (second SKU) $29.99, Lifetime Premium $59.99; 'Track up to 2 habits with free version'; advertises the streak/interactive widget, iCloud sync, history, colour themes and multi-language support; version 1.4.7 updated ~8 Sep 2026; US rating 4.9★ from 45 ratings

- **Where:** §2.2 External SKU table (verbatim) — Monthly $5.99 · Yearly $44.99 · Yearly (second SKU) $29.99 · Lifetime $59.99; listing 'Track up to 2 habits with free version', advertises streak/interactive widget, iCloud sync, history, colour themes, multi-language; v1.4.7 ~8 Sep 2026; US 4.9★ from 45
- **This app does:** four SKUs incl. two yearly
- **User reaction:** none
- **Magnitude:** SKU | Price ; Monthly Premium | $5.99 ; Yearly Premium | $44.99 ; Yearly Premium (second SKU) | $29.99 ; Lifetime Premium | $59.99
- **Direction for us:** none · **Report confidence:** external · **Generalisable:** app-specific
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R30-024 — Any monetisation friction (union)

- **Where:** §3.1 Master table #1 Any monetization friction (union)
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 29 (17.47%, HIGH), sub. 61.7%, mean 2.17
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R30-026 — Paywall too aggressive / 'not really free' — the framing objection

- **Where:** §3.1 Master table #6 Paywall too aggressive / 'not really free'
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 11 (6.63%, HIGH), sub. 23.4%, mean 1.82
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C133 Gate on capability, not on quantity; C147 Let people use the product before they pay

### R30-029 — 'Too basic / too thin for the price' — every one also carries a price objection

- **Where:** §3.1 Master table #12 'Too basic / too thin for the price'
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 (2.41%, meaningful), mean 1.50
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R30-030 — Price described as acceptable

- **Where:** §3.1 Master table #13 Price described as acceptable
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 3 (1.81%, meaningful), mean 2.67
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R30-032 — No free trial

- **Where:** §3.1 Master table #16 No free trial
- **This app does:** see §3.1
- **User reaction:** blocked-conversion
- **Magnitude:** 2 (1.20%, meaningful), mean 1.00
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C063 Free trial before purchase

### R30-043 — Paywall too aggressive / 'not really free' (11, 6.63%, mean 1.82) — distinct from the cap, this is the framing objection that the app presents as free and is not: 'В данном случае приложение полностью теряет свой смысл как «бесплатное»' ('in this case the app completely loses its meaning as free', RU); 'in app have paid offers, but this is not writes in a Appstore' (UA); 'Para todas las opciones tenes que tener la versión paga' (AR); 'Bitte mehr für kostenlose Nutzer' ('please more for free users', DE — the only 5★ in the theme); a 3★ is pure confusion — the reviewer cannot work out whether the app is paid or free

- **Where:** §3.3 Paywall too aggressive / 'not really free' — the framing objection distinct from the cap: 'in this case the app completely loses its meaning as free'; 'in app have paid offers, but this is not writes in a Appstore'; 'For all the options you need the paid version'; 'Bitte mehr für kostenlose Nutzer' (the only 5★); one 3★ cannot work out whether the app is paid or free
- **This app does:** presented as free, heavily gated
- **User reaction:** 1★-burst
- **Magnitude:** 11 (6.63%), mean 1.82
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13078324005`, `13214738742`, `13283076453`, `13286447070`, `13441364320`, `13487320234`, `13679689890`, `13682739906`, `13707712022`, `13864202916`, `13882804582`
- **Canonical:** C133 Gate on capability, not on quantity; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R30-059 — Only two features are ever named as worth paying for: more habits (all 15 cap reviews, with the users' own anchor 'at least 5 free habit entry') and the widget (one downloaded solely for it, one wanted it, the happiest reviewer in the corpus uses it, one wants the widget from the screenshots); no reviewer anywhere mentions iCloud sync, colour themes or statistics as a reason to pay — even though the first two are advertised paid features

- **Where:** §5.2 What triggers the desire to upgrade — only two features are ever named: more habits (all 15 cap reviews; 'at least 5 free habit entry') and the widget (downloaded solely for it; the happiest reviewer uses it; wants the one in the screenshots); nobody mentions iCloud sync, colour themes or statistics as a reason to pay though the first two are advertised paid features
- **This app does:** unlimited habits + widget as the paid layer
- **User reaction:** purchase-driver
- **Magnitude:** 15 + 4
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13139338718`, `13081229555`, `13130702696`, `14107277631`, `13706323164`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C013 Cloud sync / multi-device as the paid differentiator; C107 Widget variants and customisation as the paid layer

### R30-060 — Upgrade barriers by evidence weight: the cap is too low to evaluate the product (15 — you cannot experience a habit tracker with 2–3 habits, so nothing builds the intent to pay); no trial (2 — 'перед тим як щось придбати треба ж спробувати це', 'before buying something you should be able to try it'); perceived value gap at the price point (5 — price × thinness, not price alone); purchase-flow defects (4 — the user tried to give money and the flow failed); free alternatives give away the paywalled feature (1 — a documented, completed switch); confusion about whether it's paid at all (1 — a 3★ who never resolved it)

- **Where:** §5.3 Upgrade barriers in order of evidence weight (verbatim table) — cap too low to evaluate (15: you cannot experience a habit tracker with 2–3 habits so nothing builds intent to pay); no trial (2: 'before buying something you should be able to try it'); perceived value gap (5); purchase-flow defects (4); free alternatives give away the paywalled feature (1, a completed switch); confusion about whether it's paid (1)
- **This app does:** cap below evaluation threshold; no trial; broken flow
- **User reaction:** blocked-conversion
- **Magnitude:** Barrier | n | IDs | Nature ; Cap too low to evaluate the product | 15 | Part 3.3 | You cannot experience a habit tracker with 2–3 habits, so nothing builds the intent to pay ; No trial | 2 | 13680381966, 13679689890 | *"перед тим як щось придбати треба ж спробувати це"* — "before buying something you should be able to try it" ; Perceived value gap at the price point | 5 | Part 3.3 | Price × thinness, not price alone ; Purchase flow defects | 4 | Part 5.1 | The user tried to give money and the flow failed ; Free alternatives give away the paywalled feature | 1 | 13081229555 | Documented, completed switch to a competitor ; Confusion about whether it's paid at all | 1 | 13214738742 | 3★ from a user who never resolved the question
- **Direction for us:** product-rule · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `13680381966`, `13679689890`, `13081229555`, `13214738742`
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R30-082 — F6: introduce a trial, or a reversible first purchase — directly addresses the two no-trial 1★ reviews (paid annual blind; won't buy without trying) and the 3★ that cannot tell whether the app is paid

- **Where:** §8.1 F6 — introduce a trial, or a reversible first purchase: addresses the two no-trial 1★ reviews ('paid annual blind'; 'won't buy without trying') and the review that cannot tell if the app is paid
- **This app does:** no trial
- **User reaction:** blocked-conversion
- **Magnitude:** 2 + 1
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13680381966`, `13679689890`, `13214738742`
- **Canonical:** C063 Free trial before purchase

### R30-085 — E1: free cap at 5 vs 3 — hypothesis: raising the cap increases both retention and paid conversion because evaluation becomes possible, predicted by every cap review and stated outright ('It would be smarter to create attractive features that persuade the user to pay rather than limiting tracking to a mere two'); read-out: conversion rate, D7/D30 retention, 1★ rate

- **Where:** §8.3 E1 — free cap at 5 vs 3: raising the cap increases both retention and paid conversion because evaluation becomes possible (predicted by every cap review; 'It would be smarter to create attractive features that persuade the user to pay'); read-out conversion, D7/D30 retention, 1★ rate
- **This app does:** 3-habit cap
- **User reaction:** blocked-conversion
- **Magnitude:** experiment
- **Direction for us:** research · **Report confidence:** hypothesis · **Generalisable:** yes
- **Review IDs:** `13286447070`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R30-087 — E3: collapse the SKU shelf — four SKUs including two yearly prices and a $59.99 'Lifetime' generated the mis-sold-lifetime 1★; a simpler shelf should reduce refunds and mis-sale complaints; read-out: refund rate and 1★ rate on purchase themes

- **Where:** §8.3 E3 — collapse the SKU shelf: four SKUs including two yearly prices and a $59.99 'Lifetime' generated the mis-sold-lifetime 1★; a simpler shelf should reduce refunds and mis-sale complaints; read-out refund rate and purchase-theme 1★
- **This app does:** four overlapping SKUs
- **User reaction:** 1★-burst
- **Magnitude:** experiment
- **Direction for us:** research · **Report confidence:** hypothesis · **Generalisable:** yes
- **Review IDs:** `13705764332`
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

## Tactics the app used

### R30-091 — Tactic and outcome: two phrase-bank 5★ campaigns seeded the launch rating — 83 of 166 reviews (50%) from a five-phrase list in several languages, one English-language wave (Jul–Sep 2025, GB+US 38) and one Spanish/Dutch wave (Nov–Dec 2025, ES+CL 16), a Dutch sentence concatenating all five phrases posted on the Russian storefront; outcome: a public 4.4★ (4.9★ US listing) that is a decaying artefact — the campaigns stopped after January 2026, the half-year mean fell 4.65 → 3.17 → 3.00, the organic 1★ rate rose 12.5% → 44.4%, and the US and GB storefronts are commercially unmeasured because they contain almost nothing else

- **Where:** Warning #1 / §2.3 / §7.3 — tactic: two seeded 5★ launch-review campaigns (EN Jul–Sep 2025, ES/NL Nov–Dec 2025) and their outcome
- **This app does:** seeded 5★ phrase-bank campaigns
- **User reaction:** 5★-burst
- **Magnitude:** 83/166 (50%) all 5★; mean 4.65 → 3.00; organic 1★ 12.5% → 44.4%
- **Direction for us:** dont · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `13403875241`, `13404072755`, `13442553415`, `12928535001`, `13406815450`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R30-092 — Tactic and outcome: the developer answered the cap complaint by raising the free limit from 2 to 3 habits between February and April 2026; the complaint continued at the same rate and with the same ratings (1★, 3★, 4★), the listing kept saying 2, and a reviewer had already named 5 as the floor — an increment below the threshold of evaluability changes nothing

- **Where:** §3.3 / §7.2 — tactic: raising the free cap by one habit (2 → 3) in response to cap complaints, and its outcome
- **This app does:** cap 2 → 3
- **User reaction:** complaint
- **Magnitude:** 12 say 2, then 3 say 3; same ratings
- **Direction for us:** product-rule · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `14007543484`, `14262833547`, `14438894096`, `13139338718`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C059 Be visibly responsive; fixes bring reviewers back

## Insights (the why)

### R30-004 — 84% of one-star reviews are about money, not the software: 16 of 19 1★ (84.2% segment; 16 of 166 = 9.64% global, high-priority) are monetisation or billing complaints — the cap (8), price-for-value (4), no trial (2), a failed charge (1), a denied refund (1), undisclosed IAP (1), mis-sold 'lifetime' (1); only 3 of 19 describe a software defect (can't edit a habit; a name-entry bug ×2); the app is not being rated down for quality but for its business model — engineering work will not move this rating; packaging will

- **Where:** Executive summary #2 — 84% of one-star reviews are about money, not software: 16 of 19 1★ (9.64% global) are monetisation or billing — cap 8, price-for-value 4, no trial 2, failed charge 1, denied refund 1, undisclosed IAP 1, mis-sold lifetime 1; only 3 describe a defect; the app is rated down for its business model, so engineering will not move the rating — packaging will
- **This app does:** capped freemium
- **User reaction:** 1★-burst
- **Magnitude:** 16/19 1★ (84.2%); 9.64% global
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13576406218`, `13511113509`, `13596102043`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R30-006 — What people genuinely like is one attribute — minimalism — stated with a specificity the templated reviews never reach: 23 of 166 (13.86%, high-priority, mean 5.00) praise simplicity/minimalism and 12 (7.23%, high-priority) everyday convenience — 'минималистичное без лишнего мусора' ('minimalist, no unnecessary junk'); 'Good app, minimalistic, effective'; 'Muy practica, minimalista y buena app!'; 'Clean UI, awesome app'; 'понятный и удобный интерфейс. Без заморочек'; 7 (4.22%, very strong) report a concrete behaviour outcome ('finally started sticking to healthy eating and a little sport'; 'that description is exactly right; I keep it as a widget and practise small habits', KR); the product thesis works and the packaging is what fails — do not respond by adding features: the 4 reviewers (2.41%) calling the app too thin are making a price objection, not a feature request

- **Where:** Executive summary #4 — what people genuinely like is one attribute, minimalism, stated with specificity the templated reviews never reach: 23 (13.86%, mean 5.00) praise simplicity and 12 (7.23%) everyday convenience ('minimalist, no unnecessary junk'; 'Good app, minimalistic, effective'; 'Clean UI'); 7 (4.22%) report a behaviour outcome ('finally started sticking to healthy eating and a little sport'; 'I keep it as a widget and practise small habits'); the thesis works, the packaging fails — do not respond by adding features; the 4 who call it too thin mean for its price
- **This app does:** minimalist tracker
- **User reaction:** praise
- **Magnitude:** simplicity 23 (13.86%), mean 5.00; convenience 12 (7.23%); outcomes 7 (4.22%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `14338216422`, `13292317774`, `14008217420`, `13701569896`, `12868175538`, `12958650866`, `14107277631`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R30-021 — What the phrase bank does and does not license: it does make the 4.398 mean, the 80.1% 5★ share and every US/GB/ES/NL figure unusable as satisfaction measures; it does not make the positive findings false — 42 reviews (25.3%) give a reason for liking the app and the specific, idiosyncratic ones read as genuine; it does not touch the negative findings at all, since 0 of 83 phrase-bank reviews are below 5★ and every complaint comes from the organic 83; interpretation (pattern, not attribution): the seeded reviews were bought to establish a launch rating and are now expiring, which is precisely why the half-year mean has fallen 4.65 → 3.00

- **Where:** §2.3 What this does and does not license — it makes the 4.398 mean, 80.1% 5★ share and every US/GB/ES/NL figure unusable as satisfaction; it does not make the positive findings false (42 give a reason; specific idiosyncratic ones read as genuine); it does not touch the negative findings (0 of 83 phrase-bank below 5★); interpretation: the seeded reviews were bought to establish a launch rating and are expiring, which is why the half-year mean fell 4.65 → 3.00
- **This app does:** seeded launch rating decaying
- **User reaction:** mixed
- **Magnitude:** 42 with reasons; 0 of 83 negative
- **Direction for us:** dont · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `14338216422`, `13292317774`, `14008217420`, `12868175538`, `14107277631`, `12958650866`, `13242409709`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R30-022 — The substantive segment: 47 of 166 (28.31%) — 1★19 · 2★3 · 3★4 · 4★7 · 5★14, mean 2.87 — while the 119 non-substantive reviews are all 5★ (mean 5.00); all 33 sub-5★ reviews are substantive and zero are phrase-bank — the cleanest structural fact in the data: everyone who had something specific to say about this product, and was not part of the phrase bank, rated it 2.87 on average

- **Where:** §2.4 The substantive segment — 47 of 166 (28.31%), rating 1★19 · 2★3 · 3★4 · 4★7 · 5★14, mean 2.87; the 119 non-substantive are all 5★ (mean 5.00); all 33 sub-5★ reviews are substantive and zero are phrase-bank — everyone with something specific to say rated it 2.87
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 47 (28.31%), mean 2.87 vs 119 at 5.00
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R30-038 — Simplicity/minimalism (23, 13.86%, mean 5.00) — caveat: 9 of the 23 are SIMPLE_PERFECT phrase-bank strings; the organic 14 remain the largest genuine positive theme and describe the same attribute in their own words: 'понятный и удобный интерфейс. Без заморочек' ('clear, convenient interface, no fuss'); 'минималистичное без лишнего мусора'; 'Muy practica, minimalista'; 'Good app, minimalistic, effective'; 'Clean UI, awesome app'; 'es sencilla y fácil de usar'

- **Where:** §3.2 Simplicity — 23 (13.86%, mean 5.00); caveat: 9 are SIMPLE_PERFECT phrase-bank strings; the organic 14 remain the largest genuine positive theme ('clear, convenient interface, no fuss'; 'minimalist, no unnecessary junk'; 'es sencilla y fácil de usar')
- **This app does:** minimalist
- **User reaction:** praise
- **Magnitude:** 23 (14 organic)
- **Direction for us:** product-rule · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `12868175538`, `12879111396`, `12906449491`, `12928535001`, `12951242331`, `12952151986`, `13028574593`, `13105956090`, `13130702696`, `13292317774`, `13330607664`, `13351540188`, `13403875241`, `13404072755`, `13406815450`, `13449993538`, `13524579586`, `13572998737`, `13701569896`, `13706323164`, `14008217420`, `14338216422`, `14445598360`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R30-039 — Everyday convenience (12, 7.23%, mean 5.00): 'Удобное приложение, чтобы отслеживать свои успехи в любых начинаниях. Помогает не забыть сделать что-то' ('convenient for tracking progress in any undertaking; helps me not forget to do something'); 'Cool and convenient application for life'; 'it's convenient to record all your habits and goals'

- **Where:** §3.2 Everyday convenience — 12 (7.23%, mean 5.00): 'convenient for tracking progress in any undertaking; helps me not forget to do something'; 'Cool and convenient application for life'
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 12 (7.23%)
- **Direction for us:** none · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `12868175538`, `12898221749`, `12906449491`, `12927513076`, `12943312203`, `12950173104`, `12999068209`, `12999307390`, `13017650184`, `13040469782`, `14338216422`, `14445598360`
- **Canonical:** — (nuance register)

### R30-040 — Concrete behaviour change (7, 4.22%, very strong, mean 5.00) — the strongest outcome claims: 'Я настолько изменился из за этого приложения… благодаря вам я достигаю того чего ждала 12 лет' ('I've changed so much because of this app… thanks to you I'm reaching what I waited 12 years for', AM); 'I finally started sticking to healthy eating and a bit of sport'; 'It's very easy to instill new habits!'; 'I keep it up as a widget and I'm practising small habits… very good' (KR) — the product's proof of value and the argument for fixing the packaging rather than the product

- **Where:** §3.2 Concrete behaviour change — 7 (4.22%, mean 5.00): 'I've changed so much because of this app… I'm reaching what I waited 12 years for'; 'I finally started sticking to healthy eating'; 'It's very easy to instill new habits!'; 'I keep it up as a widget and I'm practising small habits' — the product's proof of value and the argument for fixing packaging, not product
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 7 (4.22%), mean 5.00
- **Direction for us:** none · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12950173104`, `12958650866`, `13152209815`, `13242409709`, `13710940338`, `14072034839`, `14107277631`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R30-041 — UI/design praised by 6 (3.61%, mean 4.83), one of them a 4★ that opens with design praise and then reports a billing failure; localisation praised once ('Idioma en español y buen diseño de app', CL) — limited evidence, but the only explicit localisation compliment and from a Spanish-language market where 13 of 13 other ES/CL-storefront reviews say nothing specific

- **Where:** §3.2 UI / design — 6 (3.61%, mean 4.83), one a 4★ opening with design praise then reporting a billing failure; localisation — 1 explicit compliment ('Idioma en español y buen diseño de app') from a Spanish-language market where 13 of 13 other ES/CL reviews say nothing specific (limited evidence)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 6; 1
- **Direction for us:** none · **Report confidence:** limited · **Generalisable:** app-specific
- **Review IDs:** `12868175538`, `12943312203`, `13028574593`, `13678734774`, `13701569896`, `13941632555`
- **Canonical:** C027 Localise early — it unlocks revenue; C057 Offer a non-pastel / premium design option

### R30-053 — 5★ (n=133): 119 (89.5%) contain no specific content — 83 phrase-bank and 36 equally short non-template ('Все супер', 'Amazing'); the 14 substantive split into genuine outcome reports, specific praise, and five-star reviews carrying a complaint — the cap, the widget paywalled, 'more for free users', can't find delete/edit, can't edit prior months, slow and the wrong widget in screenshots; 6 of the 14 substantive 5★ contain a negative — the 5★ bucket is not a clean satisfaction signal even after the phrase bank is removed

- **Where:** §4.1 5★ — 119 of 133 (89.5%) contain no specific content; the 14 substantive split into outcome reports, specific praise, and 5★ reviews carrying a complaint (cap; widget paywalled; more for free users; can't find delete/edit; can't edit prior months; slow + wrong widget in screenshots) — 6 of 14 substantive 5★ contain a negative: not a clean satisfaction signal even after removing the phrase bank
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 119/133 contentless; 6/14 substantive 5★ negative
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13242409709`, `12958650866`, `13152209815`, `14107277631`, `12950173104`, `14338216422`, `13292317774`, `14008217420`, `13941632555`, `13701569896`, `14445598360`, `13710940338`, `13130702696`, `13682739906`, `13449993538`, `13085435338`, `13706323164`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R30-054 — 4★ (n=7) all follow the identical shape — sincere praise, then one blocking specific: won't open ('I don't want to spoil your rating, but please update the app'), widget paywalled → switched to a competitor, scheduling/end-date/percentages/skip/data loss, an alarm request, can't pause or edit, can't buy monthly + cap, the 3-habit cap; five of the seven blockers are monetisation or purchase-flow items

- **Where:** §4.2 4★ — all 7 follow the identical shape: sincere praise then one blocking specific ('I don't want to spoil your rating, but please update the app'); five of the seven blockers are monetisation or purchase-flow items (widget paywall → switched to a competitor; can't buy monthly + cap; 3-habit cap)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 7; 5/7 monetisation
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `12886833369`, `13081229555`, `13176696608`, `13267951780`, `13324437553`, `13678734774`, `14007543484`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R30-055 — 3★ (n=4): crashes (RU); glitches, scroll-jump, thin functionality and 'not really worth the money' (GB); cannot determine whether the app is free or paid (TR); 3-habit maximum (RU)

- **Where:** §4.3 3★ — crashes; glitches + scroll-jump + thin functionality + 'not really worth the money'; cannot determine whether the app is free or paid; 3-habit max
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 4
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `12883902100`, `13032875149`, `13214738742`, `14262833547`
- **Canonical:** — (nuance register)

### R30-069 — Global vs Russia vs high-spend vs long tail: mean 4.40 / 4.52 / 4.79 / 3.19; substantive share 28.3% / 26.8% / 13.8% / 69.4%; substantive mean 2.87 / 3.20 / 3.50 / 2.40; phrase-bank share 50.0% / 46.4% / 67.2% / 8.3%; monetisation friction 17.5% / 16.1% / 8.6% / 47.2% — the pattern is consistent in every cut: where the phrase bank is absent the substantive rating is 2.4–3.5 and monetisation is the complaint; in the long tail (36 reviews outside the five high-volume storefronts) 47.2% of all reviews carry a monetisation complaint and the headline mean is 3.19

- **Where:** §6.7 Global vs country comparison (verbatim table) — mean 4.40 / RU 4.52 / high-spend 4.79 / long tail 3.19; substantive share 28.3 / 26.8 / 13.8 / 69.4%; substantive mean 2.87 / 3.20 / 3.50 / 2.40; phrase-bank 50.0 / 46.4 / 67.2 / 8.3%; monetisation friction 17.5 / 16.1 / 8.6 / 47.2% — where the phrase bank is absent the substantive rating is 2.4–3.5 and monetisation is the complaint; in the long tail 47.2% carry a monetisation complaint at mean 3.19
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Dimension | Global (166) | Russia (56) | High-spend (58) | Long tail (36) ; Mean ★ | 4.40 | 4.52 | 4.79 | 3.19 ; Substantive share | 28.3% | 26.8% | 13.8% | 69.4% ; Substantive mean ★ | 2.87 | 3.20 | 3.50 | 2.40 ; Phrase-bank share | 50.0% | 46.4% | 67.2% | 8.3% ; Monetization friction | 17.5% | 16.1% | 8.6% | 47.2%
- **Direction for us:** product-rule · **Report confidence:** high · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C062 Weight English-speaking rich markets; volume ≠ revenue

### R30-076 — What did not change: simplicity praise is present in every period and is the only constant positive; the cap complaint is present in all 13 months, before and after the 2→3 change; the widget-paywall complaint spans Sep 2025 to Feb 2026, persistent and never addressed; nobody has ever mentioned iCloud sync or colour themes — both advertised paid features — in any period or any market

- **Where:** §7.7 What did not change — simplicity praise in every period (the only constant positive); the cap complaint in all 13 months before and after 2→3; the widget-paywall complaint Sep 2025 → Feb 2026, never addressed; nobody has ever mentioned iCloud sync or colour themes in any period or market
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 13 months
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13130702696`, `13706323164`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C007 Generous fixed habit cap (or unlimited) — never change it; C013 Cloud sync / multi-device as the paid differentiator; C040 Widgets must not go blank, stale or disagree with the app

## Markets and languages

### R30-063 — Storefront distribution with phrase-bank and substantive counts: RU 56 (33.7%, mean 4.52, phrase-bank 26 = 46%, substantive 15, 1★ 5, Jul 2025 → Aug 2026); US 31 (5.00, 22 = 71%, 1, 0); GB 19 (4.89, 16 = 84%, 2, 0, Jul–Sep 2025 only); ES 13 (4.69, 10 = 77%, 1, 1); CL 11 (4.82, 6 = 55%, 3, 0); AR 4 (2.00, 0, 3, 3); BR 4 (3.75, 0, 4, 0); FR 4 (3.50, 1, 2, 0); KZ 4 (4.00, 0, 2, 1); NL 3 (5.00, 2, 0, 0); SA 3 (2.33, 0, 2, 2); UA 3 (2.33, 0, 2, 2); DE 2 (5.00); TR 2 (2.00); AM, IL, IT, JP, KR, MX, UY 1 each (0 phrase-bank, 7 substantive, 4 1★); only Russia clears 50

- **Where:** §6.1 Distribution (verbatim table) — RU 56 (4.52, phrase-bank 46%, substantive 15, 1★ 5); US 31 (5.00, 71% phrase-bank, 1 substantive); GB 19 (4.89, 84%); ES 13 (4.69, 77%); CL 11 (4.82, 55%); AR 4 (2.00, 0%, 3 1★); BR 4 (3.75); FR 4 (3.50); KZ 4 (4.00); NL 3; SA 3 (2.33); UA 3 (2.33); DE 2; TR 2 (2.00); 7 singletons; only Russia clears 50
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Country | n | % | Mean ★ | Phrase-bank | Substantive | 1★ | Date span ; RU | 56 | 33.7% | 4.52 | 26 (46%) | 15 | 5 | 2025-07 → 2026-08 ; US | 31 | 18.7% | 5.00 | 22 (71%) | 1 | 0 | 2025-07 → 2026-07 ; GB | 19 | 11.4% | 4.89 | 16 (84%) | 2 | 0 | 2025-07 → 2025-09 ; ES | 13 | 7.8% | 4.69 | 10 (77%) | 1 | 1 | 2025-12 → 2026-02 ; CL | 11 | 6.6% | 4.82 | 6 (55%) | 3 | 0 | 2025-09 → 2026-04 ; AR | 4 | 2.4% | 2.00 | 0 | 3 | 3 | 2026-01 → 2026-05 ; BR | 4 | 2.4% | 3.75 | 0 | 4 | 0 | 2025-09 → 2025-11 ; FR | 4 | 2.4% | 3.50 | 1 | 2 | 0 | 2025-10 → 2025-12 ; KZ | 4 | 2.4% | 4.00 | 0 | 2 | 1 | 2025-09 → 2025-10 ; NL | 3 | 1.8% | 5.00 | 2 | 0 | 0 | 2025-11 ; SA | 3 | 1.8% | 2.33 | 0 | 2 | 2 | 2025-12 → 2026-05 ; UA | 3 | 1.8% | 2.33 | 0 | 2 | 2 | 2026-01 → 2026-03 ; DE | 2 | 1.2% | 5.00 | 0 | 1 | 0 | 2025-10 → 2026-01 ; TR | 2 | 1.2% | 2.00 | 0 | 2 | 1 | 2025-10 ; AM, IL, IT, JP, KR, MX, UY | 1 each | 4.2% | — | 0 | 7 | 4 | 2025-10 → 2026-08
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R30-064 — Russia (n=56, 33.7%, mean 4.52; 5★46 · 4★3 · 3★2 · 2★0 · 1★5; phrase-bank 26 = 46.4%; substantive 15 = 26.8%): free habit cap 7 (12.50%, above global 9.04%), monetisation friction 9 (16.07%), functional defect 5 (8.93%), simplicity 6 (10.71%), convenience 6 (10.71%), behaviour change 3 (5.36%), crash 2 (3.57%), billing failure 2 (3.57%), cannot find edit/delete 1; distinctive: the only market with a continuous 13-month review stream (every month but June 2026 — every other storefront is a burst); both billing failures in the entire corpus are Russian (a Russia-specific payment-processing check is warranted since RU is the only market producing purchase attempts continuously); both crash reports are Russian, both launch week; Russian reviewers volunteer the most nuanced feedback — a polite request for prior-month editing, a 1★ titled 'Для бесплатного плохо, для платки отлично' ('bad for free use, excellent for paid') that then praises the app, and the only person in the corpus who says they liked the price; the 30 non-phrase-bank RU reviews average 4.10 and the 15 substantive 3.20 — Russia is the product's real market (highest volume, longest tail, most engaged feedback, most purchase attempts) and where the payment flow is visibly breaking

- **Where:** §6.2 Russia (verbatim table) — n=56, 5★46 · 4★3 · 3★2 · 1★5; cap 12.50% (above 9.04%); monetisation friction 16.07%; functional defect 8.93%; simplicity 10.71%; convenience 10.71%; behaviour change 5.36%; crash 3.57%; billing failure 3.57%; the only continuous 13-month stream; both billing failures and both crashes are Russian; the most nuanced feedback ('bad for free use, excellent for paid'; the only person who liked the price); non-phrase-bank RU mean 4.10, substantive 3.20 — the product's real market, and where the payment flow is visibly breaking
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 56 | Signal | vs global ; Free habit cap | 7 | 12.50% | HIGH | above global 9.04% ; Any monetization friction | 9 | 16.07% | HIGH | at global 17.47% ; Any functional defect | 5 | 8.93% | HIGH | above global 7.23% ; Simplicity praised | 6 | 10.71% | HIGH | below global 13.86% ; Everyday convenience praised | 6 | 10.71% | HIGH | above global 7.23% ; Concrete behaviour change | 3 | 5.36% | HIGH | above global 4.22% ; Crash / won't open | 2 | 3.57% | very strong | above global 1.20% ; Billing failure | 2 | 3.57% | very strong | above global 1.20% ; Cannot find edit/delete | 1 | 1.79% | meaningful | at global 1.81%
- **Direction for us:** research · **Report confidence:** meaningful (only eligible country) · **Generalisable:** app-specific
- **Review IDs:** `13670832453`, `13678734774`, `12883902100`, `12886833369`, `13085435338`, `13078324005`, `12933316146`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R30-065 — High-spend markets (tier definition — US, JP, GB, DE, FR, CA, AU, KR — not spend data; review volume never used as a download or revenue proxy): present US 31 · GB 19 · FR 4 · DE 2 · JP 1 · KR 1 = 58 (34.9%); CA and AU produced zero; US is unmeasured (22/31 phrase-bank, 31/31 five-star, the one substantive review written in Russian); GB is 16/19 phrase-bank with nothing after 19 September 2025 and its one real review is 3★; FR's two substantive reviews are both 2★ cap complaints; DE's is a 5★ asking for a bigger free tier; JP's is 'The price is too high for this quality' (1★); KR's is the only happy widget user; across the group 8 substantive reviews, 5 of them monetisation complaints, mean 3.50 against a headline 4.79 — the product has essentially no measured organic reception in its highest-spend markets; the US and GB numbers are a launch artefact, a gap in market knowledge rather than evidence of success, and the single most important thing to fix about how this product is being evaluated

- **Where:** §6.3 High-spend markets (US, JP, GB, DE, FR, CA, AU, KR; tier definition, no spend data) — present: US 31 · GB 19 · FR 4 · DE 2 · JP 1 · KR 1 = 58 (34.9%); CA and AU zero; US unmeasured (22/31 phrase-bank, 31/31 5★, the one substantive review in Russian); GB nothing after 19 Sep 2025; 8 substantive reviews total, 5 of them monetisation complaints, mean 3.50 vs headline 4.79 — essentially no measured organic reception in the highest-spend markets, the single most important thing to fix about how this product is evaluated
- **This app does:** seeded US/GB launch reviews
- **User reaction:** mixed
- **Magnitude:** Market | n | Mean ★ | Substantive | Verdict ; US | 31 | 5.00 | 1 | Unmeasured. 22/31 phrase-bank, 31/31 five-star, and the one substantive review is in Russian. ; GB | 19 | 4.89 | 2 | 16/19 phrase-bank, and nothing after 19 Sep 2025. The one real review is 3★ (13032875149). ; FR | 4 | 3.50 | 2 | Both substantive reviews are 2★ cap complaints. ; DE | 2 | 5.00 | 1 | *"Bitte mehr für kostenlose Nutzer"* (13682739906) — a 5★ asking for a bigger free tier. ; JP | 1 | 1.00 | 1 | *"The price is too high for this quality"* (13625113466). ; KR | 1 | 5.00 | 1 | The corpus's only happy widget user (14107277631).
- **Direction for us:** research · **Report confidence:** group-level, stated limitation · **Generalisable:** app-specific
- **Review IDs:** `13032875149`, `13283076453`, `13487320234`, `13625113466`, `13682739906`, `14107277631`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R30-067 — Spanish-language markets grouped (ES + CL + AR + MX + UY = 30, 18.1%; limited evidence): ES (13) and CL (11) are 16/24 phrase-bank and average 4.75, while AR (4), MX (1) and UY (1) are 0/6 phrase-bank and average 2.33; the organic Spanish-language reviews are the harshest in the corpus — 'Es un check list CARÍSIMO'; 'Cuidado, engañan' ('careful, they deceive', ES); 'no puedo recuperar el dinero'; counterweight: the single most detailed constructive review is also Spanish-language (CL, 4★); 6 organic reviews cannot characterise a language market

- **Where:** §6.5 Spanish-language markets (ES + CL + AR + MX + UY = 30, 18.1%; limited evidence) — ES and CL 16/24 phrase-bank at 4.75 vs AR, MX, UY 0/6 phrase-bank at 2.33; the organic Spanish reviews are the harshest ('Es un check list CARÍSIMO'; 'Cuidado, engañan' — careful, they deceive; 'no puedo recuperar el dinero'); the most detailed constructive review is also Spanish-language (CL, 4★)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** ES+CL 4.75 (16/24 seeded) vs AR+MX+UY 2.33 (0/6)
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `13755696898`, `13705764332`, `14264524351`, `13176696608`
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R30-068 — Two sub-50 observations promoted because they are hard defects rather than opinions: Saudi Arabia (n=3) — 2 of 3 reviews are the same onboarding name-entry blocker (both 1★, Dec 2025 and Jan 2026), limited by count but a hard block affecting an entire locale; Ukraine (n=3) — 2 of 3 are store-disclosure / trial complaints (both 1★); AR's 2.00 mean, TR's 2.00, IT/JP/MX/IL 1★ singletons and KR/UY/AM/DE 5★ singletons carry no country-level claim

- **Where:** §6.6 Sub-50 storefronts promoted as hard defects — SA (n=3): 2 of 3 the same onboarding name-entry blocker (both 1★, Dec 2025 and Jan 2026) — a hard block for an entire locale; UA (n=3): 2 of 3 store-disclosure / trial complaints (both 1★); no other sub-50 storefront supports a standalone conclusion
- **This app does:** Arabic onboarding blocker; disclosure/trial
- **User reaction:** 1★-burst
- **Magnitude:** SA 2/3; UA 2/3
- **Direction for us:** must-never-break · **Report confidence:** limited evidence, hard defects · **Generalisable:** app-specific
- **Review IDs:** `13511113509`, `13596102043`, `13679689890`, `13864202916`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C228 Text fields must handle IME composition — Hangul and CJK input

## Dated events and trends

### R30-010 — Rating quality is deteriorating fast as the seeded reviews stop: mean by half-year 2025H2 4.65 (n=138) → 2026H1 3.17 (n=23) → 2026H2 3.00 (n=5); phrase-bank reviews ran at 35 of 53 in July 2025 and stop almost entirely after December 2025 (1 in Jan 2026, 0 after); on the non-phrase-bank subset the decline is milder, 4.14 → 3.09 → 3.00, and on substantive reviews 3.15 → 2.53 → 2.50 — the public 4.4★ average is a decaying artefact; the organic trajectory is roughly 3.0★ and the cap is the reason

- **Where:** Executive summary #8 — rating quality is deteriorating fast as the seeded reviews stop: half-year mean 2025H2 4.65 (n=138) → 2026H1 3.17 (23) → 2026H2 3.00 (5); phrase-bank reviews 35/53 of July 2025, 1 in Jan 2026, 0 after; non-phrase-bank 4.14 → 3.09 → 3.00; substantive 3.15 → 2.53 → 2.50 — the public 4.4★ is a decaying artefact; the organic trajectory is ~3.0★ and the cap is the reason
- **This app does:** seeded launch reviews expiring
- **User reaction:** churn
- **Magnitude:** 4.65 → 3.17 → 3.00; substantive 3.15 → 2.53 → 2.50
- **Direction for us:** product-rule · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set; C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R30-011 — Monthly volume 2025-07 53 · 08 32 · 09 14 · 10 10 · 11 15 · 12 14 · 2026-01 9 · 02 6 · 03 2 · 04 3 · 05 3 · 06 0 · 07 3 · 08 2; 51.2% of the corpus (85 of 166) falls in the first two months, where 53 of the phrase-bank reviews concentrate; from March 2026 the app produces roughly 2–3 written reviews per month

- **Where:** §1.4 Date range and shape (verbatim monthly table) — 2025-07 53, 08 32, 09 14, 10 10, 11 15, 12 14, 2026-01 9, 02 6, 03 2, 04 3, 05 3, 06 0, 07 3, 08 2; 51.2% (85) in the first two months, where 53 phrase-bank reviews concentrate; from Mar 2026 ~2–3 written reviews a month
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Month | n |  | Month | n ; 2025-07 | 53 |  | 2026-02 | 6 ; 2025-08 | 32 |  | 2026-03 | 2 ; 2025-09 | 14 |  | 2026-04 | 3 ; 2025-10 | 10 |  | 2026-05 | 3 ; 2025-11 | 15 |  | 2026-06 | 0 ; 2025-12 | 14 |  | 2026-07 | 3 ; 2026-01 | 9 |  | 2026-08 | 2
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R30-057 — 1★ (n=19): free habit cap 8 (42.1%); price/value 4 (21.1%); purchase-flow failure 4 (21.1% — charged with nothing unlocked, refund refused, no trial then annual charge, mis-sold lifetime); undisclosed IAP on the store page 1; software defect 3 (15.8% — name-entry ×2, can't edit/remove); 16 of 19 (84.2%) monetisation or billing; the most geographically dispersed group — AR 3 · RU 5 · SA 2 · UA 2 · ES 1 · IL 1 · IT 1 · JP 1 · KZ 1 · MX 1 · TR 1, 11 storefronts, so the complaint is not local; date profile: 7 of 19 in 2025H2 and 12 in 2026 — the one-star rate rose from 5.1% of 2025H2 reviews to 42.9% of 2026 reviews (12 of 28)

- **Where:** §4.5 1★ table (verbatim) — cap 8 (42.1%), price/value 4 (21.1%), purchase-flow failure 4 (21.1%), undisclosed IAP 1, software defect 3 (15.8%); 16 of 19 monetisation/billing; the most geographically dispersed group (11 storefronts: AR 3 · RU 5 · SA 2 · UA 2 · ES, IL, IT, JP, KZ, MX, TR 1) — not local; one-star rate rose from 5.1% of 2025H2 reviews to 42.9% of 2026 reviews (12 of 28)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Reason | n | Segment % of 19 | IDs ; Free habit cap | 8 | 42.1% | 13015082250, 13057771438, 13078324005, 13139338718, 13286447070, 13679689890, 13707712022, 14438894096 ; Price / value | 4 | 21.1% | 13625113466, 13705764332, 13755696898, 13882804582 ; Purchase-flow failure | 4 | 21.1% | 13670832453 (charged, nothing unlocked), 14264524351 (refund refused), 13680381966 (no trial, annual charge), 13705764332 (mis-sold "lifetime") ; Undisclosed IAP on the store page | 1 | 5.3% | 13864202916 ; Software defect | 3 | 15.8% | 13511113509, 13596102043 (name-entry bug), 13576406218 (can't edit/remove)
- **Direction for us:** product-rule · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `13015082250`, `13057771438`, `13078324005`, `13139338718`, `13286447070`, `13679689890`, `13707712022`, `14438894096`, `13625113466`, `13705764332`, `13755696898`, `13882804582`, `13670832453`, `14264524351`, `13680381966`, `13864202916`, `13511113509`, `13596102043`, `13576406218`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R30-070 — Headline series by half-year: 2025H2 n=138, mean 4.65, non-phrase-bank 56 at 4.14, substantive 26 at 3.15, 1★ 5.1% (7/138); 2026H1 n=23, 3.17, 22 at 3.09, 17 at 2.53, 1★ 43.5% (10/23); 2026H2 n=5, 3.00, 5 at 3.00, 4 at 2.50, 1★ 40.0% (2/5, no independent weight); no version field so no release-based cut

- **Where:** §7.1 Headline series (verbatim table) — 2025H2 138 / 4.65 / non-phrase-bank 56 at 4.14 / substantive 26 at 3.15 / 1★ 5.1%; 2026H1 23 / 3.17 / 22 at 3.09 / 17 at 2.53 / 1★ 43.5%; 2026H2 5 / 3.00 / 5 at 3.00 / 4 at 2.50 / 1★ 40.0% (no independent weight)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Period | n | Mean ★ | Non-phrase-bank n / mean | Substantive n / mean | 1★ share ; 2025H2 | 138 | 4.65 | 56 / 4.14 | 26 / 3.15 | 5.1% (7/138) ; 2026H1 | 23 | 3.17 | 22 / 3.09 | 17 / 2.53 | 43.5% (10/23) ; 2026H2 | 5 | 3.00 | 5 / 3.00 | 4 / 2.50 | 40.0% (2/5)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R30-071 — Trend 1 (confirmed change, high confidence): the free cap was raised from 2 to 3 and it did not help — every review naming the limit before 4 Feb 2026 says 2 (12 reviews, 14 Aug 2025 → 4 Feb 2026: RU 1★, RU 1★, RU 1★, KZ 1★, FR 2★, TR 1★, BR 2★, FR 2★, RU 4★, UA 1★, RU 1★, RU 5★) and every review from 29 Apr 2026 says 3 (CL 4★ 29 Apr, RU 3★ 4 Jul, IT 1★ 17 Aug) with no overlap — a clean fingerprint; the store page still says 2 (a separate listing-accuracy problem); the developer responded to the complaint by adding one habit and the complaint continued at the same rate with the same ratings — +1 was not enough, and a reviewer had already named 5 as the floor

- **Where:** §7.2 Trend 1 — the cap was raised from 2 to 3 and it did not help (confirmed, high confidence) — dated table (verbatim): 12 reviews say '2' from 14 Aug 2025 to 4 Feb 2026, then 3 say '3' from 29 Apr to 17 Aug 2026, no overlap; the store page still says 2; the complaint continued at the same rate and with the same ratings (1★, 3★, 4★) — +1 was not enough, a reviewer had already named 5 as the floor
- **This app does:** raised cap 2 → 3 in Feb–Apr 2026
- **User reaction:** 1★-burst
- **Magnitude:** Says "2" | Date |  | Says "3" | Date ; 13015082250 RU 1★ | 2025-08-14 |  | 14007543484 CL 4★ | 2026-04-29 ; 13057771438 RU 1★ | 2025-08-25 |  | 14262833547 RU 3★ | 2026-07-04 ; 13078324005 RU 1★ | 2025-08-30 |  | 14438894096 IT 1★ | 2026-08-17 ; 13139338718 KZ 1★ | 2025-09-15 |  |  | ; 13283076453 FR 2★ | 2025-10-18 |  |  | ; 13286447070 TR 1★ | 2025-10-19 |  |  | ; 13441364320 BR 2★ | 2025-11-26 |  |  | ; 13487320234 FR 2★ | 2025-12-07 |  |  | ; 13678734774 RU 4★ | 2026-01-26 |  |  | ; 13679689890 UA 1★ | 2026-01-27 |  |  | ; 13707712022 RU 1★ | 2026-02-03 |  |  | ; 13710940338 RU 5★ | 2026-02-04 |  |  |
- **Direction for us:** product-rule · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `13015082250`, `13057771438`, `13078324005`, `13139338718`, `13283076453`, `13286447070`, `13441364320`, `13487320234`, `13678734774`, `13679689890`, `13707712022`, `13710940338`, `14007543484`, `14262833547`, `14438894096`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C059 Be visibly responsive; fixes bring reviewers back; C104 Never ship a paywall or feature-removal change silently; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R30-072 — Trend 2 (high confidence): the seeded reviews ran out and the rating collapsed — phrase-bank reviews by month Jul 35 · Aug 18 · Sep 9 · Oct 0 · Nov 10 · Dec 10 · Jan 1 · Feb–Aug 0 (two campaigns — English-language Jul–Sep 2025, Spanish/Dutch-language Nov–Dec 2025 — then nothing for seven months); organic reviews flat to declining but steady: Jul 18 · Aug 14 · Sep 5 · Oct 10 · Nov 5 · Dec 4 · Jan 8 · Feb 6 · Mar 2 · Apr 3 · May 3 · Jun 0 · Jul 3 · Aug 2; the 4.40 corpus mean and the 4.9★ US store rating are propped up by a supply that has stopped — the organic run-rate is ~3 reviews/month at ~3.0★, and left alone the public rating decays toward 3

- **Where:** §7.3 Trend 2 — the seeded reviews ran out and the rating collapsed (high confidence): phrase-bank Jul 35 · Aug 18 · Sep 9 · Oct 0 · Nov 10 · Dec 10 · Jan 1 · Feb–Aug 0 — two campaigns then nothing for seven months; organic flat-to-declining Jul 18 · Aug 14 · Sep 5 · Oct 10 · Nov 5 · Dec 4 · Jan 8 · Feb 6 · Mar 2 · Apr 3 · May 3 · Jun 0 · Jul 3 · Aug 2; the 4.40 mean and 4.9★ US store rating are propped up by a supply that has stopped — organic run-rate ~3 reviews/month at ~3.0★; left alone the public rating decays toward 3
- **This app does:** seeded launch reviews stopped
- **User reaction:** churn
- **Magnitude:** phrase-bank 35 → 0; organic ~3/month at ~3.0★
- **Direction for us:** dont · **Report confidence:** high · **Generalisable:** yes
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R30-073 — Trend 3 (medium-high confidence): complaints migrated from 'it's broken' to 'it's not worth paying for' — 2025H2 substantive complaints: crashes 2, cap 8, edit/pause discoverability 2, scheduling 2, alarm 1, scroll/density 2, paid-model confusion 1; 2026: cap 7, price/value 4, purchase-flow failures 4, no trial 2, refund 1, store disclosure 1, name-entry bug 2, slow 1; zero crash reports after July 2025 and zero purchase-flow complaints before January 2026 — the software stabilised and the commercial layer became the entire problem; all four purchase-flow defects (Jan, Jan, Feb, Jul) are 2026 events, suggesting either a monetisation change or growing purchase volume in 2026 — the corpus cannot distinguish

- **Where:** §7.4 Trend 3 — complaints migrated from 'it's broken' to 'it's not worth paying for' (medium-high): 2025H2 substantive complaints crashes 2, cap 8, edit/pause 2, scheduling 2, alarm 1, scroll/density 2, paid-model confusion 1; 2026 cap 7, price/value 4, purchase-flow 4, no trial 2, refund 1, store disclosure 1, name-entry 2, slow 1; zero crashes after Jul 2025, zero purchase-flow complaints before Jan 2026 — the software stabilised and the commercial layer became the entire problem; all four purchase-flow defects are 2026 events (a monetisation change or growing purchase volume — indistinguishable)
- **This app does:** stabilised software, broken commercial layer
- **User reaction:** 1★-burst
- **Magnitude:** crash 2 → 0; purchase-flow 0 → 4
- **Direction for us:** must-never-break · **Report confidence:** medium-high · **Generalisable:** yes
- **Review IDs:** `13670832453`, `13678734774`, `13705764332`, `14264524351`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R30-074 — Trend 4 (high confidence): the one-star rate rose 8× — 5.1% of 2025H2 reviews (7/138) → 42.9% of all 2026 reviews (12/28); even against the non-phrase-bank subset only, 12.5% (7/56) → 44.4% (12/27) — not an artefact of the phrase bank disappearing: the organic one-star rate itself more than tripled

- **Where:** §7.5 Trend 4 — one-star rate rose 8× (high confidence): 5.1% of 2025H2 (7/138) → 42.9% of 2026 (12/28); against the non-phrase-bank subset alone 12.5% (7/56) → 44.4% (12/27) — not an artefact of the phrase bank disappearing: the organic one-star rate more than tripled
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 5.1% → 42.9%; organic 12.5% → 44.4%
- **Direction for us:** none · **Report confidence:** high · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R30-075 — Trend 5 (low confidence, n=2): the Arabic name-entry bug is confined to 14 Dec 2025 and 5 Jan 2026, followed by a plain Saudi 5★ on 17 May 2026 ('تطبيق رائع لمتابعة استمرار العادات' — 'great app for keeping habits going'); possibly fixed — with n=3 in the storefront, a guess not a finding

- **Where:** §7.6 Trend 5 — the name-entry bug confined to Dec 2025 – Jan 2026, then a plain Saudi 5★ in May 2026 ('great app for keeping habits going'); possibly fixed — a guess, not a finding (low confidence, n=2)
- **This app does:** possibly fixed onboarding bug
- **User reaction:** praise
- **Magnitude:** 2 then a 5★
- **Direction for us:** none · **Report confidence:** low · **Generalisable:** app-specific
- **Review IDs:** `13511113509`, `13596102043`, `14074890221`
- **Canonical:** C228 Text fields must handle IME composition — Hangul and CJK input

## Positioning

### R30-001 — Habit Tracker: Simple&Powerful — 'Goal, task & Routine Planner' (App Store ID 6745508692, GAL APP LTD) — a young (Jul 2025→) minimalist tracker: free download with a hard habit cap (2, raised to 3 by Apr 2026), subscription + lifetime IAP — listing shows Monthly Premium $5.99 · Yearly $44.99 · Yearly (second SKU) $29.99 · Lifetime $59.99 and 'Track up to 2 habits with free version'; version 1.4.7; US listing 4.9★ from 45 ratings

- **Where:** header lines 1-9; §9.2 External sources
- **This app does:** developer of record GAL APP LTD; bundle app.hbt.tem; extracted 8 Sep 2026; analysis 11 Sep 2026; store rank 30; 2→3 free habits, paid widget and unlimited
- **User reaction:** mixed
- **Magnitude:** 166 reviews · 21 storefronts · 8 Jul 2025 → 19 Aug 2026; mean 4.398; 5★ 133 (80.12%) / 4★ 7 / 3★ 4 / 2★ 3 / 1★ 19
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

## Anti-patterns

### R30-018 — Three material conflicts between store page and corpus: (1) the cap number is stale or inconsistent — the page says 2, reviews from April 2026 onward consistently say 3; (2) two annual SKUs at $44.99 and $29.99 plus a $59.99 'Lifetime' is exactly the configuration that produces 'they tell you the plan is for life and it's only for a year' (ES, 1★) — whether mis-sold or misread, the SKU shelf is ambiguous enough to generate the complaint; (3) no free trial appears anywhere, consistent with the two no-trial 1★ reviews

- **Where:** §2.2 Three store-page conflicts — (1) the page says 2 free habits but reviews from Apr 2026 consistently say 3 (stale page or cap varies by build/region); (2) two annual SKUs ($44.99, $29.99) plus a $59.99 'Lifetime' is exactly the configuration that produces 'they tell you the plan is for life and it's only for a year'; (3) no free trial anywhere, consistent with the no-trial 1★s
- **This app does:** ambiguous, stale SKU shelf; no trial
- **User reaction:** 1★-burst
- **Magnitude:** 3 conflicts; 3 reviews
- **Direction for us:** must-never-break · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `14007543484`, `14262833547`, `14438894096`, `13705764332`, `13680381966`, `13679689890`
- **Canonical:** C063 Free trial before purchase; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Things not to do

### R30-090 — What not to change: do not add features to the free tier's surface area — add habit slots (simplicity is the single largest positive theme, 23, 13.86%, and the only attribute anyone volunteers unprompted); do not cut the price — three reviewers say the price is acceptable, including two who rated 1★ and 2★ for the cap, so the objection is value, not price; do not rely on the current star rating for any decision (seeded launch reviews, decaying)

- **Where:** §8.5 What not to change — do not add features to the free tier's surface area, add habit slots (simplicity is the largest positive theme and the only attribute volunteered unprompted); do not cut the price (three say it is acceptable, including a 1★ and a 2★ who rated low for the cap); do not rely on the current star rating for any decision
- **This app does:** minimal, fairly priced, capped
- **User reaction:** mixed
- **Magnitude:** 23; 3 price-acceptable
- **Direction for us:** dont · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `12933316146`, `13487320234`, `13139338718`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C064 Price level — where 'fair' turns into 'too expensive'; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

## Things to do

### R30-034 — Store-listing mismatch (widget screenshot; undisclosed IAP)

- **Where:** §3.1 Master table #18 Store-listing mismatch
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 2 (1.20%, meaningful), mean 3.00
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R30-081 — F5: correct the store listing — the cap is 3, not 2; ensure the advertised widget matches the shipped widget; make IAP disclosure visible at the decision point; removes expectation-mismatch 1★ reviews and reduces store-policy risk

- **Where:** §8.1 F5 — correct the store listing: the cap is 3 not 2; the advertised widget must match the shipped widget; make IAP disclosure visible at the decision point — removes expectation-mismatch 1★ reviews and reduces store-policy risk
- **This app does:** stale, mismatched listing
- **User reaction:** complaint
- **Magnitude:** listing conflicts + 2 reviews
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13706323164`, `13864202916`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Contradictions

### R30-044 — 'Too basic / too thin' (4, 2.41%, mean 1.50): every one of these four also carries a price objection, and no reviewer in the corpus calls the app too basic without also complaining about paying for it — not a feature-depth complaint but the same value complaint restated; adding features to answer it would be the wrong read

- **Where:** §3.3 'Too basic / too thin' — every one of the four also carries a price objection; no reviewer calls the app too basic without also complaining about paying — it is the value complaint restated, and adding features to answer it would be the wrong read
- **This app does:** minimal app at premium price
- **User reaction:** complaint
- **Magnitude:** 4/4 also price objection
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13032875149`, `13625113466`, `13705764332`, `13755696898`
- **Canonical:** C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R30-056 — 2★ (n=3): all three are the habit cap and nothing else, and one explicitly says the price is fine — 'Elle est payante on peut mettre que 2 habitude sans payer mais ce n'est pas cher' ('It's paid, you can only add 2 habits without paying, but it's not expensive', FR) — and still rates 2★: the cleanest possible evidence that the cap, not the price, is what produces the low ratings

- **Where:** §4.4 2★ — all three are the habit cap and nothing else; one explicitly says the price is fine ('Elle est payante on peut mettre que 2 habitude sans payer mais ce n'est pas cher') and still rates 2★ — the cleanest possible evidence that the cap, not the price, produces the low ratings
- **This app does:** 2-habit cap at a fair price
- **User reaction:** complaint
- **Magnitude:** 3/3 cap; 1 says price fine
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13283076453`, `13441364320`, `13487320234`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C064 Price level — where 'fair' turns into 'too expensive'; C133 Gate on capability, not on quantity

## Data caveats and method

### R30-002 — Method: 166/166 read in full in the original language (Russian 60+, Spanish 25+, English 50+, plus pt/fr/de/nl/ar/tr/it/ja/ko/uk) and hand-assigned to 29 leaf + 4 union themes (no classifier at this size); a template-detection pass normalised bodies and grouped cross-language equivalents into five phrase-bank families (exact-normalised or containment in bodies under 80 chars — a floor); each review flagged substantive (names a feature, defect, request or pricing fact) — 47 of 166 (28.3%); rates computed globally (0.60pp per review), for Russia (n=56, 1.79pp) and for the substantive segment; all 33 sub-5★ and all 47 substantive re-read and every ID asserted; overlapping theme boundaries between cap, paywall and price (11 carry two of three) so quote the union (29) for scale; half the corpus is not organic (83 phrase-bank, all 5★); only Russia reaches 50; the US storefront (31, all 5★, 22 phrase-bank) contains zero English-language criticism — US sentiment is unmeasured; no version field; the US listing's 45 ratings vs 31 written reviews means written reviews are most US ratings, itself unusual; purchase evidence thin but real (6); is_edited false for all; votes 0 on 157; 11 reviews in a language not matching their storefront; near-absence of 2–3★ (7 of 166) consistent with a prompt routing satisfied users to the store; one reviewer references a developer reply

- **Where:** How to read this; Seven warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.5 Processing method; §1.6 Limitations and known biases
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 166/166; 21 storefronts; 0 duplicates; 0 excluded; substantive 47 (28.3%)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `14338216422`, `13680381966`, `13670832453`, `13678734774`, `14264524351`, `13705764332`, `13882804582`, `13707712022`
- **Canonical:** — (nuance register)

### R30-012 — Coverage exact on every check: 166 lines parsed, 166 distinct IDs (no deduplication), 21 per-country files sum to 166 with no orphans, manifest total/per-country/rating distribution (5★133 · 4★7 · 3★4 · 2★3 · 1★19)/mean 4.398 all match, 0 empty bodies, 0 excluded; _state.json reports complete for every storefront crawled, including 0-result storefronts like cn

- **Where:** §1.3 Coverage table (verbatim) — 166 lines, 166 distinct IDs, 21 country files match, manifest total/per-country/rating distribution/mean 4.398 match, 0 empty, 0 excluded
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Check | Result ; Lines in reviews.jsonl | 166 ; Records parsed without error | 166 (100%) ; Distinct review_id | 166 — no duplicates, no deduplication applied ; Lines across all 21 by_country/*.jsonl | 166 — exact match, no orphans in either direction ; manifest.total_reviews | 166 — match ; manifest.reviews_per_country vs computed | 21/21 storefronts match exactly ; manifest.rating_distribution vs computed | 5★133 · 4★7 · 3★4 · 2★3 · 1★19 — match ; manifest.mean_rating 4.398 vs computed | 4.398 — match ; Records with empty body | 0 ; Records excluded from analysis | 0
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R30-013 — Feature inventory with review-derived gating

- **Where:** §2.1 Feature inventory table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence it exists | Gating (review-derived) | IDs ; Create + check off daily habits | Core of every review | Free, capped at 2 then 3 | 13015082250, 14262833547 ; Unlimited habits | Named as the paid unlock | Paid | 13441364320, 13707712022, 14007543484 ; Home Screen widget | Used and praised | Paid | 14107277631, 13130702696, 13081229555 ; Interactive/streak widget shown in screenshots | Reported as not matching the app's actual widget | Paid / mismatched | 13706323164 ; Reminders / notifications | Present; an *alarm* is requested as an upgrade on it | Free (implied) | 13267951780, 12950173104 ; Progress / streak tracking, daily completion ring | Described in use | Free | 13176696608, 13710940338 ; Within-month history editing | Works inside current month, not to prior months | Free | 13085435338 ; Edit / delete / pause a habit | Exists but cannot be found by users | Free | 13324437553, 13576406218, 13449993538 ; Skip a habit for a day | Exists; breaks the completion ring | Free | 13176696608 ; Habit end-date | Absent — deleting is the only way out, and it wipes history | — | 13176696608 ; Day-of-week / weekly / monthly frequency | Absent | — | 13249103798, 13032875149, 13705764332 ; Per-habit and per-day percentages | Absent | — | 13176696608 ; Localisation (ES, RU, KO, AR, PT, FR, DE, NL, IT, HE, JA, TR, UK) | Reviews written and functioning in all of these | Free | 13941632555, 14107277631 ; Name / profile entry at onboarding | Broken for Arabic-locale users | Free | 13511113509, 13596102043 ; Colour themes, iCloud sync | Store page only — no reviewer mentions either | Unverified by reviews | —
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R30-019 — The phrase bank: 83 of 166 reviews (50.00%) match one of five short phrases or their translations, all 83 are 5★ (0 exceptions) and 1 also carries substantive content — RECOMMEND 37 ('I highly recommend it' / 'Lo recomiendo encarecidamente' / 'Ik beveel het ten zeerste aan' / 'Рекомендую'), VERY_GOOD 19 ('Very good' / 'Muy bueno' / 'Все супер'), LIKE_SO_MUCH 11, BEST_ONE 9 ('The best one' / 'El mejor' / 'De beste'), SIMPLE_PERFECT 7 ('so simple, perfect' in five languages)

- **Where:** §2.3 Corpus integrity — the phrase bank (verbatim table): 83 of 166 (50.00%) match one of five short phrases or translations — RECOMMEND 37, VERY_GOOD 19, LIKE_SO_MUCH 11, BEST_ONE 9, SIMPLE_PERFECT 7 — all 83 5★, 1 carries substantive content
- **This app does:** seeded 5★ launch reviews
- **User reaction:** 5★-burst
- **Magnitude:** Phrase family | n | Example surface forms ; RECOMMEND | 37 | "I highly recommend it" · "Lo recomiendo encarecidamente" · "Ik beveel het ten zeerste aan" · "Рекомендую" ; VERY_GOOD | 19 | "Very good" · "Muy bueno" · "Super" · "Все супер" ; LIKE_SO_MUCH | 11 | "I like it so much" · "Me gusta mucho" · "Ik vind het zo leuk" ; BEST_ONE | 9 | "The best one" · "El mejor" · "De beste" ; SIMPLE_PERFECT | 7 | "so simple, perfect" · "tan simple, perfecto" · "tellement simple, parfait" · "zo eenvoudig, perfekt" · "so einfach, perfekt"
- **Direction for us:** dont · **Report confidence:** high · **Generalisable:** yes
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R30-020 — Five independent corroborating signals of seeding: (1) rating purity — 83/83 phrase-bank are 5★ while the remaining 83 are 1★19 · 2★3 · 3★4 · 4★7 · 5★50 (mean 3.80), and a 100%-5★ subgroup of 83 does not occur by chance; (2) cross-language identity — the same Dutch sentence appears on the NL storefront and on the Russian storefront a day apart, 'Ik beveel het ten zeerste aan, super, ik vind het zo leuk, heel goed, zo eenvoudig, perfect, de beste', a concatenation of all five phrase families — a phrase list, not a sentence; (3) 11 storefront/language mismatches (RU→Dutch, RU→Spanish 'el mejor', US→Russian, US→Portuguese, FR→Spanish, English in UA/KZ/AR/TR); (4) temporal clustering by market — GB+US phrase-bank reviews 15 Jul–19 Sep 2025 (38), ES+CL 18 Nov–22 Dec 2025 (16): two discrete campaigns in two language groups; monthly Jul 35 · Aug 18 · Sep 9 · Oct 0 · Nov 10 · Dec 10 · Jan 1 · then zero for seven months; (5) GB stops dead — 19 reviews, 16 phrase-bank, none at all after 19 September 2025

- **Where:** §2.3 Five corroborating signals — (1) rating purity: 83/83 5★ vs the remaining 83 at mean 3.80; (2) cross-language identity: the same Dutch sentence on the NL and RU storefronts a day apart concatenating all five phrase families ('a phrase list, not a sentence'); (3) 11 storefront/language mismatches; (4) two discrete campaigns — GB+US 15 Jul–19 Sep 2025 (38), ES+CL 18 Nov–22 Dec 2025 (16); monthly Jul 35 · Aug 18 · Sep 9 · Oct 0 · Nov 10 · Dec 10 · Jan 1 · then zero for seven months; (5) GB stops dead after 19 Sep 2025 (19 reviews, 16 phrase-bank)
- **This app does:** seeded review campaigns by language group
- **User reaction:** 5★-burst
- **Magnitude:** 83/83 5★ vs 3.80; 2 campaigns; 11 mismatches
- **Direction for us:** dont · **Report confidence:** high · **Generalisable:** yes
- **Review IDs:** `13403875241`, `13404072755`, `13442553415`, `14338216422`, `12928535001`, `13406815450`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R30-023 — Master theme table, denominator 166, with substantive segment %

- **Where:** §3.1 Master table (verbatim), 32 themes + integrity rows, with substantive-segment rates
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | Direction | n | % of 166 | Signal | Sub. % | Mean ★ ; 1 | Any monetization friction (union) | Negative | 29 | 17.47% | HIGH | 61.7% | 2.17 ; 2 | Simplicity / minimalism praised | Positive | 23 | 13.86% | HIGH | 8.5% | 5.00 ; 3 | Free habit cap (2 → 3) | Negative | 15 | 9.04% | HIGH | 31.9% | 2.00 ; 4 | Everyday convenience praised | Positive | 12 | 7.23% | HIGH | 4.3% | 5.00 ; 5 | Any functional defect (union) | Negative | 12 | 7.23% | HIGH | 25.5% | 3.00 ; 6 | Paywall too aggressive / "not really free" | Negative | 11 | 6.63% | HIGH | 23.4% | 1.82 ; 7 | Any feature request (union) | Unmet need | 8 | 4.82% | very strong | 17.0% | 3.88 ; 8 | Concrete behaviour change reported | Positive | 7 | 4.22% | very strong | 12.8% | 5.00 ; 9 | UI / visual design praised | Positive | 6 | 3.61% | very strong | 4.3% | 4.83 ; 10 | Price-for-value objection | Negative | 5 | 3.01% | very strong | 10.6% | 1.40 ; 11 | Scheduling / frequency gap | Unmet need | 4 | 2.41% | meaningful | 8.5% | 3.25 ; 12 | "Too basic / too thin for the price" | Negative | 4 | 2.41% | meaningful | 8.5% | 1.50 ; 13 | Price described as *acceptable* | Positive | 3 | 1.81% | meaningful | 4.3% | 2.67 ; 14 | Cannot find edit / delete / pause | Negative | 3 | 1.81% | meaningful | 6.4% | 3.33 ; 15 | Widget is paywalled | Negative | 2 | 1.20% | meaningful | 4.3% | 4.50 ; 16 | No free trial | Negative | 2 | 1.20% | meaningful | 4.3% | 1.00 ; 17 | Billing failure (charge / wrong SKU) | Negative | 2 | 1.20% | meaningful | 4.3% | 2.50 ; 18 | Store-listing mismatch | Negative | 2 | 1.20% | meaningful | 4.3% | 3.00 ; 19 | Crash / won't open | Negative | 2 | 1.20% | meaningful | 4.3% | 3.50 ; 20 | Name-entry bug (Arabic locale) | Negative | 2 | 1.20% | meaningful | 4.3% | 1.00 ; 21 | Refund refused | Negative | 1 | 0.60% | emerging | 2.1% | 1.00 ; 22 | "Lifetime" plan delivered as annual | Negative | 1 | 0.60% | emerging | 2.1% | 1.00 ; 23 | Cannot edit prior months | Unmet need | 1 | 0.60% | emerging | 2.1% | 5.00 ; 24 | Deleting a habit destroys its history | Negative | 1 | 0.60% | emerging | 2.1% | 4.00 ; 25 | Scroll jumps to top after ticking | Negative | 1 | 0.60% | emerging | 2.1% | 3.00 ; 26 | List rows too large, no density control | Negative | 1 | 0.60% | emerging | 2.1% | 3.00 ; 27 | App runs slowly | Negative | 1 | 0.60% | emerging | 2.1% | 5.00 ; 28 | Alarm (not just notification) requested | Unmet need | 1 | 0.60% | emerging | 2.1% | 4.00 ; 29 | Per-habit / per-day percentages requested | Unmet need | 1 | 0.60% | emerging | 2.1% | 4.00 ; 30 | Skip breaks the daily completion ring | Negative | 1 | 0.60% | emerging | 2.1% | 4.00 ; 31 | Widget praised (by a paying user) | Positive | 1 | 0.60% | emerging | 2.1% | 5.00 ; 32 | Spanish localisation praised | Positive | 1 | 0.60% | emerging | 2.1% | 5.00 ; — | *Phrase-bank (integrity flag, not a theme)* | *n/a* | *83* | *50.00%* | *—* | 2.1% | 5.00 ; — | *Non-substantive praise* | *Positive* | *119* | *71.69%* | *—* | — | 5.00
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R30-037 — Single-record rows (0.60%, emerging): refund refused (1★); 'lifetime' plan delivered as annual (1★); cannot edit prior months (5★); deleting a habit destroys its history (4★); scroll jumps to top after ticking (3★); list rows too large, no density control (3★); app runs slowly (5★); alarm, not just a notification, requested (4★); per-habit / per-day percentages requested (4★); Skip breaks the daily completion ring (4★); widget praised by a paying user (5★); Spanish localisation praised (5★); integrity rows: phrase bank 83 (50.00%, 5.00), non-substantive praise 119 (71.69%, 5.00)

- **Where:** §3.1 Master table #21–#32 single-record rows — refund refused; 'lifetime' delivered as annual; cannot edit prior months (5★); deleting a habit destroys its history; scroll jumps to top after ticking; list rows too large; app runs slowly (5★); alarm requested; per-habit/per-day percentages requested; Skip breaks the completion ring; widget praised by a paying user; Spanish localisation praised
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 12 single-record rows
- **Direction for us:** none · **Report confidence:** emerging (anecdotes) · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R30-050 — Unmet needs ranked: non-daily habit scheduling (day-of-week, x/week, weekly, monthly) 4 — four storefronts, four languages, the same ask, the only true build item; habit end-date (stop a habit without deleting its history) 1 — today the workaround destroys data; Skip should preserve the daily completion ring 1 — users feel they failed a day they completed; edit history beyond the current month 1 (asked politely by a 5★); per-habit and per-day completion percentages 1; an alarm, not just a notification 1 ('assim a pessoa recebe um alarme com o próprio app e não precisa fazer outro alarme no celular'); three of the top five come from a single review (CL, 4★) quoted because it is the most diagnostic record, not because one review is a trend — prioritised because the fix for #1 (a frequency field) also resolves #2 and #3

- **Where:** §3.4 Unmet needs (verbatim table) — non-daily scheduling 4 (4 storefronts, the only true build item); habit end-date 1 (today the workaround destroys data); Skip should preserve the completion ring 1; edit history beyond the current month 1; per-habit/per-day percentages 1; alarm not just a notification 1 ('receives an alarm from the app itself and doesn't need another alarm on the phone'); three of the top five come from one diagnostic review — prioritised because a frequency field also resolves the end-date and skip-ring issues
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Rank | Need | n | % of 166 | Signal | IDs | Why it matters ; 1 | Non-daily habit scheduling (day-of-week, x/week, weekly, monthly) | 4 | 2.41% | meaningful | 13032875149, 13176696608, 13249103798, 13705764332 | 4 storefronts, 4 languages, same ask. The only true build item. ; 2 | Habit end-date (stop a habit without deleting its history) | 1 | 0.60% | emerging | 13176696608 | Today the workaround destroys data. ; 3 | Skip should preserve the daily completion ring | 1 | 0.60% | emerging | 13176696608 | Users feel they failed a day they actually completed. ; 4 | Edit history beyond the current month | 1 | 0.60% | emerging | 13085435338 | Asked politely by a 5★ user. ; 5 | Per-habit and per-day completion percentages | 1 | 0.60% | emerging | 13176696608 | Low cost, visible payoff. ; 6 | Alarm, not just a notification | 1 | 0.60% | emerging | 13267951780 | *"assim a pessoa recebe um alarme com o próprio app e não precisa fazer outro alarme no celular"*
- **Direction for us:** must-have · **Report confidence:** meaningful / emerging · **Generalisable:** yes
- **Review IDs:** `13032875149`, `13176696608`, `13249103798`, `13705764332`, `13085435338`, `13267951780`
- **Canonical:** C010 Backfill missed days / edit start date; C012 Week / month / year grid views; C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C039 Reminders fire reliably, once; C043 Flexible / custom frequency

### R30-052 — Per band: 5★ 133 (80.12%; substantive 14 = 10.5%; phrase-bank 83 = 62.4%) — contentless praise, else minimalism; 4★ 7 (100% substantive, 0 phrase-bank) — 'I like it, but…', every one names a specific gap; 3★ 4 (100%) — cap, crash, or paid-model confusion; 2★ 3 (100%) — the 2-habit cap, all three; 1★ 19 (100%) — monetisation and billing, 16 of 19

- **Where:** Part 4 ratings table (verbatim) — 5★ 133 (substantive 14, phrase-bank 83; contentless praise, else minimalism); 4★ 7 (100% substantive, 'I like it, but…'); 3★ 4 (cap, crash, paid-model confusion); 2★ 3 (the 2-habit cap, all three); 1★ 19 (monetisation and billing, 16 of 19)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ★ | n | % of 166 | Substantive | Phrase-bank | Dominant reason ; 5 | 133 | 80.12% | 14 (10.5%) | 83 (62.4%) | Contentless praise; where a reason is given, minimalism ; 4 | 7 | 4.22% | 7 (100%) | 0 | "I like it, but…" — every one names a specific gap ; 3 | 4 | 2.41% | 4 (100%) | 0 | Cap, crash, or paid-model confusion ; 2 | 3 | 1.81% | 3 (100%) | 0 | The 2-habit cap, all three ; 1 | 19 | 11.45% | 19 (100%) | 0 | Monetization and billing, 16 of 19
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R30-062 — Supported: the cap is the dominant blocker to both usage and purchase; the widget is the most wanted paid feature; the purchase flow has at least four specific defects; price objections are value objections; not supported and not claimed: any conversion rate, ARPU, refund rate, trial-start rate, or the relative performance of the four SKUs — the corpus cannot see anyone who paid and was quietly happy

- **Where:** §5.5 What the corpus does and does not support — supported: the cap is the dominant blocker to usage and purchase; the widget is the most wanted paid feature; the purchase flow has at least four defects; price objections are value objections; not claimed: any conversion, ARPU, refund or trial-start rate, or relative SKU performance — the corpus cannot see anyone who paid and was quietly happy
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (scope statement)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R30-066 — High-review-volume storefronts defined from this corpus (n ≥ 10: RU 56, US 31, GB 19, ES 13, CL 11 = 130, 78.3%) hold 80 of the 83 phrase-bank reviews (96.4%; the other 3 in NL and FR); combined headline mean 4.73 vs substantive mean 3.41 (n=22); the high-volume group is the least informative per review — 130 reviews yield 22 substantive records while the other 36 reviews across 16 storefronts yield 25; volume and signal are inversely related, so product decisions should be weighted toward the long tail — AR, BR, SA, UA, TR, IT, JP, MX, IL, UY, KZ — where the organic reviewers are

- **Where:** §6.4 High-review-volume markets (n≥10: RU, US, GB, ES, CL = 130, 78.3%) hold 80 of 83 phrase-bank reviews (96.4%); headline mean 4.73 vs substantive 3.41 (n=22); 130 reviews yield 22 substantive while the other 36 over 16 storefronts yield 25 — volume and signal are inversely related; weight decisions toward the long tail (AR, BR, SA, UA, TR, IT, JP, MX, IL, UY, KZ)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 80/83 phrase-bank in top 5; 22 vs 25 substantive
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R30-089 — Research questions: what is the real reception in the US, GB, DE, FR, CA and AU — 58 high-spend reviews yield 8 substantive records, the product is commercially blind in its highest-value markets (method: in-app survey or a clean review-prompt cohort, not more store reviews); why are both billing failures Russian — payment processing, SKU availability, or simply the only market with continuous purchase attempts; did the 2→3 cap change actually run and when (release notes would confirm); does anyone pay and stay happy — zero satisfied-payer reviews, so retention/renewal is entirely unmeasured; what happens to the public rating over the next two quarters — the organic trajectory is ~3.0★, forecastable internally and to be monitored, not discovered

- **Where:** §8.4 Research questions Part 8 #1, Part 8 #2, Part 8 #3, Part 8 #4, Part 8 #5 — the real reception in US, GB, DE, FR, CA, AU (58 high-spend reviews yield 8 substantive; method: in-app survey or a clean review-prompt cohort, not more store reviews); why both billing failures are Russian; did the 2→3 change run and when; does anyone pay and stay happy (zero satisfied-payer reviews); what happens to the public rating over the next two quarters (~3.0★ trajectory — forecast internally, don't discover it)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (questions)
- **Direction for us:** research · **Report confidence:** open questions · **Generalisable:** yes
- **Canonical:** — (nuance register)
