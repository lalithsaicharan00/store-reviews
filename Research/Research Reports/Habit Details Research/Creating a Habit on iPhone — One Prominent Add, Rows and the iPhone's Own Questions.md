# Creating a Habit on iPhone — One Prominent Add, Rows and the iPhone's Own Questions

Written by Claude (Claude Code), 6 November 2026 (IST). iPhone design loop, screen P: Create new (Figma "IOS app",
page [create new 381:2](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=381-2), components
[1061:2015](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=1061-2015)).

## What people come to these screens to do

To add a habit or a task quickly: a name, perhaps an icon and colour, how often, and Add. Less often they set an
amount, a duration, steps, a limit, a time of day, reminders, a start or an end. Reasoned from first principles: the
frequent path (type a name, Add) must be the shortest and the confirming word must be unmistakable; every other row
is optional and should read as one list of rows, each saying what's chosen.

## What was wrong (the user's points, 6 Nov)

- **Add was two things:** a white plain glass word on some form types (Check it off, Quit, Cut down, Task once) and a
  black Small capsule on others (Track an amount, Time it, Checklist, Task on repeat). The user: "It must be the
  screen's one Prominent action everywhere."
- **The colour swatch was a square** and **Icon | Colour were two half-width cells** (Android's split row).
- **The colour sheet cut its last colour** (7 colours in a row 312 wide that held 6½) and had a drag handle for one
  height.
- **Get reminders on time** was Android's exact-alarm sheet, and the Reminders flows used Android's notification
  question ("Allow Often Enough to send you notifications?" with stacked Allow / Don't allow) and "after a second no,
  Android won't ask again".
- **Every date and time step ended in OK**, the calendars covered their own rows, Ends' calendar couldn't show
  December, and a task's "No date" was a button on Android's date picker.
- **How Long and Limit's time** were Material's Hours | Minutes boxes, and **How Much** and **Limit's amount** used
  Android's number keypad (− · ␣ · , · ✓).
- Titles and buttons in sentence case; captions naming Android's pickers, ←, ⋮, snackbar, radio, Google Play.

## What iOS does for this job

- **The confirming word of a form is the bar's prominent glass button.** iOS 26 draws a toolbar button with the
  confirm role (`.confirmationAction`) as glass filled with the app's tint (Apple's own apps tint it blue; ours is
  Ink, U2). Reasoned from first principles as well: one form, one confirming action, always in the same place and the
  same look, so it's never mistaken for an ordinary word.
- **Form rows are one inset list**: Icon and Colour are two rows (as Reminders' list editor shows colour as a row of
  circles and a symbol); a date is a **compact date picker** in its row (Calendar's Starts and Ends); a menu choice is
  a **pop-up row** with ⌃⌄ (Calendar's Repeat and End Repeat).
- **A task's date is a switch**, as Reminders' Date: on, the row says the day and opens the calendar; off means no
  date (so no special "No date" button on a calendar).
- **A calendar or time wheels popover has no OK**: choosing a day closes the calendar; tapping outside closes the
  wheels (screens B–C, the Simulator).
- **A duration is Clock's wheels** (hours · min) and **a number is typed on the decimal pad**.
- **Notifications are asked once, by the system's alert** ("“Often Enough” Would Like to Send You Notifications",
  Don't Allow · Allow); after Don't Allow, iOS never asks again and the app can only send people to Settings.

## Reminders on time: what the iPhone needs, and what it doesn't

Researched for the user's question whether Android's Get reminders on time (and the battery steps) have an iPhone
version:

- **A scheduled local notification comes at its minute on iOS without any extra permission** (no exact-alarm switch,
  no battery setting). The one thing that holds it back is a **Focus** or Do Not Disturb. So Get reminders on time
  has no iPhone version; the iPhone's only question is iOS's own notifications alert, the first time Remind me is
  turned on (U37).
- **Time Sensitive notifications** (a capability the app adds; no Apple approval) break through a Focus if the
  person allows them for the app. Apple says to use them only for things that need attention now.
- **Critical Alerts** need Apple's approval and are for health, safety and security: a habit app would not qualify.
- **AlarmKit** (iOS 26) lets an app schedule real alarms: it needs `NSAlarmKitUsageDescription` and the person's
  permission (asked on first use or with `requestAuthorization`), rings through silent mode and a Focus, and shows
  Stop (and optionally Snooze) on the Lock Screen and in the Dynamic Island, with countdowns as a Live Activity.
  It is the iPhone's match for Android's "Remind me with: An alarm". Whether it shows full screen like Android's
  alarm screen was not confirmed.
- **Users show** the problem is rarer on the iPhone: a machine keyword scan (not a hand read, and noisy) found
  reviews describing reminders or notifications not arriving in 169 of 337,331 App Store reviews (0.050 %) against
  1,266 of 901,453 Play Store reviews (0.140 %); for example "not getting all notifications" (8420520417) and "I am
  not receiving my notifications even when I have checked they are turned on" (8192947194). Saved in
  `Research/Temp/ios-design-loop/P-reminder-failure-scan.txt`.

Sources: Apple Developer documentation (`NSAlarmKitUsageDescription`, AlarmKit; `UNNotificationInterruptionLevel`),
WWDC25 session 230 ("Wake up to the AlarmKit API"), the Human Interface Guidelines on notifications, and write-ups
on nilcoalescing.com and dev.to (AlarmKit countdowns), read 6 Nov 2026.

## What changed

**Design system:**

- **Glass button › Style=Prominent** (4258:37268): Ink glass with a white Semibold word, as iOS 26 draws a confirm
  action in a bar.
- **Date picker › Month=December** (4259:113261): December 2026 (it starts on a Tuesday), 31 days, none chosen.
- **Duration picker** (4236:2507): the hours and seconds wheels gained the values above the selection; every copy's
  neighbours now follow its value (minutes wrap, "1 hour").

**Create new form, all 10 variants** (1065:2597): **Add is the Prominent glass word** everywhere (fixed width 74 so
**Save** fits on Edit Habit and Edit Task, 10 copies); titles **New Habit / New Task / Edit Habit / Edit Task** and
every page title in Title Case (131 bars); **Icon** and **Colour** are two full rows with a **round swatch**;
**Starts** is a compact date picker (56 rows: "23 Oct 2026") and **Ends** a pop-up row ("Never ⌃⌄", 56 rows); the
quit form's **Started** and **Time** are compact pickers (was Android's Started | At cells); a task's **Date** is a
switch (on: "Today"; off: no date, the Time row goes).

**Choice pages:** **What Do You Want to Do?**, **Quit or Cut Down?** (it repeated the first title),
**How Do You Want to Track It?**, **What Kind of Task?**, with Title Case rows (Build or Maintain, Check It Off,
Track an Amount, Time It, On Repeat…). Their examples ("e.g. Make your bed", "e.g. Smoking") already sat under each
row as a line, not chips, and stay.

**Pickers:** the **Colour** sheet is one height with ✕ only and shows its 13 colours, 7 + 6; the **Icon** page's Done
is Prominent (its icons are the `.fill` symbols wherever SF Symbols has one). **How Long** and **Limit › Time** are
Clock's wheels with quick-pick buttons; **How Much** and **Limit › Amount** have the decimal pad. **How Often** was
already the iPhone's (checkmark rows, steppers, segmented Week · Month · Year, Small Bordered Weekdays / Weekends)
and is unchanged. Reminder time rows lost Android's ✕ (a swipe deletes, as in every iOS list).

**Flows on the page:** the Reminders flows show iOS's alert and its once-only rule (the "second no" screen is gone:
Don't Allow → Remind me back off → Open Settings); the old Get reminders on time section now says why the iPhone
needs nothing more; every calendar and time-wheels copy sits under (or, near the bottom, above) its row; the chosen
days are set (26 Oct, 30 Oct, 25 Dec in December, 20 Oct); OK steps are now "Closes" or "Tap outside"; 64 captions and
28 frame names: ‹, ⋯, banner, checkmark, the calendar, the time wheels, the App Store's sheet.

## Left for the user

1. **Prominent Add here, plain Add elsewhere.** The form's Add (and Save, and the icon page's Done) are now the
   Prominent glass word, as asked. The log and note sheets (B, D) still use the plain glass Semibold word from §3.
   iOS 26 draws every confirm action prominent; making them all Prominent would be one rule everywhere.
2. **Remind me with: An alarm.** On the iPhone this would be AlarmKit (its own permission, rings through silent and
   Focus). Keep it as a choice, or offer notifications only at launch.
3. **Time Sensitive reminders.** Mark reminders Time Sensitive (they get through a Focus the person allows them in),
   or leave them ordinary (a Focus holds them).
4. **How Much's big number.** It's still the large number field in a card; the log screens chose a row (B). A row
   would match them.
5. **Compact pickers at 200 % text** stay beside their label; the log screens' Simulator check showed them stacking
   under the label at accessibility sizes.
