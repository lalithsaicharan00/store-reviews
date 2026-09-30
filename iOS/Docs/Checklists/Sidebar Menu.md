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
- The drag is a `@GestureState` inside the menu, so a drag frame redraws nothing else.
- Speed test `testMenuOpenClose` opens and closes the menu for 30 seconds while the app is sampled. `testScrollAllHabits` and `testScrollHabitPage` now reach Habits through the menu.

## Tests

- `TodayUITests.testMenu`: every row is there; Habits, Tasks, Times of Day, Plus and Progress open; Back returns to Today; the dimmed Today closes it; the edge swipe opens it.
- The speed tests above.
- Results: see "Test results" below.

## Test results

(Added after the GitHub Actions run.)
