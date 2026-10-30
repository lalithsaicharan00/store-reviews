# Decisions needed

Written by Claude (Claude Code), 30 October 2026, while finishing the Android design-system build
([Components — Atoms Build Plan](<Components — Atoms Build Plan.md>)). Every question, doubt and suggestion for the user is
here, and only here, one entry each, grouped by Figma page. Each says what the app does meanwhile, so nothing waits on
an answer. The first entries are the open ones carried over from the build plan's "Noted, not changed" notes (28–30 Oct);
the rest are added as each component is built.

Figma file: [Android app](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app). Code paths are under
`Android/app/src/main/kotlin/com/oftenenough/app/`.

## Design system

### D-1. Step row: 4 or 8 above and below the steps?

- **Where:** Step row (4.3), on the [design system page](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=493-2); `ui/components/StepRow.kt`.
- **What Figma shows / what the app did:** the component's description says the block takes 4 above and below; its only
  screen (Today › Steps open) draws 8.
- **What I did for now:** 8, as the screen draws it.
- **Question:** which is meant? (a) 8, and the description is updated; (b) 4, and the screen is redrawn.
- **My recommendation:** (a). The screen is the newer drawing, and 8 matches the gaps around it.

### D-2. Steps on Day details: a grey panel on the white card?

- **Where:** Step row (4.3) inside Day details' This day card; `ui/components/StepRow.kt`, `ui/day/DayDetails.kt`.
- **What Figma shows / what the app did:** the steps are Surface bright (the component's own fill) inside the white This day
  card, so they read as a grey panel of steps on a white card.
- **What I did for now:** as drawn.
- **Question:** (a) keep the grey panel; (b) the steps take the card's white inside This day.
- **My recommendation:** (b), so the card reads as one surface; only if you agree, since the component's fill is deliberate elsewhere.

### D-3. The Pale colours: only the medal, or earlier runs too?

- **Where:** Run row (4.5) and the Streaks page (5.6.2); `ui/components/RunRow.kt`.
- **What Figma shows / what the app did:** each Pale style's description says "the light end of the medal's gradient, and
  nothing else", but the Run row uses Pale for an earlier run's bar.
- **What I did for now:** as the Run row draws it (Pale bars).
- **Question:** (a) the Pale descriptions also name the Streaks page; (b) earlier runs take another colour.
- **My recommendation:** (a): the bars read well and match the medal they lead to.

## Onboarding

(Nothing open: 6.11 in the build plan settles Restoring's Cancel, Plus isn't on this phone and That isn't a backup.)

## Today

(Nothing open: 6.10 settles Paused, the notices and Edit Today's sorting.)

## Day details

### D-4. Dialogs and pickers: Surface container high or Surface bright?

- **Where:** Dialog (5.3.4), Time picker (5.3.5), Date picker (5.3.6); `ui/components/Dialog.kt`, `TimePickerDialog.kt`,
  `DatePickerDialog.kt`.
- **What Figma shows / what the app did:** each description names Surface container high (Material's own token); each
  frame is filled Surface bright.
- **What I did for now:** Surface bright, as drawn: on our grey page Surface container high is darker than the page.
- **Question:** confirm Surface bright, and the three descriptions are corrected?
- **My recommendation:** yes, Surface bright.

### D-5. Delete log: Text or Outlined button?

- **Where:** Log screen (5.3.2), [Figma 687:829](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=687-829); `ui/record/RecordScreens.kt`.
- **What Figma shows / what the app did:** Figma draws Delete log as a Text button five times and as an Outlined button twice.
- **What I did for now:** Outlined everywhere, as Delete note and Delete time of day.
- **Question:** (a) Outlined everywhere; (b) Text everywhere.
- **My recommendation:** (a): a destructive action reads better with its outline, and the other Deletes have one.

## Routine player

(Nothing open: 6.8 settles the skipped line and Your routine's rows.)

## Habits & Tasks

### D-6. "Next 25 Oct" or "Next Tue 27 Oct"?

- **Where:** Tasks page (5.5.4), [Figma 999:1061](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=999-1061); `ui/habit/TasksPage.kt`, `ui/habit/HabitsPage.kt` (`taskDay`).
- **What Figma shows / what the app did:** one row writes the next day as "Next 25 Oct", another "Next Tue 27 Oct".
- **What I did for now:** every row the same way (`taskDay`).
- **Question:** which form is meant everywhere?
- **My recommendation:** with the weekday ("Next Tue 27 Oct"): people plan tasks by weekday.

### D-7. Completed tasks' Figma description describes Archived habits

- **Where:** Completed tasks page (5.5.6), [Figma 1002:230](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1002-230).
- **What Figma shows:** the component's description is a copy of Archived habits'.
- **What I did for now:** built from the frames; only the Code line was added to the description.
- **Question:** may the description be rewritten to describe Completed tasks?
- **My recommendation:** yes.

## Details pages

### D-8. A quit habit's milestones: the page's numbers or the app's?

- **Where:** How milestones work (5.6.6), [Figma 1142:29063](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1142-29063); `ui/habit/HowMilestonesWork.kt`, the shared rule `MilestoneRule` / `quitMilestoneLadder`.
- **What Figma shows / what the app did:** the page says a quit habit reaches 3, 7, 14, 30, 60, 90, 180 and 365 clean days
  in a row, and 10 … 1,000 clean days in total. The app's quit milestones are 1, 3, 7, 10, 14, 30, 45, 60, 90, 120, 180,
  270, 365, 500, 730 days, then every year, with no total.
- **What I did for now:** the page shows Figma's words; the app gives the milestones it always has.
- **Question:** (a) the app follows the page (the shared rule changes, with its golden answers, T21); (b) the page follows
  the app.
- **My recommendation:** (a) only if you want fewer, rounder milestones; otherwise (b), because early quitters are
  helped by the 1-day and 10-day ones. A number people see changes only with your say (T21).

### D-9. "Next ·" on a quit habit's anniversary

- **Where:** All milestones (5.6.3), [Figma 1036:235](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1036-235); `ui/habit/ProgressTab.kt`.
- **What Figma shows / what the app did:** Water's next milestone says "Next ·", the Quitting screen's anniversary doesn't.
- **What I did for now:** "Next ·" on every next milestone.
- **Question:** confirm "Next ·" everywhere?
- **My recommendation:** yes, the same words for the same thing.

### D-10. "Cancel pause from …" in a habit's ⋮

- **Where:** Habit details (5.6.1), [Figma 1020:4052](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1020-4052); `ui/habit/HabitDetails.kt`.
- **What Figma shows / what the app did:** Figma's ⋮ has Pause… and Resume only. A pause set to start later (e.g. from
  Fri 30 Oct) keeps "Cancel pause from Fri 30 Oct" in the app's ⋮.
- **What I did for now:** kept: without it, a pause planned for later can't be taken back until it starts.
- **Question:** (a) keep it; (b) remove it (Resume appears only once the pause has begun).
- **My recommendation:** (a).

### D-11. The "Archived …, when Water changed to minutes" cards

- **Where:** Habit details (5.6.1); `ui/habit/HabitDetails.kt`.
- **What the app does:** a habit whose type was changed before A68 shows a card linking to the archived old habit. Figma
  has no such card; A68 ended type changes, so only habits changed before 23 Oct have one.
- **What I did for now:** kept, so those people can still reach their old history.
- **Question:** (a) keep for those habits; (b) remove (the old habit stays reachable in Archived habits).
- **My recommendation:** (b): Archived habits already holds it, and it's one less thing Figma doesn't have. Tell me and it
  goes with the cleanup.

### D-12. Add note on a task: which day?

- **Where:** Task details (5.6.5), [Figma 1136:9271](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1136-9271); `ui/habit/TaskDetailsParts.kt`.
- **What the app does:** a one-time task's note goes to the day it was done, else its planned day once it has come, else
  today; a repeating task's asks "Add a note to which day?" as History's Add (A81). Figma doesn't say.
- **Question:** confirm?
- **My recommendation:** yes.

## Create new

### D-13. Tell me at milestones: where does the switch go?

- **Where:** Create new form (5.7.3), [Figma 1065:2597](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1065-2597); `ui/newhabit/HabitForm.kt`.
- **What Figma shows / what the app did:** Figma's form has no "Tell me at milestones" switch, but How milestones work
  says "Tell me at milestones, on the habit’s form, also sends a notification".
- **What I did for now:** the switch stays at the end of a quit or cut-down habit's form.
- **Question:** (a) keep it there and add it to Figma's form; (b) remove it and the sentence (milestone notifications
  always on, or always off).
- **My recommendation:** (a): a quitter may not want a notification naming the habit.

### D-14. A name past 24 letters: snackbar or a line under the field?

- **Where:** Form field (3.1) and the forms (5.7.3); A65; `ui/components/FormField.kt`.
- **What Figma shows / what the app did:** Figma's Edit notes and A65 say a snackbar; the form says it in a line under the
  field.
- **What I did for now:** the line (U6).
- **Question:** (a) a snackbar, as A65; (b) keep the line.
- **My recommendation:** (a), as you decided in A65; the line can go with it.

### D-15. Duplicate a checklist on the free plan

- **Where:** How do you want to track it? (5.7.16); A73; `ui/newhabit/Choices.kt`.
- **What the app does:** a new checklist is Plus, but Duplicate on a checklist habit opens its form straight away, so the
  free plan can still copy one it has. Figma's Duplicate flow doesn't say.
- **Question:** (a) Duplicate a checklist opens Plus on the free plan; (b) leave it.
- **My recommendation:** (a), so the rule is the same wherever a checklist is made.

## Settings

### D-16. A time of day's name in red

- **Where:** Edit time of day (5.8.2), [Figma 830:265](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=830-265); `ui/settings/SettingsPages.kt`.
- **What Figma shows / what the app did:** past 16 characters, "That's the most: 16 characters." in Body Small Error (red).
  A65 keeps a habit's name field from ever turning red.
- **What I did for now:** red, as Figma.
- **Question:** (a) keep red here; (b) follow A65 (no red; the field just stops at 16).
- **My recommendation:** (b), so a name never turns red anywhere (U3's spirit).

### D-17. Keep reminders coming: check each phone maker's steps on a real phone

- **Where:** Keep reminders coming (5.8.1); `ui/settings/KeepRemindersComing.kt`; A40.
- **What the app does:** each maker's steps open that maker's page where Android lets an app name it, else App info. The
  makers rename and move these pages between versions; the emulator only shows "other phones".
- **Question:** can these be checked on a Samsung, a Xiaomi, a OnePlus and a vivo before release?
- **My recommendation:** yes, before release (W2: version-scoped evidence).

### D-18. Privacy policy: a Custom Tab needs one small library

- **Where:** Settings (5.8.3), [Figma 1173:547](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1173-547), the flow "Privacy policy"; `ui/settings/SettingsHome.kt`.
- **What Figma shows / what the app did:** "A Custom Tab over the app, from oftenenough.com … ✕ comes back."
- **What I did for now:** the row opens oftenenough.com/privacy in the phone's browser (`ACTION_VIEW`). A Custom Tab needs
  `androidx.browser`, a library the app doesn't have, and this work adds no libraries without you.
- **Question:** (a) add `androidx.browser` and open a Custom Tab; (b) keep the browser.
- **My recommendation:** (a): it's Google's own small library, and the tab keeps people in the app.

### D-19. Open-source licences: Google's screen needs Google's plugin

- **Where:** Settings (5.8.3), the flow "Open-source licences" (Figma: "Google’s own screen (OSS Licenses plugin)");
  `ui/settings/Support.kt` (`LicencesPage`).
- **What the app does:** its own short page listing six libraries by hand. It isn't complete (Play services, Billing,
  Glance, WorkManager and others are missing), and a hand list goes out of date.
- **What I did for now:** the row opens the app's own page.
- **Question:** (a) add Google's OSS Licenses Gradle plugin and its library, and open its screen; (b) keep the hand list
  and complete it.
- **My recommendation:** (a): the plugin lists every library the build really contains, which Google Play's rules on
  licences need.

### D-20. Backup & Sync row: the states Figma doesn't draw

- **Where:** Settings (5.8.3); `ui/backup/BackupScreens.kt` (`backupSummary`).
- **What Figma shows:** "Backed up · Today, 9:14 AM", "Backed up · Just now" and "Not backed up yet" ("the row follows
  the same status all the way").
- **What I did for now:** the other states use the Backup & Sync card's own titles: Backing up…, Waiting for the internet,
  Google Drive is full, Google Drive isn’t connected, Your Google Drive backup was deleted.
- **Question:** confirm, or give the words for these.
- **My recommendation:** confirm: the row and the card then always say the same thing.

### D-21. Sound when done: play it once when it's turned on?

- **Where:** Settings (5.8.3); `ui/settings/SettingsHome.kt`, `app/Chime.kt`.
- **What the app does:** the chime (the iPhone's Tick.wav) now plays when a log meets a goal, muted in silent and vibrate
  mode (it was a switch that did nothing). The iPhone also plays it once when Sound is turned on; Figma doesn't say.
- **What I did for now:** it doesn't play on turning on (A77).
- **Question:** (a) play it once on turning on, as the iPhone; (b) leave it.
- **My recommendation:** (a): people want to hear what they've turned on.

### D-22. Change account: Google's chooser first, or the question first?

- **Where:** Backup & Sync (5.8.5), [Figma 1178:960](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1178-960), the flow "Change account"; `ui/backup/BackupScreens.kt`, `app/backup/BackupCenter.kt`.
- **What Figma shows / what the app did:** Figma opens Google's account chooser first, then asks "Back up to another
  Drive?" naming the account chosen ("… back up to sam.work@gmail.com’s Google Drive"), with Cancel leaving it backing up
  to the old one. The app's Drive link chooses and connects in one step, so the app asks first ("Back up to another
  Drive?" … the Google Drive you choose; Choose account), then disconnects and opens Google's chooser.
- **What I did for now:** Figma's words, asked before the chooser, so it can't name the account yet. I didn't change how
  the Drive link connects (backup's own behaviour). One gap: backing out of Google's chooser after Choose account leaves
  the phone not backing up (the card says so: Not backed up, with Back up to Google Drive).
- **Question:** (a) split the Drive link's connect into "choose" and "connect", so the chooser comes first, the question
  names the account, and Cancel keeps the old one, as Figma; (b) keep the app's order.
- **My recommendation:** (a): Figma's order is safer (nothing changes until the person confirms the account they
  picked). It changes how the Drive link connects, so it's yours to allow.

### D-23. Undo last restore on Backup & Sync

- **Where:** Backup & Sync (5.8.5); `ui/backup/BackupScreens.kt`; Rulebook D5.
- **What Figma shows / what the app did:** Figma's Restore section has Restore from a backup only; a restore's Undo is in
  the snackbar on Today right after it. The app also shows "Undo last restore" under it for 30 days (D5: a restore keeps
  an undo file for 30 days).
- **What I did for now:** kept: once the snackbar has gone it's the only way to use that undo file, and removing it
  would make a safety copy of people's data unreachable.
- **Question:** (a) keep the row (and add it to Figma); (b) remove it (the undo file is kept but only the snackbar uses it).
- **My recommendation:** (a).

### D-24. New day starts at: every hour, or up to noon?

- **Where:** New day starts at (5.8.6), [Figma 1186:13870](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1186-13870); `ui/settings/SettingsPages.kt` (`NewDayStartsAtPage`); the shared rule in `Core/spec/day.md`, DAY-2.
- **What Figma shows / what the app did:** Figma lists all 24 hours, 12:00 AM to 11:00 PM. The shared day rule (iPhone and
  Android alike) takes 12:00 AM to 12:00 PM and clamps anything later.
- **What I did for now:** the page offers 12:00 AM to 12:00 PM (13 choices); the rule is unchanged.
- **Question:** (a) keep up to noon, and Figma's list ends at 12:00 PM; (b) every hour, which changes the shared rule
  (and which day people's logs count for), with its golden answers (T21).
- **My recommendation:** (a). A day starting in the afternoon or evening would put a morning log on the day before,
  which nobody expects; Figma's own intro speaks of being up "after midnight".

### D-25. Week starts on: Sunday, or the phone's region, by default?

- **Where:** Week starts on (5.8.7), [Figma 1186:13871](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1186-13871), the flow note "The default follows the phone's region"; `data/HabitStore.kt` (`weekStart`, `regionWeekStart`).
- **What Figma shows / what the app did:** Figma's default follows the phone's region (Monday in most of Europe and India,
  Sunday in the US). The app starts on Sunday until someone chooses (Current Work 99: "Sunday by default, never
  Automatic").
- **What I did for now:** Sunday, as it was. Changing the default would quietly move every week (week goals, week
  streaks, Progress) for anyone who never chose a day, including people already using the app.
- **Question:** (a) keep Sunday; (b) the region's day for new installs only, saved as a choice on first launch so
  nobody's weeks move later.
- **My recommendation:** (b): it's what people expect where weeks start on Monday, and saving it on first launch keeps
  existing people's weeks where they are.

### D-26. The timer switches are gone; should the timer always open full screen and always show in notifications?

- **Where:** the old Appearance page's Timers (removed with Theme, 5.8.8); `app/reminders/TimerNotice.kt`
  (`prefs.timerNotification`), `app/widgets/WidgetPublisher.kt` (`prefs.timerScreen`).
- **What Figma shows / what the app did:** Figma has no timer settings; its flows say the timer "opens full screen and
  starts at once" and shows "the same Live Update … one place for the timer". The app had two switches, Open timer full
  screen and Show in notifications, both on by default.
- **What I did for now:** the switches are gone from the screen (A77); the saved choices still work exactly as before
  (the build prompt: reminders' and widgets' behaviour stays), so someone who had turned one off keeps it off, with no
  way back on.
- **Question:** (a) always on for everyone, as Figma (the two saved choices stop being read); (b) put the switches back
  (in Figma too).
- **My recommendation:** (a): it's what Figma draws, what nearly everyone already has, and it removes a choice nobody
  can now change.

### D-27. Widgets still move done habits down; Today keeps them in place (A32)

- **Where:** the old Appearance page's Done habits (removed with Theme, 5.8.8); `app/widgets/WidgetPublisher.kt`
  (`sinkDone = prefs.doneOrder != "stay"`); A32.
- **What the app does:** A32 keeps done habits where they are on Today, with no setting, and the setting is gone. The
  widgets still read it: by default ("Move to bottom") a widget list moves done habits below the rest, so a widget and
  Today can show a different order.
- **What I did for now:** nothing changed in the widgets (their behaviour is locked, U28); only the setting's row is gone.
- **Question:** (a) widgets keep done habits in place too, as A32 and Today; (b) widgets keep moving them down.
- **My recommendation:** (a): a widget is Today on the home screen, and A32 was decided for the person's own order. It
  is widget work, so it waits for your yes and is checked on a phone (U28).

## Plus

### D-28. Plus: the states Figma doesn't draw

- **Where:** Plus (5.9.1), [Figma 1204:175](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app?node-id=1204-175); `ui/plus/PlusScreen.kt`.
- **What Figma shows:** the Plus screen for someone on the free plan only.
- **What I did for now:** with Plus already on (≡ › Plus), the same screen says "Plus is yours. Thank you for supporting
  Often Enough." with no Get Plus button, and the price line becomes "Plus stays with your Google Play account."; a
  payment Google Play is still waiting for says "Waiting for your payment. Plus turns on as soon as Google Play confirms
  it." in a snackbar (Today's notice says it too); "Payment not completed" is a dialog with Try again.
- **Question:** confirm these, or draw them (above all the menu's Plus for someone who has it).
- **My recommendation:** confirm, and add the "Plus is yours" state to Figma's Menu reason.

### D-29. "Restore from Google Play" and "I already have Plus" are gone

- **Where:** the old ≡ › Plus page and Get Plus (replaced by 5.9.1).
- **What the app does now:** Figma has no restore button; Google Play is asked what's owned every time the app starts or
  comes back, so a Plus bought before turns on by itself. Someone whose Plus doesn't appear has no button to press;
  onboarding's "Plus isn't on this phone" still has Check again.
- **Question:** (a) leave it to the automatic check; (b) add a "Restore purchase" row to the Plus screen and Figma.
- **My recommendation:** (a): Google Play hands the app every purchase on each check, so a button would do the same
  thing again; (b) only if support finds people looking for one after a reinstall.


## Widgets

## Notifications & alarms

## Cleanup
