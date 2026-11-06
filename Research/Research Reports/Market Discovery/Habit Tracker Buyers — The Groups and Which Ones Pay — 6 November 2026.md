# Habit Tracker Buyers — The Groups and Which Ones Pay

Written by Claude (Claude Code), 6 November 2026, at the user's request: "in both play store and app store … people are
buying habit trackers but not all of these are same audience or same set of people, so I want to different groups in
them across all apps and which groups are paying money."

## The answer in short

People who download "a habit tracker" are at least **seven different groups**. They don't just differ in who they are;
they go to different kinds of app, and **which kind of app someone picks predicts whether they pay far better than
anything they say about themselves.** Once you compare people inside the same app, saying "I have ADHD", "I'm a student"
or "I go to the gym" moves the share who say they paid by only 0.7× to 1.5× (§3).

| # | Group | What they want | Where the money is | Do they pay? |
|---|---|---|---|---|
| 1 | **People looking after their mental health** | A kind companion that makes self-care feel good: a pet, a journal, gentle check-ins | **The most money of all.** Finch alone is ~$1M/month on the App Store and ~$700K on Google Play | Yes, on a large scale, through a yearly subscription. A small share of each app's reviewers, but a very large audience |
| 2 | **Self-improvers who want to be told what to do** | A coach, a programme, a 66-day plan | **Large:** Me+, Life Reset, Grit, Fabulous ($50K–$200K+/month each) | Yes, but often under pressure: quiz → paywall → yearly plan. They also resent paying the most (6.3% of reviews, 11.4% on the iPhone) |
| 3 | **Trackers** (people who just want to record and see their habits) | A clean list, streaks, stats, widgets; no fuss | **Medium, spread over many apps:** InnerGrow ~$100K, Productive ~$70K, HabitKit and Habitify ~$40K/month on the iPhone; HabitNow ~$12K on Android | **Most willing, per person:** 1.55% of reviews are from happy buyers, ~3× groups 1 and 2, and they resent the price least. They want a fair one-time or small yearly price |
| 4 | **People with ADHD who need structure** | Routines that tell them what to do next, with timers and time blindness in mind | **Small to medium:** Routinery ~$40K, Tiimo 32K subscribers (2022) | **The highest rate of all:** 1.62% happy buyers, and they say it changed their day |
| 5 | **Gamers** | Levels, quests, avatars, a party | **Small:** Habitica ~$50K Android + ~$20K iPhone | Rarely (0.34%). Those who do buy cosmetics or support the game |
| 6 | **Counters and quitters** | "Days since" a cigarette, a drink, a haircut | **Small** (Days Since; I Am Sober is outside our data) | Rarely (0.36%). The free version is enough; payers buy a lifetime unlock for widgets or the Watch |
| 7 | **To-do list users** who arrived by search | A free list | **Very little** | Hardly ever (0.27%); when they do, it's to remove ads |

**For our app** (a generic tracker: free core, Plus later): our buyers are **group 3**, with **group 4** close by. They
are the most willing to pay of all seven, but they pay for a **fair price, a one-time option, the look, widgets and more
habits**, and much less for sync and other devices (§4, §5). Groups 1 and 2 hold most of the market's money, and we
would have to be a different product, sold a different way, to get it.

## How this was checked

Three kinds of evidence, kept apart as W2 asks:

1. **Machine counts** over every English-language review in the corpus: **485,166 reviews from 199 apps** (App Store:
   the US, UK, Canada, Australia and other English-speaking storefronts; Google Play: reviews marked English). 1,184,183
   reviews in all languages were loaded; 4 off-topic Play apps were left out (a food delivery app, a video-call app,
   Hevy and My Study Life). Keyword lists, not reading, so they are **labelled as counts**.
2. **Reading by hand:** about **150 reviews** from people who say they paid, a random sample of up to 22 from each kind of
   app (`sample.txt`), to check what the counts mean and to find the quotes.
