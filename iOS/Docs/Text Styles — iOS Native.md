# Text Styles — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: take the fonts from the already developed iPhone app, in SF Pro, without changing the app. Corrected the same day, when the user asked whether the names were native. They weren't: "the naming conventions, everything should be taken from the iOS itself … you don't need to keep anything related to Android."

Figma: file `zLgBjb7M7Fp6UN0pg7J3a8`, section `03 · Text styles` (node `1307:2423`) on the design system page. All styles are grouped under `iOS/`.

## Where each part comes from

- **The style names:** Apple's own, from the iPhone SDK (Xcode 27.2): `UIFontTextStyle` in UIKit (`LargeTitle`, `Title1`, `Title2`, `Title3`, `Headline`, `Subheadline`, `Body`, `Callout`, `Footnote`, `Caption1`, `Caption2`) and `Font.TextStyle` in SwiftUI. The SDK also has Extra Large Title 1 and 2; the app doesn't use them, so they aren't here.
- **The weight in a name** (Regular, Semibold, Bold): SwiftUI's `Font.Weight`, as the app writes it. Only the weights the app uses are here.
- **Which font does which job:** the app's code, `iOS/Habits/`.
- **Sizes and line heights:** measured on the iPhone 16, iOS 26.6, with a throwaway app in `Research/Temp/ios-type/` (git-ignored). A line height is the measured gap between two lines at the default text size, Large.
- **Tracking:** Apple's value for each size. It was checked against the width of "Often Enough habit" on the phone, set against the same words in Figma with no tracking, to about 0.05 pt per letter (Figma rounds a text's width to a whole point).

**Not checked:** how Apple's own Figma kit lays out its text styles panel. The kit wasn't opened, so its grouping may differ from `iOS/Title 2/Semibold`, though the style names come from Apple's SDK.

On the phone these fonts grow with the person's text size. A Figma style draws one size.

## Dynamic Type, at the default size (Large)

| Figma style | SwiftUI | Size / line | Tracking | Where in the app |
|---|---|---|---|---|
| `iOS/Large Title/Regular` | `.largeTitle` | 34/41 | +0.40 | The app has no plain use; on the Figma screens, a big figure |
| `iOS/Large Title/Semibold` | `.largeTitle.weight(.semibold)` | 34/41 | +0.40 | The player's closing line, `Today/RoutinePlayer.swift:558` |
| `iOS/Large Title/Bold` | `.largeTitle.weight(.bold)` | 34/41 | +0.40 | Onboarding's title, `Onboarding/OnboardingPages.swift:46` |
| `iOS/Title 1/Regular` | `.title` | 28/34 | +0.38 | The app has no plain use; on the Figma screens, Material's date header, which goes when that header does |
| `iOS/Title 1/Bold` | `.title.weight(.bold)` | 28/34 | +0.38 | A record number, `AllHabits/HabitProgressTab.swift:94` |
| `iOS/Title 2/Regular` | `.title2` | 22/28 | −0.26 | The player's goal, `Today/RoutinePlayer.swift:961` |
| `iOS/Title 2/Semibold` | `.title2.weight(.semibold)` | 22/28 | −0.26 | The player's name, `Today/RoutinePlayer.swift:291` |
| `iOS/Title 2/Bold` | `.title2.weight(.bold)` | 22/28 | −0.26 | A habit's name on its page, `AllHabits/HabitPageView.swift:140` |
| `iOS/Title 3/Regular` | `.title3` | 20/25 | −0.45 | `AddHabit/HowOftenEditor.swift:435` |
| `iOS/Title 3/Semibold` | `.title3.weight(.semibold)` | 20/25 | −0.45 | `Progress/WeekCards.swift:90`, `Today/DayBar.swift:87` |
| `iOS/Headline/Semibold` | `.headline` | 17/22 | −0.43 | A section's title, `Today/TodayRows.swift:499`; the same value as the system's navigation and alert titles |
| `iOS/Body/Regular` | `.body` | 17/22 | −0.43 | A habit's name, `Today/TodayRows.swift:71` |
| `iOS/Body/Medium` | `.body.weight(.medium)` | 17/22 | −0.43 | A Liquid Glass bar button's word (Edit), from Apple's kit; an alert's buttons (the iPhone's own). Added with the buttons, 5 Nov 2026 |
| `iOS/Body/Semibold` | `.body.weight(.semibold)` | 17/22 | −0.43 | `AddHabit/NewHabitView.swift:239`, `Today/RoutinePlayer.swift:571` |
| `iOS/Callout/Regular` | `.callout` | 16/21 | −0.31 | `AllHabits/HabitPageView.swift:146`, `Today/PauseSheet.swift:64` |
| `iOS/Callout/Semibold` | `.callout.weight(.semibold)` | 16/21 | −0.31 | `AddHabit/NewHabitView.swift:1160` |
| `iOS/Subheadline/Regular` | `.subheadline` | 15/20 | −0.23 | The line under a name, `Today/TodayRows.swift:75` |
| `iOS/Subheadline/Semibold` | `.subheadline.weight(.semibold)` | 15/20 | −0.23 | Start, `Today/TodayRows.swift:581` |
| `iOS/Footnote/Regular` | `.footnote` | 13/18 | −0.08 | "Starts 6 AM", `Today/TodayRows.swift:503` |
| `iOS/Footnote/Medium` | `.footnote.weight(.medium)` | 13/18 | −0.08 | The selected segment of a segmented control (the iPhone's own) |
| `iOS/Footnote/Semibold` | `.footnote.weight(.semibold)` | 13/18 | −0.08 | The date picker's weekdays (the iPhone's own) |
| `iOS/Caption 1/Regular` | `.caption` | 12/16 | 0 | `Progress/WeekCards.swift:41`, `Progress/HeatMap.swift:378` |
| `iOS/Caption 1/Semibold` | `.caption.weight(.semibold)` | 12/16 | 0 | A badge, `Today/TodayRows.swift:766` |
| `iOS/Caption 2/Regular` | `.caption2` | 11/13 | +0.06 | `Progress/HeatMap.swift:333` |
| `iOS/Caption 2/Semibold` | `.caption2.weight(.semibold)` | 11/13 | +0.06 | `Progress/ProgressScreen.swift:343` |

