# perf-scrolling-and-ci @ 60dbef6

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36668756601 · 2026-09-30 04:44 UTC
Commit: Speed tests on GitHub Actions, with results Claude can read [ios-perf]

- Build: success
- UI tests (none): skipped
- Speed tests: success

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | Main thread busy | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday |  % |  % | (none above noise) |
| testTapToday | 71.0 % | 0.7 % | 2.7%  HabitRow.row(now:)<br>1.0%  closure #2 in HabitRow.row(now:)<br>1.0%  HabitStore.isDone(_:on:)<br>0.9%  closure #1 in closure #2 in HabitRow.row(now:) |
| testScrollAllHabits |  % |  % | (none above noise) |
| testScrollHabitPage | not measured (test exit 65; see testScrollHabitPage.log) | | |
| testCalendarMonths | 60.1 % | 1.8 % | 16.0%  CalendarSheet.dayButton(_:)<br>15.0%  HabitStore.daySummary(on:)<br>14.3%  partial apply for closure #2 in HabitStore.daySummary(on:)<br>14.3%  closure #2 in HabitStore.daySummary(on:) |

Scroll hitches on Today (Apple's measure; under 5 ms/s is smooth, over 10 is visible stutter):

- Duration (Scroll_DraggingAndDeceleration), s: **0.911**
