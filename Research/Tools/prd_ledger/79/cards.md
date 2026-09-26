# Cards — report 79

Source: `App Store Reports/79. Habit Tracker - Ripples - Routines, streaks, reminders (REPORT).md`  
75 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 3
- [Must-haves](#must-haves) — 3
- [Must never break](#must-never-break) — 7
- [Features](#features) — 7
- [Monetization](#monetization) — 7
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 7
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 5
- [Dated events and trends](#dated-events-and-trends) — 11
- [Positioning](#positioning) — 5
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 2
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 11

## Product rules

### R79-017 — The eight decisions this corpus supports: 1) fix purchase delivery before anything else (4 of 11 1★, 33% of stated payers, 1.00★, corroborated by v2.7.0); 2) write the monetization paragraph the description lacks; 3) a billing period on every SKU, three names to one; 4) reconsider gating the widget (27 praise at 5.00★, none negative, three complain it is paid); 5) decide and say whether this is a subscription product (12 chose it because it was not); 6) treat post-v2.1.0 reliability as a regression (0.9% → 19.5%, three data-loss reports); 7) ship the Watch app or say it is not coming (three voices, two withholding a star); 8) turn off or throttle the in-app review prompt (two 1★ from people who say the app is good).

- **Where:** §0.12 #1, #2, #3, #4, #5, #6, #7, #8; §8.8
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** see §0
- **Direction for us:** product-rule · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `13582314702`, `14422900213`, `13311025859`, `13628057308`, `13728350332`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C009 Basic widgets, icons and colours are free; C022 Apple Watch app (done properly: timer, two-way sync); C033 Restore purchase and entitlements must work immediately; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C175 Updates must not break function or wipe progress; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R79-066 — §8.4.1 reconsider gating the widget — 27 reviews at 5.00★ with zero negative mentions, the only feature with a perfect record; two complain it is now paid, one in the app's angriest review; a third proposes the compromise — 'make 2 widgets available in free version, one the bigger one and one the minimalist one'; 'A widget on a home screen is a daily impression of the product; removing it from the free tier removes the strongest retention and word-of-mouth surface the app has, in exchange for pressure on a cap that was already working' (the one explicit upgrade was for more boards, not widgets); §8.6 E1: free tier with widgets + 3-board cap vs current, measuring trial→paid and D30 retention.

- **Where:** §8.4.1; §8.6 #1; §8.8 #3; part 8 #4
- **This app does:** widget moved behind the wall ~Oct 2025
- **User reaction:** complaint
- **Magnitude:** PRAISE_WIDGET 27 / 5.00★; WIDGET_GATED 2; cap upgrade 1
- **Direction for us:** build-free · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `13311025859`, `14373214557`, `14201744091`, `12712143678`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free; C297 A free cap's acceptability is set by the bundle around it — the same number reads as generous or as a wall depending on what else is free; moving a loved feature behind the wall changes sentiment as much as changing the number

### R79-067 — §8.4.2 decide whether this is a subscription product, then say so plainly — 12 reviews (6.98%, 4.67★) chose it because it was not, including the only 'used to be great' review which lists the absent subscription among what it lost; if the subscription stays, the Lifetime SKU must be prominent enough that the original promise is visibly honoured; if it goes, say so; 'the current state — five SKUs, three names, no periods, no description text — is the worst of both'; §8.6 E5 lifetime-forward paywall: show Lifetime first, subscription second, measure whether the 'no subscription' audience converts higher.

- **Where:** §8.4.2; §8.6 #5; part 8 #6
- **This app does:** subscription added beside lifetime, undeclared
- **User reaction:** churn
- **Magnitude:** ONETIME_PRAISE 12 / 4.67★; SUB_OBJECTION 2
- **Direction for us:** product-rule · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `13836767975`, `13681657252`, `14483046633`, `13106720476`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

## Must-haves

### R79-011 — The store listing says nothing about money at all: five headed sections (SEE THE PATTERN, TRACK MORE THAN CHECKMARKS, STAY CONSISTENT WITH LESS FRICTION, UNDERSTAND YOUR PROGRESS, PRIVATE BY DESIGN) and no monetization paragraph — no free-tier limit, no Plus, no subscription, no price; the IAP box lists five SKUs under three product names with no billing period shown (verbatim): SKU, as the listing names it | Price | Billing period shown ; Powerpack | $9.99 | none ; Ripples Plus Lifetime | $24.99 | none ; Plus Monthly | $2.99 | none ; Plus Yearly | $9.99 | none ; Powerpack Family | $17.99 | none — reviewers reach for whatever vocabulary is at hand (verbatim): Review | Date | What it calls the paid tier ; 11575210211 | 2024-08-05 | "the premium subscription is a one time 10 dollar payment" ; 11545582822 | 2024-07-28 | "eyes on the power pack" ; 12071906839 | 2024-12-17 | "придбав Powerpack" ; 12104500362 | 2024-12-25 | "$10 for a lifetime subscription" ; 12759315641 | 2025-06-10 | "Чекер+ был куплен в тот же день" ; 13426922120 | 2025-11-22 | "17,99€ … für die Plus-Version (da einmalkauf)" ; 13669961043 | 2026-01-24 | "plan to purchase a subscription" ; 13854797898 | 2026-03-16 | "die Vollversion" ; 14483046633 | 2026-08-28 | "a monthly subscription" — nine reviews, six names, two incompatible billing models ('the premium subscription… a one time 10 dollar payment'; '$10 for a lifetime subscription'); MON_BAIT_SWITCH 1 ('Just charge for the download instead of the bait and switch'); MON_UNEXPECTED 2 (2.00★): the surprise, not the amount, is the complaint ('after a while it turns out I have to pay').

- **Where:** §0.8; §0.12 #2; §0.12 #3; §2.4; §2.4 table (verbatim); §2.3 table (verbatim); §8.1
- **This app does:** no monetization text; 5 SKUs / 3 names / no periods
- **User reaction:** blocked-conversion
- **Magnitude:** MON_UNEXPECTED 2 / 2.00★; MON_BAIT_SWITCH 1; 6 names in 9 reviews
- **Direction for us:** must-have · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `11575210211`, `12104500362`, `14422900213`, `14483046633`, `11545582822`, `12071906839`, `12759315641`, `13426922120`, `13669961043`, `13854797898`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C236 A free-tier limit must announce itself before the user invests — at install, at setup and at the wall — never silently stop a visible progress signal

### R79-015 — A pure information failure: a 2026-07-05 review asks for 'cloud sync, so data can be backed up and synchronized across devices' — a feature shipped since at least 2024-10-14 ('thanks for sync with iCloud'), confirmed by two more, and a headed section of the description; someone read the listing and still did not learn iCloud sync exists.

- **Where:** §0.10 (sync information failure)
- **This app does:** iCloud sync exists, undiscovered
- **User reaction:** complaint
- **Magnitude:** n=1 request for a shipped feature
- **Direction for us:** must-have · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `14264852300`, `11832301736`, `12476173581`, `13910121511`
- **Canonical:** C142 Surface existing features where users look

### R79-063 — §8.1.2 write the monetization paragraph the description does not have — four sentences: what the free tier includes, that the board limit is three, what Plus adds, and that both a subscription and a one-time option exist — 'the cheapest high-value change in the report'; §8.1.3 a billing period on every SKU and collapse three product names to one — 'A customer who cannot tell whether they are buying a subscription cannot consent to buying one.'

- **Where:** §8.1.2; §8.1.3; §8.8 #2; part 8 #2
- **This app does:** no monetization text; 5 SKUs / 3 names / no periods
- **User reaction:** blocked-conversion
- **Magnitude:** paywall_shape 6 (all after Oct 2025); UNEXPECTED 2; 6 names in 9 reviews
- **Direction for us:** must-have · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Review IDs:** `14422900213`, `14483046633`, `11575210211`, `12104500362`
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C236 A free-tier limit must announce itself before the user invests — at install, at setup and at the wall — never silently stop a visible progress signal

## Must never break

### R79-009 — The one-star reviews are not about the price — 11 1★ by cause (verbatim): Cause | n | Reviews ; Paid, and the purchase did not work | 4 | 11921754194, 12352054623, 13582314702, 14192253561 ; Data or boards lost | 2 | 14173657564, 14293610339 ; The in-app review prompt | 2 | 13728350332, 14173657564 (overlaps) ; A defect (crash / UI) | 2 | 13767244783, 13836767975 ; Paywall shape / price | 2 | 13311025859, 14422900213 — only 2 of 11 are about what the app charges; four are from people who gave the developer money and did not get the product: 'I paid for the pro features but still features are not unlocked. Restore purchase is also not working'; a promotional free-lifetime entitlement that could not be redeemed; 'Lifetime purchase doesn't work. Restore purchases doesn't work. Developer doesn't respond.'; title 'Estafa' (scam) — 'Pagué por la versión premium pero no puedo usarla en mis dos celulares'. MON_ENTITLEMENT_FAIL 3 (1.74%) globally but 3 of 9 stated payers (33.3%), every one 1★ (mean 1.00★); corroborated by the developer's v2.7.0 note (2026-09-03): 'Fixed an issue where Ripples+ features would sometimes become locked while the device was offline' — a delivery failure, not a pricing disagreement; the only complaint class with a 1.00★ mean.

- **Where:** §0.6; §0.6 table (verbatim); §0.12 #1; §8.1
- **This app does:** entitlements lock offline; restore fails; no multi-device
- **User reaction:** 1★-burst
- **Magnitude:** 4 of 11 1★; MON_ENTITLEMENT_FAIL 3 / 1.74% / 33.3% of payers / 1.00★
- **Direction for us:** must-never-break · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `11921754194`, `12352054623`, `13582314702`, `14192253561`, `14173657564`, `14293610339`, `13728350332`, `13767244783`, `13836767975`, `13311025859`, `14422900213`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C139 Cache entitlements locally — never block a paid surface on a live server check; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R79-031 — N2 purchases that do not deliver — U:paid_broken 4 (2.33%), mean 1.00★, the only theme where every review is one star: MON_ENTITLEMENT_FAIL 3 + MON_PROMO_FAIL 1 (an AppAdvice lifetime promo that could not be redeemed); 3 of 9 stated payers (33.3%); corroborated by v2.7.0 'Ripples+ features would sometimes become locked while the device was offline'.

- **Where:** §3.4 N2
- **This app does:** entitlement locks offline; promo codes fail; restore fails
- **User reaction:** 1★-burst
- **Magnitude:** paid_broken 4 / 1.00★; 33.3% of payers
- **Direction for us:** must-never-break · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `11921754194`, `13582314702`, `14192253561`, `12352054623`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C089 Promos, giveaways and gift codes must work exactly as advertised; C139 Cache entitlements locally — never block a paid surface on a live server check

### R79-032 — N4 defects U:defect_any 9 (5.23%, 2.67★) — 3 data loss, 2 notifications, 1 crash, 1 UI bug, 1 reorder, 1 check-in spam; 8 of 9 after 2026-02-11. N5 the in-app review prompt UX_NAG_REVIEW 2, both 1★, both saying the app is good — 18.2% of the worst ratings, 'cheapest fix in this report'. N6 friction U:friction_any 7 (2.57★): onboarding ('I can't find any directions on what to do' — v2.3.1 later 'Simplified onboarding'), bulk entry ('If I want to add 10 check-ins to a previous day it's very painful!', a 5★ whose whole body is the complaint), list scale 2 (users with many boards), SUP_NO_RESPONSE 1.

- **Where:** §3.4 N4; §3.4 N5; §3.4 N6
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** defect_any 9 / 2.67★; NAG_REVIEW 2 / 1.00★; friction 7 / 2.57★; LIST_SCALE 2
- **Direction for us:** must-never-break · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `13728350332`, `14173657564`, `12352054623`, `13066418808`, `14162555466`, `14501661045`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in; C083 Performance must not degrade with habit count; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C175 Updates must not break function or wipe progress; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R79-043 — One-star register (verbatim): # | ID | Store | Date | Codes | What it says ; 35 | 11921754194 | in | 2024-11-07 | MON_PAID, MON_ENTITLEMENT_FAIL | Pro features are not coming even after purchasing — I paid for the pro features but still features are not unlocked. Restore purchase is also not work ; 70 | 12352054623 | us | 2025-02-25 | UX_ONBOARDING, CH_GIVEAWAY, MON_PROMO_FAIL | How do you use this app? — I can't find any directions on what to do.  Also, today we are supposed to be able to get the lifetime version free through ; 117 | 13311025859 | sk | 2025-10-25 | MON_PAYWALL_BLOCKS, MON_WIDGET_GATED, MON_PRICE_LEVEL, MON_DECLINED_PURCHASE, COMP_SWITCH_AWAY, CHURN_ABANDON | Useless without paying 18€ — Useless if you dont pay, can even put a single widget!! 18€ is way too much for a tracker lmao, pc games cost less than t ; 124 | 13582314702 | us | 2026-01-01 | MON_PAID, MON_ENTITLEMENT_FAIL, SUP_NO_RESPONSE | Lifetime purchase doesn’t work — Restore purchases doesn’t work. Developer doesn’t respond. Waste of time. ; 131 | 13728350332 | us | 2026-02-08 | UX_NAG_REVIEW, INT_RATING_CONTRADICT | Great app but knock off the obnoxious popups — Great app, but I always leave one star reviews for apps that harass me with "enjoying the app? Please l ; 135 | 13767244783 | ua | 2026-02-19 | DEF_CRASH | Не працює — На Створити дошку вибиває програму ; 138 | 13836767975 | us | 2026-03-11 | DEF_UI_BUG, MON_ONETIME_PRAISE, OUT_DAILY_USE, PRAISE_EASE, CHURN_ABANDON | Used to be great — This app became an essential part of my daily routine and it was great. I loved how easy it was to use, how reliable it was, and th ; 152 | 14173657564 | ph | 2026-06-12 | DEF_DATA_LOSS, MON_REFUND_THREAT, MON_PAID, UX_NAG_REVIEW, INT_RATING_CONTRADICT | All data gone after updating to ios 18.4 — I’ll refund my subscription if this doesn’t get fixed soon.  Edit: after a day seems like icloud sync fixed ; 155 | 14192253561 | us | 2026-06-17 | MON_PAID, MON_ENTITLEMENT_FAIL | Estafa — Pague por la versión premium pero no puedo usarla en mis dos celulares ; 164 | 14293610339 | es | 2026-07-12 | DEF_DATA_LOSS | Borrado de datos — Han borrado los datos previos de antes del cambio de nombre ; 169 | 14422900213 | us | 2026-08-13 | MON_PAYWALL_BLOCKS, MON_BAIT_SWITCH, MON_UNEXPECTED | No part of the app is free — You’re not able to use the app whatsoever for free. Payment is required. Just charge for the download instead of the bait — 4 paid and did not get the product (36.4% of the band), 2 lost data, 2 driven there by the review prompt, 2 hit a defect, 2 object to the paywall — 'Only 2 of 11 are a pricing disagreement. 6 of 11 are a promise not kept — a purchase, a data set, or a stable build'; 6 of 11 on the US storefront (54.5% vs 22.1% of corpus, not claimed as a market finding); 2 one-stars in the first 15 months, 9 in the last 11.

- **Where:** §4.7 table (verbatim); §4.7
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1★ n=11: paid-broken 4, data 2, prompt 2, defect 2, price 2; 9 of 11 in last 11 months
- **Direction for us:** must-never-break · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11921754194`, `12352054623`, `13311025859`, `13582314702`, `13728350332`, `13767244783`, `13836767975`, `14173657564`, `14192253561`, `14293610339`, `14422900213`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C033 Restore purchase and entitlements must work immediately; C034 Data must never be lost on update, reinstall or phone change; C065 Paying customers are the highest 1★ risk — every paid feature must work; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R79-057 — T3 defects went from zero to a fifth of the corpus — 8 of 9 after v2.1.0 (2026-02-11), whose notes warn widgets and shortcuts must be re-created, followed within four days by v2.1.1/2.1.2 adding a 'Deduplicate data' tool 'as some people reported duplicated boards and check-ins'; sub-classes traceable: crash fixed by name 11 days later; UI bugs one month after the overhaul; notifications — two complaints five and six weeks after v2.2.0 shipped multiple reminders ('a feature three reviewers asked for in 2024 shipped and then generated two reliability complaints'); data loss ×3, the last matching v2.6.2's stability fix for year-old builds; causation not claimed, coincidence tight and corroborated. Priority queue (verbatim): Priority | Defect | Evidence | Note ; 1 | Data / board loss | 14173657564, 14293610339, 14397430419 | For a habit tracker the record *is* the product. One user attributes the loss to the rename; one recovered via iCloud; one is asking for boards back. ; 2 | Notification reliability | 13929651995 (3★), 13962890919 (4★) | Both after v2.2.0 shipped reminders. 13962890919 ends "maybe is a bug I would like a anwser". ; 3 | Board reordering / layout freeze | 14501661045 (5★, 2026-09-02) | Reported after the v2.4.2/v2.5.0 drag-and-drop rework, by the corpus's final reviewer. ; 4 | Crash on board creation | 13767244783 | Already fixed in v2.2.0 — listed to close the loop, not to reopen it. — §8.2.2 give a recovery path for lost boards and say so publicly ('Is there anyway I can get them back? I had a nice streak going', 4★); an archive/restore feature shipped in v2.3.0 and nothing suggests users know it exists.

- **Where:** §7.4; §8.2.1 table (verbatim); §8.2.1; §8.2.2
- **This app does:** major internal overhaul shipped with a migration side-effect
- **User reaction:** 1★-burst
- **Magnitude:** defect_any 0.9% → 19.5% (2.50★); data loss 3; notifications 2 post-reminders
- **Direction for us:** must-never-break · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Side effects:** a newly shipped requested feature (reminders) generated its own defect class
- **Review IDs:** `13767244783`, `13836767975`, `13929651995`, `13962890919`, `14173657564`, `14293610339`, `14397430419`, `14501661045`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C039 Reminders fire reliably, once; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C142 Surface existing features where users look; C175 Updates must not break function or wipe progress

### R79-062 — §8.1.1 make the purchase work and make restore work — 4 of 11 1★, mean 1.00★, 33.3% of stated payers, 2024-11 → 2026-06 (a recurring class, not one build): entitlement not applied after payment, restore failing, a paid entitlement unusable on a second device; the v2.7.0 note confirms the class ('Ripples+ features would sometimes become locked while the device was offline'); add an in-app 'my purchases' state showing what is owned and when it was verified, an offline grace period for verified entitlements, and a visible support path from the failure screen; 'Developer doesn't respond' in a public 1★ is the worst outcome available.

- **Where:** §8.1.1; §8.8 #1; part 8 #1
- **This app does:** entitlement lock offline; no multi-device; restore broken
- **User reaction:** 1★-burst
- **Magnitude:** 4 / 1.00★ / 33.3% of payers
- **Direction for us:** must-never-break · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11921754194`, `13582314702`, `14192253561`, `12352054623`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C139 Cache entitlements locally — never block a paid surface on a live server check; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R79-072 — A paid entitlement must work on every device the buyer owns: 'Estafa — Pagué por la versión premium pero no puedo usarla en mis dos celulares' (1★); a Family SKU exists yet no review mentions Family Sharing.

- **Where:** §0.6; §8.1.1 (multi-device)
- **This app does:** entitlement not usable on a second device
- **User reaction:** 1★-burst
- **Magnitude:** n=1, 1★
- **Direction for us:** must-never-break · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Review IDs:** `14192253561`
- **Canonical:** C037 Family plan; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

## Features

### R79-013 — Requests: 30 reviews (17.44%, 4.73★) over 22 codes, 9 voiced by ≥2; repeated still-unshipped asks (verbatim): Ask | Voices | Reviews | Status ; Apple Watch app | 3 | 12110523017, 13628057308, 14162555466 | Not shipped — listing is iPhone-only ; Weekly / flexible scheduling | 3 | 11859903290, 13910121511, 14272948959 | Partial only ; iPad version | 2 | 14089348287, 14264852300 | Not shipped — listing is iPhone-only ; Data import / migration | 2 | 13619259448, 14501661045 | Not shipped ; Negative / inverse boards | 2 | 12537644066, 14501661045 | Not shipped — two carry an explicit rating consequence: 'Watch-App fehlt… Bitte ganz nach oben auf die Prioritätenliste!!!! (dann gibt's auch ✱✱✱✱✱)' (4★); 'Wenn ich einzelne Tage skippen könnte, oder ein Wochenziel festlegen… Das wäre der 5. Stern für mich' (4★); the residue is structural (a second platform) rather than incremental.

- **Where:** §0.10; §0.10 table (verbatim); §0.12 #7; §8.3
- **This app does:** iPhone-only; no Watch; day-based scheduling
- **User reaction:** complaint
- **Magnitude:** Watch 3; flexible scheduling 3; iPad 2; import 2; negative boards 2
- **Direction for us:** must-have · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `12110523017`, `13628057308`, `14162555466`, `11859903290`, `13910121511`, `14272948959`, `14089348287`, `14264852300`, `13619259448`, `12537644066`
- **Canonical:** C019 Quit-habit / bad-habit mode; C020 Data export / backup / CSV; C022 Apple Watch app (done properly: timer, two-way sync); C025 Scholarship / hardship / discount program; C043 Flexible / custom frequency; C141 Native iPad layout

### R79-025 — P3 widgets — PRAISE_WIDGET 27 (15.70%, CI 11.0–21.9%), mean 5.00★, not one below 5 — the only substantial feature with a perfect record; described as the thing that makes the habit stick: 'Widgets work effectively without needing to go back into the app'; 'The widgets are a game changer'; 'thanks to the widgets, I was able to easily keep a track of my study habits'; interactive, stackable ('Put all your habits in a stack').

- **Where:** §3.3 P3
- **This app does:** interactive stackable widgets; free until ~mid-2025, then paid
- **User reaction:** praise
- **Magnitude:** 27 / 15.70% / 5.00★
- **Direction for us:** build-free · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11591471612`, `11982688969`, `12712143678`, `13148701785`, `12226286073`, `11574414290`, `12641159776`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free

### R79-035 — Request backlog against the version history (verbatim): Request | Voices | Review # | Dates | Mean ★ | Status against the version history ; REQ_WIDGET_MORE | 5 | 12, 49, 58, 60, 65 | 2024-08-08, 2024-12-25, 2025-01-06, 2025-01-16, 2025-01-22 | 5.00 | shipped v2.5.0 (2026-05-29) ; REQ_REMINDERS | 3 | 4, 21, 25 | 2024-07-30, 2024-08-28, 2024-09-18 | 5.00 | shipped v2.2.0 (2026-03-01) ; REQ_WATCH | 3 | 54, 127, 151 | 2024-12-27, 2026-01-13, 2026-06-09 | 4.33 | not shipped — listing is iPhone-only ; REQ_WEEKLY_SCHEDULE | 3 | 34, 141, 161 | 2024-10-21, 2026-04-01, 2026-07-07 | 4.67 | partial — v2.4.0 lets you disable streak/consistency; no weekly target ; REQ_IMPORT | 2 | 126, 172 | 2026-01-11, 2026-09-02 | 5.00 | not shipped ; REQ_IPAD | 2 | 147, 160 | 2026-05-21, 2026-07-05 | 5.00 | not shipped — listing is iPhone-only ; REQ_NEGATIVE_HABIT | 2 | 80, 172 | 2025-04-13, 2026-09-02 | 5.00 | not shipped ; REQ_NOTES | 2 | 15, 27 | 2024-08-12, 2024-09-25 | 5.00 | shipped v1.9.0 (2025-08-14) ; REQ_SYNC | 2 | 4, 160 | 2024-07-30, 2026-07-05 | 5.00 | already shipped before both requests ; REQ_ANNUAL_VIEW | 1 | 128 | 2026-01-24 | 5.00 | partial — v2.7.0 (2026-09-03), one day after the corpus ends ; REQ_BEDTIME | 1 | 29 | 2024-10-13 | 5.00 | not shipped ; REQ_CATEGORIES | 1 | 151 | 2026-06-09 | 4.00 | not shipped ; REQ_DAY_START | 1 | 34 | 2024-10-21 | 5.00 | shipped v2.4.0 (2026-04-27) ; REQ_HEALTH | 1 | 100 | 2025-07-03 | 4.00 | not shipped ; REQ_ICONS_COLORS | 1 | 146 | 2026-05-10 | 5.00 | partial — v2.0.1 added board icons ; REQ_MULTIBOARD | 1 | 45 | 2024-12-17 | 5.00 | shipped v2.5.0 (2026-05-29) ; REQ_PHOTO | 1 | 151 | 2026-06-09 | 4.00 | not shipped ; REQ_RELATIVE_DATES | 1 | 151 | 2026-06-09 | 4.00 | not shipped ; REQ_REORDER | 1 | 159 | 2026-07-01 | 4.00 | shipped v2.4.2/v2.5.0 — still reported broken by #172 ; REQ_ROADMAP_FASTER | 1 | 121 | 2025-12-09 | 3.00 | generic ; REQ_STREAK_SHARE | 1 | 41 | 2024-11-25 | 5.00 | not shipped ; REQ_UNDO_CHECKIN | 1 | 75 | 2025-03-28 | 4.00 | partial — v2.0.1 restored the check-in configurator — 22 requests across 30 reviews (17.44%, mean 4.73★ — from satisfied users, so the backlog is retention work); the shipped rate on incremental asks is high (notes, reminders, start-of-day, widget styles, compact layout, multi-board view, icons, most within 12–18 months); every unshipped repeated ask is platform- or data-shaped (Watch 3, iPad 2, import 2, negative boards 2, weekly scheduling 3 partial) — 'these do not get closed by a point release'.

- **Where:** §3.5 table (verbatim); §3.5
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 22 requests; 9 repeated; incremental shipped; platform asks open
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `12110523017`, `14089348287`, `13619259448`, `12537644066`, `11859903290`, `14118758406`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C059 Be visibly responsive; fixes bring reviewers back; C141 Native iPad layout; C298 A public roadmap converts — and becomes a promise users hold you to

### R79-036 — Weekly / flexible scheduling — REQ_WEEKLY_SCHEDULE 3 (4.67★, 2024-10 → 2026-07), partial only (v2.4.0 lets you disable streak/consistency; no weekly target): 'Wenn ich einzelne Tage skippen könnte, oder ein Wochenziel festlegen… Das wäre der 5. Stern für mich' (4★); REQ_DAY_START 1 shipped v2.4.0; REQ_BEDTIME 1.

- **Where:** §3.5 (weekly schedule); §0.10
- **This app does:** day-based only; streak toggle shipped
- **User reaction:** complaint
- **Magnitude:** 3 voices; one withholding the 5th star
- **Direction for us:** must-have · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `11859903290`, `13910121511`, `14272948959`
- **Canonical:** C043 Flexible / custom frequency; C170 Configurable day boundary and hemisphere seasons; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R79-037 — Apple Watch (REQ_WATCH 3, 4.33★, 2024-12 → 2026-06: 'dann gibt's auch ✱✱✱✱✱') and iPad (REQ_IPAD 2, 5.00★) — the listing is iPhone-only, so these are genuinely unmet; §8.3 ship the Watch app or say it is not coming.

- **Where:** §3.5 (Watch, iPad)
- **This app does:** iPhone only
- **User reaction:** complaint
- **Magnitude:** Watch 3; iPad 2
- **Direction for us:** build-paid · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `12110523017`, `13628057308`, `14162555466`, `14089348287`, `14264852300`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C141 Native iPad layout

### R79-038 — Data import / migration (REQ_IMPORT 2, 5.00★ — including the corpus's last review), negative / inverse boards (REQ_NEGATIVE_HABIT 2, 5.00★), annual view (1, partially shipped v2.7.0 one day after the corpus ends), categories (1), Apple Health (1), photos (1), relative dates (1), streak sharing (1), icons/colours (1, partial), undo check-in (1, partial).

- **Where:** §3.5 (import, negative boards, singletons)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** n=2 or 1 each
- **Direction for us:** research · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `13619259448`, `14501661045`, `12537644066`, `14162555466`, `11987758860`
- **Canonical:** C011 Weekly / monthly / yearly reports; C019 Quit-habit / bad-habit mode; C020 Data export / backup / CSV; C021 Apple Health integration; C045 Grouping / folders / categories / tags; C202 A light social layer that is explicitly not a social network; C208 Photo / media / URL attached to a habit, memo or diary entry

### R79-065 — §8.3 the backlog that repeats (verbatim): Ask | Voices | Why it is worth doing | Evidence ; Apple Watch app | 3 | One reviewer pre-commits a 5★ for it; another calls it "quasi unentbehrlich" for fast capture; the app's whole value is low-friction check-in and the Watch is where that friction is lowest | 12110523017, 13628057308, 14162555466 ; Weekly / flexible scheduling | 3 | 14272948959 states the exact failure: a gym habit done 3×/week can never build a streak, so the app's core feedback loop breaks for non-daily habits. Also a pre-committed 5★ | 11859903290, 13910121511, 14272948959 ; iPad version | 2 | Listing is iPhone-only; a grid view is a natural fit for a larger screen | 14089348287, 14264852300 ; Data import / migration | 2 | Directly reduces switching cost *into* the product, and pairs with the existing CSV export | 13619259448, 14501661045 ; Negative / inverse boards | 2 | Both are German, 17 months apart, both describe the same design (12537644066: smoking; 14501661045: unfulfilled days as the streak). Opens the quit-habit use case the product currently cannot serve | 12537644066, 14501661045 — Watch: 'quasi unentbehrlich' for fast capture, 'the app's whole value is low-friction check-in and the Watch is where that friction is lowest'; weekly scheduling: 'a gym habit done 3×/week can never build a streak, so the app's core feedback loop breaks for non-daily habits'; negative boards: both German, 17 months apart, same design (smoking; unfulfilled days as the streak) — opens the quit-habit use case; two asks carry a pre-committed 5★, the only rating-elasticity evidence, pointing at Watch and weekly scheduling.

- **Where:** §8.3 table (verbatim); §8.3; part 8 #5
- **This app does:** iPhone-only, daily-only, positive-only boards
- **User reaction:** complaint
- **Magnitude:** Watch 3; weekly 3; iPad 2; import 2; negative 2; 2 pre-committed stars
- **Direction for us:** must-have · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `12110523017`, `13628057308`, `14162555466`, `11859903290`, `13910121511`, `14272948959`, `14089348287`, `14264852300`, `13619259448`, `12537644066`, `14501661045`
- **Canonical:** C019 Quit-habit / bad-habit mode; C020 Data export / backup / CSV; C022 Apple Watch app (done properly: timer, two-way sync); C043 Flexible / custom frequency; C141 Native iPad layout

## Monetization

### R79-006 — The price roughly tripled and exactly one reviewer states both numbers (verbatim): Date | Review | Price stated ; 2024-08-05 | 11575210211 us 5★ | $10 one-time ; 2024-09-18 | 11737999553 us 5★ | $10 one-time ; 2024-12-25 | 12104500362 us 5★ | $10 lifetime ; 2025-10-25 | 13311025859 sk 1★ | €18 — "Useless without paying 18€" ; 2025-11-22 | 13426922120 de 5★ | €17.99 — "wahrscheinlich gerechtfertigt … aber für mich ehrlich gesagt etwas teuer" ; 2026-03-16 | 13854797898 de 4★ | "kostet die Vollversion nun 23 Euro. Früher gab es sie für 10 Euro." ; 13 Sep 2026 | store listing | Ripples Plus Lifetime $24.99 — 'kostet die Vollversion nun 23 Euro. Früher gab es sie für 10 Euro… Wollte sie erwerben, um den Entwickler zu unterstützen aber 23 Euro sind doch recht viel für eine einzelne App mit einer Funktion' (4★) — a reviewer who wanted to pay to support the developer and did not; MON_DECLINED_PURCHASE 5 (2.91%, mean 3.20★) vs MON_WILL_BUY 7 (4.07%, 5.00★). Established: $10 one-time 2024-08 → 2024-12; €18 / €17.99 by 2025-10/11; €23 by 2026-03; subscription purchasable by 2026-01-24, monthly by 2026-08; not established: when subscription SKUs arrived, whether Powerpack and Plus coexist, what each unlocks, whether one-time buyers were grandfathered.

- **Where:** §0.3; §0.3 table (verbatim); §2.6
- **This app does:** one-time $10 → €18 → €23 / $24.99 lifetime
- **User reaction:** blocked-conversion
- **Magnitude:** price ×2.3; MON_DECLINED_PURCHASE 5 / 3.20★; MON_WILL_BUY 7 / 5.00★
- **Direction for us:** research · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Side effects:** a supporter-motivated buyer is lost at €23 for 'one function'
- **Review IDs:** `11575210211`, `11737999553`, `12104500362`, `13311025859`, `13426922120`, `13854797898`, `11570370725`, `14483046633`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R79-021 — Listing facts and free/paid classification: v2.4.0 (2026-04-27) 'Advanced analytics, which was previously part of paid Ripples+ plans, is now available to everyone' — the paywall moved in both directions; Family Sharing supported (a $17.99 Powerpack Family SKU) yet no review mentions it. Classification (verbatim): Capability | Status | Basis ; Core board creation & check-in | Free, up to 3 boards | 11832301736, 12899474787, 13681657252 — three storefronts, three dates, same number ; Boards beyond 3 | Paid | 14201744091 ("upgraded for more boards"), 13681657252 ; Home Screen widgets | Free until ~mid-2025, paid after | Free: 11832301736 (2024-10-14), 12191101918 (2025-01-16). Paid: 13311025859 (2025-10-25), 14373214557 (2026-08-01) ; Editing an existing habit | Paid (single voice) | 14290676887 (2026-07-11, 2★) ; Advanced analytics | Paid until v2.4.0, free after 2026-04-27 | Release note, corroborated by 14482128335 (2026-08-28) using analytics on the free tier ; iCloud sync | Free (never described as gated) | 11832301736, 12476173581; a headed section of the description ; CSV export | Unclear | 12205288948 praises it; no review says whether it is gated ; Siri Shortcuts | Unclear | 5 reviews use it; none says whether it is gated ; Journal / check-in notes | Unclear | Shipped v1.9.0; no review states its tier ; Reminders | Unclear | Shipped v2.2.0; no review states its tier ; A free trial | No evidence it exists | Zero reviews mention a trial. 11545582822 says "I'm going to trial it for a bit", meaning the free tier — 'the unclear rows are the finding': four capabilities reviewers actively use (export, Shortcuts, journal, reminders) and the corpus cannot say whether they are paid because the listing does not say; no evidence a trial exists.

- **Where:** §2.3 bullets; §2.5 table (verbatim); §2.5
- **This app does:** free: 3 boards, sync, analytics (from v2.4.0); paid: more boards, widgets (since ~mid-2025), editing (n=1); unclear: export, Shortcuts, notes, reminders; no trial
- **User reaction:** mixed
- **Magnitude:** cap 3 sources; widgets paid 2 sources; analytics ungated 2026-04-27
- **Direction for us:** undecided · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `11832301736`, `12899474787`, `13681657252`, `14201744091`, `13311025859`, `14373214557`, `14290676887`, `14482128335`, `12205288948`, `11545582822`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free; C037 Family plan; C209 No sign-up wall before first use; C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells; C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R79-029 — P7 price level is not the problem: MON_PRICE_FAIR 10 (5.81%, mean 5.00★, 2024-08 → 2026-09) including four written after the price rose ('fair one time buy options'; 'Simple, barata y eficaz'; 'der Preis für die Vollversion sehr fair'); MON_FREE_GENEROUS 10 (5.00★); MON_SUPPORT_DEV 3; U:money_positive 24 (13.95%, 4.79★) vs U:price_objection 5 (2.91%, 3.20★: 'powerpack too expensive for current features', the only E1 objection; '18€ is way too much for a tracker lmao, pc games cost less than this', 1★; 'etwas teuer', 5★) — of five price objectors one is 5★ and one 4★: objecting to the price is not disliking the app.

- **Where:** §3.3 P7; §3.4 N3
- **This app does:** one-time tier at $10 → €23
- **User reaction:** purchase-driver
- **Magnitude:** PRICE_FAIR 10 / 5.00★ (4 post-rise); price_objection 5 / 3.20★; FREE_GENEROUS 10 / 5.00★
- **Direction for us:** build-paid · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `13910121511`, `14214708913`, `14295499414`, `14501661045`, `11570370725`, `13311025859`, `13426922120`, `13854797898`, `14483046633`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R79-030 — N1 the paywall's shape — U:paywall_shape 6 (3.49%, CI 1.6–7.4%, mean 2.33★): MON_PAYWALL_BLOCKS 4 (1.75★: 'Useless if you dont pay'; 'compleet nutteloos als je niet betaald'; 'You don t let me modifie my habits whitout paying'; 'not able to use the app whatsoever for free'), MON_WIDGET_GATED 2, MON_BAIT_SWITCH 1, MON_UNEXPECTED 2 — every one of the six falls after 2025-10-25, zero in the first 15 months (E1 0/110): 'not a long-standing grievance; it appeared with the paywall change'.

- **Where:** §3.4 N1
- **This app does:** paywall tightened Oct 2025
- **User reaction:** 1★-burst
- **Magnitude:** paywall_shape 6 / 3.49% / 2.33★; PAYWALL_BLOCKS 4 / 1.75★; 0 in E1
- **Direction for us:** product-rule · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Review IDs:** `13311025859`, `13681657252`, `14290676887`, `14422900213`, `14373214557`
- **Canonical:** C001 Never move a free feature behind the paywall; C104 Never ship a paywall or feature-removal change silently; C297 A free cap's acceptability is set by the bundle around it — the same number reads as generous or as a wall depending on what else is free; moving a loved feature behind the wall changes sentiment as much as changing the number

### R79-039 — Direct evidence of what people do next (verbatim): Behaviour | n | % | Reviews ; Stated a purchase | 9 | 5.23% | 11921754194, 12071906839, 12451932869, 12759315641, 13582314702, 13749447160, 14173657564, 14192253561, 14201744091 ; Implied a purchase | 2 | 1.16% | 12226286073, 12537644066 ; Stated an intention to buy | 7 | 4.07% | 11545582822, 11552968648, 11602935317, 11832301736, 11987758860, 13669961043, 13992377824 ; Considered and declined | 5 | 2.91% | 11570370725, 13311025859, 13426922120, 13854797898, 14483046633 ; Recommended it to others | 12 | 6.98% | PRAISE-side; incl. 14201744091 "already recommended this app to a lot of my friends" ; Left or is leaving | 3 | 1.74% | 13311025859, 13836767975, 14483046633 — stated purchase 9 (5.23%), implied 2, intention 7 (4.07%), considered and declined 5 (2.91%), recommended 12 ('already recommended this app to a lot of my friends'), left or leaving 3.

- **Where:** §3.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** paid 9; intent 7; declined 5; churn 3
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `14201744091`, `12071906839`, `12759315641`, `13669961043`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R79-047 — Upgrade barriers in order of evidence (verbatim): Barrier | n | Mean ★ | Reviews ; The purchase fails after payment | 4 | 1.00 | 11921754194, 12352054623, 13582314702, 14192253561 ; Too much is behind the wall | 4 | 1.75 | 13311025859, 13681657252, 14290676887, 14422900213 ; The amount charged | 5 | 3.20 | 11570370725, 13311025859, 13426922120, 13854797898, 14483046633 ; The price went up | 1 | 4.00 | 13854797898 ; A subscription now exists | 2 | 3.00 | 13681657252, 14483046633 ; Widgets specifically gated | 2 | 2.50 | 13311025859, 14373214557 ; The surprise / non-disclosure | 2 | 2.00 | 14422900213, 14483046633 — 'the biggest barrier is not a price objection at all — it is that a third of stated payers report the transaction not delivering'; a conversion problem and a reputation problem: titles 'Estafa' and 'No part of the app is free' are what a prospective buyer reads.

- **Where:** §5.4 table (verbatim); §5.4
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** purchase fails 4 / 1.00★; wall 4 / 1.75★; amount 5 / 3.20★; subscription 2 / 3.00★; widgets gated 2 / 2.50★; surprise 2 / 2.00★
- **Direction for us:** must-never-break · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `14192253561`, `14422900213`, `13311025859`, `13854797898`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C064 Price level — where 'fair' turns into 'too expensive'; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R79-068 — §8.4.3 price level is not the barrier — do not lead with a discount: ten volunteer the price is good (5.00★), four after the increase, against five objectors who are Italian, Slovak, German, German and Czech — not a low-income-market pattern; 'the elasticity evidence points at what you get and whether you knew, not at how much. A price cut would buy less than four sentences of disclosure.'

- **Where:** §8.4.3; part 8 #7
- **This app does:** €23 lifetime
- **User reaction:** mixed
- **Magnitude:** PRICE_FAIR 10 / 5.00★ vs price_objection 5 / 3.20★
- **Direction for us:** dont · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `14501661045`, `13854797898`, `13311025859`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C062 Weight English-speaking rich markets; volume ≠ revenue; C064 Price level — where 'fair' turns into 'too expensive'

## Tactics the app used

### R79-028 — P6 the developer as a feature — PRAISE_DEV 14: 'The dev took feedback from me on Reddit and released my requested feature within a couple of weeks'; 'developer provided very fast support'; PRAISE_INDIE 9 (5.00★, nothing after 2025-02-28); PRAISE_ROADMAP 17 (9.88%) — a public roadmap is repeatedly cited as a reason for confidence ('following a roadmap full of nice upgrades'; 'einer Ansicht für kommende Features'); the counterweight: a 3★ whose entire text is 'Please complete roadmap.'

- **Where:** §3.3 P6
- **This app does:** public roadmap; Reddit/YouTube-facing solo dev
- **User reaction:** purchase-driver
- **Magnitude:** developer_equity 36 / 20.93% / 4.94★; ROADMAP 17 / 9.88%; DEV 14 / 8.14%; INDIE 9
- **Direction for us:** do · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Side effects:** a public roadmap becomes a promise users hold you to
- **Review IDs:** `11622746398`, `11736112540`, `12203658112`, `13910121511`, `13787227377`, `12071906839`, `12226286073`, `13426922120`, `13492961939`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal; C298 A public roadmap converts — and becomes a promise users hold you to

### R79-073 — A giveaway promo that could not be redeemed: an AppAdvice free-lifetime promotion on 2025-02-25 — 'today we are supposed to be able to get the lifetime version free through…' — produced a 1★ (MON_PROMO_FAIL) from a user who also could not find directions; a second giveaway (a competition win, disclosed unprompted, 'trotzdem urteile ich neutral') produced a 5★.

- **Where:** §0.6 (promo); §1.6.10
- **This app does:** promo codes via third-party giveaways
- **User reaction:** mixed
- **Magnitude:** CH_GIVEAWAY 2 (3.00★): 1★ + 5★
- **Direction for us:** dont · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Conditions:** a promo that fails is worse than no promo
- **Review IDs:** `12352054623`, `14185235911`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised; C225 A one-off free promotion (App of the Week, partner promo) acquires durable users

## Insights (the why)

### R79-004 — The product is not the problem, not once in 770 days: U:craft_praise (design, simplicity, native feel, animation, ease, performance) 117 of 172 (68.02%, CI 60.7–74.5%, mean 4.87★) — four times anything negative (verbatim) What people praise | n | % of 172 | Mean ★ ; PRAISE_DESIGN | 71 | 41.28% | 4.87 ; PRAISE_SIMPLICITY | 60 | 34.88% | 4.98 ; PRAISE_EASE | 35 | 20.35% | 4.83 ; PRAISE_WIDGET | 27 | 15.70% | 5.00 ; PRAISE_ANIMATION | 16 | 9.30% | 5.00 ; PRAISE_NATIVE_FEEL | 11 | 6.40% | 4.91; 27 (15.70%) say they searched the category and stopped here (U:competitive_win, 4.93★: 'tried a bunch of different tracking apps but none of them have nailed the simplicity'; 'Works for me where other apps don't'; 'Tried them all and this is by far the best'; 'spent the past 2 hours comparing which habit tracking app I want to invest into'); the negative story is a money-and-reliability story attached to a product people like.

- **Where:** §0.1; §0.1 table (verbatim); §3.3 P1
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** craft_praise 117 / 68.02% / 4.87★; PRAISE_DESIGN 71 (41.28%); PRAISE_SIMPLICITY 60 (34.88%, 4.98★); PRAISE_WIDGET 27 (5.00★); PRAISE_ANIMATION 16 (5.00★); competitive_win 27 / 15.70% / 4.93★
- **Direction for us:** build-free · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11536173663`, `11663987562`, `12806525837`, `13802340714`, `13615946826`, `14117040306`, `14501661045`
- **Canonical:** C005 Know which competitors buyers compare against; C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek; C185 Aesthetic and a polished onboarding convert; they do not retain

### R79-024 — P2 simplicity as a product position — PRAISE_SIMPLICITY 60 (34.88%, mean 4.98★, the highest of any theme over 20); reviewers describe what is NOT there: 'no frills, no 20 taps to log something'; 'No bloat. Just one page for all essentials'; 'no extra gamification, no ads, no BS'; 'Reminds me of the good old days of Apps… not overloaded with bloat'; 'Die App erfüllt genau ihren Zweck und nicht mehr'; U:anti_bloat 66 (38.37%, 4.98★).

- **Where:** §3.3 P2
- **This app does:** minimal, one-page
- **User reaction:** praise
- **Magnitude:** PRAISE_SIMPLICITY 60 / 34.88% / 4.98★; anti_bloat 66 / 4.98★
- **Direction for us:** product-rule · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11598211284`, `12205288948`, `13882115210`, `14118758406`, `14185235911`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R79-042 — 5★ (143) is overwhelmingly craft (DESIGN 44.8%, SIMPLICITY 41.3%, EASE 22.4%, WIDGET 18.9% — every widget mention is here); 7 (4.9%) content-free; 11 praise monetization at 5★ — 'the pricing model was, for a year, a reason for a 5★'; three 5★ are substantively negative. 4★ (12) is the request band: 8 of 12 carry a request or defect and nothing worse; two state the missing star's price — flexible scheduling or a Watch app — 'the clearest rating-elasticity signal in the corpus'; one 4★ calls it 'One of best ui i have seen' while asking for free widgets. 3★ (5): four of five about money — 'people who like the app enough not to give it one star, and who will not pay what it now asks'. 2★ (1): 'Nice but to greedy — You don t let me modifie my habits whitout paying' — the only attestation that editing an existing board is gated.

- **Where:** §4.3; §4.4; §4.5; §4.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 4★ 8 of 12 request/defect; 3★ 4 of 5 money; 2★ 1 (editing gated)
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `11650271322`, `13628057308`, `14272948959`, `14373214557`, `13854797898`, `11570370725`, `13681657252`, `14483046633`, `14290676887`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C073 Manual reordering, renaming and editing of habits/tasks — free; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings; C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R79-046 — What causes people to buy, in descending evidence: 1) hitting the board cap — the only explicit trigger ('upgraded for more boards and to support the developer'); 2) supporting the developer — MON_SUPPORT_DEV 3, a donation motive attached to a purchase ('because I like your approach'), the motive the developer-equity erosion threatens most, and the €23 price defeated it once; 3) the one-time model itself — 7 of 12 MON_ONETIME_PRAISE frame it as the reason to choose this app over subscription rivals; 4) roadmap confidence — 'what I personally miss (notes and custom units) is already planned by the developer! So I'll probably buy the full version soon'. MON_WILL_BUY 7 (5.00★); three make intent conditional (reminders + sync; notes + units; Russian) — all three conditions have since shipped; whether they converted is unknowable.

- **Where:** §5.3
- **This app does:** 3-board cap; one-time price; public roadmap; indie support
- **User reaction:** purchase-driver
- **Magnitude:** cap trigger 1; SUPPORT_DEV 3; ONETIME 12; WILL_BUY 7 / 5.00★
- **Direction for us:** build-paid · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `14201744091`, `11832301736`, `13854797898`, `11737999553`, `13106720476`, `11602935317`, `12071906839`, `11552968648`, `13992377824`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal; C298 A public roadmap converts — and becomes a promise users hold you to

### R79-060 — T6 requests stayed constant (16.4% → 19.0% → 19.5%) and got structurally harder (verbatim): Era | Typical request ; E1 | notes, reminders, smaller widgets, start-of-day, multi-board view — all incremental, and all shipped ; E3 | Apple Watch, iPad, data import, categories/search, photo attachments — all structural, none shipped — E1 asks (notes, reminders, smaller widgets, start-of-day, multi-board view) were incremental and all shipped, with two reviewers returning to acknowledge it; E3 asks (Watch, iPad, import, categories/search, photos) are structural and none shipped — 'the request pipeline works; the backlog that remains is the part a point release cannot clear'.

- **Where:** §7.7; §7.7 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** request_any flat ~17–20%; incremental shipped, structural open
- **Direction for us:** none · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `14118758406`, `14162555466`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C298 A public roadmap converts — and becomes a promise users hold you to

### R79-070 — §8.6 experiments: disclosure A/B on the listing measuring the 1★ rate; weekly-target boards (are non-daily habits a niche or a large unserved segment). §8.7 research questions: what share of users ever hit the three-board cap; how many of the 765 silent raters are on the free tier; were one-time buyers grandfathered when the subscription arrived (one 1★ consistent with a migration failure); is the rating decline an experience change or an audience change; why France produced 57 ratings and 2 text reviews; does the Watch app actually convert or is it a stated preference.

- **Where:** §8.6 #2, #4; §8.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `13582314702`, `13628057308`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C186 Never revoke what earlier buyers paid for when the model changes

### R79-071 — Restraint beats cute in a crowded category: 'Others are way too expensive or overly animated and cute. This one strikes a great balance'; 'no extra gamification, no ads, no BS'; the GitHub-contribution-graph metaphor is the identity (7 mentions at 5.00★, developers self-identify: 'As a SWE'; 'I'm a developer so I can definitely understand the GitHub feel').

- **Where:** §0.1 (competitive win); §3.3 P4; §8.5
- **This app does:** GitHub-grid, no gamification
- **User reaction:** praise
- **Magnitude:** GITHUB_GRID 7 / 5.00★; NO_GAMIFICATION 2; anti_bloat 66
- **Direction for us:** do · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Conditions:** developer / engineer audience
- **Review IDs:** `14214708913`, `13882115210`, `11622746398`, `14122073599`
- **Canonical:** C012 Week / month / year grid views; C024 Streaks / gamification; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

## Audiences

### R79-027 — P5 outcomes — U:outcome_any 35 (20.35%, 4.77★): OUT_USE_CASE 13 (study hours, gym, medication, music production, driving-theory mock tests, workouts, coding lessons, strength training, work days); OUT_HABIT_FORMED 5 (5.00★: 'you've filled in every box for the first month, then you realise you've formed a habit'; 'easier to use, so you use it more consistently'); OUT_DAILY_USE 8; OUT_RECOMMEND 12 (5.00★). Caveat not hidden: OUT_HABIT_FORMED has no entry after 2025-09-14 — five claims in the first 14 months, none in the last 12 (expected count under two at the base rate).

- **Where:** §3.3 P5
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** outcome_any 35 / 20.35%; HABIT_FORMED 5 / 5.00★, none after 2025-09
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11528747861`, `13148701785`, `11663987562`, `12531263299`, `12030271839`, `12806525837`, `13137552157`
- **Canonical:** C067 Fitness / health tracking use case; C140 Market the generic-tracker use case

## Markets and languages

### R79-034 — N8 localisation — a Russian request ('Добавьте русский язык… Но обделили русских пользователей', 5★, 2026-04-24) was shipped ~7 weeks later (v2.6.0, 2026-06-14, 'localized for 10 more countries'); 13 days after that release a Korean 4★: 'The Korean translation needs significant improvement. As it stands, it's worse than a machine translation' — the only translation-quality signal, and it points at the expansion release.

- **Where:** §3.4 N8; §6.6
- **This app does:** 16 languages; rapid expansion with a quality seam
- **User reaction:** mixed
- **Magnitude:** LOC_REQUEST 1 (shipped in 7 weeks); LOC_QUALITY 1
- **Direction for us:** do · **Report confidence:** Emerging · **Generalisable:** generalisable
- **Conditions:** a bulk localisation release ships machine-grade translations
- **Review IDs:** `13992377824`, `14233536393`
- **Canonical:** C027 Localise early — it unlocks revenue; C255 An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language

### R79-049 — No storefront reaches 50 (verbatim): Storefront | Reviews | Short of 50 by ; United States | 38 | 12 ; Germany | 17 | 33 ; United Kingdom | 12 | 38 ; India | 10 | 40 ; Spain | 8 | 42 — every storefront (verbatim): Storefront | Text reviews | % of corpus | Mean ★ (text) | 5/4/3/2/1 | Public ratings | Public mean ★ | ≥50? ; United States (us) | 38 | 22.09% | 4.32 | 30/2/0/0/6 | 220 | 4.73 | no ; Germany (de) | 17 | 9.88% | 4.82 | 14/3/0/0/0 | 98 | 4.72 | no ; United Kingdom (gb) | 12 | 6.98% | 5.00 | 12/0/0/0/0 | 57 | 4.89 | no ; India (in) | 10 | 5.81% | 4.10 | 6/1/2/0/1 | 56 | 4.64 | no ; Spain (es) | 8 | 4.65% | 4.50 | 7/0/0/0/1 | 30 | 4.70 | no ; Ukraine (ua) | 7 | 4.07% | 4.43 | 6/0/0/0/1 | 55 | 4.85 | no ; Canada (ca) | 6 | 3.49% | 5.00 | 6/0/0/0/0 | 37 | 4.92 | no ; Russia (ru) | 5 | 2.91% | 5.00 | 5/0/0/0/0 | 12 | 5.00 | no ; Switzerland (ch) | 4 | 2.33% | 5.00 | 4/0/0/0/0 | 11 | 4.73 | no ; Brazil (br) | 4 | 2.33% | 5.00 | 4/0/0/0/0 | 26 | 4.81 | no ; Israel (il) | 3 | 1.74% | 5.00 | 3/0/0/0/0 | 6 | 5.00 | no ; Italy (it) | 3 | 1.74% | 4.33 | 2/0/1/0/0 | 21 | 4.86 | no ; Norway (no) | 3 | 1.74% | 5.00 | 3/0/0/0/0 | 6 | 5.00 | no ; Poland (pl) | 3 | 1.74% | 5.00 | 3/0/0/0/0 | 27 | 4.74 | no ; Mexico (mx) | 3 | 1.74% | 4.67 | 2/1/0/0/0 | 24 | 4.88 | no ; Portugal (pt) | 3 | 1.74% | 5.00 | 3/0/0/0/0 | 10 | 4.90 | no ; South Korea (kr) | 3 | 1.74% | 4.67 | 2/1/0/0/0 | 16 | 4.94 | no ; South Africa (za) | 2 | 1.16% | 5.00 | 2/0/0/0/0 | 7 | 5.00 | no ; Sweden (se) | 2 | 1.16% | 5.00 | 2/0/0/0/0 | 9 | 4.67 | no ; Vietnam (vn) | 2 | 1.16% | 4.50 | 1/1/0/0/0 | 8 | 4.88 | no ; UZ (uz) | 2 | 1.16% | 5.00 | 2/0/0/0/0 | 5 | 5.00 | no ; Denmark (dk) | 2 | 1.16% | 5.00 | 2/0/0/0/0 | 8 | 5.00 | no ; Greece (gr) | 2 | 1.16% | 5.00 | 2/0/0/0/0 | 5 | 5.00 | no ; Colombia (co) | 2 | 1.16% | 5.00 | 2/0/0/0/0 | 2 | 5.00 | no ; Turkey (tr) | 2 | 1.16% | 5.00 | 2/0/0/0/0 | 15 | 4.87 | no ; Taiwan (tw) | 2 | 1.16% | 4.50 | 1/1/0/0/0 | 11 | 4.82 | no ; Netherlands (nl) | 2 | 1.16% | 5.00 | 2/0/0/0/0 | 18 | 4.78 | no ; SK (sk) | 2 | 1.16% | 3.00 | 1/0/0/0/1 | 4 | 4.00 | no ; France (fr) | 2 | 1.16% | 5.00 | 2/0/0/0/0 | 57 | 4.79 | no ; Czechia (cz) | 2 | 1.16% | 4.00 | 1/0/1/0/0 | 13 | 4.85 | no ; Philippines (ph) | 2 | 1.16% | 2.50 | 0/1/0/0/1 | 10 | 4.30 | no ; Finland (fi) | 1 | 0.58% | 5.00 | 1/0/0/0/0 | 6 | 5.00 | no ; Australia (au) | 1 | 0.58% | 5.00 | 1/0/0/0/0 | 15 | 4.93 | no ; PA (pa) | 1 | 0.58% | 5.00 | 1/0/0/0/0 | 2 | 5.00 | no ; GE (ge) | 1 | 0.58% | 5.00 | 1/0/0/0/0 | 1 | 5.00 | no ; Japan (jp) | 1 | 0.58% | 5.00 | 1/0/0/0/0 | 9 | 4.44 | no ; HN (hn) | 1 | 0.58% | 5.00 | 1/0/0/0/0 | 1 | 5.00 | no ; KZ (kz) | 1 | 0.58% | 5.00 | 1/0/0/0/0 | 2 | 5.00 | no ; Malaysia (my) | 1 | 0.58% | 5.00 | 1/0/0/0/0 | 3 | 5.00 | no ; Belgium (be) | 1 | 0.58% | 3.00 | 0/0/1/0/0 | 6 | 4.50 | no ; KH (kh) | 1 | 0.58% | 5.00 | 1/0/0/0/0 | 1 | 5.00 | no ; JM (jm) | 1 | 0.58% | 4.00 | 0/1/0/0/0 | 1 | 4.00 | no ; Romania (ro) | 1 | 0.58% | 2.00 | 0/0/0/1/0 | 6 | 4.50 | no ; All 43 | 172 | 100% | 4.60 | 143/12/5/1/11 | 937 | 4.781 | none — 937 public ratings vs 172 text (18.4%); France 57 ratings / 2 text; Ukraine 55 / 7.

- **Where:** §6.1 table (verbatim); §6.1; §6.2 table (verbatim); §6.2
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** us 38 (4.32, 6 1★); de 17 (4.82); gb 12 (5.00); in 10 (4.10); es 8 (4.50)
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `11528747861`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R79-050 — The five double-digit storefronts, limited evidence (verbatim): Storefront | n | Mean ★ | What is distinctive, with the caveat that n is small ; United States | 38 | 4.32 | Lowest mean of the five. Holds 6 of the corpus's 11 one-star reviews. Also the most monetization-positive storefront in Era 1: MON_ONETIME_PRAISE 7 of 12 globally, MON_PRICE_FAIR 5 of 10. Its own trend mirrors the global one: E1 4.81 (n=21) → E2 3.67 (n=6) → E3 3.73 (n=11). ; Germany | 17 | 4.82 | Highest craft praise density; PRAISE_DESIGN in 9 of 17. Supplies both reviewers who state a rating is being withheld for a named feature (13628057308, 14272948959), both negative-board requests (12537644066, 14501661045), and the only review that states the price rose (13854797898). Zero one-star reviews. ; United Kingdom | 12 | 5.00 | Every UK review is 5★. Strongest COMP_TRIED_MANY/COMP_BEST density (3 each of 12) and three of the seven GitHub-grid mentions. ; India | 10 | 4.10 | Lowest mean after the Philippines. Two 3★ (roadmap, notifications), one 1★ (the 2024 entitlement failure). Also strongly craft-positive: PRAISE_DESIGN in 5 of 10. ; Spain | 8 | 4.50 | PRAISE_SIMPLICITY in 6 of 8 — the densest single theme in any storefront. Contains the two reviews that contradict each other about the free tier 15 days apart (14422900213 is us; 14482128335 is es, against 14293610339 es 1★ on data loss). — the US holds 6 of 11 1★ and was the most monetization-positive storefront in Era 1 (ONETIME_PRAISE 7 of 12, PRICE_FAIR 5 of 10), its own trend mirroring the global (4.81 → 3.67 → 3.73); Germany supplies both rating-withholding reviewers, both negative-board requests and the only price-rise review, zero 1★; every UK review is 5★; Spain has PRAISE_SIMPLICITY in 6 of 8; 'none of these is a country finding'.

- **Where:** §6.3 table (verbatim); §6.3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** us 38 / 4.32 / 6 1★; de 17 / 4.82 / 0 1★; gb 12 / 5.00; in 10 / 4.10; es 8 / 4.50
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `13628057308`, `14272948959`, `12537644066`, `13854797898`, `14422900213`, `14482128335`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C130 Use the lead-user market as the beta cohort

### R79-051 — Market groups, defined not assumed (verbatim): Group | n | % of corpus | Mean ★ | U:craft_praise | U:money_negative | U:defect_any | U:request_any ; High-spend (9 of 10 present) | 82 | 47.67% | 4.62 | 73.17% | 7.32% | 3.66% | 20.73% ; High-volume (top 5 by reviews) | 85 | 49.42% | 4.51 | 74.12% | 9.41% | 5.88% | 18.82% ; Rest of world | 90 | 52.33% | 4.58 | — | — | — | — ; Global | 172 | 100% | 4.599 | 68.02% | 8.14% | 5.23% | 17.44% — high-spend (fixed list, 9 of 10 present; China produced zero text reviews despite a shipped Simplified Chinese localisation) 82 at 4.62★ vs rest of world 4.58★ — noise; money-negative slightly higher in the high-volume group (9.41% vs 7.32%) driven by India and Spain on 6–8 reviews — recorded so nobody mistakes its absence for evidence that price sensitivity concentrates in low-income markets: 'The reviewer who objects to €23 is German; the one who objects to €18 is Slovak; the one who calls it a scam writes Spanish on the US storefront'; the five price objectors are Italian, Slovak, German, German and Czech; Japan, Australia, Taiwan and Korea hold 51 public ratings but 7 text reviews.

- **Where:** §6.4 table (verbatim); §6.4; §6.8
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** high-spend 82 / 4.62★ / money-neg 7.32%; high-volume 85 / 4.51★ / 9.41%; global 8.14%
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Conditions:** price objections here come from high-income European markets
- **Review IDs:** `13854797898`, `13311025859`, `14192253561`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R79-053 — Languages of the text (verbatim): Language of the text | n | % | Mean ★ ; en | 137 | 79.65% | 4.62 ; de | 13 | 7.56% | 4.77 ; es | 7 | 4.07% | 3.86 ; ru | 3 | 1.74% | 5.00 ; uk | 3 | 1.74% | 3.67 ; fr | 2 | 1.16% | 5.00 ; no | 1 | 0.58% | 5.00 ; en/de | 1 | 0.58% | 5.00 ; ko | 1 | 0.58% | 5.00 ; ja | 1 | 0.58% | 5.00 ; en/uk | 1 | 0.58% | 5.00 ; nl | 1 | 0.58% | 3.00 ; pt | 1 | 0.58% | 5.00 — 16 languages ship, 13 appear, 3 bilingual reviews; no review complains the app is unavailable in their language beyond the one Russian request — consistent with a UI that is mostly icons and grids; storefront ≠ language ≠ nationality: Germany mixes German and English, 'Estafa' is Spanish on the US storefront, an Uzbekistan review is Russian.

- **Where:** §6.6 table (verbatim); §6.6; §6.7
- **This app does:** 16 localisations; icon-and-grid UI
- **User reaction:** mixed
- **Magnitude:** 13 languages; LOC_REQUEST 1; LOC_QUALITY 1
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `13992377824`, `14233536393`, `14192253561`, `12759315641`
- **Canonical:** C027 Localise early — it unlocks revenue; C255 An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language

## Dated events and trends

### R79-005 — The corpus records a business-model reversal in reviewers' own words: the most-repeated reason to buy in year one was the absence of a subscription — MON_ONETIME_PRAISE 12 (6.98%, CI 4.0–11.8%), 9 in Era 1 ('the premium subscription is a one time 10 dollar payment is incredible'; 'no frills, no 20 taps to log something, no subscriptions'; 'best of all — it's a one time purchase!!'); today's listing sells five SKUs incl. Plus Monthly $2.99 and Plus Yearly $9.99, and the corpus records the change arriving: 'plan to purchase a subscription' (2026-01-24, the first review in 18 months to name one); 'Nutteloos zonder subscriptie' (3★); 'I loved… the lack of a subscription. Now UI bugs have made it unusable' (1★, past tense on all three); 'after a while it turns out I have to pay a monthly subscription which isn't cheap for a student' (3★). 'The differentiator that 12 reviewers named as the reason they chose this app has been removed' — corroborated by the live listing.

- **Where:** §0.2; §0.12 #5; §8.4
- **This app does:** one-time $10 → subscription + $24.99 lifetime
- **User reaction:** churn
- **Magnitude:** MON_ONETIME_PRAISE 12 / 6.98%, 9 in E1; subscription named from 2026-01-24
- **Direction for us:** product-rule · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11575210211`, `11598211284`, `11737999553`, `12104500362`, `12160259550`, `12230309851`, `13106720476`, `13669961043`, `13681657252`, `13836767975`, `14483046633`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C186 Never revoke what earlier buyers paid for when the model changes; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

### R79-007 — The free tier shrank and reviewers name the piece that left — the board cap did not change (three reviewers on three storefronts state three: 'for widgets and 3 habits without limitations'; 'Widget without premium(powerpack)'; 'three habits… without huge limitations', all 5★); the widget went behind the wall: 'Useless if you dont pay, can[t] even put a single widget!!' (sk 1★, 2025-10-25); 'met 3 boards ben je totaal niks' (3★); 'make 2 widgets available in free version… it will really help budget conscious buyers' (in 4★); editing a habit paid ('You don t let me modifie my habits whitout paying', 2★). Widgets are the single most-praised feature at a perfect score — PRAISE_WIDGET 27 (15.70%), mean 5.00★, not one below 5: 'Gating the only feature that has never received a complaint is the highest-leverage monetization decision visible in this corpus.' Caveat recorded: 'not able to use the app whatsoever for free' (1★) and 'De momento uso la opción gratuita… súper útil con analíticas y todo' (5★) fifteen days apart — both cannot be literally true; a disclosure problem.

- **Where:** §0.4; §0.12 #4; §2.5 widgets row; §8.4
- **This app does:** free widgets → paid widgets (~mid-2025); 3-board cap unchanged
- **User reaction:** 1★-burst
- **Magnitude:** PRAISE_WIDGET 27 / 15.70% / 5.00★; paid-widget complaints 3; cap stated 3
- **Direction for us:** product-rule · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11832301736`, `12191101918`, `12899474787`, `13311025859`, `13681657252`, `14290676887`, `14373214557`, `14422900213`, `14482128335`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free; C297 A free cap's acceptability is set by the bundle around it — the same number reads as generous or as a wall depending on what else is free; moving a loved feature behind the wall changes sentiment as much as changing the number

### R79-008 — Ratings falling monotonically across every era boundary (verbatim): Era | Window | Days | n | % | Mean ★ | 5/4/3/2/1 | 1★ rate ; E1 Checker | 2024-07-24 → 2025-09-16 | 420 | 110 | 63.95% | 4.89 | 105/2/1/0/2 | 1.8% ; E2 Rename | 2025-09-17 → 2026-02-10 | 147 | 21 | 12.21% | 4.19 | 15/1/2/0/3 | 14.3% ; E3 Overhaul | 2026-02-11 → 2026-09-02 | 204 | 41 | 23.84% | 4.02 | 23/9/2/1/6 | 14.6% — 5★ share 95.5% → 71.4% → 56.1%; mean 4.89 → 4.19 → 4.02; first 50 reviews 4.88★, last 50 3.98★; first 12 months 105 reviews at 4.89★, last 12 months 65 at 4.12★; U:negative_any 4.5% → 23.8% → 41.5%; 2026 produced 10 of the 11 one-star reviews in the second half, spread across seven months — not one bad month.

- **Where:** §0.5; §0.5 table (verbatim); §7.2
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** E1 110 / 4.89★ / 1★ 1.8%; E2 21 / 4.19★ / 14.3%; E3 41 / 4.02★ / 14.6%; negative_any 4.5% → 41.5%
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** app-specific
- **Review IDs:** `13836767975`, `14422900213`, `13311025859`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R79-010 — Defects did not exist before the v2.1.0 overhaul; now they are a fifth of the corpus — U:defect_any E1 1/110 (0.9%, a usability nit) → E2 0/21 → E3 8/41 (19.5%, mean 2.50★); v2.1.0 (2026-02-11) notes: 'Ripples went through a major internal overhaul… widgets and custom shortcuts need to be re-configured'. Register (verbatim): # | ID | Date | ★ | Store | Defect codes | Title | Matching release note ; 75 | 12474979339 | 2025-03-28 | 4 | vn | DEF_CHECKIN_SPAM | Check in too many times | v2.0.1 (2025-10-09) restored the long-press check-in configurator ; 135 | 13767244783 | 2026-02-19 | 1 | ua | DEF_CRASH | Не працює | v2.2.0 (2026-03-01): *fixed a crash when creating a new board on iOS 18* — 11 days later ; 138 | 13836767975 | 2026-03-11 | 1 | us | DEF_UI_BUG | Used to be great | follows v2.1.0 (2026-02-11), the overhaul that reset widgets and shortcuts ; 142 | 13929651995 | 2026-04-06 | 3 | in | DEF_NOTIF_FAIL | Great App, Needs Notification Fix | follows v2.2.0 (2026-03-01), which introduced multiple reminders ; 143 | 13962890919 | 2026-04-16 | 4 | mx | DEF_NOTIF_FAIL | I liked but… | follows v2.2.0 (2026-03-01), which introduced multiple reminders ; 152 | 14173657564 | 2026-06-12 | 1 | ph | DEF_DATA_LOSS | All data gone after updating to ios 18.4 | v2.1.1/2.1.2 (2026-02) added a *Deduplicate data* tool after data problems ; 164 | 14293610339 | 2026-07-12 | 1 | es | DEF_DATA_LOSS | Borrado de datos | no matching note; the rename was v2.0.0 (2025-09-17) ; 168 | 14397430419 | 2026-08-07 | 4 | us | DEF_DATA_LOSS | I Love it But… | v2.6.2 (2026-07-20): *stability fix for users updating from builds over a year old* ; 172 | 14501661045 | 2026-09-02 | 5 | de | DEF_REORDER_BUG | Schöne App | v2.4.2/2.5.0 reworked drag-and-drop; the report is *after* that rework — two resolve against dated release notes: 'tapping Create board crashes the app' (ua 1★, 2026-02-19) → v2.2.0 eleven days later 'Fixed an issue on iOS 18 where the app would crash when trying to create a new board'; 'My old boards got taken down in an update' (4★) → v2.6.2 'stability issue for users updating directly from app versions more than a year old'; DEF_DATA_LOSS 3 (1.74%, 2.00★) all in the last seven months ('All data gone after updating to ios 18.4' — later recovered by iCloud; 'Han borrado los datos previos de antes del cambio de nombre') — 'for a habit tracker, whose entire value is an unbroken record, this is the most damaging defect class'.

- **Where:** §0.7; §0.7 table (verbatim); §0.12 #6; §8.2
- **This app does:** post-overhaul regressions incl. data loss
- **User reaction:** 1★-burst
- **Magnitude:** defect_any 0.9% → 0.0% → 19.5% (2.50★); DEF_DATA_LOSS 3 / 2.00★; DEF_NOTIF_FAIL 2
- **Direction for us:** must-never-break · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `12474979339`, `13767244783`, `13836767975`, `13929651995`, `13962890919`, `14173657564`, `14293610339`, `14397430419`, `14501661045`
- **Canonical:** C010 Backfill missed days / edit start date; C034 Data must never be lost on update, reinstall or phone change; C039 Reminders fire reliably, once; C155 Never remove a feature people bought the app for — add alongside, do not replace; C175 Updates must not break function or wipe progress; C223 Undo / un-complete is a visible button — never a gesture-only path

### R79-012 — The asset quietly eroding is the developer relationship: U:developer_equity (praise for the developer, indie-ness, public roadmap, YouTube/Reddit as channel) 36 (20.93%, 4.94★), falling E1 26.4% → E2 9.5% → E3 12.2%; PRAISE_INDIE (9, 5.00★) has no entry after 2025-02-28; CH_YOUTUBE (5) none after 2025-11-25; the one review reporting being ignored is a paying customer ('Developer doesn't respond. Waste of time.', SUP_NO_RESPONSE 1) against PRAISE_DEV 14 (8.14%, 4.93★, last 2026-06-09) — 'the pattern is not that support got bad — it is that the audience changed. The people arriving now did not come from a YouTube channel and have no relationship to spend.'

- **Where:** §0.9; §7.6
- **This app does:** creator-led (YouTube/Reddit) indie launch
- **User reaction:** praise
- **Magnitude:** developer_equity 36 / 20.93% / 4.94★, 26.4% → 12.2%; PRAISE_INDIE 9 none after 2025-02; PRAISE_DEV 14; SUP_NO_RESPONSE 1
- **Direction for us:** do · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Conditions:** an audience acquired through a creator channel carries goodwill later cohorts do not
- **Review IDs:** `11575210211`, `11622746398`, `11839901182`, `11978848977`, `12104500362`, `13426922120`, `13439873787`, `13582314702`, `14162555466`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C059 Be visibly responsive; fixes bring reviewers back; C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal

### R79-020 — The rename Checker → Ripples (v2.0.0, 2025-09-17): 110 of 172 reviews predate it, six use the old name; a 'Чекер+' tier existed under the old name (June 2025) before today's 'Ripples Plus'; one reviewer blames the rename for data loss ('Han borrado los datos previos de antes del cambio de nombre', 1★ — attribution recorded, mechanism unconfirmed); the US storefront has since gone further to 'Visual Habit Tracker: Ripples' while 42 storefronts keep a 'Habit Tracker' title.

- **Where:** §2.2
- **This app does:** renamed mid-life
- **User reaction:** mixed
- **Magnitude:** 6 reviews use old name; 1 data-loss attribution
- **Direction for us:** none · **Report confidence:** Emerging · **Generalisable:** app-specific
- **Review IDs:** `11737999553`, `12759315641`, `12806525837`, `14293610339`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C278 Do not name the app after an established competitor — a name collision makes the product 'the fake one' before it is tried, and the cost cannot be measured from reviews

### R79-054 — Three eras at externally verifiable releases (verbatim): Era | Boundary event | Window ; E1 Checker | launch → day before the rename | 2024-07-24 → 2025-09-16 ; E2 Rename | v2.0.0, 2025-09-17 — *"Checker is now Ripples!"* + iOS 26 refresh | 2025-09-17 → 2026-02-10 ; E3 Overhaul | v2.1.0, 2026-02-11 — major internal overhaul; *"widgets and custom shortcuts need to be re-configured"* | 2026-02-11 → 2026-09-02 || Era | Window | Days | n | % | Mean ★ | 5/4/3/2/1 | 1★ rate ; E1 Checker | 2024-07-24 → 2025-09-16 | 420 | 110 | 63.95% | 4.89 | 105/2/1/0/2 | 1.8% ; E2 Rename | 2025-09-17 → 2026-02-10 | 147 | 21 | 12.21% | 4.19 | 15/1/2/0/3 | 14.3% ; E3 Overhaul | 2026-02-11 → 2026-09-02 | 204 | 41 | 23.84% | 4.02 | 23/9/2/1/6 | 14.6% || quarterly (verbatim): Quarter | n | Mean ★ | 5★ | 1★ | 1★ share ; 2024 Q3 | 28 | 4.93 | 27 | 0 | 0.0% ; 2024 Q4 | 28 | 4.86 | 27 | 1 | 3.6% ; 2025 Q1 | 21 | 4.76 | 19 | 1 | 4.8% ; 2025 Q2 | 22 | 5.00 | 22 | 0 | 0.0% ; 2025 Q3 | 14 | 4.93 | 13 | 0 | 0.0% ; 2025 Q4 | 10 | 4.40 | 8 | 1 | 10.0% ; 2026 Q1 | 17 | 3.82 | 10 | 4 | 23.5% ; 2026 Q2 | 18 | 4.28 | 12 | 2 | 11.1% ; 2026 Q3 | 14 | 3.71 | 5 | 2 | 14.3% ; Union | E1 Checker (n=110) | E2 Rename (n=21) | E3 Overhaul (n=41) | Direction ; U:craft_praise | 84 (76.4%) | 9 (42.9%) | 24 (58.5%) | flat ; U:money_positive | 15 (13.6%) | 1 (4.8%) | 8 (19.5%) | flat ; U:money_negative | 3 (2.7%) | 4 (19.0%) | 7 (17.1%) | rising ; U:paywall_shape | 0 (0.0%) | 2 (9.5%) | 4 (9.8%) | rising ; U:price_objection | 1 (0.9%) | 2 (9.5%) | 2 (4.9%) | rising ; U:defect_any | 1 (0.9%) | 0 (0.0%) | 8 (19.5%) | rising ; U:purchase_evidence | 6 (5.5%) | 1 (4.8%) | 4 (9.8%) | rising ; U:request_any | 18 (16.4%) | 4 (19.0%) | 8 (19.5%) | flat ; U:outcome_any | 22 (20.0%) | 3 (14.3%) | 10 (24.4%) | flat ; U:developer_equity | 29 (26.4%) | 2 (9.5%) | 5 (12.2%) | falling ; U:competitive_win | 16 (14.5%) | 3 (14.3%) | 8 (19.5%) | flat ; U:friction_any | 2 (1.8%) | 2 (9.5%) | 3 (7.3%) | rising ; U:negative_any | 5 (4.5%) | 5 (23.8%) | 17 (41.5%) | rising || unions by era (verbatim): Era | Typical request ; E1 | notes, reminders, smaller widgets, start-of-day, multi-board view — all incremental, and all shipped ; E3 | Apple Watch, iPad, data import, categories/search, photo attachments — all structural, none shipped — E2 has only 21 reviews, so E1→E3 comparisons are the reliable ones; 2025 Q2 is the peak (22 reviews, 5.00★), 2026 Q3 the trough (3.71★).

- **Where:** §7.1 boundary table (verbatim); §7.1 era table (verbatim); §7.1 quarter table (verbatim); §7.1 union table (verbatim); §7.1
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** E1 110 / 4.89★; E2 21 / 4.19★; E3 41 / 4.02★; 2025 Q2 5.00 → 2026 Q3 3.71
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `13836767975`, `13767244783`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R79-055 — T1 ratings fell monotonically across every boundary — the strongest trend: mean 4.89 → 4.19 → 4.02; 5★ 95.5% → 71.4% → 56.1%; negative_any 4.5% → 23.8% → 41.5%; first 50 reviews 4.88★ / last 50 3.98★; 2 1★ in the first 15 months, 9 in the last 11. What it is not: a collapse in how people regard the product — craft_praise still 58.5% in E3, COMP_BEST still awarded in the final review, 23 of 41 E3 reviews 5★: 'the decline is additive — the same praise, now with something attached to it'.

- **Where:** §7.2
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 4.89 → 4.02; 5★ 95.5% → 56.1%
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** app-specific
- **Review IDs:** `14501661045`, `13836767975`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C185 Aesthetic and a polished onboarding convert; they do not retain

### R79-056 — T2 monetization complaints appeared and stayed — money_negative 2.7% (1.67★) → 19.0% → 17.1% (2.29★); not one complaint about the paywall's shape in the first 15 months (paywall_shape 0/110 in E1, then 9.5%, 9.8%); the positive side thinned then partly recovered (ONETIME_PRAISE 9 → 1 → 2; PRICE_FAIR 6 → 0 → 4 — four still call it fair after it rose): 'this is not a market rejecting a price. It is a market that was sold a specific promise — one payment, no subscription — encountering a different one, with no listing text to mediate the change.'

- **Where:** §7.3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** money_negative 2.7% → 17.1%; paywall_shape 0 → 9.8%; PRICE_FAIR 6 → 0 → 4
- **Direction for us:** product-rule · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11570370725`, `11921754194`, `14501661045`, `13681657252`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

### R79-058 — T4 the paywall tightened in the second half — every paywall_shape review (6) falls after 2025-10-25; the free-tier sequence brackets the change between 2025-07-16 (free tier 'without huge limitations') and 2025-10-25 (can't place a widget) — a 101-day window in which the free tier's most-praised component moved behind the wall; counter-evidence kept in view: 'súper útil con analíticas y todo' on the free tier (2026-08-28) is consistent with v2.4.0 de-gating advanced analytics — 'the paywall moved in both directions during E3'.

- **Where:** §7.5
- **This app does:** widgets gated ~Aug–Oct 2025; analytics ungated Apr 2026
- **User reaction:** mixed
- **Magnitude:** paywall_shape 6, all after 2025-10-25; bracket 101 days
- **Direction for us:** none · **Report confidence:** Very strong · **Generalisable:** app-specific
- **Review IDs:** `12899474787`, `13311025859`, `14482128335`
- **Canonical:** C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells; C297 A free cap's acceptability is set by the bundle around it — the same number reads as generous or as a wall depending on what else is free; moving a loved feature behind the wall changes sentiment as much as changing the number

### R79-059 — T5 developer equity thinned — 26.4% → 9.5% → 12.2%; PRAISE_INDIE none after 2025-02-28 (nine in the first seven months, zero in the following eighteen); CH_YOUTUBE none after 2025-11-25; PRAISE_DEV holds (last 2026-06-09 'Appreciate the updates. Keeps improving') — 'not a story about support getting worse… the early corpus is full of people who followed a developer; the recent corpus is full of people who found an app'; §8.4.4 rebuild the acquisition story or accept a harsher audience — E1 rated 4.89★ partly because it arrived predisposed; whatever replaces that channel will not be.

- **Where:** §7.6; §8.4.4
- **This app does:** creator-channel launch cohort aging out
- **User reaction:** mixed
- **Magnitude:** developer_equity 26.4% → 12.2%; INDIE 9 → 0; YOUTUBE 5 → 0
- **Direction for us:** do · **Report confidence:** moderate · **Generalisable:** generalisable
- **Review IDs:** `14162555466`, `11622746398`, `13439873787`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal

## Positioning

### R79-001 — Habit Tracker – Ripples (App Store ID 6502667826), developer Mykola Harmash (solo), called Checker until v2.0.0 (2025-09-17: 'Checker is now Ripples!'), US title now 'Visual Habit Tracker: Ripples'; iPhone only, iOS 18.6+, no iPad or Watch build, 16 languages, 'Data Not Linked to You', Family Sharing supported — a visual habit tracker built around a grid: create a 'board', check in, the grid fills GitHub-contribution-graph style (PRAISE_GITHUB_GRID 7, 4.07%, mean 5.00★: 'As a SWE the github-style charts are appealing'); interactive stackable Home Screen widgets (27), check-in of amounts with custom units (7), stats (9), Siri Shortcuts incl. NFC tags (5), iCloud sync (3), CSV export ('no lock-in'), notes (v1.9.0), reminders (v2.2.0); praised by absence: no ads (5), no trackers (3), no imposed gamification (2), no account (1) — U:anti_bloat 66 (38.37%, 4.98★). Capability table (verbatim): Capability | Attested by | Evidence ; Interactive Home Screen widgets, stackable | 27 | PRAISE_WIDGET, mean 5.00★ — 11574414290, 11591471612, 12226286073 ("Put all your habits in a stack"), 12641159776 ; Check-in of amounts, not just ticks, with custom units | 7 | PRAISE_FLEXIBLE — 11545582822 ("a task with a completely open schedule"), 12191447515, 13989459540 ; Stats: streaks, consistency, charts | 9 | PRAISE_ANALYTICS — 12537644066 ("das neue Update mit den Analytics"), 12712143678, 13749447160, 14482128335 ; Siri Shortcuts / automation, including NFC tags | 5 | PRAISE_SHORTCUTS — 11737999553, 11965090309, 12576699510, 12704247911, 12899474787 ("set it [on] one of my nfc tags") ; iCloud sync across devices | 3 | PRAISE_SYNC — 11832301736, 12476173581, 13910121511 ; CSV export | 1 | PRAISE_EXPORT — 12205288948 ("Lets me export my data as .csv, no lock-in") ; Check-in notes / Journal | 2 (as requests, pre-ship) | REQ_NOTES — 11602935317, 11764271619; shipped v1.9.0 ; Reminders | 3 (as requests, pre-ship) | REQ_REMINDERS — 11552968648, 11663987562, 11737999553; shipped v2.2.0

- **Where:** header lines 1-8; §2.1; §2.1 table (verbatim); §2.2; §2.3
- **This app does:** free 3 boards; one-time Powerpack $10 → Plus lifetime $24.99 + subscription
- **User reaction:** praise
- **Magnitude:** 172 reviews, 43 storefronts, 2024-07-24 → 2026-09-02 (770 days), mean 4.599★; 563 assignments (3.27/review); 91 codes
- **Direction for us:** none · **Report confidence:** header · **Generalisable:** app-specific
- **Review IDs:** `11528747861`, `11622746398`, `14122073599`, `11832349033`, `12230309851`
- **Canonical:** C012 Week / month / year grid views; C046 Shortcuts / Siri / URL scheme / API; C048 Flexible units / partial progress; C140 Market the generic-tracker use case; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R79-019 — Praised by absence: no ads (PRAISE_NO_ADS 5), no trackers (PRAISE_NO_TRACKING 3), no imposed gamification (PRAISE_NO_GAMIFICATION 2: 'Minimal incentive to follow some arbitrary set of rules to make habits stick, leaving it up to the user instead'), no account (1); U:anti_bloat 66 (38.37%, mean 4.98★); CSV export praised as 'no lock-in'.

- **Where:** §2.1 (absence praise)
- **This app does:** no ads, no tracking, no gamification, no account
- **User reaction:** praise
- **Magnitude:** anti_bloat 66 / 38.37% / 4.98★
- **Direction for us:** build-free · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11832349033`, `12230309851`, `12205288948`
- **Canonical:** C020 Data export / backup / CSV; C024 Streaks / gamification; C085 Address tracking / privacy visibly; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R79-023 — P1 craft — 'it feels like Apple built it': PRAISE_NATIVE_FEEL 11 (6.40%, 4.91★): 'looks and feels like an app made by Apple'; 'even Apple apps don't feel this good'; 'as light and fast as [the built-in] Reminders' (ko); 'Love the adoption of Liquid Glass'; in a category crowded with cute, animated, gamified trackers the differentiator is restraint executed well — 'Others are way too expensive or overly animated and cute. This one strikes a great balance.'

- **Where:** §3.3 P1
- **This app does:** native-feeling minimal design
- **User reaction:** praise
- **Magnitude:** craft_praise 117 / 68.02% / 4.87★; NATIVE_FEEL 11; ANIMATION 16 / 5.00★
- **Direction for us:** build-free · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11536173663`, `11751978838`, `12216769686`, `13615946826`, `13749447160`, `13744852606`, `14214708913`
- **Canonical:** C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek; C185 Aesthetic and a polished onboarding convert; they do not retain

### R79-026 — P4 the comparative win — COMP_TRIED_MANY 15, COMP_BEST 19 (U:competitive_win 27, 4.93★); most name the search: 'None of the apps I've used (and I've used them all)'; '色々なhabit trackerを探しましたが、デザインが一番気に入りました' (ja); 'entrega exatamente o que eu procurava a anos e nunca encontrei' (pt); COMP_BEST spans the whole window — the last review still calls it 'immernoch die beste Tracking App die ich finden konnte' while reporting a bug and asking for two features.

- **Where:** §3.3 P4
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** competitive_win 27 / 15.70% / 4.93★; COMP_BEST 19 (11.05%)
- **Direction for us:** none · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11545582822`, `12621694399`, `13989459540`, `14117040306`, `14501661045`
- **Canonical:** C005 Know which competitors buyers compare against; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R79-033 — N7 churn and substitution — U:competitive_loss 3 (1.74%, 1.67★): 'I will just use other alternatives by chinese developers'; 'Now UI bugs have made it unusable'; 'For anyone poor, I recommend 'Blossom'' — the only competitor named anywhere; three reviews are the entire churn evidence base; nobody reports cancelling or a refund.

- **Where:** §3.4 N7
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** competitive_loss 3 / 1.74% / 1.67★; COMP_CHEAPER_RIVAL 1
- **Direction for us:** none · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `13311025859`, `13836767975`, `14483046633`
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R79-074 — Removing the most-loved free component to push a cap that was already converting: the widget (27 praise at 5.00★, zero negative, the daily home-screen impression) went behind the wall in a 101-day window (Jul–Oct 2025) while the 3-board cap stayed — the cap's valence flipped from 'without huge limitations' (5★) to 'totaal niks' (3★), paywall_shape complaints went from 0/110 to ~10% of reviews, and the one explicit upgrade in the corpus was for more boards, not widgets; 'The cap is not the lever that broke; the bundle around it is.'

- **Where:** §0.4; §5.5; §8.4.1; §7.5
- **This app does:** widget gated ~Oct 2025
- **User reaction:** 1★-burst
- **Magnitude:** paywall_shape 0 → 6; WIDGET_GATED 2; PRAISE_WIDGET 27 / 5.00★
- **Direction for us:** dont · **Report confidence:** Very strong · **Generalisable:** generalisable
- **Review IDs:** `13311025859`, `14373214557`, `13681657252`, `12899474787`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free; C297 A free cap's acceptability is set by the bundle around it — the same number reads as generous or as a wall depending on what else is free; moving a loved feature behind the wall changes sentiment as much as changing the number

### R79-075 — Adding a subscription beside a one-time tier without a word of disclosure, after a year of selling 'no subscription' as the differentiator: 12 reviews chose the app because it was a one-time $10 purchase; the price then rose to €23 and monthly/yearly SKUs appeared with no billing period shown and no monetization text in the description — cost: money_negative 2.7% → 17.1%, 'bait and switch' in a 1★ title, 'Nutteloos zonder subscriptie', and the corpus's only 'used to be great' review listing the lost promise; money-positive reviews did not vanish (four still call the price fair after the rise) — the damage is in the surprise, not the amount.

- **Where:** §0.2; §0.8; §2.4; §8.4.2
- **This app does:** one-time → one-time + subscription, undisclosed
- **User reaction:** churn
- **Magnitude:** money_negative 2.7% → 17.1%; UNEXPECTED 2 / 2.00★; BAIT_SWITCH 1
- **Direction for us:** dont · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `13836767975`, `13681657252`, `14422900213`, `14483046633`, `13854797898`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C104 Never ship a paywall or feature-removal change silently; C294 When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically

## Things not to do

### R79-064 — §8.1.4 turn the review prompt down — two 1★ (mean 1.00★, 18.2% of the worst ratings) from people who say the app is good; 'i already rated this highly, but now I keep getting the review prompt after every check in. Lowering to 1 stars until fixed'; cap it: once per user, never after a check-in, never after a user has already rated — effect immediate and measurable in the rating stream.

- **Where:** §8.1.4; §8.6 #3; part 8 #3
- **This app does:** prompt after every check-in
- **User reaction:** 1★-burst
- **Magnitude:** UX_NAG_REVIEW 2 / 1.00★; 2 of 11 1★
- **Direction for us:** dont · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `13728350332`, `14173657564`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

### R79-069 — §8.5 do not: add gamification, streak pressure, social feeds or AI ('Minimal incentive to follow some arbitrary set of rules'; 'no extra gamification, no ads, no BS'; anti_bloat 38.37% at 4.98★; zero ask for social or AI) — 'the product's position IS restraint'; add ads (five praise their absence, zero ask for an ad tier); weaken privacy (three cite it as a reason to choose); rewrite the UI (68.02% craft praise; the 'unusable' review blames overhaul bugs, not design); treat the 4.599★ corpus mean as the app's rating (public 4.781★).

- **Where:** §8.5; part 8 #8
- **This app does:** restraint as position
- **User reaction:** praise
- **Magnitude:** anti_bloat 66 / 38.37% / 4.98★; NO_ADS 5; NO_TRACKING 3
- **Direction for us:** dont · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11832349033`, `13882115210`, `11832301736`, `12160259550`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C024 Streaks / gamification; C085 Address tracking / privacy visibly; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

## Things to do

### R79-014 — The shipping record is good where visible: REQ_NOTES (2 voices, Aug–Sep 2024) shipped v1.9.0; REQ_REMINDERS (3 voices, Jul–Sep 2024) shipped v2.2.0; REQ_WIDGET_MORE (5 voices, Aug 2024–Jan 2025) shipped v2.5.0 and a reviewer came back to edit — 'so happy to have compact boards now!'

- **Where:** §0.10 (shipping record)
- **This app does:** ships requested features; reviewers edit reviews up
- **User reaction:** praise
- **Magnitude:** 3 request codes shipped; 1 edited review
- **Direction for us:** do · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `11602935317`, `11764271619`, `11552968648`, `14118758406`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C172 Per-day / per-habit notes and journal text; C298 A public roadmap converts — and becomes a promise users hold you to

## Contradictions

### R79-044 — Rating does not determine theme direction (verbatim): Theme | Appears at 5★ | Appears at ≤3★ | Reading ; MON_ONETIME_PRAISE | 11 | 1 (13836767975, 1★) | The 1★ praises it in the past tense, as the thing that was lost ; MON_PRICE_LEVEL | 1 (13426922120) | 3 | A 5★ can object to the price and still rate 5 ; MON_FREE_GENEROUS | 10 | 0 | Never negative — but 14422900213 (1★) asserts the opposite of it two weeks before 14482128335 (5★) affirms it ; MON_CAP_STATED | 2 | 1 | The *same fact* (3 free boards) stated as generosity in 2024–25 and as an insult in 2026 ; DEF_DATA_LOSS | 0 | 3 (1★,1★,4★) | Two 1★ and one 4★ — the 4★ (14397430419) asks politely for the boards back ; UX_COMPACT | 2 | 0 | Requested by 11545582822, delivered, thanked for by 14118758406 ; PRAISE_DEV | 13 | 0 (one more at 4★) | vs SUP_NO_RESPONSE = 1, at 1★ — MON_CAP_STATED is the sharpest: three reviewers state the same number (three free boards) and the valence flips with the calendar — generosity in October 2024 and July 2025 ('without huge limitations'; 'Man kann aber auch gut ohne Leben'), 'je bent totaal niks' in January 2026; 'The cap did not change. What changed is what else went behind it… The cap is not the lever that broke; the bundle around it is.'

- **Where:** §4.8 table (verbatim); §4.8; §5.5
- **This app does:** 3-board cap constant; widget removed from free tier
- **User reaction:** mixed
- **Magnitude:** MON_CAP_STATED 3 (4.33★); same cap, valence 5★ → 3★
- **Direction for us:** product-rule · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Conditions:** a fixed cap's acceptability depends on what else is free alongside it
- **Review IDs:** `11832301736`, `12899474787`, `13681657252`, `13426922120`, `14201744091`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes; C297 A free cap's acceptability is set by the bundle around it — the same number reads as generous or as a wall depending on what else is free; moving a loved feature behind the wall changes sentiment as much as changing the number

## Data caveats and method

### R79-002 — Method and limits: every one of 172 reviews read in date order in its original language (13 languages, hand-identified), 91 hand codes all used, 563 assignments, 37 checks (17 re-derive codes from literal text; three caught real errors on first run), 15 absence tests, external capture 2026-09-13; no duplicates, no repeat authors; n=172 so one review is 0.58% (already 'Emerging') — Wilson CI beside every headline; no storefront reaches 50 (us 38, de 17, gb 12, in 10); version history begins v1.8.0 (2025-07-03) so 99 of 172 (57.56%) predate it; price history reconstructed from reviews, not an archive; 10 edited reviews carry their last-edit date; two giveaway-sourced reviews retained and flagged (removing them moves the mean <0.02★); low-info 7 (4.07%, all 5★) — excluding them moves every headline under 3 pp (verbatim) Union | With all 172 | Excluding the 7 | Change ; U:craft_praise | 117 = 68.02% | 117/165 = 70.91% | +2.89 pp ; U:money_positive | 24 = 13.95% | 24/165 = 14.55% | +0.60 pp ; U:money_negative | 14 = 8.14% | 14/165 = 8.48% | +0.34 pp ; U:negative_any | 27 = 15.70% | 27/165 = 16.36% | +0.66 pp; nothing here is a conversion rate (11 reviews carry purchase evidence).

- **Where:** How to read this; Nine warnings 1, 2, 6, 9; §1.1 table (verbatim); §1.2; §1.3 table (verbatim); §1.4; §1.5; §1.6; §1.7; §1.7 table (verbatim); §1.9
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 172/172 read; 91 codes; 37 checks; low-info 7
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** generalisable
- **Review IDs:** `11528747861`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R79-003 — Selection bias quantified: 937 public ratings across the same 43 storefronts vs 172 text reviews (18.4% of the base); ratings-weighted public mean 4.781★ vs corpus 4.599★ — the text corpus is ~0.18★ more negative; France is the extreme: 57 public ratings, 2 text reviews.

- **Where:** Warning 3, 4; §1.6.3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 937 ratings vs 172 text; 4.781 vs 4.599
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** generalisable
- **Review IDs:** `11528747861`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R79-016 — Fifteen claims tested and not found (zero hits in 13 languages): advertising complaints, privacy/data-selling, battery, accessibility, cancelling a subscription, a refund obtained, a support ticket, Android/web demand, Family Sharing, ADHD/clinical framing, AI, social/leaderboard, a first-launch paywall, forced account creation, inability to export; nobody reports cancelling or a refund (one threatens one) — the churn picture rests on 3 reviews (U:competitive_loss 1.74%); zero privacy complaints against 3 who volunteer privacy as why they chose it — 'Private by design' is working.

- **Where:** §0.11
- **This app does:** no ads, no account, private by design
- **User reaction:** mixed
- **Magnitude:** 15 absences; competitive_loss 3 / 1.74%; privacy-as-reason 3
- **Direction for us:** none · **Report confidence:** absence test · **Generalisable:** generalisable
- **Review IDs:** `11832301736`, `12160259550`, `14185235911`, `14173657564`
- **Canonical:** C085 Address tracking / privacy visibly; C209 No sign-up wall before first use; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R79-018 — Solicitation is confirmed by the corpus itself — two reviewers describe an in-app rating prompt and both rated 1★ specifically because of it: 'Great app, but I always leave one star reviews for apps that harass me with 'enjoying the app? Please leave a review' popups. It's gross. Change that behavior and I'll update this to 5 stars'; 'i already rated this highly, but now I keep getting the review prompt after every check in. Lowering to 1 stars until fixed' — the 83.14% 5★ share is what a satisfied user gives when asked at a good moment, and the prompt is producing 2 of 11 1★ (18.2% of the worst ratings from a growth mechanic); no burst (max 5/day, 9 per rolling week in launch fortnight), no repeat authors, no campaign; two giveaway-sourced reviews (an AppAdvice lifetime promo the reviewer could not redeem, rated 1★ partly for that; a competition win disclosed unprompted); rating-vs-text contradictions 5 (2.91%) (verbatim): # | ID | ★ | What contradicts ; 15 | 11602935317 | 5 | "5 звезд авансом. Много чего не хватает" — five stars given *in advance*, while saying much is missing ; 107 | 13066418808 | 5 | Body is entirely a complaint: "If I want to add 10 check-ins to a previous day it's very painful!" ; 131 | 13728350332 | 1 | "Great app, but I always leave one star reviews for apps that harass me…" ; 145 | 13992377824 | 5 | "Добавьте русский язык … Но обделили русских пользователей" — a grievance rated 5★ ; 152 | 14173657564 | 1 | A 1★ whose body says the original data problem was fixed and the app "rated highly" before; one off-topic 'six seven' meme review kept.

- **Where:** Warning 5, 8; §1.8; §1.8 table (verbatim); §0.12 #8; §8.2
- **This app does:** in-app review prompt after every check-in
- **User reaction:** 1★-burst
- **Magnitude:** 2 of 11 1★ caused by the prompt; contradictions 5 / 2.91%; giveaway 2
- **Direction for us:** dont · **Report confidence:** Meaningful · **Generalisable:** generalisable
- **Review IDs:** `13728350332`, `14173657564`, `12352054623`, `14185235911`, `11602935317`, `13066418808`, `13992377824`, `14187027057`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

### R79-022 — Complete theme table, 91 codes (verbatim): Code | Family | Dir | n | % of 172 | Wilson 95% | Mean ★ | Signal ; PRAISE_DESIGN | craft | pos | 71 | 41.28% | 34.2–48.7% | 4.87 | High-priority signal ; PRAISE_SIMPLICITY | craft | pos | 60 | 34.88% | 28.2–42.3% | 4.98 | High-priority signal ; PRAISE_EASE | craft | pos | 35 | 20.35% | 15.0–27.0% | 4.83 | High-priority signal ; PRAISE_WIDGET | feature | pos | 27 | 15.70% | 11.0–21.9% | 5.00 | High-priority signal ; COMP_BEST | competitive | pos | 19 | 11.05% | 7.2–16.6% | 4.95 | High-priority signal ; PRAISE_ROADMAP | developer | pos | 17 | 9.88% | 6.3–15.3% | 4.94 | High-priority signal ; PRAISE_ANIMATION | craft | pos | 16 | 9.30% | 5.8–14.6% | 5.00 | High-priority signal ; COMP_TRIED_MANY | competitive | pos | 15 | 8.72% | 5.4–13.9% | 4.93 | High-priority signal ; PRAISE_DEV | developer | pos | 14 | 8.14% | 4.9–13.2% | 4.93 | High-priority signal ; OUT_USE_CASE | outcome | pos | 13 | 7.56% | 4.5–12.5% | 4.85 | High-priority signal ; MON_ONETIME_PRAISE | money | pos | 12 | 6.98% | 4.0–11.8% | 4.67 | High-priority signal ; OUT_RECOMMEND | outcome | pos | 12 | 6.98% | 4.0–11.8% | 5.00 | High-priority signal ; PRAISE_NATIVE_FEEL | craft | pos | 11 | 6.40% | 3.6–11.1% | 4.91 | High-priority signal ; MON_FREE_GENEROUS | money | pos | 10 | 5.81% | 3.2–10.4% | 5.00 | High-priority signal ; MON_PRICE_FAIR | money | pos | 10 | 5.81% | 3.2–10.4% | 5.00 | High-priority signal ; PRAISE_PERFORMANCE | craft | pos | 10 | 5.81% | 3.2–10.4% | 4.90 | High-priority signal ; MON_PAID | money | mix | 9 | 5.23% | 2.8–9.6% | 3.22 | High-priority signal ; PRAISE_ANALYTICS | feature | pos | 9 | 5.23% | 2.8–9.6% | 5.00 | High-priority signal ; PRAISE_INDIE | developer | pos | 9 | 5.23% | 2.8–9.6% | 5.00 | High-priority signal ; PRAISE_MOTIVATING | position | pos | 9 | 5.23% | 2.8–9.6% | 5.00 | High-priority signal ; OUT_DAILY_USE | outcome | pos | 8 | 4.65% | 2.4–8.9% | 4.25 | Very strong signal ; INT_LOW_INFO | integrity | mix | 7 | 4.07% | 2.0–8.2% | 5.00 | Very strong signal ; MON_WILL_BUY | money | pos | 7 | 4.07% | 2.0–8.2% | 5.00 | Very strong signal ; PRAISE_FLEXIBLE | feature | pos | 7 | 4.07% | 2.0–8.2% | 4.71 | Very strong signal ; PRAISE_GITHUB_GRID | feature | pos | 7 | 4.07% | 2.0–8.2% | 5.00 | Very strong signal ; CH_YOUTUBE | channel | pos | 5 | 2.91% | 1.2–6.6% | 5.00 | Meaningful signal ; INT_RATING_CONTRADICT | integrity | mix | 5 | 2.91% | 1.2–6.6% | 3.40 | Meaningful signal ; MON_DECLINED_PURCHASE | money | neg | 5 | 2.91% | 1.2–6.6% | 3.20 | Meaningful signal ; MON_PRICE_LEVEL | money | neg | 5 | 2.91% | 1.2–6.6% | 3.20 | Meaningful signal ; OUT_HABIT_FORMED | outcome | pos | 5 | 2.91% | 1.2–6.6% | 5.00 | Meaningful signal ; PRAISE_NO_ADS | position | pos | 5 | 2.91% | 1.2–6.6% | 5.00 | Meaningful signal ; PRAISE_SHORTCUTS | feature | pos | 5 | 2.91% | 1.2–6.6% | 5.00 | Meaningful signal ; REQ_WIDGET_MORE | request | neg | 5 | 2.91% | 1.2–6.6% | 5.00 | Meaningful signal ; MON_PAYWALL_BLOCKS | money | neg | 4 | 2.33% | 0.9–5.8% | 1.75 | Meaningful signal ; CHURN_ABANDON | churn | neg | 3 | 1.74% | 0.6–5.0% | 1.67 | Meaningful signal ; DEF_DATA_LOSS | defect | neg | 3 | 1.74% | 0.6–5.0% | 2.00 | Meaningful signal ; MON_CAP_STATED | money | mix | 3 | 1.74% | 0.6–5.0% | 4.33 | Meaningful signal ; MON_ENTITLEMENT_FAIL | money | neg | 3 | 1.74% | 0.6–5.0% | 1.00 | Meaningful signal ; MON_SUPPORT_DEV | money | pos | 3 | 1.74% | 0.6–5.0% | 4.67 | Meaningful signal ; PRAISE_NO_TRACKING | position | pos | 3 | 1.74% | 0.6–5.0% | 5.00 | Meaningful signal ; PRAISE_SYNC | feature | pos | 3 | 1.74% | 0.6–5.0% | 5.00 | Meaningful signal ; REQ_REMINDERS | request | neg | 3 | 1.74% | 0.6–5.0% | 5.00 | Meaningful signal ; REQ_WATCH | request | neg | 3 | 1.74% | 0.6–5.0% | 4.33 | Meaningful signal ; REQ_WEEKLY_SCHEDULE | request | neg | 3 | 1.74% | 0.6–5.0% | 4.67 | Meaningful signal ; UX_COMPACT | friction | mix | 3 | 1.74% | 0.6–5.0% | 4.67 | Meaningful signal ; CH_GIVEAWAY | channel | mix | 2 | 1.16% | 0.3–4.1% | 3.00 | Meaningful signal ; CH_REDDIT | channel | pos | 2 | 1.16% | 0.3–4.1% | 5.00 | Meaningful signal ; COMP_SWITCH_AWAY | competitive | neg | 2 | 1.16% | 0.3–4.1% | 2.00 | Meaningful signal ; DEF_NOTIF_FAIL | defect | neg | 2 | 1.16% | 0.3–4.1% | 3.50 | Meaningful signal ; MON_PAID_IMPLIED | money | mix | 2 | 1.16% | 0.3–4.1% | 5.00 | Meaningful signal ; MON_SUB_OBJECTION | money | neg | 2 | 1.16% | 0.3–4.1% | 3.00 | Meaningful signal ; MON_UNEXPECTED | money | neg | 2 | 1.16% | 0.3–4.1% | 2.00 | Meaningful signal ; MON_WIDGET_GATED | money | neg | 2 | 1.16% | 0.3–4.1% | 2.50 | Meaningful signal ; PRAISE_NO_GAMIFICATION | position | pos | 2 | 1.16% | 0.3–4.1% | 5.00 | Meaningful signal ; REQ_IMPORT | request | neg | 2 | 1.16% | 0.3–4.1% | 5.00 | Meaningful signal ; REQ_IPAD | request | neg | 2 | 1.16% | 0.3–4.1% | 5.00 | Meaningful signal ; REQ_NEGATIVE_HABIT | request | neg | 2 | 1.16% | 0.3–4.1% | 5.00 | Meaningful signal ; REQ_NOTES | request | neg | 2 | 1.16% | 0.3–4.1% | 5.00 | Meaningful signal ; REQ_SYNC | request | neg | 2 | 1.16% | 0.3–4.1% | 5.00 | Meaningful signal ; UX_LIST_SCALE | friction | neg | 2 | 1.16% | 0.3–4.1% | 4.50 | Meaningful signal ; UX_NAG_REVIEW | friction | neg | 2 | 1.16% | 0.3–4.1% | 1.00 | Meaningful signal ; COMP_CHEAPER_RIVAL | competitive | neg | 1 | 0.58% | 0.1–3.2% | 3.00 | Emerging signal ; DEF_CHECKIN_SPAM | defect | neg | 1 | 0.58% | 0.1–3.2% | 4.00 | Emerging signal ; DEF_CRASH | defect | neg | 1 | 0.58% | 0.1–3.2% | 1.00 | Emerging signal ; DEF_REORDER_BUG | defect | neg | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; DEF_UI_BUG | defect | neg | 1 | 0.58% | 0.1–3.2% | 1.00 | Emerging signal ; INT_OFF_TOPIC | integrity | mix | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; LOC_QUALITY | locale | neg | 1 | 0.58% | 0.1–3.2% | 4.00 | Emerging signal ; LOC_REQUEST | locale | neg | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; MON_BAIT_SWITCH | money | neg | 1 | 0.58% | 0.1–3.2% | 1.00 | Emerging signal ; MON_PRICE_INCREASE | money | neg | 1 | 0.58% | 0.1–3.2% | 4.00 | Emerging signal ; MON_PROMO_FAIL | money | neg | 1 | 0.58% | 0.1–3.2% | 1.00 | Emerging signal ; MON_REFUND_THREAT | money | neg | 1 | 0.58% | 0.1–3.2% | 1.00 | Emerging signal ; PRAISE_EXPORT | feature | pos | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; PRAISE_NO_ACCOUNT | position | pos | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; REQ_ANNUAL_VIEW | request | neg | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; REQ_BEDTIME | request | neg | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; REQ_CATEGORIES | request | neg | 1 | 0.58% | 0.1–3.2% | 4.00 | Emerging signal ; REQ_DAY_START | request | neg | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; REQ_HEALTH | request | neg | 1 | 0.58% | 0.1–3.2% | 4.00 | Emerging signal ; REQ_ICONS_COLORS | request | neg | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; REQ_MULTIBOARD | request | neg | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; REQ_PHOTO | request | neg | 1 | 0.58% | 0.1–3.2% | 4.00 | Emerging signal ; REQ_RELATIVE_DATES | request | neg | 1 | 0.58% | 0.1–3.2% | 4.00 | Emerging signal ; REQ_REORDER | request | neg | 1 | 0.58% | 0.1–3.2% | 4.00 | Emerging signal ; REQ_ROADMAP_FASTER | request | neg | 1 | 0.58% | 0.1–3.2% | 3.00 | Emerging signal ; REQ_STREAK_SHARE | request | neg | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; REQ_UNDO_CHECKIN | request | neg | 1 | 0.58% | 0.1–3.2% | 4.00 | Emerging signal ; SUP_NO_RESPONSE | support | neg | 1 | 0.58% | 0.1–3.2% | 1.00 | Emerging signal ; UX_BULK_ENTRY | friction | neg | 1 | 0.58% | 0.1–3.2% | 5.00 | Emerging signal ; UX_ONBOARDING | friction | neg | 1 | 0.58% | 0.1–3.2% | 1.00 | Emerging signal || unions (verbatim): Union | n | % of 172 | Wilson 95% | Mean ★ | Signal ; U:craft_praise | 117 | 68.02% | 60.7–74.5% | 4.87 | High-priority signal ; U:feature_praise | 49 | 28.49% | 22.3–35.6% | 4.96 | High-priority signal ; U:anti_bloat | 66 | 38.37% | 31.4–45.8% | 4.98 | High-priority signal ; U:developer_equity | 36 | 20.93% | 15.5–27.6% | 4.94 | High-priority signal ; U:outcome_any | 35 | 20.35% | 15.0–27.0% | 4.77 | High-priority signal ; U:competitive_win | 27 | 15.70% | 11.0–21.9% | 4.93 | High-priority signal ; U:competitive_loss | 3 | 1.74% | 0.6–5.0% | 1.67 | Meaningful signal ; U:money_positive | 24 | 13.95% | 9.6–19.9% | 4.79 | High-priority signal ; U:money_negative | 14 | 8.14% | 4.9–13.2% | 2.21 | High-priority signal ; U:paywall_shape | 6 | 3.49% | 1.6–7.4% | 2.33 | Very strong signal ; U:price_objection | 5 | 2.91% | 1.2–6.6% | 3.20 | Meaningful signal ; U:purchase_evidence | 11 | 6.40% | 3.6–11.1% | 3.55 | High-priority signal ; U:purchase_intent | 7 | 4.07% | 2.0–8.2% | 5.00 | Very strong signal ; U:defect_any | 9 | 5.23% | 2.8–9.6% | 2.67 | High-priority signal ; U:paid_broken | 4 | 2.33% | 0.9–5.8% | 1.00 | Meaningful signal ; U:friction_any | 7 | 4.07% | 2.0–8.2% | 2.57 | Very strong signal ; U:request_any | 30 | 17.44% | 12.5–23.8% | 4.73 | High-priority signal ; U:locale_any | 2 | 1.16% | 0.3–4.1% | 4.50 | Meaningful signal ; U:negative_any | 27 | 15.70% | 11.0–21.9% | 2.70 | High-priority signal

- **Where:** §3.1 table (verbatim); §3.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 91 codes; 19 unions; craft_praise 117 (68.02%); money_positive 24 (13.95%) vs money_negative 14 (8.14%, 2.21★); paid_broken 4 (1.00★); request_any 30
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `11528747861`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R79-040 — Rating distribution (verbatim): Stars | Reviews | Share | Wilson 95% CI ; 5★ | 143 | 83.14% | 76.8–88.0% ; 4★ | 12 | 6.98% | 4.0–11.8% ; 3★ | 5 | 2.91% | 1.2–6.6% ; 2★ | 1 | 0.58% | 0.1–3.2% ; 1★ | 11 | 6.40% | 3.6–11.1% ; All | 172 | 100% | mean 4.599★ — the tail is inverted: 11 one-star and only 6 at 2★+3★ combined — dissatisfaction arrives as a zero, 'the signature of a transaction failing (a purchase, a data set, a prompt) rather than a product gradually underperforming'; the distribution is prompted (in-app review request) and 2 of 11 1★ exist because of the asking.

- **Where:** §4.1 table (verbatim); §4.1
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★ 143 (83.14%); 1★ 11 (6.40%); 2–3★ 6
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `13728350332`, `14173657564`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R79-041 — Theme profile by star band (verbatim) — 5★: Code | n | % of this star band | % of corpus ; PRAISE_DESIGN | 64 | 44.8% | 41.28% ; PRAISE_SIMPLICITY | 59 | 41.3% | 34.88% ; PRAISE_EASE | 32 | 22.4% | 20.35% ; PRAISE_WIDGET | 27 | 18.9% | 15.70% ; COMP_BEST | 18 | 12.6% | 11.05% ; PRAISE_ROADMAP | 16 | 11.2% | 9.88% ; PRAISE_ANIMATION | 16 | 11.2% | 9.30% ; COMP_TRIED_MANY | 14 | 9.8% | 8.72% ; PRAISE_DEV | 13 | 9.1% | 8.14% ; OUT_RECOMMEND | 12 | 8.4% | 6.98% || 4★: Code | n | % of this star band | % of corpus ; PRAISE_DESIGN | 5 | 41.7% | 41.28% ; PRAISE_EASE | 2 | 16.7% | 20.35% ; REQ_WATCH | 2 | 16.7% | 1.74% ; OUT_USE_CASE | 2 | 16.7% | 7.56% ; DEF_CHECKIN_SPAM | 1 | 8.3% | 0.58% ; REQ_UNDO_CHECKIN | 1 | 8.3% | 0.58% ; PRAISE_SIMPLICITY | 1 | 8.3% | 34.88% ; REQ_HEALTH | 1 | 8.3% | 0.58% ; PRAISE_PERFORMANCE | 1 | 8.3% | 5.81% ; PRAISE_NATIVE_FEEL | 1 | 8.3% | 6.40% || 3★: Code | n | % of this star band | % of corpus ; MON_PRICE_LEVEL | 2 | 40.0% | 2.91% ; MON_DECLINED_PURCHASE | 2 | 40.0% | 2.91% ; PRAISE_DESIGN | 2 | 40.0% | 41.28% ; MON_SUB_OBJECTION | 2 | 40.0% | 1.16% ; REQ_ROADMAP_FASTER | 1 | 20.0% | 0.58% ; MON_PAYWALL_BLOCKS | 1 | 20.0% | 2.33% ; MON_CAP_STATED | 1 | 20.0% | 1.74% ; OUT_DAILY_USE | 1 | 20.0% | 4.65% ; DEF_NOTIF_FAIL | 1 | 20.0% | 1.16% ; PRAISE_FLEXIBLE | 1 | 20.0% | 4.07% || 2★: Code | n | % of this star band | % of corpus ; MON_PAYWALL_BLOCKS | 1 | 100.0% | 2.33% || 1★: Code | n | % of this star band | % of corpus ; MON_PAID | 4 | 36.4% | 5.23% ; MON_ENTITLEMENT_FAIL | 3 | 27.3% | 1.74% ; MON_PAYWALL_BLOCKS | 2 | 18.2% | 2.33% ; CHURN_ABANDON | 2 | 18.2% | 1.74% ; UX_NAG_REVIEW | 2 | 18.2% | 1.16% ; INT_RATING_CONTRADICT | 2 | 18.2% | 2.91% ; DEF_DATA_LOSS | 2 | 18.2% | 1.74% ; UX_ONBOARDING | 1 | 9.1% | 0.58% ; CH_GIVEAWAY | 1 | 9.1% | 1.16% ; MON_PROMO_FAIL | 1 | 9.1% | 0.58%

- **Where:** §4.2 5★ table (verbatim); §4.2 4★ table (verbatim); §4.2 3★ table (verbatim); §4.2 2★ table (verbatim); §4.2 1★ table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** per-band code profiles
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `11528747861`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R79-045 — Eleven of 172 (6.40%) carry purchase evidence, mean 3.55★ vs corpus 4.599 — the only substantial segment rating below the corpus, produced entirely by four broken transactions, not buyer's remorse (verbatim): # | ID | Store | ★ | Date | Evidence type | Codes ; 35 | 11921754194 | in | 1 | 2024-11-07 | stated purchase | MON_PAID, MON_ENTITLEMENT_FAIL ; 45 | 12071906839 | ua | 5 | 2024-12-17 | stated purchase | OUT_RECOMMEND, MON_PAID, PRAISE_ROADMAP, REQ_MULTIBOARD, PRAISE_INDIE ; 66 | 12226286073 | dk | 5 | 2025-01-24 | implied purchase | MON_PRICE_FAIR, PRAISE_SIMPLICITY, PRAISE_WIDGET, MON_ONETIME_PRAISE, PRAISE_DEV, PRAISE_ROADMAP, MON_PAID_IMPLIED ; 74 | 12451932869 | pt | 5 | 2025-03-22 | stated purchase | PRAISE_DESIGN, PRAISE_SIMPLICITY, MON_PAID, PRAISE_ROADMAP ; 80 | 12537644066 | de | 5 | 2025-04-13 | implied purchase | PRAISE_ANALYTICS, REQ_NEGATIVE_HABIT, MON_ONETIME_PRAISE, MON_PRICE_FAIR, MON_PAID_IMPLIED ; 98 | 12759315641 | uz | 5 | 2025-06-10 | stated purchase | MON_PAID, PRAISE_DESIGN, PRAISE_SIMPLICITY, PRAISE_ANIMATION, PRAISE_WIDGET ; 124 | 13582314702 | us | 1 | 2026-01-01 | stated purchase | MON_PAID, MON_ENTITLEMENT_FAIL, SUP_NO_RESPONSE ; 134 | 13749447160 | fr | 5 | 2026-02-14 | stated purchase | PRAISE_NATIVE_FEEL, PRAISE_DESIGN, PRAISE_ANALYTICS, OUT_RECOMMEND, MON_PAID ; 152 | 14173657564 | ph | 1 | 2026-06-12 | stated purchase | DEF_DATA_LOSS, MON_REFUND_THREAT, MON_PAID, UX_NAG_REVIEW, INT_RATING_CONTRADICT ; 155 | 14192253561 | us | 1 | 2026-06-17 | stated purchase | MON_PAID, MON_ENTITLEMENT_FAIL ; 156 | 14201744091 | nl | 5 | 2026-06-19 | stated purchase | OUT_RECOMMEND, MON_PAID, MON_SUPPORT_DEV || verbatim evidence: # | ID | ★ | Date | What they said ; 35 | 11921754194 | 1 | 2024-11-07 | "I paid for the pro features but still features are not unlocked" ; 45 | 12071906839 | 5 | 2024-12-17 | "Не задумуючись придбав Powerpack" (bought Powerpack without hesitating) ; 74 | 12451932869 | 5 | 2025-03-22 | "Bought it and looking forward to the updates" ; 98 | 12759315641 | 5 | 2025-06-10 | "Чекер+ был куплен в тот же день, когда установил приложение" (bought the same day I installed it) ; 124 | 13582314702 | 1 | 2026-01-01 | "Lifetime purchase doesn't work. Restore purchases doesn't work." ; 134 | 13749447160 | 5 | 2026-02-14 | "j'ai acheté l'application après seulement quelques jours d'utilisation" ; 152 | 14173657564 | 1 | 2026-06-12 | "I'll refund my subscription if this doesn't get fixed soon" ; 155 | 14192253561 | 1 | 2026-06-17 | "Pagué por la versión premium pero no puedo usarla en mis dos celulares" ; 156 | 14201744091 | 5 | 2026-06-19 | "upgraded for more boards and to support the developer" — 'Чекер+ был куплен в тот же день, когда установил приложение'; 'j'ai acheté l'application après seulement quelques jours d'utilisation'; 'upgraded for more boards and to support the developer'; five of nine stated payers rated 5★, four 1★, none 2–4: 'paying this developer is, on the evidence of this corpus, a binary experience'. Segment rates (verbatim): Segment rate | Segment | Global ; MON_ENTITLEMENT_FAIL among stated payers | 3 / 9 = 33.3% | 3 / 172 = 1.74% ("Meaningful signal") ; MON_PAID among 1★ reviews | 4 / 11 = 36.4% | 9 / 172 = 5.23% ; Money-negative among 1★–3★ reviews (n=17) | 11 / 17 = 64.7% | 14 / 172 = 8.14% ; PRAISE_WIDGET among 5★ reviews | 27 / 143 = 18.9% | 27 / 172 = 15.70% ; INT_LOW_INFO among 5★ reviews | 7 / 143 = 4.9% | 7 / 172 = 4.07% ; U:craft_praise among the five 5★ stated payers | 3 / 5 = 60.0% | 117 / 172 = 68.02% — money-negative is 11 of 17 reviews below 4★ (64.7%); satisfied payers praise craft at the corpus rate.

- **Where:** §5.1 table (verbatim); §5.1; §5.2 table (verbatim); §5.2; §5.7 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** purchase_evidence 11 / 6.40% / 3.55★; payers 5×5★ + 4×1★
- **Direction for us:** must-never-break · **Report confidence:** High-priority · **Generalisable:** generalisable
- **Review IDs:** `11921754194`, `12071906839`, `12451932869`, `12759315641`, `13582314702`, `13749447160`, `14173657564`, `14192253561`, `14201744091`, `12226286073`, `12537644066`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R79-048 — Refunds, cancellations and renewals — an explicit blank: zero refunds obtained, zero cancellations, zero renewals across 172 reviews in 13 languages; one refund threat ('I'll refund my subscription if this doesn't get fixed soon') whose own later edit says the problem resolved; the churn picture rests on three reviews.

- **Where:** §5.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 0 / 0 / 0; 1 threat
- **Direction for us:** research · **Report confidence:** absence test · **Generalisable:** generalisable
- **Review IDs:** `14173657564`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R79-052 — Where the anger sits (verbatim): Slice | n | Mean ★ | 1★ count ; Storefronts with exactly 1 review (12 of 43) | 12 | 4.50 | 0 ; Storefronts with ≤2 reviews (26 of 43) | 40 | 4.53 | 2 ; United States alone | 38 | 4.32 | 6 ; Everything else | 134 | 4.68 | 5 — unlike many small corpora the long tail is not the negative part: single-review storefronts average 4.50★ with zero 1★; the one-star mass sits in the largest storefront (US 38, 4.32★, 6 1★ vs 4.68★ elsewhere); whether that is absolute pricing or sample size cannot be separated at n=38.

- **Where:** §6.5 table (verbatim); §6.5
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 1-review stores 12 / 4.50★ / 0 1★; US 38 / 4.32★ / 6 1★; rest 134 / 4.68★
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `13582314702`, `14192253561`, `14422900213`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R79-061 — Persisted across 770 days: craft praise in every quarter; COMP_BEST 2024-09 → 2026-09; widgets 27 at 5.00★ (2024-08 → 2026-06); zero complaints about ads, privacy, battery, accessibility or forced accounts; the three-board cap never moved. Cannot say: the date of the pricing change (bracketed only); which single cause drove the rating decline (pricing, widget gating, the v2.1.0 regression and the review prompt are all live in the same window); whether a composition shift explains it (E1 arrived from YouTube/Reddit; a drop from 4.89 to 4.02 is consistent with a harsher audience as well as a worse experience); volume trend.

- **Where:** §7.8; §7.9
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5 persistences; 4 unanswerables
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `14501661045`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings
