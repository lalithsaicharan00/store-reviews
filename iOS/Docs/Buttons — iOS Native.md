# Buttons — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: "already there is an app, take from it, like how the buttons and everything looks … update the buttons and actions section very properly and very cautiously, because majority of the things here are for Android."

Figma: file `zLgBjb7M7Fp6UN0pg7J3a8`, section `05 · Buttons & actions` (node `1299:2426`) on the design system page.

## Where each part comes from

- **What exists and what it looks like:** the app's code (`iOS/Habits/`) and the app running on the user's iPhone 16, iOS 26.6.
- **The sizes:** real SwiftUI controls on the phone, in a throwaway app (`Research/Temp/ios-buttons/`, git-ignored): frames read from the view, colours read from a screenshot converted to sRGB.
- **The glass and the structure:** Apple's iOS and iPadOS 26 Figma kit, copied in as plain frames with no link to the kit. Where the kit and the phone differ, the phone wins: the kit draws a medium button with 15 pt text, and the phone draws 17.

## What's in the section

| Component | Variants | What it is | Measured |
|---|---|---|---|
| **Button** (`500:26`) | 18: Style × Size × State | `.borderedProminent`, `.bordered`, `.borderless`, plus the app's red Delete | Small 28, Regular 34, Large 50; always a capsule |
| **Glass button** (`4051:2549`) | 5 | A `Button` in `.toolbar`: Apple's Liquid Glass bar button. `Style=Grouped` has no glass of its own, for two symbols sharing one capsule ([Navigation](<Navigation — iOS Native.md>)) | Top 44, Bottom 48 |
| **Symbol button** (`495:4`) | 1 | A bare SF Symbol: `Button(systemImage:)` with `.labelStyle(.iconOnly)` | 44 × 44 touch area |
| **Round button** (`559:24`) | 2: Neutral, Done | The app's `RoundActionButton` on a row | 34 circle in a 44 touch area |
| **Start button** (`4051:2556`) | 2: Neutral, Filled | The app's Start on a time of day | 34 tall, 14 at the sides |
| **Segmented control** (`4051:2588`) | 5: Segments × Selected | `Picker` with `.pickerStyle(.segmented)` | 32 tall, selected 28 |
| **Floating button** (`4193:106216`) | 2: Glass, Prominent | A button over the list. **Glass** (`4051:2589`) is the bars' Liquid Glass with a Label word, for Back to Today: a way back, not the screen's main action (the user, 6 Nov 2026). **Prominent** (Ink) stays for a page's main action (History's Add, Add note, Add time of day) | 44 tall, 18 at the sides |
| **Bottom toolbar** (`581:145`) | 1 | The app's bottom bar | 48 tall, 28 at the sides |

**Button's styles:**

| Style | Fill | Label | Text |
|---|---|---|---|
| Prominent | Ink | On Ink | Body Regular |
| Bordered | Ink at 18 % | Ink | Body Regular |
| Borderless | None | Ink | Body Regular |
| Destructive | Ink at 18 % | System Red | Body Regular |
| Disabled (Prominent, Bordered) | Secondary System Fill | Tertiary Label | As its style |

Small is Subheadline Regular in every style. The padding is 10/4 for Small, 12/6 for Regular and 20/14 for Large.

- **Ink at 18 %** is what `.bordered` with `.tint(.ink)` draws: `#DADADA` on white. It's a plain paint at 18 %, not a colour style, because linking a style removes a paint's own transparency.
- **Body Regular on Regular and Large, as iOS draws them** (6 Nov 2026, the user: "use the correct button style"). This page first used Semibold, taken from the old app (`DaySheet.swift`, `RoutinePlayer.swift`, `PlusScreens.swift`); on the Simulator a plain `.borderedProminent` and `.bordered` are 17 Regular, and the Semibold looked heavy.
- **Destructive** is the app's `RecordDeleteButton`: bordered with a red label, never a red fill.

**Symbols are characters of SF Pro, as in Apple's kit,** so a button's symbol stays an editable text property. They only draw where SF Pro is available. These were checked by eye in Figma, and macOS has no table of them:

| Symbol | Code | Symbol | Code |
|---|---|---|---|
| plus | U+10017C | ellipsis | U+100360 |
| minus | U+10017D | magnifyingglass | U+1002AB |
| xmark | U+100184 | pencil | U+10020A |
| checkmark | U+100185 | square.and.pencil | U+10020E |
| chevron.up | U+100187 | line.3.horizontal | U+100307 |
| chevron.down | U+100188 | line.3.horizontal.decrease.circle | U+100308 |
| chevron.left | U+100189 | clock | U+10042B |
| chevron.right | U+10018A | arrow.right | U+10012B |
| play.fill | U+100284 | calendar | U+100249 |
| pause.fill | U+100286 | gear | U+10035F |
| arrow.uturn.backward | U+100C4D | arrow.counterclockwise | U+100149 |
| trash | U+100211 | | |

