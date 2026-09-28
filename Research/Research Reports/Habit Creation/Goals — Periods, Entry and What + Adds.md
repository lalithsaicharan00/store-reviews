Written by Claude (Claude Code), 28 September 2026.

# Goals — Periods, Entry and What + Adds

Three questions for the Goal screen of Check it off, Count it and Time it:

1. **Periods.** Is a weekly, monthly or yearly goal an add-on to a daily goal, or its own choice?
2. **Entering the number.** Scroll or type?
3. **What + adds.** Can we pick what one tap adds by rule, so nobody is asked "Each tap adds"?

This report replaces two earlier drafts written by Codex the same morning ("Goal Periods — Daily, Weekly,
Monthly and Yearly" and "Goal Entry and Logging — Native Input and Automatic Actions"). I checked their
cited reviews against the corpus. The ones that hold up are folded in here and marked "(Codex, verified)".
The drafts are kept in `Research/Temp/goals/codex-drafts/`.

## Answers

| Question | Answer | Basis |
|---|---|---|
| Periods | **Each period stands alone.** Pick Day, Week, Month or Year, then the amount. A week, month or year goal has **no daily goal underneath it**. Day is the default. | Users show it (§1) |
| One habit with a daily goal *and* a weekly total | Rare: 1 real request in the 15 "daily and weekly" hits. Not built. | Users show it (§1.3) |
| "30 min on any 4 days a week" (an amount per day, on N days) | A real minority need: 9 reviews. **Not built yet.** It's a Day goal plus "N days a week"; see §5 | Users show it (§1.4) |
| Entering a count | **Type it**, on the number keyboard. No wheel, no cap | Users show it (§2) |
| Entering a time | **Hours and minutes wheels, open straight away**, like the Clock timer. A **Scroll / Type** switch for exact or large times (100 h a year) | Users show it for typing; wheels reasoned from first principles (§2.3) |
| What + adds | **No question.** + adds 1 when one at a time is how it happens; otherwise + asks how much. The Goal screen says which, before saving (§3) | Users show the problem; the rule is reasoned from first principles plus a goal-number count (§3) |
| Repeating the same amount | The Add Amount sheet offers **"Add 250 ml" (the same as last time)** as one tap | Reasoned from first principles; answers the "+10 / +100 ml" requests without a setting (§3.3) |

## Method

- **Corpus:** all 1,238,784 reviews in `App Store Reviews/` and `Play Store Reviews/` (habit, routine and to-do
  apps; every language, scanned with English patterns).
- **Scans:** `Research/Temp/goals/goal_scan.py` (9 themes), `composite_scan.py` (composite, layered and
  forced-daily goals) and `goal_numbers_scan.py` (the goal numbers reviewers mention, per unit).
  The hit lists are in `goal_hits.json`.
- **Read by hand:** every hit for goal caps (2), scrolling (72), tapping many times (59), custom amounts (28),
  composite goals (20), layered goals (15) and forced daily goals (3). Also all 99 "not every day" hits, and the
  first 45 period-total hits that ask for something. The period themes are large (700 and 740 hits) and mostly
  about **schedules** (certain days, every other day), not goals, so they were sampled, not coded in full.
  **Counts below are of reviews I read and judged on topic**, not raw pattern hits.
- **Reddit:** blocked for my tools (search and the built-in browser both refuse reddit.com). Codex's Reddit
  links (TickTick 5 exercises a week; a 4 hours a week timer thread; HelloHabit 50 books a year; Finch
  book-a-month) are **leads I could not open**. They are not used as evidence here.
- **Competitor pages:** Habitify's changelog, fetched 28 Sep 2026, is used only to show what the app changed.
  It is not a reason to copy the app (see CLAUDE.md, "never copy competitors blindly").
- **Every review ID below was checked against `reviews.jsonl`** with `Research/Temp/goals/verify_ids.py`.

## 1. Periods: independent, not on top of a daily goal

### 1.1 People ask for the period *instead of* a daily goal

These reviewers want a week, month or year goal and say a daily goal gets in the way:

| Review | App, rating | What they say (paraphrased) |
|---|---|---|
| `531ca9fe-c42a-4183-8474-686eec4e4958` | HabitNow, 4★ | "The app is forcing me to specify a daily goal." Wants 5 times a week, "even if it's all on one day". |
| `5fead3d7-9f47-4b9f-b575-d660b5f5b15b` | Habit Tracker (Play), 1★ | Can only choose "a day"; most of their goals aren't daily; "a waste of 5 dollars". |
| `311de7ec-103f-4874-857e-afa028ddeaf1` | HabitNow, 1★ | Number habits are per day only; no per week. Uninstalled. |
| `2212210617` | Habit-Bull, 1★ | 3 hours of reading a week: six half-hours, three hours, or all at once (Codex, verified). |
| `3631271757` | HabitMinder, 4★ | "Please add PER WEEK goals": 100 pages a week, on days they can't predict. |
| `aae74a62-6c0c-472d-b204-2fd3f6806efe` | HabitNow, 5★ | Weekly/monthly timed goals: 7 hours a week, as 1 h × 7 or 3.5 h × 2. |
| `b089d9d5-ad2a-4901-a6eb-b7ee592d920e` | Habit Tracker (Play), 4★ | Would rather have "15 pages a week" than "5 pages on 3 days", so a busy week can be done in one day. |
| `e42e04de-7677-4ecb-862b-fb47772d209a` | HabitNow, 4★ | Wants weekly or monthly goals "rather than just daily goals". |
| `9021968448` | Do Habits, 3★ | Most apps can't do "read 12 books a year", "such a small and obvious thing". |
| `3661092892` | Habit-Bull, 4★ | Gym 100 times a year, and to see how many are left. |
| `2065729197` | HabitMinder, 4★ | Three times a week without choosing the days. |
| `9438711434` | Do Habits, 1★ | Will switch apps after monthly and yearly tracking was removed (Codex, verified). |
| `5358836760` | Streaks, 4★ | 500 km of cycling a year (Codex, verified). |

`9564490880` (Do Habits, 2★, Codex, verified) shows the pattern clearly. It lists daily water, weekly
workouts, monthly new restaurants and yearly charity. Each habit has **its own** period, and none needs a
daily goal underneath.

**So users show:** the period is part of the goal ("100 pages *a week*"). Forcing a daily goal first is the
complaint, not the fix.

### 1.2 A week goal means "on any days"

Every reviewer above wants freedom over *which* days. A fixed-day schedule (Mon, Wed, Fri) is a different
thing: a Day goal with Repeat on certain days. So when the goal is per week, month or year, **Repeat leaves
the form**, and the Goal screen says "Any days you like… There's no daily minimum." Two separate controls
that could disagree would be hidden state. *Reasoned from first principles.*

### 1.3 A daily goal plus a weekly total on one habit: rare

Of the 15 "daily and weekly goals" hits, **14 mean different habits with different periods**. For example,
`9519092934` says "8 daily goals with four weekly goals", and `6888486242` has both daily and weekly goals.
Only **one** wants both on the same habit: `7ad472e7-f7fa-4364-a70b-ce9f9aafc254` (HabitNow, 5★), "at least 25
min at least 4 times per week, but in total not less than 2h each week". Not built. One primary goal per habit.

### 1.4 "An amount on N days a week": a real minority

Nine reviews want an amount per day on some days of the week:

- `3357180258`: run 3 miles at least 4 days a week.
- `7681273373`: "30 minutes, four times a week".
- `11687820487`: 15 minutes 8 times a week.
- `13845782656`: write 30 min 6 days a week.
- `12125335687`: 30 min cycling on 5 of 7 days.
- `9496045343`: exercise 30 minutes 3 days a week.
- `4f132107-2f1b-4b24-b5a1-56183340459f`: 15 minutes a day, but only 6 days a week.
- `10655113870`: a language for 10 minutes 3 times a week.
- `1324482823`: read 30 minutes 5 times a week. They also want to log two sessions on one day, which a
  weekly total gives them.

With fixed days, this already works: a Day goal with Repeat on certain days. With **any** N days, it's a Day
goal plus an "N days a week" schedule, which the model can't hold yet for counts and times. See §5.

### 1.5 Rules that follow

- **Totals add up across the period.** 20 min Monday + 2 h 40 min Saturday meets "3 h per week".
- **No daily failure** inside a week goal. Tuesday with nothing logged is just "in progress".
- **The streak counts periods** ("3 wk"), already built (`StreakUnit`).
- **Calendar periods**, using the user's week start. The Goal screen shows the first period's dates, e.g.
  "First period: 28 Sep 2026 – 3 Oct 2026". The first, partial period keeps the full goal; nothing is
  prorated or invented.
- **Going over is kept.** It isn't carried into the next period.

## 2. Entering the number: type it

### 2.1 What reviewers say

Of the 72 scrolling hits, **16 are about entering a number.** Most are about scrolling a list, not a number.

| Wants to type | Review |
|---|---|
| 10k steps, "instead of having to scroll for a minute" | `11613476397` (TheFor, 5★) |
| 12k steps: capped at 10k, and objects to scrolling (Russian) | `12835800918` (TheFor, 4★; Codex, verified) |
| "Imagine scrolling the wheel from 1 to get to 5000"; 5,000 or 9,999 maximum | `525314bf-a556-49f2-9e56-15600212c619` (TheFor Play, 3★) |
| Scroll "all the way down" to 999; wants "an input field" | `9770788297` (Productive, 2★) |
| Enter 45 "instead of swiping 45 times" (120 min a week goal) | `1450955508` (Strides, 5★) |
| Scroll to enter a duration; typing doesn't work | `29efc521-b731-4626-961b-fca34db1e0d4`, `fed58be3-0fb3-459d-9431-50182883fe58`, `d76cec5e-ef35-4176-b399-ff763df2d377` (My Study Life) |
| Changed from the keyboard to a scroll wheel, "irritating" | `03492ef1-91ee-407b-b472-d42c8320e719` (Hevy, 3★) |
| Type numbers instead of scrolling the wheel (400+ kg) | `5f03a30e-cce9-42df-a29b-98f5585bf609` (Hevy, 4★) |
| The slider should be optional, "much easier to type in decimal numbers" | `15db6d29-af9f-4d32-8066-b671a44c82d1` (Loop, 5★) |
| Tap to type instead of scrolling: "people with sore joints may struggle" | `f2980c4b-3922-4608-b03d-75491b79b7e2` (RoutineFlow, 5★) |
| Goal only in steps of 1,000; wants 2,500 | `1238687484` (Streaks, 4★) |
| Works around scrolling to 100 minutes with a "10s of minutes" unit | `13ececfd-d6ea-4632-b72e-3c3dbc01352a` (Loop, 5★) |

**Against:** `dae2df53-ae28-4193-b4f5-8a9ab0e5ab83` (Loop, 5★) wants the old scroll back.
`9f06fce3-f585-4ec1-93e6-8007c824a857` (Loop, 1★) asks for "an option … to insert the number or scroll to it".
That makes **2 of 16** for scrolling, and one of those two wants a choice.

Habitify, the app the user saw capped at 1,000, raised goal limits on iOS (10 Mar 2026) and added "type in your
exact custom number" (23 Sep 2026), per its changelog. That confirms the problem. It isn't a reason on its own.

### 2.2 Decision for Check it off and Count it

A **text field on the number keyboard**. It's selected when tapped, so typing "3" replaces "1". There's no cap
and no wheel. Decimals are allowed up to 2 places for amounts (0.5 km, 2.5 L); a tick in "times" is whole.
Count it opens with the keyboard ready, because the number is the first thing to set.

### 2.3 Decision for Time it

Time is bounded: 0–23 hours and 0–59 minutes fit two short wheels. The Clock app's timer is the same control,
so the wheels show straight away with 20 min set. The complaints above are about **long** ranges (to 999, 5,000,
100 minutes on one wheel). For those, a **Scroll / Type** switch gives two number fields: 100 hours a year is
four key presses. A time goal can't be longer than its period (at most 24 h a day). *Wheels: reasoned from
first principles. Typing for large values: users show it.*

## 3. What + adds, without asking

### 3.1 The problem is real, and asking isn't the fix

- **Tapping too many times:**
  - `3678644474` (Do Habits): 65 taps for 65 g of fish.
  - `13510993353` (Finch): "hit the + button 100 times … carpal tunnel".
  - `9770788297` (Productive): 1 by 1 up to 90.
  - `10063428334` (Habit Tracker): wants to type an amount of water.
  - `27aceabc-cac0-486f-9b59-7df8d2b14dd5` (HabitKit): wants to type "instead of pressing the +".
- **Wanting a bigger step:**
  - `c4c14097-1651-4354-9c35-aa38a542d6e3` (Loop): "+1 for water, +10 for running", because tapping +1
    80 times is exhausting.
  - `89d9a369-75d5-4536-8b7b-bc543b77745e` (Habit Tracker Play): 100 ml steps toward 2,000 ml.
- **An automatic step that guessed wrong:** `13464093143` (Habit Tracker, 4★). Over a 20 count, the swipe
  jumps by 5, and they want 1s. A coarse automatic step with no way to log the exact amount annoys people.
- **Typing every time for small counts is also bad:** `6100935111` (Do Habits) says "fast entry is king".
  `91ce824d-0119-4e65-a03c-2bc645bc5faa` (HelloHabit) likes "easily tapping" to record small counts.

So one tap is right for small counts, typing is right for big or measured ones, and a fixed configured step
isn't needed if typing and "same as last time" are one tap away.

### 3.2 The goals people actually set

`goal_numbers_scan.py` counts goal phrases ("8 glasses a day", "10k steps a day") across the corpus:

| Unit | Goal phrases | Whole number, 10 or less |
|---|---|---|
| times | 536 | 95% |
| glasses | 48 | 100% |
| cups | 22 | 95% |
| litres, bottles | 8, 4 | 100% |
| minutes | 71 | 32% |
| pages | 19 | 47% |
| push-ups | 10 | 40% |
| steps | 17 | 6% |

The 10 mark splits the units cleanly. Things you drink or do "times" sit at 10 or under. Pages, push-ups and
steps usually go above it, and people log them in batches.

### 3.3 The rule (built in `GoalInput.swift`, `CountLogging`)

1. **Measured unit** (km, miles, ml, litres, oz, kg, lbs, g, money, calories): **+ asks how much.** Real
   entries are rarely whole ones (0.5 mile, `12250094565`, HelloHabit; Codex, verified).
2. **Decimal goal:** + asks how much.
3. **Whole goal of 10 or less:** + adds 1. This covers any other unit, including your own ("5 prayers").
4. **Bigger goal:** + asks how much, **except** for things that happen one at a time (times, glasses, cups,
   bottles, books, chapters, meals, servings, workouts, sessions, classes, lessons, pills). "12 books a
   year" is still one book per log.

When + asks, the **Add Amount** sheet opens with the number keyboard up. It adds to what's logged; it never
replaces it. It also shows **"Add 250 ml — the same as last time"** as one tap, because most logs repeat (a
glass, a usual run). That answers the "+10 / +100 ml" requests with no setting to configure.

Every count also has **Add Amount…** and **Undo Last Entry** on touch-and-hold. + never undoes, and going over
the goal is kept.

**The Goal screen says which, before saving:** "On Today, each tap on + adds 1." or "On Today, + asks how much
you did, with the number keyboard." There's no hidden state. *The 10 threshold and the one-at-a-time list are
reasoned from first principles plus §3.2. No review names a number.*

Check it off keeps its ✓ (a tick is one time). Time it keeps ▶ for the timer, plus Add Time… on
touch-and-hold. A reminder's "+1" action appears only when + adds 1; otherwise the notification opens the app.

## 4. The screens as built (28 Sep)

| Screen | Contents |
|---|---|
| Goal, Check it off | Per [Day · Week · Month · Year]; Amount (1) and Unit (times) under "Goal"; "Your goal: 3 times per week". Footer: another unit, like glasses, makes it a count with + |
| Goal, Count it | Per; Amount (empty, keyboard up) and Unit (Choose). Your goal; the + rule for this goal |
| Goal, Time it | Per; Scroll / Type; wheels at 0 h 20 min, or Hours and Minutes fields. No units: time is hours and minutes only |
| Unit | Your own unit (text field) at the top, then units you've used, then Count, Volume, Distance, Weight and Money. One screen; no separate "unit name" screen; no time units |
| Form | Repeat shows only for a Day goal. The Goal row reads "2k ml per day", "12 books per year", "3 h per week" |
| Add Amount / Add Time | Amount with its unit, "Add 250 ml" (the same as last time), and Progress |

All controls are native: `Form`, segmented `Picker`, `TextField` on the number or decimal pad, wheel
`Picker`, `NavigationLink`, sheets with detents.

**Checked** on the iPhone 17 Pro simulator with `HabitsUITests/GoalFlowUITests` (5 tests, all pass). The
tests cover 2,000 ml a day (+ asks; then "same as last time"), 8 glasses (+ adds 1), 12 books a year, Check it
off 3 times a week and Time it 3 h a week. Screenshots are in `Research/Temp/goals/shots/`. The full UI test
suite has not been run: `NewFlowUITests` still uses the old Goal stepper and will need updating.

## 5. Not built, and why

| Item | Why not now |
|---|---|
| Any N days a week, with an amount per day ("30 min on any 4 days") | 9 reviews want it. It needs a new schedule kind for counts and times. Fixed days already work (Day goal + Repeat on certain days) |
| A daily minimum plus a weekly total on one habit | 1 review. It doubles every progress rule |
| "Times" vs "days" for Check it off weekly goals | A week goal counts ticks, so two ticks in one day count twice. Say so ("even twice in one day"); a "days" unit can come later if reviews ask |
| Editing a goal later | Needs goal history (spec §8) |

## Sources

- Habitify changelog: https://feedback.habitify.me/changelog (fetched 28 Sep 2026)
- Habitify, Setting Goal: https://intercom.help/habitify-app/en/articles/12393175-good-habit-setting-goal (via Codex; not re-opened)
- Scripts and hits: `Research/Temp/goals/` (goal_scan.py, composite_scan.py, goal_numbers_scan.py, verify_ids.py)
