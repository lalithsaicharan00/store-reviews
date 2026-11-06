# Inputs and Selection — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: "just because we have something here, doesn't mean we need to use it. Because in iOS it might be completely different component or no component exists at all for that … Try to create best possible input selection chips what we might use in the app rather than just following blindly what we have already."

Figma: file `zLgBjb7M7Fp6UN0pg7J3a8`, section `07 · Inputs & selection` (node `1299:2428`, was Inputs, selection & chips) on the design system page.

## Where each part comes from

- **What it looks like and its sizes:** real SwiftUI controls on the user's iPhone 16, iOS 26.6, in a throwaway app (`Research/Temp/ios-inputs/`, git-ignored). Colours were read from screenshots converted to sRGB.
- **What the app does:** its code (`iOS/Habits/`): `CheckRow`, `WeekdayPicker`, `MonthDatePicker`, `ColorGrid`, `NumberStepper`, `RemoveButton`, `AppSwitchStyle`.
- **The rules for choosing:** Apple's Human Interface Guidelines (toggles, pop-up buttons, lists), read 5 Nov 2026.
- **Cross-checks:** Apple's iOS 26 kit for the switch, stepper and pop-up symbol.

## What's in the section

| Component | Variants | What it is | Measured |
|---|---|---|---|
| **Text field** (`1065:2120`, was Form field) | 12: Position × State | A `TextField` in a list row: no box, no floating label | 52 tall, 16 at the sides, card radius 26, Body, placeholder Tertiary Label |
| **Stepper** (`4081:3569`, new) | 1 | iOS's `Stepper` | 92 × 32 (kit), height and fill from the phone, Tertiary System Fill |
| **Checkmark row** (`4081:2531`, replaces Radio list item) | 8: Position × Selected | A list row with a trailing checkmark, as `.pickerStyle(.inline)` and the app's `CheckRow` draw it | 52 tall; 72 with a line under it |
| **Checkmark** (new) | 1 | The mark alone, for a row that already has other parts | Semibold 17, Ink |
| **Pop-up button** (`4081:3080`, replaces Dropdown field) | 1; Show label on or off | `Picker` with `.pickerStyle(.menu)`: the value in Ink with `chevron.up.chevron.down` | 34 tall |
| **Switch** (`1070:246400`) | 2 | `Toggle` with `.switch`, in System Green | 63 × 28, knob 37 × 24 |
| **Day toggle** (`1075:1966`) | 4: Size × Selected | The app's week and month pickers | Week: capsule 44 tall, gap 2. Date: 40, no fill until chosen |
| **Colour swatch** (`1074:161495`) | 2 | The app's `ColorGrid` | 34 circle in 44, chosen with a 3 pt System Gray 3 ring |
| **Compact date picker** (`4081:3575`, new) | 1 | `DatePicker` with `.compact` | 34 tall, 12 at the sides |

**Deleted:** Checkbox, Radio button, Radio list item, Dropdown field, Filter chip, Assist chip.

## What each Android part became, and why

| Android | iOS | Why |
|---|---|---|
| **Radio list item, and List item with a radio** (298 copies) | **Checkmark row** | iOS has no radio button on iPhone. Apple: a list of options adds "an image — such as a checkmark — indicating that the item is selected". It's what `.pickerStyle(.inline)` draws on the phone |
| **Checkbox** | **Checkmark row** | Apple lists checkboxes only under macOS. Its only use, "At set times of day" (Morning, Afternoon, Evening; pick one or more), is several trailing checkmarks |
| **Dropdown field** | **Pop-up button** | Apple: for "a flat list of mutually exclusive options". No box and no floating label. A row reads Unit, then glasses ⌃⌄ |
| **Two dropdowns side by side** | **Wheel picker** | Replaced 6 Nov 2026: the old app's phrase of two pop-ups ("The first ⌃⌄ Friday ⌃⌄ of the month") is gone. See "Repeat on a date" below |
| **Filter chip, All \| With notes** | **One toggle button, With notes** | "All" is only With notes turned off. Apple: outside a list, "use a button that behaves like a toggle". Off is Bordered, on is Prominent |
| **Filter chip, quick picks** (5 min, 10 min …) | **Button, Small, Bordered; chosen is Prominent** | iOS has no chips; these are capsule buttons |
| **Filter chip, Weekdays, Weekends** | **Button, Small, Bordered** | They act once. The app has them Borderless, but in neutral Ink a borderless button looks like plain text |
| **Assist chip** (Go to date, Today) | **Button, Small, Bordered, with `calendar`** | What the app's own Go to Date is (`HabitPageParts.swift:177`) |
| **− 2 + between words** | **Every, 2 weeks, then a Stepper at the end** | iOS's own control, and how the app does it (`HowOftenEditor.swift:522`). The count is Body Semibold, the unit Secondary Label |
| **A drag handle and a ✕ on a step** | **Red `minus.circle.fill` first, grabber last** | How a `List` in edit mode draws them, on the phone. `RemoveButton` is the same symbol |
| **A dark ring round the field being typed in** | **Removed** | iOS shows focus with the cursor alone |

