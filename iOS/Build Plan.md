# iOS build plan

Set by the user on 27 Sep 2026. Work one task at a time, in order. Build, install and test each task on the
connected iPhone 16 before ticking it. Take a one-minute break between tasks. Record only very important
decisions and contradictions in [Architecture/Backlog.md](<../Architecture/Backlog.md>); everything else is decided
here, the production way: robust (data is never lost), with no complexity that isn't needed.

**Product rules to respect** (from the architecture notes): free = one phone, 5 habits, local-only, **no account**;
Plus = sync and server backup through an account created after purchase. Native SwiftUI components only.

| # | Task | Status |
|---|---|---|
| 1 | **Home screen (Today)**, matching Figma [193:6](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=193-6): parts of the day as cards, habit rows with progress fill, quit timers, bottom day bar, top toolbar. The **+** button opens habit creation | Done 27 Sep: `Habits.xcodeproj`, UI test `TodayUITests` passes on the iPhone |
| 2 | **Research: a native iOS habit-creation screen** that feels like Reminders and Calendar. Covers habit types (yes/no, amount, time, steps, quit), icons, colours, multiple reminders, and what the notes already decided | Done 27 Sep: [research](<../Research/Research Reports/Habit Creation/New Habit Screen — A Native iOS Design.md>) |
| 3 | **Build the habit-creation screen** from that research | Done 27 Sep: `NewHabitView`, reminders reconciled by `ReminderScheduler`; UI tests `NewHabitUITests` pass on the iPhone |
| 4 | **Research: the local database**, which must work on iPhone, Android, Mac, Windows and web, suit the Kotlin shared core, be well established and be easy to build with AI | Done 27 Sep: [SQLite through Room 3 in the Kotlin core](<../Architecture/Local Database Decision.md>) |
| 5 | **Build local storage**, so free users' data lives on the phone and is never lost | Done 27 Sep: `Core/` (Room 3 + SQLite), `Persistence`; all UI tests pass on the iPhone, including `PersistenceUITests` (survives a kill) |

## Round 2 fixes (user feedback, 27 Sep 2026)

Worked one at a time, in this order. Research first where asked.

| # | Fix | Status |
|---|---|---|
| 6 | **Words people use:** research the names users give each kind of habit (reviews + Reddit/web). Rename the "New" list with their words; every example line clearly marked as an example; no example values pre-filled in the form | Done |
| 7 | **Custom units:** research whether people need their own units; make adding one obvious | Done |
| 8 | **"When in the day" + custom day sections:** check the day-section research; sections can be added on Home, and (if the research agrees) from the form too | Done |
| 9 | **Frequencies:** check every frequency users ask for is covered; make "times a day" read naturally with every rule (e.g. every few days) | Done |
| 10 | **Checklist copy:** not a routine (day sections and Start already make routines); a checklist is one habit with a few parts | Done |
| 11 | **Colour in the New list icons:** keep colour for habits only; the type icons go neutral | Done |
| 12 | **Bottom bar:** the day label changes width, so tap positions move; give it a fixed width | Done |
| 13 | **Calendar sheet:** see-through, a gap above the month, cut off at the bottom; make it solid and fitted | Done |

Also fixed while testing round 2: section titles no longer wrap beside folded icons (only as many icons as fit are shown); a finished day shows a filled check in the bottom bar instead of a full ring that read as empty; section times follow the phone's 12- or 24-hour setting; How Often now comes before the goal in the form. Research: [New Habit Words and Units](<../Research/Research Reports/Habit Creation/New Habit Words and Units.md>).

## Round 3: long text and small screens (user feedback, 27 Sep 2026)

| # | Fix | Status |
|---|---|---|
| 14 | **Text limits:** habit and to-do names 100 characters, checklist parts 60, section names 30, units 24. Once a field is full, more typing is ignored; a long paste keeps the start. Saved text is trimmed and cut again, so nothing longer reaches the database | Done |
| 15 | **Label and value rows** (Unit, Day Section, Amount, Ends): the label stays on one line; the value ends in "…"; at least 16 pt between them. The Day Section row shows the name only, and its hours move to the footer | Done |
| 16 | **Card headers:** the name stays on one line and ends in "…"; Now sits beside it. Start ("▶ Start") and the status never shrink. When folded, icons come before the name, but the name keeps its first ~8 letters; the rest show as a "+N" square shaped like the icons; at least 24 pt before "2 left" / "All done" | Done |
| 17 | **Quitting card** folds like the others and starts open | Done |
| 18 | **Long names on Today** wrap to two lines, then "…"; the goal line stays on one line | Done |
| 19 | **New list fits every phone:** one short "Example: …" line per type, so all seven show without scrolling, down to iPhone SE. If they can't fit (very large text), the scroll bar flashes on open | Done |

Checked by `LongTextUITests` (launch argument `-longtext` fills every field at its limit) on the iPhone 16, and on iPhone SE (3rd gen), iPhone 13 mini and iPhone 17 Pro Max simulators (`Research/Temp/ios-sim-test.sh`).

## Round 4 (user feedback, 27 Sep 2026)

| # | Fix | Status |
|---|---|---|
| 20 | **Folded section names:** show at most 8 characters, then "…"; the rest of the row goes to icons | Done |
| 21 | **Row spacing on Today:** habit rows feel cramped next to the Quitting rows; give every row the same, roomier spacing | Done |
| 22 | **New list spacing:** a little more space above and below each row | Done |
| 23 | **Checklist example:** one everyone recognises (not skincare); research what people actually use checklists for | Done |
| 24 | **Checklist wording:** don't say "parts"; research the right word | Done |
| 25 | **Checklist starts empty:** no blank item by default; the Add button adds one | Done |
| 26 | **Icon sheet:** icons only (with search); no colours; picking closes it | Done |
| 27 | **Frequency clarity:** "Every Few Days" vs "A Few Times a Week" must be easy to tell apart once chosen | Done |
| 28 | **Streaks:** research how to show a streak for every frequency so the number is never mistaken for days | Done |
| 29 | **"Times each day" on Check it off:** research whether it adds value or duplicates Count an amount; decide how one habit appears in more than one day section (reminders, or placing it in several sections); weekly or monthly goals if needed | Done |
| 30 | **Habit names on Today:** one line always; 15 characters, then "…" (VoiceOver reads the full name) | Done |

Decisions and evidence: [New Habit Round 4 — Checklists, Streaks and Times a Day](<../Research/Research Reports/Habit Creation/New Habit Round 4 — Checklists, Streaks and Times a Day.md>). Schema 3 adds `entry.slot` (add-only, migration tested). Checked by 17 UI tests on the iPhone 16 and `LongTextUITests` on the iPhone SE simulator.
