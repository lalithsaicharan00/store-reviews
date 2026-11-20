# What People Actually Pay For — App by App

Written by Claude (Claude Code), 20 November 2026, at the user's request: "read each and every review by hand",
"I need genuine information from real data", and "push it because it is going to be important".

This is a running report. Apps are added one at a time. Every number comes from reviews read in full and labelled by
review ID; the labels and the scripts that count them are in [`Evidence/`](Evidence/README.md), so any number can be
recounted and any review traced.

## The question

Our app launches free. Most of what rival apps charge for, we give away. So, app by app: **once that is set aside, is
there anything people genuinely pay for?** The user, 20 Nov 2026: "Something that genuinely adds value… if you're
suggesting something that is very, very less, but still just because I asked you… then this becomes a bloat."
The end goal is a plan that holds a **one-time purchase and a subscription** together and makes sense as a whole.

### How we count (the user's rules)

- **Out of the equation:** what we give free or won't build:
  - more habits / the free habit limit;
  - widgets;
  - statistics and reports;
  - backup and export;
  - sync between devices. This one comes back only if a subscription pays for a server.

  People do pay for these, but they're no use to us as answers.
- **Read by hand, every review,** in its own language. No keyword-only counts. Labels are saved by review ID, so the
  numbers don't change between answers.
- **Review-for-reward reviews are excluded,** for example the first app's Chinese "leave a review for Premium"
  reviews. China is reported separately.
- **"Paid because of X" counts only when the review says so.** Mentioning a feature isn't a reason to pay.
- **Suggest a feature only when the data shows people pay for it.** Small signals are reported as small, not
  promoted.

## Summary so far

| App | Payers read | What made them pay, once the giveaway list is set aside | Anything new worth building? |
|---|---|---|---|
| 1. Habit Tracker – Goal Tracker & ADHD Planner (App Store) | 962 | Goodwill and a low one-time price; buying at the purchase screen; the family plan (a pricing tier, not a feature); **doing habits together, ~20** | **Doing habits together** is the only candidate. It's small, real, and needs a server, so it would belong in a subscription. Not yet. |
| 2. Daily Habits (App Store) | 44 | Cheap, one-time, worth it 16; already owns the developer's other apps 5; Calendar sync 2; Watch 2; no ads 1 | Nothing new. This app is closest to our plan (unlimited habits free, ~$4 one-time Pro), and with nothing basic locked, almost every reason is price and goodwill. |
| 3. Days Since (App Store) | 82 | Price and goodwill 31; widgets (locked in July 2025) 14; reminders 5; colours 4; goals 2 | Nothing new. Locking the once-free widgets brought a wave of 1★ reviews (1★–2★ from 2.1% to 6.9%). |
| *Calendar sync, all habit apps* | 310 reviews about it | Asked for 261 times; paid for because of it 3; would pay 11 | A request, not a reason people pay. If built, read-only first (show calendar events on Today). |
| 7. HabitKit (App Store + Play) | 297 | Goodwill (worth it, cheap, support the developer, one-time price, design) 134; locked widgets, cap and stats 58; bought at once 20 | Nothing new. |

**Across every app so far, goodwill is the largest named reason.** People pay because the app is good and the price
feels fair, usually a small one-time price, at a moment when something is there to buy. Goodwill alone, with
nothing to buy, is a different story: see "[A tip jar instead of Plus?](#a-tip-jar-instead-of-plus)".

---

## App 1 — Habit Tracker – Goal Tracker & ADHD Planner

App Store, 56,653 reviews (40,991 from China). Report: [`App Store Reports/01…`](<../../../App Store Reports/01. Habit Tracker - Goal Tracker & ADHD Planner (REPORT).md>).

### Who paid, and what made them pay

All 962 reviews that say they paid were read in full. One more turned out to have got Premium free and is excluded.
505 say what made them pay; 457 never do. Those 457 average 2.84★ and are mostly complaints written after paying.

