# Data Safety — Every Way Users Lose Data, and the Rules That Prevent It

*Written by Claude (Claude Code), 26 Sep 2026.*

**What this is:** a catalogue of every data problem users report in our review corpus, from data loss, backup,
sync, accounts and switching phones to purchases and dates. For each problem it gives the rule that prevents it.
It also includes the Apple and Google platform rules we must follow, and good practices that users praise.

**It is not a decision.** It is the input to the system design in
[`Architecture/Data Safety, Accounts and Sync.md`](<../../../Architecture/Data Safety, Accounts and Sync.md>).

**How each rule is backed:**
- **Users show…**: backed by review evidence.
- **First principles**: no review covers it, so it is reasoned from how the system works.
- **Platform rule**: an Apple or Google requirement, with a link to the source.

---

## How this was made

| Step | What | Size |
|---|---|---|
| 1 | Pulled every data-related card from the **Feature Ledger**, built from our 90 hand-read App Store reports | 16 cards, e.g. C034 data loss (55 apps), C033 restore purchase (45 apps) |
| 2 | **Full-corpus screen**: keyword patterns in ~15 languages for 38 failure types | **1,487,223 reviews** (App Store 337,331 · Play 901,453 · native apps 248,439) → **53,884 matches** |
| 3 | **Read in full** a sample from each failure type (25 per type, 40 for success stories): 60% 1–3★ habit apps, 20% 4–5★ habit apps, 20% native apps (Notes, Reminders, Google Keep, Samsung Health…) | **960 read**, each coded, with **every quote checked word-for-word** against the review (0 mismatches) |
| 4 | Checked the **platform rules** against Apple's and Google's own documentation (links in Part 3) | – |

Review references look like `P84#7259`, meaning Play Store app 84, review 7259. Appendix A maps every reference
to its review ID, app, date and star rating.

**Baseline:** 10.9% of all 1.49M reviews are 1★, with an average of 4.23★. Every rate below is compared against
that baseline.

---

## Part 1 — The short version: the 15 failures that do the most damage

Ranked by severity × frequency. "1★ share" comes from the full-corpus screen.

| # | Failure | Evidence | What prevents it |
|---|---|---|---|
| 1 | **An app update wipes everything** | 2,329 screen hits, **53.9% 1★** (5× baseline). One 2025 update erased 2–5 years of history for most reviewers that month (ledger C034) | Migrations tested on every past version; snapshot before migrating; phased rollout; never reset on error |
| 2 | **The app crashes, the user reinstalls or clears data, and loses everything** | Crash-at-launch losses **61% 1★**. Support staff *told* users to reinstall (3 read cases); users too scared to reinstall (10) | Data is backed up *before* the crash; a recovery screen when launch fails; support never says "reinstall" |
| 3 | **New phone, and nothing comes across** | 100% of the phone-change sample was a real loss | Automatic backup + account + phone-to-phone transfer; offer restore *before* onboarding |
| 4 | **Paid, but premium is gone** (reinstall, new phone, iPad, other OS) | Screen **72% 1★**, mean 1.66; ledger C033: 45 apps | Entitlement tied to the account; checked on the server; restored automatically on launch |
| 5 | **"Lifetime" taken away** when the app moves to subscriptions | 30 read, mean 1.37 | Grandfathering recorded on the server, forever; Apple 3.1.2(a) requires it |
| 6 | **Signing in, signing out or a forced login wipes local data**, or opens a *different* empty account | 18 + 5 read, mean 1.4–1.6 | Signing in merges and never deletes; show which account before merging; link sign-in methods |
| 7 | **Backup exists but is hidden, manual, off, or paid** | 24 read (hidden 8, manual 9, paid 7) | Automatic, on by default, free, visible ("Backed up 2 min ago") |
| 8 | **Restore or import fails**, or restores partly (streaks, order, photos lost) | Screen 48% 1★ | Restore is tested in CI; a full round trip keeps everything |
| 9 | **Sync doesn't work** (iPad, Watch, widget) and nobody can tell | 42 + 30 + 25 read | Sync status visible; one event model for every surface |
| 10 | **Streak reset wrongly** | 35 read; ledger C038 (×10.2 among buyers) | Streaks computed from records, never stored as a counter |
| 11 | **Editing a habit rewrites its history** (change frequency, move or delete it) | 5 read, all angry | Schedule changes carry an effective date; deleting archives the habit |
| 12 | **Time zones, DST and midnight** move check-ins to the wrong day | 18 + 8 read; ledger C038 | Store the local calendar day at the moment of logging; a user-set "day starts at" |
| 13 | **No undo** for accidental delete or tick | 11 read | Undo + 30-day Recently deleted |
| 14 | **Online-only**: no internet or server down means you can't tick | Online-only sample 96% relevant | Everything works offline; the server only syncs |
| 15 | **Account deletion doesn't cancel a web subscription**, and the user can't log in to cancel | Screen **85% 1★** | Store billing only; deletion shows the subscription status and links to where to cancel |

---

## Part 2 — The full catalogue

### A. Data disappears

#### A1. App update wipes data (Users show)
- **Evidence:**
  - screen: 2,329 hits across 96 apps, **53.9% 1★**, mean 2.06;
  - read: 38 cases;
  - the largest documented incident is Report 20: update 1.41.0 (13 Mar 2025) erased habit histories, and 126 of the next 161 reviews (78.3%) reported losing 2–5 years (ledger C034).
- **Voices:**
  - “an iOS update reset the entire app overnight” (`A20#3088`)
  - “I tried restoring from back up with no luck” (`A20#3085`)
  - “Al actualizar perdi toda mi racha progreso y tareas guardadas” (`P98#2023`)
- **Worse still:**
  - One developer shipped a data-risking update and only warned users in the release notes: “in the really small update description you warn users to backup their app data before the update” (`A23#6192`).
  - Another update quietly purged history: “Bei dem letzten Update wurden aber alle Einträge in "Fertig" gelöscht, die älter als 30 Tage sind” — every completed entry older than 30 days deleted, with no confirmation (`P126#9772`).
- **Rules:**
  - Schema changes only ever add.
  - Every build is tested against a saved database from **every** shipped version.
  - The app copies the database before each migration.
  - A migration that fails rolls back and keeps the old data; the app never starts empty.
  - Releases are phased or staged.
  - The app never deletes old data on its own.

#### A2. Operating system update wipes data or breaks the app (Users show)
- **Evidence:** screen: 308 hits, **64.6% 1★**, mean 1.70 (the highest 1★ share of any loss trigger); read: 14.
- **Voices:** “After upgrading to IOS 14.5, all the habits gone” (`A2#355`); “После обновления на ios15 пропали все заметки” (`N3#18618`).
- **Rules:**
  - Test on every iOS and Android beta each summer.
  - Keep the database in the folder the system backs up (see Part 3).
  - A launch failure must never lead to data loss (see A3).

#### A3. Crash, then reinstall or clear data, then total loss (Users show)
This is the most tragic pattern, because the user destroys their own data trying to fix the app.

- **Evidence:** screen: crash-at-launch losses 175 hits, **61% 1★**; read: 48 coded as corrupted or won't open.
- **Voices:**
  - “Had to delete the app and lose all my data and reinstall just so the app would open” (`A8#557`)
  - “Clearing app data erased my entire progresses” (`P98#175`)
- **Support made it worse:**
  - “their solution was "delete everything and re-install the app" and that's how I lost all of my journeys” (`P12#35027`)
  - Support said the data would be safe: “Mi hanno detto di reinstallare l'app per risolvere ogni problema tanto i miei dati non si sarebbero persi” (`P12#115285`)
- **Users held hostage:**
  - “I am scared to delete it and reinstall bc I don’t want to lose all my data over the years” (`A13#12452`)
  - “If I delete the app from my phone and re-download, will I lose all my past data?” (`A48#2139`). This user also had no way to reach support, because the app wouldn't open.
