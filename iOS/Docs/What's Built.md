# What's Built

Written by Claude (Claude Code), 29 September 2026. **Keep this up to date:** when a feature is finished, tick it here in the same change.

This is the short list of what the iPhone app can do today. The reasons behind each choice are in [Design Rules — Don't Regress](<../Design Rules — Don't Regress.md>) and the checklists in `Checklists/`. Work order: [Build Plan](<../Build Plan.md>).

## Creating a habit (+)

- [x] **Three starting choices:** Build or maintain · Quit or cut down · Add a task
- [x] **Build habits, four ways to track:** Check it off · Track an amount · Time it · Checklist (a habit with steps)
- [x] **Break habits:** Quit (a clock counting time since the last slip, plus the best run) · Cut down (a limit per day, week or month)
- [x] **Tasks:** once, or on a schedule; tasks have no habit progress, streaks or stats
- [x] **Every frequency:**
    - [x] Every day
    - [x] Several times a day
    - [x] A number of times a week, month or year ("3 times a week")
    - [x] Totals for a week, month or year ("20 km a month")
    - [x] An amount on N days a week ("5 km on 3 days a week")
    - [x] Days of the week (weekdays, weekends, any set)
    - [x] Every few days, weeks or months (with optional set days for weeks)
    - [x] On a date: dates of the month, "the first Saturday of the month", yearly dates, short months and 29 Feb handled
    - [x] Tasks only: After it's done (repeat from completion)
- [x] Name, icon (with search), colour, custom units, "Each + adds" or type the amount each time
- [x] Time of Day (Morning, Afternoon, Evening, own times of day, Anytime); one or more, display only
- [x] Starts and Ends dates
- [x] Description (a standing note on the habit)
- [x] Live preview at the top: the Today row and one sentence that says the whole habit, pinned on every screen the form opens
- [x] Text limits (names 24, steps 24, times of day 16, units 12)
- [x] Free limit: 5 habits, then the Plus screen (purchase not wired up yet)

## Reminders

- [x] Off by default; one per chosen time of day, more can be added
- [x] Notification or Alarm (AlarmKit, iOS 26+; the alarm has a Done button)
- [x] Remind Again if not done (every 15, 30 or 60 min, up to 3 more)
- [x] Actions in the notification: Done, "+1 glass"
- [x] A reminder stops once the habit is done

## Today

