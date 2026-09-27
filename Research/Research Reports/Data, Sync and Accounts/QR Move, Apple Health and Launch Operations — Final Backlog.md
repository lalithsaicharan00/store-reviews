# QR Move, Apple Health and Launch Operations — Final Backlog

*Written by Claude (Claude Code), 28 Sep 2026. Research for the last open items in [the Backlog](<../../../Architecture/Backlog.md>). The user set the bar: keep only what is required, what drives downloads or revenue, or what genuinely improves the experience. Remove everything else. The recommendations below were accepted and written into the architecture docs.*

**The questions:**
1. Should free users get a QR phone-to-phone move? Would it make moving easier, or earn goodwill?
2. Apple Health / Health Connect: how common is it, does it drive revenue, and should it be free or Plus?
3. Which OS versions should we support?
4. Can EU users' data stay in the EU on Cloudflare?
5. Which of the remaining operations items are required, and which should go?

**How each point is backed:**
- **Users show**: review evidence from this screen.
- **Platform fact**: vendor documentation, linked.
- **First principles**: reasoned from how the system works.

---

## 1. The short answer

| Item | Recommendation | Why |
|---|---|---|
| **QR phone-to-phone move** | **Remove.** Free users move with the phone's own transfer (same OS) or an export file (iPhone ⇄ Android). Plus users sign in. | Users show that moving between platforms is rare: 1.2 per 10k reviews. The main complaint is a purchase that didn't follow, and the Plus account already fixes that. Free users losing data this way appear in only 4 read reviews. |
| **Apple Health / Health Connect** | **Plus, read-only, in the first update after launch.** | It comes up 10× more often than cross-platform moves (12.5 per 10k, 58 apps). Users praise it and treat it as a reason to pay. When it breaks, it hurts (2.96★), so it should not be rushed into launch. |
| **Day start and week start** | **Ask both in onboarding.** | Users show that a wrong week start is a common complaint (22 read, 2.9★; topic 5). Asking once costs one screen. |
| **OS versions** | **iOS 18+ / watchOS 11+; Android 8.0 (API 26)+ / Wear OS 3+.** | Platform fact: about 88% of iPhones and about 93% of Android devices. |
| **EU data residency** | **Yes:** EU accounts get EU-jurisdiction Durable Objects and an EU R2 bucket. | Platform fact: Cloudflare supports both. |
| **Off-Cloudflare backup copy (Backblaze B2)** | **Remove.** Use point-in-time recovery plus R2 nightly snapshots. | First principles: every Plus user's phones already hold a full copy, and free users have nothing on our server. |
| **Crash reporting** | **Sentry, free tier.** | Needed for crash-loop recovery and the release canary (topic 8). |
| **Analytics** | **PostHog, EU cloud**, with no habit content. | The user's choice. EU hosting matches the residency rule. |
| **Support** | **In-app message plus a shared mailbox, with a reply within 1 working day.** | Users show that a human reply rescues a bad moment: “the team helped me transfer my Fabulous Sphere account” (`A24#21003`), and a Japanese reviewer says a Health sync failure was fixed after a quick chat with support (`A33#1651`). |
| **Public status page, published shutdown promise, lawyer review** | **Remove.** | First principles: nothing depends on them. Incidents show as an in-app banner, and the privacy policy is generated and checked against the data map. |
| **Web sales** | **None.** The web is sign-in only. Windows comes later. | The user's choice. It also keeps one purchase path per store. |

---

## 2. Method

**Screen:** 1,238,784 App Store and Play reviews, three multilingual regex patterns. The strict "I paid" rate across the whole corpus is **1.40%**. It is the baseline for the "say paid" column.

| Pattern | Matches | Apps | Per 10k reviews | Mean ★ | Say they paid |
|---|---|---|---|---|---|
| **Cross-platform move** (iPhone ⇄ Android: switch, transfer, "not synced") | 154 | 28 | 1.2 | 3.38 | 13.6% |
| **Praise for moving to a new phone** | 52 | 21 | 0.4 | 4.27 | 13.5% |
| **Apple Health / Health Connect / Google Fit / Samsung Health** | 1,552 | 58 | **12.5** | 4.18 | 4.6% |

- **Top apps for cross-platform moves:** ShineDay has 74 of the 154, then the two Fabulous apps with 14 each. So the pattern is concentrated in a few apps.
- **Top apps for Health:** Finch 458, Hevy 228, Streaks 199, Habit Tracker 147.

**Read and hand-coded:** 254 reviews:
- **cross-platform moves:** 82 sampled (at most 10 per app); 49 on topic;
- **move praise:** all 52; 8 on topic;
- **Health:** 120 sampled (at most 8 per app); 88 on topic.

