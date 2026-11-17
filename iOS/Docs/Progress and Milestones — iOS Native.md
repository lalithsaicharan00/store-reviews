# Progress, Milestones and Cards — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: "we have wavy, like a line progress, which is a material design expressive style … update it to match it the iOS … this leading icon, it should be circular here, it's square … Maybe three dots menu … I don't know iOS native how it should be. So you can do research on it and then update it."

Figma: file `zLgBjb7M7Fp6UN0pg7J3a8`, sections `10 · Progress & milestones` (`1299:2431`) and `11 · Progress cards & history` (`1299:2432`) on the design system page. The More button is in section 05.

## Where each part comes from

- **What iOS draws:** real SwiftUI on the iPhone 17 Simulator, iOS 26.5, in a throwaway app (`Research/Temp/ios-menus/card.swift`, git-ignored): five ⋯ treatments on a card, `ProgressView`, `Gauge`.
- **What the app does:** its code. The ring is `MilestoneNextRow` (`iOS/Habits/AllHabits/HabitProgressTab.swift`), the card is `WeekCardView` (`iOS/Habits/Progress/WeekCards.swift`).
- **What Apple says:** the Human Interface Guidelines, on pull-down buttons and context menus.
- **What Apple's own apps do:** screenshots of Health, Fitness, Shortcuts and News on the Simulator.

## What changed

| Component | Was | What it is now |
|---|---|---|
| **Progress bar** (`902:14527`) | Linear progress, Flat and Wavy | `ProgressView(value:)`: 4 tall, System Fill the full width, the fill on top, no gap, no end dot. Only a Value property |
| **Progress ring** (`1007:5`) | Circular progress, 52, filled arcs | The app's ring: 48, 5 thick, round ends, Tertiary System Fill behind the habit's colour, clockwise from the top |
| **Next milestone** (`1007:16`) | 16 between | 12 between; title Body Semibold |
| **Milestone pop-up** (`853:45861`) | Android's bottom sheet, handle, Close and All milestones | A Medium sheet with one height: 344, radius 38, glass, a glass ✕ at 16, 16, no handle, one Large Prominent All milestones. Inner card radius 26, 16 inside |
| **Milestones card** (`1007:24`) | Radius 24, 20 inside | Radius 26, 16 inside |
| **Habit history card** (`978:1598`) | Square icon, bare ⋮-style dots, radius 24 | 32 circle round the icon, More button, radius 26, 16 inside, name Headline, summary Title 3 Semibold, day rows reach the full 296 |
| **More button** (`4161:2553`) | New | See below |
| **Overall record card** (`1158:119643`) | Radius 24, 20 inside, `Text=200%` | Radius 26, 16 inside, `Text=Accessibility 1` |
| **Year in pixels card** (`1226:2470`) | Radius 24, cells 19.5 | Radius 26, 16 inside, cells 20.17 so the grid reaches both edges |

Milestone bar, Milestone ribbon, Milestone badge, Medal, Day cell and Stat tile keep their design, as the user said; only their descriptions changed. Every description in both sections now says what iOS and the app do, with no Material names, dp or Kotlin files.

## The three dots: is it native?

**Yes. iOS has this control, and calls it a More button.** Apple's guidance on pull-down buttons says to consider "a More pull-down button to present items that don't need prominent positions". It's meant for exactly this: Edit, Pause, Archive and Delete don't need their own place on a card.

So the ⋯ stays. What's Android's is its look (bare dots) and the idea that a long press could stand in for it. Apple's guidance on context menus says items there should also be in the main interface, so a hidden menu alone wouldn't do; here the button is in view. Long press isn't added: a long press does nothing on Habits (Android A55).

**Which ⋯.** Tried on a real card on iOS 26.5, radius 26, 16 inside:

| Tried | Size | What it looked like |
|---|---|---|
| Plain `ellipsis` | 18 × 5 | Android's bare dots again, and hard to see as a control |
| `ellipsis.circle` | 20 × 19 | A thin outline; the app uses it in bars on older pages |
| `.bordered` circle | about 19 | Ink at 18 %, small and faint |
| Glass circle | — | Glows on a white card; glass is for bars, not cards |
| **`ellipsis.circle.fill`, hierarchical, Title 2** | **26 × 25** | **Chosen.** One real SF Symbol, neutral, a clear circle, and the same family as the small grey circle Health puts on its cards |