- **"Your data got corrupted":** Finch users were told their data was corrupted and had to start again. One had kept monthly manual backups, and none of them opened: “I always do a manual backup file every month when it reminds me” (`A10#33396`).
- **Rules:**
  - **The data is already off the phone** (account sync or OS backup) before any crash happens.
  - **Crash-loop recovery screen:** after 2 failed launches, open a minimal screen with "Export my data", "Check backup", "Contact support" and "Send diagnostics".
  - **Support never recommends reinstalling** unless the backup is confirmed.
  - **The website FAQ answers "Will I lose my data if I reinstall?"** with the backup status.
  - **Restore is tested for real in CI:** backup → wipe → restore → compare.

#### A4. Reinstall, offload or accidental app deletion (Users show)
- **Evidence:** screen: 1,025 reinstall hits, **51.5% 1★**; read: 41 reinstall and 5 offload.
- **Voices:**
  - “i deleted this app for free up some space. Can I get all data back?” (`P125#5272`)
  - “it literally offloaded without me knowing and i lost all my notes” (`N3#2509`)
  - “I literally offloaded the app cause my storage was terrible” (`A4#19563`)
- **Why offloading shouldn't lose data (first principles):** iOS keeps an offloaded app's documents and data. Losses after offloading suggest data kept where iOS doesn't keep it (for example Caches), or data that lived only on a server session that was lost. **Rule:** the database lives in Application Support (iOS) or `getDatabasePath` (Android), never in caches.
- **Rule:** a reinstall restores automatically, from the account if signed in, or from the OS backup if not.

#### A5. New phone, factory reset, or phone broken or lost (Users show)
- **Evidence:** read: 36; screen: phone-change sample **100%** real losses; ledger C035: "a new phone means a lost purchase and lost data".
- **Voices:** “Upgraded my phone and lost all my previous data” (`P33#2574`); “I just lost all my tracking history when I had to reset my phone” (`A1#48527`).
- **Sync deleted the old phone's data:** “It could not sync data  to the new phone rather deleted everything from my old phone” (`P126#76460`).
- **Fear alone costs trust:** “因为我要换手机，怕换了手机后就重新开始了数据就都没了” — I'm afraid that after changing phones everything starts over (`A52#13185`).
- **Rules:**
  - Account sync, plus the WhatsApp-style "Move to a new phone" transfer from the architecture doc.
  - OS backup as a safety net.
  - **A fresh install's first screen offers "I've used this before"** (sign in, scan a code, import a file) *before* onboarding. See B5.

#### A6. Switching between iPhone and Android (Users show)
- **Evidence:** read: 6 data and 8 purchase cases; ledger C051 and C251.
- **Voices:**
  - “I used to have an android but I got a new iPhone and I don’t see any way to transfer my birdie over” (`A10#65706`)
  - “I can't even get my backup from the IOS version to restore on the Android version” (`P130#354`). The backup format was different on each platform.
- **Rules:**
  - One data model and one export format on every platform.
  - The server is platform-neutral.
  - Purchases are honoured across platforms (Part 3, Apple 3.1.3(b)).

#### A7. Signing in, signing out or a forced login destroys data (Users show)
- **Evidence:** read: 18, mean 1.61; plus 5 cases of landing in the *wrong* account.
- **Voices:**
  - “After the update it force asked me to sign in. After I did so, the entire app was wiped clean” (`N10#20114`)
  - “trying to sign in to an account deleted all of my existing data” (`A33#3361`)
  - “this app redirects me to a new account using one of my email accounts that I didn't use to sign up” (`P111#1368`)
  - “Couldn’t remember if I even used one before with this app and picked one of my Microsoft accounts” (`N10#16728`)
- **Rules:**
  - Signing in **never** deletes local data. It merges, or asks, and whatever is set aside is kept as a snapshot.
  - Before merging, show which account it is ("Signed in as ...@icloud.com via Apple, 142 habits, last used 3 Sep").
  - One account can link Apple, Google and email.
  - If a sign-in creates a brand-new account, warn: "This is a new account. Did you use another sign-in before?"
  - Signing out asks "Keep a copy on this phone?"

#### A8. Sync destroys data, lets deletes come back, or erases offline edits (Users show)
- **Voices:**
  - Offline edits wiped: “When you add items while OFFLINE (due to being abroad) your items will all be erased even once you connect” (`A85#2527`)
  - Sync wiped the account: “deleted all my tasks when I tried to sync it to my Google account” (`P126#74850`)
  - Deleted items came back: “after logging out and back in, they are back again on the mac app” (`A33#1359`)
- **Rules:**
  - Offline edits wait in the outbox; nothing is dropped.
  - The server never sends "empty state wins".
  - Deletes are tombstones.
  - Only field-level changes are sent.
  - A big drop in a user's data triggers the data-loss canary, which stops sync for that account.

#### A9. Silent partial loss: ticks vanish, saves don't stick (Users show)
- **Evidence:** read: 11 partial and 19 not saved.
- **Voices:**
  - “I'll check items off and then a couple days later, those same check marks are gone” (`P3#7335`)
  - “saying my habit has been recorded then not showing up as completed” (`A16#852`)
  - A draft lost in a crash: “the app shutsdown and I lose all the progress I’ve made while trying to create my first habit” (`A1#51980`)
- **Rules:**
  - Every tap is written to disk in a transaction before the screen shows it as done.
  - Drafts (new habit, note) are saved while typing.
  - A per-habit change history lets users see and undo.

#### A10. Editing a habit rewrites its past (Users show)
- **Voices:**
  - “if you change how many times per week for any habit, it destroys the overall streak data for ALL previous days” (`A13#4417`)
  - “Any removal of habits for TODAY is also reflected for all the previous days” (`P12#16760`)
  - A misleading prompt: “it will “update the stats”, not that it will “delete the stats”” (`A13#13150`)
  - “Every time I make a new task I loose my streak” (`P98#1078`)
- **Rules:**
  - Schedules and goals are **versioned with an effective date**, and past days are judged by the rules that applied then.
  - Moving a habit to another part of the day affects today onward only.
  - Adding or deleting one habit never changes another habit's streak.

#### A11. Mistakes with no undo (Users show)
- **Voices:**
  - “I accidentally deleted one of my habits. To my surprise, there's no possibility of undoing that operation” (`A1#100`)
  - “Remove single click habit delete, use recycle bin and archive” (`P123#1150`)
- **The success case:** “it has the ability to restore things accidentally deleted” (`P84#22354`, 5★).
- **Rules:**
  - An undo snackbar for every destructive action.
  - A 30-day **Recently deleted**.
  - **Archive** is the default way to stop a habit, keeping its history.

#### A12. Data held hostage by the paywall (Users show)
- **Voices:**
  - “you will lose all your data and access to the app unless you pay the premium” (`P91#167`)
  - Premium lapsed and the habits disappeared (`A20#1776`)
  - Backup behind the paywall: “YOUR INFO WILL BE LOST IF YOU CHANGE PHONES AND DIDN'T PAY FOR PREMIUM” (`P84#7259`)
  - Restore behind the paywall, found out only after backing up: “When I came to restore the data it's says that only in premium version its possible” (`P84#17041`)
- **Rules:**
  - **Backup, restore, export, import and sync of your own data are always free.**
  - When a subscription ends, extra features become read-only at worst. Data is never hidden or deleted.
- **Ledger C020 agrees:** charging for export generates requests, not revenue.

#### A13. Encryption lock-out (Users show, supports "no end-to-end encryption in v1")
- **Voices:**
  - “if you lose access to the password, you lose access to every single locked note” (`N3#21519`)
  - “Since the data is encrypted, it will not transfer phone to phone” (`P84#7771`)
- **Rule:** no user-held encryption keys in v1. If it is added later, it is opt-in, with a recovery key and a clear warning.

### B. Backups that fail when needed

#### B1. No backup, hidden backup, manual backup (Users show)
- **Evidence:** screen: "no backup" 1,217 hits (96% of the sample on topic); read: 24 none, 8 hidden, 9 manual.
- **Voices:**
  - “none of your data is saved by default and even with a paid Plus subscription, the app never tells you that there’s no backup” (`A10#20391`)
  - “I thought it was being backed up on my iCloud apparently not” (`A86#87`)
  - “I've lost all my tracked habits once when I changed my device and forgot to backup” (`P3#21586`)
  - “the app was not covered by Samsung backup system and I was not warned at any point” (`P126#27435`)
