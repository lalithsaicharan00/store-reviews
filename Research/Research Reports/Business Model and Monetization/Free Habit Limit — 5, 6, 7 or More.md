# Free Habit Limit — 5, 6, 7 or More

*Written by Claude (Claude Code), 29 Sep 2026. A follow-up to [Free Plan Design — Habit Cap, Widgets and an Honest Listing](<Free Plan Design — Habit Cap, Widgets and an Honest Listing.md>). The user's question: 4 is already ruled out, so what is the best free limit: 5, 6, 7, 8 or more? It has to drive revenue, keep complaints low, and fit the free widgets. A recommendation, not a decision. **Outcome (29 Sep 2026):** 5 was chosen and fixed; the "raise to 6 later" option in §8 was not taken ([02 §3.1](<../../../Architecture/02. Billing and Entitlements.md>)).*

**How each point is backed:**
- **Users show**: review evidence.
- **First principles**: reasoned from how the product and the numbers work.
- **Model**: simple arithmetic on the evidence, with every input shown.

---

## 1. The short answer: **5**

| Free limit | Engaged users who go past it (upgrade pool) | Pool compared with 5 | "It's enough" among reviews that name the limit | How often reviews mention the limit, in real apps |
|---|---|---|---|---|
| **5** | **45%** | **100%** | 22% (188 reviews) | 12–21 per 1,000 reviews |
| 6 | 37% | 82% | 16% (80) | about 15 per 1,000 |
| 7 | 33% | 73% | 22% (86) | 2–5 per 1,000 |
| 8 | 28% | 62% | 19% (53) | 4–15 per 1,000 |
| 10 | 20% | 44% | **62%** (31) | about 1 per 1,000 |

**The two findings that decide it:**
1. **Raising the limit from 5 to 6, 7 or 8 buys almost no goodwill** (users show). Among people who mention the limit, only about 1 in 5 say "that's enough" at every limit from 5 to 8. The complaint just moves to the new number.
   - At 6: “I know for a fact that not everybody only does six things a day” (`A1#51610`).
   - At 7: “The limit of 7 habits is far to low without premium.” (`P2#9429`).
   - At 8: “the 8 routines limit is so frustrating because it's not even close to being enough for me” (`P38#1192`).
   - Satisfaction only jumps at **10** (62% say enough), but by then the upgrade pool has fallen to less than half.
