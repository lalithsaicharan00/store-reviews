# Cards — report 34

Source: `App Store Reports/34. Habit Tracker - Evoday - Daily Streaks Calendar & Goals (REPORT).md`  
235 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 13
- [Must-haves](#must-haves) — 1
- [Must never break](#must-never-break) — 19
- [Features](#features) — 38
- [Monetization](#monetization) — 26
- [Tactics the app used](#tactics-the-app-used) — 7
- [Insights (the why)](#insights-the-why) — 35
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 13
- [Dated events and trends](#dated-events-and-trends) — 20
- [Positioning](#positioning) — 9
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 7
- [Things to do](#things-to-do) — 8
- [Contradictions](#contradictions) — 6
- [Data caveats and method](#data-caveats-and-method) — 30

## Product rules

### R34-112 — Data-exit restrictions and lifetime entitlement are kept despite n = 2 each because of their nature: data lock-in (2, both 1★, mean 1.00) carries legal and trust consequences out of proportion to its count; lifetime entitlement disputes (2, mean 2.50) concern paid entitlement

- **Where:** §3.1 Kept despite small counts — data lock-in (2, both 1★): data-exit restrictions carry legal and trust consequences out of proportion to their count; lifetime entitlement (2) concerns paid entitlement
- **This app does:** export disabled; backup gated; lifetime disputes
- **User reaction:** churn
- **Magnitude:** lock-in 2 (1.00, 100% 1★); lifetime 2 (2.50)
- **Direction for us:** product-rule · **Report confidence:** kept despite small counts · **Generalisable:** yes
- **Review IDs:** `12046497872`, `13731751322`, `13392990758`, `14138883204`
- **Canonical:** C020 Data export / backup / CSV; C176 Never let fear of losing history be the reason people pay; C186 Never revoke what earlier buyers paid for when the model changes

### R34-114 — Never make data exit a reason to keep paying: data lock-in (export disabled, backup gated) — 2 reviews at mean 1.00, 100% 1★ — 'forced to keep paying … if you don't want to lose all your history'

- **Where:** §3.2 Data lock-in — 'forced to keep paying … if you don't want to lose all your history'
- **This app does:** export disabled, backup gated
- **User reaction:** churn
- **Magnitude:** 2, mean 1.00, 100% 1★
- **Direction for us:** product-rule · **Report confidence:** kept despite small count · **Generalisable:** yes
- **Review IDs:** `13731751322`, `12046497872`
- **Canonical:** C020 Data export / backup / CSV; C176 Never let fear of losing history be the reason people pay

### R34-115 — Everyday features behind the paywall read as 'pay to use it': other gated features (widgets, notes, colours) 11 reviews, mean 1.55, 72.7% 1★ — 'Horrível tem que pagar' ('Horrible, you have to pay') — worse than the cap itself (2.44)

- **Where:** §3.2 Other gated feature — widgets, notes and colours behind the paywall read as 'pay to use it' ('Horrível tem que pagar'); 72.7% 1★
- **This app does:** widgets / notes / colours paid
- **User reaction:** complaint
- **Magnitude:** 11, mean 1.55, 72.7% 1★ (vs cap 2.44, 38.5%)
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12760639157`, `13605658579`, `10828741313`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free; C133 Gate on capability, not on quantity

### R34-123 — The cap itself is tolerated by many; what turns a free user into a 1★ is hitting the wall without warning, with no way to evaluate the paid product, and seeing everyday features (widgets, colours, notes) behind it

- **Where:** §3.3 Interpretation — what turns a free user into a 1★ is hitting the wall without warning, with no way to evaluate the paid product, and seeing everyday features (widgets, colours, notes) behind it
- **This app does:** 2-habit cap, gated extras, inconsistent trial
- **User reaction:** 1★-burst
- **Magnitude:** friction 78 → 75.7% of 1★
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C147 Let people use the product before they pay; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R34-143 — Keep the widget free: widgets put the streak / year grid on the home screen ('A widget in the Home Screen is for me more useful than a random notification'), 'the new widgets are a huge selling point', and gating them risks turning the most-praised recent feature into a 1★ theme ('Cant use widgets without subscription', 1★)

- **Where:** §4.2 Interpretation — widgets are the second visible surface of the year-grid idea; 'A widget in the Home Screen is for me more useful than a random notification'; gating them risks turning the most-praised recent feature into a 1★ theme
- **This app does:** widgets partly gated 2025
- **User reaction:** praise
- **Magnitude:** praise 24 (3.23%) vs paywalled 2 (1★)
- **Direction for us:** build-free · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `11481363538`, `12760639157`, `11077980453`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R34-148 — Pair local-first privacy with optional iCloud sync: portability is the cost of the privacy stance, and optional iCloud sync keeps data off the developer's servers while fixing data loss, multi-device use and exit

- **Where:** §4.3 Interpretation — portability is the cost of the privacy stance; optional iCloud sync would keep data off the developer's servers while fixing loss, multi-device use and exit
- **This app does:** local only
- **User reaction:** mixed
- **Magnitude:** privacy 7 vs loss 4 + no-sync 3 + platforms 18 + exit 2
- **Direction for us:** build-free · **Report confidence:** interpretation · **Generalisable:** yes
- **Side effects:** also unlocks iPad / Mac and removes reinstall data loss
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C085 Address tracking / privacy visibly; C153 Automatic cloud backup on by default — never manual opt-in

### R34-175 — A lifetime model obliges the developer to honour and migrate, not withdraw: a lifetime purchase is a bet on continuity, and lifetime holders' only negative reviews concern continuity — the one-time option disappearing and a lifetime licence that 'won't be working anymore'

- **Where:** §6.7 The lifetime holder is the most sensitive customer — a lifetime purchase is a bet on continuity; their only negatives concern continuity; a lifetime model obliges the developer to honour and migrate, not withdraw
- **This app does:** lifetime disputes
- **User reaction:** churn
- **Magnitude:** 2 reviews
- **Direction for us:** must-never-break · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `13392990758`, `14138883204`
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

### R34-200 — Restraint is a feature: simplicity is praised in 37% of reviews and reviewers name 'hokey games', 'cutesy interfaces' and 'decision fatigue' as reasons they left rivals

- **Where:** Part 9 #2 — restraint is a feature: simplicity praised in 37%; 'hokey games', 'cutesy interfaces' and 'decision fatigue' named as reasons they left rivals
- **This app does:** minimal
- **User reaction:** praise
- **Magnitude:** 275 (37.01%)
- **Direction for us:** product-rule · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `6713570145`, `11286612018`, `11257213711`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R34-202 — Never surprise users with the wall: disclosure complaints are few but come from people who searched for 'free'

- **Where:** Part 9 #4 — never surprise users with the wall: disclosure complaints are few but come from people who searched for 'free'
- **This app does:** limit disclosed late
- **User reaction:** complaint
- **Magnitude:** 3 (mean 2.33)
- **Direction for us:** product-rule · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `12233797625`, `11348148556`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R34-203 — Offer lifetime, then keep the promise: lifetime is a reason to buy, withdrawing it is a reason for 2★

- **Where:** Part 9 #5 — offer lifetime, then keep the promise: lifetime is a reason to buy; withdrawing it is a reason for 2★
- **This app does:** lifetime
- **User reaction:** mixed
- **Magnitude:** one-time praise 15 (4.87); lifetime complaint 2★
- **Direction for us:** must-never-break · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `11286612018`, `11583264179`, `14138883204`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C186 Never revoke what earlier buyers paid for when the model changes

### R34-204 — Local-first privacy wins praise, but add optional sync — otherwise data loss and single-device use follow

- **Where:** Part 9 #6 — local-first privacy wins praise, but add optional sync; otherwise data loss and single-device use follow
- **This app does:** local only
- **User reaction:** mixed
- **Magnitude:** privacy 7; loss 4; platforms 18
- **Direction for us:** build-free · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Canonical:** C085 Address tracking / privacy visibly; C153 Automatic cloud backup on by default — never manual opt-in

### R34-214 — Keep at least one widget and basic colours in the free tier — gated features have the worst mean of any theme with n ≥ 5 (1.55); widgets are the top new praise

- **Where:** Part 10 #9 (§10.3)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** gated 1.55; widget praise 24
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12760639157`, `13629525960`
- **Canonical:** C009 Basic widgets, icons and colours are free; C133 Gate on capability, not on quantity

### R34-226 — Keep gamification optional — demand is split

- **Where:** Part 10 #21 (§10.4)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 5 requests vs many praising absence
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `5389230957`, `10128198936`
- **Canonical:** C024 Streaks / gamification; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

## Must-haves

### R34-080 — Answer support e-mail: a single report says 'Support doesn't respond to emails' in an app whose main asset is a responsive developer; support contact positive in 7 (0.94%, mean 4.57)

- **Where:** §2.4 Signals reviewers find troubling — support doesn't respond to emails (single report)
- **This app does:** support mostly responsive
- **User reaction:** complaint
- **Magnitude:** unresponsive 1; positive 7 (0.94%), mean 4.57
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10904298957`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

## Must never break

### R34-025 — Never disable data export: 'Out of nowhere, the developer decided to disable CSV exports … years of data are stuck in this app' (1★, Feb 2026; 'Extremely shady practices here') — a single review, high consequence, in a local-first app with no account where export is the only way out

- **Where:** Executive summary #6 — CSV export disabled (Feb 2026, 1★)
- **This app does:** CSV export disabled 2026
- **User reaction:** churn
- **Magnitude:** n=1, 1★
- **Direction for us:** must-never-break · **Report confidence:** weak individually; high consequence · **Generalisable:** yes
- **Review IDs:** `13731751322`
- **Canonical:** C020 Data export / backup / CSV; C155 Never remove a feature people bought the app for — add alongside, do not replace; C176 Never let fear of losing history be the reason people pay

### R34-026 — Never require a paid backup before a user can delete or leave: in Dec 2024 deleting required a backup described as paid (1★)

- **Where:** Executive summary #6 — backup required (and paid) before deleting
- **This app does:** backup paid, required before delete
- **User reaction:** complaint
- **Magnitude:** n=1, 1★
- **Direction for us:** must-never-break · **Report confidence:** weak individually; high consequence · **Generalisable:** yes
- **Review IDs:** `12046497872`
- **Canonical:** C020 Data export / backup / CSV; C176 Never let fear of losing history be the reason people pay

### R34-027 — Honour lifetime purchases and do not silently remove the one-time option: 'After updating the app this option is gone' (Nov 2025) and 'After a year or two, your "lifetime" subscription wont be working anymore' (Jun–Jul 2026)

- **Where:** Executive summary #6 — lifetime option removed or not honoured
- **This app does:** one-time option removed in some storefronts; lifetime disputes
- **User reaction:** churn
- **Magnitude:** 2 reviews
- **Direction for us:** must-never-break · **Report confidence:** weak individually; high consequence · **Generalisable:** yes
- **Review IDs:** `13392990758`, `14138883204`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C186 Never revoke what earlier buyers paid for when the model changes

### R34-028 — Reminders must be settable: the reminder time picker broke for a paying user (Dec 2025) and a reminder could only be set to the current time (Mar 2026)

- **Where:** Executive summary #6 — reminder time picker broken for a paying user (Dec 2025, Mar 2026)
- **This app does:** reminder picker bug
- **User reaction:** complaint
- **Magnitude:** 2 reviews
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13505537432`, `13868583107`
- **Canonical:** C039 Reminders fire reliably, once; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R34-066 — Widgets must render on every home-screen mode: in Sep 2024 the widget turned white with the iOS 18 tinted home screen, and widget rendering broke for 5 (0.67%, mean 3.40, 3.0% of E4); 'stunning but have some minor errors'

- **Where:** §2.2 Sep 2024 widget turns white with iOS 18 tinted home screen; widget broken 5 (0.67%)
- **This app does:** widget rendering bugs
- **User reaction:** complaint
- **Magnitude:** 5 (0.67%), mean 3.40; E4 3.0%
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11740378083`, `11138339931`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R34-067 — An alternate app icon that stops changing after updates recurred three times (Dec 2021, 2023, 2024): 4 reviews (0.54%, mean 4.00)

- **Where:** §2.2 Dec 2021 alternate app icon stops changing after an update (also 2023, 2024); 4 (0.54%)
- **This app does:** alternate icon broken repeatedly
- **User reaction:** complaint
- **Magnitude:** 4 (0.54%), mean 4.00
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** app-specific
- **Review IDs:** `8172167468`, `10209615596`, `10781087412`
- **Canonical:** C018 App-icon themes; C175 Updates must not break function or wipe progress

### R34-068 — Reminders stop firing after updates: notifications stopped after one 2021 update, and reminders not firing / broken in 5 (0.67%, mean 3.40)

- **Where:** §2.2 2021 notifications stop firing after one update; reminders not firing / broken 5 (0.67%)
- **This app does:** reminder regressions
- **User reaction:** complaint
- **Magnitude:** 5 (0.67%), mean 3.40
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `6830197392`, `13505537432`, `13868583107`
- **Canonical:** C039 Reminders fire reliably, once; C175 Updates must not break function or wipe progress

### R34-069 — The app must open on the first launch: in Feb 2026 a reviewer had to open it 20–30 times to get it to load (rated 5★ nonetheless)

- **Where:** §2.2 Feb 2026 app needs 20–30 launches to load
- **This app does:** load failure 2026
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13744408241`
- **Canonical:** C031 Crashes / launch failures

### R34-098 — Data & entitlement trust union 10 (1.35%, mean 2.80, 3 1★): data lock-in, lifetime removed / not honoured, entitlement lost, data lost

- **Where:** §3.1 theme table #43 Data & entitlement trust (union)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 10 (1.35%), mean 2.80
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C020 Data export / backup / CSV; C034 Data must never be lost on update, reinstall or phone change; C186 Never revoke what earlier buyers paid for when the model changes

### R34-101 — Regressions (update broke / feature removed) 7 (0.94%, mean 4.29); an update broke something 6 (0.81%, mean 4.83)

- **Where:** §3.1 theme table #52/#60 Regression (union) / an update broke something
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 7 (0.94%), mean 4.29; 6 (0.81%), mean 4.83
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C175 Updates must not break function or wipe progress

### R34-108 — Data / history lost 4 (0.54%, mean 3.50), including 5★ 'Lost all data' and loss after a factory reset without sync

- **Where:** §3.1 theme table #72 Data / history lost
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 (0.54%), mean 3.50
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R34-130 — Broken capabilities (existed, then stopped): alternate app icon (4), widget rendering (5), reminders (5), launch crashes (3), Shortcuts (1), template name in notifications (1)

- **Where:** §3.5 Broken — alternate app icon (4), widget rendering (5), reminders (5), launch crashes (3), Shortcuts, template name in notifications
- **This app does:** various regressions
- **User reaction:** complaint
- **Magnitude:** 4 / 5 / 5 / 3 / 1 / 1
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11817893086`, `12088715354`
- **Canonical:** C039 Reminders fire reliably, once; C040 Widgets must not go blank, stale or disagree with the app; C175 Updates must not break function or wipe progress

### R34-144 — A widget that fails for a payer reads as wasted money: 'does not work on iphone :: waste money' (1★ payer), 'keeps getting disabled', two of six widgets don't show days

- **Where:** §4.2 widget problems — 'keeps getting disabled'; 'does not work on iphone :: waste money'; two of six widgets don't show days
- **This app does:** widget bugs
- **User reaction:** complaint
- **Magnitude:** 5 (0.67%), mean 3.40
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11081066933`, `11520002759`, `12326097524`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R34-146 — Local-only data loses users' history: data lost on reinstall, reset or for no reason (4) — 'after 9 months … All my data has been deleted!'; 'lost my data when I did a factory reset'; 'thought this app supports iCloud sync and re-installed app … lost all data as this app needs backup file'; no sync / manual backup needed (3) — 'iCloud sync doesn't work … I manually import/export'; 'basic sync is missing'

- **Where:** §4.3 The same design causes portability complaints — data lost on reinstall, reset or for no reason (4); no sync, explicit backup needed (3); no iPad/Mac/web/Watch (18); exit restricted (2, both 1★)
- **This app does:** local-only, manual backup file
- **User reaction:** complaint
- **Magnitude:** lost 4; no-sync 3
- **Direction for us:** must-never-break · **Report confidence:** meaningful (cluster) · **Generalisable:** yes
- **Review IDs:** `4968235247`, `7344582690`, `10781087412`, `4289434524`, `3550808186`, `11674162846`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R34-172 — What goes wrong after payment (segment rates on 51): reminders not firing 3 (5.9%) — a German 2019 buyer 'for support' got no notifications and returned the purchase; requests 8 (15.7%, Mac / web, stats, notes, quantities); price or trial objection while paying 1 ('Subtracted a star for cost (I paid for a month so far.)'); widget broken 1 ('waste money'); lifetime entitlement lost 1; refund / returned 1

- **Where:** §6.5 What goes wrong after payment (verbatim table) — reminders 3 (5.9%); requests 8 (15.7%); price/trial 1; widget broken 1; lifetime lost 1; refund 1
- **This app does:** post-purchase failures
- **User reaction:** complaint
- **Magnitude:** Problem | n (within 51 payers) | % of payers | Evidence ; Reminders not firing / broken | 3 | 5.9% | 4411089829 (German, 2019: bought "for support", no notifications, returned the purchase), 5535050975 (1★), 13505537432 ; Requests (Mac / web, stats, notes, quantities) | 8 | 15.7% | 12188850466, 3580101644, 9082639448, 11636711003 ; Price or trial objection while paying | 1 | 2.0% | 6831122754 ("Subtracted a star for cost (I paid for a month so far.)") ; Widget broken | 1 | 2.0% | 12326097524 ("waste money") ; Lifetime entitlement lost | 1 | 2.0% | 14138883204 ; Refund / returned | 1 | 2.0% | 4411089829
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `4411089829`, `5535050975`, `13505537432`, `12188850466`, `3580101644`, `9082639448`, `11636711003`, `6831122754`, `12326097524`, `14138883204`
- **Canonical:** C039 Reminders fire reliably, once; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R34-209 — Restore CSV export for everyone; never gate data exit or deletion behind payment

- **Where:** Part 10 #4 (§10.2)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** both lock-in reviews 1★
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13731751322`, `12046497872`
- **Canonical:** C020 Data export / backup / CSV; C176 Never let fear of losing history be the reason people pay

### R34-210 — Honour existing lifetime licences and publish what 'lifetime' covers; if the one-time option is withdrawn in a storefront, say so on the paywall

- **Where:** Part 10 #5 (§10.2)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 2 reviews
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13392990758`, `14138883204`
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

### R34-211 — Fix the reminder time picker — a paying user threatens to cancel; repeated Mar 2026

- **Where:** Part 10 #6 (§10.2)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 2 reviews
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13505537432`, `13868583107`
- **Canonical:** C039 Reminders fire reliably, once

### R34-212 — Fix widget rendering (tinted mode, missing days, widgets disabling) and the 2026 launch failure

- **Where:** Part 10 #7 (§10.2)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** widget broken 5; launch 1
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11740378083`, `11081066933`, `11520002759`, `12326097524`, `13744408241`
- **Canonical:** C031 Crashes / launch failures; C040 Widgets must not go blank, stale or disagree with the app

## Features

### R34-010 — A per-habit year grid / 'year in pixels' / GitHub-contribution-style heatmap is the one feature reviewers say rivals lack and it sells the app: 105 reviews (14.13%, no 1★) — 'the only habit tracker I could find with a whole year view'; 'I have never seen another app doing this'; 'The year in pixels completely sold me'; 'the dev is a fan of the GitHub commit tracker because that's basically what I was looking for'

- **Where:** Executive summary #1 — year grid is the one feature reviewers say rivals lack
- **This app does:** free, per habit, since 2018; monthly view added ~Apr 2020
- **User reaction:** purchase-driver
- **Magnitude:** 105 (14.13%), zero 1★
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10791779600`, `9730846797`, `9667437355`, `14284351778`, `2901595370`, `11670216762`
- **Canonical:** C012 Week / month / year grid views

### R34-021 — Home-screen widgets were the #1 request for four years: 30 requests (4.04%, very strong), peaking at 11.1% of E3 (Jun 2023 – Mar 2024) — 'I'll take one star off for a widget … I promise … to put it back'

- **Where:** Executive summary #5 — widgets were the #1 request for four years: 30 (4.04%, very strong), peak 11.1% of E3
- **This app does:** absent until ~mid-Mar 2024
- **User reaction:** complaint
- **Magnitude:** 30 (4.04%); 11.1% of E3
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `10552434405`, `6576140378`, `6580579419`, `6901067746`, `11004886291`
- **Canonical:** C009 Basic widgets, icons and colours are free; C107 Widget variants and customisation as the paid layer

### R34-023 — After static widgets ship, the next ask is interactive widgets (tick a habit from the widget): 7 reviews (0.94%), all after the launch — 'The widgets still aren't interactive' (Feb 2026); one reviewer calls the widgets interactive (Dec 2024), unresolved

- **Where:** Executive summary #5 — the new ask is interactive widgets: 7 (0.94%), all after launch
- **This app does:** widgets not interactive
- **User reaction:** complaint
- **Magnitude:** 7 (0.94%)
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13731564617`, `11412519740`, `11977577005`, `12089656951`
- **Canonical:** C023 Interactive widget check-off

### R34-024 — Widgets are behind the paywall for some users and free for others: 'Cant use widgets without subscription' (1★) and a 3-day-trial complaint vs 'still have some access to widgets' in free

- **Where:** Executive summary #5 — widgets are behind the paywall for some users
- **This app does:** widgets mixed free/paid
- **User reaction:** complaint
- **Magnitude:** 2–3 reviews
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** possibly storefront or A/B difference
- **Review IDs:** `12760639157`, `12738794859`, `13467704260`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free

### R34-043 — One-tap daily check-off on a Today list, with haptics, is free and is what 'simple' means to reviewers ('only takes one touch'; 'only takes two clicks … the haptics'); haptics praised in 3

- **Where:** §2.1 One-tap daily check-off on a Today list, with haptics — free
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** inventory; haptics 3 (weak)
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `5483779509`, `8439520479`, `13714210053`, `3249145216`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C069 Check-off sound and haptic

### R34-044 — A monthly calendar view (added ~Apr 2020, 'the new changes to see your habits in a monthly view') and a weekly view are free

- **Where:** §2.1 Monthly calendar view (added ~April 2020), weekly view — free
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** inventory
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `5755729025`, `7978390766`, `10830863058`
- **Canonical:** C012 Week / month / year grid views

### R34-045 — Streak count, success %, all-time stats and a trophy on a streak are free; the free stats screen is called 'a bit too simple'

- **Where:** §2.1 Streak count, success %, all-time stats; trophy on a streak — free (stats screen 'a bit too simple' in free)
- **This app does:** free basic stats
- **User reaction:** mixed
- **Magnitude:** inventory
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `3944773451`, `6897036135`, `11886940987`, `4720994358`, `13827396231`
- **Canonical:** C011 Weekly / monthly / yearly reports; C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells

### R34-046 — Flexible frequency — daily, x days per week (added ~Apr 2019 on request), weekly and monthly, 'no need to set days' — is free; flexible frequency praised in 13 (1.75%, mean 4.92)

- **Where:** §2.1 Frequency: daily; x days per week (added ~April 2019); weekly and monthly; 'no need to set days' — free
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** 13 (1.75%), mean 4.92
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `3954949955`, `4462219747`, `5263624340`, `12356034152`, `13627360138`
- **Canonical:** C043 Flexible / custom frequency

### R34-047 — Back-filling past days (night-shift use) and long-press to mark yesterday are free and praised (10, 1.35%, mean 4.90); import of old data was listed as Premium in 2019

- **Where:** §2.1 Back-filling past days; import of old data; long-press to mark yesterday — import listed as Premium in 2019
- **This app does:** back-fill free; import Premium 2019
- **User reaction:** praise
- **Magnitude:** 10 (1.35%), mean 4.90
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `3944773451`, `4497735688`, `10732085902`, `12073306064`
- **Canonical:** C010 Backfill missed days / edit start date

### R34-048 — Reminders — several per habit ('3 reminders a day'), per-week schedules — are free and praised in 16 (2.15%, mean 4.69); one reviewer says 'only 2 reminders without paying' (probably the habit cap)

- **Where:** §2.1 Reminders: several per habit, per-week schedules — free; 'only 2 reminders without paying' (probably the habit cap)
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** 16 (2.15%), mean 4.69
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `4455008126`, `4462219747`, `9730342132`, `12124114850`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C014 Multiple reminders per habit

### R34-049 — Notes per completed day (from Dec 2019) are Premium ('the paid versions allow you to put notes in'); notes praised in 11 (1.48%, mean 4.91) and gated notes appear among the worst-rated 'have to pay' complaints

- **Where:** §2.1 Notes per completed day — Paid
- **This app does:** paid
- **User reaction:** mixed
- **Magnitude:** notes praised 11 (1.48%), mean 4.91
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `5291008046`, `5653262510`, `6484426109`, `11810063518`, `8181313423`, `13605658579`
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R34-050 — Customisation — per-habit colours including a hex code, emoji in titles, alternate app icons, dark mode — is praised (32, 4.31%, mean 4.97) and partly Premium: dark mode and app colour (2019) and custom colours are paid ('Cant' use colours without paying' among the worst-rated gates)

- **Where:** §2.1 Colours per habit (incl. hex code), emoji in titles, alternate app icons, dark mode — Paid in part: dark mode and app colour, colours
- **This app does:** partly paid (dark mode, app colour, colours)
- **User reaction:** mixed
- **Magnitude:** customisation praised 32 (4.31%), mean 4.97
- **Direction for us:** undecided · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `5732133041`, `10801319167`, `13325880808`, `3413286186`, `4462219747`, `4497735688`, `13629525960`, `13919822858`
- **Canonical:** C009 Basic widgets, icons and colours are free; C018 App-icon themes; C080 Colour themes / dark mode

### R34-051 — Habit templates, archive, hide/show and reorder are free

- **Where:** §2.1 Habit templates; archive; hide/show; reorder — free
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** inventory
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11306521525`, `12088715354`, `13325880808`, `6713570145`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free; C118 Preset routines / templates / programs

### R34-052 — Share cards for social media (2021, 'ready made posts for bragging'; 'send screenshots of main grid to friends') are free and praised in 6 (0.81%, mean 5.00)

- **Where:** §2.1 Share cards for social media — free (2021 'ready made posts for bragging')
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** 6 (0.81%), mean 5.00
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `7906994184`, `10032640576`, `14088036663`
- **Canonical:** C202 A light social layer that is explicitly not a social network

### R34-053 — Local-first data — stored on the device ('my data isn't stored on a server'), iCloud device backup, manual CSV export/import and a backup file — with no account; privacy praised in 7 (0.94%, mean 4.29); CSV export was disabled in 2026 and backup described as paid

- **Where:** §2.1 Local-first data: on the device / iCloud device backup; manual export/import (CSV); backup file — CSV export disabled in 2026; backup described as paid
- **This app does:** local-first, no account; export disabled 2026
- **User reaction:** mixed
- **Magnitude:** privacy 7 (0.94%), mean 4.29
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `4497735688`, `6791860731`, `3550808186`, `4122355171`, `11674162846`, `13731751322`, `12046497872`
- **Canonical:** C020 Data export / backup / CSV; C085 Address tracking / privacy visibly; C153 Automatic cloud backup on by default — never manual opt-in

### R34-055 — No Apple Watch app (requested 2021 → 2025; 6, 0.81%) and no iPad, Mac or web app or cross-device sync (8, 1.08%; 'I'd even pay for separate versions as long as they synced'); a watch / iPad / Mac / web / sync union of 18 (2.42%, mean 4.67); one departure was to an app with iPad and Mac apps

- **Where:** §2.1 Not present — Apple Watch app; iPad, Mac or web app, and cross-device sync
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** Watch 6 (0.81%); iPad/Mac/web 8 (1.08%); union 18 (2.42%), mean 4.67
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `7044468569`, `13081471282`, `10581767784`, `11077980453`, `12188850466`, `12138400882`, `5975293048`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C141 Native iPad layout

### R34-056 — No iCloud / cloud sync: 6 requests (0.81%, mean 4.67), one after losing data on a factory reset; no sync caused a problem for 3

- **Where:** §2.1 Not present — iCloud / cloud sync
- **This app does:** absent (local only)
- **User reaction:** complaint
- **Magnitude:** 6 (0.81%); no-sync problem 3
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `6729639375`, `7344582690`, `10187448442`, `12427980996`
- **Canonical:** C030 Sync must work — and prove it; C153 Automatic cloud backup on by default — never manual opt-in

### R34-057 — No quantity / multiple-per-day / partial-completion habits: 11 requests (1.48%, mean 4.27) — push-ups, '5 bottles of water', 'twice a day', 'I Drank 80oz … I wanna be able to track that'

- **Where:** §2.1 Not present — quantities / partial completion (8 of 10 glasses)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 11 (1.48%), mean 4.27
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10088647035`, `13432208041`, `3233116539`, `12270557790`
- **Canonical:** C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N

### R34-058 — No notes on missed days, photos, or viewing a note from the calendar: 9 requests (1.21%, mean 4.44), e.g. a 'No Spend' habit

- **Where:** §2.1 Not present — notes on days a habit was not done
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 9 (1.21%), mean 4.44
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11400095925`, `13583853777`, `10965345926`, `9082639448`, `10569299689`
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R34-059 — No bad-habit / quit mode (6, 0.81%; 'I'd rather not see TO DO next to bad habits') and no skip / pause / 'incomplete' or sick day (5, 0.67%; 'i am sick and cannot swim … i dont want to loose my results')

- **Where:** §2.1 Not present — bad-habit / quit mode, skip or sick day
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** quit 6 (0.81%), mean 4.17; skip/pause 5 (0.67%), mean 4.40
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11475674157`, `11872013641`, `4122355171`, `13827396231`, `11811674754`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C019 Quit-habit / bad-habit mode

### R34-060 — No Apple Health integration: 2 requests (weak)

- **Where:** §2.1 Not present — Apple Health
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 2
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `6729639375`, `12150912789`
- **Canonical:** C021 Apple Health integration

### R34-061 — English-only UI for most reviewers ('Only english'): localisation requested in 19 (2.56%, mean 4.32)

- **Where:** §2.1 Not present — Localisation: English only for most reviewers
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 19 (2.56%)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11768720231`, `12121063578`, `13381269097`
- **Canonical:** C027 Localise early — it unlocks revenue

### R34-062 — Cannot complete a habit from the notification: 2 requests

- **Where:** §2.1 Not present — Complete a habit from the notification
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 2
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10052127570`, `10100128513`
- **Canonical:** C252 Complete a habit from the notification — an actionable reminder is part of the one-tap loop

### R34-089 — Streak / don't-break-the-chain praised 27 (3.63%, mean 4.93) — 'Don't Break The Chain only makes sense if you can actually see your chain!'

- **Where:** §3.1 theme table #22 Streak / don't-break-the-chain praised
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 27 (3.63%), mean 4.93; E3 0.0
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C012 Week / month / year grid views; C024 Streaks / gamification

### R34-094 — More statistics / overviews requested 14 (1.88%, mean 4.64): month %, all habits in one grid, counts ('percentage by month'); statistics praised 11 (1.48%, mean 4.55)

- **Where:** §3.1 theme table #33 Request: more statistics / overviews
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** request 14 (1.88%); praise 11 (1.48%)
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C011 Weekly / monthly / yearly reports

### R34-100 — Scheduling options requested 7 (0.94%, mean 4.43): every other day, monthly targets

- **Where:** §3.1 theme table #51 Request: scheduling options
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 7 (0.94%), mean 4.43; E1 5.7
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency

### R34-103 — Easier past-date editing and a day start after midnight 6 (0.81%, mean 4.50) — 'My day always ends after midnight' (Habitica's day-start setting cited); edit from the calendar view

- **Where:** §3.1 theme table #59 Request: easier past-date editing / day start after midnight
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 6 (0.81%), mean 4.50
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C010 Backfill missed days / edit start date; C170 Configurable day boundary and hemisphere seasons

### R34-105 — Badges, celebration, sounds requested 5 (0.67%, mean 4.80) — a 'celebration' when all habits are done

- **Where:** §3.1 theme table #68 Request: badges / celebration / sounds
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 5 (0.67%), mean 4.80
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C101 Milestones, achievements, celebration

### R34-117 — Low contrast in dark mode makes the app confusing for some (1 review, within confusing / hard to use at mean 1.67)

- **Where:** §3.2 Low contrast in dark mode
- **This app does:** dark mode contrast
- **User reaction:** complaint
- **Magnitude:** 1
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10630623535`
- **Canonical:** C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R34-218 — Interactive widgets (check off from the home screen)

- **Where:** Part 10 #13 (§10.4)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 7 requests, all after launch; widget demand union 37 (4.98%)
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11412519740`, `13731564617`
- **Canonical:** C023 Interactive widget check-off

### R34-219 — Quantity habits with partial completion (8 of 10 glasses counts as progress)

- **Where:** Part 10 #14 (§10.4)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 11 requests
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13432208041`, `10088647035`
- **Canonical:** C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N

### R34-220 — Notes on missed days, and open a day's note from the calendar

- **Where:** Part 10 #15 (§10.4)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 9 requests
- **Direction for us:** undecided · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13583853777`, `11400095925`, `10569299689`
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R34-221 — Optional iCloud sync, then iPad/Mac and Watch — iCloud keeps the no-server privacy stance

- **Where:** Part 10 #16 (§10.4)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** demand union 18; data loss 4; a named departure
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11077980453`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C141 Native iPad layout; C153 Automatic cloud backup on by default — never manual opt-in

### R34-222 — Edit days directly in the month calendar; configurable day start — one reviewer left the app over calendar editing

- **Where:** Part 10 #17 (§10.4)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 6 requests
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13559189439`, `9082639448`, `10732085902`
- **Canonical:** C010 Backfill missed days / edit start date; C170 Configurable day boundary and hemisphere seasons

### R34-223 — Statistics: month %, all habits in one grid, counts instead of streaks

- **Where:** Part 10 #18 (§10.4)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 14 requests
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `8746143988`, `12464367645`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R34-224 — Bad-habit mode and a skip / sick-day state

- **Where:** Part 10 #19 (§10.4)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 6 + 5 requests
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11475674157`, `11872013641`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C019 Quit-habit / bad-habit mode

### R34-225 — Localisation: Chinese, Russian, Spanish, French, Ukrainian — none hostile

- **Where:** Part 10 #20 (§10.4)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 19 requests
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10084467787`, `10750194157`
- **Canonical:** C027 Localise early — it unlocks revenue

### R34-234 — Experiment — widget in free tier vs paid-only

- **Where:** Part 10 #29 (§10.6)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** experiment
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free

## Monetization

### R34-012 — A 2-habit free tier is the main cause of low ratings: monetisation friction in 78 reviews (10.50%, high-priority, mean 2.68), present in 28 of the 37 1★ (75.7%) and 9 of the 11 2★; the habit cap alone 39 (5.25%, high-priority, mean 2.44, 15 of them 1★) — 'Only 2 habits for free'; 'Two is really stingy — with three I'd have kept it for decency; with five I'd have started using it, got hooked, and then bought'; 'Other apps usually have 5 free habits'

- **Where:** Executive summary #2 — the 2-habit free tier is the main cause of low ratings: monetisation friction 78 (10.50%, high-priority), mean 2.68; in 28 of 37 1★ (75.7%) and 9 of 11 2★
- **This app does:** 2 free habits 2018–2025
- **User reaction:** complaint
- **Magnitude:** friction 78 (10.50%) mean 2.68; 28/37 1★ (75.7%); 9/11 2★; cap 39 (5.25%) mean 2.44, 15 1★
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9839460397`, `9899413299`, `10904298957`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R34-014 — Gating small extras is rated worse than the habit cap: other gated features — widgets ('Cant use widgets without subscription'), notes, colours, backup — 11 reviews (1.48%) at mean 1.55, the worst-rated theme with n ≥ 5

- **Where:** Executive summary #2 — other gated features 11 (1.48%), mean 1.55, the worst-rated theme with n ≥ 5: widgets, notes, colours, backup
- **This app does:** widgets / notes / colours / backup paid
- **User reaction:** complaint
- **Magnitude:** 11 (1.48%), mean 1.55
- **Direction for us:** product-rule · **Report confidence:** meaningful; worst-rated n≥5 · **Generalisable:** yes
- **Review IDs:** `12760639157`, `13605658579`, `13629525960`, `12046497872`
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free; C133 Gate on capability, not on quantity

### R34-018 — No trial, or a 3-day trial, blocks conversion from people who want to evaluate: 7 reviews — 'I refuse to pay the min. $9 just to find out if I like it'; 'the free trial lasts only 3 days'

- **Where:** Executive summary #3 — no trial or too short (7): 'I refuse to pay the min. $9 just to find out if I like it'; 'the free trial lasts only 3 days'
- **This app does:** no trial (2022, 2024, 2026) vs 3-day trial (2025)
- **User reaction:** blocked-conversion
- **Magnitude:** 7 (0.94%)
- **Direction for us:** build-paid · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** trial existence contradicts across years/storefronts
- **Review IDs:** `11939700468`, `12738794859`
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

### R34-019 — Price level objection is mild: 25 reviews at mean 3.16 — '$40 … An indie game developed over years … will cost 5 to 25 dollars' (reviewers anchor the price to other software they buy)

- **Where:** Executive summary #3 — price level (25, mean 3.16): '$40 … An indie game developed over years … will cost 5 to 25 dollars'
- **This app does:** ~$40 lifetime, ~$20/yr, ~$9/mo
- **User reaction:** complaint
- **Magnitude:** 25 (3.36%), mean 3.16
- **Direction for us:** undecided · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11554013205`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R34-031 — A lifetime / one-time option is a stated reason to buy

- **Where:** Executive summary #7 — buy because a lifetime / one-time option exists
- **This app does:** ~$40 lifetime
- **User reaction:** purchase-driver
- **Magnitude:** qualitative (see §6.3)
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11286612018`, `11583264179`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R34-071 — The free gate: habit count 2 from 2018 to 2025 (dozens of reviews), reported as 4 in 2026 ('Up to 4 habits was free'; '4 habits in free account') — the cap may have been raised or tested; other Premium features — dark mode and app colour (2019), data import (2019), notes, custom colours, widgets (for some users) and backup

- **Where:** §2.3 The gate — habit count 2 from 2018 to 2025, reported as 4 in 2026; other Premium features: dark mode and app colour (2019), data import (2019), notes, custom colours, widgets (for some), backup
- **This app does:** 2 → 4 habits (2026?)
- **User reaction:** complaint
- **Magnitude:** dozens; 2026 two reviews report 4
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Conditions:** 2 vs 4 unresolved (storefront, version or A/B)
- **Review IDs:** `2953267303`, `5353795347`, `9839460397`, `12902043009`, `13597043858`, `14316571521`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R34-072 — Price ladder per reviewers: 2018 – mid-2019 one-time $5 → $9, 'no subscription'; Oct 2019 – 2020 £3.99/month, '$40 total', CA$7.99/mo, CA$19.99/yr, CA$55 once, 'buy outright option'; 2021–23 monthly and annual, $40 lifetime, €10/month; 2024 $40 lifetime, $20/year, €9.99/month, 'half a hundred dollars' CA$ lifetime; 2025 $9/month, $20/year, $40 lifetime, 3-day trial, 50% off £9.99/yr, one-time option 'gone'; 2026 €9.99–€20/year, 'only in Abo', 'you only pay once', lifetime 'won't be working'

- **Where:** §2.3 Price ladder (verbatim table)
- **This app does:** one-time → subscription + lifetime
- **User reaction:** mixed
- **Magnitude:** 2018 – mid-2019 | One-time: $5 → $9; "no subscription" | 2953267303, 3307938448, 4462219747, 4497735688 ; Oct 2019 – 2020 | £3.99/month; "$40 total"; CA$7.99/mo, CA$19.99/yr, CA$55 once; "buy outright option" | 4924456384, 5526275566, 6028222005, 6515336308 ; 2021 – 2023 | Monthly and annual; $40 lifetime; €10/month | 6831122754, 6884995801, 9342516160, 9459937898, 9607739351 ; 2024 | $40 lifetime, $20/year; €9.99/month; "half a hundred dollars" (CA$) lifetime | 10795711876, 10904298957, 11121787202, 11554013205, 11580982926 ; 2025 | $9/month, $20/year, $40 lifetime; 3-day trial; 50% off £9.99/yr; one-time option "gone" | 12738794859, 13560914935, 13392990758 ; 2026 | €9.99–€20/year; "only in Abo" (subscription); "you only pay once"; lifetime "won't be working" | 13597043858, 13600419608, 13740072982, 14284351778, 14138883204
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `2953267303`, `3307938448`, `4462219747`, `4497735688`, `4924456384`, `5526275566`, `6028222005`, `6515336308`, `6831122754`, `6884995801`, `9342516160`, `9459937898`, `9607739351`, `10795711876`, `10904298957`, `11121787202`, `11554013205`, `11580982926`, `12738794859`, `13560914935`, `13392990758`, `13597043858`, `13600419608`, `13740072982`, `14284351778`, `14138883204`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'

### R34-073 — Keep a lifetime option: the entry price moved from a $5–9 one-off (2018–19) to ~$20 a year or ~$40 once with a ~$9 monthly, and the lifetime option is valued — 15 reviews praise one-time / lifetime pricing (2.02%, mean 4.87; 7.5% of E1) — 'not a lot of apps offer this'; 'you only pay once which is refreshing in the current year'

- **Where:** §2.3 Interpretation — entry price moved from a $5–9 one-off to ~$20 a year or ~$40 once with a ~$9 monthly; the lifetime option is valued: 15 reviews (mean 4.87)
- **This app does:** lifetime ~$40 beside subscriptions
- **User reaction:** purchase-driver
- **Magnitude:** 15 (2.02%), mean 4.87
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12625098281`, `14284351778`, `11286612018`, `11583264179`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R34-085 — Positive monetisation 64 (8.61%, mean 4.91): 34 price fair, 15 lifetime praised, 17 free tier enough, 12 accept / defend the cap

- **Where:** §3.1 theme table #11 Monetisation positive (union)
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 64 (8.61%), mean 4.91; E1 13.2%
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors

### R34-088 — Price fair / worth it 34 (4.58%, mean 4.91), 9.4% of E1, US 6.8% vs 3.3%

- **Where:** §3.1 theme table #18 Price fair / worth it
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 34 (4.58%), mean 4.91
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R34-092 — Free tier sufficient / 'it's free' 17 (2.29%, mean 5.00) — some users only ever need two habits

- **Where:** §3.1 theme table #29 Free tier sufficient / 'it's free'
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 17 (2.29%), mean 5.00
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R34-097 — Conditional purchase intent 10 (1.35%, mean 4.40) — would buy if a named feature or price existed ('If I was paying, this app would be amazing')

- **Where:** §3.1 theme table #42 Conditional purchase intent
- **This app does:** see §3.1
- **User reaction:** blocked-conversion
- **Magnitude:** 10 (1.35%), mean 4.40
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C063 Free trial before purchase; C064 Price level — where 'fair' turns into 'too expensive'

### R34-106 — Objection to subscriptions as a model 4 (0.54%, mean 3.25) — 'leider nur im Abo'

- **Where:** §3.1 theme table #69 Objection to subscriptions as a model
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 (0.54%), mean 3.25
- **Direction for us:** build-paid · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R34-120 — A reviewer proposes the trial design directly: 'Give the user 21 days of all bells and whistles … Once you hook them on, charge them' (2018) — a habit-length full trial instead of a 2-habit wall

- **Where:** §3.3 'Give the user 21 days of all bells and whistles … Once you hook them on, charge them' (2018)
- **This app does:** no full trial
- **User reaction:** blocked-conversion
- **Magnitude:** n=1 quote
- **Direction for us:** build-paid · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `2953267303`
- **Canonical:** C063 Free trial before purchase

### R34-138 — Some reviewers ask for just one or two more free habits — 'Maybe you could change the maximal Habits to 3'; '3-4 habits' (5 reviews); by 2026 the free tier is reported as 4 habits yet one such reviewer still rated 1★ ('limited. :: 4 habits in free account')

- **Where:** §4.1 Some reviewers ask for just one more — 'Maybe you could change the maximal Habits to 3'; '3-4 habits'
- **This app does:** 2 → reportedly 4 in 2026
- **User reaction:** blocked-conversion
- **Magnitude:** 5 asks; 2026 4-habit reports 2 (one still 1★)
- **Direction for us:** product-rule · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `5964636301`, `10829968552`, `11114378387`, `11540693274`, `10668865820`, `13597043858`, `14316571521`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R34-139 — The wall now includes features, not only habits: 'Premium is the only usable form — widgets and more than 2 habits are essential' (3-day-trial reviewer); widgets and colours gated

- **Where:** §4.1 The wall now includes features, not only habits — 'Premium is the only usable form — widgets and more than 2 habits are essential'
- **This app does:** widgets / colours gated
- **User reaction:** complaint
- **Magnitude:** 3 reviews
- **Direction for us:** product-rule · **Report confidence:** E5-heavy · **Generalisable:** yes
- **Review IDs:** `12760639157`, `12738794859`, `13629525960`
- **Canonical:** C001 Never move a free feature behind the paywall; C133 Gate on capability, not on quantity

### R34-162 — A cheap one-off unlock makes buying easy: E1, when Premium was a $5–9 one-time purchase, had the highest payer share of any era (18.9% of reviews vs 3.9–8.4% under subscription + lifetime)

- **Where:** §6.2 E1 had the highest payer share (18.9%): a $5–9 one-off made 'I bought it' easy
- **This app does:** $5–9 one-off (2018–19)
- **User reaction:** purchase-driver
- **Magnitude:** E1 18.9% vs E2 6.4, E3 3.9, E4 4.5, E5 8.4
- **Direction for us:** build-paid · **Report confidence:** segment (self-selected) · **Generalisable:** yes
- **Conditions:** self-reported payers, not conversion; E1 n=53
- **Review IDs:** `3307938448`, `4462219747`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors

### R34-165 — The top purchase trigger is the free tier proving the method: 'Having started with the two free grids I have today purchased the reasonably priced annual subscription'; 'I'm so happy with it I went ahead and bought the full version'; 'After playing with the Free version (2 habits only) I knew … Bought the Lifetime and I was only 12 hrs into this'

- **Where:** §6.3 The two free habits proved the method; they needed more — 'Having started with the two free grids I have today purchased the reasonably priced annual subscription'; 'After playing with the Free version (2 habits only) I knew … Bought the Lifetime and I was only 12 hrs into this'
- **This app does:** 2 free habits → upgrade
- **User reaction:** purchase-driver
- **Magnitude:** 5 evidence reviews (most common trigger)
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `9655320510`, `13242549122`, `13044612377`, `13597043858`, `10791117607`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R34-166 — People who hate subscriptions buy lifetime: 'I was able to go pro by paying once instead of a subscription'; 'it's lifetime access, instead of a subscription which was what I was looking for'; 'odio las suscripciones así que pagué la versión lifetime … a modo de inversión'

- **Where:** §6.3 A one-time / lifetime option instead of rent — 'I was able to go pro by paying once instead of a subscription'; 'it's lifetime access, instead of a subscription which was what I was looking for'; 'I hate subscriptions so I paid for lifetime … as an investment'
- **This app does:** lifetime option
- **User reaction:** purchase-driver
- **Magnitude:** 4 evidence reviews; payer one-time praise 7
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `5293501237`, `11286612018`, `11583264179`, `3503457494`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R34-168 — Cosmetic extras and aesthetics are what payers name as the paid value: dark mode, colours ('the visually appealing extras, such as customizable colors'), notes and import; 'a estética … fez total diferença para que eu estivesse disposta a pagar'

- **Where:** §6.3 Extras: dark mode, colours, notes, import; design and aesthetics — 'aesthetics … made all the difference in my being willing to pay'
- **This app does:** extras paid
- **User reaction:** purchase-driver
- **Magnitude:** 6 evidence reviews
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `4462219747`, `4497735688`, `8181313423`, `13919822858`, `13093527963`, `3503457494`
- **Canonical:** C080 Colour themes / dark mode; C167 Cosmetic and colour variety as the paid layer

### R34-174 — Non-payers name what would convert them: no trial / too short 7 (0.94%, mean 3.00; 'I'm surprised there's no trial before making a commitment'); conditional intent 10 (1.35%, mean 4.40) — a lower price, more free habits first, iPad / Mac / iCloud ('I'd even pay for separate versions'; 'A lifetime or yearly purchase with the app across the ecosystem and i'll be right back'), budget later, and a month's trial on the monthly plan

- **Where:** §6.6 Trial and upgrade barriers among non-payers — no trial / too short 7 (3.00); conditional intent 10 (4.40): lower price, more free habits first, iPad / Mac / iCloud, budget later, a month's trial on the monthly plan
- **This app does:** no/short trial; 2-habit cap
- **User reaction:** blocked-conversion
- **Magnitude:** no trial 7 (3.00); conditional 10 (4.40)
- **Direction for us:** research · **Report confidence:** emerging / meaningful · **Generalisable:** yes
- **Review IDs:** `11939700468`, `13827396231`, `12738794859`, `4924456384`, `11097867630`, `9899413299`, `10581767784`, `11077980453`, `6836775244`, `11704110690`, `9996142813`
- **Canonical:** C044 Mac / desktop / web app; C063 Free trial before purchase; C064 Price level — where 'fair' turns into 'too expensive'

### R34-213 — Test the free tier: 2 habits (control) vs 3–4 habits vs 2 habits with a 14–21-day full trial; measure conversion and 1★ rate; the 2026 '4 habits' reports suggest this may already be under way

- **Where:** Part 10 #8 (§10.3)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** evaluation argument is the plurality of 78 friction reviews
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `2953267303`, `9899413299`, `10904298957`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C063 Free trial before purchase

### R34-215 — Offer a real trial (7–14 days) with a reminder before the charge; a 3-day trial is called too short

- **Where:** Part 10 #10 (§10.3)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 7 trial complaints
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12738794859`, `11939700468`
- **Canonical:** C109 A free trial must be a real trial; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R34-216 — Test a student or regional price and seasonal sales — affordability complaints; a 50% offer converted; New-Year months are the busiest

- **Where:** Part 10 #11 (§10.3)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** cannot afford 4; 50% offer 1; Jan peaks 34
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10795711876`, `11097867630`, `12221998930`, `13560914935`
- **Canonical:** C025 Scholarship / hardship / discount program; C092 Regional pricing

### R34-217 — Keep a lifetime option visible — a named purchase trigger and a US differentiator (one-time praise 3.02% US vs 1.46% non-US)

- **Where:** Part 10 #12 (§10.3)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 3.02% vs 1.46%
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11286612018`, `11583264179`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R34-232 — Experiment — free-tier design: cap 2 vs 3 vs 4; trial vs none — measuring conversion, D30 retention and 1★ rate

- **Where:** Part 10 #27 (§10.6)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** experiment
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C063 Free trial before purchase

## Tactics the app used

### R34-005 — Outcome of a limited-time free-lifetime giveaway (≈29 Jun 2023): it bought a burst of 27 short, mostly 5★ reviews in three days (21 on 29 Jun alone, all 5★, from br 5, us 4, vn 2, in 2, cn 2, co 2 …), shifted the corpus mean by only ~0.01 (4.571 → 4.580), lifted the short-review share of 2023 to 27.1% and of E3 to 24.8%, attracted Chinese / Russian / Ukrainian users who then asked for localisation (Jun 2023 – Jan 2024 wave), and left some who expected it again ('When will there be another limited-time free offer?') and one calling it a 'Scam of free life time subscription'

- **Where:** Seven warnings #3; §2.2 28–30 Jun 2023; §1.6 busiest day 2023-06-29
- **This app does:** free-lifetime promotion
- **User reaction:** 5★-burst
- **Magnitude:** 27 reviews / 3 days; 21 on 2023-06-29 all 5★; 2023 short 27.1%; E3 short 24.8%
- **Direction for us:** research · **Report confidence:** interpretation (probable) · **Generalisable:** yes
- **Side effects:** brought in non-English users who then asked for localisation; set an expectation of future free offers
- **Conditions:** promotion inferred from review text and timing, not confirmed
- **Review IDs:** `10083799946`, `10085535827`, `10087293260`, `12597410321`, `10084467787`, `10750194157`, `10336343530`
- **Canonical:** C027 Localise early — it unlocks revenue; C054 Never run incentivised / review-for-premium campaigns; C089 Promos, giveaways and gift codes must work exactly as advertised; C225 A one-off free promotion (App of the Week, partner promo) acquires durable users

### R34-054 — An in-app 'in progress' roadmap list tells users what is coming and wins goodwill: 'I saw developer already listed it as incoming, this informing and communicative attitude was a huge plus for me'

- **Where:** §2.1 In-app 'in progress' roadmap list — free
- **This app does:** in-app roadmap
- **User reaction:** praise
- **Magnitude:** 2 reviews
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13247369835`, `13882752696`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R34-064 — Launching through Reddit and word of mouth found the early users: the app was found via Reddit at launch (Jul 2018), and 6 reviews (0.81%, mean 5.00, 3.8% of E1) say they found it via Reddit, social media or reviews

- **Where:** §2.2 Jul 2018 launch found via Reddit; found via Reddit / social / reviews 6 (0.81%, mean 5.00)
- **This app does:** Reddit launch
- **User reaction:** praise
- **Magnitude:** 6 (0.81%), mean 5.00; E1 3.8%
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `2949637870`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R34-076 — A 50% discount offer (£9.99/year, Dec 2025) appears around New Year; a discount is mentioned in 1 review — no outcome measurable

- **Where:** §2.3 Dec 2025 50% offer £9.99/year
- **This app does:** seasonal discount
- **User reaction:** mixed
- **Magnitude:** 1 (weak)
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13560914935`
- **Canonical:** C025 Scholarship / hardship / discount program

### R34-077 — Outcome of replying to reviews and building requested features: visible developer replies changed ratings ('Updated to 4 stars - thank you devs for the response!'; 'I appreciate the thorough response'), features were built on request (weekly habits; a German reviewer's suggestion; 'He promised to integrate this feature and let me know as soon as it's released'), and 31 reviews name the developer 'Kevin' (4.17%, mean 4.77)

- **Where:** §2.4 Responsive and personal — 52 praise the developer; 31 name 'Kevin'; features built on request; visible replies that changed ratings
- **This app does:** named solo developer replies and ships requests
- **User reaction:** praise
- **Magnitude:** developer praise 52 (7.00%), mean 4.96; 'Kevin' 31 (4.17%), mean 4.77
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10732085902`, `11077980453`, `3954949955`, `8400091910`, `6393157189`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R34-167 — Being visibly a solo indie developer converts: 'helps support an independent developer'; 'I paid the app to support solo developer' (5 evidence reviews; developer praise 13 of 51 payers, 25.5%)

- **Where:** §6.3 Supporting a solo developer — 'helps support an independent developer'; 'I paid the app to support solo developer'
- **This app does:** solo indie identity
- **User reaction:** purchase-driver
- **Magnitude:** 5 reviews; 13/51 payers praise developer
- **Direction for us:** do · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `4462219747`, `4497735688`, `11737212105`, `13919822858`, `10854224657`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R34-169 — A 50% discount offer converted at least one user: 'I took advantage of a 50% reduction offer, so I paid £9.99 for a whole year - bargain!' (Dec 2025)

- **Where:** §6.3 A discount — 'I took advantage of a 50% reduction offer, so I paid £9.99 for a whole year - bargain!'
- **This app does:** 50% annual offer
- **User reaction:** purchase-driver
- **Magnitude:** n=1
- **Direction for us:** research · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `13560914935`
- **Canonical:** C025 Scholarship / hardship / discount program

## Insights (the why)

### R34-009 — The product wins on one idea — see a whole year of a habit at a glance with almost no effort: core praise in 507 reviews (68.24%, high-priority, mean 4.87) — simplicity 275 (37.01%; 273 rated 4–5★; zero 1★), design 166 (22.34%), 'best / the only one that stuck' 107 (14.40%, no 1★), year grid / month calendar / GitHub-like heatmap 105 (14.13%, no 1★)

- **Where:** Executive summary #1 — core praise 507 (68.24%, high-priority), mean 4.87
- **This app does:** simple one-tap tracker with year heatmap
- **User reaction:** praise
- **Magnitude:** 507 (68.24%), mean 4.87; simplicity 275 (37.01%); design 166 (22.34%); best 107 (14.40%); year grid 105 (14.13%)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10791779600`, `9730846797`, `9667437355`, `14284351778`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C012 Week / month / year grid views

### R34-013 — A reviewer spells out the conversion curve of the free cap: 'Two is really stingy — with three I'd have kept it for decency; with five I'd have started using it, got hooked, and then bought' (Russian, translated) — a larger free tier is the route to purchase, not a lost sale; 'Other apps usually have 5 free habits' sets the reference point

- **Where:** Executive summary #2 — 'with three I'd have kept it for decency; with five I'd have started using it, got hooked, and then bought'
- **This app does:** 2 free habits
- **User reaction:** blocked-conversion
- **Magnitude:** n=1 quote + n=1 benchmark
- **Direction for us:** product-rule · **Report confidence:** anecdotal quote within high-priority theme · **Generalisable:** yes
- **Review IDs:** `9899413299`, `10904298957`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R34-016 — The paywall objection is mostly about evaluation and disclosure, not only price: reviewers want to judge the app before paying — not told about the limit before downloading (3), no trial or too short (7), price level (25, mean 3.16)

- **Where:** Executive summary #3 — the objection is mostly about evaluation and disclosure, not only the price level
- **This app does:** 2-habit cap, trial inconsistent
- **User reaction:** complaint
- **Magnitude:** undisclosed 3; no/short trial 7; price 25 (mean 3.16)
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11348148556`, `12233797625`, `11939700468`, `12738794859`, `11554013205`
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R34-029 — Paying users are satisfied: 51 explicit payers (6.86%), mean 4.63, 42 of them 5★, only 3 at 1–2★; what goes wrong after paying is functional (reminders, a widget, the lifetime entitlement), not price

- **Where:** Executive summary #7 — paying users are satisfied: 51 explicit payers (6.86%), mean 4.63, 42 5★, 3 at 1–2★
- **This app does:** subscription + lifetime
- **User reaction:** praise
- **Magnitude:** 51 (6.86%), mean 4.63; 42 5★; 3 1–2★
- **Direction for us:** none · **Report confidence:** meaningful (self-selected) · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R34-030 — People buy after the free habits prove the method works for them: 'purely because it has been so effective in reinforcing the two habits … and I needed to add more' — the cap converts when the tracked habits succeed

- **Where:** Executive summary #7 — buy after the 2 free habits prove the method
- **This app does:** 2 free habits
- **User reaction:** purchase-driver
- **Magnitude:** qualitative
- **Direction for us:** none · **Report confidence:** meaningful (payer segment) · **Generalisable:** yes
- **Review IDs:** `13242549122`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R34-032 — Supporting a solo developer is a stated purchase motive

- **Where:** Executive summary #7 — buy to support a solo developer
- **This app does:** solo dev 'Kevin'
- **User reaction:** purchase-driver
- **Magnitude:** qualitative (see §6.3)
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `4497735688`, `11737212105`, `13919822858`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R34-040 — January is the habit-app season: the busiest months are 2024-01 (34, mean 4.65) and 2025-01 (34, mean 4.53), with 2019-12 (24, mean 4.92), matching New-Year resolution use ('I get to keep up with all of my goals for the new year'); 2023-06 (33, mean 4.82) is the promotion burst; scripts — Latin 716 (96.4%), Cyrillic 14, Chinese 12, Korean 1

- **Where:** §1.6 Languages; Volume — busiest months 2024-01 (34), 2025-01 (34), 2023-06 (33, burst), 2019-12 (24, 4.92); January peaks match New-Year resolution use; busiest day 2023-06-29 21 reviews all 5★
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2024-01 34 (4.65); 2025-01 34 (4.53); 2023-06 33 (4.82); 2019-12 24 (4.92); 2023-06-29 21 all 5★
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `3602342510`, `5353512893`, `13560914935`
- **Canonical:** C032 New Year peak-season robustness — year-end report and January onboarding

### R34-082 — Requesters are mostly happy: unmet needs (all requests) 113 (15.21%, high-priority), mean 4.48; 54.5% of all 4★ carry a request — requests are what separate 4★ from 5★

- **Where:** §3.1 theme table #4 Unmet needs — all requests (union)
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 113 (15.21%), mean 4.48; 64 5★; E1 26.4%
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R34-083 — 'Helps build / track habits' 95 (12.79%, mean 4.98), falling from 24.5% of E1 to 6.0% of E4 as praise shifted to 'beautiful and best'

- **Where:** §3.1 theme table #8 Helps build / track habits
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 95 (12.79%), mean 4.98; E1 24.5 → E4 6.0 → E5 9.1
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-086 — Motivating / accountability praised 46 (6.19%, mean 4.96)

- **Where:** §3.1 theme table #14 Motivating / accountability
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 46 (6.19%), mean 4.96
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C024 Streaks / gamification

### R34-087 — Concrete life outcomes 35 (4.71%, mean 4.94): diabetic weight loss 'finally got under 200 pounds', '26 days off sugar', 'helped me quit smoking', 25-day water streak, songwriting 5-week streak, London lockdowns

- **Where:** §3.1 theme table #17 Concrete life outcome
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 35 (4.71%), mean 4.94; US 7.2 vs non-US 3.3
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-090 — Reliability problems are rare and forgiven: reliability union 24 (3.23%, mean 3.75, 3 1★), 7.5% of E1, 6.7% of E4 (the Apr 2024 spike), 2.6% of E5 — bugs are reported politely, often at 4–5★

- **Where:** §3.1 theme table #25 Reliability (union)
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 24 (3.23%), mean 3.75; E1 7.5 E4 6.7 E5 2.6
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R34-091 — Long-term users (≥ 1 year stated) 17 (2.29%) all rate 5.00

- **Where:** §3.1 theme table #28 Long-term user (≥ 1 year stated)
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 17 (2.29%), mean 5.00
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-093 — Explicit churn / intent to leave 14 (1.88%, mean 2.21, 5 1★), 3.9% of E5, US 3.4% vs 1.0% — the review is the exit interview

- **Where:** §3.1 theme table #32 Explicit churn / intent to leave
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 14 (1.88%), mean 2.21; E5 3.9; US 3.4 vs 1.0
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-095 — Free cap accepted / defended 12 (1.62%, mean 4.92) — 'The 2 habit cap is actually well thought out. It stops me from overdoing the habits'; 'I understand why more than two habits is premium, as app developers need money, too'

- **Where:** §3.1 theme table #35 Free cap accepted / defended
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 12 (1.62%), mean 4.92
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R34-096 — 'An update improved it' 10 (1.35%, all 5★)

- **Where:** §3.1 theme table #41 An update improved it
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 10 (1.35%), mean 5.00
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-116 — 'Too basic' is a price objection from a paywalled user: 3 reviews, mean 1.67, 66.7% 1★ — 'such a basic system that i can so easily replicate on my agenda'

- **Where:** §3.2 Too basic 3 (1.67, 66.7% 1★) — 'such a basic system that i can so easily replicate on my agenda'
- **This app does:** simple app with paywall
- **User reaction:** complaint
- **Magnitude:** 3, mean 1.67
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `6028222005`
- **Canonical:** C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R34-118 — The low end of the distribution is almost entirely about access — blocked by the paywall, not told about it, unable to try, unable to take data out; reliability problems are rare (3.23%) and forgiven (mean 3.75, the mildest negative, bugs reported politely often at 4–5★) — the product rarely breaks, the business model is what users push back on

- **Where:** §3.2 Interpretation — the low end is almost entirely about access; reliability rare (3.23%) and forgiven (3.75): 'the product rarely breaks; the business model is what users push back on'
- **This app does:** reliable app, strict paywall
- **User reaction:** complaint
- **Magnitude:** access themes 1.00–3.16 vs reliability 3.75
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R34-119 — The 78 friction reviews make seven different arguments (manual, overlapping split): 'two habits is too few to judge the app' (evaluation) is the plurality ('Give the user 21 days of all bells and whistles … Once you hook them on, charge them'; 'at least five'); 'you didn't tell me' (disclosure) small and sharp ('I searched for free apps and this one came up'; 'I just wish it was said earlier (for example, here)'); 'let me try it first' (trial) E5-heavy ('a pity you can't preview … before buying'; '40$ … seriously without trying the app'); 'too expensive for what it is' steady ($40 vs an indie game; £3.99/month vs Netflix £7.99; €9.99/month 'completely of the charts'); 'I can't afford it' small; 'don't gate the basics' E5-heavy (widgets, notes, colours, backup); 'not another subscription' small

- **Where:** §3.3 Reading the monetisation objection correctly (verbatim table) — evaluation plurality; disclosure small, sharp; trial E5-heavy; value steady; affordability small; feature gates E5-heavy; model small
- **This app does:** 2-habit cap
- **User reaction:** complaint
- **Magnitude:** Argument | Rough share | Example IDs ; "Two habits is too few to *judge* the app" (evaluation) | the plurality | 2953267303 ("Give the user 21 days of all bells and whistles … Once you hook them on, charge them"), 9899413299 (with 5, "I'd have started using it … then I'd have bought"), 10904298957, 12154681308 ("at least five"), 13036244176 ("If I was paying, this app would be amazing") ; "You didn't tell me" (disclosure) | small, sharp | 11348148556, 12233797625 ("I searched for free apps and this one came up"), 10455939599 ("I just wish it was said earlier (for example, here)"), 3850157156 ("I got this because it was free") ; "Let me try it first" (trial) | E5-heavy | 11939700468, 13702002766 ("dommage qu'on ne puisse pas avoir un aperçu … avant d'acheter" *"a pity you can't preview … before buying"*), 13827396231, 12738794859 (3-day trial), 9342516160 ("40$ … seriously without trying the app") ; "Too expensive for what it is" (value) | steady | 11554013205 ($40 vs an indie game), 4924456384 (£3.99/month vs Netflix £7.99), 6028222005, 11121787202 (€9.99/month "completely of the charts"), 9607739351 ; "I can't afford it" (affordability) | small | 10795711876 ("broke college student"), 11097867630 (Vietnam), 12221998930 (ADHD, "I don't have the money"), 6836775244 ("can't wait til I can budget enough") ; "Don't gate the basics" (feature gates) | E5-heavy | 12760639157 (widgets), 13605658579 (notes, Russian), 13629525960 (colours), 12046497872 (backup) ; "Not another subscription" (model) | small | 13740072982 ("leider nur im Abo" *"unfortunately only as a subscription"*), 6028222005, 10854224657 (mild, still subscribed)
- **Direction for us:** product-rule · **Report confidence:** qualitative split · **Generalisable:** yes
- **Review IDs:** `2953267303`, `9899413299`, `10904298957`, `12154681308`, `13036244176`, `11348148556`, `12233797625`, `10455939599`, `3850157156`, `11939700468`, `13702002766`, `13827396231`, `12738794859`, `9342516160`, `11554013205`, `4924456384`, `6028222005`, `11121787202`, `9607739351`, `10795711876`, `11097867630`, `12221998930`, `6836775244`, `12760639157`, `13605658579`, `13629525960`, `12046497872`, `13740072982`, `10854224657`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase; C063 Free trial before purchase; C064 Price level — where 'fair' turns into 'too expensive'; C147 Let people use the product before they pay; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R34-126 — A calm, native-feeling iOS design is praised by 156 at 4–5★ — 'Feels like it was made by Apple'; 'Native iOS gem'; 'The whole app just feels calm and clear'

- **Where:** §3.4 Calm, native-feeling design 156 — 'Feels like it was made by Apple'; 'Native iOS gem'; 'The whole app just feels calm and clear'
- **This app does:** native iOS look
- **User reaction:** praise
- **Magnitude:** 156 (4–5★); design 166 (22.34%), mean 4.77
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9459813565`, `11298677390`, `10327221465`
- **Canonical:** C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R34-127 — Why the year grid works: seeing the whole chain beats a streak number — 'Don't Break The Chain only makes sense if you can actually see your chain!'; 'Much more useful than only knowing your longest streak'; 'see my daily efforts as a part of the big picture of my life'; 'You can spot patterns you didn't realize existed' (104 at 4–5★)

- **Where:** §3.4 The year grid / calendar — the differentiator: 'Don't Break The Chain only makes sense if you can actually see your chain!'; 'Much more useful than only knowing your longest streak'; 'You can spot patterns you didn't realize existed'
- **This app does:** year heatmap free
- **User reaction:** praise
- **Magnitude:** 104 (4–5★)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `6886056651`, `9580051830`, `11682869403`, `14284351778`
- **Canonical:** C012 Week / month / year grid views

### R34-131 — Hidden gestures and paywalled surfaces look like missing features: a reviewer asked for an easier way to mark yesterday and the developer pointed to the existing long-press ('That solves 90% of the struggle'); 'No widgets!!' (May 2024) two months after widgets shipped — either the paywall or discoverability; 'not clear how to mark first day'

- **Where:** §3.5 Misunderstandings — long-press to mark yesterday ('That solves 90% of the struggle'); 'No widgets!!' two months after widgets shipped; 'not clear how to mark first day'
- **This app does:** undiscoverable gestures
- **User reaction:** complaint
- **Magnitude:** 4 reviews
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `10732085902`, `11266485331`, `9918184824`, `13288687749`
- **Canonical:** C142 Surface existing features where users look; C223 Undo / un-complete is a visible button — never a gesture-only path

### R34-140 — The cap produces the largest single share of 1★ yet is spread across stars: 15 of 37 1★ (40.5%) are the cap (28 of 37, 75.7%, some friction); cap reviews split 3 at 5★, 7 at 4★, 9 at 3★, 5 at 2★, 15 at 1★ — many 4★ reviewers like the app and still resent the cap

- **Where:** §4.1 Impact — 15 of 37 1★ (40.5%) are the cap; cap reviews spread 3 at 5★, 7 at 4★, 9 at 3★, 5 at 2★, 15 at 1★; many 4★ reviewers like the app and still resent the cap
- **This app does:** 2-habit cap
- **User reaction:** complaint
- **Magnitude:** 15/37 1★ (40.5%); 3/7/9/5/15 by star
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R34-145 — No account and on-device data is praised as privacy: 7 reviews (0.94%, mean 4.29) — 'my data isn't stored on a server!'; 'Privacy focused too, so no servers with your data on'; 'hasn't been larded with privacy-invading trackers'

- **Where:** §4.3 Cluster 3 — Local-first data: privacy praised (7): 'my data isn't stored on a server!'; 'Privacy focused too, so no servers with your data on'; 'hasn't been larded with privacy-invading trackers'
- **This app does:** local-first, no account
- **User reaction:** praise
- **Magnitude:** 7 (0.94%), mean 4.29
- **Direction for us:** build-free · **Report confidence:** meaningful (cluster) · **Generalisable:** yes
- **Review IDs:** `4497735688`, `6791860731`, `5753516491`
- **Canonical:** C085 Address tracking / privacy visibly

### R34-150 — A lifetime purchase and a local-first data model are both promises of continuity, and the 2025–26 trust events (lifetime removed or unhonoured, export disabled, paid backup to delete) break exactly those promises — not a trend by count, but the cheapest set of problems to fix

- **Where:** §4.4 Interpretation — a lifetime purchase and a local-first data model are both promises of continuity; the 2025–26 events touch exactly those promises; not yet a trend by count, but the cheapest set of problems to fix
- **This app does:** continuity promises broken
- **User reaction:** churn
- **Magnitude:** 8 events, 1–2 reviews each
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C176 Never let fear of losing history be the reason people pay; C186 Never revoke what earlier buyers paid for when the model changes

### R34-154 — 4★ is the feature-request band — reviewers name the missing piece between 4 and 5: any request 42 of 77 (54.5%), widget demand 11 (14.3%), localisation 8 (10.4%), friction 14 (18.2%), cap 7, quantities 6, price 6 — 'Once widgets launch this will be easily a 5-star application'; 'If that feature is added, this app would be a perfect 5 stars!'; 'the only reason I haven't given it five stars is because I really want a macOS app or web version' (a payer)

- **Where:** §5.2 4★ table (verbatim) — 4★ is the feature-request band: any request 42 (54.5%), widget demand 11 (14.3%), localisation 8 (10.4%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 4★ ; Any request (unmet) | 42 | 54.5% ; Core praise | 35 | 45.5% ; Simplicity | 15 | 19.5% ; Design | 14 | 18.2% ; Monetisation friction | 14 | 18.2% ; Widget demand | 11 | 14.3% ; Localisation | 8 | 10.4% ; Cap | 7 | 9.1% ; Quantities | 6 | 7.8% ; Price objection | 6 | 7.8%
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `10811806786`, `10569299689`, `12188850466`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R34-155 — 3★ is the 'nice app, but the wall' band: monetisation friction 14 of 27 (51.9%), cap 9 (33.3%), design praised 7 (25.9%), reliability 5, requests 5, price / widget / data trust 3 each

- **Where:** §5.3 3★ table (verbatim) — 3★ is the 'nice app, but the wall' band: monetisation friction 14 (51.9%), cap 9 (33.3%)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 3★ ; Monetisation friction | 14 | 51.9% ; Cap | 9 | 33.3% ; Design (praised) | 7 | 25.9% ; Reliability | 5 | 18.5% ; Requests | 5 | 18.5% ; Price objection / widget request / data trust | 3 each | 11.1%
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `5526275566`, `10455939599`, `11852510890`, `12532587110`, `13392990758`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R34-156 — 2★ is the 'I'm leaving' band: friction 9 of 11 (81.8%), cap 5 (45.5%), explicit churn 4 (36.4%); also a Shortcuts bug, nagging, the lifetime complaint and an unclear onboarding

- **Where:** §5.4 2★ table (verbatim) — 2★ is the 'I'm leaving' band: friction 9 (81.8%), cap 5 (45.5%), explicit churn 4 (36.4%)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Theme | n | % of 2★ ; Monetisation friction | 9 | 81.8% ; Cap | 5 | 45.5% ; Explicit churn | 4 | 36.4% ; Upsell / price objection / design praised | 2 each | 18.2%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `12108620259`, `12221998930`, `12738794859`, `13740072982`, `11817893086`, `7879946381`, `14138883204`, `13288687749`
- **Canonical:** — (nuance register)

### R34-157 — 1★ is driven by the paywall almost alone: friction 28 of 37 (75.7%), cap 15 (40.5%), other gated feature 8 (21.6%), price 7 (18.9%), churn 5, confusing 4, data trust 3, reliability 3 — only 3 of 37 are reliability (data loss, reminders, widget), two more are data lock-in, only 2 of 37 are payers; the register is blunt — 'Greedy', 'SCAMMT MONEY GRAB AGAIN', 'Another app that makes you pay to use it', 'Mercenário', 'Horrível tem que pagar'

- **Where:** §5.5 1★ table (verbatim) — the paywall almost alone: friction 28 (75.7%), cap 15 (40.5%), other gated 8 (21.6%), price 7; only 3 reliability; only 2 of 37 payers; register 'Greedy', 'SCAMMT MONEY GRAB AGAIN', 'Another app that makes you pay to use it', 'Mercenário', 'Horrível tem que pagar'
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of 1★ ; Monetisation friction | 28 | 75.7% ; Cap | 15 | 40.5% ; Other gated feature | 8 | 21.6% ; Price objection | 7 | 18.9% ; Explicit churn | 5 | 13.5% ; Confusing / hard to use | 4 | 10.8% ; Data trust | 3 | 8.1% ; Reliability | 3 | 8.1%
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `4968235247`, `5535050975`, `12326097524`, `12046497872`, `13731751322`, `11326591912`, `12902043009`, `12172972006`, `5074213287`, `10828741313`
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set

### R34-159 — Reviewers love what the app is and push back on what it withholds — the product is not failing, access to it is

- **Where:** §5.6 The single most important cross-cutting fact: reviewers love what the app is and push back on what it withholds; the product is not failing, access to it is
- **This app does:** strict free tier on a loved product
- **User reaction:** mixed
- **Magnitude:** report gives none beyond §5.6 table
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R34-163 — Payers turn negative when what they bought stops working, not because of price: E5 has the lowest payer mean (4.23), and every E5 payer rating low reports a broken thing they paid for — a widget, reminders (3★), the lifetime entitlement

- **Where:** §6.2 E5 has the lowest payer mean (4.23): all three payers rating 1–2★ in E5 report a broken thing they paid for (widget, reminders, lifetime); payers turn negative when what they bought stops working, not because of price
- **This app does:** paid features broke
- **User reaction:** churn
- **Magnitude:** E5 payer mean 4.23
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `12326097524`, `13505537432`, `14138883204`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R34-170 — Long-term users renew or upgrade to lifetime: 'my one year anniversary of purchasing this app and I purchased another year again without hesitation'; a year of use then lifetime

- **Where:** §6.3 Long-term use, then renewal — 'my one year anniversary of purchasing this app and I purchased another year again without hesitation'; a year of use, then lifetime
- **This app does:** annual → renewal / lifetime
- **User reaction:** purchase-driver
- **Magnitude:** 2 reviews
- **Direction for us:** none · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `6884995801`, `8181313423`
- **Canonical:** — (nuance register)

### R34-171 — Buyers value simplicity and speak in value terms: among 51 payers simplicity 24 (47.1%), competitor comparison 16 (31.4%), price fair 14 (27.5%), design 14 (27.5%), developer 13 (25.5%), 'best' 12 (23.5%), life outcome 8, year grid 8, customisation 8, one-time pricing 7 — 'I never buy apps. This is worth it … Take it from a penny pincher'; 'it's a very small price for what you get'; 'well worth the $20. It's changing my life'

- **Where:** §6.4 What buyers value once they have paid — simplicity 24 (47.1%), competitor comparison 16 (31.4%), price fair 14 (27.5%), design 14 (27.5%), developer 13 (25.5%), 'best' 12 (23.5%), life outcome 8, year grid 8, customisation 8, one-time pricing 7; 'I never buy apps. This is worth it … Take it from a penny pincher'
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** segment rates on 51
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `5005862431`, `13881561697`, `10965345926`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

### R34-198 — Users of a simple habit tracker do not ask for AI: across 743 reviews over eight years (2018–2026) no review mentions AI, ChatGPT or an AI feature

- **Where:** §8.9 No AI trend — no review mentions AI, ChatGPT or an AI feature
- **This app does:** no AI
- **User reaction:** none
- **Magnitude:** 0 of 743
- **Direction for us:** research · **Report confidence:** explicit non-claim · **Generalisable:** yes
- **Canonical:** C056 Don't build AI features on demand grounds

### R34-201 — A 2-habit free tier converts believers and repels evaluators: it is both the top purchase trigger and 40.5% of 1★ reviews

- **Where:** Part 9 #3 — a 2-habit free tier converts believers and repels evaluators: both the top purchase trigger and 40.5% of 1★
- **This app does:** 2-habit cap
- **User reaction:** mixed
- **Magnitude:** 40.5% of 1★; top trigger
- **Direction for us:** undecided · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

## Audiences

### R34-107 — Cannot afford 4 (0.54%, mean 4.00): 'broke college student', Vietnam, ADHD 'I don't have the money', 'can't wait til I can budget enough'

- **Where:** §3.1 theme table #71 Cannot afford
- **This app does:** see §3.1
- **User reaction:** blocked-conversion
- **Magnitude:** 4 (0.54%), mean 4.00
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C025 Scholarship / hardship / discount program; C092 Regional pricing

### R34-128 — ADHD users prefer a simple general tracker over ADHD-specific apps: 5 self-identified (0.67%, mean 4.40) — 'apps designed specifically for ADHD … too detailed … This app is simple with just the right amount of detail'; 'MUST. FILL. BOXES.' — while one ADHD user cannot afford Premium

- **Where:** §3.4 Neurodivergent users 5 — 'apps designed specifically for ADHD … too detailed … This app is simple with just the right amount of detail'; 'MUST. FILL. BOXES.'
- **This app does:** simple tracker
- **User reaction:** praise
- **Magnitude:** 5 (0.67%), mean 4.40
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10858613272`, `13882752696`, `7196952603`, `10335392591`, `12221998930`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

## Markets and languages

### R34-034 — The US is the comparison-shopping market: relative to the other 478 reviews, US reviewers are twice as likely to name competitors (19.62% vs 9.62%), more likely to say 'best' (18.87% vs 11.92%), to be explicit payers (9.06% vs 5.65%) and to praise the price (6.79% vs 3.35%); they report less monetisation friction (7.92% vs 11.92%) but more explicit churn (9 reviews, 3.40%, vs 1.05%)

- **Where:** Executive summary #9 — United States (265, mean 4.577) is the comparison-shopping market
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** US 265 mean 4.577; competitors 19.62 vs 9.62; best 18.87 vs 11.92; payers 9.06 vs 5.65; price praise 6.79 vs 3.35; friction 7.92 vs 11.92; churn 3.40 vs 1.05
- **Direction for us:** research · **Report confidence:** US-only standalone · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against; C062 Weight English-speaking rich markets; volume ≠ revenue

### R34-137 — Reviewers benchmark the free cap against peers: 'Other apps usually have 5 free habits'; 'at least five don't skimp out like that'; 'no 8-10 habits for free' — 2 is below the category norm they expect; one departure was to an app with more free habits

- **Where:** §4.1 The cap is stricter than peers — 'Other apps usually have 5 free habits'; 'at least five don't skimp out like that'; 'no 8-10 habits for free'
- **This app does:** 2 free habits
- **User reaction:** churn
- **Magnitude:** 4 quotes
- **Direction for us:** product-rule · **Report confidence:** high-priority theme · **Generalisable:** yes
- **Review IDs:** `10904298957`, `12108620259`, `12154681308`, `9342516160`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R34-151 — Localisation demand is polite and language-specific: 19 reviews (2.56%, mean 4.32, none 1★) — Chinese 9 ('I hope Chinese will be supported'; 'strongly calling for a Chinese version'; 'too expensive, and no Chinese'; Traditional Chinese; one on the US storefront), Russian 4 (one on the US storefront), Spanish 2 ('No está disponible en español 😿'), French 2 ('when will French come?'), Ukrainian 1, 'more languages' 1; 10.4% of 4★ carry it

- **Where:** §4.5 Cluster 5 — Localisation demand 19 (2.56%), mean 4.32, none 1★ — Chinese 9, Russian 4, Spanish 2, French 2, Ukrainian 1, 'more languages' 1
- **This app does:** English only
- **User reaction:** complaint
- **Magnitude:** 19 (2.56%), mean 4.32; Chinese 9, Russian 4, Spanish 2, French 2, Ukrainian 1
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10084467787`, `10750194157`, `11798227360`, `10114649293`, `10120710103`, `3711570099`, `10790366652`, `11213904536`, `14365358902`, `11768720231`, `13381269097`, `11884894981`, `12121063578`, `10336343530`, `10098119560`
- **Canonical:** C027 Localise early — it unlocks revenue

### R34-177 — US ratings and composition: 5★ 210 (79.2%), 4★ 27 (10.2%), 3★ 11 (4.2%), 2★ 5 (1.9%), 1★ 12 (4.5%), mean 4.577 vs non-US 4.582 (5★ 79.7%, 1★ 5.2%); US reviews are longer (short 10.9% vs 19.5%); only 6 of the 27 June-2023 burst reviews are US; by era US / non-US mean — E1 4.31 / 4.74 (the first cap and data-loss reviews), E2 4.73 / 4.70, E3 4.64 / 4.62, E4 4.49 / 4.53, E5 4.43 / 4.38 — the same downward drift

- **Where:** §7.2 United States — ratings 5★ 210 (79.2%) · 4★ 27 · 3★ 11 · 2★ 5 · 1★ 12 (4.5%); non-US mean 4.582, 5★ 79.7%, 1★ 5.2%; US reviews longer (short 10.9% vs 19.5%); only 6 of the 27 burst reviews from the US; by era table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era | US n | US mean | non-US n | non-US mean ; E1 | 26 | 4.31 | 27 | 4.74 ; E2 | 100 | 4.73 | 149 | 4.70 ; E3 | 47 | 4.64 | 106 | 4.62 ; E4 | 41 | 4.49 | 93 | 4.53 ; E5 | 51 | 4.43 | 103 | 4.38
- **Direction for us:** none · **Report confidence:** US standalone · **Generalisable:** app-specific
- **Review IDs:** `2953267303`, `3850157156`, `3959889582`, `4968235247`
- **Canonical:** — (nuance register)

### R34-178 — US themes (265) vs non-US (478): competitor named 19.62% vs 9.62% (2×); 'best' 18.87% vs 11.92%; year grid 17.74% vs 12.13%; monetisation positive 12.08% vs 6.69%; explicit payer 9.06% vs 5.65%; customisation 7.92% vs 2.30% (3.4×); friction 7.92% (mean 2.29) vs 11.92% — lower in the US; life outcome 7.17% vs 3.35%; price fair 6.79% vs 3.35%; streak 6.42% vs 2.09% (3×); reminders praised 4.53% vs 0.84% (5×); free cap 3.77% (mean 2.00) vs 6.07% — lower share, harsher mean; explicit churn 3.40% vs 1.05% (3×); one-time / lifetime praised 3.02% vs 1.46%; watch/iPad/Mac/sync 3.02% vs 2.09%; back-fill praise 2.64% vs 0.63%; no trial 1.51% (mean 2.00) vs 0.63%; localisation 1.13% vs 3.35%; data lost 1.13% vs 0.21% (anecdotal n=3); n < 5 anecdotal

- **Where:** §7.2 US themes vs non-US (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | US n | US % | US signal | US mean | non-US % | Reading ; Core praise (union) | 192 | 72.45% | high-priority | 4.84 | 65.90% | ; Simplicity | 102 | 38.49% | high-priority | 4.88 | 36.19% | Same as elsewhere ; Design | 59 | 22.26% | high-priority | 4.81 | 22.38% | Same ; Competitor named / tried many | 52 | 19.62% | high-priority | 4.81 | 9.62% | 2× non-US ; "Best" | 50 | 18.87% | high-priority | 4.94 | 11.92% | 1.6× ; Unmet needs (union) | 48 | 18.11% | high-priority | 4.52 | 13.60% | ; Year grid / calendar | 47 | 17.74% | high-priority | 4.87 | 12.13% | 1.5× ; Utility | 37 | 13.96% | high-priority | 5.00 | 12.13% | ; Monetisation positive (union) | 32 | 12.08% | high-priority | 4.84 | 6.69% | 1.8× ; Explicit payer | 24 | 9.06% | high-priority | 4.71 | 5.65% | 1.6× ; Customisation praised | 21 | 7.92% | high-priority | 5.00 | 2.30% | 3.4× ; Monetisation friction (union) | 21 | 7.92% | high-priority | 2.29 | 11.92% | Lower in the US ; Life outcome | 19 | 7.17% | high-priority | 4.89 | 3.35% | 2.1× ; Price fair | 18 | 6.79% | high-priority | 4.89 | 3.35% | 2× ; Streak praised | 17 | 6.42% | high-priority | 4.88 | 2.09% | 3× ; Names Kevin | 14 | 5.28% | high-priority | 4.64 | 3.56% | ; Reminders praised | 12 | 4.53% | very strong | 4.58 | 0.84% | 5× ; Widget demand (union) | 12 | 4.53% | very strong | 4.58 | 5.23% | Same ; Free cap | 10 | 3.77% | very strong | 2.00 | 6.07% | Lower share, harsher mean ; Explicit churn | 9 | 3.40% | very strong | 2.44 | 1.05% | 3× non-US ; Reliability (union) | 9 | 3.40% | very strong | 3.33 | 3.14% | Same ; One-time / lifetime praised | 8 | 3.02% | very strong | 4.75 | 1.46% | ; Watch / iPad / Mac / sync demand | 8 | 3.02% | very strong | 4.62 | 2.09% | ; Price objection | 7 | 2.64% | meaningful | 2.57 | 3.77% | ; Back-filling past dates praised | 7 | 2.64% | meaningful | 4.86 | 0.63% | ; Other gated feature | 5 | 1.89% | meaningful | 1.60 | 1.26% | ; No trial | 4 | 1.51% | meaningful | 2.00 | 0.63% | ; Localisation | 3 | 1.13% | meaningful | 4.00 | 3.35% | Non-English speakers in the US store ; Data lost | 3 | 1.13% | meaningful | 3.00 | 0.21% | Anecdotal (n = 3)
- **Direction for us:** research · **Report confidence:** US standalone · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-179 — US is a comparison-shopping market: one US review in five names rivals or says it tried many, as 4.81-mean verdicts — 'I've tried every unit tracker and even subscribed to them all, and this is the best one'; 'I downloaded (and eventually deleted) several habit tracking apps'; 'i've tried a million different habit tracker apps'

- **Where:** §7.2 What is distinctive about the US #1 — a comparison-shopping market: one US review in five names rivals or says it tried many (4.81 mean) — 'I've tried every unit tracker and even subscribed to them all, and this is the best one'
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 52 (19.62%), mean 4.81
- **Direction for us:** none · **Report confidence:** US high-priority · **Generalisable:** yes
- **Review IDs:** `10653375848`, `10773056833`, `10890223306`
- **Canonical:** C005 Know which competitors buyers compare against; C062 Weight English-speaking rich markets; volume ≠ revenue

### R34-180 — US reviewers explain the mechanism: streak praise 3× and year-grid praise 1.5× the non-US rate, often citing a method — 'Don't Break The Chain', Seinfeld, GitHub commits, '80% consistent'

- **Where:** §7.2 US #2 — US reviewers explain the mechanism: streak and year-grid praise 3× and 1.5× non-US, often with a method (Don't Break The Chain, Seinfeld, GitHub commits, '80% consistent')
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** streak 6.42 vs 2.09; year grid 17.74 vs 12.13
- **Direction for us:** none · **Report confidence:** US high-priority · **Generalisable:** yes
- **Review IDs:** `6886056651`, `5242717566`, `14284351778`, `8746143988`
- **Canonical:** C012 Week / month / year grid views

### R34-181 — US reviewers pay and say so: 24 explicit payers (9.06%), mean 4.71 — 'More than SIX years using this app'

- **Where:** §7.2 US #3 — US reviewers pay and say so: 24 explicit payers, mean 4.71 ('More than SIX years using this app')
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 24 (9.06%), mean 4.71
- **Direction for us:** none · **Report confidence:** US high-priority · **Generalisable:** yes
- **Review IDs:** `3307938448`, `4462219747`, `4497735688`, `10791117607`, `11286612018`, `13881561697`, `13919822858`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R34-182 — In the US the wall hits less often but ends in departure: friction 7.92% (vs 11.92%), yet 9 of the 14 explicit churn reviews are US — the cap (2), another app with more free habits, ADHD can't afford, $9/$20/$40 with a 3-day trial, no iPad/Mac, another app suited better, reminders, calendar editing

- **Where:** §7.2 US #4 — less wall friction, but when it hits, they leave: 9 of the 14 explicit churn reviews are from the US
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 9 of 14 churn (US 3.40% vs 1.05%)
- **Direction for us:** research · **Report confidence:** US very strong · **Generalisable:** yes
- **Review IDs:** `2953267303`, `3850157156`, `12108620259`, `12221998930`, `12738794859`, `11077980453`, `12887838325`, `13505537432`, `13559189439`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C062 Weight English-speaking rich markets; volume ≠ revenue

### R34-183 — The sharpest disclosure and trial complaints come from US reviewers

- **Where:** §7.2 US #5 — the sharpest disclosure and trial complaints are US reviews
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 4 reviews; no trial US 1.51% (mean 2.00) vs 0.63%
- **Direction for us:** do · **Report confidence:** US meaningful (anecdotal n<5) · **Generalisable:** yes
- **Review IDs:** `11348148556`, `12233797625`, `11939700468`, `12738794859`
- **Canonical:** C063 Free trial before purchase; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R34-184 — US by star band: 1★ (12) — cap 4, gated features 3, trial 1, data loss 1, reminders 1 (a payer), the promotion 'scam' 1, gibberish 1; 2★ (5) — nagging, Shortcuts, cap/churn 2, price; 3★ (11) — mostly price or cap, disclosure, data loss, reminders, rating prompt, gated colours; 4★ (27) — requests 18 of 27 (66.7%): notes on missed days, quantities, Mac/iPad, actionable notifications, past-date editing

- **Where:** §7.2 US by star band — 1★ (12): cap 4, gated features 3, trial, data loss, reminders (payer), promotion 'scam', gibberish; 2★ (5); 3★ (11); 4★ (27): requests 18 of 27 (66.7%) — notes on missed days, quantities, Mac/iPad, actionable notifications, past-date editing
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 1★ 12; 2★ 5; 3★ 11; 4★ 27 (requests 66.7%)
- **Direction for us:** none · **Report confidence:** US standalone (small bands) · **Generalisable:** app-specific
- **Review IDs:** `2953267303`, `3850157156`, `11348148556`, `13036244176`, `3959889582`, `6433058881`, `14415373834`, `11939700468`, `4968235247`, `5535050975`, `10087293260`, `7920968910`, `7879946381`, `11817893086`, `12108620259`, `12221998930`, `12738794859`, `5526275566`, `11554013205`, `12124114850`, `12233797625`, `10781087412`, `13505537432`, `13586879451`, `13629525960`, `13583853777`, `13432208041`, `11077980453`, `10052127570`, `10100128513`, `10732085902`, `13559189439`
- **Canonical:** — (nuance register)

### R34-186 — Global vs US: mean 4.577 / 4.582 / 4.580; competitor 19.62 / 9.62 / 13.19%; payer 9.06 / 5.65 / 6.86%; friction 7.92 / 11.92 / 10.50%; cap 3.77 / 6.07 / 5.25%; churn 3.40 / 1.05 / 1.88%; localisation 1.13 / 3.35 / 2.56%; short 10.9 / 19.5 / 16.4% — US reviewers compare, pay and articulate; non-US reviewers hit the cap and the English-only UI more often and write shorter reviews; the overall rating is identical, so the difference is in why people rate, not how high; no cultural generalisation beyond measured differences

- **Where:** §7.3 Global vs US comparison (verbatim table) — Interpretation: US reviewers compare, pay and articulate; non-US hit the cap and English-only UI more and write shorter; overall rating identical
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Pattern | US | Non-US (478) | Global ; Mean rating | 4.577 | 4.582 | 4.580 ; Competitor named / tried many | 19.62% | 9.62% | 13.19% ; Explicit payer | 9.06% | 5.65% | 6.86% ; Monetisation friction | 7.92% | 11.92% | 10.50% ; Free cap | 3.77% | 6.07% | 5.25% ; Explicit churn | 3.40% | 1.05% | 1.88% ; Localisation request | 1.13% | 3.35% | 2.56% ; Short reviews (≤ 25 chars) | 10.9% | 19.5% | 16.4%
- **Direction for us:** research · **Report confidence:** US standalone · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R34-187 — Outside the US the 2-habit cap and English-only UI bite harder: cap 6.07% vs 3.77% and friction 11.92% vs 7.92%; localisation requests 3.35% vs 1.13% — non-English markets face both a price wall and a language wall

- **Where:** §7.3 non-US reviewers hit the cap more often (6.07% vs 3.77%) and the English-only UI (localisation 3.35% vs 1.13%)
- **This app does:** 2-habit cap, English only
- **User reaction:** complaint
- **Magnitude:** cap 6.07 vs 3.77; friction 11.92 vs 7.92; localisation 3.35 vs 1.13
- **Direction for us:** product-rule · **Report confidence:** non-US aggregate (75 storefronts, none ≥ 50) · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C027 Localise early — it unlocks revenue

## Dated events and trends

### R34-015 — Monetisation friction rose sharply after 2024 without a price-model change: 5.7% of E1 and 8.4% of E2, then 16.4% of E4 (2024) and 14.3% of E5 (2025–26); cap complaints went from 2.8% of E2 to 9.7% of E4

- **Where:** Executive summary #2 — friction rose sharply after 2024: 5.7% E1, 8.4% E2 → 16.4% E4, 14.3% E5; cap complaints 2.8% E2 → 9.7% E4
- **This app does:** same 2-habit cap throughout
- **User reaction:** complaint
- **Magnitude:** friction 5.7% → 8.4% → 16.4% → 14.3%; cap 2.8% E2 → 9.7% E4
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R34-020 — Ratings drift down slowly as paywall friction rises, not from reliability: era means 4.71 (E2) → 4.63 (E3) → 4.51 (E4) → 4.40 (E5); 1–2★ share 3.3% of E3 → 7.5% of E4 → 11.0% of E5 (17 of 154); 2026 so far mean 4.26 with 15.4% 1–2★ (n = 39, small)

- **Where:** Executive summary #4 — ratings are drifting down slowly: era means 4.71 (E2) → 4.63 (E3) → 4.51 (E4) → 4.40 (E5); 1–2★ 3.3% E3 → 7.5% E4 → 11.0% E5 (17/154); 2026 4.26, 15.4% 1–2★ (n=39); driven by the paywall, not reliability
- **This app does:** paywall unchanged, friction rising
- **User reaction:** complaint
- **Magnitude:** 4.71 → 4.63 → 4.51 → 4.40; 1–2★ 3.3% → 7.5% → 11.0%; 2026 4.26 / 15.4%
- **Direction for us:** product-rule · **Report confidence:** high-priority in E5 · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R34-022 — Shipping a long-requested widget turned it into the top new praise: widgets shipped ~mid-March 2024 ('Thanks to the devs for adding the widgets!') and widget praise reached 24 reviews (3.23%), 11.2% of E4 — 'I use the widget religiously'; one reviewer edited their review up after the launch

- **Where:** Executive summary #5 — widgets shipped ~mid-Mar 2024: widget praise 24 (3.23%), 11.2% of E4
- **This app does:** widgets shipped Mar 2024 (streak, month overview)
- **User reaction:** praise
- **Magnitude:** 24 (3.23%); 11.2% of E4
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11062493236`, `12172218323`, `11077980453`, `11580982926`
- **Canonical:** C009 Basic widgets, icons and colours are free; C059 Be visibly responsive; fixes bring reviewers back

### R34-037 — Per-year volume, mean, 5★/1★/1–2★ share, substantive mean, short share, US n and mean

- **Where:** §1.6 By year table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | mean | 5★ % | 1★ % | 1–2★ % | substantive mean | short % | US n | US mean ; 2018 (from 13 Jul) | 24 | 4.62 | 75.0 | 4.2 | 4.2 | 4.59 | 0.0 | 8 | 4.38 ; 2019 | 59 | 4.54 | 76.3 | 6.8 | 6.8 | 4.48 | 10.2 | 36 | 4.50 ; 2020 | 89 | 4.67 | 87.6 | 5.6 | 5.6 | 4.74 | 14.6 | 39 | 4.69 ; 2021 | 49 | 4.78 | 87.8 | 2.0 | 4.1 | 4.81 | 12.2 | 19 | 4.58 ; 2022 | 35 | 4.91 | 94.3 | 0.0 | 0.0 | 4.87 | 14.3 | 10 | 5.00 ; 2023 | 144 | 4.60 | 77.1 | 4.2 | 4.9 | 4.72 | 27.1 | 42 | 4.67 ; 2024 | 189 | 4.56 | 77.2 | 4.2 | 6.3 | 4.51 | 15.3 | 60 | 4.57 ; 2025 | 115 | 4.44 | 76.5 | 7.0 | 9.6 | 4.43 | 17.4 | 37 | 4.46 ; 2026 (to 6 Sep) | 39 | 4.26 | 74.4 | 10.3 | 15.4 | 4.44 | 10.3 | 14 | 4.36
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-038 — Era definitions E1–E5 from product events, with n, mean, 5★/1★/1–2★ and short shares

- **Where:** §1.6 Eras used throughout (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era | Window | What reviewers describe | n | % | mean | 5★ % | 1★ % | 1–2★ % | short % ; E1 | 2018-07-13 → 2019-09-30 | One-time Premium ($5, later $9); "no subscription"; weekly habits added (Apr 2019) | 53 | 7.1% | 4.53 | 71.7 | 5.7 | 5.7 | 5.7 ; E2 | 2019-10-01 → 2023-06-27 | Subscription + lifetime from autumn 2019; "Super Habit"; notes, colours, monthly view (Apr 2020), share cards (2021); widget requests | 249 | 33.5% | 4.71 | 87.6 | 4.4 | 5.2 | 13.7 ; E3 | 2023-06-28 → 2024-03-18 | 28–30 June 2023 promotion burst; Chinese-language requests; widget-request peak; "Daily Habits" | 153 | 20.6% | 4.63 | 75.8 | 3.3 | 3.3 | 24.8 ; E4 | 2024-03-19 → 2024-12-31 | Widgets shipped (non-interactive); April 2024 crash, fixed in a day; templates | 134 | 18.0% | 4.51 | 76.1 | 4.5 | 7.5 | 17.2 ; E5 | 2025-01-01 → 2026-09-06 | "Evoday"; 3-day trial reported; one-time option removal and lifetime disputes; CSV export disabled; reminder picker bug; free tier reported as 4 habits (2026) | 154 | 20.7% | 4.40 | 76.0 | 7.8 | 11.0 | 15.6
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `4497735688`, `4924456384`, `11004886291`, `11062493236`
- **Canonical:** — (nuance register)

### R34-039 — The rating peak came in the quiet, stable years before growth: 2022 mean 4.91, 94.3% 5★, zero 1★ (n = 35); after the 2023 promotion and volume rise the mean fell each year to 4.26 in 2026 (10.3% 1★, 15.4% 1–2★, n = 39)

- **Where:** §1.6 2022 is the best year: mean 4.91, 94.3% 5★, 0 1★ (n=35); 2026 mean 4.26, 10.3% 1★, 15.4% 1–2★
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2022 4.91 / 94.3% 5★ (n=35) → 2023 4.60 → 2024 4.56 → 2025 4.44 → 2026 4.26
- **Direction for us:** research · **Report confidence:** small annual n · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R34-063 — The business timeline reviewers lived: Jul 2018 launch (found via Reddit), 2 free habits, one-time Premium ~$5 → Dec 2018 'lifetime premium' wording → Apr 2019 weekly habits on request → Jul 2019 one-time $9, 'no subscription' → Oct 2019 subscription (£3.99/mo) → 2020 '$40 total', CA$7.99/mo, CA$19.99/yr, CA$55 once; Apr 2020 monthly view → iOS 14 widget requests from Oct 2020 → 2021 share cards, notifications stop after an update → Dec 2021 alternate icon stops changing (also 2023, 2024) → 28–30 Jun 2023 free-lifetime promotion burst → Jun 2023 – Jan 2024 Chinese / Russian / Ukrainian requests → Dec 2023 developer points to long-press → mid-Mar 2024 widgets ship (not interactive) → 10–11 Apr 2024 launch crash fixed a day later → Sep 2024 widget turns white with iOS 18 tint → Dec 2024 delete requires paid backup → Jun 2025 $9/mo, $20/yr, $40 lifetime, 3-day trial → Jul 2025 'Evoday' → Nov 2025 one-time option 'gone' → Dec 2025 50% offer £9.99/yr, reminder picker broken → Jan–Jul 2026 free tier 4 habits, €9.99–20/yr, 'only in Abo' → Feb 2026 CSV export disabled, 20–30 launches to load → Mar 2026 reminder only at current time → Jun–Jul 2026 lifetime 'wont be working' vs 'you only pay once'

- **Where:** §2.2 Timeline of the business (verbatim table)
- **This app does:** eight years of iterative change
- **User reaction:** mixed
- **Magnitude:** When (from reviews) | Event | Evidence ; Jul 2018 | Launch (found via Reddit). 2 free habits; one-time Premium ~$5 | 2949637870, 2953267303 ("limiting the test user to 2 habits and asking for $5"), 3307938448 ("worth the $5") ; Dec 2018 | "Lifetime premium" wording | 3503457494 ; Apr 2019 | Weekly / x-per-week habits added on request | 3954949955, 3944773451 ; Jul 2019 | One-time upgrade $9; "no subscription model" | 4462219747, 4455008126, 4497735688 ; Oct 2019 | Subscription appears (£3.99/month) | 4924456384 ; Dec 2019 – Jan 2020 | Busy period of 5★ reviews (24 in Dec, mean 4.92); notes present | 5288658286, 5291008046 ; Feb – Jun 2020 | "$40 total"; CA$7.99/mo, CA$19.99/yr, CA$55 once | 5526275566, 6028222005 ; Apr 2020 | Monthly view and GitHub-like view | 5755729025 ; Oct 2020 – 2023 | iOS 14 widget requests begin | 6576140378, 6580579419, 6901067746 ; 2021 | Share cards; notifications stop firing after one update | 7906994184, 6830197392 ; Dec 2021 | Alternate app icon stops changing after an update (also 2023, 2024) | 8172167468, 10209615596, 10781087412 ; 28–30 Jun 2023 | Probable free-lifetime promotion: 27 reviews in 3 days | 10083799946, 10085535827, 10087293260, 12597410321 ; Jun 2023 – Jan 2024 | Wave of requests for Chinese, Russian, Ukrainian | 10084467787, 10750194157, 10336343530 ; Dec 2023 | Developer points a reviewer to long-press to mark yesterday | 10732085902 ; ~Mid-Mar 2024 | Widgets ship (not interactive) | 11062493236, 11077980453, 11138339931 ("stunning but have some minor errors") ; 10–11 Apr 2024 | Update crashes on launch; fixed a day later | 11145404810, 11147450348 ; Sep 2024 | Widget turns white with iOS 18 tinted home screen | 11740378083 ; Dec 2024 | Deleting requires a backup, described as paid | 12046497872 ; Jun 2025 | $9/month, $20/year, $40 lifetime; 3-day trial | 12738794859 ; Jul 2025 | Name "Evoday" appears | 12842151586 ; Nov 2025 | "Please provide one time purchase option. After updating the app this option is gone" | 13392990758 ; Dec 2025 | 50% offer: £9.99/year; reminder time picker broken | 13560914935, 13505537432 ; Jan – Jul 2026 | Free tier reported as 4 habits; €9.99–20/year; "only in Abo" (subscription) | 13597043858, 14316571521, 13600419608, 13740072982 ; Feb 2026 | CSV export disabled; app needs 20–30 launches to load | 13731751322, 13744408241 ; Mar 2026 | Reminder can only be set to the current time | 13868583107 ; Jun – Jul 2026 | "lifetime subscription wont be working anymore"; another says "you only pay once" | 14138883204, 14284351778
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `2949637870`, `2953267303`, `3307938448`, `3503457494`, `3954949955`, `4462219747`, `4924456384`, `5526275566`, `6028222005`, `5755729025`, `6576140378`, `7906994184`, `6830197392`, `8172167468`, `10083799946`, `10084467787`, `10732085902`, `11062493236`, `11145404810`, `11740378083`, `12046497872`, `12738794859`, `12842151586`, `13392990758`, `13560914935`, `13505537432`, `13597043858`, `13731751322`, `13744408241`, `13868583107`, `14138883204`, `14284351778`
- **Canonical:** — (nuance register)

### R34-065 — A launch crash fixed within a day did no visible lasting damage: the 10–11 Apr 2024 update crashed on launch ('after the April 10th 2024 update'; 'the 2024.4 update') and was fixed a day later; reliability union 6.7% of E4, then 2.6% of E5

- **Where:** §2.2 10–11 Apr 2024 update crashes on launch; fixed a day later
- **This app does:** fast hotfix
- **User reaction:** complaint
- **Magnitude:** crash 3 (weak); reliability E4 6.7% → E5 2.6%
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11145404810`, `11147450348`
- **Canonical:** C031 Crashes / launch failures

### R34-142 — Widget story by phase: Oct 2020 – Mar 2024 request (28 of the 30; 'iOS 14 widget would be cool!'; one star withheld; a month-grid widget) → mid-Mar 2024 shipped ('the new widgets are a huge selling point') → 2024–26 praise 24 (15 in E4; 'Widgets are a highlight'; chose the app for its widgets; half-marathon training) → next ask interactive 7 → problems 5 (two of six widgets don't show days; white in tinted mode; 'keeps getting disabled'; 'does not work on iphone :: waste money') → 2025 paywalled 2

- **Where:** §4.2 Cluster 2 — The widget story (verbatim phase table)
- **This app does:** widgets shipped after 3.5 years of requests
- **User reaction:** mixed
- **Magnitude:** Phase | What reviewers say | n | Evidence ; Oct 2020 – Mar 2024: request | "iOS 14 widget would be cool!"; one star withheld for a widget | 28 of the 30 requests | 6580579419, 9470823701, 10335392591 (a month-grid widget), 10552434405 ; Mid-Mar 2024: shipped | "Thanks to the devs for adding the widgets!"; "the new widgets are a huge selling point" | — | 11062493236, 11077980453 ; 2024–26: praise | "I use the widget religiously"; "Widgets are a highlight"; chose the app for its widgets | 24 (15 in E4) | 12172218323, 11704110690, 11404887985, 12926583376 (half-marathon training) ; 2024–26: next ask | Interactive widgets | 7 | 11412519740, 13731564617 ; 2024–26: problems | Two of six widgets don't show days; white in tinted mode; "keeps getting disabled"; "does not work on iphone :: waste money" | 5 | 11081066933, 11740378083, 11520002759, 12326097524 ; 2025: paywalled | "Cant use widgets without subscription" | 2 | 12760639157, 12738794859
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `6580579419`, `9470823701`, `10335392591`, `10552434405`, `11062493236`, `11077980453`, `12172218323`, `11704110690`, `11404887985`, `12926583376`, `11412519740`, `13731564617`, `11081066933`, `11740378083`, `11520002759`, `12326097524`, `12760639157`, `12738794859`
- **Canonical:** C009 Basic widgets, icons and colours are free; C059 Be visibly responsive; fixes bring reviewers back

### R34-149 — Trust events 2025–26, each 1–2 reviews, coinciding with the E5 fall (mean 4.40, 1–2★ 11.0%): one-time option removed after an update (Nov 2025, 3★); 'Lifetime' stops working after a year or two (Jun 2026, 'False claim', 2★); CSV export disabled (Feb 2026, 'Vendor Lock', 1★); paid backup required to delete (Dec 2024, 1★); reminder time picker only offers 'today' near the current time — paid user ('I payed for this app … I might just cancel my membership', Dec 2025, 3★) and the same bug in China (Mar 2026, 5★); 20–30 launch attempts after the last two updates (Feb 2026, 5★ MISRATE); rating prompt before setup finished (Jan 2026, 3★)

- **Where:** §4.4 Cluster 4 — Trust events in 2025–26 (verbatim table)
- **This app does:** trust events
- **User reaction:** complaint
- **Magnitude:** Event | Evidence | Rating ; One-time purchase option removed after an update | 13392990758 (Nov 2025) | 3★ ; "Lifetime" stops working after a year or two | 14138883204 (Jun 2026: "False claim") | 2★ ; CSV export disabled | 13731751322 (Feb 2026: "Vendor Lock") | 1★ ; Backup (paid) required to delete | 12046497872 (Dec 2024) | 1★ ; Reminder time picker only offers "today" near the current time — paid user | 13505537432 (Dec 2025: "I payed for this app … I might just cancel my membership") | 3★ ; Same reminder bug | 13868583107 (Mar 2026, China) | 5★ ; App needs 20–30 launch attempts to load after the last two updates | 13744408241 (Feb 2026) | 5★ (MISRATE) ; Rating prompt before setup is finished | 13586879451 (Jan 2026) | 3★
- **Direction for us:** must-never-break · **Report confidence:** weak individually; clustered in E5 · **Generalisable:** yes
- **Review IDs:** `13392990758`, `14138883204`, `13731751322`, `12046497872`, `13505537432`, `13868583107`, `13744408241`, `13586879451`
- **Canonical:** C020 Data export / backup / CSV; C031 Crashes / launch failures; C039 Reminders fire reliably, once; C150 Never ask for a rating before the user has used the app; C186 Never revoke what earlier buyers paid for when the model changes

### R34-152 — A promotion that reaches non-English markets produces localisation demand the app cannot serve: 11 of the 19 localisation requests arrived in E3 (7.2% of the era), starting the day of the June 2023 free-lifetime burst that brought reviewers from br, vn, cn and co

- **Where:** §4.5 11 of the 19 arrived in E3 (7.2%), starting the day of the June 2023 burst, which brought reviewers from br, vn, cn and co — the promotion reached non-English users the app could not serve
- **This app does:** English-only app promoted globally
- **User reaction:** complaint
- **Magnitude:** 11/19 in E3 (7.2%)
- **Direction for us:** do · **Report confidence:** meaningful in E3 · **Generalisable:** yes
- **Conditions:** localise before (or with) a global promotion
- **Review IDs:** `10084467787`
- **Canonical:** C027 Localise early — it unlocks revenue; C225 A one-off free promotion (App of the Week, partner promo) acquires durable users

### R34-161 — Payers by era: E1 10 (18.9%, mean 4.80) · E2 16 (6.4%, 4.62) · E3 6 (3.9%, 5.00) · E4 6 (4.5%, 4.83) · E5 13 (8.4%, 4.23); rating split 42 at 5★, 4 at 4★, 2 at 3★, 1 at 2★, 2 at 1★

- **Where:** §6.2 Payers are satisfied, and E5 is their weakest era (verbatim table) — E1 10 (18.9%, 4.80) · E2 16 (6.4%, 4.62) · E3 6 (3.9%, 5.00) · E4 6 (4.5%, 4.83) · E5 13 (8.4%, 4.23); split 42/4/2/1/2
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era | Explicit payers | % of era | Mean ; E1 (2018 – Sep 2019) | 10 | 18.9% | 4.80 ; E2 (Oct 2019 – Jun 2023) | 16 | 6.4% | 4.62 ; E3 (Jun 2023 – Mar 2024) | 6 | 3.9% | 5.00 ; E4 (Mar – Dec 2024) | 6 | 4.5% | 4.83 ; E5 (2025–26) | 13 | 8.4% | 4.23
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-189 — Ratings drift down after 2022, driven by monetisation friction, not reliability: mean E1 4.53 → E2 4.71 → E3 4.63 → E4 4.51 → E5 4.40; substantive mean 4.49 → 4.77 → 4.65 → 4.44 → 4.43; 5★ share 71.7 → 87.6 → 75.8 → 76.1 → 76.0%; 1–2★ share 5.7 → 5.2 → 3.3 → 7.5 → 11.0%; by year 4.91 (2022, n = 35) → 4.60 → 4.56 → 4.44 → 4.26 (2026, n = 39)

- **Where:** §8.2 Trend 1 — Ratings drift down after 2022 (verbatim table): mean 4.53 → 4.71 → 4.63 → 4.51 → 4.40; substantive 4.49 → 4.77 → 4.65 → 4.44 → 4.43; 5★ 71.7 → 87.6 → 75.8 → 76.1 → 76.0; 1–2★ 5.7 → 5.2 → 3.3 → 7.5 → 11.0; by year 4.91 (2022) → 4.60 → 4.56 → 4.44 → 4.26 (2026); driver monetisation friction; reliability does not rise in step
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Series | E1 | E2 | E3 | E4 | E5 ; Mean (all) | 4.53 | 4.71 | 4.63 | 4.51 | 4.40 ; Mean (substantive) | 4.49 | 4.77 | 4.65 | 4.44 | 4.43 ; 5★ share | 71.7% | 87.6% | 75.8% | 76.1% | 76.0% ; 1–2★ share | 5.7% | 5.2% | 3.3% | 7.5% | 11.0%
- **Direction for us:** product-rule · **Report confidence:** high-priority in E5 · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R34-190 — The wall became the story: friction (% of era) E1 5.7 → E2 8.4 → E3 6.5 → E4 16.4 → E5 14.3; free cap 3.8 → 2.8 → 3.9 → 9.7 → 7.1; price objection 1.9 → 4.4 → 2.0 → 5.2 → 1.9; other gated feature 1.9 → 0.8 → 0.7 → 1.5 → 3.2; no trial 1.9 → 0.8 → 0.0 → 0.7 → 1.9; monetisation positive 13.2 → 8.4 → 8.5 → 6.0 → 9.7; friction doubled from E3 to E4 (10 → 22 reviews) as review volume grew and widgets launched; in E5 the objection shifts from habit count toward features behind the paywall (widgets, colours, notes) and the trial; the 2026 4-habit reports are too few to show an effect

- **Where:** §8.3 Trend 2 — The wall became the story (verbatim table): friction 5.7 → 8.4 → 6.5 → 16.4 → 14.3; cap 3.8 → 2.8 → 3.9 → 9.7 → 7.1; price 1.9 → 4.4 → 2.0 → 5.2 → 1.9; other gated 1.9 → 0.8 → 0.7 → 1.5 → 3.2; no trial 1.9 → 0.8 → 0.0 → 0.7 → 1.9; monetisation positive 13.2 → 8.4 → 8.5 → 6.0 → 9.7
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Series (% of era) | E1 | E2 | E3 | E4 | E5 ; Monetisation friction (union) | 5.7 | 8.4 | 6.5 | 16.4 | 14.3 ; Free cap | 3.8 | 2.8 | 3.9 | 9.7 | 7.1 ; Price objection | 1.9 | 4.4 | 2.0 | 5.2 | 1.9 ; Other gated feature | 1.9 | 0.8 | 0.7 | 1.5 | 3.2 ; No trial | 1.9 | 0.8 | 0.0 | 0.7 | 1.9 ; Monetisation positive (union) | 13.2 | 8.4 | 8.5 | 6.0 | 9.7
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13597043858`, `14316571521`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R34-191 — As a paywall matures, the objection moves from the habit count to everyday features behind it: in E5 'other gated feature' rose to 3.2% (from 0.7–1.5%) and no-trial to 1.9% while the cap fell from 9.7% to 7.1%

- **Where:** §8.3 In E5 the objection shifts from habit count toward features behind the paywall (widgets, colours, notes) and the trial
- **This app does:** features gated in E5
- **User reaction:** complaint
- **Magnitude:** other gated E5 3.2; no trial E5 1.9; cap 9.7 → 7.1
- **Direction for us:** product-rule · **Report confidence:** high-priority (trend) · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C133 Gate on capability, not on quantity

### R34-192 — Ship the most-requested feature and it becomes the most-praised one — a clean before/after: widget request E1 1.9 → E2 3.2 → E3 11.1 → E4 1.5 → E5 1.3%; widget praise 0.0 → 0.4 (one probably misattributed review) → 0.0 → 11.2 → 5.2%; interactive-widget request 0 → 0 → 0 → 2.2 → 2.6%; widget broken 0 → 0 → 0 → 3.0 → 0.6% — the corpus's strongest evidence that the developer's roadmap follows reviews

- **Where:** §8.4 Trend 3 — Widgets: request, launch, praise, next request (verbatim table): request 1.9 → 3.2 → 11.1 → 1.5 → 1.3; praise 0.0 → 0.4* → 0.0 → 11.2 → 5.2; interactive 0 → 0 → 0 → 2.2 → 2.6; broken 0 → 0 → 0 → 3.0 → 0.6
- **This app does:** widgets shipped Mar 2024
- **User reaction:** praise
- **Magnitude:** Series (% of era) | E1 | E2 | E3 | E4 | E5 ; Widget request | 1.9 | 3.2 | 11.1 | 1.5 | 1.3 ; Widget praise | 0.0 | 0.4* | 0.0 | 11.2 | 5.2 ; Interactive-widget request | 0.0 | 0.0 | 0.0 | 2.2 | 2.6 ; Widget broken | 0.0 | 0.0 | 0.0 | 3.0 | 0.6
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `7611242355`
- **Canonical:** C009 Basic widgets, icons and colours are free; C059 Be visibly responsive; fixes bring reviewers back

### R34-193 — Praise shifted from 'useful' to 'beautiful and the best' as the audience widened: core praise E1 77.4 → 74.7 → 64.7 → 59.0 → 66.2%; simplicity 50.9 → 39.4 → 32.0 → 35.1 → 35.1; utility ('helps me') 24.5 → 18.5 → 9.2 → 6.0 → 9.1; design 34.0 → 18.1 → 25.5 → 25.4 → 19.5; developer praised 13.2 → 8.8 → 4.6 → 6.0 → 5.2; generic only 1.9 → 8.8 → 11.1 → 11.2 → 10.4; short reviews 5.7 → 13.7 → 24.8 → 17.2 → 15.6 — early reviews were long and personal from Reddit-sourced early adopters who talk to 'Kevin'; from E3 reviews are shorter and generic (June 2023 burst, in-app prompt, wider audience), so the fall in core-praise share partly reflects mix change, not less satisfaction

- **Where:** §8.5 Trend 4 — Praise shifted from 'useful' to 'beautiful and the best' (verbatim table): core 77.4 → 74.7 → 64.7 → 59.0 → 66.2; simplicity 50.9 → 39.4 → 32.0 → 35.1 → 35.1; utility 24.5 → 18.5 → 9.2 → 6.0 → 9.1; design 34.0 → 18.1 → 25.5 → 25.4 → 19.5; developer 13.2 → 8.8 → 4.6 → 6.0 → 5.2; generic 1.9 → 8.8 → 11.1 → 11.2 → 10.4; short 5.7 → 13.7 → 24.8 → 17.2 → 15.6
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Series (% of era) | E1 | E2 | E3 | E4 | E5 ; Core praise (union) | 77.4 | 74.7 | 64.7 | 59.0 | 66.2 ; Simplicity | 50.9 | 39.4 | 32.0 | 35.1 | 35.1 ; Utility ("helps me") | 24.5 | 18.5 | 9.2 | 6.0 | 9.1 ; Design | 34.0 | 18.1 | 25.5 | 25.4 | 19.5 ; Developer praised | 13.2 | 8.8 | 4.6 | 6.0 | 5.2 ; Generic only | 1.9 | 8.8 | 11.1 | 11.2 | 10.4 ; Short reviews | 5.7 | 13.7 | 24.8 | 17.2 | 15.6
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-194 — Reliability stays low with one release spike: union 7.5% (E1, 4 reviews) → 2.0 → 1.3 → 6.7% (E4, 9 reviews) → 2.6%; E4's spike is the widget launch (rendering) and one bad release (Apr 2024 launch crash, fixed in a day); E5's reliability reports are fewer but land on payers (reminders, widget) and on launch (20–30 attempts)

- **Where:** §8.6 Trend 5 — Reliability stays low; one release spike: 7.5% (E1, 4) → 2.0 → 1.3 → 6.7% (E4, 9) → 2.6; E4 spike = widget launch rendering + April 2024 crash fixed in a day; E5 reliability reports fewer but land on payers and on launch
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 7.5 → 2.0 → 1.3 → 6.7 → 2.6
- **Direction for us:** must-never-break · **Report confidence:** very strong in E4 only · **Generalisable:** yes
- **Review IDs:** `11081066933`, `11138339931`, `11520002759`, `11740378083`, `11145404810`, `11147450348`, `13505537432`, `12326097524`, `13744408241`
- **Canonical:** C031 Crashes / launch failures; C040 Widgets must not go blank, stale or disagree with the app

### R34-195 — Data & entitlement trust by era: 3.8% (E1, data loss) → 0.8 → 0.7 → 1.5 → 1.9% (E5, 3 reviews — export shutdown, lifetime complaint, one-time option removal); not a trend by count, flagged because of consequence

- **Where:** §8.7 Trend 6 — Trust events cluster in 2025–26: data & entitlement trust 3.8% (E1, data loss) → 0.8 → 0.7 → 1.5 → 1.9% (E5, 3); not a trend by count, flagged because of consequence
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 3.8 → 0.8 → 0.7 → 1.5 → 1.9
- **Direction for us:** must-never-break · **Report confidence:** weak individually · **Generalisable:** yes
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

### R34-196 — Localisation demand by era: 1.9% (E1) → 0.0 (E2) → 7.2% (E3, 11 reviews) → 3.7 → 1.3%; Chinese requests began on 29 June 2023, the day of the promotion burst

- **Where:** §8.8 Trend 7 — Localisation demand arrived with the promotion: 1.9% (E1) → 0.0 → 7.2% (E3, 11) → 3.7 → 1.3; Chinese requests began on 29 June 2023, the day of the burst
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 1.9 → 0.0 → 7.2 → 3.7 → 1.3
- **Direction for us:** build-free · **Report confidence:** meaningful in E3 · **Generalisable:** yes
- **Review IDs:** `10084467787`
- **Canonical:** C027 Localise early — it unlocks revenue

## Positioning

### R34-001 — Habit Tracker – Evoday (App Store ID 1403517519, 'Daily Streaks Calendar & Goals') — a solo / small indie developer reviewers call 'Kevin' (31 reviews name him); the same app ID was called 'Habit Tracker' (2018), 'Super Habit(s)' (2020–23), 'Daily Habits' (2023–25) and 'Evoday' (from Jul 2025); free download with a 2-habit free tier (2018–2025, reported as 4 in 2026); one-time Premium ~$5 → $9 until mid-2019; from autumn 2019 monthly / annual subscription plus lifetime (~$9/mo, ~$20/yr, ~$40 lifetime by 2024–25); no ads; data on the device, no account

- **Where:** header lines 1-10
- **This app does:** developer of record Cosmic Taps SL; bundle com.kevinquisquater.Habits; extracted 8 Sep 2026; analysed 11 Sep 2026; store rank 34
- **User reaction:** praise
- **Magnitude:** 743 written reviews · 76 storefronts · 13 Jul 2018 → 6 Sep 2026; mean 4.580; US 265 is the only storefront ≥ 50 (next gb 34, ca 33, in 32)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Side effects:** renamed four times on one app ID
- **Review IDs:** `5288658286`, `11046696316`, `13919822858`, `5580664864`, `7672593618`, `10100128513`, `9667437355`, `11067277188`, `12427980996`, `12842151586`, `13044612377`, `13467704260`
- **Canonical:** C005 Know which competitors buyers compare against

### R34-011 — This app is where people land after trying others: 98 reviews (13.19%) name a competitor or say they tried many, and only one of them is 1★ — 'I downloaded all the habit trackers, this is the only one I kept'; 'downloaded like 30 different apps'; 'tried over a dozen apps and always come back to this one'

- **Where:** Executive summary #1 — this app is where people land after trying others: 98 (13.19%) name a competitor or say they tried many; only one 1★
- **This app does:** destination app
- **User reaction:** praise
- **Magnitude:** 98 (13.19%); 1 of them 1★
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10184986574`, `13649480321`, `6713570145`
- **Canonical:** C005 Know which competitors buyers compare against

### R34-070 — The same app ID has carried four names — 'Habit Tracker' (2018), 'Super Habit(s)' (2020–23), 'Daily Habits' (2023–25), 'Evoday' (from Jul 2025) — without visible rating effect; reviewers keep using old names

- **Where:** §2.2 Jul 2025 name 'Evoday' appears; renamed four times on one app ID
- **This app does:** renames
- **User reaction:** mixed
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `12842151586`, `5580664864`, `9667437355`
- **Canonical:** — (nuance register)

### R34-099 — Replaced paper / bullet journal 7 (0.94%, mean 4.86) — 'I was drawing habit tables by hand'

- **Where:** §3.1 theme table #46 Replaced paper / bullet journal
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 7 (0.94%), mean 4.86
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R34-125 — Positioned against gamified and cute rivals: simple, uncluttered, fast to log is praised by 273 at 4–5★ — 'no busy visuals, no hokey games'; 'Forget cutesy interfaces, overuse of emojis'; 'Some other apps have too many bells and whistles and I get decision fatigue'

- **Where:** §3.4 Simple, uncluttered, fast to log 273 — 'no busy visuals, no hokey games'; 'Forget cutesy interfaces, overuse of emojis'; 'too many bells and whistles and I get decision fatigue'
- **This app does:** minimal
- **User reaction:** praise
- **Magnitude:** 273 (4–5★)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `5483779509`, `6713570145`, `11286612018`, `11257213711`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R34-133 — This app is overwhelmingly the destination: arrivals from Streaks ('Switching to Super Habit feels like a breath of fresh air'), Ladder, HabitKit (too limited free), a tracker 'that stopped working', ADHD-specific apps, bullet journals and paper (7); departures only a handful — to an app with more free habits, to one with iPad and Mac apps, 'another one worked best for me', 'on the hunt for another'

- **Where:** §3.6 Competitors named — 98 (13.19%, mean 4.85, 89 5★); arrivals from Streaks, Ladder, HabitKit, a tracker that stopped working, ADHD apps, paper
- **This app does:** destination
- **User reaction:** praise
- **Magnitude:** 98 (13.19%), mean 4.85, 89 5★
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `6886056651`, `7672593618`, `12362414599`, `13467704260`, `10791117607`, `10858613272`, `12108620259`, `11077980453`, `12887838325`, `12221998930`
- **Canonical:** C005 Know which competitors buyers compare against

### R34-134 — The mental models reviewers bring: Atomic Habits, the Seinfeld 'don't break the chain' method, #100DaysOfCode, the GitHub contribution graph, and Habitica's day-start setting

- **Where:** §3.6 Reference points — Atomic Habits, the Seinfeld 'don't break the chain' method, #100DaysOfCode, the GitHub contribution graph, Habitica's day-start setting
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `10100128513`, `13462278457`, `5242717566`, `5354055938`, `6662280821`, `14284351778`, `9082639448`
- **Canonical:** C070 Use the language users use: Atomic Habits, 75 Hard

### R34-147 — Lack of iPad / Mac / web loses users to competitors: 'The only reason i'm going with a competitor at the moment is because I don't always want to use my phone' — and they state the conditional return ('A lifetime or yearly purchase with the app across the ecosystem and i'll be right back')

- **Where:** §4.3 'The only reason i'm going with a competitor at the moment is because I don't always want to use my phone'
- **This app does:** iPhone only
- **User reaction:** churn
- **Magnitude:** demand union 18 (2.42%)
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11077980453`
- **Canonical:** C044 Mac / desktop / web app; C141 Native iPad layout

### R34-199 — A year-at-a-glance grid is a differentiator in its own right: 104 reviews rated 4–5★ praise it, and several say no other app does it

- **Where:** Part 9 #1 — a year-at-a-glance grid is a differentiator in its own right (104 at 4–5★; several say no other app does it)
- **This app does:** year grid free
- **User reaction:** praise
- **Magnitude:** 104 (4–5★)
- **Direction for us:** build-free · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Review IDs:** `10791779600`, `9730846797`
- **Canonical:** C012 Week / month / year grid views

## Anti-patterns

### R34-185 — A giveaway that does not deliver becomes a 1★: 'Scam of free life time subscription' (US, 1★) during the June 2023 free-lifetime promotion; promo failed 1

- **Where:** §7.2 US 1★ — 'the promotion scam': free-lifetime promotion did not deliver for a US reviewer
- **This app does:** free-lifetime promo
- **User reaction:** 1★-burst
- **Magnitude:** n=1 (1★)
- **Direction for us:** dont · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `10087293260`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised

## Things not to do

### R34-006 — Do not ask for a rating before the user has finished setting up: the app prompts in-app, sometimes early — 'you want me to rate it before I even finish setting it up', 'App asks for 5 stars review', 'lovely review pop up' — and prompted reviews skew positive and short

- **Where:** Seven warnings #4; §2.4 review prompting
- **This app does:** in-app rating prompt, sometimes during setup
- **User reaction:** complaint
- **Magnitude:** 3 reviews (qualitative)
- **Direction for us:** dont · **Report confidence:** weak / anecdotal · **Generalisable:** yes
- **Side effects:** inflates short 5★ share and weakens the rating as a signal
- **Review IDs:** `13586879451`, `9821511278`, `9613494929`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R34-017 — Do not reveal the free limit only after the user has invested setup: 'Waits until I made two habits to tell me I needed to pay'; 'only to find out AFTER downloading the app that there is a fee' — 3 reviews

- **Where:** Executive summary #3 — not told about the limit before downloading (3)
- **This app does:** limit shown only at the wall
- **User reaction:** complaint
- **Magnitude:** 3 (0.40%)
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11348148556`, `12233797625`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C236 A free-tier limit must announce itself — never silently stop a visible progress signal

### R34-078 — Do not open with promotions before the user has marked a first day: 'Too many promo on start up, not clear how to mark first day'

- **Where:** §2.4 Signals reviewers find troubling — onboarding promotions: 'Too many promo on start up, not clear how to mark first day'
- **This app does:** onboarding promos
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13288687749`
- **Canonical:** C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C159 Launch-to-core-action path with no interstitials

### R34-079 — Do not nag free users who do not need Premium: upgrade nagging / promo pop-ups 4 reviews (0.54%, mean 2.00) — 'constantly being nagged to upgrade to premium. I only track one thing'; 'Very annoying pop ups asking you to upgrade'

- **Where:** §2.4 Signals reviewers find troubling — upgrade nagging (4, 0.54%, mean 2.00)
- **This app does:** upgrade pop-ups
- **User reaction:** complaint
- **Magnitude:** 4 (0.54%), mean 2.00
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `7879946381`, `8233664049`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R34-102 — Confusing / hard to use 6 (0.81%, mean 1.67, 4 1★): onboarding promos, hidden gestures, low contrast in dark mode

- **Where:** §3.1 theme table #55 Confusing / hard to use
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 6 (0.81%), mean 1.67
- **Direction for us:** dont · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C142 Surface existing features where users look; C145 Every promotional or onboarding modal must be dismissible on the smallest screen

### R34-136 — Do not put the wall inside first-run setup: it arrives at habit #3 while the user is still setting up — 'I added 2, tried to add the third and was prompted to pay'; 'Waits until I made two habits to tell me'

- **Where:** §4.1 The wall arrives at habit #3, during setup — 'I added 2, tried to add the third and was prompted to pay'
- **This app does:** wall at habit #3
- **User reaction:** complaint
- **Magnitude:** cap 39 (5.25%), mean 2.44
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `3850157156`, `11348148556`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C137 Show the paywall at the moment of need, not on app open

### R34-208 — Stop upgrade nagging for users who stay within the free tier

- **Where:** Part 10 #3 (§10.1)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** nagging 4 (mean 2.00)
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `7879946381`, `8233664049`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

## Things to do

### R34-033 — A visible, personal developer is an asset that thins as the app grows: developer praise 52 reviews (7.00%, mean 4.96); features built on request ('He listened to the community and implemented weekly habits'; 'has even implemented one of mine'); an in-app 'in progress' roadmap; its share fell from 13.2% of E1 to 5.2% of E5, and one reviewer reports no e-mail reply

- **Where:** Executive summary #8 — developer praise 52 (7.00%), mean 4.96; features built on request; in-app 'in progress' roadmap; share fell 13.2% E1 → 5.2% E5; one reports no email reply
- **This app does:** named solo dev; builds requests; in-app roadmap
- **User reaction:** praise
- **Magnitude:** 52 (7.00%), mean 4.96; 13.2% E1 → 5.2% E5
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `3954949955`, `8400091910`, `13247369835`, `13882752696`, `10904298957`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R34-035 — Cheapest wins in evidence order: (1) state the free limit on the store page and in onboarding, and delay the rating prompt until after setup; (2) let people evaluate before paying — a real trial, or 3–5 free habits; (3) never gate data exit — restore CSV export for everyone and make backup/delete free; (4) honour and publish what 'lifetime' includes and say clearly which plans are sold; (5) fix the reminder time picker and the widget rendering bugs; (6) ship interactive widgets and quantity (partial-completion) habits

- **Where:** Executive summary #10 — cheapest wins, in evidence order (1–6)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** report gives none (ordering by evidence)
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C020 Data export / backup / CSV; C023 Interactive widget check-off; C039 Reminders fire reliably, once; C040 Widgets must not go blank, stale or disagree with the app; C048 Flexible units / partial progress; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C147 Let people use the product before they pay; C186 Never revoke what earlier buyers paid for when the model changes; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R34-121 — Say in the store listing that the app is limited-free: users arrive from 'free app' searches ('I searched for free apps and this one came up'; 'I got this because it was free') and ask for the limit to be stated 'earlier (for example, here)' — i.e. on the App Store page

- **Where:** §3.3 'I searched for free apps and this one came up'; 'I just wish it was said earlier (for example, here)'; 'I got this because it was free'
- **This app does:** limit not in listing
- **User reaction:** complaint
- **Magnitude:** 4 quotes (disclosure argument)
- **Direction for us:** do · **Report confidence:** small, sharp · **Generalisable:** yes
- **Review IDs:** `12233797625`, `10455939599`, `3850157156`, `11348148556`
- **Canonical:** C134 Lead the store listing with what users actually love; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R34-205 — Ship the most-requested feature and it becomes the most-praised one (widgets: request 11.1% of E3 → praise 11.2% of E4)

- **Where:** Part 9 #7 — ship the most-requested feature and it becomes the most-praised one (widgets, E3 → E4)
- **This app does:** widgets
- **User reaction:** praise
- **Magnitude:** 11.1% → 11.2%
- **Direction for us:** do · **Report confidence:** competitor lesson · **Generalisable:** yes
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R34-206 — State the free limit and the plans on the store page and on the first screen, before the user builds habits

- **Where:** Part 10 #1 (§10.1)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 3 disclosure complaints; the wall arrives at habit #3; cap = 40.5% of 1★
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11348148556`, `12233797625`, `10455939599`, `3850157156`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R34-207 — Move the rating prompt after setup and after a streak milestone; cut onboarding promos

- **Where:** Part 10 #2 (§10.1)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** Warning 4; 3 reviews
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13586879451`, `9821511278`, `13288687749`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app; C159 Launch-to-core-action path with no interstitials

### R34-233 — Experiment — disclosure placement: limit shown before vs at habit #3

- **Where:** Part 10 #28 (§10.6)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** experiment
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R34-235 — Experiment — rating-prompt timing: after setup vs after a 7-day streak

- **Where:** Part 10 #30 (§10.6)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** experiment
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

## Contradictions

### R34-074 — Reviewers disagree about whether lifetime is still sold — Nov 2025 'gone', Feb 2026 'only subscription' ('leider nur im Abo'), Jul 2026 'pay once' — possibly a storefront or experiment difference; plan availability that differs by user reads as removal

- **Where:** §2.3 Interpretation — reviewers disagree whether lifetime is still sold (Nov 2025 'gone', Feb 2026 'only subscription', Jul 2026 'pay once')
- **This app does:** lifetime availability inconsistent
- **User reaction:** mixed
- **Magnitude:** 3 dated reviews
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13392990758`, `13740072982`, `14284351778`
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C186 Never revoke what earlier buyers paid for when the model changes

### R34-075 — The trial is inconsistent: 'no free trial' in 2022, 2024 and 2026 vs 'the free trial lasts only 3 days' in 2025

- **Where:** §2.3 Interpretation — the trial is inconsistent: 'no free trial' (2022, 2024, 2026) vs 'the free trial lasts only 3 days' (2025)
- **This app does:** trial inconsistent
- **User reaction:** blocked-conversion
- **Magnitude:** 4 dated reviews
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `9342516160`, `11939700468`, `13827396231`, `12738794859`
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

### R34-122 — The same 2-habit cap is defended by others: 64 positive monetisation reviews (mean 4.91) — 'The 2 habit cap is actually well thought out. It stops me from overdoing the habits'; 'I understand why more than two habits is premium'; 'HabitKit … too many limitations on the free version. With Evoday, you can track two activities … and still have some access to widgets'

- **Where:** §3.3 Against these sit 64 positive monetisation reviews (mean 4.91); 'The 2 habit cap is actually well thought out'; HabitKit comparison
- **This app does:** 2-habit cap
- **User reaction:** praise
- **Magnitude:** 64 (mean 4.91); cap defended 12
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** cap tolerated when disclosed and when the user tracks few habits
- **Review IDs:** `9212886099`, `6836775244`, `13467704260`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R34-132 — Gamification demand is split: five reviewers ask for more gamification while many praise its absence ('I don't need gamification'; 'no hokey games') — any gamification should be optional

- **Where:** §3.5 A real split in demand — five ask for more gamification while many praise its absence; any gamification should be optional
- **This app does:** no gamification
- **User reaction:** mixed
- **Magnitude:** 5 requests vs many praising absence
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `5389230957`, `7660503998`, `10128198936`, `6713570145`
- **Canonical:** C024 Streaks / gamification; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R34-141 — The same 2-habit cap is both the top 1★ cause and the most common purchase trigger: it converts people who have already proven the method on two habits and rejects people who wanted to evaluate the app on their real routine

- **Where:** §4.1 Interpretation — the same cap is the most common purchase trigger among payers; it converts people who proved the method on two habits and rejects people who wanted to evaluate it on their real routine
- **This app does:** 2-habit cap
- **User reaction:** mixed
- **Magnitude:** cap 15/37 1★; top §6.3 trigger
- **Direction for us:** undecided · **Report confidence:** interpretation · **Generalisable:** yes
- **Conditions:** converts users whose two tracked habits succeed; repels users evaluating a full routine
- **Review IDs:** `9655320510`, `13242549122`, `10791117607`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C147 Let people use the product before they pay

### R34-173 — No payer reports a billing dispute or unexpected charge — in contrast with peer apps where billing integrity is a leading payer theme; a simple plan shelf with a local-first, no-account app produced no billing complaints

- **Where:** §6.5 No payer reports a billing dispute or unexpected charge — contrasts with peers where billing integrity is a leading payer theme
- **This app does:** simple billing
- **User reaction:** praise
- **Magnitude:** 0 of 51 payers
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

## Data caveats and method

### R34-002 — Method: all 743 reviews read in full in date order in 6 batches (~125), in every language (English, Spanish, Portuguese, French, German, Italian, Dutch, Swedish, Danish, Polish, Russian, Ukrainian, Chinese, Korean) and hand-coded by one analyst against 95 hand-applied codes, one regex code (KEVIN) and 10 derived unions; a coverage script confirmed 743/743 coded once on the first run; a 29-pattern multilingual recall sweep read every candidate and made 10 corrections; theme counts non-exclusive; signal bands <0.1% ignore · 0.1–0.5% weak · 0.5–1% emerging · 1–3% meaningful · 3–5% very strong · >5% high-priority; denominators 743, eras E1 53 · E2 249 · E3 153 · E4 134 · E5 154, US 265; at this size one review is 0.13% (already 'weak'), four are 0.54% ('emerging'), three US reviews are 1.13% ('meaningful') — treat any theme with n < 5 as anecdotal whatever its label; no version field (release events come from review text, feature dates bracketed by first/last mention); payer evidence self-selected (51 first-person payers, 6.86%, no conversion rate); single rater, no second coder; reconciliation exact — 743 records = 743 unique IDs = sum of 76 by_country files = manifest; rating distribution {5:591, 4:77, 3:27, 2:11, 1:37} matches; mean 4.5801; 0 empty bodies/titles; 0 duplicate-text groups; is_edited 35 (e.g. 10732085902 4★ after a developer tip, 11077980453 after a reply, 11062493236 after widgets shipped); votes too sparse to weight — vote_count non-zero on 31, top 4310058011 (8 votes, a diabetic reviewer's weight-loss story); author ignored as personal data; no download, revenue, retention, churn or refund data; no external source consulted; 672 of 743 (90.4%) carry a specific theme, the 71 generic ones average 4.82

- **Where:** How to read this; Seven warnings #2 #5 #6 #7; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 743/743 coded once; 10 recall corrections; 31 voted records; 35 edited
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `4310058011`, `10732085902`, `11077980453`, `11062493236`
- **Canonical:** — (nuance register)

### R34-003 — The corpus is small and saturated with 5★: 591 of 743 (79.5%) are 5★ and only 48 (6.5%) are 1–2★, so every negative theme rests on small counts — read the IDs, not the percentages

- **Where:** Seven warnings #1 — the corpus is small and saturated with 5★: 591 of 743 (79.5%) 5★, only 48 (6.5%) 1–2★; every negative theme rests on small counts, read the IDs
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 591/743 5★ (79.5%); 48 1–2★ (6.5%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-004 — A limited-time free-lifetime promotion around 29 Jun 2023 produced a review burst: 27 reviews in three days from 11 storefronts (the corpus averages about one every four days), mean 4.81, 25 of them 5★, 55.6% with a body of 25 characters or fewer; four mention the app being free ('Freeeee'; 'This App free'; 'It let's me add as much habits as I want'; 'Scam of free life time subscription') and a later Chinese reviewer asks 'When will there be another limited-time free offer?'; without the 27 the corpus mean is 4.571

- **Where:** Seven warnings #3 — probable promotion burst 28–30 Jun 2023: 27 reviews in three days from 11 storefronts (corpus average ~1 review every four days), mean 4.81, 25 of them 5★, 55.6% with a body ≤ 25 characters; 'Freeeee', 'This App free', 'It let's me add as much habits as I want', 'Scam of free life time subscription'; later 啥时候还有限免呐？; without them the mean is 4.571
- **This app does:** free-lifetime promo
- **User reaction:** 5★-burst
- **Magnitude:** 27 in 3 days, 11 storefronts; mean 4.81; 25 5★; 55.6% ≤ 25 chars; mean without them 4.571
- **Direction for us:** none · **Report confidence:** interpretation (probable) · **Generalisable:** yes
- **Review IDs:** `10083799946`, `10085535827`, `10083139099`, `10087293260`, `12597410321`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C225 A one-off free promotion (App of the Week, partner promo) acquires durable users

### R34-007 — Rating-vs-text contradictions: 5 reviews carry a star rating contradicting their text — 5★ 'Lost all data', 5★ 'Greedy developer', 5★ 'doesn't work after the … update', 5★ 'I have to open the app 20-30 times to get it to load'; positive themes are also reported as 'rated 4–5★' subsets

- **Where:** §1.5 Known limitations — MISRATE: 5 reviews carry a star rating that contradicts their text (5★ 'Lost all data'; 5★ 'Greedy developer'; 5★ 'doesn't work after the … update'; 5★ 'I have to open the app 20-30 times to get it to load')
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5 MISRATE
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `4289434524`, `9342516160`, `11145404810`, `13744408241`
- **Canonical:** — (nuance register)

### R34-008 — Storefront is not nationality or language (the US storefront holds Russian and Korean reviews and a request for Chinese); one Canadian 2021 review praising a 'days since' widget is probably about another app since widgets arrived Mar 2024 (kept as written); reviewers contradict each other on whether a trial exists, whether widgets are free, whether lifetime is still sold and 2 vs 4 free habits — reported, not resolved, possibly storefront, version or A/B differences

- **Where:** §1.5 Known limitations — storefront ≠ nationality ≠ language; one review may be misattributed; reviewers contradict each other on plans
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** limitation · **Generalisable:** yes
- **Review IDs:** `11213904536`, `13580872804`, `10120710103`, `7611242355`
- **Canonical:** — (nuance register)

### R34-036 — Rating distribution, denominator 743

- **Where:** §1.6 Ratings table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Rating | n | % ; 5★ | 591 | 79.54% ; 4★ | 77 | 10.36% ; 3★ | 27 | 3.63% ; 2★ | 11 | 1.48% ; 1★ | 37 | 4.98% ; Mean |  | 4.580
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-041 — Storefront spread: 76 storefronts, only the US clears 50 (265, 35.7%); next gb 34, ca 33, in 32, de 26, es 22, fr 21, br 21, au 15, nl 14, cn 14, mx 13 — every non-US number is limited evidence; all 478 non-US reviews count in global numbers

- **Where:** §1.6 Storefronts: 76; only US clears 50 (us 265, 35.7%); gb 34 · ca 33 · in 32 · de 26 · es 22 · fr 21 · br 21 · au 15 · nl 14 · cn 14 · mx 13
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** us 265 (35.7%); gb 34; ca 33; in 32; de 26; es 22; fr 21; br 21; au 15; nl 14; cn 14; mx 13
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-042 — Feature inventory with free/paid state as reviewers describe it

- **Where:** §2.1 Feature inventory derived from reviews (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Attested by | Free / Paid as reviewers describe it ; One-tap daily check-off on a Today list, with haptics | 5483779509 ("only takes one touch"), 8439520479, 13714210053 ("only takes two clicks … the haptics"), 3249145216 | Free ; Year grid / "GitHub-like" heatmap / "year in pixels", per habit | 2901595370 (2018), 2990453093, 6662280821, 9667437355, 11670216762 ("like repository contributions"), 14284351778 | Free ; Monthly calendar view (added ~April 2020), weekly view | 5755729025 ("the new changes to see your habits in a monthly view"), 7978390766, 10830863058 | Free ; Streak count, success %, all-time stats; trophy on a streak | 3944773451 ("% success rate"), 6897036135, 11886940987, 4720994358 | Free (stats screen "a bit too simple" in free, 13827396231) ; Frequency: daily; x days per week (added ~April 2019); weekly and monthly; "no need to set days" | 3954949955, 4462219747, 5263624340, 12356034152, 13627360138 | Free ; Back-filling past days; import of old data; long-press to mark yesterday | 3944773451 (night-shift use), 4497735688, 10732085902 ("long-pressing the habit … to mark yesterday"), 12073306064 | Import listed as Premium in 2019 (4497735688) ; Reminders: several per habit, per-week schedules | 4455008126, 4462219747, 9730342132 ("3 reminders a day") | Free; "only 2 reminders without paying" (12124114850, probably the habit cap) ; Notes per completed day | 5291008046 (Dec 2019), 5653262510, 6484426109, 11810063518 | Paid ("the paid versions allow you to put notes in", 8181313423; 13605658579) ; Colours per habit (incl. hex code), emoji in titles, alternate app icons, dark mode | 5732133041, 10801319167 ("pick your own colour down to the specific code"), 13325880808, 3413286186 | Paid in part: dark mode and app colour (4462219747, 4497735688), colours (13629525960, 13919822858) ; Habit templates; archive; hide/show; reorder | 11306521525, 12088715354, 13325880808, 6713570145 | Free ; Share cards for social media | 7906994184 (2021: "ready made posts for bragging"), 10032640576, 14088036663 ("send screenshots of main grid to friends") | Free ; Home-screen widgets (from ~March 2024): streak, month overview | 11062493236, 11077980453, 11580982926, 11081066933 | Mixed: "Cant use widgets without subscription" (12760639157); "still have some access to widgets" in free (13467704260) ; Local-first data: on the device / iCloud device backup; manual export/import (CSV); backup file | 4497735688 ("my data isn't stored on a server"), 6791860731, 3550808186, 4122355171, 11674162846 | CSV export disabled in 2026 (13731751322); backup described as paid (12046497872) ; In-app "in progress" roadmap list | 13247369835, 13882752696 | Free
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-081 — Master theme table, denominator 743

- **Where:** §3.1 Complete ranked theme table (verbatim), 74 themes + weak row
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | n | % | Signal | Dir | Mean | 5★ | 1★ | E1 % | E2 % | E3 % | E4 % | E5 % | US % | non-US % ; 1 | Core praise (union) | 507 | 68.24% | high-priority | pos | 4.87 | 459 | 1 | 77.4 | 74.7 | 64.7 | 59.0 | 66.2 | 72.5 | 65.9 ; 2 | Simple / easy / intuitive | 275 | 37.01% | high-priority | pos | 4.93 | 258 | 0 | 50.9 | 39.4 | 32.0 | 35.1 | 35.1 | 38.5 | 36.2 ; 3 | Design / UI praised | 166 | 22.34% | high-priority | pos | 4.77 | 142 | 1 | 34.0 | 18.1 | 25.5 | 25.4 | 19.5 | 22.3 | 22.4 ; 4 | Unmet needs — all requests (union) | 113 | 15.21% | high-priority | unmet | 4.48 | 64 | 1 | 26.4 | 12.0 | 19.0 | 14.2 | 13.6 | 18.1 | 13.6 ; 5 | "Best tracker" / the only one that stuck | 107 | 14.40% | high-priority | pos | 4.96 | 103 | 0 | 15.1 | 15.7 | 15.7 | 9.7 | 14.9 | 18.9 | 11.9 ; 6 | Year grid / month calendar / heatmap praised | 105 | 14.13% | high-priority | pos | 4.93 | 99 | 0 | 18.9 | 14.9 | 14.4 | 11.2 | 13.6 | 17.7 | 12.1 ; 7 | Competitor named / tried many | 98 | 13.19% | high-priority | pos | 4.85 | 89 | 1 | 13.2 | 12.4 | 15.0 | 13.4 | 12.3 | 19.6 | 9.6 ; 8 | Helps build / track habits | 95 | 12.79% | high-priority | pos | 4.98 | 93 | 0 | 24.5 | 18.5 | 9.2 | 6.0 | 9.1 | 14.0 | 12.1 ; 9 | Monetisation friction (union) | 78 | 10.50% | high-priority | neg | 2.68 | 13 | 28 | 5.7 | 8.4 | 6.5 | 16.4 | 14.3 | 7.9 | 11.9 ; 10 | Generic only (no specific theme) | 71 | 9.56% | high-priority | — | 4.82 | 65 | 2 | 1.9 | 8.8 | 11.1 | 11.2 | 10.4 | 9.1 | 9.8 ; 11 | Monetisation positive (union) | 64 | 8.61% | high-priority | pos | 4.91 | 59 | 0 | 13.2 | 8.4 | 8.5 | 6.0 | 9.7 | 12.1 | 6.7 ; 12 | Developer responsive / praised | 52 | 7.00% | high-priority | pos | 4.96 | 50 | 0 | 13.2 | 8.8 | 4.6 | 6.0 | 5.2 | 7.9 | 6.5 ; 13 | Explicit payer (first person) | 51 | 6.86% | high-priority | segment | 4.63 | 42 | 2 | 18.9 | 6.4 | 3.9 | 4.5 | 8.4 | 9.1 | 5.6 ; 14 | Motivating / accountability | 46 | 6.19% | high-priority | pos | 4.96 | 44 | 0 | 11.3 | 4.0 | 5.2 | 6.7 | 8.4 | 6.0 | 6.3 ; 15 | Free-tier habit cap | 39 | 5.25% | high-priority | neg | 2.44 | 3 | 15 | 3.8 | 2.8 | 3.9 | 9.7 | 7.1 | 3.8 | 6.1 ; 16 | Widget demand (union) | 37 | 4.98% | very strong | unmet | 4.43 | 22 | 1 | 1.9 | 3.2 | 11.1 | 3.7 | 3.9 | 4.5 | 5.2 ; 17 | Concrete life outcome | 35 | 4.71% | very strong | pos | 4.94 | 33 | 0 | 5.7 | 6.0 | 2.0 | 4.5 | 5.2 | 7.2 | 3.3 ; 18 | Price fair / worth it | 34 | 4.58% | very strong | pos | 4.91 | 32 | 0 | 9.4 | 4.0 | 3.3 | 3.0 | 6.5 | 6.8 | 3.3 ; 19 | Customisation (colours, icons, templates) praised | 32 | 4.31% | very strong | pos | 4.97 | 31 | 0 | 1.9 | 4.8 | 4.6 | 3.7 | 4.5 | 7.9 | 2.3 ; 20 | Names the developer "Kevin" | 31 | 4.17% | very strong | pos | 4.77 | 27 | 1 | 3.8 | 6.4 | 2.6 | 3.0 | 3.2 | 5.3 | 3.6 ; 21 | Request: widget (or better widget) | 30 | 4.04% | very strong | unmet | 4.33 | 16 | 1 | 1.9 | 3.2 | 11.1 | 1.5 | 1.3 | 4.2 | 4.0 ; 22 | Streak / don't-break-the-chain praised | 27 | 3.63% | very strong | pos | 4.93 | 25 | 0 | 7.5 | 4.0 | 0.0 | 6.0 | 3.2 | 6.4 | 2.1 ; 23 | Price objection | 25 | 3.36% | very strong | neg | 3.16 | 7 | 7 | 1.9 | 4.4 | 2.0 | 5.2 | 1.9 | 2.6 | 3.8 ; 24 | Widgets praised | 24 | 3.23% | very strong | pos | 4.92 | 22 | 0 | 0.0 | 0.4 | 0.0 | 11.2 | 5.2 | 3.4 | 3.1 ; 25 | Reliability (union) | 24 | 3.23% | very strong | neg | 3.75 | 10 | 3 | 7.5 | 2.0 | 1.3 | 6.7 | 2.6 | 3.4 | 3.1 ; 26 | Localisation request | 19 | 2.56% | meaningful | unmet | 4.32 | 9 | 0 | 1.9 | 0.0 | 7.2 | 3.7 | 1.3 | 1.1 | 3.3 ; 27 | Watch / iPad / Mac / web / sync demand (union) | 18 | 2.42% | meaningful | unmet | 4.67 | 12 | 0 | 1.9 | 2.0 | 2.6 | 3.0 | 2.6 | 3.0 | 2.1 ; 28 | Long-term user (≥ 1 year stated) | 17 | 2.29% | meaningful | pos | 5.00 | 17 | 0 | 1.9 | 4.4 | 0.0 | 0.7 | 2.6 | 3.8 | 1.5 ; 29 | Free tier sufficient / "it's free" | 17 | 2.29% | meaningful | pos | 5.00 | 17 | 0 | 0.0 | 2.8 | 3.9 | 0.7 | 1.9 | 3.0 | 1.9 ; 30 | Reminders praised | 16 | 2.15% | meaningful | pos | 4.69 | 12 | 0 | 7.5 | 3.6 | 0.0 | 0.7 | 1.3 | 4.5 | 0.8 ; 31 | One-time / lifetime praised | 15 | 2.02% | meaningful | pos | 4.87 | 13 | 0 | 7.5 | 1.6 | 0.7 | 2.2 | 1.9 | 3.0 | 1.5 ; 32 | Explicit churn / intent to leave | 14 | 1.88% | meaningful | neg | 2.21 | 0 | 5 | 3.8 | 1.6 | 0.0 | 1.5 | 3.9 | 3.4 | 1.0 ; 33 | Request: more statistics / overviews | 14 | 1.88% | meaningful | unmet | 4.64 | 10 | 0 | 5.7 | 1.2 | 1.3 | 1.5 | 2.6 | 2.3 | 1.7 ; 34 | Flexible frequency praised | 13 | 1.75% | meaningful | pos | 4.92 | 12 | 0 | 3.8 | 2.4 | 0.7 | 0.0 | 2.6 | 2.6 | 1.3 ; 35 | Free cap accepted / defended | 12 | 1.62% | meaningful | pos | 4.92 | 11 | 0 | 0.0 | 2.0 | 2.6 | 0.0 | 1.9 | 2.3 | 1.3 ; 36 | Statistics praised | 11 | 1.48% | meaningful | pos | 4.55 | 9 | 1 | 1.9 | 2.4 | 1.3 | 0.7 | 0.6 | 2.6 | 0.8 ; 37 | Notes praised | 11 | 1.48% | meaningful | pos | 4.91 | 10 | 0 | 0.0 | 2.0 | 0.0 | 1.5 | 2.6 | 1.1 | 1.7 ; 38 | Other gated feature / "have to pay" | 11 | 1.48% | meaningful | neg | 1.55 | 0 | 8 | 1.9 | 0.8 | 0.7 | 1.5 | 3.2 | 1.9 | 1.3 ; 39 | Request: quantities / multiple per day | 11 | 1.48% | meaningful | unmet | 4.27 | 4 | 0 | 3.8 | 0.8 | 1.3 | 1.5 | 1.9 | 1.9 | 1.3 ; 40 | Back-filling past dates praised | 10 | 1.35% | meaningful | pos | 4.90 | 9 | 0 | 5.7 | 1.6 | 1.3 | 0.7 | 0.0 | 2.6 | 0.6 ; 41 | An update improved it | 10 | 1.35% | meaningful | pos | 5.00 | 10 | 0 | 5.7 | 2.0 | 0.0 | 1.5 | 0.0 | 1.9 | 1.0 ; 42 | Conditional purchase intent | 10 | 1.35% | meaningful | mixed | 4.40 | 6 | 0 | 0.0 | 2.0 | 0.7 | 2.2 | 0.6 | 1.9 | 1.0 ; 43 | Data & entitlement trust (union) | 10 | 1.35% | meaningful | neg | 2.80 | 2 | 3 | 3.8 | 0.8 | 0.7 | 1.5 | 1.9 | 1.1 | 1.5 ; 44 | Request: notes (missed days, photos, view from calendar) | 9 | 1.21% | meaningful | unmet | 4.44 | 4 | 0 | 3.8 | 0.8 | 2.0 | 0.7 | 0.6 | 1.9 | 0.8 ; 45 | Request: iPad / Mac / web app | 8 | 1.08% | meaningful | unmet | 4.62 | 5 | 0 | 1.9 | 0.4 | 1.3 | 1.5 | 1.3 | 1.1 | 1.0 ; 46 | Replaced paper / bullet journal | 7 | 0.94% | emerging | pos | 4.86 | 6 | 0 | 1.9 | 0.8 | 1.3 | 0.0 | 1.3 | 1.1 | 0.8 ; 47 | Support contact positive | 7 | 0.94% | emerging | pos | 4.57 | 4 | 0 | 0.0 | 1.2 | 2.0 | 0.7 | 0.0 | 1.5 | 0.6 ; 48 | Privacy / on-device data praised | 7 | 0.94% | emerging | pos | 4.29 | 4 | 0 | 3.8 | 1.2 | 0.0 | 0.0 | 1.3 | 1.9 | 0.4 ; 49 | No trial / too short / cannot preview | 7 | 0.94% | emerging | neg | 3.00 | 2 | 2 | 1.9 | 0.8 | 0.0 | 0.7 | 1.9 | 1.5 | 0.6 ; 50 | Request: interactive widget | 7 | 0.94% | emerging | unmet | 4.86 | 6 | 0 | 0.0 | 0.0 | 0.0 | 2.2 | 2.6 | 0.4 | 1.3 ; 51 | Request: scheduling options | 7 | 0.94% | emerging | unmet | 4.43 | 3 | 0 | 5.7 | 0.8 | 0.0 | 1.5 | 0.0 | 1.1 | 0.8 ; 52 | Regression (union: update broke / feature removed) | 7 | 0.94% | emerging | neg | 4.29 | 5 | 1 | 0.0 | 0.8 | 0.7 | 1.5 | 1.3 | 1.1 | 0.8 ; 53 | No ads / no nagging praised | 6 | 0.81% | emerging | pos | 4.83 | 5 | 0 | 1.9 | 0.8 | 0.7 | 0.7 | 0.6 | 1.1 | 0.6 ; 54 | Share cards praised | 6 | 0.81% | emerging | pos | 5.00 | 6 | 0 | 0.0 | 1.2 | 0.7 | 0.0 | 1.3 | 0.8 | 0.8 ; 55 | Confusing / hard to use | 6 | 0.81% | emerging | neg | 1.67 | 0 | 4 | 1.9 | 0.4 | 1.3 | 0.7 | 0.6 | 1.1 | 0.6 ; 56 | Request: Apple Watch | 6 | 0.81% | emerging | unmet | 4.67 | 4 | 0 | 0.0 | 0.8 | 0.7 | 1.5 | 0.6 | 1.1 | 0.6 ; 57 | Request: iCloud / cloud sync | 6 | 0.81% | emerging | unmet | 4.67 | 4 | 0 | 0.0 | 0.8 | 2.0 | 0.0 | 0.6 | 1.1 | 0.6 ; 58 | Request: bad-habit / quit tracking | 6 | 0.81% | emerging | unmet | 4.17 | 2 | 0 | 7.5 | 0.0 | 0.0 | 0.7 | 0.6 | 1.5 | 0.4 ; 59 | Request: easier past-date editing | 6 | 0.81% | emerging | unmet | 4.50 | 3 | 0 | 1.9 | 0.8 | 1.3 | 0.0 | 0.6 | 1.5 | 0.4 ; 60 | An update broke something | 6 | 0.81% | emerging | neg | 4.83 | 5 | 0 | 0.0 | 0.8 | 0.7 | 1.5 | 0.6 | 1.1 | 0.6 ; 61 | Found via Reddit / social / reviews | 6 | 0.81% | emerging | — | 5.00 | 6 | 0 | 3.8 | 0.8 | 1.3 | 0.0 | 0.0 | 1.1 | 0.6 ; 62 | ADHD / ADD self-identified | 5 | 0.67% | emerging | segment | 4.40 | 4 | 0 | 0.0 | 0.4 | 1.3 | 0.0 | 1.3 | 1.1 | 0.4 ; 63 | Free-lifetime promotion mentioned | 5 | 0.67% | emerging | — | 4.20 | 4 | 1 | 0.0 | 0.0 | 2.6 | 0.0 | 0.6 | 0.4 | 0.8 ; 64 | Reminders not firing / broken | 5 | 0.67% | emerging | neg | 3.40 | 2 | 1 | 1.9 | 0.8 | 0.0 | 0.0 | 1.3 | 1.1 | 0.4 ; 65 | Widget broken | 5 | 0.67% | emerging | neg | 3.40 | 1 | 1 | 0.0 | 0.0 | 0.0 | 3.0 | 0.6 | 0.0 | 1.0 ; 66 | Rating contradicts text | 5 | 0.67% | emerging | — | 5.00 | 5 | 0 | 1.9 | 0.8 | 0.0 | 0.7 | 0.6 | 1.1 | 0.4 ; 67 | Request: skip / pause / incomplete | 5 | 0.67% | emerging | unmet | 4.40 | 2 | 0 | 3.8 | 0.4 | 0.0 | 1.5 | 0.0 | 0.8 | 0.6 ; 68 | Request: badges / celebration / sounds | 5 | 0.67% | emerging | unmet | 4.80 | 4 | 0 | 1.9 | 1.2 | 0.0 | 0.0 | 0.6 | 1.1 | 0.4 ; 69 | Objection to subscriptions as a model | 4 | 0.54% | emerging | neg | 3.25 | 2 | 1 | 0.0 | 0.4 | 0.7 | 0.7 | 0.6 | 0.0 | 0.8 ; 70 | Upgrade nagging / promo pop-ups | 4 | 0.54% | emerging | neg | 2.00 | 0 | 1 | 1.9 | 0.8 | 0.0 | 0.0 | 0.6 | 0.8 | 0.4 ; 71 | Cannot afford | 4 | 0.54% | emerging | neg | 4.00 | 2 | 0 | 0.0 | 0.4 | 0.7 | 0.7 | 0.6 | 1.1 | 0.2 ; 72 | Data / history lost | 4 | 0.54% | emerging | neg | 3.50 | 2 | 1 | 1.9 | 0.8 | 0.7 | 0.0 | 0.0 | 1.1 | 0.2 ; 73 | Alternate app icon cannot be changed | 4 | 0.54% | emerging | neg | 4.00 | 1 | 0 | 1.9 | 0.4 | 1.3 | 0.0 | 0.0 | 0.4 | 0.6 ; 74 | Gibberish / off-topic | 4 | 0.54% | emerging | — | 4.00 | 3 | 1 |  |  |  |  |  |  | ; — | Weak (n = 1–3, 0.13–0.40%): limit not disclosed (3, mean 2.33); no sync caused a problem (3); crash (3); other bug (3); review prompt (3); too basic (3, mean 1.67); student/child (3); haptics (3); themes request (3); export/Shortcuts request (3); neutral (3); lifetime removed/not honoured (2, mean 2.50); data lock-in (2, mean 1.00); complete-from-notification request (2); reminder improvements (2); Health request (2); categories (2); medical/recovery use (2); entitlement lost (1); refund (1); feature removed (1); promo failed (1); discount (1); renewal (1); fixed (1); low contrast (1); support unresponsive (1); friends sharing (1); religious use (1) | ≤3 each | ≤0.40% | weak |  |  |  |  |  |  |  |  |  |  |
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-084 — Generic-only reviews (no specific theme) 71 (9.56%), mean 4.82 — rise from 1.9% of E1 to ~11% of E3–E4

- **Where:** §3.1 theme table #10 Generic only
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 71 (9.56%), mean 4.82
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-104 — Free-lifetime promotion mentioned 5 (0.67%, mean 4.20), 2.6% of E3

- **Where:** §3.1 theme table #63 Free-lifetime promotion mentioned
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 5 (0.67%), mean 4.20
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-109 — Gibberish / off-topic 4 (0.54%, mean 4.00)

- **Where:** §3.1 theme table #74 Gibberish / off-topic
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 4 (0.54%)
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-110 — Weak rows (n = 1–3, 0.13–0.40%): limit not disclosed 3 (mean 2.33); no sync caused a problem 3; crash 3; other bug 3; review prompt 3; too basic 3 (mean 1.67); student/child 3; haptics 3; themes request 3; export/Shortcuts request 3; neutral 3; lifetime removed/not honoured 2 (2.50); data lock-in 2 (1.00); complete-from-notification 2; reminder improvements 2; Health 2; categories 2; medical/recovery use 2; entitlement lost 1; refund 1; feature removed 1; promo failed 1; discount 1; renewal 1; fixed 1; low contrast 1; support unresponsive 1; friends sharing 1; religious use 1

- **Where:** §3.1 theme table weak rows (n = 1–3) — limit not disclosed 3 (2.33); no sync caused a problem 3; crash 3; other bug 3; review prompt 3; too basic 3 (1.67); student/child 3; haptics 3; themes request 3; export/Shortcuts request 3; neutral 3; lifetime removed/not honoured 2 (2.50); data lock-in 2 (1.00); complete-from-notification 2; reminder improvements 2; Health 2; categories 2; medical/recovery use 2; entitlement lost 1; refund 1; feature removed 1; promo failed 1; discount 1; renewal 1; fixed 1; low contrast 1; support unresponsive 1; friends sharing 1; religious use 1
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** ≤3 each, ≤0.40%
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-111 — Positive themes restricted to 4–5★: simplicity 273 (36.74%) · design 156 (21.00%) · 'best' 107 (14.40%) · year grid / calendar 104 (14.00%) · competitor comparison 95 (12.79%) · utility 95 (12.79%) · developer 52 (7.00%) · motivation 46 (6.19%) · life outcome 35 (4.71%) · price fair 33 (4.44%) · customisation 32 (4.31%) · streak 27 (3.63%) · widgets 24 (3.23%)

- **Where:** §3.1 Positive themes restricted to reviews rated 4–5★ — simplicity 273 (36.74%) · design 156 (21.00%) · 'best' 107 (14.40%) · year grid / calendar 104 (14.00%) · competitor comparison 95 (12.79%) · utility 95 (12.79%) · developer 52 (7.00%) · motivation 46 (6.19%) · life outcome 35 (4.71%) · price fair 33 (4.44%) · customisation 32 (4.31%) · streak 27 (3.63%) · widgets 24 (3.23%)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** as stated
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-113 — Themes with n ≥ 3 ranked by mean rating, with % 1★ and why it matters

- **Where:** §3.2 The findings with the worst rating profile (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | Mean | % 1★ | Why it matters ; Data lock-in (export disabled, backup gated) | 2 | 1.00 | 100% | Users feel trapped; "forced to keep paying … if you don't want to lose all your history" (13731751322) ; Other gated feature ("have to pay") | 11 | 1.55 | 72.7% | Widgets, notes and colours behind the paywall read as "pay to use it" (12760639157, 13605658579, 10828741313 "Horrível tem que pagar" *"Horrible, you have to pay"*) ; Confusing / hard to use | 6 | 1.67 | 66.7% | Onboarding promos and hidden gestures (13288687749, 10732085902); low contrast in dark mode (10630623535) ; Too basic | 3 | 1.67 | 66.7% | "such a basic system that i can so easily replicate on my agenda" (6028222005) ; Upgrade nagging | 4 | 2.00 | 25.0% | Hurts users who never need Premium (7879946381) ; Explicit churn | 14 | 2.21 | 35.7% | The review is the exit interview ; Limit not disclosed | 3 | 2.33 | 33.3% | The first negative experience is a surprise wall ; Free-tier cap | 39 | 2.44 | 38.5% | The *volume* complaint (5.25%) ; Monetisation friction (union) | 78 | 2.68 | 35.9% | 75.7% of all 1★ ; Data & entitlement trust (union) | 10 | 2.80 | 30.0% | ; No trial | 7 | 3.00 | 28.6% | ; Price objection | 25 | 3.16 | 28.0% | Milder: many "great app, too expensive" 4–5★ ; Reminders broken / widget broken | 5 / 5 | 3.40 | 20.0% | ; Reliability (union) | 24 | 3.75 | 12.5% | Mildest negative: bugs are reported politely, often at 4–5★
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `13731751322`, `12760639157`, `13605658579`, `10828741313`, `13288687749`, `10732085902`, `10630623535`, `6028222005`, `7879946381`
- **Canonical:** — (nuance register)

### R34-124 — Strengths with 4–5★ counts and evidence

- **Where:** §3.4 What the product genuinely does well (verbatim table)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Strength | n (4–5★) | Evidence ; Simple, uncluttered, fast to log | 273 | 5483779509 ("only takes one touch"), 6713570145 ("no busy visuals, no hokey games"), 11286612018 ("Forget cutesy interfaces, overuse of emojis"), 11257213711 ("Some other apps have too many bells and whistles and I get decision fatigue") ; Calm, native-feeling design | 156 | 9459813565 ("Feels like it was made by Apple"), 11298677390 ("Native iOS gem"), 10327221465 ("The whole app just feels calm and clear") ; The year grid / calendar — the differentiator | 104 | 6886056651 ("'Don't Break The Chain' only makes sense if you can actually see your chain!"), 9580051830 ("Much more useful than only knowing your longest streak"), 11682869403 ("see my daily efforts as a part of the big picture of my life"), 14284351778 ("You can spot patterns you didn't realize existed") ; "Best / the one I kept" | 107 | 10184986574, 11286612018 ("the only app that I've actually stuck with"), 13649480321 ; Life outcomes | 35 | 4310058011 (diabetic, "finally got under 200 pounds"), 5975293048 ("26 days off sugar"), 9265906731 ("helped me quit smoking"), 12239759021 (25-day water streak), 13649480321 (songwriting, 5-week streak), 6920747202 (London lockdowns) ; The developer | 52 | 3954949955, 6393157189, 8400091910, 13882752696 ; Customisation | 32 | 5732133041 (emoji in titles), 10801319167 (hex colour), 10312865254 (colour by group) ; Neurodivergent users | 5 | "apps designed specifically for ADHD … too detailed … This app is simple with just the right amount of detail" (10858613272); "MUST. FILL. BOXES." (13882752696); 7196952603, 10335392591 ; Replacing paper | 7 | "I was drawing habit tables by hand" (12239759021); 4462219747, 10894243423, 13656531210
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-129 — Requests where the capability did not exist for that reviewer

- **Where:** §3.5 Unmet needs table (verbatim) — requests 113 (15.21%, mean 4.48; 54.5% of all 4★)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Need | n | Evidence ; Home-screen widget (pre-March 2024) or better widget | 30 | 6576140378, 10552434405, 10611037724 (streak widget with the fire icon), 10637884382 ; Interactive widget (tick from the widget) | 7 | 11412519740, 12450993343, 13731564617, 14516919955 ; More statistics / overviews (month %, all habits in one grid, counts) | 14 | 3944773451, 8746143988 ("percentage by month"), 10760628732, 12464367645, 12471035847 ; Quantities / multiple completions per day / partial amounts | 11 | 3233116539 (push-ups), 10088647035 (5 bottles of water), 12270557790 ("twice a day"), 13432208041 ("I Drank 80oz … I wanna be able to track that") ; Notes on missed days, photos, view a note from the calendar | 9 | 10965345926, 11400095925, 13583853777 (a "No Spend" habit), 9082639448, 10569299689 ; iPad / Mac / web app | 8 | 3307938448 (2018), 10581767784 ("I'd even pay for separate versions as long as they synced"), 11077980453, 12188850466 ; Scheduling (every other day, monthly targets) | 7 | 3232869436, 8674756630, 11802277055 ; Apple Watch | 6 | 7044468569, 11310906473, 12106386358, 13081471282 ; iCloud / cloud sync | 6 | 6729639375, 7344582690 (lost data after a factory reset), 10187448442, 12427980996 ; Bad-habit / quit tracking | 6 | 4122355171 ("I'd rather not see 'TO DO' next to bad habits"), 11475674157, 13827396231 ; Easier past-date editing / day start after midnight | 6 | 9082639448 ("My day *always* ends after midnight"), 13559189439 (edit from the calendar view) ; Skip / pause / "incomplete" | 5 | 11872013641 ("i am sick and cannot swim … i dont want to loose my results"), 11811674754 ; Badges, celebration, sounds | 5 | 13081471282 (a "celebration" when all habits are done), 10033720467 ; Localisation | 19 | Part 4.5
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `6576140378`, `10552434405`, `10611037724`, `10637884382`, `11412519740`, `12450993343`, `13731564617`, `14516919955`, `3944773451`, `8746143988`, `10760628732`, `12464367645`, `12471035847`, `3233116539`, `10088647035`, `12270557790`, `13432208041`, `10965345926`, `11400095925`, `13583853777`, `9082639448`, `10569299689`, `3307938448`, `10581767784`, `11077980453`, `12188850466`, `3232869436`, `8674756630`, `11802277055`, `7044468569`, `11310906473`, `12106386358`, `13081471282`, `6729639375`, `7344582690`, `10187448442`, `12427980996`, `4122355171`, `11475674157`, `13827396231`, `13559189439`, `11872013641`, `11811674754`, `10033720467`
- **Canonical:** — (nuance register)

### R34-135 — Symptoms of the 2-habit wall with evidence

- **Where:** §4.1 Cluster 1 — The 2-habit wall (verbatim symptom table)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Symptom | Evidence ; The wall arrives at habit #3, during setup | 3850157156 ("I added 2, tried to add the third and was prompted to pay"), 11348148556 ("Waits until I made two habits to tell me") ; The cap is stricter than peers | 10904298957 ("Other apps usually have 5 free habits"), 12108620259, 12154681308 ("at least five don't skimp out like that"), 9342516160 ("no 8-10 habits for free") ; Some reviewers ask for just one more | 5964636301, 10829968552 ("Maybe you could change the maximal Habits to 3"), 11114378387, 11540693274, 10668865820 ("3-4 habits") ; The wall now includes features, not only habits | 12760639157 (widgets), 12738794859 ("Premium is the only usable form — widgets and more than 2 habits are essential"), 13629525960 (colours) ; 2026: reported as 4 free habits | 13597043858, 14316571521 ("limited. :: 4 habits in free account", still 1★)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `3850157156`, `11348148556`, `10904298957`, `12108620259`, `12154681308`, `9342516160`, `5964636301`, `10829968552`, `11114378387`, `11540693274`, `10668865820`, `12760639157`, `12738794859`, `13629525960`, `13597043858`, `14316571521`
- **Canonical:** — (nuance register)

### R34-153 — 5★ band (591): core praise 77.7%, simplicity 43.7%, design 24.0%, best 17.4%, year grid 16.8%, utility 15.7%, competitor 15.1%, generic 11.0%, request 10.8%, developer 8.5%, payer 7.1%, outcome 5.6%; sub-populations — short affective reviews incl. most of the June 2023 burst; comparison verdicts; outcome stories; 64 requests at 5★ ('Almost Perfect … if you could add … that would make your app perfect'); 5 complaints at 5★

- **Where:** §5.1 5★ table (verbatim) and sub-populations — short affective, comparison verdicts, outcome stories, requests filed at 5★ (64), complaints filed at 5★ (5, MISRATE)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of 5★ ; Core praise (union) | 459 | 77.7% ; Simplicity | 258 | 43.7% ; Design | 142 | 24.0% ; "Best" | 103 | 17.4% ; Year grid / calendar | 99 | 16.8% ; Utility | 93 | 15.7% ; Competitor comparison | 89 | 15.1% ; Generic only | 65 | 11.0% ; Any request (unmet) | 64 | 10.8% ; Developer | 50 | 8.5% ; Explicit payer | 42 | 7.1% ; Life outcome | 33 | 5.6%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `10184986574`, `13649480321`, `14284351778`, `4310058011`, `5975293048`, `9265906731`, `3580101644`, `4289434524`, `9342516160`, `11145404810`, `13744408241`, `5475283125`
- **Canonical:** — (nuance register)

### R34-158 — Cross-band reading: free cap 10 / 9 / 20 (mostly hostile, a quarter from 4–5★); price objection 13 / 3 / 9 (many 'great app, too expensive' 4–5★); widget demand 33 / 3 / 1 (a wish, not a grievance); localisation 17 / 1 / 1 (a wish); reliability 15 / 5 / 4 (forgiven); explicit payer 46 / 2 / 3 (happy); competitor named 95 / 1 / 2 (arrivals)

- **Where:** §5.6 Themes that cut across the rating line (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 5★+4★ | 3★ | 2★+1★ | Reading ; Free cap | 10 | 9 | 20 | Mostly hostile; a quarter comes from people rating 4–5★ ; Price objection | 13 | 3 | 9 | Many "great app, too expensive" 4–5★ (9453178276, 11097867630) ; Widget demand | 33 | 3 | 1 | A wish, not a grievance ; Localisation | 17 | 1 | 1 | A wish, not a grievance ; Reliability | 15 | 5 | 4 | Forgiven ; Explicit payer | 46 | 2 | 3 | Payers are happy ; Competitor named | 95 | 1 | 2 | Overwhelmingly arrivals
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `9453178276`, `11097867630`
- **Canonical:** — (nuance register)

### R34-160 — Payer framing: explicit payers (first-person, any language) 51 (6.86%, mean 4.63), of which 7 (0.94%) praise a one-time / lifetime option; conditional intent 10 (1.35%, mean 4.40); global 743 (4.58); no conversion rate is claimed or claimable from review text

- **Where:** §6.1 Framing this correctly (verbatim table) — explicit payers 51 (6.86%, mean 4.63); one-time / lifetime mention 7; conditional intent 10 (4.40); no conversion rate claimed
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Group | Definition | n | % of corpus | Mean ; Explicit payers | First-person "I paid / bought / purchased / upgraded / subscribed", "premium member", "lifetime", in any language | 51 | 6.86% | 4.63 ; …of which mention a one-time / lifetime purchase | Payer review praising a one-time or lifetime option | 7 | 0.94% | — ; Conditional intent | "Would buy if…" (not payers) | 10 | 1.35% | 4.40 ; Global | All reviews | 743 | 100% | 4.58
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-164 — Purchase triggers with evidence

- **Where:** §6.3 What made people buy (verbatim table)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Trigger | Evidence ; The two free habits proved the method; they needed more | 9655320510 ("Having started with the two free grids I have today purchased the reasonably priced annual subscription"), 13242549122, 13044612377 ("I'm so happy with it I went ahead and bought the full version"), 13597043858, 10791117607 ("After playing with the Free version (2 habits only) I knew … Bought the Lifetime and I was only 12 hrs into this") ; A one-time / lifetime option instead of rent | 5293501237 ("I was able to go pro by paying once instead of a subscription"), 11286612018 ("it's lifetime access, instead of a subscription which was what I was looking for"), 11583264179 ("odio las suscripciones así que pagué la versión lifetime … a modo de inversión" *"I hate subscriptions so I paid for lifetime … as an investment"*), 3503457494 ; Supporting a solo developer | 4462219747 ("helps support an independent developer"), 4497735688, 11737212105 ("I paid the app to support solo developer"), 13919822858, 10854224657 ; Extras: dark mode, colours, notes, import | 4462219747, 4497735688, 8181313423, 13919822858 ("the visually appealing extras, such as customizable colors") ; Design and aesthetics | 13093527963 ("a estética … fez total diferença para que eu estivesse disposta a pagar" *"aesthetics … made all the difference in my being willing to pay"*), 3503457494 ; A discount | 13560914935 ("I took advantage of a 50% reduction offer, so I paid £9.99 for a whole year - bargain!") ; Long-term use, then renewal | 6884995801 ("my one year anniversary of purchasing this app and I purchased another year again without hesitation"), 8181313423 (a year of use, then lifetime)
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** app-specific
- **Review IDs:** `9655320510`, `13242549122`, `13044612377`, `13597043858`, `10791117607`, `5293501237`, `11286612018`, `11583264179`, `3503457494`, `4462219747`, `4497735688`, `11737212105`, `13919822858`, `10854224657`, `8181313423`, `13093527963`, `13560914935`, `6884995801`
- **Canonical:** — (nuance register)

### R34-176 — Country scope: only the US clears the 50-review threshold (265 of 743, 35.7%); next gb 34, ca 33, in 32, de 26; all 478 non-US reviews (75 storefronts) used as one comparison group, no standalone conclusions for other storefronts; high-spend and high-review-volume market groups not produced at the owner's request (the latter would be the US alone)

- **Where:** §7.1 Eligibility and scope — only the US clears 50 (265, 35.7%); the only country section is the US per the owner; high-spend and high-review-volume market groups not produced at the owner's request
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** US 265 (35.7%); non-US 478 / 75 storefronts
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R34-188 — Trend method: five eras defined from product events, rates as % of era; year figures where an event is narrower; 2026 (n = 39) flagged small; the June 2023 burst isolated where it distorts E3; no trend claimed from a single month or from fewer than 5 reviews

- **Where:** §8.1 Method — five eras from product events; year figures where narrower; 2026 (n=39) small; June 2023 burst isolated where it distorts E3; no trend from a single month or < 5 reviews
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R34-197 — Non-claims: no AI trend — no review in the corpus mentions AI, ChatGPT or an AI feature; no ADHD trend — five reviews over eight years, all positive or mixed; no effect of the 4-habit free tier (two reviews); no monthly trend within E5 (small n); no conversion, retention or churn rate — the review is not a funnel

- **Where:** §8.9 Trends explicitly NOT claimed — no AI trend (no review mentions AI, ChatGPT or an AI feature); no ADHD trend (five reviews over eight years); no effect of the 4-habit free tier (two reviews); no monthly trend within E5; no conversion, retention or churn rate
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** AI 0; ADHD 5; 4-habit 2
- **Direction for us:** none · **Report confidence:** explicit non-claims · **Generalisable:** yes
- **Review IDs:** `7196952603`, `10335392591`, `10858613272`, `12221998930`, `13882752696`
- **Canonical:** — (nuance register)

### R34-227 — Research question: what is the free tier today, by storefront and cohort (2 or 4 habits)? Are widgets free?

- **Where:** Part 10 #22 (§10.5)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13597043858`, `14316571521`, `12760639157`, `13467704260`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free

### R34-228 — Research question: is lifetime still sold, and are older lifetime licences recognised after updates?

- **Where:** Part 10 #23 (§10.5)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13392990758`, `14138883204`
- **Canonical:** C186 Never revoke what earlier buyers paid for when the model changes

### R34-229 — Research question: why was CSV export disabled, and for whom?

- **Where:** Part 10 #24 (§10.5)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13731751322`
- **Canonical:** C020 Data export / backup / CSV

### R34-230 — Research question: did a free-lifetime promotion run on ~29 June 2023, and did it deliver? (one reviewer says it did not)

- **Where:** Part 10 #25 (§10.5)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `10087293260`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised

### R34-231 — Research question: what share of new users hit the 2-habit wall in their first session, and how many convert vs uninstall?

- **Where:** Part 10 #26 (§10.5)
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it
