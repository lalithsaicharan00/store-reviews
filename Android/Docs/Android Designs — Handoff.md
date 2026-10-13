# Android Designs — Handoff

Written by Claude (Claude Code), 12 October 2026, at the user's request, so the Android design work can continue in a
new session on the user's MacBook (with the iPhone simulator). Read [Android — Start Here](<README.md>) first (decisions
A1–A14), then this page. **Every frame as an image (no Figma needed):** [Android Designs — Every Screen](<Designs/README.md>).

## Where the designs are

Figma file `Ncccsm1l2O62GJ5xLSInqk` ("Design"), page **Andriod mobile** (`1241:2`):
<https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=1241-2>. Each screen lives in a **named section**,
left to right in the order a person reaches it (the user, 12 Oct 2026: "arrange everything properly in a section").

| Section (id) | Frames (id) | State |
|---|---|---|
| **Onboarding: new to the app** (`1548:2`) | Welcome (`1548:3`); 1 of 3 · Your habit. Your goal. (`1548:46`); 2 of 3 · Quit or cut down. (`1548:177`); 3 of 3 · Tasks, once or on repeat. (`1548:296`); Your days and weeks (`1548:420`), with New day starts at open (`1550:2`, 12:00 AM to 11:00 AM, as in Day and Week) and Week starts on open (`1550:71`, Sunday to Saturday); Your first habit (`1548:456`; an idea opens the New Habit form, `1302:2`) | Built 12 Oct from the user's wireframes (`835:503`) and the built iPhone app; "What's included" removed |
| **Onboarding: coming back** (`1549:2`) | Welcome back (`1549:3`); Sign in with Google: Android's account chooser over Welcome back (`1549:38`), Google's permission screen (`1549:97`); Getting your habits (`1549:128`); Restore a backup (`1549:154`; then the restore flow, `1472:2`) | Built 12 Oct; Move from another device removed |
| **Today** (`1260:2`) | Today, light, 360 × 800 (`1350:2`, the Expressive version, which replaced `1246:2`); the day bar in four day states (`1256:6`); empty: No habits yet, the first time (`1551:3`), and Nothing planned today (`1551:195`; new: the iPhone shows a blank list, Current Work 106) | Approved 12 Oct ("let's go with this one"); the drawer and every Day details sheet show it behind them |
| **Day details** (`1260:3`) | Water, an amount (`1362:2`, replaced `1258:2`); then every other kind, left to right: Read, a time habit (`1280:3`); Read, timer running (`1294:2`); Take vitamins, a check, not done (`1294:220`) and done (`1294:432`); Stretch breaks, several a day (`1294:644`); Call family, a week goal (`1294:866`); Deep clean, a month goal (`1294:1083`); Gym, N days a week (`1294:1300`); Tidy desk, a checklist (`1294:1512`); Smoking, quit with no slips (`1296:2`) and a slip (`1296:214`); Coffee, a limit (`1296:430`); Social media, a time limit (`1296:644`); a task, not done with Reschedule (`1296:858`) and done (`1296:1080`); Read, skipped (`1296:1292`); Meditate, paused (`1296:1510`); Water, an earlier day ("Yesterday", `1296:1722`) | Water approved; the rest built 12 Oct from the built app, the user: "I already approved it … just complete them" |
| **Logs and slips: add, all, view, delete, edit** (`1261:290`) | Add log (`1261:2`), All logs (`1261:83`), Log (`1261:120`), Delete confirmation (`1261:162`), Edit log (`1261:213`); Add slip (`1297:83`), Slip (`1297:164`), Delete this slip? (`1297:209`), Edit slip (`1297:257`) | Logs built, not yet reviewed by the user; slips built 12 Oct |
| **New: choices and habit form** (`1302:2`) | New · What do you want to do? (`1566:2`); Build or maintain · How do you want to track it? (`1566:44`); New Habit forms, full length: Check it off (`1321:2`), Track an amount (`1321:125`), Time it (`1321:272`), Checklist (`1321:400`); Quit or cut down · What do you want to do? (`1566:106`); Quit (`1321:529`); Cut down (`1321:614`); Task (`1321:738`) | Built 12 Oct from the built app; forms redone in the second style (the user: "this new one is looking good"), Icon | Colour in one row; question headings stay Regular |
| **New: the form's pages** (`1563:535`) | How much (`1567:2`), Unit, full length (`1563:33`), How long (`1567:60`), Limit (`1567:31`), Steps (`1563:286`), How often, full length (`1563:328`), Time of Day (`1563:438`), Group (`1563:494`) and New group (`1567:106`), Starts (`1564:58`), Ends (`1564:322`), Colour (`1564:454`), Icon (`1564:607`), Add a 6th habit: on the phone, bottom pinned (`1569:104`), whole page (`1569:2`); Reminders is the existing `1456:91` | Built 13 Oct from the built iPhone app |
| **Menu: navigation drawer** (`1326:2`) | Drawer open over Today (`1326:3`); the same, scrolled to the end (`1326:231`) | Built 12 Oct from the built app |
| **Routine player and timer** (`1328:2`) | Player pages, one per kind and state: a check (`1344:2`); a check, done, with the Saved snackbar (`1344:57`); several a day (`1344:117`); a checklist (`1344:173`); an amount, one tap (`1333:2`); a timer running (`1344:241`); a timer, not started (`1344:297`); an amount typed each time (`1344:352`); a limit (`1344:407`); a task (`1344:463`); skipped, with its snackbar (`1344:518`); the last habit, done (`1344:582`); ⋮ menu (`1345:2`); Your routine (`1345:70`); End of the routine (`1345:183`); Timer, running (`1345:219`) | Expressive version approved 12 Oct ("this is looking good"); the first version was rejected |
| **Habit details: Progress, History, Notes** (`1373:2`) | Water · History (`1375:2`), Notes (`1375:732`), Progress (`1373:3`, the user: "looking really amazing"), ⋮ menu (`1375:1275`); History and Progress drawn full length | Built 12 Oct |
| **Progress: Week, Month, Year** (`1376:2`) | Week (`1376:3`), Month (`1376:226`), Year (`1376:496`), all full length | Built 12 Oct from the built app; **no ⋮ menu** (removed the same day, below) |
| **Settings: Times of Day** (`1437:2`) | Times of Day (`1440:2`); New time of day, defaulting to free time 4–6 AM (`1440:69`); Edit time of day · Morning (`1440:152`) | Built 12 Oct from the simulator, then made Expressive at the user's request (the terminal session's version was deleted) |
| **Settings: Day and Week** (`1449:2`) | Day and Week (`1449:3`); New day starts at, its menu open (`1449:51`) | Built 12 Oct from the built app |
| **Settings: Reminders** (`1456:2`) | Reminders with the reminder check (`1456:3`); a habit's reminders, on (`1456:91`); Get reminders on time, the exact-times sheet (`1456:164`); a reminder that didn't arrive (`1456:206`) | Built 12 Oct from the built app and decisions A11 D1–D3 |
| **Settings: Appearance** (`1458:2`) | Appearance (`1458:3`); Done habits, its menu open (`1458:85`) | Built 12 Oct from the built app |
| **Settings: Google Drive & Backup** (`1461:2`) | Not backed up (`1465:2`); backed up, free (`1465:54`); synced, Plus (`1465:123`); offline, changes waiting (`1465:192`); Delete your data from Google Drive?, the dialog (`1475:2`); Erase everything on this phone?, the dialog (`1473:27`); Restore from a backup (`1465:258`) | Rebuilt 12 Oct after the user's review ("what is this backup files only on this phone … why you're mixing backup and restore, export and import"), on the structure of the researched Backup & Export mockups (`950:309`) |
| **Restore from a backup: the flow** (`1472:2`) | Google account chooser, Android's own (`1472:3`); Google's permission screen (`1472:62`); Choose a backup, ours (`1472:93`); the system file picker, Android's own (`1472:155`); Restore, the preview and confirm, ours (`1472:207`); restored, with Undo (`1472:247`) | Built 12 Oct at the user's request ("will it be the app UI or any native UI?") |
| **Settings: Privacy & Security, App Lock** (`1474:2`) | Privacy & Security (`1474:3`); then the App lock flow in order: 1 off (`1478:2`), 2 How do you want to unlock Often Enough? (`1478:28`), 3a your phone's lock, Android's prompt confirms it (`1478:66`), 3b create an app passcode (`1478:118`), 3c confirm it (`1478:175`), 4 on (`1478:232`); later, opening the app with your phone's lock (`1478:286`) or the app passcode (`1478:317`) | Built 12 Oct; reordered the same day at the user's request ("right now its screens are juggled") |
| **Settings: Plus** (`1476:2`) | Plus, buy: on the phone, Get Plus pinned (`1544:3`), whole page (`1480:2`); Plus is yours: on the phone (`1544:106`), whole page (`1480:77`) | Rebuilt 12 Oct after the user's review: the light app icon, price first, then what you get with Plus in one list (tablet, Wear OS, Windows), plain plan rows, Plus Family, Restore purchases only where you buy |
| **Settings: Help & Feedback** (`1476:110`) | Help & Feedback (`1476:111`); a topic open (`1476:194`) | Built 12 Oct |
| **Settings: About** (`1476:264`) | About (`1476:265`) | Built 12 Oct |
| **Widgets** (`1555:2`) | On home screens: One habit 2×2 (Water +1, Meditate ▶) and Today 4×2 for a section (`1555:3`); Today 4×4 with pages (`1555:92`); This week 4×2 and Tasks 4×2 (`1555:197`); Tasks 4×4 (`1555:290`) | Built 12 Oct from the built iPhone widgets (`iOS/Shared/PhoneWidgets.swift`) and the iPhone boards (`537:2981` …); one state each, the other states to follow |
| **Widgets: adding and changing** (`1559:2`) | Android's own: touch and hold the home screen (`1559:3`), Widgets searched for "often", full length (`1559:102`), a widget tapped: Add (`1559:416`); ours: One habit, choose a habit (`1560:2`); on the home screen (`1560:89`); Android's own: touch and hold the widget, Reconfigure (`1560:178`); ours: change the habit (`1560:270`); Today, the day or one section (`1560:357`); Tasks, all or one section (`1560:459`); This week, choose a habit (`1560:533`); Today without Plus (`1560:645`) | Built 12 Oct |
| **Widgets: every state** (`1557:402`) | One habit, 30 states (`1557:2`); Today, Tasks and This week, 24 states (`1558:550`) | Built 12 Oct from the built iPhone widgets |
| **Notes: add, view, delete, edit** (`1274:2`) | Add note, empty (`1274:3`); Add note, typed (`1277:2`); Add note on a day that already has a note, from the Notes tab with the date pill (`1279:2`); Discard this note? (`1277:121`); Note (`1277:235`); Delete this note? (`1277:288`); Edit note (`1277:325`); Discard your changes to this note? (`1279:111`) | Approved, 12 Oct ("looks good"); the two variants (`1279:2`, `1279:111`) follow it |