3. **Web sources** for revenue (Codex's 21 Oct revenue report in this folder, unchanged) and RevenueCat's 2025 and 2026
   subscription benchmarks, Tiimo and AppGoblin pages (fetched 6 Nov 2026).

**What "pays" means here.** Reviews can't show who paid; they show who *says* they paid. The count used is a **happy
buyer**: a 4★ or 5★ review in which the person says they paid, bought, subscribed or upgraded, or that it was "worth the
money". A 1–2★ "I paid and it's broken" is counted separately, because subscription apps with problems produce many of
those. The rate is a signal of how willing a group is, **not a conversion rate**. Where revenue is given, it comes from
the revenue report, with its low confidence.

**Grouping the apps.** Each app was put in one of seven kinds by what its listing sells (the list is in
`apptypes.py`). The kind a person chose is the clearest sign of which group they belong to.

Scripts, counts and the read sample are in [Habit Tracker Buyer Groups Evidence](<Habit Tracker Buyer Groups Evidence/>).

## 1. The seven groups, by the apps they choose

Machine counts over English reviews. "Happy buyer" and "price complaint" are shares of each group's reviews.

| Kind of app | Apps | English reviews | Happy buyers | Price complaints | Avg ★ |
|---|---:|---:|---:|---:|---:|
| A. Self-care companion (Finch, TeddyCare, Dear Me, Roubit, Habit Rabbit …) | 15 | 75,834 | 0.55% | 2.04% | 4.70 |
| B. Guided self-improvement (Fabulous, Me+, Life Reset, Grit, Atoms, 21 Days …) | 25 | 157,466 | 0.56% | **6.34%** | 3.99 |
| C. ADHD and routine planners (RoutineFlow, Routine Planner, Tiimo, Rabit, Avocation …) | 21 | 13,321 | **1.62%** | 3.50% | 4.05 |
| D. Generic trackers (InnerGrow, HabitNow, HabitKit, Streaks, Loop, Productive, Habitify …) | 114 | 126,814 | **1.55%** | 2.48% | 4.28 |
| E. Gamified RPG (Habitica, Habit Hunter, Habicat, Fun Habit …) | 11 | 13,365 | 0.34% | 0.82% | 3.98 |
| F. Quit and "days since" (Days Since, Quit Bad Habits, Days Without) | 3 | 8,708 | 0.36% | 2.01% | 4.77 |
| G. To-do lists found by "habit" search | 7 | 89,039 | 0.27% | 0.15% | 4.64 |

Two things follow.

- **Revenue and willingness don't line up.** The companion and coach apps (A, B) hold most of the money but have the
  *lowest* share of happy buyers. They sell to a very wide audience through a paywall and a yearly subscription (67% of
  Health & Fitness subscriptions sold are yearly, RevenueCat 2025), so a small share of a huge crowd pays. Trackers and
  ADHD planners (C, D) have a narrower audience, but a much larger share of it pays and says it was worth it.
- **Group 2 pays under pressure.** One review in 16 in group B complains about price or billing, one in 9 on the iPhone,
  against one in 40 for trackers. In the read sample, group B's happy buyers paid for the content and the coaching
  (23% mention it), and several mention a trial that turned into a charge. Codex's revenue report found the same:
  43.7% of Life Reset's reviews attack how it's sold.

## 2. Who each group is, from the reviews read

**Group 1: looking after their mental health (companion apps).** Young people, often in school or college, with anxiety,
depression or ADHD. A quarter of their happy buyers mention mental health or ADHD; another quarter mention the pet's
clothes, furniture or friends. They pay because the app made them feel better, quickly:

> "as a teen struggling with a lot when it comes to school … three hours into having it I already bought the
> subscription … I don't get a lot of income, only about 40 bucks a month but this is super affordable" (Finch,
> `8623550042`)

> "I have ADHD and common advice to manage it is to turn tasks in to a game" (Finch, `8494944241`)

> "I've paid for the app, and talked a couple of friends into paying" (Finch, `10008414136`)

**Group 2: self-improvers who want a coach.** They want to be led: "It's like a personal life coach in your hand"
(Fabulous, `7163473835`); "I paid for the annual and … the best $20 I've ever spent" (Me+, `219f04e6-b087-4369-a25a-54ba5cc30619`).
Some come with a diagnosis too: "I suffer with PTSD and anxiety … I even bought the year subscription" (Fabulous,
`331a2bd8-b06e-45d3-b09e-9c9632807061`).

**Group 3: trackers.** Adults who have tried several apps and know what they want. They name the reason they paid more
precisely than anyone else: a one-time or lifetime price (16% of their happy buyers), widgets (8%), sync between devices
(6%), stats and export (6%), more habits (5%).

> "I never leave app reviews and I never buy apps. Bought the premium here when I didn't even need the extra features"
> (HabitNow, `beb9ef08-3794-450d-a503-f8c70265a9c7`)

> "If you want a completely free app use Loop Habit Tracker, however, this app honestly is worth it … especially since
> you don't have to pay a stupid subscription" (HabitNow, `5c3d6034-41b3-49cb-8172-e493fe8034ab`)

> "The price to unlock all features ($2/month, $12/year) is reasonable and affordable. I upgraded to the yearly
> subscription after trying it out for a week" (HabitKit, `13596249635`)

Inside this group is a **free-only subgroup**: Loop's 14,959 English reviews have a happy-buyer rate of 0.05%, because
Loop is free and open source. People who choose it are telling you they won't pay.

