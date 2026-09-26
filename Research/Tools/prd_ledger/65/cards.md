# Cards — report 65

Source: `App Store Reports/65. Rabit - Daily Routine Planner - Habit Tracker & ADHD Help (REPORT).md`  
52 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 2
- [Must-haves](#must-haves) — 2
- [Must never break](#must-never-break) — 9
- [Features](#features) — 8
- [Monetization](#monetization) — 2
- [Tactics the app used](#tactics-the-app-used) — 2
- [Insights (the why)](#insights-the-why) — 7
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 4
- [Dated events and trends](#dated-events-and-trends) — 4
- [Positioning](#positioning) — 1
- [Anti-patterns](#anti-patterns) — 2
- [Things not to do](#things-not-to-do) — 1
- [Things to do](#things-to-do) — 1
- [Contradictions](#contradictions) — 1
- [Data caveats and method](#data-caveats-and-method) — 5

## Product rules

### R65-017 — Plant death is the single riskiest design decision: GAM_PLANT_NEG 4 (0.80%, emerging, mean 3.00) — 'Missing one scheduled habit completely kills a plant?!! … I don't mind a penalty but this is dark souls level'; 'sometimes the day doesn't allow for that particular habit to be done… are we supposed to lie?'; all plants died at once; GAM_STREAK_NEG 2 — streak-only scoring too all-or-nothing; MOT_NEG 4 (0.80%, 3.75); users accept the penalty when deserved and reject it when not — so false failures (BUG_STREAK) and the absence of a legitimate skip (CORE_SKIP 2, 0.40%, 4.50) are 'disproportionately damaging here compared with a plain streak app'; a design tuning problem, not a bug; S3: skip / exempt a day without killing the plant

- **Where:** §3.3 N8; §4.1 consequence 2; §9.2 S3
- **This app does:** a miss kills the plant; no skip
- **User reaction:** mixed
- **Magnitude:** GAM_PLANT_NEG 4 (0.80%) 3.00; MOT_NEG 4 (0.80%) 3.75
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `10912209986`, `12590814225`, `7582838275`, `9386222299`, `11641681635`, `10550831584`
- **Canonical:** C016 Skip / holiday / pause mode (pause a habit or counter without losing history); C157 Every guilt mechanic must be optional — streaks, repair prompts, countdowns; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks

### R65-049 — What to do first — if one thing ships, the notification fix (13.25% of the corpus, 45.7% of the last three years, top theme of 2★ and 3★, in 10 of 49 payer reviews, the blocker on at least three abandoned purchases); if three, F1 + F2 (entitlement) + F3 (support email) — they address every one of the top six payer complaints, cost no product decisions, and are the fastest route from a 2.061 payer mean toward the corpus mean; if a quarter, add S1 widget, S2 frequency scheduling and M1 a defensible free tier — 'the three things the corpus shows people have been asking for longest and, in five documented cases, offering money for'; the one-line story: a genuinely loved position in Brazil — 'a cute, simple, plant-growing habit tracker whose free tier was praised as the most generous in its category' — then 'four years dismantling that position'

- **Where:** §9.6; Part 0 executive summary in one line
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5 conditional purchases; payer mean 2.061
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `9942909088`
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C033 Restore purchase and entitlements must work immediately; C036 A support channel that exists, is reachable outside the app, and answers; C039 Reminders fire reliably, once

## Must-haves

### R65-008 — Support does not answer: SUP_SILENT 5 (1.00%) — all five 1★ (a perfect mean 1.00), all five payers: 'I sent an email like 2 weeks ago to solve this and still don't have any answers'; 'ninguém responde as mensagens enviadas, nem por e-mail de cadastro nem no suporte! Um descaso total!'; 'Mandei dois e-mails solicitando o estorno da compra, mas até o momento não deram retorno'; each describes a problem one reply would have converted into a 3–5★ update — 'the cheapest rating repair available'; no evidence of developer replies to reviews in the corpus

- **Where:** §0.2 SUP_SILENT; §3.3 N7; §9.1 F3; §6.7 #3; §0.10 #3
- **This app does:** support silent
- **User reaction:** 1★-burst
- **Magnitude:** 5 (1.00%) mean 1.00; 5/49 payers
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8336984761`, `9170732248`, `9330471845`, `10766573758`, `11017615081`
- **Canonical:** C036 A support channel that exists, is reachable outside the app, and answers

### R65-026 — Day and week boundaries: the day-reset time is fixed at midnight — 'My day does not start or end at 12am… I track my water usage past midnight and it doesn't reset after I sleep??' (REQ_RESETTIME 1); week start cannot be Monday — three reviewers report only Friday and Saturday offered (BUG_WEEKSTART 3, 0.60%, mean 3.33); calendar maps dates to the wrong weekday (BUG_CAL 1); F9: allow Monday as week start

- **Where:** §4.2; §3.3 N9 BUG_WEEKSTART; §9.1 F9
- **This app does:** midnight reset; Fri/Sat week start only
- **User reaction:** complaint
- **Magnitude:** WEEKSTART 3 (0.60%) 3.33; RESETTIME 1
- **Direction for us:** must-have · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `10316293721`, `7633137657`, `7700545328`, `8222996948`, `12590814225`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C170 Configurable day boundary and hemisphere seasons

## Must never break

### R65-003 — Notifications are broken, and that is the whole story since late 2023: REM_FAIL 66 (13.25%, high-priority, mean 2.91) — 58 of the 127 reviews since Nov 2023 (45.7%); by era 4 (10.8%) → 2 (0.8%) → 2 (2.2%) → 58 (45.7%) — present at launch, fixed for two years ('for 25 months, two people in 242 complained'), then catastrophically regressed; REM_NOPERM 14 (2.81%, mean 3.14) report the app is absent from iOS Settings → Notifications entirely (0% → 0% → 0% → 11.0%, 'the signature of a specific broken build') (verbatim): Review ID | Date | CC | ★ | What they say ; 10566006295 | 2023-11-09 | br | 4 | *"não aparece nem opção de notificação na configuração do IOS"* ; 10879516524 | 2024-01-30 | us | 4 | *"there is no option to turn on notifications for the app"* ; 11410699904 | 2024-06-22 | br | 5 | *"o aplicativo não aparece nas notificações do IPhone, nem para se quer configurar os lembretes"* ; 11666871970 | 2024-08-29 | mx | 2 | *"directamente no tiene la opción de habilitarlas desde configuración"* ; 12256187890 | 2025-02-01 | tr | 3 | *"uygulamanın bildirim açma kapama seçeneği yok"* (the app has no notification on/off option) ; 12988341658 | 2025-08-07 | br | 2 | *"na parte de 'notificações' do iphone, ele sequer aparece lá… parece que eles simplesmente não vem com essa característica"* ; 13253396607 | 2025-10-11 | ca | 2 | *"The app doesn't appear on the phone's list Notifications. I tried uninstalling and reinstalling multiple times."* — across iPhone 13, iPhone 14 / iOS 16 and iPad, seven storefronts, 31 months, five languages, after reinstalling and checking both settings screens: 'almost certainly a missing or failing UNUserNotificationCenter authorization request'; 'Não entendi porque um App de hábitos não tem a notificação do hábito… Perde todo o propósito'; 'That is the point of an app like this, having reminders'; 15 of 66 are 4★ and 9 are 5★ — people who like the app naming one fatal flaw; top theme of the 2★ band (44.2%) and 3★ (28.9%); still open at the last review (24 Aug 2026); REM_GOOD 15 (3.01%, a perfect 5.00) fell 8.1% → 3.3% → 3.3% → 0.8% — 'the clearest before/after in this dataset'; F1: confirm the app requests notification authorization at all; research #2: the actual failure mode needs a device test

- **Where:** Warning 3; §0.1 table (verbatim); §3.3 N1; §8.4 I5 table (verbatim); §9.1 F1; §9.6; §9.5 #2; part 9 #2; §0.10 #1
- **This app does:** notifications absent from iOS settings since Nov 2023
- **User reaction:** churn
- **Magnitude:** 66 (13.25%) mean 2.91; 45.7% of E4; REM_NOPERM 14 (2.81%) 3.14
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10566006295`, `10879516524`, `11410699904`, `11666871970`, `12256187890`, `12988341658`, `13253396607`, `11020418127`, `12946302441`, `14465169878`, `14001951104`
- **Canonical:** C008 Daily check-in and reminders are free — never paywall the reminder; C039 Reminders fire reliably, once; C175 Updates must not break function or wipe progress

### R65-006 — The people who paid are the people who were let down: 49 reviewers (9.84%) give direct purchase evidence, mean 2.061 vs corpus 3.677, 27 of 49 (55.1%) left 1★ (3× over-represented in 1★); payers by year 2020 ×1, 2021 ×8, 2022 ×12, 2023 ×15, 2024 ×10, 2025 ×1, 2026 ×2 (peak in the cap year); Brazil 38, US 7 (verbatim): What payers report | n of 49 | Segment rate | Global n ; The paid version was not worth it / money wasted (PAY_VALUE_NEG) | 11 | 22.4% | 16 ; App crashes (BUG_CRASH) | 10 | 20.4% | 27 ; Notifications don't work (REM_FAIL) | 10 | 20.4% | 66 ; Paid, but the app does not recognise it (PAY_ENTITLE) | 9 | 18.4% | 9 — every single one is a payer ; Asked for a refund (PAY_REFUND) | 8 | 16.3% | 8 — every single one is a payer ; Emailed support, got no reply (SUP_SILENT) | 5 | 10.2% | 5 — every single one is a payer || rating split (verbatim): ★ | n | % of 49 payers | (corpus share at this ★) ; 5 | 4 | 8.2% | 48.80% ; 4 | 5 | 10.2% | 15.26% ; 3 | 8 | 16.3% | 9.04% ; 2 | 5 | 10.2% | 8.63% ; 1 | 27 | 55.1% | 18.27% || post-purchase failures (verbatim): Code | n among payers | Segment rate (of 49) | Global n | Global % of 498 ; PAY_VALUE_NEG | 11 | 22.4% | 16 | 3.21% ; BUG_CRASH | 10 | 20.4% | 27 | 5.42% ; REM_FAIL | 10 | 20.4% | 66 | 13.25% ; PAY_ENTITLE | 9 | 18.4% | 9 | 1.81% ; PAY_REFUND | 8 | 16.3% | 8 | 1.61% ; SUP_SILENT | 5 | 10.2% | 5 | 1.00% ; PAY_CHARGE | 4 | 8.2% | 4 | 0.80% ; ACCT_SIGNIN | 4 | 8.2% | 5 | 1.00% ; PAY_REGRESS | 3 | 6.1% | 21 | 4.22% ; PAY_TRIAL_BAD | 3 | 6.1% | 5 | 1.00% ; PAY_CANCEL | 3 | 6.1% | 3 | 0.60% ; BUG_UPDATE | 3 | 6.1% | 14 | 2.81% ; BUG_GEN | 3 | 6.1% | 13 | 2.61% ; DATA_LOSS | 3 | 6.1% | 10 | 2.01% ; CORE_LISTS | 2 | 4.1% | 6 | 1.20% ; CROSS_ANDROID | 2 | 4.1% | 2 | 0.40% ; PAY_DARK | 2 | 4.1% | 5 | 1.00% ; BUG_OPEN | 2 | 4.1% | 11 | 2.21% ; ACCT_RESTORE | 2 | 4.1% | 3 | 0.60% ; PAY_CANCEL_INTENT | 2 | 4.1% | 2 | 0.40% ; PAY_FREE_LIMIT | 2 | 4.1% | 34 | 6.83% ; MOT_GOOD | 2 | 4.1% | 21 | 4.22% ; PAY_LIFETIME | 2 | 4.1% | 7 | 1.41% ; PAY_PREMIUM_BAD | 1 | 2.0% | 2 | 0.40% — the 1★ band is a payer band (PAY_PAID 29.67% of 1★) made of (a) people who could not get into the app and (b) people who paid and could not get what they paid for — 'Neither group is a pricing problem'; only 2 (0.40%) say paid was worth it vs 16 who say not; complete payer list (verbatim): Review ID | Date | CC | ★ | Other themes ; 6643782641 | 2020-11-14 | br | 1 | PAY_PREMIUM_BAD, CORE_BACKFILL, PAY_REGRESS ; 7394381441 | 2021-05-27 | br | 4 | PAY_TRIAL_BAD, PAY_CHARGE ; 7483566770 | 2021-06-19 | us | 4 | PAY_UPSELL, DES_CUTE, DES_SIMPLE, GAM_PLANT, CORE_LISTS ; 7495627782 | 2021-06-23 | br | 3 | PAY_CANCEL, PAY_VALUE_NEG ; 7591280568 | 2021-07-18 | br | 1 | BUG_CRASH, PAY_REFUND, SUP_CONTACT ; 7623014692 | 2021-07-27 | br | 2 | BUG_CRASH ; 7743115044 | 2021-08-28 | us | 4 | ACCT_SIGNIN, CROSS_ANDROID, SYNC_REQ ; 7814903872 | 2021-09-17 | br | 3 | PAY_ENTITLE, CORE_LISTS ; 8071399416 | 2021-11-28 | br | 1 | PAY_TRIAL_BAD, PAY_CHARGE, PAY_CANCEL, PAY_DARK ; 8291821167 | 2022-01-28 | br | 5 | BUG_UPDATE, BUG_OPEN, BUG_GEN, META_CONTRA ; 8336984761 | 2022-02-09 | co | 1 | ACCT_RESTORE, ACCT_SIGNIN, SUP_SILENT, PAY_ENTITLE ; 8580027859 | 2022-04-18 | br | 1 | BUG_CRASH, BUG_CHECK, PAY_VALUE_NEG ; 8621971726 | 2022-04-30 | br | 2 | BUG_CRASH, BUG_UPDATE ; 8654647258 | 2022-05-09 | br | 1 | BUG_CRASH ; 8687587041 | 2022-05-19 | br | 1 | PAY_RENEW, BUG_CRASH ; 8753194436 | 2022-06-08 | br | 3 | BUG_GEN, PAY_CANCEL_INTENT ; 8967446592 | 2022-08-11 | br | 3 | BUG_OPEN, BUG_CRASH, PAY_VALUE_NEG ; 9067455099 | 2022-09-09 | br | 1 | COMP_BEST, BUG_CRASH, ACCT_SIGNIN, DATA_LOSS, PAY_VALUE_NEG ; 9170732248 | 2022-10-10 | br | 1 | BUG_CRASH, SUP_SILENT, PAY_VALUE_NEG ; 9243504386 | 2022-11-01 | br | 1 | BUG_CRASH, DEV_NOFIX ; 9330471845 | 2022-11-26 | br | 1 | ACCT_RESTORE, CROSS_ANDROID, SUP_SILENT, PAY_REFUND ; 9506447076 | 2023-01-14 | cl | 2 | CORE_TODO, PAY_ENTITLE, PAY_REGRESS ; 9564856446 | 2023-01-30 | br | 1 | PAY_AUTORENEW, PAY_DARK ; 10002348801 | 2023-06-05 | br | 1 | REM_FAIL, BUG_STREAK, PAY_REFUND, PAY_CANCEL_INTENT ; 10034708112 | 2023-06-15 | br | 1 | PAY_FREE_LIMIT, PAY_ENTITLE ; 10134110248 | 2023-07-13 | br | 1 | PAY_ENTITLE, PAY_FREE_LIMIT ; 10135201402 | 2023-07-13 | br | 1 | PAY_ENTITLE, ACCT_SIGNIN, BUG_UPDATE ; 10135375382 | 2023-07-13 | br | 1 | PAY_ENTITLE ; 10142865647 | 2023-07-15 | br | 1 | REM_FAIL, PAY_VALUE_NEG ; 10232073862 | 2023-08-08 | br | 1 | PAY_REGRESS, GAM_PLANT_LOST, DATA_LOSS ; 10240334663 | 2023-08-10 | us | 1 | PAY_ADS_PAID, ADS_BAD, PAY_REFUND ; 10370996938 | 2023-09-15 | us | 3 | PAY_ENTITLE, CORE_ROUTINES, MOT_GOOD, BUG_GEN ; 10559482117 | 2023-11-07 | br | 5 | PAY_WORTH, OUT_LIFE ; 10569094114 | 2023-11-10 | br | 1 | PAY_TRIAL_BAD, PAY_CHARGE, PAY_REFUND ; 10633935353 | 2023-11-28 | us | 1 | DATA_LOSS ; 10766573758 | 2023-12-31 | br | 1 | PAY_CANCEL, SUP_SILENT ; 10775104885 | 2024-01-02 | br | 4 | REM_FAIL, PAY_VALUE_NEG ; 10912209986 | 2024-02-07 | us | 3 | GAM_PLANT_NEG, MOT_NEG ; 10954472559 | 2024-02-19 | br | 3 | REM_FAIL, PAY_VALUE_NEG ; 11017615081 | 2024-03-07 | br | 1 | PAY_REFUND, SUP_SILENT ; 11038596675 | 2024-03-13 | mx | 1 | REM_FAIL, PAY_VALUE_NEG ; 11213091836 | 2024-04-29 | br | 4 | PAY_LIFETIME, REM_FAIL, PAY_BARRIER ; 11391895419 | 2024-06-17 | br | 3 | REM_FAIL ; 11519711627 | 2024-07-21 | br | 1 | REM_FAIL, PAY_REFUND ; 11641681635 | 2024-08-23 | br | 5 | GAM_STREAK_NEG, REQ_STATS, REQ_GRAPH ; 11783159029 | 2024-09-30 | pe | 2 | REM_FAIL, PAY_REFUND, PAY_VALUE_NEG ; 12294603864 | 2025-02-10 | us | 5 | MOT_GOOD, REQ_WIDGET ; 13703032713 | 2026-02-02 | br | 2 | REM_FAIL, PAY_VALUE_NEG ; 13808763562 | 2026-03-03 | br | 1 | PAY_LIFETIME, PAY_ENTITLE, PAY_CHARGE

- **Where:** Warning 6; §0.2 table (verbatim); §6.1 table (verbatim); §6.4 table (verbatim); §5.5; §6.6 table (verbatim)
- **This app does:** subscription + lifetime
- **User reaction:** 1★-burst
- **Magnitude:** 49 payers @ 2.061; 55.1% 1★; PAY_VALUE_NEG 11/49
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10559482117`, `10936188003`, `8580027859`, `8654647258`, `8967446592`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R65-007 — PAY_ENTITLE is the sharpest finding: 9 (1.81%, mean 1.56) — every single one a payer, 9 of 49 (18.4%), spanning Sep 2021 → Mar 2026 so not a single broken release: 'Fiz a assinatura do plano plus anual e o app não reconhece!'; 'Fiz a assinatura e não consigo criar mais do que cinco hábitos!'; to-do list locked for a buyer; 'Even though I paid for the subscription the app will only let me make two routines'; lifetime charged but 'O app consta como se eu não tivesse o pacote'; 'I have ads on a paid subscription- I want a refund'; 'despite buying a premium subscription, I'm still being asked every time I'm in the app to upgrade'; cross-device restore broken — new phone only offered a new plan, account 'não existe' after reinstall, 'a opção de restaurar só acontece de celular androide para androide' (ACCT_RESTORE 3, ACCT_SIGNIN 5, CROSS_ANDROID 2); plants bought under Plus re-locked after an update; F2: audit fresh install, new device, reinstall, Android→iOS; make Restore Purchases reachable and sign-in discoverable

- **Where:** §0.2 PAY_ENTITLE; §6.4 A, D, E, F; §9.1 F2; §6.7 #2; §0.10 #2
- **This app does:** entitlement not recognised; Android→iOS restore absent
- **User reaction:** 1★-burst
- **Magnitude:** PAY_ENTITLE 9 (1.81%) 1.56, 100% payers; ACCT_SIGNIN 5 (1.00%) 2.20; ACCT_RESTORE 3 (0.60%) 1.67
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `10135375382`, `10134110248`, `7814903872`, `10370996938`, `9506447076`, `13808763562`, `10240334663`, `7483566770`, `8336984761`, `9330471845`, `9067455099`, `7743115044`, `10232073862`
- **Canonical:** C033 Restore purchase and entitlements must work immediately; C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C175 Updates must not break function or wipe progress; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R65-013 — Reported prices inconsistent enough to be a defect: four independent reviewers Jun–Nov 2022 report the monthly price as R$299–R$300 and one R$600 against R$29.90 reported elsewhere — 'Excelente só corrijam o bug do preço mês que está R$ 299,00 e não 29,90' (5★); 'desinstalei por medo de sem querer assinar o plus e ter que viver de aluguel pois custa 600 reais' (5★, uninstalled); two of four rate 5★ while reporting it as a bug; PAY_PRICE_BUG 4 (0.80%, mean 4.25), all Brazilian in BRL — 'high-severity, low-volume': a 10× price display error in the storefront holding 77% of ratings 'would suppress conversion invisibly — nobody who simply closes the paywall writes a review'; F4: verify the BRL price string; research #1: 'Highest-value single check in this list'

- **Where:** Warning 5; §2.2; §6.3 price display; §9.1 F4; §9.5 #1; part 9 #1; §6.7 #4
- **This app does:** paywall showed R$299/R$600 per month
- **User reaction:** blocked-conversion
- **Magnitude:** 4 (0.80%) 4.25; storefront holds 77.2% of ratings
- **Direction for us:** must-never-break · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `8787259760`, `8841492479`, `8982876143`, `9305007119`
- **Canonical:** C284 Verify the rendered price string in every storefront currency — a decimal or tier error on the paywall suppresses conversion invisibly, because nobody who closes a paywall writes a review

### R65-018 — The false-failure bug is the subtlest and most corrosive: BUG_STREAK 7 (1.41%, meaningful, mean 2.43) — the app reports completed habits as failed and kills the plant: 'Tengo un hábito cumplido todos los días y mi planta sale muerta y con 0 días de racha'; one reviewer reads it as deliberate — the app marks completed days as missed so you buy the subscription that lets you edit past days: 'Tática desleal.' — intent unconfirmed, the symptom fully explained by the defect, 'but the perception is a real monetization cost'; F7

- **Where:** §3.3 N6 BUG_STREAK; §9.1 F7
- **This app does:** completed days marked missed; past-day edit is paid
- **User reaction:** complaint
- **Magnitude:** 7 (1.41%) 2.43
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `9386222299`, `7700397006`, `9498013143`, `10002348801`, `8405311643`, `7562207634`, `7107263060`
- **Canonical:** C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C256 Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which; C262 Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever

### R65-019 — Data and account continuity — data_continuity 21 (4.22%, very strong, mean 2.00); DATA_LOSS 10 (2.01%, mean 1.70): 'it continuously wipes all my habits, tasks, everything and I have to start over. I have the paid version!'; 'Cadastrei mais de 50 itens em uma lista agora mesmo, salvou um a um e simplesmente sumiu tudo!'; 'I lost my streak and everything… Superdemotivating'; 'não restaura o que tinha antes, perdi praticamente tudo'; plants owned under Plus re-locked behind a padlock after an update (GAM_PLANT_LOST 1) — the loss is of exactly the asset the product asks people to build; zero data-export requests (notable for an app used for years); composite unions (verbatim): Union | Codes merged | n | % of 498 | Band | Mean ★ ; [U:reminders_broken] | REM_FAIL, REM_NOPERM, REM_PAYQ | 66 | 13.25% | High-priority | 2.91 ; [U:monetization_backlash] | PAY_FREE_LIMIT, PAY_REGRESS, PAY_HARDWALL, PAY_PREMIUM_BAD, PAY_BACKUP, PAY_PRICE, PAY_PRICE_BUG, PAY_ONETIME, PAY_STUDENT, PAY_VALUE_NEG, PAY_DARK, PAY_FEAR | 72 | 14.46% | High-priority | 2.43 ; [U:stability] | BUG_CRASH, BUG_OPEN, BUG_ONBOARD, BUG_LAYOUT, BUG_SLOW, BUG_OLDIOS, BUG_GEN | 73 | 14.66% | High-priority | 2.04 ; [U:billing_failure] | PAY_TRIAL_BAD, PAY_CHARGE, PAY_AUTORENEW, PAY_BUY_FAIL, PAY_ENTITLE, PAY_ADS_PAID, PAY_UPSELL, PAY_CANCEL, PAY_REFUND, PAY_CANCEL_INTENT | 28 | 5.62% | High-priority | 1.75 ; [U:data_continuity] | DATA_LOSS, BUG_STREAK, ACCT_SIGNIN, ACCT_RESTORE, CROSS_ANDROID, GAM_PLANT_LOST | 21 | 4.22% | Very strong | 2.00 ; [U:design_praise] | DES_CUTE, DES_SIMPLE, DES_DARK | 106 | 21.29% | High-priority | 4.57 ; [U:ads] | ADS_BAD, ADS_UPSELL, ADS_XBUG, PAY_ADS_PAID | 18 | 3.61% | Very strong | 2.39 ; [U:platform_gaps] | REQ_WIDGET, REQ_WATCH, REQ_IPAD, REQ_DESKTOP, SYNC_REQ | 55 | 11.04% | High-priority | 4.25 ; [U:requests_any] | REQ_WIDGET, REQ_WATCH, REQ_IPAD, REQ_DESKTOP, SYNC_REQ, REQ_MOOD, REQ_GRAPH, REQ_STATS, REQ_DESC, REQ_NOTES, REQ_ARCHIVE, REQ_SOUND, REQ_RESETTIME, REQ_APPICON, REQ_HABITICON, REQ_CHECKLIST, REQ_READING, REQ_EXERCISE, REQ_CUSTOM, CORE_FREQ, CORE_SKIP, CORE_PRIORITY, GAM_PLANT_VARIETY, GAM_MORE, LOC_REQ | 89 | 17.87% | High-priority | 4.29 ; [U:positive_outcome] | OUT_LIFE, MOT_GOOD, MOT_MSG, USE_STUDY, USE_MEDS, USE_MENTAL | 68 | 13.65% | High-priority | 4.88 ; [U:churn_signal] | COMP_WORSE, PAY_CANCEL_INTENT, PAY_REFUND | 20 | 4.02% | Very strong | 1.75

- **Where:** §3.3 N6 table; §3.2
- **This app does:** data wiped; backup paywalled
- **User reaction:** churn
- **Magnitude:** DATA_LOSS 10 (2.01%) 1.70; union 21 (4.22%) 2.00
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `10633935353`, `10802638244`, `10527744988`, `8286530670`, `10232073862`
- **Canonical:** C020 Data export / backup / CSV; C034 Data must never be lost on update, reinstall or phone change; C175 Updates must not break function or wipe progress

### R65-021 — First-run blocks convert recommendations into 1★: 22 reviewers never got in — 'I have seen so many great reviews for this app, and I was very excited to try it'; 'Ouvi falar muito bem deste aplicativo'; 'TODOS OS MEUS AMIGOS ME RECOMENDARAM' — 'paid-for or word-of-mouth acquisition converting to a 1★ review instead of an install'; the same class returned in 2023–2024 as a layout bug — the onboarding questionnaire's advance button renders below the visible screen; BUG_ONBOARD twice as common outside Brazil (7.32% vs 3.47%) — the blocked are disproportionately the expansion audience; F6: fix the advance button

- **Where:** §0.8; §3.3 N4; §9.1 F6; §7.3 BUG_ONBOARD
- **This app does:** onboarding button off-screen
- **User reaction:** 1★-burst
- **Magnitude:** BUG_ONBOARD 22 (4.42%) 1.45; non-BR 7.32% vs BR 3.47%
- **Direction for us:** must-never-break · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `7606364776`, `7627353565`, `12490797974`, `11052620853`, `11520264880`, `11036949364`
- **Canonical:** C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C159 Launch-to-core-action path with no interstitials

### R65-032 — Billing and entitlement failures — billing_failure 28 (5.62%, high-priority, mean 1.75), nearly all payers; PAY_REFUND 8 (1.61%, mean 1.12 — the lowest mean of any theme; all payers, seven 1★) (verbatim): Cause | ID ; Crashes after subscribing annual | 7591280568 — *"quero saber como ter meu dinheiro de volta"* ; Cannot restore on a new phone, support silent | 9330471845 ; Reminders don't work after paying Plus | 10002348801, 11519711627, 11783159029 ; Ads despite paying | 10240334663 ; Charged R$199.90 after a trial believed cancelled | 10569094114 ; Two refund emails, no reply | 11017615081 — the 7-day trial is the recurring offender (PAY_TRIAL_BAD 5, 1.00%, 2.00): 'aceitei testar por 7 dias o premium e nesse momento me descontou o valor mensal no cartão'; 'cobraram no meu cartão o valor do mesmo instante… isso é propaganda enganosa'; R$199.90 charged after deleting the app; trial subscribe button spins forever; ending free use on day two; purchases that simply fail (PAY_BUY_FAIL 3); cancellation with no route out (PAY_CANCEL 3: 'Comprei por engano e não consigo cancelar, não tem suporte, não tem orientação como faço?'); silent renewal after months of non-use ('Achei que agiram de má fé… Espero que repensem o formato de receita'); M3: fix the trial ('closer to F-tier'); M4: make cancellation findable in-app

- **Where:** §3.3 N3; §6.5 table (verbatim); §9.3 M3, M4
- **This app does:** trial charges immediately; no in-app cancel
- **User reaction:** 1★-burst
- **Magnitude:** billing 28 (5.62%) 1.75; REFUND 8 (1.61%) 1.12; TRIAL_BAD 5; CHARGE 4 (0.80%) 1.75; CANCEL 3
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `7394381441`, `8071399416`, `10569094114`, `10096220193`, `9729544234`, `10008521499`, `10092963636`, `7495627782`, `10766573758`, `9564856446`, `7591280568`
- **Canonical:** C029 Billing must be exactly right; C109 A free trial must be a real trial; C112 In-app cancellation; C221 A receipt with a working product link after every charge, and a renewal reminder before it

### R65-035 — Smaller defects worth a sprint (verbatim): Theme | n | Band | What it is | IDs ; BUG_UPDATE | 14 | Meaningful | Reviewer attributes the regression to a specific release | 6125232569, 6852368820, 7599548924, 9550931363, 11397183382 ; CONF_UX | 12 | Meaningful | Cannot find a control / doesn't know how to mark done | 7371042454, 7562207634, 9498013143, 11714496386, 11814840832 ; BUG_CHECK | 8 | Meaningful | Cannot mark a habit complete at all | 7491065993, 9193229797, 9558216526, 12590814225 ; BUG_TIMER | 3 | Emerging | Timer stops when backgrounded or the screen locks | 6088717287, 6093103985, 10819138875 ; BUG_WEEKSTART | 3 | Emerging | Week start cannot be set to Monday; only Fri/Sat offered | 7633137657, 7700545328, 8222996948 ; BUG_OLDIOS | 2 | Weak | Won't run on older iPhone / iPad iOS 12.5 | 10914233763, 11345513333 ; BUG_CAL | 1 | Weak | Calendar maps dates to the wrong weekday | 12590814225 ; BUG_SOUND | 1 | Weak | A crying-woman sound plays on every launch | 8081220982 ; CORE_HOMELIMIT | 1 | Weak | Only ~3 tasks visible on the home screen | 9193229797 ; CAL_VIEW | 1 | Weak | Calendar shows only one habit | 8405311643 ; LOC_BUG | 1 | Weak | Opens in English on the Brazilian storefront | 11639767100 ; DES_BUSY | 1 | Weak | Animations/doodles too heavy for a minimal-tracker user | 11308018826 — BUG_UPDATE 14 (2.81%, 2.71) reviewer attributes a regression to a release; CONF_UX 12 (2.41%, 3.50) cannot find a control / how to mark done; BUG_CHECK 8 (1.61%, 2.12) cannot mark a habit complete at all; an unexplained crying-woman sound on every launch ('le son d'une femme qui pleure… c'est effrayant') retained below threshold as a content / asset-integrity problem (F11); only ~3 tasks visible on the home screen; calendar shows one habit; opens in English on the Brazilian storefront; animations too heavy for a minimal-tracker user (DES_BUSY)

- **Where:** §3.3 N9 table (verbatim); §9.1 F11
- **This app does:** assorted
- **User reaction:** complaint
- **Magnitude:** BUG_UPDATE 14; CONF_UX 12; BUG_CHECK 8
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `6125232569`, `7371042454`, `7491065993`, `8081220982`, `9193229797`, `8405311643`, `11639767100`, `11308018826`
- **Canonical:** C031 Crashes / launch failures; C038 Dates, streaks and statistics correct on every surface — month boundaries, week starts, DST and timezones; C142 Surface existing features where users look

## Features

### R65-016 — The garden is the retention mechanic: GAM_PLANT 21 (4.22%, very strong, mean 4.62; 14×5★, almost purely positive) and MOT_GOOD 21 (4.22%, 4.86) — 'Ele faz analogia com uma plantação e te estimular a se manter motivado a salvar a plantinha… Eu criei hábitos que me deixaram muito mais produtivos e ainda emagreci'; 'a melhor sacada do mundo é essa de colhemos o que plantamos'; 'cuando no hago un día el hábito me hace sentir mal porque no va a crecer mas mi planta y eso hace que me impulse'; reviewers describe a relationship with a plant, not a checklist; under-built relative to its importance — more plant varieties (GAM_PLANT_VARIETY 3, 0.60%, 4.67), a placeable garden 'more like FarmTown' with tap-a-plant-for-detail (GAM_MORE 1), a widget that shows the garden and warns when a plant is near death; §9.4 #1: build out the garden — 'the cheapest available investment in the thing people already love'

- **Where:** §0.5; §4.1; §3.4 P2; §9.4 #1; part 9 #1
- **This app does:** plant grows per kept habit
- **User reaction:** praise
- **Magnitude:** GAM_PLANT 21 (4.22%) 4.62; MOT_GOOD 21 (4.22%) 4.86
- **Direction for us:** build-free · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `6056995445`, `6585144103`, `9892861064`, `9611635620`, `7419859413`, `8373713257`, `8241031108`, `13038216598`, `9823208283`
- **Canonical:** C024 Streaks / gamification; C237 The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users

### R65-024 — The widget has been requested for five years and never shipped: REQ_WIDGET 43 (8.63%, high-priority, mean 4.30 — satisfied users naming the one thing missing; 20×5★, 18×4★, 3×3★, 2×2★, 0×1★); first asked 2021-01-15, days after the iOS 14 widget launch, still asked 2025-08-25; 0% → 7.9% → 10.9% → 11.0% of eras — rising, never answered; top theme of the entire 4★ band (23.68%); more than twice as hot outside Brazil (15.45% vs 6.40%) — disproportionately an English- and Spanish-language ask; four make a purchase conditional on it: 'I would gladly pay for the premium version, but there are no widgets'; 'I'll definitely buy the lifetime plus version if you add widgets'; 'If this app had them I would 100% buy the lifetime'; 'I am going to hold off on subscribing until at least the first feature is met'; S1: home-screen and lock-screen widget

- **Where:** §0.6; §3.6; §9.2 S1; §5.2; §6.7 #6; §0.10 #6
- **This app does:** absent
- **User reaction:** blocked-conversion
- **Magnitude:** 43 (8.63%) 4.30; 4 conditional purchases; 23.7% of 4★
- **Direction for us:** build-paid · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `6872045225`, `13059862926`, `11570813316`, `12002090537`, `12794885676`, `10316293721`
- **Canonical:** C023 Interactive widget check-off; C107 Widget variants and customisation as the paid layer

### R65-025 — Scheduling by fixed weekdays is the most-requested product change: CORE_FREQ 9 (1.81%, meaningful, mean 4.11) — all nine from Brazil, spread across five years (Aug 2020 → Jul 2025), all describing 'X times per week, any day': 'Preciso estudar música 3x por semana (0/3). E ao ir concluindo durante a semana, o hábito mostrasse o progresso ou (1/3), (2/3) e (3/3)'; 'minha rotina não permite sempre me exercitar nos mesmo dias'; 'Sem isso a assinatura não vale a pena' (a conditional purchase); adjacent: multiple-times-per-day exists but cannot be partially completed ('tenho que tomar vitamina 2x ao dia, porém não consigo marcar caso eu tenho tomado apenas 1x. É tudo ou nada'; CORE_MULTI 1); CORE_FREQ + CORE_SKIP + CORE_MULTI + REQ_RESETTIME + BUG_WEEKSTART = 15 (3.01%, very strong) all the same model limitation — 'my week is not identical every week'; S2: X times per week with n/N progress; S4: partial completion; research #5: why exclusively Brazilian — local expectation or 75%-Brazil artefact

- **Where:** §0.7; §4.2; §9.2 S2, S4; §7.3; §9.5 #5; part 9 #5; §0.10 #7
- **This app does:** fixed weekdays only
- **User reaction:** blocked-conversion
- **Magnitude:** CORE_FREQ 9 (1.81%) 4.11, 100% BR; model-limit union 15 (3.01%)
- **Direction for us:** must-have · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8437662124`, `12403935823`, `8590687133`, `6319309581`, `12869653031`, `6621159448`, `9444567013`
- **Canonical:** C043 Flexible / custom frequency; C143 Intra-day completion: tap N times to fill N/N

### R65-027 — The per-habit timer is an unexploited differentiator: CORE_TIMER 8 (1.61%, mean 4.50) — 'tem até timer e é de graça!!!!!', used for study revision — but broken the same way since month two: it stops counting when backgrounded or the screen locks (BUG_TIMER 3, 0.60%, mean 4.00; Jun 2020 → Jan 2024): 'eu estudei por volta de 1 hora e marcou apenas alguns segundos'; manual time entry proposed and never shipped ('Hoje isso só acontece com o timer em tempo real'); hard to find; F8: survive backgrounding and screen lock, or ship manual entry as the interim

- **Where:** §4.3; §3.5 CORE_TIMER; §9.1 F8
- **This app does:** free timer; stops in background
- **User reaction:** mixed
- **Magnitude:** CORE_TIMER 8 (1.61%) 4.50; BUG_TIMER 3 (0.60%) 4.00
- **Direction for us:** must-never-break · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `8020728448`, `8088356750`, `7565776979`, `6088717287`, `6093103985`, `10819138875`, `7851322556`
- **Canonical:** C272 Built-in timers survive backgrounding, a call and screen lock, and always alert at the end — store the start time, compute elapsed

### R65-028 — Lists, routines and grouping are half-built: the to-do list is a separately monetised surface ('having different lists for tasks is great') — paywalled in a way called unfair ('só o todo-list que não é [gratuito], achei meio injusto'), vanished for a payer, has no reminders ('die sinnlose Aufgabenliste ohne Erinnerungsfunktion… Total sinnfrei und schade'), and routine grouping caps at two even for subscribers or duplicates habits and empties tabs; CORE_TODO 5 (1.00%, 3.80), CORE_LISTS 6 (1.20%, 2.83), CORE_ROUTINES 2 (0.40%, 2.00); named as a purchase trigger

- **Where:** §4.4; §3.5 CORE_TODO; §6.2
- **This app does:** to-do list paid; no reminders
- **User reaction:** mixed
- **Magnitude:** CORE_TODO 5 (1.00%) 3.80; CORE_LISTS 6 (1.20%) 2.83
- **Direction for us:** research · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `7483566770`, `9154786620`, `9506447076`, `11268878695`, `10370996938`, `10802638244`, `9093256402`
- **Canonical:** C045 Grouping / folders / categories / tags; C050 One-off to-dos alongside habits

### R65-029 — One surface, no ecosystem — platform_gaps 55 (11.04%, high-priority, mean 4.25): no widget (43), no Apple Watch (REQ_WATCH 5, 1.00%, 3.80 — two frame it as how they would actually get reminded), no working iPad layout (REQ_IPAD 2; crashes on iPad iOS 12.5; reminders absent on iPad), no desktop (REQ_DESKTOP 2), sync asked for as if it does not exist (SYNC_REQ 4, 0.80%, 4.75); an Android build exists but does not bridge; feature inventory (verbatim): Capability | Evidence | Representative IDs ; Habit creation, custom + from a built-in library | Strong — CORE_HABIT 32, CORE_SUGGEST 3, CORE_FLEX 5 | 6414807334, 8186043531, 8286005431, 8438753559 ; Plant/garden reward, plant death on a miss | Strong — GAM_PLANT 21, GAM_PLANT_NEG 4 | 6056995445, 6585144103, 7352688259, 10912209986, 12590814225 ; Reminders / notifications per habit | Strong, mostly as failure — REM_GOOD 15, REM_FAIL 66 | 5941677277, 6514843873, 11020418127, 13253396607 ; Per-habit timer (real-time counting) | Moderate — CORE_TIMER 8, BUG_TIMER 3 | 6088717287, 6093103985, 7851322556, 10819138875 ; To-do lists / task lists, separate from habits | Moderate — CORE_TODO 5, CORE_LISTS 6 | 7483566770, 7814903872, 9093256402, 9506447076 ; Day segmented morning / afternoon / night | Weak but specific | 8254907479 ; Routines / habit categories grouping | Weak — CORE_ROUTINES 2 | 10370996938, 10802638244 ; Progress statistics, calendar, streaks | Moderate — STAT_GOOD 5 | 6414807334, 9346366727, 9542403813, 10155950315 ; Water / food / exercise built-in trackers | Weak | 8521754652 ; Vacation mode | Weak | 8521754652 ; Light and dark mode | Weak — DES_DARK 3 | 8521754652, 9389602987, 11357344130 ; Coin economy + rewarded video, purchasable fertiliser | Weak — GAM_COIN 2, GAM_FERT 1 | 7700397006, 9675886967, 10092963636, 7582838275 ; Account + cross-device restore | Present and broken — ACCT_SIGNIN 5, ACCT_RESTORE 3 | 7743115044, 8286530670, 8336984761, 9330471845 ; An Android build exists | Weak but explicit | 7743115044, 9330471845 ; Widget | Absent — 43 requests, zero reports of one existing | §0.6 ; Apple Watch | Absent — 5 requests | 7697840101, 9648955219, 9717252502, 10340005208 ; iPad-optimised layout | Absent or broken | 6971635908, 10914233763, 10966742339 ; Desktop/web | Absent | 8656794708, 10316293721 ; "X times per week" scheduling | Absent — 9 requests | §0.7 — S5 Apple Watch; S6 iCloud sync — the sync requests and entitlement failures share a root: no reliable account layer

- **Where:** §4.5; §2.1 table (verbatim); §3.6 platform gaps; §9.2 S5, S6
- **This app does:** iPhone only
- **User reaction:** complaint
- **Magnitude:** platform_gaps 55 (11.04%) 4.25; WATCH 5; SYNC 4
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `7697840101`, `9648955219`, `9717252502`, `8490235303`, `6971635908`, `10914233763`, `10966742339`, `8656794708`, `6172014611`, `11357344130`
- **Canonical:** C013 Cloud sync / multi-device as the paid differentiator; C022 Apple Watch app (done properly: timer, two-way sync); C044 Mac / desktop / web app; C051 Android version; C141 Native iPad layout; C271 One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store

### R65-030 — Unmet needs — requests_any 89 (17.87%, high-priority, mean 4.29 — 'these are your satisfied users') (verbatim): Request | Code | n | % of 498 | Band | Mean ★ ; Home/lock-screen widget | REQ_WIDGET | 43 | 8.63% | High-priority | 4.30 ; "X times per week", any day | CORE_FREQ | 9 | 1.81% | Meaningful | 4.11 ; Apple Watch | REQ_WATCH | 5 | 1.00% | Meaningful | 3.80 ; Cloud/iCloud sync, multi-device | SYNC_REQ | 4 | 0.80% | Emerging | 4.75 ; A language (es/de/ru/vi) | LOC_REQ | 4 | 0.80% | Emerging | 4.25 ; More plant varieties | GAM_PLANT_VARIETY | 3 | 0.60% | Emerging | 4.67 ; Mood / feelings diary, wellness prompts | REQ_MOOD | 3 | 0.60% | Emerging | 5.00 ; Audible alarm, not a silent banner | REQ_SOUND | 3 | 0.60% | Emerging | 3.00 ; Skip a day without losing the plant | CORE_SKIP | 2 | 0.40% | Weak | 4.50 ; Notes / description field per habit | REQ_DESC | 2 | 0.40% | Weak | 4.50 ; iPad-optimised layout | REQ_IPAD | 2 | 0.40% | Weak | 3.50 ; Desktop/web version | REQ_DESKTOP | 2 | 0.40% | Weak | 3.00 ; Performance charts over time | REQ_GRAPH | 2 | 0.40% | Weak | 5.00 ; Alternate app icons | REQ_APPICON | 2 | 0.40% | Weak | 4.50 ; Priority level per habit | CORE_PRIORITY | 1 | 0.20% | Weak | 5.00 ; % completion score alongside streak | REQ_STATS | 1 | 0.20% | Weak | 5.00 ; Archive/hide completed items | REQ_ARCHIVE | 1 | 0.20% | Weak | 4.00 ; Custom day-reset time | REQ_RESETTIME | 1 | 0.20% | Weak | 2.00 ; Richer, placeable garden (FarmTown-style) | GAM_MORE | 1 | 0.20% | Weak | 3.00 ; Book/pages reading goal type | REQ_READING | 1 | 0.20% | Weak | 4.00 ; More habit icons | REQ_HABITICON | 1 | 0.20% | Weak | 5.00 ; Checklists/sub-steps inside a habit | REQ_CHECKLIST | 1 | 0.20% | Weak | 5.00 ; Exercise/stretch content | REQ_EXERCISE | 1 | 0.20% | Weak | 5.00 ; Calendar notes on why a habit was missed | REQ_NOTES | 1 | 0.20% | Weak | 4.00 ; More personalisation, unspecified | REQ_CUSTOM | 1 | 0.20% | Weak | 2.00 — S7: notes field per habit and completion-% score alongside the streak — small, cheap, requested by engaged users; REQ_MOOD 3 (0.60%, 5.00) mood / feelings diary; REQ_SOUND 3 (0.60%, 3.00) an audible alarm not a silent banner

- **Where:** §3.6 table (verbatim); §9.2 S7
- **This app does:** absent
- **User reaction:** complaint
- **Magnitude:** 89 (17.87%) 4.29
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11641681635`, `13038216598`, `8241031108`
- **Canonical:** C011 Weekly / monthly / yearly reports; C018 App-icon themes; C049 Mood tracker; C074 Customisable, louder reminder sounds; C172 Per-day / per-habit notes and journal text; C173 Sub-tasks / sub-routines nested inside a habit or routine

### R65-039 — What people like in the core loop, beyond design: CORE_HABIT 32 (6.43%, high-priority, mean 4.97) habit creation custom and from a built-in library; CORE_FLEX 5 (1.00%, 5.00); CORE_SUGGEST 3 (0.60%, 5.00) suggestions; STAT_GOOD 5 (1.00%, 4.60) progress statistics, calendar, streaks; DES_DARK 3 (0.60%, 5.00) light and dark mode; built-in water / food / exercise trackers and a vacation mode named once; weak requests: performance charts over time (REQ_GRAPH 2), alternate app icons (REQ_APPICON 2), habit description / notes (REQ_DESC 2), priority per habit, archive completed items, book / pages reading goal, checklists inside a habit, exercise content, calendar notes on why a habit was missed

- **Where:** §3.1 CORE_HABIT, CORE_FLEX, STAT_GOOD, DES_DARK, CORE_SUGGEST, REQ_*
- **This app does:** free core
- **User reaction:** praise
- **Magnitude:** CORE_HABIT 32 (6.43%) 4.97; STAT_GOOD 5; DES_DARK 3
- **Direction for us:** build-free · **Report confidence:** high-priority / weak · **Generalisable:** generalisable
- **Review IDs:** `8186043531`, `8286005431`, `8438753559`, `9346366727`, `9389602987`, `11357344130`, `8521754652`
- **Canonical:** C011 Weekly / monthly / yearly reports; C080 Colour themes / dark mode

## Monetization

### R65-012 — A six-year price history reconstructed from reviews (verbatim): Period | What reviewers report | Evidence ; May 2020 – Oct 2020 | Fully free. No paid tier mentioned by anyone. Reviewers plead that it stay free. | 5992963467, 6022353006, 6148957286, 6244323855, 6283900339 ; Nov 2020 | Premium launches, and takes a capability that already existed: marking the previous day. | 6637705176, 6643782641 ; 2021 – 2022 | Optional subscription ("Plus"/"Premium"), monthly and annual, with a 7-day trial. Free tier still allows many habits and is repeatedly praised as unusually generous. | 7068513904, 7187761828, 8201707258, 9056065887 ; Jun 2022 – Nov 2022 | Price reported as R$299–R$300/month by three independent reviewers; one explicitly calls it a bug against an expected R$29.90. | 8787259760, 8841492479, 9305007119 ; Aug 2022 | One reviewer reports R$600 and uninstalls out of fear of subscribing by accident. | 8982876143 ; Dec 2022 – 2023 | Ads introduced, then a free habit cap reported at 3/4/5/6 in different months. To-do list and backup move behind the paywall. | 9425433726, 9550931363, 9668193107, 9702733718, 10491574732 ; Mar 2023 | R$30/month reported. | 9690555106 ; Jul 2023 | €40/year reported (Spain). | 10166609858 ; Nov 2023 | R$199.90 charged after a trial the reviewer says they had cancelled. | 10569094114 ; Jan 2024 | A$59.99 reported (Australia). | 10769571369 ; Feb 2024 | $40 lifetime reported (US), described as affordable. | 10936188003 ; Apr 2024 | R$29.90 premium — paid, with a lifetime tier also on sale. | 11213091836 ; 2024 – 2026 | Lifetime ("vitalício") is the tier people mention wanting or buying. | 11410699904, 12002090537, 12794885676, 13808763562 — free / paid / trial classification (verbatim): Tier | Capabilities reviewers place there | Certainty ; Free (2020 – late 2022) | Unlimited or generous habit count, timer, reminders, plants, stats, dark mode | High — 48 reviews ; Free (2023 →) | 4–6 habits, ads on completion, no to-do list, no backup | High — 34 reviews ; Paid (Plus/Premium) | Habits above the cap, to-do list, backup/restore, previous-day marking, extra plants, ad removal, "routines" grouping | High ; Trial | 7 days, repeatedly reported as charging immediately or failing to start | Moderate — 7394381441, 8071399416, 10096220193, 10569094114 ; One-time / lifetime | Exists from at least 2024 ($40 US) | Moderate — 10936188003, 11213091836, 13808763562 ; Consumables | Coins earned by watching video ads; fertiliser purchasable | Low-moderate — 7582838275, 7700397006, 9675886967, 10092963636 ; Unclear | Whether notifications were ever gated — one reviewer asks (11670087069). No evidence they are; treated as a bug throughout | Low — §2.4: Rabit monetises the number of habits while its behavioural engine (plants, streaks, reminders) rewards consistency, not volume — 'the paywall taxes the axis users do not value while leaving the axis they do value free-but-broken'; 'Seria legal manter uma versão free com outras funcionalidades pagas mas não bloquear o uso do aplicativo'

- **Where:** §2.2 table (verbatim); §2.3 table (verbatim); §2.4
- **This app does:** Nov 2020 premium took previous-day marking; ads + cap Dec 2022–2023; lifetime $40 by 2024
- **User reaction:** mixed
- **Magnitude:** R$29.90/mo; €40/yr; A$59.99; $40 lifetime
- **Direction for us:** none · **Report confidence:** high · **Generalisable:** app-specific
- **Review IDs:** `6637705176`, `6643782641`, `10008521499`, `10936188003`, `11213091836`, `10569094114`
- **Canonical:** C001 Never move a free feature behind the paywall; C003 Lead with a one-time lifetime purchase; C010 Backfill missed days / edit start date; C020 Data export / backup / CSV; C133 Gate on capability, not on quantity

### R65-034 — Upgrade barriers — PAY_BARRIER 16 (3.21%, very strong, mean 3.25 — 'not angry people… interested people who stopped') (verbatim): Barrier | n | Evidence ; A missing feature the purchase was conditional on | 7 | Widget: 11570813316, 12002090537, 12794885676, 10316293721. Notifications: 11213091836, 11410699904. Frequency scheduling: 8590687133. ; Subscription instead of one-time purchase | 3 | 8201707258 (*"Uma pena a versão paga ser assinatura mensal… se fosse compra única com certeza adquiria"*), 10155950315, 10166609858 ; Price | 13 | 7006243585, 8564602907, 8787259760, 9690555106, 10769571369 ; Price that appears to be wrong | 4 | 8787259760, 8841492479, 8982876143, 9305007119 — see below ; Perceived manipulation | 5 | 7107263060, 7582838275, 8071399416, 9554337978, 9564856446 ; The paid tier does not add enough | part of 16 | 9536854678 (*"Si compras la versión de pago no hay muchos cambios"*), 10092963636 (*"não há grandes diferenças quando paga"*) ; Affordability as a student | 1 | 8222996948 ; Cannot find the price at all | 1 | 7598847727 ; The purchase itself fails | 3 | 10008521499, 10092963636, 10096220193 — a missing feature the purchase was conditional on (7: widget 4, notifications 2, frequency 1); subscription instead of one-time ('Uma pena a versão paga ser assinatura mensal… se fosse compra única com certeza adquiria'; PAY_ONETIME 3, 0.60%, 3.67); the paid tier does not add enough ('Si compras la versión de pago no hay muchos cambios'; 'não há grandes diferenças quando paga'); PAY_PRICE 13 (2.61%, 3.54); student affordability (PAY_STUDENT 1); cannot find the price at all; perceived manipulation (PAY_DARK 5, 1.00%, 1.40); M2: promote the lifetime tier — it already existed ($40) but 2023 reviewers still asked for it as though it did not — 'Discoverability, not creation'; PAY_LIFETIME 7 (1.41%, 3.57) mixed

- **Where:** §6.3 table (verbatim); §9.3 M2; §6.7 #5
- **This app does:** lifetime exists but not seen
- **User reaction:** blocked-conversion
- **Magnitude:** BARRIER 16 (3.21%) 3.25; ONETIME 3; PRICE 13 (2.61%) 3.54; DARK 5 (1.00%) 1.40; LIFETIME 7 (1.41%) 3.57
- **Direction for us:** build-paid · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `8201707258`, `10155950315`, `10166609858`, `9536854678`, `10092963636`, `8222996948`, `7598847727`, `7107263060`, `10936188003`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C064 Price level — where 'fair' turns into 'too expensive'; C133 Gate on capability, not on quantity; C284 Verify the rendered price string in every storefront currency — a decimal or tier error on the paywall suppresses conversion invisibly, because nobody who closes a paywall writes a review

## Tactics the app used

### R65-023 — Visible fixes bring reviewers back: DEV_FIX 3 (0.60%, mean 5.00) — when the team shipped a visible fix in Jul 2021 (the first-run block) and Jul 2023, reviewers returned to say thank you — they thank the team for shipping, not for replying (no developer replies in the corpus)

- **Where:** §3.3 N7 DEV_FIX
- **This app does:** fixed first-run block in days
- **User reaction:** praise
- **Magnitude:** 3 (0.60%) 5.00
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `7630352804`, `7603303804`, `10143313722`
- **Canonical:** C059 Be visibly responsive; fixes bring reviewers back

### R65-040 — A coin economy funded by rewarded video, with purchasable fertiliser: GAM_COIN 2 (0.40%, mean 4.50) — an ad-funded route to premium goods for some, but the videos fail and the ad cannot be closed so coins cannot be earned; GAM_FERT 1 (2.00)

- **Where:** §3.5 GAM_COIN; §2.3 consumables
- **This app does:** coins via rewarded video; fertiliser IAP
- **User reaction:** mixed
- **Magnitude:** GAM_COIN 2 (0.40%) 4.50
- **Direction for us:** research · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `7700397006`, `9675886967`, `10092963636`, `7582838275`
- **Canonical:** C238 A rewarded-ad unlock path for users who cannot pay (teens, students)

## Insights (the why)

### R65-004 — The notification failure directly costs revenue: three reviewers were about to buy and stopped — 'Eu ia comprar o Vitalício… Sem notificação o app não faz muito sentido, uma pena eu ia assinar o vitalicio'; 'estava pensando em comprar o acesso vitalício, mas…'; 'Estou testando para poder assinar, porém duas funções primordiais para mim não funcionam' — and three more paid first and then found out; 10 of 49 payers (20.4%) report it ('Paguei o premium anual… mas acaba sendo inútil, pois a função lembrete não funciona'); three refunds requested over it

- **Where:** §0.1 revenue; §6.3 barrier; §6.7 #1
- **This app does:** reminders broken for payers
- **User reaction:** blocked-conversion
- **Magnitude:** 3 abandoned purchases; 10/49 payers; 3 refunds
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11213091836`, `11410699904`, `10819138875`, `11038596675`, `11391895419`, `11783159029`, `10142865647`, `10002348801`, `11519711627`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C039 Reminders fire reliably, once; C065 Paying customers are the highest 1★ risk — every paid feature must work

### R65-005 — The habit loop's first step is the notification: a reviewer describes the loop unprompted — 'Para criar um hábito segue um círculo onde tem o gatilho (notificação do App), rotina (a sua atividade) e por fim a recompensa (sua árvore crescendo)' (cue, routine, reward) — so with notifications broken 'the loop's first step is broken for a large share of current users'; the one defect that makes the product's own mechanism impossible to run

- **Where:** §3.4 P2; §9.6
- **This app does:** reminders are the cue
- **User reaction:** complaint
- **Magnitude:** REM_FAIL 66
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `9942909088`
- **Canonical:** C039 Reminders fire reliably, once

### R65-009 — The free tier was the differentiator: PAY_FREE_OK 48 (9.64%, high-priority, mean 4.88 — second-highest mean of any high-priority theme), explicitly positioned against competitors' caps: 'te deja añadir más de 3 hábitos en su versión gratuita'; 'no ridiculous paywalls. everything you need is free. you can log more than three habits for the free version'; 'Fiquei perplexa ao baixar e vê que as funções premium não são as funções principais' — 'Rabit's free tier was not a cost — it was the acquisition engine and the review engine'; 15.3% of E2 → 2.2% of E3; COMP_BEST 31 (6.22%, mean 4.68) tried alternatives and chose it ('Baixei uma dúzia de Habit Trackers e esse, sem dúvidas, é o melhor') and still runs 5.5% of E4 attached to complaints

- **Where:** §0.3; §3.4 P4; §8.3 point 3; §2.5
- **This app does:** generous free tier (2020–2022)
- **User reaction:** 5★-burst
- **Magnitude:** PAY_FREE_OK 48 (9.64%) 4.88; E2 15.3% → E3 2.2%; COMP_BEST 31 (6.22%) 4.68
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `7187761828`, `9056065887`, `7701107699`, `8718500987`, `6872045225`, `11564126929`
- **Canonical:** C005 Know which competitors buyers compare against; C007 Generous fixed habit cap (or unlimited) — never change it; C061 Goodwill conversion — a generous free tier and 'support the devs'

### R65-015 — Design is the strongest positive: design_praise 106 (21.29%, high-priority, mean 4.57) — DES_CUTE 79 (15.86%, mean 4.48, the single most-cited attribute: 'fofo/fofinho', the colours, icons, hand-drawn feel) + DES_SIMPLE 58 (11.65%, 4.74); durable across eras (19.4% → 13.0% → 10.2%) — 'the design remains the last thing people like'; 'це одна з небагатьох програм де до UX віднеслись серйозно. 5 зірочок лише за це' (uk); DES_CUTE in 2 one-star and 4 two-star reviews — 'people keep praising the design in the same breath as abandoning the app'; theme direction by rating (verbatim): Theme | 5★ | 4★ | 3★ | 2★ | 1★ | Reading ; REQ_WIDGET | 20 | 18 | 3 | 2 | 0 | Overwhelmingly a satisfied-user request ; REM_FAIL | 9 | 15 | 13 | 19 | 10 | Spans the whole range — the 5★/4★ half is "great app, one fatal flaw" ; PAY_PAID | 4 | 5 | 8 | 5 | 27 | Purchase evidence, not sentiment — but see §6.1 ; GAM_PLANT | 14 | 6 | 1 | 0 | 0 | Almost purely positive ; DES_CUTE | 54 | 17 | 2 | 4 | 2 | Positive even inside negative reviews

- **Where:** §0.5; §3.4 P1; §5.7 table (verbatim); §8.3
- **This app does:** cute hand-drawn design
- **User reaction:** praise
- **Magnitude:** 106 (21.29%) 4.57; DES_CUTE 79 (15.86%) 4.48; DES_SIMPLE 58 (11.65%) 4.74
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `11971879081`, `10507733525`, `10802638244`, `10008521499`, `10047293918`
- **Canonical:** C134 Lead the store listing with what users actually love

### R65-033 — What triggers a purchase, in reviewers' words (verbatim): Trigger | Evidence | IDs ; Wanting to remove the habit cap | The most common stated reason after 2023 | 9667634914, 9702623382, 10134110248 (implied by the complaint) ; The to-do list | Paywalled, and named as the thing wanted | 7814903872, 9154786620, 9093256402 ; Removing ads | 10240334663: *"I paid so I wouldn't have ads"* | 10240334663 ; Supporting the developer | 9067455099: *"comprei uma assinatura de 1 ano para desbloquear todas as features e apoiar o desenvolvimento"* | 9067455099 ; Liking it fast | 11213091836: *"nos primeiros 15 minutos usando o app eu ja gostei. Assinei o Premium por 29,90"* | 11213091836 ; A lifetime price that reads as fair | 10936188003: *"I love how affordable it is to get Rabit Plus for $40, which last forever!"* | 10936188003 ; Backup / not losing progress | Backup moved behind the wall; that is what 10491574732 was pushed toward | 10491574732 ; Extra plants | 8241031108 wants more plants in free; 10232073862 had bought plants under Plus | 8241031108, 10232073862 — removing the habit cap is the most common stated reason after 2023; the to-do list; removing ads ('I paid so I wouldn't have ads'); supporting the developer ('comprei uma assinatura de 1 ano para desbloquear todas as features e apoiar o desenvolvimento'); liking it fast ('nos primeiros 15 minutos usando o app eu ja gostei. Assinei o Premium por 29,90'); a lifetime price that reads as fair ('I love how affordable it is to get Rabit Plus for $40, which last forever!'); only 2 (0.40%, PAY_WORTH, 5.00) say paid was worth it

- **Where:** §6.2 table (verbatim)
- **This app does:** cap, to-do, ads, lifetime
- **User reaction:** purchase-driver
- **Magnitude:** PAY_WORTH 2 (0.40%) vs PAY_VALUE_NEG 16 (3.21%) 2.31
- **Direction for us:** none · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `9667634914`, `9702623382`, `10240334663`, `9067455099`, `11213091836`, `10936188003`, `10559482117`
- **Canonical:** C003 Lead with a one-time lifetime purchase; C097 A tip / donate option

### R65-036 — Ratings by band (verbatim): ★ | n | % of corpus | Top themes in the band (n, % of band) ; 5 | 243 | 48.80% | GEN_PRAISE 56 (23.0%); DES_CUTE 54 (22.2%); DES_SIMPLE 50 (20.6%); PAY_FREE_OK 44 (18.1%); OUT_LIFE 44 (18.1%); CORE_HABIT 31 (12.8%); COMP_BEST 25 (10.3%); REQ_WIDGET 20 (8.2%) ; 4 | 76 | 15.26% | REQ_WIDGET 18 (23.7%); DES_CUTE 17 (22.4%); REM_FAIL 15 (19.7%); GAM_PLANT 6 (7.9%); CORE_FREQ 6 (7.9%); PAY_BARRIER 6 (7.9%); CONF_UX 5 (6.6%); PAY_PAID 5 (6.6%) ; 3 | 45 | 9.04% | REM_FAIL 13 (28.9%); PAY_PAID 8 (17.8%); BUG_UPDATE 4 (8.9%); PAY_VALUE_NEG 4 (8.9%); PAY_FREE_LIMIT 4 (8.9%); BUG_OPEN 3 (6.7%); DATA_LOSS 3 (6.7%); BUG_STREAK 3 (6.7%) ; 2 | 43 | 8.63% | REM_FAIL 19 (44.2%); PAY_FREE_LIMIT 8 (18.6%); PAY_REGRESS 6 (14.0%); PAY_PAID 5 (11.6%); ADS_BAD 5 (11.6%); COMP_WORSE 5 (11.6%); DES_CUTE 4 (9.3%); REM_NOPERM 4 (9.3%) ; 1 | 91 | 18.27% | PAY_PAID 27 (29.7%); BUG_CRASH 17 (18.7%); BUG_ONBOARD 17 (18.7%); PAY_FREE_LIMIT 17 (18.7%); PAY_REGRESS 13 (14.3%); REM_FAIL 10 (11.0%); BUG_GEN 7 (7.7%); PAY_REFUND 7 (7.7%) — 5★ driven by design and the free tier, not features (only 15 name working reminders; 49 content-free GEN_PRAISE/GEN_NEG reviews, 9.84%); the 4★ band is a feature-request queue — REQ_WIDGET 23.68% of the band, REM_FAIL 19.74%, CORE_FREQ and PAY_BARRIER 7.89% — 'the most commercially useful band'; 3★ is 'I paid and something is wrong, but I still think the app is decent' (REM_FAIL 28.89%, PAY_PAID 17.78%); 2★ REM_FAIL 44.19% — the highest single-theme concentration in any band, where the monetization change and the notification failure meet; §9.4 #3: treat the 4★ band as a roadmap

- **Where:** Part 5 table (verbatim); §5.1; §5.2; §5.3; §5.4; §9.4 #3; part 9 #3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5★ 243 (48.80%); 4★ 76; 3★ 45; 2★ 43; 1★ 91
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10819138875`, `10954472559`, `11391895419`, `11461818487`, `13494106663`
- **Canonical:** C065 Paying customers are the highest 1★ risk — every paid feature must work; C107 Widget variants and customisation as the paid layer

### R65-048 — The highest-value lost users left over policy, not capability: a user who had the app since 2020 uninstalled in 2023 ('antes era mejor'), another recommended it to 30 people before leaving — §9.4 #4: re-engage the E1/E2 cohort

- **Where:** §9.4 #4; part 9 #4; §0.3
- **This app does:** policy changes 2023
- **User reaction:** churn
- **Magnitude:** 2 named
- **Direction for us:** do · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `9575158231`, `9574499267`
- **Canonical:** C191 Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled

## Audiences

### R65-031 — Reported outcomes and sensitive uses: positive_outcome 68 (13.65%, mean 4.88); OUT_LIFE 47 (9.44%, high-priority, 4.89) — weight loss, quitting destructive habits and learning a language, medication adherence ('agora eu não estou mais esquecendo de tomar meus remédios'), managing depression ('m'aide à surmonter ma dépression seulement je ne reçois aucunes notifications donc impossible de se rappeler'), exam routines (USE_STUDY 5, 1.00%, 5.00), morning routine ('milagre da manhã') — for these users a reminder failure is not an inconvenience; only 2 of 498 name ADHD or autism (NEURO 2) despite the 'ADHD Help' subtitle — an ADHD user: 'Esse App é tudo que eu sempre quis', an autistic user asks for an alternate icon ('Sou autista e ele me incomoda muito'); §9.4 #2: re-examine the ADHD positioning before spending further on it

- **Where:** §3.4 P3; §4.6; §9.4 #2; part 9 #2
- **This app does:** subtitle 'ADHD Help'
- **User reaction:** praise
- **Magnitude:** OUT_LIFE 47 (9.44%) 4.89; NEURO 2
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `6056995445`, `7118806721`, `10386047751`, `12993620841`, `8521754652`, `9545808359`, `8564602907`, `10135390586`, `6111763048`
- **Canonical:** C042 Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers; C103 Vulnerable users — recovery, mental-health and minors — are a sensitive surface

## Markets and languages

### R65-041 — Only Brazil (375, 75.30%, mean 3.78) is eligible (verbatim): CC | Storefront | n | % of 498 | Mean ★ | Market group | ≥50? ; br | Brazil | 375 | 75.30% | 3.78 | high-volume | yes ; us | United States | 27 | 5.42% | 3.78 | high-spend | no — limited evidence ; mx | Mexico | 14 | 2.81% | 3.00 | high-volume | no — limited evidence ; es | Spain | 8 | 1.61% | 3.50 | high-spend | no — limited evidence ; ca | Canada | 8 | 1.61% | 2.38 | high-spend | no — limited evidence ; cl | Chile | 7 | 1.41% | 3.86 | high-volume | no — limited evidence ; tr | Turkey | 6 | 1.20% | 2.83 | high-volume | no — limited evidence ; pt | Portugal | 6 | 1.20% | 2.50 | high-volume | no — limited evidence ; co | Colombia | 5 | 1.00% | 3.00 | high-volume | no — limited evidence ; au | Australia | 5 | 1.00% | 3.20 | high-spend | no — limited evidence ; vn | Vietnam | 4 | 0.80% | 4.50 | high-volume | no — limited evidence ; de | Germany | 3 | 0.60% | 3.67 | high-spend | no — limited evidence ; id | Indonesia | 3 | 0.60% | 5.00 | high-volume | no — limited evidence ; ru | Russia | 3 | 0.60% | 5.00 | high-volume | no — limited evidence ; pe | Peru | 3 | 0.60% | 3.00 | high-volume | no — limited evidence ; nz | New Zealand | 3 | 0.60% | 3.33 | high-spend | no — limited evidence ; ec | EC | 3 | 0.60% | 2.00 | other | no — limited evidence ; pl | Poland | 3 | 0.60% | 3.67 | high-volume | no — limited evidence ; fr | France | 2 | 0.40% | 3.00 | high-spend | no — limited evidence ; gb | United Kingdom | 2 | 0.40% | 2.00 | high-spend | no — limited evidence ; in | India | 1 | 0.20% | 5.00 | high-volume | no — limited evidence ; ar | Argentina | 1 | 0.20% | 5.00 | high-volume | no — limited evidence ; be | Belgium | 1 | 0.20% | 3.00 | high-spend | no — limited evidence ; no | Norway | 1 | 0.20% | 3.00 | high-spend | no — limited evidence ; se | Sweden | 1 | 0.20% | 1.00 | high-spend | no — limited evidence ; eg | Egypt | 1 | 0.20% | 4.00 | high-volume | no — limited evidence ; ua | Ukraine | 1 | 0.20% | 5.00 | high-volume | no — limited evidence ; am | AM | 1 | 0.20% | 1.00 | other | no — limited evidence — market groups from markets.py (verbatim): Group | Storefronts present | n | % of 498 | Mean ★ ; High-spend (Tier 1) | au, be, ca, de, es, fr, gb, no, nz, se, us | 61 | 12.25% | 3.33 ; High-volume (Tier 2) | ar, br, cl, co, eg, id, in, mx, pe, pl, pt, ru, tr, ua, vn | 433 | 86.95% | 3.74 ; Outside both tiers | am, ec | 4 | 0.80% | 1.75 — the inversion: the high-spend tier supplies 61 reviews (12.25%) at 3.33 while high-volume supplies 433 (86.95%) at 3.74 — 'essentially the entire written-feedback base sits in the lower-ARPU tier, and the higher-ARPU tier rates it worse'; public ratings Brazil 4,141 (77.2%), Mexico 207, US 193, Chile 116, Spain 59, Portugal 57, Poland 52, Vietnam 51; best rank 3 in Brazil, 39th in the US; §7.8: no claim that Brazilians are more price-sensitive, ad-tolerant or loyal; notification failure is not regional (11 storefronts, 5 languages)

- **Where:** §7.1 table (verbatim); §7.2 table (verbatim); §7.8
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** BR 375 @ 3.78; Tier 1 61 @ 3.33; Tier 2 433 @ 3.74
- **Direction for us:** none · **Report confidence:** high (BR only) · **Generalisable:** generalisable
- **Review IDs:** `9056065887`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R65-042 — Brazil vs rest of world (verbatim): Code | Brazil n | % of 375 | Rest-of-world n | % of 123 | Gap (pp) ; DES_CUTE | 57 | 15.20% | 22 | 17.89% | -2.69 ; DES_SIMPLE | 42 | 11.20% | 16 | 13.01% | -1.81 ; REM_FAIL | 47 | 12.53% | 19 | 15.45% | -2.91 ; REM_NOPERM | 10 | 2.67% | 4 | 3.25% | -0.59 ; PAY_FREE_OK | 38 | 10.13% | 10 | 8.13% | +2.00 ; PAY_FREE_LIMIT | 24 | 6.40% | 10 | 8.13% | -1.73 ; PAY_REGRESS | 13 | 3.47% | 8 | 6.50% | -3.04 ; PAY_PAID | 38 | 10.13% | 11 | 8.94% | +1.19 ; REQ_WIDGET | 24 | 6.40% | 19 | 15.45% | -9.05 ; BUG_CRASH | 21 | 5.60% | 6 | 4.88% | +0.72 ; BUG_ONBOARD | 13 | 3.47% | 9 | 7.32% | -3.85 ; ADS_BAD | 8 | 2.13% | 7 | 5.69% | -3.56 ; OUT_LIFE | 35 | 9.33% | 12 | 9.76% | -0.42 ; COMP_BEST | 25 | 6.67% | 6 | 4.88% | +1.79 ; COMP_WORSE | 5 | 1.33% | 6 | 4.88% | -3.54 ; GEN_PRAISE | 47 | 12.53% | 9 | 7.32% | +5.22 ; CORE_FREQ | 9 | 2.40% | 0 | 0.00% | +2.40 ; PAY_PRICE | 10 | 2.67% | 3 | 2.44% | +0.23 ; GAM_PLANT | 14 | 3.73% | 7 | 5.69% | -1.96 ; BUG_UPDATE | 13 | 3.47% | 1 | 0.81% | +2.65 — public 4,141 @ 4.79 vs written 3.78 (−1.01); CORE_FREQ 100% Brazilian; widget twice as hot outside; onboarding blocks twice as common outside (the expansion audience); ADS_BAD and COMP_WORSE hotter outside — 'Non-Brazilian reviewers were quicker to leave over the 2023 changes; Brazilians complained and largely stayed'; GEN_PRAISE nearly twice as common in Brazil; 366 of 375 Brazilian reviews in Portuguese; DEV_LOCAL 2 (0.40%, 4.50) value that the developer is Brazilian ('Parece-me que o dev é brazuca. Fico muito feliz com isso'; 'Amoo a pegada brasileirinha do app 😍 me sinto em casa') — a real brand asset in the market holding 77% of ratings; 38 of 49 payers Brazilian

- **Where:** §7.3 table (verbatim); DEV_LOCAL
- **This app does:** local Brazilian developer
- **User reaction:** mixed
- **Magnitude:** BR gaps: widget −9.05pp; onboarding −3.85pp; GEN_PRAISE +5.22pp
- **Direction for us:** do · **Report confidence:** high (BR) · **Generalisable:** generalisable
- **Review IDs:** `8353042783`, `11521946693`
- **Canonical:** C027 Localise early — it unlocks revenue; C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R65-043 — US (27, 3.78, public 193 @ 4.70, rank 39) [limited evidence]: 7 of 27 payers, the most detailed free-tier praise and ads complaint, widget asked 6 times, three entitlement / data problems; every other storefront (verbatim): CC | n | Mean ★ | The one thing it contributes ; mx Mexico | 14 | 3.00 | The clearest ads-at-completion reports (9468996936, 9554820095, 9575158231) and four notification failures ; es Spain | 8 | 3.50 | Earliest Spanish-language request (6736603798); habit-cap objections (10122204985, 10166609858); false-streak bug (9386222299) ; ca Canada | 8 | 2.38 | Lowest mean of any storefront with n ≥ 5; three first-run blocks (10299240326, 11036949364, 9498013143) and the clearest REM_NOPERM report in English (13253396607) ; cl Chile | 7 | 3.86 | To-do list vanishing for a payer (9506447076); hard-wall complaint (12938907395) ; tr Turkey | 6 | 2.83 | Two notification reports, one of them the REM_NOPERM symptom in Turkish (12256187890); IAP-introduction complaint (9448959848) ; pt Portugal | 6 | 2.50 | Two first-run blocks (7627353565, 10420884526, 10524274622); home-screen task limit (9193229797) ; co Colombia | 5 | 3.00 | The clearest cross-device entitlement loss (8336984761); a strong free-tier endorsement (11564126929) ; au Australia | 5 | 3.20 | Calendar/streak bug (8405311643); the "like every other tracker now" line (9933931455); price objection (10769571369) ; vn Vietnam | 4 | 4.50 | Language request plus subscription-prompt fatigue (14022775133) ; de Germany | 3 | 3.67 | German-language request (7401118567); the task-list-without-reminders critique (11268878695) ; id Indonesia | 3 | 5.00 | To-do list paywall noted alongside praise (9093256402) ; ru Russia | 3 | 5.00 | Russian-language request (8767676117); widget request (9542403813) ; pe Peru | 3 | 3.00 | Two notification failures, one from a payer threatening refund (11783159029) ; nz New Zealand | 3 | 3.33 | The most detailed single defect report in the corpus (12590814225); hard-wall complaint (11319648289) ; ec Ecuador | 3 | 2.00 | Three notification failures out of three reviews ; pl Poland | 3 | 3.67 | Two widget-conditional purchases (11570813316, 12002090537) ; fr France | 2 | 3.00 | The crying-sound bug (8081220982); depression use case (12993620841) ; gb United Kingdom | 2 | 2.00 | White-screen crash (12385594171); the richest gamification proposal (13038216598) ; in, ar, be, no, se, eg, ua, am | 1 each | — | Single reviews; all included globally, none cited alone for a claim — Canada lowest mean with n ≥ 5 (2.38) with three first-run blocks; Ecuador three notification failures out of three reviews

- **Where:** §7.4; §7.5 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** US 27 @ 3.78; CA 8 @ 2.38; EC 3 @ 2.00
- **Direction for us:** none · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `9425433726`, `10370996938`, `10633935353`, `13253396607`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R65-045 — Localisation (verbatim): Language | n | % of 498 | Mean ★ ; Portuguese | 372 | 74.70% | 3.76 ; English | 70 | 14.06% | 3.46 ; Spanish | 40 | 8.03% | 3.27 ; Turkish | 4 | 0.80% | 2.50 ; Russian | 3 | 0.60% | 5.00 ; German | 2 | 0.40% | 3.00 ; French | 2 | 0.40% | 3.00 ; Vietnamese | 2 | 0.40% | 4.00 ; Indonesian | 1 | 0.20% | 5.00 ; Dutch | 1 | 0.20% | 3.00 ; Ukrainian | 1 | 0.20% | 5.00 — 126 reviews (25.30%) not Portuguese; LOC_GOOD 2 (5.00) praise language choice ('na língua que vc preferir'); LOC_REQ 4 (0.80%, 4.25): Spanish (Dec 2020: 'Solo pediría añadir el español a los idiomas de la app'), German, Russian, Vietnamese; LOC_BUG 1 — a Brazilian reviewer got English onboarding; seven Spanish-speaking storefronts supply 41 reviews at 3.22; research #4: did Spanish ship — reviewers from 2022 write about in-app specifics in Spanish, suggesting yes

- **Where:** §7.7 table (verbatim); §9.5 #4; part 9 #4
- **This app does:** pt + en; es likely later
- **User reaction:** mixed
- **Magnitude:** LOC_REQ 4 (0.80%) 4.25; Spanish-speaking 41 @ 3.22
- **Direction for us:** do · **Report confidence:** emerging · **Generalisable:** generalisable
- **Review IDs:** `7760681050`, `7688851395`, `6736603798`, `7401118567`, `8767676117`, `14022775133`, `11639767100`
- **Canonical:** C027 Localise early — it unlocks revenue

## Dated events and trends

### R65-011 — Users feared the cap before it came: in Jul–Aug 2020 two 5★ reviewers pleaded in advance — 'só espero que quando lançarem o premium não fique pro pessoal gratuito só três hábitos'; 'Porfavor não coloque premium🙏🏻' — both fears came true, one almost exactly (PAY_FEAR 2, 0.40%, mean 5.00)

- **Where:** §3.3 N2 PAY_FEAR
- **This app does:** free, pre-premium
- **User reaction:** praise
- **Magnitude:** 2 (0.40%) 5.00
- **Direction for us:** product-rule · **Report confidence:** weak · **Generalisable:** generalisable
- **Review IDs:** `6244323855`, `6283900339`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it

### R65-020 — Stability arrives in waves tied to releases — stability union 73 (14.66%, high-priority, mean 2.04): BUG_CRASH 27 (5.42%, 1.89), BUG_ONBOARD 22 (4.42%, 1.45 — the lowest mean of any theme with n>10), BUG_OPEN 11 (2.21%, 2.27), BUG_GEN 13 (2.61%, 2.31), BUG_SLOW 6 (1.20%, 3.50), BUG_LAYOUT 3 (0.60%), BUG_OLDIOS 2 (0.40%); incident windows (verbatim): Incident | Window | Window n | Hits | % of window | Mean ★ of hits | Global n of the code ; I1 Onboarding block | 16–31 Jul 2021 | 26 | 12 | 46.2% | 1.42 | BUG_ONBOARD = 22 ; I2 Crash wave | Apr–Nov 2022 | 67 | 13 | 19.4% | 1.77 | BUG_CRASH = 27 ; I3 Ads launch | 23 Dec 2022 – 1 May 2023 | 46 | 12 | 26.1% | 2.33 | ADS_BAD = 15 ; I4 Free habit cap | Jan–Nov 2023 | 99 | 26 | 26.3% | 1.85 | PAY_FREE_LIMIT = 34 ; I5 Notification outage | Nov 2023 – Sep 2026 | 127 | 14 | 11.0% | 3.14 | REM_NOPERM = 14 — I1 the first-run block, 16–31 Jul 2021: 12 of 26 (46.2%, mean 1.42) stuck at the 'good habits are like growing a tree' intro screen or 'the second dot' (verbatim) Review ID | Date | CC | ★ | Title ; 7583592939 | 2021-07-16 | br | 1 | bug ; 7594214123 | 2021-07-19 | br | 1 | Não inicia ; 7606364776 | 2021-07-22 | us | 5 | App would not work ; 7606922821 | 2021-07-22 | br | 1 | Não abre ; 7607428777 | 2021-07-23 | br | 1 | Bug ; 7609032665 | 2021-07-23 | br | 1 | Não consigo entrar ; 7612526826 | 2021-07-24 | br | 1 | Decepcionada ; 7621592414 | 2021-07-26 | us | 1 | Ugh ; 7624625109 | 2021-07-27 | br | 1 | Não funciona!!! ; 7624773603 | 2021-07-27 | br | 1 | Não funciona ; 7625465634 | 2021-07-27 | br | 2 | Não está funcionando ; 7627353565 | 2021-07-28 | pt | 1 | Problemas — fixed within days and people came back: 'CORRIGIRAM O BUG — OBRIGADAAAA! Amei!' — 'the corpus's proof that fast fixes are visibly rewarded here'; I2 the crash wave, Apr–Nov 2022: 13 of 67 (19.4%, mean 1.77), app closing 2–3 seconds after launch, eight from paying subscribers (verbatim) Review ID | Date | CC | ★ | Title ; 8580027859 | 2022-04-18 | br | 1 | Crashando ; 8621971726 | 2022-04-30 | br | 2 | Paguei para usar, mas a última atualização está fechando ; 8654647258 | 2022-05-09 | br | 1 | O app fica aberto dois segundos e fecha sozinho ; 8687587041 | 2022-05-19 | br | 1 | instabilidade ; 8723542944 | 2022-05-30 | br | 1 | Stopped working ; 8733514783 | 2022-06-02 | br | 1 | Não está abrindo ; 8812646607 | 2022-06-26 | br | 4 | Está dando erro ; 8967446592 | 2022-08-11 | br | 3 | Não abre a meses ; 9067455099 | 2022-09-09 | br | 1 | Ótimo app, quando funciona ; 9145791905 | 2022-10-03 | vn | 5 | the app crashes ; 9161732578 | 2022-10-07 | br | 1 | Fecha sozinho ; 9170732248 | 2022-10-10 | br | 1 | O app cai toda hora que eu abro :( ; 9243504386 | 2022-11-01 | br | 1 | Depois de assinar o premium, o app não abre mais — not visibly fixed: 'Não abre a meses' (seven months), 'Havia visto comentários anteriores sobre isso, mas achei que já havia sido resolvido'

- **Where:** §0.8; §3.3 N4; §8.4 I1 table (verbatim); §8.4 I2 table (verbatim); §8.4 table (verbatim)
- **This app does:** release regressions
- **User reaction:** 1★-burst
- **Magnitude:** stability 73 (14.66%) 2.04; I1 12/26 (46.2%) 1.42; I2 13/67 (19.4%) 1.77
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `7609032665`, `7624625109`, `7583592939`, `7625465634`, `7630352804`, `7603303804`, `8580027859`, `9243504386`, `8967446592`, `9170732248`
- **Canonical:** C031 Crashes / launch failures; C059 Be visibly responsive; fixes bring reviewers back; C175 Updates must not break function or wipe progress

### R65-046 — Monetization changed three times in six years and each change is visible in the ratings — eras (verbatim): Era | Window | n | % of 498 | Mean ★ | What defines it (from the corpus) ; E1 Free era | 2020-05-13 → 2020-11-11 | 37 | 7.43% | 4.49 | No paid tier discussed by anyone; PAY_FREE_OK present, PAY_FREE_LIMIT absent. ; E2 Premium introduced | 2020-11-12 → 2022-12-22 | 242 | 48.59% | 4.19 | First premium complaint 6643782641 (12 Nov 2020). Optional paid tier; free tier still generous. ; E3 Ads + habit cap | 2022-12-23 → 2023-10-31 | 92 | 18.47% | 2.98 | First ad complaint 9425433726 (23 Dec 2022); free habit cap complaints begin 27 Jan 2023. ; E4 Notification outage | 2023-11-01 → 2026-09-02 | 127 | 25.50% | 2.98 | First REM_NOPERM report 10566006295 (9 Nov 2023); reminders dominate from here to the end of the corpus. — era means 4.49 → 4.19 → 2.98 → 2.98; the E2 → E3 drop of 1.21 stars coincides exactly with ads plus the free-habit cap; by year (verbatim): Year | n | % of 498 | Mean ★ | 1★ share | Top themes ; 2020 | 45 | 9.04% | 4.47 | 6.7% | CORE_HABIT 10, DES_CUTE 8, GEN_PRAISE 7, DES_SIMPLE 6, PAY_FREE_OK 4 ; 2021 | 118 | 23.69% | 4.04 | 14.4% | GEN_PRAISE 21, DES_CUTE 18, DES_SIMPLE 16, PAY_FREE_OK 14, CORE_HABIT 13 ; 2022 | 120 | 24.10% | 4.27 | 10.8% | DES_CUTE 28, DES_SIMPLE 24, PAY_FREE_OK 23, OUT_LIFE 19, GEN_PRAISE 18 ; 2023 | 106 | 21.29% | 3.06 | 29.2% | PAY_FREE_LIMIT 26, PAY_REGRESS 18, PAY_PAID 15, DES_CUTE 12, ADS_BAD 12 ; 2024 | 67 | 13.45% | 2.93 | 23.9% | REM_FAIL 34, PAY_PAID 10, PAY_BARRIER 6, REQ_WIDGET 6, PAY_VALUE_NEG 5 ; 2025 | 30 | 6.02% | 3.03 | 23.3% | REM_FAIL 14, DES_CUTE 7, REQ_WIDGET 6, REM_NOPERM 6, DEV_STALE 3 ; 2026 | 12 | 2.41% | 2.50 | 33.3% | REM_FAIL 4, PAY_PAID 2, PAY_HARDWALL 2, COMP_BEST 2, BUG_ONBOARD 2 — theme share by era (verbatim): Code | E1 (n=37) | E2 (n=242) | E3 (n=92) | E4 (n=127) ; REM_FAIL | 4 (10.8%) | 2 (0.8%) | 2 (2.2%) | 58 (45.7%) ; REM_NOPERM | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 14 (11.0%) ; REM_GOOD | 3 (8.1%) | 8 (3.3%) | 3 (3.3%) | 1 (0.8%) ; ADS_BAD | 0 (0.0%) | 0 (0.0%) | 13 (14.1%) | 2 (1.6%) ; PAY_FREE_OK | 4 (10.8%) | 37 (15.3%) | 2 (2.2%) | 5 (3.9%) ; PAY_FREE_LIMIT | 0 (0.0%) | 3 (1.2%) | 26 (28.3%) | 5 (3.9%) ; PAY_REGRESS | 0 (0.0%) | 1 (0.4%) | 19 (20.7%) | 1 (0.8%) ; PAY_PAID | 0 (0.0%) | 21 (8.7%) | 11 (12.0%) | 17 (13.4%) ; PAY_ENTITLE | 0 (0.0%) | 2 (0.8%) | 6 (6.5%) | 1 (0.8%) ; BUG_CRASH | 3 (8.1%) | 17 (7.0%) | 3 (3.3%) | 4 (3.1%) ; BUG_ONBOARD | 0 (0.0%) | 12 (5.0%) | 3 (3.3%) | 7 (5.5%) ; REQ_WIDGET | 0 (0.0%) | 19 (7.9%) | 10 (10.9%) | 14 (11.0%) ; DES_CUTE | 7 (18.9%) | 47 (19.4%) | 12 (13.0%) | 13 (10.2%) ; DES_SIMPLE | 5 (13.5%) | 41 (16.9%) | 6 (6.5%) | 6 (4.7%) ; OUT_LIFE | 3 (8.1%) | 29 (12.0%) | 8 (8.7%) | 7 (5.5%) ; GAM_PLANT | 3 (8.1%) | 9 (3.7%) | 5 (5.4%) | 4 (3.1%) ; COMP_BEST | 0 (0.0%) | 21 (8.7%) | 3 (3.3%) | 7 (5.5%) ; COMP_WORSE | 0 (0.0%) | 0 (0.0%) | 9 (9.8%) | 2 (1.6%) ; DEV_STALE | 0 (0.0%) | 0 (0.0%) | 0 (0.0%) | 5 (3.9%) ; GEN_PRAISE | 6 (16.2%) | 40 (16.5%) | 8 (8.7%) | 2 (1.6%) — five unambiguous movements: REM_FAIL 10.8% → 0.8% → 2.2% → 45.7%; REM_NOPERM 0 → 11.0%; PAY_FREE_OK 15.3% → 2.2% as PAY_FREE_LIMIT 1.2% → 28.3% ('The same axis, inverted'); ADS_BAD 0 → 14.1% → 1.6%; GEN_PRAISE 16.2% → 16.5% → 8.7% → 1.6% ('Unqualified affection has essentially disappeared'); persistent: REQ_WIDGET 0 → 7.9 → 10.9 → 11.0%, DES_CUTE 18.9 → 19.4 → 13.0 → 10.2%; PAY_ENTITLE 0.8% → 6.5% in E3

- **Where:** Warning 4; §8.1 table (verbatim); §8.2 table (verbatim); §8.3 table (verbatim)
- **This app does:** free → premium → ads + cap → notification outage
- **User reaction:** mixed
- **Magnitude:** era means 4.49/4.19/2.98/2.98; −1.21 at E2→E3
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `6643782641`, `9425433726`, `10566006295`
- **Canonical:** C001 Never move a free feature behind the paywall; C002 Ratings follow the offer, not the feature set; C104 Never ship a paywall or feature-removal change silently

### R65-047 — Persistent, improving, worsening, disappearing (verbatim): Direction | Themes | Evidence ; Persistent across all four eras | DES_CUTE, DES_SIMPLE, OUT_LIFE, GAM_PLANT, BUG_CRASH, BUG_ONBOARD | See §8.3 ; Improved and then regressed | REM_FAIL (10.8% → 0.8% → 45.7%) | §8.3 point 1 ; Worsening | REM_FAIL, REM_NOPERM, DEV_STALE, PAY_ENTITLE (0.8% → 6.5% in E3) | §8.3 ; Sharp spike, then quiet | ADS_BAD, PAY_FREE_LIMIT, PAY_REGRESS, COMP_WORSE — all concentrated in E3 | §8.4 I3, I4 ; Disappeared | REM_GOOD (8.1% → 0.8%), GEN_PRAISE (16.2% → 1.6%), PAY_FREE_OK (15.3% → 3.9%) | §8.3 ; Never answered | REQ_WIDGET (5 years), CORE_FREQ (6 years, 6319309581 Aug 2020 → 12869653031 Jul 2025), REQ_WATCH, BUG_TIMER (6088717287 Jun 2020 → 10819138875 Jan 2024) | §0.6, §0.7, §4.3 — never answered: widget (5 years), CORE_FREQ (6 years), Watch, timer bug (Jun 2020 → Jan 2024); not supported: attributing any change to a build, reading the 2025–2026 volume decline as improvement, claiming ads were removed, month-level trends (medians 5–7 reviews)

- **Where:** §8.5 table (verbatim); §8.6
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** REM_GOOD 8.1% → 0.8%; GEN_PRAISE 16.2% → 1.6%
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `6088717287`, `10819138875`, `12802262432`, `14502281920`
- **Canonical:** C071 Never ship and walk away; C107 Widget variants and customisation as the paid layer

## Positioning

### R65-001 — Rabit: Daily Routine Planner (App Store ID 1512605216; subtitle 'Habit Tracker & ADHD Help') by GARJ APLICATIVOS LTDA (com.bluebookapple.rabit) — a Brazilian habit tracker with a garden metaphor (each kept habit grows a plant, a miss kills it), per-habit timer, to-do lists, reminders; free → Plus/Premium subscription → ads + free habit cap → lifetime tier; an Android build exists; 498 reviews (every one read), 28 storefronts, 2020-05-13 → 2026-09-02 (6 years 4 months), written mean 3.677 (243×5★, 76×4★, 45×3★, 43×2★, 91×1★); store context from Tools/habit_apps_ranked.json: 5,366 public ratings at 4.76, ranked in 54 storefronts, best rank 3 (Brazil), median 27.5, audience 'moderate'; Brazil holds 4,141 of 5,366 ratings (77.2%) at 4.79

- **Where:** header lines 1-8
- **This app does:** garden habit tracker; free → subscription + ads + cap
- **User reaction:** mixed
- **Magnitude:** 498 reviews; mean 3.677; 5,366 public @ 4.76
- **Direction for us:** none · **Report confidence:** header · **Generalisable:** app-specific
- **Review IDs:** `6056995445`
- **Canonical:** C134 Lead the store listing with what users actually love

## Anti-patterns

### R65-010 — Then the cap arrived: PAY_FREE_LIMIT 34 (6.83%, high-priority, mean 2.00), 26 in Jan–Nov 2023 alone (26.3% of that window, mean 1.85); the cap reported at 3, 4, 5 and 6 habits in different months — 'the limit was moved repeatedly rather than set once' (research #6); PAY_REGRESS 21 (4.22%, mean 1.48); COMP_WORSE 11 (2.21%, mean 2.09), every one Dec 2022 or later: 'um aplicativo que era incrível e muito bem avaliado conseguiu se tornar um aplicativo de hábitos como qualquer outro'; 'now it's like every single habit tracker app out there'; 'eu recomendei pra umas 30 pessoas, ate eles se importarem mais em ganhar dinheiro que ajudar os outros' — 'The competitive position was not lost to a competitor's feature. It was given away'; monetization backlash union (verbatim): Code | n | % of 498 | Band | Mean ★ ; PAY_FREE_LIMIT | 34 | 6.83% | High-priority | 2.00 ; PAY_REGRESS | 21 | 4.22% | Very strong | 1.48 ; PAY_VALUE_NEG | 16 | 3.21% | Very strong | 2.31 ; PAY_PRICE | 13 | 2.61% | Meaningful | 3.54 ; PAY_HARDWALL | 4 | 0.80% | Emerging | 1.50 ; PAY_PRICE_BUG | 4 | 0.80% | Emerging | 4.25 ; PAY_ONETIME | 3 | 0.60% | Emerging | 3.67 ; PAY_DARK | 5 | 1.00% | Meaningful | 1.40 ; PAY_BACKUP | 1 | 0.20% | Weak | 1.00 ; PAY_STUDENT | 1 | 0.20% | Weak | 3.00 ; PAY_PREMIUM_BAD | 2 | 0.40% | Weak | 2.50 ; PAY_FEAR | 2 | 0.40% | Weak | 5.00 — cap-window reviews (verbatim): Review ID | Date | CC | ★ | Title ; 9550931363 | 2023-01-27 | br | 1 | Atualizou para Pior ; 9552323568 | 2023-01-27 | br | 2 | Já foi bom. ; 9574499267 | 2023-02-02 | br | 2 | Pessimo ; 9575158231 | 2023-02-02 | mx | 1 | antes era mejor ; 9667634914 | 2023-03-01 | br | 1 | Limite de hábitos ; 9668193107 | 2023-03-01 | br | 1 | 3 NO MÁXIMO ; 9690555106 | 2023-03-08 | br | 4 | Bom mas não é bombom ; 9702623382 | 2023-03-11 | br | 1 | Era bom ; 9702733718 | 2023-03-11 | mx | 1 | . ; 9717252502 | 2023-03-15 | br | 1 | É bem legal o app e ajuda mas ele não aparece no AppleWatch ; 9729544234 | 2023-03-19 | br | 2 | Pago ; 9857380824 | 2023-04-24 | br | 3 | Widgets e poucos hábitos gratuitos ; 9933931455 | 2023-05-16 | au | 2 | Was good but not anymore😕 ; 10008521499 | 2023-06-07 | br | 3 | Lindo porém limitado pra pagar ; 10032904573 | 2023-06-14 | br | 3 | O App é muito bom, mas limita pra apenas 5 hábitos ; 10034708112 | 2023-06-15 | br | 1 | meio bleh ; 10047293918 | 2023-06-18 | br | 2 | Pago ; 10092963636 | 2023-07-01 | br | 2 | Tem tudo pra ser incrível ; 10122204985 | 2023-07-09 | es | 3 | Bien pero mal ; 10134110248 | 2023-07-13 | br | 1 | Assinante com recursos bloqueados ; 10166609858 | 2023-07-21 | es | 2 | Una pena ; 10188502479 | 2023-07-27 | br | 4 | Fofo, mais limitado ; 10491574732 | 2023-10-19 | br | 1 | Caro ; 10493071866 | 2023-10-19 | br | 2 | Mais ou menos ; 10507733525 | 2023-10-23 | br | 1 | Hábitos gratuitos limitados ; 10543359727 | 2023-11-02 | br | 1 | Não é grátis tem q pagar — M1: raise the free cap materially and paywall depth instead of count

- **Where:** §0.3; §3.3 N2 table (verbatim); §8.4 I4 table (verbatim); §9.3 M1; §0.10 #5; §9.5 #6; part 9 #6
- **This app does:** free cap 3–6, moved repeatedly; to-do and backup paywalled
- **User reaction:** 1★-burst
- **Magnitude:** FREE_LIMIT 34 (6.83%) 2.00; REGRESS 21 (4.22%) 1.48; COMP_WORSE 11 (2.21%) 2.09; union 72 (14.46%) 2.43
- **Direction for us:** build-free · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `9668193107`, `9702733718`, `10188502479`, `9550931363`, `10032904573`, `10047293918`, `10166609858`, `9933931455`, `9552323568`, `9574499267`
- **Canonical:** C001 Never move a free feature behind the paywall; C007 Generous fixed habit cap (or unlimited) — never change it; C104 Never ship a paywall or feature-removal change silently; C133 Gate on capability, not on quantity; C191 Never shrink a tier someone already holds — a paid tier's limits, or free capacity a user has already filled

### R65-022 — The app now looks unmaintained and reviewers say so — DEV_STALE 5 (1.00%, mean 3.40), all 2025–2026; the tell is in-app copy that never changed: 'it keeps saying to start your 2024 year strong… when it's 2025'; 'a mensagem inicial ainda é de 2024'; 'Poderiam verificar o anúncio de compra que está em 2024?' — still 2024 eighteen months later (Sep 2026); 'Tinha tudo pra ser do topo de app de hábitos mas não atualiza'; review volume 120 (2022) → 106 → 67 → 30 → 12 (first eight months of 2026) with the mean not recovering (3.03, then 2.50) — 'Fewer reviews with the same mean is attrition, not repair'; F10: update the 2024 copy — 'Visible, trivial, and currently the clearest public signal that the app is abandoned'; research #7: abandoned or quietly maintained; DEV_NOFIX 1

- **Where:** §0.9; §3.3 N7; §8.2; §9.1 F10; §9.5 #7; part 9 #7
- **This app does:** stale year string on paywall/onboarding
- **User reaction:** churn
- **Magnitude:** DEV_STALE 5 (1.00%) 3.40; volume 120 → 12
- **Direction for us:** dont · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `12262271121`, `12297664838`, `14502281920`, `14201849929`, `9243504386`
- **Canonical:** C071 Never ship and walk away

## Things not to do

### R65-014 — Ads were introduced on completion, the worst possible trigger: ADS_BAD 15 (3.01%, very strong, mean 2.33), 13 in E3; ads union 18 (3.61%, mean 2.39): 'Cada que completo un hábito me aparece un anuncio!!!'; 'No te permite terminar una sola tarea porque ya te sale un anuncio… vengo a desinstalarla después de ver unos 40 anuncios'; 'the ads appear every 30ish seconds. They don't even let you finish what you were doing'; 'a cada hábito que eu crio é um anúncio' — 'An app whose entire behavioural model is complete the habit → see your plant grow → feel rewarded inserted an interstitial exactly at the reward moment'; a reviewer names the intent: 'se o objetivo é fazer pagar o premium ou desistir de usar o app'; the ad's close button renders under the status bar on iPhone 13 forcing a restart (ADS_XBUG); a payer still sees ads; ADS_BAD 0% → 0% → 14.1% → 1.6% — the fall most plausibly the audience having left or paid, ads still reported Sep 2026 ('MUIIIIITOOOOO anúncio'); ads launch window (verbatim): Review ID | Date | CC | ★ | Title ; 9425433726 | 2022-12-23 | us | 2 | Horrible Update ; 9468996936 | 2023-01-04 | mx | 1 | Los anuncios son súper invasivos ; 9547879674 | 2023-01-26 | br | 4 | Anúncios em excesso ; 9550931363 | 2023-01-27 | br | 1 | Atualizou para Pior ; 9552323568 | 2023-01-27 | br | 2 | Já foi bom. ; 9554085652 | 2023-01-27 | be | 3 | Kan beter ; 9554337978 | 2023-01-28 | br | 3 | Muitos anúncios ; 9554820095 | 2023-01-28 | mx | 3 | Muchos anuncios!!!! ; 9574499267 | 2023-02-02 | br | 2 | Pessimo ; 9575158231 | 2023-02-02 | mx | 1 | antes era mejor ; 9582620346 | 2023-02-04 | br | 2 | resolvam isso pelo amor de deus ; 9586030618 | 2023-02-05 | mx | 4 | Reseña — F5: move the interstitial off habit completion; M5: consider removing ads for free users entirely

- **Where:** §0.4; §3.3 N5; §8.4 I3 table (verbatim); §9.1 F5; §9.3 M5; §0.10 #4
- **This app does:** interstitial on habit completion (Dec 2022)
- **User reaction:** churn
- **Magnitude:** ADS_BAD 15 (3.01%) 2.33; I3 12 of 46 (26.1%) 2.33
- **Direction for us:** dont · **Report confidence:** very strong · **Generalisable:** generalisable
- **Review IDs:** `9554820095`, `9468996936`, `9425433726`, `9582620346`, `9554337978`, `9675886967`, `10240334663`, `14502281920`, `12802262432`
- **Canonical:** C127 Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps; C145 Every promotional or onboarding modal must be dismissible on the smallest screen; C240 Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap; C246 No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver

## Things to do

### R65-052 — Ship a notification fix as the next release, before anything else — and when reminders are the product's cue, test on a current iOS device that the app appears in Settings → Notifications after a fresh install; the REM_NOPERM subset, the sharpest diagnostic evidence (verbatim): Review ID | Date | CC | ★ | Title ; 10566006295 | 2023-11-09 | br | 4 | notificação ; 10663002825 | 2023-12-06 | br | 5 | Eu tô amando mas… ; 10788023224 | 2024-01-05 | br | 4 | Notificação IPhone ; 10865879322 | 2024-01-26 | br | 3 | Sem notificações? ; 10879516524 | 2024-01-30 | us | 4 | Not Receiving Notifications ; 11410699904 | 2024-06-22 | br | 5 | Estou amando mas ; 11666871970 | 2024-08-29 | mx | 2 | No suenan notificaciones ; 12256187890 | 2025-02-01 | tr | 3 | . ; 12351584254 | 2025-02-25 | br | 1 | Não notifica ; 12988341658 | 2025-08-07 | br | 2 | Não notifica ; 13198201438 | 2025-09-28 | br | 4 | O que eu precisava! ; 13253396607 | 2025-10-11 | ca | 2 | No notifications !! ; 13494106663 | 2025-12-09 | br | 3 | Notificações ; 14201849929 | 2026-06-19 | br | 2 | Precisa atualizar! — 'This is the longest-running and highest-volume incident in the corpus, and it is still open at the last review'

- **Where:** §0.10 #1; §8.4 I5 REM_NOPERM table (verbatim); §9.1 F1
- **This app does:** no authorization request since Nov 2023
- **User reaction:** churn
- **Magnitude:** REM_NOPERM 14 (2.81%); I5 11.0% of window, mean 3.14
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10663002825`, `10788023224`, `10865879322`, `12351584254`, `13198201438`, `13494106663`, `14201849929`
- **Canonical:** C039 Reminders fire reliably, once

## Contradictions

### R65-051 — Payers are the least-satisfied users here, against the assumption that people who pay are the fans: payer mean 2.061 vs corpus 3.677, payers 3× over-represented in 1★, and the 1★ band's top theme is PAY_PAID (29.67%); and the higher-ARPU market tier rates the app worse (3.33) than the high-volume tier (3.74)

- **Where:** §5.5; §6.4; §0.2
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** payers 2.061 vs 3.677; Tier 1 3.33 vs Tier 2 3.74
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Review IDs:** `10135375382`, `8580027859`
- **Canonical:** C062 Weight English-speaking rich markets; volume ≠ revenue; C065 Paying customers are the highest 1★ risk — every paid feature must work

## Data caveats and method

### R65-002 — Method and limits: signal bands (verbatim) Band | Label | Meaning ; < 0.1% | Ignore | Not promoted unless safety/legal/data-loss ; 0.1 – 0.5% | Weak signal | Recorded, cautious wording ; 0.5 – 1% | Emerging | Worth investigating ; 1 – 3% | Meaningful | Strong candidate ; 3 – 5% | Very strong | Should shape roadmap ; > 5% | High-priority | Strong problem or opportunity — 1095 assignments (2.20 per review) from a 131-code, 13-family hand taxonomy; every review read in original language in ten chunks of fifty; codes renamed while reading (ADHD→NEURO, REQ_ICON→REQ_HABITICON) and CORE_FREQ split out of CORE_FLEX_NEG after review #199; every number machine-filled from the classification; files (verbatim) File | Role ; App Store Reviews/65. Rabit …/reviews.jsonl | The corpus. 498 lines, one JSON object each. SHA-256 76034b02a2c7fcc3d6d73e803ba4a09e80afed9122009e45ee32849a976affd3. ; App Store Reviews/65. Rabit …/by_country/*.jsonl | 28 per-storefront files. Reconciled line-by-line against the main file (§1.3). ; App Store Reviews/65. Rabit …/manifest.json | App metadata, extraction date (2026-09-08T11:58:37Z), per-country counts, rating distribution. ; App Store Reviews/65. Rabit …/_state.json | Crawl state for 82 probed storefronts. Used to establish that the crawl completed. ; Tools/habit_apps_ranked.json | Store-level ratings/ranks. The only external numbers in this report. ; markets.py (repo root) | Storefront tier definitions used for the market groups in §7.2.; coverage (verbatim) Check | Result ; Lines in reviews.jsonl | 498 ; Distinct review_id | 498 — zero duplicates ; manifest.total_reviews | 498 — match ; Sum of 28 by_country/*.jsonl | 498 — match ; Per-country file vs main-file counts | 28 of 28 match; zero country files contain an ID absent from the main file ; manifest.reviews_per_country vs main | match on all 28 ; manifest.rating_distribution vs main | match (243/76/45/43/91) ; Mean rating: computed 3.677 vs manifest 3.677 | match ; _state.json storefronts probed | 82; 0 incomplete; 28 returned ≥1 review; collected sum 498 — match per country ; Reviews classified | 498 of 498 — 100% ; Unknown IDs in the classification | 0 ; Source records with no theme | 0; limitations: 75.30% Brazil (global = Brazilian percentages with a 123-review tail), only Brazil clears 50 (US 27, MX 14, ES 8, CA 8), 9.28% coverage of public ratings, PAY_PAID is evidence of payment not a sample of payers, no version field (eras are complaint-onset dates), single reader without inter-rater statistic, absence of a theme is silence not endorsement; integrity (verbatim) Signal | Finding ; Busiest single day | 4 reviews (2021-07-27, 2023-07-13) across 431 distinct days — 0.80% of the corpus ; Busiest month | 30 reviews (2021-07) — and that month is an *incident* month (§8.4 I1), i.e. negative ; Exact (title, body) duplicates | 0 groups ; Authors appearing more than once | 0 ; Edited reviews | 1 ; Reviews that read as solicited/templated | None found. No repeated phrasing, no rating-prompt artefacts, no clustered 5★ one-word bursts beyond ordinary background rate ; Very short reviews (body ≤ 20 chars) | 35 (7.03%), mean 4.51★ — short *and* positive, the normal App Store pattern, not a manufactured one ; Reviews carrying only GEN_PRAISE/GEN_NEG | 49 (9.84%) — content-free but genuine — no manipulation in either direction; 6 contradicting reviews (1.20%), all 5★ with negative text

- **Where:** How to read this table (verbatim); Eight warnings 1, 2, 7, 8; §1.1 table (verbatim); §1.2; §1.3 table (verbatim); §1.4; §1.5; §1.6; §1.7 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 498 read; 1 eligible storefront; 9.28% coverage; 1.08-star gap
- **Direction for us:** research · **Report confidence:** method · **Generalisable:** generalisable
- **Review IDs:** `7006243585`, `9145791905`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R65-037 — Reviews contradicting their rating — META_CONTRA 6 (1.20%, meaningful), all 5★ with negative text (verbatim): Review ID | Date | CC | ★ | What the text actually says ; 7006243585 | 2021-02-17 | br | 5 | Caro d + — Absurdo de caro o premium ; 7606364776 | 2021-07-22 | us | 5 | App would not work — I have seen so many great reviews for this app, and I was very excited to try it. Unfortunately, I could not get the app to work passed the introduction. I would click t ; 8291821167 | 2022-01-28 | br | 5 | Bug — Não sei pq mais depois da última atualização, ele não abre . Sou Premium. Muitos bugs , toda hora um bug diferente ou o mesmo. ; 8982876143 | 2022-08-16 | br | 5 | lindo mas 600 reais — muito fofinho mas desinstalei por medo de sem querer assinar o plus e ter que viver de aluguel pois custa 600 reais ; 9145791905 | 2022-10-03 | vn | 5 | the app crashes — i don't know why but recently the app has been crashing whenever i open it. ; 12590814225 | 2025-04-27 | nz | 5 | Needs work — It’s a easy to use app, but there are a few issues which are demotivating: 1) miss one day on a habit and the plant dies - sometimes the day doesn’t allow for that particular ha — price complaints and crash reports filed at 5★ inflate the mean by ~0.045; 'Star ratings on this app under-report dissatisfaction rather than over-reporting it'

- **Where:** Warning 7; §5.6 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 6 (1.20%)
- **Direction for us:** none · **Report confidence:** meaningful · **Generalisable:** generalisable
- **Review IDs:** `7006243585`, `7606364776`, `8291821167`, `8982876143`, `9145791905`, `12590814225`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R65-038 — Complete global theme table, all 131 codes (verbatim): Code | Family | Dir | n | % of 498 | Band | Mean ★ ; DES_CUTE | Design & usability | pos | 79 | 15.86% | High-priority | 4.48 ; REM_FAIL | Reminders | neg | 66 | 13.25% | High-priority | 2.91 ; DES_SIMPLE | Design & usability | pos | 58 | 11.65% | High-priority | 4.74 ; GEN_PRAISE | Meta | pos | 56 | 11.24% | High-priority | 5.00 ; PAY_PAID | Monetization | neutral | 49 | 9.84% | High-priority | 2.06 ; PAY_FREE_OK | Monetization | pos | 48 | 9.64% | High-priority | 4.88 ; OUT_LIFE | Outcomes & use cases | pos | 47 | 9.44% | High-priority | 4.89 ; REQ_WIDGET | Account & platform | neg | 43 | 8.63% | High-priority | 4.30 ; PAY_FREE_LIMIT | Monetization | neg | 34 | 6.83% | High-priority | 2.00 ; CORE_HABIT | Core habit tracking | pos | 32 | 6.43% | High-priority | 4.97 ; COMP_BEST | Meta | pos | 31 | 6.22% | High-priority | 4.68 ; BUG_CRASH | Bugs & reliability | neg | 27 | 5.42% | High-priority | 1.89 ; BUG_ONBOARD | Bugs & reliability | neg | 22 | 4.42% | Very strong | 1.45 ; GAM_PLANT | Gamification | pos | 21 | 4.22% | Very strong | 4.62 ; MOT_GOOD | Gamification | pos | 21 | 4.22% | Very strong | 4.86 ; PAY_REGRESS | Monetization | neg | 21 | 4.22% | Very strong | 1.48 ; PAY_VALUE_NEG | Monetization | neg | 16 | 3.21% | Very strong | 2.31 ; PAY_BARRIER | Monetization | neg | 16 | 3.21% | Very strong | 3.25 ; REM_GOOD | Reminders | pos | 15 | 3.01% | Very strong | 5.00 ; ADS_BAD | Ads | neg | 15 | 3.01% | Very strong | 2.33 ; REM_NOPERM | Reminders | neg | 14 | 2.81% | Meaningful | 3.14 ; BUG_UPDATE | Bugs & reliability | neg | 14 | 2.81% | Meaningful | 2.71 ; BUG_GEN | Bugs & reliability | neg | 13 | 2.61% | Meaningful | 2.31 ; PAY_PRICE | Monetization | neg | 13 | 2.61% | Meaningful | 3.54 ; CONF_UX | Design & usability | neg | 12 | 2.41% | Meaningful | 3.50 ; BUG_OPEN | Bugs & reliability | neg | 11 | 2.21% | Meaningful | 2.27 ; COMP_WORSE | Meta | neg | 11 | 2.21% | Meaningful | 2.09 ; DATA_LOSS | Bugs & reliability | neg | 10 | 2.01% | Meaningful | 1.70 ; CORE_FREQ | Core habit tracking | neg | 9 | 1.81% | Meaningful | 4.11 ; PAY_ENTITLE | Monetization | neg | 9 | 1.81% | Meaningful | 1.56 ; CORE_TIMER | Core habit tracking | mixed | 8 | 1.61% | Meaningful | 4.50 ; BUG_CHECK | Bugs & reliability | neg | 8 | 1.61% | Meaningful | 2.12 ; PAY_REFUND | Monetization | neg | 8 | 1.61% | Meaningful | 1.12 ; BUG_STREAK | Bugs & reliability | neg | 7 | 1.41% | Meaningful | 2.43 ; PAY_LIFETIME | Monetization | mixed | 7 | 1.41% | Meaningful | 3.57 ; CORE_LISTS | Core habit tracking | mixed | 6 | 1.20% | Meaningful | 2.83 ; BUG_SLOW | Bugs & reliability | neg | 6 | 1.20% | Meaningful | 3.50 ; META_CONTRA | Meta | neutral | 6 | 1.20% | Meaningful | 5.00 ; CORE_FLEX | Core habit tracking | pos | 5 | 1.00% | Meaningful | 5.00 ; CORE_TODO | Core habit tracking | mixed | 5 | 1.00% | Meaningful | 3.80 ; USE_STUDY | Outcomes & use cases | pos | 5 | 1.00% | Meaningful | 5.00 ; STAT_GOOD | Outcomes & use cases | pos | 5 | 1.00% | Meaningful | 4.60 ; ACCT_SIGNIN | Account & platform | neg | 5 | 1.00% | Meaningful | 2.20 ; REQ_WATCH | Account & platform | neg | 5 | 1.00% | Meaningful | 3.80 ; PAY_TRIAL_BAD | Monetization | neg | 5 | 1.00% | Meaningful | 2.00 ; PAY_DARK | Monetization | neg | 5 | 1.00% | Meaningful | 1.40 ; SUP_SILENT | Support & stewardship | neg | 5 | 1.00% | Meaningful | 1.00 ; DEV_STALE | Support & stewardship | neg | 5 | 1.00% | Meaningful | 3.40 ; GAM_PLANT_NEG | Gamification | neg | 4 | 0.80% | Emerging | 3.00 ; MOT_NEG | Gamification | neg | 4 | 0.80% | Emerging | 3.75 ; SYNC_REQ | Account & platform | neg | 4 | 0.80% | Emerging | 4.75 ; PAY_HARDWALL | Monetization | neg | 4 | 0.80% | Emerging | 1.50 ; PAY_PRICE_BUG | Monetization | neg | 4 | 0.80% | Emerging | 4.25 ; PAY_CHARGE | Monetization | neg | 4 | 0.80% | Emerging | 1.75 ; LOC_REQ | Localisation | neg | 4 | 0.80% | Emerging | 4.25 ; DES_DARK | Design & usability | pos | 3 | 0.60% | Emerging | 5.00 ; CORE_BACKFILL | Core habit tracking | neg | 3 | 0.60% | Emerging | 2.00 ; CORE_SUGGEST | Core habit tracking | pos | 3 | 0.60% | Emerging | 5.00 ; GAM_PLANT_VARIETY | Gamification | neg | 3 | 0.60% | Emerging | 4.67 ; BUG_LAYOUT | Bugs & reliability | neg | 3 | 0.60% | Emerging | 2.33 ; BUG_TIMER | Bugs & reliability | neg | 3 | 0.60% | Emerging | 4.00 ; BUG_WEEKSTART | Bugs & reliability | neg | 3 | 0.60% | Emerging | 3.33 ; ACCT_RESTORE | Account & platform | neg | 3 | 0.60% | Emerging | 1.67 ; PAY_ONETIME | Monetization | neg | 3 | 0.60% | Emerging | 3.67 ; PAY_BUY_FAIL | Monetization | neg | 3 | 0.60% | Emerging | 2.33 ; PAY_CANCEL | Monetization | neg | 3 | 0.60% | Emerging | 1.67 ; DEV_FIX | Support & stewardship | pos | 3 | 0.60% | Emerging | 5.00 ; REQ_MOOD | Requests (other) | neg | 3 | 0.60% | Emerging | 5.00 ; REQ_SOUND | Requests (other) | neg | 3 | 0.60% | Emerging | 3.00 ; DES_ICON_NEG | Design & usability | neg | 2 | 0.40% | Weak | 5.00 ; CORE_FLEX_NEG | Core habit tracking | neg | 2 | 0.40% | Weak | 3.00 ; CORE_SKIP | Core habit tracking | neg | 2 | 0.40% | Weak | 4.50 ; CORE_EDIT | Core habit tracking | neg | 2 | 0.40% | Weak | 2.50 ; CORE_ROUTINES | Core habit tracking | neg | 2 | 0.40% | Weak | 2.00 ; GAM_STREAK_NEG | Gamification | neg | 2 | 0.40% | Weak | 5.00 ; GAM_COIN | Gamification | mixed | 2 | 0.40% | Weak | 4.50 ; MOT_MSG | Gamification | pos | 2 | 0.40% | Weak | 5.00 ; NEURO | Outcomes & use cases | mixed | 2 | 0.40% | Weak | 5.00 ; BUG_OLDIOS | Bugs & reliability | neg | 2 | 0.40% | Weak | 2.50 ; CROSS_ANDROID | Account & platform | neg | 2 | 0.40% | Weak | 2.50 ; REQ_IPAD | Account & platform | neg | 2 | 0.40% | Weak | 3.50 ; REQ_DESKTOP | Account & platform | neg | 2 | 0.40% | Weak | 3.00 ; PAY_PREMIUM_BAD | Monetization | neg | 2 | 0.40% | Weak | 2.50 ; PAY_WORTH | Monetization | pos | 2 | 0.40% | Weak | 5.00 ; PAY_CANCEL_INTENT | Monetization | neg | 2 | 0.40% | Weak | 2.00 ; PAY_FEAR | Monetization | neg | 2 | 0.40% | Weak | 5.00 ; ADS_UPSELL | Ads | neg | 2 | 0.40% | Weak | 2.00 ; DEV_LOCAL | Support & stewardship | pos | 2 | 0.40% | Weak | 4.50 ; LOC_GOOD | Localisation | pos | 2 | 0.40% | Weak | 5.00 ; REQ_GRAPH | Requests (other) | neg | 2 | 0.40% | Weak | 5.00 ; REQ_DESC | Requests (other) | neg | 2 | 0.40% | Weak | 4.50 ; REQ_APPICON | Requests (other) | neg | 2 | 0.40% | Weak | 4.50 ; GEN_NEG | Meta | neg | 2 | 0.40% | Weak | 1.00 ; DES_BUSY | Design & usability | neg | 1 | 0.20% | Weak | 4.00 ; CAL_VIEW | Design & usability | neg | 1 | 0.20% | Weak | 3.00 ; CORE_TOD | Core habit tracking | pos | 1 | 0.20% | Weak | 5.00 ; CORE_PRIORITY | Core habit tracking | neg | 1 | 0.20% | Weak | 5.00 ; CORE_MULTI | Core habit tracking | neg | 1 | 0.20% | Weak | 4.00 ; CORE_HOMELIMIT | Core habit tracking | neg | 1 | 0.20% | Weak | 1.00 ; CORE_WATER | Core habit tracking | pos | 1 | 0.20% | Weak | 5.00 ; CORE_VACATION | Core habit tracking | pos | 1 | 0.20% | Weak | 5.00 ; REM_PAYQ | Reminders | neg | 1 | 0.20% | Weak | 5.00 ; GAM_PLANT_LOST | Gamification | neg | 1 | 0.20% | Weak | 1.00 ; GAM_FERT | Gamification | neg | 1 | 0.20% | Weak | 2.00 ; GAM_MORE | Gamification | neg | 1 | 0.20% | Weak | 3.00 ; USE_MORNING | Outcomes & use cases | pos | 1 | 0.20% | Weak | 5.00 ; USE_MEDS | Outcomes & use cases | pos | 1 | 0.20% | Weak | 5.00 ; USE_MENTAL | Outcomes & use cases | pos | 1 | 0.20% | Weak | 4.00 ; BUG_CAL | Bugs & reliability | neg | 1 | 0.20% | Weak | 5.00 ; BUG_SOUND | Bugs & reliability | neg | 1 | 0.20% | Weak | 2.00 ; PAY_PRICE_INFO | Monetization | neg | 1 | 0.20% | Weak | 5.00 ; PAY_STUDENT | Monetization | neg | 1 | 0.20% | Weak | 3.00 ; PAY_INTENT | Monetization | pos | 1 | 0.20% | Weak | 5.00 ; PAY_AUTORENEW | Monetization | neg | 1 | 0.20% | Weak | 1.00 ; PAY_ADS_PAID | Monetization | neg | 1 | 0.20% | Weak | 1.00 ; PAY_UPSELL | Monetization | neg | 1 | 0.20% | Weak | 4.00 ; PAY_RENEW | Monetization | neutral | 1 | 0.20% | Weak | 1.00 ; PAY_BACKUP | Monetization | neg | 1 | 0.20% | Weak | 1.00 ; ADS_XBUG | Ads | neg | 1 | 0.20% | Weak | 4.00 ; SUP_CONTACT | Support & stewardship | neutral | 1 | 0.20% | Weak | 1.00 ; DEV_NOFIX | Support & stewardship | neg | 1 | 0.20% | Weak | 1.00 ; LOC_BUG | Localisation | neg | 1 | 0.20% | Weak | 2.00 ; REQ_STATS | Requests (other) | neg | 1 | 0.20% | Weak | 5.00 ; REQ_NOTES | Requests (other) | neg | 1 | 0.20% | Weak | 4.00 ; REQ_ARCHIVE | Requests (other) | neg | 1 | 0.20% | Weak | 4.00 ; REQ_RESETTIME | Requests (other) | neg | 1 | 0.20% | Weak | 2.00 ; REQ_HABITICON | Requests (other) | neg | 1 | 0.20% | Weak | 5.00 ; REQ_CHECKLIST | Requests (other) | neg | 1 | 0.20% | Weak | 5.00 ; REQ_READING | Requests (other) | neg | 1 | 0.20% | Weak | 4.00 ; REQ_EXERCISE | Requests (other) | neg | 1 | 0.20% | Weak | 5.00 ; REQ_CUSTOM | Requests (other) | neg | 1 | 0.20% | Weak | 2.00

- **Where:** §3.1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 131 codes; 1095 assignments
- **Direction for us:** none · **Report confidence:** table · **Generalisable:** generalisable
- **Review IDs:** `6414807334`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R65-044 — Public ratings vs written reviews (verbatim): Storefront | Public ratings | Public avg | Written here | Written mean | Gap ; Brazil | 4,141 | 4.79 | 375 | 3.78 | −1.01 ; Mexico | 207 | 4.78 | 14 | 3.00 | −1.78 ; United States | 193 | 4.70 | 27 | 3.78 | −0.92 ; Chile | 116 | 4.84 | 7 | 3.86 | −0.98 ; Spain | 59 | 4.63 | 8 | 3.50 | −1.13 ; Portugal | 57 | 4.60 | 6 | 2.50 | −2.10 ; Poland | 52 | 4.85 | 3 | 3.67 | −1.18 ; Vietnam | 51 | 4.80 | 4 | 4.50 | −0.30 ; All storefronts | 5,366 | 4.76 | 498 | 3.677 | −1.08 — the gap (−1.08 overall; −0.30 Vietnam to −2.10 Portugal) is the ordinary written-review skew: 'both are correct, and the store number is the better estimate of average satisfaction while this report is the better guide to what is broken'; research #3: the silent majority's satisfaction needs an in-app survey

- **Where:** §7.6 table (verbatim); §9.5 #3; part 9 #3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 5,366 @ 4.76 vs 498 @ 3.677
- **Direction for us:** research · **Report confidence:** limited evidence · **Generalisable:** generalisable
- **Review IDs:** `14465169878`
- **Canonical:** C231 Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings

### R65-050 — What is not a finding — silences recorded so they are not mistaken for endorsements: privacy and data handling zero reviews; accessibility one (an autistic user's discomfort with the icon), nothing on VoiceOver, Dynamic Type, contrast; data export zero requests (notable for an app used for years); social / friends / accountability zero either direction; AI zero mentions in 498 reviews 2020–2026 — 'worth knowing before assuming AI features are table stakes in this category'; onboarding discussed 22 times but only because it broke; no developer replies to reviews

- **Where:** §3.7
- **This app does:** n/a
- **User reaction:** none
- **Magnitude:** zeros
- **Direction for us:** research · **Report confidence:** n/a · **Generalisable:** generalisable
- **Review IDs:** `10135390586`
- **Canonical:** C056 Don't build AI features on demand grounds
