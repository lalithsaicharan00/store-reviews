# Lists and Rows — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: "work on these properly, and take care of each and everything … check like how reminders or any other apps that we have Apple's own apps. Check that. How do they do that?"

Figma: file `zLgBjb7M7Fp6UN0pg7J3a8`, section `08 · Lists & rows` (node `1299:2429`) on the design system page.

## Where each part comes from

- **What a list and a swipe draw:** real SwiftUI lists and Apple's Reminders on the iPhone 17 Simulator, iOS 26.5, in a throwaway app (`Research/Temp/ios-lists/`, git-ignored). A row's heights were read from the phone in section 07.
- **What the app does:** its code (`iOS/Habits/Today/TodayRows.swift`, `Components/Components.swift`).
- **What the user approved:** the Undo and Note concept, left Skip and right Note, and the spacing of the habit card.

## What's in the section

| Component | Variants | What it is | Measured or chosen |
|---|---|---|---|
| **List item** (`528:85`) | 16 | A row of an inset-grouped `List` | One line 52, two lines 72, card radius 26, symbol column 24, text at 56 |
| **Habit row** (`571:277`) | 9 | Today's row | 70 tall, icon 32, text at 60, right side 16 |
| **Step row** (`575:136`) | 2 | A step of a checklist habit | 44 tall, tick circle 22, text at 60 |
| **Habit row · Swipe** (`763:273`) | 4 (was 5) | `swipeActions` on iOS 26, in a 70 row | Slide 80, capsule 60 × 40, full-swipe capsule 197 × 40, caption Footnote; hugs its row, so a 106 row (Undo · Note under it) takes a 60 × 50 capsule by padding 13 (9 Nov 2026) |
| **Section header** (`562:48`) | 4 | Today's time of day (`PartHeader`) | 64 tall, radii 26 |
| **Run row, Comparison row** | | Progress's data bars | Unchanged: not progress controls, and their text was already iOS's |

## List item

- **Separators start at the text** and end 16 from the right, as iOS draws them. A row of a list has no gap above it (2 went on about 900 lists).
- **A row with no icon has its line from 16.** Figma can't move a line on a copy, so a small piece of line sits under the icon column, switched by **Separator from the edge**. Turn that on with Show leading off (First and Middle rows).
- **A habit's icon in a list** is a 32 circle with a gap of 8, so its text stays at 56 with its line. The slot hugs: 24 for a symbol, plus 4 of padding round a habit's circle.
- **Trailing symbols:**

| Android | iOS | Where |
|---|---|---|
| chevron_right | `chevron.right`, Tertiary Label | Everywhere |
| expand_more, expand_less | `chevron.right`, `chevron.down` | Months in History, "What the squares mean" |
| arrow_drop_down, arrow_drop_up | `chevron.up.chevron.down` | "Remind me with", "Ends" |
| open_in_new | `arrow.up.right` | Privacy policy and the like |
| close | `xmark`, Secondary Label | A reminder time |
| drag_handle, drag_indicator | `line.3.horizontal`, 17 Regular | Edit Today, the routine |

## Habit row

Only what iOS needed changed, because the user said the card already looks good. It stays 70 tall.

- **Icon 32, not 40; gap 12:** the app's size. It stays a circle where the app has a rounded square, because the user didn't ask to change that.
- **Separator from the text to 16 from the right,** hidden on a section's last row (**Show separator**). Sections have no gaps and clip to radius 26.
- **Undo and Note:** exactly the approved words and symbols, `arrow.uturn.backward` Undo and `plus` Note, never the step or habit's name.

### Undo and Note: why this style

Tried on real fills, on the Simulator:

| Style | What happened |
|---|---|
| The app's `.bordered`, and Ink at 18 % | **Splits in two where the fill ends:** the contrast problem the user described, because a see-through button shows the fill's edge |
| Liquid Glass | Reads well, but smudges a shadow on the row, and Apple keeps glass for the navigation layer |
| Solid, no outline | Vanishes on a white row |
| Outline, no fill | See-through, so it splits too |
| **Solid card colour with a 1 pt Separator outline** | **Chosen:** the same on white and on every fill |

**This isn't a stock iOS style,** and iOS has nothing that solves it. It's the concept the user approved, in iOS's shape: capsule, 28 tall (Small), Subheadline Regular, 10 at the sides, 4 from symbol to word. **16 between them** is the user's own point about misclicks (6 Oct 2026), and 6 above them is the app's.

