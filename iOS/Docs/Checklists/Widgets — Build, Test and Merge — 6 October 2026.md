# Widgets — Build, Test and Merge

Written by Claude (Claude Code), 6 October 2026. The user's request to build every widget from the
[Implementation Spec — Every Widget](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Implementation Spec — Every Widget.md>),
test it thoroughly and merge it into `main`. Current Work item 9 owns the status. Branch:
`claude/widget-implementation-testing-ki9pva`.

## The user's points

The existing widgets are mostly dummy content; reuse what fits, replace the rest.

- [ ] Build the widgets the way the documentation shows them: spacing, type, colours, states.
- [ ] **Lock Screen:** circular one habit; rectangular Today; inline.
- [ ] **Tasks:** a Medium and a Large list.
- [ ] **Weekly Medium:** one habit, this week.
- [ ] **Today lists for habits:** Medium and Large. Two lists exist in the mental model, one for habits and one for
  tasks; they work the same, one shows habits, the other tasks.
- [ ] **Choose what a list shows:** Today by default; touch and hold → Edit Widget → choose a specific section
  instead. For habits (Large and Medium). For tasks it's our call: built the same way (Today by default, or a section),
  because the spec titles a section view "Morning tasks".
- [ ] **Pages:** Large lists page above five items, Medium lists above two, whether Today or a section, habits or
  tasks.
- [ ] **Small single widget,** one per habit, with a way to choose the habit.
- [ ] **Same order as the app:** sections in the order Today shows them (Quit or Cut Down first if the person put it
  first), and inside each section the person's own order. A chosen section keeps that section's order.
