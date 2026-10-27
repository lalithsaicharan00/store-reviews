# What Goes in Plus — Our App Against HabitNow, and the iPhone Equivalent

*Written by Claude (Claude Code), 27 October 2026, at the user's request: "what are the things that we already have in our app and that we can make safely as a premium thing … cross check with HabitNow … then tell me who is our closest competitor in iOS." No new features: every item below already exists in the Android designs.*

## The answer

**Plus today** (Figma, Android app, `1167:350816`) offers three things: unlimited habits, more widgets, and supporting the developer. HabitNow's Premium offers about eight. We already build most of what HabitNow charges for, and we give it all away.

**Add three existing features to Plus:**

| # | Move into Plus | What stays free | Backlash risk | Why |
|---|---|---|---|---|
| 1 | **The year at a glance:** the Habits page's **Month** and **Year** views, and **Year in Pixels** on Habit details | Week on the Habits page. Each habit's Progress, Streaks, Milestones and Month. **History of every log, any date. Day details for any day. Export** | **Low** | The overview across all habits is what HabitNow's payers ask for most and say they'd pay for. Its free plan keeps per-habit stats and charges for overall progress. People object when their own past records are cut off, never when a summary view is paid. |
| 2 | **Checklist habits** (the Steps type): making a new one | Every checklist habit already made keeps working forever: ticking, history, widgets, restore | **Medium** | HabitNow's second biggest seller after the habit limit. Some people do push back, and that's the cost. |
| 3 | **"If not done, remind me again"** (the follow-up reminder) | The first reminder, several reminders per habit, alarm or notification | **Low** | HabitNow doesn't have it, and a HabitNow payer asks for it. Nobody switching from HabitNow loses anything they had for free. |

**Keep as they are:** unlimited habits (free has 5), the Today list and This week widgets (A13), and support the developer.

**Never in Plus:**

- **Dark mode.** HabitNow tried it and took it back after a run of 1★ and 3★ reviews.
- **Backup, Google Drive, export and restore.** These are Rulebook D10 and A46. Backup is also the most resented paywall on Android.
- **Ticking a habit from a widget.**
- **Several reminders per habit.** HabitNow gives these free, and reviewers praise it for that.
- **Tasks** (one-time and repeating).
- **The routine player and the timer.**
- **Quit and cut-down habits.**
- **Skip, pause, notes, streaks and milestones.**

Part 1 compares the two apps feature by feature and gives the evidence for each choice. Part 2 answers the iPhone question. In short, the closest equivalent to HabitNow on the iPhone is **Habit Tracker by Inner Grow** (App Store id 1438388363). It has 535,378 ratings, a one-time Lifetime price of about $10 with a cap of 5–6 free habits, and its paid tier is reports, more habits and extra reminders. For a smaller app that mixes habits and to-dos the way HabitNow does, look at **Tappsk**.

---

## How this was checked

- **HabitNow's own reviews.** The source is 29,021 Google Play reviews (`Play Store Reviews/2. HabitNow Daily Routine Planner/`), 12,263 of them in English.
  - A machine screen found 2,117 English reviews that use a payment word. They were then matched to a feature word (§1.2).
  - The reviews behind each choice were read by hand. The developer's replies say exactly what is free and what is Premium, so the free/Premium list in §1.1 comes from those replies, not from guesses.
- **Every other habit app.** A second screen covered all 254,915 App Store reviews and 797,682 Google Play reviews that contain text. It looked for a sentence with a payment word next to: checklist, history or year view, colours and icons, several reminders, or a routine player. A sample from each was read by hand (§1.3).
- **Earlier reports**, used as given:
  - [Android Plus — What Android People Pay For](<../../../Android/Docs/Research/Android Plus — What Android People Pay For….md>);
  - [Plus Scope and Account at Purchase](<Plus Scope and Account at Purchase.md>);
  - [Free Habit Limit](<Free Habit Limit — 5, 6, 7 or More.md>);
  - [Tasks in the Free Plan](<Tasks in the Free Plan — Limit, Count or Plus.md>);
  - the [Feature Ledger](<../Feature Ledger.md>) cards C001, C007, C008, C009, C011, C014 and C020;
  - App Store reports 1 (Inner Grow), 7 (HabitKit) and 59 (Tappsk).