## The reference is the built iPhone app, not Figma

**The user, 12 Oct 2026:** "take the developed app as a reference … in Figma we might have outdated designs." The
Figma iPhone, iPad and redesign frames (and `Research/…/Day Details, Logs and Notes — 7 October Redesign/Images`) can
be out of date. Before designing each Android screen, open the same screen in the built app on the iPhone simulator
and match its content, order, words and rules; change only what Android does differently. The user chose to run the
simulator on their MacBook for this (12 Oct 2026; Rulebook T1 otherwise keeps builds off it, for the battery, so keep
it on the charger). A Debug launch with no arguments adds the sample habits (T14); `-uitest` runs on its own in-memory
database (D8). `iOS/HabitsUITests/DayDetailsScreenshotUITests.swift` shows how the app's own tests reach each screen.

**Building it on the MacBook (12 Oct 2026):** the Habits scheme embeds the Watch app, so Xcode needs the **watchOS
simulator platform** installed (Xcode → Settings → Components), and the Kotlin core is built for Apple silicon only, so
pass `ARCHS=arm64`: `xcodebuild build -project Habits.xcodeproj -scheme Habits -destination 'id=<simulator>'
-derivedDataPath ../Research/Temp/ios-sim-build ARCHS=arm64`. Then `xcrun simctl launch booted com.oftenenough.app
-open-day Water` opens Water's Day details directly (`-open-add Water` its Add screen; Debug simulator builds only).
Screenshots go in `Research/Temp/android-design-shots/`.

## Decisions made while designing (the user, 12 Oct 2026)

- **Completely native Android, Material 3 (Expressive, as on Android 16); the ideas exactly the iPhone's.** "Our app
  should feel like an official material design app … the overall ideas … we will keep what we have exactly in the
  iPhone."