## The timer's buttons (6 Nov 2026)

- **Show label off leaves the symbol alone.** It's for ▶ and ⏸: the Timer screen's Pause and Resume, and the routine player's Start, Pause and Resume (Android A69). The word stays in Label, for VoiceOver.
- **The Timer screen has Log Time (Bordered) and Pause or Resume (Prominent), Large, equal widths, as in Day details.** Once the goal is met, the Prominent button takes the habit's colour (A91).
- **Clock button is deleted.** The user: a round Log Time "doesn't make sense at all". No page used it after the swap.
- **Day Details is Small, Bordered, with `calendar`, and always says Day Details,** never Today or a date. It sits under the habit's name on the Timer screen and in the routine player.
- **In SwiftUI, an icon-only button is shorter than a word beside it.** Seen on the Simulator: give it the same height.

## What happened to Android's parts

| Android | iOS | Why |
|---|---|---|
| Button, 96 variants | Button, 18 variants | Filled became Prominent, Tonal became Bordered, Text became Borderless, Outlined became Bordered. Shape went, because iOS's are always capsules. Icon became an on/off property, and anything labelled Delete, Discard, Remove or Erase became Destructive |
| Icon button | Glass button in a bar; Symbol button elsewhere | iOS has both, and neither is 48 × 48 |
| Filled icon button | Round button | One size, as in the app. Disabled went |
| **Large icon button** | **Deleted** | Android's. Its chevrons became bottom-bar Glass buttons; its play and pause became Prominent Large |
| **Connected button and group** | **Deleted; Segmented control** | The closest native part, and what the app already uses for Week · Month · Year (`Progress/ProgressScreen.swift:249`) |
| **Extended FAB** | **Deleted; Floating button** | iOS has no floating action button |
| Floating toolbar | Bottom toolbar | Three separate glass pieces with no pill behind them, exactly as `TodayView.swift:753` |

`iOS/Body/Medium` was added to the text styles for a glass button's word.

A top bar's confirming word (Add, Done, Save) is Glass button, Style=Regular, in Body Semibold. In the app that's `.confirmationAction` with `.fontWeight(.semibold)`. **Corrected the same day:** this page first said it draws as solid Ink, which was wrong; on the phone it's plain glass. A dark one needs `.buttonStyle(.glassProminent)` (about `#454545`), and the Prominent variant that drew it was deleted.

## What's different on other pages

The user expected these, since those pages are copies of Android. They wait for those pages' own turn.

- **History and Task details** still float Add at the bottom right. In the app, Add is a Bordered button inside the page (`HabitPageParts.swift:170`).
- **Today's section headers** now use Start button, since section 08 ([Lists and Rows](<Lists and Rows — iOS Native.md>)).
- **The icon picker's cells** are still Round buttons at their old 48 size. Their symbols are SF now ([Icons](<Icons — iOS Native.md>)).
- **The stepper's − and +** are Round buttons, where iOS has its own Stepper.
- **The bottom toolbar on 360 wide:** the middle piece is 184 where the phone's is 217, because the screens are still Android's 360 × 800. "Yesterday" fits tightly.

## Checked

Looked at by eye: section 05, Today, Back to Today, Habits & Tasks, the routine player, History, Day details, the icon picker, New habit, a widget's setup and Plus. Read for all copies: none left on a deleted component, no Material ligature left in a Button, Glass, Symbol or Floating symbol.

Not looked at: Settings, Onboarding, Notifications and the widget boards, beyond reading their copies. No change was made to the iPhone app.

**Not measured:** a Small button's and a Large button's side padding. The phone's row wrapped them, so those are the kit's values. The floating button's 6 between symbol and label was judged from the screenshot.

## Checking this in Figma

- **`findAllWithCriteria` found 76 Filled icon buttons in one script and 3,621 in a later one.** Copies inside other copies aren't always returned until they're used. Audit again at the end, and don't trust the first count.
- **`fontName` read from a node can carry axes its setter rejects:** copy the family and style only.
- **A copy swapped to another component keeps its own fill and height.** Back to Today came out white on white, 28 tall, until the copy's fill and height were reset.
- **A clone appended to a variant set lost its property links.** Check `componentPropertyReferences` on a cloned variant.
- **A bar that clips cuts Apple's glass shadow into a visible box.** Turn off clipping on bars that hold glass, with the main component first.
- **The ring arcs are filled shapes with an inner radius,** so a stroke on them draws the wrong thing.
- **After a dropped connection, read before retrying:** the script had finished.
