# Backup & Export and Your Account — What People Look For

Written by Claude (Claude Code), 9 October 2026, at the user's request (Current Work 58.10–58.11): "the backup and
export screen needs to be very clean and easy to understand, easy to scan … conduct thorough research on how the backup
and export screen should be, how the users expect it … where do they expect the account related stuff".

**Status: decided by the user's request, built on branch `app-lock-privacy-security`; iPhone check pending (U9).**
Evidence: [Review Evidence](<Backup & Export Screen Evidence/Review Evidence.md>) (897,899 habit-app reviews screened,
829 matches hand-coded, every cited ID and quote checked against the corpus) and
[Web and Platform Research](<Backup & Export Screen Evidence/Web and Platform Research.md>) (Apple's Human Interface
Guidelines, Nielsen Norman Group, a US Census usability study, eleven apps as references only). Labels: "users show" is
review evidence; "reasoned from first principles" is not; another app doing something is never evidence on its own.

## 1. What was wrong (the user's screenshots, 9 Oct 2026)

One list: a status line, "Where: Your account (our server)", an iCloud switch, then Back Up Now, Restore…, Move to
Another Device, Save a Backup File and Export a Spreadsheet as five look-alike rows, a paragraph, a "Sync: On" row that
can't be changed, and the account at the bottom. No grouping by job, Restore in the middle, "our server", text explaining
the screen. Two of the five buttons did the same thing: Move to Another Device and Save a Backup File both made a file
and opened the share sheet. The account (sign in, sign out, delete) could only be reached from here.

## 2. What people come to do, in order

1. **Know they're safe without doing anything.** Users show automatic backup is the first want: 99 of 125 automatic-backup
   reviews ask for it (54 of them from one app, Loop), and backups that silently stopped are rated worst (10 reviews,
   1.6–2.8★): "none of my backups had actually occurred and over two years of habit tracking data had been lost"
   (`612d885e-cb1c-4553-ac0b-fca77eaf2090`). Apple's own iCloud Backup screen is the switch, Back Up Now and the time of the
   last backup under it. → **The status comes first, with when and where, and Back Up Now beside it.**
2. **Move to a new phone.** Of 144 new-phone reviews read, 41 lost data, 19 tried and failed, 15 asked how and 11 couldn't
   find where to sign in; the 9 that worked praise clear instructions: "followed the instructions and Bam all my data is
   till here!" (`bac98001-21fb-47d4-bea1-d7f80ca1d688`). → **Moving gets its own short page that says the two steps.**
3. **Get data back after a loss.** Users show "restore" alone is ambiguous: of 123 on-topic restore reviews, **58 mean
   Restore Purchases** ("I cannot find a restore my purchase offer", `3600465748`). → **The data action names its object:
   "Restore Habits From a Backup".** Few reviews say a restore button was hard to find; the failures are files that couldn't
   be found or opened (`ba94a066-58da-49bb-b425-33f46dd13fb3`).
