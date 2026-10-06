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

## Build notes

(Filled in as the work goes.)

## Cross-check against the reviews and the Feature Ledger

(Filled in when the tests are written: each widget problem users reported, and the check that covers it.)
