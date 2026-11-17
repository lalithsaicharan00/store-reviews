# Colours — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: "we should use the native colors that iOS provides rather than customizing our own." Rebuilt the same day, when the user said the styles were still Material's under new values: "Update everything according to the … Apple iOS design system … If you need to delete something, just delete it … It's about using the right text styles, right colors from the iOS design system itself."

**The one exception: the app stays neutral.** The user, the same day: "our app is a neutral … in light mode, it uses a charcoal color … in the dark mode, it uses white. So app needs to stay neutral because we are using colors for habit cards and everywhere." So the chrome never uses iOS's blue tint or `link`. Colour belongs to the habits.

The [IOS app Figma file](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=1299-2424), section 02 · Colour, holds these as 131 colour styles, grouped the way Apple groups them. Figma holds light mode only. In the app, dark mode is whatever iOS gives for the same colour.

## Where this comes from

- **The names and groups:** Apple's, from the iPhone SDK: `UIColor` in UIKit (`UIInterface.h`) and `Color` in SwiftUI.
- **What each colour is for:** Apple's own notes in `UIInterface.h`. Fills go by the size of the shape. Backgrounds come in two stacks that aren't mixed in one piece of UI.
- **The values:** measured on the user's iPhone 16, iOS 26.6, with throwaway apps in `Research/Temp/ios-colours/` and `Research/Temp/ios-controls/` (git-ignored). They read each colour with `UIColor.resolvedColor` and drew real controls. iOS's values change between versions (Red is `#FF383C` on iOS 26, not the older `#FF3B30`), so the app must call the colour by name, never by these hex values.

**Not checked:** Apple's own Figma kit wasn't opened, so its panel may be laid out differently, though the names come from the SDK.

## System colours

Figma's styles are `iOS/<Group>/<Name>`.

| Group and name | Swift | Light | Dark | Its job |
|---|---|---|---|---|
| **Label** / Label | `.label` | #000000 | #FFFFFF | Main text and icons |
| Secondary Label | `.secondaryLabel` | #3C3C43 · 60% | #EBEBF5 · 60% | The line under a name, section footers |
| Tertiary Label | `.tertiaryLabel` | #3C3C43 · 29.8% | #EBEBF5 · 30% | Quieter still |
| Quaternary Label | `.quaternaryLabel` | #3C3C43 · 17.6% | #EBEBF5 · 16% | The quietest text |
| Placeholder Text | `.placeholderText` | #3C3C43 · 29.8% | #EBEBF5 · 30% | A field with nothing typed |
| **Separator** / Separator | `.separator` | #3C3C43 · 12% | #545458 · 50% | Lines between rows; can be see-through |
| Opaque Separator | `.opaqueSeparator` | #C6C6C8 | #38383A | A line that must hide what's behind it |
| **Fill** / System Fill | `.systemFill` | #787880 · 20% | #787880 · 36% | Thin, small shapes: a slider's or progress bar's track |
| Secondary System Fill | `.secondarySystemFill` | #787880 · 16% | #787880 · 32% | Medium shapes: a switch's background |
| Tertiary System Fill | `.tertiarySystemFill` | #767680 · 12% | #767680 · 24% | Large shapes: fields, search bars, buttons, the round button on Today |
| Quaternary System Fill | `.quaternarySystemFill` | #747480 · 8% | #767680 · 18% | Large areas with complex content |
| **Background** / System Background | `.systemBackground` | #FFFFFF | #000000 | A plain page |
| Secondary System Background | `.secondarySystemBackground` | #F2F2F7 | #1C1C1E | Content on a plain page |
| Tertiary System Background | `.tertiarySystemBackground` | #FFFFFF | #2C2C2E | Content on that content |
| **Grouped Background** / System Grouped Background | `.systemGroupedBackground` | #F2F2F7 | #000000 | A page of cards, sheets, menus, bars |
| Secondary System Grouped Background | `.secondarySystemGroupedBackground` | #FFFFFF | #1C1C1E | A card on that page |
| Tertiary System Grouped Background | `.tertiarySystemGroupedBackground` | #F2F2F7 | #2C2C2E | Content inside a card |
| **Standard** / System Red … System Brown | `.systemRed` … | Table below | Table below | A habit's colour; System Red also means Delete |
| System Gray | `.systemGray` | #8E8E93 | #8E8E93 | A control's edge, needing 3:1 against white |
| System Gray 2–6 | `.systemGray2` … | #AEAEB2, #C7C7CC, #D1D1D6, #E5E5EA, #F2F2F7 | #636366, #48484A, #3A3A3C, #2C2C2E, #1C1C1E | Neutral steps; Gray 4 replaces the old Surface dim |
| White, Black | `.white`, `.black` | #FFFFFF, #000000 | The same | White is what sits on a habit colour |
| **Custom** / Ink | `Color.ink` | #303030 | #F2F2F5 | **Ours.** The neutral main button and the progress bar |
| Custom / On Ink | `Color.onInk` | #FFFFFF | #1C1C1E | **Ours.** Text and icons on Ink |
| Custom / Dimming | `.black.opacity(0.2)` | #000000 · 20% | Not measured | **Ours.** Apple has no name for it. Measured behind a sheet and an alert |

**Left out on purpose:** `link` and the blue tint, because the chrome is neutral.

## Habit colours

iOS has exactly our 13 hues, and a habit's base colour is `iOS/Standard/System <Hue>`. The rest are `iOS/Habit/<Hue>/<Shade>`. Deep, Bar and Medal have no iOS name.

| Shade | Where it's used | What iOS gives |
|---|---|---|
| Increased Contrast | Everything that carries white | The same colour under Increase Contrast (`accessibilityContrast: .high`). White is 4.5:1 or more on all 13 |
| Deep | Milestone bar's dark end, See's label, medal's shadow | **Ours.** Increased Contrast `.mix(with: .black, by: 0.3)`, chosen because white is 9.3:1 or more |
| Gradient Top | Medal's light end | The top of iOS's own gradient, `Color.red.gradient` |
| Milestone Band (was Tertiary) | Milestone band | **Ours.** One step stronger than Fill, from the green `#CCF1D6`: OKLCH L 0.924, C 0.053, each hue's own H |
| Fill (was Quaternary) | Today's progress fill, everywhere | **Ours.** From the app's green `#E1F7E6`: OKLCH L 0.955, C 0.032, each hue's own H |
| Bar | Milestone bar | **Ours.** Deep to Increased Contrast |
| Medal | Milestone medal | **Ours.** Gradient Top to Increased Contrast |

**The fills were remade from the app's green (the same day, the user: "they are way too brighter than my expectations … I like the green color … take the green as a base and then create other colors").** The app draws a fill as the hue at 15 % (`ProgressFill`, `Components/Components.swift:157`), read from the phone as green `#E1F7E6`. Figma's old Quaternary was iOS's quaternary at 18 %, and it looked too bright. Every hue now has green's lightness and chroma with its own hue, taken from its Standard colour, so all 13 feel alike, which plain percentages don't do.

- **Chroma comes down only where sRGB can't hold it** (Blue and Indigo, a little).
- **Brown is at 0.42× chroma,** or it reads as orange. **Gray has none.**
- **Red and Pink look nearly alike at this strength,** because their hues are close. Their icons tell them apart.
- **The green matches the app exactly.** The other hues deliberately differ from the app, whose blue at 15 % is `#D9EDFF` and yellow `#FFF7D9`. Build the iPhone's fills from this table, not from `opacity(0.15)`.
- **Dark isn't touched:** the Dark columns are still iOS's tertiary and quaternary, and the app's fill there is the hue at 26 %. Figma has no dark mode yet, so decide this when dark mode is built.

Both are stored in Figma as solid colours, because they sit on a white card.

