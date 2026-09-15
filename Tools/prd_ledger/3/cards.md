# Cards — report 3

Source: `App Store Reports/3. Days Since - Quit Habit Tracker - Sober Streak Day Counter (REPORT).md`  
125 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 5
- [Must-haves](#must-haves) — 2
- [Must never break](#must-never-break) — 10
- [Features](#features) — 37
- [Monetization](#monetization) — 10
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 12
- [Audiences](#audiences) — 4
- [Markets and languages](#markets-and-languages) — 13
- [Dated events and trends](#dated-events-and-trends) — 12
- [Positioning](#positioning) — 4
- [Anti-patterns](#anti-patterns) — 3
- [Things not to do](#things-not-to-do) — 5
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 3

## Product rules

### R03-038 — Paywalling the widget was the single most expensive product decision visible in this dataset — 128 reviews, mean 2.48, and a full-quarter rating collapse

- **Where:** §1.7 #1
- **This app does:** paywalled the widget
- **User reaction:** 1★-burst
- **Magnitude:** 128 (1.21%), mean 2.48
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R03-003, R03-006, R03-008, R03-016
- **Canonical:** C001 Never move a free feature behind the paywall; C009 Basic widgets, icons and colours are free

### R03-101 — Never paywall the widget — it is the intervention, not a convenience; 26% of all 1★ reviews are about this one decision; if the widget must be monetised, monetise VARIANTS (multi-counter widgets, custom art, goal-progress rings) and keep a single-counter widget free forever

- **Where:** Part 8 #1
- **This app does:** paywalled the base widget
- **User reaction:** 1★-burst
- **Magnitude:** 26% of 1★; a full quarter's rating
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R03-008, R03-016; the 'monetise variants' rule reconciles with report 1 where widget customisation is a purchase driver
- **Canonical:** C009 Basic widgets, icons and colours are free; C107 Widget variants and customisation as the paid layer; C001 Never move a free feature behind the paywall

### R03-105 — Offer a cheap one-time purchase — 18 explicit requests, ~12 unsolicited offers to donate with no mechanism, and the most-quoted objection is subscription-as-principle, not amount: 'subscription fatigue is real'

- **Where:** Part 8 #5
- **This app does:** subscription-first, $49.99 lifetime
- **User reaction:** blocked-conversion
- **Magnitude:** 18 + ~12
- **Direction for us:** product-rule · **Report confidence:** weak count, clear principle · **Generalisable:** yes
- **Conditions:** evidence: R03-032, R03-033, R03-042
- **Review IDs:** `14060380344`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C097 A tip / donate option

### R03-119 — Keep the neutral, non-judgemental reset — the competitive differentiation against every 'sobriety coach' app is that this one doesn't talk

- **Where:** Part 8 #19
- **This app does:** no motivational copy, no shame on reset
- **User reaction:** praise
- **Magnitude:** 130 reviews praise it
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R03-056, R03-052
- **Canonical:** C095 Neutral, non-judgemental tone on failure

### R03-120 — Do not remove a feature users already have — the 2022 subscription launch was survivable because it ADDED a tier; the 2025 widget change was not, because it took something away: 'I just don't agree with taking away features that have been free for years'

- **Where:** Part 8 #20
- **This app does:** removed a free feature
- **User reaction:** 1★-burst
- **Magnitude:** two shocks compared: +3 pts 1–2★ recovered vs +7 pts not recovered
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R03-095, R03-096
- **Review IDs:** `12887257900`
- **Canonical:** C001 Never move a free feature behind the paywall

## Must-haves

### R03-102 — Ship iCloud sync and automatic backup, free — losing a 2-year sobriety streak on a phone upgrade is an unrecoverable brand event; 'Back up is literally PREMIUM?' is the line that will follow you

- **Where:** Part 8 #2
- **This app does:** backup paid
- **User reaction:** 1★-burst
- **Magnitude:** 44 reviews, 9 confirmed data losses
- **Direction for us:** build-free · **Report confidence:** high-priority (severity) · **Generalisable:** yes
- **Conditions:** evidence: R03-076
- **Review IDs:** `13629061971`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R03-118 — Protect the privacy stack as a headline feature — Face ID, no account, neutral name, alternate icons; 145 reviews, mean 4.90, zero negative; it is what makes the app usable by a 13-year-old tracking self-harm on a family phone

- **Where:** Part 8 #18
- **This app does:** privacy stack free
- **User reaction:** praise
- **Magnitude:** 145 (1.37%), mean 4.90, 0 1–2★
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R03-055, R03-080
- **Canonical:** C096 Privacy and discretion stack

## Must never break

### R03-031 — The worst case in the corpus: a Lifetime purchaser who did not receive the feature the purchase exists to unlock — still told to subscribe for widgets

- **Where:** §1.4 closing
- **This app does:** entitlement not honoured
- **User reaction:** 1★-burst
- **Magnitude:** 1 review, but the archetype of the entitlement failure
- **Direction for us:** must-never-break · **Report confidence:** single review, severe · **Generalisable:** yes
- **Review IDs:** `14060380344`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R03-039 — Not honouring entitlements: Lifetime buyers told to subscribe, paid subscribers who can't find what they bought, premium members still shown upsells

- **Where:** §1.7 #2
- **This app does:** entitlement failures
- **User reaction:** 1★-burst
- **Magnitude:** ≥4 IDs
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14060380344`, `9912775984`, `10764707061`, `12282678957`
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R03-040 — Billing hygiene: double charges, unclear cancellation, charges after trial cancellation

- **Where:** §1.7 #3
- **This app does:** billing errors
- **User reaction:** 1★-burst
- **Magnitude:** ≥7 IDs
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10263513150`, `11203632971`, `13964501187`, `10999894947`, `11248201618`, `11722683268`
- **Canonical:** C029 Billing must be exactly right

### R03-070 — Crash / won't open is only 12 reviews (0.11%) at mean 4.00 — reliability is not this app's problem

- **Where:** Part 4 row 17
- **This app does:** stable
- **User reaction:** complaint
- **Magnitude:** 12 (0.11%), mean 4.00
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R03-075 — Accidental widget reset (33, mean 4.09): the interactive widget's reset button destroys streaks with one mis-tap and cannot be undone or disabled — 'I have a toddler'; 'I don't want a visual cue to stop being sober'; one user stays on the free trial BECAUSE paying would put the reset button on their widget — a safety issue in a recovery app, not a UI nit

- **Where:** Part 4 B
- **This app does:** interactive widget with an un-undoable reset
- **User reaction:** complaint
- **Magnitude:** 33 (0.31%), mean 4.09; includes 2 paying users and one paywall-adjacent conversion blocker
- **Direction for us:** must-never-break · **Report confidence:** weak count, safety-critical · **Generalisable:** yes
- **Side effects:** destructive actions on an interactive widget need confirmation or undo; a reset button on the Home Screen is 'a visual cue to break the streak'
- **Conditions:** interactive widget check-off (report 1, lift ×5.2) and this are the same surface — make the destructive action hard, the constructive one easy
- **Review IDs:** `11969610649`, `14087849144`, `10624806513`, `11108689966`, `12399679376`, `11767328058`, `14292313517`, `11588058672`, `11989500206`, `11086772681`, `11188497308`, `13246151828`, `14005562428`, `14014676976`, `11768313172`, `10519275774`
- **Canonical:** C090 Destructive actions on widgets and quick surfaces need confirmation or undo; C023 Interactive widget check-off

### R03-076 — iCloud sync / backup (44, mean 3.91): losing years of sobriety data on a phone upgrade is the highest-severity failure mode — 'I have quit smoking for two years… they deleted the whole lot'; 'Back up is literally PREMIUM?'; nine outright data-loss reports promoted under the safety exception to the 0.1% rule

- **Where:** Part 4 C
- **This app does:** backup/sync paid; restore from iOS backup loses data
- **User reaction:** 1★-burst
- **Magnitude:** 44 (0.41%), mean 3.91; 9 (0.08%) outright data loss
- **Direction for us:** must-have · **Report confidence:** weak count, extreme severity · **Generalisable:** yes
- **Side effects:** charging for backup in a recovery app reads as holding sobriety history hostage
- **Conditions:** the report promotes this above its count deliberately — severity overrides the band
- **Review IDs:** `13629061971`, `11299477588`, `12548572664`, `12166645069`, `13465985854`, `13055204197`, `9112628469`, `12094477051`, `13021750903`, `11497487916`, `10551769710`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C013 Cloud sync / multi-device as the paid differentiator

### R03-100 — Widget technical breakage clustered in 2021–24 (17 reviews) and is near-zero in 2025–26; crashes total 12 in 10,621 (0.11%) — by category standards the engineering is excellent

- **Where:** §7.5 widget breakage + crashes
- **This app does:** stable, well-engineered
- **User reaction:** praise
- **Magnitude:** 17 widget-breakage reviews 2021–24; 12 crashes (0.11%)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** proves the rating collapse was monetisation, not quality
- **Canonical:** C031 Crashes / launch failures

### R03-103 — Make reset undoable and the widget reset button optional — add a confirmation, an undo window, and a per-widget toggle

- **Where:** Part 8 #3
- **This app does:** un-undoable widget reset
- **User reaction:** complaint
- **Magnitude:** 33 reviews, several payers
- **Direction for us:** must-never-break · **Report confidence:** meaningful (safety) · **Generalisable:** yes
- **Conditions:** evidence: R03-075
- **Canonical:** C090 Destructive actions on widgets and quick surfaces need confirmation or undo

### R03-104 — Honour entitlements the moment they're purchased — Lifetime buyers being asked to subscribe is the most damaging bug class in the corpus

- **Where:** Part 8 #4
- **This app does:** entitlement failures
- **User reaction:** 1★-burst
- **Magnitude:** 6 of 11 1–2★ payers
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** evidence: R03-030, R03-031, R03-039
- **Canonical:** C033 Restore purchase and entitlements must work immediately

### R03-125 — Counting inaccurate — 3 1★ and 2 2★; a full-price payer found the counter 2 days off at the 2-year mark

- **Where:** Part 2 1★ table row 'Counting inaccurate' + §1.4
- **This app does:** rare count drift
- **User reaction:** complaint
- **Magnitude:** 3 of 225 1★ (1.3%), 2 of 106 2★; 1 payer at 2 years
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** for a day counter the number IS the product; drift of even a day is a 1★
- **Review IDs:** `13843033653`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

## Features

### R03-016 — Widget / Lock Screen / Home Screen behind the paywall: 120 reviews (1.13%), mean 2.53, 59.2% 1–2★ — everything else paywalled is tolerated (4.0+ means); this is 'the cleanest pricing signal in the dataset'

- **Where:** §1.2 table row 1 + bold
- **This app does:** widget paid (since Jul 2025)
- **User reaction:** 1★-burst
- **Magnitude:** 120 (1.13%), mean 2.53, 59.2% 1–2★
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** a feature that has been free for years, and that is the primary surface, cannot be paywalled
- **Canonical:** C009 Basic widgets, icons and colours are free; C001 Never move a free feature behind the paywall

### R03-017 — Goals behind the paywall is tolerated (mean 4.05, 14.3% 1–2★) and is the #2 purchase trigger

- **Where:** §1.2 table row 2
- **This app does:** goals paid
- **User reaction:** purchase-driver
- **Magnitude:** 21 (0.20%), mean 4.05; 4 buyers name it — 'The goals are 100% worth upgrading for'
- **Direction for us:** build-paid · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13144761902`
- **Canonical:** C108 Goals / targets

### R03-018 — Reminders / notifications behind the paywall draw 19 reviews at mean 3.63 (31.6% 1–2★) — tolerated but less so than goals or colours

- **Where:** §1.2 table row 3
- **This app does:** reminders paid
- **User reaction:** mixed
- **Magnitude:** 19 (0.18%), mean 3.63, 31.6% 1–2★; 2 buyers name it
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** report 1 made the first reminder free and only extras paid; here all reminders are paid and it costs a third of a star more than goals
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C014 Multiple reminders per habit

### R03-019 — Colours / app icons behind the paywall are tolerated (mean 4.00, 15.4% 1–2★) and 2 buyers name colours as their reason

- **Where:** §1.2 table row 4
- **This app does:** colours and icons paid
- **User reaction:** purchase-driver
- **Magnitude:** 13 (0.12%), mean 4.00
- **Direction for us:** build-paid · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** report 1 gave colours away free and they drove 5★ — both work; cosmetics are safe to gate, not safe to un-gate
- **Review IDs:** `13602265269`, `13395203249`
- **Canonical:** C009 Basic widgets, icons and colours are free; C018 App-icon themes

### R03-020 — Backup / export / import / iCloud behind the paywall draws 12 reviews at mean 3.42 (33.3% 1–2★)

- **Where:** §1.2 table row 5
- **This app does:** backup/export/sync paid
- **User reaction:** complaint
- **Magnitude:** 12 (0.11%), mean 3.42
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C020 Data export / backup / CSV; C034 Data must never be lost on update, reinstall or phone change

### R03-021 — Siri Shortcuts behind the paywall: 4 reviews, mean 2.25, 75% 1–2★

- **Where:** §1.2 table row 6
- **This app does:** Shortcuts paid
- **User reaction:** complaint
- **Magnitude:** 4 (0.04%), mean 2.25
- **Direction for us:** undecided · **Report confidence:** ignore-band · **Generalisable:** yes
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R03-022 — Apple Watch behind the paywall: 1 review, 1★

- **Where:** §1.2 table row 7
- **This app does:** Watch paid
- **User reaction:** complaint
- **Magnitude:** 1 (0.01%)
- **Direction for us:** undecided · **Report confidence:** ignore-band · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R03-023 — Free tier confirmed working: unlimited counters, custom titles and emojis, colour coding, reset with note, full reset history, longest/average streak stats, calendar streak view, time-unit switching (seconds → years), Face ID / passcode lock, alternate app icons, social share images, dark mode

- **Where:** §1.2 free-tier list
- **This app does:** all of these free
- **User reaction:** praise
- **Magnitude:** no cap found in any review; one claim of a 20-counter limit contradicted by a user tracking '100+ things'
- **Direction for us:** build-free · **Report confidence:** stated · **Generalisable:** yes
- **Conditions:** passcode lock is free here (paid in reports 1 and 2)
- **Review IDs:** `12098476442`, `13602265269`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free; C017 Passcode lock; C080 Colour themes / dark mode; C096 Privacy and discretion stack

### R03-046 — Time-unit flexibility (hours → years) is underrated: it is what makes day 1 survivable — 'Seeing 105 hours instead of 4 days gives me that little boost'

- **Where:** Part 2 5★ row 6
- **This app does:** time-unit switching, free
- **User reaction:** praise
- **Magnitude:** 117 of 5★ (1.3%); 130 corpus (1.22%), mean 4.89, zero 1–2★
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11415043405`, `10707468669`, `11593417307`, `13180844816`, `8002227973`, `9649217076`
- **Canonical:** C098 Time-unit flexibility for counters (hours → years)

### R03-050 — The 'almost' band (3★ n=191, 4★ n=849) is dominated by absence, not defect — full table

- **Where:** Part 2 3–4★ table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Driver | In 3★ | In 4★ ; Milestones / badges / celebration wanted | 7 (3.7%) | 39 (4.6%) ; Notes / journaling wanted or too cramped | 6 (3.1%) | 33 (3.9%) ; Notifications / reminders wanted (or free) | 8 (4.2%) | 24 (2.8%) ; Pause / stop / archive a counter | 5 (2.6%) | 23 (2.7%) ; Countdown ("days until") | 2 (1.0%) | 13 (1.5%) ; Graphs / deeper stats | 3 (1.6%) | 10 (1.2%) ; Accidental widget reset | 3 (1.6%) | 10 (1.2%) ; Folders / categories | 3 (1.6%) | 8 (0.9%) ; More / custom colours, photo backgrounds | 2 (1.0%) | 7 (0.8%) ; Money-saved counter | 0 | 6 (0.7%)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R03-051 — Pause / stop / archive a counter alone is worth roughly a star to 44 people — the highest-leverage single feature in this corpus per unit of engineering

- **Where:** Part 2 3–4★ bold
- **This app does:** cannot pause a counter
- **User reaction:** complaint
- **Magnitude:** 5 3★ + 23 4★ in the band; 44 corpus-wide (0.41%), mean 4.02; 'You can't pause a counter'
- **Direction for us:** must-have · **Report confidence:** high-priority (by leverage) · **Generalisable:** yes
- **Review IDs:** `12591019352`, `13547063908`, `13415546831`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R03-053 — The widget is the intervention, not decoration: 'the first thing I see when I unlock my phone. 240 days later'; 'It is like having a life coach for free'

- **Where:** Part 3 §2
- **This app does:** Home/Lock Screen widget
- **User reaction:** praise
- **Magnitude:** 920 (8.66%)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11613261974`, `13068617301`, `11550435166`, `12090382709`, `14363669933`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R03-055 — Privacy and discretion — Face ID lock, alternate icons, a neutral app name, no account, no data collection — is the only theme with a perfect negative-free record (145 reviews, mean 4.90, zero 1–2★); 'the name was more discreet… so that I could download it without being questioned by my family'

- **Where:** Part 3 §4
- **This app does:** free privacy stack; discreet name
- **User reaction:** praise
- **Magnitude:** 145 (1.37%), mean 4.90, 0 1–2★
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** in a recovery/sobriety category the app's NAME is a privacy feature
- **Conditions:** category-critical for quit-habit; passcode lock is free here
- **Review IDs:** `9562673641`, `8103285120`, `8670863468`, `14479485824`, `14069349379`, `14215526815`, `13121449322`, `12123965670`, `13879035654`
- **Canonical:** C096 Privacy and discretion stack; C017 Passcode lock

### R03-056 — The reset mechanic — reset history, longest streak, average streak — is praised by 116 (1.09%), and 14 explicitly praise the ABSENCE of shame: 'relapse is part of recovery'; 'When you reset there's not a popup telling you to stay strong'

- **Where:** Part 3 §5
- **This app does:** reset keeps history; no shaming copy
- **User reaction:** praise
- **Magnitude:** 116 (1.09%); 14 praise no-shame
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** 'the customer experience [elsewhere] is usually based around shaming you for falling off' — tone on failure is a product decision
- **Review IDs:** `13535056893`, `13091581867`, `12724148088`, `8034842662`, `9976059748`, `12972611936`, `12280678796`, `11792382769`
- **Canonical:** C095 Neutral, non-judgemental tone on failure

### R03-058 — Top complaints and unmet needs, 20 rows with n, %, mean, band — full table

- **Where:** Part 4 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** # | Theme | n | % | Mean | Band ; 1 | Paywall in general ("have to pay", "premium only") | 214 | 2.01% | 3.44 | Meaningful ; 2 | Subscription nag / pop-ups | 176 | 1.66% | 4.35 | Meaningful ; 3 | Widget paywalled | 128 | 1.21% | 2.48 | Meaningful (5.4% within era D) ; 4 | Price too high / greed | 109 | 1.03% | 2.94 | Meaningful ; 5 | Wants notifications / reminders (or free) | 94 | 0.89% | 4.38 | Emerging ; 6 | Apple Watch (missing, broken, or paywalled) | 50 | 0.47% | 4.22 | Weak ; 7 | Graphs / deeper stats | 48 | 0.45% | 4.60 | Weak ; 8 | No iCloud sync / backup / new-phone loss | 44 | 0.41% | 3.91 | Weak ; 9 | Pause / stop / archive a counter | 44 | 0.41% | 4.02 | Weak ; 10 | Folders / categories | 43 | 0.40% | 4.67 | Weak ; 11 | Accidental widget reset | 33 | 0.31% | 4.09 | Weak ; 12 | More / custom colours, photo backgrounds | 33 | 0.31% | 4.48 | Weak ; 13 | iPad / Mac / landscape | 29 | 0.27% | 4.10 | Weak ; 14 | Countdown ("days until") | 27 | 0.25% | 4.37 | Weak ; 15 | Export / CSV | 23 | 0.22% | 3.52 | Weak ; 16 | Social / accountability partner | 21 | 0.20% | 4.38 | Weak ; 17 | Crash / won't open | 12 | 0.11% | 4.00 | Weak ; 18 | Can't backdate / edit start date | 12 | 0.11% | 4.33 | Weak ; 19 | Money-saved counter | 14 | 0.13% | 4.57 | Weak ; 20 | Localisation (app is English-only) | 9 | 0.08% | 3.89 | Ignore-by-default
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R03-061 — Wants notifications / reminders (or wants them free): 94 reviews (0.89%) at mean 4.38 — asked by happy users

- **Where:** Part 4 row 5
- **This app does:** reminders paid
- **User reaction:** complaint
- **Magnitude:** 94 (0.89%), mean 4.38
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C014 Multiple reminders per habit

### R03-062 — Apple Watch — missing, broken or paywalled — 50 reviews (0.47%, mean 4.22)

- **Where:** Part 4 row 6
- **This app does:** Watch app exists (paywalled), sometimes broken
- **User reaction:** complaint
- **Magnitude:** 50 (0.47%), mean 4.22
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R03-063 — Graphs / deeper stats requested by 48 (0.45%) at mean 4.60

- **Where:** Part 4 row 7
- **This app does:** basic stats only
- **User reaction:** complaint
- **Magnitude:** 48 (0.45%), mean 4.60
- **Direction for us:** build-paid · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C011 Weekly / monthly / yearly reports

### R03-064 — Folders / categories requested by 43 (0.40%) at mean 4.67 — the highest-mean request

- **Where:** Part 4 row 10
- **This app does:** flat list of counters
- **User reaction:** complaint
- **Magnitude:** 43 (0.40%), mean 4.67
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C045 Grouping / folders / tags / multiple profiles

### R03-065 — More / custom colours and photo backgrounds requested by 33 (0.31%, mean 4.48)

- **Where:** Part 4 row 12
- **This app does:** limited colour set
- **User reaction:** complaint
- **Magnitude:** 33 (0.31%), mean 4.48
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C079 Personal photos as habit icons; C080 Colour themes / dark mode

### R03-066 — iPad / Mac / landscape support requested by 29 (0.27%, mean 4.10)

- **Where:** Part 4 row 13
- **This app does:** iPad/Mac exist but weak; no landscape
- **User reaction:** complaint
- **Magnitude:** 29 (0.27%), mean 4.10
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C044 Mac / desktop / web app

### R03-067 — Countdown ('days until') requested by 27 (0.25%, mean 4.37)

- **Where:** Part 4 row 14
- **This app does:** count-up only
- **User reaction:** complaint
- **Magnitude:** 27 (0.25%), mean 4.37
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C099 Countdown / 'days until' mode

### R03-068 — Export / CSV requested by 23 (0.22%, mean 3.52)

- **Where:** Part 4 row 15
- **This app does:** export paid
- **User reaction:** complaint
- **Magnitude:** 23 (0.22%), mean 3.52
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C020 Data export / backup / CSV

### R03-069 — Social / accountability partner requested by 21 (0.20%, mean 4.38)

- **Where:** Part 4 row 16
- **This app does:** none
- **User reaction:** complaint
- **Magnitude:** 21 (0.20%), mean 4.38
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C015 Shared / group habits

### R03-071 — Can't backdate / edit start date — 12 reviews (0.11%, mean 4.33)

- **Where:** Part 4 row 18
- **This app does:** start date not editable (for some)
- **User reaction:** complaint
- **Magnitude:** 12 (0.11%), mean 4.33
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C010 Backfill missed days / edit start date

### R03-072 — Money-saved counter requested by 14 (0.13%, mean 4.57)

- **Where:** Part 4 row 19
- **This app does:** none
- **User reaction:** complaint
- **Magnitude:** 14 (0.13%), mean 4.57
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** category-specific: quitting smoking/drinking has a cost to show
- **Canonical:** C100 Money-saved counter

### R03-074 — Pause / stop / archive is the most-requested MISSING capability from satisfied users (44, mean 4.02): a counter should stop without being deleted so a relapse period isn't counted as abstinence and history isn't destroyed; two 3★ and two 2★ say it is the only thing between them and 5★

- **Where:** Part 4 A
- **This app does:** cannot pause
- **User reaction:** complaint
- **Magnitude:** 44 (0.41%), mean 4.02
- **Direction for us:** must-have · **Report confidence:** high-priority (by leverage) · **Generalisable:** yes
- **Review IDs:** `6386713912`, `7958751185`, `8247692991`, `8307733145`, `8583664620`, `8781228163`, `9071875815`, `9336427052`, `9497859261`, `9742186794`, `9815612198`, `9839492855`, `9853574448`, `9911225624`, `10006666229`, `10032185981`, `10114793784`, `10192967798`, `10406386435`, `10445660170`, `10556917933`, `10804111903`, `11089174862`, `11183891301`, `11205849645`, `11300877108`, `11560026280`, `11818815829`, `11873716787`, `12090334442`, `12110217758`, `12157388115`, `12284818560`, `12450405620`, `12591019352`, `12622562349`, `12707899782`, `12793759754`, `13317648020`, `13348650970`, `13415546831`, `13504054157`, `13547063908`, `14017242606`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R03-077 — Milestone celebration / badges (235, 2.21%, mean 4.74) is the largest positive-intent feature request in the corpus, spanning 2020→2026 in every era — almost all 4–5★ users describing a gap; Achievements shipped in v4.1.0 (31 Aug 2026), post-dating almost all of them

- **Where:** Part 4 D
- **This app does:** shipped Achievements Aug 2026
- **User reaction:** complaint
- **Magnitude:** 235 (2.21%), mean 4.74
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** a six-year-old top request; whether it becomes a purchase driver is not yet visible
- **Review IDs:** `5623501226`, `6799825017`, `6725577104`, `6916503157`, `7937733616`, `7788890241`, `13516767357`, `14477704812`, `13673255758`, `14443856328`, `14193482636`, `12972611936`, `12224121640`
- **Canonical:** C101 Milestones, achievements, celebration

### R03-078 — Notes / journaling wanted or too cramped — 6 3★ + 33 4★ (3.9% of 4★)

- **Where:** Part 2 3–4★ row 'Notes / journaling'
- **This app does:** reset note only; no journal
- **User reaction:** complaint
- **Magnitude:** 39 in the 3–4★ band
- **Direction for us:** research · **Report confidence:** meaningful (band) · **Generalisable:** yes
- **Canonical:** C049 Mood tracker / journal / habit notes

### R03-109 — Pause / stop / archive a counter — 44 requests, mean 4.02, several explicit 'this is the only thing keeping it at 4 stars'

- **Where:** Part 8 #9
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 44 (0.41%), mean 4.02
- **Direction for us:** must-have · **Report confidence:** high-priority (leverage) · **Generalisable:** yes
- **Conditions:** evidence: R03-051, R03-074
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R03-110 — Milestone celebration and achievements — 235 requests over six years; v4.1.0 appears to address this, validate against the 3–4★ band in the next corpus

- **Where:** Part 8 #10
- **This app does:** shipped Aug 2026
- **User reaction:** complaint
- **Magnitude:** 235 (2.21%)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R03-077
- **Canonical:** C101 Milestones, achievements, celebration

### R03-111 — A proper notes / journaling field — 152 reviews; the current field is a single cramped line; 'an important part of recovery is journaling to help identify common triggers'

- **Where:** Part 8 #11
- **This app does:** single-line note on reset
- **User reaction:** complaint
- **Magnitude:** 152 reviews
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R03-078
- **Review IDs:** `12151285522`, `14270251700`, `9673744206`, `12251429856`, `12662372114`, `10483620131`
- **Canonical:** C049 Mood tracker / journal / habit notes

### R03-112 — Graphs and trend analytics — streak length over time, resets per month, average-streak trend; two users describe the exact chart they want

- **Where:** Part 8 #12
- **This app does:** basic stats only
- **User reaction:** complaint
- **Magnitude:** 48 (0.45%), mean 4.60
- **Direction for us:** build-paid · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R03-063
- **Review IDs:** `10193651577`, `13974353363`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R03-113 — Countdown / 'days until' mode — 27 requests 2020–2026; users want one app, not two

- **Where:** Part 8 #13
- **This app does:** count-up only
- **User reaction:** complaint
- **Magnitude:** 27 (0.25%)
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R03-067
- **Canonical:** C099 Countdown / 'days until' mode

### R03-114 — Folders / categories — 43 requests, mean 4.67, zero 1–2★: pure power-user demand from people tracking 20–100 counters

- **Where:** Part 8 #14
- **This app does:** flat list
- **User reaction:** complaint
- **Magnitude:** 43 (0.40%), mean 4.67, 0 1–2★
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R03-064
- **Canonical:** C045 Grouping / folders / tags / multiple profiles

### R03-115 — A 'good habit' inverse mode — the chore/ADHD cohort is 4.17% and growing and deserves a first-class mode rather than a workaround

- **Where:** Part 8 #15
- **This app does:** count-up only, recovery framing
- **User reaction:** complaint
- **Magnitude:** 10 explicit requests; 443 chore/ADHD users
- **Direction for us:** research · **Report confidence:** very strong (audience) · **Generalisable:** yes
- **Conditions:** evidence: R03-081, R03-082
- **Canonical:** C102 Inverse / 'good habit' mode for a counter

### R03-116 — Money-saved counter — standard in competing quit-smoking apps and repeatedly named as the one thing missing

- **Where:** Part 8 #16
- **This app does:** missing
- **User reaction:** complaint
- **Magnitude:** 14 (0.13%), mean 4.57
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R03-072; category-specific
- **Canonical:** C100 Money-saved counter

## Monetization

### R03-012 — Free download with no ads anywhere — 206 reviews (1.94%) explicitly praise the absence of ads at mean 4.94, and zero of them are 1–2★

- **Where:** §1.1 bullet 1
- **This app does:** no ads
- **User reaction:** praise
- **Magnitude:** 206 (1.94%), mean 4.94, 0 1–2★
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C006 Stay minimal and ad-free; C082 Ads in the free tier

### R03-013 — Subscription-first, branded 'Count Up Club' (earlier 'Premium'): yearly $17.99, monthly $5.99 / $2.99, lifetime $49.99, discounted $11.99; legacy Premium $29.99/yr, $9.99/mo

- **Where:** §1.1 bullet 2
- **This app does:** subscription with a lifetime option at ~2.8× the yearly
- **User reaction:** mixed
- **Magnitude:** IAP list from the store page (2026-09-09)
- **Direction for us:** research · **Report confidence:** external source · **Generalisable:** yes
- **Conditions:** a rebrand of the paid tier left two SKU families visible on the store page
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C003 Lead with a one-time lifetime purchase

### R03-014 — Reviewers name a wide spread of prices — $17.99–18/yr, $50 lifetime, $30/yr, $22/yr, €7/mo, £6/mo, €60 lifetime, ₹5,000/yr, $12/yr legacy — so the pricing surface is inconsistent; one buyer 'can't find the count up club' they paid for

- **Where:** §1.1 bullet 3
- **This app does:** inconsistent prices across periods and SKUs
- **User reaction:** complaint
- **Magnitude:** ≥9 distinct price points reported
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** two SKU families + a rebrand = buyers who cannot find what they bought (R03-024)
- **Review IDs:** `9642317256`, `12870203346`, `13478631404`, `13571382100`, `12872057253`, `13723431455`, `13223954026`, `12942245612`, `11602241705`, `13471712113`, `13490897194`, `9468239921`, `10584415042`, `13409969245`, `11367914478`, `14107888082`, `10103510351`, `13189265606`, `10468707953`, `14364118481`, `9912775984`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C033 Restore purchase and entitlements must work immediately

### R03-015 — Features named as paywalled with count, %, mean and 1–2★ — full table

- **Where:** §1.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Feature named as paywalled | Reviews | % of 10,621 | Mean | 1–2★ ; Widget / Lock Screen / Home Screen | 120 | 1.13% | 2.53 | 59.2% ; Goals | 21 | 0.20% | 4.05 | 14.3% ; Reminders / notifications | 19 | 0.18% | 3.63 | 31.6% ; Colors / app icons | 13 | 0.12% | 4.00 | 15.4% ; Backup / export / import / iCloud | 12 | 0.11% | 3.42 | 33.3% ; Siri Shortcuts | 4 | 0.04% | 2.25 | 75.0% ; Apple Watch | 1 | 0.01% | 1.00 | 100%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R03-026 — Two purchases were accidental / forgot-to-cancel-trial — one left 3★

- **Where:** §1.3 trigger row 'Accidental'
- **This app does:** trial converts to paid automatically
- **User reaction:** complaint
- **Magnitude:** 2 of 45 buyers
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11618250403`, `12144029927`
- **Canonical:** C029 Billing must be exactly right

### R03-032 — 21 reviews (0.20%) say they would pay but haven't — several explicitly ask for a donate or tip button because the app has no way to give money

- **Where:** §1.5 bullet 1
- **This app does:** no tip/donate option
- **User reaction:** blocked-conversion
- **Magnitude:** 21 (0.20%); ~12 unsolicited offers to donate
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Side effects:** 'The only thing I miss is a donate button' — goodwill with nowhere to go
- **Review IDs:** `8659150662`, `7190023036`, `7259554838`, `7981181148`, `7596500499`, `7934568657`, `6826653115`, `7409351582`, `8811617621`, `8410535615`, `8581180685`, `7942101292`
- **Canonical:** C097 A tip / donate option

### R03-033 — 18 reviews (0.17%) explicitly demand a one-time purchase instead of a subscription

- **Where:** §1.5 bullet 2
- **This app does:** subscription-first; lifetime exists at $49.99 but is not what they mean
- **User reaction:** blocked-conversion
- **Magnitude:** 18 (0.17%)
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** a $50 lifetime on a free counter app does not read as 'one-time purchase' to these users — price level matters, not just the SKU type
- **Review IDs:** `9642317256`, `10149619417`, `11400900906`, `11594710921`, `11726683344`, `12173342801`, `12318988707`, `11624049028`, `10584415042`, `12456220146`, `14151250043`, `13656090865`, `12721975270`, `9385157078`, `13434276029`, `11420159085`, `9536310663`, `14060380344`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R03-042 — No one-time / tip option at a sane price — 18 explicit requests plus ~12 unsolicited offers to donate; the corpus contains people literally asking to give money in a way the app doesn't accept

- **Where:** §1.7 #5
- **This app does:** subscription or $50 lifetime only
- **User reaction:** blocked-conversion
- **Magnitude:** 18 + ~12
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R03-032, R03-033
- **Canonical:** C003 Lead with a one-time lifetime purchase; C097 A tip / donate option

### R03-059 — 'Paywall in general' is the #1 complaint theme: 214 reviews (2.01%), mean 3.44

- **Where:** Part 4 row 1
- **This app does:** subscription gating
- **User reaction:** complaint
- **Magnitude:** 214 (2.01%), mean 3.44
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R03-060 — 'Price too high / greed' draws 109 reviews (1.03%, mean 2.94)

- **Where:** Part 4 row 4
- **This app does:** $17.99/yr, $49.99 lifetime on a counter app
- **User reaction:** complaint
- **Magnitude:** 109 (1.03%), mean 2.94
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

## Tactics the app used

### R03-037 — The review prompt is also one of the app's most effective acquisition assets: at least 40 reviews say they wrote the review only because the request was charming — the prompt is not the problem; its frequency and its ignoring of the iOS opt-out are

- **Where:** §1.6 counterpoint
- **This app does:** a charming, well-written review request
- **User reaction:** 5★-burst
- **Magnitude:** ≥40 reviews written because of the prompt
- **Direction for us:** do · **Report confidence:** qualitative, clear mechanism · **Generalisable:** yes
- **Side effects:** tone of the ask converts; cadence and disrespecting opt-out backfire
- **Review IDs:** `8285762745`, `8034718546`, `12229362617`, `8862823851`, `8731237614`, `14347631180`, `9421444201`, `12732351894`, `8993759816`, `13067292411`, `10570326748`, `8250508459`, `9489905182`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R03-057 — Developer responsiveness — 42 reviews (0.40%), several are rating UPGRADES after support contact: an update-broken app fixed within hours, Watch fixed, notes editing shipped after a request; 'support quality is a real asset and it is being spent patching a self-inflicted pricing wound'

- **Where:** Part 3 §7
- **This app does:** fast, personal support
- **User reaction:** 5★-burst
- **Magnitude:** 42 (0.40%)
- **Direction for us:** do · **Report confidence:** weak count, clear mechanism · **Generalisable:** yes
- **Review IDs:** `12937787678`, `9484075370`, `11053721045`, `12891271083`, `10862813507`, `11577546860`, `12879539920`, `9809365963`, `6789235976`, `12460281591`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

## Insights (the why)

### R03-004 — The product is genuinely excellent: 34.3% praise simplicity (mean 4.90), 8.7% mention the widget (#2 theme), 4.7% praise being free, 1.9% praise no ads, 2.3% praise unlimited counters, 1.4% praise the privacy stack; reviewers call it indistinguishable from a first-party Apple app

- **Where:** Part 0 §1
- **This app does:** minimal, Apple-native feel, free, no ads, unlimited counters, Face ID lock, no account, disguised icon
- **User reaction:** praise
- **Magnitude:** simplicity 3,647 (34.3%, 4.90); widget 920 (8.7%); free 495 (4.7%); no ads 206 (1.9%); unlimited counters 244 (2.3%); privacy 145 (1.4%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 'The most Apple looking non-Apple app ever' — native-feel design is a praise driver in itself
- **Review IDs:** `10404638991`, `13283082126`, `9406490807`, `12367096941`, `8478010591`
- **Canonical:** C006 Stay minimal and ad-free; C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free

### R03-008 — The widget is not a nice-to-have, it is the product: 38.2% of 1★ reviews mention it (86 of 225) — the highest concentration of any theme in any star band; users say the widget WAS their reason for keeping the app

- **Where:** Part 0 §3
- **This app does:** widget was free for years, then paywalled
- **User reaction:** 1★-burst
- **Magnitude:** 86 of 225 1★ (38.2%)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** 'Recent update disabled widgets I've been using for 4 years'; 'This app does not have unique qualities to make widgets a premium feature'
- **Conditions:** for a day-counter the widget is the primary surface — the app itself is rarely opened
- **Review IDs:** `12866203144`, `12870567769`, `12926945945`, `12862828885`, `12856046988`, `12877198255`, `13876121897`, `12990450515`
- **Canonical:** C009 Basic widgets, icons and colours are free; C001 Never move a free feature behind the paywall

### R03-009 — 18 reviews (0.17%) explicitly state they deleted or switched apps over the paywall, mean 1.78

- **Where:** Part 0 §3 deletion line
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 18 (0.17%), mean 1.78
- **Direction for us:** product-rule · **Report confidence:** weak count, explicit churn · **Generalisable:** yes
- **Review IDs:** `9178559150`, `9659762298`, `10999894947`, `11129880622`, `12864082351`, `12865371985`, `12875697521`, `12891028517`, `12908610575`, `12926945945`, `12956539067`, `12985581259`, `13017308910`, `13207861199`, `13710553115`, `13950998269`, `14161669986`, `14446431929`
- **Canonical:** C001 Never move a free feature behind the paywall

### R03-024 — 45 reviews (0.42%) confirm a first-hand purchase — hand-curated list

- **Where:** §1.3 opening
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 45 (0.42%)
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `9466347369`, `9483674873`, `9659762298`, `9912775984`, `10120217443`, `10246644188`, `10263513150`, `10570659048`, `10618771296`, `10764707061`, `11108689966`, `11148249366`, `11291342307`, `11336770737`, `11366641851`, `11602241705`, `11618250403`, `11729131712`, `11787136840`, `12130917231`, `12308505754`, `12585734229`, `12708219985`, `12795625876`, `12868861275`, `12879539920`, `12936970266`, `13115850782`, `13144761902`, `13246151828`, `13257489481`, `13308257943`, `13395203249`, `13571741107`, `13602265269`, `13704550155`, `13843033653`, `13964501187`, `14007541207`, `14060380344`, `14144614865`, `14324807045`, `14364118481`, `14392573700`, `14461407652`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R03-025 — Stated reasons to pay: widget customisation / reset-from-Home-Screen 5, goals 4, support the indie devs 4, colours 2, reminders 2, Apple Watch 1, accidental / forgot to cancel trial 2

- **Where:** §1.3 trigger table
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Trigger | Count | Evidence ; Widget customisation / widget reset from Home Screen | 5 | `12936970266`, `14324807045`, `13308257943`, `13395203249`, `11291342307` ; Goals feature | 4 | `13144761902` (*"The goals are 100% worth upgrading for"*), `14392573700`, `12622562349`, `12308505754` ; Supporting the indie devs / app already earned it | 4 | `11366641851`, `14364118481`, `14461407652`, `10081706180` (intent) ; Colours | 2 | `13602265269`, `13395203249` ; Reminders / notifications | 2 | `12308505754`, `10246644188` ; Apple Watch | 1 | `11602241705`
- **Direction for us:** none · **Report confidence:** weak counts · **Generalisable:** yes
- **Side effects:** the #1 purchase trigger is widget customisation — the widget sells when the base widget is free
- **Review IDs:** `12936970266`, `14324807045`, `13308257943`, `13395203249`, `11291342307`, `13144761902`, `14392573700`, `12622562349`, `12308505754`, `11366641851`, `14364118481`, `14461407652`, `10081706180`, `13602265269`, `10246644188`, `11602241705`, `11618250403`, `12144029927`
- **Canonical:** C107 Widget variants and customisation as the paid layer; C108 Goals / targets

### R03-027 — Buyers who are happy anchor on price-per-month ('$12 a year. That's $1 a month… Get a grip'), on motivation ('spending $20 on this app for a year is a super motivating way to keep track of my goals') and on responsiveness ('The developers even added my suggestion into the app')

- **Where:** §1.3 buyers' words
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** 4 quoted 5★ buyers
- **Direction for us:** do · **Report confidence:** qualitative · **Generalisable:** yes
- **Side effects:** paying can itself be a commitment device for a recovery tool
- **Review IDs:** `14364118481`, `12130917231`, `11602241705`, `12795625876`
- **Canonical:** C061 'Support the devs' goodwill converts; C004 Price low and fair, anchored against subscription competitors; C059 Be visibly responsive; fixes bring reviewers back

### R03-028 — Paying costs the app roughly nine-tenths of a star and multiplies the 1–2★ rate by eight: payers 3.91 vs 4.77, 24.4% 1–2★ vs 3.11%

- **Where:** §1.4 table + bold
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** payers n=45: 3.91, 24.4% 1–2★, 64.4% 5★; corpus 4.77, 3.11%, 87.1%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R03-029 — Payer sentiment did not move across the July 2025 boundary (pre 3.92, post 3.90) — the paywall damage lands on FREE users; the buyer problem is different: delivery and billing

- **Where:** §1.4 'did not move'
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** pre n=24 mean 3.92; post n=21 mean 3.90
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** two distinct failure modes: re-paywalling hurts free users, entitlement/billing failures hurt payers
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C001 Never move a free feature behind the paywall

### R03-044 — What produces 5★ (n=9,250): simple 3,369 (36.4%), widget 678 (7.3%), free 407 (4.4%), unlimited counters 215 (2.3%), no ads 195 (2.1%), time-unit flexibility 117 (1.3%), privacy 131 (1.4%), reset history 97 (1.0%)

- **Where:** Part 2 5★ table (verbatim)
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** Driver | Count in 5★ | % of 5★ | Read as ; Simple / clean / easy / minimal | 3,369 | 36.4% | The core engine. Nothing else is close. ; Widget | 678 | 7.3% | Second-largest, and the reason people keep it installed ; Free / no paywall | 407 | 4.4% | Acquisition and retention driver ; Multiple / unlimited counters | 215 | 2.3% | The explicit switch reason from I Am Sober ; No ads | 195 | 2.1% | Trust signal in this category ; Time-unit flexibility (hours→years) | 117 | 1.3% | Underrated: it's what makes day 1 survivable ; Privacy (Face ID, no account, disguised icon) | 131 | 1.4% | Category-critical, see Part 3 ; Reset history / longest streak / average streak | 97 | 1.0% | The "relapse doesn't erase you" mechanic
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R03-047 — What produces 1★ (n=225) and 2★ (n=106) — full table

- **Where:** Part 2 1–2★ table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Driver | In 1★ | % of 1★ | In 2★ | % of 2★ ; Widget paywalled | 59 | 26.2% | 16 | 15.1% ; Other paywall / "have to pay" | 44 | 19.6% | 20 | 18.9% ; Price / greed language | 37 | 16.4% | 8 | 7.5% ; Subscription nag / pop-ups | 15 | 6.7% | 7 | 6.6% ; "Too basic / glorified stopwatch" | 13 | 5.8% | 4 | 3.8% ; Widget broken (technical, not paywall) | 8 | 3.6% | 2 | 1.9% ; Cancel / refund / billing | 7 | 3.1% | 0 | 0.0% ; Data loss / no backup | 6 | 2.7% | 1 | 0.9% ; Counting inaccurate | 3 | 1.3% | 2 | 1.9% ; Notifications behind paywall | 3 | 1.3% | 2 | 1.9% ; Reset / date editing broken | 2 | 0.9% | 0 | 0.0% ; Apple Watch broken | 1 | 0.4% | 1 | 0.9%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R03-048 — 62% of one-star reviews are about money, not about the product working badly; reliability accounts for roughly 8% — the opposite profile of most apps in this dataset family

- **Where:** Part 2 1★ bold
- **This app does:** reliable app, aggressive monetisation
- **User reaction:** 1★-burst
- **Magnitude:** widget paywall 26.2% + other paywall 19.6% + price/greed 16.4% of 1★; reliability ~8%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** when the product works, the monetisation decisions ARE the rating
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R03-052 — Radical simplicity — 34.34% at mean 4.90 — users choose this app AFTER rejecting others for being too much: 'I don't need to log all of my reasons and thoughts… I already know my reasons'; 'the only one of 3 apps that didn't give me bible quotes every time I logged on'

- **Where:** Part 3 §1
- **This app does:** minimal: counter, reset, widget
- **User reaction:** praise
- **Magnitude:** 3,647 (34.34%), mean 4.90
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** in the quit-habit category, journaling prompts, motivational quotes and 'Sobriety Plus' upsells are named as reasons to leave competitors
- **Review IDs:** `11351620542`, `9725862564`, `11549990017`, `8911015925`, `12948824437`, `9900639372`
- **Canonical:** C006 Stay minimal and ad-free

## Audiences

### R03-011 — The moral framing is unusually hostile and specific to this category: 11 reviews accuse the developer of exploiting vulnerable people ('preying on ppl with addictions'; a widget tracking days since a self-harm attempt 'refusing to work unless I pay $50') — the reputational cost of monetising a recovery tool

- **Where:** Part 0 §5
- **This app does:** monetised a recovery/sobriety tool aggressively
- **User reaction:** 1★-burst
- **Magnitude:** 11 (0.10%), extreme tone, concentrated post-paywall
- **Direction for us:** dont · **Report confidence:** weak count, reputational · **Generalisable:** yes
- **Side effects:** users of a quit-habit app include people tracking self-harm, suicidality and addiction; paywall moves read as predatory there in a way they do not in productivity apps
- **Conditions:** see Research Reports/Quit Habit Decision.md
- **Review IDs:** `12931476120`, `13452216936`, `13502020915`, `12942245612`, `13723431455`, `13876121897`, `13950998269`, `13172803401`, `12972611936`, `8410535615`, `8206594435`
- **Canonical:** C103 Recovery and harm-reduction users are a vulnerable surface

### R03-079 — Recovery and harm-reduction use cases with count, %, mean — full table (alcohol 7.09%, nicotine 3.82%, food/EDs 2.32%, self-harm 1.14%, hard drugs 1.03%, cannabis 0.96%, social media 0.69%, BFRBs 0.40%, porn/NoFap 0.38%, no-contact 0.31% at mean 4.97, shopping 0.24%, gambling 0.06%)

- **Where:** Part 5 Audience 1 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Use case | Reviews | % | Mean ; Alcohol / sobriety | 753 | 7.09% | 4.86 ; Nicotine (smoking / vaping / snus) | 406 | 3.82% | 4.88 ; Food, sugar, caffeine, binge eating, EDs | 246 | 2.32% | 4.77 ; Self-harm / suicidality | 121 | 1.14% | 4.77 ; Hard drugs / NA / relapse language | 109 | 1.03% | 4.77 ; Cannabis | 102 | 0.96% | 4.82 ; Social media / doomscrolling | 73 | 0.69% | 4.81 ; BFRBs (nail biting, trichotillomania, skin picking) | 42 | 0.40% | 4.93 ; Porn / NoFap / PMO / celibacy | 40 | 0.38% | 4.75 ; No-contact after a breakup or abuse | 33 | 0.31% | 4.97 ; Shopping / spending | 26 | 0.24% | 4.88 ; Gambling | 6 | 0.06% | 4.83
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Conditions:** quit-habit audience; means are all 4.75–4.97 — every recovery use case is a happy one
- **Canonical:** C103 Recovery and harm-reduction users are a vulnerable surface

### R03-080 — The self-harm / suicidality cohort (121 reviews, mean 4.77) matters disproportionately: multiple reviewers are minors (11, 12, 13 years old), and three complain that a 17+ age rating blocked them via family filters — the age rating is load-bearing for a real segment

- **Where:** Part 5 Audience 1 self-harm paragraph
- **This app does:** age rating moved 12+ → 17+ → 12+
- **User reaction:** praise
- **Magnitude:** 121 (1.14%); 5 self-identified minors; 3 age-rating complaints
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** content/age rating is a product decision with a user segment attached; monetisation moves land on this cohort as 'preying on the vulnerable' (R03-011)
- **Review IDs:** `8235797720`, `11811900918`, `9168912965`, `13649780407`, `8444639701`, `9082663804`, `9142597312`, `12044926784`
- **Canonical:** C103 Recovery and harm-reduction users are a vulnerable surface

### R03-081 — The accidental second product: 443 reviews (4.17%) use the app for chores, ADHD time-blindness or household maintenance, and 77 (0.72%) for medical tracking (seizure logs, medication refills, cancer prognosis, pet symptoms) — a very strong signal the developer did not design for and reviewers apologise for

- **Where:** Part 5 Audience 2
- **This app does:** designed for recovery; used for time-since-anything
- **User reaction:** praise
- **Magnitude:** 443 (4.17%) chores/ADHD; 77 (0.72%) medical
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Side effects:** 'saw this app recommended in an ADHD subreddit'; 'found it via a book on ADHD' — the ADHD audience arrives through community channels
- **Conditions:** 'time since I last did X' is a general-purpose primitive: ADHD time-blindness, medical logs, maintenance
- **Review IDs:** `12276515904`, `13602265269`, `11802530951`, `12712883376`, `13152317845`, `11987481281`, `12109101100`, `13469744538`, `12095994550`, `13155067518`, `11792382769`, `12783836494`, `11572672661`, `12864038501`, `12708537989`, `13591837410`, `12818140107`, `14248093670`, `12885656663`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

## Markets and languages

### R03-034 — Regional pricing is asked for by name in UA, TR, IN, SA — 'I would buy yearly if it was at least 60–70% cheaper. I don't think you are making any profits from Turkiye'; 'Localized pricing for digital goods is a well-researched topic'

- **Where:** §1.5 bullet 3
- **This app does:** single global price
- **User reaction:** blocked-conversion
- **Magnitude:** 6 IDs across 4 markets
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Side effects:** the review text says price is the only blocker in these markets
- **Review IDs:** `10584415042`, `11570961952`, `10134372371`, `10848084400`, `10468707953`, `13656090865`
- **Canonical:** C092 Regional pricing

### R03-043 — No regional pricing in IN, TR, UA, SA — markets where the review text says the price is the only blocker

- **Where:** §1.7 #6
- **This app does:** single global price
- **User reaction:** blocked-conversion
- **Magnitude:** 6 IDs
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R03-034
- **Canonical:** C092 Regional pricing

### R03-073 — Localisation is an ignore-band theme here (9 reviews, 0.08%) despite the app being English-only — the anglophone core is 74% of reviews

- **Where:** Part 4 row 20
- **This app does:** English only
- **User reaction:** complaint
- **Magnitude:** 9 (0.08%), mean 3.89
- **Direction for us:** none · **Report confidence:** ignore · **Generalisable:** yes
- **Conditions:** contrast reports 1–2 where localisation was a top blocker; depends on where the audience is
- **Canonical:** C027 Localise early — it unlocks revenue

### R03-083 — All 23 storefronts with ≥50 reviews: n, mean, 1–2★, widget-paywall, any-paywall, sub-nag, price, free-praise, simple-praise, widget-praise — full table

- **Where:** Part 6 country table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** cc | Country | n | Mean | 1–2★ | Widget-paywall | Any-paywall | Sub-nag | Price | Free-praise | Simple-praise | Widget-praise ; us | United States | 5,600 | 4.77 | 3.3% | 1.5% | 2.4% | 1.8% | 1.2% | 4.4% | 35.5% | 9.6% ; gb | United Kingdom | 1,146 | 4.80 | 2.4% | 0.7% | 1.7% | 2.1% | 0.7% | 4.7% | 37.7% | 7.7% ; ca | Canada | 632 | 4.73 | 3.5% | 1.6% | 2.7% | 1.4% | 1.1% | 5.7% | 35.0% | 6.6% ; au | Australia | 383 | 4.78 | 2.3% | 0.5% | 1.8% | 2.9% | 1.0% | 7.6% | 42.3% | 8.6% ; in | India | 346 | 4.79 | 2.3% | 0.9% | 0.3% | 0.9% | 0.3% | 4.6% | 36.7% | 8.1% ; de | Germany | 294 | 4.75 | 3.7% | 0.3% | 1.4% | 1.7% | 2.4% | 5.1% | 26.9% | 8.8% ; nl | Netherlands | 110 | 4.57 | 5.5% | 0.0% | 0.9% | 2.7% | 1.8% | 5.5% | 35.5% | 13.6% ; za | South Africa | 100 | 4.87 | 1.0% | 0.0% | 0.0% | 0.0% | 0.0% | 8.0% | 30.0% | 5.0% ; ru | Russia | 98 | 4.83 | 1.0% | 0.0% | 1.0% | 0.0% | 0.0% | 2.0% | 13.3% | 4.1% ; mx | Mexico | 96 | 4.79 | 3.1% | 0.0% | 1.0% | 1.0% | 0.0% | 1.0% | 26.0% | 6.2% ; br | Brazil | 86 | 4.81 | 3.5% | 0.0% | 2.3% | 1.2% | 2.3% | 2.3% | 26.7% | 7.0% ; fr | France | 84 | 4.67 | 4.8% | 0.0% | 1.2% | 0.0% | 0.0% | 1.2% | 34.5% | 13.1% ; ae | UAE | 79 | 4.76 | 1.3% | 0.0% | 0.0% | 3.8% | 0.0% | 6.3% | 27.8% | 7.6% ; se | Sweden | 74 | 4.72 | 2.7% | 0.0% | 0.0% | 2.7% | 0.0% | 2.7% | 21.6% | 4.1% ; pl | Poland | 71 | 4.56 | 8.5% | 4.2% | 4.2% | 2.8% | 1.4% | 5.6% | 25.4% | 7.0% ; es | Spain | 68 | 4.72 | 2.9% | 1.5% | 1.5% | 2.9% | 1.5% | 5.9% | 29.4% | 7.4% ; sa | Saudi Arabia | 67 | 4.82 | 1.5% | 1.5% | 0.0% | 3.0% | 3.0% | 4.5% | 22.4% | 4.5% ; ph | Philippines | 64 | 4.80 | 1.6% | 1.6% | 1.6% | 0.0% | 0.0% | 1.6% | 37.5% | 9.4% ; nz | New Zealand | 63 | 4.71 | 1.6% | 0.0% | 0.0% | 0.0% | 0.0% | 4.8% | 42.9% | 7.9% ; dk | Denmark | 53 | 4.60 | 3.8% | 3.8% | 3.8% | 0.0% | 0.0% | 5.7% | 30.2% | 5.7% ; it | Italy | 52 | 4.52 | 5.8% | 0.0% | 1.9% | 0.0% | 1.9% | 5.8% | 21.2% | 11.5% ; ch | Switzerland | 51 | 4.84 | 2.0% | 0.0% | 0.0% | 2.0% | 0.0% | 7.8% | 41.2% | 5.9% ; ie | Ireland | 50 | 4.88 | 2.0% | 0.0% | 2.0% | 0.0% | 2.0% | 4.0% | 38.0% | 10.0%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R03-084 — The US (5,600 reviews, 52.7%) decides the rating and carries 84 of 128 widget-paywall complaints (65.6%) at 1.5% of US reviews vs 0.6% elsewhere; it is the only market where price/greed vocabulary reaches 1.2% — but not the angriest by rating (Poland 8.5% 1–2★, Italy 5.8%, Netherlands 5.5%)

- **Where:** §6.1
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** US n=5,600, mean 4.77, 3.3% 1–2★; 84/128 widget complaints
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the US is the most vocal about monetisation specifically
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R03-085 — The anglophone core (US+GB+CA+AU+NZ+IE) is 7,874 reviews (74.1%) at mean 4.77 — where the widget paywall did 81% of its damage, where free-tier praise is highest (AU 7.6%, CA 5.7%) and simplicity praise strongest (AU 42.3%, NZ 42.9%); positioning that works in one works in all

- **Where:** §6.2
- **This app does:** English-only app
- **User reaction:** mixed
- **Magnitude:** 7,874 (74.1%), mean 4.77; 104 of 128 widget complaints
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R03-086 — High-spend markets (US, GB, CA, AU, DE, FR, IT, ES, NL, SE, DK, CH, IE, NZ, SA, AE) hold 8,388 reviews (79.0%) at mean 4.77, 3.1% 1–2★

- **Where:** §6.3 opening
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 8,388 (79.0%), 4.77, 3.1%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R03-087 — Germany is the price-sensitive market: 2.4% of German reviews use price/greed language — double the US rate and the highest of any eligible market; '59,99€ is too much for me personally to pay for an app that basically tracks time'

- **Where:** §6.3 Germany
- **This app does:** €59.99 lifetime shown in DE
- **User reaction:** complaint
- **Magnitude:** DE n=294, price 2.4%
- **Direction for us:** research · **Report confidence:** meaningful (in-market) · **Generalisable:** yes
- **Review IDs:** `10931212725`, `12605773887`, `11589368716`, `14018922179`, `13413526077`, `12892307323`, `13879073912`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R03-088 — Denmark and Poland took the widget change hardest per capita (3.8% and 4.2% of their reviews) — 'Widgets suddenly premium only. No warning, no version update info about it'

- **Where:** §6.3 Denmark & Poland
- **This app does:** widget paywalled without release-note disclosure
- **User reaction:** 1★-burst
- **Magnitude:** DK 3.8%, PL 4.2% on small bases
- **Direction for us:** dont · **Report confidence:** limited evidence · **Generalisable:** yes
- **Side effects:** an undisclosed change in release notes is itself a complaint
- **Review IDs:** `12882383970`, `12990450515`, `12853744436`, `12944067790`, `13631461492`, `11887508168`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently; C001 Never move a free feature behind the paywall

### R03-089 — High-review-volume markets US, GB, CA, AU, IN, DE = 8,401 reviews (79.1%) — volume used strictly as a disclosed engagement proxy

- **Where:** §6.4 opening
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 8,401 (79.1%)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R03-090 — India is the anomaly: 346 reviews at 4.79 with 0.3% paywall and 0.3% nag complaints — five times lower than any other market; the only pricing feedback is a polite request for regional pricing ('I wish it were around ₹2000 than ₹5000') — a market that likes the product and has not yet been asked to pay a price it can accept

- **Where:** §6.4 India
- **This app does:** single global price (₹5,000/yr)
- **User reaction:** blocked-conversion
- **Magnitude:** IN n=346, mean 4.79, paywall 0.3%, nag 0.3%
- **Direction for us:** do · **Report confidence:** meaningful (in-market) · **Generalisable:** yes
- **Review IDs:** `8310546194`, `12352453901`, `9709310769`, `11511641881`, `13283082126`, `10134372371`, `10848084400`, `10468707953`, `9385157078`
- **Canonical:** C092 Regional pricing

### R03-091 — English-only yet shipped in 111 storefronts: only 9 reviews (0.08%) ask for translation, but the count is suppressed by selection — people who can't read the app don't write English reviews; only 67 reviews (0.63%) are in a non-Latin script, so non-English markets are systematically under-represented; one explicit lost sale ('PS : l'app n'est toujours pas traduite')

- **Where:** §6.5
- **This app does:** English only
- **User reaction:** blocked-conversion
- **Magnitude:** 9 (0.08%); 67 non-Latin-script reviews (0.63%)
- **Direction for us:** do · **Report confidence:** below threshold, selection effect · **Generalisable:** yes
- **Side effects:** a low localisation-request count in an English-only app is evidence of absence of non-English users, not absence of demand
- **Review IDs:** `8670657354`, `9782695829`, `7912950885`, `6937466468`, `11396418684`, `8890864234`, `9471638249`, `10584415042`, `12323759307`, `13189265606`
- **Canonical:** C027 Localise early — it unlocks revenue

### R03-106 — Regional pricing for IN, TR, UA, BR, MX, SA — India has 346 reviews, a 4.79 mean, near-zero monetisation friction and three reviews naming price as the only blocker: the largest untapped conversion pool visible

- **Where:** Part 8 #6
- **This app does:** single global price
- **User reaction:** blocked-conversion
- **Magnitude:** IN 346 at 4.79
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R03-034, R03-090
- **Canonical:** C092 Regional pricing

## Dated events and trends

### R03-003 — The best-loved free habit counter put its single most-praised feature — the widget — behind a paywall in July 2025; its 1–2★ rate went from 1.75% to 8.64% in one quarter and had not fully recovered fourteen months later

- **Where:** Part 0 summary line
- **This app does:** paywalled the widget July 2025
- **User reaction:** 1★-burst
- **Magnitude:** 1–2★ 1.75% (2025 Q2) → 8.64% (2025 Q3); mean 4.86 → 4.57
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** the clearest single-cause rating collapse in the corpus so far
- **Canonical:** C001 Never move a free feature behind the paywall

### R03-005 — Quarterly rating and 1–2★ rate around the July 2025 widget paywall — full table

- **Where:** Part 0 §2 quarter table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Quarter | n | Mean | 1–2★ ; 2025 Q1 | 570 | 4.82 | 2.11% ; 2025 Q2 | 456 | 4.86 | 1.75% ; 2025 Q3 | 741 | 4.57 | 8.64% ; 2025 Q4 | 502 | 4.65 | 6.18% ; 2026 Q1 | 337 | 4.52 | 9.79% ; 2026 Q2 | 442 | 4.64 | 6.11% ; 2026 Q3 (partial) | 382 | 4.74 | 3.14%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Conditions:** 2026 Q1 was worse than 2025 Q3 (9.79% 1–2★); partial recovery only by 2026 Q3 (3.14%)
- **Canonical:** — (nuance register)

### R03-006 — Widget-paywall complaints by month: 1 in May 2025 → 39 in July 2025 → 12 → 3 → 9 → 6 → 8 → 7, then 2–6 every month through Aug 2026 — 128 reviews total (1.21%, mean 2.48, 59.1% 1–2★)

- **Where:** Part 0 §2 monthly line
- **This app does:** widget paywalled
- **User reaction:** 1★-burst
- **Magnitude:** 128 (1.21%), mean 2.48, 59.1% 1–2★; peak 39 in the release month
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a re-paywall produces a spike and then a permanent floor of complaints
- **Canonical:** C001 Never move a free feature behind the paywall

### R03-007 — Four eras A–D: n, mean, 1–2★, free-tier praise, paywall complaint, widget-paywall complaint — full table

- **Where:** Part 0 §2 era table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era | n | Mean | 1–2★ | free-tier praise | paywall complaint | widget-paywall complaint ; A · Aug 2019 – Dec 2021 | 1,439 | 4.86 | 0.83% | 4.2% | 0.7% | 0.0% ; B · Jan 2022 – Jun 2023 | 2,984 | 4.83 | 1.47% | 3.8% | 0.9% | 0.2% ; C · Jul 2023 – Jun 2025 | 3,794 | 4.78 | 2.85% | 4.6% | 1.2% | 0.3% ; D · Jul 2025 – Sep 2026 | 2,404 | 4.62 | 6.95% | 6.1% | 5.4% | 4.5%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Conditions:** paywall complaints 1.2% → 5.4% and widget-paywall 0.3% → 4.5% across a single release boundary; 1–2★ 0.83% (A) → 6.95% (D)
- **Canonical:** — (nuance register)

### R03-030 — The eleven 1–2★ payers, in full — what each paid for and what happened

- **Where:** §1.4 1–2★ payer table (verbatim)
- **This app does:** cannot find the tier they paid for; charged $17.99 twice a week for a month after cancelling; subscription not recognised on Mac, no iCloud sync; premium buyer still upsold every launch for months; cannot set future dates, support silent two weeks; paid for Lock Screen widget but cannot choose the counter; charged for a monthly sub never agreed to and data gone; counter 2 days off at 2 years; cannot find how to cancel; Lifetime buyer still told to subscribe for widgets; reset broken and no iPad↔iPhone sync
- **User reaction:** 1★-burst
- **Magnitude:** ID | Market | Date | What they paid for, and what happened ; `9912775984` | US | 2023-05 | Bought a subscription; cannot find the Count Up Club they paid for ; `10263513150` | US | 2023-08 | Charged $17.99 twice a week for a month after cancelling the yearly plan ; `10570659048` | FR | 2023-11 | Paid; app doesn't recognise the subscription on Mac, no iCloud sync, data lost on delete ; `10764707061` | US | 2023-12 | Bought premium years ago; still gets the upsell for the new tier on every launch, for months ; `11148249366` | US | 2024-04 | Paid a year in advance; cannot set future dates or edit counters; support silent for two weeks ; `13115850782` | US | 2025-09 | Paid for premium specifically for the Lock Screen widget; can't choose which counter it shows ; `13704550155` | US | 2026-02 | Charged for a monthly sub they say they never agreed to, and all data gone; requested refund ; `13843033653` | US | 2026-03 | Paid full price; counter is 2 days off at the 2-year mark ; `13964501187` | US | 2026-04 | Cannot find how to cancel; "a ploy to keep you paying"
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** six of eleven are billing or entitlement failures, not product complaints
- **Review IDs:** `9912775984`, `10263513150`, `10570659048`, `10764707061`, `11148249366`, `13115850782`, `13704550155`, `13843033653`, `13964501187`, `14060380344`, `14144614865`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C033 Restore purchase and entitlements must work immediately; C029 Billing must be exactly right

### R03-093 — Reviews per year: 7 / 151 / 1,281 / 2,275 / 1,314 / 2,163 / 2,269 / 1,161 (2019–2026 partial) — a growing, actively developed app; v4.1.0 shipped six days before the last review

- **Where:** §7.1
- **This app does:** active development
- **User reaction:** praise
- **Magnitude:** 2,275 peak (2022); 2,269 (2025)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R03-094 — Mean by year 4.43 → 4.71 → 4.88 → 4.85 → 4.74 → 4.78 → 4.71 → 4.64 (2019–2026); 1–2★ 2.0% → 0.6% → 1.1% → 3.6% → 2.8% → 5.1% → 6.2%

- **Where:** §7.2 lines
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2026 mean 4.64, 1–2★ 6.2%
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R03-095 — First monetization shock, late 2022: 1–2★ jumped 0.92% → 3.87% when the 'Count Up Club' subscription launched with upsell spam and the widget reset button removed from free — 'must pay $18 to begin using the app' — survivable: the app recovered to 4.82 by 2025 Q1

- **Where:** §7.2 event 1
- **This app does:** launched subscription Q4 2022; removed widget reset from free
- **User reaction:** 1★-burst
- **Magnitude:** 0.92% → 3.87% 1–2★ in 2022 Q4; recovered by 2025 Q1
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a subscription launch with nagging costs ~3 points of 1–2★ for two years even when the product is untouched
- **Conditions:** contrast event 2: taking away an existing free feature was not survivable in the same window
- **Review IDs:** `9178559150`, `9211936118`, `9246079791`, `9438566929`, `9444704937`, `9027024142`, `9036334050`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C093 No upsell nagging without a 'never ask again' option

### R03-096 — Second shock, July 2025: 1–2★ 1.75% → 8.64% on the widget paywall; fourteen months later it has not returned to its 2025 Q2 baseline — the decline is two discrete events, not gradual erosion

- **Where:** §7.2 event 2
- **This app does:** paywalled the widget
- **User reaction:** 1★-burst
- **Magnitude:** 1.75% → 8.64%; not recovered after 14 months
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall

### R03-097 — Worsening: paywall complaints 0.7% (era A) → 5.4% (era D), an 8× increase; widget paywall 0.0% → 4.5%; price/greed language 6 reviews (2020–21) → 60 (2025–26)

- **Where:** §7.3
- **This app does:** monetisation tightened over time
- **User reaction:** complaint
- **Magnitude:** 8× paywall complaints; 10× price/greed
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C093 No upsell nagging without a 'never ask again' option

### R03-098 — Stable: simplicity praise holds at 26–42% of every era — the core value has not degraded; free-tier praise actually ROSE in era D (4.6% → 6.1%) because free users who kept their widget wrote defensively positive reviews; milestone requests constant 2020→2026

- **Where:** §7.4
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** simplicity 26–42% every era; free praise 6.1% in era D
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** a paywall fight produces defensive 5★ reviews from the unaffected as well as 1★ from the affected
- **Review IDs:** `14456318136`, `14211548185`, `13053535012`, `12957382577`, `14364118481`
- **Canonical:** C006 Stay minimal and ad-free; C007 Generous fixed habit cap (or unlimited) — never change it

### R03-099 — Fixed: 'can't backdate / edit start date' was an early 1★ defect ('Can't set date — worthless app', Dec 2019) that largely disappears after 2022 and is now praised as a differentiator — evidence of a real fix

- **Where:** §7.5 backdate
- **This app does:** fixed date editing by 2022
- **User reaction:** praise
- **Magnitude:** 7 early 1★ IDs → 5 later praise IDs
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** an editable start date is table stakes for a counter; when present it is praised
- **Review IDs:** `5264212724`, `5492378192`, `6396319937`, `6431260025`, `5530635157`, `6614014666`, `5543491910`, `8568493851`, `7795420959`, `12377633896`, `13066783750`, `8913462962`
- **Canonical:** C010 Backfill missed days / edit start date

## Positioning

### R03-001 — Days Since is the best-loved free quit-habit counter on the App Store: 10,621 reviews at 4.77, 19,073 US ratings at 4.82, English only, on iPhone / iPad / Mac / Watch / Vision Pro; current version 4.1.0 (31 Aug 2026)

- **Where:** header line 3-6
- **This app does:** developer A Couple of Friends OOD, bundle npetrova.DaysSince, team named in reviews as Ivo, Nadya, Stan, Petar; free download; IAP 'Count Up Club' monthly $2.99 / $5.99, yearly $17.99, lifetime $49.99 (discounted $11.99); legacy 'Premium' monthly $9.99, yearly $29.99
- **User reaction:** praise
- **Magnitude:** 10,621 reviews, 111 storefronts, Aug 2019 → Sep 2026; category Health & Fitness / Productivity; age 12+
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Conditions:** a quit-habit / day-counter app, not a routine tracker — audience and moral framing differ (Part 0 §5, Part 5)
- **Canonical:** — (nuance register)

### R03-045 — Multiple / unlimited counters is the explicit switch reason from I Am Sober (which caps at 2)

- **Where:** Part 2 5★ row 4
- **This app does:** unlimited counters free
- **User reaction:** purchase-driver
- **Magnitude:** 215 of 5★ (2.3%); 244 corpus-wide (2.3%); 30 direct I Am Sober comparisons at mean 4.47
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** a competitor's quantity cap is a stated acquisition channel
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C005 Know which competitors buyers compare against

### R03-049 — 'Too basic / glorified stopwatch' is 5.8% of 1★ — the flip side of radical simplicity

- **Where:** Part 2 1★ row 'Too basic'
- **This app does:** minimal by design
- **User reaction:** complaint
- **Magnitude:** 13 of 225 1★, 4 of 106 2★
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** simplicity is the core engine (36.4% of 5★); the 'too basic' minority is the price of it
- **Canonical:** C006 Stay minimal and ad-free

### R03-054 — 'Actually free' (495, 4.66%) and the reviews name the competitor: 30 compare directly to I Am Sober, almost all citing its 2-counter cap as the reason they left — and two now recommend I Am Sober BECAUSE of this app's widget paywall

- **Where:** Part 3 §3
- **This app does:** free, unlimited counters
- **User reaction:** purchase-driver
- **Magnitude:** 495 (4.66%); 30 I Am Sober comparisons (mean 4.47); 2 reversed after the paywall
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Side effects:** the competitive risk made explicit: the gating that won users from a competitor can send them back
- **Review IDs:** `8132517827`, `8256187600`, `9356129632`, `12268649843`, `10931567211`, `9276814946`, `13185972322`, `10733606008`, `12102036646`, `11100020455`, `13471712113`, `13960930426`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C005 Know which competitors buyers compare against

## Anti-patterns

### R03-010 — The change was never cleanly resolved: developer replies framed the widget lock-out as a bug and some users saw it reversed, but 31 widget-paywall complaints are dated 2026 (mean 2.32) and one says 'Contrary to the response, widgets are still unavailable for me' — users experienced a paywalled widget continuously from July 2025 to August 2026

- **Where:** Part 0 §4
- **This app does:** called it a bug, partially rolled back (or bug persisted for a subset)
- **User reaction:** 1★-burst
- **Magnitude:** 31 complaints in 2026, mean 2.32; 3 reviews report reversal
- **Direction for us:** dont · **Report confidence:** inference labelled · **Generalisable:** yes
- **Side effects:** an ambiguous rollback ('it was a bug') is a second, separate problem: it leaves a subset of users locked out for a year while the developer's public position says otherwise
- **Conditions:** either reading — real paywall partially reversed, or a year-long bug — is bad
- **Review IDs:** `13144348194`, `13191073060`, `12875864707`, `12948474679`, `13613452424`, `13631461492`, `13636462913`, `13671837531`, `13678847520`, `13695081586`, `13710553115`, `13723431455`, `13876121897`, `13913566646`, `13942312007`, `13961326758`, `14010071469`, `14060380344`, `14066383785`, `14107888082`, `14161669986`, `14191526502`, `14191530864`, `14213949714`, `14245206810`, `14245784209`, `14250178496`, `14254252346`, `14324807045`, `14325023621`, `14340732263`, `14345891389`, `14392573700`, `14475428849`, `14489833893`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently

### R03-035 — Subscription nagging is chronic: 176 reviews (1.66%, mean 4.35) complain about upgrade pop-ups, present in every era and peaking 2024 — 73% of them are 5★ users who like the app enough to keep it and still complain; there is no 'no, never' option; a permanent banner hides the third row of counters

- **Where:** §1.6 opening + quotes
- **This app does:** full-screen upsell interstitials, permanent banner, settings reminder; no opt-out
- **User reaction:** complaint
- **Magnitude:** 176 (1.66%), mean 4.35; 129 of 176 (73%) are 5★
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Side effects:** 'Leave me alone and let me actually experience the app as a first time user before telling me the extra features'
- **Conditions:** upsell before first value is the specific complaint; a 'never ask again' control is the specific fix
- **Review IDs:** `12456220146`, `9347710178`, `12041109291`, `13413526077`, `13223954026`, `10507973491`, `11447347782`, `11764640342`, `12781765544`, `11631487359`, `11053407529`, `9532159519`, `10801499811`, `11851863331`, `12091997037`, `14185154968`, `14341258724`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R03-036 — 11 reviews complain about review-prompt nagging — three from paying customers — including one whose iOS opt-out of review prompts is ignored 'even on the lifetime paid plan'; 'comes across as scammy'

- **Where:** §1.6 review-prompt paragraph
- **This app does:** in-app review prompts that ignore the iOS opt-out and hit payers
- **User reaction:** complaint
- **Magnitude:** 11 reviews, 3 from payers
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12282678957`, `10818110589`, `11519112210`, `13083333768`, `10094842714`, `12520439155`, `12029565290`, `11640646593`, `13352415665`, `14339177491`, `14248121134`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C088 No rating-prompt or cross-promo spam, especially to payers

## Things not to do

### R03-041 — Nagging users who already said no — 176 reviews and no 'never ask again' control

- **Where:** §1.7 #4
- **This app does:** no opt-out on upsell
- **User reaction:** complaint
- **Magnitude:** 176 (1.66%)
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R03-035
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R03-107 — Add a 'don't ask again' control for the upgrade prompt — 176 reviews, 73% from 5★ users; costs nothing and buys back a percentage point of rating

- **Where:** Part 8 #7
- **This app does:** no opt-out
- **User reaction:** complaint
- **Magnitude:** 176 (1.66%)
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Conditions:** evidence: R03-035, R03-041
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R03-108 — Respect the iOS 'no in-app review prompts' setting — a lifetime customer is telling you you're violating a system preference

- **Where:** Part 8 #8
- **This app does:** review prompts ignore the OS opt-out
- **User reaction:** complaint
- **Magnitude:** 11 reviews, 3 payers
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Conditions:** evidence: R03-036
- **Review IDs:** `10818110589`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R03-121 — Do not monetise the vulnerable-user surface — in a category where users track self-harm and suicide attempts, 'preying on addicts' framing spreads faster than any feature

- **Where:** Part 8 #21
- **This app does:** aggressive paywall on a recovery tool
- **User reaction:** 1★-burst
- **Magnitude:** 11 accusations
- **Direction for us:** dont · **Report confidence:** weak count, reputational · **Generalisable:** yes
- **Conditions:** evidence: R03-011, R03-080
- **Canonical:** C103 Recovery and harm-reduction users are a vulnerable surface

### R03-122 — Do not ship a paywall change silently — 'No warning, no version update info about it'; if the July 2025 lock-out really was a bug, the absence of a release note is why nobody believed it

- **Where:** Part 8 #22
- **This app does:** undisclosed change
- **User reaction:** complaint
- **Magnitude:** DK/PL complaints
- **Direction for us:** dont · **Report confidence:** limited evidence, clear mechanism · **Generalisable:** yes
- **Conditions:** evidence: R03-010, R03-088
- **Review IDs:** `12882383970`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently

## Things to do

### R03-117 — Lead with 'unlimited counters, free, private' — the three things advocates say unprompted, and all three are why people leave I Am Sober

- **Where:** Part 8 #17
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 30 I Am Sober comparisons, mean 4.47
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Conditions:** evidence: R03-045, R03-054, R03-055
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C096 Privacy and discretion stack; C005 Know which competitors buyers compare against

## Contradictions

### R03-082 — The two audiences want opposite things: recovery users want the number to go UP and hate the reset button; chore users want it to stay LOW and reset constantly — 10 reviews ask for an 'invert' or 'good habit' mode; one counter type, two mental models

- **Where:** Part 5 product implication
- **This app does:** one counter type
- **User reaction:** mixed
- **Magnitude:** 10 invert-mode requests
- **Direction for us:** research · **Report confidence:** clear mechanism · **Generalisable:** yes
- **Conditions:** a 'good habit / invert' mode reconciles them; the reset affordance must differ per mode
- **Review IDs:** `12014211393`, `8197401481`, `9503479974`, `9917027140`, `11689561035`, `8690192526`, `9766598371`, `8168145206`, `8298887438`, `11810992187`
- **Canonical:** C102 Inverse / 'good habit' mode for a counter; C019 Quit-habit / bad-habit mode

### R03-124 — Report 3 says backup / iCloud sync must be free (losing sobriety history is an unrecoverable brand event); report 1 found iCloud sync the strongest paid differentiator (lift ×9.8) — the resolution the reports imply is: backup/restore of the user's own data free, multi-device live sync can be paid

- **Where:** Part 4 C + Part 8 #2 vs report 1 §1.3
- **This app does:** backup and sync paid
- **User reaction:** 1★-burst
- **Magnitude:** here: 44 reviews mean 3.91, 9 data losses, 'Back up is literally PREMIUM?'; report 1: sync 9.0% of buyers, ×9.8
- **Direction for us:** undecided · **Report confidence:** cross-report · **Generalisable:** yes
- **Conditions:** the distinction is data safety (must be free) vs convenience (can be paid)
- **Review IDs:** `13629061971`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C034 Data must never be lost on update, reinstall or phone change

## Data caveats and method

### R03-002 — Method: bands applied against all 10,621 globally and separately against each of the 23 storefronts with ≥50 reviews (9,667 reviews, 91.0%); the other 88 storefronts hold 954 (9.0%, mean 4.78) and get no standalone claims; one review = 0.0094%; theme membership non-exclusive

- **Where:** How to read this
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 23 storefronts ≥50; 88 below
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R03-092 — 88 storefronts under 50 reviews hold 954 reviews (9.0%) at mean 4.78 — indistinguishable from the global mean; no standalone claims

- **Where:** §6.6
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 954 (9.0%), 4.78
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `12982439459`, `13722672404`, `8894412160`
- **Canonical:** — (nuance register)

### R03-123 — Method: 10,621 records, zero duplicates, 100% reconciliation; all reviews read in full (1–4★ first, then 9,250 5★) across 28 languages; regex candidates then manual false-positive removal; confirmed-payer list fully hand-curated (n=45 — direction robust, figure not); 22.1% of bodies under 40 chars at mean 4.83; 8 of 23 eligible storefronts sit at 50–71 reviews; the July 2025 event cannot be fully adjudicated from reviews alone; causal claim rests on three independent lines (monthly spike 1→39, quarterly discontinuity, first-person narration)

- **Where:** Appendix — method
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 10,621 reviews; 5★ 9,250 / 4★ 849 / 3★ 191 / 2★ 106 / 1★ 225; mean 4.7694; is_edited 121 (1.14%); 187 with helpfulness votes; two external sources accessed 2026-09-09
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `14060380344`
- **Canonical:** — (nuance register)
