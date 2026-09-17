# Cards — report 1

Source: `App Store Reports/1. Habit Tracker - Goal Tracker & ADHD Planner (REPORT).md`  
201 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 4
- [Must-haves](#must-haves) — 5
- [Must never break](#must-never-break) — 21
- [Features](#features) — 58
- [Monetization](#monetization) — 10
- [Tactics the app used](#tactics-the-app-used) — 5
- [Insights (the why)](#insights-the-why) — 27
- [Audiences](#audiences) — 7
- [Markets and languages](#markets-and-languages) — 21
- [Dated events and trends](#dated-events-and-trends) — 22
- [Positioning](#positioning) — 4
- [Anti-patterns](#anti-patterns) — 4
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 4
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 4

## Product rules

### R01-059 — Every time a free feature moved behind the paywall the rating dropped and stayed down — it never fully recovered after April 2024

- **Where:** §1.6 pattern line
- **This app does:** four paywall regressions 2022–2024
- **User reaction:** 1★-burst
- **Magnitude:** paywall regression ('it used to be free') ×12.0 lift on 1★, ×6.3 on 2★, 75 reviews at mean 2.84 (Part 2)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** Part 8 #5: pick your free tier once and hold it
- **Review IDs:** `7242990766`, `7482039026`, `9825676857`
- **Canonical:** C001 Never move a free feature behind the paywall

### R01-166 — Never re-paywall a free feature — pick your free tier once and hold it

- **Where:** Part 8 #5
- **This app does:** re-paywalled four times
- **User reaction:** 1★-burst
- **Magnitude:** ×12 lift on 1★
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-059, R01-052, R01-056, R01-057
- **Canonical:** C001 Never move a free feature behind the paywall

### R01-167 — Lead with a one-time lifetime purchase — 'not a subscription' is the strongest pricing signal in the dataset

- **Where:** Part 8 #6
- **This app does:** lifetime SKU
- **User reaction:** purchase-driver
- **Magnitude:** 22.4% of everyone who paid names it
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-031, R01-123, R01-150
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R01-181 — Stay minimal and ad-free — 'simple/clean' is 32.2% of US reviews, 'no ads' has the highest mean of any theme (4.91), and every request for more features is paired with 'but don't make it complicated'

- **Where:** Part 8 #20
- **This app does:** minimal, ad-free
- **User reaction:** praise
- **Magnitude:** 32.2% of US; no-ads mean 4.91
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-060, R01-077
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

## Must-haves

### R01-046 — There is no support channel at all — and that is the single most over-represented complaint among buyers (×34.7)

- **Where:** §1.5 table row 8 + lift list
- **This app does:** no support channel
- **User reaction:** 1★-burst
- **Magnitude:** 11 angry payers (3.1%) but ×34.7 lift among buyers vs corpus-wide
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12940542679`, `12008055880`, `11941969340`, `11309506354`, `9283876341`, `12394406411`, `11804171737`, `11374078493`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R01-048 — No account system is the root cause of lost purchases, lost data and failed sync — a new phone means a lost purchase and lost data

- **Where:** §1.5 root cause
- **This app does:** no account system; everything device/iCloud-local
- **User reaction:** complaint
- **Magnitude:** 109 reviews ask for an account (0.19% global; 10 US, 0.18%, mean 3.65); ×5.4 on 1★, ×4.9 on 2★; ×12.0 over-represented in the paid cohort; ×15.8 lift (account/login missing) among buyers
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** Part 8 #2: ship an account system from day one
- **Review IDs:** `11264641334`, `12107547777`, `9660134870`, `8997324792`, `8514386778`, `7773632660`, `6852994319`, `6725198105`, `4038017855`, `11323614404`
- **Canonical:** C035 Account system from day one

### R01-094 — 'No support channel' is the second-worst-rated complaint theme (mean 2.04)

- **Where:** Part 4 table row 11
- **This app does:** no support channel
- **User reaction:** 1★-burst
- **Magnitude:** 28 global, 8 US, mean 2.04
- **Direction for us:** must-have · **Report confidence:** weak count, very low mean · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R01-140 — China-specific complaint cluster: no account login → membership and data lost on reinstall or new phone; iPhone↔iPad not syncing on the same Apple ID; persistent Android requests (one payer switched to Android and lost everything)

- **Where:** §6.4 bullet 7
- **This app does:** no account; iCloud-only sync; iOS only
- **User reaction:** complaint
- **Magnitude:** 6 + 4 + 4 IDs
- **Direction for us:** must-have · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** the no-account problem is global; Android is a cross-platform continuity ask
- **Review IDs:** `8217401004`, `12122244165`, `9615294074`, `12453093486`, `13691170318`, `14213711567`, `9208648018`, `9223945846`, `12107547777`, `8470619548`, `9023942437`, `10025596797`, `7970081682`, `13349826027`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one; C051 Android version

### R01-163 — Ship an account system from day one — no-account is the root cause of lost purchases, lost data and failed multi-device sync, the top three complaints from people who paid

- **Where:** Part 8 #2
- **This app does:** no account system
- **User reaction:** churn
- **Magnitude:** ×12–16 over-represented in the paid cohort
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-048, R01-140
- **Canonical:** C035 Account system from day one

## Must never break

### R01-041 — Billing errors — wrong amount, double charge, surprise renewal — are the #1 cause of angry paying customers

- **Where:** §1.5 table row 1
- **This app does:** billing errors occur
- **User reaction:** 1★-burst
- **Magnitude:** 76 angry payers (21.4% of angry payers); billing errors ×21 over-represented in 1★ reviews (Part 8 #1)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** Part 8 #1: single price shown, no trial-to-charge traps, refunds honoured, receipts clear
- **Review IDs:** `13073833210`, `12205808839`, `10835369648`, `13661881043`, `12149887715`, `8755673958`, `7693838370`, `6851547705`, `6463794681`, `5917864038`, `5489264041`, `4800753374`, `14030009468`, `13285661066`, `11777084667`, `9144813573`
- **Canonical:** C029 Billing must be exactly right

### R01-042 — Crashes are the #2 cause of angry paying customers, and 13.4% of all buyers mention one

- **Where:** §1.5 table row 2
- **This app does:** recurring crash incidents (Part 4)
- **User reaction:** 1★-burst
- **Magnitude:** 62 angry payers (17.5%); crashes ×7.1 over-represented among buyers; 13.4% of all buyers mention a crash
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12122611216`, `11791686984`, `9294699968`, `6660918412`, `5534625595`, `11210732518`, `12268266592`, `11442496849`, `8823075411`
- **Canonical:** C031 Crashes / launch failures

### R01-044 — Restore-purchase failing is a top-5 cause of angry paying customers

- **Where:** §1.5 table row 5
- **This app does:** restore purchase breaks (no account; iCloud-local)
- **User reaction:** 1★-burst
- **Magnitude:** 27 angry payers (7.6%)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** root cause is the missing account system (R01-047)
- **Review IDs:** `11941969340`, `9283876341`, `8535955220`, `7699737797`, `6751638144`, `6424767276`, `5640209527`, `5250831446`, `12858504950`, `12166995821`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R01-045 — Data loss hits paying users and is ×10.6 over-represented among buyers

- **Where:** §1.5 table row 7
- **This app does:** data is device/iCloud-local; lost on phone change or update
- **User reaction:** 1★-burst
- **Magnitude:** 22 angry payers (6.2%); data loss ×10.6 lift among buyers
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10194996668`, `9185761050`, `6883915010`, `5973855372`, `13859944372`, `9114508292`, `14457171713`, `12498095858`, `11937944304`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R01-049 — Streak / statistics miscounts are ×10.2 over-represented among buyers

- **Where:** §1.5 lift list
- **This app does:** streak and stat miscount bugs
- **User reaction:** complaint
- **Magnitude:** ×10.2 lift among buyers; no raw count in this section
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** Part 4 'persistent multi-year unfixed bugs' has the detail
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R01-063 — Taking money incorrectly is the fastest route to 1★ — billing errors are ×21.3 over-represented in 1★ and 100% of US billing complaints are 1–3★

- **Where:** Part 2 1★ table row 1 + sentence 1
- **This app does:** billing errors
- **User reaction:** 1★-burst
- **Magnitude:** ×21.3 on 1★, ×3.9 on 2★; 102 reviews, mean 1.89; 100% of US billing complaints 1–3★
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right

### R01-065 — Crashes are the largest complaint by volume: 1,072 reviews at mean 2.98

- **Where:** Part 2 1★ table row 7
- **This app does:** recurring crashes
- **User reaction:** 1★-burst
- **Magnitude:** 1,072 reviews, mean 2.98, ×8.6 on 1★, ×8.3 on 2★
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R01-066 — Reminders not firing is a strong 1★ driver

- **Where:** Part 2 1★ table row 10
- **This app does:** reminders sometimes fail
- **User reaction:** complaint
- **Magnitude:** 66 reviews; ×6.6 on 1★, ×4.1 on 2★
- **Direction for us:** must-never-break · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** reminders that work are also a top praise item (Part 3: 9.4% of US at 4.59) — same feature, both directions
- **Canonical:** C039 Reminders fire reliably, once

### R01-068 — A broken widget is a strong 1–2★ driver

- **Where:** Part 2 1★ table row 12
- **This app does:** widgets break
- **User reaction:** complaint
- **Magnitude:** 60 reviews; ×5.2 on 1★, ×7.8 on 2★
- **Direction for us:** must-never-break · **Report confidence:** moderate · **Generalisable:** yes
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R01-090 — Crashes / freezes / won't-open is the #1 complaint and runs at 5–7% of non-China reviews per year since 2024

- **Where:** Part 4 table row 1 + dilution note
- **This app does:** recurring crash incidents
- **User reaction:** 1★-burst
- **Magnitude:** 1,072 global (1.89%); 305 US (5.61% HIGH-PRIORITY); mean 2.98; 5–7% of non-CN reviews per year since 2024
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** global % is diluted by 22,136 contentless CN filler reviews — report says treat as HIGH-PRIORITY
- **Canonical:** C031 Crashes / launch failures

### R01-091 — Shared / group habits broken is the worst-rated theme in the dataset (mean 2.33), broken continuously 2020 → 2026

- **Where:** Part 4 table row 4
- **This app does:** shared habits exist but invites never arrive, records fail to modify, invitee's board vanishes, duplicates after sync, partner can delete your habits
- **User reaction:** 1★-burst
- **Magnitude:** 66 reviews, mean 2.33 — lowest-rated theme; 28 US (0.52%)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Side effects:** one user bought specifically for shared habits, couldn't use it, was refused a refund, wrote '一生黑' (lifelong hater)
- **Conditions:** a purchase driver that fails costs more than a missing feature
- **Review IDs:** `11872142407`, `14368195442`, `11619587662`, `8223936579`, `13507165984`, `8814459765`, `9655198596`, `9114508292`, `13628025400`, `11575579529`, `12367483644`, `14450880574`, `13689542636`, `12865599006`, `11729343016`, `10823077252`, `14074266911`, `13974330030`
- **Canonical:** C015 Shared / group habits

### R01-092 — Editing a habit's frequency wiped its history for years; when it was fixed in late 2025 a user came back specifically to raise their rating

- **Where:** Part 4 table row 9
- **This app does:** bug existed for years; fixed late 2025
- **User reaction:** complaint
- **Magnitude:** 20 global, 9 US (0.17%), mean 3.60
- **Direction for us:** must-never-break · **Report confidence:** weak count · **Generalisable:** yes
- **Side effects:** fixing a long-standing bug produces revised ratings — users do come back (Part 8 #15)
- **Review IDs:** `13835499661`, `11064175608`, `13331897384`, `13449875017`
- **Canonical:** C041 Editing a habit never wipes its history; C059 Be visibly responsive; fixes bring reviewers back

### R01-093 — DST / timezone changes break streaks

- **Where:** Part 4 table row 10
- **This app does:** timezone handling breaks streaks
- **User reaction:** complaint
- **Magnitude:** 28 global, 15 US (0.28%), mean 3.50
- **Direction for us:** must-never-break · **Report confidence:** weak count · **Generalisable:** yes
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R01-097 — Widgets go blank, stop updating, disappear after updates, or show different numbers from the app

- **Where:** Part 4 persistent bugs bullet 2
- **This app does:** widget reliability bugs
- **User reaction:** complaint
- **Magnitude:** 60 reviews, mean 3.40 (table); 'widget shows 10, app shows 5'
- **Direction for us:** must-never-break · **Report confidence:** weak count · **Generalisable:** yes
- **Review IDs:** `9611400134`, `11230464766`, `9925842684`, `8035455211`, `13073928408`, `10529025581`, `11190100507`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R01-100 — Notification spam — reminders firing after completion, or hundreds of repeats

- **Where:** Part 4 persistent bugs bullet 6
- **This app does:** reminder bugs
- **User reaction:** complaint
- **Magnitude:** 3 IDs
- **Direction for us:** must-never-break · **Report confidence:** weak count · **Generalisable:** yes
- **Review IDs:** `11497748147`, `13565202357`, `8354356581`
- **Canonical:** C039 Reminders fire reliably, once

### R01-162 — Never take money incorrectly: single price shown, no trial-to-charge traps, refunds honoured, receipts clear

- **Where:** Part 8 #1
- **This app does:** billing errors ×21 in 1★
- **User reaction:** 1★-burst
- **Magnitude:** billing errors ×21 over-represented in 1★ reviews
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-041, R01-063
- **Canonical:** C029 Billing must be exactly right

### R01-164 — Make sync actually work, and prove it — sync is the #1 differentiator buyers name and the #1 thing that breaks; if it is the paid feature it must be flawless

- **Where:** Part 8 #3
- **This app does:** paid iCloud sync that fails
- **User reaction:** churn
- **Magnitude:** lift ×9.8 among buyers; sync failure ×12.8 among buyers
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-015, R01-025
- **Canonical:** C030 Sync must work — and prove it

### R01-165 — Harden the year-end report — it is the best emotional moment and the most reliable outage (Jan 2020, Dec 2020, Jan 2021, Dec 2024, Jan 2026)

- **Where:** Part 8 #4
- **This app does:** year-end report crashes every year
- **User reaction:** 1★-burst
- **Magnitude:** five incidents in six years
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-095
- **Canonical:** C032 New Year peak-season robustness — year-end report and January onboarding

### R01-176 — Editing a habit must never wipe its history

- **Where:** Part 8 #15
- **This app does:** fixed late 2025
- **User reaction:** complaint
- **Magnitude:** fix produced a returning 5★ (13449875017)
- **Direction for us:** must-never-break · **Report confidence:** weak count · **Generalisable:** yes
- **Conditions:** evidence: R01-092
- **Review IDs:** `13449875017`
- **Canonical:** C041 Editing a habit never wipes its history

### R01-193 — Data loss: 211 reviews at mean 2.85, ×9.4 on 1★ and ×11.1 on 2★; 78 US (1.43%, MEANINGFUL); non-CN share rose again to 1.55% in 2025

- **Where:** Part 2 1★ table row 6 + Part 4 row 2 + Part 7
- **This app does:** data is device/iCloud-local and gets lost on phone change, reinstall or update
- **User reaction:** 1★-burst
- **Magnitude:** 211 global (0.37%), mean 2.85; ×9.4 1★, ×11.1 2★; 78 US (1.43%); by year 0 / 2.61 / 1.63 / 0.90 / 0.85 / 0.86 / 1.55 / 1.11 %
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** paid-cohort view is R01-045; root cause R01-048
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R01-194 — Streak / statistics miscounts: 44 reviews, ×8.5 on 1★, ×7.6 on 2★, mean 2.89

- **Where:** Part 2 1★ table row 8 + Part 4 row 8
- **This app does:** streak and stat miscount bugs
- **User reaction:** complaint
- **Magnitude:** 44 global (0.08%); 17 US (0.31%); mean 2.89; ×8.5 1★, ×7.6 2★; ×10.2 among buyers
- **Direction for us:** must-never-break · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** DST/timezone (R01-093) is one cause
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

## Features

### R01-009 — Habit creation is free only up to a cap, and the cap is the #1 monetization complaint

- **Where:** §1.2 row 1
- **This app does:** free up to cap (3–6, drifting)
- **User reaction:** complaint
- **Magnitude:** '#1 monetization complaint'; cap-related 2★ lift ×7.5 (Part 8)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** Part 8 #9 recommends a generous cap (6+) held constant; see R01-016 for 'unlimited' as a paid driver
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R01-010 — Daily check-in and one basic reminder per habit are free and draw no complaints

- **Where:** §1.2 row 2
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** reaction: 'fine' (no complaint signal)
- **Direction for us:** build-free · **Report confidence:** stated without count · **Generalisable:** yes
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free

### R01-011 — Icons, colours and a basic widget are free — loved, and they drive 5★ reviews

- **Where:** §1.2 row 3
- **This app does:** free (icons, colours, basic widget)
- **User reaction:** 5★-burst
- **Magnitude:** reaction: 'loved, drives 5★'; customisation 7.5% of buyers (lift ×2.7), widget 7.1% (lift ×3.1) in §1.3
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** some widgets are free here whereas other apps lock all widgets behind paywall — the free basic widget is what earns the 5★
- **Canonical:** C009 Basic widgets, icons and colours are free

### R01-012 — Backfilling missed days is free up to 7 days back and paid beyond that; users accept the split

- **Where:** §1.2 row 4
- **This app does:** free ≤7 days, paid beyond
- **User reaction:** praise
- **Magnitude:** reaction: 'fine'
- **Direction for us:** build-free · **Report confidence:** stated without count · **Generalisable:** yes
- **Conditions:** a 7-day free window is the tolerated boundary
- **Review IDs:** `11578392138`, `12625167724`
- **Canonical:** C010 Backfill missed days / edit start date

### R01-013 — Weekly / monthly / yearly reports are paid and are the #1 stated reason people pay

- **Where:** §1.2 row 5
- **This app does:** paid
- **User reaction:** purchase-driver
- **Magnitude:** '#1 stated reason people pay'; §1.3: 4.5% of buyers by keyword, dominant in qualitative read; 'reports were the reason I paid' (11309506354)
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** were free in 2020–mid 2021 and moved behind paywall Jan 2022 (regression #1, §1.6); yearly stats locked days before year-end Dec 2024 (regression #4)
- **Review IDs:** `11309506354`, `9185761050`, `11061030490`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R01-014 — Unlimited habits is paid and is the #2 reason people pay

- **Where:** §1.2 row 6
- **This app does:** paid
- **User reaction:** purchase-driver
- **Magnitude:** '#2 reason'
- **Direction for us:** undecided · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** contradicts the free-cap complaint (R01-009): the cap sells, but it also produces the #1 complaint; Part 8 recommends a generous fixed cap rather than none
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R01-015 — iCloud sync / multi-device is paid, the #3 reason people pay, and the #1 source of paid-user anger

- **Where:** §1.2 row 7
- **This app does:** paid; device/iCloud-local, no account system
- **User reaction:** purchase-driver
- **Magnitude:** #3 purchase reason; strongest true differentiator among buyers (9.0% of buyers, lift ×9.8, §1.3); sync failure ×12.8 over-represented among buyers; 34 angry payers (9.6% of angry payers) say sync doesn't work after paying (§1.5)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** if sync is the paid feature it must be flawless (Part 8 #3)
- **Review IDs:** `6736804782`, `9223945846`, `6561137344`, `6142665297`, `5360258264`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C030 Sync must work — and prove it

### R01-016 — Multiple reminders per habit is paid and a moderate purchase reason

- **Where:** §1.2 row 8
- **This app does:** paid (first reminder free)
- **User reaction:** purchase-driver
- **Magnitude:** reaction: 'moderate'; reminders 7.8% of buyers, lift ×2.0 (§1.3)
- **Direction for us:** build-paid · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** moved behind paywall Jan 2022 (§1.6)
- **Canonical:** C014 Multiple reminders per habit

### R01-017 — Shared / group habits ('一起养成') is paid, a strong purchase driver, and the worst-executed feature in the app

- **Where:** §1.2 row 9
- **This app does:** paid; exists; broken
- **User reaction:** purchase-driver
- **Magnitude:** 5.0% of buyers, lift ×5.4 — 'high-intent buy reason' (§1.3); 24 angry payers (6.8%) say shared habits are broken (§1.5)
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** demand is proven even though the implementation fails; a working version would inherit the purchase intent
- **Review IDs:** `11994782701`, `12624096933`, `11309506354`, `9114508292`, `13627620738`
- **Canonical:** C015 Shared / group habits

### R01-018 — Skip / holiday mode is paid and a minor purchase factor

- **Where:** §1.2 row 10
- **This app does:** paid
- **User reaction:** purchase-driver
- **Magnitude:** reaction: 'minor' (grouped with passcode and icon themes)
- **Direction for us:** undecided · **Report confidence:** minor · **Generalisable:** yes
- **Conditions:** moved behind paywall Jan 2022 with reports, multi-reminder and sync (§1.6)
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R01-019 — Passcode lock is paid and a minor purchase factor

- **Where:** §1.2 row 10
- **This app does:** paid
- **User reaction:** purchase-driver
- **Magnitude:** reaction: 'minor'
- **Direction for us:** research · **Report confidence:** minor · **Generalisable:** yes
- **Canonical:** C017 Passcode lock

### R01-020 — App-icon themes are paid and a minor purchase factor

- **Where:** §1.2 row 10
- **This app does:** paid
- **User reaction:** purchase-driver
- **Magnitude:** reaction: 'minor'
- **Direction for us:** undecided · **Report confidence:** minor · **Generalisable:** yes
- **Canonical:** C018 App-icon themes

### R01-021 — Quit-habit (戒除) mode is paid and well received

- **Where:** §1.2 row 11
- **This app does:** paid; shipped Sep 2023
- **User reaction:** praise
- **Magnitude:** reaction: 'well received'
- **Direction for us:** research · **Report confidence:** stated without count · **Generalisable:** yes
- **Conditions:** see Research Reports/Quit Habit Decision.md
- **Review IDs:** `13711763153`, `13811111971`, `11131185906`
- **Canonical:** C019 Quit-habit / bad-habit mode

### R01-022 — Data export is paid; it is requested a lot but rarely triggers a purchase

- **Where:** §1.2 row 12
- **This app does:** paid
- **User reaction:** complaint
- **Magnitude:** 'requested a lot, rarely a purchase trigger'; export 2.9% of buyers, lift ×3.7 (§1.3)
- **Direction for us:** build-free · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** charging for it generates requests, not revenue
- **Canonical:** C020 Data export / backup / CSV

### R01-027 — Streaks / gamification are a moderate purchase factor

- **Where:** §1.3 table row 8
- **This app does:** has streaks
- **User reaction:** purchase-driver
- **Magnitude:** 5.0% of buyers, lift ×2.4
- **Direction for us:** undecided · **Report confidence:** moderate · **Generalisable:** yes
- **Canonical:** C024 Streaks / gamification

### R01-028 — Apple Health integration is a small-volume but very-high-intent purchase reason

- **Where:** §1.3 table row 10
- **This app does:** has Apple Health integration
- **User reaction:** purchase-driver
- **Magnitude:** 1.8% of buyers, lift ×5.8
- **Direction for us:** build-paid · **Report confidence:** small, very high intent · **Generalisable:** yes
- **Conditions:** Part 8 #16: do Watch + Health properly, two-way
- **Canonical:** C021 Apple Health integration

### R01-029 — Apple Watch is a small-volume but very-high-intent purchase reason

- **Where:** §1.3 table row 11
- **This app does:** has a Watch app
- **User reaction:** purchase-driver
- **Magnitude:** 2.1% of buyers, lift ×4.2
- **Direction for us:** build-paid · **Report confidence:** small, very high intent · **Generalisable:** yes
- **Conditions:** Part 8 #16 asks for a Watch timer and two-way sync
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R01-030 — Interactive widget check-off (mark done without opening the app) is a small but very-high-intent purchase reason

- **Where:** §1.3 table row 13
- **This app does:** widgets are interactive
- **User reaction:** purchase-driver
- **Magnitude:** 1.2% of buyers, lift ×5.2
- **Direction for us:** undecided · **Report confidence:** small, very high intent · **Generalisable:** yes
- **Conditions:** Part 8 #12 lists it as a product priority
- **Canonical:** C023 Interactive widget check-off

### R01-072 — Custom frequency (every X days, specific weekdays, bi-weekly, quarterly, yearly, total-over-a-window) is the #1 unmet functional need and the highest 4★ lift in the dataset

- **Where:** Part 2 3–4★ list
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 4★ lift ×4.2, 3★ ×3.9 — 'the classic great app, but…'; Part 5 ranks it #1
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** Part 8 #11
- **Canonical:** C043 Flexible / custom frequency

### R01-073 — A Mac / Windows / web version is the strongest 3★ driver; several users volunteered to pay extra for it

- **Where:** Part 2 3–4★ list
- **This app does:** iPhone/iPad only
- **User reaction:** blocked-conversion
- **Magnitude:** 3★ lift ×4.8
- **Direction for us:** build-paid · **Report confidence:** strong · **Generalisable:** yes
- **Conditions:** Part 8 #17
- **Review IDs:** `8965466270`, `9503979717`
- **Canonical:** C044 Mac / desktop / web app

### R01-074 — Sub-tasks / folders / grouping / multiple profiles is a mid-band gap

- **Where:** Part 2 3–4★ list
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 2★ lift ×2.7, 4★ ×2.3
- **Direction for us:** undecided · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** Part 8 #13: 'me, my kids, work, pet'
- **Canonical:** C045 Grouping / folders / categories / tags; C173 Sub-tasks / sub-routines nested inside a habit or routine; C174 Multiple profiles (me, kids, pet, work)

### R01-075 — Shortcuts / Siri / URL-scheme automation is asked for by power users who evangelise

- **Where:** Part 2 3–4★ list
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 4★ lift ×2.7
- **Direction for us:** undecided · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** Part 8 #18
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R01-078 — Reminders that work are the #2 praise item

- **Where:** Part 3 table row 2
- **This app does:** reliable reminders (mostly)
- **User reaction:** praise
- **Magnitude:** 2,162 global (3.8%); 508 US (9.4%), HIGH-PRIORITY, mean 4.59
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once

### R01-079 — Icon / colour / theme customisation is praised at 'very strong' band with mean 4.70

- **Where:** Part 3 table row 3
- **This app does:** free icons and colours; paid icon themes
- **User reaction:** praise
- **Magnitude:** 1,550 global (2.7%); 255 US (4.7%), VERY STRONG, mean 4.70
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free

### R01-080 — Widgets are a high-priority praise item in the US

- **Where:** Part 3 table row 4
- **This app does:** free basic widget; paid report/calendar widget since Apr 2024
- **User reaction:** praise
- **Magnitude:** 1,297 global (2.3%); 373 US (6.9%), HIGH-PRIORITY, mean 4.45
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** mean 4.45 is the lowest among praise items — widgets also break (R01-068)
- **Canonical:** C009 Basic widgets, icons and colours are free

### R01-081 — Streaks / progress feedback is a high-priority praise item

- **Where:** Part 3 table row 5
- **This app does:** streaks + grid views
- **User reaction:** praise
- **Magnitude:** 1,202 global (2.1%); 391 US (7.2%), HIGH-PRIORITY, mean 4.73
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C024 Streaks / gamification

### R01-082 — Reports / stats board is praised at 'meaningful' band

- **Where:** Part 3 table row 6
- **This app does:** paid reports
- **User reaction:** praise
- **Magnitude:** 1,009 global (1.8%); 69 US (1.3%), MEANINGFUL, mean 4.69
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C011 Weekly / monthly / yearly reports

### R01-083 — Flexible units / partial progress (drag to 60% instead of a binary tick) is an emerging praise item and a named reason for choosing this app over competitors

- **Where:** Part 3 table row 8
- **This app does:** progress bar with partial check-in
- **User reaction:** praise
- **Magnitude:** 371 global (0.7%); 40 US (0.7%), EMERGING, mean 4.53; 'genuinely differentiating'
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `8484864815`, `7533159455`, `9599419869`
- **Canonical:** C048 Flexible units / partial progress

### R01-084 — Quit-bad-habit mode is praised at 'meaningful' band in the US

- **Where:** Part 3 table row 9
- **This app does:** paid quit mode since Sep 2023
- **User reaction:** praise
- **Magnitude:** 271 global (0.5%); 85 US (1.6%), MEANINGFUL, mean 4.69
- **Direction for us:** research · **Report confidence:** meaningful (US) · **Generalisable:** yes
- **Canonical:** C019 Quit-habit / bad-habit mode

### R01-085 — Mood / journal is praised at 'meaningful' band in the US

- **Where:** Part 3 table row 10
- **This app does:** mood tracker + journal since Dec 2023
- **User reaction:** praise
- **Magnitude:** 316 global (0.6%); 71 US (1.3%), MEANINGFUL, mean 4.66
- **Direction for us:** research · **Report confidence:** meaningful (US) · **Generalisable:** yes
- **Canonical:** C049 Mood tracker

### R01-087 — The check-off sound and haptic are named as a reason to keep coming back

- **Where:** Part 3 'specific things' bullet 3
- **This app does:** sound + haptic on check-off
- **User reaction:** praise
- **Magnitude:** named; no count
- **Direction for us:** build-free · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `12817953072`, `8746818428`
- **Canonical:** C069 Check-off sound and haptic

### R01-098 — The Apple Watch app is half-built: black screen, no timer, one-way sync only

- **Where:** Part 4 persistent bugs bullet 4
- **This app does:** Watch app exists but is weak
- **User reaction:** complaint
- **Magnitude:** 8 IDs; Watch 3★ ×4.7, 2★ ×5.7 (Part 2)
- **Direction for us:** build-paid · **Report confidence:** moderate · **Generalisable:** app-specific
- **Conditions:** Part 8 #16: Watch done properly means a Watch timer and two-way sync
- **Review IDs:** `7736947415`, `10406252185`, `11630025684`, `12115342572`, `12993356431`, `11489065352`, `9788537083`, `9495420825`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R01-099 — The Mac / M1 build won't open, groups don't display, fonts are tiny

- **Where:** Part 4 persistent bugs bullet 5
- **This app does:** Mac (iPad-on-M1) build is broken
- **User reaction:** complaint
- **Magnitude:** 6 IDs
- **Direction for us:** build-paid · **Report confidence:** weak count · **Generalisable:** app-specific
- **Conditions:** a real Mac app is a 3★-lift ×4.8 gap (R01-073)
- **Review IDs:** `8193933847`, `8772612449`, `9236687881`, `9294699968`, `10970545034`, `13673065255`
- **Canonical:** C044 Mac / desktop / web app

### R01-101 — Data export / backup / CSV is the #1 feature request by volume, from happy users (mean 4.76)

- **Where:** Part 5 table row 1
- **This app does:** export is paid
- **User reaction:** complaint
- **Magnitude:** 442 global (0.78%); 92 US (1.69% MEANINGFUL); mean 4.76
- **Direction for us:** build-free · **Report confidence:** meaningful (US) · **Generalisable:** yes
- **Conditions:** requested by 4.76-mean users = not anger, but the request volume shows the paywall on export is felt (R01-022)
- **Canonical:** C020 Data export / backup / CSV

### R01-102 — Sub-tasks / folders / grouping / tags / multiple profiles (me, kids, pet, work) is the #2 request

- **Where:** Part 5 table row 2 + bullet
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 275 global (0.49%); 63 US (1.16% MEANINGFUL); mean 4.41
- **Direction for us:** undecided · **Report confidence:** meaningful (US) · **Generalisable:** yes
- **Side effects:** one user wants Apple-Watch-style closing rings; one wants nested items
- **Review IDs:** `13747367536`, `7634754264`, `13682524933`, `9764200754`, `8348985579`
- **Canonical:** C045 Grouping / folders / categories / tags; C068 Parents tracking kids; C173 Sub-tasks / sub-routines nested inside a habit or routine; C174 Multiple profiles (me, kids, pet, work)

### R01-103 — One-off to-dos alongside habits is an emerging request

- **Where:** Part 5 table row 3
- **This app does:** habits only, no to-dos
- **User reaction:** complaint
- **Magnitude:** 237 global (0.42%); 33 US (0.61% EMERGING); mean 4.53
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C050 One-off to-dos alongside habits

### R01-104 — Interactive widget check-off is requested by 128 users at mean 4.58

- **Where:** Part 5 table row 4
- **This app does:** not interactive at the time of most requests
- **User reaction:** complaint
- **Magnitude:** 128 global (0.23%); 14 US (0.26% WEAK); mean 4.58
- **Direction for us:** undecided · **Report confidence:** weak (US) · **Generalisable:** yes
- **Conditions:** pairs with R01-030 (lift ×5.2 among buyers)
- **Canonical:** C023 Interactive widget check-off

### R01-105 — Every-X-days / custom frequency is the #1 outstanding functional request — the single change most likely to convert 4★ → 5★

- **Where:** Part 5 table row 5 + paragraph
- **This app does:** fixed daily/weekly only
- **User reaction:** complaint
- **Magnitude:** 107 global (0.19%); 42 US (0.77% EMERGING); mean 3.99; 4★ lift ×4.2 (highest in dataset)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** asks: every other day, every 3 days, bi-weekly, quarterly, specific weekdays, yearly goal period, fixed total over a custom window
- **Review IDs:** `11546677755`, `13653691592`, `8192442876`, `8386361837`, `10039214833`, `13399803793`, `9323772372`, `11102698750`, `13397631582`, `12161101542`, `11292583414`, `10638765978`, `9542852807`, `13182168411`, `14161153524`, `12821336230`, `9346815481`
- **Canonical:** C043 Flexible / custom frequency

### R01-106 — An Android version is requested by 94 users

- **Where:** Part 5 table row 7
- **This app does:** iOS only
- **User reaction:** complaint
- **Magnitude:** 94 global (0.17%); 24 US (0.44% WEAK); mean 4.41
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C051 Android version

### R01-107 — Shortcuts / Siri / automation / API requested by 87 users

- **Where:** Part 5 table row 8
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 87 global (0.15%); 24 US (0.44% WEAK); mean 4.34
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R01-108 — Mac / Windows / web app requested by 67 users

- **Where:** Part 5 table row 9
- **This app does:** missing (broken M1 build only)
- **User reaction:** complaint
- **Magnitude:** 67 global (0.12%); 14 US (0.26% WEAK); mean 4.03
- **Direction for us:** build-paid · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C044 Mac / desktop / web app

### R01-109 — Photo attachment to the journal — ignorable volume

- **Where:** Part 5 table row 10
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 16 global (0.03%); 1 US; mean 4.38
- **Direction for us:** none · **Report confidence:** ignore · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R01-110 — Cumulative totals ('how many total hours have I spent on this habit?') are requested, not just streaks

- **Where:** Part 5 'other asks' bullet 2
- **This app does:** streaks only
- **User reaction:** complaint
- **Magnitude:** 4 IDs; Part 8 #14
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13625602594`, `11444116403`, `9346815481`, `9004383645`
- **Canonical:** C047 Cumulative totals and total-days counter

### R01-111 — Points / rewards / wish list requested; one user proposes a cash-stake mode

- **Where:** Part 5 'other asks' bullet 3
- **This app does:** no rewards system
- **User reaction:** complaint
- **Magnitude:** 6 IDs
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13884191988`, `11653460054`, `8415166135`, `9503979717`, `8656766818`, `10269104804`
- **Canonical:** C052 Points / rewards / wish list

### R01-112 — Custom time-of-day segments beyond morning/afternoon/evening — needed by shift workers

- **Where:** Part 5 'other asks' bullet 4
- **This app does:** fixed three segments
- **User reaction:** complaint
- **Magnitude:** 2 IDs
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13005403096`, `8504117544`
- **Canonical:** C053 Custom time-of-day segments

### R01-113 — A total-days counter instead of consecutive-days, to reduce streak anxiety

- **Where:** Part 5 'other asks' bullet 5
- **This app does:** consecutive streaks only
- **User reaction:** complaint
- **Magnitude:** 1 ID; Part 8 #14 adopts it
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Side effects:** streak anxiety is a churn mechanism the report takes seriously despite n=1
- **Review IDs:** `9088862282`
- **Canonical:** C047 Cumulative totals and total-days counter

### R01-114 — Broader Apple Health plus Fitbit / Garmin — shipped by mid-2026

- **Where:** Part 5 'other asks' bullet 6
- **This app does:** shipped Fitbit/Garmin support by mid-2026
- **User reaction:** praise
- **Magnitude:** 2 IDs
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13049304019`, `14449213471`
- **Canonical:** C021 Apple Health integration

### R01-115 — Accessibility and cultural gaps: bigger fonts, missing disability icons, missing Islamic icons while cross/church/Star-of-David exist, Hijri calendar, lunar calendar for China

- **Where:** Part 5 'other asks' bullet 7
- **This app does:** icon set and calendars are Western-default
- **User reaction:** complaint
- **Magnitude:** several era-referenced IDs
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** cheap to fix, and it lands in the markets where localisation already blocks purchase; report cites era-shorthand IDs 6852/108/8979/6049/8796/220 that are not full review IDs
- **Review IDs:** `9950542821`
- **Canonical:** C028 Culturally complete icon set and calendars

### R01-119 — A focus timer is a 'meaningful' US theme

- **Where:** §6.1 table row focus timer
- **This app does:** has a focus timer
- **User reaction:** praise
- **Magnitude:** 72 US (1.32%) MEANINGFUL
- **Direction for us:** undecided · **Report confidence:** meaningful (US) · **Generalisable:** yes
- **Canonical:** C066 Focus timer

### R01-148 — The focus timer is an 'emerging' global theme

- **Where:** §6.5 row 'Focus timer'
- **This app does:** has a focus timer
- **User reaction:** praise
- **Magnitude:** 452 (0.80%) EMERGING
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C066 Focus timer

### R01-172 — Flexible frequency: every-X-days, specific weekdays, bi-weekly, quarterly, yearly, and custom total-over-a-window — the #1 unmet functional need worldwide

- **Where:** Part 8 #11
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** highest 4★ lift in the dataset (×4.2)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-072, R01-105
- **Canonical:** C043 Flexible / custom frequency

### R01-173 — Interactive widget check-off without opening the app

- **Where:** Part 8 #12
- **This app does:** not interactive for most of its life
- **User reaction:** purchase-driver
- **Magnitude:** ×5.2 lift among buyers
- **Direction for us:** undecided · **Report confidence:** small, very high intent · **Generalisable:** yes
- **Conditions:** evidence: R01-030, R01-104
- **Canonical:** C023 Interactive widget check-off

### R01-174 — Grouping / folders / multiple profiles — me, my kids, work, pet

- **Where:** Part 8 #13
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** #2 feature request (R01-102)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R01-074, R01-102
- **Canonical:** C045 Grouping / folders / categories / tags; C174 Multiple profiles (me, kids, pet, work)

### R01-175 — Cumulative totals ('47 hours read this year'), not just streaks — and offer total days instead of consecutive days to reduce streak anxiety

- **Where:** Part 8 #14
- **This app does:** streaks only
- **User reaction:** complaint
- **Magnitude:** 4 + 1 IDs
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R01-110, R01-113
- **Canonical:** C047 Cumulative totals and total-days counter

### R01-177 — Apple Watch + Apple Health done properly, including a Watch timer and two-way sync — small volume, very high purchase intent

- **Where:** Part 8 #16
- **This app does:** half-built Watch app; Health integration
- **User reaction:** purchase-driver
- **Magnitude:** lift ×4.2–×5.8 among buyers
- **Direction for us:** build-paid · **Report confidence:** small, very high intent · **Generalisable:** yes
- **Conditions:** evidence: R01-028, R01-029, R01-098
- **Canonical:** C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync)

### R01-178 — A Mac app — 3★ lift ×4.8; several users volunteered to pay extra for it

- **Where:** Part 8 #17
- **This app does:** broken M1 build only
- **User reaction:** blocked-conversion
- **Magnitude:** 3★ lift ×4.8
- **Direction for us:** build-paid · **Report confidence:** strong · **Generalisable:** yes
- **Conditions:** evidence: R01-073, R01-099, R01-108
- **Review IDs:** `8965466270`, `9503979717`
- **Canonical:** C044 Mac / desktop / web app

### R01-179 — Shortcuts / Siri / URL scheme — power users who will evangelise

- **Where:** Part 8 #18
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 4★ lift ×2.7
- **Direction for us:** undecided · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** evidence: R01-075, R01-107
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R01-200 — Week-start day (Monday/Sunday) and dd/mm date-format settings are asked for by European users

- **Where:** §6.2 'Western Europe' line
- **This app does:** US defaults only
- **User reaction:** complaint
- **Magnitude:** named in the Western Europe summary; no count
- **Direction for us:** build-free · **Report confidence:** qualitative · **Generalisable:** yes
- **Conditions:** cheap localisation-adjacent settings; ship with the first European language
- **Canonical:** C027 Localise early — it unlocks revenue

## Monetization

### R01-006 — Headline product is a one-time 'Lifetime' purchase, with yearly and monthly subscriptions alongside it and a Family Lifetime plan from ~mid-2024; the free tier is a hard cap on habits plus most analytics locked

- **Where:** §1.1 line 65-66
- **This app does:** lifetime + yearly + monthly + family lifetime; free = capped habits, analytics locked
- **User reaction:** mixed
- **Magnitude:** model description; purchase-driver evidence in §1.3 (22.4% of paid cohort cite 'not a subscription')
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** the lifetime SKU is the one buyers name; subscriptions exist but are not what people praise
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R01-007 — Lifetime price climbed steadily from $4.99 (2019) to ~$10 (2026) in the US, with regional pricing in 12 markets and a time-limited discount promo in China

- **Where:** §1.1 line 68-83 price table
- **This app does:** US lifetime $4.99 → $5.99 → $6 → $6.99 → $7 → $8 → $8.99 → $9.74 → ~$10; yearly $3.49–$8; family ~$12.99. CN ¥30 → ¥40 → ¥48, yearly ¥22, ¥18 as a 24-hour / 40%-off promo. UK £3.99–£5 → £8; EU €3.49–€10; AU A$8–10; CA C$8–12; BR R$27–50 (yearly R$12.90–19.90); MX MX$149–200; IN ₹999–1299; TR ₺200 (yearly ₺20–21); VN 91k–299k₫; ID Rp89k–150k; SG S$12.98 (family S$19.98)
- **User reaction:** mixed
- **Magnitude:** US lifetime $4.99 → $5.99 → $6 → $6.99 → $7 → $8 → $8.99 → $9.74 → ~$10; yearly $3.49–$8; family ~$12.99. China ¥30 (2021-22) → ¥40 (2022+) → ¥48 (2026), yearly ¥22, ¥18 as a 24-hour / 6折 promo. UK £3.99–£5, later £8; EU €3.49–€10; AU A$8–10; CA C$8–12; Brazil R$27–50, yearly R$12.90–19.90; Mexico MX$149–200, yearly MX$60; India ₹999–1299; Turkey ₺200, yearly ₺20–21; Vietnam 91,000–299,000₫; Indonesia Rp89,000–150,000, yearly Rp49,000; Singapore S$12.98, family S$19.98
- **Direction for us:** research · **Report confidence:** reported prices · **Generalisable:** yes
- **Side effects:** 'cheaper than a coffee' framing in §1.3 is anchored on these price points
- **Conditions:** prices doubled over 7 years while the rating fell — the report does not claim causation
- **Review IDs:** `7703914833`, `8271993504`, `10886897549`, `9470654295`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C064 Price level — where 'fair' turns into 'too expensive'

### R01-043 — The Family plan exists — and it is broken because it is Apple Family Sharing with no in-app affordance, so buyers cannot find how to use it

- **Where:** §1.5 table row 3
- **This app does:** Family Lifetime plan launched ~mid-2024 via Apple Family Sharing, nothing in-app
- **User reaction:** 1★-burst
- **Magnitude:** 40 angry payers (11.3%) in §1.5; 52 low-rated in §1.6 at mean 1.65; 0% of complaints before 2024 → 1.94% of all non-CN reviews in 2025
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** there is demand for a family plan (people bought it); the failure is discoverability, not the plan itself
- **Conditions:** Part 8 #10: if you ship a family plan, make it discoverable in-app
- **Review IDs:** `12159515360`, `13594757077`, `12444775035`, `14383144623`, `11575579529`, `13245020706`, `12221978847`, `14092312477`, `12516217190`, `12165765645`, `11908724929`
- **Canonical:** C037 Family plan

### R01-070 — The free habit cap draws 296 complaints and is ×7.5 over-represented in 2★

- **Where:** Part 2 1★ table row 15
- **This app does:** free cap 3–6
- **User reaction:** complaint
- **Magnitude:** 296 reviews; ×4.0 on 1★, ×7.5 on 2★
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** cap complaints land in 2★ more than 1★ — annoyance, not rage
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R01-071 — 'Too expensive' draws 209 complaints at moderate lift, even at a ~$10 lifetime price

- **Where:** Part 2 1★ table row 16
- **This app does:** lifetime ~$10 by 2026
- **User reaction:** complaint
- **Magnitude:** 209 reviews; ×3.4 on 1★, ×3.2 on 2★
- **Direction for us:** research · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** price rose from $4.99 to ~$10 (R01-007); 'cheap/fair' is simultaneously a 5★ driver (R01-032)
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R01-138 — China's free cap was 3 habits throughout 2021–22 versus 5–6 elsewhere — a stricter free tier in the home market

- **Where:** §6.4 bullet 4
- **This app does:** region-specific free cap
- **User reaction:** complaint
- **Magnitude:** 3 in CN vs 5–6 elsewhere
- **Direction for us:** research · **Report confidence:** stated · **Generalisable:** yes
- **Conditions:** pairs with 'you must pay just to reach the home page, minimum 48' (14506100308)
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R01-144 — 'No trial before pay' is a weak but present complaint (217 reviews)

- **Where:** §6.5 row 'No-trial-before-pay'
- **This app does:** no free trial of Premium
- **User reaction:** complaint
- **Magnitude:** 217 (0.38%) WEAK
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C063 Free trial before purchase

### R01-168 — Price it low and anchor against subscription competitors — 'cheaper than a coffee' is a 4.79-mean framing

- **Where:** Part 8 #7
- **This app does:** lifetime priced below competitors' yearly
- **User reaction:** purchase-driver
- **Magnitude:** mean 4.79 for price-fair reviews
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Conditions:** evidence: R01-032, R01-089
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R01-170 — Set the free cap generously (6+) and leave it alone — cap complaints carry ×7.5 lift on 2★

- **Where:** Part 8 #9
- **This app does:** cap drifted 2–6
- **User reaction:** complaint
- **Magnitude:** ×7.5 lift on 2★
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-008, R01-009, R01-070; note the report recommends a generous fixed cap, not unlimited — 'unlimited' is the #2 purchase reason (R01-014)
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R01-171 — If you ship a family plan, make it discoverable in-app — this app's family plan has mean 1.65 across 52 complaints purely because nobody can find how to use it

- **Where:** Part 8 #10
- **This app does:** family plan via Apple Family Sharing with no in-app affordance
- **User reaction:** 1★-burst
- **Magnitude:** mean 1.65 across 52 complaints
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-043, R01-134
- **Canonical:** C037 Family plan

## Tactics the app used

### R01-002 — Review-for-premium campaign ('leave a review → 3–6 months free Premium', 评论送会员) ran in China 2019–~2022 and turned China into 72% of the corpus

- **Where:** Part 0 §1 line 29-34
- **This app does:** ran the campaign 2019 to ~2022, then stopped
- **User reaction:** 5★-burst
- **Magnitude:** China = 40,991 of 56,653 reviews (72.4%), mean 4.82; 1,340 CN reviews (3.3% of CN) say outright they review only for the membership; 21,751 CN reviews (53.1%) under 12 chars at mean 4.86; CN 2021+2022 alone = 32,336 reviews at 4.85
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** produced the #1 rank and the 4.8 store average; but only 0.86% of CN reviewers show any purchase signal (see R01-036) and the developer's own dataset became unreadable
- **Conditions:** home-market campaign; see Part 8 #24 for the report's verdict
- **Review IDs:** `8904637743`, `8910739685`, `8677766507`, `8513158580`, `8354830730`, `7966619964`, `7523226507`, `6642189102`, `5194031778`, `3916981057`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R01-035 — The scholarship / 'request a discount' program is the cleanest 5★ generator in the entire dataset — and it appears to have been switched off in 2025

- **Where:** §1.3 scholarship block
- **This app does:** ran ~2022–2024: users who could not afford it were given Premium free or discounted; share of non-CN reviews 0.96% (2023) → 1.20% (2024) → 0.06% (2025) → 0.24% (2026)
- **User reaction:** 5★-burst
- **Magnitude:** 101 reviews (0.18% global, 0.72% US — emerging), mean 4.83; 91 of them 5★ at a perfect 5.00 mean
- **Direction for us:** do · **Report confidence:** emerging (US) · **Generalisable:** yes
- **Side effects:** also solves the payment-rails problem in Russia, Argentina, Turkey, Algeria, Pakistan where cards fail; killing it removed the highest-rated review source the app had
- **Conditions:** Part 8 #8: run it and never stop it
- **Review IDs:** `11448581403`, `10241954935`, `10994557868`, `10542758525`, `8470641817`, `10783884891`, `11141716858`, `11085172531`, `10530819803`, `12869585099`, `11138164446`, `10857255564`, `10825043878`, `10755398022`, `10562374061`
- **Canonical:** C025 Scholarship / hardship / discount program

### R01-088 — The developer's app family (Minimalist To-Do, Card Budget, Budget) drives cross-buying on brand trust — an under-used monetization asset

- **Where:** Part 3 'specific things' bullet 4
- **This app does:** publishes several minimalist apps under one brand
- **User reaction:** purchase-driver
- **Magnitude:** 9 IDs cited; 'users cross-buy on brand trust'; no count
- **Direction for us:** do · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `8409037626`, `8551806489`, `8552974691`, `8586441242`, `8420279444`, `11168340470`, `11210031835`, `12156175776`, `9470194755`
- **Canonical:** C060 Cross-sell an app family on brand trust

### R01-142 — Becoming visibly responsive (2025–26) produced revised 5★ reviews: users reported bugs, saw them fixed, and came back to raise their rating

- **Where:** §6.4 bullet 9
- **This app does:** developer responsive on Xiaohongshu and in-app from 2025
- **User reaction:** 5★-burst
- **Magnitude:** 'dev responsive' 98 global (0.17%); non-CN share peaked 0.73% in 2024; 6 IDs of returning reviewers
- **Direction for us:** do · **Report confidence:** weak count, clear mechanism · **Generalisable:** yes
- **Side effects:** 'I reported it twice, the author fixed it, so I came back to give 5 stars'
- **Review IDs:** `13449875017`, `12513590440`, `11883092530`, `13666901262`, `14075111063`, `14056363586`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R01-169 — Run a scholarship / hardship program and never stop it — 91 of 101 mentions are 5★ at a perfect 5.00; it also solves broken payment rails in RU/TR/AR/PK; killing it in 2025 removed the app's best review source

- **Where:** Part 8 #8
- **This app does:** ran then stopped
- **User reaction:** 5★-burst
- **Magnitude:** 91/101 5★, mean 5.00 among those
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** evidence: R01-035, R01-036
- **Canonical:** C025 Scholarship / hardship / discount program

## Insights (the why)

### R01-004 — Outside China the honest rating is ~4.29 and falling toward 3.8; the US 1★ rate more than tripled 2023→2026 (5.4% → 18.1%)

- **Where:** Part 0 §3 line 38-52
- **This app does:** store shows 4.67; non-China reality is ~4.29
- **User reaction:** complaint
- **Magnitude:** US mean 4.61 (2019) → 3.81 (2020, 16.2% 1★) → 4.54 (2023, best) → 3.73 (2025, 16.8% 1★) → 3.87 (2026, 18.1% 1★); non-CN monthly mean bottomed at 3.14 in Dec 2024 (65 of 227 reviews 1★) and never returned to 2023 levels
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the report says: design against the non-China numbers — the honest baseline for an app of this quality is ~4.29 trending to 3.8
- **Conditions:** 2020 dip = crash incidents (Part 4); 2024–2026 decline = paywall regressions + family plan + crashes (§1.6)
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R01-023 — Explicit purchase confirmations are 8.5× denser in the US than in the corpus overall

- **Where:** §1.3 line 106
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 759 reviews confirm a purchase: 1.34% globally, 4.14% of US ('very strong signal in the US')
- **Direction for us:** none · **Report confidence:** very strong (US) · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R01-024 — Simple/clean design is what buyers mention most, but it is table stakes, not a differentiator

- **Where:** §1.3 table row 1
- **This app does:** simple, clean design
- **User reaction:** purchase-driver
- **Magnitude:** 29.2% of buyers, lift ×1.4 — 'table stakes, gets them in the door'
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** see R01-095 (Part 8 #20): 32.2% of US reviews mention simple/clean
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R01-025 — iCloud sync / multi-device is the strongest true differentiator among buyers

- **Where:** §1.3 table row 2
- **This app does:** paid
- **User reaction:** purchase-driver
- **Magnitude:** 9.0% of buyers, lift ×9.8 — highest lift in the table
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** and the thing that breaks most (R01-015)
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator

### R01-026 — Buyers shopped around before paying — competitor comparison is over-represented among buyers

- **Where:** §1.3 table row 6
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 6.6% of buyers, lift ×3.3
- **Direction for us:** do · **Report confidence:** strong · **Generalisable:** yes
- **Side effects:** positioning against named competitors matters at the point of purchase
- **Canonical:** C005 Know which competitors buyers compare against

### R01-031 — People pay BECAUSE it is a one-time purchase and not a subscription — this is the top stated reason, not the price

- **Where:** §1.3 'three stated reasons' #1
- **This app does:** one-time lifetime SKU
- **User reaction:** purchase-driver
- **Magnitude:** 430 reviews globally (0.76%), 134 in the US (2.47%), 22.4% of the entire paid cohort; 'the strongest pricing signal in the dataset' (Part 8 #6)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** distinct from 'price is low' (R01-032): subscription fatigue is the reason, fairness is second
- **Review IDs:** `13050724508`, `11365943784`, `13441875727`, `9660134870`, `8880295585`, `8504863858`, `8201740274`, `7514260455`, `7096262291`, `5234071883`, `12158584332`, `11138747548`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R01-032 — The price being low / fair is the #2 stated reason to pay, and those reviews are near-perfect

- **Where:** §1.3 'three stated reasons' #2
- **This app does:** lifetime priced 'cheaper than a coffee'
- **User reaction:** purchase-driver
- **Magnitude:** 608 globally (1.07%), 176 US (3.24%), 11.7% of paid cohort, mean rating 4.79; framing: 'cheaper than a coffee', '$30/yr apps vs this'
- **Direction for us:** product-rule · **Report confidence:** very strong (US) · **Generalisable:** yes
- **Conditions:** anchored against subscription competitors (Part 8 #7)
- **Review IDs:** `11373452581`, `11711652533`, `9747144434`, `8686832314`, `14133562629`, `12448613807`, `10481350467`, `9904151511`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R01-033 — The reports board is the #3 stated reason to pay and is under-counted by keyword matching

- **Where:** §1.3 'three stated reasons' #3
- **This app does:** paid reports
- **User reaction:** purchase-driver
- **Magnitude:** keyword count 4.5% of buyers but 'dominant in the qualitative read'; 'I paid for the weekly/monthly/yearly report' appears constantly
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9185761050`, `11061030490`, `9809815444`, `8571612933`, `7932327023`, `6122442517`, `5543456646`, `12120837089`, `9248742785`, `14107403167`, `11309506354`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R01-034 — 'Support the devs' is a small, pure-margin purchase motive with very high ratings

- **Where:** §1.3 bonus driver
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 51 reviews (0.09% global, 0.40% US), mean 4.69
- **Direction for us:** do · **Report confidence:** weak signal · **Generalisable:** yes
- **Side effects:** goodwill toward an indie developer converts to purchases
- **Review IDs:** `10317808778`, `11670063988`, `8183543609`, `13769603363`, `13078191322`, `9610116256`, `3712021994`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R01-037 — 74 happy users say they WOULD pay but are held back by one missing thing — most often that the app is not in their language

- **Where:** §1.3 blocked conversion
- **This app does:** not localised into ES, PT, JA etc.
- **User reaction:** blocked-conversion
- **Magnitude:** 74 reviews (0.13%), mean 4.74 — 'happy users held back by one missing thing'
- **Direction for us:** do · **Report confidence:** weak signal, high rating · **Generalisable:** yes
- **Conditions:** 'If it were in Spanish I would buy it' (ES), 'would only be worth buying Premium if it were in Portuguese' (PT), 'I'd consider paying if it supported Japanese' (JP)
- **Review IDs:** `10659457233`, `8900768368`, `8695040986`, `8372953300`, `8261669660`, `8100585477`, `8007363760`, `7845331523`, `7671263640`, `7592934351`, `7301224156`, `7184849491`, `5324970906`, `5220698156`, `5141351490`, `4653085671`, `9213458913`, `12563756399`, `9490334380`
- **Canonical:** C027 Localise early — it unlocks revenue

### R01-038 — Paying customers rate the app a full point lower than everyone else, and more than one in five paying customers leaves a 1★

- **Where:** §1.4 line 143-147
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 1,261 paid-signal reviews (2.23%); paid-cohort mean 3.66 vs corpus 4.67; 5★ 52.1%, 4★ 12.4%, 3★ 7.4%, 2★ 5.6%, 1★ 22.5% (284)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the features people pay for are the ones that break (R01-046)
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R01-040 — 28.2% of everyone who paid left a 1–2★ review

- **Where:** §1.5 line 180
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 355 reviews from paying users rating 1–2★ = 28.2% of paid cohort
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R01-047 — The features people pay for (sync, sharing, multi-device) are exactly the features that break

- **Where:** §1.5 'most damaging pattern' + lift list
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** lift among confirmed buyers: no support channel ×34.7, account/login missing ×15.8, sync failure ×12.8, data loss ×10.6, streak/stat miscount ×10.2, crashes ×7.1
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R01-060 — 'No ads' is the highest-rated topic in the corpus — 181 of 182 mentions are positive

- **Where:** Part 2 5★ table row 1
- **This app does:** ad-free
- **User reaction:** praise
- **Magnitude:** 5★ lift ×1.12; 1 low rating out of 182; mean 4.91
- **Direction for us:** must-have · **Report confidence:** weak count, best mean · **Generalisable:** yes
- **Conditions:** Part 8 #20: stay minimal and ad-free
- **Canonical:** C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R01-062 — The 5★ recipe: clean, ad-free tracker, aimed at ADHD/students, priced as a cheap one-time buy, given away to people who can't afford it

- **Where:** Part 2 5★ 'translation'
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** synthesis of the 5★ lift table
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C006 Stay minimal — every addition is opt-in or off by default; C025 Scholarship / hardship / discount program; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R01-064 — Charging for something and then not delivering it is the second-fastest route to 1★ — restore purchase, family plan and broken sync all sit above ×9

- **Where:** Part 2 1★ table rows 2-4 + sentence 2
- **This app does:** sells sync/family/restore that fail
- **User reaction:** 1★-burst
- **Magnitude:** restore purchase ×13.9 on 1★ (49, mean 2.51); family plan ×12.7 (73, mean 2.55); sync failure ×7.6 / ×10.0 on 2★ (134, mean 2.93); shared-habit failure ×11.7 / ×11.2 (66, mean 2.33)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C030 Sync must work — and prove it; C033 Restore purchase and entitlements must work immediately; C037 Family plan; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R01-067 — Simply having paid is a 1★ risk factor: confirmed buyers are ×6.7 over-represented in 1★

- **Where:** Part 2 1★ table row 11
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** confirmed purchase ×6.7 on 1★, ×4.1 on 2★
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R01-076 — 3★ and 4★ are where feature gaps live, not anger — localisation, sync, Watch and Health sit in that band; these users already like the app and would move to 5★ if the gap were closed

- **Where:** Part 2 3–4★ list
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** localisation 3★ ×5.5; iCloud sync 3★ ×5.0 / 2★ ×6.4; Apple Watch 3★ ×4.7 / 2★ ×5.7; Apple Health 4★ ×2.8
- **Direction for us:** do · **Report confidence:** strong · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C027 Localise early — it unlocks revenue; C030 Sync must work — and prove it

### R01-077 — Simple / clean / beautiful UI is the dominant praise: 21.1% of all reviews, 32.2% of US

- **Where:** Part 3 table row 1
- **This app does:** minimal design
- **User reaction:** praise
- **Magnitude:** 11,969 global (21.1%); 1,750 US (32.2%), HIGH-PRIORITY, mean 4.74
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** Part 8 #20: every request for more features is paired with 'but don't make it complicated'
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R01-086 — Week / month / year grid views are the emotional payoff — 'filling the squares' is the retention mechanic

- **Where:** Part 3 'specific things' bullet 2
- **This app does:** grid views
- **User reaction:** praise
- **Magnitude:** named repeatedly; no count
- **Direction for us:** must-have · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `8631367041`, `10586793226`, `11007512932`
- **Canonical:** C012 Week / month / year grid views

### R01-123 — In the US the lifetime option is a genuine competitive weapon because anti-subscription sentiment is strong

- **Where:** §6.1 US notes bullet 3
- **This app does:** lifetime SKU
- **User reaction:** purchase-driver
- **Magnitude:** lifetime / not-a-subscription 134 US (2.47%) MEANINGFUL
- **Direction for us:** product-rule · **Report confidence:** meaningful (US) · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R01-137 — The review campaign gave China rank and volume, not revenue — volume collapsed from ~2,225/month (Apr 2022) to 20–40/month once the campaign ended, and only 0.86% of CN reviews show purchase signal

- **Where:** §6.4 bullets 2-3
- **This app does:** campaign ended ~Nov 2022
- **User reaction:** none
- **Magnitude:** ~2,225 reviews/month peak → 20–40/month from Nov 2022 through 2026; purchase signal 0.86%
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** incentivised review volume does not persist and does not convert
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R01-143 — Social referral is an emerging theme globally (0.52%)

- **Where:** §6.5 row 'Social referral'
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 293 (0.52%) EMERGING
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R01-150 — Confirmed purchases and lifetime/one-time praise both rose steadily as a share of non-China reviews, peaking in 2025–26

- **Where:** Part 7 table rows 1-2
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** confirmed purchase 0.73% (2019) → 5.35% (2025) → 4.69% (2026); lifetime praise 1.28% → 3.18% (2026)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** as subscription fatigue grew in the market, the lifetime SKU became a bigger reason to buy
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R01-160 — The product got better at features and worse at trust: quality of the OFFER fell (more paywalls, billing errors, broken family plan, no support) while quality of the APP mostly held — ratings followed the offer, not the app

- **Where:** Part 7 'story in one line'
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** synthesis of Part 7
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** feature work cannot compensate for a deteriorating offer
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R01-161 — Nobody in this category is asking for AI — 6 of 56,653 reviews mention it (0.011%), one uses 'AI slop' as an insult, and users repeatedly ask for the opposite: no bloat, no fancy stuff

- **Where:** Part 7 'AI' section
- **This app does:** no AI features
- **User reaction:** none
- **Magnitude:** 6 reviews (0.011%), far below the 0.1% ignore threshold; 1 genuine request (AI to build a schedule)
- **Direction for us:** dont · **Report confidence:** high-priority (negative evidence) · **Generalisable:** yes
- **Conditions:** Part 8 #23: don't build AI, build reliability instead
- **Review IDs:** `10828370613`, `12071506651`, `12146111608`, `14398239845`, `14449350393`, `14499683590`
- **Canonical:** C056 Don't build AI features on demand grounds

### R01-196 — Simple UI, streaks and cheap/fair price each carry only a small 5★ lift (×1.02–×1.03) because they are near-universal in the corpus

- **Where:** Part 2 5★ table rows 5-7
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** simple/clean UI ×1.02 (21.1% of all reviews); streaks ×1.03; cheap/fair ×1.03
- **Direction for us:** none · **Report confidence:** stated · **Generalisable:** yes
- **Conditions:** low lift ≠ unimportant: these are baseline expectations, not differentiators
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

## Audiences

### R01-061 — Students / exam-prep and ADHD / neurodivergent users are the highest-satisfaction audiences

- **Where:** Part 2 5★ table rows 2-3
- **This app does:** positions as ADHD planner in the title
- **User reaction:** praise
- **Magnitude:** students 5★ lift ×1.10, mean 4.87; ADHD ×1.09, mean 4.83; ADHD = 7.08% of US reviews at mean 4.79 (Part 8 #19)
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** also people tracking medication and chronic illness (Part 8 #19)
- **Conditions:** Part 8 #19: aim at ADHD/neurodivergent users
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R01-118 — Fitness / weight / health tracking is a 'very strong' US use case

- **Where:** §6.1 table row fitness
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 215 US (3.96%) VERY STRONG
- **Direction for us:** do · **Report confidence:** very strong (US) · **Generalisable:** yes
- **Canonical:** C067 Fitness / health tracking use case

### R01-120 — The US is an ADHD product: 7.08% of US reviews mention ADHD, autism, executive dysfunction, depression, anxiety, OCD or brain fog, and they rate it 4.79

- **Where:** §6.1 'US is an ADHD product'
- **This app does:** titled as 'ADHD Planner'
- **User reaction:** praise
- **Magnitude:** 385 US reviews (7.08%) HIGH-PRIORITY, mean 4.79 — 'single best-fitting audience'
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** also UK 5.5%, NL 5.7%, IE 7.7%, ZA 5.5% (§6.2–6.3) — an English-market pattern
- **Review IDs:** `14471682651`, `13606761481`, `12049623222`, `11311674388`, `11112049976`, `10970057468`, `10757452341`, `10636005774`, `10393613916`, `10296500513`, `10158656394`, `9989831299`, `9852989405`, `9668892809`, `9567634950`, `9329775634`, `8824929179`, `8366119419`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R01-145 — Parents tracking kids' habits is a weak but distinct use case

- **Where:** §6.5 row 'Parents/kids use'
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 118 (0.21%) WEAK; grouping/profiles requests cite 'my kids' (R01-102)
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C068 Parents tracking kids

### R01-146 — People tracking medication and chronic illness are a distinct audience

- **Where:** §6.5 row 'Chronic illness / meds'
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 90 (0.16%) WEAK; Part 8 #19 groups them with ADHD and students
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R01-147 — Fitness / health use is a 'meaningful' global theme (1.85%)

- **Where:** §6.5 row 'Fitness/health use'
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 1,049 (1.85%) MEANINGFUL
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C067 Fitness / health tracking use case

### R01-180 — Aim at ADHD and neurodivergent users — highest-fit, highest-satisfaction audience; also students and people tracking medication / chronic illness

- **Where:** Part 8 #19
- **This app does:** ADHD in the title
- **User reaction:** praise
- **Magnitude:** ADHD 7.08% of US at mean 4.79; students mean 4.87
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-061, R01-120, R01-146
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

## Markets and languages

### R01-036 — Payment rails fail in Russia, Argentina, Turkey, Algeria and Pakistan — users there cannot pay by card even when they want to

- **Where:** §1.3 scholarship block
- **This app does:** no alternative payment path except the scholarship program
- **User reaction:** blocked-conversion
- **Magnitude:** named markets: RU, AR, TR, DZ, PK; no count given
- **Direction for us:** do · **Report confidence:** stated without count · **Generalisable:** yes
- **Side effects:** a hardship/discount program doubles as the workaround
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK)

### R01-039 — Purchase-signal density by country: NZ, ZA, UAE, CZ, PT, PL, PH, CA, MY, US, DE, IN, AU, UA, UK, RU all 5.8–9.6% of that country's reviews; China 0.86%; Brazil 1.6%, Mexico 2.7%, Spain 2.2%, France 2.3%

- **Where:** §1.4 country table
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** US 395 paid-signal (7.3%); CA 65 (7.4%); UK 59 (5.8%); DE 36 (6.9%); IN 46 (6.9%); AU 31 (6.7%); CN 352 (0.86%); BR 12 (1.6%); MX 10 (2.7%); ES 6 (2.2%); FR 7 (2.3%)
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** Brazil, Mexico, Spain, France have heavy volume but weak purchase signal and all four are dominated by localisation complaints (Part 6)
- **Conditions:** US supplies 9.6% of reviews but 8.5× the purchase-signal density of China
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R01-069 — Missing localisation is the largest non-crash complaint: 639 reviews at mean 3.54, ×6.5 on 2★

- **Where:** Part 2 1★ table row 14
- **This app does:** English (and Chinese) only for most of its life; Japanese added mid-2026
- **User reaction:** complaint
- **Magnitude:** 639 reviews, mean 3.54; ×4.4 on 1★, ×6.5 on 2★, ×5.5 on 3★
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** Part 6 has the per-language counts; §1.3 shows it blocks purchases
- **Canonical:** C027 Localise early — it unlocks revenue

### R01-117 — US roadmap themes above 3%: simple UI 32.2%, reminders 9.4%, competitor named 9.0%, streaks 7.2%, ADHD 7.1%, widget 6.9%, crashes 5.6%, customisation 4.7%, confirmed purchase 4.1%, fitness/health 4.0%, price fair 3.2%

- **Where:** §6.1 table
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** US n=5,436, mean 4.27, 9.4% 1★; full table in §6.1
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 'everything above 3% is a roadmap item for the US'
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R01-124 — Localisation is a non-issue in the US (0.20%) — ignore it there

- **Where:** §6.1 US notes bullet 4
- **This app does:** English
- **User reaction:** none
- **Magnitude:** 0.20% of US
- **Direction for us:** none · **Report confidence:** ignore (US) · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R01-125 — English-speaking rich markets (US/UK/CA/AU/NZ/IE) are near-identical: ADHD framing, widget, streaks, anti-subscription pricing; they need stability and the one-time price, not localisation

- **Where:** §6.2 table + 'English-speaking' line
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** US 4.27 / UK 4.30 / CA 4.29 / AU 4.29 / NZ 4.76 / IE 4.54; top signals ADHD, widget, crashes, price-fair, bought
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C062 Weight English-speaking rich markets; volume ≠ revenue

### R01-126 — New Zealand is the best-rated rich market (4.76, 1.1% 1★) with the highest price-fair and purchase signals

- **Where:** §6.2 table row NZ
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** n=94, mean 4.76, 1★ 1.1%; price-fair 9.6%, bought 6.4%, widget 6.4%
- **Direction for us:** none · **Report confidence:** small n · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R01-127 — Western Europe (DE/FR/ES/IT/NL/PT): localisation is the biggest market-specific ask and a stated purchase blocker; also week-start Monday/Sunday setting, dd/mm date format, European DST bug, broken Mac/M1, 'too feminine' design

- **Where:** §6.2 'Western Europe' line
- **This app does:** English-only for most of its life
- **User reaction:** blocked-conversion
- **Magnitude:** FR localisation 15.9%, ES 21.8%; FR mean 4.01, ES 3.98, NL 3.99 (lowest rich-market means)
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** week-start and date-format settings are cheap localisation-adjacent fixes
- **Conditions:** DST bug: Oct 27 missing / Mar 29 duplicated
- **Canonical:** C027 Localise early — it unlocks revenue

### R01-128 — Japanese localisation shipped ~June 2026 after years as the #1 ask and immediately produced 5★ reviews praising both the localisation and the buy-once model — the clearest proof in the dataset that localisation converts

- **Where:** §6.2 'Japan' line
- **This app does:** shipped Japanese ~June 2026
- **User reaction:** 5★-burst
- **Magnitude:** JP n=132, mean 4.00, localisation 16.7% before shipping; 5 glowing IDs after
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** early translations had errors (iCloud sync labelled 障害者 / 'disabled person') — machine translation quality is visible to users
- **Review IDs:** `9490334380`, `14239800706`, `14379368271`, `14376545696`, `14445698207`, `14437414708`
- **Canonical:** C027 Localise early — it unlocks revenue

### R01-129 — Korean is still unshipped and still requested — by patient 5★ reviewers

- **Where:** §6.2 'Korea' line
- **This app does:** no Korean
- **User reaction:** blocked-conversion
- **Magnitude:** 6 IDs, all 5★
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13999601567`, `13957001291`, `13260788938`, `12104042341`, `10742118809`, `10210224741`
- **Canonical:** C027 Localise early — it unlocks revenue

### R01-130 — Arabic is a 12.2% in-market signal in Saudi Arabia (HIGH-PRIORITY), alongside missing Islamic icons and a Hijri-calendar request

- **Where:** §6.2 'Gulf' line
- **This app does:** no Arabic; no Islamic icons; no Hijri calendar
- **User reaction:** complaint
- **Magnitude:** SA n=131, localisation 12.2% HIGH-PRIORITY in-market; UAE 1★ rate 16.9%
- **Direction for us:** do · **Report confidence:** high-priority (in-market) · **Generalisable:** yes
- **Review IDs:** `13831858646`, `13708335665`, `13331431985`, `11788130875`, `11750488103`, `11452329638`, `11040206467`, `10894442514`
- **Canonical:** C027 Localise early — it unlocks revenue; C028 Culturally complete icon set and calendars

### R01-131 — Taiwan is the only rich market where shared habits is a top-3 signal

- **Where:** §6.2 table row Taiwan
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** TW n=274, shared habits 3.6%, reports 3.3%
- **Direction for us:** none · **Report confidence:** small signal · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R01-132 — Localisation in volume markets is the biggest single market-specific finding: Spanish 182 requests, Portuguese 162, French 48, Russian 44, Turkish 43, Japanese 22, Arabic 16, Ukrainian 12, Vietnamese 8, Korean 6

- **Where:** §6.3 table + language table
- **This app does:** shipped ES ~Aug 2024 (partial/reverted?), PT ~Sep–Oct 2025, JA ~Jun 2026, RU/UK ~mid-2026 with quality complaints; TR still unshipped Aug 2026
- **User reaction:** blocked-conversion
- **Magnitude:** Chile 33.8% (highest in dataset), Brazil 20.0%, Argentina 17.6%, Peru 17.5%, Russia 16.1%, Colombia 15.7%, Turkey 14.5%, Mexico 12.2%, Ukraine 11.4%, Kazakhstan 10.5%; requests peaked at 8.06% of all non-CN reviews in 2025, fell to 3.02% in 2026 as languages shipped
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** markets with heavy localisation complaints (BR, MX, ES, FR, CL, CO) have the weakest purchase signal (0–1.3%)
- **Conditions:** a shipped language visibly lowers the request rate the following year
- **Review IDs:** `13184823707`, `12958742820`, `13510576895`, `12751833462`, `13201946828`, `14459701739`, `14511362211`, `11631593284`, `13124670867`, `14210177746`, `13813994012`, `12404246932`, `11919640372`, `13999601567`
- **Canonical:** C027 Localise early — it unlocks revenue

### R01-133 — India shows billing complaints at 1.3% — a market-specific billing problem

- **Where:** §6.3 table row India
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** IN n=672, mean 4.54; billing 1.3%; purchase signal 3.1%
- **Direction for us:** must-never-break · **Report confidence:** small signal · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right

### R01-134 — The broken family plan shows up as a 3.3% signal in both the Philippines and Indonesia

- **Where:** §6.3 table rows Philippines / Indonesia
- **This app does:** family plan via Apple Family Sharing
- **User reaction:** complaint
- **Magnitude:** PH family plan 3.3% (purchase signal 3.8%); ID family plan 3.3% (purchase signal 0%)
- **Direction for us:** research · **Report confidence:** small signal · **Generalisable:** app-specific
- **Side effects:** family plans matter more where a single purchase is shared across a household
- **Canonical:** C037 Family plan

### R01-135 — Malaysia and Romania have unusually high purchase signal (6.4%, 7.5%); Romania's widget signal is 15.1%

- **Where:** §6.3 table rows Malaysia / Romania
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** MY n=109, bought 6.4%; RO n=53, widget 15.1%, bought 7.5%
- **Direction for us:** none · **Report confidence:** small n · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R01-136 — China has the lowest purchase signal of any major market (0.86%) despite 72% of reviews

- **Where:** §6.3 table row China
- **This app does:** review campaign
- **User reaction:** none
- **Magnitude:** CN n=40,991, mean 4.82, 1★ 1.1%; reports 1.9%, widget 0.9%; purchase 0.86%
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C062 Weight English-speaking rich markets; volume ≠ revenue

### R01-188 — Paid-signal reviews as a share of each country's reviews — full table

- **Where:** §1.4 country table (verbatim)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Market | Paid-signal reviews | % of that country ; New Zealand | 8 | 9.6% ; South Africa | 7 | 9.6% ; UAE | 6 | 8.5% ; Czechia | 6 | 8.7% ; Portugal | 6 | 8.0% ; Poland | 14 | 7.9% ; Philippines | 16 | 7.6% ; Canada | 65 | 7.4% ; Malaysia | 8 | 7.3% ; US | 395 | 7.3% ; Germany | 36 | 6.9% ; India | 46 | 6.9% ; Australia | 31 | 6.7% ; Ukraine | 7 | 6.7% ; UK | 59 | 5.8% ; Russia | 16 | 5.9% ; China | 352 | 0.86% ; Brazil | 12 | 1.6% ; Mexico | 10 | 2.7%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** verbatim retention of the table; the insight is R01-039
- **Canonical:** — (nuance register)

### R01-189 — Rich markets: n, mean, 1★ %, top three signals — full table

- **Where:** §6.2 rich-market table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Market | n | Mean | 1★% | Top signal | Second | Third ; US | 5,436 | 4.27 | 9.4 | ADHD 7.1 | Crashes 5.6 | Bought 4.1 ; UK | 1,025 | 4.30 | 8.9 | ADHD 5.5 | Widget 5.9 | Crashes 4.9 ; Canada | 878 | 4.29 | 8.2 | Crashes 5.9 | Widget 5.2 | Price-fair 4.3 / Bought 4.1 ; Germany | 520 | 4.21 | 7.9 | Crashes 5.2 | Widget 5.0 | Price-fair 3.5 ; Australia | 460 | 4.29 | 10.7 | Widget 6.1 | Crashes 4.3 | Bought 4.1 ; France | 302 | 4.01 | 12.9 | Localization 15.9 | Widget 5.6 | Crashes 4.6 ; Spain | 271 | 3.98 | 12.5 | Localization 21.8 | Widget 9.2 | Crashes 2.6 ; Italy | 157 | 4.20 | 10.2 | Widget 7.0 | Crashes 4.5 | Watch 4.5 ; Netherlands | 176 | 3.99 | 13.1 | Widget 8.5 | Crashes 8.0 | ADHD 5.7 / Watch 5.1 ; Japan | 132 | 4.00 | 9.1 | Localization 16.7 | Widget 6.8 | Lifetime-praise 4.5 ; Taiwan | 274 | 4.27 | 10.2 | Crashes 5.8 | Shared habits 3.6 | Reports 3.3 ; Hong Kong | 171 | 4.38 | 7.0 | Crashes 4.7 | Reports 3.5 | Lifetime 2.9 ; Sweden | 127 | 4.23 | 8.7 | Widget 7.1 | Watch 3.1 | Price-fair 2.4 ; Switzerland | 58 | 4.43 | 6.9 | Price-fair 6.9 | Widget 6.9 | Reports 3.4 ; Singapore | 101 | 4.55 | 4.0 | Widget 8.9 | Bought 4.0 | Crashes 4.0 ; New Zealand | 94 | 4.76 | 1.1 | Price-fair 9.6 | Bought 6.4 | Widget 6.4 ; Ireland | 52 | 4.54 | 3.8 | ADHD 7.7 | Crashes 3.8 | Widget 3.8 ; Austria | 66 | 4.24 | 12.1 | Widget 6.1 | Crashes 4.5 | Price-fair 3.0 ; Belgium | 61 | 4.13 | 9.8 | Widget 6.6 | Crashes 6.6 | Bought 3.3 ; Norway | 58 | 4.26 | 5.2 | Crashes 3.4 | Bought 3.4 | — ; Saudi Arabia | 131 | 4.21 | 10.7 | Localization (Arabic) 12.2 | Crashes 3.8 | Widget 2.3 ; UAE | 71 | 4.14 | 16.9 | Crashes 4.2 | Data loss 2.8 | Bought 2.8 ; Czechia | 69 | 4.39 | 5.8 | Crashes 8.7 | Widget 7.2 | Bought 4.3
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** verbatim retention; insights are R01-125..131
- **Canonical:** — (nuance register)

### R01-190 — High-volume markets: n, mean, 1★ %, dominant signal, purchase signal — full table

- **Where:** §6.3 high-volume table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Market | n | Mean | 1★% | Dominant signal | Purchase signal ; China | 40,991 | 4.82 | 1.1 | Review-farm filler; reports 1.9%; widget 0.9% | 0.86% — lowest of any major market ; Brazil | 756 | 4.13 | 9.3 | Localization 20.0% | 0.9% ; India | 672 | 4.54 | 6.4 | Crashes 4.6, widget 4.9, billing 1.3% | 3.1% ; Mexico | 377 | 4.27 | 8.0 | Localization 12.2% | 1.3% ; Turkey | 297 | 4.31 | 9.1 | Localization 14.5% | 3.4% ; Russia | 273 | 4.16 | 11.0 | Localization 16.1%, widget 7.7%, reports 4.8% | 4.8% ; Philippines | 210 | 4.62 | 3.3 | Widget 6.7, crashes 5.2, family plan 3.3% | 3.8% ; Vietnam | 208 | 4.66 | 2.4 | Widget 5.8, price-fair 3.4 | 2.4% ; Indonesia | 152 | 4.47 | 2.6 | Crashes 4.6, family plan 3.3% | 0% ; Colombia | 134 | 4.05 | 13.4 | Localization 15.7% | 0.7% ; Argentina | 108 | 4.34 | 2.8 | Localization 17.6% | 1.9% ; Ukraine | 105 | 4.15 | 11.4 | Localization 11.4%, crashes 6.7 | 4.8% ; Chile | 80 | 3.89 | 13.8 | Localization 33.8% — highest in the dataset | 0% ; Peru | 57 | 4.18 | 7.0 | Localization 17.5%, widget 8.8 | 3.5% ; Kazakhstan | 57 | 4.04 | 12.3 | Crashes 7.0, localization 10.5% | 1.8% ; Egypt | 103 | 4.56 | 6.8 | Widget 5.8, crashes 4.9 | 1.9% ; Malaysia | 109 | 4.59 | 3.7 | Widget 7.3, bought 6.4% | 6.4% ; South Africa | 73 | 4.49 | 5.5 | ADHD 5.5%, widget 5.5, bought 4.1 | 4.1% ; Thailand | 71 | 4.58 | 5.6 | Crashes 5.6, widget 5.6 | 0%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** verbatim retention; insights are R01-132..136
- **Canonical:** — (nuance register)

### R01-195 — US store themes with count, % of US and band — full table

- **Where:** §6.1 US table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | Count | % of US | Band ; Simple/clean UI | 1,750 | 32.19% | HIGH-PRIORITY ; Reminders | 508 | 9.35% | HIGH-PRIORITY ; Competitor named | 490 | 9.01% | HIGH-PRIORITY ; Streaks/gamification | 391 | 7.19% | HIGH-PRIORITY ; ADHD / neurodivergent | 385 | 7.08% | HIGH-PRIORITY ; Widget | 373 | 6.86% | HIGH-PRIORITY ; Crashes | 305 | 5.61% | HIGH-PRIORITY ; Customisation | 255 | 4.69% | VERY STRONG ; Confirmed purchase | 225 | 4.14% | VERY STRONG ; Fitness / weight / health | 215 | 3.96% | VERY STRONG ; Price is cheap/fair | 176 | 3.24% | VERY STRONG ; Lifetime / not-a-subscription | 134 | 2.47% | MEANINGFUL ; Shared/group habits | 129 | 2.37% | MEANINGFUL ; Students/exams | 127 | 2.34% | MEANINGFUL ; iCloud sync | 126 | 2.32% | MEANINGFUL ; Export | 92 | 1.69% | MEANINGFUL ; Quit bad habits | 85 | 1.56% | MEANINGFUL ; Apple Watch | 81 | 1.49% | MEANINGFUL ; Data loss | 78 | 1.43% | MEANINGFUL ; Focus timer | 72 | 1.32% | MEANINGFUL ; Mood/journal | 71 | 1.31% | MEANINGFUL ; Reports | 69 | 1.27% | MEANINGFUL ; Free habit cap complaint | 67 | 1.23% | MEANINGFUL ; Sub-tasks/grouping | 63 | 1.16% | MEANINGFUL ; Apple Health | 59 | 1.09% | MEANINGFUL ; Price too expensive | 51 | 0.94% | EMERGING
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** verbatim retention; insight is R01-117
- **Canonical:** — (nuance register)

## Dated events and trends

### R01-050 — Launch state 2019: 3 free habits, $4.99 lifetime, and the review→6-months-free campaign begins

- **Where:** §1.6 row 2019
- **This app does:** 3 free habits; $4.99 lifetime; CN review campaign
- **User reaction:** mixed
- **Magnitude:** dated event; no count
- **Direction for us:** none · **Report confidence:** timeline · **Generalisable:** app-specific
- **Review IDs:** `3916981057`
- **Canonical:** — (nuance register)

### R01-051 — 2020–mid 2021 was the goodwill peak: effectively unlimited free habits and free reports — 'can't believe it's free'

- **Where:** §1.6 row 2020–mid 2021
- **This app does:** unlimited free habits, reports free
- **User reaction:** praise
- **Magnitude:** 'peak can't-believe-it's-free goodwill'; no count
- **Direction for us:** none · **Report confidence:** timeline · **Generalisable:** yes
- **Conditions:** what followed (regressions) is measured against this peak
- **Canonical:** C001 Never move a free feature behind the paywall

### R01-052 — Paywall regression #1 (Jan 2022): reports, multi-reminder, iCloud sync and skip moved behind Premium; non-CN review volume spiked to 429/month

- **Where:** §1.6 row Jan 2022
- **This app does:** moved four free features behind paywall
- **User reaction:** 1★-burst
- **Magnitude:** non-CN volume spikes to 429/month
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `7242990766`, `7482039026`
- **Canonical:** C001 Never move a free feature behind the paywall; C011 Weekly / monthly / yearly reports; C013 Cloud sync / multi-device as the paid differentiator; C014 Multiple reminders per habit; C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R01-053 — Paywall regression #2 (Feb–Mar 2023): free habit cap introduced at 5, with some users seeing 3 or 6 (an A/B test)

- **Where:** §1.6 row Feb–Mar 2023
- **This app does:** introduced a free habit cap of 5 / 3 / 6
- **User reaction:** complaint
- **Magnitude:** dated event
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9825676857`, `9641681083`, `9803224178`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R01-054 — Quit / bad-habit mode shipped Sep 2023

- **Where:** §1.6 row Sep 2023
- **This app does:** shipped quit mode
- **User reaction:** praise
- **Magnitude:** dated event
- **Direction for us:** none · **Report confidence:** timeline · **Generalisable:** app-specific
- **Review IDs:** `13811111971`, `11131185906`
- **Canonical:** C019 Quit-habit / bad-habit mode

### R01-055 — Mood tracker + journal shipped Dec 2023

- **Where:** §1.6 row Dec 2023
- **This app does:** shipped mood tracker and journal
- **User reaction:** praise
- **Magnitude:** dated event; §3: mood/journal 316 (0.6%) global, 71 US (1.3%), mean 4.66
- **Direction for us:** research · **Report confidence:** meaningful (US) · **Generalisable:** yes
- **Review IDs:** `11907169613`, `12461799977`
- **Canonical:** C049 Mood tracker

### R01-056 — Paywall regression #3 (Apr 2024): report/calendar widget moved behind Premium AND a crash-on-launch regression on Apr 27–29 → 94 crash reviews in 3 days; the rating never fully recovered

- **Where:** §1.6 row Apr 2024
- **This app does:** re-paywalled the widget and shipped a launch crash the same month
- **User reaction:** 1★-burst
- **Magnitude:** 94 crash reviews in 3 days; 'the rating never fully recovered after Apr 2024'
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** two failures landing together compound; the report treats Apr 2024 as the turning point
- **Review IDs:** `11214694671`, `11209749389`, `11208599895`, `11208339326`, `11207697641`, `11212491544`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free; C031 Crashes / launch failures

### R01-057 — Paywall regression #4 (Dec 2024): yearly stats locked days before year-end, plus a 'minutes became hours' bug (goal values ×60) landing in New Year resolution season → worst month on record (mean 3.14)

- **Where:** §1.6 row Dec 2024
- **This app does:** locked yearly stats right before year-end; shipped a unit-conversion bug
- **User reaction:** 1★-burst
- **Magnitude:** worst month on record, non-CN mean 3.14; 65 of 227 reviews 1★
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** timing: the year-end report is the app's best emotional moment (Part 8 #4) — locking it or breaking it at year-end is maximally costly
- **Review IDs:** `12123611133`, `12133136766`, `12210864361`, `12144843194`, `12128653261`, `12127927438`, `12122368495`
- **Canonical:** C001 Never move a free feature behind the paywall; C032 New Year peak-season robustness — year-end report and January onboarding

### R01-058 — 2025–2026: the free cap was loosened back to 6 and non-members can check in freely; sentiment partially recovered

- **Where:** §1.6 row 2025–2026
- **This app does:** loosened cap to 6; free check-in
- **User reaction:** praise
- **Magnitude:** 'sentiment partially recovers'
- **Direction for us:** none · **Report confidence:** timeline · **Generalisable:** yes
- **Conditions:** recovery is partial only; 2025 mean still 3.73
- **Review IDs:** `13711763153`, `12338410317`, `13623783514`, `13624181624`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R01-095 — The year-end / year-in-review report crashed in Jan 2020, Dec 2020, Jan 2021, Dec 2024 and hung again Jan–Mar 2026 — same bug, same season, five years running

- **Where:** Part 4 crash timeline
- **This app does:** year-end report crashes every New Year
- **User reaction:** 1★-burst
- **Magnitude:** Jan 1–3 2020: 42 crash reviews; Dec 2020: 57 (Dec 10 alone 16); Jan 2021: 43; Dec 29–30 2024: 29 (alongside the stats paywall); Jan–Mar 2026: 49 at mean 2.24
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the year-end report is both the biggest emotional payoff and the most reliable crash; 'fixing New Year robustness is worth more than any new feature' (Part 8 #4)
- **Conditions:** load-test the year-end path before every December
- **Canonical:** C032 New Year peak-season robustness — year-end report and January onboarding

### R01-096 — The Apr 27–29 2024 launch-crash regression is the biggest single incident in the corpus (94 reviews in 3 days) even though it was fixed in ~2 days

- **Where:** Part 4 crash timeline row Apr 2024
- **This app does:** shipped a launch crash; fixed in ~2 days
- **User reaction:** 1★-burst
- **Magnitude:** 94 crash reviews in 3 days
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** two days of a launch crash produced more 1★ than years of minor bugs; the rating never fully recovered
- **Canonical:** C031 Crashes / launch failures

### R01-151 — 'Too expensive' peaked in 2024 (1.13%) as the lifetime price passed $8–9

- **Where:** Part 7 table row 'Price too expensive'
- **This app does:** raised lifetime price
- **User reaction:** complaint
- **Magnitude:** 0.18% (2019) → 1.13% (2024) → 0.71% (2026)
- **Direction for us:** research · **Report confidence:** moderate · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R01-152 — Billing complaints peaked in 2025 at 0.90% of non-CN reviews — nearly 10× the 2019–2023 level

- **Where:** Part 7 table row 'Billing errors'
- **This app does:** billing errors rose
- **User reaction:** 1★-burst
- **Magnitude:** 0–0.19% (2019–23) → 0.39% (2024) → 0.90% (2025) → 0.40% (2026)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right

### R01-153 — Crash share of non-CN reviews: 17.32% in 2020 (fragile launch era) → 2.43% in 2023 (best) → 5–6.5% in 2024–26

- **Where:** Part 7 table row 'Crashes'
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1.47 / 17.32 / 7.67 / 4.12 / 2.43 / 6.47 / 5.55 / 5.32 (% by year 2019–2026)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R01-154 — ADHD framing peaked at 4.07% of non-CN reviews in 2023 and has fallen since (1.16% in 2025)

- **Where:** Part 7 table row 'ADHD'
- **This app does:** positioned as ADHD planner
- **User reaction:** praise
- **Magnitude:** 0.37 (2019) → 4.07 (2023) → 1.16 (2025) → 1.67 (2026)
- **Direction for us:** do · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** the audience is still there; the app stopped earning their reviews as reliability fell
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R01-155 — Mood/journal and Apple Health mentions both peaked in 2025 (2.13% each) after the features shipped

- **Where:** Part 7 table rows 'Mood/journal', 'Apple Health'
- **This app does:** shipped mood/journal Dec 2023; broadened Health integration
- **User reaction:** praise
- **Magnitude:** mood/journal 0 → 2.13% (2025); Apple Health 0.9% → 2.13% (2025)
- **Direction for us:** research · **Report confidence:** moderate · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration; C049 Mood tracker

### R01-156 — Widget mentions held at 5–6.5% of non-CN reviews every year 2020–2025, then dipped to 4.21% in 2026

- **Where:** Part 7 table row 'Widget'
- **This app does:** widgets since 2020
- **User reaction:** praise
- **Magnitude:** 5.40 / 6.28 / 6.00 / 6.50 / 6.31 / 6.06 / 4.21 (2020–2026)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** the 2026 dip follows the Apr 2024 widget paywall and widget-reliability bugs
- **Canonical:** C009 Basic widgets, icons and colours are free

### R01-157 — Account/login requests are rising (0 → 0.32% in 2026) as more users change phones

- **Where:** Part 7 table row 'Account/login request'
- **This app does:** no account
- **User reaction:** complaint
- **Magnitude:** 0 (2019–21) → 0.32% (2026)
- **Direction for us:** must-have · **Report confidence:** weak but rising · **Generalisable:** yes
- **Canonical:** C035 Account system from day one

### R01-158 — 2023 was the best year in the app's history: US mean 4.54, crashes at 2.43%, scholarship program running, ADHD positioning at its strongest — the only sour note was the new free cap

- **Where:** Part 7 '2023 peak quality'
- **This app does:** stable app + scholarship + ADHD positioning
- **User reaction:** 5★-burst
- **Magnitude:** US mean 4.54; crashes 2.43%; ADHD 4.07%; free cap complaint 1.07%
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the winning configuration is on record: reliability + generosity + a clear audience
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R01-159 — 2026 partial recovery came from shipping localisation, loosening the free cap back to 6, and the developer becoming responsive — monthly means climbed back to 4.0–4.16

- **Where:** Part 7 '2026 partial recovery'
- **This app does:** shipped languages, loosened cap, became responsive
- **User reaction:** praise
- **Magnitude:** localisation 8.06% → 3.02%; mid-2026 monthly means 4.0–4.16
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C027 Localise early — it unlocks revenue; C059 Be visibly responsive; fixes bring reviewers back

### R01-191 — Share of non-China reviews mentioning each theme, by year 2019–2026 — full table

- **Where:** Part 7 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 | 2026 ; Confirmed purchase | 0.73 | 2.79 | 2.45 | 2.73 | 2.27 | 3.61 | 5.35 | 4.69 ; Lifetime/one-time praise | 1.28 | 0.74 | 1.39 | 1.21 | 1.43 | 1.70 | 2.71 | 3.18 ; Price cheap/fair | 1.10 | 2.61 | 1.88 | 1.61 | 3.14 | 3.25 | 3.23 | 2.62 ; Price too expensive | 0.18 | 0.56 | 0.49 | 0.63 | 0.76 | 1.13 | 0.77 | 0.71 ; Scholarship program | 0 | 0 | 0 | 0 | 0.96 | 1.20 | 0.06 | 0.24 ; Family plan problem | 0 | 0 | 0 | 0 | 0 | 0.50 | 1.94 | 1.83 ; Billing errors | 0 | 0.19 | 0.08 | 0.09 | 0.11 | 0.39 | 0.90 | 0.40 ; Free habit cap | 0.55 | 0.56 | 0.49 | 0.22 | 1.07 | 1.20 | 0.65 | 0.56 ; Crashes | 1.47 | 17.32 | 7.67 | 4.12 | 2.43 | 6.47 | 5.55 | 5.32 ; Data loss | 0 | 2.61 | 1.63 | 0.90 | 0.85 | 0.86 | 1.55 | 1.11 ; Sync failure | 0.18 | 1.12 | 0.82 | 0.45 | 0.31 | 0.45 | 1.35 | 0.56 ; Localization | 0.92 | 2.61 | 2.77 | 2.78 | 3.23 | 5.29 | 8.06 | 3.02 ; ADHD | 0.37 | 0.19 | 0.98 | 2.15 | 4.07 | 2.62 | 1.16 | 1.67 ; Mood/journal | 0 | 0.74 | 0.73 | 0.49 | 1.05 | 1.65 | 2.13 | 1.43 ; Apple Health | 0.92 | 0.93 | 0.90 | 0.54 | 0.85 | 0.92 | 2.13 | 1.11 ; Widget | 1.10 | 5.40 | 6.28 | 6.00 | 6.50 | 6.31 | 6.06 | 4.21 ; Account/login request | 0 | 0 | 0 | 0.09 | 0.13 | 0.18 | 0.13 | 0.32 ; Dev responsive | 0.18 | 0.19 | 0.08 | 0.22 | 0.58 | 0.73 | 0.58 | 0.32
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** verbatim retention; insights are R01-150..157
- **Canonical:** — (nuance register)

### R01-199 — Rating by year 2019–2026: US mean, US 1★ rate, China mean, non-CN note — full table

- **Where:** Part 0 §3 year table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | US mean | US 1★ rate | China mean | Non-CN mean ; 2019 | 4.61 | 1.6% | 4.81 | — ; 2020 | 3.81 | 16.2% | 4.48 | — ; 2021 | 4.30 | 7.5% | 4.85 | — ; 2022 | 4.43 | 6.5% | 4.85 | — ; 2023 | 4.54 | 5.4% | 4.68 | best year ; 2024 | 4.14 | 11.7% | 4.66 | —
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Conditions:** China mean fell from 4.85 (2021–22) to 4.37 (2026) even after the campaign ended; insight card is R01-004
- **Canonical:** — (nuance register)

## Positioning

### R01-001 — The app is the category leader: #1 rank in 59 storefronts, 530,893 ratings at 4.78, 56,653 reviews across 127 storefronts

- **Where:** header line 3-6
- **This app does:** market leader in the habit category; developer Inner Grow Limited, bundle com.davetech.habit, a.k.a. 'Habify' / '习惯清单'; publishes an app family (see R01-088)
- **User reaction:** mixed
- **Magnitude:** 530,893 ratings, 4.78 store avg; 56,653 reviews; #1 in 59 storefronts; Feb 2019 → Sep 2026
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Conditions:** store-level 4.78 is inflated by the China review campaign (see R01-002)
- **Canonical:** — (nuance register)

### R01-089 — Competitors are named in 9% of US reviews; US buyers anchor the price against Done ($29.99) and HabitBull ($20/yr)

- **Where:** Part 3 competitors paragraph
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 1,142 mentions (2.02% global, 9.01% US — HIGH-PRIORITY)
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** named: Streaks, Habitica, HabitBull, Habitify, Way of Life, Productive, Fabulous, Done, Loop, Finch, me+, Structured, Tally, HabitNow, TickTick, Todoist, Notion, Forest, Atoms, Strides, HabitShare; CN: 小日常, iBetter, 番茄ToDo, 滴答清单, 指尖时光, 目标地图, FastLog, 人升
- **Review IDs:** `10947705264`, `11520612891`, `8157182844`, `10633728275`, `10850980761`, `13825611867`, `10793490908`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C005 Know which competitors buyers compare against

### R01-116 — 'Too feminine / childish' design is a real, repeated critique from men and from users wanting a premium look

- **Where:** Part 5 'other asks' bullet 8
- **This app does:** pastel/cute default design
- **User reaction:** complaint
- **Magnitude:** several era-referenced IDs; Part 8 #21
- **Direction for us:** do · **Report confidence:** repeated, uncounted · **Generalisable:** yes
- **Conditions:** Part 8 #21: offer a design that isn't pastel/cute-by-default
- **Review IDs:** `14008424474`
- **Canonical:** C057 Offer a non-pastel / premium design option

### R01-122 — US users frame the app through 'Atomic Habits' and '75 Hard'

- **Where:** §6.1 US notes bullet 2
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 'heavy framing'; no count
- **Direction for us:** do · **Report confidence:** qualitative · **Generalisable:** yes
- **Canonical:** C070 Use the language users use: Atomic Habits, 75 Hard

## Anti-patterns

### R01-005 — Review-gating (route to the App Store only if the rating is high; swallow low ratings in-app) and deleting a critical review were both caught by users

- **Where:** Part 0 §3 line 54
- **This app does:** gates the review prompt; deleted at least one critical review
- **User reaction:** complaint
- **Magnitude:** 9 explicit gating/fake-review complaints; one UK user documented the routing; a Polish user called it an Apple ToS violation; one CN user documented a deleted critical review (Aug 2025)
- **Direction for us:** dont · **Report confidence:** weak signal (n=9) but reputational · **Generalisable:** yes
- **Review IDs:** `8836869044`, `6197402388`, `12993356431`, `12117289603`, `8707927339`, `8423423589`, `8258057981`, `7611186789`, `4640019537`, `11067543951`, `13173072726`
- **Canonical:** C055 Never gate or delete reviews

### R01-008 — The free habit cap was changed repeatedly — 3, unlimited, 5, 6, 4, even 2, back to 6 — as live A/B testing, and it visibly angers people

- **Where:** §1.1 line 85
- **This app does:** A/B tests the free cap; 3 (2019 and China throughout) → unlimited (2020–mid 2021) → 5 (2023) → 6 → 4 → 2 → 6 (2026)
- **User reaction:** complaint
- **Magnitude:** report calls it 'live A/B testing' that 'visibly angers people'; cap complaints carry ×7.5 lift on 2★ (Part 8 #9)
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** different users see different caps at the same time and compare notes in reviews
- **Review IDs:** `8599736021`, `13711763153`, `13742648539`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R01-139 — The review-for-premium campaign backfired reputationally: ~30 low-rated CN reviews attack the forced-review mechanic and ~15 say the promised membership never arrived

- **Where:** §6.4 bullet 6
- **This app does:** campaign with unreliable reward delivery
- **User reaction:** 1★-burst
- **Magnitude:** ~30 attacking the mechanic; ~15 'reward not delivered'; global 'review reward not delivered' 60 (0.11%)
- **Direction for us:** dont · **Report confidence:** moderate · **Generalisable:** yes
- **Side effects:** an incentive you fail to deliver is worse than no incentive
- **Review IDs:** `8038625627`, `8047806930`, `7751058710`, `7684468117`, `7823151695`, `8123994664`, `8110096979`, `9132316564`, `13567434379`, `9509273829`, `8945741828`, `8987285663`, `8663298319`, `8470403381`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R01-201 — By 2026 Chinese users report a paywall on the home page itself — 'you must pay just to reach the home page, minimum ¥48'

- **Where:** §6.4 bullet 5
- **This app does:** hard paywall at open in CN at ¥48
- **User reaction:** complaint
- **Magnitude:** 1 ID quoted; CN price ¥30 → ¥40 → ¥48
- **Direction for us:** dont · **Report confidence:** weak count, strong signal · **Generalisable:** yes
- **Side effects:** a paywall before first use is the most aggressive gating pattern in the report
- **Review IDs:** `14506100308`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

## Things not to do

### R01-184 — Don't build AI — 0.011% demand; build reliability instead

- **Where:** Part 8 #23
- **This app does:** no AI
- **User reaction:** none
- **Magnitude:** 6 of 56,653 reviews
- **Direction for us:** dont · **Report confidence:** high-priority (negative evidence) · **Generalisable:** yes
- **Conditions:** evidence: R01-161
- **Canonical:** C056 Don't build AI features on demand grounds

### R01-185 — Do not run review-for-premium campaigns — it gave this app 40,991 Chinese reviews, a #1 rank and a fake 4.8 average, but 0.86% purchase signal, a reputational backlash, and a dataset its own developer can no longer read honestly

- **Where:** Part 8 #24
- **This app does:** ran one 2019–2022
- **User reaction:** 1★-burst
- **Magnitude:** 40,991 reviews; 0.86% purchase signal; ~45 backlash reviews
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-002, R01-137, R01-139
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns

### R01-186 — Do not gate reviews — two users caught it, one called it an Apple ToS violation, one documented a critical review being deleted

- **Where:** Part 8 #25
- **This app does:** gated reviews
- **User reaction:** complaint
- **Magnitude:** 9 explicit complaints
- **Direction for us:** dont · **Report confidence:** weak count, reputational · **Generalisable:** yes
- **Conditions:** evidence: R01-005
- **Canonical:** C055 Never gate or delete reviews

## Things to do

### R01-121 — US discovery is TikTok / YouTube / Instagram / Reddit and therapist recommendation

- **Where:** §6.1 US notes bullet 1
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 5 IDs; no count
- **Direction for us:** do · **Report confidence:** qualitative · **Generalisable:** yes
- **Side effects:** therapist recommendation ties to the ADHD audience
- **Review IDs:** `14092312477`, `12824807574`, `11364976648`, `10633557367`, `10081645485`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R01-141 — China discovery is Xiaohongshu + Bilibili UP主 + Zhihu + Douban — the analogue of TikTok in the US

- **Where:** §6.4 bullet 8
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 8 IDs
- **Direction for us:** do · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `8002039077`, `8061243582`, `8509035588`, `8513588102`, `8554398766`, `7641461501`, `10049341224`, `12304607260`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R01-182 — Offer a design that isn't pastel/cute-by-default — a recurring complaint from men and from users wanting a premium look

- **Where:** Part 8 #21
- **This app does:** pastel/cute default
- **User reaction:** complaint
- **Magnitude:** recurring, uncounted
- **Direction for us:** do · **Report confidence:** repeated · **Generalisable:** yes
- **Conditions:** evidence: R01-116
- **Canonical:** C057 Offer a non-pastel / premium design option

### R01-183 — Localise early — it directly unlocks revenue: Spanish 182 requests, Portuguese 162, French 48, Russian 44, Turkish 43, Arabic, Korean; users state plainly they would buy in their language; Japan proved it mid-2026

- **Where:** Part 8 #22
- **This app does:** localised late, language by language
- **User reaction:** blocked-conversion
- **Magnitude:** 639 localisation reviews; 8.06% of non-CN reviews in 2025
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R01-037, R01-069, R01-128, R01-132
- **Canonical:** C027 Localise early — it unlocks revenue

## Contradictions

### R01-197 — The free habit cap is simultaneously the #1 monetization complaint and — as 'unlimited habits' — the #2 reason people pay; the report resolves it as 'cap generously (6+) and never move it', not 'no cap'

- **Where:** §1.2 rows 1 & 6 vs Part 8 #9
- **This app does:** cap 3–6, drifting
- **User reaction:** mixed
- **Magnitude:** cap complaint 296 reviews, ×7.5 on 2★; unlimited = #2 purchase reason
- **Direction for us:** undecided · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** see Research Reports/Feature Gating vs Quantity.md for the cross-app decision
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R01-198 — 'Price is cheap/fair' (608 reviews, mean 4.79) and 'too expensive' (209 reviews, ×3.4 on 1★) coexist for the same ~$10 lifetime price — the split follows market and year, not the price itself

- **Where:** Part 2 tables + §1.3
- **This app does:** one lifetime price, rising over time
- **User reaction:** mixed
- **Magnitude:** cheap/fair 608 (1.07%) vs too expensive 209 (0.37%); 'too expensive' peaked 2024 at 1.13% of non-CN
- **Direction for us:** research · **Report confidence:** moderate · **Generalisable:** yes
- **Conditions:** rich English markets say fair; volume markets with weak payment rails and no localisation say expensive
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

## Data caveats and method

### R01-003 — 39.1% of all reviews are under 12 characters — four in ten reviews contain zero product information

- **Where:** Part 0 §2 line 36
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 22,136 reviews (39.1%) under 12 chars, mean 4.86
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Side effects:** any count in this report is diluted by this filler; the report counts them in every denominator
- **Canonical:** — (nuance register)

### R01-149 — For product decisions weight the US and rich-market columns far more heavily than the global column, which is diluted by 22,136 contentless reviews

- **Where:** §6.5 caution
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** method note
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R01-187 — Method: every review processed; all 1–3★ and substantive reviews read individually; contentless reviews aggregated by frequency; 62 themes applied across 20+ languages; four denominators; three regex false-positive classes corrected

- **Where:** Appendix — method
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 56,653 reviews; 62 themes; signal bands <0.1% ignore / 0.1–0.5% weak / 0.5–1% emerging / 1–3% meaningful / 3–5% very strong / >5% high-priority; four denominators (US, each rich market, each of 45 countries with 50+ reviews, global); 82 storefronts under 50 reviews (824 reviews, mean 4.43) skipped individually but counted globally
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Conditions:** this report predates the current Store Review Analysis Prompt structure (no Part 9 appendix, different part numbering)
- **Canonical:** — (nuance register)

### R01-192 — Global theme rollup, all 60 themes with count, % and band — full table

- **Where:** §6.5 global rollup (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | Count | % | Band ; Simple/clean UI | 11,969 | 21.13% | HIGH-PRIORITY ; Reminders | 2,162 | 3.82% | VERY STRONG ; Customisation | 1,550 | 2.74% | MEANINGFUL ; Review-for-premium campaign | 1,365 | 2.41% | MEANINGFUL ; Widget | 1,297 | 2.29% | MEANINGFUL ; Streaks/gamification | 1,202 | 2.12% | MEANINGFUL ; Competitor named | 1,142 | 2.02% | MEANINGFUL ; Crashes | 1,072 | 1.89% | MEANINGFUL ; Fitness/health use | 1,049 | 1.85% | MEANINGFUL ; Reports/stats | 1,009 | 1.78% | MEANINGFUL ; Students/exams | 800 | 1.41% | MEANINGFUL ; Confirmed purchase | 759 | 1.34% | MEANINGFUL ; Localization request | 639 | 1.13% | MEANINGFUL ; Price cheap/fair | 608 | 1.07% | MEANINGFUL ; ADHD/neurodivergent | 555 | 0.98% | EMERGING ; Shared/group habits | 529 | 0.93% | EMERGING ; iCloud sync | 517 | 0.91% | EMERGING ; Focus timer | 452 | 0.80% | EMERGING ; Export request | 442 | 0.78% | EMERGING ; Lifetime/one-time praise | 430 | 0.76% | EMERGING ; Flexible units | 371 | 0.65% | EMERGING ; Mood/journal | 316 | 0.56% | EMERGING ; Free habit cap complaint | 296 | 0.52% | EMERGING ; Social referral | 293 | 0.52% | EMERGING ; Apple Watch | 283 | 0.50% | WEAK ; Sub-tasks/grouping | 275 | 0.49% | WEAK ; Quit bad habits | 271 | 0.48% | WEAK ; One-off to-dos | 237 | 0.42% | WEAK ; No-trial-before-pay | 217 | 0.38% | WEAK ; Data loss | 211 | 0.37% | WEAK ; Price too expensive | 209 | 0.37% | WEAK ; No-ads praise | 182 | 0.32% | WEAK ; Apple Health | 179 | 0.32% | WEAK ; Sync failure | 134 | 0.24% | WEAK ; Interactive widget request | 128 | 0.23% | WEAK ; Parents/kids use | 118 | 0.21% | WEAK ; Account/login request | 109 | 0.19% | WEAK ; Every-X-days request | 107 | 0.19% | WEAK ; Billing errors | 102 | 0.18% | WEAK ; Scholarship program | 101 | 0.18% | WEAK ; Dev responsive | 98 | 0.17% | WEAK ; Android request | 94 | 0.17% | WEAK ; Chronic illness / meds | 90 | 0.16% | WEAK ; Shortcuts/Siri | 87 | 0.15% | WEAK ; Paywall regression | 75 | 0.13% | WEAK ; Would-pay-if | 74 | 0.13% | WEAK ; Family plan problem | 73 | 0.13% | WEAK ; Mac/Windows/web | 67 | 0.12% | WEAK ; Shared-habit failure | 66 | 0.12% | WEAK ; Reminder broken | 66 | 0.12% | WEAK ; Review reward not delivered | 60 | 0.11% | WEAK ; Widget broken | 60 | 0.11% | WEAK ; Support the devs | 51 | 0.09% | IGNORE globally ; Restore purchase broken | 49 | 0.09% | IGNORE globally ; Streak/stat wrong | 44 | 0.08% | IGNORE globally ; No support channel | 28 | 0.05% | IGNORE globally ; DST/timezone | 28 | 0.05% | IGNORE globally ; Edit wipes history | 20 | 0.04% | IGNORE globally ; Photo attachment | 16 | 0.03% | IGNORE globally ; Review gating | 9 | 0.02% | IGNORE globally
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** verbatim retention; global column is diluted by 22,136 contentless reviews (R01-149)
- **Canonical:** — (nuance register)
