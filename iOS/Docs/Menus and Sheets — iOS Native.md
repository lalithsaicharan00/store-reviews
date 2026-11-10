# Menus, Sheets and Feedback — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: "Compared to Android, the menus will be different in iOS … We have like a cross icon in them, and sometimes we only have drag handle. So we need those variations … First of all, check, do we really use a snack bar in the iOS? If we do, then use it. Otherwise, you can remove it … we have curly progress, which is a material design expressive thing … We just need to make it feel like a native iOS progress."

Figma: file `zLgBjb7M7Fp6UN0pg7J3a8`, section `09 · Menus, sheets & feedback` (node `1299:2430`) on the design system page. The Alert lives in "day details components" on the Day details page.

## Where each part comes from

- **What iOS draws:** real SwiftUI on the iPhone 17 Simulator, iOS 26.5, in a throwaway app (`Research/Temp/ios-menus/`, git-ignored): a `Menu`, sheets with each detent and control, `.alert`, `.confirmationDialog`, `ProgressView`, `.redacted`.
- **What the app does:** its code. The routine player's banner (`iOS/Habits/Today/RoutinePlayer.swift`, `feedbackBanner`), the notice on Today (`iOS/Habits/Backup/BackupIssueCard.swift`), the routine list (`.navigationTitle("Your routine")`).
- **Glass:** copied from Apple's kit (Liquid Glass Regular Medium, Light), then checked against the phone.
- **The words on every copy:** read from the Android file, which keeps the same node ids.

## What's in the section

| Component | Was | What it is | Measured or chosen |
|---|---|---|---|
| **Menu item** (`734:73`) | Menu item | A row of a `Menu`. State Enabled, Disabled, Destructive, Selected; Menu has selection True or False | 42 tall, 60 with a subtitle; symbol box 28, label 10 after it, Body |
| **Menu divider** (`734:74`) | Menu divider | A break between sections, inside one panel | 21 tall, 1 pt line, 8 in from the row's ends |
| **Menu section title** (`4137:3463`) | New | `Section("Show")` in a menu | Footnote Semibold, Secondary Label, 29 tall |
| **Menu** (`734:76`) | Menu | The glass panel | 249 wide, radius 34, 10 above and below, 16 at the sides |
| **Sheet drag handle** (`737:14700`) | Drag handle | iOS's indicator | 36 × 5, Tertiary Label, 5 from the top; takes 11, not 48 |
| **Sheet** (`4141:4318`) | Bottom sheet | Controls × Detent, 8 variants | Below |
| **Banner** (`778:444`) | Snackbar | The routine player's banner | Capsule, min 44, 16 at the sides, 12 between, Subheadline, actions Semibold |
| **Placeholder** (`1030:2`) | Skeleton | `.redacted(reason: .placeholder)` | 13 tall for Body, radius 2, black at 16 % |
| **Card notice** (`795:499`) | Card notice | `BackupIssueSection`, in TipView's anatomy | Radius 26, symbol in a 32 box, Headline and Subheadline, one Regular Bordered fix, ✕ (`4198:2551`) only on what can wait, 4 pt `ProgressView` |
| **Alert** (`702:618`) | Dialog | `.alert` | 319 wide, radius 35, two 48 capsules 8 apart; surface `#ECECEC` at 95 %, as a Medium sheet (9 Nov 2026) |

## Menu

- **It opens from the button itself.** Top at the button's top, its outer edge at the button's outer edge, and it covers the button. Measured: a 249 panel at y 62 under a button at y 62. On a screen, a Menu copy goes exactly there; a menu near the bottom stays clear of the Home Indicator and covers its control.
- **Menu has selection = True** gives every row a checkmark column, as iOS does in a menu with a `Picker`: check centre 27.5, symbol 55, label 79.5. Unselected rows keep the column empty.
- **Sections are in one panel.** Android's two stacked menus (the player's ⋯) became one panel with a Menu divider.
- **Gone from Android's row:** Trailing text and the ⌘X shortcut (no such thing on an iPhone). The trailing symbol is a submenu's `chevron.right`, not an arrow.
- **A long label wraps** and the row grows (Move to another day… is 64 at 17 pt). iOS's menu doesn't widen for it.

