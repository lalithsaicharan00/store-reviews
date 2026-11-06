# Settings on iPhone — iCloud Only, Rows with Values and No Reminder Fixes

Written by Claude (Claude Code), 6 November 2026 (IST). iPhone design loop, screen Q: Settings (Figma "IOS app", page
[settings 781:34017](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=781-34017), components
[804:79](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=804-79)).

## What people come to Settings to do

Rarely, and for one thing at a time: check that their habits are backed up, restore or export them, set when their
day and week start, change appearance, haptics or sound, and find the privacy policy. Reasoned from first
principles: the backup's state is the one thing worth seeing at a glance, and nothing here should look like a
problem to fix unless it is one.

## What was wrong (the user's points, 6 Nov)

- **Google Drive on the iPhone:** Back up to Google Drive, Change account, Delete Google Drive backup, Google's account
  chooser, Allow Google Drive, "sam@gmail.com's Drive". The iPhone backs up to iCloud only (D4, D16; Android A31).
- **Reminder permissions were too prominent:** a whole Reminders section for **Keep reminders coming** ("1 thing to
  fix"), with Android's Alarms & reminders page and a page of battery steps for each phone maker (A109).
- Android parts: Google's open-source licences screen, Android's save picker on Downloads, a Theme page saying
  "System default", ‹ on a menu place, ← in the flows, a FAB on Times of day, a capsule Delete, sentence-case titles.

## What iOS does

- **Settings rows name the setting and show its value at the trailing edge** ("Week Starts On  Sunday ›",
  "Appearance  Automatic ›"), one line, Title Case; switches for on/off.
- **Backup is iCloud**, on the person's Apple Account: there's no account to choose or change.
- **Notifications are the system's**: an app can only open its own page in Settings
  (`openNotificationSettingsURLString`); iOS never asks twice. A scheduled notification needs no exact-alarm or
  battery permission (screen P's research), so **Keep reminders coming has nothing to do on iPhone** and goes.
- **Acknowledgements** is the iPhone's name for open-source licences, the app's own list.
- **Saving a file** goes through Apple's Files sheet (choose a place, Save).
- **Appearance** is Automatic, Light or Dark.

## What changed

- **Settings (3 variants):** ☰ (a place in the menu, as Today); Backup (**Backup & Sync**, "iCloud · Today,
  9:14 AM"); Your day (**Times of Day 3**, **Day Starts At 12:00 AM**, **Week Starts On Sunday**); General
  (**Appearance Automatic**, **Haptics**, **Sound When Done**, **Notifications On ›**, which opens the app's page in
  Settings); About (**Privacy Policy ↗**, **Acknowledgements**, **Version 1.0 (1)**). The Reminders section is gone:
  Notifications is one quiet row in General.
- **Backup & Sync (3 variants):** the card says **Backed Up** "to your iCloud" (Back Up Now) or **Not Backed Up**
  (Back Up to iCloud); Change account is gone; **Restore from a Backup** "From iCloud or a file"; **Save a Backup
  File**, **Export a Spreadsheet (CSV)** "To open in Numbers or Excel"; red **Delete My Data from iCloud…** (D9:
  "This iPhone keeps everything") and **Erase All My Data…** "From this iPhone".
- **Sub-pages:** Times of Day's FAB is an **Add Time of Day** row; **Edit Time of Day** has a compact time picker for
  Starts, a Prominent **Save** (as P's forms) and a red **Delete Time of Day** row; **Day Starts At**, **Week Starts
  On** and **Appearance** (Automatic · Light · Dark) are Title Case.
- **Native screens rebuilt for iPhone:** **Acknowledgements** (the core's libraries: Kotlin, Kotlinx Coroutines,
  Datetime, Serialization) replaces Google's licences screen; **Save to Files** (the design system's Large sheet:
  the file name, Save in iCloud Drive / On My iPhone / Downloads, Save) replaces Android's save picker; the privacy
  policy says iCloud and the App Store.
- **Flows:** Change account, Keep reminders coming (with its six phone-maker pages) and "Reminders before anything is
  set up" are deleted, and the page closed up; the first backup and Restore from iCloud lost Google's chooser and
  Allow steps; Delete my data from iCloud and Erase All My Data say what iCloud keeps; ‹ for ←, banner for snackbar;
  69 captions and names.
- Two Samsung battery components with no copies left were deleted. Keep reminders coming, Alarms & reminders and
  Android's notifications dialog still have copies on the Today page's Android-only notices (left for the "+" item).

## Left for the user

1. **Notifications as a row.** It opens the app's page in iOS Settings and shows On or Off. The alternative is no row
   at all (iOS's own Settings has it).
2. **Backup & Sync's name.** Kept for one mental model with Android; "iCloud" alone is the iPhone's word.
3. **Save to Files** is drawn with our sheet; the real one is Apple's, opened by the app (`fileExporter`).
