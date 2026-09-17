# Cards — report 41

Source: `App Store Reports/41. Awesome Habits - Habit Tracker - Streaks, days since & goals (REPORT).md`  
183 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 5
- [Must-haves](#must-haves) — 14
- [Must never break](#must-never-break) — 10
- [Features](#features) — 40
- [Monetization](#monetization) — 17
- [Tactics the app used](#tactics-the-app-used) — 7
- [Insights (the why)](#insights-the-why) — 21
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 16
- [Dated events and trends](#dated-events-and-trends) — 13
- [Positioning](#positioning) — 6
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 4
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 2
- [Data caveats and method](#data-caveats-and-method) — 23

## Product rules

### R41-075 — 'Add nothing' is a user-stated product requirement, stated more often and more emphatically than any single feature request: 'Please do not add any unnecessary features that would cause the app to be cluttered. I used to use another habit app… then they… added to-do list features. It just made the app unusable for me. Please don't try to be an all in one app!'; 'No-nonsense approach… without bloat. Plz keep it that way :)'; 'What you will not find here: being told which habit to do. Challenges against other people'; 'No plant that grows along, no timer you never use, just habit tracking'; 'Please keep the foundations of what you have created'; 'no gamification overload, no feeling that managing the habit tracker becomes a habit in itself'; 'kein Spam, keine Werbung, keine sinnlosen Tips'; 'Zero distractions, unlike other apps' — any roadmap must be read against it

- **Where:** §3.2.2 Simplicity and design — the specific repeated instruction: do not add anything; 'Please don't try to be an all in one app!'; 'without bloat. Plz keep it that way'; 'Keine Pflanze, die mitwächst, kein Timer, den man nicht benutzt'; 'no gamification overload, no feeling that managing the habit tracker becomes a habit in itself'
- **This app does:** minimal, no gamification
- **User reaction:** praise
- **Magnitude:** simplicity 338 (41.47%); design 284 (34.85%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8414522828`, `9243307416`, `8238514048`, `8384484490`, `8584016453`, `14489261806`, `12395956072`, `13465174002`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R41-125 — When a product is bought for one specific capability, that capability failing is a total failure of the purchase: four of ten post-purchase failures bought for a named feature that then failed — backfill, the Home Screen widget (twice, one from listing screenshots), Health sync

- **Where:** §5.4 Pattern 1 — four of ten bought for one specific named capability that then failed (backfill, widget ×2, Health sync) — any single-feature failure is a total failure of the purchase
- **This app does:** single-feature purchases
- **User reaction:** churn
- **Magnitude:** 4 of 10
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6649330433`, `7074903245`, `14223824557`, `13276009260`
- **Canonical:** C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R41-178 — Do not require an account: 'No account or login is needed'; 'Pas de compte à créer, pas de données collectées : un développeur respectueux' — and one privacy-minded payer cancelled rather than enable iCloud

- **Where:** §8.4 Do not require an account — 'No account or login is needed'; 'Pas de compte à créer, pas de données collectées : un développeur respectueux'; one cancelled a subscription rather than enable iCloud
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 7 + 1
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11221350396`, `9492349496`, `13278332346`, `14455804453`, `11055117867`, `14309794575`, `11892242464`, `9104605843`
- **Canonical:** C035 Account system from day one; C085 Address tracking / privacy visibly; C209 No sign-up wall before first use

### R41-179 — Do not drop the one-time purchase option: 81 reviews mention it (67 at 5★) and three name it as why they chose this app over a competitor (one in reverse — left for a one-payment app)

- **Where:** §8.4 Do not drop the one-time purchase option — 81 mention it, 67 at 5★; three say it is why they chose this app over a competitor
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 81 (67 5★); 3 switch reasons
- **Direction for us:** build-paid · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12128314444`, `11790255448`, `6969311100`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R41-180 — Do not make the percentage ring binary or streak-first: the non-binary ring is a stated reason to buy; one reviewer asks for more prominent streaks — a minority request against an explicit differentiator

- **Where:** §8.4 Do not make the percentage ring binary or streak-first — one asks for streaks to be more prominent, a minority request against an explicit differentiator
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** ring 40; streak request 1
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13969274929`, `11332444396`, `11481149340`, `12673892745`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C201 A user-set partial-completion threshold — a 'good day' below 100%

## Must-haves

### R41-014 — Keep the Lifetime option always discoverable: two reviewers could not find it and were blocked from paying — a direct, recoverable revenue loss

- **Where:** Executive summary #5 — two reviewers unable to find the lifetime option were blocked from paying — a direct, recoverable revenue loss
- **This app does:** lifetime hidden for some
- **User reaction:** blocked-conversion
- **Magnitude:** 2 reviews
- **Direction for us:** must-have · **Report confidence:** weak (high value) · **Generalisable:** yes
- **Review IDs:** `12128314444`, `11360590820`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R41-022 — Support contact must not depend on the Mail app: the in-app support link opens Mail and dead-ends users who don't use it — 'it is asking me to download the mail app, which I do not use… no contact info' (4★, on trial, 'likely will cancel'); 'support email should be text in the app - it opens Mail app which I don't use, and I get stuck with it forcing me to add a mail account' (4★)

- **Where:** Executive summary #12 (a) — in-app support link opens Mail and dead-ends users who don't use Mail: 2 (0.25%, weak), both cost stars, one on trial 'likely will cancel'
- **This app does:** mailto: link only
- **User reaction:** complaint
- **Magnitude:** 2 (0.25%), weak; both trial/paying
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11393377160`, `12113172399`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R41-023 — Provide an in-app cancellation path and handle refunds: a subscriber could not find how to cancel — 'I would like to unsubscribe and delete the app but there are no means to do that via the app' (GB, 4★); one unresolved public refund request — 'Terrible service. They didn't give me a refund' (UA, 1★, the only refund report, 0.12%)

- **Where:** Executive summary #12 (b) — no in-app cancellation path ('I would like to unsubscribe and delete the app but there are no means to do that via the app'); one refund request unresolved in public ('Terrible service. They didn't give me a refund', the only refund report, 0.12%)
- **This app does:** no in-app cancellation
- **User reaction:** complaint
- **Magnitude:** 1 + 1 (0.12% each)
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `7205630038`, `11450707006`
- **Canonical:** C112 In-app cancellation; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R41-058 — Onboarding confusion 8 (0.98%, mean 2.88)

- **Where:** §3.1 master table #33 Onboarding confusion
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 (0.98%), 2.88
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C075 Skippable, replayable onboarding tour

### R41-088 — Onboarding failures: 8 reviews (0.98%, mean 2.88), the lowest-rated non-monetisation theme — no tutorial ('How to use this app🤡 :: Is there a tutorial?', entire 1★ review); can't find edit ('I made a mistake when I made my first habit and I could not figure out how to edit it. It looks like all I could do was archive or delete'; a preset 3000 steps unadjustable); model not understood ('there is an option to add a list to the habit… I don't understand what that is for?')

- **Where:** §3.3.4 Onboarding — 8 (0.98%, emerging, mean 2.88), lowest-rated non-monetisation theme; three failures: no tutorial ('How to use this app🤡 :: Is there a tutorial?'); can't find edit ('could not figure out how to edit it… all I could do was archive or delete'); model not understood
- **This app does:** no tutorial
- **User reaction:** complaint
- **Magnitude:** 8 (0.98%), 2.88
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `10973931494`, `11867342767`, `8379900610`, `12067428931`
- **Canonical:** C075 Skippable, replayable onboarding tour

### R41-089 — Make skip vs miss vs not-logged visibly distinct and explain the stats: a paying user never used the app because the semantics were opaque — 'what does it mean when you forget to record a habit as completed, is that skipped or recorded as a miss. I don't understand how the stats work' (GB, 3★); five years later the same question — 'when you go into a habit's history and see gaps, you don't understand whether you forgot to tick that day or whether it was a skip. It's somehow not obvious' (UA, 4★)

- **Where:** §3.3.4 The expensive failure — a paying user never used the product because skip / miss / stat semantics were opaque ('what does it mean when you forget to record a habit as completed, is that skipped or recorded as a miss. I don't understand how the stats work'); same gap five years later ('you don't understand whether you forgot to tick that day or whether it was a skip')
- **This app does:** ambiguous skip/miss
- **User reaction:** churn
- **Magnitude:** 2 reviews, 5 years apart (one payer)
- **Direction for us:** must-have · **Report confidence:** anecdotal; high cost · **Generalisable:** yes
- **Review IDs:** `9373324084`, `14303067862`
- **Canonical:** C217 An unexplained metric reads as broken — explain the score on-screen; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

### R41-105 — Mac app text must scale: 'the Mac app has no text-zoom under the View menu… a serious problem because the app's text and icons are too small on my 27-inch display' (US, 3★, the corpus's only accessibility report); the 3★ band (28) holds reasoned objections — monetisation 8 (price 4, subscription 3, cap 1), localisation 4, bugs 4, feature gaps 8, onboarding 2 — e.g. a 150-word argument that iCloud sync makes a subscription unjustified, two precise frequency-model failures, weighted habits

- **Where:** §4.3 Three stars — reasoned objections: monetisation 8, localisation 4, bugs 4, feature gaps 8, onboarding 2; Mac app has no text-zoom ('text and icons are too small on my 27-inch display' — the only accessibility report)
- **This app does:** Mac app fixed text size
- **User reaction:** complaint
- **Magnitude:** n=1 accessibility; 3★ 28
- **Direction for us:** must-have · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `13827282696`, `10949796422`, `12529452345`, `13325152566`, `14428620119`
- **Canonical:** C044 Mac / desktop / web app; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R41-128 — A buyer must always be able to find every SKU and the purchase entry: 6 wanted to pay and were blocked (0.74%, mean 4.17) — 'Only issue is I can no longer see the lifetime plan which I would like to purchase!' (GB, Dec 2024); 'When activated trial there was a lifetime subscription option. Now don't see it. How to activate?' (UA, Jun 2024); 'I am bummed I missed out on the lifetime deal' (US, Jul 2023); 'Why is there no purchase entry in my interface? … I genuinely cannot find where the upgrade or purchase entry is!' (CN, Feb 2024); plus missing Spanish, missing sub-tasks with time, and a student deal — at least three, possibly four, could not pay because the lifetime SKU was intermittently invisible: the cheapest revenue recovery in the report

- **Where:** §5.5 Barriers to upgrading — 6 (0.74%, emerging, mean 4.17): lifetime option not visible (Dec 2024, Jun 2024 after trial), 'missed out on the lifetime deal' (Jul 2023), no purchase entry point at all (CN, 'I genuinely cannot find where the upgrade or purchase entry is!'); missing Spanish; missing sub-tasks with time; high-school student deal — at least three and possibly four could not give the developer money because the lifetime SKU was intermittently invisible: the cheapest revenue recovery in the report
- **This app does:** lifetime intermittently invisible
- **User reaction:** blocked-conversion
- **Magnitude:** 6 (0.74%), 4.17; 3–4 lifetime invisible
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12128314444`, `11360590820`, `10195683230`, `10901569398`, `11398546682`, `11063416316`, `8278322299`
- **Canonical:** C025 Scholarship / hardship / discount program; C027 Localise early — it unlocks revenue; C173 Sub-tasks / sub-routines nested inside a habit or routine; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R41-144 — Shipping localisations needs an in-app language selector that respects the user's choice: after Czech shipped, a Czech user wanted to keep English and 'there's no way to change the language' (5★); a French user's app switched to German — 'Why this language change to German??? I can't set it back to French? I'm so disappointed, I loved this app' (1★, Dec 2025) — a regression introduced by localising (2 records, 2 storefronts)

- **Where:** §6.9 #3 In-app language override — Czech user wants to keep English after Czech localisation shipped with no way to change; French user switched to German and cannot set it back ('Je suis trop déçue j'adorais cette app', 1★) — the app picks a display language the user did not choose and offers no in-app language switch
- **This app does:** no in-app language switch
- **User reaction:** 1★-burst
- **Magnitude:** 2 (one 1★)
- **Direction for us:** must-have · **Report confidence:** limited evidence; specific defect · **Generalisable:** yes
- **Review IDs:** `13309363635`, `13509177027`
- **Canonical:** C255 An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language

### R41-156 — Make the Lifetime SKU permanently discoverable and verify the purchase entry point renders in every storefront — customers with intent and no path; pure revenue recovery with no product trade-off

- **Where:** §8.1 F1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 4 blocked buyers; lifetime 81 (9.94%)
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12128314444`, `11360590820`, `10195683230`, `10901569398`
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R41-157 — Replace the mailto: support link with in-app contact text plus a web form — support is a documented conversion channel and the only data-loss recovery path ('Developer was very nice and helped me restore my data')

- **Where:** §8.1 F2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 2 (trial / paying)
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11393377160`, `12113172399`, `11834060415`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R41-160 — Add an explicit in-app language selector and stop overriding the user's chosen language — a regression introduced by shipping localisations that converts a feature investment into a rating loss

- **Where:** §8.1 F5
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 2 storefronts, one 1★
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13509177027`, `13309363635`
- **Canonical:** C255 An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language

### R41-161 — Make skip / miss / not-yet visually distinct in history — five years apart, same ambiguity, and it cost one payer the entire value of the purchase; a distinct 'not achieved' (未達) state and a 'mark no if you missed it' option are asked for

- **Where:** §8.1 F6
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 6 reviews
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9373324084`, `14303067862`, `11107932681`, `11872027872`, `13971210487`, `11725650343`
- **Canonical:** C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

### R41-168 — Experiment: a short 'how this app models habits' onboarding card — build vs break, skip vs miss, count vs days, what lists are for — addressing five onboarding failures at once

- **Where:** §8.2 E6
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** onboarding 8 (0.98%), 2.88
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9373324084`, `12067428931`, `14303067862`, `11867342767`, `10973931494`
- **Canonical:** C075 Skippable, replayable onboarding tour; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

## Must never break

### R41-015 — Device migration must never wipe history: 6 data-loss reviews (0.74%, mean 3.33) — 'After 215 days of tracking… everything (EVERYTHING!!!) has been deleted, all history lost! No chance to restore' (1★); 'ALL DATA (months of history) were deleted from BOTH old and new device. This app is a joke' (on device migration, 1★); 'This app just deleted all my habits and history after 6 months of using'; 'Sometimes there are bugs which cause data loss'; habit descriptions self-deleting; one restored ('Developer was very nice and helped me restore my data') — two of the six are iCloud / device-migration events, the highest-severity, lowest-frequency risk

- **Where:** Executive summary #6 — a small, high-severity data-loss cluster: 6 (0.74%, emerging, mean 3.33); 'After 215 days of tracking… everything (EVERYTHING!!!) has been deleted'; 'ALL DATA (months of history) were deleted from BOTH old and new device' on migration; two of six are iCloud/device-migration events; one recovered with developer help
- **This app does:** iCloud sync, backup Premium
- **User reaction:** churn
- **Magnitude:** 6 (0.74%), 3.33; 2 migration
- **Direction for us:** must-never-break · **Report confidence:** emerging; highest severity · **Generalisable:** yes
- **Review IDs:** `12535283569`, `12701004929`, `12154375821`, `12157688910`, `11141273586`, `11834060415`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R41-051 — Bugs / crashes / lag / battery 23 (2.82%, mean 3.61; 8/6/4/2/3)

- **Where:** §3.1 master table #20 Bugs / crashes / lag / battery
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 23 (2.82%), 3.61
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C175 Updates must not break function or wipe progress

### R41-053 — Widget defects / limits 13 (1.60%, mean 3.69)

- **Where:** §3.1 master table #25 Widget defects / limits
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 13 (1.60%), 3.69
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R41-057 — Apple Health sync gaps / one-way 8 (0.98%, mean 3.62)

- **Where:** §3.1 master table #32 Apple Health sync gaps / one-way
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 (0.98%), 3.62
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration; C072 Writes to shared system stores (calendar, health) must be exact and reversible

### R41-086 — Reliability sub-themes: bugs / crashes / lag / battery 23 (2.82%, 3.61) — diffuse, no single reproducible defect (iPad breakage 2020, widget preview mismatch 2021, slowness, severe battery drain on iPhone 12 Pro, lag after ~a week, unresponsive unit picker, self-deleting descriptions, widget slowdown after an iOS update, timer desync in notification centre, timezone-change message, app badge never updating, lag after trial on iPhone 7); sync failure 13 (1.60%, 3.08) — iPhone↔Watch and iPhone↔Mac; widget defects 13 (1.60%, 3.69) — stale data, slowness, icons too small; Apple Health gaps 8 (0.98%, 3.62) — one-way, missing types, not syncing; data loss 6 (0.74%, 3.33) — two device migrations

- **Where:** §3.3.3 Reliability (verbatim table) — bugs 23 diffuse; sync 13 iPhone↔Watch and iPhone↔Mac; widget defects 13 stale data, slowness, icons too small; Health gaps 8 one-way, missing types; data loss 6 (two migration)
- **This app does:** diffuse defects
- **User reaction:** complaint
- **Magnitude:** Sub-theme | n | % | Signal | Mean ★ | Nature ; Bugs / crashes / lag / battery | 23 | 2.82% | meaningful | 3.61 | Diffuse; no single reproducible defect ; Sync failure | 13 | 1.60% | meaningful | 3.08 | iPhone↔Watch and iPhone↔Mac ; Widget defects | 13 | 1.60% | meaningful | 3.69 | Stale data, slowness, icons too small ; Apple Health gaps | 8 | 0.98% | emerging | 3.62 | One-way sync, missing types, not syncing at all ; Data loss | 6 | 0.74% | emerging | 3.33 | Two are device-migration events
- **Direction for us:** must-never-break · **Report confidence:** high-priority (union) · **Generalisable:** yes
- **Review IDs:** `6686440161`, `7911454356`, `7193643397`, `12735681948`, `9995917469`, `9320708156`, `8379900610`, `11141273586`, `11860787280`, `13439662440`, `9977984348`, `13228974860`, `13508811496`, `8435023786`, `12054782248`
- **Canonical:** C021 Apple Health integration; C030 Sync must work — and prove it; C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C040 Widgets must not go blank, stale or disagree with the app

### R41-107 — Payers whose specific purchase reason failed write 17.2% of 1★: five of 29 1★ are paying customers — can't backfill past days ('I even upgraded to the paid version to unlock features and still nothing!'); Mac↔phone sync fails 'even after buying the premium'; refuses iCloud on privacy grounds so Watch sync impossible, cancelled; 'I paid for it specifically for synching with the health app' and it doesn't; refund refused; 1★ composition — monetisation 11 (cap 9, price 2, subscription 4 overlapping), sync / Health 5, data loss 2, localisation 3 (one entire review: 'Spanish'), bugs 2, onboarding 1, refund 1, review nagging 1, 2 mis-rated positives

- **Where:** §4.5 One star — composition: monetisation 11, sync/Health 5, data loss 2, localisation 3 (one entire review 'Spanish'), bugs 2, onboarding 1, refund 1, review-nagging 1, 2 mis-rated; five of 29 (17.2%) from payers whose specific purchase rationale failed
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 5/29 1★ payers (17.2%)
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6649330433`, `8751455990`, `9104605843`, `14223824557`, `11450707006`, `11786388052`, `12535283569`, `12701004929`, `11802469749`, `10078111201`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R41-124 — Post-purchase failures, the highest value per review: 10 of 60 direct payers (16.7% segment rate, 1.23% of 815, biased upward) — upgraded to backfill an 8-day streak that couldn't be backfilled (1★); paid for the Home Screen widget shown in listing screenshots that was 'coming soon' (2★); Mac↔iPhone sync fails after buying (1★); premium entitlement failed to sync to iPad (4★); Watch sync requires iCloud, refused on privacy grounds, cancelled (1★); paid, never used — setup model opaque (3★); refund refused (1★); 'paid for the lifetime subscription but there are no widgets… the entire reason I bought it. The preview looks nothing like the app this is a scam' (5★); 'I paid for it specifically for synching with the health app' (1★); 'sometimes the app treats me as if I am on the free version… neither does tapping restore purchases' (4★)

- **Where:** §5.4 Post-purchase failures (verbatim table) — 10 of 60 payers (16.7%, segment; 1.23% global), five rated 1★
- **This app does:** post-purchase failures
- **User reaction:** churn
- **Magnitude:** Review | Market | ★ | What failed ; 6649330433 | CA | 1 | Upgraded specifically to backfill an existing 8-day streak; backfilling did not exist ; 7074903245 | US | 2 | Paid for the full product for the Home Screen widget advertised in the listing screenshots; widget was *"coming soon"* ; 8751455990 | IN | 1 | Mac↔iPhone sync does not work *"even after buying the premium"* ; 8452677698 | DE | 4 | The premium entitlement itself failed to sync to the iPad ; 9104605843 | US | 1 | Watch sync requires iCloud; reviewer refuses iCloud on privacy grounds; cancelled the subscription ; 9373324084 | GB | 3 | Paid, then never used the app because the setup model was opaque ; 11450707006 | UA | 1 | Refund refused ; 13276009260 | CA | 5(!) | *"I bought the app and paid for the lifetime subscription but there are no widgets for this app which was the entire reason I bought it. The preview looks nothing like the app this is a scam"* ; 14223824557 | EG | 1 | *"I paid for it specifically for synching with the health app"* — it doesn't sync ; 13439662440 | CA | 4 | *"I have the premium version, but sometimes the app treats me as if I am on the free version, not allowing me to view stats… neither does tapping 'restore purchases'"*
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6649330433`, `7074903245`, `8751455990`, `8452677698`, `9104605843`, `9373324084`, `11450707006`, `13276009260`, `14223824557`, `13439662440`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R41-126 — A paying customer must never be shown a paywall: two entitlement-state bugs three years apart — premium entitlement not syncing to the iPad; 'sometimes the app treats me as if I am on the free version, not allowing me to view stats… neither does tapping restore purchases'

- **Where:** §5.4 Pattern 2 — two of ten are entitlement-state bugs: premium not syncing to iPad; premium intermittently reverting to free with restore purchases failing — a paying customer shown a paywall is the most damaging possible bug, reported three years apart
- **This app does:** entitlement reverts / doesn't sync
- **User reaction:** complaint
- **Magnitude:** 2 of 10 (2022, 2025)
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8452677698`, `13439662440`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C139 Cache entitlements locally — never block a paid surface on a live server check

### R41-158 — Harden iCloud device migration and surface an explicit, user-visible backup / restore with a 'last backed up' state — the lost data was recoverable, the user just had no way to do it themselves

- **Where:** §8.1 F3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 6 data-loss, 2 migration
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12701004929`, `11834060415`, `12535283569`, `12154375821`, `12157688910`, `11141273586`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R41-159 — Fix premium-entitlement state and make Restore Purchases reliable — showing a paywall to someone who already paid is the most damaging bug state available

- **Where:** §8.1 F4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 2 reports, 3 years apart
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `8452677698`, `13439662440`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C139 Cache entitlements locally — never block a paid surface on a live server check

## Features

### R41-017 — Let a habit be 'N times per week, any days' and show which days it was done: 13 reviews (1.60%, mean 3.85) ask for X times per week without fixing days or every N days, and 9 (1.10%, mean 4.00) want to see which day a weekly / monthly habit was completed — the only feature gap present in every year 2021–2026 and explicitly costing stars — 'you can't set a habit for an amount of times per week… my work schedule means I sometimes need to adjust the days I train' (GB, 2★); 'I would like the option of doing something 3 times a week, not necessarily on the same day every week'; 'There is no way to see on which day a weekly or monthly habit was recorded' — the app models 'which days' and 'how many times' as alternatives, users want both

- **Where:** Executive summary #8 — frequency flexibility is the clearest unmet need: 'X times per week without fixing which days' / 'every N days' 13 (1.60%, mean 3.85); which-day detail on weekly habits 9 (1.10%, mean 4.00); every year 2021–2026; 'this is one request, asked twice'
- **This app does:** which-days XOR how-many-times
- **User reaction:** complaint
- **Magnitude:** 13 (1.60%), 3.85; 9 (1.10%), 4.00; 2021–2026
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `6982393836`, `8656250182`, `9906262176`, `11105723095`, `11174670037`, `11184020601`, `11405961424`, `11494813596`, `12198311158`, `12529452345`, `12979275111`, `13971210487`, `14042363994`, `9028038591`, `10107026159`, `10392822751`, `11107932681`, `11872027872`, `12153222646`, `13585104492`, `14303067862`
- **Canonical:** C043 Flexible / custom frequency

### R41-028 — Platform AI used lightly for habit ideas is noticed positively: Apple Intelligence habit suggestions (Sep 2025) — 'I like the apple AI to help with ideas' (1 review)

- **Where:** §2.1 Apple Intelligence habit suggestions — 'I like the apple AI to help with ideas' (2025-09)
- **This app does:** Apple Intelligence suggestions
- **User reaction:** praise
- **Magnitude:** n=1
- **Direction for us:** research · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `13144867753`
- **Canonical:** C056 Don't build AI features on demand grounds

### R41-030 — NFC tag check-off shipped (Nov 2025)

- **Where:** §2.1 NFC tag check-off (2025-11)
- **This app does:** present
- **User reaction:** praise
- **Magnitude:** n=1
- **Direction for us:** research · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `13371878009`
- **Canonical:** — (nuance register)

### R41-040 — Widgets mentioned 111 (13.62%, mean 4.69; 89/15/4/1/2)

- **Where:** §3.1 master table #4 Widgets mentioned
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 111 (13.62%), 4.69
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free; C023 Interactive widget check-off

### R41-043 — Statistics / history / trends mentioned 54 (6.63%, mean 4.54; 38/12/1/1/2)

- **Where:** §3.1 master table #10 Statistics / history / trends
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 54 (6.63%), 4.54
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C011 Weekly / monthly / yearly reports

### R41-044 — Apple Health integration mentioned 53 (6.50%, mean 4.60; 39/9/4/0/1)

- **Where:** §3.1 master table #11 Apple Health integration
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 53 (6.50%), 4.60
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration

### R41-045 — Apple Watch mentioned 52 (6.38%, mean 4.71; 42/8/0/1/1) — includes three complaining Watch sync is broken

- **Where:** §3.1 master table #12 Apple Watch
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 52 (6.38%), 4.71
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R41-046 — Break-a-bad-habit mode (max units per day) praised 36 (4.42%, mean 4.69)

- **Where:** §3.1 master table #13 Break-a-bad-habit capability
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 36 (4.42%), 4.69
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C019 Quit-habit / bad-habit mode

### R41-047 — Siri Shortcuts / automation praised 36 (4.42%, mean 4.72) — near-full app control

- **Where:** §3.1 master table #14 Siri Shortcuts / automation
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 36 (4.42%), 4.72
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R41-048 — Reminders / notifications with snooze actions praised 28 (3.44%, mean 4.61)

- **Where:** §3.1 master table #17 Reminders / notifications
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 28 (3.44%), 4.61
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once

### R41-049 — Per-habit timer (+ Live Activities) praised 27 (3.31%, mean 4.70)

- **Where:** §3.1 master table #18 Timer feature
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 27 (3.31%), 4.70
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C066 Focus timer

### R41-050 — Daily / weekly / monthly goals visible together praised 26 (3.19%, mean 4.65)

- **Where:** §3.1 master table #19 Flexible daily/weekly/monthly goals
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 26 (3.19%), 4.65
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency

### R41-052 — CSV export / data ownership praised 14 (1.72%, mean 4.71; 13/0/0/0/1) — thanked when shipped (Feb 2023)

- **Where:** §3.1 master table #23 CSV export / data ownership
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 14 (1.72%), 4.71
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C020 Data export / backup / CSV

### R41-056 — Statistics insufficient 9 (1.10%, mean 4.44)

- **Where:** §3.1 master table #30 Statistics insufficient
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 9 (1.10%), 4.44
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C011 Weekly / monthly / yearly reports

### R41-059 — Widget text labels requested 8 (0.98%, mean 4.25)

- **Where:** §3.1 master table #34 Widget text labels requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 8 (0.98%), 4.25
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C107 Widget variants and customisation as the paid layer

### R41-060 — Sub-tasks / habit stacks / routine view 7 (0.86%, mean 4.43)

- **Where:** §3.1 master table #35 Sub-tasks / habit stacks / routine view
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 7 (0.86%), 4.43
- **Direction for us:** undecided · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C173 Sub-tasks / sub-routines nested inside a habit or routine

### R41-061 — Calendar view / calendar integration 7 (0.86%, mean 4.43)

- **Where:** §3.1 master table #36 Calendar view / calendar integration
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 7 (0.86%), 4.43
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C199 System calendar integration — see appointments inside the plan

### R41-062 — Yearly / long-horizon goals 6 (0.74%, mean 4.50)

- **Where:** §3.1 master table #38 Yearly / long-horizon goals
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 6 (0.74%), 4.50
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C108 Goals / targets

### R41-065 — Day boundary / night-shift day reset 5 (0.61%, mean 4.60) — custom day-start shipped May 2025

- **Where:** §3.1 master table #42 Day-boundary / night-shift day reset
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 5 (0.61%), 4.60
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C170 Configurable day boundary and hemisphere seasons

### R41-066 — Can't backfill / edit past days 5 (0.61%, mean 3.40)

- **Where:** §3.1 master table #43 Can't backfill / edit past days
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 5 (0.61%), 3.40
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C010 Backfill missed days / edit start date

### R41-068 — Mood tracking requested 5 (0.61%, mean 4.60)

- **Where:** §3.1 master table #45 Mood tracking requested
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 5 (0.61%), 4.60
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C049 Mood tracker

### R41-069 — Notes / descriptions requested in the early era 5 (0.61%, mean 4.80) — shipped May 2022

- **Where:** §3.1 master table #46 Notes/descriptions requested (early era)
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 5 (0.61%), 4.80
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C172 Per-day / per-habit notes and journal text

### R41-070 — Future start date / end date 5 (0.61%, mean 4.40)

- **Where:** §3.1 master table #47 Future start date / end date
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 5 (0.61%), 4.40
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency

### R41-071 — API / third-party integration 5 (0.61%, mean 3.80)

- **Where:** §3.1 master table #48 API / third-party integration
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 5 (0.61%), 3.80
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R41-077 — A daily completion percentage ring with partial credit — instead of pass / fail streaks — is a differentiator the app is not marketing: 40 reviews (4.91%, mean 4.67); 'The focus on percentages to measure accomplishment in a day is THE crucial thing… as someone who suffers from perfectionism and binary thinking… you're never thinking about the cliff edge of losing a streak or success/failure binary… the percentage focus and backseating of streaks made this a thing i actually use and bought over the hundreds of habit apps i browsed' (GB, 5★, Apr 2026); 'Empty rings bad. Filled rings good.'; 'if a habit needs a count of seven… and you have only performed it four times, you get credit for that. Nice.'; 'a meh day means about 70%— C work, but a better baseline'; inspired by closing Apple Watch rings

- **Where:** §3.2.4 The percentage ring — the app's quietest differentiator: 40 (4.91%, very strong, mean 4.67); 'as someone who suffers from perfectionism and binary thinking… you're never thinking about the cliff edge of losing a streak… the percentage focus and backseating of streaks made this a thing i actually use and bought over the hundreds of habit apps i browsed'
- **This app does:** partial-credit % ring, free
- **User reaction:** purchase-driver
- **Magnitude:** 40 (4.91%), 4.67
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13969274929`, `11332444396`, `11481149340`, `7342380013`, `6725250923`, `9474747245`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C201 A user-set partial-completion threshold — a 'good day' below 100%; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R41-079 — The Apple-ecosystem cluster sells the app: cross-device / iCloud 90 (11.04%, 4.49) — 'no account to setup, ready to go with iCloud Drive'; widgets 111 (13.62%, 4.69) — interactive check-off without opening the app; Watch 52 (6.38%, 4.71) — a complication showing the day's % ring; Apple Health 53 (6.50%, 4.60) — auto-completing steps / water / workouts; Siri Shortcuts 36 (4.42%, 4.72) — 'I was able to automate 80% of habits tracking'; privacy / no account 10 (1.23%, 5.00) — 'This app doesn't hoard your data'

- **Where:** §3.2.5 Apple-ecosystem cluster (verbatim table) — cross-device 90 'no account to setup, ready to go with iCloud Drive'; widgets 111 interactive check-off; Watch 52 complication showing % ring; Health 53 auto-completing steps/water/workouts; Shortcuts 36 'I was able to automate 80% of habits tracking'; privacy 10 'This app doesn't hoard your data'
- **This app does:** full Apple platform coverage
- **User reaction:** praise
- **Magnitude:** Theme | n | % | Signal | Mean ★ | Most-cited detail ; Cross-device / iCloud / Mac / iPad | 90 | 11.04% | high-priority | 4.49 | *"no account to setup, ready to go with iCloud Drive"* (9492349496) ; Widgets | 111 | 13.62% | high-priority | 4.69 | Interactive check-off without opening the app (11124760335, 12093784951) ; Apple Watch | 52 | 6.38% | high-priority | 4.71 | Complication showing the day's % ring (11794653008) ; Apple Health | 53 | 6.50% | high-priority | 4.60 | Auto-completing steps/water/workouts (10531421821, 14298082271) ; Siri Shortcuts | 36 | 4.42% | very strong | 4.72 | *"I was able to automate 80% of habits tracking"* (11414935723) ; Privacy / no account | 10 | 1.23% | meaningful | 5.00 | *"This app doesn't hoard your data"* (14455804453)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9492349496`, `11124760335`, `12093784951`, `11794653008`, `10531421821`, `14298082271`, `11414935723`, `14455804453`
- **Canonical:** C009 Basic widgets, icons and colours are free; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C030 Sync must work — and prove it; C046 Shortcuts / Siri / URL scheme / API; C085 Address tracking / privacy visibly

### R41-091 — Better / deeper statistics 9 (1.10%, mean 4.44) — while statistics are Premium

- **Where:** §3.4 #3 Better / deeper statistics
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 9 (1.10%), 4.44
- **Direction for us:** build-free · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `13519312740`, `11555630539`, `10045614075`, `13322024143`, `8381779872`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R41-092 — Widget text labels instead of icon-only 8 (0.98%, mean 4.25); widget icons too small ('Make them bigger and it is 5 stars!')

- **Where:** §3.4 #4 Widget text labels instead of icon-only
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 8 (0.98%), 4.25
- **Direction for us:** build-free · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `13826645362`, `11886448055`, `10415080649`, `7193643397`, `13465174002`, `10245394136`
- **Canonical:** C107 Widget variants and customisation as the paid layer

### R41-093 — Sub-tasks / habit stacks / routine view 7 (0.86%, mean 4.43) — 'I need sub tasks with time for each' blocked a purchase

- **Where:** §3.4 #5 Sub-tasks / habit stacks / routine view
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 7 (0.86%), 4.43
- **Direction for us:** undecided · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `14423293610`, `13228802467`, `11063416316`, `12933186432`, `14022932754`, `8290170982`
- **Canonical:** C173 Sub-tasks / sub-routines nested inside a habit or routine

### R41-094 — Calendar view / calendar integration 7 (0.86%, mean 4.43)

- **Where:** §3.4 #6 Calendar view / calendar integration
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 7 (0.86%), 4.43
- **Direction for us:** research · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `8352601276`, `10750983912`, `12294570428`, `12710798454`, `7869891198`
- **Canonical:** C199 System calendar integration — see appointments inside the plan

### R41-095 — Yearly / long-horizon goals 6 (0.74%, mean 4.50)

- **Where:** §3.4 #7 Yearly / long-horizon goals
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 6 (0.74%), 4.50
- **Direction for us:** build-free · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `13138354665`, `10837122337`, `10775655163`, `12569970736`, `13654436951`, `11845038528`
- **Canonical:** C108 Goals / targets

### R41-096 — Mood tracking inside the app's own history 5 (0.61%, mean 4.60) — added via Health in Sep 2024

- **Where:** §3.4 #8 Mood tracking inside the app's own history
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 5 (0.61%), 4.60
- **Direction for us:** research · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `11766790484`, `12294514611`, `8601037309`, `12299265869`
- **Canonical:** C021 Apple Health integration; C049 Mood tracker

### R41-097 — Future start date / end date for a habit 5 (0.61%, mean 4.40)

- **Where:** §3.4 #10 Future start date / end date
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 5 (0.61%), 4.40
- **Direction for us:** build-free · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `10886137884`, `11997316908`, `6841773921`, `11882129656`
- **Canonical:** C043 Flexible / custom frequency

### R41-098 — Public API / Zapier / IFTTT 5 (0.61%, mean 3.80)

- **Where:** §3.4 #11 Public API / Zapier / IFTTT
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 5 (0.61%), 3.80
- **Direction for us:** research · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `8193089811`, `10078111201`, `8118328892`, `13232442046`, `11555630539`
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R41-099 — Screen Time as a trackable bad habit 4 (0.49%, mean 4.75)

- **Where:** §3.4 #12 Screen Time as a trackable bad habit
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 4 (0.49%), 4.75
- **Direction for us:** research · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `10572050466`, `11401361919`, `12682557463`, `13297744521`
- **Canonical:** C019 Quit-habit / bad-habit mode

### R41-100 — Android / Web / Windows 4 (4.50); family sharing / compete with family 4 (5.00); app badge counter 3 (4.00) — weak

- **Where:** §3.4 #13–#15 Android / Web / Windows; family sharing; app badge counter
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 4 / 4 / 3
- **Direction for us:** research · **Report confidence:** request signal · **Generalisable:** yes
- **Review IDs:** `14313500501`, `12294920532`, `12616709393`, `11184020601`, `12809675994`, `11536341085`, `8435023786`, `13228974860`, `13508811496`
- **Canonical:** C037 Family plan; C051 Android version; C226 App-icon badge count of outstanding habits, with an active-hours window

### R41-118 — Data safety through CSV export is a purchase reason: 'especially the CSV export… so my data is safe'

- **Where:** §5.2 #7 Data safety / CSV export — 'especially the CSV export… so my data is safe'
- **This app does:** CSV export
- **User reaction:** purchase-driver
- **Magnitude:** 2 reviews
- **Direction for us:** build-free · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `12459206032`, `11184020601`
- **Canonical:** C020 Data export / backup / CSV

### R41-130 — Offer phone↔Watch sync that does not require iCloud: a privacy-minded subscriber refused iCloud, could not sync the Watch, cancelled, and will pay again for 'easy normal Bluetooth sync between the phone and the watch'

- **Where:** §5.6 Watch sync requires iCloud; reviewer refuses iCloud on privacy grounds — wants direct Bluetooth phone↔watch sync
- **This app does:** Watch sync via iCloud only
- **User reaction:** churn
- **Magnitude:** n=1 (1★)
- **Direction for us:** research · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `9104605843`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R41-162 — Ship optional text labels on widgets — 'When you have +10 habits, one habit widget with only icon and no clue… is a pain'; one runs a competitor alongside this app purely because widgets show no text; the widget is the most-praised surface (111)

- **Where:** §8.1 F7
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 8 (0.98%), 4.25
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13826645362`, `11886448055`, `10415080649`, `7193643397`, `13465174002`, `6339215858`, `6544718854`, `6543708670`
- **Canonical:** C107 Widget variants and customisation as the paid layer

### R41-164 — Experiment: 'X times per week, any days' as a first-class frequency type with per-day history — a third option inside the existing frequency picker, not a new concept (so it does not break 'add nothing'); measure 4★ → 5★ movement (8 of 13 frequency reviews are 4★)

- **Where:** §8.2 E2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 13 + 9 (2.70%), six years
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11105723095`
- **Canonical:** C043 Flexible / custom frequency

## Monetization

### R41-010 — A 3-habit free cap is the largest single negative and almost the entire 2★ band: 28 reviews (3.44%, very strong, mean 2.32) — 10 of 15 2★ (66.7%) and 9 of 29 1★ (31.0%) — 'A habit app that doesn't let you have more than 3 habits is not a habit app' (FI, 1★); 'you can't get a proper demo out of this without having at least 8 or 10 habits. Please consider raising the free habit limit!' (US, 4★); 'make it at least 10ish goals free and then people will pay for more' (CA, 2★); read not as pricing but as the product not working

- **Where:** Executive summary #2 — the 3-habit free cap is the largest single negative: 28 (3.44%, very strong, mean 2.32); 10 of 15 2★ (66.7%) and 9 of 29 1★ (31.0%)
- **This app does:** 3 free habits
- **User reaction:** complaint
- **Magnitude:** 28 (3.44%), 2.32; 10/15 2★; 9/29 1★
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `6824720982`, `6825465567`, `8077884105`, `8406116058`, `9160925249`, `9556644123`, `9710705599`, `10931710398`, `11109118040`, `11580359210`, `11857530634`, `11985104724`, `12131335894`, `12156551236`, `12202681717`, `12385678485`, `12470582996`, `12518959349`, `12659289186`, `12778509682`, `12819643720`, `12985048890`, `13563498977`, `13627048536`, `13781637874`, `14014520516`, `14169218014`, `12028492119`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R41-011 — The same 3-habit cap works as a trial for some and converts: 5 reviewers (0.61%, mean 4.80) describe it as a working trial and four of the five paid — 'I used the free version for a few weeks (only three habits) and decided I might as well do the lifetime upgrade'; 'The free version gives you 3 habits to track, which is plenty for most people… it's well worth it for $1.99 a month'; 'you can test the app with 3 goals: entirely enough to form an opinion'; 'I pretty quickly paid for premium to try it out for a month as only 3 tracked items is a low number' — the cap is the strongest conversion lever and the biggest rating liability; the question is whether it can move to a dimension that does not make the product look broken

- **Where:** Executive summary #3 — but the cap also converts: 5 (0.61%, emerging, mean 4.80) describe the 3-habit tier working as a trial, four of five went on to pay — a tuning problem, not a removal decision
- **This app does:** 3 free habits
- **User reaction:** purchase-driver
- **Magnitude:** 5 (0.61%), 4.80; 4 of 5 paid
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Conditions:** converts users who find 3 enough to judge; repels those needing 8–10 to evaluate
- **Review IDs:** `13393275122`, `12877429608`, `14309794575`, `11215681102`, `11817074234`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C147 Let people use the product before they pay

### R41-013 — A one-time Lifetime option is the most-cited commercial feature and a repeated purchase driver: 81 reviews (9.94%, high-priority, mean 4.70), 67 of them 5★ — 'Thank you very much for providing a single purchase option. It is much appreciated in the sea of subscriptions we are currently in'; 'I hate apps that don't offer lifetime premium as a purchase option, but thankfully this one does'; 'the option to pay once makes this a no-brainer to me'; 'they offer the non-subscription option (lifetime purchase). What's not to love?!'

- **Where:** Executive summary #5 — lifetime / one-time purchase is the most-cited commercial feature: 81 (9.94%, high-priority, mean 4.70), 67 5★
- **This app does:** Lifetime $22.99 beside $4.99/mo and $12.99/yr
- **User reaction:** purchase-driver
- **Magnitude:** 81 (9.94%), 4.70; 67 5★
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `7305149420`, `7489814726`, `8290170982`, `8414522828`, `8694232589`, `8883282086`, `10802417983`, `11449917454`, `11773757505`, `12081345787`, `12239848520`, `13189731645`, `13418978546`, `14298082271`, `14342654245`, `14511086289`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R41-031 — Free / paid: first 3 habits free; habits 4+ paid ('as I was trying to make my 4th habit it prompted me to pay'); statistics / history paid ('in free version you're limited with: 3 habits only. No statistics'; 'love statistics now visible' after buying); full icon set / colours paid ('only a few select icons'); widgets paid per one reviewer (weak); backup / restore paid ('I signed up to the yearly plan… which includes backup and restore'); iCloud sync ambiguous (never named as gated); CSV export, Health, vacation, skip, archive unclear; advertising none ('kein Spam, keine Werbung')

- **Where:** §2.2 Free / paid classification (verbatim table)
- **This app does:** 3 habits free; habits, stats, icons, backup paid
- **User reaction:** mixed
- **Magnitude:** Capability | Status | Evidence ; First 3 habits | Free | 12877429608, 11817074234, 14309794575, 12659289186 ; Habits 4+ (unlimited) | Paid | 7491388137 (*"as I was trying to make my 4th habit it prompted me to pay"*), 11815455819, 11501744811 ; Statistics / history | Paid | 9160925249 (*"in free version you're limited with: 3 habits only. No statistics"*), 11530645968 (*"love statistics now visible"* after buying), 13439662440 ; Full icon set / colours | Paid | 12202681717 (*"only a few select icons to use"* on free), 14309794575 (*"L'achat débloque… la personnalisation avec des icônes et des couleurs"*) ; Widgets | Paid (per one reviewer) | 10988344121 (*"pay for premium to access the widgets"*) — single source, treat as weak ; Backup / restore | Paid | 9047728455 (*"I signed up to the yearly plan… which includes backup and restore"*) ; iCloud sync across devices | Ambiguous | Praised constantly, never explicitly named as gated; 8452677698 implies premium entitlement itself must sync ; CSV export | Unclear | 10078111201 thanks the dev for it in a review that also demands an API; no review states it is gated ; Apple Health integration | Unclear | No review states gating either way ; Vacation mode, skip, archive | Unclear | No review states gating either way ; Advertising | None | 12395956072 (*"kein Spam, keine Werbung"*), 6953324112, 9557762161, 13278332346, 14455804453, 8238514048
- **Direction for us:** product-rule · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `12877429608`, `11817074234`, `14309794575`, `12659289186`, `7491388137`, `11815455819`, `11501744811`, `9160925249`, `11530645968`, `13439662440`, `12202681717`, `10988344121`, `9047728455`, `8452677698`, `10078111201`, `12395956072`, `6953324112`, `9557762161`, `13278332346`, `14455804453`, `8238514048`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C009 Basic widgets, icons and colours are free; C011 Weekly / monthly / yearly reports; C080 Colour themes / dark mode

### R41-032 — Statistics and history are gated behind Premium on top of the 3-habit cap: 'in free version you're limited with: 3 habits only. No statistics' (a cap complaint); after buying, 'love statistics now visible'

- **Where:** §2.2 Statistics / history paid — 'in free version you're limited with: 3 habits only. No statistics'
- **This app does:** stats paid
- **User reaction:** complaint
- **Magnitude:** 2 reviews
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `9160925249`, `11530645968`
- **Canonical:** C011 Weekly / monthly / yearly reports; C234 Statistics stay readable on the free tier — gating the progress view removes the motivation loop the category sells

### R41-033 — Backup / restore sits in Premium ('I signed up to the yearly plan… which includes backup and restore') — while free users face data-loss risk on migration

- **Where:** §2.2 Backup / restore paid — 'I signed up to the yearly plan… which includes backup and restore'
- **This app does:** backup paid
- **User reaction:** purchase-driver
- **Magnitude:** n=1
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `9047728455`
- **Canonical:** C020 Data export / backup / CSV; C153 Automatic cloud backup on by default — never manual opt-in

### R41-034 — Price ladder quoted by reviewers: 2021-01 DE €1.99/month, €14.50/year; 2021-06 US $2/month; 2021-08 FR €22 lifetime; 2021-11 CA $3/month; 2022-03 CA '$30 annually'; 2022-08 NL €23 lifetime; 2022-09 GB ~£1/month on yearly; 2023 DE €28 lifetime; 2024-11 US ~$20 lifetime on sale, 'double the price of the year subscription'; 2025-02 AU $40 lifetime; 2025-07 US $1.99/month, $13/year; 2025-12 FR €22 lifetime; 2026-07 FR / DE €25 lifetime; listing Sep 2026 $4.99/mo · $12.99/yr · $22.99 lifetime

- **Where:** §2.2 Price points quoted by reviewers, in date order (verbatim table); listing $4.99/mo · $12.99/yr · $22.99 lifetime
- **This app does:** monthly + yearly + lifetime throughout
- **User reaction:** mixed
- **Magnitude:** Date | Storefront | Quoted price | Review ; 2021-01 | DE | €1.99/month | 6825465567 ; 2021-01 | DE | €14.50/year | 6888526856 ; 2021-06 | US | $2/month | 7491388137 ; 2021-08 | FR | €22 lifetime | 7732471276 ; 2021-11 | CA | $3/month | 8077884105 ; 2022-03 | CA | "$30 annually" | 8460171885 ; 2022-08 | NL | €23 lifetime | 8962067224 ; 2022-09 | GB | ~£1/month on yearly | 9047728455 ; 2023-01 / 2023-03 | DE | €28 lifetime | 9473367265, 9734433109 ; 2024-11 | US | ~$20 lifetime on sale, "double the price of the year subscription" | 11945887963 ; 2025-02 | AU | $40 lifetime | 12347225054 ; 2025-07 | US | $1.99/month; $13/year | 12877429608, 12933186432 ; 2025-12 | FR | €22 lifetime | 13502703203 ; 2026-07 | FR / DE | €25 lifetime | 14309794575, 14298082271 ; 2026-09 (listing) | US | $4.99/mo · $12.99/yr · $22.99 lifetime | store listing, accessed 11 Sep 2026
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `6825465567`, `6888526856`, `7491388137`, `7732471276`, `8077884105`, `8460171885`, `8962067224`, `9047728455`, `9473367265`, `9734433109`, `11945887963`, `12347225054`, `12877429608`, `12933186432`, `13502703203`, `14309794575`, `14298082271`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'

### R41-064 — Wanted to pay, blocked 6 (0.74%, mean 4.17)

- **Where:** §3.1 master table #40 Wanted to pay, blocked
- **This app does:** see §3.1
- **User reaction:** blocked-conversion
- **Magnitude:** 6 (0.74%), 4.17
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R41-083 — The cap complaint holds two populations: nine 4–5★ fans asking for a slightly bigger free tier — telling you where the line should be (5–10 habits, named four times) — and nineteen 1–3★ reviewers who bounced, telling you what happens at 3

- **Where:** §3.3.1 Two distinct populations inside the cap theme — nine 4–5★ fans asking for a slightly bigger free tier (5–10 habits named four times) and nineteen 1–3★ who bounced
- **This app does:** 3-habit cap
- **User reaction:** blocked-conversion
- **Magnitude:** 9 fans vs 19 bounced; 5–10 named 4×
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `6824720982`, `6825465567`, `11580359210`, `12778509682`, `12819643720`, `12985048890`, `13781637874`, `12028492119`, `9160925249`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R41-084 — Show the lifetime option at the moment of subscription friction: subscription objection (10, 1.23%, mean 2.30) is distinct from price objection (21, 2.58%, 3.43) and more recoverable — in three cases the existing lifetime option would have answered it — 'I would have happily paid a one time fee for it but why on earth would I want to pay a subscription? … It's been deleted and I've bought an app that just has one payment' (GB, Feb 2021, a lost sale to a competitor); 'Hard to see the subscription model here as anything other than a cash grab' (a reasoned argument that iCloud sync means no server cost); 'I will switch to another one just to avoid the subscription'; 'There should be a lifetime purchase for £3.99 or so'; resolved: 'kinda impulse bought the lifetime package because who needs another subscription but it has delivered'

- **Where:** §3.3.2 Price objection (21, 2.58%) and subscription objection (10, 1.23%) are distinct; subscription objectors are more recoverable — in three cases lifetime already answered them but they did not know or it was not offered at the moment of friction; 'It's been deleted and I've bought an app that just has one payment' (a lost sale); 'iCloud sync means the developer carries no server cost'; 'kinda impulse bought the lifetime package because who needs another subscription'
- **This app does:** subscription + lifetime (not always visible)
- **User reaction:** blocked-conversion
- **Magnitude:** sub 10 (1.23%), 2.30; price 21 (2.58%), 3.43
- **Direction for us:** build-paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `6969311100`, `10949796422`, `11790255448`, `11755092191`, `14428620119`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R41-085 — Price objectors name their reserve price and purchasing-power gaps: €10 one-time; under $5 one-time; £3.99 lifetime; 'the one time purchase fee is a bit too much, at least in my country' (TR, 5★); 'cant you guys add like a student deal somehow?' (US high-school student, 3★); price objection by year 2.5 → 4.2 → 3.6 → 1.7 → 4.6 → 0.0% (2026, prices not constant)

- **Where:** §3.3.2 Price objectors name their reserve price — €10 one-time, under $5 one-time, £3.99 lifetime; purchasing power ('the one time purchase fee is a bit too much, at least in my country', TR); a student deal
- **This app does:** €22–28 lifetime
- **User reaction:** complaint
- **Magnitude:** 21 (2.58%), 3.43
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9473367265`, `12131335894`, `11755092191`, `13528830783`, `8278322299`
- **Canonical:** C025 Scholarship / hardship / discount program; C064 Price level — where 'fair' turns into 'too expensive'; C092 Regional pricing

### R41-113 — The top purchase trigger is that a lifetime option exists at all (10 evidence reviews), ahead of a comparison win (12 of 60 payers also carry the comparison theme)

- **Where:** §5.2 #1 The lifetime option exists at all — the single most-cited purchase reason
- **This app does:** lifetime
- **User reaction:** purchase-driver
- **Magnitude:** most-cited trigger
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8883282086`, `11449917454`, `7305149420`, `13418978546`, `12081345787`, `14342654245`, `13189731645`, `12893034917`, `14309794575`, `14428620119`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R41-115 — Hitting the 3-habit cap converts some ('Bought the lifetime subscription so I could add more habits'; 'I pretty quickly paid for premium… as only 3 tracked items is a low number') but it is only the fourth trigger and the only one that also generates the 2★ band

- **Where:** §5.2 #4 Hitting the 3-habit cap — 'Bought the lifetime subscription so I could add more habits' (fourth, and the only trigger that also generates the 2★ band)
- **This app does:** 3-habit cap
- **User reaction:** purchase-driver
- **Magnitude:** 4 evidence reviews
- **Direction for us:** undecided · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `11215681102`, `11815455819`, `13393275122`, `12877429608`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R41-116 — Statistics behind the paywall are a named purchase trigger: 'Just purchased lifetime pro version… love statistics now visible'; 'In the paid version, the app automatically makes a graph'

- **Where:** §5.2 #5 Statistics behind the paywall — 'Just purchased lifetime pro version… love statistics now visible'; 'In the paid version, the app automatically makes a graph'
- **This app does:** stats paid
- **User reaction:** purchase-driver
- **Magnitude:** 2 reviews
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `11530645968`, `8429857651`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R41-120 — Some pay to support the developer, not for features: 'Just bought the premium to support the developer i don't even need the features tbh'; 'I bought the monthly subscription to support developers!'; 'Please support the dev so he can support it for the long term'

- **Where:** §5.2 #9 Supporting the developer — 'Just bought the premium to support the developer i don't even need the features tbh'; 'I bought the monthly subscription to support developers!'; 'Please support the dev so he can support it for the long term'
- **This app does:** solo dev
- **User reaction:** purchase-driver
- **Magnitude:** 3 reviews
- **Direction for us:** do · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `11751459650`, `10454723570`, `12075485629`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R41-163 — Experiment: move the free-tier gate off number of habits — gate on history depth, statistics, widgets, sync or customisation instead; primary metric paid conversion, equally important secondary 1–2★ rate; reviewers name 5–10 habits as the defusing number; risk — four describe the current cap working as a trial

- **Where:** §8.2 E1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** cap → 66.7% of 2★, 31.0% of 1★
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12659289186`, `13393275122`, `12877429608`, `11215681102`, `14309794575`, `8077884105`, `11580359210`, `12778509682`, `13781637874`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### R41-166 — Experiment: purchasing-power-adjusted lifetime tiers in the 63 sub-50 storefronts, where cap complaints are 2.1× the high-volume markets — reserve prices named (€10, <$5, £3.99) are anecdotes, not a pricing input; 'R$8/month' quoted approvingly

- **Where:** §8.2 E4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** CA price 7.8%; TR purchasing power; student deal
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13528830783`, `12985048890`, `8278322299`, `9473367265`, `12131335894`, `11755092191`
- **Canonical:** C025 Scholarship / hardship / discount program; C092 Regional pricing

## Tactics the app used

### R41-019 — Outcome of shipping a requested localisation: reviewers came back to rate 5★ — 'I opened the app today and found an update finally introducing Italian. I ran straight here to give 5 stars' (IT, Jun 2026); Traditional Chinese (TW, Jun 2026); Czech (Oct 2025) — a measured, immediate rating response

- **Where:** Executive summary #9 — when localisations shipped, reviewers came back to reward it: Italian 'Sono corso subito a mettere 5 stelle' (Jun 2026); Traditional Chinese (Jun 2026)
- **This app does:** Czech, Italian, Traditional Chinese shipped 2025–26
- **User reaction:** 5★-burst
- **Magnitude:** 3 (0.37%), mean 5.00
- **Direction for us:** do · **Report confidence:** weak count, direct evidence · **Generalisable:** yes
- **Review IDs:** `14135424478`, `14139118342`, `13309363635`
- **Canonical:** C027 Localise early — it unlocks revenue; C059 Be visibly responsive; fixes bring reviewers back

### R41-021 — One-to-one developer support works as a conversion channel: developer / support responsiveness 66 reviews (8.10%, mean 4.73), named by 7 of 60 payers — 'I emailed the developer a feature related question. He responded within hours. Twice. Outstanding support. As such, I am buying the app outright'; 'After exploring the app more and speaking with the customer service guys… I am adding a star for this. I will be purchasing the app outright'; 'I asked the developers for it and they've just added it' — fragile because it is one person: the support-mention rate collapsed to 1.7% in 2025 before recovering to 9.4% in 2026

- **Where:** Executive summary #11 — developer responsiveness is a named purchase reason: 66 (8.10%, mean 4.73); 7 of 60 payers name it; 'He responded within hours. Twice. Outstanding support. As such, I am buying the app outright'; support-mention rate collapsed to 1.7% in 2025 before recovering to 9.4% in 2026 — one person, fragile
- **This app does:** solo developer answers e-mail
- **User reaction:** purchase-driver
- **Magnitude:** 66 (8.10%), 4.73; 7/60 payers; 2025 1.7% → 2026 9.4%
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11055117867`, `9877978258`, `14282886646`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R41-029 — Distributing through a subscription bundle store (SetApp) reaches some users: 'Assino pelo SetApp' (I subscribe through SetApp)

- **Where:** §2.1 SetApp distribution — 'Assino pelo SetApp'
- **This app does:** SetApp
- **User reaction:** praise
- **Magnitude:** n=1
- **Direction for us:** research · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `11526089864`
- **Canonical:** — (nuance register)

### R41-101 — Outcome of shipping requested features and letting requesters see it: eleven requested capabilities are documented as shipped inside the corpus, several with the original requester returning to confirm — notes / descriptions (requested 2020–21, 'Just recently, it added the ability to attach a description', 2022-05); Apple Watch app (2021); widget with % circle + grey background (a reviewer edited the review twice to confirm both requests shipped); Siri Shortcuts (absent → 'Shortcut interactions are great' in the same month, Jan 2022); CSV export ('Now that the developer has added CSV export—the feature I had been missing—the app is 5-star awesome for me', 2023-02); vacation mode (2023-12); heat maps ('Now with heat maps it has about all you could ask for', 2024-07); mood tracking via Health (2024-09); custom day / week start ('I asked whether we can have a different start day. It was not available at that time, but it is now', 2026-07); Czech, Italian, Traditional Chinese; an unnamed request ('I asked the developers for it and they've just added it') — a real competitive moat; the top three unmet needs are the ones not closed after six years

- **Where:** §3.4 Requests that shipped during the window (verbatim table) — notes (2022-05), Apple Watch (2021-04), widget with % circle (reviewer edited twice to confirm), Siri Shortcuts (2022-01, same month), CSV export (2023-02 'the app is 5-star awesome for me'), vacation mode (2023-12), heat maps (2024-07), mood via Health (2024-09), custom day-start (asked at start, 'it is now'), Czech / Italian / Traditional Chinese, an unnamed personal request (2026-07)
- **This app does:** ships requests and reviewers update ratings
- **User reaction:** 5★-burst
- **Magnitude:** Request era | Feature | Confirmation of delivery ; 2020-08 – 2021-02 | Notes / descriptions per habit | 8716355592 (2022-05: *"Just recently, it added the ability to attach a description to a habit"*) ; 2020-08 – 2021-01 | Apple Watch app | 7189304033 (2021-04), 7360729737 (2021-05) ; 2021-03 – 2021-05 | Widget with % circle + grey background | 7393214877 — reviewer edited the review twice to confirm both requests shipped ; 2022-01 | Siri Shortcuts | 8193089811 (2022-01: absent) → 8234435754 (2022-01: *"Shortcut interactions are great"*) ; 2022-02 – 2023-02 | CSV export | 9603969118 (2023-02: *"Now that the developer has added CSV export—the feature I had been missing—the app is 5-star awesome for me"*) ; 2023-12 | Vacation mode | 10748623012 (*"I also love the new vacation mode feature"*) ; 2024-07 | Heat maps | 11456145500 (*"Now with heat maps it has about all you could ask for"*) ; 2024-09 | Mood tracking (via Health) | 11766790484 (*"I'm very happy to see mood tracking added"*) ; 2021-06 – 2025 | Custom day-start / week-start | 14352778355 (2026-07: *"When I first got it, I asked whether we can have a different start day. It was not available at that time, but it is now."*) ; 2025-10 – 2026-06 | Czech, Italian, Traditional Chinese | 13309363635, 14135424478, 14139118342 ; 2026-07 | Unnamed personal request | 14282886646 (*"j'en ai fait la demande aux développeurs et ils viennent de l'ajouter"*)
- **Direction for us:** do · **Report confidence:** strong self-evidence · **Generalisable:** yes
- **Review IDs:** `8716355592`, `7189304033`, `7360729737`, `7393214877`, `8193089811`, `8234435754`, `9603969118`, `10748623012`, `11456145500`, `11766790484`, `14352778355`, `13309363635`, `14135424478`, `14139118342`, `14282886646`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R41-111 — Granting the full version free to early users at launch (2020) produced two 5★ reviews citing it — no further outcome measurable

- **Where:** §5.1 2 (0.25%) given the full version free during the 2020 launch period
- **This app does:** launch giveaway
- **User reaction:** praise
- **Magnitude:** 2 (0.25%), mean 5.00
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `6306944780`, `6725250923`
- **Canonical:** C225 A one-off free promotion (App of the Week, partner promo) acquires durable users

### R41-114 — A fast human support reply closes sales: 'He responded within hours. Twice. Outstanding support. As such, I am buying the app outright'; 'After… speaking with the customer service guys… I will be purchasing the app outright' (4 evidence reviews)

- **Where:** §5.2 #3 A support interaction closed the sale — 'He responded within hours. Twice… As such, I am buying the app outright'
- **This app does:** solo dev e-mail support
- **User reaction:** purchase-driver
- **Magnitude:** 4 reviews; 7/60 payers praise support
- **Direction for us:** do · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `11055117867`, `9877978258`, `10988344121`, `12459206032`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R41-121 — A lifetime sale converted: 'because it was on sale for about 20 dollars' (Nov 2024; lifetime described as 'double the price of the year subscription')

- **Where:** §5.2 #10 Sale pricing — 'because it was on sale for about 20 dollars'
- **This app does:** lifetime sale
- **User reaction:** purchase-driver
- **Magnitude:** n=1
- **Direction for us:** research · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `11945887963`
- **Canonical:** C025 Scholarship / hardship / discount program

## Insights (the why)

### R41-009 — A product that wins every comparison has a discovery problem, not a persuasion problem: reviewers say so — 'It deserves a way higher ranking and visibility in the search results'; 'I'm surprised that this app is not yet as famous as others. Ratings are great, must be only a matter of marketing'; 'this app doesn't get the attention it deserves'; 'I hope that it gains traction and ranks higher in the search results, since I didn't find it the first time'

- **Where:** Executive summary #1 — Interpretation: converts on the comparison page, not the category page; its growth problem is discovery, not persuasion — 'It deserves a way higher ranking and visibility in the search results'; 'must be only a matter of marketing'; 'doesn't get the attention it deserves'; 'I didn't find it the first time'
- **This app does:** low visibility
- **User reaction:** praise
- **Magnitude:** 4 quotes; comparison 160 (19.63%)
- **Direction for us:** do · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `9400089129`, `11493203641`, `13228802467`, `8013660114`
- **Canonical:** C134 Lead the store listing with what users actually love

### R41-012 — The rating is set at the paywall, not in the app: monetisation friction (cap ∪ price ∪ subscription objection) 46 reviews (5.64%, mean 2.80) produce 21 of the 44 1–2★ (47.7%), while every reliability defect together (sync, data loss, bugs, widget defects, Health gaps) — 50 reviews (6.13%, mean 3.46) — produces 13 (29.5%)

- **Where:** Executive summary #4 — monetisation friction, not defects, produces bad ratings: union 46 (5.64%, mean 2.80) = 21 of 44 1–2★ (47.7%); reliability union 50 (6.13%, mean 3.46) = 13 of 44 (29.5%) — rating set at the paywall, not in the app
- **This app does:** 3-habit cap + subscription
- **User reaction:** complaint
- **Magnitude:** friction 46 → 47.7% of 1–2★; reliability 50 → 29.5%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R41-016 — Sync is both the promise the app is bought on and its most-reported defect: cross-device / iCloud / Mac / iPad praise 90 (11.04%, mean 4.49) — 'This is the best habit tracker for someone who wants to track across multiple devices'; 'Es synchronisiert sich über alle Geräte… iPad, iPhone, Apple Watch und Mac' — vs sync failure 13 (1.60%, mean 3.08), four of them from paying reviewers; when sync breaks it breaks the purchase rationale, which is why failures skew to payers and 1★

- **Where:** Executive summary #7 — sync is the most-praised capability and the most-reported defect: praise 90 (11.04%, mean 4.49) vs failure 13 (1.60%, mean 3.08); 4 of 13 are payers — sync is the promise the app is bought on
- **This app does:** iCloud sync, no account
- **User reaction:** mixed
- **Magnitude:** praise 90 (11.04%), 4.49; failure 13 (1.60%), 3.08; 4 payers
- **Direction for us:** must-never-break · **Report confidence:** high-priority / meaningful · **Generalisable:** yes
- **Review IDs:** `6344341522`, `14298082271`, `8452677698`, `8580802546`, `8751455990`, `9104605843`, `11176831683`, `11872139244`, `12157688910`, `12219810473`, `12701004929`, `13279660290`, `13439662440`, `13465174002`, `14334740214`, `14223824557`
- **Canonical:** C030 Sync must work — and prove it; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R41-037 — Feature requests come from happy users and are roadmap input, not churn risk: unmet-needs union 112 (13.74%, mean 4.17; 51 are 5★, 42 4★) produces only 7 of 44 1–2★ (15.9%); reliability 50 (6.13%, 3.46) → 13 (29.5%); monetisation friction 46 (5.64%, 2.80) → 21 (47.7%)

- **Where:** §3.1 Union rows (verbatim table) — monetisation friction 46 (5.64%, 2.80) → 21 of 44 1–2★ (47.7%); reliability 50 (6.13%, 3.46) → 13 (29.5%); unmet needs 112 (13.74%, 4.17) → 7 (15.9%); feature requests are written by happy users (51 of 112 5★, 42 4★) — roadmap input, not churn risk
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Union | n | % | Signal | Mean ★ | Share of all 1–2★ reviews (n=44) ; Monetization friction (cap ∪ price ∪ subscription objection) | 46 | 5.64% | high-priority | 2.80 | 21 (47.7%) ; Reliability defects (sync ∪ data loss ∪ bugs ∪ widget defects ∪ Health gaps) | 50 | 6.13% | high-priority | 3.46 | 13 (29.5%) ; Unmet needs / feature requests (18 request themes) | 112 | 13.74% | high-priority | 4.17 | 7 (15.9%)
- **Direction for us:** product-rule · **Report confidence:** central quantitative claim · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R41-038 — Simplicity / ease-of-use praise 338 (41.47%, mean 4.83; 298/32/3/2/3) — broad regex count, context not decision driver

- **Where:** §3.1 master table #1 Simplicity / ease-of-use praise
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 338 (41.47%), 4.83
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R41-039 — Design / UI / aesthetics praise 284 (34.85%, mean 4.80; 244/30/6/2/2) — broad regex count

- **Where:** §3.1 master table #2 Design / UI / aesthetics praise
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 284 (34.85%), 4.80
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R41-041 — Motivation / reward / satisfaction 61 (7.48%, mean 4.79)

- **Where:** §3.1 master table #8 Motivation / reward / satisfaction
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 61 (7.48%), 4.79
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R41-054 — Privacy / no account required 10 (1.23%, all 5★, mean 5.00)

- **Where:** §3.1 master table #28 Privacy / no account required
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 10 (1.23%), 5.00
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C085 Address tracking / privacy visibly; C209 No sign-up wall before first use

### R41-063 — No ads / no gamification bloat 6 (0.74%, all 5★) — 'kein Spam, keine Werbung'

- **Where:** §3.1 master table #39 No ads / no gamification bloat
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 6 (0.74%), 5.00
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R41-067 — Paid user who churned / cancelled 5 (0.61%, mean 2.60)

- **Where:** §3.1 master table #44 Paid user who churned / cancelled
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 5 (0.61%), 2.60
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R41-076 — Outcome stories are the strongest marketing asset available: behaviour change 32 (3.93%, very strong, mean 4.97, 31 of 32 5★, the highest-rated theme) — 'I overcome my alcohol addiction because of this app. 10/10'; 'I could quit drinking alcohol and built a habit reading the bible instead'; 'This app saved my life. Literally…'; 'finishing dozens of books… Last year I was finally able to stop tracking my reading habits because it just became second nature again'; 'single-handedly eliminated several toxic and time wasting habits' — concentrated in US and GB (6.0% and 10.9% of those markets vs 3.9% global) and rising sharply (10.4% of 2026 vs 2.3–2.6% in 2023–2025)

- **Where:** §3.2.3 Behaviour change — 32 (3.93%, very strong, mean 4.97), 31 of 32 5★, the highest-rated theme; 'I overcome my alcohol addiction because of this app'; 'This app saved my life. Literally'; concentrated in US and GB (6.0% and 10.9% vs 3.9%); rising sharply 10.4% of 2026 vs 2.3–2.6% in 2023–2025
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 32 (3.93%), 4.97; US 6.0%, GB 10.9%; 2026 10.4%
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12562218294`, `9208911138`, `11751317691`, `12367909395`, `14081110708`, `12155228243`, `9333570878`
- **Canonical:** C134 Lead the store listing with what users actually love

### R41-082 — How the cap is read: 'Only allows 3 habits with free version before asking for money. No point even keeping app, deleted it immediately' (CA, 1★); 'Free version only allows 3 habits' (entire review, 2★); 'Only useable in PAID plan :: Not useful'; 'Not a great app without the subscription… This is functionally a paid app' (US, 1★); 'I don't see why I should keep paying money for every app' (DE, 1★); 'I love the app but I can't afford to pay… let the free users have at least 5/7 habits instead of 3' (AU, 4★); 'make it 4/5 pls!!'; and one would rather see ads: 'I'd rather see a couple of ads instead of paying 1,99€ monthly - but well, that's the developer's choice :)'

- **Where:** §3.3.1 The sharpest formulations — 'Only allows 3 habits with free version before asking for money. No point even keeping app, deleted it immediately'; 'This is functionally a paid app'; 'ich seh es nicht ein für jede App andauernd Geld zu bezahlen'; 'I'd rather see a couple of ads instead of paying 1,99€ monthly'
- **This app does:** 3-habit cap
- **User reaction:** churn
- **Magnitude:** 8 quotes
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `9710705599`, `10931710398`, `12518959349`, `13627048536`, `14169218014`, `11580359210`, `13781637874`, `6825465567`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R41-087 — Stability is itself praised: a 2.82% diffuse bug rate with no reproducible cluster over six years is a strong record, and reviewers state the opposite of bug reports — 'Doesn't crash. Is smooth.'; 'no bugs, no junk'; 'Well-designed, bug-free'; 'I have not encountered any bugs so far. Have used the app for more than a year'; 'stable, reliable. It never errs, it never freezes' (HU, after a two-month evaluation against monday.com, ClickUp and Trello)

- **Where:** §3.3.3 Interpretation — a 2.82% diffuse bug rate with no reproducible cluster is a strong reliability record; explicit anti-bug statements ('Doesn't crash. Is smooth'; 'no bugs, no junk'; 'Sosem hibázik, nem fagy ki' after a two-month evaluation against monday.com, ClickUp and Trello)
- **This app does:** stable
- **User reaction:** praise
- **Magnitude:** bugs 23 (2.82%)
- **Direction for us:** none · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `9474747245`, `11345916111`, `10874988299`, `13322024143`, `11254572291`
- **Canonical:** — (nuance register)

### R41-104 — 4★ is the 'one thing away' band and the cleanest roadmap signal: of 116, frequency gap 8, free cap 7, which-day detail 7, sync failure 6, price 6, bugs 6, stats 3, localisation 3, yearly goals 3 — reviewers name the fix: 'If the developers produce a Watch version and sort out the timer then I'd give this app the full 5 stars' (both shipped); 'Once this issue is resolved, I'll gladly give the app a 5-star rating' (sync); 'Make them bigger and it is 5 stars!' (widget icons); 'le falta el idioma español… no le pongo las 5 estrellas'; 'Will fix my reviews to 5 star if you will give more option as an app icon' (a Premium user); 'I would give 5/5 when they… implement the following' (timezone message, swipe gestures)

- **Where:** §4.2 Four stars — the 'one thing away' band: frequency gap 8, cap 7, 'which day' 7, sync failure 6, price 6, bugs 6, stats 3, localisation 3, yearly goals 3; reviewers name their own condition ('If the developers produce a Watch version and sort out the timer then I'd give this app the full 5 stars' — both shipped; 'Will fix my reviews to 5 star if you will give more option as an app icon' — a Premium user)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 116 4★; frequency 8, cap 7, which-day 7
- **Direction for us:** research · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6939185873`, `11176831683`, `10245394136`, `11398546682`, `13109253196`, `9977984348`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C043 Flexible / custom frequency

### R41-106 — The 2★ band is a pricing-page artefact, not a product verdict: 10 of 15 (66.7%) are cap / must-pay complaints and nine of those ten praise the product in the same breath — 'the app is amazing with small size and so simple!'; 'App looks nice'; 'UI is good but…'; 'Good UI, but only 3 habits on free plan'; the other five: a missing Home Screen widget in 2021 (a payer), an unresponsive unit picker, severe lag, the frequency gap, Watch sync broken again

- **Where:** §4.4 Two stars — almost entirely the paywall: 10 of 15 (66.7%) cap / must-pay; nine of ten praise the product in the same breath ('the app is amazing with small size and so simple!'; 'Good UI, but only 3 habits on free plan'); other five: missing widget 2021 (payer), unit picker, lag, frequency gap, Watch sync broken again — a pricing-page artefact, not a product verdict
- **This app does:** 3-habit cap
- **User reaction:** complaint
- **Magnitude:** 10/15 2★ (66.7%)
- **Direction for us:** product-rule · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8077884105`, `8406116058`, `9160925249`, `9556644123`, `10931710398`, `11109118040`, `11857530634`, `12156551236`, `12385678485`, `12470582996`, `7074903245`, `8379900610`, `9320708156`, `11105723095`, `13279660290`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R41-109 — The app wins every fight it is allowed to have, and the cap decides how many fights it gets: comparison victory by band 5★ 24.1% → 4★ 6.9% → 3★ 3.6% → 2★ 0.0% → 1★ 0.0% (nobody who compared rated 1–2★); free-cap complaint 0.2% → 6.0% → 3.6% → 66.7% → 31.0%; direct payer 7.0 / 6.9 / 7.1 / 6.7 / 17.2%; price 1.0 / 5.2 / 14.3 / 6.7 / 13.8%; subscription 0 / 1.7 / 10.7 / 6.7 / 13.8%; sync failure 0.3 / 5.2 / 0 / 6.7 / 13.8%; bugs 1.3 / 5.2 / 14.3 / 13.3 / 10.3%; localisation 1.0 / 2.6 / 14.3 / 0 / 10.3%

- **Where:** §4.6 Theme × rating cross-tabulation (verbatim table) — comparison victory falls monotonically to zero (24.1 → 6.9 → 3.6 → 0 → 0); free-tier cap nearly absent from 5★ (0.2%) and dominates 2★ (66.7%); direct payer 17.2% of 1★ — 'the app wins every fight it is allowed to have, and the cap decides how many fights it gets'
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 5★ (627) | 4★ (116) | 3★ (28) | 2★ (15) | 1★ (29) ; Comparison victory | 24.1% | 6.9% | 3.6% | 0.0% | 0.0% ; Simplicity praise | 47.5% | 27.6% | 10.7% | 13.3% | 10.3% ; Design praise | 38.9% | 25.9% | 21.4% | 13.3% | 6.9% ; Behaviour change | 4.9% | 0.9% | 0.0% | 0.0% | 0.0% ; Widgets | 14.2% | 12.9% | 14.3% | 6.7% | 6.9% ; Cross-device / sync (praise) | 10.4% | 12.9% | 14.3% | 6.7% | 17.2% ; Direct payer | 7.0% | 6.9% | 7.1% | 6.7% | 17.2% ; Free-tier cap complaint | 0.2% | 6.0% | 3.6% | 66.7% | 31.0% ; Price objection | 1.0% | 5.2% | 14.3% | 6.7% | 13.8% ; Subscription objection | 0.0% | 1.7% | 10.7% | 6.7% | 13.8% ; Sync failure | 0.3% | 5.2% | 0.0% | 6.7% | 13.8% ; Bugs / performance | 1.3% | 5.2% | 14.3% | 13.3% | 10.3% ; Localization missing | 1.0% | 2.6% | 14.3% | 0.0% | 10.3%
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C005 Know which competitors buyers compare against; C007 Generous fixed habit cap (or unlimited) — never change it

### R41-119 — When the free tier shows the product well, purchase decisions take hours, not weeks: 'I bought the lifetime after trying it for like 20 minutes'; 'after using this for one day, I bought the premium version'; 'Tried it for a few hours for free and was immediately convinced'; 'I wanted to test it for a week… but after only a few days I was happy to upgrade'

- **Where:** §5.2 #8 Speed of the decision — 'I bought the lifetime after trying it for like 20 minutes'; 'after using this for one day'; 'Tried it for a few hours for free and was immediately convinced'; 'after only a few days I was happy to upgrade'
- **This app does:** 3 free habits + lifetime
- **User reaction:** purchase-driver
- **Magnitude:** 4 reviews
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `12402418635`, `11842019567`, `12893034917`, `7830570783`
- **Canonical:** C147 Let people use the product before they pay

### R41-122 — The product converts on trust — the absence of a subscription trap, a visible comparison win, a human on the other end, and a decision made in hours or days; the cap is a real but fourth trigger

- **Where:** §5.2 Interpretation — triggers 1, 2, 3 and 8 describe a product that converts on trust: no subscription trap, a visible comparison win, a human on the other end, a decision in hours or days
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** triggers 1, 2, 3, 8
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C059 Be visibly responsive; fixes bring reviewers back

### R41-123 — Lifetime buyers stay satisfied for years: 'Bought lifetime access over a year ago and this is still the best habit tracker out there'; 'using it almost continuously for the past 2 years'; 'using Awesome Habits for three years'; 'It is worth the absolutely fair (!) price of only 25 euros for the lifetime version to me' (DE, Jul 2026); within payers — support praise 7, comparison victory 12, stats unlock and sync

- **Where:** §5.3 What paid users value after buying — support 7, comparison 12, stats unlock and sync; long-horizon payers ('Bought lifetime access over a year ago and this is still the best habit tracker out there'; 2–3 years of use); 'Es ist mir den absolut fairen (!) Preis von nur 25 Euro für die Lifetime-Version wert'
- **This app does:** lifetime €25
- **User reaction:** praise
- **Magnitude:** payers: support 7, comparison 12
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `14511086289`, `12367909395`, `12893154534`, `13125981351`, `12459206032`, `14298082271`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R41-129 — Payer churn is caused by mechanisms, not the product, and names the condition for return: 5 reviews (0.61%, mean 2.60) — 'I have cancelled my subscription but I will buy the paid subscription back if the developer implements easy normal Bluetooth sync between the phone and the watch' (refuses iCloud); no in-app cancellation path; on trial and 'likely will cancel unless these issues are resolved' (Health habits not markable; support link opens Mail); refund refused; deleted and bought a competitor over the subscription model

- **Where:** §5.6 Cancellation, refunds and churn among payers — 5 (0.61%, mean 2.60): cancelled but will buy back 'if the developer implements easy normal Bluetooth sync between the phone and the watch'; no in-app cancellation; on trial 'likely will cancel'; refund refused; deleted and bought a one-payment competitor — churn names a mechanism, two would come back
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 5 (0.61%), 2.60
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `9104605843`, `7205630038`, `11393377160`, `11450707006`, `6969311100`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C112 In-app cancellation

### R41-136 — Some pay a subscription precisely to fund longevity: a German reviewer deliberately chose the subscription over the one-time purchase because 'I want the app to still work in 3 years' (the only review making that argument) — while others reject €28 lifetime as too much ('viel zu teuer')

- **Where:** §6.3 Germany pricing reasoning in both directions — chose subscription over one-time 'ich will das die app auch noch in 3 Jahren funktioniert' (the only such argument); vs €28 lifetime too much (3★, 4★) and 'viel zu teuer'
- **This app does:** subscription + lifetime
- **User reaction:** mixed
- **Magnitude:** 1 vs 3
- **Direction for us:** research · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `8238514048`, `9473367265`, `9734433109`, `12234302996`
- **Canonical:** C196 A subscription is a promise of continued delivery — back it with a visible cadence

## Audiences

### R41-181 — Perfectionists and binary thinkers are a distinct audience served by partial credit: 'as someone who suffers from perfectionism and binary thinking it means that accomplishment becomes far more nuanced and relative - you're never thinking about the cliff edge of losing a streak' — the reason they 'bought over the hundreds of habit apps i browsed'

- **Where:** §3.2.4 perfectionism and binary thinking — the percentage ring as the reason a perfectionist bought
- **This app does:** % ring
- **User reaction:** purchase-driver
- **Magnitude:** n=1 (the most analytically useful review)
- **Direction for us:** build-free · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `13969274929`
- **Canonical:** C201 A user-set partial-completion threshold — a 'good day' below 100%; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R41-182 — Students and lower-purchasing-power users want to pay but cannot at current prices: 'Im a highschool student… cant you guys add like a student deal somehow?' (3★); 'the one time purchase fee is a bit too much, at least in my country' (TR, 5★); 'I love the app but I can't afford to pay' (AU, 4★)

- **Where:** §5.5 Affordability — 'Im a highschool student… cant you guys add like a student deal somehow?'; §3.3.2 purchasing power
- **This app does:** no student / regional price
- **User reaction:** blocked-conversion
- **Magnitude:** 3 reviews
- **Direction for us:** research · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `8278322299`, `13528830783`, `11580359210`
- **Canonical:** C025 Scholarship / hardship / discount program; C092 Regional pricing

## Markets and languages

### R41-018 — A missing language blocks purchase: 16 requests (1.96%, mean 3.56) — Russian ×5, Spanish ×4, Portuguese ×2, German, French, Czech, Italian, general; zero from US or GB — one explicit: 'le falta el idioma español, es por eso que aún no acabo de lanzarme a comprarla, y no le pongo las 5 estrellas' ('it lacks Spanish, that's why I haven't bought it and why I'm not giving 5 stars'); Russian is the largest unserved language and not on the listing's 11-language list

- **Where:** Executive summary #9 — localisation is a live, converting lever: 16 missing-language requests (1.96%, mean 3.56; Russian ×5, Spanish ×4, Portuguese ×2, German, French, Czech, Italian, general; zero US/GB); 'le falta el idioma español, es por eso que aún no acabo de lanzarme a comprarla'
- **This app does:** 11 languages; no Russian
- **User reaction:** blocked-conversion
- **Magnitude:** 16 (1.96%), 3.56; Russian 5
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `6329018597`, `10440246972`, `10635939819`, `11205195054`, `11398546682`, `11733827091`, `11786388052`, `11804482599`, `11872139244`, `13299630252`, `13309363635`, `13502703203`, `13509177027`, `13580190550`, `13958217751`, `14099685276`
- **Canonical:** C027 Localise early — it unlocks revenue

### R41-020 — Canada (n = 51, limited evidence) is the weakest analysable market and weak on price: mean 4.353 vs US 4.627, DE 4.582, GB 4.672; the highest rate of every monetisation objection — price 4/51 (7.84% vs 2.58% global), subscription 3/51 (5.88% vs 1.23%), free cap 3/51 (5.88% vs 3.44%) — yet the highest direct-payer rate (7/51, 13.7%): an actively split market — 'not worth 30 bucks annually' (1★); 'I could see maybe paying a one time fee of under $5' (1★); 'The app is excellent… Yet, I think it's over-priced'; 'I will switch to another one just to avoid the subscription'

- **Where:** Executive summary #10 — Canada is the weakest of the four markets and weak for one reason: price — CA 4.353; price objection 7.84% (global 2.58%), subscription objection 5.88% (1.23%), cap 5.88% (3.44%); highest payer rate 13.7% — an actively split market
- **This app does:** CAD pricing
- **User reaction:** mixed
- **Magnitude:** CA 4.353; price 7.84%; sub 5.88%; cap 5.88%; payers 13.7%
- **Direction for us:** research · **Report confidence:** limited evidence (n=51), internally consistent · **Generalisable:** yes
- **Review IDs:** `8460171885`, `12131335894`, `12109867402`, `11790255448`, `9710705599`, `8077884105`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C062 Weight English-speaking rich markets; volume ≠ revenue; C064 Price level — where 'fair' turns into 'too expensive'

### R41-080 — The interactive widget sells harder in the US and UK: widgets appear in 17.4% of US and 18.8% of GB reviews vs 9.9% of DE and 9.8% of CA (limited evidence)

- **Where:** §3.2.5 widgets carry 17.4% of US and 18.8% of GB reviews but only 9.9% of DE and 9.8% of CA — interactive widget a stronger selling point in the English-language high-volume markets (limited evidence)
- **This app does:** interactive widgets
- **User reaction:** praise
- **Magnitude:** US 17.4 · GB 18.8 · DE 9.9 · CA 9.8%
- **Direction for us:** build-free · **Report confidence:** limited evidence · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free; C062 Weight English-speaking rich markets; volume ≠ revenue

### R41-132 — Storefront distribution: US 201 (24.7%, 4.627; 156/29/8/2/6), DE 91 (11.2%, 4.582; 66/18/4/0/3), GB 64 (7.9%, 4.672; 53/5/3/2/1), CA 51 (6.3%, 4.353; 34/10/2/1/4), AU 40 (4.725; zero 1–2★), FR 30 (4.600), ES 21 (4.333), CZ 20 (4.800); NL 19, PL 19, BR 18, CH 18, MX 18, BE 15, IN 14, UA 12, SA 11, TR 11; 47 further ≤ 8

- **Where:** §6.1 Distribution (verbatim table) — US 201 (4.627), DE 91 (4.582), GB 64 (4.672), CA 51 (4.353), AU 40 (4.725), FR 30 (4.600), ES 21 (4.333), CZ 20 (4.800); NL 19 · PL 19 · BR 18 · CH 18 · MX 18 · BE 15 · IN 14 · UA 12 · SA 11 · TR 11; 47 further ≤ 8
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | % of corpus | Mean ★ | 5★ | 4★ | 3★ | 2★ | 1★ ; US | 201 | 24.7% | 4.627 | 156 | 29 | 8 | 2 | 6 ; DE | 91 | 11.2% | 4.582 | 66 | 18 | 4 | 0 | 3 ; GB | 64 | 7.9% | 4.672 | 53 | 5 | 3 | 2 | 1 ; CA | 51 | 6.3% | 4.353 | 34 | 10 | 2 | 1 | 4 ; AU | 40 | 4.9% | 4.725 | 31 | 7 | 2 | 0 | 0 ; FR | 30 | 3.7% | 4.600 | 21 | 8 | 0 | 0 | 1 ; ES | 21 | 2.6% | 4.333 | 12 | 7 | 0 | 1 | 1 ; CZ | 20 | 2.5% | 4.800 | 19 | 0 | 0 | 0 | 1 ; NL 19 · PL 19 · BR 18 · CH 18 · MX 18 · BE 15 · IN 14 · UA 12 · SA 11 · TR 11 |  |  |  |  |  |  |  | ; 47 further storefronts with ≤8 reviews each |  |  |  |  |  |  |  |
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R41-133 — The US is the power-user market and the lifetime option absorbs its subscription objection: Shortcuts 7.0% (4.4% global), statistics 10.9% (6.6%), widgets 17.4% (13.6%), motivation 11.4%, support 10.9%, behaviour change 6.0% (3.9%), lifetime mentioned 14.4% (9.9%); the lowest monetisation friction of the four (6 of 201, 3.0% vs CA 9 of 51, 17.6%): cap 2.0%, price 1.0%, subscription 0.0%; bugs 4.0%

- **Where:** §6.2 United States — n = 201, mean 4.627 (verbatim table) — the power-user market: leads on Shortcuts 7.0%, statistics 10.9%, widgets 17.4%, behaviour change 6.0%; lowest monetisation friction (6 of 201, 3.0% vs CA 17.6%); zero subscription objection; lifetime mentioned by 14.4% — absorbed the objection
- **This app does:** lifetime + subscription
- **User reaction:** praise
- **Magnitude:** Theme | US n | US % | Global % | Read ; Simplicity praise | 86 | 42.8% | 41.5% | at global ; Design praise | 69 | 34.3% | 34.8% | at global ; Comparison victory | 37 | 18.4% | 19.6% | at global ; Widgets | 35 | 17.4% | 13.6% | above global ; Cross-device | 25 | 12.4% | 11.0% | above global ; Support praise | 22 | 10.9% | 8.1% | above global ; Statistics | 22 | 10.9% | 6.6% | above global ; Motivation | 23 | 11.4% | 7.5% | above global ; Shortcuts | 14 | 7.0% | 4.4% | above global ; Behaviour change | 12 | 6.0% | 3.9% | above global ; Direct payer | 16 | 8.0% | 7.4% | at global ; Lifetime option mentioned | 29 | 14.4% | 9.9% | above global ; Free-tier cap complaint | 4 | 2.0% | 3.4% | below global ; Price objection | 2 | 1.0% | 2.6% | below global ; Subscription objection | 0 | 0.0% | 1.2% | below global ; Localization missing | 0 | 0.0% | 2.0% | n/a (English storefront) ; Bugs / performance | 8 | 4.0% | 2.8% | above global
- **Direction for us:** build-paid · **Report confidence:** US standalone · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C062 Weight English-speaking rich markets; volume ≠ revenue

### R41-134 — US low ratings: all 6 US 1★ — Watch sync requires iCloud (payer cancelled), a mis-rated 'Excellent', the free cap, 'Used to be good, not good anymore', cap + price, 'functionally a paid app' (three of six are the cap / requirement to pay); US 2★ (2) — a payer's missing widget and an unresponsive unit picker

- **Where:** §6.2 US 1★ reviews (all 6): Watch sync requires iCloud (payer cancelled); mis-rated 'Excellent'; cap; 'Used to be good, not good anymore'; cap + price; 'functionally a paid app' — three of six cap / requirement to pay; US 2★ (2): payer missing widget; unresponsive unit picker
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** US 1★ 6; 2★ 2
- **Direction for us:** none · **Report confidence:** US standalone · **Generalisable:** app-specific
- **Review IDs:** `9104605843`, `11802469749`, `11985104724`, `12581578919`, `13563498977`, `13627048536`, `7074903245`, `8379900610`
- **Canonical:** — (nuance register)

### R41-135 — Germany is the aesthetic / minimalism market: simplicity 50.5% and design 45.1% (the highest of any analysable market), comparison 23.1%, cross-device 14.3%, payer 9.9%; widgets 9.9% (below global); sync failure 3.3% (above global); characteristic reviews are long, comparative, design-led — 'Klares schlichtes Design. Herausragende Statistiken. Faires Bezahlmodell.'; 'This is the last habit app you will ever install'; 1★ (3): widget didn't work (2021), battery drain (2023), objects to paying at all (2026); zero 2★

- **Where:** §6.3 Germany — n = 91, mean 4.582 (verbatim table) — the aesthetic/minimalism market: simplicity 50.5%, design 45.1%; widgets below global 9.9%; sync failure 3.3% above global; 'Klares schlichtes Design. Herausragende Statistiken. Faires Bezahlmodell.'; 'Das ist die letzte Habit App die ihr installieren werdet'; 1★ (3): widget 2021, battery drain 2023, objects to paying 2026; zero 2★
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | DE n | DE % | Global % | Read ; Simplicity praise | 46 | 50.5% | 41.5% | well above global ; Design praise | 41 | 45.1% | 34.8% | well above global ; Comparison victory | 21 | 23.1% | 19.6% | above global ; Cross-device | 13 | 14.3% | 11.0% | above global ; Direct payer | 9 | 9.9% | 7.4% | above global ; Widgets | 9 | 9.9% | 13.6% | below global ; Sync failure | 3 | 3.3% | 1.6% | above global ; Price objection | 2 | 2.2% | 2.6% | at global ; Free-tier cap | 2 | 2.2% | 3.4% | below global ; Localization missing | 2 | 2.2% | 2.0% | at global
- **Direction for us:** none · **Report confidence:** DE standalone · **Generalisable:** yes
- **Review IDs:** `11500845940`, `12395956072`, `8384484490`, `11286668790`, `14298082271`, `12367909395`, `7911454356`, `9995917469`, `14169218014`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R41-137 — The UK is the best market and its profile explains why: comparison victory 28.1%, simplicity 53.1%, design 42.2%, widgets 18.8%, behaviour change 10.9%, Watch 10.9%, lifetime mentioned 18.8%, payer 12.5% — the highest of the four — and zero free-cap complaints; its only friction is the subscription form (4.7%, all three arguing for one-time purchase); it also produced the percentage-ring analysis and the fullest competitor-displacement narratives

- **Where:** §6.4 United Kingdom — n = 64, mean 4.672 (verbatim table) — the best market: highest comparison victory 28.1%, behaviour change 10.9%, widgets 18.8%, lifetime mentioned 18.8%, payer 12.5%; zero free-cap complaints; friction purely about subscription form (4.7%) — all three arguing for one-time purchase
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | GB n | GB % | Global % | Read ; Simplicity praise | 34 | 53.1% | 41.5% | highest of four markets ; Design praise | 27 | 42.2% | 34.8% | well above global ; Comparison victory | 18 | 28.1% | 19.6% | highest of four markets ; Widgets | 12 | 18.8% | 13.6% | highest of four markets ; Behaviour change | 7 | 10.9% | 3.9% | highest of four markets ; Apple Watch | 7 | 10.9% | 6.4% | above global ; Lifetime option mentioned | 12 | 18.8% | 9.9% | highest of four markets ; Direct payer | 8 | 12.5% | 7.4% | above global ; Free-tier cap complaint | 0 | 0.0% | 3.4% | zero ; Subscription objection | 3 | 4.7% | 1.2% | above global ; Localization missing | 0 | 0.0% | 2.0% | n/a
- **Direction for us:** build-paid · **Report confidence:** GB standalone · **Generalisable:** yes
- **Review IDs:** `6969311100`, `10949796422`, `11755092191`, `13969274929`, `14442200757`, `14342654245`, `12128314444`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C062 Weight English-speaking rich markets; volume ≠ revenue

### R41-138 — Canada: design 45.1%, simplicity 37.3%, comparison 17.6%, payer 13.7% (highest), price objection 7.8% (3× global), subscription objection 5.9% (5×), free cap 5.9%, bugs 5.9%, widgets 9.8%, behaviour change 2.0% — the most price-sensitive and most-converting market; three of four 1★ are monetisation, the fourth a payer blocked on backfill; objectors name 'under $5' one-time and frame it competitively ('There are many free apps that do the same thing. I will switch to another one just to avoid the subscription') — n = 51, direction supported, magnitude uncertain

- **Where:** §6.5 Canada — n = 51, mean 4.353 (verbatim table) — most price-sensitive and most-converting: 9 of 51 (17.6%) monetisation objection, payer 13.7%; three of four 1★ monetisation, fourth a payer blocked on backfill; 'There are many free apps that do the same thing. I will switch to another one just to avoid the subscription'; limited evidence — direction supported, magnitude uncertain
- **This app does:** CAD pricing
- **User reaction:** mixed
- **Magnitude:** Theme | CA n | CA % | Global % | Read ; Design praise | 23 | 45.1% | 34.8% | well above global ; Simplicity praise | 19 | 37.3% | 41.5% | below global ; Comparison victory | 9 | 17.6% | 19.6% | at global ; Direct payer | 7 | 13.7% | 7.4% | highest of four markets ; Price objection | 4 | 7.8% | 2.6% | 3× global ; Subscription objection | 3 | 5.9% | 1.2% | 5× global ; Free-tier cap complaint | 3 | 5.9% | 3.4% | above global ; Bugs / performance | 3 | 5.9% | 2.8% | above global ; Widgets | 5 | 9.8% | 13.6% | below global ; Behaviour change | 1 | 2.0% | 3.9% | below global
- **Direction for us:** research · **Report confidence:** limited evidence (n=51) · **Generalisable:** yes
- **Review IDs:** `8460171885`, `9710705599`, `12131335894`, `6649330433`, `11790255448`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C064 Price level — where 'fair' turns into 'too expensive'

### R41-139 — High-spend markets (US, JP, CN, GB, DE, KR, FR, CA, AU from public 2025 spend rankings; JP + CN + KR only 13 reviews, so effectively US / GB / DE / CA / FR / AU) vs rest: n 490 vs 325; mean 4.604 vs 4.572; self-reported payer 9.59% vs 4.00% (2.4×); free-cap complaint 2.24% vs 5.23% (the cap hurts 2.3× more outside — BA, FI, HU, PL, RO, TR, IN, ES, BE, PT, BR, MX); price 2.24 vs 3.08%; subscription objection 9 of 10 inside the group (users with enough subscriptions to object to the form, not the amount — the group lifetime was built for); localisation 0.82 vs 3.69% (4.5×); comparison 21.63 vs 16.62%; cross-device 13.06 vs 8.00%; behaviour change 5.10 vs 2.15% (likely review-writing convention)

- **Where:** §6.6 High-spend market group (verbatim table) — US, JP, CN, GB, DE, KR, FR, CA, AU; JP+CN+KR only 13 (1.6%); 490 vs 325: payer 9.59% vs 4.00% (2.4×); cap 2.24% vs 5.23% (2.3×); subscription objection 9 of 10 inside; localisation 0.82% vs 3.69% (4.5×); comparison 21.63 vs 16.62; cross-device 13.06 vs 8.00; behaviour change 5.10 vs 2.15
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Metric | High-spend group (9) | Rest of world (58) ; n | 490 (60.1%) | 325 (39.9%) ; Mean rating | 4.604 | 4.572 ; Direct payer | 47 (9.59%) | 13 (4.00%) ; Free-tier cap complaint | 11 (2.24%) | 17 (5.23%) ; Price objection | 11 (2.24%) | 10 (3.08%) ; Subscription objection | 9 (1.84%) | 1 (0.31%) ; Localization missing | 4 (0.82%) | 12 (3.69%) ; Comparison victory | 106 (21.63%) | 54 (16.62%) ; Cross-device praise | 64 (13.06%) | 26 (8.00%) ; Behaviour change | 25 (5.10%) | 7 (2.15%)
- **Direction for us:** research · **Report confidence:** group (caveated) · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R41-140 — The app's satisfaction is global; its monetisation is not: the high-review-volume four (US, DE, GB, CA; 407) and the 63-storefront tail (408) have identical means (4.590 vs 4.593) but the four self-report paying at 9.83% vs 4.90%, hit the cap at 2.21% vs 4.66%, need a language at 0.49% vs 3.43%, praise design 39.31 vs 30.39%, cross-device 14.00 vs 8.09%, behaviour change 5.65 vs 2.21% (review-volume proxy only)

- **Where:** §6.7 High-review-volume market group (verbatim table) — US, DE, GB, CA 407 vs 408: identical means 4.590 vs 4.593; payer 9.83% vs 4.90%; cap 2.21% vs 4.66%; localisation 0.49% vs 3.43% — satisfaction is global, monetisation is not
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Metric | High-volume 4 | Sub-50 storefronts (63) ; n | 407 (49.9%) | 408 (50.1%) ; Mean rating | 4.590 | 4.593 ; Direct payer | 40 (9.83%) | 20 (4.90%) ; Free-tier cap complaint | 9 (2.21%) | 19 (4.66%) ; Localization missing | 2 (0.49%) | 14 (3.43%) ; Comparison victory | 85 (20.88%) | 75 (18.38%) ; Design praise | 160 (39.31%) | 124 (30.39%) ; Cross-device praise | 57 (14.00%) | 33 (8.09%) ; Behaviour change | 23 (5.65%) | 9 (2.21%)
- **Direction for us:** research · **Report confidence:** group · **Generalisable:** yes
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R41-141 — Non-English markets like the product as much but convert at half the rate for two fixable reasons — the cap and the language: non-English storefronts 453 (55.6%), mean 4.581 (same as English); cap complaints 4.19% vs 1.9%; localisation requests 3.53% vs 0%; self-reported payers 5.52% vs 9.9%

- **Where:** §6.8 Non-English storefronts — n = 453 (55.6%), mean 4.581, indistinguishable; cap complaints 4.19% vs 1.9%; localisation 3.53% vs 0%; payer 5.52% vs 9.9% — like it as much, convert at roughly half the rate; two fixable causes: the cap and the language
- **This app does:** 3-habit cap; 11 languages
- **User reaction:** blocked-conversion
- **Magnitude:** 453; cap 4.19 vs 1.9; loc 3.53 vs 0; payer 5.52 vs 9.9
- **Direction for us:** product-rule · **Report confidence:** group · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C027 Localise early — it unlocks revenue

### R41-142 — Russian is the largest unserved language, requested from five unrelated storefronts — Armenia, Belarus, Kyrgyzstan, Turkey, Indonesia — none ≥ 50 reviews, and absent from the 11-language listing (limited evidence; recorded for the convergence)

- **Where:** §6.9 #1 Russian-language demand across five separate storefronts — AM, BY, KG, TR, ID; largest single-language request; absent from the 11-language listing (limited evidence, convergence)
- **This app does:** no Russian
- **User reaction:** blocked-conversion
- **Magnitude:** 5 across AM, BY, KG, TR, ID
- **Direction for us:** build-free · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `14099685276`, `11733827091`, `10440246972`, `13958217751`, `11872139244`
- **Canonical:** C027 Localise early — it unlocks revenue

### R41-143 — Australia (n = 40, limited evidence) has the highest mean in the corpus (4.725) with zero 1★ and 2★; AU$40 lifetime quoted

- **Where:** §6.9 #2 Australia (n = 40) highest mean 4.725, zero 1★ and 2★; AU$40 lifetime data point
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 40, mean 4.725
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `12347225054`
- **Canonical:** — (nuance register)

### R41-145 — Spain (n = 21, mean 4.333, limited evidence): three Spanish-language requests (plus Chile) April–October 2024, including one entire 1★ review 'Spanish', despite Spanish appearing on the listing — open question

- **Where:** §6.9 #4 Spain (n = 21, mean 4.333) carries three Spanish-language requests (+ CL) Apr–Oct 2024 despite Spanish on the listing — open question
- **This app does:** Spanish listed
- **User reaction:** complaint
- **Magnitude:** 3 + 1
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `11786388052`, `11398546682`, `11205195054`, `11804482599`
- **Canonical:** C027 Localise early — it unlocks revenue; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R41-165 — Experiment: Russian localisation — the largest unserved language; shipping a language produced an immediate 5★ response and a missing language blocked a purchase; measure volume, mean rating and payer self-reports in Russian-language storefronts over two quarters (explicitly limited evidence)

- **Where:** §8.2 E3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 5 requests across AM, BY, KG, TR, ID
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `14135424478`, `14139118342`, `11398546682`
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R41-025 — Year shape: 2020 51 (4.725) · 2021 81 (4.593) · 2022 95 (4.547) · 2023 84 (4.607) · 2024 235 (4.655, 28.8% volume peak) · 2025 173 (4.480, trough; 1★ 5.2%) · 2026 96 (4.594); first review 21 Jul 2020 asked for Apple Health ('will be great with Apple Health integration')

- **Where:** §1.4 Date range and shape — first review 21 Jul 2020 'prometteur :: sera super avec integration santé apple'; year table (verbatim); 2024 volume peak (28.8%); 2025 rating trough (4.480)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | % of corpus | Mean rating | 5★ | 4★ | 3★ | 2★ | 1★ ; 2020 (from 21 Jul) | 51 | 6.3% | 4.725 | 80.4% | 15.7% | 2.0% | 0.0% | 2.0% ; 2021 | 81 | 9.9% | 4.593 | 74.1% | 18.5% | 2.5% | 2.5% | 2.5% ; 2022 | 95 | 11.7% | 4.547 | 76.8% | 11.6% | 4.2% | 4.2% | 3.2% ; 2023 | 84 | 10.3% | 4.607 | 77.4% | 14.3% | 3.6% | 1.2% | 3.6% ; 2024 | 235 | 28.8% | 4.655 | 79.6% | 14.0% | 1.7% | 1.7% | 3.0% ; 2025 | 173 | 21.2% | 4.480 | 72.8% | 15.0% | 4.6% | 2.3% | 5.2% ; 2026 (to 4 Sep) | 96 | 11.8% | 4.594 | 78.1% | 11.5% | 6.2% | 0.0% | 4.2%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `6225355454`, `14511086289`
- **Canonical:** — (nuance register)

### R41-026 — Feature inventory with first-seen dates: build and break-a-habit modes (2020-08); daily / weekly / monthly goal grouping visible at once (2021-05); countable goals with over-achievement (2020-10); per-habit timer + Live Activities (2020-08); daily completion percentage ring (2020-12); interactive Home / Lock Screen widgets (2020-12); Watch app + complications (2020-08); macOS + iPadOS apps, iCloud sync, no account (2020-08); Apple Health (2021-12); Siri Shortcuts near-full control (absent Jan 2022 → shipped); lists / tags with per-list rings and widget filtering (2022-01); 2,500+ icons, colours; notes / descriptions / URLs (requested → 2022-05); CSV export (2023-02, thanked); backup / restore / import (absent 2021 → 2022-09); streaks, history, trends, heat maps (2024-07); vacation mode (2023-12); skip-a-day (2020-08); archive (2024-05); custom day-start / week-start (2025-05); NFC tag check-off (2025-11); reminders with snooze actions (2022-10); Family Sharing (2024-07); Apple Intelligence habit suggestions (2025-09); localisations Czech (2025-10), Italian and Traditional Chinese (2026-06); SetApp distribution (2024-07)

- **Where:** §2.1 Feature inventory derived from reviews (verbatim table) with first-seen dates
- **This app does:** broad Apple-ecosystem feature set built incrementally
- **User reaction:** praise
- **Magnitude:** Capability | Review evidence | First seen ; Build-a-habit and break-a-habit modes (max-units per day) | 6299943358, 6654908328, 9269264887, 11143107142, 14342654245 | 2020-08 ; Daily / weekly / monthly goal grouping (all visible at once) | 7305149420, 10127928558, 12239848520, 14309794575 | 2021-05 ; Countable goals with over-achievement (log past the target) | 6521770373, 8716355592, 8852087228, 13548079058, 14039415546 | 2020-10 ; Built-in timer per habit (+ Live Activities) | 6305195053, 6367557684, 10128805896, 12059685717 | 2020-08 ; Daily completion percentage ring (partial credit, not pass/fail) | 6725250923, 9474747245, 11332444396, 13969274929 | 2020-12 ; Home Screen / Lock Screen interactive widgets | 6725250923, 11124760335, 12093784951, 13189731645 | 2020-12 ; Apple Watch app + complications | 6367557684, 7189304033, 8548761845, 11794653008 | 2020-08 ; macOS + iPadOS apps, iCloud sync, no account required | 6305195053, 6344341522, 11221350396, 13278332346 | 2020-08 ; Apple Health / HealthKit two-way-ish integration | 6225355454 (request), 8125782074, 10531421821, 12402418635 | 2021-12 ; Siri Shortcuts actions (near-full app control) | 8193089811 (absent, 2022-01) → 8234435754, 10128805896, 14481949708 | 2022-01 ; Lists / tags for grouping habits, per-list rings + widget filtering | 8196390701, 8473364655, 8716355592, 10531421821, 13228974860 | 2022-01 ; 2,500+ icons and emoji, colour customisation | 6339215858, 7618615484, 11289731845, 13139524384 | 2020-08 ; Notes / descriptions / URLs attached to habits | 6237078958 (request) → 8716355592, 9048646892, 12081925174 | 2022-05 ; CSV export | 9603969118 (thanks for shipping it), 12459206032, 13278332346 | 2023-02 ; Backup / restore and import | 6987131094 (absent, 2021-02) → 9047728455, 12239848520 | 2022-09 ; Streaks, history, trends, heat maps | 11456145500 (heat maps new), 13548079058, 14037275566 | 2024-07 ; Vacation / holiday mode | 10748623012, 14127120944, 14265211437 | 2023-12 ; Skip-a-day | 6305195053, 8656250182, 12239848520 | 2020-08 ; Archive habits | 11289731845, 11867342767 | 2024-05 ; Custom day-start / week-start day | 14352778355 (confirms it shipped), 12696061381 | 2025-05 ; NFC tag check-off | 13371878009 | 2025-11 ; Reminders with quick snooze actions | 9241698789, 10803926184, 12912541534 | 2022-10 ; Family Sharing | 11536341085 | 2024-07 ; Apple Intelligence habit suggestions | 13144867753 (*"I like the apple AI to help with ideas"*) | 2025-09 ; Localizations shipped during window | Czech 13309363635 (2025-10), Italian 14135424478 (2026-06), Traditional Chinese 14139118342 (2026-06) | 2025-10 ; SetApp distribution | 11526089864 (*"Assino pelo SetApp"*) | 2024-07
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Review IDs:** `6299943358`, `6654908328`, `7305149420`, `6521770373`, `6305195053`, `6725250923`, `11124760335`, `6367557684`, `6344341522`, `8125782074`, `8193089811`, `8234435754`, `8196390701`, `6339215858`, `6237078958`, `8716355592`, `9603969118`, `6987131094`, `9047728455`, `11456145500`, `10748623012`, `14127120944`, `11289731845`, `14352778355`, `13371878009`, `9241698789`, `11536341085`, `13144867753`, `11526089864`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R41-035 — Price objections tracked the lifetime price: lifetime roughly doubled from €22 (2021) to €28 (2023) then settled back to €22–25 / $22.99; the monthly rose from $1.99 to $4.99; price objections peaked in 2022 (4.2%) and 2025 (4.6%) and fell to zero in 2026 (0/96) — consistent with, not proof of, the lifetime price coming back down

- **Where:** §2.2 Interpretation — lifetime roughly doubled 2021 (€22) → 2023 (€28), then back toward €22–25 / $22.99; monthly $1.99 → $4.99; price objections peak 2022 (4.2%) and 2025 (4.6%), zero in 2026 (0/96) — consistent with lifetime price coming back down
- **This app does:** lifetime €22 → €28 → €22–25
- **User reaction:** mixed
- **Magnitude:** 2022 4.2%; 2025 4.6%; 2026 0/96
- **Direction for us:** research · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R41-081 — The free-cap complaint spiked in 2025 without a documented change: 2020 0/51 → 2021 3/81 (3.7%) → 2022 2/95 (2.1%) → 2023 2/84 (2.4%) → 2024 6/235 (2.6%) → 2025 11/173 (6.4%) → 2026 4/96 (4.2%); seven of the eleven 2025 complaints are pure paywall reviews with no other content — either the cap's presentation changed or users arrived from a channel that did not set the expectation of a paid app; unresolved

- **Where:** §3.3.1 Free-tier cap by year: 2020 0/51 → 2021 3/81 (3.7%) → 2022 2/95 (2.1%) → 2023 2/84 (2.4%) → 2024 6/235 (2.6%) → 2025 11/173 (6.4%) → 2026 4/96 (4.2%); 2025 spike — seven pure paywall reviews; either a change in how the cap is presented or a new channel without paid-app expectation (research question)
- **This app does:** 3-habit cap constant
- **User reaction:** complaint
- **Magnitude:** 2025 6.4% (11/173)
- **Direction for us:** research · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12131335894`, `12156551236`, `12202681717`, `12385678485`, `12470582996`, `12518959349`, `12659289186`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R41-147 — Headline series by year — n / mean / cap / price / comparison / payer / behaviour change / support: 2020 51 / 4.725 / 0.0 / 0.0 / 9.8 / 2.0 / 7.8 / 11.8; 2021 81 / 4.593 / 3.7 / 2.5 / 16.0 / 6.2 / 3.7 / 16.0; 2022 95 / 4.547 / 2.1 / 4.2 / 20.0 / 12.6 / 3.2 / 9.5; 2023 84 / 4.607 / 2.4 / 3.6 / 32.1 / 4.8 / 2.4 / 7.1; 2024 235 / 4.655 / 2.6 / 1.7 / 19.1 / 6.8 / 2.6 / 8.5; 2025 173 / 4.480 / 6.4 / 4.6 / 16.2 / 9.2 / 2.3 / 1.7; 2026 96 / 4.594 / 4.2 / 0.0 / 24.0 / 6.2 / 10.4 / 9.4; half-year means 2020H2 4.725 · 2021H1 4.571 · 2021H2 4.640 · 2022H1 4.434 · 2022H2 4.690 · 2023H1 4.477 · 2023H2 4.750 · 2024H1 4.642 · 2024H2 4.664 · 2025H1 4.406 · 2025H2 4.583 · 2026H1 4.569 · 2026H2 4.667

- **Where:** §7.1 The headline series (verbatim table) and half-year means — 2025H1 4.406 worst half-year
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Period | n | Mean ★ | Cap complaint | Price objection | Comparison victory | Direct payer | Behaviour change | Support praise ; 2020 (H2 only) | 51 | 4.725 | 0.0% | 0.0% | 9.8% | 2.0% | 7.8% | 11.8% ; 2021 | 81 | 4.593 | 3.7% | 2.5% | 16.0% | 6.2% | 3.7% | 16.0% ; 2022 | 95 | 4.547 | 2.1% | 4.2% | 20.0% | 12.6% | 3.2% | 9.5% ; 2023 | 84 | 4.607 | 2.4% | 3.6% | 32.1% | 4.8% | 2.4% | 7.1% ; 2024 | 235 | 4.655 | 2.6% | 1.7% | 19.1% | 6.8% | 2.6% | 8.5% ; 2025 | 173 | 4.480 | 6.4% | 4.6% | 16.2% | 9.2% | 2.3% | 1.7% ; 2026 (to 4 Sep) | 96 | 4.594 | 4.2% | 0.0% | 24.0% | 6.2% | 10.4% | 9.4%
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R41-148 — An unexplained 2025 H1 paywall event — dip then recovery: 2025 is the only year below 4.50 (4.480), driven by 2025H1 (4.406, the worst half-year); within 2025 cap complaints 6.4% (highest), price objections 4.6%, 1★ 5.2% (highest), seven content-free paywall reviews; 2025H2 recovered to 4.583 and 2026 to 4.594 with zero price objections — a price change, paywall redesign, acquisition-channel shift or App Store featuring cannot be distinguished

- **Where:** §7.2 Trend 1 — the 2025 dip is real, concentrated in H1, and a monetisation event: 2025 4.480 (only year < 4.50), 2025H1 4.406; cap 6.4%, price 4.6%, 1★ 5.2%; recovered 2025H2 4.583, 2026 4.594 with zero price objections — cause unknown (price change, paywall redesign, acquisition channel, App Store featuring)
- **This app does:** paywall encounter changed 2025H1 (unknown)
- **User reaction:** 1★-burst
- **Magnitude:** 2025 4.480; H1 4.406; cap 6.4; price 4.6; 1★ 5.2
- **Direction for us:** research · **Report confidence:** medium-high · **Generalisable:** yes
- **Review IDs:** `12131335894`, `12156551236`, `12202681717`, `12385678485`, `12470582996`, `12518959349`, `12659289186`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R41-149 — Comparison victory is not a launch honeymoon: 9.8% (2020) → 16.0 → 20.0 → 32.1% (2023, partly small-denominator) → 19.1 → 16.2 → 24.0% (2026); floor 16% for six years — roughly one reviewer in five still arrives from a comparison and says this app won

- **Where:** §7.3 Trend 2 — comparison victory persistent: 9.8% → 16.0 → 20.0 → 32.1% (2023, small denominator) → 19.1 → 16.2 → 24.0%; floor 16% across six years — not a launch-honeymoon artefact
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 9.8 → 32.1 → 24.0%
- **Direction for us:** none · **Report confidence:** high confidence · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against

### R41-150 — A maturing cohort reports outcomes: behaviour-change stories 7.8% (2020 launch) → 3.7 → 3.2 → 2.4 → 2.6 → 2.3 → 10.4% (2026, 10 of all 32 in a partial year), with multi-year tenure stated ('3 years', 'three years', 'over a year', 'since 2022') — a different marketing asset than first impressions (n = 96, provisional)

- **Where:** §7.4 Trend 3 — behaviour-change stories surged in 2026: 7.8% (2020) → 3.7 → 3.2 → 2.4 → 2.6 → 2.3 → 10.4% (2026); ten of 32 in 2026; a cohort maturing (multi-year tenure stated)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 2.3% (2025) → 10.4% (2026)
- **Direction for us:** do · **Report confidence:** emerging, medium · **Generalisable:** yes
- **Review IDs:** `13601624683`, `13833089535`, `13984268382`, `13993034824`, `14010059946`, `14056047525`, `14081110708`, `14489261806`, `14501021178`, `12766245644`, `13125981351`, `12893154534`, `14511086289`, `14334740214`
- **Canonical:** C134 Lead the store listing with what users actually love

### R41-151 — A one-person support asset is fragile at volume: support praise 11.8% (2020) → 16.0 → 9.5 → 7.1 → 8.5 → 1.7% (2025, 3 of 173) → 9.4% (2026), the 2025 collapse coinciding with the rating trough — either support capacity was strained after review volume tripled (84 in 2023 → 235 in 2024) or the 2025 cohort was paywall-bouncers who never contacted support (partly supported by the cap spike); recovered in 2026

- **Where:** §7.5 Trend 4 — support praise collapsed in 2025 (1.7%, 3 of 173) and recovered in 2026 (9.4%); 11.8 → 16.0 → 9.5 → 7.1 → 8.5 → 1.7 → 9.4; coincides with the 2025 trough; (a) one-developer capacity strained after volume tripled 84 → 235, or (b) 2025 cohort was paywall-bounce reviewers
- **This app does:** solo developer
- **User reaction:** complaint
- **Magnitude:** 1.7% 2025 vs 8.5–16.0 others
- **Direction for us:** must-have · **Report confidence:** watch-list, medium · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R41-152 — A shipped feature stops being news: Apple Watch discussion 2.0% (2020) → 13.6 (2021) → 13.7 (2022) → 10.7 → 2.1 (2024) → 5.2 → 4.2% — peaking right after the Watch app shipped, then normalising; Watch complaints are spread (2022, 2025, 2025), so declining discussion, not declining quality

- **Where:** §7.6 Trend 5 — Apple Watch discussion fell by two-thirds: 2.0 → 13.6 → 13.7 → 10.7 → 2.1 → 5.2 → 4.2%; peak after the Watch app shipped; normalisation, not regression (three complaints spread 2022, 2025, 2025)
- **This app does:** Watch app shipped 2021
- **User reaction:** praise
- **Magnitude:** 13.7% → 2.1%
- **Direction for us:** none · **Report confidence:** medium · **Generalisable:** yes
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R41-153 — A free cap that never moves while the product and category move becomes a compounding friction: cap complaints 0.0% (2020) → 3.7 → 2.1 → 2.4 → 2.6 → 6.4% (2025) → 4.2% (2026) — still above every year 2021–2024; the cap stayed at 3 while category norms, the feature surface and the price all moved

- **Where:** §7.7 Trend 6 — the free-tier cap is the only negative worse now than at launch: 0.0 → 3.7 → 2.1 → 2.4 → 2.6 → 6.4 → 4.2%; the cap stayed at 3 while category norms, feature surface and price moved — the one compounding friction
- **This app does:** 3-habit cap unchanged since launch
- **User reaction:** complaint
- **Magnitude:** 0.0 → 6.4 → 4.2%
- **Direction for us:** product-rule · **Report confidence:** worsening, high confidence · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R41-154 — Localisation demand keeps rising as languages ship, because the next demand is a different language: 2020 2.0% → 2021–22 0.0% → 2023 2.4% → 2024 2.6% → 2025 2.3% → 2026 3.1%, despite Czech (Oct 2025), Italian and Traditional Chinese (Jun 2026) shipping — principally Russian

- **Where:** §7.8 Trend 7 — localisation demand rising and being answered: 2.0% → 0.0 → 2.4 → 2.6 → 2.3 → 3.1%; not falling despite Czech, Italian, Traditional Chinese shipping, because demand is for different languages (Russian)
- **This app does:** shipping languages
- **User reaction:** complaint
- **Magnitude:** 0.0 → 3.1%
- **Direction for us:** build-free · **Report confidence:** medium · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R41-155 — What held for six years: simplicity and design praise at 35–50% every year; the frequency-flexibility request every year 2021–2026; the 'don't add anything' instruction every year 2021–2026; reliability defects in a 2–5% band with no era-level degradation and bugs at 0.0% in 2026 (0/96)

- **Where:** §7.9 What did not change — simplicity and design praise 35–50% every year; frequency gap every year 2021–2026; the 'don't add anything' instruction every year 2021–2026; reliability defects 2–5% band, bugs 0.0% in 2026 (0/96)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** six consecutive years
- **Direction for us:** product-rule · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `6982393836`, `8656250182`, `9906262176`, `12198311158`, `13971210487`, `8414522828`, `7164121278`, `9760491979`, `10691911378`, `11482024114`, `11574965608`, `11221350396`, `12239848520`, `13465174002`, `14489261806`, `14455804453`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C043 Flexible / custom frequency

## Positioning

### R41-001 — Awesome Habits: Habit Tracker (App Store ID 1514915737, 'Streaks, days since & goals') by solo developer Michal Tuma — freemium with a hard 3-habit free cap, unlocked by subscription or a one-time Lifetime Premium; listing (11 Sep 2026) Monthly $4.99, Yearly $12.99 (with trial), Lifetime $22.99; no advertising anywhere; iPhone, iPad, Mac, Watch, visionOS; iCloud sync with no account; 11 languages; also distributed via SetApp

- **Where:** header lines 1-8
- **This app does:** developer Michal Tuma; bundle com.dreamer.Habits; extracted 8 Sep 2026; analysed 11 Sep 2026; store rank 41; listing 4.8 from 925 ratings
- **User reaction:** praise
- **Magnitude:** 815 written reviews · 67 storefronts · 21 Jul 2020 → 4 Sep 2026; mean 4.591; 5:627 / 4:116 / 3:28 / 2:15 / 1:29
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `11526089864`
- **Canonical:** C005 Know which competitors buyers compare against

### R41-008 — The app wins head-to-head comparison shopping overwhelmingly: 160 reviews (19.63%, high-priority, mean 4.94) say they tried or compared multiple habit trackers and chose this one — 151 5★, 8 4★, 1 3★, not one 1–2★; 24.1% of all 5★ (151/627) — 'I've tried maybe 2 dozen habit-tracking apps and this is probably the best one'; 'I tested all habit apps over the last 15 years, this is by far the BEST!'; 'I have tried literally every habit tracker in the App Store and none came even close'

- **Where:** Executive summary #1 — wins head-to-head comparison shopping: 160 (19.63%, high-priority, mean 4.94); 151 5★, 8 4★, 1 3★, zero 1–2★; 24.1% of all 5★
- **This app does:** destination app
- **User reaction:** praise
- **Magnitude:** 160 (19.63%), 4.94; 151/8/1/0/0; 24.1% of 5★
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `7305149420`, `7323930695`, `8435023786`, `8482606810`, `8967436415`, `9761451102`, `10127928558`, `10874988299`, `11173751309`, `11286668790`, `11493203641`, `11511859366`, `12162498485`, `12459206032`, `13322024143`, `13833089535`, `14298082271`, `14489261806`, `11500845940`
- **Canonical:** C005 Know which competitors buyers compare against; C134 Lead the store listing with what users actually love

### R41-073 — Reviewers describe a search that ended, not just liking the app: 'I've been using apps for habit tracking for about 3 years, and probably tried at least 20 apps… THIS IS IT'; 'After installing apps like: WabiTime, Focus, Structured, Move On, Awakee, Habitify, Sorted, Mindlist, Habitica, and Habit Tracker. I finally settled with Awesome Habits'; 'I've tested each of them for at least two weeks… I was about to give up my long search'; 'Das Ende meiner Suche'; 'the one I keep coming back to'

- **Where:** §3.2.1 Comparison victory — reviewers describe a search that ended: 'I've spent MANY hours today looking for a habit tracker that I could customize like this'; 'probably tried at least 20 apps… THIS IS IT'; 'After installing apps like: WabiTime, Focus, Structured, Move On, Awakee, Habitify, Sorted, Mindlist, Habitica, and Habit Tracker. I finally settled'; 'tested each of them for at least two weeks'; 'Das Ende meiner Suche'
- **This app does:** destination
- **User reaction:** praise
- **Magnitude:** 160 (19.63%), 4.94
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `6345974473`, `7305149420`, `8967436415`, `12459206032`, `14298082271`, `13833089535`
- **Canonical:** C005 Know which competitors buyers compare against

### R41-074 — Streaks is the named benchmark and is being displaced: 21 reviews (2.58%) — 'I loved Streaks, but hated its UI. This app has replaced Streaks for me'; 'I've outgrown the Streaks app'; 'Have been using Steaks for 2 years… this is slightly better in so many ways'; 'better than Streaks in my opinion. The sync is not as buggy'; 'beats it in terms of simplicity and usability'; 'Streaks has a limit of 12 due to their design' — one counter: 'Great alternative to Streaks… cloud synch stopped working'; other displacements from Done, Strides, Habitify, Grit and Loop (Android)

- **Where:** §3.2.1 Sub-finding — Streaks is the named benchmark: 21 (2.58%, meaningful), framed as displacement ('I loved Streaks, but hated its UI'; 'I've outgrown the Streaks app'; 'better than Streaks… The sync is not as buggy'; 'Streaks has a limit of 12 due to their design'); other displacements Done, Strides, Habitify, Grit, Loop on Android
- **This app does:** alternative to Streaks
- **User reaction:** praise
- **Magnitude:** Streaks 21 (2.58%)
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11900786735`, `13220567750`, `14442200757`, `14342654245`, `10308502629`, `12198311158`, `7164121278`, `8548761845`, `12366262022`, `12128314444`, `10949796422`, `12682557463`, `11839032938`, `13969274929`, `14037275566`, `13817327271`, `14489261806`, `8584016453`, `9713136543`, `11794653008`, `8125782074`, `8716355592`, `12735681948`, `12402418635`, `8384484490`
- **Canonical:** C005 Know which competitors buyers compare against

### R41-117 — Working Apple Health habits win switchers: 'Coming from Grit, I almost instantly bought it because the Apple Health habits actually work'

- **Where:** §5.2 #6 Apple Health actually working vs a competitor's — 'Coming from Grit, I almost instantly bought it because the Apple Health habits actually work'
- **This app does:** Health integration
- **User reaction:** purchase-driver
- **Magnitude:** n=1
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `12402418635`
- **Canonical:** C005 Know which competitors buyers compare against; C021 Apple Health integration

### R41-131 — Positioned as the value option: 6 reviews place the price at the low / fair end — 'The non-subscription price… is in the middle of the range… affordable to all'; 'My favourite app was Strides but I refused to pay the almost £80 premium. This app saved the day'; 'their heavy subscription based pricing was not worth the features'; 'the developers are greedy and want you to pay 5$ a week for some extra symbols'; 'Also cheaper than comparable apps'; 'the prettiest and the cheapest' — vs 1 'on the more expensive side'; with 21 price objections (2.58%), price is not the category problem, the requirement to pay at habit #4 is

- **Where:** §5.7 Competitive price position — 6 position it as the value option ('in the middle of the range… affordable to all'; 'My favourite app was Strides but I refused to pay the almost £80 premium'; 'developers are greedy and want you to pay 5$ a week for some extra symbols'; 'Ook goedkoper dan vergelijkbare apps'; 'die schönste und günstigste'), 1 as expensive — price is not the category problem, the requirement to pay at habit #4 is
- **This app does:** $22.99 lifetime, $12.99/yr
- **User reaction:** praise
- **Magnitude:** 6 value vs 1 expensive; price objection 21
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `7164121278`, `12128314444`, `8548761845`, `9400089129`, `8508744579`, `9613355739`, `10245394136`
- **Canonical:** C004 Price low and fair, anchored against subscription competitors

## Anti-patterns

### R41-183 — Two self-inflicted revenue mistakes with a measured cost: the lifetime SKU the audience buys for became intermittently invisible (3–4 would-be buyers unable to pay, 2023–2024, one with no purchase entry at all), and a Home Screen widget was shown in listing screenshots while still 'coming soon', producing a 2★ from a payer and a 'this is a scam' review

- **Where:** §5.4 / §5.5 — lifetime SKU intermittently invisible and a Home Screen widget sold in screenshots before it shipped
- **This app does:** lifetime hidden; screenshots ahead of product
- **User reaction:** blocked-conversion
- **Magnitude:** 3–4 blocked; 2 widget-purchase failures
- **Direction for us:** dont · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `12128314444`, `11360590820`, `10195683230`, `10901569398`, `7074903245`, `13276009260`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

## Things not to do

### R41-108 — Never ask for a review daily or after the user has rated: 'it asks for a review every day which is needlessly annoying even if you've rated the app' (CH, 1★, Aug 2026 — the only review-prompt complaint, notable because the corpus mean is partly a function of prompting); plus an unexplained 'Used to be good, not good anymore' (US, 1★, Apr 2025)

- **Where:** §4.5 Two unexplained 1★ regression signals — 'Used to be good, not good anymore' (Apr 2025); 'it asks for a review every day which is needlessly annoying even if you've rated the app' (Aug 2026) — the only review-prompt complaint, notable since the rating mean is partly a function of prompting
- **This app does:** daily review prompt (2026)
- **User reaction:** 1★-burst
- **Magnitude:** 1 + 1 (1★)
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `14406073990`, `12581578919`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R41-127 — Never show an unshipped feature in store screenshots: a buyer paid for the Home Screen widget advertised in the listing screenshots while it was 'coming soon' (2★, 2021), and another says 'there are no widgets for this app which was the entire reason I bought it. The preview looks nothing like the app this is a scam' (rated 5★)

- **Where:** §5.4 Paid for the Home Screen widget advertised in the listing screenshots; widget was 'coming soon'; 'The preview looks nothing like the app this is a scam'
- **This app does:** screenshots ahead of product
- **User reaction:** churn
- **Magnitude:** 2 reviews
- **Direction for us:** dont · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `7074903245`, `13276009260`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R41-176 — Do not add a to-do list, a journal, a pet, a plant, challenges, a social feed or an AI coach to a tracker whose users chose it for restraint — a six-year repeated instruction ('Please don't try to be an all in one app!'; 'no gamification overload'; 'doesn't overload you with features you'll never use'; 'all of the rest similar apps I tried have a ton of distracting and bloatware features')

- **Where:** §8.4 What not to change — do not add a to-do list, a journal, a pet, a plant, challenges, a social feed or an AI coach ('Please don't try to be an all in one app!'; 'all of the rest similar apps I tried have a ton of distracting and bloatware features'; 'doesn't overload you with features you'll never use')
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 12 reviews over six years
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `8414522828`, `8238514048`, `8384484490`, `9243307416`, `10691911378`, `11482024114`, `12239848520`, `13465174002`, `14489261806`, `14455804453`, `12395956072`, `11574965608`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C056 Don't build AI features on demand grounds; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek

### R41-177 — Do not introduce ads: six reviewers name the absence of advertising as a reason they chose this app, and only one would prefer ads to the subscription

- **Where:** §8.4 Do not introduce ads — six name the absence as a reason they chose the app; one prefers ads to the subscription — a minority of one against six
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** 6 vs 1
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `6953324112`, `9557762161`, `12395956072`, `13278332346`, `14455804453`, `8238514048`, `6825465567`
- **Canonical:** C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

## Things to do

### R41-024 — Cheapest high-value moves in evidence order: raise or re-shape the free-tier cap (28 reviews; 47.7% of 1–2★ from monetisation friction) → make the Lifetime option always discoverable (2 blocked buyers) → ship 'X times per week, any days' plus per-day detail on weekly habits (13 + 9, six-year persistence) → harden iCloud device migration and add visible backup / restore (6 data-loss, 2 migration) → ship Russian (5 requests) → replace the mailto: support link with in-app text + web form (2 trial / paying users) → optional text labels on widgets (8) → yearly / long-horizon goals (6)

- **Where:** Executive summary #13 — the cheapest high-value moves, in evidence order
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as stated
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C027 Localise early — it unlocks revenue; C034 Data must never be lost on update, reinstall or phone change; C036 A support channel that exists, is reachable outside the app, and answers; C043 Flexible / custom frequency; C107 Widget variants and customisation as the paid layer; C108 Goals / targets; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R41-167 — Experiment: lead store metadata with what wins — screenshot / description tests emphasising (a) the one-time purchase option, (b) the non-binary percentage ring, (c) full Apple-ecosystem coverage including Mac and Watch, (d) no ads / no account; the listing does not currently lead with the comparison win

- **Where:** §8.2 E5
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** comparison 19.63% (4.94); 4 say under-discovered
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `9400089129`, `11493203641`, `13228802467`, `8013660114`
- **Canonical:** C134 Lead the store listing with what users actually love

## Contradictions

### R41-027 — Listed languages vs reviewer experience: the listing names 11 languages including Spanish and Portuguese, yet 6 in-corpus requests for them are dated 2024–2026 (latest Portuguese Jan 2026 BR 3★; Spanish Oct 2024 CL 3★) — either shipped after those reviews or not reaching those storefronts; unresolved

- **Where:** §2.1 External confirmation — listing: Productivity; 2,500+ icons; interactive widgets; Watch complications; CSV export; Siri Shortcuts; Health; heat maps; Apple Intelligence; iOS 18 / iPadOS 18 / macOS 15 / watchOS 10 / visionOS 2; 11 languages; 4.8 from 925 ratings; Spanish and Portuguese listed despite 6 in-corpus requests 2024–2026 — shipped later or not reaching those storefronts (open question)
- **This app does:** 11 languages listed
- **User reaction:** complaint
- **Magnitude:** 6 requests 2024–26
- **Direction for us:** research · **Report confidence:** open question · **Generalisable:** yes
- **Review IDs:** `13580190550`, `11804482599`
- **Canonical:** C027 Localise early — it unlocks revenue; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R41-078 — The percentage ring has a dissent and a complexity pull: 'I don't like the out of 100% thing… Out of a 100 is so pass fail, but building habits is all about celebrating wins' (5★); two want weights — 'being able to assigning different values to habits, so that Habit A can count more % towards my progress than Habit B' (DE, 3★) — which would move it toward complexity the corpus otherwise rejects

- **Where:** §3.2.4 The one dissent — 'I don't like the out of 100% thing… Out of a 100 is so pass fail'; weighted rings wanted ('Habit A can count more % towards my progress than Habit B') — a counter-pull toward complexity
- **This app does:** unweighted ring
- **User reaction:** mixed
- **Magnitude:** 1 dissent; 2 weight requests
- **Direction for us:** undecided · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `9877978258`, `13325152566`, `11343279385`
- **Canonical:** C201 A user-set partial-completion threshold — a 'good day' below 100%

## Data caveats and method

### R41-002 — Method: all 815 reviews read in full in date order incl. every non-English review; regex candidate sets in 15 languages, then every candidate list for 44 decision-critical themes manually inspected and converted to hand-curated ID lists (paid purchase, paywall, price, subscription, defects, localisation, unmet needs); broad praise themes (design, simplicity, comparison, widgets, sync, Health, Watch, Shortcuts, support, stats, motivation) are regex 'mention' counts reported with a star breakdown; audit corrections (e.g. 'purchased a new iPhone' removed from purchase evidence; praise of other apps' pricing and 'not too expensive' removed from price objection; six payers added who wrote 'buying the premium' / 'signed up to the yearly plan'); a second over-broad sweep against the purchase list surfaced three records, all correctly excluded; 704 of 815 (86.4%) carry a theme, 111 generic (median 69 chars, 95 are 5★); bands <0.1 ignore · 0.1–0.5 weak · 0.5–1 emerging · 1–3 meaningful · 3–5 very strong · >5 high-priority; reconciliation exact (815 lines = parsed = unique IDs = country files; manifest 815 / 67 / 4.591 / 5:627 4:116 3:28 2:15 1:29 reproduced); 0 empty bodies/titles, 0 exact duplicates; one near-duplicate pair (8949712027 / 8952156169, AU, same review posted twice) retained (≤0.13pp); votes unusable (759 zero, max 10); is_edited 23 (2.8%); HTML entities unescaped; external sources — US store listing and public 2025 App Store consumer-spend rankings (for the high-spend group), always labelled; listing latest version 7.4.1 (17 Aug 2025) inconsistent with June 2026 localisation reviews — treat listing date as unreliable; written reviews ≠ users (925 ratings vs 815 reviews); residual error highest in broad simplicity (338), design (284), motivation (61) themes; no causal claims

- **Where:** How to read this; Eight warnings #4 #7; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.5 Processing method; §1.6 Limitations
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 815/815 read; 44 hand-curated themes; 111 generic
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `8949712027`, `8952156169`, `12701004929`, `9400089129`, `9557762161`, `6683101163`, `11133275048`, `12927109452`, `12239848520`, `8751455990`, `9047728455`, `12661574865`, `11055117867`, `14135424478`, `14139118342`
- **Canonical:** — (nuance register)

### R41-003 — An unusually positive corpus: 743 of 815 (91.2%) are 4–5★ and only 44 (5.4%) 1–2★, with no dominant product failure — read it for which small frictions convert into the few bad ratings and what the product is beating, not as a bug list

- **Where:** Eight warnings #1 — unusually positive corpus: 743 of 815 (91.2%) 4–5★, only 44 (5.4%) 1–2★; no dominant product failure; the signal is which small frictions convert into the few bad ratings and what 5★ reviewers say it beats
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 743/815 4–5★ (91.2%); 44 1–2★ (5.4%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R41-004 — Only four storefronts clear 50 reviews — US 201, DE 91, GB 64, CA 51 (together 407, 49.9%); 49 of 67 storefronts have fewer than 10; Japan (4), China (4) and South Korea (5) are effectively absent, so no statement about high-spend Asian markets is made

- **Where:** Eight warnings #2 #3 — only four storefronts clear 50: US 201, DE 91, GB 64, CA 51 (407, 49.9%); 49 of 67 storefronts < 10; Japan, China, South Korea effectively absent (4, 4, 5)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** US 201 · DE 91 · GB 64 · CA 51; JP 4 · CN 4 · KR 5
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R41-005 — Payer evidence: 60 reviewers (7.36%) give direct first-person evidence of paying — a self-selected channel; no conversion rate is inferred

- **Where:** Eight warnings #5 — paid-user evidence real but small: 60 (7.36%) direct first-person payers; no conversion rate
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 60 (7.36%)
- **Direction for us:** none · **Report confidence:** limitation · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R41-006 — Rating-vs-text contradictions: at least five (1★ 'Excellent :: Excellent'; 1★ 'The best on the market… Perfect app'; 5★ 'This app just deleted all my habits and history'; 5★ 'Developer is lying there is no widget feature… this is a scam'; 3★ 'genuinely no complaints') — 0.61% of the corpus but 2 of 29 1★ (6.9%)

- **Where:** Eight warnings #6 — at least five records have a star rating that contradicts their text (1★ 'Excellent :: Excellent'; 1★ 'The best on the market… Perfect app'; 5★ 'This app just deleted all my habits and history'; 5★ 'Developer is lying there is no widget feature… this is a scam'; 3★ 'genuinely no complaints'); 2 of 29 1★ (6.9%)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5 (0.61%); 2/29 1★
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `11802469749`, `10078111201`, `12154375821`, `13276009260`, `14428620119`
- **Canonical:** — (nuance register)

### R41-007 — Prices changed during the window (€14.50/yr in 2021 → €28 lifetime in 2023 → €25 lifetime in 2026), so era-over-era price-objection rates do not compare a constant price

- **Where:** Eight warnings #8 — prices changed materially (€14.50/yr 2021 → €28 lifetime 2023 → €25 lifetime 2026); price-objection rates across eras are not comparing a constant price
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** €14.50/yr → €28 → €25 lifetime
- **Direction for us:** none · **Report confidence:** limitation · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R41-036 — Master theme table, denominator 815, with star splits where available

- **Where:** §3.1 Master table (verbatim), 57 themes
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | Dir. | n | % | Signal | Mean ★ | 5★ | 4★ | 3★ | 2★ | 1★ ; 1 | Simplicity / ease-of-use praise | + | 338 | 41.47% | high-priority | 4.83 | 298 | 32 | 3 | 2 | 3 ; 2 | Design / UI / aesthetics praise | + | 284 | 34.85% | high-priority | 4.80 | 244 | 30 | 6 | 2 | 2 ; 3 | Won an explicit multi-app comparison | + | 160 | 19.63% | high-priority | 4.94 | 151 | 8 | 1 | 0 | 0 ; 4 | Widgets mentioned | + | 111 | 13.62% | high-priority | 4.69 | 89 | 15 | 4 | 1 | 2 ; 5 | Cross-device / iCloud / Mac / iPad | + | 90 | 11.04% | high-priority | 4.49 | 65 | 15 | 4 | 1 | 5 ; 6 | Lifetime / one-time purchase option | + | 81 | 9.94% | high-priority | 4.70 | 67 | 8 | 4 | 0 | 2 ; 7 | Developer / support responsiveness | + | 66 | 8.10% | high-priority | 4.73 | 56 | 6 | 1 | 2 | 1 ; 8 | Motivation / reward / satisfaction | + | 61 | 7.48% | high-priority | 4.79 | 51 | 8 | 1 | 1 | 0 ; 9 | Direct evidence of having paid | mixed | 60 | 7.36% | high-priority | 4.42 | 44 | 8 | 2 | 1 | 5 ; 10 | Statistics / history / trends | mixed | 54 | 6.63% | high-priority | 4.54 | 38 | 12 | 1 | 1 | 2 ; 11 | Apple Health integration | mixed | 53 | 6.50% | high-priority | 4.60 | 39 | 9 | 4 | 0 | 1 ; 12 | Apple Watch | mixed | 52 | 6.38% | high-priority | 4.71 | 42 | 8 | 0 | 1 | 1 ; 13 | Break-a-bad-habit capability | + | 36 | 4.42% | very strong | 4.69 | 28 | 6 | 1 | 1 | 0 ; 14 | Siri Shortcuts / automation | + | 36 | 4.42% | very strong | 4.72 | 29 | 4 | 3 | 0 | 0 ; 15 | Behaviour change / life outcome | + | 32 | 3.93% | very strong | 4.97 | 31 | 1 | 0 | 0 | 0 ; 16 | Free-tier 3-habit cap / must-pay objection | − | 28 | 3.44% | very strong | 2.32 | 1 | 7 | 1 | 10 | 9 ; 17 | Reminders / notifications | + | 28 | 3.44% | very strong | 4.61 | — | — | — | — | — ; 18 | Timer feature | + | 27 | 3.31% | very strong | 4.70 | 20 | 6 | 1 | 0 | 0 ; 19 | Flexible daily/weekly/monthly goals | + | 26 | 3.19% | very strong | 4.65 | — | — | — | — | — ; 20 | Bugs / crashes / lag / battery | − | 23 | 2.82% | meaningful | 3.61 | 8 | 6 | 4 | 2 | 3 ; 21 | Price too high | − | 21 | 2.58% | meaningful | 3.43 | 6 | 6 | 4 | 1 | 4 ; 22 | Localization missing | − | 16 | 1.96% | meaningful | 3.56 | 6 | 3 | 4 | 0 | 3 ; 23 | CSV export / data ownership | + | 14 | 1.72% | meaningful | 4.71 | 13 | 0 | 0 | 0 | 1 ; 24 | Sync failure | − | 13 | 1.60% | meaningful | 3.08 | 2 | 6 | 0 | 1 | 4 ; 25 | Widget defects / limits | − | 13 | 1.60% | meaningful | 3.69 | — | — | — | — | — ; 26 | Frequency flexibility gap (X/week, any days) | − | 13 | 1.60% | meaningful | 3.85 | — | — | — | — | — ; 27 | Subscription-model objection | − | 10 | 1.23% | meaningful | 2.30 | 0 | 2 | 3 | 1 | 4 ; 28 | Privacy / no account required | + | 10 | 1.23% | meaningful | 5.00 | 10 | 0 | 0 | 0 | 0 ; 29 | Trial in progress or just ended | mixed | 11 | 1.35% | meaningful | 4.64 | — | — | — | — | — ; 30 | Statistics insufficient | − | 9 | 1.10% | meaningful | 4.44 | — | — | — | — | — ; 31 | Can't see *which day* a weekly habit was done | − | 9 | 1.10% | meaningful | 4.00 | — | — | — | — | — ; 32 | Apple Health sync gaps / one-way | − | 8 | 0.98% | emerging | 3.62 | — | — | — | — | — ; 33 | Onboarding confusion | − | 8 | 0.98% | emerging | 2.88 | — | — | — | — | — ; 34 | Widget text labels requested | − | 8 | 0.98% | emerging | 4.25 | — | — | — | — | — ; 35 | Sub-tasks / habit stacks / routine view | − | 7 | 0.86% | emerging | 4.43 | — | — | — | — | — ; 36 | Calendar view / calendar integration | − | 7 | 0.86% | emerging | 4.43 | — | — | — | — | — ; 37 | Data loss | − | 6 | 0.74% | emerging | 3.33 | — | — | — | — | — ; 38 | Yearly / long-horizon goals | − | 6 | 0.74% | emerging | 4.50 | — | — | — | — | — ; 39 | No ads / no gamification bloat | + | 6 | 0.74% | emerging | 5.00 | 6 | 0 | 0 | 0 | 0 ; 40 | Wanted to pay, blocked | − | 6 | 0.74% | emerging | 4.17 | — | — | — | — | — ; 41 | Cap read as a *working* trial | + | 5 | 0.61% | emerging | 4.80 | — | — | — | — | — ; 42 | Day-boundary / night-shift day reset | − | 5 | 0.61% | emerging | 4.60 | — | — | — | — | — ; 43 | Can't backfill / edit past days | − | 5 | 0.61% | emerging | 3.40 | — | — | — | — | — ; 44 | Paid user who churned / cancelled | − | 5 | 0.61% | emerging | 2.60 | — | — | — | — | — ; 45 | Mood tracking requested | − | 5 | 0.61% | emerging | 4.60 | — | — | — | — | — ; 46 | Notes/descriptions requested (early era) | − | 5 | 0.61% | emerging | 4.80 | — | — | — | — | — ; 47 | Future start date / end date | − | 5 | 0.61% | emerging | 4.40 | — | — | — | — | — ; 48 | API / third-party integration | − | 5 | 0.61% | emerging | 3.80 | — | — | — | — | — ; 49 | Screen Time integration requested | − | 4 | 0.49% | weak | 4.75 | — | — | — | — | — ; 50 | Android / Web / Windows wanted | − | 4 | 0.49% | weak | 4.50 | — | — | — | — | — ; 51 | Family sharing / social / compete | − | 4 | 0.49% | weak | 5.00 | — | — | — | — | — ; 52 | Localization shipped — reviewer returned to reward it | + | 3 | 0.37% | weak | 5.00 | — | — | — | — | — ; 53 | App badge counter broken/absent | − | 3 | 0.37% | weak | 4.00 | — | — | — | — | — ; 54 | Full version granted free (2020 promo) | + | 2 | 0.25% | weak | 5.00 | — | — | — | — | — ; 55 | Support link opens Mail and dead-ends | − | 2 | 0.25% | weak | 4.00 | — | — | — | — | — ; 56 | Refund refused | − | 1 | 0.12% | weak | 1.00 | — | — | — | — | — ; 57 | Review-prompt nagging | − | 1 | 0.12% | weak | 1.00 | — | — | — | — | —
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R41-042 — Direct payers 60 (7.36%, mean 4.42; 44/8/2/1/5)

- **Where:** §3.1 master table #9 Direct evidence of having paid
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 60 (7.36%), 4.42
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R41-055 — Trial in progress or just ended 11 (1.35%, mean 4.64)

- **Where:** §3.1 master table #29 Trial in progress or just ended
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 11 (1.35%), 4.64
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R41-072 — Weak rows: Screen Time integration 4 (4.75); Android / Web / Windows 4 (4.50); family sharing / social / compete 4 (5.00); localisation shipped — returned to reward 3 (5.00); app badge counter broken / absent 3 (4.00); full version granted free (2020 promo) 2 (5.00); support link opens Mail 2 (4.00); refund refused 1 (1.00); review-prompt nagging 1 (1.00)

- **Where:** §3.1 master table #49–#57 weak rows
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** ≤4 each
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R41-090 — Unmet needs ranked by count then rating cost

- **Where:** §3.4 Unmet needs (verbatim table) — union 112 (13.74%, high-priority, mean 4.17), 51 × 5★, 42 × 4★
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Rank | Request | n | % | Signal | Mean ★ | Representative IDs ; 1 | "X times per week, any days" / "every N days" frequency | 13 | 1.60% | meaningful | 3.85 | 11105723095, 12529452345, 14042363994, 11405961424, 12979275111, 11174670037, 12198311158 ; 2 | Show which day a weekly/monthly habit was completed | 9 | 1.10% | meaningful | 4.00 | 10392822751, 13585104492, 9028038591, 12529452345, 11872027872, 14303067862 ; 3 | Better / deeper statistics | 9 | 1.10% | meaningful | 4.44 | 13519312740, 11555630539, 10045614075, 13322024143, 8381779872 ; 4 | Widget text labels instead of icon-only | 8 | 0.98% | emerging | 4.25 | 13826645362, 11886448055, 10415080649, 7193643397, 13465174002 ; 5 | Sub-tasks / habit stacks / routine view | 7 | 0.86% | emerging | 4.43 | 14423293610, 13228802467, 11063416316, 12933186432, 14022932754, 8290170982 ; 6 | Calendar view / calendar integration | 7 | 0.86% | emerging | 4.43 | 8352601276, 10750983912, 12294570428, 12710798454, 7869891198 ; 7 | Yearly / long-horizon goals | 6 | 0.74% | emerging | 4.50 | 13138354665, 10837122337, 10775655163, 12569970736, 13654436951, 11845038528 ; 8 | Mood tracking inside the app's own history | 5 | 0.61% | emerging | 4.60 | 11766790484, 12294514611, 8601037309, 12299265869 ; 9 | Notes / descriptions (2020–2021 era; shipped) | 5 | 0.61% | emerging | 4.80 | 6237078958, 6313575889, 6939185873, 7164121278 ; 10 | Future start date / end date for a habit | 5 | 0.61% | emerging | 4.40 | 10886137884, 11997316908, 6841773921, 11882129656 ; 11 | Public API / Zapier / IFTTT | 5 | 0.61% | emerging | 3.80 | 8193089811, 10078111201, 8118328892, 13232442046, 11555630539 ; 12 | Screen Time as a trackable bad habit | 4 | 0.49% | weak | 4.75 | 10572050466, 11401361919, 12682557463, 13297744521 ; 13 | Android / Web / Windows | 4 | 0.49% | weak | 4.50 | 14313500501, 12294920532, 12616709393, 11184020601 ; 14 | Family sharing / compete with family | 4 | 0.49% | weak | 5.00 | 11184020601, 12809675994, 11536341085, 12294920532 ; 15 | App badge counter | 3 | 0.37% | weak | 4.00 | 8435023786, 13228974860, 13508811496
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `13519312740`, `11555630539`, `10045614075`, `8381779872`, `13826645362`, `11886448055`, `10415080649`, `14423293610`, `13228802467`, `11063416316`, `12933186432`, `14022932754`, `8290170982`, `8352601276`, `10750983912`, `12294570428`, `12710798454`, `7869891198`, `13138354665`, `10837122337`, `10775655163`, `12569970736`, `13654436951`, `11845038528`
- **Canonical:** — (nuance register)

### R41-102 — Rating distribution: 5★ 627 (76.93%) · 4★ 116 (14.23%) · 3★ 28 (3.44%) · 2★ 15 (1.84%) · 1★ 29 (3.56%); mean 4.591

- **Where:** Part 4 corpus distribution — 5★ 627 (76.93%) · 4★ 116 (14.23%) · 3★ 28 (3.44%) · 2★ 15 (1.84%) · 1★ 29 (3.56%); mean 4.591
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as stated
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R41-103 — Rating-only monitoring misses serious complaints: the 5★ band (627) mixes contentless praise (95 of the 111 unthemed: 'Gut', 'Ok', 'Jazz'), 151 long competitive comparison verdicts, and 5★ reviews carrying substantive complaints — 1 cap, 6 price, 2 sync, 6 localisation, 8 bugs, 51 requests — including 'This app just deleted all my habits and history after 6 months of using' filed at 5★; drivers: simplicity 47.5%, design 38.9%, comparison 24.1%, widgets 14.2%, cross-device 10.4%, support 8.9%, motivation 8.1%, Watch 6.7%, Health 6.2%, stats 6.1%, behaviour change 4.9%, Shortcuts 4.6%, break-a-habit 4.5%, CSV 2.1%, privacy 1.6%

- **Where:** §4.1 Five stars — what drives them (simplicity 47.5%, design 38.9%, comparison 24.1%, widgets 14.2%, cross-device 10.4%, support 8.9% …); three sub-populations: contentless praise (95 of 111 unthemed); comparison converts (151); 5★ with a substantive complaint (1 cap, 6 price, 2 sync, 6 localisation, 8 bugs, 51 requests) — incl. a total-data-loss report filed at 5★ that rating-only monitoring would never surface
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 627 5★
- **Direction for us:** do · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `12093363717`, `11965164276`, `14201197190`, `13892606843`, `11937474480`, `12306342920`, `12154375821`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R41-110 — Payers: 60 (7.36%), mean 4.42 (below the 4.591 corpus), 5★ 44 · 4★ 8 · 3★ 2 · 2★ 1 · 1★ 5; top storefronts US 16, DE 9, GB 8, CA 7, AU 4, FR 3; by year 2020 1 · 2021 5 · 2022 12 · 2023 4 · 2024 16 · 2025 16 · 2026 6; payer rate GB 12.5% · CA 13.7% · DE 9.9% · US 8.0%; 11 more on or just after a trial; 2 given the full version free at the 2020 launch — a self-report floor, not a conversion rate

- **Where:** §5.1 Who is identifiable as a payer (verbatim table) — 60 (7.36%), mean 4.42, 5★ 44 · 4★ 8 · 3★ 2 · 2★ 1 · 1★ 5; top US 16, DE 9, GB 8, CA 7, AU 4, FR 3; by year 1/5/12/4/16/16/6; payer rate GB 12.5% · CA 13.7% · DE 9.9% · US 8.0%; 11 on trial; 2 given the full version free during the 2020 launch; self-report floor
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Property | Value ; n | 60 (7.36% of corpus) ; Mean rating | 4.42 (vs 4.591 corpus) ; Star distribution | 5★ 44 · 4★ 8 · 3★ 2 · 2★ 1 · 1★ 5 ; Top storefronts | US 16, DE 9, GB 8, CA 7, AU 4, FR 3 ; By year | 2020 1 · 2021 5 · 2022 12 · 2023 4 · 2024 16 · 2025 16 · 2026 6 ; Payer rate by market | GB 12.5% · CA 13.7% · DE 9.9% · US 8.0%
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** app-specific
- **Review IDs:** `6306944780`, `6725250923`
- **Canonical:** — (nuance register)

### R41-112 — Purchase triggers ranked by frequency in 60 payer + 6 wanted-to-pay reviews

- **Where:** §5.2 What triggers a purchase (verbatim table)
- **This app does:** n/a
- **User reaction:** purchase-driver
- **Magnitude:** Trigger | Evidence ; 1. The lifetime option exists at all (the single most-cited reason) | 8883282086, 11449917454, 7305149420, 13418978546, 12081345787, 14342654245, 13189731645, 12893034917, 14309794575, 14428620119 ; 2. The app won a head-to-head comparison (12 of 60 payers also carry the comparison theme) | 11173751309, 11493203641, 12459206032, 12402418635, 9761451102, 11242852677, 13827659773 ; 3. A support interaction closed the sale | 11055117867 (*"He responded within hours. Twice. Outstanding support. As such, I am buying the app outright"*), 9877978258 (*"After… speaking with the customer service guys… I will be purchasing the app outright"*), 10988344121, 12459206032 ; 4. Hitting the 3-habit cap | 11215681102 (*"I pretty quickly paid for premium… as only 3 tracked items is a low number"*), 11815455819 (*"Bought the lifetime subscription so I could add more habits"*), 13393275122, 12877429608 ; 5. Statistics behind the paywall | 11530645968 (*"Just purchased lifetime pro version… love statistics now visible"*), 8429857651 (*"In the paid version, the app automatically makes a graph"*) ; 6. Apple Health actually working (vs a competitor's) | 12402418635 (*"Coming from Grit, I almost instantly bought it because the Apple Health habits actually work"*) ; 7. Data safety / CSV export | 12459206032 (*"especially the CSV export… so my data is safe"*), 11184020601 ; 8. Speed of the decision | 12402418635 (*"I bought the lifetime after trying it for like 20 minutes"*), 11842019567 (*"after using this for one day, I bought the premium version"*), 12893034917 (*"Tried it for a few hours for free and was immediately convinced"*), 7830570783 (*"I wanted to test it for a week… but after only a few days I was happy to upgrade"*) ; 9. Supporting the developer, not buying features | 11751459650 (*"Just bought the premium to support the developer i don't even need the features tbh"*), 10454723570 (*"I bought the monthly subscription to support developers!"*), 12075485629 (*"Please support the dev so he can support it for the long term"*) ; 10. Sale pricing | 11945887963 (*"because it was on sale for about 20 dollars"*)
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** app-specific
- **Review IDs:** `8883282086`, `11449917454`, `7305149420`, `13418978546`, `12081345787`, `14342654245`, `13189731645`, `12893034917`, `14309794575`, `14428620119`, `11173751309`, `11493203641`, `12459206032`, `12402418635`, `9761451102`, `11242852677`, `13827659773`
- **Canonical:** — (nuance register)

### R41-146 — Trend method: calendar year and half-year buckets; a trend is named only where the theme has ≥ 5 records and the direction survives at half-year granularity; 2020 (from 21 Jul) and 2026 (to 4 Sep) partial; no version metadata, so no pre/post-release comparison

- **Where:** Part 7 Method — calendar year and half-year; trend only with ≥ 5 records surviving half-year granularity; 2020 and 2026 partial; no version metadata
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R41-169 — Research question: What changed in the first half of 2025? Worst half-year (4.406), highest cap-complaint rate (6.4%) and a 5× collapse in support mentions at once — price change, paywall redesign, acquisition-channel shift or support strain cannot be distinguished; the single highest-value question

- **Where:** Part 8 #1 (§8.3 research question 1)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `12131335894`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R41-170 — Research question: Are Spanish and Portuguese actually reaching ES / CL / BR / PT storefronts? Listed, yet four-plus reviews Apr 2024 – Jan 2026 say they are missing

- **Where:** Part 8 #2 (§8.3 research question 2)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `11205195054`, `11398546682`, `11804482599`, `13580190550`, `13299630252`
- **Canonical:** C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R41-171 — Research question: Is the lifetime SKU hidden deliberately (promotional windows) or by a bug? Three saw it disappear and one sees no purchase UI — the answer decides whether F1 is a bug fix or a pricing decision

- **Where:** Part 8 #3 (§8.3 research question 3)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `12128314444`, `11360590820`, `10195683230`, `10901569398`
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R41-172 — Research question: Is Watch sync currently reliable? Three reports over four years, each touching a payer — below threshold; instrumentation would settle it

- **Where:** Part 8 #4 (§8.3 research question 4)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `9104605843`, `12157688910`, `13279660290`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R41-173 — Research question: What is the actual free→paid conversion rate, and how does it differ between the high-volume four and the 63-storefront tail (self-reported 9.83% vs 4.90%)?

- **Where:** Part 8 #5 (§8.3 research question 5)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R41-174 — Research question: Does the review prompt run too often? One complaint (1★, Aug 2026) — recorded because 111 of 815 (13.6%) are contentless praise with a median of 69 characters, the signature of prompted reviews

- **Where:** Part 8 #6 (§8.3 research question 6)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `14406073990`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R41-175 — Prompted-review signature: 111 of 815 reviews (13.6%) are contentless praise with a median length of 69 characters, and prompting materially affects the mean the analysis is built on

- **Where:** §8.3 #6 — 111 of 815 (13.6%) contentless praise with median 69 chars is the signature of prompted reviews; prompting materially affects the mean rating
- **This app does:** in-app review prompt
- **User reaction:** 5★-burst
- **Magnitude:** 111 (13.6%), median 69 chars
- **Direction for us:** none · **Report confidence:** interpretation · **Generalisable:** yes
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire
