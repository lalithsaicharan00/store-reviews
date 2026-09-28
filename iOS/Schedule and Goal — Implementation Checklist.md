# Schedule and Goal implementation

Written by Codex, 28 September 2026.

User request: archive the supplied report, improve frequency and Goal screens from it, update the code, and test on an iOS simulator. No physical-device test is required for this request.

Source: [Schedule and Goal — One Coherent System](<../Research/Research Reports/Habit Creation/Schedule and Goal — One Coherent System.md>).

- [x] Archive the original report and add its index entry; retain citation provenance.
- [x] Replace Repeat with Schedule; keep it visible for period goals.
- [x] Four schedule choices, large read-back, inline controls, visible Starts and next occurrence.
- [x] Fixed weekdays and shortcuts; day/week/month/year intervals, dates, last day, ordinal weekday and exceptional-date policies.
- [x] Flexible distinct-day quotas for check, amount, time and checklist; daily quantity remains separate.
- [x] Explicit Goal/Schedule transitions, cancel and restoration of inactive drafts; canonical once-per-period checks.
- [x] Goal counts over menu, semantic helper copy, combined form sentence, keyboard and accessibility layouts.
- [x] Cut down has Limit with its own period and no Schedule; neutral logged/limit copy.
- [x] Tasks retain fixed schedules and gain completion-relative recurrence.
- [x] Preserve legacy records and persisted schedule meaning; test round trips and calendar arithmetic.
- [x] Update affected UI tests, run simulator tests, inspect screenshots including keyboard and large text.

Existing capabilities to preserve: per-day and aggregate goals, optional amount units, whole check counts, time wheels and typing, direct +1 versus typed logging, start/end dates, Time of Day, reminders, non-scheduled-day neutrality, tasks and quit counters. Earlier segmented period controls, disappearing Repeat, hidden week anchors and Cut down period under Repeat are intentionally replaced by the supplied report.

## Implementation notes

- New rules use explicit `Frequency.flexible`, `.calendar` and `.afterCompletion` cases. Legacy `perWeek` / `perMonth` / `perYear` records retain their aggregate semantics. The existing frequency column stores versioned Codable data for new rules; no database-column migration or destructive data rewrite is needed.
- Daily action completion and flexible-period completion are deliberately separate. Today shows daily quantity plus distinct-day progress. Section remaining counts and reminders stop after the quota; logging stays available. Unchosen flexible days do not become daily calendar failures.
- The repository currently has a creation form, not a general saved-habit editor. Existing recurrence anchors are retained in stored records; these changes do not rewrite them. Inactive per-mode parameters are retained within the creation draft.
- Date, weekday, month, ordinal and list rendering use locale-aware system formatters. The app's product copy remains English; this work does not add translated languages.
- The supplied report's first-time-user comprehension study is a future research activity, not an automated test or an observed outcome.

## Simulator validation

Build: `xcodebuild build-for-testing -project iOS/Habits.xcodeproj -scheme Habits -destination 'platform=iOS Simulator,id=F9A03BBF-4243-4190-A91C-408DF28122BF' -derivedDataPath /private/tmp/habits-schedule-build CODE_SIGNING_ALLOWED=NO`.

UI tests cover explicit period changes and cancellation/restoration, amount and time keyboards, independent goals, optional units, legacy logging, flexible day progress, all-seven-day canonicalisation, monthly/yearly date policy, completion-relative tasks and accessibility text sizes. `ScheduleCheck` runs deterministic recurrence/persistence checks through a simulator-hosted in-memory database.

### Final results — 28 September 2026

- Simulator build succeeded (iPhone 17 Pro, iOS 26.5).
- **21 distinct selected tests passed**, across the initial run and targeted reruns of failures and subsequent refinements. This was not a full repository test-suite run.
- Coverage: 11 Goal flow tests, the New flow walkthrough, 3 affected New Habit tests and 6 Schedule tests. The Schedule integration test also exercises calendar arithmetic, legacy/new storage round trips, repository reloads, distinct-day quantities, reset boundaries, week-start changes, DST/time-zone stability, checklist completion, extra logging, undo and completion-relative tasks.
- Initial failures: duplicate accessibility Button nodes, one outdated Stepper test identifier, and an existing simulator whose software keyboard was reported outside the screen. Removed redundant Button accessibility wrappers and corrected the Stepper query. The exact key-by-key test passed on a clean temporary iPhone simulator, including tapping individual number keys, verifying each character, replacing an existing number, logging progress and checking the result on Today.
- Visual QA: Goal with a number keyboard; typed hours/minutes; flexible-day read-back and Today progress; aggregate Any Day; monthly and leap-day policies; completion-relative tasks; accessibility XXXL weekdays. Large-text quick picks were changed to a vertical arrangement after screenshot inspection.
- Screenshots and a machine-readable latest-result index: `Research/Temp/schedule-goal-validation/` (ignored scratch output). Xcode result bundles remain under `/private/tmp/habits-schedule-*.xcresult`.
- No physical-device run or participant comprehension study was performed; the user requested emulator testing.
