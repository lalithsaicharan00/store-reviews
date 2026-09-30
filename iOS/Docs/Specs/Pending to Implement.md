# Pending to Implement — Times Place Habits; Reminders, Alarms and Remind Again

> **Partly superseded (27 Sep 2026, round 5b):** time of day, not reminder times, now decides where a habit shows; reminders are a separate switch, off by default. See Build Plan.md round 5b, "Time of Day and Reminders — What Users Want", and the decided design in [New Habit Goal and Time of Day.md](<New Habit Goal and Time of Day.md>). The scheduler, alarm and notification-action parts (§6) still apply.

Written by Claude (Claude Code), 27 September 2026, for the session that implements it.
**Why:** [Times, Day Sections and Reminders — Can People Predict What Happens?](<../../../Research/Research Reports/Habit Creation/Times, Day Sections and Reminders — Can People Predict What Happens.md>).
Read that report's §3 before starting. This file is the build spec; the report is the reasoning.

Work the way [Build Plan.md](<../../Build Plan.md>) says: one step at a time, build and test each step on the iPhone 16, native SwiftUI only, data never lost.
When a step is done, add it to Build Plan.md as a new round and tick it here.

---

## 0. The change in one paragraph

A habit's **times** decide where it shows on Today: a time at 7:00 AM puts it in the section that contains 7:00 AM.
**Remind Me** (on by default) turns those times into notifications.
**Alert** chooses Notification or Alarm (iOS 26 AlarmKit).
**Remind Again If Not Done** repeats every 15, 30 or 60 minutes, up to 3 more times, until the row is ticked.
A habit with **no time** keeps a single-choice **Day Section** picker (Anytime by default).
The form states the outcome in a live sentence under each group, so people can predict what will happen.

This replaces round 4's multi-select Day Section menu. Check it off in two sections now comes from two times.

## 1. Steps, in order

| # | Step | Status |
|---|---|---|
| 1 | Placement rules in `HabitStore` (§2), with Today using them (§5) | Done 27 Sep (round 5) |
| 2 | Storage: schema 4 (§3) | Done 27 Sep |
| 3 | Form: When and Reminders groups, live sentences, other footers (§4) | Done 27 Sep |
| 4 | Run the five-person predict-the-outcome test (report §6) on a build of step 3; fix any wording that fails | Pending: needs the user (the build is on the iPhone) |
| 5 | Scheduler: per-row suppression, same-minute grouping, Remind Again (§6.1–6.3) | Done 27 Sep; manual device checks in §10 still to do |
| 6 | Alarm via AlarmKit on iOS 26+ (§6.4) | Done 27 Sep; "rings on silent" still to check by hand |
| 7 | Notification actions: Done, +1 (§6.5) | Done 27 Sep |
| 8 | Day Sections editor copy, After-Add scroll and highlight, data upgrade (§7, §8) | Done 27 Sep |

Steps 1–3 are one shippable unit. 5–7 can each ship alone.

---

## 2. Placement rules (`HabitStore`)

Add one function and use it everywhere a habit's sections are needed: Today, Start (routine), the form preview and the scheduler.
**Nothing is stored:** placement is worked out from the times and the current sections every time.

```swift
/// Where a habit shows on Today: one entry per row. `slot` is the section ID for
/// habits ticked once per section (Check it off with times in 2+ sections), else nil.
struct Placement: Hashable { let section: String; let slot: String?; let times: [ReminderTime] }
func placements(of habit: Habit) -> [Placement]
func section(forMinute m: Int) -> DaySection   // rule A
```

**Rule A: a time's section.** Take `timedSections` (sorted, each with its end).
- Take `m = hour*60 + minute`. If `m < dayEndHour*60`, add `24*60` (the night belongs to the day before, as `nowSection` already does).
- The section is the one with `start ≤ m < end`.
- If `m` is before the first section's start, use the **first** section.
- If `m` is at or after the last section's end, use the **last** section.
- With no timed sections, use Anytime.