Measured: the circle reads 204 grey (Ink at about 25 %), the dots Ink, the right edge 16 from the card's edge. The tap target is 44. In a bar, ⋯ stays a Glass button.

**The app's card has a chevron, not ⋯.** `WeekCardView` opens the habit from the whole card and has no menu. The user wants the menu on the card, so this is for when the iPhone app is rebuilt.

## Progress

- **An empty track is System Fill everywhere** (6 Nov 2026, the user: "use the gray"): the Timer ring and every Progress bar, never the habit's Fill, so it reads the same on white and on grey. 330 bars and 43 rings were checked on every page. A limit's ring is System Gray on the same track. The milestone Progress ring keeps Tertiary System Fill, already grey.
- **There's no wave on iOS.** Android showed a wave while a timer ran (A90). iOS has no such thing, so a running timer shows by its ticking clock.
- **The ring follows the app, not `Gauge`.** `Gauge` with `.accessoryCircularCapacity` is 58 with a see-through track; the app draws its own.
- **The ring's label is Body Semibold.** The app's is 17 Bold, 15 for three digits or more. No iOS text style here is Body Bold, so this is 1 weight lighter than the app.

## Other pages

- **8 of the bars were wavy,** not the "about 390" written in Menus and Sheets: 3 on Day details and 5 in the routine player. They kept their habit colours. There are about 470 bars in all.
- **141 rings** on Details, Habits and the design system page, and **18 pop-ups** on Today, Details, Day details and the routine player, moved from filled arcs to strokes. Each pop-up's habit colour moved with it.
- **Every pop-up** now sits 8 in from the sides and bottom, inside Milestone · Motion too.
- **892 history cards** on Habits, plus 142 on Details, took the new card.

## Checked

- No copy on any page points at a wavy bar, and none has lost its main component.
- All 892 Habits cards: 32 circle, More button 26, radius 26, 16 inside. All 54 Overall record, Milestones and Year in pixels copies on Details the same.
- By eye: Habits week, Details Progress, a pop-up on Details, the components themselves.
- Section 05, 10 and 11 content still fits inside its section.

## Not measured

- **The real iPhone.** All of this is from the Simulator.
- **Dark.** Figma has no dark screens here.
- **Long press on Apple's own cards** wasn't tried.

## Still Android's

- **The Day details sheet's insides** (`669:234`).
- **Frames are 360 × 800.** The phone's are 393 × 852, so Year's cells are 20 here and about 23 there.

## Checking this in Figma

- **A shape's arc with `innerRadius` 1 and a stroke with `strokeCap` ROUND gives a real round-ended ring.** At 0.85 with a fill the ends are square.
- **A copy keeps its own arc:** `innerRadius` was overridden on every copy, and each needed setting by hand.
- **A copy's fill override stays when the main's fill goes.** With `innerRadius` 1 it draws nothing, so the colour is lost unless it's moved to the stroke copy by copy.
- **A nested copy's size can't be overridden, and `resize` fails without a word.** To make a 26 button sit in a 24 slot: give the main HUG with a min and max of 26, then set HUG on the copy.
- **`height` read straight after a layout change can be stale** (434 then 450, 791 then 910). Read it in the next script.
- **FILL inside a HUG row collapses the row.** Cells need a fixed height, not FILL, in a row that hugs.
- **A description stores `'`, `"`, `&` and `<` as HTML entities.** Use ’ and “ ”, and write "and".
- **Delete variants only after counting their copies on every page.** This time the count came after, and happened to be clean.

## The player's milestone (6 Nov 2026)