| What made them pay | All payers | Outside China | US |
|---|---|---|---|
| **Goodwill:** liked it 102, cheap / one-time 87, used it long 44, to support 30, recommended 16 | 259 | 234 | 97 |
| **Bought on the spot:** at the purchase screen 70, time-limited discount 41 | 103 | 59 | 30 |
| **Outgrew free:** habit cap 47, sync 17, reports 16, kept Premium after the trial 11, widget 7, Watch 6 | 102 | 75 | 36 |
| **For other people:** family plan 80, sharing habits 18 | 96 | 95 | 36 |
| Paid, never says why | 457 | 296 | 121 |

A review can be in more than one row. Recount with `Evidence/1-trigger-tally.py`.

### Once the giveaway list is set aside

| Reason | Payers | What the reviews actually say |
|---|---|---|
| **Family plan** | 80 | They paid for the family tier to unlock Premium for a partner or children, and nearly all could not share it (2.69★). **This is a pricing tier, not a feature:** in a free app there's nothing to unlock. (D16 already says no Plus Family.) |
| **Doing habits together** | ~20 | They paid specifically to share habits with a parent, child, partner or friends; every one says it broke. "I specifically got this app to share some habits with my dad for accountability… Paid $5" (8241326617); "it was the sharing feature which made me to buy lifetime pass" (9114508292); "bought it to motivate my kids with a little peer support" (10815625162); "the whole reason… a 75 soft challenge with family" (14503895960). |
| Apple Watch | 6 | Outside phones-only (D16). |
| Apple Health | 2 | One wanted sleep logged automatically (11408799874). |
| Spanish language | 2 | Language should be free anyway. |
| Paid as a commitment ("sunk cost") | 1 | 13269586684. |
| Backfill past days, more reminder times | 1 each | — |

Prices that payers name: "$5" (2022), "$5.99" lifetime (2023), "$8" lifetime (2024), "$9.99" lifetime (2025), "€7"
(2023), "€6 in the sale" (2026).

### "Reports": what they are

In this app, "reports" are a kind of statistics, but a specific kind: **one page showing all your habits together**
for a week, month or year, as a grid of filled days. It includes completion %, best day and best streak, plus a Year
in Review. Stats for a single habit were mostly free; this board was Premium (from January 2022).

- 6345193240 (translated): "can see all habits' month and year completion side by side… bought the full version for this".
- 8348168108: "I did the lifetime paid to get the reporting".
- 11309506354 (translated): "reports were the main reason I paid".

**16 of 962 payers name reports as the reason, 8 of them outside China.** The app's earlier report called reports "the
#1 stated reason people pay". Read one by one, that is wrong. For us, this view belongs in the free Progress page,
because stats are free.

### Doing habits together, in depth

Every review that might be about doing habits with other people was found with a word search in 11 languages and
read by hand: 1,011 candidates, of which 562 are on topic. Two hand-read samples of what the search left out found
about 2.5% relevant, so roughly 30 more exist and the counts are a floor.

In 2019 China, a "invite a friend for free Premium" promotion inflated mentions, so China is shown separately.

| | Outside China | US | China |
|---|---|---|---|
| Reviews about doing habits together | **286** (1.8% of 15,662) | 151 (2.8% of 5,436) | 276 |
| Do it, like it, or chose the app for it | 98 | 49 | 172 |
| Want it or plan to | 27 | 14 | 65 |
| **Say it's broken** | **180 (63%)** | 97 | 40 |
| Say they paid | 43 | 24 | 9 |
| Blocked because friends use Android | 8 | 7 | 5 |
| Average rating | 3.49★ | 3.25★ | 4.65★ |

- **Who with (outside China):** friends 169, groups or teams 35, partners 26, family 9, kids 6.
- **Don't want it:** 11 asked to hide the tab.
- **Year by year, outside China:** 15 (2019), 13, 30, 45, **80 (2023)**, 50, 34, 19 (2026).

**Why it broke.** The app built sharing on iCloud. The same failures repeat for years: "failed to modify some
records", invites stuck on "pending", and shared habits vanishing after the app closes. It is the only reason some
people downloaded or paid. When it fails, it causes 1–2★ reviews.

**What people want from it**, as reviewers say it:

1. **See each other's progress, and nudge.** People compete, or "poke" someone who hasn't done their habit.
   "Fun way to hold each other accountable… a bit of a competition" (9492923925); "I like the poke button to
   pressure my friends" (11011118031).
