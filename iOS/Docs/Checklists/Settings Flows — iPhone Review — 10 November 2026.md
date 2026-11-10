# Settings Flows — iPhone Review — 10 November 2026

Written by Claude (Claude Code), 10 November 2026, at the user's request: "let's continue with settings page … go
through them properly … work on one after the other flow … Add numbering for the flows, and complete all of the
flows."

Figma: the iOS app file, page **settings** (`781:34017`). One flow per pass of the loop: every screen looked at
against today's decisions (Routine, not time of day; title case for titles, buttons, menu rows and form rows; All Day
and Anytime fixed; Settings has no Routines row), anything cut off, overlapping, stale or wrong fixed in the design
system first, then the copies; notes and arrow words checked.

## Numbering

- [x] The page's 16 flows are numbered on from Create New's 242: **243 · Opening Settings** to **258 ·
  Acknowledgements**, the header's text and its layer name alike. The headers' text was older than their layer names
  (Back up now, Theme, Vibration and sound, Open-source licences); the layer names' words are used. An empty
  100 × 100 frame, "Choices (scrolls)", sat over the first header at 0, 0 and is deleted.

## The flows

- [x] 243 · Opening Settings: Today, the menu, Settings. All three screens right: ≡ on Today, the menu's rows in title
  case, Settings with Backup, Your day, General and About. Two notes were out of date: the menu's said "Contact us ·
  Send feedback" (now Contact Us · Send Feedback, as drawn), and Settings' listed a Reminders section that isn't there
  (now four sections, with Haptics and Sound When Done as switches).
- [x] 244 · Back Up Now: Settings, Backup & Sync, Backing Up…, Backed Up · Just now. Layout, words and notes right.
  The card's button read "Back up now" on every Backup & Sync screen: the Card notice component already says Back Up
  Now, but nine copies on this page kept the old words as their own; all nine say Back Up Now now. Looked at screens
  2–4 again.
- [x] 245 · Backing up for the first time: Settings (Not backed up yet), Backup & Sync's Not Backed Up card with Back Up
  to iCloud, Backing Up…, Backed Up · Just now. Layout, words and notes right; with nothing in iCloud yet, the page
  rightly has no Delete My Data from iCloud. Screen 3 was named "Back on Backup & Sync", but the person never leaves
  the page: now "Backing Up…: the card says so, on the same page".
- [x] 246 · Back Up Now with no internet: Backed Up, Waiting for the Internet, Backing Up…, Backed Up · Just now.
  Screen 2 had a banner under the card ("No internet. It backs up once you're online.") with a ✓, which means done,
  and it sat over the Erase row. The card already answers the tap and says the same, and a failure on iOS isn't a
  snack bar, so the banner is removed; the screen is now "Waiting for the Internet: the card says so". Screen 3's note
  named Android's WorkManager: now iCloud sends it once the phone is online again. Looked at screen 2 again.
- [x] 247 · Restore from iCloud: Backup & Sync, Apple's file picker, Restore this backup?, Restoring, Today with
  *12 habits restored · Undo*. Screen 2 was Android's "Restore from a backup." page (iCloud or A backup file, with a
  full stop in its title), which the iPhone's onboarding deleted: Restore from a Backup opens Apple's file picker
  directly. It's now the picker (onboarding's component, 393 × 852 like the Restoring screen), open in iCloud Drive's
  Often Enough folder with two dated backups, and the arrow says *Pick the backup*; arrows, words and notes moved to
  fit the wider screens. The banner sat on the day bar: it now floats 8 above it (the same on 248's Today). Notes:
  screen 2's says why there's no choice of where and that the folder must be public; screen 5's no longer names
  Android's No Backup Found (a wrong file is an alert). Looked at screens 2, 4 and 5 again.
- [x] 248 · Restore from a backup file: Backup & Sync, Apple's file picker on Downloads, Restore this backup?,
  Restoring, Today with *10 habits restored · Undo*. Android's "Restore from a backup." choice page (screen 2) is
  deleted, as in 247, so the row opens the picker directly: the flow is five screens, the later ones moved up and
  renamed, and the arrow after the picker says *Pick the file*. Both flows' Restore this backup? alerts were drawn
  360 × 800 over a 393 × 852 picker, cut off on the right: both are 393 × 852 now, the alert centred, and 247's sits
  over its own picker instead of the deleted page, with the backup's date (9 Nov) matching the file. "This phone"
  is "this iPhone", as everywhere else. Notes: the header's said "Anyone coming from an iPhone" (now an Android
  phone); the alert's names the That Isn't a Backup alert; the Restoring note claimed it names the file's date, which
  the one Restoring page doesn't (now: the same page as onboarding's, Cancel leaves the iPhone as it was). Looked at
  every changed screen again.
- [x] 249 · Save a Backup File: Backup & Sync, Save to Files (On My iPhone ticked, Save), back on Backup & Sync with
  a banner. Layout, the shared file name (D5) and the rows' words right. The sheet saved to On My iPhone but the
  banner said "Backup file saved to Downloads": it now says *Backup file saved to On My iPhone* (the screen renamed
  to match), centred again at its new width. The header's note said "Anyone moving to an iPhone", which is
  backwards for saving a file on one: now anyone moving to another phone, an Android one too, or wanting a copy of
  their own. Looked at screen 3 again.
