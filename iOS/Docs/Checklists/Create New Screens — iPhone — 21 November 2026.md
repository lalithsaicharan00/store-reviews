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
- [ ] 6. How Often's pages: Figma's new spacing.

## The screens, in the user's order

- [x] **What Do You Want to Do?** (`1061:2016`)
- [x] **Quit or Cut Down** (`1061:2101`), with the example chips
- [x] **How Do You Want to Track It?** (`1062:2`)
- [x] **What Kind of Task?** (`1109:2`)
- [ ] **Add a Routine** (New Routine: Edit routine `Mode=New`, `4761:33352`, `4761:33668`) and its banner
- [ ] **Create new form** (`1065:2597`: seven types, the task's date picker, on repeat, 200 %)
- [ ] **Icon picker** (`1074:932`, Icon choice `4748:34294`)
- [ ] **Colour** (`1074:161496`)
- [ ] **How Often** (`1075:161386`, 15 variants)
- [ ] **Routine page** (`4754:46072`) and **Edit Routine** (`830:265`)
- [ ] **Reminders** (`1100:2996`) and Allow Notifications? (`1164:344717`, iOS's own alert)
- [ ] **How Much** (`1102:2782`) and **Unit** (`1102:3316`)
- [ ] **How Long** (`1103:3208`), **Steps** (`1104:163327`), **Limit** (`1105:3190`)

## Left for the end of the loop

- [ ] UI tests that read Create New's old words: the "New" bar title (gone), "Build or maintain", "Quit or cut down",
  "Cut down" (now title case) and the question words (`NewHabitUITests`, `NewFlowUITests` and the others that open +).
  No tests run in the design phase; update them all in one go before the first run.

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
