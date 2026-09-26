# Cards — report 64

Source: `App Store Reports/64. Critique AI - Habit Tracker - Routine Builder & AI Coach (REPORT).md`  
53 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 1
- [Must-haves](#must-haves) — 3
- [Must never break](#must-never-break) — 7
- [Features](#features) — 5
- [Monetization](#monetization) — 6
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 8
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 3
- [Dated events and trends](#dated-events-and-trends) — 2
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 4
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 5

## Product rules

### R64-047 — What to do first, if only three things ship: (1) M1 + M2 — disclose the price before the quiz and in the acquisition channel, costs nothing, addresses 53 reviews (12.65%) at combined mean 1.28; (2) F1 — make the paywall closeable-looking; (3) F2 — make the AI consume its input; M3 (the free tier) is the larger decision and the one the evidence most strongly supports — 39.62% could not evaluate the product — but a business-model change for the developer; the three decisions the corpus supports: ship a free tier or stop paying for creator acquisition; a paywall dismissible in a way 'a 13-year-old can find in two seconds' with the price before the quiz; make the AI consume its input or stop selling it as the headline

- **Where:** §9.5; §0.8; §9 intro
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 53 (12.65%) @ 1.28; 39.62% blocked
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `14018545521`, `14044788188`, `14252106354`
- **Canonical:** C111 No long quiz before the price; show the price up front; C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C147 Let people use the product before they pay; C279 An AI analysis must consume its input — reject empty, silent or black input instead of returning a confident score; C281 Brief every creator and acquisition channel to state the price — an audience told 'it's free' converts marketing spend into permanent 1★

## Must-haves

### R64-018 — Plan rigidity is the top non-price complaint among users — PLAN_RIGID 9 (2.15% global, 13.0% of the 69, mean 2.00); inside-app complaint ranking after price is plan rigidity → AI quality → focus failures, 'the list that governs retention rather than acquisition' (verbatim): Theme | n in segment | Segment rate | Global n | Global % ; PAY_PRICE | 15 | 21.7% | 105 | 25.06% ; PLAN_RIGID | 9 | 13.0% | 9 | 2.15% ; AI_QUALITY | 7 | 10.1% | 8 | 1.91% ; BUG_FEATURE | 7 | 10.1% | 9 | 2.15% ; FOCUS_BROKEN | 6 | 8.7% | 6 | 1.43% ; REQ_FEATURE | 8 | 11.6% | 8 | 1.91% — five mechanics (verbatim): Mechanic | Reviewers ; Plan regenerates weekly and cannot be kept | 13580337718 (nl) — *"the app gives you a different uncustomizable plan each week… your own tasks are also weekly and you have to put in your weekly tasks every week again"* ; Cannot delete or decline assigned tasks | 13580337718, 13721073236 (us) — *"it does not let me choose what tasks to do or not it would not let me cancel any" * ; Cannot reorder / reposition tasks | 14255073330 (us), 13904718444 (us) — *"you also can't move stuff around"* ; Plan ignores the user's real constraints | 13580337718 (*"It just says leg day on Wednesday… What if you don't train on Wednesday?"*), 12616930375 (us — gym→home setting will not change), 14290822522 (us — too advanced for a 12-year-old), 13778530992 (ca — wants it built around school/sport/work) ; Content is generic filler | 14493510323 (us) — *"vague/randomized… more like XP grabs"*; 14117563141 (ca) — *"all it does is organize workouts I had already organized myself"*; 14315502915 (ca) — workouts from *"a predetermined list with little calisthenic workouts"* — 'It just says leg day on Wednesday… What if you don't train on Wednesday?'; R1: let the plan persist — own-tasks not re-entered weekly, assigned tasks deletable, declinable and reorderable; R2: build the schedule around fixed commitments (school, sport, work) — three of the eight feature requests are this

- **Where:** §4.2 table (verbatim); §4.4 table (verbatim); §9.3 R1, R2; §3.3 N9; §3.6
- **This app does:** AI weekly plan regenerates, cannot edit
- **User reaction:** churn
- **Magnitude:** 9 (2.15%) mean 2.00; 13.0% of inside
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `13580337718`, `13721073236`, `14255073330`, `13904718444`, `12616930375`, `14290822522`, `13778530992`, `14493510323`
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional; C266 A generated programme escalates on observed completion, never on a fixed calendar — and never past what a health limit the user declared allows; C282 A generated plan belongs to the user — it persists, every assigned task can be deleted, declined and reordered, and it is built around the user's fixed commitments

### R64-026 — Data and privacy trust — TRUST_PRIVACY 5 (1.19%, meaningful, mean 1.20): 'don't put your email in this app' (two German reviewers, independently, three months apart); refusal to give card or personal details before seeing the product; objection to a photo requested before the price; the German set is thematically distinct — 4 of 14 (28.6%) PAY_SCAM and 2 of 14 (14.3%) TRUST_PRIVACY vs 5.01% and 1.19% globally, combining scam accusations with data-protection or bot-review warnings [limited evidence, n=14 — recorded because the concern class is legally sensitive]

- **Where:** §3.3 N12; §7.6
- **This app does:** email + photo + card before value
- **User reaction:** complaint
- **Magnitude:** 5 (1.19%) 1.20; DE 4/14 scam, 2/14 privacy
- **Direction for us:** must-have · **Report confidence:** meaningful / limited evidence · **Generalisable:** generalisable
- **Review IDs:** `13738694827`, `14044788188`, `13175983080`, `13867349978`, `14234452764`, `14126245313`
- **Canonical:** C085 Address tracking / privacy visibly; C111 No long quiz before the price; show the price up front

### R64-030 — Support: 3 reports, all 1★ (0.72%, emerging) — three emails about a login issue, one reply asking to clarify, then silence ('My son was so excited to use this app, but now it's just taking up space'); 'the customer support won't even get back to you when contacted' (billing); 'I even contacted the support and they didn't help' (paid, frozen) — all paying or attempting-to-pay customers with a resolvable problem; F5: answer support mail — low rate, 100% conversion to 1★

- **Where:** §4.7; §9.1 F5
- **This app does:** support unresponsive
- **User reaction:** 1★-burst
- **Magnitude:** 3 (0.72%) all 1★
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `13711005008`, `13765166985`, `14198628636`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

## Must never break

### R64-006 — The paywall cannot be dismissed — PAY_SOFTLOCK 39 (9.31%, high-priority, mean 1.72), 20 storefronts, Apr 2025 → Jul 2026, reported 'with unusual mechanical precision' (verbatim): Review ID | CC | ★ | Date | What they say ; 12620716476 | us | 1 | 2025-05-05 | *"you are stuck In the buy screen. You literally can't do anything but just stare at it"* ; 12677542375 | ae | 4 | 2025-05-20 | *"I got stuck on a subscribe screen how do I remove it?"* — a 4★ asking for help, not complaining ; 12764614931 | at | 1 | 2025-06-12 | *"there was nothing to close it"* (80%-off screen) ; 13150732585 | ca | 1 | 2025-09-18 | *"no button to close it so it's unusable unless you pay"* ; 13439077210 | au | 1 | 2025-11-25 | *"no cancel button, no ignore button, no X button. NOTHING!"* ; 13448441828 | gr | 2 | 2025-11-27 | *"I cannot press the don't pay now button even if I press it 20 times"* — reinstalled, same ; 13487460495 | us | 1 | 2025-12-07 | *"stuck on that same page ever since and there's no way to exit"* ; 13597784823 | gb | 1 | 2026-01-05 | *"even when restarting the App the banner never goes away"* ; 14044788188 | de | 1 | 2026-05-09 | DE: *"das X um es wegzuclicken ist unsichtbar, klein und nicht zu finden"* — "the X to close it is invisible, tiny and impossible to find" ; 14317192032 | ae | 4 | 2026-07-18 | *"How can I quit the page that says Only AED ____ please I am blocked!"* ; 14233984114 | ca | 2 | 2026-06-27 | *"it won't let me click off my start your journey page"* — '14044788188' (de) is decisive: 'das X um es wegzuclicken ist unsichtbar, klein und nicht zu finden' (the X is invisible, tiny and impossible to find), reconciling two reviewers who mention an X with 39 who say there is none — 'the close affordance fails discoverability for a large fraction of users, and those users experience it as uncloseable'; roughly one 1★ every two weeks for 17 months; two rate 4★ while trapped, asking for help (12677542375, 14317192032) — 'the clearest possible signal that this is a UI failure'; F1: make the dismiss control large, visible, reachable on first paint, verified on small screens (13044591013) and after force-relaunch (13597784823, 13787575794); research: is the control A/B-varied or just undiscoverable; §9.5 #2 turns a 9.31% 1★ generator into a non-event and stops the scam framing at its source

- **Where:** §0.1 softlock table (verbatim); §3.3 N3; §9.1 F1; §9.4 #2; part 9 #2
- **This app does:** close control exists but invisible / tiny
- **User reaction:** 1★-burst
- **Magnitude:** 39 (9.31%) mean 1.72; 26×1★; P1 16.9% → P4 6.8%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `14044788188`, `12677542375`, `14317192032`, `13439077210`, `13448441828`, `13597784823`, `13787575794`, `12604104583`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C145 Every promotional or onboarding modal must be dismissible on the smallest screen

### R64-012 — The AI is the brand and, among people who used it, the weakest part: 19 (4.53%, very strong, mean 2.21) touch AI analysis; AI_QUALITY 8 (1.91%, meaningful, mean 2.00) say output is wrong, generic or fabricated; 7 of 69 who got in (10.1%); 3 of 13 payers — (a) accepts null input and returns a confident result, four independent reviewers, four storefronts, ten months (verbatim): Review ID | CC | ★ | Date | Test they ran ; 13706381217 | us | 1 | 2026-02-02 | Black photo, said nothing → *"it just gives you things that were good and stuff to work on"* ; 14117563141 | ca | 1 | 2026-05-29 | Voice coach on/off *"without saying a word"* → same generic feedback ; 14252106354 | us | 2 | 2026-07-02 | Silence into the speaking exercise → scored 79 ; 13227562707 | gb | 1 | 2025-10-05 | *"No matter what photo you upload, it gives the same results"* — 'The voice coach just repeats the exact same prompts over and over… It doesn't actually listen' (paid $50); silence scored 79 ($12.99/mo); black photo gets feedback (paid $25); 'No matter what photo you upload, it gives the same results' — 'a claim that at least one analysis path does not consume its input', the highest-severity product finding; (b) hallucination ('the AI checkers like outfit and posture are hallucinating a bit'); (d) delivery failure — long recordings buffer and return no feedback (paid annually, 4★); 7 of 8 AI_QUALITY from Feb 2026 on — 'what a product looks like when its user base finally grows large enough to audit the headline feature'; F2: reject empty/null input in every AI path; §0.8 #3: make the AI consume its input, or stop selling it as the headline

- **Where:** §0.6; §4.3 table (verbatim); §9.1 F2; §9.5 #3; §0.8 #3
- **This app does:** AI scores empty input
- **User reaction:** churn
- **Magnitude:** AI 19 (4.53%) 2.21; AI_QUALITY 8 (1.91%) 2.00; 3/13 payers; FEAT_AI 6.8% in P4
- **Direction for us:** must-never-break · **Report confidence:** very strong / meaningful · **Generalisable:** generalisable
- **Review IDs:** `14117563141`, `14252106354`, `13706381217`, `13227562707`, `14016792944`, `14262652548`, `12904809598`
- **Canonical:** C056 Don't build AI features on demand grounds; C148 The paid product must deliver what the ads and onboarding demonstrate; C279 An AI analysis must consume its input — reject empty, silent or black input instead of returning a confident score

### R64-029 — Reliability: BUG_CRASH 7 (1.67%, mean 1.57), BUG_FEATURE 9 (2.15%, 3.22), BUG_UI 3 (0.72%, 2.33) — no clustering, no single defect by more than two reviewers except the freeze during plan generation (May 2025 and Apr 2026, a year apart); crashes on every AI review, iPad, coach tab 'after the update'; two defects exclude users entirely: 'Doesnt work on smaller phones' (cz) and 'I can't scroll in the app, which means I can't choose the correct options' (au) — R7: fix small-screen layout and scrolling

- **Where:** §3.3 N11; §4.6; §9.3 R7
- **This app does:** plan-generation freeze; small-screen layout
- **User reaction:** complaint
- **Magnitude:** CRASH 7 (1.67%); FEATURE 9 (2.15%); UI 3 (0.72%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `12695949583`, `13937315217`, `12507627898`, `12918895427`, `13874326932`, `13044591013`, `14447033847`
- **Canonical:** C031 Crashes / launch failures; C141 Native iPad layout; C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R64-035 — Paid-user tiers never mixed (verbatim): Tier | Definition | n | % of 419 | Mean ★ ; A. Direct purchase evidence (PAID_EXPLICIT) | The reviewer states they paid, were charged, subscribed, refunded, or restored | 13 | 3.10% | 1.85 ; B. Access evidence (INSIDE_APP, not A) | Describes post-paywall behaviour or a personal outcome; payment not stated | 56 | 13.37% | 4.34 ; C. Inferred interest only | Wants the paid features, never got them | 350 | 83.53% | 2.36 — no conversion rate claimed; the 13 who state they paid (verbatim): Review ID | CC | ★ | Date | What they bought | What happened ; 12802076240 | us | 1 | 2025-06-21 | subscription (age 15) | *"Even after purchasing, the app still doesn't function. It keeps having the same paywall popup"* — entitlement failure ; 12918895427 | ca | 1 | 2025-07-21 | charged instantly | Can't log in on a second device — *"you have to pay for each device"*; app refuses to work on iPad ; 13469954659 | ge | 1 | 2025-12-03 | 3-day trial → auto-charged | *"it didn't let me know that it was over so it took my money without me knowing… i want my money back"* ; 13580337718 | nl | 5 | 2026-01-01 | 30€/yr on sale | Detailed teardown; verdict: *"for the AI plan? No. For speaking coaching and challenges? Yes"* ; 13706381217 | us | 1 | 2026-02-02 | $25 | AI responses *"are not real"*; focus mode blocks apps permanently against Screen Time settings ; 13721073236 | us | 1 | 2026-02-07 | immediate charge | *"On the website it said cancel anytime but it immediately billed me and would not let me have my money back"* ; 13765166985 | ca | 1 | 2026-02-19 | trial → full year upfront | *"They say that they give a three day trial but charge you for the full year upfront… customer support won't even get back to you"* ; 13874326932 | in | 3 | 2026-03-22 | ~$30 | Coach tab crashes the app after an update — *"I expect better from an app which costs like 30 dollars"* ; 13945409581 | us | 5 | 2026-04-11 | $2/month discount | *"The regular pricing is pretty expensive… it gave me a 'special discount' for $2/month so I did it"* — the only clean purchase-trigger record in the corpus ; 14117563141 | ca | 1 | 2026-05-29 | $50 | Voice coach doesn't listen; *"all it does is organize workouts I had already organized myself"*; *"Temu quality"* ; 14198628636 | us | 1 | 2026-06-18 | $40 | App froze on AI use; reinstall charged again; support unhelpful; *"I lost 40 dollars on something I could've just done on the notes app"* ; 14262652548 | us | 4 | 2026-07-04 | annual | Long recordings buffer and return no feedback — *"i kinda feel ripped off for paying for the year with it glitching out like that"* ; 14290822522 | us | 1 | 2026-07-11 | (bought for a 12-year-old) | Too complex for the child; *"need refund"* ; 14415717270 | se | 1 | 2026-08-11 | prior purchase | *"I can't restore my purchase so basically I can't do anything now"* — segment findings (verbatim): Finding | Segment rate | Global count | Global % ; Report a defect or shortfall after paying | 12 / 13 | 12 | 2.86% ; Billing dispute specifically | 6 / 13 | 6 | 1.43% ; AI-quality complaint | 3 / 13 | 3 | 0.72% ; Entitlement failure (paid but still locked / can't restore / charged twice) | 4 / 13 | 4 | 0.95% ; Unreservedly satisfied | 1 / 13 (13945409581) | 1 | 0.24% — F4: fix entitlement recognition — a purchase must survive relaunch, reinstall and restore and work across devices ('you have to pay for each device'; iPad refused); research #4: actual paid-cohort retention — 12 of 13 report a problem, a self-selected tail

- **Where:** Part 6 tier table (verbatim); §6.1 tables (verbatim); §9.1 F4; §9.4 #4; part 9 #4
- **This app does:** entitlement failures; per-device purchase
- **User reaction:** 1★-burst
- **Magnitude:** 13 payers @ 1.85; 12/13 defect; 6/13 billing; 4/13 entitlement; 1/13 satisfied
- **Direction for us:** must-never-break · **Report confidence:** very strong (segment n=13) · **Generalisable:** generalisable
- **Review IDs:** `12802076240`, `12918895427`, `14415717270`, `14198628636`, `13945409581`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C141 Native iPad layout

### R64-036 — Post-purchase problems that produce refunds, four mechanisms: (1) paid but still gated — paywall popup after purchase, restore fails, reinstall charges again: segment 3/13 = 23.1%, global 0.72% — 'the highest-severity class in the report: it converts a completed sale into a 1★ and a fraud accusation'; (2) billing expectation mismatch — 'On the website it said cancel anytime but it immediately billed me'; 'They say that they give a three day trial but charge you for the full year upfront'; PAY_BILLING 8 (1.91%, mean 1.50, 6 of 13 payers); (3) product does not match the sale — $50 'expecting actual coaching', bought for a 12-year-old, too advanced; (4) support does not close the loop; M5: a monthly or one-time SKU visible before the annual removes the billing-dispute class

- **Where:** §6.5; §3.3 N8; §9.2 M5
- **This app does:** annual-upfront billing; 'cancel anytime' copy
- **User reaction:** 1★-burst
- **Magnitude:** BILLING 8 (1.91%) 1.50; paid-but-gated 3/13 (23.1%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `12802076240`, `14415717270`, `14198628636`, `13469954659`, `13721073236`, `13765166985`, `14290822522`, `14364538522`
- **Canonical:** C029 Billing must be exactly right; C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C148 The paid product must deliver what the ads and onboarding demonstrate; C163 Visible monthly plan — annual-default trials drive billing disputes; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R64-048 — A screen-time blocker must never lock the user out permanently or override the OS Screen Time settings — focus mode blocked apps permanently for a $25 payer ('13706381217'), stayed locked after 10 push-ups ('so the reviewer turns the mode off, which gets rid of the point'), and unlock silently fails in silent mode because it depends on a notification

- **Where:** §4.5; §9.1 F3
- **This app does:** blocks permanently
- **User reaction:** churn
- **Magnitude:** 6 of 10 focus mentions broken
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `13706381217`, `14452220984`, `14391271895`
- **Canonical:** C280 An app-blocking focus mode must always unlock when its condition is met, never lock apps permanently, never override OS Screen Time, and never depend on a notification the OS can suppress

### R64-050 — Login and restore failures, small and all 1★: ACCT_LOGIN 3 (0.72%, emerging, mean 1.00 — 3/0/0/0/0), including a parent's three unanswered emails about a login issue; SUPPORT_BAD 3 (0.72%, 1.00); PAY_RESTORE 2 (0.48%, weak, 1.00 — 'I can't restore my purchase so basically I can't do anything now'); can't log in on a second device — 'you have to pay for each device'

- **Where:** §3.1 ACCT_LOGIN, SUPPORT_BAD, PAY_RESTORE; §4.7
- **This app does:** login + restore failing
- **User reaction:** 1★-burst
- **Magnitude:** ACCT_LOGIN 3 (0.72%) 1.00; SUPPORT_BAD 3 (0.72%) 1.00; PAY_RESTORE 2 (0.48%) 1.00
- **Direction for us:** must-never-break · **Report confidence:** emerging / weak · **Generalisable:** generalisable
- **Review IDs:** `13711005008`, `14415717270`, `12918895427`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C035 Account system from day one; C036 A support channel that exists, is reachable outside the app, and answers

## Features

### R64-013 — AI analysis without advice: 'this app just points out what's supposedly wrong with you without offering any solutions' (ca, 1★, paid $50); 'an app that tells you to wash your face and talk to people' (ca, 1★) — R3: give the AI something to say after the critique

- **Where:** §4.3 (c); §9.3 R3
- **This app does:** critique without solutions
- **User reaction:** complaint
- **Magnitude:** 2 reviews
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `14117563141`, `14315502915`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate; C279 An AI analysis must consume its input — reject empty, silent or black input instead of returning a confident score

### R64-014 — Focus mode — block selected apps, earn them back for ~15 min by doing push-ups or meditation — is the most distinctive thing in the corpus and the most broken: FEAT_FOCUS 10 (2.39%, 11.6% of INSIDE_APP, mean 3.40); FOCUS_BROKEN 6 of 10 (1.43%, meaningful, mean 3.50) (verbatim): Review ID | CC | ★ | Failure ; 12972513399 | us | 4 | *"The workout for apps doesn't work but overall good"* ; 13580337718 | nl | 5 | *"Push-ups to open apps doesn't work"*; focus mode is all-or-nothing, no way to open an app while on ; 13706381217 | us | 1 | Blocks apps permanently, overriding Screen Time permissions ; 14061007904 | us | 4 | Tapping "do workout/meditation" on a locked app *"takes me no where nor does it do anything"* ; 14452220984 | us | 2 | Workout sometimes doesn't appear (needs a second tap); after 10 push-ups *"it still locks out the apps"* — so the reviewer turns the mode off, *"which gets rid of the point"* ; 14391271895 | us | 5 | Diagnosis: *"you can't unlock apps in focus mode in silent mode because you cant receive the notification"* — four of the six are 4★/5★ advocates, 'the cheapest, highest-signal bug reports a team can get'; a 5★ defender supplies the root cause (unlock depends on a notification silent mode suppresses); it blocks apps permanently overriding Screen Time; no in-between state; one reviewer downloaded specifically for it and never reached it ('I wanted to be forced to do pushups before I opened an app', 1★); 5 of 6 failures from 2026; Clearspace named as a free substitute; F3: fix unlock including the silent-mode path, never override Screen Time

- **Where:** §0.7 table (verbatim); §4.5 table (verbatim); §9.1 F3; §3.5
- **This app does:** paid; unlock broken
- **User reaction:** mixed
- **Magnitude:** FEAT_FOCUS 10 (2.39%) 3.40; FOCUS_BROKEN 6 (1.43%) 3.50; 9 of 10/11 US
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `14391271895`, `14061007904`, `14452220984`, `13706381217`, `13580337718`, `12972513399`, `13051237656`, `14327391653`
- **Canonical:** C066 Focus timer; C280 An app-blocking focus mode must always unlock when its condition is met, never lock apps permanently, never override OS Screen Time, and never depend on a notification the OS can suppress

### R64-015 — What actually works — among the 69 who got in, praise concentrates on things that are not the AI (verbatim): Feature | Code | n | % of 419 | % of INSIDE_APP (69) | Mean ★ ; Focus mode / block apps, earn them back with exercise | FEAT_FOCUS | 10 | 2.39% | 11.6% | 3.40 ; XP, quests, leaderboards | FEAT_GAMIFY | 8 | 1.91% | 10.1% | 4.00 ; Habit / routine / calorie tracking | FEAT_TRACK | 10 | 2.39% | 11.6% | 4.20 ; Community | FEAT_COMMUNITY | 4 | 0.95% | 5.8% | 3.75 — gamification (XP, quests, leaderboards) unambiguously liked and proposed as the free hook; one sharp dissent: 'the tasks (even when tailored) are kind of vague/randomized for each day and seem more like XP grabs than anything else' (us, 2★); inside-app praise (verbatim): Theme | n in segment | Segment rate | Global n | Global % ; PRAISE_GEN | 23 | 33.3% | 67 | 15.99% ; OUT_FITNESS | 12 | 17.4% | 12 | 2.86% ; FEAT_TRACK | 8 | 11.6% | 10 | 2.39% ; FEAT_FOCUS | 8 | 11.6% | 10 | 2.39% ; FEAT_GAMIFY | 7 | 10.1% | 8 | 1.91% ; OUT_CONFIDENCE | 7 | 10.1% | 8 | 1.91% — 'Duolingo for health!'

- **Where:** §0.7 table (verbatim); §3.4 P5, P6; §4.1 table (verbatim)
- **This app does:** paid
- **User reaction:** praise
- **Magnitude:** GAMIFY 8 (1.91%) 4.00; TRACK 10 (2.39%) 4.20; COMMUNITY 4 (0.95%) 3.75
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `14047773348`, `14141948204`, `14233567561`, `14277884922`, `14359992073`, `14493510323`, `14018545521`, `13575098002`
- **Canonical:** C024 Streaks / gamification; C134 Lead the store listing with what users actually love

### R64-020 — Product surfaces per reviewers (verbatim): Surface | Review-derived description | Evidence IDs ; Onboarding quiz + scan | A long question set, then a physique photo, then a score/projection ("27% less confident than average") | 12543124530 12660642985 13398085653 13514592027 14147892220 14286509974 14411136735 ; AI analysis | Physique scan, posture analysis, outfit rating, food/meal scan, AI voice coach, AI chat coach | 12695949583 13305655143 13667546626 14016792944 14315502915 14359992073 14371635004 ; Daily plan / quests | Weekly-regenerated task list with XP, quests, streaks, leaderboards, own-task entry | 13580337718 14047773348 14141948204 14255073330 14359992073 14493510323 ; Focus mode | Blocks selected apps; unlock by doing push-ups / meditation for ~15 min | 12972513399 13051237656 14045355654 14061007904 14277884922 14359992073 14391271895 14452220984 ; Community | Social feed with comments and other users pursuing the same goals | 13975991354 14237114665 14315502915 14404327380 — the App Store 'Habit Tracker' category is the narrowest part; free / paid classification (verbatim): Capability | Status per reviews | Confidence ; Download and account creation | Free | High — universal ; Onboarding quiz | Free | High — 23 reviewers completed it before the wall ; Initial physique photo / scan submission | Free (submission), result appears gated | Medium — 13398085653 took the photo, then the paywall; 14371635004 says *"Doesn't even give you 1 trial check of the physique"* ; Onboarding score / projection | Free (shown as the hook) | Medium — 13514592027 14147892220 ; Daily plan / quests / XP / leaderboard | Paid | High ; AI coach chat | Paid | High — 13452525743: *"pay only for my unlimited access to my coach ai"* ; Physique / posture / outfit / food analysis results | Paid | High ; AI voice coach | Paid | High — 14117563141 14252106354 ; Focus mode / app blocking | Paid | High ; Community feed | Paid | Medium — only paying reviewers describe it ; Any free tier at all | Does not exist | High — 0 of 419 reviewers report free ongoing use — unclear: whether the 3-day trial is universal or A/B-varied (10 found it, 26 say no trial), whether the one-time offer is exit-intent or cohort-based, whether a lifetime SKU exists (one asks for it); §2.4: only one review in 419 ('I'm just starting but it looks good and I didn't need to buy anything yet', de, 4★) got underway without paying — its uniqueness is itself evidence the hard paywall is the default path; research #5: was it an A/B cohort

- **Where:** §2.1 table (verbatim); §2.3 table (verbatim); §2.4; §9.4 #5; part 9 #5
- **This app does:** everything past onboarding paid
- **User reaction:** mixed
- **Magnitude:** 0 of 419 report free ongoing use
- **Direction for us:** research · **Report confidence:** high · **Generalisable:** app-specific
- **Review IDs:** `14359992073`, `13753463291`, `14371635004`, `13452525743`
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay

### R64-040 — Signals that would change a paid user's mind (verbatim): Ask | Asked by | Cost signal ; Make the AI consume its input | 13706381217 14117563141 14252106354 13227562707 | One reproducible bug ; Fix focus-mode unlock (incl. silent-mode notification) | 14061007904 14452220984 14391271895 12972513399 13580337718 | Root cause already supplied by a reviewer ; Let the plan persist and be reordered/deleted | 13580337718 14255073330 13721073236 13904718444 | Scoped product work ; Build the schedule around fixed commitments | 13778530992 14290822522 14255073330 | Scoped product work ; Apple Health / Hevy sync, exercise animations | 14016792944 | Integration work ; Stop showing ads to payers | 14436616950 | Configuration — every specific new-capability request, REQ_FEATURE 8 (1.91%, meaningful, mean 3.50) (verbatim): Review ID | CC | ★ | Request ; 13189680191 | us | 4 | A calorie tracker alongside the existing food scanner ; 13778530992 | ca | 4 | Build the schedule around fixed commitments — school, sport, work ; 13999226575 | ch | 5 | A notes space ; 14016792944 | us | 3 | Exercise animations/photos; Apple Health and Hevy sync ; 14203012041 | us | 4 | Ability to delete chats ; 14255073330 | us | 2 | Per-task XP weighting, reorderable schedule, bodyweight + muscle-group workout tracking ; 14290822522 | us | 1 | A simple calendar/clock view with check-off, for a 12-year-old ; 13580337718 | nl | 5 | Persistent (non-weekly) own-tasks; ability to delete future tasks; a partial focus-mode state — R5: calorie tracker beside the food scanner, Apple Health + Hevy sync and exercise animations, notes space, delete chats, per-task XP weighting, loosen comment moderation

- **Where:** §6.6 table (verbatim); §3.6 table (verbatim); §9.3 R5
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 8 (1.91%) 3.50
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `13189680191`, `13778530992`, `13999226575`, `14016792944`, `14203012041`, `14255073330`, `14290822522`, `13580337718`
- **Canonical:** C021 Apple Health integration; C067 Fitness / health tracking use case; C172 Per-day / per-habit notes and journal text; C202 A light social layer that is explicitly not a social network; C279 An AI analysis must consume its input — reject empty, silent or black input instead of returning a confident score; C280 An app-blocking focus mode must always unlock when its condition is met, never lock apps permanently, never override OS Screen Time, and never depend on a notification the OS can suppress; C282 A generated plan belongs to the user — it persists, every assigned task can be deleted, declined and reordered, and it is built around the user's fixed commitments

## Monetization

### R64-009 — The single most common constructive request is 'let me in somehow': 95 (22.67%, high-priority, mean 1.75) propose a way to be admitted (verbatim): Proposal | Code | n | % of 419 | Band ; A free tier / free version | PAY_FREEREQ | 66 | 15.75% | High-priority ; Trial: none, too short, or removed | PAY_TRIAL | 26 | 6.21% | High-priority ; A specific pricing structure (tiers, one-off, monthly split, teen tier) | PAY_TIERS | 21 | 5.01% | High-priority ; Ads instead of payment | PAY_ADS_OK | 12 | 2.86% | Meaningful — composite unions (verbatim): Union | Members | n | % of 419 | Mean ★ ; Any monetization theme | 11 PAY_* codes + blocked set | 293 | 69.93% | 1.81 ; Blocked at the paywall | HARDWALL ∪ SOFTLOCK ∪ QUIZWALL ∪ BAIT ∪ 2WALL | 166 | 39.62% | 1.52 ; Price objection or free-tier request | PRICE ∪ FREEREQ | 154 | 36.75% | 1.90 ; Proposes a way in | FREEREQ ∪ ADS_OK ∪ TIERS ∪ TRIAL | 95 | 22.67% | 1.75 ; No monetization theme at all | — | 126 | 30.07% | 4.41 ; Any trust concern | SCAM ∪ BAIT ∪ PRIVACY ∪ AISLOP ∪ BOTS ∪ MANIP | 58 | 13.84% | 1.28 ; Rating given without product experience | PRE_USE ∪ LOWINFO ∪ CONTRA | 57 | 13.60% | 4.54 ; Any defect report | CRASH ∪ UI ∪ FEATURE ∪ FOCUS_BROKEN ∪ AI_QUALITY ∪ LOGIN ∪ PLAN_RIGID | 37 | 8.83% | 2.35 ; Any AI feature touched | FEAT_AI ∪ AI_QUALITY | 19 | 4.53% | 2.21 — strip monetization out and 126 reviews remain at 4.41 stars; 69.93% of the corpus is talking about money; developed proposals: 3 days structurally too short ('Getting into stuff like this will take at least a month to stick') with 14–30 days and a three-tier ladder with an ad-supported base, from a reviewer who defends the price; 'offer a limited but meaningful free experience… A freemium model done right builds trust'; keep workout and XP/leaderboard free and gate the rest — 'how do you want us to show the app to other people if we cant even test it'; M3: ship a permanently free tier — habit/task tracking + XP/leaderboard free; AI analysis, focus mode and coach paid; 'converts the 3★ band first; removes the 1★ acquisition tax'; §0.8 #1: 'Ship a free tier, or stop paying for creator acquisition'

- **Where:** §0.4 table (verbatim); §3.2 table (verbatim); §5.3; §9.2 M3; §0.8 #1
- **This app does:** no free tier
- **User reaction:** blocked-conversion
- **Magnitude:** 95 (22.67%) mean 1.75; FREEREQ 66 (15.75%) 1.82; no-monetization 126 (30.07%) 4.41
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `13352317135`, `12808091283`, `13371847051`, `14018545521`
- **Canonical:** C024 Streaks / gamification; C082 Ads in the free tier; C147 Let people use the product before they pay; C238 A rewarded-ad unlock path for users who cannot pay (teens, students)

### R64-010 — 12 reviewers (2.86%, meaningful, mean 1.58) volunteer ads as an acceptable price for access, while exactly one paying reviewer objects ('please don't add ads. I'd rather pay than see ads', us, 5★) and one (gb, 4★) reports already seeing ads while paying £40/yr — 'the worst of both models'; F6: stop serving ads to paying subscribers (1, 0.24%, weak — verify before acting); research #7

- **Where:** §0.4; §3.1 PAY_ADS_OK; §3.4; §9.1 F6; §9.4 #7; part 9 #7
- **This app does:** no ad tier; ads reportedly shown to a payer
- **User reaction:** mixed
- **Magnitude:** PAY_ADS_OK 12 (2.86%) 1.58; ADS_PAID 1 (0.24%)
- **Direction for us:** undecided · **Report confidence:** meaningful / weak · **Generalisable:** generalisable
- **Review IDs:** `12932976917`, `13352317135`, `14223602930`, `14208933476`, `14436616950`
- **Canonical:** C082 Ads in the free tier; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C238 A rewarded-ad unlock path for users who cannot pay (teens, students)

### R64-021 — Price ladder reconstructed from review text (verbatim): Reported price | Reviewers | Reading ; ~$40 / £40 / 40–45€ per year | 29 reviews (6.92%) — 12787371532 12899171156 12911772561 12991823037 13279976831 13371847051 13395217091 13437522598 13947967990 14006999732 14113188077 14147892220 14198628636 14238660669 14259824574 14300908983 14308340924 14359620844 14391271895 14395829020 14404327380 14408502191 14408647172 14436616950 14452220984 14470949169 14480276687 14495815355 + 12543124530 12552819232 | The modal annual price. Named identically across US/GB/DE/IT/LV storefronts. 13371847051 gives $39.99. ; $7–13 / 7.99€ / 89 kr per week | 8 reviews — 12916754441 12970403247 13470152850 13580337718 13626787196 13785854596 13976519985 14252106354 | A weekly SKU exists alongside the annual. 13580337718 states 8€/week undiscounted. ; $16–28 / month | 12593476842 12904809598 14252106354 ($12.99) | Monthly SKU, or reviewer arithmetic on the weekly. 12904809598 computes $16/mo → $192/yr. ; Discounted "one-time offer" | 9 reviews (PAY_DISCOUNT, 2.15%) — 12557945275 12693931913 12737331145 12764614931 13381524821 13580337718 13597784823 13945409581 14233567561 | A second, cheaper offer appears on exit intent. Reported as 80% off (12557945275 12764614931), 75% off (14233567561), £2.08/mo billed as £24/yr (12693931913), 30€/yr on sale (13580337718), $2/mo (13945409581). ; 3-day trial | 10 reviews — 13036584203 13175983080 13352317135 13469954659 13487460495 13537160323 13765166985 13818513442 13851683780 14442257411 | Exists, but reviewers report it requires card details up front (13867349978), charges the full year on expiry (13765166985), cannot be cancelled in-app (13818513442), and cannot be reached at all by others. ; Outliers (treat as reviewer error or extreme storefront pricing) | 13228824089 ($200/yr) 14286509974 ($100/yr) 14284939336 (50€/month) 13977263500 ($60) 14234452764 (₦19,900/mo, ₦69,900/yr) | Retained in the corpus, excluded from the modal price statement. — modal ~$40/£40/40–45€ per year (29 reviews, 6.92%); a weekly SKU ($7–13 / 7.99€ / 89 kr, 8 reviews) beside the annual; monthly $16–28 or $12.99; an 80%/75%-off exit-intent 'one-time offer'; 3-day trial requiring card up front, charging the full year on expiry, not cancellable in-app; outliers $200/yr, $100/yr, 50€/month, $60, ₦19,900/mo / ₦69,900/yr

- **Where:** §2.2 table (verbatim); Limitation 8
- **This app does:** annual ~$40 + weekly + monthly + exit discount + 3-day trial
- **User reaction:** mixed
- **Magnitude:** modal $40/yr 29 (6.92%); weekly 8; discount 9 (2.15%); trial 10
- **Direction for us:** none · **Report confidence:** reviewer-reported · **Generalisable:** app-specific
- **Review IDs:** `13371847051`, `13580337718`, `12904809598`, `12693931913`, `13867349978`, `13765166985`, `13818513442`, `13228824089`, `14234452764`
- **Canonical:** C109 A free trial must be a real trial; C113 One stable, disclosed price — no discount wheels; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R64-022 — Price is too high is distinct from 'no free use' — PAY_PRICE 105 (25.06%, high-priority, mean 1.94; 59/15/16/8/7 by 1★→5★) accept that paying is legitimate and object to the amount: 'It's okay that you have to pay, but I can't pay that much, and many adults wouldn't either because there are so many other apps that cost way less' (us, 4★); the 3★ band is the clearest 'I want to buy this and cannot' signal (verbatim): Theme | n | % of 3★ band ; PAY_PRICE | 16 | 45.7% ; PAY_HARDWALL | 12 | 34.3% ; PAY_FREEREQ | 9 | 25.7% ; INFLUENCER | 6 | 17.1% ; PAY_TIERS | 4 | 11.4% ; PAY_MINOR | 4 | 11.4% — PAY_PRICE peaks at 45.7% of 3★ while PAY_SCAM is zero: 'if this was free, this could've been one of the best apps'; 'I know that's not bad, but at the time I cannot afford it' — 'If a free or cheaper tier ships, this band converts first'; at 1★ price means refuse, at 5★ 'worth it but lower it'

- **Where:** §3.3 N2; §5.3 table (verbatim); §5.7; §6.3
- **This app does:** ~$40/yr
- **User reaction:** blocked-conversion
- **Magnitude:** 105 (25.06%) 1.94; 45.7% of 3★
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `13664731850`, `13279976831`, `14076602668`, `13450759723`, `14300908983`, `14275066962`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C147 Let people use the product before they pay

### R64-023 — Trial absent, too short, or a trap — PAY_TRIAL 26 (6.21%, high-priority, mean 1.58, persistent 7.8/6.1/5.6/5.8% across periods): (a) no trial (4 named); (b) 3 days too short — a habit product cannot be tested in 3 days; (c) the trial charges or cannot be cancelled — 'it didn't let me know that it was over so it took my money without me knowing'; 'at least bring back the free trial' (Dec 2025) — the only review implying the trial was removed, unverifiable; card required up front (refused by 13867349978), personal details refused pre-trial; M4: if no free tier, lengthen to 14 days and remove the card requirement — strictly weaker than M3 because PAY_BAIT reviewers never reach a trial

- **Where:** §3.3 N5; §9.2 M4; §6.3
- **This app does:** 3-day card-required trial → full-year charge
- **User reaction:** complaint
- **Magnitude:** 26 (6.21%) mean 1.58
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `12552819232`, `13537160323`, `13851683780`, `14442257411`, `13469954659`, `13765166985`, `13818513442`, `13525806908`, `13867349978`
- **Canonical:** C063 Free trial before purchase; C109 A free trial must be a real trial

### R64-038 — Upgrade barriers in order of evidence weight (verbatim): Barrier | Evidence | n | % of 419 ; Cannot evaluate before buying | No free tier; trial requires card (13867349978) or is unreachable | 166 blocked | 39.62% ; Absolute price vs audience income | 20 self-identified minors/teen-price arguments; 105 price objections | 105 | 25.06% ; Annual-upfront charge | 13765166985, 13721073236, 13469954659 all describe a full-year charge where they expected trial/monthly flexibility | 8 | 1.91% ; No one-time / lifetime option | 14241751488: *"you might as well just sell your app instead of using subscriptions"*; 13925870531: *"Almeno dividessero il prezzo in mesi"* | 21 (PAY_TIERS) | 5.01% ; Trust | *"don't put your email into the App"* (13738694827, 14044788188); bot-review suspicion (13443337238) | 58 (trust union) | 13.84% ; A free substitute exists | ChatGPT for the AI half, Notes/Sheets/Calendar for the tracker half, Clearspace for focus mode | 13 | 3.10% — no one-time / lifetime option: 'you might as well just sell your app instead of using subscriptions'; 'Almeno dividessero il prezzo in mesi' (at least split the price into months, it) — PAY_TIERS 21 (5.01%, high-priority, mean 1.48)

- **Where:** §6.3 table (verbatim)
- **This app does:** subscription only; annual upfront
- **User reaction:** blocked-conversion
- **Magnitude:** blocked 166 (39.62%); price 105; tiers 21 (5.01%)
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `14241751488`, `13925870531`, `13867349978`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C005 Know which competitors buyers compare against; C085 Address tracking / privacy visibly; C163 Visible monthly plan — annual-default trials drive billing disputes

## Tactics the app used

### R64-034 — The exit-intent discount ladder ('one-time offer' after dismissing the first paywall) — PAY_DISCOUNT 9 (2.15%, mean 2.44, split 5×1★ / 3×5★) and PAY_2WALL 8 (1.91%, mean 1.25): it converts ('The regular pricing is pretty expensive… it gave me a special discount for $2/month so I did it' — the only clean purchase-trigger record; 75% off → 5★) and it destroys trust ('Preis 80% Rabatt, wenn man Zahlung abbricht. Unglaubwürdig.'; £2.08/mo advertised, £24/yr charged); mixed themes (verbatim): Theme | Why it is mixed ; FEAT_FOCUS (10, mean 3.40) | The most distinctive feature and the most defective: 6 of 10 mentions are failures. ; PAY_DISCOUNT (9, mean 2.44) | Converts two reviewers (13945409581 $2/mo, 14233567561 75% off → 5★) and reads as manipulation to five others (*"Preis 80% Rabatt, wenn man Zahlung abbricht. Unglaubwürdig."* — 12557945275). ; INFLUENCER (42, mean 2.38) | The acquisition engine and the expectation-setting failure in one theme. 9 of 42 are 5★. ; FEAT_COMMUNITY (4, mean 3.75) | *"the community is priceless"* (14237114665) vs *"a probably fake community page"* (14315502915) and over-aggressive comment moderation (14404327380). — M7: reconsider it; at minimum show the billed total on the discounted offer

- **Where:** §5.7; §3.5 table (verbatim); §9.2 M7
- **This app does:** 80%/75% off exit offer; second paywall
- **User reaction:** mixed
- **Magnitude:** DISCOUNT 9 (2.15%) 2.44 split 5×1★/3×5★; 2WALL 8 (1.91%) 1.25
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `13945409581`, `14233567561`, `12557945275`, `12693931913`, `12764614931`
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

## Insights (the why)

### R64-004 — 82.58% of reviewers never got inside the product — 'a report about a purchase funnel, not mostly about a habit tracker' (verbatim): Segment | n | % of 419 | Mean ★ | 1★ share ; Never got in (no evidence of post-paywall use) | 346 | 82.58% | 2.35 | 52.0% ; Got in (INSIDE_APP, payment not stated) | 69 | 16.47% | 3.87 | 15.9% ; Stated they paid (PAID_EXPLICIT) | 13 | 3.10% | 1.85 | 76.9% — access more than doubles satisfaction (2.35 → 3.87, +1.52 stars) and stating that you paid halves it again (3.87 → 1.85): of 13 who say they paid, 10 gave 1★ and 6 are billing disputes (segment rate on n=13); INSIDE_APP segment profile n=69 (16.47%) mean 3.87 · 11×1★, 4×2★, 3×3★, 16×4★, 35×5★ · 1★ share 15.9% vs 52.0% never-got-in

- **Where:** Warning 2; §0.3 table (verbatim); §3.4 P2; §4 intro
- **This app does:** hard paywall before any use
- **User reaction:** mixed
- **Magnitude:** 346 (82.58%) never in @ 2.35; 69 (16.47%) in @ 3.87; 13 (3.10%) paid @ 1.85
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `13753463291`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work; C147 Let people use the product before they pay

### R64-016 — Reported outcomes are the highest-rated themes: OUT_FITNESS 12 (2.86%, meaningful, mean 4.92 — highest of any theme, 11×5★, all inside the app): 'It helped me lost 50 pound' (fr); 'i'm in shape now because of this app' (za); OUT_CONFIDENCE 8 (1.91%, mean 4.75): 'you go from not talking to anyone to talking to everyone' (za, 5★, strongest testimonial); outcomes 5× higher in volume markets (11.4% vs 2.2%); R4: lead with what works — outcomes (4.92) and gamification (4.00) outperform the AI layer (2.17) among users

- **Where:** §3.4 P3, P4; §4.1; §7.3; §9.3 R4
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** OUT_FITNESS 12 mean 4.92; OUT_CONFIDENCE 8 mean 4.75
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `14031991184`, `13604435482`, `13592255544`, `14011021304`, `13951827022`
- **Canonical:** C067 Fitness / health tracking use case; C134 Lead the store listing with what users actually love

### R64-017 — Personalisation depth as a hook: PERSONALIZE 5 (1.19%, meaningful, mean 4.40) — one reviewer praises the onboarding analysis and then refuses to pay: 'the personalisation is doing its job as a hook'

- **Where:** §3.4 P7; §3.1 PERSONALIZE
- **This app does:** onboarding analysis free as hook
- **User reaction:** blocked-conversion
- **Magnitude:** 5 (1.19%) mean 4.40
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `13175983080`, `12829279421`, `13931368627`
- **Canonical:** C185 Aesthetic and a polished onboarding convert; they do not retain

### R64-019 — The most valuable single review: a 5★ attached to a long, mostly critical teardown by a reviewer who paid 30€/yr on sale (list 8€/week) — weekly regeneration, undeletable future tasks, broken push-ups-to-unlock, all-or-nothing focus mode — ending 'I bought it for 30 euros for a year in sale, worth? Depends, for the AI plan? No. For speaking coaching and challenges to improve overall? Yes.' — 'the sharpest strategic statement in this corpus', consistent with AI being the weakest layer and outcomes / gamification the strongest

- **Where:** §4.4; §6.1 row; §9.3 R4
- **This app does:** paid on sale
- **User reaction:** mixed
- **Magnitude:** 1 review, 5★
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Review IDs:** `13580337718`
- **Canonical:** C056 Don't build AI features on demand grounds; C166 Keep the therapeutic core in front of the game layer; C282 A generated plan belongs to the user — it persists, every assigned task can be deleted, declined and reordered, and it is built around the user's fixed commitments

### R64-024 — Scam / greed accusation — PAY_SCAM 21 (5.01%, high-priority, mean 1.05; every one 1★ but one) is the reputational tail of the paywall mechanics; the trust union is 58 (13.84%, mean 1.28) — SCAM ∪ BAIT ∪ PRIVACY ∪ AISLOP ∪ BOTS ∪ MANIP — and trust is an upgrade barrier: 'don't put your email in this app' warned independently by two German reviewers three months apart; bot-review suspicion

- **Where:** §3.3 N7; §3.3 N12; §6.3 trust
- **This app does:** hard paywall + exit discounts
- **User reaction:** 1★-burst
- **Magnitude:** SCAM 21 (5.01%) 1.05; trust union 58 (13.84%) 1.28
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `12557945275`, `12764614931`, `13480187297`, `14096008647`, `13738694827`, `14044788188`, `13443337238`
- **Canonical:** C085 Address tracking / privacy visibly; C113 One stable, disclosed price — no discount wheels

### R64-031 — Ratings are bimodal (46.54% 1★, 26.97% 5★, 26.48% middle) — 'the signature of a product where the experience is binary — you are either inside it or you are not' (verbatim): Rating | n | % of 419 | Dominant explanation ; 1★ | 195 | 46.54% | Blocked at the paywall (66.7% of the band) ; 2★ | 42 | 10.02% | Same cause, softer language ; 3★ | 35 | 8.35% | "Good app, wrong price" — the most consistently *positive-about-the-product* negative band ; 4★ | 34 | 8.11% | People who got in; feature requests and small defects ; 5★ | 113 | 26.97% | Split three ways: real advocates, pre-use ratings, and protest votes — 1★ (verbatim): Theme | n | % of 1★ band ; PAY_HARDWALL | 87 | 44.6% ; PAY_PRICE | 59 | 30.3% ; PAY_FREEREQ | 40 | 20.5% ; PAY_SOFTLOCK | 26 | 13.3% ; PAY_BAIT | 25 | 12.8% ; INFLUENCER | 21 | 10.8% ; PAY_TRIAL | 20 | 10.3% ; PAY_SCAM | 20 | 10.3% ; PAY_QUIZWALL | 17 | 8.7% — 130 of 195 1★ (66.7%) are blocked at the paywall and only 11 (5.6%) come from inside: 'The one-star problem is an acquisition problem, not a quality problem' — commercially good news, the 1★ population has not tried the product; 2★ holds the most useful paying critics and a 2★ that defends the price ('it is reasonable since how else would they get a profit besides annoying ads?')

- **Where:** Part 5 table (verbatim); §5.1 table (verbatim); §5.2
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 1★ 195 (46.54%); 130/195 blocked; 11 inside
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `14252106354`, `14255073330`, `14493510323`, `14452220984`, `14047068138`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C147 Let people use the product before they pay

### R64-037 — What triggers a purchase: only three first-person accounts in 419 — a deep discount ($2/month special discount; 75% off annual; 30€ on sale vs 8€/week list) and creator trust ('I've watched a lot of Pierre Dalati, and his app is very high quality… it is a good investment'); no reviewer says they paid because of a specific feature — 'the product is currently sold on price anchoring and creator trust, not on value demonstration', a direct consequence of there being no free experience

- **Where:** §6.2
- **This app does:** hard paywall
- **User reaction:** purchase-driver
- **Magnitude:** 3 of 419 purchase-trigger accounts; 0 feature-driven
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `13945409581`, `14233567561`, `13580337718`, `14275066962`
- **Canonical:** C180 No 'wait, don't go' exit discounts or countdown timers on the paywall; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R64-039 — Who defends the price — PAY_DEFEND 11 (2.63%, meaningful, mean 4.55): 'This is basically a personal trainer that you can talk to at all times, and $40 bucks a year is a steal. A human trainer could cost as much as $40 a week!'; 'way cheaper than others'; a 2★ on business legitimacy; a 5★ correcting others that 'cancel anytime' means charged upfront but not renewed; nine of eleven 5★ and eight inside — 'Nobody defends the price from outside the paywall — which is the whole argument for a free tier in one sentence'; 9 of 11 in P4, a new behaviour on the listing

- **Where:** §6.4; §8.4 price defence
- **This app does:** ~$40/yr
- **User reaction:** praise
- **Magnitude:** 11 (2.63%) 4.55; 9/11 in P4
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `14391271895`, `14277884922`, `14047068138`, `14364538522`, `14208933476`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C147 Let people use the product before they pay

## Audiences

### R64-011 — The audience is younger than the price assumes: PAY_MINOR 20 (4.77%, very strong, mean 1.90) state they are minors or argue the price fails teens — self-stated ages 12 (13947967990), 13 (four), 14 (four), 15 (two); a parent buying for a 12-year-old asks for a refund; a 4★ fan: 'everyone on it seems to be like 12-15 years old which is kind of weird'; two paying adults: 'a cheaper version for people below 18' and 'I understand his main audience is teens, who will have trouble paying for this'; a ~$40/yr annual-upfront subscription needs a payment instrument much of the creator audience does not control; the most-upvoted review (13552586437, 9 votes) asks for an adult tier and a free teen tier; 13 of 20 are US (7.2% of US), every self-stated age under 14 is US; M6: price for the actual audience (experiment); research #6: what share of installs are under 13 — 'a compliance question as much as a pricing one'

- **Where:** §0.5; §3.1 PAY_MINOR; §7.2 obs 3; §9.2 M6; §9.4 #6; part 9 #6
- **This app does:** annual upfront ~$40 aimed at a teen audience
- **User reaction:** blocked-conversion
- **Magnitude:** 20 (4.77%) mean 1.90; top review 9 votes
- **Direction for us:** research · **Report confidence:** very strong · **Generalisable:** generalisable
- **Side effects:** minors + under-13 = compliance exposure
- **Review IDs:** `13552586437`, `13947967990`, `12608609019`, `14290822522`, `13975991354`, `14045355654`, `14391271895`
- **Canonical:** C092 Regional pricing; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C238 A rewarded-ad unlock path for users who cannot pay (teens, students)

### R64-044 — Onboarding inclusivity: 'the quiz questions are clearly directed toward men, and didn't have a nothing option' (au, 3★, QUIZ_BIAS 1, 0.24%, weak) — the only review addressing it, consistent with the male-coded framing throughout ('looksmax', physique, 'made me more into a man'); no reviewer complains about missing localisation or mistranslation across 22 non-English reviews

- **Where:** §7.6 QUIZ_BIAS
- **This app does:** male-coded quiz, no 'nothing' option
- **User reaction:** complaint
- **Magnitude:** 1 (0.24%) weak
- **Direction for us:** research · **Report confidence:** weak signal · **Generalisable:** generalisable
- **Review IDs:** `12737087659`
- **Canonical:** C184 Gendered branding narrows the audience; a neutral name is already tested

## Markets and languages

### R64-041 — Only the US (180, 42.96%, mean 2.66) clears 50 (verbatim): Storefront | Written reviews | % of corpus | Written mean | Status ; United States | 180 | 42.96% | 2.66 | Eligible — analysed standalone (§7.2) ; United Kingdom | 40 | 9.55% | 2.45 | [limited evidence] ; Canada | 28 | 6.68% | 2.21 | [limited evidence] ; Australia | 26 | 6.21% | 2.73 | [limited evidence] ; Germany | 14 | 3.34% | 2.14 | [limited evidence] ; UAE | 10 | 2.39% | 2.50 | [limited evidence] ; Norway 7 · Denmark 6 · Italy 6 · Netherlands 6 · Sweden 6 · Czechia 5 · France 5 | ≤7 each | — | 1.67–2.43 | [limited evidence] ; 44 further storefronts | 1–4 each | 15.51% | — | Included in all global figures; no standalone claims — US (verbatim): Theme | n | % of US 180 | vs global % | Band (US denominator) ; PAY_PRICE | 54 | 30.0% | 25.06% | High-priority ; PAY_HARDWALL | 53 | 29.4% | 28.40% | High-priority ; INSIDE_APP | 40 | 22.2% | 16.47% | High-priority ; PRAISE_GEN | 30 | 16.7% | 15.99% | High-priority ; PAY_FREEREQ | 25 | 13.9% | 15.75% | High-priority ; INFLUENCER | 17 | 9.4% | 10.02% | High-priority ; PAY_BAIT | 13 | 7.2% | 7.16% | High-priority ; PAY_MINOR | 13 | 7.2% | 4.77% | High-priority ; PAY_SOFTLOCK | 13 | 7.2% | 9.31% | High-priority ; PAY_DEFEND | 9 | 5.0% | 2.63% | High-priority ; FEAT_FOCUS | 9 | 5.0% | 2.39% | High-priority ; FEAT_AI | 9 | 5.0% | 4.30% | High-priority — US 85×1★ (47.2%) 54×5★ (30.0%), public 9,557 @ 4.73 (1.9% coverage); four US observations: price displaces access as the top complaint only in the US (30.0% vs 29.4%; GB 40.0% hardwall vs 20.0% price) — US argues the amount, the rest the existence of the wall; the US is where people get in (INSIDE_APP 22.2% vs 11.5% rest, 1.9×; all but two PAY_DEFEND; 9 of 11 FEAT_FOCUS) — 'The product's real user base… is overwhelmingly American'; minors disproportionately US (13 of 20); US carries both tails (43.6% of 1★, 47.8% of 5★)

- **Where:** §7.1 table (verbatim); §7.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** US 180 @ 2.66; price 30.0%; inside 22.2%
- **Direction for us:** none · **Report confidence:** high-priority (US only) · **Generalisable:** generalisable
- **Review IDs:** `13552586437`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R64-042 — High-spend markets defined from Tools/habit_apps_ranked.json market_tier (verbatim): Group | Storefronts in corpus | n | % of 419 | Mean ★ | 1★ share | 5★ share ; rich (high-spend) | us gb ca au de ae no dk it nl se fr be ch es ie sg sa il at fi jp kr | 357 | 85.20% | 2.53 | 47.9% | 25.2% ; volume (high-volume, lower ARPU) | in ph pl cz hu gr eg za ng th mx pk ro tr ua my id cl | 35 | 8.35% | 2.91 | 34.3% | 37.1% ; Untiered (absent from snapshot) | al ao az br co cr ge gh gt ke kw lt lv mn rs si tn vn xk zw | 27 | 6.44% | 2.96 | 44.4% | 37.0% || Theme | rich (357) | volume (35) ; PAY_HARDWALL | 30.3% | 20.0% ; PAY_PRICE | 26.1% | 20.0% ; PAY_FREEREQ | 14.3% | 20.0% ; INSIDE_APP | 16.5% | 20.0% ; PAY_SOFTLOCK | 9.5% | 2.9% ; PAY_BAIT | 7.6% | 2.9% ; OUT_FITNESS | 2.2% | 11.4% — friction is in high-spend markets (rich 2.53 / 47.9% 1★ vs volume 2.91 / 34.3%) — the opposite of the usual pattern, consistent with the paywall tracking the creator's audience; softlock almost entirely rich-market (9.5% vs 2.9%, possibly noise); in volume markets the ask shifts to 'make it free' (20.0% vs 14.3%) and outcomes are 5× higher (11.4% vs 2.2%; SA, PH, EG, MX) [limited evidence]; review-volume markets (verbatim): | Top-5 (288) | Rest of world, 52 storefronts (131) ; Mean ★ | 2.57 | 2.64 ; PAY_HARDWALL | 29.9% | 25.2% ; PAY_PRICE | 26.0% | 22.9% ; PAY_FREEREQ | 13.2% | 21.4% ; INSIDE_APP | 18.8% | 11.5% ; PAY_SOFTLOCK | 8.7% | 10.7% ; LOWINFO | 4.9% | 9.2% — top-5 and long tail more alike than different; rank note: 48th in the US (worst of 46) while the US supplies 43% of written reviews and 51% of public ratings; best ranks Greece 14, Austria/Belgium/Israel/South Africa 16

- **Where:** §7.3 tables (verbatim); §7.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** rich 357 @ 2.53; volume 35 @ 2.91
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `13604435482`, `13945755506`, `13951827022`, `13696065285`, `13491083766`, `13962435242`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R64-043 — Per-storefront written vs public (verbatim): CC | Written | Written mean | Public ratings | Public avg | Gap | Written coverage ; us | 180 | 2.66 | 9,557 | 4.73 | −2.07 | 1.9% ; gb | 40 | 2.45 | 1,443 | 4.61 | −2.16 | 2.8% ; ca | 28 | 2.21 | 1,421 | 4.65 | −2.44 | 2.0% ; au | 26 | 2.73 | 700 | 4.57 | −1.84 | 3.7% ; de | 14 | 2.14 | 550 | 4.59 | −2.45 | 2.5% ; ae | 10 | 2.50 | 151 | 4.61 | −2.11 | 6.6% ; no | 7 | 2.43 | 205 | 4.62 | −2.19 | 3.4% ; dk | 6 | 2.33 | 211 | 4.60 | −2.27 | 2.8% ; it | 6 | 1.83 | 150 | 4.61 | −2.78 | 4.0% ; nl | 6 | 2.00 | 288 | 4.53 | −2.53 | 2.1% ; se | 6 | 1.67 | 268 | 4.59 | −2.92 | 2.2% ; cz | 5 | 2.40 | 132 | 4.64 | −2.24 | 3.8% ; fr | 5 | 2.00 | 140 | 4.56 | −2.56 | 3.6% — the gap never falls below 1.84 stars in any storefront: 'a property of the rating mechanism, not of any market'

- **Where:** §7.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** gap −1.84 to −2.92
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `14032722731`
- **Canonical:** C150 Never ask for a rating before the user has used the app; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

## Dated events and trends

### R64-045 — The arc — recovery, then reversal: periods (verbatim) Period | Window | n | Mean ★ | 1★ share | 5★ share ; P1 — launch | 4 Apr 2025 → 31 Aug 2025 | 77 | 2.04 | 59.7% | 13.0% ; P2 | 1 Sep 2025 → 31 Jan 2026 | 114 | 2.78 | 43.0% | 31.6% ; P3 | 1 Feb 2026 → 31 May 2026 | 125 | 2.98 | 38.4% | 37.6% ; P4 — recent | 1 Jun 2026 → 4 Sep 2026 | 103 | 2.32 | 50.5% | 19.4% — mean 2.04 → 2.78 → 2.98 → 2.32; what improved (verbatim) Theme | P1 | P2 | P3 | P4 | Reading ; PAY_HARDWALL | 42.9% | 26.3% | 23.2% | 26.2% | Sustained fall from launch, then flat ; PAY_SOFTLOCK | 16.9% | 8.8% | 7.2% | 6.8% | Halved and stayed halved — the clearest improvement in the corpus ; INSIDE_APP | 5.2% | 15.8% | 19.2% | 22.3% | Monotonic rise — more reviewers are getting into the product every period ; 1★ share | 59.7% | 43.0% | 38.4% | 50.5% | Improved, then reversed — PAY_SOFTLOCK 16.9% → 8.8% → 7.2% → 6.8% (13 → 10 → 9 → 7) halved and stayed halved, 'something was improved in paywall dismissal after the launch quarter. It was not fixed' (−60%); INSIDE_APP 5.2% → 15.8% → 19.2% → 22.3% monotonic — 'the shape of a maturing user base'; what got worse P3 → P4 (verbatim) Theme | P3 | P4 | Change ; PAY_PRICE | 19.2% | 34.0% | +14.8 points — the largest single-theme swing in the corpus ; PAY_FREEREQ | 13.6% | 20.4% | +6.8 ; PAY_QUIZWALL | 3.2% | 8.7% | +5.5 ; PAY_DEFEND | 0.8% | 8.7% | +7.9 ; 5★ share | 37.6% | 19.4% | −18.2 — 'a price story, not a quality story': three readings (price rise or trial withdrawal; audience widening past willingness-to-pay; a visible public argument about price) not separable without pricing history (research #3); not supported: any release claim, reliability trend, seasonality, 'softlock fixed'

- **Where:** §8.1 table (verbatim); §8.2 tables (verbatim); §8.5; §9.4 #3; part 9 #3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** mean 2.04/2.78/2.98/2.32; PAY_PRICE 19.2% → 34.0% (+14.8); 5★ 37.6% → 19.4%
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `14317192032`, `14233984114`, `14274686879`, `14284939336`, `13525806908`, `14286509974`, `14451479544`
- **Canonical:** C063 Free trial before purchase; C064 Price level — where 'fair' turns into 'too expensive'; C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R64-046 — Persistent themes across all four periods (verbatim): Theme | P1 | P2 | P3 | P4 | Verdict ; PAY_BAIT | 6.5% | 8.8% | 5.6% | 7.8% | Persistent. 17 months of people arriving expecting free. Never addressed. ; PAY_TRIAL | 7.8% | 6.1% | 5.6% | 5.8% | Persistent. ; INFLUENCER | 6.5% | 14.0% | 10.4% | 7.8% | Peaks in P2 (the app's most visible period), never disappears ; PAY_FREEREQ | 13.0% | 15.8% | 13.6% | 20.4% | Persistent and rising — PAY_BAIT is the most important persistent theme, entirely under the developer's control through listing copy and creator briefing; emerging: AI-quality and focus-mode failure reports are late (7 of 8 AI_QUALITY from Feb 2026; 5 of 6 FOCUS_BROKEN from 2026) — more users, more feature-level scrutiny; PAY_DEFEND almost entirely P4 (9 of 11)

- **Where:** §8.3 table (verbatim); §8.4
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** BAIT 6.5/8.8/5.6/7.8%; FREEREQ 13.0/15.8/13.6/20.4%
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `14016792944`, `14117563141`, `14252106354`, `14262652548`, `14315502915`
- **Canonical:** C279 An AI analysis must consume its input — reject empty, silent or black input instead of returning a confident score; C280 An app-blocking focus mode must always unlock when its condition is met, never lock apps permanently, never override OS Screen Time, and never depend on a notification the OS can suppress; C281 Brief every creator and acquisition channel to state the price — an audience told 'it's free' converts marketing spend into permanent 1★

## Positioning

### R64-001 — Critique AI: Habit Tracker (App Store ID 6743095634; subtitle 'Routine Builder & AI Coach') by With Bytes LLC (com.withbytes.critique-ai) — a creator-launched (Pierre Dalati) AI self-improvement app bundling a habit / routine tracker with AI analysis of physique, face, outfit, meals and speech, a screen-time blocker (focus mode) and a social layer; hard paywall, no free tier; 419 reviews (every one read), 57 storefronts, 4 Apr 2025 → 4 Sep 2026 (17 months), written mean 2.589 (113×5★, 34×4★, 35×3★, 42×2★, 195×1★); store context from Tools/habit_apps_ranked.json only (Apple lookup blocked): 18,785 public ratings at 4.68, ranked in 46 storefronts, best rank 14, median 23, audience 'moderate'

- **Where:** header lines 1-8
- **This app does:** hard paywall; AI coach + tracker + focus mode + community, all paid
- **User reaction:** mixed
- **Magnitude:** 419 reviews; mean 2.589; 18,785 public ratings @ 4.68
- **Direction for us:** none · **Report confidence:** header · **Generalisable:** app-specific
- **Review IDs:** `14359992073`
- **Canonical:** C281 Brief every creator and acquisition channel to state the price — an audience told 'it's free' converts marketing spend into permanent 1★

### R64-028 — Reviewers name substitutes — ALT_TOOL 13 (3.10%, very strong, mean 1.92): ChatGPT (also Grok, Gemini) for the AI half; Apple Notes, Google Sheets, Google Calendar for the tracker half; Clearspace as a free focus-mode substitute; Duolingo as the freemium model to copy; 'I lost 40 dollars on something I could've just done on the notes app' — 'the substitute named for the AI half is a general-purpose LLM; the substitute named for the tracker half is a free note or spreadsheet app. Nobody names a competing self-improvement app'

- **Where:** §3.3 N13; §6.3
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 13 (3.10%) 1.92
- **Direction for us:** none · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `13279976831`, `13381524821`, `14398136616`, `13828891038`, `14198628636`, `13904718444`, `12974617060`, `13567016106`, `14327391653`
- **Canonical:** C005 Know which competitors buyers compare against; C056 Don't build AI features on demand grounds; C214 A bare checklist or task-slot paywall cannot carry a premium price — it is compared to Reminders, Notes, alarms and paper, free on every phone, and loses; C280 An app-blocking focus mode must always unlock when its condition is met, never lock apps permanently, never override OS Screen Time, and never depend on a notification the OS can suppress

## Anti-patterns

### R64-005 — The paywall is the product, as far as this corpus is concerned: 166 of 419 (39.62%, high-priority, mean 1.52) are stopped by the paywall — five separable mechanics with different fixes (verbatim): Mechanic | Code | n | % of 419 | Band | Mean ★ | What it is ; No free use at all | PAY_HARDWALL | 119 | 28.40% | High-priority | 1.48 | "You cannot use the app without paying" ; Paywall won't close | PAY_SOFTLOCK | 39 | 9.31% | High-priority | 1.72 | No X / cancel / skip; returns on relaunch ; Believed it was free | PAY_BAIT | 30 | 7.16% | High-priority | 1.23 | Told free by creator, friend, or listing ; Quiz/photo taken first | PAY_QUIZWALL | 23 | 5.49% | High-priority | 1.35 | Onboarding completed, *then* the wall ; A second paywall | PAY_2WALL | 8 | 1.91% | Meaningful | 1.25 | "One-time offer" after dismissing the first — PAY_HARDWALL 119 (28.40%, mean 1.48, 87 of 119 1★, all 57 storefronts, all 17 months): 'You can't use a single feature in the app if you don't pay… It's not like you have limited functionality you genuinely can't use any features' (us, 1★); a hard paywall is a pricing decision, a paywall that cannot be dismissed is a bug or dark pattern — 'the one that produces the angriest, lowest-rated reviews and the strongest legal exposure'; no free tier is described by anyone in 419 reviews

- **Where:** Warning 3; §0.1 tables (verbatim); §3.3 N1; §3.2
- **This app does:** hard paywall, no free tier
- **User reaction:** 1★-burst
- **Magnitude:** 166 (39.62%) mean 1.52; HARDWALL 119 (28.40%) 1.48; SOFTLOCK 39 (9.31%) 1.72; BAIT 30 (7.16%) 1.23; QUIZWALL 23 (5.49%) 1.35; 2WALL 8 (1.91%) 1.25
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `13166153326`, `12502528849`, `12620716476`, `13575204426`, `14461816545`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C147 Let people use the product before they pay; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R64-027 — 'The app is AI slop' — TRUST_AISLOP 4 (0.95%, emerging, mean 1.50) accuse the app itself of being AI-generated, one from inside the product having paid; TRUST_BOTS 2 (0.48%) suspect bot reviews; the community is 'priceless' to one and 'a probably fake community page' to another, with over-aggressive comment moderation (R5: loosen it)

- **Where:** §3.3 N12 AI slop; §3.5 community
- **This app does:** AI-branded app
- **User reaction:** complaint
- **Magnitude:** AISLOP 4 (0.95%) 1.50; BOTS 2; COMMUNITY 4 (0.95%) 3.75
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `13570161518`, `14315502915`, `14371635004`, `14237114665`, `14404327380`
- **Canonical:** C202 A light social layer that is explicitly not a social network; C267 No AI-generated art, copy or content in a paid product — reviewers accept an AI coach and reject AI decoration

## Things not to do

### R64-007 — The audience arrives believing the app is free, and that belief comes from the marketing channel: 42 (10.02%, high-priority, mean 2.38) name a creator, YouTube, TikTok or a friend (13 name Pierre Dalati); PAY_BAIT 30 (7.16%, high-priority, mean 1.23 — the lowest mean after PAY_SCAM, 25×1★ 3×2★ 2×3★ 0×4★ 0×5★): 'Ich wurde über Socialmedia angelockt. Das es kostenlos sei. Ist es nicht. Kompletter Clickbait.' (de); 'advertised on a YouTubers channel and he never mentioned anything about a paid subscription' (us); 'Say that in the videos. Just disrespectful.' (co); 'I needed to pay while it was free for my friends' (se) — 'the highest-leverage finding in the report that costs nothing to fix': the product is not mispriced, it is mis-expected; every PAY_BAIT reviewer was acquired at full marketing cost and converted into a permanent 1★; persistent 6.5% / 8.8% / 5.6% / 7.8% across four periods, the only major theme with no downward movement in 17 months and mean unmoved; M2: brief the acquisition channel to state the price

- **Where:** §0.2; §3.3 N4; §8.3; §9.2 M2; §9.5 #1
- **This app does:** creators promote without stating price
- **User reaction:** 1★-burst
- **Magnitude:** INFLUENCER 42 (10.02%) 2.38; PAY_BAIT 30 (7.16%) 1.23; P1–P4 6.5/8.8/5.6/7.8%
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Side effects:** M1 + M2 together address 53 reviews (12.65%) at combined mean 1.28
- **Review IDs:** `13443337238`, `14126245313`, `13600059562`, `14113188077`, `14072700352`, `14248303022`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C281 Brief every creator and acquisition channel to state the price — an audience told 'it's free' converts marketing spend into permanent 1★

### R64-008 — Quiz first, price second — PAY_QUIZWALL 23 (5.49%, high-priority, mean 1.35, 17×1★): reviewers completed a long survey, sometimes uploaded a physique photo and created an account, then saw the price — 'why the need to do a survey if it isn't free? couldn't it be mentioned before the survey?' (ch, 2★); '14234452764' (ng) objects to being asked for a photo before being told the price; M1: disclose the price before the onboarding quiz, or at minimum before the physique photo and account creation — 'Zero engineering cost, zero revenue cost'; P3→P4 3.2% → 8.7%

- **Where:** §3.3 N6; §9.2 M1; §9.5 #1
- **This app does:** long quiz + photo + account before paywall
- **User reaction:** 1★-burst
- **Magnitude:** 23 (5.49%) mean 1.35; P4 8.7%
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `14154949208`, `14234452764`, `12543124530`, `13398085653`, `14286509974`, `14395829020`
- **Canonical:** C085 Address tracking / privacy visibly; C111 No long quiz before the price; show the price up front

### R64-025 — Manipulative onboarding score framing — TRUST_MANIP 6 (1.43%, meaningful, mean 1.17): 'tells you that you are 27% less confident than the average even if you are 100% confident in your answers. I dislike companies that lie especially to manipulate others insecurities' (us); independently in Hebrew: 'I love myself and have confidence, and the app decided I don't have much confidence and I need to pay monthly to improve it' (il); R6: review the onboarding score's framing

- **Where:** §3.3 N12; §9.3 R6
- **This app does:** onboarding projection of deficiency
- **User reaction:** complaint
- **Magnitude:** 6 (1.43%) mean 1.17
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `13514592027`, `13553212455`, `13800895864`, `14147892220`, `14286509974`, `14032722731`
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C283 Never sell by telling the user they are deficient — an onboarding score that invents a shortfall reads as manipulation

### R64-053 — A 5★-for-removal pattern: when a hard paywall blocks a young audience, reviewers use 5★ as a message ('im only doing 5 star just for you to take the payment subscription away'), inflating the listing with ratings that are requests, not satisfaction — do not read public stars as product quality on a hard-paywalled app

- **Where:** §5.6; §1.7; Warning 6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 3 explicit of 11 CONTRA
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `13870793043`, `14003739567`, `14300908983`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

## Things to do

### R64-051 — State the price everywhere the user meets the product before the App Store does — in creator videos, in the listing, and before the onboarding quiz: 'Critique AI has a demand problem it has already solved and a conversion problem it has not — a creator-driven audience arrives in volume and wants the product, then hits a hard paywall with no free tier, no usable trial, and a dismiss button that a tenth of the corpus reports cannot be found'; the fix for mis-expectation is disclosure, not a price change

- **Where:** Part 0 executive summary in one line; §0.2 highest-leverage; §9.2 M1, M2
- **This app does:** price disclosed only at the paywall
- **User reaction:** 1★-burst
- **Magnitude:** BAIT 30 (7.16%) 1.23 + QUIZWALL 23 (5.49%) 1.35 = 53 (12.65%) @ 1.28
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `13600059562`, `14154949208`, `14072700352`
- **Canonical:** C111 No long quiz before the price; show the price up front; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C281 Brief every creator and acquisition channel to state the price — an audience told 'it's free' converts marketing spend into permanent 1★

## Contradictions

### R64-052 — Three places this corpus runs against the usual pattern: (1) high-spend ('rich') markets carry the friction — lower mean (2.53 vs 2.91) and higher 1★ share (47.9% vs 34.3%) than volume markets, because the paywall binds where the creator's audience is, not where money is scarce; (2) US reviewers argue the amount (PAY_PRICE 30.0% > HARDWALL 29.4%) while the rest of the world argues the existence of the wall (GB 40.0% vs 20.0%); (3) theme direction is not fixed by rating — PAY_PRICE spans 59×1★ … 7×5★, FEAT_FOCUS 2×1★ … 4×5★ (reason to buy and thing that breaks), PAY_DISCOUNT 5×1★ … 3×5★ (dark pattern to one, reason for purchase to another)

- **Where:** §7.2 obs 1; §7.3 finding 1; §5.7
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** rich 2.53 vs volume 2.91; US price 30.0% vs hardwall 29.4%
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `12557945275`, `13945409581`, `14233567561`, `14300908983`
- **Canonical:** C180 No 'wait, don't go' exit discounts or countdown timers on the paywall; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

## Data caveats and method

### R64-002 — Method and limits: signal bands (verbatim) Band | Label | Meaning ; < 0.1% | Ignore | Not promoted unless safety/legal/data-loss ; 0.1 – 0.5% | Weak signal | Recorded, cautious wording ; 0.5 – 1% | Emerging | Worth investigating ; 1 – 3% | Meaningful | Strong candidate ; 3 – 5% | Very strong | Should shape roadmap ; > 5% | High-priority | Strong problem or opportunity — themes non-exclusive (931 assignments, 2.2 per review); 47-code hand taxonomy, every review read in five sequential passes, no automated classifier; validated (419/419 classified, 0 unknown IDs/codes, rating distribution and mean 2.589 match manifest exactly); files (verbatim) File | Role | Records ; App Store Reviews/64. Critique AI - Habit Tracker - Routine Builder & AI Coach/reviews.jsonl | Primary corpus — every review read | 419 ; .../by_country/*.jsonl | 57 per-storefront files | 419 (reconciled, §1.4) ; .../manifest.json | Extraction metadata, per-country counts, rating distribution | — ; .../_state.json | Per-storefront crawl cursors and completeness flags | 65 storefronts polled ; Tools/habit_apps_ranked.json | Only external store-level data available (see §1.6) | —; coverage (verbatim) Check | Result ; Lines in reviews.jsonl | 419 ; Unique review_id | 419 (no duplicate IDs) ; Records classified in Temp/64-review-classification.py | 419 (100%) ; Classified IDs not present in the corpus | 0 ; Corpus records with no theme assigned | 0 ; Theme assignments total | 931 (2.22 per review) ; Unknown theme codes | 0 ; Intra-review duplicate themes | 0 ; Declared-but-unused theme codes | 0 ; Rows across all 57 by_country/*.jsonl | 419 ; IDs in country files but not in reviews.jsonl | 0 ; IDs in reviews.jsonl but not in country files | 0 ; Rating distribution vs manifest.json | exact match (5:113, 4:34, 3:35, 2:42, 1:195) ; Mean rating vs manifest.json (2.589) | exact match; no records removed — three 'Good'/'Good' reviews are distinct authors/storefronts/dates; is_edited false for all 419 (no 'updated after a fix' analysis); vote_count > 0 on 56 (13.37%), max 9; itunes.apple.com blocked so every price, SKU, trial length and feature name is reconstructed from review text; only the US (180) clears 50 — GB 40, CA 28, AU 26, DE 14 are [limited evidence]; 22 non-English reviews (5.25%, mean 2.00: 6 German, 5 Italian, 2 Norwegian, 2 Hebrew, 1 each Korean, Dutch, es-MX, es-ES, es-GT, es-CR, Czech-mixed) read in original; no burst — busiest day 6 reviews (2025-11-24, 2026-01-05) over 275 distinct days, no day > 1.4%; no version field (one 'after the update' 13874326932 unanchored); no developer responses; the same year appears as $40, £40, £24, 40€, 44€, 45€, $39.99, $45, $50, $60, $100, $192, $200 and ₦69,900 — modal ~$40/yr named in 29 reviews (6.92%) used as reference

- **Where:** How to read this table (verbatim); Eight warnings 1–8; §1.1 table (verbatim); §1.2; §1.3 table (verbatim); §1.4; §1.5; §1.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 419 read; 1 eligible storefront; 2.23% coverage
- **Direction for us:** research · **Report confidence:** method · **Generalisable:** generalisable
- **Review IDs:** `13283129495`, `13436840309`, `13634194777`, `13874326932`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R64-003 — The 2.09-star gap is structural, and one review explains it: 419 written @ 2.589 vs 18,785 public @ 4.68 (2.23% coverage) — roughly double other reports' gap and stable in every storefront (verbatim): | Written corpus | Public ratings | Gap ; Global | 419 @ 2.589 | 18,785 @ 4.68 | −2.09 ; US | 180 @ 2.66 | 9,557 @ 4.73 | −2.07 ; GB | 40 @ 2.45 | 1,443 @ 4.61 | −2.16 ; CA | 28 @ 2.21 | 1,421 @ 4.65 | −2.44 ; AU | 26 @ 2.73 | 700 @ 4.57 | −1.84 ; DE | 14 @ 2.14 | 550 @ 4.59 | −2.45 ; SE | 6 @ 1.67 | 268 @ 4.59 | −2.92 — '14032722731' (us, 1★, 6 May 2026): 'it got me to rate it before it charged me money so I gave it a 5 thinking that it was free because I am 13 and broke' — if the in-app rating prompt fires during onboarding before the paywall, the public base is substantially pre-experience ratings; corroborated by 20 explicitly pre-use reviews (4.77%, mean 4.65 — 'I like it so far. If it has a subscription I'm uninstalling', 5★), 26 content-free (6.21%, mean 4.42, 20 of them 5★) and 11 contradicting their star (2.63%, 10 of them 5★) — together 57 (13.60%, mean 4.54) ratings without product experience; consequence: the public 4.68 must not be cited as satisfaction and the written 2.589 not as quality — 'among people motivated enough to write, 39.62% describe being unable to get in, and among the 16.47% who got in, the mean is 3.87'; research question #1: does the prompt fire before the paywall — 'answerable in ten minutes from the codebase, and it changes how every dashboard in the business should be read'

- **Where:** Warning 1; §1.7 table (verbatim); §9.4 #1; part 9 #1
- **This app does:** rating prompt apparently fires before the paywall
- **User reaction:** mixed
- **Magnitude:** −2.09 stars; gap ≥ 1.84 in every storefront; 57 (13.60%, mean 4.54) no-experience ratings
- **Direction for us:** dont · **Report confidence:** very strong / research · **Generalisable:** generalisable
- **Review IDs:** `14032722731`, `13965811431`, `13824995999`, `14467750032`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R64-032 — 4★ (verbatim): Theme | n | % of 4★ band ; INSIDE_APP | 16 | 47.1% ; PRAISE_GEN | 12 | 35.3% ; PAY_PRICE | 8 | 23.5% ; PAY_FREEREQ | 5 | 14.7% ; BUG_FEATURE | 4 | 11.8% ; PAY_SOFTLOCK | 4 | 11.8% — nearly half users who got in; as in report 62's corpus, a defect-and-request list with a rating attached (workout location won't change, focus mode, calorie tracker, schedule around commitments, delete chats, recording buffers, ads while paying); two 4★ trapped on the paywall asking for help; 5★ (verbatim): Theme | n | % of 5★ band ; PRAISE_GEN | 49 | 43.4% ; INSIDE_APP | 35 | 31.0% ; LOWINFO | 20 | 17.7% ; PRE_USE | 15 | 13.3% ; OUT_FITNESS | 11 | 9.7% ; CONTRA | 10 | 8.8% ; PAY_DEFEND | 9 | 8.0% — three populations not to be averaged: real advocates 68 (16.23% of corpus, 60.2% of band), pre-use and content-free 35, protest / transactional 10; 45 of 113 5★ (39.8%) are not a product endorsement

- **Where:** §5.4 table (verbatim); §5.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 4★ 34 (47.1% inside); 5★ 113, 45 non-endorsing (39.8%)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `12616930375`, `12972513399`, `13189680191`, `14203012041`, `14262652548`, `14436616950`, `13965811431`
- **Canonical:** C021 Apple Health integration; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C282 A generated plan belongs to the user — it persists, every assigned task can be deleted, declined and reordered, and it is built around the user's fixed commitments

### R64-033 — The 11 contradicting reviews — CONTRA 11 (2.63%, meaningful, mean 4.64), ten 5★ (verbatim): Review ID | CC | ★ | The contradiction ; 13824995999 | us | 5 | Entire body: *"It doesn't let me use the app without paying"* ; 13657837093 | us | 5 | Entire body: *"It won't let me in"* ; 14467750032 | us | 5 | *"i created a acct and it wants me to purchase a package what should i do"* ; 13856509758 | us | 5 | *"Can pls make it free"* ; 13870793043 | au | 5 | Explicitly transactional: *"im only doing 5 star just for you to take the payment subscription away pleaseeee"* ; 14003739567 | us | 5 | Explicitly gaming visibility: *"I don't think any one is gonna pay 40$ just to check off a list I only gave 5 stars so you can see this"* ; 14300908983 | us | 5 | Explicitly creator loyalty: *"i'm rating this 5 stars because i support your content bro but just please, please lower that price"* ; 13598299062 | gb | 5 | *"you have to pay so I deleted it but I thought about how good it was"* ; 13815342660 | us | 5 | *"the most useful app in your life"* + *"there is no X button or cancel"* ; 13580337718 | nl | 5 | 5★ on a paid, mostly negative teardown (§4.4) ; 13626787196 | us | 1 | The inverse: *"It's great honestly and is great for improving yourself"* rated 1★ over the lack of a free tier — three say outright the star is a message to the developer: 'im only doing 5 star just for you to take the payment subscription away pleaseeee'; 'I only gave 5 stars so you can see this'; 'i'm rating this 5 stars because i support your content bro but just please, please lower that price' — the star rating is being used as a lobbying instrument about price, further undermining the public 4.68 as satisfaction; kept, not dropped

- **Where:** Warnings 6, 7; §5.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 11 (2.63%); 10 are 5★; 3 explicit lobbying
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `13870793043`, `14003739567`, `14300908983`, `13824995999`, `13657837093`, `13626787196`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R64-049 — Complete global theme table (verbatim): Theme | n | % of 419 | Band | Mean ★ | 1/2/3/4/5 ; PAY_HARDWALL | 119 | 28.40% | High-priority | 1.48 | 87/15/12/2/3 ; PAY_PRICE | 105 | 25.06% | High-priority | 1.94 | 59/15/16/8/7 ; INSIDE_APP | 69 | 16.47% | High-priority | 3.87 | 11/4/3/16/35 ; PRAISE_GEN | 67 | 15.99% | High-priority | 4.54 | 3/1/2/12/49 ; PAY_FREEREQ | 66 | 15.75% | High-priority | 1.82 | 40/9/9/5/3 ; INFLUENCER | 42 | 10.02% | High-priority | 2.38 | 21/4/6/2/9 ; PAY_SOFTLOCK | 39 | 9.31% | High-priority | 1.72 | 26/6/1/4/2 ; PAY_BAIT | 30 | 7.16% | High-priority | 1.23 | 25/3/2/0/0 ; PAY_TRIAL | 26 | 6.21% | High-priority | 1.58 | 20/1/3/0/2 ; LOWINFO | 26 | 6.21% | High-priority | 4.42 | 3/0/0/3/20 ; PAY_QUIZWALL | 23 | 5.49% | High-priority | 1.35 | 17/4/2/0/0 ; PAY_SCAM | 21 | 5.01% | High-priority | 1.05 | 20/1/0/0/0 ; PAY_TIERS | 21 | 5.01% | High-priority | 1.48 | 15/2/4/0/0 ; PRE_USE | 20 | 4.77% | Very strong | 4.65 | 0/0/2/3/15 ; PAY_MINOR | 20 | 4.77% | Very strong | 1.90 | 11/3/4/1/1 ; FEAT_AI | 18 | 4.30% | Very strong | 2.17 | 11/1/1/2/3 ; ALT_TOOL | 13 | 3.10% | Very strong | 1.92 | 7/3/1/1/1 ; PAID_EXPLICIT | 13 | 3.10% | Very strong | 1.85 | 10/0/0/1/2 ; PAY_ADS_OK | 12 | 2.86% | Meaningful | 1.58 | 7/3/2/0/0 ; OUT_FITNESS | 12 | 2.86% | Meaningful | 4.92 | 0/0/0/1/11 ; PAY_DEFEND | 11 | 2.63% | Meaningful | 4.55 | 0/1/1/0/9 ; CONTRA | 11 | 2.63% | Meaningful | 4.64 | 1/0/0/0/10 ; FEAT_FOCUS | 10 | 2.39% | Meaningful | 3.40 | 2/2/0/2/4 ; FEAT_TRACK | 10 | 2.39% | Meaningful | 4.20 | 0/1/1/3/5 ; PAY_DISCOUNT | 9 | 2.15% | Meaningful | 2.44 | 5/1/0/0/3 ; BUG_FEATURE | 9 | 2.15% | Meaningful | 3.22 | 3/0/0/4/2 ; PLAN_RIGID | 9 | 2.15% | Meaningful | 2.00 | 5/2/0/1/1 ; PAY_2WALL | 8 | 1.91% | Meaningful | 1.25 | 6/2/0/0/0 ; AI_QUALITY | 8 | 1.91% | Meaningful | 2.00 | 4/1/2/1/0 ; PAY_BILLING | 8 | 1.91% | Meaningful | 1.50 | 7/0/0/0/1 ; REQ_FEATURE | 8 | 1.91% | Meaningful | 3.50 | 1/1/1/3/2 ; OUT_CONFIDENCE | 8 | 1.91% | Meaningful | 4.75 | 0/0/1/0/7 ; FEAT_GAMIFY | 8 | 1.91% | Meaningful | 4.00 | 1/1/0/1/5 ; BUG_CRASH | 7 | 1.67% | Meaningful | 1.57 | 5/0/2/0/0 ; FOCUS_BROKEN | 6 | 1.43% | Meaningful | 3.50 | 1/1/0/2/2 ; TRUST_MANIP | 6 | 1.43% | Meaningful | 1.17 | 5/1/0/0/0 ; PERSONALIZE | 5 | 1.19% | Meaningful | 4.40 | 0/1/0/0/4 ; TRUST_PRIVACY | 5 | 1.19% | Meaningful | 1.20 | 4/1/0/0/0 ; TRUST_AISLOP | 4 | 0.95% | Emerging | 1.50 | 3/0/1/0/0 ; FEAT_COMMUNITY | 4 | 0.95% | Emerging | 3.75 | 1/0/0/1/2 ; ACCT_LOGIN | 3 | 0.72% | Emerging | 1.00 | 3/0/0/0/0 ; BUG_UI | 3 | 0.72% | Emerging | 2.33 | 0/2/1/0/0 ; SUPPORT_BAD | 3 | 0.72% | Emerging | 1.00 | 3/0/0/0/0 ; TRUST_BOTS | 2 | 0.48% | Weak | 3.00 | 1/0/0/0/1 ; PAY_RESTORE | 2 | 0.48% | Weak | 1.00 | 2/0/0/0/0 ; QUIZ_BIAS | 1 | 0.24% | Weak | 3.00 | 0/0/1/0/0 ; ADS_PAID | 1 | 0.24% | Weak | 4.00 | 0/0/0/1/0 — PRAISE_GEN 67 (15.99%, 4.54) is large but low-information by construction; LOWINFO 26 (6.21%, 4.42); PRE_USE 20 (4.77%, 4.65)

- **Where:** §3.1 table (verbatim); §3.4 P1
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 47 codes, 931 assignments
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `13283129495`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire
