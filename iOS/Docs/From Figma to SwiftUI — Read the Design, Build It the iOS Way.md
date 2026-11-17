# From Figma to SwiftUI — Read the Design, Build It the iOS Way

Written by Claude (Claude Code), 17 November 2026, at the user's request: "in Figma, those pages are components. Why?
Because in Figma we should work that way. But in code, whatever is the production ready or whatever in Swift actual
projects we follow that … in iOS, it is a native app … follow the principles of the app or the iOS design system or the
native of it. Okay, not exactly like Figma … document it in a separate place so that no other agents … make that
mistake. Every agent should pick up that basic concept."

**Read this before building anything in the iPhone app from the Figma file "IOS app" (`zLgBjb7M7Fp6UN0pg7J3a8`).**

## The idea in one line

**Figma says what the screen looks like and how it behaves. iOS and SwiftUI decide how it's built.**

The Figma file is organised for the people who maintain it. A whole screen is a component so a change reaches every
flow that shows it. It has variants for each state so a flow can show that state. It draws the status bar, keyboard,
alert and file picker so the flow reads like a phone.

None of that is how an iPhone app is made. Take what the design means from Figma: what shows, in what order, with
which words, at what weight. Then build it the way a production SwiftUI app is built.

## What a Figma thing becomes in code

| In Figma | Why Figma has it | In the app |
|---|---|---|
| **A page component** (a whole screen as one component, such as *Today, no habits yet*) | One edit reaches every flow that shows the screen | **A screen is an ordinary `View`**, shown where the app's state says. Don't make a reusable type just because Figma made a component. Reuse comes from small parts shared in code (a card shape, a row, a button style). |
| **Variants and properties on a screen** (`Label`, `Cancel`, `Kind=Not a backup`) | A flow can show each state of one component | **The state comes from the model**, an enum or a value the app really has (`firstLookDone`, a restore's progress, the file's error). A view takes data, never a "variant". Two variants of one alert are two cases of one error enum, shown by one `.alert`. |
| **Things iOS draws:** status bar, Home Indicator, Dynamic Island, keyboard, alert, action sheet, menu, file picker, share sheet, spinner, navigation bar, sheet grabber, dimming behind an alert | The flow has to look like a phone | **Never drawn by us.** `.alert`, `.confirmationDialog`, `Menu`, `.fileImporter`, `ShareLink`, `ProgressView()`, `NavigationStack` with `.toolbar`, `.sheet` with `.presentationDetents`. Figma's copy is a picture of the system's, for reading the flow. |
| **Apple's own layouts** (`ContentUnavailableView`, an inset-grouped list, a `Form`) | Drawn with fixed numbers to match the phone | **The SwiftUI view itself, with its own spacing.** Don't rebuild it from Figma's numbers or nudge its gaps to match. Figma's 32 between two buttons is a reading of what iOS does; where the two differ, iOS is right. |
| **A frame's size** (393 × 852, a 52-tall row, a 280-wide text box) | Figma needs a size to draw anything | **One phone at the default text size.** No fixed screen sizes. Rows take a minimum height and grow, and text wraps. Large text, the iPhone SE and landscape must all work. Use the safe area, never Figma's 54 and 34. |
| **A colour style** (`Label/Secondary`, `Fill/Tertiary`) | Named so a change reaches everything | **The system colour by name:** `Color(.secondaryLabel)`, `Color(.tertiarySystemFill)`. Never the hex Figma shows: it's the light value of one iOS version. Only the app's own colours are in `Palette.swift`. |
| **A text style** (`iOS/Subheadline/Regular`) | Same | **The text style:** `.font(.subheadline)`, which grows with Dynamic Type. Never `.system(size: 15)` for something iOS has a style for. |
| **A component that's iOS's own control** (Button Large Prominent, Switch, Segmented control) | Figma has no live controls | **The control with its modifiers:** `.buttonStyle(.borderedProminent).controlSize(.large)`, `Toggle`, `Picker(.segmented)`. Never a custom view that draws one. |
| **A component iOS doesn't have** (the medal, the habit's progress row, a day cell) | Same reason | **One SwiftUI view or `Shape`, in `Components/`**, used everywhere it shows. This is the only place Figma's component and the code's line up one to one. |
| **Notes, arrows and labels on a flow** | They tell the story | **The behaviour to build.** "Shown only after a second", "goes on by itself when online", "Cancel until writing starts" are requirements as much as the pixels are. Read every description on the component and every note beside the flow. |
| **Light mode only, one text size, no motion** | Figma is drawn once | **The app does all of it:** dark mode, every Dynamic Type size, VoiceOver labels, Reduce Motion. Figma not showing it isn't permission to skip it. |
| **A detached or hand-placed copy** | A designer's shortcut | **Ignore the shortcut.** Build from the main component and its description. |

## Where the two disagree

1. **The user's word wins over both** (Rulebook: "the user's new decisions win").
2. **Then iOS's behaviour.** What a native control does on the phone is right, and Figma's picture of it may be wrong.
   Read sizes from the phone or the Simulator, never from memory.
3. **Then Figma's design** for everything that's ours: words, order, which action is the main one, the app's own
   components.

When Figma is wrong about something native, build the native thing and say so in the doc for that section. Don't fix
Figma unless asked.

## Before calling a screen done

- It's built from SwiftUI's own views, and nothing iOS draws is drawn by us.
- Its states come from the app's real state, not a parameter copied from Figma.
- No hex where a system colour exists, no point size where a text style exists, no fixed height that clips large text.
- Look at it on the Simulator in light and dark, and at a large text size, and tap through it as a person would.
- The behaviour in Figma's notes is built, or the doc says why not.

## Mistakes already made, and corrected

Each one was made on the `ios-update` branch (17 Nov 2026) and is fixed in the code. They're here so nobody makes
them again.

| What was done | Why it was wrong | Now |
|---|---|---|
| The card notice's ✕ at `.system(size: 26)`, read off Figma's frame | A point size never grows with the person's text size. Figma's 26 is what Title 2 draws at the default size | `.font(.title2)` (`CardNotice`) |
| The card notice forced Figma's 15 / 16 insets on its list row | The list sets its own row insets, and they change with text size and iOS version. A notice must line up with the rows under it, which only the list's own insets guarantee | The list's own insets |
| A milestone row forced 12 above and below to make Figma's 72 | Same: 72 is what the list gives a 48 badge anyway, at one text size | The list's own insets (`MilestoneRow`) |
| The banner was capped at 328 wide | 328 is Figma's 360-point Android frame less its margins, not a rule of the iPhone's. A cap from one frame width is wrong on every other phone | Its place's padding decides its room (`Banner`) |
| The routine player's timer icon at `.system(size: 28)` | Figma's 28 is Title 1 at the default size | `.font(.title)` |

**Looked at and kept, because they're ours and iOS has no part for them:** the day cells' fixed sizes (a calendar grid
keeps its cells the same size, as Fitness and Calendar do), the medal and ring sizes, the custom clock and amount
faces (`CustomText`, which scale with a cap), Today's rows drawing their own edges for the fill and band, and the two-wheel
picker (UIKit's own `UIPickerView`, because SwiftUI can't put two wheels on one band).
