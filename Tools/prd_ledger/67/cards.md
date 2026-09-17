# Cards — report 67

Source: `App Store Reports/67. Habio - Daily Habit Tracker - Routine planner & To do list (REPORT).md`  
42 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 1
- [Must-haves](#must-haves) — 2
- [Must never break](#must-never-break) — 6
- [Features](#features) — 2
- [Monetization](#monetization) — 1
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 3
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 9
- [Dated events and trends](#dated-events-and-trends) — 3
- [Positioning](#positioning) — 1
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 6

## Product rules

### R67-042 — The rule this corpus writes: every charge must be one the customer knowingly confirmed and can undo where they bought it — a subscription visible and cancellable in the app whatever channel sold it, an add-on with its own price and confirmation, a trial reminder before conversion, support faster than the trial, and no sourced reviews to paper over the result; otherwise the product's small real base of appreciation (calm design, journal) is buried under 878 unwanted-charge reviews, 682 scam accusations and 196 escalations to banks, regulators and police — 'The flag does not remove a single complaint'

- **Where:** §8.1; §8.2; §8.3; §8.7; §0.1–§0.7
- **This app does:** violated on every point
- **User reaction:** 1★-burst
- **Magnitude:** billing harm 42.81%; non-seeded mean 1.31
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11376403157`, `10212536465`, `11079433591`, `12076539872`
- **Canonical:** C029 Billing must be exactly right; C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable; C112 In-app cancellation; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date; C215 Support reply time must be shorter than any cancellation deadline it serves; C285 Never charge a one-off add-on on a single tap against the authorisation just given for a trial — the add-on shows its price on the button, asks its own confirmation, defaults to 'no thanks' and ignores repeat taps

## Must-haves

### R67-013 — Support is slower than the trial it is meant to cancel: U_SUPPORT_FAIL 425 (20.72%, high-priority, mean 1.04, 2021-01-12 → 2026-07-11); SUP_NONE 213 (10.39%), SUP_SLOW 78 (3.80%), SUP_TEMPLATE 59 (2.88%), SUP_EVASIVE 46 (2.24%); a published response time of up to four business days (19 reviews quote it) against a three-day trial — 'How convenient when they offer a 3-day trial'; 'Funny how when it's public your response is timely'; the same agent name in 5 reviews; a templated public developer reply mentioned in 19 reviews; 37.7% of money-left reviewers report a support failure; a buyer who liked it enough to buy a year ends 'This IS gonna cause me to cancel !' over support; §8.6: first human reply within 24 hours, no retention questions in reply to a cancellation request, no identical public replies

- **Where:** §0.6; §8.6
- **This app does:** 4-business-day SLA vs 3-day trial; templated replies
- **User reaction:** 1★-burst
- **Magnitude:** 425 (20.72%) 1.04; SUP_NONE 213; SLOW 78; TEMPLATE 59; EVASIVE 46
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11333056698`, `10212438359`, `10093276946`, `6862196911`, `10158875434`, `12435693615`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C189 Public review replies answer the specific complaint — never canned, never argue price, never press a reviewer to change the rating; C215 Support reply time must be shorter than any cancellation deadline it serves

### R67-041 — Pop-ups and forced flow undermine the calm design: NEG_POPUP 19 (0.93%, emerging, mean 1.32); NEG_FORCED_FLOW 7 (0.34%) forced intentions, rewards and reflections steps; NEG_ONBOARD_LONG 29 (1.41%) the quiz doubles as the sales funnel; the 2026 dashboard as 'a mini Time Square Billboard showcase'; §8.9: skippable pop-ups and a short path to the first tracked habit

- **Where:** §3.3 NEG_POPUP; §8.9; §8.11
- **This app does:** upsell-heavy dashboard
- **User reaction:** complaint
- **Magnitude:** POPUP 19 (0.93%) 1.32; FORCED_FLOW 7; ONBOARD_LONG 29 (1.41%) 1.24
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `13626218768`, `7766810111`, `8413545877`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C111 No long quiz before the price; show the price up front; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

## Must never break

### R67-004 — This review corpus is, above all, a record of unwanted charges: U_BILLING_HARM 878 (42.81%, high-priority, mean 1.04, 2021-10-08 → 2026-07-11; 60.05% of non-seeded); ACC_SCAM 682 (33.25%, mean 1.00) call it a scam or fraud; 1,033 (50.37%) describe a charge, cancellation or refund problem (70.66% of non-seeded) — distinct mechanisms (verbatim): Code | Meaning | n | % of 2,051 | Band | Mean ★ ; MON_CHARGED_AFTER | Charged after cancelling / deleting | 351 | 17.11% | High-priority signal | 1.04 ; MON_TRIAL_CHARGE | Trial converted to full charge unexpectedly | 173 | 8.43% | High-priority signal | 1.03 ; MON_WORKBOOK | Workbook / PDF / report upsell charge | 189 | 9.22% | High-priority signal | 1.01 ; MON_CHARGED_NOSUB | Charged with no subscription / without authorisation | 164 | 8.00% | High-priority signal | 1.03 ; MON_DOUBLECHARGE | Multiple / duplicate charges | 157 | 7.65% | High-priority signal | 1.08 ; MON_PRICE_MISMATCH | Charged more than the price shown | 55 | 2.68% | Meaningful signal | 1.04 ; MON_REFUND_DENIED | Refund refused | 242 | 11.80% | High-priority signal | 1.01 ; MON_CANCEL | Cannot cancel / cancellation hard | 361 | 17.60% | High-priority signal | 1.01 ; MON_OFFSTORE | Subscription outside App Store (not in Apple subscriptions) | 137 | 6.68% | High-priority signal | 1.01 ; BANK_DISPUTE | Bank / card / PayPal dispute or card cancelled | 118 | 5.75% | High-priority signal | 1.08 ; REG_COMPLAINT | Regulator / police / legal / Apple removal threat | 94 | 4.58% | Very strong signal | 1.00 — 'They make money based on a $1 3 day trial period, and if you forget to cancel in that window, they charge you $40 and NO MATTER WHAT they aren't giving you that money back'; 'Shame on the developers for scamming people, like me, who are trying to work on their mental health' — the two most-voted reviews (16 and 13 votes) are both this complaint; prioritised picture (verbatim): Rank | Theme | Dir | n | % of 2,051 | Band | % of non-seeded | Mean ★ ; 1 | U_BILLING_HARM Any unwanted-charge complaint | − | 878 | 42.81% | High-priority signal | 60.05% | 1.04 ; 2 | ACC_SCAM Calls the app a scam / fraud / theft | − | 682 | 33.25% | High-priority signal | 46.65% | 1.00 ; 3 | U_CANCEL_TRAP Cancellation trap (can't cancel, or charged after cancelling, or off-store) | − | 597 | 29.11% | High-priority signal | 40.83% | 1.03 ; 4 | U_SUPPORT_FAIL Any support failure | − | 425 | 20.72% | High-priority signal | 29.07% | 1.04 ; 5 | U_PRODUCT_NEG Product-quality criticism (not billing) | − | 257 | 12.53% | High-priority signal | 17.31% | 1.25 ; 6 | MON_REFUND_DENIED Refund refused | − | 242 | 11.80% | High-priority signal | 16.55% | 1.01 ; 7 | U_ESCALATION Escalated beyond the app (bank, regulator, legal, Apple) | − | 196 | 9.56% | High-priority signal | 13.41% | 1.05 ; 8 | U_BUG_ANY Any reliability defect | − | 196 | 9.56% | High-priority signal | 13.34% | 1.20 ; 9 | U_AD_MISMATCH Ad/quiz promise not delivered | − | 195 | 9.51% | High-priority signal | 13.20% | 1.08 ; 10 | MON_WORKBOOK Workbook / PDF / report upsell charge | − | 189 | 9.22% | High-priority signal | 12.93% | 1.01 ; 11 | NEG_DARKUX Describes dark patterns / deliberate trickery | − | 163 | 7.95% | High-priority signal | 11.15% | 1.01 ; 12 | U_PAYWALL Paywall / not free / too expensive | − | 129 | 6.29% | High-priority signal | 8.82% | 1.28 ; 13 | USE_ADHD ADHD / neurodivergent | ~ | 97 | 4.73% | Very strong signal | 6.57% | 1.25 ; 14 | U_ACCESS_FAIL Paid/charged but could not get in | − | 97 | 4.73% | Very strong signal | 6.63% | 1.02 ; 15 | U_REQ_ANY Any feature request | − | 82 | 4.00% | Very strong signal | 5.13% | 2.60 ; 16 | U_PRAISE_ANY Any praise code | + | 668 | 32.57% | High-priority signal | 8.41% | 4.69 ; 17 | SUS_SEED Suspected solicited/seeded positive review | ~ | 589 | 28.72% | High-priority signal | 0.00% | 4.91

- **Where:** §0.1 table (verbatim); §3.1 table (verbatim); Warning 5
- **This app does:** web funnel billing
- **User reaction:** 1★-burst
- **Magnitude:** 878 (42.81%) 1.04; ACC_SCAM 682 (33.25%) 1.00
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11376403157`, `10362168353`, `10607823887`, `7891448469`, `10214635678`, `10420955834`
- **Canonical:** C029 Billing must be exactly right; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R67-005 — The cancellation path lives outside the App Store and customers cannot find it: U_CANCEL_TRAP 597 (29.11%, high-priority, mean 1.03, 2021-12-18 → 2026-07-11); MON_OFFSTORE 137 (6.68%) say the subscription does not appear in iOS Subscriptions so Apple cannot cancel or refund it — 'all payments in the Habio application are not displayed in the AppStore and the receipt comes directly from Habio'; 'the subscription is not linked to your Apple account, so even after you delete the app you will still be charged $50 every 180 days unless you redownload the app and cancel through there'; MON_WEB_FUNNEL 30 (1.46%) paid on the website quiz before installing; an emailed cancellation link that expires in 20 minutes; 'email not found' when trying to cancel; the listing says 'Payment will be charged to iTunes Account… auto-renewal may be turned off by going to the user's Account Settings' — not true for web-funnel purchases; CHURN_DELETE 66 (3.22%) believed deleting the app cancels it; the split between in-app and web purchases could not be established ('on peut très bien se désabonner via le Store' from one reviewer); §8.1: show web subscriptions in app settings with status, next charge date and amount, one-tap cancel with on-screen and emailed confirmation, an emailed cancellation effective at receipt, no expiring links or 'email not found' dead ends, listing text aligned with how web subscriptions are billed

- **Where:** §0.2; §8.1; §2.4
- **This app does:** off-store web subscription; no in-app cancel
- **User reaction:** 1★-burst
- **Magnitude:** U_CANCEL_TRAP 597 (29.11%) 1.03; OFFSTORE 137 (6.68%); WEB_FUNNEL 30 (1.46%); CHURN_DELETE 66 (3.22%)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10212536465`, `13184471122`, `10647307854`, `12082860952`, `9744192670`, `10186376860`, `11304376291`
- **Canonical:** C112 In-app cancellation; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R67-006 — Charged after cancelling, or without subscribing: MON_CHARGED_AFTER 351 (17.11%, high-priority, mean 1.04, 2022-02-24 → 2025-09-25, in every era from E2); MON_CHARGED_NOSUB 164 (8.00%, 1.03, 2023-07-28 → 2025-05-09) — the recurring detail is a cancellation the customer believed complete (in-app confirmation, deleting the app, deleting the account, or emailing support): 'While the app does show you a confirmation screen upon submitting your cancelation request, the app itself does not update to show a static message about your canceled status'; 'I receive a charge (6) months later'; 'Tuve que investigar que aplicaciones tenía GOTOTOP LTD para saber que me estaban cobrando' — the merchant name on the statement did not match the app

- **Where:** §3.2 charged after; §7.5
- **This app does:** cancellation not honoured; statement name ≠ app
- **User reaction:** 1★-burst
- **Magnitude:** CHARGED_AFTER 351 (17.11%) 1.04; CHARGED_NOSUB 164 (8.00%) 1.03
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10607823887`, `11011058403`, `11858280315`, `8392560675`, `10093276946`, `10193187378`
- **Canonical:** C029 Billing must be exactly right; C112 In-app cancellation; C221 A receipt with a working product link after every charge, and a renewal reminder before it

### R67-007 — Trials convert before the customer expects, or without a reminder: MON_TRIAL_CHARGE 173 (8.43%, high-priority, mean 1.03, 2021-10-08 → 2025-01-15); MON_NO_RECEIPT 68 (3.32%) no reminder or receipt before the charge; MON_TRIAL_SHORT 9 (0.44%) window too short or shorter than support's reply time; MON_PRICE_MISMATCH 55 (2.68%) charged more than the price shown; MON_TRIAL_1DOLLAR 148 — a $1/€1/£1 3-day or $5–$10 1–2-week paid trial auto-converting to monthly, 6-monthly or annual: 'The day before my trial ended, they took the money and THEN emailed me and said my trial was up the following day'; 'Factually their 3 days trial for 1,00 Euro is actually a 2 two days trial'; §8.3: a reminder 48 hours before conversion with the renewal amount in local currency and plan length; make the trial longer than support's own response time

- **Where:** §3.2 trial; §8.3
- **This app does:** $1 3-day paid trial → $40+ auto-renew
- **User reaction:** 1★-burst
- **Magnitude:** TRIAL_CHARGE 173 (8.43%) 1.03; NO_RECEIPT 68 (3.32%); PRICE_MISMATCH 55 (2.68%); TRIAL_1DOLLAR 148
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11521787038`, `10164682229`, `10230841817`, `10571106959`, `11136886688`
- **Canonical:** C109 A free trial must be a real trial; C113 One stable, disclosed price — no discount wheels; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date; C215 Support reply time must be shorter than any cancellation deadline it serves

### R67-018 — A paid customer must be able to get in: U_BUG_ANY 196 (9.56%, mean 1.20); U_ACCESS_FAIL 97 (4.73%, very strong, mean 1.02, 2022-04-11 → 2025-03-18) (verbatim): Code | Meaning | n | % of 2,051 | Band | Mean ★ ; BUG_LOGIN | Cannot log in / account or email not found | 52 | 2.54% | Meaningful signal | 1.04 ; BUG_ENTITLEMENT | Paid but no premium access / restore fails | 43 | 2.10% | Meaningful signal | 1.00 ; BUG_ONBOARD_STUCK | Stuck in onboarding / cannot proceed | 24 | 1.17% | Meaningful signal | 1.29 ; BUG_LAUNCH | Won't open / white or black screen | 18 | 0.88% | Emerging signal | 1.06 ; BUG_GENERIC | Doesn't work (unspecified) | 29 | 1.41% | Meaningful signal | 1.38 ; BUG_PERF | Slow / laggy | 15 | 0.73% | Emerging signal | 1.20 ; BUG_CRASH | Crashes | 11 | 0.54% | Emerging signal | 1.27 ; BUG_CONTENT | Purchased content not delivered / won't open | 10 | 0.49% | Weak signal | 1.00 ; BUG_LAYOUT | Overlapping / cut-off layout | 8 | 0.39% | Weak signal | 1.50 — 'when I tried to click the restore purchase button it says they couldn't find any purchase history'; 'die App zeigt dann immer an dass die Mail Adresse nicht gefunden wurde, wenn man kündigen will'; early-era defects differed: stuck in onboarding (15 of 73 in E1, 20.55%) and an overlapping 'i need to change something' button over the start button; §8.4: link web purchases to app accounts automatically and make Restore Purchases find them

- **Where:** §3.4 table (verbatim); §8.4
- **This app does:** web purchase not linked to app account
- **User reaction:** 1★-burst
- **Magnitude:** ACCESS_FAIL 97 (4.73%) 1.02; LOGIN 52; ENTITLEMENT 43; ONBOARD_STUCK 24
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `10102515955`, `12082860952`, `7099613318`, `10322014405`, `8556042897`, `11116084699`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R67-025 — What deliberate purchasers report — 35 MON_PAID_EXPLICIT (verbatim): Code | Meaning | n | % of paid reviewers | Band ; MON_REFUND_DENIED | Refund refused | 6 | 17.14% | High-priority signal ; NEG_CONTENT_THIN | Content generic / googleable / poorly written | 5 | 14.29% | High-priority signal ; ACC_SCAM | Calls the app a scam / fraud / theft | 5 | 14.29% | High-priority signal ; MKT_AD_MISLEAD | Ad did not match the product | 5 | 14.29% | High-priority signal ; NEG_SHALLOW | Basic / useless / not worth it | 5 | 14.29% | High-priority signal ; MON_REFUND_SEEK | Requests a refund (outcome not stated) | 5 | 14.29% | High-priority signal ; MKT_LANG_BAIT | Ad/quiz in local language, app English-only | 4 | 11.43% | High-priority signal ; BUG_LOGIN | Cannot log in / account or email not found | 4 | 11.43% | High-priority signal ; SUP_NONE | No response from support | 4 | 11.43% | High-priority signal ; BUG_ENTITLEMENT | Paid but no premium access / restore fails | 4 | 11.43% | High-priority signal ; SUP_SLOW | Slow support response | 4 | 11.43% | High-priority signal ; MKT_INSTAGRAM | Came from Instagram | 4 | 11.43% | High-priority signal — the same failures plus locked premium: 'I paid for a premium access and I was not able to access the premium features'; 'Doesn't even have an option to change the theme or profile photo'

- **Where:** §5.4 table (verbatim)
- **This app does:** premium locked after purchase
- **User reaction:** 1★-burst
- **Magnitude:** 35 (1.71%) 1.23; REFUND_DENIED 6/35 (17.14%)
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** generalisable
- **Review IDs:** `10322014405`, `8745903782`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

## Features

### R67-017 — What goes wrong with the product: U_PRODUCT_NEG 257 (12.53%, high-priority, mean 1.25; 17.31% non-seeded) (verbatim): Code | Meaning | n | % of 2,051 | Band | Mean ★ ; NEG_SHALLOW | Basic / useless / not worth it | 102 | 4.97% | Very strong signal | 1.04 ; NEG_CONTENT_THIN | Content generic / googleable / poorly written | 57 | 2.78% | Meaningful signal | 1.11 ; NEG_COMPLEX | Overwhelming / confusing | 49 | 2.39% | Meaningful signal | 1.37 ; NEG_UX | Clunky / poor UX | 38 | 1.85% | Meaningful signal | 1.61 ; NEG_ONBOARD_LONG | Onboarding / quiz too long | 29 | 1.41% | Meaningful signal | 1.24 ; NEG_POPUP | Too many pop-ups / prompts | 19 | 0.93% | Emerging signal | 1.32 ; NEG_NO_CUSTOM_HABIT | Cannot create own habits | 9 | 0.44% | Weak signal | 1.22 ; NEG_FORCED_FLOW | Forced steps (intentions, rewards, reflections) | 7 | 0.34% | Weak signal | 2.00 — shallow for the price ('You literally pay to track your own habits'; 'essentially charging 1 euro per page'); generic or poor content ('all the typos and language errors'; a therapist: 'which I would never recommend for a client or do myself'); overwhelming for the ADHD users it targets; preset routines only ('What if I want the routine to include a workout but not meditation?'); forced intentions / rewards / reflections steps; §8.10: editable routines and own habits (REQ_CUSTOM_ROUTINE 18 + NEG_NO_CUSTOM_HABIT 9) — 'the most consistent product request from people who got past the paywall'

- **Where:** §3.3 table (verbatim); §8.10
- **This app does:** preset routines; thin content
- **User reaction:** complaint
- **Magnitude:** 257 (12.53%) 1.25; SHALLOW 102 (4.97%); CONTENT_THIN 57; COMPLEX 49; UX 38; ONBOARD_LONG 29; POPUP 19
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10813939995`, `11664580165`, `11043750732`, `10800744729`, `10894127344`, `11189301426`, `7766810111`
- **Canonical:** C111 No long quiz before the price; show the price up front; C116 Content library (workouts, meditation, sleep, journal) as the paid layer; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R67-019 — Unmet needs: U_REQ_ANY 82 (4.00%, very strong, mean 2.60) — requests are few because most reviewers never reached normal use (verbatim): Code | Meaning | n | % of 2,051 | Band | Mean ★ ; REQ_LANG | Wants other languages | 41 | 2.00% | Meaningful signal | 2.41 ; REQ_CUSTOM_ROUTINE | Wants editable / own routines, more customisation | 18 | 0.88% | Emerging signal | 3.06 ; REQ_HELP | Needs instructions / guidance | 8 | 0.39% | Weak signal | 2.00 ; REQ_CALENDAR | Wants calendar view | 5 | 0.24% | Weak signal | 1.80 ; MON_TRIAL_REQ | Wants a (free) trial before paying | 14 | 0.68% | Emerging signal | 1.14 ; MON_ONETIME_REQ | Wants lifetime / one-time purchase | 2 | 0.10% | Ignore by default | 4.00 ; REQ_IPAD | iPad / multi-device | 2 | 0.10% | Ignore by default | 3.00 ; REQ_RESET | Reset progress / selections | 2 | 0.10% | Ignore by default | 1.00 — language is the only request at meaningful strength (REQ_LANG 41, 2.00%, 2.41) and it predates the language-bait ads: 6 in E1 ('ojalá pronto la pongan en español también'); calendar view, instructions / guidance, iPad, reset progress

- **Where:** §3.5 table (verbatim)
- **This app does:** English only; preset routines
- **User reaction:** complaint
- **Magnitude:** REQ_ANY 82 (4.00%) 2.60; REQ_LANG 41 (2.00%)
- **Direction for us:** research · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `7084404117`, `11830254915`, `6863614321`, `7915137610`, `11427700669`
- **Canonical:** C027 Localise early — it unlocks revenue; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

## Monetization

### R67-016 — Free / paid / trial classification (verbatim): Capability or offer | Classification | Basis ; Early app (2020–2021) | Free with limited free tier | PR_FREE 9 (first 2020-12-10), MON_FREE_LIMIT 10: "This app doesn’t ask for payments which I really love" (#6, 6736531333, ae, 5★) ; Using the app (2022 →) | Paid; hard paywall at the end of onboarding | MON_HARDWALL 47, 33 in E2: "“Optional subscription” was a lie" (#77, 8254767500, us, 1★) ; Trial | Paid trial, typically $1/€1/£1 for 3 days or $5–$10 for 1–2 weeks, auto-converting | MON_TRIAL_1DOLLAR 148, MON_TRIAL_CHARGE 173 ; Premium content inside the app after paying | Partly further-gated | MON_UPSELL 10: "even i payed for subscription 350 kr but everything is locked" (#496, 10568318776, se, 1★) ; Workbooks / reports / PDFs | One-off paid add-on, ~$29.99 each | MON_WORKBOOK 189 ; Lifetime / one-time unlock | Listed ($49.99); no reviewer says they bought it | text sweep for lifetime/one-time wording finds 4 reviews (#18 #606 #1019 #1156), none a purchase; MON_ONETIME_REQ 2 ask for one ; Web-funnel subscription | Paid off-store (card/PayPal), per reviewers | MON_WEB_FUNNEL 30, MON_OFFSTORE 137 — early app free with a limited free tier ('This app doesn't ask for payments which I really love'); from 2022 a hard paywall at the end of onboarding ('Optional subscription was a lie'; MON_HARDWALL 47, 33 in E2 = 17.74%); paid trial; premium content partly further-gated after paying ('even i payed for subscription 350 kr but everything is locked'); a listed $49.99 lifetime that no reviewer says they bought; U_PAYWALL 129 (6.29%, mean 1.28) — the objection was paying before seeing anything: 'I'd love an opportunity to try before I buy!'; 'consideren una que sea de un único pago o Lifetime, anima más a los usuarios' (MON_ONETIME_REQ 2); MON_TRIAL_REQ 14 (0.68%); §8.8: a real free tier or card-free trial — measure chargebacks and refund requests, not only conversion

- **Where:** §2.3 table (verbatim); §5.5; §8.8
- **This app does:** hard paywall from 2022; lifetime listed, unseen
- **User reaction:** blocked-conversion
- **Magnitude:** HARDWALL 47; U_PAYWALL 129 (6.29%) 1.28; TRIAL_REQ 14; ONETIME_REQ 2
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `6736531333`, `8254767500`, `10568318776`, `8397732241`, `6863614321`, `6953400305`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C061 Goodwill conversion — a generous free tier and 'support the devs'; C104 Never ship a paywall or feature-removal change silently; C147 Let people use the product before they pay

## Tactics the app used

### R67-014 — 589 five- and four-star reviews look solicited: SUS_SEED 589 (28.72%, high-priority, mean 4.91, 2024-03-11 → 2025-02-18), hand-flagged while reading, then tested against signals not used to assign it (verbatim): Test | Flagged group | Non-flagged 4–5★ | 1–3★ ; Reviews | 589 | 99 | 1,364 ; Author name in Cyrillic script | 198 (33.6%) | 1 (1.0%) | 8 (0.6%) ; On the US storefront | 555 (94.2%) | 25 (25.3%) | 307 (22.5%) ; Any helpfulness vote | 18 (3.1%) | 28 (28.3%) | 213 (15.6%) ; Date range | 2024-03-11 → 2025-02-18 | 2020-10-18 → 2026-04-11 | 2020-11-10 → 2026-07-30 ; Mentions a charge, refund, cancellation or support | 0 | 4 | 1,029 — artefacts genuine reviews do not produce: a developer reply pasted into a 5★ body ('Habio keeps me motivated and on top of We are thrilled to hear that Arch.'); one paragraph split across three accounts in the same hour; six bodies posted twice by different accounts four days apart (SUS_DUPTEXT 12, 0.59%); referral spam ('GuruApp code 9x8xj0'); praise aimed precisely at the complaint (SUS_COUNTER 31, 1.51%: 'Cancelled my subscription with no issues at all'; 'Customer support is quick and helpful'); praise for frequent updates while the current version dates from 2024-05-15 (PR_UPDATES 5) and for sharing with friends that no non-seeded reviewer mentions (PR_SOCIAL 4); 94.2% on the US storefront, 33.6% Cyrillic author names; they supply 81.59% of all praise codes (545 of 668); outcome: the US public rating rose to 4.28 while the non-seeded corpus mean is 1.31; genuine reviewers noticed — 'The app has 4.2 stars, but I have not read more than 2 positive reviews'; 'These scammers pay to have their ratings boosted' (MKT_FAKE_REVIEWS 12); §8.7: any programme that sources, incentivises or scripts reviews should stop — it adds platform-policy risk to 94 regulatory escalations; the flag is judgement, not proof, and cannot say who wrote them

- **Where:** §0.7 table (verbatim); §8.7; Warnings 3, 4
- **This app does:** suspected seeded 5★ wave
- **User reaction:** 5★-burst
- **Magnitude:** 589 (28.72%) 4.91; 94.2% US; 33.6% Cyrillic authors; 81.59% of praise codes
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `12076539872`, `11686908710`, `12012446802`, `12012499702`, `12012575477`, `11360249558`, `11357158616`, `11554629461`, `10210418380`, `11130425750`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

## Insights (the why)

### R67-015 — What real customers valued is small, but it is there: among 1,462 non-seeded reviews praise appears in 123 (8.41%), 39 of them from the free era E1 — the calm visual design (PR_DESIGN 39 non-seeded, in every era: E1 16, E2 12, E3 3, E4 5, E5 3) and the idea (PR_CONCEPT 14), often praised by the people complaining: 'I love the look and feel of the app, it's calming' (1★); 'beautiful soft graphics and layout which make it easy to look at and not overwhelming'; 'I liked it so much I purchased a yearly subscription'; a 2026 review: the dashboard's upsell makes it 'a mini Time Square Billboard showcase'; §8.11 keep the calm soft design and the daily reflection journal — 'The product has a small real base of appreciation. The business model around it is what the corpus condemns'

- **Where:** §0.8; §8.11; §7.5
- **This app does:** calm design; journal
- **User reaction:** praise
- **Magnitude:** non-seeded praise 123 (8.41%); PR_DESIGN 39
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `13626218768`, `9076061818`, `12435693615`, `13944588671`, `6547367313`, `8984118160`
- **Canonical:** C134 Lead the store listing with what users actually love; C172 Per-day / per-habit notes and journal text

### R67-021 — Churn and reviews as a deterrent: U_CHURN 75 (3.66%, very strong, mean 1.27) — CHURN_DELETE 66, CHURN_CANCEL 6, CHURN_RISK 2, CHURN_BLOCKED 1; MKT_REVIEW_MISLEAD 74 (3.61%) refer to other reviews, mostly as a warning — 'The fact that the first several top-rated reviews were all previous users warning others not to pay for subscription'; E2: 'I downloaded this app based on the pinned review that stated it had a free version' — an old 'it's free' review becomes a trap once the model changes

- **Where:** §3.7
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** U_CHURN 75 (3.66%) 1.27; REVIEW_MISLEAD 74 (3.61%)
- **Direction for us:** research · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `10345521492`, `8420684349`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C104 Never ship a paywall or feature-removal change silently

### R67-024 — Money left their account for 995 reviewers (48.51%; 68.06% of non-seeded; mean 1.05) — most did not intend the charge; deliberate purchasers MON_PAID_EXPLICIT 35 (1.71%, mean 1.23); neither is a conversion rate; the dominant purchase path in order: (1) an Instagram / Facebook ad (MKT_INSTAGRAM 40, FACEBOOK 4, SOCIAL 8) pitching ADHD help, a reading hack or a personality profile; (2) a quiz, often in the viewer's language, promising a personalised plan ('so we don't waste our time filling up a bunch of useless data in the first place'); (3) a small paid trial — 'the low price is itself the reason given for trying' ('€5.49 seemed like a reasonable amount to see if the app could fulfil on the promises'); (4) an immediate workbook / report add-on; (5) auto-renewal; very few buy because of the product ('Es ist das Geld Wert!'); money-left segment rates (verbatim): Theme | n in segment | % of segment | % of all 2,051 | Lift ; MON_CANCEL | 284 | 28.5% | 17.6% | 1.62× ; MON_REFUND_DENIED | 242 | 24.3% | 11.8% | 2.06× ; U_SUPPORT_FAIL | 375 | 37.7% | 20.7% | 1.82× ; MON_OFFSTORE | 116 | 11.7% | 6.7% | 1.75× ; MON_WORKBOOK | 189 | 19.0% | 9.2% | 2.06× ; MON_DOUBLECHARGE | 157 | 15.8% | 7.7% | 2.06× ; BANK_DISPUTE | 104 | 10.5% | 5.8% | 1.82× ; REG_COMPLAINT | 76 | 7.6% | 4.6% | 1.67× ; U_ACCESS_FAIL | 81 | 8.1% | 4.7% | 1.72× ; USE_ADHD | 68 | 6.8% | 4.7% | 1.45× ; U_AD_MISMATCH | 121 | 12.2% | 9.5% | 1.28× ; NEG_SHALLOW | 69 | 6.9% | 5.0% | 1.39× ; U_PRAISE_ANY | 18 | 1.8% | 32.6% | 0.06× — refund / churn drivers in order: support failure 37.7%, cancellation 28.5%, refund refusal 24.3%, workbook 19.0%, not worth it 6.9%; praise 0.06× lift

- **Where:** §5.1; §5.2; §5.3 table (verbatim); §5.6
- **This app does:** ad → quiz → $1 trial → workbook → auto-renew
- **User reaction:** 1★-burst
- **Magnitude:** 995 money-left (48.51%) 1.05; 35 deliberate (1.71%) 1.23
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `8413545877`, `11079433591`, `12435693615`, `11421747934`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C065 Paying customers are the highest 1★ risk — every paid feature must work; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable; C187 No paid acquisition into an auto-converting trial in frictionless-payment markets

## Audiences

### R67-012 — The audience the ads target is the audience that reports the most harm: USE_ADHD 97 (4.73%, very strong, mean 1.25, 2022-05-10 → 2026-05-11) — below even the non-seeded mean (1.31); inside the segment MON_REFUND_DENIED 34 of 97 (35.05%), MKT_AD_MISLEAD 30 (30.93%), NEG_DARKUX 23 (23.71%): 'They use lack of focus among the targeted ADHD group and trick You into in app purchase without confirming payment!'; 'en sachant pertinemment à quel point le TDAH est difficile à vivre au quotidien notamment vis à vis de la gestion financière'; USE_ACCESS 18 (0.88%) name vulnerability (disability, low income, student, mental-health crisis); USE_MENTAL 40 (1.95%); 'For someone with ADHD, this app is way too overwhelming'; §8.5: re-examine 'designed in collaboration with mental health professionals'; §8.9: onboarding built for the ADHD audience — short path to the first habit, skippable pop-ups, quiz after first value not before payment

- **Where:** §0.5; §8.5; §8.9
- **This app does:** ads target ADHD
- **User reaction:** 1★-burst
- **Magnitude:** USE_ADHD 97 (4.73%) 1.25; 35.05% refund denied; USE_MENTAL 40; USE_ACCESS 18
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `11655316652`, `10557400319`, `10894127344`, `8657686337`, `10200455380`, `10759152490`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product; C285 Never charge a one-off add-on on a single tap against the authorisation just given for a trial — the add-on shows its price on the button, asks its own confirmation, defaults to 'no thanks' and ignores repeat taps

## Markets and languages

### R67-026 — Storefront table (verbatim): Storefront | Reviews | % of 2,051 | Mean ★ | Flagged | Non-seeded mean ★ | Billing harm % | Lang-bait | Eligible ; us | 886 | 43.20% | 3.58 | 555 | 1.35 | 20.7% | 1 | ✅ ; gb | 159 | 7.75% | 1.31 | 3 | 1.24 | 62.3% | 0 | ✅ ; fr | 91 | 4.44% | 1.16 | 0 | 1.16 | 68.1% | 30 | ✅ ; de | 85 | 4.14% | 1.20 | 0 | 1.20 | 62.4% | 12 | ✅ ; au | 74 | 3.61% | 1.24 | 1 | 1.19 | 54.1% | 0 | ✅ ; ca | 69 | 3.36% | 1.61 | 0 | 1.61 | 55.1% | 1 | ✅ ; es | 53 | 2.58% | 1.06 | 0 | 1.06 | 81.1% | 9 | ✅ ; mx | 46 | 2.24% | 1.46 | 0 | 1.46 | 47.8% | 8 | ; ru | 35 | 1.71% | 4.14 | 27 | 1.25 | 8.6% | 0 | ; pl | 31 | 1.51% | 1.23 | 0 | 1.23 | 80.6% | 0 | ; br | 27 | 1.32% | 1.74 | 0 | 1.74 | 55.6% | 1 | ; cl | 25 | 1.22% | 1.00 | 0 | 1.00 | 52.0% | 10 | ; ua | 24 | 1.17% | 1.54 | 1 | 1.39 | 54.2% | 0 | ; ae | 23 | 1.12% | 1.35 | 0 | 1.35 | 69.6% | 0 | ; nz | 20 | 0.98% | 1.20 | 0 | 1.20 | 80.0% | 0 | ; cz | 19 | 0.93% | 1.21 | 0 | 1.21 | 68.4% | 0 | ; sa | 19 | 0.93% | 1.16 | 0 | 1.16 | 78.9% | 1 | ; nl | 18 | 0.88% | 1.17 | 0 | 1.17 | 22.2% | 0 | ; za | 17 | 0.83% | 1.00 | 0 | 1.00 | 70.6% | 0 | ; se | 17 | 0.83% | 1.18 | 0 | 1.18 | 47.1% | 0 | ; at | 14 | 0.68% | 1.21 | 0 | 1.21 | 71.4% | 0 | ; sk | 13 | 0.63% | 1.00 | 0 | 1.00 | 84.6% | 0 | ; kr | 13 | 0.63% | 1.00 | 0 | 1.00 | 92.3% | 0 | ; dk | 13 | 0.63% | 1.38 | 0 | 1.38 | 69.2% | 0 | ; it | 12 | 0.59% | 1.33 | 1 | 1.09 | 66.7% | 0 | ; ch | 12 | 0.59% | 1.50 | 0 | 1.50 | 50.0% | 2 | ; fi | 11 | 0.54% | 1.27 | 0 | 1.27 | 54.5% | 0 | ; tw | 10 | 0.49% | 1.00 | 0 | 1.00 | 90.0% | 0 | ; ie | 10 | 0.49% | 1.50 | 0 | 1.50 | 50.0% | 0 | ; pt | 10 | 0.49% | 1.20 | 0 | 1.20 | 20.0% | 0 | ; in | 10 | 0.49% | 3.60 | 1 | 3.44 | 10.0% | 0 | ; il | 10 | 0.49% | 1.20 | 0 | 1.20 | 90.0% | 0 | ; hk | 9 | 0.44% | 1.00 | 0 | 1.00 | 88.9% | 0 | ; vn | 9 | 0.44% | 1.56 | 0 | 1.56 | 66.7% | 0 | ; tr | 9 | 0.44% | 1.56 | 0 | 1.56 | 22.2% | 0 | ; sg | 9 | 0.44% | 1.00 | 0 | 1.00 | 66.7% | 0 | ; ro | 8 | 0.39% | 1.00 | 0 | 1.00 | 87.5% | 0 | ; co | 8 | 0.39% | 1.00 | 0 | 1.00 | 50.0% | 4 | ; be | 8 | 0.39% | 1.88 | 0 | 1.88 | 25.0% | 1 | ; ph | 8 | 0.39% | 3.25 | 0 | 3.25 | 25.0% | 0 | ; gr | 8 | 0.39% | 1.12 | 0 | 1.12 | 87.5% | 0 | ; jp | 7 | 0.34% | 1.57 | 0 | 1.57 | 57.1% | 1 | ; ge | 7 | 0.34% | 1.00 | 0 | 1.00 | 71.4% | 0 | ; kw | 7 | 0.34% | 1.00 | 0 | 1.00 | 71.4% | 1 | ; hu | 5 | 0.24% | 1.60 | 0 | 1.60 | 80.0% | 0 | ; ee | 4 | 0.20% | 1.00 | 0 | 1.00 | 0.0% | 0 | ; pa | 4 | 0.20% | 1.00 | 0 | 1.00 | 50.0% | 0 | ; pe | 4 | 0.20% | 1.00 | 0 | 1.00 | 50.0% | 3 | ; hr | 4 | 0.20% | 1.00 | 0 | 1.00 | 50.0% | 0 | ; th | 4 | 0.20% | 2.75 | 0 | 2.75 | 0.0% | 0 | ; do | 3 | 0.15% | 1.00 | 0 | 1.00 | 0.0% | 1 | ; qa | 3 | 0.15% | 1.00 | 0 | 1.00 | 33.3% | 0 | ; si | 3 | 0.15% | 1.00 | 0 | 1.00 | 66.7% | 0 | ; lt | 3 | 0.15% | 1.00 | 0 | 1.00 | 66.7% | 0 | ; no | 3 | 0.15% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; ma | 3 | 0.15% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; gt | 3 | 0.15% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; ar | 3 | 0.15% | 1.00 | 0 | 1.00 | 33.3% | 0 | ; id | 2 | 0.10% | 3.50 | 0 | 3.50 | 0.0% | 0 | ; eg | 2 | 0.10% | 2.50 | 0 | 2.50 | 50.0% | 0 | ; bh | 2 | 0.10% | 2.00 | 0 | 2.00 | 50.0% | 0 | ; uy | 2 | 0.10% | 3.50 | 0 | 3.50 | 0.0% | 0 | ; lk | 2 | 0.10% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; is | 2 | 0.10% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; bs | 1 | 0.05% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; kh | 1 | 0.05% | 5.00 | 0 | 5.00 | 0.0% | 0 | ; jo | 1 | 0.05% | 1.00 | 0 | 1.00 | 0.0% | 0 | ; sv | 1 | 0.05% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; lv | 1 | 0.05% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; ke | 1 | 0.05% | 5.00 | 0 | 5.00 | 0.0% | 0 | ; cy | 1 | 0.05% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; lb | 1 | 0.05% | 1.00 | 0 | 1.00 | 0.0% | 0 | ; mn | 1 | 0.05% | 5.00 | 0 | 5.00 | 0.0% | 0 | ; kz | 1 | 0.05% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; bj | 1 | 0.05% | 1.00 | 0 | 1.00 | 0.0% | 0 | ; om | 1 | 0.05% | 1.00 | 0 | 1.00 | 0.0% | 0 | ; dz | 1 | 0.05% | 1.00 | 0 | 1.00 | 0.0% | 0 | ; rs | 1 | 0.05% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; md | 1 | 0.05% | 1.00 | 0 | 1.00 | 100.0% | 0 | ; tn | 1 | 0.05% | 5.00 | 0 | 5.00 | 0.0% | 0 | ; am | 1 | 0.05% | 1.00 | 0 | 1.00 | 100.0% | 0 | — seven storefronts clear 50 (us 886, gb 159, fr 91, de 85, au 74, ca 69, es 53 = 1,417, 69.09%); groups (verbatim): Group | Reviews | Mean ★ | Non-seeded mean ★ | Billing harm | Cancel trap | Support fail | Ad mismatch | Praise (non-seeded) ; High-spend proxy (6) | 1,364 | 2.78 | 1.30 | 34.8% | 25.7% | 19.8% | 8.2% | 7.7% ; High-review-volume (7) | 1,417 | 2.72 | 1.29 | 36.6% | 26.1% | 19.8% | 8.7% | 7.2% ; All other storefronts (74) | 634 | 1.53 | 1.35 | 56.8% | 35.8% | 22.7% | 11.4% | 10.1% ; Global | 2,051 | 2.35 | 1.31 | 42.8% | 29.1% | 20.7% | 9.5% | 8.4% — 'the complaint does not depend on the market': non-seeded means near 1★ in every group and billing harm or the cancellation trap is the largest complaint in every eligible storefront; what varies is the mechanism — workbook (gb, es), language bait (fr, de), cancellation and support (au, de); no spend dataset fetched, so the high-spend group is an install-base proxy from lookup-API rating counts

- **Where:** §6.1 table (verbatim); §6.2; §6.10 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 7 eligible; non-seeded means 1.29–1.35 by group
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10969072744`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R67-027 — US — 886 reviews, mean 3.58 (verbatim): Code | Meaning | n | % of 886 us | Band ; SUS_SEED | Suspected solicited/seeded positive review | 555 | 62.64% | High-priority signal ; ACC_SCAM | Calls the app a scam / fraud / theft | 163 | 18.40% | High-priority signal ; PR_DESIGN | Design / interface praised | 113 | 12.75% | High-priority signal ; PR_SIMPLE | Easy to use / simple | 103 | 11.63% | High-priority signal ; MON_CHARGED_AFTER | Charged after cancelling / deleting | 98 | 11.06% | High-priority signal ; MON_CANCEL | Cannot cancel / cancellation hard | 89 | 10.05% | High-priority signal ; PR_GENERIC | Generic praise | 84 | 9.48% | High-priority signal ; PR_MOTIVATION | Motivating | 73 | 8.24% | High-priority signal ; SUP_NONE | No response from support | 64 | 7.22% | High-priority signal ; PR_OUTCOME | Reports a real outcome / habit built | 63 | 7.11% | High-priority signal ; PR_STATS | Progress tracking / analytics | 63 | 7.11% | High-priority signal ; MON_REFUND_DENIED | Refund refused | 59 | 6.66% | High-priority signal ; U_BILLING_HARM | Any unwanted-charge complaint | 183 | 20.65% | High-priority signal ; U_CANCEL_TRAP | Cancellation trap (can't cancel, or charged after cancelling, or off-store) | 147 | 16.59% | High-priority signal ; U_SUPPORT_FAIL | Any support failure | 117 | 13.21% | High-priority signal ; U_AD_MISMATCH | Ad/quiz promise not delivered | 25 | 2.82% | Meaningful signal ; U_PRAISE_ANY | Any praise code | 539 | 60.84% | High-priority signal — 'The US is two corpora': 555 of 886 (62.64%) flagged, 94.23% of all flagged; the 331 non-seeded US reviews average 1.35 with billing harm in 55.29%; US public 4.28 from 3,932 — the highest of eight storefronts looked up; US reviewers escalate to BBB, FTC, state attorney general ('I plan to also file with the attorney general')

- **Where:** §6.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** us 886 @ 3.58; non-seeded 331 @ 1.35
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Review IDs:** `10969072744`, `6629648842`, `10607823887`, `11532273217`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R67-028 — GB — 159 reviews, mean 1.31 — 'the workbook and ADHD market' (verbatim): Code | Meaning | n | % of 159 gb | Band ; ACC_SCAM | Calls the app a scam / fraud / theft | 61 | 38.36% | High-priority signal ; MON_CHARGED_AFTER | Charged after cancelling / deleting | 44 | 27.67% | High-priority signal ; MON_CANCEL | Cannot cancel / cancellation hard | 40 | 25.16% | High-priority signal ; MON_REFUND_DENIED | Refund refused | 31 | 19.50% | High-priority signal ; MON_WORKBOOK | Workbook / PDF / report upsell charge | 30 | 18.87% | High-priority signal ; SUP_NONE | No response from support | 25 | 15.72% | High-priority signal ; USE_ADHD | ADHD / neurodivergent | 23 | 14.47% | High-priority signal ; MON_OFFSTORE | Subscription outside App Store (not in Apple subscriptions) | 22 | 13.84% | High-priority signal ; NEG_DARKUX | Describes dark patterns / deliberate trickery | 22 | 13.84% | High-priority signal ; MON_TRIAL | Trial mentioned | 21 | 13.21% | High-priority signal ; MON_CHARGED_NOSUB | Charged with no subscription / without authorisation | 19 | 11.95% | High-priority signal ; MON_TRIAL_1DOLLAR | Paid 'trial' (~$1 / €1 / £1 / $5–$10) | 18 | 11.32% | High-priority signal ; U_BILLING_HARM | Any unwanted-charge complaint | 99 | 62.26% | High-priority signal ; U_CANCEL_TRAP | Cancellation trap (can't cancel, or charged after cancelling, or off-store) | 67 | 42.14% | High-priority signal ; U_SUPPORT_FAIL | Any support failure | 55 | 34.59% | High-priority signal ; U_AD_MISMATCH | Ad/quiz promise not delivered | 18 | 11.32% | High-priority signal ; U_PRAISE_ANY | Any praise code | 14 | 8.81% | High-priority signal — MON_WORKBOOK 30 of 159 (18.87%, rank 2 of 7), USE_ADHD 23 (14.47%, rank 1), MKT_AD_BIONIC 7 (4.40%, rank 1): 'they're using your own ADHD against you'

- **Where:** §6.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** gb 159 @ 1.31; ADHD 14.47%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Review IDs:** `10744087852`, `6778914453`, `10313262589`
- **Canonical:** C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product; C285 Never charge a one-off add-on on a single tap against the authorisation just given for a trial — the add-on shows its price on the button, asks its own confirmation, defaults to 'no thanks' and ignores repeat taps

### R67-029 — FR — 91 reviews, mean 1.16 — 'the language-bait market' (verbatim): Code | Meaning | n | % of 91 fr | Band ; ACC_SCAM | Calls the app a scam / fraud / theft | 46 | 50.55% | High-priority signal ; MKT_LANG_BAIT | Ad/quiz in local language, app English-only | 30 | 32.97% | High-priority signal ; MON_CANCEL | Cannot cancel / cancellation hard | 22 | 24.18% | High-priority signal ; MON_TRIAL_CHARGE | Trial converted to full charge unexpectedly | 19 | 20.88% | High-priority signal ; MON_CHARGED_AFTER | Charged after cancelling / deleting | 18 | 19.78% | High-priority signal ; MON_WORKBOOK | Workbook / PDF / report upsell charge | 16 | 17.58% | High-priority signal ; MON_TRIAL_1DOLLAR | Paid 'trial' (~$1 / €1 / £1 / $5–$10) | 16 | 17.58% | High-priority signal ; MON_REFUND_DENIED | Refund refused | 14 | 15.38% | High-priority signal ; NEG_DARKUX | Describes dark patterns / deliberate trickery | 13 | 14.29% | High-priority signal ; MON_REFUND_SEEK | Requests a refund (outcome not stated) | 13 | 14.29% | High-priority signal ; REQ_LANG | Wants other languages | 12 | 13.19% | High-priority signal ; MON_DOUBLECHARGE | Multiple / duplicate charges | 12 | 13.19% | High-priority signal ; U_BILLING_HARM | Any unwanted-charge complaint | 62 | 68.13% | High-priority signal ; U_CANCEL_TRAP | Cancellation trap (can't cancel, or charged after cancelling, or off-store) | 34 | 37.36% | High-priority signal ; U_SUPPORT_FAIL | Any support failure | 21 | 23.08% | High-priority signal ; U_AD_MISMATCH | Ad/quiz promise not delivered | 36 | 39.56% | High-priority signal ; U_PRAISE_ANY | Any praise code | 3 | 3.30% | Very strong signal — MKT_LANG_BAIT 30 of 91 (32.97%, rank 1), REQ_LANG 12 (13.19%, rank 1); no French review flagged; praise of any kind 3: 'faites au moins un travail de traduction de votre application'

- **Where:** §6.5 table (verbatim)
- **This app does:** French ads, English app
- **User reaction:** 1★-burst
- **Magnitude:** fr 91 @ 1.16; LANG_BAIT 32.97%
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Review IDs:** `11563418439`, `7145375160`, `10390703896`
- **Canonical:** C027 Localise early — it unlocks revenue; C286 Never advertise or sell in a language the app does not ship — a localised ad, quiz or checkout for an English-only app is a refund request waiting to happen

### R67-030 — DE — 85 reviews, mean 1.20 — 'Germany frames the cancellation problem in legal terms' (verbatim): Code | Meaning | n | % of 85 de | Band ; ACC_SCAM | Calls the app a scam / fraud / theft | 49 | 57.65% | High-priority signal ; MON_CANCEL | Cannot cancel / cancellation hard | 28 | 32.94% | High-priority signal ; MON_CHARGED_AFTER | Charged after cancelling / deleting | 17 | 20.00% | High-priority signal ; MON_TRIAL_1DOLLAR | Paid 'trial' (~$1 / €1 / £1 / $5–$10) | 17 | 20.00% | High-priority signal ; NEG_DARKUX | Describes dark patterns / deliberate trickery | 16 | 18.82% | High-priority signal ; MON_TRIAL_CHARGE | Trial converted to full charge unexpectedly | 13 | 15.29% | High-priority signal ; MKT_LANG_BAIT | Ad/quiz in local language, app English-only | 12 | 14.12% | High-priority signal ; MON_WORKBOOK | Workbook / PDF / report upsell charge | 12 | 14.12% | High-priority signal ; MON_REFUND_DENIED | Refund refused | 11 | 12.94% | High-priority signal ; SUP_NONE | No response from support | 11 | 12.94% | High-priority signal ; USE_ADHD | ADHD / neurodivergent | 9 | 10.59% | High-priority signal ; MON_CHARGED_NOSUB | Charged with no subscription / without authorisation | 9 | 10.59% | High-priority signal ; U_BILLING_HARM | Any unwanted-charge complaint | 53 | 62.35% | High-priority signal ; U_CANCEL_TRAP | Cancellation trap (can't cancel, or charged after cancelling, or off-store) | 37 | 43.53% | High-priority signal ; U_SUPPORT_FAIL | Any support failure | 26 | 30.59% | High-priority signal ; U_AD_MISMATCH | Ad/quiz promise not delivered | 14 | 16.47% | High-priority signal ; U_PRAISE_ANY | Any praise code | 7 | 8.24% | High-priority signal — MON_CANCEL 28 of 85 (32.94%, rank 2), NEG_DARKUX 16 (18.82%, rank 2), MKT_LANG_BAIT 12 (14.12%, rank 3); reviewers write Abofalle (subscription trap) and Widerrufsfrist (withdrawal period): 'obwohl ich innerhalb der Widerrufsfrust sogar mit nachweislichen Screenshots gekündigt habe'

- **Where:** §6.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** de 85 @ 1.20; CANCEL 32.94%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Review IDs:** `14053313423`, `6781153977`, `11138835485`
- **Canonical:** C112 In-app cancellation; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R67-031 — AU — 74 reviews, mean 1.24 — 'the cancellation-and-support market' (verbatim): Code | Meaning | n | % of 74 au | Band ; ACC_SCAM | Calls the app a scam / fraud / theft | 34 | 45.95% | High-priority signal ; MON_CANCEL | Cannot cancel / cancellation hard | 27 | 36.49% | High-priority signal ; MON_CHARGED_AFTER | Charged after cancelling / deleting | 24 | 32.43% | High-priority signal ; SUP_NONE | No response from support | 16 | 21.62% | High-priority signal ; MON_REFUND_DENIED | Refund refused | 12 | 16.22% | High-priority signal ; MON_TRIAL | Trial mentioned | 10 | 13.51% | High-priority signal ; MON_OFFSTORE | Subscription outside App Store (not in Apple subscriptions) | 10 | 13.51% | High-priority signal ; MKT_AD_MISLEAD | Ad did not match the product | 8 | 10.81% | High-priority signal ; USE_ADHD | ADHD / neurodivergent | 8 | 10.81% | High-priority signal ; BANK_DISPUTE | Bank / card / PayPal dispute or card cancelled | 8 | 10.81% | High-priority signal ; MON_DOUBLECHARGE | Multiple / duplicate charges | 8 | 10.81% | High-priority signal ; BUG_LOGIN | Cannot log in / account or email not found | 7 | 9.46% | High-priority signal ; U_BILLING_HARM | Any unwanted-charge complaint | 40 | 54.05% | High-priority signal ; U_CANCEL_TRAP | Cancellation trap (can't cancel, or charged after cancelling, or off-store) | 43 | 58.11% | High-priority signal ; U_SUPPORT_FAIL | Any support failure | 32 | 43.24% | High-priority signal ; U_AD_MISMATCH | Ad/quiz promise not delivered | 9 | 12.16% | High-priority signal ; U_PRAISE_ANY | Any praise code | 6 | 8.11% | High-priority signal — U_CANCEL_TRAP 43 of 74 (58.11%, rank 1), U_SUPPORT_FAIL 32 (43.24%, rank 1); currency confusion: 'they've also never mentioned in their add that the currency is not in AUD'

- **Where:** §6.7 table (verbatim)
- **This app does:** prices not in local currency
- **User reaction:** 1★-burst
- **Magnitude:** au 74 @ 1.24; CANCEL_TRAP 58.11%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Review IDs:** `10619536655`, `6862196911`, `10193187378`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C112 In-app cancellation; C113 One stable, disclosed price — no discount wheels

### R67-032 — CA — 69 reviews, mean 1.61 — 'Canada leans on refusal and the product' (verbatim): Code | Meaning | n | % of 69 ca | Band ; ACC_SCAM | Calls the app a scam / fraud / theft | 20 | 28.99% | High-priority signal ; MON_REFUND_DENIED | Refund refused | 15 | 21.74% | High-priority signal ; MON_CANCEL | Cannot cancel / cancellation hard | 13 | 18.84% | High-priority signal ; NEG_DARKUX | Describes dark patterns / deliberate trickery | 11 | 15.94% | High-priority signal ; MON_CHARGED_AFTER | Charged after cancelling / deleting | 11 | 15.94% | High-priority signal ; MON_TRIAL | Trial mentioned | 10 | 14.49% | High-priority signal ; MON_WORKBOOK | Workbook / PDF / report upsell charge | 9 | 13.04% | High-priority signal ; MON_DOUBLECHARGE | Multiple / duplicate charges | 9 | 13.04% | High-priority signal ; MON_TRIAL_CHARGE | Trial converted to full charge unexpectedly | 8 | 11.59% | High-priority signal ; SUP_NONE | No response from support | 8 | 11.59% | High-priority signal ; NEG_SHALLOW | Basic / useless / not worth it | 8 | 11.59% | High-priority signal ; MKT_AD_MISLEAD | Ad did not match the product | 8 | 11.59% | High-priority signal ; U_BILLING_HARM | Any unwanted-charge complaint | 38 | 55.07% | High-priority signal ; U_CANCEL_TRAP | Cancellation trap (can't cancel, or charged after cancelling, or off-store) | 23 | 33.33% | High-priority signal ; U_SUPPORT_FAIL | Any support failure | 19 | 27.54% | High-priority signal ; U_AD_MISMATCH | Ad/quiz promise not delivered | 10 | 14.49% | High-priority signal ; U_PRAISE_ANY | Any praise code | 9 | 13.04% | High-priority signal — MON_REFUND_DENIED 15 of 69 (21.74%, rank 1), U_PRODUCT_NEG 17 (24.64%, rank 1): 'Habio's real functionality lies in its ability to perform a vanishing act with your cash'

- **Where:** §6.8 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** ca 69 @ 1.61
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Review IDs:** `11157102019`, `6789088654`, `10756364742`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R67-033 — ES — 53 reviews, mean 1.06 — 'the most uniformly harmed storefront' (verbatim): Code | Meaning | n | % of 53 es | Band ; ACC_SCAM | Calls the app a scam / fraud / theft | 35 | 66.04% | High-priority signal ; MON_WORKBOOK | Workbook / PDF / report upsell charge | 21 | 39.62% | High-priority signal ; MON_CANCEL | Cannot cancel / cancellation hard | 15 | 28.30% | High-priority signal ; MON_CHARGED_NOSUB | Charged with no subscription / without authorisation | 13 | 24.53% | High-priority signal ; MON_TRIAL_1DOLLAR | Paid 'trial' (~$1 / €1 / £1 / $5–$10) | 12 | 22.64% | High-priority signal ; NEG_DARKUX | Describes dark patterns / deliberate trickery | 11 | 20.75% | High-priority signal ; MON_REFUND_DENIED | Refund refused | 10 | 18.87% | High-priority signal ; MKT_LANG_BAIT | Ad/quiz in local language, app English-only | 9 | 16.98% | High-priority signal ; MON_REFUND_SEEK | Requests a refund (outcome not stated) | 8 | 15.09% | High-priority signal ; MON_CHARGED_AFTER | Charged after cancelling / deleting | 7 | 13.21% | High-priority signal ; MON_DOUBLECHARGE | Multiple / duplicate charges | 7 | 13.21% | High-priority signal ; REG_COMPLAINT | Regulator / police / legal / Apple removal threat | 7 | 13.21% | High-priority signal ; U_BILLING_HARM | Any unwanted-charge complaint | 43 | 81.13% | High-priority signal ; U_CANCEL_TRAP | Cancellation trap (can't cancel, or charged after cancelling, or off-store) | 19 | 35.85% | High-priority signal ; U_SUPPORT_FAIL | Any support failure | 11 | 20.75% | High-priority signal ; U_AD_MISMATCH | Ad/quiz promise not delivered | 11 | 20.75% | High-priority signal ; U_PRAISE_ANY | Any praise code | 0 | 0.00% | Ignore by default — U_BILLING_HARM 43 of 53 (81.13%, rank 1), MON_WORKBOOK 21 (39.62%, rank 1), NEG_DARKUX 11 (20.75%, rank 1); praise codes 0: 'cliqué en un espacio para informarme más acerca de un pdf y directamente me cobraron 29€!'

- **Where:** §6.9 table (verbatim)
- **This app does:** PDF tap charged €29
- **User reaction:** 1★-burst
- **Magnitude:** es 53 @ 1.06; billing 81.13%; workbook 39.62%
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Review IDs:** `11258627106`, `8395059167`, `11245047696`
- **Canonical:** C029 Billing must be exactly right; C285 Never charge a one-off add-on on a single tap against the authorisation just given for a trial — the add-on shows its price on the button, asks its own confirmation, defaults to 'no thanks' and ignores repeat taps

### R67-034 — Storefront is not language (verbatim): Language | Storefronts (reviews) ; es | mx (41), es (36), cl (22), co (8), pe (4), us (3), pa (2), uy (2), ar (2), do (1), sv (1), au (1) ; fr | fr (74), ch (2), ma (1), bj (1), be (1), ca (1), dz (1) ; de | de (47), at (4), ch (2) ; pt | br (12), pt (4), ca (1) ; ko | kr (10) ; ar | sa (7), kw (1), bh (1) ; it | it (8) ; ru | us (3), ru (3), ua (2) ; vi | vn (5) ; pl | pl (5) ; zh | tw (4) ; tr | tr (4) ; da | dk (3) ; uk | ua (2), pl (1) ; ja | jp (2) ; fi | fi (2) ; sv | se (1) ; nl | nl (1) — English reviews on non-English storefronts de 37, ru 32, pl 25, ae 23, es 17, fr 17, br 15, sa 12; the Russian storefront is 27 flagged of 35 so its mean (4.14) is not market evidence; below-50 storefronts [limited evidence]: mx 46 @ 1.46 (scam 25, cancel 12), pl 31 @ 1.23, br 27 @ 1.74, cl 25 @ 1.00 (lang-bait 10), ua 24 @ 1.54 (off-store 6), ae 23 @ 1.35, nz 20 @ 1.20

- **Where:** §6.11 table (verbatim); §6.12
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ru 27/35 flagged
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `6741644871`, `7272374187`, `6734806848`, `8532787001`, `7168337466`, `6736531333`, `6547367313`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

## Dated events and trends

### R67-010 — Escalation beyond the app: U_ESCALATION 196 (9.56%, high-priority, mean 1.05, 2022-04-18 → 2026-05-11); BANK_DISPUTE 118 (5.75%) bank, card or PayPal dispute or cancelled card; REG_COMPLAINT 94 (4.58%, very strong) regulator / police / legal / Apple removal threat — BBB, FTC, ACCC, state attorneys general, the EU consumer regulator, Spain's OCU, Chile's Sernac, Germany's Verbraucherzentrale, police, Apple: 'Es ist eine Abofalle die bereits der Polizei und der Verbraucherzentrale gemeldet wurde'

- **Where:** §3.2 escalation
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** ESCALATION 196 (9.56%); BANK 118 (5.75%); REG 94 (4.58%)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11521787038`, `11216322956`, `8581410208`, `10270571607`, `10850861915`
- **Canonical:** C029 Billing must be exactly right

### R67-035 — Eras cut where the dominant complaint changes (verbatim): Era | Name | Dates | Reviews | Mean ★ | 1★ % | 5★ % | Flagged | Non-seeded mean ★ ; E1 | Free/early | 2020-10-18 → 2021-12-30 | 73 | 3.03 | 32.9% | 35.6% | 0 | 3.03 ; E2 | Paywall arrives | 2022-01-04 → 2023-06-30 | 186 | 1.73 | 73.7% | 11.8% | 0 | 1.73 ; E3 | Web funnel + off-store billing | 2023-07-01 → 2024-02-29 | 572 | 1.17 | 93.4% | 2.3% | 0 | 1.17 ; E4 | Workbook, language-bait and 5★ wave | 2024-03-01 → 2025-02-19 | 1,198 | 2.98 | 48.7% | 45.7% | 589 | 1.11 ; E5 | Tail | 2025-03-08 → 2026-07-30 | 22 | 1.59 | 77.3% | 9.1% | 0 | 1.59 — theme movement (verbatim): Theme | E1 | E2 | E3 | E4 | E5 ; U_PRAISE_ANY | 39 (53.4%) | 37 (19.9%) | 26 (4.5%) | 562 (46.9%) | 4 (18.2%) ; PR_FREE | 6 (8.2%) | 0 (0.0%) | 2 (0.3%) | 1 (0.1%) | 0 (0.0%) ; BUG_ONBOARD_STUCK | 15 (20.5%) | 3 (1.6%) | 4 (0.7%) | 2 (0.2%) | 0 (0.0%) ; MON_HARDWALL | 3 (4.1%) | 33 (17.7%) | 7 (1.2%) | 1 (0.1%) | 3 (13.6%) ; MON_TRIAL_1DOLLAR | 0 (0.0%) | 12 (6.5%) | 74 (12.9%) | 62 (5.2%) | 0 (0.0%) ; MON_CHARGED_AFTER | 0 (0.0%) | 43 (23.1%) | 187 (32.7%) | 117 (9.8%) | 4 (18.2%) ; MON_OFFSTORE | 0 (0.0%) | 6 (3.2%) | 79 (13.8%) | 51 (4.3%) | 1 (4.5%) ; MKT_AD_BIONIC | 0 (0.0%) | 0 (0.0%) | 18 (3.1%) | 4 (0.3%) | 0 (0.0%) ; MON_WORKBOOK | 0 (0.0%) | 0 (0.0%) | 73 (12.8%) | 115 (9.6%) | 1 (4.5%) ; MKT_LANG_BAIT | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 85 (7.1%) | 1 (4.5%) ; U_SUPPORT_FAIL | 1 (1.4%) | 37 (19.9%) | 201 (35.1%) | 180 (15.0%) | 6 (27.3%) ; ACC_SCAM | 0 (0.0%) | 37 (19.9%) | 294 (51.4%) | 346 (28.9%) | 5 (22.7%) ; USE_ADHD | 0 (0.0%) | 6 (3.2%) | 41 (7.2%) | 48 (4.0%) | 2 (9.1%) ; SUS_SEED | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 589 (49.2%) | 0 (0.0%) — E1 free (73, 3.03): thin free tier, onboarding traps, real specific praise 53.42%; E2 paywall (186, 1.73): free tier disappears (hard wall 17.74%), charges after cancelling begin 2022-02-24; E3 web funnel (572, 1.17): volume triples, off-store billing 13.81%, $1 trial 12.94%, bionic-reading ad 3.15%, scam language 51.4%, workbook from 2023-10-15; E4 (1,198, 2.98; non-seeded 1.11): workbook peaks 2024-04 (41), language-bait from 2024-03-28, the flagged 5★ wave from 2024-03-11 peaking 2024-12 (101) and from 2024-08 outnumbering 1★ in every month — the era mean rises to 2.98 while the non-seeded mean stays 1.11; E5 tail (22, 1.59)

- **Where:** §7.1 table (verbatim); §7.2 table (verbatim); §7.4
- **This app does:** free → paywall → web funnel → workbook + seeded wave
- **User reaction:** mixed
- **Magnitude:** era means 3.03/1.73/1.17/2.98/1.59
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `8420684349`, `13626218768`, `13944588671`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C104 Never ship a paywall or feature-removal change silently; C187 No paid acquisition into an auto-converting trial in frictionless-payment markets

### R67-036 — Monthly series 2022-01 onward (verbatim): Month | Reviews | 1★ | 5★ | $1-trial | Off-store | Charged after | Bionic ad | Workbook | Lang-bait | Flagged ; 2022-01 | 9 | 8 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 ; 2022-02 | 17 | 13 | 2 | 0 | 0 | 1 | 0 | 0 | 0 | 0 ; 2022-03 | 17 | 11 | 2 | 0 | 0 | 2 | 0 | 0 | 0 | 0 ; 2022-04 | 13 | 9 | 0 | 0 | 0 | 2 | 0 | 0 | 0 | 0 ; 2022-05 | 9 | 7 | 2 | 0 | 0 | 2 | 0 | 0 | 0 | 0 ; 2022-06 | 11 | 8 | 2 | 0 | 0 | 1 | 0 | 0 | 0 | 0 ; 2022-07 | 20 | 13 | 5 | 2 | 0 | 1 | 0 | 0 | 0 | 0 ; 2022-08 | 11 | 6 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 ; 2022-09 | 10 | 7 | 3 | 1 | 0 | 4 | 0 | 0 | 0 | 0 ; 2023-01 | 5 | 4 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 ; 2023-03 | 6 | 4 | 1 | 1 | 2 | 2 | 0 | 0 | 0 | 0 ; 2023-04 | 10 | 10 | 0 | 0 | 0 | 6 | 0 | 0 | 0 | 0 ; 2023-05 | 21 | 16 | 0 | 5 | 3 | 10 | 0 | 0 | 0 | 0 ; 2023-06 | 18 | 14 | 2 | 3 | 1 | 6 | 0 | 0 | 0 | 0 ; 2023-07 | 49 | 42 | 3 | 9 | 8 | 13 | 3 | 0 | 0 | 0 ; 2023-08 | 75 | 73 | 0 | 9 | 17 | 37 | 2 | 0 | 0 | 0 ; 2023-09 | 53 | 48 | 2 | 13 | 7 | 25 | 4 | 0 | 0 | 0 ; 2023-10 | 46 | 41 | 1 | 3 | 10 | 20 | 1 | 3 | 0 | 0 ; 2023-11 | 59 | 52 | 1 | 4 | 6 | 19 | 0 | 4 | 0 | 0 ; 2023-12 | 77 | 74 | 3 | 14 | 9 | 19 | 3 | 14 | 0 | 0 ; 2024-01 | 111 | 106 | 1 | 13 | 12 | 33 | 4 | 27 | 0 | 0 ; 2024-02 | 102 | 98 | 2 | 9 | 10 | 21 | 1 | 25 | 0 | 0 ; 2024-03 | 114 | 81 | 31 | 8 | 10 | 20 | 0 | 13 | 2 | 30 ; 2024-04 | 208 | 179 | 17 | 19 | 10 | 22 | 1 | 41 | 33 | 22 ; 2024-05 | 107 | 90 | 15 | 5 | 4 | 18 | 0 | 18 | 16 | 16 ; 2024-06 | 87 | 59 | 26 | 9 | 6 | 12 | 1 | 13 | 9 | 25 ; 2024-07 | 114 | 62 | 45 | 11 | 13 | 19 | 1 | 10 | 10 | 52 ; 2024-08 | 135 | 53 | 75 | 5 | 3 | 6 | 0 | 15 | 7 | 80 ; 2024-09 | 77 | 19 | 53 | 4 | 3 | 9 | 1 | 3 | 2 | 57 ; 2024-10 | 75 | 9 | 58 | 0 | 2 | 3 | 0 | 0 | 0 | 65 ; 2024-11 | 49 | 5 | 40 | 0 | 0 | 2 | 0 | 0 | 0 | 43 ; 2024-12 | 114 | 10 | 95 | 0 | 0 | 3 | 0 | 1 | 1 | 101 ; 2025-01 | 88 | 12 | 70 | 1 | 0 | 1 | 0 | 1 | 5 | 72 ; 2025-02 | 30 | 4 | 22 | 0 | 0 | 2 | 0 | 0 | 0 | 26 ; 2025-05 | 5 | 5 | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 0 — off-store and charged-after complaints climb from mid-2023 (2023-08: 73 of 75 reviews 1★, 37 charged-after); workbook appears 2023-10 and peaks 2024-04 (41) with language-bait 33 the same month; flagged reviews from 2024-03, 5★ outnumber 1★ from 2024-08, 101 flagged in 2024-12, flagged stop after 2025-02

- **Where:** §7.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2024-04: 208 reviews, workbook 41, lang-bait 33; 2024-12: 101 flagged
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Review IDs:** `10476768777`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable; C285 Never charge a one-off add-on on a single tap against the authorisation just given for a trial — the add-on shows its price on the button, asks its own confirmation, defaults to 'no thanks' and ignores repeat taps; C286 Never advertise or sell in a language the app does not ship — a localised ad, quiz or checkout for an English-only app is a refund request waiting to happen

## Positioning

### R67-001 — Habio – Daily Habit Tracker (App Store ID 1517360968; 'Routine planner & To do list') by Gototop LTD (com.habio) — a habit tracker with preset habits and routines, daily check-off, a reflection journal, short articles and courses ('insights'), motivational quotes, reminders and simple stats, sold mostly through a web quiz reached from Instagram / Facebook ads with a small paid trial and add-on workbooks; 2,051 reviews (every one read and hand-coded), 81 storefronts, 19 languages, 2020-10-18 → 2026-07-30, corpus mean 2.35; listing (Apple lookup API 2026-09-14): genre Health & Fitness, age 4+, released 2020-10-07, current version 4.3.1 dated 2024-05-15, languages declared EN only; claims 'designed in collaboration with mental health professionals', 'Opportunity to share Insights and achievements with friends', 'The app is free to download. We also offer an optional subscription package'; the US description lists 13 price points from $0.49 to $79.99 (weekly, monthly, quarterly, yearly, with and without 3-day trials) plus a $49.99 one-time unlock; per-storefront listing (verbatim): Storefront | Listing title | Public mean ★ | Ratings ; us | Habio - Daily Habit Tracker | 4.28 | 3,932 ; gb | Habio: Routine & Habit Tracker | 3.68 | 896 ; ca | Habio: Habit Tracker & Planner | 4.04 | 550 ; au | Habio: Habit Tracker & Planner | 3.71 | 407 ; fr | Habio: Habitude et Objectif | 3.05 | 302 ; de | Habio: Tagesplaner. Checkliste | 2.65 | 291 ; mx | Healthy Habits & Goal tracker | 3.31 | 176 ; es | Habio - Daily Habit Tracker | 2.93 | 153

- **Where:** header lines 1-5; §2.1; §2.2 table (verbatim)
- **This app does:** web-quiz funnel; paid trial; workbook upsells
- **User reaction:** mixed
- **Magnitude:** 2,051 reviews; mean 2.35; US public 4.28 on 3,932
- **Direction for us:** none · **Report confidence:** header · **Generalisable:** app-specific
- **Review IDs:** `13944588671`
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Anti-patterns

### R67-020 — Dark patterns, in reviewers' own word: NEG_DARKUX 163 (7.95%, high-priority, mean 1.01, 2023-07-06 → 2025-09-25), used by reviewers who say they work in UX — 'As a UX designer I should have seen the dark patterns from the start'; '환불을 어렵게 만드는 전형적인 다크 패턴' (the classic dark pattern of making refunds hard, kr)

- **Where:** §3.6
- **This app does:** dark patterns
- **User reaction:** 1★-burst
- **Magnitude:** 163 (7.95%) 1.01
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10917895569`, `10576482476`, `10108576912`, `10600303228`, `11528442010`
- **Canonical:** C274 A close or dismiss control must never start a purchase — no fake X, no dismissal that lands on the payment sheet

## Things not to do

### R67-008 — A $29.99 'workbook' is charged from a single tap during sign-up: MON_WORKBOOK 189 (9.22%, high-priority, mean 1.01, 2023-10-15 → 2025-05-04, peak 41 in 2024-04) — a 'download' or 'Get my PDF' button straight after the trial payment, charged against the card just authorised with no second confirmation: 'The consent to charge text is in such a low contrast colour with the background, and such a tiny type size that it hurts my eyes to even read it!'; 'la vérification est demandé donc ils ne la redemande pas ensuite'; MON_DOUBLECHARGE 157 (7.65%) often two workbooks ('adhd_workbook' + 'habits_workbook') from a button that seemed not to respond; support reply pasted verbatim: 'Please note that we do not offer refunds for in-app purchases'; 'At that point I hadn't even downloaded the app HOW on earth could I have made in app purchases ?!'; purchased content not delivered or won't open (BUG_CONTENT 10); §8.2: price on the button, a separate confirmation not the trial's stored authorisation, default 'No thanks', idempotent repeat taps, refund an unopened PDF on request

- **Where:** §0.3; §8.2
- **This app does:** one-tap $29.99 PDF upsell reusing trial authorisation
- **User reaction:** 1★-burst
- **Magnitude:** WORKBOOK 189 (9.22%) 1.01; DOUBLECHARGE 157 (7.65%) 1.08
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10476768777`, `11079433591`, `11359863927`, `11188294921`, `11245047696`, `10844663395`, `10759152490`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request; C274 A close or dismiss control must never start a purchase — no fake X, no dismissal that lands on the payment sheet; C285 Never charge a one-off add-on on a single tap against the authorisation just given for a trial — the add-on shows its price on the button, asks its own confirmation, defaults to 'no thanks' and ignores repeat taps

### R67-009 — Refunds refused and the money-back guarantee: MON_REFUND_DENIED 242 (11.80%, high-priority, mean 1.01, 2022-04-08 → 2026-05-11); MON_MONEYBACK 42 (2.05%) cite the advertised money-back guarantee as not honoured, often with its conditions — 'Money back policy requires that you use the product for 21 days consecutively!'; EU_CONSUMER 10 (0.49%) invoke the EU 14-day right of withdrawal ('by revoking your right to withdraw within 14 days as dictated under EU law'); refunds do happen: MON_REFUND_GIVEN 10 (0.49%, mean 2.80) — 'they refunded the 29.99 USD and kept the 9.99 USD as I sign up for it, so fair enough', 3 of them through a bank or PayPal, not the developer

- **Where:** §3.2 refunds; §8.2
- **This app does:** conditional money-back; refunds refused
- **User reaction:** 1★-burst
- **Magnitude:** REFUND_DENIED 242 (11.80%) 1.01; MONEYBACK 42 (2.05%); EU 10; GIVEN 10 @ 2.80
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10444922266`, `10164682229`, `11351607971`, `8546542410`, `10311381495`, `11484621917`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R67-011 — The ads and the quiz promise things the app does not have: U_AD_MISMATCH 195 (9.51%, high-priority, mean 1.08, 2021-12-30 → 2025-07-10) (verbatim): Code | Meaning | n | % of 2,051 | Band | Mean ★ ; MKT_LANG_BAIT | Ad/quiz in local language, app English-only | 86 | 4.19% | Very strong signal | 1.07 ; MKT_AD_PERSONALITY | Ad/quiz promised personalised report/plan/profile | 31 | 1.51% | Meaningful signal | 1.26 ; MKT_AD_BIONIC | Ad promised bionic / bold-letter reading tool | 22 | 1.07% | Meaningful signal | 1.00 ; MKT_AD_MISLEAD | Ad did not match the product | 99 | 4.83% | Very strong signal | 1.02 — language: every MKT_LANG_BAIT review dated 2024-03-28 or later — ad and quiz in French, Spanish, German, Arabic or Japanese, paid app English-only, while listing titles are localised ('Habio: Tagesplaner. Checkliste', 'Habio: Habitude et Objectif') ('L'ensemble des publicités ansi que les questionnaires avant l'achat sont en français, et l'application n'est dispo qu'en anglais'); a reading tool: Instagram ads showed 'bionic' bold-first-letter reading for ADHD from 2023-07-18 to 2024-09-01 — no such feature ('What a bait and switch!!'); a personalised report: the quiz promised a Myers-Briggs or ADHD profile or tailored plan — 'Nothing like that exists in the app'; of MKT_LANG_BAIT reviewers 34.9% ask for or are refused a refund; §8.5: localise or state 'English only' in every non-English ad, quiz and checkout; withdraw bionic-reading and personality-report creative unless those features ship

- **Where:** §0.4 table (verbatim); §8.5
- **This app does:** ads promise localisation, bionic reading, personality report
- **User reaction:** 1★-burst
- **Magnitude:** U_AD_MISMATCH 195 (9.51%) 1.08; LANG_BAIT 86 (4.19%); PERSONALITY 31 (1.51%); BIONIC 22 (1.07%); MISLEAD 99 (4.83%)
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11225362605`, `10182376089`, `8602506980`, `8185587507`, `10237694854`, `11224233255`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate; C286 Never advertise or sell in a language the app does not ship — a localised ad, quiz or checkout for an English-only app is a refund request waiting to happen

## Things to do

### R67-039 — Keep the store listing and the funnel telling the same story: the listing promises App Store billing and cancellation in Account Settings while web-funnel buyers are billed off-store; titles are localised while the app is English-only; the listing advertises sharing with friends and 'mental health professionals' — §8.1 align the listing text with how web subscriptions are billed and cancelled; §8.5 state 'English only' in every non-English ad, quiz and checkout

- **Where:** §0.2 listing; §8.1; §8.5
- **This app does:** listing ≠ funnel
- **User reaction:** 1★-burst
- **Magnitude:** OFFSTORE 137; LANG_BAIT 86
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10212536465`, `11225362605`
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C286 Never advertise or sell in a language the app does not ship — a localised ad, quiz or checkout for an English-only app is a refund request waiting to happen

## Contradictions

### R67-040 — Two readings of the same small-price trial: reviewers say the low trial price is exactly why they tried ('€5.49 seemed like a reasonable amount to see if the app could fulfil on the promises made in the advertising'), and the same design — a stored authorisation reused for a one-tap $29.99 add-on — produces 189 workbook complaints; a low entry price is a conversion lever and, with reused authorisation, the largest dispute generator

- **Where:** §0.3; §8.2; §0.5
- **This app does:** paid trial + reused authorisation
- **User reaction:** mixed
- **Magnitude:** TRIAL_1DOLLAR 148; WORKBOOK 189
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11079433591`, `11359863927`
- **Canonical:** C109 A free trial must be a real trial; C285 Never charge a one-off add-on on a single tap against the authorisation just given for a trial — the add-on shows its price on the button, asks its own confirmation, defaults to 'no thanks' and ignores repeat taps

## Data caveats and method

### R67-002 — Method and limits: counts non-exclusive; review IDs plus date-order index #1…#2,051; global % on all 2,051 with the non-seeded 1,462 shown beside where the flagged reviews change the picture; read in 21 batches of up to 100 in 19 languages, each line re-asserted against the corpus after every batch (zero drift, one mistyped ID caught); 765 validation checks, 0 fail; the build refuses to write if any quotation is not verbatim; no number typed by hand; files (verbatim) File | Role | Records ; App Store Reviews/67. Habio - Daily Habit Tracker - Routine planner & To do list/reviews.jsonl | the corpus; every claim resolves here | 2,051 ; by_country/*.jsonl | 81 per-storefront files | 2,051 (union) ; manifest.json | extraction metadata, per-country counts, rating distribution | — ; _state.json | collection state per polled storefront | — ; Apple iTunes Lookup API (external, 2026-09-14) | public rating, listing text, prices, languages, current version | 8 storefronts; schema (verbatim) Field | Used for | Notes ; review_id | primary key | 2,051 distinct; zero duplicates ; country, country_name | §6 | 81 storefronts ; rating | §4 | integers 1–5 only ; title, body | read in full for every record | ; author | authenticity tests only (§9.H) | zero repeat (country, author) pairs; 5 names on two storefronts ; date | §7 | 2020-10-18 → 2026-07-30 ; vote_count, vote_sum | §9.H | 259 reviews have votes; max 16 ; is_edited | §9.H | 38 edited ; app_id, app_name | constant (1517360968, Habio - Daily Habit Tracker) |; reconciliation: 2,051 distinct IDs, 0 duplicates, 81 country files match, manifest distribution {1: 1295, 2: 44, 3: 25, 4: 77, 5: 610}, mean 2.3481, 153 storefronts probed all complete, 38 edited, 259 with votes (max 16), 5 author names on two storefronts; signal bands (verbatim) Share of reviews | Label ; < 0.1% | Ignore by default ; 0.1% – < 0.5% | Weak signal ; 0.5% – < 1% | Emerging signal ; 1% – < 3% | Meaningful signal ; 3% – 5% | Very strong signal ; > 5% | High-priority signal; bimodal — 1,295 1★ (63.14%), 610 5★ (29.74%), 146 in between (7.12%), so 'A mean of 2.35★ describes almost nobody'; charges are the reviewer's account — recurrence across 81 storefronts and 19 languages gives weight; concentrated in E4 (58.41%), E5 only 22; storefront is not nationality (178 English reviews on de/fr/es/pl/ru/br/ae/sa); no conversion, revenue or refund rate derivable; apps.apple.com returned an empty page — listing facts from the lookup API only; not present: version per review, purchase records, developer responses, device

- **Where:** How to read this; Nine warnings 2, 4, 6, 8, 9; §1.1 table (verbatim); §1.2 table (verbatim); §1.3; §1.4; §1.5 table (verbatim); §1.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2,051 read; 765 checks; 7 eligible storefronts
- **Direction for us:** research · **Report confidence:** method · **Generalisable:** generalisable
- **Review IDs:** `11376403157`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R67-003 — This corpus is not the app's rating: corpus mean 2.35 vs US public 4.28 from 3,932 ratings (lookup API 2026-09-14); public means by storefront us 4.28 (3,932), gb 3.68 (896), ca 4.04 (550), au 3.71 (407), fr 3.05 (302), de 2.65 (291), mx 3.31 (176), es 2.93 (153) — the US, where the flagged 5★ wave landed, carries the highest public rating; 'neither is the truth'

- **Where:** Warning 1; §2.2; §6.3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2.35 vs 4.28
- **Direction for us:** research · **Report confidence:** high · **Generalisable:** generalisable
- **Review IDs:** `10210418380`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R67-022 — Rating distribution with and without the flagged group (verbatim): ★ | All | % of 2,051 | Flagged SUS_SEED | Non-seeded | % of non-seeded ; 5 | 610 | 29.74% | 540 | 70 | 4.79% ; 4 | 77 | 3.75% | 48 | 29 | 1.98% ; 3 | 25 | 1.22% | 0 | 25 | 1.71% ; 2 | 44 | 2.15% | 1 | 43 | 2.94% ; 1 | 1,295 | 63.14% | 0 | 1,295 | 88.58% ; mean | 2.35 |  | 4.91 | 1.31 | — without the flagged group 88.58% are 1★; 5★ themes (verbatim) Code | Meaning | n | % of 5★ reviews | Band ; PR_DESIGN | Design / interface praised | 117 | 19.18% | High-priority signal ; PR_SIMPLE | Easy to use / simple | 108 | 17.70% | High-priority signal ; PR_GENERIC | Generic praise | 99 | 16.23% | High-priority signal ; PR_MOTIVATION | Motivating | 79 | 12.95% | High-priority signal ; PR_OUTCOME | Reports a real outcome / habit built | 68 | 11.15% | High-priority signal ; PR_STATS | Progress tracking / analytics | 64 | 10.49% | High-priority signal ; PR_CONTENT | Articles / courses / quotes / insights | 48 | 7.87% | High-priority signal ; PR_CUSTOM | Customisable / unlimited habits | 47 | 7.70% | High-priority signal ; PR_NOTIF | Reminders praised | 43 | 7.05% | High-priority signal ; PR_JOURNAL | Journal / daily reflection praised | 40 | 6.56% | High-priority signal — flagged 5★ praise design, ease, motivation, stats 'in brochure language'; the 70 non-seeded 5★ are largely free-era (26 in E1): 'Let's you have as many habits you want for free'; 'a super useful addition to my adhd treatment plan'; 4★ themes (verbatim) Code | Meaning | n | % of 4★ reviews | Band ; PR_GENERIC | Generic praise | 18 | 23.38% | High-priority signal ; PR_DESIGN | Design / interface praised | 13 | 16.88% | High-priority signal ; PR_SIMPLE | Easy to use / simple | 9 | 11.69% | High-priority signal ; REQ_LANG | Wants other languages | 9 | 11.69% | High-priority signal ; PR_CONTENT | Articles / courses / quotes / insights | 7 | 9.09% | High-priority signal ; PR_MOTIVATION | Motivating | 5 | 6.49% | High-priority signal ; PR_STATS | Progress tracking / analytics | 5 | 6.49% | High-priority signal ; PR_BEST | Best tracker / better than others | 5 | 6.49% | High-priority signal ; PR_JOURNAL | Journal / daily reflection praised | 5 | 6.49% | High-priority signal ; PR_FEATURES | Feature set praised | 5 | 6.49% | High-priority signal — non-seeded 4★ are 'good, but': language ('Nur wie kann ich die App auf deutsch umstellen?'), customisation, a pop-up ('I just wish it was voluntary')

- **Where:** §4.1 table (verbatim); §4.2 5★ table (verbatim); §4.2 4★ table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★ 610 (540 flagged); non-seeded 1★ 88.58%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `6953400305`, `9078274916`, `11830254915`, `7766810111`
- **Canonical:** C027 Localise early — it unlocks revenue; C061 Goodwill conversion — a generous free tier and 'support the devs'; C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R67-023 — 3★ (verbatim) Code | Meaning | n | % of 3★ reviews | Band ; PR_DESIGN | Design / interface praised | 7 | 28.00% | High-priority signal ; REQ_LANG | Wants other languages | 4 | 16.00% | High-priority signal ; MON_DOUBLECHARGE | Multiple / duplicate charges | 4 | 16.00% | High-priority signal ; MON_TRIAL_1DOLLAR | Paid 'trial' (~$1 / €1 / £1 / $5–$10) | 3 | 12.00% | High-priority signal ; REQ_CUSTOM_ROUTINE | Wants editable / own routines, more customisation | 3 | 12.00% | High-priority signal ; PR_CONCEPT | Likes the idea (but…) | 3 | 12.00% | High-priority signal ; NEG_COMPLEX | Overwhelming / confusing | 3 | 12.00% | High-priority signal ; MON_FREE_LIMIT | Free tier too limited | 2 | 8.00% | High-priority signal ; MON_TRIAL | Trial mentioned | 2 | 8.00% | High-priority signal ; BUG_GENERIC | Doesn't work (unspecified) | 2 | 8.00% | High-priority signal — liked the look, blocked by language, pricing or a charge later partly fixed; 2★ (verbatim) Code | Meaning | n | % of 2★ reviews | Band ; REQ_LANG | Wants other languages | 7 | 15.91% | High-priority signal ; MON_HARDWALL | Hard paywall — nothing usable without paying | 5 | 11.36% | High-priority signal ; PR_CONCEPT | Likes the idea (but…) | 5 | 11.36% | High-priority signal ; NEG_UX | Clunky / poor UX | 4 | 9.09% | High-priority signal ; NEG_COMPLEX | Overwhelming / confusing | 4 | 9.09% | High-priority signal ; BUG_ONBOARD_STUCK | Stuck in onboarding / cannot proceed | 4 | 9.09% | High-priority signal ; REQ_HELP | Needs instructions / guidance | 4 | 9.09% | High-priority signal ; PR_DESIGN | Design / interface praised | 4 | 9.09% | High-priority signal ; BUG_GENERIC | Doesn't work (unspecified) | 3 | 6.82% | High-priority signal ; MON_EXPENSIVE | Too expensive / not worth price | 3 | 6.82% | High-priority signal — 'I only have 3 days free'; 'UI is top notch but UX is bad'; 1★ (verbatim) Code | Meaning | n | % of 1★ reviews | Band ; ACC_SCAM | Calls the app a scam / fraud / theft | 680 | 52.51% | High-priority signal ; MON_CANCEL | Cannot cancel / cancellation hard | 358 | 27.64% | High-priority signal ; MON_CHARGED_AFTER | Charged after cancelling / deleting | 346 | 26.72% | High-priority signal ; MON_REFUND_DENIED | Refund refused | 240 | 18.53% | High-priority signal ; SUP_NONE | No response from support | 211 | 16.29% | High-priority signal ; MON_WORKBOOK | Workbook / PDF / report upsell charge | 188 | 14.52% | High-priority signal ; MON_TRIAL_CHARGE | Trial converted to full charge unexpectedly | 170 | 13.13% | High-priority signal ; NEG_DARKUX | Describes dark patterns / deliberate trickery | 162 | 12.51% | High-priority signal ; MON_CHARGED_NOSUB | Charged with no subscription / without authorisation | 162 | 12.51% | High-priority signal ; MON_DOUBLECHARGE | Multiple / duplicate charges | 152 | 11.74% | High-priority signal — U_BILLING_HARM 863 of 1,295 (66.64%), U_CANCEL_TRAP 590 (45.56%), ACC_SCAM 680 (52.51%); median 1★ body 205 characters vs 96 for non-seeded 5★ — 'detailed accounts, not drive-by ratings'; contradictions CONTRA_RATING 8 (0.39%), CONTRA_TEXT 2, CONTRA_DISSENT 1 (the one reviewer disputing the scam consensus) — kept and counted by text

- **Where:** §4.2 3★, 2★, 1★ tables (verbatim); §4.3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 1★ 1,295: billing 66.64%, scam 52.51%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11134808726`, `8477793577`, `7189146685`, `8311453620`, `12178729000`, `12167792091`, `11304376291`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R67-037 — Sensitivity — does one episode drive the conclusions (verbatim): Headline share | All 2,051 | Non-seeded | Excluding E3 | Excluding E4 | Excluding E3 and E4 ; U_BILLING_HARM | 42.8% | 60.1% | 32.7% | 54.0% | 23.5% ; U_CANCEL_TRAP | 29.1% | 40.8% | 21.0% | 41.3% | 23.1% ; U_SUPPORT_FAIL | 20.7% | 29.1% | 15.1% | 28.7% | 15.7% ; ACC_SCAM | 33.3% | 46.6% | 26.2% | 39.4% | 14.9% ; U_AD_MISMATCH | 9.5% | 13.2% | 9.3% | 8.2% | 4.6% ; U_PRAISE_ANY | 32.6% | 8.4% | 43.4% | 12.4% | 28.5% — billing harm stays high-priority under every exclusion; the positive share is the number that moves — it depends almost entirely on the flagged E4 reviews; persisted: cancellation and charges after cancelling (2022-02-24 → 2025-09-25), language requests E1 (6) → E5 (2) — 'The ads made it worse; they did not create it', and liking the look while leaving

- **Where:** §7.6 table (verbatim); §7.5
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** billing harm 23.5%–60.1% under exclusions; praise 8.4%–43.4%
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `7084404117`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C027 Localise early — it unlocks revenue

### R67-038 — Research questions the corpus cannot answer: (1) what share of customers is charged after cancelling, and the chargeback rate by channel (web vs App Store); (2) what share of workbook purchases are refunded, disputed or never opened; (3) rating and retention of in-app vs web-funnel buyers; (4) what genuinely retained subscribers value — too few non-flagged positive reviews to say; (5) the ad creatives and languages by market and month, to confirm the timing; also not establishable: the in-app vs web purchase split, whether the workbook screen changed (complaints collapse after 2024-09 while volume also falls), the price actually charged

- **Where:** §8.12 #1–#5; part 8 #1; part 8 #2; part 8 #3; part 8 #4; part 8 #5; §2.4; §5.7
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** research · **Generalisable:** generalisable
- **Review IDs:** `11304376291`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings
