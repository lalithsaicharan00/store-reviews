# Day Details, Logs and Notes — 7 October Redesign

Written by Claude (Claude Code), 7 October 2026, from a full-day design session with the user. **Start here.** This
folder holds everything for the redesign of Day details, the log screens (add, view, edit, delete), the note screens,
and every kind of habit and task: this page (what to change in the app, and how), the
[design decisions](<Design Decisions — Day Details, Logs and Notes (7 October).md>) (every decision, its reasons and
numbers, the user's 43 points in order) and [Images](Images/) of every screen.

Status: **designed and accepted for building by the user; not yet built.** The Rulebook changes it needs (U17, U18,
U19, U22; design decisions section 10) still need the user's explicit OK before the Rulebook itself is edited.
Checklist: [Current Work items 59–62](<../../../../iOS/Docs/Checklists/Current Work Checklist.md>).

Figma (editable; the images below are exports of these):
[Water, every screen, three iPhone sizes](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=727-2288) ·
[Every habit and task, one size](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=733-2288).

## Read this first: how to use these designs

1. **They show the layout and the idea, not the pixels.** What is on each screen, in what order, what is grouped, which
   button matters most, and the words. The Figma drawings are hand-made approximations (their toolbar sits almost
   against the top edge, for one). **Build every screen with native iOS components**, let them supply their own
   metrics, and match the layout, the order and the words, not the drawn pixels.
2. **Native components to use:** a `Form` / `List` with inset-grouped sections for the cards; `LabeledContent` rows
   (Habit, Date, Time); `DatePicker` in its compact style for Date and Time; `TextField` with `.decimalPad` /
   `.numberPad` for amounts and times, and a multi-line `TextField` for notes; toolbar items for ✕ (a cancellation
   action shown as `xmark`, accessible name Cancel) and ‹; the main button as a full-width `.borderedProminent` button
   in `.safeAreaInset(edge: .bottom)`, so it rides above the keyboard; Delete as a `role: .destructive` button in the
   plain style (red text, never a red fill); `.alert` for delete confirmations; `NavigationStack` pushes for Log →
   Edit and All logs. SF Pro and SF Symbols only, light and dark, Dynamic Type to the accessibility sizes, a VoiceOver
   label on everything (U1).
3. **Smallest screen first.** Everything must fit the iPhone SE (4.7-inch) with the keyboard up, then adapt: spacing
   grows from a minimum to a maximum on taller iPhones, a note box fills the room above the button, the footer hides
   while typing where space is short, on the SE Date and Time share one row. The numbers are in design decisions
   sections 2–3; read them as relative intent.
4. **Every point the user made**, with its reason, is in design decisions section 0; the back-and-forth on the header
   and the habit is in section 6's decision log. Check the build against both.
5. **The images are dark mode at 6.1-inch** (and the SE and mini for Water). Light mode follows the system colours.

## The pages to update in the app

Each item: where the person is, the code that draws it today, what changes, and the images to match.

### 1. Today → tap a habit or task row → Day details

- **Code today:** `TodayView.swift` (`DaySheet(habit:day:pageLink:)`, around line 97) → `Today/DaySheet.swift`,
  `Today/DayActivity.swift`.
- **Changes:** one **This day** card with the status, the logging buttons in one row (**+1 | Log manually**; a time
  habit **Start timer | Log manually**; one **Mark done** for a check) and the day's note inside it (one or two lines);
  **Today's logs** with at most three rows ("All N logs ›" only with four or more); **Skip today** last, plain, never
  pinned. Tasks: **Mark done**, a **Reschedule** group, no Skip. Button words follow one rule per kind (design
  decisions section 8).
- **Images:** every `… — 1 Day details` in [Images/Every kind](<Images/Every kind/>); states in rows 06, 15 and 16;
  small screens in `Images/Small screens/1 Day details …`.

![Day details, amount habit](<Images/Every kind/01 Amount, daily goal — 1 Day details.png>)
![Day details, task](<Images/Every kind/15 Task, one time — 1 Day details, not done.png>)

### 2. Habit details → History → tap a date → Day details for that date

- **Code today:** `AllHabits/HabitPageView.swift` (`.sheet(item: $openDay) { DaySheet(habit:day:) }`, line 81).
- **Changes:** the same Day details as item 1, for the date tapped. **Its title is that date: "Today" only when it is
  today, "Yesterday" for yesterday, otherwise the date ("Sun, 4 Oct").** The headings and buttons say the day too:
  "Logs for Tue 6 Oct", "Skip this day". (`NoteSheet.dayText` already writes Today / Yesterday / the date: keep it.)
- **Images:** `06 … — 2 Day details, yesterday`, `16 Day states — 3 An earlier day (yesterday)`.

![Day details for an earlier day](<Images/Every kind/16 Day states — 3 An earlier day (yesterday).png>)

### 3. Day details → "All N logs ›" → All logs (new page)

- **Code today:** none (Day details lists every log).
- **Changes:** a page pushed in the sheet: ‹ and the title ("Today's logs", "Checks today", "Slips today", "Logs for
  Tue 6 Oct"); every log of the day, newest first, one line each; a footer with the total. A tap opens the log's view
  (item 4); a check's row keeps its own Undo. No swipe to delete, no add button.
- **Images:** `01 … — 2 All logs`, `05 … — 2 All logs`, `09 … — 2 All logs`.

### 4. A log row → Log (view) → Edit → Edit log; Delete → confirmation

- **Code today:** `DayActivity.swift` (log rows, around line 325) and `DayEntriesSection.swift` → `EntryEditView`
  (titled "Edit Log" / "Edit Slip").
- **Changes:** the row opens a **view** titled **Log** (not "Edit log"): Habit, Date, Time, the amount (or hours,
  minutes, seconds), "Logged with …", and **Delete log | Edit** at the bottom. **Edit** switches to **Edit log**: ✕
  leaves edit mode (asking first if anything changed), the time becomes a picker within the same day, the value is
  focused with the keyboard up, **Save** sits above the keyboard. **Delete log** asks first in a native alert. No
  greyed-out Save anywhere.
- **Images:** `… — 4 Log (view)`, `… — 5 Edit log` (rows 01, 05), `… — 3 Log (view)`, `… — 4 Edit log` (rows 02,
  03, 04, 07), `18 Delete confirmations — 1 Delete log`.

![Log, view](<Images/Every kind/01 Amount, daily goal — 4 Log (view).png>)
![Edit log](<Images/Every kind/01 Amount, daily goal — 5 Edit log.png>)

### 5. Adding a log: one Add screen per kind, everywhere it opens

- **Where it opens:** Day details' **Log manually** (amount and time habits: `DayActivity.logManually` →
  `AddEntryView`); History's **Add** (`HabitPageParts.swift` line 168, `HabitPageView.swift` line 82); a Today row
  (`TodayRows.swift` line 156); a Home Screen widget (`TodayView.swift` line 208, `oftenenough://log`); and the
  **Log Amount / Log Time** screen (`Today/LogProgressView.swift`, from Day details, `TimerScreen.swift` line 47 and
  `RoutinePlayer.swift` line 205; its "Log time manually" / "Log amount manually" buttons at `RoutinePlayer.swift`
  lines 432 and 601).
- **Changes:** one Add screen replaces both "Add Entry" (`AddEntryView`) and "Log Amount" / "Log Time"
  (`LogProgressView`). **"Add Entry" is no longer used: say "log".** The title and the History button say what the
  kind does: **Add log** (amount, time), **Add a check** (a check counted several times), **Mark a day done** (once a
  day, N days a week), **Tick steps** (checklist), **Add slip** (quit). Every one has the same shape: ✕ and a one-line
  title; one card with **Habit · [icon] name**, **Date** (Today + compact picker), **Time**; then the main thing
  (the amount typed with the decimal pad up; HOW LONG in hours, minutes, seconds for time, with the clock row named
  **Finished at**; the steps for a checklist; nothing to type for a check); a footer saying what will happen; the
  filled button at the bottom.
- **Images:** every `… — Add log`, `… — Add a check`, `… — Mark a day done`, `… — Tick steps`, `14 Quit — 3 Add slip`.

![Add log, amount](<Images/Every kind/01 Amount, daily goal — 3 Add log.png>)
![Add log, time](<Images/Every kind/05 Time, daily goal — 3 Add log.png>)
![Mark a day done](<Images/Every kind/08 Check, once a day — 3 Mark a day done.png>)

### 6. Slips (quit habits)

- **Code today:** `Today/LogSlipSheet.swift` (from `TodayRows.swift` line 478, `TodayView.swift` line 209,
  `Progress/HabitPagePhase2.swift` line 171); slip rows → `EntryEditView`.
- **Changes:** **Add slip** in the item 5 shape; a slip row opens **Slip** (view) with **Delete slip | Edit**;
  **Edit slip** changes the time only (the day stays fixed until a slip can move days safely, D7, U19).
- **Images:** row 14, `18 Delete confirmations — 2 Delete slip`.

### 7. Notes: add, view, edit, delete

- **Where they open:** Day details' note row (`DaySheet.swift` `NoteSheet`); Today's swipe, menu and after-log offer
  (`TodayView.swift` line 325, `TodayRows.swift`); the routine player (`RoutinePlayer.swift` line 198); Habit details →
  Notes → **Add note** (`HabitNotesTab.swift`, `NoteEditorView`) and a note row → reader (`NoteReaderView`).
- **Changes:** three screens replace `NoteSheet`, `NoteEditorView` and `NoteReaderView`: **Add note**, **Note** (view)
  and **Edit note**. No habit card; one line under the title with **[icon] habit name** at its start and the date at
  its end (a picker when adding from the Notes tab; plain text otherwise; on the view, "Sun, 4 Oct · 6 of 8 glasses ›",
  which opens that day's Day details); then the note filling the rest of the screen; **Delete note | Edit** at the
  bottom of the view; **Save** above the keyboard when adding or editing.
- **Images:** row 17, `18 Delete confirmations — 3 Delete note`, `Images/Small screens/6–8 …`.

![Note, view](<Images/Every kind/17 Notes — 2 Note (view).png>)

### 8. Words to change everywhere

| Today | Becomes |
|---|---|
| Add Entry, Edit Entry, "entry" | Add log, Log (view), Edit log, Delete log ("log" everywhere) |
| Add 1 glass, Add 20 (a quick step) | **+1**, **+20** (as Today's round button; VoiceOver keeps "Add 1 glass") |
| Log amount manually / Log time manually beside a quick button | **Log manually** |
| …the same, alone | **Log amount** / **Log time** |
| Add 1 glass on a check habit with a unit | **Add a check** (always, for a check counted several times) |
| Pause timer and save time | **Stop and save** |
| Edit Log (the screen a log row opens) | **Log**, then **Edit log** after Edit |
| Cancel (text) on an Add screen | ✕ (accessible name Cancel) |

Update every UI test that taps a renamed label in the same change (T3).

## Building it: the rules that still apply

- **Data (D rules):** a log's day is the chosen day; its time is limited to that day as the app counts it
  (`store.dayBounds`) and never later than now; changing a time never moves a log to another day. `HabitStore.log`
  stamps every log with the moment it was entered today: Add must pass the chosen time, and `editEntry` must allow a
  same-day time change for every log, not only slips. History adds one check at a time (no Times stepper); old
  multi-check logs keep working.
- **Speed (S rules):** typing updates only its field (S11, `DraftTextField`); no `ViewThatFits` in rows (S10; choose the
  side-by-side or stacked buttons from the text size); every new screen and interaction gets a `PerfDriver` scenario
  (T4): All logs, Log view → Edit, Add log for each kind, the note screens.
- **Tests and the phone:** tests once at the end (T7) on GitHub; then the real iPhone in light and dark, large text and
  VoiceOver, at SE, mini and 6.1-inch sizes (U9).

## What is in Images

- [Every kind](<Images/Every kind/>): 58 screens at 6.1-inch, named `<row> <kind> — <n> <screen>.png`, in the order
  of the Figma section: 01 amount daily goal · 02 no unit, week goal · 03 no quick step, month goal, currency · 04 a
  limit · 05 time daily goal · 06 timer running and an earlier day · 07 time week goal · 08 check once a day · 09 check
  several times a day · 10 check week goal · 11 check month goal · 12 check N days a week · 13 checklist · 14 quit ·
  15 task · 16 day states · 17 notes · 18 delete confirmations.
- [Small screens](<Images/Small screens/>): the Water screens at the SE (minimum spacing) and the mini (maximum
  spacing), 16 images, showing how the layout adapts.

These are exports of our own Figma designs (no other app's images, D11).