## Reasoned choices

- **On and off for the switch:** the user asked for iOS's default off and green on. Off is `#3C3C43` at 30 %, which reads `#C5C5C7` on white on the phone; it's a plain paint because no iOS colour name has that job. On is System Green. This is the one exception to the neutral chrome.
- **Prominent and Bordered for a toggle button:** real `.toggleStyle(.button)` draws on as a light tint and off as bare text (tried on the phone). A row of bare text doesn't look like choices, so off stays Bordered. **This is a choice, not what iOS draws.**
- **The check badge on a chosen day is gone.** The app draws a small `checkmark.circle.fill` on each chosen day. Apple's example of a toggle button shows its state by the highlight alone, and dark on light is already plain without colour. The app has the badge until it's rebuilt.
- **A date cell has no fill until chosen,** like iOS's graphical date picker. The app fills all 31, which is heavy.
- **Colour swatches are ours.** iOS's `ColorPicker` chooses any colour, and habits have 13. Seven 44s need a gap of 3 to fit in 328. The app's gap of 10 comes to 368 against a row of 329, so there the grid runs past the row's padding.

## Separators

A list row's separator on the phone is **1 pt** at `#3C3C43` 12 %, inset 16 at both ends: 3 physical pixels, read from the screenshot. The Menu row from section 06 had 0.33, so it was changed to 1.

## What's different on other pages

- **List item (section 08) was still Android's at this point.** It's iOS's now: [Lists and Rows](<Lists and Rows — iOS Native.md>).
- **The ✕ on your own unit is gone** ("prayers" on Unit). The row is a Checkmark row now, and on iOS a list row deletes with a swipe. The app has no remove there at all. The swipe isn't drawn.
- **Step row in section 08 had its own checkbox.** It now has iOS's tick circle: [Lists and Rows](<Lists and Rows — iOS Native.md>).
- **The large typed numbers are Amount field now** (see below). **"Each tap adds"** is still Android's small field.
- **Compact date picker** is the single-value capsule. A row with both a date and a time uses Date and time picker.
- **Keyboards are still Android's,** and the screens are still 360 × 800.
- **Name errors, disabled states and the open menu of a pop-up aren't drawn.** The Stepper has no disabled look at its limits.

## Typing an amount, and picking a date and time (6 Nov 2026)

The user: the amount "has to be the biggest thing in the logging here, and it has to be a separate thing. And it shouldn't change between edits", "the date and time needs to clearly indicate that these are clickable and changeable", and an amount entry "should have focus". Whatever the Log screen does, every amount entry does.