- [x] Times of day as cards, each with "N left" and ▶ Start; Quitting card; cards fold
- [x] Habit rows with progress fill, streak and action button; rows top-aligned (icon, streak and button stay at the top when the text runs to 3 lines)
- [x] Tap + / ✓ to log; tap the row to log an amount or time by hand; Undo Last Entry
- [x] Timers start in the row; a timer bar when the row is off screen; Live Activity outside the app
- [x] Streaks for every frequency ("23", "4 wk")
- [x] Skip today (a skipped day isn't a missed day)
- [x] Day bar at the bottom: ‹ › days, calendar sheet, Back to Today
- [x] Past days can be filled in
- [x] Edit Times of Day from Today
- [x] Hidden on days a habit isn't scheduled
- [x] A "3 times a week" (or monthly) habit counts as done for the day once ticked that day: "N left", the ✓ group, reminders, the routine player's segments and the day bar; each ✓ still adds one toward the week (30 Sep 2026)
- [x] A daily limit isn't "met" before the day ends; its streak counts today only once the day is over (30 Sep 2026)
- [x] The day bar and calendar rings give part credit (a 6 of 8 glasses day fills its ring part of the way)

## Editing a habit

- [x] Long-press a row → Edit Habit (also quit rows, and Habit options in the player)
- [x] Changes apply from today; past days keep their goal (goal history)
- [x] The streak restarts only when the kind of period changes (day ↔ week ↔ month ↔ year), and the form says so before Save

## Notes

Three kinds, never mixed: a note on a habit for one day, a habit's description, and a note for the whole day. A note never changes progress, and the app never asks for one.

**Ways to add or change a habit's note:**

- [x] **After logging:** the row shows a small "Add note" (the row stays in place while it's offered)
- [x] **Swipe left** on a row → Note (any row, done or not)
- [x] **Long-press** a row → Add Note / Edit Note
- [x] **Tap the note** shown under the habit to change it
- [x] **Quit rows:** swipe, long-press or tap the note (for a craving or a slip)
- [x] **In the routine player:** Habit options → Add Note, and "Add Note" in the banner after a skip
- [x] Past days too: go to the day and use any of the ways above

**Writing the note:** a note bar docked above the keyboard names the habit and day ("Drink tea · Today") with Delete, Cancel and Save; the row stays highlighted above it. The same bar is used in the player and for the day's note.

**Reading notes:**

- [x] The day's note shows under the habit on Today
- [x] Long-press → All Notes: that habit's notes, newest first
- [x] A dot in the calendar on days with a note

**The other two kinds:**

- [x] **Note for the Day:** bottom of Today → Note for the Day; it shows as a card at the top of Today
- [x] **Description:** written in New Habit or Edit Habit; shown under the habit's name in the routine player

## Pausing a habit

- [x] Long-press a habit or quit row → Pause… (Resume or Cancel Pause once paused or planned)
- [x] Pause for 1 week, 2 weeks, until a date, or until turned back on; a date brings it back on its own
- [x] Build habits and repeating tasks: choose the start day (today, a later day, or an earlier one after being ill)
- [x] While paused: off Today, no reminders, not in routines, the streak is kept (a paused day counts like a skipped day)
- [x] Folded Paused card at the bottom of Today, with when it comes back and Resume
- [x] Quit habits: pausing ends the current run (kept as a run, not a slip); resuming starts a new run
- [x] On the habit page, and for several at once in All Habits

## All Habits and the habit page

- [x] ☑︎ on Today opens All Habits: Habits, Quitting, Tasks and Archived *(superseded 30 Sep: ≡ → Habits (Habits, Quitting, Archived) and ≡ → Tasks)*
- [x] Swipe to Archive / Restore or Delete (Delete asks, and offers Archive Instead)
- [x] Select several to pause, archive or delete; drag to reorder (Today follows)
- [x] Archiving keeps all history and frees a free slot
- [x] Habit page: its sentence and description, streak, best, done this month, a month calendar of its days, notes, Edit, Pause / Resume, Archive, Delete
- [x] Habit page, Progress Phase 1 (30 Sep 2026): a total line under the numbers ("213 days done since 12 Mar 2025"), tap a calendar day for its value and note, and **Over Time** for every type but quit: Week · Month · Year · All, the type's numbers, a count bar (Done · Part done · Not done · Skipped · Paused), a chart with the goal line, By Step for checklists, a running total against a pace line for week and month totals, footnotes when the goal changed
- [x] Habit page, Progress Phase 2 (30 Sep 2026): a Year grid (tap a month to open it in the calendar), Runs (the five longest, Show All), By Weekday and the 30-day rate in Over Time
- [x] Quit habits (30 Sep 2026): **Log a Slip…** (long-press the row, or on its page): when it happened and an optional note, saved as its own event, with Undo; a live clock, best run, "54 clean days since … · 2 slips", the next milestone, Over Time (slips, clean days, longest and average run, a runs chart, the slips list, milestones reached); optional "What It Costs a Day" and "Saved so far"
- [x] Archiving keeps an archive date: the days after it don't count, and Restore turns the archived stretch into a pause

## The ≡ menu (final, 30 Sep 2026)

- [x] ≡ at the top left (replaces the avatar); Today's top bar is ≡ · Filter · +
- [x] Slides in over Today: opens with ≡ or a swipe from the left edge; closes with a tap on Today, a drag left, or a row
- [x] Most used first: Today · Progress · Habits · Tasks, then Times of Day · Reminders · Appearance, Backup & Export · Privacy, Plus, Help & Feedback · About
- [x] Wired: Progress, Habits and Tasks (All Habits, split), Times of Day, Plus. The settings rows open a "coming" page for now

## Progress (≡ → Progress; Phase 1, 30 Sep 2026)

- [x] Week and Month with ‹ ›, opening on the current one; ‹ stops at the first habit's start
- [x] Overview: a ring per day (planned habits done, with part credit), three numbers (Done of planned, Full days, Weekly or Monthly goals met), and the last period's line
- [x] A row per habit with its week marks or month dots and its type's own words ("4 of 5 days · 80%", "2 of 3 so far", "46 glasses · 5 of 7 days", "Avg 1 cup a day · limit 3 cups"); Quitting and Archived sections
- [x] Tap a day: the Day sheet (each habit's mark and value, notes) with Show on Today; tap a habit: its page at Over Time
- [x] How It's Counted with the legend; view options Show Percentages and Show Streaks (streaks also on Today's rows and the habit page)
- [x] Nothing is counted against anyone: skipped, paused, archived and not-its-day days are neutral; a weekly goal's empty day is never "not done"; a limit is judged when the day ends
- [x] Checked in the app with 17 golden cases (`-progresscheck`) and `ProgressUITests`, both in `[ios-ci]`
- [x] Phase 2 (30 Sep 2026): Year (a grid of day dots; tap a month to open it; each row its own year grid); Quitting rows with the run ticking once a minute, best run, slips in the period and a clean-day strip
- [x] Phase 3 (30 Sep 2026): View Options → Full Day (All Done, 80%, 60%); Year → Share: a picture of the year
- [x] Group stats (30 Sep 2026): chips under the range control filter every number; with All, a Groups card (a bar per group, in the groups' order) and the habits under their group's heading

## Groups (30 Sep 2026; Build Plan #68)

- [x] Optional and invisible until the first one: Today's Filter (beside +) explains them and has + New Group
- [x] Filter: chips All · ● Health 5 · ● Mind 0 · ○ Reading – (the number is how many habits it shows on the day open), empty groups last, Edit on the Groups heading
- [x] Filtered Today: the Filter icon fills, a "● Health ✕" chip at the top clears it, every card (Quitting and Paused too) shows only the group, Start plays only what's shown, "Nothing from Home on this day" with Show All; remembered when the app reopens
- [x] One editor: rename, recolour, pick habits (one group per habit: "Moves from Mind"), Pause These Habits…, delete (habits stay, with no group); drag for your own order or Sort A to Z
- [x] Habit form: a Group row beside Time of Day once a group exists, with New Group; a habit added while Today is filtered starts in that group
- [x] Habits page (≡ → Habits): one section per group, then No Group
- [x] Checked with golden case G18 (`-progresscheck`) and `GroupsUITests` (in `[ios-ci]`)

## Routine player (▶ Start on a time of day)

- [x] Full screen, one habit at a time: header "Morning · 2/10 ⌄", progress segments, circle with icon and progress
- [x] Main button per type: Start / Pause / Resume for timers, + for amounts, Mark done for checks, tappable steps for checklists; then Next or Finish routine
- [x] ‹ › to move, Habit options (log by hand, Skip today / Undo skip, undo, notes, Edit Habit)
- [x] Tap the header → Your routine: jump to any habit or reorder the routine
- [x] Cut-down habits are check-ins; quit habits aren't in routines
- [x] Summary at the end
- [x] Fast: Today stops drawing behind the player

## Ticking off and folding (1 Oct 2026, branch `animations-and-settings`)

- [x] A tick answers at once in the button: it fills, the ✓ pops, the row's colour sweeps across (#58)
- [x] Haptics: a light tap per log, a "success" when a habit is done; only from the tap, never from changing the day
- [x] Done rows stay where they were tapped and sink below the rest once you pause (1.5 s), all together; a finished time of day folds then too, not under your finger
- [x] Time of day folds and opens in one short spring; folding one part redraws only that part (#59)
- [x] Reduce Motion: no pop, no sweep, no slide; changes fade

## Settings (1 Oct 2026, branch `animations-and-settings`)

- [x] ≡ → Appearance: Theme (Automatic, Light, Dark); Done Habits (Move to Bottom, Stay in Place); Haptics (on); Sound When Done (off, a soft chime that follows the silent switch)
- [x] ≡ → Day and Week: New Day Starts At (Midnight to Noon); Week Starts On (Automatic or any day)
- [x] 12/24-hour clock follows the iPhone everywhere (no app setting); daylight saving and travel need no setting: "today" is worked out on the wall clock (fixed an hour-off on the nights the clocks change)

## Under the hood

- [x] Data saved on the phone (SQLite through the Kotlin shared core), survives closing the app
- [x] Light and dark mode

## Not built yet (Build Plan order)

- [ ] Easy undo after checking or logging
- [ ] Settings still to build: export and import, backups on the phone, support, restore purchase (theme, day start and week start are built)
- [ ] Onboarding (first launch)
- [ ] Home-screen and lock-screen widgets
- [ ] Plus: purchase, account, sync and server backup
- [ ] Apple Watch, iPad, Apple Health
