Written by Claude (Claude Code), 21 November 2026.

# Create New screens — iPhone — 21 November 2026

The user, 21 Nov 2026 (Figma section `1061:2015`, "create new components"): update the iPhone app's Create New screens
to the Figma design, **UI only** for now (logic comes later), one screen at a time, in a loop a minute apart. In Figma
every page is a component; in code, build it the production SwiftUI way and write down why
([From Figma to SwiftUI](<../From Figma to SwiftUI — Read the Design, Build It the iOS Way.md>)).

Branch `ios-update`, worktree `Research/Temp/ios-update-wt`. Each screen is checked on the Simulator against a Figma
screenshot of the same variant. Not yet on the real iPhone (U9).

## The user's points

- [ ] 1. Figma's page components become ordinary SwiftUI screens; what was done and why is written below, per screen.
- [ ] 2. Time of Day is gone: a habit's row is **Routine**, and there's **Add a Routine** (New Routine).
- [x] 3. Add a Task opens its own page first, **What Kind of Task?** (Once or On Repeat), then the task form.
- [ ] 4. Making a routine from anywhere (Create New, the habit form, Today, Habit details) goes back to where the
  person was and shows a banner with the routine's name ("“Meds” created · Undo"), nothing else.
- [ ] 5. **All Day** and **Anytime** are built in: several reminders put a habit in All Day by itself, none or one
  leaves it where it is (Anytime by default). Morning, Afternoon, Evening: one choice only.
- [x] 6. How Often's pages: Figma's new spacing.

## The screens, in the user's order

- [x] **What Do You Want to Do?** (`1061:2016`)
- [x] **Quit or Cut Down** (`1061:2101`), with the example chips
- [x] **How Do You Want to Track It?** (`1062:2`)
- [x] **What Kind of Task?** (`1109:2`)
- [x] **Add a Routine** (New Routine: Edit routine `Mode=New`, `4761:33352`, `4761:33668`) and its banner
- [x] **Create new form** (`1065:2597`: seven types, the task's date picker, on repeat, 200 %)
- [x] **Icon picker** (`1074:932`, Icon choice `4748:34294`)
- [x] **Colour** (`1074:161496`)
- [x] **How Often** (`1075:161386`, 15 variants)
- [x] **Routine page** (`4754:46072`) and **Edit Routine** (`830:265`)
- [x] **Reminders** (`1100:2996`) and Allow Notifications? (`1164:344717`, iOS's own alert)
- [ ] **How Much** (`1102:2782`) and **Unit** (`1102:3316`)
- [ ] **How Long** (`1103:3208`), **Steps** (`1104:163327`), **Limit** (`1105:3190`)

## Left for the end of the loop

- [ ] UI tests that read the habit form's old rows: the preview card and sentence (`today-preview`,
  `habit-sentence`, gone), "Time of Day" (now Routine), "How much"/"How often" (title case), the Starts and Ends pages
  (now pickers in the form), the task's Repeat picker (gone), "When you tap +" (off the form, `tap-adds-step`).
- [ ] UI tests that read Create New's old words: the "New" bar title (gone), "Build or maintain", "Quit or cut down",
  "Cut down" (now title case) and the question words (`NewHabitUITests`, `NewFlowUITests` and the others that open +).
  No tests run in the design phase; update them all in one go before the first run.
- [ ] UI tests that read the Reminders page's old words: "Add Reminder"/"Add Another Reminder" (now Add a Time,
  `add-reminder`), "A Notification"/"An Alarm" (now a menu row, values in sentence case), the − remove button (now a
  swipe, or VoiceOver's Delete action), "Reminder Says" as a left label, and the notifications prompt, which now
  comes when Remind Me is turned on (a test that turns it on must answer iOS's alert or start with permission
  granted).

## Left for the logic pass

- [ ] A routine with no set time (Set a Time off). The model still reads a section with no start as Anytime
  (`DaySection.isAnytime`), and `SectionPlan`, `saveSections` and `timedSections` unwrap every other section's
  start, so New Routine's Add waits for the switch until routines have their own "no time" and their place (after
  the timed ones, before Anytime).
