# progress-page-research @ 97980f8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36803031667 · 2026-10-01 02:15 UTC
Commit: Today: the group filter chip sits in a bar pinned above the list, so ✕ is the chip itself

- Build: success
- UI tests (none): skipped
- Speed tests: success

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 6.4 % | 0.6 % | (none above noise) |
| testTapToday | 12.4 % | 1.3 % | 0.3%  HabitStore.isDayMet(_:on:)<br>0.3%  partial apply for closure #5 in closure #1 in closure #8 in TodayView.content(now:)<br>0.3%  closure #5 in closure #1 in closure #8 in TodayView.content(now:)<br>0.3%  TodayView.partSection(_:items:day:isToday:isNow:) |
| testMenuOpenClose | 4.6 % | 1.2 % | 0.0%  closure #1 in closure #1 in TodayView.topBar.getter<br>0.0%  MenuModel.setOpen(_:reduceMotion:then:)<br>0.0%  partial apply for closure #1 in MenuModel.setOpen(_:reduceMotion:then:)<br>0.0%  closure #1 in MenuModel.setOpen(_:reduceMotion:then:) |
| testScrollAllHabits | 6.9 % | 0.6 % | 0.0%  HabitStore.quitRuns(of:now:)<br>0.0%  HabitStore.quitHistory(of:now:)<br>0.0%  static Format.elapsed(_:) |
| testScrollHabitPage | 4.2 % | 1.5 % | 0.0%  HabitStore.quitRuns(of:now:)<br>0.0%  HabitStore.quitHistory(of:now:)<br>0.0%  HabitStore.slips(of:now:)<br>0.0%  Collection.map<A, B>(_:) |
| testCalendarMonths | 7.1 % | 0.9 % | 1.1%  CalendarSheet.dayButton(_:)<br>0.9%  HabitStore.todayScore(on:)<br>0.9%  HabitStore.dayScore(on:habits:today:)<br>0.8%  HabitStore.outcome(_:on:today:) |
| testProgress | 28.9 % | 10.3 % | 9.2%  ProgressModel.load(_:store:)<br>9.2%  HabitStore.progressSnapshot(_:containing:today:fullAt:group:)<br>7.7%  Collection.map<A, B>(_:)<br>4.3%  score #1 (_:_:_:) in HabitStore.progressSnapshot(_:containing:today:fullAt:group:) |
| testProgressHabitPage | 11.7 % | 1.9 % | (none above noise) |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 5.0 s
- Habit page from Progress: 3.6 s
- Habit page: 3.4 s
- Habits: 2.4 s
- Habits: 2.5 s
- Menu: 2.9 s
- Menu: 3.2 s
- Menu: 3.3 s
- Menu: 3.5 s
- Menu: 3.9 s
- Progress: 3.1 s
- Progress: 3.4 s
