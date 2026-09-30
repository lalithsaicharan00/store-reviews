# Speed rules — top priority for every change to the app

Written by Claude (Claude Code), 30 September 2026, at the user's request: the app lagged on the user's iPhone, the
same kinds of mistakes came back session after session, and rules kept in the long design documents weren't followed.
**This file is loaded into every session through the root `CLAUDE.md`. These rules come before any design or feature
request: a change that makes the app slower is not finished, however it looks.** If a rule has to change, change it
here, with the reason and the date.

## Before you push anything under `iOS/`

1. Run `iOS/Tools/perf/check_rules.sh` (a second, works on Linux). It fails on the mistakes below that can be read
   from the code. Fix them; never loosen the check to get past it.
2. If the change touches a view, `HabitStore`, or anything a screen reads, push with `[ios-perf]` in the commit
   message (with `[ios-ci]` if behaviour changed too), then read the result:
   `git fetch origin ci-results && git show origin/ci-results:latest.md`. Compare with the run before it
   (`git show origin/ci-results:runs/…`). A screen that got worse is a bug in your change.
3. Targets (the simulator on GitHub's Mac, a year of history): **hitch time under 5 ms/s** while scrolling, tapping
   or typing; **no freezes of 100 ms or more**; **opening a screen: longest stall under 100 ms**. Above that, find the
   cause in the table's "most time in the app's own code" column and fix it before moving on.

## The rules

| # | Rule | What went wrong when it was broken |
|---|---|---|
| 1 | **The phone build is optimised.** The user installs the *Debug* configuration from Xcode, so Debug keeps `SWIFT_OPTIMIZATION_LEVEL = -O` and `KOTLIN_FRAMEWORK_BUILD_TYPE = release`. Never set `-Onone` back to "debug better" | Every screen ran unoptimised Swift and a debug Kotlin core on the iPhone: several times slower than the same code optimised (30 Sep) |
| 2 | **Measure; never judge speed by eye, screenshots or reasoning alone.** Use the speed runs (`[ios-perf]`): the app is launched with no UI test attached and uses itself (`PerfDriver` scenarios), records its own main-thread stalls (`MainThreadMeter`), and a separate launch with `sample` names the slow functions. Timing launches have no profiler attached: on a busy hosted Mac, attaching it can pause the app beyond the former 8-second settling delay (30 Sep 2026). Debug commands use direct delivery so simulated typing does not redraw every covered screen. A new screen or interaction gets a scenario in `PerfDriver` (its screen handles the commands with `.onPerfCommand`). Never measure speed through XCUITest: its screen reading runs on the app's main thread | Screenshots made fixed taps look slow and slow ones look fine (29 Sep); a `sample`-only figure counted the UI test's own work and read "−37 % busy"; XCUITest's screen reading was up to 79 % of the app's main thread and showed 4-second "freezes" the app never had (30 Sep) |
| 3 | **Only the smallest view that shows the time ticks** (a running row's clock, the timer bar, the player's clock). Never a `TimelineView`, `Timer` or ticking `@State` around a screen or list, not even once a minute: keep the time in `@State` and move it on with a `.task` that sleeps until the next moment that matters (`TodayView.tick()`) | Today ticked every second while a timer ran: every row and streak recalculated every second, and taps waited (29 Sep). A once-a-minute `TimelineView` around the list made SwiftUI redraw it on every scroll frame: 55 % busy (30 Sep) |
| 4 | **A `TimelineView` is anchored at a fixed date** (the timer's start), never `.now` or `.distantPast`; and a view never switches between a `TimelineView` and a plain view (pause = a schedule that never ticks) | `.now` rescheduled on every redraw and `.distantPast` replayed missed ticks: the app froze (28 Sep). Switching rebuilt the player's circle and it faded on Pause (29 Sep) |
| 5 | **Anything that walks through days or history is worked out in `HabitStore`, once, and remembered** (`streak`, `bestStreak`, `daySummary`, `placements`), never recomputed in a view's `body` from all entries. Read one habit's entries (`entries(of:)`), never scan every entry. Change entries only with `insertEntry` / `removeEntry(at:)`, which keep the indexes and forget only that habit's remembered numbers. A new number of this kind is remembered the same way, and forgotten when what it reads changes | A streak checked every past day against every entry ever logged; one tap on Today recalculated every row's streak over a year of days (30 Sep) |
| 6 | **Keep what a redraw touches small.** State that changes while scrolling (rows on screen, scroll position) lives in its own small `@Observable` read only by the view that needs it (`VisibleRows`). A covered screen stops drawing (Today behind the player). Views keep stable identities: never `.id(UUID())` | Each row's `onAppear` rebuilt every section of Today (30 Sep); Today redrew behind the full-screen player on every tap (29 Sep) |
| 7 | **A tap changes the screen at once; the database write follows** (`HabitStore.addLogged`, `removeLogged`, `toggleTimer`). If the write fails the store reloads what's stored and says so. Never make a tap wait for storage | The checkmark waited for a durable SQLite write through the Kotlin core; quick taps landed on the old state (29–30 Sep) |
| 8 | **`body` stays cheap**: no sorting or filtering of history, no `Calendar` arithmetic in loops (`LocalDay.adding(days:)` and `weekday` are plain arithmetic in the Gregorian calendar; use them), no formatters or big strings built per row that could be built once | Three `Calendar` calls per day stepped were most of a streak's time (30 Sep) |
| 9 | **In a `List` with a selection, use `NavigationLink { Page() } label: { … }`**, not `NavigationLink(value:)` | The habit page never opened from All Habits: the value link only selected the row (30 Sep) |
| 10 | **Rows stay light.** A shadow goes on a background *shape*, never on a view with text or one that redraws (and never a `.clear` shadow: it still costs an offscreen pass). One `.sheet(item:)` per row, not one per sheet. No `GeometryReader` in a row just to size a fill (`scaleEffect(x:anchor:)` draws the same) | Every Today row paid for a clear text shadow, four sheet modifiers and a `GeometryReader`; the timer bar re-rendered its whole shadow every second (30 Sep) |
| 11 | **Typing updates only the field.** Anything that follows the text (a preview, a sentence, a suggested icon) catches up when typing pauses (`HabitForm.shownName`, 0.3 s); saving always reads the live text. Never animate something on every keystroke | Every letter in the New Habit name redrew and re-animated the preview row and sentence: 92 % of the main thread and 100–400 ms freezes per letter, the worst screen in the app (30 Sep) |

## Why the mistakes kept coming back

- The speed rules lived in the middle of a long design document that sessions read "before changing a screen", so
  changes to the store, a model or build settings never met them. They're now here, loaded first, with a script
  that fails on the ones code can show.
- Speed was judged by eye on the simulator or by reasoning about the code, not measured before and after.
- Work that grows with history (streaks, counts, calendars) was written straight into view bodies. It's fast with the
  week of data a new build has, and slow with a year of it, or on the phone.
- The phone ran an unoptimised Debug build, which made every other cost several times bigger.