## Step row

"The goal … is like the user has to check tick the habits, as simple as that." iOS has no checkbox on iPhone, and Reminders has a leading circle, so the row has one too: `circle` in Tertiary Label, then `checkmark.circle.fill` in the habit's colour. It's centred under the habit's icon, with the text at the name's column.

**The app has a trailing round button here** (`StepRow`). Leading is Android's place too, and it's what Reminders does, so it's the smaller change. The user may want the other.

The Done circle is drawn as a shape holding `checkmark`, not the single symbol, so that every copy keeps its habit's colour.

## Swipes

**iOS has both directions, so the Android behaviour stays: left Skip, right Note, one action a side, and a full swipe acts.** That's what `allowsFullSwipe` does, and what Android's past-halfway does (A16).

| | iOS 26, in a 70 row (ours) |
|---|---|
| The row | Slides whole with its fill, 80, showing System Grouped Background behind it |
| Revealed | **A 60 × 40 capsule**, System Gray, its white symbol inside, 10 in from each side of the strip; *Skip* under it in Footnote, Secondary Label, 2 below; the two centred as one in the row |
| Full swipe | The capsule stretches across the strip, still 40 tall and **the same grey** (it doesn't turn darker); the caption stays under its middle |
| A row with no action | **Doesn't move at all** |

- **Measured again on 9 Nov 2026** (iPhone 17 Simulator, iOS 26.5, `Research/Temp/ios-lists/`, rows 81 and 70 tall, the full swipe read from a screen recording while the finger was held): **the shape follows the row's height.** In an 81 row iOS draws a 50 circle; in a 70 row, Today's, a 60 × 40 capsule. The component had the 81 row's circle squeezed into 70 with an 11 caption 2 below it, which read as off-centre. The symbol inside is filled where the symbol has a fill (`forward.fill`, U+10028C); `square.and.pencil` has none.
- **Nudge is deleted,** with its example. Android's "gives a little and springs back" (A35) doesn't exist on iOS. The 3 flows that showed it now show a plain row, and the first says so.
- **A taller row (9 Nov 2026, 104 on the Simulator; Today's skipped or just-logged row is 106):** iOS keeps the 60 width and makes the capsule **50 tall** (radius 25), and a full swipe stretches it at that height; the caption sits the same distance under it as in a 70 row, and the group stays centred. In Figma the component hugs the row inside it (its strip is absolute and stretches), so a copy holding a 106 row is 106 and nothing under it moves; the capsule's height is its padding, so such a copy sets the Circle's top and bottom padding to 13 and its radius to 25.
- **Every label is one word or phrase:** Skip, Note, Undo skip, Log a slip. iOS has no second label for a full swipe, so Skip today and Add note went.
- **System Gray, not Ink:** SwiftUI keeps a swipe's symbol white, and Ink turns near-white in dark mode. Reminders' Details is grey too. Reasoned, not tried in dark.
- **Symbols:** `forward`, `square.and.pencil`, `arrow.uturn.backward`, all as the app has them. `note.text` is the app's other Note symbol. Its code in SF Pro wasn't found.

## Section header

- **Name and time** are unchanged: Headline and Footnote.
- **"2 left" lost its chip:** plain Subheadline in Secondary Label, as in the app.
- **Start** is now section 05's Start button, Neutral and Filled, tied to **Now**. Its first copies.
- **Chevrons:** `chevron.down` open, `chevron.right` closed, 14 Semibold, Secondary Label. They're centred over the round buttons.
- **Radii 26:** a line inset 16 at both sides when open.
- **Text size=200% is now Accessibility 1,** with its fonts.

## The progress fills

The user asked for these in the same breath, so they're in this section's work: the fills on every row are now made from the app's green. Values and the rule: [Colours](<Colours — iOS Native.md>). The styles were renamed Fill and Milestone Band, because they're no longer iOS's quaternary and tertiary. 6 fills on Today's old cards were typed-in Android colours, and are now linked.

## New symbol codes

As in [Buttons](<Buttons — iOS Native.md>), characters of SF Pro, checked by eye:

| Symbol | Code | Symbol | Code |
|---|---|---|---|
| circle | U+100000 | forward | U+10028B |
| checkmark.circle.fill | U+100063 | forward.fill | U+10028C |
| arrow.up.right | U+10012F | chevron.up.chevron.down | U+10018F |

## What's different on other pages

- ~~Icons inside a row are still Material Symbols.~~ **Done the same day:** they're SF Symbols ([Icons](<Icons — iOS Native.md>)).
- **New habit's Add is a dark Small Button** on the form's component, though [Navigation](<Navigation — iOS Native.md>) says those words are plain glass. It's section 06's, and wasn't changed here.
- **Touch and hold's grey highlight** (renamed Highlight · pressed) was left alone. It belongs with the menus.
- **Open settings on the permission rows** is still a small grey capsule from an earlier round.
- **The screens are still 360 × 800,** so the swipe's capsule is the 402-wide Simulator's size on a 328 row.

## Checked

Looked at by eye: section 08, Today (seven states), the changed Today flow, the routine sheet, Habits & Tasks, History, New habit, Settings, and one row of every habit colour.

Read by walking `children` on every page: about 7,000 List item copies (trailing glyphs, icons, list gaps, separators), about 3,000 Habit rows, and about 2,000 Section headers. On New habit, every line starts where its text does.

No change was made to the iPhone app.

**Not looked at:** Onboarding, Plus, Notifications and the Widgets boards, beyond reading their copies. Every flow screen.

**Not checked on the phone:** the list and swipe measurements are from the Simulator (iPhone 17, iOS 26.5). Reminders was read there too. **Not measured:** the 28 of Undo and Note is `.small` as read before, and the symbols' sizes (15 in Undo and Note, 20 in a swipe) were judged from pictures. **Dark mode:** nothing here has been seen in dark.

## Checking this in Figma

- **Position and size on a copy's child can't be overridden** ("relative-transform"; `resize` does nothing and doesn't say so). Padding and gap can, and a property can show a layer. A hugging slot plus padding did what a resize wouldn't.
- **A hugging frame with a FILL child stays at its old size:** fix the child's size in the main first.
- **A copy's `children` leaves out hidden layers,** so a missing Leading avatar means Show leading is off. Read the property to be sure.
- **`getInstancesAsync` found 1,061 List items; walking `children` found about 7,000.** Walk by hand.
- **A page this size can drop the connection mid-script,** though the script finishes. Read before retrying. Habits & Tasks was already done.
- **A screenshot can be older than the file:** the first one after a change showed the old swipes. Take it again before believing it.

## Edit Today (6 Nov 2026)

- **A timed time of day's header ends in the word Edit** (Button, Borderless, Small, no symbol), which opens Edit time of day, its word ending where the rows' handles end. Health's *Pinned* header does the same (Simulator, 6 Nov 2026). Not a pencil (the user: "very weird") and not ⓘ: an ⓘ reads as information, so editing looked removed. Anytime and Quitting keep their drag handle.
- **Add Time of Day is a list row of its own** after the timed sections (List item, Single, One line): a filled ⊕ (`plus.circle.fill`, U+10004D, 22, Ink), then the words in Body. It's Contacts' *add phone* row; Apple's ⊕ is green, ours is Ink because the chrome stays neutral.
- Why: [Today on iPhone](<../../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/Today on iPhone — Notice Card, Edit and Back to Today.md>) §5.

## Day details (6 Nov 2026)

- **This day is one inset-grouped section** (radius 26): the reading, then its buttons side by side (Button, Large, equal widths, 8 apart), or a checklist's steps under a 1 pt Separator. Actions here are buttons, not rows: they save space, as on Android (the user, 6 Nov 2026).
- **Add a Note is its own section below,** List item, Single, Ink `note.text` and a chevron to the Note page. A written note is Lines=Two: *Note* over two lines of it, then ….
- **Skip Today** (*Undo Skip*, *Skip This Day*) is last: Button, Bordered, Large, full width, its word centred, the same button as Log. See [Buttons](<Buttons — iOS Native.md>).
- **The Step row (`575:136`) lines up with a list row:** a 24 tick column and a 16 gap, so its text and separator start at 56 and the separator stretches to 16 before the edge. Never override a step's padding to fit it into a padded frame: put the steps in the section as full-width rows. The last step has no separator.
- **The logs take First, Middle, Last or Single by how many show,** so one log has no separator under it.
- Why: [Day Details on iPhone](<../../Research/Research Reports/Day Structure and Organization/Day Details on iPhone — The Sheet, the Buttons and the Note.md>).