- **Rules:**
  - Backup is automatic and on by default.
  - The app says plainly when it is *not* backed up, with a "Not backed up" dot on the avatar.
  - Settings shows the last backup time.
  - No manual steps are needed to be safe.

#### B2. Restore fails, or restores only part (Users show)
- **Evidence:** screen: 914 hits, **48% 1★**; read: 12 failed, 2 partial, 2 falsely reported success.
- **Voices:**
  - “the new backup that you transfer over will lose all of your streaks” (`P3#4487`)
  - “most pictures got broken and couldn't be shown” (`A86#1392`)
  - “App on new phone was not able to import data that was supposedly auto-synced to the cloud” (`A55#1250`)
  - A false success: “Google Drive export fails every time,  but says that it was successful” (`P65#7648`)
  - “I thought it syncs my data to the cloud. But when I got a new phone and logged back in, all my weight data for the last two years was gone” (`N11#4206`)
- **Rules:**
  - A backup is only "done" after the server confirms it.
  - Restore brings back **everything**: habits, order, colours, notes, streak history and attachments.
  - CI runs a full round trip on every build.
  - Restoring from an older app version's backup works.

#### B3. Export broken or useless; export without import (Users show)
- **Voices:**
  - “Export to csv never worked nor got fixed” (`A31#1913`)
  - “I asked them to change data export format from sqlite so i can use it in excel” (`A13#12199`)
  - Dates shifted in the export: “When I download my habit tracking data, the days are incorrectly tied to the tracker” (`A48#2931`)
  - Export with no way back in: “Exported the CSV to Google drive and changed my phone now I'm unable to import” (`P3#15104`)
- **Praised:**
  - “Export and import to another device is flawless” (`P3#3364`)
  - “allows you to export all your data in CSV format” (`A41#85`)
- **Rules:**
  - Export both a readable CSV and a complete JSON, using **local calendar dates**.
  - Every export can be imported back, on either platform.
  - Also import CSV from common rival apps (users switching in: C020, `P3#5220`).
  - Export must not freeze with large histories (`A31#3064`).

#### B4. Onboarding before restore (Users show)
- **Voice:** “you need to go through the process of starting from scratch before you can reload the data” (`P12#31872`).
- **Rule:** the very first screen of a fresh install offers "New here" or "I've used this before".

### C. Sync

#### C1. It doesn't sync, syncs partly, or is slow, and you can't tell (Users show)
- **Evidence:** screen: 5,932 hits, **92% on topic**, 41.5% 1★; read: 42 failed, 4 partial, 8 slow; ledger C030: sync failure ×12.8 among buyers.
- **Voices:**
  - “Fica vazio como se fosse outro usuário” — the iPad shows empty, as if it were another user (`A13#1005`)
  - “I cannot sync all my habits to my iPad version, which got me worried about what will happen when I get new phones” (`A1#55314`)
- **Rules:**
  - Visible sync status ("Synced 1 min ago", "3 changes waiting").
  - A "sync now" button that never hides failures.
  - Errors are shown in plain words.

#### C2. Duplicates, conflicts and reverts (Users show)
- **Voices:**
  - “I tap an icon to say I’ve done it, then20 minutes late it’s unchecked again!!” (`A86#760`)
  - “all my notes mass duplicate themselves” (`N7#10494`)
  - Reminders fire on every device, so users log twice: “if you have already checked off a habit on one device, you still receive a reminder to mark the habit on another device” (`A48#1204`)
- **Rules:**
  - Operation IDs make every change idempotent.
  - IDs are created on the device, so there is no duplicate creation.
  - Per-field last-writer-wins, with a hybrid clock.
  - When a habit is ticked on one device, **cancel its pending reminder on the others** (silent push on sync).

#### C3. Watch (Users show)
- **Evidence:** screen: 840 hits, **96% on topic**; read: 30; ledger C022: 48 apps, "a half-built Watch app draws 2–3★".
- **Voices:**
  - “I complete habits but it doesn’t show on the mobile app and vice versa” (`A33#1333`)
  - “the Apple Watch app states “Please add a habit to the iPhone app please”” (`A1#52191`)
- **Praised:** “the Habitify syncs perfectly between the watch to an android even with the iPhone off” (`P37#597`).
- **Rule (for later):** the Watch writes through the same outbox and event model, with two-way sync and a conflict test.

#### C4. Widgets show stale data (Users show)
- **Evidence:** screen: 609 hits; read: 25.
- **Voices:**
  - “the widgets don't update for a new day anymore until I actually open the app” (`P8#1317`)
  - “In app showing correct data which is not reflected in widget” (`P123#774`)
  - A widget asking the user to unlock the phone: “says that I have to unlock it” (`A36#430`). This is the iOS file-protection trap in Part 3.
- **Rules:**
  - Widgets read the same database from the shared App Group, with file protection that allows reading after the first unlock.
  - The widget's timeline refreshes at the user's day boundary.
  - Taps on the widget write through the same outbox.

#### C5. Health data double-counted or wrong (Users show; ledger C072)
- **Voices:** “now it thinks I did twice the exercise” (`N5#14114`).
- **Rule (for later):** de-duplicate Health imports by the source sample ID, and show the source value.

### D. Accounts

#### D1. No account, so nothing can move (Users show): the most common request
- **Evidence:** read: 29 (mean 2.59); screen: 100% of that sample on topic; ledger C035 (29 apps).
- **Voices:**
  - “If there was a “Sign In With Existing Account” feature, I would be able to use the app over more than one device” (`A13#13561`)
  - “Please add Google account sync 🙏 . Lost all data when my phone crashed” (`P3#9704`)

#### D2. Forced sign-up (Users show): counter-evidence
- **Evidence:** read: 13, **mean 1.15**.
- **Voices:**
  - “You cannot use it offline/standalone - forces you to make an account to sell your data” (`P122#2263`)
  - “I shouldn't have to sign up to use this app” (`P97#2637`)
- **Praised:** “No sign up needed and treats your personal data with respect” (`A7#486`).
- **Together, D1 and D2 mean:** accounts exist from day one, but signing up is optional. This matches the architecture doc.

#### D3. Can't log in (Users show)
- **Evidence:** screen: 1,070 hits, **64.9% 1★**; read: 34.
- **The patterns:**
  - Sign-in providers breaking: Facebook (`P24#23359`), Google (`P8#5444`), a phone-number login (`A10#16520`).
  - Reset emails never arriving: “Requested a password reset via email, no email has come through” (`A85#1053`).
  - "Account never existed" after a reinstall (`A10#33224`).
  - Contradictory errors: “First I get that there's no account with my email, then try to use the same email to create a new account and it says that there's already an account” (`N10#13590`).
- **Rules:**
  - Apple + Google at launch, as decided.
  - No passwords.
  - Every sign-in error names the next step.
  - Login codes are delivered and monitored.
  - Account lookup works by any linked provider.

#### D4. Random logouts (Users show)
- **Voice:** “almost every time I open it, I’m logged out, and it forces me to send a verification email” (`A16#123`).
- **Rule:** long-lived refresh tokens. Logging out never happens silently, and the app keeps working offline while signed out.

#### D5. Can't sign out or delete the account; deletion doesn't stop billing (Users show)
- **Evidence:** screen: "account delete" hits, **85% 1★**, mostly this pattern.
- **Voices:**
  - “I deleted my account thinking it would delete my subscription, it did not” (`A33#1266`)
  - Once the account was deleted, the user couldn't log in to cancel: “I couldn’t log in because I had previously deleted my account” (`A68#3017`)
  - “不能退出苹果账号，注销账号也只是清空数据” — can't sign out; deleting the account only clears data (`A52#5891`)
- **Rules:**
  - In-app and web deletion (Part 3).
  - Before deleting, show the active subscription and a direct link to the App Store or Play subscription page, stating that deleting the account does **not** cancel the store subscription.
  - Restore Purchase still works after deletion.
  - Sign-out is always available.

#### D6. Several accounts (work and personal) (Users show, Microsoft To Do only)
- Low priority; noted for web and desktop later.

### E. Purchases and entitlements