2. **Every step above 5 shrinks the upgrade pool** (users show, from Q46's 446 people who say how many habits they track):
   - 6 loses 18% of the people who would meet the upgrade moment;
   - 7 loses 27%;
   - 8 loses 38%.
   - For 6 to earn the same as 5, 22% more of the people at the limit would have to buy. No review suggests they do.

**Also for 5:**
- **The rating cost is tiny.** About 1% of reviews complain about the limit at 5, which pulls an average rating down by about **0.02★** (§5).
- **You can raise a limit later, but never lower it** (users show). Starting at 5 keeps the option to move to 6 if our own data says so. Starting at 6 locks it in.
- **5 fits the free widgets without scrolling** (§6).

**Why not 4:**
- At 4, **1 in 25** reviews that name the limit call it enough, against more than 1 in 5 at 5.
- At 4, reviews average 2.21★, against 3.18★ at 5.

---

## 2. Method

- **Read and hand-coded for this question:**
  - every review in the free-plan screen whose first stated limit is 6 to 15 (342 reviews);
  - 150 that name 5, at most 12 per app;
  - 492 in all, combined with the 361 limit reviews coded earlier.
  - Left out: paid apps whose limit is a design choice (Streaks, Atoms' paid tier), gym routines (Hevy), and one app built around a single goal.
- **Coded:** the limit the reviewer names, and what they did or said about it:
  - "enough", "not enough";
  - left the app, refused to pay;
  - paid, will pay;
  - surprised by the limit;
  - the limit was lowered.
  - Every quote was checked against its review by script.
- **Upgrade pool:** from [Q46: How Many Habits People Actually Track](<../Home Screen and Visual Design/Today Screen Jobs/46. How Many Habits People Actually Track.md>). It uses 446 people who state their own count, leaving out anyone whose count a free limit cut short.
- **Real-app rates:** year-by-year mentions of the limit, "I paid" share and rating, for apps whose limit is known from their own reviewers.
- Files: [`Free Habit Limit Evidence/`](<Free Habit Limit Evidence/>) (`sample.py`, `cls/`, `coded.json`, `tally.py`, `tally.txt`).

---

## 3. Does a higher limit make people happier?

**Among reviews that name the limit, by the limit named:**

| Limit | Reviews | Apps | Mean ★ | 1★ | Enough | Not enough | Left | Refused to pay | Paid or will pay |
|---|---|---|---|---|---|---|---|---|---|
| 3 | 98 | 27 | 2.40 | 43% | 12 | 50 | 11 | 6 | 3 |
| 4 | 29 | 13 | 2.21 | 38% | 1 | 22 | 2 | 2 | 1 |
| **5** | **188** | **31** | **3.18** | **18%** | **33** | 94 | 14 | 10 | **11** |
| 6 | 80 | 14 | 2.85 | 28% | 11 | 50 | 7 | 1 | 3 |
| 7 | 86 | 12 | 3.27 | 19% | 14 | 45 | 3 | 1 | 10 |
| 8 | 53 | 12 | 2.98 | 17% | 9 | 27 | 10 | 2 | 2 |
| **10** | 31 | 9 | **4.16** | 6% | **16** | 8 | 1 | 1 | 3 |

**Reading (users show):**
- **5 to 8 behave alike.** Complaints outnumber "enough" about 4 to 1 at each of them.
  - The best of them are 5 (3.18★, 18% 1★) and 7 (3.27★, 19%).
  - 6 is no better than 5.
  - People at a limit of 6 still ask for more: “Can you please make it to 8 or 10 free habits?” (`A1#1657`).
- **What people ask for:** when they name a number, it is **10** (23 times), far ahead of 5 (9) and everything else. So "a little more" does not satisfy; people who want more want about 10.
- **At 10 the tone flips.** “Free version can track up to 10 habits which is really good enough to try and see if you like it enough to upgrade.” (`A52#20108`); “What made me choose it was the fact that you can add 10 habits on the free version” (`A48#1221`). But even there: “10 habits for free, but you'll do best starting with only 2-5.” (`A48#3374`)

This matches the ledger: raising a limit by one or two slots does not buy back goodwill; the objection re-forms at the new number ([C293](<../Feature Ledger.md#c293>)).

---

## 4. How many people reach each limit

**From Q46 (users show):**

| Limit | Past it: all 446 people | Past it: apps with no binding limit (36 people) | Past it: apps where payers speak (125 people) |
|---|---|---|---|
| 5 | 45% | 53% | 63% |
| 6 | 37% | 36% | 50% |
| 7 | 33% | 28% | 44% |
| 8 | 28% | 22% | 36% |
| 10 | 20% | 11% | 29% |

- **In every group, 5 → 6 is the biggest single drop.** Many people settle at exactly 5 or 6, and a limit of 6 lets them all stay free forever.
- **People reach the limit after they've started** (Q46 §4): they begin with 1 to 3 habits and grow. So at 5, the wall arrives after someone has built a routine, which is the moment people pay:
  - “Bought the premium version after 3 days so that I could track more than 5 habits.” (`A55#52`)
  - “I needed help with more than 5 habits so the upgrade was necessary.” (`A13#17018`)
  - At 6 the same decision just happens later, and for fewer people: “So i had an existential chrisis and a debate over if the premium is worth it and decided to go through with the payment.” (`P2#28466`)

---

## 5. What it means for revenue (model)

**The model (first principles):**

> revenue from the limit ∝ downloads × (share of engaged users who pass the limit) × (share of them who buy)

**Inputs:**
- **Share who pass the limit:** Q46, above.
- **Share of them who buy:** no evidence that it rises with the limit. Among reviews that name the limit, "paid or will pay" is 5.9% at 5, 3.8% at 6, 11.6% at 7, 3.8% at 8 and 9.7% at 10: noise, with no trend. So the model holds it constant.
- **Downloads:** they depend on rating.
  - At 5, mentions of the limit run at 12–21 per 1,000 reviews in real apps. About 63% of those are negative, averaging below 3★.
  - That lowers an average of about 4.7★ by **about 0.02★**.
  - At 7 (HabitNow, 2–5 per 1,000) the cost is about 0.005★.
  - A difference of 0.015★ is too small to move downloads measurably.

| Limit | Relative revenue from the limit | Extra buying needed at the limit to match 5 |
|---|---|---|
| **5** | **100** | — |
| 6 | 82 | +22% |
| 7 | 73 | +36% |
| 8 | 62 | +61% |
| 10 | 44 | +125% |

**Checked against real apps (users show, confounded, so direction only).** Play Store apps compared year by year:

| App (Play Store) | Free limit | "I paid" share in reviews | Limit mentions per 1,000 reviews | Rating |
|---|---|---|---|---|
| Habit Tracker (#24) | 5 | 1.5–3.0% | 12–29 | 4.1–4.4 |
| HabitNow (#2) | 7 | 1.0–2.0% | 2–5 | 4.6–4.7 |
| Roubit (#38) | 8 | 0.1–0.8% | 4–15 | 3.8–4.2 |
| Habit Diary (#10) | 10 | 0.04–0.13% | 0.5–1.3 | 4.7–4.8 |

**Reading:**
- Higher limits come with fewer mentions of the limit and a better rating, but also fewer people saying they paid.
- Pricing differs between these apps (one-time, subscription, ads), so this only confirms the direction.
- One HabitNow payer says the quiet part: “The only thing that I really needed was to have more than 7 habits but, the rest is just decoration.” (`P2#12756`)

**Inside one app:** Habit Tracker (App Store) raised its free limit from 5 to 6 in 2025:
- mentions of the limit fell from 18 to 15 per 1,000 reviews;
- the "I paid" share did not fall (3.7% → 6.4%);
- its rating fell in the same years, but its low reviews blame bugs after updates and double charges, not the limit (`eras.txt` in the Free Plan evidence).
- So moving from 5 to 6 did not visibly hurt that app, and it didn't visibly help either.

---

## 6. The widgets follow the limit

The user asked that the widget limit follow the habit limit. Users show three rules.

**1. Every free habit can go on every free widget, and free widgets have no separate limit of their own.**
- Users resent a widget that can't show what they track: “the big widget is limited to 6 habits only” (`A1#48918`).
- They want to choose what goes on it: “Allow the user to select up to 6 habits on a medium widget or less if they want.” (`A1#55617`).

**2. A small free set should fill the widget.** An empty slot looks broken (ledger [C236](<../Feature Ledger.md#c236>)), and a set that fits feels right: “honestly 3 is the perfect amount for the widget anyways” (`A48#1970`).

**3. Plus adds designs and more than 5 habits on a widget, never the basic widget itself** (see the Free Plan Design report §6).

**How 5 fits (first principles, iPhone sizes; Android widgets resize, so they adapt):**

| Widget | Shows with the 5 free habits |
|---|---|
| **Small** | Today's progress ring plus the next habits due (up to 3) |
| **Medium** | All 5 as a list, without scrolling. As a grid: 5 habit tiles + 1 progress tile, so there is never a blank cell |
| **Large** | All 5 with a 7-day strip each |
| **Lock screen** | Progress, plus the next 1–3 due |

- **6 would fill a 3 × 2 grid exactly, but 5 plus a progress tile fills it just as well.** So widgets are not a reason to pick 6.
- **Widgets show only habits due today,** which users ask for (Home Screen Cards and Widgets report §6.4). So on most days a free user has fewer than 5 to show.

---

## 7. Making 5 feel generous

**Users show that 5 reads as fair when framed as focus, and when the upgrade is cheap and one-time:**
- “At first, I didn’t like that we were limited to 5 habits. Now I’m appreciative because it helped me truly focus on the habits that would have the greatest impact.” (`A52#20395`)
- “There is a 5 habit limit for the free version but you dont want to juggle too many things at once.” (`P24#9392`)
- “You only get five habit slots to start, but I'm a believer in gradual success so that doesnt bother me.” (`P105#710`)
- “you can have up to five habits without premium. As for premium itself- it’s only about $10 so it is pretty cheap and easy to afford” (`A1#52504`)
- Against the category it still looks generous: “the free version suffices, allowing you a max of 5 habits instead of usually just 3 habits” (`P31#146`).

**How to say it:**
- **Store page and onboarding:** "5 habits free, forever."
- **Habits screen:** a quiet "3 of 5 free habits" counter.
- **At the wall:** one calm screen: "Plus: unlimited habits, every device, sync and backup. One payment, yours forever."

**What we should not do at launch:**
- **Earned extra slots.** One app lets the free limit grow as people keep checking in. People praise it (“后来发现是会随着使用增加习惯数量的，好评！”, I later found it grows with use, great! `A52#1810`), and its limit complaints fell from 8.2% to 0.6% of reviews (ledger [C270](<../Feature Ledger.md#c270>), consistent with the change but not proven to cause it). But it weakens the upgrade moment and breaks the simple promise "5, forever". Keep it as an idea to test only if limit complaints go over budget.
- **Watch an ad for a slot** (`P10#8744`): we have no ads.

---

## 8. What would change the answer

**Measure these from launch:**
1. The share of free users who reach 5 habits, and after how many days.
2. The share of those who buy within 14 days.
3. The 30-day retention of people who hit the limit and don't buy.
4. Mentions of the limit per 1,000 reviews, and their rating.

**When to raise it to 6 (users show raising is safe; lowering never is):**
- if fewer than about 1 in 10 free users ever reach 5, since then the wall is too rare to matter anyway;
- or if limit complaints go past about 2% of reviews, twice the rate apps at 5 see.

**Never go back down.**

---

## 9. Limits of this research

1. **Reviews are not sales data.** "Paid or will pay" in a review is a signal. The revenue model uses the Q46 pool and holds buying at the wall constant, because no evidence says otherwise.
2. **Apps differ.** The limits of 6, 7 and 8 are dominated by a few apps (Habit Tracker, Me+, HabitNow, Roubit), each with its own price and audience.
3. **Q46's "no binding limit" group is small** (36 people). The main pool figures use all 446.
4. **Some limits count tasks as well as habits** (Me+, HabitNow). They are included, because users treat them the same way.
5. **Chinese reviews of Habit Tracker with a review-for-membership offer** are coded as solicited and not counted as satisfaction.

<!-- APPENDIX -->

## Appendix — reviews cited

21 reviews cited. Ref = store letter (A App Store, P Play Store, N native app) + app number + line index in that app's `reviews.jsonl`.

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#1657` | `13106454979` | App Store (ca) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2025-09-06 | 4★ | CAP6, NOT_ENOUGH, WANT8 |
| `A1#48918` | `11812963753` | App Store (ph) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-10-09 | 3★ | WIDGET_FIT |
| `A1#51610` | `12442625360` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2025-03-20 | 4★ | CAP6, NOT_ENOUGH |
| `A1#52504` | `11146949156` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-04-11 | 5★ | CAP5, ENOUGH, PRICE_FAIR |
| `A1#55617` | `7897921680` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2021-10-10 | 3★ | WIDGET_FIT |
| `A13#17018` | `1551744886` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2017-02-24 | 5★ | CAP5, PAID |
| `A48#1221` | `4031479507` | App Store (ie) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2019-04-19 | 5★ | CAP10, ENOUGH, CHOSE_GENEROUS |
| `A48#1970` | `12193838056` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2025-01-17 | 5★ | CAP_OK, N3, WG_FREE_PRAISE |
| `A48#3374` | `1778949440` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2017-09-07 | 5★ | CAP10, ENOUGH |
| `A52#1810` | `13289981450` | App Store (cn) | 52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus | 2025-10-20 | 4★ | CAP8, ENOUGH, GROWING_CAP |
| `A52#20108` | `13684050383` | App Store (sg) | 52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus | 2026-01-28 | 5★ | CAP10, ENOUGH, WILLPAY |
| `A52#20395` | `12283194695` | App Store (us) | 52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus | 2025-02-07 | 5★ | CAP5, ENOUGH, LIFETIME_PRAISE, X_PAYER |
| `A55#52` | `1601365268` | App Store (au) | 55. Habit-Bull - Daily Goal Planner - Best To Do List Streak Tracker | 2017-04-30 | 5★ | CAP5, PAID |
| `P2#9429` | `a338cc40-1f04-4f60-91dc-fb8fa714f420` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2022-08-31 | 4★ | CAP7, NOT_ENOUGH |
| `P2#12756` | `ff7a5f87-f7f4-461f-a238-64616c014bd3` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2020-04-09 | 4★ | CAP7, PAID, PAID_THIN, X_PAYER |
| `P2#28466` | `1ff6eb18-ebf4-47f4-99f9-939d2fa9b7ed` | Play Store (ru) | 2. HabitNow Daily Routine Planner | 2023-11-06 | 5★ | CAP6, PAID, X_PAYER |
| `P10#8744` | `a8ce023f-7eb7-4186-89aa-fdae2b41b734` | Play Store (en) | 10. Habit Tracker - Habit Diary | 2023-09-15 | 5★ | CAP5, ENOUGH, EARN_SLOT |
| `P24#9392` | `f5545441-7eca-47e8-a443-67748b043224` | Play Store (en) | 24. Habit Tracker | 2018-02-14 | 5★ | CAP5, ENOUGH |
| `P31#146` | `101c7b49-dc1d-4acb-884d-f50409eb5a35` | Play Store (en) | 31. HelloHabit - Habit Tracker | 2026-02-13 | 5★ | CAP5, ENOUGH, CHOSE_GENEROUS, WANT_LIFETIME |
| `P38#1192` | `6f31f14a-1cbf-46e9-a78f-e9c5cbd60d73` | Play Store (en) | 38. Roubit -Daily Life Routine Care | 2023-03-14 | 3★ | CAP8, NOT_ENOUGH |
| `P105#710` | `04db9440-7bb7-4ab3-af47-68b26397bebc` | Play Store (en) | 105. Avocation Goal & Habit Tracker | 2020-10-15 | 4★ | CAP5, ENOUGH |