**Rule B: rows.** Let `times` be the habit's times (the `reminders` array; see §3 for the naming) and `S` the distinct sections of those times, in Today's order.
1. **No times:** one row in `section(habit.parts.first ?? .anytime)`. Unknown IDs fall back to Anytime, as `section(_:)` does today.
2. **Check it off (`.check`) and `frequency.isDayBased`, with `S.count ≥ 2`:** one row per section in `S`, with `slot = section.id`. That row's `times` are the times in that section.
3. **Otherwise with times:** one row. If `S.count == 1`, it goes in that section; if not, in **Anytime**. `slot = nil`. This covers amounts, Time it, checklists, limits, period rules, and tasks with a time.
4. **Tasks:** `dueMinute` is the task's time. If set, rule A places it; if not, `parts`.

**Replace** these with placements:
- `slots(of:)`: return the slot IDs from placements. Keep the name so the rest of the code keeps working.
- `habit.parts` filtering in `TodayView.content`: iterate sections, then `placements(of:)` for each tracked habit.
- `RoutinePlayer` and `start(part:)` already use `slots(of:)` and `isSlotDone`, so no logic change is needed there.

**Progress with slots** (`dayProgress`): count the **distinct slot values** ticked that day, **plus loose ticks**, capped at the slot count. Don't intersect with the current slots.
This way a section edit that re-files a time can never turn a finished day unfinished. A re-filed tick might show its new row unticked; ticking again stays capped, so nothing is double-counted.
Keep `isSlotDone(habit, slot:on:)` matching by ID, for the row's own tick.

**Order within a section:** timed rows by their earliest time in that section, then untimed rows in saved `position` order.
Manual drag-to-reorder is a separate task; when it's built, a manual order wins and sticks.

**Tests** (`HabitStore` has no unit-test target; add a small XCTest target, or test through UI tests with fixed launch data):
- 7:00 → Morning
- 5:30 with Morning at 6:00 → Morning
- 01:00 with day end 3 → the last section
- 12:00 → Afternoon (a start is inclusive)
- Check it off 7:00 + 21:00 → 2 rows
- 7:00 + 7:30 → 1 row
- Amount 9/12/15 → Anytime
- `perWeek` check 7:00 + 21:00 → Anytime
- No sections → Anytime
- A task at 19:00 → Evening
- Deleting a section re-files a timed habit into the section now containing its time

## 3. Storage (Core schema 4)

Follow the existing pattern: add-only migration, exported schema JSON, and a `MigrationTest` case.

| Where | Change |
|---|---|
| `Records.kt` `HabitRecord` | `@ColumnInfo(defaultValue = "1") val remind: Boolean` (Remind Me). `@ColumnInfo(defaultValue = "'notification'") val alert: String` (`notification` or `alarm`; readers treat unknown values as `notification`). `@ColumnInfo(name = "follow_up_minutes") val followUpMinutes: Int?` (null = off; 15, 30 or 60) |
| `Migrations.kt` | `v3ToV4`: three `ALTER TABLE habit ADD COLUMN …` lines with those defaults |
| `HabitRepository.kt` | `SCHEMA_VERSION = 4`; `.addMigrations(…, Migrations.v3ToV4)` |
| `Core/schemas/…/4.json` | Exported by the build |
| `MigrationTest.kt` | 3→4 keeps every row, and the new columns hold their defaults |
| `Habit.swift` | `var remind = true`, `var alert: AlertStyle = .notification` (`enum AlertStyle: String { case notification, alarm }`), `var followUpMinutes: Int?` |
| `RecordMapping.swift` | Map the three fields both ways |
| `reminder` table | **Unchanged.** It now means "the habit's times". Keep the `ReminderTime` type and the table names (renaming costs a migration and buys nothing). In new UI code, call them *times*. Keep a time's `id` stable across edits (the form must load existing IDs, not make new ones) |
| `part` column | Still holds the single Day Section for a habit with no times. It is ignored for placement while times exist |

## 4. The New Habit form (`NewHabitView.swift`, `HabitForm`)

Replace `partSection` and `remindersSection` with two groups.
The order in the form: header → How Often → type section → **When** → **Reminders**.
Quit has neither group, as now.

