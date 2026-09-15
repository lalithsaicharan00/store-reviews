# Cards — report 9

Source: `App Store Reports/9. Dear Me - Daily Routine Tracker - Self Care & ADHD Habit Planner (REPORT).md`  
147 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 3
- [Must-haves](#must-haves) — 5
- [Must never break](#must-never-break) — 13
- [Features](#features) — 27
- [Monetization](#monetization) — 4
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 14
- [Audiences](#audiences) — 4
- [Markets and languages](#markets-and-languages) — 18
- [Dated events and trends](#dated-events-and-trends) — 5
- [Positioning](#positioning) — 5
- [Anti-patterns](#anti-patterns) — 5
- [Things not to do](#things-not-to-do) — 6
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 32

## Product rules

### R09-008 — Price level is not the main problem — access is: 'great app, wish it were free' is often a 5★ sentence, while being made to pay before you can see anything scores the lowest; reviewers forgive the price, they do not forgive paying blind

- **Where:** §0.2 Price level is not the main problem — access is
- **This app does:** hard paywall before use
- **User reaction:** blocked-conversion
- **Magnitude:** M-price 123 (9.60%), mean 2.70 (highest money mean), 31 are 5★; M-wall 75 (5.85%), 1.69; M-latereveal 18 (1.41%), 1.39
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11285454916`, `11946302259`, `12294156269`, `12305015226`
- **Canonical:** C147 Let people use the product before they pay; C002 Ratings follow the offer, not the feature set

### R09-122 — Let people see the product before they pay — the claim with more evidence than anything else in the corpus: deduplicated, 159 reviews say 'let me look before you charge me' at mean 1.79 while 28 say the free tier is already usable; it may not raise revenue per install but should cut the scam, regret and refund reviews and convert the 55-review 'I'd pay if I could look first' cohort that currently converts at zero

- **Where:** §7.2 The single highest-leverage change: let people see the product before they pay — The evidence and Expected effect
- **This app does:** hard paywall before use
- **User reaction:** blocked-conversion
- **Magnitude:** M-notrial 52 + M-wall 75 + M-latereveal 18 + M-nag 59 → 159 deduplicated (12.41%), mean 1.79; targets M-scam 30 (1.20), M-regret 50, M-refund 102
- **Direction for us:** product-rule · **Report confidence:** highest-leverage · **Generalisable:** yes
- **Canonical:** C147 Let people use the product before they pay

### R09-136 — Protect what already works while fixing the rest: the daily organise-and-tick loop, the warmth that makes motivation and ADHD perfect-scoring (make affirmations optional, don't remove them), Turkish localization quality (extend it to other languages rather than dilute it), and the free tier (market it)

- **Where:** §7.4 Positioning — protect what already works
- **This app does:** warm tone; usable free tier
- **User reaction:** praise
- **Magnitude:** P-org 106 + P-outcome 101 at 4.92; P-motiv 32 and P-adhd 16 at 5.00; P-free 28
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-018, R09-019, R09-046, R09-068
- **Review IDs:** `13860369435`, `11647652906`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C027 Localise early — it unlocks revenue

## Must-haves

### R09-014 — Cancellation fails or is misunderstood: cancelling stops renewal but does not refund, and users do not understand that — 'If cancelling is only so it doesn't renew after a year' — many neutral or positive-rated users asking in public because they had nowhere else to ask

- **Where:** §0.3 cancellation itself failed or was unclear; §4.5 mechanic 3
- **This app does:** cancel = stop renewal only, not explained
- **User reaction:** complaint
- **Magnitude:** M-cancel 34 (2.65%, MEANINGFUL), mean 2.03; 31 of 34 paid; TR 27 of 34 (79.4%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11936253199`, `12133402020`, `11895224084`, `12652692645`, `13477378855`
- **Canonical:** C112 In-app cancellation

### R09-016 — No support response at all, and people ask for help in public reviews because they cannot find in-app support — 'I couldn't find any support contacts anywhere, so I had to write this as a review'; one asks for an in-app support section instead of an email address

- **Where:** §0.3 no support response at all; §4.5 Support is the amplifier; Part 7 §7.1 #3
- **This app does:** email-only support, often unanswered
- **User reaction:** 1★-burst
- **Magnitude:** X-support 25 (1.95%, MEANINGFUL), mean 1.52; 21 of 25 paid
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12178773869`, `12571528769`, `12754744101`, `13860369435`, `11695609359`, `12901421019`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R09-087 — Four refund/churn failure modes, all documented: the guarantee was not executed; the in-app refund path is a dead end; cancelling stops renewal but does not refund and users don't understand it; billing errors — and support is the amplifier; build a real in-app support and refund path to convert ~100 public refund complaints into private tickets

- **Where:** §4.5 Refund and churn mechanics — four failure modes; Part 7 §7.1 #3
- **This app does:** email support; dead-end refund UI
- **User reaction:** 1★-burst
- **Magnitude:** 21 of 25 X-support are payers; ~100 public refund complaints
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11567513705`, `13065540266`, `12571528769`
- **Canonical:** C112 In-app cancellation; C036 A support channel that exists, is reachable outside the app, and answers

### R09-117 — Build a real in-app support and refund path — converts ~100 public refund complaints into private tickets

- **Where:** Part 7 §7.1 #3 Build a real in-app support and refund path
- **This app does:** email only
- **User reaction:** 1★-burst
- **Magnitude:** 25 no-response, 21 paid
- **Direction for us:** must-have · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R09-016, R09-087
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C112 In-app cancellation

### R09-125 — State the free/paid split on a single screen

- **Where:** §7.2 Part C — State the free/paid split on a single screen
- **This app does:** blank membership page
- **User reaction:** complaint
- **Magnitude:** 19 M-unclear
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-045
- **Review IDs:** `11878902945`, `13021325704`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

## Must never break

### R09-011 — The refund pipeline is the largest reputational liability — a support and policy-execution failure, not a pricing complaint: the in-app refund request produced 'an empty box', users could not find the option at all, and invoking the EU right of withdrawal was 'impossible'

- **Where:** §0.3 The refund pipeline is the app's largest reputational liability; §4.5
- **This app does:** in-app refund path dead-ends
- **User reaction:** 1★-burst
- **Magnitude:** M-refund 102 (7.96%, HIGH-PRIORITY), mean 1.73; 99 of 226 paid (43.8% segment rate); TR 59 of 102 (57.8%, 12.53% of TR); 9.70% (2024) → 7.80% → 3.98% (2026)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11567513705`, `11480287005`, `11912344269`, `13065540266`
- **Canonical:** C112 In-app cancellation; C036 A support channel that exists, is reachable outside the app, and answers

### R09-015 — Billing does not match what was shown: annual shown as ₺199.99 and more taken; 'subscribed at 49, they took 114'; 'supposed to pay 39.99 but it charged me 56'; double-charged on a plan switch; charges after deletion; a discount pop-up that completed an Apple Pay annual purchase while the user was trying to dismiss it; a €20 annual subscription that appeared without bank details ever being entered

- **Where:** §0.3 charged an amount different from what was displayed; §4.5 mechanic 4; §5.1-FR
- **This app does:** charge ≠ displayed price
- **User reaction:** 1★-burst
- **Magnitude:** M-overcharge 16 (1.25%, MEANINGFUL), mean 1.50; 15 of 16 paid
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11539871453`, `12264639015`, `13966657008`, `12221358308`, `11935551837`, `13610891124`, `13565016167`, `11777093103`, `12190059793`
- **Canonical:** C029 Billing must be exactly right

### R09-030 — A severe reliability failure concentrated in one country: in Russia the app loads for minutes, shows 'network error', never populates widgets, and six users say it only works over a VPN — most likely backend/CDN reachability, degrading since mid-2025, while Russian users keep paying; the v1.1.46 release notes ('Things just got a whole lot faster! Enjoy quicker loading') show the developer knows

- **Where:** ⚠️ 3. The app has a severe, geographically concentrated reliability failure; §0.7 The Russia cluster is a distinct engineering problem; Part 7 §7.1 #1
- **This app does:** backend unreachable from RU
- **User reaction:** 1★-burst
- **Magnitude:** B-load 66 (5.15%, HIGH-PRIORITY), mean 2.12 — RU 52 of 66 (46.02% of RU vs 1.20% non-RU); 56.64% of RU report a defect vs 12.9% elsewhere; B-vpn 6 (all RU); RU paid 36 of 113 (31.9%); RU written 2.38 vs public 4.65
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Conditions:** a regional infrastructure failure hidden by a single global star rating
- **Review IDs:** `12574094311`, `13189159142`, `13684764082`, `13936354959`, `14274931059`, `14413735582`, `14137219709`
- **Canonical:** C132 Do not sell in a storefront where the app cannot function; C031 Crashes / launch failures

### R09-033 — The rest of the defect load: new habits won't save, users logged out and cannot sign back in, completed tasks un-complete themselves, routines and history disappear, text truncated, widgets blank (RU), iPad layout unusable, planning requires a network connection, Hebrew renders reversed, wrong weekday, signature field rejects input, Discover tab errors (Jan 2026)

- **Where:** §0.7 remaining defect themes (B-create, B-login, B-check, B-dataloss, B-ui, B-widget, B-tablet, B-offline, B-rtl, B-cal, B-sig, B-discover)
- **This app does:** multiple defects
- **User reaction:** 1★-burst
- **Magnitude:** B-create 16 (1.25%), 2.12; B-login 15 (1.17%), 1.87; B-check 12 (0.94%), 2.75; B-dataloss 5, 1.60; B-ui 5, 1.40 (FR 3); B-widget 5 (RU 5); B-tablet 2, 1.00; B-offline 2, 1.00; B-rtl 1; B-cal 3; B-sig 2; B-discover 2
- **Direction for us:** must-never-break · **Report confidence:** meaningful to weak · **Generalisable:** yes
- **Review IDs:** `12513379051`, `13580713380`
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change

### R09-043 — Charged despite cancelling inside the trial — one US reviewer kept screenshots and reports $86.53 still being attempted

- **Where:** §1.2 US trial trap; §0.2 M-trialtrap; §5.1-US
- **This app does:** trial converts after cancellation
- **User reaction:** 1★-burst
- **Magnitude:** M-trialtrap 10 (0.78%, EMERGING), mean 1.80; 10 of 10 paid; 1.51% → 0.47% → 0.00%
- **Direction for us:** must-never-break · **Report confidence:** emerging, resolved by 2026 · **Generalisable:** yes
- **Review IDs:** `13245012766`, `11552283550`
- **Canonical:** C109 A free trial must be a real trial

### R09-060 — Rapid animation is reported as a seizure/vertigo risk — promoted despite a single review as a safety concern

- **Where:** §2.2 G-a11y — rapid animation is a seizure/vertigo risk (promoted despite volume as a safety concern)
- **This app does:** fast animations, no reduce-motion
- **User reaction:** 1★-burst
- **Magnitude:** G-a11y 1 (0.08%), 1★, AU
- **Direction for us:** must-never-break · **Report confidence:** safety carve-out · **Generalisable:** yes
- **Review IDs:** `13467908248`
- **Canonical:** C149 Respect Reduce Motion — no rapid flashing animation

### R09-061 — Notifications are praised and attacked at once: some say reminders land at the exact time, others that they never arrive, and others that they all fire at once at the wrong time — 'It sends all the notifications at the same time'; '20 notifications to my Apple Watch all at once while I'm at work'

- **Where:** §2.3 Mixed themes — Notifications
- **This app does:** reminder scheduling unreliable
- **User reaction:** mixed
- **Magnitude:** P-remind 14 (1.09%), 4.86 vs B-notif 12 (0.94%), 1.75 (SA 4, TR 4) vs B-notifspam 8 (0.62%), 2.50
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13745822425`, `12019986162`, `12343427636`
- **Canonical:** C039 Reminders fire reliably, once

### R09-079 — Paying customers are the angriest users: they rate the app 1.57 stars below the corpus and 61% give one star — negatively selected (satisfied subscribers rarely write), so not a satisfaction rate, but the composition of their complaints is diagnostic and it is not about price

- **Where:** §4.1 The paid cohort table (verbatim)
- **This app does:** 226 explicit payers
- **User reaction:** 1★-burst
- **Magnitude:** | n | mean ★ | 1★ | 2★ | 3★ | 4★ | 5★ ; Paid cohort | 226 | 1.94 | 138 (61.1%) | 31 | 15 | 17 | 25 (11.1%) ; Whole corpus | 1,281 | 3.509 | 336 (26.2%) | 88 | 103 | 96 | 658 (51.4%) ; 226 (17.64%) is a floor
- **Direction for us:** must-never-break · **Report confidence:** segment rate · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R09-082 — Money left the account but Plus never activated

- **Where:** §4.5 mechanic 4 — M-payfail: money left the account but Plus never activated
- **This app does:** purchase not entitled
- **User reaction:** 1★-burst
- **Magnitude:** M-payfail 16 (1.25%, MEANINGFUL), mean 1.81; 12 of 16 paid; RU 6
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11687224311`, `12442228880`, `12650182347`, `12791514383`, `12609778626`, `13711157656`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C077 Purchase and signup flow must not leak buyers

### R09-115 — Fix the Russia backend reachability problem as an infrastructure / CDN / regional-endpoint issue, not client performance

- **Where:** Part 7 §7.1 #1 Fix the Russia backend reachability problem
- **This app does:** RU unreachable
- **User reaction:** 1★-burst
- **Magnitude:** 52 of 113 RU minute-long loads; 6 VPN-only; 36 RU paid; RU written 2.38
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** app-specific
- **Conditions:** evidence: R09-030, R09-092
- **Canonical:** C132 Do not sell in a storefront where the app cannot function; C031 Crashes / launch failures

### R09-118 — Rate-limit nothing in the AI coach's crisis path, and add a handoff — non-negotiable in a 4+ ADHD/self-care app

- **Where:** Part 7 §7.1 #4 Rate-limit nothing in the AI coach's crisis path, and add a handoff
- **This app does:** message cap applies mid-crisis
- **User reaction:** 1★-burst
- **Magnitude:** 1 reviewer cut off mid-crisis
- **Direction for us:** must-never-break · **Report confidence:** immediate (safety) · **Generalisable:** yes
- **Conditions:** evidence: R09-111
- **Review IDs:** `14507626498`
- **Canonical:** C151 Never cap or paywall a support conversation mid-crisis

### R09-119 — Clinically review the in-app depression and ADHD screens — a false-negative for a suicidal user, scaremongering at teenagers, generic ADHD content

- **Where:** Part 7 §7.1 #5 Clinically review the in-app depression and ADHD screens
- **This app does:** unvalidated screens
- **User reaction:** complaint
- **Magnitude:** 3 reviews
- **Direction for us:** must-never-break · **Report confidence:** immediate (safety) · **Generalisable:** yes
- **Conditions:** evidence: R09-027
- **Review IDs:** `11976398530`, `14069820135`
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R09-120 — Display currency explicitly in every storefront — cheap, and removes a fraud perception

- **Where:** Part 7 §7.1 #6 Display currency explicitly in every storefront
- **This app does:** ambiguous currency
- **User reaction:** complaint
- **Magnitude:** 19 M-unclear; 4 of 74 MX
- **Direction for us:** must-never-break · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R09-096
- **Canonical:** C113 One stable, disclosed price — no discount wheels

## Features

### R09-022 — The specific cause: an animated guided-breathing exercise with the beaver (4-7-8 technique) runs once during onboarding and is never available again — 'why draw a beaver just for the first time?'; 'the breathing exercise from the introduction is not available afterwards. That was one of the things that convinced me'; 'there was misleading advertising… I took the subscription for that'; 'that's not inside the app. It's just to trick you'

- **Where:** §0.5 G-guide — guided breathing exercise shown in onboarding only; Part 7 §7.3 #1
- **This app does:** onboarding-only guided exercise
- **User reaction:** churn
- **Magnitude:** G-guide 21 (1.64%, MEANINGFUL), mean 2.33; six languages; high-spend 3.8%; DE 4
- **Direction for us:** must-have · **Report confidence:** meaningful, specific, cheap · **Generalisable:** yes
- **Review IDs:** `12885713029`, `12699837651`, `12645661722`, `12754744101`, `11830287049`, `12238297592`, `12609839103`, `13309724057`, `11607493158`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate

### R09-035 — Pre-made routine templates (Discover) are the paid layer and the single most-cited gated feature — 'the proposed routines are all paid' — and the most-voted free-tier guide describes browsing the paid routines and re-typing the ideas manually as free custom habits

- **Where:** §1.1 'Keşfet' / Discover — pre-made routine templates Paid; §1.3; §5.1-FR M-gated
- **This app does:** Discover templates Plus-only
- **User reaction:** mixed
- **Magnitude:** M-gated 31 (2.42%, MEANINGFUL), mean 2.90; FR 5 (10.0%); 86 helpful votes on the workaround review
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11525075222`, `12174607035`, `12620617170`
- **Canonical:** C118 Preset routines / templates / programs

### R09-036 — Mood selection is free but writing journal text is paid — buyers expected 'all the tools (journal and other trackers)' — and engaged users ask for real free-text daily entries and a photo of the day

- **Where:** §1.1 Journal / mood + emotion logging; §4.4 journal + trackers row; §2.2 G-notes
- **This app does:** mood picker free, text entry Plus
- **User reaction:** complaint
- **Magnitude:** G-notes 9 (0.70%, EMERGING), mean 3.11
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13021325704`, `12209118679`
- **Canonical:** C049 Mood tracker / journal / habit notes

### R09-037 — Widgets are paid in some storefronts (SA, ID) and reported free in the US — inconsistent — and a Saudi 1★ argues charging for widgets specifically is unfair

- **Where:** §1.1 Home-screen widgets row; §2.2 G-widget; Part 7 §7.3 #9
- **This app does:** widgets paid by storefront
- **User reaction:** complaint
- **Magnitude:** G-widget 11 (0.86%, EMERGING), mean 3.18; 4★ band 4
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12451223326`, `13276823733`, `13021325704`
- **Canonical:** C009 Basic widgets, icons and colours are free

### R09-038 — Daily affirmations and the beaver mascot are free and do real emotional work, but affirmations cannot be turned off and the mascot appeared in an update and cannot be dismissed — make them optional, do not remove them

- **Where:** §1.1 Daily affirmations and Beaver mascot rows; Part 7 §7.4
- **This app does:** non-removable affirmations; undismissable mascot
- **User reaction:** mixed
- **Magnitude:** report gives none beyond named reviews
- **Direction for us:** do · **Report confidence:** qualitative · **Generalisable:** yes
- **Review IDs:** `13860369435`, `13624114897`, `11526412509`, `12284703983`
- **Canonical:** C117 Mascot / companion character

### R09-039 — Not present and requested: an Apple Watch app, a usable iPad build, Apple Calendar sync, dark mode, and habit sharing with friends

- **Where:** §1.1 Not present, and repeatedly requested; §2.2 G-sync, G-calendar
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** G-sync (iPad / Watch / multi-device) 7 (0.55%), 3.00; G-calendar 5 (0.39%), 3.20; dark mode 4; G-social 3 (0.23%), 3.33
- **Direction for us:** research · **Report confidence:** emerging to weak · **Generalisable:** yes
- **Review IDs:** `11966810600`, `12343427636`, `11713261203`, `11713566182`, `12020346318`, `13038158254`, `12464161947`, `12458138764`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C141 Native iPad layout

### R09-050 — Richer scheduling from engaged users: sub-daily repetition (5× daily for prayers, water), 'any N days of the week' without fixing which days, explicit weekday selection, skip/vacation — two subscribers have written the spec

- **Where:** §2.2 The frequency model is the most-misunderstood part of the product; Part 7 §7.3 #3
- **This app does:** daily / weekly / monthly only; no weekday pick
- **User reaction:** complaint
- **Magnitude:** G-freq 22 (1.72%, MEANINGFUL), mean 3.14; 3★ band 7; 4★ band 4; FR 3
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11686508200`, `11668735422`, `12183108635`, `12695260948`, `12017205465`
- **Canonical:** C043 Flexible / custom frequency; C143 Intra-day completion: tap N times to fill N/N; C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R09-051 — Preset habits cannot be renamed or edited and habits/routines cannot be deleted — and the store listing claims you can

- **Where:** §2.2 G-noedit and G-nodelete; Part 7 §7.3 #4
- **This app does:** presets locked; no delete
- **User reaction:** complaint
- **Magnitude:** G-noedit 20 (1.56%, MEANINGFUL), mean 2.55; G-nodelete 15 (1.17%), mean 3.13; DE 4
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14400137816`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free; C114 Ads must match the app

### R09-052 — More and deeper routine content is wanted (cleaning, study, sport, weekend, pets), and every preset habit needs a 'how to do this' body — a reminder that just says 'forehead lines' leaves the user asking 'what do I do?'; only the heading is shown

- **Where:** §2.2 G-content; Part 7 §7.3 #2
- **This app does:** preset habits are bare titles
- **User reaction:** complaint
- **Magnitude:** G-content 30 (2.34%, MEANINGFUL), mean 3.40; 4★ band 6; TR 16 (3.4%)
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12357846588`, `12710666495`
- **Canonical:** C118 Preset routines / templates / programs; C148 The paid product must deliver what the ads and onboarding demonstrate

### R09-053 — Routines interleave into one list: users want to group the day (cleaning / self-care / study), drag to reorder, and stop the same habit appearing 2–3 times

- **Where:** §2.2 G-group, G-order, G-dup; Part 7 §7.3 #5
- **This app does:** single interleaved list; duplicates
- **User reaction:** complaint
- **Magnitude:** G-group 13 (1.01%), 2.69; G-order 8 (0.62%), 2.38; G-dup 8 (0.62%), 2.25
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13099009549`, `12464161947`, `11491997138`, `12272862926`
- **Canonical:** C045 Grouping / folders / tags / multiple profiles; C073 Manual reordering, renaming and editing of habits/tasks — free

### R09-054 — More icons, emoji and colours — 'only 6 colours', 'only 60 emoji' — cheap and asked by engaged users

- **Where:** §2.2 G-icons; Part 7 §7.3 #6
- **This app does:** 6 colours, 60 emoji
- **User reaction:** complaint
- **Magnitude:** G-icons 14 (1.09%, MEANINGFUL), mean 3.57; 4★ band 5
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11607493158`, `11703804318`
- **Canonical:** C080 Colour themes / dark mode

### R09-055 — Time ranges and durations (start/end, not just a point), sub-tasks, quantity targets ('8 of 10 glasses of water') and a stopwatch — asked by a premium user who calls the app 'only a surface-level app'

- **Where:** §2.2 G-time and G-sub; Part 3 4★ premium user list
- **This app does:** point-in-time binary tasks
- **User reaction:** complaint
- **Magnitude:** G-time 10 (0.78%), 2.50; G-sub 7 (0.55%), 3.29
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11646116789`
- **Canonical:** C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N

### R09-056 — An audible completion sound / alarm tone instead of a silent push — Saudi Arabia is the notification/alarm market, where one reviewer gives a five-point audit of the alarm system

- **Where:** §2.2 G-sound; §5.4 SA; Part 7 §7.1 #7
- **This app does:** silent push only
- **User reaction:** complaint
- **Magnitude:** G-sound 9 (0.70%), 2.33; + B-notif 12; SA B-notif 4, G-sound 3
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11836191831`
- **Canonical:** C074 Customisable, louder reminder sounds

### R09-057 — Tick off a day you missed, and plan further ahead than 3–4 days — one German user cancelled over the planning horizon

- **Where:** §2.2 G-backfill and G-future; Part 7 §7.3 #7
- **This app does:** no backfill; 3–4-day horizon
- **User reaction:** churn
- **Magnitude:** G-backfill 6 (0.47%), 2.83; G-future 6 (0.47%), 3.50
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12847151988`, `14066249834`
- **Canonical:** C010 Backfill missed days / edit start date

### R09-058 — Statistics are free but thin — 'just numbers with no detail' — users want per-habit streaks and counts

- **Where:** §2.2 G-stats; §1.1 Statistics row
- **This app does:** basic numbers
- **User reaction:** complaint
- **Magnitude:** G-stats 6 (0.47%), 2.33
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11823311515`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R09-059 — Small requests: one-off to-dos alongside habits, a version for children, and a Monday week start (FR, FI)

- **Where:** §2.2 G-todo, G-kids, G-cal-start
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** G-todo 5 (0.39%), 3.00; G-kids 4 (0.31%), 2.75; G-cal-start 2 (0.16%), 3.50
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C050 One-off to-dos alongside habits

### R09-064 — The beaver mascot splits users: 4 love it, 2 reject it ('I couldn't with the beaver. Why a beaver?'; 'I'm not a dog'), and one reports it appeared in an update and cannot be dismissed

- **Where:** §2.3 Mixed themes — The mascot
- **This app does:** beaver mascot
- **User reaction:** mixed
- **Magnitude:** 4 positive, 2 negative, 1 undismissable
- **Direction for us:** undecided · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11526412509`, `12284703983`, `12308282270`, `13367660347`, `12148653483`, `12623899009`, `13860369435`
- **Canonical:** C117 Mascot / companion character

### R09-111 — A 2026 AI coach ('Mimi') with a hard free message cap is valued ('please raise the coach chat limit — it's genuinely good to talk to') but cut one user off mid-crisis: 'I was in a very difficult moment, I went to talk to Mimi and the chat hit the limit… I was almost having a collapse… I'm still breaking down in tears' — rate-limiting an emotional-support conversation in a 4+ ADHD/self-care app is a product-safety decision, not a pricing one

- **Where:** §6.6 Trend 5 — New in 2026: an AI coach, and a safety question with it; Part 7 §7.1 #4
- **This app does:** AI coach, free with a message cap, more messages paid
- **User reaction:** mixed
- **Magnitude:** X-ai 5 (0.39% globally, 2.84% of P3), all 2026; 2 say Mimi is valuable; 1 cut off mid-crisis
- **Direction for us:** must-never-break · **Report confidence:** safety · **Generalisable:** yes
- **Review IDs:** `14302044695`, `13810246956`, `13860369435`, `14084062489`, `14507626498`
- **Canonical:** C151 Never cap or paywall a support conversation mid-crisis; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R09-121 — Add an audible completion/alarm option — fixes a whole market's (SA) core complaint

- **Where:** Part 7 §7.1 #7 Add an audible completion/alarm option
- **This app does:** silent push
- **User reaction:** complaint
- **Magnitude:** 9 G-sound + 12 B-notif
- **Direction for us:** build-free · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R09-056
- **Review IDs:** `11836191831`
- **Canonical:** C074 Customisable, louder reminder sounds

### R09-127 — Make the guided breathing exercise re-runnable from the habit itself — the most specific, most repeated, cheapest high-impact request in the corpus

- **Where:** Part 7 §7.3 #1 Make the guided breathing exercise re-runnable from the habit itself
- **This app does:** onboarding-only
- **User reaction:** churn
- **Magnitude:** 21 G-guide in 6 languages
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-022
- **Review IDs:** `12885713029`, `12699837651`, `12609839103`, `13309724057`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate

### R09-128 — Attach a 'how to do this' body to every preset habit — turns the paid Discover library from a name list into content

- **Where:** Part 7 §7.3 #2 Attach a 'how to do this' body to every preset habit
- **This app does:** bare titles
- **User reaction:** complaint
- **Magnitude:** G-thin + G-guide
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-052
- **Review IDs:** `12357846588`, `12710666495`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate; C118 Preset routines / templates / programs

### R09-129 — Ship the frequency model reviewers describe — N× per day, any N days per week, explicit weekdays, skip/holiday

- **Where:** Part 7 §7.3 #3 Ship the frequency model reviewers describe
- **This app does:** limited scheduling
- **User reaction:** complaint
- **Magnitude:** 22 G-freq
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-050
- **Review IDs:** `11668735422`, `12695260948`
- **Canonical:** C043 Flexible / custom frequency; C143 Intra-day completion: tap N times to fill N/N

### R09-130 — Make preset habits editable and everything deletable — the listing already claims you can

- **Where:** Part 7 §7.3 #4 Make preset habits editable and everything deletable
- **This app does:** locked presets
- **User reaction:** complaint
- **Magnitude:** 20 G-noedit + 15 G-nodelete
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-051
- **Review IDs:** `14400137816`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free

### R09-131 — Group / categorise the day so cleaning, self-care and study don't collapse into one list

- **Where:** Part 7 §7.3 #5 Group/categorise the day
- **This app does:** one list
- **User reaction:** complaint
- **Magnitude:** 13 G-group + 8 G-order + 8 G-dup
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-053
- **Review IDs:** `13099009549`, `12464161947`, `11491997138`
- **Canonical:** C045 Grouping / folders / tags / multiple profiles

### R09-132 — Expand icons, emoji and colours — low cost, all from engaged users

- **Where:** Part 7 §7.3 #6 Expand icons, emoji and colours
- **This app does:** 6 colours, 60 emoji
- **User reaction:** complaint
- **Magnitude:** 14 G-icons, mean 3.57
- **Direction for us:** undecided · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-054
- **Review IDs:** `11607493158`, `11703804318`
- **Canonical:** C080 Colour themes / dark mode

### R09-133 — Backfill and forward-planning — tick off yesterday; plan more than 3–4 days ahead

- **Where:** Part 7 §7.3 #7 Backfill and forward-planning
- **This app does:** no backfill
- **User reaction:** churn
- **Magnitude:** 6 + 6
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-057
- **Review IDs:** `12847151988`, `14066249834`
- **Canonical:** C010 Backfill missed days / edit start date

### R09-135 — Widgets, dark mode, iPad, Apple Watch — in that order of demand; charging for widgets specifically is argued to be unfair

- **Where:** Part 7 §7.3 #9 Widgets, dark mode, iPad, Apple Watch — in that order of demand
- **This app does:** absent or paid
- **User reaction:** complaint
- **Magnitude:** 11 + 4 + 7 reviews
- **Direction for us:** undecided · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-037, R09-039
- **Review IDs:** `12451223326`
- **Canonical:** C009 Basic widgets, icons and colours are free; C141 Native iPad layout; C022 Apple Watch app (done properly: timer, two-way sync)

## Monetization

### R09-003 — This is a hard-paywall product and money is the single biggest thing reviewers talk about: the listing is Free, but the core loop is gated behind a 'Plus Membership' subscription with five price points and, per the corpus, no free trial in most storefronts

- **Where:** ⚠️ Read these three things before anything else — 1. This is a hard-paywall product
- **This app does:** hard paywall; Plus $6.99–$79.99; no trial in most storefronts
- **User reaction:** 1★-burst
- **Magnitude:** 434 of 1,281 (33.88%, HIGH-PRIORITY) carry a money theme, mean 2.13
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C147 Let people use the product before they pay

### R09-009 — No free trial is the highest-leverage single fix, and reviewers specify the remedy and say they would have bought: 'The single biggest missing thing is a trial period… because there's no such option, 7 out of 10 people just choose not to buy' (20 helpful votes); 'I'm happy to pay for an app… but I don't want to buy one blind'; 'I'd want to buy an app like this, but I'm giving up because I don't want to pay and then fight a refund process'

- **Where:** §0.2 The 'no free trial' complaint is the highest-leverage single fix in the corpus; §5.2 conclusion 1; Part 7 §7.2 Part A
- **This app does:** no trial in most storefronts
- **User reaction:** blocked-conversion
- **Magnitude:** M-notrial 52 (4.06%, VERY STRONG), mean 1.83; + WTP 4 → 'I would pay if you let me look first' cohort 55 (4.29%); high-spend group 7.2%; DE 6 (16.2% of DE); asks 3 days – 1 week
- **Direction for us:** undecided · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `11642792565`, `11854298993`, `12291766651`, `12025237180`, `12683497729`, `12636034921`
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay

### R09-041 — Plan structure as users meet it: weekly ≈ $7.99 / €7.99, with Turkish users repeatedly describing a weekly charge presented as if it were monthly; annual $39.99, ~$60, ₺199.99–₺699.99, ₪200, €20, ₹649, 129 DKK at 50% off

- **Where:** §1.2 The pricing model [external + corpus]
- **This app does:** weekly + annual Plus; five IAP price points
- **User reaction:** complaint
- **Magnitude:** 5 TR reviews describe weekly-shown-as-monthly; price points $6.99 / $16.99 / $27.99 / $39.99 / $79.99
- **Direction for us:** must-never-break · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `12221358308`, `11436403992`, `11587765683`, `11642792565`, `11722946564`, `12652692645`, `13966657008`, `12209118679`, `13316643309`, `11539871453`, `12257289655`, `11690398268`, `12479597871`, `12190059793`, `12301387923`, `12919237808`, `12966178467`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R09-123 — Ship a real trial everywhere — not 24 hours; reviewers ask for 3 days to 1 week — and eliminate the storefront inconsistency

- **Where:** §7.2 Part A — Ship a real trial, everywhere
- **This app does:** trial in some storefronts only
- **User reaction:** blocked-conversion
- **Magnitude:** asks: '3 Tage', '1 haftalık', '1-2 gün', '1-2 Wochen'
- **Direction for us:** undecided · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-009, R09-042
- **Review IDs:** `11854298993`, `12523888830`, `12636034921`, `12683497729`
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

## Tactics the app used

### R09-013 — Tactic: the guarantee claim was removed from the purchase flow around Dec 2024 – Feb 2025 ('the money-back guarantee is no longer mentioned'). Outcome: guarantee complaints went to zero, trial-trap complaints to zero, and refund complaints halved — removing a promise the business could not keep measurably reduced the worst category of complaint

- **Where:** EXECUTIVE SUMMARY One thing that already got fixed; §6.4 Trend 3 — The money-back guarantee was quietly withdrawn, and the refund complaint rate halved
- **This app does:** withdrew the guarantee claim
- **User reaction:** praise
- **Magnitude:** M-guarantee 2.80% (P1) → 0.62% → 0.00%; M-trialtrap 1.51% → 0.47% → 0.00%; M-refund 9.70% → 7.80% → 3.98%
- **Direction for us:** do · **Report confidence:** observed (two readings, corpus supports this one) · **Generalisable:** yes
- **Conditions:** whether it reduced conversion is unknown (research question)
- **Review IDs:** `12017205465`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised

### R09-088 — Tactic: developer replies to reviews fix individual problems. Outcome: a Turkish user who lost their subscription edited the review after the developer's response — 'Following your reply I reopened the app… my subscription is usable again, thanks'; others were refunded or helped

- **Where:** §4.5 Counter-evidence worth noting — P-support
- **This app does:** replies to some reviews
- **User reaction:** praise
- **Magnitude:** P-support 4; 11 reviews marked is_edited
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12745580868`, `12827787443`, `13534159613`, `13622846328`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

## Insights (the why)

### R09-004 — Dear Me is a well-loved product wrapped in an acquisition funnel that is actively destroying its own reputation, sold to a paying cohort that rates it 1.94 stars

- **Where:** EXECUTIVE SUMMARY headline
- **This app does:** hard paywall, long quiz, rating prompt in sign-up, heavy upsell
- **User reaction:** mixed
- **Magnitude:** paid cohort 226 at 1.94; praise themes 297 at 4.78; money themes 434 at 2.13
- **Direction for us:** product-rule · **Report confidence:** headline · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R09-018 — Praise is narrow and consistent: 'it organises my day' and 'it changed my life' are the product — every roadmap item should be tested against whether it makes the daily organise-and-tick loop better

- **Where:** §0.4 praise converges on two things; §7.4
- **This app does:** daily routine checklist
- **User reaction:** praise
- **Magnitude:** praise themes 297 (23.19%), mean 4.78; P-org 106 (8.27%), 4.92; P-outcome 101 (7.88%), 4.92; MX P-org 20.3%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12024330293`, `12221935483`, `14309372488`
- **Canonical:** — (nuance register)

### R09-063 — Design is praised but cannot carry a broken product — 'Stars only for the design'; 'Inconvenient, useless, but beautiful' — and some find the palette too loud or childish

- **Where:** §2.3 Mixed themes — Design
- **This app does:** bright illustrated palette
- **User reaction:** mixed
- **Magnitude:** P-design 33 (2.58%), mean 4.45; RU 10 (8.8%)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12875174028`, `13600520150`, `12998493686`, `13585793108`
- **Canonical:** C057 Offer a non-pastel / premium design option

### R09-073 — Five-stars with substance are about organisation and change — a chronic procrastinator 100 days in; 'my life CHANGED'; 'the first time in my life I paid for an app. It deserves every bit'

- **Where:** Part 3 5★ Representative 5★ with substance
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** P-org 100 (15.2% of 5★); P-outcome 94 (14.3%)
- **Direction for us:** none · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `12024330293`, `12221935483`, `14309372488`, `13571506850`, `12244252131`, `13270893215`
- **Canonical:** — (nuance register)

### R09-074 — The 4★ band is where paying customers write feature specs — an annual subscriber's four numbered improvements calling the price fair; German 5- and 8-point lists ('then 5 stars would be more than deserved'); these are the reviews to build from

- **Where:** Part 3 4★ — n = 96 (7.49%) — the 'one thing away' band table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 4★ band ; `PAID` | 17 | 17.7% ; `M-price` | 14 | 14.6% ; `B-load` | 7 | 7.3% ; `G-content` | 6 | 6.2% ; `G-icons` / `G-noedit` | 5 / 5 | 5.2% / 5.2% ; `M-nag` | 5 | 5.2% ; `G-widget` / `G-guide` / `G-freq` | 4 each | 4.2% each ; 17.7% of 4★ paid
- **Direction for us:** do · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `13005854395`, `12464161947`, `12699837651`, `11646116789`
- **Canonical:** — (nuance register)

### R09-075 — 3★ is 'I can't tell if this is worth it': 'what's the difference between the subscription and the free version? It isn't explained at all'; 'With all the interruptions of purchasing a subscription, discovering the app is very difficult'; stars docked for the pre-use rating prompt and the missing trial

- **Where:** Part 3 3★ — n = 103 (8.04%) — value-uncertainty band table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 3★ band ; `M-price` | 17 | 16.5% ; `PAID` | 15 | 14.6% ; `M-wall` | 9 | 8.7% ; `G-content` / `G-freq` / `M-nag` / `B-load` | 7 each | 6.8% each ; `M-refund` | 6 | 5.8% ; `U-conf` / `M-notrial` | 6 each | 5.8% each
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `12399224524`, `12127963469`, `13175470414`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R09-076 — 2★ is buyer's remorse — more than a third paid: 'nothing more than a to do list… I expected all the tools (journal and other trackers)'; 'after the purchase I realised it only has the function of marking whether you did the task'

- **Where:** Part 3 2★ — n = 88 (6.87%) — the buyer's-remorse band table (verbatim)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Theme | n | % of 2★ band ; `PAID` | 31 | 35.2% ; `G-thin` | 15 | 17.0% ; `B-load` | 15 | 17.0% ; `M-regret` | 12 | 13.6% ; `G-guide` / `M-notrial` / `M-nag` | 10 each | 11.4% each ; `M-wall` / `M-refund` / `M-price` | 9 each | 10.2% each
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `12209118679`, `11552361877`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate

### R09-078 — The one-star band is not people who wouldn't pay — 41.1% of one-star reviewers paid and then could not get the product, the value, or their money back; only 5 of 336 carry no theme

- **Where:** Part 3 1★ 41.1% of one-star reviewers paid money
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** PAID 138 of 336 (41.1%); 5 of 336 unclassified
- **Direction for us:** must-never-break · **Report confidence:** observed · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R09-081 — Price objections come from non-buyers; buyers complain about value, delivery and refunds — and Russian subscribers pay and then cannot use the product, asking for a refund in the same sentence

- **Where:** §4.2 Price objections come from non-buyers; buyers complain about value, delivery and refunds
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** M-price 19 of 123 paid (8.4%); 97 of 102 refund, 50 of 50 regret, 31 of 34 cancel, 15 of 17 guarantee, 10 of 10 trial-trap from paid; B-load 28 of 66 paid (12.4%)
- **Direction for us:** product-rule · **Report confidence:** segment rates · **Generalisable:** yes
- **Review IDs:** `13511607324`, `13523804710`, `13527113749`, `13588434539`, `14134826933`, `14137219709`, `13129532846`, `13734613349`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R09-083 — Explicit fraud / theft accusations are the lowest-rated money theme — Chile has the highest scam-accusation rate per review

- **Where:** §0.2 M-scam; §5.4 CL
- **This app does:** hard paywall + refund friction
- **User reaction:** 1★-burst
- **Magnitude:** M-scam 30 (2.34%, MEANINGFUL), mean 1.20; 15 paid; CL 3 of 24
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11825830145`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R09-084 — Paid, then regretted it — every regret statement comes from a buyer

- **Where:** §0.2 M-regret; §4.2
- **This app does:** pre-experience purchase
- **User reaction:** churn
- **Magnitude:** M-regret 50 (3.90%, VERY STRONG), mean 1.56; 50 of 50 paid (22.1% of paid cohort); 2★ band 12 (13.6%)
- **Direction for us:** none · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R09-085 — Four of five purchase triggers are pre-experience — a social/video ad promising a capability, the end-of-quiz 'your plan is ready, you only need to pay $700 pesos', the −50% newcomer timer, the onboarding breathing demo — and the only post-experience trigger, genuine early delight ('paid for a year within the first minute'; 'the first app I ever wanted to pay for'), is the rarest; the funnel converts before the product can prove itself, so the product must be retroactively good enough to justify a purchase already made

- **Where:** §4.3 What triggers a purchase — stated by buyers themselves
- **This app does:** funnel engineered to convert pre-use
- **User reaction:** purchase-driver
- **Magnitude:** 5 trigger patterns; triggers 1–4 pre-experience
- **Direction for us:** product-rule · **Report confidence:** structural reading · **Generalisable:** yes
- **Review IDs:** `12633273226`, `11789743896`, `12755295856`, `11718643683`, `14134826933`, `12286738501`, `11472460295`, `12966178467`, `12645661722`, `11805353050`, `14309372488`, `12769176601`
- **Canonical:** C147 Let people use the product before they pay

### R09-086 — The value gap in buyers' own words: a coach vs a self-filled checklist, guided exercises vs one onboarding animation, a personalised plan vs generic presets, journal vs a paywalled text box, much more than free vs 'not much' — 'I'm a paying user. But I genuinely don't know what extra it gives me… it's full of extremely superficial plans'

- **Where:** §4.4 What buyers say they got — the value gap table (verbatim)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Buyer expectation, from their own words | What they report receiving | IDs ; A coach that tells you what to do and how | A checklist you fill in yourself | `11860805909`·TR·1, `12052410758`·TR·2, `11672639638`·TR·1, `12971647904`·BR·2, `11698858385`·BR·1 ; Guided exercises (breathing, stretching) | One breathing animation, in onboarding only | `12206654248`·JP·1, `12645661722`·FR·2, `12754744101`·MX·1, `12885713029`·RU·2 ; A personalised plan from the quiz | Generic presets identical for everyone | `12587805273`·RU·1, `13521538789`·RU·1, `12755295856`·CA·1 ; Journal + trackers "in the app" | Mood picker free, text entry paywalled | `12209118679`·US·2, `13021325704`·US·2 ; Substantially more than the free tier | *"The difference between basic and premium is not much"* | `12755295856`·CA·1, `12400544803`·TR·2, `12164091003`·FR·1, `13632737127`·TR·1 ; A working app | Loading spinners, network errors | 28 paid `B-load` reviews
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `11860805909`, `12052410758`, `11672639638`, `12971647904`, `11698858385`, `12206654248`, `12587805273`, `12400544803`, `12164091003`, `13632737127`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate

### R09-104 — What does not vary by country: praise content is universal (organise and life change top in TR, BR, MX, US, CO, ES, IL — the value proposition translates), 'just a checklist' appears everywhere (not a cultural response), and nobody anywhere asks for data export

- **Where:** §5.5 What does not vary by country
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** G-thin TR 7.9%, US 13.6%, BR 6.7%, RU 7.1%, MX 6.8%, FR 8.0%; export 0
- **Direction for us:** none · **Report confidence:** observed · **Generalisable:** yes
- **Canonical:** — (nuance register)

## Audiences

### R09-019 — Motivation and ADHD / mental-health benefit are the only two themes with a perfect 5.00 mean and zero reviews below 5★ — the warmth (mascot, colour, affirmations, encouragement) is the emotional core: 'The best app for people with ADHD… the only app that didn't make me recoil'; 'this app just takes cares of me like a person'

- **Where:** §0.4 P-motiv and P-adhd are the only two themes with a perfect 5.00 mean; §7.4
- **This app does:** warm, mascot-led tone
- **User reaction:** 5★-burst
- **Magnitude:** P-motiv 32 (2.50%), mean 5.00; P-adhd 16 (1.25%), mean 5.00; ADHD mentions 17, 16 positive; BR 4 of 17 ADHD
- **Direction for us:** do · **Report confidence:** meaningful, perfect-scoring · **Generalisable:** yes
- **Review IDs:** `13270893215`, `13546243872`, `12631417278`, `11604948163`, `12808430071`, `13437517000`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C095 Neutral, non-judgemental tone on failure

### R09-027 — Safety: a 4+-rated Health & Fitness app administers depression and ADHD self-assessments — a friend who was suicidal was given a benign depression result; the ADHD test is 'needless scaremongering especially for teenagers' — and rate-limits an emotional-support chat; it needs a clinical-safety review regardless of volume

- **Where:** §0.6 One review is worth calling out on its own for safety reasons; EXECUTIVE SUMMARY finding 7; Part 7 §7.1 #5
- **This app does:** in-app depression/ADHD screens without evident validation
- **User reaction:** complaint
- **Magnitude:** 3 reviews (0.23%), promoted under the safety carve-out
- **Direction for us:** must-never-break · **Report confidence:** safety carve-out · **Generalisable:** yes
- **Review IDs:** `11976398530`, `14069820135`, `14507626498`
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R09-028 — Smaller onboarding exclusions: age brackets stop at 50/59; content written for women only; objections to inclusive Spanish ('todes'); personal-data/permission concerns; a handwritten-signature commitment step — and a French 4★ asking the developer to stop depicting only women doing housework in promo clips

- **Where:** §0.6 O-agegate, O-gender, O-inclusive, O-privacy, O-signature; §5.1-FR gender critique
- **This app does:** women-first content and marketing; capped age brackets
- **User reaction:** complaint
- **Magnitude:** O-agegate 5 (0.39%), 2.60; O-gender 5 (0.39%), 2.00; O-inclusive 2 (0.16%), 2.00; O-privacy 6 (0.47%), 1.50; O-signature 1
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12035339575`, `13005363984`, `13193031233`
- **Canonical:** — (nuance register)

### R09-062 — The notification behaviour increases anxiety in the exact audience the app targets: a 'take a deep breath' notification at midnight and an 'overdue task' alert that 'immediately stressed me out'

- **Where:** §2.3 X-anxiety; §5.1-US
- **This app does:** overdue alerts, late-night nudges
- **User reaction:** 1★-burst
- **Magnitude:** X-anxiety 6 (0.47%); US 2, CA 2
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `12184046988`, `11764762613`, `12298944709`, `11603369138`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

## Markets and languages

### R09-032 — Japanese custom-habit text entry was broken (kanji conversion and dakuten) in August 2024 — a subscriber bought the annual plan and then could not type — and Japanese written sentiment never recovered after the fix

- **Where:** §0.7 B-ime Japanese text input broken; §2.5 Japanese
- **This app does:** IME input broken Aug 2024
- **User reaction:** 1★-burst
- **Magnitude:** B-ime 7 (0.55%), mean 1.86, JP 7 of 7, Aug 2024 only; JP n=25 mean 2.80 [limited evidence]
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** app-specific
- **Review IDs:** `11614598675`, `11624500796`
- **Canonical:** C027 Localise early — it unlocks revenue

### R09-042 — Free-trial availability depends on the storefront and reviewers compare notes in public: 'for anyone asking about a trial: it depends on account type — an American account gets a trial, a Saudi account does not'; the terms say 'We make no representation or warranties that you will be offered any Trials' — a trial in one country and none in another is worse than no trial anywhere

- **Where:** §1.2 Free-trial availability is inconsistent by storefront, and reviewers noticed; Part 7 §7.2 Part A
- **This app does:** trial in US, none in SA and most others
- **User reaction:** blocked-conversion
- **Magnitude:** 52 reviewers across TR, RU, DE, FR, SA, BE, NL, AU, PK, IN say there is no trial
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11836191831`, `13021325704`
- **Canonical:** C109 A free trial must be a real trial

### R09-067 — Machine translation is a paid-user problem: Japanese phrasing is odd, Hebrew 'beneath criticism' and rendered reversed, Russian 'translated by a translator with no human involvement — headings shifted, long words don't fit', a Saudi subscribed for a full year before finding the Arabic 'very bad', and Brazilian support content is in English

- **Where:** §2.5 Localization quality is a paid-user problem in four languages; Part 7 §7.3 #8
- **This app does:** machine-translated JA, HE, RU, AR; English support in PT
- **User reaction:** 1★-burst
- **Magnitude:** G-l10n 14 (1.09%, MEANINGFUL), mean 1.79; JP G-l10n 3 + B-ime 7
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11614598675`, `11624500796`, `11890679534`, `12513379051`, `13038071101`, `12562609306`, `11895224084`
- **Canonical:** C027 Localise early — it unlocks revenue

### R09-090 — TR / RU / BR / MX / US / FR side by side: n, mean, 1★, 5★, money, bug and paid shares

- **Where:** §5.1 The six eligible storefronts table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | % of corpus | mean ★ | 1★ | 5★ | MONEY-any | BUG-any | PAID ; TR Türkiye | 471 | 36.77% | 3.71 | 24.2% | 57.5% | 35.7% | 7.6% | 21.7% ; RU Russia | 113 | 8.82% | 2.38 | 46.9% | 20.4% | 55.8% | 56.6% | 31.9% ; BR Brazil | 104 | 8.12% | 4.02 | 19.2% | 68.3% | 21.2% | 8.7% | 14.4% ; MX Mexico | 74 | 5.78% | 4.09 | 14.9% | 68.9% | 18.9% | 4.1% | 8.1% ; US United States | 59 | 4.61% | 3.75 | 18.6% | 59.3% | 35.6% | 8.5% | 15.3% ; FR France | 50 | 3.90% | 2.64 | 42.0% | 26.0% | 48.0% | 14.0% | 20.0%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-091 — Türkiye is where the refund crisis lives and also the strongest positive signal: the commercial problem is Turkish, the technical one is not (defect rate 7.6%); Turkish reviewers use the review field as a customer-service channel (one pastes a transaction UUID) and price sensitivity is expressed in lira (₺200, ₺300, ₺350, ₺400 for three months, ₺699.99/yr)

- **Where:** §5.1 TR — Türkiye (n=471) — the home market and the volume engine table (verbatim)
- **This app does:** home market
- **User reaction:** mixed
- **Magnitude:** TR 471 (36.77%), mean 3.71; refund 59 of 102 (57.8%); cancel 27 of 34 (79.4%); paid 102 of 226 (45.1%); P-outcome 45, P-org 39, P-motiv 16; Theme | n | % of TR | Label ; `PAID` | 102 | 21.7% | HIGH ; `M-refund` | 59 | 12.5% | HIGH ; `M-price` | 51 | 10.8% | HIGH ; `P-outcome` | 45 | 9.6% | HIGH ; `P-org` | 39 | 8.3% | HIGH ; `G-thin` | 37 | 7.9% | HIGH ; `M-cancel` | 27 | 5.7% | HIGH ; `M-wall` | 20 | 4.2% | Very strong ; `P-motiv` / `G-content` | 16 / 16 | 3.4% / 3.4% | Very strong ; `M-regret` | 15 | 3.2% | Very strong ; `M-notrial` | 13 | 2.8% | Meaningful ; `M-gated` | 12 | 2.5% | Meaningful ; `M-guarantee` / `U-conf` / `M-nag` | 11 each | 2.3% each | Meaningful
- **Direction for us:** none · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `11912344269`, `12279199321`, `13036253065`, `13601192854`, `13477378855`, `11946780140`, `11521594260`, `11496072461`, `13565016167`, `12577004433`, `12257289655`
- **Canonical:** C112 In-app cancellation

### R09-092 — Russia is a market in structural failure — 56.6% report a defect ('it turns out to be a mass problem') while carrying the highest paid density: Russians buy a product they then cannot run; Russians are also the least tolerant of a long, sales-heavy onboarding

- **Where:** §5.1 RU — Russia (n=113) — a market in structural failure table (verbatim)
- **This app does:** app unreachable, heavy funnel
- **User reaction:** 1★-burst
- **Magnitude:** RU 113 (8.82%), written 2.38 vs public 4.65 (+2.27); paid 31.9%; O-long 15 of 35; M-nag 26 of 59; Theme | n | % of RU | Label ; `B-load` | 52 | 46.0% | HIGH ; `PAID` | 36 | 31.9% | HIGH ; `M-nag` | 26 | 23.0% | HIGH ; `B-open` | 17 | 15.0% | HIGH ; `M-refund` / `O-long` | 15 each | 13.3% each | HIGH ; `M-wall` | 11 | 9.7% | HIGH ; `P-design` | 10 | 8.8% | HIGH ; `M-notrial` | 9 | 8.0% | HIGH ; `G-thin` | 8 | 7.1% | HIGH ; `B-login` | 7 | 6.2% | HIGH ; `M-price` / `M-payfail` / `B-vpn` / `M-regret` / `B-create` | 6 each | 5.3% each | HIGH ; `B-widget` | 5 | 4.4% | Very strong
- **Direction for us:** must-never-break · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `14137219709`, `12390854923`, `12391307827`, `12769176601`, `13142125739`, `13511607324`, `13523804710`, `13527113749`, `13588434539`, `13383801339`, `13445786577`, `13438625866`, `13909300706`
- **Canonical:** C132 Do not sell in a storefront where the app cannot function

### R09-093 — Russia's payment rails and reachability are sanction-bound: 'my country is under sanctions, and purchases are impossible'; a request for QR/SBP payment inside the app; 'Why place an app in the Russian store that doesn't work without a VPN?'

- **Where:** §5.1 RU — B-vpn and M-payfail point to sanction/payment-rail complications
- **This app does:** App Store billing only; unreachable without VPN
- **User reaction:** blocked-conversion
- **Magnitude:** B-vpn 6 (all RU, 5.3%); M-payfail 6 RU
- **Direction for us:** research · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `12885713029`, `12868940633`, `12574094311`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C132 Do not sell in a storefront where the app cannot function

### R09-094 — Brazil is the healthiest large market — negatives at roughly half the global intensity — and the strongest ADHD constituency relative to size ('Best app for ADHD')

- **Where:** §5.1 BR — Brazil (n=104) — the healthiest large market table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** BR 104 (8.12%), mean 4.02, 68.3% 5★, defects 8.7%, money 21.2%; ADHD 4 of 17; Theme | n | % of BR | Label ; `PAID` | 15 | 14.4% | HIGH ; `P-org` / `P-outcome` | 10 each | 9.6% each | HIGH ; `M-price` | 8 | 7.7% | HIGH ; `G-thin` | 7 | 6.7% | HIGH ; `M-regret` | 5 | 4.8% | Very strong ; `P-easy` | 5 | 4.8% | Very strong ; `P-free` / `ADHD` / `M-refund` | 4 each | 3.8% each | Very strong ; `P-adhd` / `P-design` / `B-onboard` / `B-open` / `M-scam` | 3 each | 2.9% each | Meaningful
- **Direction for us:** none · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `11487094036`, `11629856310`, `13437517000`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R09-096 — Mexico is the clearest 'organisation works' market and the only one with a currency-clarity problem: users ask whether the displayed price is dollars or pesos, and the ambiguity 'makes me suspect a scam' — display currency explicitly in every storefront

- **Where:** §5.1 MX — Mexico (n=74) — the best-rated eligible market table (verbatim); Part 7 §7.1 #6
- **This app does:** ambiguous currency display
- **User reaction:** complaint
- **Magnitude:** MX 74 (5.78%), mean 4.09, defects 4.1%; P-org 20.3% (highest single-theme rate of any eligible country); M-unclear 4 (5.4%); Theme | n | % of MX | Label ; `P-org` | 15 | 20.3% | HIGH ; `PAID` | 6 | 8.1% | HIGH ; `P-design` | 5 | 6.8% | HIGH ; `G-thin` | 5 | 6.8% | HIGH ; `P-outcome` / `M-wall` / `M-unclear` / `P-easy` | 4 each | 5.4% each | HIGH ; `O-ads` / `M-regret` / `M-price` | 3 each | 4.1% each | Very strong ; `O-inclusive` | 2 | 2.7% | Meaningful
- **Direction for us:** must-never-break · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `12785281626`, `11661389308`, `12316153273`, `12885327706`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R09-097 — Inclusive Spanish ('todes', 'nosotres', 'perfectE') drew explicit objections from two otherwise-positive Mexican reviewers

- **Where:** §5.1 MX — inclusive Spanish drew explicit objections [limited evidence]
- **This app does:** inclusive-language Spanish copy
- **User reaction:** complaint
- **Magnitude:** O-inclusive 2 (2.7% of MX) [limited evidence]
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `13005363984`, `13193031233`
- **Canonical:** — (nuance register)

### R09-098 — The US is the value-scrutiny market: reviewers name dollar amounts and do the value calculation out loud ('$17 a month or $60 a year' for 'literally nothing more than a to do list'); both trial-trap cases are US; and it produced the corpus's most detailed review — a full UX audit (navigation, 'Get Rid of Cellulite' filed next to 'Abusive Relationships', shallow ADHD content, undocumented free/paid split, ToS trial disclaimer, sign-up review prompt) that the product team should read in full

- **Where:** §5.1 US — United States (n=59) — the value-scrutiny market table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** US 59 (4.61%), mean 3.75, money 35.6%; Theme | n | % of US | Label ; `PAID` | 9 | 15.3% | HIGH ; `G-thin` | 8 | 13.6% | HIGH ; `M-price` | 7 | 11.9% | HIGH ; `M-wall` / `P-org` / `P-outcome` | 6 each | 10.2% each | HIGH ; `M-refund` | 5 | 8.5% | HIGH ; `P-free` | 4 | 6.8% | HIGH ; `P-easy` / `M-regret` / `M-notrial` / `U-conf` / `ADHD` | 3 each | 5.1% each | Very strong ; `M-trialtrap` / `X-anxiety` / `O-forcedrate` / `M-nag` / `B-notifspam` | 2 each | 3.4% each | Meaningful
- **Direction for us:** none · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `13316643309`, `12209118679`, `11583765638`, `13966657008`, `11552283550`, `13245012766`, `13021325704`
- **Canonical:** — (nuance register)

### R09-099 — France is the worst eligible market because three problems compound — the Nov–Dec 2024 onboarding freeze ('je continue à tergiverser' screen), the highest paid-routine gating ('the proposed routines are all paid'), and billing incidents — plus the only consumer-rights framing (droit de rétractation); when it lands, praise is strong ('I've been looking for one like this for 40 years')

- **Where:** §5.1 FR — France (n=50) — the worst-performing eligible market table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** FR 50 (3.90%), mean 2.64, 42.0% 1★, money 48.0% (highest); Theme | n | % of FR | Label ; `PAID` | 10 | 20.0% | HIGH ; `M-wall` | 7 | 14.0% | HIGH ; `M-refund` / `M-gated` | 5 each | 10.0% each | HIGH ; `P-outcome` / `M-price` / `M-nag` / `B-onboard` / `M-notrial` / `O-mislead` / `G-thin` | 4 each | 8.0% each | HIGH ; `M-regret` / `G-content` / `G-freq` / `M-overcharge` / `B-ui` / `U-conf` / `M-scam` | 3 each | 6.0% each | HIGH
- **Direction for us:** none · **Report confidence:** standalone (n ≥ 50) · **Generalisable:** app-specific
- **Review IDs:** `11965618346`, `11982010915`, `11986632519`, `11989133850`, `12620617170`, `12221358308`, `11777093103`, `12190059793`, `13065540266`, `12081200617`, `11854126799`, `12145044555`, `13099009549`
- **Canonical:** C145 Every promotional or onboarding modal must be dismissible on the smallest screen

### R09-100 — The high-spend group (US, JP, GB, DE, FR, CA, AU — external convention, not derived from the corpus) rates Dear Me half a star lower than everyone else, praises it less, and complains more about money and defects; distinctive themes are price, thin product, wall, no trial, nag, regret, confusion, misleading ads, one-time guidance

- **Where:** §5.2 High-spend markets (defined group) table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** | n | % of corpus | mean ★ | 1★ | 5★ | MONEY | BUG | PRAISE | PAID ; High-spend group (US+JP+GB+DE+FR+CA+AU) | 209 | 16.3% | 3.11 | 30.1% | 37.8% | 39.2% | 17.7% | 18.7% | 17.7% ; All other storefronts | 1,072 | 83.7% | 3.59 | 25.5% | 54.0% | 32.8% | 12.9% | 24.1% | 17.6%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-101 — Trial demand is loudest exactly where willingness to pay is highest, and Germany is the clearest recoverable loss: German negatives are almost entirely 'great concept, no trial, too many pop-ups' rather than 'bad product', and Germans write the corpus's longest constructive feature lists

- **Where:** §5.2 Three conclusions — trial demand loudest where willingness to pay is highest; the German market is the clearest case of a recoverable loss
- **This app does:** no trial; heavy upsell
- **User reaction:** blocked-conversion
- **Magnitude:** M-notrial high-spend 7.2% vs 4.06% global; DE n=37 [limited evidence] mean 2.76: M-notrial 6, M-nag 6, G-guide 4, G-noedit 4
- **Direction for us:** do · **Report confidence:** limited evidence (DE) · **Generalisable:** yes
- **Review IDs:** `11854298993`, `12291766651`, `12683497729`, `12190313843`, `12311267967`, `12636034921`, `12464161947`, `12699837651`, `12364035523`
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay

### R09-102 — The high-volume group carries the corpus but splits almost perfectly by outcome — BR + MX (178 reviews, mean 4.05) vs RU + FR (163 reviews, mean 2.46) — and the difference is defect load and funnel tolerance, not language or price (review volume is not a downloads or revenue proxy)

- **Where:** §5.3 High-review-volume storefronts (defined group) table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** | n | % of corpus | mean ★ | MONEY | BUG | PRAISE | PAID ; High-volume group | 871 | 68.0% | 3.55 | 35.8% | 14.2% | 23.4% | 20.4% ; All other storefronts | 410 | 32.0% | 3.42 | — | — | — | 11.7% ; carries 88 of 102 refunds, 79 of 123 price, 60 of 66 loading, 178 of 226 paid
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-103 — Sub-50 notes [limited evidence]: IL ₪200 and Hebrew quality; SA the alarm market with a storefront-dependent trial; ES an outsized won't-open cluster (5 of 26); JP all IME defects; CL highest scam rate; CO highest-rated with no defects; IN pays ₹649 then stuck loading; ID the best feature-request review; CH 1.25 ('A trap!'); BY all 1★; GB warmest ADHD testimonials plus streaks lost in a Jan 2026 update

- **Where:** §5.4 Sub-50 storefronts — limited-evidence notes table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** CC | n | mean ★ | Distinctive pattern (limited evidence) ; IL | 46 | 3.41 | `G-thin` 7, `M-price` 5, `M-refund` 5. Two Hebrew-quality complaints (`11890679534`, `12513379051`). Israeli reviewers name ₪200 as the pain point (`11690398268`, `12479597871`) ; SA | 46 | 3.89 | The notification/alarm market: `B-notif` 4, `G-sound` 3. `11836191831`·SA·3 gives a five-point audit of the alarm system and reveals the storefront-dependent trial. `M-notrial` 5 ; DE | 37 | 2.76 | Trial + pop-ups + editability. Highest quality of constructive feedback per review in the corpus ; ES | 26 | 3.19 | `B-open` 5 of 26 (19.2%) — Spain has an outsized "app won't open" cluster (`12400853104`, `12566381104`, `13028589549`, `13468042404`, `12289082436`) ; JP | 25 | 2.80 | All 7 `B-ime` reviews. Japanese custom-habit text entry was broken in Aug 2024. Also `G-l10n` 3, `O-agegate` 1 ; CL | 24 | 3.42 | `M-refund` 4, `M-scam` 3 — Chile has the corpus's highest scam-accusation rate per review ; CA | 20 | 3.40 | `U-conf` 3, `X-anxiety` 2, `M-wall` 2 — "I went through the whole process and then it told me to subscribe" ; CO | 20 | 4.10 | Highest-rated storefront with n≥20. `P-org` 6, no defect reports at all ; IN | 19 | 2.63 | `O-long` 3 (survey fatigue), `PAID` 6 — Indian reviewers pay ₹649 and then report the app stuck on the loading screen (`12959504851`, `12960927081`) ; ID | 8 | 4.38 | `11668735422`·ID·3 is the corpus's single best feature-request review: widgets, sub-daily repetition, percentage completion, and a skip/holiday option, written by an annual subscriber ; KZ | 8 | 3.50 | `12272862926`·KZ·3 documents habit duplication plus a missing support channel ; CH | 4 | 1.25 | Lowest mean of any storefront with n≥4. `11825830145`·CH·1: *"Eine Falle!"* ; BY | 3 | 1.00 | All three one-star; same loading/onboarding/paywall complaints as RU ; GB | 8 | 3.50 | Contains both the corpus's warmest ADHD testimonials (`13546243872`, `13550392481`, `13572792664`) and `13580713380`·GB·1, who reports per-habit streaks disappearing in a Jan 2026 update ; Zero-review-defect markets | EG 4, LY 4, VE 4, KW 3, GT 2, PA 2 all mean 5.00 |  | Small, uniformly positive Arabic- and Spanish-language storefronts
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `11890679534`, `12513379051`, `11690398268`, `12479597871`, `11836191831`, `12400853104`, `12566381104`, `13028589549`, `13468042404`, `12289082436`, `12959504851`, `12960927081`, `11668735422`, `12272862926`, `11825830145`, `13546243872`, `13550392481`, `13572792664`, `13580713380`
- **Canonical:** — (nuance register)

### R09-105 — What varies sharply: refund friction (TR, RU), loading failure (RU, ES, IN), onboarding-length intolerance (RU, IN), upsell intolerance (RU, DE, TR), trial demand (DE, SA, TR, RU), currency confusion (MX), text-input/RTL/translation defects (JP, IL, RU)

- **Where:** §5.6 What varies sharply by country table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Dimension | Concentrated in | Rare in ; Refund/cancellation friction | TR (59+27), RU (15) | BR (4), MX (0 cancel) ; Loading/reliability failure | RU (52 of 66), ES, IN | TR (7), MX (0) ; Onboarding-length intolerance | RU (15 of 35), IN (3) | BR (1), MX (1) ; Upsell-pressure intolerance | RU (26 of 59), DE (6), TR (11) | BR (1), MX (0) ; Trial demand | DE, SA (5 each), TR (13), RU (9) | BR (0), MX (0) ; Currency confusion | MX (4 of 19) | — ; Text-input / RTL / translation defects | JP (10), IL (3), RU (3) | —
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-134 — Fix the four localizations reviewers say are machine-translated: JA, HE (including RTL), RU, AR — two reviewers subscribed for a year before discovering the problem

- **Where:** Part 7 §7.3 #8 Fix the four localizations reviewers say are machine-translated
- **This app does:** machine translation
- **User reaction:** 1★-burst
- **Magnitude:** 14 G-l10n, mean 1.79
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-067
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R09-031 — A November 2024 onboarding freeze locked users out of the app entirely: a procrastination question whose 'continue' control was off-screen and unscrollable ('the picture of the woman and the wardrobe'; one on an iPhone 6; an update did not fix it) — detectable within days from written reviews, invisible in the star rating

- **Where:** EXECUTIVE SUMMARY two dated regressions; §0.7 B-onboard Nov 2024 spike; §6.3 Trend 2 (a) The Nov 2024 onboarding freeze
- **This app does:** unscrollable onboarding screen on small devices
- **User reaction:** 1★-burst
- **Magnitude:** B-onboard 21 (1.64%), mean 1.52; 10 in Nov 2024 alone (DE 4, FR 4, also CH, IT, BR, TR); 9 in 2025, 1 in 2026; 2.37% → 1.40% → 0.57%
- **Direction for us:** must-never-break · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `11953340146`, `11987084380`, `11982010915`, `11965618346`, `11986632519`, `11989133850`
- **Canonical:** C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C031 Crashes / launch failures

### R09-107 — Theme rates by period and by half-year: defects doubled, loading rose 24×, money flat, refunds / guarantee / trial trap / thin product / onboarding freeze improved

- **Where:** §6.2 Trend 1 theme-by-period and half-year tables (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | P1 2024 | P2 2025 | P3 2026 | Direction ; `BUG-any` | 10.56% | 13.57% | 22.16% | Worsening, doubled ; `B-load` | 0.65% | 5.46% | 15.91% | Worsening, 24× ; `B-open` | 0.43% | 3.59% | 5.11% | Worsening ; `B-check` | 0.65% | 0.62% | 2.84% | Worsening ; `MONEY-any` | 31.47% | 36.35% | 31.25% | Flat ; `M-refund` | 9.70% | 7.80% | 3.98% | Improving ; `M-guarantee` | 2.80% | 0.62% | 0.00% | Resolved ; `M-trialtrap` | 1.51% | 0.47% | 0.00% | Resolved ; `G-thin` | 8.84% | 8.27% | 2.84% | Improving ; `B-onboard` | 2.37% | 1.40% | 0.57% | Improving || Half | n | mean ★ | 1★ share | `B-load` | `BUG-any` ; 2024 H1 | 45 | 4.31 | 13.3% | 0.0% | 0.0% ; 2024 H2 | 419 | 3.49 | 27.4% | 0.7% | 11.7% ; 2025 H1 | 435 | 3.56 | 24.4% | 1.8% | 11.3% ; 2025 H2 | 206 | 3.15 | 34.5% | 13.1% | 18.4% ; 2026 H1 | 134 | 3.63 | 20.1% | 17.2% | 23.1% ; 2026 H2 | 42 | 3.69 | 26.2% | 11.9% | 19.0%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-108 — Reliability replaced monetization as the growth complaint — loading failures began in 2025 H2 and peaked in 2026 H1 — but the 2026 rating recovery happens despite it because it is one storefront's crisis (Russia), not a global regression; the 'quicker loading' release shipped one day before the corpus ends, so its effect is unmeasured

- **Where:** §6.2 Trend 1 — Reliability replaced monetization as the growth complaint
- **This app does:** backend degradation from mid-2025
- **User reaction:** 1★-burst
- **Magnitude:** BUG-any 10.56% → 13.57% → 22.16%; B-load 0.65% → 5.46% → 15.91% (24×); 2025 H2 13.1%, 2026 H1 17.2%, 2026 H2 11.9%; MONEY-any 31.47% → 36.35% → 31.25%
- **Direction for us:** must-never-break · **Report confidence:** observed · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C132 Do not sell in a storefront where the app cannot function

### R09-109 — An April 2025 change broke chronological task sorting across four countries in the same week — tasks started appearing alphabetically or randomly; an annual subscriber says it persisted ~6 weeks with no support reply; one recurrence in Apr 2026 — a cross-market regression reviewers detected within days that the star rating never showed

- **Where:** §6.3 Trend 2 (b) The Apr 2025 sort-order regression
- **This app does:** sort order regressed Apr 2025
- **User reaction:** complaint
- **Magnitude:** B-order 5 (0.39%), mean 2.00; 4 in Apr 2025 (IN, DE, TR, MX); 1 in Apr 2026
- **Direction for us:** must-never-break · **Report confidence:** weak, dated · **Generalisable:** yes
- **Review IDs:** `12548475613`, `12571528769`, `12571797731`, `12577110521`, `13915239677`
- **Canonical:** C119 Updates must not regress layout or lose progress

### R09-112 — New-Year seasonality is large but it is volume, not sentiment — measure any funnel change against a January baseline, and treat a January release as the highest-exposure moment of the year

- **Where:** §6.7 Trend 6 — Seasonality
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Jan–Feb 2025 = 239 reviews (18.7% of corpus in two months); peak Feb 2025 131; Jan 2026 47 vs ~20/month; 2025 Q1 mean 3.59 vs corpus 3.51
- **Direction for us:** do · **Report confidence:** observed · **Generalisable:** yes
- **Canonical:** C146 Harden onboarding before January

## Positioning

### R09-001 — Dear Me — Daily Routine Tracker (App Store ID 6475956795) is a Turkish routine/habit planner built around pre-made routine templates in an illustrated, beaver-mascot, emotionally warm shell, sold as 'Self Care & ADHD Habit Planner' behind a hard 'Plus Membership' paywall; 1,281 written reviews at mean 3.509, bimodal

- **Where:** header lines 1-8
- **This app does:** developer Fitself Dijital Hizmetler Anonim Şirketi (Türkiye); bundle com.kompanion.habit.ios; Health & Fitness; 4+; first release 27 Jun 2024; v1.1.46 3 Sep 2026; listing Free with Plus IAPs $6.99 / $16.99 / $27.99 / $39.99 / $79.99; store rank 9 in this set
- **User reaction:** mixed
- **Magnitude:** 1,281 reviews, 62 storefronts, 14 May 2024 → 4 Sep 2026; 5★ 658 (51.37%) · 4★ 96 (7.49%) · 3★ 103 (8.04%) · 2★ 88 (6.87%) · 1★ 336 (26.23%); public 4.86 on ~40,555 ratings across 8 storefronts
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-046 — The free tier is better than its reputation — a positioning failure, not a product failure: users correct each other in public ('you don't lose much'; 'the subscription just gives a little bit more but not much of a difference'), while 75 others say you cannot do anything without paying — the pop-up density is what teaches users the app is locked; market the free tier

- **Where:** §1.4 The free tier is better than its reputation, and 28 reviewers say so; Part 7 §7.4
- **This app does:** usable free tier hidden by upsell density
- **User reaction:** mixed
- **Magnitude:** P-free 28 (2.19%, MEANINGFUL), mean 4.39 vs M-wall 75 (5.85%), 1.69
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12174607035`, `13326456954`, `12294500887`, `11525075222`, `11372377257`, `11487094036`, `12044126085`, `12548474349`, `13611780246`, `13839168780`, `13951718803`, `14103224443`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R09-066 — The churn thesis is a comparison to a free tool the reviewer already owns — iPhone Notes / Reminders, paper, a whiteboard, a spreadsheet, Trello, Google Calendar, ChatGPT: 'I would get a better personalized routine using ChatGPT for free. Just a pretty app with basic content' (bought on an ad promising MBTI-personalised routines that do not exist)

- **Where:** §2.4 The 'I could do this in Notes' argument is the churn thesis, stated 20+ times
- **This app does:** checklist positioned as coach
- **User reaction:** churn
- **Magnitude:** 20+ reviews across every major market
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11356752221`, `12345630714`, `12304025485`, `12177449575`, `12373899765`, `12919946354`, `11629249062`, `11832344919`, `11488999833`, `12294753083`, `12663050322`, `12755295856`, `12680748423`
- **Canonical:** C005 Know which competitors buyers compare against; C148 The paid product must deliver what the ads and onboarding demonstrate

### R09-068 — Good localization is a named reason to choose the app: 'I tried another app, it didn't have Turkish' — all five localization-praise reviews are Turkish (one Turkish 1★ says better-localised Turkish alternatives exist)

- **Where:** §2.5 P-l10n — what good localization buys; §5.1-TR
- **This app does:** native Turkish
- **User reaction:** praise
- **Magnitude:** P-l10n 5, all TR
- **Direction for us:** do · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11647652906`, `12024330293`, `12207555969`, `12253673918`, `13167235553`
- **Canonical:** C027 Localise early — it unlocks revenue

### R09-095 — Users compare Dear Me to Me+ Daily Planner (report 4) — one prefers Me+ but keeps Dear Me as a second option 'because it has more free things'

- **Where:** §5.1 BR — X-copycat compare Dear Me to Me+ Daily Planner
- **This app does:** similar routine planner
- **User reaction:** mixed
- **Magnitude:** X-copycat 2 (both BR)
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11423187788`, `12153938882`
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R09-012 — An advertised '3-month unconditional money-back guarantee' in the purchase flow was not honoured — 'Below it said you have a satisfaction guarantee… The company does not keep to it. Repeated contact with customer service changes nothing'

- **Where:** §0.3 advertised money-back guarantee that was not honoured; §1.2
- **This app does:** guarantee shown in purchase flow, refunds refused
- **User reaction:** 1★-burst
- **Magnitude:** M-guarantee 17 (1.33%), mean 1.41; all Jul 2024 – Feb 2025; 15 of 17 paid
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11443158584`, `11511771422`, `11547216103`, `11651186782`, `11789743896`, `11801485653`, `11804618993`, `11818368934`, `11844359918`, `11895224084`, `11912344269`, `12017205465`, `12121079900`, `12178773869`, `12183108635`, `12317099799`, `12334700954`
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised

### R09-021 — 'It's just a checklist' is the #1 product criticism and the worst-rated major theme — the app markets a coach and ships a checklist, and nearly half of those saying so paid; it is not cultural, it appears at the same rate in every market

- **Where:** §0.5 'It's just a checklist' is the #1 product criticism, and it has a specific cause; §5.5
- **This app does:** routine checklist sold as coaching
- **User reaction:** 1★-burst
- **Magnitude:** G-thin 99 (7.73%, HIGH-PRIORITY), mean 1.45 (lowest with n>20), 74 are 1★; 47 paid (20.8% of paid cohort); 1★ band 74 (22.0%), 2★ band 15 (17.0%); TR 7.9%, US 13.6%, BR 6.7%, RU 7.1%, MX 6.8%, FR 8.0%; high-spend 9.6%; 8.84% (2024) → 8.27% → 2.84% (2026)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12209118679`, `11552361877`, `12400544803`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate; C114 Ads must match the app

### R09-023 — Advertised features are not in the app: the acquisition creative and onboarding demo promise an interactive coach and the product delivers a checklist — the gap is the churn

- **Where:** §0.5 O-mislead — the acquisition creative and the onboarding demo promise an interactive coach
- **This app does:** ads show guided/interactive features
- **User reaction:** 1★-burst
- **Magnitude:** O-mislead 20 (1.56%, MEANINGFUL), mean 1.40; 12 of 20 paid; 0.22% (2024) → 2.34% → 2.27%; high-spend 4.3%
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12645661722`, `12754744101`, `12755295856`
- **Canonical:** C114 Ads must match the app; C148 The paid product must deliver what the ads and onboarding demonstrate

### R09-026 — The 'personalised plan' is not personalised: 'They say your personalised plan is ready and push you to pay. Don't pay — there is no plan'; 'Fake calculations to waste time and pretend there's personalization'; 'Why did I take the test at the start if the approach is the same for everyone?'

- **Where:** §0.6 O-notpersonal — the 'personalised plan' is not personalised
- **This app does:** quiz output = generic presets
- **User reaction:** 1★-burst
- **Magnitude:** O-notpersonal 11 (0.86%, EMERGING), mean 1.55
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `11472460295`, `11717508221`, `13521538789`, `12587805273`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate; C111 No long quiz before the price; show the price up front

### R09-110 — The funnel is being tuned harder while the product improves — upsell complaints quintupled, onboarding-length and ad-mismatch complaints rose, while refunds and 'just a checklist' fell — so upsell pressure is now the fastest-growing source of one-star reviews: 'an excellent example of how to show tons of different paywall pages to users and don't let them use the app'

- **Where:** §6.5 Trend 4 — Upsell pressure is the one complaint getting monotonically worse table (verbatim)
- **This app does:** more paywall screens over time
- **User reaction:** 1★-burst
- **Magnitude:** Theme | P1 | P2 | P3 ; `M-nag` repeated upsell | 2.16% | 4.84% | 10.23% ; `O-long` onboarding length | 1.51% | 3.12% | 4.55% ; `O-mislead` ad/product mismatch | 0.22% | 2.34% | 2.27% ; `M-scam` fraud accusation | 1.51% | 2.96% | 2.27%
- **Direction for us:** dont · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `13808808716`, `13810012694`, `13813415532`, `13917372875`, `14276958495`, `14413735582`, `14451743287`, `14497068096`, `14503775552`, `13753570537`, `14139653785`, `13776099933`, `13675689954`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

## Things not to do

### R09-010 — Upsell pressure is getting worse and reviewers count the pop-ups: 'already asked 6× after downloading'; 'attacked 10 times in 10 minutes'; 'In 1 minute they offered it 3 times'; 'showed me banner about paid subscription 4 times during my first app opening' — and an ADHD user: 'if they irritated me this much, what is that if not a provocation for people with ADHD?'

- **Where:** §0.2 Upsell pressure is getting worse, not better; §6.5; Part 7 §7.2 Part B
- **This app does:** 'Newcomer discount' / −50% interstitial on nearly every open
- **User reaction:** 1★-burst
- **Magnitude:** M-nag 59 (4.61%, VERY STRONG), mean 1.80; 2.16% (2024) → 4.84% (2025) → 10.23% (2026); RU 26 of 59 (23.0% of RU); high-spend 6.7%; 1★ band 35 (10.4%)
- **Direction for us:** dont · **Report confidence:** very strong, rising · **Generalisable:** yes
- **Review IDs:** `12311292481`, `12373899765`, `12919946354`, `12650117268`, `13917372875`, `13860369435`, `12360368631`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R09-025 — The mandatory onboarding quiz is too long and reviewers time it: 'you need to spend at least 10 minutes on the creators' quest'; 'a wild and useless half-hour onboarding'; 'I tried answering them for 5 minutes and couldn't reach the sign in page'

- **Where:** §0.6 O-long — the quiz/intro is too long; Part 7 #3 (§7.5 experiment 3)
- **This app does:** unskippable personal quiz before sign-in and paywall
- **User reaction:** 1★-burst
- **Magnitude:** O-long 35 (2.73%, MEANINGFUL), mean 1.31 (second-lowest with n>20); RU 15 of 35 (13.3% of RU); IN 3; 1.51% (2024) → 3.12% → 4.55% (2026); 1★ band 28
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12572307741`, `13601275869`, `14276958495`, `12863200655`
- **Canonical:** C111 No long quiz before the price; show the price up front

### R09-044 — A '−50% Newcomer discount' timer fires on nearly every open for non-subscribers, drives impulse purchases, and in one case completed an Apple Pay annual purchase while the user was trying to dismiss it for the nth time — users ask for 'Do Not Show Again'

- **Where:** §1.2 A 'Newcomer discount' / '-50%' screen fires on nearly every open; §4.3 trigger 3
- **This app does:** recurring discount interstitial
- **User reaction:** 1★-burst
- **Magnitude:** 59 M-nag reviews; 3 named discount-timer purchases
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12360368631`, `12755295856`, `12966178467`, `12650182347`, `11777093103`
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C093 No upsell nagging without a 'never ask again' option

### R09-070 — Asked to rate the app before using it, as a step inside sign-up — 'I'm having to write a review before actually using app??'; 'first they ask you for 5 stars, then for money, and only then do you get to see the app'; 'mid-onboarding the devs beg for a review of an app I haven't even seen. Incidentally Apple forbids this' — an App Store guideline exposure that inflates the public rating

- **Where:** §2.6 13 reviews report being asked to rate the app before using it; §5.6; Part 7 §7.1 #2
- **This app does:** rating prompt inside onboarding
- **User reaction:** mixed
- **Magnitude:** O-forcedrate 13 (1.01%, MEANINGFUL), mean 2.54; public/written gap +1.35
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11894722198`, `12278140415`, `12137044359`, `13021325704`, `13441600880`, `14276958495`, `11549287863`, `11936103176`, `12009795310`, `12018437724`, `12783290291`, `13175470414`, `13604430494`
- **Canonical:** C150 Never ask for a rating before the user has used the app; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R09-116 — Remove the rating prompt from the sign-up flow — removes an App Store Review Guideline exposure and restores the rating as a usable metric

- **Where:** Part 7 §7.1 #2 Remove the rating prompt from the sign-up flow
- **This app does:** prompt inside onboarding
- **User reaction:** mixed
- **Magnitude:** 13 asked before use; 9 mismatches; +1.35 gap
- **Direction for us:** dont · **Report confidence:** immediate · **Generalisable:** yes
- **Conditions:** evidence: R09-070, R09-071
- **Canonical:** C150 Never ask for a rating before the user has used the app

### R09-124 — Cap the upsell at one interstitial per session and add 'don't show again'

- **Where:** §7.2 Part B — Cap the upsell at one interstitial per session, and add 'don't show again'
- **This app does:** interstitial on nearly every open
- **User reaction:** 1★-burst
- **Magnitude:** M-nag 2.16% → 4.84% → 10.23%
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** yes
- **Conditions:** evidence: R09-010, R09-110
- **Review IDs:** `12360368631`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

## Things to do

### R09-005 — The prioritised ask: fix Russia's backend; remove the rating prompt from sign-up; build a real support and refund path (damage control) — then ship a genuine trial in every storefront, cap the upsell at one interstitial per session, and make the breathing exercise re-runnable (the growth thesis)

- **Where:** EXECUTIVE SUMMARY The prioritised ask
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none beyond the sections cited
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R09-141 — Experiment: a post-purchase 'here's what you just unlocked' flow — because four of five purchase triggers are pre-experience, it should reduce regret and refund requests

- **Where:** Part 7 #5 (§7.5 experiment 5) Post-purchase onboarding
- **This app does:** no post-purchase onboarding
- **User reaction:** churn
- **Magnitude:** M-regret 50
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Conditions:** evidence: R09-085
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate

## Contradictions

### R09-020 — The ADHD paradox: the subtitle sells ADHD support and 16 of 17 ADHD mentions are positive, but the most detailed ADHD review says the ADHD content is one generic routine, 'totally oblivious to what it's like for someone with ADHD to actually create habits' — and the constant paywall banners are themselves 'a provocation for people with ADHD'

- **Where:** §0.4 Note the ADHD paradox
- **This app does:** 'ADHD Habit Planner' subtitle; one generic ADHD routine; heavy upsell
- **User reaction:** mixed
- **Magnitude:** 16 of 17 positive vs the most detailed review at 2★
- **Direction for us:** research · **Report confidence:** qualitative · **Generalisable:** yes
- **Conditions:** warm tone satisfies ADHD users; marketing to ADHD without ADHD-specific content invites the sharpest critics
- **Review IDs:** `13021325704`, `13860369435`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C093 No upsell nagging without a 'never ask again' option

### R09-040 — Nobody asks for data export — zero reviews across 62 storefronts — against reports 1 and 3 where export was a repeated request from happy users

- **Where:** §1.1 CSV export (0 reviews — nobody asks); §5.5 Nobody asks for data export
- **This app does:** no export
- **User reaction:** none
- **Magnitude:** 0 of 1,281
- **Direction for us:** none · **Report confidence:** absence · **Generalisable:** unknown
- **Conditions:** a template-driven daily routine app with little accumulated personal data, versus long-history trackers
- **Canonical:** C020 Data export / backup / CSV

## Data caveats and method

### R09-002 — Method: denominator 1,281, non-exclusive themes; six storefronts clear 50 — TR 471, RU 113, BR 104, MX 74, US 59, FR 50 (871, 68.0%), the other 56 (410) are [limited evidence]; every review read in its original language (TR, RU, PT, ES, FR, DE, HE, AR, JA, IT, ID, NL); fully manual classification into 101 codes (ambiguous boundaries M-price/M-wall, G-thin/G-guide, M-refund/M-cancel double-assigned); PAID is a floor (explicit text only); 339 short reviews deliberately unclassified but kept in denominators; safety findings (X-safety, G-a11y) promoted above their band; storefront skew — TR is 36.77% of the corpus and RU contributes 78.8% of loading complaints; no version, cohort or telemetry data; external data snapshot 9 Sep 2026

- **Where:** How to read this; Part 8 method (skimmed)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 1,281 records, reconciles with 62 by_country files and manifest; 0 duplicate IDs; one duplicate title+body kept; bands <0.1% ignore … >5% high-priority
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R09-006 — The corpus is bimodal — 51.37% 5★ alongside 26.23% 1★, only 22.40% in between — two nearly disjoint populations: a large low-information positive mass (318 of the 339 unclassified reviews are 5★ one-to-four-word praise like 'Çok güzel', 'Muito bom', emoji) next to a large, highly articulate negative mass; only one of them tells you what to build

- **Where:** §0.1 The shape of this corpus is unusual and it matters table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Population | n | % of corpus | mean ★ | What they write about ; Reviews carrying at least one praise theme | 297 | 23.19% | 4.78 | Organization, life outcomes, motivation, design ; Reviews carrying at least one money theme | 434 | 33.88% | 2.13 | Paywall, refunds, no trial, upsell pressure ; Reviews carrying at least one defect theme | 175 | 13.66% | 2.01 | Loading, crashes, onboarding freeze, login ; Reviews carrying at least one capability-gap theme | 244 | 19.05% | 2.46 | Thin content, can't edit/delete, frequency limits ; Reviews with no classified theme (short pure praise or noise) | 339 | 26.46% | — | "Çok güzel", "Muito bom", emoji-only
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-007 — Money supergroup broken into sixteen themes (price, refund, wall, nag, no trial, regret, cancel, gated, scam, unclear, late reveal, guarantee, overcharge, payfail, trial trap, one-time)

- **Where:** §0.2 The paywall is the product's defining decision money-theme table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Money theme | n | % | Label | mean ★ ; `M-price` price too high / wish it were free | 123 | 9.60% | HIGH-PRIORITY | 2.70 ; `M-refund` refund requested or not received | 102 | 7.96% | HIGH-PRIORITY | 1.73 ; `M-wall` cannot use the app meaningfully without paying | 75 | 5.85% | HIGH-PRIORITY | 1.69 ; `M-nag` repeated upsell pop-ups / discount timers | 59 | 4.61% | Very strong | 1.80 ; `M-notrial` explicitly asks for a free trial | 52 | 4.06% | Very strong | 1.83 ; `M-regret` paid, then regretted it | 50 | 3.90% | Very strong | 1.56 ; `M-cancel` cancellation blocked or unclear | 34 | 2.65% | Meaningful | 2.03 ; `M-gated` a specific named feature is locked | 31 | 2.42% | Meaningful | 2.90 ; `M-scam` explicit fraud / theft accusation | 30 | 2.34% | Meaningful | 1.20 ; `M-unclear` price, currency or plan not understood | 19 | 1.48% | Meaningful | 2.84 ; `M-latereveal` price only revealed after the full quiz | 18 | 1.41% | Meaningful | 1.39 ; `M-guarantee` money-back guarantee not honoured | 17 | 1.33% | Meaningful | 1.41 ; `M-overcharge` charged a different or double amount | 16 | 1.25% | Meaningful | 1.50 ; `M-payfail` paid but subscription never activated | 16 | 1.25% | Meaningful | 1.81 ; `M-trialtrap` charged despite cancelling in the trial | 10 | 0.78% | Emerging | 1.80 ; `M-onetime` wants a one-time purchase option | 1 | 0.08% | Ignore | 3.00
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-017 — Praise themes: organises my day, life change, easy, design, motivating, free tier usable, ADHD/mental health, reminders, presets, tests

- **Where:** §0.4 What people actually love praise table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Praise theme | n | % | Label | mean ★ ; `P-org` "it organises my day / my routine" | 106 | 8.27% | HIGH-PRIORITY | 4.92 ; `P-outcome` a stated life change or result | 101 | 7.88% | HIGH-PRIORITY | 4.92 ; `P-easy` easy / intuitive | 33 | 2.58% | Meaningful | 4.73 ; `P-design` design, colour, animation | 33 | 2.58% | Meaningful | 4.45 ; `P-motiv` motivating, fun, encouraging | 32 | 2.50% | Meaningful | 5.00 ; `P-free` the free tier is genuinely usable | 28 | 2.19% | Meaningful | 4.39 ; `P-adhd` helped with ADHD / anxiety / mental health | 16 | 1.25% | Meaningful | 5.00 ; `P-remind` reminders work and land on time | 14 | 1.09% | Meaningful | 4.86 ; `P-presets` the ready-made routines are valuable | 13 | 1.01% | Meaningful | 4.62 ; `P-tests` the quizzes/tests are valuable | 10 | 0.78% | Emerging | 4.80
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-024 — Onboarding/marketing funnel themes: too long, misleading, ad-driven, forced rating, not personal, privacy, age gate, gender, inclusive language, signature step

- **Where:** §0.6 The onboarding funnel is long, personal, and — reviewers say — fake table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** onboarding criticism 98 (7.65%, HIGH-PRIORITY), mean 1.93; Onboarding theme | n | % | Label | mean ★ ; `O-long` the quiz/intro is too long to get through | 35 | 2.73% | Meaningful | 1.31 ; `O-mislead` advertised features are not in the app | 20 | 1.56% | Meaningful | 1.40 ; `O-ads` heavy social-ad-driven acquisition (both praise and complaint) | 18 | 1.41% | Meaningful | 2.78 ; `O-forcedrate` asked to rate the app before using it | 13 | 1.01% | Meaningful | 2.54 ; `O-notpersonal` the "personalised plan" is not personalised | 11 | 0.86% | Emerging | 1.55 ; `O-privacy` personal-data / permissions concern | 6 | 0.47% | Weak | 1.50 ; `O-agegate` age brackets stop at 50/59 | 5 | 0.39% | Weak | 2.60 ; `O-gender` content is written for women only | 5 | 0.39% | Weak | 2.00 ; `O-inclusive` objection to inclusive Spanish ("todes") | 2 | 0.16% | Weak | 2.00 ; `O-signature` handwritten-signature/commitment step | 1 | 0.08% | Ignore | 1.00
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-029 — Twenty defect themes with concentration by country and date

- **Where:** §0.7 Reliability: one country carries almost the whole problem defect table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** defect themes 175 (13.66%), mean 2.01; Defect theme | n | % | Label | mean ★ | Concentration ; `B-load` app loads for minutes / hangs | 66 | 5.15% | HIGH-PRIORITY | 2.12 | RU 52 of 66 ; `B-open` app won't open / white screen / crash | 34 | 2.65% | Meaningful | 1.76 | RU 17, ES 5 ; `B-onboard` frozen inside the onboarding quiz | 21 | 1.64% | Meaningful | 1.52 | DE 4, FR 4, Nov 2024 spike ; `B-create` cannot save a new habit | 16 | 1.25% | Meaningful | 2.12 | RU 6 ; `B-login` logged out / cannot sign back in | 15 | 1.17% | Meaningful | 1.87 | RU 6, TR 5 ; `B-notif` reminders never arrive | 12 | 0.94% | Emerging | 1.75 | SA 4, TR 4 ; `B-check` a completed task un-completes itself | 12 | 0.94% | Emerging | 2.75 | spread ; `B-notifspam` too many / mistimed notifications | 8 | 0.62% | Emerging | 2.50 | US 2, CA 1, AU 1 ; `B-ime` Japanese text input broken (kanji/dakuten) | 7 | 0.55% | Emerging | 1.86 | JP 7 of 7, Aug 2024 only ; `B-vpn` unusable in Russia without a VPN | 6 | 0.47% | Weak | 2.00 | RU 6 of 6 ; `B-order` tasks stopped sorting chronologically | 5 | 0.39% | Weak | 2.00 | Apr 2025 spike ; `B-widget` widget fails to load or renders blank | 5 | 0.39% | Weak | 3.00 | RU 5 of 5 ; `B-dataloss` routines/history disappeared | 5 | 0.39% | Weak | 1.60 | AU 2 ; `B-ui` text truncated / layout broken | 5 | 0.39% | Weak | 1.40 | FR 3 ; `B-cal` wrong weekday shown | 3 | 0.23% | Weak | 2.67 | — ; `B-sig` signature field does not accept input | 2 | 0.16% | Weak | 1.50 | RU 2 ; `B-discover` Discover tab errors out | 2 | 0.16% | Weak | 3.50 | Jan 2026 ; `B-tablet` iPad layout unusable | 2 | 0.16% | Weak | 1.00 | — ; `B-offline` requires a network connection to plan | 2 | 0.16% | Weak | 1.00 | — ; `B-rtl` Hebrew interface renders reversed | 1 | 0.08% | Ignore | 3.00 | IL
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-034 — Capability map with free/paid status as reviewers experience it: today checklist, custom habits, Discover templates, quiz, breathing demo, tests, journal, reminders, stickers, widgets, calendar, statistics, cycle tracking, AI coach Mimi, affirmations, beaver mascot

- **Where:** §1.1 What the product is, reconstructed from the corpus table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence it exists | Free / Paid as reviewers experience it ; Daily task/habit checklist ("today" view) | Universal across corpus | Free — this is what people mean by "just a checklist" ; Custom habit creation | `12468334420`·TR·5 ("10 tane falan ekleyebildim"), `12533297284`·TR·5, `13326456954`·CA·4 | Free, with an unclear cap; several say the cap is generous ; "Keşfet" / Discover — pre-made routine templates | `11525075222`·TR·5, `12174607035`·TR·5, `11682091018`·BR·5 | Paid. The single most-cited gated feature ; Onboarding quiz → "personalised plan" | 35 `O-long` + 11 `O-notpersonal` reviews | Free, mandatory, unskippable ; Guided breathing exercise (animated beaver) | 21 `G-guide` reviews | Onboarding only — reviewers cannot re-run it ; Self-assessment tests (ADHD, anxiety, depression, personality/MBTI, "signature scent") | `12456209277`·TR·5, `13602253288`·US·5, `12019754618`·PE·3, `13103495872`·TR·1 | Mixed; some free, some gated ; Journal / mood + emotion logging | `13002982148`·US·5, `12497412052`·MX·5, `13021325704`·US·2 | Mood selection free; writing text is paid (`13021325704`·US·2) ; Reminders / notifications | 14 `P-remind` vs 12 `B-notif` | Free ; Stickers / achievement badges | `12041303013`·ES·2, `13359843723`·IN·5, `13600520150`·RU·3 | Free ; Home-screen widgets | 11 `G-widget` reviews | Paid in at least SA and ID (`12451223326`·SA·1, `13276823733`·ID·3); reported as free in US (`13021325704`·US·2) — inconsistent ; Calendar / streak history view | `12847151988`·CA·4, `13580713380`·GB·1 | Free ; Statistics | 6 `G-stats` reviews | Free but thin — "just numbers with no detail" (`11823311515`·SA·2) ; Cycle/period tracking | `12523888830`·TR·4 | Present ; AI coach "Mimi" (2026 only) | `13810246956`·TR·4, `14302044695`·TR·4, `14507626498`·BR·1 | Free with a hard message cap; more messages are paid ; Daily affirmations | `13860369435`·EE·1 (cannot be turned off), `13624114897`·TR·5 | Free, not removable ; Beaver mascot | `11526412509`·MX·5 ("mascota castor"), `12284703983`·TR·5 ("kunduz"), `12148653483`·US·4, `13367660347`·US·5 | Free
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Review IDs:** `12468334420`, `12533297284`, `13326456954`, `11525075222`, `12174607035`, `11682091018`, `13002982148`, `12497412052`, `13021325704`, `12451223326`, `13276823733`, `12847151988`, `11823311515`, `12523888830`, `13810246956`, `14302044695`, `14507626498`, `13860369435`, `11526412509`
- **Canonical:** — (nuance register)

### R09-045 — Users cannot tell what Plus adds — currency, plan length and the paid feature list are unclear; a self-identified PM notes the premium page is one vague slogan and the profile membership page is blank; 'there is no info on what is actually included in the pro subscription'

- **Where:** §1.3 Free/paid/unclear classification table (verbatim); Part 7 §7.2 Part C
- **This app does:** no single free/paid comparison screen
- **User reaction:** complaint
- **Magnitude:** M-unclear 19 (1.48%, MEANINGFUL), mean 2.84; Classification | Features ; Free | Today view, manual habit creation, check-off, reminders, calendar/streak view, basic statistics, stickers, mood selection, affirmations, mascot, some tests ; Paid (Plus) | Discover/pre-made routine templates (most-cited), journal text entry, extra AI-coach messages, unlimited habits, widgets in some storefronts ; Onboarding-only (neither free nor paid — simply absent afterwards) | The guided breathing animation. 21 reviews. This is the single largest source of "false advertising" sentiment ; Unclear to users | 19 `M-unclear` reviews cannot determine currency, plan length, or what Plus actually adds. `12399224524`·KZ·3: *"какая разница в подписке и в бесплатной версии? Это совсем не объясняется"*. `11878902945`·TR·5 — a self-identified developer/PM — writes a structured critique saying the premium value proposition page is one vague slogan and the membership page in the profile is blank
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12399224524`, `11878902945`, `13021325704`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R09-047 — Whether a free-tier habit cap exists is unclear: some report adding 10+ habits free with no cap, others report immediate blocking

- **Where:** §1.1 Custom habit creation — unclear cap; Part 7 §7.6 research question on the free-tier habit cap
- **This app does:** unclear cap
- **User reaction:** mixed
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Review IDs:** `12468334420`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R09-048 — Eighteen negative themes ranked by volume

- **Where:** §2.1 Negative themes, ranked table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** # | Theme | n | % | Label | mean ★ | Direction ; 1 | `M-price` price objection | 123 | 9.60% | HIGH | 2.70 | Negative (but 31 are 5★) ; 2 | `M-refund` refund friction | 102 | 7.96% | HIGH | 1.73 | Negative ; 3 | `G-thin` "it's just a checklist" | 99 | 7.73% | HIGH | 1.45 | Negative ; 4 | `M-wall` hard paywall | 75 | 5.85% | HIGH | 1.69 | Negative ; 5 | `B-load` loading/hang failures | 66 | 5.15% | HIGH | 2.12 | Negative ; 6 | `M-nag` upsell pressure | 59 | 4.61% | Very strong | 1.80 | Negative ; 7 | `M-notrial` no free trial | 52 | 4.06% | Very strong | 1.83 | Negative + actionable ; 8 | `M-regret` post-purchase regret | 50 | 3.90% | Very strong | 1.56 | Negative ; 9 | `O-long` onboarding length | 35 | 2.73% | Meaningful | 1.31 | Negative ; 10 | `M-cancel` cancellation friction | 34 | 2.65% | Meaningful | 2.03 | Negative ; 11 | `B-open` app won't open | 34 | 2.65% | Meaningful | 1.76 | Negative ; 12 | `M-scam` fraud accusation | 30 | 2.34% | Meaningful | 1.20 | Negative ; 13 | `U-conf` cannot find/understand a feature | 27 | 2.11% | Meaningful | 2.63 | Negative ; 14 | `X-support` no support response | 25 | 1.95% | Meaningful | 1.52 | Negative ; 15 | `G-guide` guidance shown once, never again | 21 | 1.64% | Meaningful | 2.33 | Negative ; 16 | `B-onboard` frozen in onboarding | 21 | 1.64% | Meaningful | 1.52 | Negative ; 17 | `G-noedit` cannot rename/edit habits | 20 | 1.56% | Meaningful | 2.55 | Negative ; 18 | `O-mislead` ads promised more | 20 | 1.56% | Meaningful | 1.40 | Negative
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-049 — Twenty-four unmet-need themes with what is asked for

- **Where:** §2.2 Unmet-need themes (requests, not defects) table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % | Label | mean ★ | What is asked for ; `G-content` more/deeper routine content | 30 | 2.34% | Meaningful | 3.40 | More Discover templates; cleaning, study, sport, weekend, pets ; `G-freq` richer scheduling | 22 | 1.72% | Meaningful | 3.14 | Multiple times per day; "any 2 days of the week"; skip/vacation ; `G-noedit` edit preset habits | 20 | 1.56% | Meaningful | 2.55 | Rename a template habit ; `G-nodelete` delete a habit or routine | 15 | 1.17% | Meaningful | 3.13 | Remove something added by mistake ; `G-icons` more icons, emoji, colours | 14 | 1.09% | Meaningful | 3.57 | "only 6 colours"; "only 60 emoji" ; `G-l10n` translation quality | 14 | 1.09% | Meaningful | 1.79 | JP, HE, RU, PT, DE machine-translation errors ; `G-group` group/categorise routines | 13 | 1.01% | Meaningful | 2.69 | Separate cleaning / self-care / study ; `G-widget` widgets | 11 | 0.86% | Emerging | 3.18 | Home & lock screen ; `G-time` time ranges and durations | 10 | 0.78% | Emerging | 2.50 | Start/end times, not just a point ; `G-notes` real journaling/notes | 9 | 0.70% | Emerging | 3.11 | Free-text daily entry, photo of the day ; `G-sound` completion sound / alarm tone | 9 | 0.70% | Emerging | 2.33 | Audible alarm, not a silent push ; `G-dup` stop duplicating tasks | 8 | 0.62% | Emerging | 2.25 | Same habit appears 2–3× ; `G-order` manual reordering | 8 | 0.62% | Emerging | 2.38 | Drag to reorder the day ; `G-sub` sub-tasks / quantities / counters | 7 | 0.55% | Emerging | 3.29 | "8 of 10 glasses of water" ; `G-sync` iPad / Apple Watch / multi-device | 7 | 0.55% | Emerging | 3.00 | — ; `G-backfill` tick off a day you missed | 6 | 0.47% | Weak | 2.83 | — ; `G-future` plan further ahead than 3–4 days | 6 | 0.47% | Weak | 3.50 | — ; `G-stats` real analytics | 6 | 0.47% | Weak | 2.33 | Per-habit streaks and counts ; `G-calendar` Apple Calendar integration | 5 | 0.39% | Weak | 3.20 | — ; `G-todo` one-off tasks alongside habits | 5 | 0.39% | Weak | 3.00 | — ; `G-kids` a version for children | 4 | 0.31% | Weak | 2.75 | — ; `G-social` shared routines with friends | 3 | 0.23% | Weak | 3.33 | — ; `G-cal-start` week should start Monday | 2 | 0.16% | Weak | 3.50 | FR, FI ; `G-a11y` rapid animation is a seizure/vertigo risk | 1 | 0.08% | Ignore* | 1.00 | `13467908248`·AU·1 — *promoted despite volume as a safety concern*
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-065 — Heavy social-ad acquisition cuts both ways: 'the advertising helped me download it' vs 'fooled by their ads… I bought a one-year membership'

- **Where:** §2.3 Mixed themes — Advertising (O-ads)
- **This app does:** social/video ad-driven acquisition
- **User reaction:** mixed
- **Magnitude:** O-ads 18 (1.41%, MEANINGFUL), mean 2.78
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11442054312`, `12633273226`
- **Canonical:** C114 Ads must match the app

### R09-069 — The public rating averages 4.86 on ~40,555 ratings across eight storefronts while written reviews average 3.51 — a +1.35 weighted gap, largest in RU (+2.27), FR (+2.19) and DE (+2.03)

- **Where:** ⚠️ 2. The public star rating is ~1.35 stars higher; §2.6 The rating gap table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | Public ★ | Public ratings | Written reviews | Written ★ | Gap ; BR | 4.93 | 10,481 | 104 | 4.02 | +0.91 ; MX | 4.91 | 6,156 | 74 | 4.09 | +0.82 ; US | 4.87 | 4,926 | 59 | 3.75 | +1.13 ; GB | 4.84 | 413 | 8 | 3.50 | +1.34 ; FR | 4.83 | 2,514 | 50 | 2.64 | +2.19 ; TR | 4.81 | 13,302 | 471 | 3.71 | +1.10 ; DE | 4.79 | 1,160 | 37 | 2.76 | +2.03 ; RU | 4.65 | 1,603 | 113 | 2.38 | +2.27 ; Weighted across these 8 | 4.86 | 40,555 | 916 | 3.51 | +1.35
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-071 — Five-star ratings attached to entirely negative text — titled 'Not worth it', 'I was defrauded' ('I'm giving five stars so my review appears at the top'), 'Doesn't open' — so the public rating cannot be used as a satisfaction metric; treat the written mean and the 1★ share as the signal

- **Where:** §2.6 9 reviews (0.70%) are outright MISMATCH; Decision implication
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** MISMATCH 9 (0.70%)
- **Direction for us:** none · **Report confidence:** observed · **Generalisable:** yes
- **Review IDs:** `11466703747`, `13025036138`, `13681845921`, `11509007666`, `11718643683`, `11788006113`, `11900899478`, `13815975384`, `13928105308`
- **Canonical:** — (nuance register)

### R09-072 — The 5★ band is partly a rating-prompt artefact: 318 of 658 (48.3%) carry no theme; 'great, but I wish it were free' is a 5★ sentence (31); 25 happy subscribers exist; but 11 five-stars are refund requests and 9 are outright mismatches

- **Where:** Part 3 5★ — n = 658 (51.37% of corpus) table (verbatim); Caution
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** Theme | n | % of 5★ band | Reading ; `P-org` | 100 | 15.2% | "It organised my day" is the #1 reason for 5★ ; `P-outcome` | 94 | 14.3% | A stated life change ; `P-motiv` | 32 | 4.9% | Motivation/fun — 100% of this theme is 5★ ; `M-price` | 31 | 4.7% | "Great, but I wish it were free" is a 5★ sentence ; `P-easy` | 26 | 4.0% | ; `PAID` | 25 | 3.8% | Happy subscribers do exist — 25 of them ; `P-design` | 23 | 3.5% | ; `P-free` | 19 | 2.9% | Correctly identifies a usable free tier ; `P-adhd` | 16 | 2.4% | 100% of this theme is 5★ ; `M-refund` | 11 | 1.7% | Refund requests posted as 5★ reviews ; `MISMATCH` | 9 | 1.4% | Rating contradicts the text entirely ; 17 of 658 (2.6%) refund requests or mismatches
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-077 — 1★ themes and primary causes: money refund/cancel/overcharge ~36%, paywall/no trial/price/upsell ~28%, thin product ~22%, defects ~21%, funnel ~12% (non-exclusive)

- **Where:** Part 3 1★ — n = 336 (26.23%) — a quarter of the corpus theme and primary-cause tables (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of 1★ band | Global n ; `PAID` | 138 | 41.1% | 226 ; `G-thin` | 74 | 22.0% | 99 ; `M-refund` | 73 | 21.7% | 102 ; `M-price` | 52 | 15.5% | 123 ; `M-wall` | 50 | 14.9% | 75 ; `M-nag` | 35 | 10.4% | 59 ; `M-regret` | 32 | 9.5% | 50 ; `B-load` | 31 | 9.2% | 66 ; `M-notrial` | 30 | 8.9% | 52 ; `O-long` | 28 | 8.3% | 35 ; `M-scam` | 27 | 8.0% | 30 ; `B-open` | 23 | 6.8% | 34 ; `M-cancel` | 21 | 6.2% | 34 ; `X-support` | 19 | 5.7% | 25 ; `B-onboard` | 17 | 5.1% | 21 ; `O-mislead` | 15 | 4.5% | 20 || Primary 1★ cause | approx. n | Share of 1★ ; Money: refund/cancel/overcharge/guarantee/payment failure | ~120 | ~36% ; Money: paywall, no trial, price, upsell pressure | ~95 | ~28% ; Product: thin / just a checklist / not what the ad showed | ~75 | ~22% ; Defect: loading, crash, onboarding freeze, login, data loss | ~70 | ~21% ; Funnel: onboarding length, fake personalisation, forced rating | ~40 | ~12%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-080 — Paid-cohort complaint themes (segment rates, denominator 226): refund 43.8%, regret 22.1%, thin 20.8%, cancel 13.7%, loading 12.4%, support 9.3%, price 8.4%

- **Where:** §4.2 What paying customers actually complain about table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of paid cohort | Global n ; `M-refund` | 99 | 43.8% | 102 ; `M-regret` | 50 | 22.1% | 50 ; `G-thin` | 47 | 20.8% | 99 ; `M-cancel` | 31 | 13.7% | 34 ; `B-load` | 28 | 12.4% | 66 ; `X-support` | 21 | 9.3% | 25 ; `M-price` | 19 | 8.4% | 123 ; `M-guarantee` / `M-overcharge` / `M-scam` / `B-open` | 15 each | 6.6% each | 17 / 16 / 30 / 34 ; `B-login` | 13 | 5.8% | 15 ; `M-notrial` | 13 | 5.8% | 52 ; `M-payfail` | 12 | 5.3% | 16 ; `O-mislead` | 12 | 5.3% | 20 ; `M-trialtrap` | 10 | 4.4% | 10
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-089 — Limits: review text yields no conversion, renewal, churn or refund rate; the paid cohort is negatively selected and its 25 five-star payers under-represented; PAID is a floor

- **Where:** §4.6 The honest limits of this section
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 226 paid (floor); 25 paid 5★
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R09-106 — Three periods aligned to release history (P1 launch 14 May – 31 Dec 2024 n=464, P2 2025 n=641, P3 1 Jan – 4 Sep 2026 n=176); half-year buckets where shape matters; no trend claimed below 5 per period; headline ratings are almost flat, the composition underneath is not

- **Where:** §6.1 Method period table (verbatim)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Period | n | mean ★ | 1★ | 5★ ; P1 2024 | 464 | 3.567 | 26.1% | 52.8% ; P2 2025 | 641 | 3.429 | 27.6% | 49.0% ; P3 2026 | 176 | 3.648 | 21.6% | 56.2%
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-113 — Not claimed: any trend in request themes (counts below 10 per period), any cause for the 2026 rating recovery (P3 n=176 with a different country mix), anything about the Japanese IME bug beyond 'Aug 2024, never again'

- **Where:** §6.8 Trends explicitly NOT claimed
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R09-114 — Seven immediate actions with what they rest on and expected effect

- **Where:** §7.1 Immediate — do these before anything else table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** # | Action | Rests on | Expected effect ; 1 | Fix the Russia backend reachability problem. 52 of 113 RU reviews (46.0%) report minute-long loads; 6 say the app only works over a VPN; 36 RU reviewers paid. Treat as an infrastructure/CDN/regional-endpoint issue, not client performance | §0.7, §5.1-RU, §6.2 | Recovers the corpus's worst market. RU written mean 2.38 ; 2 | Remove the rating prompt from the sign-up flow. 13 reviews document being asked to rate before use; 9 five-star reviews carry entirely negative text; the public/written gap is +1.35 | §2.6, §5.6, §3 (5★) | Removes an App Store Review Guideline exposure and restores the rating as a usable metric ; 3 | Build a real in-app support and refund path. 25 reviews report no support response; 21 of those paid. Multiple reviewers state they wrote a public review *because* they could not find support | §0.3, §4.5 | Converts ~100 public refund complaints into private tickets ; 4 | Rate-limit nothing in the AI coach's crisis path, and add a handoff. One reviewer was cut off mid-crisis by the message cap | §6.6 | Safety. Non-negotiable in a 4+ ADHD/self-care app ; 5 | Clinically review the in-app depression and ADHD screens. Three reviews raise concerns: a false-negative depression result for a suicidal user, scaremongering at teenagers, and the ADHD content being generic | §0.6, §0.4 | Safety and regulatory exposure ; 6 | Display currency explicitly in every storefront. 19 `M-unclear` reviews; 4 of 74 Mexican reviewers say the ambiguity reads as a scam | §5.1-MX, §1.3 | Cheap; removes a fraud perception ; 7 | Add an audible completion/alarm option. 9 `G-sound` + 12 `B-notif` reviews; concentrated in SA, where `11836191831`·SA·3 gives a five-point audit | §2.2, §5.4 | Fixes a whole market's core complaint
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-126 — The G-thin → G-guide → O-mislead chain (99 + 21 + 20) is one problem: the app markets a coach and ships a checklist — nine actions

- **Where:** §7.3 Product — close the promise/delivery gap table (verbatim)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** # | Action | Rests on | Notes ; 1 | Make the guided breathing exercise re-runnable from the habit itself. This is the most specific, most repeated, cheapest high-impact request in the corpus | 21 `G-guide` reviews in 6 languages | `12885713029`·RU·2, `12699837651`·DE·3, `12609839103`·DE·4, `13309724057`·DE·4 all describe exactly where the button should go ; 2 | Attach a "how to do this" body to every preset habit. Reviewers get a bare title and no instruction: `12357846588`·TR·1 receives a reminder saying "forehead lines" and asks *"Alın çizgileri derken? Ne yapacağım?"*; `12710666495`·DE·3 says only the heading is shown | `G-thin`, `G-guide` | Turns the paid Discover library from a name list into content ; 3 | Ship the frequency model reviewers describe. Sub-daily repetition (N× per day), "any N days per week", explicit weekday selection, and skip/holiday | 22 `G-freq` reviews | `11668735422`·ID·3 and `12695260948`·TR·5 have written the spec for you ; 4 | Make preset habits editable and everything deletable. | 20 `G-noedit` + 15 `G-nodelete` reviews | `14400137816`·IN·1 says the store listing *claims* you can, and you cannot — that is a listing-accuracy problem too ; 5 | Group/categorise the day. Routines currently interleave; cleaning, self-care and study collapse into one list | 13 `G-group` + 8 `G-order` + 8 `G-dup` reviews | `13099009549`·FR·3, `12464161947`·DE·3, `11491997138`·DO·3 ; 6 | Expand icons, emoji and colours. "Only 6 colours" (`11607493158`·BR·4), "only 60 emoji" (`11703804318`·TR·5) | 14 `G-icons` reviews, mean 3.57 | Low cost, all from engaged users ; 7 | Backfill and forward-planning. Tick off yesterday; plan more than 3–4 days ahead | 6 `G-backfill` + 6 `G-future` reviews | `12847151988`·CA·4 and `14066249834`·DE·2 (the latter cancelled over it) ; 8 | Fix the four localizations reviewers say are machine-translated: JA, HE (including RTL), RU, AR | 14 `G-l10n` reviews, mean 1.79 | Two of these reviewers subscribed for a year before discovering the problem ; 9 | Widgets, dark mode, iPad, Apple Watch — in that order of demand | 11 + 4 + 7 reviews | Widgets are already paid in some storefronts; `12451223326`·SA·1 argues charging for them specifically is unfair
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R09-137 — Experiment: trial length A/B (3 vs 7 days) in DE, FR, US — hypothesis: high-spend markets convert better with a trial because the blocker is trust, not price; measure refund rate and 1★ rate, not just conversion

- **Where:** Part 7 #1 (§7.5 experiment 1) Trial length A/B (3 vs 7 days) in DE, FR, US
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Conditions:** evidence: R09-009, R09-101
- **Canonical:** C063 Free trial before purchase

### R09-138 — Experiment: cap interstitials at one per session — hypothesis: it reduces 1★ volume more than it reduces revenue

- **Where:** Part 7 #2 (§7.5 experiment 2) Upsell frequency cap
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Conditions:** evidence: R09-110
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

### R09-139 — Experiment: a skippable quiz — hypothesis: raises completion in RU/IN without reducing conversion

- **Where:** Part 7 #3 (§7.5 experiment 3) Onboarding length
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** O-long mean 1.31, 15 of 35 RU
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Conditions:** evidence: R09-025
- **Canonical:** C111 No long quiz before the price; show the price up front

### R09-140 — Experiment: make the breathing exercise repeatable — hypothesis: measurably reduces thin-product / misleading-ad sentiment and 7-day churn

- **Where:** Part 7 #4 (§7.5 experiment 4) Guided-content re-run
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 21 G-guide
- **Direction for us:** research · **Report confidence:** experiment · **Generalisable:** yes
- **Conditions:** evidence: R09-022
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate

### R09-142 — Research: actual trial-to-paid, renewal and refund rates are unknowable from reviews

- **Where:** §7.6 Research questions — What is the actual trial-to-paid, renewal and refund rate?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R09-143 — Research: is the Russia loading failure server-side, CDN, or a sanction-related dependency? Requires telemetry

- **Where:** §7.6 Research questions — Is the Russia loading failure server-side, CDN, or a sanction-related dependency?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** app-specific
- **Canonical:** C132 Do not sell in a storefront where the app cannot function

### R09-144 — Research: how large is the silent satisfied-paying population? The 226 paid reviewers are negatively selected by definition

- **Where:** §7.6 Research questions — How large is the silent satisfied-paying population?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 226 (floor)
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R09-145 — Research: did removing the money-back guarantee reduce conversion, or only refunds?

- **Where:** §7.6 Research questions — Did the Feb 2025 removal of the money-back guarantee reduce conversion, or only reduce refunds?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C089 Promos, giveaways and gift codes must work exactly as advertised

### R09-146 — Research: do the ADHD / depression screens have any clinical validation?

- **Where:** §7.6 Research questions — Do the ADHD/depression screens have any clinical validation?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R09-147 — Research: what do the ~40,000 star-only raters think? Given the in-onboarding prompt, that population may be substantially prompt-driven

- **Where:** §7.6 Research questions — What do the ~40,000 star-only raters think?
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** ~40,555 ratings
- **Direction for us:** research · **Report confidence:** open · **Generalisable:** yes
- **Canonical:** C150 Never ask for a rating before the user has used the app