| Hue | Standard | Increased Contrast | Deep | Gradient Top | Milestone Band | Fill | Dark: Standard | Dark: Tertiary | Dark: Quaternary |
|---|---|---|---|---|---|---|---|---|---|
| Red | #FF383C | #E9152D | #900818 | #FF6367 | #FFDDD9 | #FFEBE9 | #FF4245 | #401011 | #2E0C0C |
| Orange | #FF8D28 | #C55300 | #793000 | #FFAD58 | #FFDFC9 | #FFECE0 | #FF9230 | #40250C | #2E1A09 |
| Yellow | #FFCC00 | #A16A00 | #623F00 | #FFCC00 | #F3E5BF | #F8F0D8 | #FFD600 | #403600 | #2E2700 |
| Green | #34C759 | #008932 | #00531B | #62DD81 | #CCF1D6 | #E1F7E6 | #30D158 | #0C3416 | #092610 |
| Mint | #00C8B3 | #008575 | #005046 | #37DFCD | #C0F2E8 | #DAF8F2 | #00DAC3 | #003731 | #002723 |
| Teal | #00C3D0 | #008198 | #004E5C | #37DBE6 | #BDF1F6 | #D8F7FA | #00D2E0 | #003538 | #002628 |
| Cyan | #00C0E8 | #007EAE | #004C6A | #37D8FA | #C0EFFF | #DAF6FF | #3CD3FE | #0F3540 | #0B262E |
| Blue | #0088FF | #1E6EF4 | #0E4197 | #2FA9FF | #D6E8FF | #E7F1FF | #0091FF | #002440 | #001A2E |
| Indigo | #6155F5 | #564ADE | #322A89 | #887DFF | #E0E4FF | #EDEFFF | #6D7CFF | #1B1F40 | #14162E |
| Purple | #CB30E0 | #B02FC2 | #6C1977 | #E95DFC | #F8DBFB | #FBEAFD | #DB34F2 | #370D3D | #27092C |
| Pink | #FF2D55 | #E7124D | #8F072C | #FF5A7F | #FFDCDC | #FFEBEB | #FF375F | #400E18 | #2E0A11 |
| Brown | #AC7F5E | #956D51 | #5A412F | #CBA489 | #F2E3D8 | #F8EEE8 | #B78A66 | #2E2219 | #211912 |
| Gray | #8E8E93 | #6C6C70 | #404043 | #B0B0B5 | #E6E6E6 | #F0F0F0 | #8E8E93 | #232325 | #1A1A1A |

Increased Contrast and Deep have no dark value yet: iOS's Increase Contrast value goes lighter in dark mode, so white wouldn't stay readable on it. Decide this when dark mode is built.

## In the app (17 Nov 2026)

Written by Claude (Claude Code), 17 November 2026, on the branch `ios-update`, at the user's request: "first of all, create the color system properly … If iOS is providing all of that by default from its design system … then don't create that color. Use the existing color itself … as a production ready application, whichever is the best decision, you can choose it."

**One file holds the colour system: [`iOS/Shared/Palette.swift`](../Shared/Palette.swift).** It's in `Shared/`, so the app, the widgets and the Live Activity all compile the same one. Before, the habit colours were mapped three times (`Components.swift`, `WidgetPalette.main`, the Live Activity's `TimerColor`) and Ink twice; each now reads `Palette.swift`.

- **Apple's colours have no copy in the app.** Every `iOS/Label`, `Separator`, `Fill`, `Background`, `Grouped Background` and `Standard` style is called by Apple's own name (`Color(.secondarySystemGroupedBackground)`, `.secondary`, `.red`), and the file's header maps each Figma style to its Swift call. No wrapper was made for them: iOS already gives their dark mode, Increase Contrast and any change in a later iOS, and a wrapper of our own would only hide that. Dimming isn't in the code at all, because iOS draws it.
- **Ours are only what iOS lacks:** `Color.ink`, `Color.onInk`, and on `HabitColor` the shades `increasedContrast`, `deep`, `gradientTop`, `fill`, `milestoneBand`, `bar` and `medal`. `HabitColor.color` stays the system colour.
- **Increased Contrast is read from iOS, not typed in:** each `UIColor.system<Hue>` resolved for light mode with Increase Contrast on, once, and kept. It doesn't change in dark mode, so white on it stays 4.5:1 or more there (iOS's own dark Increase Contrast values are lighter, and white wouldn't be readable).
- **Deep, Gradient Top, Fill and Milestone Band are Figma's values** (Deep and Gradient Top the same in light and dark). The OKLCH recipe above was checked again: it gives Figma's Fill and Band exactly for 10 hues, and within one step of rounding for the rest, so Figma's numbers were kept.
- **Bar and Medal are gradients built from those:** Bar runs Deep → Increased Contrast from leading to trailing, Medal Gradient Top → Increased Contrast from top to bottom, as Figma's styles do.
- **`HabitColor` moved from `Habits/Model/Habit.swift` to `Palette.swift`,** unchanged (same cases, same raw values, still `Codable`), so stored habits and backup files read exactly as before.

**Changed on screen:**

- **Ink is Figma's `#303030`** (dark `#F2F2F5`); the code had `#27272A` (dark `#ECECEE`), the difference noted under "For the user to judge" below. On Ink's dark value is `#1C1C1E`, as in Figma's description.
- **Today's progress fill is the habit's Fill,** opaque, in place of the hue at 15 % (26 % in dark). The green looks the same; the other hues now match Figma (blue `#E7F1FF` where it was `#D9EDFF`).

- **A habit's icon, its progress marks and charts, and the widgets' icons are its iOS colour (`HabitColor.color`), solid,** as Figma's Today component draws the icon (`iOS/Standard/System <Hue>`; the user, 17 Nov 2026: "whatever we have in Figma, you can use that"). The app's own darker set at one lightness (`HabitColor.mark`, `WidgetPalette.markHex`, OKLCH 0.64, 2 Oct 2026) and the icon tile's gradient are gone.

**The iOS colours aren't at one lightness (measured 17 Nov 2026, for the user to judge).** Only Fill and Milestone Band were made in OKLCH; the Standard colours are Apple's as they are, from OKLCH L 0.56 (Indigo) to 0.87 (Yellow), so they don't look equally strong. A white symbol on them:

| Hue | Standard | OKLCH L | White on it |
|---|---|---|---|
| Red | #FF383C | 0.65 | 3.57 : 1 |
| Orange | #FF8D28 | 0.75 | 2.31 : 1 |
| Yellow | #FFCC00 | 0.87 | 1.51 : 1 |
| Green | #34C759 | 0.73 | 2.22 : 1 |
| Mint | #00C8B3 | 0.75 | 2.12 : 1 |
| Teal | #00C3D0 | 0.74 | 2.16 : 1 |
| Cyan | #00C0E8 | 0.75 | 2.16 : 1 |
| Blue | #0088FF | 0.63 | 3.52 : 1 |
| Indigo | #6155F5 | 0.56 | 5.09 : 1 |
| Purple | #CB30E0 | 0.62 | 4.17 : 1 |
| Pink | #FF2D55 | 0.65 | 3.65 : 1 |
| Brown | #AC7F5E | 0.63 | 3.53 : 1 |
| Gray | #8E8E93 | 0.65 | 3.26 : 1 |

Seven hues fall under the 3 : 1 that WCAG 1.4.11 asks of an icon's shape, Yellow far under. Figma's own **Increased Contrast** shade is the one meant to carry white (4.5 : 1 or more on all 13), but the Today component's icons use Standard.

**Dark mode, decided here (Figma has none).** Fill and Milestone Band follow the light rule: the app's dark green fill as drawn until now (green at 26 % on the card `#1C1C1E`, `#214B2D`) gives Fill L 0.374, C 0.070, and the Band is one step stronger, L 0.430, C 0.085, each on its hue, with chroma lowered only where sRGB can't hold it. The fill is 1.6–1.7 : 1 against the card, and white text on it 9.9 : 1 or more.

| Hue | Dark Fill | Dark Milestone Band |
|---|---|---|
| Red | #60312D | #783B37 |
| Orange | #5C3618 | #72421B |
| Yellow | #4C400B | #5F4F07 |
| Green | #254B2A | #2C5C33 |
| Mint | #014C43 | #015D53 |
| Teal | #014A50 | #015B62 |
| Cyan | #00485B | #01596F |
| Blue | #234264 | #29527D |
| Indigo | #363D65 | #424B7E |
| Purple | #523356 | #663F6B |
| Pink | #603034 | #773A40 |
| Brown | #4D3D31 | #5F4B3C |
| Gray | #414141 | #505050 |