Files: [`Final Backlog Evidence/`](<Final Backlog Evidence/>) (`scan.py`, `sample.py`, `cls/`, `coded.json`, `tally.txt`).

---

## 3. The QR move

### 3.1 What users show

| Code | Reviews | Apps | Mean ★ | Say paid |
|---|---|---|---|---|
| **Paid access didn't follow to the other platform** | 23 | 9 | **2.35** | 11 |
| Our app isn't on their new platform | 10 | 5 | 4.80 | 1 |
| Data lost on a cross-platform move (paying or unclear) | 6 | 3 | 1.83 | 3 |
| iPhone and Android data don't sync | 5 | 4 | 3.40 | 0 |
| The move worked | 5 | 4 | 4.60 | 2 |
| Praise for a same-platform move | 5 | 2 | 5.00 | 1 |
| **Data lost on a cross-platform move, free user** | **4** | 3 | 3.50 | 0 |
| Moving was hard | 2 | 2 | 3.50 | 0 |
| Export and import did the job | 1 | 1 | 5.00 | 0 |

**The main complaint is paid access, not data.** Almost half the on-topic reviews (23 of 49) are about a purchase that didn't follow:
- “if you buy premium on one device, you only have access to premium features on that one device” (`P12#30020`);
- “when I asked to transfer from my android to my new iPhone I received no reply email” (`P12#28742`);
- “So all my routines and data will be lost, as well as the premium version I bought!” (`P49#326`).

Our Plus account solves this directly: sign in on the new phone and both the purchase and the data are there. Here the QR move adds nothing.

**Free users losing data on a cross-platform move are rare.** Four read reviews, mostly from Finch:
- “Since I don't have premium, I cannot get back any of my progress” (`P12#24872`);
- “I can not get my finch to successfully transfer from my old android to my iPhone so I’m gutted now” (`A10#9238`).

Even the saddest case stayed at 5★: “it didn’t save any of my progress and I had almost 2 years streak” (`A10#20322`).

**Goodwill from moves is small too.** Only 8 of the 52 "praise" matches were really about moving. They praise clear instructions, not a particular mechanism:
- “The instructions on how to transfer my data worked beautifully and were painless” (`P84#14111`);
- one user donated to unlock the transfer: “That process was seamless and extremely fast!” (`P84#18052`).

### 3.2 Recommendation: remove the QR move

- **It isn't needed for revenue:** payers are covered by the account.
- **It isn't needed for downloads:** 1.2 per 10k reviews, clustered in a few apps.
- **It barely helps free users.** Same-platform moves are already handled by iCloud or Google device backup and the phone's own transfer tool (topic 3). The rare iPhone ⇄ Android move is covered by the export file, which also works with no network.
- **First principles:** a QR move needs a relay, 15-minute server slots and a local-network fallback, which is a second transfer system to test forever. The export file does the same job with a feature we must build anyway.
- **What we keep from the evidence:** clear, short instructions. The "Moving to a new phone?" help page and the export screen say exactly what to do on each platform (users show: `P84#14111`).

---

## 4. Apple Health and Health Connect

### 4.1 What users show

| Code | Reviews | Apps | Mean ★ | Say paid |
|---|---|---|---|---|
| Asks for Health integration | 34 | 20 | 3.59 | 2 |
| Praises Health integration | 31 | 11 | **4.55** | 1 |
| Health integration broken (wrong counts, not syncing, missing types) | 23 | 10 | **2.96** | 4 |
| Health is a must-have | 2 | 1 | 5.00 | 0 |
| Left or switched over it | 2 | 2 | 1.00 | 0 |
| Paid specifically for it | 1 | 1 | 1.00 | 1 |
| Available on iPhone but not Android | 1 | 1 | 1.00 | 0 |

**It is common.** 1,552 matches across 58 of the apps, about 10× the cross-platform move rate. Four big habit apps each have 147–458 mentions.

**Users value it because it removes typing:**
- “I love the interface with Apple Health - so no need to key in that data again” (`A25#508`);
- “Pros include the integration with Health app so many streaks can be tracked automatically” (`A23#6078`);
- on Android: “Thank you for adding health connect. I am missing this in so many apps.” (`P122#14032`).

