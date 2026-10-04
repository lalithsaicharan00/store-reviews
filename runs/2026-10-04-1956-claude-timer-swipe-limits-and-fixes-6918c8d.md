# claude/timer-swipe-limits-and-fixes @ 6918c8d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37228093818 · 2026-10-04 19:56 UTC
Commit: GroupsUITests: drag the reorder handle by its coordinate (a compile error stopped the run)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayRowSheetUITests,TodayRowLayoutUITests,SectionHeaderUITests,GroupsUITests,BackupUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 28 tests, with 1 failure (0 unexpected) in 972.999 (973.028) seconds
	 Executed 28 tests, with 1 failure (0 unexpected) in 972.999 (973.030) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 76.639 (76.643) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 157.472 (157.477) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 223.415 (223.424) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 483.216 (483.223) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:150: error: -[HabitsUITests.TodayRowSheetUITests testSwipeActions] : XCTAssertGreaterThanOrEqual failed: ("50.0") is less than ("60.0") - Both buttons are big enough to hit
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (50.279 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (8.944 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (74.047 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (25.553 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (24.160 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (15.154 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (10.878 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (14.399 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (31.026 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (50.042 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (85.309 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (51.359 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (83.129 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (65.393 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (49.044 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (35.098 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (32.816 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (32.257 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (34.917 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (10.487 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (16.731 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (14.503 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (16.952 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (35.702 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (33.660 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (21.690 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' failed (30.766 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (18.702 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 19.6 | 148 ms | 2 | 4.3 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):


Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 67 ms | 34.0 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 0.5 ms |
| scroll-today | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