**Checked:** `Palette.swift` type-checks against the iOS 27.2 SDK in Swift 6 with MainActor default isolation, in Swift 6 and in Swift 5, with no warnings. **Building UITraitCollection with `init(mutations:)` is main-actor only** (UIKit's mutable traits are `@MainActor`), so `increasedContrast`, `bar` and `medal` are read on the main actor, as a view's body is; the older `init(traitsFrom:)` works anywhere but is deprecated since iOS 17. **Not checked yet:** the whole app hasn't been built (that's GitHub's job, Rulebook T1), and nothing has been looked at on the iPhone, in light or dark (U9).

**Still to move onto the system, screen by screen** (each has its own colours, decided before this): the heat map's palettes and greys (`Progress/HeatMap.swift`), the widgets' greys (`WidgetPalette`), and the habit colour at a percentage in the progress charts and tiles (`DayMarks`, `LightBarChart`, `HabitProgressTab`, the routine player's ring, the Live Activity's icon). Figma has a shade for some of these (Fill, Milestone Band) and not for others, so each is for its screen's own work.

## What happened to Material's roles

They weren't renamed one for one. Each use went to the colour for its job, and whatever iOS doesn't have was deleted.

| Material role | Now |
|---|---|
| Primary, On primary | Ink, On Ink. Text that was Primary went to its job: section titles to Label, "Subheader" and "N habits" to Secondary Label |
| Secondary container | Tertiary System Fill; a track is System Fill |
| Every On-container, On surface | Label |
| On surface variant | Secondary Label |
| Surface | System Background |
| Surface container | System Grouped Background |
| Surface bright, Surface container lowest | Secondary System Grouped Background |
| Surface container low | System Grouped Background for sheets, menus, the drawer and pop-ups; Tertiary System Fill for tiles and switched-off buttons |
| Surface container high | Tertiary System Fill; System Grouped Background for the status bar, top bar, tabs and period row, because content scrolls behind them and a see-through bar would show it |
| Surface container highest | Secondary System Fill on a switch; Tertiary System Fill elsewhere; Separator as a stroke |
| Surface dim | System Gray 4 |
| Outline | System Gray; as text, Tertiary Label, Secondary Label or Placeholder Text by job |
| Outline variant | Separator; a track is System Fill |
| Inverse surface, Inverse on surface | Ink, On Ink. The app has no snackbar; its toast-like capsule is ink (`Today/DayBar.swift:190`) |
| Error | System Red |
| Scrim | Dimming |
| On habit | White |

**Deleted, 19 styles:** Primary container, On primary container, Secondary, On secondary, Secondary container, On secondary container, Tertiary, On tertiary, Tertiary container, On tertiary container, Error, On error, Error container, On error container, Surface container lowest, Surface container low, Inverse surface, Inverse on surface, and the habit shade that repeated Gray's base colour. Nothing on any page was left using them.

## For the user to judge

1. **Label is pure black,** where Android stopped at `#1B1B1B`.
2. **Tertiary System Fill is see-through,** as iOS defines it: a round button on a coloured progress fill picks up a little of that colour.
3. **Ink differs between Figma and the code.** Figma and this page use the charcoal the user asked for, `#303030` and `#F2F2F5` in dark. `Color.ink` in the existing iPhone code is about `#27272A` and `#ECECEE`. The app wasn't changed. **Settled 17 Nov 2026: the app now uses Figma's `#303030` and `#F2F2F5`** (see "In the app").

## Not done

- **548 colours on the screens are typed in, not styles,** so they keep their old values: Day details 185, Today 106, Onboarding 77, Routine player 74, Settings 60, Details pages 16, Design system 16, Notifications 10, Habits & Tasks 4. Some are probably the Google logo or other deliberate colours, so each needs looking at.
- **The component shapes are still Material's:** the floating action button, snackbar, the date picker's "Select date" header, switch, dropdown, drawer, and the icons. So a screen has iOS's colours and text on a Material shape until those are redone.
- ~~**Nothing has been checked in the app:** the iOS app doesn't use this until it is rebuilt.~~ The app has the colour system since 17 Nov 2026 (`Shared/Palette.swift`, "In the app"); it hasn't been looked at on the iPhone yet.

## Checking this in Figma

- **Rename a style in place** to keep its ID: everything using it follows. A paint linked to a style holds no transparency of its own, so moving between styles loses nothing; linking a raw paint with its own opacity to a style does lose it.
- **A rule that goes by node name is only as good as those names.** Day details' sheet is named `Kind=…`, so a "sheet" rule missed it and the sheet turned see-through. A later search for "menu" then caught an icon called `menu_book`. Look at the screens after a sweep.
- **Change main components first, then the rest,** so instances follow instead of gaining overrides. A copy with its own override doesn't follow: set it by its own ID.
- **`moveLocalPaintStyleAfter` works only inside one folder:** rename everything to one flat folder, order them, then rename them back.
