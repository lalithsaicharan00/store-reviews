# iPad — Start Here

Written by Claude (Claude Code), 11 October 2026. Everything for building the iPad app (Current Work 86) in one
place: what it is, every decision, pictures of every screen, the system changes, and the build order.

> **Building it:** [Build Prompt (Delete When Done)](<Build Prompt (Delete When Done).md>) is the hand-off for the
> session that builds the iPad app; it deletes that file when the work is merged.

## What's in this folder

Everything from the iPad work is here, so a session without Figma has it all:

| Path | What it is |
|---|---|
| `README.md` | This page: what the iPad app is, every decision and why, the words that change, data and sync, the build order |
| `Build Prompt (Delete When Done).md` | The hand-off for the building session |
| `Designs/Design Notes.md` | Every screen with its picture inline, what it shows and why, in the order they were designed with the user |
| `Designs/01 · Today.png` … `17 · Widgets.png` | The designs: each picture is one screen, landscape first, its portrait beside it |
| `Research/The iPad Layout — Familiar Like the iPhone, Native to the iPad.md` | The research: what people say about apps on the iPad, Apple's iPadOS guidance, how 14 top iPad apps do it, rules I1–I12 |
| `Research/The User's Prompts, Word for Word.md` | What the user asked for, verbatim |
| `Research/iPad Layout Evidence/` | The review coding, the scripts that re-run and check it, and what each top app's iPad screenshots show (described in words: no other apps' images in git, D11) |

## What the iPad app is

- **Free.** The iPad layout costs nothing (the user, 11 Oct 2026). Keeping an iPad and an iPhone in sync is Plus,
  as for any second device (Architecture 11 §12).
- **The same app, one build.** The iPhone app becomes universal (iPhone and iPad), with the same code, database,
  sync, widgets and words. Nothing is a separate iPad app.
- **The iPhone's Today in Apple's iPad frame.** The ≡ menu becomes a sidebar with "9 left" beside Today; Today is one
  column of the iPhone's own cards; Day details opens as a popover pointing at the row; the day control sits at the
  top centre. Every card, row, button and word stays the iPhone's. A narrow window is the iPhone app, exactly.
- **Native iPadOS 26:** `NavigationSplitView`, popovers and form sheets, the menu bar, keyboard shortcuts, pointer,
  windows of any size, every orientation. Each pattern is copied from Apple's own iPad apps (Reminders, Notes, Mail,
  Calendar, Health, Settings), never invented.

## Read in this order

1. **The research:** [The iPad Layout — Familiar Like the iPhone, Native to the iPad](<Research/The iPad Layout — Familiar Like the iPhone, Native to the iPad.md>):
   what reviews say about habit and native apps on the iPad, Apple's iPadOS guidance, how 14 top iPad apps lay themselves out, and **rules
   I1–I12** (§6.4). Read §6 at least.
2. **The design notes:** [Design Notes](<Designs/Design Notes.md>):
   every frame, what it shows and why, §1–§8.
3. **The pictures:** [Designs/](<Designs/>), one image per screen, landscape then portrait side by side:

| # | Picture | What's in it |
|---|---|---|
| 01 | [Today](<Designs/01 · Today.png>) | Landscape (sidebar), portrait (sidebar put away), portrait with the sidebar slid over |
| 02 | [Day details](<Designs/02 · Day details.png>) | The popover pointing at the row, landscape and portrait |
| 03 | [Day details, many logs](<Designs/03 · Day details, many logs.png>) | Two newest + "All N logs"; All logs pushed inside the popover |
| 04 | [Add log with the keyboard](<Designs/04 · Add log with the keyboard.png>) | Inside the popover; landscape uses the SE's short form above the keyboard |
| 05 | [Narrow window](<Designs/05 · Narrow window.png>) | Beside another app: the iPhone layout; Day details as the iPhone's sheet |
| 06 | [Habits and Tasks](<Designs/06 · Habits and Tasks.png>) | List and habit page side by side; Progress and Notes tabs; ⋯ menu; Delete's popover |
| 07 | [Progress](<Designs/07 · Progress.png>) | Week · Month · Year at the top centre; cards two across |
| 08 | [New (+) and the habit form](<Designs/08 · New (+) and the habit form.png>) | A form sheet: the first step, how to track it, the form |
| 09 | [Calendar, Filter and Edit Group](<Designs/09 · Calendar, Filter and Edit Group.png>) | Popovers from their buttons; Edit Group pushed inside Filter |
| 10 | [Arrange Your Day](<Designs/10 · Arrange Your Day.png>) | Edit on Today |
| 11 | [Routine player and timer](<Designs/11 · Routine player and timer.png>) | Full screen |
| 12 | [Settings pages](<Designs/12 · Settings pages.png>) | All nine, beside the sidebar, landscape and portrait |
| 13 | [Pages the settings open](<Designs/13 · Pages the settings open.png>) | A time of day, App Lock, Set Up App Lock, a help topic, restore |
| 14 | [Welcome, empty Today, App Lock](<Designs/14 · Welcome, empty Today, App Lock.png>) | First run, no habits, locked |
| 15 | [13-inch Today](<Designs/15 · 13-inch Today.png>) | The same layout with more margin |
| 16 | [Columns view](<Designs/16 · Columns view.png>) | Each time of day a column; the View menu that switches it |
| 17 | [Widgets](<Designs/17 · Widgets.png>) | The Extra Large Today and its states, the Home Screen, the Lock Screen |

