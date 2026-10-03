# claude/habit-details-ci @ b808741

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37124597344 · 2026-10-03 13:01 UTC
Commit: Habit page: History · Notes · Progress, Add Entry, Year in Pixels, milestones as squares

- Core storage and migrations: success
- Build: failure
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,UndoUITests,TasksUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:1344:65: error: cannot convert value of type 'Core.HabitRecord' to expected argument type 'Habits.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:1512:61: error: cannot convert value of type 'Habits.HabitRecord' to expected argument type 'Core.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:1620:57: error: cannot convert value of type 'Core.HabitRecord' to expected argument type 'Habits.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:1694:57: error: cannot convert value of type 'Habits.HabitRecord' to expected argument type 'Core.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:1715:57: error: cannot convert value of type 'Habits.HabitRecord' to expected argument type 'Core.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:1745:53: error: cannot convert value of type 'Habits.HabitRecord' to expected argument type 'Core.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:1763:65: error: cannot convert value of type 'Habits.HabitRecord' to expected argument type 'Core.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:1794:65: error: cannot convert value of type 'Habits.HabitRecord' to expected argument type 'Core.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:1991:57: error: cannot convert value of type 'Habits.HabitRecord' to expected argument type 'Core.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:2333:50: error: cannot convert value of type 'Habits.HabitRecord' to closure result type 'Core.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:603:65: error: cannot convert value of type 'Habits.HabitRecord' to expected argument type 'Core.HabitRecord'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore.swift:716:63: error: cannot convert value of type 'Habits.HabitRecord' to expected argument type 'Core.HabitRecord'
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