## Sheet

| Controls | When |
|---|---|
| **Close** | One height: a ✕ and a title |
| **Close and drag handle** | Two heights. iOS shows the handle by itself when a sheet has more than one detent |
| **Drag handle** | Two heights and nothing else to tap |
| **Close and Save** | ✕, title, and a plain glass word at the right (Save, Edit, Done) |

| Detent | What the phone draws |
|---|---|
| **Medium** | Floats on glass, 8 in from the sides and bottom, radius 38. Its surface reads 236 grey with what's behind barely showing, so the paint is `#ECECEC` at 95 %, not the kit's 60 % |
| **Large** | Reaches the sides, opaque System Grouped Background, radius 38 at the top only, top at y 62 |

- **Colours (audit, 9 Nov 2026):** a Medium sheet is the component's glass and nothing else, never a fill on the copy (Your routine had System Grouped Background laid under it, and the player's description sheet was stretched to the edges). A Large sheet is System Grouped Background when it holds grouped rows (measured: `#F2F2F7` with white rows on the Simulator) and System Background when it doesn't (the Timer). Every sheet paint is a colour style; the glass recipe inside Medium (`#262626`, `#ECECEC` at 95 %, its shadow) is the one exception, copied from Apple's kit, which has no style for it. The Medium specimen looks grey only because it sits on the white canvas: over a dimmed screen it reads near white.
- The ✕ is a 44 glass button at 16, 16, and the title is truly centred. **The header is the Navigation bar,** so a sheet's title and a page's are one component.
- **A sheet never has both a ✕ and a Close button.** The description sheet in the player had both; the button went.
- **Your routine and Change order** are Close and Save with Edit or Done, as in the app's own toolbar. Android's left-aligned title went.

## Snack bar: iOS has none

iOS has no snack bar and no toast, and the iPhone app has one thing like it: the routine player's banner. So **Snackbar became Banner**, in exactly that form: a solid capsule on Secondary System Grouped Background with a soft shadow (the code's own note says a material one vanished on the light background), hugging its words, centred, gone after 4 seconds.

Every copy kept its words, so nothing that needs Undo was lost. Two things changed around it:

- **A failure is an alert, not a banner.** Today's "Couldn't save Meds. Nothing changed." with Try again is now an Alert with OK and Try again, which is also what the player does on a failed save.
- **Outside the player the iPhone app has no such banner today.** Confirmations with no action ("Note saved", "Plus is on") are candidates to go when each page is redone, because the change on the screen already says so.

## Card notice

**Redone 6 Nov 2026** (the user: "is this how the native iOS component looks like? … do research about it"). iOS has no notice component: Apple keeps alerts for what's critical, says to show status near what it's about, and draws help in a list as TipView. TipKit itself can hide a tip for good, which is wrong for a problem that's still there, so the card takes TipView's anatomy and stays our own view:

- A list section: a filled symbol in a 32 box (System Red for a problem, Secondary Label for Planned, Paused, Backed up and Plus Is Waiting), then Headline and Subheadline in Secondary Label, lined up with the habit names below.
- **At most one fix,** a Regular **Bordered** button (Ink at 18 %) under the words, never a dark Prominent one beside a second button. Property *Show action*.
- **A ✕ instead of Not Now,** `xmark.circle.fill` at Title 2, Ink at 25 % (the **Close button**, `4198:2551`), only on what can wait. Property *Show dismiss*. A card that only informs has neither.
- The words on every copy are the Android file's (Open Settings, Show Me How, Restore, Resume, Back Up Now).

Why, and the five layouts tried on the Simulator: [Today on iPhone — Notice Card, Edit and Back to Today](<../../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/Today on iPhone — Notice Card, Edit and Back to Today.md>).

**The wave is gone.** The bar is `ProgressView(value:)`: 4 tall, System Fill behind Ink, no end dot.

## Alert

iOS's alert replaces Android's dialog. **Its surface is near solid** (9 Nov 2026): the Simulator's `.alert` reads 238 grey over a dimmed list, and the rows behind don't show through; the kit's 60 % let a habit row's Start capsule and fills show behind the title, so the glass is `#ECECEC` at 95 %, the Medium sheet's recipe. Left-aligned title and message, two capsules, Cancel in Label, the destructive one in System Red (Rulebook D9: two choices only). `.confirmationDialog` on iPhone is a small centred panel with one red action and no visible Cancel; the app's delete questions stay alerts, because D9 wants Cancel in view.