### 4.1 WHEN

- **Row 1, `Day Section`:**
  - **No times:** a `Menu` with a single-choice `Picker` of `store.sections`, a `Divider`, and "New Section…" (existing `SectionEditor`).
  - **Times:** a plain `ValueRow("Day Section")` with no chevron, showing the placements' section names joined (“Morning, Evening”).
  - Accessibility label: “Day Section, Morning, Evening, set by the times”.
- **Time rows:** `⊖` + `DatePicker(hourAndMinute)`.
  - The label is the name of the section this time lands in, **when the habit shows a row there**. Otherwise (spread amount → Anytime) the label is “Time”.
  - Swipe to delete, as now.
- **`⊕ Add Time`:**
  - The first time defaults to the chosen Day Section's start + 60 min (9:00 for Anytime), which is the existing `nextReminderTime`. Later times default to 1 hour after the last.
  - If Remind Me is on and this is the first time, request notification permission first (existing `scheduler.requestPermission()`).
- **Removing the last time** sets `parts = [section(forMinute: that time).id]`.
- **To-do:** keep Date / Time / At in the task section. The Day Section row shows only while Time is off. With Time on, the "At" time places it, and the Reminders group shows with Remind Me. Map `taskRemind` onto `remind`; don't keep two flags.

### 4.2 REMINDERS (shown only when there is at least one time)

- `Toggle("Remind Me")`: default on.
- If on:
  - `Picker("Alert")`: Notification · Alarm. **Alarm is shown only on iOS 26+.** Choosing it requests AlarmKit permission; if denied, revert to Notification and show the denied footer.
  - `Picker("Remind Again If Not Done")`: Off · Every 15 min · Every 30 min · Every hour. **Hidden for Set a limit** (`atMost`).
- If notifications (or alarms) are denied: the footer says so and adds an **Open Settings** button (`UIApplication.openSettingsURLString`). This replaces today's text-only line.

### 4.3 The live sentences (exact wording; change only if the §6 test fails)

Build these in one pure function, `func outcome(for draft) -> (when: String, reminders: String?)`, so they can be tested.

WHEN footer:
- No time, Anytime: “Shows in Anytime on Today. Add a time to place it in a part of the day.”
- No time, a timed section: “Shows in Evening on Today (6:00 PM–12:00 AM). No reminder.” The hours come from the existing `hours(_:)`.
- Several rows (slots): “Shows in Morning and Evening, with a tick in each. Done for the day when both are ticked.” For 3+: “…when all 3 are ticked.”
- One row from times: “Shows in Morning on Today.”
- Spread → Anytime: “Shows once, in Anytime: an amount adds up across the day, so it isn't split.” For non-amounts: “Shows once, in Anytime: its times are in different parts of the day.”
- Period rules add: “Shows every day until you've done it 3 times this week.” (month/year likewise; totals: “…until you reach 180 min this week.”)

REMINDERS footer:
- Base: “A notification at 7:00 AM and 9:00 PM on days it's due.”
- Then “None for a time you've already ticked.” (slots), or “None once it's done for the day.” (single row), or for period rules “…each day until the week's 3 are done.”
- Alarm: replace “A notification” with “An alarm”, and add: “It rings even on silent or in a Focus, until you stop or snooze it. Stopping it doesn't mark it done.”
- Remind Again: “If not ticked, reminds you again every 30 min, up to 3 more times.”
- Remind Me off: “No notifications. The times only place it on Today.”
- Limit: “A notification at 8:00 PM each day it's due.”

### 4.4 Other footers (predictability fixes from report §5)

- **How Often:** when the habit isn't due today, add “First due Thursday, 2 Oct.” Compute it with `store.isDue` on the next 400 days; the created day is today.
- **Time it** section footer: “On Today, ▶ starts a timer; it counts toward \(minutes) min.”
- **Quit** footer: “The counter runs from here. It shows at the top of Today under Quitting, counting up.”
- **Round 4 strings to remove:** “To do it more than once a day, pick more sections…” and “Done N times a day: it shows in…”. Two times now say it.

