# Cards — report 18

Source: `App Store Reports/18. MyRoutine - Organize your day - Built around your real life (REPORT).md`  
161 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 11
- [Must-haves](#must-haves) — 6
- [Must never break](#must-never-break) — 12
- [Features](#features) — 49
- [Monetization](#monetization) — 12
- [Tactics the app used](#tactics-the-app-used) — 3
- [Insights (the why)](#insights-the-why) — 19
- [Audiences](#audiences) — 6
- [Markets and languages](#markets-and-languages) — 11
- [Dated events and trends](#dated-events-and-trends) — 11
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 6
- [Things not to do](#things-not-to-do) — 2
- [Things to do](#things-to-do) — 3
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 7

## Product rules

### R18-004 — The paywall does not gate advanced features — it gates marking a habit done, the one action the product exists to perform; tapping 'achieve/complete' produces a purchase sheet instead of a check mark; 'the free version can't even check things off… then it isn't a routine app at all' (rated 5★ deliberately so more people see it); 'You can write habits down. You just can't complete them. You write them and get alarms'; final KR review in corpus: habits 1–6 check fine, the 7th throws a purchase sheet — 'I was 90% ready to buy… I just lost all feeling for it and deleted it'; called 'Predatory dark pattern' (AU) and 'an unscrupulous method' (JP)

- **Where:** §0.2 The single most consequential mechanic in the corpus: the free tier blocks the check-off button
- **This app does:** free tier blocks the check-off / completion action
- **User reaction:** 1★-burst
- **Magnitude:** 139 reviews (6.79%, high-priority, mean 2.32★)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `13977781381`, `13666442337`, `14517754076`, `12576858445`, `13534993454`, `14484116611`, `12495446710`, `13894901307`, `14393820099`, `14261275910`, `14468573022`, `13868908368`, `13894400612`, `14065497753`, `14047366673`, `14068889624`, `12036038200`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C147 Let people use the product before they pay; C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R18-018 — Across five years, three languages and dozens of reviewers the argument is uniform — monetise new capability, don't confiscate old capability: 'take back what you gave and people resent it'; 'blocking features existing members were using well and charging for them, or forcing people to Pro by shrinking features, is wrong… it may work short-term but long-term I doubt it'

- **Where:** §0.5 The argument users make is remarkably uniform: monetise new capability, don't confiscate old capability
- **This app does:** confiscation-led monetisation
- **User reaction:** complaint
- **Magnitude:** 8 named IDs stating the principle
- **Direction for us:** product-rule · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `10656234239`, `10729003648`, `10737428561`, `10773481361`, `10904269033`, `10987139394`, `11646296464`, `13496310680`
- **Canonical:** C001 Never move a free feature behind the paywall; C133 Gate on capability, not on quantity

### R18-035 — Motivation intensity must be dial-able in both directions as a per-user setting — the threshold already is configurable; the streak, the shield, the light itself and the cheer messages are not

- **Where:** §0.9 Conclusion: motivation intensity is not a product decision, it is a per-user setting
- **This app does:** threshold configurable; streak/shield/light/cheers not
- **User reaction:** mixed
- **Magnitude:** synthesis of §0.9 (17 IDs)
- **Direction for us:** product-rule · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `13842532454`, `13260473006`, `12424534015`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R18-105 — Feature removal after purchase — desktop, Challenge, merged view — and one told mid-term to buy a new plan after a July 2026 update

- **Where:** §5.4 #3 Feature removal after purchase
- **This app does:** removes purchased features; forces new plan mid-term
- **User reaction:** churn
- **Magnitude:** 5 named IDs
- **Direction for us:** product-rule · **Report confidence:** ordered by trust breach · **Generalisable:** yes
- **Review IDs:** `9513306665`, `11752441594`, `11727453236`, `11714930552`, `14312836653`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace; C186 Never revoke what earlier buyers paid for when the model changes

### R18-138 — Stop metering completions — cap habits if you must, never cap check-offs; a habit tracker that refuses to record a completion on day 3–6 is demonstrating that it does not work to a user currently deciding whether it works

- **Where:** §9.1 I1. Stop metering completions
- **This app does:** meters completions on the free tier
- **User reaction:** 1★-burst
- **Magnitude:** 139 reviews (6.79%, mean 2.32★); 19.6% of all 1★; most explicit lost sale ('90% ready to buy')
- **Direction for us:** product-rule · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14517754076`, `14393820099`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R18-139 — Show one price per plan per storefront; never surface a discount to someone who has just paid — if a cheaper offer exists, apply it; make the refund path reachable in-app

- **Where:** §9.1 I2. Show one price per plan per storefront
- **This app does:** 4–5 concurrent prices per plan; discount shown post-purchase; refund path dead-ends
- **User reaction:** 1★-burst
- **Magnitude:** 144 billing disputes; fraud accusations in six languages
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14143250366`, `11881028381`, `13994502099`
- **Canonical:** C112 In-app cancellation; C113 One stable, disclosed price — no discount wheels

### R18-143 — Label paid features before use and never destroy user work at the paywall — two users each spent an hour building routines, paid to save them, and lost the work anyway; two were paywalled on features documented as free

- **Where:** §9.1 I6. Label paid features before use, and never destroy user work at the paywall
- **This app does:** paywall after work is done; work lost
- **User reaction:** 1★-burst
- **Magnitude:** 4 named IDs
- **Direction for us:** product-rule · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `12433476315`, `12536725596`, `12350930181`, `13894400612`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C204 Never destroy user work at the paywall; label paid features before they are used

### R18-144 — Move to an 'unlimited free core, paid depth' model — monetise new capability, not existing capability; the corpus already names what people will pay for: export, statistics with trend, routine modes, timer with time tracking, Apple Watch parity, themes, web/Mac — every one additive

- **Where:** §9.2 M1. Move to an 'unlimited free core, paid depth' model
- **This app does:** confiscation model
- **User reaction:** mixed
- **Magnitude:** five years of reviews in three languages; §5.5 backlog
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `10729003648`, `13587898854`, `13064048672`
- **Canonical:** C001 Never move a free feature behind the paywall; C133 Gate on capability, not on quantity

### R18-145 — Ship a genuine, permanent free tier and say so on the listing — the reviews that convert best are from people who used the app free for a week or a month first; the reviews that generate refund demands are from people charged before they could evaluate; the current arrangement optimises for the second

- **Where:** §9.2 M2. Ship a genuine, permanent free tier and say so on the listing
- **This app does:** trial-first, evaluate-later
- **User reaction:** blocked-conversion
- **Magnitude:** 3 conversion IDs vs 11 charged-before-evaluation IDs
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `8363704388`, `8961449067`, `10995640730`
- **Canonical:** C147 Let people use the product before they pay; C181 If the app is paid-only, say so in the subtitle and first screenshot; C192 A trial must end in a usable free tier, not a cliff

### R18-147 — Stop marketing to people who have already paid — remove the promo bar, the Dynamic Island countdown and the annual-upsell nag for anyone with an active plan; 'a pro member should be a pro member regardless of whether they are paying monthly or yearly'

- **Where:** §9.2 M4. Stop marketing to people who have already paid
- **This app does:** upsells active subscribers
- **User reaction:** complaint
- **Magnitude:** 4 named IDs (§5.4 #5); promo-nag 40 (1.95%, 2.40★)
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13492813619`, `12862293051`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C127 Never show ads to paying subscribers

### R18-154 — Per-user toggles for streak display, the shield, the traffic light itself and cheer-message frequency; default the shield to off

- **Where:** §9.3 P6. Make the motivation system configurable in both directions
- **This app does:** streak/shield/light/cheers not configurable
- **User reaction:** mixed
- **Magnitude:** §0.9: 17 IDs
- **Direction for us:** product-rule · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13842532454`, `13260473006`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

## Must-haves

### R18-059 — Sign-up / login required or broken is a very strong signal at 3.13★

- **Where:** §3.1 Sign-up / login required or broken
- **This app does:** mandatory account; login failures
- **User reaction:** complaint
- **Magnitude:** 70 (3.42%, very strong, mean 3.13★, 18 1★)
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C035 Account system from day one; C209 No sign-up wall before first use

### R18-063 — Support unreachable / unanswered is meaningful at 2.72★; the worst case waited over a week with no acknowledgement

- **Where:** §3.1 Support unreachable / unanswered
- **This app does:** support silent
- **User reaction:** churn
- **Magnitude:** 32 (1.56%, meaningful, mean 2.72★, 15 1★)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14238803827`, `14248568509`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R18-103 — A sign-up wall before any trial — JP required email + phone + real name

- **Where:** §5.3 #7 Sign-up wall before any trial
- **This app does:** mandatory sign-up first
- **User reaction:** blocked-conversion
- **Magnitude:** 5 named IDs (kr, us, jp, gb); theme 70 (3.42%)
- **Direction for us:** must-have · **Report confidence:** ranked #7 · **Generalisable:** yes
- **Review IDs:** `8258577524`, `10178633937`, `9088458031`, `12549047166`, `14379439679`
- **Canonical:** C209 No sign-up wall before first use

### R18-108 — Support silence lands hardest on payers (a week of silence on a lifetime account; TW refund flow is a dead end; HK 'can't find contact details'); the Japanese in-app feedback form is itself broken — dark-mode text invisible and every valid email rejected as malformed, so Japanese users can only file a bug through the App Store

- **Where:** §5.4 #6 Support silence — lands hardest on payers; the Japanese in-app feedback form is itself broken
- **This app does:** support unreachable; JP feedback form broken
- **User reaction:** churn
- **Magnitude:** 32 (1.56%, mean 2.72★); 3 IDs for the broken JP form
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14238803827`, `14248568509`, `14338132758`, `13837162309`, `14007691344`, `12955157658`, `14258618311`, `14429093675`, `13757721182`, `13576075338`, `13712167027`
- **Canonical:** C027 Localise early — it unlocks revenue; C036 A support channel that exists, is reachable outside the app, and answers

### R18-141 — Never re-run onboarding on an existing or paying account, and add a skip button — a Pro subscriber forced back through the questionnaire and a lifetime buyer whose data was replaced by two survey-chosen routines are the same defect

- **Where:** §9.1 I4. Never re-run onboarding on an existing or paying account, and add a skip button
- **This app does:** onboarding re-runs; no skip
- **User reaction:** churn
- **Magnitude:** onboarding theme mean 2.03★ (lowest)
- **Direction for us:** must-have · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14437815273`, `14238803827`
- **Canonical:** C075 Skippable, replayable onboarding tour; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R18-157 — Let users hide what they don't use — complexity is high-priority in all three eligible storefronts (KR 6.75%, JP 10.76%, US 8.33%) and rising as features accumulate; an ADHD user asks to hide social, recommendations, to-do, diary and streaks; another asks them explicitly not to add more

- **Where:** §9.3 P9. Let users hide what they don't use
- **This app does:** no way to hide surfaces
- **User reaction:** complaint
- **Magnitude:** complexity 149 (7.28%); KR 6.75 / JP 10.76 / US 8.33%
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13842532454`, `11064706172`
- **Canonical:** C006 Stay minimal and ad-free; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

## Must never break

### R18-007 — The trial converts, or appears to convert, immediately — 'isn't this deception?'; asked for monthly, charged annual; 'in my case there was no free period' (jp); app frozen since minute 10, still charged a full year (id); reproduced in KR, JP, TW, ID, BR, DE

- **Where:** §0.4 (a) Charged before they could evaluate
- **This app does:** trial charges before evaluation is possible
- **User reaction:** 1★-burst
- **Magnitude:** 11 named IDs across 6 storefronts inside the 144-review billing theme
- **Direction for us:** must-never-break · **Report confidence:** high-priority (within billing theme) · **Generalisable:** yes
- **Review IDs:** `10402774146`, `10504712330`, `10656594581`, `10665782696`, `10808234292`, `13735625152`, `13997904350`, `14196174434`, `12806633553`, `11785990316`, `13751955979`
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial

### R18-008 — Entitlement failures — the purchase succeeded and the app still demands payment: ₩33,000 annual still capped at 8 routines; lifetime buyers denied Pro; ¥8,890 lifetime paid via PayPay never applied; subscription active in iOS settings, premium unusable; a TW lifetime holder accidentally bought an annual, cancelled it, and the lifetime entitlement was deleted too

- **Where:** §0.4 (b) Paid and then locked out
- **This app does:** entitlement not applied after successful purchase; cancelling one plan deletes another
- **User reaction:** churn
- **Magnitude:** 25 reviews (1.22%, meaningful, mean 2.44★); 9.94% of confirmed payers (16 of 161)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14201976473`, `14183433420`, `14171622208`, `14442984779`, `14486310873`, `14133850956`, `11032526889`, `10682135962`, `9962008254`, `11902546307`, `12068983875`, `11854385750`, `12777592140`, `14247429732`, `14031409160`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R18-009 — A lifetime buyer (¥6,890) lost power mid-session; on restart the app reset to onboarding, deleted every routine and all five routine modes, then demanded a Pro subscription; support e-mailed with purchase screenshots did not reply for over a week, including to a follow-up asking merely whether the case was open — 'Please don't turn the app I loved into the app I hate'; the clearest statement of how the product loses its best customers

- **Where:** §0.4 The worst single case in the corpus
- **This app does:** state reset + entitlement loss + silent support
- **User reaction:** churn
- **Magnitude:** n=1 posted twice (jp, 1★, Jun–Jul 2026)
- **Direction for us:** must-never-break · **Report confidence:** single case, exceptional · **Generalisable:** yes
- **Review IDs:** `14238803827`, `14248568509`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C034 Data must never be lost on update, reinstall or phone change; C036 A support channel that exists, is reachable outside the app, and answers

### R18-036 — Among 161 confirmed payers (7.86%, mean 3.53★) theme rates are materially worse than global on the things that destroy trust in a record-keeping product: entitlement failure 9.94% vs 1.22%; data loss 12.42% vs 6.01%; trial/billing 14.29% vs 7.03%; cross-device/web/Mac sync 6.21% vs 2.69%; order/future-date edit restriction 8.70% vs 6.35% — payers have more data to lose, more devices to sync and a contractual expectation; 'not a single day without a crash… if you take money you have to deliver… how many years must I wait for it to stabilise'; Pro across iPhone/iPad/Mac: check-ins sync instantly, structural edits corrupt state, 'same problem for years, exhausting; if it isn't fixed I'll switch'; all weight-log history vanished — 'if I'd known records could all disappear I wouldn't have paid'; a lifetime buyer left for TodoMate

- **Where:** §0.10 Reliability is a paid-user problem, not a free-user problem; payer-vs-global table (verbatim)
- **This app does:** reliability failures concentrated among payers
- **User reaction:** churn
- **Magnitude:** Theme | Payer rate (n=161) | Global rate (n=2,048) ; Entitlement failure | 9.94% (16) | 1.22% ; Data loss | 12.42% (20) | 6.01% ; Trial/billing dispute | 14.29% (23) | 7.03% ; Cross-device / web / Mac sync | 6.21% (10) | 2.69% ; Order / future-date edit restriction | 8.70% (14) | 6.35%
- **Direction for us:** must-never-break · **Report confidence:** high-priority (payer cohort) · **Generalisable:** yes
- **Review IDs:** `10673432472`, `13972678934`, `11442003118`, `13450548328`, `11427388698`, `10985703210`, `10983549558`, `13023417712`, `14504465163`
- **Canonical:** C030 Sync must work — and prove it; C033 Restore purchase and entitlements must work immediately; C034 Data must never be lost on update, reinstall or phone change; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R18-056 — Data loss / records reset / won't save is high-priority and splits by tenure — long-time users report and stay (37 in 5★), new users report and leave (31 in 1★); 12.42% of payers

- **Where:** §3.1 Data loss / records reset / won't save
- **This app does:** data loss on update/reset
- **User reaction:** churn
- **Magnitude:** 123 (6.01%, HIGH, mean 3.27★, 31 1★); payer rate 12.42% (20/161)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `11442003118`, `13972678934`, `14238803827`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R18-057 — Crash / won't launch is high-priority; a 1-year member: 'not a single day without a crash'

- **Where:** §3.1 Crash / won't launch
- **This app does:** crashes
- **User reaction:** churn
- **Magnitude:** 111 (5.42%, HIGH, mean 3.15★, 29 1★); 5★ band 31; 3★ band 20 (9.3%)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10673432472`, `13926457593`
- **Canonical:** C031 Crashes / launch failures

### R18-058 — Lag / slow / loading is a very strong signal

- **Where:** §3.1 Lag / slow / loading
- **This app does:** slow/laggy
- **User reaction:** complaint
- **Magnitude:** 76 (3.71%, very strong, mean 3.32★, 15 1★)
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Canonical:** C083 Performance must not degrade with habit count

### R18-064 — Notifications not firing or impossible to silence is a meaningful theme

- **Where:** §3.1 Notification not firing / can't silence
- **This app does:** notification defects
- **User reaction:** complaint
- **Magnitude:** 21 (1.03%, meaningful, mean 3.57★)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C039 Reminders fire reliably, once

### R18-104 — Data loss hits 20 of 161 payers (12.42%); in one case the developer restored the data and the review was upgraded

- **Where:** §5.4 #2 Data loss among payers — one resolved by restoring data, review upgraded
- **This app does:** data loss; one successful restore
- **User reaction:** churn
- **Magnitude:** 20/161 (12.42%); 7 named IDs incl. tw
- **Direction for us:** must-never-break · **Report confidence:** payer cohort · **Generalisable:** yes
- **Review IDs:** `14238803827`, `11442003118`, `10985703210`, `13450548328`, `10983549558`, `11103012143`, `14374791999`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C059 Be visibly responsive; fixes bring reviewers back

### R18-111 — A CA user will return when the timezone bug is fixed; timezone/overseas date theme 11 (0.54%)

- **Where:** §5.5 Timezone fix — 'I'll come back when it's fixed'
- **This app does:** wrong date when travelling
- **User reaction:** churn
- **Magnitude:** n=1 stated + 11 theme
- **Direction for us:** must-never-break · **Report confidence:** single · **Generalisable:** yes
- **Review IDs:** `8592955634`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

### R18-119 — Korean-diaspora users in the US/CA hit a timezone bug — the day rolls on Korean time; US daylight saving is unhandled; one asks for a refund; span 2021-08 → 2024-11

- **Where:** §7.1 US Korean-diaspora timezone bug (incl. DST unhandled)
- **This app does:** timezone tied to KR
- **User reaction:** churn
- **Magnitude:** 6 IDs; theme 11 (0.54%)
- **Direction for us:** must-never-break · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `7667185054`, `8850150608`, `10288775267`, `8288427147`, `8592955634`, `11951042522`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

### R18-140 — Fix entitlement propagation and instrument it — a lifetime purchase that stops working is not a bug, it is the end of the customer relationship; add a purchase-state self-check on launch and an in-app restore that actually restores without dumping the user into onboarding

- **Where:** §9.1 I3. Fix entitlement propagation, and instrument it
- **This app does:** entitlements fail; restore loops to onboarding
- **User reaction:** churn
- **Magnitude:** 25 (1.22%, mean 2.44★); every JP instance 1★
- **Direction for us:** must-never-break · **Report confidence:** recommendation (immediate) · **Generalisable:** yes
- **Review IDs:** `14238803827`, `13953352894`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C139 Cache entitlements locally — never block a paid surface on a live server check

## Features

### R18-011 — iPad landscape mode was withdrawn around Sep 2021 — '가로모드 중단이요..?'; one reviewer: 'landscape only, and I'd buy'

- **Where:** §0.5 iPad landscape mode withdrawn (~Sep 2021)
- **This app does:** removed iPad landscape
- **User reaction:** blocked-conversion
- **Magnitude:** 5 IDs
- **Direction for us:** must-have · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `7762347992`, `7891611908`, `7960129120`, `8049542760`, `8107694384`
- **Canonical:** C141 Native iPad layout; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R18-013 — The web/desktop version was discontinued in late 2022/early 2023 — one user had subscribed for a year because of desktop

- **Where:** §0.5 Web / desktop version discontinued (late 2022 / early 2023)
- **This app does:** removed web/desktop
- **User reaction:** churn
- **Magnitude:** 4 IDs
- **Direction for us:** paid · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `9513306665`, `9878312095`, `9791158691`, `10179190547`
- **Canonical:** C044 Mac / desktop / web app; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R18-014 — The highlighter was moved from free to Pro in May 2023 — 'you take away what already existed?'; later cut to 1 colour on free

- **Where:** §0.5 Highlighter moved free → Pro (May 2023)
- **This app does:** free feature moved behind paywall
- **User reaction:** complaint
- **Magnitude:** n=1 named + Dec 2023 batch
- **Direction for us:** product-rule · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `9892001293`
- **Canonical:** C001 Never move a free feature behind the paywall

### R18-015 — The to-do list was moved from free to Pro in Nov 2023, hitting among others a teacher using it with a class; 9 named IDs incl. JP

- **Where:** §0.5 To-do list moved free → Pro (Nov 2023)
- **This app does:** free feature moved behind paywall
- **User reaction:** 1★-burst
- **Magnitude:** 9 named IDs
- **Direction for us:** product-rule · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `10598930656`, `10602078683`, `10626638051`, `10645526932`, `10656234239`, `10656594581`, `10666557187`, `10775337514`, `10787375859`
- **Canonical:** C001 Never move a free feature behind the paywall

### R18-017 — Condition-check, weight/number trackers and statistics moved behind Pro and partly back; one reviewer notes the flip-flop fragmented their data

- **Where:** §0.5 Trackers and statistics moved behind Pro and partly back (Jul 2024 → 2025)
- **This app does:** paywall flip-flop on trackers/statistics
- **User reaction:** complaint
- **Magnitude:** 5 IDs
- **Direction for us:** dont · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `11536013545`, `12350930181`, `12497207499`, `12706210535`, `11815241341`
- **Canonical:** C001 Never move a free feature behind the paywall; C104 Never ship a paywall or feature-removal change silently

### R18-020 — Routines and one-off to-dos interleaved in a single reorderable time-ordered list was the purchase reason for several annual subscribers and MyRoutine's one advantage over dedicated to-do apps; removing it forfeited that advantage without matching to-do apps on their own ground

- **Where:** §0.6 Routine + to-do in one time-ordered list (the feature itself)
- **This app does:** had it, removed Sep 2024
- **User reaction:** purchase-driver
- **Magnitude:** 32 protest reviews mean 4.25★; ≥2 subscribed because of it
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11700463203`, `11727453236`, `11752441594`, `11714930552`
- **Canonical:** C050 One-off to-dos alongside habits; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R18-021 — Weekly view — used to verify '3× per week' habits and to compare trend on numeric habits — was removed in the same Sep 2024 release; 8 named IDs incl. Singapore

- **Where:** §0.6 Weekly view removed (collateral, Sep 2024)
- **This app does:** removed weekly view
- **User reaction:** complaint
- **Magnitude:** 8 IDs
- **Direction for us:** must-have · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `11696910432`, `11700553046`, `11710196595`, `11712906881`, `11756484782`, `11834968287`, `11932729042`, `11707812003`
- **Canonical:** C012 Week / month / year grid views; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R18-022 — Challenge (fixed-duration goals) was removed in the Sep 2024 release; one user had bought a year because of Challenge; 6 IDs incl. VN

- **Where:** §0.6 Challenge feature removed (collateral, Sep 2024)
- **This app does:** removed fixed-duration challenges
- **User reaction:** churn
- **Magnitude:** 6 IDs
- **Direction for us:** undecided · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `11689998104`, `11699658192`, `11752441594`, `11846983639`, `12185895649`, `11781517701`
- **Canonical:** C101 Milestones, achievements, celebration; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R18-027 — A green day at ~60–80% completion, not 100%, with the threshold user-set: 'with apps that show percentage you aim for 100 and suffer; with this you switch to "green light is good enough"' (jp, ADHD/ASD); 'if you get too absorbed in routines it becomes compulsive… with a 60% check and the green light, the sense of achievement feels like 100%'; 'I never feel guilted or pressured like some other habit tracking apps' (au)

- **Where:** §0.8 (1) The traffic light (신호등) with a user-set completion threshold
- **This app does:** free; user-set threshold for a daily green/yellow/red light
- **User reaction:** praise
- **Magnitude:** 92 reviews (4.49%, very strong, mean 4.24★) on the light/streak/badge system
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `9744682977`, `11978551289`, `12492881974`, `13268786498`, `9514694714`, `6529483781`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C201 A user-set partial-completion threshold — a 'good day' below 100%

### R18-028 — Rest, postpone-a-day and skip options instead of an unconditional yes/no — 'the sense of deprivation when you miss a routine is smaller'

- **Where:** §0.8 (2) Rest / postpone / skip instead of pass-fail
- **This app does:** has rest/postpone/skip
- **User reaction:** praise
- **Magnitude:** 2 named IDs within the 92-review light theme
- **Direction for us:** free · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `10367219461`, `6859591028`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C095 Neutral, non-judgemental tone on failure; C201 A user-set partial-completion threshold — a 'good day' below 100%

### R18-029 — The routine timer (~Nov 2024) is praised and converts: one sets every routine to 1 minute purely to defeat activation energy — 'and then I actually started???'; a US user values the 30-second voice warning

- **Where:** §0.8 (3) The routine timer (shipped ~Nov 2024)
- **This app does:** routine timer with voice warning
- **User reaction:** purchase-driver
- **Magnitude:** 46 reviews (2.25%, meaningful, mean 4.37★)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12353891566`, `11993264527`, `14045116089`, `13503736524`, `12822094053`, `12815650430`
- **Canonical:** C120 Sequential routine timer with spoken next step and live finish-time estimate

### R18-030 — A light social layer — see other routiners for motivation 'but it isn't like SNS, which is nice'; a teacher chose it over rivals because the social features are lighter; following a friend described as an 'exchange diary'

- **Where:** §0.8 (4) A light social layer that is explicitly not a social network
- **This app does:** light social layer (follow, see others' routines)
- **User reaction:** praise
- **Magnitude:** 66 reviews (3.22%, very strong, mean 4.45★)
- **Direction for us:** undecided · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `7835571277`, `10598930656`, `10492723138`
- **Canonical:** C202 A light social layer that is explicitly not a social network

### R18-032 — The shield (~Aug 2025) preserves a streak through a missed day and users experience that as a lie — 'the streak number feels fake so motivation actually drops… I get complacent thinking I can skip today since the number won't disappear'; 'auto-shielded on days I didn't do it, so a green light on a failed day is meaningless… the tail wagging the dog'; an annual payer (jp) notes the green-light cut-off rules changed silently; one asks for an on/off toggle

- **Where:** §0.9 Too soft — the 'shield' (방패) invalidates the streak
- **This app does:** automatic streak shield, not optional
- **User reaction:** complaint
- **Magnitude:** 6 IDs
- **Direction for us:** product-rule · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `13260473006`, `13104946209`, `13765930951`, `13056561637`, `13769975479`, `14415129984`
- **Canonical:** C024 Streaks / gamification; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R18-034 — Others find the light too easy: green achievable while skipping the hard habits; wants a 'must-do' habit that gates the light; wants a 90% threshold; wants a 100% star above the green light; wants mini/normal/focus intensity levels — shipped as 미니/플러스/맥스 in Jun 2026, then reported as repeatedly resetting

- **Where:** §0.9 And too easy for others
- **This app does:** single light threshold; intensity levels shipped Jun 2026 but reset
- **User reaction:** mixed
- **Magnitude:** 6 IDs
- **Direction for us:** undecided · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `10806031465`, `10647565568`, `13819171699`, `13842882389`, `13657572874`, `14184795326`
- **Canonical:** C024 Streaks / gamification; C201 A user-set partial-completion threshold — a 'good day' below 100%

### R18-042 — Feature inventory: habit checklist with custom emoji stamp (Jul 2020, free but completions metered); traffic light with user-set % threshold (free); badges/levels (free); retrospective/diary (partly Pro); short & long memo per habit (metered 20/week → 5/week → 14 ticks/week); web+PC (paid, discontinued ~2022/23, returned as beta 2025); social follow/copy/best routines/cheer messages (free); reminders (free); day-of-week / n-times-per-week repeat (partly Pro in some periods); rest/skip/postpone (free); free trial 3 weeks (Oct 2020) → 7 days by 2023; home-screen widget (Dec 2021, reported as Pro by some); Apple Watch (~Feb 2022, free with Pro); monthly report/statistics (~Mar 2022, Pro); goals with linked habits (~Dec 2022); Challenge (~Jan 2023, removed Sept 2024); highlighter (Pro May 2023, 1 colour free from Jan 2024); to-do (2021, Pro Nov 2023); tracking habits weight/condition/timestamp/numbers (2023–25, Pro with flip-flops); routine bundles + per-bundle timer (~Nov 2024, Pro); note (~Mar 2025, Pro); to-do calendar (~Apr 2025, Pro); per-habit streaks + shield (~Aug 2025, Pro); routine modes — swappable day templates (~Dec 2025, Pro); intensity levels (~Jun 2026, Pro); completion animation/sound (~May 2026, free)

- **Where:** §2.1 Feature inventory derived from reviews (verbatim table)
- **This app does:** see table
- **User reaction:** mixed
- **Magnitude:** Capability | First seen in corpus | Free / Paid (as reported) | Evidence ; Habit ("습관") checklist with custom emoji stamp | Jul 2020 | Free, but completions are metered (§0.2) | 6162278434, 13977781381, 14393820099 ; Traffic light (신호등) day status, user-set % threshold | Jul 2020 | Free | 6163620772, 11978551289 ; Badges / levels | 2020 | Free | 8997599884, 9013404592 ; Retrospective / diary (회고 → 일기) | Jul 2020 | Partly Pro (12347915109) | 6162253418, 8902763630 ; Short memo & long memo per habit | 2020 | Metered — 20/week → 5/week → 14 ticks/week | 8789513059, 10773481361, 14393820099 ; Web + PC version | Jul 2020 | Paid feature, discontinued ~2022/23, returned as beta 2025 | 6171352716, 9513306665, 13042903108 ; Social: follow routiners, copy routines, best/theme routines, cheer messages | Jul 2020 | Free | 6225061945, 8773230635, 14108167464 ; Reminders per habit | 2020 | Free | 6529812431 ; Day-of-week / n-times-per-week repeat | 2020 | Partly Pro in some periods (13895676942 tw) | 6529670915, 9657336466 ; Rest (쉼) / skip / postpone | 2021 | Free | 10367219461, 9418591969 ; Free-trial → subscription | Oct 2020 (3 weeks) → 7 days by 2023 | — | 6526765963, 10339050009 ; Home-screen widget | Dec 2021 | Reported as Pro by some (13496310680 jp) | 8173262340, 8232445562 ; Apple Watch app | ~Feb 2022 | Free with Pro account | 8409385715, 8412382382 ; Monthly report / statistics | ~Mar 2022 | Pro | 8409385715, 11815241341 ; Goals (나의 목표) with linked habits | ~Dec 2022 | Free/Pro unclear | 9492696267, 9687682796 ; Challenge (fixed-duration) | ~Jan 2023 | Removed Sept 2024 | 9611075637, 11752441594 ; Highlighter | pre-2023 | Moved to Pro May 2023, 1 colour free from Jan 2024 | 9892001293, 10570170204 ; To-do list | 2021 | Moved to Pro Nov 2023 | 8232574930, 10598930656 ; Tracking habits (weight, condition, timestamp, numbers) | 2023–2025 | Pro (with reported flip-flops) | 12350930181, 12706210535 ; Routine bundles (묶음루틴) + per-bundle timer | ~Nov 2024 | Pro | 11980527185, 12023625379 ; Note feature | ~Mar 2025 | Pro | 12461476430 ; To-do calendar / monthly to-do | ~Apr 2025 | Pro | 12512686577, 12536816913 ; Per-habit streaks (연속 달성) + shield (방패) | ~Aug 2025 | Pro | 13056561637, 13205319753 ; Routine modes (루틴 모드) — swappable day templates | ~Dec 2025 | Pro | 13547363890, 13795524849 ; Intensity levels (미니/플러스/맥스) | ~Jun 2026 | Pro | 14184795326 ; Completion animation / sound | ~May 2026 | Free | 14052908844
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Review IDs:** `6162278434`, `6163620772`, `8997599884`, `6162253418`, `8789513059`, `6171352716`, `6225061945`, `6529812431`, `6529670915`, `10367219461`, `6526765963`, `8173262340`, `8409385715`, `9492696267`, `9611075637`, `8232574930`, `12350930181`, `11980527185`, `12461476430`, `12512686577`, `13056561637`, `13547363890`, `14184795326`, `14052908844`
- **Canonical:** — (nuance register)

### R18-043 — A web + PC version existed from Jul 2020 as a paid feature, was discontinued ~2022/23 and returned as a beta in 2025

- **Where:** §2.1 Web + PC version — paid, discontinued ~2022/23, returned as beta 2025
- **This app does:** web/PC: paid → removed → beta
- **User reaction:** mixed
- **Magnitude:** 3 inventory IDs; 4 removal IDs in §0.5
- **Direction for us:** paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `6171352716`, `9513306665`, `13042903108`
- **Canonical:** C044 Mac / desktop / web app

### R18-044 — An Apple Watch app arrived ~Feb 2022, free with a Pro account

- **Where:** §2.1 Apple Watch app (~Feb 2022), free with Pro account
- **This app does:** watch app bundled with Pro
- **User reaction:** mixed
- **Magnitude:** 2 IDs
- **Direction for us:** paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8409385715`, `8412382382`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R18-045 — A home-screen widget arrived Dec 2021 and is reported as Pro by some users (jp: 'the widget is paid?')

- **Where:** §2.1 Home-screen widget (Dec 2021), reported as Pro by some
- **This app does:** widget; free/paid status unclear to users
- **User reaction:** mixed
- **Magnitude:** 3 IDs
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `8173262340`, `8232445562`, `13496310680`
- **Canonical:** C023 Interactive widget check-off; C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible

### R18-046 — Routine modes — swappable day templates (weekday/weekend/shift etc.) — shipped ~Dec 2025 as Pro; five modes were wiped in the worst case in the corpus

- **Where:** §2.1 Routine modes (루틴 모드) — swappable day templates (~Dec 2025, Pro)
- **This app does:** Pro day templates
- **User reaction:** mixed
- **Magnitude:** 2 inventory IDs
- **Direction for us:** undecided · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `13547363890`, `13795524849`
- **Canonical:** C206 Swappable day templates / routine modes for irregular schedules

### R18-047 — Routine bundles with a per-bundle timer shipped ~Nov 2024 as Pro — the timer is the converting feature of §0.8

- **Where:** §2.1 Routine bundles (묶음루틴) + per-bundle timer (~Nov 2024, Pro)
- **This app does:** Pro bundles + timer
- **User reaction:** purchase-driver
- **Magnitude:** 2 inventory IDs; 46 timer reviews
- **Direction for us:** paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11980527185`, `12023625379`
- **Canonical:** C120 Sequential routine timer with spoken next step and live finish-time estimate; C173 Sub-tasks / sub-routines nested inside a habit or routine

### R18-054 — UI complexity / can't find things is the largest negative theme by count (149, 7.28%, high-priority) though at 3.65★ it is friction among loyal users rather than churn; Notion is the benchmark for 'too complex'

- **Where:** §3.1 UI complexity / can't find things — the largest negative theme by count
- **This app does:** feature-dense UI; discoverability problems
- **User reaction:** complaint
- **Magnitude:** 149 (7.28%, HIGH, mean 3.65★, 24 1★); 4★ band 30 (9.3%), 3★ band 24 (11.1%)
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9514694714`, `10851299280`, `9744682977`
- **Canonical:** C006 Stay minimal and ad-free; C142 Surface existing features where users look; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

### R18-055 — Order/reorder/future-date edit restriction is the #1 unmet need — free reordering / drag-and-drop and editing future dates; 73 five-star reviews describe this friction; a JP ADHD user docked a star purely for reorder discoverability

- **Where:** §3.1 Order / reorder / future-date edit restriction
- **This app does:** restricted reordering and future-date editing
- **User reaction:** complaint
- **Magnitude:** 130 (6.35%, HIGH, mean 4.07★, 14 1★); 5★ band 73 (6.8%); payer rate 8.70%
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8790036022`, `10405411434`, `10547226293`, `11570091772`, `13830429548`, `10925388863`, `9744682977`
- **Canonical:** C010 Backfill missed days / edit start date; C073 Manual reordering, renaming and editing of habits/tasks — free

### R18-061 — Cross-device / web / Mac sync complaints are meaningful and worse among payers (6.21%)

- **Where:** §3.1 Cross-device / web / Mac sync
- **This app does:** sync problems across iPhone/iPad/Mac/web
- **User reaction:** complaint
- **Magnitude:** 55 (2.69%, meaningful, mean 3.73★); payers 10 (6.21%)
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13972678934`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C030 Sync must work — and prove it

### R18-067 — Design / cute / clean / intuitive is the top positive theme; 116 of the 5★ reviews (10.9%) praise design

- **Where:** §3.1 Design / cute / clean / intuitive — the top positive theme
- **This app does:** cute, clean design with custom emoji stamps
- **User reaction:** praise
- **Magnitude:** 164 (8.01%, HIGH, mean 4.46★)
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C006 Stay minimal and ad-free

### R18-069 — Apple Watch is mostly positive but asks for parity — timer, bundles, standalone use

- **Where:** §3.1 Apple Watch (mostly positive; asks for parity)
- **This app does:** watch app lacks timer/bundles/standalone
- **User reaction:** mixed
- **Magnitude:** 48 (2.34%, meaningful, mean 4.46★)
- **Direction for us:** paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `13431240197`, `13435011015`, `12102004351`, `12181512959`, `12736883056`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync)

### R18-071 — Feature-request themes all skew positive (engaged users): statistics/graphs/trend 57 (2.78%, 4.12★); theme colours/dark mode/fonts 60 (2.93%, 4.53★); merged routine+to-do view 46 (2.25%, 4.22★, mostly post-Sept-2024); shift-work/variable-schedule 31 (1.51%, 4.03★); diary/memo aggregation view 22 (1.07%, 4.68★); export/backup 18 (0.88%, 4.44★)

- **Where:** §3.1 Feature-request themes (verbatim table) — all skew positive, engaged users
- **This app does:** requests from engaged users
- **User reaction:** praise
- **Magnitude:** Theme | n | % | Mean ★ | Signal ; Statistics / graphs / trend reporting | 57 | 2.78% | 4.12 | Meaningful ; Theme colours / dark mode / fonts | 60 | 2.93% | 4.53 | Meaningful ; Merged routine + to-do view (mostly post-Sept-2024) | 46 | 2.25% | 4.22 | Meaningful ; Shift-work / variable-schedule support | 31 | 1.51% | 4.03 | Meaningful ; Diary / memo aggregation view | 22 | 1.07% | 4.68 | Meaningful ; Export / backup (Excel, CSV, PDF, Notion) | 18 | 0.88% | 4.44 | Emerging
- **Direction for us:** none · **Report confidence:** theme table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R18-073 — Unmet needs ranked: 1 free reordering/drag-and-drop and editing future dates 130; 2 real statistics (% achieved, trend, annual view, per-habit graphs) 57; 3 theme colours/dark mode/font size 60; 4 restore merged routine+to-do 46; 5 shift-work/variable-day routine profiles 31; 6 diary/memo aggregation, calendar of entries, search 22+; 7 export/backup 18 ('add export and I'll subscribe for life'); 8 photo/media/URL attached to a habit/memo/diary ~25; 9 to-do parity (carry-over, subtasks, tags, priority, undated, recurring) ~30; 10 configurable day-end time ~15; 11 widget: check without opening, choose routine, 2-column, calendar (214 mentions); 12 Apple Watch parity 48; 13 Mac/Windows/web ~20 ('PC access please I'm desperate!'); 14 hide unused tabs ~8; 15 turn streak/light/shield on and off ~12

- **Where:** §3.3 Unmet needs (verbatim table) — every substantial request ranked by count
- **This app does:** requests
- **User reaction:** mixed
- **Magnitude:** Rank | Request | n (classifier or reading) | Representative IDs ; 1 | Free reordering / drag-and-drop, and editing future dates | 130 | 8790036022, 10405411434, 10547226293, 11570091772, 13830429548, 10925388863 ; 2 | Real statistics: % achieved, trend, annual view, per-habit graphs | 57 | 10444375042, 11058573700, 13064048672, 13815455991, 14102776480 ; 3 | Theme colours / dark mode / font size | 60 | 10134189547, 11208317901 (us), 13199584756, 12955157658, 14107861406 ; 4 | Restore the merged routine + to-do view | 46 | §0.6 ; 5 | Shift-work / variable-day routine profiles | 31 | 12245337065, 11794115305, 12580123414, 12478377114 (jp), 13618217151 (jp) ; 6 | Diary/memo aggregation, calendar of entries, search | 22 + | 9774376446, 12024794472, 13309723170, 11802252737 ; 7 | Export / backup (Excel, CSV, PDF, Notion) | 18 | 13587898854 (*"내보내기 해주시면 평생 구독할게요"*), 12730801342, 13843048940, 9925440139 (jp), 12983375244 ; 8 | Photo / media / URL attached to a habit, memo or diary | ~25 (reading) | 8650285763, 9091145019, 10607803565, 12024794472, 12478377114 (jp) ; 9 | To-do parity: carry-over, subtasks, tags/categories, priority, undated, recurring | ~30 (reading) | 9624805038, 10935748594, 12687026543, 13147214076, 14171150075 (us), 13662101102 (ph) ; 10 | Configurable day-end time (not midnight) | ~15 (reading) | 11911176952, 13531683889, 13705144684, 11617268315 (jp), 12403094681 (us) ; 11 | Widget: check without opening the app; choose which routine; 2-column; calendar | 214 mentions total | 8173262340, 9660942025, 10861517833, 11798381598, 14127953337 (us), 9556123553 (vn) ; 12 | Apple Watch parity (timer, bundles, standalone) | 48 | 13431240197 (jp), 13435011015 (jp), 12102004351 (jp), 12181512959, 12736883056 ; 13 | Mac / Windows / web client | ~20 (reading) | 14232062718, 14264012710, 13932466192, 13411029434 (kr, English: *"PC access please I'm desperate!"*), 9829175246 (vn) ; 14 | Hide unused tabs / reduce visual load | ~8 (reading) | 13842532454, 13821412218, 11064706172 ; 15 | Turn the streak / light / shield on and off | ~12 (reading) | §0.9
- **Direction for us:** none · **Report confidence:** request table · **Generalisable:** app-specific
- **Review IDs:** `8790036022`, `10444375042`, `10134189547`, `12245337065`, `9774376446`, `13587898854`, `8650285763`, `9624805038`, `11911176952`, `8173262340`, `13431240197`, `14232062718`, `13842532454`
- **Canonical:** — (nuance register)

### R18-074 — Real statistics — % achieved, trend, annual view, per-habit graphs — is the #2 request; a paying user notes statistics have no charts; a lifetime buyer left for TodoMate over statistics, export and diary aggregation

- **Where:** §3.3 #2 Real statistics: % achieved, trend, annual view, per-habit graphs
- **This app does:** statistics behind Pro but shallow (no charts)
- **User reaction:** complaint
- **Magnitude:** 57 (2.78%, meaningful, 4.12★)
- **Direction for us:** paid · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10444375042`, `11058573700`, `13064048672`, `13815455991`, `14102776480`, `10851299280`, `11427388698`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R18-075 — Theme colours, dark mode and font size are the #3 request at 4.53★ — engaged users

- **Where:** §3.3 #3 Theme colours / dark mode / font size
- **This app does:** limited theming
- **User reaction:** praise
- **Magnitude:** 60 (2.93%, meaningful, 4.53★)
- **Direction for us:** free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `10134189547`, `11208317901`, `13199584756`, `12955157658`, `14107861406`
- **Canonical:** C080 Colour themes / dark mode

### R18-076 — Shift-work / variable-day routine profiles is a meaningful request (KR 3-shift, JP); routine modes shipped ~Dec 2025 as Pro

- **Where:** §3.3 #5 Shift-work / variable-day routine profiles
- **This app does:** later shipped as Pro 'routine modes'
- **User reaction:** complaint
- **Magnitude:** 31 (1.51%, meaningful, 4.03★)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12245337065`, `11794115305`, `12580123414`, `12478377114`, `13618217151`
- **Canonical:** C170 Configurable day boundary and hemisphere seasons; C206 Swappable day templates / routine modes for irregular schedules

### R18-077 — Diary/memo aggregation, a calendar of entries and search — the highest-rated request theme at 4.68★

- **Where:** §3.3 #6 Diary/memo aggregation, calendar of entries, search
- **This app does:** memos exist but cannot be browsed together or searched
- **User reaction:** praise
- **Magnitude:** 22+ (1.07%, meaningful, 4.68★)
- **Direction for us:** undecided · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `9774376446`, `12024794472`, `13309723170`, `11802252737`
- **Canonical:** C172 Per-day / per-habit notes and journal text; C205 Aggregated, searchable journal / diary across days

### R18-078 — Export/backup to Excel, CSV, PDF or Notion — 'add export and I'll subscribe for life'

- **Where:** §3.3 #7 Export / backup (Excel, CSV, PDF, Notion)
- **This app does:** no export
- **User reaction:** blocked-conversion
- **Magnitude:** 18 (0.88%, emerging, 4.44★)
- **Direction for us:** free · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `13587898854`, `12730801342`, `13843048940`, `9925440139`, `12983375244`
- **Canonical:** C020 Data export / backup / CSV

### R18-079 — Attach a photo, media or URL to a habit, memo or diary entry

- **Where:** §3.3 #8 Photo / media / URL attached to a habit, memo or diary
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** ~25 (reading)
- **Direction for us:** undecided · **Report confidence:** reading · **Generalisable:** yes
- **Review IDs:** `8650285763`, `9091145019`, `10607803565`, `12024794472`, `12478377114`
- **Canonical:** C208 Photo / media / URL attached to a habit, memo or diary entry

### R18-080 — To-do parity — carry-over, subtasks, tags/categories, priority, undated and recurring to-dos; a JP 4★ will keep Pro if a cross-date to-do list ships

- **Where:** §3.3 #9 To-do parity: carry-over, subtasks, tags/categories, priority, undated, recurring
- **This app does:** to-do is Pro yet shallow
- **User reaction:** complaint
- **Magnitude:** ~30 (reading)
- **Direction for us:** undecided · **Report confidence:** reading · **Generalisable:** yes
- **Review IDs:** `9624805038`, `10935748594`, `12687026543`, `13147214076`, `14171150075`, `13662101102`, `14479635630`
- **Canonical:** C050 One-off to-dos alongside habits; C173 Sub-tasks / sub-routines nested inside a habit or routine

### R18-081 — A configurable day-end time (not midnight)

- **Where:** §3.3 #10 Configurable day-end time (not midnight)
- **This app does:** day ends at midnight
- **User reaction:** complaint
- **Magnitude:** ~15 (reading; kr, jp, us)
- **Direction for us:** must-have · **Report confidence:** reading · **Generalisable:** yes
- **Review IDs:** `11911176952`, `13531683889`, `13705144684`, `11617268315`, `12403094681`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone); C170 Configurable day boundary and hemisphere seasons

### R18-082 — Widget requests — check off without opening the app, choose which routine shows, 2-column layout, calendar widget; the widget has 214 mentions and is simultaneously the most-loved and most-broken surface; one user runs both MyRoutine and Routinery solely for Routinery's timer widget

- **Where:** §3.3 #11 Widget: check without opening the app; choose which routine; 2-column; calendar
- **This app does:** widget exists; not interactive; limited configuration
- **User reaction:** mixed
- **Magnitude:** 214 widget mentions total; 5★ 121 (11.3%) vs 1★ 19
- **Direction for us:** undecided · **Report confidence:** reading · **Generalisable:** yes
- **Review IDs:** `8173262340`, `9660942025`, `10861517833`, `11798381598`, `14127953337`, `9556123553`
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app; C107 Widget variants and customisation as the paid layer

### R18-083 — Mac / Windows / web client — 'PC access please I'm desperate!' (kr, in English); web returned as beta 2025

- **Where:** §3.3 #13 Mac / Windows / web client
- **This app does:** web beta only
- **User reaction:** complaint
- **Magnitude:** ~20 (reading)
- **Direction for us:** paid · **Report confidence:** reading · **Generalisable:** yes
- **Review IDs:** `14232062718`, `14264012710`, `13932466192`, `13411029434`, `9829175246`
- **Canonical:** C044 Mac / desktop / web app

### R18-084 — Hide unused tabs / reduce visual load — requested by the ADHD reviewer who also wants the streak hideable

- **Where:** §3.3 #14 Hide unused tabs / reduce visual load
- **This app does:** cannot hide tabs
- **User reaction:** complaint
- **Magnitude:** ~8 (reading)
- **Direction for us:** must-have · **Report confidence:** reading · **Generalisable:** yes
- **Review IDs:** `13842532454`, `13821412218`, `11064706172`
- **Canonical:** C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

### R18-109 — Conditional-purchase promises — treat as a priced backlog, not forecasts: data export ('add export and I'll subscribe for life'; jp 'I'd pay more'); a widget (2021: '1000% willing to pay for a widget'); iPad landscape; Apple Watch ('even if paid I'd buy right away'); a cross-date all-to-dos list (existing Pro renewal condition); annual statistics ('I'd pay lifetime immediately'); a black theme ('add it only for paid subscribers'); a working timer with time tracking; a timezone fix ('I'll come back'); a time-table/time-block view; fewer bugs; just being allowed to try it

- **Where:** §5.5 Conditional-purchase promises (verbatim table) — a priced feature backlog
- **This app does:** backlog of stated purchase conditions
- **User reaction:** purchase-driver
- **Magnitude:** Condition | Who ; Data export (Excel/CSV/Notion) | 13587898854 (*"내보내기 해주시면 평생 구독할게요"*), 14102776480 (jp: *"이거 해결되면 돈 더 낼 의향도 있습니다"*) ; A widget | 8039445612 (2021: *"돈내고라도 위젯 사용할 의향 1000%"*) ; iPad landscape | 8107694384 ; Apple Watch support | 8300726420 (*"유료기능이더라도… 당장 구매할것 같은데"*) ; A cross-date "all to-dos" list | 14479635630 (jp, existing Pro member — renewal condition) ; Annual statistics | 13064048672 (*"이 기능이면 바로 평생 결제하고 쓸 거 같아요"*) ; A black theme | 11208317901 (us: *"You can also add it only to the paid subscribers"*) ; A working timer with time tracking | 14504465163 (*"그때 다시 회원으로 돌아오려 합니다"*) ; Timezone fix | 8592955634 (ca: *"고쳐지면 다시 돌아오겠습니다"*) ; A time-table / time-block view | 12348149297 ; Fewer bugs | 13926457593 (us), 13031399325 ; Just being allowed to try it | 14517754076, 13848157788 (ca), 12433476315
- **Direction for us:** build-paid · **Report confidence:** stated conditions · **Generalisable:** yes
- **Review IDs:** `13587898854`, `14102776480`, `8039445612`, `8107694384`, `8300726420`, `14479635630`, `13064048672`, `11208317901`, `14504465163`, `8592955634`, `12348149297`, `13926457593`, `13031399325`, `14517754076`, `13848157788`, `12433476315`
- **Canonical:** C011 Weekly / monthly / yearly reports; C020 Data export / backup / CSV; C022 Apple Watch app (done properly: timer, two-way sync); C133 Gate on capability, not on quantity

### R18-110 — A time-table / time-block view is a stated purchase condition

- **Where:** §5.5 A time-table / time-block view
- **This app does:** absent
- **User reaction:** blocked-conversion
- **Magnitude:** n=1
- **Direction for us:** research · **Report confidence:** single · **Generalisable:** yes
- **Review IDs:** `12348149297`
- **Canonical:** C199 System calendar integration — see appointments inside the plan

### R18-117 — Japanese reviewers uniquely ask for auto-advancing timers (next routine starts automatically when the previous one ends)

- **Where:** §7.1 Japan — auto-advancing timers (unique JP request)
- **This app does:** timer does not auto-advance
- **User reaction:** complaint
- **Magnitude:** 4 JP IDs
- **Direction for us:** undecided · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `14328062792`, `14045116089`, `13435011015`, `12428102869`
- **Canonical:** C120 Sequential routine timer with spoken next step and live finish-time estimate

### R18-134 — UI vocabulary confusion — 습관 (habit) vs 루틴 (routine) vs 모드 (mode) — persists 2022→2026

- **Where:** §8.6 UI vocabulary confusion (습관 vs 루틴 vs 모드)
- **This app does:** overlapping product vocabulary
- **User reaction:** complaint
- **Magnitude:** 3 IDs
- **Direction for us:** must-have · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `12272956378`, `13439818706`, `14232607477`
- **Canonical:** C075 Skippable, replayable onboarding tour

### R18-149 — Restore an optional merged routine + to-do view as a toggle, not a replacement — a minority genuinely prefers the split

- **Where:** §9.3 P1. Restore an optional merged routine + to-do view
- **This app does:** removed; requested back
- **User reaction:** churn
- **Magnitude:** 32 reviews mean 4.25★; ≥4 subscribers named it as purchase trigger
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `11700463203`, `12118393284`, `12287914815`
- **Canonical:** C050 One-off to-dos alongside habits; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R18-150 — Make reordering direct (long-press to drag) and allow editing any date — remove the 'you cannot edit future dates' restriction introduced ~Jun 2023; the most-repeated single request in the corpus

- **Where:** §9.3 P2. Make reordering direct, and allow editing any date
- **This app does:** restricted reorder and future-date edit since ~Jun 2023
- **User reaction:** complaint
- **Magnitude:** 130 (6.35%), five years, mean 4.07★
- **Direction for us:** must-have · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `8790036022`, `13853005780`
- **Canonical:** C010 Backfill missed days / edit start date; C073 Manual reordering, renaming and editing of habits/tasks — free

### R18-151 — Build statistics that answer 'am I getting better?' — per-habit achievement %, trend over weeks/months, annual view, a calendar of green/yellow/red; two reviews specify the requirement precisely

- **Where:** §9.3 P3. Build statistics that answer 'am I getting better?'
- **This app does:** statistics behind Pro, no trend/charts
- **User reaction:** complaint
- **Magnitude:** 57 reviews
- **Direction for us:** paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `10444375042`, `10851299280`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R18-152 — Ship export — asked continuously since the app's fifth month and named as a purchase condition twice; export is also the honest answer to five years of data-loss reports: it lets users protect themselves

- **Where:** §9.3 P4. Ship export
- **This app does:** no export
- **User reaction:** blocked-conversion
- **Magnitude:** 18 reviews, mean 4.44★
- **Direction for us:** free · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `6164039764`, `13587898854`, `14102776480`
- **Canonical:** C020 Data export / backup / CSV; C176 Never let fear of losing history be the reason people pay

### R18-153 — Aggregate the diary — people write daily reflections for years and cannot read them back except one date at a time

- **Where:** §9.3 P5. Aggregate the diary
- **This app does:** diary entries not browsable together
- **User reaction:** complaint
- **Magnitude:** 22 reviews, mean 4.68★ — highest-rated request theme
- **Direction for us:** undecided · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `9774376446`, `12024794472`
- **Canonical:** C205 Aggregated, searchable journal / diary across days

### R18-155 — Finish routine modes — right feature, wrong execution: switching a mode rewrites past days' lights, modes apply forward-only rather than per-date, edits inside a mode don't persist, and it is buried in Settings

- **Where:** §9.3 P7. Finish routine modes
- **This app does:** modes shipped buggy
- **User reaction:** complaint
- **Magnitude:** 5 named IDs
- **Direction for us:** must-never-break · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13685716991`, `13812236928`, `13795524849`, `14108692347`, `13556531783`
- **Canonical:** C078 Ship the paid feature working before you sell it; C206 Swappable day templates / routine modes for irregular schedules

### R18-156 — Apple Watch and widget parity with the timer — Japan and the US both rate the timer as a high-priority strength and both ask for it on the watch and in the widget

- **Where:** §9.3 P8. Apple Watch and widget parity with the timer
- **This app does:** timer absent from watch and widget
- **User reaction:** complaint
- **Magnitude:** JP 6.28%, US 8.33% timer; 4 named IDs
- **Direction for us:** paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `13431240197`, `13435011015`, `12736883056`, `14127953337`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C023 Interactive widget check-off; C120 Sequential routine timer with spoken next step and live finish-time estimate

## Monetization

### R18-006 — An unusually wide ladder of concurrently-live price points — five simultaneous annual prices in the US ($17.99–$39.99) and four in Korea (₩25,000–₩33,000), monthly ₩3,500/₩3,900 or $4.99/$5.99, lifetime ₩69,000/₩89,000 or $79.99; a distinct repeating pattern inside billing disputes is 'I paid, and then the app immediately offered me a cheaper price' — paid ₩33,000 then shown ₩25,000 after the tutorial; charged both ₩33,000 and ₩25,000; '40% off' advertised at ₩28,000 charged ₩33,000, re-subscribed and charged again — ₩61,000 total; chose ₩33,000 charged ₩45,000; Taiwan reproduces it exactly ('the promo price and the actual card charge differed by 2×'); JP ¥2,900 checkout → ¥4,150 charged; users do not read this as a pricing experiment, they read it as fraud (詐欺 / 詐騙 / scam / fraudulent / Abzocke / 사기 / 피싱앱 수준)

- **Where:** §0.3 The price ladder itself is generating fraud accusations; plan/price table (verbatim)
- **This app does:** multiple concurrent price points per plan; discount banners not honoured at checkout
- **User reaction:** 1★-burst
- **Magnitude:** 144 trial/billing/refund disputes (7.03%, high-priority, mean 2.90★); Plan | Korea (KR) | United States (US) ; Pro monthly | ₩3,500 / ₩3,900 | $4.99 / $5.99 ; Pro annual | ₩25,000 / ₩28,000 / ₩30,000 / ₩33,000 | $17.99 / $22.99 / $29.99 / $34.99 / $39.99 ; Pro lifetime | ₩69,000 / ₩89,000 | $79.99
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Side effects:** Taiwan is the lowest-rated storefront in the corpus at 2.60 mean and billing is essentially the whole story there
- **Review IDs:** `14143250366`, `14146289685`, `13829350794`, `11881028381`, `13420003023`, `13734105920`, `12417115787`, `13773500213`, `14160907779`, `14215712231`, `14291964350`, `12109687708`, `13994502099`, `14344435230`, `14286926161`, `14488115233`
- **Canonical:** C029 Billing must be exactly right; C113 One stable, disclosed price — no discount wheels; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

### R18-016 — Dec 2023–Jan 2024: free routines cut 15→8, short memo →5/week, highlighter →1 colour, and friend-invite bonus routines revoked; JP called it '改悪' (a change for the worse); a user who recruited friends to earn 23 free routines had the earned quota revoked — 'my friends and family all deleted the app, but I'm still here'

- **Where:** §0.5 Dec 2023 – Jan 2024 free-tier cuts and friend-invite bonus revoked
- **This app does:** cut free caps and revoked earned referral rewards
- **User reaction:** 1★-burst
- **Magnitude:** 9 named IDs + 1
- **Direction for us:** product-rule · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `10754519109`, `10772477035`, `10773481361`, `10773703235`, `10729003648`, `10570170204`, `10883150036`, `10914801439`, `10788981444`, `10857167531`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C089 Promos, giveaways and gift codes must work exactly as advertised

### R18-048 — Free download; Pro subscription with monthly, annual and lifetime tiers at four to five concurrent price points per tier per storefront; trial length moved from 3 weeks (2020–21) → 7 days (2023 onward), with 2-day and 3-day variants reported (de, hk, jp)

- **Where:** §2.2 Monetisation model — structure and trial length
- **This app does:** monthly/annual/lifetime; trial shrank 3 weeks → 7 days → 2–3 days
- **User reaction:** mixed
- **Magnitude:** listing 10 Sep 2026; 3 IDs for short trials
- **Direction for us:** undecided · **Report confidence:** listing + reviews · **Generalisable:** app-specific
- **Review IDs:** `13751955979`, `14429093675`, `12227960355`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C109 A free trial must be a real trial

### R18-050 — Price points named by reviewers corroborate the listing: Korea ₩3,900/mo, ₩25,000 / ₩28,000 / ~₩30,000 / ₩33,000 annual, ₩45,000 and ₩47,000 mischarges, ₩61,000 double, lifetime ~₩89,000, ~₩70,000/yr; Japan ¥4,560/yr, ¥3,500/yr, ¥2,900 → ¥4,150 charged, lifetime ¥6,890 and ¥8,890; US $23/yr or $3/mo, $29.99 (au), '$50'; Taiwan NT$890 list, NT$590 promo, NT$790 renewal; Vietnam 600k VND/yr

- **Where:** §2.2 Price points named by reviewers (verbatim table)
- **This app does:** price points as named in reviews
- **User reaction:** mixed
- **Magnitude:** Market | Named in reviews ; Korea | ₩3,900/mo 10656594581 · ₩25,000 14143250366 · ₩28,000 13734105920 · ₩30,000-ish 12300507880 · ₩33,000 10259408955 10809417235 · ₩45,000 (mischarge) 13420003023 · ₩47,000 (mischarge) 10105520747 · ₩61,000 (double) 11881028381 · lifetime ~₩89,000 11815241341 13637970269 · ~₩70,000/yr 14478284399 ; Japan | ¥4,560/yr 11187045021 11978156607 · ¥3,500/yr 12214731690 · ¥2,900 → ¥4,150 charged 14488115233 · lifetime ¥6,890 14238803827 and ¥8,890 12777592140 ; US | $23/yr or $3/mo 10771673004 · $29.99 13894901307 (au) · "$50" 10857540454 ; Taiwan | NT$890 list, NT$590 promo, NT$790 renewal 14286926161 14344435230 ; Vietnam | 600k VND/yr 11925026971
- **Direction for us:** research · **Report confidence:** review-derived · **Generalisable:** app-specific
- **Review IDs:** `10656594581`, `14143250366`, `13734105920`, `12300507880`, `10259408955`, `10809417235`, `13420003023`, `10105520747`, `11881028381`, `11815241341`, `13637970269`, `14478284399`, `11187045021`, `11978156607`, `12214731690`, `14488115233`, `14238803827`, `12777592140`, `10771673004`, `13894901307`, `10857540454`, `14286926161`, `14344435230`, `11925026971`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R18-060 — Price objection is a meaningful theme distinct from billing disputes

- **Where:** §3.1 Price objection
- **This app does:** price seen as too high
- **User reaction:** complaint
- **Magnitude:** 56 (2.73%, meaningful, mean 3.30★, 16 1★)
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** yes
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R18-092 — Confirmed payers: 161 (7.86%), mean 3.528 vs 3.824 corpus — payers rate 0.30 stars lower; distribution 5★ 75 · 4★ 16 · 3★ 24 · 2★ 11 · 1★ 35 (21.7% vs 16.2% corpus-wide); kr 143 · jp 14 · us 3 · tw 1; by year 2020:1 · 2021:4 · 2022:13 · 2023:22 · 2024:38 · 2025:37 · 2026:46 — more numerous in the review stream than ever; lifetime buyers specifically 34 reviews (1.66%), mean 4.12★; definition undercounts payers (explicit first-person statements only, precision ≈92%)

- **Where:** §5.1 The confirmed-payer cohort — 161 reviewers (7.86%); metric table (verbatim)
- **This app does:** payers are more polarised and lower-rated than the corpus
- **User reaction:** mixed
- **Magnitude:** Metric | Value ; n | 161 (7.86% of 2,048) ; Mean rating | 3.528 (vs 3.824 corpus) — payers rate 0.30 stars lower than the corpus ; Distribution | 5★ 75 · 4★ 16 · 3★ 24 · 2★ 11 · 1★ 35 (21.7%) ; By storefront | kr 143 · jp 14 · us 3 · tw 1 ; By year | 2020:1 · 2021:4 · 2022:13 · 2023:22 · 2024:38 · 2025:37 · 2026:46 ; Lifetime buyers specifically | 34 reviews (1.66%), mean 4.12★
- **Direction for us:** must-never-break · **Report confidence:** high-priority cohort · **Generalisable:** yes
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R18-093 — Lifetime buyers (34 reviews, 1.66%) average 4.12★ — well above the payer cohort's 3.53 and the corpus 3.82

- **Where:** §5.1 Lifetime buyers specifically — 34 reviews, mean 4.12★
- **This app does:** lifetime tier exists (₩69,000–89,000 / $79.99 / ¥6,890–8,890)
- **User reaction:** praise
- **Magnitude:** 34 (1.66%), mean 4.12★ vs payers 3.528
- **Direction for us:** build-paid · **Report confidence:** cohort · **Generalisable:** yes
- **Review IDs:** `11815241341`, `13637970269`, `14238803827`, `12777592140`, `11427388698`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R18-099 — Barriers ranked: 1 cannot evaluate before paying; 2 price feels high for value delivered (56, 2.73%) — sharpest JP compares to a rival at ¥380/yr or ¥1,400 lifetime and leaves; 3 subscription itself rejected, users want one-time purchase; 4 bugs make the paid version look unsafe to buy (JP couldn't verify terms — English only — so quit); 5 loss of trust from the price ladder/mischarges; 6 students, teens and children cannot pay; 7 sign-up wall before any trial

- **Where:** §5.3 What stops people from paying — every barrier, ranked (verbatim table)
- **This app does:** barriers
- **User reaction:** blocked-conversion
- **Magnitude:** Rank | Barrier | Evidence ; 1 | Cannot evaluate before paying. The paywall lands before or during the trial of the core action | 14517754076 (90% ready to buy), 13848157788 (ca: *"I might've paid for this, if I could have seen…"*), 12433476315, 14068889624, 13894901307 (au), 14031934887 (us), 12989964586 ; 2 | Price feels high for the value delivered — 56 reviews (2.73%) | 11187045021 (jp — the sharpest: compares to a rival at ¥380/yr or ¥1,400 lifetime and leaves), 11815241341 (₩89,000 lifetime), 14478284399 (₩70,000/yr), 13889164527, 12357145235, 10857540454 (us) ; 3 | Subscription itself is rejected; users want a one-time purchase | 7841937957, 8174800592, 8454428069, 8785421572, 10296452732, 10787703382, 12783996460 (jp), 14233269481 (hk), 13650576656 (jp) ; 4 | Bugs make the paid version look unsafe to buy | 13926457593 (us: *"too buggy at the moment"*), 13487846506 (us), 12024690867 (jp: couldn't verify the terms — English only — so quit) ; 5 | Loss of trust from the price ladder / mischarges | §0.3 ; 6 | Students, teens and children cannot pay — a recurring, sympathetic segment | 11974551441 (a primary-school student), 13005084273, 12857404582 (au teen: also notes the age gate's lowest bracket is "18 and under" though the store rates it "all ages"), 13758846200 (gb child), 11132278368 (fr), 13247035053 (au: *"wish they had a student plan"*), 12122589601, 10598930656 (a teacher whose class lost the to-do list) ; 7 | Sign-up wall before any trial | 8258577524, 10178633937 (us), 9088458031 (jp — email + phone + real name), 12549047166, 14379439679 (gb)
- **Direction for us:** product-rule · **Report confidence:** ranked · **Generalisable:** yes
- **Review IDs:** `14517754076`, `11187045021`, `7841937957`, `13926457593`, `11974551441`, `8258577524`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'; C147 Let people use the product before they pay

### R18-100 — Subscription itself is rejected by a recurring set of reviewers who want a one-time purchase (kr, jp, hk)

- **Where:** §5.3 #3 Subscription itself is rejected; users want a one-time purchase
- **This app does:** subscription-first with a lifetime option
- **User reaction:** blocked-conversion
- **Magnitude:** 9 named IDs
- **Direction for us:** build-paid · **Report confidence:** ranked #3 · **Generalisable:** yes
- **Review IDs:** `7841937957`, `8174800592`, `8454428069`, `8785421572`, `10296452732`, `10787703382`, `12783996460`, `14233269481`, `13650576656`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R18-125 — A Dutch reviewer saw the displayed price move 'from over 200 to 68 to 19.90' — wildly moving prices destroy trust even before a charge

- **Where:** §7.4 nl — displayed price moved 'from over 200 to 68 to 19.90', destroying trust
- **This app does:** price shown changes drastically
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13724277153`
- **Canonical:** C113 One stable, disclosed price — no discount wheels

### R18-146 — Add a student/child tier or a family option — students, teens and children appear repeatedly and sympathetically, including a teacher using it with a whole class until the to-do list went paid; the store rates the app 'all ages' while the onboarding age bracket starts at '18 and under'

- **Where:** §9.2 M3. Add a student/child tier or a family option
- **This app does:** no student/family tier
- **User reaction:** blocked-conversion
- **Magnitude:** 8 named IDs (§5.3 #6)
- **Direction for us:** research · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `10598930656`, `12857404582`
- **Canonical:** C025 Scholarship / hardship / discount program; C037 Family plan

### R18-148 — Keep the lifetime tier and protect it absolutely — 34 lifetime buyers at mean 4.12★ are the most committed segment; two of the corpus's most damaging reviews are lifetime buyers who lost their entitlement

- **Where:** §9.2 M5. Keep the lifetime tier and protect it absolutely
- **This app does:** lifetime tier present but entitlement fragile
- **User reaction:** mixed
- **Magnitude:** 34 lifetime (1.66%), mean 4.12★
- **Direction for us:** build-paid · **Report confidence:** recommendation · **Generalisable:** yes
- **Review IDs:** `14238803827`, `14031409160`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C033 Restore purchase and entitlements must work immediately

## Tactics the app used

### R18-097 — Acquisition through the founder's book and a Millie's Library / Draw Andrew interview, YouTubers (kr, jp), Instagram/Twitter ads (kr, us), and an App Store Editor's Choice feature in 2020

- **Where:** §5.2 #4 A creator or book
- **This app does:** founder book, interviews, YouTubers, social ads, Editor's Choice
- **User reaction:** purchase-driver
- **Magnitude:** 10 named IDs
- **Direction for us:** do · **Report confidence:** ranked #4 · **Generalisable:** app-specific
- **Review IDs:** `9522758316`, `9663347068`, `12461265321`, `13583464496`, `12917751855`, `14406881138`, `8549757135`, `11802252737`, `6225061945`, `6526765963`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)

### R18-136 — What improved: bundles + timer (Nov 2024) answered a 2021 request for nested/grouped routines and won loud approval; routine modes (Dec 2025) answered the shift-work request first raised in 2022 and won back a churned subscriber ('神✨'; a KR nurse: 'rain in a drought') though execution is still buggy; dark mode shipped (requested from Dec 2020, present by Feb 2025); widget, Apple Watch, month view and one-tap complete all shipped after sustained request campaigns; responsiveness is visible and valued — several upgrade their rating after a developer reply; 'how is it that everything I think of gets improved one by one??'; the pattern: MyRoutine ships what users ask for, roughly 18–36 months later, and often breaks something else in the same release

- **Where:** §8.7 Trend 6 — What genuinely improved
- **This app does:** ships requests 18–36 months later; often breaks something else
- **User reaction:** praise
- **Magnitude:** 6 rating-upgrade IDs; 4 buggy-modes IDs
- **Direction for us:** do · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `6874709836`, `7765093968`, `11391766303`, `12023625379`, `12815650430`, `8532953584`, `14454264522`, `13795524849`, `14108692347`, `13812236928`, `13685716991`, `6800233288`, `12343142427`, `8519301616`, `11103012143`, `12023009972`, `13039376354`, `14374239484`, `14479635630`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C175 Updates must not break function or wipe progress

### R18-137 — Routine modes (Dec 2025) answered a 2022 shift-work request and won back a churned JP subscriber — a shipped long-standing request re-converts churned users

- **Where:** §8.7 Routine modes won back a churned subscriber
- **This app does:** shipped a 3-year-old request
- **User reaction:** purchase-driver
- **Magnitude:** n=1 returning churned user + 1 KR nurse
- **Direction for us:** do · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `14454264522`, `13795524849`, `8532953584`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C206 Swappable day templates / routine modes for irregular schedules

## Insights (the why)

### R18-003 — Two theme families dominate and point in opposite directions: praise for design/cuteness/intuitiveness (164, 8.01%, 4.46★) and habit-formed/life-changed (131, 6.40%, 4.54★) versus free-tier restriction blocking core use (139, 6.79%, 2.32★), trial/auto-billing/refund disputes (144, 7.03%, 2.90★), data loss (123, 6.01%, 3.27★) and crash/won't launch (111, 5.42%, 3.15★) — all six high-priority; a genuinely differentiated product with a monetisation and reliability problem of equal size, and reviews praising the product and condemning the paywall are frequently the same reviews

- **Where:** §0.1 The product is loved. The business model is what people write about; family table (verbatim)
- **This app does:** loved product, disliked business model
- **User reaction:** mixed
- **Magnitude:** Family | n | % of 2,048 | Mean ★ ; Praise: design / cuteness / intuitiveness | 164 | 8.01% | 4.46 ; Praise: habit formed, life changed | 131 | 6.40% | 4.54 ; Free-tier restriction blocks core use | 139 | 6.79% | 2.32 ; Trial / auto-billing / refund dispute | 144 | 7.03% | 2.90 ; Data loss / records reset | 123 | 6.01% | 3.27 ; Crash / won't launch | 111 | 5.42% | 3.15
- **Direction for us:** product-rule · **Report confidence:** high-priority (>5%) · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R18-005 — The binding free limit is completions, not habits: the free tier advertises 10 habits, but ticking a habit consumes the short-memo quota capped at 14 per week — two check-offs a day; if accurate this single quota explains five years of users reporting the app 'stops working on day 3 / day 5 / day 6 / day 10' — the advertised limit is the number of habits, the binding limit is the number of completions; a habit tracker whose free tier meters completions teaches new users in their first week that the product does not work, precisely when a habit-formation product must prove it does — the highest-leverage finding in the corpus

- **Where:** §0.2 One Hong Kong reviewer supplies the mechanic nobody else spells out
- **This app does:** check-offs metered via a 14/week short-memo quota on the free tier
- **User reaction:** blocked-conversion
- **Magnitude:** n=1 explicit (hk, 1★, Aug 2026) explaining the 139-review theme
- **Direction for us:** product-rule · **Report confidence:** high-priority (mechanism from close reading) · **Generalisable:** yes
- **Side effects:** the app 'stops working on day 3/5/6/10' pattern across five years
- **Conditions:** if the HK account is accurate
- **Review IDs:** `14393820099`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R18-026 — The praise clusters the roadmap should protect: (1) the traffic light with a user-set completion threshold, (2) rest/postpone/skip instead of pass-fail, (3) the routine timer, (4) a light social layer explicitly not a social network, (5) ADHD/executive-function fit, (6) routine + to-do in one time-ordered list — the thing removed in Sept 2024

- **Where:** §0.8 What people actually love — and it is not the tracker (list)
- **This app does:** differentiated on motivation mechanics, not the tracker
- **User reaction:** praise
- **Magnitude:** six clusters; see individual cards
- **Direction for us:** must-have · **Report confidence:** very strong / meaningful · **Generalisable:** yes
- **Canonical:** C134 Lead the store listing with what users actually love; C201 A user-set partial-completion threshold — a 'good day' below 100%

### R18-033 — An ADHD reviewer states the design principle outright: 'streaks motivate some people, but for others a broken streak is the feature that makes them quit the routine — people diagnosed with ADHD are likely the latter; I'd like to be able to hide this UI'; another wants the light off entirely because 'I can only finish my routine near the end of the day, so I have to sit in red all day and it makes me uncomfortable'

- **Where:** §0.9 Too hard — the streak is a quitting trigger
- **This app does:** streak and light not hideable
- **User reaction:** complaint
- **Magnitude:** 5 IDs
- **Direction for us:** product-rule · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `13842532454`, `12424534015`, `12618795582`, `12719246363`, `11116355780`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns

### R18-052 — Free: habit creation to the cap, traffic light, badges, social/follow/copy, reminders, rest/skip, completion animation; Pro: to-do, statistics/monthly report, tracking habits, note, to-do calendar, highlighter beyond 1 colour, routine bundles + timer, routine modes, intensity levels, unlimited habits, unlimited completions; unclear/changed: widget, diary, day-of-week repeat, condition check — reported free by some and paid by others in overlapping periods; that last column is itself a finding: reviewers cannot tell what they are buying — 'the premium feature description says not one word about trackers'; 'it says the free version allows up to 2 tracking modes yet it tells me to pay'; a GB user bought Pro for a timer the screenshots advertise and could not find it

- **Where:** §2.2 Classification summary (verbatim table) — reviewers cannot tell what they are buying
- **This app does:** free/paid boundary illegible and shifting
- **User reaction:** blocked-conversion
- **Magnitude:** Reported as free | Reported as Pro | Unclear / changed over time ; Habit creation (to the cap), traffic light, badges, social/follow/copy, reminders, rest/skip, completion animation | To-do list, statistics/monthly report, tracking habits, note, to-do calendar, highlighter (beyond 1 colour), routine bundles + timer, routine modes, intensity levels, unlimited habits, unlimited completions | Widget, diary, day-of-week repeat, condition check — all reported as free by some users and paid by others in overlapping periods ; 7 named IDs
- **Direction for us:** must-have · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `12350930181`, `13894400612`, `13534993454`, `14288774795`, `13496310680`, `12433476315`, `14331337303`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C204 Never destroy user work at the paywall; label paid features before they are used

### R18-066 — Positive themes: design/cute/clean/intuitive 164 (8.01%, 4.46★, HIGH); habit formed/life changed 131 (6.40%, 4.54★, HIGH); traffic light/streak/badge 92 (4.49%, 4.24★); social layer 66 (3.22%, 4.45★); Apple Watch 48 (2.34%, 4.46★, mostly positive, asks for parity); routine timer 46 (2.25%, 4.37★); ADHD/neurodivergent/low-mood fit 36 (1.76%, 4.53★); explicit praise for partial-completion design 10 (0.49%, 4.80★ — conservative classifier, qualitatively much larger)

- **Where:** §3.1 Positive themes (verbatim table)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** # | Theme | n | % | Mean ★ | Signal ; 1 | Design / cute / clean / intuitive | 164 | 8.01% | 4.46 | HIGH ; 2 | Habit formed / life changed | 131 | 6.40% | 4.54 | HIGH ; 3 | Traffic light / streak / badge system | 92 | 4.49% | 4.24 | Very strong ; 4 | Social layer (routiners, copying, cheering) | 66 | 3.22% | 4.45 | Very strong ; 5 | Apple Watch (mostly positive; asks for parity) | 48 | 2.34% | 4.46 | Meaningful ; 6 | Routine timer | 46 | 2.25% | 4.37 | Meaningful ; 7 | ADHD / neurodivergent / low-mood fit | 36 | 1.76% | 4.53 | Meaningful ; 8 | Explicit praise for partial-completion design | 10 | 0.49% | 4.80 | Weak (conservative classifier; qualitatively much larger)
- **Direction for us:** none · **Report confidence:** theme table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R18-068 — Habit formed / life changed is the second positive theme — 'my life changed completely' (jp)

- **Where:** §3.1 Habit formed / life changed
- **This app does:** product works for those who get through
- **User reaction:** praise
- **Magnitude:** 131 (6.40%, HIGH, mean 4.54★)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `10313873532`, `12614380013`, `12292226361`, `12243537252`, `13331816001`
- **Canonical:** C201 A user-set partial-completion threshold — a 'good day' below 100%

### R18-070 — Explicit praise for partial-completion design is the highest-rated theme at 4.80★ — conservative classifier, qualitatively much larger

- **Where:** §3.1 Explicit praise for partial-completion design
- **This app does:** green day below 100%
- **User reaction:** praise
- **Magnitude:** 10 (0.49%, weak by count, mean 4.80★)
- **Direction for us:** must-have · **Report confidence:** weak count / exceptional magnitude · **Generalisable:** yes
- **Review IDs:** `9744682977`, `11978551289`
- **Canonical:** C201 A user-set partial-completion threshold — a 'good day' below 100%

### R18-087 — 4★ is the 'one thing away from perfect' band and the one thing is usually reordering, the widget or a missing statistic — 'If I could give it 4 and a half I would' (journaling not prominent enough); JP will keep Pro if a cross-date to-do ships; top 4★ themes widget 45 (14.0%), complexity 30 (9.3%), data loss 29 (9.0%), order/edit 29 (9.0%)

- **Where:** §4.1 4★ — the 'one thing away from perfect' band
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 322 4★ (15.72%)
- **Direction for us:** none · **Report confidence:** rating band · **Generalisable:** yes
- **Review IDs:** `9744682977`, `12077348883`, `14479635630`
- **Canonical:** C011 Weekly / monthly / yearly reports; C073 Manual reordering, renaming and editing of habits/tasks — free

### R18-088 — 3★ is the paying-but-disappointed band: paid, no modularity, noisy defaults, statistics with no charts; a US medical student 'really wanted to purchase the lifetime membership, but it's too buggy'; one cancelled because paying only removes limits, adds nothing; top themes complexity 24 (11.1%), payer 24 (11.1%), widget 22, paywall 21, crash 20

- **Where:** §4.1 3★ — the paying-but-disappointed band
- **This app does:** paying disappointed users
- **User reaction:** churn
- **Magnitude:** 216 3★ (10.55%)
- **Direction for us:** product-rule · **Report confidence:** rating band · **Generalisable:** yes
- **Review IDs:** `10851299280`, `13487846506`, `13926457593`, `11116355780`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C133 Gate on capability, not on quantity

### R18-089 — 2★ is the smallest band (109, 5.32%) and the most concentrated on money: paywall 18 (16.5%), billing 13 (11.9%), payer 11 (10.1%)

- **Where:** §4.1 2★ — the smallest band and the most concentrated on money
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 109 2★ (5.32%)
- **Direction for us:** none · **Report confidence:** rating band · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R18-090 — More than a third of 1★ reviews (122/332, 36.7%) are about money — the paywall (65, 19.58%) or the bill (57, 17.17%) — and one in ten (35, 10.54%) was written by someone who had paid; reliability is the second engine (data loss 31, crash 29); feature gaps barely appear — 1★ reviewers are not people who wanted more, they are people who could not use, could not trust, or could not get their money back

- **Where:** §4.1 1★ — n = 332 (16.21%); theme table (verbatim); more than a third of 1★ are about money
- **This app does:** 1★ driven by money and reliability, not feature gaps
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n in 1★ | % of 1★ ; Free-tier restriction | 65 | 19.58% ; Trial/billing dispute | 57 | 17.17% ; Confirmed payer | 35 | 10.54% ; Data loss | 31 | 9.34% ; Crash | 29 | 8.73% ; Complexity/confusion | 24 | 7.23% ; Promo-nag | 18 | 5.42% ; Onboarding | 18 | 5.42% ; Ads | 16 | 4.82%
- **Direction for us:** product-rule · **Report confidence:** rating band · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C147 Let people use the product before they pay

### R18-094 — The most common purchase path is hitting the habit/completion cap while already engaged — it converts and embitters at the same time

- **Where:** §5.2 #1 Hitting the habit/completion cap while already engaged — converts and embitters
- **This app does:** cap-triggered conversion
- **User reaction:** purchase-driver
- **Magnitude:** 4 named IDs; most common named trigger
- **Direction for us:** product-rule · **Report confidence:** ranked #1 by naming frequency · **Generalisable:** yes
- **Review IDs:** `11213284399`, `12822094053`, `10995640730`, `9092043014`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C137 Show the paywall at the moment of need, not on app open

### R18-095 — Named purchase triggers seen in advance: the timer; routine modes for shift work (incl. a returning churned JP user); Challenge; the merged routine+to-do view; desktop/web; iPad landscape; statistics — three of these seven were later removed

- **Where:** §5.2 #2 A specific feature seen in advance
- **This app does:** feature-led conversion
- **User reaction:** purchase-driver
- **Magnitude:** 14 named IDs across 7 features
- **Direction for us:** build-paid · **Report confidence:** ranked #2 · **Generalisable:** yes
- **Side effects:** three of the seven named triggers (Challenge, merged view, desktop) were subsequently removed
- **Review IDs:** `12353891566`, `13119628268`, `14331337303`, `13795524849`, `14454264522`, `11752441594`, `11727453236`, `11714930552`, `12862607759`, `9513306665`, `8107694384`, `8633124826`
- **Canonical:** C120 Sequential routine timer with spoken next step and live finish-time estimate; C155 Never remove a feature people bought the app for — add alongside, do not replace; C206 Swappable day templates / routine modes for irregular schedules

### R18-096 — Conversion after a month, a week, two weeks, or the trial → Pro path — outcome-led conversion requires being allowed to use the product

- **Where:** §5.2 #3 Trying it for days and being convinced by the outcome
- **This app does:** trial-to-conviction
- **User reaction:** purchase-driver
- **Magnitude:** 5 named IDs
- **Direction for us:** product-rule · **Report confidence:** ranked #3 · **Generalisable:** yes
- **Review IDs:** `8363704388`, `8961449067`, `10995640730`, `10961939818`, `12822094053`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C147 Let people use the product before they pay

### R18-098 — Some pay to fund the developer — a GB app developer defends the price; 'just skip a couple of fried chickens'

- **Where:** §5.2 #5 Wanting to fund the developer
- **This app does:** goodwill conversion
- **User reaction:** purchase-driver
- **Magnitude:** 3 named IDs
- **Direction for us:** do · **Report confidence:** ranked #5 · **Generalisable:** yes
- **Review IDs:** `9256280526`, `14031166609`, `14364890014`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'

### R18-101 — Bugs make the paid version look unsafe to buy — 'too buggy at the moment'; a JP user couldn't verify the terms (English only) so quit

- **Where:** §5.3 #4 Bugs make the paid version look unsafe to buy
- **This app does:** bugs block conversion
- **User reaction:** blocked-conversion
- **Magnitude:** 3 named IDs
- **Direction for us:** must-never-break · **Report confidence:** ranked #4 · **Generalisable:** yes
- **Review IDs:** `13926457593`, `13487846506`, `12024690867`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C078 Ship the paid feature working before you sell it

### R18-106 — 'Not so much amazing paid service as feeling forced to pay because the basics were cut'; 'even paid, there's nothing to use beyond the to-do list' — the paid tier only removes limits

- **Where:** §5.4 #4 The paid tier adds nothing, it only removes limits
- **This app does:** Pro = removal of caps
- **User reaction:** churn
- **Magnitude:** 3 named IDs
- **Direction for us:** product-rule · **Report confidence:** ordered by trust breach · **Generalisable:** yes
- **Review IDs:** `11116355780`, `10904269033`, `14504465163`
- **Canonical:** C133 Gate on capability, not on quantity

### R18-112 — The retention mechanism is consistent and unusual: (1) partial credit removes the failure state; (2) the traffic light creates a visible daily debt — got out of bed at 2:30am to clear a red light; 'if I don't succeed or the light isn't green something feels off so I just do it'; (3) cheer messages and rest options prevent the shame spiral; (4) seeing others' routines supplies templates and company without becoming a social network; (5) the timer defeats activation energy — this is the asset the monetisation is spending down

- **Where:** Part 6 Why people stay: the retention mechanism
- **This app does:** partial credit + daily light + rest + light social + timer
- **User reaction:** praise
- **Magnitude:** 131 reviews (6.40%, high-priority, mean 4.54★) describe a behaviour change
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `9091145019`, `8404425930`, `12363679942`, `10629245924`, `14406960899`, `13132341344`
- **Canonical:** C095 Neutral, non-judgemental tone on failure; C120 Sequential routine timer with spoken next step and live finish-time estimate; C201 A user-set partial-completion threshold — a 'good day' below 100%; C202 A light social layer that is explicitly not a social network

## Audiences

### R18-024 — Shift workers, 3-shift workers, parents and night workers are excluded by onboarding questions that assume a 9-to-5 weekday life — 'I do shift work and that's not an option. I wanted to create my own routine not have you suggest one for me. Hence the name of your app. MY routine not your routine' — the sharpest positioning critique in the corpus

- **Where:** §0.7 (3) It excludes anyone without a 9-to-5 weekday life
- **This app does:** onboarding assumes 9-to-5
- **User reaction:** blocked-conversion
- **Magnitude:** 4 IDs (au, kr ×2, ph)
- **Direction for us:** must-have · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `12445646540`, `12245337065`, `12132150109`, `12784378291`
- **Canonical:** C170 Configurable day boundary and hemisphere seasons; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R18-031 — Reviewers self-identifying with ADHD, ASD, depression, burnout or 무기력 rate the app highly; ADHD is now in the KR store title itself ('ADHD 하루 계획표 앱')

- **Where:** §0.8 (5) ADHD / executive-function fit
- **This app does:** positions on ADHD in the KR title
- **User reaction:** praise
- **Magnitude:** 36 reviews (1.76%, meaningful, mean 4.53★)
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11067291310`, `11993264527`, `12428102869`, `11888055232`, `12121119977`, `13842532454`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R18-102 — Students, teens and children cannot pay: a primary-school student, an AU teen (notes the age gate's lowest bracket is '18 and under' though the store rates it 'all ages'), a GB child, 'wish they had a student plan', a teacher whose class lost the to-do list

- **Where:** §5.3 #6 Students, teens and children cannot pay — a recurring, sympathetic segment
- **This app does:** no student plan; age gate mismatch
- **User reaction:** blocked-conversion
- **Magnitude:** 8 named IDs
- **Direction for us:** do · **Report confidence:** ranked #6 · **Generalisable:** yes
- **Review IDs:** `11974551441`, `13005084273`, `12857404582`, `13758846200`, `11132278368`, `13247035053`, `12122589601`, `10598930656`
- **Canonical:** C025 Scholarship / hardship / discount program; C037 Family plan; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

### R18-113 — Tenure: 3–4 year users, 500+ day streaks, 1,000 routine completions, 199 and 700 days; life contexts: exam candidates and re-taking students, a stay-at-home parent, a parent-entrepreneur scripting the day minute by minute, pregnancy, post-illness recovery, a disability and return-to-work plan (jp), depression and 무기력, primary-school children

- **Where:** Part 6 Tenure evidence and life contexts
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 8 tenure IDs; 11 context IDs
- **Direction for us:** do · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `12780156991`, `13356295904`, `14401843895`, `14345482795`, `13399863062`, `11340256601`, `14108167464`, `13769975479`, `8749041575`, `11871621227`, `11513425197`, `14493849853`, `10365634719`, `14460799436`, `11857498349`, `11905634612`, `14409378886`, `14411303132`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R18-127 — The GB storefront contains the corpus's clearest autistic-user usability report

- **Where:** §7.4 gb — clearest autistic-user usability report
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=1
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13149940985`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R18-159 — Serve irregular schedules in onboarding, not just in Pro — shift workers, night workers, parents and students are a repeating, articulate, paying segment; the questions currently assume a weekday 9-to-5

- **Where:** §9.4 Q2. Serve irregular schedules in onboarding, not just in Pro
- **This app does:** irregular schedules only served by Pro modes
- **User reaction:** blocked-conversion
- **Magnitude:** 6 named IDs
- **Direction for us:** do · **Report confidence:** recommendation (positioning) · **Generalisable:** yes
- **Review IDs:** `12245337065`, `12784378291`, `12132150109`, `12580123414`, `13795524849`, `12478377114`
- **Canonical:** C170 Configurable day boundary and hemisphere seasons; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional; C206 Swappable day templates / routine modes for irregular schedules

## Markets and languages

### R18-040 — By storefront: KR 1,599 (78.08%, 3.95★), JP 223 (10.89%, 3.37★), US 84 (4.10%, 3.82★), TW 35 (1.71%, 2.60★ — lowest), GB 23 (3.48★), AU 17 (3.71★), CA 15 (3.20★), 22 others 52; by rating 5★ 1,069 (52.20%) · 4★ 322 (15.72%) · 3★ 216 (10.55%) · 2★ 109 (5.32%) · 1★ 332 (16.21%); mean 3.824; review length median 89 chars, 404 (19.73%) under 40 chars; 203 (9.91%) carry a helpfulness vote

- **Where:** §1.7 Corpus composition — by storefront table (verbatim); by rating
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Storefront | n | % | Mean ★ | First → last ; kr Korea | 1,599 | 78.08% | 3.95 | 2020-07-06 → 2026-09-06 ; jp Japan | 223 | 10.89% | 3.37 | 2022-07-24 → 2026-09-01 ; us United States | 84 | 4.10% | 3.82 | 2021-08-08 → 2026-09-03 ; tw Taiwan | 35 | 1.71% | 2.60 | 2024-07-11 → 2026-09-05 ; gb United Kingdom | 23 | 1.12% | 3.48 | 2022-05-26 → 2026-08-17 ; au Australia | 17 | 0.83% | 3.71 | 2022-07-05 → 2026-03-28 ; ca Canada | 15 | 0.73% | 3.20 | 2022-01-27 → 2026-03-14 ; 22 others | 52 | 2.54% | — | —
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R18-065 — Localisation defects (19, 0.93%, emerging) and timezone / overseas-date errors (11, 0.54%, emerging) are emerging themes

- **Where:** §3.1 Localisation defects; Timezone / overseas date wrong
- **This app does:** localisation and timezone defects
- **User reaction:** complaint
- **Magnitude:** 19 (0.93%) + 11 (0.54%)
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue; C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone)

### R18-114 — KR / JP / US own-denominator rates: free-tier restriction 6.38% / 8.07% / 8.33% (all HIGH); trial/billing 7.07% / 5.38% / 2.38%; entitlement failure 1.19% / 2.24% (mean 1.00★) / 0; data loss 6.32% / 6.28% / 2.38%; crash 5.69% / 3.14% / 10.71%; widget 11.57% / 7.62% / 11.90%; order/edit 7.44% / 2.69% / 4.76%; complexity 6.75% / 10.76% / 8.33%; localisation 0.31% / 3.14% / 0; timer 1.31% / 6.28% / 8.33%; ADHD 1.44% / 3.14% / 5.95%; social 3.69% / 0.90% / 3.57%; merged view 2.75% / 0.45% / 1.19%; confirmed payer 8.94% / 6.28% / 3.57%; design praise 7.44% / 12.11% / 11.90%; life change 6.13% / 9.87% / 5.95%

- **Where:** §7.1 The three eligible storefronts (≥50 reviews) — theme comparison table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme (own-storefront denominator) | KR n=1,599 | JP n=223 | US n=84 ; Free-tier restriction | 102 (6.38%) HIGH | 18 (8.07%) HIGH | 7 (8.33%) HIGH ; Trial/billing dispute | 113 (7.07%) HIGH | 12 (5.38%) HIGH | 2 (2.38%) Meaningful ; Entitlement failure | 19 (1.19%) | 5 (2.24%), mean 1.00★ | 0 ; Data loss | 101 (6.32%) HIGH | 14 (6.28%) HIGH | 2 (2.38%) ; Crash | 91 (5.69%) HIGH | 7 (3.14%) | 9 (10.71%) HIGH ; Widget | 185 (11.57%) HIGH | 17 (7.62%) HIGH | 10 (11.90%) HIGH ; Order/edit restriction | 119 (7.44%) HIGH | 6 (2.69%) | 4 (4.76%) ; Complexity/confusion | 108 (6.75%) HIGH | 24 (10.76%) HIGH | 7 (8.33%) HIGH ; Localisation | 5 (0.31%) Weak | 7 (3.14%) Very strong | 0 ; Timer | 21 (1.31%) | 14 (6.28%) HIGH | 7 (8.33%) HIGH ; ADHD / neurodivergent | 23 (1.44%) | 7 (3.14%) Very strong | 5 (5.95%) HIGH ; Social layer | 59 (3.69%) Very strong | 2 (0.90%) Emerging | 3 (3.57%) Very strong ; Merged routine+to-do view | 44 (2.75%) | 1 (0.45%) | 1 (1.19%) ; Confirmed payer | 143 (8.94%) HIGH | 14 (6.28%) HIGH | 3 (3.57%) ; Praise: design | 119 (7.44%) HIGH | 27 (12.11%) HIGH | 10 (11.90%) HIGH ; Praise: life change | 98 (6.13%) HIGH | 22 (9.87%) HIGH | 5 (5.95%) HIGH
- **Direction for us:** none · **Report confidence:** ≥50 storefronts · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R18-115 — Korea is the only storefront where the social layer is very strong (3.69%) and where the merged routine+to-do view matters at scale; the paywall history is lived in full there; Korean reviews are the longest and most structured — several read as unpaid product consultancy; KR-specific mechanics: KakaoTalk login breaks repeatedly on PC/Mac, KakaoTalk is the only support channel and is closed at weekends, and reviewers ask for KakaoPay and Kakao gifting

- **Where:** §7.1 Korea (n=1,599, mean 3.95) — the home market and the whole business
- **This app does:** KakaoTalk login/support; no KakaoPay
- **User reaction:** mixed
- **Magnitude:** n=1,599 (78.08%), mean 3.95; confirmed payer 8.94%
- **Direction for us:** do · **Report confidence:** ≥50 storefront · **Generalisable:** app-specific
- **Review IDs:** `10444375042`, `10851299280`, `11700463203`, `14184795326`, `13042903108`, `8221813827`, `8472416777`, `8572620032`, `10816022292`, `10574355802`, `11697109244`, `13244453495`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C036 A support channel that exists, is reachable outside the app, and answers

### R18-116 — Japan's deficit has three fixable causes: (1) localisation (3.14% very strong vs 0.31% KR) — Japanese Instagram ads led to an app that opened in Korean with a KakaoTalk login ('the Japanese is odd', half-Korean UI), largely fixed by 2 Sep 2022 but Korean push notifications persisted into 2023 and the terms page is English-only, which is why one reviewer refused to trial; (2) entitlement failures are catastrophic — 5 reviews, every one 1★ (mean 1.00); (3) the support channel is broken (feedback form rejects valid emails, text invisible in dark mode); strengths: timer 6.28% (vs 1.31% KR), ADHD fit 3.14%; JP uniquely asks for auto-advancing timers and Apple Watch timer parity

- **Where:** §7.1 Japan (n=223, mean 3.37 — 0.58 below Korea) — three fixable causes
- **This app does:** shipped JP marketing before JP localisation; broken JP support form
- **User reaction:** mixed
- **Magnitude:** n=223 (10.89%), mean 3.37; localisation 7 (3.14%); entitlement 5 (mean 1.00★); timer 14 (6.28%)
- **Direction for us:** do · **Report confidence:** ≥50 storefront · **Generalisable:** yes
- **Review IDs:** `8991795108`, `9042880275`, `9000746331`, `9041592638`, `9044125551`, `10540063845`, `12024690867`, `14238803827`, `14248568509`, `14247429732`, `14179422656`, `12777592140`, `13757721182`, `13576075338`, `13712167027`, `9744682977`, `14328062792`, `14045116089`, `13435011015`, `12428102869`, `13431240197`
- **Canonical:** C027 Localise early — it unlocks revenue; C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C132 Do not sell in a storefront where the app cannot function

### R18-118 — The US storefront is two populations: Korean-diaspora users (13 of 84 in Korean) who hit the timezone bug (US daylight saving unhandled; asks for a refund), and native English users for whom ADHD fit (5.95%, the highest of any storefront) and the timer (8.33%) dominate praise while crashes (10.71%) and sign-in requirements dominate criticism; several US teen/child reviewers describe the app as completely free — the opposite of KR/JP in the same period — either the free tier is enforced differently or they had not yet hit the completion quota: a research question, not a finding

- **Where:** §7.1 United States (n=84, mean 3.82) — two populations
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** n=84 (4.10%), mean 3.82; ADHD 5 (5.95%); timer 7 (8.33%); crash 9 (10.71%)
- **Direction for us:** research · **Report confidence:** ≥50 storefront · **Generalisable:** app-specific
- **Review IDs:** `7667185054`, `8850150608`, `10288775267`, `8288427147`, `8592955634`, `11951042522`, `11067291310`, `11993264527`, `12292226361`, `12234125678`, `12244913951`, `11432555244`, `11538265895`, `12230682122`, `13866825904`
- **Canonical:** C031 Crashes / launch failures; C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone); C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R18-120 — High-spend group present (US, JP, KR, GB, DE, CA, AU, FR, TW) = 1,996 of 2,048 (97.46%); review volume is not used as a download or revenue proxy; per storefront: kr 1,599 (3.95) paywall history/reliability/reorder; jp 223 (3.37) localisation/entitlement/support; us 84 (3.82) crashes/sign-in/onboarding, ADHD strength; tw 35 (2.60) billing/refund; gb 23 (3.48) paywall/onboarding/sign-in; au 17 (3.71) onboarding excludes shift workers, 'predatory' paywall; ca 15 (3.20) onboarding length + paywall, timezone; fr 6 (2.83) localisation, complexity; de 2 (1.00) billing

- **Where:** §7.2 High-spend markets — definition and its limits; high-spend storefront table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** High-spend storefront | n | Mean ★ | Dominant issue ; kr | 1,599 | 3.95 | Paywall history, reliability, reorder friction ; jp | 223 | 3.37 | Localisation, entitlement failure, support channel ; us | 84 | 3.82 | Crashes, sign-in wall, onboarding; ADHD strength ; tw | 35 | 2.60 | Billing/refund — see below ; gb | 23 | 3.48 | Paywall, onboarding confusion, sign-in failure ; au | 17 | 3.71 | Onboarding excludes shift workers; "predatory" paywall ; ca | 15 | 3.20 | Onboarding length + paywall; timezone ; fr | 6 | 2.83 | Localisation (2023), complexity ; de | 2 | 1.00 | Billing (both reviews)
- **Direction for us:** none · **Report confidence:** market table · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R18-121 — Taiwan: 35 reviews, mean 2.60 — 1.35 stars below Korea — and the cause is not the product: 12 of 35 (34.3%) are billing complaints describing one mechanism — the promotional price shown is not the price charged and the refund path dead-ends; Traditional Chinese is largely Simplified wording with untranslated strings ('a paid app should mind this detail'); product complaints are ordinary; fixing the TW price/refund flow and zh-Hant strings is a high-yield, low-engineering intervention in a top-tier spend market

- **Where:** §7.2 Taiwan is the clearest, most fixable market failure in the corpus
- **This app does:** promo price ≠ charged price; refund dead-end; zh-Hant is really zh-Hans
- **User reaction:** 1★-burst
- **Magnitude:** n=35, mean 2.60; billing 12 (34.3%)
- **Direction for us:** do · **Report confidence:** sub-50 but severe · **Generalisable:** yes
- **Review IDs:** `13994502099`, `14344435230`, `14286926161`, `14196174434`, `14257555510`, `14341166322`, `14458138589`, `14249011988`, `14258618311`, `14130826250`, `14029976650`, `14031409160`, `13819899467`, `13895676942`, `14209593301`, `14011038948`, `14026637069`
- **Canonical:** C027 Localise early — it unlocks revenue; C112 In-app cancellation; C113 One stable, disclosed price — no discount wheels

### R18-122 — Hong Kong is the lowest-rated storefront (n=7, mean 1.29) — 6 of 7 are paywall or bug reports in Cantonese, none a product-quality complaint; below threshold, flagged for investigation not action

- **Where:** §7.2 Hong Kong (n=7, mean 1.29) — lowest-rated storefront; limited evidence
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** n=7, mean 1.29
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `14393820099`, `14429093675`
- **Canonical:** C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R18-123 — High-review-volume storefronts by this corpus: kr, jp, us — 1,906 reviews, 93.07%; review volume reflects where the app has been marketed, not where it has most users

- **Where:** §7.3 High-review-volume storefronts
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 1,906 (93.07%)
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R18-124 — Sub-50 notes: gb (23, 3.48) corroborates onboarding friction on a Pro account, sign-in failure, the listing/feature mismatch on the timer, the corpus's only defence of the pricing and its clearest autistic-user usability report; au (17, 3.71) the sharpest positioning critique, 'predatory dark pattern', a teen's age-gate/age-rating mismatch; ca (15, 3.20) three independent onboarding-abandonment reviews, one noting the in-app support link resolves to an ad; nl (5, 2.40) Dutch translation unintelligible and the displayed price moved 'from over 200 to 68 to 19.90', destroying trust; ads added to the free tier May 2026; fr (6, 2.83) French advertised but unavailable Feb 2023, working by May 2023; vn (7, 4.14) and th (3, 4.67) the most positive small storefronts, price the only reservation; de, ru, br, lt all 1★, all billing or paywall

- **Where:** §7.4 Sub-50 storefronts — limited-evidence notes (gb, au, ca, hk, nl, fr, vn, th, de, ru, br, lt)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 12 storefronts under 50
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `14437815273`, `14379439679`, `14331337303`, `14031166609`, `13149940985`, `12445646540`, `13894901307`, `12857404582`, `13218586893`, `13729043534`, `13848157788`, `13724277153`, `14117739778`, `9641708600`, `9977436595`, `11925026971`, `13172565846`, `10650286400`
- **Canonical:** C113 One stable, disclosed price — no discount wheels; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional; C209 No sign-up wall before first use

## Dated events and trends

### R18-010 — Capabilities users already possessed were withdrawn, usually to create Pro value, and every withdrawal produced a rating trough: ~Sep 2021 iPad landscape withdrawn; 2022 15-routine cap begins blocking check-off not just creation; Apr 2022 free use effectively time-limited; 24–26 Oct 2022 interstitial ad on every check-off (17+ reviews in following weeks); late 2022/early 2023 web/desktop discontinued; May 2023 highlighter free→Pro; Nov 2023 to-do list free→Pro; Dec 2023–Jan 2024 free routines 15→8, short memo →5/week, highlighter →1 colour, friend-invite bonus routines revoked; Jul 2024→2025 condition-check, weight/number trackers, statistics moved behind Pro (and partly back); Sept 2024 routine/to-do split, weekly view removed, Challenge removed

- **Where:** §0.5 Five years of removing things people already had; removal table (verbatim)
- **This app does:** serial feature withdrawal to create Pro value
- **User reaction:** 1★-burst
- **Magnitude:** When | What was removed or restricted | Evidence ; ~Sep 2021 | iPad landscape mode withdrawn | 7762347992 (*"가로모드 중단이요..?"*), 7891611908, 7960129120, 8049542760, 8107694384 (*"landscape only, and I'd buy"*) ; 2022 (through year) | 15-routine cap begins blocking check-off, not just creation | 8199492162, 8214659011, 8548522332, 9072388493, 9092043014 ; Apr 2022 | Free use effectively time-limited | 8601996746 (*"프로멤버쉽 아니면 루틴 지속을 일주일도 못하네요"*) ; 24–26 Oct 2022 | Interstitial ad on every check-off | 17+ reviews in the following weeks: 9223090299, 9223234624, 9223910581, 9228413942, 9230911524, 9230913085, 9239767151, 9242285983, 9245789487, 9247722324, 9256280526, 9257333050, 9259537674, 9260428008, 9349646831 ; late 2022 / early 2023 | Web / desktop version discontinued | 9513306665 (*subscribed a year* because of desktop), 9878312095, 9791158691, 10179190547 ; May 2023 | Highlighter moved free → Pro | 9892001293 (*"있던걸 뺏기 있나요"* — "you take away what already existed?") ; Nov 2023 | To-do list moved free → Pro | 10598930656 (a teacher using it with a class), 10602078683, 10626638051, 10645526932, 10656234239, 10656594581, 10666557187, 10775337514, 10787375859 (jp) ; Dec 2023 – Jan 2024 | Free routines 15 → 8; short memo → 5/week; highlighter → 1 colour; friend-invite bonus routines revoked | 10754519109, 10772477035, 10773481361, 10773703235, 10729003648, 10570170204, 10883150036, 10914801439, 10788981444 (jp: *"改悪"*) ; Jul 2024 → 2025 | Condition-check, weight/number trackers, statistics moved behind Pro (and partly back) | 11536013545, 12350930181, 12497207499, 12706210535 (notes the flip-flop fragmented their data), 11815241341 ; Sept 2024 | Routine and To-do split into separate tabs; weekly view removed; Challenge feature removed | see §0.6
- **Direction for us:** product-rule · **Report confidence:** close reading, illustrative IDs · **Generalisable:** yes
- **Review IDs:** `7762347992`, `8199492162`, `8601996746`, `9223090299`, `9513306665`, `9892001293`, `10598930656`, `10754519109`, `11536013545`
- **Canonical:** C001 Never move a free feature behind the paywall; C104 Never ship a paywall or feature-removal change silently; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R18-019 — 32 reviews between 6 Sep 2024 and 29 Jan 2025 protest one redesign, mean 4.25★ — the loyal paying base, not churned free users; before: routines and one-off to-dos interleaved in a single reorderable time-ordered list; after: two separate tabs; interleaving expressed when a to-do had to happen and expressed priority for free — separated it's 'barely different from writing tasks in the Notes app'; one subscribed for a year because of the merged view and it was removed days later; one paid and the split shipped the next day; a 22-day-streak 1-year subscriber has stopped opening the app; ADHD US user: 'The best features are gone now and I'm going back to using the notes app'; still requested 19 months later by paying users; nobody asked for the split — one clear defender plus a handful who came to prefer it

- **Where:** §0.6 September 2024: the app removed the exact thing that made people pay for it
- **This app does:** split the interleaved routine+to-do list into two tabs
- **User reaction:** churn
- **Magnitude:** 32 reviews (1.56%, meaningful, mean 4.25★) 6 Sep 2024–29 Jan 2025; still asked Apr–May 2026
- **Direction for us:** product-rule · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `11700463203`, `11727453236`, `11714930552`, `11729996278`, `11702770360`, `11703079091`, `11701377230`, `13922137845`, `14128340502`, `11703838844`, `12118393284`
- **Canonical:** C050 One-off to-dos alongside habits; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R18-041 — Per-year means: 2020 4.111 (n72) · 2021 4.227 (132) · 2022 4.142 (253; JP 2.875) · 2023 3.976 (287; JP 3.267) · 2024 3.707 (475; JP 3.700) · 2025 3.928 (470; KR 4.048, JP 3.550) · 2026 to 6 Sep 3.290 (359; KR 3.527, JP 3.032) — 2026 is the worst year on record in every major storefront; the corpus ends on its lowest note

- **Where:** §1.7 By year table (verbatim) — 2026 is the worst year on record, in every major storefront
- **This app does:** rating decline 2021 peak 4.227 → 2026 3.290
- **User reaction:** churn
- **Magnitude:** Year | n | Mean ★ | KR mean | JP mean ; 2020 | 72 | 4.111 | 4.111 | — ; 2021 | 132 | 4.227 | 4.244 | — ; 2022 | 253 | 4.142 | 4.224 | 2.875 ; 2023 | 287 | 3.976 | 4.051 | 3.267 ; 2024 | 475 | 3.707 | 3.750 | 3.700 ; 2025 | 470 | 3.928 | 4.048 | 3.550 ; 2026 (to 6 Sep) | 359 | 3.290 | 3.527 | 3.032
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R18-049 — Free allowance by period: 2020 H2 3-week trial then a 'free membership'; Aug 2021 10 routines; Oct 2021–2023 15 routines (+ up to ~8 via friend invites → 23); Nov 2023 to-do Pro-only; Dec 2023–mid 2024 8 routines, short memo 5/week, invite bonuses revoked; late 2024–2026 10 habits but ticking consumes a 14/week memo quota — the cap number is the advertised limit, the binding limit is completions

- **Where:** §2.2 Free tier as reported, by period (verbatim table)
- **This app does:** free cap shrank 15 → 8 → 10-with-metered-completions
- **User reaction:** complaint
- **Magnitude:** Period | Advertised free allowance | Evidence ; 2020 H2 | 3-week trial, then a "free membership" | 6526765963, 6533185954, 6929097900 ; Aug 2021 | 10 routines | 7692904522 ; Oct 2021 – 2023 | 15 routines (+ up to ~8 more via friend invites → 23) | 7952223213, 8174800592, 8657868688, 10729003648 ; Nov 2023 | To-do becomes Pro-only | 10598930656 and 8 others ; Dec 2023 – mid 2024 | 8 routines, short memo 5/week, invite bonuses revoked | 10754519109, 10772477035, 10857167531 ; late 2024 – 2026 | 10 habits, but ticking consumes a 14/week memo quota | 12036038200, 13202762473, 14393820099
- **Direction for us:** product-rule · **Report confidence:** review-derived · **Generalisable:** yes
- **Review IDs:** `6526765963`, `7692904522`, `7952223213`, `10598930656`, `10754519109`, `12036038200`, `13202762473`, `14393820099`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C200 Never meter the completion action — a free cap may limit habits, never check-offs

### R18-072 — 52.20% 5★ and 16.21% 1★ with only 5.32% 2★ — people either found their app or hit a wall; in 2026 the 5★ share falls to 38.7% (139/359) and 1★ rises to 27.6% (99/359), the worst mix in the corpus

- **Where:** §3.2 The rating distribution is bimodal, and 2026 hollowed out the top
- **This app does:** bimodal, worsening
- **User reaction:** mixed
- **Magnitude:** 2026: 5★ 38.7% (139/359), 1★ 27.6% (99/359)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R18-128 — Eras anchored to dated clusters of ≥10 reviews: E1 launch/web era/feature build-out 2020-07-06→2022-10-23 n419 mean 4.217; E2 ads era + first restrictions 2022-10-24→2023-11-14 n264 4.064; E3 paywall tightening (to-do → Pro, cap 15→8) 2023-11-15→2024-08-31 n319 3.527; E4 split/rebuild/bundles/timer/modes 2024-09-01→2025-11-30 n656 3.930; E5 modes + billing crisis 2025-12-01→2026-09-06 n390 3.303

- **Where:** §8.1 Method — era table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Era | Window | n | % | Mean ★ | 5/4/3/2/1 ; E1 Launch, web era, feature build-out | 2020-07-06 → 2022-10-23 | 419 | 20.5% | 4.217 | 258/73/42/13/33 ; E2 Ads era + first restrictions | 2022-10-24 → 2023-11-14 | 264 | 12.9% | 4.064 | 157/40/23/15/29 ; E3 Paywall tightening (to-do → Pro, cap 15→8) | 2023-11-15 → 2024-08-31 | 319 | 15.6% | 3.527 | 146/41/35/29/68 ; E4 Split, rebuild, bundles, timer, modes | 2024-09-01 → 2025-11-30 | 656 | 32.0% | 3.930 | 356/117/61/25/97 ; E5 Modes + billing crisis | 2025-12-01 → 2026-09-06 | 390 | 19.0% | 3.303 | 152/51/55/27/105
- **Direction for us:** none · **Report confidence:** era definition · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R18-129 — Monetisation friction by era E1→E5: free-tier restriction 2.63 / 2.65 / 10.97 / 6.10 / 11.79%; trial/billing 0.95 / 5.30 / 8.15 / 8.08 / 12.05%; entitlement failure 0 / 0 / 1.25 / 0.46 / 4.36%; promo-nag 1.19 / 0 / 3.13 / 2.13 / 2.56%; confirmed payer 3.82 / 5.30 / 9.09 / 7.77 / 13.08%; two spikes, two causes — E3's paywall spike is the Nov 2023–Jan 2024 tightening; E5's is worse: billing disputes and entitlement failures rising together while the payer share hits its all-time high — in E5 4.36% of all reviews are from someone who paid and could not use what they bought, a 9.5× increase over E3

- **Where:** §8.2 Trend 1 — Worsening and dominant: monetisation friction (verbatim table)
- **This app does:** monetisation friction worsening
- **User reaction:** churn
- **Magnitude:** Theme | E1 | E2 | E3 | E4 | E5 ; Free-tier restriction | 2.63% | 2.65% | 10.97% | 6.10% | 11.79% ; Trial/billing dispute | 0.95% | 5.30% | 8.15% | 8.08% | 12.05% ; Entitlement failure | 0% | 0% | 1.25% | 0.46% | 4.36% ; Promo-nag | 1.19% | 0% | 3.13% | 2.13% | 2.56% ; Confirmed payer | 3.82% | 5.30% | 9.09% | 7.77% | 13.08%
- **Direction for us:** product-rule · **Report confidence:** era series · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R18-130 — Stability by era E1→E5: crash 7.40 / 4.17 / 8.15 / 4.27 / 3.85%; lag 4.77 / 4.17 / 3.76 / 1.83 / 5.38%; data loss 3.58 / 7.95 / 6.58 / 6.25 / 6.41%; crashes improved from the Dec-2020 epidemic and the Nov-2023 wave; lag was solved by E4 and regressed sharply in E5 (1.83% → 5.38%) coinciding with routine modes, intensity levels and note/tracker features; data loss has never improved — 6–8% in every era after E1, five years running, the single most durable defect

- **Where:** §8.3 Trend 2 — Improving then regressing: stability (verbatim table)
- **This app does:** data loss never fixed; lag regressed with feature load
- **User reaction:** churn
- **Magnitude:** Theme | E1 | E2 | E3 | E4 | E5 ; Crash | 7.40% | 4.17% | 8.15% | 4.27% | 3.85% ; Lag | 4.77% | 4.17% | 3.76% | 1.83% | 5.38% ; Data loss | 3.58% | 7.95% | 6.58% | 6.25% | 6.41%
- **Direction for us:** must-never-break · **Report confidence:** era series · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C083 Performance must not degrade with habit count

### R18-131 — Widget mentions are the largest single theme (214, 10.45%) and their character inverts: before Dec 2021 31 reviews mean 4.77★, pure requests (one would have paid for it); after launch the top defect surface — blank widgets, disappearing from the picker, wrong weekday, false 'all done', check-off opening the app, routine widget rendering to-dos, font too large; the single most-repeated widget request across five years and every language is 'let me check off without launching the app' — some builds fixed it (jp, Jul 2025) then it regressed

- **Where:** §8.4 Trend 3 — The widget: from the top request to the top bug surface
- **This app does:** widget shipped, then became the top bug surface; interactive check-off fixed then regressed
- **User reaction:** mixed
- **Magnitude:** 214 (10.45%); pre-launch 31 at 4.77★; 11 defect IDs; 4 request IDs 2021→2025
- **Direction for us:** must-never-break · **Report confidence:** era series · **Generalisable:** yes
- **Review IDs:** `8039445612`, `11601155435`, `11557007642`, `11554836033`, `12458833524`, `13210725274`, `13597417182`, `13924535491`, `14128340502`, `11599563000`, `10106353303`, `13282158897`, `8173262340`, `9556123553`, `10861517833`, `13101423234`, `12926497490`, `13278083524`
- **Canonical:** C023 Interactive widget check-off; C040 Widgets must not go blank, stale or disagree with the app

### R18-132 — ADHD/neuro theme by era: E1 0.72% · E2 1.89% · E3 0% (classifier; qualitatively present) · E4 3.05% · E5 1.54%; the KR title now reads 'ADHD 하루 계획표 앱'; the corpus supports the positioning (mean 4.53★, specific mechanism praise) but the same population is most damaged by streak mechanics and the onboarding excludes exactly the irregular-schedule lives ADHD users often have — the positioning is ahead of the product

- **Where:** §8.5 Trend 4 — Emerging and now central: ADHD and neurodivergent positioning (verbatim table)
- **This app does:** ADHD positioning in title; product not yet aligned
- **User reaction:** mixed
- **Magnitude:** Era | ADHD/neuro theme ; E1 | 0.72% ; E2 | 1.89% ; E3 | 0% (classifier; qualitatively present) ; E4 | 3.05% ; E5 | 1.54%
- **Direction for us:** do · **Report confidence:** era series · **Generalisable:** yes
- **Review IDs:** `13842532454`, `12445646540`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R18-133 — Unresolved in every era and still open in the last month: reorder friction / can't edit future dates 2020-12→2026-09; data loss 2020-12→2026-09; widget check opens the app 2021-12→2026; diary/memo aggregation missing 2022-01→2026-02; no export 2020-11→2026-03 (asked for Excel export in the app's 5th month); statistics without charts or trend 2022→2026; timezone wrong for overseas users 2021-08→2024-11; UI vocabulary confusion (습관 vs 루틴 vs 모드) 2022→2026; a typo in a daily popup ('오늘도 수고 많았아요') still unfixed after a year

- **Where:** §8.6 Trend 5 — Persisted unchanged across all five years (verbatim table)
- **This app does:** nine defects/gaps persisted five years
- **User reaction:** complaint
- **Magnitude:** Theme | Span | Latest evidence ; Reorder friction / can't edit future dates | 2020-12 → 2026-09 | 6813254462 (2020) → 13853005780 (Mar 2026) ; Data loss | 2020-12 → 2026-09 | 6755246776 → 14496075544 (1 Sep 2026) ; Widget check opens the app | 2021-12 → 2026 | 8173262340 → 14128340502 ; Diary/memo aggregation missing | 2022-01 → 2026-02 | 8278766556 → 13700701827 ; No export | 2020-11 → 2026-03 | 6164039764 (asked for Excel export in the app's 5th month) → 13843048940 ; Statistics without charts or trend | 2022 → 2026 | 10444375042 → 14184795326 ; Timezone wrong for overseas users | 2021-08 → 2024-11 | 7667185054 → 11951042522 ; UI vocabulary confusion (습관 vs 루틴 vs 모드) | 2022 → 2026 | 12272956378, 13439818706, 14232607477 ; A typo in a daily popup | ≥2025 → Aug 2026 | 14462318051: *"오늘도 수고 많았아요"* still unfixed after a year
- **Direction for us:** must-never-break · **Report confidence:** era series · **Generalisable:** yes
- **Review IDs:** `6813254462`, `13853005780`, `6755246776`, `14496075544`, `8173262340`, `14128340502`, `8278766556`, `13700701827`, `6164039764`, `13843048940`, `10444375042`, `14184795326`, `7667185054`, `11951042522`, `12272956378`, `13439818706`, `14232607477`, `14462318051`
- **Canonical:** C020 Data export / backup / CSV; C034 Data must never be lost on update, reinstall or phone change; C038 Dates, streaks and statistics correct on every surface (incl. DST / timezone); C073 Manual reordering, renaming and editing of habits/tasks — free

## Positioning

### R18-001 — MyRoutine / 마이루틴 (App Store ID 1518956326) — 'Organize your day · Built around your real life' — a Korean routine/habit tracker with to-dos, diary, timer and a light social layer; the decision it informs is how to price and package a habit app people genuinely love when five years of monetisation changes have converted its most loyal users into its angriest reviewers

- **Where:** header lines 1-10; §1.6 External sources; §10.6
- **This app does:** developer Minding. co., Ltd.; bundle com.minding.myroutine; category Productivity; KR listing 4.8★ from ~25,000 ratings, US 4.8★ from ~3.3K, version 34.28 (accessed 10 Sep 2026); KR store title now includes 'ADHD 하루 계획표 앱'; store rank 18
- **User reaction:** mixed
- **Magnitude:** 2,048 written reviews, 29 storefronts, 6 Jul 2020 → 6 Sep 2026 (75 calendar months); written mean 3.824
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R18-085 — Named competitors: TodoMate 6 (the main alternative — a lifetime buyer left for it over statistics, export and diary aggregation; one switched to MyRoutine from it); Notion 7 (benchmark for 'too complex' and the thing MyRoutine failed to replace); Routinery 4 (better routine-timer widget — one runs both apps; recommends copying Routinery and Structured); Apple Reminders 7 (the fallback when the paywall or complexity wins); Apple Notes 2 (ADHD user returned after the Sept-2024 split); TimeTree, Structured, Daystamp, 플래닛, 1day스케줄, 아시스트가이드, Blocos, 심스페이스 1–2 each as models for calendars, widgets and timers

- **Where:** §3.4 Competitors reviewers name (verbatim table)
- **This app does:** compared against TodoMate, Notion, Routinery, Apple Reminders/Notes
- **User reaction:** mixed
- **Magnitude:** Competitor | n | Context ; 투두메이트 / TodoMate | 6 | The main named alternative. 11427388698 (a lifetime buyer) left for it over statistics, export and diary aggregation. Also 11646296464, 12122589601, 13563271747, 9912306722 (switched *to* MyRoutine), 8761641540 ; Notion | 7 | Both a benchmark for "too complex" (9514694714) and the thing MyRoutine failed to replace (9878312095, 11442188567, 12629011104) ; 루티너리 / Routinery | 4 | Named for a better routine-timer widget. 14127953337 runs both apps solely for that widget; 12023625379 recommends copying it and Structured ; Apple Reminders | 7 | The fallback when MyRoutine's paywall or complexity wins: 13719591657 (jp), 13771499654, 9775832874 ; Apple Notes | 2 | 11703079091 (us, ADHD) returned to Notes after the Sept-2024 split ; TimeTree, Structured, Daystamp, 플래닛, 1day스케줄, 아시스트가이드, Blocos, 심스페이스 | 1–2 each | Named as models for calendars, widgets and timers
- **Direction for us:** do · **Report confidence:** named counts · **Generalisable:** app-specific
- **Review IDs:** `11427388698`, `11646296464`, `12122589601`, `13563271747`, `9912306722`, `8761641540`, `9514694714`, `9878312095`, `11442188567`, `12629011104`, `14127953337`, `12023625379`, `13719591657`, `13771499654`, `9775832874`, `11703079091`
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R18-012 — An interstitial ad on every check-off shipped 24–26 Oct 2022 and produced 17+ protest reviews in the following weeks

- **Where:** §0.5 Interstitial ad on every check-off (24–26 Oct 2022)
- **This app does:** interstitial ad on the core action
- **User reaction:** 1★-burst
- **Magnitude:** 17+ reviews in following weeks
- **Direction for us:** dont · **Report confidence:** close reading (dated burst) · **Generalisable:** yes
- **Review IDs:** `9223090299`, `9223234624`, `9223910581`, `9228413942`, `9230911524`, `9230913085`, `9239767151`, `9242285983`, `9245789487`, `9247722324`, `9256280526`, `9257333050`, `9259537674`, `9260428008`, `9349646831`
- **Canonical:** C082 Ads in the free tier; C093 No upsell nagging without a 'never ask again' option

### R18-023 — Onboarding is the lowest-rated theme in the report — 34 reviews, mean 2.03★ — and these reviewers never reached the product: (1) the survey is long and feels like a funnel — 'makes you fill out a survey then wants you to pay BEFORE YOU EVEN SEE THE APP'; 'I might've paid for this, if I could have seen literally anything past the questionnaire'; a Pro subscriber was forced through the questionnaire again; (2) it plans for you — 'you don't lead the plan, they do', titled 'an app that wants to turn you into a very ordinary machine'; 'They won't let me write my own routine'; (3) it excludes anyone without a 9-to-5 weekday life — shift worker: 'MY routine not your routine'; 3-shift, parent, night worker; (4) a pledge you must sign — 'I will become a better version of myself'; (5) no skip button, and it re-runs on existing accounts — restore-purchase loop returns you to onboarding; 'Don't treat me like an idiot'

- **Where:** §0.7 The onboarding is a conversion leak with an identifiable shape
- **This app does:** long mandatory survey → suggested plan → pledge signature → paywall, no skip, re-runs on existing accounts
- **User reaction:** blocked-conversion
- **Magnitude:** 34 reviews (1.66%, meaningful, mean 2.03★ — lowest of any theme)
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14031934887`, `13848157788`, `13218586893`, `13729043534`, `11481732875`, `14407318888`, `14437815273`, `12445646540`, `13390879707`, `12762108716`, `12098514129`, `13515738048`, `12495446710`, `10785117382`, `12245337065`, `12132150109`, `12784378291`, `14082437879`, `14232098480`, `12802740109`, `13953352894`, `12265439660`
- **Canonical:** C075 Skippable, replayable onboarding tour; C111 No long quiz before the price; show the price up front; C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R18-051 — Interstitial ads on check-off (~24–26 Oct 2022) were softened by ~Dec 2022 (Apr 2023: remaining ads 'minimal and clean'); a persistent bottom promo bar and a Dynamic Island discount countdown appear in 2025–26 and are experienced as worse than the 2022 ads — 'Absolutely the worst choice' (nl)

- **Where:** §2.2 Ads — 2022 interstitials softened; 2025–26 persistent promo bar and Dynamic Island discount countdown experienced as worse
- **This app does:** in-app upsell bar + Dynamic Island countdown
- **User reaction:** complaint
- **Magnitude:** 11 named IDs 2025–26 incl. jp ×2, nl
- **Direction for us:** dont · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `9349646831`, `9790998955`, `14164985475`, `14330193137`, `14472024199`, `13425678335`, `14510091242`, `14232460077`, `12941484108`, `12949129516`, `14071210641`, `14089424168`, `14117739778`
- **Canonical:** C082 Ads in the free tier; C093 No upsell nagging without a 'never ask again' option; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall

### R18-062 — In-app ads/promo interstitials (46, 2.25%, 2.70★) and upgrade-nag/promo bar/countdown (40, 1.95%, 2.40★) are both meaningful and among the lowest-rated themes; promo-nag is 5.42% of 1★ and ads 4.82% of 1★

- **Where:** §3.1 In-app ads / promo interstitials; Upgrade-nag / promo bar / countdown
- **This app does:** ads + promo bar + countdown
- **User reaction:** 1★-burst
- **Magnitude:** 46 (2.25%, 2.70★, 16 1★) + 40 (1.95%, 2.40★, 18 1★)
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `14164985475`, `14117739778`
- **Canonical:** C082 Ads in the free tier; C093 No upsell nagging without a 'never ask again' option

### R18-126 — A CA reviewer notes the in-app support link resolves to an ad

- **Where:** §7.4 ca — in-app support link resolves to an ad
- **This app does:** support link → ad
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** dont · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `13729043534`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R18-135 — A typo in a daily popup ('오늘도 수고 많았아요') is still unfixed after a year — a visible signal of neglect on the most-seen surface

- **Where:** §8.6 A typo in a daily popup still unfixed after a year
- **This app does:** unfixed typo on a daily surface
- **User reaction:** complaint
- **Magnitude:** n=1, ≥2025 → Aug 2026
- **Direction for us:** do · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `14462318051`
- **Canonical:** C071 Never ship and walk away

## Things not to do

### R18-025 — A forced pledge signature — 'I will become a better version of myself' — before proceeding reads as 'spiritual or self-improvement-cult vibe' and repelled a JP reviewer; a CA reviewer hit a signature step it wouldn't let them complete

- **Where:** §0.7 (4) A pledge you must sign
- **This app does:** mandatory pledge signature in onboarding
- **User reaction:** blocked-conversion
- **Magnitude:** 2 IDs
- **Direction for us:** dont · **Report confidence:** close reading · **Generalisable:** yes
- **Review IDs:** `14082437879`, `13848157788`
- **Canonical:** C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R18-107 — 'A pro member should be a pro member regardless of whether they are paying monthly or yearly' — a monthly user nagged daily to go annual; a JP 'buy the next term' screen blocks the app entirely

- **Where:** §5.4 #5 Being marketed to after paying
- **This app does:** upsells paying members
- **User reaction:** complaint
- **Magnitude:** 4 named IDs
- **Direction for us:** dont · **Report confidence:** ordered by trust breach · **Generalisable:** yes
- **Review IDs:** `13492813619`, `12862293051`, `13785665369`, `14179422656`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option; C127 Never show ads to paying subscribers

## Things to do

### R18-142 — Fix the Japanese feedback form (Japan cannot report bugs) and the Taiwanese price/refund flow (TW at 2.60★ almost entirely from billing) — both are days of work in top-tier spend markets

- **Where:** §9.1 I5. Fix the Japanese feedback form and the Taiwanese price/refund flow
- **This app does:** broken JP form; TW promo-price mismatch
- **User reaction:** 1★-burst
- **Magnitude:** JP 3 IDs; TW 12/35 billing
- **Direction for us:** do · **Report confidence:** recommendation (immediate) · **Generalisable:** app-specific
- **Review IDs:** `13757721182`, `13576075338`, `13712167027`
- **Canonical:** C027 Localise early — it unlocks revenue; C036 A support channel that exists, is reachable outside the app, and answers; C112 In-app cancellation

### R18-158 — Let people write their own habit first and answer questions later, or never — 'MY routine not your routine'

- **Where:** §9.4 Q1. The app is named MyRoutine and the onboarding builds *its* routine
- **This app does:** onboarding builds a suggested routine before the user's own
- **User reaction:** blocked-conversion
- **Magnitude:** n=1 sharpest + onboarding 34 (2.03★)
- **Direction for us:** must-have · **Report confidence:** recommendation (positioning) · **Generalisable:** yes
- **Review IDs:** `12445646540`
- **Canonical:** C203 Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional

### R18-160 — The ADHD positioning is real (highest-rated theme cluster, now in the store title) — earn it: configurable streaks, hideable UI, no punitive paywall on completion

- **Where:** §9.4 Q3. The ADHD positioning is real — earn it
- **This app does:** positions on ADHD ahead of the product
- **User reaction:** mixed
- **Magnitude:** ADHD 36 (1.76%, 4.53★)
- **Direction for us:** do · **Report confidence:** recommendation (positioning) · **Generalisable:** yes
- **Review IDs:** `13842532454`, `11067291310`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

## Contradictions

### R18-091 — Themes on both sides: widget 121 5★ vs 19 1★ (most-loved and most-broken surface simultaneously); order/reorder 73 vs 14 (loyal friction, not churn); streak/traffic light 57 vs 5 (beloved but the shield and streak can both demotivate); data loss 37 vs 31 (long-time users report and stay, new users report and leave); confirmed payer 75 vs 35 (the payer cohort is itself bimodal); billing dispute 52 vs 57 (the 52 five-star billing reviews are almost all 'great app, please refund me')

- **Where:** §4.2 Themes that appear on both sides of the line (verbatim table)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | 5★ | 1★ | Reading ; Widget | 121 | 19 | The most-loved and most-broken surface simultaneously ; Order/reorder | 73 | 14 | Mostly loyal users describing friction, not churn ; Streak/traffic light | 57 | 5 | Beloved, but see §0.9 — the shield and the streak can both demotivate ; Data loss | 37 | 31 | Splits by tenure: long-time users report and stay; new users report and leave ; Confirmed payer | 75 | 35 | The payer cohort is itself bimodal — see §5 ; Billing dispute | 52 | 57 | The 52 five-star billing reviews are almost all "great app, please refund me"
- **Direction for us:** none · **Report confidence:** rating band · **Generalisable:** yes
- **Canonical:** C040 Widgets must not go blank, stale or disagree with the app; C065 Paying customers are the highest 1★ risk — every paid feature must work

## Data caveats and method

### R18-002 — Method: overwhelmingly a Korean corpus — 1,599 of 2,048 (78.08%) KR, JP 223 (10.89%), US 84 (4.10%); only these three clear the 50-review bar, so every 'global' figure is Korea-weighted; storefront ≠ language (13 of 84 US reviews in Korean; 16 languages read, none discarded); public rating ~1 star above written (KR 4.8★ vs written 3.824, gap 0.98; KR-only written 3.949 gap 0.85) — the report describes the population motivated enough to type, not the average user; counts come from a keyword classifier manually audited — floors, not measurements; signal bands: <0.1 ignore, 0.1–<0.5 weak, 0.5–<1 emerging, 1–<3 meaningful, 3–5 very strong, >5 high-priority

- **Where:** How to read this; Four things to know; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Limitations and judgement calls; §10.1 counting rules; §10.3 method audit trail
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 2,048/2,048 read; denominator 2,048 non-exclusive themes; 29 storefronts; 75 months
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R18-037 — Classifier precision audit: paywall_v3 45 sampled 36 true ≈80%; trial_billing_dispute ≈83%; data_loss ≈83%; crash ≈92%; entitlement_failure ≈83%; paid_confirmed ≈92%; two themes rejected and rebuilt (shift_work — bare '모드' matched 다크모드/가로모드; onboarding_friction 60% precision v1 → 1.66% v2); notifications split into a precise 'notification problem' subset; recall check on 136 unmatched 무료/無料/free/免費 reviews found several genuine paywall complaints — the paywall count of 139 is a floor; counts carry ~20% over-count risk; no app-version field, so every 'an update did X' is an inference from dated clusters — the three best-evidenced (Oct 2022 ads, Nov 2023–Jan 2024 tightening, Sept 2024 split) rest on 10+ same-window reviews

- **Where:** §1.4 Processing method — precision audit; §1.5 Counts are floors; §10.3 method audit trail
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 34 themes; 21 batches of 100; 6 precision samples
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R18-038 — 90 reviews (4.39%) are flagged is_edited and several visibly edit in response to a developer reply, so support quality can only be assessed from the user side

- **Where:** §1.5 Developer replies are not in the corpus
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 90 (4.39%) edited; 7 named IDs edited after a reply
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `8519301616`, `12023009972`, `13039376354`, `11103012143`, `14374239484`, `12109687708`, `14479635630`
- **Canonical:** — (nuance register)

### R18-039 — A cluster of native-English 4–5★ reviews with near-identical 'serial app-hopper who finally stuck with one' phrasing in a tight window (gb 10–29 Jun 2025 ×4, au 10 & 18 Jun 2025 ×2); a JP reviewer independently alleges fake reviews ('there are quite a few shills in the reviews') and a DE reviewer alleges fake lifetime promo codes; the six are treated as limited-evidence, excluded from qualitative conclusions, kept in counts

- **Where:** §1.5 Possible seeded / marketing-style reviews
- **This app does:** possible seeded English reviews Jun 2025
- **User reaction:** 5★-burst
- **Magnitude:** 6 reviews in 20 days; 2 independent allegations
- **Direction for us:** dont · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `12757322029`, `12767129702`, `12778751472`, `12831425768`, `12756530951`, `12790218793`, `13997904350`, `12543396557`
- **Canonical:** C076 Never seed launch reviews

### R18-053 — Negative/mixed themes ranked (denominator 2,048): free-tier restriction 139 (6.79%, 2.32★, 65 1★); trial/billing/refund 144 (7.03%, 2.90★); UI complexity/can't find things 149 (7.28%, 3.65★); order/reorder/future-date edit restriction 130 (6.35%, 4.07★); data loss 123 (6.01%, 3.27★); crash 111 (5.42%, 3.15★); lag/slow 76 (3.71%); sign-up/login required or broken 70 (3.42%, 3.13★); price objection 56 (2.73%, 3.30★); cross-device/web/Mac sync 55 (2.69%); ads 46 (2.25%, 2.70★); upgrade-nag/promo bar/countdown 40 (1.95%, 2.40★); onboarding 34 (1.66%, 2.03★); support unreachable 32 (1.56%, 2.72★); entitlement failure 25 (1.22%, 2.44★); notification not firing/can't silence 21 (1.03%); localisation defects 19 (0.93%); timezone/overseas date wrong 11 (0.54%)

- **Where:** §3.1 All themes, ranked — Negative and mixed themes (verbatim table)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** # | Theme | n | % | Mean ★ | 1★ | Signal ; 1 | Free-tier restriction blocks core use | 139 | 6.79% | 2.32 | 65 | HIGH ; 2 | Trial / billing / refund dispute | 144 | 7.03% | 2.90 | 57 | HIGH ; 3 | UI complexity / can't find things | 149 | 7.28% | 3.65 | 24 | HIGH ; 4 | Order / reorder / future-date edit restriction | 130 | 6.35% | 4.07 | 14 | HIGH ; 5 | Data loss / records reset / won't save | 123 | 6.01% | 3.27 | 31 | HIGH ; 6 | Crash / won't launch | 111 | 5.42% | 3.15 | 29 | HIGH ; 7 | Lag / slow / loading | 76 | 3.71% | 3.32 | 15 | Very strong ; 8 | Sign-up / login required or broken | 70 | 3.42% | 3.13 | 18 | Very strong ; 9 | Price objection | 56 | 2.73% | 3.30 | 16 | Meaningful ; 10 | Cross-device / web / Mac sync | 55 | 2.69% | 3.73 | 8 | Meaningful ; 11 | In-app ads / promo interstitials | 46 | 2.25% | 2.70 | 16 | Meaningful ; 12 | Upgrade-nag / promo bar / countdown | 40 | 1.95% | 2.40 | 18 | Meaningful ; 13 | Onboarding friction | 34 | 1.66% | 2.03 | 18 | Meaningful ; 14 | Support unreachable / unanswered | 32 | 1.56% | 2.72 | 15 | Meaningful ; 15 | Entitlement failure (paid, not applied) | 25 | 1.22% | 2.44 | 11 | Meaningful ; 16 | Notification not firing / can't silence | 21 | 1.03% | 3.57 | 4 | Meaningful ; 17 | Localisation defects | 19 | 0.93% | 3.58 | 1 | Emerging ; 18 | Timezone / overseas date wrong | 11 | 0.54% | 3.64 | 1 | Emerging
- **Direction for us:** none · **Report confidence:** theme table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R18-086 — The defining characteristic of MyRoutine's 5★ reviews is that most contain a complaint or request — 73 reorder friction, 52 billing disputes, 37 data loss, 31 crashes; reviewers say explicitly they rate high so the developer will read it ('giving 5 so the developer sees this'); top 5★ themes: widget 121 (11.3%), design 116 (10.9%), life-change 96 (9.0%), confirmed payer 75 (7.0%), order/edit 73 (6.8%), traffic light 57 (5.3%), social 48 (4.5%); unconditional praise clusters on life change, the traffic light's compulsion loop (got out of bed at 2:30am because of a red light), design and social

- **Where:** §4.1 5★ — n = 1,069 (52.20%); most 5★ reviews contain a complaint or a request
- **This app does:** 5★ used as a channel to the developer
- **User reaction:** mixed
- **Magnitude:** 1,069 5★ (52.20%); 73/52/37/31 complaint sub-counts
- **Direction for us:** none · **Report confidence:** rating band · **Generalisable:** yes
- **Review IDs:** `13977781381`, `12141615363`, `11894471289`, `10313873532`, `9091145019`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

### R18-161 — Research questions: (1) is the completions quota (14/week) real, current and global — verify in code and store metadata; (2) why do some US/CA users describe the app as 'completely free' in the same months KR/JP users are blocked — regional config, cohort assignment, or quota not yet reached; (3) the actual conversion effect of each paywall tightening — the corpus shows the sentiment cost precisely and the revenue benefit not at all; (4) what proportion of the 4.8★ / 25,000 tap-through ratings comes from users who hit the completion wall — the 0.98-star gap is the most important unexplained number; (5) is the GB/AU 5★ cluster of June 2025 organic; (6) do routine modes actually retain shift workers or only win them back briefly

- **Where:** §9.5 Research questions this corpus cannot answer; part 9 #1; part 9 #2; part 9 #3; part 9 #4; part 9 #5; part 9 #6
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 6 questions
- **Direction for us:** research · **Report confidence:** research questions · **Generalisable:** yes
- **Review IDs:** `14393820099`, `11432555244`, `12230682122`, `13866825904`, `14454264522`, `13795524849`
- **Canonical:** — (nuance register)
