# Components — Atoms Build Plan

Written by Claude (Claude Code), 28 October 2026, at the user's request: "work on the components one by one … work one
thing at a time … once something is perfectly implemented and done, then move to the next thing."

The design system page of the Figma file "Android app" (`sJptV3HAKYauEIGUxYS3qs`, page 493:2) is the source. Each atom is
built in the app (`app/src/main/kotlin/com/oftenenough/app/ui/components/`) as **Android's own Material 3 component**
wherever one exists, set up once so every screen gets the same thing, then the screens are moved onto it.

## The user's rules for this work (28 Oct 2026)

- **Android's own first.** A Material 3 component is used as it is; our text styles (A74) and colour roles (A75) come
  from the theme, never set on a screen.
- **Corner radius:** keep the native component's own corners. Change them only where the design is clearly different,
  never for a near match ("whatever we get from the native component, let's keep it as it is. Don't style it too much").
- **Outlined buttons are used** (the Button set keeps Outlined).
- **Form field:** where a design shows our grey form field (the habit and task forms), use ours, "because it is
  intentional"; everywhere a design shows Android's own text field, use Android's own.
- **Snackbar:** Android's snackbar, changed only to allow a second action where a design has two; its colours (the
  action's too) exactly as the design draws them.
- **One at a time:** an atom is done only when it's built, the screens use it, and the app compiles. Then the next.
- Design phase: a local compile is the check (no CI or device tests until the user says).

## Order and status

Status: ☐ to do · ◐ in progress · ☑ done (compiled).

### 0. Foundation

| # | What | Figma | Status |
|---|---|---|---|
| 0.1 | Colour roles in code: `Theme.kt`'s Material colour scheme takes A75's 32 roles and values | 02 · Colour | ☑ |
| 0.2 | Text styles in code: `Type.kt` matches A74 (Title Small, Body Emphasized; no Title 20) | 03 · Text styles | ☑ |

### 1. Android's own, as it is

**Material 3 Expressive (A76, 28 Oct 2026):** the app moves to Material 3 1.5 (1.5.0-beta02 until it is stable), which
has 1.2–1.5's components; 1.4 had none. Once it's in, 2.1's Medium and Large sizes, 1.20's wavy bar and the loading
indicator move from the hand-set versions onto Material's own.

| # | Atom | Figma | Android | Status |
|---|---|---|---|---|
| 1.1 | Icon button | 495:4 | `IconButton` | ☑ |
| 1.2 | Large icon button | 718:8242 | `FilledIconButton` / `FilledTonalIconButton`, large size, square | ☑ |
| 1.3 | Connected button + group | 967:611, 967:612 | `ButtonGroup` + `ToggleButton` | ☑ |
| 1.4 | Extended FAB | 1043:72991 | `SmallExtendedFloatingActionButton` | ☑ |
| 1.5 | Floating toolbar (the bar) | 581:145 | `HorizontalFloatingToolbar` | ☑ |
| 1.6 | Top app bar | 495:70 | `TopAppBar` | ☑ |
| 1.7 | Primary tabs | 964:219669, 964:219674 | `PrimaryTabRow` + `Tab` | ☑ |
| 1.8 | Drawer item | 625:46 | `NavigationDrawerItem` | ☑ |
| 1.9 | Search bar, search view header | 1114:1963, 1052:1960 | `SearchBarDefaults.InputField` | ☑ |
| 1.10 | Dropdown field | 1075:1967 | `ExposedDropdownMenuBox` + `OutlinedTextField` | ☑ |
| 1.11 | Checkbox | 1096:1974 | `Checkbox` | ☑ |
| 1.12 | Radio button | 737:167 | `RadioButton` | ☑ |
| 1.13 | Radio list item | 737:183 | `ListItem` + `RadioButton` | ☑ |
| 1.14 | Switch | 1070:246400 | `Switch` | ☑ |
| 1.15 | Filter chip | 1040:678 | `FilterChip` | ☑ |
| 1.16 | Assist chip | 764:448 | `AssistChip` | ☑ |
| 1.17 | Sheet drag handle | 737:14700 | `BottomSheetDefaults.DragHandle` | ☑ |
| 1.18 | Bottom sheet | 737:184 | `ModalBottomSheet` | ☑ |
| 1.19 | Menu divider | 734:74 | `HorizontalDivider` | ☑ |
| 1.20 | Linear progress (wavy, flat) | 902:14527 | `LinearWavyProgressIndicator` / `LinearProgressIndicator` | ☑ |
| 1.21 | Circular progress | 1007:5 | `CircularProgressIndicator` | ☑ |

### 2. Android's own, with a small setting of ours

