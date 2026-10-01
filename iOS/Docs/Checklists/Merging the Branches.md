# Merging the Branches

Written by Claude (Claude Code), 1 October 2026. Branch: `integration` (from `animations-and-settings`).

**Context (the user's words, tidied):** there are a lot of branches; most of the work in them is done, some are dummies. Merge them without losing any of the changes we spent a lot of time on. Then: proceed with the plan, and continue and complete it.

| # | Point | Done |
|---|---|---|
| M1 | Find which branches are real and which are dummies | [x] Real: `animations-and-settings`, `progress-page-research`, `sidebar`, `claude/undo-research`, `claude/habit-tracker-features-igxafl`. Already contained elsewhere: `claude/adoring-dijkstra-3rixv2`, `perf-smooth-app`. Nothing beyond `main`: `claude/vigilant-brown-kqro5t`, `perf-scrolling-and-ci`. `ci-results` is CI's own and is never merged |
| M2 | Lose nothing | [x] Every branch tip saved as `archive/<name>-2026-10-01` on GitHub before any merge (branches, since this environment can't push tags) |
| M3 | Merge the real branches | [x] `progress-page-research`, `sidebar` and `undo-research` merged into `integration`; every conflict resolved keeping both sides' behaviour (below) |
| M4 | The old feature branch (29–30 Sep) | [x] Not merged whole: its Progress, Settings, backup and Undo bar were rebuilt differently since. Its 12 research reports copied; app lock, the review prompt, Siri and Shortcuts, and milestones rebuilt on the current app; its first run already existed. **The Today widget waits** (below) |
| M5 | Test before touching `main` | [ ] Running on GitHub (results below) |
| M6 | Move `main` and delete merged branches | [ ] After the tests, with the user |

## Decisions made while merging

- **The habit page's calendar:** a tap on a day opens that day's sheet (its result and entries; fill in or fix it, from Undo, Build Plan #57). It replaces Progress's read-only popover, which showed less and sat inside the same button, so one of the two never got the tap.
- **Speed tests:** `PERFORMANCE.md` (from `undo-research`, loaded first by the root `CLAUDE.md`) says never to measure through XCUITest, whose screen reading was up to 79 % of the main thread. So `[ios-perf]` is now the app-driven runner (`measure_perf_driver.sh`, `PerfDriver`); the older XCTest speed tests stay as `[ios-perf-xctest]` for screens with no `PerfDriver` scenario yet (Progress, Groups, Backup, Tasks, Reminders). Run workflow can time and profile chosen scenarios (`scenarios`).
- **Speed rules kept from both sides:** the Design Rules' table and `PERFORMANCE.md`; `check_rules.sh` passes.
- **`HabitStore`:** `undo-research`'s caches (calendar, past day totals, streak runs, best streak) kept; Progress's day scoring kept as the one definition of a day; the limit rule (#60b) moved into the new streak structure; `sidebar`'s time-zone and storage fixes kept. Entries changed directly (Log a Slip, logging from a reminder, deleting a habit) now go through `insertEntry`/`removeEntry(at:)`, which keep the per-habit indexes; otherwise counts went stale.
- **Today:** the animations branch's `PartSection` and done-row hold kept; `undo-research`'s inline Undo, day sheet and speed-driver hooks carried into it; its speed driver opens Habits through the ≡ menu.
- **Quit rows:** one way to log a slip, "Log a Slip…" with its time and Undo; `undo-research`'s visible Slipped button opens the same sheet. "Edit Today's Progress…" added from `undo-research`.
- **The New Habit form:** `undo-research`'s typing pause (the previews catch up 300 ms after the last letter) kept; the previews now also catch up when the form is back from a screen it opened, or the name field is left. Found by `HabitCreationUITests`: the pause was cancelled by the pushed screen, so "Enter a habit name" stayed under a typed name.
- **CI:** one Core storage step (both branches added one); `[ios-ci]` runs Today, Timer, Progress, Groups and Undo tests.
- **App lock:** the Face ID usage text was missing on the old branch; iOS ends an app that asks for Face ID without it. Added.

## Not done, and why

- **Today widget:** needs an App Group on the app and its widget extension, in the Apple Developer account and Xcode. Without it registered, Xcode can refuse to install the app on the phone. Another session is renaming the app (`com.oftenenough.app`), and the group's name must match. Research: `Research/Research Reports/Home Screen and Visual Design/Widgets — Tick Without Opening the App.md`.
- **Old tests that predate the merge:** `FocusPlayerUITests` (8 of 12), `RoutineCalendarUITests` (4 of 7), `GoalFlowUITests` (2 of 6) and one `ScheduleUITests` fail the same way on the pre-merge branch (`archive/animations-and-settings-2026-10-01`, run of 1 Oct 06:09): written for the old routine player and form.

## Results (GitHub, 1 Oct 2026)

| Run | What | Result |
|---|---|---|
| 6fa7949 | Whole suite + speed | Builds; Core storage tests pass. The UI job hit GitHub's 60-minute limit after six classes |
| archive base | Focus player, goal flow, habit creation on the pre-merge branch | Same failures as above in Focus player and goal flow (old tests); habit creation 6/6 |
| 3d928ad | Second half of the suite + app-driven speed | Timer, Today, Tasks, Section Header pass; Undo tests still used the old "All habits" button (fixed); habit page scrolling had one 1.5 s stall (being profiled) |
