# iOS Design Loop — Progress

Written by Claude (Claude Code), 6 November 2026 (IST), at the user's request: carry the iPhone design in the Figma
file "IOS app" (`zLgBjb7M7Fp6UN0pg7J3a8`) screen by screen, native to iOS, with Android's mental model. Design only:
no app code. Branch: `claude/nice-hopper-dhgw5r` (docs). Scratch branch for Simulator probes:
`claude/nice-hopper-dhgw5r-probe` (**safe to delete**, W3; screenshots are workflow artifacts only, D11).

How each screen is done (the brief's loop): look → ask (job, what's wrong, what's Android's, iOS's way) → research
(HIG, Apple's apps on the Simulator, reviews) → try 2–5 versions on the Simulator → fix the design system first →
update every copy on every page → correct captions, arrows and frame names → check by eye (incl. 200 % text) →
write it down (report, doc section, Rulebook, this file) → commit and push.

## Note on missing references (6 Nov 2026)

The brief names eleven `iOS/Docs/… — iOS Native.md` docs and two reviews (Today's notice card; Day details on
iPhone) from 5–6 Nov. **None of them is in git on any branch** (checked `main`, `ios-rebuild`, every remote branch
and all history on 6 Nov, 01:10 IST); they seem to be on another machine, unpushed. This loop therefore takes the
decided rules from the brief's §3, the finished Figma screens (Menu, Today, Edit Today, Day details 669:234) and
the design system page (493:2). Where a doc section would go, it is written in
[iOS Native — Design Loop Notes](<../iOS Native — Design Loop Notes.md>) under the doc's name, ready to move into
that doc when the docs are pushed (so nothing clashes with the unpushed files).

## Status

| | Screen | Figma | Status | What changed | Report |
|---|---|---|---|---|---|
| — | Menu, Today, Edit Today, Day details | 669:234 … | Finished before this loop (reference) | — | — |
| A | Timer screens | 705:7745 | **Done** 6 Nov | Large sheet; Timer ring + Clock buttons replace cookie, wave, chip and capsule pair; ✕, name over the day, Day Details word; Paused / Goal met / Over the limit; 13 copies (Day details 4, Today 3, routine player 7) restored; captions on 3 pages; 200 % frame 4230:447235; DS: Clock button 4228:2548, Timer ring 4228:2551, Navigation bar actions capsule | [Timer on iPhone](<../../../Research/Research Reports/Day Structure and Organization/The Timer on iPhone — Clock's Ring and Round Buttons.md>) |
| B | Log screens (Add log, Log view, Edit log, Delete log) | 687:829 | **Done** 6 Nov | Large sheet as Health's Add Data: rows, compact Date/Time pickers, Amount row on the decimal pad, Duration on Clock's wheels, Add/Save as glass words (off until there's an amount: Error → Empty), view with Edit in the bar and a red Delete row; 63 copies restored (day details 54, Today 6, routine player 3); captions; 200 % frame 4243:334448; DS: Number pad 4234:5418, Duration picker 4236:2507, List item › Show picker | [Logging on iPhone](<../../../Research/Research Reports/Day Structure and Organization/Logging on iPhone — Health's Rows, Compact Pickers and the Decimal Pad.md>) |
| C | Time picker · Date picker (every copy, every page) | 703:602 · 705:1025 | **Done** 6 Nov (months on K and P's flows still October) | Calendar popover (Limit variants, a circle per day) and time wheels popover replace Android's dialogs; 35 copies on 6 pages: scrims gone, anchored under their rows, values set, no OK steps | same report |
| D | Note screens | 765:1087 | **Done** 6 Nov | Large sheet: Add Note / Edit Note, Add / Save glass words (off while empty), note card, footer with the day, Apple's iOS keyboard (123, grey return); view with Edit in the bar and a red Delete Note row; 21 copies kept their words (habit layers moved, note a property); captions on 2 pages | [Logging on iPhone § D](<../../../Research/Research Reports/Day Structure and Organization/Logging on iPhone — Health's Rows, Compact Pickers and the Decimal Pad.md>) |
| E | Routine player | 906:89513 | **Done** 6 Nov (time habits' ring and the Live Activity still open) | Title menu with '1 of 3' under it; circle replaces the cookie (colours copied per copy); no hero card; Day Details button replaces the Today chip; Title Case words; 92 copies; captions | [Routine Player on iPhone](<../../../Research/Research Reports/Day Structure and Organization/The Routine Player on iPhone — Title Menu, Circles and Day Details.md>) |
| F | Your routine sheet | 907:29174 | **Done** 6 Nov | Already native (Medium sheet, Edit, grabbers); done row's trailing ✓ removed (✓ means selected on iOS), ▶ marks the current one, Done Semibold; 4 copies | Routine Player report § F |
| G | Habits page | 986:150825 | **Done** 6 Nov | Title menu Habits ⌄ (☰ · search +), period in a Today-style bottom bar, nothing pinned, Back to This Week glass, ⋯ centred (card component), ContentUnavailableView empty states; 52 copies; 64 captions; DS: Navigation bar › Title menu, ContentUnavailableView 4252:428521 | [Habits Page on iPhone](<../../../Research/Research Reports/Habit Details Research/The Habits Page on iPhone — Title Menu, Bottom Bar and Empty States.md>) |
| H | Archived habits · Search | 988:7736 · 991:8050 | **Done** 6 Nov | Archived Habits title; No Archived Habits as ContentUnavailableView; snackbar layers → Banner; letters keyboard component rebuilt from Apple's kit (all copies); No Results for “yoga” with one Large Add “yoga”; captions | Habits Page report § H |
| I | Tasks page | 999:1061 | **Done** 6 Nov | Tasks ⌄ title menu (☰ · search +) in 12 variants; One-time \| Repeating kept as content filter; No Tasks Yet / No Repeating Tasks as ContentUnavailableView with New Task; captions | Habits Page report § I |
| J | Archived tasks · Completed tasks | 1001:178 · 1002:230 | **Done** 6 Nov | One shape with Archived Habits (Title Case titles, intro line, one list, ⋯ with the way back and red Delete, Banner, ContentUnavailableView); Completed gained its intro; Mark as Not Done / Delete All Completed | Habits Page report § J |
| K | Habit details | 1020:4052 | **Done** 6 Nov | See All (no +); No Progress Yet / Nothing Here Yet as ContentUnavailableView; With Notes / Go to Date… buttons; 376 history day cells unsquashed (24 pt) in Water blue; Go to Date calendars anchored, September variant added to the Date picker; captions | Habits Page report § K |
| L | Streaks · All milestones | 1034:74 · 1036:235 | Not started | | |
| M | Search (details pages) | 1053:9079 | Not started | | |
| N | Task details | 1136:9271 | Not started | | |
| O | The page at 1142:29063 | 1142:29063 | Not started | | |
| P | Create new (components 1061:2015, page 381:2) | 381:2 | Not started | | |
| Q | Settings | 804:79 · 781:34017 | Not started | | |
| R | Plus | 1204:175 | Not started | | |
| + | Open from Today's review: History's Back to this week/month (Prominent); Android-only notices on Today | — | Back to This Week done in G (glass); notices still open | | |

## Left for the user

**A · Timer** ([705:7745](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=705-7745)):
1. ✕ (as every sheet) or a glass ⌄ ("put away, the clock keeps going") at the top left.
2. Day Details as a word in the bar (chosen) or inside ⋯ (hides it).
3. Should the ring's clock (SF Pro Light 64) become a text style, and what's its name?

**B · Log screens** ([687:829](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=687-829)):
1. Amount as a row (chosen) or the 48 pt number card.
2. Ask before deleting with an alert (kept, Cancel · Delete) or iOS 26's popover from the row.
3. Date format: "21 Oct 2026" (the file's) or the American "Oct 21, 2026".

**D · Notes**: Add for a new note (as Add Log) and Save when editing; the old screen said Save for both.

**E · Routine player** ([906:89513](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=906-89513)):
1. Day Details visible under the name (chosen) or first in ⋯.
2. The hero card removed on the habit and end screens.

**G · Habits page** ([986:150825](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=986-150825)):
1. Title menu (chosen) or a segmented Habits | Tasks in the bar.
2. The period in a bottom bar (chosen, as Today) instead of Android's pinned row.

## Next

Screen L, Streaks (1034:74) and All milestones (1036:235). Still open from E: a time habit in the player should use the Timer ring
(a Screen=Time variant); the player page's 'outside the app' frames still show Android's Live Update chip (iPhone:
Live Activity), with the notifications page. Carried over: History's Go to date flows (details pages 1150:76414 …) and
the create-new forms still show October in the new calendar: set their months and days in K and P.

## How the probes work

`claude/nice-hopper-dhgw5r-probe` holds a SwiftUI app (`Probe/`) whose screens are variants (`-variant name`) and a
UI test that screenshots them (`Shots.swift`). Pushing runs `.github/workflows/ios-probe.yml` on `macos-26`
(iPhone 17, iOS 26, 9:41). Our own screenshots come back on `claude/nice-hopper-dhgw5r-shots` (both branches safe to
delete); a cloud session can't download artifacts. Apple's apps come back as element trees (text) only; their
screenshots stay in the run's artifact (D11).