### 4.5 Save

- `habit.reminders` = the times, with their IDs kept, sorted.
- `habit.parts` = `[chosen section]` (single).
- `remind`, `alert`, `followUpMinutes` as chosen (`followUpMinutes = nil` for limits).
- A **limit or amount with times** keeps them; placement handles the rest.

### 4.6 UI tests to update or add

- `NewHabitUITests.testCheckOffInTwoSections`: add two times (7:00 AM, 9:00 PM) instead of the multi-select menu. Assert “Day Section, Morning, Evening, set by the times”, then the Today rows and separate ticks, as now.
- `testChooserThenAmountWithReminderRemoved`: button titles change (“Add Time”, “Remove time”).
- New:
  - An amount with 3 spread times shows in Anytime (footer text + Today).
  - Remind Me off hides Alert and Remind Again.
  - Removing the last time keeps the section.
  - “First due” appears for a Mon/Wed/Fri habit created on another day.
- `LongTextUITests`: the Day Section menu screenshot still applies when there are no times.

## 5. Today (`TodayView.swift`, `TodayRows.swift`)

- Build each section's rows from `placements(of:)` (§2). A habit can appear in several sections only through slots.
- Row subtitle: append the row's earliest time, “0/1 · 7:00 AM”. For slot rows, show that section's time. Tasks already show their time.
- Sort within a section as in §2.
- **After Add:** `TodayView` gets the new habit's ID back from the sheet. It then:
  - jumps to today if another day is shown;
  - sets `foldOverrides[section] = true` for the new habit's first section;
  - scrolls to the row (`ScrollViewReader`) and highlights it for about 1.5 s. Use a row background flash that respects Reduce Motion.
  - If it isn't due today, do nothing extra: the form already said “First due …”.

## 6. Reminders (`ReminderScheduler.swift`)

### 6.1 Per-row planning

For each due day in the 7-day horizon, each placement row, and each time in that row, plan one alert unless:
- `remind == false`;
- the day is not due;
- for today, **that row** is done (`isSlotDone` for slots, `isDone` otherwise);
- or the fire time has passed.

Limits (`atMost`) still aren't suppressed by "done".
For period rules, "done" means the period goal is met; the current `isDone` already does this.

**Identifiers:** `reminder.<habitID>.<timeID>.<yyyy-m-d>`, as now. Follow-ups add `.f1`, `.f2`, `.f3`.
The existing `threadIdentifier` becomes the section ID, so iOS stacks a section's notifications together.

### 6.2 Same-minute grouping

After planning, bucket the notification-style requests by exact fire date.
- A bucket of **one**: the per-habit notification. Title = habit name; body as `reminderBody` today; for slot rows, prefix the section (“Evening · Time for floss”).
- A bucket of **2 or more**: **one** notification.
  - Title: the section name (“Morning”).
  - Body: the names, “Meds, Stretch, Floss +2”.
  - Identifier: `reminder.group.<yyyy-m-d>.<hhmm>`.
  - Category without Done (§6.5). Tapping it opens Today on that section.

This also saves slots in the 64-pending limit.
Keep the existing cap (60 pending, nearest first). Add a `BGAppRefreshTask` that runs `reconcile` about daily, so the horizon refills even when the app isn't opened. Register it in `HabitsApp` and add the `BGTaskSchedulerPermittedIdentifiers` Info key through build settings.

### 6.3 Remind Again If Not Done

- For each planned alert of a habit with `followUpMinutes = n`, also plan up to **3** follow-ups at `+n`, `+2n`, `+3n`. Stop earlier if a follow-up would fall past the day's end.
- Plan follow-ups only for **today and tomorrow**, to protect the pending budget; the reconcile and background refresh roll the window forward.
- Ticking the row triggers `store.onChange` → `scheduleReconcile`, which removes the pending follow-ups (they are no longer wanted). Also call `removeDeliveredNotifications` for that row, as the current "done today" code does, narrowed to the row's time IDs.
- Grouped (same-minute) alerts: follow-ups are planned **per habit**, never grouped, so each one can stop on its own tick.