- [ ] **Interactive:** what can log in place logs in place (✓, saved +N).
- [ ] **A quantity with no saved number:** if possible, tapping should bring up the log screen straight away instead
  of opening the app and finding the screen. (iOS can't show an input over the Home Screen; the closest possible is to
  open the app directly on that habit's amount entry, one tap, no navigation. Do that.)
- [ ] The same for **steps** (an amount habit counted in steps) and for **quit habits: Record a slip** opens directly.
- [ ] **Timed habits:** ▶ starts the timer (the in-app timer and the Live Activity / Dynamic Island too); ⏸ stops it
  and saves the time.
- [ ] **Look:** clean, easy to understand, minimal but useful, the same aesthetic across Small, Medium, Large and the
  weekly Medium.
- [ ] **Test every widget type thoroughly:** every widget problem users raised in the reviews and Feature Ledger
  cards; performance (S rules); data updating and robustness (D rules).
- [ ] Note everything; when the build is done, cross-check that every point here was implemented.
- [ ] When every test passes, **merge into `main`**.
- [ ] **Test the widgets for reliability** (the user, later the same day): a dedicated stress suite,
  `WidgetReliabilityCheck` (`-widgetreliability`, `WidgetUITests.testReliabilityUnderBurstsRetriesAndRollover`):
  40 widget + 10 app taps in one burst and 120 retried callbacks out of order (exactly 50, all there after a cold
  start); 21 quick ✓ on/off (one tick); 10 quick ▶/⏸ and repeated ⏸ (one session saved); a button drawn before an edit
  (refused); privacy switched on mid-run; an undone tap retried; a habit deleted with taps queued; every row's week and
  done state equal to Progress and Today; 20 overlapping publications (newest on disk, never half written); a
  half-written file, travel and midnight (the new day by itself, yesterday's button refused); a year of history for 12
  habits (size, time, streaks).
- [ ] **Then the app itself, the same way** (the user: "once widgets are completed check app as well"): time zones and
  time-zone travel, bursts of taps, retried and out-of-order callbacks (notification and alarm actions, the Live
  Activity's ⏸), ✓ on/off storms, timer start/pause storms, storms of saves and publications (widgets, reminders,
  backup), a year of history, and midnight / day-start rollover. An app reliability suite on CI, after the widgets
  pass.

## Build notes

- **Kinds** (stable IDs kept where they still fit): `OftenEnough.Item.v1` One habit (Small, Lock Screen circle and
  line); `OftenEnough.Today.v1` Today list (Medium, Large); `OftenEnough.History.v1` now This week (Medium);
  `OftenEnough.Tasks.v1` Tasks (Medium, Large, new); `OftenEnough.LockToday.v1` Today on the Lock Screen (rectangle,
  line). The Icons and History-month widgets are gone (spec §1: icon-only and monthly not built).
- **Data:** `WidgetSnapshot` v2 (`Shared/WidgetSnapshot.swift`), worked out in `HabitStore+Widgets.swift` from the
  store's own functions, so a widget says exactly what Today and Progress say. Each habit's seven days are remembered
  until its data changes (S5); publication still waits 2 s after the last change (S16).
- **Order:** lists follow `todayCards` (Quit or Cut Down wherever the person put it) and, in each card, the person's
  order; done rows sink after the pause when Done Habits is Move to Bottom, and stay with Stay in Place. After a widget
  tap the rows hold still for 1.5 s (`held` / `settle`), then settle (U4, U13).
- **Choosing:** Edit Widget → Habit (one-habit widgets) or Show → Today or a section (lists), by stable ID. A removed
  section says Section unavailable; an archived or deleted habit says Habit unavailable; neither is ever replaced.
- **Buttons:** ✓ toggles the day (a done ✓ unchecks it), +N adds one saved step, ▶/⏸ run the same timer as Today
  (Live Activity and Dynamic Island included). With Appearance → Open Timer Full Screen on (the default), ▶ opens the
  app on the running full-screen timer, as Today's ▶ does; off, it starts in place.
- **Opens directly** (iOS can't show an input over the Home Screen): an amount with no saved step and steps →
  `oftenenough://log/<id>` (Add Entry sheet); a quit habit → `oftenenough://slip/<id>` (Record a slip); a checklist →
  its Day details with the named steps; Choose a habit → the Widgets guide.
- **Not decided here:** paging is per list and size (`kind.family.section`); two identical widgets share a page
  (WidgetKit gives no per-instance ID). The Lock Screen rectangle under App Lock shows Content hidden, not counts:
  item 58 decides.

## Cross-check against the reviews and the Feature Ledger

Each widget problem users reported, and the check that covers it (`WidgetCheck`, `WidgetUITests`, `WidgetSystemUITests`):

| Users reported | Ledger | Covered by |
|---|---|---|
| Blank or grey widget, "0% all the time", stuck on day 1 | C040 | Corrupt/oversized/unknown-version files → Open to update, never blank; seven day frames, tomorrow starts at 0; after seven days, Open to update |
| Widget disagrees with the app; false "all done" | C040 | Values come from the store's own functions; the habit list's count equals the day bar's; quit and limits never "left" |
| Widget ignored the week start | C040 | Weekly squares and day names follow the week-start setting |
| Deleted habit/task still shown; configuration lost | C040 | Deleted and archived habits leave every widget and can't be logged; choices by stable ID; removed section → Section unavailable |
| Wrong content (routine widget showed to-dos) | C040 | Habit lists never show tasks, task lists never show habits |
| Blank on tinted / clear Home Screens | C040 | Accentable icons, fills and buttons; non-colour states (✓, ✕, text); render check in dark; iPhone check (U9) |
| Colour blocks scrambled | C040 | Week squares by position in the week, Progress's own cells |
| Check-off opens the app instead of logging | C023 | ✓ and + log in the app's process from a closed app (system test: cold +1, then read from disk) |
| +1 / incremental widgets removed elsewhere | C023 | +N adds one saved step, stays +N above the goal |
| Streak on the widget | C023 | "🔥 12" on the weekly widget; hidden when streaks are hidden |
| Accidental taps record a day | C040 (report 46), C090 | A done ✓ unchecks that day; retried callbacks never log twice; Record a slip only opens its sheet |
| Destructive reset on a widget | C090 | No reset or delete on any widget; a slip is never logged by a tap |
| Widgets paywalled | C009 | No Plus checks on any widget (the user, 6 Oct 2026) |
| Widget lag | C040 | `widget-publish` and `widget-log` speed scenarios (S2) |
