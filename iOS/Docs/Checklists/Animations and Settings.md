# Animations and Settings — the User's Points

Written by Claude (Claude Code), 1 October 2026. Branch: `animations-and-settings` (made from `progress-page-research`, which already has the ≡ menu). Build Plan #58, #59 and part of #61.

Other sessions are working at the same time: Progress on `progress-page-research`, the ≡ menu's Backup, Tasks and Reminders on `sidebar`, undo on `claude/undo-research`. This branch doesn't touch their pages.

## The user's points (1 Oct 2026)

| # | Point | Research | Built | Tested |
|---|---|---|---|---|
| 1 | Make a separate new branch for this work | — | [x] `animations-and-settings` | — |
| 2 | **#58 Completion animation:** research it from reviews: find what people like and what they complain about, and pick the best | [x] report §1–2 | [x] | [ ] |
| 2a | It must be delightful | [x] | [x] pop, sweep, haptic, optional chime | [ ] |
| 2b | Most important: it must be fast and use little work | [x] | [x] transforms only; one settle per pause | [ ] |
| 3 | **#59 Section open and close animation:** it must look good and be fast | [x] report §3 | [x] `PartSection`, `FoldBox`, `Motion.fold` | [ ] |
| 4 | **#61 Settings: theme** | [x] | [x] ≡ → Appearance | [ ] |
| 4a | **Day start** | [x] | [x] ≡ → Day and Week | [ ] |
| 4b | **Week start** | [x] | [x] ≡ → Day and Week | [ ] |
| 4c | Research: should the app follow the phone's 12- or 24-hour clock, or have its own setting? | [x] follow the iPhone | [x] checked: no fixed formats | — |
| 4d | Research: daylight saving: does it need a setting or handling? | [x] handling, no setting | [x] wall-clock `today()` fix | [ ] `SettingsCheck` D3, D4 |
| 4e | Go through the ledger cards for small but important things people need in settings, and build them too | [x] C069, C080, C170, C038, C171, C226, C255 | [x] Done Habits, Haptics, Sound | [ ] |
| 5 | Schedule a message to continue in 3 hours if not finished | — | [x] fires 03:00 UTC, 1 Oct | — |
| 6 | Test everything thoroughly for speed and reliability | — | — | [ ] |

## Notes as the work goes

- **Research** (1 Oct): [Ticking Off, Folding and Small Settings — What People Need](<../../../Research/Research Reports/Home Screen and Visual Design/Ticking Off, Folding and Small Settings — What People Need.md>). 140 animation reviews and 243 row-movement reviews read in full; 38 IDs and quotes verified.
- **Found in the code:** (1) a done row held for "Add note" jumped down at the moment the next row was tapped, so the list moved under the finger; (2) a part folded the instant its last habit was ticked, cutting off the fill and ✓; (3) the success haptic fired when changing the day (it followed `done`, not the tap); (4) `today()` subtracted hours from the moment, an hour off on daylight-saving nights; (5) every `HabitRow` redrew on every Today redraw because of a fresh `Binding` for checklist steps.
- **Built:** `TodayLayout` (hold, settle, fold boxes), `PartSection`, `TickFeedback`, `Motion`, `ProgressFill` as a transform, ≡ → Appearance, ≡ → Day and Week, `HabitStore.setDayEnd/setWeekStart`, the chime `Settings/Tick.wav` (made for this app, 0.42 s).
- **Left for later, with reasons:** app-icon badge (needs the `sidebar` branch's reminder work), in-app language (iOS has it per app; the app is English only), text size (Dynamic Type), hiding done habits (it would hide what "N left" counts down), a day that ends after noon (needs Times of Day reworked).
- **Noticed, not changed:** `store.calendar` is the iPhone's calendar, so a phone set to the Buddhist or Japanese calendar stores different year numbers in `LocalDay`. The `perf-smooth-app` branch moves day arithmetic to the Gregorian calendar; that branch should settle it.
- **Tests:** `TodayUITests` `testDoneRowWaitsForThePause`, `testDoneRowStaysInPlace`, `testFoldAndOpen`, `testDayWeekAndAppearance`, `testSettingsChecks` (`-settingscheck`: daylight-saving nights in New York, week starts, saving); `testMenu` now expects the Day and Week row. Speed: `PerformanceUITests` `testTickRun`, `testFoldToday`.

## Test results

**Run 78** (`4192beb`, [run](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36796303885)): **build passed.** New checks passed: `testSettingsChecks` (both daylight-saving nights, week starts, saving), `testDayWeekAndAppearance`, `testDoneRowStaysInPlace`, `testFoldAndOpen`, and `testMenu` with the new Day and Week row; `testTodayScreen`, `testBackToToday`, both TimerUITests and all 10 ProgressUITests passed too. **`testDoneRowWaitsForThePause` failed** on timing: GitHub's simulator took more than 1.5 s between the two taps, so the rows had already settled when the test looked. Fixed in the test (a debug-only `-today.settlePause 8`), not by changing the app's 1.5 s. Two GroupsUITests failed (`testFirstGroupFromFilter`, `testEditRenameDeleteAndEmptyDay`) exactly as on `progress-page-research` `54ad3f4`, the commit this branch started from; the Progress session is fixing them there.

Speed baseline to compare with (`progress-page-research` `aa4e230`, 30 Sep): Today taps 19.2 % main thread busy, 2.4 % redraw.
