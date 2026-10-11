# Android Plus — What Android People Pay For, and Keeping the iPhone and Android Apps the Same

Written by Claude (Claude Code), 11 October 2026, at the user's request: "study the Android much better … on iOS
people pay for the Watch and the tablet … what do we sell in Android then? … if we keep the iOS app very different
from Android, do we get problems? … cross check and do thorough research."

**Status:** approved and filed on 11 October 2026; the decisions that followed it are in the [Android folder's README](<../README.md>).
Every hand coding, script and count is in [`Android Plus Evidence/`](<Android Plus Evidence/>).

---

## 1. The short answer

1. **My earlier summary was wrong in one important way.** Measured the same way on both stores, **paying for sync and
   other devices is just as real on Android as on the iPhone.** Android people pay to use the app on their computer,
   a tablet or a second phone, and to keep their habits when they change phones. What Android doesn't have is the
   **Watch**: people buy iPhone habit apps for the Apple Watch; on Android almost nobody does.
2. **The earlier "iPhone people pay for Watch and iPad" picture came from a table of both stores added together.**
   Split by store, the iPhone and Android lists are close to the same list, in nearly the same order: more habits,
   widgets, sync/other devices, then themes, backup and statistics. The Watch is the only large difference.
3. **Android people pay much less often.** About 1 in 90 Play reviews says the person paid, against 1 in 28 on the App
   Store, and Google Play takes about 30% of what people spend in the two stores (2025 estimate). Android Plus will sell
   fewer copies per user. It doesn't need different contents.
4. **Yes, two different apps cause problems, but only for a small group, and it's the same group that buys.** About
   0.13% of all reviews mention the other platform. They ask for the app on the other platform, complain that the
   other version has more features or a lower price, and above all lose what they paid for when they change from
   iPhone to Android or back.
5. **So Android Plus should be the iPhone's Plus, at the same price:** more than 5 habits, the extra widgets, and
   **sync to your other devices**, with the same purchase working on both stores. The differences are only those the
   platforms force: Wear OS instead of the Apple Watch (later, if at all), and Google Drive instead of iCloud.
6. **Two things can't be copied from the iPhone and need your decision:** how Android sync works without a server
   (§8), and **Plus Family: Google Play can't share an in-app purchase with a family**, so Apple's Family Sharing has
   no Android equivalent (§7).

---

## 2. What I checked, and how

| Question | How | Evidence label |
|---|---|---|
| Who says they paid, on each store | The same payment patterns (13 languages) run over every review: 901,453 Play reviews (146 apps) and 337,331 App Store reviews (70 apps) | Machine count |
| What those payer reviews are about | A seeded random 250 per store, **read one by one** and coded | Users show |
| What people say they paid for, feature by feature | Every English review where a payment word sits within 70 characters of a feature word, in the same sentence; a seeded random 60 per feature per store **read one by one** (960 reviews, 16 files) | Users show (estimates scaled up from the sample) |
| People who use or move between both platforms | Every review naming the other platform (1,341 Play, 291 App Store); a seeded random 150 per store **read one by one** | Users show |
| Store rules, spending, watches, competitors | Google and Apple's own pages; Sensor Tower and Counterpoint figures as reported by others | Platform rule / secondary source |

All hand codings, scripts and counts: `Android Plus Evidence/` (§11). Every review cited below was looked up in
its `reviews.jsonl` by script, not typed from memory. **Limits:** samples of 60 give rough numbers (± a few reviews);
the feature scan is English only; the corpus mixes habit trackers with routine, to-do, gym and self-care apps, and
a few large apps (Fabulous, Tasks, Hevy) weigh heavily; Play has 2.7× more reviews than the App Store, so the tables
compare **rates**, not raw counts.

---

## 3. Where the earlier picture went wrong

The earlier [Plus Scope report](<../../../Research/Research Reports/Business Model and Monetization/Plus Scope and Account at Purchase.md>)
§3 table ("Sync / devices / iPad / Mac 4.3%, Watch 1.7%") counted **both stores together**, and the Android figures
(sync 5.6%, lifetime 17.1%) came from a different scan with different patterns. Comparing those two made Android look
as if it cared about different things. Run once, with the same patterns, side by side:

| Words in a payer's review | Play (9,790 payer reviews) | App Store (12,020 payer reviews) |
|---|---|---|
| One-time / lifetime / no subscription | 8.0% | 13.7% |
| Reminders / notifications | 8.6% | 9.1% |
| Themes / colours / icons | 5.4% | 6.8% |
| No ads | 6.2% | 6.2% |
| **Sync / other devices / tablet / computer** | **4.8%** | **4.7%** |
| Widgets | 4.3% | 4.3% |
| Statistics | 3.1% | 3.8% |
| Backup / restore / export | 2.4% | 3.7% |
| More habits / unlimited | 1.5% | 2.5% |
| **Watch / Wear OS** | **0.5%** | **1.8%** |

*Machine count of words present, not reasons.* The two lists are nearly the same. Sync and other devices: identical.
The Watch: nearly four times as common on the App Store, and most Play "watch" matches turn out to be the gym app Hevy
when read (§6).

---

## 4. What people say they paid for, side by side (read by hand)

Estimated reviews per 10,000 English reviews of each store, from 60 hand-read matches per feature and store.
"Paid for it" counts people who paid with that feature as the reason, including those whose feature then broke or was
missing (they still paid for it). "Objects" counts people angry that it's behind a paywall.

| Feature | Play: paid for it | App Store: paid for it | Play: would pay | App Store: would pay | Play: objects | App Store: objects |
|---|---|---|---|---|---|---|
| More habits | 2.5 | **11.0** | 1.1 | 2.3 | 5.0 | 16.2 |
| Widgets | **4.8** | 8.1 | 0.6 | 1.4 | 2.8 | 4.5 |
| **Sync / other devices** | **4.1** | **6.4** | **1.5** | **1.5** | 0.6 | 0.2 |
| Themes / dark mode / colours | 0.7 | 4.1 | 0.2 | 0.6 | 2.3 | 3.2 |
| **Watch** | **0.1** | **2.3** | 0.1 | 0.7 | 0 | 0.1 |
| Backup / export | 1.9 | 1.7 | 0.3 | 0.1 | **1.5** | 0.5 |
| Statistics | 0.6 | 1.2 | 0.3 | 0.2 | 0.8 | 1.4 |

Because App Store reviewers talk about paying three times as often (§5), compare **each feature's share of that store's
paying** instead of raw rates:

| Share of all feature-linked paying | Play | App Store |
|---|---|---|
| Widgets | 33% | 23% |
| **Sync / other devices** | **28%** | **18%** |
| More habits | 17% | 32% |
| Backup | 13% | 5% |
| Themes | 5% | 12% |
| **Watch** | **1%** | **7%** |
| Statistics | 4% | 3% |

**What this shows (users show):**

- **Sync and other devices is a bigger share of what Android people pay for than of what iPhone people pay for.** The
  Android "other device" is a computer or the web, a tablet, a second phone, or the next phone: "I've upgraded to
  premium because I like being able to access on computer as well as phone" (`P84#12632`, Tasks); "I bought premium,
  so I could have more routines and to sync it across my devices" (`P2#3087`, HabitNow). And people who won't buy
  without it: "i would not mind paying for BUT it does not sync to my other device" (`P9#1076`).
- **Widgets are Android's clearest single reason** ("Im also a paid user so I could use the widget on my homescreen",
  `P2#11255`). Our widgets are free (decided 29 Sep); Plus adds designs. That stays right on Android.