### 6.4 Alarm (iOS 26+, AlarmKit)

- Wrap it in `if #available(iOS 26, *)`, in a new `AlarmScheduler` next to `ReminderScheduler`, reconciled in the same pass. Alarm-style alerts go to AlarmKit, not to `UNUserNotificationCenter`.
- Authorization: `AlarmManager.shared.requestAuthorization()` when Alarm is first chosen in the form. Add `NSAlarmKitUsageDescription`: “Habits rings an alarm at your habit's time when you choose Alarm for it.”
- Schedule one fixed-date alarm per planned alert and per follow-up. Keep an ID map (a setting key such as `alarm_ids`, JSON of our request ID → AlarmKit UUID) so reconcile can cancel exactly what is no longer wanted: done, edited, deleted, archived, or style changed.
- Presentation:
  - Title = habit name.
  - Stop button “Stop”.
  - Secondary button “Done” (marks that row done through an App Intent) if the AlarmKit version in use supports a custom secondary action; otherwise “Snooze”.
  - Check Apple's current AlarmKit docs for the per-app alarm limit and the secondary-button API before writing this. Don't assume.
- **Below iOS 26:** a habit saved with `alert = alarm` (for example, synced from a newer device later) falls back to a notification. The form shows Notification selected.

### 6.5 Notification actions (Ledger C252)

- Category `habit.single`:
  - Check / slot / task: **Done**.
  - Amount: **+\(increment) \(unit)**.
  - Time it and checklists: no action; tapping opens the app.
- Category `habit.group`: no actions.
- Handle them in a `UNUserNotificationCenterDelegate` set in `HabitsApp`. Map the request ID to (habit, time) → the row's slot → call the same store method a tap on Today would (`toggleSlot`, `toggleCheck`, `increment`). Only ever *add* a tick from a notification; don't untick. The store's write-then-show rule applies unchanged.

## 7. Day Sections editor (`DaySections.swift`)

- The `DaySectionsView` footer adds: “Habits with a time move with it.”
- `SectionEditor` delete message: “Habits without a time move to Anytime. Habits with a time move to the section their time is in.”
- `saveSections`: keep moving removed-section `parts` to Anytime (it only affects habits with no time now). Nothing to do for timed habits: placement is computed.

## 8. Upgrading existing data (dev builds only; the app hasn't shipped)

A one-time pass on load, guarded by a setting key `placement_v1`:
- **A habit with several `parts` and no times** (round 4 multi-section): give it one time per part at that section's start + 60 min, `remind = false`, and `parts = [first part]`. It keeps its rows, silently.
- **A habit with times and a `part` that disagrees:** nothing to do. The times now decide, which is the intended fix.
- If this is judged unnecessary because there are no real users yet, skip it and note that in Build Plan.md.

## 9. Don't

- Don't add a separate "time vs reminder" pair per row. One time, one Remind Me switch per habit.
- Don't use `.timeSensitive` or Critical Alerts. Breaking through Focus is only for Alarm, which the user chooses.
- Don't show Alarm below iOS 26, or Remind Again on limits.
- Don't store placement. Don't drop or rename columns.
- Don't change how the Start routine works beyond it reading placements.

## 10. Done means

- [ ] The report §6 test passes (4 of 5 per scenario, and no surprise alarm), or the failing wording is fixed and re-tested.
- [ ] All existing UI tests pass on the iPhone 16. The new ones in §4.6 pass. `LongTextUITests` passes on the iPhone SE simulator.
- [x] `Core` migration test 3→4 passes.
- [ ] A manual check on the device:
  - 7:00 AM and 9:00 PM on Floss: ticking the morning row before 7 means the 7:00 notification doesn't come, and the 9:00 one does.
  - Remind Again every 15 min: it stops at the tick.
  - Three habits at 8:00 give one grouped notification.
  - An Alarm rings on silent (iOS 26).
  - Editing Morning's start moves a timed habit.
- [ ] Build Plan.md has the new round with its status. This file's steps are ticked.