The pictures show layout, hierarchy and behaviour at 11-inch (1180 × 820) and 13-inch (1376 × 1032) sizes, light mode.
Build with native components; where a native component does it better than a picture, use the native component.
The Figma source is the "tablet" page of the design file, if needed; nothing here depends on it.

## Decided (with the user, 11 Oct 2026), and why

**How the decisions were made.** The user decided two things (the iPad is free; design the 11-inch first) and asked for
everything else to come from how Apple's own and the top iPad apps work, not from guesswork: "these questions
shouldn't be for me … take inspiration from top apps and top patterns in the iPad". So every layout choice below names
the apps it copies and the evidence for it. Links go to the research (R = [the report](<Research/The iPad Layout — Familiar Like the iPhone, Native to the iPad.md>))
and the design notes (N = [Design Notes](<Designs/Design Notes.md>)). Read the reason before changing a decision.

| Decision | Why | Where |
|---|---|---|
| **Free** | The user, 11 Oct 2026, on the report's recommendation: the most common iPad complaint is an app that ignores the iPad, and charging for the layout would repeat it. Sync between devices stays Plus | R §8 (1); R §3.1 |
| **The same app, the iPhone's Today in Apple's frame** (I1, I2) | Users want the same app on both ("same habits, same gestures") and dislike an iPhone app stretched or a different app on the iPad; Apple: keep functionality the same across size classes | R §3.1, §3.5, §4; I1–I2 in R §6.4 |
| **A sidebar with counts** (I3, I4), its button the system's `sidebar.left` at every width; the iPhone keeps ≡ | Every top productivity app uses a sidebar (Reminders, Notes, Mail, Calendar, Things, TickTick…); counts beside Today are how Reminders and Things answer "how much is left"; users dislike a sidebar that can't be put away; the user asked for one consistent menu icon | R §6.1; N §1, §4 |
| **Today one column of the iPhone's cards, ≈ 700 pt, centred** (I5) | No top app spreads a day's list across the screen; Reminders' Today is also Morning / Afternoon / Tonight; Things keeps ≈ 700 pt; users want "more at the same size, not the same at a bigger size" | R §6.1–6.2, §3.4; N §1 |
| **The day control at the top centre** (I6, I7) | Calendar and Fantastical put their date and view controls there | R §6.1; N §1 |
| **Day details as a popover at the row, both orientations; the iPhone's sheet in a narrow window** (I9) | Apple's own example of a popover is Calendar's event details; iPad Calendar and Reminders users expect details to pop up (one complained when it stopped); Apple: popovers on regular width, sheets on compact; an 11-inch is regular in both orientations | R §6.1, §4; N §3 |
| **No ✕ in the Day details popover; Add log keeps ✕ and blocks outside taps while typing** | Apple: a Close only "if it provides clarity", work never thrown away by a tap outside; Calendar's event popover has no Close, its Edit has Cancel. The user: "if the native app itself is not using it, people don't expect it" | N §3 |
| **Many logs: the iPhone's three-log rule; All logs pushed inside the popover** | Keeps the popover's size bounded (U17); Calendar opens Edit inside its popover; Apple: never a popover from a popover | N §3 (Many logs) |
| **A narrow window is the iPhone app** (I2) | Apple's size classes; Mail, Notes and Reminders look like their iPhone versions in a narrow window | R §6.3; N §4 |
| **Habits and Tasks: list and page side by side** | Notes, Mail, Reminders and Settings; a user asked for "a master detail view on iPad"; 7 reviews want progress beside the list | R §3.4; N §5 |
| **Progress: cards two across; Week · Month · Year at the top centre** | Health's Summary and Home lay cards out across; Google Keep praised for columns on the iPad; Calendar's centred switcher | R §3.4, §6.1; N §5 |
| **Settings beside the sidebar at 700 pt** | The iPad's Settings app | N §5 |
| **Form sheets** (New (+), the habit form, Edit Habit, Set Up App Lock, restore) | Apple: "Prefer using the page or form sheet presentation styles in an iPadOS app"; Reminders' New List, Health's Add Data | N §5 |
| **Popovers from their buttons** (calendar, Filter, Delete's confirmation) | Small, quick and tied to what's on screen (Apple's popover guidance); Calendar's date picker; the iPad shows action sheets as popovers | N §5, §7 |
| **Columns view: an option, switched from the View menu (⌘1/⌘2) and Appearance → Layout; nothing extra on Today** | Reminders' Columns (praised); 4 reviews want more of the day at once; Reminders keeps the switch in a menu, so the user chose no ⋯ on Today | R §3.4, §6.2; N §6 |
| **13-inch: the same layout with more margin** | The room is what the Columns view is for; rows past ≈ 700 pt read poorly | N §6 |
| **Widgets: the iPhone's unchanged, plus an Extra Large Today** | The widgets' principles are locked (instant tap, safe save), not their use on new devices (the user); Apple's extra-large widgets show more of the same content | N §8 |
| **Light-mode designs only** | The user: native colours give dark mode | — |
| **No day rings in the calendar** | The user, 2 and 11 Oct 2026; Design Rules, "Calendar and Back to Today" | N §5 |
| **Every orientation and window size; keyboard shortcuts** (I8, I11) | 165 reviews complain of portrait-only against 12 praising landscape; Apple TN3192; people use the iPad with a keyboard | R §3.2, §3.6, §4 |

## Words that change on the iPad

From the device, never typed twice: "iPhone" → "iPad" where the copy names this device (Appearance, Day and Week,
Reminders' "On This iPhone" and "Open iPhone Settings", Help's "which iPhone you use", onboarding's restore choices);
"≡ › Day and Week" → "Day and Week, in the sidebar"; **no Haptics row** (iPads have no Taptic Engine) and no "silent
switch" in Sound's footer; **Face ID → Touch ID** where the iPad has Touch ID, from `biometryType`; "iPhone Passcode"
→ "iPad Passcode"; Plus names **the other device** ("your iPhone and Apple Watch" when read on an iPad); no Dynamic
Island in the Timers footer.

## Data, storage and sync: nothing new to design

The Watch needed its own data design (Architecture 12) because it is a separate app with its own small database
talking to the iPhone over WatchConnectivity. **The iPad is not:** it's the same app on another device, so it already
has everything:

- **Its own copy of the database**, the same as any iPhone's (the shared core, the same schema and migrations, D1, D2).
- **Sync through the person's iCloud**, as **Architecture 11** designs it for every device, the iPad named in it:
  Plus keeps the iPhone, the iPad and the Watch in sync; **the free plan syncs one device at a time** (§12): opening
  the app on an iPad with habits already in iCloud shows the second-device sheet (Keep Both in Sync (Plus) · Move to
  This iPad).
- **Backups** per device, as on any iPhone (D4, D5); iCloud & Backup lists the iPad under Devices.
- **Widgets** use the same App Group and the same tap → save pipeline (U26, U28).

What the iPad does need is **app-level system changes**, not data design; they're in the build prompt §4:
the device family and orientations, size classes and windows (state per window), the menu bar's commands, the Extra
Large widget family, and a few capabilities to **check on a real iPad**: Live Activities, AlarmKit alarms, Health
steps (Walk) and Touch ID.

## Build order

1. Universal build: device family 1,2, every orientation; the app runs on the iPad simulator as a big iPhone.
2. The split view: sidebar (regular) and the iPhone stack (compact), switching without losing state.
3. Today on the iPad: the column, the top bar, Day details as a popover (and everything inside it).
4. Habits/Tasks list–detail, Progress, settings, sheets and popovers, the player and timer.
5. Keyboard and pointer: the menu bar (View, Go), shortcuts, hover, right-click = long press.
6. Columns view; 13-inch check.
7. Widgets: Extra Large Today; check the others at iPad sizes; Lock Screen.
8. Words that name the device.
9. Tests on the iPad simulator; speed runs; then the real iPad checks.
