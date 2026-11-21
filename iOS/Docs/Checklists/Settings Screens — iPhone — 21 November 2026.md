# Settings Screens — iPhone — 21 November 2026

Written by Claude (Claude Code), 21 November 2026, at the user's request: "next let's work on the settings page …
we have removed couple of things from it and then made everything very much simple … most of these are native
components … whichever things can be checked, that you can check, but mostly implement the settings component
section perfectly, step by step, just like you did."

Figma: the iOS app file, section **settings components** (`804:79`), and the board of system parts the flows use
(`1172:216`: the clean-for-30-days notification, the Lock Screen and Dynamic Island's Live Activity, Save to Files,
the privacy policy in Safari). UI only, as with Create New; in code each Figma page is an ordinary SwiftUI screen and
its variants are that screen's states. Branch `ios-update`.

## The user's points

- [x] 1. Settings is simpler: Backup (Backup & Sync), Your day (Day Starts At, Week Starts On), General (Appearance,
  Haptics, Sound When Done, Notifications), About (Privacy Policy, Version). Everything else the old page listed
  is gone from it.
- [x] 2. Native parts stay native: nothing drawn for what iOS draws (notifications, the Live Activity, Save to Files,
  Safari). Check on the Simulator what can be checked.
- [x] 3. The privacy policy opens the website in Safari's own view.

## The screens, in Figma's order

- [x] **Settings** (`1173:547`: Default, End of the list, Nothing set up)
- [x] **Backup & Sync** (`1178:960`: Backed up, Not backed up, Backed up · end of the list)
- [x] **Day Starts At** (`1186:13870`: Default, End of the list)
- [x] **Week Starts On** (`1186:13871`)
- [x] **Appearance** (`1188:376784`)
- [x] The system parts (`1172:216`): what can be checked on the Simulator

- [x] 4. (21 Nov 2026, the user: "In dark mode, just change this red color a little bit. It looking too bright …
  catching too much attention.") The delete rows' red is softer in dark mode only: `Color.destructive`
  (`Shared/Palette.swift`), iOS's Red with saturation ×0.84 and brightness ×0.86 (iOS 26's #FF4245 → about #DB5355),
  worked out from `.systemRed`, so it follows iOS; light mode and Increase Contrast keep iOS's own Red.

## Left for the logic pass

- **Day Starts At offers 12:00 AM to 12:00 PM, not Figma's 24 hours.** The day's rules (`HabitStore.setDayEnd`, the
  shared core, Android) accept 0 to 12; a later hour would be cut back to noon without a word. Open decision D-24.
- **The clean-for-30-days notification (system parts board) isn't built on the iPhone.** No milestone notification
  exists in the iPhone app; it comes with the notifications work.
- **Done order and the timer switches** left the Appearance page (not in Figma); what they did stays in
  `Preferences` until the logic pass decides.
- **Progress, Times of Day, Reminders, Plus, Privacy & Security, Help and About** are no longer listed anywhere in
  Settings; `MenuPlace` still has them for speed runs and links until the logic pass removes them.
- **The backup file's name** is *Often Enough 2026-11-21 1405.zip* (seen in Save to Files); D5 says
  *Often Enough backup YYYY-MM-DD HHmm.zip*. `BackupCenter.makeFile`.
- **Backup & Sync's card symbol is filled** (CardNotice's TipView anatomy, 6 Nov rule); Figma draws it outlined.
  Kept filled as the decided rule says; the user can say otherwise.
- **UI tests to rewrite** (T3): `ICloudUITests` (`cloud-device`, `cloud-card`, the cloud-status titles, See Plus),
  `BackupUITests` (`backup-import`, the old status words), and the Appearance and Day and Week tests
  (`appearance-haptics`, `appearance-sound`, `day-start-picker`, `week-start-picker` became Settings' switches,
  `day-start-<hour>`, `week-start-<day>` and `appearance-<theme>`).

## What was done, screen by screen

- **Settings** (`Habits/Settings/SettingsPage.swift`): one inset-grouped `List`, four sentence-case headers. Backup &
  Sync's row says what its page's card says (the newer of the last checked backup file and the last sync). Haptics
  and Sound When Done are whole-row `Toggle`s in green; Notifications asks iOS the first time and opens the app's
  page in iPhone Settings after that, and reads the state again on return. Privacy Policy opens
  `oftenenough.com/privacy` in `SFSafariViewController`, full screen with ✕ (`.close`), as Figma's browser tab.
  Checked in light and dark.
- **Day Starts At, Week Starts On, Appearance** (`SettingsChoicePages.swift`): one shape, `ChoiceList`: the intro in
  Secondary Label as a clear row (iOS's headers fade and capitalise), then Checkmark rows that save at once and keep
  the page open, as iPhone Settings does. Checked: the tick moves, the Settings row follows, Dark switches at once.
  The old `DayAndWeekView` and `AppearanceView` are deleted.
- **Backup & Sync** (`Habits/Backup/ICloudPage.swift`): one Card notice leads with whether the habits are safe
  (Backed Up · Back Up Now, or Not Backed Up · Back Up to iCloud), then Restore, Export, and the deletes in red, as
  Figma. The card also speaks for the states Figma doesn't draw and the data rules need (a backup that can't be
  written, another Apple Account with both answers, D3; iCloud removed, full, off or signed out). Delete and Erase
  ask with Cancel and one red action (D9). Undo Last Restore shows only while there's one to undo (D5). Gone: the
  Devices section, Import a Backup File (Restore opens files), Google Drive (D4). Save a Backup File is iOS's own
  Save to Files (`UIDocumentPickerViewController(forExporting:asCopy:)`): checked, the file lands in On My iPhone
  and the sheet closes; the spreadsheet keeps the share sheet so it can go straight to Numbers. Checked in light and
  dark, backed up and iCloud off. Today's backup card's button says *Open Backup & Sync*.
- **System parts:** the Live Activity shows in the Dynamic Island (the habit's icon and the clock) and on the Lock
  Screen (name, clock, progress, Pause) once a timer starts; a test launch needs `-timer-presence` for it. On the
  locked Simulator the seconds showed as `--`; most likely iOS's own reduced Lock Screen updates, not ours: check
  on the phone. Save
  to Files and Safari as above. The notification isn't built (above).