| # | Atom | Figma | Android | Ours | Status |
|---|---|---|---|---|---|
| 2.1 | Button (Filled, Tonal, Text, Outlined) | 500:26 | `Button`, `FilledTonalButton`, `TextButton`, `OutlinedButton` | Sizes Small / Medium / Large, Round / Square | ☑ |
| 2.2 | Filled icon button (Today's round ✓ / +) | 559:24 | `FilledTonalIconButton` → `FilledIconButton` | Done: the habit's Colour, white glyph | ☑ |
| 2.3 | Icon | 528:47 | `Icon` | Material Symbols Rounded glyphs | ☑ |
| 2.4 | List item | 528:85 | `ListItem` | First / Middle / Last / Single corners; To do / Done; Plus label slot | ☑ |
| 2.5 | Menu, Menu item | 734:76, 734:73 | `DropdownMenu`, `DropdownMenuItem` | Destructive in Error; groups with gaps | ☑ |
| 2.6 | Snackbar | 778:444 | `Snackbar` | A second action; the design's colours | ☑ |
| 2.7 | Day toggle | 1075:1966 | `FilledIconToggleButton` | A letter or date number in place of an icon | ☑ |

### 3. Ours (Android has nothing like them)

| # | Atom | Figma | Status |
|---|---|---|---|
| 3.1 | Form field (the habit and task forms) | 1065:2120 | ☐☑ |
| 3.2 | Colour swatch | 1074:161495 | ☐☑ |
| 3.3 | Plus label | 1208:1983 | ☐☑ |
| 3.4 | Skeleton | 1030:2 | ☐☑ |
| 3.5 | Medal | 913:29957 | ☐☑ |
| 3.6 | Day cell | 977:635 | ☐☑ |

Not built: Status bar and Gesture navigation (Android draws them), the Google Drive logo (an image).

### 4. Later: built from the atoms

Habit row ☑ (4.1), Habit row · Swipe ☑ (4.2), Step row ☑ (4.3), Section header ☑ (4.4), Run row ☑ (4.5), Comparison row, Card notice, Milestone bar, Milestone
ribbon, Next milestone, Milestone badge, Milestone pop-up, Milestones card, Stat tile, Habit history card, Overall record
card, Year in pixels card, and the day navigation inside the floating toolbar.

## Log

What each atom changed, newest last.

- **0.1 Colour roles (28 Oct).** `Theme.kt`: `lightScheme` is the Figma file's 32 roles value for value (A75); `darkScheme`
  keeps the old dark colours under the same roles. The older shortcuts in `AppColors` (`ink`, `tonal`, `soft`, …) now
  each read one role, so every screen already shows A75's values; they go as screens move onto the atoms. Hand-typed
  colours still left (each goes with its atom): `MilestoneViews.kt` 215, 278; `TodayScreen.kt` 442 (snackbar action, 2.6);
  `DayDetails.kt` 148–149, 171 (drag handle, 1.17); `PlusParts.kt` 265, 313; `PlusPage.kt` 129 (progress track, 1.20);
  `RoutinePlayer.kt` 723, 1229–1231 (snackbar, 2.6).
- **0.2 Text styles (28 Oct).** `Type.kt`: Title 20 gone; Title Small (14/20 Medium) and Body Large / Medium / Small
  Emphasized added; Material's `titleSmall` slot is Title Small. Each Title 20 now uses what Figma uses there: the
  drawer's name and Progress's headline → Title Large Emphasized; the habit form's name → Body Large (Form field);
  Plus's status heading → Headline Small Emphasized; the player's big button labels → Title Large.
- **1.1 Icon button (28 Oct).** Figma: Material's own, 48 dp target, 24 dp glyph; every one is **On surface variant**
  (Material's standard icon button, 38 % when disabled) except a header's navigation icon at its start (back, close),
  which is **On surface**, exactly Material's top app bar defaults. Built as `StandardIconButton`
  (`ui/components/IconButtons.kt`): Material's `IconButton` with On surface variant, nothing else. Moved onto it: card
  ‹ › (Habit history, Progress's period bar; their own 40–45 % disabled colours gone), each row's and card's ⋮ (Habits,
  Tasks, the habit form's room page), the search headers' back and clear (Habits, notes, Help), Day details' ⋮, the
  routine player's ✕ and ⋮, the habit form's remove-step and remove-reminder ✕. Every `TopAppBar` lost its
  `navigationIconContentColor` / `actionIconContentColor` overrides, and Today's bar its icon tints: actions (search,
  add, ⋮, Arrange) are now On surface variant as drawn, where they were On surface. Left for later atoms: the hand-drawn
  headers' back/close (On surface already, become `TopAppBar` in 1.6) and the floating toolbar's ‹ › (On surface, 1.5).
  Noted, not changed: Figma's Day details sheet has no ✕ (code has one).
- **1.6 Top app bar (28 Oct).** Figma: Material's small top app bar (64 dp; title 16 dp in, 56 after an icon). What the
  design sets over Material's defaults: the bar is **Surface container** (the page), **Surface container high once
  something scrolls under it** (the Scrolled variants of Habits, Tasks and Habit details), the title **Title Large
  Emphasized**, a subtitle Label Medium in On surface variant. Built as `AppTopBar` (`ui/components/TopBar.kt`, Material's
  `TopAppBar` with those four things) and `NavigationIcon` (a plain `IconButton`, coloured by the bar). Material 1.4 has
  no subtitle slot, so the subtitle sits under the title in the title slot. Moved onto it: all 15 `TopAppBar`s (Today,
  Habits, Tasks, Completed, Archived, Habit details, Streaks, All milestones, Progress, the habit form and its pages) and
  the 7 hand-drawn headers (Settings, Arrange Today, Backup & Sync's pages, Plus's flow, the choice pages, the 6th-habit
  page, the Log / Note / All logs screens). Fixed on the way: titles that were Title Large Regular (Habits, Tasks,
  Completed, Archived, Streaks, Progress, Habit details' collapsed name) are now Emphasized as drawn; the scrolled bar
  (Habits, Tasks, Habit details) was Secondary container (#E2E2E2) and is now Surface container high (#E8E8E8); Today's
  and Progress's bar no longer pin themselves to one colour. Figma's Top app bar description said the bar never changes
  colour under a scroll; corrected to match its pages. The selection bars (Select habits / tasks) keep their Secondary
  container: they aren't in the design (A55 retired selecting several).
  Differences from Figma noted, not changed (screen content, for each screen's own pass): Settings has ← where Figma has
  ☰ (it's a drawer page); the 6th-habit page has ✕ where Figma has ←; titles "Arrange Today" (Figma "Edit Today"),
  "Completed" ("Completed tasks"), "Habits" ("Habits & Tasks").
- **1.7 Primary tabs (28 Oct).** Figma: Material's `PrimaryTabRow` exactly (48 dp, Label Large, a 3 dp indicator as wide
  as the label with a rounded top, a 1 dp Outline variant divider); active Primary, inactive On surface variant. Built as
  `PrimaryTabs` (`ui/components/Tabs.kt`): Material's row and tabs, setting only the inactive colour (Compose gives
  inactive tabs the active colour unless told) and the row's container (it has none in the design: the page, or the
  scrolled bar's colour when pinned). Moved onto it: Tasks (One-time · Repeating) and Habit details (Progress ·
  History). Fixed: the active tab and indicator were On surface (#1B1B1B), now Primary (#303030); Habit details'
  indicator was a fixed 56 dp, its divider hand-coloured: both now Material's own. Noted, not changed: A57 (23 Oct)
  makes Tasks' One-time · Repeating a connected button group (1.3), so Tasks leaves this atom when 1.3 is built.
- **1.8 Drawer item (28 Oct).** Figma: Material's `NavigationDrawerItem` with its own numbers and colours (56 dp, full
  pill, Label Large, selected Secondary container / On secondary container, unselected transparent / On surface
  variant), except the count, which is On surface variant on the selected row too. The drawer already used Material's
  item; it overrode every colour. Now it takes Material's and sets only the selected count (`ui/menu/Drawer.kt`, one
  use, so no wrapper). Fixed: unselected labels were On surface (#1B1B1B), now On surface variant (#474747); unselected
  rows painted their own white, now transparent on the sheet. Left for the drawer itself (a molecule): the sheet's
  colour, the header and the divider.
- **1.9 Search bar and Search view header (28 Oct).** Figma: the **Search view header** is Material's full-screen search
  header (72 dp, ←, the field, ✕ once typed, a Primary cursor) on the page's own colour, with Material's divider under
  it (the Search page); the **Search bar** is Material's collapsed bar, a 56 dp pill, except its colour: Surface
  container highest where Material's is Surface container high. Built from Material's own search field
  (`SearchBarDefaults.InputField`) in `ui/components/Search.kt`: `SearchHeader`, `SearchBarField` (typed in place) and
  `SearchBarButton` (the pill that opens a full-screen search). Material's `SearchBar` itself isn't used: it animates
  between the two and owns the results' layout, while the app's pages already swap the bar for the header and list
  their own results. Moved onto them: the searches of Habits, Tasks and Completed tasks and of a habit's notes
  (header), the notes' pill (button), Help and the icon picker (bar). Fixed: four hand-made `BasicTextField`s gone; the
  headers were Secondary container, now on the page as drawn, with the divider they lacked; the cursor was On surface,
  now Material's Primary; the notes' header was 64 dp, now 72; the pills were Secondary container (#E2E2E2), now
  Surface container highest (the same value, the design's role). Figma's Search bar had no description; written.
- **1.10 Dropdown field (28 Oct).** Figma: Material's outlined exposed dropdown with every value Material's default
  (56 dp, 4 dp corners, a 1 dp Outline border, the label Body Small in a gap in the border, the value Body Large On
  surface, ▾ On surface variant). Used in How often › On a date (**Repeat on**: Dates, The last day, A weekday;
  **Which** and **Day** side by side; for a year **Month** and **Day** side by side, 16 apart) and How much / Limit
  (**Unit**, full width, 16 under the number). Built as `DropdownField` (`ui/components/Dropdown.kt`):
  `ExposedDropdownMenuBox` around a read-only `OutlinedTextField`, setting nothing; a second form opens a page instead
  of a menu (Unit, whose choices are their own page with search). Moved onto it: the Repeat on choice was three
  segmented buttons; the weekday was "The [first ▾] [Friday ▾] of the month" in 40 dp pills; the year was two pills
  ("October ▾" "23rd ▾"); the unit was a 40 dp pill. Now as drawn: "First … Last" capitalised, the year's day a plain
  number ("23"). Noted, not changed: the menu under the field is Material's for now and takes the app's menu look
  with 2.5 (Menu); How often's own differences from Figma (the date circles' fill, the "Every N months" row Figma
  doesn't show) belong to the How often page, not this atom; `MenuPill` stays only for App Lock (`PrivacyLock.kt`), not
  in the first version and not in Figma.
- **1.11 Checkbox (28 Oct).** Figma: Material's checkbox with Material's colours (an 18 dp box, 2 dp corners, a 40 dp
  state layer; ticked Primary with an On primary tick, not ticked a 2 dp On surface variant outline, disabled 38 % On
  surface). The component itself has no instances; the Step row (575:136) draws the same box and says the one setting:
  on a habit's own rows the ticked box is the habit's colour with a white tick. Built as `AppCheckbox`
  (`ui/components/Checkbox.kt`): Material's `Checkbox`, defaults, or `habitColor`. Moved onto it: the form's check rows
  (`CheckRow`: Time of day, Reminders' settings and the rest), the routine player's steps and Day details' steps. Fixed:
  the form's ticked box was On surface (#1B1B1B), now Primary (#303030); the player's empty box was On surface, now On
  surface variant; Day details' box was drawn by hand (and didn't dim when disabled), now Material's. Noted, not
  changed: Figma's Step row doesn't cross out a ticked step and puts the text 48 from the box's start (the code crosses
  it out, 40): the Step row molecule. Habits and Tasks still have row selection with `Role.Checkbox`, retired by A55;
  it goes when that code is removed.
- **1.12 Radio button (28 Oct).** Figma: Material's radio button with Material's colours (a 20 dp ring in a 40 dp state
  layer; selected Primary, unselected On surface variant, disabled 38 % On surface); used only inside the Radio list
  item (1.13). Material's `RadioButton` is used as it is, with nothing set, so there's no wrapper (as 1.8). Every radio
  in the app overrode its colours; all now take Material's: the form's choice rows (`RadioRow`), Arrange Today's card
  choice, Habits' sort and view choices, the Pause sheet and the widget setup screen. Fixed: selected was On surface
  (#1B1B1B), now Primary (#303030); on Habits and the Pause sheet the unselected ring was On surface too, now On
  surface variant (#474747). Left for 1.13: the rows around them. Not a radio: the group page's habit picker (a
  multi-select drawn with ✓ circle icons; Today's groups aren't in the v1 designs).
- **1.13 Radio list item (28 Oct).** Figma: Material's list item with a leading radio (56 dp with one line, 72 with
  supporting text; Body Large On surface over Body Medium On surface variant; no fill; the whole row taps), edge to
  edge. All 32 instances are the Pause sheet's four lengths. Built as `RadioListItem` (`ui/components/RadioListItem.kt`):
  Material's `ListItem` with Material's `RadioButton`, `selectable` as a radio button, its container transparent so it
  sits on the sheet. Moved onto it: the Pause sheet, whose rows were hand-made 64 dp rows inside the sheet's 24 dp
  padding; they now run edge to edge at Material's 72 dp, 8 under the sheet's text, as drawn. Noted, not changed:
  Material puts the label 56 from the edge where Figma's frame says 52 (native kept); the sheet's title, text and
  buttons (still 24 in, Figma's text 16) go with 1.18; radio rows in dialogs (Show habits by, Move to group, Arrange's
  Move to) are the dialogs' own; the form's choice rows and the widget setup's choices sit in segmented lists and go
  with List item (2.4).
- **1.14 Switch (28 Oct).** Figma: Material's switch with Material's colours (52 × 32; on, a Primary track and a 24 dp
  On primary handle with a ✓; off, a Surface container highest track, a 2 dp Outline border and a 16 dp Outline
  handle), at the end of list items (reminders, milestones, settings) and in How often's On set days. Built as
  `AppSwitch` (`ui/components/Switch.kt`): Material's `Switch`, colours untouched, the ✓ in Material's own icon slot
  (`thumbContent`, in Material's On primary container). It replaces `InkSwitch`, which set every colour: moved over
  are the form's switch rows (`SwitchRow`: Remind me, Tell me at milestones, and the rest), the task form's Time,
  Settings' switches, Today's groups and App Lock. Fixed: the on track was On surface (#1B1B1B), now Primary (#303030);
  off, the handle and border were On surface variant (#474747), now Outline (#777777); the off track was Secondary
  container, now Surface container highest (the same #E2E2E2 in light; Material's role in dark).
- **1.15 Filter chip (28 Oct).** Figma: Material's filter chip with Material's colours (32 dp, 8 dp corners, Label Large;
  not selected a 1 dp Outline variant border and On surface variant label; selected Secondary container with a ✓, On
  secondary container). Used for History's All · With notes, How long's quick picks (5 min … 1 h) and Weekdays ·
  Weekends. Built as `AppFilterChip` (`ui/components/Chips.kt`): Material's `FilterChip`, the ✓ as its leading icon
  when selected, nothing else set. Moved onto it, replacing four hand-made chips: History's `PageChip` (All, With
  notes), How long's `FilterPill`, `ChoicePill` (Weekdays · Weekends; Progress's groups) and Today's group `Chip`.
  Fixed: `ChoicePill` was a 40 dp pill, 10 dp corners, filled On surface when chosen with "✓" typed into its text, now
  Material's; the others drew their own borders and fills (the quick picks' border was Outline, now Outline variant;
  labels were On surface, now On surface variant until chosen). Noted, not changed: Figma's quick picks include 1 h 30
  min, 2 h and 3 h on some screens the code doesn't offer (the How long page's content, not this atom); Go to date
  stays hand-made until 1.16 (Assist chip); the Weekdays · Weekends chips never show as chosen, as drawn.
- **1.16 Assist chip (28 Oct).** Figma: Material's outlined assist chip with Material's colours (32 dp, 8 dp corners,
  a 1 dp Outline variant border, no fill; an 18 dp calendar icon in Primary, the label Label Large On surface). Used
  for History's Go to date, the note screen's date and the routine player's day ("Today", which opens Day details).
  Built as `AppAssistChip` (`ui/components/Chips.kt`, beside the filter chip): Material's `AssistChip`, the calendar
  icon by default. Moved onto it: all three, each hand-made before (History's `PageChip` is gone; its All · With notes
  call the filter chip directly). Fixed: the icons were On surface, now Primary; the note's border was Outline, now
  Outline variant; the player's chip was a filled Surface container highest pill with a › and 6 dp gaps, now the
  outlined chip as drawn, without the ›. Noted: the player's chip lost its spoken "Open Day details" (Material's chip
  has no click label); it still reads as a button named "Today".
- **1.17 Sheet drag handle (28 Oct).** Figma: Material's handle (32 × 4, full corners, On surface variant, 22 above and
  below: 48 in all), in the Bottom sheet, Day details and the milestone pop-up. Material 1.4's
  `BottomSheetDefaults.DragHandle`, which `ModalBottomSheet` draws by itself, is exactly that (with TalkBack's expand,
  collapse and close actions), so there's no wrapper: a sheet passes no `dragHandle`. Five sheets already did. Fixed:
  Day details drew its own (#79797E at 50 %, 16 above and 4 below) and the milestone pop-up its own (Outline at 40 %,
  12 above, nothing below); both now Material's, so each sheet's content starts 24 and 32 dp lower, as drawn. Day
  details' hand-typed divider and Skip outline colours (#E2E2E6, #C7C7CC) aren't the handle's: they go with the
  dividers (1.19) and Button (2.1).
- **1.18 Bottom sheet (28 Oct).** Figma: Material's modal sheet (Surface container low, #F3F3F3; 28 dp top corners;
  Material's handle, 1.17), with an optional header (a Top app bar on the sheet's colour, Title Large Emphasized, 16 in),
  any content, and optional actions (Text and Filled buttons, right-aligned, 16 in, 8 apart), 24 under everything. Day
  details (669:234) and the milestone pop-up (853:45861) are the same sheet with content of their own. Built as
  `AppBottomSheet` (`ui/components/BottomSheet.kt`): Material's `ModalBottomSheet` with its own colour, shape, handle
  and scrim, opened whole and scrolling, with the header and actions as the design draws them. Moved onto it: the Pause
  sheet (header "Pause …", the words under it 16 in, its four radio list items edge to edge, Cancel · Pause) and the
  Colour sheet (header "Colour", the swatches 8 under it, 16 in). Fixed: every sheet set its own colour, and none was
  the design's: Pause, Colour and Today's groups were Surface container lowest (white), Get reminders on time, Day
  details and Your routine Surface container; the milestone pop-up was already right. All seven now take Material's,
  and the four that set a 28 dp shape of their own don't. Pause's and Colour's titles were Headline Small 24 in, now the
  header as drawn. Noted, not changed: Get reminders on time, Your routine, Day details, Today's groups and the
  milestone pop-up keep their own content on `ModalBottomSheet` (no header in the design, or content that is a molecule
  of its own); the Description and Let alarms fill the screen sheets in Figma have no sheet in the code yet; they
  take this one when they're built.
- **1.19 Menu divider (28 Oct).** Figma: Material's divider, 1 dp Outline variant (#C6C6C6), 12 in from the menu's sides
  and 2 above and below (Material's menu divider padding), between a menu's groups; ten uses. Every other line in the
  design (Primary tabs, the history card's dividers and gridlines) is the same Outline variant, Material's own divider
  colour. Built as `MenuDivider` (`ui/components/MenuDivider.kt`): Material 1.4's `HorizontalDivider` with that padding
  (1.4 has no menu divider padding of its own; 1.5's `MenuDefaults.HorizontalDividerPadding` is the same 12 and 2).
  Moved onto it: the six menus with a divider (Habits, Tasks, Archived, Habit details' habit and task menus, Day
  details). Fixed: all six were Secondary container, edge to edge with no gap, now as drawn; the three dividers outside
  menus (Progress's comparison, the Plus card, Day details' This day) were Secondary container or a hand-typed #E2E2E6,
  now Material's colour, and `DividerLight` is gone. Noted, not changed: the Day details sheet in Figma (669:234) has
  no line in This day at all (goes with the Day details molecule); the drawer's line (16 in, 8 above and below, Outline
  variant at 60 %) goes with the navigation drawer.
- **1.20 Linear progress (28 Oct).** Figma: two styles, values in steps of 10. **Flat** (neutral progress: where a
  routine is, the widgets, the reminder notification): Material's indicator as it is, 4 dp, Primary on Secondary
  container, a 4 dp gap and a 4 dp Primary stop dot, no track at 100. **Wavy** (a habit's own progress: the player's
  and the alarm's hero cards, Day details): 10 dp high, a 4 dp wave 3 dp each side of the middle and 40 dp crest to
  crest in the habit's Colour, a 4 dp gap, the track in the habit's **Fill** (Figma's "Habit / … / Fill", e.g. Red
  #FBE3DF) with a stop dot in its Colour; the notice card's saving bar is the wavy one in Material's colours (Primary on
  Secondary container). Material 1.4 has the flat indicator but not the wavy one (that's 1.5's
  `LinearWavyProgressIndicator`, like 1.2–1.5). Built: flat, no wrapper (Material's `LinearProgressIndicator`, nothing
  set); wavy, `WavyProgress` (`ui/components/Progress.kt`, moved out of `Shapes.kt`), drawn by hand to Material's and
  Figma's measurements with Material's colours by default, and a progress bar to TalkBack. Theme: `c.habitFill` holds
  Figma's 13 Fill colours (light; dark, the colour at 24 % on the card, as Figma draws no dark habit styles). Moved onto
  them: the player's routine bar (was a hand-drawn bar in ink on a hand-typed #D5D5DA), the Plus page's free-habits
  bar (6 dp, ink, no gap or stop) and the player's and Day details' habit bars (wavy, the habit's colour). Fixed: the
  wave was 20 dp crest to crest and 1.8 dp high with a 6 dp gap, now 40, 3 and 4; the habit tracks were the colour at
  22 %, now its Fill; the notice card's saving bar was a flat 6 dp ink bar on Surface container highest with no gap or
  stop, now the wavy bar as drawn. Noted, not changed: Material's wavy bar flattens near 0 and 100 %, Figma's stays wavy
  (kept as Figma); the player's over-the-limit line (a full grey line, Figma 9.2) stays with the hero card; the widgets'
  bars are Glance's own (Glance has no Compose indicator); the alarm screen's hero card isn't built yet; the notice
  card's spinner goes with 1.21.
- **1.21 Circular progress (28 Oct).** Figma: a determinate ring toward a track's next milestone, 52 dp, a 3.9 dp band
  (inner radius 0.85), the habit's **Band** behind (e.g. Blue #CDD4EA) and its Colour filling clockwise from the top,
  the number in the middle (Title Medium On surface; Label Large from three digits). One place: the Next milestone
  specimen (the habit page's Progress, All milestones, the milestone pop-up). Built as `AppCircularProgress` and
  `CircularProgressLabel` (`ui/components/Progress.kt`): Material's own `CircularProgressIndicator` at 52 dp with its
  own 4 dp band, round ends and 4 dp gap, only its colours set; `c.habitBand` holds Figma's 13 Band colours (light;
  dark, the colour at 28 % on the card). Moved onto it: the habit page's `MilestoneRing` and the milestone pop-up's
  ring, both hand-drawn before. Fixed: their tracks were the colour at 20 %, now its Band; the pop-up's label went to
  Label Medium only past three digits, now Label Large from three as drawn. Noted, not changed: Material's ring has a
  4 dp gap between the fill and the track and round ends, which Figma's arc doesn't draw (kept as Android's, the
  user's rule on native details); the notice card's spinner (an indeterminate ring in a Surface container highest
  disc) is an icon in Figma's Card notice (Secondary container), so it goes with that molecule; Today's day bar ring
  (`MiniRing`) belongs to a day bar the new Today has no Figma for.
- **2.1 Button (28 Oct).** Figma: four styles in three sizes and two shapes, all used on screens (about 190 instances).
  **Filled** (Primary / On primary) for the one main action; **Tonal** (Secondary container) beside it; **Text** (no
  container, On surface variant) for Cancel and quiet actions; **Outlined** (1 dp Outline variant, 2 on Large; On
  surface variant) for Skip today, Delete log, Close. **Small** 40 dp, 24 at the sides (16 before an icon), icon 20,
  Label Large; **Medium** 56, 24, icon 24, Title Medium; **Large** 96, icon 32, gap 12, Title Large; **Round** (full)
  or **Square** (12, 16, 28). Material 1.4's four buttons are the Small size as they are; Medium and Large are Material
  3 Expressive's sizes (1.5), so their heights, sides, icon and label are set by hand to the same tokens. Built as
  `AppButton` with `ButtonStyle` and `ButtonSize` (`ui/components/Button.kt`): Material's `Button`,
  `FilledTonalButton`, `TextButton` and `OutlinedButton`; set only: the sizes, the square shape, Text and Outlined
  labels On surface variant (Material's are Primary), Outlined's border Outline variant (Material's is Outline),
  `destructive` (the label in Error: Delete, Remove, Erase, D9), a switched-off Filled or Tonal made solid on the
  surface (it can float over a list), and `compact` (12 at the sides for a button filling a share of a row). Large keeps
  16 at the sides: every Large button fills a set width with its label centred, and Material's 48 cut "Mark done" to
  "Ma…" in the player's 184 dp slot (Figma's own drawing runs past its 48). Moved onto it: **132 buttons**. That's 76
  Text buttons (every dialog's OK, Cancel and Delete, the pickers, Undo, Resume, Note for the day); every `InkButton`,
  `TonalButton` and `PlainButton` (all three deleted); the hand-set Material buttons (Add / Save / Done / Create in
  forms and dialogs, Delete time of day, the record pickers' `Pill`, See what's in Plus, Open settings); the Plus
  flows' `MainButton`, `QuietButton`, `DialogButton` and `PlusTonalButton` (now one line each); the routine player's
  and timer's big buttons (Large, square); and the hand-drawn boxes (Delete | Edit, New group / Not now, New habit
  "…" in search, Start from an idea, the sixth habit's Get Plus and Make room, Archive, the milestone pop-up's Close
  and All milestones, Day details' Skip today and logging buttons). Fixed:
  - Main actions were ink (On surface), now Primary.
  - Tonal ones were other greys (Surface container highest, `soft`), now Secondary container.
  - Text buttons were ink, now On surface variant.
  - Outlines were Outline or a hand-typed #C7C7CC, now Outline variant; `SkipLineLight` is gone.
  - Heights of 48 and 52 are now 40 or 56; Day details' logging buttons are Medium (Filled for what the goal asks,
    U16, else Tonal) where they were hand-drawn 52 dp boxes.
  - Delete time of day was a tonal button with red text and an icon, now Outlined Medium in red as drawn.
  - Delete | Edit is Outlined (red) and Filled, Medium.
  - The player's "+1" label was a size up (Headline Small), now Title Large like every Large label.
  - Return to unfinished was 64 dp, now Medium (56).
  - Icons were 18 dp, now the size's own (20, 24, 32).

  Noted, not changed: the snackbars' action buttons go with 2.6; the player's ‹ › are icon buttons (1.2); Continue with
  Google or Apple keeps their own branding; the two coach marks' Got it (retired by A48) are untouched. Figma itself
  draws Delete log both Text and Outlined (Log screen ×5 Text, ×2 Outlined): the code uses Outlined everywhere, with
  Delete note. Figma's timer says "Log time", the code "Log manually". The habit form's Open settings still swallows
  a failure (U40's build work, not this atom). The Figma description said "No outlined buttons"; it now describes
  Outlined and Large.
- **2.2 Filled icon button (28 Oct).** Figma: two states in two sizes, full round, a 24 dp filled glyph. **Neutral**
  is Surface container highest with an On surface variant glyph; **Done** is the habit's Colour (the style is
  *Habit / … / Colour*, not Strong as the plan said) with a white glyph. **Small** 40 dp: Today's row (✓ + ▶ ⏸ ⌄),
  the − and + of a number in How often; **Medium** 56 dp: the icon picker, five to a row of 328 (space between, 12
  apart). Built as `AppFilledIconButton` with `IconButtonSize` (`ui/components/FilledIconButton.kt`): Material's own
  `FilledIconButton` (40 dp in a 48 dp target, its ripple); set only the two states' colours (the change fades over
  220 ms), the 56 dp size, and a done button switched off keeping its colour at 38 % (a past day still reads done).
  Moved onto it: the 7 Today-row buttons and the habit form's preview (`RoundActionButton`, deleted), the number
  steppers (`StepButton`, now one line) and the icon picker's cells. Fixed:
  - Today's neutral glyph was ink (On surface), now On surface variant.
  - The steppers were Secondary container, now Surface container highest (the same grey in light mode).
  - The icon picker was six to a row of white squares with 16 dp corners (round only when chosen), now five round
    56 dp buttons, Surface container highest, as drawn.
  - The hand-drawn boxes had no ripple; now Material's.
  Noted: the round leading icon discs (settings, Backup, Restore, Plus) belong to List item (2.4) and the day circles
  to Day toggle (2.7). The widgets' "+1" round button is Glance, built with the widgets.
- **The switch to Material 3 1.5 (28 Oct, Android A76).** `app/build.gradle.kts` pins
  `androidx.compose.material3:material3:1.5.0-beta02` over the BOM (back to the BOM's version once 1.5 is stable).
  What 1.5 broke or deprecated, fixed: the dropdown menu is a top-level function now (`ExposedDropdownMenu` needs its
  own import); `rememberModalBottomSheetState` gave way to `rememberBottomSheetState`, so every sheet uses one
  `rememberWholeSheetState()` (hidden or expanded, never half-open; `BottomSheet.kt`); `ListItem`'s headline is its
  trailing content (`RadioListItem`); the search field keeps its text in a `TextFieldState` and a `SearchBarState`, and
  `Search.kt` keeps it the same as the screens' String (what's typed goes out; a cut, ✕ or Back comes back in). A full
  rebuild shows no other new warnings. Moved onto Material's own:
  - **1.20's wavy bar** is `LinearWavyProgressIndicator` as it is (it now flattens near 0 and 100, Material's way).
  - **The loading indicator** is `ContainedLoadingIndicator` (the design's colours and 64 dp kept).
  - **2.1's sizes** take Material's heights, padding, icon sizes and icon gaps (`ButtonDefaults`), and its press
    shapes: round and square buttons now square up a little while pressed (Expressive's shape morph). Kept of ours:
    Large's 16 at the sides (Material's 48 cuts "Mark done") and `compact`'s 12. **Changed by Material:** a Small
    button has 16 at the sides where Figma draws 24 (Expressive's Small). Large labels stay Title Large as Figma
    draws them; Material's own is Headline Small.
- **1.2 Large icon button (28 Oct).** Figma: Filled (Primary, On primary) and Tonal (Secondary container, On
  secondary container), Narrow 64, Default 96 and Wide 128, 96 high, 28 corners, a 32 filled glyph. Used for the
  routine player's ‹ › (Tonal Narrow; both fill the row when there's no main button) and the timer's Pause and Resume
  (Filled Wide, beside Log time). Built as `AppLargeIconButton` with `LargeIconWidth` (`ui/components/FilledIconButton.kt`):
  Material 1.5's own `FilledIconButton` and `FilledTonalIconButton` at `largeContainerSize`, `largeSquareShape` and
  `largePressedShape`, `largeIconSize`; nothing set but the width. Moved onto it: the player's `SideButton` (deleted)
  and the timer's main button. Fixed:
  - The player's ‹ › were 56 wide, now 64 (Narrow).
  - Their colours were Surface container highest (`behind`) and ink, off at ink 6 % and 30 %; now Secondary container
    and On secondary container, off in Material's disabled colours.
  - The timer's Pause / Resume was a Large button with words, half the row; now the Wide icon button (128) as drawn,
    and Log manually takes the rest. TalkBack still reads the action's own words (`spoken`).
  - Figma: the component's fills were typed hex; now linked to the colour styles, and its description names the code.
  Noted: Figma's timer says "Log time", the code "Log manually" (not changed here).
- **1.3 Connected button group (28 Oct).** Figma: the Connected button (Selected / Unselected × Start / Middle / End)
  and the group (Week · Month · Year), 24 instances: the Habits page's Week · Month · Year, the Tasks page's One-time ·
  Repeating (in the list and in both empty states), How often's periods, and the Limit page's Amount · Time. 40 dp,
  Label Large, 16 at the sides, 2 apart; not chosen Secondary container with the outer ends round and the inner corners
  8; chosen Primary, fully round, a ✓ before the label. Built as `AppConnectedButtons` (`ui/components/ButtonGroup.kt`):
  Material 1.5's own `ToggleButton`s with `ButtonGroupDefaults`' connected shapes and space. Set only: not chosen in
  Secondary container (Material's Surface container is the page's own colour), Material's ✓ shown when chosen, 12 at
  the sides with three or more choices so "✓ Weeks" fits Figma's 97 dp, and a long label wrapping instead of being
  cut. TalkBack reads each as a radio button. Moved onto it: How often's five choices (`Segments`, deleted: an ink
  segmented button on white) and the Tasks page's One-time · Repeating. The Tasks page change, as A57 decided: the
  choice was pinned Primary tabs under the top bar; now it's the list's first row, 16 from the top and scrolling away
  with it, and it stays above both empty states. The buttons keep the tags `tasks-tab-0` and `tasks-tab-1`.
  Noted, not changed (each is the screen's own work, not the atom's):
  - The Habits page has no Week · Month · Year in the code yet.
  - The Limit page draws Amount · Time; the code puts Time in the unit list instead.
  - "Again after" offers Days · Weeks · Months · Years; Figma draws Days · Weeks · Months. With four, "✓ Months"
    can't fit a quarter of a 360 dp phone.
  - The short-month and 29 February choices aren't in Figma; they use the same group.
- **1.4 Extended FAB (28 Oct).** Figma: one component, 56 high, 16 corners, 16 and 20 at the sides, 12 between the
  icon and the label (Title Medium), Primary with On primary, Elevation Level 3, 16 from the right and above the gesture
  bar. 14 instances: History's **Add** (every History state but archived, where it's hidden), Task details' **Add note**
  (`edit_note`; not done, done, repeating, menu open) and Times of day's **Add time of day**. Built as `AppExtendedFab`
  (`ui/components/Fab.kt`): Material 1.5's own `SmallExtendedFloatingActionButton` with its own sizes, padding, label
  style and shadow; set only Primary (Material's is Primary container, our light grey). Moved onto it: History's Add
  and Times of day's Add time of day, which were Material's older extended FAB in ink with a hand-set 12 dp gap and
  label. Material's gap after the icon is its own (Figma 12).
  Noted, not changed: Task details has no Add note button in the code; Figma doesn't say which day's note it opens
  (today's, or the task's own day), so it waits for that.
- **1.5 Floating toolbar (28 Oct).** Figma: the day bar over Today (7 instances), Material's own tokens: 64 high, fully
  round, 8 at the ends, 4 between, 16 from each edge (328 on a 360 dp phone), Surface bright, Material's shadow and no
  outline; content On surface. Inside: ‹ and › (icon buttons, 48 dp), and centred between them the day's ring (20 dp,
  On surface on Outline variant, from twelve o'clock), the day ▾ (Title Medium) and the count (Label Large, On
  surface variant). Built on Material 1.5's own `HorizontalFloatingToolbar` (`DayBar`, `ui/today/TodayScreen.kt`), with
  its own height, shape, padding and shadow; set only Surface bright (Material's Surface container is our page).
  Fixed:
  - The bar was a hand-made `Surface`: 320 wide, white (`surface`) with a 1 dp ink outline at 8 % and a 10 dp shadow.
    Now Material's toolbar, 16 from each edge, Surface bright, no outline.
  - The chevrons were tinted ink by hand; now Material's toolbar colour (On surface), the same as drawn.
  - The ring was 22 dp on Secondary container with a round end; now 20 dp on Outline variant with square ends, as drawn.
  - The count was Body Medium; now Label Large.
  The tags `day-bar`, `day-previous` and `day-next` stay. The milestone bar, snackbars and Back to today still sit above it.
- **2.3 Icon (28 Oct).** Figma: one Icon (528:47, 54 instances), a 24 × 24 glyph in Material Symbols Rounded, weight
  400, grade 0, fill 0, On surface variant (it takes the colour of where it sits). Across the design system page every
  icon is fill 0 except where Figma fills it on purpose: habit and task icons (Habit row, Section header), play and
  pause on the Large icon button and the Section header, the selected Drawer item, the Plus label's medal (check,
  close, add, the drag handle and ▾ are filled too, but look the same either way). Empty screens' cookies are fill 0
  as well (inventory_2, checklist, task_alt at 48).
  The code drew Material Icons (`material-icons-extended`): 142 Rounded, which are filled, and 157 Outlined, which have
  other corners, 316 names in 642 places. Built: `ui/theme/Symbols.kt`, every icon the app uses (229 outlined, 106
  filled in `Symbols.Filled`), each the Symbol's own 24 px outline from fonts.gstatic.com, named after its Symbol
  (`Symbols.Check`), 17 mirrored for right-to-left as Material's AutoMirrored ones were. Material's own `Icon` draws
  them, as before (24 dp, the content colour). Plus's 34 Symbols (`ui/plus/Symbols.kt`, 15 Oct) are merged into it.
  Moved: 50 files. Habit icons (`HabitIcons.icon`) are `Symbols.Filled`, the picker's (`outlined`) `Symbols`; play and
  pause, a ✓ in a circle and the streak's flame stay filled; every other icon is now outlined, as drawn. The open
  drawer row's icon is filled (`MenuItem.selectedIcon`). Six names differ from Material Icons': AddCircleOutline is
  `AddCircle`, ChatBubbleOutline `ChatBubble`, StarOutline `Star`, HelpOutline `Help`, FavoriteBorder `Favorite`,
  Email `Mail`. `material-icons-extended` is gone from the build. The app and both test sets compile.
  Noted: a few of Figma's Habit details flows still set habit icons in Material Icons Round (5 glyphs); A51's filled
  icon is now the Symbol's own fill, as the Habit row draws it.
- **2.4 List item (28 Oct).** Figma: one List item (528:85) by Position (First, Middle, Last, Single) and State (To do,
  Done), with a leading avatar (an icon in a 40 dp circle), a headline in Title Medium, supporting text, and slots
  beside the headline (the Plus label, a day's "Today") and under the text (a note, an example tag, a tonal fix). Rows
  of a group are Surface, 2 apart on the Surface container page, 24 outside and 4 between. Built as `AppListItem`
  (`ui/components/ListItem.kt`) on Material 1.5's own Expressive `SegmentedListItem`, which is the same grouped list:
  its own padding (16 at the sides, 10 above and below), heights (56 for one line, 72 for two, taller as text grows),
  Surface colour, On surface variant icons and supporting text, the 2 dp `SegmentedGap`, and the shape that
  rounds up while pressed. Set only:
  - **Corners:** 24 outside and 4 between, as every card in the designs (Material's outside is 16); pressed, focused
    and hovered round up to 24 all round, as Material's do to theirs (`listItemShapes`).
  - **Headline:** Title Medium (Material's is Body Large).
  - **Avatar:** Surface container highest (Material's is Primary container); Primary with On primary when Done
    (`ListAvatar`).
  - **Slots:** `beside`, `below`, with `ListNote`, `ListExample`, `ListAction` (Tonal Small, 12 under) and `ListChevron`.
  `ListRow` and `SegmentedList` (`Components.kt`) are built on it, and `Segment` stays for pieces that aren't rows.
  Moved onto it: the form rows (radio, check, add, open, switch, number), Settings' switches and Times of day, Privacy
  & lock, Reminders (its rows now follow A70: the avatar turns into ✓ when allowed, and the fix is a tonal button under
  the words), groups and their habits, the reminder times, the task's Time, Ideas, Restore's Google Drive and file
  choices, Backup's pages, widget setup's choices, Create new's choices (with their examples), History's days (Today
  beside, the note under), Task details' events, a record's facts, Get reminders on time, Plus's rows and Not backed
  up, the Habits page's and Archived habits' rows, Day details' logs and actions, All logs, Day & week's dropdowns,
  Help's topics. The tags stay (T3).
  Left as they are, and why: Settings' info and plan rows and the form's fields (no row: they're Segment pieces, or
  Form field, 3.1), the habit form's tap step and half rows (3.1), the sheets' own rows in Filter and groups (on the
  sheet, not a list), the Tasks page's rows (their hold-to-drag and tap gestures, T22; now Surface, 2 apart, Title
  Medium), and the molecules (Habit row, Arrange, the routine player's steps and Your routine, milestones, History's
  fold header, the colour sheet).
  Changed to see: rows are Surface (#F9F9F9), no longer white, on the Surface container page; labels that were Body
  Large are Title Medium; Help's open topic no longer turns its title bold. Noted, not changed: the Habits and Tasks
  pages still select with a long press, which A55 retired; Reminders' words ("Allow", "Fix") are as they were; History's
  rows lost their "Open the day" click label. The app and both test sets compile.
- **2.5 Menu, Menu item (28 Oct).** Figma: Menu (734:76, 40 instances) is Material 3 Expressive's vertical menu:
  Surface container low, Elevation Level 2, 16 corners, 4 around the items, 112 to 280 wide. A menu with gaps is Menus
  stacked 2 apart, 16 at the outside and 8 where they meet (the routine player's ⋮). Menu item (734:73): 44 high, a 20
  dp icon On surface variant, the label Body Large On surface, Selected on Secondary container with 12 corners,
  Disabled at 38 %, Destructive in Error. Every menu's items have an icon except Ends' Never and On a date….
  Built (`ui/components/Menu.kt`) on Material 1.5's own Expressive menu, which is the same thing:
  - `AppMenu` is `DropdownMenuPopup` holding one `DropdownMenuGroup`, with Material's colour, shadow, 16 corners,
    padding, width and motion.
  - `AppGroupedMenu` is its groups `MenuDefaults.GroupSpacing` (2) apart with `MenuDefaults.groupShape` (16 and 8).
  - `AppMenuItem` is Material's `DropdownMenuItem`, or `SelectableDropdownMenuItem` for a choice. It keeps Material's
    4 corners, 44 height, padding and colours: the chosen one is on Tertiary container, our same grey as Secondary
    container, with 12 corners.
  Set only: the label is Body Large, Material's own token (`SegmentedMenuTokens.ItemLabelTextFont`), where Compose
  1.5 still has Label Large marked as a to-do; `destructive` turns the label and icon Error. Material's padding
  inside an item is 12 at the sides, where Figma and the token say 16; kept, as it's Material's own code.
  `MenuDivider` (1.19) still separates groups inside one menu.
  Moved onto it: every menu in the app. Today's touch-and-hold menu, Day details' ⋮, Habit and Task details' ⋮,
  the Habits and Tasks pages' top ⋮ and row ⋮, their Move menus, Archived habits and Completed tasks, Make room,
  Arrange's menus, the routine player's ⋮ (now two groups, as drawn), the task form's Date, Repeat and Ends, Remind
  me with and Remind again, Lock again, Day & week's choices, and the exposed dropdown's menu (the field stays
  Material's, 1.10). Before, each menu set its own corners, colour (white in Habit details and in the forms) and
  shadow (6 dp), and the choice menus drew a ✓ or a blank in front of each choice; now the chosen one is shaded and
  read as a selected radio button.
  Icons now as drawn: View habit is `visibility` (was insights); Move to another day… and Pick a day… are `event`
  (were edit_calendar and calendar_month); Skip this time is `redo` (was skip_next); the player's Go to first
  unfinished is `first_page` and End routine `stop_circle` (were undo and flag; both added to `Symbols`, from Google's
  Material Symbols); Remind me with's choices have their `notifications` and `alarm`; Make room's Delete… its
  `delete`. The tags stay (T3). The app and both test sets compile.
  Changed to see: menus size to their words, from 112 wide (the Habits and Tasks pages' were held to 200). Noted,
  not changed: some words differ from Figma's menus ("Delete habit…" and "Delete task…" where Figma says Delete;
  Today's menu has Arrange…, which Figma's doesn't); Make room has its Archive as a button beside ⋮, where Figma
  puts Archive and Delete in the ⋮.
- **2.6 Snackbar (28 Oct).** Figma: one Snackbar (778:444, 86 instances), Material's own: Inverse surface (#303030),
  4 corners, Elevation Level 3, 48 high for one line and 68 for two, the text Body Medium in Inverse on surface
  (#F1F1F1), 12 from the screen's edges; an optional action (a text button, Label Large, 12 in, 40 high), an optional
  close, and a second action only where an approved flow has two: the routine player's Saved · Undo · Add note. The
  action is #F1F1F1, the text's own colour. Built (`ui/components/Snackbar.kt`) on Material's own `Snackbar` with
  all of its defaults (colour, shape, shadow, heights, padding, Material's text buttons and close). Set only:
  - **Action colour:** Inverse on surface (Material's is Inverse primary, #C6C6C6 in our theme).
  - **A second action:** `AppSnackbar(message, actions)` puts up to two `SnackbarAction`s side by side in Material's
    one action slot, each Material's text button.
  `AppSnackbarHost` shows a screen's `SnackbarHostState` messages through it.
  Moved onto it: every snackbar. Today, Day details, Arrange, the Habits and Tasks pages, Archived habits, Completed
  tasks, Backup, every other page (AppRoot's host) and the routine player's. Fixed:
  - Today's action was a hand-picked grey (#D7D7DC, #45454A in dark).
  - Day details' snackbar was ink with On ink, the opposite colours in dark mode.
  - The player's was its own colours (#313033, #F4EFF4), with its buttons' padding cut to 8. It's now the theme's,
    with Material's own button padding; its tags stay (T3).
  Arrange's set the 4 corners by hand; they're Material's own. The app and both test sets compile.
  Noted, not changed (where each screen puts its snackbar): Figma puts it 12 from the sides. Today and the Habits,
  Tasks, Archived and Completed pages add 4 to Material's 12, making 16; Day details adds 16, making 28.
- **2.7 Day toggle (28 Oct).** Figma: Day toggle (1075:1966, 45 instances on the How often page), by Size and Selected.
  Week (S M T W T F S): 34, round, On surface on Surface container highest, Label Large, seven spread across the row.
  Date (1 to 31): 40, round, On surface on nothing, Body Large, seven to a row spread across it, rows 8 apart.
  Chosen, both are Primary with On primary. Built as `DayToggle` (`ui/components/DayToggle.kt`) on Material's own
  round `FilledIconToggleButton`, a letter or a date in place of its icon: Material's shape, chosen colours,
  switched-off colours and checkbox semantics. Set only:
  - **Size** (`DayToggleSize`): 34 and 40 (Material's is 40).
  - **Not chosen:** On surface on Surface container highest, or on nothing for a date (Material's is On surface
    variant on Surface container, our page's grey).
  Material gives each a 48 dp touch area, and seven of those don't fit a 328 dp row. So a row of them has none: the
  34 or 40 is the target, with the row's space between, as before.
  Moved onto it: the weekday picker (`WeekdayCircles`: Days of the week, and Every few weeks › On set days) and the
  month's dates (On a date › Dates). Fixed:
  - The weekdays were 40 on Secondary container in Title Small; now 34 on Surface container highest in Label Large.
  - The dates were circles that grew with the row on Secondary container, 6 apart, Label Large; now 40, on nothing
    until chosen, Body Large, rows 8 apart, spread across.
  - TalkBack read "Monday, chosen"; now it reads "Monday", a checkbox, checked or not checked.
  The tags stay (T3). The app and both test sets compile.
  Noted, not changed: Figma's weekday row is 16 in from its block's sides and its date rows 8 in. The code's How
  often blocks have their own insets, which belong to the How often option block, a molecule for later.
- **3.1 Form field (28 Oct).** Figma: Form field (1065:2120, 25 instances, all on Create new), by Position (First,
  Middle, Last, Single) and State (Empty, Filled, Typing), with Show handle, Show remove and Show cursor. 56 tall, 16
  all round, Surface bright (#F9F9F9, the List item's own fill), corners 24 outside and 4 between, Body Large: On
  surface variant while empty, On surface once typed, the cursor Primary. Used for a habit's or task's name (First)
  and description (Middle), a custom unit (Middle, with its Done laid over the end) and a checklist's steps (handle
  and ✕). Built as `FormField` (`ui/components/FormField.kt`) on Compose's `BasicTextField`, as one piece of the
  form's segmented list: `segmentShape` by place, the colour scheme's Surface (the List item's, so it matches the
  rows beside it in dark mode too), `handle` for the drag and a `trailing` slot for ✕ (`FormFieldRemove`, Material's
  icon button) or Done, the field then ending 4 from its edge so the glyph sits 16 in. No error state.
  Moved onto it: the name and description (HabitForm), the custom unit (Unit) and the steps (Steps). Fixed:
  - The name was 72 tall with 22 above and below, on white; now 56, on Surface like the rows under it.
  - The description and the name were white (#FFFFFF) beside #F9F9F9 rows.
  - The cursor was On surface; now Primary.
  - A missing name outlined the field in red and said "Give it a name to add it." (Figma 2.1.10). A65 took that
    away: the field looks as usual, and Add still takes the focus to it.
  - The steps were 72 tall (12 above and below a 48 dp ✕); now 56, so the drag's 58 dp step is a row and its gap.
  The tags stay (T3). The app and both test sets compile.
  Corrected from 2.4's note: the form's Icon | Colour halves are List items in Figma, not Form fields, and the tap
  step ("Each tap adds") isn't a Form field either; both stay as they are for now (the halves' 24 dp corner on one
  side only isn't a List item position).
  Noted, not changed:
  - Figma's Unit page keeps No unit first, then the field, then Create your own unit; the code puts the field where
    Create your own unit was, before No unit.
  - Figma gives Quit a description too; the code's Quit form has none.
  - A65's snackbar for a name past 24 letters isn't built: the form still says so in a line under the field.
  - "Reminder says" is a List item in Figma; the code's is a Segment with a field in it (the List item's, 2.4).
- **3.2 Colour swatch (28 Oct).** Figma: Colour swatch (1074:161495, 13 instances, all in the Colour sheet
  1074:161496), by Selected. A 40 dp circle of the habit's own Colour; chosen, the colour is 30 inside a 2 dp On
  surface ring with 5 between, and a 20 dp ✓ in On habit (white) on it. The sheet: seven to a row, 8 between, rows 12
  apart, 16 at the sides, 8 above and 24 under. Built as `ColourSwatch` (`ui/components/ColourSwatch.kt`); Material
  has no colour picker. TalkBack reads it as a radio button. Like the Day toggle (2.7), seven in a row leave no room
  for 48 dp touch areas, so the 40 is the target.
  Moved onto it: the Colour sheet (FormPages' `ColourSheet`). Fixed:
  - The swatches grew with the sheet's width (seven equal shares); now 40 dp on every phone, from the start of the row.
  - The chosen one had a 3 dp ink ring with 6 between, and no ✓; now 2 dp On surface, 5 between, with the ✓.
  - Rows ended 12 apart with nothing extra under the last; now 24 under, as Figma.
  - TalkBack read "Red, chosen"; now it reads "Red", a radio button, selected or not selected. "Gray" is now "Grey",
    as the app writes it.
  The tags stay (T3). The app and both test sets compile.
  Noted, not changed: Figma puts the white ✓ on the habit's Colour, but Figma's own On habit note says white sits only
  on Strong (tone 48). On Yellow (#F9AB00), Cyan and Mint the white ✓ is faint. The code follows the swatch as
  drawn, on Colour; the app has no Strong tones yet.
- **3.3 Plus label (28 Oct).** Figma: Plus label (1208:1983), one component. A pill of Primary, 24 tall: the filled
  workspace_premium, 16, then "Plus" in Label Medium, both On primary, 4 between, 4 above and below, 8 before and 10
  after. It marks the one thing on a screen that needs Plus; the row or card it's in opens Plus. In Figma it's on the
  List item (beside the name, or on its own line under the supporting text), the widget setup's Plus card (leading
  the heading, 8 before the title), the widgets' Plus messages and the Year in pixels card's Free overlay.
  Built as `PlusLabel` (`ui/components/PlusLabel.kt`). The filled workspace_premium was missing from `Symbols.Filled`:
  added from Google's own 24 px SVG (fonts.gstatic.com, Rounded, fill 1), as every other icon.
  The code had no Plus label anywhere. Placed: the widget setup's Plus card (One habit's This week, Today, Tasks),
  leading its heading. `AppListItem`'s `beside` and `below` already take it. The app and both test sets compile.
  Not placed, and why:
  - The widgets' own Plus messages are Glance (the home screen's widget), which can't draw a Compose component; they
    get a Glance copy with the widgets' own work.
  - The Year in pixels card's Free overlay, and the Plus rows A73 adds (year views, new checklists, If not done,
    remind again), aren't built yet. Each takes the label when it is.
  Noted, not changed: Figma's Plus card is a different card. Its title is "This week comes with Plus" with one line
  under it, 20 in on 24 corners, and the whole card opens Plus. The code's says "This week is a Plus widget" with two
  lines, 24 in on 28 corners, and has Get Plus and Add without Plus buttons. That's the Widget setup screen's work.
- **3.4 Skeleton (28 Oct).** Figma: Skeleton (1030:2), one component, Surface container high, resized and rounded to
  what it stands for: 8 for a line or a number, 16 for a tile, round for a medal (20 for the latest milestone). Its
  27 instances are all in Habit details' Progress while the record is read: Overall record (a title, the total, four
  tiles), Milestones (a title, the latest, three medals), What the squares mean (the real card, folded), Week and
  Month (a title, a summary, seven days). Each card is white, 24 corners, 20 inside, its pieces 12 apart. Built as
  `Skeleton` (`ui/components/Skeleton.kt`); Material has none. Still, with no shimmer, as Figma draws it.
  Moved onto it: Habit details' loading (`loadingItems`, the only loading state the app draws). Fixed:
  - The pieces were Secondary container (#E2E2E2) with 6, 8 and 20 corners; now Surface container high (#E8E8E8)
    with Figma's 8, 16, 20 and round.
  - Only two cards stood in, the record (its tiles 100 tall) and one bar for Milestones. Now all of Figma's: the
    record with 96 dp tiles, Milestones with the latest and three medals, the squares' key, Week and Month.
  The tag stays (T3). The app and both test sets compile.
- **3.5 Medal (28 Oct).** Figma: Medal (913:29957), by Size: Large 104 (the milestone pop-up), Medium 72 (details
  pages), Small 40 (a list row's leading slot), scaled between (52 for a badge, 44, 32). A nine-point star, inner
  radius 86 %, corners 10 % of its size, in the habit's Medal gradient: Pale (tone 75) at the top to Strong (tone 48)
  at the bottom. A drop shadow of black at 20 %, 2 down with a 6 blur at 72. The same star at 82 % as a white line at
  60 % (2.2, 1.8, 1.2 by size). The number is On primary: Headline Large Emphasized, Headline Small Emphasized or
  Title Medium by size. Its exported outline is the code's star exactly.
  Built as `Medal` (`ui/components/Medal.kt`): the app's one medal, `MilestoneMedal` in `ui/habit/Medals.kt`, moved
  into the components and renamed, with `medalColors`, `MedalShape` and `WhiteMedal` beside it. Every caller moved:
  Habit details' Milestones card and shelf, All milestones, the pop-up, the band's sparkles, the routine player.
  Fixed:
  - The colours were worked out from the habit's colour: top 28 % to white, bottom 88 %, deepened for yellow and
    mint. Now Figma's 13 Medal gradients exactly, in light.
  - The shadow was a dark shade of the colour at 35 %; now black at 20 %.
  - The ring was 1.5 at 72 in white at 55 %; now 60 %, at Figma's 2.2, 1.8 and 1.2.
  - The number's size was a share of the medal, not a text style (U36); now Figma's three styles. A three-digit
    number is a step smaller and four digits two, so it stays inside the ring.
  The app and both test sets compile. `Milestones — Every Habit Type and Every Milestone.md` updated.
  Noted, not changed:
  - Figma draws the number in On primary (#F9F9F9); the code keeps white (#FFFFFF, On habit), which On primary
    would turn dark in dark mode.
  - Figma draws light only, so dark keeps its worked-out steps.
  - `WhiteMedal` (the milestone bar's white medal) still sizes its number by share; it belongs to the Milestone bar
    molecule.
- **3.6 Day cell (28 Oct).** Figma: Day cell (977:635), State × Size, with a Today switch. Sizes: Week 36 (corners
  8), Small 28 (7), Year 24 (6). Done is the habit's Colour with a ✓ in On habit; More than the goal is its Strong (the
  medal's deep end) with the ✓; Part is the Colour at 50 %. Not done, Skipped, Paused and To come are Surface
  container high, the first three with close, redo or pause in Outline (Material Symbols Rounded, outlined, 400). No
  goal is a dashed Outline variant line, 1.5 inside, 3 on and 3 off. Empty is nothing. Today adds a 2 dp On surface
  ring, 6 larger, corners 3 rounder. Glyphs: ✓ 22, 16, 17; ✕ 18, 12, 14; pause and redo 16, 12, 12. Used in Week and
  Month (36), the key (36), Year (24, scaled to 20 in the Year in pixels card) and the Plus example.
  Built as `DayCell` and `DayCellDraw` (`ui/components/DayCell.kt`), with `DayCellSize` and `dayCellColors`. A year
  has hundreds of cells, so `DayCellDraw` batches every look into one path per colour in one Canvas (S12), and each
  glyph is Symbols' own outline, scaled once. A size between Figma's takes the nearest and scales. Every square moved
  onto it: Habit details' Week strip, Month and Year in pixels, History's rows, the key, and the old Progress page's
  Week, Month and Year (`ui/progress/HeatMap.kt`). The old `HeatSize`, `HeatPalette`, `HeatDraw` and `HeatSquare` are
  gone.
  Fixed:
  - Squares were the iPhone's five steps of colour (three part steps, met, more), with grey EBEBF0 and its signs.
    Now Figma's: one Part, Done, More than the goal, the theme's greys.
  - Signs were drawn lines (a ✓ stroke, a ✕, a ⏩ for skipped, two bars); now Figma's glyphs, skipped as redo.
  - Corners were 22 % of the side; now 8, 7, 6. The dash was 4.5 % of the side; now 1.5, 3 on 3 off.
  - Today's ring was 2.5 outside; now 2 (Figma's 6 larger).
  - The Week strip was 40 (the old Progress page's too); now 36.
  - The key ("What the squares mean") now has Figma's ten rows in its order and words, at 36 with 12 between and 16
    to the words in Body Medium, then its footnote in Body Small ("Nothing here counts against you …"). Its "Has a
    note" row is gone: Figma has none.
  - The old Progress page's key shows Part, Done and More than the goal instead of five percentages, and says No goal
    that day.
  - The comparison's earlier bar takes Part's colour (it was the second step).
  The app and both test sets compile.
  Noted, not changed:
  - Figma draws light only. Dark uses the same roles and the habit's dark colour, and keeps a deep shade for the ✓ on
    Done (white doesn't read on the dark colours); More keeps white on the medal's dark end.
  - The month's note dots and the year's corner dot aren't in Figma's Day cell; they stay as they were (the Month card
    draws them).
  - History's rows keep the Year size (24); Figma has no Day cell there.
  - The key card's shell (Figma: a List item header and the key as a second piece, 2 apart) is still one card; it
    goes with the card molecules.
  - Small (28) has no use in Figma yet.
- **4.1 Habit row (28 Oct).** Figma: Habit row (571:277), one State variant (To do, Part done, Part done · just
  logged, Done, Done · just logged, Done · milestone, Done · just logged · milestone, Quit or cut down · just logged,
  Quit or cut down · milestone) and switches for the streak, the action, the Log button, the run and touch and hold.
  Surface bright, square (the section gives the corners), the body 16 / 12 / 14 / 14; the 40 icon, 16, Title Medium
  name over the Body Medium line, 16, then the streak and the action 20 apart. Undo · Note 12 below, 56 in: 36 high,
  corners 16, Outline variant edge. The milestone band under everything. The progress fill behind, in the habit's Fill;
  touch and hold, On surface at 10 %.
  Built as `HabitRowLayout` (`ui/components/HabitRow.kt`), with `HabitRowLine`, `HabitRowStreak` and
  `HabitRowAfterLogButton`; Today's `HabitRow` and `QuitRow` (`ui/today/TodayRows.kt`) now work out what to show and
  hand it to the molecule, so both rows are one layout. `StreakLabel` and `OutlinedPill` moved in from
  `Components.kt` (Today was their only user).
  Fixed:
  - The row was Surface container lowest (#FFFFFF); now Surface bright (#F9F9F9), as Figma.
  - The fill was the habit's colour at 16 %, 18 % once full; now the habit's Fill, one tone for every colour.
  - A cut-down row still filled in grey; now it never fills (A41, decided 22 Oct, not built until now). The unused
    grey (`neutralFill`) is gone.
  - Touch and hold shaded On surface at 8 %; now Material's 10 %.
  - Undo · Note sat 16 under the body with corners 18 on white; now 12, corners 16, on the row's Surface.
  - An amount typed each time had a + button ("Add an amount"); now the tonal Small "Log" (Figma's Show log button,
    the user's 19 Oct word).
  - The 🔥 had its own 12 sp size (U36); now Body Small.
  - A later day's "Done today" was a hand-made 36 dp pill; now the tonal Small button, as Log.
  The app and both test sets compile.
  Noted, not changed:
  - The section header and a checklist's steps beside the row are still #FFFFFF until their molecules (Section
    header, Step row) move to Surface bright, so for now the row is a shade greyer than its neighbours.
  - The milestone band, the burst and the before-the-tap layers (Goal before, Streak before, Action · before the tap)
    belong to the Milestone ribbon and its motion; the band keeps its own drawing.
  - Figma's own uses show neither Log nor the run (no Today frame draws a typed amount or a quit with the row yet).
- **4.2 Habit row · Swipe (28 Oct).** Figma: Habit row · Swipe (763:273), Swipe: Left · reveal, Left · past halfway,
  Right · reveal, Right · past halfway, Nudge. A real Habit row slid over its action, inside the section's corners.
  Reveal (the row 136 across): Surface container highest, a 24 icon, 8, the short word in Label Large, all On surface,
  16 from its side. Past halfway (196): Inverse surface and Inverse on surface, the full words ("Skip today", "Add
  note"). Nudge: 24 and back. The row slides flat: no corners, no shadow. Today's swipe flows use it as it is.
  Built as `HabitRowSwipe` with `SwipeAction` (`ui/components/HabitRowSwipe.kt`): Today's `SwipeRow`
  (`ui/today/SwipeActions.kt`) moved into the components and renamed; Today's habit and quit rows use it.
  Fixed:
  - Past halfway was On surface (#1B1B1B) with On primary; now Inverse surface (#303030) with Inverse on surface.
  - Past halfway moved the words 24 from the side; now 16, as Reveal.
  - The moving row lifted, with corners 12 and a 3 dp shadow; Figma slides it flat, so it does now.
  The app and both test sets compile.
  Noted, not changed:
  - Figma draws no motion for the swipe; the spring back, the 120 ms colour change and the tick at halfway stay.
- **4.3 Step row (28 Oct).** Figma: Step row (575:136), State To do · Done, no motion. 48 tall, 56 in, 12 at the end,
  8 between the box and the words, Surface bright. Material's checkbox in a 40 dp frame: an 18 dp box with 2 corners;
  not ticked, a 2 dp On surface variant outline; ticked, the habit's Colour with a filled white check (On habit). The
  step in Body Large, On surface, and On surface variant once ticked, never crossed out. The screens use the one
  component in three places, each with its own room:
  - **Today** (Steps open, 739:10266): a block of rows stacked with no gap, Surface bright, the section's corners (4
    under the row, 24 at the section's end), 8 above and below.
  - **Day details' This day** (669:158): 48 tall, nothing at the start (the card's 16 is the indent), 12 at the end;
    the rows keep the component's Surface bright on the white card.
  - **The routine player** (926:112641): 56 tall, 8 in, 16 at the end, Surface container lowest, each a segment 2 apart
    (24 outside, 4 between).

  Built as `StepRow` with `StepRowPlace` (Today, Card, Player) and `StepRowBlock` (`ui/components/StepRow.kt`). The
  whole row is the toggle (a checkbox to TalkBack, read "Done" or "Not done"), with Material's `Checkbox`
  (`AppCheckbox`, the habit's colour) centred in the 40. Moved onto it: Today's steps (`StepsBlock`; `StepLine`
  deleted), Day details' steps and the Tick steps add screen (`StepCheck` deleted), and the routine player's
  (`StepRows`). The tags (`steps-…`, `step-…`, `day-step-…`, `record-step-…`, `player-step-…`) and the "Done" / "Not
  done" TalkBack states stay (T3).
  Fixed:
  - Today crossed a ticked step out; now it only greys it, as drawn. Day details crossed it out too.
  - Today's block was white (Surface container lowest) with 4 above and below; now Surface bright with 8, as the
    Steps open screen draws it. The block now matches the Habit row above it (4.1's noted mismatch, half of it; the
    section header is 4.4).
  - Today's box was drawn by hand (a 16 dp check, faded in over 150 ms); now Material's checkbox, with its own tick
    animation.
  - Today's rows had 8 corners and the 56 and 12 outside them, on the block; now each row runs the full width with the
    56 and 12 inside it, so the whole width is the touch target.
  - Day details put the 24 dp checkbox at the row's start and the words 16 after it (40 in); now the 40 frame and 8,
    the words 48 in, as drawn.
  - The player's steps were the page's Surface container on 20 and 4 corners, 4 apart, 52 tall, 12 at the sides, 12
    after the box, and a ticked step's words stayed On surface. Now Surface container lowest, 24 and 4, 2 apart, 56
    tall, 8 and 16, the 40 frame and 8, and ticked words On surface variant.
  - A switched-off step (a later day; a paused or skipped day in Day details): the words stayed On surface on Today and
    in the player and turned On surface variant in Day details. Figma draws no switched-off step, so now one rule,
    Material's: the box and the words in On surface at 38 %.

  Noted, not changed:
  - **For the user:** the component's description says the block takes 4 above and below, but its only screen (Today
    › Steps open) draws 8. Built as the screen draws it. Which is meant?
  - **For the user:** Day details draws the steps on Surface bright inside the white This day card. That's the
    component's own fill, not set on that screen, so it reads as a grey panel of steps on the white card. Built as
    drawn; say if they should be white like the card.
  - Figma's This day reads top to bottom: the reading, the steps, then the buttons, 24 apart, 16 inside, corners 24
    over 4. The code puts the buttons before the steps, 20 inside, 28 corners. That's the Day details card's own
    layout, for its molecule.
  - Figma's player puts the steps on the page under a white hero card; the code keeps them inside Material's `Card`
    (Surface container highest). The white segments read on it. That's the routine player's own layout, for when it's
    built.
  - The Tick steps add screen (`RecordScreens.kt`) has no Figma; its rows use the Card place on its white card.
  - Figma's step names wrap freely in a fixed 48; the code keeps two lines with … and lets the row grow (U36).
  - The session can't reach Google's Maven (T22), so the compile check is GitHub's Android build on this commit.
    **Built:** run 40731917778 (Android #100, commit 34cfc77) passed: assembleDebug, unit tests and lint, in 7
    minutes. It was the first build of `main` on GitHub since 22 Oct, so it checked every atom before it too (they had
    been pushed with `[skip ci]`).
- **4.4 Section header (28 Oct).** Figma: Section header (562:48), State Open · Closed by Text size Default · 200%, with
  Show time, Show badge, Show start and Show habit icons; no motion. Used only on Today: 1,048 instances on the Today
  page (Morning, Afternoon, Evening, Anytime, Quitting, Paused), and Today again behind the sheets of the other pages.
  Surface bright, 64 tall: 16 at the start, 12 between its parts, 8 at the end. The name in Title Medium (On surface)
  over the time in Body Small (On surface variant), taking the room left. Closed, the habits as 28 dp discs of their
  Colour with the filled icon at 16 in On habit, ringed 2 dp in Surface bright, 6 over each other, and past three a
  "+N" disc (Surface container highest, Label Medium). The count is a neutral pill: 24 tall, corners 12, 10 at the
  sides, Label Medium On surface on Surface container highest. Open, Start is Material's extra-small button: 32, round,
  Primary with On primary, the filled play arrow at 20, 8, Label Large. ⌃ ⌄ is Material's small standard icon button
  (40, a 24 glyph, On surface variant). Open, the corners are 24 over 4; closed, 24 all round. At 200%: the name and
  ⌃ ⌄ on the first line; under it, 8 down, the time, discs, count and Start, 12 apart, wrapping 8 apart.

  Built as `SectionHeader` with `SectionHabit` (`ui/components/SectionHeader.kt`). Start is Material's own `Button`
  at `ButtonDefaults.ExtraSmallContainerHeight` with its round shape, which squares up while pressed. Its sides and
  icon gap are set to Material's tokens (`ButtonXSmallTokens`, 16 and 8, which Figma draws): Compose 1.5's own
  extra-small padding is still 12 with a 4 gap, marked in its code to be corrected. ⌃ ⌄ is `StandardIconButton` (1.1);
  its 48 dp target leaves 4 less around it, so the glyph sits where Figma draws it. Large text (font scale 1.5 and up,
  as Habit details' one column) takes the 200% layout, its second line a `FlowRow`. Today's three headers moved onto it
  (the times of day, Quitting, Paused). `PartHeader`, its `StartButton` and `FoldedIcons`, the grey `Badge`
  (`Components.kt`) and `MiniMedal` (`MilestoneViews.kt`) are gone. The tags (`header-…`, `start-…`), "Start Morning"
  and the "Fold …" / "Open …" TalkBack words stay (T3).
  Fixed:
  - The header was white (Surface container lowest); now Surface bright. The rest of 4.1's mismatch: Today's cards are
    one colour now.
  - Start was tonal grey with ink for every time of day but the current one. Figma draws it Primary everywhere
    (Morning and Anytime alike, all 478 instances that show it, no other colour), so now it always is.
  - Start was hand-drawn: 32 tall, ▶ 18, 4 dp, 14 and 18 at the sides. Now Material's extra-small button: ▶ 20, 8,
    16 and 16, Material's ripple and pressed shape.
  - ⌃ ⌄ was a hand-made clickable circle; now Material's icon button.
  - The name sat at its own width, so closed sections' discs followed the name. Now the name takes the room that's
    left, so the discs sit beside the count, as drawn.
  - The discs' ring was white (Surface container lowest); now Surface bright. "+N" was a fixed 28 circle that couldn't
    grow; it now grows into a pill with large text, as at 200%.
  - A folded section put a small medal on a habit's disc for a milestone not yet seen, and moved that habit first.
    A43 (22 Oct) took that away: a folded section shows nothing about a milestone. Both are gone.
  - A finished section said "✓ Done"; Figma's count says "Done".
  - Paused's header had a line under it ("Meds · back on 20 Oct", "2 habits"). Figma's Paused header has none (all 9
    instances); each paused row says when it comes back.
  - Large text: the name was cut to one line beside everything else; now the 200% layout.

  Noted, not changed:
  - Figma's milestone flows show a finished Morning ("Done") still offering Start (2 instances, flows where only the
    badge text was changed). The code shows Start only while something is left, and still does. Say if a finished
    time of day should keep Start.
  - Figma draws Paused open on every screen; the code opens it folded. That's Today's own choice, for the Today screen.
  - The switch to the 200% layout is at font scale 1.5 (Figma has only 100 % and 200 %).
  - **Built:** run 40734638057 (Android #101, commit ce4eefb) passed: assembleDebug, unit tests and lint.
- **4.5 Run row (28 Oct).** Figma: Run row (1034:2), one component, no motion; used only on the Streaks page
  (`Screen=Streaks` and its flow, 6 instances). The length in Title Medium (On surface) taking the room left and the
  dates in Body Medium (On surface variant), 12 apart on one baseline; 8 under them, the track, 8 tall, corners 4,
  Surface container high. The bar is the run's share of the longest (the longest fills it; 12 of 23 days leaves 138 of
  288), in the habit's **Colour** for the run going on now and its **Pale** for an earlier one. On the screen, the rows
  sit 16 apart in a white card (24 corners, 20 inside) under "3 runs", 16 below it.
  Built as `RunRow` (`ui/components/RunRow.kt`), and `appColors.habitPale` (`ui/theme/Theme.kt`): Figma's 13 Pale
  colours (tone 75), beside Fill and Band. In dark it's the colour at 60 % on the card, as Figma draws light only. The
  Streaks page (a quit habit's Runs too) moved onto it; its own `RunRow` is gone. The tags (`run-current`, `run`) and
  each run's spoken words stay (T3).
  Fixed:
  - An earlier run's bar was the habit's colour at 60 %; now its Pale.
  - The track was Secondary container (#E2E2E2); now Surface container high (#E8E8E8).
  - The length and dates were centred on each other; now on one baseline.
  - Runs sat 20 apart (10 above and below each) and 14 under the title; now 16 and 16, as drawn. The note follows 16
    under the last run (it was 22).
  Noted, not changed:
  - **For the user:** Figma's Pale styles each say "the light end of the medal's gradient, and nothing else", but the
    Run row (and its screen) uses Pale for an earlier run's bar. Built as the Run row draws it. Should the Pale
    descriptions mention the Streaks page, or should earlier runs take another colour?
  - Figma's page puts the note ("Runs of 3 days or more …", Body Small) under the card, 16 below it; the code keeps it
    as the card's last line. Its habit line is 20 from the screen's edge (16 and 4) where the code has 28. Both belong
    to the Streaks page component (`Streaks page`, 1034:74), for when it's built.
  - A share too small to see keeps 3 % of the track (the code's, kept), so a 3-day run beside a 300-day one still
    shows a bar. Figma's formula has no least width.
  - The Pale values are also the medal's top (`Medal.kt`'s own list); left as they are.
