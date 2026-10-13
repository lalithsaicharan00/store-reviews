# Shared Habit Rules — Results

Written by Claude (Claude Code), 12 October 2026, for Current Work item 92: the habit rules moved from the iPhone's Swift
into the shared Kotlin core, so iPhone, iPad, Apple Watch and Android work out the same numbers from one copy.

## What moved

`Core/rules` (package `app.habits.rules`, written down in [`spec/`](spec/README.md)):

| Area | Rules | Kotlin |
|---|---|---|
| The day | which day a moment belongs to, the day start, daylight saving, day bounds, weeks, months, years, a habit's first day | `HabitRules.today`, `dayBounds`, `dayStart`, `dayStartMoment`, `period`, `startDay`, `quitStartDay`; `Day`, `Zone` |
| Schedules | every schedule, calendar rules, "after it's done", tasks and moved days, start and end dates, goal history, skips, pauses, archives | `isDue`, `matches`, `add`, `rule`, `periodRange`, `periodKind`, `hasPause` |
| Goals | the day's goal and progress, period totals and counts, done, complete, satisfied, period met, counting up, a day's share | `dayGoal`, `dayProgress`, `isDayMet`, `isTotal`, `loggedTotal`, `periodTotal`, `periodCount`, `progress`, `goal`, `isDone`, `flexibleProgress`, `isComplete`, `isSatisfied`, `isPeriodMet`, `countsUp`, `dayFraction` |
| Streaks | the streak, the run before, every run, the best streak, quit runs and slips, milestones | `streak`, `runBefore`, `runs`, `bestStreak`, `slips`, `quitHistory`, `quitRuns`; `Milestones`, `StreakUnit` |
| A day across habits | a habit's outcome, a day's score, a habit's calendar mark | `outcome`, `dayScore`, `todayScore`, `dayMark` |
| Where habits show | placements, timed sections, Today's cards | `placements`, `timedSections`, `sectionForMinute`, `dayMinute`, `todayCards`, `cardMembers` |
| Reading saved data | the database's rows and the iPhone's saved settings | `Rows.load`, `RulesInput` (from `Core`'s records), `LiveRules` (the apps' live copy) |

## Checkpoint 1: proven against the iPhone

The golden cases ([`fixtures/`](fixtures/README.md)) were recorded by running the iPhone's own code on GitHub's Mac
(`core-fixtures.yml`, `GoldenRecorder.swift`):