- [x] 250 · Export a Spreadsheet: Backup & Sync, Save to Files, back with a banner. The sheet offered to save the
  *backup* (Often Enough backup 2026-10-21 0914.zip): it now names the spreadsheet as the Android app does,
  *Often Enough Export 2026-10-21.csv* (`BackupCenter.csvName`). The banner said saved to Downloads while On My iPhone
  was ticked: now *Spreadsheet saved to On My iPhone*, centred, the screen renamed. Notes: the sheet's listed columns
  the export doesn't have (time); now Android's own, Date, Habit, What, Amount, Unit, Note; screen 3's note was empty,
  now says the banner names the folder and nothing in the app changes. Looked at screens 2 and 3 again.
- [x] 251 · Delete My Data from iCloud: the end of Backup & Sync, the alert, Not Backed Up with *Deleted from iCloud*.
  All right: the row red with Erase, the alert Cancel and Delete only with Delete red and the body saying where the
  habits stay (D9), and afterwards no Delete row, the card offering Back Up to iCloud, the banner centred clear of the
  rows. Only the screen's layer name was older than its alert's title: now *Delete Your Data from iCloud?*.
- [x] 252 · Erase All My Data: the end of Backup & Sync, the alert, Today with No Habits Yet. **Design system:** all
  three Backup & Sync screens (Backed up, Not backed up, end of the list) had their Home Indicator at 776, 10 below
  every other screen's, so its line sat cut at the bottom edge and showed as a second line under each alert's own
  (251 and 252); all three are at 766 now. The alert's title was sentence case beside 251's: now *Erase All Your
  Data?*, its layer too. The last note called the empty Today "a fresh install", which on the iPhone fetches from
  iCloud first (D14): it now says iCloud sync was turned off first so the erased habits don't come straight back
  (D9), the iCloud copy stays until it's deleted, and Restore from a Backup brings it back. Looked at screens 1 and 2
  again.
- [x] 253 · Day Starts At: Settings, the Day Starts At page (12:00 AM ticked), 3:00 AM ticked, back on Settings.
  Layout, words and notes right: the page says what the setting does above Checkmark rows, saved on the tap. The
  last screen, back on Settings, still said 12:00 AM: it now says 3:00 AM, the hour just chosen. Looked at it again.
- [x] 254 · Week Starts On: Settings, the Week Starts On page (Sunday ticked), Monday ticked, back on Settings.
  Layout, words and notes right. As in 253, the last screen still said Sunday: it now says Monday. Looked at it
  again.
- [x] 255 · Appearance: Settings, the Appearance page (Automatic ticked), Light ticked, back on Settings. Layout and
  words right: Automatic, Light, Dark, with the line above saying Automatic follows the iPhone. The last screen still
  said Automatic: now Light. Notes: the first said "System default follows the phone's dark theme", Android's words;
  now Automatic, the default, follows the iPhone's Light or Dark appearance. The last was empty: now the app stays
  light even when the iPhone is in Dark. Looked at screen 4 again.
- [x] 256 · Haptics and Sound: Settings scrolled to its end, then Sound When Done on. Screen 2 is "Sound When Done:
  on" but its switch was still off, so the two screens were the same: the switch is on now (green). The flow's title
  is title case, as the rows it names. Notes right (Haptics on and Sound off by default; the sound only when a goal is
  met; silent mode mutes it). Looked at screen 2 again.
- [x] 257 · Privacy Policy: Settings, the policy in a browser view, back in Settings. The ↗ row and the policy's words
  are right (habits on the iPhone and in the person's iCloud, no server, Plus through the App Store). The note called
  the view "a Custom Tab", Android's: now Safari's own view, SFSafariViewController. **Left for the user:** the view
  itself is still drawn as Android's Custom Tab (✕, a two-line title, share and ⋮ in a grey bar). On the iPhone it's
  Safari's view, with its own bars; drawing it from memory would break the rule to read native controls from the
  phone, so it's to be read from the phone and redrawn.
- [x] 258 · Acknowledgements: Settings, the Acknowledgements page, back in Settings. Layout and words right; screen 1's
  empty note now says the › opens the app's own page. **Left for the user:** the page lists Kotlin, Kotlinx
  Coroutines, Datetime and Serialization, the shared core's libraries, but the iPhone app is Swift only since 5 Nov
  and the iOS project has no packages. With no outside code there's nothing to acknowledge, so the page (and its row)
  may have nothing to show; whether to keep it, and with what, is the user's call. The note says so.
  - [x] **The user's answer, the same day: "Remove the row."** Acknowledgements is gone from the iPhone's Settings:
    the row from all three Settings screens (Default, End of the list, Nothing set up), so About is Privacy Policy and
    Version; the Acknowledgements page component (its one copy was this flow's); and flow 258 itself, its screens,
    arrows and notes. Nothing on any page mentions it now. Looked at Settings and its end of the list again.
    Settings now has 15 flows, 243 to 257.
