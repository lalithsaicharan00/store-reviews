# Cards — report 59

Source: `App Store Reports/59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule (REPORT).md`  
110 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 4
- [Must-haves](#must-haves) — 4
- [Must never break](#must-never-break) — 8
- [Features](#features) — 9
- [Monetization](#monetization) — 9
- [Tactics the app used](#tactics-the-app-used) — 4
- [Insights (the why)](#insights-the-why) — 13
- [Audiences](#audiences) — 2
- [Markets and languages](#markets-and-languages) — 23
- [Dated events and trends](#dated-events-and-trends) — 9
- [Positioning](#positioning) — 2
- [Anti-patterns](#anti-patterns) — 4
- [Things not to do](#things-not-to-do) — 3
- [Things to do](#things-to-do) — 2
- [Contradictions](#contradictions) — 3
- [Data caveats and method](#data-caveats-and-method) — 11

## Product rules

### R59-006 — One screen, tasks and habits together — the praise is about ease, not power: U_PRAISE_ANY 11,622 (76.58%, High-priority, 4.86★); U_EASE 4,927 (32.47%, High-priority) — PR_EASY 3,824 (25.20%), PR_SIMPLE 1,704 (11.23%), PR_FAST 125 (0.82%), PR_ONE_SCREEN 82 (0.54%); then design PR_DESIGN 1,457 (9.60%), better-than-others PR_BETTER_THAN 1,307 (8.61%), thanks to the developer PR_DEV 1,244 (8.20%); the differentiator users name is tasks and habits on one screen: PR_ALLINONE 293 (1.93%), PR_HABITS 445 (2.93%) — 'Задачи и привычки в одном приложении - гениально' (tasks and habits in one app — genius; #97, the most-voted review, 156 votes); 'настолько простое и интуитивно понятно что в него хочется постоянно заходить' (so simple and intuitive that you want to keep opening it); 'Я попробовал все основные планировщики на рынке, по сравнению с Tappsk они просто мрак' (tried all the main planners; next to Tappsk they are dire); 'combine tasks + habits in one place makes sense'; 'Гораздо удобней стандартных заметок и напоминаний' (much more convenient than built-in Notes and Reminders)

- **Where:** §0.1; §3.2
- **This app does:** today/tomorrow/later buckets with habits row on top
- **User reaction:** praise
- **Magnitude:** 76.58% praise; 32.47% ease; 1.93% all-in-one
- **Direction for us:** product-rule · **Report confidence:** High-priority signal · **Generalisable:** generalisable
- **Review IDs:** `4091270637`, `7442129872`, `13183233726`, `8730080790`, `3304698631`, `3301701050`, `5997304916`, `6676135932`, `7411252185`, `8220120605`, `9133320729`, `9898646652`, `10934108435`, `12166357406`, `14504520574`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default; C050 One-off to-dos alongside habits; C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R59-029 — No ads, ever, and a free tier genuinely usable for tasks: PR_NO_ADS 127 (0.84%), no ad complaint coded; PR_FREE 493 (3.25%, Very strong, 4.91★) — 'Нет лимита на список дел в бесплатной версии' (no limit on the to-do list in the free version); unlimited tasks free after the 2021 20-task cap was lifted

- **Where:** §2.3; §3.2; §8.10
- **This app does:** no ads; unlimited free tasks
- **User reaction:** praise
- **Magnitude:** no-ads 127; free 493
- **Direction for us:** product-rule · **Report confidence:** Very strong signal · **Generalisable:** generalisable
- **Review IDs:** `13962874852`
- **Canonical:** C061 Goodwill conversion — a generous free tier and 'support the devs'; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R59-032 — Entry costs seconds: 'позволяет тебе записать задачу быстрее чем ты ее забудешь' (lets you write the task down faster than you forget it); 'Задачи добавляются за пол секунды' (tasks are added in half a second); including by voice — holding the add button (PR_VOICE 52, 0.34%; BUG_VOICE 15)

- **Where:** §3.2 why it works
- **This app does:** one-tap add; hold-to-dictate
- **User reaction:** praise
- **Magnitude:** PR_FAST 125; PR_VOICE 52
- **Direction for us:** must-have · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `13255885715`, `11803065014`
- **Canonical:** C264 Log-entry friction is sacred — never add a tap to the logging path; a logging redesign is the highest-risk change in the product

### R59-107 — What the corpus says to keep: the one screen — today / tomorrow / later with habits on top; automatic carry-over as the default but with an opt-out per task; the lifetime unlock and the seasonal discount that sells it; no ads in the free tier and a free tier genuinely usable for tasks; the developer's visible presence — thanked by name, fast Telegram support

- **Where:** §8.10
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** keep list
- **Direction for us:** product-rule · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Canonical:** C003 Lead with a one-time lifetime purchase; C050 One-off to-dos alongside habits; C059 Be visibly responsive; fixes bring reviewers back; C061 Goodwill conversion — a generous free tier and 'support the devs'; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

## Must-haves

### R59-043 — Disclose that the software is paid up front: MON_DISCLOSURE 80 (0.53%, 1.95★), MON_PAYWALL_SURPRISE 64 (0.42%, 1.70★) — 'Пишите сразу, что ПО платное, а не встроенные покупки' (say up front that the software is paid, not in-app purchases, 1★); state the caps on the listing; 44 of the 674 1★ are paywall surprise and 50 disclosure

- **Where:** §3.3; §8.7
- **This app does:** caps not stated on listing
- **User reaction:** 1★-burst
- **Magnitude:** disclosure 80; surprise 64
- **Direction for us:** must-have · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `6782314326`
- **Canonical:** C110 An obvious 'continue free' path on the paywall — the free/paid boundary must be legible; C181 If the app is paid-only, say so in the subtitle and first screenshot; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate

### R59-049 — Confusing on first use: NEG_UI_CONFUSING 152 (1.00%, Meaningful) and NEG_ONBOARDING 78 (0.51%) — reviewers cannot find how to delete a habit, set a reminder on a habit, or see what the productivity score means ('не могу понять как удалить ненужную привычку' — cannot work out how to delete an unwanted habit; 'не очень понятно что значит 115' — not clear what 115 means); NEG_UI_CONFUSING rises to 1.4% of E6

- **Where:** §3.5
- **This app does:** hidden gestures; unexplained score
- **User reaction:** complaint
- **Magnitude:** 152 + 78
- **Direction for us:** must-have · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Review IDs:** `11964877237`, `13622497679`
- **Canonical:** C075 Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in; C142 Surface existing features where users look

### R59-057 — Support (verbatim): Code | Dir | Meaning | n | % of 15,176 | Band | Mean ★ | Dates ; PR_SUPPORT | + | Support responsive | 105 | 0.69% | Emerging signal | 4.83 | 2019-02-12 → 2026-06-28 ; SUP_NONE | - | No reply from developers | 64 | 0.42% | Weak signal | 2.03 | 2019-09-19 → 2026-05-26 ; SUP_CONTACT | - | Contact route broken/missing | 31 | 0.20% | Weak signal | 2.61 | 2019-02-28 → 2026-07-05 ; NEG_DEV_PROMISE | - | Requests/promises not delivered | 88 | 0.58% | Emerging signal | 3.43 | 2019-11-02 → 2026-03-23 ; MON_QUESTION | ~ | Question about premium/billing | 63 | 0.42% | Weak signal | 4.57 | 2019-03-11 → 2025-08-06 — both kinds of report more frequent in E5–E6; praise names fast e-mail and Telegram replies and refunds ('Поддержка решила вопрос очень быстро'; 'j'ai réussi à joindre le support par Télégram qui a été d'une grande aide'; 'поддержка подарила мне подписку навсегда другой аккаунт' — support gifted lifetime on another account); silence reported for e-mail, mostly billing and sync ('пишу на почту уже 2 раза, ответа нет' — e-mailed twice, no reply; 'На почту пишешь не отвечают, в тг пишешь бот' — e-mail unanswered; on Telegram you get a bot); bugs acknowledged but never fixed ('каждый раз обещают направить разработчикам, но проблема остается'); fix: route billing and sync tickets to the channel that answers and acknowledge bug reports with a status

- **Where:** §3.8 table (verbatim); §8.4
- **This app does:** Telegram + e-mail support
- **User reaction:** mixed
- **Magnitude:** PR_SUPPORT 105 vs SUP_NONE 64 + SUP_CONTACT 31
- **Direction for us:** must-have · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `11127123256`, `12675143558`, `13366922113`, `14107533962`, `12401679164`, `13688781045`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C059 Be visibly responsive; fixes bring reviewers back; C215 Support reply time must be shorter than any cancellation deadline it serves

### R59-103 — Immediate fix — make the trial behave like a trial: no charge before day 7; a visible countdown and a one-tap cancel inside the app; a confirmation e-mail with the renewal date (MON_AUTO_CHARGE 229, MON_CANCEL_TROUBLE 73, MON_REFUND 159) — this one theme carries 24% of the 1★ reviews; for the direct-card route, a cancellation that works without the App Store and stops retries after deletion

- **Where:** §8 intro; §8.1
- **This app does:** trial charged early; no in-app cancel
- **User reaction:** 1★-burst
- **Magnitude:** 24% of 1★
- **Direction for us:** must-have · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `5676768910`, `6311375123`, `11390008426`, `14345786054`, `13382307021`
- **Canonical:** C109 A free trial must be a real trial; C112 In-app cancellation; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel; C232 Payment retries are bounded — daily dunning against a declined card reads as fraud to the customer and their bank

## Must never break

### R59-004 — The 7-day trial that charged immediately is the largest single source of 1★ reviews: MON_AUTO_CHARGE 229 (1.51%, Meaningful, mean 1.82★, 2019-06-02 → 2026-07-25) carries 163 of the 674 1★ reviews (24.2% segment rate), co-occurs with MON_TRIAL in 111 and MON_REFUND in 113; stable pattern across five years — the reviewer taps '7 days free', a year's fee (999 ₽ named in 73) is taken at once or on day six, the subscription is hard to find and cancel (MON_CANCEL_TROUBLE 73), and charges continue after deletion; peaked in 2020 (2.9% of E2), never gone (1.2% of E6) — 'при выборе бесплатной недели сразу списали деньги за год' (on choosing the free week they immediately took a year's money); '«7 дней бесплатно», а сами втихую списываете на 6 день' ('7 days free', yet you quietly charge on day 6); 'Списывают деньги, даже если приложение удалено' (they take money even when the app is deleted); 'После отмены подписки приложение каждый раз пытается списать с карты средства' (after cancelling, the app keeps trying to charge the card)

- **Where:** Seven warnings 3; §0.2; §4.2 1★
- **This app does:** 7-day trial converting to annual; charged early per reviewers
- **User reaction:** 1★-burst
- **Magnitude:** 229 (1.51%); 163 of 674 1★ (24.2%)
- **Direction for us:** must-never-break · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Side effects:** whether charges were early, expected or refunded is the reviewer's account
- **Review IDs:** `6311375123`, `5676768910`, `14345786054`, `11390008426`, `4253774614`, `5648423037`, `6064206204`, `6411826355`, `6705910204`, `7273681067`, `8002465664`, `9543755153`, `11728726587`
- **Canonical:** C109 A free trial must be a real trial; C112 In-app cancellation; C152 A promised pre-charge trial reminder must actually arrive — in-app, with amount and date; C163 Visible monthly plan — annual-default trials drive billing disputes

### R59-011 — Off-App-Store billing breaks cancellation: because App Store subscription management no longer shows the app, direct-card subscribers cannot find the subscription and are charged after deletion ('В Айфоне в подписках вас у меня нет' — you are not in my iPhone subscriptions, 1★); fix: a cancellation that works without the App Store and that stops retries after deletion

- **Where:** §0.4; §8.1
- **This app does:** direct-card route without in-app cancel
- **User reaction:** 1★-burst
- **Magnitude:** part of MON_AUTO_CHARGE 229
- **Direction for us:** must-never-break · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13382307021`, `14345786054`
- **Canonical:** C112 In-app cancellation; C210 Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel; C232 Payment retries are bounded — daily dunning against a declined card reads as fraud to the customer and their bank

### R59-013 — Lifetime buyers are the ones asked to pay again: BUG_PURCHASE 45 and MON_PAID_TWICE 28 of the 430 lifetime reviews; 57 lifetime reviews are 1–2★; the 2021-01 update is the largest cluster, the rest spread to 2026 — a year after buying 'forever', the app asks again: 'мной было оплачено пожизненное использование, но приложение висит в подписках с припиской «на год»' (I paid for lifetime, but the app sits in subscriptions marked 'for a year'); 'купил полную версию на всегда за 1500 тыс, сегодня списалось 999 рублей за подписку' (bought forever for 1,500; today 999 roubles were taken for a subscription); 'Покупала версию «Навсегда», спустя год написали, что пора опять оплатить «навсегда» ещё раз' (bought Forever; a year later told to pay forever again); 'Купила навсегда, а получается не навсегда' (bought forever and it turns out not forever)

- **Where:** §0.5; §5.4; §8.2
- **This app does:** lifetime unlock not honoured for some
- **User reaction:** 1★-burst
- **Magnitude:** BUG_PURCHASE 45 + PAID_TWICE 28 of 430 lifetime; 57 at 1–2★
- **Direction for us:** must-never-break · **Report confidence:** Weak–Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `5095024136`, `7466929882`, `12353908918`, `13130899515`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C186 Never revoke what earlier buyers paid for when the model changes

### R59-015 — Four dated regressions cluster within days of releases: BUG_CRASH 215 (1.42%, Meaningful, 2.81★), BUG_UPDATE 103 (0.68%, Emerging, 2.83★) — (1) 2021-10-22→25: 36 crash reports in 2021-10, 33 in four days; iPhone 6/6+/7 on iOS 12–14 cannot open the app after an iOS-15-era update ('на версии ПО 12.5.5, IPhone 6+, перестало заходить в приложение'; 'у меня всё перестало работать на шестом айфоне'); (2) 2023-06→10: completing a recurring task closes the app (BUG_RECURRING 37, 14 in these months); a reviewer isolates the 'show completed tasks' setting and support advised hiding them ('дело в отображении выполненных задач'; 'За три месяца никаких подвижек с этим багом' — no progress in three months); build named 'Tappsk 2.5.397 Build 397 iOS 16.5'; (3) 2023-08→12: the calendar opens on the same month of 2022 (BUG_CALENDAR 51, 23 in these months; 'нужно календарь две минуты листать с апреля 2022'; fixed by December 'P.S. Все исправлено, спасибо'); (4) 2023-10: freezes after one action (BUG_PERF 36, 10 in 2023-10; 'можно ставить только одну галочку, потом не реагирует'); E5 carries the highest crash rate after launch (2.6%); later: widgets blank or stale after updates (BUG_WIDGET 100; 'при переключении дня задачи на виджете не меняются') and launch crashes in 2026-05 (7); the 2026-08 release notes (2.6.2) list exactly iCloud sync, duplicate recurring tasks, the Watch app and widgets; fix: release check on the oldest supported iOS and on the show-completed path, a fast hotfix path, widgets that refresh at day change without opening the app — U_REGRESSION 296 produced most of the 1–3★ outside billing

- **Where:** §0.6; §7.1 E5; §8.3
- **This app does:** regressions shipped in clusters
- **User reaction:** 1★-burst
- **Magnitude:** crash 215; update 103; recurring 37; calendar 51; perf 36; widget 100; E5 crash 2.6%
- **Direction for us:** must-never-break · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Review IDs:** `7941135777`, `7941117734`, `10335459972`, `10351281175`, `10148052052`, `10383577572`, `10652121920`, `10525597408`, `13688781045`, `3825379548`, `6389491813`, `7055953001`, `7944463011`, `8479321365`, `10004087209`, `10311017030`, `10915200942`, `12380569127`, `14341897960`
- **Canonical:** C031 Crashes / launch failures; C040 Widgets must not go blank, stale or disagree with the app; C156 Content and event releases need a crash gate across device generations; C175 Updates must not break function or wipe progress

### R59-045 — Purchase not recognised: BUG_PURCHASE 142 (0.94%, Emerging, 2.81★, 2019-11-06 → 2026-07-24) — 'оплачено 990руб за подписку , но работать в этой программе нельзя пока ещё 1499 руб не заплатите' (990 ₽ paid for the subscription, but you cannot work until you pay another 1,499 ₽, 1★); lifts 8.43× among purchasers; fix: restore the lifetime unlock from any receipt, on any device, on the Mac, after a reinstall, without an annual charge between; never show the lifetime buyer a subscription paywall

- **Where:** §3.4; §8.2
- **This app does:** unlock not applied
- **User reaction:** 1★-burst
- **Magnitude:** 142 (0.94%); 8.43× lift in purchasers
- **Direction for us:** must-never-break · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `8119749092`, `6828852918`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R59-046 — Reminders that do not fire persist in every era: BUG_REMINDER 96 (0.63%, 2.78★, 0.3–0.9% per era) — 'unless you open the app every other day, the reminders you set will stop working'; 'за весь день дай бог словить хотя бы 2 уведомления' (in a whole day you are lucky to catch two notifications); Turkish reviewers report a crash when setting a habit reminder ('app closes when i try to set')

- **Where:** §3.4
- **This app does:** local reminders stop when app not opened
- **User reaction:** complaint
- **Magnitude:** 96 (0.63%)
- **Direction for us:** must-never-break · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `11682385361`, `13564198701`, `11020375846`
- **Canonical:** C039 Reminders fire reliably, once; C258 A 'nag until done' repeating reminder — the one reminder shape reviewers say no other app offers

### R59-047 — Data loss and sync: U_DATA_RISK 104 (0.69%, 3.05★) — BUG_DATA_LOSS 47, BUG_SYNC 61 — 'но все мои задачи пропали' (but all my tasks disappeared); 'На iphone не работает синхронизация' (sync does not work on the iPhone); 'Нигде не указано, что задачу надо обязательно сохранить' (nowhere does it say a task must be saved); a paid user: 'все записи удалились и больше не могу авторизоваться' (all records deleted and I can no longer sign in); BUG_SYNC lifts 5.71× among purchasers

- **Where:** §3.4
- **This app does:** iCloud sync
- **User reaction:** 1★-burst
- **Magnitude:** 104 (0.69%)
- **Direction for us:** must-never-break · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `14114704622`, `10865716992`, `11215422615`, `13260201732`
- **Canonical:** C030 Sync must work — and prove it; C034 Data must never be lost on update, reinstall or phone change

### R59-071 — Refund and churn drivers after purchase: MON_REFUND 159 (1.05%, Meaningful, 1.94★) — an immediate or post-cancellation charge, a second charge on a lifetime buyer, a purchase that did not unlock; among purchasers U_CHURN 27 (2.5%), SUP_NONE 28; refunds reported granted ('Все вернули! Оперативно') and refused ('техподдержка не видит причины возврата' — support sees no reason for a refund; 'I was rejected to refund of 20$ annual subscription')

- **Where:** §5.6
- **This app does:** case-by-case refunds
- **User reaction:** refund
- **Magnitude:** 159 (1.05%)
- **Direction for us:** must-never-break · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Review IDs:** `4861219077`, `6145445742`, `11915504481`
- **Canonical:** C029 Billing must be exactly right; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request

## Features

### R59-016 — Unmet need 1 — a computer: U_PLATFORM_REQ 385 (2.54%, Meaningful) — REQ_DESKTOP 208 (1.37%), REQ_WEB 104 (0.69%), REQ_ANDROID 28 (0.18%); the Mac app shipped 2020-06 and was sold separately (MON_PER_DEVICE 59: 'Она платная для тех кто уже премиум?' — is it paid for those who already have premium?); the request then shifts to Windows and the browser ('Сделайте версию для ПК на WINDOWS 10'; 'нужна веб версия, товарищи') and to the Mac app being left behind ('Там какое то старое приложение,которое давно не обновляется'; 'garder à jour la version Mac qui semble délaissé'); desktop requests fall from 6.0% of E1 to 0.6% of E4 and hold near 1% since; the reason given by several who leave for Things ('пришлось отказаться в пользу things из-за отсутствия поддержки Mac') or TickTick; experiment: a web or Windows client priced into Premium, a read-mostly web view first to test demand

- **Where:** §0.7 #1; §3.7; §8.8
- **This app does:** iPhone, Watch, stale Mac app; no web/Windows
- **User reaction:** request
- **Magnitude:** 385 (2.54%); desktop 208; web 104
- **Direction for us:** feature · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Review IDs:** `6079771386`, `6104445084`, `13904252067`, `11286087766`, `12663645398`, `14007929696`, `3334609644`, `5624959804`, `6227238989`, `6744353449`, `7627449945`, `8595218323`, `9699053533`, `10908865904`, `12292931608`, `14451954398`
- **Canonical:** C005 Know which competitors buyers compare against; C044 Mac / desktop / web app; C251 If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R59-017 — Unmet need 2 — a time, and an order, on the task: U_SCHEDULE_REQ 471 (3.10%, Very strong) — REQ_TIME 186 (1.23%), REQ_SORT 132 (0.87%), REQ_CALENDAR_VIEW 118 (0.78%), REQ_ADVANCE_REMINDER 68 (0.45%); a task has a reminder time but no event time, so lists do not order by the day's timeline ('чтобы задача на 09:00 стояла выше задачи на 11:00' — so the 09:00 task sits above the 11:00 task; 'тк нет в приложении времени - я просто в названиях пишу время' — since the app has no time, I write the time in the titles); REQ_TIME at its era maximum in E6 (1.8%) and 69 of the 4★ reviews; experiment: an optional start time and duration distinct from the reminder, sort the day by it, show it on the widget — hypothesis: converts the most frequent 4★ request to 5★ and removes the write-the-time-in-the-title workaround; guard against bloat (PR_KEEP_SIMPLE 49)

- **Where:** §0.7 #2; §8.5
- **This app does:** reminder time only; no event time or timeline sort
- **User reaction:** request
- **Magnitude:** 471 (3.10%); REQ_TIME 186; 69 of 4★
- **Direction for us:** feature · **Report confidence:** Very strong signal · **Generalisable:** generalisable
- **Side effects:** bloat risk to simplicity praise
- **Review IDs:** `13183233726`, `14087812180`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C276 An optional event time (and duration) on a task or habit, distinct from its reminder, with the day sorted by it and shown on the widget

### R59-018 — Unmet need 3 — yesterday: U_HISTORY_REQ 253 (1.67%, Meaningful) — REQ_BACKFILL 62 (0.41%), REQ_SHOW_DONE 71 (0.47%), REQ_STATS 114 (0.75%), NEG_HISTORY 18 (0.12%), plus NEG_DAY_BOUNDARY 19; unfinished tasks roll to today and cannot be marked done for the day they were done ('если я выполнила задачу в 00:01 и хочу отметить её выполненной за предыдущую дату' — did it at 00:01 and want to mark it done for the previous date; 'Как быть совам' — what about night owls); habits show a week, not a month ('Не нашел полноценную сводную статистику по всем привычкам' — no proper summary statistic across habits); a missed item cannot be marked as missed ('чтобы можно было задачу пометить как НЕ сделанную'); experiment: mark done for a past date, a user-set day boundary, a month view per habit — hypothesis: the diary users value becomes trustworthy

- **Where:** §0.7 #3; §3.5; §8.6
- **This app does:** no back-dating; midnight day boundary; week-only habit view
- **User reaction:** request
- **Magnitude:** 253 (1.67%); backfill 62; stats 114
- **Direction for us:** feature · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Review IDs:** `13036787092`, `5226238815`, `13080691665`, `12086132243`
- **Canonical:** C010 Backfill missed days / edit start date; C012 Week / month / year grid views; C170 Configurable day boundary and hemisphere seasons; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which; C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R59-019 — Attachments are the next tier: U_ATTACH_REQ 223 (1.47%) — REQ_PHOTO 124, REQ_NOTES 106 ('ГДЕ ПРИКРЕПИТЬ ФОТО' — WHERE DO I ATTACH A PHOTO, 4★)

- **Where:** §0.7; §3.6
- **This app does:** no photo attachments
- **User reaction:** request
- **Magnitude:** 223 (1.47%)
- **Direction for us:** feature · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Review IDs:** `3882857828`
- **Canonical:** C208 Photo / media / URL attached to a habit, memo or diary entry

### R59-025 — What the product is: a daily to-do list with a habit tracker on the same screen; four buckets (today, tomorrow, this week, later); unfinished tasks roll forward automatically; colour category, reminder, subtasks, note, recurring; habits as a row of icons at the top ticked daily; a productivity score summarises the day; hidden lists (books, films, shopping); calendar view of a chosen day with Apple Calendar events; voice entry by holding add; a task diary (logbook); widgets; Apple Watch app; Mac app syncing through iCloud; free tier caps habits, recurring tasks and reminders. Capability evidence table (verbatim): Capability | Positive evidence | Friction evidence ; Today / tomorrow / later buckets with auto carry-over | PR_SECTIONS 134, PR_AUTO_CARRY 69, PR_ONE_SCREEN 82, PR_SWIPE 58 | NEG_RECURRING_CARRY 28, NEG_PLAN_AHEAD 32, NEG_DAY_BOUNDARY 19, REQ_INBOX 28, REQ_PIN 7 ; Habits row and score | PR_HABITS 445, PR_SCORE 84, PR_MOTIVATION 251 | REQ_HABIT_OPTIONS 113, REQ_STATS 114, NEG_SCORE 23, BUG_HABITS 34 ; Reminders and notifications | PR_REMINDERS 401 | BUG_REMINDER 96, REQ_ADVANCE_REMINDER 68, REQ_SOUND 10, REQ_NOTIF_ACTIONS 28, NEG_NOTIF_SPAM 29, REQ_SNOOZE 10 ; Recurring tasks | PR_RECURRING 126 | BUG_RECURRING 37, REQ_RECURRENCE 51 ; Task time and ordering | — | REQ_TIME 186, REQ_SORT 132, REQ_DEADLINE 24, REQ_MULTIDAY 12, BUG_REORDER 14 ; Calendar view and Apple Calendar sync | PR_CALENDAR 129 | REQ_CALENDAR_VIEW 118, REQ_CALENDAR_SYNC 56, BUG_CALENDAR 51, REQ_EVENTS 33 ; Subtasks, notes, lists, hidden lists | PR_SUBTASKS 75, PR_LISTS 185, PR_HIDDEN_LISTS 29, PR_TEMPLATES 23 | REQ_NOTES 106, REQ_PHOTO 124, REQ_CHECKLIST 21, REQ_TAGS 24, REQ_PROJECTS 33, REQ_TASK_OPTIONS 156 ; Diary / history | PR_DIARY 42 | REQ_BACKFILL 62, REQ_SHOW_DONE 71, NEG_HISTORY 18, REQ_SEARCH 19 ; Voice entry | PR_VOICE 52 | BUG_VOICE 15 ; Widgets, Watch | PR_WIDGET 167, PR_WATCH 37 | BUG_WIDGET 100, REQ_WIDGET 29, REQ_WATCH 81, REQ_BADGE 5 ; Mac, iCloud sync, other platforms | PR_MAC 92 | BUG_SYNC 61, BUG_IPAD 21, REQ_DESKTOP 208, REQ_WEB 104, REQ_ANDROID 28, REQ_IPAD 11, REQ_SYNC 43, MON_PER_DEVICE 59 ; Design, themes, customisation | PR_DESIGN 1457, PR_CUSTOM 92 | NEG_DESIGN 49, REQ_THEMES 70, REQ_CUSTOMIZE 234, REQ_ICON 20, REQ_FONT 21, REQ_DARK 13 ; Sharing and collaboration | PR_SHARE 5 | REQ_SHARED 65, REQ_FAMILY_SHARE 13, REQ_SHARE 15, REQ_SOCIAL 10 ; Free tier, trial, premium, lifetime | PR_FREE 493, PR_NO_ADS 127, MON_VALUE 465, MON_ONETIME_PRAISE 93, MON_MODEL_OK 40 | MON_FREE_LIMIT 697, MON_FREE_CUT 103, MON_TRIAL 306, MON_AUTO_CHARGE 229, MON_PRICE 252, MON_UPSELL 97, BUG_PURCHASE 142, MON_PAYMENT_METHOD 74 ; Developer and support | PR_DEV 1244, PR_SUPPORT 105, PR_UPDATE 45, PR_RU_DEV 10 | SUP_NONE 64, SUP_CONTACT 31, NEG_DEV_PROMISE 88 ; Languages, onboarding | PR_LANG 18, PR_ARTICLES 49 | REQ_LANG 19, BUG_TRANSLATION 7, NEG_ONBOARDING 78, NEG_UI_CONFUSING 152, REQ_CONTENT 20

- **Where:** §2.1 table (verbatim)
- **This app does:** tasks + habits one screen
- **User reaction:** mixed
- **Magnitude:** capability table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** C050 One-off to-dos alongside habits

### R59-034 — Automatic carry-over without guilt — but with an opt-out per task: PR_AUTO_CARRY 69 (0.45%) — 'all your unfinished today's tasks move to tomorrow'; the same mechanism is a complaint for others: NEG_RECURRING_CARRY 28 (recurring carry-over unwanted), NEG_PLAN_AHEAD 32 (recurring tasks do not show on future dates — 'Открывая календарь задача во вт не отображается'); keep carry-over as the default with a per-task opt-out

- **Where:** §3.2 why it works; §3.5; §8.10
- **This app does:** auto carry-over for all tasks
- **User reaction:** mixed
- **Magnitude:** carry 69 vs recurring-carry 28 + plan-ahead 32
- **Direction for us:** do · **Report confidence:** Weak signal · **Generalisable:** generalisable
- **Review IDs:** `10582924323`, `13245077158`
- **Canonical:** C050 One-off to-dos alongside habits

### R59-035 — Colour categories and the one screen: PR_SECTIONS 134 (0.88%), PR_ONE_SCREEN 82 (0.54%) — 'Die Ansicht „heutige und zukünftige Aufgaben“ ist bei keiner Anderen App so gut und Übersichtlich aufgeteilt' (the today-and-upcoming view is not laid out this well in any other app); PR_SWIPE 58 reschedule by swipe; Germany praises the one-screen layout at 8.92×

- **Where:** §3.2 why it works
- **This app does:** today/tomorrow/week/later sections; swipe to reschedule
- **User reaction:** praise
- **Magnitude:** sections 134; one screen 82; swipe 58
- **Direction for us:** must-have · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `10839438623`
- **Canonical:** C050 One-off to-dos alongside habits; C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R59-052 — The request list (verbatim): Code | Dir | Meaning | n | % of 15,176 | Band | Mean ★ | Dates ; REQ_CUSTOMIZE | ~ | Other settings | 234 | 1.54% | Meaningful signal | 4.50 | 2019-06-26 → 2026-07-10 ; REQ_DESKTOP | ~ | Mac / Windows app | 208 | 1.37% | Meaningful signal | 4.56 | 2019-03-11 → 2026-06-23 ; REQ_TIME | ~ | Task time / duration | 186 | 1.23% | Meaningful signal | 4.30 | 2018-11-13 → 2026-08-08 ; REQ_TASK_OPTIONS | ~ | Other task options | 156 | 1.03% | Meaningful signal | 4.44 | 2019-07-25 → 2026-08-20 ; REQ_SORT | ~ | Sorting / reordering | 132 | 0.87% | Emerging signal | 4.35 | 2019-06-18 → 2026-08-08 ; REQ_PHOTO | ~ | Photos / files | 124 | 0.82% | Emerging signal | 4.53 | 2019-03-15 → 2026-07-30 ; REQ_CALENDAR_VIEW | ~ | Better calendar view | 118 | 0.78% | Emerging signal | 4.36 | 2019-03-13 → 2026-05-27 ; REQ_STATS | ~ | Statistics / history | 114 | 0.75% | Emerging signal | 4.51 | 2019-05-08 → 2026-08-18 ; REQ_HABIT_OPTIONS | ~ | Habit scheduling/count options | 113 | 0.74% | Emerging signal | 4.36 | 2019-06-19 → 2026-08-02 ; REQ_NOTES | ~ | Notes / journal / descriptions | 106 | 0.70% | Emerging signal | 4.64 | 2019-05-22 → 2026-06-23 ; REQ_WEB | ~ | Web version | 104 | 0.69% | Emerging signal | 4.51 | 2019-03-06 → 2026-06-05 ; REQ_VIEWS | ~ | Other list views | 89 | 0.59% | Emerging signal | 4.62 | 2019-03-15 → 2026-01-21 ; REQ_WATCH | ~ | Apple Watch app | 81 | 0.53% | Emerging signal | 4.42 | 2018-10-23 → 2024-11-30 ; REQ_SHOW_DONE | ~ | Keep completed tasks visible | 71 | 0.47% | Weak signal | 4.34 | 2018-10-29 → 2025-08-29 ; REQ_THEMES | ~ | Themes / colours / backgrounds | 70 | 0.46% | Weak signal | 4.64 | 2018-11-08 → 2026-07-05 ; REQ_ADVANCE_REMINDER | ~ | Earlier / multiple reminders | 68 | 0.45% | Weak signal | 4.25 | 2019-03-15 → 2025-08-17 ; REQ_SHARED | ~ | Shared lists / collaboration | 65 | 0.43% | Weak signal | 4.62 | 2019-03-06 → 2026-01-20 ; REQ_BACKFILL | ~ | Edit past days | 62 | 0.41% | Weak signal | 4.03 | 2019-06-10 → 2026-06-30 ; REQ_INTEGRATIONS | ~ | Integrations (Siri, Reminders, Health) | 57 | 0.38% | Weak signal | 4.18 | 2019-03-10 → 2026-07-13 ; REQ_CALENDAR_SYNC | ~ | Calendar sync (iOS/Google) | 56 | 0.37% | Weak signal | 4.23 | 2019-05-16 → 2025-09-18 ; REQ_GOALS | ~ | Goals | 52 | 0.34% | Weak signal | 4.73 | 2019-05-16 → 2026-04-14 ; REQ_RECURRENCE | ~ | More recurrence rules | 51 | 0.34% | Weak signal | 4.59 | 2019-10-05 → 2025-06-03 ; REQ_SYNC | ~ | Sync across devices | 43 | 0.28% | Weak signal | 4.26 | 2019-03-02 → 2026-04-14 ; REQ_TIMER | ~ | Timer / time tracking | 43 | 0.28% | Weak signal | 4.58 | 2020-01-22 → 2025-02-05 ; REQ_SCOPE | ~ | Adjacent domains | 35 | 0.23% | Weak signal | 4.77 | 2020-01-31 → 2025-10-08 ; REQ_PROJECTS | ~ | Projects / hierarchy | 33 | 0.22% | Weak signal | 4.55 | 2019-10-02 → 2025-05-31 ; REQ_EVENTS | ~ | Events / birthdays | 33 | 0.22% | Weak signal | 4.48 | 2019-02-28 → 2024-09-04 ; REQ_GAMIFY | ~ | More gamification | 30 | 0.20% | Weak signal | 4.80 | 2020-01-02 → 2025-11-20 ; REQ_WIDGET | ~ | Widget requested or widget options | 29 | 0.19% | Weak signal | 4.52 | 2020-09-17 → 2021-02-11 ; REQ_ANDROID | ~ | Android version | 28 | 0.18% | Weak signal | 4.71 | 2019-03-06 → 2026-06-13 ; REQ_NOTIF_ACTIONS | ~ | Actions from notifications/lock screen | 28 | 0.18% | Weak signal | 4.29 | 2020-01-10 → 2025-11-14 ; REQ_INBOX | ~ | Inbox / quick capture | 28 | 0.18% | Weak signal | 4.43 | 2020-02-10 → 2025-10-25 ; REQ_TAGS | ~ | Tags | 24 | 0.16% | Weak signal | 3.83 | 2019-04-28 → 2025-02-25 ; REQ_DEADLINE | ~ | Deadlines / overdue | 24 | 0.16% | Weak signal | 4.42 | 2020-02-24 → 2026-06-04 ; REQ_LOCATION | ~ | Location reminders | 22 | 0.14% | Weak signal | 4.27 | 2019-10-31 → 2026-03-04 ; REQ_SUBTASK_REMINDER | ~ | Subtask dates/reminders | 21 | 0.14% | Weak signal | 4.52 | 2019-07-16 → 2025-05-31 ; REQ_FONT | ~ | Font size / bold | 21 | 0.14% | Weak signal | 4.33 | 2019-10-02 → 2026-03-05 ; REQ_CHECKLIST | ~ | Proper lists | 21 | 0.14% | Weak signal | 4.57 | 2019-11-10 → 2024-03-29 ; REQ_QUICK_ACTIONS | ~ | 3D Touch actions | 21 | 0.14% | Weak signal | 4.24 | 2019-02-02 → 2023-07-07 ; REQ_ICON | ~ | App icon options | 20 | 0.13% | Weak signal | 4.85 | 2019-03-17 → 2025-12-28 ; REQ_CONTENT | ~ | More articles | 20 | 0.13% | Weak signal | 4.85 | 2019-12-10 → 2025-12-16 ; REQ_SEARCH | ~ | Search | 19 | 0.13% | Weak signal | 4.26 | 2019-09-29 → 2025-10-17 ; REQ_LANG | ~ | Language | 19 | 0.13% | Weak signal | 4.32 | 2019-04-28 → 2025-02-03 ; REQ_SHARE | ~ | Export/send lists | 15 | 0.10% | Ignore by default | 4.53 | 2018-12-05 → 2025-10-03 ; REQ_FAMILY_SHARE | ~ | Family sharing | 13 | 0.09% | Ignore by default | 4.62 | 2019-07-19 → 2024-05-23 ; REQ_DARK | ~ | Dark mode / auto theme | 13 | 0.09% | Ignore by default | 4.62 | 2019-03-15 → 2021-10-21 ; REQ_PASSCODE | ~ | Passcode / Face ID | 12 | 0.08% | Ignore by default | 4.92 | 2019-11-15 → 2024-06-07 ; REQ_MULTIDAY | ~ | Multi-day tasks | 12 | 0.08% | Ignore by default | 4.00 | 2019-07-29 → 2023-06-04 ; REQ_IPAD | ~ | iPad version | 11 | 0.07% | Ignore by default | 4.64 | 2019-03-14 → 2024-07-13 ; REQ_SNOOZE | ~ | Snooze options | 10 | 0.07% | Ignore by default | 3.90 | 2019-04-21 → 2026-02-12 ; REQ_SOUND | ~ | Notification sound / alarm | 10 | 0.07% | Ignore by default | 3.80 | 2021-07-06 → 2023-06-12 ; REQ_SOCIAL | ~ | Social / competition | 10 | 0.07% | Ignore by default | 4.80 | 2019-12-03 → 2024-07-09; requests under 10: REQ_PIN 7, REQ_HIDE_HABITS 5, REQ_UNDO 5, REQ_BADGE 5, REQ_BACKUP 4, REQ_TIERED_PRICE 4

- **Where:** §3.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** request
- **Magnitude:** request table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-054 — Habit scheduling and recurrence options: REQ_HABIT_OPTIONS 113 (0.74%), REQ_RECURRENCE 51, REQ_CUSTOMIZE 234 (1.54%, the largest request, 80 of the 4★), REQ_TASK_OPTIONS 156, REQ_SHARED 65, REQ_INTEGRATIONS 57, REQ_CALENDAR_SYNC 56, REQ_GOALS 52, REQ_TIMER 43, REQ_WATCH 81, REQ_THEMES 70, REQ_NOTIF_ACTIONS 28, REQ_LOCATION 22, REQ_PASSCODE 12

- **Where:** §3.6
- **This app does:** n/a
- **User reaction:** request
- **Magnitude:** customize 234; habit options 113
- **Direction for us:** feature · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Canonical:** C014 Multiple reminders per habit; C015 Shared / group habits; C017 Passcode lock; C022 Apple Watch app (done properly: timer, two-way sync); C043 Flexible / custom frequency; C045 Grouping / folders / categories / tags; C046 Shortcuts / Siri / URL scheme / API; C066 Focus timer; C080 Colour themes / dark mode; C108 Goals / targets; C252 Complete a habit from the notification — an actionable reminder is part of the one-tap loop

## Monetization

### R59-009 — The free-tier cap is the most frequent objection in every era: MON_FREE_LIMIT 697 (4.59%, Very strong, 3.82★, 2019-01-10 → 2026-07-28); from 2021 the wording is 'only 2 habits / 2 recurring tasks free' ('you only get two habits and two recurring events before you get blocked with a pay wall'; 'Бесплатно только 2 привычки, 2 события' — only 2 habits, 2 events free), before it was '20 tasks'; some accept it ('but that's fair enough'); it leads the 3★ band (80 of 481, 16.63%), is third in 4★ (247, 14.78%) and second in 2★ (37); praise and a price objection share 601 reviews (3.96%) — 'great app, but only two habits free' is the typical 4★ review

- **Where:** §0.3; §2.3; §4.2
- **This app does:** caps habits and recurring tasks at 2 free
- **User reaction:** downgrade
- **Magnitude:** 697 (4.59%); 247 of 4★; 80 of 3★
- **Direction for us:** product-rule · **Report confidence:** Very strong signal · **Generalisable:** generalisable
- **Review IDs:** `11991927304`, `11954179428`, `11685387322`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R59-012 — The lifetime unlock is the monetization asset: MON_PAID 1,090 (7.18%, High-priority, 4.31★) of whom 396 name the lifetime unlock (MON_LIFETIME 430, 2.83%); value judgements positive — MON_VALUE 465 (3.06%, mean 4.93★); the one-time option itself praised 93 times (MON_ONETIME_PRAISE) against only 23 objections to subscription pricing (MON_SUBSCRIPTION) — the reverse of most habit apps; discounts do the selling: MON_DISCOUNT 224 (1.48%), lifetime named at 449–600 ₽ on sale against 1,490–2,500 ₽ list — 'спасибо разработчикам за отсутсвие подписки' (thanks to the developers for not having a subscription); '5€ de por vida que es lo que te cobran las demás al mes' (€5 for life, what the others charge per month)

- **Where:** §0.5; §5.2
- **This app does:** lifetime unlock with frequent discounts
- **User reaction:** purchase-driver
- **Magnitude:** MON_PAID 1,090; lifetime 396; one-time praise 93 vs subscription objection 23
- **Direction for us:** monetization · **Report confidence:** High-priority signal · **Generalisable:** generalisable
- **Review IDs:** `4710971288`, `9146548136`, `4238407684`, `5920658568`, `6485049126`, `6974939853`, `7910145492`, `8731434537`, `10114139002`, `11267081983`, `12572090210`, `14472989926`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R59-027 — Free / paid / trial classification (verbatim): Capability or offer | Classification | Basis ; Tasks, buckets, carry-over, subtasks, notes, lists, calendar view, widgets | Free (unlimited tasks after the 2021 20-task cap was lifted) | listing; PR_FREE 493; "Нет лимита на список дел в бесплатной версии" *(no limit on the to-do list in the free version)* (#14943, 13962874852, ru, 5★) ; Habits beyond 2, recurring tasks beyond 2, reminders beyond a few | Paid — the caps most often named | MON_FREE_LIMIT 697; "Бесплатно только 2 привычки, 2 события" *(only 2 habits, 2 events free)* (#12926, 11685387322, ru, 2★) ; Free tier in 2021-01 → 04 | Cut — 20 tasks (some report 10 or 3), habits removed for some | MON_FREE_CUT 103 (§0.3) ; Trial | 7 days (3 days and a gifted month also reported), converting to an annual charge; charged early or immediately in many accounts | MON_TRIAL 306; MON_AUTO_CHARGE 229 (§0.2) ; Premium price | Subscription monthly (~300 ₽) or annual (999 ₽ named 102 times; $20, €20) and lifetime (list 1,490–2,500 ₽; on sale 449–600 ₽, $14, €4–10) | §9.G; MON_LIFETIME 430; MON_DISCOUNT 224 ; Mac app | Sold separately in 2020–2022; later reviewers describe Mac sync as part of Premium | MON_PER_DEVICE 59 (2020-03-14 → 2025-10-21); PR_MAC 92 ; iCloud sync between devices | Premium | "в бесплатной версии синхронизировать устройства нельзя" *(in the free version you cannot sync devices)* (#14383, 13145009355, ru, 5★); "оставить синхронизацию в бесплатной версии" *(keep sync in the free version)* (#13234, 11891796485, ru, 5★) ; Ads | None | PR_NO_ADS 127; no ad complaint was coded ; Payment route for Russian users after 2022-03 | Direct card / carrier billing outside the App Store, arranged via support and later in-app | MON_PAYMENT_METHOD 74 (§0.4) ; Lifetime unlock honoured across devices, reinstalls and years | Unclear — restored for some, lost or re-billed for others | BUG_PURCHASE 142; MON_PAID_TWICE 47 (§0.5) — could not be established: exact free-tier caps at any date (reviewers name 2, 3, 5, 10, 20 and 50); whether immediate trial charges are App Store behaviour, a bug or design, and whether refunds were granted; the mechanism of direct-card billing and how cancellation works outside the App Store; current prices by region (same lifetime named at 449 ₽ and 2,500 ₽ within a year)

- **Where:** §2.3 table (verbatim); §2.4
- **This app does:** tasks free; habits/recurring beyond 2 paid; iCloud sync Premium; no ads
- **User reaction:** mixed
- **Magnitude:** classification table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `13962874852`, `11685387322`, `13145009355`, `11891796485`
- **Canonical:** C001 Never move a free feature behind the paywall; C013 Cloud sync / multi-device as the paid differentiator; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

### R59-028 — Cross-device iCloud sync is Premium-only and reviewers ask for it free: 'в бесплатной версии синхронизировать устройства нельзя' (in the free version you cannot sync devices); 'оставить синхронизацию в бесплатной версии' (keep sync in the free version)

- **Where:** §2.3
- **This app does:** sync gated behind Premium
- **User reaction:** request
- **Magnitude:** anecdotal
- **Direction for us:** monetization · **Report confidence:** anecdotal · **Generalisable:** generalisable
- **Review IDs:** `13145009355`, `11891796485`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator

### R59-041 — Monetization themes (verbatim): Code | Dir | Meaning | n | % of 15,176 | Band | Mean ★ | Dates ; MON_PAID | ~ | States a purchase | 1090 | 7.18% | High-priority signal | 4.31 | 2019-01-15 → 2026-09-03 ; MON_FREE_LIMIT | - | Free tier too limited | 697 | 4.59% | Very strong signal | 3.82 | 2019-01-10 → 2026-07-28 ; MON_VALUE | + | Worth the money / fair price | 465 | 3.06% | Very strong signal | 4.93 | 2019-03-29 → 2026-08-26 ; MON_LIFETIME | ~ | Bought lifetime | 430 | 2.83% | Meaningful signal | 4.35 | 2019-05-31 → 2026-08-26 ; MON_INTENT | + | Intends to buy | 381 | 2.51% | Meaningful signal | 4.70 | 2019-02-22 → 2026-08-08 ; MON_TRIAL | ~ | Mentions the trial | 306 | 2.02% | Meaningful signal | 3.14 | 2019-01-10 → 2026-07-24 ; MON_PRICE | - | Too expensive | 252 | 1.66% | Meaningful signal | 3.71 | 2019-04-29 → 2026-02-11 ; MON_AUTO_CHARGE | - | Unexpected charge | 229 | 1.51% | Meaningful signal | 1.82 | 2019-06-02 → 2026-07-25 ; MON_DISCOUNT | ~ | Bought or wants a discount/promo | 224 | 1.48% | Meaningful signal | 4.34 | 2019-08-15 → 2026-07-19 ; MON_REFUND | - | Refund requested or given | 159 | 1.05% | Meaningful signal | 1.94 | 2019-06-02 → 2026-03-03 ; MON_FREE_CUT | - | Free tier reduced | 103 | 0.68% | Emerging signal | 2.21 | 2020-01-19 → 2025-10-10 ; MON_UPSELL | - | Aggressive premium prompts | 97 | 0.64% | Emerging signal | 3.33 | 2019-04-29 → 2026-05-21 ; MON_ONETIME_PRAISE | + | Glad a lifetime option exists | 93 | 0.61% | Emerging signal | 4.87 | 2019-09-01 → 2026-06-14 ; MON_NOT_WORTH | - | Not worth the money | 85 | 0.56% | Emerging signal | 1.88 | 2019-04-21 → 2026-04-09 ; MON_DISCLOSURE | - | Unclear or misleading terms | 80 | 0.53% | Emerging signal | 1.95 | 2019-03-13 → 2026-02-12 ; MON_PAYMENT_METHOD | - | Cannot pay (method/region) | 74 | 0.49% | Weak signal | 4.31 | 2020-03-03 → 2026-07-05 ; MON_CANCEL_TROUBLE | - | Cannot cancel | 73 | 0.48% | Weak signal | 1.95 | 2019-10-18 → 2026-07-25 ; MON_WONT_PAY | - | Won't pay | 65 | 0.43% | Weak signal | 3.32 | 2019-05-24 → 2026-07-28 ; MON_PAYWALL_SURPRISE | - | Thought it was free | 64 | 0.42% | Weak signal | 1.70 | 2019-01-10 → 2024-07-13 ; MON_QUESTION | ~ | Question about premium/billing | 63 | 0.42% | Weak signal | 4.57 | 2019-03-11 → 2025-08-06 ; MON_PER_DEVICE | - | Must buy per device / platform | 59 | 0.39% | Weak signal | 4.02 | 2020-03-14 → 2025-10-21 ; MON_PAID_TWICE | - | Charged twice | 47 | 0.31% | Weak signal | 2.85 | 2019-09-29 → 2025-05-19 ; MON_MODEL_OK | + | Payment options fine | 40 | 0.26% | Weak signal | 4.85 | 2019-03-12 → 2026-06-14 ; MON_CANT_AFFORD | ~ | Can't afford premium | 39 | 0.26% | Weak signal | 4.41 | 2019-05-17 → 2026-02-25 ; MON_SUBSCRIPTION | - | Objects to subscription model | 23 | 0.15% | Weak signal | 3.26 | 2020-02-06 → 2025-01-28 ; MON_DONATE_WISH | + | Wants to support/donate | 18 | 0.12% | Weak signal | 4.67 | 2019-04-06 → 2026-03-04 ; MON_WANT_ONETIME | - | Wants a one-time purchase | 12 | 0.08% | Ignore by default | 3.17 | 2019-03-31 → 2025-01-28 ; MON_HONEST | + | Honest billing | 8 | 0.05% | Ignore by default | 5.00 | 2019-09-02 → 2025-04-09

- **Where:** §3.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** monetization code table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-067 — Segment rates among 1,090 purchasers (verbatim): Theme | n in segment | % of segment | % of all 15,176 | Lift ; MON_LIFETIME | 396 | 36.3% | 2.8% | 12.82× ; PR_EASY | 230 | 21.1% | 25.2% | 0.84× ; PR_SIMPLE | 205 | 18.8% | 11.2% | 1.68× ; PR_BETTER_THAN | 179 | 16.4% | 8.6% | 1.91× ; MON_VALUE | 179 | 16.4% | 3.1% | 5.36× ; PR_DEV | 167 | 15.3% | 8.2% | 1.87× ; PR_DESIGN | 145 | 13.3% | 9.6% | 1.39× ; MON_DISCOUNT | 129 | 11.8% | 1.5% | 8.02× ; PR_BEST | 100 | 9.2% | 7.9% | 1.17× ; BUG_PURCHASE | 86 | 7.9% | 0.9% | 8.43× ; TENURE_LONG | 86 | 7.9% | 1.9% | 4.13× ; PR_HABITS | 71 | 6.5% | 2.9% | 2.22× ; PR_RECOMMEND | 67 | 6.1% | 6.2% | 0.99× ; PR_HAS_ALL | 63 | 5.8% | 3.6% | 1.62× ; PR_ALLINONE | 47 | 4.3% | 1.9% | 2.23× ; BUG_CRASH | 42 | 3.9% | 1.4% | 2.72× ; PR_REMINDERS | 42 | 3.9% | 2.6% | 1.46× ; COMP_MENTION | 42 | 3.9% | 1.4% | 2.77× ; JUST_STARTED | 40 | 3.7% | 5.1% | 0.72× ; MON_TRIAL | 39 | 3.6% | 2.0% | 1.77× ; PR_STICKY | 36 | 3.3% | 1.7% | 1.96× ; REQ_CUSTOMIZE | 33 | 3.0% | 1.5% | 1.96× ; PR_RECURRING | 31 | 2.8% | 0.8% | 3.43× ; MON_PAID_TWICE | 30 | 2.8% | 0.3% | 8.89× ; OUT_PRODUCTIVE | 29 | 2.7% | 5.2% | 0.51× ; PR_FREE | 29 | 2.7% | 3.2% | 0.82× ; REQ_TASK_OPTIONS | 28 | 2.6% | 1.0% | 2.50× ; SUP_NONE | 28 | 2.6% | 0.4% | 6.09× ; NEG_DEV_PROMISE | 28 | 2.6% | 0.6% | 4.43× ; PR_CALENDAR | 27 | 2.5% | 0.9% | 2.91× ; REQ_TIME | 27 | 2.5% | 1.2% | 2.02× ; PR_LISTS | 26 | 2.4% | 1.2% | 1.96× ; PR_SUPPORT | 26 | 2.4% | 0.7% | 3.45× ; MON_REFUND | 26 | 2.4% | 1.0% | 2.28× ; BUG_SYNC | 25 | 2.3% | 0.4% | 5.71× ; BUG_REMINDER | 25 | 2.3% | 0.6% | 3.63× ; MON_NOT_WORTH | 25 | 2.3% | 0.6% | 4.09× ; REQ_DESKTOP | 24 | 2.2% | 1.4% | 1.61× ; BUG_WIDGET | 23 | 2.1% | 0.7% | 3.20× ; REQ_WEB | 22 | 2.0% | 0.7% | 2.95× ; REV_UPDATED | 22 | 2.0% | 0.4% | 5.19× ; MON_ONETIME_PRAISE | 21 | 1.9% | 0.6% | 3.14× ; PR_SCORE | 21 | 1.9% | 0.6% | 3.48× ; REQ_CALENDAR_VIEW | 21 | 1.9% | 0.8% | 2.48× ; REQ_NOTES | 20 | 1.8% | 0.7% | 2.63× ; OUT_MEMORY | 20 | 1.8% | 2.1% | 0.85× ; PR_MOTIVATION | 20 | 1.8% | 1.7% | 1.11× ; NEG_UI_CONFUSING | 20 | 1.8% | 1.0% | 1.83× ; NEG_UX | 20 | 1.8% | 0.9% | 1.93× ; PR_WIDGET | 20 | 1.8% | 1.1% | 1.67× ; MON_PER_DEVICE | 20 | 1.8% | 0.4% | 4.72× ; REQ_HABIT_OPTIONS | 19 | 1.7% | 0.7% | 2.34× ; PR_MAC | 19 | 1.7% | 0.6% | 2.88× ; REQ_STATS | 19 | 1.7% | 0.8% | 2.32× ; CONTRA_RATING | 18 | 1.7% | 1.0% | 1.62× ; REQ_WATCH | 18 | 1.7% | 0.5% | 3.09× ; MON_PRICE | 18 | 1.7% | 1.7% | 0.99× ; USE_WORK | 18 | 1.7% | 1.1% | 1.54× ; PR_PERF | 18 | 1.7% | 1.7% | 0.97× ; MON_INTENT | 17 | 1.6% | 2.5% | 0.62× ; REQ_PHOTO | 17 | 1.6% | 0.8% | 1.91× ; MON_UPSELL | 17 | 1.6% | 0.6% | 2.44× ; BUG_UPDATE | 16 | 1.5% | 0.7% | 2.16× ; REQ_VIEWS | 16 | 1.5% | 0.6% | 2.50× ; COMP_SWITCHED_FROM | 16 | 1.5% | 0.7% | 2.03× ; PR_GENERIC | 15 | 1.4% | 20.1% | 0.07× ; PR_SECTIONS | 15 | 1.4% | 0.9% | 1.56× ; OUT_HABIT | 15 | 1.4% | 1.2% | 1.17× ; REV_SOLICITED | 15 | 1.4% | 2.0% | 0.68× — MON_LIFETIME 12.82×, BUG_PURCHASE 8.43×, MON_PAID_TWICE 8.89×, MON_DISCOUNT 8.02×, SUP_NONE 6.09×, BUG_SYNC 5.71×, MON_VALUE 5.36×; PR_GENERIC 0.07×

- **Where:** §5.3 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** lift table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work

### R59-068 — What purchasers report: 892 of 1,090 (81.8%) rate 4–5★; 147 (13.5%) rate 1–2★; satisfied buyers name value, the one-time price and permanence; dissatisfied name a purchase that did not unlock, was charged twice or was cancelled by the app. Table (verbatim): Code | Dir | Meaning | n | % of 15,176 | Band | Mean ★ | Dates ; MON_PAID | ~ | States a purchase | 1090 | 7.18% | High-priority signal | 4.31 | 2019-01-15 → 2026-09-03 ; MON_LIFETIME | ~ | Bought lifetime | 430 | 2.83% | Meaningful signal | 4.35 | 2019-05-31 → 2026-08-26 ; MON_VALUE | + | Worth the money / fair price | 465 | 3.06% | Very strong signal | 4.93 | 2019-03-29 → 2026-08-26 ; MON_ONETIME_PRAISE | + | Glad a lifetime option exists | 93 | 0.61% | Emerging signal | 4.87 | 2019-09-01 → 2026-06-14 ; BUG_PURCHASE | - | Purchase not applied | 142 | 0.94% | Emerging signal | 2.81 | 2019-11-06 → 2026-07-24 ; MON_PAID_TWICE | - | Charged twice | 47 | 0.31% | Weak signal | 2.85 | 2019-09-29 → 2025-05-19 ; MON_REFUND | - | Refund requested or given | 159 | 1.05% | Meaningful signal | 1.94 | 2019-06-02 → 2026-03-03 ; MON_PER_DEVICE | - | Must buy per device / platform | 59 | 0.39% | Weak signal | 4.02 | 2020-03-14 → 2025-10-21 ; MON_NOT_WORTH | - | Not worth the money | 85 | 0.56% | Emerging signal | 1.88 | 2019-04-21 → 2026-04-09 ; MON_SUBSCRIPTION | - | Objects to subscription model | 23 | 0.15% | Weak signal | 3.26 | 2020-02-06 → 2025-01-28 — paid, told to pay again ('не могу добавить более 20-ти задач, говорит, надо оплатить премиум'); paid twice ('Плата за подписку навсегда списалась 2 раза' — lifetime fee charged twice; 'написано, что поддерживается семейный доступ' — it says Family Sharing is supported); paid then lost account or data; paid, expected more ('поторопился и оплатил подписку'; 'Unfortunately I bought premium'); paid and pleased ('уже давно оплатила подписку «навсегда», не жалею' — paid for lifetime long ago, no regrets)

- **Where:** §5.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 81.8% of purchasers 4–5★; 13.5% 1–2★
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `6829914500`, `13130899515`, `6087358548`, `6070071932`, `13260201732`, `13080691665`, `12138681695`, `14060488713`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C037 Family plan; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R59-069 — Upgrade barriers among non-buyers (verbatim): Code | Dir | Meaning | n | % of 15,176 | Band | Mean ★ | Dates ; MON_FREE_LIMIT | - | Free tier too limited | 697 | 4.59% | Very strong signal | 3.82 | 2019-01-10 → 2026-07-28 ; MON_PRICE | - | Too expensive | 252 | 1.66% | Meaningful signal | 3.71 | 2019-04-29 → 2026-02-11 ; MON_TRIAL | ~ | Mentions the trial | 306 | 2.02% | Meaningful signal | 3.14 | 2019-01-10 → 2026-07-24 ; MON_DISCLOSURE | - | Unclear or misleading terms | 80 | 0.53% | Emerging signal | 1.95 | 2019-03-13 → 2026-02-12 ; MON_PAYWALL_SURPRISE | - | Thought it was free | 64 | 0.42% | Weak signal | 1.70 | 2019-01-10 → 2024-07-13 ; MON_WONT_PAY | - | Won't pay | 65 | 0.43% | Weak signal | 3.32 | 2019-05-24 → 2026-07-28 ; MON_CANT_AFFORD | ~ | Can't afford premium | 39 | 0.26% | Weak signal | 4.41 | 2019-05-17 → 2026-02-25 ; MON_UPSELL | - | Aggressive premium prompts | 97 | 0.64% | Emerging signal | 3.33 | 2019-04-29 → 2026-05-21 ; MON_PAYMENT_METHOD | - | Cannot pay (method/region) | 74 | 0.49% | Weak signal | 4.31 | 2020-03-03 → 2026-07-05 ; REQ_TIERED_PRICE | ~ | Buy features separately | 4 | 0.03% | Ignore by default | 3.00 | 2020-01-01 → 2024-12-02 ; MON_WANT_ONETIME | - | Wants a one-time purchase | 12 | 0.08% | Ignore by default | 3.17 | 2019-03-31 → 2025-01-28 ; MON_INTENT | + | Intends to buy | 381 | 2.51% | Meaningful signal | 4.70 | 2019-02-22 → 2026-08-08 — two habits is too few to evaluate ('неинтересно так пробовать' — no fun to try it like this; '2 alışkanlıktan fazlasına premium istiyor' — wants premium for more than 2 habits, the most-voted Turkish review); a trial that needs a card ('полная версия в пробном периоде требует привязки карты'); discount timing and disappearing offers ('Предложение куда-то исчезло и желание купить пропало' — the offer vanished and so did the wish to buy; 'нажимаю на купит, а кнопка не активная' — I press buy and the button is inactive); experiment: raise the free cap to three habits and say so on the listing — reviewers propose three or five as the number that lets them evaluate; hypothesis: fewer 1–3★ 'only two habits' reviews with no measurable loss of lifetime purchases, which are driven by discounts, not the cap

- **Where:** §5.5 table (verbatim); §8.7
- **This app does:** 2-habit free cap; card-required trial
- **User reaction:** downgrade
- **Magnitude:** barrier table; cap drives only 13 purchases
- **Direction for us:** tactic · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `11970511474`, `6163911444`, `12830175248`, `8459345520`, `13303118771`, `11954179428`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C063 Free trial before purchase; C133 Gate on capability, not on quantity; C180 No 'wait, don't go' exit discounts or countdown timers on the paywall; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### R59-070 — Price anchors named by non-buyers: 'Рублей 199-299' (199–299 roubles); 'Люди куда охотнее отдадут 100р в месяц' (people would far more willingly pay 100 ₽ a month, 1★); 'Месячную подписку можно было бы сделать хотя бы 150р, а не 300' (the monthly could be at least 150 ₽, not 300); list prices monthly ~300 ₽, annual 999 ₽ ($20, €20), lifetime 1,490–2,500 ₽ (on sale 449–600 ₽, $14, €4–10); MON_PRICE 252 (1.66%), MON_CANT_AFFORD 39

- **Where:** §5.5
- **This app does:** monthly ~300 ₽; annual 999 ₽
- **User reaction:** downgrade
- **Magnitude:** anecdotal price points
- **Direction for us:** monetization · **Report confidence:** anecdotal · **Generalisable:** app-specific
- **Conditions:** Russian pricing
- **Review IDs:** `11442234591`, `11004360086`, `10898391818`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C092 Regional pricing

## Tactics the app used

### R59-007 — Early acquisition came from the developer's own vc.ru article (MKT_PRESS 13, 0.09%; 'Статья на vc- топ!' — the article on vc — top!); later word of mouth and Russian-language media: MKT_WOM 41, MKT_BLOGGER 19 ('посмотрел видео у Маргулана' — watched a video by Margulan; 'я смотрела тик ток' — I was watching TikTok), MKT_REVIEWS 20, MKT_AD 9

- **Where:** §0.1; §3.7
- **This app does:** founder article; bloggers
- **User reaction:** praise
- **Magnitude:** WOM 41; blogger 19; press 13; ad 9
- **Direction for us:** do · **Report confidence:** Weak signal · **Generalisable:** generalisable
- **Review IDs:** `5433538754`, `9057417749`, `10176992080`
- **Canonical:** C058 Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN); C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal

### R59-036 — The developer's visible presence: PR_DEV 1,244 (8.20%, 4.96★) — reviewers thank them by name; Russian origin noted (PR_RU_DEV 10: 'это еще и русский создатель а не зарубежный' — and it is a Russian creator, not a foreign one); PR_DEV rises to 10.0% of E6; keep the developer visible and Telegram support fast

- **Where:** §3.2 why it works; §8.10
- **This app does:** visible founder; Telegram chat
- **User reaction:** praise
- **Magnitude:** 1,244 (8.20%)
- **Direction for us:** do · **Report confidence:** High-priority signal · **Generalisable:** generalisable
- **Review IDs:** `13820151786`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back; C239 A personal origin story in the listing builds trust — and turns any later gate into a betrayal

### R59-066 — What triggers a purchase (segment rates of 1,090 purchasers): (1) the lifetime offer, usually on sale — MON_LIFETIME 396 (36.3%), MON_DISCOUNT 129 (11.8%) — 'дождался скидку и купил премиум навсегда' (waited for the discount and bought premium forever); 'выскочило предложение взять премиум навсегда с хорошей скидкой, не задумываясь взял' (an offer popped up for forever at a good discount; took it without thinking); (2) the app worked in the first days — JUST_STARTED 40 bought within days ('Поюзал один день и купил навсегда' — used it one day and bought forever; 'Оформила премиум в тот же день, когда скачала'); (3) hitting the habit cap — MON_FREE_LIMIT 13 ('I just wanted to unlock more Habits'; 'чисто из-за большего числа привычек'); (4) better than the rest — PR_BETTER_THAN 179 (16.4%) ('Сразу купила программу навсегда'); (5) supporting the developer — MON_DONATE_WISH 18 ('Купил навсегда чтобы поддержать разработчиков'; 'приобрела подписку, чтобы отблагодарить разработчиков')

- **Where:** §5.2
- **This app does:** time-limited lifetime discount pop-ups
- **User reaction:** purchase-driver
- **Magnitude:** lifetime 36.3%; discount 11.8%; cap only 13
- **Direction for us:** tactic · **Report confidence:** segment rates · **Generalisable:** generalisable
- **Review IDs:** `7900587923`, `11004111636`, `11791791548`, `11585930293`, `12110291519`, `13644589198`, `7229643172`, `12529102869`, `13811965764`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C061 Goodwill conversion — a generous free tier and 'support the devs'; C097 A tip / donate option; C113 One stable, disclosed price — no discount wheels; C147 Let people use the product before they pay

### R59-106 — Experiments, each with a hypothesis: (8.5) an optional event time and duration distinct from the reminder, day sorted by it, shown on the widget — guard against bloat; (8.6) mark done for a past date, user-set day boundary, month view per habit; (8.7) raise the free cap to three habits and state caps on the listing — lifetime purchases are driven by discounts not by the cap; (8.8) a web or Windows client priced into Premium, a read-mostly web view first; (8.9) soften the rating prompt's dismiss wording and suppress it after a purchase, crash or support ticket

- **Where:** §8.5–§8.9
- **This app does:** n/a
- **User reaction:** request
- **Magnitude:** five experiments
- **Direction for us:** tactic · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `13183233726`, `14087812180`, `13036787092`, `5226238815`, `13080691665`, `11954179428`, `11286087766`, `14007929696`, `6709846085`, `5470893305`, `13827246849`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C010 Backfill missed days / edit start date; C012 Week / month / year grid views; C044 Mac / desktop / web app; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C170 Configurable day boundary and hemisphere seasons; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C276 An optional event time (and duration) on a task or habit, distinct from its reminder, with the day sorted by it and shown on the widget

## Insights (the why)

### R59-030 — Prioritised picture (verbatim, denominator 15,176 with E6 count and rate): Rank | Theme | Dir | n | % of 15,176 | Band | Mean ★ | Dates | n in E6 | % of E6 ; 1 | U_PRAISE_ANY Any praise | + | 11622 | 76.58% | High-priority signal | 4.86 | 2018-10-14 → 2026-09-05 | 2031 | 72.6% ; 2 | U_EASE Ease and simplicity | + | 4927 | 32.47% | High-priority signal | 4.89 | 2018-10-14 → 2026-09-03 | 960 | 34.3% ; 3 | U_REQ_ANY Any request | ~ | 2258 | 14.88% | High-priority signal | 4.48 | 2018-10-23 → 2026-08-20 | 439 | 15.7% ; 4 | U_UPGRADE_SIGNAL Purchase, intent or value statement | + | 1785 | 11.76% | High-priority signal | 4.49 | 2019-01-15 → 2026-09-03 | 329 | 11.8% ; 5 | U_OUTCOME Any stated outcome | + | 1463 | 9.64% | High-priority signal | 4.91 | 2018-11-12 → 2026-09-05 | 305 | 10.9% ; 6 | PR_DESIGN Design / interface | + | 1457 | 9.60% | High-priority signal | 4.82 | 2018-10-14 → 2026-09-03 | 263 | 9.4% ; 7 | PR_BETTER_THAN Better than alternatives | + | 1307 | 8.61% | High-priority signal | 4.93 | 2018-10-15 → 2026-09-05 | 216 | 7.7% ; 8 | PR_DEV Thanks the developers | + | 1244 | 8.20% | High-priority signal | 4.96 | 2018-10-15 → 2026-08-27 | 279 | 10.0% ; 9 | U_PRICE_OBJECTION Any price or paywall objection | − | 1169 | 7.70% | High-priority signal | 3.56 | 2019-01-10 → 2026-07-28 | 170 | 6.1% ; 10 | MON_PAID States a purchase | ~ | 1090 | 7.18% | High-priority signal | 4.31 | 2019-01-15 → 2026-09-03 | 220 | 7.9% ; 11 | U_BUG_ANY Any defect | − | 901 | 5.94% | High-priority signal | 3.12 | 2018-10-22 → 2026-07-24 | 170 | 6.1% ; 12 | U_NEG_PRODUCT Any product negative | − | 771 | 5.08% | High-priority signal | 3.58 | 2019-02-25 → 2026-08-02 | 157 | 5.6% ; 13 | MON_FREE_LIMIT Free tier too limited | − | 697 | 4.59% | Very strong signal | 3.82 | 2019-01-10 → 2026-07-28 | 124 | 4.4% ; 14 | U_BILLING Billing and unlock trust | − | 485 | 3.20% | Very strong signal | 2.30 | 2019-05-22 → 2026-07-25 | 78 | 2.8% ; 15 | U_SCHEDULE_REQ Time, order and calendar planning | ~ | 471 | 3.10% | Very strong signal | 4.34 | 2018-11-13 → 2026-08-08 | 89 | 3.2% ; 16 | MON_LIFETIME Bought lifetime | ~ | 430 | 2.83% | Meaningful signal | 4.35 | 2019-05-31 → 2026-08-26 | 96 | 3.4% ; 17 | U_PLATFORM_REQ Another platform or device | ~ | 385 | 2.54% | Meaningful signal | 4.53 | 2018-10-23 → 2026-06-23 | 50 | 1.8% ; 18 | REV_SOLICITED Rating prompt | ~ | 309 | 2.04% | Meaningful signal | 4.77 | 2020-01-01 → 2026-07-19 | 69 | 2.5% ; 19 | MON_TRIAL Mentions the trial | ~ | 306 | 2.02% | Meaningful signal | 3.14 | 2019-01-10 → 2026-07-24 | 38 | 1.4% ; 20 | U_REGRESSION Crash, update breakage or lost feature | − | 296 | 1.95% | Meaningful signal | 2.89 | 2019-02-28 → 2026-07-24 | 57 | 2.0% ; 21 | PR_ALLINONE Tasks + habits + calendar in one app | + | 293 | 1.93% | Meaningful signal | 4.82 | 2019-03-06 → 2026-08-26 | 43 | 1.5% ; 22 | TENURE_LONG Long-term user | + | 290 | 1.91% | Meaningful signal | 4.58 | 2020-01-02 → 2026-09-03 | 121 | 4.3% ; 23 | U_HISTORY_REQ History, back-dating and statistics | ~ | 253 | 1.67% | Meaningful signal | 4.34 | 2018-10-29 → 2026-08-18 | 69 | 2.5% ; 24 | MON_AUTO_CHARGE Unexpected charge | − | 229 | 1.51% | Meaningful signal | 1.82 | 2019-06-02 → 2026-07-25 | 33 | 1.2% ; 25 | U_ATTACH_REQ Notes and attachments | ~ | 223 | 1.47% | Meaningful signal | 4.58 | 2019-03-15 → 2026-07-30 | 39 | 1.4% ; 26 | BUG_CRASH Crashes / won't open | − | 215 | 1.42% | Meaningful signal | 2.81 | 2019-02-28 → 2026-07-24 | 43 | 1.5% ; 27 | U_CHURN Deleted, switched or about to leave | − | 183 | 1.21% | Meaningful signal | 2.39 | 2019-03-12 → 2026-05-20 | 34 | 1.2% ; 28 | U_SUPPORT_NEG Unanswered support or unkept promise | − | 146 | 0.96% | Emerging signal | 2.87 | 2019-09-19 → 2026-05-26 | 49 | 1.8% ; 29 | PR_SUPPORT Support responsive | + | 105 | 0.69% | Emerging signal | 4.83 | 2019-02-12 → 2026-06-28 | 25 | 0.9% ; 30 | U_DATA_RISK Data loss or sync failure | − | 104 | 0.69% | Emerging signal | 3.05 | 2019-03-19 → 2026-06-05 | 22 | 0.8% ; 31 | MON_FREE_CUT Free tier reduced | − | 103 | 0.68% | Emerging signal | 2.21 | 2020-01-19 → 2025-10-10 | 3 | 0.1% ; 32 | U_PAY_ACCESS Cannot pay from the reviewer's country or card | − | 102 | 0.67% | Emerging signal | 4.05 | 2019-05-22 → 2026-07-13 | 28 | 1.0% — praise and a price objection share 601 reviews (3.96%); U_NEG_PRODUCT 771 and U_BUG_ANY 901 together touch 1,556 (10.25%); billing trust (U_BILLING 485, 3.20%, 2.30★) is the largest negative that is neither a price objection nor a product defect

- **Where:** §3.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 32-row ranking
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-031 — What users value (verbatim): Code | Dir | Meaning | n | % of 15,176 | Band | Mean ★ | Dates ; PR_EASY | + | Easy / convenient / intuitive | 3824 | 25.20% | High-priority signal | 4.90 | 2018-10-14 → 2026-09-03 ; PR_GENERIC | + | General praise | 3048 | 20.08% | High-priority signal | 4.86 | 2018-10-14 → 2026-09-03 ; PR_SIMPLE | + | Simple / minimal / nothing extra | 1704 | 11.23% | High-priority signal | 4.88 | 2018-10-14 → 2026-08-22 ; PR_DESIGN | + | Design / interface | 1457 | 9.60% | High-priority signal | 4.82 | 2018-10-14 → 2026-09-03 ; PR_BETTER_THAN | + | Better than alternatives | 1307 | 8.61% | High-priority signal | 4.93 | 2018-10-15 → 2026-09-05 ; PR_DEV | + | Thanks the developers | 1244 | 8.20% | High-priority signal | 4.96 | 2018-10-15 → 2026-08-27 ; PR_BEST | + | Best / favourite | 1192 | 7.85% | High-priority signal | 4.93 | 2018-11-08 → 2026-09-03 ; PR_RECOMMEND | + | Recommends it | 943 | 6.21% | High-priority signal | 4.92 | 2018-11-13 → 2026-09-05 ; PR_HAS_ALL | + | Has the features needed | 542 | 3.57% | Very strong signal | 4.89 | 2018-12-20 → 2026-09-03 ; PR_FREE | + | Free version is enough | 493 | 3.25% | Very strong signal | 4.91 | 2018-11-25 → 2026-08-16 ; PR_HABITS | + | Habit tracker | 445 | 2.93% | Meaningful signal | 4.88 | 2019-04-28 → 2026-08-17 ; PR_REMINDERS | + | Reminders | 401 | 2.64% | Meaningful signal | 4.90 | 2019-10-20 → 2026-06-19 ; PR_ALLINONE | + | Tasks + habits + calendar in one app | 293 | 1.93% | Meaningful signal | 4.82 | 2019-03-06 → 2026-08-26 ; PR_PERF | + | Works reliably | 258 | 1.70% | Meaningful signal | 4.90 | 2018-10-17 → 2026-05-26 ; PR_STICKY | + | Daily use / indispensable | 256 | 1.69% | Meaningful signal | 4.93 | 2018-11-12 → 2026-08-09 ; PR_MOTIVATION | + | Motivating | 251 | 1.65% | Meaningful signal | 4.92 | 2018-10-14 → 2026-08-20 ; PR_LISTS | + | Lists and categories | 185 | 1.22% | Meaningful signal | 4.91 | 2019-04-28 → 2026-08-02 ; PR_WIDGET | + | Widgets | 167 | 1.10% | Meaningful signal | 4.90 | 2019-05-05 → 2026-09-05 ; PR_SECTIONS | + | Today / tomorrow / week / later sections | 134 | 0.88% | Emerging signal | 4.95 | 2019-06-29 → 2026-08-16 ; PR_CALENDAR | + | Calendar view / calendar import | 129 | 0.85% | Emerging signal | 4.90 | 2020-01-10 → 2026-08-16 ; PR_NO_ADS | + | No ads | 127 | 0.84% | Emerging signal | 4.91 | 2018-11-25 → 2026-06-17 ; PR_RECURRING | + | Recurring tasks / routines | 126 | 0.83% | Emerging signal | 4.90 | 2018-10-14 → 2026-09-05 ; PR_FAST | + | Quick to use | 125 | 0.82% | Emerging signal | 4.94 | 2018-11-12 → 2026-08-20 ; PR_SUPPORT | + | Support responsive | 105 | 0.69% | Emerging signal | 4.83 | 2019-02-12 → 2026-06-28 ; PR_CUSTOM | + | Customisable | 92 | 0.61% | Emerging signal | 4.93 | 2019-07-11 → 2026-06-19 ; PR_MAC | + | Mac version | 92 | 0.61% | Emerging signal | 4.60 | 2020-06-15 → 2026-07-16 ; PR_SCORE | + | Productivity score / rating | 84 | 0.55% | Emerging signal | 4.86 | 2019-12-10 → 2026-04-25 ; PR_ONE_SCREEN | + | All tasks on one screen / one place | 82 | 0.54% | Emerging signal | 4.89 | 2018-10-14 → 2026-04-15 ; PR_SUBTASKS | + | Subtasks / checklists | 75 | 0.49% | Weak signal | 4.91 | 2019-05-18 → 2026-08-16 ; PR_AUTO_CARRY | + | Unfinished tasks carry over | 69 | 0.45% | Weak signal | 4.87 | 2019-05-31 → 2026-08-17 ; PR_SWIPE | + | Reschedule by swipe | 58 | 0.38% | Weak signal | 4.88 | 2019-07-20 → 2026-04-25 ; PR_VOICE | + | Voice input | 52 | 0.34% | Weak signal | 4.92 | 2019-05-04 → 2026-08-19 ; PR_PRIORITY | + | Priorities | 50 | 0.33% | Weak signal | 4.94 | 2020-01-02 → 2026-04-14 ; PR_KEEP_SIMPLE | + | Don't change it | 49 | 0.32% | Weak signal | 4.96 | 2020-03-11 → 2026-05-02 ; PR_ARTICLES | + | Productivity articles | 49 | 0.32% | Weak signal | 4.88 | 2019-12-10 → 2026-05-03 ; PR_UPDATE | + | Updates / fixes | 45 | 0.30% | Weak signal | 4.98 | 2019-07-16 → 2026-08-02 ; PR_DIARY | + | Task diary / log | 42 | 0.28% | Weak signal | 4.95 | 2018-10-15 → 2025-06-02 ; PR_WATCH | + | Apple Watch app | 37 | 0.24% | Weak signal | 4.59 | 2020-11-12 → 2026-05-21 ; PR_HIDDEN_LISTS | + | Hidden lists | 29 | 0.19% | Weak signal | 4.97 | 2018-10-16 → 2026-06-28 ; PR_TEMPLATES | + | Ready-made task ideas | 23 | 0.15% | Weak signal | 4.91 | 2020-02-19 → 2023-06-05 ; PR_LANG | + | Localisation | 18 | 0.12% | Weak signal | 4.94 | 2019-05-05 → 2026-02-03 ; PR_RU_DEV | + | Russian developers | 10 | 0.07% | Ignore by default | 4.10 | 2019-04-30 → 2026-03-06 ; PR_SOUND | + | Sounds | 10 | 0.07% | Ignore by default | 4.60 | 2019-05-19 → 2024-06-13 ; PR_SHARE | + | Sharing tasks | 5 | 0.03% | Ignore by default | 4.60 | 2019-06-16 → 2024-12-02 ; PR_BACKFILL | + | Can mark past days | 4 | 0.03% | Ignore by default | 4.50 | 2020-08-17 → 2024-05-02 ; PR_GRACE | + | Non-judgemental | 3 | 0.02% | Ignore by default | 5.00 | 2020-03-29 → 2020-06-09

- **Where:** §3.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** praise code table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-037 — Outcomes and use contexts (verbatim): Code | Dir | Meaning | n | % of 15,176 | Band | Mean ★ | Dates ; OUT_PRODUCTIVE | + | More productive / organised | 796 | 5.25% | High-priority signal | 4.91 | 2018-11-12 → 2026-09-03 ; JUST_STARTED | ~ | Just started | 775 | 5.11% | High-priority signal | 4.82 | 2019-07-29 → 2026-09-02 ; OUT_MEMORY | + | Doesn't forget things | 326 | 2.15% | Meaningful signal | 4.92 | 2019-11-23 → 2026-08-17 ; TENURE_LONG | + | Long-term user | 290 | 1.91% | Meaningful signal | 4.58 | 2020-01-02 → 2026-09-03 ; OUT_HABIT | + | Built habits | 178 | 1.17% | Meaningful signal | 4.90 | 2019-10-20 → 2026-08-20 ; USE_WORK | ~ | Work / business | 163 | 1.07% | Meaningful signal | 4.72 | 2019-02-09 → 2026-08-31 ; OUT_LIFE | + | Life easier / better | 156 | 1.03% | Meaningful signal | 4.98 | 2019-02-09 → 2026-09-05 ; OUT_STRESS | + | Less stress / clear head | 99 | 0.65% | Emerging signal | 4.89 | 2019-02-09 → 2026-09-03 ; USE_STUDY | ~ | Study | 90 | 0.59% | Emerging signal | 4.73 | 2020-01-26 → 2026-08-16 ; USE_HEALTH | ~ | Health (water, pills, sleep) | 85 | 0.56% | Emerging signal | 4.84 | 2019-05-22 → 2026-08-17 ; USE_FAMILY | ~ | Home / family | 43 | 0.28% | Weak signal | 4.81 | 2019-06-16 → 2026-09-05 ; OUT_RESULT | + | Reaches goals | 21 | 0.14% | Weak signal | 4.86 | 2019-08-19 → 2026-04-17 ; USE_FITNESS | ~ | Exercise / diet | 13 | 0.09% | Ignore by default | 4.46 | 2019-10-07 → 2025-03-05 ; OUT_AWARENESS | + | Self-awareness | 7 | 0.05% | Ignore by default | 5.00 | 2020-01-09 → 2024-10-17 ; USE_COACH | ~ | Coach recommends it | 1 | 0.01% | Ignore by default | 5.00 | 2020-01-29 → 2020-01-29

- **Where:** §3.2 outcomes table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** outcome table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-044 — Defects (verbatim): Code | Dir | Meaning | n | % of 15,176 | Band | Mean ★ | Dates ; BUG_CRASH | - | Crashes / won't open | 215 | 1.42% | Meaningful signal | 2.81 | 2019-02-28 → 2026-07-24 ; BUG_PURCHASE | - | Purchase not applied | 142 | 0.94% | Emerging signal | 2.81 | 2019-11-06 → 2026-07-24 ; BUG_UPDATE | - | Broke after an update | 103 | 0.68% | Emerging signal | 2.83 | 2019-02-28 → 2026-07-13 ; BUG_WIDGET | - | Widget broken | 100 | 0.66% | Emerging signal | 3.74 | 2019-06-15 → 2026-07-13 ; BUG_REMINDER | - | Notifications fail | 96 | 0.63% | Emerging signal | 2.78 | 2018-10-22 → 2026-04-23 ; BUG_SYNC | - | iCloud sync fails | 61 | 0.40% | Weak signal | 3.49 | 2019-08-24 → 2026-06-05 ; BUG_OTHER | - | Other defect | 60 | 0.40% | Weak signal | 2.63 | 2019-07-23 → 2026-01-28 ; BUG_CALENDAR | - | Calendar import bugs | 51 | 0.34% | Weak signal | 3.24 | 2020-02-13 → 2025-03-19 ; BUG_DATA_LOSS | - | Data lost | 47 | 0.31% | Weak signal | 2.47 | 2019-03-19 → 2026-05-28 ; BUG_TASKS | - | Task editing bugs | 45 | 0.30% | Weak signal | 3.29 | 2019-10-03 → 2026-06-27 ; BUG_RECURRING | - | Recurring tasks misbehave | 37 | 0.24% | Weak signal | 3.16 | 2019-06-15 → 2026-06-30 ; BUG_PERF | - | Battery / heat | 36 | 0.24% | Weak signal | 3.28 | 2020-01-31 → 2026-05-25 ; BUG_HABITS | - | Habit bugs | 34 | 0.22% | Weak signal | 2.79 | 2019-06-15 → 2026-01-23 ; BUG_PAYMENT | - | Payment fails | 34 | 0.22% | Weak signal | 3.50 | 2019-05-22 → 2026-07-13 ; BUG_OS | - | Broken on new iOS | 29 | 0.19% | Weak signal | 3.38 | 2019-10-08 → 2026-05-22 ; BUG_IPAD | - | iPad problems | 21 | 0.14% | Weak signal | 3.43 | 2019-09-26 → 2026-05-25 ; BUG_DATES | - | Wrong dates/sections | 19 | 0.13% | Weak signal | 3.32 | 2019-08-18 → 2026-04-23 ; BUG_SLOW | - | Slow / lag | 15 | 0.10% | Ignore by default | 3.33 | 2019-03-30 → 2024-04-12 ; BUG_VOICE | - | Voice input fails | 15 | 0.10% | Ignore by default | 3.40 | 2019-04-28 → 2022-07-26 ; BUG_REORDER | - | Order not kept | 14 | 0.09% | Ignore by default | 4.21 | 2019-02-25 → 2025-11-05 ; BUG_GENERIC | - | Some bugs | 13 | 0.09% | Ignore by default | 3.77 | 2019-08-19 → 2023-04-26 ; BUG_TRANSLATION | - | Typos / translation errors | 7 | 0.05% | Ignore by default | 3.29 | 2020-02-05 → 2024-01-28 ; BUG_TIMEZONE | - | Time zone bug | 4 | 0.03% | Ignore by default | 3.25 | 2019-03-30 → 2024-08-01 ; BUG_LISTS | - | List bugs | 2 | 0.01% | Ignore by default | 4.50 | 2018-12-05 → 2024-03-13

- **Where:** §3.4 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** defect code table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-048 — Product negatives (verbatim): Code | Dir | Meaning | n | % of 15,176 | Band | Mean ★ | Dates ; NEG_UI_CONFUSING | - | Can't find existing feature | 152 | 1.00% | Meaningful signal | 4.06 | 2019-05-02 → 2026-06-30 ; NEG_UX | - | Awkward interaction | 144 | 0.95% | Emerging signal | 3.46 | 2019-02-25 → 2026-07-29 ; NEG_LIMITED | - | Too basic / lacks functions | 115 | 0.76% | Emerging signal | 3.39 | 2019-03-15 → 2025-12-28 ; NEG_DEV_PROMISE | - | Requests/promises not delivered | 88 | 0.58% | Emerging signal | 3.43 | 2019-11-02 → 2026-03-23 ; NEG_ONBOARDING | - | Hard to learn | 78 | 0.51% | Emerging signal | 3.27 | 2020-02-05 → 2026-04-15 ; NEG_DESIGN | - | Dislikes design | 49 | 0.32% | Weak signal | 3.90 | 2019-03-12 → 2026-03-05 ; NEG_PLAN_AHEAD | - | Recurring tasks hidden in future | 32 | 0.21% | Weak signal | 3.88 | 2019-03-05 → 2026-05-03 ; NEG_NOTIF_SPAM | - | Too many app notifications | 29 | 0.19% | Weak signal | 3.24 | 2020-03-04 → 2026-04-17 ; NEG_RECURRING_CARRY | - | Recurring carry-over unwanted | 28 | 0.18% | Weak signal | 3.75 | 2019-12-22 → 2026-08-02 ; NEG_GENERIC | - | Dislikes it | 26 | 0.17% | Weak signal | 1.85 | 2020-02-13 → 2025-11-30 ; NEG_SCORE | - | Dislikes productivity rating | 23 | 0.15% | Weak signal | 4.17 | 2019-11-01 → 2026-01-11 ; NEG_DAY_BOUNDARY | - | Midnight cuts the day | 19 | 0.13% | Weak signal | 4.00 | 2019-12-02 → 2025-08-19 ; NEG_HISTORY | - | History clutter | 18 | 0.12% | Weak signal | 3.83 | 2020-01-01 → 2026-03-24 ; NEG_LOST_FEATURE | - | Feature removed | 17 | 0.11% | Weak signal | 3.53 | 2019-09-11 → 2025-08-22 ; NEG_SPAM | - | Spam content | 17 | 0.11% | Weak signal | 2.12 | 2020-01-31 → 2026-05-21 ; NEG_PERMISSION | - | Forced permissions | 7 | 0.05% | Ignore by default | 1.57 | 2020-02-15 → 2023-08-17 ; NEG_BLOAT | - | Too many functions | 5 | 0.03% | Ignore by default | 2.80 | 2020-01-13 → 2025-11-16 ; NEG_ACCESSIBILITY | - | Accessibility | 3 | 0.02% | Ignore by default | 2.67 | 2021-01-19 → 2023-09-24 ; NEG_ADD_ON_LAUNCH | - | Add screen opens on launch | 2 | 0.01% | Ignore by default | 4.50 | 2019-05-30 → 2019-06-29

- **Where:** §3.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** negatives table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-051 — Too plain for some: NEG_DESIGN 49, NEG_LIMITED 115 (0.76%, 3.39★) — the cost of simplicity is a minority who find it too basic; NEG_BLOAT only 5

- **Where:** §3.5
- **This app does:** minimal feature set
- **User reaction:** complaint
- **Magnitude:** limited 115; design 49
- **Direction for us:** none · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `13057793501`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R59-058 — Rating distribution (verbatim): ★ | Reviews | % of 15,176 | In E6 | % of E6 | Mean body length (chars) ; 5 | 12,122 | 79.88% | 2270 | 81.16% | 110 ; 4 | 1,671 | 11.01% | 269 | 9.62% | 168 ; 3 | 481 | 3.17% | 86 | 3.07% | 200 ; 2 | 228 | 1.50% | 53 | 1.89% | 226 ; 1 | 674 | 4.44% | 119 | 4.25% | 176 ; mean | 4.60 |  | 4.62 |  | — 3★ and 2★ reviews are the longest: they argue a case, usually the free tier or a purchase problem

- **Where:** §4.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★ 79.88%; 1★ 4.44%
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-059 — 5★ themes (verbatim): Code | Meaning | n | % of 5★ reviews | Segment band | % of all 15,176 ; PR_EASY | Easy / convenient / intuitive | 3527 | 29.10% | High-priority signal | 25.20% ; PR_GENERIC | General praise | 2678 | 22.09% | High-priority signal | 20.08% ; PR_SIMPLE | Simple / minimal / nothing extra | 1539 | 12.70% | High-priority signal | 11.23% ; PR_DESIGN | Design / interface | 1277 | 10.53% | High-priority signal | 9.60% ; PR_BETTER_THAN | Better than alternatives | 1227 | 10.12% | High-priority signal | 8.61% ; PR_DEV | Thanks the developers | 1204 | 9.93% | High-priority signal | 8.20% ; PR_BEST | Best / favourite | 1134 | 9.35% | High-priority signal | 7.85% ; PR_RECOMMEND | Recommends it | 884 | 7.29% | High-priority signal | 6.21% ; MON_PAID | States a purchase | 785 | 6.48% | High-priority signal | 7.18% ; OUT_PRODUCTIVE | More productive / organised | 733 | 6.05% | High-priority signal | 5.25% ; JUST_STARTED | Just started | 657 | 5.42% | High-priority signal | 5.11% ; PR_HAS_ALL | Has the features needed | 497 | 4.10% | Very strong signal | 3.57% — 5★ reviews are ease, design and thanks

- **Where:** §4.2 5★ table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 5★ top codes
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-060 — 4★ themes (verbatim): Code | Meaning | n | % of 4★ reviews | Segment band | % of all 15,176 ; PR_GENERIC | General praise | 320 | 19.15% | High-priority signal | 20.08% ; PR_EASY | Easy / convenient / intuitive | 254 | 15.20% | High-priority signal | 25.20% ; MON_FREE_LIMIT | Free tier too limited | 247 | 14.78% | High-priority signal | 4.59% ; PR_SIMPLE | Simple / minimal / nothing extra | 144 | 8.62% | High-priority signal | 11.23% ; PR_DESIGN | Design / interface | 131 | 7.84% | High-priority signal | 9.60% ; MON_PAID | States a purchase | 107 | 6.40% | High-priority signal | 7.18% ; JUST_STARTED | Just started | 100 | 5.98% | High-priority signal | 5.11% ; REQ_CUSTOMIZE | Other settings | 80 | 4.79% | Very strong signal | 1.54% ; PR_BETTER_THAN | Better than alternatives | 70 | 4.19% | Very strong signal | 8.61% ; REQ_TIME | Task time / duration | 69 | 4.13% | Very strong signal | 1.23% ; MON_PRICE | Too expensive | 66 | 3.95% | Very strong signal | 1.66% ; OUT_PRODUCTIVE | More productive / organised | 58 | 3.47% | Very strong signal | 5.25% — 4★ reviews are the same praise with one missing thing: the free-tier cap (247), customisation (80), a task time (69), price (66) or a desktop (46)

- **Where:** §4.2 4★ table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 4★ top codes
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C276 An optional event time (and duration) on a task or habit, distinct from its reminder, with the day sorted by it and shown on the widget

### R59-061 — 3★ themes (verbatim): Code | Meaning | n | % of 3★ reviews | Segment band | % of all 15,176 ; MON_FREE_LIMIT | Free tier too limited | 80 | 16.63% | High-priority signal | 4.59% ; MON_PAID | States a purchase | 51 | 10.60% | High-priority signal | 7.18% ; PR_GENERIC | General praise | 38 | 7.90% | High-priority signal | 20.08% ; BUG_CRASH | Crashes / won't open | 35 | 7.28% | High-priority signal | 1.42% ; CONTRA_RATING | Star contradicts text | 33 | 6.86% | High-priority signal | 1.02% ; PR_DESIGN | Design / interface | 32 | 6.65% | High-priority signal | 9.60% ; NEG_UX | Awkward interaction | 29 | 6.03% | High-priority signal | 0.95% ; PR_EASY | Easy / convenient / intuitive | 28 | 5.82% | High-priority signal | 25.20% ; MON_PRICE | Too expensive | 28 | 5.82% | High-priority signal | 1.66% ; MON_TRIAL | Mentions the trial | 26 | 5.41% | High-priority signal | 2.02% ; BUG_UPDATE | Broke after an update | 23 | 4.78% | Very strong signal | 0.68% ; BUG_PURCHASE | Purchase not applied | 23 | 4.78% | Very strong signal | 0.94% — led by the free-tier cap (80 of 481) and crashes (35)

- **Where:** §4.2 3★ table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 3★ top codes
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-062 — 2★ themes (verbatim): Code | Meaning | n | % of 2★ reviews | Segment band | % of all 15,176 ; MON_PAID | States a purchase | 49 | 21.49% | High-priority signal | 7.18% ; MON_FREE_LIMIT | Free tier too limited | 37 | 16.23% | High-priority signal | 4.59% ; MON_NOT_WORTH | Not worth the money | 23 | 10.09% | High-priority signal | 0.56% ; BUG_CRASH | Crashes / won't open | 19 | 8.33% | High-priority signal | 1.42% ; BUG_PURCHASE | Purchase not applied | 18 | 7.89% | High-priority signal | 0.94% ; CHURN_DELETE | Deleted / stopped | 17 | 7.46% | High-priority signal | 0.55% ; MON_FREE_CUT | Free tier reduced | 17 | 7.46% | High-priority signal | 0.68% ; NEG_UX | Awkward interaction | 17 | 7.46% | High-priority signal | 0.95% ; MON_TRIAL | Mentions the trial | 16 | 7.02% | High-priority signal | 2.02% ; MON_LIFETIME | Bought lifetime | 15 | 6.58% | High-priority signal | 2.83% ; COMP_MENTION | Names a competitor | 14 | 6.14% | High-priority signal | 1.39% ; MON_PRICE | Too expensive | 14 | 6.14% | High-priority signal | 1.66% — purchases that disappointed (MON_PAID 49, MON_NOT_WORTH 23, BUG_PURCHASE 18) and the 2021 free cut (17)

- **Where:** §4.2 2★ table (verbatim)
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 2★ top codes
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-063 — 1★ themes (verbatim): Code | Meaning | n | % of 1★ reviews | Segment band | % of all 15,176 ; MON_AUTO_CHARGE | Unexpected charge | 163 | 24.18% | High-priority signal | 1.51% ; MON_TRIAL | Mentions the trial | 111 | 16.47% | High-priority signal | 2.02% ; MON_REFUND | Refund requested or given | 108 | 16.02% | High-priority signal | 1.05% ; MON_PAID | States a purchase | 98 | 14.54% | High-priority signal | 7.18% ; BUG_CRASH | Crashes / won't open | 76 | 11.28% | High-priority signal | 1.42% ; MON_FREE_LIMIT | Free tier too limited | 76 | 11.28% | High-priority signal | 4.59% ; MON_DISCLOSURE | Unclear or misleading terms | 50 | 7.42% | High-priority signal | 0.53% ; MON_FREE_CUT | Free tier reduced | 49 | 7.27% | High-priority signal | 0.68% ; CHURN_DELETE | Deleted / stopped | 48 | 7.12% | High-priority signal | 0.55% ; BUG_PURCHASE | Purchase not applied | 47 | 6.97% | High-priority signal | 0.94% ; MON_CANCEL_TROUBLE | Cannot cancel | 47 | 6.97% | High-priority signal | 0.48% ; MON_PAYWALL_SURPRISE | Thought it was free | 44 | 6.53% | High-priority signal | 0.42% — trial charges (MON_AUTO_CHARGE 163, MON_TRIAL 111, MON_REFUND 108), the free cut (49), disclosure (50), crashes (76)

- **Where:** §4.2 1★ table (verbatim)
- **This app does:** n/a
- **User reaction:** 1★-burst
- **Magnitude:** 1★ top codes
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-110 — Monetisation pain is geographic, product love is not: removing the Russian storefront leaves praise (76.8%), ease and the free-limit objection intact but cuts billing from 3.2% to 1.4% and payment access to 0.0% — billing failures stem from the trial charge in roubles and blocked App Store payments, not from the product

- **Where:** §6.22; §7.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** billing 3.2% → 1.4% without ru
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

## Audiences

### R59-038 — Memory and ADHD: OUT_MEMORY 326 (2.15%, Meaningful), USE_HEALTH 85 (0.56%) — 'As an ADHD person'; 'keeps me together with my bad ADHD'; 'Я очень забывчивая, и это приложение буквально спасает меня' (I am very forgetful and this app literally saves me); the same users are the most exposed to the missing task time; USE_HEALTH distinctive in US (6.89×) and GB (8.76×); OUT_MEMORY in FR (3.34×) and SE (5.01×)

- **Where:** §3.2 outcomes
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 326 (2.15%); health 85
- **Direction for us:** none · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Review IDs:** `11039389369`, `12210234384`, `13659861073`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C183 A pre-planned, structured day is the outcome ADHD and autistic users praise

### R59-039 — Work, study and habits kept: USE_WORK 163 (1.07%) — 'Работаю руководителем и поток задач безграничен' (I work as a manager and the flow of tasks is endless); USE_STUDY 90 (0.59%) — 'Оно облегчило жизнь студентки в 5 раз' (made a student's life five times easier); OUT_HABIT 178 (1.17%) — 'Помогло мне начать пить воду каждый день' (helped me start drinking water every day); 'я бы пила воды в 3 раза меньше' (I would drink three times less water); OUT_PRODUCTIVE 796 (5.25%)

- **Where:** §3.2 outcomes
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** work 163; study 90; habit 178
- **Direction for us:** none · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Review IDs:** `13844937938`, `14436109780`, `11687814333`, `13910926688`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

## Markets and languages

### R59-010 — From March 2022 Russian users could not pay through the App Store; a direct-card checkout later turns this into praise: MON_PAYMENT_METHOD 74 (0.49%, Weak, 4.31★, 2020-03-03 → 2026-07-05) — only 6 before 2022-03, 26 in the rest of 2022 when Apple Pay and Russian cards stopped working; 72 of 74 on the Russian storefront; unusually 54 of 74 are 5★ — reviewers want to pay and ask how ('не могу оплатить премиум - версию, с кем мне связаться' — cannot pay for premium, whom do I contact); support answered some within minutes ('в течении 10-20 минут решили' — solved within 10–20 minutes); arranged card or carrier billing case by case ('у меня мобильный оператор Megafon'); from 2024 a direct bank-card route appears in praise ('спасибо, что можно оплачивать напрямую по банковской карте' — thanks for letting us pay directly by bank card; 'за возможность альтернативной оплаты подписки для РФ'); 'Не мог оплатить подписку, так как эпл больше не принимает российские карты. Разработчики решили проблему'; 'Нашла способ оплатить из России и купила'; 'Вы теряете живые деньги' (you are losing real money)

- **Where:** §0.4; §2.3; §6.22
- **This app does:** direct-card / carrier billing outside the App Store for Russia
- **User reaction:** purchase-driver
- **Magnitude:** 74 (0.49%); 72 ru; 54 of 74 5★
- **Direction for us:** do · **Report confidence:** Weak signal · **Generalisable:** generalisable
- **Conditions:** storefronts where App Store payments are blocked
- **Review IDs:** `8518222803`, `8515045646`, `12480320347`, `13606147288`, `8482434347`, `10534966149`, `9567686482`, `13696767009`, `5610817154`, `8724203183`, `9039867577`, `9525631672`, `10131309786`, `10775299468`, `11302828146`, `12738318710`, `14265180049`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R59-056 — Western services exiting Russia (Trello, Notion) and Apple payments blocked are acquisition and monetisation events for a local-developer app: switchers arrive in E4 after those services leave; a Russian creator is itself praised (PR_RU_DEV 10)

- **Where:** §3.7; §6.22
- **This app does:** n/a
- **User reaction:** switch-to
- **Magnitude:** anecdotal; E4
- **Direction for us:** none · **Report confidence:** anecdotal · **Generalisable:** app-specific
- **Conditions:** sanctions / service-exit markets
- **Review IDs:** `10966052624`, `11752235590`, `13820151786`
- **Canonical:** C005 Know which competitors buyers compare against; C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK)

### R59-072 — Storefront table (verbatim): Storefront | Reviews | % of 15,176 | Mean ★ | Public ★ (ratings) | Praise % | Price objection % | Billing % | Bug % | Platform request % | Schedule request % | E6 share % | Eligible ; ru | 10,667 | 70.29% | 4.61 | 4.75 (32,119) | 76.5% | 7.3% | 4.0% | 6.6% | 2.8% | 3.6% | 18.3% | ✅ ; ua | 824 | 5.43% | 4.67 | 4.79 (3,508) | 77.8% | 6.3% | 1.9% | 3.2% | 2.8% | 1.1% | 7.6% | ✅ ; br | 583 | 3.84% | 4.71 | 4.77 (2,400) | 74.6% | 6.7% | 0.7% | 1.7% | 1.5% | 1.5% | 32.1% | ✅ ; de | 332 | 2.19% | 4.55 | 4.57 (1,098) | 80.7% | 8.7% | 2.1% | 4.2% | 0.9% | 4.8% | 14.5% | ✅ ; us | 311 | 2.05% | 4.53 | 4.70 (1,041) | 76.8% | 7.7% | 1.0% | 8.0% | 0.6% | 3.2% | 28.3% | ✅ ; fr | 279 | 1.84% | 4.53 | 4.59 (932) | 81.4% | 11.8% | 1.8% | 1.1% | 0.4% | 1.1% | 13.6% | ✅ ; kz | 247 | 1.63% | 4.78 | 4.83 (832) | 79.4% | 7.7% | 0.8% | 3.2% | 3.2% | 1.2% | 28.3% | ✅ ; sa | 220 | 1.45% | 4.61 | 4.60 (777) | 76.8% | 11.4% | 0.5% | 4.1% | 0.9% | 1.8% | 10.0% | ✅ ; gb | 163 | 1.07% | 4.48 | 4.56 (446) | 76.1% | 9.2% | 1.2% | 9.2% | 3.1% | 0.6% | 9.8% | ✅ ; tr | 134 | 0.88% | 4.13 | 4.49 (434) | 59.7% | 17.2% | 4.5% | 14.9% | 0.7% | 0.7% | 21.6% | ✅ ; ca | 102 | 0.67% | 4.55 | 4.67 (338) | 71.6% | 10.8% | 1.0% | 3.9% | 4.9% | 2.0% | 12.7% | ✅ ; au | 96 | 0.63% | 4.42 | 4.57 (316) | 72.9% | 13.5% | 1.0% | 1.0% | 0.0% | 2.1% | 12.5% | ✅ ; by | 81 | 0.53% | 4.79 | 4.88 (297) | 75.3% | 6.2% | 0.0% | 6.2% | 3.7% | 2.5% | 23.5% | ✅ ; ch | 72 | 0.47% | 4.50 | 4.62 (256) | 76.4% | 11.1% | 0.0% | 1.4% | 1.4% | 1.4% | 13.9% | ✅ ; se | 65 | 0.43% | 4.08 | 4.44 (231) | 63.1% | 15.4% | 0.0% | 4.6% | 3.1% | 1.5% | 13.8% | ✅ ; it | 57 | 0.38% | 4.53 | 4.49 (170) | 86.0% | 8.8% | 0.0% | 3.5% | 1.8% | 0.0% | 17.5% | ✅ ; es | 57 | 0.38% | 4.67 | 4.68 (157) | 80.7% | 10.5% | 0.0% | 7.0% | 1.8% | 3.5% | 14.0% | ✅ ; mx | 56 | 0.37% | 4.79 | 4.81 (150) | 82.1% | 3.6% | 1.8% | 0.0% | 1.8% | 1.8% | 10.7% | ✅ ; in | 53 | 0.35% | 4.51 | 4.72 (187) | 86.8% | 5.7% | 0.0% | 7.5% | 1.9% | 0.0% | 24.5% | ✅ ; 90 other storefronts | 777 | 5.12% | 4.58 | — | 76.8% | 8.6% | 1.8% | 5.3% | 1.8% | 2.1% | 23.8% | ; Global | 15,176 | 100% | 4.60 | — | 76.6% | 7.7% | 3.2% | 5.9% | 2.5% | 3.1% | 18.4% | — eligibility ≥50 reviews: ru, ua, br, de, us, fr, kz, sa, gb, tr, ca, au, by, ch, se, it, es, mx, in; distinctive = lift ≥1.8 with ≥5 reviews; bands in country sections are storefront segment bands

- **Where:** §6.1 table (verbatim); §6.2
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 19 eligible storefronts
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-073 — RU — 10,667 reviews, 4.61★ (public 4.75 from 32,119); Russian 10,424, English 166; 1–2★ 6.5%; E6 share 18.3%. Table (verbatim): Code | Meaning | n | % of ru | Segment band | % global | Lift ; PR_EASY | Easy / convenient / intuitive | 2915 | 27.3% | High-priority signal | 25.2% | 1.08× ; PR_GENERIC | General praise | 2001 | 18.8% | High-priority signal | 20.1% | 0.93× ; PR_SIMPLE | Simple / minimal / nothing extra | 1200 | 11.2% | High-priority signal | 11.2% | 1.00× ; PR_DESIGN | Design / interface | 1084 | 10.2% | High-priority signal | 9.6% | 1.06× ; PR_DEV | Thanks the developers | 1030 | 9.7% | High-priority signal | 8.2% | 1.18× ; PR_BETTER_THAN | Better than alternatives | 936 | 8.8% | High-priority signal | 8.6% | 1.02× ; MON_PAID | States a purchase | 892 | 8.4% | High-priority signal | 7.2% | 1.16× ; PR_BEST | Best / favourite | 882 | 8.3% | High-priority signal | 7.9% | 1.05× — no distinctive theme; Russia defines the global profile; in absolute terms it carries 72 of 74 payment-route complaints, 96 of 103 free-tier-cut complaints and most trial-charge reports

- **Where:** §6.3 RU table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 70.29% of corpus
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `3300153411`, `5900611155`, `6556394037`, `7198994111`, `8103498990`, `9067263809`, `9971293629`, `10848281063`, `12099571192`, `14512226198`, `3331470837`, `6429068171`, `7979746757`, `10556698584`, `14376924894`
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R59-074 — UA — 824 reviews, 4.67★ (public 4.79); Russian 593, Ukrainian 111, English 107; 1–2★ 4.1%; E6 7.6% (volume falls sharply after 2021). Table (verbatim): Code | Meaning | n | % of ua | Segment band | % global | Lift ; PR_EASY | Easy / convenient / intuitive | 212 | 25.7% | High-priority signal | 25.2% | 1.02× ; PR_GENERIC | General praise | 208 | 25.2% | High-priority signal | 20.1% | 1.26× ; PR_DESIGN | Design / interface | 76 | 9.2% | High-priority signal | 9.6% | 0.96× ; PR_SIMPLE | Simple / minimal / nothing extra | 65 | 7.9% | High-priority signal | 11.2% | 0.70× ; PR_BEST | Best / favourite | 63 | 7.6% | High-priority signal | 7.9% | 0.97× ; PR_DEV | Thanks the developers | 63 | 7.6% | High-priority signal | 8.2% | 0.93× ; PR_BETTER_THAN | Better than alternatives | 57 | 6.9% | High-priority signal | 8.6% | 0.80× ; MON_PAID | States a purchase | 49 | 5.9% | High-priority signal | 7.2% | 0.83× — distinctive REQ_LANG 8 (7.75×), REQ_GAMIFY 6 (3.68×), REQ_TIMER 7 (3.00×), REV_UPDATED 6, REQ_SHOW_DONE 7; the only storefront where a language request is distinctive: 8 ask for a Ukrainian interface, which the listing does not declare (nor Kazakh); REQ_LANG 19 overall; BUG_TRANSLATION 7 (e.g. a German widget in Russian) — localise into the languages your storefronts write in, including politically sensitive ones

- **Where:** §6.4 UA table (verbatim); §6.23
- **This app does:** no Ukrainian localisation
- **User reaction:** request
- **Magnitude:** REQ_LANG 7.75× in UA
- **Direction for us:** do · **Report confidence:** table · **Generalisable:** generalisable
- **Conditions:** Russian-speaking markets with Ukrainian users
- **Review IDs:** `3334609644`, `5825883539`, `6344422509`, `6864777160`, `7401172073`, `7950180771`, `8551416893`, `9384116864`, `10535762825`, `14506261565`, `6138803751`, `7608036580`, `9228375032`, `14215584243`
- **Canonical:** C027 Localise early — it unlocks revenue

### R59-075 — BR — 583 reviews, 4.71★ (public 4.77); Portuguese 567; 1–2★ 2.9%; E6 share 32.1% — the growth market of the late corpus (most reviews 2023 onward). Table (verbatim): Code | Meaning | n | % of br | Segment band | % global | Lift ; PR_GENERIC | General praise | 139 | 23.8% | High-priority signal | 20.1% | 1.19× ; PR_EASY | Easy / convenient / intuitive | 127 | 21.8% | High-priority signal | 25.2% | 0.86× ; OUT_PRODUCTIVE | More productive / organised | 84 | 14.4% | High-priority signal | 5.2% | 2.75× ; PR_SIMPLE | Simple / minimal / nothing extra | 52 | 8.9% | High-priority signal | 11.2% | 0.79× ; PR_BEST | Best / favourite | 37 | 6.3% | High-priority signal | 7.9% | 0.81× ; PR_RECOMMEND | Recommends it | 36 | 6.2% | High-priority signal | 6.2% | 0.99× ; JUST_STARTED | Just started | 31 | 5.3% | High-priority signal | 5.1% | 1.04× ; PR_DESIGN | Design / interface | 28 | 4.8% | Very strong signal | 9.6% | 0.50× — distinctive PR_FAST 15 (3.12×), OUT_PRODUCTIVE 84 (2.75×), OUT_LIFE 16 (2.67×); talks about outcomes at over twice the global rate with the lowest 1–2★ share of the three storefronts above 500

- **Where:** §6.5 BR table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** E6 32.1%; outcomes 2.75×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `5777390116`, `8203588251`, `8970905654`, `9661863508`, `10122010048`, `10611948267`, `11149419405`, `12028346781`, `13113054242`, `14515138883`, `5954970157`, `8636380837`, `10147766502`, `11426109678`, `14097083395`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-076 — DE — 332 reviews, 4.55★ (public 4.57); German 277; 1–2★ 4.5%; E6 14.5%. Table (verbatim): Code | Meaning | n | % of de | Segment band | % global | Lift ; PR_GENERIC | General praise | 78 | 23.5% | High-priority signal | 20.1% | 1.17× ; PR_EASY | Easy / convenient / intuitive | 65 | 19.6% | High-priority signal | 25.2% | 0.78× ; PR_SIMPLE | Simple / minimal / nothing extra | 52 | 15.7% | High-priority signal | 11.2% | 1.39× ; PR_DESIGN | Design / interface | 37 | 11.1% | High-priority signal | 9.6% | 1.16× ; PR_BETTER_THAN | Better than alternatives | 31 | 9.3% | High-priority signal | 8.6% | 1.08× ; MON_FREE_LIMIT | Free tier too limited | 21 | 6.3% | High-priority signal | 4.6% | 1.38× ; OUT_PRODUCTIVE | More productive / organised | 21 | 6.3% | High-priority signal | 5.2% | 1.21× ; PR_RECOMMEND | Recommends it | 18 | 5.4% | High-priority signal | 6.2% | 0.87× — distinctive PR_ONE_SCREEN 16 (8.92×), PR_RECURRING 9 (3.27×), MON_ONETIME_PRAISE 6 (2.95×), MON_UPSELL 5 (2.36×), REQ_SORT 6 (2.08×), OUT_LIFE 7, PR_ALLINONE 12 (1.87×), OUT_MEMORY 13, PR_MOTIVATION 10; Germany praises the one-screen layout and the one-time price, and reports the upsell as intrusive more than most

- **Where:** §6.6 DE table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** one-screen 8.92×; one-time praise 2.95×; upsell 2.36×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `3553281774`, `6831614744`, `7833838380`, `8212659436`, `8748522320`, `9132813924`, `9585043604`, `10391489090`, `11876525609`, `14489435131`, `5717641451`, `7506250318`, `8769420728`, `9981617180`, `13827246849`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C093 No upsell nagging without a 'never ask again' option; C254 An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation

### R59-077 — US — 311 reviews, 4.53★ (public 4.70); English 235, Russian 59, Arabic 13; 1–2★ 5.8%; E6 28.3%. Table (verbatim): Code | Meaning | n | % of us | Segment band | % global | Lift ; PR_EASY | Easy / convenient / intuitive | 56 | 18.0% | High-priority signal | 25.2% | 0.71× ; PR_GENERIC | General praise | 54 | 17.4% | High-priority signal | 20.1% | 0.86× ; PR_SIMPLE | Simple / minimal / nothing extra | 45 | 14.5% | High-priority signal | 11.2% | 1.29× ; PR_BETTER_THAN | Better than alternatives | 40 | 12.9% | High-priority signal | 8.6% | 1.49× ; PR_DESIGN | Design / interface | 33 | 10.6% | High-priority signal | 9.6% | 1.11× ; OUT_PRODUCTIVE | More productive / organised | 33 | 10.6% | High-priority signal | 5.2% | 2.02× ; PR_BEST | Best / favourite | 30 | 9.6% | High-priority signal | 7.9% | 1.23× ; PR_RECOMMEND | Recommends it | 24 | 7.7% | High-priority signal | 6.2% | 1.24× — distinctive USE_HEALTH 12 (6.89×), USE_FAMILY 5 (5.67×), PR_SWIPE 6 (5.05×), PR_RECURRING 10 (3.87×), SUP_NONE 5 (3.81×), USE_STUDY 7 (3.80×), MON_WONT_PAY 5 (3.75×), PR_SECTIONS 10 (3.64×), PR_ALLINONE 20 (3.33×), PR_CUSTOM 6, OUT_HABIT 11 (3.02×), PR_LISTS 11, USE_WORK 9, PR_CALENDAR 7, PR_REMINDERS 19, PR_HABITS 21 (2.30×), COMP_SWITCHED_FROM 5, REQ_HABIT_OPTIONS 5, OUT_PRODUCTIVE 33 (2.02×), REQ_TASK_OPTIONS 6; ADHD and family use distinctive, all-in-one praise, refusal to pay above global

- **Where:** §6.7 US table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** health 6.89×; all-in-one 3.33×; won't pay 3.75×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `3750048186`, `5793220793`, `6974797379`, `8113668774`, `9039944899`, `9603519296`, `10561988075`, `11754868231`, `13294830597`, `14406460321`, `3846335191`, `6858805806`, `9347633573`, `11489187546`, `14285768410`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R59-078 — FR — 279 reviews, 4.53★ (public 4.59); French 266; 1–2★ 3.2%; E6 13.6%. Table (verbatim): Code | Meaning | n | % of fr | Segment band | % global | Lift ; PR_GENERIC | General praise | 79 | 28.3% | High-priority signal | 20.1% | 1.41× ; PR_SIMPLE | Simple / minimal / nothing extra | 49 | 17.6% | High-priority signal | 11.2% | 1.56× ; PR_EASY | Easy / convenient / intuitive | 45 | 16.1% | High-priority signal | 25.2% | 0.64× ; PR_RECOMMEND | Recommends it | 41 | 14.7% | High-priority signal | 6.2% | 2.36× ; OUT_PRODUCTIVE | More productive / organised | 27 | 9.7% | High-priority signal | 5.2% | 1.85× ; PR_BETTER_THAN | Better than alternatives | 22 | 7.9% | High-priority signal | 8.6% | 0.92× ; MON_FREE_LIMIT | Free tier too limited | 21 | 7.5% | High-priority signal | 4.6% | 1.64× ; OUT_MEMORY | Doesn't forget things | 20 | 7.2% | High-priority signal | 2.1% | 3.34× — distinctive OUT_MEMORY 20 (3.34×), PR_RECOMMEND 41 (2.36×), PR_MOTIVATION 10 (2.17×), MON_PRICE 10 (2.16×), OUT_PRODUCTIVE 27 (1.85×); France writes about not forgetting things at over three times global, recommends more than any other large storefront; price objections above global (11.8%)

- **Where:** §6.8 FR table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** memory 3.34×; price 2.16×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `4073963129`, `6927630049`, `7902744488`, `8235860092`, `8663610108`, `9009757324`, `9488402944`, `10112806932`, `11535925402`, `14402559735`, `7997756363`, `8730501806`, `10025627335`, `13881631979`
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'

### R59-079 — KZ — 247 reviews, 4.78★ (public 4.83); Russian 203, English 29, Kazakh 6; 1–2★ 2.8%; E6 28.3%. Table (verbatim): Code | Meaning | n | % of kz | Segment band | % global | Lift ; PR_GENERIC | General praise | 64 | 25.9% | High-priority signal | 20.1% | 1.29× ; PR_EASY | Easy / convenient / intuitive | 59 | 23.9% | High-priority signal | 25.2% | 0.95× ; PR_DESIGN | Design / interface | 28 | 11.3% | High-priority signal | 9.6% | 1.18× ; PR_SIMPLE | Simple / minimal / nothing extra | 28 | 11.3% | High-priority signal | 11.2% | 1.01× ; PR_DEV | Thanks the developers | 25 | 10.1% | High-priority signal | 8.2% | 1.23× ; PR_BEST | Best / favourite | 21 | 8.5% | High-priority signal | 7.9% | 1.08× ; PR_BETTER_THAN | Better than alternatives | 14 | 5.7% | High-priority signal | 8.6% | 0.66× ; MON_PAID | States a purchase | 14 | 5.7% | High-priority signal | 7.2% | 0.79× — distinctive TENURE_LONG 10 (2.12×); highest mean of storefronts above 100 reviews; over-indexes on long-tenure reviewers

- **Where:** §6.9 KZ table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 4.78★; tenure 2.12×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `3879229714`, `5978706041`, `6753125016`, `8006133029`, `9089658094`, `9782572168`, `10948046933`, `11912755339`, `13255837762`, `14506820397`, `6483943245`, `9156078127`, `11801133304`, `14451954398`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-080 — SA — 220 reviews, 4.61★ (public 4.60); Arabic 169, English 49; 1–2★ 4.1%; E6 10.0%. Table (verbatim): Code | Meaning | n | % of sa | Segment band | % global | Lift ; PR_GENERIC | General praise | 86 | 39.1% | High-priority signal | 20.1% | 1.95× ; PR_EASY | Easy / convenient / intuitive | 30 | 13.6% | High-priority signal | 25.2% | 0.54× ; MON_FREE_LIMIT | Free tier too limited | 21 | 9.5% | High-priority signal | 4.6% | 2.08× ; OUT_PRODUCTIVE | More productive / organised | 21 | 9.5% | High-priority signal | 5.2% | 1.82× ; PR_RECOMMEND | Recommends it | 18 | 8.2% | High-priority signal | 6.2% | 1.32× ; PR_DEV | Thanks the developers | 15 | 6.8% | High-priority signal | 8.2% | 0.83× ; PR_REMINDERS | Reminders | 13 | 5.9% | High-priority signal | 2.6% | 2.24× ; PR_BETTER_THAN | Better than alternatives | 10 | 4.5% | Very strong signal | 8.6% | 0.53× — distinctive OUT_LIFE 9 (3.98×), PR_REMINDERS 13 (2.24×), MON_FREE_LIMIT 21 (2.08×), REQ_CUSTOMIZE 7 (2.06×), PR_GENERIC 86 (1.95×), OUT_PRODUCTIVE 21 (1.82×); short generic praise dominates; the free-tier cap is its most frequent complaint at twice global

- **Where:** §6.10 SA table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** free limit 2.08×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `5757334491`, `6997846785`, `7692594472`, `8020651263`, `8385539724`, `8980361372`, `9457533854`, `10142989212`, `11151589524`, `14443036408`, `7517399910`, `8387994312`, `10042893815`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it

### R59-081 — GB — 163 reviews, 4.48★ (public 4.56; E6 corpus mean 4.12); English 159; 1–2★ 5.5%; E6 9.8%. Table (verbatim): Code | Meaning | n | % of gb | Segment band | % global | Lift ; PR_EASY | Easy / convenient / intuitive | 33 | 20.2% | High-priority signal | 25.2% | 0.80× ; PR_BETTER_THAN | Better than alternatives | 25 | 15.3% | High-priority signal | 8.6% | 1.78× ; PR_GENERIC | General praise | 25 | 15.3% | High-priority signal | 20.1% | 0.76× ; OUT_PRODUCTIVE | More productive / organised | 23 | 14.1% | High-priority signal | 5.2% | 2.69× ; PR_DESIGN | Design / interface | 20 | 12.3% | High-priority signal | 9.6% | 1.28× ; PR_SIMPLE | Simple / minimal / nothing extra | 20 | 12.3% | High-priority signal | 11.2% | 1.09× ; PR_BEST | Best / favourite | 15 | 9.2% | High-priority signal | 7.9% | 1.17× ; MON_FREE_LIMIT | Free tier too limited | 13 | 8.0% | High-priority signal | 4.6% | 1.74× — distinctive USE_HEALTH 8 (8.76×), USE_STUDY 5 (5.17×), OUT_LIFE 8 (4.77×), PR_ALLINONE 10 (3.18×), OUT_PRODUCTIVE 23 (2.69×), PR_MOTIVATION 7, COMP_MENTION 5, REQ_CUSTOMIZE 5, PR_REMINDERS 8; over-indexes on health and study use and all-in-one praise; most likely to ask the developer not to change the app

- **Where:** §6.11 GB table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** health 8.76×; all-in-one 3.18×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `3750057095`, `5705732997`, `6031062548`, `6950666930`, `7893006077`, `8340462496`, `8914863311`, `9856586457`, `11004998054`, `13498933122`, `3814584110`, `5990919411`, `7626512021`, `9889341142`, `12672655001`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers

### R59-082 — TR — 134 reviews, 4.13★ (public 4.49); Turkish 102; 1–2★ 15.7% (global 5.9%); E6 21.6%. Table (verbatim): Code | Meaning | n | % of tr | Segment band | % global | Lift ; PR_GENERIC | General praise | 36 | 26.9% | High-priority signal | 20.1% | 1.34× ; BUG_CRASH | Crashes / won't open | 16 | 11.9% | High-priority signal | 1.4% | 8.43× ; MON_FREE_LIMIT | Free tier too limited | 14 | 10.4% | High-priority signal | 4.6% | 2.27× ; MON_PAID | States a purchase | 14 | 10.4% | High-priority signal | 7.2% | 1.45× ; PR_EASY | Easy / convenient / intuitive | 12 | 9.0% | High-priority signal | 25.2% | 0.36× ; MON_PRICE | Too expensive | 10 | 7.5% | High-priority signal | 1.7% | 4.49× ; PR_RECOMMEND | Recommends it | 10 | 7.5% | High-priority signal | 6.2% | 1.20× ; BUG_REMINDER | Notifications fail | 10 | 7.5% | High-priority signal | 0.6% | 11.80× — distinctive BUG_HABITS 6 (19.99×), BUG_REMINDER 10 (11.80×), BUG_CRASH 16 (8.43×), MON_PRICE 10 (4.49×), MON_FREE_LIMIT 14 (2.27×); second-lowest mean of eligible storefronts and lowest above 100; a locale-specific defect the others barely report — the app closes when a reminder is set on a habit (two Korean reports too) — alongside price objections; test reminder flows under each locale

- **Where:** §6.12 TR table (verbatim); §6.24
- **This app does:** habit-reminder crash in Turkish locale
- **User reaction:** 1★-burst
- **Magnitude:** 1–2★ 15.7%; BUG_HABITS 19.99×
- **Direction for us:** must-never-break · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `5440400493`, `7342114973`, `8340666721`, `9056268005`, `9605987186`, `10027348801`, `10516604840`, `11116680784`, `11925689449`, `14394979399`, `8236763256`, `9543755153`, `10311666951`, `12495374216`, `11020375846`
- **Canonical:** C031 Crashes / launch failures; C064 Price level — where 'fair' turns into 'too expensive'; C156 Content and event releases need a crash gate across device generations

### R59-083 — CA — 102 reviews, 4.55★ (public 4.67); English 87, French 11; 1–2★ 2.0%. Table (verbatim): Code | Meaning | n | % of ca | Segment band | % global | Lift ; OUT_PRODUCTIVE | More productive / organised | 20 | 19.6% | High-priority signal | 5.2% | 3.74× ; PR_EASY | Easy / convenient / intuitive | 18 | 17.6% | High-priority signal | 25.2% | 0.70× ; PR_GENERIC | General praise | 18 | 17.6% | High-priority signal | 20.1% | 0.88× ; PR_SIMPLE | Simple / minimal / nothing extra | 14 | 13.7% | High-priority signal | 11.2% | 1.22× ; PR_BETTER_THAN | Better than alternatives | 11 | 10.8% | High-priority signal | 8.6% | 1.25× ; JUST_STARTED | Just started | 8 | 7.8% | High-priority signal | 5.1% | 1.54× ; MON_FREE_LIMIT | Free tier too limited | 7 | 6.9% | High-priority signal | 4.6% | 1.49× ; PR_REMINDERS | Reminders | 7 | 6.9% | High-priority signal | 2.6% | 2.60× — distinctive OUT_PRODUCTIVE 20 (3.74×), PR_REMINDERS 7 (2.60×), PR_ALLINONE 5 (2.54×); praise 71.6%; top non-praise MON_FREE_LIMIT 7, REQ_PHOTO 3, BUG_CALENDAR 3 — indicative only

- **Where:** §6.13 CA table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** productive 3.74×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `3750086179`, `5828237326`, `6200456465`, `7025028562`, `8270968597`, `8905378416`, `9360549882`, `10245351047`, `11535152327`, `13956074699`, `3883332119`, `6172514475`, `8483703559`, `9553162151`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-084 — AU — 96 reviews, 4.42★ (public 4.57; E6 4.08); English 94; 1–2★ 9.4%. Table (verbatim): Code | Meaning | n | % of au | Segment band | % global | Lift ; PR_EASY | Easy / convenient / intuitive | 17 | 17.7% | High-priority signal | 25.2% | 0.70× ; PR_SIMPLE | Simple / minimal / nothing extra | 13 | 13.5% | High-priority signal | 11.2% | 1.21× ; PR_BETTER_THAN | Better than alternatives | 13 | 13.5% | High-priority signal | 8.6% | 1.57× ; PR_GENERIC | General praise | 12 | 12.5% | High-priority signal | 20.1% | 0.62× ; OUT_PRODUCTIVE | More productive / organised | 10 | 10.4% | High-priority signal | 5.2% | 1.99× ; PR_DESIGN | Design / interface | 10 | 10.4% | High-priority signal | 9.6% | 1.08× ; PR_RECOMMEND | Recommends it | 9 | 9.4% | High-priority signal | 6.2% | 1.51× ; MON_VALUE | Worth the money / fair price | 7 | 7.3% | High-priority signal | 3.1% | 2.38× — distinctive PR_MOTIVATION 6 (3.78×), PR_ALLINONE 6 (3.24×), MON_VALUE 7 (2.38×), OUT_PRODUCTIVE 10, PR_REMINDERS 5; praise 72.9%, price objection 13.5%; top non-praise MON_FREE_LIMIT 7, REQ_STATS 4, MON_PRICE 4 — indicative

- **Where:** §6.14 AU table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** all-in-one 3.24×; value 2.38×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `3750067398`, `5917776512`, `6319546601`, `7106072958`, `7724569153`, `7996934561`, `8658852107`, `9708429256`, `11359451960`, `14303361019`, `4174959753`, `6753631764`, `8113192979`, `9834787257`, `13925888757`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-085 — BY — 81 reviews, 4.79★ (public 4.88; E6 5.00); Russian 69; 1–2★ 2.5%. Table (verbatim): Code | Meaning | n | % of by | Segment band | % global | Lift ; PR_EASY | Easy / convenient / intuitive | 18 | 22.2% | High-priority signal | 25.2% | 0.88× ; PR_BETTER_THAN | Better than alternatives | 16 | 19.8% | High-priority signal | 8.6% | 2.29× ; PR_SIMPLE | Simple / minimal / nothing extra | 14 | 17.3% | High-priority signal | 11.2% | 1.54× ; PR_DESIGN | Design / interface | 10 | 12.3% | High-priority signal | 9.6% | 1.29× ; PR_GENERIC | General praise | 10 | 12.3% | High-priority signal | 20.1% | 0.61× ; PR_DEV | Thanks the developers | 6 | 7.4% | High-priority signal | 8.2% | 0.90× ; PR_RECOMMEND | Recommends it | 6 | 7.4% | High-priority signal | 6.2% | 1.19× ; MON_PAID | States a purchase | 5 | 6.2% | High-priority signal | 7.2% | 0.86× — distinctive PR_BETTER_THAN 16 (2.29×); top non-praise MON_FREE_LIMIT 3, BUG_WIDGET 3, BUG_CRASH 3 — indicative

- **Where:** §6.15 BY table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** better-than 2.29×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `5359553360`, `5695055835`, `6205593723`, `6534763327`, `7006480028`, `8262642663`, `9774600735`, `11290309936`, `12192301574`, `14257674111`, `5470893305`, `5939419252`, `9143173815`, `10969904826`, `13813624039`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-086 — CH — 72 reviews, 4.50★ (public 4.62); German 34, English 21, French 17; 1–2★ 5.6%. Table (verbatim): Code | Meaning | n | % of ch | Segment band | % global | Lift ; PR_GENERIC | General praise | 26 | 36.1% | High-priority signal | 20.1% | 1.80× ; PR_SIMPLE | Simple / minimal / nothing extra | 11 | 15.3% | High-priority signal | 11.2% | 1.36× ; PR_EASY | Easy / convenient / intuitive | 10 | 13.9% | High-priority signal | 25.2% | 0.55× ; OUT_PRODUCTIVE | More productive / organised | 6 | 8.3% | High-priority signal | 5.2% | 1.59× ; PR_DESIGN | Design / interface | 5 | 6.9% | High-priority signal | 9.6% | 0.72× ; PR_BEST | Best / favourite | 4 | 5.6% | High-priority signal | 7.9% | 0.71× ; MON_FREE_LIMIT | Free tier too limited | 4 | 5.6% | High-priority signal | 4.6% | 1.21× ; PR_BETTER_THAN | Better than alternatives | 3 | 4.2% | Very strong signal | 8.6% | 0.48× — no distinctive theme; top non-praise MON_FREE_LIMIT 4, REQ_THEMES 2, REQ_TASK_OPTIONS 2 — indicative; price objection 11.1%

- **Where:** §6.16 CH table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** no distinctive
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `6165159984`, `8073960162`, `8412356401`, `8649469375`, `8971559792`, `9465877201`, `9732921522`, `10260777646`, `11413636362`, `13906448870`, `6165213446`, `8643237683`, `9579441970`, `10560200749`, `12943576319`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-087 — SE — 65 reviews, 4.08★ (public 4.44, the widest gap 0.36); Swedish 50; 1–2★ 12.3%. Table (verbatim): Code | Meaning | n | % of se | Segment band | % global | Lift ; PR_GENERIC | General praise | 9 | 13.8% | High-priority signal | 20.1% | 0.69× ; PR_BETTER_THAN | Better than alternatives | 8 | 12.3% | High-priority signal | 8.6% | 1.43× ; PR_EASY | Easy / convenient / intuitive | 8 | 12.3% | High-priority signal | 25.2% | 0.49× ; PR_SIMPLE | Simple / minimal / nothing extra | 8 | 12.3% | High-priority signal | 11.2% | 1.10× ; OUT_MEMORY | Doesn't forget things | 7 | 10.8% | High-priority signal | 2.1% | 5.01× ; PR_DESIGN | Design / interface | 6 | 9.2% | High-priority signal | 9.6% | 0.96× ; MON_FREE_LIMIT | Free tier too limited | 6 | 9.2% | High-priority signal | 4.6% | 2.01× ; OUT_PRODUCTIVE | More productive / organised | 5 | 7.7% | High-priority signal | 5.2% | 1.47× — distinctive OUT_MEMORY 7 (5.01×), MON_FREE_LIMIT 6 (2.01×); lowest mean of eligible storefronts; price objection 15.4%; praise 63.1% — indicative

- **Where:** §6.17 SE table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 4.08★; free limit 2.01×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `5764705045`, `6453445770`, `6858023792`, `8161526412`, `8291296108`, `8860504768`, `9790631389`, `10349771264`, `11916325199`, `13336615886`, `5853758797`, `6483990233`, `8801560463`, `10339809199`, `12155079224`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-088 — IT — 57 reviews, 4.53★ (public 4.49); Italian 47; 1–2★ 5.3%. Table (verbatim): Code | Meaning | n | % of it | Segment band | % global | Lift ; PR_EASY | Easy / convenient / intuitive | 10 | 17.5% | High-priority signal | 25.2% | 0.70× ; PR_GENERIC | General praise | 10 | 17.5% | High-priority signal | 20.1% | 0.87× ; PR_SIMPLE | Simple / minimal / nothing extra | 10 | 17.5% | High-priority signal | 11.2% | 1.56× ; PR_DESIGN | Design / interface | 9 | 15.8% | High-priority signal | 9.6% | 1.64× ; PR_FREE | Free version is enough | 5 | 8.8% | High-priority signal | 3.2% | 2.70× ; JUST_STARTED | Just started | 5 | 8.8% | High-priority signal | 5.1% | 1.72× ; PR_HAS_ALL | Has the features needed | 5 | 8.8% | High-priority signal | 3.6% | 2.46× ; MON_PAID | States a purchase | 5 | 8.8% | High-priority signal | 7.2% | 1.22× — distinctive PR_FREE 5 (2.70×), PR_HAS_ALL 5 (2.46×); praise 86.0%; top non-praise MON_FREE_LIMIT 4 — indicative

- **Where:** §6.18 IT table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** free 2.70×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `5019499160`, `6791792852`, `7685052243`, `8642021594`, `9251651874`, `9397762840`, `9670224237`, `10562125498`, `12207349376`, `13832505689`, `8384587254`, `10535125039`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-089 — ES — 57 reviews, 4.67★ (public 4.68); Spanish 45; 1–2★ 1.8%. Table (verbatim): Code | Meaning | n | % of es | Segment band | % global | Lift ; PR_EASY | Easy / convenient / intuitive | 12 | 21.1% | High-priority signal | 25.2% | 0.84× ; PR_SIMPLE | Simple / minimal / nothing extra | 10 | 17.5% | High-priority signal | 11.2% | 1.56× ; PR_GENERIC | General praise | 9 | 15.8% | High-priority signal | 20.1% | 0.79× ; PR_BEST | Best / favourite | 8 | 14.0% | High-priority signal | 7.9% | 1.79× ; PR_RECOMMEND | Recommends it | 8 | 14.0% | High-priority signal | 6.2% | 2.26× ; PR_DESIGN | Design / interface | 5 | 8.8% | High-priority signal | 9.6% | 0.91× ; MON_FREE_LIMIT | Free tier too limited | 5 | 8.8% | High-priority signal | 4.6% | 1.91× ; PR_HAS_ALL | Has the features needed | 5 | 8.8% | High-priority signal | 3.6% | 2.46× — distinctive PR_HAS_ALL 5 (2.46×), PR_RECOMMEND 8 (2.26×), MON_FREE_LIMIT 5 (1.91×) — indicative

- **Where:** §6.19 ES table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** recommend 2.26×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `5233004370`, `5895003362`, `6404855964`, `7458857837`, `8483502588`, `9157753617`, `9733431962`, `10953884426`, `11570999422`, `13956649418`, `6949838574`, `9210096414`, `11090536455`, `12644325448`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-090 — MX — 56 reviews, 4.79★ (public 4.81); Spanish 52; 1–2★ 1.8%. Table (verbatim): Code | Meaning | n | % of mx | Segment band | % global | Lift ; PR_EASY | Easy / convenient / intuitive | 11 | 19.6% | High-priority signal | 25.2% | 0.78× ; PR_GENERIC | General praise | 10 | 17.9% | High-priority signal | 20.1% | 0.89× ; OUT_PRODUCTIVE | More productive / organised | 10 | 17.9% | High-priority signal | 5.2% | 3.40× ; PR_BETTER_THAN | Better than alternatives | 7 | 12.5% | High-priority signal | 8.6% | 1.45× ; PR_SIMPLE | Simple / minimal / nothing extra | 6 | 10.7% | High-priority signal | 11.2% | 0.95× ; PR_RECOMMEND | Recommends it | 5 | 8.9% | High-priority signal | 6.2% | 1.44× ; PR_HAS_ALL | Has the features needed | 4 | 7.1% | High-priority signal | 3.6% | 2.00× ; JUST_STARTED | Just started | 4 | 7.1% | High-priority signal | 5.1% | 1.40× — distinctive OUT_PRODUCTIVE 10 (3.40×); praise 82.1%; price objection 3.6% — indicative

- **Where:** §6.20 MX table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** productive 3.40×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `6173062139`, `6695799142`, `8075211499`, `8845841956`, `9108851892`, `9395259450`, `9812663434`, `10749360014`, `11150420945`, `14457606673`, `6179225547`, `6549007186`, `7051187332`, `9939518963`, `14390074153`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-091 — IN — 53 reviews, 4.51★ (public 4.72); English 53; 1–2★ 1.9%; E6 24.5%. Table (verbatim): Code | Meaning | n | % of in | Segment band | % global | Lift ; PR_GENERIC | General praise | 16 | 30.2% | High-priority signal | 20.1% | 1.50× ; PR_BETTER_THAN | Better than alternatives | 9 | 17.0% | High-priority signal | 8.6% | 1.97× ; PR_EASY | Easy / convenient / intuitive | 9 | 17.0% | High-priority signal | 25.2% | 0.67× ; PR_DESIGN | Design / interface | 8 | 15.1% | High-priority signal | 9.6% | 1.57× ; PR_SIMPLE | Simple / minimal / nothing extra | 6 | 11.3% | High-priority signal | 11.2% | 1.01× ; PR_DEV | Thanks the developers | 4 | 7.5% | High-priority signal | 8.2% | 0.92× ; PR_RECOMMEND | Recommends it | 4 | 7.5% | High-priority signal | 6.2% | 1.21× ; PR_ALLINONE | Tasks + habits + calendar in one app | 4 | 7.5% | High-priority signal | 1.9% | 3.91× — distinctive PR_BETTER_THAN 9 (1.97×); praise 86.8%; top non-praise BUG_PERF 2, REQ_CUSTOMIZE 2, REQ_IPAD 1 — indicative

- **Where:** §6.21 IN table (verbatim)
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** better-than 1.97×
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `4246822176`, `6185411305`, `6749472835`, `7488016870`, `8455385564`, `9750959022`, `10868912141`, `11248903516`, `12259670527`, `14504520574`, `4319347061`, `6396309989`, `7340175481`, `8875055385`, `12847126523`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue

### R59-092 — High-spend and high-volume markets — no consumer-spend dataset fetched, so no spend ranking asserted; high-spend proxy = six eligible storefronts with most public ratings (ru, ua, br, de, us, fr — an install-base proxy); high-volume = ≥200 reviews (adds kz, sa). Table (verbatim): Group | Reviews | Mean ★ | Praise % | Outcome % | Price objection % | Billing % | Payment access % | Bug % | Platform request % | Schedule request % | E6 share % ; High-spend proxy: ru + ua + br + de + us + fr | 12,996 | 4.61 | 76.7% | 8.9% | 7.4% | 3.5% | 0.8% | 6.0% | 2.6% | 3.3% | 18.3% ; High-volume: ru + ua + br + de + us + fr + kz + sa | 13,463 | 4.61 | 76.8% | 9.0% | 7.4% | 3.4% | 0.8% | 5.9% | 2.6% | 3.3% | 18.3% ; ru + ua + kz + by (Russian-speaking storefronts) | 11,819 | 4.62 | 76.6% | 7.7% | 7.2% | 3.7% | 0.9% | 6.3% | 2.8% | 3.4% | 17.8% ; us + gb + ca + au + in (English-speaking, eligible) | 725 | 4.51 | 76.1% | 20.3% | 9.1% | 1.0% | 0.0% | 6.8% | 1.8% | 2.1% | 19.6% ; de + fr + ch + se + it + es (continental Europe, eligible) | 862 | 4.51 | 79.6% | 14.8% | 10.6% | 1.4% | 0.1% | 3.1% | 1.0% | 2.7% | 14.3% ; sa + tr (Middle East, eligible) | 354 | 4.43 | 70.3% | 13.0% | 13.6% | 2.0% | 0.0% | 8.2% | 0.8% | 1.4% | 14.4% ; br + mx (Latin America, eligible) | 639 | 4.72 | 75.3% | 21.3% | 6.4% | 0.8% | 0.0% | 1.6% | 1.6% | 1.6% | 30.2% ; Global | 15,176 | 4.60 | 76.6% | 9.6% | 7.7% | 3.2% | 0.7% | 5.9% | 2.5% | 3.1% | 18.4% — billing and payment-access problems are a Russian-speaking-storefront phenomenon (App Store payments and the trial charge in roubles; billing 3.7% vs 1.0% English-speaking); SA + TR above global on price objections (13.6%) and defects; English-speaking group and BR + MX describe outcomes at about twice global (20.3% / 21.3%); continental Europe price objection 10.6%; schedule and platform requests spread evenly — no market uniquely asks for a desktop

- **Where:** §6.22 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** billing 3.7% RU-speaking vs 1.0% EN; outcomes 20% EN/LatAm
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

## Dated events and trends

### R59-040 — Tenure grows as the corpus ages: TENURE_LONG 290 (1.91%) rises from 0.4% of E2 to 4.3% of E6 — 'кажется у меня со времен айфон 11' (I think I have had it since the iPhone 11); 'пользуюсь уже 6 лет' (have used it for 6 years); returning users frequent relative to leavers (CHURN_RETURN 36: 'Сто раз скачивала, сто раз удаляла, но в итоге всегда возвращаюсь' — downloaded a hundred times, deleted a hundred times, always come back)

- **Where:** §3.2 outcomes; §7.2
- **This app does:** n/a
- **User reaction:** praise
- **Magnitude:** 0.4% E2 → 4.3% E6
- **Direction for us:** none · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Review IDs:** `14313080369`, `13892662331`, `11556849371`
- **Canonical:** — (nuance register)

### R59-053 — Requests that stop mark shipped features: REQ_DARK (13, 2019-03-15 → 2021-10-21) ends in 2021, consistent with a dark theme shipping; REQ_WATCH (81) falls from 4.7% of E1 to 0.0% of E6 as Watch praise appears (PR_WATCH 37); REQ_DESKTOP falls after the Mac app; REQ_TIME, REQ_BACKFILL, REQ_PHOTO, REQ_STATS and REQ_SHARED never stop

- **Where:** §3.6; §7.2
- **This app does:** shipped dark mode, Watch, Mac
- **User reaction:** request
- **Magnitude:** Watch 4.7% → 0.0%
- **Direction for us:** none · **Report confidence:** era segment rates · **Generalisable:** generalisable
- **Canonical:** C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C080 Colour themes / dark mode

### R59-095 — Era method and table: eras cut at dated product or market changes reviewers describe, checked against monthly volume and code clusters — E1→E2 at 2020-01-01 (first month ≥100 reviews: 310 vs 37; rating prompt appears), E2→E3 at 2021-01-01 (free-tier cut and unlock failures from 2021-01-04), E3→E4 at 2022-03-01 (App Store payment unavailable to Russian users), E4→E5 at 2023-06-01 (recurring-task crash, build 2.5.397), E5→E6 at 2024-05-01 (regression clusters ended; first month since 2019 under 130 reviews; direct-card checkout praised). Table (verbatim): Era | Name | Dates | Reviews | Per month | Mean ★ | 1–2★ % | 5★ % ; E1 | Launch year | 2018-10-14 → 2019-12-31 | 319 | 21 | 4.25 | 11.0% | 64.9% ; E2 | Growth wave and immediate trial charges | 2020-01-01 → 2020-12-31 | 3,356 | 280 | 4.62 | 5.8% | 80.7% ; E3 | Free-tier cut and the Oct-2021 crash | 2021-01-01 → 2022-02-28 | 3,341 | 239 | 4.50 | 8.4% | 77.0% ; E4 | Sanctions and payment workarounds | 2022-03-01 → 2023-05-31 | 3,153 | 210 | 4.70 | 3.5% | 82.0% ; E5 | Regressions: recurring-task crash, wrong calendar year, freezes | 2023-06-01 → 2024-04-30 | 2,210 | 201 | 4.64 | 4.9% | 80.5% ; E6 | Direct card billing and a thinning corpus | 2024-05-01 → 2026-09-05 | 2,797 | 96 | 4.62 | 6.1% | 81.2%

- **Where:** §7.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** six eras
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-096 — Theme movement across eras (verbatim): Theme | E1 | E2 | E3 | E4 | E5 | E6 ; U_PRAISE_ANY | 205 (64.3%) | 2601 (77.5%) | 2608 (78.1%) | 2531 (80.3%) | 1646 (74.5%) | 2031 (72.6%) ; U_EASE | 94 (29.5%) | 1111 (33.1%) | 1122 (33.6%) | 997 (31.6%) | 643 (29.1%) | 960 (34.3%) ; PR_DESIGN | 58 (18.2%) | 401 (11.9%) | 289 (8.7%) | 250 (7.9%) | 196 (8.9%) | 263 (9.4%) ; PR_DEV | 20 (6.3%) | 326 (9.7%) | 227 (6.8%) | 214 (6.8%) | 178 (8.1%) | 279 (10.0%) ; PR_ALLINONE | 10 (3.1%) | 105 (3.1%) | 66 (2.0%) | 37 (1.2%) | 32 (1.4%) | 43 (1.5%) ; PR_MAC | 0 (0.0%) | 13 (0.4%) | 14 (0.4%) | 15 (0.5%) | 23 (1.0%) | 27 (1.0%) ; PR_SUPPORT | 8 (2.5%) | 18 (0.5%) | 17 (0.5%) | 17 (0.5%) | 20 (0.9%) | 25 (0.9%) ; TENURE_LONG | 0 (0.0%) | 13 (0.4%) | 51 (1.5%) | 47 (1.5%) | 58 (2.6%) | 121 (4.3%) ; U_OUTCOME | 13 (4.1%) | 263 (7.8%) | 283 (8.5%) | 344 (10.9%) | 255 (11.5%) | 305 (10.9%) ; MON_PAID | 34 (10.7%) | 279 (8.3%) | 278 (8.3%) | 156 (4.9%) | 123 (5.6%) | 220 (7.9%) ; MON_LIFETIME | 9 (2.8%) | 113 (3.4%) | 102 (3.1%) | 57 (1.8%) | 53 (2.4%) | 96 (3.4%) ; MON_VALUE | 13 (4.1%) | 136 (4.1%) | 115 (3.4%) | 66 (2.1%) | 55 (2.5%) | 80 (2.9%) ; MON_DISCOUNT | 8 (2.5%) | 52 (1.5%) | 53 (1.6%) | 45 (1.4%) | 28 (1.3%) | 38 (1.4%) ; MON_TRIAL | 4 (1.3%) | 104 (3.1%) | 89 (2.7%) | 47 (1.5%) | 24 (1.1%) | 38 (1.4%) ; MON_AUTO_CHARGE | 10 (3.1%) | 98 (2.9%) | 57 (1.7%) | 18 (0.6%) | 13 (0.6%) | 33 (1.2%) ; MON_CANCEL_TROUBLE | 3 (0.9%) | 11 (0.3%) | 10 (0.3%) | 12 (0.4%) | 8 (0.4%) | 29 (1.0%) ; MON_FREE_LIMIT | 8 (2.5%) | 159 (4.7%) | 145 (4.3%) | 149 (4.7%) | 112 (5.1%) | 124 (4.4%) ; MON_FREE_CUT | 0 (0.0%) | 2 (0.1%) | 88 (2.6%) | 9 (0.3%) | 1 (0.0%) | 3 (0.1%) ; MON_PAYMENT_METHOD | 0 (0.0%) | 3 (0.1%) | 3 (0.1%) | 35 (1.1%) | 15 (0.7%) | 18 (0.6%) ; MON_PER_DEVICE | 0 (0.0%) | 27 (0.8%) | 24 (0.7%) | 2 (0.1%) | 2 (0.1%) | 4 (0.1%) ; BUG_PURCHASE | 4 (1.3%) | 23 (0.7%) | 57 (1.7%) | 14 (0.4%) | 19 (0.9%) | 25 (0.9%) ; BUG_CRASH | 13 (4.1%) | 25 (0.7%) | 49 (1.5%) | 27 (0.9%) | 58 (2.6%) | 43 (1.5%) ; BUG_UPDATE | 6 (1.9%) | 5 (0.1%) | 46 (1.4%) | 4 (0.1%) | 20 (0.9%) | 22 (0.8%) ; BUG_RECURRING | 1 (0.3%) | 4 (0.1%) | 8 (0.2%) | 1 (0.0%) | 15 (0.7%) | 8 (0.3%) ; BUG_CALENDAR | 0 (0.0%) | 7 (0.2%) | 2 (0.1%) | 18 (0.6%) | 23 (1.0%) | 1 (0.0%) ; BUG_PERF | 0 (0.0%) | 9 (0.3%) | 0 (0.0%) | 0 (0.0%) | 15 (0.7%) | 12 (0.4%) ; BUG_WIDGET | 2 (0.6%) | 17 (0.5%) | 34 (1.0%) | 8 (0.3%) | 18 (0.8%) | 21 (0.8%) ; BUG_REMINDER | 1 (0.3%) | 18 (0.5%) | 22 (0.7%) | 14 (0.4%) | 16 (0.7%) | 25 (0.9%) ; U_DATA_RISK | 6 (1.9%) | 31 (0.9%) | 15 (0.4%) | 17 (0.5%) | 13 (0.6%) | 22 (0.8%) ; REQ_DESKTOP | 19 (6.0%) | 89 (2.7%) | 33 (1.0%) | 20 (0.6%) | 13 (0.6%) | 34 (1.2%) ; REQ_WEB | 10 (3.1%) | 33 (1.0%) | 20 (0.6%) | 19 (0.6%) | 11 (0.5%) | 11 (0.4%) ; REQ_WATCH | 15 (4.7%) | 57 (1.7%) | 5 (0.1%) | 0 (0.0%) | 3 (0.1%) | 1 (0.0%) ; REQ_TIME | 8 (2.5%) | 38 (1.1%) | 29 (0.9%) | 39 (1.2%) | 22 (1.0%) | 50 (1.8%) ; REQ_SORT | 5 (1.6%) | 34 (1.0%) | 30 (0.9%) | 27 (0.9%) | 14 (0.6%) | 22 (0.8%) ; REQ_BACKFILL | 3 (0.9%) | 13 (0.4%) | 10 (0.3%) | 8 (0.3%) | 7 (0.3%) | 21 (0.8%) ; REQ_PHOTO | 9 (2.8%) | 24 (0.7%) | 37 (1.1%) | 17 (0.5%) | 17 (0.8%) | 20 (0.7%) ; REQ_STATS | 7 (2.2%) | 33 (1.0%) | 11 (0.3%) | 16 (0.5%) | 12 (0.5%) | 35 (1.3%) ; REQ_SHARED | 5 (1.6%) | 20 (0.6%) | 13 (0.4%) | 11 (0.3%) | 6 (0.3%) | 10 (0.4%) ; NEG_UI_CONFUSING | 3 (0.9%) | 41 (1.2%) | 30 (0.9%) | 21 (0.7%) | 19 (0.9%) | 38 (1.4%) ; NEG_DEV_PROMISE | 1 (0.3%) | 8 (0.2%) | 15 (0.4%) | 19 (0.6%) | 15 (0.7%) | 30 (1.1%) ; SUP_NONE | 1 (0.3%) | 6 (0.2%) | 19 (0.6%) | 11 (0.3%) | 6 (0.3%) | 21 (0.8%) ; REV_SOLICITED | 0 (0.0%) | 53 (1.6%) | 70 (2.1%) | 65 (2.1%) | 52 (2.4%) | 69 (2.5%) ; U_CHURN | 8 (2.5%) | 36 (1.1%) | 74 (2.2%) | 16 (0.5%) | 15 (0.7%) | 34 (1.2%) ; NOISE | 1 (0.3%) | 6 (0.2%) | 15 (0.4%) | 31 (1.0%) | 27 (1.2%) | 23 (0.8%) ; WRONG_APP | 1 (0.3%) | 19 (0.6%) | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 0 (0.0%)

- **Where:** §7.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** era segment rates
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-097 — Yearly series (verbatim): Year | Reviews | Mean ★ | 1–2★ | 5★ | Price objection | Billing | Bugs | Platform request | Schedule request | Burst-day reviews ; 2018 | 23 | 4.87 | 0 | 20 | 0 | 0 | 2 | 1 | 1 | 0 ; 2019 | 296 | 4.21 | 35 | 187 | 19 | 25 | 38 | 45 | 24 | 0 ; 2020 | 3356 | 4.62 | 195 | 2708 | 266 | 144 | 162 | 168 | 123 | 209 ; 2021 | 2822 | 4.48 | 256 | 2165 | 284 | 131 | 236 | 54 | 75 | 92 ; 2022 | 2564 | 4.69 | 93 | 2083 | 203 | 45 | 87 | 26 | 78 | 0 ; 2023 | 2589 | 4.67 | 110 | 2109 | 168 | 36 | 157 | 33 | 70 | 23 ; 2024 | 1848 | 4.63 | 106 | 1507 | 133 | 54 | 116 | 34 | 49 | 0 ; 2025 | 1150 | 4.59 | 75 | 918 | 66 | 39 | 63 | 16 | 36 | 0 ; 2026 | 528 | 4.61 | 32 | 425 | 30 | 11 | 40 | 8 | 15 | 0 || Months with ≥250 reviews (verbatim): Month | Reviews | Mean ★ | 1–2★ | 5★ | Billing | Crash / update | Free cut | Long-term users ; 2020-01 | 310 | 4.73 | 13 | 269 | 5 | 1 | 1 | 3 ; 2020-04 | 362 | 4.70 | 14 | 302 | 11 | 1 | 0 | 0 ; 2020-05 | 319 | 4.64 | 15 | 259 | 11 | 3 | 1 | 2 ; 2020-06 | 267 | 4.54 | 20 | 208 | 17 | 0 | 0 | 0 ; 2020-07 | 286 | 4.51 | 21 | 209 | 13 | 2 | 0 | 3 ; 2020-08 | 265 | 4.57 | 21 | 217 | 14 | 3 | 0 | 0 ; 2020-09 | 268 | 4.61 | 16 | 215 | 9 | 6 | 0 | 0 ; 2020-10 | 261 | 4.61 | 15 | 208 | 15 | 0 | 0 | 1 ; 2020-11 | 293 | 4.57 | 21 | 235 | 16 | 9 | 0 | 1 ; 2021-01 | 372 | 4.38 | 40 | 270 | 34 | 14 | 28 | 7 ; 2021-02 | 258 | 4.60 | 19 | 212 | 10 | 2 | 6 | 3 ; 2021-03 | 266 | 4.19 | 46 | 186 | 22 | 9 | 39 | 2 ; 2021-09 | 287 | 4.47 | 27 | 220 | 8 | 7 | 3 | 4 ; 2021-10 | 285 | 4.29 | 36 | 199 | 10 | 42 | 1 | 5 ; 2021-11 | 255 | 4.61 | 15 | 206 | 7 | 2 | 0 | 3 ; 2022-01 | 300 | 4.63 | 14 | 235 | 6 | 2 | 1 | 5 ; 2023-01 | 280 | 4.73 | 8 | 231 | 3 | 3 | 1 | 3 ; 2023-10 | 260 | 4.67 | 9 | 208 | 4 | 10 | 0 | 8

- **Where:** §7.3 tables (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2020 peak 3,356; 2026 528
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-098 — E1 launch year (319 reviews, 4.25★, the lowest): a small early base writing long request-heavy reviews (U_REQ_ANY 42.0%, the highest era) above all for desktop or web (U_PLATFORM_REQ 14.4%); praise the lowest (64.3%); early users from the developer's vc.ru article. E2 2020 growth wave (3,356, 4.62★): volume from 37 a month to 310 in one month and near 300 since; the rating prompt starts (REV_SOLICITED 1.6%); trial and charge complaints peak (MON_TRIAL 3.1%, MON_AUTO_CHARGE 2.9%); the Mac app ships 2020-06 sold separately (MON_PER_DEVICE 0.8%, peak); a Korean cluster about another app on 2020-04-05 — a guilt-trip prompt coincides with a 10× volume jump

- **Where:** §7.4 E1–E2
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** E1 4.25★; E2 volume ×8
- **Direction for us:** none · **Report confidence:** era segment rates · **Generalisable:** app-specific
- **Canonical:** C044 Mac / desktop / web app; C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R59-099 — E3 (3,341 reviews, 4.50★): the 2021-01 update caps the free tier and drops unlocks (MON_FREE_CUT 2.6%, BUG_PURCHASE 1.7%, era peaks); 2021-01 busiest month (372); 2021-10 an update leaves older iPhones unable to open the app (BUG_UPDATE 1.4%, BUG_CRASH 1.5%); price objection (10.1%) and churn (2.2%) peak. E4 (3,153, 4.70★, the highest era mean): the calmest era — praise at its maximum (80.3%), defects at minimum (3.5%); the defining complaint is not the product — Russian users cannot pay (MON_PAYMENT_METHOD 1.1%, peak), support arranges card or carrier payment case by case; Trello and Notion users arrive after those services leave Russia — a release-quiet era is the best-rated era

- **Where:** §7.4 E3–E4
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** E3 4.50★ vs E4 4.70★
- **Direction for us:** none · **Report confidence:** era segment rates · **Generalisable:** generalisable
- **Canonical:** C005 Know which competitors buyers compare against; C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C104 Never ship a paywall or feature-removal change silently; C175 Updates must not break function or wipe progress; C191 Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled

### R59-100 — E5 (2,210, 4.64★): three regression clusters in six months — recurring-task crash from 2023-06 (BUG_RECURRING 0.7%), calendar a year back from 2023-08 (BUG_CALENDAR 1.0%), freezes 2023-10 (BUG_PERF 0.7%), crash rate highest since launch (2.6%); monthly volume begins to fall. E6 (2,797, 4.62★, 96 a month): fewer, longer reviews from veterans (TENURE_LONG 4.3%, peak); payment through a Russian card now praised while charges after cancellation persist (MON_AUTO_CHARGE 1.2%, MON_CANCEL_TROUBLE 1.0% — its peak); dominant requests a task time (1.8%), marking yesterday done (0.8%) and statistics (1.3%); dominant criticism that nothing changes (NEG_DEV_PROMISE 1.1%) and that support does not answer (SUP_NONE 0.8%); a launch-crash cluster in 2026-05

- **Where:** §7.4 E5–E6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** E5 crash 2.6%; E6 cancel trouble 1.0%
- **Direction for us:** none · **Report confidence:** era segment rates · **Generalisable:** generalisable
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C071 Never ship and walk away; C112 In-app cancellation; C175 Updates must not break function or wipe progress; C196 A subscription is a promise of continued delivery — back it with a visible cadence

### R59-101 — What persisted in every era: ease and simplicity praise (U_EASE 29.1–34.3%); the free-tier cap objection (MON_FREE_LIMIT 2.5–5.1%); unexpected charges (MON_AUTO_CHARGE 0.6–3.1%); a time on the task (REQ_TIME 0.9–2.5%); a desktop version (REQ_DESKTOP 0.6–6.0%); reminders that do not fire (BUG_REMINDER 0.3–0.9%); the rating prompt from 2020 (REV_SOLICITED up to 2.5%)

- **Where:** §7.5
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** seven persistent themes
- **Direction for us:** none · **Report confidence:** era segment rates · **Generalisable:** generalisable
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C039 Reminders fire reliably, once; C044 Mac / desktop / web app; C109 A free trial must be a real trial

## Positioning

### R59-001 — Tappsk - ToDo & Habit Tracker (App Store ID 1385049326) by MATVEY KONDAKOV (com.tappsk.ios), Productivity / Lifestyle — a daily to-do list with a habit tracker on the same screen; free download with a capped free tier, Premium sold monthly, annually and as a one-time lifetime unlock, 7-day trial, frequent lifetime discounts; 15,176 reviews all read and hand-coded, 2018-10-14 → 2026-09-05 (just under eight years), 109 storefronts, 24 languages plus emoji-only (Russian 11,548, English 1,457, Portuguese 578, German 347, French 323, Arabic 202, Spanish 128, Ukrainian 115), corpus mean 4.60★

- **Where:** header lines 1-5
- **This app does:** tasks + habits on one screen; freemium with lifetime unlock
- **User reaction:** praise
- **Magnitude:** 15,176 reviews; mean 4.60
- **Direction for us:** none · **Report confidence:** corpus-level fact · **Generalisable:** app-specific
- **Review IDs:** `3300153411`
- **Canonical:** C050 One-off to-dos alongside habits

### R59-055 — Churn, switching and competition (verbatim): Code | Dir | Meaning | n | % of 15,176 | Band | Mean ★ | Dates ; CHURN_DELETE | - | Deleted / stopped | 84 | 0.55% | Emerging signal | 1.75 | 2019-03-26 → 2025-08-11 ; CHURN_RISK | - | May leave | 56 | 0.37% | Weak signal | 3.29 | 2019-03-12 → 2026-05-20 ; CHURN_SWITCHED | - | Uses another app instead | 43 | 0.28% | Weak signal | 2.49 | 2019-10-02 → 2026-04-29 ; CHURN_RETURN | + | Came back | 36 | 0.24% | Weak signal | 4.50 | 2021-02-25 → 2025-12-10 ; COMP_MENTION | ~ | Names a competitor | 211 | 1.39% | Meaningful signal | 3.88 | 2019-03-06 → 2026-05-06 ; COMP_SWITCHED_FROM | + | Switched from a competitor | 110 | 0.72% | Emerging signal | 4.87 | 2019-05-04 → 2026-07-24 ; MKT_WOM | ~ | Word of mouth | 41 | 0.27% | Weak signal | 4.90 | 2020-02-02 → 2026-09-03 ; MKT_REVIEWS | ~ | App Store reviews | 20 | 0.13% | Weak signal | 3.85 | 2021-03-05 → 2026-03-26 ; MKT_BLOGGER | ~ | Blogger / YouTuber | 19 | 0.13% | Weak signal | 4.95 | 2020-03-30 → 2023-07-24 ; MKT_PRESS | ~ | Article / book | 13 | 0.09% | Ignore by default | 4.62 | 2019-03-06 → 2023-01-23 ; MKT_AD | ~ | Advertising | 9 | 0.06% | Ignore by default | 4.11 | 2020-03-16 → 2022-09-15 — switchers to Tappsk (COMP_SWITCHED_FROM 110, 0.72%, 4.87★) outnumber leavers to another app (CHURN_SWITCHED 43, 0.28%); they come from Notes and Reminders, paper, Todoist, Trello and Notion — the last two after those services left Russia ('После того как Trello стало невозможно пользоваться на территории России'; 'выбрал Tappsk после ухода Notion' — chose Tappsk after Notion left) — and from Things ('Desinstalei o Things por causa desse app'); leavers name TickTick and Things ('по итогу я пользуюсь TickTick')

- **Where:** §3.7 table (verbatim)
- **This app does:** n/a
- **User reaction:** switch-to
- **Magnitude:** switched-from 110 vs switched-to-other 43
- **Direction for us:** none · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `3304698631`, `10966052624`, `11752235590`, `12493280516`, `14007929696`, `11286087766`
- **Canonical:** C005 Know which competitors buyers compare against

## Anti-patterns

### R59-008 — The January-2021 free-tier cut and the update that locked paying users out: MON_FREE_CUT 103 (0.68%, Emerging, 2.21★, 2020-01-19 → 2025-10-10), 80 of 103 in 2021-01→04 — an update capped the free tier at 20 tasks (reviewers also report 10, 3 and '2 habits, 2 recurring'), removed free habits for some, and at the same time stopped recognising existing purchases (BUG_PURCHASE 45 in 2021-01→03, 57 in E3 = 1.7%, its peak); any price objection peaks (U_PRICE_OBJECTION 10.1% of E3), E3 has the lowest era mean after launch (4.50★); the second most-voted review (#4384, 94 votes) is this complaint; 2021-01 busiest month (372), churn peaks 2.2% — 'с бесплатной версии убрали привычки, раньше можно было использовать две, а теперь НИ ОДНОЙ' (habits removed from the free version; before two, now NONE); 'Разработчик ответил что их 50, но в приложении доступно лишь 20' (developer replied it is 50, but only 20 are available); 'Вы просите 2500₽ при покупке навсегда' (you ask 2,500 ₽ for lifetime); 'Я уже покупала платную версию на всегда, почему она слетела??' (I already bought forever, why has it dropped off??); 'премиум у меня куплен ещё с июля' (I have had premium since July)

- **Where:** §0.3; §7.4 E3
- **This app does:** cut the free tier and broke unlock recognition in the same update
- **User reaction:** 1★-burst
- **Magnitude:** 103 (0.68%); 80 in 2021-01→04; BUG_PURCHASE 57 in E3
- **Direction for us:** dont · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `5424921597`, `7057459407`, `7074918019`, `6828890559`, `6828852918`, `6845886967`, `6896799004`, `7021320461`, `7060798259`, `7120936666`, `7269069571`, `8936743115`, `13250040158`
- **Canonical:** C001 Never move a free feature behind the paywall; C104 Never ship a paywall or feature-removal change silently; C186 Never revoke what earlier buyers paid for when the model changes; C191 Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled

### R59-020 — Stagnation is itself a complaint: NEG_DEV_PROMISE 88 (0.58%, Emerging), rising to 1.1% of E6 — 'there were added zero new features'; 'Два года прошу добавить эту простую фичу' (I have been asking for this simple feature for two years, 1★); 'приложение вообще не меняется годами' (the app has not changed at all in years, 5★); REQ_TIME, REQ_BACKFILL, REQ_PHOTO, REQ_STATS and REQ_SHARED never stop across eight years; among purchasers NEG_DEV_PROMISE lifts 4.43×

- **Where:** §0.7; §3.5; §7.4 E6
- **This app does:** long-standing requests unaddressed
- **User reaction:** complaint
- **Magnitude:** 88 (0.58%); 1.1% of E6; 4.43× among purchasers
- **Direction for us:** dont · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `13879749140`, `10958883560`, `13057793501`
- **Canonical:** C071 Never ship and walk away; C196 A subscription is a promise of continued delivery — back it with a visible cadence

### R59-021 — The guilt-trip rating prompt ('пусть разработчики грустят' — let the developers be sad) is named in 2% of reviews from 2020 on: REV_SOLICITED 309 (2.04%, Meaningful, 4.77★, 2020-01-01 → 2026-07-19), none before 2020-01, then 1.6–2.5% of every era; reviewers quote the dismiss button as the reason they wrote ('Отдельный респект разработчикам за окно с отзывами'; 'adorei a estratégia para deixarmos a avaliação' — loved the strategy for getting us to leave a review); but 12 of 309 are 1–2★ reviews about the prompt itself ('это манипуляция эмоциями' — this is emotional manipulation; 'Хватит меня каждую секунду просить оставить отзыв' — stop asking me every second; 'Saudumme Formulierung' — idiotic wording) and it feeds distrust of other reviews (REV_DISTRUST 32: 'начитались купленных отзывов' — having read the bought reviews); experiment: keep the prompt but change the dismiss wording and suppress it after a purchase, a crash or a support ticket — hypothesis: same volume of 5★, fewer 1★ about the prompt, less bought-reviews suspicion

- **Where:** §0.8; §8.9; §9.H
- **This app does:** guilt-trip dismiss wording on rating prompt
- **User reaction:** mixed
- **Magnitude:** 309 (2.04%); 12 at 1–2★; distrust 32
- **Direction for us:** tactic · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Side effects:** inflates the praise share; manipulative-feeling to some
- **Review IDs:** `12468108128`, `6484666207`, `6709846085`, `5470893305`, `13827246849`, `13740181043`, `5347259262`, `7117266715`, `8050815628`, `8748522320`, `9564840255`, `10336469896`, `11232478136`, `14321673961`
- **Canonical:** C094 Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire; C150 Never ask for a rating before the user has used the app

### R59-042 — The upsell itself is a complaint: MON_UPSELL 97 (0.64%, Emerging, 3.33★) — 'Каждый день по 30 раз пихают мне всплывающее окошко «Купите нашу полную версию»' (thirty times a day they push the pop-up: buy our full version, 2★); Germany reports the upsell at 2.36×; lifts 2.44× among purchasers

- **Where:** §3.3
- **This app does:** frequent premium pop-ups
- **User reaction:** complaint
- **Magnitude:** 97 (0.64%)
- **Direction for us:** dont · **Report confidence:** Emerging signal · **Generalisable:** generalisable
- **Review IDs:** `10830000286`
- **Canonical:** C093 No upsell nagging without a 'never ask again' option

## Things not to do

### R59-014 — Do not re-price within days of a purchase: 'Kurz nach dem Kauf wurde der Preis durch einen Zufallsgenerator reduziert' (shortly after the purchase the price was reduced by a random generator, 4★); the same lifetime unlock is named at 449 ₽ and 2,500 ₽ within a year; show one price per region (MON_DISCLOSURE 80)

- **Where:** §0.5; §8.2
- **This app does:** random/seasonal lifetime discounts
- **User reaction:** complaint
- **Magnitude:** anecdotal; MON_DISCLOSURE 80
- **Direction for us:** dont · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `10839438623`
- **Canonical:** C092 Regional pricing; C113 One stable, disclosed price — no discount wheels

### R59-033 — Nothing extra — and users ask the developer not to change it: PR_SIMPLE 1,704 (11.23%) — 'Ничего лишнего. Удобно' (nothing superfluous. Convenient); 'отсутствуют ненужные мешающие опции, присущие аналогам' (the unneeded, obstructive options of the rivals are absent); PR_KEEP_SIMPLE 49 (0.32%, 4.96★) — the guard against bloat when adding task time or other requests; NEG_BLOAT only 5

- **Where:** §3.2 why it works; §8.5
- **This app does:** minimal option set
- **User reaction:** praise
- **Magnitude:** 1,704 (11.23%); keep-simple 49
- **Direction for us:** dont · **Report confidence:** High-priority signal · **Generalisable:** generalisable
- **Review IDs:** `8590926525`, `11022679672`
- **Canonical:** C006 Stay minimal — every addition is opt-in or off by default

### R59-050 — A productivity score demotivates some: NEG_SCORE 23 (0.15%) against PR_SCORE 84 — 'ОЧЕНЬ ДЕМОТИВИРУЕТ эта стрелочка которая показывает насколько я продуктивна' (this arrow showing how productive I am is VERY demotivating, 4★)

- **Where:** §3.5; §2.1
- **This app does:** daily productivity score with trend arrow
- **User reaction:** mixed
- **Magnitude:** negative 23 vs praise 84
- **Direction for us:** dont · **Report confidence:** Weak signal · **Generalisable:** generalisable
- **Review IDs:** `10957454552`
- **Canonical:** C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C217 An unexplained metric reads as broken — explain the score on-screen

## Things to do

### R59-104 — Immediate fix — honour every lifetime unlock, everywhere: restore from any receipt, on any device, on the Mac, after a reinstall, without an annual charge in between (BUG_PURCHASE 142, MON_PAID_TWICE 47); never show the lifetime buyer a subscription paywall; show one price per region and do not re-price within days of a purchase (MON_DISCLOSURE 80)

- **Where:** §8.2
- **This app does:** n/a
- **User reaction:** refund
- **Magnitude:** 142 + 47
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `5095024136`, `7466929882`, `12353908918`, `6828852918`, `8119749092`, `10839438623`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C113 One stable, disclosed price — no discount wheels; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C186 Never revoke what earlier buyers paid for when the model changes

### R59-105 — Immediate fixes — the regression pattern and the mailbox: a release check on the oldest supported iOS and on the show-completed-tasks path before shipping, a fast hotfix path (four clusters in three years, U_REGRESSION 296); widgets that refresh at day change without opening the app (BUG_WIDGET 100); route billing and sync tickets to the channel that answers (Telegram praised, e-mail condemned) and acknowledge bug reports with a status (SUP_NONE 64, NEG_DEV_PROMISE 88)

- **Where:** §8.3; §8.4
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 296; 100; 64 + 88
- **Direction for us:** do · **Report confidence:** report recommendation · **Generalisable:** generalisable
- **Review IDs:** `7941135777`, `10335459972`, `10383577572`, `10525597408`, `13688781045`, `14107533962`, `12401679164`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers; C040 Widgets must not go blank, stale or disagree with the app; C059 Be visibly responsive; fixes bring reviewers back; C156 Content and event releases need a crash gate across device generations; C175 Updates must not break function or wipe progress

## Contradictions

### R59-005 — Trial-charge complaints are not all the app's fault, but the app still takes the 1★: some are the reviewer's own missed cancellation ('забыла отменить подписку' — forgot to cancel the subscription, a 5★); 'списали деньги за приложение, которого у меня нет' (money was taken for an app I no longer have, 5★); support sometimes refunds ('Все вернули! Оперативно' — refunded everything, promptly) and sometimes does not ('Деньги, естественно, никто не возвращает' — naturally nobody returns the money, 1★)

- **Where:** §0.2
- **This app does:** support refunds case by case
- **User reaction:** mixed
- **Magnitude:** part of 229
- **Direction for us:** none · **Report confidence:** anecdotal within theme · **Generalisable:** generalisable
- **Review IDs:** `6516703708`, `6976074774`, `4861219077`, `4253774614`
- **Canonical:** C029 Billing must be exactly right; C212 No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request; C221 A receipt with a working product link after every charge, and a renewal reminder before it

### R59-064 — Rating-versus-text contradictions: CONTRA_RATING 155 (1.02%); 102 are 4–5★ reviews whose text reports a problem (BUG_CRASH 29, MON_AUTO_CHARGE 24, MON_REFUND 21, BUG_UPDATE 14) — 'Возможно ли вернуть деньги после списания' (is it possible to get the money back after the charge, 5★); 'при открытии выкидывает и не заходит' (on opening it throws me out, 4★); 20 are 1–2★ reviews whose text is praise or a request ('Все удобно и интуитивно понятно, мне очень комфортно пользоваться! Рекомендую', 1★); the rest are 3★ pure praise; all kept and coded by text — high star counts hide support tickets, so star-filtered monitoring misses refund requests

- **Where:** §4.3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 155 (1.02%); 102 high-star problems
- **Direction for us:** none · **Report confidence:** Meaningful signal · **Generalisable:** generalisable
- **Review IDs:** `6516703708`, `14096098531`, `12623571929`, `3948836465`, `4053184502`, `10335459972`, `10957454552`, `14094462568`
- **Canonical:** C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R59-109 — A lifetime model generates recurring billing risk: the one-time unlock is praised 93 times against 23 subscription objections and sells on discount, yet its buyers carry the highest problem lifts (BUG_PURCHASE 8.43×, MON_PAID_TWICE 8.89×, SUP_NONE 6.09× among purchasers) because the same app also runs annual subscriptions and a 7-day trial that can be charged against a lifetime customer — selling both lifetime and subscription SKUs requires entitlement logic that never lets a subscription paywall or charge reach a lifetime owner

- **Where:** §8.2; §5.2; §0.5
- **This app does:** lifetime + subscription + trial side by side
- **User reaction:** mixed
- **Magnitude:** praise 93 vs PAID_TWICE lift 8.89×
- **Direction for us:** must-never-break · **Report confidence:** segment rates · **Generalisable:** generalisable
- **Review IDs:** `7466929882`, `5095024136`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C033 Restore purchase and entitlements must work immediately; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps

## Data caveats and method

### R59-002 — Method: every quantified claim carries count, percentage, denominator, scope, period, band and IDs; theme counts non-exclusive; §10 complete per-review index; review IDs shown as review_id and #position in date order; quotations verbatim with translations; global percentages use all 15,176. Reconciliation (verbatim script output): 15,176 records, 15,176 distinct IDs, 0 duplicates, 0 exact content duplicates, 21 repeat storefront+author, 28 authors on more than one storefront, 109 by_country files summing to 15,176, manifest totals / per-country / rating distribution {1: 674, 2: 228, 3: 481, 4: 1671, 5: 12122} all match, mean 4.6038, _state 130 storefronts probed all complete, 21 zero-review fronts, all 13 fields present, 0 empty title/body, 996 edited, 371 with votes (max 156). Processing: 59-dump.py in date order; batches of 100 (152 classification files); hand codes plus quoted-note per review; 59-check-cls.py after every batch re-asserts ID at index and every quoted fragment; 59-fill-ids.py fills IDs from the index so IDs cannot drift; 59-build-classification.py rejects unknown codes, adds STAR_n / ERA_En and 20 unions; 59-build-report.py refuses to write if any quotation is not verbatim and asserts every trend direction; 59-verify-report.py re-reads the written file; no clustering, keyword rule or model assigned a code

- **Where:** §How to read this; §1.3; §1.4
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 15,176/15,176 read and hand-coded (100%)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-003 — Warnings: a praise corpus and a Russian one — 5★ 12,122 (79.88%), 1–2★ 902 (5.94%), any-praise 76.58%; the Russian storefront holds 10,667 (70.29%) and 11,548 (76.09%) are written in Russian, so global bands are Russian-speaking bands; eight years and several pricing regimes (2021-01 free-tier cut, App Store payment unavailable to most Russian users from 2022-03, a direct-card checkout later) so themes are dated and §7 separates six eras; 3,701 bodies (24.39%) ≤30 characters, many only PR_GENERIC or PR_EASY; NOISE 103 carry no usable content; WRONG_APP 20 describe another product; CONTRA_RATING 155 (1.02%) coded by text and several 5★ reviews are refund tickets; codes are hand judgement; outcomes and purchases self-reported. Limitations: selection (satisfied users prompted, dissatisfied write when something breaks or a card is charged — neither measures typical use); purchases unverifiable; no version data; thin late corpus (monthly volume falls from a 2021-01 peak of 372 to under 100 through 2026); language mix (22 other languages carry 2,061; 110 emoji/symbols only)

- **Where:** Seven warnings 1–2, 5–7; §1.6
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 79.88% 5★; 70.29% ru storefront
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** generalisable
- **Canonical:** — (nuance register)

### R59-022 — Bursts are disclosed, not dropped: 14 days carry 20+ reviews (324 reviews, 2.13%), 77.5% of them 5★; two are not praise bursts — 2021-01-04 (28 reviews, 13 purchase failures) and 2021-03-03 (22 reviews, 10 the free-tier cut); one is an artefact — on 2020-04-05, 19 Korean-storefront 5★ reviews describe an RPG game, not this app (WRONG_APP 20; '뻔한 RPG게임이지만 그래도 뻔해서 좋네' — a predictable RPG, but good), kept and coded WRONG_APP only; removing burst days moves no headline by more than 0.2 points

- **Where:** §0.8; §7.6; §9.H
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 14 days / 324 reviews (2.13%)
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** generalisable
- **Review IDs:** `5765513375`
- **Canonical:** — (nuance register)

### R59-023 — Files used (verbatim): File | Role | Records ; App Store Reviews/59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule/reviews.jsonl | the corpus; every claim resolves here | 15,176 ; by_country/*.jsonl | 109 per-storefront files | 15,176 (union) ; manifest.json | extraction metadata, per-country counts, rating distribution | — ; _state.json | collection state per polled storefront | — ; Apple iTunes Lookup API (external, 2026-09-14) | public rating, listing text, version, languages | 19 storefronts || Schema (verbatim): Field | Used for | Notes ; review_id | primary key | 15,176 distinct; zero duplicates ; country, country_name | §6 | 109 storefronts ; rating | §4 | integers 1–5 only ; title, body | read in full for every record | median body length 72 characters ; author | authenticity tests only (§9.H) | 28 names appear on more than one storefront ; date | §7 | 2018-10-14 → 2026-09-05 ; vote_count, vote_sum | §9.H | 371 reviews have votes; max 156 ; is_edited | §9.H | 996 edited ; app_id, app_name | constant (1385049326, Tappsk: ToDo & Habit Tracker) | — not present and never claimed: app version per review, purchase or subscription records, developer responses, device, any identifier linking a reviewer to a purchase

- **Where:** §1.1 table (verbatim); §1.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 13 fields; 15,176 records
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-024 — Signal thresholds (verbatim): Share of reviews | Label ; < 0.1% | Ignore by default ; 0.1% – < 0.5% | Weak signal ; 0.5% – < 1% | Emerging signal ; 1% – < 3% | Meaningful signal ; 3% – 5% | Very strong signal ; > 5% | High-priority signal; at n=15,176, 0.1% ≈ 15, 1% ≈ 152, 5% ≈ 759; segment rates labelled and show both denominators

- **Where:** §1.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** bands
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-026 — Store listing (external, Apple Lookup API, 2026-09-14), verbatim: Storefront | Public mean ★ | Ratings | Corpus reviews | Corpus mean ★ | Corpus mean ★ in E6 ; ru | 4.75 | 32,119 | 10667 | 4.61 | 4.59 ; ua | 4.79 | 3,508 | 824 | 4.67 | 4.65 ; br | 4.77 | 2,400 | 583 | 4.71 | 4.81 ; de | 4.57 | 1,098 | 332 | 4.55 | 4.58 ; us | 4.70 | 1,041 | 311 | 4.53 | 4.58 ; fr | 4.59 | 932 | 279 | 4.53 | 4.53 ; kz | 4.83 | 832 | 247 | 4.78 | 4.81 ; sa | 4.60 | 777 | 220 | 4.61 | 4.68 ; gb | 4.56 | 446 | 163 | 4.48 | 4.12 ; tr | 4.49 | 434 | 134 | 4.13 | 4.17 ; ca | 4.67 | 338 | 102 | 4.55 | 4.54 ; au | 4.57 | 316 | 96 | 4.42 | 4.08 ; by | 4.88 | 297 | 81 | 4.79 | 5.00 ; ch | 4.62 | 256 | 72 | 4.50 | 4.70 ; se | 4.44 | 231 | 65 | 4.08 | 4.33 ; in | 4.72 | 187 | 53 | 4.51 | 4.62 ; it | 4.49 | 170 | 57 | 4.53 | 4.80 ; es | 4.68 | 157 | 57 | 4.67 | 4.62 ; mx | 4.81 | 150 | 56 | 4.79 | 4.67 — title 'Tappsk: ToDo & Habit Tracker' (ru: 'Tappsk: ежедневник планировщик'); age 4+; released 2018-10-13 (ru) / 2018-12-19 (us); version 2.6.2 dated 2026-08-09; min iOS 15.1; mission to replace a planner, habit tracker, reminder app and calendar with one app; lists swipe-to-reschedule, habits, day calendar, reminders that repeat until acted on, voice entry, sharing a task to a friend's Tappsk, subtasks, routine suggestions, hidden lists, logbook; Premium = unlimited recurring tasks, habits and reminders; support e-mail and Telegram chat; 17 declared languages but not Ukrainian or Kazakh; public mean above corpus mean in 17 of 19 storefronts, by up to 0.36 (se); listing text not used as evidence

- **Where:** §2.2 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 19 storefronts
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-065 — Paid-user populations and what they are not: stated purchase MON_PAID 1,090 (7.18%, 4.31★), of whom MON_LIFETIME 396; stated purchase, charge, refund or unlock problem U_PAID 1,408 (9.28%, 3.85★); on the trial MON_TRIAL 306 (2.02%, 3.14★ — low because 111 report an immediate charge; 51 state intent to buy); intent MON_INTENT 381 (2.51%, 4.70★); worth it without saying they bought 286; upgrade barrier U_PRICE_OBJECTION 1,169 (7.70%, 3.56★); none of these is a conversion rate — cannot say how many pay, renew or are refunded (§5.7: nor the lifetime/subscription split, whether immediate trial charges are systematic, regional prices, refunds granted)

- **Where:** §5.1; §5.7
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 1,090 / 1,408 / 306 / 381 / 1,169
- **Direction for us:** none · **Report confidence:** method statement · **Generalisable:** app-specific
- **Canonical:** — (nuance register)

### R59-093 — Storefront is not language (verbatim): Language | Reviews | Storefronts (reviews) ; Russian (ru) | 11548 | ru (10424), ua (593), kz (203), by (69), us (59), kg (31), uz (30), pl (15) ; English (en) | 1457 | us (235), ru (166), gb (159), ua (107), au (94), ca (87), in (53), sa (49) ; Portuguese (pt) | 578 | br (567), pt (7), pl (1), us (1), se (1), ao (1) ; German (de) | 347 | de (277), at (35), ch (34), ru (1) ; French (fr) | 323 | fr (266), be (23), ch (17), ca (11), sn (2), dz (1), gb (1), cm (1) ; Arabic (ar) | 202 | sa (169), us (13), ae (8), kw (4), om (2), qa (2), ru (1), ye (1) ; Spanish (es) | 128 | mx (52), es (45), co (5), cl (5), ec (3), ar (3), pe (3), cr (2) ; Ukrainian (uk) | 115 | ua (111), uz (1), cz (1), pl (1), sk (1) ; Emoji / symbols only (zz) | 110 | ru (71), ua (13), kz (7), de (4), pl (3), br (3), az (1), sa (1) ; Turkish (tr) | 108 | tr (102), az (2), gb (1), de (1), us (1), kz (1) ; Swedish (sv) | 50 | se (50) ; Italian (it) | 48 | it (47), no (1) ; Chinese (zh) | 47 | cn (32), tw (11), hk (3), us (1) ; Dutch (nl) | 41 | nl (34), be (7) ; Korean (ko) | 40 | kr (40) ; Japanese (ja) | 9 | jp (9) ; Kazakh (kk) | 7 | kz (6), ru (1) ; Norwegian (no) | 5 | no (5) ; Polish (pl) | 5 | pl (4), is (1) ; Hebrew (he) | 3 | il (3) ; Croatian (hr) | 1 | ba (1) ; Indonesian (id) | 1 | id (1) ; Finnish (fi) | 1 | fi (1) ; Uzbek (uz) | 1 | uz (1) ; Vietnamese (vi) | 1 | vn (1) — Russian written from 46 storefronts (59 reviews on US, 12 on DE); English from 94

- **Where:** §6.23 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** language table
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Canonical:** C027 Localise early — it unlocks revenue

### R59-094 — Storefronts below 50 reviews — limited evidence, included in every global figure, not standalone (verbatim): Storefront | Reviews | Mean ★ | E6 | Top codes | IDs (up to 3) ; nl | 46 | 4.24 | 6 | PR_EASY 11, MON_FREE_LIMIT 7, PR_GENERIC 7, MON_PAID 4 | 5526248449, 8988006632, 13633452336 ; at | 44 | 4.66 | 4 | PR_GENERIC 10, OUT_PRODUCTIVE 8, PR_EASY 7, PR_SIMPLE 6 | 6371026354, 9120967403, 14188396413 ; kr | 42 | 4.26 | 3 | WRONG_APP 19, MON_REFUND 5, BUG_CRASH 4, BUG_REMINDER 4 | 5765513375, 6427912738, 11824625820 ; be | 42 | 4.45 | 4 | PR_EASY 11, PR_GENERIC 8, MON_FREE_LIMIT 4, PR_DESIGN 4 | 6475747173, 9492757163, 13466721523 ; pl | 40 | 4.60 | 16 | PR_EASY 10, PR_GENERIC 8, PR_BEST 7, PR_BETTER_THAN 6 | 5631885223, 9665860751, 14006523892 ; uz | 34 | 4.85 | 6 | PR_GENERIC 9, PR_EASY 9, PR_DEV 9, PR_BEST 4 | 5354117117, 9239245691, 14113015888 ; cn | 33 | 4.27 | 4 | PR_SIMPLE 6, PR_GENERIC 5, MON_PAID 4, PR_DESIGN 3 | 5201702493, 6949603010, 14364909972 ; kg | 33 | 4.97 | 8 | PR_EASY 10, PR_BEST 7, PR_GENERIC 6, PR_BETTER_THAN 5 | 5428286652, 9831638946, 14000120903 ; ae | 32 | 4.69 | 13 | PR_EASY 8, OUT_PRODUCTIVE 6, JUST_STARTED 3, PR_BETTER_THAN 3 | 5811947052, 9451241601, 14094462568 ; il | 25 | 4.36 | 5 | PR_GENERIC 6, PR_BEST 4, PR_EASY 4, PR_DESIGN 3 | 5203285112, 9147711841, 13467944166 ; no | 23 | 4.78 | 3 | PR_SIMPLE 5, PR_EASY 5, PR_GENERIC 3, OUT_MEMORY 3 | 8131770429, 9523283675, 14068529725 ; az | 19 | 4.68 | 3 | PR_EASY 6, PR_GENERIC 6, PR_MOTIVATION 2, OUT_PRODUCTIVE 2 | 5542585753, 8393545387, 14090459243 ; lv | 18 | 4.72 | 1 | PR_GENERIC 8, PR_EASY 5, MON_FREE_LIMIT 3, JUST_STARTED 2 | 5534567050, 7000723574, 12607928057 ; vn | 15 | 4.80 | 3 | PR_GENERIC 6, PR_EASY 3, PR_SIMPLE 3, MON_PRICE 2 | 5622374732, 6688103641, 13522315108 ; am | 13 | 4.69 | 8 | PR_EASY 3, PR_BEST 3, PR_BETTER_THAN 3, PR_DESIGN 2 | 3761571855, 11508456668, 14401837696 ; tw | 13 | 4.23 | 4 | PR_SIMPLE 5, PR_EASY 3, PR_DESIGN 2, PR_BETTER_THAN 2 | 5349517331, 9040266362, 14364480983 ; cz | 12 | 4.83 | 2 | PR_GENERIC 4, PR_DEV 2, JUST_STARTED 2, PR_DESIGN 2 | 5525868836, 9600254038, 12479269454 ; fi | 12 | 4.50 | 2 | PR_GENERIC 3, MON_FREE_LIMIT 2, PR_BETTER_THAN 2, PR_BEST 2 | 5591511243, 10392833192, 11769640964 ; ng | 12 | 4.83 | 5 | PR_GENERIC 3, OUT_PRODUCTIVE 3, PR_DESIGN 3, PR_EASY 3 | 7222129460, 10892104605, 13144563659 ; ph | 11 | 4.73 | 2 | PR_BETTER_THAN 3, PR_EASY 2, PR_REMINDERS 2, PR_BEST 2 | 6202816983, 7690667572, 13027256480 ; id | 10 | 4.50 | 3 | PR_RECOMMEND 3, PR_REMINDERS 2, PR_BETTER_THAN 2, OUT_HABIT 1 | 4987246428, 7359569279, 11546607326 ; sg | 10 | 4.10 | 1 | PR_GENERIC 3, MON_FREE_LIMIT 2, MON_PRICE 2, PR_EASY 2 | 5367783826, 6549938569, 11308419849 ; jp | 10 | 3.70 | 2 | MON_FREE_LIMIT 4, PR_EASY 3, MON_PAID 2, REV_UPDATED 2 | 6179064887, 7753674778, 14093472630 ; za | 9 | 4.56 | 1 | PR_DESIGN 2, PR_GENERIC 2, PR_SIMPLE 1, PR_ALLINONE 1 | 6452208738, 9083056005, 12350619533 ; dk | 9 | 4.56 | 2 | PR_GENERIC 2, PR_BEST 2, PR_EASY 2, PR_FREE 2 | 6683666734, 8676600057, 12270896171 ; hk | 9 | 4.67 | 3 | PR_SIMPLE 3, PR_GENERIC 2, REQ_PHOTO 1, PR_BETTER_THAN 1 | 7221471262, 9888974770, 13825040488 ; pt | 9 | 4.56 | 2 | PR_GENERIC 3, PR_EASY 3, MON_PRICE 1, MON_FREE_LIMIT 1 | 7868769370, 9860930436, 14362264720 ; eg | 9 | 4.56 | 4 | PR_GENERIC 4, MON_FREE_LIMIT 2, PR_SUBTASKS 1, PR_EASY 1 | 8171821300, 9634692469, 13989658319 ; ie | 8 | 4.50 | 2 | PR_EASY 2, OUT_MEMORY 2, PR_HABITS 1, NEG_UI_CONFUSING 1 | 5797411695, 10806454710, 12184844915 ; co | 8 | 4.25 | 1 | PR_EASY 2, PR_GENERIC 2, MON_FREE_LIMIT 2, PR_DESIGN 1 | 6170168806, 8225984208, 11453966067 ; ee | 7 | 4.43 | 1 | PR_EASY 2, NEG_PERMISSION 1, CHURN_DELETE 1, MON_UPSELL 1 | 5535767219, 9469129194, 12557630227 ; nz | 7 | 4.71 | 0 | PR_EASY 4, PR_DESIGN 3, PR_SIMPLE 2, REQ_TIME 1 | 5925475641, 7836136651, 9479780499 ; th | 7 | 5.00 | 3 | TENURE_LONG 2, OUT_LIFE 1, PR_GENERIC 1, PR_PERF 1 | 6187876674, 9093845624, 14260063138 ; bg | 7 | 5.00 | 2 | PR_GENERIC 2, PR_BETTER_THAN 2, PR_ALLINONE 1, PR_SIMPLE 1 | 6638153454, 10885086803, 13339046740 ; md | 6 | 5.00 | 2 | OUT_PRODUCTIVE 3, PR_DEV 1, MON_PAID 1, MON_VALUE 1 | 5751621213, 6825503414, 13167866328 ; rs | 6 | 4.67 | 4 | PR_DESIGN 3, PR_EASY 3, MON_ONETIME_PRAISE 1, MON_VALUE 1 | 6303750653, 11317380728, 12728156086 ; kw | 6 | 4.33 | 1 | PR_EASY 2, PR_GENERIC 2, REQ_CUSTOMIZE 1, PR_CUSTOM 1 | 6405699508, 7669738806, 11758391816 ; ge | 6 | 5.00 | 2 | PR_EASY 3, MON_PAID 2, PR_BEST 2, PR_BETTER_THAN 1 | 8214387735, 10275147821, 14309376928 ; qa | 6 | 4.83 | 3 | PR_EASY 2, PR_GENERIC 1, PR_BEST 1, PR_DEV 1 | 9136983788, 11004302830, 11473602666 ; ar | 5 | 5.00 | 2 | PR_SIMPLE 2, MON_TRIAL 1, OUT_PRODUCTIVE 1, PR_MOTIVATION 1 | 6169730897, 9165216075, 12676715332 ; my | 5 | 4.80 | 0 | OUT_PRODUCTIVE 1, PR_RECOMMEND 1, PR_DESIGN 1, PR_REMINDERS 1 | 6244523951, 8517342538, 10834968229 ; cl | 5 | 4.00 | 4 | NEG_UX 2, USE_WORK 1, NEG_DESIGN 1, OUT_PRODUCTIVE 1 | 9077581794, 11974820809, 12495560678 ; bw | 5 | 4.80 | 2 | PR_GENERIC 3, NEG_UI_CONFUSING 1, PR_DESIGN 1 | 9123828483, 10500805731, 13143902313 ; sk | 5 | 4.80 | 3 | PR_SIMPLE 1, PR_STICKY 1, JUST_STARTED 1, PR_BEST 1 | 10933477317, 11564655063, 13006323636 ; ro | 4 | 5.00 | 1 | PR_GENERIC 2, REQ_DESKTOP 1, REV_STAR_TACTIC 1, PR_BETTER_THAN 1 | 5256888194, 7792345632, 11295476388 ; lt | 4 | 4.75 | 2 | PR_BEST 1, PR_HABITS 1, OUT_LIFE 1, JUST_STARTED 1 | 5824155639, 11903003055, 13586456936 ; kh | 4 | 4.75 | 2 | PR_GENERIC 3, JUST_STARTED 1, PR_REMINDERS 1, PR_MOTIVATION 1 | 6361551162, 11266827355, 11442395521 ; lk | 4 | 4.75 | 1 | PR_EASY 3, PR_BETTER_THAN 2, PR_ALLINONE 1, PR_SIMPLE 1 | 6451763701, 8298289195, 12468744241 ; om | 4 | 4.75 | 2 | PR_GENERIC 2, PR_SIMPLE 1, OUT_PRODUCTIVE 1, USE_STUDY 1 | 7190308503, 12595501920, 13663991727 ; do | 4 | 5.00 | 2 | PR_BETTER_THAN 1, PR_PERF 1, PR_DEV 1, PR_GENERIC 1 | 10241312604, 11797369586, 12469986282 ; ec | 3 | 3.33 | 0 | PR_DESIGN 2, PR_GENERIC 1, PR_EASY 1, BUG_WIDGET 1 | 6169969874, 6750583677, 8232914905 ; pe | 3 | 5.00 | 1 | PR_EASY 3, PR_SIMPLE 2 | 6211290343, 8819180185, 11764422598 ; jo | 3 | 5.00 | 1 | PR_BETTER_THAN 2, PR_REMINDERS 1, OUT_PRODUCTIVE 1, PR_GENERIC 1 | 6551532503, 8594481858, 13998022042 ; gh | 3 | 4.33 | 2 | PR_GENERIC 1, PR_EASY 1, OUT_PRODUCTIVE 1 | 7893510038, 11479519899, 12660946751 ; is | 3 | 4.67 | 1 | PR_RECOMMEND 3, PR_STICKY 1, OUT_HABIT 1, PR_BETTER_THAN 1 | 8432992264, 9828590332, 11525699703 ; si | 2 | 5.00 | 0 | PR_SIMPLE 2, BUG_DATA_LOSS 1, JUST_STARTED 1, PR_EASY 1 | 6010807569, 6310021778 ; ba | 2 | 4.50 | 1 | MON_AUTO_CHARGE 1, MON_TRIAL 1, REQ_CUSTOMIZE 1, PR_DESIGN 1 | 6295860761, 12799466645 ; cr | 2 | 5.00 | 1 | PR_HAS_ALL 2, REQ_THEMES 1, PR_CUSTOM 1 | 6711669409, 12519914207 ; hu | 2 | 5.00 | 1 | PR_WIDGET 1, MON_VALUE 1, PR_BETTER_THAN 1, PR_MOTIVATION 1 | 7530735639, 12763147215 ; mt | 2 | 4.50 | 1 | OUT_PRODUCTIVE 1, PR_LISTS 1 | 9528050812, 12603582433 ; uy | 2 | 5.00 | 1 | PR_SIMPLE 2, PR_DEV 1, PR_EASY 1, PR_BETTER_THAN 1 | 10772134026, 11718063274 ; ke | 2 | 5.00 | 0 | OUT_PRODUCTIVE 1, PR_GENERIC 1 | 11088986769, 11134716730 ; sn | 2 | 5.00 | 2 | OUT_PRODUCTIVE 1, OUT_HABIT 1, PR_GENERIC 1 | 11617130995, 12615711434 ; tn | 2 | 5.00 | 2 | OUT_PRODUCTIVE 1, PR_HABITS 1, PR_DIARY 1, MON_FREE_LIMIT 1 | 11694547157, 12294919146 ; gr | 2 | 5.00 | 2 | PR_HAS_ALL 1, MON_PAID 1, MON_PER_DEVICE 1, CHURN_RISK 1 | 11703387168, 13296168593 ; pa | 1 | 4.00 | 0 | REQ_ADVANCE_REMINDER 1, PR_GENERIC 1 | 6193863954 ; mw | 1 | 4.00 | 0 | JUST_STARTED 1, PR_DIARY 1, PR_FREE 1 | 6258869552 ; pk | 1 | 5.00 | 0 | PR_BETTER_THAN 1, PR_HAS_ALL 1, PR_DESIGN 1, PR_DEV 1 | 6510911511 ; kn | 1 | 5.00 | 0 | PR_BEST 1, PR_EASY 1, PR_DESIGN 1 | 6686300301 ; ve | 1 | 5.00 | 0 | USE_STUDY 1, PR_GENERIC 1 | 6689005075 ; ma | 1 | 1.00 | 0 | MON_AUTO_CHARGE 1, MON_TRIAL 1 | 7339748310 ; dz | 1 | 5.00 | 0 | PR_GENERIC 1 | 7922272844 ; ye | 1 | 5.00 | 0 | REQ_CUSTOMIZE 1, USE_STUDY 1 | 8189009648 ; bh | 1 | 5.00 | 0 | PR_BEST 1, PR_SIMPLE 1 | 8284003906 ; tt | 1 | 5.00 | 0 | PR_SIMPLE 1, PR_EASY 1 | 8406411898 ; cy | 1 | 5.00 | 0 | PR_BEST 1, REQ_NOTES 1 | 8506570911 ; jm | 1 | 4.00 | 0 | PR_RECOMMEND 1 | 8632658780 ; vc | 1 | 5.00 | 0 | NOISE 1 | 8649189458 ; fj | 1 | 4.00 | 0 | PR_GENERIC 1 | 9279913750 ; ai | 1 | 5.00 | 0 | PR_BEST 1 | 9483868075 ; py | 1 | 5.00 | 0 | PR_GENERIC 1 | 9543364840 ; ne | 1 | 4.00 | 0 | NEG_LIMITED 1, PR_GENERIC 1 | 9732803416 ; cm | 1 | 5.00 | 0 | PR_GENERIC 1 | 10432763883 ; bo | 1 | 5.00 | 1 | PR_GENERIC 1 | 11351940878 ; hr | 1 | 5.00 | 1 | PR_EASY 1, PR_VOICE 1 | 11837836257 ; ao | 1 | 3.00 | 1 | PR_GENERIC 1, CONTRA_RATING 1 | 12247865759 ; al | 1 | 5.00 | 1 | PR_GENERIC 1 | 12518017272 ; hn | 1 | 5.00 | 1 | PR_GENERIC 1 | 12521511315 ; tm | 1 | 5.00 | 1 | JUST_STARTED 1, PR_DEV 1 | 12949822338 ; ly | 1 | 5.00 | 1 | PR_DEV 1 | 13972077310 — note: 19 of 42 Korean-storefront reviews describe a different app (an RPG) and are WRONG_APP; Korea's remainder follows the global profile with two reports of the habit-reminder crash also seen in Turkey; no other small storefront shows a material pattern

- **Where:** §6.24 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** 90 storefronts, 777 reviews
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** app-specific
- **Review IDs:** `5765513375`, `6427912738`, `11824625820`
- **Canonical:** — (nuance register)

### R59-102 — Sensitivity — do the bursts drive the conclusions? The 14 burst days hold 324 reviews. Table (verbatim): Headline share | All 15,176 | Without burst days (14,852) | Without the ru storefront (4,509) | E6 only (2,797) ; U_PRAISE_ANY | 76.6% | 76.8% | 76.8% | 72.6% ; U_EASE | 32.5% | 32.7% | 28.8% | 34.3% ; PR_ALLINONE | 1.9% | 1.9% | 2.5% | 1.5% ; U_PRICE_OBJECTION | 7.7% | 7.6% | 8.6% | 6.1% ; MON_FREE_LIMIT | 4.6% | 4.6% | 5.8% | 4.4% ; U_BILLING | 3.2% | 3.1% | 1.4% | 2.8% ; MON_AUTO_CHARGE | 1.5% | 1.5% | 0.6% | 1.2% ; U_BUG_ANY | 5.9% | 5.9% | 4.3% | 6.1% ; U_REGRESSION | 2.0% | 1.9% | 1.5% | 2.0% ; U_PLATFORM_REQ | 2.5% | 2.5% | 1.8% | 1.8% ; U_SCHEDULE_REQ | 3.1% | 3.1% | 1.8% | 3.2% ; U_HISTORY_REQ | 1.7% | 1.7% | 1.3% | 2.5% ; U_PAY_ACCESS | 0.7% | 0.7% | 0.0% | 1.0% ; REV_SOLICITED | 2.0% | 2.1% | 1.4% | 2.5% ; U_CHURN | 1.2% | 1.2% | 0.6% | 1.2% ; mean ★ | 4.60 | 4.61 | 4.59 | 4.62 — removing burst days moves no headline by more than 0.2 points; removing the Russian storefront changes two things: payment-access falls 0.7% → 0.0% and billing falls (3.2% → 1.4%; auto-charge 1.5% → 0.6%); every other Part 0 finding holds in the non-Russian corpus and in E6 alone

- **Where:** §7.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** burst removal ≤0.2 pts
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Canonical:** C026 Handle markets where card payment fails (RU, AR, TR, DZ, PK); C231 Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone

### R59-108 — Research questions the corpus cannot answer: (1) what fraction of trials are charged before day 7, and is the cause App Store behaviour, a bug or the direct-card flow; (2) how many lifetime buyers have lost the unlock and on which path (reinstall, new device, Mac, account change); (3) the mix of lifetime versus subscription revenue, and does the lifetime discount cannibalise annual renewals; (4) how many users write the time into the task title, and do they churn faster; (5) does the free habit cap at 2 versus 3 change lifetime conversion

- **Where:** §8.11 part 8 #1, part 8 #2, part 8 #3, part 8 #4, part 8 #5
- **This app does:** n/a
- **User reaction:** n/a
- **Magnitude:** five open questions
- **Direction for us:** none · **Report confidence:** research question · **Generalisable:** generalisable
- **Canonical:** C064 Price level — where 'fair' turns into 'too expensive'; C163 Visible monthly plan — annual-default trials drive billing disputes
