# iOS Native — Design Loop Notes

Written by Claude (Claude Code), 6 November 2026 (IST). The iPhone design loop's dated sections for the
`iOS/Docs/… — iOS Native.md` docs. Those docs (Colours, Text Styles, System Bars, Buttons, Navigation, Inputs, Lists
and Rows, Icons, Menus and Sheets, Progress and Milestones, Onboarding) weren't in git when the loop started, so each
section below is headed with the doc it belongs to; move it there once the docs are pushed. Progress:
[iOS Design Loop — Progress](<Checklists/iOS Design Loop — Progress.md>).

## Buttons — iOS Native · 6 Nov 2026: the Clock button (screen A, the timer)

- **Where a clock runs, the buttons are Clock's**: a round button, an 80 disc inside a 2 pt ring, 90 across, one word
  in Body Regular (Figma: Clock button 4228:2548). Neutral (Secondary System Fill, Label) for the secondary action
  (Log Time); Prominent (Ink, white) for Start, Pause and Resume; Done (the habit's colour, white) for Pause once the
  goal is met (A91). Never a capsule pair under a running clock.
- **Its word doesn't grow with Dynamic Type past Body** (as Clock's): at Accessibility 1, "Log Time" overflowed the
  circle on the Simulator. VoiceOver reads the word.
- Two at most, at the screen's two sides, 28 from the edges and 12 above the Home Indicator's area.

## Progress and Milestones — iOS Native · 6 Nov 2026: the Timer ring (screen A)