- **How to look a review up.** A reference such as `P2#3904` means Play Store app 2, line 3904 of `reviews.jsonl`, counted from 0 and split on newlines only (Python's `splitlines()` also splits on rare Unicode line breaks and gives different numbers). `A13#5201` works the same way for the App Store. A script checked that every reference in this report exists and says what is claimed (`Temp/plus-scope-cite-check.txt`).
- **Labels.** "Users show" means review evidence. "Reasoned" means first principles, used where reviews are thin.

---

## Part 1 — Plus, feature by feature

### 1.1 What HabitNow gives free and what it charges for

HabitNow is Android only. It has 5M+ installs and 4.7★ from about 93,000 ratings. Premium is a one-time purchase of "around $6 USD, depending on the country" (developer, `P2#1795`).

| | HabitNow free | HabitNow Premium | **Our app, free** | **Our Plus today** |
|---|---|---|---|---|
| **Habits** | 7, **counting repeating tasks** (`P2#2537`, `P2#227`) | Unlimited | 5 habits; tasks don't count | Unlimited |
| **One-time and repeating tasks** | One-time unlimited; repeating count toward the 7 | Unlimited | Unlimited, both kinds | — |
| **Checklists inside a habit** | No (`P2#5664`, `P2#23611`) | **Yes** | Yes (Steps type) | — |
| **Timer** | Basic timer | **Intervals and Pomodoro presets** (`P2#1558`) | Timer and routine player | — |
| **Reminders** | Several per habit, alarm or notification (`P2#4112`, `P2#5325`) | Same | Several per habit, alarm or notification, **plus "remind me again if not done"** | — |
| **Statistics** | Per-habit stats (`P2#25427`) | **Overall progress graphs and "Weaknesses"** (`P2#1237`) | Per-habit Progress, Streaks, Milestones, Month, Year in Pixels; Habits page Week, Month, Year | — |
| **Widgets** | A light list to view and a 1×1 quick add; **can't tick** (`P2#305`, `P2#2464`) | Light and dark widgets, opacity, different lists, ticking (`P2#24427`) | One-habit widgets (tick), Tasks widgets, glance widgets (A13) | Today list and This week |
| **Backup** | A local backup file (`P2#375`, `P2#3547`) | **Cloud backup with sign-in, sync between devices** (`P2#2681`, `P2#22413`) | Google Drive backup, backup file, restore | — |
| **Export** | — | **CSV export** (`P2#2566`) | Backup file and CSV | — |
| **Categories, colours, icons** | 5 custom categories (`P2#9998`) | More categories, editing the defaults, more colours and icons | Every colour and icon; times of day | — |
| **Dark mode** | Free (it was Premium until reviews pushed back: `P2#11080`, `P2#11436`) | — | Free | — |
| **Ads** | None; a Premium banner that can be turned off (`P2#2919`) | — | None | — |

**What this shows (users show):** HabitNow's paid tier is a pile of small conveniences, and its buyers say they pay for that pile and a low one-time price, not for any single feature. In the earlier Android research, HabitNow's buyers gave these reasons:

| Reason for buying | Share of buyers |
|---|---|
| Look and simplicity | 16% |
| Cheap or fair price | 13% |
| Lifetime price | 11% |
| Widgets | 7% |
| Supporting the developer | 6% |
| Hitting the habit limit | 5% |

Our Plus screen names only two of those conveniences, so it reads as thin even though the app itself does more.

### 1.2 How HabitNow's reviewers react to each paid feature

This is a machine screen of English HabitNow reviews that have both a payment word and the feature word. It is not hand-coded, and it only shows how much each feature is talked about. The hand-read reaction is in the third column.

| Feature | Reviews | Mean ★ | Read by hand (users show) |
|---|---:|---:|---|
| Habit limit | 177 | 3.60 | The most resented gate, as in every corpus |
| Widgets | 145 | 3.99 | Sells well, but has the most objections of any feature. The objections are about **not being able to tick from the widget**, or the dark widget being paid. Customising a widget is accepted. |
| Backup and sync | 88 | 4.16 | Some people pay for cloud backup. Others object strongly. Payers want sync between devices. |
| Theme and colours | 114 | 4.35 | Paying for dark mode itself was rejected. Extra colours, icons and an "ultra dark" option are paid for and accepted. |
| Statistics | 98 | 4.51 | Per-habit stats are free and praised. People ask for overall stats and say they'd pay for them. No objection to them being paid. |
| Categories | 76 | 4.58 | More categories are paid. No objection. |
| Timer | 56 | 4.41 | Intervals are paid. Almost no objection. |
| Checklist | 51 | 4.22 | Paid for and praised, with a smaller group objecting |
| Export | 13 | 4.31 | Accepted as paid |

### 1.3 Each candidate, with its evidence

#### Recommended for Plus

**1. The year at a glance: Habits page Month and Year, and Year in Pixels**

*HabitNow's reviewers want an overview of all their habits, and say they'd pay for it (users show):*

- "The moment i get stats, im buying premium" (`P2#11760`).
- "one thing which is stopping me from getting pro is I cannot see the 2d graph of my habits" (`P2#6158`).
- "Even if it's in premium only, I'd pay for that" (`P2#4402`).
- "missing a big feature … overall statistics" (`P2#5989`).
- "graphs to show all habits in a single view" (`P2#6940`, 2★).

HabitNow already charges for "overall progress … in graphs and your Weaknesses" (`P2#1237`).

*In other apps (users show):*

- **People pay for year and heat-map views:**
  - "yearly view is my favorite feature" (`P69#54`, a premium user);
  - "Heatmap and Widget was the cherry on top for premium purchase" (`P123#754`);
  - one bought "the larger widget showing the entire heat map" (`A62#15`).
- **Inner Grow:** the weekly, monthly and yearly report is **the first reason its buyers give for paying** (App Store report 1, §1.3).
- **The objections that exist are about something else:**
  - having one's own records cut off: "Task completion history is paywalled" (`P7#209`, 2★); "Gotta pay to see more of my history. Lame" (`P122#5817`);
  - records held hostage: "I can't get any of my history out without paying this ransom" (`A48#4033`);
  - a view that was free being taken away: "Calendar is paid now … that one was free already" (`A13#5201`).
- **Ledger card C011 says the same:** keep the basic progress view free and sell the deep report. When one app charged for *all* its statistics, its reviews averaged 1.40★.

*So the line is:*

| Stays free | Moves to Plus |
|---|---|
| The Week view of every habit | The Habits page's Month and Year overviews of every habit together |
| Each habit's own page | Year in Pixels |
| History of every log for any date | |
| Day details for any date | |
| Backup and CSV export | |

Nobody's records are ever out of reach. Rule D10's intent holds: Plus buys a way of looking at your data, never the data itself. Because we're launching with this split, it never "moves a free feature behind the paywall" (C001).

*Risk: low.* Two notes:

- The Year view is where a long-time person feels progress, so its locked state must show what it would look like, not a blank page (reasoned).
- Year in Pixels is decided design (A61). Gating it adds a locked state to Habit details, the Habits page and their flows.

**2. Checklist habits: making a new one**

*HabitNow (users show).* Of the reviews that name the checklist next to a payment word:

- **Several paid for it:**
  - "a personal favorite is the checklist feature … (paid feature). Most definitely worth getting the paid version" (`P2#3904`);
  - `P2#6513`, `P2#6852`;
  - "lifetime $5 … access to checklists" (`P2#7162`);
  - `P2#7241`.
- **A smaller group refused:**
  - "idiotic im not paying money to have a checklist" (`P2#2471`, 1★);
  - "I downloaded it for the checklist … had to get premium" (`P2#6607`, 2★);
  - `P2#7885`, `P2#8694`, `P2#9494`.
- **The developer softened it** by pointing free users to "filter lists".

*Other apps (users show):*

- **Objections:**
  - "can't use most of the features, including a checklist within the habit without paying" (`A33#3159`, Habitify, 1★);
  - "please don't make premium option 🙏" (`P98#362`);
  - "No subtasks option unless it is a subscription … Deleting" (`P117#124`).
- **Counterweights:**
  - a premium user who loves sub-tasks (`P84#14374`);
  - an app praised for "unlimited steps and checklists" free (`A5#41`).

*The rule that makes it fair (D10, reasoned).* Plus gates only **making a new checklist habit**. A checklist habit that already exists always works, with or without Plus: ticking steps, Day details, widgets, history and export. That includes one restored from a backup on a phone without Plus, the same way A30 treats a restore.

*Risk: medium.* This is the one item on the list that some people will complain about. It's worth it because it's the clearest "more power" feature we have, and it's HabitNow's proof that people pay for it. Leave it out if the aim is zero complaints.

**3. "If not done, remind me again"**

*HabitNow doesn't have it (users show).* A HabitNow payer asks: "I want perpetual reminders … if I don't do it by that time, I get a new notification every 1 hour or so until I mark it as done" (`P2#2708`).

*Elsewhere it is valued:*

- "I love the nagging reminders. Helps me manage my ADHD" (`A5#3171`);
- ledger C014 notes a paying user's medication use for a repeating reminder.

*Why it's safe (reasoned).* It's an extra on top of a reminder, not the reminder itself. Ledger C008 says the reminder must be free, and it stays free. Someone coming from HabitNow never had it, so nothing feels taken away.

*Risk: low.* Its pull is small. It's a good line on the Plus screen rather than a reason to buy on its own.

#### Considered and not recommended

**Several reminders per habit (the user's example).**

*Evidence on both sides (users show):*

- **Against charging:** HabitNow gives them free and is praised for exactly that: "the only one that allows multiple notifications in its free version" (`P2#11278`).
- **For charging:** other apps charge, and some people accept it: "I understand that as a 'feature'" (`A31#1968`); HabitKit's buyers name them (`P9#334`); Inner Grow charges ("moderate", report 1 §1.2).
- **Others push back:** "There's not a lot you can do … with only one reminder" (`P35#222`).

*Why not (reasoned):* on Android, where HabitNow is the comparison, paid multiple reminders would be the one place we're visibly worse than it for free. "Remind me again" gets most of the value without that comparison.

**More colours and icons.**

*Evidence (users show):*

- **Accepted as paid:** HabitNow (`P2#9099`, `P2#8536`) and other apps: "free version has all the features too except analytics and access to more colors" (`P19#471`); a buyer asking for even more colours (`A53#537`).
- **Rejected when the free set is small:** "only three colours" (`P105#199`, `A54#153`); "I can't even pick a color besides basic 3 (which was possible before)" (`A20#1809`, 1★).

*Why not:* it's a small seller (themes: 5% of feature-linked paying on Play). Our palette was designed as one set with equal-weight fills, and splitting it would mean redesigning it.

**Dark mode.** Never.

- HabitNow charged for it and drew "Dark mode behind a pay wall? No thank you. Uninstalled" (`P2#11948`), "Don't make people pay for dark mode" (`P2#12229`, 1★), and `P2#11655`.
- Then it made it free (`P2#11080`, `P2#11436`).
- What people do accept paying for is the *extra*: "ultra dark" (`P2#6828`, `P2#8536`).

**Backup, Google Drive, export, restore.** Never (D10, A46).

- HabitNow charges for cloud backup and draws "need premium to just sync. what a joke" (`P2#3036`), as well as `P2#7056` and `P2#9182`.
- It's the most resented gate in the Android research (22 of 60 matches object).
- CSV export is accepted as paid in HabitNow (`P2#4402`, `P2#1712`), but our rule keeps it free. That's a decided product rule, not a gap.

**Ticking from a widget.** Never.

- HabitNow's widget objections are mostly about this: "use the widget to mark items done without getting premium" (`P2#7885`); "updating your tasks in the widget are locked" (`P2#2217`); `P2#975`, `P2#1348`, `P2#2013`.
- Our free one-habit widgets tick, which already beats HabitNow. Keep the Today list and This week widgets in Plus (A13): they sell (`P2#3286`, `P2#4248`, `P2#5970`, `P2#6828`).
- The remaining risk is someone with five habits who wants one list widget. Say plainly on the widget picker that the one-habit widgets are free.

**The routine player.** Keep free.

- Charging to start a routine draws "You have to pay just to start a routine" (`A4#19141`, 1★).
- One Fabulous user did upgrade for its routine timer (`P12#45001`), but that's one review.
- Reasoned: the player is how someone does their morning, which is the daily loop, and C008's logic applies to it.

**Quit and cut-down habits.** Keep free.

- Inner Grow charges for its quit mode and it's "well received" (report 1).
- Reasoned: someone quitting smoking or drinking meets the paywall at the moment of trying. Quit-tracker reviewers are the harshest about paywalls (App Store report 3: the widget paywall alone moved its 1–2★ rate from 1.75% to 8.64%).

**Tasks.** Keep free and unlimited, as decided (Tasks in the Free Plan). HabitNow counts repeating tasks inside its 7; we don't, which is part of why 5 habits is fair next to HabitNow's 7.

### 1.4 The Plus screen, rewritten

Same layout as `1167:350816` ("With Plus", one row per item, the price line, Get Plus). The opening line ("You're using all 5 free habits…") changes with the screen's entry point.

**With Plus**

1. **Unlimited habits** — Free has 5. Add as many as you like.
2. **Your year at a glance** — See every habit by month and year, and each habit's Year in Pixels.
3. **Checklist habits** — Break a habit into steps and tick them off.
4. **Remind me again** — If a habit isn't done, get another nudge later.
5. **Today's list and This week widgets** — Your whole day on your home screen.
6. **Support me as a developer** — Help keep Often Enough going.

**Always free:** backup to Google Drive, export, dark mode, reminders, tasks, and every habit you've made.

*Why the "Always free" line (users show):* HabitNow's vague "includes widgets" drew a 3★ "It doesn't say which or how many" (`P2#2464`). Report 3's lesson was that a paywall change nobody explained is the one people don't forgive (R03-122). Saying up front what will never be charged for turns that into trust.

### 1.4a Follow-up, 27 Oct: checklists in habits or in tasks, and do our routines replace them?

**Where HabitNow's checklists are used.** HabitNow puts a checklist in both habits and tasks, and both are Premium (`P2#6693`, `P2#24738`). We read all 223 HabitNow reviews that mention checklists or sub-items, by hand. In the 73 where the context is clear (`Temp/hn-checklist-context.py`):

| Where the checklist is | Reviews | Name paying for it |
|---|---:|---:|
| **A habit** | 38 | 12 |
| A task | 17 | 6 |
| Both | 1 | 1 |
| Objections (any kind) | 8 | — |

So it's **mostly habits, about two to one** (users show). Examples:
- "Checklist for habits is a game changer for me and the main reason why i am using this app" (`P2#8450`);
- "the checklist feature for routines/habits (paid feature)" (`P2#3904`).

Our tasks have no steps at all, so the task side of HabitNow's demand has nothing to match in our app.

**What people use checklist habits for.** Ten of these reviews use a checklist habit **as a routine**, because HabitNow has no routine feature:
- "The premium version has habits with a checklist, which I use for routines/chained habits" (`P2#7375`);
- "I know that checklists are a thing and they kinda work, but I include meditation in my morning routine and would like to have this as a separate habit" (`P2#9076`);
- `P2#364`, `P2#2461`, `P2#3436`, `P2#3904`, `P2#5491`, `P2#8505`, `P2#12495`, `P2#24631`.

Eight more want a timer on each step (`P2#980`, `P2#1695`, `P2#2657`, `P2#3882`, `P2#5153`, `P2#8505`, `P2#15790`, `P2#21542`). That's what our routine player does, and it's free. So **for us, checklist habits will sell less than they do in HabitNow** (reasoned). The biggest use, a morning routine, is already covered free by a routine of separate habits.

**What's left for a checklist habit:** one habit made of parts that keeps one streak. Examples:
- a yoga habit with its stretches (`P2#3022`);
- exercise with its sets (`P2#5153`);
- "select how many need to be done to count as a success" (`P2#5713`);
- house chores (`P2#565`).

**Why it still belongs in Plus (reasoned).** A free checklist habit would be a way round the 5-habit limit: ten things packed into one habit use one slot. HabitNow's free users mix the two up already ("add more checklist (6) without upgrading" `P2#2943`; "only 7 items to checklist for free" `P2#7660`). With checklists in Plus:
- a free person who wants a morning routine builds it from separate habits and plays it free;
- someone with more than five things reaches the limit, where Plus is offered anyway;
- someone who wants one habit with parts has a clear reason to buy.

The Plus screen's row should say plainly that it's about habits: "Checklist habits — one habit, several steps".

### 1.5 One thing this doesn't settle: the price

Plus is $29.99. The comparable one-time prices are:

| App | One-time price | Source |
|---|---|---|
| HabitNow | About $6 | `P2#1795` |
| Inner Grow | About $10 (Lifetime) | Report 1 §1.1 |
| HabitKit | $30 / €35 (Lifetime) | Report 7 |

HabitKit's is the only lifetime price in these reports that draws its own complaints. Every "too expensive" review after October 2024 is about the lifetime number. One reviewer wrote that €35 was too much and they "found a great habit tracker app for 6.99€ (lifetime)" (report 7 §1.4, `11942193233`). Adding the three items above makes $29.99 easier to justify. It doesn't make it HabitNow's price. That's the user's call; the evidence is here so it's made knowingly.

---

## Part 2 — The iPhone's HabitNow

**What we looked for:** an app that is generic and feature-based (not themed, not a pet, not coaching content), very widely used, with a free plan that has a habit limit and a cheap one-time unlock. Those are the four things that define HabitNow.

The sources are our [Habit App Inventory](<../Market Discovery/Habit App Inventory — 13 October 2026.md>) (ratings counted across 174 storefronts on 13 Oct 2026, with download estimates where a provider gave them) and the 21 Oct [revenue estimates](<../Market Discovery/Habit Apps — Revenue Estimates and Provisional Store Top Tens — 21 October 2026.md>). All download and revenue figures are provider estimates for one recent month, not verified sales.

### 2.1 The closest match: Habit Tracker by Inner Grow (App Store id 1438388363)

| | HabitNow (Android) | Habit Tracker, Inner Grow (iPhone) |
|---|---|---|
| **What it is** | A generic habit and task tracker | A generic habit tracker (check, count, timer, quit mode, goals) |
| **Size** | 5M+ installs; ~93,000 ratings | **535,378 ratings** worldwide, the 4th most-rated habit app in our inventory; ~200,000 downloads last month (provider estimate) |
| **Revenue** | ~$12K a month (our scenario) | ~$100K a month, joint 2nd in our provisional App Store top ten (low confidence) |
| **Price** | One-time, ~$6 | **One-time Lifetime, ~$10 in the US**; yearly and monthly subscriptions alongside it |
| **Free plan** | 7 habits and repeating tasks | **5–6 habits** (it has drifted: 3, 4, 5, 6) |
| **Paid** | Checklists, timer intervals, cloud backup, CSV, widget options, overall stats, more categories | **Weekly, monthly and yearly reports** (the #1 reason to pay), unlimited habits, iCloud sync, multiple reminders, skip and holiday, quit mode, app icons, export |
| **Why people buy** | Look, fair one-time price, widgets | **"A one-time purchase, not a subscription"** (22.4% of its paid cohort), low price, the reports |

It matches HabitNow on all four points. It is also the strongest iPhone evidence for item 1 above: on the iPhone's biggest generic tracker, the year report is what people pay for.

**Caveats:**

- It has **no to-do list**: 237 reviews ask for one-off to-dos beside habits.
- It sells subscriptions as well as a Lifetime.
- About 72% of its reviews are Chinese, many of them solicited by a 2019–22 "review for premium" campaign (report 1, Part 0). So its average rating flatters it. Its English reviews are the ones to read.

### 2.2 Runners-up, and when each is the better comparison

| App | Ratings (13 Oct) | Why it's close | Why it isn't the answer |
|---|---:|---|---|
| **Tappsk: ToDo & Habit Tracker** | 48,560 | **Habits and to-dos on one screen**, tasks that roll forward, subtasks, a Lifetime unlock: the closest *feature* mix to HabitNow and to us | About a tenth of Inner Grow's size; mostly Russian-speaking users |
| **HabitKit** | 9,474; ~100,000 downloads (founder's figure) | One-time Lifetime at **$30, the same as our Plus**; on both iPhone and Android; ~$40K a month on iOS | Minimal heat-map tracker with no tasks; its own reviews resent the $30 price |
| **Productive** | 278,678 | Big, generic, feature-based | Subscription-first; its free plan allows 3 habits (`A13#15831`) |
| **Streaks** | 67,639 | Generic, iPhone-native, paid once | Paid upfront, with no free plan to compare |
| **Habitify** | 69,901 | Generic and feature-based | 3 free habits; checklists and most features are paid (`A33#3159`) |
| **ShineDay** | 564,230 | Generic micro-habit tracker with to-dos and a lifetime unlock; the most-rated habit tracker after Finch and Me+ | 95% of its reviews come from mainland China; ads in the free plan; a pastel, illustrated style (App Store report 52) |

**Use them like this:**

- **Inner Grow** is the benchmark for what an iPhone person expects free and paid in a generic tracker.
- **Tappsk** is the benchmark for how habits and tasks live together.
- **HabitKit** is the benchmark for our price.

Finch, Me+ and Fabulous are bigger, but they're the themed, pet or coaching apps the user ruled out.

---

## What to do next

1. **Decide the three Plus items** (the year at a glance, checklist habits, remind me again). Write each decision down as an Android A-number the same day.
2. **Update the Plus screen** (`1167:350816`) with the six rows and the "Always free" line. Add the locked states the gated features need:
   - the Habits page at Month and Year;
   - Year in Pixels on Habit details;
   - the checklist type on "How do you want to track it?";
   - "If not done, remind me again" on the Reminders page.

   Each locked state shows what it would look like and opens Plus. None of them hide data.
3. **Write the restore rule for checklist habits,** like A30: one that already exists always works without Plus.
4. **Decide the price** with §1.5 in view.