4. **Know where their habits are.** Users object to a server they didn't choose or can't leave ("you have no option not to
   sync if you're logged on", `d3d02976-bfc5-4604-9835-1fb4f1af77d7`); 11 praise data kept on the phone (4.91★). No review
   reacts to the words "our server": that it alarms people is reasoned from first principles, with Apple's writing guide
   ("avoid using *we*") and its iCloud guidance ("people don't need to know where content resides"). → **Places are named
   the way people name them: "your account", "iCloud", "this iPhone". Never "our server", never "we".**
5. **Export a spreadsheet.** CSV is named in 189 reviews and Excel/spreadsheets in 94, for analysis or to leave without
   losing anything; it's a different job from a backup. Users show the two blur ("there is an 'Export' data button, but no
   'Import'", `5038938558`; "the only backup option is a manual data export", `13103091241`). → **Export is its own group,
   and each row says what the file is for, in one line.**
6. **Sync** is wanted automatic (47 ask, 24 say it's broken) and **no review asks for an on/off switch**; Apple's guide says
   "a toggle always lets people manage the state of something". → **No Sync row on this screen.** Sync is part of the
   account (its devices), and the words backup and sync are never mixed (Backup, Sync and Accounts rule 10).

## 3. Where the account goes

Users look for sign-in, sign-out and their plan in **Settings or an account page** (≈13 and ≈9 reviews), never inside a
backup screen; sign-out was missing or unfindable in 28 of 86 sign-out reviews, and in 10 signing out cost data or a
purchase ("Did I buy a lifetime or yearly subscription?", `11495117139`). In a US Census Bureau study (2022) people found
log-out every time when it was on screen or in the main menu, and 54% of the time in a sub-menu. Apple puts the account at
the top of Settings with Sign Out at the bottom of its page, and expects Delete Account in "the app's account settings".

→ **An "Account" row joins the ≡ menu, first in its group: Account · Backup & Export · Privacy & Security.** The menu list
was "final" (Design Rules, 30 Sep); this changes it at the user's request of 9 Oct ("do we need a separate tab for
accounts … update the account"). Backup & Export keeps a "Your Account" row that opens the same page, because backing up to
the account is one of its places.

## 4. The design

### Backup & Export (native `Form`, four short groups, no paragraphs)

| Group | Rows |
|---|---|
| *(status, no header)* | **Backed up today 09:14** / *In your account and iCloud* (or *In your account*, *In iCloud*); **Only on this iPhone** / *Deleting the app deletes your habits*; *Backing up…*; *Not backed up yet*; a problem in red with its one fix as a button. **Back Up Now** when there's somewhere to back up to. |
| **Backed Up To** | **Your Account** › (Plus or Free) — or **Your Account: Sign In** when signed out. **iCloud** switch, only when it can be changed (signed in), with its one-line note when the copy is paused. |
| **Restore & Move** | **Restore Habits From a Backup…** · **Move to a New iPhone** › · **Undo Last Restore** (only within 30 days of a restore) |
| **Export** | **Save a Backup File** — *To restore later, here or on another iPhone* · **Export a Spreadsheet (CSV)** — *To open in Numbers, Excel or Google Sheets* |
| *(signed out only)* | **Erase All My Data…** (red, asks first, offers a backup file first) |

Gone, and where each part went (U5): "Where" → the status's second line; the backup paragraph → the status line and the
Backed Up To rows; "Sync: On" and its text → removed (sync lives with the account and its devices); "Sync is part of Plus"
→ removed (backup never looks like a Plus perk, D10); "Before You Delete the App" (three paragraphs) → the phone-only
status line *Deleting the app deletes your habits* (Offload is in Help); the Account section → the Your Account row;
Move to Another Device's duplicate share → the Move page, which still sends a file.

### Move to a New iPhone (one level down, two numbered steps)

Signed in: *1 Install Often Enough on the new iPhone · 2 Sign in with the same account*. Signed out with iCloud: *… 2 Choose
Restore Habits From a Backup* (same Apple Account). Only on this iPhone: *1 Send a backup file · 2 Open it on the new
iPhone*. Every case ends with **Send a Backup File** (the share sheet).

### Account (≡ → Account, and Backup & Export → Your Account)

Signed out: **Sign In** and one line (*Back up to your account, and with Plus, use your habits on all your devices*).
Signed in: **Signed in with** (Apple / Google and the email), **Plan** (Plus or Free), with Plus **Last Synced** (when this
iPhone last synced: people want to know when it last ran, §2.6), **Devices**, then **Sign Out** (one
line: *Your habits stay on this iPhone*) and **Delete Account…** at the bottom. Signing out leaves the page on its
signed-out state rather than closing it.

### Words

The sign-in sheet loses its two paragraphs for one line each (*Back up to your account and get your habits back on any
phone by signing in.* / *Used only to back up and sync your habits. Never sold, never for ads.*); every "our server" and "we"
on these screens is rewritten ("Couldn't reach your account" …).

## 5. Rules this keeps

D3 (the "No account yet → Create an Account" step), D4 (backup automatic, free, visible with its time), D5 (30-day undo,
every export importable), D9 (delete account, erase this phone only if chosen), D10 (nothing here is Plus-only), U1/U2
(native rows, monochrome, red only for problems and Delete), U11 (plain words). Checked with the user on the iPhone (U9).

## 6. Second pass: the user's review (9 Oct 2026, Current Work 58.12)

The user, on the first build: without an account the habits are still backed up to iCloud, and the screen didn't say
so; "Sign In" alone didn't say why an account is worth it; "Deleting the app deletes your habits" is wrong when there's an
iCloud copy and makes people anxious; the free plan's real limit is one device, with no sync between devices.

Facts checked before writing a word (Architecture 02, 03, 06; `BackupCenter`; `server/src/backup.ts`):

- **No account:** the backup goes to the person's own iCloud (`iCloud.com.oftenenough.app`, a hidden iCloud Drive
  folder), read back and checked by SHA-256, on each day something changed. It survives deleting the app, and Restore
  offers it after reinstalling.
- **A free account:** the same daily backup goes to the account (seven daily copies), with the iCloud copy beside it.
  **Encrypted in transit (TLS) and at rest (Cloudflare)**; not end-to-end, so the app says "encrypted", never "only you
  can read it".
- **Plus:** every change syncs between devices; no iCloud copy is written (so the screen no longer claims one).
- **Devices:** free is one device (phone or tablet) with no sync (Architecture 02, 1 Oct); moving takes a backup file
  or a sign-in. The iOS app is iPhone-only today.
- **Google Drive** is decided for Android only; the iOS app has no Drive code. A Drive row on iOS would do nothing, so
  it isn't shown; adding Drive on iOS is a separate piece of work for the user to decide.

What changed: §4's table now reads, without an account, *Backed up today 09:14 · In iCloud* (or *Only on this iPhone ·
No backup copy yet*), an **iCloud** row with its state (when / Full / Off / New Apple Account, a problem opening its
fix) and **Create Account** with *Encrypted daily backups that follow you to a new phone*. The sheet behind it lists the
four reasons in one line each. The account shows *Free · One device*; Move to a New iPhone adds *Without Plus, the two
don't stay in sync*. Help's "Before deleting the app" now says what really happens.
