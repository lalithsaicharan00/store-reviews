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
- **Figma is the final word (the user, 29 Oct 2026, Android A77):** "whatever we have Figma, that is the final thing
  … If something we don't have in the Figma, then it definitely means it has to be deleted." When the app has a
  screen, row, button, word or behaviour Figma doesn't, delete it (code, route, tests); never leave it under "Noted,
  not changed". Saved data is never lost, and widgets', reminders', sync's and backup's behaviour stay as they are.
- **Figma descriptions come back HTML-escaped** (`"` as `&quot;`, `'` as `&#39;`, `&` as `&amp;`), so writing back what
  was read escapes them again (found 29 Oct 2026: 11 descriptions had `&amp;quot;`, repaired). Always unescape what
  `description` returns before writing it back.
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

Habit row ☑ (4.1), Habit row · Swipe ☑ (4.2), Step row ☑ (4.3), Section header ☑ (4.4), Run row ☑ (4.5), Comparison row ☑ (4.6), Card notice ☑ (4.7), Milestone bar ☑ (4.8), Milestone
ribbon ☑ (4.9), Next milestone ☑ (4.10), Milestone badge ☑ (4.11), Milestone pop-up ☑ (4.12), Milestones card ☑ (4.13), Stat tile ☑ (4.14), Habit history card ☑ (4.15), Overall record
card ☑ (4.16), Year in pixels card ☑ (4.17), and the day navigation inside the floating toolbar ☑ (4.18).

### 5. The pages' components (added 28 Oct 2026)