- [ ] All Day as a built-in routine, and a habit with two or more reminders going into it by itself. The Routine page
  draws All Day from the reminders alone (`inAllDay`: Remind Me on with two or more times), so its row has no tap,
  and the habit's `parts` keep whatever was chosen before. Once All Day is in the model it becomes an ordinary row.
- [ ] `parts` is still an array (a habit could sit in several times of day); `choose` now writes one value. The model
  and backup format go to one routine in the logic pass (Data Rules for Sync).
- [ ] A one-time task with no date (the form's Date switch off). The model reads a task with no `dueDay` as a
  repeating one, so for now it's saved with its date; the footer already says what No date will mean.

## What was done, screen by screen

### What Do You Want to Do? (`1061:2016`) — done 21 Nov

- **Built as:** the existing `NewItemChoices` screen, an inset-grouped `List` (not Figma's stacked frames): one Section
  for the heading, one card for Build or Maintain, Quit or Cut Down and Add a Task, and its own card for Add a Routine
  (a routine is its own thing, the user, 10 Nov). The list draws the cards, separators and chevrons; we draw none.
- **The heading** ("What Do You Want to Do?", Title 2 Bold) is `PageHeading`, a clear first row with no insets, so it
  sits on the cards' edge at every text size. Not a section header (iOS fades and capitalises those) and not the
  navigation title (Figma's bar has none). `defaultMinListRowHeight` 0 so the list's 44-point minimum doesn't add 16
  under it; `listSectionSpacing(24)` is Figma's 24 between blocks. Every create new page with a heading reuses it.
- **A choice row** is `ChoiceLabel`, shared by the choice pages: the symbol in Secondary Label at Title 3 in a
  24-point column that scales with text (`@ScaledMetric`), the title in Body (was Semibold), one Subheadline line in
  Secondary Label. The list's own row insets, never Figma's 12 (From Figma to SwiftUI).
- **Close** is the glass ✕ (`Button("Close", systemImage: "xmark")`, `.cancellationAction`), as every sheet in the
  app closes; the word Cancel is gone.
- **Gone:** the "N of 5 free habits used" footer (no Plus in the iPhone's designs, 10 Nov). The 6th-habit check
  itself is logic and stays for now.
- **For now, until their own steps:** Add a Task still opens the task form (What Kind of Task? comes next in this
  list); Add a Routine opens the old time-of-day editor (New Routine and its banner are their own step).
- **Checked on the Simulator** (iPhone 17 Pro, iOS 26): light, dark and Accessibility Large against the Figma
  screenshot. Debug launch to reach it: `-uitest -open-new`.

### Quit or Cut Down? (`1061:2101`) — done 21 Nov

- **Built as:** the second question page (`question(_:_:)` in `NewItemChoices`), now the same page as the first:
  `PageHeading("Quit or Cut Down?")`, then one card. The bar has only iOS's back button; the old title is gone.
- **The example** is `ExampleTag`, Figma's Tag: "e.g. Smoking", "e.g. Coffee, 2 a day", Footnote in Label on a
  Secondary System Fill capsule, 8 under the description. iOS has no chip on iPhone and this isn't one: it can't be
  tapped, it only reads, so it's a plain `Text` with a capsule background, inside the row's one accessibility element.
- **Words from Figma:** Quit "Stop completely. Track the time since you stopped."; Cut Down (title case) "Set a
  maximum and log how much." `ItemType.example` now holds only the example ("Smoking"); the tag adds "e.g.".
- **Checked on the Simulator:** light and dark against the Figma screenshot (`-uitest -open-new`, then Quit or Cut
  Down).

### How Do You Want to Track It? (`1062:2`) — done 21 Nov

- **Built as:** the same question page as Quit or Cut Down? (`question(_:_:)`), `PageHeading` then one card of four
  `ChoiceLabel` rows with their `ExampleTag`. No title in the bar, only iOS's back button.
- **Words and symbols from Figma:** Check It Off "Done or not done." (`checkmark.circle`, e.g. Make your bed); Track an
  Amount "How many or how much." (`number`, e.g. 8 glasses of water); Time It "How long, with a timer." (`timer`,
  e.g. Meditate 10 min); Checklist "One habit, several steps." (`checklist`, was `list.bullet.clipboard`; e.g.
  Workout: push-ups, squats). All four are free and carry no badge; each opens its form as before.
- **Checked on the Simulator:** light and dark against the Figma screenshot (`-uitest -open-new`, then Build or
  Maintain).

### What Kind of Task? (`1109:2`) — done 21 Nov

- **Built as:** `taskKinds` in `NewItemChoices`, the same choice page as the habit questions (`PageHeading`, one card
  of `ChoiceLabel` rows with `ExampleTag`). Add a Task now pushes it instead of the task form.
- **Rows from Figma:** Once "On one day, or with no date." (`calendar`, e.g. Pick up parcel); On Repeat "Comes back
  on the days you pick, or a while after it’s done." (`calendar.badge.clock`, e.g. Water plants, every 3 days).
- **Why a page before the form:** once or on repeat is the first thing that shapes a task, as a type shapes a habit,
  so it's asked first (the user, 21 Nov 2026). Each row opens `HabitForm(type: .task)`; On Repeat passes
  `repeats: true`, a new argument that starts the form's `taskRepeats` on. The form still has its old Repeat picker
  until the Create new form step redraws it; that step decides whether the picker goes.
- **Checked on the Simulator:** light and dark against the Figma screenshot; On Repeat opens the form on "On a
  schedule".

### Add a Routine: New Routine (`4761:33352`, `4761:33668`) and its banner — done 21 Nov

- **Built as:** `SectionEditor` (Today/DaySections.swift), redrawn as Figma's Edit routine, Mode=New. A `Form`, so iOS
  draws the cards, separators, the switch and the compact time picker: Name (placeholder "Name", 16 characters), then
  **Time** with **Set a Time** (System Green, off by default as in Figma) and, when on, **Starts**, then **Your day**:
  every routine with its times as they'll be, the new one marked "New". ✕ to cancel, Add to save, title New Routine
  (Edit Routine for a saved one).
- **No Ends picker:** a routine ends when the next one starts (Android A122). The page gives `SectionPlan` the next
  routine's start as the end, so the plan it already had does the rest. The footer says what happens before anything
  is saved: "Ends at 6:00 PM, when Evening starts. Afternoon will now end at 1:00 PM." (or "…, at the end of your
  day."). It replaces the old "Split …?" question: Undo on the banner puts everything back.
- **Section headers** ("Time", "Your day") are `FormHeader`: Subheadline Semibold, Secondary Label, sentence case.
  `Color(.secondaryLabel)`, not `.secondary`: the hierarchical style dims again on top of the header's own grey, so it
  came out lighter than Figma's.
- **The banner:** `CreatedRoutine` (its ID, name and the list as it was) goes back through `onSaved`, and
  `.routineCreatedBanner($created)` floats Figma's Banner ("“Meds” created · Undo") at the bottom of the page the
  person comes back to, for 4 seconds, as the app's other banners do. Undo saves the old list back, so a routine the
  new one cut short gets its times back. It's a modifier each opener attaches, not one app-wide banner, because each
  opener is a different stack (Create New's sheet, the habit form's Time of Day page, Edit Today, Settings' Times of
  Day) and the banner belongs to the page the person is on. Attached on all four; Habit details has no way to add a
  routine yet.
- **Set a Time off can't be saved yet** (see "Left for the logic pass"): Add waits for the switch.
- **Checked on the Simulator:** both variants against the Figma screenshots, light and dark; Add brings back Create
  New with the banner; Undo (tried with the banner held 30 seconds, then set back to 4) removed Meds and gave
  Afternoon back its 12–6. Edit Today's and the habit form's banners are wired but not looked at yet.

### Create new form (`1065:2597`) — done 21 Nov

- **Built as:** `HabitForm`, still one `Form` for every type, now laid out as Figma's seven variants: the name card,
  the type's own card, Routine and Reminders, then Starts and Ends. iOS draws the cards, separators, chevrons, switches
  and compact pickers. `listSectionSpacing(16)` and a 16 top margin are Figma's gaps (iOS's default is about twice).
  Title: New Habit for every habit type (Cut Down too), New Task for tasks.
- **Gone:** the preview card and the sentence under it. Figma's form has neither: each row says what's chosen. The
  sentence's code stays, because the pages the form opens still pin it at their top until their own steps.
- **Name card:** Name, Description (optional) for every type, quit included, then Icon | Colour, two buttons in one row
  with a 28-tall divider, each with its own chevron (`RowChevron`, Footnote Semibold in Tertiary Label, as iOS draws
  a link's). At the accessibility text sizes they stack as two rows, Figma's 200 % variant, chosen from
  `dynamicTypeSize`, never `ViewThatFits` (S10).
- **A row that opens a page** (`screenRow`) is Figma's two-line List item: the setting in Body, what's chosen under it in
  Subheadline Secondary Label, as Settings' rows read. Words: How Much, How Long, Steps, Limit, How Often, Routine,
  Reminders (title case); "Not set yet" and "None yet" until set.
- **Starts and Ends are picked in place:** Starts is iOS's compact date picker (Started for a day in the past); Ends
  is a menu `Picker`, Never or On a Date, in Secondary Label as Figma's value is; On a Date adds End Date under it.
  The two pages they used to open are gone.
- **Quit:** Started (date) and Time (time), two compact pickers on the one moment, footer "The run counts up from
  here. A slip starts it again." No routine, reminders or dates.
- **Cut Down:** Limit and How Often, then Reminders alone (a limit has no routine, 5 Oct), then Starts and Ends. The
  old "It shows on Today under Quit or Cut Down" footer is gone with Figma.
- **Task once:** Date and Time switches, System Green, each with its value under it once on, as Reminders' rows.
  Tapping the value opens the picker in a popover under the row (`popover(arrowEdge: .top)` with
  `presentationCompactAdaptation(.popover)`): the graphical calendar for Date, Figma's `Open=Date picker`, a wheel
  for Time. Turning a switch on opens its picker. The pickers are tinted back to Ink: the switch's green tinted the
  calendar's chosen day. Footer from Figma; with Date off it says the task stays on Tasks (U38).
- **Task on repeat:** How Often and the Time switch in one card, footer "It comes back on the days you pick.", then
  Routine and Reminders, Starts and Ends. Once or on repeat is chosen on What Kind of Task?, so the Repeat picker
  is gone.
- **The bar:** iOS's ‹ while nothing is typed; once something is, the same ‹ (and ✕ when editing) asks Discard
  Changes / Keep Editing first, so nothing typed is lost to a tap (U18). Add as before.
- **Off the form for now:** "When you tap +" isn't on Figma's form; it's How Much's "When you log it" (Figma
  `1102:2613`) and moves there in that step. The Routine row still opens the old Time of Day page until the Routine
  page step.
- **Checked on the Simulator:** Track an Amount (light) against Figma's `Type=Amount`; Task once with its calendar
  popover, choosing the 25th; Checklist and Quit in dark; Cut Down at Accessibility Large (stacked Icon and Colour);
  ‹ after typing asks before discarding. Edit Habit uses the same form and wasn't looked at on its own.

### Icon picker (`1074:932`, Icon choice `4748:34294`) — done 21 Nov

- **Built as:** `IconSheet` (AddHabit/Appearance.swift), still a sheet over the form with its own `NavigationStack`, as
  Reminders' New List opens its icons. ✕ (`Button("Cancel", systemImage: "xmark")`, `.cancellationAction`), Icon,
  and Done (`.confirmationAction`, plain glass with a Semibold word, as Add and Save) in the bar.
- **Picking changed:** a tap moves the ring, Done keeps it, ✕ leaves the icon as it was. It used to pick and close on
  the first tap; Figma's page has ✕ and Done, so a person can look before choosing.
- **Search** is iOS's own `.searchable` drawer, always showing: on iOS 26 it draws Figma's glass capsule under the bar,
  and typing gives the bar to the field and a ✕ (the Rulebook's Active search), with the keyboard's Search key and
  clearing for free. A search finds an outlined icon by its filled one's words (`IconLibrary.filled`).
- **A choice** is `IconChoice`: a 38 circle of Tertiary System Fill with the symbol in Ink at Title 3 (20 pt), and on
  the chosen one the Colour swatch's ring (System Gray 3, 3 wide, 5 outside). The circle scales with text
  (`@ScaledMetric`). The habit's colour isn't used on the page; it shows on the form.
- **The grid** is a `LazyVGrid` of six flexible columns, 8 between rows, inside a `ScrollView` (a lazy grid only in a
  ScrollView, S13; ids are symbol names, S14). Group names are Subheadline Semibold in Secondary Label, 4 in.
- **Icons:** filled and outlined side by side where SF Symbols has both (every name checked with
  `NSImage(systemSymbolName:)` on the Mac). Health, Fitness, Mind and Home are Figma's lists exactly (18, 12, 18, 18;
  "Home and Chores" is now Home). Figma's page is cut where it scrolls, so the groups after them keep the app's icons,
  paired; **Other** now also holds what Figma's four left out (teeth, eyes, yoga, gym, dishes, bins and the rest), so
  no icon a habit's name suggests is missing from the page. VoiceOver says "outlined" on an outlined icon.
- **A habit keeps the style picked** (the Rulebook, 10 Nov): the form shows an outlined heart outlined.
- **Checked on the Simulator:** light against the Figma screenshot (Mind's star with the ring); picked the outlined
  heart, Done, the form showed it; dark with the ring on the saved icon; searched "book" (Mind and Faith and Reflection,
  filled and outlined).

### Colour (`1074:161496`, Colour swatch) — done 21 Nov

- **Built as:** `ColourSheet` (AddHabit/NewHabitView.swift), a sheet with its own `NavigationStack`: ✕
  (`Button("Close", systemImage: "xmark")`, `.cancellationAction`) and the title Colour, no Done. A tap on a colour
  picks it and closes the sheet, because the colour shows at once on the form and one tap is the whole job; Figma's
  page has no Done.
- **Height:** iOS's Medium detent is half the screen, far taller than two rows, so the sheet's height is the grid's
  own (`onGeometryChange`, plus 64 for the bar) through `.presentationDetents([.height(_)])`. iOS 26 floats a sheet
  that isn't full height on glass, 8 in from the sides, as Figma draws it. At large text the grid grows and the sheet
  with it; a `ScrollView` takes over past the screen.
- **The grid** is a plain `Grid` (fixed, 13 colours: no lazy grid, S13), 7 to a row, 12 between rows, 18 at the sides,
  8 on top, 24 below, in the palette's order (Red to Grey).
- **A swatch** is `ColorGrid`'s button: a 34 circle in a 44 touch area. The chosen one has a white checkmark (16,
  Semibold) and a 3 pt System Gray 3 ring 5 outside it, the same ring as the Icon picker. VoiceOver reads the colour's
  name and Selected. A fixed palette, so not iOS's `ColorPicker`.
- **Checked on the Simulator:** light against Figma (Yellow chosen), picked Indigo and the sheet closed with the form's
  Icon and Colour in indigo, dark with the ring on Indigo.

### How Often (`1075:161386`, Day toggle `1075:1966`) — done 21 Nov

- **Built as:** `HowOftenEditor` (AddHabit/HowOftenEditor.swift), still one inset-grouped `Form` pushed from the form's
  How Often row. Figma draws each option as a component with its controls stacked in one frame; here every control is
  its own list row, so the list keeps row heights, insets, Dynamic Type and VoiceOver order. The lines Figma leaves out
  inside a chosen option are hidden per row (the chosen row's bottom line, each control's top line, `inChoice`), and the
  two lines it draws full width (above the dates grid and the wheels) are moved out to the card's edges with the
  separator alignment guides (`FullWidthLine`).
- **Spacing:** no section headers ("Daily", "A number of times" … are gone), 16 between cards and 16 above the first
  (`listSectionSpacing(16)`, `contentMargins(.top, 16)`), the cards Figma groups: Every day + Several times a day;
  Times a week, month or year; On certain days; Every few days, weeks, months; On a date; a task's A while after it’s
  done. Settings sit flush under their choice in Body, no longer indented in Subheadline.
- **Gone, as in Figma:** the sentence pinned at the top (`stickySentence`, and the `sentence` argument), the Next row
  under the set-day rhythms, the footer under A while after it’s done, and the Every N months stepper under On a date
  (every few months on the start date's date is Every few months). The notes for 29–31 and 29 February stay: they only
  show for those dates.
- **On certain days:** Weekdays and Weekends are Small Bordered capsules tinted Ink (Ink at 18 %), Subheadline, 8 apart,
  above the seven days.
- **Day toggle** (shared, so ScheduleEditor gets it too): `WeekdayPicker` is seven 40-point circles, never stretched,
  Tertiary System Fill, chosen Ink with On Ink, no tick badge; at the accessibility sizes the days' names stack.
  `MonthDatePicker` is iOS's graphical date picker's look: the number alone, chosen Body Medium on an Ink circle, 8
  between rows, a plain `Grid` (S13).
- **On a date:** Month | Year; a month's Repeat on is a Pop-up button (`Picker(.menu)`, value in Ink): Dates (the
  grid), The last day, A weekday. A weekday and a year's date are Figma's Wheel picker, one band across two wheels,
  through `WheelPicker` (UIKit's `UIPickerView`: two SwiftUI wheels draw two bands, the Rulebook, 6 Nov): first |
  Friday, November | 21. This removes the old `ViewThatFits` phrase row (S10) and the two Month and Date pop-ups.
  `WheelPicker` now hugs loosely so its band fills the card, 8 in.
- **A while after it’s done:** Days | Weeks | Months (Years only for a task already saved with it), then Again after
  with no unit word, as Figma.
- **CheckRow** lost its own 44-point minimum: inside a list row (15 above and below) it made every checkmark row 74
  tall; now 52-ish for one line, Figma's Checkmark row. Every CheckRow in the app gets it.
- **Left as they were (words come from the model, for the logic pass):** a task's "1 week after it's done" has a straight
  apostrophe (`HowOften.phrase`), and Every few months chosen says "Every month", where Figma says "On the 23rd of every
  month".
- **Checked on the Simulator:** Every day, Twice a day, 3 times a week, Every Saturday, Every other week with and
  without set days, the 21st of every month (grid), the third Saturday (wheel), every year on November 21 (wheel), the
  task's list and 1 week after it's done in dark. Cut down's three "At most" rows weren't opened (only its headers
  changed).

### Routine page (`4754:46072`) and Edit Routine (`830:265`) — done 21 Nov

- **Routine page** (the habit form's Routine row, `timeOfDayRow`): Figma's page component is a plain `Form`, so iOS
  draws the cards, lines and disabled text. One card of Checkmark rows: **All Day** *For habits with several
  reminders*, **Anytime** *For habits with no set time*, then the person's routines by start (`timedSections`) with
  their times; **New Routine** is its own card. No headers, no sticky sentence, no Outcome footer (Figma has none).
  Title Routine. **One choice:** a tap replaces the choice (`choose`), so "Pick one or more" and "Or" are gone.
- **Several reminders** (`4763:36841`): with two or more reminders All Day is ticked, every other row is disabled, and
  New Routine's footer says *It has reminders at several times, so it’s in All Day. With one reminder or none, you can
  choose another.* `CheckRow` now greys both lines to Tertiary Label when disabled (Figma's Enabled=False), read from
  `isEnabled`, so every disabled CheckRow in the app gets it.
- **Add row:** a filled ⊕ in Ink with On Ink, 16 before the words (Figma), not iOS's green: the chrome stays neutral
  (the Rulebook, 5 Nov). `AddRow` is shared, so Add Reminder, Add Step, Create Your Own Unit and Edit Today's Add
  Routine change with it.
- **Hours** on the Routine page are "6:00 AM – 12:00 PM", spaced as Figma and Edit Routine's Your day
  (`Outcome.hours`, used only there).
- **Edit Routine** (`SectionEditor`): Your day marks the routine being edited **Editing** (Figma's Mode=Edit; New
  stays on a new one), and the name's limit line turns red at 16 characters (Figma's Error state), grey before it.
  `TextLimit.note` now says *That’s the most* with a curly apostrophe, so every name field's limit does. Delete
  Routine and the Time=None footer were already Figma's.
- **Checked on the Simulator:** the Routine page in light and dark, one choice (Evening replaced Morning), New Routine
  with a 20-letter name (red line), Edit Routine for Morning from Edit Today in dark (Editing, Delete Routine). **Not
  checked here:** the several-reminders state; it was checked with the Reminders screen (below).

### Reminders (`1100:2996`) and Allow Notifications? (`1164:344717`) — done 21 Nov

- **A plain `Form`**, as the other pages: Figma's page component is iOS's own list. No sticky sentence and no
  Outcome footer (Figma has neither). Sections 24 apart, 16 from the bar.
- **Off:** Remind Me alone, *Reminders are off. Turning on Remind Me asks once to send you notifications.*
- **Allow Notifications?** is iOS's own alert, so nothing is drawn for it: turning Remind Me on asks there and then
  (`remindTurned`, Rulebook U37), where before it was asked only on saving. Not allowed, the switch goes back off and
  the footer says notifications are off, with Open Settings (in Ink).
- **Remind me at:** each time is a row with a clock and the time as its words (Figma `1100:2915`), not a compact
  picker's pill. A tap opens a wheel under it, as Calendar's Starts does, and closes it again; a swipe deletes it,
  as Clock's alarms do, because Figma has no − button (`ReminderTimeRow`; VoiceOver has a Delete action). **Add a
  Time** has a plain `plus` in Secondary Label, as Figma, not the Ink ⊕ of New Routine. Separators start at the words.
- **All Day line:** with two or more times, *You’ve added more than one reminder, so this habit goes in All Day.*
- **How:** Remind Me With and If Not Done, Remind Again are Figma's Menu rows (`MenuValueRow`): the value under the
  name, iOS's up-and-down chevrons, the menu opening from the row (`1100:162805`). **Remind Me With's choices are
  `Toggle`s with two `Text`s and an `Image` as the label's own children:** a `Picker` in a menu, or a `Label` around
  the words, drops the second line (*In your notifications*, *Rings until you stop it*), seen on the Simulator.
  Footer *Not sent on a day it’s already done.* (not for a limit, which has no Remind Again).
- **Reminder Says:** a speech bubble and the field across the row, placeholder *Reminder Says (optional)*; footer
  *Shown instead of the name when names are hidden outside the app.*
- **Checked on the Simulator:** Off, iOS's alert on turning on, On, Add a Time, a time's wheel opening and closing,
  the All Day line, the menu with its second lines, dark, and the Routine page in All Day (ticked, the rest greyed,
  its footer). Not checked: Don't Allow (the switch going back off), and a swipe to delete.

