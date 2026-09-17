# Cards — report 19

Source: `App Store Reports/19. Wisey - Habit Builder - Form habits, change your life (REPORT).md`  
89 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 8
- [Must-haves](#must-haves) — 5
- [Must never break](#must-never-break) — 7
- [Features](#features) — 6
- [Monetization](#monetization) — 6
- [Tactics the app used](#tactics-the-app-used) — 1
- [Insights (the why)](#insights-the-why) — 13
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 8
- [Dated events and trends](#dated-events-and-trends) — 9
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 5
- [Things not to do](#things-not-to-do) — 7
- [Things to do](#things-to-do) — 1
- [Data caveats and method](#data-caveats-and-method) — 10

## Product rules

### R19-052 — Three reviewers state the money-back guarantee is why they bought and all three say it was not honoured — a guarantee is the cheapest conversion lever in subscription commerce and the most expensive one to break: it converts a refund request into a fraud allegation; 'I signed up with 30 days money back warranty… told that it is not refundable… I am going to report this scammers to my credit card company'

- **Where:** §6.2 The most commercially important line: a money-back guarantee is why they bought, and it was not honoured
- **This app does:** guarantee as conversion lever, then refused
- **User reaction:** 1★-burst
- **Magnitude:** 3 of 64 payers (4.7%); 3 of 105 (2.86%)
- **Direction for us:** product-rule · **Report confidence:** meaningful — most commercially important · **Generalisable:** yes
- **Review IDs:** `12778540152`, `13675718331`, `13772597437`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R19-057 — A 24-hour pre-renewal cancellation cut-off cannot coexist with a 48-hour support reply time when cancellation runs through support — the deadline is structurally unmeetable

- **Where:** §7.1 Support reply time must be shorter than the cancellation deadline
- **This app does:** 24h deadline vs 48h reply
- **User reaction:** 1★-burst
- **Magnitude:** n=1 stating it explicitly
- **Direction for us:** product-rule · **Report confidence:** process defect · **Generalisable:** yes
- **Review IDs:** `13597970945`
- **Canonical:** C112 In-app cancellation; C215 Support reply time must be shorter than any cancellation deadline it serves

### R19-074 — Move subscription billing into the App Store for App Store-acquired users; if the web funnel stays, make the app show the active plan, price, next charge date and a working cancel button — the root cause: 60 distinct reviews once deduplicated flow from a customer who cannot see or stop their own subscription; nothing else matters as much

- **Where:** §10.1 Immediate — act without further research (verbatim table) — #1 Move subscription billing into the App Store
- **This app does:** off-store billing invisible in the app
- **User reaction:** 1★-burst
- **Magnitude:** §0.1 (18) · §0.3a (19) · §0.3b (19) · §7.3 (4); # | Action | Rests on | Why now ; 1 | Move subscription billing into the App Store for App Store-acquired users; if the web funnel stays, make the app show the active plan, price, next charge date and a working cancel button | §0.1 (18) · §0.3a (19) · §0.3b (19) · §7.3 (4) | This is the root cause. Themes 5, 6, 7 and 27 in §3.2 — 60 distinct reviews once deduplicated — all flow from a customer who cannot see or stop their own subscription. Nothing else on this list matters as much. ; 2 | Collapse the e-book plan into the main subscription, or delete it | §0.2 (11) | Two reviewers on two continents report the same asymmetry: the main plan cancels, the e-book plan does not. This is the corpus's most specific and most repeated mechanism. ; 3 | One-tap cancellation, symmetric buttons, one confirmation step | §0.6 (24) · 13636589290 · 13435933779 | The bold-stay/small-cancel asymmetry and the ~10-step confirm chain are named verbatim by reviewers. These are hours of work and they are the direct source of the ADHD-exploitation accusation in §0.9. ; 4 | Delete the "prove 14 days of use" refund condition and honour the advertised money-back guarantee | §0.4a (6) · §0.4b (3) · §6.2 | Three reviewers say the guarantee is *why they bought*. Breaking it converts a refund request into a chargeback and an FTC report (§6.5). The refund is cheaper than the dispute. ; 5 | Send a renewal reminder email before every charge, and a receipt with a working product link after every charge | §7.3 (4) · RENEWAL_SURPRISE (3) · 14087411464 | One reviewer received a single confirmation email with no link to the product and never found it again. Support's own answer — "we sent you an EMAIL notification" (13417665753) — concedes the notification model is the whole safeguard. ; 6 | Fix the four named defects: cancel form not submitting (13689727356 13772597437), settings/account inaccessible (13876370915), iPhone login error 300 with no message (13258914566), back-dating a completed habit (12915336789) | §7.4 (10) | The entire defect surface is ten reports. Two of them block cancellation, which makes them billing defects with legal exposure, not UX polish. ; 7 | Reply to support email within the cancellation deadline, or move cancellation out of email entirely | §7.1 mode 3 · 13597970945 | A 24-hour cancellation deadline served by a 48-hour support queue is unsatisfiable by construction. ; 8 | Retire the discount ladder. Replace a $5-lifetime save-offer against a $99 charge with a plain refund or a pause | §0.5 (3) | The offer is currently teaching customers that the list price is a 20× markup, in public, in writing.
- **Direction for us:** product-rule · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `13366105778`, `13417665753`
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R19-077 — Delete the proof-of-use refund condition and honour the advertised guarantee — breaking it converts a refund request into a chargeback and an FTC report; the refund is cheaper than the dispute

- **Where:** §10.1 #4 Delete the 'prove 14 days of use' refund condition and honour the advertised money-back guarantee
- **This app does:** conditional refunds, unhonoured guarantee
- **User reaction:** 1★-burst
- **Magnitude:** §0.4a (6) · §0.4b (3) · §6.2
- **Direction for us:** product-rule · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `12760145236`, `13675718331`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R19-080 — Reply within the cancellation deadline or move cancellation out of email entirely — a 24-hour deadline served by a 48-hour queue is unsatisfiable by construction

- **Where:** §10.1 #7 Reply to support email within the cancellation deadline, or move cancellation out of email entirely
- **This app does:** email cancellation vs 24h deadline
- **User reaction:** 1★-burst
- **Magnitude:** §7.1 mode 3
- **Direction for us:** product-rule · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `13597970945`
- **Canonical:** C215 Support reply time must be shorter than any cancellation deadline it serves

### R19-083 — Friction a neurotypical user calls annoying this audience calls predatory, because the product's own marketing asserts they cannot be relied on to complete multi-step tasks; the ADHD positioning and the retention funnel are incompatible — pick one; if the positioning stays, the cancellation flow has to be the easiest flow in the product

- **Where:** §10.2 b. Selling to people who struggle with follow-through raises the bar on cancellation, it does not lower it
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 13 (12.38%)
- **Direction for us:** product-rule · **Report confidence:** transferable · **Generalisable:** yes
- **Review IDs:** `13546645984`, `13828678467`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

### R19-084 — Any habit product charging above a few dollars must deliver something a checklist structurally cannot — genuine personalisation, real coaching content, accountability with another human, or data the user could not assemble themselves; Wisey charged $45–$99 for the substitute and got 96 one-star reviews

- **Where:** §10.2 c. A checklist has a free substitute pre-installed on the device
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 13 name the substitute; 96 1★
- **Direction for us:** product-rule · **Report confidence:** transferable · **Generalisable:** yes
- **Review IDs:** `13828678467`, `13094667829`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R19-085 — A guarantee's value is in the buying decision; its cost is in honouring it; a guarantee you will not honour is a fraud allegation you have pre-purchased

- **Where:** §10.2 d. A guarantee is a conversion lever that only works once
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 3 bought because of it, 3 escalated
- **Direction for us:** product-rule · **Report confidence:** transferable · **Generalisable:** yes
- **Review IDs:** `12778540152`, `13675718331`, `13772597437`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

## Must-haves

### R19-043 — Three ask for a cancel button inside the app instead of an email

- **Where:** §3.4 Cancel from inside the app — a cancel button that is not an email
- **This app does:** email-only cancellation
- **User reaction:** complaint
- **Magnitude:** 3 named; CANCEL_HARD 24
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12731738911`, `13099305086`, `13280826420`
- **Canonical:** C112 In-app cancellation

### R19-056 — Support failure in four modes: no reply at all ('ZERO response'; 'Support never responds to emails'); circular replies ('keeps looping you around'; 'inconsistently suggest we go to Apple support directly'); slow enough to defeat the deadline — 'They said cancel within 24 hours before and they take more than 48 hrs to get back to you!' — when cancellation runs through support email and support replies in 48 hours against a 24-hour deadline the deadline cannot be met, a process defect not a service-quality complaint; hostile or scripted ('a rude lecture via email about how I signed up on purpose'; 'less like support and more like a scripted sales funnel')

- **Where:** §7.1 Support failure — 17 of 105 (16.19%); four failure modes
- **This app does:** email-only support: silent, circular, slow, hostile
- **User reaction:** 1★-burst
- **Magnitude:** 17 of 105 (16.19%, High-priority)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12705617097`, `12742285860`, `12761607224`, `12874978864`, `12998276106`, `13003020356`, `13142094640`, `13202910675`, `13241632109`, `13259029152`, `13280826420`, `13417665753`, `13597970945`, `13675718331`, `13716802092`, `13921976046`, `14397733811`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C215 Support reply time must be shorter than any cancellation deadline it serves

### R19-059 — Reviewers cannot find any record of what they bought — 'no confirmation email anywhere'; 'Customer support emailed and said we sent you an EMAIL notification. Seriously an email'; 'when you get your thank-you email BE SURE to click the link at the bottom. THAT is where the fine print is'; combined with off-store billing this produces a customer who has been charged and possesses no subscription entry, no receipt they can find and no working link to the product — every downstream support cost starts here

- **Where:** §7.3 Records and receipts — 4 of 105 (3.81%); no subscription entry, no receipt, no working link
- **This app does:** no receipt / no record / fine print in a footer link
- **User reaction:** 1★-burst
- **Magnitude:** 4 of 105 (3.81%, Very strong)
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13150104593`, `13366105778`, `13417665753`, `14087411464`
- **Canonical:** C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel; C221 A receipt with a working product link after every charge, and a renewal reminder before it

### R19-076 — One-tap cancellation, symmetric buttons, one confirmation step — hours of work, and the direct source of the ADHD-exploitation accusation

- **Where:** §10.1 #3 One-tap cancellation, symmetric buttons, one confirmation step
- **This app does:** asymmetric buttons, ~10 confirms
- **User reaction:** 1★-burst
- **Magnitude:** §0.6 (24)
- **Direction for us:** must-have · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `13636589290`, `13435933779`
- **Canonical:** C112 In-app cancellation

### R19-078 — A renewal reminder before every charge and a receipt with a working product link after every charge — support's own answer 'we sent you an EMAIL notification' concedes the notification model is the whole safeguard

- **Where:** §10.1 #5 Send a renewal reminder email before every charge, and a receipt with a working product link after every charge
- **This app does:** single confirmation email with no link
- **User reaction:** 1★-burst
- **Magnitude:** §7.3 (4) · RENEWAL_SURPRISE (3)
- **Direction for us:** must-have · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14087411464`, `13417665753`
- **Canonical:** C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date; C221 A receipt with a working product link after every charge, and a renewal reminder before it

## Must never break

### R19-006 — Charged after cancelling: 'I followed the cancellation instructions exactly well before the time required and was charged several days later'; 'trying since the first month to cancel… 6 months later they are still taking my money'; 'It breaks cancellations into two innocuous components, so even if the user thinks they've cancelled (and receives a cancellation email) they will continue charging'; cancelled after a $34.99 trial charge, then charged $99.99 three months later

- **Where:** §0.3 (a) Charged after cancelling — 19 of 105
- **This app does:** charges continue after cancellation
- **User reaction:** 1★-burst
- **Magnitude:** 19 of 105 (18.10%, High-priority)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12763706876`, `12821851615`, `12836726941`, `12910430870`, `13099305086`, `13131008150`, `13142094640`, `13259029152`, `13280826420`, `13282459076`, `13366105778`, `13369386593`, `13435933779`, `13636589290`, `13679453387`, `13752060221`, `13880194933`, `13917677839`, `14160038721`
- **Canonical:** C029 Billing must be exactly right; C112 In-app cancellation; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R19-007 — Charged with no subscription the reviewer recognises — 'Unauthorized transaction… Never signed up for this'; 'Have never used this app. Now it is continually trying to charge my credit card' (nz); 'one dollar charges will come out constantly'; 'stolen over $100 now and the app keeps on trying to get $59.99 again and again every week'

- **Where:** §0.3 (b) Charged with no subscription the reviewer recognises — 19 of 105
- **This app does:** unrecognised recurring charges
- **User reaction:** 1★-burst
- **Magnitude:** 19 of 105 (18.10%, High-priority)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12811553385`, `12924114693`, `12985541561`, `13101150060`, `13131239346`, `13150104593`, `13248498967`, `13251215774`, `13280092455`, `13369386593`, `13490397655`, `13597970945`, `13636589290`, `13644957048`, `13759087115`, `13770028994`, `13810899948`, `14160038721`, `14208322175`
- **Canonical:** C029 Billing must be exactly right; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R19-009 — Refunds refused for 25 of 105 (23.81%, High-priority); the refusal is not what makes people write 'scam' — three specific mechanics are (proof-of-use requirement, unhonoured guarantee, retention offers instead of an answer)

- **Where:** §0.4 The refund policy is the churn engine — 25 of 105 refused a refund
- **This app does:** refunds refused; website purchases non-refundable
- **User reaction:** 1★-burst
- **Magnitude:** 25 of 105 (23.81%, High-priority)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12763706876`, `12778540152`, `12811553385`, `12819961338`, `12868620709`, `12874978864`, `12985541561`, `12998276106`, `13003020356`, `13007286102`, `13009681827`, `13259029152`, `13280826420`, `13311158289`, `13357149144`, `13417665753`, `13675718331`, `13716802092`, `13742636617`, `13770028994`, `13772597437`, `13785381809`, `13880194933`, `13926895274`, `14087411464`
- **Canonical:** C029 Billing must be exactly right; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R19-036 — A 'free trial' that charged (10, 9.52%); terms found only after charging (5); no renewal warning (3); price not visible at decision time (3 — 'They hide price on the main page'); charged ≠ agreed (3 — $29.99 annual agreed, $59.99/month billed); no confirmation or record (4, 3.81%)

- **Where:** §3.2 TRIAL_MISLEAD — 'free trial' that charged; FINE_PRINT; RENEWAL_SURPRISE; PRICE_OPACITY; PRICE_MISMATCH; RECEIPT_MISSING
- **This app does:** trial/price/renewal disclosure failures
- **User reaction:** 1★-burst
- **Magnitude:** 10 + 5 + 3 + 3 + 3 + 4
- **Direction for us:** must-never-break · **Report confidence:** high-priority / very strong / meaningful · **Generalisable:** yes
- **Review IDs:** `12985541561`, `13311158289`, `13742636617`, `13716802092`, `13803171356`, `13921976046`, `12742285860`, `13248498967`
- **Canonical:** C109 A free trial must be a real trial; C113 One stable, disclosed price — no discount wheels; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says; C221 A receipt with a working product link after every charge, and a renewal reminder before it

### R19-058 — Paid and could not use what they paid for — 'I can log in on my laptop but no apps'; 'App doesn't work, was not able to use the service and was still charged $49.99'; login error 300 on iPhone (iPad fine) with no error message; 'once you've started the cancellation process, you can no longer log onto the app' — buried inside billing complaints; the error-300 review is the only pure bug report in the corpus and the cheapest actionable item

- **Where:** §7.2 Entitlement failures — 5 of 105 (4.76%); the most under-weighted finding
- **This app does:** paid, no access; device-specific login failure
- **User reaction:** 1★-burst
- **Magnitude:** 5 of 105 (4.76%, Very strong)
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12742285860`, `13142094640`, `13357149144`, `13258914566`, `14160038721`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R19-060 — The complete defect list: cannot back-date a completed habit; login fails on iPhone with error 300 and no message (iPad unaffected); app freezes (mx); settings/account section inaccessible for weeks (de); cancel form does not work (two independent reports); paid but no access (4) — ten reports in sixteen months, none corroborated more than twice, a small and unremarkable defect surface; the software is not what is generating this corpus

- **Where:** §7.4 Software defects — the complete list, 10 of 105 (verbatim table)
- **This app does:** small defect surface
- **User reaction:** complaint
- **Magnitude:** Defect | ID | Detail ; Cannot back-date a completed habit | 12915336789 | "Today I went to log yesterday's habit and it wouldn't let me" ; Login fails on iPhone, error 300, no message | 13258914566 | iPad unaffected ; App freezes | 13816735964 (mx) | "Always freeze" ; Settings / account section inaccessible for weeks | 13876370915 (de) | Blocked cancellation ; Cancel form does not work | 13689727356 13772597437 | Two independent reports ; Paid but no access | 12742285860 13142094640 13357149144 14160038721 | §7.2
- **Direction for us:** none · **Report confidence:** high-priority by count, small in substance · **Generalisable:** app-specific
- **Review IDs:** `12915336789`, `13258914566`, `13816735964`, `13876370915`, `13689727356`, `13772597437`, `12742285860`, `13142094640`, `13357149144`, `14160038721`
- **Canonical:** C031 Crashes / launch failures; C033 Restore purchase and entitlements must work immediately

### R19-079 — Fix the four named defects: cancel form not submitting, settings/account inaccessible, iPhone login error 300 with no message, back-dating a completed habit — two of them block cancellation, which makes them billing defects with legal exposure, not UX polish

- **Where:** §10.1 #6 Fix the four named defects
- **This app does:** small defect list, two block cancellation
- **User reaction:** 1★-burst
- **Magnitude:** §7.4 (10)
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `13689727356`, `13772597437`, `13876370915`, `13258914566`, `12915336789`
- **Canonical:** C010 Backfill missed days / edit start date; C031 Crashes / launch failures; C033 Restore purchase and entitlements must work immediately

## Features

### R19-024 — Feature inventory — only the first four are described by anyone as working: habit checklist (works; 'just a calendar'); reminders/alarms (works; three call it an alarm clock); home-screen widget (one 5★ mention); back-dating a missed habit (broken or absent — 'went to log yesterday's habit and it wouldn't let me'); courses/video lessons (mixed — one finds them useful, five call them thin/boring/generic/AI-generated); e-books/PDFs (uniformly negative); focus music; personalised plan from a quiz (promised, not delivered); a suite of separate apps ('useless little apps'); web portal/account area (the real product surface, never surfaced from inside the app); support chat bot 'Rachel'; login/account access (fragile, error 300); store listing claims statistics and charts — nobody in the corpus mentions them at all

- **Where:** §2.1 Feature inventory derived from reviews (verbatim table)
- **This app does:** see table
- **User reaction:** mixed
- **Magnitude:** Capability | Evidence | Reviewer verdict ; Habit checklist / tracker | 12748055966 12933789910 13117882072 13131008150 13194035072 14107869084 | Works; universally described as minimal. "Just a calendar" (14107869084) ; Reminders / alarms | 13568090356 (5★) 12692126207 13636589290 13828678467 | Works; three reviewers call it an alarm clock ; Home-screen widget | 13571866718 (5★) | Only mention in the corpus; positive ; Back-dating a missed habit | 12915336789 | Broken or absent — "Today I went to log yesterday's habit and it wouldn't let me" ; Courses / video lessons | 13398540937 (3★, positive) 12748055966 12910430870 12760145236 13675718331 14160038721 | Mixed. One reviewer finds the courses genuinely useful; five call them thin, boring, generic or AI-generated ; E-books / workbooks / PDFs | 11 reviews, §0.2 | Uniformly negative; the main billing grievance ; Focus music | 12998276106 | "only consisted of music that purportedly helped you to focus" ; Personalised plan from a quiz | 12748055966 12778540152 13194035072 13785381809 14107869084 | Promised, not delivered (§0.8) ; A suite of separate apps | 12778540152 13785381809 13398540937 | Confirmed externally (4 apps); reviewers call them "useless little apps" ; Web portal / account area | 13398540937 (positive) 13366105778 13876370915 13150104593 | The real product surface; never surfaced from inside the app ; Support chat bot ("Rachel") | 13251215774 13921976046 | One "nice"; one "tried to convince me to stay" ; Login / account access | 13258914566 (error 300) 12742285860 13876370915 14160038721 | Fragile
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Review IDs:** `12748055966`, `13568090356`, `13571866718`, `12915336789`, `13398540937`, `12998276106`, `12778540152`, `13366105778`, `13251215774`, `13258914566`, `12742285860`
- **Canonical:** — (nuance register)

### R19-025 — Back-dating a missed habit is broken or absent — 'Today I went to log yesterday's habit and it wouldn't let me'

- **Where:** §2.1 Back-dating a missed habit — broken or absent
- **This app does:** absent/broken
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** free · **Report confidence:** single · **Generalisable:** yes
- **Review IDs:** `12915336789`
- **Canonical:** C010 Backfill missed days / edit start date

### R19-026 — The web portal (courses, account area) is the real product surface and the only praised asset, and the app never links to it

- **Where:** §2.1 Web portal / account area — the real product surface, never surfaced from inside the app
- **This app does:** web portal disconnected from app
- **User reaction:** mixed
- **Magnitude:** 4 IDs; 1 positive
- **Direction for us:** do · **Report confidence:** close reading · **Generalisable:** app-specific
- **Review IDs:** `13398540937`, `13366105778`, `13876370915`, `13150104593`
- **Canonical:** C142 Surface existing features where users look

### R19-027 — The listing claims progress statistics and charts, templates, smart reminders and widgets; nobody in the corpus mentions statistics or charts at all — neither to praise nor to complain

- **Where:** §2.1 Store-listing claims statistics and charts — nobody in the corpus mentions them
- **This app does:** claimed, invisible
- **User reaction:** none
- **Magnitude:** 0 of 105 mentions
- **Direction for us:** none · **Report confidence:** external check · **Generalisable:** app-specific
- **Canonical:** C134 Lead the store listing with what users actually love

### R19-040 — Only six requests — people fighting a charge do not file feature requests: surface the web portal from inside the app ('a few seconds to say look here for more help… and have a hyperlink'); allow back-dating a completed habit ('I did the habit so why can't I go back and track it?'); Spanish localisation (ads run in Spanish, app English-only); in-app guidance ('I don't see instructions!!!'); a way to evaluate before paying; cancel from inside the app

- **Where:** §3.4 Unmet needs — every request in the corpus (verbatim table); scarcity is itself a finding
- **This app does:** requests
- **User reaction:** complaint
- **Magnitude:** Request | ID | Exact ask ; Surface the web portal from inside the app | 13398540937 | "Perhaps advertise the website on the apps when they open? Something short, a few seconds to say 'look here for more help with your day' and have a hyper link." ; Allow back-dating a completed habit | 12915336789 | "I did the habit so why can't I go back and track it?" ; Spanish localisation | 13710711149 | Ads run in Spanish; the app is English-only ; In-app guidance / instructions | 13150371570 | "I'm finding little in the way of guidence. I don't see instructions!!!" ; A way to evaluate before paying | 13405220625 14289131320 12819961338 | A real free tier or trial ; Cancel from inside the app | 12731738911 13099305086 13280826420 | A cancel button that is not an email
- **Direction for us:** none · **Report confidence:** request table · **Generalisable:** app-specific
- **Review IDs:** `13398540937`, `12915336789`, `13710711149`, `13150371570`, `13405220625`, `14289131320`, `12819961338`, `12731738911`, `13099305086`, `13280826420`
- **Canonical:** C010 Backfill missed days / edit start date; C112 In-app cancellation; C142 Surface existing features where users look; C147 Let people use the product before they pay

### R19-042 — 'I'm finding little in the way of guidance. I don't see instructions!!!' — no onboarding guidance

- **Where:** §3.4 In-app guidance / instructions
- **This app does:** no instructions
- **User reaction:** complaint
- **Magnitude:** 2 (ONBOARDING_GAP 1.90%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13150371570`, `14087411464`
- **Canonical:** C075 Skippable, replayable onboarding tour

## Monetization

### R19-028 — App Store listing: free download, IAP Premium $6.99 and $29.99; reviewers report web subscriptions of $15–$99.99, a second web subscription for e-books ($17–$45/month) and retention offers ($1/month, $5 lifetime, $49–$49.99 lifetime) — none shown on the listing; $29.99 appears once as an agreed annual price then billed at $59.99/month; no reviewer clearly identifies as an Apple-billed purchaser

- **Where:** §2.2 Monetisation model — listing vs reviewer-reported table (verbatim); the mismatch is the finding
- **This app does:** listing prices ≠ charged prices
- **User reaction:** 1★-burst
- **Magnitude:** Layer | What the App Store listing says (external, 10 Sep 2026) | What reviewers report paying ; App download | Free | Free ✓ ; In-App Purchase | Premium $6.99; Premium $29.99 | $29.99 appears once, as an *agreed* annual price that was then billed at $59.99/month (13248498967); $9.99 once (13671148757); "$7 minimum" cited by a non-buyer (13405220625) ; Web subscription | *not shown on the App Store listing* | $15, $30, $34.99, $37, $45, $49.99, $50, $59.99, $60, $70, $85, $98.50, $99, $99.99 ; Second web subscription (e-books) | *not shown on the App Store listing* | $17, $17.99, $19.99, $45/month ; Retention offer | *not published* | $1/month; $5 lifetime; $49–$49.99 lifetime
- **Direction for us:** dont · **Report confidence:** external + reviews · **Generalisable:** app-specific
- **Review IDs:** `13248498967`, `13671148757`, `13405220625`
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R19-029 — Free: downloading the app — nothing else confirmed free; paid: habit tracking itself ('Everything you do requires extra payment'; 'there isn't even the possibility of trying the minimum functions' — it); separately gated: e-books; trial-gated: a trial exists but is described inconsistently ('free 7 days charged trial', '$45 for the initial trial', '$34.99 trial') — whether a genuinely free trial exists is unclear; unclear which capabilities the $6.99/$29.99 IAPs unlock

- **Where:** §2.2 Classification of capabilities by gate (verbatim table)
- **This app does:** everything paid; trial ambiguous
- **User reaction:** blocked-conversion
- **Magnitude:** Gate | Capabilities ; Free | Downloading the app. Nothing else is confirmed free by any reviewer. ; Paid / subscription-gated | Habit tracking itself, per 12915335177 ("Everything you do requires extra payment") and 14289131320 (it) ("non c'è neanche la possibilità di provare le funzioni minime" — *there isn't even the possibility of trying the minimum functions*) ; Separately gated | E-books / workbooks — a second subscription (§0.2) ; Trial-gated | A trial exists but is described inconsistently: "free 7 days charged trial" (12985541561), "$45 for the initial trial" (12836726941), "$34.99 trial" (13366105778). Whether a genuinely free trial exists is unclear from the corpus. ; Unclear | Which capabilities the $6.99 / $29.99 App Store IAPs unlock. No reviewer in this corpus clearly identifies as an Apple-billed purchaser.
- **Direction for us:** product-rule · **Report confidence:** review-derived · **Generalisable:** app-specific
- **Review IDs:** `12915335177`, `14289131320`, `12985541561`, `12836726941`, `13366105778`
- **Canonical:** C147 Let people use the product before they pay; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R19-030 — Four refused to buy because they could not try first — 'Not even a free trial? There's no way to see if you'd even like the app before putting down a minimum of $7. I'll pass'; the subscription request 'starts immediately' and is 'excessively expensive' (it); 'there is no trial period where you can try the app first' (ca) — the only conversion-funnel evidence from non-payers

- **Where:** §2.2 4 of 105 refused to buy because they could not try first
- **This app does:** no evaluable free tier
- **User reaction:** blocked-conversion
- **Magnitude:** 4 of 105 (3.81%, Very strong)
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `13405220625`, `14289131320`, `12819961338`, `12915335177`
- **Canonical:** C063 Free trial before purchase; C147 Let people use the product before they pay

### R19-031 — The developer's terms permit renewal 'each week, month, 6 months, year', a 24-hour pre-trial-end cancellation cut-off, non-refundable website purchases, and cancellation 'via settings in your account' or by email; EU withdrawal right 14 days; two observations: weekly billing makes '$59.99 again and again every week' structurally possible, and the cancellation surface the terms point to is precisely the one two reviewers say they lost access to

- **Where:** §2.2 Developer's published terms — weekly billing permitted; cancel via account settings users lose access to
- **This app does:** weekly-capable auto-renew; cancel via a surface that locks users out
- **User reaction:** 1★-burst
- **Magnitude:** terms accessed 10 Sep 2026; 3 IDs
- **Direction for us:** dont · **Report confidence:** external · **Generalisable:** yes
- **Review IDs:** `13490397655`, `13876370915`, `14160038721`
- **Canonical:** C112 In-app cancellation; C190 No weekly billing tier; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R19-050 — Confirmed payers 64 (60.95%), inferred 3, not established 38; 63 of 64 confirmed payers left 1★ (the 64th is the 3★); not one of the eight 5★ reviewers indicates being a customer in any commercial sense — a majority-payer corpus, not the voice of people who bounced off a paywall

- **Where:** §6.1 The payer cohort — 64 of 105 (60.95%); group table (verbatim)
- **This app does:** majority of reviewers paid
- **User reaction:** 1★-burst
- **Magnitude:** Group | n | % of 105 ; Confirmed payers | 64 | 60.95% ; Inferred payers (strongly implied, not stated) — 12874978864 13202910675 13754537415 | 3 | 2.86% ; Payment not established | 38 | 36.19%
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13398540937`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R19-053 — Among 64 payers: scam label 67.2%, refund refused 32.8%, cancel hard 31.2%, billed post-cancel 28.1%, off-store 23.4%, double billed 23.4%, not as advertised 21.9%, price high 20.3%, unauthorised 18.8%, support fail 18.8%, content thin 17.2%, e-book upsell 15.6%, low value vs free 15.6%, ADHD targeting 14.1% — one third of everyone who paid says they could not get their money back and just under one third says they could not stop paying; for a subscription business those two numbers in a public corpus are the business

- **Where:** §6.3 What paid users complain about — segment rates (verbatim table)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | Payers | Segment rate | Global n (of 105) ; SCAM_LABEL | 43 | 67.2% | 57 ; REFUND_REFUSED | 21 | 32.8% | 25 ; CANCEL_HARD | 20 | 31.2% | 24 ; BILL_POST_CANCEL | 18 | 28.1% | 19 ; OFF_STORE | 15 | 23.4% | 18 ; BILL_DOUBLE | 15 | 23.4% | 16 ; NOT_AS_ADVERTISED | 14 | 21.9% | 19 ; PRICE_HIGH | 13 | 20.3% | 15 ; BILL_UNAUTH | 12 | 18.8% | 19 ; SUPPORT_FAIL | 12 | 18.8% | 17 ; CONTENT_THIN | 11 | 17.2% | 12 ; EBOOK_UPSELL | 10 | 15.6% | 11 ; LOW_VALUE_VS_FREE | 10 | 15.6% | 13 ; ADHD_TARGETING | 9 | 14.1% | 13
- **Direction for us:** must-never-break · **Report confidence:** payer cohort · **Generalisable:** yes
- **Canonical:** C029 Billing must be exactly right; C065 Paying customers are the highest 1★ risk — every paid feature must work

## Tactics the app used

### R19-018 — The acquisition channel is named by six: Instagram (3), YouTube (1), unspecified social media (2); the pattern is consistent — paid social ad → web quiz → web checkout → an app that turns out to be a checklist

- **Where:** §0.9 Six name the acquisition channel — paid social ad → web quiz → web checkout → checklist
- **This app does:** paid social → web quiz → web checkout
- **User reaction:** 1★-burst
- **Magnitude:** 6 of 105 (5.71%, High-priority)
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12998276106`, `13671148757`, `13710711149`, `14107869084`, `14087411464`, `13880194933`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C148 The paid product must deliver what the ads and onboarding demonstrate

## Insights (the why)

### R19-003 — Executive summary: Wisey is not, in its reviews, a habit-tracking product — it is a payment funnel with a habit tracker attached, and the reviews are a dispute record; nine findings: billing outside the App Store (18, 17.14%); a second e-book subscription (11, 10.48%); charged after cancelling (19) and charged with no recognised subscription (19); refunds refused (25, 23.81%) with three mechanics turning refusal into fraud allegations; a save-flow that destroys price credibility ($98.50/mo → $5 or $49 lifetime); cancellation obstructed by five named mechanics (24, 22.86%); a product ceiling — a checklist cannot carry $45–$99 (13, 12.38%); ADHD-targeting accusations (13, 12.38%) with 6 escalations to banks/FTC; the December 5★ burst of unresolved provenance

- **Where:** Executive summary — nine findings
- **This app does:** web-funnel subscription with thin app
- **User reaction:** 1★-burst
- **Magnitude:** see individual cards
- **Direction for us:** product-rule · **Report confidence:** summary · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R19-015 — Strip out the billing and a quieter finding remains: the product does nothing existing free tools don't — the phone's alarm, the Notes app, the calendar, paper or Excel; 'If you can set an alarm on your phone you don't need this app'; 'might as well asked my kids to draw up a habit builder — no input or suggestions, videos, nothing, just a calendar' (gb); 'a very basic checklist hidden behind a terrible UI and clunky UX' (au); this is the finding that generalises — a habit tracker whose entire surface is a checklist has a commodity substitute pre-installed on every phone, and that ceiling is what makes $45–$99 read as theft rather than as expensive

- **Where:** §0.7 'It's a to-do list I could have written myself' — the value problem underneath the billing problem
- **This app does:** bare checklist at $45–$99
- **User reaction:** 1★-burst
- **Magnitude:** 13 of 105 (12.38%, High-priority)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12692126207`, `12731738911`, `12748055966`, `12933789910`, `13094667829`, `13117882072`, `13131008150`, `13194035072`, `13251215774`, `13636589290`, `13810899948`, `13828678467`, `14107869084`
- **Canonical:** C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R19-020 — Only 11 of 105 (10.48%) contain anything positive and 8 are the December 5★ burst; setting it aside leaves three statements in sixteen months: the only 3★ — 'the online portal/website has tons of helpful info… a few episodes in their courses very useful. The apps are too rudimentary to be helpful but the website is good'; 'It's technically easy to use' (immediately followed by 'none of this actually helps build habits'); 'AI Bot Rachel was nice though. Haha.'

- **Where:** §0.10 What the corpus says works — a very short section, honestly labelled
- **This app does:** web course library is the only praised asset
- **User reaction:** mixed
- **Magnitude:** 11 of 105 (10.48%) positive; 3 excluding the burst
- **Direction for us:** research · **Report confidence:** honest minimum · **Generalisable:** app-specific
- **Review IDs:** `13398540937`, `13117882072`, `13251215774`
- **Canonical:** C142 Surface existing features where users look

### R19-032 — 75 of 105 (71.43%) raise any money theme, 51 (48.57%) any product theme, 35 both, 40 money only, 16 product only, 14 neither, and only 10 (9.52%) report a functional software defect — a habit tracker generating 7.5× more billing complaints than bug reports; in every other folder in the collection the ratio runs the other way; the engineering surface is not what is failing, the commercial surface is

- **Where:** §3.1 The corpus splits into two subjects, and one dwarfs the other (verbatim table)
- **This app does:** commercial failure, not engineering failure
- **User reaction:** 1★-burst
- **Magnitude:** Group | n | % of 105 | Signal ; Raises any money theme (billing, price, trial, cancellation, refund, upsell, receipts) | 75 | 71.43% | High-priority ; Raises any product theme (value, content, UX, bugs, onboarding, localisation) | 51 | 48.57% | High-priority ; Raises both | 35 | 33.33% | — ; Money only | 40 | 38.10% | — ; Product only | 16 | 15.24% | — ; Raises neither (pure verdict, no mechanism, or short praise) | 14 | 13.33% | — ; Reports a functional software defect | 10 | 9.52% | High-priority
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R19-034 — 57 of 105 (54.29%) use the word scam, fraud, crooks or stealing — the corpus's default vocabulary, not a fringe reaction; 59.4% of the 1★ band

- **Where:** §3.2 SCAM_LABEL — 57 of 105 use the word scam / fraud / crooks / stealing
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 57 (54.29%, High-priority)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** app-specific
- **Review IDs:** `12692126207`, `12896636688`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R19-035 — Not-as-advertised (19, 18.10%), price too high (15, 14.29% — nobody defends the price) and thin content — courses/videos/PDFs judged worthless, one calling them AI-generated (12, 11.43%) are all high-priority

- **Where:** §3.2 NOT_AS_ADVERTISED — gap between the ad and the app; PRICE_HIGH — nobody defends the price; CONTENT_THIN
- **This app does:** advertised programme ≠ delivered checklist
- **User reaction:** 1★-burst
- **Magnitude:** 19 + 15 + 12
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13675718331`, `12760145236`, `14107869084`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C148 The paid product must deliver what the ads and onboarding demonstrate; C214 A bare checklist cannot carry a premium price — it has a free substitute pre-installed on every phone

### R19-039 — Positive themes: generic praise 7 (all 5★ burst); tone 'feels human / calm' 2; reminders 1; widget 1; web courses genuinely useful 1; 'technically easy to use' inside a 1★; support bot pleasant inside a 1★ — excluding the December burst the corpus contains three positive statements in sixteen months, two inside one-star reviews

- **Where:** §3.3 Positive themes — the complete list (verbatim table)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % | Signal | IDs ; PRAISE_GENERIC — undifferentiated praise, no feature named | 7 | 6.67% | High-priority | all 5★, see §5 ; PRAISE_TONE — "feels human", "calm" | 2 | 1.90% | Meaningful | 13549237052 13552347079 ; PRAISE_REMINDERS | 1 | 0.95% | Emerging | 13568090356 ; PRAISE_WIDGET | 1 | 0.95% | Emerging | 13571866718 ; CONTENT_VALUE_POS — the web courses are genuinely useful | 1 | 0.95% | Emerging | 13398540937 ; EASE_OK — "technically easy to use" (inside a 1★) | 1 | 0.95% | Emerging | 13117882072 ; AI_BOT_POS — support bot was pleasant (inside a 1★) | 1 | 0.95% | Emerging | 13251215774
- **Direction for us:** none · **Report confidence:** theme table · **Generalisable:** app-specific
- **Review IDs:** `13549237052`, `13552347079`, `13568090356`, `13571866718`, `13398540937`, `13117882072`, `13251215774`
- **Canonical:** — (nuance register)

### R19-046 — Within the 1★ band: scam label 57 (59.4%), confirmed payer 63 (65.6%), refund refused 25 (26.0%), cancel hard 24 (25.0%), billed post-cancel 19, unauthorised 19, not-as-advertised 19; four causes in order: a money dispute (75 of 96, 78.1% — the modal 1★ is a person who paid, tried to stop paying, and could not); a value verdict without a dispute (16 — 'paper or an excel sheet is just as useful'); a pure verdict with no mechanism ('Just go talk to your doctor'); a functional complaint (only four: back-dating, login error 300, freezing, no instructions); two 1★ reviews contain praise — star rating in this corpus is not a feature preference, it is a verdict on the transaction

- **Where:** §4.2 What drives 1★ — n = 96 (verbatim table); four causes; star rating is a verdict on the transaction
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n in 1★ | Segment rate | Global count ; SCAM_LABEL | 57 | 59.4% of 1★ | 57 ; CONFIRMED_PAYER | 63 | 65.6% of 1★ | 64 ; REFUND_REFUSED | 25 | 26.0% of 1★ | 25 ; CANCEL_HARD | 24 | 25.0% of 1★ | 24 ; BILL_POST_CANCEL | 19 | 19.8% of 1★ | 19 ; BILL_UNAUTH | 19 | 19.8% of 1★ | 19 ; NOT_AS_ADVERTISED | 19 | 19.8% of 1★ | 19
- **Direction for us:** product-rule · **Report confidence:** rating band · **Generalisable:** yes
- **Review IDs:** `13094667829`, `13828678467`, `14107869084`, `12896636688`, `13016003589`, `13296391777`, `13003499428`, `12915336789`, `13258914566`, `13816735964`, `13150371570`, `13117882072`, `13251215774`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R19-047 — The only mixed review, by a confirmed payer still trying to use the product: the web portal 'has tons of helpful info… a few episodes in their courses very useful'; 'The apps are too rudimentary to be helpful'; request: advertise the website from inside the app on open with a link — found real value by accident, on a surface the app never pointed them to

- **Where:** §4.3 The single 3★ — the only reviewer still trying to use the product
- **This app does:** value hidden on an unlinked surface
- **User reaction:** mixed
- **Magnitude:** n=1 (3★, ca, 14 Nov 2025)
- **Direction for us:** do · **Report confidence:** single · **Generalisable:** yes
- **Review IDs:** `13398540937`
- **Canonical:** C142 Surface existing features where users look

### R19-051 — Purchase triggers among 64 payers: a paid social ad promising ADHD help 6 (9.4%); the promise of a personalised plan from a quiz 5 (7.8%); a 'free trial' framing 8 (12.5%; 10 globally); a money-back guarantee used as risk reversal 3 (4.7%); impulse explicitly attributed to ADHD 1 ('I signed up on an impulse because I have ADHD… hence the interest in Wisey'); never read these as conversion rates

- **Where:** §6.2 What made people pay — named purchase triggers (verbatim table)
- **This app does:** ads + quiz + trial + guarantee funnel
- **User reaction:** 1★-burst
- **Magnitude:** Trigger | Payers | Segment rate | Global | Evidence ; A paid social ad promising ADHD help | 6 | 9.4% of payers | 6 / 105 (5.71%) | 12998276106 (IG) 13671148757 (IG) 13710711149 (IG, Spanish-language ad) 13880194933 14087411464 14107869084 (YouTube) ; The promise of a personalised plan from a quiz | 5 | 7.8% of payers | 5 / 105 (4.76%) | 12748055966 12778540152 13194035072 13785381809 14107869084 ; A "free trial" framing | 8 | 12.5% of payers | 10 / 105 (9.52%) | 12763706876 12836726941 12985541561 13131008150 13280826420 13311158289 13366105778 13926895274 ; A money-back guarantee used as risk reversal | 3 | 4.7% of payers | 3 / 105 (2.86%) | 12778540152 (30-day) 13675718331 (30-day) 13772597437 ; Impulse, explicitly attributed to ADHD | 1 | 1.6% of payers | 1 / 105 (0.95%) | 13003020356 — "I signed up for this on an impulse (because I have ADHD…. Hence the interest in Wisey)"
- **Direction for us:** dont · **Report confidence:** named triggers · **Generalisable:** yes
- **Review IDs:** `12998276106`, `13671148757`, `13710711149`, `13880194933`, `14087411464`, `14107869084`, `12748055966`, `12763706876`, `12836726941`, `12985541561`, `13131008150`, `13280826420`, `13311158289`, `13366105778`, `13926895274`, `12778540152`, `13675718331`, `13772597437`, `13003020356`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C109 A free trial must be a real trial; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R19-054 — Only four non-payers, all giving the same reason — no way to evaluate first; the absence of a larger price-objection population is itself informative: people are not bouncing off this paywall, they are going through it and then trying to reverse the transaction — the problem is not acquisition, it is what happens after

- **Where:** §6.4 Upgrade barriers — the non-payer evidence; people are not bouncing off this paywall
- **This app does:** funnel converts, then reverses
- **User reaction:** blocked-conversion
- **Magnitude:** 4 of 105 (3.81%, Very strong)
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12819961338`, `12915335177`, `13405220625`, `14289131320`
- **Canonical:** C147 Let people use the product before they pay; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### R19-082 — Trust is a purchasable feature: in a category where the software is commoditised, Apple-billed subscriptions, one-tap cancel, a visible price on the paywall and a renewal reminder are product differentiators that cost almost nothing to ship — say so in the store listing; a competitor was recommended because its 'customer service aren't trying to rob you'

- **Where:** §10.2 a. Trust is a purchasable feature, and this corpus prices it
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** transferable lesson
- **Direction for us:** do · **Report confidence:** transferable · **Generalisable:** yes
- **Review IDs:** `12863798573`
- **Canonical:** C005 Know which competitors buyers compare against; C112 In-app cancellation; C181 If the app is paid-only, say so in the subtitle and first screenshot

### R19-088 — Experiments: in-app course-library entry point on first open (3★+ share among users who open it); genuine free tier (track 1–3 habits forever) vs paywall-on-open (paid conversion and 30-day retention); Apple-billed IAP vs web checkout at the same price (refund, chargeback, 1★ share per cohort); refund-on-request within 30 days, no conditions (chargeback rate, review mean, ticket volume)

- **Where:** §10.4 Experiments worth running (verbatim table)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Experiment | Hypothesis | Success measure ; In-app course-library entry point on first open | Reviewers who see the content asset rate materially higher than those who see only the tracker | 3★+ share among users who open the library ≥1× ; Genuine free tier (track 1–3 habits forever) vs paywall-on-open | The 4 no-trial refusals (§6.4) represent a larger silent population | Paid conversion and 30-day retention vs current ; Apple-billed IAP vs web checkout, same price | Off-store billing is causing the dispute volume, not the price | Refund rate, chargeback rate, 1★ share per cohort ; Refund-on-request within 30 days, no conditions | Refund cost < dispute + reputation cost | Chargeback rate, review mean, support ticket volume
- **Direction for us:** research · **Report confidence:** experiments · **Generalisable:** yes
- **Canonical:** C142 Surface existing features where users look; C147 Let people use the product before they pay; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

## Audiences

### R19-017 — Thirteen accuse the product of deliberately targeting people with ADHD because they are less likely to complete a cancellation — 'preying on ADHDers they know may not remember to cancel'; 'Most ADHD apps understand the basics of ADHD and impulse control and will refund your money… They should change the name to UNWisey'; 'the ONE SINGLE EMAIL they sent confirming my purchase with no actual link… If you have actual ADHD, you understand why one singular email with no working links is a complete and total waste'; 'designed for people with ADHD to spend money but not to help them' (de); when your positioning is 'we help people who struggle to follow through', a friction-heavy cancellation flow is read as exploiting the exact deficit you claim to treat, and it is the accusation that gets regulators involved

- **Where:** §0.9 The ADHD accusation is a reputational and regulatory risk, not just an insult
- **This app does:** ADHD-positioned funnel with cancellation friction
- **User reaction:** 1★-burst
- **Magnitude:** 13 of 105 (12.38%, High-priority)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12692126207`, `12868620709`, `13003020356`, `13007286102`, `13111156410`, `13194035072`, `13280826420`, `13546645984`, `13754537415`, `13828678467`, `14087411464`, `14160038721`, `13671148757`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

## Markets and languages

### R19-041 — Ads run in Spanish but the app is English-only (cl reviewer)

- **Where:** §3.4 Spanish localisation — ads run in Spanish, the app is English-only
- **This app does:** localised ads, unlocalised app
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13710711149`
- **Canonical:** C027 Localise early — it unlocks revenue; C148 The paid product must deliver what the ads and onboarding demonstrate

### R19-061 — Storefronts: us 72 (68.57%, 1.444, 64 1★, 8 5★); ca 11 (1.182); de 4, gb 4, au 3, mx 2, nz 2, ch/cl/fr/it/ph/se/tr 1 each — all at exactly 1.000; only the US clears 50; thirteen of fourteen storefronts have a mean of exactly 1.000 and the US is higher only because it holds all eight 5★ — excluding the December burst the US mean is 1.000, identical to every other storefront

- **Where:** §8.1 Storefront table (all 14) (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Storefront | n | % of 105 | Mean ★ | 1★ | 5★ | First | Last | ≥50 (standalone) ; us | 72 | 68.57% | 1.444 | 64 | 8 | 2025-05-24 | 2026-06-08 | Yes ; ca | 11 | 10.48% | 1.182 | 10 | 0 | 2025-06-07 | 2026-08-07 | No ; de | 4 | 3.81% | 1.000 | 4 | 0 | 2025-09-07 | 2026-03-22 | No ; gb | 4 | 3.81% | 1.000 | 4 | 0 | 2025-09-13 | 2026-05-26 | No ; au | 3 | 2.86% | 1.000 | 3 | 0 | 2025-09-13 | 2026-04-03 | No ; mx | 2 | 1.90% | 1.000 | 2 | 0 | 2026-02-24 | 2026-03-05 | No ; nz | 2 | 1.90% | 1.000 | 2 | 0 | 2025-08-07 | 2026-06-21 | No ; ch | 1 | 0.95% | 1.000 | 1 | 0 | 2025-09-03 | — | No ; cl | 1 | 0.95% | 1.000 | 1 | 0 | 2026-02-04 | — | No ; fr | 1 | 0.95% | 1.000 | 1 | 0 | 2025-10-25 | — | No ; it | 1 | 0.95% | 1.000 | 1 | 0 | 2026-07-11 | — | No ; ph | 1 | 0.95% | 1.000 | 1 | 0 | 2026-02-20 | — | No ; se | 1 | 0.95% | 1.000 | 1 | 0 | 2026-02-05 | — | No ; tr | 1 | 0.95% | 1.000 | 1 | 0 | 2026-02-21 | — | No
- **Direction for us:** none · **Report confidence:** storefront table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R19-062 — US (n=72) theme rates: scam 58.3%, confirmed payer 59.7%, cancel hard 25.0%, refund refused 22.2%, billed post-cancel 19.4%, double billed 18.1%, support fail 18.1%, off-store 16.7%, unauthorised 15.3%, price high 15.3%, not as advertised 15.3%, ADHD targeting 13.9%, content thin 13.9%, e-book upsell 9.7%, low value 8.3%, legal escalation 6.9%, no custom plan 0.0%; the US profile is the global profile; the US carries all but one escalation and both competitor recommendations — where FTC and chargeback paths are named, the commercial risk concentrates

- **Where:** §8.2 United States — n = 72 (verbatim table); the US profile is the global profile
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | US n | US % | Signal (US) ; SCAM_LABEL | 42 | 58.3% | High-priority ; CONFIRMED_PAYER | 43 | 59.7% | High-priority ; CANCEL_HARD | 18 | 25.0% | High-priority ; REFUND_REFUSED | 16 | 22.2% | High-priority ; BILL_POST_CANCEL | 14 | 19.4% | High-priority ; BILL_DOUBLE | 13 | 18.1% | High-priority ; SUPPORT_FAIL | 13 | 18.1% | High-priority ; OFF_STORE | 12 | 16.7% | High-priority ; BILL_UNAUTH | 11 | 15.3% | High-priority ; PRICE_HIGH | 11 | 15.3% | High-priority ; NOT_AS_ADVERTISED | 11 | 15.3% | High-priority ; ADHD_TARGETING | 10 | 13.9% | High-priority ; CONTENT_THIN | 10 | 13.9% | High-priority ; EBOOK_UPSELL | 7 | 9.7% | High-priority ; LOW_VALUE_VS_FREE | 6 | 8.3% | High-priority ; LEGAL_ESCALATION | 5 | 6.9% | High-priority ; NO_CUSTOM_PLAN | 0 | 0.0% | —
- **Direction for us:** none · **Report confidence:** ≥50 storefront · **Generalisable:** app-specific
- **Canonical:** C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

### R19-063 — Canada (n=11): 3 of the 5 'promised a personalised plan' reviews are Canadian, and Canada contributes the only 3★ and the most constructive review; with n=11 three reviews is not a market difference — flagged for follow-up not action

- **Where:** §8.3 Canada — n = 11, limited evidence
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** n=11, mean 1.182
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `12748055966`, `12778540152`, `13194035072`, `13398540937`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate

### R19-064 — 'No personalised plan' is 0 of 72 in the US and 5 of 33 (15.2%) non-US (ca ×3, mx, gb); either the ad creative differs by market (the Chilean reviewer confirms ad language differs from app language) or a 5-review theme against 33 is noise — do not act without a larger non-US sample; other fragile US/non-US differences: non-US higher on low-value-vs-free (21.2 vs 8.3%), not-as-advertised (24.2 vs 15.3%), trial-mislead (15.2 vs 6.9%), unauthorised (24.2 vs 15.3%); US higher on content-thin, double billing, scam label (58.3 vs 45.5%)

- **Where:** §8.4 The one real geographic split — 'no personalised plan' (verbatim table)
- **This app does:** possible market-specific ad creative
- **User reaction:** 1★-burst
- **Magnitude:** Group | n | NO_CUSTOM_PLAN | Rate ; US | 72 | 0 | 0.0% ; Non-US | 33 | 5 | 15.2%
- **Direction for us:** research · **Report confidence:** fragile (n=33) · **Generalisable:** app-specific
- **Review IDs:** `13710711149`, `12748055966`, `12778540152`, `13194035072`, `13785381809`, `14107869084`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate

### R19-065 — High-spend markets present (us, ca, gb, de, fr, au) 95 (90.48%, mean 1.358) vs all others 10 (mean 1.000); Japan, China and South Korea contribute zero reviews because they were never queried — a distribution and extraction fact; the 1.358 is entirely a US artefact of the December burst; strip it and the high-spend group runs at 1.000 — there is no market in this corpus where this product is working

- **Where:** §8.5 High-spend markets (verbatim table) — every high-spend market behaves identically; JP/CN/KR never queried
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Group | n | % of 105 | Mean ★ ; High-spend markets present (us, ca, gb, de, fr, au) | 95 | 90.48% | 1.358 ; All other storefronts (mx, nz, ch, cl, it, ph, se, tr) | 10 | 9.52% | 1.000
- **Direction for us:** none · **Report confidence:** market table · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R19-066 — Storefronts ≥5% of corpus: us 72 (68.57%), ca 11 (10.48%) — a US corpus with a Canadian minority and eleven single-digit tails; review volume measures nothing except review volume

- **Where:** §8.6 High-review-volume markets (verbatim table)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Storefront | n | % of corpus ; us | 72 | 68.57% ; ca | 11 | 10.48%
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R19-067 — 'On Instagram it appears in Spanish and in this app everything is in English… tell me if there's a Spanish version and if not, refund the money' — a clean instance of the general pattern: the funnel promises something the product does not contain; two of the three non-English reviews (it, de) additionally complain the product is paywalled before it can be seen

- **Where:** §8.7 Localisation — the Instagram ad ran in Spanish; the product is English-only
- **This app does:** ads localised, product not
- **User reaction:** 1★-burst
- **Magnitude:** 1 of 105 (0.95%, Emerging) + 2 paywall complaints
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13710711149`, `14289131320`, `13650570635`
- **Canonical:** C027 Localise early — it unlocks revenue; C147 Let people use the product before they pay; C148 The paid product must deliver what the ads and onboarding demonstrate

## Dated events and trends

### R19-019 — Six escalated outside the store: credit-card dispute, bank fraud department + Apple, reporting to card issuer, 'Reported to FTC - Koflimin', bank dispute; one asks Apple directly: 'I recommend suspension from the App Store until they fix their subscription issues'

- **Where:** §0.9 Six escalated outside the store — banks, card networks, FTC, Apple
- **This app does:** disputes and regulator reports
- **User reaction:** 1★-burst
- **Magnitude:** 6 of 105 (5.71%, High-priority)
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13099305086`, `13259029152`, `13636589290`, `13675718331`, `13754537415`, `13926895274`, `14160038721`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request; C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

### R19-023 — Monthly review volume: 2025-05 2 · 06 12 · 07 9 · 08 8 · 09 12 · 10 10 · 11 8 · 12 11 · 2026-01 8 · 02 9 · 03 6 · 04 4 · 05 2 · 06 2 · 07 1 · 08 1 — the corpus collapses through 2026

- **Where:** §1.6 Monthly volume (verbatim table) — the collapse in 2026
- **This app does:** review flow dries up
- **User reaction:** none
- **Magnitude:** Month | n |  | Month | n ; 2025-05 | 2 |  | 2026-01 | 8 ; 2025-06 | 12 |  | 2026-02 | 9 ; 2025-07 | 9 |  | 2026-03 | 6 ; 2025-08 | 8 |  | 2026-04 | 4 ; 2025-09 | 12 |  | 2026-05 | 2 ; 2025-10 | 10 |  | 2026-06 | 2 ; 2025-11 | 8 |  | 2026-07 | 1 ; 2025-12 | 11 |  | 2026-08 | 1
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R19-055 — A consistent four-stage escalation: attempts to cancel (24 obstructed, 22.86%) → requests a refund (25 refused, 23.81%) → offered retention instead (5, 4.76%) → escalates outside the store (6, 5.71%); exactly one partial refund (50% offered after three emails, not yet received) and no full refund reported by anyone; terminal state: 'Reported to FTC… Edit: Confirmed scam. :)'

- **Where:** §6.5 Refund, churn and escalation path (verbatim table); no full refund reported by anyone
- **This app does:** cancel → refuse → retain → escalate
- **User reaction:** 1★-burst
- **Magnitude:** Stage | n | % of 105 | IDs (representative) ; 1. Attempts to cancel | 24 report obstruction | 22.86% | §0.6 ; 2. Requests a refund | 25 refused | 23.81% | §0.4 ; 3. Is offered retention instead | 5 | 4.76% | 12819961338 13772597437 13803171356 13921976046 13926895274 ; 4. Escalates outside the store | 6 | 5.71% | 13099305086 13259029152 13636589290 13675718331 13754537415 13926895274
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12819961338`, `13772597437`, `13803171356`, `13921976046`, `13926895274`, `13099305086`, `13259029152`, `13636589290`, `13675718331`, `13754537415`
- **Canonical:** C112 In-app cancellation; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R19-068 — Eras by date: E1 24 May–30 Sep 2025 n43 mean 1.000 (~10.2/month); E2 1 Oct 2025–31 Jan 2026 n37 mean 1.919 (~9.3/month); E3 1 Feb–7 Aug 2026 n25 mean 1.000 (~4.0/month); E2's 1.919 is produced entirely by the eight December 5★ — excluding them E2 is 29 reviews at 1.069; all era percentages are fragile (one E3 review = 4.0%)

- **Where:** §9.1 Method — era table (verbatim); E2's mean is produced entirely by the December burst
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Era | Window | n | Mean ★ | Reviews/month ; E1 | 24 May – 30 Sep 2025 | 43 | 1.000 | ~10.2 ; E2 | 1 Oct 2025 – 31 Jan 2026 | 37 | 1.919 | ~9.3 ; E3 | 1 Feb – 7 Aug 2026 | 25 | 1.000 | ~4.0
- **Direction for us:** none · **Report confidence:** era definition · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R19-069 — Persistent across E1/E2/E3: refund refused 25.6 / 16.2 / 32.0%; cancel hard 18.6 / 27.0 / 24.0%; billed post-cancel 16.3 / 21.6 / 16.0%; unauthorised 14.0 / 21.6 / 20.0%; off-store 20.9 / 8.1 / 24.0%; scam label 69.8 / 45.9 / 40.0% (declining share); nothing was fixed — the first review (19 days after launch) describes the two-subscription mechanism, the 14-day refund condition and the ADHD-targeting accusation; the last (441 days later) describes unresponsive support and post-trial charges

- **Where:** §9.2 What persisted, unchanged, across all sixteen months (verbatim table) — nothing was fixed
- **This app does:** no change over 16 months
- **User reaction:** 1★-burst
- **Magnitude:** Theme | E1 (n=43) | E2 (n=37) | E3 (n=25) | Verdict ; REFUND_REFUSED | 25.6% | 16.2% | 32.0% | Persistent ; CANCEL_HARD | 18.6% | 27.0% | 24.0% | Persistent ; BILL_POST_CANCEL | 16.3% | 21.6% | 16.0% | Persistent ; BILL_UNAUTH | 14.0% | 21.6% | 20.0% | Persistent ; OFF_STORE | 20.9% | 8.1% | 24.0% | Persistent ; SCAM_LABEL | 69.8% | 45.9% | 40.0% | Persistent, declining share
- **Direction for us:** dont · **Report confidence:** era series · **Generalisable:** app-specific
- **Review IDs:** `12692126207`, `14397733811`
- **Canonical:** C029 Billing must be exactly right; C071 Never ship and walk away

### R19-070 — Price-high rises 7.0% (3) → 18.9% (7) → 20.0% (5); reported amounts rise — E1 $15–$45, E2 introduces $59.99, $85, $99.99 and $100 cumulative, E3 has $98.50/month and $99 non-refundable; price increase or plan-mix shift cannot be determined, but the reviewer experience worsened either way

- **Where:** §9.3 Worsening — price shock (verbatim table)
- **This app does:** prices reported rising to ~$99
- **User reaction:** 1★-burst
- **Magnitude:** Theme | E1 | E2 | E3 ; PRICE_HIGH | 7.0% (3) | 18.9% (7) | 20.0% (5)
- **Direction for us:** none · **Report confidence:** era series (fragile) · **Generalisable:** app-specific
- **Review IDs:** `13803171356`, `13926895274`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R19-071 — Two themes appear only in the final era: support retention loop 2.3% / 0 / 16.0% (4) and discount ladder 0 / 0 / 12.0% (3); from Feb 2026 reviewers stop describing a refund refusal and start describing a negotiation — a bot, then a human, then a $1/month or $5-lifetime counter-offer, then a refusal; three ladder reports name three price points from three storefronts (tr, us, us); interpretation: a save-flow was added or intensified around late 2025/early 2026 and it is not saving customers — all four left 1★; social-ad mentions also rise (2.3 → 2.7 → 16.0%), consistent with a 2026 paid-acquisition push or more explicit reviewers — the corpus cannot distinguish

- **Where:** §9.4 Emerging in E3 — the retention machine (verbatim table)
- **This app does:** save-flow added ~early 2026
- **User reaction:** 1★-burst
- **Magnitude:** Theme | E1 | E2 | E3 | IDs ; SUPPORT_RETENTION_LOOP | 2.3% (1) | 0.0% (0) | 16.0% (4) | 13772597437 13803171356 13921976046 13926895274 ; DISCOUNT_LADDER | 0.0% (0) | 0.0% (0) | 12.0% (3) | 13772597437 13803171356 13926895274
- **Direction for us:** dont · **Report confidence:** era series (thin) · **Generalisable:** yes
- **Review IDs:** `13772597437`, `13803171356`, `13921976046`, `13926895274`
- **Canonical:** C180 No 'wait, don't go' exit discounts or countdown timers on the paywall; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R19-072 — E-book upsell 11.6% (5) → 13.5% (5) → 4.0% (1), last complaint 21 Feb 2026; content-thin 18.6% (8) → 5.4% (2) → 8.0% (2); the e-book decline is the only credible improvement signal and it is ambiguous — the mechanism may have been removed, or the buying population shrank to where nobody hits it

- **Where:** §9.5 Improving — two themes genuinely fade (verbatim table)
- **This app does:** e-book plan possibly removed
- **User reaction:** mixed
- **Magnitude:** Theme | E1 | E2 | E3 | Reading ; EBOOK_UPSELL | 11.6% (5) | 13.5% (5) | 4.0% (1) | The e-book second subscription draws its last complaint on 21 Feb 2026 (13772597437) ; CONTENT_THIN | 18.6% (8) | 5.4% (2) | 8.0% (2) | Complaints about the courses/videos fall away after E1
- **Direction for us:** none · **Report confidence:** era series (ambiguous) · **Generalisable:** app-specific
- **Review IDs:** `13772597437`
- **Canonical:** C211 No second, separately-cancelled add-on subscription

### R19-073 — Jun–Dec 2025 (7 months) 70 reviews; Jan–Mar 2026 (3 months) 23; Apr–Aug 2026 (5 months) 10 — monthly volume falls from ~10 to 2, 2, 1, 1; three explanations: acquisition spend cut, funnel moved further off-store so complaints land on Trustpilot and card issuers, or the product was fixed — the third is least consistent with the evidence (2026 reviews at exactly 1.000 from February on)

- **Where:** §9.6 The clearest trend of all: the corpus is drying up (verbatim table)
- **This app does:** review flow collapsing
- **User reaction:** none
- **Magnitude:** Period | Reviews ; Jun–Dec 2025 (7 months) | 70 ; Jan–Mar 2026 (3 months) | 23 ; Apr–Aug 2026 (5 months) | 10
- **Direction for us:** none · **Report confidence:** era series · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

## Positioning

### R19-001 — Wisey: Habit Builder (App Store ID 6742659386) — 'Form habits, change your life' — a habit tracker sold as part of a subscription 'programme' for adults who self-identify as having ADHD; the decision it informs is what a habit-tracking product can and cannot charge for, and what happens to a habit app when the acquisition funnel, not the tracker, is the business

- **Where:** header lines 1-10; §12.4 External sources
- **This app does:** developer KOFLIMIN LIMITED (artist 1621709984); bundle com.koflimin.limited.wisey.habitbuilder; sister apps Your Productive Self (4.08★, 877), Deep Focus (4.07★, 136), Simple Budget (3.03★, 29); US listing 3.45★ from 259 ratings; v1.1.1 released 1 Jul 2026, first released 5 May 2025; store rank 19
- **User reaction:** 1★-burst
- **Magnitude:** 105 written reviews, 14 storefronts, 24 May 2025 → 7 Aug 2026 (16 months); written mean 1.324
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R19-044 — Only two competitors, both named by departing payers as the better alternative: Fabulous ('much better'; folder 24 in this collection) and Triimo ('it actually works and customer service aren't trying to rob you') — in this category at this price point, trust is a feature people comparison-shop on

- **Where:** §3.5 Competitors named — Fabulous and Triimo; trust is a feature people comparison-shop on
- **This app does:** compared against Fabulous, Triimo
- **User reaction:** churn
- **Magnitude:** 2 of 105 (1.90%)
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12760145236`, `12863798573`
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R19-004 — Billing happens outside the App Store and that single architectural choice generates most of the corpus: the listing shows Premium $6.99 and $29.99 IAPs, but reviewers report $15, $17, $17.99, $19.99, $30, $34.99, $37, $45, $49.99, $50, $59.99, $60, $70, $85, $98.50, $99, $99.99 and cumulative $100, $136, 'hundreds' — almost none an App Store IAP; the developer's terms confirm two purchase pathways and that website purchases are non-refundable; 'The app is just a front, this is a web based program so your terms are hidden from you. It will not show in your subscriptions either'; 'intentionally funnel you outside appstore to their website so that you cant request refund'; everything downstream follows from billing happening somewhere Apple cannot see it

- **Where:** §0.1 The product being reviewed is a payment funnel, and the App Store app is its front door
- **This app does:** web checkout outside App Store; app is the front door
- **User reaction:** 1★-burst
- **Magnitude:** 18 of 105 (17.14%, High-priority) say the subscription does not appear in Apple subscriptions
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13417665753`, `13150104593`, `13366105778`, `13770028994`, `13926895274`, `13131008150`, `13716802092`, `12692126207`, `12731738911`, `12811553385`, `12821851615`, `12998276106`, `13099305086`, `13202910675`, `13435933779`, `13772597437`, `14087411464`, `14397733811`
- **Canonical:** C029 Billing must be exactly right; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel

### R19-005 — A second, separate subscription for e-books/workbooks/PDFs charged on top of the programme subscription with its own cancellation path — pays $15, clicks the e-book link, charged $17 'because they already have your info'; '$59.99/month for the app and another $45.00/month for some ebooks'; billed $45 then $17.99 minutes later; 'provides a link to PDFs that a third grader could create'; two reviewers on two continents five months apart describe the same asymmetry — cancelling the main plan succeeds, cancelling the e-book plan does not; corroborated by public Trustpilot complaints (pattern existence only)

- **Where:** §0.2 The second subscription: 11 reviewers describe being enrolled in an e-book plan they did not knowingly buy; table (verbatim)
- **This app does:** hidden add-on e-book subscription at $45/mo
- **User reaction:** 1★-burst
- **Magnitude:** 11 of 105 (10.48%, High-priority), five storefronts, 8 months apart; ID | CC | Date | What the reviewer describes ; 12692126207 | us | 2025-05-24 | Pays $15, gets an e-book link, clicking it charges $17 because "they already have your info"; no way to unsubscribe except email ; 12705617097 | us | 2025-05-27 | "They lock you in to purchasing additional material even when you declined it" ; 12821851615 | us | 2025-06-27 | "$59.99/month for the app and another $45.00/month for some ebooks" ; 12836726941 | us | 2025-06-30 | Billed $45, then "a few minutes later billed an additional $17.99" ; 12910430870 | us | 2025-07-19 | Cancelled the programme; "there was an ebook subscription that was not cancelled" → charged $45 ; 13251215774 | ca | 2025-10-11 | "billed for 'custom plan' AND 'e book plan' which I never signed up for" ; 13280826420 | ca | 2025-10-18 | Programme cancelled with one click; "the e-books subscription would not allow it" → billed 45 USD ; 13311158289 | fr | 2025-10-25 | "They hide price on the main page to trick you buying ebooks" ; 13546645984 | us | 2025-12-23 | "provides a link to PDFs that a third grader could create" ; 13636589290 | us | 2026-01-15 | "THEN there is 45 freaking dollars for ebooks?!!" ; 13772597437 | tr | 2026-02-21 | "After subscribing they immediately send you ebook which will cost you 45 $/month and they dont give any information about this beforhand"
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12692126207`, `12705617097`, `12821851615`, `12836726941`, `12910430870`, `13251215774`, `13280826420`, `13311158289`, `13546645984`, `13636589290`, `13772597437`
- **Canonical:** C029 Billing must be exactly right; C211 No second, separately-cancelled add-on subscription

### R19-013 — When a customer tries to leave they are offered a dramatically lower price — charged $98.50/month, offered lifetime for $49; charged $99 non-refundable, offered a $5 lifetime; subscription + $45/mo e-books, offered '$5 for lifetime, $1 per month' — and each reviewer draws the same conclusion: 'That is probably the real value of the service. I passed on that. I'm too mad to give them another dime'; a save-offer at 5% of the charged price converts a pricing objection into a fraud belief and costs the lifetime-value sale it was trying to protect; all three left 1★

- **Where:** §0.5 The discount ladder tells buyers the real price — 3 reviews; table (verbatim)
- **This app does:** save-offer at ~5% of charged price
- **User reaction:** 1★-burst
- **Magnitude:** 3 of 105 (2.86%, Meaningful); ID | Charged | Offered on cancellation ; 13772597437 (tr) | subscription + $45/mo e-books | "$5 for lifetime, 1 $ per month" ; 13803171356 (us) | $98.50/month | "lifetime subscription for $49 or $49.99" ; 13926895274 (us) | $99 non-refundable | "$5 'lifetime subscription'"
- **Direction for us:** dont · **Report confidence:** meaningful — most commercially instructive · **Generalisable:** yes
- **Review IDs:** `13772597437`, `13803171356`, `13926895274`
- **Canonical:** C180 No 'wait, don't go' exit discounts or countdown timers on the paywall; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R19-014 — Cancellation obstructed by five named, reproducible mechanics: (1) cancellation requires email, not a button ('several emails from the right email account 30 days in advance'); (2) visual weighting — 'the big bold items were to stay subscribed and the smaller was to cancel'; (3) confirmation-step attrition — 'about 10 are-you-sure items'; (4) split cancellation across two objects; (5) losing account access mid-cancellation — 'once you've started the cancellation process, you can no longer log onto the app to continue it'; 'Could not access the settings or account section for weeks' (de); two report the cancel control simply not working — a bug report inside a billing complaint and the cheapest thing to verify

- **Where:** §0.6 Cancellation is described as obstructed, with named dark patterns — 24 of 105
- **This app does:** email-only cancel, bold/small asymmetry, ~10 confirms, split cancel, lockout mid-flow
- **User reaction:** 1★-burst
- **Magnitude:** 24 of 105 (22.86%, High-priority)
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12692126207`, `12731738911`, `12811553385`, `12821851615`, `12910430870`, `12924114693`, `13099305086`, `13150104593`, `13241632109`, `13280826420`, `13282459076`, `13435933779`, `13546645984`, `13564772884`, `13597970945`, `13636589290`, `13679453387`, `13689727356`, `13716802092`, `13752060221`, `13772597437`, `13876370915`, `13926895274`, `14160038721`
- **Canonical:** C112 In-app cancellation; C213 If you position on ADHD or executive-function help, cancellation must be the easiest flow in the product

### R19-016 — Five paid specifically for a customised programme and received a blank habit tracker — 'They promised a customized plan to help. I received no such plan… expecting you to setup your own habits'; 'They promise a full program to help you and instead you pay for some useless little apps' (mx) — literally accurate: the subscription grants access to four separate thin Wisey apps rather than a programme; all five are non-US (3 ca, 1 mx, 1 gb) — 0 of 72 US reviews

- **Where:** §0.8 The promise that is not delivered: a personalised plan
- **This app does:** sells a personalised plan, delivers a blank tracker + thin app bundle
- **User reaction:** 1★-burst
- **Magnitude:** 5 of 105 (4.76%, Very strong); 0 of 72 US
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12748055966`, `12778540152`, `13194035072`, `13785381809`, `14107869084`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Things not to do

### R19-010 — A refund requires proving 14 days of consecutive use — 'you are NOT ALLOWED TO ASK FOR A REFUND until 14 days of activity on the app'; 'I used it for 2 days, and didnt like it'; the condition is impossible to satisfy when 'there is no plan' to follow

- **Where:** §0.4 (a) A refund requires proving you used the product — 6 of 105
- **This app does:** proof-of-use refund condition
- **User reaction:** 1★-burst
- **Magnitude:** 6 of 105 (5.71%, High-priority)
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `12692126207`, `12760145236`, `12778540152`, `12998276106`, `13117882072`, `13772597437`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R19-011 — A 30-day money-back guarantee was advertised and not honoured — 'Shortly they dont have money back guarantee'; no published guarantee page could be located (two candidate URLs 404), so the 14-day/30-day conditions rest on review evidence only

- **Where:** §0.4 (b) A 'money-back guarantee' that was advertised and then not honoured — 3 of 105
- **This app does:** advertised guarantee not honoured
- **User reaction:** 1★-burst
- **Magnitude:** 3 of 105 (2.86%, Meaningful); 6 + 3 reviewers across four storefronts
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12778540152`, `13675718331`, `13772597437`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R19-012 — Refund requests answered with retention offers instead of an answer — 'Their bot tried to convince me to stay on… Never did they address my refund until I continued to ask directly, in three different emails. Finally, a 50% refund was offered'; 'attempted to upsell me on a $5 lifetime subscription—which makes absolutely no sense given the $99 charge they're refusing to reverse'

- **Where:** §0.4 (c) Refund requests answered with retention offers instead — 5 of 105
- **This app does:** retention bot in place of refund handling
- **User reaction:** 1★-burst
- **Magnitude:** 5 of 105 (4.76%, Very strong)
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `12819961338`, `13772597437`, `13803171356`, `13921976046`, `13926895274`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R19-038 — One reviewer reports access terminated immediately on cancellation rather than at period end

- **Where:** §3.2 IMMEDIATE_TERMINATION — access cut the moment you cancel
- **This app does:** cancel = instant lockout
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `12933789910`
- **Canonical:** C193 When a trial or subscription ends, the user lands on a usable free tier with read-only history — never a cliff

### R19-075 — Collapse the e-book plan into the main subscription or delete it — the corpus's most specific and most repeated mechanism

- **Where:** §10.1 #2 Collapse the e-book plan into the main subscription, or delete it
- **This app does:** second hidden subscription
- **User reaction:** 1★-burst
- **Magnitude:** §0.2 (11)
- **Direction for us:** dont · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `12910430870`, `13280826420`
- **Canonical:** C211 No second, separately-cancelled add-on subscription

### R19-081 — Retire the discount ladder — replace a $5-lifetime save-offer against a $99 charge with a plain refund or a pause; the offer is teaching customers that the list price is a 20× markup, in public, in writing

- **Where:** §10.1 #8 Retire the discount ladder
- **This app does:** save-offer at 5% of list
- **User reaction:** 1★-burst
- **Magnitude:** §0.5 (3)
- **Direction for us:** dont · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `13803171356`
- **Canonical:** C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

### R19-086 — Every gap between funnel and product — a personalised plan that was an empty tracker, a Spanish ad for an English-only app, a programme that was four thin apps — was created by marketing and paid for by the product's rating

- **Where:** §10.2 e. Do not let the funnel promise what the product does not contain
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 5 + 1 + several
- **Direction for us:** dont · **Report confidence:** transferable · **Generalisable:** yes
- **Review IDs:** `12748055966`, `13710711149`, `13785381809`
- **Canonical:** C148 The paid product must deliver what the ads and onboarding demonstrate; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

## Things to do

### R19-087 — The tracker is a commodity, the course library is the differentiated asset, and the app never mentions the library exists — every reviewer who called the product 'just a checklist' may have been describing the 10% of the product they were shown; the action is a one-screen change: surface the course library on first open with a link, as the only constructive reviewer literally requests

- **Where:** §10.3 The one product opportunity in the corpus — surface the course library from the app's first open
- **This app does:** differentiated asset hidden from the app
- **User reaction:** mixed
- **Magnitude:** n=1 constructive reviewer vs 13 'just a checklist'
- **Direction for us:** do · **Report confidence:** single-source opportunity · **Generalisable:** yes
- **Review IDs:** `13398540937`
- **Canonical:** C142 Surface existing features where users look

## Data caveats and method

### R19-002 — Method: 105 records, every one hand-coded from a full read in original language — no sampling, classifier or clustering; the corpus is 91.43% one-star (96 1★, 8 5★, 1 3★, zero 2★ and 4★) — a distribution with no middle, so it is a dispute record not a satisfaction survey; the public rating is 2.13 stars above what people write (3.45★ from 259 vs 1.324 written; 105 of 259 carry text); the dominant subject is not the app — 75 of 105 (71.43%) raise billing/pricing/cancellation/refund and only 10 (9.52%) report a functional defect; all eight 5★ were posted in one nine-day window 23–31 Dec 2025, all US, 44–74 chars — evidence of uncertain provenance; signal bands <0.1 ignore … >5% high-priority

- **Where:** How to read this; Five things to know; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Limitations and judgement calls; §12.1 counting rules; §12.3 method audit trail
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 105/105 read; denominator 105 non-exclusive; 14 storefronts; 16 months
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R19-008 — One reviewer states that after blocking the card, charges appeared on other payment methods carrying their name, including an account belonging to a six-year-old child with a genetic disorder for whom they are guardian, totalling 'HUNDREDS OF DOLLARS' — a single review (0.95%), uncorroborated within the corpus, surfaced under the safety exception, not as a quantified pattern

- **Where:** §0.3 One case is materially more serious than the rest — surfaced under the safety exception
- **This app does:** alleged charges to other payment methods
- **User reaction:** 1★-burst
- **Magnitude:** n=1 (0.95%), safety exception
- **Direction for us:** none · **Report confidence:** single uncorroborated · **Generalisable:** app-specific
- **Review IDs:** `13636589290`
- **Canonical:** — (nuance register)

### R19-021 — Nine storefronts queried returned zero (hk nl no ae co ua my cr ec); no Japanese, Korean or Chinese storefront was queried at all; only the US (n=72) clears the 50-review bar; 'confirmed payer' requires a first-person statement — three strongly implied payers are coded INFERRED_PAYER and excluded from the 64-payer denominator; amounts are as reported, currency often unstated, none converted; reviews reflect the reviewer's understanding — several 'charged without consent' reports are consistent with a trial that auto-converted per unread terms

- **Where:** §1.3 Storefronts queried that returned zero reviews; §1.5 Only one storefront clears the 50-review bar; §1.5 Confirmed payer is a conservative judgement
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 9 zero storefronts; 3 inferred payers excluded; 63 theme codes
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `12874978864`, `13202910675`, `13754537415`, `13280826420`, `13369386593`
- **Canonical:** — (nuance register)

### R19-022 — Corpus: 105 reviews, 14 storefronts, 24 May 2025 → 7 Aug 2026; the first review lands 19 days after the 5 May 2025 launch; mean 1.324; 1★ 96 (91.43%) · 3★ 1 · 5★ 8 (7.62%); 1 edited; 8 with any upvote, max vote_sum 5 on 'Scam'; 3 non-English (de, es/cl, it); mean body 284.2 chars for 1★ (median 197) vs 57.1 for 5★

- **Where:** §1.6 Corpus composition (verbatim table)
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Dimension | Value ; Reviews | 105 ; Storefronts | 14 ; Date range | 24 May 2025 → 7 Aug 2026 ; App release date | 5 May 2025 (external) — the first review lands 19 days after launch ; Mean rating (written) | 1.324 ; Rating distribution | 1★ 96 (91.43%) · 2★ 0 · 3★ 1 (0.95%) · 4★ 0 · 5★ 8 (7.62%) ; Edited reviews | 1 (13754537415) ; Reviews with any upvote | 8 of 105; maximum vote_sum = 5 (12692126207, "Scam") ; Non-English reviews | 3 — 13650570635 (de), 13710711149 (es/cl), 14289131320 (it). All read in the original. ; Mean body length, 1★ | 284.2 chars (median 197) ; Mean body length, 5★ | 57.1 chars
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `13754537415`, `12692126207`, `13650570635`, `13710711149`, `14289131320`
- **Canonical:** — (nuance register)

### R19-033 — Negative themes (n/105): SCAM_LABEL 57 (54.29%) — the corpus's default vocabulary; REFUND_REFUSED 25; CANCEL_HARD 24; NOT_AS_ADVERTISED 19; BILL_POST_CANCEL 19; BILL_UNAUTH 19; OFF_STORE 18; SUPPORT_FAIL 17; BILL_DOUBLE 16 (15.24%); PRICE_HIGH 15 (14.29%) — nobody defends the price; ADHD_TARGETING 13; LOW_VALUE_VS_FREE 13; CONTENT_THIN 12 (11.43%); EBOOK_UPSELL 11; TRIAL_MISLEAD 10 (9.52%); UX_POOR 7; APP_THIN 7; REFUND_14DAY 6; SOCIAL_AD 6; LEGAL_ESCALATION 6; ENTITLEMENT_FAIL 5; NO_CUSTOM_PLAN 5; SUPPORT_RETENTION_LOOP 5; FINE_PRINT 5; DARK_PATTERN 5; TRUST_LOW 4; RECEIPT_MISSING 4; PRICE_MISMATCH 3; MONEYBACK_BROKEN 3; PAYWALL_UPFRONT 3; PRICE_OPACITY 3; RENEWAL_SURPRISE 3; DISCOUNT_LADDER 3; NO_TRIAL 3; ONBOARDING_GAP 2; BUG_CANCEL_FORM 2; ENGAGEMENT_LOW 2; ALT_APP_NAMED 2; plus 14 emerging singletons

- **Where:** §3.2 Prioritised negative themes (verbatim table, 38 rows)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** # | Theme | n | % | Signal | One-line reading ; 1 | SCAM_LABEL — reviewer uses the word scam / fraud / crooks / stealing | 57 | 54.29% | High-priority | The corpus's default vocabulary, not a fringe reaction ; 2 | REFUND_REFUSED | 25 | 23.81% | High-priority | §0.4 ; 3 | CANCEL_HARD | 24 | 22.86% | High-priority | §0.6 — five named mechanics ; 4 | NOT_AS_ADVERTISED | 19 | 18.10% | High-priority | Gap between the ad and the app ; 5 | BILL_POST_CANCEL | 19 | 18.10% | High-priority | §0.3a ; 6 | BILL_UNAUTH | 19 | 18.10% | High-priority | §0.3b ; 7 | OFF_STORE — not an App Store subscription | 18 | 17.14% | High-priority | §0.1, the root cause ; 8 | SUPPORT_FAIL | 17 | 16.19% | High-priority | §7.1 ; 9 | BILL_DOUBLE — two or more charges for one purchase | 16 | 15.24% | High-priority | §0.2 ; 10 | PRICE_HIGH | 15 | 14.29% | High-priority | Nobody defends the price ; 11 | ADHD_TARGETING | 13 | 12.38% | High-priority | §0.9 ; 12 | LOW_VALUE_VS_FREE | 13 | 12.38% | High-priority | §0.7 — the product ceiling ; 13 | CONTENT_THIN | 12 | 11.43% | High-priority | Courses/videos/PDFs judged worthless ; 14 | EBOOK_UPSELL | 11 | 10.48% | High-priority | §0.2 ; 15 | TRIAL_MISLEAD | 10 | 9.52% | High-priority | "Free trial" that charged ; 16 | UX_POOR | 7 | 6.67% | High-priority | Outdated, sloppy, confusing ; 17 | APP_THIN | 7 | 6.67% | High-priority | "Rudimentary", "little apps" ; 18 | REFUND_14DAY | 6 | 5.71% | High-priority | Refund requires proof of use ; 19 | SOCIAL_AD | 6 | 5.71% | High-priority | IG / YouTube acquisition named ; 20 | LEGAL_ESCALATION | 6 | 5.71% | High-priority | FTC, banks, chargebacks ; 21 | ENTITLEMENT_FAIL — paid but cannot access | 5 | 4.76% | Very strong | §7.2 ; 22 | NO_CUSTOM_PLAN | 5 | 4.76% | Very strong | §0.8 ; 23 | SUPPORT_RETENTION_LOOP | 5 | 4.76% | Very strong | §0.4c ; 24 | FINE_PRINT | 5 | 4.76% | Very strong | Terms found only after charging ; 25 | DARK_PATTERN | 5 | 4.76% | Very strong | §0.6 ; 26 | TRUST_LOW — distrusts the company as an entity | 4 | 3.81% | Very strong | Beyond product dissatisfaction ; 27 | RECEIPT_MISSING — no confirmation, no record | 4 | 3.81% | Very strong | §7.3 ; 28 | PRICE_MISMATCH — charged ≠ agreed | 3 | 2.86% | Meaningful | 12742285860 13248498967 13803171356 ; 29 | MONEYBACK_BROKEN | 3 | 2.86% | Meaningful | §0.4b ; 30 | PAYWALL_UPFRONT | 3 | 2.86% | Meaningful | §2.2 ; 31 | PRICE_OPACITY — price not visible at decision time | 3 | 2.86% | Meaningful | 13311158289 13742636617 13772597437 ; 32 | RENEWAL_SURPRISE — no renewal warning | 3 | 2.86% | Meaningful | 13716802092 13803171356 13921976046 ; 33 | DISCOUNT_LADDER | 3 | 2.86% | Meaningful | §0.5 ; 34 | NO_TRIAL | 3 | 2.86% | Meaningful | §2.2 ; 35 | ONBOARDING_GAP | 2 | 1.90% | Meaningful | 13150371570 14087411464 ; 36 | BUG_CANCEL_FORM | 2 | 1.90% | Meaningful | 13689727356 13772597437 ; 37 | ENGAGEMENT_LOW — "I forgot I had it" | 2 | 1.90% | Meaningful | 13921976046 14087411464 ; 38 | ALT_APP_NAMED — names a competitor to use instead | 2 | 1.90% | Meaningful | §3.5
- **Direction for us:** none · **Report confidence:** theme table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R19-037 — Fourteen singletons retained: feature backlog (back-dating), login bug (error 300), freeze, account-access bug, immediate termination on cancel, AI content, upsell bombardment, localisation (Spanish ads, English app), discovery gap (web portal), ineffective, partial refund, severe harm, jurisdiction note, funnel critique

- **Where:** §3.2 Emerging-signal singletons retained because each names a specific fixable thing
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 14 × 0.95%
- **Direction for us:** none · **Report confidence:** emerging · **Generalisable:** app-specific
- **Review IDs:** `12915336789`, `13258914566`, `13816735964`, `13876370915`, `12933789910`, `13675718331`, `13381915569`, `13710711149`, `13398540937`, `13117882072`, `13921976046`, `13636589290`, `13689727356`, `13975889341`
- **Canonical:** — (nuance register)

### R19-045 — 5★ 8 (7.62%, 57 chars) · 4★ 0 · 3★ 1 (372 chars) · 2★ 0 · 1★ 96 (91.43%, 284 chars); a healthy product produces a 4★ band of people who like it with reservations and a 2★ band of disappointed-not-betrayed — both are entirely empty; the shape you get when the review population is (a) people in a billing dispute and (b) something else

- **Where:** §4.1 The distribution has no middle (verbatim table)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Stars | n | % of 105 | Mean body length ; 5★ | 8 | 7.62% | 57 chars ; 4★ | 0 | 0.00% | — ; 3★ | 1 | 0.95% | 372 chars ; 2★ | 0 | 0.00% | — ; 1★ | 96 | 91.43% | 284 chars
- **Direction for us:** none · **Report confidence:** rating band · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R19-048 — All eight 5★ in full: 'Didn't expect much at first, but it's grown on me'; 'feels more human'; 'Simple; calm, and consistent'; 'Helps me stay consistent with my daily habits and reminders'; 'really helped me form good routines'; 'Widgets on the home screen make logging habits so quick'; 'Simple and effective habit builder—highly recọmmend'; 'Perfect tool for building positive habits' — only two name a capability (reminders, widget); none mentions price, subscription, cancellation, courses, e-books, the web portal or a personalised plan

- **Where:** §4.4 What drives 5★ — n = 8 (verbatim table)
- **This app does:** n/a
- **User reaction:** 5★-burst
- **Magnitude:** ID | Date | Title | Body ; 13545315131 | 23 Dec 2025 | Cool | "Didn't expect much at first, but it's grown on me over time." ; 13549237052 | 24 Dec 2025 | Awesome app | "I've tried a lot of habit apps, and this one feels more human." ; 13552347079 | 25 Dec 2025 | Great app | "Simple; calm, and consistent. That's what keeps me using it." ; 13568090356 | 29 Dec 2025 | love app | "Love this app! Helps me stay consistent with my daily habits and reminders" ; 13568431568 | 29 Dec 2025 | Easy | "This app really helped me form good routines" ; 13571866718 | 30 Dec 2025 | So good | "Widgets on the home screen make logging habits so quick" ; 13572140998 | 30 Dec 2025 | ok | "Simple and effective habit builder—highly recọmmend" ; 13576146958 | 31 Dec 2025 | Great app | "Perfect tool for building positive habits over time"
- **Direction for us:** none · **Report confidence:** rating band · **Generalisable:** app-specific
- **Review IDs:** `13545315131`, `13549237052`, `13552347079`, `13568090356`, `13568431568`, `13571866718`, `13572140998`, `13576146958`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R19-049 — The 5★ band: all 8 in 23–31 Dec 2025 (9 days of 441), the only 5★ in 16 months, all US, 44–74 chars vs 1★ mean 284, all posted 07:01–13:00 UTC, generic register with 5 of 8 lacking terminal punctuation, Firstname-Lastname handles with no repeats, and one homoglyph ('recọmmend', U+1ECD — the only non-Latin-1 character in any English review; a documented duplicate-detection evasion technique); two 1★ fall in the same window so the store was accepting negatives; organic vs inorganic — the pattern fits inorganic substantially better but the report does not assert inauthenticity; what would settle it: Apple's integrity signals, same handles on other Koflimin apps, dated clusters on the sister apps; every positive finding is stated with and without the burst — excluding it the corpus is 97 reviews at mean 1.021 with three positive statements

- **Where:** Part 5 §5.1 What is observable (verbatim table); §5.2 The two explanations, and what would settle it
- **This app does:** possible purchased review burst
- **User reaction:** 5★-burst
- **Magnitude:** Observation | Detail ; Time window | All 8 fall between 23 and 31 December 2025 — a 9-day span inside a 441-day corpus ; Exclusivity | These are the only 5★ reviews in 16 months; there is no other 5★ before or after ; Storefront | 8 of 8 are US ; Length | 44–74 characters (mean 57.1) vs a 1★ mean of 284.2 and median of 197 ; Posting hour (UTC) | 6 of 8 fall in a 07:01–11:18 band; the other two at 08:47 and 09:08 — all 8 within 07:01–13:00 ; Register | Generic category praise ("Great app", "So good", "ok"); 5 of 8 end without terminal punctuation ; Author handles | Firstname-Lastname / Lastname_Firstname forms with no repeats: "Zhang Tran", "Jaramillo Rex", "Mercier Tyra", "OlsonSharane", "hinson jeanmarie", "Krystina Fitzpatrick", "marybelle_bordersm", "Cabral_Geniaf" ; Character anomaly | 13572140998 spells "recommend" as "recọmmend" using U+1ECD, Latin small letter o with dot below. It is the only non-Latin-1 character in any English-language review in the corpus. Homoglyph substitution of this kind is a documented technique for evading duplicate-text detection. ; Context | The same 9-day window also contains two 1★ reviews (13546645984, 13564772884), so the window is not a period when the store was only accepting positive reviews ; excluding burst: 97 reviews, mean 1.021
- **Direction for us:** dont · **Report confidence:** unresolved provenance · **Generalisable:** yes
- **Review IDs:** `13572140998`, `13546645984`, `13564772884`
- **Canonical:** C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R19-089 — Research questions: (1) are the eight December 5★ organic — every positive finding is contingent; (2) the actual refund rate; (3) do App Store IAP buyers ($6.99/$29.99) complain at all — not one of 105 clearly identifies as Apple-billed, and if the IAP cohort is quiet that alone settles recommendation 1; (4) did the price rise or the plan mix shift; (5) why review volume collapsed in 2026 H1; (6) does the ad creative differ by market

- **Where:** §10.5 Research questions this corpus cannot answer; part 10 #1; part 10 #2; part 10 #3; part 10 #4; part 10 #5; part 10 #6
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 6 questions
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** yes
- **Canonical:** — (nuance register)