Milestone ribbon is a capsule now: it hugs its words, 32 tall, in the habit's Milestone Band colour. It sits under the progress, where Goal met goes, because the player's page has no card edge for a band to hang from and Apple's [Feedback](https://developer.apple.com/design/human-interface-guidelines/feedback) page says status works best near what it describes. Habit, Time and 200 % keep its place (32, or 46 at 200 %), so nothing moves when it appears. In a checklist it's under the progress in the card, and the steps below it do move. Saved · Undo · Add note sits just above the bottom bar, so the two never overlap (read on every copy that shows both).

## In the app (17 Nov 2026)

Built from Figma's Progress and milestones page (`1299:2431`). iOS gives the progress bar (`ProgressView(value:)`, already used on Progress) and the activity indicator (`ProgressView()`), so they aren't ours. Everything below is, because iOS has nothing like it; each is one component, used everywhere it shows.

- **Medal** (`Components/Milestones.swift`): `MedalShape` is Android's nine-point star (`Medal.kt`, a 72 box), so both phones draw one medal. `Medal(number:size:color:)` fills it with the habit's Medal gradient, adds the white inner ring (the same star at 0.82) and the number in white. Large 104 (Title 1 Bold), Medium 72 (Title 2 Bold), 52 for a badge, Small 40 (Body), 16 with no number for a band or ribbon. The shadow is on the star alone (S10). Today's band uses the 16 medal in place of the old seal symbol.
- **Progress ring** (`ProgressRing`): a trimmed circle, 48 and 5 by default on Tertiary System Fill; `Gauge`'s circular styles are the Watch's and widgets' fixed sizes, so they don't fit.
- **Next milestone, Milestone badge, Milestones card** (`AllHabits/HabitProgressTab.swift`): the card's header is Body with See All N as a Small capsule button; Latest sits on the habit's Fill (radius 20, Medium medal); Earlier is up to three badges side by side (no sideways scroll); Next rows use the ring.
- **All Milestones** is an inset-grouped `List`: a line with the habit and how many are reached, then a section per track (In a row, In total, Since a slip) with its next milestone first and every one reached under it, as Milestone rows (72 tall, 48 slot, Small medal or ring). Figma's How Milestones Work row isn't there yet: the page it opens hasn't been built on the iPhone.
- **Timer ring** (`FocusProgressCircle`, shared by the Timer screen and the routine player): a `ProgressRing` 10 thick on System Fill, the habit's colour, System Gray for a limit (never red: "Over limit" is grey words too). The timer shows the habit's icon (28, its colour), the clock in SF Pro Light 64 with tabular figures (`CustomText.timer`, grows with Large Title up to 80) and "of 10 min" under it. The Timer screen's ring is 260 across at most. The clock's VoiceOver label is "6:42 of 20 min" (it was "6:42 / 20 min"; the player's tests changed with it, T3).
- **Milestone bar, pop-up and ribbon** (`Components/MilestoneMoments.swift`), with Android's keyframes to the millisecond (`Components/Motion.swift`: `Key`, `track`, Figma's easings as SwiftUI `UnitCurve`s, and `Playback`). `Playback` is an `Animatable` view moved by one linear `withAnimation`, so nothing ticks and it stops redrawing at its end (S3, S4); Reduce Motion shows it at rest.
  - **Bar**: on Today, over the bottom of the list, when a tap reaches a streak milestone; 5 seconds with its time-left line, swiped sideways or See to put it away. Only `TodayMilestoneBar` reads the store's milestone (S6).
  - **Pop-up**: See opens it, a sheet sized to its content with no handle and a glass ✕. All Milestones opens the habit's page with All Milestones on top (`HabitPageRoute.milestones`). Its title: "Your first milestone" for a habit's lowest rung, "…, again" when an earlier run reached it (`MilestoneOffer.again`: the best run is longer than the current one), otherwise the milestone.
  - **Ribbon**: in the routine player under the progress, its 32 points kept so nothing moves (`PlayerMilestone`).
- **Not ported from Android:** `MilestoneCenter`'s tiers (a pop-up by itself for a landmark, at most two bars a day, a band only for logs from a widget or notification) and its per-day records. On the iPhone the bar shows for every streak milestone a tap reaches, and the pop-up only from See. That's behaviour, so it's the user's call.
