# Plus Scope and Account at Purchase

*Written by Claude (Claude Code), 27 Sep 2026. A follow-up to [Sign-in Prompts and the Backup Guarantee — Backlog 4](<../Data, Sync and Accounts/Sign-in Prompts and the Backup Guarantee — Backlog 4.md>). Recommendations, not decisions.*

**The user's proposal (27 Sep):**
- **Free:** phone only, 5 habits, no Apple Watch, no iPad.
- **Plus:** one lifetime purchase that unlocks everything else.
- **Accounts:** ask people to create an account at purchase, so Plus can't be lost.
- **Scope:** don't build iCloud / Google Drive backup or sync for the privacy minority if it is small.

**The questions this answers:**
1. How big is the "no account, my own cloud only" group, and do they pay?
2. Is lifetime really why people buy?
3. Should iPad and Watch be Plus-only? Is the free version usable on iPad in other apps?
4. Is 5 free habits OK?
5. Can we ask for an account before purchase?

**How each point is backed:**
- **Users show**: review evidence.
- **Platform rule**: Apple or Google, linked.
- **First principles**: reasoned from how the system works.

---

## 1. The short answer

| Proposal | Verdict | Why |
|---|---|---|
| **Drop our own iCloud / Google Drive backup and sync** | **Agree** | The privacy "never on a server" group is tiny and rarely pays. Payers cluster in multi-device and iPad (§2) |
| **Keep "no account needed" for free use** | **Keep** (you didn't ask to change it) | Forced sign-up is one of the worst-rated patterns (86 reviews, 1.42★). No-account praise is large (151, 4.85★) |
| **Lifetime is the main reason to buy** | **Agree** | Lifetime or one-time wording appears in 15.8% of reviews where people say they paid, 3.7× the next reason (§3) |
| **iPad = Plus** | **Agree, with one change**: let the free app *open* on iPad as a standalone single device, and make **using iPad together with the phone** (sync) the Plus feature | Users who pay for iPad expect it; nobody complains iPad costs money. The failure is "I paid and it doesn't reach my iPad" (58 reviews). iPad-only users would otherwise hit a wall on first launch (§4) |
| **Watch = Plus** | **Agree** | Payers ask for Watch support and some buy for it; only 1 in 88 objects to paying. The real risk is a broken Watch app (27 reviews, 2.22★) (§5) |
| **5 free habits** | **Workable, but pick once and never change it** | Caps of 1–3 are hated. 5–6 is tolerated and converts engaged users. Changing a cap later is what enrages people (§6) |
| **Account at purchase** | **Offer it, optional, on the purchase screen.** Never required | Apple rejects apps that require registration before buying a non-account purchase (§7). Plus restores from the store on the same platform anyway. An account adds cross-platform and backup |

---

## 2. The privacy / own-cloud group is small and mostly free users

Groups from the two full-read screens:
- [iPad Sync and Server Trust — Backlog 5](<../Data, Sync and Accounts/iPad Sync and Server Trust — Backlog 5.md>): every trust match read.
- [Backlog 4](<../Data, Sync and Accounts/Sign-in Prompts and the Backup Guarantee — Backlog 4.md>): every Drive and iCloud-backup match read.

"Say they paid" uses a strict pattern ("I paid / bought / lifetime member / premium user…"). Across a 2% random sample of all habit-app reviews, the baseline is **1.40%**.

| Group | Reviews | Say they paid | What it means |
|---|---|---|---|
| **Refuse our server** (distrust servers, want local-only or E2EE, iCloud instead of an account, own cloud) | **87** (78 + 9) | 6 (6.9%) | 7 in 100,000 habit-app reviews |
| Want backup to **Google Drive** | 131 | **1 (0.8%)** | Below baseline. Mostly free users of one open-source app (Loop) |
| Want backup/sync to **iCloud** | 79 | 8 (10.1%) | A backup wish, not a refusal of accounts |
| Like that **no account is needed** | 151 | 3 (2.0%) | They like not being *forced*; they aren't against an optional account |
| **Want sync / multi-device / iPad sync** | 209 | 17 (8.1%) | |
| **iPad sync failed** | 106 | **21 (19.8%)** | The most payer-heavy group |
| **Lost data because there was no account** | 60 | 6 (10.0%) | |

**Reading:**
- Payers cluster where you're heading: **multi-device, iPad and sync behind an account**. Together these groups hold 44 self-declared payers.
- The groups that would need our own iCloud or Drive layer hold 6 + 1.
- The earlier ledger card agrees: cloud sync / multi-device is "the strongest true differentiator among buyers (lift ×9.8)" ([Feature Ledger C013](<../Feature Ledger.md#c013>)).

**So (users show):**
1. Drop the CloudKit / Drive backup layer and the own-cloud sync idea from v1.
2. Keep what costs nothing:
   - the phone's own backup (iCloud device backup, Android Auto Backup), with our database stored where those backups include it;
   - local snapshots;
   - export and import.
3. Keep the app fully usable without an account. That is what the 151 praise and the 86 forced-sign-up complaints are about, not cloud choice.

---

## 3. Lifetime is the main reason to buy

**Whole corpus (1.24M App Store and Play reviews):**
- 14,034 reviews say the person paid.
- Words that appear in those reviews (a review can count more than once; this is co-occurrence, not stated cause):

| Words present | Share of payer reviews |
|---|---|
| **Lifetime / one-time / no subscription** | **15.8%** |
| Sync / devices / iPad / Mac | 4.3% |
| Widgets | 3.5% |
| Themes / colours / icons | 3.2% |
| Support the developer | 2.4% |
| Stats | 2.2% |
| Unlimited / more habits | 1.8% |
| Watch | 1.7% |
| Backup | 0.9% |

**Read by hand:** 50 happy lifetime payers.
- Voices:
  - “I’m glad I got in early for the lifetime membership because subscriptions suck” (`A1#272`);
  - “It's great that there is a lifetime subscription - absolutely a no-brainer!” (`A76#563`);
  - “Thank you for making it a one time payment and not yearly” (`A53#116`).
- Some would pay only if lifetime existed:
  - “買い切り版なら金払うから出してほしいわ” — if there were a one-time version I'd pay; please release one (`P3#19276`);
  - “you really should add a lifetime plan. I am positive a lot would buy it!” (`A10#35007`).
- This matches the earlier findings. 22.4% of one app's paid cohort named "not a subscription" as their top reason. One-time praise outnumbered subscription objections 93 to 23 in another ([Business Model report §4.1](<Habit Tracker — Business Model, Free Baseline and Moat.md>)).

---

## 4. iPad: payers expect Plus to include it; don't lock iPad-only users out

130 reviews mentioning iPad or tablet together with paying were read; 93 were on topic.

| What they say | Reviews | Mean ★ |
|---|---|---|
| **I paid, but it doesn't reach my iPad/tablet** (entitlement or data missing) | 58 | 2.81 |
| Would pay / paid *for* multi-device | 21 | 4.29 |
| Asked to pay again on the other device | 10 | 3.10 |
| iPad layout or crashes | 12 | 3.33 |
| **Complains that iPad is paid at all** | **0** | – |

**Voices:**
- **Expectation:**
  - “I was hoping to get access to it for all devices like phone, iPad and laptop” (`A59#14326`);
  - “Comprei o Premium na esperança de poder usar o app no celular e tablet” — I bought Premium hoping to use it on phone and tablet (`P2#24189`);
  - “for a Pro plan, it should include sync with iPhone and iPad” (`A7#48`).
- **Willing to pay for it:**
  - “I would like to get an optimized version on my iPad, though.  That way I’d pay for the Upgrade.” (`A20#757`);
  - “iPadとの同期を求めます。そしたら課金します。” — I want iPad sync; then I'll pay (`A47#136`);
  - “I paid for this app because it was available on all platforms” (`A23#580`).
- **The failure:**
  - “I paid for Premium, but it does not sync between my Samsung phone and my Samsung tablet” (`P44#305`);
  - “I bought a premium subscription on my mobile phone and now can't restore it on my tablet. The app wants me to pay again.” (`P15#381`).

**Is the free app usable on iPad elsewhere?**
- Most apps in the corpus are universal, and their free tier runs on iPad. That is why there are no "iPad is paywalled" complaints to read.
- The closest precedent for "one device free, more devices paid" is Day One: the free Basic plan works on a single device with no sync, and sync across devices is paid ([Day One Plans](https://dayoneapp.com/plans/), [pricing guide](https://dayoneapp.com/guides/premium-subscription/day-one-pricing-features-guide/)).
- That is a competitor pattern, not evidence. What matters is that users above ask to pay for exactly this.

**Recommendation (users show + first principles):**
- **Free on iPad = standalone** (single device, same limits as the phone). iPad-only people exist (29 "iPad is my main device" reviews in the #5 screen). A paywall on first launch would give them nothing to try and a 1★ reason.
- **Plus = using iPad (and Mac, web, a second phone, the other platform) together with your phone.** That is sync plus the entitlement everywhere. It is exactly what the 58 + 21 reviews ask to pay for.
- **It must work the moment they pay:** entitlement on every device through the account and store restore, and data in sync. "Paid but not on my iPad" is the category's failure (2.81★).

---

## 5. Apple Watch and Wear OS: fine as Plus; the risk is quality

99 reviews mentioning Watch together with paying were read; 88 were on topic.

| What they say | Reviews | Mean ★ |
|---|---|---|
| Want a Watch app (many are already payers) | 27 | 4.07 |
| **Watch app broken or not syncing** | 27 | **2.22** |
| Praise the Watch app | 24 | 4.83 |
| Bought *because* of the Watch | 10 | 3.70 |
| **Object to Watch being paid** | **1** | 5.00 |

**Voices:**
- **Bought for it:**
  - “갤럭시 워치 연동되는거 보고 바로 결제 했습니다” — I saw it works with the Galaxy Watch and paid right away (`P20#1312`);
  - “I wanted to keep up with habits easily on my Apple Watch” (`A41#780`).
- **The one objection is mild and still 5★:** “I just don’t like that in order to access it on my apple watch I’d have to pay” (`A3#6950`).
- **The real danger:**
  - “手机和手表不同步，手表上计划一个都没有，浪费了会员了” — phone and watch don't sync, the watch shows no plans, the membership was wasted (`A1#3160`);
  - “Paid to upgrade, still doesn’t sync.” (`A2#430`).

The ledger card leans "free" ([C022](<../Feature Ledger.md#c022>)), but on small numbers: 0 apps where paid converted vs 3 where it was resented. This sample shows purchase intent and almost no objection.

**Recommendation:** Watch and Wear OS in Plus. Ship them only when check-in works reliably both ways.

---

## 6. Five free habits

The evidence is from the ledger ([C007](<../Feature Ledger.md#c007>), Contested, 56 apps). This screen adds two reviews from an app with a 5-habit cap:
- **Caps of 1–3 are hated.** A 1-habit tier got 76 complaints (2.22★). HelloHabit's 3 was hated (2.20★) while its 5 was defended (3.78★). Defenders were "loved at 3–6, hated at 1".
- **5 can convert engaged users:**
  - “I have made about 5 habits, I was disappointed that I had to pay if I wanted to make more. But, then I saw the price.” (`A1#46513`);
  - “It only allows five habits unless you pay for premium” (`A1#1901`), followed by "I’ll pay for premium without looking back".
  - "Hitting the cap while already engaged" is the one purchase trigger buyers name.
- **Two costs to accept:**
  - a 4-habit cap held for 3½ years was still the top 2★ theme, and 0 of 27 complainers paid;
  - a raised cap re-anchors at the new number.
- **The part that is not contested:** never change the number after launch. Cutting it is what produced the worst years (5 → 3 in one app).

**Recommendation:** 5 or 6, fixed forever, stated on the store page. Never block a check-in, history, reminders or widgets for existing habits. The business-model report recommended unlimited; the Notion decision was 6. Choosing 5 costs some rating and gains conversion, and the evidence supports either.

---

## 7. Account at purchase: yes, but optional

**Platform rule (Apple 5.1.1(v)):**
- An app can't require users to register before buying an in-app purchase that isn't account-based. Registration must be optional.
- Apple's own suggested fix is to tell users that registering lets them use the purchase on all their devices, and let them register at any time.
- Sources: [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/), and Apple forum threads quoting App Review ([731471](https://developer.apple.com/forums/thread/731471), [724336](https://developer.apple.com/forums/thread/724336)).

**What this allows:**
- The purchase screen says: "Sign in with Apple / Google to keep Plus and your habits on every phone and tablet, iPhone or Android."
- It shows **[Sign in and buy]** as the main button, with a visible **[Buy without an account]**.
- After a no-account purchase, the "Plus is yours" screen offers sign-in once (Backlog 4).
- This is the only prompt a free user ever sees about accounts, apart from features that need one.

**Why optional is enough:**
- On the same store, Plus restores itself without an account (02 §3.4).
- The account adds three things:
  - the other platform;
  - sync with iPad and other devices;
  - a server backup of habits.
- Those are the Plus promises, so most buyers will sign in. The review failures in §4 are what happens without it.

**Plus Family:** needs an account (it is account-based), which Apple allows.

---

## 8. What this changes in the architecture (if agreed)

1. **03 Backup:**
   - v1 = local snapshots + the phone's own backup + export/import;
   - move CloudKit / Drive snapshots, the reinstall marker and the protection card to the Backlog;
   - the only "back up" suggestion becomes "Sign in to back up and sync".
2. **01 Accounts §3.2:**
   - no time-based nudges;
   - sign-in offered on the purchase screen (optional) and when a feature needs it.
3. **02 Billing:**
   - free = 5 (or 6) habits, one device;
   - Plus (lifetime) = unlimited habits, iPad / second device / other platform with sync, Watch / Wear OS, plus the existing personalisation and depth items;
   - update the business-model assumptions.
4. **07 Other Surfaces:**
   - the free iPad app works as a standalone single device;
   - "Use with your iPhone" is Plus;
   - Watch is Plus.
5. **Backlog #5:** the own-cloud sync question closes as "not doing it".

---

## 9. Method and limits

- **Screen** (`scan.py` in [`Plus Scope Evidence/`](<Plus Scope Evidence/>)):
  - all App Store and Play reviews;
  - a strict "I paid" pattern with reason words;
  - iPad or tablet near paying, Watch near paying, and happy lifetime payers.
- **Reading set:** 279 reviews (iPad 130, Watch 99, lifetime 50), at most 8 per app. 218 were on topic. Codes and quotes were checked by `check_cls.py` (0 errors). Counts are in `tally.txt` and `reasons.txt`.
- **Segment sizes** come from the Backlog 5 and Backlog 4 coded sets, joined with each review's text.
- **Limits:**
  - "Say they paid" undercounts payers, because most don't say so. It is used to compare groups, not as a conversion rate.
  - Reason words co-occur with payment; they are not always the stated reason.
  - iPad-paywall reactions can't be measured directly, because few apps in the corpus paywall the iPad.

<!-- APPENDIX -->

## Appendix — reviews cited

20 reviews cited. Ref = store letter (A App Store, P Play Store, N native app) + app number + line index in that app's `reviews.jsonl`.

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#272` | `14076814177` | App Store (au) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2026-05-18 | 5★ | LIFETIME_PRAISE |
| `A1#1901` | `10878847255` | App Store (ca) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-01-29 | 5★ | CAP5_ACCEPTED |
| `A1#3160` | `11630025684` | App Store (cn) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-08-20 | 1★ | WATCH_QUALITY, X_PAYER |
| `A1#46513` | `11342173209` | App Store (id) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-06-04 | 5★ | CAP5_ACCEPTED, LIFETIME_PRAISE |
| `A2#430` | `4402829597` | App Store (us) | 2. Daily Habits - Habit Tracker - Habit List and Routine Tracker | 2019-07-02 | 1★ | WATCH_QUALITY, X_PAYER |
| `A3#6950` | `12134334067` | App Store (us) | 3. Days Since - Quit Habit Tracker - Sober Streak Day Counter | 2025-01-02 | 5★ | WATCH_PAYWALL_BAD |
| `A7#48` | `13833569208` | App Store (br) | 7. Habit Tracker - HabitKit - Streaks & Accountability | 2026-03-10 | 2★ | PAID_EXPECT_ALL_DEVICES, X_PAYER |
| `A10#35007` | `12450265322` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-03-22 | 5★ | LIFETIME_WANT |
| `A20#757` | `6451182919` | App Store (co) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2020-09-21 | 5★ | PAY_FOR_DEVICES |
| `A23#580` | `9044438629` | App Store (ca) | 23. Streaks - The habit-forming to-do list | 2022-09-02 | 3★ | PAY_FOR_DEVICES, X_PAYER |
| `A41#780` | `7489814726` | App Store (us) | 41. Awesome Habits - Habit Tracker - Streaks, days since & goals | 2021-06-21 | 5★ | WATCH_BUY_REASON, LIFETIME_BUYER |
| `A47#136` | `13780402439` | App Store (jp) | 47. Habit Streak Tracker - DotHabit - Daily Routine, Goals & Planner | 2026-02-23 | 5★ | PAY_FOR_DEVICES |
| `A53#116` | `6845067659` | App Store (ca) | 53. HabitMinder • Habit Tracker - Daily Reminders & Routines | 2021-01-08 | 5★ | WATCH_PRAISE, LIFETIME_PRAISE |
| `A59#14326` | `8059217653` | App Store (ua) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2021-11-24 | 2★ | PAID_EXPECT_ALL_DEVICES, LIFETIME_BUYER |
| `A76#563` | `13534435911` | App Store (ca) | 76. Way of Life - Habit Tracker - Build a better, stronger you | 2025-12-20 | 5★ | LIFETIME_PRAISE, PAID_EXPECT_ALL_DEVICES |
| `P2#24189` | `d2e52ca4-a394-41c0-a3b8-98911917b243` | Play Store (pt) | 2. HabitNow Daily Routine Planner | 2024-11-08 | 4★ | PAID_EXPECT_ALL_DEVICES, X_PAYER |
| `P3#19276` | `38214fec-51dd-4b2f-8de9-7236b5609b9e` | Play Store (ja) | 3. Loop Habit Tracker | 2025-12-07 | 5★ | LIFETIME_WANT |
| `P15#381` | `f8873781-55ea-4d25-a3ee-8581745c3fb1` | Play Store (en) | 15. Habit Tracker - HabitGenius | 2025-12-14 | 2★ | PAID_EXPECT_ALL_DEVICES, PAY_AGAIN_BAD, X_PAYER |
| `P20#1312` | `2816ea0e-d508-4857-96c3-64989f678dcb` | Play Store (ko) | 20. MyRoutine - Routine Habit Goal | 2025-02-24 | 5★ | WATCH_BUY_REASON |
| `P44#305` | `755a6ed0-ed10-4f7f-b236-303cf874aef1` | Play Store (en) | 44. Habit Tracker - TickOff | 2025-07-02 | 1★ | PAID_EXPECT_ALL_DEVICES, X_PAYER |