## Routine player: redesign pending (noted 28 Sep 2026)

The full-screen routine that ▶ Start opens isn't designed properly yet (the user). Don't test its UI until it's redesigned; see `Design Rules — Don't Regress.md`, "Not designed yet".

## Timers: not built yet (noted 28 Sep 2026)

From [Timing a Habit — Start, See and Stop](<../../../Research/Research Reports/Habit Creation/Timing a Habit — Start, See and Stop.md>). The rest of that report is built.

- **Stop from the Lock Screen.** A ⏸ button in the Live Activity (a `LiveActivityIntent` that calls `HabitStore.toggleTimer`). Three reviews ask for it. For now, tapping the Live Activity opens the app, where ⏸ is one tap.
- **A check when a forgotten timer is stopped.** For example, "Save 6 h 12 min for Read?" when a session runs far past its goal. Two reviews. For now, Undo Last Entry removes a wrong session.

## Sidebar reminder reliability — 30 September 2026

This supersedes the 7-day horizon and unconditional alarm Done button in §6. User priority: performance and reminder reliability, with no unanswered setup questions. Existing ledger C039/C123/C252 and reminder reports support optional alerts, predictable due dates and no ghosts after edits or completion.

- Plan 30 local calendar days; install the nearest 60 notifications, reduced to reserve slots for other app notifications and running timers. AlarmKit gets up to 30 nearest alarms; excess or failed alarms fall back to notifications when allowed. These are app budgets, not promises about Apple's undocumented AlarmKit maximum.
- iOS determines background execution. Opening the app, significant time changes, rule/progress changes and background refresh reconcile schedules. The menu shows actual permission and the latest confirmed scheduled alert; that date does not guarantee every item has that many days queued. The nearest-first limit is explained.
- Serialize scheduling passes. Coalescing cancels only delayed requests to start a pass, never a system write already underway. Unchanged notifications incur no add calls. Retry failed additions once, remove a failed stale replacement, re-read pending requests and report failures.
- Notification permission handles authorized, provisional and ephemeral consistently. Opening the page never requests permission; explicit buttons and iPhone Settings recover denial. Alarms require the person's separate choice and permission.
- Actions validate the current habit/time/configuration, due day, pause/archive/reminder switch and completion. Persist stable event IDs, including tombstones after undo, so retries cannot add an amount twice or revive an undone action. Distinct follow-up events can each add their increment.
- Alarm ownership/configuration is saved before scheduling. Ringing alarms remain only while their target is current; removed, edited, paused, completed or disabled alerts are cancelled. Duration and checklist alarms offer Stop without a Done button that cannot finish those types; amount actions name the actual increment.
- Use calendar wall times on the actual day, including overnight reminders and day end. Spring gaps use the next valid time; fall duplicates use the first occurrence once. Replan on significant time-zone/clock changes. No claim that a closed app can refresh fixed-date alarms immediately after travel.
- Remind Again: at most three follow-ups, today/tomorrow only, stopping at the next time or day end; none for limits. Same-minute grouping has no ambiguous Done action.
- CI covers controlled scheduling races/errors, cold-load identity and alarm metadata, replay after undo, stale/paused/archived/deleted actions, tasks, interval/calendar/period/flexible rules, leap months, DST, overnight clocks, travel wall times and budgets. Performance planning fixture: 100 reminders and >30,000 entries; median planning must stay under one second on the hosted simulator. Compare measured timings, not that loose failure threshold, for regressions.
- Physical iPhone checks still apply to sound, Focus/silent behavior, real AlarmKit delivery, reboot/background delivery and scroll hitches. Simulator/fake service checks prove planning/action rules and API builds; they cannot prove OS delivery on hardware.

Database failures cross the Kotlin/Swift boundary as caught errors (`@Throws(Exception::class)`). A successful read/open has its own state, independent of the dismissible message. An unavailable database preserves the system schedule and blocks actions, exports and writes until recovery; acknowledging an error never converts unknown data into an empty schedule. Corrupt-file and closed-database checks exercise the real bridge.
