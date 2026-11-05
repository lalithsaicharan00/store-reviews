# Logging on iPhone — Health's Rows, Compact Pickers and the Decimal Pad

Written by Claude (Claude Code), 6 November 2026 (IST). iPhone design loop, screens B (the log screens: Add log,
the Log view, Edit log, delete) and C (the date picker and the time picker, every copy). Figma "IOS app":
[Log screen 687:829](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=687-829),
[Date picker 705:1025](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=705-1025),
[Time picker 703:602](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=703-602).

## What people come to these screens to do

- **Add a log** they didn't tap on Today: an amount (2 glasses, $50), a time (5 min of stretching), or a slip, often
  for an earlier time or yesterday. The amount is the thing they came to type; the date and time are usually right
  and sometimes need one change.
- **Look at one log** and, rarely, correct it (the amount, the time, the day) or delete it.

Reasoned from first principles, with the earlier evidence in
[Editing One Habit Log](<Day Details and Entry Editor Handoff/Editing One Habit Log — Scope, Fields and Recovery.md>):
the frequent path (type a number, save) must be the shortest; changing the date or time must be possible without
leaving the screen; a delete must be hard to do by accident and easy to find.

## What was wrong

Every part came from Android:

- **Date and Time** were two half-width boxes with chevrons, each opening a Material dialog (a calendar with a
  pencil, Cancel and OK; a typed time input with an AM/PM toggle and a clock icon). The date read "Today, 21 Oct 2026".
- **The keypad** was Android's (− · ␣ · , · ✓ beside the digits). The iPhone's decimal pad has letters under the
  digits and . · 0 · ⌫ at the bottom.
- **Add** was a full-width Prominent capsule above the keyboard; **Delete log | Edit** were two capsules at the
  bottom of the view. The user: "Android patterns".
- **How long** was Material's time-input boxes (Hours | Minutes | Seconds).
- **An empty amount** let Add be tapped and then showed a red line ("Enter more than zero.").
- Edit log's button still said Add.

## What iOS does for this job (seen on the Simulator)

The probe (scratch branch `claude/nice-hopper-dhgw5r-probe`, iPhone 17, iOS 26) rebuilt the screen with SwiftUI's
own parts and read Apple's apps' element trees:

- **Health's Add Data and Calendar's New Event are the native shape**: an inset list; Date and Time as rows whose
  value is a **compact picker** (a grey pill); the value to type as a row with the number trailing; ✕ at the left and
  the confirming word at the right of the bar. Calendar's Done is **off until the event is valid** (the tree reads
  `add-button, label: 'Done', Disabled`).
- **Tapping the date pill** opens the graphical calendar as a popover under the row (month ›, ‹ ›, the weekdays, the
  days; the chosen day an Ink circle). **Tapping the time pill** opens the time wheels (hour · minute · AM/PM) as a
  popover. Neither has OK or Cancel: choosing a day closes the calendar; tapping outside closes the wheels.
- **A duration** is Clock's wheels: "0 hours 5 min" (UIDatePicker .countDownTimer), or three wheels with sec.
- **The decimal pad** comes up with the amount focused.
- **A saved record** reads as rows (LabeledContent: Date Today · Time 2:05 PM · Amount 2 glasses), **Edit** sits in
  the bar, and **Delete Log** is a red row of its own; tapping it asks first (an alert with Cancel and Delete, or a
  popover with the one red action).
- **At large text** the rows stack: the label, then the pill under it.

## What was tried