| Set | Cases | Answers compared | Recorded in | Differences |
|---|---|---|---|---|
| Hand-written, one or more per spec rule | 61 | | run 38213677372 | 0 |
| Seeded random histories (every kind, schedule, day start, week start, zone, edit, skip, pause, archive, timer) | 2,000 | | run 38213677372 | 0 |
| A year of history (450 days, twelve habits, the Watch's 400 days) | 1 | | run 38213677372 | 0 |
| The extreme account (40 habits, 15 years, 375,090 logs) | 1 | | run 38213679929 | 0 |
| **All** | **2,063** | **8,267,003** | | **0** |

The recorder found two iPhone bugs on clock-change nights, both fixed in Swift and in the spec the same day: `dayBounds`
crashed (New York, 2 AM day start), and a day whose start hour is skipped started a day late (Lord Howe Island)
([differences.md](spec/differences.md) #6, #8). Five more behaviours that look wrong are kept as they are, waiting for the
user's decision (#2, #3, #4, #5, #7).

**Speed on the JVM** (`RulesSpeedTest`, this session's Linux container, third round): a year of history: rows read in
10 ms, streaks and best streaks of 12 habits 5 ms, a month's day scores under 1 ms. The extreme account: streaks and best
streaks of 40 habits over 15 years 80–270 ms, a month's scores 1 ms.

## Checkpoint 2: the iPhone, iPad and Watch ask the shared rules

Every rule function in `HabitStore` asks the core first (`HabitStore+Rules.swift`, `LiveRules`); the store keeps its
shape (it remembers what it worked out, S5) and the Swift rules stay as the fallback.

- **The same answers through the bridge:** every golden case recorded again through the iPhone's own store with the
  shared rules answering (`-golden-shared`, run 38213784456), compared with the Swift rules' recording, every key, the
  screens built on the rules included (Progress Week, Month and Year with their cards, the habit page's record, Over
  Time, weekday chart and quit statistics, and the widgets' whole snapshot): **2,062 cases, 0 differences**
  (`fixtures/tools/compare.py`).

### Making it as fast as the Swift rules

The first switch gave the same answers but was slower, side by side with `main` (one job, four rounds): the Day sheet's
add, edit and undo 241 → 502 ms/s with 35–58 freezes, Today's +1 8.5 → 33.4, the calendar's month change 9.7 → 27.5,
Progress's year cards 2.7× the work (runs 38229397046, 38229387771, 38229393346). The Kotlin rules themselves were never
the cost (a profile put them at 0.1 % of the main thread); measuring part by part (`RulesBench`, the `rules-calls` speed
scenario) found where it went, and each fix kept every answer (GoldenTest, StripTest, LiveRulesTest, the shared
recording):

| What cost the time | Fix |
|---|---|
| Every shared rule told SwiftUI it read the habit's logs, so "is it due" redrew Today's list on every log (69 draws became 287) | Each rule reads for SwiftUI exactly what the Swift rule read (Rulebook S19); one counter for skips, moves, pauses, goal history and archive days |
| A strip of days (Progress's cards, the habit page's record, history, Progress tab and comparison, Over Time, the weekday chart, the calendar's day scores) crossed into Kotlin once per day and rule | One call per habit and range (`LiveRules.days` → `HabitRules.strip`, read back as one block of bytes); a fortnight of day scores at a time |
| The Swift side's bookkeeping around each call: 2.2 µs (crossing itself 0.2 µs) | One handle lookup, the calendar's kind remembered: 0.6 µs |
| Kotlin looked a habit's data up by its ID string (hashed again on every lookup on Apple platforms), boxed every day number, read the zone's clock again for the same moments, made a judged copy of a habit per day, and asked the app's clock back across the bridge | Each habit's data found once and kept on it (`HabitFacts`), logs indexed by day number (`DayBuckets`), tables of moments read, judged copies kept per goal, the clock read only when a timer or an overdue task needs it, no boxed dates in schedules |
| Habits and settings given again unchanged (the Watch, after each sync) threw away everything worked out | Skipped when nothing changed; the zone carries over a real change |
| The copy of every log rebuilt on the main thread after every load (45–80 ms) | Made off the main thread while the load reads |

| Views drew for inputs the rules' refresh read: the first view to ask a rule after a change gave the core its habits and settings again, read tracked, and redrew for every habit, skip, pause, timer and section (the Day sheet 641 draws against 451) | What the core is given is read untracked (`ruleState`); each rule still reads what it depends on (S19) |
| A Today row asked about ten rules, each its own crossing; the Apple Watch's slower processor felt every one | A row's numbers in one call (`LiveRules.row` → `HabitRules.row`, `CoreRow`), checked against each rule asked on its own for every golden case (194,813 habit-days, 0 differ) |

### The final speed, side by side

**iPhone** (`[ios-perf-bisect]`, `main` @ `ac462364` against the shared rules @ `41045ec5`, one job each, hitches in ms/s,
median of the rounds; lower is better):

| What | `main` | Shared | Run |
|---|---|---|---|
| Today: scrolling | 0.0 | 0.0 | 38329425418 |
| Today: +1 and day ‹ › | 51.0 | 26.8 | 38329425418 |
| Today: +1 alone | 0.2 | 0.2 | 38329425418 |
| Today: day ‹ › alone | 35.1 | 45.2 | 38329425418 |
| Day sheet: add, edit and exact undo | 163.4 | 163.2 | 38329426726 |
| Entry editor: typing | 1.4 | 2.6 | 38329426726 |
| Widget: full publication | 0.8 | 1.3 | 38329426726 |
| Habit page: History scrolling | 6.5 | 5.7 | 38329425137 |
| Habit page: Progress scrolling | 14.4 | 5.6 | 38329425137 |
| Habit page: switching tabs | 4.3 | 4.1 | 38329425137 |
| Progress: scrolling | 6.2 | 4.5 | 38329425137 |
| Progress: period ‹ › and range | 113.2 | 122.8 | 38329425137 |
| Progress Year: scrolling | 20.4 | 7.4 | 38329426542 |
| Calendar: month ‹ › | 4.3 | 4.5 | 38329426542 |

Day ‹ ›, typing, the widget and Progress's ‹ › overlap round by round (Today's day ‹ › per round: `main` 141, 25, 45,
46, 17, 24; shared 51, 40, 16, 24, 76, 65; the round before, 22.3 against 26.4), and redraws are equal (Today's list 607
against 596, the Day sheet 635 against 630). Work: Progress's year cards 172 ms against 213 (run 38329426542), the habit page's history
1.19× (`main` 2,825 ms over 583 asks, shared 3,363 over 580).

**Apple Watch** (`[watch-perf]`, one build, the variants in turns, four rounds; the Swift rules with `-swift-rules`):

| What | Swift | Shared, one call per rule | Shared, a row in one call | Runs |
|---|---|---|---|---|
| Today: scrolling 30 habits | 8.5 | 2.6 | 2.0 | 38342508127 |
| Routine: paging with the Crown | 3.7 | 2.4 | 1.1 | 38342508127 |
| Launch to a usable Today | 1.0–1.4 s | 0.7–1.1 s | 0.9–1.1 s | 38342508127 |
| Day details: +1 | 1.2 | 5.2 | 1.5 | 38342507816 |
| Today: +1 | 2.0 | 0.6 | 2.3 | 38342507816 |
| Today: ✓ and Undo | 0.8 | 1.5 | 1.8 | 38342507816 |

The final build (shared by default) against `-swift-rules`, on two slower machines: Today scrolling 15.4 against 17.6,
routine 3.5 against 3.5, launch even (run 38349267677); Day details +1 53.3 against 54.1, with the same draws per tap
(run 38355351760). One round of Day details +1 in run 38349267677 (61.9 ms/s) did not come back.

### Tests on GitHub

- **Answers:** every golden case through the shared rules again on the final code: 2,062 cases recorded again on the final code, 0 differences beyond the Lord Howe fix (#8), whose Swift recording predates it (run 38363493132).
- **iPhone UI** (`41045ec5`): Today, TodayRowLayout and Progress (38329428557); Arrange, Groups, Placement and Schedule
  (38329431161); HabitPage, both halves (38329435488, 38329450617); DayDetails (38329437499, 38338945612, 38345185625);
  FocusPlayer and NewHabit (38329439841); WeekCards, TodayRowSheet, Reminders and SectionHeader (38329441779); Undo,
  Tasks, CompletionFeedback and RoutineCalendar (38329443653); Widget, WidgetSystem and Timer (38329445759).
  Failures, each read and rerun (T2): FocusPlayer's swipe and NewHabit's typed limit passed again here and on `main`
  (38342599243, 38342602049); Groups' Filter sheet failed the same way on `main` (38348370810 here, 38348373467 on `main`);
  DayDetails' `testTickSteps` was XCTest failing to stop the app, and passed again; DayDetails no longer fits one run
  and was split (Rulebook T1). ProgressUITests.testHidePercentages: failed three times here (38329428557, 38345185625, 38350206922) and passed 8 of 8 on `main` (38350211791, 38350214291); being measured (launch, run 38363372540).
- **Reminders' self-check** (90 s): the shared and Swift rules take the same time in one job (59, 42 s against 52, 47 s:
  run 38338710982); nearly all of it is importing a year of history, and `main` took 89 s (run 38328968932).
- **iPad** (iPad Air 11-inch): IPadUITests 15/15 (38329447799); the one failure the run before passed again here and on
  `main` (38328971447, 38328983009).
- **Apple Watch:** every Watch UI test on both sizes, on the shared rules (38349268502) and on the Swift rules
  (38329424844); the paired-simulator step failed booting, as it does on every branch.

## What stays in Swift, and why

Nothing on the Apple Watch: it was kept on its Swift rules for a day (12–13 Oct) while it was slower, and moved once
it wasn't (above). `-swift-rules` still turns the Swift rules on anywhere, to measure side by side.

- **A phone set to a non-Gregorian calendar** (Buddhist, Japanese, …) keeps the Swift rules: its saved days are in that
  calendar's years and the shared rules count Gregorian days ([differences.md](spec/differences.md) #5, the user's
  decision).
- **Words and screens** built on the rules (Progress, the habit page, widgets' text, `HabitCopy`): the iPhone's own; each
  platform writes its own words over the same numbers.
- **Lookups that are only the store's own data**: `isSkipped`, `isPaused`, `isArchived`, `rule(_:on:)` (which earlier
  goal judged a day: the Swift habit is needed for its words), `entries(of:)`.
- `recordingDay(at:for:)` (the log editor's day for an edited time): kept until the user decides #7.