- **A running habit's clock sits inside a ring** (Figma: Timer ring 4228:2551): 260 across, 10 thick, round ends,
  the habit's colour on its Fill, clockwise from the top; inside, the habit's filled icon (28, the habit's colour),
  the clock in SF Pro Light 64 with tabular figures, and the goal (Body, Secondary Label). Full at the goal; the clock
  keeps counting.
- **iOS has no wave**: a running clock shows it's running by counting; paused says "Paused" under the ring.
- **A limit's ring is System Gray on Gray Fill** (A41), never the habit's colour, never red; its icon keeps the
  habit's colour. Past the limit the line under it says "Over the limit".

## Navigation — iOS Native · 6 Nov 2026: a word action alone in the bar

- The Navigation bar's shared symbol capsule now shows only with Action 1 (Action 2 needs Action 1), so a bar whose
  only trailing item is a word (Day Details) puts the word at the trailing edge, 16 in, with no empty slot. Checked:
  no copy used Action 2 without Action 1.

## Menus and Sheets — iOS Native · 6 Nov 2026: the timer is a Large sheet

- The timer on its own opens as a **Large sheet** (from y 54, System Background, radius 38 at the top) over Today or
  over Day details: ✕ at the left (16 from the top and side), the habit's name with the day as the subtitle, and
  **Day Details** as a word at the right, which opens that day's Day details over the timer. ✕ or a swipe down puts
  it away; the clock keeps running (Today's row and the Live Activity keep it).

## Inputs — iOS Native · 6 Nov 2026: dates, times, amounts and durations (screens B and C)

- **A date or time in a form is a compact picker** at the trailing edge of its row (List item › Show picker): a grey
  pill reading "21 Oct 2026" or "2:05 PM". Date and Time are two rows of one section (a time habit's is "Finished").
- **Tapping the date** opens the calendar popover under the row (Date picker 705:1025): the chosen day an Ink circle,
  today Ink Semibold, days outside the limit Tertiary Label. Choosing a day closes it; **no OK or Cancel**.
- **Tapping the time** opens the time wheels popover under the pill (Time picker 703:602: hour, minute, AM or PM).
  Tapping outside closes it. A time later than now can't be chosen: the wheel turns back.
- **An amount is a row** ("Amount … 2 glasses", the number in Label, the unit in Secondary), typed on the **decimal
  pad** (Number pad 4234:5418), never Android's keypad. Money puts the symbol first and drops the unit ("$50").
- **A duration is Clock's wheels** (Duration picker 4236:2507): hours · min, and sec only on a log that has seconds.
- **Nothing typed yet: the confirming word is off** (Tertiary), as Calendar's Done; no red line under the field.

## Lists and Rows — iOS Native · 6 Nov 2026: rows without an icon, a saved record, Delete

- A row with no leading icon turns on **Separator from the edge**, so its separator starts at its text (16).
- **A saved record reads as rows**: the label at the left, the value trailing in Secondary Label (Date says Today or
  Yesterday). Edit is a word in the bar.
- **Delete is a red row in a section of its own** at the end ("Delete Log", "Delete Slip"), never a capsule; it asks
  first with an alert, Cancel and Delete (D9).

## Menus and Sheets — iOS Native · 6 Nov 2026: adding a log

- Add Log, Add Slip and Edit Log are a **Large sheet** over Day details: ✕ at the left, the title, and **Add** (or
  **Save**) as a Semibold glass word at the right; never a Prominent capsule above the keyboard. Alerts ask before
  discarding typed changes ("Discard this log?", Keep Editing · Discard).

## Inputs — iOS Native · 6 Nov 2026: a note, and the letters keyboard (screen D)

- **A note is a multi-line text field in a card of its own** in the sheet (Body, 'Note' as the placeholder in
  Tertiary Label), 200 tall while typing; the view shows the whole note in its card.
- **The letters keyboard is the iPhone's**: Apple's iOS 26 kit keyboard (Type Default), resized to the frame,
  accessory bar off, suggestions on, **123** at the bottom left and a **grey return** (Type Return, not
  Return-Prominent), as the Simulator shows for a multi-line field. Never Gboard's icon strip or ?123.

## Navigation — iOS Native · 6 Nov 2026: a title menu with its count (screen E)

- A screen whose title opens something (the routine player's Morning, which opens Your routine) is a **title menu**:
  the title in Headline with a small chevron.down, centred, and its count under it in Caption 1 Secondary
  ("1 of 3", "Yesterday · 1 of 3"). Never a pop-up button's up-down chevrons pushed to the left, and no second row of
  progress.

## Buttons — iOS Native · 6 Nov 2026: Day Details, and words in a bottom bar

- **Day Details** opens a day's details from a page about one habit: a Small Bordered button with the word, no
  calendar symbol and never a chip that names a day ("Today").
- In a bottom bar, the main action keeps its **word** in a Prominent capsule (Mark Done, Start, Next); the iOS bar
  draws a Label as its symbol alone, which is too little for the main action.

## Navigation — iOS Native · 6 Nov 2026: Habits and Tasks, and a period (screen G)

- **Habits and Tasks are a title menu**, Habits ⌄ (Navigation bar › Text=Title menu): ☰ at the left (a place in the
  menu, as Today), search and + at the right. Never ‹ on a menu place, never a segmented capsule squeezed between
  them.
- **A period you step through lives in the bottom bar**, as Today's day does: ‹ 18–24 Oct ⌄ › (Bottom toolbar,
  ring and count off), › off on the latest period. Nothing sticks to the top while scrolling; Back to This Week
  floats above the bar as the plain glass button.

## Menus and Sheets — iOS Native · 6 Nov 2026: empty states

- **Every empty or waiting page is a ContentUnavailableView** (4252:428521): the symbol (48) in Secondary Label with no
  shape behind it, the title in Title 2 Bold and Title Case, the description in Subheadline Secondary, then one Large
  Prominent button.

## Inputs — iOS Native · 6 Nov 2026: the letters keyboard everywhere; no results (screen H)

- **Keyboard · letters (native)** (990:251) is Apple's iOS 26 kit keyboard, cropped to 260 so screens keep their
  place: every letters keyboard in the file is now the iPhone's.
- **A search with no results is iOS's no-results view** (ContentUnavailableView with the magnifying glass): "No
  Results for “yoga”", a line, and one Large Prominent button when there's something to do (Add “yoga”).
