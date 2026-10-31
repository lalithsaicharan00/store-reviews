# QA Flows — Often Enough Android app against Figma

Written by Claude (Claude Code), 31 October 2026, for the flow-by-flow QA pass the user asked for. Figma file:
[Android app](https://www.figma.com/design/sJptV3HAKYauEIGUxYS3qs/Android-app) (`sJptV3HAKYauEIGUxYS3qs`). Each flow is
a row of screens under a title frame; its node ID opens it (`?node-id=<id with - for :>`). Screens are listed in order,
by the caption Figma gives each one. Status: **not started** · **in progress** · **passed** · **blocked** (why).

Emulator: Pixel 10 Pro AVD (`emulator-5554`), Android 16, 1080 × 2400 at 480 dpi (Figma's 360 × 800 dp), account
`jeffreyjohn0112@gmail.com` (license tester). Set to `hw.keyboard=no` on 31 Oct 2026 (the old config is in
`Research/Temp/qa-flows/avd-config.ini.bak`): with a hardware keyboard reported, Gboard floated and never docked, so
no screen with a keyboard could be compared with Figma.

## Totals

| Page | Node | Flows | Passed |
|---|---|---|---|
| onboarding | 1:5 | 12 | 10 |
| today | 54:5580 | 84 | 65 |
| day details | 169:1270 | 44 | 0 |
| routine player | 234:2 | 24 | 0 |
| habits & tasks | 269:148 | 35 | 0 |
| details pages | 298:2 | 24 | 0 |
| create new | 381:2 | 28 | 0 |
| settings | 781:34017 | 23 | 0 |
| plus | 1166:15123 | 0 (the page holds only the Plus component set; its flows are on create new 18–20 and today 43) | — |
| widgets | 1232:173760 | 4 | 0 |
| notifications & alarms | 1265:24553 | 12 | 0 |
| **All** | | **290** | **75** |

## Bug log

Each entry: page · flow — what differed — how it was fixed (commit).

1. Onboarding · New to the app — No habits yet's line wrapped on its own ("…to do often / enough."); Figma breaks it
   after "like" (“Add something you’d like↵to do often enough.”, Body Large, 328 dp box) — the line break is in the
   app's text now (`TodayScreen.NoHabitsYet`, `FirstRunTest`).
2. Onboarding · New to the app — every Small button drew 8 dp narrower than Figma (New habit 129 dp against 137,
   Restore from a backup 215 against 223): the app used Material Expressive's 16/16 padding, Figma's Button (500:26)
   has 24/24, 16/24 with an icon — `AppButton`'s Small padding is Figma's now (`Button.kt`). Shared: every Small
   button in the app widens to Figma's.
3. Onboarding · Plus still not back — Restoring had no Cancel; Figma draws Cancel on every Restoring (582:7893). The Google Drive restore gained one: it stops the work and empties the phone again (it started empty), so nothing half-restored stays (`RestoreFlow.cancelDrive`).
4. Onboarding · Plus still not back — **bug:** Check again on Plus isn’t on this phone went to No backup found: the Plus gate empties the phone and lets go of Drive, so a second look found nothing. Check again now asks Google Play first and stays on the screen without Plus; with Plus it reconnects and brings Drive's copy down (`RestoreFlow.recheckDrivePlus`).
5. Onboarding · Plus still not back — the email's footer said “Often Enough 1.0 (4) (free)”; Figma 43:2413 says “Often Enough 1.0 (free)” (the version name alone).
6. Onboarding · Back from Google Drive — Today, habits restored (2.7) showed a snackbar “Your habits are back: …”; Figma's onboarding ends on Today with none. The restore route now knows where it started: from the empty Today nothing more is said, from Settings it still says what came back (`AppRoot` restore?from=settings, `RestoreFlow.onRestored`).
7. Onboarding · Back with a backup file — a file's Restoring (602:3305) showed no Cancel: it was offered only while Plus was checked, and dropped the moment the habits were written, so the screen faded to Today without it. Cancel now stays the whole restore: before the write it stops it (one transaction, rolled back), after it puts the phone back with the restore's undo file (`RestoreFlow.cancelFile`); Google Drive's Cancel also stays until the screen has gone.
8. Onboarding · Wrong Google account — **bug:** Try another Google account never showed a chooser: it let go of the account and Play Services handed the same one straight back, so the person landed on No backup found again. The Drive link can now ask for a choice (`DriveLink.connect(pick = true)`: Android's own account chooser, then Google's grant for the chosen account), used by Try another Google account and by Settings' Change account; the old account is only replaced once a new one is chosen, so Cancel keeps it.
9. Onboarding · No internet: checking Plus — **bug:** offline, the Plus check said Plus isn’t on this phone instead of No internet (9.6): Google Play answers from its own cache with no network, and an empty answer was taken as “no Plus”. An empty answer offline now counts as no connection; a cached purchase still counts (`PlayPlusStore.restore`).
10. Today · Check off a habit — the row's second line said the schedule (“Every day · 8:00 AM”) and kept the reminder after the habit was done; Figma's rule (flow 49): the goal for its period (Not done, 4/10 min, 2/3 this week), then “ | ” and the next reminder still to come, which goes once it's done (“Done”) (`StoreWords.rowLine`).
11. Today · Check off a habit — every habit row was 76 dp, Figma's is 72: the round button's 48 dp touch target added to 14 + 14. The row keeps the 48 target with 12 around it, so the icon, words and button sit exactly where Figma draws them (shared `HabitRowLayout`).
12. Today · demo data — the `design` demo was drawn from an older Figma frame (Meds already done, last in Morning). It now matches the Android file's Today (700:3219): Meds first and still to do at 57, one done in Afternoon and in Evening (`DemoData.design`).
13. Today · Log an amount manually — Day details' second button said “Log manually” (and an amount typed each time “Log amount”); Figma's Day details sheet (669:234) says “+1 | Log” and a single “Log” (`DayDetails` actions).
14. Today · Log an amount manually — tall sheets sat 6 dp lower than Figma: Material's sheet runs up behind the status bar and pads its handle down by it, while Figma's sheet edge is 6 dp above the status bar's bottom with the scrim above (87:178). One shared setting now places every modal sheet's edge there (`Modifier.belowStatusBar`, `sheetInsets`: Day details, the player's sheets, `AppBottomSheet`).
15. Today · An amount typed each time — Day details for a week's or month's goal said the day's amount (“$100 today”) over the period's total on a second line, under “This day”. Figma's Day details page draws the card as This week / This month, the period's total over its goal (“$300 of $500”, “140 of 300 this week”, “1 h 40 of 3 h”, “2 of 3 this week”), what's left at the end of the line (“$200 to go”, Goal reached), and for once-a-month Not done yet · Any day in October / Done this month · Done today at … (`DayStatus.make`, `DayDetails` card name).
16. Today · Time a habit — at the goal the running timer's ⏸ stayed grey; Figma fills it in the habit's colour the moment the clock passes the goal (723:11579). The row's button reads the live clock through a derived state, so it fills at the goal and the row recomposes once, not every second (`TodayRows.RowButton`).
17. Today · Time a habit — the Timer screen's day chip was the player's outlined chip; Figma's Timer screen (705:7745) draws it filled (Surface container, no border, 34 high) with a › after “Today”. `AppAssistChip(filled = true)`, asked for by the Timer screen through `HeroCard(filledDayChip)`; the player keeps the outlined one.
18. Today · Log time manually — a time habit's Day details said “Start timer | Log manually”; Figma says “Start timer | Log time” (725:5688).
19. Today · Tick checklist steps — **bug:** ticking the last step folded the steps by themselves after the pause; Figma keeps them open (“The steps fold only when you tap ⌃. Nothing folds by itself.”). The fold-later mechanism is gone (`TodayRows.StepsBlock`, `TodayLayout`).
20. Today · Quit: log a slip — the quit row said "Best 45 days"; Figma says when the run began ("Since 3 Oct"). Fixed in QuitRow.
21. Today · Quit: log a slip — limit rows read "0/2 cups max"; Figma reads "0 of 2 cups · 2 left", "Limit reached · 2 of 2 cups", "Over the limit · 3 of 2 cups", running "12:40 · 17 min left". Fixed in rowLine (limitLine).
22. Today · Quit: log a slip — Day details' button said "Record a slip"; Figma "Log a slip" / "Log another slip". Fixed in DayDetails' actions.
23. Today · Quit: log a slip — every record screen's date read "Today, 31 Oct 2026"; the user (31 Oct): the date alone, "31 Oct 2026". Fixed in recordDate. Figma's file still has "Today, 21 Oct 2026" in 60 Date rows.
24. Today · Quit: log a slip — the record screens' habit card was grey and 60 dp; Figma's List item is white there and 8 dp above and below (56 for one line). Fixed in AppListItem (all list items without content below) and HabitFact.
25. Today · Quit: log a slip — Time was as wide as its words (117 dp) with › beside the text; Figma's Time is 144 dp with › at the edge. Fixed in DateTimeRows/DatePiece.
26. Today · Quit: log a slip — "1 slip recorded" was split into a big 1 and small words; Figma has one headline. Fixed with DayStatus.words.
27. Today · Quit: log a slip — the demos' Smoking used the ⃠ icon; Figma uses smoke_free. Fixed in DemoData.
28. Today · Log a slip from the menu — the row menu had Arrange… and Pause…; Figma's is Edit habit · Pause · Add note · Skip today / Log a slip, with Add note's edit_note icon. Fixed in RowMenu (ScreensTest updated).
29. Today · Log a slip from the menu — the menu opened from the row's left at its words' width; Figma hangs it from the card's right edge, 4 below, 220 wide. Fixed in HabitRowLayout's anchor and RowMenu.
30. Today · Log a slip from the menu — menu items had Material's 12 at the sides; Figma's Menu item has 16. Fixed in AppMenuItem. Items stay Material's 48 high (Compose 1.5 hard-codes MenuListItemContainerHeight 48, the touch target) against Figma's 44; Material also opens the menu above a row near the bottom edge, where Figma draws it overlapping the bottom bar.
31. Today · Touch and hold a habit — a skipped row lost its round button; every Figma skipped row keeps it, switched off. Fixed in rowButton/RowButton.
32. Today · Touch and hold a habit — a switched-off filled icon button used Material's disabled greys (E3E3E3); Figma's is the button at 38 % (F0F0F0, tick B5). Fixed in AppFilledIconButton (also a past day's timer).
33. Today · Touch and hold a habit (the user, 31 Oct: disabled as Material 3 Expressive, in our colours) — Material's disabled is On surface 10–12 % for the container and 38 % for the content, not an opacity; on our neutral palette On surface 10 % is Surface container highest (E2E2E2), the enabled neutral and Tonal colour, so a literal copy reads as enabled. Ours: Surface container low (F3F3F3 / 2A2A2D dark), content On surface at 38 %, no habit colour, for every Filled, Tonal and icon button; Outlined's border Surface container highest. App: AppFilledIconButton, AppButton. Figma: State=Disabled added to Filled icon button (559:24, 2 variants) and Button (500:26, State property, 48 disabled variants); the 6 skipped rows on the today page use it.
34. Today · Pause a habit — Today's menu, Day details and the habit page opened a full Pause page (Pause until, Choose a date, Until I turn it back on, Starts, no snackbar); Figma has one Pause sheet everywhere. Fixed: AppRoot shows the Habits page's PauseSheet for all of them, with "Meds paused until Wed, 28 Oct" · Undo; PauseScreen, its route and pauseSummary deleted (A77), PauseWordsTest rewritten.
35. Today · Pause a habit — a bottom sheet added 24 under its buttons on top of the gesture bar (48 in all); Figma's 24 include the gesture bar. Fixed in AppBottomSheet.
36. Today · Pause a habit — Today's snackbar was 16 in and 12 above the day bar; Figma's is 12 in and 20 above. Fixed in TodaySnackbars.
37. Today · the day bar (the user, 31 Oct: its shadow should stand out as in Figma, with Material's own shadows) — the floating toolbar used Material's default elevation and barely showed (232 against the page's 238 under it); Figma's is 0/6/18 at 18 % + 0/1/4 at 12 %. Fixed with Material's Elevation Level 4 (8 dp, expandedShadowElevation): measured under the bar 184→229 against Figma's 190→238, the sides the same. Level 5 (12 dp) was darker and longer than Figma.
38. Today · the day bar's shadow (the user, 31 Oct: if Material's own shadow can't match exactly, use exactly the design's) — Material's levels were too weak (Level 3) or too dark and long (Level 4, 5). Now Figma's two shadows exactly with Compose's dropShadow: 0 6 18 black 18 % and 0 1 4 black 12 %, the toolbar's elevation 0; measured under the bar 188→231 against Figma's 190→238, the sides within 3.
39. Today · Pause until a date — Until a date… opened the picker a week ahead; Figma opens it on tomorrow. Fixed in PauseSheet.
40. Today · Pause until a date — dialogs dimmed what's behind them by Android's default 60 %; Figma's is Material's 32 % scrim. Fixed in the app theme (android:backgroundDimAmount 0.32, light and dark): an opacity, the same on every device.
41. Today · Pause until a date — the date picker ran edge to edge on a 360 dp phone (Material's dialog is a fixed 360) and, once narrowed, its week overflowed: Material's grid gives each day a 48 dp target plus 12 at the sides, which needs 360. Now built from Material's parts: 16 in from the screen's sides up to Material's 360, each day's target a seventh of the room up to Material's 48 (LocalMinimumInteractiveComponentSize; 43 on a 360 dp phone, as Figma's 43-wide days), Figma's 112 header (Material's is a fixed 120) with ✏ / 📅 to type, and Material's own button placement. Applies to every date picker (AppDatePicker).
42. Today · Resume a habit (the user, 31 Oct: keep the app's Paused row with its Resume button; Figma to follow) — the row said "Paused · back Sat, 7", cut off; now "Paused until 7 Nov" (the day it's back, as the snackbar says it), or "Paused" until resumed. Fixed in DayWords.paused (also the habit page).
43. Today · Resume a habit — Resume in Day details kept the sheet open with no message; Figma closes it and Today says "Meds resumed" · Undo. Fixed with DayNav.resumed and AppRoot's shared sayUndo (the Pause snackbar uses it too); the ⋮'s Resume habit the same.
44. Today · Resume a habit — a paused day said "Paused days don't count toward your streak" beside Paused; Figma puts "Back on Wed, 28 Oct" in the card's label instead of This day. Fixed with DayStatus.label ("Until you resume it" with no end).
45. Today · Resume a habit — Day details' plan line said "Every day · Morning" for Meds; Figma says "Every day · 8:00 AM": a habit with reminders shows their times. Fixed in planLine.
46. OPEN · Day details — the This day card's label and headline render 18 and 41 dp tall against their 16/36 line heights (Today's rows render exactly), so the card is ~8 dp taller than Figma; not font padding (tried) nor the font's metrics (hhea fits). To find on the Day details page.
47. Today · Resume a habit, Figma updated to the app (the user, 31 Oct) — Screen=Today's Paused row (752:15728, so all 9 screens): "Paused until 28 Oct", no streak, the ⋮ swapped for Button Style=Text "Resume", 8 at the end and no gap before it (the line 145 wide, as the app's); the flow's note says so.
48. Today · Several reminders in one time of day (new, the user, 31 Oct) — a row's line took the next of ALL the habit's reminders and never moved on by itself (its model was remembered without the reminder). Now each time of day's row shows its own next reminder (shownReminder), wakes when it passes (rememberShownReminder, one produceState loop, S3) and keeps the last once all have gone; the row model is keyed on it. Seen on the emulator on the real clock: 9:45 → 9:46 at 9:45:00 by itself, then 9:46 stays. Figma: new flow 1714:66792 on the today page (3 screens, arrows, rule notes).
49. Today · Skip a day — skipping from Day details left Today's row without Undo · Note; Figma shows them, as a skip from the menu does. Fixed: Day details' Skip offers them (setSkipped offer).
50. Today · Skip a day — a skipped day said "Doesn't count toward your streak"; Figma's Day details says "Your streak stays safe". Fixed in DayStatus.
51. Today · Skip a day, Figma — four Buttons faked as disabled by hand-set colours (Mark done, three Saves) now use Button State=Disabled; the cloned Disabled variants (both sets) had lost their Label / Icon glyph links, now relinked (74).
52. Today · Add a note by swiping right — the Note swipe showed note_add (edit_note with a note); Figma's is sticky_note_2. Fixed in noteAction.
53. Today · Undo a skip by swiping — before halfway the action said "Undo"; Figma says "Undo skip" all the way. Fixed in skipAction.
54. Today · Log a slip by swiping — before halfway the action said "Slip"; Figma says "Log a slip". Fixed in QuitRow.
55. Today · Add a note after a log — Save went back without a word; Figma says "Note saved". Fixed in NoteScreen (say).
56. Today · Add a note after a log — Day details' note row showed the note's text alone; Figma's is "Note" over the text (one line). Fixed in DayActivity (AppListItem supportingLines added, default unchanged).
57. Today · Add a note from Day details — the app also says "Note saved" here (one rule for every save; flow 27's frame has it, this flow's doesn't). Messages said under Day details now show on the sheet: it shows the app's one snackbar (LocalAppSnackbar).
58. Today · Change a note — Save stayed on the note's view; Figma goes back to Day details with "Note saved". Fixed in NoteScreen.
59. Today · Delete a note — the dialog said "Only the note for … is removed. That day's progress stays." · Delete note, and no Undo after; Figma: "Your logs for this day stay as they are." · Cancel | Delete, then "Note deleted" · Undo. Fixed in NoteScreen.
60. Today · Leave a note unsaved — the dialog said "What you wrote won’t be saved." · Keep writing; Figma: "What you typed won’t be saved." · Keep editing. Fixed in NoteScreen.
61. Today · Look at tomorrow — the "Planned for …" line was there but out of sight: the list kept its first card (Morning) in place when the line was added above it. A line that appears above the cards (Planned for, All done for today) now brings the list to its top when it was there already (TodayScreen).
62. Today · a folded section's discs — on Tomorrow, "4 planned" left Afternoon's name as "After…" and "Starts 1…"; Figma shows one disc and +3. The discs now give way to the name and time: as many as fit beside them whole, down to one and +N (SectionHeader, measured, so it works at any width and font size).
63. Today · a later day's rows — they said "8 glasses" with no 🔥 or button, and a task had a "Done today" button; Figma's Tomorrow draws "0/8 glasses", 🔥 23 and the round button. Rows now show the line and streak as on their own day, with the round button switched off (nothing is logged ahead) and a task's ✓ on, marking it done today (TodayRows; DoneTodayButton removed).
64. Today · demo data — Water showed 🔥 24 on Today where Figma's Today draws 23: its run was 23 days before today plus today. Now 22 before (DemoData.design).
65. Today · Go to a day — the calendar had Cancel and Go; Figma has neither: one tap on a date goes there (nothing is saved, so nothing to confirm), and tapping outside or Back closes it. AppDatePicker takes atOnce (no buttons, 20 under the weeks, as Figma); Go to a day uses it.
66. Today · the day bar's date — "Tue, 13 Oct"; Figma's day bar writes "Tue 13 Oct". DayWords.bar.
67. Today · a new habit (A47) — Add still lit the new row and said "Added to the end of Anytime" with Move; A47 and Figma: a new habit just appears at the end of its time of day, no highlight, no snackbar, no Move. Removed with their code (TodayScreen's snackbar and lit row, HabitRowLayout's flash, TodayActions.arrange and ArrangeLift, Arrange's lifted habit); Today still opens its time of day, and scrolls only when the new row is off the screen.
68. Today · the day ring — it counted a part-done habit's share (1 of 8 glasses drew a sliver at 0/1); Figma's Floating toolbar: "Set the arc to match Count" (Today's 4/13 arc is exactly 4/13). DayScore.fraction is now done of planned.
69. Today · Nothing planned — its words ran the screen's width (one long line and a short one); Figma's Nothing planned narrows them to 280 dp. EmptyState takes bodyWidth, a cap, so it still fits any phone and font size.
70. Today · notice card (Card notice 795:466) — 168 dp tall with its buttons 5 lower than Figma's 160: the Text buttons' 48 dp touch target added 4 above and below their 40 on top of Figma's 4 and 8. CardNotice now takes that 4 back from the padding on each side (the touch target stays 48); measured 160, buttons at 112, as Figma. (Its body breaks a word earlier in Figma: same style and width, font rendering.)
71. Today · Backup is off → Reconnect — it reconnected in silence (Play Services handed back the account it knew, no chooser) and said nothing; Figma: Google's account chooser rises over Today, then (only if access was removed) Google's permission page, and back on Today the notice goes with "Google Drive connected · sam@gmail.com". Reconnect now asks with the chooser (connectDrive(pick = true)) and says the account; DriveLink gives its email (BackupScreens' driveEmail no longer parses it out of the name). Checked with the real Drive and the emulator's test account.
72. Today · Back up again's card — while the files were being counted the bar sat flat and empty for ~4 s (WorkingNoticeCard passed 0); Figma draws the wavy line at work. It now passes no count until there is one, so CardNotice shows Material's moving wave, then the line fills as each file is saved. Checked with the real Drive (test account): deleted → Backing up → Backed up for a moment → the card folds away.
73. Keep reminders coming's lead — it said the phone's first words ("Two steps keep Often Enough awake.") whatever was done; Figma's flows 38 and 39 say what's left: "… One step left.", "All set. Reminders will come on time.", and with Alarms & reminders off "Reminders may come late. Android sends them on time only when Alarms & reminders is allowed. It's Android's setting, not the app's." keepLead works it out (ReminderWordsTest.leadFollowsWhatsLeft).
74. Today · a missed or late reminder's notice stayed after everything was fixed; Figma: back on Today the notice is gone (a notice ends when its problem is fixed elsewhere). It now goes once Keep reminders coming has nothing left to do, and the reminder it was about is cleared.
75. Today · a reminder that came late had the paused-bell icon; Figma's late notice has the clock (schedule). Test launches can force it (notice "late", 40 minutes, as Figma draws it).
76. Today · Reminders can't come → Turn on — it went straight to Android's notification settings; Figma asks with Android's own question while Android will still ask, and only after two refusals opens the settings (flow 42); either way, back on Today the notice goes with "Reminders are on". One shared helper does it (rememberTurnOnNotifications, beside openSettingsPage), used by Today's notice and Keep reminders coming's Allow.
77. Today · the notice didn't show when the first habit with reminders arrived (a restore, or the demo), only on the next return to the app: it was worked out again only every 50 data changes. Whether any habit wants reminders is now one of its keys.
78. Day details · a cut-down habit's line said "At most 2 cups a day · Anytime"; it sits in Quitting, not a time of day, and Figma says "At most 2 cups a day". planLine leaves the time of day out for a limit (its reminder times still show).
79. Timer · a limit's wave was in the habit's colour; Figma: "The wave stays neutral" (Outline on Outline variant). ProgressLine draws a limit's wave neutral below the limit (over it, the flat grey line as before).
80. Day details · a limit not yet reached said "Limit 30 min · within max"; Figma: "Limit 30 min · 30 min left", "Limit 2 cups · 1 cup left" (StoreWords).
81. Today · a timed limit's running line said "29:07 · 0 min left" in its last minute, and called 30:20 over the limit while its count said 30 of 30: it now says at least "1 min left" and counts whole minutes, so 30:00–30:59 reads "Limit reached · 30:xx" (Figma's frame 4), on the row and in Day details alike.
82. Today · a tap that couldn't be saved said "Couldn’t save that tap. It’s undone." with nothing to do; Figma: "Couldn't save Meds. Nothing changed." with Try again. A failed tap now carries the habit's name and a retry (HabitStore.failedTap); the snackbar is cleared only once shown (clearing it first restarted the effect and took the snackbar away). Test launches can fail the first tap's save (failTap) to see it.
83. Today · a long name took two lines ("Take vitamins / with water"); Figma and A49: a name is always one line on Today, ending in …, with the full name in Day details. HabitRowLayout's name is one line. (At 200 % the rules hold: one-line names, two-line headers, taller rows; the sizes are Android's own large-text scaling, so a header's Start can wrap where Figma's drawing fits it.)
84. Edit Today · rows were 64 dp: the 48 dp handle sat inside Figma's List item padding (56 for one line, 72 for two). The padding is 4 less beside the handle; rows measure 56 and 72.
85. Edit Today · the avatars drew the habits' filled icons; Figma's List item draws them outlined (Material Symbols fill 0), as the icon picker does (HabitIcons.outlined).
86. Edit Today · a paused habit sat apart at the end, with no handle; Figma lists it in its time of day like any row, "Paused" under the name, with its handle. Paused habits are now ordinary rows (the separate paused block is gone).
87. Edit Today · a times-a-week habit had an empty second line; Figma: "3 times a week" (arrangeSubtitle falls back to the plan).
88. Edit Today · while carrying a row, the gap it left was empty; Figma draws "Drop here": a dashed outline, Outline, 1 dp, 6 on 4 off, in the row's shape. Drawn in the row's place, under the carried row.
89. Today · demo data — paused Meditate was in Evening; Figma's Edit Today has it in Morning (DemoData.design).
90. New time of day · Your day listed "New time of day · New" before a start was picked, with no footer; Figma lists the new one once its start is chosen, and under Your day says "Each time of day ends when the next one starts. This is your day once you add this one."
91. Edit time of day · the last time of day's end said "12:00 AM, when your new day starts"; Figma: "12:00 AM, when the day ends".
92. Edit time of day · Add/Save asked "Split Evening?" and changed rows said "Was …"; neither is in Figma (Add puts Night straight in). Both removed (A77); splitting loses nothing.
93. Edit Today · an empty time of day showed nothing under its heading; Figma: "Drag a habit here" in a dashed box (Outline, 1 dp, 6 on 4 off, corners 24), the same drawing as the drop slot.
94. Edit Today · Anytime's handle stepped the card one place per 64 dp dragged, with nothing lifted and no word when it was let go; Figma 62:2: the whole card (heading and rows) lifts and follows the finger on the page's colour, corners 24, Elevation Level 3, a dashed outline where it will land, the others making room; let go, it's saved and the snackbar says "Anytime moved to the top" with Undo. Built that way (`HabitStore.placeCard`; Undo puts it back); a card passes another when its leading edge crosses that card's middle.
95. Time picker (Today flows 51, 52; every dialog, menu and sheet in Surface) · the dialog was #DFDFDF, not Figma's #F9F9F9: the theme set Surface tint to Transparent, which Material lays over Surface at its elevation's alpha, so black at ~11 % darkened every raised surface coloured Surface. Surface tint is now Surface's own colour (light and dark), which changes nothing (`ui/theme/Theme.kt`).
96. Time picker · the focused hour or minute box had a grey (Outline) 2 dp border; Figma (and Material) draw it Primary, #303030. Set in the shared picker (`ui/components/TimePickerDialog.kt`).
97. Edit time of day · "Delete Morning?" said "Its 4 habits move to Anytime. Their logs, notes and streaks stay."; Figma: "Its 4 habits will move to Anytime."
98. Every dialog (Dialog 5.3.4) · 280 dp wide, Material's minimum for short text; Figma's component: 312 (the width less 24 each side, 280–560). `AppDialog` now fills the width less 24 each side. Its 12 dp of extra height is D-47.
99. Delete a time of day · its habits kept their old places among Anytime's (Meds, Stretch and Skincare before Read); Figma: at the end of Anytime, in their order. `deleteSection` puts them there once the move is saved.
100. Delete a time of day · back on Edit Today the list stayed at its top; Figma's frame 5 shows Anytime, where the habits went. Edit Today now scrolls to Anytime after a delete.
101. Milestone band (Today rows, the player's ribbon) · "30 days in a row · reached today" ("· yesterday" for a quit or limit); Figma's rule 156:47: the band names the milestone only, in the pop-up's words, and no Figma band or ribbon has a suffix. The band is the title now ("7 days in a row again" for a repeat); the pop-up keeps "Meds · reached today". Test launches gained `streak` ("Meds=29") and `moments=used` to set up the milestone flows.
102. Timer screen and routine player · the wavy line drew a taller wave than Figma's: the player gave Material's line 16 dp and its wave grows with its height; Figma's atom (902:14527) and frames are 10 dp. Now 10. (The timer frame's own hand-drawn wave is tighter than the atom; the app follows the atom, Material's.)
103. A running row's line · "9:24 of 10 min" had wide spaces: tabular figures on the whole line widen Google Sans Flex's spaces; Figma's line is plain Body Medium. Only the clock takes them now (`HabitRowLine`).
104. A running timer crossing its goal · only the ⏸ filled: 🔥 stayed 29, no chime, no band until the timer stopped (nothing was saved while it ran). The user chose (A87, D-48): at the goal the time so far is saved as the session's log and the timer counts on; the stop makes it the whole session (one log). The store sleeps until each running timer's goal (no ticking) and works on Today, the timer screen and the player alike; a restart picks a reached session up where its log ends.
105. Quit clock and every clock or count with a space ("30d 11:30:18", a log's "10:30 AM", the Habits page's period, the history card's detail, the running line) · tabular figures on the whole text widened its spaces beyond Figma's plain lines. One helper, `tabular()` beside the text styles, applies them to everything but the spaces; all five use it.
106. Milestone bar · 16 dp above the day bar; Figma: 10 (614–686, day bar at 696). The empty snackbar host kept its 8 dp under the bar's own 8; it now takes its 8 only while a snackbar shows, and the bar has Figma's 10.
107. A number reached again · the band read "7 days in a row"; Figma: "7 days in a row again" (its bands say "again" for a length reached before a break: "30 days clean again" too). The app said it only for a best run again (14 or more); it now says it for any length reached before, worked out from the earlier runs, so a first-time milestone shown as just the row stays plain. Test launches gained `earlier` ("Meds=7"); a set Smoking run is its first.
108. Milestone pop-up · "All milestones" was cut to "All mileston…": its two half-width buttons kept 24 at the sides; they're `compact` (12), as every button that shares a row in halves.
109. Milestone pop-up and every bottom sheet · the buttons sat on the gesture bar (0 gap), in Figma's components too (the user). A88: 12 above the 24 dp gesture area. Figma's Bottom sheet and Milestone pop-up components now keep 36 at the bottom, their 13 placements moved up 12 (one Day details sheet that ran 8 past its screen now ends on it); `AppBottomSheet` keeps 36.

¹ Onboarding 10, 10.8–10.10: checked with the one Google account on the emulator (the chooser opens, Cancel keeps the account, picking goes to Restoring). A second account holding a backup can't be added here; its Restoring → Today is flow 2's, which passed.
² Today 38: checked on the Pixel emulator (one step, the battery). Samsung's steps (Never auto sleeping apps) need a real Samsung, as Figma's note says.
³ Today 40: each maker's lead, steps, paths and icons compared word for word with Figma's six pages (KeepRemindersComing.maker, ReminderWordsTest); the Pixel page run on the emulator. The other makers' pages open their own settings screens and need real phones (A40, Figma's note).
⁴ Today 43: the notice (forced) matches Figma and Open Google Play opens Play; a payment that Play holds and then finishes can't be made on this emulator (see the Play purchase question). The notice reads PlayPlusStore.pending, which is observable state, so it goes when Play finishes.

## Open questions for the user

Every question for the user is in [Decisions needed](<Android/Docs/Decisions needed.md>), one entry each, by Figma page (the QA pass's are D-37 to D-48, moved there 31 Oct 2026). The parcel's day is settled by A86: a task is on the day it's planned for, "Task · Once", never "due". Add log's date in Today flow 4 is settled by A82 (the date alone).

---

## Onboarding (1:5)

| # | Node | Flow | Screens | Status |
|---|---|---|---|---|
| 1 | 31:5578 | New to the app | Splash → Today, no habits yet | passed |
| 2 | 39:1532 | Back from Google Drive | Splash → Today, no habits yet → Restore from a backup → Choose a Google account (native) → Allow Google Drive (native) → Restoring → Today, habits restored | passed |
| 3 | 39:2021 | Plus didn’t come back | Splash → Today, no habits yet → Restore from a backup → Choose a Google account → Allow Google Drive → Restoring → Plus isn’t on this phone → Restoring → Today, habits restored | blocked: 3.1–3.7 pass (the same screens as flow 4, checked there). 3.8–3.9 need Plus to arrive while the screen is open, which needs a real Google Play purchase — see Open questions |
| 4 | 39:2697 | Plus still not back | Splash → Today, no habits yet → Restore from a backup → Choose a Google account → Allow Google Drive → Restoring → Plus isn’t on this phone → Email | passed |
| 5 | 39:3228 | From an iPhone, with Plus | Splash → Today, no habits yet → Restore from a backup → Choose a file (native) → Restoring → Plus isn’t on this phone (iPhone) → Email | passed |
| 6 | 39:3744 | From an iPhone, without Plus | Splash → Today, no habits yet → Restore from a backup → Choose a file → Restoring → Today, habits restored | passed |
| 7 | 39:4212 | Back with a backup file | Splash → Today, no habits yet → Restore from a backup → Choose a file → Restoring → Today, habits restored | passed |
| 8 | 39:4635 | No internet: Google Drive | Splash → Today, no habits yet → Restore from a backup → No internet → Choose a Google account → Allow Google Drive → Restoring → Today, habits restored | passed |
| 9 | 39:5144 | No internet: checking Plus | Splash → Today, no habits yet → Restore from a backup → Choose a file → Restoring → No internet → Restoring → Today, habits restored | blocked: 9.1–9.6 pass (offline, the Plus check says No internet; Try again offline stays; back online it checks again). 9.7–9.8 need Plus to come back from Google Play, and Play won't sell Plus to this sideloaded build — see Open questions |
| 10 | 39:5757 | Wrong Google account | Splash → Today, no habits yet → Restore from a backup → Choose a Google account → Allow Google Drive → Restoring → No backup found → Choose a Google account → Restoring → Today, habits restored | passed ¹ |
| 11 | 39:6436 | Wrong file | Splash → Today, no habits yet → Restore from a backup → Choose a file → That isn’t a backup → Choose a file → Restoring → Today, habits restored | passed |
| 12 | 39:6935 | Backup from a newer version | Splash → Today, no habits yet → Restore from a backup → Choose a file → From a newer version | passed |

## Today (54:5580)

| # | Node | Flow | Screens | Status |
|---|---|---|---|---|
| 1 | 68:2 | Check off a habit | Today → Tap ✓: Meds fills; Undo · Note appear | passed |
| 2 | 117:2 | Check off several times a day | Stretch breaks 1 of 3 → ✓ 2 of 3, plain → ✓ 3 of 3, fills and chimes → ✓ again: 4, still counts | passed |
| 3 | 71:2 | Add an amount | Water 5 of 8 → + 6 of 8; Undo · Note → + twice: 8 of 8 → past the goal 9 of 8 | passed |
| 4 | 87:2 | Log an amount manually | Water 5 of 8 → Day details → Log manually: Add log, 2 → Added: 7 of 8 → Swipe down: Today; Undo · Note | passed |
| 5 | 119:2 | An amount typed each time | Savings $250 of $500 → Log: Add log $50 → Add: $300; Undo · Note → Day details | passed |
| 6 | 73:2 | Time a habit | Stretch 4 of 10 min → ▶ timer opens and starts → ⌄ row keeps the clock; ⏸ → goal: fills, chimes → ⏸ saved; Undo · Note | passed |
| 7 | 95:2 | Log time manually | Stretch 4 of 10 → Day details → Add log, 5 min → 9 of 10 → Swipe down: Today | passed |
| 8 | 75:2 | Tick checklist steps | Skincare 1 of 4 → ⌄ steps open → tick: 2 of 4 → last step: fills → ⌃ folds | passed |
| 9 | 77:2 | A week or month goal | Call family 2 of 3 this week → ✓ 3 of 3 → rest of week stays full | passed |
| 10 | 120:2 | Do a task on Today | Pick up parcel → ✓ done; Undo · Note → stays done in place | passed |
| 11 | 79:2 | Quit: log a slip | Smoking 19 days → Day details → Add slip → 1 slip recorded → Swipe down: run starts again | passed |
| 12 | 81:1657 | Log a slip from the menu | Today → hold Smoking: menu → Add slip → back on Today; Undo · Note | passed |
| 13 | 122:2 | Touch and hold a habit | Today → hold Meds: menu → Skip today: skipped; Undo · Note | passed |
| 14 | 122:550 | Pause a habit | Today → hold Meds → Pause Meds sheet → Pause: leaves Morning; snackbar Undo | passed |
| 15 | 137:2 | Pause a habit until a date | Today → menu → Pause sheet (1 week) → Until a date…: date picker → 30 → OK: Back on Fri, 30 Oct → Pause | passed |
| 16 | 122:1300 | Resume a habit | Paused card → Day details, Paused → Resume habit; snackbar Undo | passed |
| 17 | 84:2 | Undo and Note follow the latest log | Water 6 of 8 → + on Water: buttons on Water → ✓ Call family: buttons move → Start a routine: buttons go | passed |
| 18 | 139:5 | Undo clears the buttons | Water 6 of 8 → + → ✓ Call family → Undo: check taken back, buttons gone | passed |
| 19 | 85:2 | Skip a day | Meds not done → Day details → Skip today → Swipe down: Meds skipped | passed |
| 20 | 85:780 | Skip by swiping | Meds → swipe left: Skip → past halfway: dark, Skip today, tick → let go: skipped | passed |
| 21 | 124:2 | Add a note by swiping right | Today → swipe right Water: Note → past halfway: Add note → let go: Add note | passed |
| 22 | 124:647 | Undo a skip by swiping | Meds skipped → swipe left: Undo skip → dark → let go: not done | passed |
| 23 | 124:1376 | Log a slip by swiping | Smoking → swipe left: Log a slip → dark → let go: Add slip | passed |
| 24 | 124:2081 | Swiping where there's nothing to do | Today → week goal springs back → cut-down springs back → task springs back | passed |
| 25 | 90:2 | Add a note after a log | Water 5 of 8 → + 6 of 8 → Note: Add note → type: Save on → Save: Note saved → Day details shows it | passed |
| 26 | 90:828 | Add a note from Day details | Water → Day details → Add a note… → Save: shows here | passed |
| 27 | 91:2 | Change a note | Water → Day details with note → Note → Edit note → Save | passed |
| 28 | 91:607 | Delete a note | Water → Day details → Note → Delete this note? → Delete; Undo | passed |
| 29 | 91:1143 | Leave a note unsaved | Water → Day details → note typed → ✕: Discard this note? → Discard | passed |
| 30 | 99:2 | Log yesterday | Today → ‹ Yesterday; Back to today → ✓ Meds for yesterday → Back to today: streak 58 | passed |
| 31 | 100:2 | Look at tomorrow | Today → › Tomorrow → Water: Day details for tomorrow → ✕ → Back to today | passed |
| 32 | 101:2 | Pick a day | Today → Today ▾: Go to a day → 13: Tue 13 Oct → Back to today | passed |
| 33 | 104:2 | No habits yet | Splash → No habits yet → Added: first habit → + 1 of 8 | passed |
| 34 | 104:419 | Nothing planned today | Nothing planned today → › Tomorrow, Gym → Back to today | passed |
| 35 | 125:2 | Notice: backup is paused | Backup is paused → backed up: notice gone | passed |
| 36 | 125:371 | Notice: backup is off | Backup is off → Reconnect: account chooser → pick account → Continue: notice gone; snackbar | passed |
| 37 | 125:807 | Notice: your backup was removed | Backup deleted → Back up again: backing up → Backed up → card gone | passed |
| 38 | 125:1173 | Notice: a reminder didn't arrive | Reminder didn't arrive → Show me how: Keep reminders coming → Open → Back → Open → Back: all set | passed ² |
| 39 | 151:2 | Notice: a reminder came late | Came late → Show me how: Alarms & reminders off → Open settings → Back: all set → ← Today | passed |
| 40 | 151:498 | Keep reminders coming on each phone | Xiaomi notice → Xiaomi → OnePlus/OPPO → vivo → Honor/Huawei → Pixel and others | passed ³ |
| 41 | 125:1537 | Notice: reminders can't come | Reminders can't come → Turn on: Android's question → Allow: notice gone | passed |
| 42 | 153:206 | Notice: reminders can't come (won't ask again) | Reminders can't come → Turn on: notification settings → Back: notice gone | passed |
| 43 | 125:1901 | Notice: Plus is waiting for payment | Plus waiting for payment → Plus is on: notice gone | passed ⁴ |
| 44 | 116:2 | Cut down: an amount | Coffee 1 of 2 → + Limit reached → + Over the limit → Day details | passed |
| 45 | 116:987 | Cut down: a time limit | Social media 0 of 30 → ▶ timer vs limit → ⌄ → 30:00 Limit reached → ⏸ at 42 min: Over the limit | passed |
| 46 | 126:362 | A new habit appears | Today (after + → form → Add) → Journal at the end of Morning | passed |
| 47 | 126:900 | Couldn't save a tap | Meds → ✓ shows at once → save failed: goes back; snackbar | passed |
| 48 | 126:1437 | Long names and large text | Today → 24-letter name, one line … → 200 % font | passed |
| 49 | 232:2 | What a row's second line says, with reminders | goal · reminder after a \| → ✓ Meds: reminder time goes | passed |
| 50 | 57:2 | Arrange Today | Today → ✏ Edit Today → drag Read into Evening → dropped; Undo → ← Today | passed |
| 51 | 59:4 | Change a time of day | Today → Edit Today → ✏ Morning: Edit time of day → Starts: time picker → 7:00 AM → Save | passed |
| 52 | 59:712 | Add a time of day | Today → Edit Today → Add time of day → Starts: picker → 10:00 PM → Add: Night | passed |
| 53 | 62:2 | Move Anytime or Quitting | Today → Edit Today ⠿ → drag Anytime to top → dropped; Undo → ← Today | passed |
| 54 | 65:2 | Delete a time of day | Today → Edit Today → ✏ Morning → Delete Morning? → habits to end of Anytime | passed |
| 55 | 65:717 | Fill a new time of day | Today → Night empty → drag Bed on time into Night → dropped | passed |
| 56 | 107:2 | Milestone on the row: a check | Meds 29 → ✓ 30; band rises under Undo · Note → after next log: band stays all day | passed |
| 57 | 107:544 | Milestone on the row: an amount | Water 7 of 8, 29 days → + 8 of 8; band rises → + past goal: never plays again | passed (Water sits in Anytime in the demo, Morning in Figma's frames; also checked through Add log: the band rises once the sheet has closed) |
| 58 | 107:1091 | Milestone on the row: a timer | Stretch 4 of 10 → ▶ → ⌄ → crosses 10:00: fills, chimes, band rises | passed |
| 59 | 107:1654 | Milestone on the row: a checklist | Skincare 1 of 4 → ⌄ → tick Serum → last step: band rises; steps stay open | passed |
| 60 | 107:2429 | Milestone on the row: quit, no tap | Open the app: 30 days clean → Quitting on screen: band rises once | passed |
| 61 | 108:2 | Milestone bar: one milestone | Meds 2 → ✓ 3: bar above the day bar → after 5 s/touch: bar goes, band | passed |
| 62 | 108:561 | Milestone bar: the next one replaces it | Stretch past 10, Meds to do → ✓ Meds: bar → ⏸ Stretch: Stretch's bar → 5 s: band | passed (under A87 Stretch's bar comes as its clock crosses 10:00, not at ⏸, as Figma's own flow 58: tested with Meds' bar up when Stretch crossed; Meds' bar went, its band stayed, Stretch's bar rose, then its band) |
| 63 | 108:1308 | Milestone: a number reached again | Meds 6 (had 7) → ✓ 7: just the row → band stays | passed |
| 64 | 110:2 | Pop-up: your first milestone | Meds 2 → ✓ pop-up once taps stop → Close: band | passed |
| 65 | 110:592 | Pop-up: a month in a row | Meds 29 → ✓ pop-up → Close | not started |
| 66 | 110:1179 | Pop-up: a year in a row | Meds 364 → ✓ pop-up → Close | not started |
| 67 | 110:1766 | Pop-up: weeks of goals met | Call family 2 of 3 (25 weeks) → ✓ pop-up → Close | not started |
| 68 | 110:2353 | Pop-up: months of goals met | Deep clean 0 of 1 (5 months) → ✓ pop-up → Close | not started |
| 69 | 110:2937 | Pop-up: a yearly anniversary | Meds a year ago → ✓ One year of Meds → Close | not started |
| 70 | 111:2 | Pop-up: quit, from its band | Smoking's band → tap: pop-up → Close | not started |
| 71 | 111:714 | Pop-up: cut down, from its band | Coffee's band → pop-up → Close | not started |
| 72 | 111:1426 | Pop-up: from a bar's See | Meds → ✓ 25 times: bar → See: pop-up → Close | not started |
| 73 | 111:2209 | Pop-up: back to your best | Meds 13 (best 14) → ✓ 14: bar → band: pop-up "again" → Close | not started |
| 74 | 111:2992 | Pop-up: quit, back after a slip | Smoking's band → pop-up → Close | not started |
| 75 | 112:2 | Reached away: from a widget | Open app: Water finished on widget → band plays once | not started |
| 76 | 112:360 | Reached away: in a folded section | Afternoon folded → open: band plays once | not started |
| 77 | 112:757 | Reached away: the milestone notification | Lock screen notification → tap: Today with pop-up → Close | not started |
| 78 | 166:2 | Reached away: notification, phone in use | heads-up notification → tap: pop-up → Close | not started |
| 79 | 114:2 | Rule: a pop-up, a bar, then just the row | Meds 29, Stretch 2, Skincare 6 → pop-up → bar → just the row | not started |
| 80 | 114:793 | Rule: two bars, then just the row | Meds 2, Stretch 6, Skincare 13 → bar → bar → row | not started |
| 81 | 114:1551 | Rule: no more than 2 pop-ups in 7 days | Wed, 2 pop-ups → ✓ 30 days: a bar → 5 s band; See opens pop-up | not started |
| 82 | 114:2107 | Rule: history added later is never celebrated | missed yesterday → ‹ Yesterday → ✓: nothing plays | not started |
| 83 | 114:2646 | Rule: undone and done again | Meds 2 → ✓ bar → Undo → ✓ again: nothing plays twice | not started |
| 84 | 1714:66792 | Several reminders in one time of day (added 31 Oct, the user) | Meds 8:00 + 11:00 AM in Morning → 7:30: shows 8:00 AM → 8:00 goes by: 11:00 AM → after 11:00: stays 11:00 AM | passed |

## Day details (169:1270)

| # | Node | Flow | Screens | Status |
|---|---|---|---|---|
| 1 | 173:2 | Open Day details and close it | Today → Day details → drag down/✕/Back → Today | not started |
| 2 | 175:2 | +1 to the goal, and past it | Water 7 of 8 → 1 glass to go → +1: Goal reached → +1: 9 of 8 → ✕ | not started |
| 3 | 176:2 | Log from Day details | Water 5 of 8 → Day details → Log: Add log, 2 → Added: 7 of 8 → ✕ | not started |
| 4 | 178:2 | Add log on another day and time | → Add log → Date: picker → 20 → OK → Time: picker → OK → Add: snackbar says where | not started |
| 5 | 179:2 | Add log: nothing typed, or a time later than now | → Add log empty → Add: error line → type 2 → Time 6:00 PM → OK: stays 2:05 PM, says why → Add → ✕ | not started |
| 6 | 180:2 | Add log: ✕ after typing | → 2 typed → ✕: Discard this log? → Keep editing → ✕ → Discard → ✕ | not started |
| 7 | 181:2 | Open a log | → Day details → tap log: Log view → ← → ✕ | not started |
| 8 | 182:2 | Edit a log | → Log → Edit → type 3 → Save: snackbar → ← 6 of 8 → ✕ | not started |
| 9 | 183:2 | Edit a log: ✕ with changes | → Edit log → 3 → ✕: Discard your changes? → Keep editing → ✕ → Discard → ← | not started |
| 10 | 184:2 | Move a log to another day | → Edit log → Date picker → 20 → OK: footer says so → Save → ← 3 of 8 → ✕ | not started |
| 11 | 185:2 | Delete a log | → Log → Delete this log? → Delete; Undo → Undo → ✕ → (Cancel) | not started |
| 12 | 186:2 | All logs, and deleting there | Water 7 of 8 → 2 newest + All 4 logs → All logs → Log → Delete → Undo → ← → ✕ | not started |
| 13 | 188:2 | Time a habit from Day details | → Start timer → ⌄ → Pause: saved → ✕ → (timer) Today › | not started |
| 14 | 189:2 | Log time from Day details | → Log time: 5 min → 9 of 10 → ✕ | not started |
| 15 | 190:2 | A timer's log: view and change it | → timer's log → Log with seconds → Edit H/M/S → 3 → Save → ← → ✕ | not started |
| 16 | 191:2 | A check habit: Mark done, and Undo done | → Not done → Mark done → ✕ → Day details Done → Undo done → ✕ | not started |
| 17 | 192:2 | Skip a day from Day details, and undo it | → Skip today → ✕ → Day details Skipped → Undo skip → ✕ | not started |
| 18 | 193:2 | Several checks a day | Stretch breaks 2 of 3 → Add a check → tap check: Log → Delete this check? → Delete; Undo → ✓ past goal | not started |
| 19 | 194:638 | A week goal: checks count toward the week | Call family 2 of 3 → This week, no Skip → Add a check → ✕ → stays full → next Monday 0 of 3 | not started |
| 20 | 195:2 | A month goal: done once this month | Deep clean → This month → Mark done → ✕ → stays full → done on Wed, 21 Oct | not started |
| 21 | 196:178 | An amount week goal: Push-ups, 300 a week | 140 of 300 → +20 \| Log → +20 → ✕ → Saturday goal | not started |
| 22 | 197:2 | An amount typed each time: Savings | $250 of $500 → one Log → Add log $50 → Add → ✕ | not started |
| 23 | 198:2 | A time week goal: Piano, 3 hours a week | 1 h 40 of 3 h → Start timer → ⌄ → Pause → ✕ | not started |
| 24 | 199:2 | A checklist: tick steps in Day details | Skincare 1 of 4 → steps in This day → tick → all done → untick → ✕ | not started |
| 25 | 200:2 | Log a slip from Day details | Smoking → Day details → Add slip → 1 slip recorded → ✕ | not started |
| 26 | 201:2 | Open a slip: change its time, or delete it | → Slip view → Edit slip → time 8:15 → Save → Delete slip? → Delete; Undo → ✕ → travel time zone | not started |
| 27 | 202:2 | Cut down: an amount, from Day details | Coffee 1 of 2 → +1 Limit reached → +1 Over the limit → ✕ | not started |
| 28 | 203:2 | Cut down: a time limit, from Day details | Social media → Start timer → ⌄ at 42 min → Pause → ✕ | not started |
| 29 | 204:2 | A task in Day details: mark it done | Pick up parcel → Mark done; Reschedule → Done → ✕ | not started |
| 30 | 204:820 | A task in Day details: reschedule it | → Reschedule → Do tomorrow; Undo → Another day… picker → 25 → OK → Undo | not started |
| 31 | 205:2 | A paused habit: resume it from Day details | Paused card → Day details Paused → Resume habit | not started |
| 32 | 206:2 | Day details for an earlier day | ‹ Yesterday → Water → Day details Yesterday → +1 twice → ✕ → Back to today | not started |
| 33 | 207:1000 | Day details for a later day | › Tomorrow → Water → ✕ → Back to today | not started |
| 34 | 210:2 | The ⋮ menu: archive a habit | Water → ⋮ → Archive; Undo → Undo | not started |
| 35 | 210:1012 | The ⋮ menu: delete a habit | Water → ⋮ → Delete Water? → Delete; Undo | not started |
| 36 | 210:2089 | The ⋮ menu: pause a habit | Water → ⋮ → Pause… → Pause Water sheet → Pause; Undo | not started |
| 37 | 211:2 | Notes: add a note from Day details | Water → Add a note… → Save | not started |
| 38 | 211:750 | Notes: change a note | → Note → Edit note → Save | not started |
| 39 | 211:1528 | Notes: delete a note | → Note → Delete this note? → Delete; Undo | not started |
| 40 | 211:2237 | Notes: leave a note unsaved | → typed → ✕ Discard this note? → Discard | not started |
| 41 | 211:3096 | Notes: a long note in Day details | two lines … → Note, whole → ← → ✕ | not started |
| 42 | 212:2 | Milestones from Day details: the bar | Meds 2 → Mark done: bar over Day details → 5 s → ✕: band | not started |
| 43 | 212:1089 | Milestones from Day details: the pop-up | Meds 29 → Mark done: pop-up → Close → ✕ | not started |
| 44 | 215:2 | Day details with a long name and large text | 24-letter name → 200 % → scrolled → ✕ | not started |

## Routine player (234:2)

| # | Node | Flow | Screens | Status |
|---|---|---|---|---|
| 1 | 239:2 | Start a routine | Morning, 3 left; Start → player on Meds → ✕ | not started |
| 2 | 240:2 | A check in the player: Mark done, then Next | Start → Meds → Mark done: Saved · Undo · Add note; Next → Stretch → ✕ | not started |
| 3 | 241:2 | The Saved snackbar: Undo, and Add note | → Mark done → Undo → Mark done → Add note → Save: Note saved | not started |
| 4 | 242:2 | A time habit in the player | → › Stretch 4:00 → Start → Pause → Resume → 10:00 Goal met → Pause → Next | not started |
| 5 | 243:2 | A checklist in the player | → Skincare steps → tick → all: Finish → untick | not started |
| 6 | 245:2 | The end of the routine: everything done | → Skincare all ticked → Finish: end page → Done | not started |
| 7 | 246:2 | The end of the routine, with some left | → Meds done → Next → › → › last: end page, 2 left → Return to unfinished → Done | not started |
| 8 | 247:2 | Day details from the player, and skipping | → Today chip: Day details over player → Skip today → ✕ → Next | not started |
| 9 | 248:300 | Your routine: jump to a habit, change the order | → Morning ▾: Your routine → Skincare → Edit drag → Done | not started |
| 10 | 249:2 | The ⋮ menu in the player | → ⋮ → Go to first unfinished / Change order / End routine | not started |
| 11 | 251:2 | An amount in the player | Water → +1 → +1 twice: Goal met → Today chip → Log manually → Add, ✕ | not started |
| 12 | 252:2 | An amount typed each time: Log | Read → › Savings → Log → Add → › Water | not started |
| 13 | 253:2 | Several checks a day in the player | → Stretch breaks → Add a check ×2: Goal met → Next | not started |
| 14 | 253:397 | A week goal in the player | → › Call family → Add a check → Next | not started |
| 15 | 253:721 | A task in the player | → Pick up parcel → Mark done → Finish | not started |
| 16 | 254:2 | Start on a routine that's partly done | Meds done earlier → Start: opens on Stretch, says why → ‹ Meds done | not started |
| 17 | 254:741 | A routine on another day (yesterday) | Yesterday → Start: chip says Yesterday → Mark done → Next: Log → ✕ | not started |
| 18 | 255:2 | ✕ with a timer running | → Stretch running → ✕: row ticks → tap row: timer → ⏸ on row | not started |
| 19 | 258:630 | The timer on its own: Pause, Resume, the goal | Stretch → ▶ → Pause → Resume → 10:00 → ⌄ → ⏸ on row | not started |
| 20 | 258:1282 | The timer against a limit; Log time from the timer | Social media → ▶ → past 30:00 → Log manually → Add → ⌄ → ⏸ | not started |
| 21 | 260:2 | The timer outside the app: the Live Update | player running → Home: status chip → shade: Live Update → Pause → lock screen → 10:00 → tap card | not started |
| 22 | 266:2 | A milestone in the player: the ribbon | Meds 2 → Mark done: ribbon → Next → ‹ → end: Reached in this routine | not started |
| 23 | 266:573 | A big milestone in the player: the pop-up waits | Meds 29 → Mark done: ribbon → Finish: pop-up over end page → Close | not started |
| 24 | 267:2 | Long names, a description and large text | → long name → description → tap: sheet → 200 % | not started |

## Habits & tasks (269:148)

| # | Node | Flow | Screens | Status |
|---|---|---|---|---|
| 1 | 283:2 | Open Habits & Tasks from the menu | Today → ☰ → Habits & Tasks, Week | not started |
| 2 | 283:405 | Week, Month and Year | Week → Month → Year | not started |
| 3 | 283:721 | An earlier week, and back to this one | This week → ‹ last week; Back to this week → back | not started |
| 4 | 283:1332 | Scroll the page | top → scrolled: bars stay → end: Paused, Archived, key | not started |
| 5 | 284:2 | Tap a card: Habit details, and back | Stretch card → Habit details → ← | not started |
| 6 | 285:2 | Tap a square: Day details for that day | Stretch Friday → Day details → Log time 6 min → Add: square fills; Undo | not started |
| 7 | 286:2 | A card's ⋮: Edit habit | ⋮ → menu → Edit habit → Save: 15 min a day | not started |
| 8 | 289:2 | A card's ⋮: Pause… | ⋮ Pause… → sheet → Pause; Undo → in Paused | not started |
| 9 | 290:2 | A paused card's ⋮: Resume | Paused ⋮ → Resume → Undo snackbar → back in Morning | not started |
| 10 | 291:2 | A card's ⋮: Archive | ⋮ Archive; Undo → Undo → Archived counts 4 | not started |
| 11 | 292:2 | A card's ⋮: Delete | ⋮ Delete → Delete Stretch? → Delete; Undo → Cancel/Undo | not started |
| 12 | 293:2 | Archived habits: open, Restore | Archived (3) → list → ⋮ Restore, Delete → Restore; Undo | not started |
| 13 | 293:849 | Archived habits: Delete, open one, the last one restored | ⋮ Delete → dialog → tap Push-ups: read-only details → empty | not started |
| 14 | 296:2 | Search habits and tasks (from Habits) | search → search view → “wa” → Water → ← keeps search | not started |
| 15 | 296:602 | Search: no match (from Habits) | “yoga” → Add “yoga” → What do you want to do? → How track? → New habit “yoga” → Add · Show | not started |
| 16 | 297:2 | +: a new habit | + → What do you want to do? → How track? → New habit Floss → Add · Show → Show scrolls | not started |
| 17 | 299:2 | Every kind of card (Week) | Checks → Amounts and goals → Skipped, paused, quit → time limit, every few days | not started |
| 18 | 301:2 | Empty and first states | No habits → all archived → first week → July all paused | not started |
| 19 | 303:2 | A long name, and Font size 200% | usual → long name → 200 % | not started |
| 20 | 305:2 | The Tasks tab: One-time | Tasks → One-time → end: No date, Completed, Archived | not started |
| 21 | 306:2 | The Tasks tab: Repeating | Repeating → by how often → end | not started |
| 22 | 308:2 | A task's ⋮: Move to another day | ⋮ Move… → picker → OK; Undo → under Fri 30 Oct | not started |
| 23 | 309:2 | A task's ⋮: Edit task and Duplicate | Edit task → Save → Duplicate → New task copy → Add · Show | not started |
| 24 | 309:761 | A task's ⋮: Archive and Delete | Archive; Undo → Delete dialog → Delete; Undo | not started |
| 25 | 310:2 | A repeating task's ⋮: Skip this time | ⋮ Skip this time → next Wed 28 Oct; Undo → Today unchanged | not started |
| 26 | 311:2 | A task with No date: Do today, or Pick a day | No date ⋮ → Do today · Show → Show → Pick a day… | not started |
| 27 | 312:2 | A task done on Today, and when the day ends | ✓ on Today → struck through on Tasks → next day: Completed → 14 | not started |
| 28 | 313:2 | Completed tasks: Mark as not done | Completed → list → ⋮ → Mark as not done; Undo | not started |
| 29 | 313:426 | Completed tasks: Delete all completed | ⋮ Delete all completed → dialog → Deleted; Undo | not started |
| 30 | 313:645 | Archived tasks: Restore, Delete | Archived (3) → list → ⋮ → Restore; Undo | not started |
| 31 | 314:2 | Search habits and tasks (from Tasks) | search → “den” → Call the dentist → ← | not started |
| 32 | 314:466 | Search: no match (from Tasks) | “plumber” → Add → Add a task → New task → Add · Show | not started |
| 33 | 315:2 | +: a new task | + → New task Buy groceries, Tomorrow → Add · Show → Show | not started |
| 34 | 315:542 | Tap a task: its details, and back | Car service → Task details → ← | not started |
| 35 | 316:2 | Tasks: empty states and Font size 200% | No tasks → Repeating none → 200 % | not started |

## Details pages (298:2)

| # | Node | Flow | Screens | Status |
|---|---|---|---|---|
| 1 | 321:2 | Open Habit details: Progress, scrolling | Water card → Progress, large title → scrolled: small bar → whole tab | not started |
| 2 | 322:2 | A habit's description: two lines, More, Less | two lines, More → More → Less | not started |
| 3 | 322:2597 | Habit details' ⋮: Pause…, and Delete | ⋮ → Pause sheet → Paused card, Resume → Delete Water? → Delete; Undo | not started |
| 4 | 324:2 | See all streaks | See all streaks → Streaks → ← | not started |
| 5 | 325:2 | Milestones: All milestones, and how they work | See all 4 → All milestones → How milestones work → reached one: pop-up → Close | not started |
| 6 | 326:2 | What the squares mean | folded → open → folded | not started |
| 7 | 328:2 | Month: an earlier month, a day, and logging it | ‹ → September → Sat 19 → Day details → +1; Undo → ✕ | not started |
| 8 | 329:2 | Month for other kinds of goal | Gym 3×/week → Read 20 min | not started |
| 9 | 331:2 | Year in Pixels: a square, its day | Year → 14 Sep → Day details → ✕ | not started |
| 10 | 335:2 | History: every day, newest first, and one day opened | History → September → Sat 26 → Day details → ✕ | not started |
| 11 | 337:1861 | History: With notes, and searching notes | With notes → Search notes → “run” → “swim” none → ← | not started |
| 12 | 339:3638 | History: Go to date | Go to date → picker → September → 14 → OK → lit row → fades | not started |
| 13 | 345:4263 | History: Add, for any day | Add → Add to which day? → ‹ 8 → Open Tue 8 Sep → Day details → +1; Undo → ✕ | not started |
| 14 | 342:3249 | History: Add a note to any day | Add → ‹ → 20 → Open → Add a note… → Save → ✕ → scroll | not started |
| 15 | 347:2396 | Edit habit: Started moved earlier | ⋮ Edit habit → Started 25 Aug → Save: History runs to 25 Aug | not started |
| 16 | 349:4001 | An archived habit | ⋮ Archive → card with Restore; Undo → History read-only → ⋮ Restore, Delete → Restore | not started |
| 17 | 351:2274 | A new habit: its first days | 2 days old: Progress → whole page → History First day → made today → No progress yet | not started |
| 18 | 354:1822 | A quit habit’s Progress | Smoking → whole page → See all 5 → How milestones work | not started |
| 19 | 1157:99625 | A cut-down habit’s Progress: an amount | Coffee → whole page → See all 4 → How milestones work | not started |
| 20 | 1158:112719 | A cut-down habit’s Progress: time | Social media → whole page → See all 3 → How milestones work | not started |
| 21 | 355:2234 | Larger text, and loading | Progress 200 % → History 200 % → Loading | not started |
| 22 | 380:3192 | Task details: a one-time task | Car service → Task details → ⋮ → done today | not started |
| 23 | 358:679 | Task details: a repeating task | Replace the water filter → Task details → ← | not started |
| 24 | 367:2718 | History: a skipped day | Tue 8 → Day details → Skip this day → Add a note… → Save → ✕ | not started |

## Create new (381:2)

| # | Node | Flow | Screens | Status |
|---|---|---|---|---|
| 1 | 396:2 | A new habit: check it off | + → What do you want to do? → How track? → New habit (keyboard) → “Journal” → form → Time of day → ← → Add: end of Morning | not started |
| 2 | 397:589 | A new habit: leaving it | + → New habit empty → ← nothing asked → typed, ← → Discard this habit? → Discard | not started |
| 3 | 399:442 | A new habit: its icon and colour | Icon → icon page → book → Done → Colour → sheet of 14 → orange | not started |
| 4 | 400:439 | How often: several a day, or a number of times | How often → Every day → Several times a day → + → Times a week… → Month → ← | not started |
| 5 | 401:536 | How often: days of the week, or every few | certain days → Every Friday → Mon, Wed → Every few days → weeks → set days → months → ← | not started |
| 6 | 401:1116 | How often: on a date each month or year | date each month → 1 and 15 → a weekday → Year → ← | not started |
| 7 | 402:488 | Time of day: more than one, and a new one | Morning + Evening → New time of day → “Before work” → Add → ← | not started |
| 8 | 403:361 | Reminders: turned on | Reminders → Remind me → Android asks → Allow → Add a time → 2:00 PM → ← | not started |
| 9 | 403:501 | Reminders: notifications not allowed | Remind me → Don’t allow → back off, says why → Open settings after second no | not started |
| 10 | 403:640 | Reminders: on time, on some phones | after Allow → Open settings: Alarms & reminders → Back | not started |
| 11 | 404:1152 | Starts and Ends | Starts → picker → 26 → Ends menu → On a date… → 25 Dec → OK | not started |
| 12 | 405:400 | A new habit: track an amount | Track an amount → form → How much → Unit → glasses → 8 glasses | not started |
| 13 | 405:710 | A new habit: time it | Time it → form → How long → 15 min → ← | not started |
| 14 | 405:1039 | A new habit: a checklist | Checklist → form → Steps → ← 3 steps | not started |
| 15 | 406:523 | A new habit: quit | Quit or cut down → Quit → quit form → Started picker → At time → Add | not started |
| 16 | 406:870 | A new habit: cut down | Cut down → form → Limit Amount → ← → How often for a limit → ← | not started |
| 17 | 459:8 | A new habit: cut down time | Cut down → Limit → Time → 1 h → ← → How often → ← | not started |
| 18 | 406:1153 | A sixth habit on the free plan | 5 habits → Add a 6th habit: Plus → Make room → Archive Read; Undo → Continue | not started |
| 19 | 1220:383082 | A checklist on the free plan | Checklist → Checklists come with Plus → scrolled → Paid: form; Plus is on | not started |
| 20 | 1227:392721 | Remind again on the free plan | If not done, remind again → Plus → scrolled → Paid: Plus is on | not started |
| 21 | 407:2156 | Edit habit | ⋮ Edit habit → form → How much 10 → Save: Changes saved → discard → name cleared | not started |
| 22 | 469:2 | A new task: for today | + → Add a task → Once → New task → “Pick up parcel” → form → Add | not started |
| 23 | 471:2 | A task’s date | Date → picker → 30 → OK → No date | not started |
| 24 | 474:2 | A task’s time | Time on → picker 2:00 PM → OK | not started |
| 25 | 474:282 | A repeating task | Add a task → On repeat → form → How often → A while after → ← | not started |
| 26 | 475:2 | A new task: leaving it | + → Add a task → Once → empty ← → typed: Discard this task? → Discard | not started |
| 27 | 475:835 | Edit task | ⋮ Edit task → form → Date → Tomorrow → Save → name cleared → discard | not started |
| 28 | 407:2927 | The habit form at 200% text | form 200 % → How often 200 % | not started |

## Settings (781:34017)

| # | Node | Flow | Screens | Status |
|---|---|---|---|---|
| 1 | 1179:357753 | Opening Settings | Today → ≡ → Settings | not started |
| 2 | 1181:2810 | Back up now | Settings → Backup & Sync → Back up now → Backing up… → Backed up | not started |
| 3 | 1181:4132 | Backing up for the first time | Not backed up yet → Back up to Google Drive → chooser → Allow → Backing up… → Backed up | not started |
| 4 | 1182:4382 | Change account | Change account → chooser → Back up to another Drive? → Backing up… → Backed up | not started |
| 5 | 1182:360295 | Back up now with no internet | Back up now offline → Waiting + snackbar → online: Backing up… → Backed up | not started |
| 6 | 1183:5575 | Restore from Google Drive | Restore from a backup → Google Drive → chooser → Allow → Restore this backup? → Restoring → Today + Undo | not started |
| 7 | 1183:6412 | Restore from a backup file | Restore → A backup file → file picker → Restore this backup? → Restoring → Today + Undo | not started |
| 8 | 1183:8042 | Save a backup file | Save a backup file → save picker → saved to Downloads | not started |
| 9 | 1183:8483 | Export a spreadsheet | Export CSV → save picker → saved | not started |
| 10 | 1183:9112 | Delete the Google Drive backup | Delete Google Drive backup… → dialog → Not backed up + snackbar | not started |
| 11 | 1183:9556 | Erase all my data | Erase all my data… → dialog → Today, no habits yet | not started |
| 12 | 1183:11921 | Edit a time of day | Times of day → Morning → Starts → 07:00 → Save → list | not started |
| 13 | 1183:367054 | A new time of day | Add time of day → name, starts → “Before work” → Add | not started |
| 14 | 1183:368079 | Delete a time of day | Morning → Delete time of day → Delete Morning? → Undo | not started |
| 15 | 1183:368648 | Leaving Edit time of day with changes | Morning → renamed → ✕ → Discard your changes? → unchanged | not started |
| 16 | 1186:373799 | New day starts at | Settings → page → 3:00 AM → ← | not started |
| 17 | 1186:374469 | Week starts on | Settings → page → Monday → ← | not started |
| 18 | 1183:373672 | Keep reminders coming | 1 thing to fix → Open settings → Alarms & reminders on → All set → Settings · All set | not started |
| 19 | 1199:16989 | Reminders, before anything is set up | No reminders yet → nothing allowed → 3 things to fix | not started |
| 20 | 1188:377756 | Theme | Theme → Light → ← → Settings Light | not started |
| 21 | 1183:374861 | Vibration and sound | Sound when done → on | not started |
| 22 | 1183:375417 | Privacy policy | Privacy policy → browser tab → back | not started |
| 23 | 1183:375992 | Open-source licences | licences → Google's licences screen → back | not started |

## Widgets (1232:173760)

| # | Node | Flow | Screens | Status |
|---|---|---|---|---|
| 1 | 1256:3355 | Add a widget | hold home → Widgets → search, One habit → + Add → choose habit, Add widget → on home | not started |
| 2 | 1264:8718 | Add the Today widget from the app’s icon | hold icon → Widgets → Today 4×2 → Add → All of today → Morning → Add widget → on home | not started |
| 3 | 1257:4344 | Change a widget | hold widget → edit frame ✎ → One habit: Read → Save → shows Read | not started |
| 4 | 1258:5608 | Today widget on the free plan | hold home → Widgets → Today 4×2 → Add → without Plus → tap → app opens Today | not started |

## Notifications & alarms (1265:24553)

| # | Node | Flow | Screens | Status |
|---|---|---|---|---|
| 1 | 1274:404399 | Tick a habit from its reminder | reminder over home → Done → Today: Meds done | not started |
| 2 | 1275:2054 | A week goal, from the lock screen | lock-screen reminder → saved without unlocking → goes away | not started |
| 3 | 1276:2388 | An amount, +1 at a time, and Undo | Water reminder → +1: 4 of 8, Undo → Undone → shade +1 | not started |
| 4 | 1277:2639 | An amount typed in the notification | Walk reminder → field → 3000 → saved 5,500 of 8,000 | not started |
| 5 | 1277:405022 | A time habit: Start from the reminder | Read reminder → timer runs as Live Update → shade → Goal met | not started |
| 6 | 1278:3210 | A time habit: Log time already spent | Read reminder → field → 8 → Goal met → goes away | not started |
| 7 | 1278:405794 | A checklist, one step at a time | Tick Cleanser → Serum → Moisturiser → all four: done | not started |
| 8 | 1279:4534 | A checklist out of order: Open | 2 of 4 → Day details → Sunscreen → reminder keeps up | not started |
| 9 | 1280:4045 | A task, from its reminder | task reminder → Done | not started |
| 10 | 1281:4896 | Several reminders at the same minute | group for Morning → opened → Meds done leaves → Stretch: Start or Log time | not started |
| 11 | 1282:4986 | An alarm: turn it on, then answer it | Remind me with → Let alarms fill the screen → Full screen notifications → Allowed → An alarm → rings → Done | not started |
| 12 | 1282:407448 | An alarm without full screen | Let alarms fill the screen → without full screen → rings as notification → Not now → Done | not started |
