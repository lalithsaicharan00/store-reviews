# Cards — report 24

Source: `App Store Reports/24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help (REPORT).md`  
195 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 9
- [Must-haves](#must-haves) — 10
- [Must never break](#must-never-break) — 23
- [Features](#features) — 29
- [Monetization](#monetization) — 9
- [Tactics the app used](#tactics-the-app-used) — 3
- [Insights (the why)](#insights-the-why) — 25
- [Audiences](#audiences) — 8
- [Markets and languages](#markets-and-languages) — 12
- [Dated events and trends](#dated-events-and-trends) — 14
- [Positioning](#positioning) — 4
- [Anti-patterns](#anti-patterns) — 12
- [Things not to do](#things-not-to-do) — 9
- [Things to do](#things-to-do) — 5
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 22

## Product rules

### R24-093 — The same constraint that produces small-steps praise (4.18%, mean 4.692) produces the forced-water/breakfast complaint (0.29%, mean 2.452) and feeds 'cannot customise' (0.40%, 2.097) and 'too slow / shallow' (0.39%, 2.393); any relaxation has to be an opt-out for the minority who already have the habit, not a default change — the corpus is explicit that the default is why the product works

- **Where:** §3.3 This is also the source of the biggest product complaint — the constraint is the value proposition and the top product objection; any relaxation must be an opt-out, not a default change
- **This app does:** constraint as product
- **User reaction:** mixed
- **Magnitude:** 4.18% praise vs 0.29% + 0.40% + 0.39% objection
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R24-106 — The corpus does not ask for the constraint to be removed; it asks for one branch — a way to declare an existing habit as already held and start at habit two; small cost, and it addresses the concrete example inside several much larger personalisation complaints

- **Where:** §4.1 Interpretation — the corpus asks for one branch: declare an existing habit as already-held and start at habit two
- **This app does:** no 'already do this' branch
- **User reaction:** complaint
- **Magnitude:** 124 (0.29%) direct; feeds 175 + 168
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R24-124 — The subscription is invisible where iOS users look: 125 state explicitly it does not appear in Apple Subscriptions, 204 the broader off-Apple fact; because it was sold on the web, cancelling in the App Store does nothing

- **Where:** §6.2 (4) The subscription is invisible where iOS users look — not in Apple Subscriptions; cancelling in the App Store does nothing
- **This app does:** web-sold subscription invisible in iOS
- **User reaction:** 1★-burst
- **Magnitude:** 125 (0.29%, mean 1.136); 204 (0.47%, mean 1.118)
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12932307919`, `14396308469`, `13276324661`, `14085528402`, `13631053622`
- **Canonical:** C112 In-app cancellation; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-164 — The winning mechanic is the constraint, not the content: users convert because the app refuses to let them over-commit (mean 4.692) — anyone shipping a habit tracker with unlimited habits is competing against the wrong thing

- **Where:** Part 10 #2 — the winning mechanic is the constraint, not the content; anyone shipping unlimited habits is competing against the wrong thing
- **This app does:** constrained pacing
- **User reaction:** purchase-driver
- **Magnitude:** 1,817, mean 4.692
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R24-165 — The single biggest available advantage is billing hygiene: sell through Apple IAP, make the subscription visible in Apple Subscriptions, honour cancellation — and you have differentiated against 5,791 reviews of published grievance; Finch is named 19 times and the reason is business-model trust, not features

- **Where:** Part 10 #3 — the single biggest available advantage is billing hygiene: sell through Apple IAP, visible in Apple Subscriptions, honour cancellation; Finch named 19× for business-model trust
- **This app does:** off-Apple billing
- **User reaction:** churn
- **Magnitude:** 5,791; Finch 19
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-171 — Move subscription billing into Apple IAP, or at minimum surface the web subscription inside the app with a one-tap cancel — addresses not-in-Apple (125), cannot-cancel (1,146) and a large share of charged-after-cancel (1,620) at the root

- **Where:** §11.1 Part 11 #1 — move subscription billing into Apple IAP, or surface the web subscription in-app with one-tap cancel [high-priority]
- **This app does:** off-Apple
- **User reaction:** 1★-burst
- **Magnitude:** 125 + 1,146 + 1,620
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C112 In-app cancellation; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-173 — Stop creating subscriptions during onboarding without a priced, explicit confirmation — 324 bundle complaints (mean 1.398), 338 no-consent charges (mean 1.047)

- **Where:** §11.1 Part 11 #3 — stop creating subscriptions during onboarding without a priced, explicit confirmation [very strong]
- **This app does:** silent bundle enrolment
- **User reaction:** 1★-burst
- **Magnitude:** 324 + 338
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C211 No second, separately-cancelled add-on subscription

### R24-181 — Let users declare a habit already-held and start at habit two — addresses forced water/breakfast (124) and softens no-customisation (175) and slow/shallow (168); keep the default, which is why the product works

- **Where:** §11.3 Part 11 #11 — let users declare a habit already-held and start at habit two; keep the default [weak individually, structurally important]
- **This app does:** no already-held branch
- **User reaction:** complaint
- **Magnitude:** 124 + 175 + 168
- **Direction for us:** product-rule · **Report confidence:** weak individually, structurally important · **Generalisable:** yes
- **Canonical:** C160 Honour what onboarding asks — a declared limitation must change the suggestions; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R24-188 — Decide whether the ADHD claim is a marketing frame or a design constraint — the segment is 6.01% of E4 reviews, rates 2.747, and names the interface and the cancellation flow as actively hostile to the condition; either build for it or stop claiming it

- **Where:** §11.4 Part 11 #18 — decide whether the ADHD claim is a marketing frame or a design constraint: either build for it or stop claiming it [very strong]
- **This app does:** ADHD as marketing only
- **User reaction:** churn
- **Magnitude:** 6.01% of E4; 2.747
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Must-haves

### R24-052 — Cannot find / complete cancellation

- **Where:** §3.1 theme table #12 Cannot find / complete cancellation
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 1,146 (2.64%, meaningful), mean 1.115, 1★ 92.3%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C112 In-app cancellation

### R24-054 — Support unresponsive / automated only

- **Where:** §3.1 theme table #14 Support unresponsive / automated only
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 947 (2.18%, meaningful), mean 1.528, 1★ 80.0%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C215 Support reply time must be shorter than any cancellation deadline it serves

### R24-074 — Privacy / personal data complaints run at mean 1.225 (87.7% 1★)

- **Where:** §3.1 #35 Privacy / personal data — mean 1.225
- **This app does:** long questionnaire, web billing collects card data
- **User reaction:** complaint
- **Magnitude:** 138 (0.32%, weak), mean 1.225
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C085 Address tracking / privacy visibly

### R24-127 — Support cannot resolve it: 947 (2.18%, mean 1.528) describe unresponsive or automated-only support; 17 name the specific obstacle — a web contact form with a 250-character limit and no telephone number; 968 (2.23%, mean 1.070) report a refund refused citing a cancel-24-hours-before clause or the non-refundable set-up fee

- **Where:** §6.2 (7) Support cannot resolve it — web form with a 250-character limit and no telephone; refunds refused citing a 24-hour clause or the non-refundable fee
- **This app does:** contact form with 250-char limit; automated refusals
- **User reaction:** 1★-burst
- **Magnitude:** 947 (2.18%); 17 name the form; 968 (2.23%) refused
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12684356794`, `12961953095`, `13116907572`, `13473184526`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request; C215 Support reply time must be shorter than any cancellation deadline it serves

### R24-175 — Give support a real channel and an exception path — 947 (mean 1.528) describe automated-only support and the 250-character form is named 17 times; the refund path demonstrably works when reached

- **Where:** §11.1 Part 11 #5 — give support a real channel and an exception path; the refund path works when reached [meaningful]
- **This app does:** automated support only
- **User reaction:** complaint
- **Magnitude:** 947; 17
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C215 Support reply time must be shorter than any cancellation deadline it serves

### R24-176 — Send a renewal reminder — 197 reviews (mean 1.168) say no notice was given; the cheapest single item on the list

- **Where:** §11.1 Part 11 #6 — send a renewal reminder; the cheapest single item [weak but trivially cheap]
- **This app does:** no renewal notice
- **User reaction:** 1★-burst
- **Magnitude:** 197, mean 1.168
- **Direction for us:** must-have · **Report confidence:** weak but trivially cheap · **Generalisable:** yes
- **Canonical:** C221 A receipt with a working product link after every charge, and a renewal reminder before it

### R24-177 — Ship a low-stimulus mode — a home screen that opens on today's routine with coaching, Discover, Circles and cross-app promotion below the fold; 46.1% of the 1,324 requests are from 4–5★ reviewers — a retention feature, not complaint triage

- **Where:** §11.2 Part 11 #7 — ship a low-stimulus mode: a home screen that opens on today's routine with coaching, Discover, Circles and cross-app promotion below the fold [very strong]
- **This app does:** busy home screen
- **User reaction:** complaint
- **Magnitude:** 1,324 (3.05%), 46.1% 4–5★
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C159 Launch-to-core-action path with no interstitials; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

### R24-179 — Make animations and completion celebrations skippable — 182 pop-up/unskippable-step reviews (mean 2.082) plus a persistent complaint that checking off one habit takes 3–5 screens

- **Where:** §11.2 Part 11 #9 — make animations and completion celebrations skippable; checking off one habit takes 3–5 screens [weak, high annoyance]
- **This app does:** unskippable celebrations
- **User reaction:** complaint
- **Magnitude:** 182, mean 2.082
- **Direction for us:** must-have · **Report confidence:** weak, high annoyance · **Generalisable:** yes
- **Canonical:** C145 Every promotional or onboarding modal must be dismissible on the smallest screen

### R24-180 — Give per-notification-type control — 744 reviews (1.71%); the specific failure is that users turn all notifications off, which disables the product

- **Where:** §11.2 Part 11 #10 — per-notification-type control; users turn all notifications off, which disables the product [meaningful]
- **This app does:** all-or-nothing notifications
- **User reaction:** complaint
- **Magnitude:** 744 (1.71%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once; C123 Notification escalation must be user-configurable, never silently retuned

### R24-186 — An iPad build and reliable cross-device restore — 257 reviews; progress loss on device change is the most-cited reason a multi-year user stops

- **Where:** §11.3 Part 11 #16 — iPad build and reliable cross-device restore; progress loss on device change is the most-cited reason a multi-year user stops [emerging]
- **This app does:** no iPad; no restore
- **User reaction:** churn
- **Magnitude:** 257 (0.59%)
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C141 Native iPad layout

## Must never break

### R24-003 — Off-Apple subscription billing is the defining fact of the corpus: core billing disputes — charged after cancelling, unable to cancel, charge invisible in Apple Subscriptions, refused refund, unauthorised or duplicate charge, a 'free' trial that charged — are the single largest theme, at mean 1.110 with 94.2% 1★; the mechanism is stated repeatedly: sold through the developer's web checkout, so it does not appear in Apple Subscriptions, cancelling in the App Store does not stop it, and Apple cannot refund a charge it never processed

- **Where:** Executive summary #1 — off-Apple subscription billing is the defining fact and the single largest theme
- **This app does:** subscription sold via own web checkout outside Apple IAP
- **User reaction:** 1★-burst
- **Magnitude:** 5,791 (13.32%, high-priority), mean 1.110, 94.2% 1★; bill_any 6,612 (15.21%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `2268729711`, `7100144631`, `8998006088`, `11677442443`, `12030528331`, `12480865958`, `13002991015`, `13373884371`, `13667952251`, `13983220851`
- **Canonical:** C029 Billing must be exactly right; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-038 — Reviewers report annual, quarterly ('every 3 months'), bimonthly, monthly and weekly cycles at overlapping prices ('this page says $59 for a year… it's $40 billed every three months'; '$39.99 for a biweekly subscription plan') — the inconsistency of what users believe they bought is itself a measurable failure and the direct cause of 'charged twice' reports, several of which are two real subscriptions

- **Where:** §2.2 e — billing periods are inconsistent (annual, quarterly, bimonthly, monthly, weekly at overlapping prices); the inconsistency of what users believe they bought is itself a product failure
- **This app does:** multiple overlapping plan periods
- **User reaction:** 1★-burst
- **Magnitude:** 4 representative reviews; duplicate charges 584 (1.34%, mean 1.134)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12308000770`, `13067587566`, `13351480495`, `14383766600`
- **Canonical:** C029 Billing must be exactly right; C113 One stable, disclosed price — no discount wheels

### R24-044 — Scam / fraud / theft vocabulary

- **Where:** §3.1 theme table #4 Scam / fraud / theft vocabulary
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 3,468 (7.98%, high-priority), mean 1.073, 1★ 96.6%
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-048 — Charged after cancelling

- **Where:** §3.1 theme table #8 Charged after cancelling
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 1,620 (3.73%, very strong), mean 1.085, 1★ 95.9%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-053 — Refund refused

- **Where:** §3.1 theme table #13 Refund refused
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 968 (2.23%, meaningful), mean 1.070, 1★ 96.3%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R24-055 — Crash / freeze / bug / won't load

- **Where:** §3.1 theme table #15 Crash / freeze / bug / won't load
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 944 (2.17%, meaningful), mean 2.367, 1★ 44.7%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R24-060 — Duplicate / repeated charges

- **Where:** §3.1 theme table #20 Duplicate / repeated charges
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 584 (1.34%, meaningful), mean 1.134, 1★ 93.7%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C232 Payment retries are bounded — daily dunning against a declined card reads as fraud to the customer and their bank

### R24-061 — 'Free' trial was not free

- **Where:** §3.1 theme table #21 'Free' trial was not free
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 506 (1.16%, meaningful), mean 1.136, 1★ 92.9%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C109 A free trial must be a real trial

### R24-063 — Charge without consent / warning — the lowest mean in the corpus

- **Where:** §3.1 theme table #23 Charge without consent / warning
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 338 (0.78%, emerging), mean 1.047, 1★ 97.3%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C211 No second, separately-cancelled add-on subscription

### R24-068 — No iPad / lost progress on device change

- **Where:** §3.1 theme table #28 No iPad / lost progress on device change
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 257 (0.59%, emerging), mean 2.693, 1★ 33.5%
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C141 Native iPad layout

### R24-071 — Auto-renewal with no notice

- **Where:** §3.1 #30 Auto-renewal with no notice
- **This app does:** no renewal reminder
- **User reaction:** 1★-burst
- **Magnitude:** 197 (0.45%, weak), mean 1.168, 88.8% 1★, 0.0% 5★
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C221 A receipt with a working product link after every charge, and a renewal reminder before it

### R24-079 — Cannot log in / paid but no premium access

- **Where:** §3.1 #43 Cannot log in / paid but no access
- **This app does:** entitlement not delivered
- **User reaction:** 1★-burst
- **Magnitude:** 96 (0.22%, weak), mean 1.375, 78.1% 1★
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C139 Cache entitlements locally — never block a paid surface on a live server check

### R24-082 — Audio plays through the silent switch or after close

- **Where:** §3.1 #49 Audio overrides silent switch
- **This app does:** audio ignores silent switch
- **User reaction:** complaint
- **Magnitude:** 56 (0.13%, weak), mean 2.036, 58.9% 1★
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R24-094 — Broken things: crash / freeze / won't load past the first screen (944, 2.17%, mean 2.367); cannot log in / paid but no premium access (96, mean 1.375); progress lost on device change / no restore (257, 0.59%, mean 2.693); audio plays through the silent switch or after close (56, mean 2.036)

- **Where:** §3.4 Broken table (verbatim) — crash/won't load past the first screen 944; cannot log in / paid but no access 96; progress lost on device change 257; audio through silent switch 56
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Need | n | % | Mean ★ | Evidence ; Crash / freeze / won't load past the first screen | 944 | 2.17% | 2.367 | 2010369280, 6305332926, 7752054215, 10054955195, 12202917593, 13339042150 ; Cannot log in / paid but no premium access | 96 | 0.22% | 1.375 | 4120717487, 7166047365, 9167146840, 11074882111, 12528709109, 13576987510 ; Progress lost on device change / no restore | 257 | 0.59% | 2.693 | 1990102873, 4726706775, 6722624148, 8221914407, 10650989543, 12047728556 ; Audio plays through the silent switch / after close | 56 | 0.13% | 2.036 | 2412897605, 3497727528, 5849678518, 7561940570, 9943848741
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `2010369280`, `6305332926`, `7752054215`, `10054955195`, `12202917593`, `13339042150`, `4120717487`, `7166047365`, `9167146840`, `11074882111`, `12528709109`, `13576987510`, `1990102873`, `4726706775`, `6722624148`, `8221914407`, `10650989543`, `12047728556`, `2412897605`, `3497727528`, `5849678518`, `7561940570`, `9943848741`
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C139 Cache entitlements locally — never block a paid surface on a live server check

### R24-120 — Billing scale: bill_core 5,791 (13.32%, mean 1.110, 94.2% 1★); bill_any 6,612 (15.21%); 5,458 of 10,413 1★ reviews (52.4%); 4,042 of 10,637 E4 reviews (38.00%) — high-priority on every denominator that matters; no product theme reaches half this size and no theme has a lower mean

- **Where:** §6.1 Scale table (verbatim) — bill_core 13.32%; 52.4% of 1★; 38.00% of E4; no product theme reaches half this size and none has a lower mean
- **This app does:** off-Apple billing
- **User reaction:** 1★-burst
- **Magnitude:** Measure | n | % of 43,469 | Mean ★ | %1★ ; bill_core — any core dispute | 5,791 | 13.32% | 1.110 | 94.2% ; bill_any — incl. refund/support/price/bundle | 6,612 | 15.21% | 1.201 | 91.1% ; Share of the entire 1★ band that is bill_core | 5,458 of 10,413 | 52.4% of 1★ | — | — ; Share of E4 (2024–26) that is bill_core | 4,042 of 10,637 | 38.00% of E4 | — | —
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-122 — The trial is charged via a 'pay what you can' set-up fee ($1 / $10 / ~$16) described as covering costs and classed in the terms as non-refundable

- **Where:** §6.2 (2) The trial is charged — 'pay what you can' $1 / $10 / ~$16 set-up fee, non-refundable
- **This app does:** paid non-refundable 'free trial'
- **User reaction:** 1★-burst
- **Magnitude:** 506 (1.16%) trial charged; 100 name the fee, mean 1.110
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13983838985`, `10909330947`, `13278190010`, `13591196521`, `14453348484`
- **Canonical:** C109 A free trial must be a real trial

### R24-123 — One or more subscriptions are created that the user did not knowingly select — the bundle (324) and charges with no consent or warning at all (338, mean 1.047, the lowest in the corpus)

- **Where:** §6.2 (3) One or more subscriptions created that the user did not knowingly select — bundle 324; charge with no consent or warning 338
- **This app does:** silent enrolment
- **User reaction:** 1★-burst
- **Magnitude:** 324 (0.75%); 338 (0.78%, mean 1.047, 97.3% 1★)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13578287485`, `14420525318`, `13759495643`, `14406647146`
- **Canonical:** C029 Billing must be exactly right; C211 No second, separately-cancelled add-on subscription

### R24-125 — Cancellation does not stop the charge: 1,620 (3.73%, mean 1.085) were charged after cancelling and 227 state they hold a screenshot or e-mail confirming the cancellation

- **Where:** §6.2 (5) Cancellation does not stop the charge — 227 hold a screenshot or e-mail confirming cancellation and were charged anyway
- **This app does:** confirmed cancellations still billed
- **User reaction:** 1★-burst
- **Magnitude:** 1,620 (3.73%), mean 1.085; 227 with proof
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `7226767053`, `7717432145`, `12153410886`, `13029061238`, `14372809998`, `14457740924`
- **Canonical:** C029 Billing must be exactly right; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R24-126 — Payment retry behaviour looks like a loop to the customer: 584 (1.34%) report duplicate or repeated charges, 117 describe daily or near-daily retry attempts, and 123 report their bank flagging or blocking the merchant as fraud

- **Where:** §6.2 (6) Retry behaviour looks like a payment loop — daily retries (117); bank flags or blocks the merchant as fraud (123)
- **This app does:** aggressive dunning retries
- **User reaction:** 1★-burst
- **Magnitude:** 584 (1.34%); 117 daily retries; 123 bank-flagged
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13884799619`, `11914953567`, `13853634156`, `7041235372`, `13116907572`
- **Canonical:** C232 Payment retries are bounded — daily dunning against a declined card reads as fraud to the customer and their bank

### R24-172 — Honour cancellations that the company's own system already confirmed — 227 reviews hold an e-mail or screenshot and were charged anyway; whatever the cause (a second subscription, a bundle, a race condition) it is the highest-intensity failure in the corpus and falsifiable internally

- **Where:** §11.1 Part 11 #2 — honour cancellations the company's own system already confirmed (227 with e-mail/screenshot) — the highest-intensity failure, falsifiable internally [high-priority]
- **This app does:** confirmed cancellations still billed
- **User reaction:** 1★-burst
- **Magnitude:** 227
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R24-174 — Fix payment retry — 584 duplicate-charge reports and 123 bank-fraud-flag reports; repeated same-day retries against a declined card read as fraud to both the customer and their bank

- **Where:** §11.1 Part 11 #4 — fix payment retry: repeated same-day retries against a declined card read as fraud to the customer and their bank [meaningful]
- **This app does:** aggressive dunning
- **User reaction:** 1★-burst
- **Magnitude:** 584; 123
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C232 Payment retries are bounded — daily dunning against a declined card reads as fraud to the customer and their bank

### R24-187 — Fix the first-run reliability failures — 944 crash/freeze reports; the recurring shape is the app freezing on the 'first mountain' / Journeys screen on day one, and paid users who cannot log in at all (96)

- **Where:** §11.3 Part 11 #17 — fix first-run reliability: freezing on the 'first mountain' / Journeys screen on day one; paid users who cannot log in (96) [meaningful]
- **This app does:** day-one freeze; login failures
- **User reaction:** 1★-burst
- **Magnitude:** 944 (2.17%); 96
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C139 Cache entitlements locally — never block a paid surface on a live server check

### R24-189 — Publish one price — the corpus contains annual, quarterly, bimonthly, monthly and weekly cycles at overlapping prices plus a cancellation flow that discounts to $2–$5

- **Where:** §11.4 Part 11 #19 — publish one price: annual, quarterly, bimonthly, monthly and weekly at overlapping prices plus a cancel flow that discounts to $2–$5 [meaningful]
- **This app does:** many overlapping prices
- **User reaction:** complaint
- **Magnitude:** price objection 791; cancel-flow discounts 5 named
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C113 One stable, disclosed price — no discount wheels

## Features

### R24-010 — Users cannot skip the forced first habit 'drink water' (then 'eat breakfast') — a weak count but unusually consistent wording across eleven years and many languages, recurring inside larger complaints as the concrete example of 'not personalised'

- **Where:** Executive summary #8 — the forced first habit ('drink water', then 'eat breakfast') is a small theme with an outsized narrative footprint
- **This app does:** forced starter habit, unskippable
- **User reaction:** complaint
- **Magnitude:** 124 (0.29%, weak), mean 2.452
- **Direction for us:** product-rule · **Report confidence:** weak but persistent · **Generalisable:** yes
- **Review IDs:** `2059294945`, `4219672380`, `5251295013`, `6031701613`, `7231330364`, `8128909538`, `9936616848`, `11852321733`, `12846167630`
- **Canonical:** C160 Honour what onboarding asks — a declared limitation must change the suggestions; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R24-022 — Onboarding is a long questionnaire (often reached via an Instagram / Facebook / X advert), a 'letter from your future self' and a held-finger 'contract' signing using the fingerprint sensor

- **Where:** §2.1 Onboarding — long questionnaire via social ads, 'letter from your future self', held-finger 'contract' signing with the fingerprint sensor
- **This app does:** long ritual onboarding after paid social ads
- **User reaction:** mixed
- **Magnitude:** inventory row; onboarding too long 45 (0.10%, mean 1.600)
- **Direction for us:** dont · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `7608105779`, `13641827689`, `11036419330`, `11785559577`
- **Canonical:** C111 No long quiz before the price; show the price up front; C161 Values and identity screens are optional in both directions

### R24-023 — Morning / afternoon / evening routine checklists with timers and per-habit guided content are the core product

- **Where:** §2.1 Rituals / routines — morning, afternoon, evening checklists with timers and per-habit guided content
- **This app does:** routine checklists with timers, guided
- **User reaction:** praise
- **Magnitude:** routine built 3,611 (8.31%, mean 4.467)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11122189610`, `12016141805`, `11743843988`
- **Canonical:** C118 Preset routines / templates / programs

### R24-024 — The first habit is universally 'drink a glass of water on waking', gated three days before the next unlocks, then 'eat a healthy breakfast', then exercise

- **Where:** §2.1 The first habit — 'drink a glass of water on waking', gated 3 days before the next unlocks; then breakfast, then exercise
- **This app does:** forced, time-gated starter sequence
- **User reaction:** mixed
- **Magnitude:** 124 (0.29%) object
- **Direction for us:** product-rule · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11007332063`, `12377235635`, `14003383594`
- **Canonical:** C160 Honour what onboarding asks — a declared limitation must change the suggestions; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R24-025 — Multi-week guided programmes ('Journeys') rendered as a mountain map with an animated traveller

- **Where:** §2.1 Journeys / mountains — multi-week guided programmes as a mountain map with an animated traveller
- **This app does:** guided programmes, premium
- **User reaction:** praise
- **Magnitude:** inventory row
- **Direction for us:** build-paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11842141822`, `13355228633`, `13650208449`
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C118 Preset routines / templates / programs

### R24-026 — Three short narrated audio-plus-text coaching pieces per day quoting named authors and researchers, plus written 'letters' including 'from your future self'

- **Where:** §2.1 Daily / focus / nightly coaching — three short narrated audio-plus-text pieces per day with quotes from named authors and researchers; letters
- **This app does:** daily coaching content, premium
- **User reaction:** praise
- **Magnitude:** coaching praised 6,095 (14.02%, mean 4.483); science framing 736 (1.69%, mean 3.865)
- **Direction for us:** build-paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11622883414`, `11839073307`, `12832796136`, `11066361054`, `5594181955`
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R24-027 — Time-boxed group challenges and an in-app community feed ('Circles') with comments and writing prompts

- **Where:** §2.1 Challenges — time-boxed group challenges ('no sugar for a week'); Circles — in-app community feed
- **This app does:** challenges and community feed
- **User reaction:** mixed
- **Magnitude:** Circles 370 (0.85%, mean 3.897)
- **Direction for us:** research · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `6543667873`, `11305397471`, `11294707285`, `11691602301`
- **Canonical:** C015 Shared / group habits; C202 A light social layer that is explicitly not a social network

### R24-028 — The 'Make Me Fabulous' activity launcher (guided meditation, stretching, deep-work ritual) is repeatedly reported removed or unfindable after a redesign; the deep-work ramp-up ritual is named by long-tenure users as the single reason they renew

- **Where:** §2.1 Make Me Fabulous / Launch — activity launcher repeatedly reported removed or unfindable after a redesign; Deep work — reason long-tenure users renew
- **This app does:** removed / hid a feature that long-tenure users renewed for
- **User reaction:** churn
- **Magnitude:** 3 + 1 reviews cited
- **Direction for us:** product-rule · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11842141822`, `12337019505`, `14506251739`
- **Canonical:** C066 Focus timer; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R24-029 — Background soundscapes and per-task music (praised, mean 4.387), a daily mood check-in, and streak counters with 'freeze' passes and certificates

- **Where:** §2.1 Ambient sound / music; mood tracking; streaks / freezes / certificates
- **This app does:** audio, mood, streaks with freezes
- **User reaction:** mixed
- **Magnitude:** music 282 (0.65%, mean 4.387)
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `5282944837`, `14346117158`, `13514681303`, `13044004537`, `12611007165`, `14245283579`, `13650208449`
- **Canonical:** C024 Streaks / gamification; C049 Mood tracker; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R24-030 — Apple Watch and widget exist but are barely mentioned — 69 (0.16%) and 53 (0.12%) — in a 43,469-review corpus

- **Where:** §2.1 Apple Watch present but thin (69, 0.16%); Widget present but thin (53, 0.12%)
- **This app does:** Watch and widget present, marginal
- **User reaction:** mixed
- **Magnitude:** Watch 69 (0.16%, mean 3.116); widget 53 (0.12%, mean 3.868)
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** app-specific
- **Review IDs:** `2006599866`, `6405204376`, `8265107322`, `2095635360`, `9515548817`, `10519844634`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R24-031 — An AI chat/coach bubble appearing from roughly 2025 is described as an unwanted addition by long-tenure users; AI-generated art/copy is the worst-rated non-billing theme (mean 1.156, 90.6% 1★), small and recent

- **Where:** §2.1 AI assistant — chat/coach bubble from ~2025, an unwanted addition for long-tenure users; AI-generated art/copy theme mean 1.156
- **This app does:** added an AI assistant; AI-generated art/copy
- **User reaction:** complaint
- **Magnitude:** AI art/copy 64 (0.15%, weak, mean 1.156, 90.6% 1★)
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12846915013`, `14262152932`, `13581200143`
- **Canonical:** C056 Don't build AI features on demand grounds

### R24-045 — Art / design / graphics praised

- **Where:** §3.1 theme table #5 Art / design / graphics
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 2,969 (6.83%, high-priority), mean 4.089, 1★ 11.4%, 5★ 61.3%
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C134 Lead the store listing with what users actually love

### R24-058 — Notification volume / control

- **Where:** §3.1 theme table #18 Notification volume / control
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 744 (1.71%, meaningful), mean 2.437, 1★ 43.7%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once; C123 Notification escalation must be user-configurable, never silently retuned

### R24-062 — Community / Circles

- **Where:** §3.1 theme table #22 Community / Circles
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 370 (0.85%, emerging), mean 3.897, 1★ 14.3%, 5★ 54.9%
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C015 Shared / group habits; C202 A light social layer that is explicitly not a social network

### R24-067 — Music / audio / narration praised

- **Where:** §3.1 theme table #27 Music / audio / narration
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 282 (0.65%, emerging), mean 4.387, 5★ 69.5%
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R24-076 — Accessibility (vision, font size, VoiceOver) requests

- **Where:** §3.1 #37 Accessibility (vision, font, VoiceOver)
- **This app does:** accessibility gaps
- **User reaction:** complaint
- **Magnitude:** 129 (0.30%, weak), mean 3.101
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R24-078 — Repetitive coaching content

- **Where:** §3.1 #41 Repetitive coaching content
- **This app does:** content repeats
- **User reaction:** complaint
- **Magnitude:** 103 (0.24%, weak), mean 2.660
- **Direction for us:** build-paid · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C196 A subscription is a promise of continued delivery — back it with a visible cadence

### R24-080 — Cannot undo a tick or backfill a missed day

- **Where:** §3.1 #45 Cannot undo or backfill a day
- **This app does:** no backfill/undo
- **User reaction:** complaint
- **Magnitude:** 70 (0.16%, weak), mean 2.700
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C010 Backfill missed days / edit start date

### R24-085 — Dark mode (43) and per-weekday / shift-work scheduling (31) requested, predominantly by satisfied users

- **Where:** §3.1 #53 No dark mode; #54 no per-weekday / shift-work schedule
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 43 (0.10%, mean 3.535); 31 (0.07%, mean 3.484)
- **Direction for us:** must-have · **Report confidence:** ignore · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency; C080 Colour themes / dark mode

### R24-096 — A calmer, less busy home screen is the largest unbuilt request and 46.1% of it comes from satisfied 4–5★ users — a retention-preserving feature

- **Where:** §3.4 A calmer, less busy home screen — 46.1% requested by 4–5★ users
- **This app does:** busy home screen
- **User reaction:** complaint
- **Magnitude:** 1,324 (3.05%), 46.1% 4–5★
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `7280199018`, `9617541402`, `11583598458`, `12674646598`, `13654261115`
- **Canonical:** C159 Launch-to-core-action path with no interstitials; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

### R24-097 — Fewer or controllable notifications requested

- **Where:** §3.4 Fewer / controllable notifications
- **This app does:** high notification volume
- **User reaction:** complaint
- **Magnitude:** 744 (1.71%, meaningful), mean 2.437, 28.5% 4–5★
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `4831434999`, `7192135813`, `8812657942`, `10075146878`, `13509348951`
- **Canonical:** C039 Reminders fire reliably, once; C123 Notification escalation must be user-configurable, never silently retuned

### R24-098 — Per-weekday / shift-work scheduling is requested predominantly by satisfied users

- **Where:** §3.4 Per-weekday / shift-work scheduling — 51.6% from 4–5★ users
- **This app does:** daily-only routines
- **User reaction:** complaint
- **Magnitude:** 31 (0.07%), 51.6% 4–5★
- **Direction for us:** must-have · **Report confidence:** ignore (but retained users) · **Generalisable:** yes
- **Review IDs:** `3862126193`, `5984966483`, `7852053634`, `9671088387`, `11251746171`
- **Canonical:** C043 Flexible / custom frequency

### R24-099 — Dark mode is requested predominantly by satisfied, retained users

- **Where:** §3.4 Dark mode — 58.1% from 4–5★ users
- **This app does:** no dark mode
- **User reaction:** complaint
- **Magnitude:** 43 (0.10%), 58.1% 4–5★
- **Direction for us:** build-free · **Report confidence:** ignore (but retained users) · **Generalisable:** yes
- **Review IDs:** `2419357081`, `6929437572`, `7390272530`, `7848606261`, `9789125721`
- **Canonical:** C080 Colour themes / dark mode

### R24-100 — An iPad app and cross-device continuity are requested; progress is lost on device change with no restore

- **Where:** §3.4 iPad app / cross-device continuity; progress lost on device change
- **This app does:** no iPad; no restore
- **User reaction:** complaint
- **Magnitude:** 257 (0.59%, emerging), mean 2.693, 34.2% 4–5★
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `3669324936`, `5629701161`, `7613143521`, `9190530552`, `12047728556`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C141 Native iPad layout

### R24-141 — Long-tenure paying users ask to save or re-listen to a coaching piece and cannot — 'the main reason, every year, I seriously consider whether or not I will even renew'; related: cannot revisit journal entries; background music removed

- **Where:** §7.3 A specific under-served request — long-tenure payers cannot save or re-listen to a coaching piece ('the main reason, every year, I seriously consider whether I will even renew'); cannot revisit journal entries; background music removed
- **This app does:** no library / replay of paid content
- **User reaction:** churn
- **Magnitude:** 3 named reviews
- **Direction for us:** must-have · **Report confidence:** limited evidence, high value · **Generalisable:** yes
- **Review IDs:** `13236083919`, `14280639299`, `14346117158`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace; C233 Content the user paid for is saveable and replayable — a library, not a stream

### R24-182 — Per-weekday and shift-work scheduling — 31 reviews but 51.6% are 4–5★

- **Where:** §11.3 Part 11 #12 — per-weekday and shift-work scheduling (51.6% are 4–5★) [weak, high-value requester]
- **This app does:** daily-only
- **User reaction:** complaint
- **Magnitude:** 31, 51.6% 4–5★
- **Direction for us:** must-have · **Report confidence:** weak, high-value requester · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency

### R24-183 — Backfill and undo — 70 reviews; the emotional cost is disproportionate because it breaks streaks the product itself made meaningful

- **Where:** §11.3 Part 11 #13 — backfill and undo; the emotional cost is disproportionate because it breaks streaks the product made meaningful [weak]
- **This app does:** no backfill/undo
- **User reaction:** complaint
- **Magnitude:** 70
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C010 Backfill missed days / edit start date

### R24-184 — Dark mode — 43 reviews, 58.1% from 4–5★ reviewers; cheap and requested by advocates

- **Where:** §11.3 Part 11 #14 — dark mode, 58.1% from 4–5★ reviewers [cheap, requested by advocates]
- **This app does:** no dark mode
- **User reaction:** complaint
- **Magnitude:** 43, 58.1% 4–5★
- **Direction for us:** build-free · **Report confidence:** ignore-to-weak, cheap · **Generalisable:** yes
- **Canonical:** C080 Colour themes / dark mode

### R24-185 — Save / re-listen to coaching pieces and revisit past journal entries — named by long-tenure paying users as a renewal factor

- **Where:** §11.3 Part 11 #15 — save / re-listen to coaching and revisit past journal entries; named by long-tenure payers as a renewal factor [weak]
- **This app does:** no content library
- **User reaction:** churn
- **Magnitude:** 2 named reviews
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13236083919`, `14280639299`
- **Canonical:** C233 Content the user paid for is saveable and replayable — a library, not a stream

## Monetization

### R24-033 — A real free tier exists but is hard to find — behind a small 'X' or 'skip' on the trial splash; limits reported as roughly 3–4 habits with coaching locked

- **Where:** §2.2 a — a real free tier exists and is hard to find (behind a small X/skip on the trial splash); ~3–4 habits, coaching locked
- **This app does:** hidden free tier, ~3–4 habits, coaching paid
- **User reaction:** mixed
- **Magnitude:** free-tier-generous 77 (0.18%, mean 4.442)
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12877743366`, `13649333600`, `11726445406`, `11086090742`, `12130093563`, `12206048353`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C133 Gate on capability, not on quantity

### R24-034 — The 'free trial' charges: a 'pay what you can' set-up fee presented on a donation-style screen with options around $1 / $10 / $16.41, described in the terms as non-refundable

- **Where:** §2.2 b — the trial is usually not free: a 'pay what you can' non-refundable set-up fee ($1 / $10 / $16.41) on a donation-style screen
- **This app does:** paid, non-refundable trial set-up fee
- **User reaction:** 1★-burst
- **Magnitude:** 506 (1.16%) say the trial charged; 100 name the set-up fee, mean 1.110
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8078038999`, `11270936086`, `11998625607`, `12241507559`, `12644539764`, `13252486000`, `13417041561`, `13614621943`, `13761067153`, `14057143520`
- **Canonical:** C109 A free trial must be a real trial

### R24-035 — Billing runs outside Apple: reviewers state the charge does not appear in Apple Subscriptions, cancelling through Apple does not stop it, and they had to cancel on the developer's website; statement merchant names 'Fabulous SAS', 'Fabulous App Paris', 'thefab.co', processor Chargebee

- **Where:** §2.2 c — billing runs outside Apple: not in Apple Subscriptions, cancelling via Apple does nothing, cancel on the developer's website; merchants 'Fabulous SAS', 'Fabulous App Paris', 'thefab.co', processor Chargebee
- **This app does:** web checkout via Chargebee
- **User reaction:** 1★-burst
- **Magnitude:** 204 (0.47%) explicit, mean 1.118
- **Direction for us:** product-rule · **Report confidence:** emerging (explicit) / high-priority (composite) · **Generalisable:** yes
- **Review IDs:** `5562765503`, `8681528284`, `9383000414`, `11023024817`, `11781065148`, `12060309335`, `12390941468`, `12864469399`, `13295929517`, `13631053622`, `13849680698`, `14119700381`
- **Canonical:** C112 In-app cancellation; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-037 — Prices named (testimony, mixed currencies): $40 (491) · $39.99 (409) · $50 (289) · $1 (221) · $60 (137) · $100 (121) · $49.99 (109) · $35 (95) · $29.99 (91) · $30 (82) · $80 (81) · $70 (80) · $34.99 (62) · $67 (35) · $19.99 (31); the recurring pairs $39.99 + $29.99 or $39.99 + $49.99 on the same day are the bundle signature in hundreds of 2024–26 reviews

- **Where:** §2.2 d — prices named by reviewers: $40 (491) · $39.99 (409) · $50 (289) · $1 (221) · $60 (137) · $100 (121) · $49.99 (109) · $35 (95) · $29.99 (91) · $30 (82) · $80 (81) · $70 (80) · $34.99 (62) · $67 (35) · $19.99 (31); $39.99 + $29.99 or + $49.99 same day is the bundle signature
- **This app does:** ~$40/yr headline; bundle adds $29.99–49.99
- **User reaction:** complaint
- **Magnitude:** $40 ×491; $39.99 ×409; pairs in hundreds of reviews
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C211 No second, separately-cancelled add-on subscription

### R24-047 — Refund requested or mentioned

- **Where:** §3.1 theme table #7 Refund requested or mentioned
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 1,737 (4.00%, very strong), mean 1.163, 1★ 92.4%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R24-057 — Price objection

- **Where:** §3.1 theme table #17 Price objection
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 791 (1.82%, meaningful), mean 2.248, 1★ 53.0%
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R24-064 — Bundle / sister-app subscription

- **Where:** §3.1 theme table #24 Bundle / sister-app subscription
- **This app does:** see §3.1
- **User reaction:** 1★-burst
- **Magnitude:** 324 (0.75%, emerging), mean 1.398, 1★ 83.6%
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C211 No second, separately-cancelled add-on subscription

### R24-142 — The price objection (791, 1.82%, mean 2.248, 53.0% 1★) is rarely to the existence of a price; it is to magnitude relative to category ($40 per quarter, or $80–$100 per month once bundles are counted, against $5–$20/year rivals), opacity (different prices quoted on different screens), and targeting (a product marketed to people with executive dysfunction and low income priced as a premium wellness subscription)

- **Where:** §7.4 Price objection examined — magnitude vs category ($40/quarter or $80–100/month with bundles vs $5–20/yr rivals), opacity (different prices on different screens), targeting (priced as premium wellness for people with executive dysfunction and low income)
- **This app does:** ~$40/quarter plus bundles; inconsistent price display
- **User reaction:** complaint
- **Magnitude:** 791 (1.82%), mean 2.248
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12185164799`, `13101231620`, `14135454399`, `13010833468`, `12308000770`, `12470218336`, `13182834152`, `13615857614`, `14350750065`, `11637887359`, `12663348260`, `13281553025`, `14110502597`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R24-143 — Counter-evidence stated fairly: the free tier is repeatedly described as genuinely usable (77 reviews, mean 4.442) and a distinct group says the price is fair for what is included ('only $20 a year and it is worth every penny')

- **Where:** §7.4 Counter-evidence — the free tier is repeatedly described as genuinely usable and a distinct group says the price is fair ('only $20 a year and it is worth every penny')
- **This app does:** usable free tier; some at $20/yr
- **User reaction:** praise
- **Magnitude:** 77 (0.18%); 3 fair-price reviews
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12877743366`, `13649333600`, `13885598213`, `14383996948`, `11062961456`, `11178556858`, `13523105037`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

## Tactics the app used

### R24-193 — Tactic and outcome: the cancellation flow offers progressively lower prices; it converts some users, but reviewers publish it as a trick they use deliberately, and it establishes that the list price is not the real price — corrosive to the 791 who already object to price and to the 'publish one price' rule

- **Where:** §7.2 #4 / §11.4 #19 — tactic: escalating save-offers in the cancellation flow ($19.99 → $12.99 → $5 → $2/month → 30 days free)
- **This app does:** cancel-flow discount ladder
- **User reaction:** mixed
- **Magnitude:** 5 named reviews; price objection 791 (1.82%, mean 2.248)
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14078552085`, `11068061944`, `11770837150`, `13135059492`, `14162136721`
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

### R24-194 — Tactic and outcome: the app prompts for a review in the first days of use — dozens of 5★ reviews say so ('they asked me to review it now which I find kind of ridiculous'); it inflates first-impression praise, and the highest-voted reviews are all pre-2024 5★s; billing disputes arrive at renewal, so the 5★ band measures onboarding, not tenure

- **Where:** §1.5 / §5.1 — tactic: in-app review prompt on day 1–3
- **This app does:** early review prompt
- **User reaction:** 5★-burst
- **Magnitude:** 5★ band 25,163 (57.89%), median 105 chars; 4 named reviews
- **Direction for us:** dont · **Report confidence:** disclosed bias · **Generalisable:** yes
- **Review IDs:** `13061180549`, `13802373157`, `14003379751`, `12134714782`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R24-195 — Tactic and outcome: a donation-style 'pay what you can' screen ($1 / $10 / ~$16) charges a non-refundable set-up fee on the 'free' trial; outcome is 506 'trial was not free' reviews at mean 1.136 and templated refund refusals quoting the fee clause

- **Where:** §2.2 b / §6.2 (2) — tactic: 'pay what you can' non-refundable set-up fee on the trial
- **This app does:** paid trial framed as donation
- **User reaction:** 1★-burst
- **Magnitude:** 506 (1.16%), mean 1.136; 100 name the fee, mean 1.110
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8078038999`, `11270936086`, `13252486000`, `13614621943`, `14057143520`
- **Canonical:** C109 A free trial must be a real trial

## Insights (the why)

### R24-005 — The product is genuinely well-liked and that has changed less than the rating: coaching/motivation praised (mean 4.483), 'life-changing' (mean 4.799, 88.7% 5★), art/design praised (4.089), and the small-steps pacing — the refusal to let users over-commit — is the highest-rated theme of any size in the corpus (4.692)

- **Where:** Executive summary #3 — the product itself is genuinely well-liked; small-steps pacing is the highest-rated theme of any size
- **This app does:** gentle, constrained coaching pacing
- **User reaction:** praise
- **Magnitude:** coaching 6,095 (14.02%, mean 4.483); life-changing 4,468 (10.28%, mean 4.799, 88.7% 5★); design 2,969 (6.83%, 4.089); small steps 1,817 (4.18%, mean 4.692)
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `1948880555`, `5325209035`, `6021355606`, `6785291083`, `7190336108`, `7658661973`, `8179896888`, `9471116676`, `11494466523`
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R24-006 — The 1★ and 5★ populations are talking about different things — 1★ about billing (scam language 32.2%, refund 15.4%, charged-after-cancel 14.9%, cannot-cancel 10.2%), 5★ about the product (coaching 18.2%, life-changing 15.8%, routine-built 10.6%, design 7.2%); the tiny 2–3★ band is the only one where product criticism dominates, led by confusing navigation and cluttered UI — the billing problem masks a separate, smaller, genuine UX problem, and fixing one will not fix the other

- **Where:** Executive summary #4 — the 1★ and 5★ populations are not arguing about the same product; the small 2–3★ band is led by navigation and clutter
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2–3★ band 3,292 (7.58%)
- **Direction for us:** must-have · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C159 Launch-to-core-action path with no interstitials

### R24-036 — Three consequences follow mechanically from web billing and all appear in the corpus: (i) the subscription is invisible where iOS users are trained to look, so people believe they have none; (ii) cancelling in the App Store does nothing, so people who did cancel are charged anyway; (iii) Apple cannot refund a charge it never processed, so the user is routed to a web form with a 250-character limit and no telephone number — why the theme's mean (1.110) is lower than any product theme

- **Where:** §2.2 Why this is the root cause — three mechanical consequences: invisible where iOS users look; App Store cancel does nothing; Apple cannot refund, user routed to a 250-character web form with no phone
- **This app does:** off-Apple billing
- **User reaction:** 1★-burst
- **Magnitude:** bill_core mean 1.110
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `12932307919`, `14396308469`, `13029061238`, `14372809998`, `13130540330`, `14079270691`, `12684356794`, `13473184526`
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-041 — Coaching / motivation / gentle tone praised — the largest theme

- **Where:** §3.1 theme table #1 Coaching / motivation / gentle tone
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 6,095 (14.02%, high-priority), mean 4.483, 1★ 5.7%, 5★ 75.1%
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R24-042 — 'Life-changing / best app'

- **Where:** §3.1 theme table #2 Life-changing / best app
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 4,468 (10.28%, high-priority), mean 4.799, 1★ 1.8%, 5★ 88.7%
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R24-043 — A routine or habit was actually built

- **Where:** §3.1 theme table #3 Routine or habit actually built
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 3,611 (8.31%, high-priority), mean 4.467, 1★ 5.4%, 5★ 73.7%
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C118 Preset routines / templates / programs

### R24-046 — Small-steps pacing — the app won't let you over-commit

- **Where:** §3.1 theme table #6 Small-steps pacing / won't let you over-commit
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 1,817 (4.18%, very strong), mean 4.692, 1★ 2.0%, 5★ 81.1%
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R24-083 — Reviews invoking Apple or Editor's Choice have mean 1.085 (95.7% 1★) — 'Apple should not feature this'

- **Where:** §3.1 #51 Apple / Editor's Choice invoked — mean 1.085, 95.7% 1★
- **This app does:** featured by Apple
- **User reaction:** churn
- **Magnitude:** 47 (0.11%, weak), mean 1.085
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C134 Lead the store listing with what users actually love

### R24-088 — The single most important number in the report: reviews that mention money at all average 2.006 and reviews that do not average 4.356 — a 2.35-star gap; the money is the problem and the product is not

- **Where:** §3.1 The single most important number — reviews that mention money average 2.006, those that do not 4.356; a 2.35-star gap
- **This app does:** off-Apple subscription billing under a well-liked product
- **User reaction:** mixed
- **Magnitude:** 2.006 vs 4.356; gap 2.35 stars
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R24-092 — The product's real moat is a refusal: the app declines to let users add more habits ('it warns you when trying to add too much'; 'I stacked everything I wanted to change and failed miserably; this time I followed the program') — the highest-rated theme of meaningful size across nine years and many languages

- **Where:** §3.3 The pacing finding is the product's real moat — a refusal to let users add more habits ('it warns you when trying to add too much')
- **This app does:** hard-limited habit stacking with a gated programme
- **User reaction:** praise
- **Magnitude:** 1,817 (4.18%), mean 4.692, 2.0% 1★
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1948880555`, `5325209035`, `6021355606`, `6785291083`, `7190336108`, `7658661973`, `8179896888`, `8501483563`, `9471116676`, `11494466523`
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R24-101 — Requests made predominantly by satisfied, retained users (dark mode 58.1%, per-weekday scheduling 51.6%, calmer home screen 46.1% 4–5★) are retention-preserving features, not complaint triage

- **Where:** §3.4 The 4–5★ share column is the actionable one — dark mode, per-weekday scheduling and a calmer home screen are retention-preserving features, not complaint triage
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 58.1% / 51.6% / 46.1%
- **Direction for us:** do · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency; C080 Colour themes / dark mode; C159 Launch-to-core-action path with no interstitials

### R24-104 — The design bet — the app decides what you work on, refuses to let you add more, and wraps the refusal in narrative and audio — is validated at the top of the distribution: reviewers describe previous failure with self-directed trackers and attribute success to the constraint ('I stacked up everything I wanted to change… and I failed—MISERABLY'; 'it warns you when trying to add too much')

- **Where:** §4.1 The bet: constrain the user, and constrain them gently — validation: previous failure with self-directed trackers, success attributed to the constraint
- **This app does:** app-directed programme, refuses over-commitment
- **User reaction:** praise
- **Magnitude:** 1,817 (4.18%), mean 4.692, 2.0% 1★
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11058749172`, `11300682685`, `8316569117`
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R24-111 — Selling direct rather than through Apple is a design bet: the corpus's largest and lowest-rated theme is a consequence of a commercial architecture decision, not of a feature

- **Where:** §4.4 The fourth bet: sell direct, not through Apple — the largest and lowest-rated theme is a consequence of a commercial architecture decision, not a feature
- **This app does:** off-Apple billing
- **User reaction:** 1★-burst
- **Magnitude:** bill_core 13.32%, mean 1.110
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-114 — 4★ (n=4,601, bill_core 32 = 0.7%) is where product criticism first appears at scale — confusing navigation 6.32%, cluttered 4.04%, crash 2.93%; the modal 4★ review praises the coaching and then asks for a simpler home screen

- **Where:** §5.2 4★ — 'I like it, but': praises coaching then asks for a simpler home screen
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 291 (6.32%); 186 (4.04%); 135 (2.93%)
- **Direction for us:** must-have · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11039550189`, `11189202374`, `12832796136`, `14435637931`, `14110502597`
- **Canonical:** C159 Launch-to-core-action path with no interstitials

### R24-115 — 3★ (n=1,828, bill_core 62 = 3.4%) is the most balanced band: confusing navigation 10.01%, cluttered 8.37%, crash 7.22%, notifications 5.47%, price 4.65%, sister-app ads 2.35% alongside coaching 12.69% and design 10.56%

- **Where:** §5.3 3★ — the most balanced band and most useful for product work
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as listed
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `10992459471`, `11065672263`, `11583598458`, `13047138158`, `14221145502`
- **Canonical:** — (nuance register)

### R24-116 — 2★ (n=1,464, bill_core 180 = 12.3%) is the longest band (286 characters), led by confusing navigation 12.98% and cluttered 12.16% with design praise at 12.02% — the highest design-praise share of any negative band; the characteristic 2★ review is a long, careful account of an app the writer wanted to like

- **Where:** §5.4 2★ — the longest band (286 chars): a long, careful account of an app the writer wanted to like; highest design-praise share of any negative band
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 12.98% / 12.16% / 12.02%
- **Direction for us:** must-have · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11059128795`, `11258492217`, `12206139825`, `13093968640`, `14494360866`
- **Canonical:** C159 Launch-to-core-action path with no interstitials

### R24-119 — Art/design is praised even by detractors — design is not the problem; the money and the clutter are

- **Where:** §5.6 Design is praised even by detractors — it is not the problem
- **This app does:** strong art direction
- **User reaction:** praise
- **Magnitude:** 2,969 (6.83%), mean 4.089; 12.02% of 2★
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C134 Lead the store listing with what users actually love

### R24-129 — The corpus cannot establish intent; what it establishes is that a specific commercial architecture — web checkout outside Apple IAP, bundled trials created during onboarding, and a support channel that cannot process exceptions — mechanically produces all eight complaint shapes; the 5,791 reviews are one architecture observed from eight angles

- **Where:** §6.2 Interpretation — the 5,791 reviews are one architecture observed from eight angles, not eight separate problems
- **This app does:** off-Apple billing architecture
- **User reaction:** 1★-burst
- **Magnitude:** 5,791 (13.32%)
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-133 — Two non-exclusive readings the corpus cannot settle: the aggressive web-checkout funnel is deployed primarily against English-language and European advertising audiences, or price sensitivity in USD/GBP/EUR markets makes the same charge more consequential; what is ruled out is a classifier artefact — Brazilian ratings are 0.5 stars above the corpus and 1.4 above the UK

- **Where:** §6.5 Interpretation — two readings: the web-checkout funnel targets English-language and European ad audiences, or USD/GBP/EUR price sensitivity; 'classifier can't read Portuguese' is ruled out by ratings
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** br 4.266 vs gb 3.368
- **Direction for us:** research · **Report confidence:** interpretation · **Generalisable:** unknown
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R24-134 — The science framing (736, mean 3.865) is the theme most often inverted by detractors: Duke University, Dan Ariely and behavioural science are cited approvingly by satisfied users and thrown back by dissatisfied ones — the Duke affiliation is challenged ('no longer related to Duke… their office is in Europe'), the founder is invoked against the app ('discredited for falsifying results… I no longer trust this app to be evidence based'), and the framing is read as the mechanism ('uses behavioural science to get you to subscribe'); a genuine acquisition asset (1.77% of 5★) that becomes a liability the moment trust breaks because it raises the expected standard of conduct

- **Where:** §6.6 The credibility claims turn hostile — Duke / Dan Ariely / behavioural science cited approvingly then thrown back ('uses behavioural science to get you to subscribe')
- **This app does:** science/university credibility framing
- **User reaction:** mixed
- **Magnitude:** 736 (1.69%); 12 name Dan Ariely, split by era
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `3498932930`, `9654134632`, `2081835457`, `3383670737`, `11960317431`, `11142144586`, `14506251739`, `11036419330`
- **Canonical:** C195 Premium pricing on a trust-based personal brand spends the brand

### R24-136 — The modal conversion story: the trial produced a result in days ('In three days my mindset really started to change… so I went ahead and kept my subscription')

- **Where:** §7.2 #1 The trial produced a result in days — the modal conversion story
- **This app does:** content-led trial
- **User reaction:** purchase-driver
- **Magnitude:** 2 named reviews
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11480619063`, `10987632061`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R24-137 — Users who had failed with self-directed trackers convert specifically because the app refused to let them over-commit

- **Where:** §7.2 #2 The pacing removed a prior failure — converts because the app refused to let them over-commit
- **This app does:** gated pacing
- **User reaction:** purchase-driver
- **Magnitude:** 3 named reviews
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11058749172`, `11298347895`, `11535313577`
- **Canonical:** C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R24-140 — Among paying 4–5★ reviewers the value statements are, in order: the three daily coaching pieces; the deep-work ritual; the meditations; the art and audio; and the fact that missing a day is not punished

- **Where:** §7.3 What buyers value once paid — three daily coaching pieces, deep-work ritual, meditations, art and audio, and that missing a day is not punished
- **This app does:** content and forgiveness
- **User reaction:** praise
- **Magnitude:** 5 representative reviews
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11842141822`, `8224377882`, `13523105037`, `14038035383`, `13490840884`
- **Canonical:** C066 Focus timer; C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R24-145 — A visible minority report fast, effective refunds, sometimes upgrading their review in place (1★ → 4★ after refund) — the refund path works when it is reached; the failure is reaching it

- **Where:** §7.5 Partially offsetting — a visible minority report fast, effective refunds and upgrade their review in place (1★ → 4★); the refund path works when reached, the failure is reaching it
- **This app does:** refunds work when the request lands
- **User reaction:** praise
- **Magnitude:** 6 named among 1,412 edited
- **Direction for us:** must-have · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `12610947103`, `13811397692`, `14482279671`, `14034408044`, `12254880059`, `14220122715`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R24-163 — The habit-coaching thesis is validated — 4,468 reviews (10.28%, mean 4.799) say this category of product changed their life; demand is not the question

- **Where:** Part 10 #1 — the habit-coaching thesis is validated; demand is not the question
- **This app does:** guided coaching
- **User reaction:** praise
- **Magnitude:** 4,468 (10.28%), mean 4.799
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

## Audiences

### R24-007 — The app is marketed to ADHD users and ADHD users are its angriest segment (mean 2.747 vs 3.751; 54.2% 1–2★); within it 201 reviews (mean 1.159) explicitly accuse the app of exploiting the condition it advertises to — 'they know because of your poor executive function that you won't take the extra effort to find the cancel button'

- **Where:** Executive summary #5 — marketed to ADHD users, who are its angriest segment; 201 accuse it of exploiting the condition it advertises to
- **This app does:** positions on ADHD; cancellation hard to find
- **User reaction:** churn
- **Magnitude:** 933 (2.15%, meaningful), mean 2.747, 54.2% 1–2★ vs 41.2% 4–5★; 201 exploitation accusations, mean 1.159
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `7280196965`, `11706534401`, `11946441313`, `12195847716`, `12369933325`, `12644539764`, `13161684157`, `13458992785`, `13667737208`, `13961791199`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

### R24-051 — Depression / anxiety / PTSD / grief context

- **Where:** §3.1 theme table #11 Depression / anxiety / PTSD / grief
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 1,256 (2.89%, meaningful), mean 3.938, 1★ 19.5%, 5★ 64.6%
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R24-056 — ADHD / autism / executive dysfunction

- **Where:** §3.1 theme table #16 ADHD / autism / executive dysfunction
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 933 (2.15%, meaningful), mean 2.747, 1★ 47.7%, 5★ 35.5%
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R24-072 — A segment objects to occult / new-age / 'cult-like' content (195, mean 2.410); separately, the word 'God' was blocked in the Circles community (14, mean 1.714)

- **Where:** §3.1 #31 Occult / new-age / cult objection; #56 word 'God' blocked in Circles
- **This app does:** spiritual framing; profanity filter blocks 'God'
- **User reaction:** complaint
- **Magnitude:** 195 (0.45%, mean 2.410, 47.7% 1★); 14 (0.03%, mean 1.714)
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C015 Shared / group habits

### R24-081 — Some users find the content a diet-culture / eating-disorder trigger

- **Where:** §3.1 #48 Diet-culture / eating-disorder trigger
- **This app does:** diet-adjacent content
- **User reaction:** complaint
- **Magnitude:** 61 (0.14%, weak), mean 2.918
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C162 Automated suggestions from user text must be safety-filtered; notifications must be crisis-aware

### R24-086 — Clinicians review it (24, mean 4.042) and a few arrive on a therapist's or doctor's recommendation (9, mean 4.111)

- **Where:** §3.1 #55 Reviewer states clinical/professional role; #57 recommended by a therapist or doctor
- **This app does:** clinical recommendation channel
- **User reaction:** praise
- **Magnitude:** 24 (0.06%); 9 (0.02%)
- **Direction for us:** do · **Report confidence:** ignore · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R24-159 — ADHD/neurodivergent self-identification rose 0.20% (E1) → 0.69% → 1.65% → 6.01% (E4) — 30× — while the segment's mean sits well below the corpus (2.747 vs 3.751) and 54.2% is 1–2★; the ADHD positioning worked as acquisition, but that audience arrives into the E4 billing experience and 201 frame it as exploiting the condition — the corpus's sharpest strategic warning: the marketing succeeded and the outcome made it worse

- **Where:** §9.6 Trend 5 — the ADHD segment grows 30× and sours simultaneously [very strong]: 0.20% → 0.69% → 1.65% → 6.01%; 'the marketing succeeded and the outcome made it worse'
- **This app does:** ADHD marketing into a hostile billing flow
- **User reaction:** churn
- **Magnitude:** 0.20% → 6.01% (30×); mean 2.747; 54.2% 1–2★; 201 exploitation claims
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

### R24-166 — The ADHD segment is large, growing 30× across eras and currently unhappy — and unusually articulate about why: over-stimulating interfaces, unskippable animations, and cancellation flows that exploit executive dysfunction; that is a specification handed over for free

- **Where:** Part 10 #4 — the ADHD segment is large, growing 30×, unhappy, and unusually articulate about why: a specification handed over for free
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 6.01% of E4; mean 2.747
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

## Markets and languages

### R24-011 — The billing collapse concentrates in English-language and some European storefronts (Ireland 24.5%, Finland 26.4%, Poland 25.4%, Ukraine 25.0%, UK 19.9%, Australia 19.7%, Canada 18.0%, Netherlands 17.5%, US 15.3%) against Latin America (Brazil 3.00%, Mexico 2.98%, Peru 3.01%, Ecuador 2.47%, Dominican Rep. 3.85%), corroborated by language-neutral ratings (Brazil 4.266, Mexico 4.381, Peru 4.511, Ecuador 4.593 vs UK 3.368, Australia 3.436, Ireland 3.266, Finland 2.361); even in E4 Brazil holds 4.002 at 7.49% billing vs the US's 2.560 at 42.63%

- **Where:** Executive summary #9 — the billing collapse is concentrated in English-language storefronts; Latin America is a different business
- **This app does:** web billing reaches some markets and not others
- **User reaction:** mixed
- **Magnitude:** core-billing rate ie 24.5 · fi 26.4 · pl 25.4 · ua 25.0 · gb 19.9 · au 19.7 · ca 18.0 · nl 17.5 · us 15.3 vs br 3.00 · mx 2.98 · pe 3.01 · ec 2.47 · do 3.85; E4 br 4.002 / 7.49% vs us 2.560 / 42.63%
- **Direction for us:** research · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R24-015 — China mainland is effectively unclassified (only 15.3% of 1,250 reviews contain Latin-script words) but its language-neutral rating is real and worse than the corpus — mean 3.431, 28.6% 1★; China has real dissatisfaction this classifier cannot read

- **Where:** §1.5 The China storefront is effectively unclassified — rating 3.431, 28.6% 1★, worse than corpus
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** n=1,250; mean 3.431; 28.6% 1★; billing 0.24% (artefact)
- **Direction for us:** research · **Report confidence:** limited by method · **Generalisable:** app-specific
- **Canonical:** C027 Localise early — it unlocks revenue

### R24-077 — More languages requested

- **Where:** §3.1 #40 Language / localisation request
- **This app does:** limited localisation
- **User reaction:** complaint
- **Magnitude:** 121 (0.28%, weak), mean 3.380
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R24-132 — Billing concentrates by storefront (language-neutral ratings confirm it): Ireland 3.266 / 24.48%, Finland 2.361 / 26.39%, Poland 3.154 / 25.38%, Ukraine 2.823 / 25.00%, Hong Kong 2.900 / 23.33%, Hungary 3.118 / 23.53%, Romania 3.569 / 22.41%, New Zealand 3.573 / 20.77%, UK 3.368 / 19.85%, Australia 3.436 / 19.67%, Canada 3.575 / 18.01%, Netherlands 3.172 / 17.52%, US 3.753 / 15.31% — versus Peru 4.511 / 3.01%, Ecuador 4.593 / 2.47%, Mexico 4.381 / 2.98%, Brazil 4.266 / 3.00%, Dominican Rep. 4.558 / 3.85%, Saudi Arabia 4.192 / 2.35%; in E4 US 2.560 at 42.63% and UK 2.113 at 47.26% vs Brazil 4.002 at 7.49% and Mexico 4.274 at 5.71%

- **Where:** §6.5 Who is hit and who is not (verbatim table) — Ireland, Finland, Poland, Ukraine, HK, Hungary, Romania, NZ, UK, AU, CA, NL, US vs Peru, Ecuador, Mexico, Brazil, Dominican Rep., Saudi Arabia; holds in E4
- **This app does:** web funnel deployed against English/European ad audiences
- **User reaction:** mixed
- **Magnitude:** Market | n | Mean ★ | bill_core % ; Ireland | 192 | 3.266 | 24.48% ; Finland | 72 | 2.361 | 26.39% ; Poland | 130 | 3.154 | 25.38% ; Ukraine | 96 | 2.823 | 25.00% ; Hong Kong | 60 | 2.900 | 23.33% ; Hungary | 51 | 3.118 | 23.53% ; Romania | 116 | 3.569 | 22.41% ; New Zealand | 260 | 3.573 | 20.77% ; United Kingdom | 3,274 | 3.368 | 19.85% ; Australia | 1,510 | 3.436 | 19.67% ; Canada | 2,215 | 3.575 | 18.01% ; Netherlands | 331 | 3.172 | 17.52% ; United States | 19,877 | 3.753 | 15.31% ; — |  |  | ; Peru | 133 | 4.511 | 3.01% ; Ecuador | 81 | 4.593 | 2.47% ; Mexico | 1,008 | 4.381 | 2.98% ; Brazil | 2,630 | 4.266 | 3.00% ; Dominican Rep. | 104 | 4.558 | 3.85% ; Saudi Arabia | 213 | 4.192 | 2.35%
- **Direction for us:** research · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R24-146 — Per-storefront n, mean, 5★%, 1★% and bill_core% for the 52 storefronts with ≥50 reviews (42,213, 97.11% of the corpus); the remaining 94 hold 1,256 (2.89%) and are reported only in aggregate

- **Where:** §8.1 Eligibility; §8.2 All 52 eligible storefronts table (verbatim) — 52 storefronts ≥50 = 42,213 (97.11%); 94 sub-50 = 1,256 (2.89%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Storefront | Code | n | % of corpus | Mean ★ | %5★ | %1★ | bill_core % ; 1 | United States | us | 19,877 | 45.73% | 3.753 | 58.7% | 24.0% | 15.31% ; 2 | United Kingdom | gb | 3,274 | 7.53% | 3.368 | 48.2% | 33.5% | 19.85% ; 3 | Brazil | br | 2,630 | 6.05% | 4.266 | 74.5% | 14.2% | 3.00% ; 4 | Canada | ca | 2,215 | 5.10% | 3.575 | 51.9% | 27.8% | 18.01% ; 5 | France | fr | 1,550 | 3.57% | 3.985 | 57.9% | 16.6% | 7.03% ; 6 | Australia | au | 1,510 | 3.47% | 3.436 | 48.3% | 30.9% | 19.67% ; 7 | Germany | de | 1,504 | 3.46% | 3.610 | 50.5% | 24.5% | 12.63% ; 8 | China mainland | cn | 1,250 | 2.88% | 3.431 | 47.0% | 28.6% | 0.24% ; 9 | Mexico | mx | 1,008 | 2.32% | 4.381 | 76.4% | 11.2% | 2.98% ; 10 | Spain | es | 620 | 1.43% | 3.790 | 56.0% | 22.4% | 10.32% ; 11 | Chile | cl | 420 | 0.97% | 4.121 | 70.0% | 16.4% | 5.48% ; 12 | Colombia | co | 405 | 0.93% | 4.207 | 71.1% | 14.3% | 6.42% ; 13 | Netherlands | nl | 331 | 0.76% | 3.172 | 37.8% | 35.0% | 17.52% ; 14 | India | in | 319 | 0.73% | 3.887 | 62.7% | 22.3% | 11.29% ; 15 | Argentina | ar | 314 | 0.72% | 4.236 | 71.7% | 13.4% | 5.10% ; 16 | Italy | it | 314 | 0.72% | 3.430 | 45.5% | 27.7% | 7.64% ; 17 | South Africa | za | 264 | 0.61% | 3.534 | 54.2% | 30.7% | 16.29% ; 18 | New Zealand | nz | 260 | 0.60% | 3.573 | 53.5% | 28.8% | 20.77% ; 19 | Switzerland | ch | 239 | 0.55% | 3.728 | 54.4% | 24.3% | 10.88% ; 20 | Belgium | be | 231 | 0.53% | 3.701 | 50.2% | 22.5% | 11.26% ; 21 | Russia | ru | 220 | 0.51% | 3.509 | 44.1% | 20.0% | 3.18% ; 22 | Turkey | tr | 215 | 0.49% | 3.540 | 48.8% | 27.9% | 10.70% ; 23 | Saudi Arabia | sa | 213 | 0.49% | 4.192 | 69.0% | 12.2% | 2.35% ; 24 | Ireland | ie | 192 | 0.44% | 3.266 | 46.9% | 37.5% | 24.48% ; 25 | Sweden | se | 187 | 0.43% | 3.267 | 46.0% | 33.7% | 18.18% ; 26 | Portugal | pt | 167 | 0.38% | 3.527 | 50.9% | 29.9% | 15.57% ; 27 | UAE | ae | 164 | 0.38% | 4.061 | 70.1% | 20.1% | 14.02% ; 28 | Philippines | ph | 147 | 0.34% | 4.088 | 65.3% | 15.0% | 8.16% ; 29 | Austria | at | 138 | 0.32% | 3.819 | 59.4% | 18.8% | 8.70% ; 30 | Peru | pe | 133 | 0.31% | 4.511 | 81.2% | 9.0% | 3.01% ; 31 | Poland | pl | 130 | 0.30% | 3.154 | 45.4% | 37.7% | 25.38% ; 32 | Vietnam | vn | 118 | 0.27% | 4.102 | 68.6% | 15.3% | 9.32% ; 33 | Romania | ro | 116 | 0.27% | 3.569 | 56.9% | 29.3% | 22.41% ; 34 | Norway | no | 112 | 0.26% | 3.446 | 44.6% | 26.8% | 11.61% ; 35 | Malaysia | my | 111 | 0.26% | 4.081 | 64.9% | 17.1% | 9.01% ; 36 | Denmark | dk | 108 | 0.25% | 3.481 | 50.9% | 30.6% | 12.04% ; 37 | DO | do | 104 | 0.24% | 4.558 | 80.8% | 7.7% | 3.85% ; 38 | Israel | il | 104 | 0.24% | 3.683 | 58.7% | 26.9% | 14.42% ; 39 | Ukraine | ua | 96 | 0.22% | 2.823 | 40.6% | 50.0% | 25.00% ; 40 | Czechia | cz | 92 | 0.21% | 3.522 | 55.4% | 32.6% | 19.57% ; 41 | Egypt | eg | 83 | 0.19% | 4.120 | 69.9% | 18.1% | 12.05% ; 42 | Indonesia | id | 83 | 0.19% | 4.325 | 72.3% | 10.8% | 7.23% ; 43 | Singapore | sg | 82 | 0.19% | 3.561 | 53.7% | 28.0% | 9.76% ; 44 | EC | ec | 81 | 0.19% | 4.593 | 84.0% | 7.4% | 2.47% ; 45 | Finland | fi | 72 | 0.17% | 2.361 | 23.6% | 58.3% | 26.39% ; 46 | Japan | jp | 70 | 0.16% | 3.043 | 40.0% | 40.0% | 11.43% ; 47 | Thailand | th | 70 | 0.16% | 4.157 | 67.1% | 12.9% | 7.14% ; 48 | Hong Kong | hk | 60 | 0.14% | 2.900 | 38.3% | 45.0% | 23.33% ; 49 | Nigeria | ng | 54 | 0.12% | 4.593 | 81.5% | 5.6% | 5.56% ; 50 | Greece | gr | 53 | 0.12% | 4.038 | 66.0% | 17.0% | 13.21% ; 51 | CR | cr | 52 | 0.12% | 4.385 | 76.9% | 11.5% | 3.85% ; 52 | Hungary | hu | 51 | 0.12% | 3.118 | 45.1% | 39.2% | 23.53%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R24-147 — Group A (US, UK, Canada, Australia, New Zealand, Ireland = 27,328, 62.87%): every one has a bill_core rate above the corpus average and every one collapses in E4 — US 3.447/11.00% → 4.334/4.15% → 4.246/5.77% → 2.560/42.63%; UK 2.948/15.90% → 3.986/7.92% → 4.022/8.77% → 2.113/47.26%; Canada 3.356/16.67% → 4.060/7.61% → 3.940/10.11% → 2.355/48.20%; Australia 3.394/11.11% → 3.974/7.73% → 3.976/7.19% → 2.226/51.63% — in Australia in 2024–26 more than half of everything written is a billing dispute

- **Where:** §8.3 Group A — the English-language billing crisis: US, UK, CA, AU, NZ, IE = 62.87%; every one above the corpus billing rate and every one collapses in E4 (verbatim era table)
- **This app does:** web billing funnel in English markets
- **User reaction:** 1★-burst
- **Magnitude:** Market | E1 mean / bill | E2 mean / bill | E3 mean / bill | E4 mean / bill ; United States | 3.447 / 11.00% | 4.334 / 4.15% | 4.246 / 5.77% | 2.560 / 42.63% ; United Kingdom | 2.948 / 15.90% | 3.986 / 7.92% | 4.022 / 8.77% | 2.113 / 47.26% ; Canada | 3.356 / 16.67% | 4.060 / 7.61% | 3.940 / 10.11% | 2.355 / 48.20% ; Australia | 3.394 / 11.11% | 3.974 / 7.73% | 3.976 / 7.19% | 2.226 / 51.63%
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R24-148 — Group B (Brazil, Mexico, Chile, Colombia, Argentina, Peru, Ecuador, Dominican Republic, Costa Rica, Saudi Arabia = 5,360, 12.33%): group mean 4.285, market means 4.12–4.59, bill_core 2.35%–6.42%; Brazil is the single best control case — 2,630 reviews, mean 4.266, staying healthy through E4 (4.002, 7.49%) while the US sits at 2.560 / 42.63%; Mexico the same (E4 4.274 / 5.71%) — language-neutral evidence that something about how the product is sold in these markets is materially different

- **Where:** §8.4 Group B — Latin America and the Gulf, where the product is working: br, mx, cl, co, ar, pe, ec, do, cr, sa = 12.33%, group mean 4.285; Brazil the best control case, healthy through E4
- **This app does:** same product, different sales funnel by market
- **User reaction:** praise
- **Magnitude:** n=5,360 (12.33%), mean 4.285; br E4 4.002 / 7.49%; mx E4 4.274 / 5.71%
- **Direction for us:** research · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R24-149 — Continental Europe converges late: France 3.870/3.48% → 4.281/1.83% → 4.384/2.96% → 3.118/22.83%; Germany 3.215/9.23% → 4.200/2.36% → 4.031/5.76% → 2.810/30.60%; Netherlands 3.018/5.36% → 3.677/8.60% → 3.927/7.32% → 2.170/41.00% — France held out longest and best (E3 4.384, the highest era-market figure of any large market) and still fell; the billing change reached non-English markets later and hit them less hard, but it reached them

- **Where:** §8.5 Continental Europe — a middle case now converging (verbatim era table): France held out longest (E3 4.384, highest era-market figure of any large market) and still fell; Netherlands E4 2.170 / 41.00%
- **This app does:** billing change rolled out to non-English markets later
- **User reaction:** churn
- **Magnitude:** Market | E1 | E2 | E3 | E4 ; France | 3.870 / 3.48% | 4.281 / 1.83% | 4.384 / 2.96% | 3.118 / 22.83% ; Germany | 3.215 / 9.23% | 4.200 / 2.36% | 4.031 / 5.76% | 2.810 / 30.60% ; Netherlands | 3.018 / 5.36% | 3.677 / 8.60% | 3.927 / 7.32% | 2.170 / 41.00%
- **Direction for us:** research · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R24-150 — Germany is a distinctive sub-case: design/art praise runs at 19.61% — nearly three times the corpus rate (6.83%) and the highest of any large market — while scam vocabulary runs at 10.97%; German reviewers write about the app's craft more than anyone and the German corpus is the clearest example of the two-population split

- **Where:** §8.5 Germany — design praise at 19.61%, nearly 3× the corpus rate and highest of any large market, alongside scam vocabulary at 10.97%: the clearest two-population split
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=1,504; design 19.61% vs 6.83%; scam 10.97%; mean 3.610
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Canonical:** C027 Localise early — it unlocks revenue

### R24-152 — The 94 sub-50 storefronts (1,256 reviews, 2.89%) are in aggregate better than the corpus — mean 3.980, 19.6% 1★; largest: Taiwan 49, Uruguay 46, Croatia 44, Lithuania 44, Kuwait 40, Bulgaria 39, Korea 39, Slovakia 38, Guatemala 35, Kazakhstan 34; no individual claims made

- **Where:** §8.7 The small-market tail — 94 storefronts, 1,256 reviews (2.89%), mean 3.980, 19.6% 1★, better than the corpus [limited evidence]
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=1,256 (2.89%), mean 3.980, 19.6% 1★
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R24-153 — Varies by country: billing-dispute rate (2.35% Saudi Arabia → 26.39% Finland), mean rating (2.361 Finland → 4.593 Ecuador/Nigeria), design-praise rate (0.68% Brazil → 19.61% Germany, partly a classifier-coverage artefact), language requests (Vietnam, Uzbekistan, Russia, Brazil, Italy); does not vary: the praise vocabulary (small steps, coaching, art, 'life-changing' in every language), the forced-water complaint (English, Spanish, German, French, Portuguese, Arabic) and the clutter complaint wherever the classifier can read

- **Where:** §8.8 What genuinely varies by country (verbatim table) — billing rate, mean rating, design-praise rate (partly classifier artefact), language requests (vn, uz, ru, br, it) vary; praise vocabulary, forced-water complaint (6 languages) and clutter complaint do not
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Varies | Does not vary ; Billing-dispute rate (2.35% Saudi Arabia → 26.39% Finland) | The praise vocabulary — small steps, coaching, art, "life-changing" appear in every language ; Mean rating (2.361 Finland → 4.593 Ecuador/Nigeria) | The forced-water complaint — appears in English, Spanish, German, French, Portuguese, Arabic ; Design-praise rate (0.68% Brazil → 19.61% Germany) — *partly a classifier-coverage artefact* | The clutter complaint — appears wherever the classifier can read the language ; Language requests — concentrated in Vietnam, Uzbekistan, Russia, Brazil, Italy |
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R24-169 — Localise beyond English: the Latin-American storefronts rate 4.12–4.59 with almost no billing friction — a receptive, under-served market

- **Where:** Part 10 #7 — localise beyond English; Latin-American storefronts rate 4.12–4.59 with almost no billing friction — a receptive, under-served market
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 4.12–4.59; bill_core 2.35–6.42%
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

## Dated events and trends

### R24-004 — The billing failure is dated: quarterly core-billing rate 5.4% (2023Q1) → 5.0% (Q2) → 6.6% (Q3) → 12.0% (Q4) → 16.5% (2024Q1) → 33.1% (2024Q4) → 52.3% (2025Q2) → 51.0% (2026Q1) while the mean fell 4.181 → 2.074 — a step change between 2023Q3 and 2024Q1 and a second larger one in 2024Q4; era means E1 3.485 · E2 4.244 · E3 4.205 · E4 2.662

- **Where:** Executive summary #2 — the failure is dated: begins Q4 2023 and never recovers
- **This app does:** billing model changed late 2023
- **User reaction:** 1★-burst
- **Magnitude:** 5.4% → 12.0% → 16.5% → 33.1% → 52.3% → 51.0%; mean 4.181 → 2.074; E4 2.662
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-013 — 1,412 edited reviews (3.25%) — many are visible downgrades added after a later charge, the opposite of report 23's edit-after-fix upgrades

- **Where:** §1.3 is_edited — many are visible downgrades added after a later charge
- **This app does:** renewal charges turn 5★ into 1★ edits
- **User reaction:** churn
- **Magnitude:** 1,412 (3.25%)
- **Direction for us:** must-never-break · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `12823158693`, `13873071118`
- **Canonical:** C029 Billing must be exactly right; C221 A receipt with a working product link after every charge, and a renewal reminder before it

### R24-018 — Per-year n, mean, 5★%, 1★% and bill_core%: a 2019 dip (3.350, 31.4% 1★, billing 10.09%), a 2020–2022 plateau at ~4.23–4.26 with billing ~4–5%, then 2024 3.331 (23.56%) → 2025 2.387 (44.90%) → 2026 2.053 (49.72%, 67.8% 1★)

- **Where:** §1.6 Volume and mean by year table (verbatim) — 2019 dip (3.350, bill_core 10.09%), 2020–22 plateau ~4.23, collapse 2024 3.331 → 2025 2.387 → 2026 2.053
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | % of corpus | Mean | %5★ | %1★ | bill_core % ; 2017 (from 23 Nov) | 104 | 0.24% | 4.327 | 68.3% | 6.7% | 0.00% ; 2018 | 1,451 | 3.34% | 3.800 | 55.8% | 19.5% | 5.86% ; 2019 | 4,023 | 9.25% | 3.350 | 46.7% | 31.4% | 10.09% ; 2020 | 7,807 | 17.96% | 4.229 | 68.0% | 11.8% | 3.92% ; 2021 | 9,652 | 22.20% | 4.256 | 69.3% | 11.5% | 4.29% ; 2022 | 6,649 | 15.30% | 4.234 | 69.3% | 11.9% | 4.93% ; 2023 | 3,146 | 7.24% | 4.145 | 67.3% | 14.2% | 6.68% ; 2024 | 4,049 | 9.31% | 3.331 | 50.1% | 35.8% | 23.56% ; 2025 | 3,893 | 8.96% | 2.387 | 28.5% | 59.4% | 44.90% ; 2026 (to 6 Sep) | 2,695 | 6.20% | 2.053 | 20.4% | 67.8% | 49.72%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R24-019 — Eras chosen from the shape of the data: E1 (Nov 2017–Dec 2019, n=5,578, 12.83%, mean 3.485, bill_core 8.80%), E2 (2020–21, 17,459, 40.16%, 4.244, 4.12%), E3 (2022–23, 9,795, 22.53%, 4.205, 5.49%), E4 (Jan 2024–Sep 2026, 10,637, 24.47%, 2.662, 38.00%)

- **Where:** §1.6 Eras table (verbatim) — E1 Nov 2017–Dec 2019 3.485 / 8.80%; E2 2020–21 4.244 / 4.12%; E3 2022–23 4.205 / 5.49%; E4 Jan 2024–Sep 2026 2.662 / 38.00%
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era | Period | n | % | Mean | bill_core % ; E1 | Nov 2017 – Dec 2019 | 5,578 | 12.83% | 3.485 | 8.80% ; E2 | Jan 2020 – Dec 2021 | 17,459 | 40.16% | 4.244 | 4.12% ; E3 | Jan 2022 – Dec 2023 | 9,795 | 22.53% | 4.205 | 5.49% ; E4 | Jan 2024 – Sep 2026 | 10,637 | 24.47% | 2.662 | 38.00%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R24-070 — 212 reviewers say they escalated to their bank, the BBB, the FTC or legal action

- **Where:** §3.1 #29 Escalated to bank / BBB / FTC / legal
- **This app does:** off-Apple billing disputes escalate outside the store
- **User reaction:** 1★-burst
- **Magnitude:** 212 (0.49%, weak), mean 1.236, 92.5% 1★
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-109 — Clutter complaints rose steadily across all four eras including the two good ones (1.90% → 2.72% → 2.96% → 4.26%) and sister-app advertising rose 0.11% → 0.21% → 0.50% → 2.03% — the interface got busier over time and a material part of what got added was commercial rather than functional

- **Where:** §4.2 Clutter grows independently of billing: 1.90% → 2.72% → 2.96% → 4.26%; sister-app ads 0.11% → 0.21% → 0.50% → 2.03% — what got added was commercial, not functional
- **This app does:** interface accreted commercial surfaces
- **User reaction:** churn
- **Magnitude:** 1.90 → 2.72 → 2.96 → 4.26%; 0.11 → 0.21 → 0.50 → 2.03%
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C127 Never show ads to paying subscribers; C159 Launch-to-core-action path with no interstitials

### R24-128 — Users escalate outside the company: chargebacks, bank blocks, new cards, complaints to the Better Business Bureau, the FTC, a state attorney general or a lawyer

- **Where:** §6.2 (8) The user escalates outside the company — chargeback, bank block, new card, BBB, FTC, state attorney general, lawyer
- **This app does:** disputes leave the store ecosystem
- **User reaction:** 1★-burst
- **Magnitude:** 212 (0.49%, mean 1.236)
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11541415141`, `11945228372`, `12324443572`, `12955266205`, `13338375566`, `13617520821`, `13873014737`, `14112324759`
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-130 — Quarterly bill_core and mean 2023Q1–2026Q3: two step changes, neither gradual — 2023Q3 → Q4 (6.6% → 12.0%, mean 4.192 → 3.743) and 2024Q3 → Q4 (17.7% → 33.1%, 3.613 → 2.988); since 2025Q2 the rate plateaus at roughly half of everything written and the mean near 2.0 (2025Q2 1.919, 71.8% 1★); there is no recovery anywhere in the corpus

- **Where:** §6.3 Quarterly timeline table (verbatim) — two step changes: 2023Q3→Q4 (6.6% → 12.0%, mean 4.192 → 3.743) and 2024Q3→Q4 (17.7% → 33.1%, 3.613 → 2.988); plateau at ~half of everything written since 2025Q2; no recovery
- **This app does:** billing model tightened twice
- **User reaction:** 1★-burst
- **Magnitude:** Quarter | n | Mean ★ | %1★ | bill_core % | scam-language % ; 2023 Q1 | 838 | 4.181 | 12.8% | 5.4% | 2.4% ; 2023 Q2 | 1,047 | 4.293 | 11.4% | 5.0% | 2.3% ; 2023 Q3 | 712 | 4.192 | 12.2% | 6.6% | 3.8% ; 2023 Q4 | 549 | 3.743 | 24.6% | 12.0% | 5.5% ; 2024 Q1 | 765 | 3.531 | 29.0% | 16.5% | 9.2% ; 2024 Q2 | 502 | 3.410 | 31.5% | 19.1% | 12.5% ; 2024 Q3 | 1,221 | 3.613 | 28.7% | 17.7% | 10.6% ; 2024 Q4 | 1,561 | 2.988 | 46.0% | 33.1% | 20.5% ; 2025 Q1 | 1,371 | 2.773 | 50.0% | 37.1% | 23.6% ; 2025 Q2 | 677 | 1.919 | 71.8% | 52.3% | 33.4% ; 2025 Q3 | 801 | 2.327 | 60.8% | 45.1% | 28.8% ; 2025 Q4 | 1,044 | 2.231 | 62.7% | 50.2% | 31.8% ; 2026 Q1 | 1,290 | 2.074 | 67.5% | 51.0% | 36.1% ; 2026 Q2 | 789 | 2.057 | 67.8% | 49.2% | 34.6% ; 2026 Q3 (to 6 Sep) | 616 | 2.005 | 68.3% | 47.7% | 32.1%
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-131 — A first billing crisis resolved: monthly bill_core rose from 0.0% (Jun–Jul 2018) to 20.2% (Nov 2018), ran 7–15% through 2019 with the mean bottoming at 2.854 (May) and 2.884 (Nov), then in Dec 2019 snapped back to 2.6% / mean 4.206 and stayed for four years; the discontinuity coincides with a volume step (268 → 606 → 893) — why is an open question (pricing/billing change vs start of in-app review solicitation); it establishes the failure mode has been recoverable before — the company solved this once

- **Where:** §6.4 An earlier, smaller billing crisis in 2018–2019 that resolved — bill_core 20.2% (Nov 2018), mean 2.854 (May 2019), snaps back Dec 2019 to 2.6% / 4.206 and holds four years
- **This app does:** billing crisis fixed once
- **User reaction:** mixed
- **Magnitude:** Month | n | Mean ★ | bill_core % ; 2018-11 | 119 | 2.958 | 20.2% ; 2019-05 | 316 | 2.854 | 14.9% ; 2019-11 | 268 | 2.884 | 12.7% ; 2019-12 | 606 | 4.206 | 2.6% ; 2020-01 | 893 | 4.234 | 4.1%
- **Direction for us:** do · **Report confidence:** very strong (event) / open (cause) · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C059 Be visibly responsive; fixes bring reviewers back

### R24-155 — Annual mean 4.327 (2017) → 3.800 → 3.350 (2019) → 4.229 → 4.256 (2021) → 4.234 → 4.145 (2023) → 3.331 (2024) → 2.387 (2025) → 2.053 (2026) — the 2024–26 fall is 2.09 stars below the 2021 peak and bill_core tracks it (4.29% → 6.68% → 23.56% → 44.90% → 49.72%); product themes do not — small-steps praise falls only 5.68% → 1.52% and clutter rises only 3.09% → 5.68%

- **Where:** §9.2 Trend 1 — the rating collapse is real, dated, monetisation-driven [very strong]: annual mean 4.327 → 3.800 → 3.350 → 4.229 → 4.256 → 4.234 → 4.145 → 3.331 → 2.387 → 2.053; bill_core 4.29% (2021) → 49.72% (2026); product themes do not track it
- **This app does:** off-Apple billing rollout
- **User reaction:** 1★-burst
- **Magnitude:** 2.09-star fall; bill_core 4.29% → 49.72%
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-156 — 2018–2019 shows the same shape at smaller amplitude (bill_core peak 20.2% Nov 2018, mean bottom 2.854 May 2019) and December 2019 returns to 4.206 / 2.6% for four years — the most useful trend in the report: the failure mode is recoverable

- **Where:** §9.3 Trend 2 — there was an earlier crisis and it was fixed [very strong]: the most useful trend — the failure mode is recoverable
- **This app does:** fixed billing once
- **User reaction:** praise
- **Magnitude:** 20.2% → 2.6%; 2.854 → 4.206
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C059 Be visibly responsive; fixes bring reviewers back

### R24-157 — Clutter complaints rise 1.90% → 2.72% → 2.96% → 4.26% through the good eras too, and confusing navigation behaves the same way — the app has been getting busier for eight years and the complaint is decoupled from billing; fixing billing will not fix this

- **Where:** §9.4 Trend 3 — interface complaints rise steadily and independently [very strong]: clutter through the good eras too; fixing billing will not fix this
- **This app does:** eight years of accretion
- **User reaction:** complaint
- **Magnitude:** 1.90 → 2.72 → 2.96 → 4.26%
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C159 Launch-to-core-action path with no interstitials

### R24-158 — Commercial surfaces inside the product are an E4 phenomenon: sister-app advertising 0.11% → 0.21% → 0.50% → 2.03% (18×); bundle subscriptions 0.30% → 0.06% → 0.17% → 2.62%; AI-generated content complaints 0.00% → 0.00% → 0.00% → 0.60% — the theme does not exist before 2024

- **Where:** §9.5 Trend 4 — commercial surfaces inside the product are an E4 phenomenon [very strong]: sister-app ads 18× E1→E4; bundles 0.30 → 2.62%; AI-content complaints 0 → 0.60% (first instance Jan 2024)
- **This app does:** added ads, bundles and AI content in 2024–26
- **User reaction:** 1★-burst
- **Magnitude:** 18×; 0 → 0.60%
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10840315230`
- **Canonical:** C056 Don't build AI features on demand grounds; C127 Never show ads to paying subscribers; C211 No second, separately-cancelled add-on subscription

### R24-160 — Positive vocabulary held flat or rising through E3 and fell only in E4: life-changing 8.98% → 12.55% → 12.18% → 5.48%; small-steps 3.33% → 5.21% → 4.96% → 2.22%; design 6.35% → 7.47% → 7.46% → 5.45% — the advocates did not drift away gradually; they were displaced in a single era by a different kind of reviewer

- **Where:** §9.7 Trend 6 — the positive vocabulary is thinning [very strong]: life-changing 8.98 → 12.55 → 12.18 → 5.48%; small steps 3.33 → 5.21 → 4.96 → 2.22%; design 6.35 → 7.47 → 7.46 → 5.45% — flat or rising through E3, displaced in a single era
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** as listed
- **Direction for us:** none · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

## Positioning

### R24-001 — Fabulous — Daily Habit Tracker · Morning Routines & ADHD Help (App Store ID 1203637303) — a freemium-subscription coaching app with a limited free tier, premium sold as annual / 3-monthly / 'bimonthly' plans plus a paid 'trial set-up fee' and a bundle covering sister apps (Clarify, Shape, Elixir, Lumière, Lune, Ambiance, Sphere); billing runs substantially outside Apple IAP through the developer's own web checkout — the single fact behind the largest finding

- **Where:** header lines 1-9; §12.4 External sources
- **This app does:** developer of record Fabulous; bundle co.thefabulous.app; extracted 8 Sep 2026; analysis 11 Sep 2026; store rank 24; off-Apple web billing
- **User reaction:** mixed
- **Magnitude:** 43,469 reviews · 146 storefronts · 23 Nov 2017 → 6 Sep 2026; mean 3.751; 5★ 25,163 (57.89%) / 4★ 4,601 (10.58%) / 3★ 1,828 (4.21%) / 2★ 1,464 (3.37%) / 1★ 10,413 (23.96%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R24-059 — Science / research / university framing praised

- **Where:** §3.1 theme table #19 Science / research / university framing
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 736 (1.69%, meaningful), mean 3.865, 1★ 18.6%, 5★ 60.6%
- **Direction for us:** do · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C195 Premium pricing on a trust-based personal brand spends the brand

### R24-102 — Competitors named (rare, 102, 0.23%, almost always as a switching destination inside a negative review): Finch 19 (mean 1.579), Noom 18 (3.833), Duolingo 14 (3.286), Notion 13 (2.077), Stoic 11 (4.000), Way of Life 6 (5.000), Habitica 4 (1.750), Todoist 3 (2.000)

- **Where:** §3.5 Competitors named table (verbatim) — Finch 19 (1.579), Noom 18 (3.833), Duolingo 14 (3.286), Notion 13 (2.077), Stoic 11 (4.000), Way of Life 6 (5.000), Habitica 4 (1.750), Todoist 3 (2.000)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Competitor | n | Mean ★ of the review naming it | Representative IDs ; Finch | 19 | 1.579 | 8615390894, 10009624824, 13673827247, 13827309312 ; Noom | 18 | 3.833 | 5265102784, 7331730434, 7572330191, 8426666167 ; Duolingo | 14 | 3.286 | 7452356609, 11735454398, 11961834216, 11995700791 ; Notion | 13 | 2.077 | 4343478678, 5660073877, 7906240165, 10822765363 ; Stoic | 11 | 4.000 | 5266699257, 7325587887, 10123977762, 14452875038 ; Way of Life | 6 | 5.000 | 2599238888, 6534980130, 8676496810, 8752308740 ; Habitica | 4 | 1.750 | 6659839724, 7970990328, 8915659990, 14112324759 ; Todoist | 3 | 2.000 | 3216104597, 6883582926, 6944638164
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `8615390894`, `10009624824`, `13673827247`, `13827309312`, `5265102784`, `7331730434`, `7572330191`, `8426666167`, `7452356609`, `11735454398`, `11961834216`, `11995700791`, `4343478678`, `5660073877`, `7906240165`, `10822765363`, `5266699257`, `7325587887`, `10123977762`, `14452875038`, `2599238888`, `6534980130`, `8676496810`, `8752308740`, `6659839724`, `7970990328`, `8915659990`, `14112324759`, `3216104597`, `6883582926`, `6944638164`
- **Canonical:** C005 Know which competitors buyers compare against

### R24-103 — Finch is the named alternative in the modern era and it is named in anger (mean 1.579) — the recommendation is explicitly about the business model, not the features ('Finch is much less greedy… they actually care about the people that subscribed'); Noom and Duolingo are comparisons of mechanic (click-through lessons; streak freezes), not alternatives

- **Where:** §3.5 Finch is the named alternative in the modern era and is named in anger — about the business model, not features ('Finch is much less greedy')
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Finch 19, mean 1.579
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12422067440`
- **Canonical:** C005 Know which competitors buyers compare against; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

## Anti-patterns

### R24-008 — The interface is the product's second problem and the opposite of its promise — an app sold as a focus aid for ADHD is itself overstimulating: confusing/unintuitive (mean 2.338) and cluttered/overwhelming (mean 3.068); this grows steadily and independently of billing: 1.90% (E1) → 2.72% (E2) → 2.96% (E3) → 4.26% (E4)

- **Where:** Executive summary #6 — the interface is the second problem and the opposite of what the app promises; grows independently of billing
- **This app does:** busy, gamified, content-heavy UI
- **User reaction:** complaint
- **Magnitude:** confusing 1,507 (3.47%, very strong, mean 2.338); cluttered 1,324 (3.05%, very strong, mean 3.068); 1.90% → 2.72% → 2.96% → 4.26%
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1980329123`, `5654554957`, `6670783764`, `7280199018`, `8449184231`, `9617541402`, `11583598458`, `12674646598`, `13654261115`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C159 Launch-to-core-action path with no interstitials

### R24-032 — Nine sister apps each need their own download and their own subscription; named in corpus: Sphere 88 (mean 2.989), Clarify 80 (mean 1.637), Shape 54 (3.593), Ambiance 14 (4.071), Elixir 9, Lumière 8, Lune 4 (1.000), Enchant 1 — Clarify, the ADHD-targeted sister app, is named almost exclusively inside billing complaints

- **Where:** §2.1 Sister apps — Clarify, Shape, Elixir, Lumière, Lune, Ambiance, Sphere, Mind, Enchant — each its own download and its own subscription; Clarify named almost only inside billing complaints
- **This app does:** app family with separate subscriptions
- **User reaction:** complaint
- **Magnitude:** Sphere 88 · Clarify 80 (1.637) · Shape 54 · Ambiance 14 · Elixir 9 · Lumière 8 · Lune 4 (1.000) · Enchant 1
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11592429998`, `11879138719`, `14404089964`
- **Canonical:** C060 Cross-sell an app family on brand trust; C211 No second, separately-cancelled add-on subscription

### R24-049 — Confusing / unintuitive navigation

- **Where:** §3.1 theme table #9 Confusing / unintuitive navigation
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 1,507 (3.47%, very strong), mean 2.338, 1★ 46.2%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C159 Launch-to-core-action path with no interstitials

### R24-050 — Cluttered / overwhelming / overstimulating UI

- **Where:** §3.1 theme table #10 Cluttered / overwhelming / overstimulating
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 1,324 (3.05%, very strong), mean 3.068, 1★ 28.9%, 5★ 32.0%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C159 Launch-to-core-action path with no interstitials

### R24-066 — Childish / condescending tone

- **Where:** §3.1 theme table #26 Childish / condescending tone
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 304 (0.70%, emerging), mean 2.701, 1★ 40.5%
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C095 Neutral, non-judgemental tone on failure

### R24-073 — Pop-ups / unskippable steps (182, mean 2.082), cannot customise / too rigid (175, mean 2.097) and too slow / shallow content (168, mean 2.393) are the worst substantial non-billing UX themes after sister-app ads

- **Where:** §3.1 #32 Pop-ups / unskippable steps; #33 cannot customise / too rigid; #34 too slow / shallow content
- **This app does:** rigid, interruptive programme
- **User reaction:** complaint
- **Magnitude:** 182 (0.42%); 175 (0.40%); 168 (0.39%)
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C160 Honour what onboarding asks — a declared limitation must change the suggestions

### R24-090 — The worst non-billing theme is AI-generated content (n=64, mean 1.156) but it is small, recent and co-occurs with billing; the worst substantial non-billing themes are sister-app ads (308, 1.932), pop-ups (182, 2.082), no customisation (175, 2.097) and confusing navigation (1,507, 2.338)

- **Where:** §3.2 The worst non-billing themes — AI-generated content (64, 1.156, co-occurs with billing); sister-app ads 1.932; pop-ups 2.082; no customisation 2.097; confusing navigation 2.338
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** as listed
- **Direction for us:** must-have · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C127 Never show ads to paying subscribers; C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C159 Launch-to-core-action path with no interstitials; C160 Honour what onboarding asks — a declared limitation must change the suggestions

### R24-105 — The same constraint produces four complaint shapes: 'I already do this' (forced water/breakfast, 124, mean 2.452); 'it ignored my answers' (no customisation, 175, 2.097); 'too slow / too shallow' (168, 2.393); 'it doesn't fit my week' (no per-day schedule, 31, 3.484) — a long onboarding questionnaire produces an identical plan for everyone ('You will answer a ton of questions… and then the app will not take any of your answers into account'; 'I told it I drink water all day. The first habit I'm to build is drinking three glasses of water')

- **Where:** §4.1 Rejection — four complaint shapes table (verbatim): 'I already do this' 124; 'it ignored my answers' 175; 'too slow / shallow' 168; 'doesn't fit my week' 31
- **This app does:** detailed questionnaire, identical plan
- **User reaction:** complaint
- **Magnitude:** Shape | Theme | n | Mean ★ ; "I already do this" | ux_forced_water_breakfast | 124 | 2.452 ; "It ignored my answers" | ux_no_customization | 175 | 2.097 ; "It's too slow / too shallow" | ux_slow_pacing_shallow | 168 | 2.393 ; "It doesn't fit my week" | ux_no_per_day_schedule | 31 | 3.484
- **Direction for us:** product-rule · **Report confidence:** weak individually, consistent · **Generalisable:** yes
- **Review IDs:** `11727320977`, `11787845786`, `14173187184`
- **Canonical:** C160 Honour what onboarding asks — a declared limitation must change the suggestions; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R24-108 — The against-case has a specific, repeated, damaging form: an app marketed as an ADHD and focus aid is described as itself overstimulating — close to a stock sentence ('This app literally GIVES me adhd'; 'an ADHD nightmare to set up'; 'For someone with severe ADHD this app is completely useless')

- **Where:** §4.2 An app marketed as an ADHD and focus aid is described as itself overstimulating — a stock sentence ('This app literally GIVES me adhd')
- **This app does:** overstimulating UI sold as a focus aid
- **User reaction:** churn
- **Magnitude:** 4 named reviews; cluttered 1,324 (3.05%)
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11778963777`, `11436147013`, `13600052281`, `13656613592`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C159 Launch-to-core-action path with no interstitials

### R24-110 — From ~2022 the product became a family of apps (Clarify, Shape, Elixir, Lumière, Lune, Ambiance, Sphere, Mind) and reviewers experience it two ways, both negative: as advertising inside a product they already pay for ('I'm on the purchased version… I don't want to see adds'; 'please consider removing ads and upsells for paying members!!') and as a billing trap — near-identical offer screens during onboarding each enrolling a separate subscription that must later be cancelled separately

- **Where:** §4.3 The third bet: an ecosystem of separate apps — experienced as advertising inside a paid product (14.6% 4–5★, lowest of any UX theme) and as a billing trap
- **This app does:** app-family cross-sell with separate subscriptions
- **User reaction:** 1★-burst
- **Magnitude:** ads 308 (0.71%, mean 1.932, 14.6% 4–5★); bundle 324 (0.75%, mean 1.398); both E4: 0.30 → 0.06 → 0.17 → 2.62%; 0.11 → 0.21 → 0.50 → 2.03%
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11143130693`, `11960208395`
- **Canonical:** C060 Cross-sell an app family on brand trust; C127 Never show ads to paying subscribers; C211 No second, separately-cancelled add-on subscription

### R24-121 — Acquisition happens off-store: a large share arrive from an Instagram / Facebook / X ad, take a questionnaire in a web browser, and enter payment details before ever opening the app

- **Where:** §6.2 (1) Acquisition happens off-store — social ad → web questionnaire → payment details before ever opening the app
- **This app does:** paid social → web funnel → card before install
- **User reaction:** 1★-burst
- **Magnitude:** 6 representative reviews
- **Direction for us:** dont · **Report confidence:** high-priority (chain) · **Generalisable:** yes
- **Review IDs:** `8427785341`, `11036419330`, `12195952808`, `13430547332`, `14496026279`, `13631053622`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C111 No long quiz before the price; show the price up front

### R24-139 — The cancellation flow offers progressively lower prices — $19.99, $12.99, $5, $2/month, 30 days free — and reviewers document it as a tactic they use deliberately ('keep opting for cancel, you'll eventually get an offer for $5/month'); it converts some but publicly establishes that the list price is not the real price, corrosive to the 791 (1.82%) who already object to price

- **Where:** §7.2 #4 Price anchoring during cancellation — the cancel flow offers $19.99 → $12.99 → $5 → $2/month → 30 days free; reviewers document it as a tactic they use deliberately
- **This app does:** escalating save-offers on cancel
- **User reaction:** mixed
- **Magnitude:** 5 named reviews; price objection 791 (1.82%)
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14078552085`, `11068061944`, `11770837150`, `13135059492`, `14162136721`
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

## Things not to do

### R24-009 — In-app advertising of the developer's own sister apps is a paid-subscriber grievance (mean 1.932) and being subscribed to a bundle one did not knowingly buy is worse (mean 1.398); both are essentially absent before 2022 and concentrate in E4 — sister-app ads 0.11% → 0.21% → 0.50% → 2.03%; bundle complaints 0.30% → 0.06% → 0.17% → 2.62%

- **Where:** Executive summary #7 — in-app advertising of sister apps is a paid-subscriber grievance, and it is new; bundle subscriptions not knowingly bought
- **This app does:** upsells sister apps inside a paid app; sells a multi-app bundle at onboarding
- **User reaction:** 1★-burst
- **Magnitude:** ads 308 (0.71%, emerging, mean 1.932); bundle 324 (0.75%, mean 1.398); E4 2.03% and 2.62%
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11624316237`, `12183418883`, `12699901526`, `13133491407`, `13457132791`, `13940867104`, `12238712030`, `12420478007`, `13272341928`, `13584041512`, `14087096771`
- **Canonical:** C060 Cross-sell an app family on brand trust; C127 Never show ads to paying subscribers; C211 No second, separately-cancelled add-on subscription

### R24-039 — Users are enrolled in a multi-app bundle during onboarding without an explicit priced confirmation — a sequence of near-identical full-screen offers where the decline control is a small 'skip'/'X' in a corner

- **Where:** §2.2 f — the bundle: enrolled in a multi-app bundle during onboarding via near-identical full-screen offers whose decline is a small skip/X in a corner
- **This app does:** bundle upsell in onboarding with hidden decline
- **User reaction:** 1★-burst
- **Magnitude:** 324 (0.75%, emerging), mean 1.398, 83.6% 1★
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12238712030`, `12420478007`, `12901184992`, `13272341928`, `13584041512`, `13744387263`, `14087096771`, `14420525318`
- **Canonical:** C211 No second, separately-cancelled add-on subscription

### R24-065 — In-app advertising of sister apps

- **Where:** §3.1 theme table #25 In-app advertising of sister apps
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 308 (0.71%, emerging), mean 1.932, 1★ 57.8%
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C127 Never show ads to paying subscribers

### R24-075 — Referral / share-with-friend prompts drew 131 mentions (mean 3.053)

- **Where:** §3.1 #36 Referral / share-with-friend prompts
- **This app does:** referral prompts
- **User reaction:** mixed
- **Magnitude:** 131 (0.30%, weak), mean 3.053
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R24-084 — Onboarding too long

- **Where:** §3.1 #52 Onboarding too long — mean 1.600
- **This app does:** long questionnaire onboarding
- **User reaction:** complaint
- **Magnitude:** 45 (0.10%, weak), mean 1.600, 73.3% 1★
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C111 No long quiz before the price; show the price up front

### R24-144 — Refund refusal language is near-verbatim across years and markets — 'in line with our T&Cs, the set-up fee for the trial period is non-refundable' and 'the renewal date was displayed at the time of signing up… unless cancelled at least 24 hours before the renewal date'

- **Where:** §7.5 Refunds and billing support — refusal language near-verbatim across years: 'set-up fee for the trial period is non-refundable'; 'unless cancelled at least 24 hours before the renewal date'
- **This app does:** templated refusals citing T&Cs
- **User reaction:** 1★-burst
- **Magnitude:** refund mentioned 1,737 (4.00%, 1.163); refused 968 (2.23%, 1.070); support 947 (2.18%, 1.528); escalated 212 (0.49%, 1.236)
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11270936086`, `12321421246`, `13653522994`, `13753645415`, `14350750065`, `14013765356`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R24-167 — Do not put advertising inside a paid product — sister-app ads have the lowest satisfied-share (14.6% at 4–5★) of any UX theme

- **Where:** Part 10 #5 — do not put advertising inside a paid product (14.6% satisfied-share, lowest of any UX theme)
- **This app does:** ads in paid tier
- **User reaction:** complaint
- **Magnitude:** 308, mean 1.932, 14.6% 4–5★
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C127 Never show ads to paying subscribers

### R24-170 — Beware the credibility trade: university and named-researcher endorsements are strong acquisition assets (1.77% of 5★) that convert into weapons the moment a billing dispute starts

- **Where:** Part 10 #8 — beware the credibility trade: university and named-researcher endorsements convert into weapons the moment a billing dispute starts
- **This app does:** science framing
- **User reaction:** mixed
- **Magnitude:** 736; 1.77% of 5★
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C195 Premium pricing on a trust-based personal brand spends the brand

### R24-178 — Remove sister-app promotion from paid accounts entirely — 308 reviews, mean 1.932, only 14.6% satisfied

- **Where:** §11.2 Part 11 #8 — remove sister-app promotion from paid accounts entirely [emerging, worst-rated UX theme]
- **This app does:** ads in paid tier
- **User reaction:** complaint
- **Magnitude:** 308, 1.932, 14.6%
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C127 Never show ads to paying subscribers

## Things to do

### R24-012 — Cheapest unshipped wins in evidence order: move subscription billing into Apple IAP (or make web billing visible and cancellable in one step) → stop selling bundles during onboarding without an explicit priced confirmation → honour cancellations already confirmed by e-mail → remove sister-app advertising from paid accounts → let users skip or replace the first habit → a low-stimulus 'just my routine' home screen → per-weekday and shift-work scheduling → let users backfill a missed day

- **Where:** Executive summary #10 — cheapest unshipped wins in evidence order
- **This app does:** none shipped as of Sep 2026
- **User reaction:** complaint
- **Magnitude:** report gives none (ranked list)
- **Direction for us:** do · **Report confidence:** summary ranking · **Generalisable:** yes
- **Canonical:** C010 Backfill missed days / edit start date; C043 Flexible / custom frequency; C127 Never show ads to paying subscribers; C159 Launch-to-core-action path with no interstitials; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel; C211 No second, separately-cancelled add-on subscription; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R24-138 — Credibility signals convert: Duke/Stanford/behavioural-science framing and Atomic Habits adjacency

- **Where:** §7.2 #3 Credibility signals — Duke/Stanford/behavioural-science framing and Atomic Habits adjacency
- **This app does:** university and science framing
- **User reaction:** purchase-driver
- **Magnitude:** 4 named reviews
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10985171233`, `11518618204`, `11545357324`, `12975776937`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C070 Use the language users use: Atomic Habits, 75 Hard; C195 Premium pricing on a trust-based personal brand spends the brand

### R24-168 — Ship the cheap things this corpus asks for and Fabulous has not: dark mode (58.1% of requesters 4–5★), per-weekday and shift-work schedules (51.6%), backfill a missed day, save/re-listen to a coaching piece, an iPad build, and declaring a habit already-held

- **Where:** Part 10 #6 — ship the cheap things this corpus asks for: dark mode, per-weekday/shift schedules, backfill, save/re-listen coaching, iPad, declare a habit already-held
- **This app does:** none shipped
- **User reaction:** complaint
- **Magnitude:** as listed
- **Direction for us:** do · **Report confidence:** weak individually · **Generalisable:** yes
- **Canonical:** C010 Backfill missed days / edit start date; C043 Flexible / custom frequency; C080 Colour themes / dark mode; C141 Native iPad layout; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional; C233 Content the user paid for is saveable and replayable — a library, not a stream

### R24-190 — Re-examine what changed in the Latin-American funnel — those markets carry the same product at 4.0–4.6 stars with a fraction of the billing friction; whatever is different there is the model

- **Where:** §11.4 Part 11 #20 — re-examine what changed in the Latin-American funnel: same product at 4.0–4.6 stars with a fraction of the billing friction — whatever is different there is the model [very strong]
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 4.0–4.6 vs 2.1–2.6
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R24-191 — Experiments: move one English storefront to Apple IAP and measure the 1★ rate against a matched control; A/B the low-stimulus home screen on new installs measuring day-7 and day-30 retention; add 'I already do this' to the first habit and measure completion of habit two; send a renewal reminder 7 days ahead in one market and measure refund requests and 1★ rate

- **Where:** §11.5 Experiments — move one English storefront to Apple IAP; A/B low-stimulus home screen on day-7/day-30 retention; 'I already do this' on the first habit; 7-day renewal reminder in one market
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (experiments)
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** — (nuance register)

## Contradictions

### R24-107 — The app is an animated, narrated, colour-saturated world rather than a checklist, and the corpus splits measurably: for — design 2,969 (mean 4.089), music/audio 282 (4.387); against — cluttered/overwhelming 1,324 (3.068), pop-ups 182 (2.082), childish/condescending 304 (2.701)

- **Where:** §4.2 The second bet: make the interface an experience — for (design 4.089, music 4.387) vs against (cluttered 3.068, pop-ups 2.082, childish 2.701)
- **This app does:** experiential, animated UI
- **User reaction:** mixed
- **Magnitude:** for 2,969 + 282 vs against 1,324 + 182 + 304
- **Direction for us:** undecided · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C159 Launch-to-core-action path with no interstitials

## Data caveats and method

### R24-002 — Method: 43,469/43,469 read in full in 260 batches, country-then-date order, coverage verified programmatically (0 missing, 0 extra); 57-theme multilingual regex classifier with five disclosed corrections before use (religious objection 901→195 because 'cult' matched 'difficult'; ADHD 1,569→933 because 'add' matched the verb; coaching 6,433→6,095 because 'kind' matched 'kind of'; repetitive content 285→103 because 'repeat' matched 'charged repeatedly'; religion-censorship rebuilt 2→14); residual false-positive tail in scam language (10 of 3,468 about art plagiarism); 1,435 of 3,468 scam-language reviews carry no other billing theme but are one-line billing complaints (mean 1.107); two composites — bill_core (9 dispute themes) and bill_any (adds refund, support failure, price, bundle); corpus is bimodal (57.89% 5★, 23.96% 1★, 7.58% middle) and back-weighted (2024–26 = 24.47% at mean 2.662 vs 2020–21 = 40.16% at 4.244); theme rates under-count in zh/ja/ko/th/ru/he/ar — China mainland only 15.3% Latin-script so its billing rate 0.24% is an artefact (its rating 3.431, 28.6% 1★ is real); 'scam' is a word not a legal finding; no version field; review-selection bias runs both ways — in-app review prompt on day 1–3 inflates early praise, billing disputes arrive at renewal months later; not every reviewer is a payer (11,200, 25.77% discuss the transaction); storefront ≠ nationality ≠ language; prices are testimony in mixed currencies; no download/revenue/retention/refund-outcome data

- **Where:** How to read this; Seven warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations; §12.1 counting rules; §12.3 validation; §12.5 Reproduction; §12.6 Completion checklist; §12.7 one-paragraph version
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 43,469/43,469; 146 storefronts; 0 empty bodies/titles; 9,582,733 characters; 99 duplicate groups (338 records) kept; is_edited 1,412 (3.25%, many visible downgrades after a later charge); 3,197 (7.35%) with votes
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `13061180549`, `13802373157`, `14003379751`, `2049293486`, `5090340749`, `12823158693`, `13873071118`
- **Canonical:** — (nuance register)

### R24-014 — 41.4% of scam-language reviews are one-word or one-line billing complaints ('Scam', 'Fraud', 'Thieves') with no other theme — consistent with the billing population; a 0.29% false-positive tail is about art plagiarism (Monument Valley comparisons)

- **Where:** §1.4 #5 Disclosed residual error — 1,435 of 3,468 scam-language reviews carry no other billing theme, one-line 'Scam' at mean 1.107
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1,435 of 3,468 (41.4%), mean 1.107; 10 (0.29%) false positives
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `2049293486`, `5090340749`
- **Canonical:** — (nuance register)

### R24-016 — Fabulous solicits reviews in-app during the first days of use — dozens of 5★ reviews say so ('they asked me to review it now which I find kind of ridiculous') — while billing complaints arrive at renewal months or years later; the two samples are drawn at different lifecycle points

- **Where:** §1.5 Review-selection bias — in-app review prompt on day 1–3 ('they asked me to review it now which I find kind of ridiculous')
- **This app does:** early in-app review prompt
- **User reaction:** 5★-burst
- **Magnitude:** dozens of 5★ say so explicitly
- **Direction for us:** dont · **Report confidence:** disclosed bias · **Generalisable:** yes
- **Review IDs:** `14003379751`, `13061180549`, `13802373157`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R24-017 — Rating distribution is U-shaped: the two extremes hold 81.85% of reviews and the 2–3★ middle 7.58%

- **Where:** §1.6 Ratings table (verbatim) — U-shaped: extremes hold 81.85%, middle 7.58%
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Rating | n | % ; 5★ | 25,163 | 57.89% ; 4★ | 4,601 | 10.58% ; 3★ | 1,828 | 4.21% ; 2★ | 1,464 | 3.37% ; 1★ | 10,413 | 23.96% ; Mean |  | 3.7508
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R24-020 — The highest-voted reviews (556, 175, 166, 160, 133, 124, 106, 96 votes) are all positive and all pre-2024 — the voting population predates the billing collapse

- **Where:** §1.6 Most-voted reviews — all positive and all pre-2024; the voting population predates the billing collapse
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** top 8 votes 556 → 96
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `7145509593`, `3354419782`, `6061329076`, `4009086528`, `8959985525`, `2188974205`, `6880068846`, `3842317360`
- **Canonical:** — (nuance register)

### R24-021 — Feature inventory from reviewers' own words

- **Where:** §2.1 Feature inventory table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Surface | What reviewers describe | Representative IDs ; Onboarding | Long questionnaire (frequently reached via an Instagram / Facebook / X advert), a "letter from your future self," and a held-finger "contract" signing using the fingerprint sensor | 7608105779, 13641827689, 11036419330, 11785559577 ; Rituals / routines | Morning, afternoon, evening routine checklists with timers and per-habit guided content | 11122189610, 12016141805, 11743843988 ; The first habit | Universally "drink a glass of water on waking," gated 3 days before the next unlocks; then "eat a healthy breakfast," then exercise | 11007332063, 12377235635, 14003383594 ; Journeys / mountains | Multi-week guided programmes rendered as a mountain map with an animated traveller | 11842141822, 13355228633, 13650208449 ; Daily / focus / nightly coaching | Three short narrated audio-plus-text pieces per day, with quotes from named authors and researchers | 11622883414, 11839073307, 12832796136 ; Letters | Written pieces framed as letters, including "from your future self" | 11066361054, 5594181955 ; Challenges | Time-boxed group challenges ("no sugar for a week") | 6543667873, 11305397471 ; Circles | In-app community feed with comments and writing prompts | 11294707285, 11691602301, 11691602301 ; Make Me Fabulous / Launch | An activity launcher (guided meditation, stretching, deep work ritual) — repeatedly reported as removed or unfindable after a redesign | 11842141822, 12337019505, 14506251739 ; Deep work | A long ramp-up ritual for extended focus sessions, named by several long-tenure users as the single reason they renew | 11842141822 ; Ambient sound / music | Background soundscapes and per-task music | 5282944837, 14346117158 ; Mood tracking | Daily mood check-in | 13514681303, 13044004537 ; Streaks / freezes | Streak counters, "freeze" passes, certificates | 12611007165, 14245283579, 13650208449 ; Apple Watch | Present but thin — only 69 reviews (0.16%) mention it at all | 2006599866, 6405204376, 8265107322 ; Widget | Present but thin — 53 reviews (0.12%) | 2095635360, 9515548817, 10519844634 ; AI assistant | A chat/coach bubble appearing from roughly 2025, described as an unwanted addition by long-tenure users | 12846915013, 14262152932, 13581200143 ; Sister apps | Clarify (ADHD), Shape (fitness), Elixir, Lumière, Lune (sleep), Ambiance, Sphere, Mind, Enchant — each its own download and its own subscription | 11592429998, 11879138719, 14404089964
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R24-040 — Master theme table, denominator 43,469

- **Where:** §3.1 Complete ranked theme table (verbatim), 57 themes
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | Group | n | % of 43,469 | Mean ★ | %1★ | %5★ | Signal ; 1 | Coaching / motivation / gentle tone | POSITIVE | 6,095 | 14.02% | 4.483 | 5.7% | 75.1% | high-priority ; 2 | Life-changing / best app | POSITIVE | 4,468 | 10.28% | 4.799 | 1.8% | 88.7% | high-priority ; 3 | Routine or habit actually built | POSITIVE | 3,611 | 8.31% | 4.467 | 5.4% | 73.7% | high-priority ; 4 | Scam / fraud / theft vocabulary | BILLING | 3,468 | 7.98% | 1.073 | 96.6% | 0.9% | high-priority ; 5 | Art / design / graphics | POSITIVE | 2,969 | 6.83% | 4.089 | 11.4% | 61.3% | high-priority ; 6 | Small-steps pacing / won't let you over-commit | POSITIVE | 1,817 | 4.18% | 4.692 | 2.0% | 81.1% | very strong ; 7 | Refund requested or mentioned | BILLING | 1,737 | 4.00% | 1.163 | 92.4% | 1.8% | very strong ; 8 | Charged after cancelling | BILLING | 1,620 | 3.73% | 1.085 | 95.9% | 1.0% | very strong ; 9 | Confusing / unintuitive navigation | UX | 1,507 | 3.47% | 2.338 | 46.2% | 9.8% | very strong ; 10 | Cluttered / overwhelming / overstimulating | UX | 1,324 | 3.05% | 3.068 | 28.9% | 32.0% | very strong ; 11 | Depression / anxiety / PTSD / grief | SEGMENT | 1,256 | 2.89% | 3.938 | 19.5% | 64.6% | meaningful ; 12 | Cannot find / complete cancellation | BILLING | 1,146 | 2.64% | 1.115 | 92.3% | 0.3% | meaningful ; 13 | Refund refused | BILLING | 968 | 2.23% | 1.070 | 96.3% | 0.6% | meaningful ; 14 | Support unresponsive / automated only | BILLING | 947 | 2.18% | 1.528 | 80.0% | 8.6% | meaningful ; 15 | Crash / freeze / bug / won't load | UX | 944 | 2.17% | 2.367 | 44.7% | 12.9% | meaningful ; 16 | ADHD / autism / executive dysfunction | SEGMENT | 933 | 2.15% | 2.747 | 47.7% | 35.5% | meaningful ; 17 | Price objection | BILLING | 791 | 1.82% | 2.248 | 53.0% | 15.2% | meaningful ; 18 | Notification volume / control | UX | 744 | 1.71% | 2.437 | 43.7% | 16.9% | meaningful ; 19 | Science / research / university framing | POSITIVE | 736 | 1.69% | 3.865 | 18.6% | 60.6% | meaningful ; 20 | Duplicate / repeated charges | BILLING | 584 | 1.34% | 1.134 | 93.7% | 1.4% | meaningful ; 21 | "Free" trial was not free | BILLING | 506 | 1.16% | 1.136 | 92.9% | 1.4% | meaningful ; 22 | Community / Circles | POSITIVE | 370 | 0.85% | 3.897 | 14.3% | 54.9% | emerging ; 23 | Charge without consent / warning | BILLING | 338 | 0.78% | 1.047 | 97.3% | 0.3% | emerging ; 24 | Bundle / sister-app subscription | BILLING | 324 | 0.75% | 1.398 | 83.6% | 5.6% | emerging ; 25 | In-app advertising of sister apps | UX | 308 | 0.71% | 1.932 | 57.8% | 7.8% | emerging ; 26 | Childish / condescending tone | UX | 304 | 0.70% | 2.701 | 40.5% | 24.3% | emerging ; 27 | Music / audio / narration | POSITIVE | 282 | 0.65% | 4.387 | 4.6% | 69.5% | emerging ; 28 | No iPad / lost progress on device change | UX | 257 | 0.59% | 2.693 | 33.5% | 18.3% | emerging ; 29 | Escalated to bank / BBB / FTC / legal | OTHER | 212 | 0.49% | 1.236 | 92.5% | 3.8% | weak ; 30 | Auto-renewal with no notice | BILLING | 197 | 0.45% | 1.168 | 88.8% | 0.0% | weak ; 31 | Occult / new-age / cult objection | CONTENT | 195 | 0.45% | 2.410 | 47.7% | 17.9% | weak ; 32 | Pop-ups / unskippable steps | UX | 182 | 0.42% | 2.082 | 47.3% | 7.7% | weak ; 33 | Cannot customise / too rigid | UX | 175 | 0.40% | 2.097 | 54.3% | 12.0% | weak ; 34 | Too slow / shallow content | UX | 168 | 0.39% | 2.393 | 45.2% | 17.3% | weak ; 35 | Privacy / personal data | CONTENT | 138 | 0.32% | 1.225 | 87.7% | 1.4% | weak ; 36 | Referral / share-with-friend prompts | CONTENT | 131 | 0.30% | 3.053 | 27.5% | 29.0% | weak ; 37 | Accessibility (vision, font, VoiceOver) | SEGMENT | 129 | 0.30% | 3.101 | 27.1% | 24.8% | weak ; 38 | Not visible in Apple Subscriptions | BILLING | 125 | 0.29% | 1.136 | 91.2% | 0.8% | weak ; 39 | Forced first habit (water / breakfast) | UX | 124 | 0.29% | 2.452 | 46.0% | 20.2% | weak ; 40 | Language / localisation request | OTHER | 121 | 0.28% | 3.380 | 17.4% | 29.8% | weak ; 41 | Repetitive coaching content | CONTENT | 103 | 0.24% | 2.660 | 33.0% | 15.5% | weak ; 42 | Competitor named | OTHER | 102 | 0.23% | 3.020 | 34.3% | 36.3% | weak ; 43 | Cannot log in / paid but no access | UX | 96 | 0.22% | 1.375 | 78.1% | 2.1% | weak ; 44 | Free tier is generous | POSITIVE | 77 | 0.18% | 4.442 | 2.6% | 62.3% | weak ; 45 | Cannot undo or backfill a day | UX | 70 | 0.16% | 2.700 | 32.9% | 12.9% | weak ; 46 | Apple Watch | OTHER | 69 | 0.16% | 3.116 | 26.1% | 26.1% | weak ; 47 | AI-generated art / copy | UX | 64 | 0.15% | 1.156 | 90.6% | 0.0% | weak ; 48 | Diet-culture / ED trigger | CONTENT | 61 | 0.14% | 2.918 | 26.2% | 19.7% | weak ; 49 | Audio overrides silent switch | UX | 56 | 0.13% | 2.036 | 58.9% | 10.7% | weak ; 50 | Widget | OTHER | 53 | 0.12% | 3.868 | 1.9% | 37.7% | weak ; 51 | Apple / Editor's Choice invoked | OTHER | 47 | 0.11% | 1.085 | 95.7% | 0.0% | weak ; 52 | Onboarding too long | UX | 45 | 0.10% | 1.600 | 73.3% | 4.4% | weak ; 53 | No dark mode | UX | 43 | 0.10% | 3.535 | 4.7% | 20.9% | ignore ; 54 | No per-weekday / shift-work schedule | UX | 31 | 0.07% | 3.484 | 9.7% | 22.6% | ignore ; 55 | Reviewer states clinical/professional role | SEGMENT | 24 | 0.06% | 4.042 | 12.5% | 66.7% | ignore ; 56 | Word "God" blocked in Circles | CONTENT | 14 | 0.03% | 1.714 | 50.0% | 0.0% | ignore ; 57 | Recommended by a therapist or doctor | SEGMENT | 9 | 0.02% | 4.111 | 22.2% | 77.8% | ignore
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R24-069 — Weak/ignore rows: escalated to bank/BBB/FTC/legal 212 (0.49%, mean 1.236); auto-renewal with no notice 197 (0.45%, 1.168); occult/new-age/cult objection 195 (0.45%, 2.410); pop-ups/unskippable steps 182 (0.42%, 2.082); cannot customise/too rigid 175 (0.40%, 2.097); too slow/shallow content 168 (0.39%, 2.393); privacy/personal data 138 (0.32%, 1.225); referral/share prompts 131 (0.30%, 3.053); accessibility 129 (0.30%, 3.101); not visible in Apple Subscriptions 125 (0.29%, 1.136); forced first habit 124 (0.29%, 2.452); localisation request 121 (0.28%, 3.380); repetitive coaching 103 (0.24%, 2.660); competitor named 102 (0.23%, 3.020); cannot log in/paid but no access 96 (0.22%, 1.375); free tier generous 77 (0.18%, 4.442); cannot undo/backfill 70 (0.16%, 2.700); Apple Watch 69 (0.16%, 3.116); AI-generated art/copy 64 (0.15%, 1.156); diet-culture/ED trigger 61 (0.14%, 2.918); audio overrides silent switch 56 (0.13%, 2.036); widget 53 (0.12%, 3.868); Apple/Editor's Choice invoked 47 (0.11%, 1.085); onboarding too long 45 (0.10%, 1.600); no dark mode 43 (0.10%, 3.535); no per-weekday schedule 31 (0.07%, 3.484); clinical/professional role 24 (0.06%, 4.042); 'God' blocked in Circles 14 (0.03%, 1.714); recommended by therapist/doctor 9 (0.02%, 4.111)

- **Where:** §3.1 theme table #29–#57 weak/ignore rows
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 29 weak/ignore rows as listed
- **Direction for us:** none · **Report confidence:** weak/ignore · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R24-087 — Composites: bill_core 5,791 (13.32%, mean 1.110, 94.2% 1★); bill_any 6,612 (15.21%, mean 1.201); transaction-aware 11,200 (25.77%, mean 2.006, 65.9% 1★); not transaction-aware 32,269 (74.23%, mean 4.356, 9.4% 1★)

- **Where:** §3.1 Composite measures table (verbatim) — bill_core, bill_any, transaction-aware vs not
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Composite | Definition | n | % | Mean ★ | %1★ ; bill_core | Any of: charged-after-cancel · cannot-cancel · not-in-Apple · refund-refused · scam language · unauthorised charge · duplicate charge · trial-not-free · auto-renew-no-notice | 5,791 | 13.32% | 1.110 | 94.2% ; bill_any | bill_core + refund mention + support failure + price objection + bundle complaint | 6,612 | 15.21% | 1.201 | 91.1% ; Transaction-aware | Any mention of subscription / premium / paid / charge / bill / trial / refund / price / cost / currency symbol / purchase / renew | 11,200 | 25.77% | 2.006 | 65.9% ; Not transaction-aware | The remaining corpus | 32,269 | 74.23% | 4.356 | 9.4%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R24-089 — Of themes with n ≥ 100 ranked by mean, the top twelve are all billing: charge without consent 1.047, refund refused 1.070, scam language 1.073, charged after cancelling 1.085, cannot cancel 1.115, duplicate charges 1.134, not in Apple Subscriptions 1.136, trial not free 1.136, refund requested 1.163, auto-renew no notice 1.168, privacy 1.225, escalated to bank/BBB/FTC 1.236, bundle 1.398, support unresponsive 1.528

- **Where:** §3.2 Worst rating profile table (verbatim) — the top twelve are all billing
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | Mean ★ | %1★ ; Charge without consent / warning | 338 | 1.047 | 97.3% ; Refund refused | 968 | 1.070 | 96.3% ; Scam / fraud / theft vocabulary | 3,468 | 1.073 | 96.6% ; Charged after cancelling | 1,620 | 1.085 | 95.9% ; Cannot find / complete cancellation | 1,146 | 1.115 | 92.3% ; Duplicate / repeated charges | 584 | 1.134 | 93.7% ; Not visible in Apple Subscriptions | 125 | 1.136 | 91.2% ; "Free" trial was not free | 506 | 1.136 | 92.9% ; Refund requested | 1,737 | 1.163 | 92.4% ; Auto-renewal with no notice | 197 | 1.168 | 88.8% ; Privacy / personal data | 138 | 1.225 | 87.7% ; Escalated to bank / BBB / FTC / legal | 212 | 1.236 | 92.5% ; Bundle / sister-app subscription | 324 | 1.398 | 83.6% ; Support unresponsive / automated only | 947 | 1.528 | 80.0%
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-091 — Positive themes by mean: life-changing 4.799; small-steps pacing 4.692; coaching 4.483; routine built 4.467; music/audio 4.387; art/design 4.089; depression/anxiety context 3.938; Circles 3.897; science framing 3.865

- **Where:** §3.3 What the product does well table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % | Mean ★ | %1★ ; Life-changing / best app | 4,468 | 10.28% | 4.799 | 1.8% ; Small-steps pacing | 1,817 | 4.18% | 4.692 | 2.0% ; Coaching / motivation / gentle tone | 6,095 | 14.02% | 4.483 | 5.7% ; Routine or habit actually built | 3,611 | 8.31% | 4.467 | 5.4% ; Music / audio / narration | 282 | 0.65% | 4.387 | 4.6% ; Art / design / graphics | 2,969 | 6.83% | 4.089 | 11.4% ; Depression / anxiety / PTSD / grief context | 1,256 | 2.89% | 3.938 | 19.5% ; Community / Circles | 370 | 0.85% | 3.897 | 14.3% ; Science / research framing | 736 | 1.69% | 3.865 | 18.6%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R24-095 — Unbuilt: calmer home screen 1,324 (3.05%, 46.1% 4–5★); fewer/controllable notifications 744 (1.71%, 28.5%); choose or skip the first habit 124 (0.29%); per-weekday / shift-work scheduling 31 (0.07%, 51.6%); dark mode 43 (0.10%, 58.1%); backfill a missed day / undo a tick 70 (0.16%, 35.7%); iPad app / cross-device continuity 257 (0.59%, 34.2%); more languages 121 (0.28%)

- **Where:** §3.4 Unbuilt table (verbatim) — calmer home screen, fewer notifications, skip first habit, per-weekday scheduling, dark mode, backfill, iPad, more languages, with 4–5★ share
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Need | n | % | 4–5★ share | Evidence ; A calmer, less busy home screen | 1,324 | 3.05% | 46.1% | 7280199018, 9617541402, 11583598458, 12674646598, 13654261115 ; Fewer / controllable notifications | 744 | 1.71% | 28.5% | 4831434999, 7192135813, 8812657942, 10075146878, 13509348951 ; Choose or skip the first habit | 124 | 0.29% | — | 2059294945, 5251295013, 7231330364, 9936616848, 12846167630 ; Per-weekday / shift-work scheduling | 31 | 0.07% | 51.6% | 3862126193, 5984966483, 7852053634, 9671088387, 11251746171 ; Dark mode | 43 | 0.10% | 58.1% | 2419357081, 6929437572, 7390272530, 7848606261, 9789125721 ; Backfill a missed day / undo a tick | 70 | 0.16% | 35.7% | 2060469141, 4366061898, 6272200071, 8412476835, 12421385072 ; iPad app / cross-device continuity | 257 | 0.59% | 34.2% | 3669324936, 5629701161, 7613143521, 9190530552, 12047728556 ; More languages | 121 | 0.28% | — | 2403941042, 4462510307, 6403357982, 8147026632, 12505684120
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `7280199018`, `9617541402`, `11583598458`, `12674646598`, `13654261115`, `4831434999`, `7192135813`, `8812657942`, `10075146878`, `13509348951`, `2059294945`, `5251295013`, `7231330364`, `9936616848`, `12846167630`, `3862126193`, `5984966483`, `7852053634`, `9671088387`, `11251746171`, `2419357081`, `6929437572`, `7390272530`, `7848606261`, `9789125721`, `2060469141`, `4366061898`, `6272200071`, `8412476835`, `12421385072`, `3669324936`, `5629701161`, `7613143521`, `9190530552`, `12047728556`, `2403941042`, `4462510307`, `6403357982`, `8147026632`, `12505684120`
- **Canonical:** — (nuance register)

### R24-112 — Median review length rises monotonically from 5★ to 2★ (105 → 150 → 227 → 286 characters) and falls slightly at 1★ (243) — the 2★ band contains the most considered reviews and the 1★ band many one-word verdicts

- **Where:** Part 5 intro — median review length rises 5★ → 2★ (105 → 150 → 227 → 286 chars) then falls at 1★ (243); the 2★ band holds the most considered reviews
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 105 → 150 → 227 → 286 → 243 chars
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R24-113 — 5★ (n=25,163, mean length 105, bill_core 59 = 0.2%): coaching 18.19%, life-changing 15.75%, routine built 10.57%, design 7.23%, small steps 5.85%, depression/anxiety 3.23%, science 1.77%, cluttered 1.69%, ADHD 1.32%; 424 five-star reviewers still say the interface is too busy — a feature request from retained customers; a substantial share is written in the first three days at the app's prompting, so treat the band as first-impression satisfaction

- **Where:** §5.1 5★ themes table (verbatim); 424 five-star reviewers still say the interface is too busy; much of the band is written in the first three days at the app's prompting
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of band ; Coaching / motivation / gentle tone | 4,578 | 18.19% ; Life-changing / best app | 3,964 | 15.75% ; Routine or habit actually built | 2,660 | 10.57% ; Art / design / graphics | 1,820 | 7.23% ; Small-steps pacing | 1,473 | 5.85% ; Depression / anxiety / PTSD / grief context | 812 | 3.23% ; Science / research framing | 446 | 1.77% ; Cluttered / overwhelming | 424 | 1.69% ; ADHD / autism / executive dysfunction | 331 | 1.32%
- **Direction for us:** must-have · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `13061180549`, `14003379751`, `13802373157`, `12134714782`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C159 Launch-to-core-action path with no interstitials

### R24-117 — 1★ (n=10,413): bill_core present in 5,458 (52.4% of the band); scam 32.18%, refund 15.41%, charged after cancelling 14.91%, cannot cancel 10.16%, refund refused 8.95%, support 7.28%, confusing navigation 6.68%, duplicate charges 5.25%, trial not free 4.51%, ADHD 4.27%; era distribution E1 1,552 (14.9%) · E2 2,031 (19.5%) · E3 1,242 (11.9%) · E4 5,588 (53.7%); within E4, 1★ is 52.5% of everything written

- **Where:** §5.5 1★ themes table (verbatim) — bill_core in 52.4% of the band; era distribution E4 53.7% of all 1★; within E4 1★ is 52.5% of everything written
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of band ; Scam / fraud / theft vocabulary | 3,351 | 32.18% ; Refund requested | 1,605 | 15.41% ; Charged after cancelling | 1,553 | 14.91% ; Cannot cancel | 1,058 | 10.16% ; Refund refused | 932 | 8.95% ; Support unresponsive | 758 | 7.28% ; Confusing navigation | 696 | 6.68% ; Duplicate charges | 547 | 5.25% ; "Free" trial was not free | 470 | 4.51% ; ADHD / neurodivergent | 445 | 4.27%
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R24-118 — Cross-band themes: cluttered (424 in 5★ = 1.69%; 1,324 total, mean 3.068) — retained users want it calmer, new users bounce; ADHD (331 in 5★ = 1.32%; 445 in 1★ = 4.27%) — the segment is both best- and worst-served; design (1,820 in 5★; mean 4.089) — praised even by detractors, not the problem; science framing (446 in 5★; mean 3.865) — credibility cuts both ways once trust is lost

- **Where:** §5.6 Themes that cut across the rating line (verbatim table) — clutter, ADHD, design, science framing
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 5★ n (% of 5★) | 1★ n (% of 1★) | Reading ; Cluttered / overwhelming | 424 (1.69%) | 1,324 total, mean 3.068 | Retained users want it calmer; new users bounce off it ; ADHD / neurodivergent | 331 (1.32%) | 445 (4.27%) | The segment is both the best-served and the worst-served ; Art / design / graphics | 1,820 (7.23%) | mean 4.089 overall | Design is praised even by detractors — it is not the problem ; Science / research framing | 446 (1.77%) | mean 3.865 overall | Credibility cuts both ways once trust is lost (see Part 6.6)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R24-135 — Three populations kept apart: transaction-aware 11,200 (25.77%, mean 2.006), not transaction-aware 32,269 (74.23%, mean 4.356), in active dispute 5,791 (13.32%, 1.110); the 2.35-star gap is the headline and not an artefact of complainers using more words — the non-transaction 74% is happy; caveat: the transaction-aware group self-selects toward money grievances and measures what happens when money enters the conversation, not how payers feel

- **Where:** §7.1 Three populations table (verbatim) — transaction-aware 2.006 vs not 4.356 vs in dispute 1.110; the 2.35-star gap is the headline; caveat: it measures what happens when money enters the conversation
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Population | Definition | n | % | Mean ★ ; Transaction-aware | Mentions subscription / premium / paid / charge / bill / trial / refund / price / cost / currency / purchase / renew | 11,200 | 25.77% | 2.006 ; Not transaction-aware | Everything else | 32,269 | 74.23% | 4.356 ; In active dispute (bill_core) | Subset of the above | 5,791 | 13.32% | 1.110
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R24-151 — China mainland (1,250, eighth-largest storefront): mean 3.431, 28.6% 1★ — worse than the corpus on both — with a computed bill_core of 0.24% that is not a finding because only 15.3% of reviews contain Latin-script words; China is dissatisfied above the corpus average and the report cannot say why; what must not be said is that China has no billing problem; the same caution applies to Russia (63.2% Latin-detectable), Korea (59.0%), Japan (78.6% — rating profile notably poor, mean 3.043, 40.0% 1★, n=70, limited evidence) and Thailand (98.6%)

- **Where:** §8.6 China mainland — the market this method cannot read: mean 3.431, 28.6% 1★; only 15.3% Latin-detectable; what must not be said is that China has no billing problem; same caution for Russia (63.2%), Korea (59.0%), Japan (78.6%, mean 3.043, 40% 1★ on n=70)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** cn 3.431 / 28.6% 1★ / 15.3% readable; jp 3.043 / 40.0% 1★ (n=70)
- **Direction for us:** research · **Report confidence:** measurement gap · **Generalisable:** app-specific
- **Canonical:** C027 Localise early — it unlocks revenue

### R24-154 — Trends are computed on annual, quarterly and era denominators, never the corpus denominator, because corpus share is dominated by volume swings (2021 alone is 22.20% of all reviews); era boundaries chosen from the shape of the data

- **Where:** §9.1 Method — trends on annual, quarterly and era denominators, never the corpus denominator (2021 alone is 22.20%)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (method)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R24-161 — Annual n 9,652 (2021) → 6,649 → 3,146 (2023) → 4,049 (2024) → 3,893 → 2,695 (2026 part-year): volume fell 67% 2021–2023 then rose in 2024 almost entirely as 1★ (35.8% of that year, up from 14.2%) — a rising review count here is a distress signal, not an engagement signal

- **Where:** §9.8 Trend 7 — review volume falls 67% 2021→2023 then rises in 2024 almost entirely as 1★ — a rising review count is a distress signal, not an engagement signal
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** −67% then +29% mostly 1★
- **Direction for us:** none · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R24-162 — Not claimed: that any specific release caused anything (no version field; 2023Q4 and 2024Q4 steps dated not attributed); what changed in December 2019; that product satisfaction declined proportionally (non-transaction population still 4.356); any churn, refund-rate or revenue figure; China/Korea/Russia/Japan trends beyond ratings

- **Where:** §9.9 Trends explicitly NOT claimed — no release attribution, no explanation of Dec 2019, no proportional product-satisfaction decline (non-transaction population 4.356), no churn/refund/revenue claim, no cn/kr/ru/jp trends beyond ratings
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (non-claims)
- **Direction for us:** none · **Report confidence:** non-claim · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R24-192 — Open questions: what changed in December 2019 (bill_core 12.7% → 2.6%, mean 2.884 → 4.206 in one month — the single most valuable unknown; the company appears to have solved this once); what changed in 2023Q4 and 2024Q4; whether China's dissatisfaction is the same problem; the actual refund rate; whether bundle subscriptions are deliberate design or a checkout defect; how much of the E4 review surge is organic vs review-campaign effects

- **Where:** §11.6 Research questions — what changed in Dec 2019 (the single most valuable unknown), 2023Q4 and 2024Q4; is China's dissatisfaction the same problem; actual refund rate; bundles deliberate or a checkout defect; how much of the E4 surge is organic
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none (questions)
- **Direction for us:** research · **Report confidence:** open questions · **Generalisable:** yes
- **Canonical:** — (nuance register)
