# Cards — report 14

Source: `App Store Reports/14. My Habits - Daily Habit Builder - Tracker for Goals & Routine (REPORT).md`  
58 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 1
- [Must-haves](#must-haves) — 1
- [Must never break](#must-never-break) — 6
- [Features](#features) — 9
- [Monetization](#monetization) — 6
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 8
- [Markets and languages](#markets-and-languages) — 3
- [Dated events and trends](#dated-events-and-trends) — 6
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 8

## Product rules

### R14-055 — Make the upsell earn its place: trigger it on a value moment (a completed week, the cap being hit), never on launch — one user kept intent despite the pop-ups, another lost it because of them; same mechanism, opposite outcomes, decided by timing

- **Where:** §8.3 M3 Make the upsell earn its place — trigger it on a value moment, never on launch
- **This app does:** upsell on launch
- **User reaction:** mixed
- **Magnitude:** n=2 contrasting
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `1099032136`, `1130585398`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C137 Show the paywall at the moment of need, not on app open

## Must-haves

### R14-056 — Answer support — the one recorded support interaction turned a billing failure into a 5★ review; the highest-leverage single action in the corpus

- **Where:** §8.3 M4 Answer support — the highest-leverage single action in the corpus
- **This app does:** responsive support (once)
- **User reaction:** praise
- **Magnitude:** n=1 (5★)
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `1036447473`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

## Must never break

### R14-006 — Data loss is the only theme with a perfect 1★ record: 'After months of tracking it's all gone in the latest update. Stay away from this app if you value your data'; 'After the update all my marks disappeared'; 'I don't want to backdate all my progress by memory (again)' — the first two are one day apart (a single bad release in May 2015), the 2020 '(again)' shows it recurred 5.5 years later; for a streak tracker the accumulated chain IS the product; the only review telling other buyers to stay away

- **Where:** Part 0 §3 Data loss is the only theme with a perfect 1★ record
- **This app does:** update wiped tracked history, twice
- **User reaction:** 1★-burst
- **Magnitude:** 3 (4.29%) mean 1.00, all 1★; 9–10 May 2015 + 25 Nov 2020
- **Direction for us:** must-never-break · **Report confidence:** very strong (counts) · **Generalisable:** yes
- **Review IDs:** `1195475837`, `1194862743`, `6684084592`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C175 Updates must not break function or wipe progress

### R14-007 — Crashes bracket the entire lifespan and are what the app died of: the lowest-rated theme; the app broke at each major iOS transition and was repaired slowly or not at all — 'Opens but then crashes with new iOS 14. Same thing happened with iOS 13 and it took them a while to fix it… if this is not fixed by next week I will just delete the app'; the 2020 crash fires on the single most-used action, checking a habit off; a date that never rolls over requiring a device restart every day; v1.7 shipped five weeks after and is still current — whether it fixed the crash is unknowable from two later 4★ reviews; the reliability problem is a maintenance-capacity problem, not a coding problem

- **Where:** Part 0 §4 Crashes bracket the entire lifespan and are what the app died of; table (verbatim)
- **This app does:** crashes at iOS 13/14 transitions; slow or no fixes
- **User reaction:** 1★-burst
- **Magnitude:** 6 (8.57%) mean 1.50 (4 of 6 1★); Date | ID | Ctry | ★ | Failure ; 2014-03-18 | `961881835` | kr | 3 | *"It keeps crashing down from the beginning"* — on the then-latest iOS ; 2014-10-09 | `1077393973` | jp | 2 | Date never rolls over; device restart required every single day to log ; 2015-04-02 | `1176859130` | ru | 1 | *"It just glitches" / "Doesn't work at all"* ; 2015-08-12 | `1241930865` | kr | 1 | *"it has too slow response"* ; 2020-11-23 | `6678082433` | de | 1 | *"closes (crashes?) every time when touching the calendar to mark habit as done. It's completely unusable"* ; 2020-11-25 | `6684084592` | gb | 1 | *"Opens but then crashes with new IOS 14. Same thing happened with the new IOS 13 and it took them a while to fix it"*
- **Direction for us:** must-never-break · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `961881835`, `1077393973`, `1176859130`, `1241930865`, `6678082433`, `6684084592`, `7082831771`, `7929736347`
- **Canonical:** C031 Crashes / launch failures; C071 Never ship and walk away; C175 Updates must not break function or wipe progress

### R14-042 — Never destroy user history on update: migration tests, automatic pre-migration backup and a visible restore path — in a streak tracker the accumulated chain IS the product

- **Where:** §8.1 I1 Never destroy user history on update — migration tests, automatic pre-migration backup, visible restore path
- **This app does:** history wiped on update
- **User reaction:** 1★-burst
- **Magnitude:** N3 3 (4.29%) mean 1.00
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `1195475837`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in; C175 Updates must not break function or wipe progress

### R14-043 — Treat the check-off action as tier-zero: it must never crash and must be covered by an OS-beta regression test before every major iOS release — the app broke on iOS 13 and again on iOS 14

- **Where:** §8.1 I2 Treat the check-off action as tier-zero — never crash, OS-beta regression test before every major iOS release
- **This app does:** check-off crashes after OS updates
- **User reaction:** 1★-burst
- **Magnitude:** N2 6 (8.57%) mean 1.50
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `6678082433`
- **Canonical:** C031 Crashes / launch failures; C175 Updates must not break function or wipe progress

### R14-045 — Instrument and repair the upgrade flow and alert on purchase-sheet failures — 'the orange screen' is willing money that never arrived; a freemium app with a broken buy button monetises nothing

- **Where:** §8.1 I4 Instrument and repair the upgrade flow; alert on purchase-sheet failures
- **This app does:** purchase sheet fails silently
- **User reaction:** blocked-conversion
- **Magnitude:** N6 2 (2.86%), both 4★
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `6183382407`
- **Canonical:** C077 Purchase and signup flow must not leak buyers

### R14-046 — Fix date rollover: the app must advance to the new day without a restart — 'having to restart every single day' breaks the one daily interaction the product exists for

- **Where:** §8.1 I5 Fix date rollover — the app must advance to the new day without a restart
- **This app does:** date never rolls over
- **User reaction:** complaint
- **Magnitude:** n=1 (jp, 2★)
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `1077393973`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

## Features

### R14-014 — Feature inventory: calendar/grid check-off ('green day'), streak/chain, good and bad habits, statistics and graphs, reminders, editing/backdating, works fully offline, multiple habits at a glance, counted habits with a max of 6 per day, a habit 'diary'; confirmed absent and requested: iPad/universal, widget, colour schemes, adjustable font size, per-day alarm scheduling, weekly/monthly trend views, non-daily periodicity, onboarding tutorial, Russian localisation

- **Where:** §2.1 Feature inventory derived from reviews table (verbatim); confirmed absent list
- **This app does:** see table
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence | Confidence ; Daily habit check-off on a calendar / grid ("green day", "green square") | `1076855737`, `1184550500`, `6678082433` | High ; Streak / chain tracking ("Seinfeld streak") | `1076855737`, `1184550500` | High ; Tracks both good habits to build and bad habits to break | `1002707223`, `959856482`, `1076855737` | High ; Progress statistics and graphs of past entries | `1036447473`, `1076855737`, `1120439485`, `961110962`, `1195988013` | High ; Reminders / scheduled alarms | `1147730742`, `1208386132`, `1132075503`, `1190931941` | High ; Editing or backdating previous days | `1184550500` | Medium ; Works fully offline, no network needed to check in | `1195988013` | Medium ; Multiple habits visible at a glance on one screen | `1113922936`, `1076855737` | Medium ; Counted habits with a maximum of 6 entries per day | `1054073250` | Low (single source) ; Habit "diary" | `1208386132` | Low (single source) ; absent: iPad, widget, colour schemes, font size, per-day alarms, trend views, non-daily periodicity, tutorial, Russian
- **Direction for us:** research · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `1076855737`, `1184550500`, `6678082433`, `1002707223`, `959856482`, `1036447473`, `1147730742`, `1208386132`, `1195988013`, `1113922936`, `1054073250`, `1195162150`, `1407746285`, `1056568978`, `1190931941`, `1026996445`, `7082831771`, `1174519073`
- **Canonical:** — (nuance register)

### R14-015 — Praised or noted capabilities: works fully offline; tracks both good habits to build and bad habits to break; counted habits capped at 6 entries per day

- **Where:** §2.1 Works fully offline, no network needed to check in; Tracks both good habits to build and bad habits to break; Counted habits with a maximum of 6 entries per day
- **This app does:** offline; good + bad habits; counted habits max 6/day
- **User reaction:** praise
- **Magnitude:** offline n=1; good/bad 3; 6/day cap n=1
- **Direction for us:** build-free · **Report confidence:** medium/low · **Generalisable:** yes
- **Review IDs:** `1195988013`, `1002707223`, `959856482`, `1054073250`
- **Canonical:** C019 Quit-habit / bad-habit mode; C143 Intra-day completion: tap N times to fill N/N; C188 The app must open offline — never block launch on a network call

### R14-018 — Positive drivers beyond effectiveness and simplicity: a clean interface, visible statistics and progress records, reminders that work, streak/green-square satisfaction, a previously reported problem being fixed, and the ability to edit or backdate previous days ('on some apps you can't do this… you can't go back')

- **Where:** §3.1 P3 Attractive / clean interface; P4 Statistics and visible progress records; P6 Reminders work; P7 Streak/green-square satisfaction; P8 A previously reported problem was fixed; P11 Can edit/backdate previous days
- **This app does:** stats, reminders, streak grid, backdating — all present
- **User reaction:** praise
- **Magnitude:** P3 6 (8.57%) 4.67; P4 5 (7.14%) 5.00; P6 3 (4.29%) 5.00; P7 2 (2.86%) 5.00; P8 2 (2.86%) 5.00; P11 1 5.00
- **Direction for us:** build-free · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `961128068`, `1118980626`, `961110962`, `1120439485`, `1132075503`, `1147730742`, `1076855737`, `1184550500`, `1193853972`, `1197160923`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C010 Backfill missed days / edit start date; C011 Weekly / monthly / yearly reports; C024 Streaks / gamification; C059 Be visibly responsive; fixes bring reviewers back

### R14-019 — Negative themes beyond nags, crashes and data loss: the free-tier caps (3 habits; 6 daily entries), a dated interface or unintuitive navigation, no tutorial, and updates months or years apart

- **Where:** §3.1 N4 Free-tier limits hit (3 habits; 6 daily entries); N5 Interface dated or navigation unintuitive; N10 No tutorial; N11 Updates months or years apart
- **This app does:** 3-habit cap; 6-entry cap; no tutorial; stale UI
- **User reaction:** complaint
- **Magnitude:** N4 3 (4.29%) 3.33; N5 3 (4.29%) 2.67; N10 1 1.00; N11 1 1.00
- **Direction for us:** research · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `1174519073`, `6183382407`, `1054073250`, `1138108331`, `1262227277`, `6684084592`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C071 Never ship and walk away; C075 Skippable, replayable onboarding tour

### R14-021 — Every feature request: Russian localisation (2), iPad/universal, weekly/monthly trend views, raise the 6-entries-per-day cap, adjustable font size, a tutorial, per-day alarm scheduling, widget, colour schemes, non-daily periodicity — a list of leads, not a ranked backlog

- **Where:** §3.3 Unmet needs — every feature request in the corpus table (verbatim); a list of leads, not a ranked backlog
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 12 (17.14%) mean 3.42, 7 of 12 at 4–5★; Request | n | IDs | ★ ; Russian localisation | 2 | `1157833711`, `1265490751` | 3, 2 ; iPad / universal app | 1 | `1002707223` | 5 ; Weekly and monthly trend views | 1 | `1026996445` | 1 ; Raise the 6-entries-per-day cap | 1 | `1054073250` | 5 ; Adjustable font size | 1 | `1056568978` | 4 ; A tutorial / clearer first-run guidance | 1 | `1174519073` | 1 ; Per-day alarm scheduling (weekday vs weekend) | 1 | `1190931941` | 4 ; Home-screen widget | 1 | `1195162150` | 5 ; Removal from purchase list | 1 | `1367475729` | 3 ; Colour scheme options | 1 | `1407746285` | 4 ; Non-daily habit periodicity | 1 | `7082831771` | 4
- **Direction for us:** research · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `1157833711`, `1265490751`, `1002707223`, `1026996445`, `1054073250`, `1056568978`, `1174519073`, `1190931941`, `1195162150`, `1367475729`, `1407746285`, `7082831771`
- **Canonical:** C009 Basic widgets, icons and colours are free; C011 Weekly / monthly / yearly reports; C027 Localise early — it unlocks revenue; C043 Flexible / custom frequency; C075 Skippable, replayable onboarding tour; C080 Colour themes / dark mode; C141 Native iPad layout; C143 Intra-day completion: tap N times to fill N/N

### R14-022 — Two requests are worth more than their counts because both point at the same structural gap — the scheduling model is too rigid for real routines: 'Could the period be changeable rather than limited to daily only? There are habits I want to track over the long term' (the app's most recent substantive feedback; a strictly daily grid cannot represent '3× a week') and 'I have very different life style between weekdays and weekend. So I need more alarm setting properties'

- **Where:** §3.3 Two are worth more than their counts — non-daily periodicity is a structural limit of the data model; per-day alarm scheduling (weekday vs weekend)
- **This app does:** daily-only grid; one alarm schedule for all days
- **User reaction:** complaint
- **Magnitude:** n=1 each (1.43%), both 4★
- **Direction for us:** must-have · **Report confidence:** n=1 each, structural · **Generalisable:** yes
- **Review IDs:** `7082831771`, `1190931941`
- **Canonical:** C014 Multiple reminders per habit; C043 Flexible / custom frequency

### R14-047 — Support non-daily periodicity (n× per week, every n days) and per-day-of-week reminder schedules — a data-model limit and the app's most recent substantive feedback

- **Where:** §8.2 B1 Support non-daily habit periodicity and per-day-of-week reminder schedules
- **This app does:** daily-only
- **User reaction:** complaint
- **Magnitude:** n=1 + n=1
- **Direction for us:** must-have · **Report confidence:** recommendation (build next) · **Generalisable:** yes
- **Review IDs:** `7082831771`, `1190931941`
- **Canonical:** C014 Multiple reminders per habit; C043 Flexible / custom frequency

### R14-048 — Add weekly and monthly trend views above the daily grid — the only dissatisfied confirmed payer named this exact gap and said they would revise their rating; aligns with statistics praise (5 reviews, all 5★)

- **Where:** §8.2 B2 Add weekly and monthly trend views above the daily grid
- **This app does:** daily trend only
- **User reaction:** complaint
- **Magnitude:** N8 n=1 (1★ payer); P4 5 (7.14%) 5.00
- **Direction for us:** build-paid · **Report confidence:** recommendation (build next) · **Generalisable:** yes
- **Review IDs:** `1026996445`
- **Canonical:** C011 Weekly / monthly / yearly reports; C012 Week / month / year grid views

### R14-052 — Ship the small asks — iPad/universal, widget, colour schemes, adjustable font size, raise the 6-entry cap: each is one review, collectively 5 of 12 requests, all from 4–5★ users, and one makes a purchase conditional on font size

- **Where:** §8.2 B6 Ship the small asks — iPad/universal, widget, colour schemes, font size, raise the 6-entry cap
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 5 of 12 requests, all 4–5★
- **Direction for us:** build-free · **Report confidence:** recommendation (build next) · **Generalisable:** yes
- **Review IDs:** `1002707223`, `1195162150`, `1407746285`, `1056568978`, `1054073250`
- **Canonical:** C009 Basic widgets, icons and colours are free; C080 Colour themes / dark mode; C141 Native iPad layout; C143 Intra-day completion: tap N times to fill N/N; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

## Monetization

### R14-008 — Purchase intent is three times more common than evidence of purchase — 'With free apps the whole point is to try it before you decide'; 'Will continue to evaluate for a week or so but if I'm still just as happy I'll be upgrading'; 'Well worth trying out and paying for the upgrade' — while the only confirmed buyer at $3 found it 'too basic for the $3 expended' (wanted weekly/monthly trends), and two willing buyers in 2020 could not complete the purchase ('When I click upgrade button, it only appears an orange screen and then disappears'; 'I couldn't find the extended version') five to seven months before the last-ever release; demand to pay was present, articulated and repeatedly obstructed — first by the upsell's tone, later by a broken checkout

- **Where:** Part 0 §5 Purchase intent is three times more common than evidence of purchase, and the buy button was broken; intent table (verbatim)
- **This app does:** 3-habit free cap; one-time Pro unlock; upgrade button broken in 2020
- **User reaction:** blocked-conversion
- **Magnitude:** intent 6 (8.57%) mean 4.50; paid explicit 2 (2.86%) + 1 implied; purchase blocked 2 (2.86%) both 4★; refused 2 (2.86%) both 2★; ID | Ctry | ★ | Statement ; `1056568978` | ru | 4 | *"Please add option change type size… After I will buy, and will recommended it for all my friends"* ; `1128016301` | kr | 4 | *"With free apps the whole point is to try it before you decide"* ; `1130585398` | us | 5 | *"Trying it out a little longer before I purchase the full version"* ; `1137963077` | kr | 4 | *"I think I'll go Pro"* ; `1184550500` | au | 5 | *"Will continue to evaluate for a week or so but if I'm still just as happy I'll be upgrading to the full version"* ; `1222427563` | gb | 5 | *"Well worth trying out and paying for the upgrade"*
- **Direction for us:** must-never-break · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `1056568978`, `1128016301`, `1130585398`, `1137963077`, `1184550500`, `1222427563`, `1026996445`, `1036447473`, `6183382407`, `5929885128`, `1174519073`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C061 Goodwill conversion — a generous free tier and 'support the devs'; C077 Purchase and signup flow must not leak buyers

### R14-016 — Monetisation: free download capped at 3 habits, one-time 'full version'/'Pro' IAP — $3 in 2014, $1.99 'Premium Access' today; weekly/monthly trend analysis evidently not in the paid tier either (requested by a paying user); two model changes visible — a mid-2014 monetisation model change with a separate paid SKU, and a price reduction; one 2016 disclosure complaint that IAPs were not indicated in the store (now labelled)

- **Where:** §2.2 Monetisation model table (verbatim); two model changes; one disclosure complaint
- **This app does:** free (3 habits) + $1.99–$3 one-time unlock
- **User reaction:** mixed
- **Magnitude:** Element | Classification | Evidence ; App download | Free | `1128016301`, `1130585398`, `1113922936` all describe a "free version" ; Habit count in free tier | Free, capped at 3 | `1174519073`: *"you can only track 3 habits for free"* ; "Full version" / "Pro" unlock | Paid, one-time IAP | `1130585398`, `1184550500`, `1137963077`, `1222427563` ; Price paid in 2014 | $3 | `1026996445` — *"the $3 expended"* ; Price today | $1.99, "Premium Access" | Store listing, 9 Sep 2026 ; Weekly/monthly trend analysis | Unclear — requested by a paying user, so evidently not in the paid tier either | `1026996445` ; Everything else named in §2.1 | Unclear — no review ties any other specific feature to the paywall | — ; disclosure complaint 1 (1.43%)
- **Direction for us:** build-paid · **Report confidence:** review-derived · **Generalisable:** yes
- **Review IDs:** `1174519073`, `1130585398`, `1184550500`, `1137963077`, `1222427563`, `1026996445`, `1036447473`, `1374720328`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C104 Never ship a paywall or feature-removal change silently

### R14-032 — Four barriers to paying, in descending order of how badly they reflect on the business: the checkout was broken (revenue lost at the last step from users who had already decided); the upsell mechanism repelled the buyer; the paid tier did not contain what the buyer wanted — a 1★ from a payer that names its own remedy ('Might be worth it if weekly and monthly trending were added. I know I'd change my opinion'), the single most actionable paid-user record; disclosure

- **Where:** §5.3 What stopped people from paying — four barriers in descending order
- **This app does:** broken checkout; nags; shallow paid tier
- **User reaction:** blocked-conversion
- **Magnitude:** checkout 2 (2.86%); nags 2 (2.86%); shallow tier 1; disclosure 1
- **Direction for us:** must-never-break · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `6183382407`, `5929885128`, `1099032136`, `1133797353`, `1026996445`, `1374720328`
- **Canonical:** C011 Weekly / monthly / yearly reports; C077 Purchase and signup flow must not leak buyers; C093 No upsell nagging without a 'never ask again' option; C104 Never ship a paywall or feature-removal change silently

### R14-033 — The two confirmed payers land at opposite poles (a 1★ who found the analysis too shallow; a 5★ rescued with a promo code), and no refund request, unexpected charge, charge-after-cancel or failed restore appears anywhere — a one-time IAP at $1.99–$3 generated no billing-integrity grievances at all, in sharp contrast to the subscription apps in this dataset

- **Where:** §5.4 Post-purchase experience — a one-time IAP at $1.99–$3 generated no billing-integrity grievances at all
- **This app does:** $1.99–$3 one-time unlock
- **User reaction:** praise
- **Magnitude:** 0 billing grievances of 70; 2 payers at 1★ and 5★
- **Direction for us:** build-paid · **Report confidence:** clean record (n=70) · **Generalisable:** yes
- **Review IDs:** `1026996445`, `1036447473`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C029 Billing must be exactly right

### R14-053 — Keep the try-then-buy structure and the one-time purchase — every purchase-intent reviewer describes use-free → see-it-work → upgrade, and a $1.99–$3 one-time IAP generated no billing grievances in 70 reviews

- **Where:** §8.3 M1 Keep the try-then-buy structure and the one-time purchase
- **This app does:** free tier + one-time unlock
- **User reaction:** purchase-driver
- **Magnitude:** 6 intent mean 4.50; 0 refund complaints
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C063 Free trial before purchase

### R14-054 — Re-test the free habit cap: 3 may be below the threshold at which a user accumulates a streak worth paying to keep — the cap must be generous enough to create the streak that creates the desire; today it is the only free-tier complaint that reached 1★

- **Where:** §8.3 M2 Re-test the free habit cap — 3 may be below the threshold at which a user accumulates a streak worth paying to keep
- **This app does:** 3-habit free cap
- **User reaction:** blocked-conversion
- **Magnitude:** N4 3 (4.29%); 1 at 1★
- **Direction for us:** undecided · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `1174519073`, `6183382407`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

## Tactics the app used

### R14-009 — The only support interaction in the corpus was excellent: 'when my account had problems due to the move to a new monetisation model, they immediately sent me a promo code for the new app (which is paid)' — a 5★ that also records a mid-2014 monetisation model change

- **Where:** Part 0 §5 the only support interaction in the corpus, which was excellent — promo code after a monetisation model change
- **This app does:** promo code to bridge a model change
- **User reaction:** praise
- **Magnitude:** n=1 (1.43%)
- **Direction for us:** do · **Report confidence:** n=1 · **Generalisable:** yes
- **Review IDs:** `1036447473`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back; C089 Promos, giveaways and gift codes must work exactly as advertised

## Insights (the why)

### R14-003 — The core mechanic worked and the business around it did not: a fifth of reviewers say the app changed their behaviour, simplicity praise is unanimously 5★, and several tried multiple competitors and picked this one — 'a great app if you're looking for a Seinfeld streak tracker that's simple and easy to use… Marking off another green day and keeping the streak going is really satisfying'; what killed it is a short list of execution failures — nag prompts, crashes, data loss, a broken purchase button, abandonment

- **Where:** Part 0 §1 The core mechanic worked. The business around it did not.
- **This app does:** simple streak grid, freemium
- **User reaction:** praise
- **Magnitude:** outcome 14 (20.00%) mean 4.93 (13 of 14 5★); simplicity 10 (14.29%) mean 5.00; chose over competitors 5 (7.14%) mean 5.00
- **Direction for us:** product-rule · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `1076855737`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C005 Know which competitors buyers compare against; C006 Stay minimal and ad-free

### R14-020 — The corpus splits into pure praise (mean 4.79) and reviews carrying a criticism or request (mean 2.75) — a 2.04-star gap; 13 of the 50 four- and five-star reviews still carry a criticism or request: satisfied users telling the developer what to do next, the highest-value records in the corpus

- **Where:** §3.2 The corpus splits cleanly into two populations table (verbatim); 13 of the 50 four- and five-star reviews still carry a criticism or a request
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Population | n | Share | Mean ★ | Rating spread ; Pure praise, no criticism or request | 38 | 54.29% | 4.79 | 5★31 / 4★6 / 3★1 ; Carries at least one criticism or request | 32 | 45.71% | 2.75 | 5★3 / 4★10 / 3★4 / 2★6 / 1★9 ; 13 of 50 4–5★ (26.00%) with criticism
- **Direction for us:** do · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `1002707223`, `1054073250`, `1056568978`, `1190931941`, `1195162150`, `1262227277`, `1407746285`, `5929885128`, `6183382407`, `7082831771`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R14-024 — 5★ splits into substantive praise (accountability — 'the most important part of forming a new habit or breaking an old one is a sense of accountability') and low-information one-liners (35% of 5★); two 5★ reviews are relief not delight — praising the removal of pop-ups and a bug fix ('The problem in 1.4.2 where recorded Habits became inaccessible has been fixed')

- **Where:** §4.1 5★ — two distinct groups; substantive praise; low-information; two 5★ reviews are not endorsements of the current product
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 5★ 34 (48.57%): substantive 22, low-info 12 (35.29% of 5★)
- **Direction for us:** none · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `1092091026`, `1135523217`, `1147730742`, `1210295810`, `1169580369`, `1229822768`, `1015124612`, `1081962130`, `1193853972`, `1197160923`, `1054073250`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R14-025 — The 4★ band is 'good product, one specific problem': 3 of 16 docked specifically for nag prompts, 2 are blocked buyers, 4 are feature requests wrapped in praise — at least 5 of 16 would plausibly have been 5★ if a prompt had been silenced or a button had worked

- **Where:** §4.1 4★ — where the corpus is most informative; at least 5 of 16 four-star reviews would plausibly have been 5★ if a prompt had been silenced or a button had worked
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 4★ 16 (22.86%): nag-docked 3 (18.75% of 4★); blocked buyers 2 (12.50%); requests 4 (25.00%); 5 of 16 (31.25%) recoverable
- **Direction for us:** dont · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `1113922936`, `1115315804`, `1126869931`, `5929885128`, `6183382407`, `1056568978`, `1190931941`, `1407746285`, `7082831771`, `1262227277`, `1118980626`, `1133763832`, `1128016301`, `1137963077`, `1318342739`, `7929736347`
- **Canonical:** C077 Purchase and signup flow must not leak buyers; C093 No upsell nagging without a 'never ask again' option

### R14-026 — 3★ is mixed or blocked, never hostile: crashes from first launch rated 3 not 1; the clearest dated-UI signal ('the interface should have a look more modern and neater'); a Russian user explicitly withholding a real rating over language ('I can't rate it') — a placeholder, not a judgement

- **Where:** §4.1 3★ — mixed or blocked, never hostile; a placeholder rating withheld over language
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 3★ 5 (7.14%)
- **Direction for us:** none · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `961881835`, `1138108331`, `1157833711`, `1367475729`, `1122529516`
- **Canonical:** C027 Localise early — it unlocks revenue

### R14-028 — 7 of 9 one-star reviews are reliability or data-integrity failures and only 2 concern money or scope — reliability, not pricing, produced this app's worst ratings, a materially different profile from paywall-driven habit apps in this dataset

- **Where:** §4.1 1★ table (verbatim); reliability, not pricing, is what produced this app's worst ratings
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1★ 9 (12.86%); reliability/data 7 (77.78% of 1★, 10.00% of all); ID | Ctry | Cause ; `1195475837` | au | Data loss on update — warns others away ; `1194862743` | ru | Data loss on update ; `6678082433` | de | Crash on every check-off — *"completely unusable"* ; `6684084592` | gb | Crash on iOS 14 + data re-entry + slow update cadence ; `1176859130` | ru | *"Doesn't work at all"* ; `1241930865` | kr | Too slow to respond ; `1174519073` | us | Free tier capped at 3 habits + confusing UI + no tutorial ; `1026996445` | us | Paid $3, product too basic for the money ; `1202765053` | us | *"Just bad"* — no content
- **Direction for us:** must-never-break · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `1195475837`, `1194862743`, `6678082433`, `6684084592`, `1176859130`, `1241930865`, `1174519073`, `1026996445`, `1202765053`
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change

### R14-031 — All six purchase-intent reviewers describe the same sequence — use the free tier, find it genuinely works, decide to upgrade — none mentions a paywall, trial timer, onboarding pitch or discount; the conversion driver is demonstrated value over days of real use, which is why the 3-habit cap is a delicate setting: too tight and the user never accumulates the streak that creates the desire to pay; intent survived DESPITE the pop-ups ('Other than the in app purchase Pop ups every time I open it, this is a fantastic free app. Trying it out a little longer before I purchase')

- **Where:** §5.2 What made people want to pay — use the free tier → find it works → decide to upgrade; the 3-habit cap is a delicate setting
- **This app does:** free tier → one-time unlock
- **User reaction:** purchase-driver
- **Magnitude:** 6 intent (8.57%) mean 4.50
- **Direction for us:** product-rule · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `1184550500`, `1128016301`, `1130585398`, `1056568978`, `1174519073`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C061 Goodwill conversion — a generous free tier and 'support the devs'; C063 Free trial before purchase; C137 Show the paywall at the moment of need, not on app open

### R14-041 — Persisted unchanged: simplicity as the core attraction, praised from Mar 2014 to Oct 2021 ('Great interface, works well'); feature requests stayed small and stayed unmet — iPad (2014), font size (2014), widget (2015), colour schemes (2016), custom periodicity (2021) — not one resolved, no release since Dec 2020

- **Where:** §7.7 What persisted unchanged across the whole corpus
- **This app does:** minimal; requests unmet
- **User reaction:** praise
- **Magnitude:** simplicity praised 2014–2021; 5 named requests unmet
- **Direction for us:** product-rule · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `961128068`, `1076855737`, `1195988013`, `1222427563`, `7929736347`
- **Canonical:** C006 Stay minimal and ad-free; C071 Never ship and walk away

## Markets and languages

### R14-011 — Localisation was asked for, never delivered, and the listing still shows English only: over a third of reviews are non-English and Russian-language storefronts are the second-largest group after the US; 'I can't rate it, because I've spent 20 minutes and still can't switch the language. I really need an app like this, but in Russian!' — both requests unanswered for a decade in a product whose entire UI is a handful of labels

- **Where:** Part 0 §6 Localisation was asked for, never delivered, and the store listing still shows English only
- **This app does:** English only
- **User reaction:** blocked-conversion
- **Magnitude:** 25 of 70 (35.71%) non-English; ru+by+ua 15 (21.43%); explicit Russian asks 2 (2.86%) [limited evidence]
- **Direction for us:** build-free · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `1157833711`, `1265490751`
- **Canonical:** C027 Localise early — it unlocks revenue

### R14-034 — Limited-evidence market notes: the corpus is broadly distributed (US only 28.57%; Korea and Russia together exceed it); Russian-language storefronts are the largest bloc after English and produced the only localisation requests; every nag-prompt complaint outside the US came from Korea or the UK, and the three Korean records are the only ones quantifying the star penalty or writing a review purely to satisfy the prompt (n=4, not a market finding); both 2020 crash reports came from Europe two days apart — a single iOS 14 regression

- **Where:** Part 6 MARKET AND LANGUAGE NOTES (limited evidence)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** us 20 (28.57%); kr 12; ru 11; ru+by+ua 15 (21.43%); nag outside US n=4; 2020 crashes de+gb
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `1157833711`, `1265490751`, `1113922936`, `1115315804`, `1126869931`, `1099032136`, `6678082433`, `6684084592`
- **Canonical:** C027 Localise early — it unlocks revenue; C062 Weight English-speaking rich markets; volume ≠ revenue

### R14-051 — Localise, Russian first — 21% of reviews come from Russian-language storefronts, the only two language requests are Russian, and the UI is a few dozen strings; one user spent 20 minutes hunting for a language switch and withheld a rating [limited evidence]

- **Where:** §8.2 B5 Localise — Russian first; the UI is a few dozen strings
- **This app does:** English only
- **User reaction:** blocked-conversion
- **Magnitude:** N7 2 (2.86%); ru/by/ua 15 (21.43%)
- **Direction for us:** build-free · **Report confidence:** recommendation (build next), limited evidence · **Generalisable:** yes
- **Review IDs:** `1157833711`
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R14-004 — Nagging cost this app a full star and the corpus proves the fix worked: the only theme where users state the exact star penalty — 'every time I run the free version, windows keep popping up telling me to write a review or buy. I docked one star for this'; 'Happy now??'; 'killed with constant nagging for a rating and upgrade. Deleted'; 'making me wait for the message then dismiss it is counterproductive. I'm very unlikely to pay for the upgrade just to get rid of the pestering' — every complaint falls 18 Nov 2014 – 21 Jan 2015, then 'They removed the pop ups. Nice!!' (5★) and 'not annoying at all… Their competitor Way of Life already managed to become tiresome by begging for an upgrade within the first minute' — no further nag complaint in 6.4 years

- **Where:** Part 0 §2 The single most transferable finding: nagging cost this app a full star, and the corpus proves the fix worked
- **This app does:** rating + upsell pop-ups on every launch of the free version, removed early 2015
- **User reaction:** 1★-burst
- **Magnitude:** nag complaints 6 (8.57%) mean 3.00; any mention 9 (12.86%) mean 3.67; complaints 18 Nov 2014 – 21 Jan 2015; 5★ praise for removal May–Jun 2015
- **Direction for us:** dont · **Report confidence:** high-priority (counts), cleanest before/after · **Generalisable:** yes
- **Side effects:** the rival Way of Life was still giving away the same advantage
- **Review IDs:** `1113922936`, `1115315804`, `1126869931`, `1130477064`, `1133797353`, `1099032136`, `1193853972`, `1208386132`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R14-035 — Year buckets are severely unbalanced (2014: 23, 2015: 37, 2016: 4, 2020: 4, 2021: 2) so 2016–21 is treated as one thin tail; mean 4.30 (2014) → 3.78 (2015) → 3.25 → 2.50 (2020) → 4.00 (2021, n=2)

- **Where:** §7.1 Method — unbalanced buckets; year table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | Mean ★ | Rating spread ; 2014 | 23 | 4.30 | 5★15 / 4★4 / 3★1 / 2★2 / 1★1 ; 2015 | 37 | 3.78 | 5★19 / 4★6 / 3★3 / 2★3 / 1★6 ; 2016 | 4 | 3.25 | 4★2 / 3★1 / 2★1 ; 2020 | 4 | 2.50 | 4★2 / 1★2 ; 2021 | 2 | 4.00 | 4★2 ; 2014–15 | 60 | 3.98 | — ; 2016–21 | 10 | 3.10 | —
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R14-037 — The mean declined across the app's life and the only movement with a usable sample (2014 → 2015, −0.52) is driven by 1★ reviews rising from 4.35% to 16.22%, five of six being reliability or data-loss reports — the rating decline is a reliability decline

- **Where:** §7.3 Trend 2 — Mean rating declined across the app's life; the rating decline is a reliability decline
- **This app does:** reliability regressions
- **User reaction:** 1★-burst
- **Magnitude:** 4.30 → 3.78; 1★ 1 of 23 → 6 of 37; 5 of 6 reliability/data
- **Direction for us:** must-never-break · **Report confidence:** usable sample both sides · **Generalisable:** yes
- **Review IDs:** `1176859130`, `1194862743`, `1195475837`, `1241930865`, `1174519073`
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change

### R14-038 — The nag prompts were fixed — the corpus's one clear success: 6 complaints in the Nov 2014 – Jan 2015 window (37.5% of reviews then), zero in the following 44 reviews over 6.7 years; a single, cheap change eliminated the theme responsible for half of all 2★ reviews and it never resurfaced

- **Where:** §7.4 Trend 3 — Fixed: the nag prompts (the corpus's one clear success); table (verbatim)
- **This app does:** pop-ups removed early 2015
- **User reaction:** praise
- **Magnitude:** Window | Nag complaints | Share of window ; Nov 2014 – Jan 2015 | 6 | 6 of the 16 reviews in that window (37.50%) ; Feb 2015 – Oct 2021 | 0 | 0 of 44 (0.00%)
- **Direction for us:** do · **Report confidence:** clean before/after · **Generalisable:** yes
- **Review IDs:** `1193853972`, `1208386132`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R14-039 — Crashes persist at every OS transition across 6.7 years ('Same thing happened with the new iOS 13 and it took them a while to fix it'); the counterfactual: a 1.4.2 bug that made recorded habits inaccessible WAS fixed and the reviewer returned to post 5★ — the problem was cadence, not capability

- **Where:** §7.5 Trend 4 — Persistent: crashes at every OS transition; the counterfactual — when this developer fixed things, users noticed and rewarded it
- **This app does:** slow fixes at iOS transitions
- **User reaction:** 1★-burst
- **Magnitude:** crash reports 2014 (2), 2015 (2), 2020 (2)
- **Direction for us:** must-never-break · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `961881835`, `1077393973`, `1176859130`, `1241930865`, `6678082433`, `6684084592`, `1197160923`
- **Canonical:** C031 Crashes / launch failures; C059 Be visibly responsive; fixes bring reviewers back; C071 Never ship and walk away

### R14-040 — The last thing the corpus records before the app went quiet is that both the product and its checkout stopped working at once: both broken-upgrade reports (May and Jul 2020) are among the final six substantive records, in the same window as the iOS 14 crashes

- **Where:** §7.6 Trend 5 — Emerging late: monetisation plumbing broke before the app died
- **This app does:** checkout broken in final months
- **User reaction:** blocked-conversion
- **Magnitude:** 2 broken-upgrade reports 2020; 0 earlier
- **Direction for us:** must-never-break · **Report confidence:** late-emerging · **Generalisable:** yes
- **Review IDs:** `5929885128`, `6183382407`
- **Canonical:** C071 Never ship and walk away; C077 Purchase and signup flow must not leak buyers

## Positioning

### R14-001 — My Habits: Daily Habit Builder (App Store ID 814998643), originally shipped as 'Hab-It', is a small freemium 'Seinfeld streak' tracker by a solo developer — read as a post-mortem: last version 1.7 shipped 29 Dec 2020, roughly five years eight months without an update

- **Where:** header lines 1-10; §1.6 External source table (verbatim)
- **This app does:** developer Siarhei Marozau; bundle savefon.mobi.Hab-It-; free with 'Premium Access' $1.99 one-time IAP; English only; iOS 9+; store rank 14
- **User reaction:** mixed
- **Magnitude:** 70 written reviews, 14 storefronts, 15 Mar 2014 → 19 Oct 2021; written mean 3.857; Field | Value ; Name / subtitle | My Habits: Daily Habit Builder — Tracker for Goals & Routine ; Developer | Siarhei Marozau ; Price label | "Free · In-App Purchases" ; In-app purchase | "Premium Access $1.99" ; Current version | 1.7, released 29 Dec 2020 ; Store rating | 4.3★ from 3 ratings — see Warning 4, do not use ; Category | Productivity ; Requirements | iOS 9.0 or later · 28.3 MB ; Languages | English only
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R14-023 — Competitive position is unusually favourable — 'Tried a lot like these apps but this one is the best by far'; named rivals: Way of Life cited negatively for nag behaviour, Balanced cited as a UI and feature benchmark to copy; named differentiators: offline check-in and editing previous days; the reason people picked it was simplicity and reliability of the basics, not features — precisely the position crashes and data loss destroy

- **Where:** §3.4 Competitive position — the reason people picked this app was simplicity and reliability of the basics, not features
- **This app does:** simple, reliable basics; offline; backdating
- **User reaction:** purchase-driver
- **Magnitude:** 8 (11.43%) compare against rivals, mean 4.75, 5 rank it first
- **Direction for us:** product-rule · **Report confidence:** high-priority (counts) · **Generalisable:** yes
- **Review IDs:** `978448437`, `1099557740`, `1222427563`, `1195988013`, `1208386132`, `1056568978`, `1184550500`, `1262227277`
- **Canonical:** C005 Know which competitors buyers compare against; C006 Stay minimal and ad-free; C010 Backfill missed days / edit start date; C188 The app must open offline — never block launch on a network call

## Anti-patterns

### R14-058 — Anti-pattern with a measured cost: rating-and-upsell pop-ups on every launch of the free version cost 6 rating-suppressing reviews in 9 weeks (half of all 2★, three 4★ docked a star, one explicit lost sale, three prompt-driven junk reviews) — and removing them produced unsolicited 5★ praise and a named advantage over a rival still doing it

- **Where:** Part 0 §2; §4.1 2★; §7.4 Trend 3; §8.1 I3
- **This app does:** launch pop-ups Nov 2014 – Jan 2015, then removed
- **User reaction:** 1★-burst
- **Magnitude:** 6 (8.57%) mean 3.00; 3 of 6 2★; 3 of 16 4★ docked; 0 of 44 later reviews
- **Direction for us:** dont · **Report confidence:** high-priority (counts), clean before/after · **Generalisable:** yes
- **Review IDs:** `1113922936`, `1130477064`, `1099032136`, `1193853972`, `1208386132`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

## Things not to do

### R14-005 — Two second-order effects of the nag prompt: it polluted the ratings data (at least 3 records exist only because the app demanded a review — 'I don't usually leave reviews, but it kept telling me to, so here's one'; a review whose title and body are the word 'Review'), and it directly caused a lost sale — an explicit refusal to pay BECAUSE of the upsell mechanism; the upsell destroyed the conversion it was built to create

- **Where:** Part 0 §2 Two second-order effects: the nagging polluted the ratings data; it directly caused a lost sale
- **This app does:** prompt-driven reviews; upsell refusal
- **User reaction:** churn
- **Magnitude:** 3 records (4.29%) prompt-driven; 2 (2.86%) refused to pay citing nags
- **Direction for us:** dont · **Report confidence:** meaningful (counts) · **Generalisable:** yes
- **Review IDs:** `1115315804`, `1126869931`, `1122529516`, `1099032136`, `1133797353`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C093 No upsell nagging without a 'never ask again' option; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R14-027 — Nag prompts are the single largest cause of 2★ reviews — half of them — and all three explicitly say the app itself is good ('The app works great', 'Decent app'): the corpus's cleanest self-inflicted wounds, three 2★ ratings from users who liked the product

- **Where:** §4.1 2★ — nag prompts are the single largest cause; the corpus's cleanest self-inflicted wounds
- **This app does:** rating/upsell nags
- **User reaction:** 1★-burst
- **Magnitude:** 3 of 6 2★ (50.00%); other 2★: date bug, undisclosed IAP, no Russian
- **Direction for us:** dont · **Report confidence:** band analysis · **Generalisable:** yes
- **Review IDs:** `1099032136`, `1130477064`, `1133797353`, `1077393973`, `1374720328`, `1265490751`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R14-044 — Remove or hard-cap in-app rating and upgrade prompts — at most one, dismissible permanently, never on launch, never before demonstrated value; the corpus contains its own before/after result; the cheapest rating improvement available

- **Where:** §8.1 I3 Remove or hard-cap in-app rating and upgrade prompts — at most one, dismissible permanently, never on launch, never before demonstrated value
- **This app does:** prompts on every launch
- **User reaction:** 1★-burst
- **Magnitude:** 6 negative reviews in 9 weeks; removal → 5★ praise
- **Direction for us:** dont · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `1193853972`, `1208386132`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

## Things to do

### R14-049 — Protect and market the two named differentiators — offline check-in and editable past days — the reasons two reviewers chose this app over rivals; neither appears in the store listing

- **Where:** §8.2 B3 Protect and market the two named differentiators: offline check-in and editable past days
- **This app does:** offline + backdating exist but are unmarketed
- **User reaction:** purchase-driver
- **Magnitude:** n=1 each
- **Direction for us:** do · **Report confidence:** recommendation (build next) · **Generalisable:** yes
- **Review IDs:** `1195988013`, `1184550500`
- **Canonical:** C010 Backfill missed days / edit start date; C134 Lead the store listing with what users actually love; C188 The app must open offline — never block launch on a network call

### R14-050 — Refresh the visual language on a schedule — the UI was praised as attractive in 2014 and called dated by Jan 2015; a 2020-era build in 2026 has no chance

- **Where:** §8.2 B4 Refresh the visual language on a schedule
- **This app does:** stale UI
- **User reaction:** complaint
- **Magnitude:** N5 3 (4.29%)
- **Direction for us:** do · **Report confidence:** recommendation (build next) · **Generalisable:** yes
- **Canonical:** C071 Never ship and walk away

## Contradictions

### R14-029 — Three themes cross the rating line: nag prompts (praised when removed, docked when present), the free tier (try-before-buy is 'the point' vs the 3-habit cap), and the interface — praise clusters in 2014–15 while 'dated' appears from Jan 2015; a visual language that reads as clean in 2014 does not in 2021, and the last visual update predates most remaining users' phones

- **Where:** §4.2 Themes that appear on both sides of the rating line table (verbatim); the interface split — clean in 2014 reads dated by 2021
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | Positive appearance | Negative appearance ; Nag prompts | `1193853972` (5★, praises removal); `1208386132` (5★, praises absence vs rival); `1130585398` (5★, tolerates them) | `1099032136`, `1130477064`, `1133797353` (2★); `1113922936`, `1115315804`, `1126869931` (4★, docked) ; Free tier / upgrade | `1128016301` (4★, try-before-buy is *the point*); `1130585398`, `1184550500` (evaluating before buying) | `1174519073` (1★, 3-habit cap); `6183382407` (4★, cap + broken button) ; Interface | `961128068`, `1118980626`, `1195988013`, `7929736347` (attractive, clear) | `1138108331` (3★, dated); `1174519073` (1★, confusing); `1262227277` (4★, unintuitive navigation)
- **Direction for us:** do · **Report confidence:** counts · **Generalisable:** yes
- **Review IDs:** `1193853972`, `1208386132`, `1130585398`, `1128016301`, `1184550500`, `961128068`, `1195988013`, `7929736347`, `1138108331`, `1174519073`, `1262227277`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C071 Never ship and walk away; C093 No upsell nagging without a 'never ask again' option

## Data caveats and method

### R14-002 — Method: n=70 so one review = 1.43% and 'high-priority' means 4–14 people — counts are the honest unit; no country reaches 50 (US 20) so no per-country section; the corpus is history not current state (85.71% of reviews 2014–15, app unupdated since Dec 2020); the store's 3-rating count cannot be reconciled with 20 US written reviews (likely a ratings reset) — do not use the 4.3★ figure; all 70 read in full chronologically, 25 non-English translated, manual non-exclusive labels counted by script; judgement calls disclosed (a Korean 'purchase list' review not counted as paid; an implied payer kept separate; a body reading 'Review' coded low-information); 18 reviews (25.71%) ≤30 chars of substance, 12 of 34 five-star; two gaps: 8 Jul 2016 → 11 May 2020 (1,403 days) and Mar–Oct 2021

- **Where:** How to read this; ⚠️ Four warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Limitations and judgement calls; §1.7 Corpus composition; §9.1 counting rules
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 70/70 read; 0 duplicates; 14 storefronts reconcile; 5★34 / 4★16 / 3★5 / 2★6 / 1★9; storefronts us 20 · kr 12 · ru 11 · gb 6 · jp 4 · au 3 · by 3 · mx 3 · br 2 · cn 2 · de 1 · in 1 · mo 1 · ua 1; language EN 45, Cyrillic 10, KO 8, ES/PT 3, ZH 2, JA 2; votes on 3 records; is_edited false on all
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R14-010 — With 2 confirmed payers out of 70, no conversion rate, ARPU or paid-satisfaction rate can be computed and none is claimed

- **Where:** Part 0 §5 What this does not show — no conversion rate, ARPU or paid-satisfaction rate
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 2 of 70
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R14-012 — Selection bias is unquantifiable and worsened by the app soliciting ratings in-app during 2014–15 — an unknown share of the early positive records exist because of a prompt, at least 3 say so outright

- **Where:** §1.5 Limitations — the app actively solicited ratings in-app during 2014–15, so an unknown share of early positive records exist because of a prompt
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 3 (4.29%) say so
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R14-013 — Corpus composition: ratings, storefronts, language, and two gaps exceeding 200 days including a 1,403-day hole

- **Where:** §1.7 Corpus composition ratings table (verbatim); storefronts; language; date gaps
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ★ | Count | Share ; 5 | 34 | 48.57% ; 4 | 16 | 22.86% ; 3 | 5 | 7.14% ; 2 | 6 | 8.57% ; 1 | 9 | 12.86% ; gaps 8 Jul 2016 → 11 May 2020 (1,403 days), 9 Mar → 19 Oct 2021 (224 days)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R14-017 — All themes ranked: eleven positive, eleven negative, and cross-cutting rows

- **Where:** §3.1 All themes, ranked — Positive themes table (verbatim); Negative themes table (verbatim); Cross-cutting table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** POS: # | Theme | n | % | Signal | Mean ★ | Representative IDs ; P1 | Effective — genuinely helps build/break habits, track progress | 14 | 20.00% | High-priority | 4.93 | `961110962`, `1002707223`, `1036447473`, `1076855737`, `1092091026`, `1099557740`, `1135523217`, `1147730742`, `1184550500`, `1266315769` ; P2 | Simple, easy, intuitive to use | 10 | 14.29% | High-priority | 5.00 | `1002707223`, `1036447473`, `1076855737`, `1099557740`, `1122437324`, `1135523217`, `1149728919`, `1208386132`, `1120439485` ; P3 | Attractive / clean interface | 6 | 8.57% | High-priority | 4.67 | `961128068`, `1118980626`, `1195988013`, `1208386132`, `7929736347`, `1149728919` ; P4 | Statistics and visible progress records | 5 | 7.14% | High-priority | 5.00 | `961110962`, `1036447473`, `1076855737`, `1120439485`, `1195988013` ; P5 | Best of the habit apps I tried | 5 | 7.14% | High-priority | 5.00 | `978448437`, `1099557740`, `1195988013`, `1208386132`, `1222427563` ; P6 | Reminders work and are welcome | 3 | 4.29% | Very strong | 5.00 | `1132075503`, `1147730742`, `1208386132` ; P7 | Streak/green-square satisfaction as a motivator | 2 | 2.86% | Meaningful | 5.00 | `1076855737`, `1184550500` ; P8 | A previously reported problem was fixed | 2 | 2.86% | Meaningful | 5.00 | `1193853972`, `1197160923` ; P9 | Responsive support | 1 | 1.43% | Meaningful | 5.00 | `1036447473` ; P10 | Works offline | 1 | 1.43% | Meaningful | 5.00 | `1195988013` ; P11 | Can edit/backdate previous days | 1 | 1.43% | Meaningful | 5.00 | `1184550500` ;; NEG: # | Theme | n | % | Signal | Mean ★ | Representative IDs ; N1 | Nag prompts for upgrade and rating | 6 | 8.57% | High-priority | 3.00 | `1099032136`, `1113922936`, `1115315804`, `1126869931`, `1130477064`, `1133797353` ; N2 | Crashes, freezes, unusable behaviour, slowness | 6 | 8.57% | High-priority | 1.50 | `961881835`, `1077393973`, `1176859130`, `1241930865`, `6678082433`, `6684084592` ; N3 | Data lost on update | 3 | 4.29% | Very strong | 1.00 | `1194862743`, `1195475837`, `6684084592` ; N4 | Free-tier limits hit (3 habits; 6 daily entries) | 3 | 4.29% | Very strong | 3.33 | `1174519073`, `6183382407`, `1054073250` ; N5 | Interface dated or navigation unintuitive | 3 | 4.29% | Very strong | 2.67 | `1138108331`, `1174519073`, `1262227277` ; N6 | Upgrade purchase cannot be completed | 2 | 2.86% | Meaningful | 4.00 | `5929885128`, `6183382407` ; N7 | No Russian localisation | 2 | 2.86% | Meaningful | 2.50 | `1157833711`, `1265490751` ; N8 | Paid price not matched by depth of analysis | 1 | 1.43% | Meaningful | 1.00 | `1026996445` ; N9 | In-app purchases not disclosed on the listing | 1 | 1.43% | Meaningful | 2.00 | `1374720328` ; N10 | No tutorial / onboarding | 1 | 1.43% | Meaningful | 1.00 | `1174519073` ; N11 | Updates months or years apart | 1 | 1.43% | Meaningful | 1.00 | `6684084592` ;; CROSS: Theme | n | % | Signal | Mean ★ | Note ; Any explicit feature request | 12 | 17.14% | High-priority | 3.42 | See §3.3 ; Reviewer compared against rival habit apps | 8 | 11.43% | High-priority | 4.75 | See §3.4 ; Low-information review (no theme content) | 18 | 25.71% | High-priority | 4.44 | 12 of these are 5★ ; Carries ≥1 criticism or request | 32 | 45.71% | — | 2.75 | Union of all negative + request themes ; Pure praise, no criticism | 38 | 54.29% | — | 4.79 | Complement of the above
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R14-030 — Paid evidence base: confirmed paid 2, implied 1, stated intent 6, blocked 2, refused 2, any monetisation content 12; the value is the mechanism, not the magnitude

- **Where:** §5.1 The evidence base, stated honestly table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Group | n | % of 70 | Mean ★ ; Confirmed paid (states payment or a paid transaction directly) | 2 | 2.86% | 3.00 ; Implied paid (endorses paying, without stating they did) | 1 | 1.43% | 5.00 ; Stated intent to buy | 6 | 8.57% | 4.50 ; Blocked from buying (wanted to, could not) | 2 | 2.86% | 4.00 ; Refused to buy, reason stated | 2 | 2.86% | 2.00 ; Any monetisation-related content | 12 | 17.14% | 3.17
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R14-036 — Review volume collapsed: 85.71% of reviews in the first 22 months, then nothing for 1,403 days (Jul 2016 → May 2020); consistent with an app that stopped being marketed and updated, but the corpus cannot distinguish 'nobody used it' from 'users stopped writing' from crawl retention — an observation, not a measured decline

- **Where:** §7.2 Trend 1 — Review volume collapsed, and there is a 3.8-year hole in the corpus
- **This app does:** abandoned
- **User reaction:** none
- **Magnitude:** 60 of 70 in first 22 months; 1,403-day gap; 6 reviews (8.57%) from 2020–21
- **Direction for us:** none · **Report confidence:** interpretation flagged · **Generalisable:** yes
- **Review IDs:** `1407746285`, `5929885128`
- **Canonical:** — (nuance register)

### R14-057 — Research questions: did v1.7 fix the iOS 14 crash; actual free→paid conversion; why the US listing shows 3 ratings against 20 written reviews (resolve before using any store-rating figure); how many users hit the 3-habit cap and churned silently; did the mid-2014 monetisation change cost users

- **Where:** §8.4 Research questions this corpus cannot answer; part 8 #1; part 8 #2; part 8 #3; part 8 #4; part 8 #5
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 5 questions
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** yes
- **Review IDs:** `7082831771`, `7929736347`, `1036447473`
- **Canonical:** — (nuance register)
