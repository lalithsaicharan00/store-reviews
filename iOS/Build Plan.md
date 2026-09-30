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

## Round 5: times place habits; reminders, alarms and Remind Again (27 Sep 2026)

Spec: [Pending to Implement.md](<Docs/Specs/Pending to Implement.md>). Reasoning: [Times, Day Sections and Reminders — Can People Predict What Happens?](<../Research/Research Reports/Habit Creation/Times, Day Sections and Reminders — Can People Predict What Happens.md>).

| # | Task | Status |
|---|---|---|
| 31 | ~~**Placement:** a habit's times decide its section (`HabitStore.placements(of:)`, `section(forMinute:)`), worked out on every render and never stored. Check it off on a set schedule with times in 2+ sections gets a row per section; everything else is one row (Anytime if its times spread). Today sorts timed rows by time and shows the time on the row ("0/1 · 7:00 AM")~~ | Replaced by 39 |
| 32 | **Storage, schema 4:** `habit.remind`, `alert`, `follow_up_minutes` (add-only; migration test 3→4 passes) | Done |
| 33 | ~~**Form:** When (Day Section picker with no time, read-only list with times; time rows labelled with their section) and Reminders (Remind Me, Alert on iOS 26+, Remind Again If Not Done, Open Settings when denied). Live sentences from `Outcome`, "First due …", Time it and Quit footers~~ | Replaced by 39 |
| 34 | **Predict-the-outcome test** with five people (report §6) | Waiting for the user |
| 35 | **Scheduler:** a row's reminders stop once that row is ticked; same-minute notifications share one; Remind Again every 15/30/60 min, up to 3 more, today and tomorrow only; background refresh about twice a day | Done |
| 36 | **Alarm (AlarmKit, iOS 26+):** fixed-date alarms with a Done button that marks the row done; below iOS 26 an alarm habit uses a notification | Done |
| 37 | **Notification actions:** Done (Check it off, to-dos), "+1 glass" (amounts); only ever add | Done |
| 38 | **Day Sections copy, After-Add reveal** (opens the section, scrolls, flashes the row) and the one-time upgrade of round-4 multi-section habits (`placement_v1`) | Done |

