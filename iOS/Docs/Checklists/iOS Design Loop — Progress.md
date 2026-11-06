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
| L | Streaks · All milestones | 1034:74 · 1036:235 | **Done** 6 Nov | Squeezed medals and rings replaced by a new Milestone row (DS 4256:2590), 15 rows with their numbers, arcs and colours; All Milestones title; Streaks unchanged | Habits Page report § L |
| M | Search (details pages) | 1053:9079 | **Done** 6 Nov | Results' day cells unsquashed; No Notes with “swim” as ContentUnavailableView above the keyboard | Habits Page report § M |
| N | Task details | 1136:9271 | **Done** 6 Nov | History cells unsquashed (24 pt, the task's colour); Nothing Done Yet as ContentUnavailableView; Edit Task / Move to Another Day… | Habits Page report § N |
| O | How milestones work | 1142:29063 | **Done** 6 Nov | Settings' grammar: Subheadline Semibold headers, Body rule + Subheadline detail in each card, 28 between sections; How Milestones Work title | Habits Page report § O |
| P | Create new (components 1061:2015, page 381:2) | 381:2 | **Done** 6 Nov | Add (Save on Edit) is the Prominent glass word on all 10 form types; Icon and Colour two rows, round swatch; Starts a compact picker, Ends a pop-up row (56 each); quit's Started/Time compact pickers; a task's Date a switch; Colour sheet one height, 13 colours shown; How Long and Limit › Time on Clock's wheels, How Much and Limit › Amount on the decimal pad; iOS's notifications alert, asked once (no Get reminders on time); popovers under their rows, no OK; December in the calendar; Title Case titles (131 bars) and choices; 64 captions, 28 frame names; DS: Glass button › Prominent 4258:37268, Date picker › December 4259:113261, Duration picker's upper values | [Creating a Habit on iPhone](<../../../Research/Research Reports/Habit Details Research/Creating a Habit on iPhone — One Prominent Add, Rows and the iPhone's Own Questions.md>) |
| Q | Settings | 804:79 · 781:34017 | **Done** 6 Nov | ☰; rows with trailing values, Title Case (Appearance, Haptics, Day Starts At…); Reminders section → one Notifications row; Backup & Sync iCloud only (no Change account, Delete My Data from iCloud…); Times of Day's FAB → row; Edit Time of Day compact picker, Prominent Save, red Delete row; Acknowledgements and Save to Files rebuilt for iPhone; Change account, Keep reminders coming (+6 phone-maker pages) and reminders-before-set-up flows deleted; Google steps out of first backup and restore; 69 captions | [Settings on iPhone](<../../../Research/Research Reports/Data, Sync and Accounts/Settings on iPhone — iCloud Only, Rows with Values and No Reminder Fixes.md>) |
| R | Plus | 1204:175 | **Done** 6 Nov | Get Plus · $29.99 a Large Prominent button with Restore Purchases (Small Borderless) under it in a 100 bar; Apple Account and iCloud words; Title Case titles and rows (55 texts); 5 copies on create new follow | [Plus on iPhone](<../../../Research/Research Reports/Business Model and Monetization/Plus on iPhone — One Large Button, Restore Purchases and the App Store's Sheet.md>) |
| + | Open from Today's review: History's Back to this week/month (Prominent); Android-only notices on Today | 54:5580 | **Done** 6 Nov | Back to This Week glass (G); notices: exact-alarm, late, battery and phone-maker flows deleted; backup paused/off/deleted say iCloud (no Google chooser); Reminders can't come as iOS's two cases (Turn On → iOS alert once; Open Settings); Plus waiting = App Store pending; unused Android components deleted | [Settings on iPhone § Today's notices](<../../../Research/Research Reports/Data, Sync and Accounts/Settings on iPhone — iCloud Only, Rows with Values and No Reminder Fixes.md>) |

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

**P · Create new** ([381:2](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=381-2)):
1. Prominent Add on the forms (as asked) but the plain glass word on the log and note sheets (§3): one rule for all?
2. Remind me with: An alarm → AlarmKit on iPhone, or notifications only at launch.
3. Time Sensitive reminders (through a Focus the person allows) or ordinary ones.
4. How Much's big number field, or a row as the log screens chose.
5. Compact pickers at 200 % text: beside the label (now) or stacked under it.

**Q · Settings** ([781:34017](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=781-34017)):
1. Notifications as a row in General (opens the app's page in iOS Settings), or no row.
2. "Backup & Sync" (one name with Android) or "iCloud".
3. Save to Files is drawn with our sheet; the real one is Apple's.

**R · Plus** ([1204:175](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=1204-175)):
1. Restore Purchases under the button (chosen) or only in the menu variant.
2. "Get Plus · $29.99" or the price alone, as StoreKit's product view.
3. A page for someone who already has Plus isn't drawn.

## Next

Every lettered screen (A–R) and the "+" item are done. Leftovers, one per iteration:
1. **Routine player, time habits** (906:89513): the clock should sit in the Timer ring (a Screen=Time variant).
2. **Live Activity** on the routine player page's 'outside the app' frames (958:157631, notes 260:225, 260:231) and the
   notifications & alarms page (1265:24553): Android's Live Update chip, heads-up notification and shade → iOS's Live
   Activity, notification banner and Notification Center.
3. History's Go to date flows (details pages 1150:76414 …) could show September.

## How the probes work

`claude/nice-hopper-dhgw5r-probe` holds a SwiftUI app (`Probe/`) whose screens are variants (`-variant name`) and a
UI test that screenshots them (`Shots.swift`). Pushing runs `.github/workflows/ios-probe.yml` on `macos-26`
(iPhone 17, iOS 26, 9:41). Our own screenshots come back on `claude/nice-hopper-dhgw5r-shots` (both branches safe to
delete); a cloud session can't download artifacts. Apple's apps come back as element trees (text) only; their
screenshots stay in the run's artifact (D11).
