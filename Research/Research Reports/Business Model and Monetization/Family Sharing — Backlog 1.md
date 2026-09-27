# Family Sharing for Plus — Backlog #1

> **Update 27 Sep 2026: decided.** Plus Family ships as **our own account-based family groups** (invite by link, own accounts, any platform), not Apple Family Sharing, because it must work on Android and the invite must live in the app. §6's guardrails still apply; guardrail 1 (one product) no longer does, since a family seat plan is a separate product. Design: [02 Billing §3.6](<../../../Architecture/02. Billing and Entitlements.md>).

*Written by Claude (Claude Code), 26 Sep 2026. Evidence for [Backlog #1](<../../../Architecture/Backlog.md>) ("Apple Family Sharing for Plus"). Research, not a decision.*

**The question:** should one Plus purchase cover the buyer's Apple family (up to 5 more people)? Your worry: less money per household, and one more promise to keep working.

**Evidence:**
- **A fresh screen** of all 1,487,223 reviews, 6 patterns in ~12 languages: family sharing, family plans, "had to buy it again for my wife", sharing a purchase, households using one app, and per-child profiles. It found 1,099 matches.
- **Every App Store and Play Store match read and hand-coded:** 533 reviews (App Store 401, Play Store 114, native 18 for contrast). Every quote below is verbatim and checked by script.
- **Platform rules** from Apple's and Google's documentation, and the only published commentary on revenue (RevenueCat).
- **Reused:** Report 1 (Habit Tracker) and Feature Ledger card C037 "Family plan".
- **Files:** [`Family Sharing Evidence/`](<Family Sharing Evidence/>).

**How each claim is backed:** "users show" means reviews; "platform fact" means Apple's or Google's own rules; "first principles" means reasoning.

---

## 1. The short answer

| Your worry | What the data says |
|---|---|
| **"Less revenue per user"** | **Mostly not.** Families without a family option don't buy one copy each. **They stay on the free version.** In apps without Family Sharing, 18 reviews say the family didn't buy at all because it would mean paying per person. Only **3** describe a household paying for each member. Meanwhile **86** reviews say they bought *because* of a family option. |
| **"More promise to maintain, a hassle"** | **Yes, if it's built carelessly.** The most visible family plan in the corpus (Habit Tracker's "Lifetime Family", mid-2024) produced **77** reviews saying "I paid for family and can't find how to share it" or "it doesn't unlock for my husband", **mean 2.6★**. The sharing itself works through Apple. What failed was that **the app never told anyone how.** |
| **"Can we undo it?"** | **No.** Once Family Sharing is on for a product, [Apple doesn't allow turning it off](https://developer.apple.com/help/app-store-connect/configure-in-app-purchase-settings/turn-on-family-sharing-for-in-app-purchases/). It *can* be turned on later, though. |
| **Android** | **Google Play can't share in-app purchases** with family ([Google Play Help](https://support.google.com/googleplay/answer/7007852?hl=en)). Only Apple families would get it. |

**Recommendation:** turn Family Sharing **on**, on the one Plus lifetime product. Don't sell a separate "family" product. Launch it only together with an in-app "Share Plus with your family" screen and the five guardrails in §6. If that screen isn't ready for launch, launch with sharing **off** and turn it on in an update. Turning it on is the one-way step, so waiting costs nothing.

---

## 2. How Family Sharing works (platform facts)

- **What it covers:** non-consumable purchases (our lifetime Plus) and subscriptions. The buyer and **up to 5 family members** in their Apple family get it ([Apple tech talk](https://developer.apple.com/videos/play/tech-talks/110345/)).
- **It can't be turned off** once it's on for a product. A product without sharing needs a new product ID ([App Store Connect Help](https://developer.apple.com/help/app-store-connect/configure-in-app-purchase-settings/turn-on-family-sharing-for-in-app-purchases/)).
- **Turning it on later is allowed.** For people who bought earlier, the developer unlocks access through receipt validation or server notifications (same page).
- **Telling buyers from family:** each transaction says whether it was bought or family-shared (`inAppOwnershipType`). The family member gets it through the same StoreKit calls as a buyer.
- **Losing access:** when a member leaves the family, the buyer stops sharing, or the buyer gets a refund, Apple sends a `REVOKE` notification and the transaction gets a `revocationDate` (tech talk).
- **Android:** "You can't share in-app purchases and apps downloaded at no charge with your family members" ([Google Play Help](https://support.google.com/googleplay/answer/7007852?hl=en)). There is no equivalent for our product.
- **Revenue data:** none is published. Apple's talk claims only that sharing grows engagement and lowers churn. RevenueCat says it "could also mean that fewer subscriptions are sold per family" and gives no numbers ([RevenueCat](https://www.revenuecat.com/blog/engineering/implement-apple-family-sharing)). **So the reviews are the evidence.**

---

## 3. How big the family question is

| Measure (App Store habit apps) | Value |
|---|---|
| Reviews that mention family sharing or a family plan | about **220 of 337,331** (0.07%) |
| …that mention paying (paid, bought, premium, lifetime… in 12 languages) | **60%** of family-sharing mentions, **70%** of family-plan mentions, vs **10.8%** for all reviews |
| Reviews where a household uses the app together (read and confirmed) | 145 (mean **4.63★**) |
| Reviews where parents use it for or with their kids | 84 (mean 4.45★) |

**Small, but it's all about money.** When a review mentions family it's nearly always about a purchase. And households using an app together are among its happiest users.

---

## 4. When apps sell a family option

### 4.1 It makes sales (users show)

**86 reviews** across 9 apps say they bought *because* of a family option:
- “Bought the app for family sharing but unable to proceeds” (`A1#1750`)
- “Realized it would be good for my family so upgraded to family subscription and purchased the lifetime option for family.” (`A1#1691`)
- “and secondly because it works with family sharing” (`A23#3843`), about Streaks
- “Offers family sharing.” (`A41#707`), about Awesome Habits, listed as a reason to choose it

Report 1 found that family-plan complaints come **×12.7** more often from buyers than from the average reviewer. Family buyers are a real buying group.

### 4.2 It fails when the app doesn't explain it (users show)

**113 reviews** across 17 apps (mean **2.62★**, 52% rated 1–2★) are about a family option that was sold but didn't work for the buyer. **77 of them are one app:** Habit Tracker's "Lifetime Family" plan.

| What went wrong | Reviews | Mean ★ |
|---|---|---|
| **"How do I share it?"** There's no screen in the app | 53 | 2.98 |
| **"It doesn't unlock for my family member"** | 43 | 2.21 |
| **The listing said "Family Sharing" but the purchase wasn't shared** (mostly before Apple allowed sharing in-app purchases, Dec 2020) | 12 | 2.42 |
| **Charged twice** (the family member bought again, or paid for individual + family) | 9 | 2.78 |
| **Surprised by Apple's rules** (a family "Purchase Sharing" setting that also bills the organiser) | 2 | 1.50 |

In their words:
- “I just purchased the lifetime family pack and there is no way in the app to share it with my family” (`A1#46798`)
- “on his iPhone the app still asks him to purchase Premium, and Restore Purchases does not unlock the Lifetime Family plan” (`A1#46738`)
- “Family sharing doesn’t work. I reached out to their support and they stopped responding when they couldn’t fix it.” (`A1#51685`)
- “ONLY way is to turn on Family Purchase Sharing which also means all future purchases of all members in the family will be charged to the organiser’s card” (`A1#323`)

**The same app, from buyers who worked it out:**
- “I dug deep and figured out how the family sharing worked. No issues!” (`A1#52030`)
- “You need to turn on Apple family sharing and add people to your family. The sharing happens through Apple, not in the app.” (`A1#51956`)

**What that shows** (first principles): sharing through Apple works. The failures come from three things:
1. **No screen in the app** that says where to go or who already has Plus.
2. **A separate, pricier "family" product.** Buyers expected a button to invite people, so they paid extra and then looked for something that didn't exist.
3. **Nobody answering support.**

Report 1 dates it: 0% of complaints before 2024, 1.94% of all non-China reviews in 2025, mean 1.65★.

### 4.3 When it works, it's quietly liked

12 reviews (mean 4.17★): “Excellent value, can share with family too” (`A23#2041`), “My family uses it too as it can be shared.” (`A24#6588`).

---

## 5. When apps *don't* offer it

### 5.1 Families stay free instead of buying twice (users show)

Almost all of this comes from **Finch** ($40–70 a year per person), where families use the app together.

| What they say | Reviews | Mean ★ |
|---|---|---|
| **Please add family sharing or a family plan** | 70 | 4.00 |
| **So we didn't buy, or we stay on free** | **18** | 3.72 |
| **We'd pay if there were a family option** | 10 | 4.10 |
| **Too expensive per person** | 15 | 3.20 |
| **We pay for each person anyway** | **3** | 3.33 |

In their words:
- “there’s no way I’d pay 4 subscriptions but would be no brainer if it was for all of us (even if slightly higher price)” (`A10#10158`)
- “we can’t pay for 4 annual subscriptions, but we could probably afford the cost of 2 subscriptions if it covered the whole family” (`A10#37023`)
- “can&#39;t justify buying it for just one of us lol” (`A10#3474`). Without sharing, *nobody* in that family bought.
- “Do, we just use the free option, which is alright but I wish there was an option for a family subscription or family sharing.” (`A10#42961`)
- “ファミリー共有ができないのが残念で、有料課金は諦めました” (`A5#1041`): *no family sharing, so I gave up on paying*
- The rare exception: “My whole family has the plus version now just because we use it so much” (`A10#68390`)

**What that shows:** the revenue you'd "lose" is mostly revenue these households were never going to pay. Per-person buying (3 reviews) is much rarer than buying nothing (18) or buying because sharing exists (86).

**One caveat** (first principles): Finch is a $40–70-a-year subscription, so paying per person hurts much more than with our lifetime price of about $10. At our price, some couples would buy twice. The reviews can't measure that, and it's the real unknown.

### 5.2 What families also want (not Family Sharing)

- **Profiles for kids in one app,** on one device (13): “I just wish I could have multiple users so that my daughter could also have her own profile/pets/quests.” (`A10#9046`)
- **Shared lists and goals** between family members (35). That's Backlog #9 (shared habits), a separate feature.

---

## 6. Recommendation for Backlog #1

**Turn Family Sharing on for the one Plus lifetime product, with these five guardrails.** Each one fixes a failure from §4.2.

1. **One product, not a separate "family" product.** Plus is Plus, and it covers your Apple family. There's no pricier tier where buyers expect an invite button (the failure in `A1#46798` and 52 more).
2. **A "Share Plus with your family" screen in the app** (Settings → Plus). It says in plain words: "Plus is shared through Apple Family Sharing. Your family members get it automatically on their iPhone and iPad." It links straight to the right iOS setting, and says whether sharing is on. Family members see "Plus, shared by your family". Nobody has to find a hidden setting.
3. **Unlock automatically, and never offer a second purchase to a family member.** On launch the app reads current entitlements; a family-shared purchase unlocks without tapping Restore. If a family member opens the paywall, it says "You already have Plus through your family". That prevents the charged-twice reviews (9).
4. **Say plainly what it doesn't cover.** On the purchase screen: "Shared with up to 5 family members on iPhone and iPad. On Android, each person buys." Family-shared Plus stays on the family member's Apple devices. It isn't attached to *their* account for Android or web ([02 Billing §3.6](<../../../Architecture/02. Billing and Entitlements.md>)). That's the gap behind “Cool app, but don’t buy if your family has android” (`A1#51952`).
5. **Handle revocation quietly.** A `REVOKE` notification removes only the shared extras. The member's habits are never touched. The message says why ("Your family stopped sharing Plus").

**Price** (first principles): set the one lifetime price knowing it may cover a household. Don't add a family surcharge. The reviews show families will pay a bit more for "all of us" (`A10#10158`, `A10#37023`), but a second, pricier product is exactly what failed.

**Timing:** it's irreversible, so turn it on **only when guardrails 2 and 3 are built and tested**. If they aren't ready for launch, launch with sharing off and turn it on in the next update. Apple lets you unlock earlier purchases later, so waiting loses nothing.

**Tests to add to 02 Billing:**
1. The buyer purchases; a family member on another Apple ID opens the app and has Plus without tapping anything.
2. The family member opens the paywall and sees "You have Plus through your family", with no Buy button.
3. The buyer leaves the family; the member loses Plus extras on the next launch and keeps every habit.
4. The same family member signs into our account on Android and sees free, plus the message "Plus from Apple Family Sharing works on iPhone and iPad".

**Later, only if asked:** "profiles for kids in one app" and "shared habits" are different features (Backlog #9). A family plan on Android would need our own account-based family groups (02 §3.6).

---

## 7. Method and limits

- **The screen:** `scan.py`, 6 patterns. Counts are in `mode-stats.txt`, coded tallies in `tally.txt`.
- **The reading:** `sample.py` read every App Store and Play Store match, plus 3 native reviews per pattern.
- **Coding:** in `cls/`. `check_cls.py` found zero unknown keys, zero duplicates, zero unread reviews and zero quotes that don't match.
- **Working files not committed:** the match file and reading batches sit in `Research/Temp/backlog1-family/`, and `scan.py` and `sample.py` rebuild them.
- **Precision** (share of matches that were really on topic): family plan 95%, family sharing 86%, household use 97%, kid profiles 37%, "buy again for a person" 20%, "share purchase" 10%. The last two mostly caught "share my progress". Counts in this report are **only reviews that were read and confirmed**.
- **Limits:**
  - Reviews can't tell how many *extra* sales a family option produces, or how many second purchases it replaces. The counts show which way it leans, not how much money is involved.
  - The "stay free" evidence is mostly one subscription app (Finch).
  - The "failed family plan" evidence is mostly one app (Habit Tracker). But the failures match across 17 apps and 12 languages.

<!-- APPENDIX -->

## Appendix — reviews cited

20 reviews cited. Ref = store letter (A App Store, P Play Store, N native app) + app number + line index in that app's `reviews.jsonl`.

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#323` | `12159515360` | App Store (au) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2025-01-08 | 1★ | FS_HOWTO, FS_FAMILY_CHARGE, FS_BOUGHT_FOR |
| `A1#1691` | `12273728364` | App Store (ca) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2025-02-05 | 1★ | FS_BROKEN, FS_BOUGHT_FOR, FS_UPGRADED |
| `A1#1750` | `11619587662` | App Store (ca) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-08-17 | 5★ | FS_BROKEN, FS_BOUGHT_FOR |
| `A1#46738` | `14383144623` | App Store (in) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2026-08-03 | 1★ | FS_BROKEN, FS_BOUGHT_FOR |
| `A1#46798` | `13627620738` | App Store (in) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2026-01-13 | 1★ | FS_HOWTO, FS_BOUGHT_FOR |
| `A1#51685` | `12250034690` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2025-01-30 | 1★ | FS_BROKEN |
| `A1#51952` | `11875200636` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-10-26 | 1★ | FS_ANDROID, FS_BOUGHT_FOR |
| `A1#51956` | `11864008523` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-10-23 | 5★ | FS_HOWTO, FS_WORKS, FS_BOUGHT_FOR |
| `A1#52030` | `11727820447` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-09-15 | 5★ | FS_HOWTO, FS_WORKS, FS_BOUGHT_FOR |
| `A5#1041` | `9907503193` | App Store (jp) | 5. Routine Planner, Habit Tracker - Daily Time Management for ADHD | 2023-05-09 | 3★ | FS_WANT, FS_NOT_BUY, FS_WOULD_PAY, HOUSEHOLD |
| `A10#3474` | `13687846721` | App Store (ca) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-01-29 | 5★ | FS_WANT, FS_NOT_BUY |
| `A10#9046` | `13055826730` | App Store (fr) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-08-24 | 5★ | MULTI_PROFILE_REQ, KID_USE |
| `A10#10158` | `13841068535` | App Store (gb) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-03-12 | 5★ | FS_WANT, FS_WOULD_PAY, FS_NOT_BUY, HOUSEHOLD |
| `A10#37023` | `12198036016` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-01-18 | 4★ | FS_WANT, FS_WOULD_PAY, FS_NOT_BUY, KID_USE |
| `A10#42961` | `11189422176` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2024-04-22 | 1★ | FS_WANT, FS_NOT_BUY, HOUSEHOLD |
| `A10#68390` | `8388650550` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2022-02-23 | 5★ | HOUSEHOLD, HOUSEHOLD_PAID_EACH |
| `A23#2041` | `9367716405` | App Store (gb) | 23. Streaks - The habit-forming to-do list | 2022-12-06 | 5★ | FS_WORKS |
| `A23#3843` | `1925820330` | App Store (se) | 23. Streaks - The habit-forming to-do list | 2017-11-16 | 5★ | FS_WORKS, FS_BOUGHT_FOR |
| `A24#6588` | `6818167113` | App Store (ca) | 24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help | 2021-01-01 | 5★ | HOUSEHOLD, FS_WORKS |
| `A41#707` | `11536341085` | App Store (us) | 41. Awesome Habits - Habit Tracker - Streaks, days since & goals | 2024-07-26 | 5★ | FS_WORKS |