#### E1. Paid but not unlocked; lost after reinstall, new phone or second device (Users show)
- **Evidence:**
  - screen: restore-purchase **72% 1★**, mean 1.66;
  - charged-but-locked **72.9% 1★**;
  - ledger C033 (45 apps) and C065 (paying users give 1★ at ×6.7).
- **Voices:**
  - “When I tapped restore purchase it just shows me ads for the subscription” (`A31#1594`)
  - “Purchased premium on iPad and it did not transfer to iPhone” (`A1#54685`)
  - “I cannot restore my data from the cloud backup, as the app prompts me to pay for Premium again” (`P2#1413`)
  - “Twice, I actually purchased the offer just to make it go away, but it was never applied” (`A31#1225`)
- **Rules:**
  - Entitlements live on the server, tied to the account.
  - Restore runs automatically on every launch, as well as through the button.
  - Entitlements cover every device of the same platform family (Apple 3.1.2(a)).
  - Grant the entitlement in the same step as the purchase, and show any upsell afterwards (ledger C033, Report 31).

#### E2. Pay again on the other OS (Users show)
- **Voices:**
  - “the app on Android tells me no subscription is found, and I have to pay again” (`P12#55685`)
  - “you should provide a button for us to sign in so I don't have to buy and pay again” (`P130#308`)
- **Rule:** honour purchases across platforms through the account. Apple 3.1.3(b) allows this, provided the item is also sold as an in-app purchase.

#### E3. Lifetime revoked or turned into a subscription (Users show)
- **Evidence:** read: 30, **mean 1.37**; Report 20's 2021 revocation drew 91 restore complaints, 75.8% from payers (ledger C033).
- **Voices:**
  - “I paid for a lifetime subscription, which was taken away in just 2 weeks” (`A20#1458`)
  - The fixed version of the same story, 4★: “Glad Habit has responded and updated the app to restore premium for users who purchased before the upgrade” (`A20#3290`)
- **Rules:**
  - "Lifetime" means forever.
  - Grandfathered rights are stored on the server per account and never depend on a local flag.

#### E4. A family plan with no way to share (Users show)
- **Evidence:** read: 14 across 4 apps, 11 of them from one app's family plan, mean 1.79.
- **Voices:**
  - “Purchased the lifetime family plan and cannot add my daughter” (`A1#51690`)
  - “everyone who is signed as “family” in Apple, can subscribe to this app and it will charge your card” (`A1#47908`)
- **Rule:** if we offer family access, use the store's own Family Sharing, which is automatic, or build a working invite flow *before* selling it.

#### E5. Web subscriptions invisible and hard to cancel (Users show)
- **Evidence:** read: 16, mean 1.31, 15 of them about one app (Fabulous, on both stores).
- **Voice:** “The subscription is not present in your Apple subscriptions” (`A24#23338`).
- **Rule:** sell only through the App Store and Play billing, so users can always see and cancel in the system settings.

#### E6. Charged twice; still asked to pay after paying (Users show)
- **Voice:** “it locks up and insists I need to purchase access to the premium features - and I’ve already paid” (`A24#34199`).
- **Rule:** before showing any paywall, check the entitlement on the server; never upsell an entitled user.

#### E7. Consumables not applied: streak savers that don't save (Users show)
- **Voice:** “TWO ON HAND STREAK REPAIRS AND IT LOST MY STREAKKKKKKKKKKK” (`A10#325`).
- **Rule:** if we ever have streak freezes, apply them in the same transaction as the missed day, on the server.

#### E8. Different features on each platform (Users show; ledger C251)
- **Voice:** “die Widgets kann ich scheinbar nicht auf Android installieren sonder nur auf IOS” — widgets exist only on iOS, and this user paid for a year (`P4#2666`).
- **Rule:** the same features on iOS and Android, or a visible "coming soon" state.

### F. Dates and time (ledger C038: 36 apps, ×10.2 among buyers)

| Problem | Voice | Rule |
|---|---|---|
| Travel across time zones moves check-ins | “I went from the pacific time zone to the eastern time zone on holiday and all streaks and checks got completely messed up” (`A48#2859`) | Store the **local calendar day at the moment of logging** plus the time zone. Past days never move |
| A tick lands on the wrong day | “the app marks it complete on 23rd March” (`P11#5243`) | Same as above; test every surface |
| DST | “It broke down after daylight savings it keeps thinking today is yesterday” (`A1#54197`) | DST tests in CI (both transitions, 23- and 25-hour days) |
| Midnight / day start | “The ‘start of the day’ feature is really not intuitive” (`A23#0`) | A user-set "day starts at" with a clear explanation |
| Streak reset wrongly | “my Day streak of 267 disappeared even though I didn’t miss any days” (`A10#18457`) | Streaks are *derived* from records and recomputed, never stored as a counter; show why a streak ended |
| Streak shown broken when data is complete | “it shows your streaks as being broken even though the data says they’re complete” (`A1#2281`) | One function computes streaks on every surface |
| No backfill | “impossible to change previous day record” (`A23#2502`) | Allow backfilling past days |
| Skip counted as done | “when I skip a habit, the app currently logs it as completed” (`A1#46783`) | Skip is its own state; history shows it as not done |
| Reminders ignore time zone | “Reminder time isn't adjusted for the timezone” (`A31#4961`) | Reminders follow local time by default |
| Week start ignored | “My week setting is to start on Monday, but on Sunday it cleared and reset the week” (`A31#3273`) | Week start is honoured everywhere, including widgets |
| Calendar systems | “The lunar day of Vietnam is wrong” (`N2#24263`) | Use the system calendar APIs; test non-Gregorian locales (e.g. Buddhist year) |

### G. Offline and performance

- **Online-only apps (Users show):**
  - Evidence: screen: 1,574 hits, **96% on topic**; read: 27.
  - “Server has been down today and I cant check off or edit my to-do list” (`P8#6812`)
  - “uninstalled because it wouldn't work offline” (`P8#7209`)
  - Praised: “Simple, light, customizable, offline” (`P84#16756`).
  - **Rule:** everything works offline, and the server is only for sync.
- **Slower as data grows (Users show):**
  - “It takes ages to log habits and even scrolling through a short habit list has become a pain” (`A31#2533`)
  - **Rule:** a performance budget tested with 10 years × 50 habits of data. Ticking takes under 100 ms, and cold launch under 1 s.

### H. Trust, privacy and support

- **Privacy (Users show):**
  - Read: 18 concerns, mean 1.17: “Your data cannot be deleted and is not encrypted” (`P4#21633`).
  - Local and private is praised: “All data in the app stays in your phone” (`A86#84`); “i love knowing this app is private” (`A10#21485`).
  - **Rules:** no selling of data; collect as little as possible; a truthful privacy label; a plain-language "where your data lives" page.
- **No channel when the app won't open (Users show):**
  - “writing a negative review is the only way to get technical support” (`N7#1378`)
  - **Rule:** a support email and FAQ on the website, and the recovery screen from A3.
- **Communication (Users show):**
  - An update wiped data “without any communication” (`A20#1814`).
  - **Rule:** during any data incident, an in-app banner plus a status page, and a written post-mortem.
- **Support that saves users (Users show):**
  - “the Finch team’s kind care when my data corrupted, so I updated my rating after all” (`A10#28347`)
  - **Rule:** support can restore any account to a point in time, which the server's 30-day recovery makes possible.

---

## Part 3 — Platform rules we must follow

Checked against the official pages on 26 Sep 2026, unless marked otherwise.

### Google Play Billing ([integrate guide](https://developer.android.com/google/play/billing/integrate), [subscription lifecycle](https://developer.android.com/google/play/billing/lifecycle/subscriptions))

