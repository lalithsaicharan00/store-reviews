# Free Plan Design — Habit Cap, Widgets and an Honest Listing

*Written by Claude (Claude Code), 28 Sep 2026. Follow-up on 5 vs 6, 7, 8 or 10: [Free Habit Limit — 5, 6, 7 or More](<Free Habit Limit — 5, 6, 7 or More.md>). Research for the free plan: how many habits, what else is free, and how to show the limit on the store page. It builds on [Plus Scope and Account at Purchase](<Plus Scope and Account at Purchase.md>) and [Q46: How Many Habits People Actually Track](<../Home Screen and Visual Design/Today Screen Jobs/46. How Many Habits People Actually Track.md>). A recommendation, not a decision.*

**The goal (the user's words, shortened):** earn good revenue without looking greedy. Get as many downloads as possible, make the free plan genuinely usable, push people to upgrade without making them angry, and feel like better value than the apps people already know.

**The questions:**
1. Does a limit on habits make people upgrade, or just leave? Who complains: free users or payers?
2. Should the cap be **4 or 5**?
3. What if habits were unlimited and only other devices (iPad, Watch, web) were paid? Would people still upgrade?
4. Widgets: free, paid, or split?
5. Apple Watch: paid?
6. Should the limit be shown on the store page? Does showing it cost downloads?
7. What should free include to win downloads without hurting upgrades?
8. How many complaints should we expect and accept?

**How each point is backed:**
- **Users show**: review evidence from this screen or an earlier one.
- **Platform fact**: Apple or Google documentation, linked.
- **Outside data**: published benchmarks, linked.
- **First principles**: reasoned from how the product works.

---

## 1. The short answer

| Question | Answer | Why |
|---|---|---|
| **Does a habit cap make people upgrade?** | **Yes, when people hit it after they are already using the app. It drives them away when they hit it before they have tried the app.** | Users show purchases triggered by the cap and by liking the app first: 10 paid at the cap, 10 paid for unlimited habits, and 33 upgraded after using the free version (4.97★). Almost everyone who complains is a free user: 6 of 176 cap complaints come from payers. Only 28 say they deleted the app, against 176 who complain but stay. |
| **4 or 5?** | **5, fixed forever.** | At a cap of 4, reviews average **2.28★** and 1 says "that's enough" against 21 complaints. At 5 they average **3.66★**, with 14 "enough" against 23 complaints. In the earlier count, 55% of engaged users track more than 4 habits and 45% more than 5, so 5 still reaches the upgrade moment for nearly half. And 5 is above the category's common cap of 3, which people notice and name. |
| **Unlimited habits, only devices paid?** | **No, not as the main lever.** Keep the cap at 5 *and* devices in Plus. | Users show that unlimited-free apps are loved (37 praise reviews, 4.92★) but rarely earn: the unlimited-free apps have the lowest "I paid" share of any group (0.19%). Most people use one phone. The cap is the upgrade moment that reaches the most people. |
| **Widgets** | **Interactive widgets free** for the free habits, home and lock screen. **Plus adds widget designs and sizes.** | Users show paid basic widgets are hated (25 reviews, 1.72★). When one app moved widgets behind the paywall, its 1★ share went from 1.9% to 5.0%. But extra widget styles do sell (18 bought for widgets, 17 happy to pay). |
| **Apple Watch** | **Plus.** You were right. | Earlier screen: 10 bought *because* of the Watch, and 1 in 88 objected to paying. The real risk is a broken Watch app (27 reviews, 2.22★). |
| **Show the limit on the store page?** | **Yes, plainly, but not as the headline.** Put it in the first lines of the description and in one later screenshot. Show it again in the app before the limit is reached. | **Platform fact:** Apple requires it (guideline 2.3.2), and the App Store already lists every in-app purchase and its price on the product page. **Users show:** "I thought it was free" reviews average **1.20★** (85% 1★). People who were told upfront say they would still have downloaded. |
| **What free includes** | Everything needed to build habits on one phone, with **no ads, no account, no nagging** and the full feature set for 5 habits. | Users show free generosity is the most-praised theme in this screen (90 reviews, 4.91★), and generous free plans lead people to pay: "because I've never seen a developer be so generous in a free version" (`P84#14511`). |
| **Expected complaints** | About **1 review in 200** will complain about the 5-habit limit, mostly at 3–4★. | In apps with a cap of 5, 1.4% of reviews mention the cap, and about a third of those complain. That rate fits a 4.6–4.8★ app. |

**One sentence:** 5 habits free forever on one phone, with every feature, free widgets, no ads and no account. Plus is a one-time purchase for unlimited habits, every device, sync, backup, Watch and extra designs. Say so plainly on the store page and in the app before anyone hits the limit.

---

## 2. Method

**Screen:** all 1,238,784 App Store and Play reviews in the corpus. The strict "I paid" rate across all of them is **1.13%**, the baseline for "say they paid" below.

| Pattern (multilingual) | Matches | Apps | Per 10k reviews | Mean ★ | 1★ | Say paid |
|---|---|---|---|---|---|---|
| **Habit cap** ("only 3 habits", "more than 5 habits", "limit of…") | 5,015 | 121 | 40.5 | 3.02 | 27% | 5.5% |
| **Widget near a paywall word** | 1,774 | 119 | 14.3 | 3.31 | 24% | 19.6% |
| **"Thought it was free", misleading, listing** (narrowed to price or limit wording) | 2,684 | 155 | – | 2.80 | 42% | 9.7% |
| **"Up front", transparent, honest about price** | 276 | 45 | 2.2 | 1.77 | 69% | 5.4% |
| **Unlimited habits** | 525 | 68 | 4.2 | 3.70 | 21% | 12.6% |
| **Switching between apps, with a price or limit word** | 4,632 | 139 | 37.4 | 3.67 | 19% | 10.9% |
| **"The free version is enough / generous"** (4–5★) | 2,784 | 98 | 22.5 | 4.87 | 0% | 9.6% |

**Read and hand-coded:** 977 reviews, sampled with a cap per app so no single app dominates. **790 were on topic, from 112 apps.** Every quote below was checked against its review by script.

**Also:**
- **Five before-and-after cases** inside single apps whose free plan changed (`eras.py`).
- **An app-level comparison** of apps grouped by their free cap (`app_buckets.py`).
- **Platform rules and outside benchmarks**, linked where used.

Files: [`Free Plan Evidence/`](<Free Plan Evidence/>).

---

## 3. Does a habit cap make people upgrade?

### 3.1 What people do when they meet the cap

| What they say | Reviews | Apps | Mean ★ | 1★ |
|---|---|---|---|---|
| **Complain about the cap** | 176 | 58 | 2.48 | 38% |
| Say the cap is fine | 53 | 25 | **4.75** | 0% |
| **Say they deleted the app or moved on** | 28 | 21 | 1.50 | 61% |
| Refuse to pay, without leaving | 12 | 10 | 2.17 | 17% |
| **Paid at the cap** | 10 | 9 | 4.30 | 10% |
| Say they will pay | 18 | 15 | 4.33 | 0% |
| Paid for unlimited habits | 10 | 7 | 4.20 | 10% |
| **Upgraded after using the free version for a while** | 33 | 26 | **4.97** | 0% |
| Chose this app *because* its cap was more generous | 21 | 12 | 4.90 | 0% |
| **The cap was lowered later** | 29 | 14 | 1.69 | 52% |
| Hit the cap without warning | 15 | 12 | 2.33 | 33% |
| "I can't even try it" | 14 | 12 | 1.71 | 50% |

**Who complains?** Free users. Of the 176 cap complaints, **6** come from people who say they paid. So the complaint is about the *entry* price, not about value after buying.

**Most people who complain stay.** 176 complain, 28 say they left. Many complain inside a 4–5★ review:
- “5 is quite a lot compared to the usual 3 of other apps, but it still stops me from being as productive as possible.” (`A13#5968`)

**The purchases that work come after use, not at first launch.** Users show three shapes:
1. **Engaged, then hit the cap:**
   - “I just paid for the premium version since I wanted to add more than four habits, but I was able to use the free version for months and was happy with it, too.” (`P14#69`)
   - “the free version was good enough for me but I wanted to achieve more goals this year so I upgraded” (`A48#1016`)
2. **Loved it, paid to support it and get more:**
   - “Also I wanted to add more habits bc it is that useful.” (`A54#333`)
   - “first 2 yrs the free version, loved it, paid for the life-time nearly 2 yrs ago” (`A48#2323`)
3. **Saw the value fast:** “Bought the Lifetime and I was only 12 hrs into this.” (`A34#571`)

**The purchases that fail come before use.** When the cap is too low to try the app, people can't judge it and don't pay:
- “how do you expect me to subscribe without trying anything??” (`A25#366`)
- “An extra habit couldve swayed me into paying $7 for the full version.” (`A86#155`)

This matches Q46: people start with 1–3 habits and grow to about 5. A cap people reach *after* they have started is the one purchase moment that works.

### 3.2 Before and after, inside single apps

| App and change | Before | After | What changed |
|---|---|---|---|
| **Habit Tracker** (outside China): free cap **3 → 5** (2023) | 4.34★, 7.1% 1★, 2.2% say paid | 4.38★, 7.6% 1★, **3.7% say paid** | Rating flat, and more reviewers say they paid. Cap mentions rose (10 → 18 per 1,000), as more people used the app long enough to reach the cap. |
| **Habit**: unlimited free → **cap 3 + subscription** (Feb 2021) | 4.58★, 3.0% 1★ | **1.78★, 65.4% 1★** | Collapse. It also took away features people had bought outright, so it is the worst case, not a pure test of the cap. |
| **Strides**: free goals **10 → 7 → 3** | 6 cap mentions per 1,000 | 22.5, then **44.4** per 1,000 | Each cut multiplied complaints. |
| **Days Since**: widgets **free → paid** (mid-2025) | 4.80★, 1.9% 1★, 6 widget-paywall mentions per 1,000 | 4.62★, **5.0% 1★**, **49** per 1,000 | 1★ share more than doubled. The "I paid" share rose only from 0.75% to 1.25%. |

**Caveats:**
- Habit Tracker's 2025–26 era (cap 6) fell to 3.85★. Its low reviews from then are mostly bugs after updates and double charges; only 51 of 630 mention the limit. So the cap is not the cause.
- In China the same app ran a review-for-membership offer (“评论可得3个月会员”, review and get 3 months of membership). Its Chinese reviews are shown separately in `eras.txt` and left out above.

**What this shows (users show):**
- **Raising a low cap to 5 cost nothing** in rating.
- **Lowering a cap, or taking back something free, is what enrages people.** The 29 "cap was lowered" reviews average 1.69★:
  - “this app used to be the best free habit app, until they now have started charging you to have more than 5 habits” (`A1#45825`)
  - “reducing their free trackers from 7 to 3” (`A48#321`)
- So **pick the number once and never lower it.**

---

## 4. 4 or 5?

### 4.1 Reviews by the cap the reviewer names

| Free cap | Reviews | Mean ★ | 1★ | Complain | "Enough" | Left | Say they'll pay |
|---|---|---|---|---|---|---|---|
| 1 | 39 | 2.87 | 31% | 25 | 9 | 1 | 0 |
| 2 | 45 | 3.00 | 29% | 32 | 7 | 1 | 2 |
| 3 | 94 | 2.43 | 41% | 48 | 12 | **11** | 1 |
| **4** | 29 | **2.28** | **38%** | 21 | **1** | 2 | 0 |
| **5** | 62 | **3.66** | **11%** | 23 | **14** | 2 | 4 |
| 6–8 | 22 | 3.00 | 18% | 10 | 3 | 3 | 2 |

*The cap-1 row includes 4 reviews of an app that allows one goal by design and is loved for it; it is not a paywall.*

**At 4, almost nobody says "enough"; at 5, one in four does.** This matches Q46, where people said whether a cap was enough: **66% said 4 was not enough, 51% said 5 was not enough.**

In their own words:
- **At 4:**
  - “The four habit limit makes the app completely useless.” (`P14#495`)
  - “not even 5 seems a bit too restrictive. good aesthetics, but not worth paying to upgrade.” (`P9#745`)
  - “increasing this limit to 7 (or something like that) would encourage more users to engage with the app and possibly buy the premium version” (`P9#1757`)
- **At 5:**
  - “only 5 habits allowed without paying but I dont care bc i cant stick to more than 5 at once anyway” (`P31#320`)
  - “free version let's you track 5 things which is great to get you started” (`P24#9361`)
- **Asked for directly:**
  - “Only 3 habits in free version. 5 would be perfect” (`A13#19763`)
  - “Five I could understand, but three seems like too few.” (`P70#829`)
  - When reviewers name the number they want, **5** and **10** come up most (7 each).

### 4.2 How many people reach each cap

From Q46 (446 people who say how many habits they track):

| Cap | Share of engaged users above it (would meet the wall) |
|---|---|
| 3 | 63% |
| **4** | **55%** |
| **5** | **45%** |
| 6 | 37% |

**Moving from 4 to 5 gives up about 10 of every 100 engaged users as upgrade candidates.** In return, the 5 that most people want now fits, reviews are much milder, and the cap stops blocking a fair trial. People start with 1–3 habits and grow (Q46 §4). So at 5 the wall comes *after* someone has built a routine, which is the moment people pay.

### 4.3 Where the category sits

Across the corpus, apps whose reviewers name a clear cap mostly stop at **3** (19 apps), or at 2 or 4. Users show they notice and choose on this:
- “Most that I tried had a limit of 3 habits before you had to buy premium. Unfortunately, I had my heart set on 4 habits.” (`A1#55958`)
- “I've downloaded too many to count, only to find out they had habit limits before I found this one” (`P3#8069`)

**At 5 we are more generous than most** without giving the product away. The earlier caution still holds: raising a cap by a slot or two later does not buy back goodwill, because the complaint simply moves to the new number (ledger [C293](<../Feature Ledger.md#c293>)). So choose once.

**Verdict: 5.**

---

## 5. What if habits were unlimited and only devices were paid?

**What unlimited-free earns in goodwill (users show):**
- Unlimited-habit praise: 37 reviews, **4.92★**. Chose the app *because* of a generous cap: 21 reviews, 4.90★.
- “Unlike many other habit tracking apps, users can have an unlimited number of habits without having to pay to upgrade!” (`A20#130`)
- Some ask for exactly this trade: “just let people have infinite habits and let the rest be costly” (`A25#1104`)

**What it earns in money:**
- Apps whose free plan is unlimited have the lowest "I paid" share of any group: **0.19% of reviews**, against 2.8% for cap-5 apps and 3.2% for cap-3 apps (`app-buckets.txt`). Part of this is that the biggest of them, Loop, has nothing to sell, so treat it as direction only.
- The earlier payer screen found "sync / devices / iPad" in 4.3% of payer reviews and "unlimited / more habits" in 1.8% ([Plus Scope §3](<Plus Scope and Account at Purchase.md>)). So devices do sell. But they reach only people who own a second device and want it, while the habit cap reaches everyone who grows past 5.
- Some payers feel habits alone are thin value: “All it has is unlimited habits (which i believe it should anyway) and twelve color choices” (`P105#793`). That argues for **Plus being much more than habits**, which it already is.

**Reasoned from first principles:**
- Most people use one phone.
- With unlimited habits, a single-phone user has almost no reason to buy. Our revenue would then depend on the minority with an iPad or Watch, plus goodwill tips.
- With a cap of 5, the roughly 45% of engaged users who grow past 5 meet a fair, expected moment to buy, and multi-device users have a second reason.
- The goodwill side is already covered: free has every feature, widgets, no ads and no account. The cap is the *only* limit on the free phone app.

**Verdict:** keep both levers. The habit cap at 5 is the broad upgrade moment. Devices, sync, backup and Watch make Plus feel like far more than "more habits".

---

## 6. Widgets

| What users say | Reviews | Apps | Mean ★ | 1★ |
|---|---|---|---|---|
| **Paid for the widget and it's broken or missing** | 29 | 15 | **1.62** | 66% |
| Praise free widgets | 26 | 18 | **4.92** | 0% |
| **Resent that basic widgets are paid** | 25 | 17 | **1.72** | 60% |
| Bought Plus *for* widgets | 18 | 10 | 2.94 | 33% |
| Happy to pay for widgets / widget extras | 17 | 12 | 4.76 | 0% |
| Widgets moved from free to paid | 7 | 3 | 1.29 | 71% |

**Basic widgets are part of using the app, not an extra** (users show):
- “A basic widget should be free. Come on!” (`A36#273`)
- “Davvero per spuntare una casella da widget devo essere premium? È solo un tap sullo schermo.” (Do I really have to be premium to tick a box from the widget? It's just a tap on the screen.) (`P2#21989`)
- The widget is what keeps some people on track: “I can miss notifications, but not if it’s on my Home Screen.” (`A43#358`)
- Taking widgets away hurts most: “That’s why I’m really disappointed to see widgets moved behind a paywall, especially one that isn’t particularly affordable.” (`A3#2110`). That app's 1★ share more than doubled (§3.2).

**But widget extras sell:**
- “I don’t usually buy the “premium” version of apps, but the widgets alone are worth the money.” (`A7#576`)
- A split is accepted: “Widget'lardan bazıları Premium ama geriye kalanlar fazlasıyla iş görüyor zaten.” (Some widgets are premium, but the rest do the job more than enough.) (`P41#439`)
- “The free plan gives everything you need, but the Premium plan gives some additional customization and added features to the widgets.” (`P2#6586`)

**Free widgets make the free plan feel complete:**
- “The free version includes 3 habits to track and includes the widget. I could have done with just that, but the annual subscription is very reasonable” (`P70#378`)
- “you do only get 3 goals with the free version but honestly 3 is the perfect amount for the widget anyways” (`A48#1970`)

**The biggest widget risk is a paid widget that doesn't work** (29 reviews, 1.62★): “I paid to upgrade solely for the use of a widget and no widget is available.” (`A20#3354`)

**Recommendation (users show + first principles):**
- **Free:**
  - interactive home-screen widgets (small and medium) and lock-screen widgets;
  - they show and tick the free habits;
  - they are designed to look complete with 1 to 5 habits. A widget built for more rows leaves blank rows on a free plan, which looks broken (ledger [C236](<../Feature Ledger.md#c236>)).
- **Plus:**
  - more widget designs and sizes (large, year grid, per-habit history);
  - themes for widgets;
  - widgets for more than 5 habits.
- **Never move a free widget into Plus later.**
- **Ship every paid widget working on both platforms first,** or don't sell it yet.

---

## 7. Apple Watch

The earlier screen ([Plus Scope §5](<Plus Scope and Account at Purchase.md>)) read 99 reviews mentioning the Watch together with paying; 88 were on topic:
- 10 bought *because* of the Watch;
- 27 are Watch requests, many from people who already pay;
- **1 objected** to it being paid, and that review is still 5★.

**Watch stays Plus.** The risk is a broken Watch app (27 reviews, 2.22★), so it ships only when check-ins sync reliably both ways.

---

## 8. The store page: will showing the limit cost downloads?

### 8.1 What users show

| What users say | Reviews | Apps | Mean ★ | 1★ |
|---|---|---|---|---|
| **"I thought it was free"** / the listing implied free | 59 | 31 | **1.20** | 85% |
| No real free version: trial or paywall at first launch | 48 | 20 | 1.35 | 79% |
| Charged by a trial they didn't expect | 40 | 11 | **1.10** | 92% |
| **Limit not stated in the listing or before setup** | 28 | 21 | 2.21 | 46% |
| Hit the limit with no warning, after setting up | 15 | 12 | 2.33 | 33% |
| Ad or screenshot showed something the app doesn't have | 11 | 7 | 1.27 | 82% |
| Price unclear, or different from what was shown | 10 | 9 | 1.30 | 90% |
| **Praise for being clear about what's free** | 5 | 5 | 4.80 | 0% |

**The anger is about surprise, not about the price.** People say being told upfront is what they want:
- “I don't care if people decide to charge but say that up front - not once I've installed and starting using the app and then learn I can't enter more than 5 habits” (`P3#7044`)
- “Wish it had said in description only 5 goals free” (`A55#1450`)
- “Please make it clear in the description and screenshots what exactly you get or dont get (4 habits) for free / pro and how much pro costs!” (`P33#238`)
- **Buried counts as hidden:** “It does mention 3 habits in the description. At the very bottom.... after about 10 paragraphs of other text” (`P70#324`)
- **"In-app purchases" alone is not enough:** “but it does not specify when that will be required, nor how often.” (`P130#214`)
- **Screenshots of the paid version mislead:** “Les images de la description correspondent a l'application en version premium.” (The description images show the premium version.) (`P70#1044`)

**Does telling them lose the download?** Reviews can't count people who never downloaded, so this can't be proven either way. What reviews do show:
- **People who were told say they would still have downloaded:** “I wish that it told me up front that if I wanted to use the app to its full potential, I had to pay money. Thats what I have to say, but I would still download this app even if you had to pay for unlimited routines.” (`A43#441`)
- **Being honest wins purchases:**
  - “If I saw an app just like that but more honest, I'd pay them instantly.” (`P33#2103`)
  - “I would have considered purchasing this if it were upfront with cost.” (`A12#265`)
- **Only one reviewer says they would not have downloaded,** and that app had no free version at all: “I downloaded the app then was charged $32.99. I would have never downloaded it otherwise.” (`A13#13303`)
- **A clear cap reads as fair:**
  - “The app is free to download with an available in-app purchase.” (`A86#1673`), praising the pricing model;
  - “it basically encourages you to pay if you will actually use the app” (`P49#363`).

**So (first principles):** the few downloads that honest wording might cost are people who want unlimited free forever. They are also the people who leave the "I thought it was free" 1★ reviews. We lose little by losing them and avoid a 1.20★ review stream.

### 8.2 What the stores require

- **Apple guideline 2.3.2 (platform fact):** "If your app includes in-app purchases, make sure your app description, screenshots, and previews clearly indicate whether any featured items, levels, subscriptions, etc. require additional purchases." ([App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/))
- **Apple guideline 3.1.2(c):** before asking someone to subscribe, "clearly describe what the user will get for the price." It is written for subscriptions, but it is good practice for Plus too.
- **The App Store already shows the price.** The product page shows "In-App Purchases" by the Get button and lists up to 20 items with prices ([Apple: Creating your product page](https://developer.apple.com/app-store/product-page/)). So hiding the limit hides nothing from a careful reader; it only surprises everyone else.
- **Search results show only the first one to three screenshots** ([same page](https://developer.apple.com/app-store/product-page/)). That is where the product's value should go, not the limit.
- **Google Play (platform fact):**
  - metadata must "accurately describe" the app;
  - price and promotional text is not allowed in the title, icon or developer name, e.g. "free for limited time only" ([Play Metadata policy](https://support.google.com/googleplay/android-developer/answer/9898842?hl=en)).
  - So "free" does not go in our title or icon on Play.

### 8.3 Recommendation

- **Title and icon:** no price words.
- **First screenshots (1–3):** the product's value. No limit banner.
- **One later screenshot:** a simple "Free · Plus" comparison. Plus-only features (iPad, Watch, themes) carry a small **Plus** tag wherever they appear in screenshots.
- **Description, first lines:**
  > **Free forever:** track up to 5 habits on your phone, with reminders, widgets and full history. No ads, no account.
  > **Plus, one payment, yours for life:** unlimited habits, iPad, Apple Watch, sync and backup.
- **In the app, before the wall:**
  - the habit screen shows **"3 of 5 free habits"** from the first habit;
  - onboarding says it once;
  - the limit is never a surprise after setup (users show 15 reviews at 2.33★, e.g. “Spent a bunch of time creating habit entry’s to only be asked after 7 entries to subscribe to enter more. Misleading.” `A48#2993`).
- **At the wall:**
  - one calm screen: "You're tracking 5 habits. Plus unlocks unlimited habits, plus every device, sync and backup. One payment, yours forever." Then **[Get Plus]** · **[Not now]**;
  - no countdown timers and no fake discounts (users show: “nonstop “limited time offer” ads for premium. all have fake countdown timers to incite FOMO.” `A31#2131`);
  - their existing habits keep working either way.

---

## 9. What free should include to win downloads

**Users show generosity is the most-praised theme** in this screen: 90 reviews, **4.91★**. What they name:
- No ads.
- No constant upselling: “Doesn’t constantly ask you to upgrade and offers good features in the free version” (`A36#31`).
- Every feature works for the free habits: “So the free version you can really test out and see if this is right for you” (`A1#53770`).
- Better than rivals' paid tiers: “Even the free version is better than the premium of some other apps.” (`P2#9436`)

**Generosity leads to purchases, not away from them:**
- “I'm considering going premium for the first time ever with an app, because I've never seen a developer be so generous in a free version” (`P84#14511`)
- “The free version would have been perfectly fine for my needs, but I upgraded to support the developer.” (`A13#644`)

**What costs goodwill without earning money (users show):**
- **Nagging:** 25 reviews, 1.44★. “Constantly showing advertisement to buy expensive premium subscription… Annoying! Once is enough!” (`A3#4375`)
- **Subscriptions for a tracker:** 33 reviews, 2.06★. By contrast, lifetime is praised (25 reviews, 4.84★) and asked for (16): “Would I pay a one-time fee of $5, absolutely, but a yearly fee, nope!” (`A55#1350`)
- **Taking back what people bought:** 25 reviews, **1.28★**. “I have been downgraded to basic account and lost all of the features I had PAID FOR” (`A20#1185`)
- **Trials that bill:** 40 reviews, 1.10★. Plus is a one-time purchase with no trial, so this cannot happen to us.

**Recommendation — free on the phone:**
- **Habits:** 5, fixed forever.
- **Every habit type and schedule:** yes, for those 5.
- **Reminders:** yes.
- **Full history, calendar, streaks and basic stats:** yes.
- **Interactive home and lock-screen widgets:** yes (§6).
- **Other surfaces:** dark mode, notification actions and Siri / Shortcuts.
- **Data:** export and import, and the phone's own backup.
- **Day end and week start settings:** yes.
- **Never:** ads, an account, or repeated upgrade prompts.

**Plus (one payment):**
- unlimited habits;
- iPad, Android tablets, a second phone, iPhone ⇄ Android, web and Mac later;
- Apple Watch and Wear OS;
- sync and automatic backup;
- Apple Health / Health Connect (first update after launch);
- widget designs, themes and icons;
- deeper stats.

**Never locked, on any tier:** checking in, history, reminders, widgets for existing habits, and export. This matches [02 §3.1](<../../../Architecture/02. Billing and Entitlements.md>).

---

## 10. How many complaints to expect

- **Apps with a cap of 5** (eight apps, 81,276 reviews): **1.4%** of reviews mention the cap.
- **In our sample, about a third of cap-5 mentions are complaints** (23 of 62), and they are mild: the cap-5 group averages 3.66★ with 11% 1★.
- **Estimate:** about **0.5% of our reviews** will complain about the limit, roughly 1 in 200, mostly at 3–4★. For comparison:
  - apps with a cap of 3 see about 1.8% of reviews mention the cap, and those average 2.43★;
  - the "I thought it was free" reviews we can avoid average 1.20★.
- **Reasoned from first principles:** a 4.7★ app can carry 1 in 200 mild complaints. What pulls ratings down is **surprise, lowered caps, nagging and broken paid features**, and all four are avoidable. The plan above avoids each of them.

---

## 11. Limits of this research

1. **Reviews are not conversion data.** "I paid" in a review is a signal, not a sales figure. The app-level comparison (`app-buckets.txt`) is confounded by pricing model, category and audience, so it is used only for direction.
2. **Downloads lost to honest wording can't be seen in reviews.** People who read the listing and didn't download never review. The case for disclosure rests on Apple's rule, the product page's IAP list, and the cost of the 1★ reviews it prevents.
3. **Outside benchmark:** RevenueCat reports a Day-35 download-to-paid median of **12.11% for hard paywalls vs 2.18% for freemium**, with higher refunds on hard paywalls (5.8% vs 3.4%) ([State of Subscription Apps 2025](https://www.revenuecat.com/state-of-subscription-apps-2025)). These are subscription apps. A hard paywall would convert more of those who install, but users show it draws the worst reviews in this screen (1.35★, 79% 1★), so we don't adopt it.
4. **Sampling:** a per-app cap keeps big apps from dominating, so percentages describe the spread of apps as much as the mass of reviews.
5. **Habit Tracker's Chinese reviews** include a review-for-membership offer and are reported separately.
6. **Cap numbers come from the reviewers.** Some misremember, or describe caps that differ by platform.

<!-- APPENDIX -->

## Appendix — reviews cited

54 reviews cited. Ref = store letter (A App Store, P Play Store, N native app) + app number + line index in that app's `reviews.jsonl`.

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#45825` | `9569111950` | App Store (gb) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2023-01-31 | 1★ | CAP_CHANGED, N5 |
| `A1#53770` | `10088230674` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2023-06-30 | 5★ | CAP_OK, N5, UL_PAID_FOR, PRICE_FAIR |
| `A1#55958` | `6644227276` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2020-11-14 | 5★ | CAP_CHOSE_GENEROUS, N4 |
| `A3#2110` | `13876121897` | App Store (gb) | 3. Days Since - Quit Habit Tracker - Sober Streak Day Counter | 2026-03-22 | 2★ | WG_REMOVED, WG_PAID_RESENT |
| `A3#4375` | `11887508168` | App Store (pl) | 3. Days Since - Quit Habit Tracker - Sober Streak Day Counter | 2024-10-29 | 1★ | NAG |
| `A7#576` | `13198372302` | App Store (pt) | 7. Habit Tracker - HabitKit - Streaks & Accountability | 2025-09-29 | 5★ | WG_PAID_BUY |
| `A12#265` | `14099429124` | App Store (us) | 12. That Girl - Routine Planner - Cute Daily Calendar Schedule | 2026-05-24 | 1★ | LS_THOUGHT_FREE, LS_FAIR_WOULDPAY |
| `A13#644` | `1452052715` | App Store (au) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2016-09-18 | 5★ | CONVERT_AFTER_USE, SUPPORT_DEV, FE_GENEROUS |
| `A13#5968` | `6035515512` | App Store (gb) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2020-06-04 | 5★ | CAP_COMPLAIN, N5 |
| `A13#13303` | `5589893386` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2020-02-28 | 1★ | LS_THOUGHT_FREE, LS_WOULDNT_DL |
| `A13#19763` | `3141687798` | App Store (vn) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2018-09-01 | 4★ | CAP_COMPLAIN, N3, WANT5 |
| `A20#130` | `4998652775` | App Store (au) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2019-10-22 | 5★ | UL_PRAISE, CAP_CHOSE_GENEROUS |
| `A20#1185` | `6967047222` | App Store (gb) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2021-02-07 | 1★ | PAID_LOST, X_PAYER |
| `A20#3354` | `6956866789` | App Store (us) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2021-02-05 | 2★ | WG_PAID_BUY, WG_BROKEN_PAID, X_PAYER |
| `A25#366` | `13927978729` | App Store (eg) | 25. Grit - Daily Habit Tracker - Routines & Goals ADHD Planner | 2026-04-06 | 1★ | CAP_COMPLAIN, CANT_EVALUATE, N3 |
| `A25#1104` | `12609243324` | App Store (us) | 25. Grit - Daily Habit Tracker - Routines & Goals ADHD Planner | 2025-05-02 | 2★ | CAP_SURPRISE, LS_THOUGHT_FREE, N3, GATE_OTHER |
| `A31#2131` | `8427510411` | App Store (nz) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2022-03-06 | 1★ | NAG |
| `A34#571` | `10791117607` | App Store (us) | 34. Habit Tracker - Evoday - Daily Streaks Calendar & Goals | 2024-01-06 | 5★ | CAP_PAID, N2, LIFETIME_PRAISE |
| `A36#31` | `13465064480` | App Store (ca) | 36. (Not Boring) Habits - Science-backed habit tracker | 2025-12-02 | 5★ | FE_GENEROUS |
| `A36#273` | `8797076855` | App Store (tr) | 36. (Not Boring) Habits - Science-backed habit tracker | 2022-06-21 | 1★ | WG_PAID_RESENT, WG_BASIC_FREE_ASK, CAP_LEFT |
| `A43#358` | `7010047564` | App Store (us) | 43. Habit Hub - Routine Tracker - Daily Todo, Goals & Schedule | 2021-02-18 | 5★ | WG_FREE_PRAISE |
| `A43#441` | `5644116512` | App Store (us) | 43. Habit Hub - Routine Tracker - Daily Todo, Goals & Schedule | 2020-03-11 | 3★ | LS_LIMIT_HIDDEN, LS_KNEW_DL, N3 |
| `A48#321` | `7031612228` | App Store (ca) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2021-02-24 | 2★ | CAP_CHANGED, N3, SUB_PRICE |
| `A48#1016` | `3598379156` | App Store (gb) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2019-01-01 | 5★ | CAP_PAID, CONVERT_AFTER_USE, X_PAYER |
| `A48#1970` | `12193838056` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2025-01-17 | 5★ | CAP_OK, N3, WG_FREE_PRAISE |
| `A48#2323` | `8205982720` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2022-01-05 | 5★ | CONVERT_AFTER_USE, LIFETIME_PRAISE, X_PAYER |
| `A48#2993` | `2957558274` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2018-07-24 | 1★ | LS_LIMIT_HIDDEN, CAP_SURPRISE, N7 |
| `A54#333` | `7597717527` | App Store (us) | 54. Avocation - Habit Tracker - Daily planner & ADHD organizer | 2021-07-20 | 5★ | CAP_PAID, CONVERT_AFTER_USE, SUPPORT_DEV, X_PAYER |
| `A55#1350` | `3713152341` | App Store (us) | 55. Habit-Bull - Daily Goal Planner - Best To Do List Streak Tracker | 2019-01-30 | 3★ | CAP_WILLPAY, CAP_REFUSE, N5, SUB_PRICE, WANT_LIFETIME |
| `A55#1450` | `2320648884` | App Store (us) | 55. Habit-Bull - Daily Goal Planner - Best To Do List Streak Tracker | 2018-03-18 | 4★ | CAP_WILLPAY, LS_LIMIT_HIDDEN, N5 |
| `A86#155` | `1346902450` | App Store (ca) | 86. Today Habit tracker - For to-dos, routines & goals | 2016-03-12 | 3★ | CAP_COMPLAIN, N1, CANT_EVALUATE |
| `A86#1673` | `1351545012` | App Store (us) | 86. Today Habit tracker - For to-dos, routines & goals | 2016-03-22 | 4★ | CAP_OK, N1, LS_FAIR_DISCLOSED |
| `P2#6586` | `b902b28d-02c6-44ff-a360-03e0a243ab7b` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2023-11-11 | 5★ | FE_GENEROUS, WG_PAID_OK |
| `P2#9436` | `e0cd418a-eb07-4ecc-bca5-10b58f52f580` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2022-08-29 | 5★ | FE_GENEROUS, VALUE_BETTER |
| `P2#21989` | `db7bbcba-2fdd-4f4b-999a-60e8d981ae2a` | Play Store (it) | 2. HabitNow Daily Routine Planner | 2023-12-28 | 3★ | WG_PAID_RESENT |
| `P3#7044` | `be615c86-1ed0-4f29-a0d0-120c8615cbaa` | Play Store (en) | 3. Loop Habit Tracker | 2022-01-11 | 5★ | CAP_CHOSE_GENEROUS, LS_LIMIT_HIDDEN, N5 |
| `P3#8069` | `db33670c-59b0-4b9d-99b0-08c4dfd975d5` | Play Store (en) | 3. Loop Habit Tracker | 2021-04-24 | 5★ | CAP_CHOSE_GENEROUS, LS_LIMIT_HIDDEN |
| `P9#745` | `3d0aeeba-d042-49bf-90e0-27599c8cbf2b` | Play Store (en) | 9. Habit Tracker - HabitKit | 2024-12-18 | 3★ | CAP_COMPLAIN, CAP_REFUSE, N4, WANT5 |
| `P9#1757` | `27fa21c1-1012-4af7-a6a3-4accf426e4aa` | Play Store (pl) | 9. Habit Tracker - HabitKit | 2025-02-16 | 2★ | CAP_COMPLAIN, N4, WANT7, CANT_EVALUATE |
| `P14#69` | `54872ee8-a563-42f0-b26b-2f3d9820b4a9` | Play Store (en) | 14. Habit Pixel - Streak Tracker | 2026-06-08 | 5★ | CAP_PAID, CONVERT_AFTER_USE, N4, X_PAYER |
| `P14#495` | `384ae408-39f4-43ee-ba3e-7c06fc895b60` | Play Store (es) | 14. Habit Pixel - Streak Tracker | 2026-06-24 | 1★ | CAP_COMPLAIN, N4 |
| `P24#9361` | `457087a1-7709-4c69-ad22-0804c7b302bd` | Play Store (en) | 24. Habit Tracker | 2018-02-19 | 4★ | CAP_OK, N5 |
| `P31#320` | `1ee83ecc-ca4d-47fb-9dcd-508bfe669883` | Play Store (en) | 31. HelloHabit - Habit Tracker | 2025-03-31 | 5★ | CAP_OK, N5, WG_FREE_PRAISE |
| `P33#238` | `01fa728f-4cd3-4fa1-90be-ab67edfa3224` | Play Store (de) | 33. Productive - Habit tracker | 2020-02-05 | 3★ | LS_LIMIT_HIDDEN, N4, WANT_LIFETIME |
| `P33#2103` | `afc25d72-775d-45ba-a56e-6427203ffc15` | Play Store (en) | 33. Productive - Habit tracker | 2020-02-05 | 3★ | LS_HARD_PAYWALL, LS_FAIR_WOULDPAY |
| `P41#439` | `6a2ec6c1-e1fe-471f-9df5-72e84df88c78` | Play Store (tr) | 41. Routineday Daily Habit Tracker | 2026-08-24 | 5★ | WG_PAID_OK, WG_FREE_PRAISE |
| `P49#363` | `67d39773-a3a0-49ea-bc97-863cf1c59ea3` | Play Store (en) | 49. RoutineFlow - Routine for ADHD | 2025-11-14 | 5★ | CAP_OK, N1, LS_FAIR_DISCLOSED |
| `P70#324` | `cbbbc468-cf5a-44a4-ae8a-91e02ec892bb` | Play Store (en) | 70. everyday Habit Tracker | 2023-04-12 | 2★ | LS_LIMIT_HIDDEN, N3 |
| `P70#378` | `ef33150a-1edf-434e-820e-0f4930d6fe31` | Play Store (en) | 70. everyday Habit Tracker | 2022-08-25 | 5★ | WG_FREE_PRAISE, CAP_OK, N3, PRICE_FAIR |
| `P70#829` | `809c870b-618f-4f7f-b966-66431d326586` | Play Store (en) | 70. everyday Habit Tracker | 2019-02-02 | 4★ | CAP_COMPLAIN, N3, WANT5 |
| `P70#1044` | `bb274267-001f-4328-8a81-97d9f61f9969` | Play Store (fr) | 70. everyday Habit Tracker | 2018-09-11 | 1★ | LS_LIMIT_HIDDEN, LS_SCREENSHOT_PAID, N3 |
| `P84#14511` | `0e8cb56f-71b2-4e54-9082-61740a2b211c` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2022-12-28 | 5★ | FE_GENEROUS, CONVERT_AFTER_USE, SUPPORT_DEV |
| `P105#793` | `f089b3a1-63cd-41e2-9500-f09409e80909` | Play Store (en) | 105. Avocation Goal & Habit Tracker | 2020-09-03 | 3★ | UL_PAID_FOR, PAID_THIN, X_PAYER |
| `P130#214` | `d1d0138d-7cdc-40c6-9aa2-de9be570f118` | Play Store (en) | 130. Way of Life - habit tracker | 2021-08-29 | 4★ | LS_LIMIT_HIDDEN, N3 |