2. **Not necessarily the same habit.** "Most of the time two people want to build different habits, but we want to
   supervise each other" (7603611585, translated). Another asks to share "overall habit adherence… and be able to nudge people
   … without needing to perform the exact same habit" (9840610091), or to "only complete the habits that are ours
   while still reminding the other person" (8232038072).
3. **One shared chore either person can tick off.** Watering plants, housework (11758778851, 10064514519,
   13859377788).
4. **A group view beyond today.** "I can only see my group members status for today… Wish I could get an overview of
   the week" (13066280752); a family challenge where "I don't see a way to easily see who completed what habits on
   past days" (12136625495).
5. **Works across phones, and is easy to join.** QR codes and links fail; one reviewer asks for usernames
   (11023900018); 13 are blocked by friends on Android (7161054209, 10886615294, 14219162418).
6. **Light, not a social network.** People praise "light social" and reject "unnecessary social forum
   features" (9336120630, 3993298385, translated).

**Verdict for app 1.** Doing habits together is the one thing outside the giveaway list with real evidence. The demand
is real but small: about 2–3% of reviews outside China, and about 20 people who paid specifically for it. It brings
people to an app, and badly built it is a main source of 1★. It needs a server and some way to identify people,
which conflicts with D16 (no server, no accounts), so whether to reopen that is the user's call. If it's ever built,
it belongs in the **subscription**, because its cost recurs. Its useful core is small:

- link with a person, on any phone;
- see each other's day and nudge;
- optionally, one shared habit either person can complete;
- no feed.

Keep it as a candidate and check it against the next apps.

---

## App 2 — Daily Habits

App Store, all 517 reviews read one by one. Labels: `Evidence/2-codes.py`; recount with `Evidence/2-tally.py`.
Report: [`App Store Reports/02…`](<../../../App Store Reports/02. Daily Habits - Habit Tracker - Habit List and Routine Tracker (REPORT).md>).

**Why it matters here: it's the app closest to our plan.**
- **Free:** unlimited habits, reminders, widgets, the Watch app and a free Groups feature.
- **Pro:** a one-time purchase of about $3.99 that adds sync between devices, sending upcoming habits to Apple's
  Calendar, extended statistics, a passcode lock and no ads.
- **Status:** no update since May 2021.

### Who paid and why

**44 say they paid** (3.16★, pulled down by Pro features that broke). 8 more intend to, and 4 got Pro free in the
launch promotion. 26 of the 44 say why.

| What made them pay | Payers | Reviews |
|---|---|---|
| **Price and goodwill:** cheap 11, worth it 6, one-time 5, support 1, used it long 1 | **16** | "it's cheap and it has one time fee. I bought it because of that" (9923794823); "used it half a year, recently bought… the best price for the quality" (5263275131, translated) |
| **Already owns the developer's other apps,** or wants them to work together (Be Focused, Focus Matrix) | 5 | 7232398007, 8106352419, 8731669029, 13788341591, 2109039905 |
| Sending habits to Apple's Calendar | 2 | 1663634672, 5403701988; both say it broke |
| Apple Watch | 2 | 1816542296, 4402829597; both say it broke |
| No ads | 1 | 5727003954 ("a cheap upgrade of 1€ you can remove ads and sync") |
| Widgets, sync (on the giveaway list) | 1 each | — |

One more is telling: "paying only removes the ads, I didn't feel much benefit" (4025884406, translated).

### What this app adds to the picture

- **Nothing new to build.**
  - Owning the developer's other apps doesn't apply to us, since we're one app.
  - Calendar sync and the Watch are two reviews each, and both are out of scope.
  - We have no ads to remove.
- **With nothing basic locked, people pay for the price and the goodwill.** Unlimited habits free is this app's most
  loved theme (30 reviews, 4.97★ in its report). The payers who give a reason talk about a cheap, one-time price.
- **The cost is a low payment rate and low payer ratings.** About 1 in 12 reviewers say they paid. Payers rate it
  lower than the app overall, because what Pro promised (sync, calendar, Watch) broke.