Every other component set in the Figma file, page by page in Figma's order, built the same way, one at a time. Left
out, as Status bar and Gesture navigation are: what Figma marks as Android's own and draws only to show a flow (the
Google account and Drive screens, the file picker, Samsung's and Android's settings pages, the notifications
permission, notifications, the lock screen, the shade, keyboards, the browser tab, the launcher, its menus and the
widget picker, the home screen). **Widgets and reminders: their look only** — never what a tap, an update, a
reminder, sync or backup does (the build prompt's rule).

| # | Component | Figma | Status |
|---|---|---|---|
| 5.1.1 | Onboarding · Splash | 553:2427 | ☑ |
| 5.1.2 | Onboarding · Today, no habits yet | 547:2419 | ☑ |
| 5.1.3 | Onboarding · Restore from a backup | 553:4083 | ☑ |
| 5.1.4 | Onboarding · Restoring | 582:7893 | ☑ |
| 5.1.5 | Onboarding · Plus isn’t on this phone | 582:8320 | ☑ |
| 5.1.6 | Onboarding · No internet | 582:8426 | ☑ |
| 5.1.7 | Onboarding · No backup found | 690:13442 | ☑ |
| 5.1.8 | Onboarding · That isn’t a backup | 582:8484 | ☑ |
| 5.2.1 | Today · Navigation drawer | 626:76 | ☑ |
| 5.2.2 | Today · Today | 728:7985 | ☑ |
| 5.2.3 | Today · Edit Today | 827:39487 | ☑ |
| 5.2.4 | Today · Milestone · Motion (the bar, the pop-up and the row's moment on Today) | 853:45982 | ☑ |
| 5.3.1 | Day details · Day details sheet | 669:234 | ☑ |
| 5.3.2 | Day details · Log screen | 687:829 | ☑ |
| 5.3.3 | Day details · All logs screen | 694:607 | ☑ |
| 5.3.4 | Day details · Dialog | 702:618 | ☑ |
| 5.3.5 | Day details · Time picker | 703:602 | ☑ |
| 5.3.6 | Day details · Date picker | 705:1025 | ☑ |
| 5.3.7 | Day details · Timer screen | 705:7745 | ☑ |
| 5.3.8 | Day details · Note screen | 765:1087 | ☑ |
| 5.4.1 | Routine player · Routine player | 906:89513 | ☑ |
| 5.4.2 | Routine player · Your routine sheet | 907:29174 | ☑ |
| 5.5.1 | Habits & Tasks · Habits page | 986:150825 | ☑ |
| 5.5.2 | Habits & Tasks · Archived habits page | 988:7736 | ☑ |
| 5.5.3 | Habits & Tasks · Search page | 991:8050 | ☑ |
| 5.5.4 | Habits & Tasks · Tasks page | 999:1061 | ☑ |
| 5.5.5 | Habits & Tasks · Archived tasks page | 1001:178 | ☑ |
| 5.5.6 | Habits & Tasks · Completed tasks page | 1002:230 | ☑ |
| 5.6.1 | Details pages · Habit details page | 1020:4052 | ☑ |
| 5.6.2 | Details pages · Streaks page | 1034:74 | ☑ |
| 5.6.3 | Details pages · All milestones page | 1036:235 | ☑ |
| 5.6.4 | Details pages · Notes search page | 1053:9079 | ☑ |
| 5.6.5 | Details pages · Task details page | 1136:9271 | ☑ |
| 5.6.6 | Details pages · How milestones work page | 1142:29063 | ☑ |
| 5.7.1 | Create new · What do you want to do? | 1061:2016 | ☑ |
| 5.7.2 | Create new · Quit or cut down | 1061:2101 | ☑ |
| 5.7.3 | Create new · Create new form | 1065:2597 | ☑ |
| 5.7.4 | Create new · Icon picker | 1074:932 | ☑ |
| 5.7.5 | Create new · Colour | 1074:161496 | ☑ |
| 5.7.6 | Create new · How often page | 1075:161386 | ☑ |
| 5.7.7 | Create new · Time of day page | 1098:2480 | ☑ |
| 5.7.8 | Create new · Reminders page | 1100:2996 | ☑ |
| 5.7.9 | Create new · How much page | 1102:2782 | ☑ |
| 5.7.10 | Create new · Unit page | 1102:3316 | ☑ |
| 5.7.11 | Create new · How long page | 1103:3208 | ☑ |
| 5.7.12 | Create new · Steps page | 1104:163327 | ☑ |
| 5.7.13 | Create new · Limit page | 1105:3190 | ☑ |
| 5.7.14 | Create new · What kind of task? | 1109:2 | ☑ |
| 5.7.15 | Create new · Get reminders on time | 1164:344717 | ☑ |
| 5.7.16 | Create new · How do you want to track it? | 1208:375097 | ☑ |
| 5.8.1 | Settings · Keep reminders coming | 804:192 | ☑ |
| 5.8.2 | Settings · Edit time of day | 830:265 | ☑ |
| 5.8.3 | Settings · Settings | 1173:547 | ☑ |
| 5.8.4 | Settings · Times of day | 1176:356264 | ☑ |
| 5.8.5 | Settings · Backup & Sync | 1178:960 | ☑ |
| 5.8.6 | Settings · New day starts at | 1186:13870 | ☑ |
| 5.8.7 | Settings · Week starts on | 1186:13871 | ☑ |
| 5.8.8 | Settings · Theme | 1188:376784 | ☑ |
| 5.9.1 | Plus · Plus | 1204:175 | ☑ |
| 5.9.2 | Create new · Make room (the frames of "A sixth habit on the free plan", 1167:351072, 1167:351230; added 30 Oct) | 1167:351072 | ☑ |
| 5.10.1 | Widgets · Widget · One habit | 1235:46 | ☑ |
| 5.10.2 | Widgets · Widget row fill | 1238:428 | ☑ |
| 5.10.3 | Widgets · Widget · List row | 1238:429 | ☑ |
| 5.10.4 | Widgets · Widget · List | 1240:488 | ☑ |
| 5.10.5 | Widgets · Widget · This week | 1243:857 | ☑ |
| 5.10.6 | Widgets · Widget setup | 1252:3618 | ☑ |
| 5.11.1 | Notifications & alarms · Notification icon (Often Enough) | 1268:3 | ☑ |
| 5.11.2 | Notifications & alarms · Reminder notification | 1268:127 | ☑ |
| 5.11.3 | Notifications & alarms · Reminder group | 1273:903 | ☑ |
| 5.11.4 | Notifications & alarms · Alarm screen | 1274:1061 | ☑ |
| 5.11.5 | Notifications & alarms · Let alarms fill the screen | 1274:16200 | ☑ |

### 6. Figma cleanup (added 29 Oct 2026, Android A77)

The user, 29 Oct 2026: "whatever we have Figma, that is the final thing … If something we don't have in the Figma, then
it definitely means it has to be deleted." Each row settles what earlier entries left under "Noted, not changed" on a
page already built, by Figma: what the app has and Figma doesn't is deleted (code, route, tests); where they differ,
Figma's. Saved data is never deleted with a screen (the D rules). Done one at a time, like a component, **after
every page in section 5 is built** (the user, 29 Oct 2026: "once everything implementation is done, clean up the old
things"); pages not built yet (5.5.6 onwards) follow A77 as they're built. Anything genuinely unclear is held for the
user, not guessed. Checked against the whole file on 29 Oct (a
search of every page's text).

| # | What goes or changes (Figma) | Status |
|---|---|---|
| 6.1 | Start from an idea: `IdeasScreen`, its route and its idea lists (no idea screen anywhere in Figma) | ☑ |
| 6.2 | The old Progress page: `ProgressScreen` and its route (the Habits tab is that page, A54); SpeedTest moves to the Habits tab | ☑ |
| 6.3 | The day's own note (no habit): Today's day-note card and "Note for the day", and the Note screen's day note (Figma's notes are a habit's, for a day); saved notes stay in the data | ☑ |
| 6.4 | Groups: Today's group filter and sheet, Show habits by, Put in a group / New group / Move to group, "Nothing from a group", Progress's group filter (A64: groups are gone) | ☑ |
| 6.5 | App Lock (`PrivacyLock`, `AppLock`): not in Figma and not in the first version | ☑ |
| 6.6 | Add screens Figma doesn't draw: check what Day details' Tick steps and Log buttons open in Figma's flows (Day details draws a Tick steps button), and delete only a screen no flow opens | ☑ |
| 6.7 | Day details: a milestone shows the bar over the sheet, no ribbon in This day; the Log screen's View footers in Figma's words ("Added by hand at 2:05 PM.", "From the timer. Started 2:09 PM.", "Your run started again from this slip."), ← on Entry as drawn; All logs' "Undo takes one back." goes; Add note on a day that has one opens Edit note, without the "already has a note" line; Add note and Edit note show no date (A78) | ☑ |
| 6.8 | Routine player: the "1 skipped for today …" line goes; Your routine's rows say only Figma's Done, Here now, Not done | ☐ |
| 6.9 | Habits & Tasks: What the squares mean starts folded; Archived habits' free-plan sentence goes; Tasks' drag to reorder and the "Moved to …" snackbar go | ☐ |
| 6.10 | Today: Paused opens unfolded, as drawn; the notices in Figma's words; Edit Today's sort helpers (`sortedByName`, `sortedByReminder`) go | ☐ |
| 6.11 | Onboarding: Restoring gets Figma's Cancel (only where nothing is half written); Plus isn't on this phone shows Contact us alone as a Text button; That isn't a backup says only Figma's two cases | ☐ |
| 6.12 | Atoms: the Day cell's note dots, corner dot and unused Small size go if Figma's cards don't draw them; leftover coach-mark code (the ✏ tip) goes | ☐ |

Settled by the user the same day (A78): "· 48 days" removed from Figma; Day details keeps ✕ (added to Figma); notes
have no date chip (removed from Figma). Start on a finished Morning: settled (A79), Start removed from those frames and the "Start when everything's already
done" flow deleted from Figma. Today's "Deleted on another device" notice
went with the sync brake it belonged to (29 Oct 2026, the user's go-ahead: Drive sync's brake removed from the core and
Android, Rulebook D17).

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
  - **Built:** run 40736055121 (Android #102, commit 641c719) passed: assembleDebug, unit tests and lint.
- **Compiling in the session (28 Oct).** The user opened the session's network fully. Google's Maven and the Android
  SDK now download (the SDK installed outside the repository, `/root/android-sdk`), but Maven Central
  (`repo.maven.apache.org`) answers the shared proxy with 429 Too Many Requests, so the session fetches it through
  Google's own copy (`maven-central.storage-download.googleapis.com`), set by an init script in the session's Gradle
  home (`/root/.gradle/init.d`), never in the repository. From 4.6 on, each component compiles in the session first
  (the app, the unit tests and the instrumented tests' code, which GitHub's build job doesn't compile), then GitHub's
  build checks the push. The first full compile also found two needless `!!` in 4.4's `SectionHeader` (Kotlin already
  knows `onStart` is there); removed with 4.6.
- **4.6 Comparison row (28 Oct).** Figma: Comparison row (1009:2), one component, no motion; 180 instances, all in
  Habit details' Week card ("Same days last week": This week, Last week) and Month card ("Compared with the month
  before": October, September). The label in Body Medium (On surface variant) taking the room left and the value in
  Label Large (On surface), 12 apart on one baseline; 6 under them, the bar, 8 tall, corners 4, in the habit's Colour,
  on no track. The larger value fills the width, the other its share. Both bars are the habit's Colour in every
  instance (Blue, Green, Orange, Grey, Brown, Purple). In the card each comparison is a divider, a heading in Label
  Large (On surface) and the two rows, 12 apart.
  Built as `ComparisonRow` (`ui/components/ComparisonRow.kt`). Habit details' comparison (`ComparisonView`,
  `ProgressTab.kt`) moved onto it; its own `ComparisonRow` is gone. The tag `habit-comparison` stays (T3).
  Fixed:
  - The label, bar and value were on one line (the label 92 wide, the value 64 at the end); now the label and value
    on one baseline, the bar under them across the width, as drawn.
  - The bar was 10 tall and round on a grey track (Secondary container); now 8 tall, corners 4, no track.
  - The earlier period's bar was the Day cell's Part colour (3.6 had moved it there from the old second step); Figma
    draws both periods in the habit's Colour, so now both are.
  Noted, not changed (the card's, for 4.15 Habit history card):
  - The code's comparison has no divider, its heading is Title Small (Figma: Label Large; the same 14/20 Medium, a
    different name), and its pieces are 8 apart (Figma 12). The rows are placed by the card.
  - A share too small to see keeps 2 % of the width (the code's, kept); Figma's formula has none.
  - **Built:** compiled in the session (the app and both test sets); run 40739873815 (Android #103, commit 5ae9471)
    passed: assembleDebug, unit tests and lint.
- **4.7 Card notice (28 Oct).** Figma: Card notice (795:499), State Notice · Progress · Done, with Show dismiss; no
  motion. Surface bright, corners 24. The icon in a 40 dp disc of Secondary container (glyph On secondary container,
  outlined), 16, the title in Title Medium (On surface) over the body in Body Medium (On surface variant), 4 apart,
  both wrapping. **Notice:** 16 at the start and top, 8 at the end and bottom; 4 under the words, Text buttons (Not
  now, then the action) at the end, 8 apart, wrapping. **Progress:** 16 all round, no buttons, 12 under the words the
  wavy bar (Primary on Secondary container). **Done:** 16 all round, the words alone. 14 instances on Today (backup
  paused, off, deleted, being sent again and done; reminders off, didn't arrive, came late; Plus waiting) and 30 on
  Backup & Sync, where it is the page's status card: 16 all round, one **Tonal** button under the words (56 in, 12
  below them), or none; and under the card, 8 down, a List item: Change account · "Backing up to sam@gmail.com".
  Built as `CardNotice` (`ui/components/CardNotice.kt`) on Material's own filled `Card` (its colours set to Surface
  bright and On surface, its 12 corners to the designs' 24), with `actionUnder` for Backup & Sync's tonal button and
  `working` / `progress` for the Progress state (Material's own moving wave, `LinearWavyProgressIndicator`, while
  there is no count). `cloud_alert` and `switch_account` added to `Symbols` from Google's own 24 px Rounded SVGs.
  Moved onto it: Today's notices (`NoticeCard`, `TodayNotices.kt`; `PlainNoticeCard` and `NoticeShape` gone) and
  Backup & Sync's status card (`BackupScreens.kt`). The tags stay (`notice-…`, `notice-dismiss`, `notice-action`,
  `backup-state`, `drive-connect`, `drive-now`, `drive-again`, `drive-change`); `FirstRunTest` reads the new words.
  The app, the unit tests (55, all passed) and the instrumented tests' code build in the session.
  Fixed:
  - The icon disc was Surface container highest with an ink glyph; now Secondary container and On secondary
    container (the same greys in light, the roles in dark). The title and body were 2 apart; now 4.
  - The card was a hand-made column on white (Surface container lowest), 12 at the end; now Material's card in
    Surface bright, 8 at the end with the words 16 in. The buttons didn't wrap; now they do.
  - Backing up again (A39) showed a turning circle in the disc and the title alone; now Figma's Progress: the disc
    keeps its icon (cloud_upload), "Backing up to Google Drive…" over "Everything goes again: your habits, notes and
    every year of logs.", the bar 12 under them, 16 all round. Done was an ink disc and "Everything is in your Google
    Drive again" alone; now the usual disc (cloud_done), "Backed up" over "Everything is in your Google Drive again.",
    as A39 and Figma say. `NoticeWork` carries the two bodies.
  - The deleted backup's notice said "Your Google Drive backup was removed" with cloud_off; now A39's and Figma's
    "Your Google Drive backup was deleted", "Your habits are still safe on this phone. Back them up again to keep a
    copy in Google Drive.", with cloud_alert.
  - Backup & Sync's status card was a 56 dp disc (ink when backed up), the title in Title Large, a line and a
    paragraph, and two buttons (Back up now, Change account; Back up to Google Drive was Filled with an icon). Now the
    Card notice as drawn: title, one body line, one Tonal button under the words; Change account is its own List item
    under the card, with the account in its line. Figma's words for its states: "Backed up · Today at 9:14 AM. It
    backs up by itself as you go.", "Not backed up · Your habits are only on this phone. Back them up to your own
    Google Drive to keep them safe.", "Backing up… · You can leave this page; it carries on." (the Progress state,
    new: the page had none), "Waiting for the internet · Last backed up … Nothing is lost: it backs up by itself once
    you're online." (no button, as drawn), and the deleted backup as on Today. The time reads "Today at 9:14 AM".
  Noted, not changed:
  - **For the user:** Backup & Sync's card no longer says "Only Often Enough can open them, and we never see them. It
    backs up as you go, at least daily." (Figma's words are shorter), and waiting for the internet no longer shows how
    many changes wait or a Try again button (Figma has neither). Rulebook D4 asks the page to say the truth, "waiting
    (how many)". Should the count come back?
  - Figma draws no Backup & Sync card for Drive full, Drive not connected or a phone without Google Play services; they
    keep the code's words in the same card (Not connected now has link_off, as Today's "Backup is off").
  - A39's own text says the working card shows "a turning circle"; Figma's drawing of the same flow, and this
    component, keep the icon. Built as Figma draws it.
  - Today's other notices keep the code's words where Figma's differ (Today's own copy, for the Today screen):
    "Backup is off" and "Reminders can't come" say "the app" where Figma says "Often Enough"; the missed reminder says
    "A reminder didn't arrive" where Figma names the habit, the time and the phone's maker (A40), and the "came 40
    minutes late" notice isn't built. The "Deleted on another device" notice is still in the code (D17 removed it from
    the designs; its code goes as build work 148.7).
  - **Built:** run 40742120775 (Android #104, commit 49ae1d3) passed: assembleDebug, unit tests and lint.
- **4.8 Milestone bar (28 Oct).** Figma: Milestone bar (852:45599), one component; its entrance is Today's ("Milestone ·
  Motion", 853:45982). 328 × 72, corners 20, the habit's **Bar** gradient (Figma's "Habit / … / Bar": Deep, tone 30,
  to Strong, tone 48, left to right), Elevation Level 3. 12 at the sides, 14 above and below; the medal (a 44 box: a
  white 40 star with a 3.3 shadow, a 0.8 line in the habit's Pale at 82 %, the number in Label Large in its Strong,
  three white sparkles at 95, 80 and 70 %), 12, the title in Title Medium over the habit's name in Body Medium at 86 %,
  both On primary, 12, See (the Small filled button, white, its label Strong). A 56 × 130 sheen tilted 20° (white at
  28 % in its middle), and the time left along the foot (20 in, 3 up, 3 tall, white at 45 %). Motion, one 5.6 s
  timeline: the bar fades in and rises 24 dp from 300 to 550 ms (emphasized decelerate); then the badge pops 0.6 → 1
  (300 ms, an overshoot), the sparkles appear 60 ms apart and settle at 60 %, the sheen sweeps once (600 ms,
  ease-in-out), and the time-left line shrinks.
  Built as `MilestoneBar` (`ui/components/MilestoneBar.kt`), with its white medal (`BarMedal`, moved in from
  `Medal.kt`'s `WhiteMedal`), and the theme's `habitStrong` and `habitDeep` (Figma's 13 Strong and Deep colours).
  See is Material's own `Button` at the Small size in white with the Strong label. The bar's own motion runs on one
  timeline read only in its layer and draw lambdas, so a moving bar never recomposes (S3, S6); the time left is an
  `Animatable` too (it was a 50 ms loop recomposing the bar). **Screen motion, on Today:** the rise and the leaving
  are `TodayScreen`'s now, Material's `AnimatedVisibility` with the motion scheme's fast spatial and effects springs
  (24 dp up and in; out, 16 dp up and fading), none with Remove animations, each milestone its own bar (keyed).
  The design system's motion helpers moved to `ui/components/Motion.kt`: `Key`, `track`, Figma's easings (`EaseOut`,
  `EaseIn`, `EaseInOut`, `Arrive`, `Pop`), `animationsOn` and `sparkle` (Celebration, MilestoneViews, HabitRow and the
  routine player use them from there; their copies are gone). Deleted with the old bar: `WhiteMedal` and the unused
  `MedalShape` (`Medal.kt`). The tags `milestone-bar` and `milestone-bar-see`, the spoken words, the swipe away and
  Android's longer time for people who ask for it stay. The app, the unit tests (55) and the instrumented tests'
  code build in the session.
  Fixed:
  - The bar was 64 tall with a gradient worked out from the habit's colour (12 % darker to 22 % lighter) and a 10 dp
    shadow in the habit's colour; now 72, Figma's Bar gradient, and Material's Level 3 shadow.
  - On a light habit colour the words and See turned dark (#1C1B1F); Figma's bar is always deep enough for On primary,
    so they are always light now, and See is white with its label in Strong.
  - The habit's name was Body Small at 85 %; now Body Medium at 86 %. The gaps were 10 and 8; now 12 and 12.
  - See was a hand-made 36 dp pill; now Material's button (40, its ripple and pressed shape).
  - The medal's number was sized by a share of the medal (a size of its own, U36); now Label Large (Label Medium past
    two digits, to stay inside the line). Its line was the Strong colour at 35 %; now the habit's Pale, 0.8.
  - The sparkles went from 40 % to 100 % and back to 70 %, growing from 60 % with an overshoot; now Figma's: from
    nothing to full and settling at 60 %, growing from nothing with the pop. The sheen was upright at 35 %; now
    tilted 20° at 28 %, 56 wide.
  - The time-left line was 16 in, 2 tall, square, in the words' colour at 55 %; now 20 in, 3 tall and round, white
    at 45 %. It starts once the bar is up, as Figma's does.
  Noted, not changed:
  - Figma's star is white to #F5F5F7 with a shadow in #244A87 at 35 % (neither is a style); built plain white
    with the shadow black at 35 %.
  - Figma's time-left line stops at 205 of 288 at the end of its loop (Figma's keyframes); the description says it
    shrinks over the 5 s, so it runs to nothing.
  - Figma draws light only. In dark the bar keeps its light look (On primary is dark in the dark scheme, so the words
    are white; See stays white); the Bar, Strong and Deep colours are the same in both, as the habit colours are.
  - Figma's pop-up and row motion in the same "Milestone · Motion" frame are 4.12's and 4.1's.
  - `Celebration.kt` line 246 has a needless `.toFloat()` (from 1.21); it goes with 4.10 Next milestone, which draws
    that ring.
  - **Built:** run 40744805315 (Android #105, commit 5c25474) passed: assembleDebug, unit tests and lint.
- **4.9 Milestone ribbon (28 Oct).** Figma: Milestone ribbon (902:16439), one component, its motion in the routine
  player's frame (2 s; the ribbon's part from 460 ms). Built as `ui/components/MilestoneRibbon.kt`: 40 tall, the full
  width, the habit's Band; centred, 16 at the sides, the 16 dp `Medal`, 8, the milestone in Label Large in the habit's
  Deep, one line. **Its own motion**, once when it's reached (`play`), read only where it's drawn: the medal spins in
  from 35° and pops (0.01 → 1.3 → 1), the words slide 8 dp and fade up, a sheen (48 × 80, tilted 20°, white at 50 %)
  passes once; at rest otherwise and with Remove animations. **The screens' motion**, `MilestoneRibbonArrival`
  (10 dp up and fading in, Material's fast spatial and effects springs, nothing with Remove animations), kept beside
  the ribbon because both screens play it alike. Moved: the routine player (across the hero card's top) and Day
  details (top of This day, corners 12, keyed per milestone). Deleted: the old `MilestoneRibbon` in `Celebration.kt`
  and the imports it alone used. The tag `day-ribbon` stays. The app, the unit tests (55) and the instrumented
  tests' code build in the session.
  Fixed:
  - The ribbon was the habit's colour at 24 % over the surface; now the habit's Band. Its words were the colour
    darkened with black at 50 %; now the habit's Deep (light; see below for dark).
  - The medal was 18; now 16. The sides were 12; now 16. Day details' words sat at the start; now centred, as Figma's
    one ribbon is.
  - It dropped 20 dp from above; now it rises 10 dp, as Figma's frame does, on Material's springs.
  - The sheen was upright, 48 wide, at 45 %; now Figma's: 48 × 80, tilted 20°, at 50 %, once from 420 ms.
  - A long milestone ran past the ribbon; now one line with an ellipsis.
  Noted, not changed:
  - Figma's Day details has no ribbon: a milestone reached there shows the bar over the sheet. Kept the ribbon in
    Day details until the Day details sheet (section 5); the user's call.
  - Figma's player frame lays the ribbon over the card (A53: nothing shifts); in the code it sits in the card's
    column, so the card grows by 40 when it's reached. For the Routine player (section 5).
  - Figma draws light only. In dark the Band is the colour at 28 % on the card, where Deep doesn't read, so the words
    are the colour's light shade there (white at 72 % over it), as before.
  - Figma's medal shadow is #244A87 at 35 % (not a style); the `Medal` atom (3.5) keeps its own shadow.
  - **Built:** run 40759503541 (Android #106, commit bf2277d) passed: assembleDebug, unit tests and lint.
- **4.10 Next milestone (28 Oct).** Figma: Next milestone (1007:16), one component, properties Title and Supporting
  text, no motion; two instances, both in the Milestones card (the design system's specimen and the habit page's
  Progress); the milestone pop-up draws the same row by hand inside its own card (853:45869). Built as
  `ui/components/NextMilestone.kt`: a row, items centred, the Circular progress (1.21, 52) with the milestone's number
  in it (✓ once a track's last is reached), 16, the title in Title Medium On surface over the supporting text in Body
  Medium On surface variant, both wrapping. Moved: the habit page's Milestones card and All milestones
  (`MilestoneNextRow`, its spoken line and the tags `habit-milestone-next-…` kept) and the milestone pop-up's next
  milestone. The app, the unit tests (55) and the instrumented tests' code build in the session.
  Fixed:
  - The row was built twice (the habit page and the pop-up); now one component.
  - The pop-up's needless `.toFloat()` (from 1.21) is gone with its copy. Nothing on screen changes: both copies
    already matched Figma's row.
  Noted, not changed:
  - The pop-up's card round the row is the colour Surface, 20 corners, 34 and 14 inside and 76 tall at least;
    Figma's is Surface container lowest, 24 corners, 20 all round. It's the pop-up's, so it goes with 4.12.
  - Material's ring keeps its 4 dp gap and round ends (1.21).
  - **Built:** run 40760673622 (Android #107, commit 95bdeeb) passed: assembleDebug, unit tests and lint.
- **4.11 Milestone badge (28 Oct).** Figma: Milestone badge (1007:9), one component, properties Name and Date, no
  motion; three instances, side by side 4 apart under Earlier in the Milestones card. Built as
  `ui/components/MilestoneBadge.kt`: a column, centred, 4 apart: the Medal at 52 (Figma's Small, scaled as its
  instance is) with its number, the name in Label Medium On surface, the date in Body Small On surface variant;
  TalkBack reads its one spoken line. `MilestoneBadgeWidth` is Figma's 92. Moved: the habit page's Earlier row
  (Progress), its tag `habit-milestone-shelf` kept. Deleted: `ShelfMedal`. The app, the unit tests (55) and the
  instrumented tests' code build in the session.
  Fixed:
  - The name and the date were cut to one line with an ellipsis; Figma's grow in height, so they wrap now, centred.
  - Past four, the row scrolled with each badge 88 wide; now Figma's 92.
  Noted, not changed:
  - The Earlier row itself (a share each up to four, scrolling past that) is the Milestones card's, 4.13.
  - **Built:** run 40761546106 (Android #108, commit d4b1196) passed: assembleDebug, unit tests and lint.
- **4.12 Milestone pop-up (28 Oct).** Figma: Milestone pop-up (853:45861), one component, six text properties; its
  motion in "Milestone · Motion", Pop-up (today components: the sheet sliding up 532 dp in 380 ms, and every layer's
  keyframes over 2.4 s); three instances (Today's motion, Day details' Mark done, the habit page's "tap a reached
  one"). Built as `ui/components/MilestonePopup.kt` on the Bottom sheet atom (1.18): 24 at the sides and 24 apart, the
  hero (the medal's stage, 176; 4; the title in Headline Small Emphasized; 4; the supporting text in Body Medium), the
  Next milestone (4.10) on a Surface container lowest card (24 corners, 20 in), and Close (Outlined) and All
  milestones (Filled), Medium, 8 apart. **Its own motion** follows Figma's keyframes to the millisecond (checked layer
  by layer: glow, medal, ring, all twelve dots, the four sparkles, the words, the card, the buttons), read only where
  it's drawn, at rest with Remove animations. **Its entrance and leaving** are Material's sheet's own (scrim, slide,
  predictive back); Close and All milestones now slide it away before they act. Moved: Today, Day details and the
  routine player. Deleted: `Celebration.kt` (`LandmarkPopup`, `CelebrationMedal` and its timeline). The tags
  `landmark-popup`, `landmark-close`, `landmark-all` and `landmark-more` stay. The app, the unit tests (55) and the
  instrumented tests' code build in the session.
  Fixed:
  - The card behind the next milestone was Surface, 20 corners, 34 and 14 inside, 76 tall at least; now Surface
    container lowest, 24 corners, 20 all round (noted at 4.10).
  - The gaps were 8 over the stage, 6 between the title and the words, 20 before the card and the buttons, 10
    between the buttons and 32 under; now none, 4, 24, 8 and the sheet's 24.
  - The buttons kept 12 at the sides (`compact`); now Figma's 24.
  - The glow was the habit's colour at 42 % fading out; now the habit's Band, 150 across, with Figma's 24 dp blur
    (drawn as its soft edge, so it works on every Android version). The ring's line was 2; now 2.5. The dots were the
    habit's Colour; now its Pale.
  - The medal was hidden until 250 ms; Figma's is there from the start, small and turned, as the sheet rises.
  - The card and the buttons arrived 50 ms late (900 and 1000 ms); now 850 and 950.
  - Close and All milestones took the sheet away at once; now it slides down first, as Material's sheets do.
  Noted, not changed:
  - "and 1 more in this routine" (the routine player's chip, RP.3) isn't in the component; kept as it was, for the
    Routine player (section 5).
  - The habit page's "tap a reached one: its pop-up again" (Figma's details pages) isn't built; for the Habit details
    page (section 5).
  - Figma draws light only; in dark the card is Surface container lowest of the dark scheme, and the glow, dots and
    medal take the habit colours' dark values (1.21, 3.5).
  - **Built:** run 40762725369 (Android #109, commit dfe1d8b) passed: assembleDebug, unit tests and lint.
- **4.13 Milestones card (28 Oct).** Figma: Milestones card (1007:24), one component with Show earlier, Show next,
  Latest and Reached; no motion; eleven instances, all on Habit details › Progress. Built as
  `ui/components/MilestonesCard.kt`: Surface container lowest, 24 corners, 20 in, 12 apart: the header (Milestones,
  a heading, and See all N as Material's Small Text button), the latest on the habit's Fill (20 corners, 16 in; the
  Medium Medal, 16, Latest / the milestone / its day, 2 apart), Earlier over up to three Milestone badges (4.11), and
  Next over each track's Next milestone (4.10); a part with nothing in it isn't shown. The habit page's words for a
  next milestone (`NextMilestone(next, …)`, with "Next · " on All milestones and its spoken line) moved beside it.
  Moved: the habit page's Progress and All milestones. Deleted: the page's own card, `MilestoneNextRow`, its plate
  colour and `MilestoneBadgeWidth`. The tags `habit-milestones`, `habit-milestones-see-all`, `habit-milestone-latest`,
  `habit-milestone-shelf` and `habit-milestone-next-…` and the spoken words stay. The app, the unit tests (55) and
  the instrumented tests' code build in the session.
  Fixed:
  - The latest milestone sat on the habit's colour at 14 % on the card; now the habit's Fill, as Figma's.
  - See all N was a hand-made pill with a chevron in On surface; now Material's Small Text button (40, 24 at the
    sides, its ripple), no chevron, as drawn.
  - Earlier showed up to four side by side and scrolled past that; Figma's description says up to three, so it shows
    the three newest, each a third, and All milestones keeps the rest.
  - The card was the page's Surface; now Surface container lowest by name (the same white in light).
  Noted, not changed:
  - With one milestone reached the header says "1 reached" and has no See all; Figma draws only the card with
    several. Kept; the user's call.
  - Figma draws light only; in dark the Fill is the colour at 24 % on the card (1.20).
  - **Built:** run 40763664187 (Android #110, commit 58b791b) passed: assembleDebug, unit tests and lint.
- **4.14 Stat tile (28 Oct).** Figma: Stat tile (1005:2), one component (Label, Show emoji, Emoji, Number, Unit,
  Caption), no motion; eight instances, all in the Overall record card's specimen (default and 200 % text). Built as
  `ui/components/StatTile.kt`: Surface container low, or the habit's Fill for the current streak; corners 16, 14 in,
  4 apart: the label in Body Small On surface variant; the value on one baseline, 4 apart (the phone's own emoji in
  Body Large, the number in Headline Small Emphasized, the unit in Body Medium, both On surface), wrapping before it's
  cut; the caption in Body Small On surface variant; one spoken line for TalkBack. Moved: the habit page's Overall
  record and a quit habit's record (`RecordBox`, its tags `habit-streak-…`, `habit-record-…` and `habit-quit-…` and
  spoken words kept). The app, the unit tests (55) and the instrumented tests' code build in the session.
  Fixed:
  - The tiles had 20 corners and 16 inside; now 16 and 14.
  - A neutral tile was Surface container high; now Surface container low. The current streak was the habit's colour
    at 18 % on the card; now its Fill.
  - The label was Body Medium; now Body Small. The unit was Body Large; now Body Medium.
  - The current streak had Material's flame icon (24, the flame colour, 6 from the number); now the phone's own 🔥,
    as Figma's emoji, in Body Large, 4 from the number on its baseline.
  Noted, not changed:
  - The tiles' grid (two a row, 8 apart, one a row from 150 % text) and which tile a quit habit tints are the Overall
    record card's, 4.16; a quit habit's current run keeps the 🔥 it had as a flame.
  - Figma draws light only; in dark the Fill is the colour at 24 % on the card (1.20).
  - **Built:** run 40764348850 (Android #111, commit 77e6ce7) passed: assembleDebug, unit tests and lint.
- **4.15 Habit history card (28 Oct).** Figma: Habit history card (978:1598), Period Week · Month · Year · Year scrolled
  back, with Habit header, Period header, Comparison, Daily chart and Week 6; no motion. 124 instances on Habits &
  Tasks (Habit header: Week, Month, Year) and 22 on Habit details › Progress (Period header, the comparison, and
  Recorded each day on Month). Built as `ui/components/HabitHistoryCard.kt`: the card (Surface container lowest, 24
  corners, 16 at the top, 20 at the start and bottom, 12 at the end, 12 apart) and its parts in Figma's order:
  `HistoryHabitHeader` (the 40 dp avatar, Title Medium over Body Medium, a trailing slot), `HistoryPeriodHeader`
  (Title Medium over Body Medium, ‹ ›), `HistorySummary` (Title Large Emphasized over Body Medium, 2 apart),
  `HistoryWeek` and `HistoryMonth` (weekday names in Body Small, today's in Label Medium On surface; the squares 36
  and 6 apart, 8 under the names in Week, 6 in Month), `HistoryYear` (letters 12 wide, 6, weeks of 24 squares 4 apart
  under the months in Body Small; scrolls and opens on the latest week), `HistorySection` (a divider, the heading in
  Label Large, 12 apart) and `HistoryDailyChart`. Every card's squares are one Canvas (S12). Moved: the Progress
  page's habit cards (Week, Month, Year) and Habit details' Week and Month cards, the Year in Pixels card's header.
  Deleted: `ui/progress/HeatMap.kt` (its grid, week, month, year and sizes), `HeatMonthGrid`, Habit details'
  `DayNames` and `PeriodHeader`, `ui/charts/Charts.kt` (`LightBarChart`, `ChartAxis`) and `amountsUnder`. The tags
  (`progress-row-…`, `habit-progress-week`, `week-strip`, `month-grid`, `previous-…`, `next-…`, `habit-comparison`,
  `habit-month-chart`) and the spoken words stay. The app, the unit tests (55) and the instrumented tests' code build
  in the session.
  Fixed:
  - Both cards had 16 or 20 all round and 16 or 4 between their parts; now Figma's 16 / 20 / 12 and 12, the summary
    and its line 2 apart. Habit details' summary was Title Large; now Title Large Emphasized.
  - The squares were spread to fill the card's width (each a seventh, up to 36); now Figma's 36, 6 apart, as drawn.
  - The weekday names were Body Medium (today's underlined) on the Progress page and Label Medium on Habit details;
    now Body Small, today's in Label Medium On surface, no underline.
  - Habit details' Month put the day's number over every square, the amount under it and a dot for a note; Figma's
    Month has none of them (A60 for the dots). The amounts stay in Recorded each day.
  - The Progress page's icon was 44 in a cookie; now the list item's 40 dp circle. Its name was Body Large; now
    Title Medium.
  - Year: the letters were Label Medium in a 16 column, 4 from the weeks, the months Label Medium in an 18 row; now
    Body Small, 12, 6 and 16 + 4.
  - Recorded each day and the comparison now sit under a divider each, their headings in Label Large (the
    comparison's was Title Small), the comparison's rows 8 in from the end as drawn.
  - Recorded each day was an auto-scaled chart with ticks every step, a dashed goal line and a day number every
    week; now Figma's: the goal at 96 of 120 (bars stop at 120), lines at the goal, half of it and the baseline in
    Outline variant, the goal's and the half's amounts in the habit's own words at the end ("8 glasses"), bars two
    thirds of their slot with top corners 2, and the 1st and today under them.
  Noted, not changed:
  - Figma's Habits & Tasks header ends in ⋮ (Edit habit, Pause…, Archive, Delete; A54); the Progress page keeps its
    chevron until Habits & Tasks is built (section 5), which also brings Week · Month · Year as A54 has them.
  - A week goal's Week column ("Met", "1 of 3") isn't in Figma's Month; kept, the squares then 32. The user's call.
  - With no daily goal (a week or month total), the most in a day takes the goal's place on the chart; in a past
    month only the 1st is numbered. Figma draws only a daily goal in the current month.
  - The squares keep Figma's 288 dp: on a wider phone the room is at the card's end, as Figma's card hugs them.
  - Figma draws light only; the squares, lines and words take the dark scheme's roles.
  - **Built:** run 40765453143 (Android #112, commit 409a132) passed: assembleDebug, unit tests and lint.
- **4.16 Overall record card (28 Oct).** Figma: Overall record card (1158:119643), Text Default · 200 %, with Since,
  Total and Total unit; no motion; eleven instances, all on Habit details › Progress. Built as
  `ui/components/OverallRecordCard.kt`: Surface container lowest, 24 corners, 20 in, 12 apart: the header (Overall
  record in Title Medium, a heading, and since when in Body Medium, 8 apart; stacked 4 apart from 150 % text), the
  total (`OverallRecordTotal`: the number in Headline Large Emphasized On surface and its unit in Body Large On
  surface variant, 8 apart on one baseline, wrapping), the Stat tiles (4.14) two a row, 8 apart and as tall as each
  other (one a row from 150 % text), anything more, then See all streaks (Material's Small Text button) at the end.
  Moved: the habit page's record and a quit habit's record (its ticking run in the total's styles, See all runs,
  the money saved). Deleted: `PageCard` and `SeeAllLink`. The tags `habit-progress-record`, `habit-record-headline`,
  `habit-see-all-streaks`, `habit-see-all-runs` and `quit-money-saved` stay. The app, the unit tests (55) and the
  instrumented tests' code build in the session.
  Fixed:
  - The card had 16 inside and 16 between its parts; now 20 and 12.
  - The total was Display Medium; now Headline Large Emphasized, its words 8 from the number on its baseline (they
    were one string). A quit habit's run takes the same styles.
  - At large text the header stayed on one line; now the date goes under the title, as Figma's 200 %.
  - See all streaks (and See all runs) was a hand-made link with a chevron in On surface, 48 tall; now Material's
    Small Text button, no chevron, as drawn.
  - A row with one tile left gave it the whole width; now it keeps its half, as Figma's grid of two.
  Noted, not changed:
  - "Done on" before the number (a check habit's record) isn't in Figma's card, which draws an amount; kept, in
    the unit's style.
  - A quit habit's record (its four tiles, the money saved) has no Figma variant here; it uses the same card.
  - Figma draws light only; the card takes the dark scheme's roles.
  - **Built:** run 40766647917 (Android #113, commit e389f20) passed: assembleDebug, unit tests and lint.
- **4.17 Year in pixels card (28 Oct).** Figma: Year in pixels card (1226:2470), Plan Plus · Free, with Period,
  Summary and Detail; no motion; ten instances (Plus) and one (Free) on Habit details › Progress. Built as
  `ui/components/YearInPixelsCard.kt` on the Habit history card's frame and header (4.15): "Year in pixels" with
  its year and ‹ ›, the summary, the grid, and "Tap a square to see its day." in Body Small. The grid fills the
  card's width and never scrolls sideways: a square is (width − 8 − 18 − 12 × 3) ÷ 12 (19.5 on a 360 dp phone),
  rows and columns 3 apart, the months' letters over the columns and the 1st, 6th … 31st down the side, all Body
  Small On surface variant; each square the Day cell (3.6, Size Year, scaled), in one Canvas. The Free plan is built
  in (`locked`, `onUnlock`): blurred under the Scrim at 16 %, the arrows hidden in place, the prompt with the Plus
  label 16 under the header, the whole card one tap target. Moved: Habit details' Year card (tags `habit-year-grid`,
  `year-pixels`, `previous-year`, `next-year` kept). Deleted: `HeatYearPixels`, the Day cell atom's note dots
  (`DayCellDraw.note`, its two paths and colour) and `noteIndexes`, which nothing draws since A60. The app, the unit
  tests (55) and the instrumented tests' code build in the session.
  Fixed:
  - The card was 12 at the sides and 16 at the top and bottom, its parts 16 apart; now the history card's 16 / 12 /
    20 / 20 and 12. Its title said "Year in Pixels"; now Figma's "Year in pixels". The summary is Title Large
    Emphasized, 2 over its line.
  - Squares were always 24 with the gaps squeezed between 1 and 4 to fit, so on a 360 dp phone the twelve columns ran
    past the card; now they fill the width, 3 apart, as Figma's description says.
  - Months were three letters in Label Small Medium; now one letter in Body Small. Every day was numbered down the
    side in Label Small, right-aligned; now the 1st and every fifth day after, in Body Small, from the start.
  - A day with a note had a dot in its square's corner; gone (A60).
  - The footnote "Tap a square to see its day." was missing.
  Noted, not changed:
  - The Free plan isn't switched on: A73 makes the year at a glance Plus (this card, and the Habits page's Month and
    Year), which is one change with the Plus screen and Habits & Tasks (section 5). The card is ready for it.
  - Figma's grid shows no today ring; the Day cell keeps its Today ring (3.6).
  - The blur is Android 12's and later; on Android 11 a locked card shows the scrim and the prompt without it.
  - **Built:** run 40767915907 (Android #114, commit db8856e) passed: assembleDebug, unit tests and lint.
- **4.18 Day navigation (28 Oct).** Figma: Floating toolbar (581:145), one component with Day, Count, Show count and
  Show ring; no motion; seven instances on Today. Built as `ui/components/DayNavigation.kt`: the Floating toolbar
  atom (1.5, Material's `HorizontalFloatingToolbar` on Surface bright, 16 from the edges, its width never changing)
  with ‹ and › (Icon buttons, 48) and between them the day, one button for Go to a day, 4 in at its sides and 8
  apart: `DayRing` (20 dp, inner radius 0.72, the arc On surface from twelve o'clock on an Outline variant track),
  the day in Title Medium with ▾ 2 after it, and the count in Label Large On surface variant. Moved: Today's
  `DayBar`, which now works out only the day's words and numbers. Deleted: `MiniRing` (`Shapes.kt`). The tags
  `day-bar`, `day-previous` and `day-next` and the spoken words stay. The app, the unit tests (55) and the
  instrumented tests' code build in the session.
  Fixed:
  - The ring's band was 3 dp; now Figma's inner radius 0.72 (2.8 dp on 20).
  - The ▾ touched the day's name; now 2 after it. The day had nothing at its sides; now 4. A long day name now ends
    in … before it pushes the count out.
  Noted, not changed:
  - Figma's description still names `DayBar` and `MiniRing` as the code; the new Code line is added after it, as
    the build prompt says to change nothing else there.
  - **Built:** run 40768891140 (Android #115, commit b8870fa) passed: assembleDebug, unit tests and lint.
- **5.1.1 Onboarding · Splash (28 Oct).** Figma: Splash (553:2427), one component, no properties and no motion; thirteen
  instances (onboarding's flows, one on Today). Android's own splash (the SplashScreen API, A76's "as it is"): the
  adaptive icon's foreground, 288 dp in Figma (Android shows it in its 192 dp circle), on white, then Today. Compared
  with the code: `themes.xml` sets the splash background to #FFFFFF and the icon to `splash_icon`, Figma's own SVG
  export of the same three tiles (#BFBFBF, #666666, #333333, the 52:60 inset and 12° tilt), and `MainActivity` keeps it
  up until the habits are read. Nothing differs, so nothing changed; no Kotlin component, because Android draws it.
  Noted, not changed:
  - The white is the Logo Guide's, not a colour role (Figma uses no style there); kept.
  - Figma draws light only; in dark the splash is #0D0D0D with the dark foreground (`values-night`,
    `drawable-night`), from the Logo Guide (13 Oct 2026).
  - **Built:** run 40770191493 (Android #116, commit 9675fd1) passed: assembleDebug, unit tests and lint.
- **5.1.2 Onboarding · Today, no habits yet (28 Oct).** Figma: Today, no habits yet (547:2419), one screen, no
  properties and no motion; fourteen instances in the onboarding flows. Today's top bar (☰ and +; built with Today,
  5.2.2) over the empty state, built as `ui/components/EmptyState.kt`: centred in what's left, 16 at the sides, the
  checklist glyph (48) in a 112 dp cookie of Surface container highest, On surface; 16; "No habits yet" in Headline
  Small Emphasized On surface over "Add something you'd like to do often enough." in Body Large On surface variant, 8
  apart, centred, the full width; 24; New habit (Filled, Small, +) over Restore from a backup (Tonal, Small), 8
  apart. Moved: Today's `NoHabitsYet`. The words FirstRunTest reads stay. The app, the unit tests (55) and the
  instrumented tests' code build in the session.
  Fixed:
  - The cookie was Secondary container (the same grey in light, not the same role); now Surface container highest.
    The glyph was 50; now 48.
  - The words were held to 268 dp, 32 in at the sides; now the full width, 16 in, as drawn.
  Noted, not changed:
  - Figma's cookie is a nine-point star with sharp points (inner radius 0.86); the app's `CookieShape` is the same
    nine scallops, rounded, as Material's cookie shapes are. Kept.
  - Today's other empty states (Nothing planned, Nothing from a group) keep their own layout until Today (5.2.2).
  - **Built:** run 40771154930 (Android #117, commit e4db293) passed: assembleDebug, unit tests and lint.
- **5.1.3 Onboarding · Restore from a backup (28 Oct).** Figma: Restore from a backup (553:4083), one screen, no
  properties and no motion; 21 instances across the onboarding flows. A top app bar with ← only; the content 16 at the
  sides, 24 apart and 24 under: the Heading ("Restore from a backup." in Headline Small Emphasized On surface over
  "Choose where your backup is." in Body Large On surface variant, 8 apart) and two List items (2.4), First and Last,
  2 apart: Google Drive · Backed up automatically (the Drive logo in a Surface container highest avatar) and A backup
  file · A file you saved (description), each ending in ›. The screen is `RestoreFlow`'s first step, on the flows'
  shared `FlowScreen` and `StepHeading`. Figma's onboarding and Plus screens all draw their heading and content this
  way (checked: 14 onboarding frames, 10 Plus frames), so the two shared parts were fixed rather than this screen
  alone. The words and tags FirstRunTest reads stay. The app, the unit tests (55) and the instrumented tests' code
  build in the session.
  Fixed:
  - Every flow's title was Headline Medium Emphasized, 8 in from the sides; now Headline Small Emphasized at the
    content's edge, as Figma's Heading.
  - A flow's content started 8 under the top bar; now right under it (Figma's content has no top padding). A centred
    message keeps its 24.
  - The heading's colours were the app's ink and secondary; now On surface and On surface variant by name (the same
    values).
  Noted, not changed:
  - The rows already matched Figma (the List item atom, 2.4).
  - **Built:** run 40772411782 (Android #118, commit eb47678) passed: assembleDebug, unit tests and lint.
- **5.1.4 Onboarding · Restoring (28 Oct).** Figma: Restoring (582:7893), one screen, no properties and no motion; 15
  instances. No top bar; centred, 24 at the sides: Material's contained loading indicator (64, its shapes On surface
  in a Surface container highest circle), 24, "Restoring your habits" in Headline Small Emphasized On surface over
  "From sam@gmail.com's Google Drive" in Body Medium On surface variant, 8 apart; Cancel (the Medium Text button,
  full width) in a bottom bar. The screen is `WaitScreen` (`backup/BackupScreens.kt`), `RestoreFlow`'s Restoring step.
  The app, the unit tests (55) and the instrumented tests' code build in the session.
  Fixed:
  - The title was Title Large Emphasized; now Headline Small Emphasized.
  - The sides were 40; now 24, the words the full width between them.
  - The indicator's circle was Secondary container (the same grey in light); now Surface container highest. Its
    shapes and the words take On surface and On surface variant by name.
  Noted, not changed:
  - **Cancel isn't there.** The code is built to have no way out while habits are written ("writing habits isn't
    stopped halfway", and Back does nothing), so nothing is ever half restored. Adding Cancel changes what a restore
    does; that's the user's call (the build prompt's rule on data). Without the bottom bar the words sit 40 lower
    than Figma's, centred in the whole screen.
  - **Built:** run 40773139756 (Android #119, commit 91bece1) passed: assembleDebug, unit tests and lint.
- **5.1.5 Onboarding · Plus isn't on this phone (28 Oct).** Figma: Plus isn't on this phone (582:8320), one screen, no
  properties and no motion; three instances (made on Android with Plus, twice; made on an iPhone with Plus). ← only;
  the Heading ("Plus isn't on this phone." over the lead); a bottom bar, 12 / 16 in and 8 apart: Check again (Medium
  Filled, full width) over Contact us (Medium Text). It is `RestoreFlow`'s NEEDS_PLUS step on `FlowScreen` and
  `StepHeading`, fixed with 5.1.3. Compared: the words (both leads), the buttons, their order, sizes and styles, the
  bottom bar and the top bar are Figma's. Nothing differs, so nothing changed.
  Noted, not changed:
  - In the iPhone instance Check again is hidden and Contact us is left as the Text button, alone; the code makes it
    the Filled button there, as the screen's one way on. It looks like a hidden layer rather than a decision; the
    user's call.
  - Figma's frame is filled #F0F0F3 (no style), not Surface container; the screen keeps Surface container, as every
    other flow screen.
  - **Built:** run 40774018710 (Android #120, commit 5ecd4c2) passed: assembleDebug, unit tests and lint.
- **5.1.6 Onboarding · No internet (28 Oct).** Figma: No internet (582:8426), one screen, no properties and no motion;
  two instances (restoring from Google Drive; checking Plus). No top bar; centred over a bottom bar, 24 at the sides:
  wifi_off (28, On surface) in a 64 dp circle, 24, "No internet" in Headline Small Emphasized over the line in Body
  Medium On surface variant, 8 apart; Try again (Medium Filled) over Cancel (Medium Text), 8 apart, 12 / 16 in. It
  draws the same as Restoring (5.1.4) but for its icon and buttons, so both are now one component,
  `ui/components/CentredMessage.kt` (`CentredMessage`, with `MessageIcon`): `RestoreFlow`'s two No internet steps
  (`Centred`) and `WaitScreen` use it. Both screens' words and the tags `no-internet-…` stay. The app, the unit tests
  (55) and the instrumented tests' code build in the session.
  Fixed:
  - The title was Title Large Emphasized; now Headline Small Emphasized. The sides were 40; now 24, the words the
    full width.
  - The icon's circle was Secondary container (the same grey in light); now Surface container highest, as Figma's
    #E2E2E2 is on these screens (Restoring's is that style by name).
  Noted, not changed:
  - Figma fills this frame and its circle without styles (#F0F0F3 and #E2E2E2); the screen keeps Surface container,
    and the circle takes the matching role.
  - **Built:** run 40774985570 (Android #121, commit 5c69b56) passed: assembleDebug, unit tests and lint.
- **5.1.7 Onboarding · No backup found (28 Oct).** Figma: No backup found (690:13442), one screen, no properties and
  no motion; one instance. ← only; the Heading ("No backup found." over "There's no Often Enough backup in
  sam@gmail.com's Google Drive."); one List item, Single (description · A backup file · A file you saved ›); Try
  another Google account (Medium Filled) in the bottom bar. It is `RestoreFlow`'s NO_BACKUP step on `FlowScreen`,
  `StepHeading` (5.1.3) and the shared `FileChoice` row. Compared: words, the row and its position, the button and
  the layout are Figma's. Nothing differs, so nothing changed.
  - **Built:** run 40775688323 (Android #122, commit aa573ca) passed: assembleDebug, unit tests and lint.
- **5.1.8 Onboarding · That isn't a backup (28 Oct).** Figma: That isn't a backup (582:8484), one screen, no
  properties and no motion; two instances (not a backup; from a newer version). ← only; the Heading; one button in
  the bottom bar (Choose another file, or Update Often Enough; Medium Filled). It is `FileProblem`
  (`backup/BackupScreens.kt`) on `FlowScreen` and `StepHeading` (5.1.3). The app, the unit tests (55) and the
  instrumented tests' code build in the session.
  Fixed:
  - From a newer version said "… to bring it back; nothing has changed yet."; now Figma's "… to bring it back.
    Nothing has changed yet."
  Noted, not changed:
  - The code also says why when a file was zipped again by another app or doesn't match (damaged); Figma draws only
    the plain case and a newer version. Kept.
  - Section 5.1 (Onboarding) is done.
  - **Built:** run 40776376075 (Android #123, commit de38ade) passed: assembleDebug, unit tests and lint.
- **5.2.1 Today · Navigation drawer (28 Oct).** Figma: Navigation drawer (626:76), one component, no properties and no
  motion (Material's drawer slides in itself); two instances. Material's modal navigation drawer on Surface container
  low, end corners 16: the header (the mark, 36, and "Often Enough" in Title Large Emphasized On surface, 12 apart, 28
  from the edges, 16 above and below), then six Drawer items (1.8), 56 tall and 12 in, one under another (Today,
  Habits & Tasks with its count; a divider in Outline variant, 8 above and below, 28 in; Plus, Settings, Contact us,
  Send feedback). It is `MenuDrawer` (`menu/Drawer.kt`), with the tablet's `MenuSidebar` on the same rows. The tags
  `menu-drawer` and `menu-…` stay. The app, the unit tests (55) and the instrumented tests' code build in the
  session.
  Fixed:
  - The sheet was Surface container lowest (the cards' white); now Surface container low, as drawn (the sidebar too).
  - The header sat 24 from the start and had 28 under it; now 28 from both edges and 16 above and below.
  - The rows had 4 between them; now none, as Material's and Figma's.
  - The divider was Outline variant at 60 %; now Outline variant. The room under the last row was 24; now 16.
  Noted, not changed:
  - The sheet's width is Material's (`ModalDrawerSheet`); Figma's 304 on a 360 dp phone is what Material leaves for
    the scrim there, so no width of ours is set.
  - **Built:** run 40777327621 (Android #124, commit fc0566d) passed: assembleDebug, unit tests and lint.
- **5.2.2 Today · Today (28 Oct).** Figma: Today (728:7985), Screen Today · Steps open · Back to today · Tomorrow ·
  Nothing planned · Notice · Large text, with Morning row 4, Anytime row 4 and Paused section; 523 instances. The top
  app bar (☰, ✏, +; no title), then the list 16 at the sides: the time-of-day sections 16 apart, each a Section header
  (4.4) and its Habit rows (4.1) 2 apart; the Card notice (4.7) first when there is one; on a later day the Planned
  line (Body Medium On surface variant, 4 in); 80 under the last card; the Bottom fade (80: the page colour, clear, 90 %
  at 60 %, solid) with the day bar (4.18) 16 above the screen's foot; Back to today (Material's Small Tonal button with
  calendar_today, Surface container lowest, Level 3) 16 above it on another day; Nothing planned as the empty state
  (5.1.2) with New habit (Tonal). It is `TodayScreen` (`today/TodayScreen.kt`). The app, the unit tests (55) and the
  instrumented tests' code build in the session.
  Fixed (Figma and the decisions of 21–23 Oct: "top bar ≡ · ✏ · + with no filter", A32, A48, A64):
  - The top bar had a Filter button and its sheet (a group to show, Hide done habits, Hide done tasks) with chips
    under the bar; gone, and Today no longer applies a group or hides done rows from the old saved settings, so nobody
    is left with a filter they can't see or turn off. The groups pages themselves stay (Habits & Tasks opens them).
  - Done rows sank to the end of their time of day; now they stay where they are (A32).
  - The tip under ✏ after three days is gone (A48), with its seen-days count and the test launch's argument for it.
  - The bottom fade was 170 tall (50 % at the middle); now Figma's 80 (90 % at 60 %), solid under it over the
    gesture bar. The list's room under the last card was 132 (192 on another day) whatever the gesture bar; now 80
    (136) above the gesture bar.
  - Back to today was a hand-made pill (an outline, a 6 dp shadow in the page's white, 12 above the bar); now
    Material's Small Tonal button on Surface container lowest with Level 3, 16 above the bar.
  - The Planned line was 16 in; now 4, as drawn. Nothing planned had a 24 gap under the cookie, words held to 32 in
    and sat 96 high; now the empty state (16, full width, centred).
  - Deleted: `FilterSheet` and its rows (`FilterAndGroups.kt`), `groupCount`, `TodayChips`, `InputChip`, `TopIcon`,
    `NothingInGroup`, `ArrangeTip`, TodayNav's `newGroup` and `editGroups`, and the instrumented test
    `aNewGroupFiltersToday`, which tested only the filter that's gone (a removed feature, not a loosened test).
  Noted, not changed:
  - Settings still has "Done habits: Move to bottom / Stay in place"; on Today it now does nothing (A32). It goes with
    Settings (5.8.3). The widgets keep their own order rule (widgets: their look only).
  - The day's note (a card above the sections) and "Note for the day" under them aren't in Figma's Today; kept, the
    user's call.
  - The Progress page still filters by group; that's Habits & Tasks (5.5).
  - **Built:** run 40778735342 (Android #125, commit 78a1671) passed: assembleDebug, unit tests and lint.
- **5.2.3 Today · Edit Today (28–29 Oct).** Figma: Edit Today (827:39487), State Default · Dragging a habit · Empty time
  of day · Dragging a section; no motion of its own (the row follows the finger); fifteen instances. "Edit Today" with
  ←; the content 16 at the sides, 40 under; each time of day 16 apart: its heading (48 tall, 16 in, "Morning · 6 AM –
  12 PM" in Label Large Primary, ending in ✏ for a timed one or the drag handle for Anytime and Quitting), 8, then its
  habits as List items (2.4), 2 apart and 24 at the ends: the icon in a 40 dp Surface container highest avatar, the
  name in Title Medium, how often in Body Medium, the drag handle; paused ones last in their time of day, "Paused";
  Add time of day (Small Tonal, +) after the timed ones. It is `ArrangeDayScreen` (`today/ArrangeDay.kt`); the drag,
  Move up / Move down / Move to…, the snackbars and every tag stay. The app, the unit tests (55) and the instrumented
  tests' code build in the session.
  Fixed:
  - The title said "Arrange Today"; now "Edit Today", as on ✏'s screen in Figma and the decisions (21 Oct).
  - A time of day's label was grey, 40 tall, with a ⋮ (sort, edit, move); now Primary and 48, with ✏ (timed) or the
    handle (Anytime, Quitting), which TalkBack can move up and down.
  - The rows had a 32 dp grey disc (18 dp icon), the name in Body Large over Body Small, 20 dp ends and 4 above and
    below; now the List item's 40 dp avatar, Title Medium over Body Medium, 24 ends and 8.
  - Paused habits were a group of their own at the end ("Paused · always last", with their return dates); now last in
    their own time of day, "Paused", as drawn.
  - The end had a footnote and a Times of Day row; now Add time of day after the timed ones (it opens New time of
    day). The content started 8 under the bar; now right under it, with 40 at the end.
  Noted, not changed:
  - Sort by reminder time and Sort A to Z (the old ⋮) aren't in Figma, so they're gone from the screen; their helpers
    (`sortedByName`, `sortedByReminder`) stay, as a unit test covers the first. The user's call to bring sorting back.
  - The paused rows no longer say when they come back ("Back on …"); Figma says "Paused". Today's paused rows still do.
  - **Built:** run 40797496814 (Android #126, commit 3cc6ab0) passed: assembleDebug, unit tests and lint.
- **5.2.4 Today · Milestone · Motion (29 Oct).** Figma: Milestone · Motion (853:45982), Kind Bar · Pop-up · Row band,
  motion only; 25 instances. Checked keyframe by keyframe against the code:
  - **Bar:** rises 24 and fades in, then stays 5 s: Today's `AnimatedVisibility` on Material's fast springs (4.8);
    the 5 s (longer when the phone asks for more time) is the bar's own.
  - **Pop-up:** the scrim to 32 % and the sheet sliding up (380 ms, emphasized decelerate) are Material's
    `ModalBottomSheet`'s own (4.12); everything inside follows Figma to the millisecond (4.12).
  - **Row band** (a milestone reached by a tap in the row, `MilestoneBand` and `milestoneBurst` in
    `today/MilestoneViews.kt`): the medal's spin and pop, the words, the sheen, both sparkles, the burst ring and its
    eight dots, 12 ms apart, all match Figma's 2 s loop on the code's 2.6 s timeline, ms for ms; the row's own fill,
    count roll, button press and after-log buttons are the Habit row's (4.1).
  The app, the unit tests (55) and the instrumented tests' code build in the session.
  Fixed:
  - The band slid 10 dp into a row that had already grown by its full height, and was in by 600 ms; now it opens
    from nothing to its height (420–800 ms, emphasized decelerate) and fades in over 460–620 ms, so the row grows
    smoothly, as drawn.
  Noted, not changed:
  - The band opening changes the row's height while it plays (one row, under a second); the rest of the moment is
    drawn without layout (S3, S6).
  - Section 5.2 (Today) is done.
  - **Built:** run 40797952439 (Android #127, commit 19ab2d7) passed: assembleDebug, unit tests and lint.
- **5.3.1 Day details · Day details sheet (29 Oct).** Figma: Day details sheet (669:234), Kind Amount · Status ·
  Checklist · Cut down, with Period, Status, Show progress, Second button, Logs title, Show logs, Log 2, Log 3, Show
  skip and Limit; no motion of its own (Material's sheet slides); 147 instances. The Bottom sheet atom (Surface
  container low, the drag handle); the Top app bar (64, on the sheet's colour) with the day and ⋮; the content 16 at
  the sides, 16 apart, 24 under: the habit (a List item, Single, two lines: its 40 dp avatar, Title Medium, Body
  Medium, ›); the Day card, two pieces 2 apart on Surface container lowest: This day (24 / 4 corners, 20 by 16 in:
  "This day" in Label Medium On surface variant, 4, the count in Display Medium with its words in Body Large and what's
  left in Body Medium, 8, the wavy progress; 24; a checklist's steps; 24; the Medium buttons, 8 apart) and the note (a
  List item, Last: sticky_note_2 in its avatar, "Add a note…", ›); the day's logs (their title in Label Large On
  surface variant, 16 in, 8 over List items with the time and ›; four or more: two and "All N logs"); Skip today
  (Medium Outlined, full width). It is `DayDetailsSheet` / `DayDetailsContent` (`day/DayDetails.kt`). Every tag and
  word the tests use stays. The app, the unit tests (55) and the instrumented tests' code build in the session.
  Fixed:
  - The top bar was a hand-made row, 56 tall, its title in Title Large Emphasized; now the Top app bar atom (1.6), 64,
    with ✕ and ⋮ as its icons.
  - The habit had a 48 dp icon in a hand-made row (16 / 12 in); now the List item's 40 dp avatar and its spacing, on
    Surface container lowest.
  - This day and the note were one card (28 corners) with a divider and a row in Body Medium, the note's icon bare;
    now two pieces of a group (24 / 4 corners, 2 apart), the note a List item with its icon in an avatar and "Add a
    note…" in Title Medium, as Figma's description asks ("The note is a list item, not a divider and a row").
  - Inside This day: 20 at the sides and 18 / 4 above and below; now 16 at the sides and 20 above and below; 4 under
    "This day"; 24 (was 12) above the buttons and above the steps (was 4).
  - The parts were 12 apart and 8 under the bar; now 16 and none.
  - The logs' title was flush with the rows; now 16 in. The log rows and All N logs are on Surface container lowest.
  Noted, not changed:
  - Figma's Top app bar instance has no leading icon (its description says ✕); ✕ kept, so the sheet can be closed
    without a swipe. The user's call.
  - The wavy bar's track is the habit's colour at 25 % in this frame; the Linear progress atom (1.20) keeps the
    habit's Fill, as everywhere else.
  - The two buttons keep 12 at their sides (`compact`) so "Log manually" fits half the width; Figma draws 24.
  - The milestone ribbon at the top of This day isn't in Figma (5.1 / 4.9); kept.
  - **Built:** run 40798504142 (Android #128, commit aaa4f9d) passed: assembleDebug, unit tests and lint.
- **5.3.2 Day details · Log screen (29 Oct).** Figma: Log screen (687:829), Kind Amount · Duration · Slip by Mode
  Entry · View · Error, with Show seconds. The one screen for adding, viewing and editing a record: the Top app bar
  (64); the content 16 at the sides, 8 apart, nothing above; the fields, 2 apart (the habit, a List item, First, one
  line; Date | Time, two two-line List items 72 high, 8 above and below, 16 / 8 in, ›, Date filling and Time hugging,
  their outer corners 24); "Amount" or "How long" in Label Large On surface variant, 16 in, 8 above; the Value card
  (Surface container lowest, corners 24, 16 above and below: the number in Display Medium On surface, the unit in Body
  Large On surface variant) or the How long card (corners 24, 20 by 16 in, 12 apart: boxes 80 high, corners 12, Surface
  container high when focused and Surface container when not, Display Medium Emphasized On surface / On surface
  variant, the labels 8 under in Body Medium); the footer in Body Small On surface variant, 16 in, Error for what's
  wrong ("Enter more than zero.", the "0" in Outline); the Bottom bar (12 / 16): Add or Save, Medium Filled, the full
  width; in View, "Delete log" / "Delete slip" (Medium Outlined, Error) and Edit (Medium Filled), half each. It is
  `AddLogScreen` and `LogScreen` (`record/RecordScreens.kt`) with their parts in `record/RecordParts.kt`. Every tag and
  word the tests use stays. The app, the unit tests (55) and the instrumented tests' code build in the session.
  Fixed:
  - The main button was a hand-made 48 dp box in On surface; now the Button atom (2.1), Medium Filled, 56, Material's
    own disabled colours. Delete | Edit lost their 12 dp sides (`compact`): Figma's Medium buttons keep 24.
  - The amount card had 20 corners, 18 above and below and a 112 dp floor, its number in Display Medium Emphasized and
    its empty "0" in Secondary container; now 24, 16, no floor, Display Medium and Outline. The View shows the number
    as text, not a field you could focus.
  - The How long card had 28 corners; the focused box was Secondary container with a 2 dp On surface outline and the
    others Surface container high, every number On surface; now 24 corners, Surface container high / Surface container
    with no outline, the unfocused numbers On surface variant and an empty focused "0" in Outline.
  - A time log's View showed the three typing boxes, read-only; now Figma's Value card, "2 min 42 s" (`DurationValue`,
    tag `record-duration`).
  - Date | Time had 14 above and below and an arrow (keyboard_arrow_right); now 8 and Figma's chevron_right. The View's
    date has its year ("Today, 21 Oct 2026"), as Entry's always had.
  - The content had 8 above it; now none, as Figma.
  - A zero How long said "A session is longer than zero." (or "Enter how long, more than zero."); now Figma's "Enter
    more than zero.", as for an amount.
  Noted, not changed:
  - Figma's Top app bar instances in Entry show ← (Leading=Back) while the description says Entry closes; ✕ kept for
    Entry and Edit (U18 asks before losing typing), ← for View.
  - Figma's View draws › on Date and Time, but in View neither opens anything until Edit; no › there, so nothing looks
    tappable that isn't.
  - Figma's footers in View read "Added by hand at 2:05 PM.", "From the timer. Started 2:09 PM." and "Your run started
    again from this slip."; the app's words ("Logged by hand.", "Logged with the timer.") come from the record's own
    source (`originLine`) and a timer's start isn't stored apart from its log. The user's call.
  - The habit's name may take two lines at large text sizes (Figma: one line), so a 24-letter name is never cut.
  - "Recorded in India Standard Time", for a record made in another time zone, isn't in this frame (Figma 9.3.4); kept.
  - The Add screen's Steps card (Tick steps) and the check / mark-done kinds aren't in this frame; they keep their
    look until their own frames.
  - **Built:** run 40799737559 (Android #129, commit bdd5dde) passed: assembleDebug, unit tests and lint.
- **5.3.3 Day details · All logs screen (29 Oct).** Figma: All logs screen (694:607), with Log 3 … Log 6 and the
  Footer as properties. Every record of one habit on one day, newest first, from Day details' "All N logs ›": the Top
  app bar (64) with ← and "Today’s logs"; the content 16 at the sides, 8 apart, nothing above; the rows, one-line List
  items 56 high, 2 apart, on Surface container lowest (the value in Title Medium On surface; the clock in Body Medium On
  surface variant and ›, 16 apart); the footer in Body Small On surface variant ("7 glasses in all. Tap a log to change
  or delete it."). A row opens the Log screen's View. It is `AllLogsScreen` (`record/RecordScreens.kt`); the rows'
  end is Day details' `LogTrailing`. Every tag the tests use stays. The app, the unit tests (55) and the instrumented
  tests' code build in the session.
  Fixed:
  - A title over the rows ("Water · 6 logs", Label Large) isn't in Figma; gone. The habit's name was only there; the
    screen opens from that habit's Day details, which names it.
  - The rows were on the List item's default colour; now Surface container lowest, as Figma and Day details.
  - The clock and › (or Undo) were 8 apart; now 16, the List item's own gap (Day details' log rows too).
  - The content had 8 above and 16 under it; now neither, as Figma.
  - "Today's logs" had a straight apostrophe; now Figma's ’ (Day details' section title too).
  Noted, not changed:
  - A check's rows (a counted check has nothing to view) keep their named Undo in place of ›, and their footer "Undo
    takes one back."; Figma draws only amounts.
  - **Built:** run 40800473737 (Android #130, commit d242498) passed: assembleDebug, unit tests and lint.
- **5.3.4 Day details · Dialog (29 Oct).** Figma: Dialog (702:618), Kind Default · Destructive. Material's alert dialog:
  one question, one line of what follows, two text actions. Corners 28, 24 in all round, the question in Headline
  Small On surface, 16, the line in Body Medium On surface variant, 24, the actions at the end 8 apart (Small Text
  buttons, On surface variant); Default is Keep editing / Discard, Destructive Cancel / Delete with Delete in Error
  (D9). It is `AppDialog` (`components/Dialog.kt`): Material's `AlertDialog` on Surface bright, its actions the Button
  atom, its tags readable by UI Automator. Every yes/no question moved onto it: deleting a habit (Day details, Habit
  details, Habits, Tasks, Completed tasks, Archived, Make room), a log, a slip, a note, a time of day, a group;
  splitting a time of day; starting a habit over; turning off App lock, no screen lock, Forgot app passcode; Write to
  us; No room for another habit; and every Discard question (`DiscardDialog`, `record/RecordScreens.kt`). Every tag
  the tests use stays; HabitFormTest taps "Discard" (was "Discard changes"). The app, the unit tests (55) and the
  instrumented tests' code build in the session.
  Fixed:
  - Each dialog set its own colours: Surface container lowest, Surface container low (`menu`) or Material's default
    Surface container high; now all Surface bright, as Figma fills it.
  - Deleting a habit from Day details or Habit details offered three buttons (Archive instead, Cancel, Delete); now
    Cancel and Delete only (D9, Figma's two text actions). The body still says archiving keeps the history, and
    Archive is in the same ⋮ menu.
  - The Discard question's action was "Discard changes" in red, with no line under the question; now Figma's Default:
    "Discard", not red (nothing saved is lost), and a line that says what goes ("The 2 glasses you typed won’t be
    added.", "The note stays as it was.", "This habit won’t be added.").
  Noted, not changed:
  - Figma's description names Surface container high (Material's DialogTokens) while its frames are filled Surface
    bright; Surface bright used, as drawn: on our grey page Surface container high is darker than the page behind it.
  - Dialogs that hold a list or a field (Put in a group, Show habits by, New time of day, New group, Move to, the time
    pickers, Plus's own dialog) aren't this component; they keep their look until their own frames (5.3.5, 5.7, 5.9).
  - "Write to us" offers OK and Copy address, neither the Default nor the Destructive pair; kept as it is.
  - **Built:** run 40801223299 (Android #131, commit 7e5f819) passed: assembleDebug, unit tests and lint.
- **5.3.5 Day details · Time picker (29 Oct).** Figma: Time picker (703:602), with Label, Hours and Minutes as text
  properties. Android's time picker in its typed mode, the one a log's Time field opens: corners 28, 24 in all round;
  "Enter time" in Label Medium On surface variant, 16; the hours and minutes fields (96 × 72, corners 8, Surface
  container highest, Display Medium On surface, the focused one outlined in Primary), ":" between them, AM / PM (52 ×
  72, corners 8, 1 dp Outline, the chosen half Primary with On primary); 24; the clock icon (to the dial), Cancel and
  OK in Text. It is `AppTimePicker` (`components/TimePickerDialog.kt`): Material 1.5's own `TimePickerDialog`, its
  `DisplayModeToggle` and `TimeInput` (the dial, `TimePicker`, a tap away), on Surface bright. A log's Time
  (`DateTimeRows`, `record/RecordParts.kt`) and every minute of the day the forms ask for (`MinuteDialog`,
  `newhabit/FormParts.kt`: a task's time, a reminder, a time of day's start) open it. Tags `picker-ok` / `time-ok`
  stay; HabitFormTest waits for "Enter time" (was "Select time"). The app, the unit tests (55) and the instrumented
  tests' code build in the session.
  Fixed:
  - Both opened the dial (`TimePicker`) in a plain alert dialog, titled "Select time" in Label Large, with no way to
    type; now the typed mode first, as Figma, with the clock icon to switch, in Material's own time picker dialog.
  - The AM / PM chosen half was Material's Tertiary container; now Primary with On primary, as Figma (our scheme has no
    hue for Tertiary). The typed fields are Surface container highest whether focused or not, On surface.
  Noted, not changed:
  - Figma sets the ":" in Display Medium so it fits the 72 dp field (Material's token is Display Large); Material's
    `TimeInput` draws its own separator, kept as Material draws it.
  - The dial isn't drawn in Figma; it keeps Material's colours, with the dialog's container and Figma's AM / PM.
  - The description names Surface container high (Material's token); the frame is filled Surface bright, as the Dialog
    (5.3.4); Surface bright used.
  - **Built:** run 40802035903 (Android #132, commit f379e17) passed: assembleDebug, unit tests and lint.
- **5.3.6 Day details · Date picker (29 Oct).** Figma: Date picker (705:1025), Limit Any day · Today and earlier ·
  Tomorrow and later · Today and later. Android's date picker in its calendar mode: corners 28; the header 24 in, 16
  above ("Select date" in Label Large On surface variant, 16, "Wed, 21 Oct" in Headline Large On surface, ✏ to type);
  a divider in Outline variant; the month ▾ and ‹ › in On surface variant; weekdays and days in Body Large On surface,
  40 dp circles, six rows always, the chosen day Primary with On primary; days outside the limit in Outline, not
  tappable; Cancel and OK in Text. It is `AppDatePicker` (`components/DatePickerDialog.kt`): Material 1.5's own
  `DatePickerDialog` and `DatePicker` on Surface bright, the limit given as `allowed`. A log's and a note's Date, the
  forms' days (`DayDialog`: Starts, Started, a task's date), Another day (moving a task, "Move") and Today's Go to a
  day ("Go") open it. `dayToUtcMs` / `utcMsToDay` moved with it from `record/RecordParts.kt`. Tags `picker-ok`,
  `date-ok`, `calendar-go` stay. The app, the unit tests (55) and the instrumented tests' code build in the session.
  Fixed:
  - Six date pickers each built Material's dialog with its colours: Surface container high, the headline and divider
    in Material's roles, days it can't take in On surface at 38 %; now one component on Surface bright with the
    headline On surface and those days in Outline, as Figma.
  - A log's and a note's Date, Another day and Go to a day showed Material's own headline (its date format); now
    every one shows the day as "Wed, 21 Oct" in Headline Large under its title in Label Large, as the forms' did.
  Noted, not changed:
  - Figma's dialog is 328 wide; Material's date picker dialog is 360 (its own fixed width, with 48 dp touch room per
    day), so on a 360 dp phone it meets the screen's edges. Narrowing it would squeeze Material's day cells; kept until
    it can be checked on a phone.
  - Material rings today's date in Primary; Figma draws no ring (Tomorrow and later shows today in plain Outline);
    Material's ring kept.
  - "Add to which day?" (Habit details' History) has its own title and wording (Figma 2.11); it moves with its page
    (5.6).
  - The description names Surface container high; the frames are filled Surface bright, as the Dialog (5.3.4);
    Surface bright used.
  - **Built:** run 40802892671 (Android #133, commit 382c8a4) passed: assembleDebug, unit tests and lint.
- **5.3.7 Day details · Timer screen (29 Oct).** Figma: Timer screen (705:7745), State Running · Paused, with Habit,
  Elapsed, Goal, Day and Status as properties. The timer, full screen: the Top app bar (64) with ⌄ (expand_more: it
  minimises, the timer keeps running) and "Timer"; the content 16 at the sides, the hero card filling it (Surface
  container lowest, corners 32, 32 by 24 in, 32 between its parts: the cookie 144 in the habit's colour, 28, the name
  in Headline Large Emphasized and the day chip 12 under it; "6:42" in Display Large with "of 10 min" in Body Large, 8
  apart; the wavy bar, and the status 12 under it: an 18 dp icon, 4, Label Large On surface variant); the bottom bar,
  12 above and below, 16 at the sides, 8 apart: Log time (Large square Tonal) and Pause or Resume (the Wide Large
  icon button, Filled). It is `TimerScreen` (`player/TimerScreen.kt`) with the routine player's `HeroCard`
  (`player/RoutinePlayer.kt`). Every tag stays. The app, the unit tests (55) and the instrumented tests' code build in
  the session.
  Fixed:
  - The top was a hand-made row with keyboard_arrow_down and no title; now the Top app bar atom with expand_more and
    "Timer".
  - The tonal button said "Log manually"; now Figma's "Log time".
  - The buttons had 16 above and below; now the bottom bar's 12.
  - The hero card had 24 above and below its stack, 20 under the day chip and 16 over the wave; now 32 each, as
    Figma's Timer screen and Routine player both draw it (the routine player's card is the same one).
  - The status line ("Goal met", "Paused") sat over the wave, 6 from its icon, in Body Medium; now 12 under the wave,
    4 from its icon, in Label Large, as Figma's Progress and status. A checklist's card keeps its own order and
    spacing until 5.4.1.
  Noted, not changed:
  - Figma's timer draws its own day chip (34 high, corners 8, Surface container, calendar_today · Today · ›); the app
    uses the Assist chip atom (1.16), as the routine player's Figma does.
  - Figma's routine player puts 24 between the cookie and the name and 8 under the name; the timer's 28 and 12 are
    kept here; 5.4.1 decides the player's.
  - **Built:** run 40803611711 (Android #134, commit 184301f) passed: assembleDebug, unit tests and lint.
- **5.3.8 Day details · Note screen (29 Oct).** Figma: Note screen (765:1087), Mode Entry · empty · Entry · typed ·
  View, with Habit and Note as properties. Add note, Edit note and Note, built like the Log screen: the Top app bar (✕
  and "Add note" / "Edit note"; ← and "Note"); the content 16 at the sides, nothing above, 8 apart: the habit and the
  day (4 above and below, 8 apart: the icon in a 24 dp circle, the name in Title Medium On surface, then a new note's
  date as an Assist chip, "21 Oct 2026", or the date in Body Medium On surface variant); the field (Surface container
  lowest, corners 24, 16 in, Body Large, "Write a note" in On surface variant) or, in View, the note's card; the bottom
  bar: Save (Medium Filled, off until something is typed) or Delete note | Edit. It is `NoteScreen`
  (`record/NoteScreens.kt`). Tags stay; HabitDetailsTest's note test now checks the date (`note-day`) and the habit's
  name (was the day as a title and "Water · " with how the day went). The app, the unit tests (55) and the
  instrumented tests' code build in the session.
  Fixed:
  - A habit's note, read, had its own header: the day as a title in Headline Small ("Wednesday, 21 October"), then a
    20 dp icon and "Water · Goal met · 8 of 8 glasses" (a frame, 1373:2, that is no longer in Figma); now the same
    habit-and-day row as Entry, the date in Body Medium, as the component's View. `noteDayLine`, used only there, is
    gone.
  - The habit-and-day row was 16 in at the sides with a 40 dp floor; now flush with the content, 4 above and below.
  - The date read "Today, 21 Oct" (DayWords' day words); now "21 Oct 2026", as Figma's chip and View.
  - The field and the note's card had 20 corners; now 24. The content had 8 above it; now none.
  Noted, not changed:
  - Figma's Edit note is Entry · typed with its title changed, so its date is a chip; editing a saved note keeps its
    date as text, because a note can't be moved to another day (the chip would open a picker that does nothing).
  - "21 Oct already has a note; you're changing it." (a new note on a day that has one) isn't in Figma; kept, so the
    note being changed is never a surprise.
  - The day's own note (no habit) shows calendar_today in the icon's place and "This day" for the name; Figma draws
    only a habit's note.
  - **Built:** run 40804357386 (Android #135, commit 5af489b) passed: assembleDebug, unit tests and lint.
- **5.4.1 Routine player · Routine player (29 Oct).** Figma: Routine player (906:89513), Screen Habit · Checklist ·
  Checklist · many steps · End · Habit · 200% text, with the milestone ribbon, snackbar, description, status and End's
  sections as properties. One habit at a time, ‹ › between them: the top bar (✕, "Morning ▾" in Title Large Emphasized
  with ▾ in On surface variant, ⋮); the routine's Flat progress with "1 of 3" (Label Medium On surface variant), 4
  above, 12 below, 16 at the sides; the hero card (Surface container lowest, corners 32, 32 by 24 in, 32 between its
  parts: the cookie 144, 24, the name in Headline Large Emphasized, the description in Body Large On surface variant and
  the day chip 8 apart; the count or "Not done" in Display Large; the wave, the status 12 under it); the bottom bar (12 /
  16): ‹ (Narrow tonal), the main action (Large square Filled), › (Narrow tonal). A checklist: a card holding the
  header (the cookie 72, 12, the name in Headline Medium Emphasized, the description and chip 6 apart, 16, the wave with
  "1 of 4 steps" in Label Large 12 after it), the steps 12 under it as their own group, scrolling when there are many;
  ‹ › only, Wide. The end: the card (the cookie 112 in Inverse surface, done_all, 16, the title in Headline Medium
  Emphasized and its line in Body Large, 8 apart), then, 24 apart, Done, Left for later (each row opens that habit
  again) and Reached in this routine, each a Label Large Primary title over two-line List items on Surface bright;
  Done, Large square Filled, the full width. At 200 % text the habit card's cookie is 96, 24 by 16 in, 16 and 20 apart.
  It is `RoutinePlayer` (`player/RoutinePlayer.kt`): `PlayerTopBar`, `RoutineProgress`, `HeroCard`, `HabitButtons`,
  `EndPage`, `EndButtons`. PlayerTest: "Not done" (was "Not done yet") and "Left for later" (was the Return to
  unfinished button). The app, the unit tests (55) and the instrumented tests' code build in the session.
  Fixed:
  - The routine's progress row was 24 in at the sides, 12 above and 16 below; now 16, 4 and 12. ▾ was On surface; now
    On surface variant, against the title with no gap.
  - The hero card: 24 between the cookie and the name (was 28) and 8 between the name, the description and the chip
    (was 4 to 12); the description in Body Large across the card (was Body Medium, 264 wide). A single check or task
    says "Not done" or "Done" in Display Large On surface (was "Not done yet" in Headline Medium, grey). The Timer
    screen keeps its own 28 and 12 (5.3.7).
  - A checklist had its steps inside the card, a 96 cookie and a large "1 of 4" count, and from four steps a compact
    left-aligned header with the steps scrolling inside the card; now one layout for any number of steps, as Figma:
    the header card, "1 of 4 steps" beside the wave, the steps under the card.
  - The buttons had 16 above and 24 below; now the bottom bar's 12 and 12.
  - The end: the cookie was 120 in On surface, the title Headline Medium, 28 and 16 apart, the milestones in a grey box
    inside the card, with Review routine under them and Return to unfinished (Medium tonal) over Done; now Figma's
    card, the Done / Left for later / Reached sections, and Done alone. A Left for later row opens that habit (the
    title ▾ still opens Your routine).
  Noted, not changed:
  - "1 skipped for today. Skipped days don't count against you." under the end's line isn't in Figma; kept (U3:
    skipped days are neutral, and the list shows them as "Skipped").
  - Figma's many-steps checklist draws a scrollbar that fades; Compose has none of its own, so the steps keep the fade
    at their foot when there's more.
  - Figma's day chip and snackbar are the Assist chip and Snackbar atoms the player already used; unchanged.
  - **Built:** run 40805471229 (Android #136, commit 9743823) passed: assembleDebug, unit tests and lint.
- **5.4.2 Routine player · Your routine sheet (29 Oct).** Figma: Your routine sheet (907:29174), Mode Your routine ·
  Change order. From the routine's name in the player: Material's sheet on Surface container with its drag handle; the
  header (24 in, 12 at the end, 12 under it): "Your routine" or "Change order" in Title Large Emphasized On surface,
  Edit or Done (Text); the habits, 16 at the sides, two-line List items (72) 2 apart on Surface bright: the habit's
  icon, its name, "Here now" / "Done" / "Not done", and ▶ (the one on screen) or ✓ (done) in On surface, or, changing
  the order, drag_indicator; the footer 12 under them, 24 in, Body Small On surface variant; 24 under it all. It is
  `RoutineSheet` (`player/RoutinePlayer.kt`); its words are `PlayerWords.queueStatus`, `QUEUE_FOOTER` and
  `QUEUE_FOOTER_EDIT`. Tags stay; PlayerTest and PlayerWordsTest follow the new words. The app, the unit tests (55)
  and the instrumented tests' code build in the session.
  Fixed:
  - The rows were hand-made, 64 high, 20 dp outer corners, on Surface container lowest; now the List item atom, 72
    high, 24 / 4 corners, on Surface bright. ✓, ▶ and the drag handle were On surface variant or ink; now On surface.
  - The sheet was Material's Surface container low; now Surface container, as Figma's sheet here.
  - Changing the order kept the title "Your routine"; now "Change order".
  - The words: the habit on screen said nothing of its own ("Not finished" or "Done"); now "Here now"; "Not finished"
    is now "Not done". The footers now read "Tap a habit to go to it. Moving never marks anything done." and "Drag to
    change the order for this run. Today's order stays as it is." (were "Jump to any habit, or change the order …"
    and "Drag to change the order for this routine. Today keeps its own order.").
  - The header was 56 high with the list 8 under it, the footer 32 in; now 40 with 12 under it, and 24.
  Noted, not changed:
  - A limit's rows keep "Limit check-in" / "Checked in" and a skipped one "Skipped for today" with ⏩; Figma draws
    only done, here and not done.
  - **Built:** run 40806096329 (Android #137, commit c658edb) passed: assembleDebug, unit tests and lint.
- **5.5.1 Habits & Tasks · Habits page (29 Oct).** Figma: Habits page (986:150825), Screen Week · Scrolled · Habit added
  · End of the list · Another week · Month · Year · No habits yet · All archived · Large text · Scrolled to Water (A54,
  A55, A57). Habits & Tasks, one page from the menu on Surface container: the Top app bar (☰ · Habits & Tasks · search ·
  +, the + acting on the tab you're on) and Primary tabs Habits · Tasks, which stay. Habits is the Progress page (A54):
  Week · Month · Year (the Connected button group, 16 in, 16 above, 8 below, scrolling away); the period row (56: the
  dates in Title Medium On surface over "This week" in Body Small On surface variant, 16 in; chevron_left and
  chevron_right at the end, off on the first and latest), pinned under the tabs once the buttons have gone; the cards by
  Today's times of day, then Quitting and Paused, each title in Label Large Primary, the Habit history cards (4.15) 12
  apart and 16 from the edges, the header's ⋮ (Edit habit, Pause… or Resume, Archive, Delete); then the Archived row and
  What the squares mean, 80 under them. Scrolled, the top bar, the tabs and the pinned row turn Surface container high.
  On an earlier period "Back to this week" (month, year) floats 16 above the gesture bar, the same button as Today's.
  No habits: the empty page (the checklist cookie, "No habits yet", "Habits you add show here, with how each one is
  going.", New habit), and with every habit archived "No habits right now" with the Archived row under it. A card opens
  Habit details; a square in Week or Month opens that day's Day details; Year's squares are too small, so the card
  opens. A habit just added scrolls into view. It is `HabitsPage` (`habit/HabitsPage.kt`, routed from the menu's
  Habits & Tasks in `AppRoot.kt`); the snapshot is Progress's own (`rememberProgressSnapshot`, `progress/Progress.kt`,
  now shared), the button that brings you back is Today's (`BackToButton`, `today/TodayScreen.kt`, now shared), and
  the Tasks tab is `TasksPage` (5.5.4) under the page's bar. The app, the unit tests (55), lint and the instrumented
  tests' code build in the session.
  Fixed:
  - The menu's Habits & Tasks opened a "Habits" list of rows (icon, name, a line, ⋮) with a top ⋮ (Select, Show by…,
    Arrange…, New or Edit groups, Archived habits, Tasks, Progress); Tasks and Progress were separate pages behind it.
    Now Figma's one page: the tabs, and the Habits tab is the Progress page's cards by time of day (A54).
  - Selecting several (a long press, Select, its bar with Pause, Resume, Archive, Group, Delete) and its first-visit
    coach mark are gone (A55, A48); Show by group and New group are gone (A64); the card's ⋮ has no Duplicate (A54).
  - The empty page had "Start from an idea" (Tonal) under New habit and its own words; now Figma's one Filled New habit
    and its words, on the Empty state (5.1.2).
  - The Archived row's icon sat in a 40 dp avatar on the List item's own colour; now inventory_2 bare, on Surface
    container lowest, as Figma (the Tasks tab's row too).
  - What the squares mean had no icon and its arrow was On surface; now help first and the arrow On surface variant
    (Habit details' Progress uses the same card).
  - The Tasks page lost its own top bar (☰ · Tasks · search · + · ⋮) and lives under the page's; its search opens from
    the page's search, and Completed tasks (in its ⋮) is a row at the end of One-time, over Archived (README, 23 Oct).
  - Material Symbols' chevron_left joined the icons (chevron_right mirrored).
  - Tests: HabitsPageTest covers the card's ⋮ (Archive, Delete, Pause, Resume), Week · Month · Year with Back to this
    week, search, the Archived row and Restore, the free plan's +; its Duplicate, selection, Show by, top ⋮ and coach
    mark tests are gone with what they tested. ScreensTest archives from a card's ⋮ (was a selection). TasksPageTest
    opens the Tasks tab, searches and adds from the page's bar and opens Completed from its row. TodayTest's "an idea
    opens the form" is gone: nothing opens Start from an idea now.
  Noted, not changed:
  - Start from an idea (`IdeasScreen`) now has no way in: Figma's empty page has one button and nothing else offered
    it. The screen and its route are kept. The user's call.
  - The old Progress page (`ProgressScreen`) was opened only from the old Habits ⋮; it now has no way in, its route
    kept. The Habits tab is that page now (A54); the user's call whether it goes. (SpeedTest still opens it through a
    menu row that hasn't existed since the six-row menu.)
  - Figma's search for the whole page (A59, Habits then Tasks) is 5.5.3; until then the search finds habits on Habits
    and tasks on Tasks, as before. "Scrolled to Water" (a result scrolling to its card) comes with it.
  - The Tasks tab keeps its own look (its coach mark, selecting several, its colours) until 5.5.4.
  - What the squares mean opens unfolded until it has been folded once anywhere (the app's rule since 6 Oct); Figma
    draws it folded at the end of the list.
  - The Archived habits' cards and their "count for the days before" note (the old Progress page) aren't here: Figma
    has only the Archived row.
  - **Built:** run 40808120294 (Android #138, commit 91f8f75) passed: assembleDebug, unit tests and lint.
- **5.5.2 Habits & Tasks · Archived habits page (29 Oct).** Figma: Archived habits page (988:7736), Screen Archived ·
  Menu open · Restored · Nothing archived. From Habits › Archived: the Top app bar (← and "Archived habits") on Surface
  container; the content 16 at the sides, 8 above, 40 under; the intro ("Archived habits keep everything they had.
  They're off Today and send no reminders.") in Body Large On surface variant, 16 in; 24 under it one rounded list,
  newest first, of two-line List items 2 apart on Surface bright (the habit's icon, its name, "Archived 12 Oct", ⋮
  with Restore and Delete, Delete in Error). A row opens its Habit details, read-only. Restore says so with Undo;
  Delete asks first and waits for its Undo (D6). Nothing archived: the empty page, centred, no button. It is
  `ArchivedHabitsScreen` (`habit/ArchivedHabits.kt`; Archived tasks, 5.5.5, is the same screen for tasks). HabitsPageTest
  also takes Restore back with Undo. The app, the unit tests (55) and the instrumented tests' code build in the
  session.
  Fixed:
  - The rows were the Habits page's old rows on the List item's own colour; now Surface bright, the name one line.
  - A long press selected several, with a bar of Restore and Delete; gone (A55, on every list).
  - The ⋮ had a divider and "Delete habit…"; now Restore and Delete, as Figma's Menu.
  - Restore's snackbar offered View (back to Habits); now Undo, which archives it again, as Figma's Restored.
  - The intro was Body Medium ("… keep all their history and send no reminders."); now Figma's words in Body Large,
    16 in, 24 over the list. The bottom room was 96; now 40 above the gesture bar.
  - Nothing archived was its own centred column ("Nothing archived", Title Large); now the Empty state (5.1.2) with
    "No archived habits" and "When you archive a habit, it waits here with its history."
  Noted, not changed:
  - Figma's rows read "Archived 12 Oct · 48 days"; what the 48 days count isn't said (not how long ago: the dates and
    numbers don't run that way), so the line stays "Archived 12 Oct" (or "Started over as …"). The user's call.
  - On the free plan the intro adds "They don't count toward your five free habits."; Figma draws Plus's page.
  - Archived tasks keeps its own words until 5.5.5; it lost selecting several with this page.
  - **Built:** run 40808878515 (Android #139, commit c04924f) passed: assembleDebug, unit tests and lint.
- **5.5.3 Habits & Tasks · Search page (29 Oct).** Figma: Search page (991:8050), Screen Start · Results · Results ·
  keyboard down · No match · Tasks only · Tasks only · keyboard down (A59, A72). One search for the whole page, from
  either tab: the Search view header (1.9, "Search habits and tasks") and its divider; nothing until a letter is typed;
  then 16 in, the habits that match, then the tasks, each group only when something in it matches: its subheader ("4
  habits", "2 tasks") in Label Large Primary, 16 in, 8 over one rounded list of two-line List items 2 apart on Surface
  bright (the icon in its colour, the name, a line), the tasks 16 under the habits. A habit's line is its time of day
  and plan ("Afternoon · 30 min a day") or "Archived 12 Oct"; a task's its day ("Today · planned for Wed, 21 Oct",
  "Tue, 17 Nov · 10:30 AM"), its rhythm and next day, "Completed Wed, 21 Oct" or "Archived …". Nothing matching:
  "Nothing matches “yoga”" in Title Medium and one Tonal button, Add “yoga”, opening What do you want to do? with the
  name filled in. A habit going on goes back to its card on Habits (Figma's Scrolled to Water, 5.5.1); an archived
  one, and a task, open their details. It is `PageSearch` (`habit/HabitsPage.kt`), opened from the page's search; Add
  goes to New with `from=search` (`AppRoot.kt`), back to the page once made. The app, the unit tests (55), lint and the
  instrumented tests' code build in the session.
  Fixed:
  - Search was per tab: "Search habits" found habits (and archived ones) as the old rows with ⋮; the Tasks tab had its
    own search, open tasks then Completed then Archived, as task rows with ⋮. Now one search, Figma's groups and rows,
    no ⋮ (a result opens or shows its habit).
  - No match said "No habits called “yoga”" (or "No tasks …") with a line of advice and New habit “yoga” (New task
    “yoga”); now Figma's one line and Add “yoga”, which asks what it is (A72), never guessing habit or task.
  - A task carried from an earlier day read "Today · planned 21 Oct"; now "Today · planned for Wed, 21 Oct". A done
    one read "Done Wed, 21 Oct"; now "Completed Wed, 21 Oct".
  - The search's groups were Body Medium titles ("Habits", "Archived", "Completed"); now counted subheaders in Label
    Large Primary, archived and completed ones saying so in their own line.
  - The old Habits row (`HabitsRow`) and the Tasks page's search (`TaskSearch`) are gone, nothing else used them.
  - Tests: HabitsPageTest and TasksPageTest search through the one search and add through Add “word” (the task one
    then picks Add a task).
  Noted, not changed:
  - A habit's line is "<time of day> · " and the Habits page's line (its plan, or "Back on 3 Nov" when paused, "Starts
    …", "Ends …"), so a paused one reads "Paused · Back on 3 Nov"; Figma draws only habits going on.
  - **Built:** run 40827006219 (Android #140, commit 68be94b) passed: assembleDebug, unit tests and lint.
- **5.5.4 Habits & Tasks · Tasks page (29 Oct).** Figma: Tasks page (999:1061), Screen One-time · One-time · end of the
  list · Repeating · Repeating · end of the list · Menu open · Moved to Today · No tasks yet · No repeating tasks · Moved
  to another day · Next day · Task added · Large text (A55, A57, A58). Habits & Tasks' Tasks tab, under the page's bar,
  tabs and search: the list 16 in, 16 above, 80 under, 12 between its parts; One-time · Repeating (the Connected
  button group, scrolling away); each section's title in Label Large Primary 16 in (No date's note in Body Small On
  surface variant, 2 under) over one rounded list of two-line List items 2 apart on Surface container lowest (the icon
  in its colour, the name in Title Medium, On surface variant once done, the line in Body Medium On surface variant,
  ⋮); at the end of both kinds Completed ("6 tasks done") and Archived. The ⋮: Edit task; Move to another day… (the
  date picker at once, A58), Skip this time (repeating), Do today and Pick a day… (No date) or Mark as not done (done
  today); Duplicate; Archive; Delete. Nothing to show: the Empty state with New task, the button group kept over it.
  It is `TasksPage` (`habit/TasksPage.kt`); a repeating task's line is `repeatingLine` (`data/TaskWords.kt`, also the
  search's). TasksPageTest follows. The app, the unit tests (55), lint and the instrumented tests' code build in the
  session.
  Fixed:
  - Selecting several (a long press, its top bar with Select all, its bar of Move, Archive, Delete) and the first-visit
    coach mark are gone (A55, A48); a still hold does nothing.
  - Move to another day… opened a submenu (Tomorrow, Pick a day…, No date); now the date picker at once (A58). A
    repeating task's ⋮ had Move and Skip; now Skip this time in its place (README, 23 Oct). The ⋮ had a divider and
    "Delete task…"; now Figma's six rows, "Delete".
  - Do today said "… moved to Today" with Undo; now "… is on Today" with Show, which opens Today (Figma's Moved to
    Today).
  - The rows were on Surface with a done task struck through in grey; now Surface container lowest, a done one's name
    On surface variant and not struck, as Figma. (Completed tasks' rows, the same row, follow until 5.5.6.)
  - A repeating task had up to three lines (how often with its time, its day, when it was last done or skipped); now
    Figma's one ("Every 3 days · Next 25 Oct", "8:00 AM · Next today" under Every day, "Done today").
  - A task with No date had no line; now "No date".
  - Section titles were Body Medium On surface variant (No date's note Body Medium, 12 under); now Label Large Primary
    with the note in Body Small 2 under, 20 above and 12 below each, as Figma.
  - Completed was a row without a count at the end of One-time only, with check_circle; now task_alt and its count, at
    the end of both kinds, shown once something is done.
  - The empty pages were their own column (Title Large, the repeat icon, no button on Repeating); now the Empty state
    with task_alt, Figma's words, and New task on both.
  - Tests: TasksPageTest's move test checks the picker opens at once (A58) and the "is on Today" snackbar; the long
    press test checks a still hold does nothing; the coach mark and selection tests are gone with what they tested.
  Noted, not changed:
  - A hold that moves still drags a task within its day (the person's own order, U13); A55 says a long press does
    nothing, which a still hold now honours. The user's call whether dragging stays.
  - Moving to any other day says "Moved to Fri, 30 Oct" with Undo; Figma's Moved to another day draws no snackbar.
  - Figma writes the next day as "Next 25 Oct" in one row and "Next Tue 27 Oct" in another; the app writes every one
    the same way (`taskDay`).
  - Repeating rows lose "Last done …" and "Skipped …" (on the task's details still).
  - **Built:** run 40828236097 (Android #141, commit 7be2bcd) passed: assembleDebug, unit tests and lint.

- **5.5.5 Habits & Tasks · Archived tasks page (29 Oct).** Figma: Archived tasks page (1001:178), Screen Archived · Menu
  open · Restored · Nothing archived. From Tasks › Archived: the same page as Archived habits (5.5.2) for tasks: the
  Top app bar (← and "Archived tasks"), the intro in Body Large On surface variant, one rounded list newest first (the
  task's icon in its colour, its name, "Archived 10 Oct", ⋮ with Restore and Delete); a row opens its Task details,
  read-only; Restore says so with Undo; nothing archived: the Empty state, no button. It is `ArchivedHabitsScreen(tasks =
  true)` (`habit/ArchivedHabits.kt`). The app, the unit tests (55), lint and the instrumented tests' code build in the
  session.
  Fixed:
  - The intro said "Archived tasks keep their history and stay off Today and Tasks. Restore one to bring it back."; now
    Figma's "Archived tasks keep their history. They're off Today and the Tasks list."
  - Restore said "… is back in Today" or "… is back in Tasks"; now "… restored" with Undo, as Figma's Restored.
  - Nothing archived said "Tasks you archive keep their history here, and you can restore them any time."; now "When
    you archive a task, it waits here with its history."
  - Tests: TasksPageTest's archived test reads the new intro and snackbar.
  Noted, not changed:
  - The snackbar no longer says where a restored task went (Today or under its day on Tasks); Figma says "restored"
    only.
  - **Built:** run 40829236155 (Android #142, commit 9d8320e) passed: assembleDebug, unit tests and lint.

- **5.5.6 Habits & Tasks · Completed tasks page (29 Oct).** Figma: Completed tasks page (1002:230), Screen Completed ·
  Menu open · Open again · Nothing completed · Deleted, and the habits & tasks flows "Completed tasks: by the day they
  were done" and "The top bar's ⋮: Delete all completed". From Tasks › Completed: the Top app bar (←, "Completed tasks",
  ⋮ with Delete all completed) on Surface container; content 16 at the sides, 8 above, 40 under, 24 between days; each
  day's subheader ("Today", "Thu, 22 Oct") in Label Large Primary, 16 in, 8 over one rounded list of two-line List items
  2 apart on Surface bright (icon in its colour, the name, "Done 9:12 AM", "· planned for Wed" or a repeating task's
  "· every day", ⋮ with Mark as not done and Delete); Mark as not done says "… is open again" with Undo; Delete all
  completed asks "Delete 14 completed tasks?" ("They go for good, with their notes. Tasks still to do and repeating
  tasks stay.", Cancel | Delete) and says "14 completed tasks deleted" with Undo; nothing completed: the Empty state
  (task_alt), no ⋮. It is `CompletedTasksScreen` (`habit/CompletedTasks.kt`), on the List item (2.4), Menu (2.5),
  Dialog (5.3.4) and Empty state atoms. The app, the unit tests (55), lint and the instrumented tests' code build in
  the session.
  Fixed:
  - The title was "Completed"; now "Completed tasks".
  - Search (its own header) and selecting several (a long press, Select all, a bottom bar with Delete) are gone (A55,
    A77); the page's one action is ⋮ › Delete all completed, as Figma.
  - The intro line ("Every task you finish, by the day you did it …") is gone: Figma has none.
  - Day headings said "Yesterday" and "Thursday, 22 Oct" in Body Medium grey; now "Today" or "Thu, 22 Oct" in Label
    Large Primary, 8 above the list and 24 between days.
  - Rows were the Tasks page's task row (Surface container lowest, done names grey); now the List item on Surface
    bright with the name in On surface, as Figma draws them.
  - The line said "Done 6:40 PM · for 21 Oct"; now "· planned for Wed" (the weekday within a week, "d MMM" beyond), and
    a repeating task's rhythm ("· every day").
  - A row's ⋮ had Mark as not done only; now Mark as not done and Delete (red), Delete asking first (D9).
  - Mark as not done said "… is back in Today" / "… back under No date"; now "… is open again", as Figma's Open again.
  - The empty page was its own column with "Tasks you finish are kept here, by the day you did them."; now the Empty
    state with Figma's "Tasks you tick off on Today come here when the day ends."
  - `TaskRow` lost its selecting state (Completed was its last user); `SectionTitle` and `BarAction` (Habits page) had
    no users left and are deleted.
  - Tests: TasksPageTest's completed test reads the new title and snackbar; a new test checks Delete all completed asks
    first and keeps everything while Undo shows.
  Noted, not changed:
  - ~~Held for the user: a repeating task's row has no Delete.~~ Settled the same day (A80): it has Delete, which
    deletes the whole task, the question saying its progress goes too; added to Figma as Menu open · repeating and
    Delete a repeating task.
  - Figma doesn't say how far back "planned for Wed" names a weekday; within a week it does, beyond that "d MMM".
  - A day in another year adds its year ("Thu, 22 Oct 2025"); Figma draws only this year.
  - Figma's description of this component is a copy of Archived habits' (it describes the archived page); its Code
    line is added after it, as the build prompt says to change nothing else.
  - **Built:** run 40861173881 (Android #148, commit 9d97623) passed: assembleDebug, unit tests and lint.

- **5.6.1 Details pages · Habit details page (29 Oct).** Figma: Habit details page (1020:4052), its 22 screens (Progress,
  Scrolled, With description, Description open, Loading, New habit, History and its states, At the key, Key open, At
  Month, At Year in Pixels, Progress · full length and its free plan) and the details pages' flows. On Surface container:
  the Top app bar (←, ⋮; the name moves into it on scroll, Surface container high), the large title (the icon 56 in the
  habit's colour, the name in Headline Medium Emphasized, "8 glasses a day | Anytime" in Body Medium On surface variant,
  16 at the sides and under), a description in Body Medium On surface variant cut at two lines with a Text button More /
  Less lined up with the words, then Primary tabs Progress | History, pinned. Progress: a Card notice when archived or
  paused, then the Overall record, Milestones, What the squares mean (folded), Week, Month and Year in Pixels (the
  molecules 4.13–4.17); a habit with nothing logged shows the Empty state "No progress yet", its first Week ("Your first
  week", "Started today, Fri 23 Oct") and the key. History: Search notes, All · With notes · Go to date, a rounded list
  per month on Surface container lowest (the month's List item header folds it; each day a List item with its Small Day
  cell, "Today · 4/8 glasses · 4 logs", its note and ›), and Add. It is `HabitDetailsScreen` (`habit/HabitDetails.kt`)
  with `progressItems` / `freshItems` (`ProgressTab.kt`) and `historyItems` (`HistoryTab.kt`). The app, the unit tests
  (55), lint and the instrumented tests' code build in the session.
  Fixed:
  - The name was Headline Medium; now Headline Medium Emphasized. The line under it said "8 glasses a day, anytime ·
    Paused"; now "8 glasses a day | Anytime" (the times of day by name), with paused or archived said by the card only
    (`pageGoalLine`). The header lost its 4 above.
  - The description was Body Large in On surface, and More was its own label with an arrow; now Body Medium On surface
    variant and Material's Text button (More / Less, no icon), its label lined up with the words.
  - The paused and archived cards were the page's own; now the Card notice (4.7), with Figma's words ("Archived today",
    "Everything it recorded is kept. Restore it to log again."; "Paused until Fri 30 Oct", "Off Today, no reminders.
    Paused days don't count."). The page's own StateCard is deleted.
  - Archive left the page; now the page stays, archived, and says "Water archived" with Undo (Figma: Archive never asks).
  - Delete deleted at once; now the page closes and Habits & Tasks says "Water deleted" with Undo, deleting only once
    Undo has gone (D6; the habit's card hidden meanwhile, `PendingDelete`). The question's words are Figma's ("Its logs,
    notes, streaks and milestones go too. To keep them, archive it instead: Archive is in the same menu.").
  - ⋮ had a line before Delete; now before Archive, as Figma's (and the Habits page's) menu.
  - What the squares mean opened unfolded until it had been folded once; now it starts folded and opens for the visit
    (Figma: "it stays folded everywhere").
  - A habit with nothing logged showed every card at zero; now Figma's New habit: No progress yet, its first week, the
    key.
  - History's month headers were drawn by hand (20 in, the chevron in ink); now the List item (Title Medium, Body Medium,
    expand_less / expand_more On surface variant). Each day showed the Year Day cell (24) and "Today" beside the date;
    now the Small cell (28) in the 40 leading slot and "Today · 4/8 glasses · 4 logs" in its line, on Surface container
    lowest.
  - With notes now ends with "Days without a note are hidden while With notes is on."; Nothing here yet is the Empty
    state (history in its cookie).
  - Go to date's day is lit in the habit's Fill for a moment and fades back (Material's slow effects spring).
  - Tests: HabitDetailsTest reads the new header line, the cards' words and Archive's snackbar, and checks a new habit's
    No progress yet; HabitsPageTest has a test for Delete from the page coming back with Undo.
  Noted, not changed:
  - ~~Held for the user: History's Add.~~ Settled the same day (A81): Add always asks "Add to which day?", with no day
    chosen (today only ringed, "Selected date", Open off until a day is picked). `AppDatePicker` (5.3.6) now takes no
    day for that, and a button named after the day picked; Figma's flow step, notes and the Add button's layer name were
    changed to match. HabitDetailsTest picks a day before Open.
  - Deleting from a page opened from Today returns to Today, whose own snackbar isn't this one: there it deletes at
    once, as before. Figma draws only the way back to Habits & Tasks.
  - "No progress yet" shows while nothing at all is logged; Figma draws a habit made today. A habit made days ago with
    nothing logged shows the same.
  - A pause still to come keeps "Cancel pause from Fri 30 Oct" in ⋮; Figma draws only Pause… and Resume.
  - The cards after a type change (Archived …, when Water changed to minutes; Water was counted in glasses) stay, on the
    Card notice: A68 ended type changes, so they're only for habits changed before; they go with the Figma cleanup.
  - Tasks open this page too; their page is 5.6.5, so their ⋮, header and History are unchanged here.
  - **Built:** run 40863412319 (Android #149, commit 5f64411) passed: assembleDebug, unit tests and lint. Then A80
    (run #150) and A81 (run #151), both passed.

- **5.6.2 Details pages · Streaks page (29 Oct).** Figma: Streaks page (1034:74), Screen Streaks. From Progress's See
  all streaks (a quit habit's See all runs, titled Runs): on Surface container, the Top app bar (← "Streaks"); content
  16 at the sides, 8 above, 40 under, 16 apart: the habit (icon 28, 12, name in Title Medium, "Since 2 Sep 2026" in
  Body Medium On surface variant), 4 in; one card on Surface container lowest, corners 24, 20 inside, 16 between ("3
  runs" in Title Medium, then a Run row (4.5) per run, longest first, the current one "· now"); the footnote under the
  card in Body Small On surface variant. It is `StreaksPage` (`habit/StreaksPage.kt`). The app, the unit tests (55),
  lint and the instrumented tests' code build in the session.
  Fixed:
  - The habit line was 28 from the screen's edge and 4 from the top; now 20 and 8, as Figma.
  - The footnote was the card's last line; now under the card, 16 below it (Run row's note under 4.5 settled).
  - The page and card took the app's old colours (`appColors`); now Surface container and Surface container lowest.
  - The footnote's "don't" takes Figma's ’.
  - The page ends 40 above the gesture bar, as Figma (it was 16).
  Noted, not changed:
  - No runs of 3 yet: the card says "None yet" with the footnote; Figma draws only a habit with runs.
  - A quit habit's page (Runs, "Every run, longest first. A slip ends a run.") is the same page; Figma draws only Water's.
  - **Built:** run 40910167664 (Android #152, commit 7cf8821) passed: assembleDebug, unit tests and lint.

- **5.6.3 Details pages · All milestones page (29 Oct).** Figma: All milestones page (1036:235), Screen All milestones ·
  Quitting, and the details pages' flow "tap a reached one: its pop-up again". From the Milestones card's See all: on
  Surface container, the Top app bar (← "All milestones"); content 16 at the sides, 8 above, 8 apart: "Water · 4
  reached" in Body Medium On surface variant, 16 in; per track a subheader in Label Large Primary (16 in, 12 above, 4
  below) over one rounded list of two-line List items 2 apart on Surface container lowest: its next milestone first
  (the Circular progress, 40, with its number; "Next · 7 to go · now 23"), then every one reached, newest first (the
  Small Medal, 40; "Reached 13 Oct"). A reached one opens its pop-up again (4.12: "14 days in a row", "Water · 13 Oct",
  that track's next, Close | All milestones, both closing it here). It is `AllMilestonesPage` (`habit/ProgressTab.kt`).
  The app, the unit tests (55), lint and the instrumented tests' code build in the session.
  Fixed:
  - The rows were drawn by hand (a 52 ring and a 52 medal, 76 tall, on the app's old white); now List items on Surface
    container lowest with the 40 ring and the Small Medal (40), as Figma.
  - The track titles were Label Large in grey; now Label Large Primary, 20 from the list above and 12 to their own.
  - The summary line and the page's colours take the theme's roles (`appColors` gone from the page).
  - A reached milestone did nothing; now it opens its pop-up again, said as reached on its day; TalkBack can open it
    too ("Show its pop-up").
  - Tests: HabitDetailsTest's milestones test opens a reached one's pop-up and closes it.
  Noted, not changed:
  - Figma ends the page with a "How milestones work ›" row (help in its avatar); its page is 5.6.6, so the row comes with
    it. Until then the page keeps its closing note in Body Small.
  - The Quitting screen's anniversary says "27 Sep 2027 · 339 days to go" without "Next ·", where Water's says "Next ·";
    the app says "Next ·" on every next milestone, as Water's.
  - **Built:** run 40933613903 (Android #153, commit 3abd934) passed: assembleDebug, unit tests and lint.

- **5.6.4 Details pages · Notes search page (29 Oct).** Figma: Notes search page (1053:9079), Screen Start · Results · No
  match. From History's Search notes: the Search view header (1.9, "Search notes") and its divider, the keyboard up, on
  Surface container. Nothing typed: "Search Water’s notes by any word." in Body Medium On surface variant, centred, 16
  in. Results: "2 notes" in Label Large Primary (32 in, 16 above, 8 below) over one rounded list of History's day rows
  (List items 2 apart on Surface bright, the Small Day cell, the date, its line, the note with the words in Medium,
  ›); a row opens its Day details. No match: "No notes with “swim”" in Title Medium and "Search looks through this
  habit’s notes. To find a day, use Go to date." in Body Medium On surface variant, centred, 48 down, 8 apart. It is
  `HistorySearchPage` (`habit/HistoryTab.kt`). The app, the unit tests (55), lint and the instrumented tests' code build
  in the session.
  Fixed:
  - Nothing typed showed an empty page; now Figma's hint, naming the habit.
  - The count was Body Medium in grey; now the subheader in Label Large Primary, 8 over the list.
  - Matched words were Bold; now Medium, as Figma (and A74's weights).
  - The rows were History's (Surface container lowest); here they're Surface bright, as Figma's results.
  - No match said only "Search looks through this habit's notes." 64 down; now Figma's two lines, 48 down, 8 apart.
  - The page took the app's old colours; now the theme's roles.
  - Tests: HabitDetailsTest checks the hint and No match's second line.
  Noted, not changed:
  - The search counts what's typed from 0.3 s after typing stops (S11); Figma shows results "as you type".
  - **Built:** run 40934314244 (Android #154, commit bf18635) passed: assembleDebug, unit tests and lint.

- **5.6.5 Details pages · Task details page (29 Oct).** Figma: Task details page (1136:9271), Screen One-time · not done
  yet · One-time · done · Repeating · Menu open. A tap on a task's row opens it. On Surface container: the Top app bar
  (←, ⋮; the name moves into it on scroll), the large title (the icon 56 in the task's colour, the name in Headline
  Medium Emphasized, "One-time · Tue 4 Nov, Morning", "One-time · done today" or "Every 2 months · Next Wed 9 Dec" in
  Body Medium On surface variant). No tabs: a task has no Progress, only its days, 16 in, 16 apart. Not done yet: the
  Card notice (event, "Planned for Tue 4 Nov, Morning", "It shows on Today that day; tick it there.") over the Empty
  state (task_alt, "Nothing done yet", "When it’s done, the day shows here, with any note."). Done: one rounded list on
  Surface container lowest, "Done" (folds it) then its day ("Fri 23 Oct", "Done at 9:12 AM", the note, ›, the Small Day
  cell done). Repeating: a list per year ("2026", "Done 4 times"), newest first. A day opens its Day details. Add note
  (Extended FAB, edit_note). ⋮ is the Tasks row's own: Edit task, Move to another day… (Skip this time, Do today and
  Pick a day…, Mark as not done by the kind), Duplicate, Archive, Delete (red, asks first). It is `TaskDetailsScreen`
  (`habit/TaskDetailsParts.kt`), opened by `HabitDetailsScreen` for a task. The app, the unit tests (55), lint and the
  instrumented tests' code build in the session.
  Fixed:
  - A task shared the habit page, with a single History tab and its own ⋮; now a page of its own with no tabs.
  - The line read "Today · Morning", "Every 3 days, anytime" or "A task · Anytime"; now Figma's "One-time · …" and
    "Every … · Next …" (`taskDetailsLine`, `taskPlannedFor`).
  - Its History listed Waiting, Skipped, Planned and "Task created" rows with avatars (A77: not in Figma, deleted with
    `taskHistory` and `TaskEvent`); now the Planned notice and Nothing done yet, or the days it was done, by year.
  - The ⋮ had Edit task, Move…, Mark as not done, Archive and "Delete task…" (no Duplicate, no Skip this time); now the
    Tasks row's `TaskMenuItems`, with the same words, snackbars and Undo. Archive stays on the page and says so with Undo.
  - Delete went at once; now the page leaves and the page under it says "… deleted" with Undo, deleting once Undo has
    gone (D6), as a habit's; Tasks and Completed tasks keep it away meanwhile (`PendingDelete`). A repeating task's
    question says its progress goes too (A80).
  - There was no Add note; now the Extended FAB.
  - Tests: TasksPageTest opens a planned task (its line, the notice, Nothing done yet, no tabs) and a done one (Done,
    its day, Mark as not done with Undo).
  Noted, not changed:
  - Figma has no archived task; the page shows the same Archived Card notice as a habit's, with Restore, and ⋮ keeps
    Restore and Delete.
  - Add note on a one-time task writes to the day it was done, else its planned day once it has come, else today; a
    repeating task's asks "Add a note to which day?" with no day chosen, as History's Add (A81). Figma doesn't say which day.
  - **Built:** run 40935987561 (Android #155, commit c05fd05) passed: assembleDebug, unit tests and lint.

- **5.6.6 Details pages · How milestones work page (29 Oct).** Figma: How milestones work page (1142:29063), Screen How
  milestones work · Quitting and cutting down, and All milestones' last row. From "How milestones work ›" (24 under
  All milestones' last list, a one-line List item on Surface container lowest, help in its avatar, ›). On Surface
  container: the Top app bar (← "How milestones work"); content 16 at the sides, 8 above, 40 under, 8 apart: per part
  a subheader in Label Large Primary (16 in, 12 above, 4 below) over a card on Surface container lowest (corners 24,
  16 inside, 12 between lines) in Body Medium On surface. A habit to reach: In a row, In total, Anniversaries, Which
  ones get a pop-up, Quitting and cutting down. A quit habit or a limit: Quitting: days clean in a row, Quitting: clean
  days in total, Cutting down: days within the limit, Never counted, Anniversaries, Which ones get a pop-up. ← goes back
  to All milestones. It is `HowMilestonesWorkPage` (`habit/HowMilestonesWork.kt`). The app, the unit tests (55), lint
  and the instrumented tests' code build in the session.
  Fixed:
  - There was no such page; now Figma's, with both screens' words.
  - All milestones ended with a note in Body Small (A77: not in Figma, deleted); now the How milestones work row.
  - Tests: HabitDetailsTest's milestones test opens the page from All milestones, checks its parts and comes back.
  Noted, not changed:
  - The page's words are Figma's. For a habit to reach they match the shared rule (`MilestoneRule`: 3 … 365 days, 2 …
    52 weeks, 2 … 12 months in a row; 10 … 1,000 in total; pop-ups at 30, 180, 365 days). **For a quit habit they
    don't, held for the user:** the app's quit milestones (`quitMilestoneLadder`, All milestones' one "since a slip"
    track) are 1, 3, 7, 10, 14, 30, 45, 60, 90, 120, 180, 270, 365, 500, 730 days, then every year, with no clean days
    in total; the page says 3, 7, 14, 30, 60, 90, 180 and 365 clean in a row, and 10 … 1,000 clean days in total. A
    rule that changes numbers people see is the user's decision (T21).
  - **Built:** run 40936952551 (Android #156, commit 289a966) passed: assembleDebug, unit tests and lint.

- **5.7.1 Create new · What do you want to do? (29 Oct).** Figma: What do you want to do? (1061:2016). New's first page,
  from every +. On Surface container: the Top app bar with ✕ and no title; the content 16 at the sides, 24 under, 24
  apart: "What do you want to do?" in Headline Small Emphasized On surface, then one rounded list of two-line List
  items 2 apart on Surface bright (the icon in the avatar on Surface container highest, the name in Title Medium, the
  line in Body Medium On surface variant, ›): Build or maintain (trending_up), Quit or cut down (trending_down), Add a
  task (event_available). It is `NewChoices` on `ChoicePage` (`newhabit/Choices.kt`), which the other choice pages
  share. The app, the unit tests (55), lint and the instrumented tests' code build in the session.
  Fixed:
  - The question was Headline Medium Emphasized, 8 in and at most 236 wide, 8 under the bar; now Headline Small
    Emphasized across the page, straight under the bar, as Figma.
  - The page and its rows took the app's old colours; now Surface container and Surface bright.
  - `NewChoices` lost a parameter it never used.
  - Tests: ScreensTest checks the three choices' lines.
  Noted, not changed:
  - Edit still has a Type row opening "Change the type", which A68 removed; it is part of the form, so it goes with
    5.7.3.

- **5.7.2 Create new · Quit or cut down (29 Oct).** Figma: Quit or cut down (1061:2101). From Quit or cut down: the
  choice page (5.7.1) with ←, "What do you want to do?", and two List items with their example tags: Quit (block,
  "Stop completely. Track the time since you stopped.", "e.g. Smoking") and Cut down (speed, "Set a maximum and log
  how much.", "e.g. Coffee, 2 a day"), each opening its form. It is `TypeChoices` (`newhabit/Choices.kt`). The app, the
  unit tests (55), lint and the instrumented tests' code build in the session.
  Fixed:
  - Quit said "Track time since you stopped."; now Figma's "Track the time since you stopped."
  - The page and its rows take 5.7.1's Figma layout and colours.
  - Tests: HabitFormTest opens Quit or cut down and checks both choices, their examples and ←.
  - **Built:** run 40937900222 (Android #157, commit 3a6bc4c) passed: assembleDebug, unit tests and lint (5.7.1 and
    5.7.2 together).

- **5.7.3 Create new · Create new form (29 Oct).** Figma: Create new form (1065:2597), Type Check it off · Track an
  amount · Time it · Checklist · Quit · Cut down · Task once (and its Date picker) · Task on repeat · Check it off at
  200%, with the create new page's flows (A new habit: check it off, track an amount, quit; Starts and Ends; Edit
  habit). New habit, New task, Edit habit and Edit task, the type already chosen. On Surface container: the Top app
  bar (←, the title, **Add** or **Save** as a Filled Small button, quiet until there's a name, A65); then one list, 16 at
  the sides and above, 40 under, 16 between groups, 2 within, every row on Surface bright: the name (focused, the
  keyboard up) and Description (optional), then Icon | Colour (one-line halves, the icon or the colour at 40, ›); the
  type's rows (How much, How long, Steps or Limit, "Not set yet" or "None yet" until set, then How often; a quit
  habit's Started | At with "The run counts up from here. A slip starts it again."; a task's Date ("Today · Fri, 23
  Oct") and Time, "If it isn’t done, it moves to today until it is.", or How often and Time, "It comes back on the days
  you pick."); Time of day and Reminders (a limit: Reminders only); Starts and Ends (Ends a menu, ▾). In Edit a changed
  goal says "The new goal starts today. Days before keep 8 glasses a day." under its rows (Body Medium). It is
  `HabitForm` (`newhabit/HabitForm.kt`). The app, the unit tests (55), lint and the instrumented tests' code build in
  the session.
  Fixed:
  - Edit had a Type row opening "Change the type", and saving another type started the habit over (A68: a habit keeps
    its type). The row, the page (`TypePage`), `changeType`, `typeChanged`, the Start over question and Today's "Old
    Water is in Archived habits" snackbar are deleted; habits started over before A68 keep their linked pages
    (`HabitStore.startOver` stays for them and their tests).
  - The form opened with a Preview card and "Enter a habit name to see the preview." (A64): deleted.
  - Groups were on the form (a Group row and its page, with New group): deleted (A64, "Groups are gone"). Saving no
    longer changes a habit's group, so one already in a group stays in it.
  - Notes under the rows that Figma doesn't have ("It shows on Today under Quit or Cut Down…", "The counter runs from
    here…", the start date's and end date's lines, "Tasks don't have progress or stats."): deleted; the footers are
    Figma's (Body Small On surface variant, 16 in, 8 under).
  - The titles were "New Habit", "Task", "Quit" and "Cut down"; now "New habit" and "New task".
  - Add was a hand-drawn pill in ink; now the Filled Small button, disabled until there's a name.
  - A quit habit had no description; now it has one, as Figma.
  - Values said "Set" and "Add"; now "Not set yet" and "None yet". How much says what one tap adds ("8 glasses · each
    tap adds 1"). Days say "Wed, 2 Sep" (and "Today · Fri, 23 Oct" for a task), "Time of Day" is "Time of day".
  - Icon and Colour were 32 with 12 between; now 40 and 8, as Figma's one-line List item. The rows, field and halves
    take Surface bright (`OpenRow` and `FormField` gained a colour), the page Surface container.
  - Ends showed ›; now ▾, as it opens a menu.
  - Tests: HabitFormTest's two type-change tests are replaced by Edit's (no Type, Group or preview; leaving with
    changes asks) and a New habit test of Figma's rows, Add's quiet and ready states and the quit footer; How long's
    test reads "Not set yet".
  Noted, not changed:
  - **Tell me at milestones** (a quit or cut-down habit's switch, with its notes) isn't on Figma's form, but How
    milestones work says "Tell me at milestones, on the habit’s form, also sends a notification". It turns milestone
    notifications on, so it stays at the end of those forms until the user says where it goes (held).
  - **When you tap +** (Track an amount) stays on the form for now: Figma moves it to How much ("When you log it"),
    built with 5.7.9, where it goes then.
  - **Repeat** (Never | On a schedule) stays first in the task form: Figma chooses it before the form, on What kind of
    task? (5.7.14), where it goes then.
  - Figma's Edit notes say a name over 24 characters shows a snackbar; the form keeps its line under the field (U6)
    for now.
  - Groups are still on Today's filter and Progress (`FilterAndGroups.kt`, `Progress.kt`); A64 says they're gone. That is
    cleanup item 6.4, after every page is built.
  - **Built:** run 40939585087 (Android #158, commit aa82e5f) passed: assembleDebug, unit tests and lint.

- **5.7.4 Create new · Icon picker (29 Oct).** Figma: Icon picker (1074:932), and the flow "A new habit: its icon and
  colour". From the form's Icon. On Surface container: the Top app bar (✕ "Icon", Done as a Filled Small button); the
  content 16 at the sides and above, 16 apart: the Search bar ("Search icons", Surface container highest), then the
  icons by kind, each kind's label in Label Large On surface variant (4 in), 12 over its rows of Medium icon buttons
  (56, five to a row, spread across, 12 apart), 24 between kinds. The current one is filled in the habit's colour, the
  rest neutral. Done keeps the one tapped, ✕ leaves it as it was. It is `IconPage` (`newhabit/FormPages.kt`) on
  `FormPage`, which every form page shares. The app, the unit tests (55), lint and the instrumented tests' code build in
  the session.
  Fixed:
  - The kinds' labels were the grey group title (16 above, 8 under, 16 in); now Label Large On surface variant, 4 in, 12
    over the icons and 24 between kinds.
  - The search bar sat 8 from the bar and the icons; now 16, as Figma, with 24 under the last row.
  - Form pages (`FormPage`) took the app's old page colour; now Surface container.
  - Tests: HabitFormTest picks an icon with Done, and checks ✕ keeps the one chosen before.
  Noted, not changed:
  - Figma draws four kinds of ten icons as a sample; the app keeps its catalogue (`HabitIcons`, the kinds and icons
    people's habits use) and its search.
  - A search with no match says "No icons match “…”." (Figma draws no such state).

- **5.7.5 Create new · Colour (29 Oct).** Figma: Colour (1074:161496), over the form behind its Scrim. From the form's
  Colour: the Bottom sheet (Surface container low, its drag handle, the header "Colour" in Title Large Emphasized), then
  the 13 habit colours as Colour swatches (40, 8 apart, seven to a row, rows 12 apart; 16 at the sides, 8 above, 24
  under): Red, Orange, Yellow, Green, Mint, Teal, Cyan · Blue, Indigo, Purple, Pink, Brown, Grey. The chosen one is
  smaller (30) in an On surface ring with a check in On habit (white). A tap chooses it and closes the sheet. It is
  `ColourSheet` (`newhabit/FormPages.kt`). The app, the unit tests (55), lint and the instrumented tests' code build in
  the session.
  Fixed:
  - It already matched Figma; two placeholder lines that only kept unused imports alive are deleted.
  - Tests: HabitFormTest chooses orange, sees the sheet close, and finds orange chosen when it opens again.
  - **Built:** run 40940598201 (Android #159, commit 26f8cab) passed: assembleDebug, unit tests and lint (5.7.4 and
    5.7.5 together).

- **5.7.6 Create new · How often page (29 Oct).** Figma: How often page (1075:161386), 15 variants (Every day; Several
  times a day; Times a week, month or year; On certain days of the week; Every few days; Every few weeks, and on set
  days; Every few months; On a date: dates, a weekday, a year; Cut down; Task: every day, a while after it’s done; Every
  day at 200%), and the flows "How often: several a day, or a number of times", "days of the week, or every few", "on a
  date each month or year". From the form's How often. On Surface container: the Top app bar (← "How often"); groups of
  radio Options, 16 at the sides and above, 40 under, 16 between groups, 2 within, no titles (A64), each option's words
  in Body Large on Surface bright. The chosen one says what it means ("Twice a day", "3 times a week", "Every Friday",
  "Every other week on Friday", "On the 23rd of every month", "Every year on October 23", "2 weeks after it’s done") and
  opens its settings in the same piece, 8 apart, 16 (or 12, or 24) under: a Stepper (Body Large label, − number +, its
  unit); Week · Month · Year; Weekdays · Weekends and the seven days; On set days with its switch and days; Month ·
  Year, Repeat on and the 31 dates, or Which and Day, or Month and Day; Days · Weeks · Months with Again after. A limit
  chooses "At most 1 h a day / a week / a month"; a task has Every day, the days of the week, every few, on a date and a
  while after it’s done. It is `HowOftenPage` (`newhabit/FormPages.kt`), with `OpenOption`, `Stepper` and Option-style
  `RadioRow` (`newhabit/FormParts.kt`). The app, the unit tests (55), lint and the instrumented tests' code build in the
  session.
  Fixed:
  - The groups had titles (Daily, A number of times, Days of the week, Every few days, weeks or months, On a date, In
    total, A number of days, After it's done); deleted (A64).
  - A chosen option and its settings were separate rows 2 apart; now one piece of the group, as Figma's "(chosen)".
  - Options were Title Medium on Surface; now Body Large on Surface bright (`AppListItem` gained a headline style;
    `RadioRow(option = true)`; other pages keep Title Medium).
  - Counts were List item rows; now the Stepper (16 at the sides, label filling, then − number + and the unit).
  - The days of the week sat 40 in with 12 between their parts; now Weekdays · Weekends 16 in, 8 apart, then the days
    16 in, 24 under. On set days is a row of its own with the switch, then its days.
  - A date rule had an "Every n months" count Figma doesn't have (Every few months covers it): deleted; a habit that
    has one keeps it.
  - A task's page was titled "Repeat"; now "How often". Its "Counted from the day you tick it." note and the Years
    choice of Again after are gone (Figma: Days · Weeks · Months); a task saved with years keeps them.
  - The Week · Month · Year and Month · Year groups sit 16 in with 4 above, as Figma's Period.
  - Tests: HabitFormTest checks no group titles, Several times a day's Twice a day and its + to 3 times a day, Times a
    week, and the form's row saying it.
  Noted, not changed:
  - An amount habit's choices (a day, a week, a month or a year in total, and days a week, month or year) aren't drawn;
    they keep their options, now without titles.
  - The notes for months without a date ("Months without that date use their last day.") and the last-day and leap-year
    choices aren't drawn (no variant picks a 29th to 31st or 29 February); they stay for those days.
  - **Built:** run 40941854863 (Android #160, commit 8851c69) passed: assembleDebug, unit tests and lint.

- **5.7.7 Create new · Time of day page (29 Oct).** Figma: Time of day page (1098:2480), Option At set times of day ·
  Anytime, and the flow "Time of day: more than one, and a new one". From the form's Time of day. On Surface container:
  the Top app bar (← "Time of day"); one group of two Options (16 in, 16 down, Surface bright, Body Large over Body
  Medium): Anytime ("No set time") and At set times of day ("Pick one or more"). Chosen, the second opens in the same
  piece, 8 under: the times of day as checkboxes 40 further in, each with its hours ("6:00 AM – 12:00 PM"), and + New
  time of day (the same page as Settings › Times of day). It is `TimeOfDayPage` (`newhabit/FormPages.kt`). The app, the
  unit tests (55), lint and the instrumented tests' code build in the session.
  Fixed:
  - The title said "Time of Day"; now "Time of day".
  - A line under the list repeated the choice ("It shows in Morning on Today …", A64): deleted, with
    `FormOutcome.timeOfDay`.
  - The times and New time of day were rows of their own, 2 apart; now in the chosen option's piece, Body Large, 40 in
    (`CheckRow` and `AddRow` gained `option`).
  - `NewSectionDialog`, a New time of day dialog nothing opened, is deleted.
  - Tests: HabitFormTest's new time of day test checks the title and that no line repeats the choice.
  Noted, not changed:
  - Figma's chosen "At set times of day" is Title Medium, its unchosen one and every other Option Body Large; the app
    uses Body Large for both.

- **5.7.8 Create new · Reminders page (29 Oct).** Figma: Reminders page (1100:2996), Reminders Off · On · On, menu
  open · On, free plan, and the flows "Reminders: turned on", "notifications not allowed", "on time, on some phones".
  From the form's Reminders. On Surface container: the Top app bar (← "Reminders"); groups 24 apart, 16 at the sides
  and above, 40 under, each footer 8 under in Body Small On surface variant, rows on Surface bright. **Remind me**
  (its switch; off: "Reminders are off. Turning on Remind me asks Android once if Often Enough may send
  notifications."; refused: "Notifications are off for Often Enough, so reminders can’t come. Turning Remind me on asks
  again."; once Android won't ask: "Android won’t ask again. To get reminders, allow notifications for Often Enough in
  Settings." with Open settings). **Remind me at** (Label Large Primary): each time (schedule, Body Large, ✕) and + Add
  a time. **How**: Remind me with (its menu: A notification, "In your notifications"; An alarm, "Rings until you stop
  it") and If not done, remind again (Never, 15 or 30 min, an hour), then "Not sent on a day it’s already done."
  **Reminder says (optional)** (chat_bubble): "Shown instead of the name when names are hidden outside the app." It is
  `RemindersPage` (`newhabit/FormPages.kt`). The app, the unit tests (55), lint and the instrumented tests' code build
  in the session.
  Fixed:
  - The page opened with the habit's icon and its sentence; Figma has neither: deleted, with the form pages' sentence
    chip (`SentenceChip`, `FormState.sentence`, `chipText`) and the `chip` parameter every page passed as null.
  - The footers were the app's own ("Reminders are off. Turn on Remind me to choose times …", "Notifications are off for
    the app …", a long "A notification at 9:00 AM on planned days …" sentence, "Shown in this habit's reminders …");
    now Figma's words. `FormOutcome.reminders` and its rules sentence are deleted.
  - Remind me at and How were grey Label Large 24 above; now Label Large Primary, 8 over their rows, groups 24 apart.
  - The times and Add a time were Title Medium; now Body Large, as Figma. Rows sit on Surface bright.
  - **If not done, remind again is Plus (A73):** on the free plan the row carries the Plus label under Never and opens
    Plus instead of its menu. A habit that already has a follow-up keeps it; reminders themselves are unchanged.
  - The Remind me with menu's choices have their lines ("In your notifications", "Rings until you stop it");
    `AppMenuItem` gained a supporting line.
  - Edit habit's form had no way to Plus (an empty `onPlus`); it now opens Plus too.
  - Tests: HabitFormTest turns reminders on and checks the off footer, Remind me at, a time, both footers and remind
    again marked Plus.
  Noted, not changed:
  - Figma's free-plan row opens Plus with Reason=Remind me again; the Plus screen has no reasons yet (5.9.1), so it
    opens the Plus screen as it is.
  - **Built:** run 40943749934 (Android #161, commit d7cfee2) passed: assembleDebug, unit tests and lint (5.7.7 and
    5.7.8 together).

- **5.7.9 Create new · How much page (29 Oct).** Figma: How much page (1102:2782), State Typing · Keyboard down, and
  the flow "A new habit: track an amount". From the form's How much. On Surface container: the Top app bar (← "How
  much"); 16 at the sides and above, 40 under, 24 between: the amount's card (Surface bright, corners 24, 24 above and
  under, 20 at the sides, 16 apart): the number field (80 tall, Surface container highest, corners 16, Display Medium,
  the number pad up while it's empty) over the Unit dropdown; its footer, "Up to 2 decimal places. The unit is
  optional."; then **When you log it** (Label Large Primary): One tap adds a set amount, open with Each tap adds and its
  step (72 wide, Surface container highest, corners 8), or Type the amount each time. The form says it back ("8 glasses
  · each tap adds 1"). It is `HowMuchPage` and `WhenYouLogIt` (`newhabit/FormPages.kt`). The app, the unit tests (55),
  lint and the instrumented tests' code build in the session.
  Fixed:
  - The card started with the rhythm ("Every day") over the number; nothing above the number repeats How often (A64).
  - The footer said "Tap the number to type it, up to 2 decimal places. The unit is optional."; now Figma's words.
  - How a tap logs ("When you tap +", on the form since 5.7.3) moves here as Figma's When you log it, with its words
    (One tap adds a set amount, Each tap adds, Type the amount each time); its notes go. `TapRows` is deleted.
  - The number field and card take the theme's roles (Surface container highest, Surface bright, Primary while typing).
  - Tests: HabitFormTest types 8, checks the footer and When you log it, and sees the form say "each tap adds 1" and
    then "typed each time".
  Noted, not changed:
  - Limit still opens this page with its old card and note until its own page, 5.7.13 (A67: Amount · Time).
  - An amount that isn't a number above 0 says "Enter a number above 0, with up to 2 decimal places." in the footer's
    place (Figma draws no such state).

- **5.7.10 Create new · Unit page (29 Oct).** Figma: Unit page (1102:3316), State No unit · Creating your own ·
  Searching · Own unit added. From How much's Unit. On Surface container: the Top app bar (← "Unit"); 16 at the sides
  and above, 40 under, 24 between: the Search bar ("Search units"); **Your own** (No unit, the units of your own, the
  field "e.g. prayers" with Done while creating, + Create your own unit; "Anything you count, in a word or two:
  prayers, laps, sets."); then Drinking, Walking and running, Reading and writing, Exercise, Everyday and Money, each a
  subheader in Label Large Primary over radio Options in Body Large on Surface bright. Searching shows only the
  matching units, in their groups, without Your own. A tap chooses and goes back. It is `UnitPage`
  (`newhabit/FormPages.kt`). The app, the unit tests (55), lint and the instrumented tests' code build in the session.
  Fixed:
  - There was no search; now Figma's Search units, which filters every group.
  - Your own started with Create your own unit; now No unit first and Create your own unit last, as Figma, its field
    opening above it. A unit made here and in no other habit shows with ✕, which takes it off.
  - A limit's "Cutting down" group (cigarettes, drinks, coffees, snacks) isn't in Figma: deleted.
  - Group titles were the grey label 16 above; now Label Large Primary 8 over their rows, groups 24 apart, the rows Body
    Large on Surface bright.
  - Tests: HabitFormTest searches "bo" (bottles and books, not glasses), makes "prayers" with Done, and finds it with ✕.
  Noted, not changed:
  - A cut-down habit still finds "Time" here until Limit's own Amount · Time (5.7.13, A67), which is where it goes.
  - **Built:** run 40944794438 (Android #162, commit d48b580) passed: assembleDebug, unit tests and lint (5.7.9 and
    5.7.10 together).

- **5.7.11 Create new · How long page (30 Oct).** Figma: How long page (1103:3208), State Typing · Quick pick, and the
  flow "A new habit: time it". From Time it's How long. On Surface container: the Top app bar (← "How long"); 16 at the
  sides and above, 40 under, 24 between: the card (Surface bright, corners 24, 24 above and under, 20 at the sides)
  with Hours and Minutes side by side, 12 apart, each box 80 tall on Surface container highest, corners 16, the number
  in Display Medium Emphasized ("0" until typed; Primary's 2 dp ring while typing; the cursor starts in Minutes), its
  label under it in Body Medium On surface variant; then **Quick picks** (Label Large Primary): 5, 10, 15, 20, 30, 45
  min and 1 h as filter chips, 8 apart, and "The timer on Today counts up to it." It is `HowLongPage` and `TimeBox`
  (`newhabit/FormPages.kt`). The app, the unit tests (55), lint and the instrumented tests' code build in the session.
  Fixed:
  - The card started with the rhythm ("Every day"); nothing above the boxes repeats How often (A64).
  - The boxes were 96 wide around a ":" in Display Medium with "00" and labels in Body Small; now two equal boxes 12
    apart, no ":", Display Medium Emphasized, "0", labels in Body Medium.
  - Quick picks' title was the grey label; now Label Large Primary. The footer is Figma's "The timer on Today counts
    up to it." (was "How long it takes on a day. The timer on Today counts up to it.").
  - Colours take the theme's roles.
  - Tests: HabitFormTest's How long test checks Quick picks and the footer.
  Noted, not changed:
  - A week's or month's total says "How long in a week, in total. The timer on Today counts up to it.", and minutes
    over 59 say "Minutes go up to 59; use hours for more." (Figma draws only a day).
  - **Built:** run 40989840291 (Android #163, commit 16a231b) passed: assembleDebug, unit tests and lint.

- **5.7.12 Create new · Steps page (30 Oct).** Figma: Steps page (1104:163327), State Typing a step, and the flow "A new
  habit: a checklist". From a checklist's Steps. On Surface container: the Top app bar (← "Steps"); 16 at the sides and
  above, 40 under: one list, 2 apart, on Surface bright: each step a Form field with its handle (drag to reorder;
  TalkBack's Move up and Move down) and ✕ ("Step 4" until typed, the new one focused), then + Add step (Body Large); 8
  under it, "Up to 24 letters a step. Each step is ticked on its own." The form says how many ("None yet", "2 steps").
  It is `StepsPage` (`newhabit/FormPages.kt`). The app, the unit tests (55), lint and the instrumented tests' code build
  in the session.
  Fixed:
  - The footer said "… Drag to reorder. …"; now Figma's words.
  - The steps and Add step take Surface bright; Add step is Body Large, as Figma; the list sits 16 under the bar.
  - Tests: HabitFormTest adds two steps and sees the form say "2 steps".
  Noted, not changed:
  - A73 makes a new checklist habit Plus; the free plan doesn't stop it yet. That choice is made on How do you want to
    track it? (5.7.16), where it goes.

- **5.7.13 Create new · Limit page (30 Oct).** Figma: Limit page (1105:3190), Kind Amount · Time, and the flows "A new
  habit: cut down" and "A new habit: cut down time" (A67). From a cut-down habit's Limit. On Surface container: the Top
  app bar (← "Limit"); 16 at the sides and above, 40 under, 24 between: **Amount · Time** (a connected button group,
  Amount to start), then a card on Surface bright (corners 24, 20 above, 24 under, 20 at the sides, 16 apart) under "At
  most" in Body Medium On surface variant. **Amount:** How much's number field over the Unit dropdown; "Log it only when
  it happens. At or under the limit counts as a good day." **Time:** How long's Hours and Minutes, then **Quick picks**
  (15, 30, 45 min, 1 h, 1 h 30 min, 2 h, 3 h); "Log time spent, or use the timer. At or under the limit counts as a good
  day." A time limit is saved as a Duration limit ("At most 1 h a day"), logged as time or with the timer. It is
  `LimitPage` (`newhabit/FormPages.kt`), sharing `AmountField` with How much and `TimeBox` with How long. The app, the
  unit tests (55), lint and the instrumented tests' code build in the session.
  Fixed:
  - A67's build work: a time limit was the unit "minutes" in a *Time* group on the Unit page; that group is deleted and
    Limit's Time choice makes the time limit, typed in hours and minutes.
  - The limit used How much's old card with the rhythm on top ("At most, every day") and its own note; now Figma's
    "At most" card and footers.
  - Switching Amount and Time starts the number again (two cups aren't two minutes). A saved limit keeps its kind and
    shows no Amount · Time (A68).
  - The old goal card (`GoalCard`, `oftenHeader`) is deleted: no page uses it now.
  - Tests: HabitFormTest checks At most and Amount's footer, picks Time and 1 h, sees Time's footer, and the form's
    Limit saying 1 h.
  - **Built:** run 40990668905 (Android #164, commit d89b1fa) passed: assembleDebug, unit tests and lint (5.7.12 and
    5.7.13 together).

- **5.7.14 Create new · What kind of task? (30 Oct).** Figma: What kind of task? (1109:2), and the task flows ("The
  third choice: Add a task, then once or on repeat"; "No Repeat row: a one-time task has its date"; "The repeating task
  form: no Date; How often, Starts and Ends"). From Add a task and from Tasks' +. The choice page (5.7.1) with ←: Once
  (event, "On one day, or with no date.", "e.g. Pick up parcel") and On repeat (event_repeat, "Comes back on the days you
  pick, or a while after it’s done.", "e.g. Water plants, every 3 days"), each opening its task form. It is `TaskKinds`
  (`newhabit/Choices.kt`), in `NewHabitFlow`. The app, the unit tests (55), lint and the instrumented tests' code build
  in the session.
  Fixed:
  - There was no such page: Add a task and Tasks' + opened the form, whose first row was Repeat (Never | On a
    schedule). Now the kind is chosen first and the form has no Repeat row (held since 5.7.3); its menu is deleted.
  - ← from the task form goes back to What kind of task?; from there, to What do you want to do? (or, from Tasks' +,
    out). A duplicated task keeps its own kind and opens its form straight away.
  - `Symbols.EventRepeat` added (Material Symbols' event_repeat, outlined).
  - Tests: HabitFormTest opens On repeat (How often, its footer, no Date or Repeat row, ← back to the page);
    TasksPageTest goes through Once from Tasks' + and from search's Add, and reads the No date footer (the preview's
    note it read went in 5.7.3).
  Noted, not changed:
  - Edit task has no Repeat row either: a task keeps the kind it was made with, as a habit keeps its type (A68).

- **5.7.15 Create new · Get reminders on time (30 Oct).** Figma: Get reminders on time (1164:344717), and the flow
  "Reminders: on time, on some phones". After Allow on Reminders, on a phone that holds exact times back: the Bottom
  sheet (Surface container low, its drag handle) over Reminders and its Scrim; centred, 24 at the sides, 16 apart: the
  alarm icon in Primary; "Get reminders on time" in Headline Small On surface; "To save battery, Android can hold
  reminders back, so one set for 9:00 AM may come a few minutes to an hour late." and "Settings opens on Alarms &
  reminders. Turn on Allow setting alarms and reminders, then come back." in Body Medium On surface variant, 8 apart;
  then Open settings (Filled) over Not now (Text), the sheet's width, 8 apart, 8 more above them. Open settings opens
  Often Enough's own Alarms & reminders switch (U40). It is `ExactTimesSheet` (`newhabit/FormPages.kt`) on
  `AppBottomSheet`. The app, the unit tests (55), lint and the instrumented tests' code build in the session.
  Fixed:
  - The sheet was Material's plain one with a 64 icon circle, its own words ("Android holds reminders back unless an
    app may use exact times …") and "Allow exact times" as a Medium button; now the Bottom sheet atom with Figma's
    icon, words and buttons.
  - U40's build work: Open settings swallowed a failure and opened nothing on a phone without that page; it now opens
    App info, through `openSettingsPage` (`settings/RemindersSettings.kt`), which Today's notices (`TodayNotices.open`)
    use too.
  Noted, not changed:
  - No instrumented test opens it: a test launch never asks Android for notifications or exact times (a system
    question would stay over every later launch on the emulator), so the sheet is checked by building it.
  - **Built:** run 40991406372 (Android #165, commit 56c2cf0) passed: assembleDebug, unit tests and lint (5.7.14 and
    5.7.15 together).

- **5.7.16 Create new · How do you want to track it? (30 Oct).** Figma: How do you want to track it? (1208:375097), Plan
  Plus · Free. From Build or maintain. The choice page (5.7.1) with ←: Check it off (check_circle, "Done or not done.",
  "e.g. Make your bed"), Track an amount (tag, "How many or how much.", "e.g. 8 glasses of water"), Time it (timer, "How
  long, with a timer.", "e.g. Meditate 10 min") and Checklist (checklist, "One habit, several steps.", "e.g. Workout:
  push-ups, squats"), each opening its form. **Plan=Free:** Checklist carries the Plus label beside its name and opens
  Plus (A73: a new checklist is Plus; one made earlier or restored always works). It is `TypeChoices`
  (`newhabit/Choices.kt`). The app, the unit tests (55), lint and the instrumented tests' code build in the session.
  Fixed:
  - Checklist said "A short list to tick off." and "e.g. Clean kitchen"; now Figma's words.
  - The free plan could make a checklist; now the Plus label and the Plus screen, as Figma (held since 5.7.12).
    `ChoiceCard` gained `plus`.
  - Tests: HabitFormTest checks Checklist's words and its Plus label on the free plan, and that its tap opens no form;
    the Steps test launches with Plus.
  Noted, not changed:
  - Duplicate on a checklist habit opens its form straight away, so the free plan can still copy one it has; Figma's
    Duplicate flow doesn't say. Held for the user.
  - Figma's Plus screen opens with a reason; the Plus screen has none yet (5.9.1).

  - **Built:** run 40991904546 (Android #166, commit 1bebdef) passed: assembleDebug, unit tests and lint.

  **Section 5.7 Create new is built (5.7.1–5.7.16).**

- **5.8.1 Settings · Keep reminders coming (30 Oct).** Figma: Keep reminders coming (804:192), the per-maker screens on
  the today page ("Keep reminders coming on each phone": Samsung, Xiaomi, OnePlus, vivo, Honor, Google Pixel and other
  phones) and the settings flows ("nothing allowed yet", "tap Open settings"); A40, A66, A70. From a reminder notice's
  Show me how and from Settings. On Surface container: the Top app bar (← "Keep reminders coming"); 16 at the sides, 8
  above, 40 under, 24 between: the lead in Body Large On surface variant (this phone maker's, e.g. "Samsung puts apps
  to sleep to save battery, which can stop reminders. Two steps keep Often Enough awake.", or "No habit has a reminder
  yet. When one does, these steps make sure it comes on time. You can do them now or later."); **Permissions** (Label
  Large Primary) over one list on Surface bright: Allow notifications (App info › Notifications; Allow), Allow alarms &
  reminders (Special app access › Alarms & reminders; Open settings), then this phone maker's own steps, each its own
  row with its own icon and Open settings; a row still to do has its Tonal button under its words, a row done turns its
  icon into the check (A70); then "These change only Often Enough. Other apps keep saving battery." It is
  `KeepRemindersComingPage` (`settings/KeepRemindersComing.kt`). The app, the unit tests (55), lint and the instrumented
  tests' code build in the session.
  Fixed:
  - Settings › Reminders was a different page: a "Reminder check" card (Notifications, Exact times, Battery), a "didn't
    arrive" card, and every habit's reminders under With reminders and Without reminders. Figma has none of those
    (A77): deleted with `RemindersSettingsPage`, `missedReason` and `reminderLine`. Today's notice still says when a
    reminder didn't arrive, and its Show me how opens this page.
  - This phone maker's steps (A40) were one generic Battery row; now each maker's own steps in Figma's words: Samsung
    (Set battery to Unrestricted; Keep it out of sleeping apps), Xiaomi, Redmi, POCO (Turn on Autostart; Set Battery
    saver to No restrictions), OnePlus, OPPO, realme (Allow background activity; Allow auto launch), vivo, iQOO (Allow
    high background power use; Turn on Autostart), Honor, Huawei (Manage App launch yourself, all three on), and every
    other phone (Set battery to Unrestricted). Each opens that maker's page where Android lets an app name it, else App
    info; one the app can read (battery Unrestricted) is ticked when it's so, the others once opened (A40).
  - `openSettingsPage` also falls back to App info when a maker keeps its page closed to other apps.
  - Icons added: battery_full, autorenew, battery_saver, rocket_launch (Material Symbols, outlined).
  - Tests: ScreensTest opens the page from Settings (lead, Permissions, both rows, footer); ReminderWordsTest checks
    each maker's lead and steps (in place of the deleted lines' tests).
  Noted, not changed:
  - A40: the makers' menu names change with versions; each step and the page it opens must be checked on a real phone
    of that maker before release (W2, version-scoped). The emulator is a Google phone, so only "other phones" is seen
    in tests.
  - Settings' own row for this page (its name and "1 thing to fix" / "All set" / "No reminders yet") is 5.8.3.

- **5.8.2 Settings · Edit time of day (30 Oct).** Figma: Edit time of day (830:265), State Default · Error. From Times
  of day (and, as New time of day, from the form's Time of day). The Top app bar (✕, the title, Save or Add); 16 at the
  sides and above, 40 under, 8 apart: the name (Surface container lowest, Body Large, up to 16 characters; at 16,
  "That's the most: 16 characters." in Body Small Error); **Time** (Label Large On surface variant): Starts (its time, ›,
  the time picker) and Ends ("12:00 PM, when Afternoon starts"); "Habits can still be ticked at any time; the time of
  day only orders Today and marks what's Now."; **Your day**: each time of day with its hours, this one saying
  "Editing" ("New" while adding); Delete time of day (Outlined, Medium, red words, 16 above), asked first. It is
  `SectionEditorScreen` (`settings/SettingsPages.kt`). The app, the unit tests (55), lint and the instrumented tests'
  code build in the session.
  Fixed:
  - The name was Headline Medium in a 68-tall card; now Figma's field, Body Large on Surface container lowest.
  - Starts was a large tile (the time in Display Medium, an edit pencil, the end under it); now Figma's Starts and Ends
    rows (`StartTile` deleted).
  - The labels were the grey group title; now Label Large On surface variant 8 above, as Figma's. The footer is Body
    Small.
  - Your day's rows were hand-drawn segments with a tonal "✎ Editing" chip; now List items on Surface bright with
    "Editing" (or "New") as trailing text. The line under them ("Each time of day ends when the next one starts. …") is
    gone: Figma has none.
  - Over 16 characters there was the app's limit note; now Figma's "That's the most: 16 characters." in Error.
  - Tests: HabitFormTest's new time of day test checks the Ends row's words, New, and the 16-character line.
  Noted, not changed:
  - Figma's Error line is red (Body Small Error) for a time of day's name; A65 keeps a habit's name field from ever
    turning red. This follows Figma; held for the user if a time of day's name should follow A65 too.
  - A row whose hours a new start changes says "Was …" under them, and a start inside another time of day asks to
    split it first; Figma draws neither state.
  - **Built:** run 40992743287 (Android, commit 3f7c19f) passed: assembleDebug, unit tests and lint (5.8.1 and 5.8.2
    together).

- **5.8.3 Settings · Settings (30 Oct).** Figma: Settings (1173:547), Screen Default · End of the list · Nothing set up,
  and the settings page's flows (Opening Settings, Keep reminders coming, Vibration and sound, Privacy policy,
  Open-source licences, New day starts at, Week starts on, Theme, Reminders before anything is set up). From the menu
  (A28). On Surface container: the Top app bar (≡ "Settings", Title Large Emphasized); scrolling, 8 above, 16 at the
  sides, 40 under, 24 between: five sections, each a Label Large Primary heading 16 in and, 8 under it, one List of List
  items on Surface bright (Two lines, the icon in its circle, › where it opens something): **Backup** (Backup & Sync:
  "Backed up · Today, 9:14 AM", cloud_done; "Not backed up yet", cloud_off), **Your day** (Times of day: their names;
  New day starts at: 12:00 AM; Week starts on: Sunday), **Reminders** (Keep reminders coming: "No reminders yet" while
  no habit reminds, "3 things to fix" … "1 thing to fix" with notification_important, "All set" with
  notifications_active), **General** (Theme: System default; Vibration, "A light buzz as you log", on; Sound when done,
  "Plays when a goal is met", off; the whole row toggles), **About** (Privacy policy, "Opens in your browser", ↗;
  Open-source licences, "The libraries we use"; Version "1.0 (1)", not tappable). It is `SettingsHome`
  (`settings/SettingsHome.kt`), in the menu's drawer (`WithMenu`). Local Gradle can't reach Maven Central from the
  session (HTTP 429 on every request through the proxy, 30 Oct), so GitHub's Android build is the compile check; the
  instrumented tests' code was checked by reading.
  Fixed:
  - Settings was a stand-in list (Your day: Times of Day, Day and Week; The app: Reminders, Appearance; Your habits:
    Backup & Sync, Privacy & Security; About: Help, About) with ← where Figma has ≡; now Figma's five sections, rows,
    words, values and icons, with the menu.
  - Each row shows its current value (Figma: "Every row that opens something to change has › and shows its current
    value under the name"). Backup & Sync's comes from the page's own card (`backupSummary`, `ui/backup/BackupScreens.kt`,
    "Today, 9:14 AM" where the card says "Today at 9:14 AM"); Keep reminders coming counts what its page shows still to
    do (`remindersLeftToFix`, shared with the page, read again on return from Android's settings).
  - **Sound when done did nothing:** the switch was saved but no sound ever played. Now the chime (the iPhone's
    Tick.wav, `res/raw/tick.wav`, played by `app/Chime.kt`) plays when a log meets a goal (the store's `onLog`, as the
    iPhone's `TickFeedback`), as a sonification sound muted in silent and vibrate mode (Figma: "Android's silent mode
    mutes it").
  - Help & Feedback and About aren't in Figma (A77): deleted with their routes, `HelpTopics`, the About card and
    Today's unused `help()`. Contact us is in the menu (A29); Version and the licences are Settings' rows. What other
    screens use stays in `settings/Support.kt` (`Support`, `LicencesPage`). The Privacy & Security row goes; App Lock's
    own code goes with cleanup 6.5 (A27).
  - Privacy policy opens oftenenough.com/privacy in the browser.
  - Icons added: volume_up, policy, code, notification_important (Material Symbols Rounded, outlined).
  - Tests: FirstRunTest checks the five sections and every row's words; ScreensTest loses the Help test; SpeedTest's
    control is the Settings page scrolled (the Help page it scrolled is gone).
  Noted, not changed:
  - New day starts at and Week starts on open the Day and Week page, and Theme opens Appearance, until their own pages
    (5.8.6, 5.8.7, 5.8.8).
  - A Custom Tab (Figma's) needs `androidx.browser`, and Google's licences screen needs its OSS Licenses plugin: no
    library was added (Decisions needed D-18, D-19).
  - The Backup & Sync row's states Figma doesn't draw keep the card's titles (D-20). The iPhone plays the chime once
    when Sound is turned on; Figma doesn't say, so it doesn't (D-21).
  - Figma draws light only; the page uses the theme's roles, so dark follows them. Rows are List items (56 dp and up,
    growing with the text); the headings are headings and the two switches read as switches to TalkBack; nothing
    moves, so Remove animations changes nothing.
  - **Built:** run 41019950301 (Android, commit 801bd18) passed: assembleDebug, unit tests and lint.

- **5.8.4 Settings · Times of day (30 Oct).** Figma: Times of day (1176:356264), and the flows Edit a time of day, A new
  time of day, Delete a time of day and Leaving Edit time of day with changes. From Settings. On Surface container: the
  Top app bar (← "Times of day"); 8 above, 16 at the sides, 24 between: one List on Surface bright: Anytime ("No set
  time", no ›: "it has no time to change"), then each time of day in time order with its hours ("6:00 AM – 12:00 PM",
  ›); then, 16 in, "Morning, Afternoon, Evening, or your own, like Before work. Each one ends when the next one starts." in
  Body Medium On surface variant; the Extended FAB, Add time of day. After an edit, "Changes saved"; after a delete,
  "Morning deleted" with Undo, which brings it back with its habits; both above the FAB. A new one just appears in its
  place, in time order. It is `TimesOfDayPage` (`settings/SettingsPages.kt`), the snackbars in AppRoot's `section/{id}`.
  GitHub's Android build is the compile check (local Gradle can't reach Maven Central, 5.8.3).
  Fixed:
  - The title was "Times of Day"; the rows took the list's default colour (Surface bright now), and the footer was the
    form's grey note in Body Small without Afternoon; now Figma's.
  - Nothing said a change was saved, and a deleted time of day couldn't be brought back. Now "Changes saved", and
    "<name> deleted" with Undo: `HabitStore.deleteSection` keeps the times of day as they were and each moved habit's
    places then and now; `undoSectionDelete` puts them back, finding each habit by ID when the write runs (S7), and
    leaves a habit changed in between as it is.
  - Edit time of day's own flows (5.8.2 missed them): its delete question said "Its habits move to Anytime. Nothing else
    changes." with "Delete time of day"; now Figma's "Its 4 habits move to Anytime. Their logs, notes and streaks stay."
    with Delete (one habit: "Its 1 habit moves …"; none: "No habits are in it."). ✕ or Back with something changed
    closed without asking; now "Discard your changes?" / "Morning stays as it was." / Keep editing · Discard, Edit
    habit's words, as Figma says (a new one: "Discard this time of day?" / "It won’t be added."). Unchanged, ✕ closes.
  - Tests: ScreensTest deletes Morning from Settings › Times of day and checks Undo brings it and its habits back.
  Noted, not changed:
  - Figma's Content ends 40 under the footer; the page keeps 72 under it so the FAB never covers the footer when the
    list is long (Material's FAB floats over content).
  - The one-habit and no-habit delete wordings, and New time of day's discard question, aren't drawn; they follow the
    drawn ones' pattern.
  - Figma draws light only; dark follows the theme's roles. The rows are List items; nothing moves but the snackbar,
    which is Material's own.
  - **Built:** run 41020692607 (Android, commit 0472063) passed: assembleDebug, unit tests and lint.

- **5.8.5 Settings · Backup & Sync (30 Oct).** Figma: Backup & Sync (1178:960), Screen Backed up · Not backed up · Backed
  up · end of the list, and the settings page's backup flows (Back up now, Backing up for the first time, Change account,
  Back up now with no internet, Restore from Google Drive, Restore from a backup file, Save a backup file, Export a
  spreadsheet, Delete the Google Drive backup, Erase all my data). From Settings. On Surface container: the Top app bar
  (← "Backup & Sync"); scrolling, 8 above, 16 at the sides, 40 under, 24 between: the Card notice (4.7) saying where
  things stand, and 8 under it, connected, Change account (switch_account, "Backing up to sam@gmail.com"); **Restore**
  (Label Large Primary): Restore from a backup (settings_backup_restore, "From Google Drive or a file", ›); **Export**:
  Save a backup file (save, "To restore later, on any phone"), Export a spreadsheet (CSV) (table, "To open in Google
  Sheets or Excel"); then, no heading, in Error: Delete Google Drive backup… (delete, "This phone keeps everything",
  connected only) and Erase all my data… (delete_forever, "From this phone"). Every row a List item on Surface bright,
  its icon in its circle. It is `BackupScreen` (`backup/BackupScreens.kt`). GitHub's Android build is the compile check
  (5.8.3).
  Fixed:
  - The rows took the list's default colour, the headings were Secondary with their own gaps, the icons were
    drive_folder_upload, table_chart, restore and cloud_off, Restore's line said "a backup file", and the two deletions
    had no second line; now Figma's colours, Section spacing (24 between, 8 under a heading), icons and lines.
  - The dialogs were Plus's dialog with an icon and their own words; now the Dialog atom (5.3.4) with Figma's: "Delete
    your Google Drive backup?" / "Your backup in sam@gmail.com’s Google Drive is deleted. Your habits stay on this phone,
    and nothing is backed up until you turn it on again." / Cancel · Delete; "Erase all your data?" with, when nothing is
    backed up, "They aren’t backed up anywhere, so they can’t be brought back."; "Back up to another Drive?".
  - Snackbars in Figma's words: "Google Drive backup deleted", "Backup file saved to Downloads", "Spreadsheet saved to
    Downloads", and offline Back up now's "No internet. It backs up once you’re online." (it said nothing).
  - After Erase all my data the page stayed open with "Everything on this phone is erased. You’re starting fresh."; now
    the app starts again on Today's No habits yet, as Figma (`onErased`).
  - Icons added: save, table (Material Symbols Rounded, outlined).
  Noted, not changed:
  - Android's save picker lets the person choose any folder, so "saved to Downloads" shows only when the file went
    there (Downloads' own provider, or Download on the phone's storage); elsewhere "Backup file saved" /
    "Spreadsheet saved" (D4: the truth). The picker opens where Android last left it; Figma draws it on Downloads.
  - Change account asks before Google's chooser, not after, because the Drive link chooses and connects in one step
    (Decisions needed D-22). Undo last restore stays under Restore (D-23).
  - The states Figma doesn't draw (Backing up…, Waiting for the internet, Google Drive is full, isn't connected, backup
    deleted, no Google Play services) keep the card's words (D-20). A failed save or export keeps its own words.
  - No instrumented test changes: the tests tap Restore's row only, and a test launch has no real Drive or save picker.
  - Figma draws light only; dark follows the theme's roles. Delete's and Erase's red is the Error role (D9).
  - **Built:** run 41021397917 (Android, commit 7b04baa) passed: assembleDebug, unit tests and lint.

- **5.8.6 Settings · New day starts at (30 Oct).** Figma: New day starts at (1186:13870), Screen Default · End of the
  list, and the flow "New day starts at" ("A page, like Times of day: it says what the setting does before the choices
  … Saved the moment it's tapped, as Android's own settings pages; nothing to confirm. ← goes back."). From Settings'
  row. On Surface container: the Top app bar (← "New day starts at"); 8 above, 16 at the sides, 40 under, 24 between:
  "Logs before this time count for the day before. Choose a later hour if you’re often up after midnight." in Body
  Large On surface variant, 16 in; then one List on Surface bright of the hours, each a List item (One line) with its
  radio and the hour in Title Medium. It is `NewDayStartsAtPage` on `ChoicePage` (`settings/SettingsPages.kt`); Week
  starts on and Theme take the same page (5.8.7, 5.8.8). GitHub's Android build is the compile check (5.8.3).
  Fixed:
  - New day starts at was a dropdown on a "Day and Week" page, with its own note; now Figma's page of its own, saved on
    tap.
  - Tests: ScreensTest taps 3:00 AM, checks it's saved, and that Settings' row says 3:00 AM.
  Noted, not changed:
  - Figma lists all 24 hours; the shared day rule takes 12:00 AM to 12:00 PM (Core/spec/day.md, DAY-2), so the page lists
    those (Decisions needed D-24).
  - The Day and Week page stays for Week starts on until 5.8.7, which deletes it.
  - Figma draws light only; dark follows the theme's roles. The radios are Material's; each row is one tap target.
  - **Built:** run 41022112231 (Android, commit 3acdb1c) passed: assembleDebug, unit tests and lint.

- **5.8.7 Settings · Week starts on (30 Oct).** Figma: Week starts on (1186:13871), and the flow "Week starts on" ("Says
  what changes, then every day of the week … Saved at once"). From Settings' row. The choice page of 5.8.6: the Top app
  bar (← "Week starts on"), "Week goals, the week view and Progress start on this day." in Body Large On surface variant,
  then Sunday to Saturday, each with its radio, saved on tap. It is `WeekStartsOnPage` on `ChoicePage`
  (`settings/SettingsPages.kt`). GitHub's Android build is the compile check (5.8.3).
  Fixed:
  - Week starts on was a dropdown on the Day and Week page. That page is gone (A77) with its notes and its Clock card
    ("Times follow your phone's 24-hour time setting …", "Daylight saving and travel are handled for you …"), which
    Figma doesn't have; so is `DayAndWeekRows`, which nothing used.
  - Tests: ScreensTest taps Monday, checks it's saved, and that Settings' row says Monday.
  Noted, not changed:
  - Figma's default follows the phone's region; the app's is Sunday until someone chooses (Current Work 99). Changing
    it would move every week for people who never chose (Decisions needed D-25).
  - `DropdownRow` stays for Appearance until Theme (5.8.8).
  - Figma draws light only; dark follows the theme's roles.
  - **Built:** run 41022802724 (Android, commit 17ffa89) passed: assembleDebug, unit tests and lint.

- **5.8.8 Settings · Theme (30 Oct).** Figma: Theme (1188:376784), and the flow "Theme" ("A page, like New day starts at
  and Week starts on … Changes at once and is saved; ← goes back"). From Settings' row. The choice page of 5.8.6: the
  Top app bar (← "Theme"), "System default turns dark when your phone’s dark theme is on." in Body Large On surface
  variant, then System default, Light and Dark, each with its radio, saved on tap. It is `ThemePage` on `ChoicePage`
  (`settings/SettingsPages.kt`). GitHub's Android build is the compile check (5.8.3).
  Fixed:
  - Theme was three hand-drawn tiles at the top of an Appearance page; now Figma's page of its own.
  - The Appearance page is gone (A77) with what Figma doesn't have: Done habits (A32: no setting), Vibration and Sound
    when done (on Settings since 5.8.3), and the Timers card (Open timer full screen, Show in notifications), with
    `ToggleRow` and `DropdownRow` (`settings/DayAndWeek.kt`), which nothing else used.
  - Tests: ScreensTest taps Dark, checks it's saved, and that Settings' row says Dark.
  Noted, not changed:
  - The saved timer and done-habit choices are still read by the timer's notification and the widgets, unchanged
    (their behaviour stays; a stored setting is kept): Decisions needed D-26 (always on, as Figma?) and D-27 (widgets
    keep done habits in place, as A32?).
  - Figma draws light only; Dark is the theme's dark scheme.

  **Section 5.8 Settings is built (5.8.1–5.8.8).**
  - **Built:** run 41023514082 (Android, commit 1b16109) passed: assembleDebug, unit tests and lint.

- **5.9.1 Plus · Plus (30 Oct).** Figma: Plus (1204:175), Reason 6th habit · Checklist · Remind me again · Year in Pixels ·
  Menu, Screen Default · End of the list; the flows "A sixth habit on the free plan", "A checklist on the free plan" and
  "Remind again on the free plan" (create new). On Surface container: the Top app bar (← only); scrolling, 16 at the
  sides, 24 under, 24 between: the heading about that one thing (Headline Small Emphasized over Body Large On surface
  variant, 8 apart; Menu: the app icon on its 56 tile, 16 before "Plus" and "Pay once, keep forever. No subscription, no
  account.", 2 apart); its picture, the only colour on the screen (the five habits and a dashed Primary sixth spot, "5 of
  5 free habits"; a Workout row on Today with its three steps open; a Walk reminder at 9:00 AM and, "Not done yet · an
  hour later", another at 10:00 on Green's Fill; a year of Water in Day cells at 20, under the months' letters, "Water ·
  2026"); **What you get with Plus** (Label Large Primary): the six as List items on Surface bright, grey icons in their
  circles (all_inclusive, widgets, calendar_month, checklist, notifications_active, favorite), the reason's own first;
  **Always free**; the price in a line. Held at the bottom, Get Plus · $29.99 (Filled, Medium, round, the width, 12 above
  and under). Paid, it goes on where the person was and the snackbar says "Plus is on". It is `PlusScreen` with
  `PlusReason` (`plus/PlusScreen.kt`), the route `plus/<reason>`, and inside the new-habit flow for a sixth habit.
  GitHub's Android build is the compile check (5.8.3).
  Fixed:
  - Plus was four screens of their own: the menu's Plus page (a Free / Plus is yours card, a Backup row, Already have
    Plus? › Restore from Google Play), Get Plus (Unlimited habits, Sync across devices, More widgets, Works on, and "I
    already have Plus"), Restore from Google Play's own steps, and Add a 6th habit (its price card, three features and Make
    room instead). Now Figma's one screen with its reasons (A77): `PlusPage.kt`, `GetPlusScreen`, the Plus `RestoreFlow`,
    `SixthHabitPage` and the Plus parts only they used are deleted, with the Google and Apple logos nothing draws now.
    Google Play is asked what's owned at every start and return (`MainActivity.onStart`, Rulebook D18), so a Plus bought
    before comes back by itself; onboarding's "Plus isn't on this phone" keeps its own Check again.
  - Each way in opens Plus for its reason and goes on as Figma's flows: Checklist on How do you want to track it?
    (paid: the checklist form opens straight away), If not done, remind again (paid: back on Reminders without the
    label), a sixth habit (paid: the habit is added; ← opens Make room, whose ← leaves, so the two never loop), Restore
    a 6th habit (the same, titled so), the menu (paid: it stays, saying Plus is yours) and a widget's Plus card (Menu).
  - **Year in pixels is Plus on the free plan (A73)**, as Figma's Habit details "Progress · full length · free plan": the
    card's lock (built in 4.17) is switched on, and its tap opens Plus for Year in Pixels (`HabitDetailsNav.plus`).
  - Tests: HabitFormTest buys Plus from Checklist and sees the checklist form and "Plus is on", and a sixth habit's ←
    reaches Make room; ScreensTest buys from the menu's Plus and sees it say Plus is yours; FirstRunTest reads that Plus
    stays with Google Play; HabitsPageTest waits for the Plus screen.
  Noted, not changed:
  - Not drawn, so the app's own (Decisions needed D-28): the screen with Plus already on (the menu: "Plus is yours. Thank
    you for supporting Often Enough.", no button); a payment Play is still waiting for (a snackbar here, and Today's
    "Plus is waiting for your payment"); "Payment not completed" (the Dialog atom, Try again).
  - The pictures are Figma's examples, the same for everyone (but the sixth habit's own icons); they take no touch and
    TalkBack reads each as one sentence. The Workout row fills a third (1 of 3 steps); Figma's fill is 131 of 328.
    The reminders are on Surface container lowest where Figma's native notification is white, so dark mode reads.
  - Figma's own description of Plus stores its quotes as the text "&quot;" (an old double escape); the Code line was
    added after it as it is.
  - Make room (the frames of the same flow) isn't a component set; it's 5.9.2.
  - Figma draws light only; dark follows the theme's roles and the habits' dark colours.
  - **Build:** run 41024981286 (commit 2f570de) failed to compile: the Plus route's trailing lambda went to
    `PlusScreen`'s last parameter, `title`, not `onBought` (AppRoot.kt 406). Fixed by naming it; every other call names
    its arguments.
  - **Build:** run 41025304404 (commit d0be0d5) compiled and passed the unit tests, but lint failed once
    (NonObservableLocale): the Year example read `Locale.getDefault()` in a composable, so the months' letters wouldn't
    follow a change of language. It reads `LocalConfiguration`'s locale now, as the date picker does.
  - **Built:** run 41025974515 (Android, commit f8a3730) passed: assembleDebug, unit tests and lint.

- **5.9.2 Create new · Make room (30 Oct).** Figma: the frames "3 · Make room: each habit’s ⋮ has Archive and Delete; tap
  Archive on Read" (1167:351072) and "4 · Read archived · Undo; Continue" (1167:351230), in the flow "A sixth habit on the
  free plan" ("Back (←), then archive one"; "Archive keeps everything; Delete is in ⋮ and asks first"). Not a component
  set, so it has no Figma description for a Code line. From Plus for a sixth habit, by its ←. On Surface container: the
  Top app bar (← "Make room"); 8 above, 16 at the sides, 24 between: "Archive or delete one of your habits to add a new
  one." in Body Large On surface variant, 16 in; one List on Surface bright of the habits (Two lines): each one's own
  icon in its colour in the grey circle, its name, its goal ("8 glasses a day", "Every day"), and ⋮ (Archive; Delete in
  Error); then "Archived habits keep all their progress; you can bring them back any time." in Body Medium. Archived,
  the snackbar says "Read archived" with Undo, and Continue (Filled, Medium) is held at the bottom. It is `MakeRoomPage`
  (`newhabit/MakeRoom.kt`, renamed from FormMorePages.kt, whose 6th-habit page went with 5.9.1). GitHub's Android build is
  the compile check (5.8.3).
  Fixed:
  - Each row had an Outlined Archive button and ⋮ with only Delete…, the habit's icon in its coloured circle and no
    goal; now Figma's List item with ⋮ Archive · Delete, the grey circle and the goal.
  - Making room went on by itself the moment there was room; now the snackbar says what was archived, with Undo, and
    Continue goes on (Figma 4). Undo restores the habit.
  - The intro counted the habits ("one of your 5 habits"); the footer was the form's Body Small note with "and";
    now Figma's words and styles.
  - ← went back to the sixth-habit page (which now opens Make room by its own ←, 5.9.1); it leaves the flow instead,
    so the two never loop.
  - Tests: HabitFormTest archives through ⋮, sees "… archived" and taps Continue.
  Noted, not changed:
  - Figma doesn't draw Delete's question here; it keeps the app's ("Its history and notes are deleted too. Archiving
    keeps them and makes room just the same."), Cancel · Delete (D9). A quit habit's line says "Quit".
  - Figma draws light only; dark follows the theme's roles and the habits' dark colours.

  **Section 5.9 Plus is built (5.9.1–5.9.2).**
  - **Built:** run 41026741864 (Android, commit a06471c) passed: assembleDebug, unit tests and lint.

- **5.10.1 Widgets · Widget · One habit (30 Oct).** Figma: Widget · One habit (1235:46), Kind Habit · Message, and its 29
  states ("One habit (2×2) · every state"). The 2×2 home-screen widget, Jetpack Glance: Surface container lowest, 28
  corners, 12 above, 16 at the sides and under; at the top the habit's icon (40) and the round button (40, a 48 touch
  target): Surface container highest with an On surface variant glyph, or the habit's colour with white once its goal is
  met; at the foot the name (Title Medium, 16 sp), its line (Body Medium, 14 sp, On surface variant; a quit run's or a
  timer's clock), and 12 under it today's progress (4 tall, the habit's colour on Secondary container) or the band
  (20 tall, 10 corners, Surface container high, Label Medium: "Best 45 days", "Daily limit", "Limit reached", "Over
  the limit", "Skipped today", "Back on Mon 19 Oct", "Mon, Wed and Fri"). Kind Message: its icon (24) and the ↗ button
  at the top, Title Medium over Body Medium at the foot: Choose a habit · Tap to choose; Choose a habit · Habit removed;
  No habits yet · Start one in the app; Open to update · Data unavailable. It is `SmallCard`, `Band` and `SmallMessage`
  (`app/widgets/Widgets.kt`). Only how it looks changed: what a tap does, how it's saved and when the widget updates are
  locked (U28) and untouched. GitHub's Android build is the compile check (5.8.3).
  Fixed:
  - The top row sat at the top; the name was 17 sp; the line under a quit run or timer was 15 sp; the caption ("Best 45
    days", "Daily limit") was a 12 sp line under it and the bar was still drawn under that, 8 tall on Tonal; the card was
    12 in all round. Now Figma's sizes, the band in place of the bar (so a limit never fills, A41), and the 4 tall bar.
  - The round button was Secondary container with an On surface glyph at 20; now Surface container highest, On surface
    variant, 24, as Figma's Filled icon button (every widget's button uses it).
  - The widgets' glyphs were Material Icons (filled, square ends); now Material Symbols Rounded, as Figma and the app:
    check, add, arrow_outward, list, refresh, and play and pause filled, as on Today's own button (`ic_w_*.xml`).
  - The messages were centred, 16 sp, with a 12 sp line; now Figma's layout and words ("Tap to choose", "Choose a habit
    · Habit removed"), and "No habits yet · Start one in the app" when there's no habit to choose (it opens the app).
  Noted, not changed:
  - Glance can't draw Material's flat bar exactly: no gap and no stop dot at the end of the track; its corners are
    rounded only on Android 12 and later. The text is the launcher's font (Glance can't use Google Sans Flex, T22).
  - The round button keeps a 48 touch target, so its circle sits 4 in from the edge where Figma's is flush.
  - Four states need the widget data the locked tap uses: the milestone medal and band, Couldn't save, New best, and
    skipped's "3 glasses today" (Decisions needed D-30).
  - Dark follows the app's dark colours (each colour is a day and night pair).
  - **Built:** run 41029670193 (Android, commit cb60773) passed: assembleDebug, unit tests and lint.
- **5.10.2 Widgets · Widget row fill (30 Oct).** Figma: Widget row fill (1238:428), Value 0 … 100 in steps of 10 ("100 =
  done"), and how the rows of "Today and Tasks (4×2, 4×4) · every state" use it. Behind a list row, from its start: a
  rectangle in the habit's Fill colour (Habit / <colour> / Fill, Water's #DFEAFB), as wide as the share of today's goal
  reached; a done row is filled whole; Value 0 draws nothing. Figma's Coffee ("1 of 2 cups max") and Smoking rows are
  Value 0: a cut-down row and a quit row never fill (A41). It is `RowFill` (`app/widgets/Widgets.kt`), used by
  `ListRow`. Only the look changed; the widget's data, taps and updates are locked (U28) and untouched.
  Fixed:
  - A limit's row filled in Surface container high toward its limit; now it never fills (A41), as Figma draws it.
  - The fill followed the share alone; it now also follows "done", so a row whose round button shows done is always
    filled whole (Figma's "100 = done"), whatever its share says.
  Noted, not changed:
  - Figma steps the fill by 10, like Linear progress; the widget draws the exact share (3 of 8 glasses is 37.5 %, not
    40 %), as Today's row in the app does, so the two never disagree.
  - The fill's corners come from the row's (12, 5.10.3); Glance rounds them only on Android 12 and later.
  - **Built:** run 41030552615 (Android, commit 603d1af) passed: assembleDebug, unit tests and lint.
- **5.10.3 Widgets · Widget · List row (30 Oct).** Figma: Widget · List row (1238:429) and its rows in "Today and Tasks
  (4×2, 4×4) · every state". One habit or task in the Today and Tasks widgets: 304 × 56, 12 corners, no background of
  its own, today's fill behind it (5.10.2); Body 8 at the sides, 12 between, centred: the habit's icon (32, its colour
  with a white glyph), Name (Label Large, On surface, one line …) over Goal (Body Small, On surface variant, one line …:
  "Anytime · 3 of 8 glasses", "6:24 of 10 min", "19d 12:32:45 · Best 45 days"), Streak (🔥 and the count, Label Medium,
  2 apart; tasks have none) and Action (the Filled icon button, Small, 40: Neutral, or Done in the habit's colour). It
  is `ListRow` and `Streak` (`app/widgets/Widgets.kt`). What a tap does, how it saves and when the widget updates are
  locked (U28) and untouched.
  Fixed:
  - The row was 64 tall with 16 corners on Surface; now 56, 12 corners, and no background of its own (the widget's shows
    through, as Figma's).
  - The icon was 36, the name 15 sp, the line 13 sp; now 32, Label Large (14 sp Medium) and Body Small (12 sp).
  - The streak was a drawn orange flame (`ic_w_flame`, now deleted) and a 15 sp count, tight against the line; now the
    phone's own 🔥 and the count in Label Medium, 12 after the text and 12 before the button, as Figma. This week's
    streak uses the same 🔥 (Figma draws it there too); its count keeps its size until 5.10.5.
  Noted, not changed:
  - The round button keeps its 48 touch target, so the row's padding at the end is 4 and the circle sits 8 from the
    edge, as Figma's.
  - The milestone (the medal in place of the icon and "30 days in a row" as the line, until the day ends) needs data
    the widget snapshot doesn't have; it joins D-30.
  - The text is the launcher's font (Glance, T22). `AppColors.flame` is now read by nothing: cleanup.
  - **Built:** run 41031376056 (Android, commit a36b33a) passed: assembleDebug, unit tests and lint.
- **5.10.4 Widgets · Widget · List (30 Oct).** Figma: Widget · List (1240:488), Size 4×2 · List, 4×2 · Message and 4×4 ·
  List, and the 15 states of "Today and Tasks (4×2, 4×4) · every state". The Today list (Plus, A73) and Tasks (free)
  widgets: Surface container lowest, 28 corners. 4×2: 12 at the sides and under, 10 above; the header (28 tall, 8 in:
  the title in Title Medium, 16 sp, and the count chip "2 of 5 done", Label Medium On surface variant on Surface
  container high, 10 corners, 8 by 2), 6 under it, two List rows 4 apart. 4×4: 12 all round; the header (48 tall: Title
  Large, 22 sp, over the count, and the pager ‹ 1/2 ›: 48 Standard icon buttons, chevron 24, Label Medium, all On surface
  variant), 8 under it, five rows 2 apart. Message: the header's title, then in the middle, 16 in, 4 between: the glyph
  (24, On surface variant) or the Plus label, the headline (Title Medium) and its line (Body Small, On surface variant):
  Nothing planned for today · Open Today; Nothing planned in Morning · Open Morning; Section unavailable · Tap to choose
  another; No habits yet · Start one in the app; No tasks today · Add one in the app; Open to update · Data unavailable;
  and the free plan, Plus label · See your whole day here with Plus · Tap to open the app. It is `ListWidget`, `Header`,
  `PageArrow`, `ListMessage` and the widgets' own `PlusLabel` (`app/widgets/Widgets.kt`; the app's `PlusLabel` is
  Compose, which Glance can't draw). The page change, taps and updates are locked (U28) and untouched.
  Fixed:
  - The widget was 12 in all round; the header 4 in, its title 17 sp, the chip on Secondary container in On surface, 10 by
    3, 12 corners; now Figma's.
  - The 4×4's pager arrows were 40 with a 20 glyph (Material Icons, square ends), the page number 14 sp On surface, a
    disabled arrow drawn in Secondary container; now 48, 24, Rounded chevrons (`ic_w_left`, `ic_w_right`), 12 sp, all On
    surface variant as Figma (D-31). The rows were 4 apart on the 4×4; now 2.
  - A message's title was 17 sp with no header on Open to update, its glyph On surface 6 above, its line Medium; now the
    header names the widget (Today or Tasks), the glyph is On surface variant, 4 between, the line Body Small.
  - The free plan said "Tick habits off here with Plus · Your habits are in the app" with the count and an Open Today
    button; now Figma's Plus label and words (D-32). The whole widget still opens Today.
  Noted, not changed:
  - Figma draws only a 4×2 message; a 4×4 with nothing to list uses the same, in the middle of its height.
  - Glance can't draw the app's own Compose atoms, so the Plus label is drawn again in Glance from the same roles
    (`AppColors.lightRoles` / `darkRoles`, Primary and On primary) and the same filled workspace_premium.
  - "N tasks left", in Figma's description of the Message variant, is drawn in no state; nothing shows it.
  - **Built:** run 41032298033 (Android, commit 35cfeda) passed: assembleDebug, unit tests and lint.
- **5.10.5 Widgets · Widget · This week (30 Oct).** Figma: Widget · This week (1243:857), Kind Habit and Message, and
  "This week · every state" (done today, quit, cut down, a week goal, choose a habit, open to update, free plan) and
  "· milestones". 4×2, Surface container lowest, 28 corners, 12 all round, 12 between two halves. Left, on Surface
  container (96 wide, 16 corners, 8 at the sides, 6 between, centred): the icon (44), the name (Label Large), the streak
  (🔥 and the count, 14 sp Medium) or, for a quit run or a limit, the caption (Body Small, On surface variant: "Best 45
  days", "Daily limit"). Right: today's number (28 sp) and unit (14 sp, On surface variant, on its baseline: "of 8
  glasses", "since 26 Sep") with the round button; today's progress (4 tall, the habit's colour on Secondary container,
  On surface variant for a limit; none for a quit run); the week on Surface container (16 corners): seven Day cells (Size
  Year, 24, 2 apart, today ringed) with their letters (11 sp Medium; today's On surface). Message: the glyph (24) on the
  left panel; Headline Small (22 sp) over Body Medium; the note on Surface container (16 corners, 16 in), with the Plus
  label on the free plan. It is `WeekCard`, `WeekMessage` and `WeekCellBitmaps` (`app/widgets/Widgets.kt`,
  `WidgetPublisher.kt`). Taps, saving and updates are locked (U28) and untouched.
  Fixed:
  - The week was drawn with Glance squares in the widget's own language (a ✓ on met days, » and ‖ on skipped and paused,
    a grey square around today); now the Day cell itself: `DayCellDraw` (Atom 3.6) draws the seven cells into one
    picture with the app's colours (`dayCellColors` now also takes the roles directly), so Part is the colour at 50 %,
    More than the goal the deep shade, Not done grey with ✕, No goal dashed, Skipped redo, Paused pause, and today's
    2 dp ring, exactly as Progress shows them. Glance can't draw a dash, a ring or a glyph in a square.
  - The panels were Surface container high with 20 corners and 8 in all round; now Surface container, 16 corners. The
    icon was 48, the name 15 sp, the number 30 sp, the quit and timer clocks 24 sp, the bar 8 tall; now 44, 14, 28, 28
    and 4. A limit showed its streak, or nothing, where Figma has "Daily limit"; now the caption.
  - Today's letter was Bold; now Medium in On surface, as Figma.
  - The messages were the list's centred words ("Habit removed · Tap to choose another"; the free plan "See the whole
    week here with Plus…" as its line); now Figma's Kind Message: Choose a habit · Not chosen yet (or Habit removed) ·
    "Tap to choose the habit this widget shows."; Open to update · Data unavailable · "Open the app to refresh this
    widget."; This week · "Water: 3 of 8 glasses today" · the Plus label and "See the whole week here with Plus. Tap to
    open the app." (calendar_view_week, `ic_w_week`).
  Noted, not changed:
  - Figma's quit number is "19d 12:32"; the widget keeps the live clock with seconds ("19d 12:32:45"), the only way a
    widget can tick without redrawing every minute (S3, U28: the widget's updates are locked).
  - The round button keeps its 48 touch target, so the top row is 48 tall and the gap under it 4 (8 under the circle).
  - The free plan's line is worked out from the habit's own line: "Water: 3 of 8 glasses today", "Gym: 2 of 3 this
    week", "Smoking: since 26 Sep".
  - The milestone (the medal in place of the icon, the band in place of the bar) is D-30.
  - The cells keep Figma's 24 and 2 apart while the widget is wide enough, and shrink together below that.
  - **Built:** run 41033132651 (Android, commit e8e3300) passed: assembleDebug, unit tests and lint.
- **5.10.6 Widgets · Widget setup (30 Oct).** Figma: Widget setup (1252:3618), Screen One habit, One habit · change, Today,
  Tasks, This week, Today · free plan and This week · free plan. Android's configuration activity, after a widget is
  added and from Reconfigure. On Surface container: the Top app bar (← and the widget's name; ← leaves without adding);
  then, scrolling, 8 above, 16 at the sides, 16 between, 24 at the end: the preview (the gradient of Habit / Blue / Fill
  to Habit / Orange / Fill, top to bottom, 28 corners, 24 above and under; the widget centred, a 2×2 at its 156 × 176,
  a 4×2 at 296 × 159); "Show" (Label Large, On surface variant); the choices (one List, Surface bright, 2 apart, a Radio
  button at the end): a habit with its icon (40, its colour, glyph 24), its name and "Anytime · 8 glasses a day"; or
  All of today ("Every habit planned for today"), All of today’s tasks ("Every task for today") and each time of day
  ("From 6 AM · 3 habits", "Anytime · 2 habits"). At the bottom, on Surface container, 16 all round: Add widget, or
  Save when changing a placed widget (Filled, Medium, round). Free plan: the preview as Plus shows it, then the Plus card
  (Surface container lowest, 24 corners, 20 in, 8 between: the Plus label and "Today’s list comes with Plus" / "This
  week comes with Plus" in Title Medium; what Plus adds in Body Medium, On surface variant); the whole card opens the
  Plus screen; Add widget adds the free widget. It is `WidgetSetupActivity` (`app/widgets/`) with `WidgetPreview`
  (`Widgets.kt`). What a widget does once placed is locked (U28) and untouched.
  Fixed:
  - There was no preview; now the real widget, drawn by Glance itself (`GlanceRemoteViews` over `WidgetPreview`, the
    widget's own body) from the app's snapshot and the choice being made, so it changes as the person picks. It takes no
    touch (its buttons would log) and TalkBack reads it as "Preview of the widget".
  - The bar closed with ✕; now ← as Figma's bar ("Leading: Back"; the description's "✕ closes" is the old wording).
  - "Show" was 16 in from the list (GroupTitle); now level with it, 16 above and under.
  - A habit's line was its page sentence ("8 glasses a day, anytime"); now Figma's "Anytime · 8 glasses a day" (a quit
    habit keeps "Quitting since 2 Sep"). Its icon was 40 with a 22 glyph; now 24. The rows were Surface container
    lowest; now Surface bright, as every List in the app.
  - Tasks' first choice said "All of today"; now "All of today’s tasks".
  - Add widget always said Add widget; Reconfigure now says Save.
  - The free plan was a page of its own ("Today is a Plus widget", two paragraphs) with Get Plus · price and Add without
    Plus; now Figma's: the preview, one card that opens the Plus screen, and Add widget. Buying Plus there and coming back
    shows the choices.
  Noted, not changed:
  - On the free plan This week shows no choices; the free widget then follows the habit it had, or the first habit in
    the person's order, so it can say where that habit stands.
  - The preview's colours follow the phone's light or dark setting, as the widget itself does, even when the app's
    Theme is set otherwise (widgets follow the phone; Glance resolves day and night from it).
  - A 4×4's preview is drawn at 90 % too (Figma draws only 4×2 previews).
  - **Built:** run 41034100600 (Android, commit 4523645) passed: assembleDebug, unit tests and lint.
  **Section 5.10 Widgets is built (5.10.1–5.10.6).**
- **5.11.1 Notifications & alarms · Notification icon (Often Enough) (30 Oct).** Figma: Notification icon (1268:3), 24 ×
  24: Often Enough's mark (the 52:60 inset artwork, 12° clockwise, true transparent seams) in its tonal lift, the three
  tiles white at 45 %, 70 % and 96 %, the newest brightest; "Never a single-ink mark." It is `res/drawable/
  ic_notification.xml`, Figma's own SVG export as a vector (the newest tile a rounded square turned 12° about its
  corner), the small icon of every notification the app posts: reminders and alarms (`Reminders`), the timer's Live
  Update (`TimerNotice`) and milestones (`MilestoneAlerts`).
  Research first (the prompt's rule for notifications), read 30 Oct:
  - developer.android.com, [Create a notification](https://developer.android.com/develop/ui/views/notifications/build-notification):
    the small icon is the one thing a notification must have; Android draws it from its alpha alone (white, tinted by
    the system), so the mark's three alphas stay three tones. Up to three action buttons, never one that repeats the
    tap on the notification; direct reply (RemoteInput) re-posts the same ID to close the field (for 5.11.2).
  - [Notification groups](https://developer.android.com/develop/ui/views/notifications/group): children with setGroup,
    one summary (setGroupSummary, the same ID every time, a line per child); Android groups four or more on its own,
    but only a summary guarantees it; each child keeps its own buttons (5.11.3).
  - [Android 14 behaviour changes](https://developer.android.com/about/versions/14/behavior-changes-14): full-screen
    intents are only for calling and alarm apps on Google Play; check `canUseFullScreenIntent()` and open
    `ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT` (5.11.4–5.11.5). [Exact alarms](https://developer.android.com/about/versions/14/changes/schedule-exact-alarms):
    not pre-granted from Android 14; `setAlarmClock` needs it too (already handled: `canBeExact`, U40). Android 15 and
    16's behaviour pages change nothing here; 16's ProgressStyle is for rides, deliveries and navigation.
  - [dontkillmyapp.com](https://dontkillmyapp.com/): Huawei, Xiaomi, OnePlus and Samsung (in that order) stop apps in
    the background; Samsung's "Put unused apps to sleep" stops alarms after 3 days; Xiaomi needs Background autostart;
    OnePlus's Deep optimisation and Sleep standby hold notifications back. No maker offers a fix in code: the person
    changes a setting, which Keep reminders coming (5.8.4, A40, U40) already walks through.
  Fixed:
  - The icon was a Material ✓ in a circle, one ink; now the brand mark in its three tones, as Figma.
  Noted, not changed:
  - The circle of the habit's colour behind it is the notification's `setColor`, part of Reminder notification
    (5.11.2). Some makers' status bars (and Android below 12's) draw the icon without the circle; the alphas still read
    as three tones there.
  - **Built:** run 41034637519 (Android, commit 4a7bb3e) passed: assembleDebug, unit tests and lint.
- **5.11.2 Notifications & alarms · Reminder notification (30 Oct).** Figma: Reminder notification (1268:127), State
  Collapsed · Expanded · Reply, "Reminder notification · every kind" (K.1–K.21) and the flows on the page ("Tick a habit
  from its reminder", "An amount, +1 at a time, and Undo", "An amount typed in the notification", "A time habit: Start",
  "A checklist, one step at a time", "A task, from its reminder"). Android's own template (Android 12 and later): the
  app's icon (5.11.1) in a circle of the habit's colour (setColor), "Often Enough · time", the habit's name, one line of
  where it stands, today's progress (setProgress) and at most three buttons, each saving in the background as Today's
  round button would. It is `Reminders.notice` and `Reminders.act` (`app/reminders/Reminders.kt`); the research is in
  5.11.1's entry. When reminders are planned and rung (`ReminderPlan.plan`, `replan`, `fire`, the alarm channel, D3) is
  unchanged.
  Built, kind by kind (Figma's words):
  - A check once a day: "Not done yet", **Done**; it goes once done. Several a day: "1 of 3 today" and progress, each
    Done adds one (U14), then **Undo**; at 3 of 3 it goes. A week or month goal: "1 of 3 this week", Done, and after it
    the count ("2 of 4 this month") for a few seconds, then it goes until the next reminder.
  - An amount with a step: "3 of 8 glasses", **+1 glass**; after it, **Undo +1 glass**, naming what it takes back; at the
    goal "8 of 8 glasses · Goal met", Undo only, gone after 4 seconds (setTimeoutAfter). Without a step: **Log** opens
    Android's direct reply, "How many steps?", ➤ saves (the phone's own way of writing numbers: "8,000", "2,5").
  - Time: "0 of 20 min", **Start** (the timer runs, and its Live Update, `TimerNotice`, takes the reminder's place) and
    **Log time** ("How many minutes?"); after a log, Undo; at the goal "Goal met".
  - A checklist: "0 of 5 steps", the steps as Android's inbox lines (✓ or ○), **Tick Warm-up** naming the next step,
    **Open** (the day), and Undo after a tick; the last step finishes it and it goes.
  - A task: "Task · for today", **Done**. A follow-up: "Still to do today". Updates are quiet (setOnlyAlertOnce), so an
    alarm stops ringing once answered.
  - Undo takes back exactly the log the button made, by its ID (`undoEntry`), so a second Undo does nothing.
  Fixed:
  - The line under the name was the habit's plan ("8 glasses a day", "Time for meds"); now where it stands, as Figma.
  - There was no colour, no progress, no Undo, and only Done (a check, a task) or +1 (an amount with a step): an amount
    without a step, a time habit and a checklist had no button at all. Now every kind has Figma's buttons.
  - Every button closed the notification; now it updates in place, or goes when Figma says.
  - `ReminderPlan.action` (the old button label) is gone; nothing else read it.
  Noted, not changed:
  - "Any button stops further follow-ups" (K.20) needs the reminder plan to remember a button was used; the plan is
    unchanged (the prompt: don't change what reminders do underneath). Follow-ups still stop once the habit is done.
    Decisions needed D-33.
  - Figma's description says a button never repeats the tap on the notification, yet a checklist's Open does (it opens
    the day, as a tap does); built as drawn (D-34).
  - Limits (cut down) are not drawn: they keep "1 of 2 cups · Daily limit", + or Log and Undo, no progress (A41) and
    never "Goal met".
  - With names hidden outside the app, the words are "Reminder" (or the reminder's own text), the buttons have no units
    or step names ("+1", "Tick next step") and a checklist's steps aren't listed.
  - `ReminderPlan.body` is now read only by the hidden-names path's fallback; cleanup.
  - Several reminders at the same minute are still one summary; that's 5.11.3.
  - **Built:** run 41035925336 (Android, commit f2f8a05) passed: assembleDebug, unit tests and lint.
- **5.11.3 Notifications & alarms · Reminder group (30 Oct).** Figma: Reminder group (1273:903), State Collapsed and
  Expanded, and the flow "Several reminders at the same minute" (one group for Morning; opened, each habit is its own
  notification; Done takes it out of the group; Stretch opened shows Start and Log time). Android's own grouping
  (setGroup and a summary, [Notification groups](https://developer.android.com/develop/ui/views/notifications/group)):
  the summary "8:00 AM · 3 reminders" with a line per reminder ("Take vitamins · Not done yet", "Water · 3 of 8
  glasses", "Stretch · 1 of 3 today": Android's inbox lines) and the count Android adds; each reminder posted as its own
  notification in the group (5.11.2), with its own buttons. It is `Reminders.group`, `Reminders.standing` and
  `ReminderPlan.groupWords`. When reminders ring is unchanged.
  Fixed:
  - Same-minute reminders were one notification only ("Morning" · "Meds, Stretch +2") with no buttons: none of them
    could be logged without opening the app. Now each is there, in the group, with its buttons; the summary alone rings
    (GROUP_ALERT_SUMMARY), and an update or a log keeps a reminder in its group.
  - The summary's title was the time of day's name; now Figma's "8:00 AM · 3 reminders" (with names hidden, the title
    alone, no lines).
  - An alarm-style reminder in a group never rang as an alarm; the summary now rings on the alarm sound when any of them
    is an alarm.
  Noted, not changed:
  - The summary rings once, not again and again as a single alarm does: logging one reminder in the group couldn't stop
    the summary's ring. The full-screen alarm is 5.11.4.
  - The summary's lines say where each stood when it rang; Android removes the summary once every reminder in it is
    logged or swiped.
  - **Built:** run 41036560057 (Android, commit 028004b) passed: assembleDebug, unit tests and lint.
- **5.11.4 Notifications & alarms · Alarm screen (30 Oct).** Figma: Alarm screen (1274:1061), Kind Check · Amount · Typed
  amount · Time · Checklist · Task, and the flows "An alarm: turn it on, then answer it" and "An alarm without full
  screen". A reminder set to ring as an alarm fills the screen over the lock screen (a full-screen intent) when Android
  lets it (5.11.5); it rings until answered, and the ring is the notification's, so the screen's buttons stop it as the
  notification's own buttons do (`Reminders.answer`, the same saving as 5.11.2). On the habit's Fill colour: the clock
  ("7:00", Display Large) and "Reminder · Tue, 27 Oct" (Body Large, On surface variant), 24 above, 16 under; the hero
  card (Surface container lowest, 28 corners, 24 by 28 in, 20 between): the cookie (112, glyph 56), the name (Headline
  Medium Emphasized), the description (Body Large), "Not done yet" (Headline Small) or the count ("3", Display Medium,
  and "of 8 glasses", Body Large) and the wavy progress (A76: Material's own); a checklist's card: the cookie (56), the
  name, the progress with "0 of 5 steps" (Label Large) and its steps (Step rows on Surface container, 16 corners, 2
  apart); a task: "Task · for today". Under it, 16 in, 8 between: the main button (Filled, Large, round, the width):
  **Done**, **+1 glass**, **Log**, **Start**, **Tick Warm-up**; then Text, Medium: **Log time** (time), **Open** (a
  checklist) and **Not now**. It is `AlarmActivity` (`app/reminders/`), with `Reminders.canFillScreen`, `answer` and
  `quiet`; the manifest asks for `USE_FULL_SCREEN_INTENT` and declares the activity (over the lock screen, turns the
  screen on, its own task, not in Recents). Research: 5.11.1's entry (Android 14's full-screen intent rules).
  Built:
  - Done, +1 glass, Start and Tick save as the notification's buttons do, then the screen goes and the notification is
    left as it now stands, quiet. A step row in the card ticks that step.
  - **Not now** (and Back) stops the ring and leaves the reminder as an ordinary notification.
  - **Log**, **Log time** and **Open** stop the ring, ask the phone to unlock (requestDismissKeyguard), then open Add
    log or the day in the app.
  Fixed:
  - An alarm only ever rang as a notification (A11 D3, 12 Oct: "no full screen"); Figma, newer (A77), draws it filling
    the screen. Without the person's permission it still rings as a notification, as Figma's "An alarm without full
    screen" (Decisions needed D-35).
  Noted, not changed:
  - Figma says Log and Log time "open Add log over the lock screen"; the app's Add log is in the app's own activity, so
    the phone asks to unlock first. Showing the whole app over the lock screen would show everything without unlocking.
  - Several alarms at the same minute ring as their group's notification (5.11.3), not one screen each.
  - The clock is the reminder's own time, written as the phone writes times (24-hour or not).
  - **Built:** run 41037408289 (Android, commit e394788) passed: assembleDebug, unit tests and lint.
- **5.11.5 Notifications & alarms · Let alarms fill the screen (30 Oct).** Figma: Let alarms fill the screen (1274:16200)
  over Reminders, and the flows "An alarm: turn it on, then answer it" (2 · the sheet, 3 · Android's Full screen
  notifications for Often Enough, 4 · Allowed, 5 · back on Reminders) and "An alarm without full screen" (Not now: it
  rings as a notification). The Bottom sheet over the Reminders page, asked once, the first time someone chooses Remind
  me with: An alarm on Android 14 or later while Android doesn't allow it (13 and lower allow it already): centred, 24
  at the sides, 16 apart: alarm_on in Primary, "Let alarms fill the screen" (Headline Small), why ("An alarm can show
  over the lock screen and ring until you answer it, like your clock’s. Android asks you to allow this for each app.
  Without it, the alarm rings as a notification.") and what to do ("Settings opens on Full screen notifications. Turn on
  Allow full screen notifications, then come back.") in Body Medium On surface variant, 8 apart; Open settings (Filled,
  Small) over Not now (Text), the width, 8 apart. It is `FullScreenSheet`, sharing `SettingsSheet` with Get reminders on
  time (5.7.15) (`ui/newhabit/FormPages.kt`), and `Reminders.shouldAskFullScreen`. Research: 5.11.1's entry.
  Built:
  - Open settings goes straight to Often Enough's own switch (`Settings.ACTION_MANAGE_APP_USE_FULL_SCREEN_INTENT` with the
    package), and a phone without that page opens App info (U40, `openSettingsPage`). Whether it's allowed is read each
    time an alarm rings (`canUseFullScreenIntent()`, 5.11.4), so nothing is stale on return.
  - Not now keeps An alarm chosen; it rings as a notification.
  Fixed:
  - Get reminders on time's sheet is now the shared `SettingsSheet`; its words, tags and look are unchanged.
  - The comment that an alarm is "never a full screen (A11 D3)" now says what the app does (D-35).
  Noted, not changed:
  - "Asked once": a second habit set to An alarm doesn't ask again; Keep reminders coming doesn't list this switch
    (Figma's Keep reminders coming has no row for it).
  - **Built:** run 41038258162 (Android, commit ced0b4a) passed: assembleDebug, unit tests and lint.
  **Section 5.11 Notifications & alarms is built (5.11.1–5.11.5). Every component in section 5 is ☑; next, the
  cleanup (section 6).**
- **6.1 Cleanup · Start from an idea (30 Oct).** Figma draws no idea screen anywhere (A77). Proof nothing reaches it:
  the only way in was `TodayNav.ideas()` (the page "Start from an idea"), and no screen called it; no test uses it.
  Deleted: `ui/onboarding/Ideas.kt` (`IdeasScreen`, `IdeaRow`, `HabitIdea` and its eight ideas), its page route, the
  New route's `idea` argument, `NewHabitFlow`'s and `HabitForm`'s `idea` parameter, `FormState.applyIdea`, and the
  "pristine" check only an idea set (`markPristine`, `signature`): a new form has changes once it has a name or a step,
  as before for every other new habit. No saved data is touched.
  - **Built:** run 41039142425 (Android, commit f183045) passed: assembleDebug, unit tests and lint.
- **6.2 Cleanup · The old Progress page (30 Oct).** Since A54 the Habits tab is Progress; the old page had no way in (no
  menu row: FirstRunTest checks there is none; nothing navigated to `page/Progress`). Deleted: `ProgressScreen`,
  `ProgressNav`, its range picker, period bar, group chips, card and empty state (`ui/progress/Progress.kt`), its route in
  `AppRoot` and `SettingsPage.PROGRESS`. Kept, as the Habits tab reads them: `rememberToday`, `rememberProgressSnapshot`
  with its cache, `movedAnchor` and `QuitRunClock`. SpeedTest measures the same three things on the Habits tab: the Week
  scroll, Week to Year (`habits-range-2`) and the Year scroll, then back on Week for the habit's own page; the old
  separate "Habits list scroll" was the Week scroll again, so it goes. The instrumented speed run isn't dispatched here
  (the prompt), so this test change runs the next time it is.
  - **Built:** run 41039852058 (Android, commit 08c6c4a) passed: assembleDebug, unit tests and lint.
- **6.3 Cleanup · The day's own note (30 Oct).** Figma's notes are a habit's, for a day; it draws no note for the day
  itself. Removed from the screens: Today's day-note card and its "Note for the day" button, the Note screen's day-note
  mode (a note is always a habit's now; a habit deleted while the screen is open closes it), `Routes.note`'s "day" and
  `TodayActions.writeNote`'s null habit, `HabitStore.dayNote` and `setDayNote`. **Saved day notes stay** (D rules): they
  load into `dayNotes`, go in every backup and the spreadsheet export ("Note for the day" rows), and come back with a
  restore; nothing deletes them.
  - **Built:** run 41040721061 (Android, commit cfd4349) passed: assembleDebug, unit tests and lint.
- **6.4 Cleanup · Groups (30 Oct).** A64: groups are gone. Most of their screens had already gone with the components
  (Today's filter and sheet, Show habits by, the form's Group, "Nothing from a group"); what was left had no way in: the
  Edit groups and group form screens (`ui/today/FilterAndGroups.kt`, routes `groups` and `group/{id}`: nothing navigated
  to them). Deleted: those screens and routes, `HabitStore.saveGroup`, `deleteGroup`, `setGroup`, `groupOf` and the
  in-memory `groups`, `HabitGroup`, `SwiftJson.groups`, `TextLimit.GROUP`, `Prefs.todayGroup` and `progressGroup`, the
  Habits tab's group filter (`ProgressBuilder`'s `groupId`, `ProgressSnapshot.group`), and the demo's three groups.
  **Saved groups stay** (D rules): the "groups" and "groups_order" settings rows are never touched, so they stay in the
  database and every backup, and nothing reads or rewrites them.
  - **Built:** run 41041552989 (Android, commit 15effcc) passed: assembleDebug, unit tests and lint.
- **6.5 Cleanup · App Lock (30 Oct).** Not in Figma and not in the first version (A27: no row opened it). Deleted:
  `app/AppLock.kt` (passcode hash, lock again, wrong-code waits), `ui/settings/PrivacyLock.kt` (Privacy & Security, App
  lock, its setup and passcode pages, the lock screen and keypad), their routes, `SettingsPage.PRIVACY`, the screen-off
  watcher, the lock in `MainActivity` (the cover, its TalkBack hiding and the Recents screenshot switch), the unit test
  `AppLockTest` and ScreensTest's `appLockWithAPasscodeLocksAndOpens`, and the `androidx.biometric` library.
  `MainActivity` is a `ComponentActivity` again (it was a `FragmentActivity` only for the fingerprint prompt). Names
  hidden outside the app now follow only the person's Hide names setting (`AppGraph.hidesNames`). No habit data was ever
  in App Lock's own file; it is left on the phone untouched.
  - **Built:** run 41042376880 (Android, commit 2749232) passed: assembleDebug, unit tests and lint.
- **6.6 Cleanup · Add screens Figma doesn't draw (30 Oct).** Figma's Day details flows (page "day details"): Mark done,
  Add a check and Undo done act in place ("A check habit: Mark done", "Several checks a day", "A week goal", "A month
  goal"); a checklist's steps are ticked "right in This day" ("A checklist: tick steps in Day details"); a task is "Mark
  it done" in place; only **Log** (an amount, time; "Log from Day details", "Log time from Day details", "An amount typed
  each time") and **Record a slip** ("Log a slip from Day details") open an Add screen. Proof in the code: every way into
  Add (`Routes.add`: Day details' Log and Log manually, Today's Log and +, Log a slip, the player's Log, the timer's Log
  manually, a widget's `log/` and `slip/`, an alarm's Log and Log time) is for an amount, time or quit habit. Deleted:
  the Add screen's Add a check, Mark a day done and Tick steps modes (`RecordKind.CHECK`, `DAY_DONE`, `STEPS`, their
  steps list, footers and discard words), and `addTitle` in `TodayRows` (read by nothing). An old link for a check, task
  or checklist closes at once. The Log screen (a saved record) is unchanged.
  - **Built:** run 41043254147 (Android, commit 333208f) passed: assembleDebug, unit tests and lint.
- **6.7 Cleanup · Day details (30 Oct).** Figma's page "day details" and its components (Log screen 687:829, All logs
  694:607, Note screen 765:1087).
  - **Milestones:** a milestone reached in Day details shows the bar over everything, the sheet too (its own window,
    TopCenter, going after its time, on See or a touch elsewhere), or the pop-up; This day's ribbon is gone
    ("Milestones from Day details: the bar / the pop-up"). `MilestoneCenter.claim` lets Day details have the bar (only
    the routine player turns it into its ribbon).
  - **The Log screen's View footers**, Figma's words: "Added by hand at 2:05 PM.", "From the timer. Started 2:09 PM." (its
    start: the end less its minutes) and, for a slip, "Your run started again from this slip."; a log from elsewhere
    keeps its line ("Logged from Today."), which Figma doesn't draw. ✕ on Entry and ← on View were already as drawn.
  - **All logs:** no footer, as Figma's screen (the rows alone): "Undo takes one back." and the "N in all" line go.
  - **Notes (A78):** Add note and Edit note show the habit only, no date and no date chip, so a note's day never changes
    (the date picker, the day switching and "… already has a note; you're changing it." go); Note (View) keeps its date.
