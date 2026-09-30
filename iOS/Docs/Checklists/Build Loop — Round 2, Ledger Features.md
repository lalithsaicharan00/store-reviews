# Build Loop — Round 2, Ledger Features

Written by Claude (Claude Code), 29 September 2026. The user's points for this round, and each loop as it's done.

**Context (the user's words, tidied):** complete whatever else is needed. Work out the next most important things from the Feature Ledger's cards and build them one after another, in a loop, with the same process: research first, then build.

**Order chosen from the ledger** (Part 1 "What wins" and Part 7 "must-have", minus business and listing rules, minus what's built): Settings (C170, C038, C157/C207, C288, C075, C036, C085) · check-off feedback (C069, #58) · export and backup (C020, C034, C176) · widgets (C009, C023, C040) · Shortcuts (C046) · milestones (C101).

| # | Point | Done |
|---|---|---|
| U1 | Pick the next most important things from the ledger cards | [x] Order above |
| U2 | Research each, then build, one after another | [x] Each loop below |

## Loop 5 — Settings (#61)

Research: [Settings — What People Need There](<../../../Research/Research Reports/Settings and Help/Settings — What People Need There.md>).

| # | Point | Done |
|---|---|---|
| L5.1 | The avatar opens Settings, a sheet applied at once | [x] `SettingsView` |
| L5.2 | Day Ends At, midnight to noon; Week Starts On, any day; days already logged keep their dates | [x] `HabitStore.saveSettings` |
| L5.3 | Show Streaks (on by default); off hides Today's flame only | [x] `DaySettings.showStreaks` |
| L5.4 | Notifications off for the app: say so, link to iOS Settings | [x] |
| L5.5 | Times of Day from Settings too | [x] |
| L5.6 | How It Works: searchable answers naming where to tap | [x] `HelpView` |
| L5.7 | Plan row (Free, N of 5, Plus…); Privacy stated; Version | [x] |
| L5.8 | Contact Support | [ ] Row ready; hidden until a support address is set (`AppInfo.supportEmail`) |
| L5.9 | UI test | [x] `SettingsUITests` (written; not run: no Mac in this session) |

## Loop 6 — Check-off feedback (#58, C069)

Research: [Check-off Feedback — Haptics, Sound and Animation](<../../../Research/Research Reports/Day Structure and Organization/Check-off Feedback — Haptics, Sound and Animation.md>).

| # | Point | Done |
|---|---|---|
| L6.1 | A light click on every +, a success haptic when a habit becomes done | [x] `RoundActionButton` |
| L6.2 | A short system sound when done, off by default | [x] |
| L6.3 | Haptics and Sounds switches in Settings (When You Log); the player follows Haptics too | [x] `CheckFeedback` environment |
| L6.4 | One small bounce of ✓; none with Reduce Motion; no confetti | [x] |
| L6.5 | Feedback only right after a tap on that button (not when the day changes) | [x] |
| L6.6 | #58: the done row stays in place until the next log (it offers Add note), so the fill finishes where the person looks | [x] Already true; recorded |

## Loop 7 — Export and backup (C020, C034, C176)

Research: [Export and Backup — Keeping Your Own Data](<../../../Research/Research Reports/Data, Sync and Accounts/Export and Backup — Keeping Your Own Data.md>), building on the Data Safety report.

| # | Point | Done |
|---|---|---|
| L7.1 | Settings → Your Data: "Included in your iPhone's backups" (the database is in Application Support) | [x] |
| L7.2 | Export a Spreadsheet (CSV): local dates, habit, what, amount, unit, note; archived habits too | [x] `DataExport` |
| L7.3 | Save a Backup File: a consistent copy of the database, shared through the share sheet | [x] `HabitStore.backupFile` |
| L7.4 | Restore from a Backup File: adds only what's missing; never overwrites, never revives; old backups upgrade; no free-limit stop | [x] `HabitStore.restore`, Core `mergeAll` |
| L7.5 | Tell the person what was added | [x] |
| L7.6 | Core test for the merge | [x] `mergingABackupAddsOnlyWhatIsMissing` (written; not run: Google Maven blocked here) |
| L7.7 | Help answers for backup, moving phones, the spreadsheet | [x] |

## Loop 8 — Today widget (C023, C040, C009)

Research: [Widgets — Tick Without Opening the App](<../../../Research/Research Reports/Home Screen and Visual Design/Widgets — Tick Without Opening the App.md>), building on the widget study and Architecture 07.

| # | Point | Done |
|---|---|---|
| L8.1 | One free Today widget: small, medium, large; Lock Screen circular, rectangular, inline | [x] `HabitsTodayWidget` |
| L8.2 | Habits by name in Today's order, what's left first, done ones dimmed below | [x] `WidgetBridge.day` |
| L8.3 | Tap ✓ / +1 / +amount to log without opening the app, one step per tap; others open the app | [x] `LogHabitFromWidget` |
| L8.4 | The row updates at once; the day's reminders stop when it's done | [x] (reminder removal from the widget is best-effort; the app replans when it runs) |
| L8.5 | Taps saved with tap-time entry IDs, applied once by the app before anything else | [x] `WidgetTap`, `WidgetBridge.applyPendingTaps` |
| L8.6 | Turns over at the person's day start by itself; "Open Habits" instead of a stale day | [x] `TodayProvider`, `WidgetFile.day(at:)` |
| L8.7 | App Group entitlement for the app and the widget extension | [x] in the project; [ ] turn it on for both App IDs in the developer account |
| L8.8 | Tried on a device | [ ] No Mac in this session |

## Loop 9 — Siri and Shortcuts (C046)

Research: [Siri and Shortcuts — Log by Voice and Automation](<../../../Research/Research Reports/Home Screen and Visual Design/Siri and Shortcuts — Log by Voice and Automation.md>).

| # | Point | Done |
|---|---|---|
| L9.1 | Log a Habit: one step today, only adds; asks for a number when needed; per-section ticks fill the first open one | [x] `LogHabitIntent`, `HabitStore.logFromShortcut` |
| L9.2 | What's Left Today and Get Habit Progress, spoken and returned as text for shortcuts | [x] `WhatsLeftIntent`, `HabitProgressIntent` |
| L9.3 | Open a Habit opens its page over Today (not over a running routine or a habit being written) | [x] `OpenHabitIntent`, `AppRouter.openHabit` |
| L9.4 | Siri phrases with no setup; refreshed when habits are added, renamed or archived | [x] `HabitShortcuts` |
| L9.5 | Works with the app closed; widget and reminders updated before returning | [x] |
| L9.6 | Help answers for the widget and Siri | [x] `HelpView` |
| L9.7 | Tried on a device | [ ] No Mac in this session |

## Loop 10 — Milestones (C101, with C157, C095)

Research: [Milestones — Marking Progress Without Noise](<../../../Research/Research Reports/Day Structure and Organization/Milestones — Marking Progress Without Noise.md>).

| # | Point | Done |
|---|---|---|
| L10.1 | A tap that reaches 7, 30, 100, 365… in a row (4/12/26/52 weeks, 3/6/12 months) says so in the Undo bar | [x] `HabitStore.withUndo`, `StreakUnit.isMilestone`, `UndoBar` |
| L10.2 | The tap that finishes the day says "All N done today" | [x] `HabitStore.dayTotals` |
| L10.3 | Habit page: milestones reached (from the best streak) and the next; quit habits by time since the last slip | [x] `HabitPageView.milestones`, `QuitMilestones` |
| L10.4 | Settings → Milestones, on; streak milestones follow Show Streaks | [x] `DaySettings.milestones` |
| L10.5 | No pop-up, sound, confetti or notification; Undo removes the milestone with the tap | [x] |
| L10.6 | Help answer | [x] |
| L10.7 | Tried on a device | [ ] No Mac in this session |

## Loop 11 — Asking for a review (C094, C054, C093)

Research: [Asking for a Review — When, How Often, Never How](<../../../Research/Research Reports/Business Model and Monetization/Asking for a Review — When, How Often, Never How.md>).

| # | Point | Done |
|---|---|---|
| L11.1 | Apple's request only; no pre-question, no reward | [x] `ReviewPrompt`, `TodayView` (`requestReview`) |
| L11.2 | After a week of real use: first habit 7+ days old, 7 days logged, 10 logs | [x] `ReviewPrompt.shouldAsk` |
| L11.3 | Only on the tap that finishes today, 2 s later, not over a routine or a note | [x] `UndoOffer.finishedDay` |
| L11.4 | Once per version, 120 days apart; never in UI tests | [x] |
| L11.5 | Rate Habits in Settings → Help | [ ] Row ready; hidden until `AppInfo.appStoreID` is set |

## Loop 12 — First run (C075, C159, C209, C235, Data Safety B4)

Research: [The First Run — Start in One Tap](<../../../Research/Research Reports/Habit Creation/The First Run — Start in One Tap.md>).

| # | Point | Done |
|---|---|---|
| L12.1 | Opens on Today; nothing before it | [x] Already true; recorded |
| L12.2 | Empty Today: New Habit, Restore from a Backup, How It Works | [x] `TodayView`, `RestoreBackup` (shared with Settings) |
| L12.3 | Notification permission only when a reminder is turned on | [x] Already true (`ReminderScheduler.requestPermission`) |
| L12.4 | UI test | [x] `FirstRunUITests` (written; not run: no Mac in this session) |