- **Doing habits together:** the free Groups feature appears in only 6 reviews (5 like it, 1 broken, 2380499734: "we
  each have to create our own habits instead of sharing"). Nobody paid for it, since it was free.

---

## App 3 — Days Since

App Store. It has 10,621 reviews. Every review with a word about paying, pricing, buying or donating was read in full, 951 in all.
Labels: `Evidence/3-codes.py`; recount with `Evidence/3-tally.py`.
Report: [`App Store Reports/03…`](<../../../App Store Reports/03. Days Since - Quit Habit Tracker - Sober Streak Day Counter (REPORT).md>).

**Why it matters here.** It's a "days since" counter, mostly for quitting things, and its history is unusual:
- **Free until late 2022:** fully free, no purchases.
- **Then Premium, later the "Count Up Club":** about $6 a month, $18 a year or $50 lifetime. Locked:
  - goals;
  - reminders;
  - colours and app icons;
  - backup and iCloud;
  - Siri Shortcuts;
  - the Watch;
  - **from July 2025, widgets**, which had been free.

It shows both before and after.

### Who paid and why

**82 say they paid** (3.87★). 47 more say they would, and 9 asked for a way to donate. 50 of the 82 say why.

| What made them pay | Payers | Reviews |
|---|---|---|
| **Price and goodwill:** worth it 17, cheap 7, support the developer 4, used it long 4, a discount 3, one-time 3, money it saved them 1 | **31** | "I was hesitant at first to pay for a counter app but… I keep coming back… Supporting developers that create high quality apps is a must" (9948694045); "they've saved me way more than that for the year" (9466347369) |
| **The giveaway list:** widgets 14, backup 1 | 15 | "pay for the pro version in order to be able to customize my widget" (12936970266) |
| Reminders | 5 | "the reminders are a great feature" after an overdose (12308505754). Two of the five complain about them. One cancelled because they couldn't repeat every 14 days (10142749961), and one says the paid reminders make no sound (10246644188). |
| Colours | 4 | "I can customize the colors of my counter" (11787136840); "the base colors were way too bright for me… It's not necessary" (13602265269) |
| Goals (a target number of days) | 2 | "The goals are 100% worth upgrading for" (13144761902); 14392573700 |
| Apple Watch | 2 | 10507899228 (out of scope, D16) |
| Didn't choose to: forgot to cancel the trial | 2 | 11618250403, 12144029927 |
| One each | | bought at once; kept it after the trial; "an honest developer" (9489905182); shared through Family Sharing (13571741107); **expected a community and found none** (13955344492); paid only because years of data were in it, under protest at the widget lock (12870203346) |
| Paid, never says why | 32 | |

**Would pay (47)** mostly name price:
- cheap 9;
- to support the developer 7;
- if one-time 5;
- worth it 3.

Then reminders 3, a check-in streak 2, and one each for iPad, Watch, sync, backup, Shortcuts and seeing all counters at once.
**The 9 who wanted to donate** wrote in 2021–2022, while the app was free, except one in 2025.

### What this app adds to the picture

- **Nothing new to build.** Outside price, goodwill and the giveaway list, there are only three features:
  - reminders (5);
  - colours (4);
  - goals (2).

  We give reminders and colours free. A habit's goal and its milestones are already part of every habit. Each is a
  handful of reviews, and two of the five reminder payers are complaints. The rest:
  - **A community:** one person paid expecting one.
  - **A check-in streak:** two would pay for one, which is simply what a habit tracker does.
  - **Money saved by quitting:** asked for in about 12 reviews (word search), with no payer.
- **Taking a free feature away cost more than it earned.**
  - **Before:** in the year before the widget lock, 47 of 2,288 reviews were 1★ or 2★ (2.1%).
  - **After:** from July 2025, 167 of 2,404 were (6.9%), and 90 of those mention widgets (word search over all
    reviews).
  - **Paid under protest:** "I'll pay the $18/year because I'm used to this… but I'm leaving a 1 star review"
    (12870203346).

  This is the strongest evidence so far for our rule: **give the basics away from the start, and never take one back.**
- **The goodwill was there before there was anything to buy.** The donate requests came while it was free: "Have you
  thought about making a donate button?" (6826653115). Once there was something to buy, it became the largest named
  reason to pay, as in apps 1, 2 and 7.

---

## A closer look: Calendar sync

Asked by the user on 20 Nov 2026 after app 2: "What about this? Sending habits to Apple Calendar?"

Every habit-app review in our data that mentions calendar sync or integration was found with an English word search
(pure to-do and school-planner apps were left out) and read by hand: 830 candidates. **310 are about connecting a
habit app to a calendar.** Another 124 only say "I can do this in my calendar app for free". Labels:
`Evidence/cal-codes.py`; recount with `Evidence/cal-tally.py`.

| | Reviews |
|---|---|
| **Ask for it** | **261** (3.96★; 199 on Play, 111 on the App Store among all 310): mostly HabitNow (80) and Habitica (32), then Productive, Habitify, Routine Planner, Me+, RoutineFlow |
| Use it and like it | 21 |
| **Say it's broken or made a mess** | 16, plus about 11 in app 2's own reviews |
| Don't want habits in their calendar | 12 ("I downloaded the separate tracker because I want my calendar just for work", b74a0821…) |
| Say they **paid because of it** | **3** (Habitify c4a4c703…, refunded within an hour; app 2's 1663634672 and 5403701988), and 2 of the 3 say it broke |
| Say they would pay if it existed | 11 ("I would happily pay for this app if I could sync it with my Google calendar", 420ddc3b…) |
| Left, or won't use the app, without it | 11 |

- **Which calendar:** Google 171, Apple 29, Outlook 6.
- **Which way:**
  - Most don't say (165).
  - 52 want their **calendar events shown in the app**, to plan habits around appointments: "read my calendar
    events and add them to the days as tasks I can check off" (3a1643d0…).
  - 44 want **habits written into their calendar**, often for time-blocking.
- **Writing into someone's calendar is where it breaks:**
  - duplicates every day (Habitify b7bed9d5…, 12668301832);
  - "about 20 copies of each item" (1508808010);
  - "App has ruined my phone calendar by adding blank events" (1650678342);
  - every habit scheduled as an hour-long event (4494723296).

  Feature Ledger C072 already says writes to a shared system store must be exact and reversible.

**Verdict.** This is a real, steady **request**, mostly from people who plan their whole day (habits plus tasks,
especially on Android). It is not a reason people pay: 3 people out of 310 said they paid for it, and 11 said they
would. If it's ever built:

- **Start read-only:** show today's calendar events on Today. It needs no server, so it could be a one-time Plus extra.
- **Leave writing into calendars out,** unless it can be exact and reversible.

**How firm this is:** the word search was English (it also caught "Google Calendar" written inside other
languages), so other languages are undercounted.

---

## App 7 — HabitKit

All 2,993 reviews read one by one: App Store 882, Google Play 2,111. Labels: `Evidence/7-codes.py`.

### Who paid and why

297 say they paid (Play 186, App Store 111; 4.38★). Another 73 want to but hadn't: students, and people in Russia
and Iran who can't pay. 195 of the 297 say why.

| What made them pay | Payers |
|---|---|
| **Goodwill:** worth it 45, cheap 33, support the indie developer 29, one-time price 22, design 22, used it for years 10 | **134** |
| **Hit a lock:** widgets 29, more than 4 habits 26, stats 5 | 58 |
| **Bought at once,** at first sight or at the offer | 20 |
| Other, one each: automations, reminders, symptom tracking, calendar view, moving data from an old app; privacy 2 | — |

- **What the lock costs:** among non-payers, a word search finds 176 complaints about the 4-habit cap (106 at
  1–3★) and 65 about paid widgets (35 at 1–3★).
- **Who pays more often:** 12.6% of App Store reviewers say they paid, against 8.8% on Play.
- **By country:**
  - On the App Store, the US has 20 of the 51 goodwill payers. Germany, the UK and Canada have 4–6 each, and the
    rest are spread thin.
  - Payment rates differ more than reasons do. The US is about 1 in 5 reviewers, Germany, the UK and Canada about
    1 in 9.
  - On Play (language only, no country), English accounts for 57 of the 83 goodwill payers.
  - By language on Play: German reviewers pay most often (13%), English 9%, Spanish 5%. Russian reviewers often
    can't pay at all.

**Verdict for HabitKit.** Nothing new. Everything people pay for is on the giveaway list or is goodwill.

### How people find it, and how a late app ranked

Only 279 reviews say how they found the app:

| How they found it | Reviews |
|---|---|
| Already shopping: "was looking for a habit tracker", "tried many" | **204** |
| Developers who like the GitHub-style grid | 48 |
| YouTube: MKBHD 4, The Studio 3, Starter Story 2, other 4 | 13 |
| Followed the founder building in public | 9 |
| Switched from another app | 10 |
| Threads, friends, the developer's other apps, Product Hunt, browsing the store, a podcast, a book | 15 |

The founder says about 98% of new users find his apps in the stores. His posts are blocked from this container, so
these are search summaries:
- He reached #7 for "habit tracker" in the US in January 2025, the top 5 during 2025, and #2 in early 2026, then lost
  #2 to Finch later in 2026.
- He has 2,400 ratings against a rival with 749,000, and still ranks above it.
- He credits a big YouTube video in December 2024 for the US jump.

Apple's own page, read directly, says search uses **text relevance** (title, subtitle, keywords, category) and
**user behaviour** (downloads, ratings and reviews). Age is not on the list. So a late app can climb if:

- its title starts with the phrase;
- searchers pick it over the apps beside it (HabitKit's grid is unlike anything near it; 43 reviews name it);
- its ratings stay high;
- bursts of outside downloads land at the right time (just before the January rush);
- it wins smaller countries first.

At least five other apps also start their name with "Habit Tracker", so the title only gets an app into the race.
The climb took about three years.

---

## A tip jar instead of Plus?

The user asked whether a fully free app with a well-timed tip or pay-what-you-want banner could earn enough.

| Evidence | People who pay | Average |
|---|---|---|
| In-app tip prompt (KudosKits, 2013, 700k users, the vendor's own claim) | 0.58% | $2.10 |
| One indie developer's tip jar, 20k downloads | 3 tips in a month | — |
| Pay-what-you-want (Gneezy et al., *Science* 2010) | 8.4% (vs 0.5% fixed price) | $0.92 |
| Freemium apps, median (RevenueCat 2025, via secondary sources) | 2.2% | ~$24 first-year value per payer |
| Hard paywall, median (same) | 12.1% | ~$49 |

**A case from our own data: Tasks – To Do List & Reminders** (Play #84, 58,553 reviews; 278 mention donating).
- **Early on:** a donation app that reviewers loved.
- **By 2020–21:** backup and restore, and more, had moved behind a subscription, and reviewers were angry: "a
  donation used to be enough". The developer's reasons aren't in the reviews.
- **Perks for ratings:** it also tied perks to donating or rating 5★, which breaks the store rules.

In HabitKit, 73 people say they will pay and none had. Goodwill turns into money when there's something fair to buy.

**Rough maths per 100,000 downloads:**
- tip jar: about $3,000, once;
- one-time Plus at about $20, bought by 2%: about $40,000.

These are illustrative assumptions, not forecasts. **Recommendation:** keep everything a habit tracker needs free,
keep a fair one-time Plus, and use the "right moment" banner to offer Plus rather than a tip.

Sources:
[RevenueCat 2025](https://revenuecat.com/state-of-subscription-apps-2025) ·
[Airbridge](https://www.airbridge.io/en/blog/hard-paywall-vs-freemium-2026) ·
[KudosKits](https://techcrunch.com/2013/11/29/ironsource-announces-kudoskits/) ·
[indie tip jar](https://medium.com/@1qazster/can-indie-developers-still-make-money-i-tested-it-with-my-own-app-3340251320dd) ·
[Freakonomics on Gneezy](https://freakonomics.com/2013/10/not-so-dismal-after-all/) ·
[Apple: App Store search](https://developer.apple.com/app-store/search/) ·
[Röhl on X, #7](https://x.com/SebastianRoehl/status/1875093561999593860) ·
[Röhl on X, 2.4k vs 749k](https://x.com/SebastianRoehl/status/2097298459032506494) ·
[Röhl, 2025 review](https://sebastianroehl.substack.com/p/2025-the-year-that-changed-everything) ·
[Launched #84](https://launchedfm.com/episode/84-habitkit-sebastian-rohl) ·
[Starter Story](https://www.starterstory.com/habit-kit-breakdown).
The web sources were read only as search summaries, except Apple's page.