**Group 4: ADHD and structure.** The highest rate of happy buyers, and the strongest words. They pay because the app
tells them what to do next, with time on it:

> "As someone with ADHD who had trouble with time management, this app is EXACTLY what I needed" (RoutineFlow,
> `f43c3ff1-e48c-409a-aa0d-7f9405ef7b11`)

> "you have ADHD so you have no idea how long it actually takes for you to take a shower? Good news, they planned for
> that … I'm paying real life human dollars for this app and it is worth every penny" (Routine Planner, `12625991801`)

17% of their happy buyers mention a lifetime price ("great $9.99 lifetime deal", RoutineFlow,
`2dfe04e0-5488-4027-adb2-4ba15248d50c`).

**Group 5: gamers.** They pay for the game, not the tracking: "it's basically only for cosmetics" (Habitica,
`f4df2d78-3f9c-4ed9-9c4e-15dab27e866f`); "Then I bought my avatar a hat. 10/10" (Habitica,
`d1fed9dc-12ef-437b-b45b-7e13129c7d2e`). 31% of their happy buyers mention pets, gems, quests or avatars; 13% paid to
support the developer.

**Group 6: counters and quitters.** Quiet, satisfied, and content with free: "The free version is perfectly adequate …
I wish the lifetime license was a little bit cheaper" (Days Since, `13171944329`). A third of their happy buyers paid for
widgets; "happy we don't have to subscribe" (Days Since, `12708219985`).

**Group 7: to-do list users.** They don't pay; the few who do (19%) pay to remove ads.

## 3. What people say about themselves barely changes whether they pay

Reviews where people describe themselves were counted with keyword lists (ADHD, mental health, students, fitness, faith,
parents, medication and others; `lift.py`). At first, nearly every group looks more likely to pay than average. That is
mostly because long reviews mention both who someone is *and* that they paid, and because some apps attract both.
Compared **inside the same app and against reviews of the same length** (`lift2.txt`):

| Who they say they are | Reviews | Happy buyers, against the same app and length |
|---|---:|---:|
| Faith (prayer, Bible, Quran) | 355 | 1.51× (few reviews) |
| Parents and partners | 5,670 | 1.35× |
| Taking medication or vitamins | 1,612 | 1.35× |
| ADHD or autism | 7,611 | 1.25× |
| Apple Watch, iPad, widgets, Shortcuts | 11,568 | 1.17× |
| Fitness | 10,086 | 1.12× |
| Mental health | 14,140 | 1.05× |
| Stats and charts | 4,233 | 0.97× |
| Gaming words | 18,400 | 0.84× |
| Students | 2,208 | 0.80× |
| Quitting something | 1,527 | 0.70× |

So inside one app, people with ADHD, parents and people tracking medication pay a little more, students and quitters a
little less, and the rest are about average. **The big differences are between kinds of app (0.27% to 1.62%, six times
apart), not between kinds of people inside an app.** Someone has already sorted themselves by the time they install.

## 4. The iPhone and Android

Inside the same kind of app, iPhone reviewers say they paid about **twice as often** as Android reviewers: trackers
2.47% against 1.00%, companion apps 0.59% against 0.21%, coach apps 0.90% against 0.40%. ADHD planners are the exception
(1.80% against 1.57%), and they are mostly Android apps in our data. iPhone reviewers also complain about price more
(trackers 4.96% against 0.99%), so it isn't only that they are happier; they talk about money more.

Outside the reviews, RevenueCat's 2026 benchmark says the same with real payments: North America converts 2.8% of
downloads to paying against 0.7% in India and South-East Asia, pays $32 a year per payer against $14, and Google Play
loses 31% of its cancellations to failed payments against 14% on the iPhone. Health & Fitness apps have the best
revenue per install of any category (median $0.44 in 14 days; RevenueCat 2025).

## 5. What it means for our free core and Plus

Our app is a generic tracker, so **our buyers are group 3, with group 4 next to it**. They are the people most willing
to pay per person, and they resent paying least. What the evidence says about selling to them:

- **A one-time price matters to them.** It's the most common reason trackers give for paying (16%), and the same for
  ADHD planners (17%). The earlier study of HabitKit and HabitNow buyers found 26% and 11%
  ([Phones Only, No Accounts](<Phones Only, No Accounts — Why, 21 October 2026.md>) §1). **Keeping the $39.99 lifetime
  beside the ~$11.99 yearly fits this group;** HabitKit sells at $2 a month and $12 a year, and its buyers call that
  "reasonable and affordable".
