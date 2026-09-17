# Cards — report 52

Source: `App Store Reports/52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus (REPORT).md`  
210 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 10
- [Must-haves](#must-haves) — 4
- [Must never break](#must-never-break) — 22
- [Features](#features) — 37
- [Monetization](#monetization) — 19
- [Tactics the app used](#tactics-the-app-used) — 5
- [Insights (the why)](#insights-the-why) — 24
- [Audiences](#audiences) — 5
- [Markets and languages](#markets-and-languages) — 20
- [Dated events and trends](#dated-events-and-trends) — 21
- [Positioning](#positioning) — 3
- [Anti-patterns](#anti-patterns) — 7
- [Things not to do](#things-not-to-do) — 2
- [Things to do](#things-to-do) — 5
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 25

## Product rules

### R52-036 — Reviewers ask that social features never be added: SOC_NOSOCIAL 120 (0.58%, emerging, mean 4.85); the third most-upvoted review in the corpus (48 votes) ends 'please never add social features, I just want to check in quietly by myself'

- **Where:** §0.6 SOC_NOSOCIAL; §3.4 P6
- **This app does:** absent: no social layer
- **User reaction:** praise
- **Magnitude:** 120 (0.58%, 4.85); 48-vote review
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `2584511973`
- **Canonical:** C131 No default-on social feed in a personal tool; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R52-041 — Honoured lifetime purchases build unusual loyalty: DEV_TRUST 213 (1.03%, meaningful, mean 4.93 — the highest-mean theme above 100 reviews); 'I thought I'd have to pay again, but it said: you are a lifetime member. I nearly cried' (5★, 2021, reinstalled years later)

- **Where:** §0.8 DEV_TRUST; §3.4 P4
- **This app does:** lifetime membership honoured years later
- **User reaction:** praise
- **Magnitude:** 213 (1.03%, 4.93)
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8082408412`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C186 Never revoke what earlier buyers paid for when the model changes

### R52-059 — The monetisation history is a sequence of re-scopings of what was already owned — one-time unlock → tiered unlock → subscription (2020); free themes for premium members → paid themes → themes free again; free year statistics → VIP (2025); ad-free for everyone → ad-free for ¥8 (2025) — each generated its own complaint wave; PAY_REGRESS (existing entitlement reduced) 75 (0.36%, weak, mean 2.15) is the lowest-mean price theme after PAY_SCAM and PAY_REFUND; where old entitlements were honoured reviewers wrote some of the warmest reviews — 'Honouring old purchases costs almost nothing and is the single strongest trust signal in these reviews'

- **Where:** §2.4
- **This app does:** re-scoped existing entitlements four times
- **User reaction:** 1★-burst
- **Magnitude:** PAY_REGRESS 75 (0.36%, 2.15)
- **Direction for us:** product-rule · **Report confidence:** weak (theme) / report's structural reading · **Generalisable:** generalisable
- **Review IDs:** `2692072328`, `8082408412`, `9563598738`, `11466372895`
- **Canonical:** C001 Never move a free feature behind the paywall; C186 Never revoke what earlier buyers paid for when the model changes

### R52-110 — The check-in loop: fast is the feature — CORE_CHECK 217 (1.05%, meaningful, mean 4.87): one tap, a sound, the icon lighting up; every change that added a step was reviewed negatively within days: the June 2021 status sheet; the removal of 'tap again to undo' ('you used to tap again to cancel; now you can only choose failed', 2024); the 2026 'habit ball' collection that couldn't be hidden; multi-check habits that force a detail sheet even with one-tap enabled

- **Where:** §4.1
- **This app does:** one-tap check-in, repeatedly slowed by releases
- **User reaction:** praise
- **Magnitude:** CORE_CHECK 217 (1.05%, 4.87)
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `10956751942`, `13991192760`, `14001497640`, `14460646052`
- **Canonical:** C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R52-126 — Scope creep: to-dos (CORE_TODO 307 rose to 3.0% of 2024 reviews when 小事 shipped) and focus (FOCUS 390 rose to 5.5% of 2026 reviews) are accepted but consistently ranked below check-in speed — 'product manager, please don't add features blindly — restraint, restraint' (5★, Aug 2026); a careful to-do and timer spec (4★, 2026); the August 2026 focus page redesign is the latest instance

- **Where:** §4.7
- **This app does:** added to-dos, focus timer, AI
- **User reaction:** mixed
- **Magnitude:** CORE_TODO 3.0% of 2024; FOCUS 5.5% of 2026
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `14103541349`, `14398335606`, `13842773106`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C050 One-off to-dos alongside habits; C066 Focus timer

### R52-189 — F2: no ads for any paying member, including legacy lifetime and ¥8 ad-free buyers; verify entitlement before rendering the first ad — success signal zero AD_NEG ∩ PAY_BOUGHT

- **Where:** §9.1 F2; part 9 #1
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 40 paying reviewers reported ads (2019–2026)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps

### R52-190 — F3: never gate restoring a user's own backup behind membership — success DATA_LOSS ∩ PAY_* → 0; with F4 'stops the worst 1★ reviews, from the users who paid'

- **Where:** §9.1 F3; part 9 #2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 32 reviews; payer data-loss mean 1.73
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R52-196 — M1: keep the lifetime option and grandfather every past entitlement explicitly — re-scoping drives PAY_REGRESS (mean 2.15) and PAY_SCAM (86% 1★); honoured lifetimes drive DEV_TRUST (mean 4.93)

- **Where:** §9.2 M1
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** PAY_REGRESS 2.15; PAY_SCAM 86% 1★; DEV_TRUST 4.93
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

### R52-203 — R1: redesigns ship behind a setting for at least one release (old focus page, AI titles off, habit balls hidden, compact widget) — four redesign waves; do this before the next UI change ships

- **Where:** §9.3 R1; part 9 #4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** four redesign waves
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13403164932`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R52-204 — R2: protect one-tap check-in and one-tap undo (June 2021 and 2024 regressions)

- **Where:** §9.3 R2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C223 Undo / un-complete is a visible button — never a gesture-only path; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

## Must-haves

### R52-074 — Support silence: SUP_BAD 184 (0.89%, emerging, mean 2.33) rises with each crash wave (2018: 48; 2024: 27; 2025: 23); among payers 4.53× lift and a 1.92 mean; email, WeChat, Weibo and Xiaohongshu channels reported unanswered; SUP_ASK 102 (0.49%, weak) request a contact channel

- **Where:** §3.3 N8
- **This app does:** support channels unanswered
- **User reaction:** complaint
- **Magnitude:** 184 (0.89%, 2.33); payers ×4.53 at 1.92; 2018 48 / 2024 27 / 2025 23
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `5718060639`, `7678755936`, `9932746241`, `12099235782`, `12506637899`, `13185604830`, `14460646052`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R52-106 — Annoying notifications: REM_ANNOY 155 (0.75%, emerging, mean 3.26), first seen 2020-07-13 — notifications that nag or cannot be tuned

- **Where:** §3.1 REM_ANNOY row
- **This app does:** notifications nag
- **User reaction:** complaint
- **Magnitude:** 155 (0.75%, 3.26)
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** generalisable
- **Canonical:** C123 Notifications are few and finely user-controllable — per-type settings, escalation opt-in, never spammy and never silently retuned

### R52-191 — F4: account-bound restore that works across reinstall, iPad, Mac and Android (including QQ-era Android buyers); fix Mac WeChat binding — success PAY_RESTORE < 0.3%

- **Where:** §9.1 F4; part 9 #2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** PAY_RESTORE 190; Android ∩ tier/restore 49; Mac binding 12 since 2021
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C035 Account system from day one; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R52-206 — R8: an in-app feedback channel with a visible reply — SUP_BAD 184 with payer mean 1.92; fast fixes are among the strongest praise

- **Where:** §9.3 R8
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** SUP_BAD 184; payer mean 1.92
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

## Must never break

### R52-015 — Paying members still see ads — 40 reviews AD_NEG ∩ PAY_BOUGHT (all years): 'I bought lifetime membership before… now there are too many ads, an ugly ad pops up at every check-in' (1★, Jun 2025); the decision: never show ads after a check-in or to any payer

- **Where:** §0.1 bullet; §0.9 #1
- **This app does:** lifetime and ad-free buyers shown ads, including on check-in
- **User reaction:** 1★-burst
- **Magnitude:** 40 reviews
- **Direction for us:** must-never-break · **Report confidence:** very strong (parent theme) · **Generalisable:** generalisable
- **Review IDs:** `12795677855`, `14301818772`, `13876926025`, `4189381643`
- **Canonical:** C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps

### R52-026 — Memberships don't travel across devices or platforms: PAY_RESTORE 190 (0.92%, emerging, mean 2.61); DATA_SYNC_FAIL 151 (0.73%, emerging, 3.23); PLAT_ANDROID 195 (0.95%, emerging, 3.53); PLAT_MAC 37 (0.18%, weak, 3.81); data integrity union (loss, sync failure or restore failure) 518 (2.51%, meaningful, mean 2.85); decision: one account owns the membership and the data across iPhone, iPad, Mac and Android

- **Where:** §0.4
- **This app does:** membership bound per platform; restore unreliable
- **User reaction:** complaint
- **Magnitude:** PAY_RESTORE 190 (0.92%, 2.61); union 518 (2.51%, 2.85)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `6663079686`, `12506637899`
- **Canonical:** C030 Sync must work — and prove it; C033 Restore purchase and entitlements must work immediately; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R52-028 — iPhone ↔ iPad: 147 reviews combine PLAT_IPAD with sync failure, a sync request or a restore failure (0.71%, emerging); an iPhone membership isn't recognised on iPad (2020); a lifetime member reports two years of sync complaints across several feedback channels with no reply (1★, 2025)

- **Where:** §0.4 bullet iPhone ↔ iPad
- **This app does:** iPad does not honour iPhone membership; iPad sync unreliable
- **User reaction:** complaint
- **Magnitude:** 147 (0.71%)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `6663079686`, `12506637899`
- **Canonical:** C030 Sync must work — and prove it; C033 Restore purchase and entitlements must work immediately; C141 Native iPad layout

### R52-032 — DATA_LOSS 229 (1.11%, meaningful, mean 2.73; 85 at 1★); 56 tie the loss directly to an update or crash — 'four years of to-do records all gone… I bought lifetime membership for this' after the 28 Jul 2025 update (1★)

- **Where:** §0.5 DATA_LOSS
- **This app does:** update and crash wipe local records
- **User reaction:** 1★-burst
- **Magnitude:** 229 (1.11%, 2.73); 85 1★; 56 update/crash-linked
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `12957540481`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C175 Updates must not break function or wipe progress

### R52-049 — gb storefront, Apr 2023: a 'lifetime' purchase billed as £12.99/month

- **Where:** §2.2 Apr 2023 row
- **This app does:** SKU labelled lifetime billed monthly
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `9809502780`
- **Canonical:** C029 Billing must be exactly right; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R52-067 — Reliability failure union N4 2,608 (12.64%, high-priority, mean 3.49), release-clustered: BUG_FEATURE (a named feature broken) 647 (3.14%, very strong, mean 3.56); BUG_UPDATE (an update caused it) 524 (2.54%, meaningful, 3.26); PLAT_WIDGET_BUG 454 (2.20%, meaningful, 3.91); BUG_CRASH 412 (2.00%, 3.22); REM_FAIL 279 (1.35%, 3.45); DATA_LOSS 229 (1.11%, 2.73); CARD_BUG 193 (0.94%, emerging, 3.96 — 93.3% in 2018–2021); BUG_DISPLAY 181 (0.88%, 3.83); DATA_SYNC_FAIL 151 (0.73%, 3.23); BUG_LAG 132 (0.64%, emerging, 3.08)

- **Where:** §3.3 N4 list
- **This app does:** release-clustered defects
- **User reaction:** 1★-burst
- **Magnitude:** 2,608 (12.64%, 3.49)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Canonical:** C031 Crashes / launch failures; C175 Updates must not break function or wipe progress

### R52-068 — Widget defects: PLAT_WIDGET_BUG 454 (2.20%, meaningful, mean 3.91, 2017-12 → 2026-09) against PLAT_WIDGET_GOOD 48 (0.23%, weak, 4.79)

- **Where:** §3.3 N4 PLAT_WIDGET_BUG; §3.1
- **This app does:** widgets buggy
- **User reaction:** complaint
- **Magnitude:** 454 (2.20%, 3.91)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R52-069 — Reminders don't fire: REM_FAIL 279 (1.35%, meaningful, mean 3.45) — with a 3.62× lift among payers (4.9% of payers), a top paid-user failure

- **Where:** §3.3 N4 REM_FAIL; §0.3
- **This app does:** reminders unreliable
- **User reaction:** complaint
- **Magnitude:** 279 (1.35%, 3.45); payers 4.9% ×3.62
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C039 Reminders fire reliably, once; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R52-070 — Entitlement broken union N5 573 (2.78%, meaningful, mean 2.96): PAY_BILLING 261 (1.26%, mean 3.51) — 83.5% in 2018–2020: purchases that spin forever, double charges, a price shown as ¥12 but charged ¥31, no Alipay/WeChat Pay; PAY_RESTORE 190 (0.92%, 2.61); PAY_REGRESS 75 (0.36%, 2.15); PAY_PRICE_RISE 42 (0.20%); PAY_REFUND 32 (0.16%, 1.91)

- **Where:** §3.3 N5 PAY_BILLING
- **This app does:** billing defects 2018–2020
- **User reaction:** 1★-burst
- **Magnitude:** 573 (2.78%, 2.96); PAY_BILLING 261 (1.26%, 3.51)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `1953868037`, `2404783757`, `2415453515`, `5560444593`
- **Canonical:** C029 Billing must be exactly right

### R52-071 — A reviewer-reported carrier-billing incident: an SMS login subscribed the user to ¥55/month of China Mobile services (1★, Nov 2025) — a single report, flagged as a potential legal and billing exposure, not a pattern

- **Where:** §3.3 N5 carrier-billing incident
- **This app does:** SMS login tied to carrier subscription (reported)
- **User reaction:** 1★-burst
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** single report · **Generalisable:** generalisable
- **Review IDs:** `13342556684`
- **Canonical:** C029 Billing must be exactly right

### R52-072 — DES_DENSE (cluttered, too dense) 427 (2.07%, meaningful, mean 3.63) is persistent (1.4–3.9% every year); DES_REDESIGN 372 (1.80%, 3.39) is event-driven; DES_NEG 102 (0.49%, weak, 3.62)

- **Where:** §3.3 N6
- **This app does:** interface growing dense
- **User reaction:** complaint
- **Magnitude:** DES_DENSE 427 (2.07%, 3.63); DES_REDESIGN 372 (1.80%, 3.39)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R52-076 — Privacy and permissions: DATA_PRIVACY 65 (0.32%, weak, mean 3.48) — location access ('still using location after uninstall'), a dead privacy-policy link (nz), a passcode lock that an ad dismissal bypasses (2025), and forced iCloud or Apple-ID binding; individually weak but the passcode bypass and location claims are security-relevant and recorded despite the band

- **Where:** §3.3 N10
- **This app does:** passcode bypassed by ad dismissal; location use; dead privacy link
- **User reaction:** complaint
- **Magnitude:** 65 (0.32%, 3.48)
- **Direction for us:** must-never-break · **Report confidence:** weak (security-relevant) · **Generalisable:** generalisable
- **Review IDs:** `11313989030`, `9500642269`, `6897719071`, `13404013818`, `14366400588`, `14389575364`
- **Canonical:** C085 Address tracking / privacy visibly; C096 Privacy and discretion stack

### R52-107 — Account / login problems: DATA_ACCOUNT 200 (0.97%, emerging, mean 3.40) — QQ vs WeChat login split by platform, WeChat unbindable on Mac

- **Where:** §3.1 DATA_ACCOUNT row
- **This app does:** login split by platform
- **User reaction:** complaint
- **Magnitude:** 200 (0.97%, 3.40)
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** generalisable
- **Canonical:** C035 Account system from day one

### R52-118 — Reminders are the reason people install and a top paid-user failure (verbatim table: REM_GOOD 185 0.90% 4.88; REM_FAIL 279 1.35% 3.45; REM_WANT 588 2.85% 4.36; REM_ANNOY 155 0.75% 3.26); among payers REM_FAIL has a 3.62× lift (63 of 1,286) because reminders were the gated feature in 2017, so reviewers bought or reviewed for them; failures: silent mode kills the sound; reminders keep firing after the habit is done (23-vote review); archived habits still remind; changed reminder sounds revert; notifications stop entirely (paid)

- **Where:** §4.4 table (verbatim)
- **This app does:** reminders with multiple defects
- **User reaction:** complaint
- **Magnitude:** Theme | n | % | Mean ★ ; REM_GOOD | 185 | 0.90% | 4.88 ; REM_FAIL | 279 | 1.35% | 3.45 ; REM_WANT | 588 | 2.85% | 4.36 ; REM_ANNOY | 155 | 0.75% | 3.26
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `5553105088`, `3720806853`, `3942069540`, `14196747453`, `10789570246`, `8593368940`
- **Canonical:** C039 Reminders fire reliably, once

### R52-119 — Reminders must stop once the habit is done and must not fire for archived habits: 'reminders keep firing after the habit is done' (23 votes); archived habits still remind; changed reminder sounds revert

- **Where:** §4.4 bullet reminders after done
- **This app does:** reminds after completion and after archive
- **User reaction:** complaint
- **Magnitude:** 23-vote review
- **Direction for us:** must-never-break · **Report confidence:** meaningful (parent) · **Generalisable:** generalisable
- **Review IDs:** `3720806853`, `3942069540`, `14196747453`, `10789570246`
- **Canonical:** C039 Reminders fire reliably, once

### R52-122 — Autosave so an interrupted note isn't lost

- **Where:** §4.5 #3
- **This app does:** notes lost on interruption
- **User reaction:** complaint
- **Magnitude:** report gives none
- **Direction for us:** must-never-break · **Report confidence:** very strong (parent) · **Generalisable:** generalisable
- **Review IDs:** `9989639645`, `13861341315`
- **Canonical:** C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R52-125 — Widget renders blank on iOS 26 with Clear/Tinted home-screen appearance

- **Where:** §4.6 iOS 26 widget
- **This app does:** widget blank under new OS appearance modes
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** meaningful (parent) · **Generalisable:** generalisable
- **Review IDs:** `14329669709`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R52-127 — The focus app-block list works backwards, allowing only the blocked apps (3★, 2026)

- **Where:** §4.7 bullet app-block
- **This app does:** broken: app-block list inverted
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** meaningful (parent) · **Generalisable:** generalisable
- **Review IDs:** `13842773106`
- **Canonical:** C066 Focus timer

### R52-154 — Post-purchase problems — why payers turn 1★ (verbatim): reliability failure after paying 286 (22.2%, 3.04); membership not restored / not recognised on new device 38 (3.0%); support silence 52 (4.0%, 1.92); data lost 33 (2.6%, 1.73); ads while paying 40 (3.1%, 2.85); entitlement reduced / re-priced / double charged 80 (6.2%, 2.62); reminders failing 63 (4.9%)

- **Where:** §6.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Problem | Payers (segment n of 1,286) | Segment mean ★ | Global n | IDs ; Reliability failure after paying | 286 (22.2%) | 3.04 | 2,608 | 11769437560 13151145215 11764717780 ; Membership not restored / not recognised on new device | 38 (3.0%) | — | 190 | 9932746241 6663079686 13082395093 ; Support silence | 52 (4.0%) | 1.92 | 184 | 9932746241 12506637899 14280113143 ; Data lost | 33 (2.6%) | 1.73 | 229 | 12957540481 11764810805 14018590420 ; Ads while paying | 40 (3.1%) | 2.85 | 885 | 4189381643 6130073882 12795677855 ; Entitlement reduced / re-priced / double charged | 80 (6.2%) incl. restore & billing | 2.62 | 573 | 6268143177 6909488103 11012729767 14450688542 ; Reminders failing | 63 (4.9%) | — | 279 | 8593368940 2497510762
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `11769437560`, `9932746241`, `12957540481`, `4189381643`, `6268143177`, `8593368940`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R52-155 — The clearest current billing case (tw, 1★, Aug 2026): bought the lifetime unlock for NT$390 during a trial, was then charged NT$220 for the annual plan when the trial converted, and e-mails to support bounced

- **Where:** §6.4 14450688542
- **This app does:** trial auto-converted after a lifetime purchase; support e-mail bounces
- **User reaction:** 1★-burst
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** single case · **Generalisable:** generalisable
- **Review IDs:** `14450688542`
- **Canonical:** C029 Billing must be exactly right; C036 A support channel that exists, is reachable outside the app, and answers; C109 A free trial must be a real trial

### R52-192 — F5: release gate for old iOS (14.x) and data migrations; staged rollout; crash-safe local store before schema changes — success no month with ≥20 BUG_CRASH; 'the next crash wave is statistically due'

- **Where:** §9.1 F5; part 9 #3
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** six crash waves = 42.5% of crash reviews; three with data loss
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C156 Content and event releases need a crash gate across device generations; C175 Updates must not break function or wipe progress

### R52-193 — F6: a passcode lock must not be bypassed by an ad dismissal; audit location permission requests in non-cn locales — success no privacy/lock reports

- **Where:** §9.1 F6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 13404013818; 11313989030
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13404013818`, `11313989030`
- **Canonical:** C096 Privacy and discretion stack

## Features

### R52-029 — Mac build: WeChat account cannot be bound, reported by 12 reviews 2021–2026 — among the most-upvoted reviews (10 votes, 2022; 4 votes, 2021); 'people raised this three years ago' (1★, Dec 2024)

- **Where:** §0.4 bullet Mac
- **This app does:** broken: Mac build cannot bind WeChat login, unresolved five years
- **User reaction:** complaint
- **Magnitude:** 12 reviews; 10- and 4-vote reviews
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** app-specific
- **Review IDs:** `9113611996`, `7733162522`, `12099235782`
- **Canonical:** C035 Account system from day one; C044 Mac / desktop / web app

### R52-042 — Reward mechanics are liked and growing: STAT_REWARD (光芒值 'sunshine points' earned by check-ins and exchanged for self-set rewards) 312 (1.51%, meaningful, mean 4.65), rising from 0.1–0.8% of reviews before 2021 to 1.9–3.1% from 2021 on

- **Where:** §0.8 STAT_REWARD; §3.4 P5
- **This app does:** free: points exchanged for self-set rewards
- **User reaction:** praise
- **Magnitude:** 312 (1.51%, 4.65); <2021 0.1–0.8% → 2021+ 1.9–3.1%
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C052 Points / rewards / wish list

### R52-044 — Product surfaces per reviewers (verbatim table): a hand-drawn pastel '小清新' habit check-in app that over nine years added to-dos, notes, rewards, focus timing and statistics — habit check-in grouped by time-of-day scenes (起床 / 晨间 / 中午 / 晚间); illustrated icon library, palettes, themes/skins, fonts, later custom uploaded images; daily quote card saved to a card wallet; check-in notes and a standalone notes stream with 'on this day in past years' and AI note titles (2026); per-habit reminders, hourly chime, 'strong reminder'; 光芒值 reward points exchanged for self-defined wishes and a 'habit balls' collection (2026); weekly/monthly calendars, day timeline, year statistics (moved to VIP Dec 2025); to-dos with priorities (~2024); pomodoro and count-up focus timer linked to habits with an app-blocking list; home-screen and Today widgets; sibling apps from the same studio

- **Where:** §2.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Surface | Review-derived description | Theme evidence | Representative IDs ; Habit check-in (日常) | Tap an icon to complete a habit; habits grouped by time of day (起床 / 晨间 / 中午 / 晚间 "scenes"); daily, weekly and custom frequencies | CORE_CHECK 217 · CORE_SEGMENT 159 · CORE_FREQ 299 | 2239007655 3254531371 10229830471 ; Habit icons & styles | Illustrated icon library, colour palettes, themes/skins, fonts; later custom uploaded images | DES_ICON_LIKE 321 · DES_ICON_WANT 561 · DES_THEME 343 | 5234243491 13663058300 14449455617 ; Daily card (卡片 / 卡包) | Completing the day's habits yields a quote card, saved to a card wallet | CARD_GOOD 106 · CARD_BUG 193 · CARD_WANT 154 | 2584511973 2114506602 7503066855 ; Check-in notes (打卡日志 / 碎碎念) | A note per check-in; later a standalone notes stream; "on this day in past years" (往年今日); AI note titles (2026) | JRNL_GOOD 234 · JRNL_WANT 668 | 6984394901 12696434160 13930545782 ; Reminders (提醒 / 整点报时) | Per-habit reminders; hourly chime; "strong reminder" | REM_GOOD 185 · REM_FAIL 279 · REM_WANT 588 | 4607325416 5553105088 8593368940 ; Rewards (光芒值 / 光芒心愿) | Points per check-in, exchanged for self-defined wishes; "habit balls" collection (2026) | STAT_REWARD 312 · STAT_PENALTY 21 | 11663316873 13992537486 13591116003 ; Statistics | Weekly/monthly calendars, timeline of the day, year statistics (moved to VIP Dec 2025) | STAT_GOOD 155 · STAT_WANT 478 | 5813993595 13559154241 13983550843 ; To-dos (小事) | One-off tasks with priorities alongside habits (from ~2024) | CORE_TODO 307 | 6984394901 12957540481 14453965506 ; Focus / pomodoro (番茄钟 / 专注) | Pomodoro and count-up timer linked to habits; app-blocking list; 2026 red focus page | FOCUS 390 | 14466033004 14381653023 13842773106 ; Widgets | Home-screen and Today-view widgets; tap-to-check (pre-iOS 14, and restored in later builds) | PLAT_WIDGET_GOOD 48 · PLAT_WIDGET_BUG 454 · PLAT_WIDGET_WANT 240 | 5169380786 6487343139 10384521337 ; Sibling apps | Same studio: 布谷布谷 (Bugu), 须臾, 青子记账 (Qingzi ledger), 千结 — cross-purchasers are common | USER_CROSSAPP 230 | 1710533099 7002665650 13599050555
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `2239007655`, `3254531371`, `10229830471`, `5234243491`, `2584511973`, `6984394901`, `4607325416`, `11663316873`, `5813993595`, `14466033004`, `5169380786`, `1710533099`
- **Canonical:** — (nuance register)

### R52-054 — Premium icons, themes/skins and some colours are paid (themes sold separately in 2018) — DES_THEME 343 (1.66%, meaningful, mean 4.47, mixed) with payer lift ×3.65 (why people pay) and DES_ICON_WANT 561 (2.72%, meaningful, mean 4.49) lift ×2.83; a 2018 theme buyer got a refund when themes became free again

- **Where:** §2.3 Premium icons row
- **This app does:** paid: premium icons, themes, some colours
- **User reaction:** purchase-driver
- **Magnitude:** DES_THEME 343 (1.66%, 4.47) lift ×3.65; DES_ICON_WANT 561 lift ×2.83
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `2459857576`, `2570484742`, `6714504989`, `2692072328`
- **Canonical:** C009 Basic widgets, icons and colours are free; C167 Cosmetic and colour variety as the paid layer

### R52-055 — Backup / restore from iCloud after reinstall is paid in several builds — reviewers asked to buy membership to restore their own data (medium-high confidence, 32 reviews)

- **Where:** §2.3 Backup / restore row
- **This app does:** paid: iCloud backup restore
- **User reaction:** blocked-conversion
- **Magnitude:** 32 reviews
- **Direction for us:** build-free · **Report confidence:** medium-high · **Generalisable:** generalisable
- **Review IDs:** `6494333470`, `11779820068`
- **Canonical:** C020 Data export / backup / CSV; C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R52-057 — Focus timer basics free; some timing modes (on-the-hour count, blocking) prompt for membership (medium confidence)

- **Where:** §2.3 Focus timer row
- **This app does:** free basics, paid modes
- **User reaction:** mixed
- **Magnitude:** report gives none
- **Direction for us:** undecided · **Report confidence:** medium · **Generalisable:** generalisable
- **Review IDs:** `14466033004`, `14501891567`
- **Canonical:** C066 Focus timer

### R52-058 — Apple Watch, full Mac and Android parity not available or broken; PLAT_WATCH 256 (1.24%, meaningful, mean 4.52) — check in from the wrist; one reviewer bought a Watch for this app; other devices asked for union (Watch, iPad, Mac, Android) 835 (4.05%, very strong, mean 4.09)

- **Where:** §2.3 Apple Watch / Mac / Android row; §3.6 #7
- **This app does:** absent: Watch app; Mac and Android not at parity
- **User reaction:** complaint
- **Magnitude:** PLAT_WATCH 256 (1.24%, 4.52); device union 835 (4.05%, 4.09)
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `2203609471`, `12014746702`, `12414606820`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C051 Android version

### R52-081 — Motivation mechanics: STAT_REWARD 312 (1.51%, 4.65), CARD_GOOD (daily quote card) 106 (0.51%, emerging, 4.83), STAT_GOOD 155 (0.75%, emerging, 4.90), DES_ANIM (animation, check-in sound '咔嚓声') 115 (0.56%, emerging, 4.66) — rewards exchanged for self-set wishes, the check-in sound and the daily quote card

- **Where:** §3.4 P5
- **This app does:** free: reward points, quote card, check-in sound
- **User reaction:** praise
- **Magnitude:** STAT_REWARD 312; CARD_GOOD 106; STAT_GOOD 155; DES_ANIM 115
- **Direction for us:** build-free · **Report confidence:** emerging–meaningful · **Generalisable:** generalisable
- **Review IDs:** `11663316873`, `13992537486`, `14330209556`, `2584511973`
- **Canonical:** C052 Points / rewards / wish list; C069 Check-off sound and haptic

### R52-086 — Time-of-day scenes (morning / noon / evening grouping) are the structure people love and also confusing ('two + buttons'): CORE_SEGMENT 159 (0.77%, emerging, mean 3.99)

- **Where:** §3.5 CORE_SEGMENT row
- **This app does:** free: habits grouped into time-of-day scenes
- **User reaction:** mixed
- **Magnitude:** 159 (0.77%, 3.99)
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `10229830471`, `8790365200`
- **Canonical:** C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in

### R52-087 — Streaks are motivating ('600 days') but streak resets after bugs enrage: STAT_STREAK 106 (0.51%, emerging, mean 4.00)

- **Where:** §3.5 STAT_STREAK row
- **This app does:** streak counter; bug resets
- **User reaction:** mixed
- **Magnitude:** 106 (0.51%, 4.00)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `13983550843`, `3115814668`, `12914673906`
- **Canonical:** C024 Streaks / gamification; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R52-088 — To-dos (小事, from ~2024) welcomed but sorting and hiding regressions: CORE_TODO 307 (1.49%, meaningful, mean 4.50)

- **Where:** §3.5 CORE_TODO row
- **This app does:** free: to-dos with priorities beside habits
- **User reaction:** mixed
- **Magnitude:** 307 (1.49%, 4.50)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `14453965506`, `12062367782`
- **Canonical:** C050 One-off to-dos alongside habits

### R52-090 — Unmet needs — any feature request 4,160 (20.16%, high-priority, mean 4.38), overwhelmingly from satisfied users and distinct from broken features (verbatim table); explicit non-requests: social features (SOC_NOSOCIAL 120) and 'stop adding features' (DES_DENSE, DES_REDESIGN); SOC_FRIEND 74 (0.36%, weak) is the minority asking for accountability buddies

- **Where:** §3.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** # | Request | Code | n | % | Band | Mean ★ | What exactly | IDs ; 1 | Richer check-in notes, especially photos | JRNL_WANT | 668 | 3.24% | Very strong | 4.36 | Photos in check-in logs (the most repeated single ask), browse all logs, autosave, bigger note field | 2002976675 6984394901 12696434160 13854649069 ; 2 | Reminder control | REM_WANT | 588 | 2.85% | Meaningful | 4.36 | Suppress after completion, loud / silent-mode alarm, repeat until done, custom sounds, voice | 3942069540 5553105088 8781527056 ; 3 | More / custom icons | DES_ICON_WANT | 561 | 2.72% | Meaningful | 4.49 | Study, yoga, chores icons; custom emoji; restore icons removed in 2024 and 2026 | 1950454065 11829807156 13663058300 14449455617 ; 4 | Statistics | STAT_WANT | 478 | 2.32% | Meaningful | 4.37 | Long-range timeline comparison (63-vote review), year view, trend line per habit, completion % | 5813993595 3171718094 9308317324 ; 5 | iPad version / layout / sync | PLAT_IPAD | 380 | 1.84% | Meaningful | 4.09 | HD version (2017–2019), landscape, split view, real-time sync | 2486414786 3645579338 11602790209 ; 6 | Focus / timer | FOCUS | 390 | 1.89% | Meaningful | 4.35 | Pause, count-up, auto-log to habit, quieter sounds, working app-block lists | 3797496594 14103541349 13842773106 14294329230 ; 7 | Apple Watch | PLAT_WATCH | 256 | 1.24% | Meaningful | 4.52 | Check in from the wrist; one reviewer bought a Watch for this app | 2203609471 12014746702 12414606820 ; 8 | Widget improvements | PLAT_WIDGET_WANT | 240 | 1.16% | Meaningful | 4.48 | Interactive (iOS 17) check-in widget, weekly widget, pomodoro widget, compact icon widget | 10384521337 12120100064 14460646052 ; 9 | Multiple check-ins per day | CORE_MULTI | 237 | 1.15% | Meaningful | 4.44 | Water × 8, meds morning and evening; reward points per check-in | 1967712726 9824409111 11523801306 ; 10 | Back-fill / correct a day / custom day rollover | CORE_RETRO | 218 | 1.06% | Meaningful | 4.18 | Undo a mistaken tap (removed in 2021, 10956751942); end the day at 2–4 am for night owls (50 text mentions, Appendix D) | 3867825890 10271914772 10956751942 ; 11 | Frequency rules | CORE_FREQ | 299 | 1.45% | Meaningful | 4.55 | Monthly, every-other-day, N times per week counted as done | 2280904016 11873598362 13073134030 ; 12 | Cross-device sync | DATA_SYNC_WANT | 132 | 0.64% | Emerging | 4.31 | Account-based sync instead of iCloud-only | 7848174072 14434252181 ; 13 | Bad habits / penalties | CORE_BADHABIT 57 · STAT_PENALTY 21 | 78 (sum; may overlap) | ≤0.38% | Weak | 4.8 | Negative habits that deduct reward points | 9308317324 14294025867 ; 14 | Everything else | REQ_OTHER | 395 | 1.91% | Meaningful | 4.47 | Countdown / anniversaries, accounting, voice input, sleep-time logging, timetable | 14165760963 13812226657 13881698345
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `8577613263`
- **Canonical:** — (nuance register)

### R52-091 — The biggest single request: richer check-in notes, especially photos — JRNL_WANT 668 (3.24%, very strong, mean 4.36): photos in check-in logs (the most repeated single ask), browse all logs, autosave, bigger note field; JRNL_GOOD 234 (1.13%, meaningful, 4.85) for the notes that exist

- **Where:** §3.6 #1
- **This app does:** notes exist; no photos; no browse-all
- **User reaction:** praise
- **Magnitude:** JRNL_WANT 668 (3.24%, 4.36); JRNL_GOOD 234 (1.13%, 4.85)
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `2002976675`, `6984394901`, `12696434160`, `13854649069`
- **Canonical:** C172 Per-day / per-habit notes and journal text; C208 Photo / media / URL attached to a habit, memo or diary entry

### R52-092 — Reminder control: REM_WANT 588 (2.85%, meaningful, mean 4.36) — suppress after completion, loud / silent-mode alarm, repeat until done, custom sounds, voice

- **Where:** §3.6 #2
- **This app does:** basic reminders
- **User reaction:** complaint
- **Magnitude:** 588 (2.85%, 4.36)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `3942069540`, `5553105088`, `8781527056`
- **Canonical:** C074 Customisable, louder reminder sounds; C258 A 'nag until done' repeating reminder — the one reminder shape reviewers say no other app offers

### R52-093 — More / custom icons: DES_ICON_WANT 561 (2.72%, meaningful, mean 4.49) — study, yoga, chores icons; custom emoji; restore icons removed in 2024 and 2026

- **Where:** §3.6 #3
- **This app does:** icon library, some icons removed in 2024 and 2026
- **User reaction:** complaint
- **Magnitude:** 561 (2.72%, 4.49)
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `1950454065`, `11829807156`, `13663058300`, `14449455617`
- **Canonical:** C009 Basic widgets, icons and colours are free; C167 Cosmetic and colour variety as the paid layer

### R52-094 — Statistics requests: STAT_WANT 478 (2.32%, meaningful, mean 4.37) — long-range timeline comparison (a 63-vote review, the most-upvoted in the corpus), year view, trend line per habit, completion %

- **Where:** §3.6 #4
- **This app does:** weekly/monthly stats; year stats now VIP
- **User reaction:** complaint
- **Magnitude:** 478 (2.32%, 4.37); 63-vote review
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `5813993595`, `3171718094`, `9308317324`
- **Canonical:** C011 Weekly / monthly / yearly reports; C012 Week / month / year grid views

### R52-095 — iPad version / layout / sync: PLAT_IPAD 380 (1.84%, meaningful, mean 4.09) — HD version (2017–2019), landscape, split view, real-time sync

- **Where:** §3.6 #5
- **This app does:** iPad support partial
- **User reaction:** complaint
- **Magnitude:** 380 (1.84%, 4.09)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `2486414786`, `3645579338`, `11602790209`
- **Canonical:** C141 Native iPad layout

### R52-096 — Focus / timer requests: FOCUS 390 (1.89%) — pause, count-up, auto-log to habit, quieter sounds, working app-block lists

- **Where:** §3.6 #6
- **This app does:** focus timer with gaps and bugs
- **User reaction:** mixed
- **Magnitude:** 390 (1.89%, 4.35)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `3797496594`, `14103541349`, `13842773106`, `14294329230`
- **Canonical:** C066 Focus timer

### R52-097 — Widget improvements: PLAT_WIDGET_WANT 240 (1.16%, meaningful, mean 4.48) — interactive (iOS 17) check-in widget, weekly widget, pomodoro widget, compact icon widget

- **Where:** §3.6 #8
- **This app does:** widgets exist; interactive check-in lost then restored
- **User reaction:** complaint
- **Magnitude:** 240 (1.16%, 4.48)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `10384521337`, `12120100064`, `14460646052`
- **Canonical:** C023 Interactive widget check-off

### R52-098 — Multiple check-ins per day: CORE_MULTI 237 (1.15%, meaningful, mean 4.44) — water × 8, meds morning and evening; reward points per check-in

- **Where:** §3.6 #9
- **This app does:** absent or limited
- **User reaction:** complaint
- **Magnitude:** 237 (1.15%, 4.44)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `1967712726`, `9824409111`, `11523801306`
- **Canonical:** C143 Intra-day completion: tap N times to fill N/N

### R52-099 — Back-fill / correct a day / custom day rollover: CORE_RETRO 218 (1.06%, meaningful, mean 4.18) — undo a mistaken tap (removed in 2021); end the day at 2–4 am for night owls (50 text mentions, Appendix D)

- **Where:** §3.6 #10
- **This app does:** undo removed 2021; no day-rollover setting
- **User reaction:** complaint
- **Magnitude:** 218 (1.06%, 4.18); 50 rollover mentions
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `3867825890`, `10271914772`, `10956751942`
- **Canonical:** C010 Backfill missed days / edit start date; C170 Configurable day boundary and hemisphere seasons; C223 Undo / un-complete is a visible button — never a gesture-only path

### R52-100 — Frequency rules: CORE_FREQ 299 (1.45%, meaningful, mean 4.55) — monthly, every-other-day, N times per week counted as done

- **Where:** §3.6 #11
- **This app does:** daily/weekly/custom but gaps
- **User reaction:** complaint
- **Magnitude:** 299 (1.45%, 4.55)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `2280904016`, `11873598362`, `13073134030`
- **Canonical:** C043 Flexible / custom frequency

### R52-101 — Cross-device sync: DATA_SYNC_WANT 132 (0.64%, emerging, mean 4.31) — account-based sync instead of iCloud-only

- **Where:** §3.6 #12
- **This app does:** iCloud-only sync
- **User reaction:** complaint
- **Magnitude:** 132 (0.64%, 4.31)
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `7848174072`, `14434252181`
- **Canonical:** C030 Sync must work — and prove it; C035 Account system from day one

### R52-102 — Bad habits / penalties: CORE_BADHABIT 57 · STAT_PENALTY 21 (78 sum, may overlap, ≤0.38%, weak, mean 4.8) — negative habits that deduct reward points

- **Where:** §3.6 #13
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 78 (≤0.38%, 4.8)
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `9308317324`, `14294025867`
- **Canonical:** C019 Quit-habit / bad-habit mode; C052 Points / rewards / wish list

### R52-103 — Everything else: REQ_OTHER 395 (1.91%, meaningful, mean 4.47) — countdown / anniversaries, accounting, voice input, sleep-time logging, timetable

- **Where:** §3.6 #14
- **This app does:** absent
- **User reaction:** mixed
- **Magnitude:** 395 (1.91%, 4.47)
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `14165760963`, `13812226657`, `13881698345`
- **Canonical:** C099 Countdown / 'days until' mode

### R52-105 — Themes at Emerging or above without their own paragraph: DATA_ACCOUNT (account / login problems) 200 (0.97%, emerging, mean 3.40); CORE_GOAL 180 (0.87%, 4.55); DES_COLOR 166 (0.80%, 4.65); CORE_TIMEPLAN (time-plan / schedule view) 156 (0.76%, 4.38); REM_ANNOY (annoying notifications, from 2020-07) 155 (0.75%, 3.26); CARD_WANT 154 (0.75%, 4.40); CORE_ORDER (reorder) 151 (0.73%, 4.16); PAY_FREEDEMAND (make it free) 147 (0.71%, 3.43); CORE_ARCHIVE 133 (0.64%, 3.99); DATA_BACKUP 133 (0.64%, 3.73); USER_STUDENT 123 (0.60%, 4.15); META_RECOMMEND 289 (1.40%, 4.93); CORE_CHECK (one-tap check-in praised) 217 (1.05%, 4.87); PAY_PRICE_OK 256 (1.24%, 4.86); PAY_PRICE_HIGH 254 (1.23%, 3.28)

- **Where:** §3.1 rows (Emerging+ themes without a narrative paragraph)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as listed
- **Direction for us:** none · **Report confidence:** emerging–meaningful · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

### R52-109 — Reorder and archive: CORE_ORDER 151 (0.73%, emerging, mean 4.16) asks for habit reordering; CORE_ARCHIVE 133 (0.64%, emerging, mean 3.99) — archiving habits (mixed)

- **Where:** §3.1 CORE_ORDER / CORE_ARCHIVE rows
- **This app does:** sorting limited; archive exists with issues
- **User reaction:** mixed
- **Magnitude:** CORE_ORDER 151 (4.16); CORE_ARCHIVE 133 (3.99)
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** generalisable
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free; C227 A 'graduated' state — keep tracking a mastered habit without it occupying an active slot

### R52-111 — 'Tap again to undo' a check-in was removed (2021 per §3.6, reported 2024) — now the only option is to mark the habit 'failed'

- **Where:** §4.1 bullet 'tap again to undo'
- **This app does:** removed: tap-again undo
- **User reaction:** complaint
- **Magnitude:** n=1 quote; within CORE_RETRO 218
- **Direction for us:** build-free · **Report confidence:** meaningful (parent) · **Generalisable:** generalisable
- **Review IDs:** `10956751942`
- **Canonical:** C223 Undo / un-complete is a visible button — never a gesture-only path; C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R52-116 — Weekly-N habits spoil a '100% day' — a habit due N times a week counts as incomplete on the days it is not done

- **Where:** §4.3 bullet weekly-N
- **This app does:** daily completion % penalises weekly-N habits
- **User reaction:** complaint
- **Magnitude:** n=1 cited
- **Direction for us:** must-have · **Report confidence:** meaningful (parent) · **Generalisable:** generalisable
- **Review IDs:** `8267555469`
- **Canonical:** C043 Flexible / custom frequency

### R52-117 — Night owls' check-ins after midnight land on the next day — reviewers ask to end the day at 2–4 am (50 text mentions)

- **Where:** §4.3 bullet night owls; §3.6 #10
- **This app does:** absent: custom day rollover
- **User reaction:** complaint
- **Magnitude:** 50 text mentions
- **Direction for us:** must-have · **Report confidence:** meaningful (parent) · **Generalisable:** generalisable
- **Review IDs:** `3867825890`, `14510307751`
- **Canonical:** C170 Configurable day boundary and hemisphere seasons

### R52-120 — Notes and journaling, the biggest single request: JRNL_GOOD 234 (1.13%, 4.85) vs JRNL_WANT 668 (3.24%, very strong); many treat the app as a micro-diary with '往年今日' (on this day in past years) praised; asks in order: 1 photos in check-in logs and notes (2017 → 2025: 'please add photos to check-ins!! I really want photos!!!'); 2 browsing all logs beyond the current month; 3 autosave so an interrupted note isn't lost; 4 no forced titles and no AI titles

- **Where:** §4.5
- **This app does:** notes per check-in; on-this-day; AI titles 2026
- **User reaction:** mixed
- **Magnitude:** JRNL_GOOD 234; JRNL_WANT 668
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `14034097323`, `13948803433`, `2002976675`, `12696434160`, `14409706316`, `9989639645`, `13861341315`, `13930545782`, `14508025525`
- **Canonical:** C172 Per-day / per-habit notes and journal text; C208 Photo / media / URL attached to a habit, memo or diary entry; C268 Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input

### R52-123 — Platforms table (verbatim): PLAT_WIDGET_BUG 454 peak 2020–2021 (62.8% of all); PLAT_IPAD 380 peak 2018–2020 (63.7%); PLAT_WATCH 256 persistent, 2019–2020 peak; PLAT_WIDGET_WANT 240 persistent; PLAT_ANDROID 195 persistent; PLAT_OS 49 (0.24%, weak, 3.55) iOS version floor / old devices; PLAT_MAC 37 2021–2025 (WeChat binding)

- **Where:** §4.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | n | % | Band | Mean ★ | Peak ; PLAT_WIDGET_BUG | 454 | 2.20% | Meaningful | 3.91 | 2020–2021 (62.8% of all) ; PLAT_IPAD | 380 | 1.84% | Meaningful | 4.09 | 2018–2020 (63.7% of all) ; PLAT_WATCH | 256 | 1.24% | Meaningful | 4.52 | persistent, 2019–2020 peak ; PLAT_WIDGET_WANT | 240 | 1.16% | Meaningful | 4.48 | persistent ; PLAT_ANDROID | 195 | 0.95% | Emerging | 3.53 | persistent ; PLAT_OS | 49 | 0.24% | Weak | 3.55 | iOS version floor / old devices ; PLAT_MAC | 37 | 0.18% | Weak | 3.81 | 2021–2025 (WeChat binding)
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-124 — Widgets carry more emotional weight than their count suggests: 'Maybe the most important features of ShineDay are its widgets. Being able to check off completed habits without opening the app…' (at, 5★, 2019); when iOS 14 removed that in Oct 2020, 55 widget-bug reviews arrived in one month; the fragility recurs in 2024 ('changes every update'), 2026 (widget check-in removed again) and on iOS 26 with Clear/Tinted home screens (widget renders blank)

- **Where:** §4.6 widgets
- **This app does:** interactive widget check-in removed Oct 2020, restored, removed again 2026
- **User reaction:** 1★-burst
- **Magnitude:** 55 widget-bug reviews in Oct 2020
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `5169380786`, `11984523524`, `14508345550`, `14329669709`
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app

### R52-198 — M3: free basic year summary, paid detailed report — Dec 2025 produced 15 reviews in a month when year statistics moved to VIP, and a reviewer asks for exactly this split

- **Where:** §9.2 M3
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 15 reviews in Dec 2025
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13559154241`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R52-202 — Product and retention work (verbatim): R1 redesigns ship behind a setting for at least one release (old focus page, AI titles off, habit balls hidden, compact widget); R2 protect one-tap check-in and one-tap undo; R3 photos in check-in logs and notes, browse all logs, autosave; R4 reminder intelligence — suppress once done, a silent-mode 'strong' alarm, sounds that persist; R5 custom day rollover and multi-check habits linked to reward points; R6 Apple Watch check-in, interactive iOS widgets; R7 icon library — restore removed icons, add study/chores/yoga, allow emoji; R8 an in-app feedback channel with a visible reply; R9 keep the app social-free

- **Where:** §9.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** # | Work | Why ; R1 | Redesigns ship behind a setting for at least one release (old focus page, AI titles off, habit balls hidden, compact widget) | §0.6: four redesign waves; 13403164932 proposes decoupled styles ; R2 | Protect one-tap check-in and one-tap undo | §4.1: June 2021 and 2024 regressions ; R3 | Photos in check-in logs and notes; browse all logs; autosave | §4.5: JRNL_WANT 668 (3.24%, very strong) — the largest unmet need ; R4 | Reminder intelligence: suppress once done, a silent-mode "strong" alarm, sounds that persist | §4.4: REM_FAIL lift 3.62 among payers ; R5 | Custom day rollover and multi-check habits linked to reward points | §3.6 #9–#10: 237 + 218 reviews; 50 rollover mentions ; R6 | Apple Watch check-in; interactive iOS widgets | §4.6: PLAT_WATCH 256; widget emotional weight (5169380786) ; R7 | Icon library: restore removed icons, add study/chores/yoga categories, allow emoji | §3.6 #3: DES_ICON_WANT 561; payers' top request (lift 2.83) ; R8 | An in-app feedback channel with a visible reply | §3.3 N8: SUP_BAD 184, payer mean 1.92; fast fixes are among the strongest praise (§3.4 P4) ; R9 | Keep the app social-free | §0.6: SOC_NOSOCIAL 120, payer lift 4.55
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `13403164932`, `5169380786`
- **Canonical:** — (nuance register)

### R52-205 — R6: Apple Watch check-in and interactive iOS widgets (PLAT_WATCH 256; widget emotional weight)

- **Where:** §9.3 R6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** PLAT_WATCH 256
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `5169380786`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C023 Interactive widget check-off

### R52-210 — Weak-band requests carried only as master-table rows: DES_FONT 87 (0.42%, mean 4.53); DES_DARK (dark mode) 70 (0.34%, 3.89, from 2019-10); CORE_SUBTASK 62 (0.30%, 4.45); DATA_EXPORT 59 (0.29%, 4.46); SOC_SHARE 53 (0.26%, 4.23); PLAT_CAL (calendar integration) 41 (0.20%, 4.12); CORE_SEARCH 46 (0.22%, 4.30); SOC_FRIEND (accountability buddies) 74 (0.36%, 4.42) — a minority against SOC_NOSOCIAL 120

- **Where:** §3.1 rows (weak requests); §3.6 non-requests
- **This app does:** absent
- **User reaction:** mixed
- **Magnitude:** as listed
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `8577613263`
- **Canonical:** C020 Data export / backup / CSV; C080 Colour themes / dark mode; C173 Sub-tasks / sub-routines nested inside a habit or routine; C199 System calendar integration — see appointments inside the plan; C202 A light social layer that is explicitly not a social network

## Monetization

### R52-016 — An 8-yuan lifetime ad-free SKU exists; reviewers who find it accept the trade ('but 8 yuan removes ads forever', 5★; 'paid 8 yuan, much better', 5★) while others conclude the ads exist to sell it ('noticed the 8-yuan lifetime ad-free SKU and concludes the ads exist to sell it', 1★) — the decision: surface the 8-yuan ad-free SKU honestly

- **Where:** §0.1 bullets; §0.9 #1
- **This app does:** paid: 8 yuan one-time ad removal
- **User reaction:** mixed
- **Magnitude:** report gives none (quotes only)
- **Direction for us:** undecided · **Report confidence:** very strong (parent theme) · **Generalisable:** generalisable
- **Conditions:** cheap one-time ad removal is accepted when discoverable; aggressive ads make it read as extortion
- **Review IDs:** `13284916834`, `14100445684`, `13362003467`
- **Canonical:** C082 Ads in the free tier

### R52-019 — The free habit quota is the persistent monetisation friction and the first wall a new user meets: PAY_CAP5 888 (4.30%, very strong, mean 2.96; 1/2/3/4/5 = 257/98/154/180/199); PAY_WALL 715 (3.47%, very strong, mean 2.62); monetisation-friction union 2,496 (12.10%, high-priority, mean 2.98); 'only five free habits is too few… anyone serious wants to keep more than five things a day' (5★, Dec 2017) and the same complaint in 2020 and 2025, eight years apart

- **Where:** §0.2
- **This app does:** free: capped habit quota (5 most often stated)
- **User reaction:** complaint
- **Magnitude:** PAY_CAP5 888 (4.30%, 2.96); PAY_WALL 715 (3.47%, 2.62); union 2,496 (12.10%, 2.98)
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `2001609740`, `5519779697`, `12892816707`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R52-027 — The membership is sold twice across Android and iOS, at different prices, with different login methods (QQ on Android versus WeChat on iOS): 49 reviews combine PLAT_ANDROID with a tier or restore failure (mean 2.80); 'only after buying did I find Android membership must be bought separately' (1★, 2023); 'iOS lifetime 88, Android 48? Where's the justice' (1★, Feb 2026)

- **Where:** §0.4 bullet Android ↔ iOS
- **This app does:** paid separately per platform; iOS lifetime 88 vs Android 48
- **User reaction:** complaint
- **Magnitude:** 49 reviews (2.80)
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `4353672876`, `6367540210`, `8198718685`, `10530140312`, `13791604447`
- **Canonical:** C051 Android version; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R52-047 — Two tiers (小太阳 small sun / 大太阳 big sun) with no upgrade credit between them, and a November 2019 price rise (小太阳 ¥8→¥12, 大太阳 ¥12→¥18); reviewers' figures for each tier conflict across dates; PAY_TIERS (tier structure confusing / Android-iOS split) 113 (0.55%, emerging, mean 3.53) with a 5.11× payer lift

- **Where:** §2.2 Nov 2019 row; §2.3 tier row
- **This app does:** paid: two one-time tiers without upgrade credit; price rise
- **User reaction:** complaint
- **Magnitude:** PAY_TIERS 113 (0.55%, 3.53); lift ×5.11
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `2830538942`, `4821574128`, `8270198642`, `5099014000`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R52-050 — Price seen as unstable: '¥30 when I was a student, ¥80 now' (Oct 2024); ¥18 / ¥28 / ¥88 reported in the same months and a ¥12 buyer finds lifetime at ¥98 (Jun–Aug 2025) — PAY_PRICE_RISE 42 (0.20%, weak, mean 3.19)

- **Where:** §2.2 Oct 2024 and Jun–Aug 2025 rows
- **This app does:** lifetime price rising and varying
- **User reaction:** complaint
- **Magnitude:** PAY_PRICE_RISE 42 (0.20%, 3.19)
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `11873598362`, `12834474035`, `13082395093`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C113 One stable, disclosed price — no discount wheels

### R52-052 — 2026 new-install onboarding requires picking 5 habits and a 3-day free trial ('mandatory trial selection at onboarding'); earlier trials 7 days in some reviews; PAY_TRIAL 71 (0.34%, weak, mean 3.18), weak until 2026 and concentrated in the new onboarding — watch, don't act on the level yet

- **Where:** §2.2 2026 row; §2.3 trial row; §3.7
- **This app does:** trial: 3-day trial inside mandatory onboarding (2026)
- **User reaction:** complaint
- **Magnitude:** PAY_TRIAL 71 (0.34%, 3.18)
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `14389575364`, `13986964200`, `14206066896`, `14053361336`
- **Canonical:** C063 Free trial before purchase; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R52-053 — Free / paid / trial / unclear classification (verbatim table); unclear from reviews: whether the habit quota differs by cohort or A/B test (reviewers in the same month report different caps), whether iCloud restore is ever free in current builds, whether Android and iOS memberships have ever been unified (2018–2026 reviewers say no)

- **Where:** §2.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Capability | Status per reviews | Confidence | Evidence ; Download, habit check-in, basic statistics | Free | High | universal ; Number of habits | Free up to a quota — most often stated as 5 (2018–2024); 3, 4, 6, 8 and 10 also reported; from 2025 the quota grows with check-ins | High (existence), medium (number) | §0.2 ; Reminders | Gated behind a written review in 2017; free afterwards | High | 1947016834 1939187899 ; Premium icons, themes/skins, some colours | Paid (and themes sold separately in 2018) | High | 2459857576 2570484742 6714504989 ; Backup / restore from iCloud after reinstall | Paid in several builds — reviewers asked to buy membership to restore their own data | Medium-high (32 reviews) | 6494333470 11779820068 ; Year statistics | Free until Dec 2025, then VIP | High (15 reviews since Nov 2025) | 13501470470 13559154241 13530928663 ; Ad-free | Paid (¥8 lifetime) from ~Oct 2025; earlier builds had splash ads that membership removed inconsistently | High | 13284916834 4189381643 6130073882 ; Focus timer basics | Free; some timing modes (on-the-hour count, blocking) prompt for membership | Medium | 14466033004 14501891567 ; Trial | 3-day trial appears in 2026 onboarding; earlier trials 7 days in some reviews | Medium | 13986964200 14206066896 14053361336 ; Social / community | Does not exist, and payers ask that it never will | High | SOC_NOSOCIAL 120 ; Apple Watch, Mac (full), Android parity | Not available / broken | High | PLAT_WATCH 256 · PLAT_MAC 37
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `1947016834`, `1939187899`, `2459857576`, `6494333470`, `13501470470`, `13284916834`, `14466033004`, `13986964200`
- **Canonical:** — (nuance register)

### R52-056 — Ad-free became paid (¥8 lifetime) from ~Oct 2025; earlier builds had splash ads that membership removed inconsistently

- **Where:** §2.3 Ad-free row
- **This app does:** paid: ad removal ¥8; membership did not reliably remove ads
- **User reaction:** mixed
- **Magnitude:** report gives none
- **Direction for us:** undecided · **Report confidence:** high (status) · **Generalisable:** generalisable
- **Review IDs:** `13284916834`, `4189381643`, `6130073882`
- **Canonical:** C082 Ads in the free tier

### R52-066 — General paywall N3: PAY_WALL 715 (3.47%, very strong, mean 2.62) — 'everything costs money': themes, backgrounds, backup, later year statistics and some focus modes; peaked in 2018 (7.1%), returned Dec 2025 (year statistics) and 2026 (mandatory trial selection at onboarding)

- **Where:** §3.3 N3
- **This app does:** many surfaces paywalled
- **User reaction:** complaint
- **Magnitude:** 715 (3.47%, 2.62); 2018 peak 7.1%
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `2524800702`, `5662173619`, `14507944819`, `14501891567`, `14031908801`
- **Canonical:** C001 Never move a free feature behind the paywall

### R52-085 — PAY_LIFETIME 432 (2.09%, meaningful, mean 3.97): praise for a one-time option, demands for it, and anger when it was withdrawn; 199 payers explicitly bought lifetime (mean 4.36)

- **Where:** §3.5 PAY_LIFETIME row
- **This app does:** lifetime offered, withdrawn, reintroduced
- **User reaction:** mixed
- **Magnitude:** 432 (2.09%, 3.97)
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `3291064932`, `6268143177`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R52-108 — Price judged fair (PAY_PRICE_OK 256, 1.24%, mean 4.86, payer lift ×4.58) about as often as too high (PAY_PRICE_HIGH 254, 1.23%, mean 3.28); PAY_FREEDEMAND 147 (0.71%, 3.43); PAY_SUB_NEG (subscription objection) 97 (0.47%, weak, 3.01); PAY_DISCOUNT (student / discount ask) 31 (0.15%, 3.94)

- **Where:** §3.1 PAY_PRICE_OK / PAY_PRICE_HIGH rows
- **This app does:** ¥-priced tiers
- **User reaction:** mixed
- **Magnitude:** PRICE_OK 256 (4.86) vs PRICE_HIGH 254 (3.28); SUB_NEG 97 (3.01)
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R52-145 — Purchase trigger 2 — lifting the habit quota, stated or implied; explicit in 17 payer reviews: '¥18 lifetime isn't expensive; 3 habits is too few, so I bought without thinking'

- **Where:** §6.2 #2
- **This app does:** paid: removes habit quota
- **User reaction:** purchase-driver
- **Magnitude:** 17 payer reviews
- **Direction for us:** build-paid · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `5562288248`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R52-146 — Purchase trigger 3 — icons and themes: 161 payers (4.50 mean) mention them; they are both a reason to buy and the top payer request

- **Where:** §6.2 #3
- **This app does:** paid: icons and themes
- **User reaction:** purchase-driver
- **Magnitude:** 161 payers (4.50)
- **Direction for us:** build-paid · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Canonical:** C167 Cosmetic and colour variety as the paid layer

### R52-148 — Purchase trigger 5 — one-time rather than subscription: PAY_SUB_NEG payers and non-payers alike prefer lifetime ('one time purchase instead of a subscription', us; gb)

- **Where:** §6.2 #5
- **This app does:** lifetime option
- **User reaction:** purchase-driver
- **Magnitude:** report gives none
- **Direction for us:** build-paid · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `3291064932`, `8200081272`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R52-149 — Purchase trigger 6 — removing ads (2025–26) via the ¥8 SKU

- **Where:** §6.2 #6
- **This app does:** paid: ¥8 ad removal
- **User reaction:** purchase-driver
- **Magnitude:** report gives none
- **Direction for us:** undecided · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `13284916834`, `14100445684`
- **Canonical:** C082 Ads in the free tier

### R52-150 — Upgrade barriers (verbatim): price too high / 'not worth it for a habit app' PAY_PRICE_HIGH 254 (1.23%, 3.28); should be free on principle PAY_FREEDEMAND 147 (0.71%, 3.43); tier confusion / no upgrade credit / Android split PAY_TIERS 113 (0.55%, 3.53); subscription model PAY_SUB_NEG 97 (0.47%, 3.01); trial terms PAY_TRIAL 71 (0.34%, 3.18); payment method / purchase flow broken PAY_BILLING 112 in 2018 (no Alipay); students without money ('forty-plus yuan, any conscience?' — Grade 7); distrust after watching re-scoping PAY_SCAM 183 / PAY_REGRESS 75 (1.36 / 2.15) — 'no longer want to buy'

- **Where:** §6.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** Barrier | Code | n | % | Band | Mean ★ | IDs ; Price too high / "not worth it for a habit app" | PAY_PRICE_HIGH | 254 | 1.23% | Meaningful | 3.28 | 7014407503 8759088131 9608922496 ; Should be free on principle | PAY_FREEDEMAND | 147 | 0.71% | Emerging | 3.43 | 14166043894 14027211204 ; Tier confusion / no upgrade credit / Android split | PAY_TIERS | 113 | 0.55% | Emerging | 3.53 | 4821574128 5500546497 10530140312 ; Subscription model | PAY_SUB_NEG | 97 | 0.47% | Weak | 3.01 | 6119258263 11012729767 ; Trial terms | PAY_TRIAL | 71 | 0.34% | Weak | 3.18 | 13986964200 14206066896 ; Payment method / purchase flow broken | PAY_BILLING (2018 subset) | 112 in 2018 | — | — | — | 1984445137 (no Alipay) 2399860126 2433751859 ; Students without money | USER_STUDENT ∩ price | — | — | — | — | 9608922496 (Grade 7: *"四十多块钱有没有一点点良心"*, *EN:* "forty-plus yuan, any conscience?") 8759088131 ; Distrust after watching re-scoping | PAY_SCAM, PAY_REGRESS | 183 / 75 | — | — | 1.36 / 2.15 | 12834474035 (*"不想买了"*, *EN:* "no longer want to buy")
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `7014407503`, `8759088131`, `9608922496`, `14166043894`, `4821574128`, `6119258263`, `13986964200`, `1984445137`, `12834474035`
- **Canonical:** — (nuance register)

### R52-156 — Refunds PAY_REFUND 32 (0.16%, weak, mean 1.91) — triggers: a redesign removing a used feature (¥68, Dec 2024); crash plus 'give me my money back'; a charge after deleting the app; a new buyer overwhelmed by friction on day one; a 2018 refund granted after themes became free for premium members

- **Where:** §6.5
- **This app does:** refunds requested; one granted 2018
- **User reaction:** 1★-burst
- **Magnitude:** 32 (0.16%, 1.91)
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `12062367782`, `13869205023`, `4953271455`, `8372670716`, `14460646052`, `2692072328`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R52-195 — Monetisation changes to test (verbatim): M1 keep lifetime and grandfather every past entitlement explicitly ('you bought X in 2019; you keep X') — risk small legacy revenue, large trust gain; M2 keep quota-grows-with-use and explain it on the paywall — low risk; M3 free basic year summary, paid detailed report — a reviewer asks for exactly this split; M4 make the ¥8 ad-free SKU visible before the first ad, not discoverable after an ad fails to close — could raise conversion and lower PAY_SCAM; M5 price parity or a single cross-platform membership — platform-fee constraints; M6 onboarding: allow skipping the trial and habit selection; every paywall screen needs a visible back control — watch PAY_TRIAL

- **Where:** §9.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** # | Change | Why | Risk ; M1 | Keep the lifetime option and grandfather every past entitlement explicitly ("you bought X in 2019; you keep X") | §2.4: re-scoping drives PAY_REGRESS (mean 2.15) and PAY_SCAM (86% 1★); honoured lifetimes drive DEV_TRUST (mean 4.93) | Revenue from legacy users — small; trust gain large ; M2 | Keep the quota-grows-with-use mechanic and explain it on the paywall | §0.2: reviewers who understand it praise it (13289981450, 13591116003); PAY_CAP5 now 0.6% | Low ; M3 | Free basic year summary, paid detailed report | §8.4 Dec 2025: 15 reviews in a month; 13559154241 asks for exactly this split | Low ; M4 | Make the ¥8 ad-free SKU visible *before* the first ad, not discoverable after an ad fails to close | §0.1: 13362003467 reads the SKU as the motive for hostile ads | Could raise conversion and lower PAY_SCAM ; M5 | Price parity or a single cross-platform membership | §0.4: 13791604447 (iOS 88 vs Android 48), 10530140312 | Platform-fee constraints ; M6 | Onboarding: allow skipping the trial and habit selection; every paywall screen needs a visible back control | 2026: 14389575364 14507944819 14426138907 14501891567 | Low; watch PAY_TRIAL
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `13289981450`, `13591116003`, `13559154241`, `13362003467`, `13791604447`, `10530140312`, `14389575364`, `14507944819`, `14426138907`, `14501891567`
- **Canonical:** — (nuance register)

### R52-200 — M5: price parity or a single cross-platform membership (iOS 88 vs Android 48) — risk: platform-fee constraints

- **Where:** §9.2 M5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** iOS ¥88 vs Android ¥48
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13791604447`, `10530140312`
- **Canonical:** C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

## Tactics the app used

### R52-006 — Review-to-unlock gate at launch (2017): the app required a written review to unlock features — mostly reminders (132 of 462 name reminders) — with a length check; outcome: META_UNLOCK 462 (2.24%, meaningful, mean 4.16; 427 in 2017 = 16.0% of that year, 24 in 2018, 11 in 2019–2025); Oct–Dec 2017 holds 2,535 reviews (12.29% of the nine-year corpus), 415 unlock reviews (16.4% of the window); all 15 busiest days of 3,205 review days fall 5 Nov → 13 Dec 2017 (79, 70, 69, 63, 63… per day; peak 79 on 12 Dec 2017 = 0.38% of corpus); filler text — the title repeated twenty times, random character strings, '能不能不要逼人写评价啊' ('please stop forcing people to write reviews') repeated dozens of times at 5★; 'many gave five stars because a good review was required to keep using the app'; consequences: 2017 year mean 4.61 is the highest full year, 2017 is 48.6% low-info and 20.3% pre-use (542 of all 717 pre-use reviews), so 2017 is never used as a baseline for decline

- **Where:** §Eight warnings 4; §1.7 Review-to-unlock
- **This app does:** gated reminders behind writing a review, 2017
- **User reaction:** 5★-burst
- **Magnitude:** 462 (2.24%, 4.16); 427 in 2017 (16.0%); 15 busiest days all Nov–Dec 2017; peak 79/day
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Side effects:** inflates the 2017 mean and makes the launch year unusable as a baseline
- **Conditions:** 2017 launch; gate removed after 2017–2018
- **Review IDs:** `1947016834`, `1958402990`, `1959643783`, `1901055265`, `2524800702`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R52-007 — From 2020 the app prompts for a review on the Nth launch ('第500次打开', '第800次打开', '第3000次打开') — solicited but not gated; 40 reviews mention the prompt (text census over the full corpus, mean 4.50); some complain: 'just downloaded, haven't used it, and it keeps asking me to review' (3★, 2020); 'paid 8 yuan to remove ads and it still insists I review' (3★, 2025) — solicitation inflates 5★ volume but does not change the direction of any finding

- **Where:** §Eight warnings 5; §1.7 Nth-launch prompts
- **This app does:** Nth-launch review prompt, 2020–2026, also shown to paying ad-free buyers
- **User reaction:** mixed
- **Magnitude:** 40 mentions (mean 4.50)
- **Direction for us:** do · **Report confidence:** text census · **Generalisable:** generalisable
- **Conditions:** milestone-launch prompt works when it fires after real use; fires too early for some and still fires for payers
- **Review IDs:** `11090257717`, `11216871410`, `11350173560`, `11065176175`, `11285961475`, `6682921169`, `13351689320`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R52-021 — From 2025 the free habit quota grows with use — 'keep checking in and it gives you more habit slots' (5★); 'I thought it was capped at 8, then found it grows with use' (4★); 'very kind' (5★) — reviewers who notice treat it as generosity, not friction; outcome: PAY_CAP5 fell from 8.2% of reviews (2018) and 7.1% (2020) to 0.6% in 2026, the only monetisation theme with a sustained, monotonic decline

- **Where:** §0.2 bullet 'From 2025 the quota grows with use'
- **This app does:** free quota earned through continued check-ins (2025 on)
- **User reaction:** praise
- **Magnitude:** PAY_CAP5 8.2% (2018) → 7.1% (2020) → 0.6% (2026)
- **Direction for us:** build-free · **Report confidence:** very strong (parent theme) · **Generalisable:** generalisable
- **Side effects:** turns the cap from a wall into a reward loop
- **Conditions:** observed from 2025; the decline may also reflect cohort change
- **Review IDs:** `13125235029`, `13289981450`, `13591116003`
- **Canonical:** C270 Free habit capacity that grows with continued check-ins — an earned cap reads as generosity, not as a wall

### R52-045 — A family of sibling apps from the same studio — 布谷布谷 (Bugu), 须臾, 青子记账 (Qingzi ledger), 千结 — and cross-purchasers are common: USER_CROSSAPP 230 (1.11%, meaningful, mean 4.57)

- **Where:** §2.1 Sibling apps row
- **This app does:** cross-sells sibling apps
- **User reaction:** praise
- **Magnitude:** USER_CROSSAPP 230 (1.11%, 4.57)
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `1710533099`, `7002665650`, `13599050555`
- **Canonical:** C060 Cross-sell an app family on brand trust

### R52-197 — M2: keep the quota-grows-with-use mechanic and explain it on the paywall — reviewers who understand it praise it; PAY_CAP5 now 0.6%

- **Where:** §9.2 M2
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** PAY_CAP5 0.6% (2026)
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13289981450`, `13591116003`
- **Canonical:** C270 Free habit capacity that grows with continued check-ins — an earned cap reads as generosity, not as a wall

## Insights (the why)

### R52-023 — Paying users are the most satisfied segment — until an entitlement breaks: PAY_BOUGHT 1,286 (6.23%, high-priority, mean 4.11; 815 at 5★ = 63.4% segment rate); 199 (15.5% segment rate) explicitly bought lifetime, mean 4.36; why people pay (lift = segment rate ÷ global rate): PAY_PRICE_OK 5.7% vs 1.24% ×4.58, SOC_NOSOCIAL 2.6% vs 0.58% ×4.55, DEV_TRUST 4.0% vs 1.03% ×3.92, DES_THEME 6.1% vs 1.66% ×3.65, DES_ICON_WANT 7.7% vs 2.72% ×2.83; what goes wrong after: SUP_BAD 4.0% vs 0.89% ×4.53, PAY_TIERS 2.8% vs 0.55% ×5.11, REM_FAIL 4.9% vs 1.35% ×3.62, PAY_RESTORE 3.0% vs 0.92% ×3.21

- **Where:** §0.3; §6.1
- **This app does:** paid: lifetime and membership tiers
- **User reaction:** purchase-driver
- **Magnitude:** Payers over-index on… | Segment rate (of 1,286) | Global rate | Lift ; PAY_PRICE_OK — price is fair / worth it | 5.7% | 1.24% | 4.58 ; SOC_NOSOCIAL — praising the *absence* of social features | 2.6% | 0.58% | 4.55 ; DEV_TRUST — trust in the developer as a reason to pay | 4.0% | 1.03% | 3.92 ; DES_THEME — themes / skins | 6.1% | 1.66% | 3.65 ; DES_ICON_WANT — more icons | 7.7% | 2.72% | 2.83 ; SUP_BAD — no response from support | 4.0% | 0.89% | 4.53 ; PAY_TIERS — tier structure confusing / Android-iOS split | 2.8% | 0.55% | 5.11 ; REM_FAIL — reminders don't fire | 4.9% | 1.35% | 3.62 ; PAY_RESTORE — membership lost after reinstall / device change | 3.0% | 0.92% | 3.21
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R52-024 — Once an entitlement or reliability failure happens, payers become the harshest reviewers: paid and reports value (fair price, trust, clean/cute, outcome) at 4–5★ n=306 mean 4.92; paid and an entitlement broke (restore / billing / refund / regression / price rise) 80 at 2.62; paid and a reliability failure (crash, lag, update, data loss, sync, widget, reminder) 286 at 3.04; paid and data loss 33 at 1.73; paid and support never answered 52 at 1.92

- **Where:** §0.3 payer sub-segment table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Payer sub-segment | n | Mean ★ ; Paid and reports value (fair price, trust, clean/cute, outcome) at 4–5★ | 306 | 4.92 ; Paid and an entitlement broke (restore / billing / refund / regression / price rise) | 80 | 2.62 ; Paid and a reliability failure (crash, lag, update, data loss, sync, widget, reminder) | 286 | 3.04 ; Paid and data loss | 33 | 1.73 ; Paid and support never answered | 52 | 1.92
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R52-033 — Simplicity is the product and every redesign is judged against it: aesthetic praise union 3,537 (17.14%, high-priority, mean 4.80) — DES_CLEAN 1,716 (8.32%), DES_CUTE 1,431 (6.94%), DES_PRETTY 429 (2.08%), DES_ICON_LIKE 321 (1.56%); interface regression union 824 (3.99%, very strong, mean 3.58) — DES_REDESIGN 372 (1.80%), DES_DENSE 427 (2.07%), DES_NEG 102 (0.49%)

- **Where:** §0.6
- **This app does:** clean, cute design
- **User reaction:** praise
- **Magnitude:** aesthetic 3,537 (17.14%, 4.80); regression 824 (3.99%, 3.58)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R52-038 — Untranslated UI plus a precise-location permission request made a US reviewer conclude the app was malware — titled 'Malware?? DO NOT INSTALL' (1★, 2024); a Canadian 'I'd give 4 or 5 stars' if everything were in English (1★, 2019) — a rating contradiction caused purely by localisation

- **Where:** §0.7 quote 11313989030
- **This app does:** Chinese strings in English UI + location permission
- **User reaction:** 1★-burst
- **Magnitude:** n=2 quotes
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `11313989030`, `5222510620`
- **Canonical:** C027 Localise early — it unlocks revenue; C085 Address tracking / privacy visibly

### R52-039 — Reported real-world outcomes: 1,340 reviews (6.49%, high-priority, mean 4.88) — self-discipline OUT_DISCIPLINE 761 (3.69%), less procrastination 107, fitness 190, study 115, mental health 57; 'to push my depressed self to do the small daily things' (5★, Dec 2025); 'this app helped me quit smoking for 577 days' (5★, Apr 2026)

- **Where:** §0.8 Outcomes; §3.4 P3
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 1,340 (6.49%, 4.88)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `13578778405`, `13925038009`
- **Canonical:** — (nuance register)

### R52-040 — Tenure is rising: USER_LONGTERM 705 (3.42%, very strong, mean 4.63); 460 of these (65.2%) written in 2024–2026, when long-tenure users were 8.1%, 6.7% and 8.5% of each year's reviews; 'eight years of yoga logged… my 2,000th check-in' (5★, Aug 2026)

- **Where:** §0.8 Tenure
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 705 (3.42%, 4.63); 2024/25/26 8.1% / 6.7% / 8.5%
- **Direction for us:** none · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `14460751570`
- **Canonical:** — (nuance register)

### R52-043 — The five decisions this corpus supports: 1 fix the ad mechanics, not the ad model (remove motion-triggered and auto-jump ads, make close close, no ads after check-in or to payers, surface the 8-yuan SKU honestly); 2 one account owns membership and data across iPhone, iPad, Mac and Android, and restoring a user's own records is never paywalled; 3 a release gate in front of old-iOS devices and data migrations (six waves = 42.5% of crash reviews, at least three destroyed data); 4 ship new UI as opt-in and never remove one-tap check-in; 5 finish English and Traditional Chinese strings, starting with notifications and ads

- **Where:** §0.9 (five decisions)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none beyond cited sections
- **Direction for us:** product-rule · **Report confidence:** report's decisions · **Generalisable:** generalisable
- **Canonical:** C027 Localise early — it unlocks revenue; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C156 Content and event releases need a crash gate across device generations; C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever; C269 If the free tier carries ads, never use hijacking ad mechanics — no auto-jump into other apps, no shake or tilt triggers, a close control that closes, and no ad on the check-in; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R52-073 — Money-grab accusations: PAY_SCAM 183 (0.89%, emerging, mean 1.36) — 158 of 183 at 1★ (86.3%), the most rating-concentrated theme in the corpus; the trigger is almost always a re-scoping or an unexpected charge, rarely the price level itself

- **Where:** §3.3 N7
- **This app does:** re-scoping and unexpected charges
- **User reaction:** 1★-burst
- **Magnitude:** 183 (0.89%, 1.36); 86.3% 1★
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `6014282876`, `7527160505`, `8372670716`, `11012729767`, `12834474035`, `13599050555`
- **Canonical:** C001 Never move a free feature behind the paywall; C186 Never revoke what earlier buyers paid for when the model changes

### R52-077 — Clean and simple is the #1 substantive theme: DES_CLEAN 1,716 (8.32%, high-priority, mean 4.84), stable across nine years (4.2–13.6% of each year), recovered to 9–11% in 2024–2026

- **Where:** §3.4 P1
- **This app does:** clean, simple UI
- **User reaction:** praise
- **Magnitude:** 1,716 (8.32%, 4.84)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `2239007655`, `5234243491`, `8292363946`, `12806346802`, `14466033004`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R52-079 — Reported outcomes by type: OUT_DISCIPLINE 761 (3.69%, 4.90), OUT_FITNESS 190 (0.92%, 4.80), OUT_LIFE 168 (0.81%, 4.93), OUT_STUDY 115 (0.56%, 4.83), OUT_PROCRAST 107 (0.52%, 4.89), OUT_MENTAL 57 (0.28%, 4.91), OUT_ADHD 6

- **Where:** §3.4 P3
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 1,340 (6.49%, 4.88)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `5743585438`, `11919980065`, `13662299946`
- **Canonical:** — (nuance register)

### R52-082 — No social layer, no noise: AD_NONE_PRAISE 172 (0.83%, emerging, mean 4.90) rose in 2024–2026 (1.3–1.7% of reviews) because paying members and pre-ad-era builds were compared explicitly with the new ad experience; SOC_NOSOCIAL 120 (0.58%, 4.85)

- **Where:** §3.4 P6
- **This app does:** ad-free for payers (when it works)
- **User reaction:** praise
- **Magnitude:** AD_NONE_PRAISE 172 (0.83%, 4.90); 2024–26 1.3–1.7%
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `1799881579`, `3020069241`, `11772429963`, `12727553179`, `14403408295`
- **Canonical:** C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R52-113 — Motivation: rewards and cards beat streaks — STAT_REWARD 312 (1.51%, mean 4.65) and CARD_GOOD 106 (0.51%, 4.83) against CARD_BUG 193 (0.94%, 3.96) and CARD_WANT 154 (0.75%), versus STAT_STREAK 106 (0.51%, 4.00); the reward shop (points exchanged for self-set wishes) is praised as a way to delay spending — one reviewer asks for separate point currencies per habit type, another uses it to curb impulse buying

- **Where:** §4.2
- **This app does:** reward shop with self-set wishes
- **User reaction:** praise
- **Magnitude:** STAT_REWARD 312 (4.65) vs STAT_STREAK 106 (4.00)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `13992537486`, `14002570586`
- **Canonical:** C052 Points / rewards / wish list

### R52-115 — Scheduling mechanics don't fit real routines — reality is messier than a daily grid: CORE_FREQ 299 (1.45%), CORE_MULTI 237 (1.15%), CORE_RETRO 218 (1.06%), CORE_ORDER 151 (0.73%), CORE_SEGMENT 159 (0.77%, 3.99), CORE_ARCHIVE 133 (0.64%); weekly-N habits spoil a '100% day'; night owls' check-ins after midnight land on the next day; one habit needs two check-ins; to-dos lose their custom order

- **Where:** §4.3
- **This app does:** daily-grid scheduling
- **User reaction:** complaint
- **Magnitude:** CORE family 2,196 (10.64%, 4.43)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8267555469`, `3867825890`, `14510307751`, `9824409111`, `14482764227`, `14453965506`, `14435125339`
- **Canonical:** C043 Flexible / custom frequency; C143 Intra-day completion: tap N times to fill N/N; C170 Configurable day boundary and hemisphere seasons

### R52-134 — 5★ (n=13,415, 65.01%): 30.8% (4,131) carry no product content, plus 445 pre-use and 233 review-to-unlock; substantive praise is simplicity (DES_CLEAN 11.1%), cuteness (DES_CUTE 8.7%), purchase satisfaction (PAY_BOUGHT 6.1%), outcomes (OUT_DISCIPLINE 5.2%), tenure (USER_LONGTERM 4.4%); 5★ is also where requests live — JRNL_WANT 387, DES_ICON_WANT 356, REM_WANT 323, STAT_WANT 267 all majority-5★ ('I love it, please add X'); differentiator signal: DEV_TRUST 204 of 213 at 5★ and META_RECOMMEND 277 of 289

- **Where:** §5.1
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 13,415 (65.01%); 4,131 low-info (30.8%)
- **Direction for us:** none · **Report confidence:** band summary · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-135 — 4★ (n=3,278, 15.89%) is the request band — REM_WANT 5.7%, JRNL_WANT 5.6%, STAT_WANT 4.7%, DES_ICON_WANT 4.5% — and where the quota bites without anger (PAY_CAP5 5.5%: 'love it, wish more habits were free'); 4★ reviewers name the one thing withheld from 5★ — language, or ads added recently

- **Where:** §5.2
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 3,278 (15.89%); PAY_CAP5 5.5%
- **Direction for us:** none · **Report confidence:** band summary · **Generalisable:** app-specific
- **Review IDs:** `3300136517`, `5818585169`, `10229830471`, `12806854675`
- **Canonical:** — (nuance register)

### R52-136 — 3★ (n=1,498, 7.26%): monetisation and reliability without contempt — PAY_CAP5 10.3%, AD_NEG 9.3%, BUG_FEATURE 6.7%, BUG_UPDATE 5.5%, BUG_CRASH 4.6%, PLAT_WIDGET_BUG 4.3%; a typical 3★ is a paying user listing numbered bugs

- **Where:** §5.3
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 1,498 (7.26%)
- **Direction for us:** none · **Report confidence:** band summary · **Generalisable:** app-specific
- **Review IDs:** `5170598820`, `11602790209`, `13804721782`
- **Canonical:** — (nuance register)

### R52-137 — 2★ (n=570, 2.76%): AD_NEG 18.1%, PAY_CAP5 17.2%, PAY_WALL 13.0%; the 2★ reviewer usually still uses the app and is warning others ('used it for years… if this continues I'll really switch apps')

- **Where:** §5.4
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 570 (2.76%); AD_NEG 18.1%
- **Direction for us:** none · **Report confidence:** band summary · **Generalisable:** app-specific
- **Review IDs:** `12803944732`
- **Canonical:** — (nuance register)

### R52-138 — 1★ (n=1,873, 9.08%): AD_NEG 20.4% (383), PAY_WALL 15.9%, PAY_CAP5 13.7%, PAY_BOUGHT 9.0% (168 paid reviewers), PAY_SCAM 8.4%, BUG_UPDATE 7.0%, BUG_CRASH 6.0%, SUP_BAD 5.0%, DATA_LOSS 4.5%, PAY_RESTORE 4.2%; two churn drivers: 1 moral objection to monetisation (PAY_SCAM, 86.3% 1★); 2 loss of something already invested — data, streak or a paid entitlement — and these are long-tenure users: USER_LONGTERM has 34 1★ ('five whole years wasted'), DATA_LOSS is 37.1% 1★

- **Where:** §5.5
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 1,873 (9.08%); USER_LONGTERM 34 1★; DATA_LOSS 37.1% 1★
- **Direction for us:** must-never-break · **Report confidence:** band summary · **Generalisable:** generalisable
- **Review IDs:** `11776198730`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C065 Paying customers are the highest 1★ risk — every paid feature must work; C186 Never revoke what earlier buyers paid for when the model changes

### R52-144 — Purchase trigger 1 — the look, within days of install: 'Downloaded, five minutes later bought premium'; 'third day, bought 大太阳'; 'within 24 hrs of the trial I bought lifetime' (us); DES_CLEAN in 118 payer reviews, DES_CUTE in 88

- **Where:** §6.2 #1
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** DES_CLEAN 118 payers; DES_CUTE 88
- **Direction for us:** do · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `2878274954`, `5743585438`, `14053361336`
- **Canonical:** C185 Aesthetic and a polished onboarding convert; they do not retain

### R52-147 — Purchase trigger 4 — supporting an indie developer: DEV_TRUST ∩ paid 52 (mean 4.98); 'less than a Starbucks for a good mood every day — absolutely worth it' (54 votes); bought 'so the app can keep running'

- **Where:** §6.2 #4
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 52 (4.98); 54-vote review
- **Direction for us:** do · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Review IDs:** `5234243491`, `12398631654`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R52-153 — Distrust after watching re-scoping blocks future purchases — 'no longer want to buy' (PAY_SCAM 183 at 1.36 / PAY_REGRESS 75 at 2.15)

- **Where:** §6.3 distrust row
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** 183 / 75
- **Direction for us:** product-rule · **Report confidence:** emerging / weak · **Generalisable:** generalisable
- **Review IDs:** `12834474035`
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

### R52-157 — Signals that would change a paying user's mind, in order of recurrence: 1 membership and data that follow the account to any device; 2 no ads for anyone who has paid anything; 3 keep one-tap check-in and ship redesigns as optional; 4 a reply when something breaks; 5 more icons and themes; 6 photos in logs; 7 an Apple Watch app — none is a price cut; payers overwhelmingly find the price fair (PAY_PRICE_OK lift 4.58)

- **Where:** §6.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** PAY_PRICE_OK lift 4.58
- **Direction for us:** product-rule · **Report confidence:** report's reading · **Generalisable:** generalisable
- **Canonical:** C009 Basic widgets, icons and colours are free; C022 Apple Watch app (done properly: timer, two-way sync); C036 A support channel that exists, is reachable outside the app, and answers; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C208 Photo / media / URL attached to a habit, memo or diary entry; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R52-187 — Persistent themes unchanged for nine years across releases, price changes and redesigns: DES_CLEAN praise, DES_DENSE fear, PLAT_WATCH requests, LOC_UNTRANS, DATA_LOSS and the request for photos in notes

- **Where:** §8.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** nine years
- **Direction for us:** none · **Report confidence:** trend · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

### R52-207 — Research questions: Q1 what share of revenue did the June 2025 ad formats and the ¥8 SKU produce, against churn among active users (reviews show cost, not revenue); Q2 how many legacy lifetime buyers exist and what share lost their entitlement in the 2020 subscription switch; Q3 does the habit quota vary by cohort or test (same-month reviewers report 3, 5 and 8); Q4 why is Hong Kong the best-ranked storefront with the lowest public average; Q5 would an English-complete build change US/CA/AU acquisition (the public rating gap is uniform, so ratings won't answer); Q6 is the ADHD positioning supported by any user data outside reviews

- **Where:** §9.4 Q1–Q6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

## Audiences

### R52-017 — Ads contradict the calm purpose of the product and hit vulnerable users: a two-year user 'ads contradict the app's purpose of calming you down. Sorry, uninstalled' (3★, us storefront, Chinese text, Jun 2025); a chronic-illness patient logging medication says the growing ads are 'agitating for a patient' (1★, Oct 2025)

- **Where:** §0.1 quotes
- **This app does:** ads in a calm self-care app
- **User reaction:** churn
- **Magnitude:** report gives none
- **Direction for us:** dont · **Report confidence:** very strong (parent theme) · **Generalisable:** generalisable
- **Review IDs:** `12743825635`, `13229374881`
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R52-083 — Reminders that work: REM_GOOD 185 (0.90%, emerging, mean 4.88), frequently for medication or life admin — medication logging, an IVF medication schedule

- **Where:** §3.4 P7
- **This app does:** reliable reminders
- **User reaction:** praise
- **Magnitude:** 185 (0.90%, 4.88)
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `13229374881`, `13812563564`
- **Canonical:** C039 Reminders fire reliably, once; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R52-128 — ADHD and neurodivergence: 6 reviews (0.03%, ignore), all positive (mean 4.83) — breaking 'get ready' into steps helps with likely ADHD (gb, 5★, 2018, 2 votes); 'adhd, hope to keep using' (cn, 2023); 'adhd good review' (cn, 4★, 2025); 'very suitable for adhd' (cn, 2025) — too few for any product claim, recorded because the listing uses ADHD in its name

- **Where:** §4.8
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 6 (0.03%, 4.83)
- **Direction for us:** research · **Report confidence:** ignore · **Generalisable:** generalisable
- **Review IDs:** `3254531371`, `7621851935`, `9740237093`, `12499012234`, `12545714069`, `13137415583`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R52-142 — Who the paying reviewers are — full lift table (verbatim): PAY_LIFETIME lift 7.39 (199, 4.36); PAY_TIERS 5.11; PAY_PRICE_OK 4.58 (4.89); SOC_NOSOCIAL 4.55 (4.94); SUP_BAD 4.53 (1.92); DEV_TRUST 3.92 (4.98); DATA_BACKUP 3.74 (3.68); DES_THEME 3.65; REM_FAIL 3.62 (3.24); USER_CROSSAPP 3.49 (4.58); DATA_SYNC_FAIL 3.29 (2.87); PAY_RESTORE 3.21 (2.63); DES_ICON_WANT 2.83; DATA_ACCOUNT 2.41; CARD_BUG 2.41; DATA_LOSS 2.31 (1.73); BUG_FEATURE 2.06 (3.17); BUG_CRASH 1.83 (2.60); AD_NEG 0.73 (2.85); DES_CUTE 0.99

- **Where:** §6.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n among paid | Segment rate (of 1,286) | Global n | Global % | Lift | Mean ★ within paid ; PAY_LIFETIME | mixed | 199 | 15.5% | 432 | 2.09% | 7.39 | 4.36 ; DES_CLEAN | positive | 118 | 9.2% | 1,716 | 8.32% | 1.10 | 4.86 ; DES_ICON_WANT | request / unmet need | 99 | 7.7% | 561 | 2.72% | 2.83 | 4.43 ; USER_LONGTERM | context | 89 | 6.9% | 705 | 3.42% | 2.03 | 4.60 ; DES_CUTE | positive | 88 | 6.8% | 1,431 | 6.94% | 0.99 | 4.78 ; BUG_FEATURE | negative | 83 | 6.5% | 647 | 3.14% | 2.06 | 3.17 ; DES_THEME | mixed | 78 | 6.1% | 343 | 1.66% | 3.65 | 4.55 ; PAY_PRICE_OK | positive | 73 | 5.7% | 256 | 1.24% | 4.58 | 4.89 ; REM_FAIL | negative | 63 | 4.9% | 279 | 1.35% | 3.62 | 3.24 ; DEV_TRUST | positive | 52 | 4.0% | 213 | 1.03% | 3.92 | 4.98 ; SUP_BAD | negative | 52 | 4.0% | 184 | 0.89% | 4.53 | 1.92 ; USER_CROSSAPP | context | 50 | 3.9% | 230 | 1.11% | 3.49 | 4.58 ; USER_SWITCH | context | 48 | 3.7% | 355 | 1.72% | 2.17 | 4.40 ; REM_WANT | request / unmet need | 48 | 3.7% | 588 | 2.85% | 1.31 | 4.56 ; BUG_CRASH | negative | 47 | 3.7% | 412 | 2.00% | 1.83 | 2.60 ; JRNL_WANT | request / unmet need | 46 | 3.6% | 668 | 3.24% | 1.10 | 4.57 ; BUG_UPDATE | negative | 45 | 3.5% | 524 | 2.54% | 1.38 | 2.78 ; PLAT_IPAD | request / unmet need | 45 | 3.5% | 380 | 1.84% | 1.90 | 4.00 ; FOCUS | mixed | 43 | 3.3% | 390 | 1.89% | 1.77 | 4.00 ; PLAT_WIDGET_BUG | negative | 41 | 3.2% | 454 | 2.20% | 1.45 | 3.29 ; DES_PRETTY | positive | 40 | 3.1% | 429 | 2.08% | 1.50 | 4.53 ; AD_NEG | negative | 40 | 3.1% | 885 | 4.29% | 0.73 | 2.85 ; PAY_RESTORE | negative | 38 | 3.0% | 190 | 0.92% | 3.21 | 2.63 ; DES_DENSE | negative | 37 | 2.9% | 427 | 2.07% | 1.39 | 3.32 ; CORE_FREQ | request / unmet need | 37 | 2.9% | 299 | 1.45% | 1.99 | 4.54 ; PAY_TIERS | negative | 36 | 2.8% | 113 | 0.55% | 5.11 | 3.25 ; SOC_NOSOCIAL | positive | 34 | 2.6% | 120 | 0.58% | 4.55 | 4.94 ; REQ_OTHER | request / unmet need | 33 | 2.6% | 395 | 1.91% | 1.34 | 4.48 ; DATA_LOSS | negative | 33 | 2.6% | 229 | 1.11% | 2.31 | 1.73 ; DES_REDESIGN | negative | 32 | 2.5% | 372 | 1.80% | 1.38 | 2.66 ; DATA_BACKUP | mixed | 31 | 2.4% | 133 | 0.64% | 3.74 | 3.68 ; DATA_SYNC_FAIL | negative | 31 | 2.4% | 151 | 0.73% | 3.29 | 2.87 ; DATA_ACCOUNT | negative | 30 | 2.3% | 200 | 0.97% | 2.41 | 3.63 ; STAT_WANT | request / unmet need | 30 | 2.3% | 478 | 2.32% | 1.01 | 4.23 ; CARD_BUG | negative | 29 | 2.3% | 193 | 0.94% | 2.41 | 3.41 ; DES_ICON_LIKE | positive | 28 | 2.2% | 321 | 1.56% | 1.40 | 4.82 ; PLAT_ANDROID | request / unmet need | 27 | 2.1% | 195 | 0.95% | 2.22 | 3.81 ; CORE_TODO | mixed | 25 | 1.9% | 307 | 1.49% | 1.31 | 4.40 ; CORE_SEGMENT | mixed | 22 | 1.7% | 159 | 0.77% | 2.22 | 3.95 ; PLAT_WATCH | request / unmet need | 22 | 1.7% | 256 | 1.24% | 1.38 | 4.59
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-152 — Students without money are a conversion barrier — a Grade 7 reviewer: 'forty-plus yuan, any conscience?'; USER_STUDENT 123 (0.60%, emerging, mean 4.15)

- **Where:** §6.3 students row
- **This app does:** no student price
- **User reaction:** blocked-conversion
- **Magnitude:** USER_STUDENT 123 (0.60%, 4.15)
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `9608922496`, `8759088131`
- **Canonical:** C025 Scholarship / hardship / discount program

## Markets and languages

### R52-022 — The iOS quota was tighter than Android's and switchers noticed: 'on Android I could add a dozen, why treat us differently?' (1★, 2019)

- **Where:** §0.2 bullet 'iOS quota was tighter than Android's'
- **This app does:** iOS free quota smaller than Android's
- **User reaction:** complaint
- **Magnitude:** report gives none
- **Direction for us:** dont · **Report confidence:** very strong (parent theme) · **Generalisable:** generalisable
- **Conditions:** cross-platform app with different per-platform limits
- **Review IDs:** `3853033716`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R52-037 — The international users literally cannot read the app: LOC_UNTRANS 153 globally (0.74%, emerging, mean 3.25) but 100 of 453 reviews from English-primary storefronts (22.1% segment rate, mean 3.00) say notifications, pop-ups, prompts and ads remain in Chinese with the device set to English; in each eligible non-Chinese storefront it is the single largest theme — us 64/287 (22.30%), ca 14/61 (22.95%), au 11/53 (20.75%), high-priority at country denominator; Taiwan's equivalent: LOC_WANT 46/201 (22.89%, high-priority) for missing Traditional Chinese; public average there still 4.65–4.74, so not sinking the listing, but named by almost every fourth non-Chinese reviewer; decision: finish English and Traditional Chinese strings, starting with notifications and ads

- **Where:** §0.7; §0.9 #5
- **This app does:** partial English localisation; no Traditional Chinese
- **User reaction:** complaint
- **Magnitude:** us 64/287 (22.30%); ca 14/61 (22.95%); au 11/53 (20.75%); tw LOC_WANT 46/201 (22.89%)
- **Direction for us:** do · **Report confidence:** high-priority (country denominators) · **Generalisable:** generalisable
- **Review IDs:** `3000754446`, `6448767945`, `5222510620`
- **Canonical:** C027 Localise early — it unlocks revenue

### R52-075 — International users can't read the app: LOC_UNTRANS 153 (0.74%) + LOC_WANT 99 (0.48%, weak, mean 3.63) + LOC_ENGBAD 11 (0.05%) — small globally, the top theme in every eligible non-mainland storefront

- **Where:** §3.3 N9
- **This app does:** incomplete localisation
- **User reaction:** complaint
- **Magnitude:** 153 + 99 + 11
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** generalisable
- **Canonical:** C027 Localise early — it unlocks revenue

### R52-078 — Cute art style: DES_CUTE 1,431 (6.94%, high-priority, mean 4.77) — dominant at launch (18.5% of 2017), declining steadily to 2.9% in 2026 while DES_CLEAN held, so the app is increasingly praised for calm rather than cuteness; in non-mainland storefronts cuteness is still the lead praise (us 20.56%, ca 14.75%, au 13.21%, tw 12.94%); DES_PRETTY 429 (2.08%, 4.75), DES_ICON_LIKE 321 (1.56%, 4.78)

- **Where:** §3.4 P2
- **This app does:** cute illustrated style
- **User reaction:** praise
- **Magnitude:** 1,431 (6.94%, 4.77); 18.5% (2017) → 2.9% (2026); us 20.56%
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `1799881579`, `3300136517`, `13445617661`, `14053361336`
- **Canonical:** C185 Aesthetic and a polished onboarding convert; they do not retain

### R52-151 — Payment method / purchase flow broken in 2018 — 112 PAY_BILLING reviews that year, including no Alipay / WeChat Pay option on iOS

- **Where:** §6.3 payment method row
- **This app does:** App Store billing only; no local wallets
- **User reaction:** blocked-conversion
- **Magnitude:** 112 in 2018
- **Direction for us:** do · **Report confidence:** meaningful (parent) · **Generalisable:** generalisable
- **Review IDs:** `1984445137`, `2399860126`, `2433751859`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK)

### R52-158 — Storefront eligibility, 48 storefronts (verbatim): six clear 50 and are analysed individually; the other 42 hold 244 reviews and are limited evidence, included in global figures only

- **Where:** §7.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** CC | Storefront | Written reviews | % of corpus | Written mean ★ | 1/2/3/4/5 | Public ratings (snapshot) | Public avg | Search rank | Market tier | Standalone analysis ; cn | China mainland | 19,669 | 95.32% | 4.25 | 1784/533/1428/3117/12807 | 550321 | 4.78 | 3 | rich | ✅ eligible (≥50) ; us | United States | 287 | 1.39% | 4.16 | 32/11/17/46/181 | 3259 | 4.71 | 26 | rich | ✅ eligible (≥50) ; tw | Taiwan | 201 | 0.97% | 4.20 | 19/8/14/32/128 | 2509 | 4.74 | 4 | rich | ✅ eligible (≥50) ; hk | Hong Kong | 119 | 0.58% | 4.23 | 11/3/8/23/74 | 2093 | 4.65 | 2 | rich | ✅ eligible (≥50) ; ca | Canada | 61 | 0.30% | 4.34 | 2/3/7/9/40 | — | — | — | not ranked | ✅ eligible (≥50) ; au | Australia | 53 | 0.26% | 4.04 | 6/2/6/9/30 | 651 | 4.71 | 26 | rich | ✅ eligible (≥50) ; gb | United Kingdom | 40 | 0.19% | 4.10 | 2/4/5/6/23 | — | — | — | not ranked | [limited evidence] ; sg | Singapore | 27 | 0.13% | 4.19 | 4/0/1/4/18 | 310 | 4.71 | 7 | rich | [limited evidence] ; jp | Japan | 24 | 0.12% | 4.71 | 0/1/0/4/19 | 529 | 4.83 | 28 | rich | [limited evidence] ; de | Germany | 22 | 0.11% | 4.18 | 4/0/0/2/16 | 176 | 4.66 | 34 | rich | [limited evidence] ; my | Malaysia | 20 | 0.10% | 4.25 | 1/0/3/5/11 | 482 | 4.7 | 9 | volume | [limited evidence] ; ph | Philippines | 10 | 0.05% | 4.40 | 0/0/2/2/6 | 86 | 4.76 | 16 | volume | [limited evidence] ; fr | France | 10 | 0.05% | 3.70 | 2/0/2/1/5 | 111 | 4.77 | 35 | rich | [limited evidence] ; nz | New Zealand | 9 | 0.04% | 3.67 | 2/0/1/2/4 | 81 | 4.69 | 32 | rich | [limited evidence] ; id | Indonesia | 8 | 0.04% | 4.88 | 0/0/0/1/7 | 75 | 4.79 | 12 | volume | [limited evidence] ; nl | Netherlands | 7 | 0.03% | 4.29 | 0/0/1/3/3 | 31 | 4.65 | 31 | rich | [limited evidence] ; it | Italy | 7 | 0.03% | 3.43 | 0/3/0/2/2 | 88 | 4.52 | 27 | rich | [limited evidence] ; vn | Vietnam | 6 | 0.03% | 4.50 | 0/0/0/3/3 | 71 | 4.62 | 29 | volume | [limited evidence] ; se | Sweden | 5 | 0.02% | 4.80 | 0/0/0/1/4 | 20 | 4.65 | 38 | rich | [limited evidence] ; mo | MO | 4 | 0.02% | 4.25 | 0/1/0/0/3 | — | — | — | not ranked | [limited evidence] ; th | Thailand | 4 | 0.02% | 5.00 | 0/0/0/0/4 | 89 | 4.81 | 37 | volume | [limited evidence] ; sa | Saudi Arabia | 4 | 0.02% | 5.00 | 0/0/0/0/4 | 30 | 4.7 | 24 | rich | [limited evidence] ; es | Spain | 4 | 0.02% | 4.00 | 1/0/0/0/3 | 78 | 4.6 | 26 | rich | [limited evidence] ; kr | South Korea | 3 | 0.01% | 2.33 | 2/0/0/0/1 | — | — | — | not ranked | [limited evidence] ; ie | Ireland | 3 | 0.01% | 5.00 | 0/0/0/0/3 | — | — | — | not ranked | [limited evidence] ; qa | QA | 2 | 0.01% | 4.00 | 0/0/1/0/1 | — | — | — | not ranked | [limited evidence] ; ar | Argentina | 2 | 0.01% | 4.00 | 0/0/1/0/1 | 4 | 4.5 | 35 | volume | [limited evidence] ; br | Brazil | 2 | 0.01% | 3.50 | 0/1/0/0/1 | 24 | 4.62 | 41 | volume | [limited evidence] ; ae | UAE | 2 | 0.01% | 4.50 | 0/0/0/1/1 | 21 | 4.81 | 31 | rich | [limited evidence] ; lk | LK | 1 | 0.00% | 5.00 | 0/0/0/0/1 | — | — | — | not ranked | [limited evidence] ; at | Austria | 1 | 0.00% | 5.00 | 0/0/0/0/1 | 9 | 4.89 | 29 | rich | [limited evidence] ; ch | Switzerland | 1 | 0.00% | 4.00 | 0/0/0/1/0 | — | — | — | not ranked | [limited evidence] ; pl | Poland | 1 | 0.00% | 4.00 | 0/0/0/1/0 | 4 | 4.75 | 36 | volume | [limited evidence] ; cz | Czechia | 1 | 0.00% | 5.00 | 0/0/0/0/1 | 4 | 4.75 | 42 | volume | [limited evidence] ; cl | Chile | 1 | 0.00% | 5.00 | 0/0/0/0/1 | 6 | 5 | 34 | volume | [limited evidence] ; in | India | 1 | 0.00% | 5.00 | 0/0/0/0/1 | 38 | 4.61 | 38 | volume | [limited evidence] ; mn | MN | 1 | 0.00% | 5.00 | 0/0/0/0/1 | — | — | — | not ranked | [limited evidence] ; mv | MV | 1 | 0.00% | 3.00 | 0/0/1/0/0 | — | — | — | not ranked | [limited evidence] ; no | Norway | 1 | 0.00% | 5.00 | 0/0/0/0/1 | 4 | 3.75 | 34 | rich | [limited evidence] ; eg | Egypt | 1 | 0.00% | 1.00 | 1/0/0/0/0 | 14 | 4.57 | 30 | volume | [limited evidence] ; tr | Turkey | 1 | 0.00% | 4.00 | 0/0/0/1/0 | 14 | 4.64 | 37 | volume | [limited evidence] ; mx | Mexico | 1 | 0.00% | 5.00 | 0/0/0/0/1 | 21 | 5 | 36 | volume | [limited evidence] ; kz | KZ | 1 | 0.00% | 5.00 | 0/0/0/0/1 | — | — | — | not ranked | [limited evidence] ; ru | Russia | 1 | 0.00% | 4.00 | 0/0/0/1/0 | — | — | — | not ranked | [limited evidence] ; za | South Africa | 1 | 0.00% | 4.00 | 0/0/0/1/0 | — | — | — | not ranked | [limited evidence] ; pk | Pakistan | 1 | 0.00% | 5.00 | 0/0/0/0/1 | 7 | 3.86 | 40 | volume | [limited evidence] ; bg | BG | 1 | 0.00% | 5.00 | 0/0/0/0/1 | — | — | — | not ranked | [limited evidence] ; dk | Denmark | 1 | 0.00% | 5.00 | 0/0/0/0/1 | 5 | 4.6 | 26 | rich | [limited evidence]
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-159 — High-spend markets (market_tier = rich from habit_apps_ranked.json): 19 storefronts (cn, us, tw, hk, au, sg, jp, de, fr, nz, nl, it, se, sa, es, ae, at, no, dk) hold 20,453 reviews (mean 4.25); excluding cn 784 reviews, mean 4.19 — top themes DES_CUTE 14.2%, META_LOWINFO 12.8%, LOC_UNTRANS 12.4%, DES_CLEAN 11.0%, LOC_WANT 8.8%, PAY_BOUGHT 7.5%, USER_LONGTERM 5.0%, DES_PRETTY 4.5%, PAY_PRICE_OK 4.1%, PAY_LIFETIME 3.6%; monetisation reads differently here — price is praised, not resisted, and ads barely appear (AD_NEG outside cn totals 21 reviews across all 47 non-cn storefronts)

- **Where:** §7.2 high-spend markets
- **This app does:** same app across markets; ads concentrated on cn
- **User reaction:** mixed
- **Magnitude:** rich ex-cn 784 (4.19); LOC_UNTRANS 12.4%; AD_NEG non-cn 21
- **Direction for us:** do · **Report confidence:** market group · **Generalisable:** generalisable
- **Canonical:** C027 Localise early — it unlocks revenue; C062 Weight English-speaking rich markets; volume ≠ revenue

### R52-160 — High-review-volume markets (review volume as a disclosed proxy, no download data): (a) ≥50 written reviews cn, us, tw, hk, ca, au — 20,390 reviews, 98.82%; (b) public rating count cn 550,321 · us 3,259 · tw 2,509 · hk 2,093 · au 651 · jp 529 · my 482; lists agree except ca and gb are not ranked in the snapshot and jp/my have few written reviews; the volume tier (15 emerging-market storefronts) holds 60 reviews (mean 4.40) with LOC_UNTRANS in 20 (33.3%) — limited evidence, same direction as every other non-Chinese group

- **Where:** §7.2 high-review-volume markets
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 20,390 (98.82%); volume tier 60 (4.40), LOC_UNTRANS 20 (33.3%)
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Canonical:** C027 Localise early — it unlocks revenue

### R52-161 — Language groups (verbatim): mainland cn 19,669 at 4.25 — LOWINFO 23.6%, CLEAN 8.2%, CUTE 6.6%, BOUGHT 6.2%, AD_NEG 4.4%, CAP5 4.3%; Traditional-Chinese storefronts (tw, hk, mo) 324 at 4.21 — LOC_WANT 16.7%, LOWINFO 15.4%, CLEAN 10.5%, CUTE 10.5%, BOUGHT 6.8%; English-primary (us, ca, au, gb, nz, ie) 453 at 4.16 — LOC_UNTRANS 22.1%, CUTE 17.0%, CLEAN 11.3%, LOWINFO 10.6%, PRICE_OK 8.6%; rest of world (41 storefronts) 188 at 4.29 — LOC_UNTRANS 16.5%, LOWINFO 12.2%, CLEAN 11.7%, CUTE 11.2%

- **Where:** §7.2 language groups table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Group | Reviews | Mean ★ | Top themes (segment rate) ; Mainland (cn) | 19,669 | 4.25 | LOWINFO 23.6% · CLEAN 8.2% · CUTE 6.6% · BOUGHT 6.2% · AD_NEG 4.4% · CAP5 4.3% ; Traditional-Chinese storefronts (tw, hk, mo) | 324 | 4.21 | LOC_WANT 16.7% · LOWINFO 15.4% · CLEAN 10.5% · CUTE 10.5% · BOUGHT 6.8% ; English-primary (us, ca, au, gb, nz, ie) | 453 | 4.16 | LOC_UNTRANS 22.1% · CUTE 17.0% · CLEAN 11.3% · LOWINFO 10.6% · PRICE_OK 8.6% ; Rest of world (41 storefronts) | 188 | 4.29 | LOC_UNTRANS 16.5% · LOWINFO 12.2% · CLEAN 11.7% · CUTE 11.2%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-162 — China mainland cn n=19,669 (95.32%), mean 4.25, public 550,321 @ 4.78, search rank 3 — top-22 theme table (verbatim)

- **Where:** §7.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n | % of 19,669 (cn) | Band (cn denominator) | Mean ★ | Global % | Representative IDs ; META_LOWINFO | context | 4639 | 23.59% | High-priority | 4.79 | 23.07% | 1950454065 1986965251 2032262921 3409725912 1949718391 ; DES_CLEAN | positive | 1609 | 8.18% | High-priority | 4.84 | 8.32% | 2239007655 6523111476 7014407503 7732711686 2461333284 ; DES_CUTE | positive | 1299 | 6.60% | High-priority | 4.77 | 6.94% | 3825542658 2750063671 2461333284 2524800702 2032262921 ; PAY_BOUGHT | mixed | 1221 | 6.21% | High-priority | 4.11 | 6.23% | 5743585438 8818193734 6968174312 2692072328 2239007655 ; AD_NEG | negative | 864 | 4.39% | Very strong | 2.48 | 4.29% | 5836813780 13599050555 13229374881 6714504989 12838426934 ; PAY_CAP5 | negative | 852 | 4.33% | Very strong | 2.94 | 4.30% | 7014407503 14466033004 2524800702 7113176039 2355084367 ; OUT_DISCIPLINE | positive | 742 | 3.77% | Very strong | 4.90 | 3.69% | 7732711686 12137796234 11586069676 6003841123 14330209556 ; META_PREUSE | context | 707 | 3.59% | Very strong | 4.49 | 3.47% | 1986965251 10206709033 7234588624 1903354458 1962214384 ; PAY_WALL | negative | 702 | 3.57% | Very strong | 2.62 | 3.47% | 2524800702 5662173619 11586069676 2959697257 1932916552 ; USER_LONGTERM | context | 658 | 3.35% | Very strong | 4.63 | 3.42% | 8818193734 6523111476 6984394901 12024716798 8664320195 ; JRNL_WANT | request / unmet need | 652 | 3.31% | Very strong | 4.36 | 3.24% | 6968174312 8127931334 2692072328 6984394901 10004617749 ; BUG_FEATURE | negative | 615 | 3.13% | Very strong | 3.56 | 3.14% | 8127931334 2692072328 2082226839 2077341563 5553105088 ; REM_WANT | request / unmet need | 577 | 2.93% | Meaningful | 4.36 | 2.85% | 2239007655 5553105088 2461333284 6720147190 2821580152 ; DES_ICON_WANT | request / unmet need | 538 | 2.74% | Meaningful | 4.50 | 2.72% | 1950454065 2692072328 2239007655 6523111476 7732711686 ; BUG_UPDATE | negative | 500 | 2.54% | Meaningful | 3.26 | 2.54% | 7130244869 6132700499 13804721782 2003853377 7511231843 ; META_UNLOCK | context | 461 | 2.34% | Meaningful | 4.16 | 2.24% | 2524800702 1986965251 2355084367 1901055265 2360233410 ; STAT_WANT | request / unmet need | 449 | 2.28% | Meaningful | 4.37 | 2.32% | 11719901468 6776816950 7113176039 3171718094 2298692416 ; PLAT_WIDGET_BUG | negative | 430 | 2.19% | Meaningful | 3.91 | 2.20% | 7130244869 14460646052 2003853377 6479997609 5302182129 ; DES_DENSE | negative | 409 | 2.08% | Meaningful | 3.67 | 2.07% | 2082226839 12024716798 8664320195 2298692416 13804721782 ; PAY_LIFETIME | mixed | 401 | 2.04% | Meaningful | 3.96 | 2.09% | 5743585438 6523111476 6984394901 11466372895 6988218645 ; BUG_CRASH | negative | 400 | 2.03% | Meaningful | 3.22 | 2.00% | 2298692416 13185604830 1994680289 2434407272 6816187446 ; DES_PRETTY | positive | 386 | 1.96% | Meaningful | 4.76 | 2.08% | 1986965251 5836813780 8270198642 2355084367 9824409111
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-163 — China is the global picture — every Part 0–6 finding is ≥95% a cn finding; country-specific: all of META_UNLOCK (461 of 462) and of the 2025 ad wave (864 of 885 AD_NEG); all WeChat/QQ login and Android-parity issues (PLAT_ANDROID 193 of 195) and every yuan price figure; SOC_NOSOCIAL is 100% cn (120) — the 'please don't add social' stance is a mainland audience preference in this corpus

- **Where:** §7.3 bullets
- **This app does:** ads and unlock gate concentrated on cn
- **User reaction:** mixed
- **Magnitude:** META_UNLOCK 461/462; AD_NEG 864/885; PLAT_ANDROID 193/195; SOC_NOSOCIAL 120/120
- **Direction for us:** none · **Report confidence:** high-priority (cn) · **Generalisable:** app-specific
- **Canonical:** C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R52-164 — United States us n=287 (1.39%), mean 4.16, public 3,259 @ 4.71, rank 26 — theme table (verbatim)

- **Where:** §7.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n | % of 287 (us) | Band (us denominator) | Mean ★ | Global % | Representative IDs ; LOC_UNTRANS | negative | 64 | 22.30% | High-priority | 2.94 | 0.74% | 6492955149 6620106445 5818585169 5382292307 6570172906 ; DES_CUTE | positive | 59 | 20.56% | High-priority | 4.56 | 6.94% | 6620106445 5818585169 5382292307 13445617661 6570172906 ; DES_CLEAN | positive | 31 | 10.80% | High-priority | 4.97 | 8.32% | 11776505386 13409482292 12806346802 4293570938 13784332361 ; META_LOWINFO | context | 31 | 10.80% | High-priority | 4.84 | 23.07% | 11609518585 5496289185 13277226651 6727728372 11736638744 ; PAY_BOUGHT | mixed | 29 | 10.10% | High-priority | 4.28 | 6.23% | 6897673880 6320027148 7848174072 3500266452 7708239263 ; PAY_PRICE_OK | positive | 23 | 8.01% | High-priority | 4.74 | 1.24% | 13409482292 12806346802 6620106445 6897673880 4612882702 ; USER_LONGTERM | context | 23 | 8.01% | High-priority | 4.61 | 3.42% | 8582609673 7719501489 10751414925 9108669403 9628039930 ; LOC_WORKAROUND | context | 13 | 4.53% | Very strong | 4.54 | 0.09% | 6492955149 6620106445 3500266452 7088209334 7519602304 ; PAY_LIFETIME | mixed | 13 | 4.53% | Very strong | 4.15 | 2.09% | 12806346802 7848174072 12283194695 4414460850 6057434372 ; PAY_CAP5 | negative | 13 | 4.53% | Very strong | 3.69 | 4.30% | 11776505386 5818585169 12283194695 3500266452 6092786915 ; USER_SWITCH | context | 13 | 4.53% | Very strong | 4.92 | 1.72% | 12806346802 5382292307 7708239263 4414460850 10751414925 ; DES_PRETTY | positive | 12 | 4.18% | Very strong | 4.50 | 2.08% | 7848174072 7088209334 7708239263 7519602304 7573098132 ; META_RECOMMEND | positive | 12 | 4.18% | Very strong | 5.00 | 1.40% | 13409482292 12806346802 3500266452 7708239263 3677259067 ; DES_ICON_LIKE | positive | 12 | 4.18% | Very strong | 5.00 | 1.56% | 4293570938 12283194695 7719501489 8465560249 6562515981 ; STAT_WANT | request / unmet need | 10 | 3.48% | Very strong | 4.50 | 2.32% | 6492955149 5382292307 4612882702 11523801306 11705843228 ; SUP_GOOD | positive | 10 | 3.48% | Very strong | 4.70 | 0.72% | 11776505386 7719501489 7573098132 9628039930 13466654925 ; LOC_WANT | request / unmet need | 9 | 3.14% | Very strong | 3.00 | 0.48% | 3500266452 3038448006 4385664490 13466654925 7156975679 ; DES_THEME | mixed | 9 | 3.14% | Very strong | 4.67 | 1.66% | 12806346802 3500266452 5907319251 9108669403 13466654925 ; STAT_REWARD | positive | 9 | 3.14% | Very strong | 4.89 | 1.51% | 13972073586 11771895892 4050731883 12921528371 12499439081 ; PLAT_WIDGET_BUG | negative | 9 | 3.14% | Very strong | 3.56 | 2.20% | 6492955149 6461688067 7719501489 8239700598 8286878940 ; DES_ICON_WANT | request / unmet need | 8 | 2.79% | Meaningful | 4.75 | 2.72% | 4293570938 9628039930 14053361336 13466654925 2731222610 ; BUG_UPDATE | negative | 8 | 2.79% | Meaningful | 3.25 | 2.54% | 7519571134 5907319251 4184277058 7553360995 5909357249
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-165 — US: LOC_UNTRANS 64 (22.30%, high-priority, mean 2.94) is the top theme; LOC_WORKAROUND 13 (4.53%, very strong) shows users coping — translating screenshots, guessing icons (6 votes, the most-upvoted US review); DES_CUTE 59 (20.56%) is the reason they stay; monetisation is not the US problem — PAY_PRICE_OK 23 (8.01%) outnumbers every price complaint combined (PAY_CAP5 13, PAY_WALL 2, PAY_PRICE_HIGH 2); AD_NEG 6 (2.09%), BUG_CRASH 0; USER_LONGTERM 23 (8.01%) since 2019–2020

- **Where:** §7.4 bullets
- **This app does:** Chinese strings in English UI
- **User reaction:** mixed
- **Magnitude:** LOC_UNTRANS 64 (22.30%, 2.94); PAY_PRICE_OK 23 (8.01%)
- **Direction for us:** do · **Report confidence:** high-priority (us) · **Generalisable:** generalisable
- **Review IDs:** `6620106445`, `9628039930`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C027 Localise early — it unlocks revenue

### R52-166 — Taiwan tw n=201 (0.97%), mean 4.20, public 2,509 @ 4.74, rank 4 — theme table (verbatim)

- **Where:** §7.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n | % of 201 (tw) | Band (tw denominator) | Mean ★ | Global % | Representative IDs ; LOC_WANT | request / unmet need | 46 | 22.89% | High-priority | 3.63 | 0.48% | 7299698208 14285773927 12925856919 5805783345 6963815688 ; DES_CUTE | positive | 26 | 12.94% | High-priority | 4.85 | 6.94% | 13131137254 12925856919 4509008512 2066570829 3018949395 ; DES_CLEAN | positive | 22 | 10.95% | High-priority | 4.64 | 8.32% | 13131137254 2494551620 7082666221 12925856919 4509008512 ; META_LOWINFO | context | 21 | 10.45% | High-priority | 4.86 | 23.07% | 4386784898 12003743779 14485546823 7289944782 12856120154 ; PAY_BOUGHT | mixed | 20 | 9.95% | High-priority | 3.85 | 6.23% | 10271914772 13765711070 5017080772 11007177022 10046997610 ; BUG_FEATURE | negative | 13 | 6.47% | High-priority | 3.69 | 3.14% | 4473894054 12834475294 13773135515 10846173748 2066570829 ; STAT_WANT | request / unmet need | 11 | 5.47% | High-priority | 4.82 | 2.32% | 5017080772 2494551620 4243211816 9022446679 6963815688 ; PAY_LIFETIME | mixed | 8 | 3.98% | Very strong | 3.75 | 2.09% | 13765711070 10046997610 14450688542 12762709180 13773135515 ; BUG_CRASH | negative | 7 | 3.48% | Very strong | 3.43 | 2.00% | 2690805456 6892880195 4500654010 2531595532 4058982636 ; STAT_REWARD | positive | 7 | 3.48% | Very strong | 4.71 | 1.51% | 7629813817 10046997610 12985975127 7276661470 6881194403 ; DES_ICON_LIKE | positive | 6 | 2.99% | Meaningful | 4.50 | 1.56% | 8558891345 2066570829 2690805456 13825820015 3579956969 ; BUG_DISPLAY | negative | 6 | 2.99% | Meaningful | 3.83 | 0.88% | 8558891345 3541536472 6963815688 13995708224 13018922212 ; DES_REDESIGN | negative | 6 | 2.99% | Meaningful | 3.00 | 1.80% | 14011015782 3891283636 6648286963 8755934338 3695958626 ; LOC_UNTRANS | negative | 6 | 2.99% | Meaningful | 3.50 | 0.74% | 14285773927 5805783345 14333062340 6558735321 14154732178 ; OUT_DISCIPLINE | positive | 6 | 2.99% | Meaningful | 5.00 | 3.69% | 7299698208 12482732225 7348909046 14298148857 11350227190 ; META_RECOMMEND | positive | 5 | 2.49% | Meaningful | 5.00 | 1.40% | 10355729403 7325857963 13826297976 13226679450 13314977054 ; AD_NEG | negative | 5 | 2.49% | Meaningful | 1.00 | 4.29% | 14011015782 13047520315 12710001321 13035587953 12862015543 ; PAY_CAP5 | negative | 4 | 1.99% | Meaningful | 4.50 | 4.30% | 4509008512 2066570829 2690805456 3627223763 ; REQ_OTHER | request / unmet need | 4 | 1.99% | Meaningful | 5.00 | 1.91% | 5017080772 7299698208 4552808313 3378812972 ; BUG_UPDATE | negative | 4 | 1.99% | Meaningful | 2.50 | 2.54% | 6479607174 12053916573 3695958626 5682715669 ; PLAT_WIDGET_BUG | negative | 4 | 1.99% | Meaningful | 4.00 | 2.20% | 4473894054 6648286963 6479607174 12053916573 ; PAY_BILLING | negative | 4 | 1.99% | Meaningful | 3.00 | 1.26% | 14450688542 6972248547 13974690850 6075199478
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-167 — Taiwan: LOC_WANT 46 (22.89%, high-priority) is Traditional Chinese — from 2018 ('add Traditional Chinese and it'd be one of my favourites') to 2026 ('can't set Traditional Chinese at all', 1★; may delete because the 'Traditional' setting still shows mostly Simplified); BUG_FEATURE 13 (6.47%) and BUG_CRASH 7 (3.48%) proportionally higher than cn (3.13% / 2.03%) — small but consistent ('can't uncheck'); PAY_BOUGHT 20 (9.95%) — Taiwanese reviewers pay at a higher segment rate than cn (6.21%)

- **Where:** §7.5 bullets
- **This app does:** Simplified-only or partial Traditional
- **User reaction:** blocked-conversion
- **Magnitude:** LOC_WANT 46 (22.89%); PAY_BOUGHT 9.95% vs cn 6.21%
- **Direction for us:** do · **Report confidence:** high-priority (tw) · **Generalisable:** generalisable
- **Review IDs:** `3018949395`, `13817137072`, `14285773927`, `10271914772`
- **Canonical:** C027 Localise early — it unlocks revenue

### R52-168 — Hong Kong hk n=119 (0.58%), mean 4.23, public 2,093 @ 4.65, search rank 2 — theme table (verbatim)

- **Where:** §7.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n | % of 119 (hk) | Band (hk denominator) | Mean ★ | Global % | Representative IDs ; META_LOWINFO | context | 25 | 21.01% | High-priority | 4.96 | 23.07% | 10235709289 11689888338 12211687849 12376667404 5873371244 ; DES_CLEAN | positive | 12 | 10.08% | High-priority | 4.83 | 8.32% | 14033431396 14156858693 12360777180 11546247626 12738868385 ; DES_CUTE | positive | 8 | 6.72% | High-priority | 5.00 | 6.94% | 11633988752 3161544099 3050385996 12979312518 12331762691 ; LOC_WANT | request / unmet need | 8 | 6.72% | High-priority | 3.00 | 0.48% | 3872404355 6756588974 6001731569 7092955940 5982924091 ; LOC_UNTRANS | negative | 8 | 6.72% | High-priority | 2.62 | 0.74% | 14033431396 7947255952 7092955940 7055771918 6974143936 ; USER_LONGTERM | context | 6 | 5.04% | High-priority | 4.83 | 3.42% | 11967942541 12772104316 14077075394 8091004483 13634286926 ; DES_PRETTY | positive | 5 | 4.20% | Very strong | 4.80 | 2.08% | 3872404355 13790092999 11546247626 12769478787 11752121505 ; DES_THEME | mixed | 5 | 4.20% | Very strong | 4.00 | 1.66% | 8488726630 6756588974 13671070360 6974143936 12732871528 ; PAY_WALL | negative | 4 | 3.36% | Very strong | 3.75 | 3.47% | 8488726630 12906917498 4101490540 6726128074 ; AD_NEG | negative | 4 | 3.36% | Very strong | 2.25 | 4.29% | 12979312518 6292937353 13002163522 6726128074 ; DES_REDESIGN | negative | 4 | 3.36% | Very strong | 1.75 | 1.80% | 7526936412 13515619630 11717125502 11136295590 ; CORE_TODO | mixed | 4 | 3.36% | Very strong | 4.50 | 1.49% | 11967942541 11895863317 9908939586 12841732927 ; REM_GOOD | positive | 3 | 2.52% | Meaningful | 5.00 | 0.90% | 11628000497 13966587299 3050385996 ; META_RECOMMEND | positive | 3 | 2.52% | Meaningful | 5.00 | 1.40% | 13563064460 11546247626 3050385996 ; CORE_RETRO | request / unmet need | 3 | 2.52% | Meaningful | 4.00 | 1.06% | 7455979010 3161544099 4604504507 ; CORE_FREQ | request / unmet need | 3 | 2.52% | Meaningful | 4.33 | 1.45% | 3872404355 11175806368 7226918619 ; CORE_CHECK | positive | 3 | 2.52% | Meaningful | 5.00 | 1.05% | 6658478334 13856879417 11091137544 ; PLAT_WIDGET_WANT | request / unmet need | 3 | 2.52% | Meaningful | 4.67 | 1.16% | 6756588974 13671070360 6658478334 ; DES_ICON_LIKE | positive | 3 | 2.52% | Meaningful | 4.67 | 1.56% | 7947255952 6658478334 11245853409 ; DES_DARK | request / unmet need | 3 | 2.52% | Meaningful | 4.67 | 0.34% | 11895863317 7518960921 12732871528 ; BUG_UPDATE | negative | 3 | 2.52% | Meaningful | 2.33 | 2.54% | 7526936412 13515619630 7518960921 ; DEV_TRUST | positive | 3 | 2.52% | Meaningful | 5.00 | 1.03% | 7518960921 12974732222 13960487608
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-169 — Hong Kong: LOC_WANT 8 (6.72%) and LOC_UNTRANS 8 (6.72%), both high-priority at hk denominator — reviewers split between English and Traditional Chinese needs; redesign 4 (3.36%) and paywall 4 (3.36%) very strong but rest on 4 reviews — direction, not rate (the new year statistics can't be shared or screenshotted); the best search rank in the snapshot (2) coincides with the lowest public average among eligible storefronts (4.65)

- **Where:** §7.6 bullets
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** LOC_WANT 8 (6.72%); LOC_UNTRANS 8 (6.72%); rank 2 at 4.65
- **Direction for us:** research · **Report confidence:** high-priority (hk) · **Generalisable:** app-specific
- **Review IDs:** `13515619630`
- **Canonical:** C027 Localise early — it unlocks revenue

### R52-170 — Canada ca n=61 — theme table (verbatim): LOC_UNTRANS 14 (22.95%), DES_CUTE 9 (14.75%), PAY_PRICE_OK 6 (9.84%), PAY_CAP5 5 (8.20%), PLAT_WIDGET_BUG 4 (6.56%); not ranked in the snapshot

- **Where:** §7.7 Canada table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n | % of 61 (ca) | Band (ca denominator) | Mean ★ | Global % | Representative IDs ; LOC_UNTRANS | negative | 14 | 22.95% | High-priority | 3.86 | 0.74% | 3300136517 12225883072 3703008157 9262377975 7343996687 ; DES_CUTE | positive | 9 | 14.75% | High-priority | 4.89 | 6.94% | 7002665650 3300136517 13143217371 12378214371 5429674260 ; PAY_PRICE_OK | positive | 6 | 9.84% | High-priority | 4.67 | 1.24% | 3300136517 7343996687 11199357550 9053480415 5429674260 ; META_LOWINFO | context | 6 | 9.84% | High-priority | 5.00 | 23.07% | 13915595886 11346818771 8256718267 14437796140 12137593812 ; PAY_CAP5 | negative | 5 | 8.20% | High-priority | 3.80 | 4.30% | 3300136517 6753080145 12378214371 7334134149 10733224930 ; PAY_BOUGHT | mixed | 4 | 6.56% | High-priority | 3.50 | 6.23% | 9053480415 4870605504 6487551914 8589780596 ; PLAT_WIDGET_BUG | negative | 4 | 6.56% | High-priority | 4.00 | 2.20% | 6930990891 6979051928 6487551914 11630774278 ; DES_CLEAN | positive | 3 | 4.92% | Very strong | 4.67 | 8.32% | 7343996687 1785796252 7191321283 ; USER_SWITCH | context | 3 | 4.92% | Very strong | 4.67 | 1.72% | 7002665650 7343996687 1785796252 ; PAY_BILLING | negative | 3 | 4.92% | Very strong | 5.00 | 1.26% | 2076872380 3114197177 2527018191 ; DES_PRETTY | positive | 3 | 4.92% | Very strong | 4.67 | 2.08% | 12225883072 4546338445 9053480415 ; DES_DENSE | negative | 3 | 4.92% | Very strong | 3.67 | 2.07% | 6753080145 6577712550 10733224930 ; STAT_REWARD | positive | 3 | 4.92% | Very strong | 4.67 | 1.51% | 7002665650 9262377975 6975254189 ; DES_ICON_LIKE | positive | 2 | 3.28% | Very strong | 5.00 | 1.56% | 1785796252 9438367139 ; LOC_WANT | request / unmet need | 2 | 3.28% | Very strong | 3.50 | 0.48% | 3300136517 7435068303 ; PAY_WALL | negative | 2 | 3.28% | Very strong | 3.00 | 3.47% | 6853528829 8873192195 ; STAT_WANT | request / unmet need | 2 | 3.28% | Very strong | 4.00 | 2.32% | 8873192195 6902477770 ; OUT_STUDY | positive | 2 | 3.28% | Very strong | 5.00 | 0.56% | 7002665650 12363705664 ; CORE_CHECK | positive | 2 | 3.28% | Very strong | 5.00 | 1.05% | 7258930880 7171446159 ; CORE_ROUTINE | mixed | 2 | 3.28% | Very strong | 5.00 | 0.39% | 7621851935 14108833148 ; FOCUS | mixed | 2 | 3.28% | Very strong | 5.00 | 1.89% | 7621851935 12316541059 ; REM_GOOD | positive | 2 | 3.28% | Very strong | 5.00 | 0.90% | 7621851935 12316541059
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-171 — Australia au n=53 — theme table (verbatim): LOC_UNTRANS 11 (20.75%), DES_CUTE 7 (13.21%), PLAT_WIDGET_BUG 4 (7.55%), JRNL_WANT 4 (7.55%); written mean 4.04 is the lowest of the six eligible storefronts against a 4.71 public average; both ca and au have zero AD_NEG and zero META_UNLOCK; at n≈50–60 every theme with 3+ reviews clears 'very strong' — read for direction

- **Where:** §7.7 Australia table (verbatim) and bullets
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n | % of 53 (au) | Band (au denominator) | Mean ★ | Global % | Representative IDs ; LOC_UNTRANS | negative | 11 | 20.75% | High-priority | 2.27 | 0.74% | 7793191797 5218989452 6361046633 6762542207 7760682811 ; META_LOWINFO | context | 8 | 15.09% | High-priority | 4.75 | 23.07% | 12368848041 11967788665 13881575260 12004796873 11108723175 ; DES_CUTE | positive | 7 | 13.21% | High-priority | 4.86 | 6.94% | 5852956766 13503066338 6964729295 6931128777 4509194068 ; DES_CLEAN | positive | 6 | 11.32% | High-priority | 4.67 | 8.32% | 4887783468 7782517304 11898914200 4509194068 14026871340 ; PAY_PRICE_OK | positive | 4 | 7.55% | High-priority | 4.50 | 1.24% | 4887783468 3865835016 14390984842 4509194068 ; JRNL_WANT | request / unmet need | 4 | 7.55% | High-priority | 4.75 | 3.24% | 5852956766 6595730620 7782517304 6891892068 ; PLAT_WIDGET_BUG | negative | 4 | 7.55% | High-priority | 4.25 | 2.20% | 6546262074 8120293042 8275970029 8216821647 ; DES_PRETTY | positive | 4 | 7.55% | High-priority | 4.50 | 2.08% | 7793191797 14390984842 8848347174 6564683026 ; BUG_FEATURE | negative | 3 | 5.66% | High-priority | 2.33 | 3.14% | 8216821647 5882049521 9045674978 ; STAT_REWARD | positive | 3 | 5.66% | High-priority | 4.67 | 1.51% | 13503066338 8120293042 8784954307 ; PAY_LIFETIME | mixed | 2 | 3.77% | Very strong | 4.00 | 2.09% | 4887783468 3865835016 ; PAY_SUB_NEG | negative | 2 | 3.77% | Very strong | 4.00 | 0.47% | 4887783468 3865835016 ; META_RECOMMEND | positive | 2 | 3.77% | Very strong | 4.00 | 1.40% | 4887783468 3865835016 ; REM_WANT | request / unmet need | 2 | 3.77% | Very strong | 4.00 | 2.85% | 8216821647 4247991714 ; DES_ICON_WANT | request / unmet need | 2 | 3.77% | Very strong | 3.50 | 2.72% | 5834072468 6664112882 ; USER_SWITCH | context | 2 | 3.77% | Very strong | 5.00 | 1.72% | 5852956766 7744123944 ; META_EDIT | context | 2 | 3.77% | Very strong | 5.00 | 0.13% | 7782517304 8120293042 ; LOC_WANT | request / unmet need | 2 | 3.77% | Very strong | 2.00 | 0.48% | 7793191797 9045674978 ; CORE_MULTI | request / unmet need | 2 | 3.77% | Very strong | 4.00 | 1.15% | 7857073883 8784954307 ; DES_COLOR | mixed | 2 | 3.77% | Very strong | 5.00 | 0.80% | 8120293042 11891512764 ; PAY_CAP5 | negative | 1 | 1.89% | Meaningful | 5.00 | 4.30% | 3865835016 ; DES_FONT | request / unmet need | 1 | 1.89% | Meaningful | 3.00 | 0.42% | 4887783468
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-173 — Localisation and language: scripts Chinese 19,858 (96.24%), Latin (mostly English) 731 (3.54%) — 294 of those from the cn storefront (English-speaking users with a mainland Apple ID), no letters 40, Japanese 5; LOC_UNTRANS by year 17 (2018), 26, 38, 28, 17, 4, 8, 5, 10 (2026) — peaked 2020 and not fixed, persisting in 2025–2026 (de; dk 'some pages and headings have to be translated from Chinese'; us); mixed-language UI reported even by Chinese-reading users on English systems, who ask for an in-app language setting independent of iOS

- **Where:** §7.9
- **This app does:** partial English, no in-app language setting
- **User reaction:** complaint
- **Magnitude:** LOC_UNTRANS 17/26/38/28/17/4/8/5/10 by year 2018→2026
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `13629767047`, `13971540834`, `14514304514`, `11414179245`
- **Canonical:** C027 Localise early — it unlocks revenue; C255 An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language

## Dated events and trends

### R52-012 — The 2025 ad rollout is the largest negative event in nine years: AD_NEG 885 (4.29%, very strong, mean 2.46; 1/2/3/4/5 = 383/103/139/128/132; 2018-12-27 → 2026-09-04, cn×864), 575 of 885 (65.0%) written in 2025 alone; Jan–May 2025 991 reviews, 6 AD_NEG (0.6%), mean 4.59 → Jun–Nov 2025 1,562 reviews, 546 AD_NEG (35.0%), mean 3.70 → 2026 (to 7 Sep) 1,341, 78 (5.8%), mean 4.42; July 2025 is the lowest-rated month in the corpus (362 reviews, mean 3.35; 173 AD_NEG), June 2025 next (3.60); before 2025 the lowest month was Dec 2019 (3.61); monthly means recovered to 4.45–4.61 Jan–May 2026 — whether mechanics were softened or complainants left, the corpus cannot distinguish

- **Where:** §Part 0 executive summary; §0.9 #1
- **This app does:** aggressive ads from June 2025
- **User reaction:** 1★-burst
- **Magnitude:** 885 (4.29%, 2.46); Jun–Nov 2025 546/1,562 = 35.0% at 3.70; Jul 2025 3.35
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `12831040911`, `13362003467`, `12795677855`, `12743825635`
- **Canonical:** C082 Ads in the free tier; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver; C269 If the free tier carries ads, never use hijacking ad mechanics — no auto-jump into other apps, no shake or tilt triggers, a close control that closes, and no ad on the check-in

### R52-013 — Ad rollout window table (verbatim)

- **Where:** §0.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Window | Reviews | AD_NEG | Share of window | Mean ★ of window ; Jan–May 2025 | 991 | 6 | 0.6% | 4.59 ; Jun–Nov 2025 | 1,562 | 546 | 35.0% | 3.70 ; 2026 (to 7 Sep) | 1,341 | 78 | 5.8% | 4.42
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-018 — Ads were not new in 2025: splash ads for Ctrip (2019) and Pinduoduo (2021) produced a smaller wave — AD_NEG 99 reviews (3.4%) in 2020, 83 (2.8%) in 2021, then 0.2–0.7% in 2022–2024; a 2022 reviewer even tells others to downgrade to v5.05 to escape ads

- **Where:** §0.1 last paragraph
- **This app does:** splash ads 2019–2021
- **User reaction:** complaint
- **Magnitude:** 2020 99 (3.4%); 2021 83 (2.8%); 2022–24 0.2–0.7%
- **Direction for us:** dont · **Report confidence:** very strong (parent theme) · **Generalisable:** app-specific
- **Review IDs:** `4607325416`, `7038818912`, `8329654441`
- **Canonical:** C082 Ads in the free tier; C269 If the free tier carries ads, never use hijacking ad mechanics — no auto-jump into other apps, no shake or tilt triggers, a close control that closes, and no ad on the check-in

### R52-030 — Reliability fails in waves, and each wave is a release: reliability union 2,608 (12.64%, high-priority, mean 3.49); BUG_CRASH 412 (2.00%, meaningful, mean 3.22); 175 of 412 crash reviews (42.5%) fall in six of 110 months, roughly every 12–18 months — Jul 2018 25 (crash on tapping purchase, fixed within a day); Oct 2019 32 (v2.41 on iOS 13 crash after Face ID / Touch ID, month 3.73); May 2023 26 (v7.14 launch crash for days, reinstall wiped records, 3.76); Sep 2024 44 (post-update crash on launch or sync, restoring data required buying membership, 3.89); Apr 2025 24 (post-update launch crash including focus space on iOS 14.8); Sep 2025 24 (20+ days of launch crashes on iOS 14.x despite a stated iOS 14 floor); decision: a release gate in front of old-iOS devices and data migrations — at least three waves destroyed data

- **Where:** §0.5 table (verbatim); §0.9 #3
- **This app does:** recurring post-release crash waves
- **User reaction:** 1★-burst
- **Magnitude:** Month | BUG_CRASH | What reviewers describe | Evidence ; Jul 2018 | 25 | Crash on tapping the purchase button; fixed within a day | 2830538942 2834021219 2838663501 ; Oct 2019 | 32 | v2.41 on iOS 13: crash right after Face ID / Touch ID unlock (month mean 3.73) | 4942566618 4936869831 4925667389 ; May 2023 | 26 | v7.14: launch crash for days; reinstall wiped records (month mean 3.76) | 9919428713 9980189801 9952880388 ; Sep 2024 | 44 | Post-update crash on launch or sync; restoring data required buying membership (month mean 3.89) | 11764810805 11779820068 11776198730 ; Apr 2025 | 24 | Post-update launch crash, including the focus space on iOS 14.8 | 12516883329 12494993872 12522893732 ; Sep 2025 | 24 | 20+ days of launch crashes on iOS 14.x devices despite a stated iOS 14 floor | 13185604830 13180896126 13148041255
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `2830538942`, `4942566618`, `9919428713`, `11764810805`, `12516883329`, `13185604830`
- **Canonical:** C031 Crashes / launch failures; C156 Content and event releases need a crash gate across device generations; C175 Updates must not break function or wipe progress

### R52-031 — A distinct failure on 31 Jul 2023 produced 12 reviews in one day, all saying the update could not be downloaded or reinstalled

- **Where:** §0.5 31 Jul 2023
- **This app does:** update undownloadable for a day
- **User reaction:** 1★-burst
- **Magnitude:** 12 reviews in one day
- **Direction for us:** must-never-break · **Report confidence:** report gives none · **Generalisable:** app-specific
- **Review IDs:** `10203240496`, `10204269642`, `10205174382`
- **Canonical:** C175 Updates must not break function or wipe progress

### R52-034 — Redesign complaints arrive in bursts that match releases, and each is about losing speed or calm, not a feature: Oct 2020 26 (iOS 14 widgets: tap-to-check replaced by a progress ring that opens the app); Jun 2021 29 (a check-in opens a Success / Pending / Fail sheet instead of a single tap — 'a check-in used to be one tap… now it's at least two'; 'As a product manager myself… The whole layout is very confusing'); Sep–Dec 2024 31 (home layout compressed; widgets and sorting changed); Feb–Apr 2026 20 (AI-generated note titles that can't be switched off); Aug 2026 12 (solid-red pomodoro/focus page clashing with the app); decision: ship new UI as opt-in and never remove one-tap check-in

- **Where:** §0.6 redesign table (verbatim); §0.9 #4
- **This app does:** repeated redesigns
- **User reaction:** 1★-burst
- **Magnitude:** Month | DES_REDESIGN | The change reviewers object to | Evidence ; Oct 2020 | 26 | iOS 14 widgets: tap-to-check replaced by a progress ring that opens the app | 6487343139 6489384630 6514321794 ; Jun 2021 | 29 | A check-in now opens a *Success / Pending / Fail* sheet instead of a single tap | 7515737588 7517368475 7522832396 7519571134 ; Sep–Dec 2024 | 31 | Home layout compressed; widgets and sorting changed | 12024716798 12065142171 12062367782 ; Feb–Apr 2026 | 20 | Several changes, most visibly AI-generated note titles that can't be switched off | 13930545782 13965180848 14508025525 ; Aug 2026 | 12 | Solid-red pomodoro/focus page that clashes with the rest of the app | 14381653023 14403076784 14405943569 14421731886
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `6487343139`, `7515737588`, `7519571134`, `12024716798`, `13930545782`, `14381653023`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R52-046 — A nine-year price history reconstructed from dated reviews (verbatim): Oct 2017 ¥6 one-time 'permanent' unlock (adds backup) → Nov 2017–2018 ¥12 one-time pro, separate paid themes ~¥6 → 2018–2019 ¥12 and ¥18, two tiers 小太阳 / 大太阳 with no upgrade credit → Nov 2019 price rise 小太阳 ¥8→¥12, 大太阳 ¥12→¥18 → Jun–Aug 2020 switch to subscription ('月卡') alongside or instead of lifetime, buyers told their lifetime is now annual → Jun 2021 lifetime ¥88 → Jul 2022 ¥38/3 months, ¥58/8 months, ¥88 lifetime → Apr 2023 gb 'lifetime' billed as £12.99/month → Oct 2024 '¥30 when I was a student, ¥80 now' → Jun–Aug 2025 price seen as unstable ¥18/¥28/¥88, a ¥12 buyer finds lifetime at ¥98 → Oct 2025 ¥8 lifetime ad removal → Dec 2025 year statistics moved behind VIP → Feb 2026 iOS lifetime ¥88 vs Android ¥48 → 2026 new-install onboarding requires picking 5 habits and a 3-day free trial; text census inside PAY_*: '永久 / 终身 / 买断' (lifetime) 419 reviews rising from 2020, '大太阳 / 小太阳 / 高级会员' 241 (mostly 2018–2020), '¥88' 38 (2021–2026)

- **Where:** §2.2 table (verbatim)
- **This app does:** price ladder ¥6 one-time → ¥88 lifetime + subscriptions
- **User reaction:** mixed
- **Magnitude:** When (review date) | Reported price / model | Evidence ; Oct 2017 | ¥6 one-time "permanent" unlock (adds backup) | 1819686355 ; Nov 2017 – 2018 | ¥12 "高级/专业版" one-time; separate paid themes (~¥6 each) | 1953868037 2077341563 2435239101 ; 2018 – 2019 | ¥12 and ¥18 purchases both reported ("高级帐户" ¥18 in Jul 2018); two tiers 小太阳 / 大太阳 with no upgrade credit between them. Reviewers' figures for each tier conflict across dates | 2830538942 4821574128 8270198642 ; Nov 2019 | Price rise: 小太阳 ¥8→¥12, 大太阳 ¥12→¥18 | 5099014000 ; Jun–Aug 2020 | Switch to subscription ("月卡") alongside or instead of lifetime; buyers told their lifetime is now annual | 6119258263 6268143177 6014282876 ; Jun 2021 | Lifetime ¥88 | 7519301296 ; Jul 2022 | ¥38 / 3 months, ¥58 / 8 months, ¥88 lifetime | 8917356810 ; Apr 2023 | gb storefront: "lifetime" purchase billed as £12.99/month | 9809502780 ; Oct 2024 | "¥30 when I was a student, ¥80 now" | 11873598362 ; Jun–Aug 2025 | Price seen as unstable: ¥18 / ¥28 / ¥88; a ¥12 buyer finds lifetime at ¥98 | 12834474035 13082395093 ; Oct 2025 → | ¥8 lifetime ad removal | 13284916834 13362003467 13351689320 14100445684 ; Dec 2025 | Year statistics moved behind VIP | 13501470470 13559154241 13557404547 ; Feb 2026 | iOS lifetime ¥88 vs Android ¥48 | 13791604447 ; 2026 | New-install onboarding requires picking 5 habits and a 3-day free trial | 14389575364 13986964200 14206066896
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `1819686355`, `5099014000`, `6119258263`, `7519301296`, `8917356810`, `9809502780`, `11873598362`, `12834474035`, `13284916834`, `13501470470`, `13791604447`, `14389575364`
- **Canonical:** — (nuance register)

### R52-048 — Jun–Aug 2020 switch to subscription ('月卡') alongside or instead of lifetime — buyers told their lifetime is now annual

- **Where:** §2.2 Jun–Aug 2020 row; §2.4
- **This app does:** lifetime re-scoped to annual for earlier buyers
- **User reaction:** 1★-burst
- **Magnitude:** report gives none (dated reviews)
- **Direction for us:** product-rule · **Report confidence:** weak (PAY_REGRESS parent) · **Generalisable:** generalisable
- **Review IDs:** `6119258263`, `6268143177`, `6014282876`
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

### R52-065 — Free habit quota N2: PAY_CAP5 888 (4.30%, very strong, mean 2.96, 2017-09 → 2026-08) — the first paywall any user meets, declining since 2020 and nearly gone in 2026 once the quota started growing with use

- **Where:** §3.3 N2
- **This app does:** free quota growing with use from 2025
- **User reaction:** complaint
- **Magnitude:** 888 (4.30%, 2.96)
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `5560993303`, `8759088131`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R52-114 — The daily quote card was a launch-era hook; its bugs (blank cards, can't claim, duplicate images) were 93.3% concentrated in 2018–2021, and complaints stopped once the card became manual to claim ('now I have to claim each day's card by hand?', 2021)

- **Where:** §4.2 daily card
- **This app does:** daily card, later manual claim
- **User reaction:** mixed
- **Magnitude:** CARD_BUG 193, 93.3% in 2018–2021
- **Direction for us:** none · **Report confidence:** emerging · **Generalisable:** app-specific
- **Review IDs:** `6816187446`
- **Canonical:** — (nuance register)

### R52-143 — Paying reviewers by year (verbatim): 2017 30 (1.1%, 4.43); 2018 233 (11.7%, 3.94); 2019 174 (13.0%, 4.39); 2020 274 (9.5%, 4.18); 2021 171 (5.7%, 4.05); 2022 67 (4.2%, 4.19); 2023 54 (4.9%, 3.74); 2024 94 (4.8%, 4.01); 2025 88 (3.2%, 4.09); 2026 101 (7.5%, 4.05) — 2018–2019 (cheap one-time tiers) is when the largest share say they paid; the 2026 rebound (7.5%) coincides with the ¥8 ad-removal SKU and the onboarding trial (correlation in text, not sales)

- **Where:** §6.1 year table (verbatim)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Year | Paying reviewers | Share of that year's reviews | Mean ★ ; 2017 | 30 | 1.1% | 4.43 ; 2018 | 233 | 11.7% | 3.94 ; 2019 | 174 | 13.0% | 4.39 ; 2020 | 274 | 9.5% | 4.18 ; 2021 | 171 | 5.7% | 4.05 ; 2022 | 67 | 4.2% | 4.19 ; 2023 | 54 | 4.9% | 3.74 ; 2024 | 94 | 4.8% | 4.01 ; 2025 | 88 | 3.2% | 4.09 ; 2026 | 101 | 7.5% | 4.05
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-176 — Volume and rating by year (verbatim): 2017 2,667 at 4.61 (1★ 1.4%); 2018 1,989 at 4.15 (9.2%); 2019 1,338 at 4.10 (11.9%); 2020 2,876 at 4.07 (10.9%); 2021 3,004 at 4.23 (7.4%); 2022 1,603 at 4.31 (8.1%); 2023 1,094 at 4.17 (10.9%); 2024 1,978 at 4.39 (8.9%); 2025 2,744 at 4.06 (15.2%); 2026 (to 7 Sep) 1,341 at 4.42 (8.7%)

- **Where:** §8.2 year table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Year | Reviews | % of corpus | Mean ★ | 1/2/3/4/5 | 1★ share ; 2017 | 2,667 | 12.93% | 4.61 | 38/20/146/545/1918 | 1.4% ; 2018 | 1,989 | 9.64% | 4.15 | 182/64/180/401/1162 | 9.2% ; 2019 | 1,338 | 6.48% | 4.10 | 159/45/115/208/811 | 11.9% ; 2020 | 2,876 | 13.94% | 4.07 | 313/107/273/547/1636 | 10.9% ; 2021 | 3,004 | 14.56% | 4.23 | 223/74/279/633/1795 | 7.4% ; 2022 | 1,603 | 7.77% | 4.31 | 130/50/112/205/1106 | 8.1% ; 2023 | 1,094 | 5.30% | 4.17 | 119/37/82/161/695 | 10.9% ; 2024 | 1,978 | 9.59% | 4.39 | 176/43/91/191/1477 | 8.9% ; 2025 | 2,744 | 13.30% | 4.06 | 417/101/169/264/1793 | 15.2% ; 2026 (to 7 Sep) | 1,341 | 6.50% | 4.42 | 116/29/51/123/1022 | 8.7%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-177 — Eras (verbatim): E1 2017–2019 5,994 at 4.34 — launch, review-to-unlock, ¥6–¥18 one-time tiers, card, billing and iPad asks; E2 2020–2021 5,880 at 4.15 — subscription switch, splash ads, iOS 14 widgets, June 2021 check-in redesign; E3 2022–2023 2,697 at 4.25 — lifetime ¥88, quiet period, May 2023 crash, July 2023 update failure; E4 2024 1,978 at 4.39 — to-dos and focus added, long-tenure users return, Sep 2024 crash + redesign; E5 2025 2,744 at 4.06 — ad wave, Apr and Sep crash waves, year statistics to VIP; E6 2026 1,341 at 4.42 — recovery, AI titles, focus-page redesign, onboarding trial

- **Where:** §8.2 era table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Era | Years | Reviews | % | Mean ★ | Character ; E1 | 2017–2019 | 5,994 | 29.05% | 4.34 | Launch; review-to-unlock; ¥6–¥18 one-time tiers; card, billing and iPad asks ; E2 | 2020–2021 | 5,880 | 28.50% | 4.15 | Subscription switch; splash ads; iOS 14 widgets; June 2021 check-in redesign ; E3 | 2022–2023 | 2,697 | 13.07% | 4.25 | Lifetime ¥88; quiet period; May 2023 crash; July 2023 update failure ; E4 | 2024 | 1,978 | 9.59% | 4.39 | To-dos and focus added; long-tenure users return; Sep 2024 crash + redesign ; E5 | 2025 | 2,744 | 13.30% | 4.06 | Ad wave; Apr and Sep crash waves; year statistics to VIP ; E6 | 2026 (to 7 Sep) | 1,341 | 6.50% | 4.42 | Recovery; AI titles; focus-page redesign; onboarding trial
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-178 — Theme share by year, % of that year's reviews (verbatim)

- **Where:** §8.3 share table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 | 2026 | Reading ; META_UNLOCK | 16.0 | 1.2 | 0.5 | 0.0 | 0.0 | 0.0 | 0.0 | 0.1 | 0.0 | 0.0 | ; META_PREUSE | 20.3 | 0.6 | 0.1 | 0.5 | 1.7 | 2.1 | 2.7 | 0.9 | 0.5 | 0.1 | ; META_LOWINFO | 48.6 | 8.6 | 7.0 | 11.4 | 16.5 | 33.8 | 33.5 | 27.0 | 22.6 | 23.5 | ; PAY_CAP5 | 0.9 | 8.2 | 6.1 | 7.1 | 5.3 | 4.4 | 4.9 | 3.3 | 2.0 | 0.6 | ; PAY_WALL | 1.1 | 7.1 | 6.0 | 4.8 | 2.8 | 3.7 | 4.1 | 2.4 | 2.1 | 2.5 | ; PAY_BILLING | 0.2 | 5.6 | 4.1 | 1.8 | 0.5 | 0.2 | 0.5 | 0.2 | 0.1 | 0.4 | ; PAY_BOUGHT | 1.1 | 11.7 | 13.0 | 9.5 | 5.7 | 4.2 | 4.9 | 4.8 | 3.2 | 7.5 | ; PAY_LIFETIME | 0.0 | 0.5 | 1.1 | 2.3 | 2.5 | 2.7 | 3.3 | 3.4 | 2.8 | 3.2 | ; PAY_PRICE_HIGH | 0.4 | 3.7 | 1.6 | 1.0 | 1.3 | 1.3 | 2.7 | 0.8 | 0.4 | 0.4 | ; PAY_SUB_NEG | 0.0 | 0.2 | 0.7 | 1.6 | 1.0 | 0.0 | 0.1 | 0.2 | 0.0 | 0.4 | ; PAY_RESTORE | 0.0 | 1.1 | 1.6 | 0.7 | 1.3 | 0.9 | 1.0 | 1.3 | 0.9 | 0.9 | ; PAY_REGRESS | 0.0 | 0.1 | 0.3 | 0.3 | 0.7 | 0.2 | 0.7 | 0.4 | 0.4 | 0.6 | ; AD_NEG | 0.0 | 0.1 | 1.8 | 3.4 | 2.8 | 0.6 | 0.2 | 0.7 | 21.0 | 5.8 | ; AD_NONE_PRAISE | 0.4 | 0.8 | 0.7 | 0.5 | 0.5 | 0.7 | 0.7 | 1.7 | 1.3 | 1.4 | ; DES_CUTE | 18.5 | 11.0 | 7.0 | 4.9 | 4.1 | 6.0 | 4.4 | 4.0 | 3.6 | 2.9 | ; DES_CLEAN | 13.6 | 11.1 | 6.1 | 4.2 | 4.5 | 7.2 | 6.9 | 11.1 | 9.0 | 10.3 | ; DES_REDESIGN | 0.0 | 0.0 | 0.7 | 2.0 | 3.2 | 2.1 | 1.0 | 3.5 | 1.8 | 3.5 | ; DES_DENSE | 1.4 | 3.9 | 2.5 | 1.4 | 2.6 | 2.6 | 1.6 | 1.5 | 1.6 | 2.0 | ; BUG_CRASH | 0.4 | 3.9 | 5.2 | 0.9 | 0.6 | 1.2 | 2.5 | 3.6 | 2.5 | 1.7 | ; BUG_UPDATE | 0.3 | 2.7 | 3.6 | 3.7 | 2.8 | 1.7 | 2.9 | 3.8 | 2.6 | 1.3 | ; BUG_FEATURE | 1.5 | 8.5 | 3.1 | 4.5 | 3.0 | 1.9 | 1.3 | 2.1 | 2.2 | 2.5 | ; PLAT_WIDGET_BUG | 0.1 | 1.8 | 0.7 | 5.1 | 4.6 | 1.9 | 1.5 | 1.8 | 0.7 | 1.5 | ; DATA_LOSS | 0.3 | 1.8 | 1.4 | 1.4 | 1.2 | 0.4 | 1.1 | 1.4 | 0.9 | 1.3 | ; PLAT_IPAD | 0.1 | 3.7 | 7.0 | 2.6 | 1.7 | 1.2 | 2.0 | 1.1 | 0.7 | 0.2 | ; PLAT_WATCH | 0.1 | 0.7 | 2.3 | 2.6 | 1.3 | 1.2 | 1.7 | 1.3 | 0.8 | 0.7 | ; CARD_BUG | 0.3 | 3.9 | 1.6 | 1.4 | 1.4 | 0.2 | 0.0 | 0.0 | 0.0 | 0.1 | ; JRNL_WANT | 0.7 | 5.5 | 5.1 | 5.0 | 5.3 | 2.1 | 2.0 | 1.4 | 2.0 | 2.2 | ; REM_WANT | 6.1 | 5.8 | 3.6 | 2.8 | 3.7 | 1.3 | 1.2 | 0.8 | 0.4 | 0.5 | ; STAT_WANT | 0.3 | 4.2 | 3.8 | 3.1 | 4.2 | 1.6 | 1.5 | 1.3 | 1.2 | 1.6 | ; STAT_REWARD | 0.1 | 0.7 | 0.4 | 0.8 | 3.1 | 1.9 | 2.2 | 1.9 | 2.2 | 1.9 | ; FOCUS | 0.2 | 1.7 | 1.1 | 2.4 | 2.5 | 1.1 | 1.4 | 1.2 | 2.3 | 5.5 | ; CORE_TODO | 0.3 | 0.9 | 1.0 | 1.0 | 1.6 | 0.8 | 1.9 | 3.0 | 2.5 | 1.9 | ; SUP_BAD | 0.2 | 2.4 | 0.7 | 0.8 | 0.4 | 0.3 | 1.0 | 1.4 | 0.8 | 1.4 | ; SUP_GOOD | 0.1 | 0.8 | 0.3 | 0.2 | 0.4 | 0.6 | 0.2 | 1.7 | 2.0 | 0.7 | ; USER_LONGTERM | 0.0 | 0.5 | 1.1 | 1.5 | 2.9 | 2.9 | 3.8 | 8.1 | 6.7 | 8.5 | ; DEV_TRUST | 0.7 | 4.1 | 2.3 | 0.5 | 0.2 | 0.2 | 0.2 | 0.3 | 0.3 | 3.2 | ; OUT_DISCIPLINE | 8.6 | 4.2 | 2.4 | 1.9 | 2.0 | 2.6 | 1.9 | 4.6 | 4.1 | 2.9 | ; LOC_UNTRANS | 0.0 | 0.9 | 1.9 | 1.3 | 0.9 | 1.1 | 0.4 | 0.4 | 0.2 | 0.7 |
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-179 — Counts behind each theme-by-year cell (verbatim)

- **Where:** §8.3 counts table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Year | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 | 2026 ; META_UNLOCK n | 427 | 24 | 7 | 1 | 0 | 0 | 0 | 2 | 1 | 0 ; META_PREUSE n | 542 | 12 | 1 | 15 | 50 | 34 | 30 | 17 | 14 | 2 ; META_LOWINFO n | 1296 | 172 | 93 | 327 | 495 | 542 | 366 | 534 | 620 | 315 ; PAY_CAP5 n | 25 | 164 | 82 | 205 | 159 | 71 | 54 | 65 | 55 | 8 ; PAY_WALL n | 29 | 142 | 80 | 137 | 85 | 59 | 45 | 47 | 57 | 34 ; PAY_BILLING n | 6 | 112 | 55 | 51 | 15 | 4 | 6 | 3 | 3 | 6 ; PAY_BOUGHT n | 30 | 233 | 174 | 274 | 171 | 67 | 54 | 94 | 88 | 101 ; PAY_LIFETIME n | 1 | 9 | 15 | 66 | 75 | 44 | 36 | 67 | 76 | 43 ; PAY_PRICE_HIGH n | 11 | 73 | 21 | 28 | 39 | 21 | 30 | 15 | 10 | 6 ; PAY_SUB_NEG n | 0 | 4 | 9 | 45 | 29 | 0 | 1 | 3 | 1 | 5 ; PAY_RESTORE n | 0 | 22 | 22 | 19 | 39 | 15 | 11 | 26 | 24 | 12 ; PAY_REGRESS n | 0 | 1 | 4 | 10 | 21 | 3 | 8 | 8 | 12 | 8 ; AD_NEG n | 0 | 1 | 24 | 99 | 83 | 9 | 2 | 14 | 575 | 78 ; AD_NONE_PRAISE n | 10 | 15 | 9 | 14 | 16 | 12 | 8 | 34 | 35 | 19 ; DES_CUTE n | 493 | 218 | 94 | 142 | 124 | 96 | 48 | 79 | 98 | 39 ; DES_CLEAN n | 362 | 221 | 82 | 121 | 134 | 116 | 75 | 220 | 247 | 138 ; DES_REDESIGN n | 0 | 0 | 9 | 58 | 95 | 33 | 11 | 70 | 49 | 47 ; DES_DENSE n | 38 | 78 | 34 | 41 | 78 | 41 | 18 | 29 | 43 | 27 ; BUG_CRASH n | 12 | 77 | 70 | 25 | 19 | 19 | 27 | 71 | 69 | 23 ; BUG_UPDATE n | 8 | 53 | 48 | 107 | 83 | 28 | 32 | 75 | 72 | 18 ; BUG_FEATURE n | 39 | 169 | 41 | 128 | 90 | 31 | 14 | 41 | 60 | 34 ; PLAT_WIDGET_BUG n | 2 | 35 | 10 | 147 | 138 | 30 | 16 | 36 | 20 | 20 ; DATA_LOSS n | 8 | 36 | 19 | 40 | 36 | 7 | 12 | 27 | 26 | 18 ; PLAT_IPAD n | 2 | 73 | 93 | 76 | 52 | 19 | 22 | 21 | 19 | 3 ; PLAT_WATCH n | 2 | 14 | 31 | 74 | 40 | 19 | 19 | 26 | 21 | 10 ; CARD_BUG n | 7 | 77 | 22 | 40 | 41 | 3 | 0 | 0 | 1 | 2 ; JRNL_WANT n | 18 | 110 | 68 | 145 | 160 | 33 | 22 | 27 | 55 | 30 ; REM_WANT n | 164 | 115 | 48 | 81 | 112 | 21 | 13 | 15 | 12 | 7 ; STAT_WANT n | 9 | 84 | 51 | 88 | 126 | 25 | 16 | 25 | 33 | 21 ; STAT_REWARD n | 2 | 14 | 5 | 22 | 92 | 31 | 24 | 37 | 60 | 25 ; FOCUS n | 5 | 33 | 15 | 70 | 74 | 17 | 15 | 24 | 63 | 74 ; CORE_TODO n | 9 | 17 | 13 | 30 | 49 | 13 | 21 | 60 | 69 | 26 ; SUP_BAD n | 5 | 48 | 10 | 24 | 12 | 5 | 11 | 27 | 23 | 19 ; SUP_GOOD n | 3 | 16 | 4 | 6 | 11 | 9 | 2 | 33 | 54 | 10 ; USER_LONGTERM n | 1 | 10 | 15 | 44 | 87 | 46 | 42 | 161 | 185 | 114 ; DEV_TRUST n | 18 | 81 | 31 | 15 | 7 | 4 | 2 | 5 | 7 | 43 ; OUT_DISCIPLINE n | 230 | 83 | 32 | 54 | 59 | 41 | 21 | 90 | 112 | 39 ; LOC_UNTRANS n | 0 | 17 | 26 | 38 | 28 | 17 | 4 | 8 | 5 | 10
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-180 — Trend reading, every value: worsening — AD_NEG 0.7% (2024) → 21.0% (2025) → 5.8% (2026); FOCUS ≤2.5% → 5.5% (2026), mostly the focus-page redesign and timer bugs; DES_REDESIGN in every release year (2.0% 2020, 3.2% 2021, 3.5% 2024, 3.5% 2026); improving — PAY_CAP5 8.2% (2018) → 0.6% (2026); PAY_BILLING 5.6% (2018) → ≤0.5% since 2021; CARD_BUG 3.9% (2018) → ~0 since 2022; PLAT_IPAD 7.0% (2019) → 0.2% (2026); REM_WANT 6.1% (2017) → 0.5% (2026); JRNL_WANT ~5% (2018–2021) → ~2% (2022–2026); emerging — USER_LONGTERM 1.5% (2020) → 8.1–8.5% (2024, 2026); CORE_TODO 3.0% (2024); SUP_GOOD 1.7–2.0% (2024–2025); persistent — DES_CLEAN 4–14% every year, DES_DENSE 1.4–3.9%, DATA_LOSS 0.4–1.8%, LOC_UNTRANS every year since 2018, PLAT_WATCH 0.7–2.6% every year since 2019

- **Where:** §8.3 worsening / improving / emerging / persistent
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as listed
- **Direction for us:** none · **Report confidence:** trend · **Generalisable:** app-specific
- **Canonical:** C082 Ads in the free tier; C270 Free habit capacity that grows with continued check-ins — an earned cap reads as generosity, not as a wall

### R52-181 — DEV_TRUST by year 0.7% (2017), 4.1% (2018, n=81), 2.3%, 0.5%, 0.2%, 0.2%, 0.2%, 0.3%, 0.3% (2025), 3.2% (2026, n=43) — trust peaked with cheap one-time tiers in 2018 and returned in 2026; SUP_GOOD n 16 (2018) → 33 (2024) → 54 (2025) → 10 (2026)

- **Where:** §8.3 DEV_TRUST series
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** DEV_TRUST 4.1% (2018) → 0.2–0.5% (2020–25) → 3.2% (2026)
- **Direction for us:** none · **Report confidence:** trend · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-182 — Incident windows (verbatim): Oct–Dec 2017 META_UNLOCK 415 of 2,535 (4.60) gated reminders; Apr 2018 PAY_BILLING 15 · CARD_BUG 6 (227, 3.90) purchase flow hangs, cards blank; Jul 2018 BUG_CRASH 25 (318, 4.31) crash on purchase button fixed next day; Oct 2019 BUG_CRASH 32 · BUG_UPDATE 18 (142, 3.73) v2.41 iOS 13 biometric crash; Feb 2020 PAY_CAP5 51 · 1★ 57 (372, 3.91) a surge of new users hitting the quota (3–5 habits); Jun–Aug 2020 PAY_SUB_NEG · PAY_REGRESS (3.69–3.92) lifetime → subscription; Oct 2020 PLAT_WIDGET_BUG 55 · DES_REDESIGN 26 (510, 4.26) iOS 14 widgets lose tap-to-check; Jun 2021 DES_REDESIGN 29 · BUG_UPDATE 19 (235, 4.16) status sheet on every check-in; May 2023 BUG_CRASH 26 (90, 3.76); 31 Jul 2023 BUG_UPDATE 12 in one day (110, 3.88); Sep 2024 BUG_CRASH 44 · BUG_UPDATE 29 · DES_REDESIGN 17 (240, 3.89) post-update crash, restore behind paywall, layout change; Dec 2024 DES_REDESIGN 14 · PLAT_WIDGET_BUG 11 (165, 4.41) layout and widget redesign, to-do sorting removed; Apr 2025 BUG_CRASH 24 (213, 4.39); Jun–Nov 2025 AD_NEG 546 (1,562, 3.35–3.98) in-flow ads; Sep 2025 BUG_CRASH 24 inside the ad wave (249, 3.86); Dec 2025 PAY_WALL 12 · PAY_REGRESS (191, 4.31) year statistics to VIP at year-end; Aug 2026 DES_REDESIGN 12 · BUG_CRASH 10 (187, 4.15) red focus page, launch crash with data loss

- **Where:** §8.4 incident table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Window | Signal | Reviews | Month mean ★ | What happened, per reviewers | Evidence ; Oct–Dec 2017 | META_UNLOCK | 415 of 2,535 | 4.60 | Reminders and features gated behind a written review | 1947016834 1958402990 1959643783 ; Apr 2018 | PAY_BILLING 15 · CARD_BUG 6 | 227 | 3.90 | Purchase flow hangs; cards blank | 2399860126 2404783757 2380647375 ; Jul 2018 | BUG_CRASH 25 | 318 | 4.31 | Crash on purchase button; fixed next day | 2830538942 2838663501 ; Oct 2019 | BUG_CRASH 32 · BUG_UPDATE 18 | 142 | 3.73 | v2.41 on iOS 13: crash after biometric unlock | 4942566618 4925667389 ; Feb 2020 | PAY_CAP5 51 · 1★ 57 | 372 | 3.91 | A surge of new users hitting the quota (3–5 habits) | 5519779697 5560993303 5562288248 ; Jun–Aug 2020 | PAY_SUB_NEG · PAY_REGRESS | — | 3.69–3.92 | Lifetime → subscription | 6119258263 6268143177 6014282876 ; Oct 2020 | PLAT_WIDGET_BUG 55 · DES_REDESIGN 26 | 510 | 4.26 | iOS 14 widgets lose tap-to-check | 6487343139 6489384630 6514321794 ; Jun 2021 | DES_REDESIGN 29 · BUG_UPDATE 19 | 235 | 4.16 | Success/Pending/Fail sheet on every check-in | 7515737588 7517368475 7519571134 ; May 2023 | BUG_CRASH 26 | 90 | 3.76 | v7.14 launch crash; reinstall loses data | 9919428713 9980189801 ; 31 Jul 2023 | BUG_UPDATE 12 (one day) | 110 | 3.88 | App cannot be updated or re-downloaded | 10203240496 10204269642 ; Sep 2024 | BUG_CRASH 44 · BUG_UPDATE 29 · DES_REDESIGN 17 | 240 | 3.89 | Post-update crash; restore behind paywall; layout change | 11764810805 11779820068 11694266275 ; Dec 2024 | DES_REDESIGN 14 · PLAT_WIDGET_BUG 11 | 165 | 4.41 | Layout and widget redesign; to-do sorting removed | 12024716798 12062367782 12120100064 ; Apr 2025 | BUG_CRASH 24 | 213 | 4.39 | Post-update launch crash | 12516883329 12522893732 ; Jun–Nov 2025 | AD_NEG 546 | 1,562 | 3.35–3.98 | In-flow ads with auto-jump, motion trigger, hidden close | §0.1 ; Sep 2025 | BUG_CRASH 24 (inside ad wave) | 249 | 3.86 | Crash on iOS 14.x for 20+ days | 13185604830 13180896126 ; Dec 2025 | PAY_WALL 12 · PAY_REGRESS | 191 | 4.31 | Year statistics moved to VIP at year-end | 13501470470 13559154241 13557404547 13530928663 ; Aug 2026 | DES_REDESIGN 12 · BUG_CRASH 10 | 187 | 4.15 | Red focus page; launch crash with data loss | 14381653023 14397667938 14397348639
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `2399860126`, `5519779697`, `5560993303`, `12062367782`, `12120100064`, `11694266275`, `14397667938`, `14397348639`
- **Canonical:** C031 Crashes / launch failures; C175 Updates must not break function or wipe progress

### R52-183 — Feb 2020: a surge of new users (372 reviews, 1★ 57, mean 3.91) hitting the 3–5-habit quota — PAY_CAP5 51 in one month; an acquisition spike converts into cap complaints

- **Where:** §8.4 Feb 2020 row
- **This app does:** free quota 3–5 during an install surge
- **User reaction:** 1★-burst
- **Magnitude:** PAY_CAP5 51; 1★ 57; 372 reviews at 3.91
- **Direction for us:** build-free · **Report confidence:** incident window · **Generalisable:** generalisable
- **Review IDs:** `5519779697`, `5560993303`, `5562288248`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R52-184 — Dec 2024 layout and widget redesign removed to-do sorting (DES_REDESIGN 14 · PLAT_WIDGET_BUG 11, 165 reviews at 4.41; a ¥68 buyer asked for a refund); Aug 2026 red focus page plus a launch crash with data loss (DES_REDESIGN 12 · BUG_CRASH 10, DATA_LOSS 8, 187 at 4.15)

- **Where:** §8.4 Dec 2024 and Aug 2026 rows
- **This app does:** redesign removes a used feature
- **User reaction:** complaint
- **Magnitude:** Dec 2024 14 + 11; Aug 2026 12 + 10 + 8
- **Direction for us:** must-never-break · **Report confidence:** incident window · **Generalisable:** generalisable
- **Review IDs:** `12024716798`, `12062367782`, `12120100064`, `14381653023`, `14397667938`, `14397348639`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R52-185 — Full month-by-month table, 110 months × ten indicators (verbatim)

- **Where:** §8.4 month table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Month | Reviews | Mean ★ | 1★ | META_UNLOCK | PAY_CAP5 | PAY_WALL | PAY_BILLING | AD_NEG | BUG_CRASH | BUG_UPDATE | PLAT_WIDGET_BUG | DES_REDESIGN | DATA_LOSS ; 2017-08 | 19 | 4.63 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 ; 2017-09 | 113 | 4.71 | 1 | 12 | 1 | 4 | 0 | 0 | 0 | 1 | 0 | 0 | 0 ; 2017-10 | 645 | 4.60 | 6 | 105 | 5 | 8 | 0 | 0 | 1 | 3 | 0 | 0 | 0 ; 2017-11 | 1115 | 4.60 | 18 | 190 | 7 | 10 | 1 | 0 | 6 | 1 | 0 | 0 | 6 ; 2017-12 | 775 | 4.61 | 13 | 120 | 12 | 7 | 5 | 0 | 5 | 3 | 2 | 0 | 2 ; 2018-01 | 125 | 4.30 | 8 | 1 | 11 | 7 | 7 | 0 | 2 | 5 | 2 | 0 | 2 ; 2018-02 | 82 | 4.20 | 8 | 2 | 9 | 3 | 7 | 0 | 4 | 0 | 0 | 0 | 2 ; 2018-03 | 181 | 4.03 | 21 | 7 | 18 | 16 | 16 | 0 | 6 | 1 | 2 | 0 | 4 ; 2018-04 | 227 | 3.90 | 27 | 1 | 17 | 24 | 15 | 0 | 6 | 8 | 8 | 0 | 7 ; 2018-05 | 182 | 3.82 | 31 | 1 | 13 | 14 | 12 | 0 | 9 | 2 | 6 | 0 | 7 ; 2018-06 | 244 | 4.32 | 19 | 4 | 17 | 8 | 7 | 0 | 12 | 5 | 9 | 0 | 1 ; 2018-07 | 318 | 4.31 | 18 | 1 | 23 | 19 | 27 | 0 | 25 | 16 | 5 | 0 | 7 ; 2018-08 | 189 | 4.12 | 18 | 4 | 14 | 18 | 10 | 0 | 6 | 7 | 0 | 0 | 2 ; 2018-09 | 117 | 4.13 | 11 | 0 | 15 | 12 | 2 | 0 | 1 | 5 | 2 | 0 | 2 ; 2018-10 | 111 | 3.99 | 12 | 1 | 13 | 13 | 4 | 0 | 1 | 1 | 0 | 0 | 1 ; 2018-11 | 111 | 4.43 | 5 | 2 | 8 | 6 | 4 | 0 | 0 | 1 | 1 | 0 | 0 ; 2018-12 | 102 | 4.41 | 4 | 0 | 6 | 2 | 1 | 1 | 5 | 2 | 0 | 0 | 1 ; 2019-01 | 135 | 4.29 | 9 | 0 | 11 | 10 | 8 | 0 | 1 | 3 | 0 | 2 | 0 ; 2019-02 | 140 | 4.39 | 10 | 2 | 4 | 7 | 11 | 0 | 1 | 0 | 0 | 1 | 1 ; 2019-03 | 139 | 4.06 | 19 | 2 | 12 | 13 | 10 | 1 | 1 | 1 | 0 | 1 | 2 ; 2019-04 | 116 | 4.20 | 12 | 1 | 5 | 8 | 3 | 1 | 15 | 4 | 1 | 0 | 1 ; 2019-05 | 75 | 4.35 | 6 | 1 | 2 | 2 | 3 | 1 | 0 | 2 | 0 | 1 | 1 ; 2019-06 | 94 | 4.21 | 7 | 0 | 5 | 4 | 4 | 1 | 2 | 5 | 1 | 0 | 0 ; 2019-07 | 95 | 4.19 | 9 | 0 | 13 | 6 | 7 | 0 | 2 | 4 | 2 | 1 | 3 ; 2019-08 | 138 | 4.01 | 18 | 0 | 9 | 6 | 1 | 4 | 10 | 8 | 0 | 0 | 1 ; 2019-09 | 94 | 4.10 | 10 | 1 | 6 | 1 | 4 | 1 | 2 | 2 | 2 | 0 | 2 ; 2019-10 | 142 | 3.73 | 28 | 0 | 7 | 9 | 2 | 5 | 32 | 18 | 1 | 2 | 2 ; 2019-11 | 103 | 3.93 | 17 | 0 | 6 | 7 | 1 | 6 | 4 | 1 | 2 | 0 | 3 ; 2019-12 | 67 | 3.61 | 14 | 0 | 2 | 7 | 1 | 4 | 0 | 0 | 1 | 1 | 3 ; 2020-01 | 90 | 3.78 | 15 | 1 | 4 | 8 | 4 | 3 | 3 | 1 | 0 | 0 | 2 ; 2020-02 | 372 | 3.91 | 57 | 0 | 51 | 36 | 7 | 11 | 0 | 0 | 1 | 0 | 4 ; 2020-03 | 340 | 4.07 | 43 | 0 | 32 | 15 | 13 | 10 | 2 | 12 | 11 | 5 | 4 ; 2020-04 | 206 | 3.75 | 36 | 0 | 17 | 10 | 9 | 11 | 0 | 15 | 7 | 1 | 4 ; 2020-05 | 138 | 3.92 | 16 | 0 | 6 | 5 | 4 | 3 | 1 | 5 | 3 | 0 | 3 ; 2020-06 | 107 | 3.92 | 16 | 0 | 7 | 6 | 3 | 1 | 9 | 10 | 2 | 7 | 2 ; 2020-07 | 97 | 3.69 | 17 | 0 | 12 | 7 | 1 | 5 | 4 | 3 | 1 | 0 | 1 ; 2020-08 | 81 | 3.89 | 13 | 0 | 9 | 8 | 0 | 2 | 1 | 0 | 1 | 0 | 1 ; 2020-09 | 108 | 4.03 | 12 | 0 | 2 | 2 | 3 | 6 | 0 | 12 | 14 | 5 | 1 ; 2020-10 | 510 | 4.26 | 34 | 0 | 22 | 14 | 2 | 15 | 4 | 26 | 55 | 26 | 8 ; 2020-11 | 418 | 4.31 | 21 | 0 | 19 | 13 | 3 | 15 | 0 | 7 | 27 | 5 | 5 ; 2020-12 | 409 | 4.20 | 33 | 0 | 24 | 13 | 2 | 17 | 1 | 16 | 25 | 9 | 5 ; 2021-01 | 494 | 4.18 | 45 | 0 | 30 | 26 | 5 | 20 | 5 | 18 | 26 | 8 | 6 ; 2021-02 | 427 | 4.26 | 29 | 0 | 34 | 12 | 5 | 13 | 2 | 7 | 13 | 4 | 4 ; 2021-03 | 422 | 4.23 | 27 | 0 | 30 | 11 | 1 | 24 | 2 | 6 | 14 | 4 | 5 ; 2021-04 | 255 | 4.42 | 16 | 0 | 4 | 4 | 0 | 7 | 2 | 3 | 11 | 4 | 3 ; 2021-05 | 209 | 4.40 | 10 | 0 | 5 | 2 | 0 | 6 | 2 | 4 | 12 | 5 | 4 ; 2021-06 | 235 | 4.16 | 20 | 0 | 7 | 5 | 2 | 2 | 1 | 19 | 12 | 29 | 0 ; 2021-07 | 211 | 4.09 | 24 | 0 | 9 | 9 | 1 | 3 | 2 | 11 | 10 | 11 | 2 ; 2021-08 | 216 | 4.31 | 9 | 0 | 12 | 10 | 0 | 2 | 1 | 7 | 19 | 13 | 2 ; 2021-09 | 143 | 4.20 | 9 | 0 | 5 | 1 | 0 | 3 | 1 | 4 | 7 | 6 | 1 ; 2021-10 | 121 | 4.26 | 8 | 0 | 10 | 2 | 0 | 0 | 0 | 2 | 4 | 4 | 2 ; 2021-11 | 151 | 4.15 | 13 | 0 | 6 | 1 | 0 | 2 | 1 | 1 | 5 | 4 | 4 ; 2021-12 | 120 | 4.06 | 13 | 0 | 7 | 2 | 1 | 1 | 0 | 1 | 5 | 3 | 3 ; 2022-01 | 179 | 4.07 | 19 | 0 | 6 | 3 | 2 | 6 | 7 | 17 | 10 | 10 | 1 ; 2022-02 | 162 | 4.46 | 9 | 0 | 1 | 4 | 1 | 2 | 4 | 2 | 2 | 3 | 0 ; 2022-03 | 181 | 4.34 | 14 | 0 | 5 | 8 | 0 | 0 | 0 | 2 | 4 | 7 | 0 ; 2022-04 | 172 | 4.58 | 7 | 0 | 7 | 2 | 0 | 0 | 3 | 1 | 2 | 1 | 0 ; 2022-05 | 131 | 4.39 | 8 | 0 | 9 | 6 | 0 | 0 | 1 | 3 | 2 | 1 | 1 ; 2022-06 | 119 | 4.21 | 10 | 0 | 5 | 5 | 0 | 0 | 2 | 1 | 4 | 3 | 0 ; 2022-07 | 132 | 4.08 | 15 | 0 | 11 | 12 | 1 | 1 | 0 | 0 | 1 | 2 | 1 ; 2022-08 | 109 | 4.34 | 10 | 0 | 5 | 5 | 0 | 0 | 1 | 1 | 1 | 1 | 1 ; 2022-09 | 93 | 4.28 | 8 | 0 | 5 | 5 | 0 | 0 | 0 | 1 | 3 | 1 | 0 ; 2022-10 | 116 | 4.39 | 10 | 0 | 4 | 2 | 0 | 0 | 1 | 0 | 0 | 2 | 2 ; 2022-11 | 113 | 4.26 | 11 | 0 | 9 | 3 | 0 | 0 | 0 | 0 | 1 | 2 | 1 ; 2022-12 | 96 | 4.31 | 9 | 0 | 4 | 4 | 0 | 0 | 0 | 0 | 0 | 0 | 0 ; 2023-01 | 118 | 4.33 | 10 | 0 | 9 | 6 | 0 | 0 | 0 | 1 | 1 | 0 | 0 ; 2023-02 | 116 | 4.30 | 9 | 0 | 3 | 8 | 1 | 0 | 0 | 1 | 0 | 1 | 0 ; 2023-03 | 123 | 4.28 | 10 | 0 | 2 | 4 | 0 | 0 | 0 | 2 | 6 | 3 | 1 ; 2023-04 | 83 | 4.33 | 4 | 0 | 7 | 2 | 1 | 0 | 0 | 0 | 0 | 0 | 1 ; 2023-05 | 90 | 3.76 | 19 | 0 | 1 | 1 | 1 | 0 | 26 | 6 | 1 | 2 | 6 ; 2023-06 | 93 | 4.43 | 4 | 0 | 3 | 1 | 1 | 0 | 1 | 0 | 1 | 0 | 2 ; 2023-07 | 110 | 3.88 | 18 | 0 | 7 | 12 | 1 | 0 | 0 | 12 | 2 | 0 | 0 ; 2023-08 | 110 | 4.15 | 12 | 0 | 11 | 3 | 0 | 0 | 0 | 10 | 1 | 1 | 0 ; 2023-09 | 58 | 4.03 | 9 | 0 | 1 | 2 | 0 | 2 | 0 | 0 | 0 | 0 | 0 ; 2023-10 | 82 | 4.21 | 8 | 0 | 3 | 1 | 1 | 0 | 0 | 0 | 2 | 1 | 0 ; 2023-11 | 61 | 4.05 | 9 | 0 | 3 | 3 | 0 | 0 | 0 | 0 | 1 | 1 | 2 ; 2023-12 | 50 | 4.08 | 7 | 0 | 4 | 2 | 0 | 0 | 0 | 0 | 1 | 2 | 0 ; 2024-01 | 92 | 4.57 | 4 | 0 | 3 | 2 | 0 | 0 | 0 | 1 | 3 | 0 | 1 ; 2024-02 | 99 | 4.00 | 18 | 0 | 3 | 5 | 0 | 1 | 10 | 2 | 2 | 1 | 1 ; 2024-03 | 182 | 4.31 | 15 | 1 | 9 | 6 | 1 | 0 | 0 | 5 | 4 | 6 | 0 ; 2024-04 | 193 | 4.48 | 13 | 1 | 10 | 5 | 0 | 0 | 0 | 4 | 2 | 4 | 2 ; 2024-05 | 139 | 4.68 | 5 | 0 | 5 | 1 | 1 | 0 | 1 | 2 | 2 | 1 | 1 ; 2024-06 | 164 | 4.59 | 11 | 0 | 5 | 3 | 0 | 5 | 2 | 3 | 0 | 3 | 0 ; 2024-07 | 184 | 4.31 | 21 | 0 | 5 | 6 | 1 | 5 | 6 | 7 | 1 | 5 | 3 ; 2024-08 | 179 | 4.57 | 10 | 0 | 5 | 4 | 0 | 2 | 3 | 2 | 2 | 6 | 3 ; 2024-09 | 240 | 3.89 | 45 | 0 | 7 | 5 | 0 | 0 | 44 | 29 | 3 | 17 | 10 ; 2024-10 | 157 | 4.58 | 7 | 0 | 5 | 0 | 0 | 0 | 0 | 3 | 0 | 4 | 2 ; 2024-11 | 184 | 4.49 | 13 | 0 | 4 | 3 | 0 | 0 | 4 | 10 | 6 | 9 | 4 ; 2024-12 | 165 | 4.41 | 14 | 0 | 4 | 7 | 0 | 1 | 1 | 7 | 11 | 14 | 0 ; 2025-01 | 183 | 4.54 | 10 | 0 | 3 | 4 | 1 | 0 | 1 | 2 | 2 | 12 | 1 ; 2025-02 | 179 | 4.70 | 6 | 0 | 4 | 7 | 0 | 1 | 1 | 1 | 0 | 1 | 5 ; 2025-03 | 213 | 4.69 | 8 | 0 | 9 | 1 | 0 | 1 | 0 | 2 | 0 | 3 | 2 ; 2025-04 | 213 | 4.39 | 16 | 0 | 6 | 4 | 0 | 1 | 24 | 7 | 0 | 0 | 2 ; 2025-05 | 203 | 4.62 | 11 | 0 | 8 | 3 | 0 | 3 | 1 | 1 | 5 | 4 | 1 ; 2025-06 | 273 | 3.60 | 76 | 0 | 2 | 0 | 0 | 85 | 3 | 14 | 2 | 5 | 1 ; 2025-07 | 362 | 3.35 | 100 | 0 | 7 | 11 | 0 | 173 | 3 | 13 | 2 | 4 | 2 ; 2025-08 | 251 | 3.78 | 51 | 1 | 4 | 7 | 1 | 92 | 1 | 5 | 2 | 2 | 0 ; 2025-09 | 249 | 3.86 | 44 | 0 | 7 | 2 | 0 | 73 | 24 | 8 | 1 | 5 | 2 ; 2025-10 | 213 | 3.98 | 32 | 0 | 3 | 3 | 0 | 60 | 5 | 6 | 3 | 4 | 3 ; 2025-11 | 214 | 3.87 | 42 | 0 | 1 | 3 | 1 | 63 | 2 | 4 | 1 | 2 | 5 ; 2025-12 | 191 | 4.31 | 21 | 0 | 1 | 12 | 0 | 23 | 4 | 9 | 2 | 7 | 2 ; 2026-01 | 198 | 4.45 | 17 | 0 | 4 | 1 | 0 | 22 | 1 | 5 | 4 | 5 | 2 ; 2026-02 | 147 | 4.34 | 13 | 0 | 0 | 2 | 0 | 12 | 0 | 5 | 4 | 10 | 1 ; 2026-03 | 223 | 4.44 | 20 | 0 | 2 | 5 | 2 | 14 | 2 | 2 | 2 | 4 | 3 ; 2026-04 | 139 | 4.50 | 11 | 0 | 0 | 3 | 1 | 6 | 6 | 2 | 0 | 6 | 0 ; 2026-05 | 154 | 4.61 | 6 | 0 | 1 | 5 | 0 | 4 | 0 | 1 | 4 | 2 | 2 ; 2026-06 | 135 | 4.45 | 13 | 0 | 0 | 5 | 1 | 4 | 3 | 0 | 0 | 2 | 1 ; 2026-07 | 130 | 4.51 | 8 | 0 | 0 | 3 | 0 | 5 | 1 | 0 | 3 | 4 | 1 ; 2026-08 | 187 | 4.15 | 24 | 0 | 1 | 8 | 2 | 10 | 10 | 2 | 2 | 12 | 8 ; 2026-09 | 28 | 4.29 | 4 | 0 | 0 | 2 | 0 | 1 | 0 | 1 | 1 | 2 | 0
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

## Positioning

### R52-001 — ShineDay: Habit Tracker / 小日常 (App Store ID 1263789061; subtitle 'Micro Habits, ADHD & Focus') by Guangzhou Xiaorichang Technology Co., Ltd. (bundle com.dandelion.Routine) — 20,634 written reviews, 48 storefronts, 3 Aug 2017 → 7 Sep 2026 (110 months), extracted 8 Sep 2026; written mean 4.25 (13,415×5★, 3,278×4★, 1,498×3★, 570×2★, 1,873×1★); ranking snapshot 562,951 public ratings at 4.78, ranked in 45 storefronts, best search rank 2 (Hong Kong), median rank 32, audience 'established'; a nine-year-old mainland-China habit tracker people choose for how it looks and feels (clean 8.32%, cute 6.94%, no social layer) whose reviews turn negative almost entirely over how it makes money

- **Where:** header lines 1-7
- **This app does:** freemium habit tracker: free habit quota, lifetime/membership tiers, 8-yuan ad-free SKU, ads from 2019 and aggressively from June 2025; also an Android build and a Mac build
- **User reaction:** mixed
- **Magnitude:** 20,634 reviews; 562,951 public ratings at 4.78
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-060 — Positioning versus reviewing population: the subtitle names ADHD and Focus; reviewers name cute, clean, simple, self-discipline and no social features; OUT_ADHD 6 (0.03%); FOCUS 390 (1.89%, meaningful, mean 4.35, mixed) rising to 5.5% of 2026 reviews, mostly requests and complaints about the new focus page — the reviewing population is a Chinese self-discipline and planner audience; any ADHD roadmap would rest on listing positioning, not this corpus

- **Where:** §2.5
- **This app does:** subtitle ADHD & Focus
- **User reaction:** mixed
- **Magnitude:** OUT_ADHD 6 (0.03%); FOCUS 390 (1.89%), 5.5% of 2026
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `14466033004`, `14381653023`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R52-089 — USER_SWITCH 355 (1.72%, meaningful, mean 4.47): mostly 'I tried ten apps, this one stuck', a minority leaving

- **Where:** §3.5 USER_SWITCH row
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 355 (1.72%, 4.47)
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `12806346802`, `8818193734`
- **Canonical:** — (nuance register)

## Anti-patterns

### R52-014 — Reviewers do not object to ads as such; they describe specific interaction-design mechanics, repeatedly and independently — text sub-cuts inside AD_NEG, 2025–26: ad opens another app automatically (Taobao, Pinduoduo, Meituan, Quark) 107; close / skip button hidden, tiny or ineffective 88; shaking or tilting the phone triggers the ad 33; ad appears after the check-in itself, not only at launch (read in window); paying members still see ads (AD_NEG ∩ PAY_BOUGHT, all years) 40 — 'the skip and close buttons get more hidden… move the phone slightly, twist it, tilt the screen… it jumps into the ad page'; a full-screen Taobao ad 'that also can't be closed'; the reading: 'the ads were not a pricing decision that users rejected. They were an interaction-design decision' — a 35% complaint rate within five months

- **Where:** §0.1 mechanics table (verbatim) and reading
- **This app does:** auto-jump ads, motion-triggered ads, close control that does not close, ads after check-in, ads to payers
- **User reaction:** 1★-burst
- **Magnitude:** Mechanic | Reviews (2025–26) | Representative IDs ; Ad opens another app automatically (Taobao, Pinduoduo, Meituan, Quark) | 107 | 12831040911 12886873169 12914673906 13362003467 ; Close / skip button hidden, tiny or ineffective | 88 | 12803944732 12793111376 13362003467 12831040911 ; Shaking or tilting the phone triggers the ad | 33 | 12831040911 12829168869 12739880901 ; Ad appears after the check-in itself, not only at launch | — (read in window) | 12796570816 12742750263 13362003467 ; Paying members still see ads (coded AD_NEG ∩ PAY_BOUGHT, all years) | 40 | 12795677855 14301818772 13876926025 4189381643
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `12831040911`, `12886873169`, `12914673906`, `13362003467`, `12803944732`, `12793111376`, `12829168869`, `12739880901`, `12796570816`, `12742750263`
- **Canonical:** C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap; C269 If the free tier carries ads, never use hijacking ad mechanics — no auto-jump into other apps, no shake or tilt triggers, a close control that closes, and no ad on the check-in

### R52-025 — The single most expensive failure is the reinstall path: a crash leads to a reinstall, which loses local data; restoring that data asks for membership, and the old membership doesn't restore — 32 reviews say outright that restoring their own data required paying: 'after reinstalling I bought lifetime membership to restore my data, and restoring crashed the app' (1★, 26 Sep 2024); decision: never put restoring a user's own records behind a paywall

- **Where:** §0.3 'The single most expensive failure is the reinstall path'; §0.9 #2
- **This app does:** data restore gated behind membership; membership restore fails after reinstall
- **User reaction:** 1★-burst
- **Magnitude:** 32 reviews
- **Direction for us:** product-rule · **Report confidence:** high-priority (parent) · **Generalisable:** generalisable
- **Side effects:** turns a crash into a forced purchase and a data-loss 1★
- **Review IDs:** `6494333470`, `11779820068`, `11764810805`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C034 Data must never be lost on update, reinstall or phone change; C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R52-051 — Year statistics moved from free to VIP in December 2025 — 15 reviews since Nov 2025 (high confidence) — and PAY_WALL returned in December 2025 and 2026

- **Where:** §2.2 Dec 2025 row; §2.3 year statistics row; §3.3 N3
- **This app does:** free → paid: year statistics, Dec 2025
- **User reaction:** 1★-burst
- **Magnitude:** 15 reviews since Nov 2025
- **Direction for us:** product-rule · **Report confidence:** high (status confidence) · **Generalisable:** generalisable
- **Review IDs:** `13501470470`, `13559154241`, `13557404547`, `13530928663`
- **Canonical:** C001 Never move a free feature behind the paywall; C011 Weekly / monthly / yearly reports; C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells

### R52-064 — Two ad waves: splash and cross-promotion ads 2019–2021 (206 reviews) and the June 2025 in-flow ads (575 in 2025); AD_CROSSPROMO 26 (0.13%, weak, mean 3.35) — forced Weibo-follow and developer-promotion pop-ups that couldn't be dismissed (2019–2021)

- **Where:** §3.3 N1 AD_CROSSPROMO
- **This app does:** undismissable follow-us and cross-promotion pop-ups
- **User reaction:** complaint
- **Magnitude:** 2019–21 wave 206; AD_CROSSPROMO 26 (0.13%, 3.35)
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `3926888539`, `5674638517`, `12844224345`
- **Canonical:** C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C269 If the free tier carries ads, never use hijacking ad mechanics — no auto-jump into other apps, no shake or tilt triggers, a close control that closes, and no ad on the check-in

### R52-112 — The 2026 'habit ball' collection (a new reward surface) could not be hidden and added friction to the check-in loop

- **Where:** §4.1 bullet habit ball
- **This app does:** new collection surface forced on users
- **User reaction:** complaint
- **Magnitude:** report gives none
- **Direction for us:** dont · **Report confidence:** report gives none · **Generalisable:** generalisable
- **Review IDs:** `13991192760`, `14001497640`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

### R52-121 — AI-generated note titles shipped Feb–Apr 2026 and couldn't be switched off — part of a 20-review redesign burst; reviewers ask for no forced titles and no AI titles

- **Where:** §4.5 #4; §0.6 Feb–Apr 2026
- **This app does:** AI note titles forced on
- **User reaction:** complaint
- **Magnitude:** 20 DES_REDESIGN (Feb–Apr 2026)
- **Direction for us:** dont · **Report confidence:** meaningful (parent) · **Generalisable:** generalisable
- **Review IDs:** `13930545782`, `13965180848`, `14508025525`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C267 No AI-generated art, copy or content in a paid product — reviewers accept an AI coach and reject AI decoration

### R52-209 — Onboarding (2026) requires picking 5 habits and choosing a 3-day trial with paywall screens lacking a visible back control — a forced-trial onboarding pattern that re-opened PAY_WALL

- **Where:** §9.2 M6; §2.2 2026 row
- **This app does:** forced habit selection and trial choice at onboarding
- **User reaction:** complaint
- **Magnitude:** PAY_WALL 2.5% of 2026
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `14389575364`, `13986964200`, `14206066896`, `14507944819`, `14426138907`
- **Canonical:** C063 Free trial before purchase; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

## Things not to do

### R52-188 — F1: remove motion-triggered and auto-jump ad formats; make every close control close; no ad after a check-in — success signal AD_NEG share below the 2020–21 level (≤3%); first priority with F2 ('the fastest, largest sentiment recovery; no pricing change needed')

- **Where:** §9.1 F1; part 9 #1
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 546 in six months; 107 auto-jump, 88 broken-close, 33 motion-trigger; target ≤3%
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap; C269 If the free tier carries ads, never use hijacking ad mechanics — no auto-jump into other apps, no shake or tilt triggers, a close control that closes, and no ad on the check-in

### R52-201 — M6: onboarding must allow skipping the trial and habit selection, and every paywall screen needs a visible back control (2026 reviews)

- **Where:** §9.2 M6
- **This app does:** 2026 onboarding forces habit selection and trial choice; paywall screens without back
- **User reaction:** complaint
- **Magnitude:** report gives none
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `14389575364`, `14507944819`, `14426138907`, `14501891567`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

## Things to do

### R52-035 — A 5★ reviewer proposes the governance fix unprompted: 'style changes too much between iterations… consider decoupling the front-end style' (Nov 2025) — keep a stable visual style independent of feature iteration

- **Where:** §0.6 quote 13403164932
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** n=1
- **Direction for us:** do · **Report confidence:** very strong (parent) · **Generalisable:** generalisable
- **Review IDs:** `13403164932`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R52-080 — Fast fixes are named specifically and build trust: a purchase crash fixed the next day (2018), a bug fixed a day after email (2020), a feature request shipped within days (2024) and within a month (2025); SUP_GOOD 148 (0.72%, emerging, mean 4.93); USER_LONGTERM 705, DEV_TRUST 213 (4.93)

- **Where:** §3.4 P4
- **This app does:** responsive developer at times
- **User reaction:** praise
- **Magnitude:** SUP_GOOD 148 (0.72%, 4.93)
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `2838663501`, `5913842481`, `11719901468`, `13403164932`, `9563598738`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R52-194 — F7: complete English strings — notifications and ads first; ship Traditional Chinese — success LOC_UNTRANS + LOC_WANT below 5% in us, ca, au, tw; with R3 'the largest remaining positive opportunities'

- **Where:** §9.1 F7; part 9 #5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** top theme in us, ca, au (≈22%) and tw (22.89%); target <5%
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C027 Localise early — it unlocks revenue

### R52-199 — M4: make the ¥8 ad-free SKU visible before the first ad, not discoverable after an ad fails to close — a reviewer reads the SKU as the motive for hostile ads; could raise conversion and lower PAY_SCAM

- **Where:** §9.2 M4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13362003467`
- **Canonical:** C082 Ads in the free tier; C269 If the free tier carries ads, never use hijacking ad mechanics — no auto-jump into other apps, no shake or tilt triggers, a close control that closes, and no ad on the check-in

### R52-208 — What to do first: 1 F1 + F2 ad mechanics and payer protection; 2 F3 + F4 restore and entitlement portability; 3 F5 release gate; 4 R1 opt-in redesigns; 5 F7 + R3 localisation and photos in notes

- **Where:** §9.5 part 9 #1–#5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

## Contradictions

### R52-010 — The listing's 'ADHD' positioning is not a corpus theme: only 6 reviews (0.03%, ignore) mention ADHD — the store subtitle ('Micro Habits, ADHD & Focus') and the reviewing population do not overlap

- **Where:** §1.6 #8; §4.8
- **This app does:** subtitle names ADHD
- **User reaction:** none
- **Magnitude:** 6 (0.03%)
- **Direction for us:** research · **Report confidence:** ignore · **Generalisable:** app-specific
- **Conditions:** Chinese-language user base; ADHD keyword aimed at English search
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Data caveats and method

### R52-002 — Method: all 20,634 reviews read individually in original language (Chinese simplified and traditional, English, Japanese, mixed) in chronological order, 166 chunks of 125; hand-assigned from a 123-code, 12-family inductive taxonomy (Temp/52-cls, Temp/52-review-classification.py), 34,191 assignments (1.66 per review, median 1); validated 0 unknown IDs, 0 unassigned, 0 duplicate keys, 0 intra-review duplicate themes, 0 undefined codes, 1 declared-but-unused code (SOC_GROUP_NEG n=0); reconciliation exact against 48 by_country files, manifest (20,634; 5:13,415 · 4:3,278 · 3:1,498 · 2:570 · 1:1,873; mean 4.2500) and _state.json (92 storefronts polled, all complete); no deduplication — 171 identical title+body pairs over 953 records are coincidental short phrases (好 ×129, 不错 ×74, 好用 ×73, 很好 ×46, good ×16) and all kept; every global % divides by 20,634; signal bands <0.1% ignore · 0.1–0.5% weak · 0.5–1% emerging · 1–3% meaningful · 3–5% very strong · >5% high-priority; text sub-cuts only ever taken inside a hand-coded theme and labelled; high-impact clusters re-read before writing; no automated classifier; 13 fields present — author, app_id, app_name, country_name unused; is_edited 186 (0.90%), vote_count>0 on 323 (1.57%, max 63 on 5813993595), votes never weights; body median 19 characters, mean 34.9; translations marked EN

- **Where:** §How to read this; §1.1–1.5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 20,634 (100%)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `5813993595`
- **Canonical:** — (nuance register)

### R52-003 — A mainland-China corpus: 19,669 of 20,634 (95.32%) from cn and 19,858 (96.24%) written in Chinese — 'global' means China plus 965 reviews from 47 other storefronts; only six storefronts clear 50 (cn 19,669 · us 287 · tw 201 · hk 119 · ca 61 · au 53); gb 40, sg 27, jp 24, de 22 and every other storefront are limited evidence

- **Where:** §Eight warnings 1, 7; §1.6 #4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 95.32% cn; 6 eligible storefronts
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-004 — Written reviews are 3.67% of public ratings (20,634 of 562,951) and the written mean (4.25) sits 0.53★ below the public average (4.78) — a moderate gap consistent across storefronts, so a negativity-skewed sample, not a different population

- **Where:** §Eight warnings 2; §1.6 #3
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 3.67%; −0.53★
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

### R52-005 — Almost a quarter of the corpus has no product content: META_LOWINFO 4,760 (23.07%, largest theme, applied generously) — '好', '不错', '好用'; with pre-use and review-to-unlock reviews 5,479 (26.55%, mean 4.73) carry no product experience; median body 19 characters; the 5★ band is 30.8% content-free

- **Where:** §Eight warnings 3; §1.6 #6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 4,760 (23.07%); 5,479 (26.55%, 4.73); 5★ 30.8% content-free
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-008 — 73 reviews (0.35%, weak) contradict their own rating — 35 are 5★ complaints and 24 are 1★ praise; kept and listed in full (§5.6, Appendix E)

- **Where:** §Eight warnings 6; §1.7 Contradictions
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 73 (0.35%): 35 5★ complaints, 24 1★ praise
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-009 — No version field and no developer responses in the data: every release, price change and redesign is reconstructed from reviewer text and dates; no live App Store page or developer site fetched — every price, tier name, trial and feature description is reviewer-reported with reviewers' own errors, contradictions reported not resolved; one external source, the repo's undated habit_apps_ranked.json (public counts, averages, search ranks, market_tier rich/volume/other); reviewers mention developer replies (3823855755, 11719901468) but replies are not in the data; 2026 is partial (to 7 Sep); prices span nine years of changes

- **Where:** §Eight warnings 8; §1.6 #1, #2, #5, #7
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Review IDs:** `3823855755`, `11719901468`
- **Canonical:** — (nuance register)

### R52-011 — META_FAKE 37 (0.18%, weak, mean 2.27): mostly 1★ reviewers who cannot reconcile the high average with their experience ('such a high score must be bought'); no evidence of purchased reviews beyond the disclosed 2017 gate

- **Where:** §1.7 Fake-review allegations
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 37 (0.18%, 2.27)
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `12841963125`, `3761234905`
- **Canonical:** — (nuance register)

### R52-020 — The stated cap moved: inside PAY_CAP5/PAY_WALL reviewers name '5 habits' in every year 2018–2025 (174 mentions, text sub-cut) but also '4' (2017–2018, 2020–2024), '3' (2020–2021, 2025), '6' (2018), '8' (2025) and '10' (2020, 2021, 2025, 2026) — reviewers are describing different builds and cohorts

- **Where:** §0.2 bullet 'The stated cap moved'
- **This app does:** cap changed across builds and cohorts
- **User reaction:** mixed
- **Magnitude:** 174 '5 habits' mentions; 4 / 3 / 6 / 8 / 10 also stated
- **Direction for us:** none · **Report confidence:** text sub-cut · **Generalisable:** app-specific
- **Review IDs:** `13289981450`, `14081265840`
- **Canonical:** — (nuance register)

### R52-061 — Complete global theme table — all 123 codes (verbatim)

- **Where:** §3.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** # | Theme | Family | Direction | n | % of 20,634 | Band | Mean ★ | 1/2/3/4/5 | Storefronts | First → last ; 1 | META_LOWINFO | META | context | 4,760 | 23.07% | High-priority | 4.79 | 64/21/117/427/4131 | 21 | 2017-08-03 → 2026-09-04 ; 2 | DES_CLEAN | DES | positive | 1,716 | 8.32% | High-priority | 4.84 | 5/2/25/197/1487 | 20 | 2017-08-03 → 2026-09-05 ; 3 | DES_CUTE | DES | positive | 1,431 | 6.94% | High-priority | 4.77 | 2/10/39/218/1162 | 19 | 2017-08-09 → 2026-08-17 ; 4 | PAY_BOUGHT | PAY | mixed | 1,286 | 6.23% | High-priority | 4.11 | 168/48/77/178/815 | 12 | 2017-08-03 → 2026-09-04 ; 5 | PAY_CAP5 | PAY | negative | 888 | 4.30% | Very strong | 2.96 | 257/98/154/180/199 | 12 | 2017-09-21 → 2026-08-24 ; 6 | AD_NEG | PAY | negative | 885 | 4.29% | Very strong | 2.46 | 383/103/139/128/132 | 10 | 2018-12-27 → 2026-09-04 ; 7 | OUT_DISCIPLINE | OUT | positive | 761 | 3.69% | Very strong | 4.90 | 0/0/7/59/695 | 9 | 2017-09-24 → 2026-08-25 ; 8 | META_PREUSE | META | context | 717 | 3.47% | Very strong | 4.49 | 11/6/52/203/445 | 7 | 2017-09-22 → 2026-07-27 ; 9 | PAY_WALL | PAY | negative | 715 | 3.47% | Very strong | 2.62 | 298/74/106/73/164 | 8 | 2017-09-21 → 2026-09-04 ; 10 | USER_LONGTERM | OUT | context | 705 | 3.42% | Very strong | 4.63 | 34/14/16/48/593 | 12 | 2017-11-05 → 2026-09-06 ; 11 | JRNL_WANT | INS | request / unmet need | 668 | 3.24% | Very strong | 4.36 | 19/12/66/184/387 | 9 | 2017-09-10 → 2026-09-04 ; 12 | BUG_FEATURE | REL | negative | 647 | 3.14% | Very strong | 3.56 | 113/40/101/160/233 | 13 | 2017-08-10 → 2026-08-27 ; 13 | REM_WANT | REM | request / unmet need | 588 | 2.85% | Meaningful | 4.36 | 11/11/56/187/323 | 6 | 2017-08-03 → 2026-09-06 ; 14 | DES_ICON_WANT | DES | request / unmet need | 561 | 2.72% | Meaningful | 4.49 | 7/9/40/149/356 | 13 | 2017-08-03 → 2026-09-06 ; 15 | BUG_UPDATE | REL | negative | 524 | 2.54% | Meaningful | 3.26 | 131/40/82/104/167 | 10 | 2017-09-27 → 2026-09-04 ; 16 | STAT_WANT | INS | request / unmet need | 478 | 2.32% | Meaningful | 4.37 | 13/6/37/155/267 | 10 | 2017-09-27 → 2026-09-06 ; 17 | META_UNLOCK | META | context | 462 | 2.24% | Meaningful | 4.16 | 27/12/52/138/233 | 2 | 2017-09-20 → 2025-08-21 ; 18 | PLAT_WIDGET_BUG | PLAT | negative | 454 | 2.20% | Meaningful | 3.91 | 46/22/64/115/207 | 8 | 2017-12-16 → 2026-09-04 ; 19 | PAY_LIFETIME | PAY | mixed | 432 | 2.09% | Meaningful | 3.97 | 74/12/33/48/265 | 9 | 2017-10-01 → 2026-08-27 ; 20 | DES_PRETTY | DES | positive | 429 | 2.08% | Meaningful | 4.75 | 6/2/11/54/356 | 15 | 2017-08-03 → 2026-09-01 ; 21 | DES_DENSE | DES | negative | 427 | 2.07% | Meaningful | 3.63 | 75/18/58/114/162 | 11 | 2017-10-24 → 2026-09-04 ; 22 | BUG_CRASH | REL | negative | 412 | 2.00% | Meaningful | 3.22 | 112/26/69/69/136 | 6 | 2017-10-16 → 2026-08-23 ; 23 | REQ_OTHER | META | request / unmet need | 395 | 1.91% | Meaningful | 4.47 | 6/7/31/104/247 | 12 | 2017-10-19 → 2026-09-05 ; 24 | FOCUS | INS | mixed | 390 | 1.89% | Meaningful | 4.35 | 13/11/33/102/231 | 8 | 2017-10-12 → 2026-09-02 ; 25 | PLAT_IPAD | PLAT | request / unmet need | 380 | 1.84% | Meaningful | 4.09 | 35/9/43/92/201 | 8 | 2017-10-09 → 2026-05-15 ; 26 | DES_REDESIGN | DES | negative | 372 | 1.80% | Meaningful | 3.39 | 89/25/47/75/136 | 7 | 2019-01-24 → 2026-09-04 ; 27 | USER_SWITCH | OUT | context | 355 | 1.72% | Meaningful | 4.47 | 19/9/17/51/259 | 13 | 2017-09-07 → 2026-09-06 ; 28 | DES_THEME | DES | mixed | 343 | 1.66% | Meaningful | 4.47 | 13/5/28/58/239 | 7 | 2017-11-30 → 2026-07-20 ; 29 | DES_ICON_LIKE | DES | positive | 321 | 1.56% | Meaningful | 4.78 | 2/0/10/44/265 | 10 | 2017-08-10 → 2026-07-31 ; 30 | STAT_REWARD | INS | positive | 312 | 1.51% | Meaningful | 4.65 | 5/2/11/61/233 | 10 | 2017-10-21 → 2026-08-28 ; 31 | CORE_TODO | CORE | mixed | 307 | 1.49% | Meaningful | 4.50 | 5/5/24/71/202 | 11 | 2017-10-03 → 2026-09-04 ; 32 | CORE_FREQ | CORE | request / unmet need | 299 | 1.45% | Meaningful | 4.55 | 4/5/11/82/197 | 6 | 2017-08-10 → 2026-08-21 ; 33 | META_RECOMMEND | META | positive | 289 | 1.40% | Meaningful | 4.93 | 2/0/1/9/277 | 13 | 2017-09-26 → 2026-09-06 ; 34 | REM_FAIL | REM | negative | 279 | 1.35% | Meaningful | 3.45 | 55/16/47/70/91 | 6 | 2017-10-14 → 2026-06-18 ; 35 | PAY_BILLING | PAY | negative | 261 | 1.26% | Meaningful | 3.51 | 62/10/31/50/108 | 11 | 2017-11-28 → 2026-08-29 ; 36 | PAY_PRICE_OK | PAY | positive | 256 | 1.24% | Meaningful | 4.86 | 0/0/5/26/225 | 11 | 2017-08-03 → 2026-09-04 ; 37 | PLAT_WATCH | PLAT | request / unmet need | 256 | 1.24% | Meaningful | 4.52 | 5/6/10/65/170 | 15 | 2017-12-02 → 2026-08-19 ; 38 | PAY_PRICE_HIGH | PAY | negative | 254 | 1.23% | Meaningful | 3.28 | 61/18/42/54/79 | 4 | 2017-10-25 → 2026-09-03 ; 39 | PLAT_WIDGET_WANT | PLAT | request / unmet need | 240 | 1.16% | Meaningful | 4.48 | 3/6/18/59/154 | 7 | 2017-09-24 → 2026-08-14 ; 40 | CORE_MULTI | CORE | request / unmet need | 237 | 1.15% | Meaningful | 4.44 | 6/2/10/82/137 | 6 | 2017-09-17 → 2026-08-28 ; 41 | JRNL_GOOD | INS | positive | 234 | 1.13% | Meaningful | 4.85 | 1/1/4/21/207 | 6 | 2017-10-14 → 2026-09-05 ; 42 | USER_CROSSAPP | OUT | context | 230 | 1.11% | Meaningful | 4.57 | 13/2/9/24/182 | 7 | 2017-08-03 → 2026-09-07 ; 43 | DATA_LOSS | DATA | negative | 229 | 1.11% | Meaningful | 2.73 | 85/18/44/37/45 | 8 | 2017-11-03 → 2026-08-19 ; 44 | CORE_RETRO | CORE | request / unmet need | 218 | 1.06% | Meaningful | 4.18 | 16/8/16/59/119 | 4 | 2017-10-09 → 2026-08-05 ; 45 | CORE_CHECK | CORE | positive | 217 | 1.05% | Meaningful | 4.87 | 0/0/3/22/192 | 10 | 2017-08-13 → 2026-08-19 ; 46 | DEV_TRUST | REL | positive | 213 | 1.03% | Meaningful | 4.93 | 1/1/0/7/204 | 7 | 2017-09-07 → 2026-09-05 ; 47 | DATA_ACCOUNT | DATA | negative | 200 | 0.97% | Emerging | 3.40 | 49/7/33/36/75 | 2 | 2017-11-07 → 2026-08-18 ; 48 | PLAT_ANDROID | PLAT | request / unmet need | 195 | 0.95% | Emerging | 3.53 | 42/15/23/27/88 | 3 | 2017-08-29 → 2026-08-26 ; 49 | CARD_BUG | INS | negative | 193 | 0.94% | Emerging | 3.96 | 17/6/32/50/88 | 4 | 2017-08-29 → 2026-09-01 ; 50 | OUT_FITNESS | OUT | positive | 190 | 0.92% | Emerging | 4.80 | 1/1/6/19/163 | 4 | 2017-10-03 → 2026-08-24 ; 51 | PAY_RESTORE | PAY | negative | 190 | 0.92% | Emerging | 2.61 | 78/20/33/16/43 | 3 | 2018-02-27 → 2026-08-26 ; 52 | REM_GOOD | REM | positive | 185 | 0.90% | Emerging | 4.88 | 0/0/2/18/165 | 6 | 2017-09-20 → 2026-08-24 ; 53 | SUP_BAD | REL | negative | 184 | 0.89% | Emerging | 2.33 | 94/20/17/22/31 | 6 | 2017-11-05 → 2026-08-23 ; 54 | PAY_SCAM | PAY | negative | 183 | 0.89% | Emerging | 1.36 | 158/9/2/3/11 | 3 | 2017-10-01 → 2026-06-20 ; 55 | BUG_DISPLAY | REL | negative | 181 | 0.88% | Emerging | 3.83 | 20/8/28/52/73 | 6 | 2017-09-25 → 2026-09-02 ; 56 | CORE_GOAL | CORE | mixed | 180 | 0.87% | Emerging | 4.55 | 3/1/9/48/119 | 5 | 2017-10-30 → 2026-07-11 ; 57 | AD_NONE_PRAISE | PAY | positive | 172 | 0.83% | Emerging | 4.90 | 1/0/2/10/159 | 3 | 2017-10-17 → 2026-08-27 ; 58 | OUT_LIFE | OUT | positive | 168 | 0.81% | Emerging | 4.93 | 0/0/1/9/158 | 9 | 2017-09-21 → 2026-08-27 ; 59 | DES_COLOR | DES | mixed | 166 | 0.80% | Emerging | 4.65 | 1/0/9/36/120 | 7 | 2017-08-03 → 2026-08-21 ; 60 | CORE_SEGMENT | CORE | mixed | 159 | 0.77% | Emerging | 3.99 | 14/8/19/42/76 | 6 | 2017-09-15 → 2026-07-05 ; 61 | CORE_TIMEPLAN | CORE | mixed | 156 | 0.76% | Emerging | 4.38 | 4/3/13/45/91 | 2 | 2017-10-12 → 2026-08-09 ; 62 | REM_ANNOY | REM | negative | 155 | 0.75% | Emerging | 3.26 | 36/11/33/27/48 | 6 | 2020-07-13 → 2026-05-18 ; 63 | STAT_GOOD | INS | positive | 155 | 0.75% | Emerging | 4.90 | 0/0/2/11/142 | 8 | 2017-08-09 → 2026-08-28 ; 64 | CARD_WANT | INS | request / unmet need | 154 | 0.75% | Emerging | 4.40 | 5/5/9/40/95 | 3 | 2017-08-08 → 2026-05-07 ; 65 | LOC_UNTRANS | LOC | negative | 153 | 0.74% | Emerging | 3.25 | 32/14/27/44/36 | 25 | 2018-04-05 → 2026-09-05 ; 66 | CORE_ORDER | CORE | request / unmet need | 151 | 0.73% | Emerging | 4.16 | 10/5/17/38/81 | 6 | 2017-09-15 → 2026-08-21 ; 67 | DATA_SYNC_FAIL | DATA | negative | 151 | 0.73% | Emerging | 3.23 | 36/9/28/41/37 | 6 | 2017-12-06 → 2026-08-09 ; 68 | SUP_GOOD | REL | positive | 148 | 0.72% | Emerging | 4.93 | 0/0/0/11/137 | 5 | 2017-10-17 → 2026-08-19 ; 69 | PAY_FREEDEMAND | PAY | negative | 147 | 0.71% | Emerging | 3.43 | 33/9/24/24/57 | 5 | 2017-10-20 → 2026-08-03 ; 70 | CORE_ARCHIVE | CORE | mixed | 133 | 0.64% | Emerging | 3.99 | 11/7/16/37/62 | 4 | 2017-09-17 → 2026-06-18 ; 71 | DATA_BACKUP | DATA | mixed | 133 | 0.64% | Emerging | 3.73 | 23/6/16/27/61 | 3 | 2017-10-01 → 2026-08-16 ; 72 | BUG_LAG | REL | negative | 132 | 0.64% | Emerging | 3.08 | 38/11/22/24/37 | 7 | 2017-10-04 → 2026-08-19 ; 73 | DATA_SYNC_WANT | DATA | request / unmet need | 132 | 0.64% | Emerging | 4.31 | 6/5/11/30/80 | 5 | 2017-10-01 → 2026-08-16 ; 74 | USER_STUDENT | OUT | context | 123 | 0.60% | Emerging | 4.15 | 12/5/12/18/76 | 3 | 2017-10-20 → 2026-08-10 ; 75 | SOC_NOSOCIAL | SOC | positive | 120 | 0.58% | Emerging | 4.85 | 0/0/2/14/104 | 1 | 2017-09-20 → 2026-08-24 ; 76 | DES_ANIM | DES | mixed | 115 | 0.56% | Emerging | 4.66 | 3/1/4/16/91 | 6 | 2017-10-17 → 2026-07-31 ; 77 | OUT_STUDY | OUT | positive | 115 | 0.56% | Emerging | 4.83 | 0/2/3/8/102 | 4 | 2017-09-20 → 2026-08-28 ; 78 | PAY_TIERS | PAY | negative | 113 | 0.55% | Emerging | 3.53 | 23/7/14/25/44 | 3 | 2017-10-01 → 2026-08-26 ; 79 | OUT_PROCRAST | OUT | positive | 107 | 0.52% | Emerging | 4.89 | 0/1/0/9/97 | 4 | 2017-08-10 → 2026-06-19 ; 80 | CARD_GOOD | INS | positive | 106 | 0.51% | Emerging | 4.83 | 0/0/2/14/90 | 8 | 2017-08-09 → 2026-08-16 ; 81 | STAT_STREAK | INS | mixed | 106 | 0.51% | Emerging | 4.00 | 14/4/9/20/59 | 5 | 2017-11-12 → 2026-09-06 ; 82 | DES_NEG | DES | negative | 102 | 0.49% | Weak | 3.62 | 16/4/16/33/33 | 3 | 2017-09-29 → 2026-08-12 ; 83 | SUP_ASK | REL | request / unmet need | 102 | 0.49% | Weak | 4.35 | 4/3/9/23/63 | 2 | 2017-08-29 → 2026-07-05 ; 84 | LOC_WANT | LOC | request / unmet need | 99 | 0.48% | Weak | 3.63 | 14/8/19/18/40 | 15 | 2018-04-21 → 2026-07-22 ; 85 | PAY_SUB_NEG | PAY | negative | 97 | 0.47% | Weak | 3.01 | 31/7/15/18/26 | 7 | 2018-05-21 → 2026-09-04 ; 86 | CORE_QUANT | CORE | request / unmet need | 90 | 0.44% | Weak | 4.46 | 3/2/6/19/60 | 3 | 2017-10-22 → 2026-08-19 ; 87 | DES_FONT | DES | request / unmet need | 87 | 0.42% | Weak | 4.53 | 2/1/5/20/59 | 7 | 2017-09-13 → 2026-07-14 ; 88 | CORE_ROUTINE | CORE | mixed | 80 | 0.39% | Weak | 4.56 | 3/0/4/15/58 | 7 | 2017-11-04 → 2026-09-06 ; 89 | PAY_REGRESS | PAY | negative | 75 | 0.36% | Weak | 2.15 | 41/9/9/5/11 | 2 | 2018-06-14 → 2026-08-20 ; 90 | SOC_FRIEND | SOC | request / unmet need | 74 | 0.36% | Weak | 4.42 | 2/1/11/10/50 | 4 | 2017-12-04 → 2025-11-04 ; 91 | META_CONTRA | META | context | 73 | 0.35% | Weak | 3.26 | 24/7/3/4/35 | 4 | 2017-09-27 → 2026-08-08 ; 92 | PAY_TRIAL | PAY | mixed | 71 | 0.34% | Weak | 3.18 | 19/8/11/7/26 | 5 | 2018-01-02 → 2026-08-20 ; 93 | DES_DARK | DES | request / unmet need | 70 | 0.34% | Weak | 3.89 | 7/1/14/19/29 | 6 | 2019-10-11 → 2026-08-11 ; 94 | DATA_PRIVACY | DATA | negative | 65 | 0.32% | Weak | 3.48 | 19/1/6/8/31 | 4 | 2017-10-23 → 2026-08-08 ; 95 | CORE_SUBTASK | CORE | request / unmet need | 62 | 0.30% | Weak | 4.45 | 1/0/6/18/37 | 4 | 2017-10-09 → 2026-08-09 ; 96 | DATA_EXPORT | DATA | request / unmet need | 59 | 0.29% | Weak | 4.46 | 2/1/4/13/39 | 1 | 2018-02-09 → 2026-09-01 ; 97 | CORE_BADHABIT | CORE | mixed | 57 | 0.28% | Weak | 4.81 | 0/0/0/11/46 | 3 | 2017-09-29 → 2026-07-12 ; 98 | OUT_MENTAL | OUT | positive | 57 | 0.28% | Weak | 4.91 | 0/0/0/5/52 | 4 | 2017-09-20 → 2026-04-05 ; 99 | SOC_SHARE | SOC | request / unmet need | 53 | 0.26% | Weak | 4.23 | 5/2/4/7/35 | 3 | 2017-08-08 → 2026-04-24 ; 100 | PLAT_OS | PLAT | negative | 49 | 0.24% | Weak | 3.55 | 10/2/6/13/18 | 2 | 2017-09-06 → 2026-07-21 ; 101 | PLAT_WIDGET_GOOD | PLAT | positive | 48 | 0.23% | Weak | 4.79 | 0/1/2/3/42 | 7 | 2018-04-09 → 2026-07-25 ; 102 | CORE_SEARCH | CORE | request / unmet need | 46 | 0.22% | Weak | 4.30 | 3/0/3/14/26 | 4 | 2017-11-17 → 2026-05-11 ; 103 | PAY_PRICE_RISE | PAY | negative | 42 | 0.20% | Weak | 3.19 | 13/3/5/5/16 | 1 | 2018-03-26 → 2026-06-14 ; 104 | PLAT_CAL | PLAT | request / unmet need | 41 | 0.20% | Weak | 4.12 | 1/1/6/17/16 | 3 | 2018-01-12 → 2026-08-15 ; 105 | LOC_CULTURE | LOC | context | 38 | 0.18% | Weak | 4.18 | 3/2/1/11/21 | 4 | 2017-11-29 → 2026-02-16 ; 106 | META_FAKE | META | negative | 37 | 0.18% | Weak | 2.27 | 20/4/4/1/8 | 3 | 2017-10-09 → 2025-07-02 ; 107 | PLAT_MAC | PLAT | request / unmet need | 37 | 0.18% | Weak | 3.81 | 5/1/7/7/17 | 4 | 2018-03-07 → 2026-08-09 ; 108 | PAY_REFUND | PAY | negative | 32 | 0.16% | Weak | 1.91 | 20/5/2/0/5 | 2 | 2018-04-03 → 2026-08-23 ; 109 | PAY_DISCOUNT | PAY | request / unmet need | 31 | 0.15% | Weak | 3.94 | 5/1/3/4/18 | 3 | 2017-10-28 → 2026-02-27 ; 110 | STAT_ACHIEVE | INS | mixed | 31 | 0.15% | Weak | 4.45 | 1/1/1/8/20 | 1 | 2017-08-09 → 2025-03-22 ; 111 | DEV_ABANDON | REL | negative | 27 | 0.13% | Weak | 3.22 | 8/1/4/5/9 | 2 | 2017-12-28 → 2026-07-12 ; 112 | META_EDIT | META | context | 27 | 0.13% | Weak | 4.04 | 3/1/3/5/15 | 6 | 2017-10-28 → 2025-04-22 ; 113 | AD_CROSSPROMO | PAY | negative | 26 | 0.13% | Weak | 3.35 | 6/3/2/6/9 | 2 | 2017-12-13 → 2021-03-08 ; 114 | SOC_GROUP_GOOD | SOC | positive | 26 | 0.13% | Weak | 4.65 | 0/0/3/3/20 | 2 | 2018-04-26 → 2026-03-12 ; 115 | STAT_PENALTY | INS | request / unmet need | 21 | 0.10% | Weak | 4.86 | 0/0/0/3/18 | 1 | 2017-09-22 → 2026-08-05 ; 116 | LOC_WORKAROUND | LOC | context | 19 | 0.09% | Ignore | 4.47 | 0/0/1/8/10 | 6 | 2018-08-20 → 2025-07-23 ; 117 | PLAT_SIRI | PLAT | request / unmet need | 15 | 0.07% | Ignore | 4.40 | 0/1/1/4/9 | 2 | 2017-10-23 → 2026-02-19 ; 118 | CARD_LIMIT | INS | negative | 14 | 0.07% | Ignore | 4.50 | 0/0/2/3/9 | 1 | 2017-09-16 → 2022-12-10 ; 119 | LOC_ENGBAD | LOC | negative | 11 | 0.05% | Ignore | 4.18 | 0/1/1/4/5 | 5 | 2020-01-09 → 2022-09-03 ; 120 | PLAT_HEALTH | PLAT | request / unmet need | 7 | 0.03% | Ignore | 4.43 | 0/0/1/2/4 | 2 | 2018-02-08 → 2026-05-28 ; 121 | OUT_ADHD | OUT | positive | 6 | 0.03% | Ignore | 4.83 | 0/0/0/1/5 | 3 | 2018-10-02 → 2025-09-14 ; 122 | AD_REWARD | PAY | mixed | 3 | 0.01% | Ignore | 4.00 | 0/0/1/1/1 | 1 | 2020-02-25 → 2021-08-31 ; 123 | SOC_GROUP_NEG | SOC | negative | 0 | 0.00% | Ignore | — | 0/0/0/0/0 | 0 | —
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-062 — Composite unions, each review counted once (verbatim)

- **Where:** §3.2 unions table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Union | Codes | n | % of 20,634 | Band | Mean ★ | 1/2/3/4/5 ; No product experience | META_LOWINFO META_PREUSE META_UNLOCK | 5,479 | 26.55% | High-priority | 4.73 | 94/32/177/637/4539 ; Any feature request | 16 request codes (icons, journal, reminders, stats, widget, watch, cards, sync, other, language, friends, frequency, multi, retro, subtasks, order) | 4,160 | 20.16% | High-priority | 4.38 | 120/88/346/1133/2473 ; Aesthetic praise | DES_CUTE DES_CLEAN DES_PRETTY DES_ICON_LIKE | 3,537 | 17.14% | High-priority | 4.80 | 14/14/81/464/2964 ; Reliability failure | BUG_* (5) + PLAT_WIDGET_BUG DATA_SYNC_FAIL DATA_LOSS REM_FAIL CARD_BUG | 2,608 | 12.64% | High-priority | 3.49 | 506/162/414/600/926 ; Monetization friction | PAY_CAP5 PAY_WALL PAY_PRICE_HIGH PAY_SUB_NEG PAY_PRICE_RISE PAY_REGRESS PAY_RESTORE PAY_REFUND PAY_BILLING PAY_TRIAL PAY_FREEDEMAND PAY_SCAM PAY_TIERS | 2,496 | 12.10% | High-priority | 2.98 | 810/216/372/400/698 ; Reported outcome | OUT_* (7) | 1,340 | 6.49% | High-priority | 4.88 | 1/4/17/108/1210 ; Paid (first-person purchase) | PAY_BOUGHT | 1,286 | 6.23% | High-priority | 4.11 | 168/48/77/178/815 ; Ads negative | AD_NEG | 885 | 4.29% | Very strong | 2.46 | 383/103/139/128/132 ; Other devices asked for | PLAT_WATCH PLAT_IPAD PLAT_MAC PLAT_ANDROID | 835 | 4.05% | Very strong | 4.09 | 83/29/81/183/459 ; Interface regression | DES_REDESIGN DES_DENSE DES_NEG | 824 | 3.99% | Very strong | 3.58 | 155/41/108/207/313 ; Entitlement broken | PAY_REGRESS PAY_RESTORE PAY_BILLING PAY_REFUND PAY_PRICE_RISE | 573 | 2.78% | Meaningful | 2.96 | 200/45/78/76/174 ; Data integrity | DATA_LOSS DATA_SYNC_FAIL PAY_RESTORE | 518 | 2.51% | Meaningful | 2.85 | 177/42/94/90/115
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-063 — Family totals, a review counts once per family (verbatim) — DES 5,141 (24.92%, 4.55), META 6,253 (30.30%), PAY 4,758 (23.06%, mean 3.34), REL 2,264 (10.97%, 3.61), DATA 818 (3.96%, 3.49), LOC 275 (1.33%, 3.58), SOC 260 (1.26%, 4.60)

- **Where:** §3.2 family table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Family | Name | Codes | Reviews with ≥1 code | % of 20,634 | Band | Mean ★ | 1/2/3/4/5 ; DES | Design, aesthetics and interface | 13 | 5,141 | 24.92% | High-priority | 4.55 | 194/67/246/856/3778 ; CORE | Core habit tracking mechanics | 15 | 2,196 | 10.64% | High-priority | 4.43 | 76/42/142/541/1395 ; REM | Reminders and notifications | 4 | 1,164 | 5.64% | High-priority | 4.09 | 100/37/132/284/611 ; PLAT | Platforms and surfaces | 11 | 1,626 | 7.88% | High-priority | 4.11 | 139/59/170/380/878 ; DATA | Data, sync and account | 7 | 818 | 3.96% | Very strong | 3.49 | 182/38/114/162/322 ; INS | Insight, motivation and logging | 13 | 2,620 | 12.70% | High-priority | 4.43 | 87/46/198/617/1672 ; SOC | Social and accountability | 5 | 260 | 1.26% | Meaningful | 4.60 | 7/2/18/33/200 ; PAY | Monetization | 21 | 4,758 | 23.06% | High-priority | 3.34 | 1259/338/563/705/1893 ; REL | Reliability and support | 10 | 2,264 | 10.97% | High-priority | 3.61 | 437/131/292/430/974 ; LOC | Localization and language | 5 | 275 | 1.33% | Meaningful | 3.58 | 43/22/41/71/98 ; OUT | Reported outcomes and user identity | 11 | 2,603 | 12.62% | High-priority | 4.70 | 74/34/68/240/2187 ; META | Review intent and integrity | 8 | 6,253 | 30.30% | High-priority | 4.70 | 144/48/217/750/5094
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-084 — Mixed themes, direction depends on the reviewer (verbatim): PAY_BOUGHT 1,286 — 815 × 5★ and 168 × 1★; PAY_LIFETIME 432 (2.09%, 3.97) — praise for a one-time option, demands for it, anger when withdrawn; FOCUS 390 — liked as all-in-one, 2026 focus-page redesign and timer bugs; CORE_SEGMENT 159 (0.77%, 3.99) — time-of-day scenes loved and confusing ('two + buttons'); STAT_STREAK 106 (0.51%, 4.00) — motivating ('600 days') but streak resets after bugs enrage; CORE_TODO 307 (1.49%, 4.50) — welcomed (2024) but sorting and hiding regressions; USER_SWITCH 355 (1.72%, 4.47) — mostly 'I tried ten apps, this one stuck', a minority leaving

- **Where:** §3.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % | Band | Mean ★ | Why mixed | IDs ; PAY_BOUGHT | 1,286 | 6.23% | High-priority | 4.11 | 815 × 5★ and 168 × 1★ — purchase is praise or grievance depending on what happened next (§6) | 5234243491 9932746241 ; PAY_LIFETIME | 432 | 2.09% | Meaningful | 3.97 | Praise for a one-time option; also demands for it, and anger when it was withdrawn | 3291064932 6268143177 ; FOCUS | 390 | 1.89% | Meaningful | 4.35 | Liked as an all-in-one feature; 2026 focus-page redesign and timer bugs | 14466033004 14381653023 ; CORE_SEGMENT | 159 | 0.77% | Emerging | 3.99 | Time-of-day scenes are the structure people love, and also confusing ("two + buttons", 8790365200) | 10229830471 8790365200 ; STAT_STREAK | 106 | 0.51% | Emerging | 4.00 | Motivating ("600 days", 13983550843), but streak resets after bugs enrage | 3115814668 12914673906 ; CORE_TODO | 307 | 1.49% | Meaningful | 4.50 | Welcomed addition (2024), but sorting and hiding regressions (12062367782) | 14453965506 12062367782 ; USER_SWITCH | 355 | 1.72% | Meaningful | 4.47 | Mostly "I tried ten apps, this one stuck"; a minority leaving | 12806346802 8818193734
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `5234243491`, `9932746241`, `3291064932`, `6268143177`, `10229830471`, `8790365200`, `3115814668`, `12914673906`, `14453965506`, `12062367782`, `12806346802`, `8818193734`, `13983550843`
- **Canonical:** — (nuance register)

### R52-104 — What is not a finding: trial complaints (PAY_TRIAL 71, 0.34%) weak until 2026 — watch; Apple Health (PLAT_HEALTH 7), Siri/Shortcuts (PLAT_SIRI 15), achievements (STAT_ACHIEVE 31) and groups (SOC_GROUP_GOOD 26) below or near the ignore line; ADHD 6

- **Where:** §3.7
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** PLAT_HEALTH 7; PLAT_SIRI 15; STAT_ACHIEVE 31; SOC_GROUP_GOOD 26
- **Direction for us:** none · **Report confidence:** ignore / weak · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-129 — Rating band 5★ n=13,415 (65.01%) theme table (verbatim)

- **Where:** Part 5 5★ table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n in band | Segment rate (of this band) | Global n | Share of theme's reviews in this band ; META_LOWINFO | context | 4,131 | 30.8% | 4,760 | 86.8% ; DES_CLEAN | positive | 1,487 | 11.1% | 1,716 | 86.7% ; DES_CUTE | positive | 1,162 | 8.7% | 1,431 | 81.2% ; PAY_BOUGHT | mixed | 815 | 6.1% | 1,286 | 63.4% ; OUT_DISCIPLINE | positive | 695 | 5.2% | 761 | 91.3% ; USER_LONGTERM | context | 593 | 4.4% | 705 | 84.1% ; META_PREUSE | context | 445 | 3.3% | 717 | 62.1% ; JRNL_WANT | request / unmet need | 387 | 2.9% | 668 | 57.9% ; DES_PRETTY | positive | 356 | 2.7% | 429 | 83.0% ; DES_ICON_WANT | request / unmet need | 356 | 2.7% | 561 | 63.5% ; REM_WANT | request / unmet need | 323 | 2.4% | 588 | 54.9% ; META_RECOMMEND | positive | 277 | 2.1% | 289 | 95.8% ; STAT_WANT | request / unmet need | 267 | 2.0% | 478 | 55.9% ; DES_ICON_LIKE | positive | 265 | 2.0% | 321 | 82.6% ; PAY_LIFETIME | mixed | 265 | 2.0% | 432 | 61.3% ; USER_SWITCH | context | 259 | 1.9% | 355 | 73.0% ; REQ_OTHER | request / unmet need | 247 | 1.8% | 395 | 62.5% ; DES_THEME | mixed | 239 | 1.8% | 343 | 69.7%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-130 — Rating band 4★ n=3,278 (15.89%) theme table (verbatim)

- **Where:** Part 5 4★ table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n in band | Segment rate (of this band) | Global n | Share of theme's reviews in this band ; META_LOWINFO | context | 427 | 13.0% | 4,760 | 9.0% ; DES_CUTE | positive | 218 | 6.7% | 1,431 | 15.2% ; META_PREUSE | context | 203 | 6.2% | 717 | 28.3% ; DES_CLEAN | positive | 197 | 6.0% | 1,716 | 11.5% ; REM_WANT | request / unmet need | 187 | 5.7% | 588 | 31.8% ; JRNL_WANT | request / unmet need | 184 | 5.6% | 668 | 27.5% ; PAY_CAP5 | negative | 180 | 5.5% | 888 | 20.3% ; PAY_BOUGHT | mixed | 178 | 5.4% | 1,286 | 13.8% ; BUG_FEATURE | negative | 160 | 4.9% | 647 | 24.7% ; STAT_WANT | request / unmet need | 155 | 4.7% | 478 | 32.4% ; DES_ICON_WANT | request / unmet need | 149 | 4.5% | 561 | 26.6% ; META_UNLOCK | context | 138 | 4.2% | 462 | 29.9% ; AD_NEG | negative | 128 | 3.9% | 885 | 14.5% ; PLAT_WIDGET_BUG | negative | 115 | 3.5% | 454 | 25.3% ; DES_DENSE | negative | 114 | 3.5% | 427 | 26.7% ; BUG_UPDATE | negative | 104 | 3.2% | 524 | 19.8% ; REQ_OTHER | request / unmet need | 104 | 3.2% | 395 | 26.3% ; FOCUS | mixed | 102 | 3.1% | 390 | 26.2%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-131 — Rating band 3★ n=1,498 (7.26%) theme table (verbatim)

- **Where:** Part 5 3★ table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n in band | Segment rate (of this band) | Global n | Share of theme's reviews in this band ; PAY_CAP5 | negative | 154 | 10.3% | 888 | 17.3% ; AD_NEG | negative | 139 | 9.3% | 885 | 15.7% ; META_LOWINFO | context | 117 | 7.8% | 4,760 | 2.5% ; PAY_WALL | negative | 106 | 7.1% | 715 | 14.8% ; BUG_FEATURE | negative | 101 | 6.7% | 647 | 15.6% ; BUG_UPDATE | negative | 82 | 5.5% | 524 | 15.6% ; PAY_BOUGHT | mixed | 77 | 5.1% | 1,286 | 6.0% ; BUG_CRASH | negative | 69 | 4.6% | 412 | 16.7% ; JRNL_WANT | request / unmet need | 66 | 4.4% | 668 | 9.9% ; PLAT_WIDGET_BUG | negative | 64 | 4.3% | 454 | 14.1% ; DES_DENSE | negative | 58 | 3.9% | 427 | 13.6% ; REM_WANT | request / unmet need | 56 | 3.7% | 588 | 9.5% ; META_PREUSE | context | 52 | 3.5% | 717 | 7.3% ; META_UNLOCK | context | 52 | 3.5% | 462 | 11.3% ; REM_FAIL | negative | 47 | 3.1% | 279 | 16.8% ; DES_REDESIGN | negative | 47 | 3.1% | 372 | 12.6% ; DATA_LOSS | negative | 44 | 2.9% | 229 | 19.2% ; PLAT_IPAD | request / unmet need | 43 | 2.9% | 380 | 11.3%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-132 — Rating band 2★ n=570 (2.76%) theme table (verbatim)

- **Where:** Part 5 2★ table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n in band | Segment rate (of this band) | Global n | Share of theme's reviews in this band ; AD_NEG | negative | 103 | 18.1% | 885 | 11.6% ; PAY_CAP5 | negative | 98 | 17.2% | 888 | 11.0% ; PAY_WALL | negative | 74 | 13.0% | 715 | 10.3% ; PAY_BOUGHT | mixed | 48 | 8.4% | 1,286 | 3.7% ; BUG_FEATURE | negative | 40 | 7.0% | 647 | 6.2% ; BUG_UPDATE | negative | 40 | 7.0% | 524 | 7.6% ; BUG_CRASH | negative | 26 | 4.6% | 412 | 6.3% ; DES_REDESIGN | negative | 25 | 4.4% | 372 | 6.7% ; PLAT_WIDGET_BUG | negative | 22 | 3.9% | 454 | 4.8% ; META_LOWINFO | context | 21 | 3.7% | 4,760 | 0.4% ; PAY_RESTORE | negative | 20 | 3.5% | 190 | 10.5% ; SUP_BAD | negative | 20 | 3.5% | 184 | 10.9% ; DATA_LOSS | negative | 18 | 3.2% | 229 | 7.9% ; DES_DENSE | negative | 18 | 3.2% | 427 | 4.2% ; PAY_PRICE_HIGH | negative | 18 | 3.2% | 254 | 7.1% ; REM_FAIL | negative | 16 | 2.8% | 279 | 5.7% ; PLAT_ANDROID | request / unmet need | 15 | 2.6% | 195 | 7.7% ; LOC_UNTRANS | negative | 14 | 2.5% | 153 | 9.2%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-133 — Rating band 1★ n=1,873 (9.08%) theme table (verbatim)

- **Where:** Part 5 1★ table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Theme | Direction | n in band | Segment rate (of this band) | Global n | Share of theme's reviews in this band ; AD_NEG | negative | 383 | 20.4% | 885 | 43.3% ; PAY_WALL | negative | 298 | 15.9% | 715 | 41.7% ; PAY_CAP5 | negative | 257 | 13.7% | 888 | 28.9% ; PAY_BOUGHT | mixed | 168 | 9.0% | 1,286 | 13.1% ; PAY_SCAM | negative | 158 | 8.4% | 183 | 86.3% ; BUG_UPDATE | negative | 131 | 7.0% | 524 | 25.0% ; BUG_FEATURE | negative | 113 | 6.0% | 647 | 17.5% ; BUG_CRASH | negative | 112 | 6.0% | 412 | 27.2% ; SUP_BAD | negative | 94 | 5.0% | 184 | 51.1% ; DES_REDESIGN | negative | 89 | 4.8% | 372 | 23.9% ; DATA_LOSS | negative | 85 | 4.5% | 229 | 37.1% ; PAY_RESTORE | negative | 78 | 4.2% | 190 | 41.1% ; DES_DENSE | negative | 75 | 4.0% | 427 | 17.6% ; PAY_LIFETIME | mixed | 74 | 4.0% | 432 | 17.1% ; META_LOWINFO | context | 64 | 3.4% | 4,760 | 1.3% ; PAY_BILLING | negative | 62 | 3.3% | 261 | 23.8% ; PAY_PRICE_HIGH | negative | 61 | 3.3% | 254 | 24.0% ; REM_FAIL | negative | 55 | 2.9% | 279 | 19.7%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-139 — Rating contradictions META_CONTRA 73 (0.35%, weak): 35 at 5★, 24 at 1★, 7 at 2★, 4 at 4★, 3 at 3★ — four types: 5★ given to unlock or to be seen with negative text ('it's trash, have to review to unlock'; 'five stars so everyone sees: this app has tons of ads'); 1★ given to praise ('small, handy, free — thumbs up'; 1★ because 'people read bad reviews'); rating capped for a single missing thing (ca 1★ would be 4–5★ with full English; au 3★ fully positive); joke ('six stars, one overflowed') — opposite directions, cannot move a headline figure, kept in every count

- **Where:** §5.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Type | Example ; 5★ given to unlock or to be seen, text negative | 1932545403 (5★ *"就很垃圾 要评价才能解锁"*, *EN:* "it's trash, have to review to unlock"); 13048313896 (5★ *"五星让大家看到，这个软件广告多的要死"*, *EN:* "five stars so everyone sees: this app has tons of ads") ; 1★ given to praise | 12594769019 (1★ *"小巧，好用！还是免费的，点赞！"*, *EN:* "small, handy, free — thumbs up"); 7461051480 (1★ because *"很多人喜欢看差评"*, *EN:* "people read bad reviews") ; Rating capped for a single missing thing | 5222510620 (ca, 1★ — would be 4–5★ with full English); 4887783468 (au, 3★ with an entirely positive text) ; Joke / irony | 11997804351 (1★ *"给了六星好评，溢出一颗"*, *EN:* "six stars, one overflowed")
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** app-specific
- **Review IDs:** `1932545403`, `13048313896`, `12594769019`, `7461051480`, `5222510620`, `4887783468`, `11997804351`
- **Canonical:** — (nuance register)

### R52-140 — Theme direction is not fixed by rating: PAY_CAP5 has 199 five-star reviews ('the quota is fine, the app is lovely'), AD_NEG 132 five-star, PAY_BOUGHT 168 one-star — star rating alone is never used as a proxy for feature preference

- **Where:** §5.7
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** PAY_CAP5 199 5★; AD_NEG 132 5★; PAY_BOUGHT 168 1★
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

### R52-141 — Paid evidence tiers: direct PAY_BOUGHT 1,286 first-person statements of buying, subscribing or being a member (6.23%); lifetime subset PAY_BOUGHT ∩ PAY_LIFETIME 199; indirect interest PAY_LIFETIME without purchase statement 233 (asking for, praising or mourning a lifetime option; mean 3.64); no conversion rate claimed — written reviewers are not a purchase funnel

- **Where:** Part 6 evidence tiers
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 1,286 / 199 / 233 (3.64)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-172 — Public ratings versus written reviews (verbatim): the gap is uniform (≈ −0.5★) — cn −0.53, us −0.55, tw −0.54, hk −0.42, au −0.67, sg −0.52, jp −0.12, de −0.48; localisation complaints in English-speaking storefronts do not show as a deeper public-rating penalty, and the ad wave is not visible in the public average (the snapshot is undated and 562,951 ratings absorb a 1,562-review window)

- **Where:** §7.8 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** Storefront | Written n | Written mean | Public ratings | Public avg | Gap ; cn | 19,669 | 4.25 | 550,321 | 4.78 | −0.53 ; us | 287 | 4.16 | 3,259 | 4.71 | −0.55 ; tw | 201 | 4.20 | 2,509 | 4.74 | −0.54 ; hk | 119 | 4.23 | 2,093 | 4.65 | −0.42 ; au | 53 | 4.04 | 651 | 4.71 | −0.67 ; ca | 61 | 4.34 | not ranked | — | — ; sg [limited] | 27 | 4.19 | 310 | 4.71 | −0.52 ; jp [limited] | 24 | 4.71 | 529 | 4.83 | −0.12 ; de [limited] | 22 | 4.18 | 176 | 4.66 | −0.48
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

### R52-174 — What country data does not support: no claim that any non-Chinese market is more or less price-sensitive (PAY_PRICE_OK higher outside cn but n<300 per storefront at different price points); no cultural generalisation about why mainland users write shorter reviews — prompt- and unlock-driven solicitation is a sufficient mechanical explanation

- **Where:** §7.10
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-175 — Trend method: calendar years (2026 partial); six eras for readability with year boundaries; every one of 110 months profiled on ten indicator codes; an incident window is a month where one indicator reaches ≥10 reviews and stands out against adjacent months, each re-read; 2017 distorted by review-to-unlock, so 'decline since launch' starts from 2018; a trend is a direction held ≥2 consecutive years with ≥50 reviews per year in the theme, or a labelled incident window

- **Where:** §8.1
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 110 months; ≥10 per indicator; ≥2 years ≥50/year
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R52-186 — What trend data does not support: whether ads were rolled back — AD_NEG fell from 60–63/month (Oct–Nov 2025) to 4–14/month (Feb–Jul 2026) but review volume also fell (~250 → ~140/month) and 2026 reviews still describe ads (an ad on every tab, each with a differently placed close button, Aug 2026); causal effect of the growing quota — PAY_CAP5 declined before 2025 too (5.3% → 3.3%, 2021→2024), consistent but not proven; onboarding-trial effects (2026) too few and recent; AI note titles appear in a few 2026 reviews, all negative, no before/after possible

- **Where:** §8.5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** AD_NEG 60–63/mo → 4–14/mo; volume ~250 → ~140/mo; PAY_CAP5 5.3% → 3.3% pre-2025
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** generalisable
- **Review IDs:** `14484909185`, `13986964200`, `14206066896`, `14389575364`, `13930545782`, `13965180848`, `14508025525`, `13723729804`
- **Canonical:** — (nuance register)
