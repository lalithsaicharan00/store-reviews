# Merging the Branches

Written by Claude (Claude Code), 1 October 2026. Branch: `integration` (from `animations-and-settings`).

**Context (the user's words, tidied):** there are a lot of branches; most of the work in them is done, some are dummies. Merge them without losing any of the changes we spent a lot of time on. Then: proceed with the plan, and continue and complete it.

| # | Point | Done |
|---|---|---|
| M1 | Find which branches are real and which are dummies | [x] Real: `animations-and-settings`, `progress-page-research`, `sidebar`, `claude/undo-research`, `claude/habit-tracker-features-igxafl`. Already contained elsewhere: `claude/adoring-dijkstra-3rixv2`, `perf-smooth-app`. Nothing beyond `main`: `claude/vigilant-brown-kqro5t`, `perf-scrolling-and-ci`. `ci-results` is CI's own and is never merged |
| M2 | Lose nothing | [x] Every branch tip saved as `archive/<name>-2026-10-01` on GitHub before any merge (branches, since this environment can't push tags) |
| M3 | Merge the real branches | [x] `progress-page-research`, `sidebar` and `undo-research` merged into `integration`; every conflict resolved keeping both sides' behaviour (below) |
| M4 | The old feature branch (29–30 Sep) | [x] Not merged whole: its Progress, Settings, backup and Undo bar were rebuilt differently since. Its 12 research reports copied; app lock, the review prompt, Siri and Shortcuts, and milestones rebuilt on the current app; its first run already existed. **The Today widget waits** (below) |
| M5 | Test before touching `main` | [x] Every class touched by the merge passes on `integration` (results below); `main`'s one new commit (Cloudflare plugin settings) merged in |
| M6 | Move `main` and delete merged branches | [x] `main` moved to `integration` (fast-forward, 1 Oct, the user's go-ahead). [ ] Deleting the merged branches: this environment can't, list below |
| M7 | Speed: nothing slower after the merge (the user: "performance is the most important thing") | [x] Every regression found is fixed and measured (below). Opening screens and Today's first scroll were slow before the merge too: still to do |

## Decisions made while merging

- **The habit page's calendar:** a tap on a day opens that day's sheet (its result and entries; fill in or fix it, from Undo, Build Plan #57). It replaces Progress's read-only popover, which showed less and sat inside the same button, so one of the two never got the tap.
- **Speed tests:** `PERFORMANCE.md` (from `undo-research`, loaded first by the root `CLAUDE.md`) says never to measure through XCUITest, whose screen reading was up to 79 % of the main thread. So `[ios-perf]` is now the app-driven runner (`measure_perf_driver.sh`, `PerfDriver`); the older XCTest speed tests stay as `[ios-perf-xctest]` for screens with no `PerfDriver` scenario yet (Progress, Groups, Backup, Tasks, Reminders). Run workflow can time and profile chosen scenarios (`scenarios`).
- **Speed rules kept from both sides:** the Design Rules' table and `PERFORMANCE.md`; `check_rules.sh` passes.
- **`HabitStore`:** `undo-research`'s caches (calendar, past day totals, streak runs, best streak) kept; Progress's day scoring kept as the one definition of a day; the limit rule (#60b) moved into the new streak structure; `sidebar`'s time-zone and storage fixes kept. Entries changed directly (Log a Slip, logging from a reminder, deleting a habit) now go through `insertEntry`/`removeEntry(at:)`, which keep the per-habit indexes; otherwise counts went stale.
- **Today:** the animations branch's `PartSection` and done-row hold kept; `undo-research`'s inline Undo, day sheet and speed-driver hooks carried into it; its speed driver opens Habits through the ≡ menu.
- **Quit rows:** one way to log a slip, "Log a Slip…" with its time and Undo; `undo-research`'s visible Slipped button opens the same sheet. "Edit Today's Progress…" added from `undo-research`.
- **The New Habit form:** `undo-research`'s typing pause (the previews catch up 300 ms after the last letter) kept; the previews now also catch up when the form is back from a screen it opened, or the name field is left. Found by `HabitCreationUITests`: the pause was cancelled by the pushed screen, so "Enter a habit name" stayed under a typed name.
- **CI:** one Core storage step (both branches added one); `[ios-ci]` runs Today, Timer, Progress, Groups and Undo tests.
- **Month calendars (found by the merge tests on 1 Oct, not caused by the merge):** the habit page's and Today's calendars kept the weekday letters and the days in one lazy grid with plain numbers as identities, so weekday 1 and day 1 were the same cell and **days 1–6 of every month never drew** (Today's calendar lost its first row). Each cell now has its own kind of identity (`MonthGridCell`). Tests only noticed it on the 1st–6th, when the only tappable days were the missing ones.
- **Old test assertions brought up to date:** New Habit's time-of-day test looked for the routine list the focus player replaced on 29 Sep; LongText's drag became a tap on a row when the distance was a few points, and its form test scrolled Today's list (behind the sheet) instead of the form.
- **App lock:** the Face ID usage text was missing on the old branch; iOS ends an app that asks for Face ID without it. Added.

## Speed after the merge (1 Oct)

Compared with the last pre-merge runs (`undo-research`), measured with the app driving itself (`[ios-perf]`):

- **Habit page scrolling froze 1.4–2.7 s** the first time it scrolled (pre-merge: under 50 ms). A bisect run, leaving out one section at a time, put it on the Over Time charts; a second, on Swift Charts' first layout of the main chart as a whole (selection, either axis and the date bins each took off part). Over Time's bars and By Weekday are now drawn in one `Canvas` pass (`LightBarChart`), with each bar for VoiceOver and the chart descriptor for Audio Graphs.
- **Typing a habit's name rebuilt the whole New Habit form** on every letter (the form read the name for its buttons): the typed text now lives in `TypedName`, read only by the field (68.8 % → 10.6 % of the main thread).
- **A `NumberFormatter` per number** in Today's rows and the habit sentences: made once.
- **Today's clocks ticked under every page from the ≡ menu**: paused while a page covers Today.
- **The habit page's total line walked all history on each redraw**: remembered in the store.
- **Calendars dropped days 1–6** (weekday letters and days shared identities in one grid): fixed for the habit page and Today's calendar.
- **Every chart is drawn in one pass now** (`LightBarChart`, `LightLineChart`): the running total, the 30-day rate and the quit runs chart too. The app no longer uses Swift Charts.
- Still to do, slow before the merge as well (pre-merge runs: All Habits 400–700 ms, habit page 400–750 ms): **opening a screen** stalls 500–1,300 ms (target under 100 ms), and **Today's first scroll** has one 180–440 ms freeze. Not checked on screen yet: the running-total, rate and quit runs charts (no test takes their picture).

Lessons are in `PERFORMANCE.md` (rules 6, 8, 11 and the new 12).

## Second round (1 Oct, evening): onboarding, widgets and the app's name

The user's words, tidied: most of the in-between branches are dummies, made by chats that didn't know what to name a
branch. Onboarding and widgets are finished; analytics and server-sync are still being worked on. The app is
**Often Enough**, its domain **oftenenough.com**, and its IDs follow how production apps name theirs.

| # | Point | Done |
|---|---|---|
| R1 | Back up every branch merged or marked for deletion | [x] `archive/onboarding-and-help-2026-10-01`, `archive/iphone-widgets-2026-10-01`, `archive/free-plan-data-safety-2026-10-01`, `archive/pensive-bardeen-ou4hiw-2026-10-01`, `archive/eloquent-turing-oznzs3-2026-10-01`, `archive/gracious-newton-exo5ow-2026-10-01` |
| R2 | Merge `onboarding-and-help` | [x] No conflicts |
| R3 | Merge `codex/iphone-widgets` | [x] App code merged cleanly; three documents (Build Plan #62/#63, What's Built, this checklist) kept both sides |
| R4 | The app's name and IDs | [x] Merged from `claude/gracious-newton-exo5ow` (also inside `claude/server-and-sync`), using server-sync's final IDs: **`com.oftenenough.app`**, `com.oftenenough.app.liveactivity`, `com.oftenenough.app.uitests`, background task `com.oftenenough.app.refresh`, App Group **`group.com.oftenenough.app`** (widgets). Home-screen name **Often Enough**. The speed script and the widget gallery test use the new ID and name |
| R5 | Tests and speed on the merged code | [ ] Running on GitHub (results below) |
| R6 | Move `main` | [ ] When R5 passes |

**On the iPhone:** a new bundle ID installs as a new app beside the old "Habits" one; the old app's habits stay in the
old app. Export a backup from the old app (Settings → Backup) and restore it in Often Enough, then delete the old app.
Xcode registers the App Group `group.com.oftenenough.app` on the first install (Signing & Capabilities → App Groups if
it asks).

## Third round (1 Oct, night): backup, sync and accounts

The user's words, tidied: merge everything except `analytics` (Codex is still on it) into `integration` and `main`,
so the branches can go; keep this list current. Plan and progress: [Merge and Hardening](<../../../Architecture/Merge and Hardening — Plan and Progress.md>).

| # | Point | Done |
|---|---|---|
| T1 | Merge `integration` into `claude/server-and-sync`, keeping both sides | [x] `b8edab4` (decisions in the plan note: one Backup & Export page, one backup file format, schema 7) |
| T2 | Tests | [x] Server 129, Core (7 migration tests), website, `check_rules.sh`. iOS on GitHub, every class the merge touched: Backup 8/8, Sync, Persistence 4/4, Onboarding 6/6, Today 8/8, Progress 10/10, New Habit 19/19, Habit Creation 6/6, Undo, Timer 2/2, Groups 5/5. Speed: better than `integration` everywhere it was measured, after one fix (lesson L17) |
| T3 | Move `integration`, then `main`, to the result (fast-forward) | [x] 1 Oct, 23:45 UTC |
| T4 | Merge `analytics` (finished, the user, 2 Oct) | [x] `5c895cd`: Info.plist, Privacy, `HabitStore.perform`, the workflow and the lessons kept both sides; the backup events now come from the new Backup & Export page. [x] Tests (Analytics, Backup, Persistence, Onboarding, Sync 23/23; Today, Undo, Timer, Groups 23/23; Release build; analytics contract 101 checks), then `main` (`aca91eb`, 2 Oct 05:00 UTC) |

## Branches to delete (for any agent or person reading this)

This environment can't delete branches on GitHub; delete them there (GitHub → Branches) or with
`git push origin --delete <name>` from a machine that can. Every one is in `main` or kept under `archive/…`, and nothing
should be merged from them.

| Branch | Why it can go |
|---|---|
| `animations-and-settings`, `progress-page-research`, `sidebar`, `claude/undo-research` | Merged into `main` (first round) |
| `claude/habit-tracker-features-igxafl` | Its features rebuilt into `main` (first round, M4) |
| `claude/adoring-dijkstra-3rixv2`, `perf-smooth-app`, `claude/vigilant-brown-kqro5t`, `perf-scrolling-and-ci` | Nothing beyond what `main` already has |
| `onboarding-and-help`, `codex/iphone-widgets` | Merged into `main` (second round) |
| `claude/eloquent-turing-oznzs3` | Superseded by onboarding: its work is in `onboarding-and-help` |
| `claude/free-plan-data-safety` | Research only; every commit is also on `claude/server-and-sync`, whose later edits supersede it (checked 1 Oct) |
| `claude/pensive-bardeen-ou4hiw` | Its one commit is the first of `claude/free-plan-data-safety` (and on server-sync) |
| `claude/gracious-newton-exo5ow` | The rename, now in `main`; also inside `claude/server-and-sync` |
| `claude/integration-check-b` | Temporary: a copy of `integration` so two halves of the tests could run at once |
| `claude/perf-bisect-habit-page` | Scratch: the habit page with one part left out per speed scenario (`PerfBisect`). Never merge it |
| `claude/server-and-sync` | Every commit is in `main` (third round, T3, 1 Oct). The hardening session still pushes there first and moves `main` after each tested step: **safe to delete whenever it's level with `main`** (`git log main..claude/server-and-sync` prints nothing) |
| `claude/serene-wright-mcvmrx` | Nothing beyond `main` (a session's starting branch); already deleted |
| `analytics` | Fully in `main` (third round, T4, 2 Oct); already deleted (gone from GitHub by 2 Oct 12:00) |
| `claude/progress-week-research` | **Keep: in progress.** The Week visual research and five options (2 Oct); not in `main` |
| `claude/progress-week-cards` | **Keep: in progress.** A Week build ("a card per habit, dates bar pinned, no overview or rings") plus the overview and card research; not in `main`, waiting on the user's choice |
| `claude/today-arrange-research` | Report 27 and its checklist (3 Oct); inside `claude/today-edit-mode`, so in `main` with it: **safe to delete** |
| `claude/today-edit-mode` | Arrange Your Day (item 5), tested and merged into `main` (fast-forward, 3 Oct): **safe to delete** once the user has looked at it on the iPhone |
| `claude/weekly-overview-stats-ly55gk` | Its own note says research only, copied to `claude/progress-week-cards`: **safe to delete once that branch keeps it** |
| `integration` | Once nobody works on it: `main` is the same |

**Keep:** `main`, `ci-results` (CI writes its results there) and every `archive/…` branch. Everything else is in
`main` once T4 is done: `analytics` included (its pull request #3 shows as merged then).

## Not done, and why

- **Widgets:** merged in the second round (R3), with the App Group matching the app's new ID (R4). Checks that need a real iPhone are listed in the widget report. See [widget integration and release checks](<../iPhone Widgets.md>) for macOS results and unverified device checks. The original provisioning requirement remains: a widget needs an App Group on the app and its widget extension, in the Apple Developer account and Xcode. Without it registered, Xcode can refuse to install the app on the phone. Another session is renaming the app (`com.oftenenough.app`), and the group's name must match. Research: `Research/Research Reports/Home Screen and Visual Design/Widgets — Tick Without Opening the App.md`.
- **Old tests that predate the merge:** `FocusPlayerUITests` (8 of 12), `RoutineCalendarUITests` (4 of 7), `GoalFlowUITests` (2 of 6) and one `ScheduleUITests` fail the same way on the pre-merge branch (`archive/animations-and-settings-2026-10-01`, run of 1 Oct 06:09): written for the old routine player and form.

## Results (GitHub, 1 Oct 2026)

| Run | What | Result |
|---|---|---|
| 6fa7949 | Whole suite + speed | Builds; Core storage tests pass. The UI job hit GitHub's 60-minute limit after six classes |
| archive base | Focus player, goal flow, habit creation on the pre-merge branch | Same failures as above in Focus player and goal flow (old tests); habit creation 6/6 |
| 3d928ad | Second half of the suite + app-driven speed | Timer, Today, Tasks, Section Header pass; Undo tests still used the old "All habits" button (fixed); habit page scrolling had one 1.5 s stall (being profiled) |
| e753ec6 | Undo, Today, Progress, Groups, Habit Creation + speed | 36 of 37 pass (Undo's calendar test: the missing days, above). Habit page scrolling: longest stall 193 ms (was 1.5 s); opening All Habits 197 ms, the habit page 349 ms |
| 416a8f7 | Undo, Habit Scenario, LongText, New Flow, Placement | Habit Scenario, New Flow, Placement pass; LongText 2 fail (tests, above) |
| 5b8205c | Undo, New Habit, Persistence, Reminders, Backup | Persistence, Reminders, Backup pass; Undo 18/19 and New Habit 36/37 (both fixed above) |
| archive base | LongText on the pre-merge branch | Its form test fails there too (the keyboard's first-use tip covered the field) |
| 4dbd57a | The fixed tests, LongText, Routine Calendar, Today + speed | LongText 3/3, Today 8/8, Undo calendar fixed; Routine Calendar's day tap and the focus player's title still failing (fixed next) |
| c47a1c4 | Every class touched today, in two halves, + speed | **All pass**: New Habit, Today, LongText, Undo, Habit Creation, Progress, Groups, the calendar's day tap |
| 593c376 | Progress tests + the habit pages' speed with `LightBarChart` | Progress 10/10. Habit page scrolling: longest freeze 294 ms (was 1–2.7 s); the weekly-total page 465 ms and opening the quit page 1.2 s, both still on Swift Charts |
| dbb0d3a | The same, with every chart drawn in one pass | Progress 10/10. Scrolling: habit page 210 ms (hitch 15 ms/s, was 108–205), weekly total 45 ms, quit 31 ms |
