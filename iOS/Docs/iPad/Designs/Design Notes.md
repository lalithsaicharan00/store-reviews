# iPad Design Notes — Every Screen, and Why

Written by Claude (Claude Code), 11 October 2026. Every iPad screen, with its picture and the reason for it. **The
pictures in this folder are the designs**: a building session needs nothing else. (They were drawn on the "tablet"
page of the Figma file `Ncccsm1l2O62GJ5xLSInqk`, node `1078:309`; the frame numbers below, like `1104:2`, are that
file's, for anyone who opens it.) Each picture shows a screen's landscape version first and its portrait version
beside it. The reasons are in the
[iPad Layout report](<../Research/The iPad Layout — Familiar Like the iPhone, Native to the iPad.md>) §6 and §8.

## 1. Landscape, Today (frame `1104:2`, 1180 × 820) — the layout approved by the user, 11 Oct 2026

| Part | What it shows | Why (report) |
|---|---|---|
| **Sidebar** (320 pt, floating, can be put away with the sidebar button) | The iPhone's ≡ menu, same rows, same order: Today · Progress · Habits · Tasks, then Times of Day · Day and Week · Reminders · Appearance, then iCloud & Backup · Privacy & Security, then Plus, then Help & Feedback · About | §6.1 every productivity app uses a sidebar; I3 |
| **Today's count** | "9 left" beside Today, in plain grey; Habits and Tasks show their counts as on the iPhone's menu | I4; Reminders, Things |
| **Top bar** | Centre: ‹ · ring + "Today ⌄" + 4/13 · ›, the iPhone's day bar moved to the top. Trailing: Edit, then Filter and + in one group | I6, I7; Calendar, Fantastical |
| **Today** | One column, 700 pt, centred in the space beside the sidebar: the iPhone's own cards (Morning open, Afternoon and Evening folded with their icons and "N left", Anytime open, Quit or Cut Down below, scrolled) | I1, I5; Things' readable width, Reminders' Morning / Afternoon / Tonight |
| **Rows** | Unchanged from the iPhone: colour icon, name, the line under it, the progress fill, the streak, the round control (grey before, the habit's colour when done) | I1; U2, U14 |

The numbers agree: 13 habits on Today, 4 done, 9 left (Morning 2 + Afternoon 3 + Evening 2 + Anytime 2), and the
day ring shows 4/13. Quit or Cut Down isn't counted, as on the iPhone.

![Today: landscape, portrait, portrait with the sidebar shown](<01 · Today.png>)

## 2. Portrait (820 × 1180)

The user, 11 Oct 2026, after approving landscape: portrait next, and how the iPhone's bottom sheet (Day details)
works in both orientations, "take inspiration from … native apps instead of creating our own ideas".

| Frame | What it shows | Why |
|---|---|---|
| **Portrait · Today** (`1109:291`) | The sidebar is put away; its button sits at the top left. The day control stays in the centre, Edit · Filter + on the right. The same 700 pt column, centred (60 pt each side), so the whole day fits without scrolling | iPadOS's own split view in portrait (Mail, Notes, Reminders): the sidebar is hidden and slides over when wanted; I3 |
| **Portrait · sidebar shown** (`1109:538`) | The sidebar slides over Today, frosted, with a shadow; Today doesn't move or shrink. Tapping outside it, or its button, puts it away | The system's overlay sidebar in portrait; U4 (nothing moves) |

## 3. Day details: a popover in both orientations

| Frame | What it shows |
|---|---|
| **Landscape · Day details** (`1109:2`) | Tapped Stretch: the row shows pressed and a popover opens below it, its arrow pointing at the row |
| **Portrait · Day details** (`1109:785`) | Tapped Call family: the same popover. When a row is too low for it to fit below, the system places it above, arrow pointing down |

What decides it (not our own idea):

- **Apple's own rule:** popovers on regular width, sheets on compact width (HIG Popovers: "Reserve popovers for wide
  views; for compact views … a sheet"). An 11-inch iPad is regular width in **both** orientations, so it's a popover in
  both; only a narrow window beside another app gets the iPhone's sheet.
- **Apple's own example is the same job:** the HIG's example of a popover is Calendar's event details, which "disappears
  after the change, letting people continue reviewing the events". Day details is the same: look at one habit's day,
  log, go back to the list. Calendar and Reminders show an item's details this way on iPad.
- **Inside, it's the iPhone's Day details, unchanged** (the habit, This day with its buttons and note, today's logs,
  Skip today), at the iPhone's width (375 pt), so nothing is redesigned.
- **No ✕ in the popover.** Tapping anywhere outside closes it (HIG: a Close button only "if it provides clarity").
  Day details saves as you go, so there is nothing to confirm. This differs from the iPhone's sheet (U18), which keeps
  its ✕; the user may want to confirm it.
- **Add log, a log, a note, All logs open inside the popover**, pushed with a back chevron, as Calendar's Edit opens
  inside its event popover. Apple: never a popover from a popover and nothing over a popover except an alert (Delete's
  confirmation). The popover grows to fit and moves up above the keyboard.
- **Still full screen:** the routine player and the timer.

**Is it what people expect? (the user, 11 Oct 2026: "is that how other apps in iPad do it?")** Users show that a
details pop-up is the expected way on the iPad's own apps. One iPad Calendar user complained when it went away in an
iOS update: "I used to be able to tap on an appointment and the details would pop up and give me an option to edit,
delete or just view" (`N2#16334`, 1★, Apr 2026). An iPad Reminders user complained when the details pop-up opened off
the right edge, out of view (`N1#7979`, 1★, Mar 2026), so a pop-up has to point at the row and stay on screen (the
system's own popover does both). A details panel fixed to one side of Calendar's day view was disliked: "you can only
scroll the calendar with your left hand" (`N2#18857`, 3★). Scan: [`popover_scan.py`](<../Research/iPad Layout Evidence/popover_scan.py>)
(86 native-app reviews about how details open, 9 of them on the iPad).

**The no-✕ choice is confirmed by the user, 11 Oct 2026:** "if the native app itself is not using it, then obviously
people don't expect it."

![Day details as a popover, landscape and portrait](<02 · Day details.png>)

### Many logs (the user, 11 Oct 2026: "what if we have more things in the day details?")

The iPhone's rule stays, so the popover never grows with the number of logs (U17): one to three logs are all shown;
four or more show the two newest and "All N logs ›".

| Frame | What it shows |
|---|---|
| **Landscape · Day details, many logs** (`1114:2`) | Water with 8 logs: 1 glass 9:30 AM, 1 glass 9:00 AM, All 8 logs. Water is the last row, so the popover opens above it, arrow pointing down |
| **Landscape · All logs inside the popover** (`1114:301`) | "All 8 logs" opens Today's logs inside the same popover with a back button, as Calendar's Edit opens inside its event popover. The popover changes height smoothly (HIG: "animate the change") and stays pointing at Water; a longer list scrolls inside it. A log opens its Log view the same way |
| **Portrait · Day details, many logs** (`1114:606`) | The same popover, above the row |

If Day details is ever taller than the room above and below a row, the system makes the popover as tall as the screen
allows and its content scrolls, as the iPhone's sheet does.

![Day details with many logs, and All logs inside the popover](<03 · Day details, many logs.png>)

### Add log with the keyboard (the user, 11 Oct 2026: "go ahead with the add log keyboard one"; everything before it approved)

"Log manually" opens the iPhone's Add log inside the same popover; the iPad's keyboard comes up at the bottom of the
screen (the numbers keyboard: on the iPad a number field gets the full keyboard's numbers layer, not the iPhone's
keypad), and the popover moves up to stay above it.

| Frame | What it shows |
|---|---|
| **Landscape · Add log with the keyboard** (`1120:2`) | The keyboard is 398 pt tall, so 422 pt is left above it and Water is under the keyboard. The popover moves up above the keyboard, without its arrow while its row is covered. Add log uses the iPhone SE's short form (Date and Time in one row, no line under the amount), as the iPhone already does when the keyboard leaves little room (U22, T15) |
| **Portrait · Add log with the keyboard** (`1120:355`) | The keyboard is 320 pt tall and Water stays in view, so the popover keeps pointing at it, with the full form (Date and Time on their own rows, "Adds a new log. Other logs stay as they are.") |

The same in both:

- **✕ stays on Add log** (U18: Cancel, asks first if something was typed). This is a task with something to keep or
  throw away, which is when Apple says a popover should have a Close or Cancel (HIG Popovers), as Calendar's Edit
  inside its event popover has Cancel. ✕ returns to Day details inside the popover; Add saves and returns there too.
- **Tapping outside doesn't close it while something is typed** (the popover stops closing on outside taps until Add or
  ✕), so a stray tap never loses a typed amount; Apple says work is never thrown away by a tap outside a popover.
- **Add is the filled button at the popover's bottom**, just above the keyboard, as on the iPhone.
- **With a hardware keyboard** (Magic Keyboard) there is no on-screen keyboard: the popover stays where it was, pointing
  at the row, with the full form; Return adds (I11).

To check on a real iPad before building (U9): where iPadOS 26 puts a popover, and whether it keeps its arrow, when the
keyboard covers the row it points at; the keyboard heights above are the usual 11-inch ones, not measured.

![Add log inside the popover with the iPad keyboard, landscape and portrait](<04 · Add log with the keyboard.png>)

## 4. A narrow window (the user, 11 Oct 2026: "go ahead with the narrow window one")

On iPadOS 26 people put two apps side by side, or make a window narrow. When the window is narrow enough, iPadOS
calls it compact width (on an 11-inch iPad, half the screen is compact, as it was in Split View), and the app becomes
the iPhone app, exactly (I2). Apple: "Keep functionality the same as size classes change" and use a sheet, not a
popover, in compact views (HIG Layout, Popovers). Mail, Notes and Reminders do the same: in a narrow window they look
like their iPhone versions.

| Frame | What it shows |
|---|---|
| **Narrow window beside another app** (`1122:2`) | Two windows side by side on the 11-inch in landscape; ours is 578 pt wide. The sidebar is put away and its button opens the menu over Today, as in portrait; the top bar is the iPhone's (menu button · Edit · Filter +), with the menu button after the window's own controls (red, yellow, green), which iPadOS puts at a window's top left. On the iPad the menu button is always the system's sidebar button, at every width, never the iPhone's ≡ (the user, 11 Oct 2026: "make sure be consistent"); iPadOS draws that button for every app's sidebar, and the same button in the same place keeps working as the window is resized; the day control goes back to the iPhone's floating bottom bar; the cards fill the window's width, as on the iPhone |
| **Narrow window · Day details sheet** (`1122:196`) | Tapping a row opens the iPhone's Day details sheet, with its ✕ (U18), not the popover. Add log, All logs and the rest are the iPhone's too |

Widening the window back past compact brings the sidebar, the top-centre day control and the popover back; nothing
the person was doing is lost (an open Day details stays open, as a sheet or a popover).

![A narrow window beside another app: the iPhone layout, and Day details as the sheet](<05 · Narrow window.png>)

## 5. Every other screen (the user, 11 Oct 2026: "we have a lot of other screens … complete them")

Each screen keeps the iPhone's content, words and order (I1) and takes the iPad pattern the top apps use for that kind
of screen (report §6.1). Frames are on the tablet page, landscape unless named.

| Kind of screen | iPad pattern (who does it) | Our screens (frame) | Why (users show / reasoned) |
|---|---|---|---|
| A list of things, each with a page | **The list and the selected item side by side** (Notes, Mail, Reminders, Settings) | **Habits** (`1133:2`), **Habits in portrait** (`1172:2`: sidebar put away, list 320 pt beside the details); **Tasks** the same | Users ask for "a master detail view on iPad" (`N6#1949`) and for progress beside the list (7 reviews, report §3.4); moving from habit to habit is one tap, with no Back |
| One habit's page | The iPhone page in the detail column | **Habit details** (inside `1133:2`): header, History · Notes · Progress, Add log and Go to Date, the key, month cards | Same page, same tabs (I1). In a split view the list rows lose their › and show which habit is selected |
| A dashboard | **Cards several across, flowing in rows** (Health's Summary, Home) | **Progress** (`1134:2`): Week · Month · Year in the top bar's centre, as Calendar's Day · Week · Month · Year; the dates bar under the title (it still sticks); the key (folded); habit cards **two across**, in the person's order left to right | More habits and days at once, at the same size (report §3.4: "more at the same size, not the same at a bigger size"); Google Keep praised for using columns on the iPad (`N7#12386`) |
| Settings | **The page beside the sidebar**, a grouped list at a readable width (the iPad's Settings app) | **Times of Day** (`1135:2`), **Day and Week** (`1135:283`), **Reminders** (`1135:559`), **Appearance** (`1135:873`), **iCloud & Backup** (`1135:1175`), **Privacy & Security** (`1168:2`), **Help & Feedback** (`1168:558`), **About** (`1168:873`): 700 pt, centred, the same width as Today's column; title in the top bar, as on the iPhone (inline). A row that opens a page (a time of day, App Lock, a help topic) pushes it in the same place with a back button | The same pages, nothing new to learn (I1) |
| Plus | One decision read top to bottom, in a narrower column (540 pt) | **Plus** (`1168:280`) | A purchase page stretched to 700 pt reads poorly (reasoned); the iPhone's design, unchanged |
| Starting something new | **A form sheet in the middle of the screen** (HIG Sheets: "Prefer using the page or form sheet presentation styles in an iPadOS app"; Reminders' New List, Health's Add Data) | **New (+)** (`1169:2`): "What do you want to do?" in a 580 × 620 form sheet over dimmed Today; the habit form and every later step open inside the same sheet, so its size never jumps | A form isn't "a small amount of information", so not a popover (HIG Popovers) |
| A quick choice from a button | **A popover from the button** (Calendar's date picker, every toolbar menu) | **Calendar** (`1169:281`): the app's own "Go to a day" from "Today ⌄": the month with ‹ ›, plain dates with no rings (today bold, the open day in a grey circle, later days lighter; the user, 2 Oct and 11 Oct 2026: the app has no day rings), its line "Tap any day to open it…", and Back to Today keeping its place, hidden on today. No Done: picking a day or tapping outside closes it. **Filter** (`1169:597`): Show (All Habits, groups with counts), New Group, Edit Groups, Hide Completed Habits / Tasks, from the Filter button; no Done, a tap outside closes it | Small, quick and related to what's on screen (HIG Popovers) |
| Edit mode | In place, as on the iPhone | **Arrange Your Day** (`1171:2`): only Done in the top bar, the same column with every habit, ≡ handles and each card's ··· | Same as the iPhone (Design Rules, Arrange Your Day) |
| Focus on one thing | **Full screen** (HIG: full-screen modal for focused tasks) | **Routine player** (`1171:342`), **timer** (`1171:377`): the iPhone's layout centred; Pause 24 pt above the bottom bar (‹ · Day details · ›); the circle centred between the title and Pause | Same layout (I1); a queue beside the player is a possible later use of the room, not designed |
| First run, empty, locked | Centred on the screen | **Welcome** (`1171:395`, a 480 pt column), **empty Today** (`1171:419`), **App Lock cover** (`1171:675`) | The iPhone's screens and words |

![Habits and Tasks: list and details side by side; the Progress and Notes tabs; the ⋯ menu; Delete as a popover](<06 · Habits and Tasks.png>)

![Progress: cards two across, landscape and portrait](<07 · Progress.png>)

![New (+) as a form sheet: the first step, how to track it, the form](<08 · New (+) and the habit form.png>)

![The calendar and Filter as popovers; Edit Group inside Filter](<09 · Calendar, Filter and Edit Group.png>)

![Arrange Your Day](<10 · Arrange Your Day.png>)

![The routine player and the timer, full screen](<11 · Routine player and timer.png>)

![All nine settings pages beside the sidebar, landscape and portrait](<12 · Settings pages.png>)

![Pages the settings open: a time of day, App Lock, Set Up App Lock, a help topic, restore](<13 · Pages the settings open.png>)

![Welcome, an empty Today and the App Lock cover](<14 · Welcome, empty Today, App Lock.png>)

### Words that change on the iPad

Found while building these; each must read right on an iPad (and should come from the device, never be typed twice):

- **"iPhone" → "iPad"** wherever the copy names the device: Appearance's Automatic footer, Day and Week's footers, Reminders' "On This iPhone" header and its "Open iPhone Settings", Help's "which iPhone you use", onboarding's restore choices ("Replace What's on This iPhone").
- **"≡ › Day and Week"** (onboarding) names a menu the iPad doesn't have: on the iPad it's the sidebar ("Day and Week, in the sidebar").
- **No Haptics row on the iPad**: iPads have no Taptic Engine, so the switch would do nothing. "Sound When Done"'s footer loses "follows your iPhone's silent switch" (iPads have no silent switch); drawn as "A chime when a habit is done."
- **Face ID → Touch ID** on iPads with Touch ID in the top button (iPad Air, iPad mini, iPad): App Lock's words come from the device's own `biometryType`, as on iPhones; "iPhone Passcode" → "iPad Passcode".
- **Plus**: "your iPad and Apple Watch" → on the iPad "your iPhone and Apple Watch".
- **To check on a real iPad before promising**: Live Activities ("Show on Lock Screen") and alarms on the iPad; there's no Dynamic Island, so the Timers footer drops it.

## 6. The 13-inch and the Columns view (the user, 11 Oct 2026: "go ahead with the 13 inch and columns view")

### The 13-inch (iPad Pro 13-inch: 1376 × 1032 landscape, 1032 × 1376 portrait)

| Frame | What it shows |
|---|---|
| **13-inch · landscape · Today (List)** (`1175:2`) | The 11-inch layout with more room: the same 320 pt sidebar, Today's column still 700 pt, centred; the whole day fits without scrolling. The column doesn't widen: rows stretched past ≈ 700 pt are harder to read across (Things keeps ≈ 700 pt on its 13-inch screenshots; report §6.1), and the room is what the Columns view is for |
| **13-inch · portrait · Today (List)** (`1175:1209`) | As the 11-inch portrait: sidebar put away, its button at the top left, the column centred |

Every other screen (§5) carries over unchanged: its column widths stay, with more margin; Progress's cards stay two
across at the same size (a third column would shrink the 40 pt day squares).

![13-inch Today, landscape and portrait](<15 · 13-inch Today.png>)

### The Columns view (Reminders' Columns, report §6.2 item 5)

An option, never the default: List stays the default because every top app shows a day's list as one column (§6.1).
Columns answers "show me the whole day at once" (report §3.4: 4 reviews want more of the day at once, 8 more habits at
once), the way Reminders' Columns is praised ("columns mode is great", `N1#8235`).

| Frame | What it shows |
|---|---|
| **13-inch · landscape · Columns view** (`1175:246`) | Each time of day is its own column, 300 pt wide, left to right in the person's order (Morning, Afternoon, Evening, Anytime, then Quit or Cut Down and Paused). Three columns fit beside the sidebar; the next one peeks in at the edge and the row of columns scrolls sideways, as in Reminders. Put the sidebar away and four fit |
| **11-inch · landscape · Columns view** (`1175:730`) | The same; two and a half columns fit, so on the 11-inch it's most useful with the sidebar put away |
| **13-inch · View menu** (`1176:2`) | Switching: the iPadOS 26 menu bar's **View** menu, **as List ⌘1 / as Columns ⌘2** (Files' and Finder's words), with Hide Sidebar, Go to Today, Previous Day and Next Day (I11's shortcuts) |
| **Appearance** (`1135:873`) | The same choice for people without a keyboard: Today → **Layout: List / Columns** (iPad only), its footer pointing at the View menu |

What stays the same in Columns: every column header is the card's own (name, "Starts 12 PM", "N left", Start), rows are
Today's rows exactly, a row opens Day details as a popover, nothing moves during a run of taps (U4), done rows sink
within their own column after the pause (U13), and Edit opens Arrange Your Day as a list. What differs: a column never
folds (it has its own room, so folding would only hide), and the whole page scrolls down together, not each column on
its own (Reminders does the same). In a narrow window Columns falls back to the iPhone list.

Reasoned, not from reviews: where the switch lives. Reminders keeps "View as Columns" in its ⋯ menu; Today's top bar
has no ⋯ and keeps the iPhone's Edit · Filter +, so the switch is in the menu bar's View menu and in Appearance.

![The Columns view on the 13-inch and 11-inch, and the View menu](<16 · Columns view.png>)

## 7. Portrait versions and the deeper screens (the user, 11 Oct 2026)

Every landscape-only screen now has its portrait beside it (sections on the tablet page): the sidebar is put away
and its button sits at the top left; content keeps its width, centred; Progress's cards stay two across at 382 pt;
the player and timer keep Pause and the bottom bar at the bottom with the circle centred above.

Deeper screens, all following §5's patterns: **Habits**: the Progress tab (Overall record, Milestones), the Notes tab
(search, Add note, notes by month), the ⋯ menu (Edit Habit, Pause…, Archive, Delete) as the system's drop-down menu,
and Delete's confirmation **as a popover from ⋯** (on the iPad an action sheet is shown as a popover from its button,
with no Cancel: a tap outside cancels). The habit page's header is centred, as on the iPhone (U20). **New Habit**:
"How do you want to track it?" and the form itself, both inside the same form sheet (the form scrolls; Add in the
top bar, as on the iPhone). **Edit Group**, pushed inside the Filter popover: only the group's own habits and Add
Habits, Pause These Habits… and Delete Group in view, colours padded off the edges (Current Work 85). **A time of
day** (Morning) pushed in the detail column with Save; **App Lock** and **Set Up App Lock** (a form sheet; Touch ID and
iPad Passcode on this iPad); **a help topic**; **restore** (a form sheet listing the iCloud backups).

## 8. Widgets on the iPad (the user, 11 Oct 2026: widgets aren't locked as UI; their principles are)

The iPhone's widgets (Small, Medium Today, Large Today, Weekly Medium, Tasks, Lock Screen) **work on the iPad
unchanged**: same families, same rows, same taps, the same switch that shows a tap at once and the same safe save
behind it (Rulebook U26 and the widgets doc: those principles are what's locked). The iPad adds:

| Frame | What it shows | Why |
|---|---|---|
| **Extra Large · Today** (`1190:1647`) | iPad only (`systemExtraLarge`): the whole day, **ten habits a page in two columns of five**, read down then across, in Today's order, with "2 of 12 done" and ‹ 1/2 › paging as Large Today has. The rows are Large Today's own row components, unchanged | Report §6.5's "whole day" widget; Apple's own extra-large widgets (Calendar, Notes, Photos) show more of the same content, not new content. More than ten habits page exactly as Large does (5 a page there, 10 here) |
| Extra Large states (`1190:1666` and the next two) | Five or fewer: one column, no pager; App Lock on: "Content hidden"; nothing planned: "Nothing planned for today · Open Today" | The same states as Large Today |
| **Home Screen** (`1190:1688`) | Extra Large, Medium Today, Weekly Medium, Small and Tasks Medium on an iPad Home Screen, sizes in proportion | Shows them together; app icons are blank squares (no other apps' images, D11) |
| **Lock Screen** (`1190:2035`) | The iPad's Lock Screen in landscape keeps its widgets under the clock on the left: the rectangular Today and three circular habits, monochrome, exactly the iPhone's Lock Screen set | iPadOS has Lock Screen widgets; same kinds as the iPhone |

Sizes are the system's, per iPad model; the designs keep the iPhone's measures (Large 338 × 354) for comparison. StandBy
is iPhone only.

![iPad widgets: the Extra Large Today and its states, the Home Screen, the Lock Screen](<17 · Widgets.png>)

## 9. Plus on the iPad (the user, 11 Oct 2026: "in the iPad, the user can use the free itself and they can upgrade from there also")

The iPhone's Plus screens (Current Work 80, built; Figma section "Plus — every screen", node `1011:309`) come to the
iPad with the same words, prices and order; only the presentation changes, as everywhere else on the iPad: what is a
sheet on the iPhone is a **form sheet** in the middle of the screen, and a page from the menu sits **beside the
sidebar**. Only the main screens are drawn (the user: "we don't need to create everything, the main Plus screens");
the rest follow the same two patterns.

| Screen (iPhone card) | On the iPad |
|---|---|
| **Add a 6th habit** (E1) | A form sheet over Today when a sixth habit is added: the five habits and a dashed +, Plus and Plus Family side by side, what both include ("Your iPhone and Apple Watch" on the iPad: the plan names the *other* devices), Get Plus, Make room instead |
| **Make Room** | Pushed inside the same form sheet (‹ back), never a sheet on a sheet: Archive on each habit, ⋯ for Delete |
| **The Plus page** (P1/P2) | Beside the sidebar (§5, `1168:280` and its portrait) |
| **Plus is yours** (A1/A2, after buying) | A form sheet with Done, after Apple's own purchase sheet |
| **Use your habits on this iPad?** (E4/D1, the second-device sheet) | **The iPad's own moment:** a free person opening the app on an iPad with habits already in iCloud. A form sheet: Keep both in sync (Plus) · See Plus, or Move to this iPad · Use on This iPad; ✕ keeps this iPad on its own (Architecture 11 §12) |
| **Your Plus** (Y1, owners) | Beside the sidebar, Plus selected: included, Upgrade to Plus Family, Restore Purchases, Contact Us |

![Plus on the iPad: the 6th habit, Make Room, Plus is yours, the second-device sheet and Your Plus, landscape and portrait](<18 · Plus.png>)

## 10. Still to design

Nothing on the list. Each design waits for the user's review (checklist item 86), then building.