- **Date and time picker:** iOS's `DatePicker` with `.compact` and both components, one row. A real one draws its label and two capsules on one row (tried on the Simulator). Apple's [Pickers](https://developer.apple.com/design/human-interface-guidelines/pickers) page says the compact style shows a button with the value in the app's accent colour. Our accent is Ink, so the capsule is what says it can be tapped. **Editable:** two capsules, 34 tall, 12 at the sides, 4 apart, Tertiary System Fill. **Read:** same place and height, no capsule, Secondary Label. A capsule never appears on something that can't be changed.
- **Amount field:** `iOS/Custom/Amount`, 56 Bold, centred, the unit under it, on a card of its own. **iOS has no focus ring on a touch screen:** focus is the cursor, tinted Ink, with the keypad up, set by `@FocusState` on appear (reasoned from Apple's [Text fields](https://developer.apple.com/design/human-interface-guidelines/text-fields) page and tried on the Simulator). **Typing**, **Empty** (a Placeholder 0 with the cursor before it) and **Read** (no cursor) sit in the same place at the same size.
- **Log screen:** one card holds the habit and When (Finished on a time log); then the main thing is a block with a header, Amount or How long, as Time's block always was; the footer is 8 under its block. Add, View, Edit and Empty have the same blocks in the same places. A check or a slip has nothing to type, so it has no block.
- **How Much and Limit** use the same field, with the Unit pop-up under it instead of the unit's word. Limit's At most is a header above the card, as it is on the Time side.
- **200 % text:** the row stacks and the capsules wrap, and the form scrolls so the amount stays above the keypad.
- **Not changed:** Time's wheels, and "Each tap adds", which is a small value in a list row and can't be the biggest thing on its screen.

## Repeat on a date (6 Nov 2026)

The user, of "The first ⌃⌄ Friday ⌃⌄ of the month": "it's just a line of text … not at all good". Of Month and Day: "why date and month as a separate thing? Because when it comes to a picker, we can have both in one, right?"

**What Apple's apps do, seen on the iOS 26.5 Simulator (Calendar › Repeat › Custom):**

- Frequency is a pop-up row. Monthly shows two checkmark rows, Each and On the…, and the choice opens under its row, in the same card, under a full-width line.
- Each is a seven-column date grid. On the… is **one wheel with two columns**, first | Sunday, 216 tall. It reaches the card's bottom edge.
- Yearly is a month grid: the day comes from the event, so Calendar has no month-and-day wheel to copy. Contacts' birthday didn't open on the Simulator, so it wasn't read.

**What we took:**

- **Wheel picker** (section 07), Weekday and Month and day. One capsule band across both wheels: 34 tall, 8 from the card, radius 17, Quaternary System Fill (`#F4F4F5` on white, measured). The rows sit 31, 58 and 77 from the middle, at 45, 40 and 25 %, sizes 21, 18 and 14, and lean in 8 to 11 towards the middle. Lists don't wrap: Saturday is the last row under Friday, as Calendar's first row has nothing above it.
- **A weekday:** first | Friday, under Repeat on. **Every year:** October | 23, under Month | Year, reasoned from the same control. The Option row's words change with the wheel, so they do the job of Calendar's footer.
- **Repeat on** is a list row, 52 tall, a line inset 16 above it and a full-width line below it. The dates grid sits 12 under that line and 12 above the card's edge.
- **The Repeat on pop-up stays** (the user: "that is good") where Calendar has two checkmark rows.

**For the rewrite:** two `Picker(.wheel)` side by side draw a band each (seen in the probe); one band needs `UIPickerView` with two components in a `UIViewRepresentable`. The Day wheel shows the days the chosen month has.

**Not changed:** the Duration picker keeps its own band (Tertiary System Fill, radius 8), which wasn't compared with Clock on this pass.

## Time of Day: one choice (6 Nov 2026)

The user: "If habit belongs to only one time of the day, section, it only appears there itself. That's it."

Android's page, and our first version of it, had two levels: Anytime or At set times of day, then Morning, Afternoon and Evening with several allowed. The user found two faults: the times can't be seen until At set times of day is chosen, and the second level exists for a rare case. Of 1,574 reviews about sections, 79 (5%) want one habit shown in several.

**What it is:** one card of Checkmark rows, Anytime and every time of day, one ✓, with each row's hours under its name. New Time of Day is `plus.circle.fill` in Ink, in a row of its own under the card, because it's an action and not a choice. A leading circle was tried for choosing several the same day and dropped with the need for it.

**Checkmark row:** it was fixed at 52, so a supporting line had no room. It now hugs: 52 with one line, 72 with two.


## Checked

Looked at by eye: section 07; How often in six states; Limit; How long, also after its ring went; How much; Steps; Unit; New habit; Time of day; New day starts at; History, with and without the filter on; the routine player; Widget setup; Pause; the Colour sheet, also after its gap changed.

Read for all copies: nothing points at a deleted component. Checkmark row has 302 copies placed by hand, 298 from radios and 4 from checkboxes; Pop-up button 9; Stepper 7. Nested copies that held their own words or selection were compared with the Android file (274 rows, 13 different) and restored.

**Not looked at:** every flow screen, Settings beyond one page, Onboarding, Plus. No change was made to the iPhone app, and the throwaway app was uninstalled.

**Not measured:** the stepper's width is the kit's (its edge wasn't read cleanly). The chevron's size was judged from the screenshot: about 11 × 16, so Footnote Medium. A row's 72 with a second line was read from a screenshot, not from the view.

## Checking this in Figma

- **`findAll` can return no copies inside copies, in the same script that found 274 before.** The first swap recorded none, so walk `children` by hand: it's slower (275,000 nodes) and it finds them all. Don't trust a count of 0.
- **A swapped copy keeps its own padding too,** not only its fill and height: all 270 kept Android's 8 and 16, which pushed text out of line with the rows beside them. Set it on every copy after swapping. A filter chip's kept fill made a Prominent button pale.
- **A nested instance's id can change when you hide it,** so setting `visible` and then `name` fails with "node does not exist". Set the name first.
- **Setting `minHeight` on a main is easy to miss:** a variant read 56 while its parts added up to 52.
- **Some nodes live in a slot,** with `parent` of `Content` and no page above it. `findAll` misses them; `getInstancesAsync` finds them, and swapping works.
- **Apple's kit and the phone differ on the switch:** the kit draws 64 × 28 with a 39 knob, the phone 63 with a 37. The phone wins.

**Symbols added this round** (characters of SF Pro, checked by eye, as in [Buttons](<Buttons — iOS Native.md>)): plus.circle.fill U+10004D, minus.circle U+10004E, minus.circle.fill U+10004F, xmark.circle U+100050, xmark.circle.fill U+100051, chevron.up.chevron.down U+10018F.