- **Backup is the one thing Android people most resent paying for**: 22 of 60 Play backup matches object to it, against
  9 of 54 on the App Store ("you can't back up your progress unless you get premium, which is absolutely absurd",
  `P24#2354`). Our plan already keeps backup free (D10, D16). On Android it must stay visibly free.
- **More habits is a reason on both stores**, strongest on the iPhone, and also the most objected-to limit on both.
- **The Watch is an iPhone reason only** (§6).

---

## 5. How much Android people pay at all

- **Reviews that say "I paid": 1.1% on Play, 3.6% on the App Store** (9,790 of 901,453 against 12,020 of 337,331;
  machine count, same patterns).
- **Spending, 2025:** App Store about $117.6 billion, Google Play about $49.2 billion, roughly 70 / 30 (Sensor Tower
  estimates, reported by Business of Apps; secondary source).
- **What buyers write about, read by hand (250 per store):** most buyer reviews don't say why they paid. They are about
  money and trust: charged unexpectedly (13% of Play payers, 17% App Store), **the purchase lost or not restored on a
  new phone (12% / 19%)**, the paid app broken (16% / 18%), features taken back after paying (1% / 14%, mostly one
  App Store app that switched to a subscription). Happy buyers: 45% on Play, 31% on the App Store.

**So:** an Android user is less likely to buy, but an Android buyer wants the same things and is hurt by the same
failures. Android Plus sells fewer copies; it doesn't need different contents.

---

## 6. The Watch and Wear OS

