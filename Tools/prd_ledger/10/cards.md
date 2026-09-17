# Cards — report 10

Source: `App Store Reports/10. Finch - Self-Care Pet - Daily Journal & Habit Tracker (REPORT).md`  
180 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 7
- [Must-haves](#must-haves) — 4
- [Must never break](#must-never-break) — 19
- [Features](#features) — 22
- [Monetization](#monetization) — 17
- [Tactics the app used](#tactics-the-app-used) — 3
- [Insights (the why)](#insights-the-why) — 22
- [Audiences](#audiences) — 5
- [Markets and languages](#markets-and-languages) — 13
- [Dated events and trends](#dated-events-and-trends) — 20
- [Positioning](#positioning) — 3
- [Anti-patterns](#anti-patterns) — 12
- [Things not to do](#things-not-to-do) — 5
- [Things to do](#things-to-do) — 8
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 19

## Product rules

### R10-012 — Every major feature removal produced a measurable, dated backlash and none were reversed in the corpus: Journeys → Self-Care Areas, automatic mood check-ins and affirmations, exact-time goal scheduling; generic 'you removed a feature I used' grew 16×

- **Where:** EXECUTIVE SUMMARY #5 Every major feature removal produced a measurable, dated backlash, and none were reversed; §8.5 Trend 4
- **This app does:** removed Journeys (Apr–May 2025), auto mood check-ins/affirmations (Oct 2025+), exact-time goal scheduling (Nov 2025–Jan 2026)
- **User reaction:** complaint
- **Magnitude:** Journeys 49 reviews mean 2.76 (36 in 2025); mood check-ins 64 mean 3.77 (49 in 2025H2–2026); timed goals 9 mean 3.11; U-feature-removed-generic 0.02% (2022) → 0.32% (2026), 16×
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace

### R10-023 — Several capabilities reviewers report as previously free are now paid — soundscapes (animal sounds), longer timers, the monthly event micropet — i.e. paywall creep on things people had already been using

- **Where:** §2.2 Soundscapes and longer timers reported as previously free; monthly event micropet reported as previously free
- **This app does:** moved free features behind Finch Plus
- **User reaction:** complaint
- **Magnitude:** reported by individual reviewers; M-paywall theme quantified in §4.2
- **Direction for us:** product-rule · **Report confidence:** corpus-derived · **Generalisable:** yes
- **Review IDs:** `13057118678`, `13594995098`, `14455889030`, `10529428569`
- **Canonical:** C001 Never move a free feature behind the paywall

### R10-040 — Non-punitiveness is a named differentiator ('unlike other apps, he doesn't get sick or sad if I miss things… without any guilt from my virtual friend') — and the streak mechanic and the Journeys→Self-Care-Areas change are, in reviewers' own words, the direct negation of it

- **Where:** §3.1 P-gentle; §3.2 (b) Non-punitiveness is a named differentiator — and it is the exact thing later changes eroded
- **This app does:** pet never gets sick or sad; no guilt — until streaks were added
- **User reaction:** praise
- **Magnitude:** P-gentle 476 (0.68%, EMERGING) mean 4.87
- **Direction for us:** product-rule · **Report confidence:** emerging, high mean · **Generalisable:** yes
- **Conditions:** read against §4.5 and §8.5
- **Review IDs:** `10243200718`, `11745067634`, `13005792453`, `8389731820`, `12939486987`, `14187447203`, `11824105803`, `13609263572`, `12060228726`, `9668443213`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R10-062 — Individually the product-change themes are small; collectively they are the corpus's clearest statement about product direction, all dated, all pointing the same way

- **Where:** §4.4 Collectively they are the corpus's clearest statement about product direction
- **This app does:** removed features users bought the app for
- **User reaction:** complaint
- **Magnitude:** FAM-product-change 269 (0.384%, WEAK) mean 3.43, 51 one-star; U-ui-change 94 mean 3.53
- **Direction for us:** product-rule · **Report confidence:** weak volume / coherent · **Generalisable:** yes
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace

### R10-139 — Paywall creep on previously-free items from November 2022 onward is the largest single monetization theme, though its rate is falling

- **Where:** §8.5 Paywall creep on previously-free items row (M-paywall)
- **This app does:** moved free items behind Plus
- **User reaction:** complaint
- **Magnitude:** M-paywall 715 mean 4.38; 1.20% (2022) → 0.85% (2026); 4★ band 141 (3.03%)
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9337272695`, `9364974191`, `9386542212`, `9479031601`, `9771124109`, `9138911582`
- **Canonical:** C001 Never move a free feature behind the paywall

### R10-159 — P2: make every guilt mechanic optional — streak display, streak repair prompts, event countdowns, commitment prompts; a single 'gentle mode' toggle would resolve streak pressure and a large share of FOMO complaints

- **Where:** §9.3 P2. Make every guilt mechanic optional — 'gentle mode' toggle; §9.5 #2
- **This app does:** guilt mechanics mandatory since mid-2024
- **User reaction:** complaint
- **Magnitude:** 476 praise non-guilt; 96 now say it guilts; U-fomo-events 40
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R10-165 — P8: make the values screens optional in both directions — a 'skip pronoun selection' toggle addresses the delete-at-onboarding reviews; a show/hide filter for themed cosmetic categories addresses the objectors and, by giving the same control to everyone, defuses the framing; the users asking for MORE representation have a higher mean than those asking for less, and the missing-lesbian-flag complaint recurs 2022–2026 unfixed

- **Where:** §9.3 P8. Make the values screens optional in both directions
- **This app does:** mandatory pronoun step; no cosmetic-category filter
- **User reaction:** mixed
- **Magnitude:** 54 delete-at-onboarding; 109 objection mean 3.50; 111 want more mean 4.57
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C161 Values and identity screens are optional in both directions

## Must-haves

### R10-058 — Support closes the loop badly: unanswered emails, weeks-long delays, AI or canned replies and 'we're a small team' — and paying users are 13× over-represented among support complaints

- **Where:** §4.3 Support closes this loop badly too (D-support)
- **This app does:** slow / AI / canned support; small team
- **User reaction:** complaint
- **Magnitude:** D-support 185 (0.264%, WEAK) mean 3.10, 71 one-star; 48 of 185 (26%) carry purchase evidence — 13.2× over-representation
- **Direction for us:** must-have · **Report confidence:** weak / paid-skewed · **Generalisable:** yes
- **Review IDs:** `12508862481`, `13005792453`, `13192704866`, `13756726098`, `14225501459`, `14366340795`, `14251210046`, `12907317317`, `12518605995`, `14207705711`, `13428425479`, `14025215424`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R10-156 — F5: answer support email — weeks of silence, canned replies that do not address the question, AI responses repeating the same three troubleshooting steps; the minimum viable fix: 'Please get some humans involved in your tech support'

- **Where:** §9.1 F5. Answer support email
- **This app does:** AI/canned support
- **User reaction:** complaint
- **Magnitude:** 185 reviews; 26% from payers; 13.2× paid over-representation
- **Direction for us:** must-have · **Report confidence:** recommendation (fix) · **Generalisable:** yes
- **Review IDs:** `14366340795`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R10-160 — P3: reduce the interstitial cost of the core action — a path from launch to checkbox that does not pass through a quote, a mood prompt, an event cutscene, a visitor, a chest, and a claim-confirm-claim sequence (one review counts the claim button appearing three times for one reward)

- **Where:** §9.3 P3. Reduce the interstitial cost of the core action
- **This app does:** six+ interstitials before the checklist
- **User reaction:** complaint
- **Magnitude:** 1,046 overwhelm; 84 too-many-taps
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `12717371857`
- **Canonical:** C159 Launch-to-core-action path with no interstitials

### R10-163 — P6: ship dark mode and finish the accessibility work — and close the loop the onboarding opens: if a user declares a mobility limitation, stop suggesting walks

- **Where:** §9.3 P6. Ship dark mode and finish the accessibility work you started
- **This app does:** asks about disability then ignores it
- **User reaction:** complaint
- **Magnitude:** 90 dark-mode requests since 2022; 597 accessibility reviews
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `14249655239`
- **Canonical:** C080 Colour themes / dark mode; C160 Honour what onboarding asks — a declared limitation must change the suggestions; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

## Must never break

### R10-005 — 'You promised to remind me before charging' is the highest-intensity complaint: the app states it will warn users before the trial converts, reviewers say it does not, or that they were charged immediately on starting the 'free' trial; with cancellation friction and refund refusal this is the worst-rated family in the corpus, repeated verbatim across five years, 20+ storefronts and every language — and it is NOT a pricing objection (only 92 of 596 price complaints come from payers vs 241 of 404 billing disputes)

- **Where:** ⚠️ 2. 'You promised to remind me before charging' is the highest-intensity complaint in the corpus; EXECUTIVE SUMMARY #2 The trial-to-subscription flow is the largest reputational liability; §4.2; §6.3
- **This app does:** free trial with a promised pre-charge reminder that reviewers say never arrives
- **User reaction:** 1★-burst
- **Magnitude:** M-trial-no-reminder 160 reviews mean 1.98; M-trial-charged 149 mean 1.79; billing-dispute family 404 (0.58%, EMERGING) mean 1.97, 244 are 1★; 17.45% of all paid-evidence reviewers (241/1,381) are in it
- **Direction for us:** must-never-break · **Report confidence:** high-priority (headline) · **Generalisable:** yes
- **Canonical:** C109 A free trial must be a real trial; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R10-006 — Data loss is a structural defect, not an incident: progress is stored on-device, backup is manual and opt-in, and the standard support remedy is a new bird plus 5,000 rainbow stones — offered to users who had 20,000–200,000 stones and multi-year streaks; in an app whose entire retention mechanic is emotional attachment to one pet this converts the greatest strength into the greatest liability

- **Where:** ⚠️ 3. Data loss is a structural product defect, not an incident, and it is getting worse; EXECUTIVE SUMMARY #3 Local-only storage is the second liability; §4.3; §8.4
- **This app does:** local-only storage; manual opt-in backup; remedy = new pet + 5,000 stones
- **User reaction:** 1★-burst
- **Magnitude:** 551 reviews (0.79%, EMERGING globally; 9.09% of all 1★); data-integrity family (D-data-loss + D-no-backup + D-login-account + D-sync-devices) 0.42% (2022H1) → 1.76% (2026H1); 37 explicit 'no automatic backup'; 90 'cannot log back in'
- **Direction for us:** must-never-break · **Report confidence:** high-priority (headline) · **Generalisable:** yes
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R10-011 — Reliability is now the fastest-growing complaint family and the corpus attributes it directly to monthly event releases

- **Where:** EXECUTIVE SUMMARY #4 Reliability is now the fastest-growing complaint family; §8.3 Trend 3
- **This app does:** monthly content events ship bugs
- **User reaction:** 1★-burst
- **Magnitude:** reliability family 1,648 (2.35%, MEANINGFUL) mean 3.32; 1.89% (2022H1) → 4.80% (2026H1); crash reports 0.36% of 2024 → 2.03% of 2026 reviews; D-event-bug 0.06% of 2025 → 0.32% of 2026
- **Direction for us:** must-never-break · **Report confidence:** meaningful, rising · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C156 Content and event releases need a crash gate across device generations

### R10-028 — Price dispersion is itself a finding: reviewers report being quoted a different price from a family member or friend on the same day (parent $34.99, son $41.99 — 'That just took all the joy of playing with this today out of my sails'; support 'could not explain the cost differences', range $19.99–$99.99) — WEAK by volume, high-severity trust signal by content because users compare notes inside a household

- **Where:** §2.3 The dispersion is itself a finding (M-price-inconsistent); §4.2
- **This app does:** variable/personalised subscription pricing
- **User reaction:** complaint
- **Magnitude:** M-price-inconsistent 12 reviews, mean 3.75
- **Direction for us:** must-never-break · **Report confidence:** weak volume / high severity · **Generalisable:** yes
- **Review IDs:** `13973018233`, `13859119520`, `12682049848`, `12877389441`, `12506634709`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R10-047 — The trial-reminder failure mechanism is stated the same way for five years: the app tells the user it will notify them before the trial converts; the notification does not arrive; an annual charge lands — 'They said free 1-week trial and that they would notify us before payment went through and they did not honor that either of these statements'; 'It's kinda lame to market an app heavily towards ADHD and tell you specifically that you'll get a reminder before the free trial ends only to not do exactly that'

- **Where:** §4.2 The specific mechanism, stated the same way for five years
- **This app does:** promised pre-charge reminder not delivered; trial defaults to annual
- **User reaction:** 1★-burst
- **Magnitude:** M-trial-no-reminder 160 (0.228%) mean 1.98, 92 one-star, 89 paid-evidence; appears 2022 through 2026 every year (5/8/12/14/13 cited IDs per year)
- **Direction for us:** must-never-break · **Report confidence:** weak volume / highest intensity · **Generalisable:** yes
- **Review IDs:** `8450449406`, `9377363892`, `10894998349`, `12165793458`, `13684684762`, `12821877102`, `12761313447`, `14512967242`
- **Canonical:** C109 A free trial must be a real trial; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R10-049 — 'Charged at trial START, not trial end' is a distinct and more severe claim — whether a real charge, a pre-authorisation, or a store-side display artefact cannot be determined from text, but 149 people believe it happened and 99 of them gave one star

- **Where:** §4.2 Charged at trial start, not trial end
- **This app does:** trial appears to charge immediately
- **User reaction:** 1★-burst
- **Magnitude:** M-trial-charged 149 (0.213%) mean 1.79, 99 one-star, 96 paid-evidence
- **Direction for us:** must-never-break · **Report confidence:** weak volume / highest intensity · **Generalisable:** yes
- **Review IDs:** `12117168256`, `12154514925`, `12238194934`, `12242821032`, `12267858614`, `12489141814`, `12515680303`, `12742313476`, `12814366937`, `13309759497`, `13323080135`, `14163733137`, `14334922614`, `14403016858`
- **Canonical:** C109 A free trial must be a real trial

### R10-050 — Refund refusal closes the loop and is the lowest-rated theme in the corpus: reviewers describe being routed between the developer and Apple with neither accepting responsibility

- **Where:** §4.2 Refund refusal closes the loop
- **This app does:** refunds refused / routed to Apple
- **User reaction:** 1★-burst
- **Magnitude:** M-refund-denied 98 (0.140%) mean 1.48, 71 one-star, 91 paid-evidence
- **Direction for us:** must-never-break · **Report confidence:** weak volume / lowest mean · **Generalisable:** yes
- **Review IDs:** `12409091682`, `12518605995`, `12655037808`, `13005792453`, `13869988823`, `14020090949`, `14242421063`, `14275458594`, `14466997995`, `11753119019`, `10405832029`
- **Canonical:** C029 Billing must be exactly right

### R10-051 — Cancellation friction / cancelled-but-still-charged, unauthorised-charge reports and duplicate charges complete the billing-dispute family

- **Where:** §4.2 M-cancel-hard, M-unauthorized, M-double-charge rows
- **This app does:** cancellation friction; charges perceived as unauthorised; double charges
- **User reaction:** 1★-burst
- **Magnitude:** M-cancel-hard 66 (0.094%) mean 2.18, 36 one-star, 30 paid; M-unauthorized 51 (0.073%) mean 2.12, 31 one-star, 24 paid; M-double-charge 10 (0.014%) mean 1.60, 5 one-star, 8 paid
- **Direction for us:** must-never-break · **Report confidence:** ignore-band volume, carve-out · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C112 In-app cancellation

### R10-053 — Crashes are the largest single defect theme

- **Where:** §4.3 D-crash row; §8.2
- **This app does:** crash on launch during events
- **User reaction:** 1★-burst
- **Magnitude:** D-crash 568 (0.811%, EMERGING) mean 3.07, 151 one-star
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures

### R10-054 — The data-loss mechanism as users describe it: progress lives on the device; a cloud backup exists but is manual and opt-in and many users only discover this after the loss; failure modes: (a) 'your pet data got corrupted' with only re-hatching offered, (b) app deleted/offloaded for storage and unrecoverable, (c) phone change and account unrecoverable, (d) backup file exists but restores empty or fails

- **Where:** §4.3 The data-loss mechanism, as users describe it
- **This app does:** local-only progress; manual opt-in cloud backup
- **User reaction:** 1★-burst
- **Magnitude:** D-data-loss 551 (0.787%, EMERGING) mean 3.10, 160 one-star; D-no-backup 37; D-login-account 90 mean 2.89; D-sync-devices 31 mean 4.16, 0 one-star; IDs every year 2021–2026
- **Direction for us:** must-never-break · **Report confidence:** emerging / 9.09% of 1★ · **Generalisable:** yes
- **Review IDs:** `7603837966`, `8124198861`, `9714150379`, `11291619797`, `12595515502`, `13683756253`, `14245428205`, `13411041280`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C035 Account system from day one; C153 Automatic cloud backup on by default — never manual opt-in

### R10-056 — Data loss hits paying users no less than free users — the paid cohort is over-represented in the data-loss theme

- **Where:** §4.3 It hits paying users no less than free users (data loss)
- **This app does:** no automatic backup for subscribers either
- **User reaction:** churn
- **Magnitude:** 48 of 551 data-loss reviews carry purchase evidence; paid cohort 4.4× over-represented
- **Direction for us:** must-never-break · **Report confidence:** segment rate · **Generalisable:** yes
- **Review IDs:** `12595515502`, `13411041280`, `13732070192`, `14156611933`, `13646312358`, `14273682143`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R10-059 — The home-screen widget is the longest-running unfixed defect in the corpus: across all five years it renders as a grey/black box or fails to update — mostly fans reporting it, which is why it never generated pressure

- **Where:** §4.3 The widget is the longest-running unfixed defect in the corpus
- **This app does:** widget chronically broken 2021–2026
- **User reaction:** complaint
- **Magnitude:** D-widget-bug 117 (0.167%, WEAK) mean 3.91, 6 one-star; IDs in every year 2021–2026; widget mentioned 493 times
- **Direction for us:** must-never-break · **Report confidence:** weak, persistent · **Generalisable:** yes
- **Review IDs:** `8028480594`, `8063339783`, `9504481447`, `10233025213`, `11832970239`, `13215675126`, `13720918256`, `14361444262`, `14407038000`
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R10-060 — Remaining defect themes: lag/overheating/battery, notifications not delivered or not switchable off, goals disappearing/duplicating/reordering, monthly event/quest/reward bugs, audio/soundscape breakage

- **Where:** §4.3 D-lag-perf, D-notif-broken, D-goals-bug, D-event-bug, D-sound-bug rows
- **This app does:** multiple defects
- **User reaction:** complaint
- **Magnitude:** D-lag-perf 149 (0.213%) mean 3.62; D-notif-broken 86 (0.123%) mean 3.47; D-goals-bug 83 (0.119%) mean 3.81; D-event-bug 73 (0.104%) mean 3.23; D-sound-bug 19 mean 3.47
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once; C083 Performance must not degrade with habit count

### R10-066 — Streaks — defect harm: the streak resets despite eligibility, or repair tokens fail outright, and this defect grew 74× in three years

- **Where:** §4.5 Streaks — defect harm (D-streak-bug)
- **This app does:** streak counter unreliable; repair fails
- **User reaction:** complaint
- **Magnitude:** D-streak-bug 171 (0.244%) mean 3.26, 45 one-star; 0.01% of 2023 → 0.74% of 2026 (74×)
- **Direction for us:** must-never-break · **Report confidence:** weak, rising fast · **Generalisable:** yes
- **Review IDs:** `14155454118`, `14156037444`, `14156043295`, `14158910349`, `14158945706`, `14160185561`, `14161950158`, `14184548492`, `14190841447`, `14258840772`, `13645979333`, `14020891685`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones

### R10-086 — Safety-sensitive content produced at least one severe incident class: in 2022 the goal-suggestion system parsed a journal entry about suicidal ideation and generated a goal to 'schedule time for suicide'; in-app depression/anxiety/ADHD quizzes returned severe results to children in a 4+ app; a 'you can do this' notification arrived immediately after a text about suicide — reported regardless of volume under the safety carve-out

- **Where:** §4.7 Safety-sensitive content is present and has produced at least one severe incident class
- **This app does:** auto goal suggestions from journal text; diagnosis quizzes; motivational notifications
- **User reaction:** complaint
- **Magnitude:** C-safety 335 (0.478%) mean 4.55; C-diagnosis-quiz 221 mean 4.86; 3 + 4 + 1 incident IDs
- **Direction for us:** must-never-break · **Report confidence:** safety carve-out · **Generalisable:** yes
- **Review IDs:** `8197656256`, `8249486173`, `8310957728`, `10461078232`, `11680366668`, `9028127653`, `8747299439`, `12943514439`
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface; C162 Automated suggestions from user text must be safety-filtered; notifications must be crisis-aware

### R10-152 — F1: make the trial-conversion reminder real and provable — send the promised pre-charge notification as a blocking in-app card on next open, not only as a push (users report the push arriving at 1am and drowning in the app's own notification volume); show exact amount and charge date on the trial-acceptance screen and permanently in Settings; investigate and publicly explain the 149 'charged at trial start' reports; put a working cancel path inside the app rather than deep-linking to Apple

- **Where:** §9.1 F1. Make the trial-conversion reminder real, and make it provable
- **This app does:** push-only reminder; annual default; cancel via Apple deep link
- **User reaction:** 1★-burst
- **Magnitude:** 404 billing-dispute reviews mean 1.97; 244 one-star; 241 of 1,381 payers; rate up 4–6× 2022→2025; 149 trial-charged, 99 one-star; M-cancel-hard 66 mean 2.18
- **Direction for us:** must-never-break · **Report confidence:** recommendation (fix) · **Generalisable:** yes
- **Review IDs:** `13126279553`
- **Canonical:** C112 In-app cancellation; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R10-153 — F2: ship automatic cloud backup on by default — no manual 'create save file' step (37 reviews did not know a manual backup was required until after the loss); never present 'your pet data got corrupted → re-hatch' as the only option — offer server-side recovery, and if impossible restore INVENTORY rather than 5,000 stones to someone who lost 30,000; fix account recovery (90 reviews describe email/phone not recognised for accounts that demonstrably exist — their friends can still see the bird); warn before the destructive path (users delete the app for storage every year in every market)

- **Where:** §9.1 F2. Ship automatic cloud backup, on by default
- **This app does:** manual opt-in backup; account recovery fails
- **User reaction:** 1★-burst
- **Magnitude:** 551 data-loss reviews; 9.09% of 1★ band; family rate quadrupled 2022H1→2026H1; 37 no-backup; 90 login-account
- **Direction for us:** must-never-break · **Report confidence:** recommendation (fix) · **Generalisable:** yes
- **Review IDs:** `14141439529`, `13806982854`, `14102886128`, `13583950351`
- **Canonical:** C035 Account system from day one; C153 Automatic cloud backup on by default — never manual opt-in; C154 Compensation for lost data must match the loss — never a flat token

### R10-154 — F3: gate monthly events behind a crash test across device generations — the corpus contains the exact repro ('after the growth potion'); a pre-release check would have prevented the largest quality event in the app's history and, because of streaks, the largest single destruction of user progress

- **Where:** §9.1 F3. Gate monthly events behind a crash test
- **This app does:** no pre-release crash gate on event content
- **User reaction:** 1★-burst
- **Magnitude:** Feb 2026 120 crash-tagged reviews from a single event asset; June 2026 second cluster
- **Direction for us:** must-never-break · **Report confidence:** recommendation (fix) · **Generalisable:** yes
- **Canonical:** C156 Content and event releases need a crash gate across device generations

### R10-169 — Fix price presentation: household members quoted different prices on the same day, support could not explain — whatever the mechanism, the perception is discriminatory pricing inside families

- **Where:** §9.4 Fix price presentation
- **This app does:** inconsistent quoted prices
- **User reaction:** complaint
- **Magnitude:** 12 reviews
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C113 One stable, disclosed price — no discount wheels

## Features

### R10-014 — A large, coherent, unserved accessibility and internationalisation demand — none are complaints about a broken thing, they are people asking to be able to keep paying

- **Where:** EXECUTIVE SUMMARY #8 A large, coherent, unserved accessibility and internationalisation demand; §4.6; §7.4
- **This app does:** English-only; no dark mode; no Apple Watch; no Apple Health; no cross-device sync; no Family Sharing
- **User reaction:** blocked-conversion
- **Magnitude:** accessibility 597 (0.85%); localisation 292 (0.42%); dark mode 90; Apple Watch 92; Apple Health 608; cross-device sync 31; Family Sharing 30; Russia localisation 18.45% of all RU reviews; China 26.42%
- **Direction for us:** build-free · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C027 Localise early — it unlocks revenue; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R10-018 — Feature vocabulary by how many reviews mention it: adventures, Finch Plus, breathing, outfits, journaling, reflections, streaks, quests, Journeys (removed), mood tracking (auto check-in removed), micropets, gems/stones, furniture, quizzes, shop, widget (chronically broken), Guardian, first aid kit, travel, soundscapes, good vibes, Tree Town, insights, merch, Self-Care Areas, pause mode

- **Where:** §2.1 Feature vocabulary table (verbatim)
- **This app does:** full feature set as described by reviewers
- **User reaction:** mixed
- **Magnitude:** Feature / term | Reviews | % | Notes ; Adventures / exploring | 2,290 | 3.27% | Core loop. Cooldown length is itself a complaint (§4.5) ; Finch Plus / premium | 2,278 | 3.25% | The subscription ; Breathing exercises | 1,606 | 2.29% | Named more than any other therapeutic tool ; Outfits / dressing the pet | 1,310 | 1.87% | ; Journaling | 1,302 | 1.86% | ; Reflections | 1,194 | 1.70% | Guided prompts ; Streaks | 1,189 | 1.70% | Added ~mid-2024 (§8.5) ; Quests | 1,153 | 1.65% | ; Journeys | 1,006 | 1.44% | Removed Apr–May 2025 (§8.5) ; Mood tracking | 953 | 1.36% | Auto check-in removed Oct 2025 (§8.5) ; Micropets | 935 | 1.33% | Hatched from eggs; monthly event rewards ; Gems / stones | 766 + 461 | — | In-game currency ; Furniture / nest decor | 712 | 1.02% | ; Quizzes / self-assessments | 558 | 0.80% | Depression, anxiety, ADHD, body image ; Shop (Mr. Prickles / Robin's) | 509 | 0.73% | Random daily rotation, paid re-roll ; Widget | 493 | 0.70% | Chronically broken (§4.3) ; Guardian programme | 449 | 0.64% | Sponsor another user's subscription ; First aid kit | 444 | 0.63% | Crisis / distress tools ; Travel (Finchie Forest, Tokyo, Paris…) | 388 | 0.55% | ; Soundscapes | 385 | 0.55% | ; Good vibes / gifting | 370 | 0.53% | ; Tree Town (friends) | 325 | 0.46% | ; Insights / weekly report | 145 | 0.21% | ; Merch (plushies, pins, stickers) | 134 | 0.19% | Physical goods; fulfilment complaints (§4.8) ; Self-Care Areas | 52 | 0.07% | The Journeys replacement ; Pause mode / snooze | 54 | 0.08% |
- **Direction for us:** research · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-019 — Breathing exercises are the therapeutic tool reviewers name most, ahead of journaling and reflections

- **Where:** §2.1 Breathing exercises named more than any other therapeutic tool
- **This app does:** breathing exercises free, some (anxiety) gated
- **User reaction:** praise
- **Magnitude:** breathing 1,606 (2.29%); journaling 1,302 (1.86%); reflections 1,194 (1.70%); quizzes 558 (0.80%); first aid kit 444 (0.63%); soundscapes 385 (0.55%)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R10-020 — A pause mode / snooze exists and is mentioned by a small number of reviewers

- **Where:** §2.1 Pause mode / snooze row; §4.6
- **This app does:** pause mode exists
- **User reaction:** mixed
- **Magnitude:** 54 mentions (0.08%)
- **Direction for us:** undecided · **Report confidence:** ignore-band · **Generalisable:** yes
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history)

### R10-024 — The anxiety breathing exercise is reported gated behind Plus in a mental-health app — a therapeutic tool behind a paywall

- **Where:** §2.2 Anxiety breathing exercise gated
- **This app does:** anxiety breathing exercise paid
- **User reaction:** complaint
- **Magnitude:** several reviewers
- **Direction for us:** build-free · **Report confidence:** corpus-derived · **Generalisable:** yes
- **Review IDs:** `14338788841`
- **Canonical:** C001 Never move a free feature behind the paywall; C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R10-035 — The self-care tool set (breathing, soundscapes, first aid kit, journaling) is praised at high-priority scale

- **Where:** §3.1 P-tools Breathing, soundscapes, first aid, journaling
- **This app does:** tool set mostly free, some paid
- **User reaction:** praise
- **Magnitude:** P-tools 3,746 (5.35%, HIGH-PRIORITY) mean 4.84
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C116 Content library (workouts, meditation, sleep, journal) as the paid layer

### R10-036 — Social features (Tree Town friend town, 'good vibes' gifting) are a meaningful praise theme

- **Where:** §3.1 P-social Tree Town, good vibes, friends
- **This app does:** Tree Town, good vibes gifting free
- **User reaction:** praise
- **Magnitude:** P-social 2,035 (2.91%, MEANINGFUL) mean 4.84; Tree Town 325 mentions; good vibes 370
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C015 Shared / group habits

### R10-070 — Unmet needs are retention offers from users who already like the product — almost all 4–5★: more pet interaction, Apple Health, accessibility, localisation, completion verification, Apple Watch, dark mode, night-shift schedule, cross-device sync, Family Sharing, desktop/web

- **Where:** §4.6 Unmet needs — requests, not defects table (verbatim)
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** Request | n | % | Signal | Mean | Note ; More pet interaction / mini-games | 829 | 1.184% | MEANINGFUL | 4.64 | Largest single feature request ; Apple Health integration | 608 | 0.868% | EMERGING | 4.69 | Mindful minutes, water, medication ; Accessibility (broad) | 597 | 0.852% | EMERGING | 4.56 | See §7.4 ; Localisation | 292 | 0.417% | WEAK | 4.27 | 11+ languages requested ; Completion verification | 158 | 0.226% | WEAK | 4.59 | Photo proof / anti-cheat ; Apple Watch app | 92 | 0.131% | WEAK | 4.71 | Explicitly to reduce phone use ; Dark mode | 90 | 0.128% | WEAK | 4.28 | Requested since 2022 ; Night-shift / non-standard schedule | 146 | 0.208% | WEAK | 4.64 | Also southern-hemisphere seasons ; Cross-device sync | 31 | 0.044% | Ignore-by-default | 4.16 | 0 one-star ; Family Sharing | 30 | 0.043% | Ignore-by-default | 3.63 | Per-seat pricing objection ; Desktop / web | 6 | 0.009% | Ignore-by-default | 3.83 |
- **Direction for us:** build-free · **Report confidence:** verbatim · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C027 Localise early — it unlocks revenue; C080 Colour themes / dark mode

### R10-071 — More pet interaction / mini-games is the largest single feature request

- **Where:** §4.6 More pet interaction / mini-games — largest single feature request
- **This app does:** pet interaction limited to adventures and dressing
- **User reaction:** praise
- **Magnitude:** 829 (1.184%, MEANINGFUL) mean 4.64
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** app-specific
- **Canonical:** C117 Mascot / companion character

### R10-072 — Apple Health integration is the largest ignored integration ask in the corpus — mindful minutes, water, medication — almost entirely from satisfied users

- **Where:** §4.6 Apple Health (608 requests) is the largest ignored integration ask in the corpus
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 608 (0.868%, EMERGING) mean 4.69
- **Direction for us:** undecided · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `14408516417`, `12160927071`, `13818669914`, `8601859891`, `8323353137`, `11470496389`, `12397154442`, `13053497310`, `9878449464`
- **Canonical:** C021 Apple Health integration

### R10-073 — Apple Watch is the most emotionally coherent ask: users want it specifically to stop looking at their phone, which is the app's own stated goal — 'I got an Apple Watch because I felt like my phone was sucking attention and energy from me… I would love to be able to check on my birb and mark off goals on the watch'

- **Where:** §4.6 Apple Watch (92, mean 4.71) is the most emotionally coherent ask
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 92 (0.131%, WEAK) mean 4.71
- **Direction for us:** undecided · **Report confidence:** weak, high mean · **Generalisable:** yes
- **Review IDs:** `11451565056`, `14471258544`, `13919785505`, `8316004742`, `8310431154`, `12865399088`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R10-074 — Dark mode is an accessibility issue, not a preference — 'a self-care app could keep producing popular cosmetic items for the pets while leaving light-sensitive users without a basic accessibility feature. Cute clothes for the bird were apparently shippable' (migraine, light sensitivity)

- **Where:** §4.6 Dark mode (90 requests since 2022) is an accessibility issue, not a preference
- **This app does:** absent since 2022
- **User reaction:** complaint
- **Magnitude:** 90 (0.128%, WEAK) mean 4.28; requested since 2022
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `14284922425`, `13690970916`, `13654406960`, `14008031999`, `13145721783`, `12557849777`, `13945397134`
- **Canonical:** C080 Colour themes / dark mode; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R10-075 — Broad accessibility demand (screen reader, motion, disability representation, text size) is emerging-band and from satisfied users

- **Where:** §4.6 Accessibility (broad) row; §7.5
- **This app does:** partial
- **User reaction:** praise
- **Magnitude:** 597 (0.852%, EMERGING) mean 4.56; FAM-accessibility 1,150 (1.64%) mean 4.47
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

### R10-076 — Localisation is requested in 11+ languages

- **Where:** §4.6 Localisation row (11+ languages requested); §7.4
- **This app does:** English-only
- **User reaction:** blocked-conversion
- **Magnitude:** 292 (0.417%, WEAK) mean 4.27
- **Direction for us:** build-free · **Report confidence:** weak globally, very strong in RU/CN · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R10-077 — Completion verification (photo proof / anti-cheat) is asked for by users who admit checking boxes without doing the task

- **Where:** §4.6 Completion verification row
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 158 (0.226%, WEAK) mean 4.59
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C169 Completion verification / anti-cheat

### R10-078 — The app assumes a conventional daytime schedule and northern-hemisphere seasons; night-shift workers and southern-hemisphere users ask for a configurable day boundary and seasons

- **Where:** §4.6 Night-shift / non-standard schedule row (U-schedule-night)
- **This app does:** fixed day boundary and seasons
- **User reaction:** complaint
- **Magnitude:** 146 (0.208%, WEAK) mean 4.64
- **Direction for us:** build-free · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C170 Configurable day boundary and hemisphere seasons

### R10-079 — Cross-device sync / account portability is requested with zero one-star reviews — a pure request

- **Where:** §4.6 Cross-device sync row
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 31 (0.044%) mean 4.16, 0 one-star
- **Direction for us:** undecided · **Report confidence:** ignore-band · **Generalisable:** yes
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator

### R10-081 — Desktop / web version is barely requested in this corpus

- **Where:** §4.6 Desktop / web row
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** 6 (0.009%) mean 3.83
- **Direction for us:** research · **Report confidence:** ignore-band · **Generalisable:** yes
- **Canonical:** C044 Mac / desktop / web app

### R10-085 — Loyal users complain representation is missing — most often the lesbian flag, aroace, demigirl/demiboy — while a similar number object to LGBTQ+ content or want an opt-out; religious items and national flags are also requested

- **Where:** §4.7 111 reviews complain that representation is missing (C-lgbt-more); C-lgbt-objection; C-religion; C-national-flag
- **This app does:** Pride content; limited flag set
- **User reaction:** mixed
- **Magnitude:** C-lgbt-more 111 (0.158%) mean 4.57; C-lgbt-objection 109 (0.156%) mean 3.50; C-religion 116 (0.166%) mean 4.14; C-national-flag 16 mean 3.00
- **Direction for us:** undecided · **Report confidence:** weak, both directions · **Generalisable:** app-specific
- **Review IDs:** `12280237908`, `11159383290`, `12379742945`, `14144887984`, `12484266125`, `11477756750`, `10928423183`, `14347171250`
- **Canonical:** C161 Values and identity screens are optional in both directions

### R10-158 — P1: restore cumulative, non-streak progress tracking — the requirement is not the old UI, it is credit for non-consecutive progress; chronic-illness and ADHD users state a streak-only model is structurally incompatible with their lives; ship it alongside streaks, not instead of them

- **Where:** §9.3 P1. Restore cumulative, non-streak progress tracking
- **This app does:** removed cumulative progress (Journeys)
- **User reaction:** churn
- **Magnitude:** U-journeys-removed mean 2.76, lowest-rated change
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C047 Cumulative totals and total-days counter; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R10-161 — P4: let users buy what they can see — the catalogue shows items that cannot be purchased, the shop rotates randomly, the re-roll costs currency; this frustrates engaged, currency-rich users, the ones most likely to subscribe

- **Where:** §9.3 P4. Let users buy what they can see; §9.5 #6
- **This app does:** random shop rotation; paid re-roll; unpurchasable catalogue items
- **User reaction:** complaint
- **Magnitude:** U-economy 196 mean 4.10
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** app-specific
- **Review IDs:** `13291611680`, `14437464706`, `12896721169`, `13528610213`, `14277989798`
- **Canonical:** C164 A random-rotation shop with paid re-rolls and unpurchasable catalogue items is a friction generator

### R10-162 — P5: ship the platform integrations people are asking to pay for — Apple Health, Apple Watch, cross-device sync, Family Sharing — the stated price of a fifth star and, for Family Sharing, of two or four subscriptions instead of one

- **Where:** §9.3 P5. Ship the platform integrations people are asking to pay for
- **This app does:** absent
- **User reaction:** praise
- **Magnitude:** Apple Health 608 mean 4.69; Apple Watch 92 mean 4.71; sync 31 mean 4.16 zero 1★; Family Sharing 30
- **Direction for us:** undecided · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C037 Family plan

## Monetization

### R10-021 — Corpus-derived free/paid map: goals, check-off, energy, adventures free; basic outfits/furniture free with limited rotation (6–8 slots vs 12–16 for Plus); some breathing exercises gated; soundscapes and longer timers paid (previously free); full shop / colour options / outfit saves paid; monthly event micropet paid or partially paid from ~2025 (previously free); goal icon customisation paid; Journeys organisation was paid (2022); cloud backup free but opt-in and manual; Guardian paid add-on; Family Sharing not supported

- **Where:** §2.2 Free / paid / trial classification table (verbatim)
- **This app does:** generous free core with cosmetics and content paid
- **User reaction:** mixed
- **Magnitude:** Capability | Status per reviewers | Evidence ; Daily goals, checking off, energy, adventures | Free | Universal; 857 reviews explicitly praise free-tier scope ; Basic outfits and furniture (limited daily rotation) | Free | Free users report 6–8 shop slots vs. 12–16 for Plus ; Breathing exercises (some) | Mixed | Several reviewers report the *anxiety* breathing exercise gated: `14338788841` ; Soundscapes (animal sounds), longer timers | Paid | `13057118678`, `13594995098` — reported as previously free ; Full shop / colour options / outfit saves | Paid | `12383429614`, `14375332074`, `14378349434` ; Monthly event micropet (from ~2025) | Paid or partially paid | `14455889030`, `10529428569` — reported as previously free ; Goal icon customisation | Paid | `12187968321`, `12241626633` ; Journeys organisation (2022 era) | Was paid | `9130759190` ; Cloud backup / account sync | Free but opt-in and manual | 37 reviews; §4.3 ; Guardian (sponsoring others) | Paid add-on | 449 mentions ; Family Sharing | Not supported | 30 reviews, mean 3.63
- **Direction for us:** research · **Report confidence:** corpus-derived · **Generalisable:** app-specific
- **Review IDs:** `14338788841`, `13057118678`, `13594995098`, `12383429614`, `14375332074`, `14378349434`, `14455889030`, `10529428569`, `12187968321`, `12241626633`, `9130759190`
- **Canonical:** C001 Never move a free feature behind the paywall

### R10-022 — Shop slot count is the free/paid boundary for cosmetics: free users see 6–8 daily shop slots vs 12–16 for Plus — gating on quantity of rotation, not on a capability

- **Where:** §2.2 Free users report 6–8 shop slots vs 12–16 for Plus
- **This app does:** shop rotation size gated
- **User reaction:** mixed
- **Magnitude:** report gives none beyond the slot counts
- **Direction for us:** undecided · **Report confidence:** corpus-derived · **Generalisable:** yes
- **Canonical:** C133 Gate on capability, not on quantity

### R10-025 — A 7-day free trial is the dominant description, but 3-day, 2-day and 5-day variants also appear — trial length is not consistent across users

- **Where:** §2.2 Trial: 7-day free trial dominant with 3/2/5-day variants
- **This app does:** 7-day trial defaulting to annual; variants 2/3/5 days
- **User reaction:** mixed
- **Magnitude:** trial-mention flag; variants cited by 4 reviews
- **Direction for us:** research · **Report confidence:** corpus-derived · **Generalisable:** app-specific
- **Review IDs:** `10132933191`, `12814784154`, `12752079228`, `12675075647`
- **Canonical:** C109 A free trial must be a real trial

### R10-027 — Prices reviewers report (what users say they were charged, not a price list): $40 dominant, then $70, $50, $60, $39.99…; plus ¥11,000/yr (JP), R1,500 (ZA), RM199 (MY), €45–€80, £30–£120, C$50–C$200, A$30–A$130, ₽3,000–6,000

- **Where:** §2.3 Prices reviewers report table (verbatim)
- **This app does:** annual ~$40 (most cited) up to $70–$100
- **User reaction:** mixed
- **Magnitude:** Price point | Mentions | Price point | Mentions ; $40 | 129 | $39.99 | 17 ; $70 | 49 | $10 | 16 ; $50 | 32 | $100 | 15 ; $60 | 21 | $20 | 15 ; $35 | 11 | $30 | 11 ; $9.99 | 10 | £40 | 10 ; $69.99 | 6 | £39.99 | 8 ; $49.99 | 6 | $42 | 7 ; $99.99 | 5 | £69.99 | 5 ; $34.99 | 5 | $75 | 5 ; hand-read: ¥11,000/yr JP; R1,500 ZA; RM199 MY; €45–€80; £30–£120; C$50–C$200; A$30–A$130; ₽3,000–6,000
- **Direction for us:** research · **Report confidence:** corpus-derived · **Generalisable:** app-specific
- **Review IDs:** `13046812794`, `11204966534`, `13181758667`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R10-029 — Monetisation model: free-to-download; generous free tier; 7-day trial defaulting to an ANNUAL subscription; onboarding-time discounted offer with a scarcity frame; in-game-currency shops with randomised rotation and a paid re-roll; a monthly seasonal pass with paid and free reward tracks; a Guardian tier for gifting; physical merchandise; and from 2026 sponsored IP events

- **Where:** §2.4 Monetisation model summary
- **This app does:** subscription + seasonal pass + gifting + merch + sponsored events
- **User reaction:** mixed
- **Magnitude:** report gives none on this summary
- **Direction for us:** research · **Report confidence:** corpus-derived · **Generalisable:** app-specific
- **Canonical:** C168 Monthly seasonal event with a paid reward track

### R10-080 — Family Sharing is not supported and the objection is per-seat pricing — households asked to pay twice

- **Where:** §4.6 Family Sharing row; §2.2 Family Sharing not supported
- **This app does:** no Family Sharing
- **User reaction:** complaint
- **Magnitude:** 30 (0.043%) mean 3.63
- **Direction for us:** research · **Report confidence:** ignore-band · **Generalisable:** yes
- **Canonical:** C037 Family plan

### R10-100 — 'Advertised free but isn't' / false-advertising claims are a distinct 1★ theme

- **Where:** Part 5 1★ band M-not-free row; §6.3 M-not-free
- **This app does:** listed free with trial defaulting to annual
- **User reaction:** 1★-burst
- **Magnitude:** M-not-free 126 global, 68 one-star (3.86% of 1★ band); 18 paid (7.2× lift)
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R10-102 — The paid cohort rates 1.1 stars below non-payers, nearly a quarter of it is one-star, and reviews mentioning both a purchase and a trial average 2.19

- **Where:** §6.1 The paid cohort — paid mean 3.661, 1★ 23.24%; trial-mention reviews; paid+trial
- **This app does:** subscription with trial
- **User reaction:** churn
- **Magnitude:** paid 1,381 (1.97%) mean 3.661; 5★ 763 · 4★ 118 · 3★ 90 · 2★ 89 · 1★ 321 (23.24%); non-paid mean 4.785; trial-mention 588 (0.84%) mean 3.238; paid+trial 178 mean 2.185
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R10-108 — Payers over-index on the Guardian programme, on praising the free tier, on accessibility and Apple Health requests, and on upsell-pressure complaints

- **Where:** §6.3 M-guardian, P-free-generous, U-accessibility, U-apple-health, M-upsell-pressure rows in paid table
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** M-guardian 92 paid (6.66%, 6.6×); P-free-generous 71 (5.14%, 4.2×); U-accessibility 44 (3.19%, 3.7×); U-apple-health 34 (2.46%, 2.8×); M-upsell-pressure 15 (1.09%, 8.5×; global 90)
- **Direction for us:** research · **Report confidence:** segment lifts · **Generalisable:** yes
- **Canonical:** C025 Scholarship / hardship / discount program

### R10-109 — Purchase trigger: the trial worked and they wanted to keep it — 'you start out with the plus version as a free trial and once we lost it we aren't as interested'

- **Where:** §6.4 The trial worked and they wanted to keep it
- **This app does:** 7-day Plus trial
- **User reaction:** purchase-driver
- **Magnitude:** 4 cited reviews; no conversion rate claimed
- **Direction for us:** build-paid · **Report confidence:** thin evidence · **Generalisable:** yes
- **Review IDs:** `11833081713`, `9807397020`, `12777430846`, `14497912306`
- **Canonical:** C063 Free trial before purchase

### R10-110 — Purchase trigger: cosmetic and colour variety — 'I started getting finch plus solely because I found the extra color options in the seasonal items & larger shop selection very motivating to get my tasks done'

- **Where:** §6.4 Cosmetic/colour variety was the specific hook
- **This app does:** Plus = more colours, larger shop
- **User reaction:** purchase-driver
- **Magnitude:** 3 cited reviews
- **Direction for us:** build-paid · **Report confidence:** thin evidence · **Generalisable:** yes
- **Review IDs:** `14378349434`, `14497912306`, `12783240976`
- **Canonical:** C167 Cosmetic and colour variety as the paid layer

### R10-111 — Purchase trigger: completing the monthly event (paid reward track / micropet)

- **Where:** §6.4 Monthly event completion
- **This app does:** seasonal pass with paid track
- **User reaction:** purchase-driver
- **Magnitude:** 3 cited reviews
- **Direction for us:** build-paid · **Report confidence:** thin evidence · **Generalisable:** app-specific
- **Review IDs:** `13929170868`, `14455889030`, `13741508287`
- **Canonical:** C168 Monthly seasonal event with a paid reward track

### R10-112 — Purchase trigger: support the developers because it works — 'even though I don't make a lot of money I make it a priority to pay for this app because I know how much joy it brings me'; 'I use this app every day… and I think I'm worth $40'

- **Where:** §6.4 Support the developers / because it works
- **This app does:** goodwill conversion
- **User reaction:** purchase-driver
- **Magnitude:** 4 cited reviews
- **Direction for us:** build-paid · **Report confidence:** thin evidence · **Generalisable:** yes
- **Review IDs:** `11112718539`, `13005792453`, `12547227541`, `8456836129`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R10-116 — Price at renewal is a distinct, smaller cancellation driver — triggered by a renewal quote higher than the original price

- **Where:** §6.5 #7 Price at renewal — renewal quote higher than the original
- **This app does:** renewal price rises vs intro price
- **User reaction:** churn
- **Magnitude:** 4 cited reviews
- **Direction for us:** dont · **Report confidence:** small · **Generalisable:** yes
- **Review IDs:** `12515242428`, `12222994297`, `12155763925`, `14300275597`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R10-167 — Offer a genuine monthly plan and price it visibly — the default-to-annual is the mechanism behind most of the billing disputes; several reviewers say plainly they would have paid monthly

- **Where:** §9.4 Offer a genuine monthly plan and price it visibly (M-no-monthly)
- **This app does:** annual default; monthly absent or hidden
- **User reaction:** blocked-conversion
- **Magnitude:** M-no-monthly 23 reviews ask directly; 404 billing disputes
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `11241544851`, `11243997394`, `12547404473`
- **Canonical:** C163 Visible monthly plan — annual-default trials drive billing disputes

### R10-168 — Offer a one-time purchase tier — asked for explicitly

- **Where:** §9.4 Offer a one-time purchase tier (M-want-onetime)
- **This app does:** subscription only
- **User reaction:** blocked-conversion
- **Magnitude:** M-want-onetime 47 reviews, mean 3.62
- **Direction for us:** research · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R10-180 — 'Self-care should be free' — a normative objection to charging at all, distinct from a price objection — is small and flat across five years

- **Where:** §7.2 M-should-be-free row; §8.7 M-should-be-free flat
- **This app does:** free tier + subscription
- **User reaction:** complaint
- **Magnitude:** M-should-be-free us 0.34% / gb 0.40% / ca 0.32% / au 0.32%; by year 0.37% → 0.41% → 0.29% → 0.25% → 0.35% (flat)
- **Direction for us:** none · **Report confidence:** weak, flat · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

## Tactics the app used

### R10-041 — A clinician channel exists: 'my therapist recommended this', plus therapists and psychologists writing as professionals who recommend it to clients — a high-trust acquisition channel that is visibly reversible: two clinicians publicly withdrew the recommendation over data loss

- **Where:** §3.1 P-therapist-rec; §3.2 (d) Clinical channel
- **This app does:** therapist-recommended, no formal program
- **User reaction:** praise
- **Magnitude:** P-therapist-rec 381 (0.54%, EMERGING) mean 4.91; 2 clinicians withdrawing
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** yes
- **Side effects:** data loss destroys the clinician channel
- **Review IDs:** `13192704866`, `12678214054`, `10195590904`, `12025813421`, `13983749907`, `8322398440`, `12658276545`, `13652698300`, `13875198474`, `11714664731`, `13569423105`, `13434160590`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R10-113 — The Guardian sponsored-membership programme is a strategic asset: one of very few monetisation-adjacent themes with a positive mean, functioning as both a conversion path and a goodwill generator, described warmly by both receivers and givers; the friction is that it is hard to APPLY for and opaque about whether sponsorship reached a real person ('they advertise a guardian program to cover people like me but there is no way to apply')

- **Where:** §6.4 Gifted or sponsored first; §6.6 The Guardian programme is a strategic asset the corpus rates highly
- **This app does:** Guardian: pay to sponsor another user's subscription
- **User reaction:** purchase-driver
- **Magnitude:** M-guardian 708 mentions, mean 4.76, 92 with purchase evidence; Guardian programme 449 feature-vocabulary mentions
- **Direction for us:** do · **Report confidence:** meaningful, positive mean · **Generalisable:** yes
- **Review IDs:** `13583950351`, `12963211313`, `11377452881`, `12745041087`, `14491292042`, `14262792225`, `9977710032`, `11401527483`, `9723946025`, `12771102574`, `10246078752`, `14131024327`, `14142344100`
- **Canonical:** C025 Scholarship / hardship / discount program

### R10-170 — Formalise and publicise the Guardian pathway — its only consistent complaint is that there is no visible way to apply

- **Where:** §9.4 Formalise and publicise the Guardian pathway
- **This app does:** Guardian exists, application path invisible
- **User reaction:** praise
- **Magnitude:** mean 4.76 across 708 mentions
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C025 Scholarship / hardship / discount program

## Insights (the why)

### R10-004 — The paying cohort is the only cohort whose satisfaction is collapsing, and it has collapsed by 1.4 stars while the public rating barely moves: the headline number is held up by an ever-growing base of new free users while the monetised cohort curdles — the single most important number in the corpus

- **Where:** ⚠️ Read these five things — 1. The paying cohort is the only cohort whose satisfaction is collapsing; EXECUTIVE SUMMARY #1 Paid-user sentiment is in free-fall while the headline rating is not; §6.1
- **This app does:** subscription (Finch Plus) with free trial; free tier generous
- **User reaction:** churn
- **Magnitude:** 1,381 paid-evidence reviews (1.97%); paid mean 4.40 (2022) → 4.01 (2023) → 3.82 (2024) → 3.19 (2025) → 2.96 (2026); non-paid mean 4.785 overall; corpus mean 4.864 → 4.645; in 2026 36.7% of paid-evidence reviews are 1★ (92/251)
- **Direction for us:** product-rule · **Report confidence:** high-priority (headline) · **Generalisable:** yes
- **Conditions:** paid cohort is a floor biased toward billing grievances (§6.2)
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R10-009 — What is genuinely working is worth more than all the problems: nearly a third of the corpus carries a core-benefit theme at 4.89; mental-health benefit, life-change claims, ADHD/neurodivergent self-identification, clinician recommendation and free-tier/ad-free praise — each of these is directly threatened by a decision described elsewhere in the report

- **Where:** ⚠️ What is genuinely working, and is worth more than all of the above; EXECUTIVE SUMMARY What must be protected
- **This app does:** free tier generous and ad-free; gentle tone; companion pet
- **User reaction:** praise
- **Magnitude:** core-benefit 20,883 (29.82%) mean 4.89; P-mental-health 8,398 (11.99%); P-life-changed 2,686 (3.83%) mean 4.97; P-adhd-nd 5,157 (7.36%); P-therapist-rec 381 (0.54%); P-free-generous 857 (1.22%); non-punitive tone 476 mean 4.87; companionship 1,309
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C095 Neutral, non-judgemental tone on failure; C117 Mascot / companion character

### R10-010 — Finch is a beloved product with a 4.76 mean rating whose written record shows five years of steadily accumulating trust damage, concentrated almost entirely on people who have paid

- **Where:** EXECUTIVE SUMMARY headline
- **This app does:** subscription self-care pet
- **User reaction:** mixed
- **Magnitude:** mean 4.76 over 70,041; paid cohort 4.40 → 2.96
- **Direction for us:** product-rule · **Report confidence:** headline · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R10-015 — A values conflict runs in both directions and cannot be resolved by picking a side: some object to being asked the pet's pronouns and delete on that screen, some object to LGBTQ+ content, and MORE complain there is not enough representation (these are the loyal users); the only intervention the corpus supports is optionality, not editorial change

- **Where:** EXECUTIVE SUMMARY #9 A values conflict runs in both directions and cannot be resolved by picking a side; §4.7
- **This app does:** pet pronoun question in onboarding; Pride content; inclusive design
- **User reaction:** mixed
- **Magnitude:** 428 discuss pronouns; 54 object to being asked (mean 3.24); 109 object to LGBTQ+ content (mean 3.50); 111 want MORE representation (mean 4.57); 116 ask for religious items; 16 for a national flag
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C161 Values and identity screens are optional in both directions

### R10-031 — Fourteen positive themes ranked: motivation, cute design, recommend, mental health, ADHD/ND, tools, life-changed, social, companion, team praise, free-generous, gentle, therapist-rec, sobriety

- **Where:** §3.1 Positive themes, ranked table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % | Signal | Mean | Reading ; `P-motivation` | 11,175 | 15.96% | HIGH-PRIORITY | 4.88 | Motivation / follow-through is the #1 reported benefit ; `P-cute-design` | 10,074 | 14.38% | HIGH-PRIORITY | 4.91 | Aesthetics are load-bearing, not decorative ; `P-recommend` | 9,765 | 13.94% | HIGH-PRIORITY | 4.91 | Explicit recommendation to others ; `P-mental-health` | 8,398 | 11.99% | HIGH-PRIORITY | 4.89 | Concrete mental-health benefit claimed ; `P-adhd-nd` | 5,157 | 7.36% | HIGH-PRIORITY | 4.76 | Self-identified ADHD/autistic/ND user ; `P-tools` | 3,746 | 5.35% | HIGH-PRIORITY | 4.84 | Breathing, soundscapes, first aid, journaling ; `P-life-changed` | 2,686 | 3.83% | VERY STRONG | 4.97 | "changed my life" / "best app ever" ; `P-social` | 2,035 | 2.91% | MEANINGFUL | 4.84 | Tree Town, good vibes, friends ; `P-companion` | 1,309 | 1.87% | MEANINGFUL | 4.84 | "not alone", "like a friend" ; `P-team-praise` | 974 | 1.39% | MEANINGFUL | 4.90 | Praise for the developers specifically ; `P-free-generous` | 857 | 1.22% | MEANINGFUL | 4.92 | Free tier praised as generous / ad-free ; `P-gentle` | 476 | 0.68% | EMERGING | 4.87 | Non-punitive tone, "no guilt", "at my own pace" ; `P-therapist-rec` | 381 | 0.54% | EMERGING | 4.91 | Clinician recommended it, or reviewer is a clinician ; `P-sobriety` | 134 | 0.19% | WEAK | 4.62 | Sobriety / recovery use case
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-032 — Motivation / follow-through is the #1 reported benefit, and aesthetics are load-bearing rather than decorative — cute design is the second-largest theme and rates higher than motivation

- **Where:** §3.1 P-motivation is the #1 reported benefit; P-cute-design aesthetics are load-bearing, not decorative; P-recommend
- **This app does:** cute bird pet, cosmetics
- **User reaction:** praise
- **Magnitude:** P-motivation 11,175 (15.96%, HIGH-PRIORITY) mean 4.88; P-cute-design 10,074 (14.38%) mean 4.91; P-recommend 9,765 (13.94%) mean 4.91
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C117 Mascot / companion character

### R10-033 — A concrete mental-health benefit is claimed by one in eight reviewers and 'changed my life' claims rate a near-perfect 4.97; the core-benefit family is nearly 30% of the corpus

- **Where:** §3.1 P-mental-health; P-life-changed; core-benefit family
- **This app does:** self-care tools + pet
- **User reaction:** praise
- **Magnitude:** P-mental-health 8,398 (11.99%) mean 4.89; P-life-changed 2,686 (3.83%, VERY STRONG) mean 4.97; core-benefit family 20,883 (29.82%) mean 4.89
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C117 Mascot / companion character

### R10-037 — The externalisation mechanism works and users articulate it precisely: 'I will do for the bird what I will not do for myself' — the causal story users tell about why this app worked when others didn't; companionship ('not alone', 'like a friend') is its own theme

- **Where:** §3.1 P-companion; §3.2 (a) The externalisation mechanism works, and users articulate it precisely
- **This app does:** pet whose wellbeing depends on the user's goals
- **User reaction:** praise
- **Magnitude:** P-companion 1,309 (1.87%, MEANINGFUL) mean 4.84; most-endorsed review in corpus 358 net votes
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9438141619`, `12370795858`, `11489285888`, `8499763457`, `8797139022`, `10841359117`, `13005792453`, `12674347241`, `8389731820`, `9272023003`
- **Canonical:** C117 Mascot / companion character

### R10-038 — Praise for the developers specifically is a meaningful theme

- **Where:** §3.1 P-team-praise
- **This app does:** developer visibly cares
- **User reaction:** praise
- **Magnitude:** P-team-praise 974 (1.39%, MEANINGFUL) mean 4.90
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R10-039 — The free tier's reputation is an asset with a measurable size: reviewers volunteer that the free version is generous, ad-free and does not nag ('Finally, an app that is actually free… no annoying pop ups'; 'prioritises your mindfulness exercises without pushing its subscription service at all') — this is the asset the 2026 sponsored-IP events spend down

- **Where:** §3.1 P-free-generous; §3.2 (c) The free tier's reputation is an asset with a measurable size
- **This app does:** generous, non-nagging free tier
- **User reaction:** praise
- **Magnitude:** P-free-generous 857 (1.22%, MEANINGFUL) mean 4.92
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `8797139022`, `8619792409`, `8343850932`, `8345380038`, `14135326556`, `10246078752`, `13212308967`, `11984368192`, `12099230305`, `13918020477`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C061 Goodwill conversion — a generous free tier and 'support the devs'; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R10-044 — Ordering by volume and ordering by damage are almost inverted: the billing-dispute family is the smallest complaint family and by far the most destructive

- **Where:** §4.1 The ordering by volume and the ordering by damage are almost inverted; The billing-dispute family is the smallest complaint family and by far the most destructive
- **This app does:** trial conversion without reminder
- **User reaction:** 1★-burst
- **Magnitude:** FAM-billing-dispute 404 (0.58%) mean 1.97, 244 (60.4%) one-star, 17.45% of every reviewer who mentions having paid; FAM-monetization-any 2,045 (2.92%) mean 3.73; FAM-gamification-harm 1,948 (2.78%) mean 4.38; FAM-reliability 1,648 (2.35%) mean 3.32; FAM-data-integrity 658 (0.94%) mean 3.14, 27.5% 1★
- **Direction for us:** must-never-break · **Report confidence:** emerging / highest severity · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R10-048 — Why this is worse than an ordinary billing complaint: the product is marketed to and adopted by people who state they cannot reliably remember things — a promised reminder is not a courtesy in that context, it is the feature; reviewers make this argument unprompted dozens of times

- **Where:** §4.2 Why this is worse than an ordinary billing complaint (ADHD + promised reminder)
- **This app does:** ADHD-marketed app that fails its own reminder promise
- **User reaction:** 1★-burst
- **Magnitude:** 7.36% of corpus self-identifies as ADHD/ND; 6 cited IDs making the argument
- **Direction for us:** product-rule · **Report confidence:** argued by reviewers · **Generalisable:** yes
- **Review IDs:** `11939993235`, `11959224161`, `12738181086`, `13571872699`, `13042542238`, `14043265448`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R10-057 — Data loss is described in bereavement language — 'It feels like a pet died', 'my birb Bean… she liked tea, chocolate chip cookies, and hated Blues Clues. And now she's gone', 'planning the funeral for her birb', 'murdered my bird, my heart, and my soul' — the emotional-attachment mechanic firing in reverse

- **Where:** §4.3 It is described in bereavement language
- **This app does:** single-pet attachment with no backup
- **User reaction:** 1★-burst
- **Magnitude:** 4 cited bereavement reviews within 551 data-loss reviews
- **Direction for us:** must-never-break · **Report confidence:** qualitative · **Generalisable:** yes
- **Side effects:** the stronger the attachment mechanic, the larger the data-loss liability
- **Review IDs:** `9583838100`, `13033899041`, `14243659017`, `13732070192`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C117 Mascot / companion character

### R10-068 — 'It's just a checklist' is the churn thesis, stated by people who still rate it highly ('Just create a Notes app checklist and add it as a widget'); its sibling, completion verification, is the same observation as a feature request — users volunteer that they check boxes without doing the task and ask to be held accountable

- **Where:** §4.5 'It's just a checklist' is the churn thesis; U-goal-verification sibling
- **This app does:** no completion verification
- **User reaction:** mixed
- **Magnitude:** U-just-checklist 111 (0.158%) mean 4.13; U-goal-verification 158 (0.226%) mean 4.59
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `11976062097`, `11688717901`, `13649889390`, `12241418903`, `14263816049`, `11584654564`, `12966352245`
- **Canonical:** C169 Completion verification / anti-cheat

### R10-096 — The 4★ band is the highest-signal band for roadmap purposes — praise plus a single named blocker — and it is where the platform gaps live: Apple Health, Apple Watch, dark mode and cross-device sync all peak here relative to global share; these reviewers are telling you the exact price of their fifth star

- **Where:** Part 5 4★ band — the 'one thing away' band; The four-star band is where the platform gaps live
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 4★ n=4,655 (6.65%); U-more-pet 174 (3.74% of band); U-overwhelm 142 (3.05%); M-paywall 141 (3.03%); M-price-high 101 (2.17%); D-crash 96; U-boring 94; D-data-loss 78; U-localization 76; U-accessibility 68; U-economy 61; D-widget-bug 40; U-apple-health 38; U-dark-mode 26; U-apple-watch 18; D-sync-devices 12
- **Direction for us:** build-free · **Report confidence:** band analysis · **Generalisable:** yes
- **Canonical:** C021 Apple Health integration; C022 Apple Watch app (done properly: timer, two-way sync); C080 Colour themes / dark mode

### R10-097 — Three stars overwhelmingly means 'I like this and something is broken' — crashes and data loss together are 13.7% of the band; it is not lukewarm users, it is frustrated fans

- **Where:** Part 5 3★ band — the value-uncertainty band
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 3★ n=1,333 (1.90%); D-crash 94 (7.05% of band); D-data-loss 89 (6.68%); U-overwhelm 58 (4.35%); M-paywall 36; M-price-high 36; U-localization 34; P-motivation 123 (9.23%); P-adhd-nd 106 (7.95%)
- **Direction for us:** must-never-break · **Report confidence:** band analysis · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change

### R10-098 — Two-star reviewers are frequently long-term users writing a farewell: they establish that the app worked, then explain what broke it (P-adhd-nd and P-motivation are high in this band)

- **Where:** Part 5 2★ band — the buyer's-remorse band
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** 2★ n=742 (1.06%); D-crash 70 (9.43% of band); D-data-loss 51 (6.87%); U-overwhelm 39 (5.26%); M-trial-no-reminder 29 (3.91%); M-price-high 28; M-paywall 25; P-adhd-nd 61 (8.22%); P-motivation 58 (7.82%)
- **Direction for us:** must-never-break · **Report confidence:** band analysis · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R10-099 — Reading the 1★ band correctly is the key analytical move: a large share of one-star reviews are written by people who explicitly say the app helped them — detractors of a specific transaction or failure, not of the product; the band is ~30% reliability, ~14% billing dispute, ~19% monetization broadly, ~8% values/content, and only a small residue of 'not for me' — so the one-star population is highly recoverable and almost none of it is a product-market-fit problem

- **Where:** Part 5 1★ band — the churn band; Reading the one-star band correctly is the key analytical move; Implication: the one-star population is highly recoverable
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1★ n=1,761 (2.51%); D-data-loss 160 (9.09%); D-crash 151 (8.57%); M-trial-charged 99 (5.62%); M-trial-no-reminder 92 (5.22%); P-adhd-nd 92; P-mental-health 86; P-recommend 78; M-refund-denied 71 (4.03%); D-support 71; M-not-free 68 (3.86%); M-price-high 62; D-streak-bug 45; M-paywall 38; C-community-mod 37; C-pronouns 36; M-cancel-hard 36; C-brand-collab 35; C-age-rating 33; D-* union 526 (~30%); billing 244 (~14%); monetization 413 (~19%); values 133 (~8%)
- **Direction for us:** must-never-break · **Report confidence:** band analysis · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R10-106 — The five highest paid-cohort lifts are all billing-mechanics failures, not price and not product: paying users are not primarily complaining that Finch costs too much — they are complaining about how they were charged, and about not being able to undo it

- **Where:** §6.3 The shape of this table is the argument — Paying users are not primarily complaining that Finch costs too much
- **This app does:** trial/billing mechanics
- **User reaction:** churn
- **Magnitude:** M-refund-denied 47.1×; M-trial-charged 32.7×; M-trial-no-reminder 28.2×; M-unauthorized 23.9×; M-cancel-hard 23.1×; price only 7.8× (6.66% of paid reviews)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R10-107 — The second paid-cohort cluster — support, community moderation, brand collabs, feature removal, UI churn, AI — is a relationship cluster: the sound of a paying base that feels the company has stopped listening

- **Where:** §6.3 The second cluster is a relationship cluster
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** D-support 13.2×; C-brand-collab 8.0×; C-community-mod 7.0×; U-feature-removed-generic 6.6×; U-ui-change 6.5×; C-ai 4.2×
- **Direction for us:** dont · **Report confidence:** segment lifts · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

### R10-130 — The shape of the complaint set is stable across the four Anglophone storefronts (same order, within a factor of ~1.8): the billing-dispute mechanism, the data-loss mechanism and the feature-removal backlash are global, not regional — product problems, not market problems

- **Where:** §7.6 What does NOT vary by country — The billing-dispute mechanism, the data-loss mechanism and the feature-removal backlash are global, not regional
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** overwhelm, paywall, price, crashes, data loss in same order within ×1.8 in us/gb/ca/au
- **Direction for us:** product-rule · **Report confidence:** stable · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C034 Data must never be lost on update, reinstall or phone change; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R10-157 — The single highest-leverage decision: decide explicitly and publicly whether Finch is a self-care tool with a game attached or a collection game with self-care attached, then align the roadmap — the product has drifted from the first to the second without ever saying so, shown by the convergence of six signals; long-form reviewers state the drift as a thesis ('a pay-to-play loot box checklist simulator'); this is NOT a recommendation to remove the game (the game is why 10,074 call it cute and 11,175 say it motivates them) — it is to stop making the therapeutic layer pay for the game layer's growth: put First Aid back on the home screen, restore an OPTIONAL automatic mood check-in, stop moving breathing/soundscapes/reflections further behind menus

- **Where:** §9.2 The single highest-leverage product decision — self-care tool with a game attached or a collection game with self-care attached; convergence table (verbatim); 'a pay-to-play loot box checklist simulator'
- **This app does:** therapeutic layer buried under collection game
- **User reaction:** churn
- **Magnitude:** Signal | Direction ; `P-tools` mentions | 15.63% (2021) → 2.65% (2026) ; Positive-core family | 30.40% (2022H1) → 23.08% (2026H2) ; `U-overwhelm` | 1,046 reviews, MEANINGFUL, largest UX theme ; Feature removals (Journeys, mood check-ins, timed goals, milestones) | all replaced by streak/collection mechanics ; `U-streak-pressure` + `D-streak-bug` | 0 → 267 reviews since mid-2024 ; `C-brand-collab` | 2 (2022) → 107 (2026) ; P-cute-design 10,074; P-motivation 11,175
- **Direction for us:** product-rule · **Report confidence:** recommendation (strategic) · **Generalisable:** yes
- **Review IDs:** `13828330334`, `14268143502`, `14420113173`, `13688122090`, `12551489443`, `14425330451`, `13456598701`, `13828096584`, `13971066794`
- **Canonical:** C166 Keep the therapeutic core in front of the game layer

## Audiences

### R10-034 — ADHD / autistic / neurodivergent users are a very large, self-identifying segment — 7.36% of all reviews — and rate slightly below the other positive themes

- **Where:** §3.1 P-adhd-nd Self-identified ADHD/autistic/ND user
- **This app does:** gentle tone, externalisation via pet
- **User reaction:** praise
- **Magnitude:** P-adhd-nd 5,157 (7.36%, HIGH-PRIORITY) mean 4.76
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R10-042 — A sobriety / recovery use case exists at weak volume and rates lower than other positive themes

- **Where:** §3.1 P-sobriety
- **This app does:** no sobriety-specific feature
- **User reaction:** praise
- **Magnitude:** P-sobriety 134 (0.19%, WEAK) mean 4.62
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C019 Quit-habit / bad-habit mode

### R10-083 — Child-appropriateness / 4+ age-rating concerns are a meaningful theme, mostly from parents, mixed in direction

- **Where:** §4.7 C-age-rating row
- **This app does:** 4+ rated with mental-health quizzes
- **User reaction:** mixed
- **Magnitude:** C-age-rating 920 (1.314%, MEANINGFUL) mean 4.74
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R10-122 — Australia has the most neurodivergent-identified reviewer base and simultaneously the highest 'too childish' and boredom rates — a coherent segment signal: users came for ADHD support and are most likely to say the gamification is not aimed at them

- **Where:** §7.2 Australia has the corpus's most neurodivergent-identified reviewer base
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** au 2,166: P-adhd-nd 11.40% vs 7.36% global; U-childish 1.06%; U-boring 1.02%; P-motivation 18.10%; P-free-generous 1.62%
- **Direction for us:** research · **Report confidence:** stable (large n) · **Generalisable:** yes
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R10-129 — Accessibility is a market segment: blindness/VoiceOver, physical disability and mobility, chronic illness, motion sensitivity and epilepsy, sound sensitivity, light sensitivity; the recurring structural complaint is that the onboarding asks about disability and then ignores the answer — 'I have mobility issues, so I clicked that on the app, ever since, the app has been suggesting that I do things that I've told it I can't do'

- **Where:** §7.5 Accessibility as a market; the onboarding asks about disability and then ignores the answer
- **This app does:** asks about disability at onboarding; suggestions ignore it
- **User reaction:** complaint
- **Magnitude:** 597 accessibility reviews (0.85%) mean 4.56
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `7831288958`, `8427696106`, `10055344806`, `11110195517`, `8427543028`, `11467978208`, `12047590938`, `14249655239`, `14176678035`, `12682396517`, `13469175015`, `8432577759`, `8517938841`, `12097433833`, `13011506116`, `14427781194`, `14316419666`
- **Canonical:** C160 Honour what onboarding asks — a declared limitation must change the suggestions; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

## Markets and languages

### R10-030 — Finch is, in review terms, an English-language product with a small international tail that is asking loudly to be served: 92.11% of reviews come from four Anglophone storefronts

- **Where:** §2.5 A structural note on the language of this corpus
- **This app does:** English-only app
- **User reaction:** blocked-conversion
- **Magnitude:** US 50,932; GB 6,667; CA 4,748; AU 2,166 = 64,513 (92.11%); 21 non-English-primary storefronts 3,840 (5.48%); 90 sub-50 storefronts 956 (1.36%)
- **Direction for us:** research · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C027 Localise early — it unlocks revenue

### R10-117 — 31 storefronts with ≥50 reviews (69,085 reviews, 98.64%) analysed individually; 90 storefronts with 956 reviews (1.36%) generate no standalone conclusions; per-storefront n, mean, 1★ %, 5★ %

- **Where:** §7.1 Eligibility storefront table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | Mean | 1★ % | 5★ % ; us | 50,932 | 4.777 | 2.39 | 88.71 ; gb | 6,667 | 4.786 | 2.13 | 88.33 ; ca | 4,748 | 4.689 | 3.33 | 84.06 ; au | 2,166 | 4.716 | 2.95 | 84.76 ; de | 698 | 4.692 | 2.58 | 83.52 ; se | 478 | 4.738 | 2.09 | 84.94 ; nl | 410 | 4.671 | 3.17 | 81.95 ; fr | 273 | 4.513 | 4.76 | 74.73 ; no | 235 | 4.757 | 2.13 | 86.81 ; nz | 232 | 4.703 | 3.88 | 84.91 ; ru | 206 | 4.549 | 6.31 | 79.61 ; dk | 184 | 4.647 | 3.26 | 82.07 ; be | 166 | 4.717 | 2.41 | 83.73 ; es | 151 | 4.470 | 5.96 | 76.82 ; mx | 146 | 4.829 | 1.37 | 91.10 ; br | 142 | 4.697 | 2.11 | 85.92 ; ie | 122 | 4.746 | 3.28 | 86.07 ; pl | 112 | 4.902 | 0.00 | 93.75 ; ch | 111 | 4.721 | 1.80 | 86.49 ; fi | 111 | 4.568 | 4.50 | 77.48 ; in | 100 | 4.850 | 1.00 | 92.00 ; za | 94 | 4.830 | 1.06 | 89.36 ; at | 93 | 4.667 | 4.30 | 81.72 ; sg | 86 | 4.663 | 6.98 | 88.37 ; ph | 76 | 4.750 | 2.63 | 84.21 ; ae | 67 | 4.896 | 1.49 | 94.03 ; it | 59 | 4.576 | 5.08 | 83.05 ; pt | 58 | 4.534 | 6.90 | 81.03 ; tr | 58 | 4.638 | 5.17 | 81.03 ; cn | 53 | 4.208 | 5.66 | 52.83 ; cz | 51 | 4.922 | 0.00 | 92.16
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-119 — Storefront outliers: France, Russia, Spain, Singapore and Portugal carry the highest 1★ rates among eligible storefronts; Poland and Czechia have zero 1★ and the highest means; Mexico, India, South Africa and UAE rate very high; China is the worst-rated eligible storefront

- **Where:** §7.1 storefront outliers: fr, ru, es, sg, pt worst 1★; pl, cz, mx, in, za, ae best; cn worst mean
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** fr 273 mean 4.513 1★ 4.76%; ru 206 4.549 6.31%; es 151 4.470 5.96%; sg 86 4.663 6.98%; pt 58 4.534 6.90%; pl 112 4.902 0.00%; cz 51 4.922 0.00%; mx 146 4.829; in 100 4.850; za 94 4.830; ae 67 4.896; cn 53 4.208 5★ 52.83%
- **Direction for us:** research · **Report confidence:** storefront-level · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R10-120 — Within the four >1,000-review Anglophone storefronts (us, gb, ca, au): per-theme rates for 16 themes

- **Where:** §7.2 The high-review-volume group (defined) table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** group 64,513 (92.11%) mean 4.769; rest of world 5,528 mean 4.690; Theme | us (50,932) | gb (6,667) | ca (4,748) | au (2,166) ; `U-overwhelm` | 1.53% | 1.48% | 1.60% | 1.34% ; `C-age-rating` | 1.40% | 1.17% | 1.41% | 1.34% ; `M-paywall` | 1.02% | 1.08% | 1.39% | 1.39% ; `M-price-high` | 0.81% | 0.91% | 1.20% | 1.11% ; `D-crash` | 0.76% | 0.75% | 1.31% | 0.88% ; `U-boring` | 0.76% | 0.70% | 0.86% | 1.02% ; `D-data-loss` | 0.78% | 0.69% | 0.93% | 0.83% ; `U-childish` | 0.75% | 0.75% | 0.84% | 1.06% ; `C-pronouns` | 0.66% | 0.33% | 0.57% | 0.74% ; `M-should-be-free` | 0.34% | 0.40% | 0.32% | 0.32% ; `D-support` | 0.25% | 0.24% | 0.46% | 0.32% ; `M-trial-no-reminder` | 0.22% | 0.21% | 0.40% | 0.09% ; `P-mental-health` | 12.26% | 15.22% | 10.66% | 11.77% ; `P-motivation` | 16.23% | 14.40% | 17.92% | 18.10% ; `P-adhd-nd` | 7.12% | 7.48% | 8.17% | 11.40% ; `P-free-generous` | 1.27% | 0.99% | 1.43% | 1.62%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-121 — Canada is the problem market: lowest mean and highest 1★ rate in the Anglophone group, highest rates on paywall, price, crashes, data loss, support failure and trial-reminder failure, the highest paid-evidence rate, and a billing-dispute rate nearly double the US and more than double the UK

- **Where:** §7.2 Canada is the group's problem market — where the paid experience is worst and most reported; §7.3 Canada carries the highest paid exposure and the highest billing-dispute rate of any large market
- **This app does:** same product, worse paid outcome in CA
- **User reaction:** churn
- **Magnitude:** ca 4,748 mean 4.689, 1★ 3.33%; paywall 1.39%, price 1.20%, crash 1.31%, data loss 0.93%, support 0.46%, trial-reminder 0.40%; paid-evidence 2.38% vs US 2.08%; billing-dispute 0.95% vs US 0.55%, UK 0.43%
- **Direction for us:** research · **Report confidence:** stable (large n) · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R10-123 — The UK reports the strongest mental-health benefit and the group's lowest 1★ rate — the healthiest large market

- **Where:** §7.2 The UK reports the strongest mental-health benefit — the healthiest large market
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** gb 6,667 mean 4.786, 1★ 2.13%; P-mental-health 15.22% vs 11.99% global
- **Direction for us:** research · **Report confidence:** stable (large n) · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R10-124 — High-monetisation-exposure proxy group: storefronts ≥50 reviews whose paid-evidence rate exceeds the corpus 1.97% — with billing-dispute rate and mean; only us, ca, au are stable

- **Where:** §7.3 A defined 'high-monetisation-exposure' group (proxy, disclosed) table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | Paid-evidence rate | Billing-dispute rate | Mean ; fi | 111 | 4.50% | 1.80% | 4.568 ; pt | 58 | 3.45% | 1.72% | 4.534 ; za | 94 | 3.19% | 0.00% | 4.830 ; ie | 122 | 2.46% | 0.00% | 4.746 ; ca | 4,748 | 2.38% | 0.95% | 4.689 ; sg | 86 | 2.33% | 2.33% | 4.663 ; at | 93 | 2.15% | 1.08% | 4.667 ; us | 50,932 | 2.08% | 0.55% | 4.777 ; in | 100 | 2.00% | 0.00% | 4.850 ; au | 2,166 | 1.99% | 0.60% | 4.716
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-125 — The inverse group: Denmark, Belgium and Poland show zero paid-evidence reviews — markets where the free product does well and the paid product is essentially absent from the written record; Poland also has zero 1★ and the second-highest mean

- **Where:** §7.3 Denmark, Belgium and Poland show zero paid-evidence reviews
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** dk 184, be 166, pl 112: 0 paid-evidence; pl mean 4.902, 0 one-star
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-126 — Localisation rate by storefront — WEAK globally, HIGH-PRIORITY at country level in cn, ru, tr, br, es, mx, fr, de; VERY STRONG in at, ch, pt; these are floors

- **Where:** §7.4 Localisation is the single largest country-specific finding table (verbatim)
- **This app does:** English-only
- **User reaction:** blocked-conversion
- **Magnitude:** U-localization 292 global (0.42%); Storefront | Localisation rate | n | Signal at country level ; cn | 26.42% | 14/53 | HIGH-PRIORITY ; ru | 18.45% | 38/206 | HIGH-PRIORITY ; tr | 18.97% | 11/58 | HIGH-PRIORITY ; br | 13.38% | 19/142 | HIGH-PRIORITY ; es | 11.92% | 18/151 | HIGH-PRIORITY ; mx | 8.90% | 13/146 | HIGH-PRIORITY ; fr | 6.96% | 19/273 | HIGH-PRIORITY ; de | 5.87% | 41/698 | HIGH-PRIORITY ; at | 4.30% | 4/93 | VERY STRONG ; ch | 3.60% | 4/111 | VERY STRONG ; pt | 3.45% | 2/58 | VERY STRONG `[limited evidence]` ; jp | — | 15 mentions | `[limited evidence, n=45]`
- **Direction for us:** build-free · **Report confidence:** verbatim · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R10-127 — Localisation blocks payment: reviewers say they will not or cannot pay in English — a Russian one-liner 'Wants see a Russian language.. that's all:)' is the fifth most-endorsed review in the entire corpus; 'I'm giving it one star because there's no Russian language version… If the language version appears, I'll delete this review and give it 5 stars'; a Brazilian cites 215 million Portuguese speakers; a Canadian argues French is an official language and the app asks personal questions in a second language; a Chilean 'no pagaré más el plus' without Spanish

- **Where:** §7.4 Reviewers frequently state the consequence directly: they will not, or cannot, pay in English
- **This app does:** English-only
- **User reaction:** blocked-conversion
- **Magnitude:** cn 26.42% (14/53); ru 18.45% (38/206); tr 18.97% (11/58); br 13.38% (19/142); es 11.92% (18/151); mx 8.90%; fr 6.96%; de 5.87% (41/698); RU review with 37 net votes
- **Direction for us:** build-free · **Report confidence:** high-priority at country level · **Generalisable:** yes
- **Review IDs:** `10089551843`, `13365815550`, `13378852631`, `13145741750`, `12685853749`, `12782609083`, `12786765767`, `13015580489`, `12591344504`, `12599016250`, `14391291831`, `14297425558`
- **Canonical:** C027 Localise early — it unlocks revenue

### R10-128 — China is the worst-rated eligible storefront and a quarter of its reviews are a language request; it also contains a political-content complaint about Taiwan being listed as a separate travel destination — a market-access category of risk

- **Where:** §7.4 China is the corpus's worst-rated eligible storefront; Taiwan travel-destination complaint
- **This app does:** English-only; Taiwan listed as travel destination
- **User reaction:** complaint
- **Magnitude:** cn 53, mean 4.208, 5★ 52.83% vs 87.88% norm; localisation 26.42%; Taiwan complaint 2 reviews [limited evidence]
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `11915474270`, `12869927574`
- **Canonical:** C027 Localise early — it unlocks revenue

### R10-131 — Sub-50 storefronts are statistically indistinguishable from the corpus; Japan holds the corpus's only regional price-parity complaint — Finch Plus at ¥11,000/yr (~$74) against $40 in the US; Estonia and Hong Kong show lower means on small samples with no conclusion drawn

- **Where:** §7.7 Sub-50 storefronts [limited evidence] — Japan regional price-parity complaint; Estonia, Hong Kong
- **This app does:** no regional pricing (JP pays ~$74 vs $40)
- **User reaction:** complaint
- **Magnitude:** 90 storefronts 956 reviews (1.36%) mean 4.717; jp n=45 mean 4.533; ee n=34, hk n=37 means below 4.55
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13046812794`
- **Canonical:** C092 Regional pricing

### R10-164 — P7: localise — English-only is HIGH-PRIORITY at country level in eight storefronts simultaneously; priority order by combined volume and intensity: German, Spanish (es-419 + es-ES), French, Brazilian Portuguese, Russian, Japanese

- **Where:** §9.3 P7. Localise — priority order; §9.5 #5
- **This app does:** English-only
- **User reaction:** blocked-conversion
- **Magnitude:** cn 26.4%, tr 19.0%, ru 18.5%, br 13.4%, es 11.9%, mx 8.9%, fr 7.0%, de 5.9%; paid-evidence rate de 1.29% / es 0.66% / mx 0.68%
- **Direction for us:** build-free · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R10-007 — Two dated engineering failures visible at day resolution: 4 May 2022 crash-on-launch (largest quality event in the app's history at that time) and February 2026 'Wonderland / Queen of Hearts' event whose growth-potion animation made the pet oversized and crashed the app on load — reviewers named the exact trigger

- **Where:** ⚠️ 4. Two dated engineering failures visible at day resolution; §8.2 Trend 1
- **This app does:** monthly event shipped a crash
- **User reaction:** 1★-burst
- **Magnitude:** 4 May 2022: 128 reviews that day vs ~90/day baseline, mean 3.72, 34 one-star, 42 crash reports in one day; Feb 2026: 120 crash-tagged reviews in one month (2.03% of all 2026 reviews vs 0.36–0.53% baseline 2023–2024), peak 20 crash reports on 2 Feb 2026
- **Direction for us:** must-never-break · **Report confidence:** high-priority (headline) · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C156 Content and event releases need a crash gate across device generations

### R10-061 — Product-change backlash themes with peak periods: UI change (Feb 2024 redesign; continuous 2025–26), feature-removed-generic (2026), mood check-in removed (Oct 2025–Mar 2026), Journeys removed (Apr–Jun 2025), timed goals removed (Nov 2025–Jan 2026)

- **Where:** §4.4 Product-change backlash table (verbatim)
- **This app does:** repeated redesigns and removals
- **User reaction:** complaint
- **Magnitude:** Theme | n | % | Signal | Mean | Peak period ; `U-ui-change` | 94 | 0.134% | WEAK | 3.53 | Feb 2024 redesign; continuous 2025–26 ; `U-feature-removed-generic` | 77 | 0.110% | WEAK | 3.13 | 2026 (37 of 77) ; `U-moodcheckin-removed` | 64 | 0.091% | Ignore-by-default | 3.77 | Oct 2025 – Mar 2026 ; `U-journeys-removed` | 49 | 0.070% | Ignore-by-default | 2.76 | Apr–Jun 2025 ; `U-timedgoals-removed` | 9 | 0.013% | Ignore-by-default | 3.11 | Nov 2025 – Jan 2026 ; Family (union) | 269 | 0.384% | WEAK | 3.43 | —
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R10-103 — Paid-cohort satisfaction fell every single year for five years while the whole corpus barely moved; trial-mentioning reviewers track the same way

- **Where:** §6.1 The trend is the finding; The damage is concentrated on the people paying for the product
- **This app does:** subscription
- **User reaction:** churn
- **Magnitude:** paid mean 5.00 (2021, n=16) → 4.40 (2022, 275) → 4.01 (2023, 222) → 3.82 (2024, 260) → 3.19 (2025, 357) → 2.96 (2026, 251); 1★ share of paid 0% → 8.7% → 15.3% → 20.8% → 32.8% → 36.7%; corpus mean 4.864 → 4.645; 5★ share 91.70% → 83.15%; trial-mention mean 3.87 → 3.62 → 3.13 → 2.83 → 3.22
- **Direction for us:** product-rule · **Report confidence:** high-priority trend · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R10-115 — Cancellation and refund drivers in order from the paid cohort's own text: 1 billing surprise (largest), 2 data loss while subscribed, 3 feature removal (Journeys, mood check-ins, timed goals), 4 sponsored IP events ('I was a paid subscriber for 1.5 years and I just canceled my subscription because of the supergirl theme'), 5 ethics / AI / hiring, 6 support silence, 7 price at renewal (a renewal quote higher than the original)

- **Where:** §6.5 Cancellation and refund drivers, in order
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** billing 241 of 1,381; data loss 48 paid; feature removal 8 cited; IP events 8 cited; ethics 7; support 4; renewal price 4
- **Direction for us:** must-never-break · **Report confidence:** ordered by evidence · **Generalisable:** yes
- **Review IDs:** `13411041280`, `12547227541`, `13475103522`, `13523723252`, `14186200268`, `12705023244`, `13894921431`, `12515242428`
- **Canonical:** C029 Billing must be exactly right; C034 Data must never be lost on update, reinstall or phone change; C127 Never show ads to paying subscribers; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R10-132 — Time-trend method (half-year buckets for families, calendar years for themes, month/day for incidents) and baseline year table; the one-star rate has more than tripled while volume stayed high — the single most important background fact

- **Where:** §8.1 Method — three time resolutions; Baseline volume and sentiment table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Year | n | Mean | 1★ % | 5★ % ; 2021 | 531 | 4.842 | 1.13 | 91.15 ; 2022 | 16,820 | 4.864 | 1.11 | 91.70 ; 2023 | 12,136 | 4.810 | 1.61 | 89.03 ; 2024 | 13,144 | 4.788 | 2.11 | 88.63 ; 2025 | 15,816 | 4.684 | 4.00 | 85.65 ; 2026 (partial) | 11,594 | 4.645 | 4.00 | 83.15 ; 1★ 1.11% → 4.00%; 2021 (n=531) indicative only; 2026 partial through 7 Sep (n=11,594); 2021H1 (n=11) never used
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-133 — Family rates by half-year 2021H2–2026H2: billing, monetization, reliability, data-integrity, product-change, values, gamification, positive-core

- **Where:** §8.1 Family rates by half-year table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Half | n | Mean | 1★% | Billing | Monet. | Reliab. | Data-int. | Prod-chg | Values | Gamif. | Positive-core ; 2021H2 | 520 | 4.842 | 1.15 | 0.00 | 3.27 | 2.12 | 0.58 | 0.19 | 0.38 | 4.23 | 31.92 ; 2022H1 | 10,643 | 4.881 | 0.95 | 0.11 | 1.97 | 1.89 | 0.42 | 0.08 | 0.69 | 2.18 | 30.40 ; 2022H2 | 6,177 | 4.835 | 1.39 | 0.39 | 2.88 | 1.80 | 0.81 | 0.18 | 1.00 | 2.57 | 32.15 ; 2023H1 | 6,889 | 4.811 | 1.67 | 0.68 | 3.32 | 1.97 | 0.89 | 0.26 | 0.96 | 2.41 | 31.17 ; 2023H2 | 5,247 | 4.810 | 1.52 | 0.34 | 2.50 | 1.51 | 0.32 | 0.13 | 1.05 | 2.04 | 30.55 ; 2024H1 | 7,357 | 4.834 | 1.37 | 0.30 | 2.83 | 1.32 | 0.54 | 0.33 | 0.82 | 2.50 | 31.83 ; 2024H2 | 5,787 | 4.730 | 3.04 | 0.93 | 3.84 | 2.23 | 0.79 | 0.40 | 1.40 | 3.77 | 33.04 ; 2025H1 | 9,106 | 4.712 | 3.40 | 0.83 | 3.12 | 1.70 | 0.90 | 0.54 | 1.42 | 2.91 | 30.32 ; 2025H2 | 6,710 | 4.644 | 4.80 | 1.18 | 3.40 | 3.17 | 1.73 | 0.67 | 1.56 | 3.43 | 27.72 ; 2026H1 | 9,514 | 4.652 | 3.94 | 0.58 | 2.90 | 4.80 | 1.76 | 0.61 | 1.89 | 3.01 | 25.11 ; 2026H2 | 2,080 | 4.612 | 4.28 | 0.82 | 2.98 | 2.84 | 1.49 | 1.15 | 2.93 | 3.80 | 23.08
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-134 — 4 May 2022 crash-on-launch: a clean, closed incident mostly from first-time users who had just installed after seeing an ad — resolved within days and never recurred at that magnitude; proof the corpus detects such events at day resolution

- **Where:** §8.2 (a) 4 May 2022 — crash on launch
- **This app does:** launch crash after an update during an ad campaign
- **User reaction:** 1★-burst
- **Magnitude:** 128 reviews on 4 May vs ~90/day baseline; mean 3.72 vs 4.87 monthly; 34 one-star; 42 crash-tagged in one day; 3–6 May: 400 reviews, 46 crash-tagged, 34 one-star
- **Direction for us:** must-never-break · **Report confidence:** day-level · **Generalisable:** yes
- **Side effects:** a launch crash during an acquisition campaign hits first-time users who then never return
- **Review IDs:** `8636217694`, `8636379393`, `8636383341`, `8637099622`, `8637858391`
- **Canonical:** C031 Crashes / launch failures

### R10-135 — February 2026 'Wonderland' event crash: the Queen of Hearts event's 'grow potion' enlarged the pet and the app then crashed on load ('since my birb drank the giant potion the app crashes constantly. My birb is a giant and that seems to be too much to handle for my phone'); consequences: lost streaks of 47–600+ days, inability to run a backup because the app crashed before it could, paid subscriptions unusable for weeks — the severity multiplier is the streak mechanic: in 2022 a crash cost a session, in 2026 a crash costs a 600-day streak

- **Where:** §8.2 (b) February 2026 — the 'Wonderland' event crash; The severity multiplier here is the streak mechanic
- **This app does:** monthly event shipped a crash; streaks amplify the cost
- **User reaction:** 1★-burst
- **Magnitude:** 120 crash-tagged reviews in Feb 2026 vs 15 in Jan and 1–15 monthly norm 2023–24; 20 on 2 Feb, 11 on 3 Feb, 10 on 4 Feb, 9 on 6 Feb; monthly 1★ 4.85%; 67 reviews mention Wonderland at mean 3.40; lost streaks 47/70/142/300/400+/600+ days
- **Direction for us:** must-never-break · **Report confidence:** month/day-level · **Generalisable:** yes
- **Review IDs:** `13707568156`, `13711835469`, `13718339682`, `13743955362`, `13743566701`, `13725395996`, `13767997910`, `13711833057`, `13704583556`, `13707818559`, `13750797974`, `13737744762`
- **Canonical:** C031 Crashes / launch failures; C156 Content and event releases need a crash gate across device generations; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R10-136 — Reliability is the fastest-worsening dimension and monthly events are the named cause: the 2024 trough is real (the app got measurably more stable) and the 2026 spike is a regression; reviewers blame the monthly event cadence for shipping unstable code — 'Instead of doing things to improve the stability of the app, the finch team just keeps launching events that feels like they haven't tested anything'

- **Where:** §8.3 Trend 2 — Reliability is the fastest-worsening dimension, and events are the named cause
- **This app does:** monthly content events without a crash gate
- **User reaction:** 1★-burst
- **Magnitude:** reliability 1.89% (2022H1) → 4.80% (2026H1); crash 0.80% (2022) → 0.53% → 0.36% (2024) → 0.52% → 2.03% (2026); D-event-bug 0.07/0.05/0.08/0.06 → 0.32% (2026); June 2026: 14 event-bug + 42 data-loss reviews; D-streak-bug 0.01/0.01/0.17/0.39 → 0.74%
- **Direction for us:** must-never-break · **Report confidence:** trend · **Generalisable:** yes
- **Review IDs:** `14154438154`, `14224222208`, `14130446306`, `13977961683`, `14225501459`, `14083723197`, `13513453625`, `14224706579`
- **Canonical:** C031 Crashes / launch failures; C156 Content and event releases need a crash gate across device generations

### R10-137 — Data integrity broke down in H2 2025 and has not recovered; the problem statement changed from 'I deleted the app and lost everything' (user-initiated, 2022–23) to 'it told me my pet data got corrupted' (app-initiated, unprompted, from 2025) — a more serious failure because the user did nothing and the standard recovery path (a manual backup they may never have made) is unavailable

- **Where:** §8.4 Trend 3 — Data integrity broke down in H2 2025 and has not recovered; the problem statement changing to 'it told me my pet data got corrupted'
- **This app does:** app-initiated data corruption with no automatic backup
- **User reaction:** 1★-burst
- **Magnitude:** data-integrity 0.42% → … → 1.73% (2025H2) → 1.76% (2026H1) → 1.49% (2026H2); D-data-loss 0.46% (2022) → 0.46% → 0.56% → 1.08% (2025) → 1.47% (2026); monthly 22 (Jul 2025), 20 (Nov), 21 (Dec), 21 (Jan 2026), 28 (Feb), 42 (Jun 2026) vs 1–13 norm
- **Direction for us:** must-never-break · **Report confidence:** trend · **Generalisable:** yes
- **Review IDs:** `12595515502`, `12881347765`, `12925432031`, `13033899041`, `13683756253`, `13732070192`, `14145164297`, `14242421063`, `14373848758`, `14381587355`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R10-138 — Sixteen dated product changes 2022–2026 with themes, counts, means and review IDs: bird redesign, house leaked then withdrawn, paywall creep, beta sync lockout, Feb 2024 UI redesign, Tree Town non-user friends removed, streaks introduced, Journeys → Self-Care Areas, Guardian/AI ads controversy, hiring-ethics allegations, auto mood check-ins removed, exact-time goal scheduling removed, multi-add of goals removed, friends house view → tree only, Special Quests/milestones removed, colour palettes restricted

- **Where:** §8.5 Trend 4 — A five-year pattern of removing what people bought the app for table (verbatim)
- **This app does:** repeated removals
- **User reaction:** complaint
- **Magnitude:** Change | When (from review dates) | Theme | n | Mean | Evidence ; Bird redesign / new animations | Mar 2022 | — | ~15 | — | `8431474054`, `8433557491`, `8423825673`, `8428795694`, `8430950964`, `8602453752`, `8450607835` ; House/nest feature leaked then withdrawn | Jul–Aug 2022 | — | ~6 | — | `8927346914`, `8928490368`, `8931782968`, `8931967858`, `8934343143`, `8940560295` ; Paywall creep on previously-free items | Nov 2022 onward | `M-paywall` | 715 | 4.38 | `9337272695`, `9364974191`, `9386542212`, `9479031601`, `9771124109`, `9138911582` ; "Beta" account sync locks users out | Mar 2023 | `D-login-account` | ~12 in month | — | `9686931072`, `9699066698`, `9699388738`, `9712101197`, `9714150379`, `9723946025` ; Major UI redesign | Feb 2024 | `U-ui-change` | 24 in 2024 | 3.57 | `10906118540`, `10909346801`, `10917010011`, `10917852575`, `10919712068`, `10942641436`, `10946015163`, `10983032325`, `10996138525`, `10997614001`, `11001128510`, `11004907223`, `11031925790`, `11133639611`, `10938969089`, `10919643786`, `10920304817` ; Tree Town: non-user "friends" removed | May 2024 | — | ~5 | — | `11249547975`, `11250263856`, `11252722247`, `11254260811`, `11256055041` ; Streaks introduced | ~mid-2024 | `U-streak-pressure` | 24 (2024) | 3.96 | `11350735942`, `11396970425`, `11401527483`, `11548301986`, `11591661994`, `11688717901` ; Journeys → Self-Care Areas | Apr–May 2025 | `U-journeys-removed` | 49 total, 36 in 2025 | 2.76 | full list in §10.7 ; Guardian/AI ads controversy | Jan & May 2025 | `C-ai` | 62 (2025) | 4.35 | `12213043459`, `12219142669`, `12728967109`, `12686511039`, `13253481318` ; Hiring-ethics allegations | May 2025 | `C-hiring-ethics` | 8 (2025) | 1.67 | `12684393117`, `12686511039`, `12705023244`, `12709962941`, `12716829097` ; Auto mood check-ins + affirmations removed | Oct–Nov 2025 | `U-moodcheckin-removed` | 64 total | 3.77 | `13305396533`, `13306356665`, `13342650115`, `13344861750`, `13397787719`, `13410263343`, `13412273696`, `13414089882`, `13420079481`, `13425412408`, `13442043764`, `13475103522`, `13480507283` ; Exact-time goal scheduling removed | Nov 2025 – Jan 2026 | `U-timedgoals-removed` | 9 total | 3.11 | `13372364201`, `13414781377`, `13418954795`, `13523723252`, `13527307155`, `13535877318`, `13591367850`, `13712815939`, `13569702591` ; Multi-add of goals as a list removed | Dec 2025 – Feb 2026 | — | ~10 | — | `13501873014`, `13504992115`, `13595168865`, `13489561522`, `13662364288`, `13927178942`, `14218873851` ; Friends "house" view → tree only | Jun 2026 | — | ~8 | — | `14141621712`, `14143079962`, `14145326653`, `14146681247`, `14156325373`, `14076986749` ; Special Quests / milestones removed | Jun–Jul 2026 | `U-feature-removed-generic` | 37 in 2026 | 3.13 | `14213362996`, `14217885463`, `14221509378`, `14221781843`, `14241117951`, `14280429752`, `14299934656`, `14201555063` ; Colour palettes restricted | Aug–Sep 2026 | — | ~10 | — | `14374387869`, `14375332074`, `14378349434`, `14399992054`, `14452613945`, `14499796343`, `14501652328` ; generic feature-removal 0.02% (2022) → 0.03% → 0.12% → 0.11% → 0.32% (2026), 16×
- **Direction for us:** product-rule · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace

### R10-140 — A 'beta' account-sync rollout in March 2023 locked users out of their accounts

- **Where:** §8.5 'Beta' account sync locks users out (Mar 2023)
- **This app does:** beta sync shipped to all
- **User reaction:** 1★-burst
- **Magnitude:** ~12 D-login-account reviews in the month
- **Direction for us:** must-never-break · **Report confidence:** dated · **Generalisable:** yes
- **Review IDs:** `9686931072`, `9699066698`, `9699388738`, `9712101197`, `9714150379`, `9723946025`
- **Canonical:** C030 Sync must work — and prove it; C035 Account system from day one

### R10-141 — The February 2024 major UI redesign drew a backlash cluster

- **Where:** §8.5 Major UI redesign Feb 2024 (U-ui-change)
- **This app does:** redesign
- **User reaction:** complaint
- **Magnitude:** 24 U-ui-change reviews in 2024, mean 3.57; U-ui-change 94 total mean 3.53
- **Direction for us:** dont · **Report confidence:** dated · **Generalisable:** yes
- **Review IDs:** `10906118540`, `10909346801`, `10917010011`, `10983032325`, `11031925790`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R10-142 — Streaks were introduced around mid-2024 and immediately generated pressure complaints

- **Where:** §8.5 Streaks introduced ~mid-2024 row
- **This app does:** streaks added
- **User reaction:** complaint
- **Magnitude:** U-streak-pressure 24 in 2024, mean 3.96
- **Direction for us:** dont · **Report confidence:** dated · **Generalisable:** yes
- **Review IDs:** `11350735942`, `11396970425`, `11401527483`, `11548301986`, `11591661994`, `11688717901`
- **Canonical:** C024 Streaks / gamification; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R10-145 — Exact-time goal scheduling was removed (Nov 2025–Jan 2026) and multi-add of goals as a list was removed (Dec 2025–Feb 2026)

- **Where:** §8.5 Exact-time goal scheduling removed (Nov 2025 – Jan 2026); Multi-add of goals as a list removed
- **This app does:** removed timed goals and list multi-add
- **User reaction:** complaint
- **Magnitude:** U-timedgoals-removed 9 total mean 3.11; multi-add ~10 reviews
- **Direction for us:** product-rule · **Report confidence:** dated, small · **Generalisable:** yes
- **Review IDs:** `13372364201`, `13414781377`, `13523723252`, `13591367850`, `13501873014`, `13504992115`, `13595168865`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace

### R10-146 — Smaller dated changes each drew a cluster: bird redesign (Mar 2022), a house/nest feature leaked then withdrawn (Jul–Aug 2022), Tree Town non-user 'friends' removed (May 2024), friends' house view reduced to tree only (Jun 2026), Special Quests / milestones removed (Jun–Jul 2026), colour palettes restricted (Aug–Sep 2026)

- **Where:** §8.5 smaller dated changes: bird redesign Mar 2022; house leaked then withdrawn Jul–Aug 2022; Tree Town non-user friends removed May 2024; friends house view → tree only Jun 2026; Special Quests / milestones removed Jun–Jul 2026; Colour palettes restricted Aug–Sep 2026
- **This app does:** repeated removals and restrictions
- **User reaction:** complaint
- **Magnitude:** ~15, ~6, ~5, ~8, 37 (2026 U-feature-removed-generic), ~10
- **Direction for us:** product-rule · **Report confidence:** dated, small · **Generalisable:** app-specific
- **Review IDs:** `8431474054`, `8927346914`, `11249547975`, `14141621712`, `14213362996`, `14374387869`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace

### R10-147 — A Guardian/AI-ads controversy (Jan & May 2025) and hiring-ethics allegations about unpaid design work (May 2025) each produced dated clusters; hiring ethics is the lowest-mean content theme

- **Where:** §8.5 Guardian/AI ads controversy Jan & May 2025; Hiring-ethics allegations May 2025
- **This app does:** AI-generated ads; alleged unpaid design work in hiring
- **User reaction:** complaint
- **Magnitude:** C-ai 62 in 2025, mean 4.35 (156 total); C-hiring-ethics 8 in 2025, mean 1.67
- **Direction for us:** dont · **Report confidence:** dated · **Generalisable:** yes
- **Review IDs:** `12213043459`, `12219142669`, `12728967109`, `12686511039`, `13253481318`, `12684393117`, `12705023244`, `12709962941`, `12716829097`
- **Canonical:** — (nuance register)

### R10-148 — 2026: the product's values become a subject of the reviews — public-domain themes (Wizard of Oz, Alice in Wonderland) were tolerated with unease; the June 2026 DC/Supergirl month was not; objections repeat almost word for word: 'you are charging me and advertising to me' (a 575-day-streak multi-year subscriber), 'this month should have been Pride', 'criticism was suppressed', and the rollout was broken as well as unwanted; it continued with a July 1950s drive-in theme drawing a racial/heteronormative-representation critique and a September film tie-in; the people most offended are the people paying

- **Where:** §8.6 Trend 5 — 2026: the product's values become a subject of the reviews; June 2026 DC/Supergirl month; Why this matters more than 127 reviews should
- **This app does:** sponsored IP monthly events from June 2026
- **User reaction:** churn
- **Magnitude:** content/values family 0.69% (2022H1) → 1.42% (2025H1) → 1.89% (2026H1) → 2.93% (2026H2); C-brand-collab 2/5/3/10/107 by year, mean 3.09; 80 name Supergirl, 68 in June 2026, mean 2.99; June 2026: 14 event-bug, 42 data-loss, 104 one-star reviews; 8.0× over-represented among payers
- **Direction for us:** dont · **Report confidence:** trend · **Generalisable:** yes
- **Review IDs:** `14136600404`, `14117246332`, `14134408387`, `14154691963`, `14131417726`, `14259430571`, `14261659918`, `14497986029`, `14507114042`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C127 Never show ads to paying subscribers

### R10-149 — Monetisation complaints are flat-to-down while billing complaints rise 4–7×: users have largely stopped arguing about the price and started arguing about the transaction — a solvable problem, and a different problem from the one a pricing change would address

- **Where:** §8.7 Trend 6 — Monetisation complaints are flat-to-down; billing complaints are not
- **This app does:** price stable; billing mechanics failing
- **User reaction:** 1★-burst
- **Magnitude:** M-paywall 1.20% (2022) → 0.85% (2026) falling; M-price-high 0.57% → 1.22% (2024 peak) → 0.72% falling; M-should-be-free flat 0.25–0.41%; M-trial-no-reminder 0.07% → 0.38% (2025) → 0.28% up 4–5×; M-trial-charged 0.06% → 0.38% → 0.24% up 4–6×; M-refund-denied 0.04% → 0.21% → 0.19% up ~5×; M-not-free 0.04% → 0.28% up 7×
- **Direction for us:** must-never-break · **Report confidence:** trend · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C064 Price level — where 'fair' turns into 'too expensive'

### R10-150 — The benefit signal is thinning: the therapeutic tool-set is mentioned less and less as it moves further behind menus and paywalls, while the task-tracking and collection layers stay prominent — precisely what hundreds of long-form reviewers assert has happened

- **Where:** §8.8 Trend 7 — The benefit signal is thinning; Read together with §8.5, this is one story
- **This app does:** tools buried; collection game foregrounded
- **User reaction:** complaint
- **Magnitude:** P-mental-health 15.44% (2021) → 14.02 → 13.55 → 11.78 → 10.67 → 9.30% (2026); P-tools 15.63% → 7.98 → 5.24 → 5.57 → 4.08 → 2.65%; P-companion 2.64% → 2.57% → 2.00% → 1.71% → 1.52% → 1.32%; positive-core 30.40% (2022H1) → 23.08% (2026H2); P-motivation flat 15.2% → 13.0%; P-social 3.03% → 3.09%
- **Direction for us:** product-rule · **Report confidence:** trend · **Generalisable:** yes
- **Review IDs:** `13828330334`, `14268143502`, `14425330451`, `13456598701`, `14420113173`, `13688122090`, `12551489443`, `10983032325`
- **Canonical:** C166 Keep the therapeutic core in front of the game layer

## Positioning

### R10-001 — Finch: Self-Care Pet (App Store ID 1528595748) is a self-care habit/journal app built around emotional attachment to one virtual bird pet, monetised by a 'Finch Plus' subscription with a free trial and a Guardian sponsored-membership programme; by far the largest corpus in the set — 70,041 written reviews at mean 4.7631, 87.88% five-star

- **Where:** header lines 1-8
- **This app does:** developer Finch Care Public Benefit Corporation; bundle com.finch.finch; store rank 10 in this set; 121 storefronts; 13 May 2021 → 7 Sep 2026 (5 yr 4 mo); free download with Finch Plus subscription
- **User reaction:** praise
- **Magnitude:** 70,041 reviews; 5★ 61,550 (87.88%) · 4★ 4,655 (6.65%) · 3★ 1,333 (1.90%) · 2★ 742 (1.06%) · 1★ 1,761 (2.51%); mean 4.7631; 100% coverage, zero duplicate IDs, exact manifest reconciliation
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-017 — The product loop: hatch a bird, name it, choose its pronouns and colours, dress it; completing real-world goals generates energy that sends the bird on a multi-hour adventure, it returns with a discovery and item and asks a two-option question that shapes its personality; goals also earn rainbow stones spent in rotating shops on clothing and furniture

- **Where:** §2.1 What the product is, reconstructed from what users describe
- **This app does:** virtual-pet self-care app; adventures, energy, rainbow stones, rotating shops
- **User reaction:** praise
- **Magnitude:** report gives none on this paragraph
- **Direction for us:** research · **Report confidence:** descriptive · **Generalisable:** app-specific
- **Canonical:** C117 Mascot / companion character

### R10-179 — The tone and visual style read as childish or condescending to some adults — a complaint that appears only as a per-country row, highest in Australia, the most ADHD-identified market

- **Where:** §7.2 U-childish row; §10.2 U-childish definition
- **This app does:** cute, pastel, pet-first design
- **User reaction:** complaint
- **Magnitude:** U-childish us 0.75% / gb 0.75% / ca 0.84% / au 1.06%
- **Direction for us:** research · **Report confidence:** weak (country table only) · **Generalisable:** yes
- **Canonical:** C057 Offer a non-pastel / premium design option

## Anti-patterns

### R10-055 — The data-loss compensation is described as insulting relative to the loss: the standard remedy is 5,000 rainbow stones, and reviewers itemise 20,000–200,000 stones lost, multi-year streaks and event-exclusive items that cannot be re-earned (~10,000 items lost, 30 offered back)

- **Where:** §4.3 The compensation is described as insulting relative to the loss
- **This app does:** flat 5,000-stone compensation regardless of loss
- **User reaction:** 1★-burst
- **Magnitude:** losses itemised: 20,000 / 30,000+ / 35,000 / 40,000 / 200,000 stones; ~10,000 items lost vs 30 returned
- **Direction for us:** dont · **Report confidence:** reviewer-itemised · **Generalisable:** yes
- **Review IDs:** `12925432031`, `13033899041`, `10411200153`, `13923371591`, `13434160590`, `13787017447`
- **Canonical:** C154 Compensation for lost data must match the loss — never a flat token

### R10-064 — Overwhelm is the largest single UX complaint: an app sold to people with executive-function difficulty has accumulated so many interstitials that reaching the checklist is itself an executive-function task — 'I don't wanna be required to go through 800 different screens before I can get to the checklist'; one review lists six sequential screens before the goal list

- **Where:** §4.5 U-overwhelm is the largest single UX complaint in the corpus
- **This app does:** interstitial-heavy path to the core checklist
- **User reaction:** complaint
- **Magnitude:** U-overwhelm 1,046 (1.493%, MEANINGFUL) mean 4.50; U-too-many-clicks 84 (0.120%) mean 3.49
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12951667597`, `12095378263`, `12823843140`, `13661516668`, `14168702702`, `12658682757`, `11766242787`, `9330701695`, `10529428569`, `13237881486`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C159 Launch-to-core-action path with no interstitials

### R10-065 — Streaks are a net-negative mechanic in the written record — design harm: the streak reintroduces exactly the guilt the app was praised for removing, and repairing it costs 1,000 gems ('I dread going into finch because of this new feature')

- **Where:** §4.5 Streaks are a net-negative mechanic in the written record — design harm
- **This app does:** streaks added ~mid-2024; paid/gem-cost streak repair
- **User reaction:** complaint
- **Magnitude:** U-streak-pressure 96 (0.137%) mean 3.96; 5 reviews in 2022–23 combined, 24/41/23 in 2024/2025/2026
- **Direction for us:** dont · **Report confidence:** weak, rising · **Generalisable:** yes
- **Review IDs:** `11591661994`, `11548301986`, `11688717901`, `12179584982`, `12488852403`, `14075929805`, `12176073009`, `13003497273`, `14513803336`, `11900885112`
- **Canonical:** C024 Streaks / gamification; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R10-067 — The in-game economy is a friction generator: goals yield 3–12 stones while shop items cost 500–900, the shop rotates randomly with a paid re-roll, and the item you want never appears (one review does the arithmetic: 50 tasks for one 250-stone item)

- **Where:** §4.5 The economy is a friction generator (U-economy)
- **This app does:** stone scarcity; random shop; paid re-roll
- **User reaction:** complaint
- **Magnitude:** U-economy 196 (0.280%, WEAK) mean 4.10
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13291611680`, `12199427863`, `14437464706`, `12896721169`, `14277989798`, `13512928462`, `13899596152`, `12783240976`, `13528610213`, `14415321702`
- **Canonical:** C164 A random-rotation shop with paid re-rolls and unpurchasable catalogue items is a friction generator

### R10-069 — Engagement decays into repetition; notification volume is a complaint; monthly-event micropets are seen as low-quality 'blobs' or duplicates; event/FOMO pressure and non-recoverable rewards; the adventure cooldown is itself a complaint

- **Where:** §4.5 U-boring, U-notif-spam, U-blob-micropets, U-fomo-events rows; §2.1 adventures cooldown
- **This app does:** content treadmill with FOMO
- **User reaction:** complaint
- **Magnitude:** U-boring 518 (0.740%, EMERGING) mean 4.39; U-notif-spam 77 (0.110%) mean 3.65; U-blob-micropets 52 mean 3.81; U-fomo-events 40 mean 3.52; adventures 2,290 mentions (3.27%)
- **Direction for us:** dont · **Report confidence:** emerging / weak · **Generalisable:** yes
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C168 Monthly seasonal event with a paid reward track

### R10-087 — The community-moderation stream is a persistent reputational drag: the Facebook group, Discord and subreddit are described as heavily moderated and hostile to criticism, with a 2022–23 cluster around a Harry Potter / JK Rowling content decision producing accusations in both directions, and an anti-Black moderation allegation; paying users are 7× over-represented

- **Where:** §4.7 The community-moderation stream is a persistent, dated reputational drag
- **This app does:** official community channels with heavy moderation
- **User reaction:** complaint
- **Magnitude:** C-community-mod 211 (0.301%, WEAK) mean 3.93; 29 of 211 paid (7.0× over-representation)
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `8779142067`, `8786543457`, `8809056328`, `9344350321`, `9696554036`, `9954956356`, `10427260247`, `12039960855`, `8714915960`, `8996753611`, `12023264733`, `12205292045`, `13454522816`, `14372739263`, `14201570708`, `14260047035`, `14154691963`
- **Canonical:** C165 Official community channels must tolerate criticism

### R10-089 — Physical merch orders arrive late, wrong or not at all, with no support response

- **Where:** §4.8 Merch fulfilment
- **This app does:** sells plushies/pins/stickers
- **User reaction:** complaint
- **Magnitude:** merch 134 mentions (0.19%); 6 cited fulfilment complaints
- **Direction for us:** dont · **Report confidence:** small · **Generalisable:** app-specific
- **Review IDs:** `12100759969`, `12849337898`, `14135314999`, `14172035895`, `14444272993`, `13529294099`
- **Canonical:** — (nuance register)

### R10-090 — Update churn: near-daily updates, large downloads, and monthly events that require an update to unlock

- **Where:** §4.8 Update churn
- **This app does:** frequent forced updates
- **User reaction:** complaint
- **Magnitude:** 7 cited reviews
- **Direction for us:** dont · **Report confidence:** small · **Generalisable:** yes
- **Review IDs:** `11198114825`, `11510475741`, `12613070528`, `13513453625`, `14083723197`, `14381189233`, `14382450807`
- **Canonical:** C175 Updates must not break function or wipe progress

### R10-091 — Users are made to change their pet's colour at a growth milestone with no way back

- **Where:** §4.8 Forced pet ageing / colour change (U-forced-color)
- **This app does:** forced colour change at growth stage
- **User reaction:** complaint
- **Magnitude:** 22 reviews mean 3.59
- **Direction for us:** dont · **Report confidence:** small · **Generalisable:** app-specific
- **Review IDs:** `8431474054`, `9348919175`, `10666674801`, `11613982899`, `12602358290`, `12671877044`, `14168221622`, `14477855392`
- **Canonical:** — (nuance register)

### R10-092 — The pet's randomised likes/dislikes cause distress — the companion 'hates everything I love'

- **Where:** §4.8 The pet's randomised likes/dislikes (U-likes-dislikes)
- **This app does:** random personality traits
- **User reaction:** complaint
- **Magnitude:** 28 reviews mean 3.79
- **Direction for us:** dont · **Report confidence:** small · **Generalisable:** app-specific
- **Review IDs:** `12267413829`, `13650646547`, `11882249586`, `12802871170`, `10868115871`, `14114392965`, `13445215677`
- **Canonical:** — (nuance register)

### R10-143 — The Journeys removal (Apr–May 2025) is the sharpest single case: Journeys rewarded cumulative, non-consecutive progress; the Self-Care Areas replacement rewards consecutive streaks; the app's audience is people whose progress is by definition not consecutive — 'They removed the component that gave users a sense of levelling… and replaced it with daily streaks'; 'as someone with severe chronic illness, the Journeys feature was incredible… I've regretfully canceled my subscription'; a clinician: 'only 1 of 2 apps I actually recommend to my clients — all adults with ADHD'

- **Where:** §8.5 The Journeys removal is the sharpest single case
- **This app does:** replaced cumulative-progress reward with consecutive-streak reward
- **User reaction:** churn
- **Magnitude:** U-journeys-removed 49 total, 36 in 2025, mean 2.76 (lowest product-change theme), 21 of 49 one-star; Journeys 1,006 vocabulary mentions
- **Direction for us:** product-rule · **Report confidence:** dated, sharp · **Generalisable:** yes
- **Review IDs:** `12557701970`, `12674347241`, `12682396517`, `12778041860`, `12655037808`, `14299934656`, `12596071096`, `12559327482`, `12547227541`, `13365769674`, `13420079481`
- **Canonical:** C047 Cumulative totals and total-days counter; C155 Never remove a feature people bought the app for — add alongside, do not replace; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R10-144 — The automatic mood check-in removal (Oct–Nov 2025) is the second sharpest, and its argument is about accessibility rather than reward: an automatic prompt is a memory aid, and moving it behind a button destroys the dataset for exactly the users who need it — 'my mood data is now almost empty for the last three months even though I do the emotion exercise multiple times a day'

- **Where:** §8.5 The mood check-in removal is the second sharpest
- **This app does:** auto mood prompt moved behind a button
- **User reaction:** complaint
- **Magnitude:** U-moodcheckin-removed 64 total, mean 3.77, 49 in 2025H2–2026; mood tracking 953 vocabulary mentions
- **Direction for us:** product-rule · **Report confidence:** dated · **Generalisable:** yes
- **Review IDs:** `13860027170`, `13305396533`, `13425412408`, `13414089882`, `13855090245`, `14256888213`, `14352654672`, `14129375665`, `14114531927`
- **Canonical:** C049 Mood tracker; C155 Never remove a feature people bought the app for — add alongside, do not replace

## Things not to do

### R10-008 — In June 2026 the monthly event became a paid DC/Supergirl movie tie-in and the reaction is the clearest values-breach signal in five years: subscribers say they are now paying to be advertised to, in a mental-health app, in a month they expected to be Pride — this theme did not meaningfully exist before 2025; 857 reviewers had praised Finch specifically for being ad-free

- **Where:** ⚠️ 5. In June 2026 the monthly event became a paid movie tie-in; EXECUTIVE SUMMARY #6 Sponsored IP events broke a stated brand promise; §8.6
- **This app does:** sponsored IP monthly event (June 2026)
- **User reaction:** complaint
- **Magnitude:** C-brand-collab 127 reviews mean 3.09; 107 (84%) in 2026, 68 in June 2026 alone; 2 in 2022, 5 in 2023, 3 in 2024; 8.0× over-represented among paid-evidence reviewers; ad-free praise 857 (1.22%)
- **Direction for us:** dont · **Report confidence:** high-priority (headline) · **Generalisable:** yes
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C127 Never show ads to paying subscribers

### R10-026 — A 'one-time offer' discount screen is presented during onboarding, before the app has been used, stating the discount is lost forever if dismissed — small by volume but qualitatively vivid

- **Where:** §2.2 'one-time offer' discount screen during onboarding, before the app has been used (M-fomo-offer)
- **This app does:** scarcity-framed onboarding discount
- **User reaction:** complaint
- **Magnitude:** M-fomo-offer 10 reviews, mean 2.90
- **Direction for us:** dont · **Report confidence:** weak, vivid · **Generalisable:** yes
- **Review IDs:** `10582541234`, `11351698438`, `11950784924`, `13853322399`, `13018762164`
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C137 Show the paywall at the moment of need, not on app open

### R10-084 — The pronoun-selection screen is a measurable but small acquisition leak: users delete the app at that step — reported only because the intervention is cheap and non-editorial (a skip option) and the same intervention serves the opposite constituency

- **Where:** §4.7 The pronoun screen is a measurable acquisition leak, and it is small
- **This app does:** mandatory pet-pronoun question at onboarding
- **User reaction:** churn
- **Magnitude:** C-pronouns-objection 54 (0.077%) mean 3.24; peaked 2022 (1.19% of that year's pronoun mentions), flat since; C-pronouns all 428 (0.611%) mean 4.42
- **Direction for us:** do · **Report confidence:** ignore-band volume · **Generalisable:** yes
- **Review IDs:** `8580844131`, `8474636545`, `9487215463`, `9891211417`, `11733826774`, `12309043500`, `13004599450`, `13000860998`, `13283702073`, `13678224974`, `13680058420`, `14012193700`, `14416401473`, `14488479244`
- **Canonical:** C161 Values and identity screens are optional in both directions

### R10-166 — Stop spending the ad-free reputation: if brand partnerships continue, make them opt-in for subscribers

- **Where:** §9.4 Stop spending the ad-free reputation
- **This app does:** sponsored IP events shown to payers
- **User reaction:** churn
- **Magnitude:** 857 name ad-free as trust reason; brand-collab 8.0× among payers, mean 3.09
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C127 Never show ads to paying subscribers

### R10-171 — Do not raise prices to solve the paid-satisfaction problem, and do not cut them either — price complaints are falling while billing complaints rise; the problem is the transaction, not the number

- **Where:** §9.4 Do not raise prices to solve the paid-satisfaction problem, and do not cut them either
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** price complaints falling; billing up 4–6×
- **Direction for us:** dont · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

## Things to do

### R10-016 — The prioritised ask: make the trial reminder real and provable; ship automatic cloud backup on by default; stop shipping monthly events without a crash gate; stop removing features people bought the app for; and decide explicitly whether the product is a self-care tool with a game attached or a collection game with self-care attached — because 2,000+ reviewers say it has silently become the second

- **Where:** EXECUTIVE SUMMARY The prioritised ask
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 2,000+ reviewers in the gamification-harm family
- **Direction for us:** do · **Report confidence:** recommendation · **Generalisable:** yes
- **Canonical:** C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date; C153 Automatic cloud backup on by default — never manual opt-in; C155 Never remove a feature people bought the app for — add alongside, do not replace; C156 Content and event releases need a crash gate across device generations; C166 Keep the therapeutic core in front of the game layer

### R10-155 — F4: fix the widget — low severity per review, the single longest-running unresolved complaint in the corpus; fixing it is cheap goodwill

- **Where:** §9.1 F4. Fix the widget
- **This app does:** widget broken 5 years
- **User reaction:** complaint
- **Magnitude:** 117 reviews over five years, mean 3.91, still open in 2026
- **Direction for us:** do · **Report confidence:** recommendation (fix) · **Generalisable:** yes
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app

### R10-172 — Experiment 1: blocking in-app trial reminder vs push-only; measure billing-dispute review rate and refund requests — expected to move the single worst-rated family

- **Where:** §9.5 #1 Blocking in-app trial reminder vs push-only; part 9 #1
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** billing family mean 1.97
- **Direction for us:** do · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date

### R10-173 — Experiment 2: 'gentle mode' toggle (streak hidden, no repair prompts, no event countdown); measure retention among self-identified ADHD/chronic-illness users against the non-punitive praise baseline

- **Where:** §9.5 #2 'Gentle mode' toggle; part 9 #2
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 476-review non-punitive baseline
- **Direction for us:** do · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R10-174 — Experiment 3: automatic backup default-on with a one-line disclosure; measure data-loss review rate against the 2025H2–2026H1 baseline

- **Where:** §9.5 #3 Automatic backup default-on; part 9 #3
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** baseline 1.7–1.8%
- **Direction for us:** do · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** C153 Automatic cloud backup on by default — never manual opt-in

### R10-175 — Experiment 4: restore the home-screen First Aid button; measure P-tools mention rate

- **Where:** §9.5 #4 Home-screen First Aid button restored; part 9 #4
- **This app does:** First Aid moved off home screen
- **User reaction:** none
- **Magnitude:** P-tools 15.63% → 2.65%
- **Direction for us:** do · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** C166 Keep the therapeutic core in front of the game layer

### R10-176 — Experiment 5: German + Spanish localisation as a paired test; measure paid-evidence rate in de/es/mx

- **Where:** §9.5 #5 German + Spanish localisation as a paired test; part 9 #5
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** current paid-evidence de 1.29% / es 0.66% / mx 0.68%
- **Direction for us:** do · **Report confidence:** experiment · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue

### R10-177 — Experiment 6: catalogue-direct purchase (buy any owned-catalogue item at a premium) vs random rotation; measure U-economy complaint rate and Plus conversion among high-balance users

- **Where:** §9.5 #6 Catalogue-direct purchase vs random rotation; part 9 #6
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** U-economy 196
- **Direction for us:** do · **Report confidence:** experiment · **Generalisable:** app-specific
- **Canonical:** C164 A random-rotation shop with paid re-rolls and unpurchasable catalogue items is a friction generator

## Contradictions

### R10-013 — Gamification is now producing measurable harm alongside its benefit: streaks (added ~mid-2024) generate their own defect stream and their own pressure stream — the most common single sentence in the family is that the app now punishes a missed day in a product bought specifically because the user misses days

- **Where:** EXECUTIVE SUMMARY #7 Gamification is now producing measurable harm alongside its benefit; §4.5
- **This app does:** streaks added mid-2024; streak repair monetised
- **User reaction:** complaint
- **Magnitude:** gamification-harm family 1,948 (2.78%, MEANINGFUL); D-streak-bug 171 mean 3.26, 0.01% (2023) → 0.74% (2026); U-streak-pressure 96 mean 3.96
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C024 Streaks / gamification; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

## Data caveats and method

### R10-002 — Method: denominator 70,041, non-exclusive themes, standard signal bands; corpus is 87.9% five-star so every complaint rate is compressed (a 0.8% theme is 560 reviews and can be 8–9% of the 1★ band) — segment rates are always labelled with their own denominator; NO external sources used, prices/features/release timings are [corpus-derived]; three-layer method: 88-theme compound regex rules over all 70,041 records + complete human reading of all 3,836 ≤3★ reviews + ~1,200 4★ reviews + two validation passes (~85–92% precision on complaint themes, recall unmeasured, so ALL complaint counts are lower bounds); automated theme detection is English-only so every theme rate for 21 non-English storefronts (de, fr, es, mx, br, ru, cn, jp, tr, it, pt, pl, cz, dk, se, no, fi, nl, at, ch, be — 3,840 reviews, 5.48%) is a floor; 40.92% of reviews (28,662) matched no theme (median body 79 chars, 89.5% five-star, mean 4.806; tag rate 81.8% for 200+ char bodies, 68.2% for ≤3★); votes sparse (2,605 reviews, 3.72%); date-of-writing not date-of-experience (977 edits); paid cohort (1,381) is a conservative floor biased toward billing grievances; no conversion/retention/revenue, no causal claims, no public-rating-vs-written gap computable; deduplication not applied (120 groups / 284 records of identical generic praise kept)

- **Where:** How to read this; §1.1 Files and schema; §1.2 Coverage and reconciliation; §1.3 Processing method; §1.4 What is not claimed; §1.5 Known limitations and biases; §10.1 counting rules
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 70,041 / 70,041 parsed; 121 by_country files exact; ratings 1:1761 2:742 3:1333 4:4655 5:61550; mean 4.7631 matches manifest; 0 empty bodies/titles; is_edited 977 (1.39%); signal bands <0.1% ignore · 0.1–0.5% weak · 0.5–1% emerging · 1–3% meaningful · 3–5% very strong · >5% high-priority; validation: first classification pass had false positives (M-trial-no-reminder matched 'remind myself', D-support matched 'part of my support system', M-should-be-free matched praise for the free tier) and was rewritten with negative-context exclusions; recall calibrated against keyword probes (1,036 mention 'journey', 80 ≤3★, rule captures 49)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R10-003 — Files, schema and reconciliation tables

- **Where:** §1.1 Files and schema table (verbatim); §1.2 Coverage and reconciliation table (verbatim)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** File | Records | Used for ; `reviews.jsonl` | 70,041 | Primary corpus. Every record read and classified. ; `by_country/*.jsonl` | 121 files, 70,041 records | Reconciliation only. ; `manifest.json` | — | App identity, extraction date, expected totals. ;; Check | Result ; Records parsed from `reviews.jsonl` | 70,041 / 70,041 (100%) ; JSON parse failures | 0 ; Unique `review_id` values | 70,041 (zero duplicates) ; Sum of `by_country/*.jsonl` | 70,041 — exact match, 121 files ; Per-country counts vs. `manifest.json` | All 121 match exactly, zero discrepancies ; Rating distribution vs. `manifest.json` | Exact match (1:1761, 2:742, 3:1333, 4:4655, 5:61550) ; Mean rating vs. `manifest.json` (4.763) | 4.7631 — match ; Empty `body` fields | 0 ; Empty `title` fields | 0 ; Records excluded from analysis | 0
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-043 — Nine complaint families ranked by volume: monetization-any, gamification-harm, reliability, accessibility, content-values, platform-gaps, data-integrity, billing-dispute, product-change

- **Where:** §4.1 Complaint families, ranked table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Family | n | % of corpus | Signal | Mean | 1★ share of family ; `FAM-monetization-any` | 2,045 | 2.92% | MEANINGFUL | 3.73 | 413 (20.2%) ; `FAM-gamification-harm` | 1,948 | 2.78% | MEANINGFUL | 4.38 | 103 (5.3%) ; `FAM-reliability` | 1,648 | 2.35% | MEANINGFUL | 3.32 | 369 (22.4%) ; `FAM-accessibility` | 1,150 | 1.64% | MEANINGFUL | 4.47 | 44 (3.8%) ; `FAM-content-values` | 874 | 1.25% | MEANINGFUL | 3.93 | 133 (15.2%) ; `FAM-platform-gaps` | 765 | 1.09% | MEANINGFUL | 4.63 | 31 (4.1%) ; `FAM-data-integrity` | 658 | 0.94% | EMERGING | 3.14 | 181 (27.5%) ; `FAM-billing-dispute` | 404 | 0.58% | EMERGING | 1.97 | 244 (60.4%) ; `FAM-product-change` | 269 | 0.38% | WEAK | 3.43 | 51 (19.0%)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-045 — Billing-dispute cluster: six themes with n, %, signal, mean, 1★ and paid-evidence counts

- **Where:** §4.2 Monetization — the billing-dispute cluster table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % | Signal | Mean | 1★ | Paid-evidence n ; `M-trial-no-reminder` | 160 | 0.228% | WEAK | 1.98 | 92 | 89 ; `M-trial-charged` | 149 | 0.213% | WEAK | 1.79 | 99 | 96 ; `M-refund-denied` | 98 | 0.140% | WEAK | 1.48 | 71 | 91 ; `M-cancel-hard` | 66 | 0.094% | Ignore-by-default (volume) | 2.18 | 36 | 30 ; `M-unauthorized` | 51 | 0.073% | Ignore-by-default (volume) | 2.12 | 31 | 24 ; `M-double-charge` | 10 | 0.014% | Ignore-by-default (volume) | 1.60 | 5 | 8 ; Family (deduplicated union) | 404 | 0.577% | EMERGING | 1.97 | 244 | 241
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-046 — Four of the six billing themes sit below the 0.1% 'ignore by default' line on volume alone and are reported anyway under the standard's financial-integrity carve-out; as segment rates the family is 13.86% of all 1★ and 17.45% of all paid-evidence reviews

- **Where:** §4.2 Four of these six sit below the 0.1% line on volume alone — They are reported anyway under the financial-integrity carve-out; Segment rates
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** family 404 (0.577%, EMERGING) mean 1.97; 244/1,761 one-star (13.86%); 241/1,381 paid (17.45%)
- **Direction for us:** must-never-break · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right

### R10-052 — Reliability and data-integrity themes: thirteen defect themes with n, %, signal, mean, 1★

- **Where:** §4.3 Reliability and data integrity table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % | Signal | Mean | 1★ ; `D-crash` | 568 | 0.811% | EMERGING | 3.07 | 151 ; `D-data-loss` | 551 | 0.787% | EMERGING | 3.10 | 160 ; `D-support` | 185 | 0.264% | WEAK | 3.10 | 71 ; `D-streak-bug` | 171 | 0.244% | WEAK | 3.26 | 45 ; `D-lag-perf` | 149 | 0.213% | WEAK | 3.62 | 18 ; `D-widget-bug` | 117 | 0.167% | WEAK | 3.91 | 6 ; `D-login-account` | 90 | 0.128% | WEAK | 2.89 | 27 ; `D-notif-broken` | 86 | 0.123% | WEAK | 3.47 | 20 ; `D-goals-bug` | 83 | 0.119% | WEAK | 3.81 | 10 ; `D-event-bug` | 73 | 0.104% | WEAK | 3.23 | 15 ; `D-no-backup` | 37 | 0.053% | Ignore-by-default | 3.08 | 11 ; `D-sync-devices` | 31 | 0.044% | Ignore-by-default | 4.16 | 0 ; `D-sound-bug` | 19 | 0.027% | Ignore-by-default | 3.47 | 2 ; Reliability family (union) | 1,648 | 2.354% | MEANINGFUL | 3.32 | 369 ; segment: reliability family 20.95% of all 1★ (369/1,761) and 21.03% of all 2★ (156/742)
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-063 — Gamification-harm themes: overwhelm, boring, economy, just-checklist, streak pressure, too many clicks, notification spam, blob micropets, FOMO events

- **Where:** §4.5 Gamification harm table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % | Signal | Mean ; `U-overwhelm` | 1,046 | 1.493% | MEANINGFUL | 4.50 ; `U-boring` | 518 | 0.740% | EMERGING | 4.39 ; `U-economy` | 196 | 0.280% | WEAK | 4.10 ; `U-just-checklist` | 111 | 0.158% | WEAK | 4.13 ; `U-streak-pressure` | 96 | 0.137% | WEAK | 3.96 ; `U-too-many-clicks` | 84 | 0.120% | WEAK | 3.49 ; `U-notif-spam` | 77 | 0.110% | WEAK | 3.65 ; `U-blob-micropets` | 52 | 0.074% | Ignore-by-default | 3.81 ; `U-fomo-events` | 40 | 0.057% | Ignore-by-default | 3.52 ; Family (union) | 1,948 | 2.781% | MEANINGFUL | 4.38
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-082 — Content, values and trust themes: age rating, pronouns, safety, diagnosis quiz, community moderation, AI, brand collab, religion, LGBT-more, LGBT-objection, privacy, pronouns-objection, national flag, review manipulation, hiring ethics

- **Where:** §4.7 Content, values and trust table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % | Signal | Mean | Direction ; `C-age-rating` | 920 | 1.314% | MEANINGFUL | 4.74 | Mostly parents; mixed ; `C-pronouns` (all mentions) | 428 | 0.611% | EMERGING | 4.42 | Both directions ; `C-safety` | 335 | 0.478% | WEAK | 4.55 | Crisis/grief/ED context ; `C-diagnosis-quiz` | 221 | 0.316% | WEAK | 4.86 | Mostly neutral/positive ; `C-community-mod` | 211 | 0.301% | WEAK | 3.93 | FB/Discord/Reddit conduct ; `C-ai` | 156 | 0.223% | WEAK | 4.35 | Mostly 2025–26 ; `C-brand-collab` | 127 | 0.181% | WEAK | 3.09 | 84% in 2026 ; `C-religion` | 116 | 0.166% | WEAK | 4.14 | Requests + objections ; `C-lgbt-more` | 111 | 0.158% | WEAK | 4.57 | Wants *more* representation ; `C-lgbt-objection` | 109 | 0.156% | WEAK | 3.50 | Wants less / opt-out ; `C-privacy` | 101 | 0.144% | WEAK | 3.96 | Contacts, phone number, tracking ; `C-pronouns-objection` | 54 | 0.077% | Ignore-by-default | 3.24 | Deletes at the pronoun screen ; `C-national-flag` | 16 | 0.023% | Ignore-by-default | 3.00 | ; `C-review-manip` | 16 | 0.023% | Ignore-by-default | 4.25 | Allegation only ; `C-hiring-ethics` | 9 | 0.013% | Ignore-by-default | 1.67 | Concentrated May 2025
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-088 — Smaller trust themes: use of AI in ads/support/content (mostly 2025–26), privacy (contacts, phone-number-only sign-up, tracking), review-manipulation allegations, and a May 2025 cluster alleging unpaid design work in hiring at the lowest mean of any content theme

- **Where:** §4.7 C-ai, C-privacy, C-review-manip, C-hiring-ethics rows
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** C-ai 156 (0.223%) mean 4.35; C-privacy 101 (0.144%) mean 3.96; C-review-manip 16 mean 4.25; C-hiring-ethics 9 mean 1.67 (May 2025)
- **Direction for us:** dont · **Report confidence:** weak · **Generalisable:** yes
- **Canonical:** C085 Address tracking / privacy visibly

### R10-093 — Per-band theme tables for all five star bands (band denominators)

- **Where:** Part 5 5★ band table (verbatim); 4★ band table (verbatim); 3★ band table (verbatim); 2★ band table (verbatim); 1★ band table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★: Theme | n in band | % of 5★ band ; `P-motivation` | 10,318 | 16.76% ; `P-cute-design` | 9,409 | 15.29% ; `P-recommend` | 9,210 | 14.96% ; `P-mental-health` | 7,870 | 12.79% ; `P-adhd-nd` | 4,414 | 7.17% ; `P-tools` | 3,339 | 5.42% ; `P-life-changed` | 2,627 | 4.27% ; `P-social` | 1,825 | 2.97% ;; 4★: Theme | n in band | % of 4★ band ; `P-motivation` | 604 | 12.98% ; `P-cute-design` | 533 | 11.45% ; `P-adhd-nd` | 484 | 10.40% ; `U-more-pet` | 174 | 3.74% ; `U-overwhelm` | 142 | 3.05% ; `M-paywall` | 141 | 3.03% ; `M-price-high` | 101 | 2.17% ; `D-crash` | 96 | 2.06% ; `U-boring` | 94 | 2.02% ; `D-data-loss` | 78 | 1.68% ; `U-localization` | 76 | 1.63% ; `U-accessibility` | 68 | 1.46% ; `U-economy` | 61 | 1.31% ; `D-widget-bug` | 40 | 0.86% ;; 3★: Theme | n in band | % of 3★ band ; `P-motivation` | 123 | 9.23% ; `P-adhd-nd` | 106 | 7.95% ; `D-crash` | 94 | 7.05% ; `D-data-loss` | 89 | 6.68% ; `U-overwhelm` | 58 | 4.35% ; `M-paywall` | 36 | 2.70% ; `M-price-high` | 36 | 2.70% ; `U-localization` | 34 | 2.55% ;; 2★: Theme | n in band | % of 2★ band ; `D-crash` | 70 | 9.43% ; `D-data-loss` | 51 | 6.87% ; `U-overwhelm` | 39 | 5.26% ; `M-trial-no-reminder` | 29 | 3.91% ; `M-price-high` | 28 | 3.77% ; `M-paywall` | 25 | 3.37% ; `P-adhd-nd` | 61 | 8.22% ; `P-motivation` | 58 | 7.82% ;; 1★: Theme | n in band | % of 1★ band | Global n ; `D-data-loss` | 160 | 9.09% | 551 ; `D-crash` | 151 | 8.57% | 568 ; `M-trial-charged` | 99 | 5.62% | 149 ; `M-trial-no-reminder` | 92 | 5.22% | 160 ; `P-adhd-nd` | 92 | 5.22% | 5,157 ; `P-mental-health` | 86 | 4.88% | 8,398 ; `P-recommend` | 78 | 4.43% | 9,765 ; `M-refund-denied` | 71 | 4.03% | 98 ; `D-support` | 71 | 4.03% | 185 ; `M-not-free` | 68 | 3.86% | 126 ; `M-price-high` | 62 | 3.52% | 596 ; `D-streak-bug` | 45 | 2.56% | 171 ; `M-paywall` | 38 | 2.16% | 715 ; `C-community-mod` | 37 | 2.10% | 211 ; `C-pronouns` | 36 | 2.04% | 428 ; `M-cancel-hard` | 36 | 2.04% | 66 ; `C-brand-collab` | 35 | 1.99% | 127 ; `C-age-rating` | 33 | 1.87% | 920
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-094 — The 5★ band is dominated by four benefit claims; 41.67% of it carries no theme (median 79 chars, 'Love it', 'So cute'); the important nuance is that 702 five-star reviews carry a billing, reliability or product-change complaint — people who love the app and report a defect anyway

- **Where:** Part 5 5★ band — 25,648 five-star reviews carry no theme at all; 702 five-star reviews carry a billing, reliability or product-change complaint
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 5★ n=61,550 (87.88%); P-motivation 10,318 (16.76% of band); P-cute-design 9,409 (15.29%); P-recommend 9,210 (14.96%); P-mental-health 7,870 (12.79%); untagged 25,648 (41.67%); 702 (1.14%) carry a complaint
- **Direction for us:** none · **Report confidence:** band analysis · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-095 — A handful of reviewers say outright they picked their star rating to be seen rather than to express satisfaction — in both directions: rating down to get the developers' attention ('I'm only making this one star so you can see it… This app is awesome') and rating up so the review sits near the top ('The worst (i only gave it 5 stars so you could see)') — star rating is a weak proxy for satisfaction in both directions; no finding rests on rating alone

- **Where:** Part 5 5★ band — reviewers pick their star rating to be seen rather than to express satisfaction, in both directions
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ~11 hand-verified reviews, well below any threshold
- **Direction for us:** none · **Report confidence:** methodological point · **Generalisable:** yes
- **Review IDs:** `10174564913`, `14351670200`, `10924185515`, `12428506521`, `14082597695`, `12663718459`, `14483561352`, `13697877845`, `14105215358`, `13343247063`, `12426654413`
- **Canonical:** — (nuance register)

### R10-101 — Paid-cohort metrics and the year-by-year paid-sentiment trend

- **Where:** §6.1 The paid cohort table (verbatim); §6.1 The trend is the finding table (verbatim)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Metric | Value ; Reviews with explicit purchase evidence (`paid`) | 1,381 (1.97% of corpus) ; Paid-cohort mean rating | 3.661 ; Paid-cohort rating distribution | 5★ 763 · 4★ 118 · 3★ 90 · 2★ 89 · 1★ 321 (23.24%) ; Non-paid mean rating | 4.785 ; Reviews mentioning a trial (`trial`) | 588 (0.84%), mean 3.238 ; Reviews with both paid + trial evidence | 178, mean 2.185 ;; Year | Paid-evidence reviews | % of that year | Mean rating | 1★ count | 1★ share of paid cohort ; 2021 | 16 | 3.01% | 5.00 | 0 | 0% ; 2022 | 275 | 1.63% | 4.40 | 24 | 8.7% ; 2023 | 222 | 1.83% | 4.01 | 34 | 15.3% ; 2024 | 260 | 1.98% | 3.82 | 54 | 20.8% ; 2025 | 357 | 2.26% | 3.19 | 117 | 32.8% ; 2026 | 251 | 2.16% | 2.96 | 92 | 36.7%
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-104 — The paid cohort is a text signal biased toward grievance and its absolute mean is not an estimate of subscriber satisfaction; the TREND survives because the bias is constant across years, and because the paid cohort's positive themes hold up — paying users report MORE benefit, not less; their falling rating is a falling opinion of the transaction, not of the product's value

- **Where:** §6.2 The honest limits of this section — paid cohort biased toward grievance; two reasons the trend survives
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** P-motivation 18.75% of paid vs 15.96% global; P-mental-health 13.90% vs 11.99%; P-tools 12.89% vs 5.35% (2.4× lift); 1.44-star fall 2022→2026
- **Direction for us:** product-rule · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R10-105 — Paid-cohort complaint lifts: 24 themes with paid n, % of paid cohort, global n and lift

- **Where:** §6.3 What paying customers actually complain about table (verbatim)
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Theme | Paid n | % of paid cohort | Global n | Lift vs. corpus ; `M-refund-denied` | 91 | 6.59% | 98 | 47.1× ; `M-trial-charged` | 96 | 6.95% | 149 | 32.7× ; `M-trial-no-reminder` | 89 | 6.44% | 160 | 28.2× ; `M-unauthorized` | 24 | 1.74% | 51 | 23.9× ; `M-cancel-hard` | 30 | 2.17% | 66 | 23.1× ; `D-support` | 48 | 3.48% | 185 | 13.2× ; `M-upsell-pressure` | 15 | 1.09% | 90 | 8.5× ; `D-notif-broken` | 14 | 1.01% | 86 | 8.3× ; `C-brand-collab` | 20 | 1.45% | 127 | 8.0× ; `M-price-high` | 92 | 6.66% | 596 | 7.8× ; `M-not-free` | 18 | 1.30% | 126 | 7.2× ; `C-community-mod` | 29 | 2.10% | 211 | 7.0× ; `M-guardian` | 92 | 6.66% | 708 | 6.6× ; `U-feature-removed-generic` | 10 | 0.72% | 77 | 6.6× ; `U-ui-change` | 12 | 0.87% | 94 | 6.5× ; `C-religion` | 13 | 0.94% | 116 | 5.7× ; `D-data-loss` | 48 | 3.48% | 551 | 4.4× ; `C-ai` | 13 | 0.94% | 156 | 4.2× ; `P-free-generous` | 71 | 5.14% | 857 | 4.2× ; `U-accessibility` | 44 | 3.19% | 597 | 3.7× ; `D-crash` | 40 | 2.90% | 568 | 3.6× ; `M-paywall` | 47 | 3.40% | 715 | 3.3× ; `U-apple-health` | 34 | 2.46% | 608 | 2.8× ; `U-overwhelm` | 50 | 3.62% | 1,046 | 2.4×
- **Direction for us:** none · **Report confidence:** verbatim · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R10-114 — Direct purchase-trigger evidence is thinner than complaint evidence; no conversion rate is claimed

- **Where:** §6.4 No conversion rate is claimed and none can be
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R10-118 — Where a non-English storefront shows a HIGH theme rate that is a strong finding; where it shows a low rate that is uninformative — non-English storefronts are systematically under-tagged

- **Where:** §7.1 Reminder before reading any theme rate below: classification is English-only
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 21 non-English-primary storefronts
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R10-151 — Trends explicitly NOT claimed: no trend in pronoun objections (flat 0.06–0.10%), no trend in safety-content complaints (the 2022 'schedule time for suicide' cluster is a closed incident), no trend in community moderation (declining slightly), no seasonality claim (volume tracks marketing and events), no claim about 2026H2 beyond the partial period

- **Where:** §8.9 Trends explicitly NOT claimed
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** C-pronouns-objection 0.10/0.06/0.07/0.08/0.07%; C-safety 0.51% → 0.41%; C-community-mod 0.35% → 0.22%; 2026H2 n=2,080 (Jul–7 Sep)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R10-178 — Research questions the corpus cannot answer: are 'charged at trial start' reports real charges, pre-authorisations or store artefacts (server logs can tell); actual data-corruption rate per active user; did any removed feature improve the metric it was removed for (only the cost side is visible); do sponsored IP events acquire more users than they cost in cancellations; subscriber satisfaction among people who never write about money; why did the paid-evidence RATE stay flat (1.6–2.3%) while paid SENTIMENT fell 1.44 stars — something changed in the experience, not in who was writing

- **Where:** §9.6 Research questions this corpus cannot answer
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 149 trial-charged; 551 data-loss; 127 brand-collab; paid 1,381; rate 1.6–2.3%
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** yes
- **Canonical:** — (nuance register)