**It influences choice and payment:**
- “I paid for it specifically for synching with the health app” (`A41#283`);
- the price sets the expectation: “For the price it’s missing sync with health app” (`A13#12396`);
- some leave over it: a 1★ review says only “No Apple health connectivity” (`A36#190`); “I'm switching to Streaks it's better anyways it adds things to apple health” (`A20#3440`).
- Reviews that mention Health say they paid 4.6% of the time, 3.3× the corpus baseline. This is a signal, not proof: Health users skew toward engaged users.
- None of the 88 on-topic reviews complains that Health sits behind a paywall.

**When it breaks, it hurts** (23 reviews, 2.96★). The failures are about trust in the numbers:
- “The steps on the app end up being 2ish times what’s on Apple Health” (`A31#483`);
- “It added all my daily steps to my currently building habit” (`A31#2176`);
- the paying user above, whose data “doesn't sync” (`A41#283`).

### 4.2 Recommendation: Plus, read-only, first update after launch

- **Plus, not free.**
  - Users show it's a reason to pay, and nobody resents the paywall.
  - It is an automation convenience, not core tracking. The free 5 habits stay fully usable by hand.
  - Plus already means "more devices, less effort" (iPad, Watch, sync); Health fits that.
- **Read-only.** We read steps, workouts, sleep and mindful minutes to complete habits. We never write to Health.
  - First principles: writing creates the double-count and wrong-number failures users hate (`A31#483`), and gives us no benefit.
  - Reads use the platform's merged totals and store the source ID (topic 5 §9).
- **First update after launch, not launch.** Users show broken Health is worse than none (2.96★ vs 3.59★ for "please add it"). Launch is about the core. Health gets its own release with its own test pass (topic 8).
- **Both platforms together.** One reviewer was angry to find iPhone-only support: “sync with Apple health. but on Android you have no options” (`P17#1`). So Apple Health and Health Connect ship in the same update.

---

## 5. Onboarding: day start and week start

- **Users show** (topic 5 §2, 242 reviews read): a wrong or fixed week start is the most common sync-engine complaint (22 reviews, 2.9★). People who go to bed after midnight need a later day end (first principles).
- **Recommendation:** onboarding asks two questions, each with a sensible default already selected:
  - **"When does your day end?"** Midnight to noon, in 30-minute steps, default midnight.
  - **"Which day does your week start on?"** Pre-selected from the phone's region.
- Both can be changed later in Settings. The value is stored on the phone for free users and synced for Plus (topic 5 §4.2–4.3).

---

## 6. OS versions (platform fact)