- **App Store:** 73 reviews link paying to a watch; of 60 read, 37 paid for the Apple Watch (often then broken: "I
  purchased this app purely so I could use this on my watch", `A31#1388`) and 11 would pay for it.
- **Play:** 7 reviews in the whole corpus; 6 are the gym app Hevy ("I was so close to purchasing the lifetime plan
  until I realized there was no WearOS app", `P122#18627`); one habit app (`P40#13`).
- **Market:** Apple 23% of smartwatches in 2025; Samsung 7%; Wear OS shipments fell year on year in Q3 2025
  (Counterpoint, secondary).

**So:** the Apple Watch is a genuine reason to buy Plus on the iPhone. A Wear OS app is not a reason to buy Plus on
Android today; keep it out of Android's first version and its Plus promise.

---

## 7. Do two different apps cause problems?

**Users show (150 hand-read per store; estimates scaled to all 1,341 Play and 291 App Store reviews naming the other
platform):**

| What they say | Play (≈ all) | App Store (≈ all) |
|---|---|---|
| Please make it for the other platform | ≈ 608 | ≈ 60 |
| Changed platform and wants to keep using it | ≈ 152 | ≈ 56 |
| **The other platform's version has more, or costs less** | ≈ 152 | ≈ 45 |
| Uses devices on both platforms, wants one account | ≈ 125 | ≈ 31 |
| **Changed platform and lost data or the paid status** | ≈ 63 | ≈ 31 |
| **Asked to pay again on the other platform** | ≈ 45 | ≈ 27 |
| Wants to share with someone on the other platform | ≈ 80 | ≈ 23 |

About half the "lost what I paid for" reviews are one subscription app (Fabulous). Small numbers overall, about 0.13%
of the corpus, but they are buyers and they are angry:

- **Paying more for less:** "I'd buy the lifetime Hevy Pro if we had all the features iOS users have" (`P122#15367`);
  "why does my Android party member have feature I don't?" (`A85#2342`); a Brazilian reviewer won't pay R$119 a year for
  an Android version that "doesn't do everything the iOS version does" (`P33#5148`, translated).
- **Different prices:** "Why on ios its 100 $ for a year subscription and on android its only 15 $" (`A13#7660`);
  "Android users get it cheaper!" (`A24#41008`); and the reverse (`P12#124376`).
- **The purchase doesn't follow the person:** "my paid subscription did not transfer … they told me I had to subscribe
  and pay again on iOS first" (`P12#52019`); "Don't expect to transfer between operating systems" (`A4#15435`).
- **People who would buy once it's on both:** "waiting for it to support Android to upgrade to life time member"
  (`A48#1990`); "I would buy the premium if the developer release it for iPhone" (`P2#4341`); an iPhone lifetime buyer
  worried the purchase "may go to waste" if they move to Android (`A1#46778`).
- **Mixed households and devices:** a Galaxy phone with an iPad (`P41#256`), an Android phone with an iPad
  (`A76#4699`), syncing with a wife's iPhone (`P84#32658`).

**Platform rules:**
- **Google doesn't require the two versions to match**: "We do not require parity across platforms" (Google Play
  Payments FAQ). So any difference is our choice, and reviews say it's a bad one.
- **Both stores let one purchase unlock both apps.** Apple 3.1.3(b): an app may let people use what they bought on
  another platform, provided it is also sold in the App Store app. Google allows apps to give access to content paid
  for elsewhere; for an app that also sells through Google Play Billing, Google's FAQ doesn't say it directly, so
  confirm with Google's current policy when we build it.
- **Google Play can't share an in-app purchase with a family**: "You can't share in-app purchases … with your family
  members" (Google Play Help). Only paid apps are shared. **Plus Family as built on Apple (Family Sharing) has no
  Android equivalent**, so on Android it would need our own sharing through the entitlement account, or no Plus
  Family at launch.

**So:** the problems come from three things, and each has a fix:
1. **Different features:** keep Plus the same on both; where a platform forces a difference (Watch, iCloud), say so.
2. **Different prices:** one price list on both stores (reasoned from the reviews above; Google allows either).
3. **A purchase that doesn't follow the person:** the entitlement-only account already planned for Android launch
   (D16) is exactly this. These reviews make it a **launch requirement**, not later work. Their habits travel with the
   backup file (D5).

---

## 8. So what is Android Plus?

**Recommendation (users show, plus first principles):** the same Plus as the iPhone, at the same price, with one
purchase working on both stores.

| | iPhone Plus (as decided) | Android Plus (recommended) |
|---|---|---|
| More than 5 habits | ✓ | ✓ |
| Extra widget designs, the "This week" widget | ✓ | ✓ |
| **Use your habits on your other devices** | iPad, Mac (later), through iCloud | **Android tablet, a second phone, the computer later** — how is the open question below |
| Watch | Apple Watch | Not at launch (Wear OS only if Android people ask) |
| Backup | Free, automatic | Free, automatic (Android's own + daily Google Drive file) |
| Plus Family | Apple Family Sharing | **Needs a decision** (Google can't share it) |
| Bought on one store, works on the other | Through the entitlement account | Through the entitlement account, **at launch** |

**The open question this research reopens: Android sync.** Earlier today we agreed to leave Google Drive sync out of
Android's first version because it's unproven. This research shows sync is a bigger share of what Android people pay
for than it is on the iPhone. The choices:

- **A. Launch Android Plus without sync, say so plainly, add it later.** Lowest risk. Android Plus is weaker than the
  iPhone's at launch (more habits and widget designs only), and reviews show people who won't buy without sync
  (`P9#1076`).
- **B. Prove Google Drive sync before Android launches** (the two-device test in the Drive report §6), then launch
  with it. Matches what people pay for; costs the prototype time, and if it fails we fall back to A.
- **C. A server only for sync on Android.** Ruled out by D16.

**I'd recommend B, with A as the fallback.** Build the Android app first; prototype Drive sync alongside it rather than
after it, so the decision is made from a working test before launch, not from reasoning.

---

## 9. Decisions for the user

1. **Android Plus has the same contents and price as iPhone Plus**, minus the Watch (recommended).
2. **One purchase works on both stores from Android's launch** (the entitlement account; recommended, because losing a
   paid status on switching is the worst cross-platform failure in the reviews).
3. **Android sync: B (prove Drive sync before launch, fall back to A) or A (launch without, add later).**
4. **Plus Family on Android:** our own sharing through the entitlement account, or no Plus Family on Android at launch.
5. **Google Drive on iPhone / Mac** (still open from Current Work 77): if Drive sync is built for Android, the same code
   serves people with an iPhone and an Android tablet, who exist (§7).

---

## 10. What this changes in earlier documents (when approved)

- [Android and Mixed Devices Without a Server](<../../../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/Android and Mixed Devices Without a Server — and CloudKit's Limits.md>)
  §3: its payer table (sync 5.6%) was right that sync matters; add that, measured side by side, it matters at least as
  much as on the iPhone, and that the Watch is the real difference.
- [Plus Scope](<../../../Research/Research Reports/Business Model and Monetization/Plus Scope and Account at Purchase.md>) §3:
  note that its table combines both stores.
- Rulebook D16: Android launches with the entitlement account (not "added when Android launches" as optional), and
  Plus Family on Android is undecided.

---

## 11. Files (all in `Android Plus Evidence/`)

| File | What it is |
|---|---|
| `PROGRESS.md` | Step-by-step progress, to resume after an interruption |
| `scan_payers.py` → `payers_play.jsonl`, `payers_app.jsonl`, `comention.md` | Payer scan, both stores, same patterns (§3) |
| `sample.py`, `sample-play.json`, `sample-app.json`, `read/play-*.txt`, `read/app-*.txt` | The 250 + 250 random payer reviews |
| `coded_payers.py`, `tally_payers.py` → `tally_payers.md` | Their hand coding, validated (every sampled review coded once; IDs checked against `reviews.jsonl`) (§5) |
| `scan_reasons.py` → `link_play.jsonl`, `link_app.jsonl`, `link_counts.md`, `read/link-*.txt` | Payment-next-to-feature scan (§4) |
| `coded_links.py`, `tally_links.py` → `link_tally.md` | Hand coding of 960 of them, validated (§4) |
| `scan_cross.py` → `cross_*.jsonl`, `cross_counts.md`, `read/cross-*.txt` | Reviews naming the other platform (§7) |
| `coded_cross.py` → `cross_tally.md` | Hand coding of 300 of them, validated (§7) |
| `web_notes.md` | Store rules, spending and watch figures, with links |
| `quotes.tsv` | Every quoted review's full text and ID |

**Citations:** `P<n>#<line>` / `A<n>#<line>` = app folder number in `Play Store Reviews` / `App Store Reviews` and the
0-based line in its `reviews.jsonl`. Appendix A maps each cited review to its store ID.

**Sources:** [Google Play Payments policy FAQ](https://support.google.com/googleplay/android-developer/answer/10281818) ·
[Google Play Help: Family Library](https://support.google.com/googleplay/answer/7007852) ·
[App Store Review Guidelines 3.1.3(b)](https://developer.apple.com/app-store/review/guidelines/) ·
store spending 2025 (Sensor Tower, via [Statista](https://www.statista.com/statistics/1489711/total-global-app-spending)
and [Quashbugs](https://quashbugs.com/blog/app-store-statistics)) · smartwatch shares (Counterpoint, via
[MacTech](https://www.mactech.com/2025/12/22/apple-watch-shipments-grew-12-year-over-year-in-the-third-quarter-of-2025/amp/)
and [Huawei Central](https://www.huaweicentral.com/huawei-and-apple-dominate-2025-global-smartwatch-market/amp/)) ·
competitors, checked not copied: [HabitNow on AlternativeTo](https://www.alternativeto.net/software/habitnow/about/),
[Habitify on the App Store](https://apps.apple.com/us/app/-/id1111447047).

---

## Appendix A — cited reviews (generated by script from `reviews.jsonl`)

| Cite | Store ID | Store | App | Date | Rating |
|---|---|---|---|---|---|
| `A1#46778` | `13949589339` | App Store (in) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2026-04-12 | 4★ |
| `A4#15435` | `11111972763` | App Store (us) | 4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker | 2024-04-02 | 2★ |
| `A13#7660` | `12533690290` | App Store (jo) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2025-04-12 | 1★ |
| `A24#41008` | `5240448041` | App Store (us) | 24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help | 2019-12-06 | 1★ |
| `A31#1388` | `9260807388` | App Store (gb) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2022-11-06 | 1★ |
| `A48#1990` | `11907591400` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2024-11-03 | 2★ |
| `A76#4699` | `13775898909` | App Store (us) | 76. Way of Life - Habit Tracker - Build a better, stronger you | 2026-02-22 | 4★ |
| `A85#2342` | `7603445575` | App Store (us) | 85. Habitica - Gamified Taskmanager - Stay motivated and organized | 2021-07-22 | 2★ |
| `P2#3087` | `4ad4eb96-420d-4360-b4cd-684bdc0b573d` | Play (en) | 2. HabitNow Daily Routine Planner | 2025-04-14 | 3★ |
| `P2#4341` | `1c6c8b6e-261e-467b-9ea9-b00e1437fd6d` | Play (en) | 2. HabitNow Daily Routine Planner | 2024-08-25 | 5★ |
| `P2#11255` | `1420c125-d33c-4566-a062-af247afddca3` | Play (en) | 2. HabitNow Daily Routine Planner | 2021-09-01 | 5★ |
| `P9#1076` | `dc4fee35-fad6-40db-9551-9bcea8877aee` | Play (en) | 9. Habit Tracker - HabitKit | 2024-02-01 | 4★ |
| `P12#52019` | `fbba7bd5-ceef-453f-b19b-b8c6e5c12e65` | Play (en) | 12. Fabulous Daily Routine Planner | 2020-06-04 | 1★ |
| `P12#124376` | `c456704c-4b56-4133-89ed-58576329a443` | Play (pt) | 12. Fabulous Daily Routine Planner | 2023-05-06 | 5★ |
| `P24#2354` | `ffd59708-4423-40e8-a3aa-a5702fd690dc` | Play (en) | 24. Habit Tracker | 2021-07-26 | 2★ |
| `P33#5148` | `3db1a2ca-b7d0-4827-aa3a-92d9ffde24f8` | Play (pt) | 33. Productive - Habit tracker | 2019-10-27 | 3★ |
| `P40#13` | `c16e4dbe-24fa-4082-9d99-8364a83c1cea` | Play (en) | 40. Habit Eazy - Habit & To Do Pal | 2026-01-01 | 3★ |
| `P41#256` | `191bf590-e9b1-4679-b2a9-1e140fd953fd` | Play (ko) | 41. Routineday Daily Habit Tracker | 2025-07-14 | 5★ |
| `P84#12632` | `742efedd-42a6-4bb5-a580-ad3bffecf13f` | Play (en) | 84. Tasks - To Do List & Reminders | 2023-09-25 | 5★ |
| `P84#32658` | `4c5b2ee4-81e1-4439-bf3e-b107a8f3724f` | Play (en) | 84. Tasks - To Do List & Reminders | 2018-05-13 | 5★ |
| `P122#15367` | `3a336b00-b89b-4825-8a1b-2f737a30a553` | Play (en) | 122. Hevy - Gym Log Workout Tracker | 2024-01-17 | 5★ |
| `P122#18627` | `731fdb54-eb77-4129-baf0-578a11315652` | Play (en) | 122. Hevy - Gym Log Workout Tracker | 2022-12-28 | 1★ |