SwiftUI's `.title` and `.caption` are UIKit's Title 1 and Caption 1. The Figma names use the numbered form so the scale reads in order.

## Custom: not Apple's text styles

The app sets these two sizes itself, so **these names are ours; Apple has no name for them.**

| Figma style | SwiftUI | Font | Size / line | Tracking |
|---|---|---|---|---|
| `iOS/Custom/Clock` | `.system(size: 36, weight: .medium, design: .rounded)` | SF Pro Rounded Medium | 36/43 | +0.37 |
| `iOS/Custom/Amount` | `.system(size: 56, weight: .bold)` (`AmountNumberField` while typing) | SF Pro Bold | 56/67 | +0.35 |

The amount's line is 57.33 on the phone; the style rounds it to 57. Code: `Today/RoutinePlayer.swift:340`, `Today/AddLogView.swift:35`, `Today/LogRecordView.swift:169`.

## Accessibility 1

Apple's name for its first accessibility text size (`DynamicTypeSize.accessibility1`). It replaces the 200% group; Body is 28 at this size. Only the styles the large-text frames use are here. **The iPhone goes on to Accessibility 5 (Body 53), and that isn't drawn.**

| Figma style | Size / line | Tracking |
|---|---|---|
| `iOS/Accessibility 1/Title 1/Bold` | 38/46 | +0.37 |
| `iOS/Accessibility 1/Title 2/Semibold` | 34/41 | +0.40 |
| `iOS/Accessibility 1/Title 2/Bold` | 34/41 | +0.40 |
| `iOS/Accessibility 1/Headline/Semibold` | 28/34 | +0.38 |
| `iOS/Accessibility 1/Body/Regular` | 28/34 | +0.38 |
| `iOS/Accessibility 1/Subheadline/Regular` | 25/31 | +0.15 |
| `iOS/Accessibility 1/Subheadline/Semibold` | 25/31 | +0.15 |
| `iOS/Accessibility 1/Footnote/Regular` | 23/29 | −0.10 |
| `iOS/Accessibility 1/Caption 1/Semibold` | 22/27 | −0.26 |
| `iOS/Accessibility 1/Caption 2/Semibold` | 20/25 | −0.45 |
| `iOS/Accessibility 1/Custom/Clock` | 49/59 | +0.35 |