| Version | What it was | Verdict |
|---|---|---|
| Rows | Health's grammar: Amount as a row, "2 glasses" trailing | **Chosen**: the footer stays above the keypad; one look reads the whole log |
| Big number | A centred 48 pt number card, as before | Slid under the keypad on the iPhone 17; at large text the unit was hidden |
| Duration: Clock's wheel | 0 hours 5 min | **Chosen** (with a sec wheel only on a timer's log) |
| Duration: two wheels | Separate hours and min pickers | Looked like two controls, not one length of time |
| Delete: leading red row / centred red row / red row with a trash symbol | | **Leading red row** (as Contacts; centred is Calendar's; the symbol added nothing) |
| Ask before delete: alert / popover | | Alert kept (two choices, Cancel and Delete, D9); the popover is Apple's other way |

## What changed

**Design system (493:2):**

- **Number pad** (4234:5418): the decimal pad, drawn to the Simulator on the background of Apple's iOS 26 kit
  (the kit's keys use a font weight Figma can't load).
- **Duration picker** (4236:2507): Clock's hours · min · sec wheels; Show seconds; the selected values are
  properties.
- **List item** (528:85): new **Show picker**, a Compact date picker at the trailing edge with its Value exposed, so
  a Date or Time row is one List item. Rows without an icon turn on **Separator from the edge**, so the line starts at
  the text.

**Pickers (day details page), rebuilt in place so every copy kept its place:**

- **Date picker** (705:1025): the graphical calendar popover, 318 × 326, with the four Limit variants (any day; today
  and earlier; tomorrow and later; today and later). Each day is its own cell with its own circle, so a copy chooses
  any day by the circle's opacity.
- **Time picker** (703:602): the time wheels popover, 232 × 204; Hours, Minutes and AM or PM are properties.

**Log screen (687:829), all 8 variants**, a Large sheet over Day details: ✕ · Add Log · **Add** (Semibold glass
word); the habit row; **Date** and **Time** (or **Finished** for a time habit) with compact pickers; **Amount** with
"2 glasses" trailing, typed on the decimal pad; or **How long** on the Duration picker; the footer. Edit is the same
sheet with **Save**. The view: ‹ · Log · **Edit**; Date reads Today or Yesterday; then **Delete Log** (or Delete
Slip) in red. The Error variants are now **Empty**: Add is off and the amount reads a grey 0.

**Every copy (63):** day details 54, Today 6, routine player 3. Titles in Title Case; Edit's button says Save; the
dates, times, amounts, durations (with seconds where a timer's log has them) put back from a snapshot taken before
the rebuild. Two check logs and three Savings copies lost their habit in the move and were put back by hand (from the
Android file, same node ids). A 200 % text frame sits beside the component (4243:334448).

**Every picker copy (35, six pages):** the scrims are gone; the calendar opens under its row and the wheels under
the time pill; the chosen day or time is set (20 Oct, 8:30 PM, 6:00 PM, 8:15 AM, 7:00 AM, 22 and 25 Oct); frame
names say "the calendar" and "the time wheels", and the OK steps are gone ("Closes", "Tap outside"). The captions on
the day details page describe the iPhone's behaviour: no OK; Add waits; later days are grey; a later time turns back.

## Screen D: the note screens (6 Nov 2026)

[Note screen 765:1087](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=765-1087) had the same
Android parts: Gboard (the icon strip, ?123, a dark return key), a Save capsule over it, and Delete note | Edit
capsules on the view. On the Simulator, a note field in a list (a multi-line TextField in its own card, 'Note' as its
placeholder) beat a full-sheet editor like Notes: it reads as the same sheet as Add Log, the habit stays in view, and
Add greys out by itself while it's empty.

Now: a Large sheet, ✕ · **Add Note** · **Add** (Semibold, off while empty; **Edit Note** and **Save** when editing);
the habit as a card; the note's card (200 tall while typing); a footer that names the day ("A note for today,
21 Oct." — a note's day can't be changed); **the iPhone keyboard** from Apple's iOS 26 kit (no accessory bar,
suggestions on, 123, a grey return, as the Simulator showed). The view: ‹ · Note · **Edit**; the habit with **Today**;
the note; **Delete Note** in red. The habit's icon and name layers were moved, not redrawn, and the note text is a
property, so all 21 copies (day details 8, Today 10, routine player 1, details pages 2) kept their words; the two
History copies' footers say their days (Sun, 20 Sep; Tue, 8 Sep). Captions on both pages now say Add turns on,
Delete Note is a red row, and Edit is in the bar.

## Left for the user

1. **Rows or the big number.** Rows were chosen from the Simulator; if the amount should feel bigger, the
   alternative is the 48 pt card (it slides under the keypad on smaller phones).
2. **Ask before deleting: alert or popover.** Kept the alert (Cancel and Delete, D9). iOS 26's own apps more often
   show a popover from the row with the one red action; it can't be misclicked either.
3. **A note's confirm word.** Add (as Add Log) for a new note, Save when editing; the old screen said Save for both.
4. **Date format.** The pill reads "21 Oct 2026" (the file's format); an American iPhone shows "Oct 21, 2026". The
   view says Today or Yesterday as Reminders does.

## Still open (other screens)

- History's Go to date (details pages, 9 frames: 1150:76414 …) and the create-new forms (11) use the new calendar
  and wheels but still show October; their months (September) and chosen days are set when those screens are done
  (K and P).
- The List item's description still begins "Material's ListItem"; it is rewritten with the lists screen.