| Platform | Minimum | Reach (mid-2026) | Source |
|---|---|---|---|
| iPhone / iPad | **iOS 18 / iPadOS 18** | about 88% (iOS 26 alone is ~70%) | [TelemetryDeck iOS versions](https://telemetrydeck.com/survey/apple/iOS/majorSystemVersions/) |
| Apple Watch | **watchOS 11** | pairs with iOS 18 | Apple pairing requirements |
| Android phones and tablets | **Android 8.0 (API 26)** | about 93% (Android 10 would reach ~87%) | [Android distribution chart](https://capgo.app/android-distribution-chart/) |
| Wear OS | **Wear OS 3** | the current Wear OS line | Google Wear OS |

- **What most production apps do:** support the current iOS major version plus the one before it, and on Android reach about 90–95% of devices. These choices match that.
- **Health Connect needs a newer Android.** We hide it where it isn't available instead of raising the minimum for everyone.
- **Reviewed every year**, and the app announces it two months before dropping a version (topic 8 §7).

---

## 7. EU data residency (platform fact)

Cloudflare supports keeping data in the EU for each part we use:
- **Durable Objects:** create the object with `jurisdiction: "eu"`, and its storage stays in the EU ([Durable Objects data location](https://developers.cloudflare.com/durable-objects/reference/data-location/)).
- **R2:** create the bucket with EU jurisdiction, and objects stay in the EU ([R2 data location](https://developers.cloudflare.com/r2/reference/data-location/)).
- **D1:** a jurisdiction can be set when the database is created ([D1 data location](https://developers.cloudflare.com/d1/configuration/data-location/)).

**Recommendation:**
- A Plus account's jurisdiction is chosen when it is created, from the store country. It cannot change later.
- EU accounts live in EU Durable Objects, and their snapshots go to an EU R2 bucket.
- The global D1 directory holds only provider IDs → account IDs, never habit data.
- Free users have nothing on our server, so the question doesn't arise for them.

---

## 8. What was removed, and why

| Removed | Why (first principles unless noted) |
|---|---|
| **QR phone-to-phone move**, its relay and local-network fallback | §3: rare, and covered by the account and the export file. |
| **Off-Cloudflare copy (Backblaze B2)** | R2 plus point-in-time recovery covers server mistakes. Every Plus user's phones hold a full copy. A second vendor adds cost, keys and a second place to delete data from. |
| **Server storage for free users** | Free is local only. Their backup is the phone's own backup plus on-device snapshots and export (topic 3). |
| **Public status page** | Users look at the app, not a status site. An in-app banner from `/v1/status` reaches them where they are. |
| **Published shutdown promise** | The shutdown plan stays internal (topic 6 §12). Publishing a formal promise adds obligations without adding safety. |
| **Lawyer review of the privacy policy** | The policy is generated with a standard generator and checked line by line against our data map (topic 9 §11). Small apps normally ship this way. |
| **Web sales and web checkout** | One purchase path per store, with no extra tax or refund handling. The web is sign-in only. |
| **Windows at launch** | Later. |
| **Fitbit, Garmin and other direct integrations** | Health Connect and Apple Health already bring in most wearable data. |

<!-- APPENDIX -->

## Appendix — reviews cited

20 reviews cited. Ref = store letter (A App Store, P Play Store, N native app) + app number + line index in that app's `reviews.jsonl`.

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A10#9238` | `14510819650` | App Store (gb) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-09-04 | 1★ | XOS_DATA_LOST_FREE |
| `A10#20322` | `14254142625` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-07-02 | 5★ | XOS_DATA_LOST_FREE |
| `A13#12396` | `6655719623` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2020-11-17 | 3★ | HEALTH_WANT |
| `A20#3440` | `6928343835` | App Store (us) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2021-01-29 | 1★ | HEALTH_PRAISE, HEALTH_CHURN |
| `A23#6078` | `1469712437` | App Store (us) | 23. Streaks - The habit-forming to-do list | 2016-10-20 | 5★ | HEALTH_PRAISE |
| `A24#21003` | `5941734740` | App Store (om) | 24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help | 2020-05-13 | 5★ | XOS_OK, X_PAYER |
| `A25#508` | `11399786219` | App Store (gb) | 25. Grit - Daily Habit Tracker - Routines & Goals ADHD Planner | 2024-06-19 | 5★ | HEALTH_PRAISE |
| `A31#483` | `9805827528` | App Store (ca) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2023-04-10 | 3★ | HEALTH_BROKEN |
| `A31#2176` | `9123656067` | App Store (ph) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2022-09-26 | 5★ | HEALTH_BROKEN |
| `A33#1651` | `7790208990` | App Store (jp) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2021-09-10 | 5★ | HEALTH_BROKEN, X_PAYER |
| `A36#190` | `13902720788` | App Store (in) | 36. (Not Boring) Habits - Science-backed habit tracker | 2026-03-30 | 1★ | HEALTH_WANT, HEALTH_CHURN |
| `A41#283` | `14223824557` | App Store (eg) | 41. Awesome Habits - Habit Tracker - Streaks, days since & goals | 2026-06-25 | 1★ | HEALTH_BROKEN, HEALTH_BUY_REASON, X_PAYER |
| `P12#24872` | `50b7b08f-c653-40aa-a1ca-180f06c378d4` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2022-05-14 | 3★ | XOS_DATA_LOST_FREE |
| `P12#28742` | `dca66272-4006-41f4-9b08-86a9d43db1f6` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2021-12-29 | 1★ | XOS_PAID_LOST, X_PAYER |
| `P12#30020` | `9960c405-17cd-4f61-8446-cf6a46dcce31` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2021-11-09 | 1★ | XOS_PAID_LOST, X_PAYER |
| `P17#1` | `ca95537c-2cda-41e2-8625-7e71f881f206` | Play Store (en) | 17. Habit Tracker - Daily Routine | 2026-08-30 | 1★ | HEALTH_PARITY |
| `P49#326` | `a06e5ec2-077f-4461-b239-f7df0d78378e` | Play Store (en) | 49. RoutineFlow - Routine for ADHD | 2025-12-21 | 2★ | XOS_PAID_LOST, XOS_DATA_LOST, X_PAYER |
| `P84#14111` | `4a1d5eb5-7951-477a-8e37-4160e2217b7d` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2023-02-25 | 5★ | MOVE_PRAISE, X_PAYER |
| `P84#18052` | `97fdc8aa-1b5c-4b11-a2b6-a71565ed810a` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2021-03-01 | 5★ | MOVE_PRAISE, MOVE_PAID |
| `P122#14032` | `a2d77089-7aad-40aa-ab3e-68e1de02b116` | Play Store (en) | 122. Hevy - Gym Log Workout Tracker | 2024-06-07 | 5★ | HEALTH_PRAISE, HEALTH_MUST |