| Rule | What it means for us |
|---|---|
| **Acknowledge every purchase within 3 days**, or Google automatically refunds it and revokes the entitlement | The server verifies and acknowledges immediately. An alert fires if anything is unacknowledged after 24 h |
| **Grant only when the state is PURCHASED**. Never grant or acknowledge while PENDING. The 3-day clock starts at PURCHASED | Show "payment pending" (cash and slow payment methods) |
| **Call `queryPurchasesAsync()` on launch and on resume**, to catch purchases missed through network loss, other devices, or changes while the app was closed | Part of the restore-on-launch rule (E1) |
| **Set `obfuscatedAccountId`** in the purchase flow | Links each Play purchase to our account, and helps fraud detection |
| **Real-time developer notifications** and `purchases.subscriptionsv2.get` are the source of truth | The server tracks renewals, cancellations and refunds without the app being open |
| Subscription states: **active** and **grace period** = access; **on hold** and **paused** = no access; **cancelled** = access until expiry; **revoked** = remove immediately | Encode this table exactly; data is never touched, only features |
| **`linkedPurchaseToken`** links upgrades, downgrades and resubscribes to the old purchase | Keeps the same account through plan changes |

### Apple App Store ([App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/))

| Rule | What it means for us |
|---|---|
| **3.1.1:** "make sure you have a restore mechanism for any restorable in-app purchases" | A Restore Purchase button, plus automatic restore |
| **3.1.2(a):** subscriptions must be "available across all of the user's devices" | iPhone, iPad, Mac and Watch all unlocked |
| **3.1.2(a):** when moving to subscriptions, "you should not take away the primary functionality existing users have already paid for" | Lifetime is grandfathered forever (E3) |
| **3.1.3(b):** apps "may allow users to access content, subscriptions, or features they have acquired in your app on other platforms", provided they are also sold as in-app purchases | Cross-platform entitlements are allowed (E2) |
| **5.1.1(v):** "If your app doesn't include significant account-based features, let people use it without a login" | Sign-up stays optional (D2) |
| **5.1.1(v):** apps that support account creation must offer account deletion in the app | (D5) |
| **4.8:** apps with third-party login must offer an equivalent private option | Sign in with Apple |

**StoreKit 2 practice** (from Apple's StoreKit documentation; the page could not be re-fetched today, so treat
this as known practice to re-check at build time):
- Start listening to `Transaction.updates` at launch, because purchases from other devices, Ask to Buy
  approvals, renewals and refunds arrive there.
- `finish()` each verified transaction.
- Use `Transaction.currentEntitlements` for the current state.
- Set `appAccountToken` to link purchases to our account.
- Handle refunds and revocation through App Store Server Notifications V2.

### Google Play account deletion ([policy](https://support.google.com/googleplay/android-developer/answer/13327111))
- The app must offer an **in-app path** to delete the account and its data.
- There must also be a **web link** that works after the app has been uninstalled.
- Data may be kept only for legitimate reasons such as security, fraud prevention or regulation, and only if disclosed.

### Android backup ([Auto Backup](https://developer.android.com/identity/data/autobackup), [testing](https://developer.android.com/identity/data/testingbackup))
- **Size and cost:** 25 MB per app per user, free, and it doesn't count toward the user's Drive quota.
- **Frequency and storage:** it runs about daily, when the phone is idle and on Wi-Fi. Only the latest backup is kept.
- **Encryption:** backups are end-to-end encrypted with the screen lock on Android 9+.
- **Databases are included by default.** Cache, code-cache and `no_backup` folders are excluded.
- **On Android 12+,** `dataExtractionRules` has separate **cloud-backup** and **device-transfer** sections. On some manufacturers, `allowBackup="false"` stops cloud backup but *not* phone-to-phone transfer.
- **Restore happens at install, before the app first opens.**

From these, three first-principles rules follow:
1. **Keep the device ID, sync cursor and session tokens in `no_backup`,** because a restored copy must register as a new device. Otherwise two phones share one identity and sync corrupts both.
2. **A restored database may come from an older app version,** so migrations must run on it.
3. **After restoring, force a full sync** before trusting local "last synced" markers.
- **Hibernation:** Android pauses the activity of unused apps ("Pause app activity if unused"). One user missed reminders for a long time because of it (`P3#4628`). **Rule:** detect this and explain how to turn it off.

### iOS storage ([iCloud backup guidance](https://developer.apple.com/documentation/foundation/optimizing-your-app-s-data-for-icloud-backup))
- **`Documents/` and `Library/Application Support/` are backed up**; `Caches/` and `tmp/` are not. The database goes in Application Support.
- **Offloading keeps an app's documents and data** (per iOS Settings). Losses after offloading therefore point to data stored in the wrong place (A4).
- **The widget "unlock" trap** (first principles + `A36#430`): with complete file protection, a widget or background task cannot read the database while the phone is locked. **Rule:** use "complete until first user authentication" for the shared database.
- **0xdead10cc** (known iOS crash code, not re-fetched today): iOS kills an app that holds a SQLite lock in a shared App Group container while being suspended. **Rule:** finish or cancel writes when the app goes to the background, and keep transactions short.

---

## Part 4 — What users praise (copy these)

| Praised | Voice |
|---|---|
| Seamless sync across devices | “it all syncs seamlessly unlike most habit trackers I’ve used” (`A41#379`) |
| Moving phones just works | “I also recently changed devices and everything transferred perfectly” (`P91#53`) |
| Export and import that work | “Export and import to another device is flawless” (`P3#3364`) |
| No account needed | “No sign up needed and treats your personal data with respect” (`A7#486`) |
| Data stays private | “All data in the app stays in your phone” (`A86#84`) |
| Trash / undo | “it has the ability to restore things accidentally deleted” (`P84#22354`) |
| Works offline | “no WiFi needed” (`A10#20467`) |
| Support that fixes things | “after reporting it, the team fixed it within just a week” (`A5#1926`) |
| A restore that was fixed and works | “the premium features I had paid for and come to enjoy were restored through the “restore purchases” button” (`A20#315`) |

---

## Part 5 — What this adds to the architecture doc

Already covered by [`Architecture/Data Safety, Accounts and Sync.md`](<../../../Architecture/Data Safety, Accounts and Sync.md>):
- local SQLite as the source of truth;
- outbox, idempotent sync and tombstones;
- snapshots before migrations;
- OS backup;
- free export and import;
- account sync with 30-day recovery;
- optional sign-up;
- the data-loss canary;
- phased releases;
- no end-to-end encryption in v1;
- QR phone transfer.

**New from this research:**
1. **Crash-loop recovery screen** and "never tell users to reinstall" (A3).
2. **"I've used this before" before onboarding** (A5, B4).
3. **Signing in never deletes; show the account before merging; warn on a brand-new account** (A7).
4. **Schedules and goals versioned with effective dates; streaks derived, never stored** (A10, F).
5. **Undo, Recently deleted and Archive** (A11).
6. **Data never held hostage:** backup, restore, export and sync are free, and an ended subscription never hides data (A12).
7. **Export uses local dates, every export can be imported, and CSV import from rival apps** (B3).
8. **A backup counts only when the server confirms it; restore is round-trip tested in CI** (B2).
9. **Cancel reminders on other devices once a habit is ticked** (C2).
10. **Widget file protection plus a refresh at the day boundary** (C4).
11. **Store billing only; account deletion shows the subscription status and links to cancel** (D5, E5).
12. **Restore entitlements automatically on launch; acknowledge Play purchases immediately; lifetime is forever** (E1, E3, Part 3).
13. **Device ID, cursor and tokens excluded from OS backup; full sync after an OS restore** (Part 3).
14. **Performance budget for 10 years of data** (G).
15. **Incident communication: in-app banner and status page** (H).

---

## Limits of this report

- **Screen counts are keyword matches,** not hand-counted totals. The "share on topic" column is from 25 reads per
  type, weighted toward low ratings, so the estimates are rough.
- **The Play Store corpus has no per-app hand-read reports.** Its evidence here comes from the screen and the sample.
- **Native apps** (Notes, Reminders, Google Keep, Samsung Health, Microsoft To Do…) are not habit trackers. They
  are used here for lessons about sync and loss, not for habit-specific claims.
- **No trend-over-time claims are made,** so the survivorship checks were not needed.

## Appendix A — Every review cited

Generated from the corpus by `build_appendix.py`; see the table below.

<!-- APPENDIX -->

