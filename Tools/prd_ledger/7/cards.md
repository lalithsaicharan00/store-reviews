# Cards — report 7

Source: `App Store Reports/7. Habit Tracker - HabitKit - Streaks & Accountability (REPORT).md`  
145 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 3
- [Must-haves](#must-haves) — 5
- [Must never break](#must-never-break) — 10
- [Features](#features) — 27
- [Monetization](#monetization) — 13
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 18
- [Audiences](#audiences) — 6
- [Markets and languages](#markets-and-languages) — 14
- [Dated events and trends](#dated-events-and-trends) — 8
- [Positioning](#positioning) — 4
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 2
- [Things to do](#things-to-do) — 4
- [Contradictions](#contradictions) — 4
- [Data caveats and method](#data-caveats-and-method) — 24

## Product rules

### R07-010 — Users argue a widget is an OS feature you should not charge for — 'something that's built into the operating system'; 'isn't the no widgets without subscription thing a bit overkill?'; 'I'm all for pro features being add-ons but the widget?!' — the objection is to the category of thing gated, not the price

- **Where:** Part 0 §3 The argument reviewers actually make
- **This app does:** widgets Pro-only
- **User reaction:** 1★-burst
- **Magnitude:** 13 objections, 0 at 5★
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10771302089`, `12781411049`, `13905806444`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R07-051 — Do not solve the conversion problem by adding upsell pressure — this corpus explicitly rewards its absence: 'I personally hate when developers force users into buying a subscription… by nagging with constant ads… Habitkit is one of the rare gems among many slop apps'; 'no te bloquea todo ni te insiste en hacer el upgrade'; the few complaints ('wayyyy too many ads of premium', 'Annoying popups' Aug 2026) are the exception

- **Where:** §1.6 Upsell pressure is small — and that's an asset; Part 4 #19; Part 9 #10
- **This app does:** light upsell
- **User reaction:** praise
- **Magnitude:** Upsell nagging 8 (0.91%), mean 3.25, 37.5% 1–2★; 0 of 8 are payers
- **Direction for us:** product-rule · **Report confidence:** defended position · **Generalisable:** yes
- **Review IDs:** `13206904375`, `11714676984`, `14088197028`, `12253135804`, `14488967268`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R07-119 — Protect the simplicity: every new mode (sub-habits, integrations, AI) should be invisible by default and opt-in — reviewers said this in advance, repeatedly and unprompted

- **Where:** Part 9 #16 Protect the simplicity. Ship complexity behind opt-in.
- **This app does:** features shipped visible by default
- **User reaction:** complaint
- **Magnitude:** simplicity praise −12 points
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-118
- **Review IDs:** `13860278748`
- **Canonical:** C006 Stay minimal and ad-free

## Must-haves

### R07-020 — Put a support address in the app, visibly: the two reviewers who could not reach the (famously responsive) developer produced two 1★s — 'I can't find any way to contact customer support'; 'The developer also doesn't respond to emails, so there's no way to get support' — both paying, both 2026; a discoverability fix, not a staffing one

- **Where:** Part 0 §6 The counter-case is small but real and recent; Part 9 #2
- **This app does:** support not findable in-app
- **User reaction:** 1★-burst
- **Magnitude:** 2 (0.23%, Weak), both 1★, both payers, both 2026
- **Direction for us:** must-have · **Report confidence:** weak, high cost · **Generalisable:** yes
- **Review IDs:** `13952801052`, `14351190258`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R07-080 — Setup / UI confusion is a sharp minority complaint — including a gear icon that opens the Export menu instead of Settings ('Zahnrad öffnet nicht die Einstellungen, sondern das Export-Menu')

- **Where:** Part 4 #14 Setup / UI confusing; §4.2 gear icon opens Export
- **This app does:** gear icon → Export
- **User reaction:** 1★-burst
- **Magnitude:** 13 (1.47%, MEANINGFUL), mean 2.92, 46.2% 1–2★; 1★ confusing 3 (7.3%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13736974190`, `13213024086`
- **Canonical:** C075 Skippable, replayable onboarding tour

### R07-088 — Make the existing weekly/monthly goal modes discoverable: the app HAS 'X per week / X per month' goals and rest days, but changelog 1.11 moved frequency behind 'Advanced Options' — so users rate it as missing: a 3★ offered to raise his rating if corrected ('If incorrect advise me how and will adjust review') and nobody took it; a payer 'didn't realize until subscribing to pro… that it is only set up for daily habits'; a FR 2★ says it puts the app behind competitors — the highest ratio of rating gain to engineering cost in the report

- **Where:** §4.2 The frequency model is the most-misunderstood part of the product; Part 4 #7; Part 6 #6; §8.4; Part 9 #12
- **This app does:** feature exists, hidden in Advanced Options
- **User reaction:** complaint
- **Magnitude:** Wants weekly / flexible / skip-day goals 17 (1.93%, MEANINGFUL), mean 4.12, 5.9% 1–2★; 8.4% of 4★; span 3y (10266075296 16 Aug 2023 → 14489689059 30 Aug 2026)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10266075296`, `11800436326`, `13187090517`, `14489689059`, `13736974190`
- **Canonical:** C142 Surface existing features where users look; C043 Flexible / custom frequency

### R07-122 — Put a support address in the app, visibly — the two reviewers who could not reach the developer produced two 1★s; discoverability, not staffing

- **Where:** Part 9 #2 Put a support address in the app, visibly (Immediate)
- **This app does:** support not visible in-app
- **User reaction:** 1★-burst
- **Magnitude:** 2 × 1★; developer praise 133 at 93.2% 5★
- **Direction for us:** must-have · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R07-020
- **Review IDs:** `14351190258`, `13952801052`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R07-132 — Surface frequency in habit creation rather than behind 'Advanced Options' — the highest rating-gain to engineering-cost ratio in the report

- **Where:** Part 9 #12 Make the existing weekly/monthly goal modes discoverable
- **This app does:** hidden since changelog 1.11
- **User reaction:** complaint
- **Magnitude:** 17 reviews incl. a payer and a 3★ offering to re-rate
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-088
- **Review IDs:** `10266075296`, `11800436326`
- **Canonical:** C142 Surface existing features where users look; C043 Flexible / custom frequency

## Must never break

### R07-012 — Eight paying customers' Pro entitlement did not unlock — a 100% segment rate (every one is in the paid cohort); stable across 15 months and four platforms (widget, restore, macOS carry-over), the newest instance is the most recent review in the whole corpus (6 Sep 2026); two rated 5★ while reporting it — an open receipt-validation / widget-timeline bug; fix, then proactively email the eight

- **Where:** Part 0 §4 (Eight people paid and did not get the product — this is the highest-severity finding); Part 4 #20; §8.3; Part 9 #1
- **This app does:** Pro purchased, widgets still show 'Upgrade to HabitKit Pro' / restore fails / Pro does not carry to Mac
- **User reaction:** 1★-burst
- **Magnitude:** 8 (0.91%, EMERGING), mean 2.25, 75% 1–2★, 100% of them payers; 0.00% (P1) 0.00% (P2) 1.62% (P3) 1.52% (P4) — emerged 2025, still open Sep 2026
- **Direction for us:** must-never-break · **Report confidence:** highest severity · **Generalisable:** yes
- **Review IDs:** `12836329335`, `13105035694`, `13398478371`, `13430341774`, `13693601586`, `14351190258`, `14519062888`, `12450937418`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R07-018 — The tail of the no-sync gap is data loss: users lost their history on reinstall, on a new phone (one switched to Tiimo), by accidental delete, and by historical entries silently vanishing

- **Where:** Part 0 §5 The tail of this gap is data loss; Part 4 #26
- **This app does:** local-only storage, no backup by default
- **User reaction:** churn
- **Magnitude:** 5 (0.57%), mean 2.20, 60.0% 1–2★
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10001495366`, `12211144791`, `13499288017`, `14016661342`, `13952801052`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R07-033 — Paying reviewers rate 0.44 stars lower and are 3× more likely to leave 1–2★ — the central monetization fact in this corpus; the share of reviewers who declare a purchase rose every year, so the buyer base is growing and increasingly vocal

- **Where:** §1.2 Paying reviewers rate 0.44 stars lower and are 3× more likely to leave 1–2★
- **This app does:** paid cohort 75
- **User reaction:** complaint
- **Magnitude:** paid 4.16 vs rest 4.60; 5★ 64.0% vs 79.8%; 1–2★ 17.3% vs 5.8%; declared payers 2.11% → 7.26% → 9.74% → 12.63%
- **Direction for us:** must-never-break · **Report confidence:** segment rate (n = 75) · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R07-047 — Subscription → lifetime is not possible in-app: two 5★ customers in the same week (11 Jul 2026) tried to switch and could not — 'I wanna buy the lifetime subscription but I can't find it anywhere, it only shows month or yearly'; [external] the FAQ says this is by design: cancel the subscription, let it expire, then buy lifetime

- **Where:** §1.4 Barrier 3 — a willing buyer literally could not give the developer money; Part 9 #7
- **This app does:** no in-app cross-grade from subscription to lifetime
- **User reaction:** blocked-conversion
- **Magnitude:** 2 (5★, US + ES), same week; [limited evidence] but mechanism documented
- **Direction for us:** must-never-break · **Report confidence:** limited evidence, documented · **Generalisable:** yes
- **Conditions:** contrast report 6, where the lifetime purchase did not cancel the running subscription and double-billed
- **Review IDs:** `14288167581`, `14289596763`
- **Canonical:** C077 Purchase and signup flow must not leak buyers; C003 Lead with a one-time lifetime purchase

### R07-079 — Bugs are reported rarely but at a steep rating cost, and payers are the ones who hit and report them; bug reports are 2.5× more common outside high-spend markets

- **Where:** Part 4 #9 Bugs reported; §7.2 bugs
- **This app does:** mostly stable
- **User reaction:** 1★-burst
- **Magnitude:** 16 (1.81%, MEANINGFUL), mean 2.75, 50.0% 1–2★; 7 of 16 payers (43.8%); high-spend 1.1% vs rest 2.8%
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C031 Crashes / launch failures

### R07-089 — Streak maths for non-daily goals is not trusted: 'I'm on a 12 week streak for a habit I started 8 weeks ago'; 'The numeric streak count for weekly goals is strange, so I don't use it'; 'The streak is not a true streak'; one resolved only because the developer explained it personally — a wrong number in a trust-based app is worse than no number; audit it

- **Where:** §4.2 streak maths for non-daily goals is not trusted; Part 4 #27; Part 9 #4
- **This app does:** weekly-goal streak count wrong / opaque
- **User reaction:** complaint
- **Magnitude:** Streak maths confusing 4 (0.45%, Weak), mean 4.00
- **Direction for us:** must-never-break · **Report confidence:** weak, trust-critical · **Generalisable:** yes
- **Review IDs:** `13578452293`, `13856682531`, `12189061392`, `11317982485`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

### R07-092 — Notifications are a small, sharp problem with opposite failures: reminders silently went quiet ([external] changelog 1.16.1: 'reminders could go quiet for the rest of the week, depending on the day you last opened the app'), fired at the wrong time — and one 1★ says 'This app doesn't have notifications' when it does, a discovery failure inside onboarding

- **Where:** §4.4 Notifications: a small, sharp, six-review problem; Part 4 #23
- **This app does:** reminders regressed then fixed in 1.16.1
- **User reaction:** 1★-burst
- **Magnitude:** 6 (0.68%, EMERGING), mean 2.67, 50.0% 1–2★
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12837659567`, `10334933288`, `14470755939`
- **Canonical:** C039 Reminders fire reliably, once; C142 Surface existing features where users look

### R07-121 — Fix the Pro entitlement / widget-unlock failure — highest severity: cache entitlement locally, render the widget optimistically from the last-known-good receipt instead of blocking on a live server call, then proactively email the eight reviewers

- **Where:** Part 9 #1 Fix the Pro entitlement / widget-unlock failure (Immediate)
- **This app does:** widget blocks on network entitlement check
- **User reaction:** 1★-burst
- **Magnitude:** 8 reviews, mean 2.25, 100% payers, 15 months unresolved; newest 6 Sep 2026
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R07-012, R07-014
- **Review IDs:** `14519062888`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C139 Cache entitlements locally — never block a paid surface on a live server check

### R07-123 — Investigate the Aug 2026 compact-list redesign and ship a text-size / density option or an opt-out

- **Where:** Part 9 #3 Investigate the Aug 2026 compact-list redesign (Immediate)
- **This app does:** redesign shipped without a density option
- **User reaction:** 1★-burst
- **Magnitude:** 5 reviews in 12 days, mean 2.43, three from payers, one 'going to hunt for an alternative app'
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R07-024
- **Review IDs:** `14452046441`, `14447636722`
- **Canonical:** C119 Updates must not regress layout or lose progress

### R07-124 — Audit the streak count for 'X per week/month' habits — a wrong number in a trust-based app is worse than no number

- **Where:** Part 9 #4 Audit the streak count for 'X per week/month' habits (Immediate)
- **This app does:** 12-week streak on an 8-week-old habit
- **User reaction:** complaint
- **Magnitude:** 1 wrong count + 2 who stopped using the streak number
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R07-089
- **Review IDs:** `13578452293`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

## Features

### R07-009 — Putting home-screen widgets behind the paywall costs more rating than it earns revenue: 13 reviews object to Pro-gated widgets at mean 2.23 with not one 5★ — the only theme in the corpus with a zero 5★ rate — against 8 who name the widget as the thing that made them buy; widgets are simultaneously the best-loved feature and the most resented paywall

- **Where:** Part 0 §3 (Putting home-screen widgets behind the paywall costs more rating than it earns revenue); Part 4 #12; §8.4
- **This app does:** all home-screen widgets Pro
- **User reaction:** complaint
- **Magnitude:** objection 13 (1.47%, MEANINGFUL), mean 2.23, 53.8% 1–2★, 0% 5★; purchase trigger 8 (0.91%), mean 4.88; widget praise 84 (9.52%), mean 4.69; span 2y 5m (10771302089 1 Jan 2024 → 14093446153 22 May 2026)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10771302089`, `12781411049`, `13905806444`, `13575345887`, `12622891075`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R07-016 — No cross-device / iCloud sync is the biggest product gap: the #1 theme in the recoverable 3★/4★ band, persistent for three years, and a conversion blocker with named willingness to pay — 'If you could sync it across multiple devices I would totally be willing to buy the lifetime pass'; 'I probably wouldn't have subscribed if I had noticed this sooner'; 'for a Pro plan, it should include sync'

- **Where:** Part 0 §5 (No cross-device sync is the biggest *product* gap, and it is 2½ years old and unfixed); Part 4 #1; Part 6 #1; §8.4; Part 9 #11
- **This app does:** absent (local-only); FAQ: 'currently in development'
- **User reaction:** blocked-conversion
- **Magnitude:** 54 (6.12%, HIGH-PRIORITY), mean 3.85, 33.3% 5★, 13.0% 1–2★; 18.9% of 4★, 31.4% of 3★; 0.70% (P1) → 7.26% → 7.14% → 7.07%; span 3y 4m (9806367856 10 Apr 2023 → 14378210199 2 Aug 2026); US 9.0%, DE 7.5%, GB 3.4%, CA 5.4%
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** also eliminates the data-loss cluster and the 'changed phones, lost everything' churn
- **Conditions:** must ship opt-in, end-to-end, CloudKit private database to keep the privacy promise (7 praise local-only storage)
- **Review IDs:** `12386725682`, `13473841112`, `13833569208`, `12139974588`, `9806367856`, `14378210199`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator

### R07-028 — Charts & statistics are Pro and praised where used — and are one of the two paid features users most want to preview before buying ('I wish I could see how the charts are before purchasing')

- **Where:** §1.1 Charts & statistics Pro; Part 3 #10; §7.3
- **This app does:** Pro
- **User reaction:** praise
- **Magnitude:** Charts & statistics praise 41 (4.65%, VERY STRONG), mean 4.59, 78.0% 5★; top-10 volume storefronts 5.8% vs long tail 1.9%
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12183236954`, `13059439732`, `11031287982`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R07-029 — Data export/import is Pro while the store listing advertises 'IMPORT AND EXPORT — Switching phones and don't want to lose your data?' with no sign it is paywalled; users hit exactly that — 'you cant even import/export if you change devices without also paying for it'; 'I cannot export my data without buying the subscription. It is against GDPR.'

- **Where:** §1.1 Discrepancy worth naming; Part 4 #33 Export locked / GDPR objection
- **This app does:** export/import Pro; listing implies free
- **User reaction:** 1★-burst
- **Magnitude:** Export locked / GDPR objection 2 (0.23%), mean 1.00, 100% 1–2★
- **Direction for us:** build-free · **Report confidence:** weak, severe · **Generalisable:** yes
- **Side effects:** a rights/regulatory framing, not a price objection
- **Review IDs:** `11530931211`, `13904375498`
- **Canonical:** C020 Data export / backup / CSV; C114 Ads must match the app

### R07-030 — A 2nd/3rd reminder per habit at different times shipped as a Pro feature (changelog 1.14), as did compact-list configuration (1.13); the request is asked by satisfied users

- **Where:** §1.1 compact-list configuration and 2nd/3rd reminder Pro [external]; Part 4 #25; Part 6 #13
- **This app does:** Pro
- **User reaction:** praise
- **Magnitude:** Wants multiple reminders per habit 6 (0.68%), mean 4.50, 0% 1–2★
- **Direction for us:** build-paid · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C014 Multiple reminders per habit

### R07-031 — The core loop is free — calendar, archive, streaks, one reminder per habit, categories, Shortcuts, backfill — and there are no ads for anyone; 'no ads' reviews are all 5★

- **Where:** §1.1 Calendar, archive, streaks, reminders(1), categories, Shortcuts, backfill Free; No ads row; Part 3 #17
- **This app does:** free
- **User reaction:** praise
- **Magnitude:** No ads 7 (0.79%), mean 5.00, 100% 5★
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13188634050`, `13680396177`, `12336116396`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C006 Stay minimal and ad-free

### R07-037 — Widgets are a real purchase trigger for some: 'Probably upgrading to paid soon for widget feature'; 'the widgets alone are worth the money'

- **Where:** §1.3b Widgets as purchase trigger
- **This app does:** widgets Pro
- **User reaction:** purchase-driver
- **Magnitude:** 8 (0.91%), 3 confirmed payers, mean 4.88
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11371105238`, `13198372302`, `14274998448`, `14363513442`
- **Canonical:** C009 Basic widgets, icons and colours are free; C107 Widget variants and customisation as the paid layer

### R07-049 — No Family Sharing loses sales: 'after I paid for it I couldn't let my family use it? Paying for Pro Lifetime would have felt much better if my kids could use it too'; 'it doesn't support family sharing so I will probably uninstall it and try another'

- **Where:** §1.4 Barrier 5 — no Family Sharing; Part 4 #32; Part 6 #17
- **This app does:** absent
- **User reaction:** churn
- **Magnitude:** 2 (0.23%, Weak), mean 4.00 — one lost expansion sale (payer), one stated churn
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12266571361`, `14057511657`
- **Canonical:** C037 Family plan

### R07-061 — More colours and a colour picker: customization is praised, but 21 preset colours (4 of them greys) break down past ~10 habits — a payer makes the operational case that habits become visually indistinguishable, which directly limits the value of Pro's unlimited habits

- **Where:** Part 3 #6 Customization; Part 4 #13 Wants more colours / icons; Part 6 #8; Part 9 #14
- **This app does:** 21 preset colours, no picker
- **User reaction:** complaint
- **Magnitude:** Customization praise 78 (8.84%), mean 4.72; wants more colours/icons 13 (1.47%), mean 4.38, 7.7% 1–2★
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13621381288`
- **Canonical:** C080 Colour themes / dark mode

### R07-063 — The grid is the product and reviewers explain the behavioural loop unprompted: 'The addiction comes from wanting to paint the whole heatmap with your habit streak, and it works'; 'seeing the grid fill up is so satisfying you'll think twice about missing a single day'; 'Didn't know I needed a habit tracker with GitHub like heat map'

- **Where:** §3.1 The grid is the product, and reviewers explain the mechanism unprompted; Part 3 #7
- **This app does:** GitHub-style year heat-map, free
- **User reaction:** praise
- **Magnitude:** Grid / GitHub heat-map 73 (8.28%, HIGH-PRIORITY), mean 4.73, 80.8% 5★; high-spend 10.1% vs rest 5.6%
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11371105238`, `11237726788`, `10260406195`, `13116413283`
- **Canonical:** C012 Week / month / year grid views

### R07-069 — Shortcuts / Siri / NFC automation serves a small, extremely loyal quantified-self segment — hotel key cards used as NFC triggers — who also ask for a read-only API, REST APIs and deep links

- **Where:** Part 3 #14 Shortcuts / Siri / NFC automation; Part 5 quantified-self row; Part 6 #16
- **This app does:** Shortcuts free
- **User reaction:** praise
- **Magnitude:** 13 (1.47%, MEANINGFUL), mean 4.77, 84.6% 5★; Read-only API / deep links 3, mean 5.00
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13244460118`, `12336116396`, `14402619133`, `13650913780`, `12934585259`, `12108952662`
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R07-076 — Native iPad layout before Apple Watch: the iPad complaint hurts most and is cheapest to fix — a responsive layout, not a new app ('on iPad the UI feels stretched and awkward'; one churned over it)

- **Where:** §4.3 iPad; Part 4 #6; Part 6 #4; Part 9 #13
- **This app does:** iPhone layout stretched on iPad
- **User reaction:** churn
- **Magnitude:** No native iPad app 18 (2.04%, MEANINGFUL), mean 3.61 (worst of the three), 16.7% 1–2★; 8.4% of 4★, 11.4% of 3★
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13336507038`, `13092058110`
- **Canonical:** C141 Native iPad layout

### R07-077 — Mac / web app is wanted; several users found the iOS-app-on-Mac workaround themselves; Pro from phone not carrying to macOS is one of the entitlement failures

- **Where:** §4.3 Mac / web; Part 4 #11
- **This app does:** no native Mac/web app
- **User reaction:** complaint
- **Magnitude:** No Mac / web app 15 (1.70%), mean 3.87, 20.0% 1–2★
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12403426948`, `12186579144`, `13105035694`
- **Canonical:** C044 Mac / desktop / web app

### R07-078 — Apple Watch is asked for most and forgiven most — a want, not a blocker (tick a habit from the wrist; several say they would pay), except two 1★s

- **Where:** §4.3 Apple Watch; Part 4 #5; Part 6 #5
- **This app does:** no Watch app
- **User reaction:** complaint
- **Magnitude:** No Apple Watch app 20 (2.27%, MEANINGFUL), mean 4.15, 15.0% 1–2★; 6.3% of 4★
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12162624396`, `13583765027`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R07-082 — Health / Strava / Oura / Duolingo integration is a pure-upside request with stated willingness to pay — 'Would easily pay for the pro version if it had that'

- **Where:** Part 4 #24 Wants Health / Strava / Oura integration; Part 6 #12
- **This app does:** absent
- **User reaction:** purchase-driver
- **Magnitude:** 6 (0.68%, EMERGING), mean 4.83, 0% 1–2★
- **Direction for us:** build-paid · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12139974588`, `12183133631`
- **Canonical:** C021 Apple Health integration

### R07-083 — Friend visibility / accountability partner is a small request benchmarked against HabitShare

- **Where:** Part 4 #34 Wants friend / accountability sharing; Part 6 #18
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 2 (0.23%, Weak), mean 4.50
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `9901846846`
- **Canonical:** C015 Shared / group habits

### R07-085 — Hide / reorder completed habits is asked by long-list users

- **Where:** Part 4 #30 Wants 'hide completed habits'; Part 6 #15
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 3 (0.34%, Weak), mean 4.33
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R07-086 — Per-day notes are pure upside — people want to record what they did, not only that they did it ('I'd like to add a note specifying which exercises'; 'on a day you missed your habit, write the reason why'; 'I'd be willing to subscribe to pro for that') — shipped in 1.16.0 and confirmed by the reviewer who proposed it; verify late requesters were on older builds before treating it as open

- **Where:** §4.1 The two request clusters that are pure upside — per-day notes; Part 4 #8; Part 6 #7; §8.2
- **This app does:** shipped 1.16.0 after 3 years of requests
- **User reaction:** purchase-driver
- **Magnitude:** 16 (1.81%, MEANINGFUL), mean 4.81, not one below 4★; requests Nov 2023 → Aug 2026
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13824458972`, `13036578153`, `12607872016`, `14466920687`
- **Canonical:** C049 Mood tracker / journal / habit notes

### R07-087 — Sub-habits / folders / pages are the natural next product after categories and what heavy users (10+ habits, the paying segment) ask for: 'label the habit morning routine, click it to open, add a sub-habit like make bed, brush teeth, do skin care, and once you check off all three it will complete that habit'; pages to separate his tracking from his dog's; career vs health folders

- **Where:** §4.1 Sub-habits / folders / pages; Part 4 #17; Part 6 #9
- **This app does:** categories only
- **User reaction:** praise
- **Magnitude:** 11 (1.25%, MEANINGFUL), mean 4.82, zero 1–2★
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** ship opt-in, invisible by default (Part 9 #16)
- **Review IDs:** `11526306665`, `13692456434`, `13149743389`, `12727692876`, `11650437167`, `11081763094`
- **Canonical:** C045 Grouping / folders / tags / multiple profiles

### R07-090 — Genuinely missing: skip / rest days that don't break the chain (public holidays shouldn't break a work habit) and every-other-day intervals — 'leider keine Gewohnheiten, die alle zwei Tage anstehen… Sonst hätte ich es mit der App versucht', a stated non-adoption

- **Where:** §4.2 Genuinely missing: skip / rest days and every-other-day intervals; Part 9 #15
- **This app does:** no interval / holiday skip
- **User reaction:** blocked-conversion
- **Magnitude:** 3 reviews, all 5★ or 4★; cheap
- **Direction for us:** must-have · **Report confidence:** weak, cheap · **Generalisable:** yes
- **Review IDs:** `13604363091`, `12962416172`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C043 Flexible / custom frequency

### R07-091 — A configurable day boundary (a 4am rollover, not midnight) for night-shift and late-night loggers — all requesters 5★, cheap fix

- **Where:** Part 4 #29 Wants custom day-boundary (not midnight); Part 6 #14; Part 9 #15
- **This app does:** midnight rollover
- **User reaction:** praise
- **Magnitude:** 3 (0.34%, Weak), mean 5.00
- **Direction for us:** must-have · **Report confidence:** weak, cheap · **Generalisable:** yes
- **Review IDs:** `12632001002`, `13776739735`, `11670099719`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

### R07-093 — Notification interactions users want: mark 'complete' from a held notification without opening the app ('Not possible to hold notification and choose complete'), more attention-grabbing reminders, and a sticky reminder that can't be dismissed until the habit is done

- **Where:** §4.4 missing notification action; flashy / sticky reminders
- **This app does:** no actionable notification
- **User reaction:** 1★-burst
- **Magnitude:** 3 of the 6 notification reviews (1★, 4★, 4★)
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13184092651`, `13631547170`, `12438365647`
- **Canonical:** C123 Notification escalation must be user-configurable, never silently retuned

### R07-104 — Multi-habit widget shipped in 1.15, yet 4 requests are dated 2026 — a discoverability check is needed

- **Where:** Part 6 #10 Multi-habit widget; Part 4 #16
- **This app does:** shipped 1.15 (Pro)
- **User reaction:** complaint
- **Magnitude:** Wants multi-habit widget 11 (1.25%, MEANINGFUL), mean 4.09, 9.1% 1–2★; 4 requests dated 2026
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C107 Widget variants and customisation as the paid layer; C142 Surface existing features where users look

### R07-131 — Ship iCloud/CloudKit sync — the single largest rating lever — opt-in, end-to-end, CloudKit private database, and say so in the release notes, so the privacy promise holds

- **Where:** Part 9 Product — converts 3★/4★ into 5★ #11 Ship iCloud/CloudKit sync
- **This app does:** absent
- **User reaction:** blocked-conversion
- **Magnitude:** 54 reviews; 18.9% of 4★; 31.4% of 3★; 3 years unfixed
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-016, R07-072
- **Review IDs:** `12386725682`, `12139974588`, `13833569208`, `13499288017`, `11241317063`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C096 Privacy and discretion stack

### R07-133 — Native iPad layout before Apple Watch — worse mean, and a layout problem rather than a new product

- **Where:** Part 9 #13 Native iPad layout before Apple Watch
- **This app does:** stretched phone UI
- **User reaction:** complaint
- **Magnitude:** iPad mean 3.61 vs Watch 4.15
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-076, R07-078
- **Canonical:** C141 Native iPad layout

### R07-134 — More colours and a colour picker — the 21-colour palette directly limits the value of Pro's unlimited habits

- **Where:** Part 9 #14 More colours, and a colour picker
- **This app does:** 21 presets, 4 greys
- **User reaction:** complaint
- **Magnitude:** 13 requests
- **Direction for us:** undecided · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-061
- **Review IDs:** `13621381288`
- **Canonical:** C080 Colour themes / dark mode

### R07-135 — Rest/skip days and a configurable day boundary — small counts but all 5★ and both cheap

- **Where:** Part 9 #15 Rest/skip days, and a configurable day boundary
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 3 + 3
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-090, R07-091
- **Review IDs:** `13604363091`, `12632001002`, `13776739735`, `11670099719`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

## Monetization

### R07-006 — The 4-habit free cap is the single most damaging decision in the product: it does not convert the people it blocks — zero of the 27 complainers show any evidence of having paid — it produces a bad review and a churn; top 2★ theme by a distance

- **Where:** Part 0 §2 (The 4-habit free cap is the single most damaging decision in the product); Part 4 #4; Part 2 2★; Part 6 #2; §8.4
- **This app does:** free tier = 4 habits, unchanged Feb 2023 → Aug 2026 (18 dated reports: 15 say 4, two 5, one 3)
- **User reaction:** churn
- **Magnitude:** 27 (3.06%, VERY STRONG), mean 2.56, 55.6% 1–2★, 7.4% 5★; 0 of 27 paid; 2★: 8 of 19 (42.1%); outside high-spend 4.2% vs 2.3%; long tail 4.5% vs 2.4%; CA 7.1%; span 3y 7m (9589360229 6 Feb 2023 → 14463193980 23 Aug 2026)
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `9589360229`, `10100430683`, `11058226263`, `11333683156`, `11530931211`, `11713771657`, `12224917759`, `12297500345`, `12499305420`, `13030220021`, `13513014070`, `13677605567`, `13838060940`, `14316598205`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R07-011 — Make one widget free and more widgets paid — the model reviewers designed themselves: 'only making one widget free and making more widgets paywalled, kinda like Widgy'; widgets are the strongest daily-engagement surface (one user runs three home-screen pages of them), so a free widget creates the habit that later justifies Pro

- **Where:** Part 0 §3 free-one/paid-many proposal; Part 6 #3; Part 9 #6
- **This app does:** zero free widgets
- **User reaction:** blocked-conversion
- **Magnitude:** 13 objections at 2.23 (0% 5★); 8 widget buyers at 4.88
- **Direction for us:** build-free · **Report confidence:** recommendation · **Generalisable:** yes
- **Side effects:** also reduces the Pro-entitlement widget failures' blast radius
- **Review IDs:** `12622891075`, `14305420985`
- **Canonical:** C009 Basic widgets, icons and colours are free; C107 Widget variants and customisation as the paid layer

### R07-026 — Every explicit 'too expensive' complaint dated after Oct 2024 is about the lifetime number, never the monthly one — and the price objection has two peaks (2024 and 2026), both following a lifetime price increase (to €35 in late 2024; still €35/£29.99 in 2026 while a $12/year SKU exists); correlation only, no causal claim

- **Where:** §1.1 Reading: every too-expensive complaint after Oct 2024 is about lifetime; §8.3 price objection two peaks
- **This app does:** lifetime $15 (Dec 2022) → €35 (late 2024)
- **User reaction:** complaint
- **Magnitude:** price objection 0.00% (P1) → 2.99% (P2) → 0.65% (P3) → 3.03% (P4)
- **Direction for us:** research · **Report confidence:** correlation · **Generalisable:** yes
- **Conditions:** raising the lifetime price draws price objections even in the markets that praise lifetime most
- **Review IDs:** `11818567731`, `11942193233`, `11994502139`, `14093446153`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R07-036 — The one-time / lifetime option is the single most cited reason to pay — 'If you're NOT a fan of subscription based services, then THIS IS THE APP FOR YOU… You're not renting this product, it is yours to keep'; one reviewer says lifetime is why he did not drop to 4★ over the habit cap, another would give a bonus star for it

- **Where:** §1.3a The one-time / lifetime option is the single most cited reason to pay; Part 3 #9; §7.2 finding 3; Part 9 #7
- **This app does:** lifetime SKU ≈ $30 / €35 / £29.99
- **User reaction:** purchase-driver
- **Magnitude:** 45 (5.10%, HIGH-PRIORITY), mean 4.71, 77.8% 5★; 16 confirmed payers (35.6% segment rate); high-spend group 7.2% vs rest 2.0%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11999151976`, `13685738378`, `13657506354`, `13344667636`, `9334266709`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R07-042 — Barrier 1 is the €35/$30 lifetime price specifically — 'The app does not have enough features to justify the $13 pro. $5 or $10 would be more acceptable'; 'Ich hab schon bis zu 500€ für Apps bezahlt. Aber hier reden wir über die Simpelste Utility vorstellbar'

- **Where:** §1.4 Barrier 1 — the €35/$30 lifetime price, specifically; Part 4 #10
- **This app does:** lifetime €35 / $30
- **User reaction:** complaint
- **Magnitude:** Price too high 15 (1.70%, MEANINGFUL), mean 2.73, 46.7% 1–2★; paid cohort 4 of 15 (26.7%)
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11942193233`, `12076054585`, `14093446153`, `13621381288`, `12032382845`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R07-044 — A buyer who pays and resents it: 'making people pay 40$ CA for lifetime usage. It's taking advantage of people. I still paid it because I don't feel like returning to other apps, but that's an abusive amount' — rated 5★

- **Where:** §1.4 CA$40 — bought, resents it, 5★
- **This app does:** CA$40 lifetime (~US$30)
- **User reaction:** mixed
- **Magnitude:** 1 (5★, CA)
- **Direction for us:** research · **Report confidence:** quoted (n = 1) · **Generalisable:** yes
- **Review IDs:** `12076054585`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R07-046 — Barrier 2 is no trial: users ask to try before paying, and the features they most want to preview are exactly charts and widgets — the two things a screenshot cannot convey; add a real trial for those two

- **Where:** §1.4 Barrier 2 — no trial; Part 4 #22; Part 9 #9
- **This app does:** no trial
- **User reaction:** blocked-conversion
- **Magnitude:** Wants trial before buying 7 (0.79%, EMERGING), mean 4.14, 14.3% 1–2★
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10332746889`, `12181661428`, `11031287982`, `14248083289`, `11920130040`
- **Canonical:** C063 Free trial before purchase

### R07-062 — Price is fair and the free tier is generous, say a large set of satisfied users — the same packaging that angers the 5–8-habit user reads as good value to others

- **Where:** Part 3 #8 Price is fair; #12 Free tier is generous
- **This app does:** 4 free habits; lifetime ≈ $30
- **User reaction:** praise
- **Magnitude:** Price is fair 51 (5.78%), mean 4.94, 94.1% 5★; free tier generous 25 (2.83%), mean 4.52, 80.0% 5★; paid cohort fair-price 15 of 51 (29.4%)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C004 Price low and fair, anchored against subscription competitors; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R07-074 — The paywall generally blocks use for a very strong minority — distinct from the specific cap and widget themes — and runs highest in Canada

- **Where:** Part 4 #3 Paywall generally blocks use
- **This app does:** 4 habits free; widgets, charts, export Pro
- **User reaction:** complaint
- **Magnitude:** 31 (3.51%, VERY STRONG), mean 3.06, 38.7% 1–2★; CA 7.1% (HIGH), US 3.8%, DE 2.8%, GB 2.2%
- **Direction for us:** none · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R07-125 — Raise the free habit cap from 4 to 6–8 — move the wall past the 5-to-8-habit user, not in front of them

- **Where:** Part 9 Monetization — repackage, don't reprice #5 Raise the free habit cap from 4 to 6–8
- **This app does:** 4-habit cap
- **User reaction:** churn
- **Magnitude:** 27 complaints, mean 2.56, 55.6% 1–2★, zero conversions among complainers; 11 say 4 is enough
- **Direction for us:** build-free · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-006, R07-007
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R07-126 — Make one widget free (more with Pro) — the widget paywall is the only theme with a 0% 5★ rate, and free widgets create the habit that later justifies Pro

- **Where:** Part 9 #6 Make one widget free
- **This app does:** all widgets Pro
- **User reaction:** complaint
- **Magnitude:** 13 objections, 0% 5★
- **Direction for us:** build-free · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-009, R07-011
- **Review IDs:** `12622891075`, `14305420985`
- **Canonical:** C009 Basic widgets, icons and colours are free; C107 Widget variants and customisation as the paid layer

### R07-127 — Keep the lifetime SKU prominent, and make subscription → lifetime possible in-app — two 5★ customers in one July 2026 week tried to hand over the lifetime price and could not

- **Where:** Part 9 #7 Keep the lifetime SKU prominent, and make subscription→lifetime possible in-app
- **This app does:** no in-app cross-grade
- **User reaction:** blocked-conversion
- **Magnitude:** lifetime top trigger 45 (35.6% payers); 2 blocked buyers
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-036, R07-047
- **Review IDs:** `14288167581`, `14289596763`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C077 Purchase and signup flow must not leak buyers

### R07-129 — Add a real trial for charts and widgets, the two features screenshots cannot sell

- **Where:** Part 9 #9 Add a real trial for the two features screenshots cannot sell: charts and widgets
- **This app does:** no trial
- **User reaction:** blocked-conversion
- **Magnitude:** 7 requests
- **Direction for us:** undecided · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-046
- **Canonical:** C063 Free trial before purchase

## Tactics the app used

### R07-017 — Tactic: the developer tells users sync is in development (FAQ, and personally) — the roadmap message is reaching some users and buying goodwill, with one 5★ reviewer relaying it

- **Where:** Part 0 §5 [external] sync 'is currently in development' relayed by a reviewer
- **This app does:** communicates roadmap for the top missing feature
- **User reaction:** praise
- **Magnitude:** 1 reviewer (5★, IN) relays it
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13346250530`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

## Insights (the why)

### R07-003 — HabitKit is not a troubled app — 78.46% 5★, dense specific praise, top three themes are product themes (simplicity 38.10%, design 34.58%, the developer himself 15.08%), nothing suggests a broken core loop — yet its rating is sliding monotonically for reasons that are all fixable

- **Where:** Part 0 §1 (This is the healthiest product in the set — and its rating is still sliding, for reasons that are all fixable)
- **This app does:** healthy core loop
- **User reaction:** mixed
- **Magnitude:** simplicity 38.10%, design 34.58%, developer 15.08%; mean 4.79 → 4.42 across four cohorts
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R07-005 — The cause of the slide is almost entirely monetization, not product quality: of 41 one-star reviews, 21 (51.2%) are paywall / price / free cap and 4 (9.8%) paid and could not get what they paid for; only 4 are the app malfunctioning and 3 about confusion — 'The product is winning. The packaging is losing.'

- **Where:** Part 0 §1 And the cause is almost entirely monetization; Part 2 1★
- **This app does:** 4-habit cap, Pro-gated widgets, €35 lifetime
- **User reaction:** 1★-burst
- **Magnitude:** 1★ n = 41: 21 (51.2%) paywall/price/cap; 4 (9.8%) paid-but-broken; 4 malfunction; 3 confusing
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R07-007 — The cap is not universally hated: 11 reviewers name the same cap and are fine with it — all 11 are 5★ — so it is hated by people who need 5–8 habits and loved by people who need 3–4: a segmentation problem with a cheap fix (raise the cap to 6–8), not a pricing problem; move the wall past the 5-to-8-habit user, who is the likeliest future power user and payer

- **Where:** Part 0 §2 Counter-evidence that matters; Part 9 #5
- **This app does:** 4-habit cap
- **User reaction:** mixed
- **Magnitude:** 11 (1.25%), all 5★ vs 27 complainers at 2.56
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Conditions:** the wall should sit above the typical user's habit count and below the power user's (10+) needs — folders, colours, stats
- **Review IDs:** `10842857261`, `10882654265`, `11602928681`, `11714676984`, `12068026268`, `12238453493`, `12273297032`, `13727963896`, `13813261463`, `14407894713`, `14463193980`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R07-019 — The developer is a top-5 product asset and reviewers name him ('Sebastian', 'Seb'): replies in hours to days, a widget bug fixed within an hour, a fix in two days, a proposed day-note feature shipped, a reviewer upgrading his review after both requests shipped — 'best support services I've ever seen from any app on the app store'

- **Where:** Part 0 §6 (The developer is a top-5 product asset, and reviewers say so by name); Part 3 #3
- **This app does:** solo developer answers personally and ships user requests
- **User reaction:** praise
- **Magnitude:** 133 (15.08%, HIGH-PRIORITY), mean 4.85, 93.2% 5★; CA 23.2% (highest)
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12762466887`, `11364312275`, `11551214646`, `13432617886`, `14466920687`, `11426923525`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R07-021 — Three tightly coupled praise clusters describe one product decision — the GitHub grid and doing nothing else: simplicity / no bloat, design / visual appeal, and the grid heat-map itself, which reviewers spontaneously call 'GitHub', 'contribution graph', 'commits', 'Seinfeld / don't break the chain'

- **Where:** Part 0 §7 (What actually makes people love this app: the GitHub grid, and doing nothing else)
- **This app does:** minimal grid-first tracker
- **User reaction:** praise
- **Magnitude:** simplicity 336 (38.10%), mean 4.86, 89.9% 5★; design 305 (34.58%), mean 4.78; grid 73 (8.28%), mean 4.73
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C006 Stay minimal and ad-free; C012 Week / month / year grid views

### R07-035 — Free-tier grievances and buyer grievances are two disjoint populations: payers never appear in cap complaints (0 of 27), widget-paywall objections (0 of 13) or upsell nagging (0 of 8) — free-tier complaints tell you why people don't buy; paid complaints (bugs, broken entitlement, subscription objection, redesign) tell you why buyers churn

- **Where:** §1.2 The free-tier grievances and the buyer grievances are two disjoint populations
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** cap 0/27, widget paywall 0/13, upsell 0/8 in paid cohort; bug_reported 7 of 16 (43.8%), subscription objection 22 of 55 (40.0%), redesign 3 of 7 (42.9%), price objection 4 of 15 (26.7%)
- **Direction for us:** product-rule · **Report confidence:** segment rates · **Generalisable:** yes
- **Conditions:** read each complaint theme against the population that produced it before deciding what to fix
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R07-039 — Hitting the habit cap does convert some users — 'Ich hab mir sofort die Pro Version geholt, weil ich auch noch mehr als 4 Gewohnheiten tracken wollte'; 'Instantly went for the pro subscription cause I wanted to add habits for everything' — but none of them are among the 27 who complain about it

- **Where:** §1.3c Hitting the habit cap
- **This app does:** 4-habit cap
- **User reaction:** purchase-driver
- **Magnitude:** 4 quoted buyers; 0 of 27 complainers paid
- **Direction for us:** undecided · **Report confidence:** quoted · **Generalisable:** yes
- **Review IDs:** `14374370548`, `13779234074`, `14028004356`, `12132760416`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R07-040 — Supporting the indie developer is a genuine, repeated purchase motive, not politeness: 'I mostly subscribed to be supportive'; 'I like to support independent creators'; 'you also value user data and privacy… 5 stars – you have a new pro subscriber'; a developer from his own region

- **Where:** §1.3d Supporting the indie developer — a genuine, repeated motive, not politeness
- **This app does:** solo indie, privacy-first
- **User reaction:** purchase-driver
- **Magnitude:** 5 quoted buyers
- **Direction for us:** do · **Report confidence:** quoted · **Generalisable:** app-specific
- **Conditions:** depends on a visible, named, likeable indie maker
- **Review IDs:** `11339667935`, `12934931415`, `12639428322`, `13843530419`, `13003206041`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R07-041 — The free tier is doing real trial work for the buyers it does not annoy: buyers describe delays of 6 weeks, a month, a week, two months before upgrading, or monthly then yearly within a week

- **Where:** §1.3e A trial period of using the free tier first
- **This app does:** 4-habit free tier as de facto trial
- **User reaction:** purchase-driver
- **Magnitude:** 5 quoted buyers with stated delays
- **Direction for us:** build-free · **Report confidence:** quoted · **Generalisable:** yes
- **Review IDs:** `12159772330`, `12934931415`, `13596249635`, `14469978356`, `13603385121`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C007 Generous fixed habit cap (or unlimited) — never change it

### R07-050 — Subscription aversion is loud but mostly non-fatal: the theme is bimodal (32 of 55 are 5★ praising that a subscription is NOT required) and 22 of 55 are confirmed payers who subscribed while complaining — the lesson is not 'drop subscriptions' but that the lifetime SKU is doing enormous defensive work and must stay visible and purchasable

- **Where:** §1.5 Subscription aversion is loud but mostly non-fatal; Part 4 #2
- **This app does:** subscription + lifetime
- **User reaction:** mixed
- **Magnitude:** 55 (6.24%, HIGH-PRIORITY), mean 3.84, 27.3% 1–2★; 32 of 55 5★, 15 1–2★; 22 of 55 payers (40%); 4.93% → 5.13% → 6.17% → 8.59%; DE 9.3%, US 8.1%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R07-053 — The 5★ recipe is unusually consistent: 'I tried N other habit trackers, they were bloated, this one shows me a coloured grid, I stopped looking' — and everyone who says it changed their life or is their favourite app gives 5★

- **Where:** Part 2 5★ recipe; Part 3 #11 Life-changing
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** Life-changing / best app 38 (4.31%), mean 5.00, 100% 5★
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R07-056 — Nearly one in five 4★ reviews would be a 5★ if sync existed, and several say so verbatim — 'I'll upgrade to 5 stars if I can sync across iCloud' — the cheapest star in the corpus

- **Where:** Part 2 4★ Nearly one in five 4★ reviews would be a 5★ if sync existed
- **This app does:** no sync
- **User reaction:** blocked-conversion
- **Magnitude:** 18 of 95 4★ (18.9%)
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12487171971`, `13594471502`, `13856682531`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator

### R07-057 — 3★ is a feature-gap band, not a quality band: only 3 of 35 three-star reviews are about the app working badly; the rest are sync (31.4%), cap, iPad, paywall and widget paywall

- **Where:** Part 2 3★ — n = 35 (3.97%) — almost entirely sync + paywall table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 3★ ; Wants sync | 11 | 31.4% ; Habit cap | 4 | 11.4% ; iPad | 4 | 11.4% ; Paywall general | 4 | 11.4% ; Widget paywall | 3 | 8.6% ; only 3 of 35 about the app working badly
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-058 — 2★ is the free cap's band: 8 of 19 name the habit cap, 6 more name sync or missing platforms; only one is about usability ('a bit complicated') and one about the redesign

- **Where:** Part 2 2★ — n = 19 (2.15%) — the free cap's band
- **This app does:** 4-habit cap
- **User reaction:** complaint
- **Magnitude:** 2★ n = 19: cap 8 (42.1%); sync/platforms 6; usability 1; redesign 1
- **Direction for us:** build-free · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `13213024086`, `14447636722`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R07-064 — The year-scale view defuses failure: users say it is the only tracker that does not induce anxiety when a streak breaks — 'this is the only one that doesn't give me so much anxiety and stress when I miss my streaks'; 'It doesn't guilt you'; 'Trusts you to own your goals'; 'you don't feel discouraged if you have been off track for one entire week' — a differentiator against the whole streak-shaming category, absent from the store listing

- **Where:** §3.1 the year-scale view specifically defuses failure; Part 3 #19; Part 9 #17
- **This app does:** months-scale grid, no shaming
- **User reaction:** praise
- **Magnitude:** 6 (0.68%); Non-judgmental / no guilt 6 (0.68%, EMERGING), mean 5.00, 100% 5★
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12458258118`, `12949502025`, `11650437167`, `10260406195`
- **Canonical:** C095 Neutral, non-judgemental tone on failure

### R07-070 — Reliability is volunteered as praise — 'no bugs', 'never crashes' — and almost no crash reports exist

- **Where:** Part 3 #16 Reliability / no bugs; §4.5 Almost no crash reports
- **This app does:** stable
- **User reaction:** praise
- **Magnitude:** Reliability / no bugs 8 (0.91%, EMERGING), mean 5.00, 100% 5★
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R07-071 — The offline / no-account posture appears to have completely eliminated privacy and data-selling accusations — zero in a category where they are common — and some users praise local-only storage and even the absence of sync ('not based around some opaque cloudy AI nonsense')

- **Where:** Part 3 #18 Privacy / local data / no account; §4.5 No privacy or data-selling accusations at all
- **This app does:** no account, local-only, no ads
- **User reaction:** praise
- **Magnitude:** Privacy / local data / no account 7 (0.79%), mean 4.71; 0 privacy accusations
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11241317063`, `13860278748`, `13177753546`
- **Canonical:** C096 Privacy and discretion stack

### R07-096 — Absences are informative: no ad complaints beyond premium-upsell interstitials (there are no ads), no privacy accusations, no billing-fraud claims, no AI demand, almost no crashes — the complaint load is packaging and missing platforms

- **Where:** §4.5 No ad complaints; What is *not* in this corpus
- **This app does:** no ads, local-only
- **User reaction:** praise
- **Magnitude:** 0 ad / privacy / fraud complaints; 8 upsell interstitial complaints
- **Direction for us:** none · **Report confidence:** absence · **Generalisable:** yes
- **Canonical:** — (nuance register)

## Audiences

### R07-065 — ADHD / autistic / executive-dysfunction users are a small but perfect-scoring segment — every one is 5★ ('die benutzerfreundlichste App die ich kenne') — yet the listing never mentions ADHD, while competitors in this set (apps 1 and 5) put it in the app title

- **Where:** §3.2 ADHD is a small but perfect-scoring segment; Part 3 #13; Part 9 #17
- **This app does:** not marketed
- **User reaction:** praise
- **Magnitude:** 13 (1.47%), mean 5.00, 100% 5★; 0.70% (P1) → 0.43% → 2.60% → 1.52%
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12306236126`, `12639428322`, `12836092446`, `13220877574`, `13332990475`, `13461770688`, `13605202758`, `13666998704`, `13647254621`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R07-066 — People use it for things that are not habits — migraines and medical incidents, supplements for themselves and their dog, art-project days, gym sessions, medication adherence, imported 2015-era JSON history, a bullet journal's digital twin: 'I love that it does not necessarily have to have a goal and you can use it to just track whatever you like' — a real, high-satisfaction, unmarketed segment (listing says only 'form new habits or break old ones')

- **Where:** §3.3 People use it for things that are not habits; Part 3 #15; Part 9 #18
- **This app does:** generic tracker by accident
- **User reaction:** praise
- **Magnitude:** 11 (1.25%), mean 4.91, 90.9% 5★
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10226902295`, `13149743389`, `13939554665`, `11915650641`, `13690973300`, `12471637696`, `10705970933`, `14440599892`
- **Canonical:** C140 Market the generic-tracker use case

### R07-098 — Developers and technical users are the founding audience — they recognise the GitHub contribution graph on sight ('If you're a developer, the whole thing feels very familiar from GitHub'; 'It is like GitHub of Habit'; one spots the Flutter build)

- **Where:** Part 5 Developers / technical users — the founding audience
- **This app does:** GitHub-grid metaphor
- **User reaction:** praise
- **Magnitude:** 7 named reviews; 73 grid-metaphor mentions
- **Direction for us:** do · **Report confidence:** founding audience · **Generalisable:** app-specific
- **Review IDs:** `9452538229`, `12072650756`, `12104725882`, `13196795496`
- **Canonical:** C012 Week / month / year grid views

### R07-099 — Ex-bullet-journallers explain the year-grid attachment — one drew a pixel year-view by hand before

- **Where:** Part 5 Ex-bullet-journallers
- **This app does:** year grid
- **User reaction:** praise
- **Magnitude:** 4 named reviews
- **Direction for us:** do · **Report confidence:** small · **Generalisable:** yes
- **Review IDs:** `10705970933`, `11674324275`, `12196979794`, `13177753546`
- **Canonical:** C012 Week / month / year grid views

### R07-100 — Multi-habit power users (10+ habits) are the paying segment, and they drive the folders, colours and hide-completed requests — '21 colours not enough for 10+ habits'

- **Where:** Part 5 Multi-habit power users (10+) — the paying segment
- **This app does:** unlimited habits Pro
- **User reaction:** purchase-driver
- **Magnitude:** 4 named reviews
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `13621381288`, `14089093879`, `12958968819`, `13422297301`
- **Canonical:** C045 Grouping / folders / tags / multiple profiles; C133 Gate on capability, not on quantity

### R07-102 — Religious practice is a use case — daily Bible reading, and a request for location-based Islamic prayer times ('potenziell 2 Milliarden Kunden')

- **Where:** Part 5 Religious practice [limited evidence, n=2]
- **This app does:** generic habits only
- **User reaction:** praise
- **Magnitude:** 2 [limited evidence]
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13291634659`, `13647254621`
- **Canonical:** C028 Culturally complete icon set and calendars

## Markets and languages

### R07-045 — Cross-platform price-parity objection: '$2 a month. Too pricy for me, twice the cost of same subscription on android'

- **Where:** §1.4 cross-platform price-parity objection
- **This app does:** $2/month on iOS
- **User reaction:** 1★-burst
- **Magnitude:** 1 (1★, US)
- **Direction for us:** research · **Report confidence:** quoted (n = 1) · **Generalisable:** yes
- **Review IDs:** `12032382845`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R07-048 — The China storefront looks unserved rather than under-served: 2 of 4 CN reviews are purchase failures ('无法购买会员' — cannot purchase membership; '怎么开会员 / 怎么设置中文啊' — how do I buy / how do I set Chinese?) and a third asks for Chinese, on a 100% English-only listing

- **Where:** §1.4 Barrier 4 — China storefront cannot buy at all; §7.4 CN
- **This app does:** EN-only listing; purchase fails in CN
- **User reaction:** blocked-conversion
- **Magnitude:** 4 CN reviews total: 2 purchase failures, 2 Chinese requests [limited evidence]
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** unknown
- **Review IDs:** `11442530087`, `11183018670`, `11385868721`
- **Canonical:** C027 Localise early — it unlocks revenue; C132 Do not sell in a storefront where the app cannot function

### R07-105 — US / DE / GB / CA side by side: n, mean, 5★, 1–2★, praise, payers, sync, subscription, price, cap, paywall, churn

- **Where:** §7.1 The four eligible storefronts (≥50 reviews) table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | US | DE | GB | CA ; n (% of corpus) | 211 (23.9%) | 107 (12.1%) | 89 (10.1%) | 56 (6.3%) ; Mean rating | 4.61 | 4.69 | 4.69 | 4.50 ; 5★ | 78.7% | 77.6% | 80.9% | 78.6% ; 1–2★ | 4.7% | 1.9% | 3.4% | 8.9% ; Simplicity praise | 41.7% | 46.7% | 33.7% | 28.6% ; Design praise | 43.1% | 37.4% | 46.1% | 32.1% ; Developer praise | 18.0% | 16.8% | 16.9% | 23.2% ; Explicit payers | 13.3% | 7.5% | 5.6% | 12.5% ; Wants sync | 9.0% | 7.5% | 3.4% | 5.4% ; Subscription objection | 8.1% | 9.3% | 4.5% | 5.4% ; Price objection | 1.9% | 3.7% | 0.0% | 5.4% ; Habit-cap complaint | 1.4% | 2.8% | 0.0% | 7.1% ; Paywall (general) | 3.8% | 2.8% | 2.2% | 7.1% ; Stated churn | 0.9% | 0.9% | 1.1% | 3.6%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-106 — Country-level signal labels (each country's own n): CA carries a HIGH-PRIORITY signal on four separate money themes — the only eligible storefront that does

- **Where:** §7.1 Signal labels applied at country level table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Finding | US (n=211) | DE (n=107) | GB (n=89) | CA (n=56) ; Wants sync | 9.00% HIGH | 7.48% HIGH | 3.37% VERY STRONG | 5.36% HIGH ; Subscription objection | 8.06% HIGH | 9.35% HIGH | 4.49% VERY STRONG | 5.36% HIGH ; Paywall (general) | 3.79% VERY STRONG | 2.80% MEANINGFUL | 2.25% MEANINGFUL | 7.14% HIGH ; Habit-cap complaint | 1.42% MEANINGFUL | 2.80% MEANINGFUL | 0.00% — none | 7.14% HIGH ; Price objection | 1.90% MEANINGFUL | 3.74% VERY STRONG | 0.00% — none | 5.36% HIGH ; Widget paywall objection | 0.47% Weak | 1.87% MEANINGFUL | 1.12% MEANINGFUL | 1.79% MEANINGFUL ; Stated churn | 0.95% Emerging | 0.93% Emerging | 1.12% MEANINGFUL | 3.57% VERY STRONG ; Explicit payers | 13.27% HIGH | 7.48% HIGH | 5.62% HIGH | 12.50% HIGH
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-107 — US is the biggest and most engaged market and its friction is feature-shaped, not price-shaped: highest payer density, highest sync demand, highest 'tried many apps' rate, the longest feature-specific reviews and nearly all automation praise — sync 19, iPad/Mac 11, only 3 habit-cap complaints

- **Where:** §7.1 US (n=211)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** US 211: payers 13.3%, sync 9.0%, tried-many 19.4%, cap 1.4%, mean 4.61
- **Direction for us:** research · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R07-108 — Germany is the best-rated and most product-loyal eligible market and also where the price argument is loudest and most concrete: Germans do not object to paying, they object to €35 for what they read as a utility — all three €35 lifetime reports, and the only reviewer who names a competitor's price and switches, are German

- **Where:** §7.1 DE (n=107)
- **This app does:** €35 lifetime
- **User reaction:** mixed
- **Magnitude:** DE 107: mean 4.69, 1.9% 1–2★, simplicity 46.7%, subscription objection 9.3%, price objection 3.7%
- **Direction for us:** research · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `11818567731`, `11942193233`, `11994502139`, `14093446153`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R07-109 — GB is the healthiest storefront — zero habit-cap complaints, lowest sync demand, highest life-change rate, peak design praise — and its only negatives are recent: both Aug-2026 redesign complaints are British payers

- **Where:** §7.1 GB (n=89)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** GB 89: 80.9% 5★, cap 0.0%, sync 3.4%, life change 7.9%, design 46.1%
- **Direction for us:** none · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `14447636722`, `14452015607`
- **Canonical:** C119 Updates must not regress layout or lose progress

### R07-110 — Canada is the problem market — lowest mean, highest 1–2★, cap, paywall, price-objection and churn rates — while having the highest developer-praise rate and a high payer rate: Canadians love the maker and resent the price; CA$40 for a US$30 SKU is a ~33% premium, and CA is the only eligible market where price complaints outnumber sync complaints — a CA-specific pricing review is warranted

- **Where:** §7.1 CA (n=56) — the problem market; Part 9 #8
- **This app does:** CA$40 lifetime (~33% over US$30)
- **User reaction:** complaint
- **Magnitude:** CA 56: mean 4.50, 1–2★ 8.9%, cap 7.1%, paywall 7.1%, price 5.4%, churn 3.6%, developer praise 23.2%, payers 12.5%; four HIGH money signals
- **Direction for us:** do · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** yes
- **Conditions:** exchange-rate-driven tier pricing can overshoot in one storefront
- **Review IDs:** `12076054585`, `11530931211`, `12224917759`, `13645021715`, `11816451066`, `11860513242`
- **Canonical:** C092 Regional pricing

### R07-111 — High-spend group (US, JP, GB, DE, CN, KR, CA, FR, AU — a labelled assumption, not verified against a spend dataset) vs rest of world

- **Where:** §7.2 High-spend markets table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | High-spend group | Rest of world ; n | 525 (59.5%) | 357 (40.5%) ; Mean | 4.62 | 4.48 ; 1–2★ | 4.8% | 9.8% ; Explicit payers | 9.1% | 7.6% ; One-time-purchase praise | 7.2% | 2.0% ; Grid/GitHub praise | 10.1% | 5.6% ; Habit-cap complaint | 2.3% | 4.2% ; Widget-paywall objection | 1.3% | 1.7% ; Paid-but-broken Pro | 0.4% | 1.7% ; Bugs reported | 1.1% | 2.8% ; Sync demand | 6.7% | 5.3%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-112 — The free cap does nearly twice as much damage outside high-spend markets — MA, DZ, VN, ID, PT, MX, AR, TR, IT, PL, where $30 lifetime is a materially larger sum: 'People on developer countries could really use a plan that does not cost their minimum income' — consider regional lifetime pricing, or lead with the $12/year SKU in price-sensitive storefronts

- **Where:** §7.2 finding 1 — the free cap does nearly twice as much damage outside high-spend markets; Part 9 #8
- **This app does:** one global price ladder
- **User reaction:** complaint
- **Magnitude:** cap complaints rest-of-world 4.2% vs high-spend 2.3%; 1–2★ 9.8% vs 4.8%
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12090297861`
- **Canonical:** C092 Regional pricing; C007 Generous fixed habit cap (or unlimited) — never change it

### R07-113 — The long tail is not a rounding error: the 60 small storefronts are 30% of the corpus, rate ~0.13 stars lower and complain about the cap almost twice as often — the majority of the cap problem (review volume is a disclosed proxy, not downloads or revenue)

- **Where:** §7.3 High-review-volume storefronts table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** top-10 US 211, DE 107, GB 89, CA 56, FR 30, BR 29, IN 28, PL 27, AU 20, TR 20 = 617 (70.0%); | Top-10 volume | Other 60 storefronts ; n | 617 (70.0%) | 265 (30.0%) ; Mean | 4.60 | 4.47 ; 1–2★ | 5.7% | 9.4% ; Habit-cap complaint | 2.4% | 4.5% ; Paid-but-broken Pro | 0.8% | 1.1% ; Design praise | 37.8% | 27.2% ; Charts/stats praise | 5.8% | 1.9%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R07-114 — Sub-50 notes [limited evidence]: FR (n=30) 86.7% 5★ but both 1★s are paywall/usability and the 2★ is the weekly-goal misunderstanding; BR (n=29) has the biggest store-vs-written gap of any storefront (4.882 vs 4.41), 4 of the 54 sync requests and one entitlement failure; CN unserved

- **Where:** §7.4 Sub-50 storefronts — limited-evidence notes
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 66 storefronts < 50 hold 419 reviews (47.5%); FR 30; BR 29; CN 4
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `10100430683`, `12091523105`, `13187090517`, `13430341774`
- **Canonical:** — (nuance register)

### R07-128 — Review Canadian and emerging-market pricing — regional lifetime pricing, or lead with the $12/year SKU in price-sensitive storefronts

- **Where:** Part 9 #8 Review Canadian and emerging-market pricing
- **This app does:** one price ladder; CA$40
- **User reaction:** complaint
- **Magnitude:** CA worst eligible market; cap complaints 4.2% vs 2.3% outside high-spend
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-110, R07-112
- **Canonical:** C092 Regional pricing

### R07-138 — Localise the listing, starting with Chinese and German

- **Where:** Part 9 #19 Localise the listing, starting with Chinese and German
- **This app does:** EN-only listing
- **User reaction:** blocked-conversion
- **Magnitude:** DE 12.1% of corpus; CN cannot buy
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-048, R07-084
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R07-004 — The rating falls across four annual cohorts on healthy samples: 1★ rate multiplied ~5.8× (1.4% → 8.1%) and 5★ fell 13.3 points — a consistent trend, not noise

- **Where:** Part 0 §1 cohort table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Period | n | Mean | 5★ | 1★ ; P1 — Nov 2022 → Dec 2023 | 142 | 4.79 | 88.0% | 1.4% ; P2 — 2024 | 234 | 4.66 | 80.3% | 1.7% ; P3 — 2025 | 308 | 4.47 | 75.0% | 6.2% ; P4 — 2026 (Jan–Sep) | 198 | 4.42 | 74.7% | 8.1%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-024 — A late-2026 redesign produced the app's first design backlash, a tight dated cluster: 'the latest redesign of the 5-day screen does not work… I'm going to hunt for an alternative app'; 'not what I paid £29.99 for… Why is everything bigger?'; 'the compact view isn't very compact anymore'; 'Liked it better with words' — three of five quoted are payers; [external] 1.16.0 'A refreshed look', 1.17.1 compact-list changes; balanced by 'Love the new look'; 3 weeks old — watch, don't over-read

- **Where:** Part 0 §9 (A late-2026 UI redesign is producing the app's first design backlash); Part 4 #21; §8.3; Part 9 #3
- **This app does:** shipped refreshed look + compact-list changes Aug 2026
- **User reaction:** 1★-burst
- **Magnitude:** 7 (0.79%, EMERGING), mean 2.43, 57.1% 1–2★; 6 of 7 dated Aug 2026+; 0.00% → 0.43% → 0.00% → 3.03%; paid cohort 3 of 7 (42.9%); both GB instances are payers
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Side effects:** repro: iPhone 14 with display zoom + large text; fix with a text-size / density option or an opt-out
- **Review IDs:** `14447636722`, `14452015607`, `14452046441`, `14462152671`, `14488967268`, `14467718205`
- **Canonical:** C119 Updates must not regress layout or lose progress

### R07-025 — Prices reviewers actually report: monthly ≈ $2 / £1.99, yearly ≈ $12–13, lifetime ≈ $30 / €35 / £29.99; the lifetime price roughly doubled between Dec 2022 ($15) and late 2024 (€35)

- **Where:** Part 1 intro; §1.1 The model, reconstructed from the corpus + listing — prices table (verbatim)
- **This app does:** free download; Pro = monthly / yearly subscription OR one-time lifetime; no ads; no account; local-only data
- **User reaction:** mixed
- **Magnitude:** 212 reviews (24.04%) touch money; Date | Review | Storefront | Reported price ; Dec 2022 | `9410648676` | US | lifetime "just 15 bucks" ; Apr 2024 | `11174986923` | JP | ¥100/month, ~¥600/year ; Jul 2024 | `11526306665` | US | "$0.99" (monthly) ; Jul 2024 | `11530931211` | CA | "$20" (lifetime) ; Oct–Nov 2024 | `11818567731` `11942193233` `11994502139` | DE | €35 lifetime (three independent reports) ; Dec 2024 | `12076054585` | CA | CA$40 (~US$30) lifetime ; Dec 2024 | `12032382845` | US | $2/month ; Jan 2025 | `12163780356` | US | "$30 … for a year" ; Mar 2025 | `12481828605` | GB | £1.99/month ; Apr 2025 | `12533700383` | NL | "30 euros" ; Oct 2025 | `13275907556` | US | $2/mo, $30 lifetime ; Jan 2026 | `13596249635` | US | $2/mo, $12/year ; Jan 2026 | `13621381288` | US | "$13 pro" ; May 2026 | `14093446153` | DE | €35 (widgets behind it) ; Aug 2026 | `14452015607` `14374370548` `14463193980` | GB/DE/US | £29.99 · €35 einmalkauf · $30 lifetime
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `9410648676`, `11174986923`, `11526306665`, `11530931211`, `11818567731`, `11942193233`, `11994502139`, `12076054585`, `12032382845`, `12163780356`, `12481828605`, `12533700383`, `13275907556`, `13596249635`, `13621381288`, `14093446153`, `14452015607`, `14374370548`, `14463193980`
- **Canonical:** — (nuance register)

### R07-101 — Quit-habit mode: requested from 2024, rising to 2.53% of P4, shipped in 1.17.0 and immediately validated — 'The quit option work surprisingly well… I'm more motivated because I don't have to open the app to log a missed day'; sobriety users already used the app ('tried multiple apps to motivate me to have alcohol-free days, this is the only one that's worked')

- **Where:** Part 5 Sobriety / consumption reduction; Part 6 #11; §8.2 Quit-habit mode
- **This app does:** shipped quit-habit mode Aug 2026
- **User reaction:** praise
- **Magnitude:** Wants bad-habit / quit mode 11 (1.25%, MEANINGFUL), mean 4.00, 27.3% 1–2★; 0.00% → 0.43% → 1.62% → 2.53%; paid cohort 4 of 11 (36.4%)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11762071060`, `14470496356`, `11351318921`, `9466333479`, `10417971167`
- **Canonical:** C019 Quit-habit / bad-habit mode

### R07-116 — Interactive widgets are a clean closed loop: requests to tick a habit from the widget ran Dec 2023 → Jun 2024 then stopped dead once changelog 1.7 'Tappable widgets' shipped — 'Finally added interactivity with the widgets'; 'Since the update the widget works as it should and that makes this the best habit tracker I found'; a reviewer edited his review up to 5★; zero requests after Oct 2025 — proof the team can close a loop

- **Where:** §8.2 Themes that genuinely improved — interactive widgets
- **This app does:** shipped tappable widgets (1.7), Jun 2024
- **User reaction:** praise
- **Magnitude:** widget praise 7.04% (P1) → 14.10% (P2) → 9.09% (P3) → 6.57% (P4); 8 requests Dec 2023–Jun 2024, 0 after Oct 2025
- **Direction for us:** build-free · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `10685338852`, `10690084425`, `10786717280`, `10809321944`, `10854549103`, `10899303798`, `11309161661`, `11426923525`, `11393534582`, `11434680073`
- **Canonical:** C023 Interactive widget check-off; C059 Be visibly responsive; fixes bring reviewers back

### R07-117 — Worsened / emerged by cohort: 1★ rate, subscription objection, explicit payers, paid-but-broken, redesign, quit requests, price objection, simplicity praise, design praise

- **Where:** §8.3 Themes that worsened or emerged table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | P1 | P2 | P3 | P4 | Read ; 1★ rate | 1.4% | 1.7% | 6.2% | 8.1% | The headline ; Subscription objection | 4.93% | 5.13% | 6.17% | 8.59% | Steadily rising ; Explicit payers | 2.11% | 7.26% | 9.74% | 12.63% | Buyer base growing ; Paid-but-broken Pro | 0.00% | 0.00% | 1.62% | 1.52% | Emerged in 2025, still open Sep 2026 ; Redesign complaints | 0.00% | 0.43% | 0.00% | 3.03% | All but one in Aug 2026 ; Bad-habit/quit requests | 0.00% | 0.43% | 1.62% | 2.53% | Rose until shipped ; Price objection | 0.00% | 2.99% | 0.65% | 3.03% | Two peaks — both after lifetime price rises ; Simplicity praise | 41.55% | 41.45% | 39.61% | 29.29% | Down 12 points — the app is getting less simple ; Design praise | 47.89% | 30.77% | 34.09% | 30.30% | Down from launch high
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-118 — The simplicity story is fading — the classic feature-creep signature: named by 41.5% of reviewers in 2022–24 and 29.3% in 2026, across the period in which categories, day notes, quit habits, custom values, three view modes and a redesign all shipped; reviewers are already policing it — 'Please, don't clutter it with pointless features and distracting buttons… It's a finished product. And for those who want more of everything — just make them a separate version'; 'Please keep it simple as it is right now'

- **Where:** §8.3 The simplicity story is fading; Part 9 #16
- **This app does:** shipped categories, notes, quit habits, custom values, 3 view modes, redesign
- **User reaction:** complaint
- **Magnitude:** simplicity praise 41.55% → 41.45% → 39.61% → 29.29% (−12 points); design praise 47.89% → 30.77% → 34.09% → 30.30%
- **Direction for us:** product-rule · **Report confidence:** high-priority theme in decline · **Generalisable:** yes
- **Review IDs:** `13860278748`, `14193781102`, `10915115990`, `12166781464`
- **Canonical:** C006 Stay minimal and ad-free

### R07-120 — The persistent four — no sync (3y 4m, 54), 4-habit cap (3y 7m, 27), widgets behind paywall (2y 5m, 13), weekly-goal discoverability (3y, 17) — all still producing reviews in the last 60 days of the corpus

- **Where:** §8.4 The persistent four — unfixed across the entire life of the app table (verbatim)
- **This app does:** none fixed
- **User reaction:** complaint
- **Magnitude:** Theme | First seen | Last seen | Span | Total ; No cross-device sync | `9806367856` (KZ, 10 Apr 2023) | `14378210199` (ES, 2 Aug 2026) | 3y 4m | 54 ; 4-habit free cap | `9589360229` (PL, 6 Feb 2023) | `14463193980` (US, 23 Aug 2026) | 3y 7m | 27 ; Widgets behind paywall | `10771302089` (AU, 1 Jan 2024) | `14093446153` (DE, 22 May 2026) | 2y 5m | 13 ; Weekly-goal discoverability | `10266075296` (GB, 16 Aug 2023) | `14489689059` (GB, 30 Aug 2026) | 3y | 17
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `9806367856`, `14378210199`, `9589360229`, `14463193980`, `10771302089`, `14093446153`, `10266075296`, `14489689059`
- **Canonical:** — (nuance register)

## Positioning

### R07-001 — Habit Tracker — HabitKit (App Store ID 6443918070) is a solo-indie GitHub-contribution-grid habit tracker: no ads, no account, local-only data, Pro sold as monthly/yearly subscription OR one-time lifetime; 882 written reviews at mean 4.562 — the healthiest product in the set

- **Where:** header lines 1-8
- **This app does:** developer Sebastian Roehl (solo indie); bundle com.roehl.habitkit; Productivity; 4+; English-only listing (app itself supports 15+ languages); store rank 7 in this set
- **User reaction:** praise
- **Magnitude:** 882 reviews, 70 storefronts, 27 Nov 2022 → 6 Sep 2026; 5★ 692 (78.46%) · 4★ 95 (10.77%) · 3★ 35 (3.97%) · 2★ 19 (2.15%) · 1★ 41 (4.65%); US store 4.852 on 2,405 ratings
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-022 — Switchers are the purest positive signal in the corpus: people who explicitly tried multiple competitors and chose HabitKit — named losers Atoms/James Clear, Habitify, Productive, Notion, Todoist, HabitMate, superhabit — 'Many of the others (even Atoms from James Clear) is over complicated and almost… distracting'

- **Where:** Part 0 §7 tried multiple competitors and switched; Part 3 #4
- **This app does:** simplest in the category
- **User reaction:** praise
- **Magnitude:** 126 (14.29%), mean 4.96, 96.0% 5★, zero 1–2★; US 19.4%
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12134207623`
- **Canonical:** C005 Know which competitors buyers compare against; C006 Stay minimal and ad-free

### R07-043 — An explicit competitive churn at a stated price point: '35€ for lifetime access for (essentially) an automated excel sheet was just too much… I found a great habit tracker app for 6.99€ (lifetime)' — a simple utility is benchmarked against cheap lifetime competitors

- **Where:** §1.4 an explicit competitive churn at a stated price point
- **This app does:** €35 lifetime
- **User reaction:** churn
- **Magnitude:** 1 (3★, DE) — the only reviewer who names a competitor's price and switches
- **Direction for us:** research · **Report confidence:** quoted (n = 1) · **Generalisable:** yes
- **Review IDs:** `11942193233`
- **Canonical:** C005 Know which competitors buyers compare against; C064 Price level — where 'fair' turns into 'too expensive'

### R07-068 — Where HabitKit loses users to competitors: HabitMate 'does it too but with more features' (2★), superhabit has a calendar view HabitKit lacked, HabitShare has real accountability-partner features, and a user churned to Tiimo after data loss

- **Where:** §3.4 against HabitKit rows
- **This app does:** minimal feature set; no social; local-only
- **User reaction:** churn
- **Magnitude:** 4 reviews against (IT 2★, GB 4★, KR 4★, MX 1★)
- **Direction for us:** research · **Report confidence:** limited · **Generalisable:** yes
- **Review IDs:** `11713771657`, `10933253113`, `9901846846`, `13499288017`
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R07-014 — An offline-first app gated its widget on a live network entitlement check: the developer's FAQ tells affected users to 'disable VPN/DNS filters' and email an 'RC ID' (RevenueCat) — and the failures are 4× more common outside high-spend markets (PH, UA, BR, PL, MM), where those network conditions are likelier; cache entitlement locally and render the widget optimistically from the last-known-good receipt

- **Where:** Part 0 §4 [external] FAQ; §7.2 finding 2; Part 9 #1
- **This app does:** widget extension blocks on RevenueCat network check
- **User reaction:** 1★-burst
- **Magnitude:** paid-but-broken 1.7% outside high-spend vs 0.4% inside (4×)
- **Direction for us:** must-never-break · **Report confidence:** highest severity · **Generalisable:** yes
- **Side effects:** a serviceability bug with a geographic distribution
- **Review IDs:** `13430341774`, `13105035694`, `12836329335`, `13693601586`, `14351190258`
- **Canonical:** C139 Cache entitlements locally — never block a paid surface on a live server check; C033 Restore purchase and entitlements must work immediately

### R07-015 — Creator content is driving purchases against features the app does not have: a user bought an annual plan to get a lock-screen widget seen on YouTube — it does not exist

- **Where:** Part 0 §4 12450937418; Part 4 #31 No lock-screen widget; Part 9 #20
- **This app does:** no lock-screen widget
- **User reaction:** complaint
- **Magnitude:** 1 (2★, IN, 22 Mar 2025); No lock-screen widget 2 (0.23%), mean 4.50
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Side effects:** worth a creator brief so videos show what actually ships
- **Review IDs:** `12450937418`
- **Canonical:** C114 Ads must match the app

## Things not to do

### R07-094 — Adding AI to this app would be arguing with its own fanbase: users praise the absence — 'without adding AI bloatware'; 'not based around some opaque cloudy AI nonsense' — and only one proposes adaptive scheduling / natural-language logging

- **Where:** §4.5 No AI backlash and almost no AI demand
- **This app does:** no AI
- **User reaction:** praise
- **Magnitude:** 2 praise the absence, 1 request
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13891792959`, `14450302981`, `13177753546`
- **Canonical:** C056 Don't build AI features on demand grounds

### R07-130 — Do NOT add upsell pressure to solve conversion — multiple 5★ reviews name the absence of nagging as the reason they stayed and paid; giving it up trades a durable asset for a short-term lift

- **Where:** Part 9 #10 Do NOT add upsell pressure to solve conversion
- **This app does:** light upsell
- **User reaction:** praise
- **Magnitude:** only 8 nagging complaints
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-051
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

## Things to do

### R07-084 — Localise the store listing, starting with Chinese and German: the listing is English-only while the app itself supports 15+ languages (changelog 1.2, 1.14, 1.17.2) — DE is 12.1% of the corpus and CN cannot even buy

- **Where:** Part 4 #28 Localization gaps; Part 9 #19
- **This app does:** EN-only listing, localised app
- **User reaction:** blocked-conversion
- **Magnitude:** Localization gaps 4 (0.45%, Weak), mean 4.50; DE 107 reviews (12.1%); CN 4
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `11183018670`, `11385868721`
- **Canonical:** C027 Localise early — it unlocks revenue

### R07-136 — Say 'ADHD' and 'no-guilt tracking' in the store listing — ADHD reviewers rate 5.00 across all 13 and the no-shaming property appears nowhere in the listing

- **Where:** Part 9 Positioning — free rating and revenue, no engineering #17 Say 'ADHD' and 'no-guilt tracking' in the store listing
- **This app does:** listing silent on both
- **User reaction:** praise
- **Magnitude:** ADHD 13 at 5.00; no-guilt 6 at 5.00
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-064, R07-065
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C095 Neutral, non-judgemental tone on failure; C134 Lead the store listing with what users actually love

### R07-137 — Market the generic-tracker use case — the listing ('form new habits or break old ones') is narrower than what users do

- **Where:** Part 9 #18 Market the generic-tracker use case
- **This app does:** listing narrow
- **User reaction:** praise
- **Magnitude:** 11 reviews, mean 4.91
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R07-066
- **Canonical:** C140 Market the generic-tracker use case; C134 Lead the store listing with what users actually love

### R07-139 — Lean into the YouTube / Threads discovery channel with a creator brief — discovery is named via YouTube (incl. 'The Studio' channel, also cited on the marketing site), Threads, Twitter, LinkedIn and Product Hunt, and one video drove an annual purchase for a lock-screen widget that does not exist

- **Where:** Part 9 #20 Lean into the YouTube/Threads discovery channel
- **This app does:** organic creator coverage, no brief
- **User reaction:** purchase-driver
- **Magnitude:** 12 discovery mentions
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `12898756160`, `12949502025`, `13053618099`, `14516845857`, `11877901803`, `11039862982`, `10984473093`, `9980285580`, `12450937418`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C114 Ads must match the app

## Contradictions

### R07-008 — A cap held perfectly stable for 3½ years was still the top 2★ theme — stability alone does not rescue a cap set too low; this qualifies the 'never change the cap' rule from earlier reports (stable AND high enough)

- **Where:** Part 0 §2 3½-year-old constraint that has never been revisited
- **This app does:** 4-habit cap unchanged since Feb 2023
- **User reaction:** churn
- **Magnitude:** 18 dated confirmations over 3½ years; still producing reviews in the last 60 days
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Conditions:** contrast report 1 (a drifting cap angered users) and report 6 (a 1 → 2 raise did not help)
- **Review IDs:** `9589360229`, `14463193980`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R07-038 — Widgets behind the paywall both sell and repel: 8 buyers name them as the reason to pay (mean 4.88) while 13 object (mean 2.23, zero 5★) — the report resolves it with one free widget and more with Pro, which keeps a paid layer without gating the category

- **Where:** §1.3b vs §0.3 widget paywall
- **This app does:** all widgets Pro
- **User reaction:** mixed
- **Magnitude:** 8 triggers at 4.88 vs 13 objections at 2.23 (0% 5★)
- **Direction for us:** build-free · **Report confidence:** resolved by recommendation · **Generalisable:** yes
- **Conditions:** contrast report 3, where widget variants were the #1 purchase trigger with the base widget free
- **Review IDs:** `12622891075`, `13198372302`, `13905806444`
- **Canonical:** C009 Basic widgets, icons and colours are free; C107 Widget variants and customisation as the paid layer

### R07-072 — No account and local-only storage cut both ways: they eliminate privacy complaints and are praised, and they cause the #1 product gap (no sync, 54) and the data-loss churn (5) — the report's resolution is sync shipped opt-in, end-to-end, on the CloudKit private database, with no account

- **Where:** §4.5 privacy posture vs §0.5 sync gap and data loss; Part 9 #11 'Do it without breaking the privacy promise'
- **This app does:** no account, local-only
- **User reaction:** mixed
- **Magnitude:** 0 privacy accusations; 7 privacy praise; 54 sync requests at 3.85; 5 data-loss at 2.20
- **Direction for us:** build-paid · **Report confidence:** resolved by recommendation · **Generalisable:** yes
- **Conditions:** contradicts 'account system from day one' (report 1) as the only fix: iCloud-based sync can deliver continuity without an account
- **Review IDs:** `11241317063`, `13499288017`
- **Canonical:** C035 Account system from day one; C013 Cloud sync / multi-device as the paid differentiator; C096 Privacy and discretion stack

### R07-095 — Unlike apps 3, 5 and 6 in this set, nobody claims they were charged an amount they did not agree to — HabitKit's paid failures are the opposite problem: charged correctly, not delivered

- **Where:** §4.5 No billing-fraud or surprise-charge accusations
- **This app does:** no trial-to-charge or quote/charge issues
- **User reaction:** none
- **Magnitude:** 0 billing-fraud accusations vs 8 entitlement failures
- **Direction for us:** none · **Report confidence:** absence · **Generalisable:** yes
- **Conditions:** billing correctness and entitlement delivery are two separate must-never-break checks
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately

## Data caveats and method

### R07-002 — Method: denominator 882, non-exclusive themes, signal bands on global share and separately per eligible country; only US (211), DE (107), GB (89), CA (56) clear 50; [external] facts never mixed into corpus %; hybrid classification — broad praise themes by multilingual regex (±3–5% relative error), every high-stakes theme and the paid cohort hand-curated from ID lists (small-n themes are floors); paid cohort audited (14 regex false positives removed, 15 added, intent excluded, 10 'inferred-only' held out); no version field so release attributions come from the undated public changelog; 178 non-English reviews read in-language; Sep 2026 partial; survivor bias in paid cohort; in-app prompt timing unknown

- **Where:** How to read this; Part 10 method (skimmed)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 882 records, 0 duplicates, 70 by_country files reconcile; 60 themes; bands <0.1% ignore, 0.1–0.5% weak, 0.5–1% emerging, 1–3% meaningful, 3–5% very strong, >5% high-priority
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R07-013 — The eight paid-but-not-delivered cases, by country, rating and date

- **Where:** Part 0 §4 table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** ID | Country | ★ | Date | What happened ; `12836329335` | PH | 5 | 2025-06-30 | Bought Pro, widget still says "Upgrade to HabitKit Pro" ; `13105035694` | UA | 2 | 2025-09-06 | Pro from phone does not carry to macOS ; `13398478371` | US | 5 | 2025-11-14 | Bought lifetime, widget not unlocking ; `13430341774` | BR | 1 | 2025-11-23 | Bought Pro, widgets blurred with upgrade prompt — "Edit: not fixed yet" ; `13693601586` | PL | 1 | 2026-01-30 | Purchased Pro for widget; still not working ; `14351190258` | MM | 1 | 2026-07-26 | Paid annual; "Something went wrong" on restore; could not find support ; `14519062888` | US | 1 | 2026-09-06 | Subscribed; widget shows "subscribe to Pro" for several minutes daily ; `12450937418` | IN | 2 | 2025-03-22 | Bought annual to get a lock-screen widget seen on YouTube; it does not exist
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `12836329335`, `13105035694`, `13398478371`, `13430341774`, `13693601586`, `14351190258`, `14519062888`, `12450937418`
- **Canonical:** — (nuance register)

### R07-023 — Written reviews run below tap-only ratings in all eight storefronts checked — tap ratings are collected in-app at a moment of satisfaction; the written corpus is the leading indicator, and it says 4.42 for 2026

- **Where:** Part 0 §8 (The public rating is 0.24–0.44 stars higher than what people write) table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | Store rating (all ratings) | Store rating count | This corpus (written only) | n | Gap ; US | 4.852 | 2,405 | 4.61 | 211 | −0.24 ; DE | 4.823 | 747 | 4.69 | 107 | −0.13 ; GB | 4.757 | 756 | 4.69 | 89 | −0.07 ; CA | 4.791 | 470 | 4.50 | 56 | −0.29 ; FR | 4.754 | 293 | 4.57 | 30 | −0.18 ; BR | 4.882 | 382 | 4.41 | 29 | −0.47 ; IN | 4.753 | 348 | 4.68 | 28 | −0.07 ; PL | 4.815 | 297 | 4.48 | 27 | −0.34
- **Direction for us:** do · **Report confidence:** observed · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R07-027 — Free/paid split as reviewers experience it: 4 habits, calendar, archive, streaks, one reminder, categories, Shortcuts, backfill free; unlimited habits, widgets, charts & statistics, export/import, compact-list configuration, 2nd/3rd reminder Pro; no ads for everyone

- **Where:** §1.1 Free / paid split as reviewers experience it table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Status in reviews | Evidence ; Up to 4 habits | Free (stable Feb 2023 → Aug 2026) | 15 dated confirmations ; Unlimited habits | Pro | `12313286063` `14374370548` `13779234074` ; Home-screen widgets | Pro | `10771302089` `12760644253` `13018758207` `13905806444` ; Charts & statistics | Pro | `12183236954` `13059439732` `11031287982` ; Data export / import | Pro (disputed as a rights issue) | `11530931211` `13904375498` ; Compact-list configuration | Pro [external, changelog 1.13] | — ; 2nd/3rd reminder per habit | Pro [external, changelog 1.14] | — ; Calendar, archive, streaks, reminders(1), categories, Shortcuts, backfill | Free | `13188634050` `13680396177` `12336116396` ; No ads | Free and paid alike | 7 reviews, all 5★
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `12313286063`, `14374370548`, `13779234074`, `10771302089`, `12760644253`, `13018758207`, `13905806444`, `12183236954`, `13059439732`, `11031287982`, `11530931211`, `13904375498`, `13188634050`, `13680396177`, `12336116396`
- **Canonical:** — (nuance register)

### R07-032 — Explicit-paid cohort vs rest of corpus (first-person purchase statements only; 10 inferred-only excluded)

- **Where:** §1.2 The explicit-paid cohort — 75 reviewers (8.50%) table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | Paid cohort (n=75) | Rest of corpus (n=807) ; Mean rating | 4.16 | 4.60 ; 5★ | 64.0% | 79.8% ; 1–2★ | 17.3% | 5.8% ; distribution 5★ 48 · 4★ 11 · 3★ 3 · 2★ 6 · 1★ 7; US 28, DE 8, CA 7, GB 5; by year 2023 3 (2.11%) · 2024 17 (7.26%) · 2025 30 (9.74%) · 2026 25 (12.63%)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-034 — Paid-cohort over-indexes against an 8.5% baseline: pro_entitlement_broken 100%, bug_reported 43.8%, subscription_objection 40.0%, redesign_complaint 42.9%, praise_onetime_price 35.6%

- **Where:** §1.2 What paying reviewers over-index on table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | In paid cohort | Of that theme overall | Baseline is 8.5% ; `pro_entitlement_broken` | 8 | 100.0% of 8 | catastrophic ; `bug_reported` | 7 | 43.8% of 16 | payers hit and report bugs ; `subscription_objection` | 22 | 40.0% of 55 | payers hate subs *and paid anyway* ; `redesign_complaint` | 3 | 42.9% of 7 | ; `praise_onetime_price` | 16 | 35.6% of 45 | the lifetime SKU is why they bought ; `praise_price_fair` | 15 | 29.4% of 51 | ; `price_objection` | 4 | 26.7% of 15 | bought and still resent it ; `want_bad_quit_habit` | 4 | 36.4% of 11 |
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-052 — 5★ themes: simplicity 43.6%, design 37.1%, developer 17.9%, tried-many 17.5%, widgets 9.5%, customization 9.0%, grid 8.5%, fair price 6.9%, life change 5.5%, one-time purchase 5.1%

- **Where:** Part 2 5★ — n = 692 (78.46%) table (verbatim)
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** Theme | n in band | % of 5★ ; Simplicity / no bloat | 302 | 43.6% ; Design / visual | 257 | 37.1% ; Developer / indie support | 124 | 17.9% ; Tried many, chose this | 121 | 17.5% ; Widgets (positive) | 66 | 9.5% ; Grid / GitHub heat-map | 59 | 8.5% ; Customization | 62 | 9.0% ; Price is fair | 48 | 6.9% ; Life change / "best app" | 38 | 5.5% ; One-time purchase option | 35 | 5.1%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-054 — A 5★ is not evidence the product is complete: 18 of the 692 five-star reviews still ask for sync and 2 are people whose Pro purchase is broken

- **Where:** Part 2 5★ A 5★ here is not evidence the product is complete
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 18 of 692 5★ want sync; 2 of 692 paid-but-broken
- **Direction for us:** none · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `12836329335`, `13398478371`
- **Canonical:** — (nuance register)

### R07-055 — 4★ themes: wants sync 18.9%, design praise 38.9%, simplicity 25.3%, widget praise 13.7%, iPad 8.4%, weekly goals 8.4%, paywall 8.4%, Watch 6.3%, cap 6.3%

- **Where:** Part 2 4★ — n = 95 (10.77%) — the 'one missing thing' band table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 4★ ; Wants sync | 18 | 18.9% ; Design praise | 37 | 38.9% ; Simplicity praise | 24 | 25.3% ; Widget praise | 13 | 13.7% ; Wants iPad app | 8 | 8.4% ; Wants weekly/flexible goals | 8 | 8.4% ; Paywall (general) | 8 | 8.4% ; Wants Apple Watch | 6 | 6.3% ; Habit cap | 6 | 6.3%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-059 — 1★ causes: paywall/price/free cap 51.2%, paid but Pro doesn't work 9.8%, data loss / won't load 9.8%, missing platform or feature 9.8%, confusing 7.3%, redesign 4.9%, content-free 4.9%, wrong app 2.4% — more than half of all one-star reviews are a pricing-and-packaging decision

- **Where:** Part 2 1★ — n = 41 (4.65%) — money, then broken purchases, then everything else table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Cause | n | % of 1★ ; Paywall / price / free cap | 21 | 51.2% ; Paid but Pro doesn't work | 4 | 9.8% ; Data loss / app won't load | 4 | 9.8% ; Missing platform or feature (Watch, notifications, bad habits) | 4 | 9.8% ; Confusing / overwhelming | 3 | 7.3% ; Redesign regression | 2 | 4.9% ; Content-free ("this app sucks") | 2 | 4.9% ; Wrong app / mis-download | 1 | 2.4%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-060 — Nineteen praise themes with n, %, mean, 5★% and signal

- **Where:** Part 3 WHAT PEOPLE PRAISE (full table) (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** # | Theme | n | % | Mean | 5★% | Signal ; 1 | Simplicity / minimalism / no bloat | 336 | 38.10% | 4.86 | 89.9% | HIGH-PRIORITY ; 2 | Design / visual appeal / UI-UX | 305 | 34.58% | 4.78 | 84.3% | HIGH-PRIORITY ; 3 | Developer responsiveness / indie | 133 | 15.08% | 4.85 | 93.2% | HIGH-PRIORITY ; 4 | Tried many apps, chose this | 126 | 14.29% | 4.96 | 96.0% | HIGH-PRIORITY ; 5 | Widgets (positive only) | 84 | 9.52% | 4.69 | 78.6% | HIGH-PRIORITY ; 6 | Customization (colours/icons/emoji) | 78 | 8.84% | 4.72 | 79.5% | HIGH-PRIORITY ; 7 | Grid / GitHub heat-map metaphor | 73 | 8.28% | 4.73 | 80.8% | HIGH-PRIORITY ; 8 | Price is fair / good value | 51 | 5.78% | 4.94 | 94.1% | HIGH-PRIORITY ; 9 | One-time / lifetime purchase exists | 45 | 5.10% | 4.71 | 77.8% | HIGH-PRIORITY ; 10 | Charts & statistics | 41 | 4.65% | 4.59 | 78.0% | VERY STRONG ; 11 | Life-changing / best app I own | 38 | 4.31% | 5.00 | 100% | VERY STRONG ; 12 | Free tier is generous | 25 | 2.83% | 4.52 | 80.0% | MEANINGFUL ; 13 | ADHD / autism / executive function fit | 13 | 1.47% | 5.00 | 100% | MEANINGFUL ; 14 | Shortcuts / Siri / NFC automation | 13 | 1.47% | 4.77 | 84.6% | MEANINGFUL ; 15 | Used for non-habit tracking | 11 | 1.25% | 4.91 | 90.9% | MEANINGFUL ; 16 | Reliability / "no bugs" / never crashes | 8 | 0.91% | 5.00 | 100% | EMERGING ; 17 | No ads | 7 | 0.79% | 5.00 | 100% | EMERGING ; 18 | Privacy / local data / no account | 7 | 0.79% | 4.71 | 71.4% | EMERGING ; 19 | Non-judgmental / no guilt / your pace | 6 | 0.68% | 5.00 | 100% | EMERGING
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-067 — Named competitors and switching reasons — for HabitKit: Atoms, Habitify, Productive, Notion, Todoist; against: HabitMate, superhabit, HabitShare, Tiimo

- **Where:** §3.4 Competitors reviewers name, and why they left them table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Named app | Reviews | Stated reason for switching to HabitKit ; Atoms (James Clear) | `12134207623` `13596249635` | "over complicated and almost… distracting"; "better than Atoms" ; Habitify, Productive | `12025027893` | "pared down compared to other similar apps… quick and easy" ; Notion | `11040398420` `12015479550` | no long-term history; not simple ; Todoist | `12934585259` | "way better than todoist" ; HabitMate | `11713771657`(IT,2★) | against HabitKit — "lo fa anche HabitMate ma con più funzioni" ; superhabit | `10933253113`(GB,4★) | against — has a calendar view HabitKit lacked ; HabitShare | `9901846846`(KR,4★) | against — has real accountability-partner features ; Tiimo | `13499288017`(MX,1★) | against — churned to it after data loss
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `12134207623`, `13596249635`, `12025027893`, `11040398420`, `12015479550`, `12934585259`, `11713771657`, `10933253113`, `9901846846`, `13499288017`
- **Canonical:** — (nuance register)

### R07-073 — Thirty-four complaint / unmet-need themes with n, %, mean, 1–2★% and signal

- **Where:** Part 4 COMPLAINTS AND UNMET NEEDS (full table) (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** # | Theme | n | % | Mean | 1–2★% | Signal ; 1 | No cross-device / iCloud sync | 54 | 6.12% | 3.85 | 13.0% | HIGH-PRIORITY ; 2 | Subscription objection (all valences) | 55 | 6.24% | 3.84 | 27.3% | HIGH-PRIORITY ; 3 | Paywall generally blocks use | 31 | 3.51% | 3.06 | 38.7% | VERY STRONG ; 4 | 4-habit free cap | 27 | 3.06% | 2.56 | 55.6% | VERY STRONG ; 5 | No Apple Watch app | 20 | 2.27% | 4.15 | 15.0% | MEANINGFUL ; 6 | No native iPad app | 18 | 2.04% | 3.61 | 16.7% | MEANINGFUL ; 7 | Wants weekly / flexible / skip-day goals | 17 | 1.93% | 4.12 | 5.9% | MEANINGFUL ; 8 | Wants per-day notes | 16 | 1.81% | 4.81 | 0.0% | MEANINGFUL ; 9 | Bugs reported | 16 | 1.81% | 2.75 | 50.0% | MEANINGFUL ; 10 | Price too high | 15 | 1.70% | 2.73 | 46.7% | MEANINGFUL ; 11 | No Mac / web app | 15 | 1.70% | 3.87 | 20.0% | MEANINGFUL ; 12 | Widgets behind paywall | 13 | 1.47% | 2.23 | 53.8% | MEANINGFUL ; 13 | Wants more colours / icons | 13 | 1.47% | 4.38 | 7.7% | MEANINGFUL ; 14 | Setup / UI confusing | 13 | 1.47% | 2.92 | 46.2% | MEANINGFUL ; 15 | Wants bad-habit / quit mode | 11 | 1.25% | 4.00 | 27.3% | MEANINGFUL ; 16 | Wants multi-habit widget | 11 | 1.25% | 4.09 | 9.1% | MEANINGFUL ; 17 | Wants sub-habits / folders / pages | 11 | 1.25% | 4.82 | 0.0% | MEANINGFUL ; 18 | Stated churn to another app | 9 | 1.02% | 1.89 | 77.8% | MEANINGFUL ; 19 | Upsell nagging | 8 | 0.91% | 3.25 | 37.5% | EMERGING ; 20 | Paid but Pro doesn't unlock | 8 | 0.91% | 2.25 | 75.0% | EMERGING ; 21 | Recent redesign regression | 7 | 0.79% | 2.43 | 57.1% | EMERGING ; 22 | Wants trial before buying | 7 | 0.79% | 4.14 | 14.3% | EMERGING ; 23 | Notification problems / gaps | 6 | 0.68% | 2.67 | 50.0% | EMERGING ; 24 | Wants Health / Strava / Oura integration | 6 | 0.68% | 4.83 | 0.0% | EMERGING ; 25 | Wants multiple reminders per habit | 6 | 0.68% | 4.50 | 0.0% | EMERGING ; 26 | Data loss | 5 | 0.57% | 2.20 | 60.0% | EMERGING ; 27 | Streak maths confusing | 4 | 0.45% | 4.00 | 0.0% | Weak ; 28 | Localization gaps | 4 | 0.45% | 4.50 | 0.0% | Weak ; 29 | Wants custom day-boundary (not midnight) | 3 | 0.34% | 5.00 | 0.0% | Weak ; 30 | Wants "hide completed habits" | 3 | 0.34% | 4.33 | 0.0% | Weak ; 31 | No lock-screen widget | 2 | 0.23% | 4.50 | 0.0% | Weak ; 32 | No Family Sharing | 2 | 0.23% | 4.00 | 0.0% | Weak ; 33 | Export locked / GDPR objection | 2 | 0.23% | 1.00 | 100% | Weak ; 34 | Wants friend / accountability sharing | 2 | 0.23% | 4.50 | 0.0% | Weak
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R07-075 — Platform gaps ranked by rating damage: iPad 18 at 3.61, Mac/web 15 at 3.87, Apple Watch 20 at 4.15

- **Where:** §4.3 Platform gaps, ranked by rating damage table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Gap | n | Mean | Notes ; iPad (native layout) | 18 | 3.61 | Worst mean of the three. `13336507038`(PH,4★) *"on iPad the UI feels stretched and awkward"*; `13092058110`(ID,2★) churned over it ; Mac / web | 15 | 3.87 | Several found the iOS-app-on-Mac workaround themselves (`12403426948`,DE,5★; `12186579144`,DE,5★) ; Apple Watch | 20 | 4.15 | Highest volume, least rating damage — a *want*, not a blocker, except `12162624396`(AU,1★) and `13583765027`(US,1★)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13336507038`, `13092058110`, `12403426948`, `12186579144`, `12162624396`, `13583765027`
- **Canonical:** — (nuance register)

### R07-081 — Stated churn to another app is rare but the angriest group, concentrated in Canada

- **Where:** Part 4 #18 Stated churn to another app
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 9 (1.02%, MEANINGFUL), mean 1.89, 77.8% 1–2★; CA 3.6% (VERY STRONG) vs US 0.9%, DE 0.9%, GB 1.1%
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13499288017`
- **Canonical:** — (nuance register)

### R07-097 — Self-described segments: developers/technical, ADHD, ex-bullet-journallers, multi-habit power users, quantified-self, sobriety, non-habit trackers, religious practice

- **Where:** Part 5 WHO ACTUALLY USES THIS table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Segment | Evidence | Signal ; Developers / technical users — recognise the GitHub contribution graph on sight | `9336703919` `9452538229`(DE, *"If you're a developer, the whole thing feels very familiar from GitHub"*) `10422430745` `12072650756`(*"It is like GitHub of Habit"*) `12104725882`(spots the Flutter build) `13116845394` `13196795496`(an app developer himself) | The founding audience; 73 grid-metaphor mentions ; ADHD / neurodivergent adults | 13 reviews, all 5★ (§3.2) | Perfect-scoring, growing, unmarketed ; Ex-bullet-journallers | `10705970933` `11674324275` `12196979794`(DE, drew a pixel year-view by hand before) `13177753546` | Explains the year-grid attachment ; Multi-habit power users (10+) | `13621381288`(21 colours not enough for 10+ habits) `14089093879` `12958968819` `13422297301` | The paying segment; drives folders/colours/hide-completed asks ; Quantified-self / automation users | 13 Shortcuts/NFC reviews — `13244460118`(US,5★, hotel key cards as NFC triggers) `12336116396` `12183133631`(wants Strava/Oura/Duolingo) `14402619133` `13650913780`(wants a read-only API) `12934585259`(wants REST APIs) | Small, extremely loyal, mean 4.77 ; Sobriety / consumption reduction | `11351318921`(GB,5★, *"tried multiple apps to motivate me to have alcohol-free days, this is the only one that's worked"*) `9466333479` `13206904375`(water) `10417971167` | The quit-habit feature (1.17) serves this ; Non-habit trackers | 11 reviews (§3.3) | Unmarketed ; Religious practice | `13291634659`(US,5★, daily Bible reading) `13647254621`(DE,5★, asks for location-based Islamic prayer times, *"potenziell 2 Milliarden Kunden"*) | `[limited evidence, n=2]`
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `9336703919`, `9452538229`, `10422430745`, `12072650756`, `12104725882`, `13116845394`, `13196795496`, `10705970933`, `11674324275`, `12196979794`, `13621381288`, `14089093879`, `12958968819`, `13422297301`, `13244460118`, `11351318921`, `9466333479`, `13291634659`, `13647254621`
- **Canonical:** — (nuance register)

### R07-103 — Feature requests ranked by volume × rating headroom: sync, raise the cap, one free widget, iPad layout, Watch, findable weekly goals, day notes, colours, sub-habits, multi-habit widget, quit mode, integrations, extra reminders, day boundary, hide completed, API, Family Sharing, accountability partner

- **Where:** Part 6 WHAT THE FEATURE REQUESTS ACTUALLY SAY table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Rank | Request | n | Mean | What they actually want ; 1 | Cross-device sync | 54 | 3.85 | iCloud/CloudKit specifically. Several would pay more for it. Currently the #1 blocker on 3★/4★ ; 2 | Raise / rethink the free habit cap | 27 | 2.56 | Not "free everything" — several propose 6–8, or one free widget ; 3 | Free (or one-free) widget | 13 | 2.23 | `12622891075` proposes the exact model: one widget free, more with Pro ; 4 | Native iPad layout | 18 | 3.61 | Not a new app — a layout that isn't a stretched phone ; 5 | Apple Watch complication/app | 20 | 4.15 | Tick a habit from the wrist; several say they'd pay for it ; 6 | Make the existing weekly/monthly goals findable | 17 | 4.12 | See §4.2 — mostly a UI/onboarding fix, not new code ; 7 | Per-day notes | 16 | 4.81 | Shipped in 1.16 — verify and close ; 8 | More colours + a colour picker | 13 | 4.38 | 21 preset colours, 4 of them greys; breaks down past ~10 habits ; 9 | Sub-habits / folders / pages | 11 | 4.82 | The next step after categories, for 10+ habit users ; 10 | Multi-habit widget | 11 | 4.09 | [external] shipped in 1.15, yet 4 requests are dated 2026 — discoverability check needed ; 11 | Bad-habit / quit mode | 11 | 4.00 | Shipped in 1.17; `14470496356`(AU,5★, Aug 2026) confirms and praises it ; 12 | Health / Strava / Oura / Duolingo integration | 6 | 4.83 | `12139974588`(CA,4★) *"Would easily pay for the pro version if it had that"* ; 13 | 2nd/3rd reminder per habit at different times | 6 | 4.50 | [external] shipped 1.14 as a Pro feature ; 14 | Custom day boundary (4am, not midnight) | 3 | 5.00 | Night-shift and late-night users; all 5★, cheap fix ; 15 | Hide / reorder completed habits | 3 | 4.33 | Long-list users ; 16 | Read-only API / deep links | 3 | 5.00 | Power users; `13650913780` `12934585259` `12108952662` ; 17 | Family Sharing | 2 | 4.00 | Two lost/at-risk sales ; 18 | Friend visibility / accountability partner | 2 | 4.50 | `9901846846`(KR,4★) names HabitShare as the benchmark
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `12622891075`, `14470496356`, `12139974588`, `13650913780`, `12934585259`, `12108952662`, `9901846846`
- **Canonical:** — (nuance register)

### R07-115 — Time method: four comparable cohorts (P1 launch–Dec 2023 n=142, P2 2024 n=234, P3 2025 n=308, P4 Jan–Sep 2026 n=198); no app-version field so release attributions come from the public changelog and reviewers' dated statements; two January spikes (Jan 2025 n=71, Jan 2026 n=36) from New Year resolution seasonality; Sep 2026 partial (6 reviews)

- **Where:** §8.1 Method
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** P1 142 · P2 234 · P3 308 · P4 198; Jan 2025 71; Jan 2026 36; Sep 2026 6
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Side effects:** New Year produces the biggest review (and likely install) spikes in the category
- **Canonical:** — (nuance register)

### R07-140 — Research: the actual free → paid conversion rate is unknown — 75 self-declared payers out of 882 reviewers is a review-writing rate; never quote 8.5% as conversion

- **Where:** Part 9 Research questions — What is the actual free→paid conversion rate?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 75 / 882 = 8.5% (not conversion)
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R07-141 — Research: how many people hit the 4-habit cap and silently leave? The 27 complaints are a floor, not an estimate

- **Where:** Part 9 Research questions — How many people hit the 4-habit cap and silently leave?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 27 (floor)
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R07-142 — Research: would raising the cap to 8 reduce revenue? Untestable from reviews — needs an A/B test with cohort LTV

- **Where:** Part 9 Research questions — Would raising the cap to 8 reduce revenue?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R07-143 — Research: is the 2026 rating decline partly compositional? More payers write reviews each year (2.11% → 12.63%) and payers rate 0.44 lower, so some of the decline is mix, not deterioration — store-side cohort data would separate them

- **Where:** Part 9 Research questions — Is the P4 rating decline compositional?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** payers 2.11% → 12.63%; payer gap −0.44
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R07-144 — Research: how widespread is the entitlement failure among non-reviewers? 8 reviews is what surfaced — RevenueCat logs would give the true rate

- **Where:** Part 9 Research questions — How widespread is the entitlement failure among non-reviewers?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 8 (surfaced)
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R07-145 — Research: which SKU do buyers actually pick? Reviewers name lifetime far more than yearly, but review-writing is biased toward one-time purchasers who feel good about the transaction

- **Where:** Part 9 Research questions — Which SKU do buyers actually pick?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase
