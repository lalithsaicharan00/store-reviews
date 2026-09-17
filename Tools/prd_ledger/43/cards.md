# Cards — report 43

Source: `App Store Reports/43. Habit Hub - Routine Tracker - Daily Todo, Goals & Schedule (REPORT).md`  
143 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 8
- [Must-haves](#must-haves) — 11
- [Must never break](#must-never-break) — 18
- [Features](#features) — 21
- [Monetization](#monetization) — 9
- [Tactics the app used](#tactics-the-app-used) — 3
- [Insights (the why)](#insights-the-why) — 18
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 8
- [Dated events and trends](#dated-events-and-trends) — 15
- [Positioning](#positioning) — 3
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 3
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 19

## Product rules

### R43-014 — A redesign that adds a blocking modal with no opt-out turns long-time payers into 1★: the Oct 2025 redesign shipped a journal prompt on every skip — 'The latest update really is just bloatware. Long time paid user and pop up journal feature should have option to TURN OFF. Bad design to have to do skip every time. Furthermore the pop up is obscured by my keyboard' (1★, 17 Oct 2025); 'a bunch of distracting popups (prompts to write a note when skipping a habit, a weird calendar header that takes up too much space)… Wish we could get the older version' (2★, 18 Oct) — while three praise the same redesign ('The new design is amazing'; 'program your day windows and reorder items in time windows is fantastic'; 'After these changes this app is great again'); a settings toggle would neutralise both negatives — the cheapest fix in the report

- **Where:** Executive summary #8 — the October 2025 redesign split reviewers over modal popups: long-time payer 1★ 'pop up journal feature should have option to TURN OFF. Bad design to have to do skip every time… the pop up is obscured by my keyboard'; 2★ 'prompts to write a note when skipping a habit, a weird calendar header… Wish we could get the older version'; vs 'The new design is amazing'; 'program your day windows and reorder items in time windows is fantastic'; 'After these changes this app is great again' — a settings toggle neutralises both negatives
- **This app does:** journal-on-skip modal, no toggle
- **User reaction:** mixed
- **Magnitude:** 2 negative (1★, 2★) vs 3 positive
- **Direction for us:** product-rule · **Report confidence:** medium (redesign active) · **Generalisable:** yes
- **Review IDs:** `13278821225`, `13280430575`, `13284708645`, `13415356335`, `14436400155`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap

### R43-063 — A natural experiment in lifting a free cap: a 3-item cap on a habit tracker produced a decade-topping negative theme (mean 2.36, 25 one-star reviews, 16 accusations of false advertising); loosening it around 2021–22 removed the theme entirely within about two years and replaced it with free-tier praise (19, mean 4.63 — 'track unlimited amounts of habits for free'); three habits is below the threshold at which a habit tracker can demonstrate what it is for

- **Where:** §3.4.1 Interpretation — a natural experiment: a 3-item cap produced a decade-topping negative theme (2.36, 25 1★, 16 false-advertising accusations); loosening it removed the theme within ~two years and replaced it with praise_free_tier at 4.63 — three habits is below the threshold at which a habit tracker can demonstrate what it is for
- **This app does:** cap lifted ~2021–22
- **User reaction:** praise
- **Magnitude:** cap 66 (2.36) → 0; praise_free_tier 19 (4.63)
- **Direction for us:** product-rule · **Report confidence:** interpretation (dated) · **Generalisable:** yes
- **Review IDs:** `10869613654`, `11799865019`, `12410220634`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R43-116 — Add a settings toggle to disable the skip-journal popup and the calendar header from the Oct 2025 redesign — the cheapest fix in the report; two reviews, both recent, specific, one from a long-tenured payer, and the fix is a boolean

- **Where:** §8.1 #2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** popup_journal_2025 2 (1.50)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13278821225`, `13280430575`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks

### R43-127 — Treat the multi-step timer and the widget as protected surfaces in any redesign — the mechanics behind the listing's 'ADHD-friendly interface' claim, named by the fastest-growing segment and almost nobody else

- **Where:** §8.2 #13
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** ADHD / accessibility 25 (4.64)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `3743116260`, `7010047564`, `9164282595`, `9194130138`, `9195704288`
- **Canonical:** C009 Basic widgets, icons and colours are free; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C066 Focus timer

### R43-129 — Do not introduce a subscription — monetisation praise (89, mean 4.70) outnumbers all friction (87) by 2.25 stars and the one-time model is the most-cited reason for choosing the app over a named competitor; if recurring revenue is needed the corpus supports an optional supporter tier ('I would be happy to purchase it every year so they could continue to keep it up to date'), not a gate

- **Where:** §8.3 #15
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** monetization_praise 89 (4.70) vs friction 87 (2.45)
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `3627076218`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R43-130 — Do not re-tighten the free tier — 66 cap reviews at 2.36, 25 of 76 one-stars and 16 false-advertising accusations all stopped when the cap was loosened; this corpus is the natural experiment, do not re-run it

- **Where:** §8.3 #16
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** free_cap 66 (2.36) → 0
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R43-131 — Do not simplify away the configurability — customisation praised 46 (4.83), scheduling flexibility 17 (4.65); 'after a couple days you will appreciate the robust settings over the bare minimum other apps give' — setup complexity is a documentation problem, not a feature problem

- **Where:** §8.3 #17
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** customization 46; flexibility 17
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `7673068249`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R43-132 — Do not remove the nag loop or soften it into a single daily reminder — praised 22 (4.86), described as unavailable elsewhere, found excessive by one review in 638

- **Where:** §8.3 #18
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** praise_nag 22 (4.86) vs 1
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `6222322942`, `4277971819`
- **Canonical:** C258 A 'nag until done' repeating reminder — the one reminder shape reviewers say no other app offers

## Must-haves

### R43-016 — A powerful but opaque product needs an in-app help screen — named for nine straight years: no guide / tutorial / FAQ / help 9 (1.41%, mean 2.78) plus a learning curve 14 (2.19%, 3.36), union 20 (3.13%) — 'There must be some tips or suggestions in start' (PK, 2017) through 'I don't understand nothing' (US, Aug 2026); 'There is no help option in settings which makes at least one action I want to take impossible: I want to create a habit that includes a timer. I can't find instructions for this in the app, on YouTube, or through a Google search'; 'I find the lack of set up instructions and lack of FAQ maddening… I have had to contact support twice on things that could have explained up front'; 'it took me an hour or so to figure out how to make it work… I'd pay for this if it had some adjustments in usability'

- **Where:** Executive summary #10 — onboarding is the cheapest unaddressed problem, named for nine straight years: no guide / tutorial / FAQ / help 9 (1.41%, mean 2.78) + learning curve 14 (2.19%, 3.36) = 20 (3.13%, very strong); 'There must be some tips or suggestions in start' (2017) → 'I don't understand nothing' (2026); 'no help option in settings… I can't find instructions for this in the app, on YouTube, or through a Google search'; 'lack of FAQ maddening… contact support twice on things that could have explained up front'; 'took me an hour… I'd pay for this if it had some adjustments in usability'
- **This app does:** no help / FAQ / tour
- **User reaction:** complaint
- **Magnitude:** 20 (3.13%); 9 (2.78) + 14 (3.36)
- **Direction for us:** must-have · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1553177362`, `14407854273`, `6810959323`, `8251773389`, `13416844344`
- **Canonical:** C075 Skippable, replayable onboarding tour; C259 An in-app help screen — first-run tour, searchable FAQ, per-setting explanations — for any product whose setup is richer than its daily use

### R43-017 — Support that fixes things within hours is bimodal when the intake channel is broken: praised by name in 24 (3.76%, mean 4.67) — 'the support team contacted me and helped me fix the minor issue'; 'I recently requested a small new feature, got a response, and it was added a few days later' (Jan 2026); a 2★ upgraded to 5★ after the requested fix shipped — vs 7 (1.10%, mean 1.29, the lowest theme) who got no response and 4 who report the in-app feedback path itself broken ('Feedback email can not send'; 'They have a report bug feature, but that also doesn't work'; 'I wasn't able to email due to the configuration') — fixing the feedback path is a support-capacity fix disguised as a bug fix

- **Where:** Executive summary #11 — support is an asset that fails where most needed: praised by name 24 (3.76%, mean 4.67; a 2★ upgraded to 5★ after a fix; 'requested a small new feature… added a few days later') vs no response 7 (1.10%, mean 1.29, the lowest of any theme) and 4 reporting the in-app feedback channel itself broken ('Feedback email can not send'; 'report bug feature… doesn't work') — support is bimodal because the intake is unreliable
- **This app does:** fast fixes; broken in-app feedback
- **User reaction:** mixed
- **Magnitude:** praise 24 (4.67); no response 7 (1.29); channel broken 4
- **Direction for us:** must-have · **Report confidence:** very strong / meaningful · **Generalisable:** yes
- **Review IDs:** `1626042608`, `13581758283`, `1958553531`, `3705163026`, `3226700626`, `6537988680`, `7984884909`, `10019289476`, `11111402633`, `11605150337`, `11762923278`, `2331157968`, `4910574623`, `6294511871`, `7954475421`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R43-031 — State 'one-time' on the purchase button: 5 reviewers (0.78%, mean 4.20) could not tell whether $2.99 was per month or once — 'is the $2.99 per month or a one time purchase?'; 'without paying money each month'

- **Where:** §2.2 The plan label must say 'one-time': 5 reviews could not tell whether $2.99 was monthly or a one-time purchase
- **This app does:** price label ambiguous
- **User reaction:** mixed
- **Magnitude:** 5 (0.78%), 4.20
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `5835145722`, `4476308231`, `3961509114`, `6238490934`, `9532357652`
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R43-045 — UX confusion 9 (1.41%, 3.33); cluttered UI 9 (1.41%, 3.00; 6 of 9 non-US)

- **Where:** §3.1 master table #42 ux_confusion / #43 ui_cluttered
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 9 + 9
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C075 Skippable, replayable onboarding tour; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R43-048 — Price confusion 5 (0.78%, mean 4.20) — could not tell one-time from monthly

- **Where:** §3.1 master table #52 price_confusion
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** 5 (0.78%), 4.20
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R43-051 — In-app support channel broken 4 (0.63%, 3.25); canned response 1 (1.00)

- **Where:** §3.1 master table #59 support_channel_broken / #96 support_canned_response
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 + 1
- **Direction for us:** must-have · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C189 Never post canned public replies — answer the specific complaint or don't reply

### R43-071 — The most common action needs a large, unambiguous tap target: for four years the Done and Info buttons sat adjacent and swipes were mis-read — 'the item disappears before I can choose my swiped option… the Done button… is so close to the Info button that I end up opening Info… as many times as I mark one Done' (2017); 'Done and i button too close together' (2018); 'Tap targets for your most common actions — marking a habit done or viewing statistics — are tiny' (2★); 'I was constantly marking things as done when I really wanted to mark them as skipped… I'm sick of trying to swipe exactly right so I deleted it' (2★, churned)

- **Where:** §3.4.4 swipe_done_ux 5 (0.78%) — a single interaction failing for four years: Done and Info buttons adjacent, swipe sensitivity ('the item disappears before I can choose my swiped option'; 'Done and i button too close together'; 'Tap targets for your most common actions… are tiny'; 'I was constantly marking things as done when I really wanted to mark them as skipped… so I deleted it' — churned)
- **This app does:** adjacent Done / Info; swipe gestures
- **User reaction:** churn
- **Magnitude:** 5 (0.78%), 3.20; 1 churn
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1522226211`, `2331157968`, `2356764825`, `1534631145`, `6152463760`
- **Canonical:** C223 Undo / un-complete is a visible button — never a gesture-only path; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which

### R43-092 — Honour statutory withdrawal windows: 'On cancelling within 14 days I was also not refunded the purchase price, which is why I give only one star here for lack of customer-friendliness' (DE, 1★) — the only refund-denied record

- **Where:** §5.5 a refund refused inside the EU 14-day withdrawal period (DE, 1★)
- **This app does:** EU 14-day refund refused
- **User reaction:** complaint
- **Magnitude:** n=1 (1★)
- **Direction for us:** must-have · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `6537988680`
- **Canonical:** C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

### R43-117 — Repair the in-app feedback / bug-report channel — 'Feedback email can not send'; 'report bug feature… doesn't work'; 'I wasn't able to email due to the configuration' — it is the intake for the seven no-response reviews (mean 1.29)

- **Where:** §8.1 #3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** support_channel_broken 4
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `2331157968`, `4910574623`, `6294511871`, `7954475421`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R43-121 — Say 'one-time purchase' on the purchase sheet in words — three of five confused reviewers are 5★ users trying to buy, and one wrote a 2★ believing it was monthly; the sheet fails to state the product's most-praised attribute

- **Where:** §8.1 #7
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** price_confusion 5 (4.20)
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `3961509114`, `4476308231`, `6238490934`, `9532357652`, `5835145722`
- **Canonical:** C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R43-122 — Ship an in-app help screen — a first-run tour, a searchable FAQ, per-setting explanations — requested Feb 2017 → Aug 2026; also recovers the ~3 scheduling reviews asking for capabilities the app has; not a threat to the praised simplicity (daily use vs setup)

- **Where:** §8.2 #8
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** onboarding + learning curve 20 (3.13%)
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `1553177362`, `14407854273`, `6810959323`, `8251773389`, `5432803445`, `6246525358`, `9662306542`
- **Canonical:** C259 An in-app help screen — first-run tour, searchable FAQ, per-setting explanations — for any product whose setup is richer than its daily use

## Must never break

### R43-012 — Local-only storage with no enforced cloud backup loses the longest-tenured users at the moment of the biggest redesign: data loss 12 reviews (1.88%, mean 2.08), accelerating — 0 in 2016–18, 5 in 2019–21, 7 in 2022–26 (4.55% of the era); the 2026 cluster: 'I have done 3 updates for this app… and now I can no longer access the app. It no longer opens. I have lost all of my reminders' (US, 1★, Apr 2026); 'I used HabitHub for four years and after an update my locally stored data was gone' (DE, 7 Jul 2026); 'This morning I opened the app, the UI has changed and all my data of four years is gone' (DE, 11 Jul 2026) — both Germans got an immediate support reply and had already migrated to a competitor; 'If I could change anything, I would sync my data to the iCloud to be sure'

- **Where:** Executive summary #6 — data loss is the most severe and accelerating defect: 12 (1.88%, mean 2.08), 0 in 2016–18, 5 in 2019–21, 7 in 2022–26 (4.55% of the era); 2026 cluster — updates then app no longer opens and all reminders lost; 'I used HabitHub for four years and after an update my locally stored data was gone'; 'UI has changed and all my data of four years is gone' — both German reviewers got immediate support replies and had already migrated; 'I would sync my data to the iCloud to be sure'
- **This app does:** local storage, iCloud optional
- **User reaction:** churn
- **Magnitude:** 12 (1.88%), 2.08; 7 in 2022–26 (4.55%)
- **Direction for us:** must-never-break · **Report confidence:** highest severity · **Generalisable:** yes
- **Review IDs:** `13950149136`, `14273363206`, `14291899176`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R43-013 — Regression-test notifications on every iOS major — a five-week public regression on the signature feature with 'email support' as the remedy is the most avoidable reputational event: 15 reviews (2.35%, mean 2.60) — an iOS 15 cluster 13 Oct – 10 Nov 2021 ('Notifications continue even after marking task as complete or muting the task since iOS update'; 'App is now giving double notifications'; 'Others have also reported this, and I don't think the solution is to have us individually email tech support. It's clearly a bug'; 'It's been over a month and a half since the new update came out and there hasn't been a bug fix' (payer); support's reinstall advice worked) — and ghost habits: 'It doesn't show up in the app, but keep firing at midnight… Aside from nuking this app, I don't see any way to interact with that habit'; 'old reminders keep popping up… I deleted and readded the app, I've changed phones and nothing seems to allow me to cancel'

- **Where:** Executive summary #7 — notification failures are a recurring, version-linked defect attacking the differentiator: 15 (2.35%, mean 2.60) firing twice, after completion, or not at all; an iOS 15 cluster Oct–Nov 2021 ('Notifications continue even after marking task as complete'; 'double notifications'; 'I don't think the solution is to have us individually email tech support. It's clearly a bug'; 'over a month and a half… no bug fix' from a payer; reinstall fixed it); ghost habits — a deleted habit that still fires at midnight, survives reinstall and a new phone
- **This app does:** notification regressions on OS updates; orphaned reminders
- **User reaction:** 1★-burst
- **Magnitude:** 15 (2.35%), 2.60; iOS 15 cluster 5 in 4 weeks
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `7910377516`, `7942724644`, `7954475421`, `7984884909`, `8009348865`, `11762923278`, `13362043458`
- **Canonical:** C039 Reminders fire reliably, once; C258 A 'nag until done' repeating reminder — the one reminder shape reviewers say no other app offers

### R43-027 — Do not remove a pause feature in a redesign: 'pause a habit' is reported removed by the 2026 update (1)

- **Where:** §2.1 Pause a habit — reported removed by the 2026 update
- **This app does:** pause removed 2026
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** must-never-break · **Report confidence:** weak · **Generalisable:** yes
- **Review IDs:** `13742967030`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently; C155 Never remove a feature people bought the app for — add alongside, do not replace

### R43-042 — Generic 'buggy' 14 (2.19%, mean 2.00), 2020–2025

- **Where:** §3.1 master table #33 generic_buggy
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 14 (2.19%), 2.00
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C175 Updates must not break function or wipe progress

### R43-044 — Save / edit bug 10 (1.57%, mean 2.30), 2019–2024

- **Where:** §3.1 master table #40 save_edit_bug
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 10 (1.57%), 2.30
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C175 Updates must not break function or wipe progress

### R43-050 — Purchase not delivered 4 (0.63%, 2.75); restore purchase issue 1 (1.00); repurchase required 1 (1.00, 2017)

- **Where:** §3.1 master table #57 purchase_not_delivered / #95 restore_purchase_issue / #83 repurchase_required
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 4 + 1 + 1
- **Direction for us:** must-never-break · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature; C186 Never revoke what earlier buyers paid for when the model changes

### R43-066 — Reliability sub-themes (74, 11.60%, mean 2.35): crash / won't open 20 (3.13%, 2.15; 18 of 20 US); regression after update 16 (2.51%, 2.44); notification bug 15 (2.35%, 2.60); generic buggy 14 (2.19%, 2.00); data loss 12 (1.88%, 2.08); save / edit bug 10 (1.57%, 2.30); stats bug 5; iCloud sync error 5 (1.40); widget issue 4; timer bug 3; ghost habit 2; scheduling bug 1

- **Where:** §3.4.3 Reliability (verbatim sub-theme table) — crash_wont_open 20 (3.13%, 2.15, 18/20 US); regression_after_update 16; notification_bug 15; generic_buggy 14; data_loss 12; save_edit_bug 10; stats_bug 5; sync_icloud_error 5 (1.40); widget_issue 4; timer_bug 3; ghost_habit 2; scheduling_bug 1
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Sub-theme | n | % of 638 | Mean ★ | Signal | Period ; crash_wont_open | 20 | 3.13% | 2.15 | very strong | 2017–2026 ; regression_after_update | 16 | 2.51% | 2.44 | meaningful | 2017–2026 ; notification_bug | 15 | 2.35% | 2.60 | meaningful | 2019–2026 ; generic_buggy | 14 | 2.19% | 2.00 | meaningful | 2020–2025 ; data_loss | 12 | 1.88% | 2.08 | meaningful | 2020–2026 ; save_edit_bug | 10 | 1.57% | 2.30 | meaningful | 2019–2024 ; stats_bug | 5 | 0.78% | 2.60 | emerging | 2019–2026 ; sync_icloud_error | 5 | 0.78% | 1.40 | emerging | 2018–2022 ; widget_issue | 4 | 0.63% | 3.25 | emerging | 2019–2024 ; timer_bug | 3 | 0.47% | 3.67 | weak | 2021–2022 ; ghost_habit | 2 | 0.31% | 2.00 | weak | 2024–2025 ; scheduling_bug | 1 | 0.16% | 4.00 | weak | 2025
- **Direction for us:** must-never-break · **Report confidence:** high-priority (union) · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C175 Updates must not break function or wipe progress

### R43-067 — The app must open — a persistent won't-open state ran Dec 2021 → Feb 2023 (six reviews in fourteen months) and recurred Dec 2025 → Apr 2026: crash / won't open 20 (3.13%, mean 2.15) in three patterns — crash on check-off, crash after purchase ('after purchasing, the app crashed every single time I opened it', 2★), and won't open at all; one reviewer names a memory precondition: 'Crashes if you have less than 500MB free… Need more than 500MB free at any one time'

- **Where:** §3.4.3 crash_wont_open — three sub-patterns: crash on check-off, crash after purchase ('after purchasing, the app crashed every single time I opened it'), and a persistent won't-open state (Dec 2021 → Feb 2023, six in fourteen months; recurring Dec 2025 → Apr 2026); 'Crashes if you have less than 500MB free'
- **This app does:** launch failures, two clusters
- **User reaction:** 1★-burst
- **Magnitude:** 20 (3.13%), 2.15; 18/20 US
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1626042608`, `1666138250`, `2945436722`, `8084225988`, `8243274829`, `8359132653`, `9023682666`, `9510714483`, `9625474815`, `13539509871`, `13950149136`, `2168935274`
- **Canonical:** C031 Crashes / launch failures; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R43-068 — The advertised backup must restore, and its errors must be dismissible: iCloud sync error 5 (0.78%, mean 1.40, the lowest-rated reliability sub-theme) — 'Constant iCloud Error… I'm signed into iCloud. First impressions are often the last. Sloppy code' (1★); 'iCloud Sign in Error - I can't turn off this message. It's so annoying' (1★); 'I deleted the app and reinstalled and lost everything even though it was backed up to iCloud' (payer, 1★) — iCloud is simultaneously the advertised backup mechanism, an undismissable error banner, and a backup that did not restore

- **Where:** §3.4.3 sync_icloud_error 5 (0.78%, mean 1.40, lowest reliability sub-theme) — 'Constant iCloud Error… Sloppy code'; 'iCloud Sign in Error - I can't turn off this message'; 'I deleted the app and reinstalled and lost everything even though it was backed up to iCloud' (payer) — iCloud is the advertised backup, an undismissable error banner, and a backup that did not restore
- **This app does:** iCloud backup unreliable
- **User reaction:** 1★-burst
- **Magnitude:** 5 (0.78%), 1.40
- **Direction for us:** must-never-break · **Report confidence:** emerging; high severity · **Generalisable:** yes
- **Review IDs:** `5809629662`, `6371120408`, `9023682666`
- **Canonical:** C030 Sync must work — and prove it; C153 Automatic cloud backup on by default — never manual opt-in

### R43-081 — Ten payers at 1★ (13.2% of the band) — every one a delivery failure: had to re-buy after a system reinstall (CN); 'How do I restore purchase' failed; a save bug met by a canned reply and a refund demand; 'I upgraded app and nothing happens, just took my money' (PL); a refund refused inside the EU 14-day window (DE); 'Had it for two minutes after I paid for it and it's glitching'; won't open with data gone despite iCloud; a lifetime payer with a bug and no support reply (VN); everything wiped; a long-time payer hit by the 2025 popup regression

- **Where:** §4.5 10 of 76 one-star reviews are confirmed payers (13.2%) — the most expensive cell: had to re-buy after a system reinstall (CN); restore-purchase failure; save bug + canned reply + refund demand; purchase produced nothing (PL); refund refused inside 14 days (DE); 'Had it for two minutes after I paid for it and it's glitching'; won't open, data gone despite iCloud; lifetime payer bug + no support reply (VN); everything wiped; long-time payer 2025 popup regression
- **This app does:** post-purchase delivery failures
- **User reaction:** churn
- **Magnitude:** 10/76 1★ (13.2%)
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `1817063259`, `6174123870`, `6302864374`, `6371120408`, `6537988680`, `7226835619`, `9023682666`, `10019289476`, `10145156296`, `13278821225`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature; C186 Never revoke what earlier buyers paid for when the model changes

### R43-089 — Post-purchase failures are entirely about delivery, not value: any reliability defect after paying 11 of 48 (22.9%; 1.72% global); purchase did not unlock anything 4 (8.3%); generic bugginess 4; churned after paying 3; post-update regression 3; crash 2; data loss 2; iCloud failure 2; refund requested 2; had to re-purchase after reinstall 1; restore purchases failed 1

- **Where:** §5.4 Post-purchase failures (verbatim table) — any defect 11 (22.9%); purchase did not unlock 4 (8.3%); generic bugginess 4; churned after paying 3; post-update regression 3; crash 2; data loss 2; iCloud 2; refund 2; re-purchase after reinstall 1; restore failed 1 — entirely delivery, not value
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** Failure mode | Payers affected | Segment rate (n=48) | Global | IDs ; Any reliability defect after paying | 11 | 22.9% | 1.72% | 2945436722 5259644670 6302864374 6371120408 7226835619 7652035829 7984884909 9023682666 10019289476 10145156296 13278821225 ; Purchase did not unlock anything | 4 | 8.3% | 0.63% | 1544580960 3395577909 5849652810 6371120408 ; Generic bugginess | 4 | 8.3% | 0.63% | 6302864374 7226835619 7652035829 10019289476 ; Churned after paying | 3 | 6.3% | 0.47% | 7226835619 10019289476 10145156296 ; Post-update regression | 3 | 6.3% | 0.47% | 2945436722 7984884909 13278821225 ; Crash / won't open | 2 | 4.2% | 0.31% | 2945436722 9023682666 ; Data loss | 2 | 4.2% | 0.31% | 9023682666 10145156296 ; iCloud sync failure | 2 | 4.2% | 0.31% | 6371120408 9023682666 ; Refund requested | 2 | 4.2% | 0.31% | 6302864374 6537988680 ; Had to re-purchase after reinstall | 1 | 2.1% | 0.16% | 1817063259 ; Restore-purchases failed | 1 | 2.1% | 0.16% | 6174123870
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `2945436722`, `5259644670`, `6302864374`, `6371120408`, `7226835619`, `7652035829`, `7984884909`, `9023682666`, `10019289476`, `10145156296`, `13278821225`, `1817063259`, `6174123870`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R43-090 — The unlock must visibly execute at the moment of purchase — for a one-time product this is where the business model runs: 4 buyers got nothing ('I paid to upgrade to get the edit function, but no changes happened… Something broken in the backend?? Who knows'; 'I bought the premium but I haven't gotten any extra features… such as graphs'; 'Purchase premium but still getting free trial capabilities, Give me my Premium that I Paid for'; 'I upgraded app and nothing happens, just took my money'), one could not buy ('it won't let me upgrade to the premium version'), one could not restore ('How do I restore purchase', 1★)

- **Where:** §5.4 purchase_not_delivered 4 (0.63%, mean 2.75) — the most damaging pattern for a one-time product, the exact moment the model executes: 'no changes happened… Something broken in the backend??'; 'haven't gotten any extra features… such as graphs'; 'Purchase premium but still getting free trial capabilities, Give me my Premium that I Paid for'; 'just took my money'; plus 'it won't let me upgrade' and 'How do I restore purchase'
- **This app does:** entitlement not applied
- **User reaction:** 1★-burst
- **Magnitude:** 4 (0.63%), 2.75 + blocked 1 + restore 1
- **Direction for us:** must-never-break · **Report confidence:** emerging; model-critical · **Generalisable:** yes
- **Review IDs:** `1544580960`, `3395577909`, `5849652810`, `6371120408`, `6136388593`, `6174123870`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R43-113 — A redesign must not change the meaning of existing schedules: 'since the new redesign all habits scheduled for every 2/3 weeks now show up every week' (GB, 4★, Nov 2025) — a precise, reproducible regression in a core code path, filed by a user who still gave 4★

- **Where:** §7.9 'since the new redesign all habits scheduled for every 2/3 weeks now show up every week' (GB, 4★, Nov 2025) — a precise scheduling regression in a core code path
- **This app does:** scheduling regression
- **User reaction:** complaint
- **Magnitude:** n=1 (4★)
- **Direction for us:** must-never-break · **Report confidence:** weak count; precise · **Generalisable:** yes
- **Review IDs:** `13418583733`
- **Canonical:** C043 Flexible / custom frequency; C104 Never ship a paywall or feature-removal change silently

### R43-115 — Make iCloud backup the default and add an explicit, visible restore path; show last-backup time in settings — the highest-severity finding: data loss grew 0.31% → 3.45%, three lost multi-year histories, two churned in July 2026; a payer's iCloud backup did not restore; the fix is named verbatim ('I would sync my data to the iCloud to be sure')

- **Where:** §8.1 #1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** data_loss 12 (2.08); sync_icloud_error 5 (1.40)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `14273363206`, `9023682666`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C153 Automatic cloud backup on by default — never manual opt-in

### R43-118 — Fix the every-2/3-week scheduling regression shipped with the redesign

- **Where:** §8.1 #4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** scheduling_bug 1 (4★)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13418583733`
- **Canonical:** C104 Never ship a paywall or feature-removal change silently

### R43-119 — Restore the 'pause a habit' control removed in the 2026 update — a removed capability is a regression, not a request

- **Where:** §8.1 #5
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** pause_missing 1 (2★)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `13742967030`
- **Canonical:** C155 Never remove a feature people bought the app for — add alongside, do not replace

### R43-124 — Add a regression test for notification scheduling on every iOS major and publish a known-issues note in the listing when one breaks — the iOS 15 cluster ran five weeks with 'email support' as the remedy; notifications are the differentiator

- **Where:** §8.2 #10
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** notification_bug 15 (2.60)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `7910377516`, `7942724644`, `7954475421`, `7984884909`, `8009348865`
- **Canonical:** C039 Reminders fire reliably, once

### R43-125 — Fix ghost habits — deleted habits that keep firing and survive uninstall and a new phone, meaning the schedule persists outside the app's own state

- **Where:** §8.2 #11
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** ghost_habit 2 (2.00)
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `11762923278`, `13362043458`
- **Canonical:** C039 Reminders fire reliably, once

## Features

### R43-011 — A 'nag me until it's done' repeating reminder is a moat nobody else is credited with: praised by name in 22 reviews (3.45%, mean 4.86) and reminders generally in 54 (8.46%, 4.76) — 'Best feature by far is the nag me until Im done option, which is something no other app has offered thus far'; 'HabitHub relies on good old-fashioned nagging. It's simple and effective'; 'The first time in my life I gave money to something to NAG me 😐'; 'you can set it to nag you as often as you want and don't have to stop what you are doing to turn off an alarm' — and it is the mechanism most exposed to notification bugs

- **Where:** Executive summary #5 — the signature feature is the 'nag until done' repeating reminder: 22 (3.45%, very strong, mean 4.86) by name, reminders generally 54 (8.46%, 4.76); 'something no other app has offered thus far'; 'good old-fashioned nagging'; 'The first time in my life I gave money to something to NAG me'; the moat, and the mechanism most exposed to notification bugs
- **This app does:** repeat-until-done reminders, free
- **User reaction:** purchase-driver
- **Magnitude:** nag 22 (3.45%), 4.86; reminders 54 (8.46%), 4.76
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `6222322942`, `2510076061`, `5232097891`, `11268226195`, `1486308038`, `8921933482`
- **Canonical:** C008 Daily check-in and one basic reminder per habit are free; C258 A 'nag until done' repeating reminder — the one reminder shape reviewers say no other app offers

### R43-015 — Scheduling shapes users ask for: intervals longer than one month ('There are no options for tasks that occur beyond every 1 month… Wish I'd known that before I paid for it', payer 2★), Nth weekday of month ('1st Tuesday of each month'), 'X times per week' without fixing days, every other week, a due date that rolls from last completion — 29 reviews (4.55%, mean 3.38); roughly a tenth ask for shapes the app already supports (custom days 'Monday and Wednesday's', timed tasks, untimed tasks) and land as 1★ / 2★ — a discoverability problem

- **Where:** Executive summary #9 — scheduling shapes: 29 (4.55%, very strong, mean 3.38) name a missing capability — intervals beyond one month ('Wish I'd known that before I paid for it'), Nth weekday of month ('1st Tuesday of each month'), X times per week without fixed days, every other week, due date rolling from last completion; but ~a tenth ask for something the app has (custom days, timers, untimed tasks) landing as 1★/2★ — a discoverability problem
- **This app does:** custom days, timers exist; >monthly, Nth-weekday, N×/week absent
- **User reaction:** complaint
- **Magnitude:** 29 (4.55%), 3.38; ~3 discoverability
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `7289065763`, `6569265970`, `2431436613`, `2885013412`, `7539356424`, `1522226211`, `5812621934`, `10280711337`, `5432803445`, `6246525358`, `9662306542`
- **Canonical:** C043 Flexible / custom frequency; C142 Surface existing features where users look

### R43-024 — Multiple completions and reminders per day — water, meals, reps with 0/2 and 0/4 counters, hourly nagging — exist and are praised; one reviewer names a 20-reminders-per-day cap as a limit

- **Where:** §2.1 Multiple reminders / completions per day (water / meals / reps; hourly nagging; 0/2, 0/4 counters) — free; reminder count cap of 20/day named as a limit
- **This app does:** multi-count free; 20/day cap
- **User reaction:** praise
- **Magnitude:** 5 + 1
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `2093791169`, `2689404914`, `3359093927`, `7316654754`, `14295935121`, `6065249389`
- **Canonical:** C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N; C226 App-icon badge count of outstanding habits, with an active-hours window

### R43-025 — A colour-coded (red / yellow / green) time-window timeline as the main screen and multi-step timed routines (morning routines, workouts, kids, ADHD) are core differentiators; the timer's background-music fade and voice prompts shipped in response to a review

- **Where:** §2.1 Time-window scheduling with red / yellow / green state — the colour-coded timeline is the main screen; multi-step timers / timed routines for morning routines, workouts, kids, ADHD; timer with background music fade + voice prompts shipped in response to a review
- **This app does:** time windows + step timers, free
- **User reaction:** praise
- **Magnitude:** inventory
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `1870679717`, `8251773389`, `11840965309`, `13284708645`, `3306469965`, `3849179643`, `5184672437`, `6433681812`, `9195704288`, `11512950686`, `3705163026`, `14295935121`
- **Canonical:** C066 Focus timer; C069 Check-off sound and haptic; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R43-026 — Inventory notes: statistics with streaks, percentages, grades and all-time views are very heavily praised; calendar per habit; journal notes; categories; home and lock-screen widgets; iCloud sync (also the source of 5 sync-error reports); Siri / Shortcuts; dark theme; one-time tasks alongside habits (one report they don't save); per-habit notification sounds repeatedly 'too few'; drag-to-reorder within time windows only from Nov 2025 after 7 asks; 'pause a habit' reported removed by the 2026 update

- **Where:** §2.1 Statistics: streaks, %, grades, all-time — very heavily praised; calendar view per habit; journal / per-day notes; categories / groups; widgets; iCloud sync (also 5 sync-error reports); Siri / Shortcuts; dark theme; one-time tasks (one report of them not saving); per-habit notification sounds 'too few'; drag-to-reorder only from Nov 2025 (7 earlier asks); pause a habit reported removed by the 2026 update
- **This app does:** broad, mostly free
- **User reaction:** mixed
- **Magnitude:** inventory
- **Direction for us:** build-free · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `11557060713`, `1880954809`, `6235525265`, `9884046420`, `13415356335`, `13832109970`, `13742967030`, `3627076218`, `7225948719`
- **Canonical:** C009 Basic widgets, icons and colours are free; C011 Weekly / monthly / yearly reports; C030 Sync must work — and prove it; C045 Grouping / folders / categories / tags; C046 Shortcuts / Siri / URL scheme / API; C050 One-off to-dos alongside habits; C073 Manual reordering, renaming and editing of habits/tasks — free; C080 Colour themes / dark mode; C107 Widget variants and customisation as the paid layer; C155 Never remove a feature people bought the app for — add alongside, do not replace; C172 Per-day / per-habit notes and journal text

### R43-029 — Absent per reviewers: Nth-weekday and longer-than-monthly intervals; 'X times per week' without fixed days; CSV / PDF export; a macOS app; Health integration; shared / household sync; negative / 'avoid' habit tracking (3); location-based reminders; passcode / Touch ID lock; backfilling a day after it has passed (4); habit-data import; bulk edit across a group; per-habit colours / icons (4)

- **Where:** §2.1 Capabilities asked for with no evidence in the corpus — Nth-weekday and >monthly; X times per week; CSV / PDF export; macOS app; Health integration; shared / household sync; negative / 'avoid' habits; location-based reminders; passcode / Touch ID lock; backfilling a passed day (4); habit-data import; bulk edit across a group; per-habit colours / icons (4)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 1–4 each
- **Direction for us:** research · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `6569265970`, `7289065763`, `2431436613`, `6506840284`, `7799773693`, `3869364986`, `10116531918`, `10794697350`, `8626793011`, `12132274531`, `5451004215`, `5741386279`, `7047105323`, `8951281264`, `3817510097`, `1534631145`, `3580766264`, `3607266330`, `6148198959`, `11268226195`, `5468311237`, `9532357652`
- **Canonical:** C010 Backfill missed days / edit start date; C017 Passcode lock; C019 Quit-habit / bad-habit mode; C020 Data export / backup / CSV; C021 Apple Health integration; C037 Family plan; C043 Flexible / custom frequency; C044 Mac / desktop / web app; C080 Colour themes / dark mode

### R43-035 — Customisation praised 46 (7.21%, mean 4.83)

- **Where:** §3.1 master table #11 praise_customization
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 46 (7.21%), 4.83
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C073 Manual reordering, renaming and editing of habits/tasks — free; C080 Colour themes / dark mode

### R43-038 — Other feature requests 17 (2.66%, mean 3.71)

- **Where:** §3.1 master table #24 feature_request_other
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 17 (2.66%), 3.71
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R43-039 — Scheduling flexibility praised 17 (2.66%, mean 4.65) — alongside 29 asking for more shapes

- **Where:** §3.1 master table #25 praise_scheduling_flexibility
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 17 (2.66%), 4.65
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C043 Flexible / custom frequency

### R43-040 — Better / more notification sounds and snooze requested 16 (2.51%, mean 3.94)

- **Where:** §3.1 master table #28 notification_improvement_request
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 16 (2.51%), 3.94
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C074 Customisable, louder reminder sounds; C107 Widget variants and customisation as the paid layer

### R43-041 — Multiple completions per day praised 14 (2.19%, mean 4.71)

- **Where:** §3.1 master table #31 praise_multi_count
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 14 (2.19%), 4.71
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C048 Flexible units / partial progress; C143 Intra-day completion: tap N times to fill N/N

### R43-043 — 'Too limited' 11 (1.72%, mean 3.00)

- **Where:** §3.1 master table #38 too_limited
- **This app does:** see §3.1
- **User reaction:** complaint
- **Magnitude:** 11 (1.72%), 3.00
- **Direction for us:** research · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R43-046 — Journal praised 9 (1.41%, 4.44); widget praised 9 (1.41%, 4.44)

- **Where:** §3.1 master table #44 praise_journal / #45 praise_widget
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 9 + 9
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C009 Basic widgets, icons and colours are free; C172 Per-day / per-habit notes and journal text

### R43-049 — Siri praised 5 (0.78%, mean 4.40), all US

- **Where:** §3.1 master table #54 praise_siri
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 5 (0.78%), 4.40
- **Direction for us:** build-free · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C046 Shortcuts / Siri / URL scheme / API

### R43-058 — Grades and percentages motivate: statistics, streaks and the green / red calendar praised by 55 (8.62%, mean 4.82) — 'Thank you for %'s and grades. This is how my brain works. Since I've put a daily exercise routine as one of my tasks, I'm actually completing it so I can stay at a 90% grade'; 'The progress chart… keeps me honest'; 'the calendar that shows red and green days so I can easily spot how many days I achieved my goal' — against 5 (0.78%, mean 2.60) reporting statistics wrong

- **Where:** §3.3.3 Statistics and streaks — 55 (8.62%, mean 4.82): percentage rings, grades, streaks, green/red calendar; 'Thank you for %'s and grades. This is how my brain works… I'm actually completing it so I can stay at a 90% grade'; 'keeps me honest'; vs 5 (0.78%, 2.60) reporting statistics wrong
- **This app does:** stats free
- **User reaction:** praise
- **Magnitude:** 55 (8.62%), 4.82; stats_bug 5 (2.60)
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `7010047564`, `13832109970`, `7598268036`
- **Canonical:** C011 Weekly / monthly / yearly reports

### R43-073 — Feature requests come from people who like the product, and the developer works the queue: the feature-gap union is 124 (19.44%, mean 3.64) with only 21 (16.9%) at 1–2★ — richer scheduling 29 (3.38); Apple Watch 12 (4.00, since shipped); more UI languages 10 (3.20, Arabic unanswered); manual reordering 7 (3.71, shipped Nov 2025); notification sounds & snooze 16 (3.94); backfill a past day 4; toggleable groups / profiles 4 (4.25); per-habit colours / icons 4 (4.50); calendar view 4; negative / avoid habits 3; macOS 3 (4.67); export 2; household sync 2; Health, location reminders, passcode, Shortcuts, bulk edit, import, undo Done, per-occurrence progress, social 1 each — three of the top four gaps have since been closed (Watch, reordering, Spanish / Portuguese)

- **Where:** §3.5 Unmet needs (verbatim table) — scheduling 29; Apple Watch 12 (shipped); languages 10; reorder 7 (shipped Nov 2025); notification sounds & snooze 16; backfill 4; toggleable groups / profiles 4; per-habit colours / icons 4; calendar view 4; negative habits 3; macOS 3; export 2; household sync 2; Health 1; location reminders 1; passcode 1; Shortcuts 1; bulk edit 1; import 1; undo Done 1; per-occurrence progress 1; social 1; feature-gap union 124 (19.44%, mean 3.64), only 21 (16.9%) at 1–2★; three of the top four gaps since closed
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Need | n | % of 638 | Mean ★ | Signal | Representative IDs ; Richer scheduling (Nth weekday, >monthly, X/week, every-other-week, dynamic due dates) | 29 | 4.55% | 3.38 | very strong | 2885013412 6569265970 7289065763 7539356424 10280711337 11285252674 ; Apple Watch (now apparently shipped) | 12 | 1.88% | 4.00 | meaningful | 4161687730 4986120210 6905478703 8251179102 8954443510 10783651409 ; Additional UI languages (Arabic unanswered) | 10 | 1.57% | 3.20 | meaningful | 12565071834 12752447582 12767914274 8182517804 11496905396 ; Manual reordering of tasks (shipped Nov 2025) | 7 | 1.10% | 3.71 | meaningful | 3581923071 6166225694 7078374078 8984421673 11840965309 14289945067 ; Better/more notification sounds & snooze | 16 | 2.51% | 3.94 | meaningful | 1880954809 6235525265 8591869846 9884046420 13416844344 ; Backfill a past day | 4 | 0.63% | 3.75 | emerging | 1534631145 3580766264 3607266330 6148198959 ; Groups/profiles that can be toggled on and off | 4 | 0.63% | 4.25 | emerging | 2895489622 5532345123 5757998514 9420414826 ; Per-habit colours and icons | 4 | 0.63% | 4.50 | emerging | 5468311237 7047105323 7316654754 9532357652 ; Calendar / date view | 4 | 0.63% | 3.50 | emerging | 6052857761 7017819148 11126369075 11496905396 ; Negative / "avoid" habits | 3 | 0.47% | 3.67 | weak | 5451004215 5741386279 7047105323 ; macOS / desktop app | 3 | 0.47% | 4.67 | weak | 3869364986 6506840284 10116531918 ; Data export (CSV/PDF) | 2 | 0.31% | 4.50 | weak | 6506840284 7799773693 ; Shared / household sync | 2 | 0.31% | 3.50 | weak | 8626793011 12132274531 ; Health app integration | 1 | 0.16% | 5.00 | weak | 10794697350 ; Location-based reminders | 1 | 0.16% | 4.00 | weak | 8951281264 ; Passcode / Touch ID lock | 1 | 0.16% | 4.00 | weak | 3817510097 ; Shortcuts integration | 1 | 0.16% | 3.00 | weak | 3429879417 ; Bulk edit across a group | 1 | 0.16% | 4.00 | weak | 11268226195 ; Data import from another tracker | 1 | 0.16% | 4.00 | weak | 3580766264 ; Undo an accidental "Done" | 1 | 0.16% | 2.00 | weak | 5498377628 ; Per-occurrence progress within a day | 1 | 0.16% | 5.00 | weak | 4198312666 ; Social / shared challenges | 1 | 0.16% | 5.00 | weak | 6794532635
- **Direction for us:** do · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `2885013412`, `6569265970`, `7289065763`, `7539356424`, `10280711337`, `11285252674`, `4986120210`, `6905478703`, `8251179102`, `8954443510`, `3581923071`, `6166225694`, `7078374078`, `8984421673`, `14289945067`, `8591869846`, `2895489622`, `5532345123`, `5757998514`, `9420414826`, `6052857761`, `7017819148`, `11126369075`, `3429879417`, `5498377628`, `4198312666`, `6794532635`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C027 Localise early — it unlocks revenue; C043 Flexible / custom frequency; C059 Be visibly responsive; fixes bring reviewers back; C073 Manual reordering, renaming and editing of habits/tasks — free; C107 Widget variants and customisation as the paid layer

### R43-074 — Small asks: undo an accidental Done (1, 2★ — paired with the swipe mis-taps); groups / profiles that can be toggled on and off, e.g. weekday vs weekend sets (4, mean 4.25)

- **Where:** §3.5 Undo an accidental 'Done' — 1 (2.00); groups / profiles that can be toggled on and off — 4 (4.25)
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 1 + 4
- **Direction for us:** build-free · **Report confidence:** emerging / weak · **Generalisable:** yes
- **Review IDs:** `5498377628`, `2895489622`, `5532345123`, `5757998514`, `9420414826`
- **Canonical:** C223 Undo / un-complete is a visible button — never a gesture-only path; C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R43-123 — Extend scheduling: intervals beyond one month (quarterly, annual), Nth weekday of month, 'X times per week' without fixing days, every other week with a start date, a due date rolling from last completion — the longest-running unaddressed request (Jan 2017 → Jan 2025); a retention item (mean 3.38 — people who like the app)

- **Where:** §8.2 #9
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** scheduling_flexibility_missing 29 (3.38)
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `7289065763`, `6569265970`, `2431436613`, `1522226211`, `10280711337`
- **Canonical:** C043 Flexible / custom frequency

### R43-126 — Ship Arabic with RTL layout — three independent requests in fourteen months, all exactly 3★; the only unanswered language cluster

- **Where:** §8.2 #12
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** localization_missing 10; Arabic 3
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `12565071834`, `12752447582`, `12767914274`
- **Canonical:** C027 Localise early — it unlocks revenue

### R43-128 — Add more notification sounds, per-habit sound assignment and a 'remind me later' snooze — 'hearing the same sound for every habit… mentally makes me mush all my tasks together'; 'you can't use the notification or ringtone sounds from your iPhone' — 4★ reviewers naming the fifth star

- **Where:** §8.2 #14
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** notification_improvement_request 16 (3.94)
- **Direction for us:** build-free · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `1880954809`, `6235525265`, `8591869846`, `9884046420`, `13416844344`
- **Canonical:** C107 Widget variants and customisation as the paid layer

### R43-136 — Experiment: a macOS / Catalyst build — 3 requests (4.67) overlapping export; the listing already claims Mac (M1+), so this may be discoverability rather than a build question

- **Where:** §8.4 E4
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** mac_desktop_missing 3 (4.67); export 2
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `3869364986`, `6506840284`, `10116531918`
- **Canonical:** C044 Mac / desktop / web app

## Monetization

### R43-010 — A cheap one-time unlock is a defensible position users state in competitive terms: one-time praised 40 (6.27%, mean 4.60), price / value praised 57 (8.93%, 4.89), the monetisation-praise union 89 (13.95%, 4.70) — larger than the entire friction union (87) and two stars higher — 'I've tried 3 other apps that ranged from $25 to $60 per year. This one is simple, inexpensive and does everything you need'; 'Others have less features yet will charge double the one time payment for this as a monthly subscription!'; 'they charge you 2.99 just once'; 'Thank you for making it accessible to super low income people like myself, Without having to have a subscription'; 'No subscription 🥳🎉 · Very reasonable one-time purchase price · Great data privacy (no data collected) · No ads' — any move to subscription would attack the most-praised attribute

- **Where:** Executive summary #4 — the one-time price is a first-class differentiator stated in competitive terms: praise_one_time 40 (6.27%, mean 4.60), praise_price 57 (8.93%, 4.89); monetisation-praise union 89 (13.95%, 4.70) > friction union 87 and two stars higher; 'I've tried 3 other apps that ranged from $25 to $60 per year'; 'charge double the one time payment for this as a monthly subscription!'; 'accessible to super low income people… Without having to have a subscription'; 'No subscription 🥳🎉 · Very reasonable one-time purchase price · Great data privacy · No ads'
- **This app does:** $2.99 → $4.99 one-time
- **User reaction:** purchase-driver
- **Magnitude:** one-time 40 (4.60); price 57 (4.89); union 89 (13.95%, 4.70) vs friction 87
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `7618584736`, `5751872904`, `7938484525`, `8208737898`, `7316654754`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors

### R43-030 — Free / paid: a single non-consumable unlock with no subscription anywhere — yet 5 reviews (0.78%, mean 4.20) could not tell what they were buying ('is the $2.99 per month or a one time purchase?'); free — download, tracking, check-off, timeline, colour states, statistics, streaks, calendar (post-2022), multi-step timers; habit count capped at 3 until ~2021–2022 then apparently uncapped; reminders capped alongside habits in the early era ('you only get 2 free reminders'); unlimited habits / premium paid one-time $2.99 US (2017–22) → $4.99 (2026), CA$3.99–4, £2.99, €3.99; no ads ever; no account; no trial (4 ask)

- **Where:** §2.2 Free / paid classification (verbatim table) — single non-consumable unlock, no subscription in 638 reviews; 5 reviews (0.78%, mean 4.20) could not tell whether $2.99 was monthly or one-time; download, tracking, timeline, statistics free; habit count capped at 3 until ~2021–22 then apparently uncapped; reminders capped alongside habits early ('you only get 2 free reminders'); unlimited / premium paid one-time $2.99 → $4.99; no ads; no account; no trial (4 ask)
- **This app does:** one-time unlock
- **User reaction:** mixed
- **Magnitude:** Capability | Status | Basis ; App download | Free | Store listing + all reviews ; Habit tracking, check-off, timeline, colour states | Free | 1514923982 3277298667 7917102602 ; Statistics, streaks, calendar | Free (post-2022 evidence) | 10869613654 12410220634 8554147668 ; Habit count | Capped at 3 up to ~2021–2022, then apparently uncapped | 66 free_cap_3habits reviews through Jan 2023; 8554147668 10869613654 11799865019 12410220634 after ; Reminders | Capped alongside habits in the early era | 3549755193 (*"you only get 2 free reminders"*), 6460019028, 8051225391 ; Multi-step timers | Reported working in free tier | 7316654754 (*"Can try out full app for free with 3 habits"*) ; Unlimited habits / "premium" | Paid, one-time | 1846285750 3039432884 5072219640 7293009213 ; Price observed | $2.99 US (2017–2022) → $4.99 US (2026 listing); CA$3.99–4, £2.99, €3.99 | 4476308231 5238058702 1998324046 5072219640 + listing ; Ads | None, ever | 7256207765 6885418251 10453106838 ; Account / login | Not required | 7316654754 ; Trial | None exists | 4 reviews ask for one: 1986492426 4084647887 5876621564 7289065763
- **Direction for us:** build-paid · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `5835145722`, `4476308231`, `3961509114`, `6238490934`, `9532357652`, `1514923982`, `3277298667`, `7917102602`, `3549755193`, `6460019028`, `8051225391`, `1846285750`, `3039432884`, `5072219640`, `7293009213`, `5238058702`, `1986492426`, `4084647887`, `5876621564`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C007 Generous fixed habit cap (or unlimited) — never change it; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R43-052 — Purchase intent 4 (0.63%, mean 4.50)

- **Where:** §3.1 master table #61 purchase_intent
- **This app does:** see §3.1
- **User reaction:** purchase-driver
- **Magnitude:** 4 (0.63%), 4.50
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R43-084 — The dominant purchase trigger is the one-time model itself, framed against subscriptions: 'Haven't paid for an app in a loooonnnggg time. Glad I did here'; 'I researched other Habit aiding apps, and one wanted 13 dollars a year, while another wanted 7 dollars upfront. I only paid a small $4'; 'I purchased the premium version… because it's cheaper & it really does its purpose'; 'Hate subscription app, this one is great as it is non-subscriptional and feature rich'; 'I am so very grateful that it was just a one time fee. If it was going to be a subscription app I was not going to bother'

- **Where:** §5.2 What triggers a purchase — 1. the one-time model against subscriptions (dominant): 'Haven't paid for an app in a loooonnnggg time. Glad I did here'; 'one wanted 13 dollars a year, while another wanted 7 dollars upfront. I only paid a small $4'; 'Hate subscription app, this one is great as it is non-subscriptional and feature rich'; 'If it was going to be a subscription app I was not going to bother'
- **This app does:** $2.99–4.99 one-time
- **User reaction:** purchase-driver
- **Magnitude:** trigger #1 of 4
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6406104025`, `3039432884`, `7413771936`, `7078374078`, `8208737898`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R43-085 — A full-featured free tier limited only in quantity converts after evaluation: 'I started off using the 3 free habits to see if the app would help me stick to these new habits and it really has helped… I will pay the once off fee to get unlimited habits soon!' (a documented intent); 'The free version has all the features but limits the amount of habits you can track at once so try it out and if it works for you, you can upgrade as I did 😊'; 'I highly recommend using the free version a few days before buying this app'

- **Where:** §5.2 trigger 2 — successful evaluation on the free tier: 'I started off using the 3 free habits… it really has helped… I will pay the once off fee'; 'The free version has all the features but limits the amount of habits… try it out and if it works for you, you can upgrade as I did'; 'I highly recommend using the free version a few days before buying'
- **This app does:** 3 habits, all features
- **User reaction:** purchase-driver
- **Magnitude:** trigger #2
- **Direction for us:** build-free · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `4633186504`, `1869913594`, `5451004215`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C063 Free trial before purchase

### R43-086 — A capability not found elsewhere closes the sale: 'you can track habits that are multiple times a day (e.g. glasses of water) and set multiple timers'; 'I really like the 0/2, 0/4 etc feature that visually shows you how far behind you are… thank you for not charging an astronomical subscription for this - it made me buy it'; 'paid for the full version because i really like the happy sound when completing tasks and the percentage representation of the overall success rate'

- **Where:** §5.2 trigger 3 — a specific capability not found elsewhere: 'habits that are multiple times a day (e.g. glasses of water) and set multiple timers'; 'the 0/2, 0/4 etc feature that visually shows you how far behind you are… thank you for not charging an astronomical subscription for this - it made me buy it'; 'the happy sound when completing tasks and the percentage representation'
- **This app does:** multi-count, timers, sound, %
- **User reaction:** purchase-driver
- **Magnitude:** trigger #3
- **Direction for us:** build-free · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `7316654754`, `3359093927`, `6521749449`
- **Canonical:** C048 Flexible units / partial progress; C066 Focus timer; C069 Check-off sound and haptic

### R43-087 — People pay to support the policy, and name their blockers when they don't: 'I purchased the premium version because I want to support the excellent privacy and pricing policies!'; 'Remember: you wouldn't do your job for free. Don't expect programmers to work for free either'; 'I wanna donate the developer. This is free and awesome'; purchase intent 4 (0.63%, mean 4.50) — 'I would purchase app if it worked for habits that are different than once a day'; 'I'd pay for this if it had some adjustments in usability'

- **Where:** §5.2 trigger 4 — supporting the developer / the policy: 'I purchased the premium version because I want to support the excellent privacy and pricing policies!'; 'you wouldn't do your job for free. Don't expect programmers to work for free either'; 'I wanna donate the developer'; purchase_intent 4 (0.63%, mean 4.50), two naming the exact blocker ('I would purchase app if it worked for habits that are different than once a day'; 'I'd pay for this if it had some adjustments in usability')
- **This app does:** privacy + pricing policy
- **User reaction:** purchase-driver
- **Magnitude:** trigger #4; intent 4
- **Direction for us:** do · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `7316654754`, `8770293457`, `5336687570`, `3961509114`, `4633186504`, `5606572349`, `13416844344`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C085 Address tracking / privacy visibly

### R43-093 — The upgrade barrier is evaluation and clarity, not price: (1) not enough free surface — 4 ask for a time-limited trial ('Would have more stars if I cd test out >3 goals — Prior to paying!'; 'How can I really see if I like this app if I don't get to use it fully functional? Why not give 2 weeks fully functional, then handicap it to 3?'; 'Would prefer a 1 month trial'; 'Wish I'd known that before I paid for it'); (2) not knowing what is bought — 5 cannot tell one-time from recurring, three of them 5★ reviewers trying to pay ('can't seem to figure out if the $2.99 is per month or a one time purchase.?') — the purchase sheet fails to state the product's best selling point; (3) a named missing capability (2)

- **Where:** §5.6 Barriers to upgrading — almost never price: (1) not enough free surface (historic, 4: 'Would have more stars if I cd test out >3 goals — Prior to paying!'; 'Why not give 2 weeks fully functional, then handicap it to 3?'); (2) not knowing what is bought (5; 'I'm absolutely loving the app but I'm wanting the upgrade but can't seem to figure out if the $2.99 is per month or a one time purchase.?' — 5★ reviewers trying to give money; the cheapest revenue fix); (3) a named missing capability (2)
- **This app does:** purchase sheet unclear; 3-cap (historic)
- **User reaction:** blocked-conversion
- **Magnitude:** 4 + 5 + 2
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `1986492426`, `4084647887`, `5876621564`, `7289065763`, `3961509114`, `4476308231`, `6238490934`, `9532357652`, `5835145722`, `5606572349`, `13416844344`
- **Canonical:** C147 Let people use the product before they pay; C177 One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says

### R43-135 — Experiment: surface the 'unlimited habits' unlock at the moment of demonstrated value (e.g. a 14-day streak) rather than at a count limit — the historic cap failed because it blocked before value was demonstrated; measure purchase rate and 'deceptive'-shaped language

- **Where:** §8.4 E3
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** historic cap 66
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C133 Gate on capability, not on quantity

## Tactics the app used

### R43-004 — Outcome of a launch-week seeded burst: 13 US 5★ reviews posted within 24 minutes on 10 Oct 2016 (three days after the app's first review), short generic non-native praise ('Use!!', 'Best!!', 'Helful', 'Thanks to'), zero votes — it lifted 2016's mean from 4.45 to 4.58 but moved the ten-year mean by only 0.02 (3.994 → 4.014); detected by timestamp clustering, flagged as us_2016_burst and excluded from market conclusions

- **Where:** Eight warnings #3 — a solicited-looking burst: 13 US 5★ reviews within 24 minutes on 10 Oct 2016 (18:15–18:39 UTC), three days after the first review, short generic non-native praise ('Use!!', 'Best!!', 'Helful', 'Thanks to'), zero votes; mean 4.014 → 3.994 without them; 2016 4.58 → 4.45 — 2016's strength partly manufactured
- **This app does:** seeded launch reviews
- **User reaction:** 5★-burst
- **Magnitude:** 13 (2.04%); 2016 4.58 → 4.45; global 4.014 → 3.994
- **Direction for us:** dont · **Report confidence:** suspected · **Generalisable:** yes
- **Review IDs:** `1464510394`, `1464510888`, `1464511771`, `1464512380`, `1464514000`, `1464514406`, `1464514777`, `1464515896`, `1464516366`, `1464516987`, `1464517402`, `1464517827`, `1464518182`
- **Canonical:** C054 Never run incentivised / review-for-premium campaigns; C076 Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable

### R43-020 — Outcome of shipping the requested platform: 12 Apple Watch requests (1.88%, mean 4.00) ran May 2019 ('Not using your app due to lack of iwatch… Let us know when iwatch comes out!') to Jan 2024, the listing now ships Watch, Mac (M1+), Vision and TV, and no Watch request appears after Jan 2024; the remaining platform ask is a Mac / desktop app ('il ne manque que l'application macOS'); at least four verified cases of the developer shipping what reviewers asked — Apple Watch, drag-to-reorder (7 earlier asks), the timer music fix that turned a 2★ into 5★, and a feature 'added a few days later'

- **Where:** Executive summary #14 — twelve asked for Apple Watch over five years (May 2019 'Not using your app due to lack of iwatch' → Jan 2024); the listing now ships Watch, Mac, Vision, TV and no Watch request appears after Jan 2024; the next ask is a Mac / desktop app (3); the developer ships requested features — Watch, drag-to-reorder, the timer music fix, a feature 'added a few days later'
- **This app does:** ships requests
- **User reaction:** praise
- **Magnitude:** Watch 12 (4.00) → 0 after Jan 2024; Mac 3
- **Direction for us:** do · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `4161687730`, `10783651409`, `1998324046`, `6885418251`, `3869364986`, `6506840284`, `10116531918`, `3705163026`, `13581758283`, `13415356335`
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C059 Be visibly responsive; fixes bring reviewers back

### R43-060 — Outcome of fast, specific support: praised by 24 (3.76%, mean 4.67) — 'replied to a recent query within minutes'; 'I got a new phone and suddenly had crashes. I wrote to Support. They replied very quickly with a solution'; a US reviewer raised their rating from 2★ to 5★ after the team shipped the exact fix asked for; 'requested a small new feature… added a few days later' (Jan 2026) — but two 2026 data-loss reviewers credit immediate support contact and still churned because the data was already gone

- **Where:** §3.3.5 Support as a differentiator — 24 (3.76%, mean 4.67): 'replied to a recent query within minutes'; new phone crashes fixed quickly after two years of daily use; a 2★ raised to 5★ after the exact requested fix shipped; two 2026 data-loss reviewers credit immediate support contact while still churning because the data was already gone
- **This app does:** responsive support
- **User reaction:** praise
- **Magnitude:** 24 (3.76%), 4.67; 2★→5★
- **Direction for us:** do · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `1626042608`, `3260189910`, `8279813275`, `13581758283`, `3705163026`, `14273363206`, `14291899176`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back

## Insights (the why)

### R43-009 — At a $2.99–4.99 one-time price, review damage — not refunds — is the cost of a broken unlock: 48 payers (7.52%) average 3.58 vs 4.05 for non-payers; 11 of 48 (22.9%) hit a reliability defect after paying and 4 of 48 (8.3%) say the purchase did not deliver — 'I paid to upgrade to get the edit function, but no changes happened… Something broken in the backend??'; 'I bought the premium but I haven't gotten any extra features'; 'Purchase premium but still getting free trial capabilities'; 'I upgraded app and nothing happens, just took my money' — yet only 2 reviewers in 638 request a refund

- **Where:** Executive summary #3 — payers rate worse (3.58 vs 4.05 non-payers, 48 payers 7.52%); 11 of 48 (22.9%) hit a defect after paying; 4 of 48 (8.3%) say the purchase did not deliver ('I paid to upgrade to get the edit function, but no changes happened'; 'Purchase premium but still getting free trial capabilities'; 'I upgraded app and nothing happens, just took my money'); only 2 of 638 request a refund — cheap enough that people leave a bad review instead
- **This app does:** one-time $2.99–4.99
- **User reaction:** churn
- **Magnitude:** payers 3.58 vs 4.05; defect 11/48 (22.9%); not delivered 4/48; refunds 2/638
- **Direction for us:** must-never-break · **Report confidence:** high-priority (segment) · **Generalisable:** yes
- **Review IDs:** `2945436722`, `5259644670`, `6302864374`, `6371120408`, `7226835619`, `7652035829`, `7984884909`, `9023682666`, `10019289476`, `10145156296`, `13278821225`, `1544580960`, `3395577909`, `5849652810`, `6537988680`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C078 Ship the paid feature working before you sell it — the purchase trigger must never be the broken feature

### R43-028 — No ads, no account and no data collection are enumerated together as reasons to choose the app — 'No subscription 🥳🎉 · Very reasonable one-time purchase price · Great data privacy (no data collected) · No ads' (DE, 5★)

- **Where:** §2.1 No ads, no account required, no data collection — 'No subscription · Very reasonable one-time purchase price · Great data privacy (no data collected) · No ads' enumerates all four
- **This app does:** no ads / account / tracking
- **User reaction:** praise
- **Magnitude:** 4 reviews
- **Direction for us:** product-rule · **Report confidence:** inventory · **Generalisable:** yes
- **Review IDs:** `6885418251`, `7256207765`, `7316654754`, `10453106838`
- **Canonical:** C035 Account system from day one; C085 Address tracking / privacy visibly; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R43-032 — A generous free tier substitutes for a trial; a 3-item one does not: 'please use the free version before buying it'; 'The free version will let you teach three habits which is more than enough to test out the App'; 'I started off using the 3 free habits to see if the app would help me stick to these new habits and it really has helped! Been using it for 2 months now and I will pay the once off fee' — only 4 reviews (0.63%) ever ask for a time-limited trial (vs 14 in report 42's 3-habit-plus-paid-basics corpus); the 2021–22 loosening looks like the developer reaching the same conclusion

- **Where:** §2.2 Interpretation — the free tier functioned as the trial: 'please use the free version before buying it'; 'three habits which is more than enough to test out the App'; 'I started off using the 3 free habits to see if the app would help… Been using it for 2 months now and I will pay the once off fee'; only 4 (0.63%) ask for a time-limited trial vs 14 in report 42 — a generous free tier substitutes for a trial, a 3-item one does not
- **This app does:** 3 free habits with full features, then uncapped
- **User reaction:** purchase-driver
- **Magnitude:** trial requests 4 (0.63%)
- **Direction for us:** product-rule · **Report confidence:** interpretation · **Generalisable:** yes
- **Review IDs:** `1514923982`, `6580752035`, `4633186504`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C063 Free trial before purchase; C147 Let people use the product before they pay

### R43-036 — Design praised 34 (5.33%, mean 4.88) — against ui_dated_ugly 16 (2.51%, 2.94) mostly non-US

- **Where:** §3.1 master table #14 praise_design
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 34 (5.33%), 4.88
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C057 Offer a non-pastel / premium design option

### R43-037 — Explicit churn 23 (3.61%, mean 1.87); churn risk 5 (0.78%, 2.60)

- **Where:** §3.1 master table #17 churn_exit / #55 churn_risk
- **This app does:** see §3.1
- **User reaction:** churn
- **Magnitude:** 23 (3.61%), 1.87; 5
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R43-047 — No ads praised 5 (0.78%, 4.80); privacy praised 1 (5.00)

- **Where:** §3.1 master table #48 praise_no_ads / #101 praise_privacy
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 5 + 1
- **Direction for us:** product-rule · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C085 Address tracking / privacy visibly; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R43-053 — Categories praised 4 (4.50); updates praised 4 (5.00); the 2025 redesign praised 3 (5.00); reorder praised 2 (5.00)

- **Where:** §3.1 master table #66 praise_categories / #67 praise_updates / #71 praise_redesign_2025 / #82 praise_reorder
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 4 + 4 + 3 + 2
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R43-055 — Family aggregates: core praise 350 (54.86%, mean 4.76); any praise 377 (59.09%, 4.72, only 8 of 117 1–2★); feature gaps 124 (19.44%, 3.64) → 21 of 117; monetisation praise 89 (13.95%, 4.70) → 0; monetisation friction 87 (13.64%, 2.45) → 51 (43.6%); reliability 74 (11.60%, 2.35) → 41 (35.0%); UX friction 61 (9.56%, 3.03) → 25 (21.4%); support 36 (5.64%, 3.75) → 6 — (a) the pricing model itself is a net asset, monetisation praise larger than friction and 2.25 stars higher, a shape no other corpus in the series has; (b) since friction is almost entirely pre-2022, a bad review in 2026 is reliability first, UX second, feature gaps third, pricing essentially not at all

- **Where:** §3.2 Theme-family aggregates (verbatim table) — core praise 350 (54.86%, 4.76); any praise 377 (59.09%, 4.72) → 8 of 117 1–2★; feature gaps 124 (19.44%, 3.64) → 21; monetisation praise 89 (13.95%, 4.70) → 0; monetisation friction 87 (13.64%, 2.45) → 51 (43.6%); reliability 74 (11.60%, 2.35) → 41 (35.0%); UX friction 61 (9.56%, 3.03) → 25; support 36 (5.64%, 3.75) → 6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Family | Reviews | % of 638 | Mean ★ | Share of the 117 1–2★ reviews | Signal ; Core praise (28 themes) | 350 | 54.86% | 4.76 | 4/117 (3.4%) | high-priority ; Any praise (core + monetization + support) | 377 | 59.09% | 4.72 | 8/117 (6.8%) | high-priority ; Feature gaps & requests (29 themes) | 124 | 19.44% | 3.64 | 21/117 (17.9%) | high-priority ; Monetization praise (5 themes) | 89 | 13.95% | 4.70 | 0/117 (0.0%) | high-priority ; Monetization friction (11 themes) | 87 | 13.64% | 2.45 | 51/117 (43.6%) | high-priority ; Reliability defects (12 themes) | 74 | 11.60% | 2.35 | 41/117 (35.0%) | high-priority ; UX friction (13 themes) | 61 | 9.56% | 3.03 | 25/117 (21.4%) | high-priority ; Support (4 themes) | 36 | 5.64% | 3.75 | 6/117 (5.1%) | high-priority
- **Direction for us:** product-rule · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C003 Lead with a one-time lifetime purchase

### R43-056 — Daily use is simple; setup is not — the same product draws 123 'simple' reviews (19.28%, mean 4.86, top every year in ten languages) and 20 'I couldn't figure it out' reviews: 'Beautiful simplicity… I keep coming back to this one'; 'You can make this app as complicated or as simple as you like'; 'you don't have to read a bunch of flowery, condescending you can do it! messages'; 'It's not all illustrated with pink & blue kittens and ribbons… nor is it incessantly asking me to note my feelings for the day'; 'There is a little bit of a learning curve to setting up habits with certain settings, but once they are set up, the app is super simple in day to day use'; 'after a couple days you will appreciate the robust settings over the bare minimum other apps give' — an onboarding fix targets a different surface from the praised simplicity

- **Where:** §3.3.1 Simplicity is the biggest theme — 123 (19.28%, mean 4.86), top every year, ten languages; 'Beautiful simplicity… I keep coming back to this one'; 'You can make this app as complicated or as simple as you like'; 'you don't have to read a bunch of flowery, condescending you can do it! messages'; 'not all illustrated with pink & blue kittens and ribbons… nor is it incessantly asking me to note my feelings' — daily use is simple, setup is not ('a little bit of a learning curve to setting up… once they are set up, the app is super simple')
- **This app does:** robust settings, minimal daily surface, no motivational fluff
- **User reaction:** praise
- **Magnitude:** 123 (19.28%), 4.86 vs learning curve 20
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `1464655793`, `1534641505`, `8251773389`, `8770293457`, `10280711337`, `3849179643`, `7673068249`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C178 A quiet, adult, non-gamified tracker is a positioning some users actively seek; C259 An in-app help screen — first-run tour, searchable FAQ, per-setting explanations — for any product whose setup is richer than its daily use

### R43-057 — The core loop works — 61 first-person outcome accounts (9.56%) at a 4.95 mean, the highest of any theme: 'I used to stress about remembering to take my meds, remembering to floss… Now I don't'; 'I started with a simple task of drinking 8 cups of water. For the first time in my entire life, I actually did'; 'I have depression and sometimes find it hard to do even the simplest things - like taking a shower… I put easy things on my routine list'; 'my life has completely changed in the past two weeks… I have done all 13 daily habits almost every day since I got it' (the most-upvoted review); 'this app has literally cured my anxiety' — every recommendation is about protecting this, not changing it

- **Where:** §3.3.2 Behaviour change — 61 (9.56%, mean 4.95, the highest of any theme n>10): meds, flossing, water, showering, exercise, study, chores; 'For the first time in my entire life, I actually did'; 'I have depression… I put easy things on my routine list'; 'my life has completely changed in the past two weeks… all 13 daily habits almost every day' (most-upvoted); 'literally cured my anxiety' — protect, don't change
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 61 (9.56%), 4.95
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `1606850924`, `5116172341`, `5403626844`, `5307496014`, `12554097189`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R43-064 — At $2.99 the price objection was about being stopped, not about money: 36 reviews (5.64%, mean 2.31) — 11 in 2016–18, 22 in 2019–21, 3 in 2022–26 — almost all object to paying at all ('i don't like that you have to pay when you can easily set timers on your phone for free'; 'I'm a college student so I'm ~broke~'; 'Just make the app cost 3 dollars from the start instead of wasting everybody's time' — an objection to the model) and only two call the price itself too high; once people were not stopped, the objection stopped

- **Where:** §3.4.2 Price objections — 36 (5.64%, mean 2.31), also historical: 11 (2016–18), 22 (2019–21), 3 (2022–26); almost all object to paying at all, not the $2.99 amount — 'you can easily set timers on your phone for free'; 'I'm a college student so I'm ~broke~'; 'Just make the app cost 3 dollars from the start instead of wasting everybody's time'; only two call the price too high — at $2.99 the objection was about being stopped, not money
- **This app does:** $2.99 one-time behind a 3-cap
- **User reaction:** complaint
- **Magnitude:** 36 (5.64%), 2.31; 3 since 2022
- **Direction for us:** product-rule · **Report confidence:** high-priority (historical) · **Generalisable:** yes
- **Review IDs:** `5889989562`, `7912717292`, `2275905867`, `5750812833`, `7714812880`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C064 Price level — where 'fair' turns into 'too expensive'

### R43-070 — A dated, dense UI costs the app non-US users who trade features for looks: UX friction 61 (9.56%, mean 3.03) — dated / ugly UI 16 (2.51%, 2.94), 10 of 16 non-US against a 35.9% baseline ('Wow what an outdated looking UI… Can we please have higher resolution icons and UI elements for 2021 not 2011?', AU; 'the design could still use some polish', DE 2016; 'I'd prefer more color and the option to have a cleaner look with less text in the habit list… Presently I'm using other habit trackers that have fewer features but are more visually appealing to me', DE payer); learning curve 14; onboarding missing 9; UX confusion 9; cluttered 9; swipe-done 5; review prompt nag 4; journal popup 2

- **Where:** §3.4.4 UX friction (verbatim table) — ui_dated_ugly 16 (2.51%, 2.94; 10 of 16 non-US vs 35.9% baseline: 'higher resolution icons and UI elements for 2021 not 2011?'; 'I'd prefer more color and… a cleaner look… Presently I'm using other habit trackers that have fewer features but are more visually appealing' — a payer naming the trade-off); learning_curve 14; onboarding_missing 9; ux_confusion 9; ui_cluttered 9; swipe_done_ux 5; review_prompt_nag 4; popup_journal_2025 2
- **This app does:** dated UI
- **User reaction:** mixed
- **Magnitude:** Sub-theme | n | % | Mean ★ | Signal ; ui_dated_ugly | 16 | 2.51% | 2.94 | meaningful ; learning_curve | 14 | 2.19% | 3.36 | meaningful ; onboarding_missing | 9 | 1.41% | 2.78 | meaningful ; ux_confusion | 9 | 1.41% | 3.33 | meaningful ; ui_cluttered | 9 | 1.41% | 3.00 | meaningful ; swipe_done_ux | 5 | 0.78% | 3.20 | emerging ; review_prompt_nag | 4 | 0.63% | 2.75 | emerging ; popup_journal_2025 | 2 | 0.31% | 1.50 | weak ; others (text_size_accessibility, notification_annoyance, storage_complaint, localization_quality, review_prompt_bug) | 1 each | 0.16% | — | weak
- **Direction for us:** do · **Report confidence:** high-priority (union) · **Generalisable:** yes
- **Review IDs:** `1483614751`, `7264484143`, `8625672596`, `7316654754`
- **Canonical:** C057 Offer a non-pastel / premium design option; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R43-076 — Why people give 5★: it is simple, it changed a behaviour, and it cost three dollars once — simplicity 29.5% of the band, behaviour change 15.5%, value / cheap 13.9%, stats 12.9%, best-of-many 11.8%, reminders 11.8%, customisation 10.7%, design 8.0%, one-time price 7.8%; 24 of 373 are confirmed payers (the largest payer block); stripping the 13 burst and 51 low-info records leaves 315 substantive 5★ (49.4% of the corpus)

- **Where:** §4.1 Five stars (verbatim table) — simplicity 29.5%, behaviour change 15.5%, generic 14.2%, value / cheap 13.9%, low_info 13.7%, stats 12.9%, best-of-many 11.8%, reminders 11.8%, customisation 10.7%, design 8.0%, one-time 7.8%, payer 6.4%; 'it is simple, it changed a behaviour, and it cost three dollars once'; 315 substantive 5★ after stripping burst and low_info
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Theme | n | % of 5★ ; praise_simplicity | 110 | 29.5% ; praise_behaviour_change | 58 | 15.5% ; praise_generic | 53 | 14.2% ; praise_value_cheap | 52 | 13.9% ; low_info | 51 | 13.7% ; praise_stats | 48 | 12.9% ; praise_best_of_many | 44 | 11.8% ; praise_reminders | 44 | 11.8% ; praise_customization | 40 | 10.7% ; praise_design | 30 | 8.0% ; praise_one_time_price | 29 | 7.8% ; paid_direct | 24 | 6.4%
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C006 Stay minimal — every addition is opt-in or off by default

### R43-077 — The 4★ band is a roadmap with an explicit price per star: 94 reviews — feature requests 11.7%, reminders praised 8.5%, cap 7.4%, one-time praised 7.4%, notification improvements 7.4%, scheduling gaps 6.4%, too limited 5.3%, Watch 5.3%, reorder 4.3% — 'Would get 5 stars if it had Apple Watch support'; 'plz add that option then i will change to five star'; 'Iron out that crinkle and you get five stars from me!'; 'Need the shortcuts iOS integration. Then… 5 stars!' — three of the most-named items (Watch, reorder, localisation) have since shipped

- **Where:** §4.2 Four stars (verbatim table) — a feature-request queue: feature_request_other 11, reminders 8, cap 7, one-time 7, notification improvements 7, scheduling 6, too_limited 5, Watch 5, reorder 4; 'Would get 5 stars if it had Apple Watch support'; 'plz add that option then i will change to five star'; 'Need the shortcuts iOS integration. Then… 5 stars!' — three of the most-named items have since shipped
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 4★ ; praise_simplicity | 11 | 11.7% ; feature_request_other | 11 | 11.7% ; praise_reminders | 8 | 8.5% ; free_cap_3habits | 7 | 7.4% ; praise_one_time_price | 7 | 7.4% ; notification_improvement_request | 7 | 7.4% ; scheduling_flexibility_missing | 6 | 6.4% ; too_limited | 5 | 5.3% ; apple_watch_missing | 5 | 5.3% ; reorder_missing | 4 | 4.3%
- **Direction for us:** do · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6325610929`, `1628782242`, `4407802540`, `3429879417`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R43-078 — 3★ is capped satisfaction — one named thing holds the rating: cap 11 (20.4%), scheduling gaps 8 (14.8%), price 7 (13.0%), notification bug 6 (11.1%), localisation 4 (7.4%), payer 4; widget / UX confusion / onboarding / learning curve / broken support channel 3 each; all three Arabic requests land here ('Nice app but it lacks Arabic support, so it deserves ⭐️⭐️⭐️')

- **Where:** §4.3 Three stars (verbatim table) — 'capped satisfaction': cap 20.4%, scheduling 14.8%, price 13.0%, notification bug 11.1%, localisation 7.4%; all three Arabic requests land here ('Nice app but it lacks Arabic support, so it deserves ⭐️⭐️⭐️')
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 3★ ; free_cap_3habits | 11 | 20.4% ; scheduling_flexibility_missing | 8 | 14.8% ; price_objection | 7 | 13.0% ; notification_bug | 6 | 11.1% ; localization_missing | 4 | 7.4% ; paid_direct | 4 | 7.4% ; widget_issue / ux_confusion / onboarding_missing / learning_curve / support_channel_broken | 3 each | 5.6%
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `12565071834`, `12752447582`, `12767914274`
- **Canonical:** C027 Localise early — it unlocks revenue

### R43-079 — The 2★ band is the historic paywall: cap 15 of 41 (36.6%) and price 13 (31.7%), 14 of those 15 cap reviews predating 2023; dated UI 6, churn 6, payer 5, competitor 4; scheduling / regression / cluttered / too limited / crash 3 each — strip the pre-2022 paywall reviews and it is a handful of UI and reliability complaints

- **Where:** §4.4 Two stars (verbatim table) — almost entirely the historic paywall: cap 15 (36.6%), price 13 (31.7%), 14 of 15 cap reviews predate 2023; ui_dated 6, churn 6, payer 5, competitor 4; strip the pre-2022 paywall reviews and the band is a handful of UI and reliability complaints
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Theme | n | % of 2★ ; free_cap_3habits | 15 | 36.6% ; price_objection | 13 | 31.7% ; ui_dated_ugly | 6 | 14.6% ; churn_exit | 6 | 14.6% ; paid_direct | 5 | 12.2% ; competitor_mention | 4 | 9.8% ; scheduling_flexibility_missing / regression_after_update / ui_cluttered / too_limited / crash_wont_open | 3 each | 7.3%
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** yes
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R43-088 — Permanence is what payers value, and some would pay again to fund maintenance: 'only $2.99 to unlock all the features (forever at no additional expense or yearly renew)'; 'It has iCloud sync, stats, and notes… It isn't a completely unnecessary monthly subscription like most habit apps. I would be happy to purchase it every year so they could continue to keep it up to date'; payers evangelise the price — 'Absolutely worth paying the tiny fee to get unlimited tasks. Just Buy It ALREADY!!!'; 'Pay for it - the free one is great, but I promise you, the full version is well worth it!'

- **Where:** §5.3 What paid users value — permanence: 'only $2.99 to unlock all the features (forever at no additional expense or yearly renew)'; 'It isn't a completely unnecessary monthly subscription… I would be happy to purchase it every year so they could continue to keep it up to date' (a payer volunteering to pay more); evangelists 'Just Buy It ALREADY!!!'; 'Pay for it - the free one is great, but… the full version is well worth it!'
- **This app does:** one-time forever
- **User reaction:** praise
- **Magnitude:** 24 of 48 payers at 5★
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `7117527798`, `3627076218`, `1846285750`, `4047899872`, `5307496014`
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R43-091 — A cheap one-time purchase generates almost no billing conflict — an under-appreciated operational advantage over subscription: 2 refund references in 638 (0.31%; 4.2% of payers vs 37.9% in report 42's subscription corpus), zero subscription cancellations, zero unexpected charges, zero trial traps, zero chargebacks; the two: 'Your copy and paste reply is laughable… Just update the app or give us a refund' (the only canned-reply report) and a refund refused within the EU 14-day withdrawal window ('lack of customer-friendliness', DE, 1★)

- **Where:** §5.5 Refunds remarkably quiet — 2 of 638 (0.31%), both 1★: a glitchy purchase met by 'Your copy and paste reply is laughable… Just update the app or give us a refund'; a refund refused inside the EU 14-day withdrawal period; zero cancellations, unexpected charges, trial traps or chargebacks vs 11 of 29 payers (37.9%) in report 42 — a $2.99–4.99 one-time purchase generates almost no billing conflict
- **This app does:** one-time $2.99–4.99
- **User reaction:** praise
- **Magnitude:** refunds 2/638 (4.2% of payers) vs 37.9%
- **Direction for us:** build-paid · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `6302864374`, `6537988680`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C089 Promos, giveaways and gift codes must work exactly as advertised; C112 In-app cancellation

## Audiences

### R43-018 — ADHD and executive-function users are the warmest, fastest-growing constituency — without being targeted: ADHD named in 18 reviews (2.82%, mean 4.61) plus 12 other accessibility accounts (1.88%, 4.75 — autism, depression, chronic illness, head injury, ASD, disability, anxiety), union 25; 17 of 18 and 12 of 12 are US; 0.0% of 2016–18 reviews → 5.84% of 2022–26; 'I was not diagnosed with ADHD until last year at age 25… Habit Hub is a surprisingly simple but infinitely helpful app. It has significantly improved my relationship with my fiancée'; 'I have ASD and some executive functioning issues… I love that it's a widget!… Thank you for %'s and grades' (16 votes); 'I have severe ADHD and I use this app to complete tasks that would otherwise take hours on end — cooking, cleaning, and even applying makeup'; 'severe depression paired with adhd, and this has so far motivated me to shower for the first time in a week'; 'I'm autistic and have ADHD and this app has helped me get my life under control' — the listing already says 'ADHD-friendly interface' and the corpus supports it

- **Where:** Executive summary #12 — ADHD / executive-function use is a growing, almost exclusively US segment and the warmest constituency: ADHD 18 (2.82%, mean 4.61) + accessibility 12 (1.88%, 4.75; autism, depression, chronic illness, head injury, ASD, disability, anxiety); 17 of 18 and 12 of 12 US; 0.0% (2016–18) → 5.84% (2022–26); 'diagnosed with ADHD… at age 25… significantly improved my relationship with my fiancée'; 'I have ASD… I love that it's a widget… Thank you for %'s and grades' (16 votes); 'severe ADHD… cooking, cleaning, and even applying makeup'; 'motivated me to shower for the first time in a week'
- **This app does:** nag reminders, timers, widget, grades
- **User reaction:** praise
- **Magnitude:** ADHD 18 (4.61) + accessibility 12 (4.75) = 25; 0.0% → 5.84%
- **Direction for us:** do · **Report confidence:** meaningful, growing · **Generalisable:** yes
- **Review IDs:** `5460506563`, `7010047564`, `9164282595`, `8151253624`, `11268226195`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R43-100 — The ADHD / accessibility segment (25 reviews, 3.92%, mean 4.64; 24 of 25 US; the fastest-growing theme — 0.00% of 2016–18 → 4.22% → 7.79% of 2022–26) names two mechanics almost nobody else does: the multi-step timer (used to decompose a morning routine, cooking or an adult child's routine into timed steps) and the home-screen widget ('if I have to seek it out a lot of the time it's not happening. I can miss notifications, but not if it's on my Home Screen'); accounts include autism, chronic illness and memory loss, depression, head injury, ASD, disability ('dealing with a brain that doesn't often work perfectly'), anxiety, and 'when I don't have the brain power to think it just tells me what to do next'; one VoiceOver user confirms it works; one 'The text is small, I can not see to read it!' — timer and widget should be protected surfaces in any redesign; only 2 of the 25 are confirmed payers (research question)

- **Where:** §6.5 The ADHD / accessibility segment — 25 (3.92%, very strong), mean 4.64; 24 of 25 US; growth 0.00% (2016–18) → 4.22% → 7.79% (2022–26), the fastest-growing theme; two features named repeatedly by this segment and almost nobody else — the multi-step timer (decompose a morning routine or cooking into timed steps) and the widget ('if I have to seek it out a lot of the time it's not happening. I can miss notifications, but not if it's on my Home Screen'); the only VoiceOver confirmation; one text-too-small complaint; treat timer and widget as protected surfaces
- **This app does:** step timers, widget, nag, grades
- **User reaction:** praise
- **Magnitude:** 25 (3.92%), 4.64; 0.00 → 7.79%; payers 2/25
- **Direction for us:** product-rule · **Report confidence:** very strong · **Generalisable:** yes
- **Review IDs:** `4047899872`, `4841363699`, `5460506563`, `5497234508`, `5751819554`, `5762418939`, `6186041222`, `6580736792`, `8151253624`, `8318478253`, `8878232742`, `9164282595`, `9194130138`, `9195704288`, `11268226195`, `12970752478`, `13394656031`, `14052132595`, `3743116260`, `4384478235`, `5403626844`, `7010047564`, `8208737898`, `9773508594`, `12554097189`, `4210723089`, `4939227766`
- **Canonical:** C009 Basic widgets, icons and colours are free; C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C066 Focus timer; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

## Markets and languages

### R43-019 — A missing language caps satisfaction at exactly 3★: 10 localisation requests (1.57%, mean 3.20), all non-US (4.37% of the 229 non-US) — Arabic three times in fourteen months ('Does this app support Arabic or not?'; 'Nice app but it lacks Arabic support, so it deserves ⭐️⭐️⭐️'), Spanish three ('La app solo esta en ingles'), Portuguese two (both BR 5★, pleading), Polish one; the listing now lists English, Japanese, Korean, Portuguese, Spanish, so Portuguese and Spanish appear answered and Arabic is the only unanswered cluster; one localisation-quality failure — 'The app is a mess, full of spelling mistakes' (GB, 1★)

- **Where:** Executive summary #13 — localisation is the only clearly non-US gap: 10 (1.57%, mean 3.20), all non-US (4.37% of 229); Arabic three times in 14 months (SA, OM, SA — 'Nice app but it lacks Arabic support, so it deserves 3 stars'), Spanish 3, Portuguese 2 (both BR 5★ pleading), Polish 1, general 1; listing now has English, Japanese, Korean, Portuguese, Spanish — Arabic unanswered, producing exactly 3★; 'full of spelling mistakes' (GB, 1★)
- **This app does:** 5 languages; no Arabic
- **User reaction:** complaint
- **Magnitude:** 10 (1.57%), 3.20; Arabic 3 (all 3★)
- **Direction for us:** build-free · **Report confidence:** meaningful · **Generalisable:** yes
- **Review IDs:** `12565071834`, `12752447582`, `12767914274`, `8182517804`, `11496905396`, `11605150337`, `5849454883`, `6230329628`, `10158814839`, `4318358329`, `10905816260`
- **Canonical:** C027 Localise early — it unlocks revenue

### R43-095 — Storefront distribution: US 409 (64.11%, mean 3.934) the only eligible; UK 28 (4.286), Canada 27 (4.333), Australia 21 (4.476), India 19 (4.316), Vietnam 11 (3.636), Germany 10 (3.900), Philippines / Poland 7 each, Brazil / Mexico 6, Italy / Turkey 5, Spain / Netherlands 4, China / France / Japan / New Zealand / Oman / Russia 3, 17 storefronts with 2, 17 with 1

- **Where:** §6.1 Distribution (verbatim table) — US 409 (64.11%, 3.934) the only eligible; GB 28 (4.286), CA 27 (4.333), AU 21 (4.476), IN 19 (4.316), VN 11 (3.636), DE 10 (3.900), PH / PL 7, BR / MX 6, IT / TR 5, ES / NL 4, CN / FR / JP / NZ / OM / RU 3, 17 with 2, 17 with 1
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | % of 638 | Mean ★ | Eligible? ; United States | 409 | 64.11% | 3.934 | Yes — the only eligible storefront ; United Kingdom | 28 | 4.39% | 4.286 | No — limited evidence ; Canada | 27 | 4.23% | 4.333 | No — limited evidence ; Australia | 21 | 3.29% | 4.476 | No — limited evidence ; India | 19 | 2.98% | 4.316 | No — limited evidence ; Vietnam | 11 | 1.72% | 3.636 | No ; Germany | 10 | 1.57% | 3.900 | No ; Philippines, Poland | 7 each | 1.10% | 3.857 / 3.714 | No ; Brazil, Mexico | 6 each | 0.94% | 4.333 / 3.500 | No ; Italy, Turkey | 5 each | 0.78% | 4.400 / 3.600 | No ; Spain, Netherlands | 4 each | 0.63% | 4.000 / 5.000 | No ; China, France, Japan, New Zealand, Oman, Russia | 3 each | 0.47% | 3.667 / 4.667 / 4.667 / 3.667 / 3.333 / 5.000 | No ; 17 storefronts with 2 reviews | 34 | 5.33% | — | No ; 17 storefronts with 1 review | 17 | 2.66% | — | No
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R43-096 — US (n = 409, mean 3.934; 5★ 56.7%, 1★ 13.4%): simplicity 18.58%, cap 12.22% (above global), behaviour change 11.25%, reminders 9.05%, stats 8.56%, customisation 8.07%, value 8.07%, best-of-many 7.33%, one-time 6.85%, price objection 6.36%, payer 6.11%, scheduling gap 5.13%, crash 4.40%, ADHD 4.16%, churn 3.91%, deceptive free 3.42%, accessibility 2.93%, localisation 0.00% — four distinctively American things: the paywall reaction concentrated here (75.8% of cap and 87.5% of 'bait and switch' / 'scam' reviews), crashes reported almost exclusively here (90.0%; probably a reporting-behaviour artefact, labelled uncertain), ADHD / accessibility a US phenomenon, and zero language requests; the US mean sits below the non-US 4.157 because of the paywall era

- **Where:** §6.2 United States — n = 409, mean 3.934 (verbatim table); four distinctively American things: the paywall reaction concentrated here (50 of 66 cap, 14 of 16 deceptive_free — 'false advertising', 'bait and switch', 'scam' language); crashes reported almost exclusively here (18 of 20; likely a reporting-behaviour artifact, uncertain); ADHD / accessibility a US phenomenon (17 of 18; 12 of 12); localisation a non-issue by construction; US mean 3.934 < non-US 4.157 because of the paywall era
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | % of 409 | Signal (US scope) | vs global ; praise_simplicity | 76 | 18.58% | high-priority | below global 19.28% ; free_cap_3habits | 50 | 12.22% | high-priority | above global 10.34% ; praise_behaviour_change | 46 | 11.25% | high-priority | above global 9.56% ; low_info | 37 | 9.05% | high-priority | below global 9.25% ; praise_reminders | 37 | 9.05% | high-priority | above global 8.46% ; praise_stats | 35 | 8.56% | high-priority | below global 8.62% ; praise_customization | 33 | 8.07% | high-priority | above global 7.21% ; praise_value_cheap | 33 | 8.07% | high-priority | below global 8.93% ; praise_best_of_many | 30 | 7.33% | high-priority | below global 7.84% ; praise_one_time_price | 28 | 6.85% | high-priority | above global 6.27% ; price_objection | 26 | 6.36% | high-priority | above global 5.64% ; paid_direct | 25 | 6.11% | high-priority | below global 7.52% ; scheduling_flexibility_missing | 21 | 5.13% | high-priority | above global 4.55% ; crash_wont_open | 18 | 4.40% | very strong | well above global 3.13% ; praise_adhd | 17 | 4.16% | very strong | well above global 2.82% ; churn_exit | 16 | 3.91% | very strong | above global 3.61% ; deceptive_free | 14 | 3.42% | very strong | above global 2.51% ; accessibility_use_case | 12 | 2.93% | meaningful | above global 1.88% ; localization_missing | 0 | 0.00% | ignore | global 1.57%
- **Direction for us:** research · **Report confidence:** US standalone · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R43-097 — Non-US aggregate (n = 229, mean 4.157) vs US: cap 6.99% vs 12.22%; deceptive free 0.87% vs 3.42%; crash 0.87% vs 4.40%; ADHD 0.44% vs 4.16%; accessibility 0.00% vs 2.93%; localisation 4.37% vs 0.00%; payer 10.04% vs 6.11% (weak, 9 records); dated / ugly UI 4.37% vs 1.47% — visual design is criticised more outside the US (10 of 16 across Germany, UK ×3, Croatia, Egypt, Australia, Mexico, Indonesia; limited evidence); value praise 10.48% vs 8.07%; simplicity similar (20.52% vs 18.58%)

- **Where:** §6.3 The non-US aggregate — n = 229, mean 4.157 (verbatim table): cap 6.99% vs 12.22%; deceptive 0.87% vs 3.42%; crash 0.87% vs 4.40%; ADHD 0.44% vs 4.16%; accessibility 0.00%; localisation 4.37% vs 0.00%; payer 10.04% vs 6.11% (weak); ui_dated_ugly 4.37% vs 1.47% — non-US complains more about design (10 of 16 across DE, GB ×3, HR, EG, AU, MX, ID); value praise 10.48% vs 8.07%
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | US (n=409) | Non-US (n=229) | Direction ; free_cap_3habits | 12.22% | 6.99% | US complains more ; deceptive_free | 3.42% | 0.87% | US complains more ; crash_wont_open | 4.40% | 0.87% | US reports more ; praise_adhd | 4.16% | 0.44% | US only ; accessibility_use_case | 2.93% | 0.00% | US only ; localization_missing | 0.00% | 4.37% | Non-US only ; paid_direct | 6.11% | 10.04% | Non-US pays more (weak) ; ui_dated_ugly | 1.47% | 4.37% | Non-US complains more ; praise_value_cheap | 8.07% | 10.48% | Non-US praises price more ; praise_simplicity | 18.58% | 20.52% | Similar
- **Direction for us:** research · **Report confidence:** aggregate (limited per country) · **Generalisable:** yes
- **Review IDs:** `7316654754`
- **Canonical:** C057 Offer a non-pastel / premium design option; C062 Weight English-speaking rich markets; volume ≠ revenue

### R43-098 — Arabic: three independent Arabic-storefront reviewers (Saudi Arabia ×2, Oman) raised the same missing language within one quarter (Apr–Jun 2025) and each capped their rating at exactly 3★ while otherwise positive — limited evidence by market size, unanimous in character; the report's recommendation is Arabic with RTL layout

- **Where:** §6.3 (b) Arabic is the only unanswered language cluster — SA Apr 2025, OM Jun 2025, SA Jun 2025, all exactly 3★, all otherwise positive; Saudi Arabia 2 reviews, Oman 3 — the signal is that all three independent Arabic-storefront reviewers raised the same point in one quarter and capped at 3
- **This app does:** no Arabic / RTL
- **User reaction:** complaint
- **Magnitude:** 3 (all 3★); SA n=2, OM n=3
- **Direction for us:** build-free · **Report confidence:** limited evidence · **Generalisable:** yes
- **Review IDs:** `12565071834`, `12752447582`, `12767914274`
- **Canonical:** C027 Localise early — it unlocks revenue

### R43-101 — High-spend markets (US, JP, CN, GB, DE, KR, CA, AU, FR) hold 505 reviews (79.15%) at mean 4.006 vs 4.045 for the rest — indistinguishable; the paywall objection was 2.6× more common inside the group (11.88% vs 4.51%), one-time-price praise 7.13% vs 3.01%, and every single language request comes from outside it (0.00% vs 7.52%) — exactly what the listing's five languages (four of them high-spend markets) would predict; the group is 81.0% US and Japan, China, Korea, France contribute 10 reviews between them

- **Where:** §6.6 High-spend market group (verbatim table) — US, JP, CN, GB, DE, KR, CA, AU, FR = 505 (79.15%), mean 4.006 vs 4.045; cap 11.88% vs 4.51% (2.6×); payer 7.72% vs 6.77%; one-time praise 7.13% vs 3.01%; localisation 0.00% vs 7.52% — every language request is outside the group, as the five listed languages predict; 81.0% US by volume; JP, CN, KR, FR contribute 10 reviews
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Metric | High-spend group | Rest of world ; Storefronts present | 9 of 9 | 46 ; Reviews | 505 (79.15%) | 133 (20.85%) ; Mean rating | 4.006 | 4.045 ; free_cap_3habits | 60 (11.88%) | 6 (4.51%) ; paid_direct | 39 (7.72%) | 9 (6.77%) ; praise_one_time_price | 36 (7.13%) | 4 (3.01%) ; localization_missing | 0 (0.00%) | 10 (7.52%) ; praise_simplicity | 95 (18.81%) | 28 (21.05%)
- **Direction for us:** research · **Report confidence:** group (external definition; mostly US) · **Generalisable:** yes
- **Canonical:** C027 Localise early — it unlocks revenue; C062 Weight English-speaking rich markets; volume ≠ revenue

### R43-102 — The six highest-volume storefronts (US, GB, CA, AU, IN, VN; 515, 80.72%, mean 4.004) overlap the high-spend group almost completely; neither grouping separates this corpus into different populations — the only cut that does is US vs non-US, and the only theme that cleanly separates them is localisation

- **Where:** §6.7 High-review-volume market group (verbatim table) — US, GB, CA, AU, IN, VN = 515 (80.72%), 4.004 vs 4.057; overlaps high-spend almost completely; neither grouping separates the corpus — only US vs non-US does, and only localisation cleanly separates them
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** Metric | High-volume group | Rest ; Reviews | 515 (80.72%) | 123 (19.28%) ; Mean rating | 4.004 | 4.057 ; praise_simplicity | 96 (18.64%) | 27 (21.95%) ; free_cap_3habits | 60 (11.65%) | 6 (4.88%) ; paid_direct | 38 (7.38%) | 10 (8.13%)
- **Direction for us:** none · **Report confidence:** group (review-volume proxy) · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R43-103 — Sub-50 observations (limited evidence): Germany 10 (3.900) holds both 2026 four-year data losses four days apart (possibly one root cause), the only refund refusal and the most detailed positive payer review; UK 28 (4.286) three of the 16 dated-UI reviews; Canada 27 (4.333) six confirmed payers — 22.2%, the highest payer density of any storefront with n > 5; Australia 21 (4.476); Vietnam 11 (3.636, the lowest n > 10) a lifetime payer with an unanswered support e-mail and a rating / text contradiction; Saudi Arabia + Oman 5 all three Arabic requests; Brazil 6 two 5★ reviews whose entire content is a plea for Portuguese (now listed)

- **Where:** §6.8 Other sub-50 storefronts (verbatim table) — Germany 10 (3.900): both 2026 four-year data losses (4 days apart, possibly one root cause), the only refund refusal, the most detailed positive payer review; UK 28 (4.286): 3 of 16 dated-UI reviews; Canada 27 (4.333): six payers (22.2%, highest payer density); Australia 21 (4.476); Vietnam 11 (3.636, lowest n>10): a lifetime payer with an unanswered support e-mail; SA + OM 5: all three Arabic requests; Brazil 6: two 5★ reviews that are pleas for Portuguese
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Storefront | n | Observation | Warning ; Germany | 10 | Mean 3.900. Holds both 2026 four-year data-loss reviews (14273363206, 14291899176), the corpus's only refund refusal (6537988680), and its most detailed positive payer review (7316654754). | n=10; the two data-loss reviews are 4 days apart and may share a single root cause ; United Kingdom | 28 | Mean 4.286, highest of the four near-threshold storefronts after AU. Three of the corpus's 16 ui_dated_ugly reviews. | n=28, below threshold ; Canada | 27 | Mean 4.333. Six confirmed payers (22.2% of CA reviews vs 7.52% globally) — the highest payer density of any storefront with n>5. | n=27; 6 records ; Australia | 21 | Mean 4.476, highest of the near-threshold group. | n=21 ; Vietnam | 11 | Mean 3.636, lowest of any storefront with n>10. Holds a lifetime payer with an unanswered support email (10019289476) and a rating/text contradiction (7755890511). | n=11 ; Saudi Arabia + Oman | 5 combined | All three Arabic-language requests, all 3★ (§6.3b) | n=5 across 2 storefronts ; Brazil | 6 | Two 5★ reviews whose entire content is a plea for Portuguese (5849454883, 6230329628); the listing now supports Portuguese | n=6
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** app-specific
- **Review IDs:** `14273363206`, `14291899176`, `6537988680`, `7316654754`, `10019289476`, `7755890511`, `5849454883`, `6230329628`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

## Dated events and trends

### R43-007 — The reference case for what lifting a free cap does to sentiment: 'you only get 3 habits, then you pay' is the largest negative theme (66, 10.34%, mean 2.36) yet not a current one — yearly 7.5% (2016) → 11.5 → 13.3 → 12.8 → 13.8 → 14.1% (2021) → 6.7 → 3.6 → 0.0% (2024) → 3.3 → 0.0% (2026); all monetisation friction 23.1% of 2020 reviews → 0.0% of 2024 and 2026; from 2022 reviewers say the opposite — 'It has none of that premium membership biz… can have everything the app has to offer without purchasing anything' (Apr 2022); 'it's so hard to find an app that'll let you track unlimited amounts of habits for free but this one does it' (DK, Jan 2024); 'No need to pay to repeat everyday routine' (MY); 'this is completely free!' (IN, 2025) — the free tier was materially loosened around 2021–2022

- **Where:** Executive summary #1 — the central monetisation problem was solved and the corpus records when: free-cap complaint 66 (10.34%, mean 2.36) runs 7.5% (2016) → 11.5 → 13.3 → 12.8 → 13.8 → 14.1% (2021) → 6.7 → 3.6 → 0.0% (2024) → 3.3 → 0.0% (2026); monetisation friction 23.1% of 2020 → 0.0% of 2024 and 2026; from 2022 'can have everything the app has to offer without purchasing anything'; 'track unlimited amounts of habits for free' — the reference case for what raising a free cap does
- **This app does:** 3-habit cap (2016–~2022) → uncapped
- **User reaction:** praise
- **Magnitude:** cap 66 (10.34%), 2.36; 14.1% (2021) → 0.0% (2024, 2026); friction 23.1% (2020) → 0.0%
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `8554147668`, `10869613654`, `11799865019`, `12410220634`
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set; C007 Generous fixed habit cap (or unlimited) — never change it

### R43-008 — Once the paywall was fixed, reliability became the whole job: era table — 2016–18 n 176, mean 4.34, monetisation friction 13.07%, reliability 3.41%; 2019–21 n 308, 3.90, 18.83%, 13.31%; 2022–26 n 154, 3.88, 3.90%, 17.53%; reliability by year 0.0% (2016) → 10.0% (2020) → 23.9% (2021) → 21.4% (2023) → 26.1% (2026); the reliability union (74, 11.60%, mean 2.35) now produces 41 of 117 1–2★ (35.0%) against monetisation's 51 (43.6%), almost all historical — there is essentially no live pricing objection left

- **Where:** Executive summary #2 — reliability replaced monetisation as the source of bad reviews (verbatim era table): 2016–18 176 / 4.34 / friction 13.07% / reliability 3.41%; 2019–21 308 / 3.90 / 18.83% / 13.31%; 2022–26 154 / 3.88 / 3.90% / 17.53%; reliability union 74 (11.60%, mean 2.35) = 41 of 117 1–2★ (35.0%) vs monetisation 51 (43.6%) almost all historical — 'in 2026 terms, fixing bugs is the whole job'
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** Era | n | mean ★ | Monetization friction | Reliability ; 2016–2018 | 176 | 4.34 | 23 (13.07%) | 6 (3.41%) ; 2019–2021 | 308 | 3.90 | 58 (18.83%) | 41 (13.31%) ; 2022–2026 | 154 | 3.88 | 6 (3.90%) | 27 (17.53%)
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set; C175 Updates must not break function or wipe progress

### R43-022 — Two different mechanisms took turns: yearly means 2016 4.58 (4.45 without the burst; 53) → 2017 4.32 (78) → 2018 4.07 (45) → 2019 4.16 (86) → 2020 3.78 (130, the volume peak; 1★ 19) → 2021 3.83 (92) → 2022 4.13 (45) → 2023 3.54 (28) → 2024 3.50 (28) → 2025 4.13 (30) → 2026 3.91 (23) — the 2020 trough is the paywall, the 2023–2024 trough is reliability, each followed by recovery

- **Where:** §1.4 Date range and shape (verbatim year table) — first review 7 Oct 2016 'I love it. Super like!!!'; last 16 Aug 2026 'After these changes this app is great again' (edited); 2016 4.58 (4.45 without burst) → 2017 4.32 → 2018 4.07 → 2019 4.16 → 2020 3.78 (130, volume peak) → 2021 3.83 → 2022 4.13 → 2023 3.54 → 2024 3.50 → 2025 4.13 → 2026 3.91; not a monotonic decline — the 2020 trough is the paywall, the 2023–24 trough is reliability
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | % of corpus | Mean ★ | 5★ | 4★ | 3★ | 2★ | 1★ ; 2016 (from 7 Oct) | 53 | 8.3% | 4.58 | 39 | 9 | 3 | 1 | 1 ; 2017 | 78 | 12.2% | 4.32 | 51 | 15 | 4 | 2 | 6 ; 2018 | 45 | 7.1% | 4.07 | 26 | 7 | 6 | 1 | 5 ; 2019 | 86 | 13.5% | 4.16 | 55 | 11 | 7 | 5 | 8 ; 2020 | 130 | 20.4% | 3.78 | 67 | 20 | 9 | 15 | 19 ; 2021 | 92 | 14.4% | 3.83 | 49 | 13 | 9 | 7 | 14 ; 2022 | 45 | 7.1% | 4.13 | 29 | 5 | 4 | 2 | 5 ; 2023 | 28 | 4.4% | 3.54 | 12 | 5 | 3 | 2 | 6 ; 2024 | 28 | 4.4% | 3.50 | 13 | 3 | 3 | 3 | 6 ; 2025 | 30 | 4.7% | 4.13 | 18 | 3 | 6 | 1 | 2 ; 2026 (to 16 Aug) | 23 | 3.6% | 3.91 | 14 | 3 | 0 | 2 | 4
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `1462455628`, `14436400155`
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R43-061 — A 3-item free cap, dated year by year until it was lifted: 2016 4/53 (7.5%) → 2017 9/78 (11.5%) → 2018 6/45 (13.3%) → 2019 11/86 (12.8%) → 2020 18/130 (13.8%) → 2021 13/92 (14.1%, peak) → 2022 3/45 (6.7%) → 2023 1/28 → 2024 0/28 → 2025 1/30 → 2026 0/23; last clearly current complaint Jan 2023 ('Without a paid upgrade only 3 to-dos can be created, therefore useless'); in its era it produced 25 of 76 1★ (32.9%) and 15 of 41 2★ (36.6%) — 'If it's a paid app then say so. You can only add 3 items before you have to upgrade'; 'how can anyone set up a productive day with only 3 available habits?'; 'Don't be a fool like me setting it all up only to be hit with a over priced payment… Phone calendars are just as affective and FREE'; 'they should allow people to list at least 8 - 10 habits for free'; 'I have severe ADHD and wanted this to help keep me on track but I'd rather use a piece of paper for $3 or the reminders app that comes on the iPhone already'

- **Where:** §3.4.1 The free-tier cap by year (verbatim table) — 4/53 (7.5%) 2016 → 9/78 → 6/45 → 11/86 → 18/130 → 13/92 (14.1% peak 2021) → 3/45 → 1/28 → 0/28 → 1/30 → 0/23; last clearly-current complaint Jan 2023 'Ohne kostenpflichtiges Upgrade nur 3 To Dos erstellbar, somit nutzlos'; in its era 25 of 76 1★ (32.9%) and 15 of 41 2★ (36.6%); 'If it's a paid app then say so'; 'how can anyone set up a productive day with only 3 available habits?'; 'Phone calendars are just as affective and FREE'; 'at least 8 - 10 habits for free'; 'I have severe ADHD… I'd rather use a piece of paper for $3 or the reminders app'
- **This app does:** 3-habit cap 2016–~2022
- **User reaction:** 1★-burst
- **Magnitude:** Year | n | free-cap reviews | rate ; 2016 | 53 | 4 | 7.5% ; 2017 | 78 | 9 | 11.5% ; 2018 | 45 | 6 | 13.3% ; 2019 | 86 | 11 | 12.8% ; 2020 | 130 | 18 | 13.8% ; 2021 | 92 | 13 | 14.1% (peak) ; 2022 | 45 | 3 | 6.7% ; 2023 | 28 | 1 | 3.6% ; 2024 | 28 | 0 | 0.0% ; 2025 | 30 | 1 | 3.3% ; 2026 | 23 | 0 | 0.0%
- **Direction for us:** product-rule · **Report confidence:** high-priority (historical) · **Generalisable:** yes
- **Review IDs:** `9546787807`, `12453183273`, `1512313008`, `1550215921`, `2452690617`, `5884162836`, `5497234508`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R43-069 — The 2025 redesign shipped with a regression tail: 'worse after an update' 3 reviews in 2016–18 → 4 in 2019–21 → 9 in 2022–26 (5.84% of that era), eight of them in the ten months Oct 2025 – Jul 2026 — still visible at the end of the corpus

- **Where:** §3.4.3 regression_after_update worsens: 3 (2016–18) → 4 (2019–21) → 9 (2022–26, 5.84% of era); eight of the nine recent in the ten months Oct 2025 – Jul 2026 — the redesign shipped with a regression tail still visible at the end of the corpus
- **This app does:** redesign regressions
- **User reaction:** complaint
- **Magnitude:** 16 (2.51%); 8 in Oct 2025 – Jul 2026
- **Direction for us:** must-never-break · **Report confidence:** meaningful, worsening · **Generalisable:** yes
- **Review IDs:** `13278821225`, `13280430575`, `13418583733`, `13539509871`, `13742967030`, `13912464552`, `13950149136`, `14273363206`, `14291899176`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C175 Updates must not break function or wipe progress

### R43-080 — A 2026 one-star review of this app is a crash, a data loss or an unanswered support e-mail — not a price: of 76 1★, 32 (42.1%) are dated 2016–2021 and carry a monetisation theme, while 1★ from 2022 on are almost entirely reliability; composition — cap 25 (32.9%), deceptive free 13 (17.1%), churn 12, crash 11 (14.5%), price 10, payer 10, data loss 8, buggy 8, support unresponsive 6, regression 6, notification / save bug 5 each

- **Where:** §4.5 One star (verbatim table) — two cleanly separated eras: 32 of 76 (42.1%) dated 2016–2021 carry monetisation; 2022-onward 1★ are almost entirely reliability (crash, data loss, unanswered support); cap 25 (32.9%), deceptive 13, churn 12, crash 11, price 10, payer 10, data loss 8, buggy 8, support unresponsive 6, regression 6
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** Theme | n | % of 1★ ; free_cap_3habits | 25 | 32.9% ; deceptive_free | 13 | 17.1% ; churn_exit | 12 | 15.8% ; crash_wont_open | 11 | 14.5% ; price_objection | 10 | 13.2% ; paid_direct | 10 | 13.2% ; data_loss | 8 | 10.5% ; generic_buggy | 8 | 10.5% ; support_unresponsive | 6 | 7.9% ; regression_after_update | 6 | 7.9% ; notification_bug / save_edit_bug | 5 each | 6.6%
- **Direction for us:** must-never-break · **Report confidence:** segment · **Generalisable:** yes
- **Review IDs:** `8243274829`, `8359132653`, `8807511600`, `9023682666`, `9510714483`, `9546787807`, `9625474815`, `9991247377`, `10019289476`, `10145156296`, `11111402633`, `11285252674`, `11330745828`, `11605150337`, `11762923278`, `13278821225`, `13539509871`, `13721188155`, `13912464552`, `13950149136`, `14407854273`
- **Canonical:** C002 Ratings follow the offer, not the feature set; C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change

### R43-105 — Monetisation friction collapsed: by era 13.07% (23/176) → 18.83% (58/308) → 3.90% (6/154); by halves 15.99% → 11.29% (understated because the split sits inside the paywall era); by year the cap peaked at 14.1% in 2021 and is 0.0% in 2024 and 2026; 'deceptive free' has zero instances after 21 Oct 2021; free-tier praise in 2024–25 uses language incompatible with a 3-item cap

- **Where:** §7.2 Trend 1 — monetisation friction collapsed (verbatim table): eras 13.07% → 18.83% → 3.90%; halves 15.99% → 11.29% (understated, split sits mid-paywall era); years peak 14.1% cap 2021 → 0.0% 2024 and 2026; deceptive_free zero after 21 Oct 2021; praise_free_tier in 2024–25 incompatible with a 3-item cap
- **This app does:** cap lifted
- **User reaction:** praise
- **Magnitude:** Cut | Early | Middle | Late ; Eras | 13.07% (23/176) | 18.83% (58/308) | 3.90% (6/154) ; Halves | 15.99% (51/319) | — | 11.29% (36/319) ; Years | peak 14.1% free-cap in 2021 | — | 0.0% in 2024 and 2026
- **Direction for us:** product-rule · **Report confidence:** improving, high confidence · **Generalisable:** yes
- **Review IDs:** `10869613654`, `11799865019`, `12410220634`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R43-106 — Reliability complaints rose 3.6× and are now the dominant negative: by era 3.41% (6/176) → 13.31% (41/308) → 17.53% (27/154); by halves 5.02% → 18.18%; by year 0.0% (2016) → 23.9% (2021) → 26.1% (2026); the sub-themes that grew across halves — data loss 0.31% → 3.45%, regression after update 1.25% → 3.76%, crash / won't open 1.88% → 4.39%, notification bug 1.25% → 3.45%; the iCloud error did not grow and has no instance after Aug 2022

- **Where:** §7.3 Trend 2 — reliability rose steadily (verbatim table): eras 3.41% → 13.31% → 17.53%; halves 5.02% → 18.18% (3.6×); years 0.0% (2016) → 23.9% (2021) → 26.1% (2026); grew: data_loss 0.31 → 3.45%, regression 1.25 → 3.76%, crash 1.88 → 4.39%, notification_bug 1.25 → 3.45%; sync_icloud_error did not grow, none after Aug 2022
- **This app does:** engineering debt
- **User reaction:** complaint
- **Magnitude:** Cut | Early | Middle | Late ; Eras | 3.41% (6/176) | 13.31% (41/308) | 17.53% (27/154) ; Halves | 5.02% (16/319) | — | 18.18% (58/319) ; Years | 0.0% (2016) | 23.9% (2021) | 26.1% (2026)
- **Direction for us:** must-never-break · **Report confidence:** worsening, high confidence · **Generalisable:** yes
- **Canonical:** C031 Crashes / launch failures; C034 Data must never be lost on update, reinstall or phone change; C039 Reminders fire reliably, once; C175 Updates must not break function or wipe progress

### R43-107 — The product traded one problem for another: monetisation friction by year 2016 7.5% → 15.4 → 15.6 → 15.1 → 23.1% (2020) → 16.3 → 6.7 → 7.1 → 0.0% (2024) → 3.3 → 0.0% (2026); reliability 0.0% → 2.6 → 8.9 → 7.0 → 10.0 → 23.9% (2021, the crossover) → 13.3 → 21.4 → 14.3 → 16.7 → 26.1% (2026, the highest in the corpus, n = 23) — the monetisation fix was real and complete; the engineering debt that replaced it is not being paid down

- **Where:** §7.4 Trend 3 — the two negatives crossed over in 2021–2022 (verbatim year table): monetisation 7.5 → 15.4 → 15.6 → 15.1 → 23.1 (2020) → 16.3 → 6.7 → 7.1 → 0.0 → 3.3 → 0.0%; reliability 0.0 → 2.6 → 8.9 → 7.0 → 10.0 → 23.9 (2021, crossover) → 13.3 → 21.4 → 14.3 → 16.7 → 26.1% — 'the product traded one problem for another; the monetisation fix was real and complete, the engineering debt that replaced it is not being paid down'
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Year | n | Monetization friction | Reliability ; 2016 | 53 | 7.5% | 0.0% ; 2017 | 78 | 15.4% | 2.6% ; 2018 | 45 | 15.6% | 8.9% ; 2019 | 86 | 15.1% | 7.0% ; 2020 | 130 | 23.1% | 10.0% ; 2021 | 92 | 16.3% | 23.9% ← crossover ; 2022 | 45 | 6.7% | 13.3% ; 2023 | 28 | 7.1% | 21.4% ; 2024 | 28 | 0.0% | 14.3% ; 2025 | 30 | 3.3% | 16.7% ; 2026 | 23 | 0.0% | 26.1%
- **Direction for us:** must-never-break · **Report confidence:** structural, high confidence · **Generalisable:** yes
- **Canonical:** C002 Ratings follow the offer, not the feature set

### R43-108 — An unchanged one-time model became a stated reason to choose the app as the category moved to subscription: monetisation praise 7.39% (2016–18) → 16.88% → 15.58% (halves 11.60% → 16.30%); value / cheap praise 3.98% → 11.04% → 10.39% — even as the price rose from $2.99 to $4.99; the praise is about the alternatives getting more expensive

- **Where:** §7.5 Trend 4 — monetisation praise grew into a stable asset: union 7.39% → 16.88% → 15.58% (halves 11.60 → 16.30%); praise_value_cheap 3.98 → 11.04 → 10.39%; the price rose $2.99 → $4.99 — the praise is about alternatives getting more expensive as competitors moved to subscription
- **This app does:** one-time while rivals went subscription
- **User reaction:** praise
- **Magnitude:** 7.39 → 16.88 → 15.58%
- **Direction for us:** build-paid · **Report confidence:** improving, high confidence · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C004 Price low and fair, anchored against subscription competitors

### R43-109 — The ADHD segment arrived without the product changing: ADHD praise 0.00% (2016–18) → 2.92% → 5.84% (2022–26), accessibility 0.00% → 2.27% → 3.25%, every cut agreeing; the first ADHD mention is April 2019 (AU) — tracking the broader rise in adult ADHD diagnosis and ADHD-app marketing

- **Where:** §7.6 Trend 5 — ADHD and accessibility grew from nothing: praise_adhd 0.00 → 2.92 → 5.84%; accessibility 0.00 → 2.27 → 3.25%; first mention Apr 2019 (AU); tracks the rise in adult ADHD diagnosis and ADHD-app marketing — the product did not change, the segment arrived
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 0.00 → 5.84%
- **Direction for us:** do · **Report confidence:** emerging, high confidence in direction · **Generalisable:** yes
- **Review IDs:** `4047899872`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R43-110 — Localisation requests grew (0.00% → 1.30% → 3.90% by era, n = 10) and moved from a generic 'Need more language' (2019) to named languages — Portuguese (2020), then Spanish, Polish and Arabic (2024 on); the listing's current five languages are consistent with Portuguese and Spanish having been answered

- **Where:** §7.7 Trend 6 — localisation requests grew and moved from 'any language' (2019) to named languages (Portuguese 2020; Spanish, Polish, Arabic from 2024): 0.00 → 1.30 → 3.90%; n=10
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 0.00 → 3.90%
- **Direction for us:** build-free · **Report confidence:** worsening, medium · **Generalisable:** yes
- **Review IDs:** `4318358329`
- **Canonical:** C027 Localise early — it unlocks revenue

### R43-111 — A single-developer support operation scales until the intake breaks: support praise is flat (4.55% → 3.25% → 3.90%) while 'no response' rose 0.57% → 0.65% → 2.60% (halves 0.31% → 1.88%), six of seven since 2020 and four since 2023 — consistent with a broken in-app feedback form (four reports) causing messages to be missed entirely

- **Where:** §7.8 Trend 7 — support became bimodal: praise flat (4.55 → 3.25 → 3.90%) while support_unresponsive rose 0.57 → 0.65 → 2.60% (halves 0.31 → 1.88%); six of seven since 2020, four since 2023 — a single-developer operation that scales until volume or a broken intake channel causes messages to be missed
- **This app does:** solo support; broken intake
- **User reaction:** complaint
- **Magnitude:** unresponsive 0.57 → 2.60%
- **Direction for us:** must-have · **Report confidence:** worsening, medium (n=7) · **Generalisable:** yes
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R43-112 — A redesign that delivers long-requested capabilities and ships regressions at the same time nets out unsettled: 9 of the 53 reviews from 2025–26 reference the Oct 2025 redesign — a long-time payer's 1★ over the journal popup; 2★ over popups and a calendar header; 5★ 'The new design is amazing'; 5★ reordering shipped; 4★ 'since the new redesign all habits scheduled for every 2/3 weeks now show up every week'; 1★ freezes and a black screen; 2★ the pause button removed; 1★ three updates then total data loss; 5★ 'After these changes this app is great again' — plus the two German data losses at the moment the UI changed; split 4 positive, 7 negative (n = 11 over ten months); the final review in the corpus is positive

- **Where:** §7.9 Trend 8 — the 2025–2026 redesign is the most concentrated event: 9 of 53 reviews reference it — 1★ journal popup; 2★ popups + calendar header; 5★ 'new design is amazing'; 5★ reordering shipped; 4★ 'all habits scheduled for every 2/3 weeks now show up every week'; 1★ freezes + black screen; 2★ pause button removed; 1★ three updates then total data loss; 5★ 'great again'; plus the two German data losses — split 4 positive, 7 negative; not yet settled; the final review is positive
- **This app does:** redesign Oct 2025
- **User reaction:** mixed
- **Magnitude:** 4 positive / 7 negative of 53
- **Direction for us:** must-never-break · **Report confidence:** active, medium · **Generalisable:** yes
- **Review IDs:** `13278821225`, `13280430575`, `13284708645`, `13415356335`, `13418583733`, `13539509871`, `13742967030`, `13950149136`, `14436400155`, `14273363206`, `14291899176`
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out; C175 Updates must not break function or wipe progress

### R43-114 — What held for ten years: simplicity praise is the top theme every single year (26.70% → 15.58% → 18.18% by era; the mid-era dip is the paywall crowding the corpus); the nag feature is praised in every era and criticised once ('the endless notifications were frustrating for me'); scheduling flexibility requested continuously for nine years (2.84% → 4.87% → 5.84%; Jan 2017 → Jan 2025), the longest-running unaddressed request; onboarding requested Feb 2017 → Aug 2026 and never addressed; no subscription ever appeared in 638 reviews

- **Where:** §7.10 What did not change — simplicity praise permanent (26.70 → 15.58 → 18.18%, top every year); the nag feature praised every era and criticised once ('the endless notifications were frustrating for me'); scheduling flexibility requested nine years (2.84 → 4.87 → 5.84%, Jan 2017 → Jan 2025) — the longest-running unaddressed request; onboarding requested nine years, never addressed; no subscription ever appeared
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** nine to ten years
- **Direction for us:** product-rule · **Report confidence:** persistent · **Generalisable:** yes
- **Review IDs:** `1486308038`, `13284708645`, `4277971819`, `1522226211`, `12187998188`, `1553177362`, `14407854273`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C006 Stay minimal — every addition is opt-in or off by default; C043 Flexible / custom frequency; C258 A 'nag until done' repeating reminder — the one reminder shape reviewers say no other app offers; C259 An in-app help screen — first-run tour, searchable FAQ, per-setting explanations — for any product whose setup is richer than its daily use

## Positioning

### R43-001 — Habit Hub: Routine Tracker (App Store ID 1149192857, 'Daily Todo, Goals & Schedule') by Sabana Patel (bundle atryb.HabitHub) — free download with a single one-time non-consumable unlock, no subscription anywhere in the corpus; listing (11 Sep 2026) One-Time Premium Upgrade $4.99, reviewers name $2.99 (US 2017–22), $3.99 / CA$4, £2.99, €3.99 — a slow one-time price ladder; listing 4.7★ from 8.1K ratings, version 13.24; iPhone, iPad, Mac (M1+), Vision, Watch, TV; English, Japanese, Korean, Portuguese, Spanish; 'ADHD-friendly interface' on the listing

- **Where:** header lines 1-8
- **This app does:** developer Sabana Patel; bundle atryb.HabitHub; extracted 8 Sep 2026; analysed 11 Sep 2026; store rank 43
- **User reaction:** praise
- **Magnitude:** 638 written reviews · 55 storefronts · 7 Oct 2016 → 16 Aug 2026 (9 years 10 months, the longest corpus in the series); mean 4.014; 5:373 / 4:94 / 3:54 / 2:41 / 1:76
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** C003 Lead with a one-time lifetime purchase

### R43-059 — Wins head-to-head on simplicity plus price, and loses only to free defaults: 50 reviews (7.84%, mean 4.88) chose it over many — 'I have checked 22 habit tracker apps in iPhone and this one is my favorite'; 'I downloaded all the habits app from the app store and this one is hands down the best'; 'I tested 5 different habit apps and this one won. It won for its simplicity… I'm amazed to say it was also the cheapest of the 5'; 'I have bought a zillion habit tracking apps and this is my favorite one'; 22 (3.45%) name a competitor — Streaks, Strides, Apple Reminders (4), the phone calendar (2), MyFitnessPal, paper — and the two most common 'I left for' destinations are Apple Reminders and the built-in calendar

- **Where:** §3.3.4 Competitive displacement — 50 (7.84%, mean 4.88): 'checked 22 habit tracker apps'; 'downloaded all the habits app from the app store'; 'looked at over 20 Apps'; 'tested 5… It won for its simplicity… also the cheapest of the 5'; 'bought a zillion habit tracking apps'; 22 (3.45%) name a competitor — Streaks, Strides, Apple Reminders ×4, the phone calendar ×2, MyFitnessPal, paper; the 'I left' destinations are Apple Reminders and the calendar — free defaults, not paid rivals
- **This app does:** cheap + simple
- **User reaction:** praise
- **Magnitude:** 50 (7.84%), 4.88; competitors 22 (3.45%)
- **Direction for us:** none · **Report confidence:** high-priority · **Generalisable:** yes
- **Review IDs:** `3881308378`, `6885418251`, `6580752035`, `10556496349`, `4939227766`, `13690508910`, `7233080227`, `10116531918`, `5184672437`, `5497234508`, `7480223627`, `11347643721`, `2452690617`, `13721188155`, `3359093927`
- **Canonical:** C005 Know which competitors buyers compare against

### R43-094 — Chosen for simplicity, one-time price and the nag feature; abandoned only for free built-ins (Apple Reminders, the phone calendar, paper) when the paywall blocked them, or when reliability broke — no reviewer in 638 leaves for a named paid competitor

- **Where:** §5.7 Competitive position — chosen for simplicity + one-time price + the nag feature; left for built-in free alternatives (Apple Reminders, calendar, paper) when the paywall blocked them and for reliability when it broke; no reviewer in 638 leaves for a named paid competitor
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 50 chose; 22 name alternatives; 0 leave for a paid rival
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** yes
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R43-143 — The self-inflicted mistake with a measured cost: listing a free app whose free tier stopped at three items and a $2.99 unlock — held from 2016 to ~2022 — produced a decade-topping negative theme (66, mean 2.36), 25 of 76 one-star reviews, 16 'bait and switch' / 'scam' accusations (14 of them US), and price objections that were really objections to being stopped; loosening the cap erased all of it within two years

- **Where:** Exec #3 / §3.4.1 / §8.3 — anti-pattern: a 'free' listing with a 3-item cap and a $2.99 unlock, held for six years, was read as bait-and-switch by the highest-spending market
- **This app does:** 3-item cap on a 'free' listing
- **User reaction:** 1★-burst
- **Magnitude:** cap 66 (2.36); deceptive 16 (1.25); 25/76 1★
- **Direction for us:** dont · **Report confidence:** high-priority (historical) · **Generalisable:** yes
- **Review IDs:** `1512313008`, `4196549471`, `6594778942`, `1550215921`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C181 If the app is paid-only, say so in the subtitle and first screenshot

## Things not to do

### R43-062 — A 'free' listing with a 3-item cap reads as false advertising: deceptive_free 16 (2.51%, mean 1.25, the joint-lowest theme) — 'Not a free app. The whole app is an in app purchase'; 'Bait and switch. After 3 they make you pay'; 'So sick of these apps that advertise as free, but nothing works until you pay to upgrade. Totally useless so I deleted it' — 14 of 16 US, zero after October 2021

- **Where:** §3.4.1 deceptive_free 16 (2.51%, mean 1.25, joint-lowest) — 'Not a free app. The whole app is an in app purchase'; 'Bait and switch. After 3 they make you pay'; 'So sick of these apps that advertise as free, but nothing works until you pay'; zero after Oct 2021; 14 of 16 US
- **This app does:** listing 'free', 3-item cap
- **User reaction:** 1★-burst
- **Magnitude:** 16 (2.51%), 1.25; 0 after Oct 2021
- **Direction for us:** dont · **Report confidence:** meaningful (historical) · **Generalisable:** yes
- **Review IDs:** `1586277821`, `4196549471`, `6594778942`
- **Canonical:** C181 If the app is paid-only, say so in the subtitle and first screenshot; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R43-072 — An over-frequent review prompt lowers the rating it is meant to raise: 4 reviews (0.63%, mean 2.75) — 'it seems every time I open this app, it's asking me to rate it in the App Store. Heelllooo? I don't want to be distracted!!!' (3★); 'Paid $3, still kept asking for review. Annoying!' (3★); 'Keeps asking for the review every 2 minutes' (1★, whose entire body is 'Review!'); plus a broken prompt ('Asks to rate but Submit remains greyed out')

- **Where:** §3.4.4 review_prompt_nag 4 (0.63%, mean 2.75) — 'every time I open this app, it's asking me to rate it'; 'Paid $3, still kept asking for review. Annoying!'; 'Keeps asking for the review every 2 minutes' (1★, body 'Review!'); prompt broken 'Submit remains greyed out' — a rating-acquisition mechanism actively lowering the rating
- **This app does:** frequent rating prompt, incl. to payers
- **User reaction:** complaint
- **Magnitude:** 4 (0.63%), 2.75; +1 broken
- **Direction for us:** dont · **Report confidence:** emerging · **Generalisable:** yes
- **Review IDs:** `4841363699`, `6061083581`, `11330745828`, `5282428025`, `10116531918`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R43-120 — Reduce in-app review-prompt frequency and suppress it entirely for users who have already purchased — a rating-acquisition mechanism generating 1★ and 3★ reviews ('Paid $3, still kept asking for review'; 'every 2 minutes')

- **Where:** §8.1 #6
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** review_prompt_nag 4 (2.75) + broken 1
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** yes
- **Review IDs:** `4841363699`, `5282428025`, `6061083581`, `11330745828`, `10116531918`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire

## Things to do

### R43-021 — Cheapest high-value moves in evidence order: enforce iCloud backup and add a visible restore path (12 data-loss reviews; the 2026 German pair lost four years each and churned) → make the journal / skip popup optional in settings (2 reviews, cheapest) → add an in-app help / FAQ screen and first-run tour (20 reviews over nine years; also recovers part of the scheduling theme) → fix the in-app feedback / bug-report channel (4 report it broken; it is the intake for the 7 unresponsive-support reviews) → regression-test notification scheduling on every iOS major (15 notification-bug reviews clustered on OS updates) → add scheduling beyond one month, Nth weekday and 'X times per week' (29) → ship Arabic (3 in 14 months, all 3★) → do not introduce a subscription (89 praise the one-time model, mean 4.70)

- **Where:** Executive summary #15 — the cheapest high-value moves, in evidence order
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as stated
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C003 Lead with a one-time lifetime purchase; C027 Localise early — it unlocks revenue; C036 A support channel that exists, is reachable outside the app, and answers; C039 Reminders fire reliably, once; C043 Flexible / custom frequency; C153 Automatic cloud backup on by default — never manual opt-in; C207 Let users hide surfaces they don't use — tabs, social, recommendations, streaks; C259 An in-app help screen — first-run tour, searchable FAQ, per-setting explanations — for any product whose setup is richer than its daily use

### R43-133 — Experiment: a visual refresh behind a theme switch with the current look as default — dated-UI complaints (16, mostly non-US) vs design praise 34 and simplicity 123; a forced redesign risks the larger constituency; measure adoption and non-US mean

- **Where:** §8.4 E1
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** ui_dated_ugly 16 vs praise_design 34
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C057 Offer a non-pastel / premium design option; C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

### R43-134 — Experiment: an in-app 'what changed' screen shown once after each update with a link to roll back preferences — the redesign negatives are about surprise, not the changes; measure regression-shaped reviews the following quarter

- **Where:** §8.4 E2
- **This app does:** report recommendation
- **User reaction:** none
- **Magnitude:** redesign 4 positive / 7 negative
- **Direction for us:** research · **Report confidence:** report recommendation · **Generalisable:** yes
- **Canonical:** C119 Redesigns must not regress layout — ship a density / text-size option or an opt-out

## Contradictions

### R43-065 — Some would prefer a paid-up-front app to a free download with a wall: 'Just make the app cost 3 dollars from the start instead of wasting everybody's time' (US, 1★) — against the 16 who call the free listing deceptive, the same objection from the other side

- **Where:** §3.4.2 'Just make the app cost 3 dollars from the start instead of wasting everybody's time' — a paid-up-front preference
- **This app does:** free + IAP
- **User reaction:** complaint
- **Magnitude:** n=1
- **Direction for us:** research · **Report confidence:** anecdotal · **Generalisable:** yes
- **Review IDs:** `2275905867`
- **Canonical:** C181 If the app is paid-only, say so in the subtitle and first screenshot

## Data caveats and method

### R43-002 — Method: all 638 records read individually in full in date order in their original languages (English, German, French, Spanish, Portuguese, Italian, Polish, Russian, Vietnamese, Japanese, Korean, Chinese, Turkish, Czech, Croatian, Arabic, Danish), 110 hand-assigned themes across 8 families as an explicit review_id → themes map (Temp/43-review-classification.py) validated programmatically (zero unknown IDs, unassigned, duplicated or out-of-family themes), every cited ID verified; bands <0.1 ignore · 0.1–0.5 weak · 0.5–1 emerging · 1–3 meaningful · 3–5 very strong · >5 high-priority; denominators 638 global, 409 US; 48 records low_info only; reconciliation exact (638 = parsed = unique = 55 country files; manifest 638 / 55 / 4.014 / 5:373 4:94 3:54 2:41 1:76 reproduced); zero duplicates; 67 of 122 queried storefronts returned zero reviews; votes 572 zero, max 17 (a 'Complete life changer' review) — votes did not surface the burst, timestamp clustering did; vote_sum ignored; is_edited on 9, four changing the verdict (2★ → 5★ after a fix; 'EDIT- Upgraded review'; data loss then support contact; 'great again'); body median 139 chars, max 2,235 (keyboard mash); the store aggregate 4.7 (8.1K) sits 0.69 above the 4.014 written mean — the ordinary writing-bias gap, not a hidden problem; free-tier boundary inferred from complaints stopping; no version field; recent years hold 23–30 records each so era buckets are used; 42 of 110 themes have 1–4 reviews and are never promoted; 48 payers (7.52%) self-selected, no conversion rate; external sources — the US listing and public consumer-spend rankings, never mixed into counts

- **Where:** How to read this; Eight warnings #2 #6 #8; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.5 Processing method; §1.6 Limitations; §2.3 External sources
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 638/638; 110 themes / 8 families; 9 edited; 67 zero storefronts
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Review IDs:** `5307496014`, `7010047564`, `3705163026`, `4268975961`, `6506840284`, `6736154930`, `7401092364`, `7910377516`, `14258304700`, `14291899176`, `14436400155`, `1720363940`, `6276587317`
- **Canonical:** — (nuance register)

### R43-003 — A positive, top-heavy corpus: 73.2% of written reviews are 4–5★ (373 5★, 94 4★) and only 117 (18.34%) are 1–2★ — the opposite of the usual shape; findings about what is wrong rest on smaller counts than findings about what is right

- **Where:** Eight warnings #1 — positive and top-heavy: 373 5★ (58.46%), 94 4★ — 73.2% 4–5★; only 117 (18.34%) 1–2★; negative findings rest on smaller counts
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 5★ 373 (58.46%); 4★ 94; 1–2★ 117 (18.34%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R43-005 — Single-market dominance: the US is 409 of 638 (64.11%) and the only storefront over 50; UK 28, Canada 27, Australia 21, India 19 are limited evidence; 82.45% of records are English-primary and 133 non-English records span 46 storefronts — any 'global' statement is mostly about US iPhone users

- **Where:** Eight warnings #4 #5 — only the US clears 50 (409, 64.11%); UK 28, CA 27, AU 21, IN 19 limited; 82.45% English-primary; 133 non-English records across 46 storefronts — 'global' is mostly US iPhone users
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** US 409 (64.11%); GB 28; CA 27; AU 21; IN 19
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R43-006 — Rating vs text contradictions, 5 (0.78%): 5★ 'Unusable since update, crashes immediately after pressing done' (NL); 1★ 'OK' (PH); 1★ opening 'This a great app… I'm very impressed' then an appended update reporting total failure (US); 5★ 'Year change broke the app… My streaks got reset' (DE); 1★ 'best app I can find' (VN) — ~1% noise in rating-only analysis

- **Where:** Eight warnings #7 — five rating/text contradictions (0.78%): 5★ 'Unusable since update, crashes immediately after pressing done'; 1★ 'OK'; 1★ 'This a great app… I'm very impressed' then appended total failure; 5★ 'Year change broke the app… My streaks got reset'; 1★ 'best app I can find'
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5 (0.78%)
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `1666138250`, `5241266296`, `6174597189`, `6825601567`, `7755890511`
- **Canonical:** — (nuance register)

### R43-023 — Feature inventory with representative IDs

- **Where:** §2.1 Feature inventory derived from reviews (verbatim table)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** Capability | Evidence (review IDs) | Notes ; Repeating habit tracking with check-off | 1465068130 1724517458 8813020228 | Core loop ; "Nag me until done" repeating reminders | 1486308038 2510076061 5232097891 6222322942 8921933482 11268226195 | Signature feature; named as unavailable elsewhere ; Multiple reminders/completions per day | 2093791169 2689404914 3359093927 7316654754 14295935121 | Water/meals/reps; hourly nagging; 0/2, 0/4 counters ; Reminder count cap of 20/day | 6065249389 | Named explicitly as a limit ; Time-window scheduling with red/yellow/green state | 1870679717 8251773389 11840965309 13284708645 | The colour-coded timeline is the main screen ; Multi-step timers / timed routines | 3306469965 3849179643 5184672437 6433681812 9195704288 11512950686 | Used for morning routines, workouts, kids, ADHD ; Timer with background music fade + voice prompts | 3705163026 14295935121 | Shipped in response to a review ; Statistics: streaks, %, grades, all-time | 1467490946 3990165913 7010047564 10453106838 13832109970 | Very heavily praised ; Calendar view per habit (green/red days) | 4115322082 7598268036 10869613654 | ; Journal / per-day notes | 3627076218 4115322082 7117527798 7837731858 11840965309 | ; Categories / groups | 6421205464 6794532635 8318478253 11840965309 | ; Home-screen & lock-screen widgets | 5184672437 6025127204 7010047564 7050125745 14377341125 | ; iCloud sync across devices | 3627076218 7225948719 | Also the source of 5 sync-error reports ; Siri / Shortcuts voice commands | 5184672437 5307496014 7837731858 8095877872 | ; Apple Watch | 1998324046 6885418251 | Notifications confirmed by reviewers; 12 reviews asked for fuller support up to Jan 2024 ; Dark theme | 4719659444 | ; One-time tasks alongside habits | 7413771936 11557060713 11840965309 | 11557060713 reports one-time tasks not saving ; Per-habit notification sounds | 1880954809 6235525265 9884046420 | Repeatedly described as too few ; Drag-to-reorder within time windows | 13415356335 13832109970 | Appears only from Nov 2025; 7 earlier reviews asked for it ; Pause a habit | 13742967030 | Reported *removed* by the 2026 update ; No ads, no account required, no data collection | 6885418251 7256207765 7316654754 10453106838 | 7316654754 enumerates all four
- **Direction for us:** none · **Report confidence:** inventory · **Generalisable:** app-specific
- **Review IDs:** `1465068130`, `1724517458`, `8813020228`, `1486308038`, `2093791169`, `2689404914`, `3359093927`, `14295935121`, `6065249389`, `1870679717`, `11840965309`, `3306469965`, `3849179643`, `5184672437`, `6433681812`, `9195704288`, `11512950686`, `1467490946`, `3990165913`, `10453106838`, `13832109970`, `4115322082`, `7598268036`, `3627076218`, `7117527798`, `7837731858`, `6421205464`, `6794532635`, `8318478253`, `6025127204`, `7050125745`, `14377341125`, `7225948719`, `5307496014`, `8095877872`, `4719659444`, `7413771936`, `11557060713`, `1880954809`, `6235525265`, `9884046420`, `13742967030`, `7256207765`
- **Canonical:** — (nuance register)

### R43-033 — Master theme table, denominator 638, with US share and period

- **Where:** §3.1 Master table — all 110 themes (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** # | Theme | Family | Dir | n | % of 638 | Mean ★ | US share | Period | Signal ; 1 | praise_simplicity | praise_core | pos | 123 | 19.28% | 4.86 | 76/123 | 2016–2026 | high-priority ; 2 | free_cap_3habits | monetization_friction | neg | 66 | 10.34% | 2.36 | 50/66 | 2016–2025 | high-priority ; 3 | praise_generic | praise_core | pos | 61 | 9.56% | 4.82 | 35/61 | 2016–2026 | high-priority ; 4 | praise_behaviour_change | praise_core | pos | 61 | 9.56% | 4.95 | 46/61 | 2016–2026 | high-priority ; 5 | low_info | meta | mixed | 59 | 9.25% | 4.59 | 37/59 | 2016–2026 | high-priority ; 6 | praise_value_cheap | monetization_praise | pos | 57 | 8.93% | 4.89 | 33/57 | 2017–2026 | high-priority ; 7 | praise_stats | praise_core | pos | 55 | 8.62% | 4.82 | 35/55 | 2016–2026 | high-priority ; 8 | praise_reminders | praise_core | pos | 54 | 8.46% | 4.76 | 37/54 | 2016–2026 | high-priority ; 9 | praise_best_of_many | praise_core | pos | 50 | 7.84% | 4.88 | 30/50 | 2016–2026 | high-priority ; 10 | paid_direct | meta | mixed | 48 | 7.52% | 3.58 | 25/48 | 2017–2026 | high-priority ; 11 | praise_customization | praise_core | pos | 46 | 7.21% | 4.83 | 33/46 | 2016–2026 | high-priority ; 12 | praise_one_time_price | monetization_praise | pos | 40 | 6.27% | 4.60 | 28/40 | 2016–2024 | high-priority ; 13 | price_objection | monetization_friction | neg | 36 | 5.64% | 2.31 | 26/36 | 2016–2025 | high-priority ; 14 | praise_design | praise_core | pos | 34 | 5.33% | 4.88 | 23/34 | 2016–2026 | high-priority ; 15 | scheduling_flexibility_missing | feature_gap | mixed | 29 | 4.55% | 3.38 | 21/29 | 2017–2025 | very strong ; 16 | praise_support | support | pos | 24 | 3.76% | 4.67 | 16/24 | 2017–2026 | very strong ; 17 | churn_exit | meta | neg | 23 | 3.61% | 1.87 | 16/23 | 2018–2026 | very strong ; 18 | praise_nag | praise_core | pos | 22 | 3.45% | 4.86 | 13/22 | 2016–2025 | very strong ; 19 | competitor_mention | meta | mixed | 22 | 3.45% | 3.68 | 15/22 | 2018–2026 | very strong ; 20 | crash_wont_open | reliability | neg | 20 | 3.13% | 2.15 | 18/20 | 2017–2026 | very strong ; 21 | praise_timer_routines | praise_core | pos | 20 | 3.13% | 4.70 | 15/20 | 2018–2026 | very strong ; 22 | praise_free_tier | monetization_praise | pos | 19 | 2.98% | 4.63 | 9/19 | 2017–2025 | meaningful ; 23 | praise_adhd | praise_core | pos | 18 | 2.82% | 4.61 | 17/18 | 2019–2026 | meaningful ; 24 | feature_request_other | feature_gap | mixed | 17 | 2.66% | 3.71 | 10/17 | 2016–2026 | meaningful ; 25 | praise_scheduling_flexibility | praise_core | pos | 17 | 2.66% | 4.65 | 14/17 | 2018–2026 | meaningful ; 26 | ui_dated_ugly | ux_friction | neg | 16 | 2.51% | 2.94 | 6/16 | 2016–2024 | meaningful ; 27 | deceptive_free | monetization_friction | neg | 16 | 2.51% | 1.25 | 14/16 | 2016–2021 | meaningful ; 28 | notification_improvement_request | feature_gap | mixed | 16 | 2.51% | 3.94 | 12/16 | 2017–2026 | meaningful ; 29 | regression_after_update | reliability | neg | 16 | 2.51% | 2.44 | 10/16 | 2017–2026 | meaningful ; 30 | notification_bug | reliability | neg | 15 | 2.35% | 2.60 | 10/15 | 2019–2026 | meaningful ; 31 | praise_multi_count | praise_core | pos | 14 | 2.19% | 4.71 | 8/14 | 2017–2026 | meaningful ; 32 | learning_curve | ux_friction | neg | 14 | 2.19% | 3.36 | 9/14 | 2019–2025 | meaningful ; 33 | generic_buggy | reliability | neg | 14 | 2.19% | 2.00 | 10/14 | 2020–2025 | meaningful ; 34 | us_2016_burst | meta | mixed | 13 | 2.04% | 5.00 | 13/13 | 2016 | meaningful ; 35 | accessibility_use_case | praise_core | pos | 12 | 1.88% | 4.75 | 12/12 | 2019–2025 | meaningful ; 36 | apple_watch_missing | feature_gap | mixed | 12 | 1.88% | 4.00 | 7/12 | 2019–2024 | meaningful ; 37 | data_loss | reliability | neg | 12 | 1.88% | 2.08 | 7/12 | 2020–2026 | meaningful ; 38 | too_limited | feature_gap | mixed | 11 | 1.72% | 3.00 | 7/11 | 2016–2026 | meaningful ; 39 | localization_missing | feature_gap | mixed | 10 | 1.57% | 3.20 | 0/10 | 2019–2025 | meaningful ; 40 | save_edit_bug | reliability | neg | 10 | 1.57% | 2.30 | 8/10 | 2019–2024 | meaningful ; 41 | onboarding_missing | ux_friction | neg | 9 | 1.41% | 2.78 | 8/9 | 2017–2026 | meaningful ; 42 | ux_confusion | ux_friction | neg | 9 | 1.41% | 3.33 | 6/9 | 2017–2023 | meaningful ; 43 | ui_cluttered | ux_friction | neg | 9 | 1.41% | 3.00 | 3/9 | 2018–2026 | meaningful ; 44 | praise_journal | praise_core | pos | 9 | 1.41% | 4.44 | 7/9 | 2019–2026 | meaningful ; 45 | praise_widget | praise_core | pos | 9 | 1.41% | 4.44 | 5/9 | 2019–2026 | meaningful ; 46 | support_unresponsive | support | neg | 7 | 1.10% | 1.29 | 3/7 | 2018–2024 | meaningful ; 47 | reorder_missing | feature_gap | mixed | 7 | 1.10% | 3.71 | 5/7 | 2018–2026 | meaningful ; 48 | praise_no_ads | monetization_praise | pos | 5 | 0.78% | 4.80 | 2/5 | 2016–2023 | emerging ; 49 | swipe_done_ux | ux_friction | neg | 5 | 0.78% | 3.20 | 4/5 | 2017–2020 | emerging ; 50 | rating_text_contradiction | meta | mixed | 5 | 0.78% | 2.60 | 1/5 | 2017–2021 | emerging ; 51 | sync_icloud_error | reliability | neg | 5 | 0.78% | 1.40 | 4/5 | 2018–2022 | emerging ; 52 | price_confusion | monetization_friction | neg | 5 | 0.78% | 4.20 | 4/5 | 2019–2023 | emerging ; 53 | stats_bug | reliability | neg | 5 | 0.78% | 2.60 | 3/5 | 2019–2026 | emerging ; 54 | praise_siri | praise_core | pos | 5 | 0.78% | 4.40 | 5/5 | 2019–2021 | emerging ; 55 | churn_risk | meta | neg | 5 | 0.78% | 2.60 | 4/5 | 2020–2026 | emerging ; 56 | backfill_missing | feature_gap | mixed | 4 | 0.63% | 3.75 | 4/4 | 2017–2020 | emerging ; 57 | purchase_not_delivered | monetization_friction | neg | 4 | 0.63% | 2.75 | 2/4 | 2017–2020 | emerging ; 58 | no_trial_wanted | monetization_friction | neg | 4 | 0.63% | 2.50 | 4/4 | 2017–2021 | emerging ; 59 | support_channel_broken | support | neg | 4 | 0.63% | 3.25 | 3/4 | 2018–2021 | emerging ; 60 | grouping_missing | feature_gap | mixed | 4 | 0.63% | 4.25 | 4/4 | 2018–2022 | emerging ; 61 | purchase_intent | meta | mixed | 4 | 0.63% | 4.50 | 3/4 | 2019–2025 | emerging ; 62 | review_prompt_nag | ux_friction | neg | 4 | 0.63% | 2.75 | 2/4 | 2019–2024 | emerging ; 63 | widget_issue | reliability | neg | 4 | 0.63% | 3.25 | 2/4 | 2019–2024 | emerging ; 64 | feature_request_colors | feature_gap | mixed | 4 | 0.63% | 4.50 | 0/4 | 2020–2023 | emerging ; 65 | calendar_view_missing | feature_gap | mixed | 4 | 0.63% | 3.50 | 2/4 | 2020–2024 | emerging ; 66 | praise_categories | praise_core | pos | 4 | 0.63% | 4.50 | 3/4 | 2020–2024 | emerging ; 67 | praise_updates | praise_core | pos | 4 | 0.63% | 5.00 | 1/4 | 2021–2026 | emerging ; 68 | mac_desktop_missing | feature_gap | mixed | 3 | 0.47% | 4.67 | 0/3 | 2019–2023 | weak ; 69 | bad_habit_missing | feature_gap | mixed | 3 | 0.47% | 3.67 | 2/3 | 2020–2021 | weak ; 70 | timer_bug | reliability | neg | 3 | 0.47% | 3.67 | 2/3 | 2021–2022 | weak ; 71 | praise_redesign_2025 | praise_core | pos | 3 | 0.47% | 5.00 | 1/3 | 2025–2026 | weak ; 72 | dark_mode_request | feature_gap | mixed | 2 | 0.31% | 4.00 | 1/2 | 2017 | weak ; 73 | apple_watch_praise | praise_core | pos | 2 | 0.31% | 5.00 | 0/2 | 2017–2021 | weak ; 74 | praise_sync | praise_core | pos | 2 | 0.31% | 4.50 | 2/2 | 2019–2021 | weak ; 75 | praise_reliability | praise_core | pos | 2 | 0.31% | 5.00 | 1/2 | 2019–2022 | weak ; 76 | feature_request_themes | feature_gap | mixed | 2 | 0.31% | 4.00 | 0/2 | 2019–2020 | weak ; 77 | refund_request | monetization_friction | neg | 2 | 0.31% | 1.00 | 1/2 | 2020 | weak ; 78 | export_missing | feature_gap | mixed | 2 | 0.31% | 4.50 | 1/2 | 2020–2021 | weak ; 79 | shared_household_missing | feature_gap | mixed | 2 | 0.31% | 3.50 | 2/2 | 2022–2025 | weak ; 80 | ghost_habit | reliability | neg | 2 | 0.31% | 2.00 | 2/2 | 2024–2025 | weak ; 81 | popup_journal_2025 | ux_friction | neg | 2 | 0.31% | 1.50 | 2/2 | 2025 | weak ; 82 | praise_reorder | praise_core | pos | 2 | 0.31% | 5.00 | 1/2 | 2025–2026 | weak ; 83 | repurchase_required | monetization_friction | neg | 1 | 0.16% | 1.00 | 0/1 | 2017 | weak ; 84 | shortcuts_integration_missing | feature_gap | mixed | 1 | 0.16% | 3.00 | 1/1 | 2018 | weak ; 85 | import_missing | feature_gap | mixed | 1 | 0.16% | 4.00 | 1/1 | 2018 | weak ; 86 | lock_missing | feature_gap | mixed | 1 | 0.16% | 4.00 | 0/1 | 2019 | weak ; 87 | progress_granularity_missing | feature_gap | mixed | 1 | 0.16% | 5.00 | 1/1 | 2019 | weak ; 88 | accessibility_voiceover_praise | praise_core | pos | 1 | 0.16% | 5.00 | 1/1 | 2019 | weak ; 89 | notification_annoyance | ux_friction | neg | 1 | 0.16% | 2.00 | 1/1 | 2019 | weak ; 90 | praise_dark_mode | praise_core | pos | 1 | 0.16% | 5.00 | 0/1 | 2019 | weak ; 91 | text_size_accessibility | ux_friction | neg | 1 | 0.16% | 4.00 | 0/1 | 2019 | weak ; 92 | undo_missing | feature_gap | mixed | 1 | 0.16% | 2.00 | 1/1 | 2020 | weak ; 93 | storage_complaint | ux_friction | neg | 1 | 0.16% | 1.00 | 1/1 | 2020 | weak ; 94 | purchase_blocked | monetization_friction | neg | 1 | 0.16% | 4.00 | 1/1 | 2020 | weak ; 95 | restore_purchase_issue | monetization_friction | neg | 1 | 0.16% | 1.00 | 1/1 | 2020 | weak ; 96 | support_canned_response | support | neg | 1 | 0.16% | 1.00 | 1/1 | 2020 | weak ; 97 | use_case_kids | praise_core | pos | 1 | 0.16% | 5.00 | 1/1 | 2020 | weak ; 98 | praise_sound | praise_core | pos | 1 | 0.16% | 5.00 | 0/1 | 2020 | weak ; 99 | refund_denied | monetization_friction | neg | 1 | 0.16% | 1.00 | 0/1 | 2020 | weak ; 100 | social_sharing_missing | feature_gap | mixed | 1 | 0.16% | 5.00 | 0/1 | 2020 | weak ; 101 | praise_privacy | monetization_praise | pos | 1 | 0.16% | 5.00 | 0/1 | 2021 | weak ; 102 | location_reminder_missing | feature_gap | mixed | 1 | 0.16% | 4.00 | 1/1 | 2022 | weak ; 103 | review_prompt_bug | ux_friction | neg | 1 | 0.16% | 5.00 | 0/1 | 2023 | weak ; 104 | health_integration_missing | feature_gap | mixed | 1 | 0.16% | 5.00 | 0/1 | 2024 | weak ; 105 | localization_quality | ux_friction | neg | 1 | 0.16% | 1.00 | 0/1 | 2024 | weak ; 106 | bulk_edit_missing | feature_gap | mixed | 1 | 0.16% | 4.00 | 1/1 | 2024 | weak ; 107 | stats_insufficient | feature_gap | mixed | 1 | 0.16% | 2.00 | 0/1 | 2024 | weak ; 108 | scheduling_bug | reliability | neg | 1 | 0.16% | 4.00 | 0/1 | 2025 | weak ; 109 | pause_missing | feature_gap | mixed | 1 | 0.16% | 2.00 | 0/1 | 2026 | weak ; 110 | local_only_storage | feature_gap | mixed | 1 | 0.16% | 4.00 | 0/1 | 2026 | weak
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R43-034 — Generic praise 61 (9.56%, mean 4.82); low_info 59 (9.25%, 4.59)

- **Where:** §3.1 master table #3 praise_generic
- **This app does:** see §3.1
- **User reaction:** praise
- **Magnitude:** 61 + 59
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R43-054 — Weak themes (n ≤ 3): mac_desktop_missing 3 (4.67); bad_habit_missing 3; timer_bug 3; dark_mode_request 2 (2017); apple_watch_praise 2; praise_sync 2; praise_reliability 2; feature_request_themes 2; refund_request 2 (1.00); export_missing 2; shared_household_missing 2; ghost_habit 2 (2.00); popup_journal_2025 2 (1.50); repurchase_required 1; shortcuts_integration_missing 1; import_missing 1; lock_missing 1; progress_granularity_missing 1; accessibility_voiceover_praise 1; notification_annoyance 1; praise_dark_mode 1; text_size_accessibility 1; undo_missing 1 (2.00); storage_complaint 1 (1.00); purchase_blocked 1; restore_purchase_issue 1; support_canned_response 1; use_case_kids 1; praise_sound 1; refund_denied 1; social_sharing_missing 1; praise_privacy 1; location_reminder_missing 1; review_prompt_bug 1; health_integration_missing 1; localization_quality 1 (1.00); bulk_edit_missing 1; stats_insufficient 1; scheduling_bug 1; pause_missing 1; local_only_storage 1

- **Where:** §3.1 master table #72–#110 weak rows
- **This app does:** see §3.1
- **User reaction:** mixed
- **Magnitude:** ≤3 each
- **Direction for us:** none · **Report confidence:** theme-table signal · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R43-075 — Distribution: 5★ 373 (58.46%) · 4★ 94 (14.73%) · 3★ 54 (8.46%) · 2★ 41 (6.43%) · 1★ 76 (11.91%); top-heavy rather than bimodal; 73.2% 4–5★

- **Where:** Part 4 distribution — 5★ 373 (58.46%) · 4★ 94 (14.73%) · 3★ 54 · 2★ 41 · 1★ 76 (11.91%); top-heavy, not bimodal; the 4★ band is the most informative
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** as stated
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R43-082 — Cross-tab: simplicity 110/11/1/0/1; cap 8/7/11/15/25; behaviour change 58/3/0/0/0; value 52/4/1/0/0; stats 48/4/3/0/0; reminders 44/8/1/1/0; best-of-many 44/6/0/0/0; payer 24/5/4/5/10; customisation 40/4/2/0/0; one-time 29/7/3/1/0; price objection 2/4/7/13/10; design 30/4/0/0/0; scheduling gap 8/6/8/3/4; support 19/3/1/1/0; churn 1/2/2/6/12; nag 20/1/1/0/0; competitor 11/3/1/4/3; crash 3/2/1/3/11 — the cap appears at 5★ eight times ('limited to three habits which might be good in a way as it makes me focus'; 'If you are going to use the app for more than a month it is worth buying'), paying spans the whole range (exposure, not satisfaction), and crashes at 5★ only where support resolved them

- **Where:** §4.6 Theme × rating cross-tabulation (verbatim table, top 20) — free_cap at 5★ eight times ('limited to three habits which might be good in a way as it makes me focus'; 'If you are going to use the app for more than a month it is worth buying'); paid_direct spans the range (24 5★, 10 1★) — paying is an exposure signal, not a satisfaction signal; crash at 5★ only where support resolved it
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Theme | n | 5★ | 4★ | 3★ | 2★ | 1★ | Mean ; praise_simplicity | 123 | 110 | 11 | 1 | 0 | 1 | 4.86 ; free_cap_3habits | 66 | 8 | 7 | 11 | 15 | 25 | 2.36 ; praise_generic | 61 | 53 | 7 | 0 | 0 | 1 | 4.82 ; praise_behaviour_change | 61 | 58 | 3 | 0 | 0 | 0 | 4.95 ; low_info | 59 | 51 | 1 | 2 | 1 | 4 | 4.59 ; praise_value_cheap | 57 | 52 | 4 | 1 | 0 | 0 | 4.89 ; praise_stats | 55 | 48 | 4 | 3 | 0 | 0 | 4.82 ; praise_reminders | 54 | 44 | 8 | 1 | 1 | 0 | 4.76 ; praise_best_of_many | 50 | 44 | 6 | 0 | 0 | 0 | 4.88 ; paid_direct | 48 | 24 | 5 | 4 | 5 | 10 | 3.58 ; praise_customization | 46 | 40 | 4 | 2 | 0 | 0 | 4.83 ; praise_one_time_price | 40 | 29 | 7 | 3 | 1 | 0 | 4.60 ; price_objection | 36 | 2 | 4 | 7 | 13 | 10 | 2.31 ; praise_design | 34 | 30 | 4 | 0 | 0 | 0 | 4.88 ; scheduling_flexibility_missing | 29 | 8 | 6 | 8 | 3 | 4 | 3.38 ; praise_support | 24 | 19 | 3 | 1 | 1 | 0 | 4.67 ; churn_exit | 23 | 1 | 2 | 2 | 6 | 12 | 1.87 ; praise_nag | 22 | 20 | 1 | 1 | 0 | 0 | 4.86 ; competitor_mention | 22 | 11 | 3 | 1 | 4 | 3 | 3.68 ; crash_wont_open | 20 | 3 | 2 | 1 | 3 | 11 | 2.15
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** yes
- **Review IDs:** `1534620561`, `1465107496`, `1626042608`, `8279813275`, `1666138250`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R43-083 — Payers: 48 (7.52%) rate 3.58 vs 4.05 for non-payers — 5★ 50.0% vs 59.2%, 1★ 20.8% vs 11.2% (1.9× as likely); 23 of 48 payers are non-US (47.9% vs a 35.9% baseline) — a 10.04% payer self-report rate among non-US reviewers vs 6.11% US (weak; the difference is 9 records)

- **Where:** §5.1 Who is identifiable as a payer (verbatim table) — 48 (7.52%): payers 3.58 vs non-payers 4.05; 5★ 50.0% vs 59.2%; 1★ 20.8% vs 11.2% (1.9×); 23 of 48 payers non-US (47.9% vs 35.9% baseline) — payer rate 10.04% non-US vs 6.11% US (weak, 9 records)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Metric | Payers (n=48) | Non-payers (n=590) ; Mean rating | 3.58 | 4.05 ; 5★ | 24 (50.0%) | 349 (59.2%) ; 4★ | 5 (10.4%) | 89 (15.1%) ; 3★ | 4 (8.3%) | 50 (8.5%) ; 2★ | 5 (10.4%) | 36 (6.1%) ; 1★ | 10 (20.8%) | 66 (11.2%)
- **Direction for us:** none · **Report confidence:** segment · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R43-099 — English-primary storefronts (US, GB, CA, AU, IN, PH, SG, NZ, IE, ZA, HK, MY, NG) are 526 of 638 (82.45%) at mean 4.011 — the corpus essentially is the English-speaking App Store; inference about non-English markets rests on 112 records across 42 storefronts and is not market research

- **Where:** §6.4 English-primary storefronts — n = 526 (82.45%), mean 4.011, indistinguishable from global; the corpus essentially is the English-speaking App Store; non-English inference rests on 112 records across 42 storefronts
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** 526 (82.45%), 4.011
- **Direction for us:** none · **Report confidence:** eligibility · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R43-104 — Trend method: three cuts over the same 638 records — by calendar year (2023–2026 hold 23–30 each, directional only), by three eras of ≥ 150 records (2016–18 n 176; 2019–21 n 308; 2022–26 n 154) as the primary instrument, and by halves split at the median record (5 Jun 2020, 319 each) as an equal-n control; a trend is named only if it holds in at least two cuts; percentages are within-period rates

- **Where:** §7.1 Method — three cuts: calendar year (2023–26 hold 23–30 each, directional); three eras 2016–18 (176), 2019–21 (308), 2022–26 (154) as the primary instrument; halves split at the median record (5 Jun 2020, 319 each) as an equal-n control; a trend is labelled only if it holds in two of three cuts; within-period rates
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** report gives none
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R43-137 — Research question: When exactly did the free cap change, and to what? The complaint's disappearance dates to 2022–23 and post-2022 claims contradict ('completely free' vs a $4.99 listing IAP) — resolvable from release notes and IAP history

- **Where:** Part 8 #1 (§8.5 research question 1)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R43-138 — Research question: Is the US crash concentration real (18 of 20; 4.40% vs 0.87%)? Device mix, iOS mix, or more diagnostic US reviewers — resolvable only from crash telemetry

- **Where:** Part 8 #2 (§8.5 research question 2)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R43-139 — Research question: What is the actual conversion rate, and did it move when the cap changed? 48 writers say they paid — no conversion claim made

- **Where:** Part 8 #3 (§8.5 research question 3)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)

### R43-140 — Research question: Did the July 2026 German data-loss pair (four days apart, same symptom, same support response) share one root cause? Resolvable from migration logs

- **Where:** Part 8 #4 (§8.5 research question 4)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `14273363206`, `14291899176`
- **Canonical:** C034 Data must never be lost on update, reinstall or phone change

### R43-141 — Research question: Does the ADHD segment convert differently? 25 identify at a 4.64 mean but only 2 are confirmed payers — cannot distinguish 'does not pay' from 'does not mention paying'

- **Where:** Part 8 #5 (§8.5 research question 5)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Review IDs:** `4047899872`, `4384478235`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R43-142 — Research question: Why is the self-reported payer rate higher outside the US (10.04% vs 6.11%)? A 9-record difference, may be noise — resolvable from per-storefront IAP data

- **Where:** Part 8 #6 (§8.5 research question 6)
- **This app does:** unknown
- **User reaction:** none
- **Magnitude:** unanswerable from reviews
- **Direction for us:** research · **Report confidence:** research question · **Generalisable:** yes
- **Canonical:** — (nuance register)
