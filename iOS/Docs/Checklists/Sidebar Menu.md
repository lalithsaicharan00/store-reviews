# Sidebar Menu (≡) — the User's Points

Written by Claude (Claude Code), 30 September 2026. Branch: `sidebar`.

**Final decision (the user, 30 Sep 2026):** the top-left button is a ≡ menu (sidebar). Everything that isn't used every day lives there, including Progress, Habits (All Habits) and Tasks. This is final; don't reopen it. The research behind it (and the suggestions this decision overrides) is [Navigation, Round 3](<../../../Research/Research Reports/Home Screen and Visual Design/Navigation Pattern/Navigation, Round 3 — The Menu, Filter and Two Ways In.md>).

## The user's points

- [x] Replace the avatar with a ≡ (hamburger) menu
- [x] Put Progress in the menu (it leaves Today's top bar)
- [x] Put My Habits (All Habits) in the menu (it leaves Today's top bar)
- [x] Put Tasks in the menu: all the tasks the user has created
- [x] Put everything else in the menu too (the settings rows)
- [x] The most-used places at the very top
- [x] Structure and arrange everything properly; proper names for each row
- [x] Pages that exist are wired up (Habits, Tasks, Times of Day, Plus); pages not built yet open a simple "coming" page. Nothing new is built beyond the wiring
- [x] Everything still works after the move (All Habits, the habit page, archive, delete, reorder)
- [x] It feels native: iOS parts, iOS motion, VoiceOver, Reduce Motion
- [x] No speed problems: Today doesn't redraw while the menu opens, closes or is dragged
- [x] Looks good
- [x] Tested on GitHub Actions (UI tests and speed tests)
- [x] The branch is named `sidebar`, so other agents and the user can find it
- [x] Recorded as final, by adding to the docs, never by rewriting what's there

## What was built

- **≡ at the top left** (`line.3.horizontal`, VoiceOver "Menu"). Today's top bar is now ≡ · Filter · +.
- **Filter's icon** is `line.3.horizontal.decrease.circle` (Apple Mail's filter), so it doesn't look like ≡ (Round 3, finding 5). Filter still does nothing yet.
- **The menu slides in from the left over Today**, about 84% of the width (at most 360 points), with Today dimmed behind it.
  - Opens with ≡, or with a swipe from the left edge of Today. The edge swipe works only on Today itself: on any pushed page the same swipe means Back.
  - Closes by tapping the dimmed Today, dragging the menu left, choosing a row, or VoiceOver's escape (two-finger Z).
  - With Reduce Motion on, it fades instead of sliding.
- **Rows, most used first** (plain monochrome icons: colour is for habits only):

| Group | Row | Opens |
|---|---|---|
| Places | Today | Closes the menu (Today is where you are) |
| | Progress | A "coming" page (the Progress research is still running) |
| | Habits (with a count) | All Habits, now for habits only: Habits · Quitting · Archived |
| | Tasks (with a count) | The same screen for tasks only: Tasks · Archived |
| Your day | Times of Day | The Times of Day list, pushed (the same list as "Edit Times of Day" on Today) |
| | Reminders | Coming |
| | Appearance | Coming |
| Your data | Backup & Export | Coming |
| | Privacy | Coming |
| Plus | Plus ("N of 5 free habits used" on the free plan) | The Plus page |
| Help | Help & Feedback | Coming |
| | About | Coming (shows the version) |

- **Every row pushes its page onto Today's own navigation stack,** so Back and the edge swipe return to Today. The habit page still opens from Habits and Tasks.

## Speed

- The menu's open state lives in `MenuModel`, and Today never reads it. Opening, dragging and closing the menu redraw only the menu and the dimming, never Today's list.
- The drag lives in `MenuModel.drag`, which only the menu layer reads, so a drag frame redraws nothing else.
- The menu's rows exist only while it's open or moving (`MenuModel.mounted`): a closed menu does no work, even when a tap on Today changes the counts it shows.
- Speed test `testMenuOpenClose` opens and closes the menu for 30 seconds while the app is sampled. `testScrollAllHabits` and `testScrollHabitPage` now reach Habits through the menu.

## Tests

- `TodayUITests.testMenu`: every row is there; Habits, Tasks, Times of Day, Plus and Progress open; Back returns to Today; the dimmed Today closes it; the edge swipe opens it.
- The speed tests above.
- Results: see "Test results" below.

## Test results

**Run 1** (`4d12f28`, [run 26](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36695561508)): build passed; TimerUITests (2), `testTodayScreen` and `testBackToToday` passed; all six speed tests ran. **`testMenu` failed** at "Today closes the menu": the rows still existed after closing. The menu *was* closed (off screen), but `accessibilityHidden` doesn't reach inside a `List`'s cells, so VoiceOver could still land on the off-screen rows. **Fixed:** the rows are made as the menu opens and removed once it has closed (`MenuModel.mounted`).

Speed, run 1 (the simulator on GitHub's Mac, a year of history): `testMenuOpenClose` main thread 12.5 % busy with 0.8 % SwiftUI redraw, and none of Today's code among the busiest functions, so **Today doesn't redraw under the menu**. The other screens are in line with earlier runs: Today scroll 3.0 %, Today taps 21.3 %, Habits scroll 7.9 %, habit page 2.3 %, calendar 17.8 %.

**Run 2** (`d91ac70`, [run 30](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36698742564)): the closing check now passes. **Speed: opening and closing the menu went from 12.5 % to 2.2 % main thread busy** (redraw 0.7 %), because a closed menu no longer does any work; the other screens stayed in line (Today scroll 4.6 %, Today taps 22.5 %, Habits scroll 5.3 %, habit page 4.2 %, calendar 13.8 %). `testMenu` then stopped at "back on Habits" after a habit's page: the test tapped the first button in the navigation bar, which on the habit page isn't Back. **Fixed in the test:** it taps the Back button itself (or uses the system edge swipe).

**Run 3** (`5246bce`, [run](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36701896598)): still "back on Habits". The screen tree the test recorded showed why: the habit's page had **never opened**. Tapping a row in Habits *selected* it ("Selected" in the tree) instead of opening its page, because the list always had multi-select on and each row's tag is the same ID its link opens. This is an app bug from All Habits (`f691c38`, before the menu), hidden because the checks looked for the habit's name, which the list row also shows. **Fixed:** selection is on only while Select is; `testMenu` and the habit-page speed test now wait for the page's own title bar. (So the "Habit page" speed numbers in runs 1 and 2 were really the list.)

**Run 4** (`64009fb`, [run](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36703998046)): **all green.** Build passed; all 5 UI tests passed (`testMenu`, `testTodayScreen`, `testBackToToday`, both TimerUITests); all 6 speed tests ran. Speed: menu open and close 4.0 % main thread busy (0.8 % redraw), Today scroll 7.1 %, Today taps 10.0 %, Habits scroll 5.3 %, the habit page (now really the page) 6.9 %, calendar 10.2 %. Opening Habits from the menu took about 2 s and the habit page 2.5 s, including the test's own checks.