- **Sync and other devices are a minority reason.** 6% of trackers' happy buyers mention sync or another device, and
  1% elsewhere. It does sell to some (the iPad owner who paid for sync, `8196026084`), and a broken sync after paying is
  one of the angriest kinds of review (`b919dbed-33b7-4570-bf91-3cdd9d290a18`). **A Plus built mainly on sync, Watch,
  tablet and Mac would be selling the least-asked-for reason to the group most willing to pay.** The look, widgets,
  more habits and the year at a glance carry more of it (and are already in the 27 Oct Plus plan).
- **Don't sell like group 2.** Quiz-and-paywall funnels bring money and the worst reviews (6.3% price complaints,
  3.99★). Trackers' happy buyers often say they paid *because* they weren't pushed: "I paid premium to show the app
  creator what a fantastic app he/she/they created" (InnerGrow, `9456468052`).
- **Group 4 is the nearest group we could serve better.** They pay the most readily, and our routine player and timer
  are the features they pay for elsewhere ("tells me what to do and when to do it"). This is a direction to consider,
  not a decision.
- **Groups 1, 5, 6 and 7 are not our buyers.** Groups 5–7 rarely pay anyone. Group 1 pays a great deal, but for a pet, a
  feeling and content, which is a different product.
- **Expect more iPhone buyers per user than Android ones**, roughly twice as many by both the reviews and RevenueCat.

## 6. What the data covers and what it doesn't

**Covered** (English reviews in this repository): 70 App Store apps and 129 Google Play apps. Among the top earners:
Finch (App Store only), Me+ (both), Fabulous (both), Life Reset (App Store), Grit, InnerGrow, Productive (both),
Habitify (both), HabitKit (both), Streaks (App Store), HabitNow, Loop, Habitica (both), MyRoutine (both), TeddyCare,
Dear Me (both), HelloHabit (both), RoutineFlow, Tiimo (Google Play, 136 English reviews), Days Since (App Store).

**Not covered by our review data:** Finch on Google Play, Routinery, I Am Sober, Daylio, Structured, Stoic and Bearable.
These are big apps in groups 1, 4 and 6, so those groups rest on fewer apps than group 3. **Non-English reviews were not
counted** (about 700,000), so the groups describe English-speaking buyers; RevenueCat's regional numbers suggest buyers
elsewhere pay less often and less.

**Limits:**

- **Keyword counts, not reading.** The self-description lists catch some wrong reviews (for example "pet" in a
  sentence about a real pet). The 150 reviews read agreed with the groups they were put in; they are too few to give a
  precision figure.
- **Saying you paid isn't paying.** Some kinds of app make people talk about money more (a subscription that renews,
  a trial that turns into a charge), so the rates compare willingness to say so, not conversion.
- **No age or gender data.** None of the sources fetched gives buyers' age or gender. "Young people" in group 1 comes
  from what reviewers say about themselves (teen, college student), not from a measured share.
- **Revenue is low-confidence** and mixes sources and months, as the 21 Oct revenue report says. Life Reset's
  $203K/month isn't split by store.
- **Grouping apps is a judgement.** InnerGrow's App Store name includes "ADHD Planner", but it's a generic tracker
  with a habit limit, so it's in group 3.

## Sources

- Review corpora: `App Store Reviews/`, `Play Store Reviews/` (read-only).
- [Habit Apps — Revenue Estimates and Provisional Store Top Tens](<Habit Apps — Revenue Estimates and Provisional Store Top Tens — 21 October 2026.md>) (Codex, 21 Oct 2026), for every revenue figure.
- [Phones Only, No Accounts — Why](<Phones Only, No Accounts — Why, 21 October 2026.md>) §1, for HabitKit and HabitNow buyers' reasons.
- [RevenueCat, State of Subscription Apps 2025](https://www.revenuecat.com/state-of-subscription-apps-2025/): Health & Fitness 67% yearly, 14-day revenue per install median $0.44, trial-to-paid median 39.9%.
- [SaaStr's summary of RevenueCat's 2026 report](https://saastr.com/the-top-10-learnings-from-revenuecats-state-of-subscription-apps-how-115000-mobile-apps-deliver-16b-in-revenue-whats-working-whats-quietly-killing-growth) (7 Mar 2026): North America against India and South-East Asia, Google Play's failed payments.
- [Sifted on Tiimo](https://sifted.eu/articles/tiimo-planning-app-for-neurodivergent-people) (28 Sep 2022): 32K paying subscribers at €19 a year; [Tiimo on going freemium](https://www.tiimoapp.com/blog/why-tiimo-went-freemium) (updated 18 Mar 2025): over a million users.
- [AppGoblin, I Am Sober](https://appgoblin.info/apps/672904239) (crawled 1 Nov 2026): 17.8M installs, an estimate of $10K+ a month, which is a floor band.