## Other pages

The new components went through every page: Today, Habits & Tasks, Day details, Routine player, Details, Create new, Settings and Notifications. Onboarding, Plus and Widgets have none. Each Menu copy was moved to its button, each Banner centred, each Sheet and Alert resized, and every Alert's and Card notice's words compared with the Android file.

Still Android's, on purpose, for later sections:

- **Linear and Circular progress in section 10** were left for their own section: [Progress, Milestones and Cards](<Progress and Milestones — iOS Native.md>). Only 8 bars were wavy, not the 390 first written here.
- **"Notifications permission dialog (native)"** is Android's system dialog.
- **Frames are 360 × 800.** The phone's are 393 × 852, so a Medium sheet is 344 here.
- **Android's flow names** still say "snack" in a few frames.

## Day details (6 Nov 2026)

- **One height (Large), so no drag handle.** iOS shows the handle only when a sheet has two heights; the ✕ and ⋯ sit 16 from the sheet's top either way (iPhone 17 Simulator). The variants' paddingTop is 11, as Sheet *Close, Large* (`4141:4170`).
- **A full sheet starts at the status bar's foot (y 54)** in the flows, not under the Dynamic Island: 144 copies moved on six pages.
- Its insides: [Lists and Rows](<Lists and Rows — iOS Native.md>), *Day details*. Why: [Day Details on iPhone](<../../Research/Research Reports/Day Structure and Organization/Day Details on iPhone — The Sheet, the Buttons and the Note.md>).

## Choices for the user to judge

- **Banner kept,** rather than deleted, because the app really has it and removing it would lose Undo on many of its 100 or so copies.
- **A banner up to 350 wide on a 360 frame** ("No internet. It backs up once you're online."): it fits the real phone with room, and it's tight only here.
- **Card notice's Small action** on one copy is 2 pt over its row in Figma.

## Checked

- Every Menu 249 wide, every Sheet 344, every visible Menu item 42 or 60 (or 64 where a label wraps).
- Alert and Card notice words on Today, Details and Settings match the Android file.
- No Material word is visible in a symbol's place on any of the 12 pages. Some hidden layers keep one (`today`, `undo`, `auto_awesome`): they don't draw.
- By eye: Today, Habits, Routine player, Details, Create new, Settings.

## Not measured

- **The real iPhone.** All of this is from the Simulator.
- **Dark.** Figma has no dark screens here.
- **A menu row's subtitle.** A `Label` with two texts didn't show one in the probe, so 60 tall and 13/18 are Apple's kit.
- **The menu's open animation** isn't in Figma.

## Checking this in Figma

- **A failed script changes nothing,** so retry freely.
- **`figma.skipInvisibleInstanceChildren` is on,** and `findOne` then misses hidden nodes. Set it false first.
- **A variant added by hand has no property bindings.** The three new Menu has selection = True variants looked right, but their copies showed "Menu item" with the right value in the property: `componentProperties` reports the value while the text ignores it. Compare a row's text with its property, and copy `componentPropertyReferences` from a bound variant.
- **`setProperties` to another variant resets a copy's overrides.** Pass every property together.
- **`combineAsVariants` on a component with a slot keeps copies, their titles and their slots,** but property keys change. A copy with its own slot contents keeps them, so an old header stayed in one Your routine copy.
- **A hidden text's sizing can't be set.** Show it, set FILL and HUG, hide it again; it still reads FIXED while hidden.
- **Android's `minHeight` stays on a component** (Menu item 44) until set to null.
- **A nested instance keeps its old size in new variants** (the drag handle stayed 48).
- **An earlier Button swap had reset words** on Card notice and Dialog to "Manage storage": restore from the Android file. A word in a hidden row isn't a fault, so check a parent's visibility before calling it one.
- **Absolute children of auto-layout frames** need `layoutPositioning === 'ABSOLUTE'` checked, not only `layoutMode === 'NONE'`.
- **A section doesn't grow with its content:** resize it and move what's below.