The clock's size here is worked out, not measured: the app scales 36 with `.title` (36 × 38 ÷ 28 ≈ 49) and caps it at 52.

## What iOS's own controls use

Read from real controls on the iPhone 16, iOS 26.6, at the default text size, with a throwaway app (`Research/Temp/ios-controls/`, git-ignored). **Measure a control; don't remember it:** notes said an alert's message is Footnote, and the phone shows Subheadline.

| Control | Text |
|---|---|
| List cell | Body; its subtitle Subheadline in Secondary Label; a value cell's value Body in Secondary Label |
| Grouped list header | 17 pt Semibold in Secondary Label, the same as `iOS/Body/Semibold` |
| Grouped list footer | Footnote in Secondary Label |
| Alert, action sheet | Title Headline; message Subheadline in Secondary Label; buttons Body at Medium weight; the preferred action Body Semibold |
| Segmented control | Footnote; selected Footnote Medium |
| Navigation bar | Inline title Headline; large title Large Title Bold |
| Search and text fields | Body |
| Buttons, every configuration | Mini and small 15 pt Regular; medium and large 17 pt Regular |
| Inline date picker | Month 17 Semibold; weekdays Footnote Semibold in Secondary Label; days Title 3 Regular, selected Title 3 Semibold |
| Time wheels | About 21–23.5 pt Regular, which has no name in the scale |

The list header and footer were read from UIKit; SwiftUI's `Form` wasn't read separately. A native menu couldn't be opened from code, so it wasn't measured.

**What changed in Figma because of this:** Segmented control (then Connected button) and Primary tab are Footnote, the selected one Footnote Medium. Button's Filled, Medium style is Body Semibold, from the app's own main action; other Medium buttons stay Body Regular, as iOS draws them. A section header ("Subheader") is Body Semibold. The date picker is month Headline, weekdays Footnote Semibold, days Title 3. A list item's trailing text is Body. The streak's emoji is Caption 1. The player's end title is Large Title Semibold, as in the app. Dialog, the top bar's title, search, fields, footers and Today's rows were already right.

**Where the app and iOS differ, left as they are:** form notes are `.callout` in the app (`AddHabit/NewHabitView.swift:1508`) and Footnote natively and in Figma. Alert buttons are Body Medium natively; the style is there, and Dialog takes it when it gets iOS's shape.

## What happened to the old styles

Android's 37 styles became 36; Footnote Medium later made 37, and Body Medium 38. Eight duplicates were deleted once no text used them (nothing on any page was left on them); seven styles the Android list had no place for were added: Large Title Semibold, Title 3 Regular and Semibold, Callout Regular and Semibold, Caption 1 Regular, Caption 2 Regular.

Text on the screens keeps its look: the merged styles already held the same values. **Beyond the date picker, no screen uses Title 3 or Callout yet**, so where the app uses those (form prompts, week cards), a Figma screen may still show a neighbouring size.

## Still open

- **Component descriptions still describe Material:** colour and text role words were replaced in 61 of 158, but 42 still mention Material or Compose, and 138 mention Android or `.kt` code paths. They go with the components, when those are redone for iOS.
- **Text typed straight in, not using a style, keeps its font:** Google Sans Flex about 3,100 pieces, Roboto about 1,600, Inter about 3,550. What was sampled is mostly Android's own parts (keyboard keys, the status bar, flow labels), plus text inside widgets. These go when those parts are redrawn for iOS.
- **The large-text frames have some overflow,** for example "Compared with the month before" (373 wide in a 296 card). Whether these were there before SF Pro wasn't checked.

## Checking this in Figma

- **`get_screenshot` can return an old picture of a frame** whose component changed: read the node's values, or export it from the file (`exportAsync`), before believing the picture.
- **`loadAllPagesAsync` isn't available through the plugin,** but `await page.loadAsync()` on each page works inside one script. Main components first on every page, then anything still left, so instances follow instead of gaining overrides.
- **`moveLocalTextStyleAfter` works only inside one folder.** To order styles across groups, order them while they share a folder, then rename them in that order.
