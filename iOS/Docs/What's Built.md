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

- [x] ☑︎ on Today opens All Habits: Habits, Quitting, Tasks and Archived
- [x] Swipe to Archive / Restore or Delete (Delete asks, and offers Archive Instead)
- [x] Select several to pause, archive or delete; drag to reorder (Today follows)
- [x] Archiving keeps all history and frees a free slot
- [x] Habit page: its sentence and description, streak, best, done this month, a month calendar of its days, notes, Edit, Pause / Resume, Archive, Delete

## Routine player (▶ Start on a time of day)

- [x] Full screen, one habit at a time: header "Morning · 2/10 ⌄", progress segments, circle with icon and progress
- [x] Main button per type: Start / Pause / Resume for timers, + for amounts, Mark done for checks, tappable steps for checklists; then Next or Finish routine
- [x] ‹ › to move, Habit options (log by hand, Skip today / Undo skip, undo, notes, Edit Habit)
- [x] Tap the header → Your routine: jump to any habit or reorder the routine
- [x] Cut-down habits are check-ins; quit habits aren't in routines
- [x] Summary at the end
- [x] Fast: Today stops drawing behind the player

## Backup, sync and accounts (1 Oct 2026, branch `claude/server-and-sync`)

Design: [Backup, Sync and Accounts — One Seamless Experience](<../../Research/Research Reports/Data, Sync and Accounts/Backup, Sync and Accounts — One Seamless Experience.md>).

- [x] **Settings → Backup & Sync** (the avatar on Today): where the backup is and when it last worked, Back Up Now,
      Restore, Move to Another Device, Export a File, Undo Last Restore (30 days); Sync ("part of Plus" when free);
      sign in or out
- [x] **Accounts are optional and free:** Google sign-in (the system web sheet, no SDK); an unknown sign-in asks
      before creating an account. Sign in with Apple is written but off until the Apple Developer account
- [x] **A free account backs up to our server** once on each day something changed, confirmed by the server's checksum;
      **only Plus syncs**
- [x] **Restore** from the account's copies (any of its devices: "copy my habits here once") or a file, also opened
      from AirDrop, Files or Mail; a preview, then Replace or Merge; an import that adds nothing says so
- [x] **"I've Used This Before"** on the empty first screen
- [x] **A card on Today only when the main backup has a problem** (signed out, the server unreachable for 2 days, a copy
      that failed its check), with the fix; Not Now hides it for 7 days. Nothing about backup on Today otherwise
- [x] **Your account:** sign-in methods, devices, Sign Out, **Delete Account** (export offered first, Face ID or
      passcode, then keep or erase this iPhone's habits); another device of a deleted account just signs out
- [x] **Erase All My Data** without an account (asks first, offers an export)
- [x] **One notification** when a background backup finds a problem while the app is closed (only if notifications are
      allowed); tapping it opens Backup & Sync
- [ ] The copy in the user's own iCloud, and finding it from "I've used this before" (both written; off until the
      Apple Developer account)
- [ ] The Plus purchase flow's "One last step" and "Turn on sync" lines (waits for the Plus screen design)

## Under the hood

- [x] Data saved on the phone (SQLite through the Kotlin shared core), survives closing the app
- [x] Light and dark mode

## Not built yet (Build Plan order)

- [ ] Easy undo after checking or logging
- [ ] Completion animation before a done row moves down
- [ ] Section open and close animation
- [ ] Progress and statistics screens
- [ ] Settings and account
- [ ] Sync, backup, widgets, Apple Watch, iPad, Apple Health