- **Light only in Figma.** No dark versions were drawn: native components make dark mode automatic ("it's not a
  custom design … we are using native things"). **The app still needs dark mode** (the user, 13 Oct 2026): built from
  Material 3's dark roles, with an old dark design (`194:10`) as colour inspiration only ([every screen](<Designs/README.md>)).
- **Small screen first:** 360 × 800 (status bar 36, gesture navigation 24 at the bottom, a camera hole).
- **Today's top app bar: ≡ · Edit (pencil) · Filter · +**, no title. + is in the top bar, **not a floating action
  button** (the FAB beside the day bar was rejected: "not looking good").
- **The day bar is Material's floating toolbar** (`HorizontalFloatingToolbar`, version B, chosen over a docked
  full-width bar), at Google's standard size from the component's code: **64 high, fully rounded, 8 padding at the
  ends, 4 between items, 48 × 48 arrows, 16 above the gesture area**; 320 wide; white with a hairline edge and a
  shadow (Google's default is grey with no shadow: kept white because the user wanted it "easily noticeable"); a soft
  fade behind it (Android's gradient protection).
- **The day bar's width never changes** when the day changes (the user: "the layout shift … looks ugly"); ‹ and ›
  stay at its ends. **Corrected 12 Oct (the user):** "no layout shift" means the width only: the ring, the day name ▾
  and the count sit **together as one group, centred**, 8 apart, and may move a little as the text changes ("Today",
  "Yesterday", "Wed, 30 Sep"; "4/13"). The earlier version, with the three spread to fixed slots across 200, looked
  wrong. Applied to every day bar on the page.
- **Cards are Android 16's segmented lists:** each row its own white piece, 2 apart, outer corners 24 (were 20), inner
  4, on a `#F0F0F3` background, 16 from the screen's sides, 16 between cards (were 12).
- **Rows:** 72 high (Material's two-line item); a round 40 habit icon in the habit's colour (round, not the iPhone's
  rounded square); name 16 / line 14; streak with a filled flame; a 40 round button (tonal grey, or filled in the
  habit's colour when the goal is met); the progress fill in a light tint of the habit's colour.
- **Section headers:** name 16 Medium, "Starts 6 AM" 12; **"N left" as a grey badge** (12 Medium, corners 12); ▶ Start
  (filled ink for the Now section, tonal grey otherwise); ⌃/⌄. Folded: **the habit icons as an overlapping stack** (28,
  a white ring, 6 overlapping) ending in a "+N" disc. **Outer corners 24, 16 between sections** (Expressive version,
  12 Oct). **Every section, the current one included, is the same white pieces on the grey screen.** Tried and rejected
  the same day: the current section in a grey container (its grey dulled the progress fills), an ink outline ("really
  ugly"), a deeper grey, a dark container, and a white screen with grey cards or grey section containers. The current
  section is marked only by its filled ▶ Start.
- **Day details is a modal bottom sheet** (drag handle, corners 28) with **✕ at the start, the title, ⋮ at the end**
  (Android's placement); the iPhone's content (habit ›, This day card with +1 | Log manually and the note, Today's logs
  with at most three rows, Skip today last and outlined).
- **Add / Edit screens:** ✕ and a one-line title; Habit, Date, Time as segmented rows with tonal pill buttons that
  open Android's date and time pickers; the amount large in its own card; the filled main button full width just
  above the keyboard (drawn as Gboard's number pad). **Log view:** ← back, **Delete log (red text on grey) | Edit
  (filled)** at the bottom. **Delete** asks in Material's dialog (Cancel, Delete log in red).
- **Notes** (12 Oct, from the built app): no habit card; one line under the title, the round 24 habit icon, the name
  (16 Medium) and the day ("Today, 12 Oct", 14, secondary), lined up with the text inside the box (32 from the edge);
  the note in a white card (corners 20, Roboto 16/24, "Write a note"); Save full width 12 above the keyboard, **off
  (Material's disabled filled button: ink at 12 %, label at 38 %) until something is typed**, as on the iPhone; Gboard's
  letter keyboard (capitals at the start of a note, Enter as the dark new-line key). **Edit note has ✕ only**, never ‹
  and ✕ (the iPhone showed both once: Current Work 104). The keyboard closes when a dialog opens. **Dialog and button
  words are sentence case on Android** ("Keep writing", "Discard changes", "Delete note"; the iPhone's alerts say "Keep
  Writing", "Delete Note"), as Material writes them and as "Delete this log?" already did.
- **Day details, Expressive version** (the user, 12 Oct; applied to all 19 sheets): the habit card's icon in the
  **cookie shape**; **This day** with corners 28, padding 18 / 20, and **the count and its second line on one row,
  baseline-aligned** (the user's own edit): a number in the status becomes the large count ("**4** of 8 glasses", 44),
  a short second line sits at the row's right ("4 glasses to go", "8 min to go", "One step left"), a long one stays on
  its own line below ("Timer running · 0:03", "Paused days don't count toward your streak"); a status with no number
  stays 28 Medium ("Not done", "Skipped"). **The wavy progress bar only where there's progress toward a goal**
  (amounts, time, several a day, week and month goals, checklists), never on checks, limits, quits, tasks, skipped or
  paused days. Logging buttons 52 high, equal; the note row has a leading `sticky_note_2`; list corners 24; 12 between
  blocks. **The sheet stays as compact as before:** the day title and the habit card stay (the title changes to a date
  on other days; the user rejected moving the habit into the title), and Skip today ends no lower than it did (753 on
  Water; every other sheet ends higher).
- **Day details, every kind** (12 Oct, from the built app's `DayDetailsFixture`, `-uitest -day-details-fixture
  -open-day <name>`): the words and buttons are the iPhone's. Emphasis follows U16: a positive goal action is filled
  (Mark done, +1, Add a check, Start timer, Resume habit); a limit's +1 / Start timer and a quit's Record a slip are
  tonal; Undo done is tonal. Quit, limit and task sheets have no Skip (as on the iPhone). Several checks a day list
  "Checks today", each row with its own **Undo** text button. A checklist's steps are **Material checkboxes** (square,
  18, ticked in the habit's colour), not the iPhone's circles. Reschedule rows carry a leading icon (`redo`,
  `calendar_month`). **Skipped: both logging buttons stay visible and switched off** (U15; the iPhone left "Stop and
  save" on when a running timer's day was skipped). An earlier day is titled "Yesterday" and ends with "Skip this day".
- **New (+) and the habit form** (12 Oct, from the built app): the iPhone's words, order and examples. The first step
  closes with ✕ (not "Cancel"), later steps go back with ←. Choice rows are segmented pieces with Material Symbols
  (`trending_up`, `trending_down`, `calendar_month`, `check_circle`, `tag`, `timer`, `assignment`, `block`, `speed`).
  **The form, second version (the user, 12 Oct: the first, with outlined fields straight on the grey and no chevrons,
  "is not looking good … take inspiration from … Google apps"):** **Add is a filled pill button** at the end of the
  top app bar, off until there's a name (Google Calendar's Save); "Preview" with the Today row as it will look; then
  **one card holding the name, the description and Icon | Colour**: the name a **large borderless field** (22, "Name,
  e.g. Make bed", like Calendar's "Add title" and Keep's "Title"), the description with a leading `notes` icon, and
  **Icon | Colour as one compact row of two connected pieces**, each with its own chevron (the user: "they are
  important but … not as important as how often"); **every settings row has a leading Material Symbol, the value under
  the title and a trailing chevron** when it opens a page (Compose `SegmentedListItem`: leading icon, supporting text,
  trailing icon); a row that sets its value in place ends with that control instead (Date / Started pills, Time switch).
  "When you tap +" as radio rows, "Each tap adds" in a small filled field. Icons: `event_repeat` How often, `tag` How
  much, `timer` How long, `checklist` Steps, `speed` Limit, `history` Started, `repeat` Repeat, `calendar_today` Date,
  `schedule` Time / Time of Day, `folder` Group, `notifications` Reminders, `event` Starts, `event_busy` Ends.
- **The ≡ menu is Material 3's modal navigation drawer** (12 Oct, the iPhone's items and groups): a sheet 304 wide
  (the screen less 56, so Today shows at the edge), end corners 16, over a 32 % scrim; the app's name as the small
  headline; items 56 high with pill-shaped selection (Today selected, its icon filled), Material Symbols, 14 Medium
  labels, counts at the end (Habits 15, Tasks 3); the iPhone's five groups split by dividers. **"iCloud & Backup" is
  "Google Drive & Backup" on Android**; Privacy & Security uses `shield` (Android's own Security icon) instead of the
  iPhone's hand. Thirteen items at Material's 56 don't fit 800, so the drawer scrolls (both ends drawn); its content
  stays below the status bar, as Compose's `ModalDrawerSheet` pads for the system bars.
- **Routine player and timer, Material 3 Expressive version** (12 Oct; the user rejected the first, a ring with a
  "‹ Day details ›" toolbar: "not looking good … the day details … creating very ugly thing"). The iPhone's words,
  order and one main action per kind; the look from Expressive's tactics (Google Design's research: containment, bold
  shape and colour, larger key actions; Clock's giant buttons): a top app bar with ✕, **title "Anytime ▾" and a
  subtitle "Habit 4 of 12"** (opens Your routine) and ⋮; thin routine segments; **one large white hero card** (corners
  32) holding the habit's icon in Material's **cookie shape** (9-sided scallop) in its colour, the name (32), **a "📅
  Today ›" chip that opens Day details** (also first in ⋮), a display-size count ("2 of 8 glasses") and Expressive's
  **wavy progress bar** in the habit's colour; at the bottom **a button group, 96 high: ‹ (tonal) · the main action
  (ink) · › (tonal)**, like media controls. **No "Day details" toolbar.** Main action per kind, as the iPhone: Mark
  done (a check, a task), Log one (several a day), Log 1 glass (one tap), Log amount (typed each time), Start / Pause
  (time), Log 1 cup (a limit), none for a checklist (its steps sit in the card and ‹ › share the row), Next / Finish
  routine once done or skipped. **The iPhone's "Saved · Undo · Add Note" banner is Material's snackbar** (dark, corners
  4, Undo and Add note as its actions). ⋮: Day details, View routine, Go to first unfinished, End routine. Your routine
  is a modal bottom sheet (Edit, ✓ for done, ▶ for the current one). The end page is the same card (the cookie in ink),
  with Return to unfinished (tonal) and Done (large, ink). The timer: ⌄ to put it away, the same card, and a button
  group of Log manually (tonal) and Pause (ink).
- **Long labels and long checklists in the player** (the user, 12 Oct: "in real world scenario this is not going to
  work"). **‹ and › are 56 wide** (still well over 48), the main button takes the rest, its label 18 Medium. **When a
  label doesn't fit beside its icon, the icon moves above it and the label may wrap to a second line** (withdrawn, see below) inside the
  96-high button. **Corrected the same day (the user): the main button's label stays on one line, its icon beside it,
  and a long label ends in an ellipsis** ("Log 2.5 kilom…", `1347:2`), so the button group keeps its sizes and
  spacing; TalkBack reads the whole label. (The icon-above, two-line version is withdrawn.) **A checklist with many steps**
  (`1347:57`): the header turns compact (a 64 cookie beside the name and the day chip), then the count and the wavy
  bar, and **the steps scroll inside the card** with a fade and a scroll indicator at the bottom showing there's more.
- **Habit details** (12 Oct, from the built app; the iPhone opens on History): **a large top app bar** whose title is
  the habit (the cookie icon, "Water" 28, the goal as its subtitle; it collapses to a small bar on scroll; this also
  avoids the iPhone's doubled "Water", Current Work 95); **Material primary tabs** History · Notes · Progress, pinned,
  with an ink indicator under the selected label. History: Add log and Go to date as tonal buttons; What the squares
  mean collapsed; each month a segmented group (header "October 2026 / Reached on 12 of 12 days so far" ⌃, then a row
  per day: the day's square, "Mon 12 Today", "8/8 glasses · 8 logs" (**logs, not the iPhone's "entries"**), a note icon
  when there's a note, ›). Notes: a Material search bar, Add note, notes grouped by month with the text wrapping.
  Progress: the iPhone's cards in order (Overall record with four tiles, the current streak's tinted; Milestones with
  **cookie badges** and **circular progress** for Next; Week, Month with its bar chart, Year in Pixels), each with
  ‹ › icon buttons where the iPhone has them. The today square has an outside ring (its rows must not clip it). ⋮:
  Edit habit, Pause…, Archive, then Delete in red.
- **Progress** (12 Oct, from the built app): a drawer destination, so its top app bar leads with **≡**, not ← (back
  goes to Today); title "Progress", ⋮. **Week · Month · Year as a Material connected button group** (selected: ink with
  a check, others tonal; outer corners 20, inner 8). The period navigator "‹ 11–17 Oct / This week ›" (› off on the
  current period). What the squares mean, collapsed. **One card per habit in the iPhone's order and words**: the
  habit's cookie icon, name and goal, › to Habit details; the summary ("Reached on 2 of 2 days so far" / "16 glasses
  this week"; "1 of 3 this week" / "2 to go · 6 days left"; "Met 4 of 6 weeks so far"; "Every step on 2 of 2 days so
  far"); then the period's squares: the week's seven, the month's calendar, or the year's weekday × week grid aligned to
  the latest week. Square states: done (the habit's colour, ✓), part (its colour at 50 %), not done (grey ✗), not
  scheduled (dashed outline), still to come (grey); today has an outside ink ring. **No ⋮ menu** (the user, 12 Oct:
  "overall, we don't need these options … we will get to know from users"): the iPhone's Show Percentages, Show Streaks
  and Full Day are dropped. Checked first: Full day is ledger C201 (Strong, 4 apps) and percentages had one direct ask;
  hiding streaks is part of C157 (Certain) and C207 (Certain), but Progress shows no streaks, so its switch did nothing
  here. If people ask to hide streaks, it returns in Appearance (Current Work 96).
- **Times of Day** (12 Oct, from the built app, made Expressive at the user's request): rows with the name, the times
  as supporting text and ›; **no icons** (a time of day has no icon to choose) and **no coloured day timeline** (tried
  and removed the same day, the user: "user can't set a coloring here … make it clean and simple"). **Add time of day
  is an extended FAB** (ink, corners 16, bottom right; Clock adds alarms this way), not the iPhone's last row. New /
  Edit: ✕, the large borderless name, **Starts | Ends as two big time tiles** (36, like Clock) that open the time
  picker, the iPhone's footer, then the iPhone's **Your day rows** with plain **New / Changed / No change** badges ("Was
  6:00 PM – 12:00 AM" on its own line when a split happens); Edit ends with Delete time of day (red on grey, 56) and
  shows the time of day's real end (the iPhone shows start + 1 h: Current Work 97). **A new time of day opens in free
  time and splits nothing** (the user: no "randomly new timings"): with the standard set, 4:00–6:00 AM, just before
  Morning; the rule, shared with the iPhone, is Current Work 98.
- **Day and Week** (12 Oct, from the built app): two **dropdown rows** (Material's exposed dropdown menu: leading icon,
  title, the value as supporting text, ▾; it opens a menu with ✓ on the chosen value, scrolling when long): **New day
  starts at** as exact times (**12:00 AM**, 1:00 AM … 12:00 PM; **never "Midnight"**, the user: "user has to click on
  it, see what is midnight") and **Week starts on** (the seven weekdays, **default Sunday, no "Automatic"**), each with
  the iPhone's footer, minus "Automatic follows your region" (Current Work 99, the same fix on the iPhone). The **Clock** group keeps its two notes as quiet rows (14, grey, an icon each): "Times follow your
  phone's 24-hour time setting, in Settings › System › Date & time" (Android's path, not General › Date & Time) and the
  daylight-saving note. Sentence case: "New day starts at", "Week starts on".
- **Reminders** (12 Oct; the iPhone's page plus decisions A11 D1–D3): the iPhone's "On This iPhone" group becomes a
  **Reminder check** card (D2): Notifications, **Exact times** and **Battery**, each with its state in words and either a
  ✓ or one ink button that opens that setting ("Allow", "Fix"); exact times off says "reminders may come up to 10
  minutes late" (D1). Then the iPhone's **With reminders** (each habit's times, Notification / Alarm, "Again every 15
  min") and **Without reminders** groups, habits with their cookie icons. **A habit's reminders**: "Remind me" switch
  (Material switch, on = ink with a ✓ thumb; the chrome stays monochrome, U2), the times as removable rows with time
  pills, Add another reminder, **Remind me with** (A notification / An alarm, D3) and **If not done, remind again**
  (Never / Every 15 min / 30 min / hour) as dropdowns, the iPhone's outcome sentence, Reminder says. **Exact times are
  asked for in context** (D1): after notifications are allowed for the first reminder, a bottom sheet "Get reminders on
  time" explains in two sentences and opens Alarms & reminders ("Allow exact times" / "Not now"); never at first launch.
  **A reminder that didn't arrive** (D2) shows **once**, at the top of Reminders: what happened in plain words, that
  phone maker's reason, "Show me how" and "Dismiss"; it never blames the person, and the check below shows what to fix.
  Never a direct battery-exemption request (Play policy).
- **Appearance** (12 Oct, the iPhone's groups and footers): **Theme as a connected button group** Light · Dark ·
  **System default** (Android's own word for following the phone; the iPhone says "Automatic"), the chosen one ink with
  a ✓; Today's **Done habits** as a dropdown (Move to bottom / Stay in place); **When you tick**: **Vibration** (Android's
  word for the iPhone's "Haptics") and Sound when done, the chime "follows your phone's sound mode"; **Timers**: Open
  timer full screen and **Show in notifications** (the iPhone's "Show on Lock Screen"; on Android a running timer is a
  Live Update in the notifications, lock screen and status bar, A11 D4). Switches on are ink with a ✓ thumb. **A
  connected button group's buttons keep at least 16 of padding at each side and take their width from their labels**
  (the spare width shared equally), so a long label like "System default" never touches the edges (the user, 12 Oct).
- **Google Drive & Backup** (12 Oct; the iPhone's iCloud & Backup with Google Drive in iCloud's place, A4/A10;
  **rebuilt the same day** on the structure of the researched Backup & Export mockups, `950:309`, after the user found
  the first version confusing). The page answers three questions, in order: **is my data safe?** (one status card),
  **how do I get it back?** (**Restore**) and **how do I take it out?** (**Export**). The status card (corners 28, a 56
  icon disc, ink when backed up or synced; title; when · where; one line of why; actions that share the row equally) has
  four states: **Not backed up** ("Your habits are only on this phone", Back up to Google Drive, the promise that we never
  see the habits, D16); **Backed up** (free: "Today 9:14 AM · Google Drive (sam@gmail.com)", D4's rhythm in one sentence,
  Back up now / Change account); **Synced** (Plus: Sync now / Change account); **No internet** (A6: "3 changes waiting to
  sync", "Everything works offline …", Try again; never blaming the person). **Devices** (kept, the user liked it): this
  phone and the others with when each last synced; on the free plan, this phone plus "Use on more devices … with Plus".
  **Restore**: one row, *Restore from a backup* ›, which asks **"Where is your backup?"**: Google Drive ("Any day of the
  last week, month or six months") or **A backup file** (this is where importing lives; there's no separate Import
  row), "Restoring replaces the habits on this phone. You can undo it for 30 days" (D5). **Export**: Save a backup file
  ("To restore later, here or on another device") and Export a spreadsheet (CSV). **Last, a red group** (kept from the
  iPhone and its research; the user: "if we need to have erase … add it back"): **Delete my data from Google Drive…**
  (when connected) and **Erase all my data…**, each asking in Material's dialog first (the iPhone's words): Delete asks
  "Delete your data from Google Drive?" with Save a backup file first / Delete from Google Drive / Delete from Google
  Drive and this phone / Cancel; Erase asks with Save a backup file first / Erase everything (red) / Cancel; it's the only way to clear the app's hidden copy in Drive, which uninstalling leaves
  behind. **Gone:** "Backup files: only on this phone", a separate Import row, and Move to another device (removed by the
  user). Example accounts are generic.
- **Restore: which screens are ours and which are Android's** (12 Oct). Backups live in Drive's private **app data
  folder** (`drive.appdata`, A4), which Google hides from the Drive app and drive.google.com, so **Restore from Google
  Drive is our own UI**: "Google Drive" lists the backups by device ("Pixel 9 · this phone", "Pixel Tablet") and day
  (Today 9:14 AM, Yesterday, a week, a month, six months back), each with "12 habits, 840 logs". **Native, drawn as
  Android shows them:** Android's **Google account chooser** sheet ("Choose an account · to continue to Often Enough",
  only if no account is connected yet) and **Google's permission screen** for the Drive app-data scope; and for **A
  backup file**, Android's **system file picker** (Storage Access Framework: Recent / Downloads / Drive). Both routes then
  share our **Restore** preview (D5): "12 habits, 840 logs · From "Pixel 9", 12 Oct 2026, 9:14 AM", "On this phone now",
  **Replace what's on this phone** (ink) and **Merge** (tonal), each with what it will change, and "You can undo a restore
  for 30 days"; after it, a snackbar "Restored: 12 habits, 840 logs · Undo" and an **Undo last restore** row (until the
  30 days end). Android says **logs** where the iPhone's restore says "check-ins" (Current Work 95).
- **Privacy & Security and App lock** (12 Oct, the iPhone's page and App Lock decisions 1–4): App lock › (Off); **Outside
  the app**: Hide names outside the app ("Widgets, reminders, alarms and Google Assistant show icons and numbers");
  **Help improve the app**: Share usage, Share crash diagnostics (off and dimmed, "Not available yet"); the closing line
  **"No ads. No account. Your habits stay on your phone and in your own Google Drive; we never see them."** (D16; the
  iPhone still says "An account is optional": Current Work 101). **The iPhone's Face ID and iPhone passcode become one
  choice on Android, "Your phone's lock"** ("Fingerprint, face, PIN or pattern: whatever unlocks this phone. Android
  chooses which to show"): Android's BiometricPrompt doesn't let an app pick fingerprint or face, it uses what the person
  set up, with the screen lock as the fallback, so there's no second question. The other choice is **An app passcode**
  (six digits). **The flow, in order** (the user, 12 Oct): App lock off → switch on → **"How do you want to unlock Often
  Enough?"** (two radio rows, Continue) → your phone's lock: **Android's prompt once, "Confirm it's you"**, to check it
  works; or an app passcode: **Create an app passcode** → **Enter it again** → **App lock, on** (the switch, **Unlock
  with**, **Lock again** Immediately / After 1 minute / After 15 minutes, "Locking your phone always locks the app at
  once"). Later, opening the app: a white cover with the ink cookie lock, "Often Enough is locked", under Android's
  prompt "Unlock Often Enough"; or the app passcode screen (six dots, round keys, Forgot app passcode? → the 24-hour
  reset, App Lock decision 2).
- **Plus** (rebuilt 12 Oct after the user's reviews): **the light app icon** (Figma `1160:161`: the tonal three-tile
  mark on white, app-icon corners; the user, after a gold logo and a gold tile were tried: "let's use this logo
  itself … since we are in the light mode"). **The price comes first, what Plus adds second** (the user: "what is the
  price, that is the most important thing, and what it unlocks is the second"). Buy, top to bottom: a **left-aligned
  header** (the icon at 64 px beside "Plus" / "One payment, yours forever."; the user: "the header … left aligned, I
  really liked it"); the **free-habits card** ("3 of 5 free habits used · 2 left" with a linear bar; the user: "that
  limit was amazing, let's add it back"); the **plan rows**, one segmented list, no outline: Plus · Just you · $24.99 ·
  one-time and **Plus Family** · You + 5 people, each with their own habits · $59.99 · one-time, the chosen one with a
  filled radio on the neutral tone `#E6E6EA` (U2); then **What you get with Plus, one list** of two-line rows (a tonal
  round icon, a title, one line; the user: "let's combine everything together … what you will get in the Plus"):
  Unlimited habits (Free has 5. Add as many as you like.), More widgets (Today's list and This week, A13), Tablet,
  Wear OS watch, Windows app (A14), **Synced through Google Drive** (never "your own Google Drive": the user, "syncing
  through Google Drive, that's it"). Pinned at the bottom on the page's background: **Get Plus · $24.99** and a
  full-width tonal **Restore purchases** (no "One-time, no subscription" line). The first screen (360 × 800) shows the
  price, both plans and the button. **Restore purchases lives only on the buy screen** (the user: "when the Plus is
  already yours, why do we need a restore purchase there?"). Owned: the same left-aligned header ("Plus is yours / Yours forever"; the user: "to make consistent … make it left alignment"),
  **What you have with Plus** (the same list), "Nothing to sign in to: Plus comes with your Google account, on every
  phone, tablet and computer signed in to it", a **Plus Family** card with the sum (Plus Family $59.99 · You paid for
  Plus −$24.99 · **You pay $35.00**) and **Upgrade for $35.00**, then Contact us. The iPhone's matching changes are
  Current Work 103.
- **Onboarding** (12 Oct, from the user's wireframes `835:503` and the built iPhone app; the user handed it over:
  "we do need some changes in the onboarding since we have removed some things"). Two sections above Today, in the
  order a person meets them. **New:** the Welcome (**our light app icon**, the user: "in the first screen use our app
  logo"; Often Enough; "Habits grow through repetition. You choose how often is enough."; "Have you used Often Enough
  before?" with two rows, I'm new here / I've used it before, and Privacy & optional usage sharing); **"What's included"
  (the free plan) is gone** (the user: "let's remove that screen"); the three pages with a page indicator, Skip setup
  and Continue, each showing Today's real rows, one card with Today's corners (round top on the header, round bottom on the last
  row only) (an amount, a check, a timer, steps; Smoking's run, Coffee's limit,
  Social media's time limit; three tasks and Unlimited tasks); Your days and weeks (Day and Week's own two rows: 12:00
  AM and Sunday, never Midnight or Automatic, Current Work 99; each opens the same exposed-dropdown menu as Day and
  Week, the chosen value ticked); Your first habit (eight ideas, Create my own habit
  pinned). **Coming back:** Welcome back with **Sign in with Google** (your habits come back from Google Drive; Android's
  account chooser, Google's permission screen, then Getting your habits with an Expressive loading indicator and a
  count) and **Restore a backup** (Google Drive or a backup file, then the restore flow); Start without restoring.
  **Move from another device is gone** (A12: a transfer is built last). Not drawn yet: "We found data on this device"
  (when Android's own Auto Backup has already brought the database back).
  The iPhone's matching changes: Current Work 105.
- **Today, empty** (12 Oct). **No habits yet** (after Skip setup, Start without restoring, or deleting the last
  habit): only ≡ and + in the top bar (Edit and Filter have nothing to act on), no day bar; an Expressive cookie shape
  with the checklist symbol, "No habits yet", "Add something you'd like to do often enough, or start from an idea.",
  then **New habit** (filled), **Start from an idea** (tonal), and Restore from a backup and How it works as text
  buttons: the iPhone's four ways out, never a dead end. **Nothing planned today** (habits exist, none on this day):
  the normal top bar and day bar (an empty ring, no count), "Nothing planned today", "Your habits are planned for other
  days. Each one shows on its own days.", and New habit (tonal); neutral, never "missed" or "no habits due" (U3).
- **Widgets** (12 Oct; the user: "fixed sizes, similar to iPhone, but widgets should look good"). The kinds the iPhone
  has built, with A13's free and Plus: **One habit** (2×2, free), **Today** (4×2 for the day or one section, 4×4 with
  ‹ 1/2 › pages above five; Plus), **Tasks** (4×2, 4×4; free), **This week** (4×2, one habit; Plus). **Fixed sizes, no
  resizing in the first version** (`resizeMode="none"`, min = max): 2×2 156 × 176, 4×2 328 × 176, 4×4 328 × 368 on a
  360-wide phone, inside Google's Pixel ranges (2×2: 109–306 × 115–276; 4×2: 245–624 × 115–276; the 4×4 follows the
  cell formula, 118 × 4 − 16 = 456 at most; [Widget sizing](https://developer.android.com/design/ui/mobile/guides/widgets/sizing),
  [Layouts](https://developer.android.com/develop/ui/views/appwidgets/layouts)). **Corners: 28 dp**, the most
  `system_app_widget_background_radius` ever is, and **12 dp inside** (28 − the 16 dp padding, Google's rule:
  [Glance](https://developer.android.com/develop/ui/compose/glance/create-app-widget)). **Touch targets 48 dp** (Google's
  widget layouts guide), the visible button 36–44 dp inside it. White surface, our ink and the habits' colours (no
  wallpaper colours, A11 D5); the habit icons are the Android app's filled circles, not the iPhone's bare symbols (kept, the user, 12 Oct: "keep the filled circle icons"; widgets can't animate, so no shape morphing there). The
  same contents as the iPhone: a row is icon, name, "Section · 3 of 8 glasses", 🔥 streak and the round button
  (✓, +1, ▶, ↗ for steps), filling toward its goal (U25), done in the habit's colour (U2); the header names the list
  and "2 of 5 done". This week: the habit card, today's value, a bar, and the week's seven squares from Sunday (Current
  Work 99). **No lock-screen widgets in the first version** (on Android they are new and only on some devices; check what Pixel and Samsung phones allow before designing any; the iPhone's three stay iPhone-only for now).
  Taps follow the locked rules (U26/U28): the whole card changes at once, the app saves behind.
- **Adding and changing a widget** (12 Oct; the user: "native to Android, how in Android it allows to change the
  habit, to select a specific section"). Android's own steps: touch and hold the home screen → **Widgets** → search
  "often" → Often Enough's six widgets with previews, size and one line each ("With Plus" on Today and This week) → tap
  one → **Add**. Then **our setup screen** (Android's widget configuration activity), the same shape for every widget:
  ✕ and the widget's name, a live preview on a wallpaper-coloured card, **Show** with one choice (radio rows), and a
  full-width **Add widget**. One habit and This week: choose a habit (icon, name, "Anytime · 8 glasses a day"). Today:
  **All of today, or one section** (Morning, Afternoon, Evening, Anytime, Quit or cut down, each with its start and
  how many), **text only, no icons**: times of day have no icons and people can't give them one (the user, 12 Oct). Tasks: all of today's tasks, or one section. **Changing it later** is Android's own Reconfigure: touch and
  hold the widget, the pencil, and the same screen with **Save** (`android:widgetFeatures="reconfigurable"`; the
  setup is also optional, `configuration_optional`, so a widget never sits empty: a new One habit shows "Choose a
  habit · Tap to choose", which opens the same screen). **Adding a Plus widget without Plus** never blocks: the screen
  says what Plus adds and what the widget does without it ("shows how many are done and opens Today"), with **Get
  Plus · $24.99** and **Add without Plus**; on the home screen it shows the day's count, "Tick habits off here with
  Plus" and Open Today (Current Work 93: never blank, never a paywall on a tap). The launcher's own screens (the
  menu, the picker, Add, the pencil) differ between Pixel and Samsung: check both on the phones (A11 D12).
- **Every widget state** (12 Oct, from the built iPhone widgets): One habit in 30 states (a check, done, several a day,
  an amount and past it, typed each time, a saved step, a timer ready and running, a checklist and done, quit's run,
  after a slip and a new best, a limit under, reached and over (a neutral grey, never red, U3/U25), a time limit, a
  week and a month goal, skipped, paused, not planned today (its days instead), a long name; and Choose a habit, Habit
  removed, No habits yet, Content hidden, Open to update, Couldn't save). Today and Tasks: one section with a timer
  running, quit and limits, all done, names hidden (Hide names outside the app), nothing planned (for today, or in a
  section), section unavailable, no habits, hidden, open to update, without Plus, the 4×4's page 2 of 2, no tasks
  today, "2 tasks left" with names hidden. This week: done today, quit, cut down, a week goal (its off days dashed),
  choose a habit, hidden, open to update, without Plus.
- **The New choices** (redone 13 Oct in Material 3 Expressive, then calmed the same day after the user's review):
  New, Build or maintain, and Quit or cut down. **One heading only**: the top bar keeps ✕ or ← and no title, so the
  28 sp question is the page's title (a title in the bar above it competed). One card per choice: the icon in **the
  same cookie shape every time** (56 dp, tonal grey; the user: mixed shapes, especially the small four-point one,
  looked uneven), the name at **16 sp Regular** (never heavier than the heading), one line, a short example chip that
  always fits ("e.g. Smoking", "e.g. Coffee, 2 a day"), and ›; the same padding (16) and gaps (4) on every card.
- **The habit form's pages** (13 Oct, from the built iPhone app). Each row of New Habit opens its own page, in
  Android's way: a top app bar with ← and the row's name, and the goal so far in a small chip ("8 glasses every
  day", "Every Mon, Wed and Fri"), so the page always says what it changes; going back keeps the choice (no Save).
  **How much / Limit** (redone 13 Oct in Material 3 Expressive, the user: "use material design expressive"): one
  white card with the period ("Every day", "At most, every day"), a big number (57 sp) in a tonal box between round
  − and + buttons, and the unit as a chip with ▾ that opens Unit. **Unit**: Create your own unit, No unit, then the iPhone's groups (Drinking, Walking and
  running, Reading and writing, Exercise, Everyday, Money; a limit adds Cutting down first), radio rows. **How long**: the same card, hours : minutes in two big boxes (the one being typed outlined) and quick picks as
  filter chips (5, 10, 15, 20, 30, 45 min, 1 h). **Steps**: one row per step with a drag handle and ✕, Add step, "Up to 24
  letters a step". **How often**: radio rows grouped as on the iPhone (In total; A number of days; Days of the week;
  Every few days, weeks or months; On a date); the chosen one opens its controls in place (Days of the week: Weekdays
  / Weekends chips and seven round day buttons from Sunday). **Time of Day**: "Pick one or more" checkboxes (Morning,
  Afternoon, Evening with their times, no icons) or Anytime, and New time of day. **Group**: None and the groups, New
  group (a dialog with a folder icon, "Put habits together, then filter Today and Progress by group.", Name, 6/24,
  Cancel / Add). **Starts**: Material's date picker dialog titled Starts, with "A
  start date in the past lets you tick the days since then." **Ends**: a menu on the row (Never ✓, On a date…),
  opening upward when there's no room below. **Colour**: a bottom sheet of the 13 habit colours, the chosen one
  ringed. **Icon**: a full page with a search bar and the iPhone's groups (Health, Fitness, Mind, …) on white tiles,
  the chosen one filled in the habit's colour, and Done. **Add a 6th habit**: **contextual, as on the iPhone** (the user, 13 Oct: "it
  is showing the context … not just random upgrade"), **built from the approved Plus page** (redone 13 Oct after
  "looking very ugly"): ✕; the left-aligned "Add a 6th habit" and "You're using all 5 free habits. Plus makes room for
  as many as you like."; one white card with the person's five habits in their colours and the sixth as a filled ink
  + at the end, "5 of 5 free habits used · Plus: no limit" and a full bar; then the Plus page's own plan rows and its
  What you get with Plus list; pinned: Get Plus · $24.99, a tonal **Make room instead** (archive or delete one) and
  its one-line explanation. Not drawn yet: Make room's list, a task's Repeat, a quit habit's Started picker.
- **Help & Feedback and About** (12 Oct, the iPhone's words): Help has a Material search bar at the top (the iPhone has
  it at the bottom), Contact us, Show the welcome again, the iPhone's footer, then the topics grouped as on the iPhone,
  each an **expanding row** (▾ opens the answer in place). Answers name today's controls and say "log" (the iPhone's
  still name retired ones: Current Work 102). **About**: the logo (the transparent light tonal mark, `1166:17`, 96 px, straight on the white card: the Logo Guide's "simple matching surface", so no tile and no outline; the user, 12 Oct: "use our app logo"), name and version in one card, The name, Privacy
  (with Google Drive), Acknowledgements and Android's standard **Open source licences** ›.
- **Headings are Medium, the top-bar title stays Regular** (the user, 12 Oct: "if it is the default thing, let's keep
  it … if it is a design choice then … at least make it medium"). Checked in Compose Material 3's `TypeScaleTokens.kt`:
  Headline/Title Large are `WeightRegular` by default, and Material 3 Expressive adds **Emphasized** versions at
  `WeightMedium` (`HeadlineSmallEmphasized`, `TitleLargeEmphasized`). **Day details' status** ("12 of 20 min", 28) uses
  the emphasized style, **Roboto Medium**. **A screen's question heading** ("What do you want to do?", 24) was tried in
  Medium and **reverted to Regular** (the user: "it is creating some sort of imbalance … in the day details, it is
  okay"; to be judged again in the app on the phone). The small top app bar's title (22, Title Large) stays Regular,
  Material's default.
- **Type and icons:** Roboto (Regular, Medium); Material Symbols Rounded for outline chrome icons, Material Icons Round
  for filled ones (habit icons, the flame, ▶ ✓ + in round buttons). Ink `#1C1B1F`, secondary text `#5E5E62`, tonal
  `#ECECEF`/`#E6E6EA`, error red `#B3261E`. Chrome stays black, white and grey; colour is for habits (U2, decision A11's
  D5: no wallpaper colours).

## How we work on these (the user's standing preferences)

- Design **one** screen, show it, get approval, then the variants (one example first).
- Every screen goes into its own named section on the page; nothing loose on the canvas, no explanatory labels on it.
- Settle layout questions from the native platform's own patterns (Google's apps, Material docs, the Compose
  component's defaults) and say which; check Google's documentation when a size or pattern is questioned ("is it a
  standard pattern or something we are creating?").
- Before using the Figma tools: load the `figma-use` skill, then `create_session` with the file key.

## What's left, in order

1. ~~**Notes:** Add note, Note (view, Delete note | Edit), Edit note, and their variants.~~ Done 12 Oct.
2. ~~**Day details for every other kind**~~ done 12 Oct (the Day details section, and slips in Logs and slips). Not
   drawn: Tick steps (the checklist's Add screen for a past day) and the amount-per-week / per-month kinds (Push-ups
   "+20" with "0 of 300 this week", Savings "Log amount"); they use the same parts.
3. ~~**New (+):** the choices, then the habit form.~~ Built 12 Oct. ~~The pages each row opens and the sixth-habit
   sheet~~ built 13 Oct. Not drawn yet: Make room's list, a task's Repeat, a quit habit's Started picker; with test
   data over five habits, the iPhone's Quit or cut down opened a blank sheet (check).
4. ~~**The ≡ menu** as Material's navigation drawer.~~ Built 12 Oct.
5. ~~**The routine player and the timer.**~~ Built 12 Oct. Still to draw: the running timer as Android 16's Live
   Update notification (A11 D4) and Today's timer bar.
6. ~~**Habit details:** Progress, History and Notes tabs.~~ Built 12 Oct. Not drawn: Milestones' See all page, Go to
   date, a habit with no history yet, and the other kinds' Progress (time, checks, quit, checklist).
7. ~~**Progress.**~~ Built 12 Oct (Week, Month, Year; no ⋮). Not drawn: the legend expanded.
8. ~~**Settings pages:**~~ Built 12 Oct (Times of Day, Day and Week, Reminders, Appearance, Google Drive & Backup and
   the restore flow, Privacy & Security and App lock, Plus, Help & Feedback, About). Was: Times of Day, Day and Week, Reminders (with the reminder check, A11 D1–D2), Appearance, Google
   Drive & Backup (the sync line and status, A7), Privacy & Security and App Lock, Plus, Help & Feedback, About.
9. ~~**Welcome**~~ (the onboarding) built 12 Oct. ~~An empty Today~~ built 12 Oct. Still to draw: "We found data on this device".
10. ~~**Widgets**~~ built 12 Oct: every kind, every state, adding and changing. Paused: lock-screen widgets (the user, 12 Oct).
11. Then the larger phone (412 wide) for the screens that need it, and the tablet layout (A11 D9).