131 reviews cited. Ref = store letter + app number + line index in that app's `reviews.jsonl`.

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#100` | `12813158013` | App Store (ar) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2025-06-24 | 2★ | L_USER |
| `A1#2281` | `8644664722` | App Store (ca) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2022-05-07 | 3★ | T_STREAK |
| `A1#46783` | `13846085905` | App Store (in) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2026-03-14 | 5★ | T_SKIP_SEMANTICS |
| `A1#47908` | `10722392885` | App Store (md) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2023-12-20 | 2★ | E_FAMILY_CHARGE |
| `A1#48527` | `11196093258` | App Store (nl) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-04-24 | 4★ | L_PHONE |
| `A1#51690` | `12242228925` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2025-01-28 | 1★ | E_FAMILY, X_PAYER |
| `A1#51980` | `11830163287` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-10-13 | 1★ | L_DRAFT |
| `A1#52191` | `11426782012` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-06-26 | 3★ | S_WATCH |
| `A1#54197` | `9708123607` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2023-03-13 | 5★ | T_DST, T_DATE, X_NO_CHANNEL |
| `A1#54685` | `9363590247` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2022-12-05 | 4★ | E_DEVICE, X_PAYER |
| `A1#55314` | `8325687578` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2022-02-06 | 3★ | S_FAIL, S_PARTIAL |
| `A2#355` | `7271771390` | App Store (ru) | 2. Daily Habits - Habit Tracker - Habit List and Routine Tracker | 2021-04-28 | 1★ | L_OSUPD |
| `A4#19563` | `9791906911` | App Store (us) | 4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker | 2023-04-06 | 2★ | L_REINST, L_OFFLOAD, A_NOACC |
| `A5#1926` | `14075143379` | App Store (sa) | 5. Routine Planner, Habit Tracker - Daily Time Management for ADHD | 2026-05-17 | 5★ | POS_SUPPORT |
| `A7#486` | `9901846846` | App Store (kr) | 7. Habit Tracker - HabitKit - Streaks & Accountability | 2023-05-07 | 4★ | POS_NOACCOUNT, PR_LOCAL_PRAISE |
| `A8#557` | `11334966642` | App Store (ph) | 8. Onrise - Habit Tracker & Focus - Build habits, focus & journal | 2024-06-02 | 2★ | L_CORRUPT, L_REINST |
| `A10#325` | `14154584824` | App Store (au) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-06-07 | 4★ | T_STREAK, E_CONSUMABLE |
| `A10#16520` | `13640888834` | App Store (lk) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-01-16 | 5★ | A_LOGIN_FAIL, A_PROVIDER |
| `A10#18457` | `12471642902` | App Store (se) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-03-27 | 3★ | T_STREAK |
| `A10#20391` | `14243659017` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-06-30 | 1★ | L_PHONE, A_NOACC, B_HIDDEN, X_PAYER |
| `A10#20467` | `14233226313` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-06-27 | 5★ | POS_OFFLINE |
| `A10#21485` | `14136151685` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-06-02 | 5★ | PR_LOCAL_PRAISE |
| `A10#28347` | `13365769674` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-11-07 | 3★ | L_CORRUPT, X_SUPPORT_SAVED |
| `A10#33224` | `12611463470` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-05-02 | 4★ | L_REINST, A_LOGIN_FAIL, E_RESTORE, E_DOUBLE, X_PAYER |
| `A10#33396` | `12595515502` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-04-28 | 1★ | L_CORRUPT, B_RESTORE_FAIL, X_PAYER, X_CHURN |
| `A10#65706` | `8554393257` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2022-04-11 | 1★ | L_XOS, S_XOS |
| `A13#1005` | `9438976827` | App Store (br) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2022-12-27 | 3★ | S_FAIL, A_WRONG_ACCOUNT, X_PAYER |
| `A13#4417` | `11089722245` | App Store (cz) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2024-03-27 | 4★ | L_EDITHIST |
| `A13#12199` | `7151936917` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2021-03-27 | 1★ | B_EXPORT_BAD, X_SUPPORT_NONE |
| `A13#12452` | `6567640264` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2020-10-24 | 2★ | L_CORRUPT, X_REINSTALL_FEAR |
| `A13#13150` | `5751801063` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2020-04-02 | 1★ | L_EDITHIST, X_PAYER |
| `A13#13561` | `5363950167` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2020-01-05 | 3★ | A_NOACC, S_MULTI_REQ, X_PAYER |
| `A16#123` | `11022816765` | App Store (ca) | 16. Atoms - from Atomic Habits - The official Atomic Habits app | 2024-03-08 | 2★ | A_LOGOUT, A_EMAIL |
| `A16#852` | `11032957168` | App Store (us) | 16. Atoms - from Atomic Habits - The official Atomic Habits app | 2024-03-11 | 2★ | L_NOTSAVED, T_NOBACKFILL |
| `A20#315` | `7003059038` | App Store (ca) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2021-02-17 | 5★ | POS_RESTORE, X_SUPPORT_SAVED |
| `A20#1458` | `6931305336` | App Store (il) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2021-01-30 | 1★ | E_LIFETIME, X_PAYER |
| `A20#1776` | `12418376691` | App Store (pl) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2025-03-14 | 3★ | L_PAYWALL, X_SUPPORT_NONE, X_CHURN, X_PAYER |
| `A20#1814` | `6939561990` | App Store (pl) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2021-02-01 | 1★ | L_UPD, E_LIFETIME, X_NOTICE, X_PAYER |
| `A20#3085` | `12421896263` | App Store (us) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2025-03-15 | 1★ | L_UPD, L_RANDOM, B_RESTORE_FAIL, X_PAYER |
| `A20#3088` | `12420735034` | App Store (us) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2025-03-14 | 1★ | L_UPD |
| `A20#3290` | `7014338184` | App Store (us) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2021-02-19 | 4★ | E_LIFETIME, X_SUPPORT_SAVED, X_PAYER |
| `A23#0` | `13118511580` | App Store (ae) | 23. Streaks - The habit-forming to-do list | 2025-09-09 | 3★ | T_MIDNIGHT, T_STREAK |
| `A23#2502` | `6092744357` | App Store (ie) | 23. Streaks - The habit-forming to-do list | 2020-06-18 | 2★ | T_NOBACKFILL |
| `A23#6192` | `1450424836` | App Store (us) | 23. Streaks - The habit-forming to-do list | 2016-09-16 | 1★ | L_UPD, X_NOTICE |
| `A24#23338` | `14296691149` | App Store (us) | 24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help | 2026-07-13 | 2★ | E_WEBSUB |
| `A24#34199` | `7831863122` | App Store (us) | 24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help | 2021-09-22 | 2★ | E_UPSELL, E_DOUBLE, X_PAYER |
| `A31#1225` | `11554629938` | App Store (gb) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2024-07-31 | 2★ | E_CHARGED, E_UPSELL, X_CHURN, X_PAYER |
| `A31#1594` | `7409688659` | App Store (gb) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2021-05-31 | 1★ | E_RESTORE, E_LIFETIME, L_PHONE, X_SUPPORT_NONE, X_PAYER |
| `A31#1913` | `9826980863` | App Store (lu) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2023-04-16 | 1★ | B_EXPORT_BAD |
| `A31#2533` | `12330590961` | App Store (us) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2025-02-19 | 1★ | P_SLOW_DATA, X_CHURN |
| `A31#3064` | `9895641170` | App Store (us) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2023-05-05 | 1★ | E_LIFETIME, E_RESTORE, B_EXPORT_BAD, X_SUPPORT_NONE, X_CHURN, X_PAYER |
| `A31#3273` | `9559928265` | App Store (us) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2023-01-29 | 3★ | L_UPD, T_WEEKSTART |
| `A31#4961` | `3323964863` | App Store (us) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2018-10-20 | 1★ | T_REMINDER_TZ |
| `A33#1266` | `7363611676` | App Store (gt) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2021-05-20 | 1★ | E_CANCEL_ACCT |
| `A33#1333` | `8961056662` | App Store (il) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2022-08-09 | 3★ | S_WATCH |
| `A33#1359` | `13088820299` | App Store (in) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2025-09-02 | 1★ | S_DELETE_RESURRECT, S_XDEVICE_MISMATCH, X_PAYER |
| `A33#3361` | `8947227861` | App Store (us) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2022-08-05 | 2★ | L_LOGIN |
| `A36#430` | `10610214785` | App Store (us) | 36. (Not Boring) Habits - Science-backed habit tracker | 2023-11-21 | 4★ | S_WIDGET, S_WIDGET_LOCKED |
| `A41#85` | `12454294235` | App Store (br) | 41. Awesome Habits - Habit Tracker - Streaks, days since & goals | 2025-03-23 | 5★ | POS_EXPORT |
| `A41#379` | `9537862474` | App Store (gb) | 41. Awesome Habits - Habit Tracker - Streaks, days since & goals | 2023-01-23 | 5★ | POS_SYNC |
| `A48#1204` | `11112816965` | App Store (id) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2024-04-02 | 1★ | S_DUP, S_REMINDER_XDEVICE |
| `A48#2139` | `9935997963` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2023-05-17 | 1★ | L_CORRUPT, X_REINSTALL_FEAR, X_NO_CHANNEL |
| `A48#2859` | `3547227581` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2018-12-19 | 4★ | T_TZ, T_STREAK |
| `A48#2931` | `3176625993` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2018-09-11 | 3★ | B_EXPORT_BAD, T_TZ |
| `A52#5891` | `10560216294` | App Store (cn) | 52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus | 2023-11-07 | 1★ | A_STUCK, A_DELETE |
| `A52#13185` | `5734138017` | App Store (cn) | 52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus | 2020-03-30 | 5★ | S_FAIL, X_PHONE_FEAR |
| `A55#1250` | `5436553763` | App Store (us) | 55. Habit-Bull - Daily Goal Planner - Best To Do List Streak Tracker | 2020-01-22 | 1★ | B_RESTORE_FAIL, S_FAIL, L_LOGIN, B_IMPORT |
| `A68#3017` | `12178587829` | App Store (pl) | 68. Ultiself - Self-Improvement - Biohacker Routine Planner App | 2025-01-13 | 1★ | E_CANCEL_ACCT |
| `A85#1053` | `3190782112` | App Store (gb) | 85. Habitica - Gamified Taskmanager - Stay motivated and organized | 2018-09-15 | 1★ | A_LOGIN_FAIL, A_EMAIL |
| `A85#2527` | `4277495042` | App Store (us) | 85. Habitica - Gamified Taskmanager - Stay motivated and organized | 2019-06-07 | 1★ | L_OFFLINE_EDITS, P_ONLINE_ONLY |
| `A86#84` | `8288640052` | App Store (ca) | 86. Today Habit tracker - For to-dos, routines & goals | 2022-01-27 | 5★ | PR_LOCAL_PRAISE, POS_BACKUP |
| `A86#87` | `6920732784` | App Store (ca) | 86. Today Habit tracker - For to-dos, routines & goals | 2021-01-27 | 2★ | L_REINST, L_CORRUPT, B_HIDDEN, B_ICLOUD |
| `A86#760` | `1920258131` | App Store (gb) | 86. Today Habit tracker - For to-dos, routines & goals | 2017-11-14 | 1★ | S_WATCH, S_REVERT |
| `A86#1392` | `1890431264` | App Store (us) | 86. Today Habit tracker - For to-dos, routines & goals | 2017-11-01 | 1★ | B_RESTORE_FAIL, B_ATTACH, B_SLOW |
| `N2#24263` | `12165259360` | App Store (native app) (vn) | 2. Calendar | 2025-01-10 | 1★ | T_CALENDAR_SYSTEM |
| `N3#2509` | `11929289737` | App Store (native app) (ca) | 3. Notes - Take note of almost anything | 2024-11-09 | 2★ | L_OFFLOAD |
| `N3#18618` | `7883838330` | App Store (native app) (ru) | 3. Notes - Take note of almost anything | 2021-10-06 | 1★ | L_OSUPD |
| `N3#21519` | `14072583776` | App Store (native app) (us) | 3. Notes - Take note of almost anything | 2026-05-16 | 1★ | L_ENCRYPT_LOCKOUT |
| `N5#14114` | `11147743987` | App Store (native app) (us) | 5. Apple Fitness - Fitness and Fitness+ | 2024-04-12 | 1★ | S_HEALTH_WRONG |
| `N7#1378` | `1754932182` | App Store (native app) (ca) | 7. Google Keep - Notes and lists | 2017-08-27 | 1★ | S_FAIL, X_NO_CHANNEL |
| `N7#10494` | `8816795247` | App Store (native app) (us) | 7. Google Keep - Notes and lists | 2022-06-27 | 2★ | S_DUP, L_SYNC, B_TRASH_BLANK |
| `N10#13590` | `1592820392` | App Store (native app) (mx) | 10. Microsoft To Do - Capture Tasks & Set Reminders | 2017-04-19 | 1★ | A_LOGIN_FAIL |
| `N10#16728` | `10029231730` | App Store (native app) (sg) | 10. Microsoft To Do - Capture Tasks & Set Reminders | 2023-06-13 | 1★ | L_LOGIN, L_UPD, A_FORCED, A_WRONG_ACCOUNT, X_NOTICE |
| `N10#20114` | `7674060548` | App Store (native app) (us) | 10. Microsoft To Do - Capture Tasks & Set Reminders | 2021-08-09 | 1★ | L_LOGIN, L_UPD, A_FORCED |
| `N11#4206` | `13304807987` | App Store (native app) (nz) | 11. Samsung Health - Health & Fitness | 2025-10-23 | 1★ | L_PHONE, S_INVISIBLE, B_FALSE_SUCCESS |
| `P2#1413` | `fda33ff9-1de8-419e-a275-8491b69d746a` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2026-05-06 | 1★ | E_DEVICE, B_PAID, L_PHONE, X_PAYER |
| `P3#3364` | `8d589751-caab-4e60-8e11-ac46999b8c99` | Play Store (en) | 3. Loop Habit Tracker | 2025-01-11 | 5★ | POS_EXPORT, POS_MIGRATE |
| `P3#4487` | `f859df68-f832-44df-8f99-e37bb0c86a8e` | Play Store (en) | 3. Loop Habit Tracker | 2024-01-02 | 3★ | L_PHONE, B_MANUAL, B_RESTORE_PARTIAL, L_REINST |
| `P3#4628` | `48a87432-532b-4658-95f3-16f693ebe0fc` | Play Store (en) | 3. Loop Habit Tracker | 2023-11-23 | 5★ | P_OS_HIBERNATE |
| `P3#7335` | `636ffbc5-ba45-4de7-9566-53780fb40e77` | Play Store (en) | 3. Loop Habit Tracker | 2021-10-22 | 2★ | L_PARTIAL |
| `P3#9704` | `6fa4d955-938d-483d-8149-8364ad740554` | Play Store (en) | 3. Loop Habit Tracker | 2020-05-19 | 1★ | A_NOACC, L_PHONE |
| `P3#15104` | `91f43947-5cc0-4983-925b-578b64c73383` | Play Store (en) | 3. Loop Habit Tracker | 2017-02-18 | 3★ | B_IMPORT, L_PHONE |
| `P3#21586` | `fe24d60c-c323-411c-93fb-49d368c4f97b` | Play Store (pt) | 3. Loop Habit Tracker | 2019-04-26 | 4★ | L_PHONE, B_MANUAL, S_MULTI_REQ |
| `P4#2666` | `e4356637-ecad-407a-b102-2ff3575cd67e` | Play Store (de) | 4. Me+ Lifestyle Routine | 2024-05-20 | 1★ | E_PLATFORM_GAP, X_PAYER |
| `P4#21633` | `a40b0f37-0f89-453e-8d90-16bef1fb790d` | Play Store (en) | 4. Me+ Lifestyle Routine | 2024-03-18 | 1★ | PR_CONCERN, A_DELETE |
| `P8#1317` | `a87f5a6a-ebf6-4a7b-b0dd-a6d487a92774` | Play Store (en) | 8. Habitica - Gamify Your Tasks | 2025-10-06 | 3★ | S_WIDGET, T_ROLLOVER |
| `P8#5444` | `ed399cf1-1ccb-4999-a0f6-9dfff8040c71` | Play Store (en) | 8. Habitica - Gamify Your Tasks | 2021-10-30 | 2★ | A_LOGIN_FAIL, A_PROVIDER |
| `P8#6812` | `5c9ad7f1-335b-4fb2-aa0a-f4c49e672bb4` | Play Store (en) | 8. Habitica - Gamify Your Tasks | 2019-11-16 | 1★ | P_ONLINE_ONLY, P_SERVER_DOWN |
| `P8#7209` | `211622cf-6d08-42ad-a40c-91a8a2ca9f8e` | Play Store (en) | 8. Habitica - Gamify Your Tasks | 2019-05-08 | 1★ | P_ONLINE_ONLY, X_CHURN |
| `P11#5243` | `0558d6be-aa18-4ece-8792-4f75ecc74967` | Play Store (en) | 11. Dear Me - Daily Routine Tracker | 2025-03-24 | 1★ | T_TZ, T_DATE |
| `P12#16760` | `d1a30e40-5704-4925-82b2-cddbe81c17b6` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2023-10-30 | 3★ | L_EDITHIST |
| `P12#31872` | `8f60b031-b525-4e33-bbea-25d3f95f7ce2` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2021-09-20 | 3★ | B_MANUAL, B_ONBOARD_FIRST |
| `P12#35027` | `f235ad79-6078-459a-aead-aedd076c5b06` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2021-06-30 | 1★ | L_REINST, X_SUPPORT_ADVICE, B_RESTORE_FAIL, X_PAYER |
| `P12#55685` | `0af3617e-7bcd-4d67-819b-d6855fa161bc` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2020-01-26 | 1★ | E_XOS, X_SUPPORT_NONE, X_PAYER |
| `P12#115285` | `1957099d-0f4a-45af-ac2a-b91d0201985d` | Play Store (it) | 12. Fabulous Daily Routine Planner | 2019-05-14 | 1★ | L_REINST, X_SUPPORT_ADVICE, X_PAYER |
| `P24#23359` | `2eaa5d4d-4edf-4a3e-8978-d6e7bc906ac6` | Play Store (pt) | 24. Habit Tracker | 2018-01-20 | 1★ | A_LOGIN_FAIL, A_PROVIDER |
| `P33#2574` | `bb55006c-d93e-490b-b84a-66e9a5d0e806` | Play Store (en) | 33. Productive - Habit tracker | 2019-10-22 | 1★ | L_PHONE |
| `P37#597` | `7caa94eb-dd2f-462c-a03c-baaaab025afb` | Play Store (en) | 37. Habitify - Habit Tracker | 2023-01-22 | 5★ | POS_SYNC, POS_XOS |
| `P65#7648` | `9368b74c-412f-4d68-a861-a796b2fa43ae` | Play Store (en) | 65. Goal & Habit Tracker Calendar | 2018-06-11 | 3★ | B_EXPORT_BAD, B_FALSE_SUCCESS |
| `P84#7259` | `5eb47eab-9992-49b1-950b-808f634ba2e9` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2026-04-23 | 3★ | L_PHONE, B_PAID, B_HIDDEN |
| `P84#7771` | `9c069dc1-6cb7-467b-90a4-d33c34e77b64` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2026-01-06 | 5★ | L_ENCRYPT_LOCKOUT, B_PAID |
| `P84#16756` | `06d01783-3a47-4c6c-913c-246aed77b6bf` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2021-11-28 | 5★ | POS_OFFLINE |
| `P84#17041` | `ce75700f-830d-4dd9-8043-f963e1e81c93` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2021-09-21 | 2★ | L_PHONE, B_PAID, B_RESTORE_FAIL |
| `P84#22354` | `58951e8b-eb52-4ecb-8389-c0f2e1e0d01e` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2020-03-01 | 5★ | POS_UNDO |
| `P91#53` | `260a8ed4-58b9-4b1c-ae59-04868ecefb94` | Play Store (en) | 91. Habit Check Calendar | 2026-05-07 | 5★ | POS_MIGRATE |
| `P91#167` | `c76e7506-fcf9-438b-89b2-dd35a7415e25` | Play Store (en) | 91. Habit Check Calendar | 2025-01-10 | 1★ | L_PAYWALL |
| `P97#2637` | `8c97abf7-349b-459d-b3a1-461f6373b893` | Play Store (en) | 97. To-do list - tasks planner | 2024-12-29 | 1★ | A_FORCED, PR_CONCERN |
| `P98#175` | `0db48b99-b007-480d-887f-cc454eec6a55` | Play Store (en) | 98. Rabit - Habit Tracker & Planner | 2024-10-22 | 3★ | L_CORRUPT, L_CLEAR |
| `P98#1078` | `3c945169-b08c-4824-9396-3e92e41acf26` | Play Store (en) | 98. Rabit - Habit Tracker & Planner | 2021-03-26 | 4★ | T_STREAK, L_EDITHIST |
| `P98#2023` | `2427a3f1-9eea-493a-b512-be20ab2f7611` | Play Store (es) | 98. Rabit - Habit Tracker & Planner | 2022-04-25 | 2★ | L_UPD |
| `P111#1368` | `ce4d0c81-3aba-419a-b061-f309111ea135` | Play Store (en) | 111. My Study Life - School Planner | 2023-10-05 | 1★ | L_LOGIN, A_WRONG_ACCOUNT |
| `P122#2263` | `ad0749f9-656b-450b-809f-a667ca9edc3a` | Play Store (en) | 122. Hevy - Gym Log Workout Tracker | 2026-08-16 | 1★ | A_FORCED, P_ONLINE_ONLY, PR_CONCERN, X_CHURN |
| `P123#774` | `526b8083-ac2c-4cc3-80d7-f0c68be5880f` | Play Store (en) | 123. Rise - Habit List | 2024-11-24 | 1★ | S_WIDGET, X_PAYER |
| `P123#1150` | `9c749724-74b3-4476-b436-ecc8ac19f003` | Play Store (en) | 123. Rise - Habit List | 2023-11-18 | 5★ | B_NONE, L_USER |
| `P125#5272` | `2a373859-2a53-44ed-8ff1-2c01b0f3eac0` | Play Store (en) | 125. 21 Days Challenge | 2023-07-25 | 5★ | L_REINST |
| `P126#9772` | `bef027a4-eea6-4308-a332-d9e105abbfc7` | Play Store (de) | 126. To Do List | 2026-05-09 | 1★ | L_UPD, L_RETENTION, X_NOTICE |
| `P126#27435` | `a03515a8-9821-416b-b831-0db966455af1` | Play Store (en) | 126. To Do List | 2023-12-31 | 3★ | L_OSUPD, B_HIDDEN, X_NOTICE, PR_LOCAL_PRAISE |
| `P126#74850` | `7eb676e8-b9e0-48c9-97f6-947efb340d55` | Play Store (en) | 126. To Do List | 2018-10-07 | 1★ | L_LOGIN, L_SYNC |
| `P126#76460` | `4bcf6198-b115-47d9-a850-7ba37d1348f4` | Play Store (en) | 126. To Do List | 2018-07-16 | 1★ | L_PHONE, L_SYNC |
| `P130#308` | `83945e8a-49bb-4b3b-80cf-0905f4081de6` | Play Store (en) | 130. Way of Life - habit tracker | 2019-03-02 | 3★ | E_XOS, A_NOACC, X_PAYER |
| `P130#354` | `ba7e562f-2799-4357-806e-f8601cb272a9` | Play Store (en) | 130. Way of Life - habit tracker | 2017-05-06 | 3★ | B_XOS_FORMAT, L_XOS |

## Appendix B — Evidence files

In [`Data Safety Evidence/`](<Data Safety Evidence/>):
- `scan.py`: the full-corpus screen;
- `mode-stats.txt`: hits, apps, 1★ share and mean per failure type;
- `sample.py` and `sample-index.json`: how the 960 reviews were drawn;
- `cls/`: the 16 hand-coded batches, one line per review, with codes and a verbatim quote;
- `check_cls.py`: the validator (every key known, no duplicates, every quote verbatim);
- `coded.json`: all 960 coded reviews;
- `precision.json`: the share of each failure type's sample that was on topic;
- `build_appendix.py`: builds Appendix A and checks every citation in this report.
