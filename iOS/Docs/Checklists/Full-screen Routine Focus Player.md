# Full-screen routine focus player

Written by Codex, 29 September 2026.

## User request, recorded before research and implementation

- [x] Create a new branch, preserving the existing home and creation work: `codex/routine-focus-player`.
- [x] Research routine apps, including Routinery, and actual review evidence before settling the UI.
- [x] Decide whether a whole-routine timer earns its place; avoid two competing clocks when a habit is timed.
- [x] Section Start opens a full-screen, focused, one-thing-at-a-time flow.
- [x] Native SwiftUI components and SF Symbols; clean centered layout, clear hierarchy and polished light/dark appearance.
- [x] Frequent actions are one tap away; less frequent actions discoverable within one or two taps.
- [x] Support check-offs (including repeated checks), counts/custom amounts, timed habits, checklists, tasks and cut-down limits.
- [x] Preserve saved progress, manual logging, timer pause/save on leaving, skipping without completion, next-item preview and honest completion summary.
- [x] Include navigation/revisiting, correction, interruptions and save failures in the design; avoid accidental completion or time loss.
- [x] Build, run focused behavioral UI tests and inspect screenshots at iPhone size, including keyboard and accessibility layouts where relevant.

## Follow-up work requested by the user (after the player)

1. Habit notes; research whether notes for the whole day are needed before designing day notes.
2. Improve section open/close animation beyond the current opacity change.
3. Easy undo feedback after checking/logging (snackbar or a suitable native presentation).
4. Sequence completion feedback: finish the progress-fill/check animation before moving the completed row below unfinished rows. Test repeated goals, especially the final third check, for smoothness and performance.
5. Pause an individual habit; research/design pausing tracking across the whole app.
6. All Habits, archive and delete management.
7. Progress and statistics screens last.

These follow-ups are recorded, not bundled into the player implementation. Player-local correction and transition feedback are in scope.

## Results

### Delivered behavior

Research and source links: [Full-screen Focus Player — One Thing at a Time](<../../../Research/Research Reports/Day Structure and Organization/Full-screen Focus Player — One Thing at a Time.md>). Eight cited review IDs were verified against the local corpus; none missing.

The player uses routine position instead of a whole-routine countdown, because untimed habits have no duration estimates. Timed habits keep their existing count-up clock, pause/resume and manual logging. Checks, amounts, checklists, tasks and limit check-ins share a centered full-screen layout. Completing an item stays on that screen until Next; Undo targets the exact saved entry. The queue supports revisiting and session-only reordering. Limit check-ins never manufacture consumption or a completed day.

Stopping a timer saves elapsed time and removes its running marker in one database transaction. Player navigation waits for successful persistence. Date rollover closes the session against its original tracking day. Backgrounding keeps the timer running.

### Verification

- Core repository and migration tests: 12 passed, including atomic timer-stop persistence and repeated-stop safety (`Research/Temp/focus-player/core-tests.log`).
- Earlier physical iPhone 16 run: 19 passed, covering nine focus-player cases plus routine/calendar, schedule and timer regressions (`device-final.xcresult`).
- Small iPhone SE simulator, light appearance: three focused tests passed, including checklist, accessibility text and the manual-entry keyboard (`small-light.xcresult`). Dark appearance was inspected on the larger simulator (`simulator-v4.xcresult`).
- Final physical iPhone verification passed: **19 tests, zero failures** (`device-verified.xcresult`): 10 focus-player tests, seven routine/calendar regressions and two existing timer tests. This includes the latest accessibility footer/contrast refinements and the original-day/exact-undo persistence check.
- Final screenshots exported to `Research/Temp/focus-player/shots-final/` and visually inspected: amount, checklist, limit, summary, running timer, accessibility text/checklist and manual-entry keyboard. Checklist disabled-action contrast is visible; the accessibility footer puts the next-item preview above Back/Skip; the input and Add action remain reachable with the keyboard open.
- The intermediate simulator run was deliberately stopped when the user asked to release the simulator and use the phone. It is not a completed validation run.
- `git diff --check` passed. Existing uncommitted home/creation work was preserved. No commit was requested or created.

### Scope and follow-up limits

Habit entries and running timers survive process termination; the routine cursor, temporary order and reviewed-limit state are session-only. This iteration does not add routine history or total-session statistics. Save-error handling is implemented; forced storage-failure injection and manual VoiceOver listening have not been performed. The ordered follow-ups above remain separate work.
