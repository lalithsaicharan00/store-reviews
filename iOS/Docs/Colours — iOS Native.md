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
3. **Ink differs between Figma and the code.** Figma and this page use the charcoal the user asked for, `#303030` and `#F2F2F5` in dark. `Color.ink` in the existing iPhone code is about `#27272A` and `#ECECEE`. The app wasn't changed.

## Not done

- **548 colours on the screens are typed in, not styles,** so they keep their old values: Day details 185, Today 106, Onboarding 77, Routine player 74, Settings 60, Details pages 16, Design system 16, Notifications 10, Habits & Tasks 4. Some are probably the Google logo or other deliberate colours, so each needs looking at.
- **The component shapes are still Material's:** the floating action button, snackbar, the date picker's "Select date" header, switch, dropdown, drawer, and the icons. So a screen has iOS's colours and text on a Material shape until those are redone.
- **Nothing has been checked in the app:** the iOS app doesn't use this until it is rebuilt.

## Checking this in Figma

- **Rename a style in place** to keep its ID: everything using it follows. A paint linked to a style holds no transparency of its own, so moving between styles loses nothing; linking a raw paint with its own opacity to a style does lose it.
- **A rule that goes by node name is only as good as those names.** Day details' sheet is named `Kind=…`, so a "sheet" rule missed it and the sheet turned see-through. A later search for "menu" then caught an icon called `menu_book`. Look at the screens after a sweep.
- **Change main components first, then the rest,** so instances follow instead of gaining overrides. A copy with its own override doesn't follow: set it by its own ID.
- **`moveLocalPaintStyleAfter` works only inside one folder:** rename everything to one flat folder, order them, then rename them back.