Decisions made while building (none contradict the spec's intent):
- **Alarm button is Done, not Snooze.** AlarmKit allows one custom secondary button (`secondaryButtonBehavior: .custom` with an App Intent), so the alarm offers Stop and Done as the spec prefers. The Reminders footer says so: "…until you stop it. Stopping it doesn't mark it done; its Done button does." This replaces "until you stop or snooze it", which would have promised a Snooze that doesn't exist. Test this wording in step 34.
- **Alarm IDs are derived, not stored:** each AlarmKit ID is a hash of the reminder's ID, so no `alarm_ids` setting is needed to cancel exactly what's no longer wanted. A ringing alarm is only cancelled once its row is done. The per-app alarm limit isn't published; the app keeps the nearest 30 and stops on `maximumLimitReached`.
- **Remind Again stops at the row's next time** (the next time reminds anyway) as well as at the day's end.
- **"If not done"** in the sentence for amounts, Time it and checklists; "If not ticked" for Check it off and to-dos.
- **Upgrade times** are an hour into each section, or halfway for a section shorter than two hours, so the time never lands in the next section.
- **Fixed on the way:** tapping + on a limit ("Set a limit") undid instead of logging while under the limit, so a limit could never be logged. + now always logs on a limit.
- **Info.plist:** the background-refresh identifier, `fetch` background mode and `NSAlarmKitUsageDescription` can't be build settings, so they live in `iOS/Habits-Info.plist`, merged with the generated keys.
- **Placement tests:** the app has no unit-test target, so the §2 cases run in a debug-only `-placementcheck` launch, checked by `PlacementUITests`.

### Round 5b: Time of Day (user feedback, 27 Sep 2026)

The user found "When / Day Section / Add Time" confusing and hard to tap. Research: [Time of Day and Reminders — What Users Want](<../Research/Research Reports/Habit Creation/Time of Day and Reminders — What Users Want.md>).

| # | Task | Status |
|---|---|---|
| 39 | **Time of Day** (renamed from Day Section everywhere, "Edit Times of Day" on Today): large chips, always editable, decide where a habit shows; multi-select ("Pick one or more", with ticks) for Check it off on a set schedule, "Pick one" otherwise. **Reminders** are separate and off by default; Remind Me adds one reminder per chosen time of day, labelled "Morning reminder", and they follow the chips until edited; reminders never move a habit. Alert and "If Not Done, Remind Again" show only with Remind Me on. Form sentences are larger (callout) and rewritten in plain words. Round-5 dev data (silent times) is put back into its times of day once (`placement_v2`) | Built and installed on the iPhone; checked by `FormWalkthroughUITests` and `PlacementUITests`. Full UI suite not re-run yet (the user asked to review the screen first); `NewHabitUITests` and `LongTextUITests` still use the old wording and need updating |


## Round 6: New flow, Goal row, Time of Day (27 Sep 2026)

Spec (everything decided, in one place): [New Habit Goal and Time of Day.md](<Docs/Specs/New Habit Goal and Time of Day.md>).

| # | Task | Status |
|---|---|---|
| 40 | **New flow:** "What do you want to create?" (a good habit, a bad habit, a task) → "How do you want to track it?" / "What do you want to do?" → one form. Pushed lists, no icons; icon picker and New Time of Day are pushed pages, not sheets | Built; installed on the iPhone |
| 41 | **Numbers:** whole stays whole, up to 2 decimal places, "k" from 1,000, time as "1 h 25 min" | Built |
| 42 | **Check it off:** "Times a day" (1 = plain tick, no "0/1"); several times of day = a tick in each | Built; **to change** (28 Sep): the goal stays as typed, no "one in each" |
| 43 | **Time it:** hours-and-minutes wheels | Built |
| 44 | **Time of Day** menu (parts, then "Or", then Anytime; always multi-select for every type, only Anytime single); ticks one per part, counts and times shared, anything else the same row in each part | Built; **to change** (28 Sep): the time of day is display only, the same row with one shared progress in each part for every type, no splitting. Reminders unlimited within the chosen parts |
| 45 | **Reminders:** progressive (Remind Me → times → Remind Me With → If Not Done, Remind Again); each reminder limited to its time of day | Built |
| 46 | **Tasks:** once or on a schedule; "Tasks don't have progress or stats" | Built |
| 47 | Goal history, long-press Add Amount… / Mark as Done, edit screen | Not started |
| 48 | **Flow test** `NewFlowUITests` | Passes on the iPhone 16 (27 Sep): all three choices, both questions, the Check it off form with Morning + Evening and reminders, Today, Count it, Time it, Cut down, Task. Fixed on the way: a per-part tick row showed "0/2"; it now shows only its time. `NewHabitUITests`, `LongTextUITests` and `FormWalkthroughUITests` still use the old chooser and need updating before a full run |

### Round 6b: compact form, display-only time of day, start and end dates (28 Sep 2026)

| # | Task | Status |
|---|---|---|
| 49 | **Compact form:** name row; Icon · Colour pop-ups; Repeat and Time of Day, and Goal, each opening a full screen; reminders (one by default, add more) with Remind Me With / Remind Again right below | Built; `NewFlowUITests` passes on the iPhone; installed |
| 50 | **Time of Day is display only:** the same row with one shared progress in each chosen part; the goal is never changed or split | Built (the flow test checks a goal of 4 stays 4 after picking Morning and Afternoon) |
| 51 | **Start and end dates:** Starts (Today, any past or future day), Ends (Never or a date, never before the start) on the Repeat screen; Core schema 5 (`starts_on`, `ends_on`) | Built; Core migration test 4→5 passes |
| 52 | Repeat screen lists every How Often option; Dates is its own section above Reminders; a Remind Me switch shows the reminder sections only when on; switches are green (checked in dark and light) | Built; `NewFlowUITests` passes on the iPhone; installed |

Rounds 7–9 (New Habit form Round 3/4 and the full-screen routine player) are recorded in `Docs/Checklists/` and merged into main on 29 Sep.

## Complete every feature (order set by the user, 29 Sep 2026)

**Goal:** the app isn't being built to release yet. It's built to get every screen and feature right and working (backend only as much as the screens need), so the designs can then go into Figma. No iPhone testing until the features are complete; simulator checks are fine. Work top to bottom, one at a time.

| # | Feature | Status |
|---|---|---|
| 53 | **Habit page and Edit habit:** open a habit, edit name, icon, colour, goal, how often, time of day, reminders, dates; edits apply from today and past days keep their goal (the old #47). The page is the home for notes, pause, archive and delete | Edit built 29 Sep (long-press → Edit Habit; goal history); the habit page itself comes with notes (#54) |
| 54 | **Habit notes** (research first whether notes for the whole day are needed) | Built 29 Sep: habit notes, a description, and a note for the day (`Docs/Checklists/Habit Notes and Day Notes.md`) |
| 55 | **Pause a habit** (research pausing tracking across the whole app) | Built 29 Sep: research, long-press → Pause…, Paused card, quit runs (`Docs/Checklists/Pause a Habit.md`); installed on the iPhone. Also on the habit page since #56b |
| 56 | **All Habits:** the list behind the top-bar button, with archive and delete | Built 29 Sep (`Docs/Checklists/All Habits and Habit Page.md`); builds, not yet installed or tested by hand |
| 56b | **Habit page** (added by the user, 29 Sep): tap a habit (in All Habits) to open its page, the home for its notes, Edit, **Pause / Resume** (built #55, needs a place here), archive and delete | Built 29 Sep with #56 |
| 57 | **Easy undo after checking or logging** (snackbar or a suitable native presentation) | Not started |
| 58 | **Completion feedback:** finish the fill or check animation before the row moves below unfinished rows; smooth on repeated goals (the last of three checks) | Not started |
| 59 | **Section open and close animation** beyond the current fade | Not started |
| 60 | **Progress and statistics screens** (in the ≡ menu, not Today's top bar) | Phase 1 built 30 Sep (60a–60c, 60e); research done 30 Sep ([report](<../Research/Research Reports/Progress and Statistics/The Progress Page — What People Need, and How to Build It.md>)); build order in [Progress — What to Build, in Order](<Docs/Specs/Progress — What to Build, in Order.md>). **Phases 1–3 built 30 Sep, group stats with groups the same day** |
| 60a | **Weekly and monthly goals done for the day once logged that day**, on Today ("N left", the section ✓), in the routine player's segments and in the day bar's ring and count (`isSatisfied`, `daySummary` → `dayScore`). Today a 3-times-a-week habit stays "left" after today's tick | **Built 30 Sep 2026** (branch `progress-page-research`); golden cases G2, G10, G16 and UI tests green on GitHub |
| 60b | **Daily limits (cut down) judged when the day ends**, not counted as met from the start of the day | **Built 30 Sep 2026**; G4 green |
| 60c | **Archive date** (`archivedOn`, a small database change) so archived habits stop counting from that day and past numbers never change; Restore saves the gap as a pause | **Built 30 Sep 2026**, stored in the settings table (no schema change); G8 green |
| 60d | **"Log a Slip…" for quit habits:** date, time and an optional note, saved as an event with Undo (today a slip can only be recorded by editing "Started") | **Built 30 Sep 2026**: long-press on a quit row and on its page; `logSlip`, `quitHistory`; golden checks and `testLogSlipAndUndo` green |
| 60e | **Progress, Phase 1:** the Progress page from the ≡ menu (Week and Month overview, habit rows, Day sheet, explanations, view options) and the habit page's Over Time for every type; tests and speed test | **Built 30 Sep 2026**; `-progresscheck` (G1–G17) and `ProgressUITests` green on GitHub. Built on grouped cards, not a `List` (see Design Rules) |
| 60f | **Progress, Phase 2:** Year views, Runs, By Weekday, the 30-day rate, quit sections | **Built 30 Sep 2026**; golden checks and `ProgressUITests` (Year, Log a Slip, habit page) green on GitHub |
| 60g | **Progress, Phase 3:** full-day threshold, money saved, shareable year image, group stats | **Built 30 Sep 2026**, group stats with groups (#68) |
| 61 | **Settings and account** (the avatar button) | Next (chosen by the user, 30 Sep). Include export and import with on-device snapshots (free users' only backup), a support and contact link, day start and week start, theme, restore purchase, help |
| 62 | **Onboarding (first launch):** asks day start and week start (decided, Backlog 28 Sep); the user creates their own habits first, no sign-up wall, a skippable tour (ledger C203, C209, C075) | Not started |
| 63 | **Home-screen and lock-screen widgets:** interactive, free, show every free habit; Plus adds designs and sizes (Backlog 29 Sep; ledger C009, C023, C040) | Not started; best after Progress settles what a widget shows |
| 64 | **Plus: purchase, account, sync and server backup:** StoreKit purchase and restore, "Continue with Apple / Google" after buying, sync, server backup, Plus Family invites (Architecture 01–06). The Plus screen exists; buying isn't wired up | Not started; the largest remaining piece, and 65–67 depend on it |
| 65 | **Apple Watch app** (Plus): timer and two-way sync done properly (ledger C022, 19 apps positive, 40 negative) | Not started |
| 66 | **iPad layout** (Plus) | Not started |
| 67 | **Apple Health, read-only** (Plus; first update after launch, Backlog 28 Sep) | Not started |
| 68 | **Smaller, useful but not urgent:** milestones and celebrations (C101), check-off sound and haptic (C069, fits with #58), Siri and Shortcuts (C046), app-icon badge (C226), passcode lock (C017), tags or grouping (C045), mood tracker (C049) | **Groups built 30 Sep 2026** ([plan](<Docs/Specs/Groups — What to Build.md>)); the rest not started |

State on 30 Sep 2026: undo (#57) is researched and being built in another session; Progress (#60) is being researched in another session. Suggested order after them: 61 Settings → 62 Onboarding → 63 Widgets (every screen a free user sees, before Figma) → 64 Plus, then 65–67.

**≡ menu (the user, 30 Sep 2026, final):** the avatar became a ≡ side menu holding Progress, Habits, Tasks and every setting (Design Rules, "≡ Menu — FINAL"). Built on the `sidebar` branch with the pages that exist wired in (Habits, Tasks, Times of Day, Plus); Progress (#60) and the settings pages (#61) open "coming" pages until they're built, each wired in one place (`MenuPage`). Checklist: `Docs/Checklists/Sidebar Menu.md`.

**Progress (#60), 30 Sep 2026:** researched on the `progress-page-research` branch. It opens from the ≡ menu's Progress row (`MenuPage`), per the final menu decision. Four fixes to what's built come first (60a–60d), then Phase 1 (60e). Order and details: `Docs/Specs/Progress — What to Build, in Order.md`.
