# 58 — Backup & Export screen and account placement: review evidence and existing research

Written by Claude (Claude Code), 9 October 2026. Working notes for the redesign of Backup & Export and the placement
of account sign-in / sign-out. Research only, not a design and not a decision. Scratch file (Research/Temp is
gitignored).

**Evidence labels.** "Users show" = review evidence read by hand. "Reasoned from first principles" = no review covers
it. An app doing something is never treated as evidence that it is right; a review that names another app is used only
for what the reviewer says they want.

**Files behind these notes (all in `Research/Temp/`):**

| File | What it is |
|---|---|
| `58-backup-scan.py` | Screen of 897,899 habit-app reviews (App Store 333,160 + Play 564,739; to-do, gym, planner, native apps left out with the same exclusion list as `Backup Experience Evidence/scan.py`). 11 English patterns. Writes `58-candidates.json` (3,493 matches) |
| `58-confuse-scan.py` | Second pass over the same reviews: two or more of backup / export / sync / restore-import together with a confusion or expectation word; and "where is my data" questions. Writes `58-confuse.json` (111 matches) |
| `58-codes-restore.py`, `58-codes-auto.py`, `58-codes-trust.py`, `58-codes-sync.py`, `58-codes-signout.py`, `58-codes-newphone.py` | Hand codes, one entry per review read. `58-tally.py <codes> <MODE>` checks every match is coded (0 missing, 0 unknown for all six) and prints the counts below |
| `58-export-sample.txt` | 124 export reviews naming a file format, at most 6 per app, read by hand |
| `58-show.py` | Prints matches for a pattern |

Review references look like `P3#15434` (Play app 3, line 15434 of its `reviews.jsonl`) or `A20#524` (App Store app 20);
the review ID follows. Every review ID below was copied from the corpus files; every quote is checked word for word
(`58-verify-quotes.py`).

---

## Part A — What the existing research already decided (constraints on the redesign)

### A1. `Research/Research Reports/Data, Sync and Accounts/Backup, Sync and Accounts — One Seamless Experience.md` (1 Oct 2026)

The most direct predecessor. It is "a design to decide in Notion, not a decision record", built on the user's seven
rules of 1 Oct (§ header).

- **User's rules (header, "final"):** sync only through our server; free works without an account; no account =
  nothing on our server; with an account people choose where the backup lives (our server, iCloud or Google Drive);
  a free user on two devices can copy but not sync; never ask "do you want sync?" after buying Plus; **"No odd
  questions … It should feel automatic and smooth, while people stay in control."**
- **§1 "The short answer":** people don't want to choose, they want backup to just happen (110 reviews ask for
  automatic backup vs 2 asking to choose a place). Backup and sync are two different things "and the app says so".
  Accounts are offered only where they help: "Settings → Backup & Sync, a new device, the Plus purchase".
- **§3 rules 9 and 10:** "Status is always one tap away and honest: Settings → Backup & Sync shows where the last good
  backup is and when." / "The words 'backup' and 'sync' are never mixed. Backup screens never promise other devices;
  sync screens never claim to be a backup."
- **§4.3 "Settings → Backup & Sync (one screen, two clearly separate parts)":** this is the origin of the rows the
  user now dislikes. It sketched `Where: Your account (our server) ›`, `Also: Copy in your iCloud [on]`, and four
  buttons in a row `[Back up now] [Restore…] [Move to another device] [Export a file]`, with a separate SYNC part
  ("Plus: On · iPhone, iPad, Apple Watch [Devices ›]"; free: "Sync is part of Plus…"). The user's complaint (the
  server wording, the iCloud switch, the unchangeable "Sync: On", Restore lost among peers) is aimed squarely at this
  sketch, so these specific rows are not settled.
- **§4.3, still useful:** "Nothing about backup or sync on Today while everything works"; "Plus can still force a sync
  without a button: pull down on Today"; "Settings has [Sync now] and [Back up now] for people who look for them."
  Users show (in that report): 11 of 15 sync-button reviews complain about having to press it.
- **§4.4:** problems are told at once (red status in Settings, a card on Today, one notification); second copies get a
  quieter grey line; words "say what happened and what is still safe … Never 'Error'".
- **§4.5 "Making an account":** offered "in Settings → Backup & Sync ('Sign in to back up to your account')", on
  "I've used this before", on a second device and in the Plus purchase flow. Sign-in sheet wording includes "We store
  your habits on our server only to back them up and sync them. We never sell them or use them for ads. Delete
  everything any time in Settings."
- **§4.8 "Moving without an account":** Move to another device = ask "Is the new device using the same Apple
  Account?"; if yes "Nothing to do"; otherwise [Send my habits] → share sheet. Import rules: the app finds the file
  itself, shows what's inside first, Replace or Merge, undo 30 days, never a false "success".
- **§5 "Words the app uses":** Backup "a copy so you never lose your habits"; Sync "the same habits on all your
  devices"; Your account "lets your devices talk to each other, and keeps your backup on our server"; Your iCloud
  "your own storage; we can't see it". Never "Cloud" on its own ("which cloud?"), never "Free backup" / "premium
  backup".

### A2. `Export and Backup — Keeping Your Own Data.md` (29 Sep 2026)

- **"Answer" 1–5:** the button names "Export a Spreadsheet (CSV)", "Save a Backup File", "Restore from a Backup File"
  come from here, written for the free, local-only app before accounts and iCloud existed. Restore "only adds" what's
  missing and says what happened ("Added 3 habits and 412 logged entries. Nothing already here was changed.").
- "Reasoned from first principles": one complete backup file (the database) plus one readable CSV.

### A3. `Data Safety — Every Way Users Lose Data, and the Rules That Prevent It.md` (26 Sep 2026)

- **Part 1 #7 / B1:** "Backup is automatic and on by default … Settings shows the last backup time … No manual steps
  are needed to be safe"; a "Not backed up" dot on the avatar (the avatar has since become ≡).
- **B2:** restore brings back everything; tested in CI. **B3:** export CSV + complete file, local dates, every export
  can be imported back. **B4:** "I've used this before" on the very first screen.
- **D3–D5:** "Sign-out is always available"; account deletion shows the store subscription and says deleting does not
  cancel it; every sign-in error names the next step. **A7 / Part 1 #6:** signing in merges and never deletes, "show
  which account before merging" (now Rulebook D3).
- **H:** "a plain-language 'where your data lives' page".

### A4. `Sign-in Prompts and the Backup Guarantee — Backlog 4.md` (27 Sep 2026)

- **§4.1:** sign-in only when the person asks for something that needs it, once after buying Plus; "After any 'Not
  now' … Never again. **Settings → Account keeps a plain 'Sign in to sync' row**." (An Account place in Settings was
  assumed.)
- **§2.1:** repeated prompts 1.75★ (72 reviews); backup reminders with no "never" get apps deleted (`A31#459`,
  `A31#725`). **§4.2 point 4:** after the one choice, "Settings shows the honest state ('Backed up only on this
  phone')". **§4.5:** "A backup is never a sync source"; restore merges and can be undone.
- **§2.4:** iCloud is not everyone (full, off, refused, work phones): 16 reviews; iCloud restores that failed 46
  (1.93★).

### A5. `Free Plan Data Protection — Backup Without Giving Away Plus.md` (1 Oct 2026; §4 superseded)

- §1 points 1–2 still stand: backup is rarely why people pay (0.9% of payer reviews vs 4.3% for sync/devices);
  paywalled backup 83 reviews at 2.39★. So nothing on the screen should look like backup is a Plus perk.

### A6. `QR Move, Apple Health and Launch Operations — Final Backlog.md` (28 Sep 2026; accepted)

- **§3.2:** QR move removed; free users move with the phone's own transfer or the export file; Plus users sign in.
  "What we keep from the evidence: clear, short instructions" (users show: `P84#14111`).

### A7. `iPad Sync and Server Trust — Backlog 5.md` §5

- 55 reviews say no to data on the developer's server (2.40★) vs 179 praising no-account/local (4.87★); **0** reviews
  are both "no server" and "I want sync". **§5.4:** "what they reject is being *forced*, and data being *sold*. No
  review objects to an **optional** sign-in that syncs their own data."

### A8. `Research/Research Reports/Settings and Help/Settings — What People Need There.md` (29 Sep 2026)

- Written before accounts: "Privacy: 'Your habits stay on this iPhone. No account, no ads and no tracking.'"; "A sheet,
  applied at once: the avatar opens an account-and-settings sheet across iOS". "Export and backup (next loop)". Says
  nothing about where sign-in goes beyond that.

### A9. Navigation and screen decisions (not in the Data folder, but binding)

- `iOS/Design Rules — Don't Regress.md`, "≡ Menu — FINAL (the user, 30 Sep 2026)": **"Decided and final. Don't reopen
  it."** Menu order: Today · Progress · Habits · Tasks | Times of Day · Day and Week · Reminders · Appearance |
  **Backup & Export · Privacy & Security** | **Plus** | Help & Feedback · About. **There is no Account row today.**
  Adding one changes this decided list, which needs the user's say-so.
- `Research/Research Reports/Home Screen and Visual Design/Navigation Pattern/Navigation, Round 3 — The Menu, Filter
  and Two Ways In.md` (research, 30 Sep): proposed "Your data → Backup & Export: Status ('Saved on this phone · today
  09:14'), Snapshots, Export a copy, Import, Move to a new phone"; "Privacy: … (and Delete account / Turn off sync for
  Plus)"; "Plus: Get Plus or Plus status, **Restore Purchases**, Plus Family, **Account (Plus only)**". It also notes
  "the native choice … the way the avatar opens the account page in Apple's App Store and Health apps" (a platform
  observation, not review evidence).
- Design Rules, "Sidebar data, tasks and reminders": "Backup/export/restore are available to free users … explain free
  external backup and Offload clearly. Never promise local-only uninstall retention."
- Rulebook D4: "Backup is automatic, on by default, free and visible ('Backed up 2 min ago'), and counts only when the
  copy is read back and checked." D3, D9, D10 also apply. U3/U11: plain words.

---

## Part B — What users show (this study)

Counting rule: "N of D" = N reviews coded with that theme out of D reviews read in full for that pattern. A review can
carry more than one code. All counts are floors from English keyword screens; reviews that say the same thing in other
words were missed. Mean ★ is over the coded reviews.

### B1. "Restore" is read as Restore Purchases more often than as restoring data

Pattern `FIND_RESTORE` (can't / how / where + restore / import / recover; restore button hidden). **153 read, every
match.**

| Code | Reviews | Apps | Mean ★ |
|---|---|---|---|
| **Restore a *purchase* (subscription, lifetime) failed or couldn't be found** | **58** | 21 | 1.72 |
| Tried to restore or import *data* and it failed | 34 | 11 | 2.62 |
| No backup existed, so nothing could be restored | 23 | 11 | 1.57 |
| Asks how to restore / import data | 4 | 4 | 4.75 |
| Couldn't find / see / pick the backup file | 4 | 3 | 3.75 |
| Export exists but no import | 4 | 4 | 2.25 |
| Off topic | 30 | 20 | 3.07 |

- **Users show the word "restore" means "get my purchase back" to many people:** 58 of the 123 on-topic reviews.
  - "I’m struggling to understand how I restore a purchase in case of changing phones" (Habit Tracker, 2★, `12124781595`)
  - "I cannot find a restore my purchase offer, rather frustrating." (Productive, 1★, `3600465748`)
  - "When I tapped restore purchase it just shows me ads for the subscription." (Do Habits, 1★, `7409688659`)
  - A data restore blocked by a purchase that didn't follow: "I cannot restore my data from the cloud backup, as the
    app prompts me to pay for Premium again." (HabitNow, 1★, `fda33ff9-1de8-419e-a275-8491b69d746a`)
- **Finding the data restore is mostly a file problem, not a button problem** (few reviews, but consistent):
  - "Cannot import backup. There is no file chooser." (Loop, 3★, `6f46543a-3e6c-4b5c-a277-bfef7c355b9c`)
  - "when I saved the files and switched to new phone I was unable to restore everything now even if I have a file I
    can't see" (Goal & Habit Tracker, 4★, `ba94a066-58da-49bb-b425-33f46dd13fb3`)
  - "How can I restore a backup from my old IPhone to the new one?" (Way of Life, 5★, `8255181175`)
  - "Hi, how can I import my file?" (Pixel Habit Tracker, 5★, `a1790a0f-7adc-499a-be7d-6bcfd3606ae2`)
  - Status unclear at the moment of restore: "I got a new phone and was unable to restore a backup, where does my data
    even backup to? iCloud? Doesn’t really say within the app" (Habit — Daily Tracker, 2★, `5963669614`)
- **Strength:** strong that "Restore" alone is ambiguous next to purchase language (58 reviews, 21 apps); weak that
  people can't *find* a data-restore button (4 + 4 reviews). No review complains that Restore was buried in a list;
  the complaint they make is that it failed or the file couldn't be found.
- **Reasoned from first principles:** label the data action with its object ("Restore habits from a backup", or the
  backup's name and date) and keep Restore Purchases in Plus, as Navigation Round 3 already put it.

### B2. Backup, export, sync and import are confused with one another

Pattern `MIXED_CONF` + `WHERE_DATA` (second pass): **111 read**; on-topic codes below (others were about Apple Health
"sync", restores of purchases, or unrelated "instead of").

| Code | Reviews | What they say |
|---|---|---|
| **Wanted sync, got a backup file / backup used as sync** | 17 | "Cloud backup isn't really a substitue for this" |
| **Thought they were backed up (or synced), and weren't** | 11 | "I thought it was being backed up on my iCloud apparently not." |
| **Don't know where the backup or export file went** | 6 | "where does the backup file go in the drive" |
| **Export without import / export mistaken for backup** | 4 | "there is an “Export” data button, but no “Import”" |
| Praise for export + import as "control" | 6 | "provides a sense of full control" |

Plus, from other patterns: 7 more "backup used as sync" in `AUTO_BACKUP_STATUS`, 1 export/backup confusion there.

- Users show export and backup blur together:
  - "Why do we not have an option to manually initiate one of those internal backups?" — after finding only "export
    a backup" (Streaks, 2★, `8553855848`)
  - "The only backup option is a manual data export, which is inconvenient." (Productive, 2★, `13103091241`)
  - "It’s confusing why the app would have an export, but no import." (Productive, 5★, `5038938558`)
  - "What's the point of adding the export data feature if I can't recover it when there's an issue?" (Disciplined,
    2★, `dc81051d-739b-4ce3-b0d0-603d7397949b`)
- Users show backup and sync blur together:
  - "I thought it synced with Google Drive." (Way of Life, 3★, `987c1ac7-2ad7-47ae-8844-ecf02819bedf`)
  - "Cloud backup isn't really a substitue for this" (HabitNow, 4★, `f64faf60-3016-4433-9fe4-98b8df724235`)
  - "I have on-line back up turned on, but that doesn’t appear to make a difference." (Routinery, 2★, `8531146799`)
  - "My hope was that the import / export functionality in PRO would keep 2 or more devices in sync using a
    cloud-backup like Google Drive." (HabitKit, 3★, `2330795e-fd1b-483a-8350-7477a3400b6b`)
  - Lost everything by assuming a sync existed: "thought this app supports iCloud sync and re-installed app to fix app
    icon issue.. lost all data as this app needs backup file" (Habit Tracker, 3★, `10781087412`)
- Users show "account" and "backup" blur: "what’s the point in creating an account with my email if everything’s stored
  locally? This is very misleading." (Finch, 2★, `9343658775`). And data vs account deletion: "How can I delete my
  account? All I see is an option for deleting data" (HabitBull, 2★, `3c8af349-1d61-4a9e-96b9-258d28a6d580`).
- **Strength:** medium. 30-plus reviews across 15+ apps show the confusion directly; the earlier study counted 12 + 23
  "backup used as sync" (A1 §2, A4 §2). No review asks for *more* explanation text; they ask for the thing to work, or
  for it to be automatic.
- **Reasoned from first principles:** the user's own test ("five actions people can't tell apart") matches what
  reviewers show; each action needs a name that says its result (a file to keep, a spreadsheet to open, the same
  habits on another device) rather than a paragraph.

### B3. Trust: where the data lives, servers and iCloud

Pattern `TRUST_SERVER`: **71 read, every match.** Plus `ICLOUD_BACKUP`: 87 read.

| Code | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Want data kept in a cloud / on an account (mostly after a loss) | 17 | 9 | 3.41 |
| Server outages / online-only (Habitica 13 of 17) | 17 | 6 | 2.18 |
| **Praise data kept on the phone / not on a server** | 11 | 4 | **4.91** |
| **Object to data on the developer's server, or to forced sync** | 6 | 5 | 2.00 |
| Didn't know their data was only local | 4 | 3 | 1.75 |

- Users show the objection is to *not being asked* or *not being able to turn it off*, not to an optional copy:
  - "the app immediately syncs your data to the company's servers, which I did not want." … "you have no option not to
    sync if you're logged on" (HabitBull, 1★, `d3d02976-bfc5-4604-9835-1fb4f1af77d7`)
  - "This app requires you to create an account and save your data on their server(s)." (Habitify, 1★, `3837963170`)
  - "you cant decide which data to upload." (Habitica, 4★, `0187399b-fe63-4f94-8ea6-066730f4e6df`)
  - "I'd much rather my data was stored locally where only I have access to it." (Habitica, 3★,
    `295905fb-c384-4eab-b424-0e33c8067f9a`)
- Users show local storage is praised as privacy:
  - "The data stays on your phone rather than a server and I hope they maintain that for sake of privacy." (Finch, 5★,
    `8664860268`)
  - "It's local-only, so it doesn't have syncing or real-time backup, but it's also not another account to sign in
    to." (Loop, 5★, `939227c2-db86-46eb-866d-6d7ce900145b`)
- **iCloud is read as private, a server is not:** two reviewers distinguish them unprompted:
  - "Privacy focused too, so no servers with your data on - it’s all safely stored on device/iCloud backups only"
    (Habit Tracker, 5★, `6791860731`)
  - "Only if you enable iCloud Backup where a copy of you data will be stored in Apple Servers which do have descent
    privacy policy" (Today Habit Tracker, 5★, `8288640052`)
- Users don't know where their data is: "I didn't realize my data was only stored locally" (Way of Life, 4★,
  `1450861749`); "where does my data even backup to? iCloud?" (`5963669614`, above).
- iCloud isn't free space for everyone: "I’m not paying extra for iCloud storage. I maxed that out years ago."
  (Habit — Daily Tracker, 1★, `12433150633`).
- iCloud reminders are resented: "there’s an annoying reminder to backup to iCloud that you can’t turn off." (Do
  Habits, 3★, `6288116547`).
- **Strength:** medium for "a server is something people must choose and can turn off" (6 objections + the 55 in
  Backlog 5 §5; 0 objections to optional sign-in there). Weak-to-medium for "iCloud reads as private" (2 explicit
  reviews). **No review in this screen reacts to a label like "our server"**; the user's worry that the wording itself
  would alarm people is reasoned, not shown. Backlog 5 §5.4: what people reject is being forced and data being sold.

### B4. Automatic backup, and seeing that it happened

Pattern `AUTO_BACKUP_STATUS`: **125 read, every match.**

| Code | Reviews | Apps | Mean ★ |
|---|---|---|---|
| **Want automatic backup** | **99** | 21 | 4.05 |
| …of which lost data first | 25 | 12 | 3.24 |
| **Backups silently didn't happen / last backup was old** | 6 + 4 stale | 3–4 | 2.17 / 2.75 |
| Couldn't find the backup option | 3 | 3 | 4.00 |
| Praise automatic backup | 4 | 4 | 5.00 |
| Frequency too low | 4 | 3 | 3.50 |

Loop Habit Tracker (Play, manual backup only) supplies 54 of the 99 "want automatic" reviews; the rest span 20 apps.
The earlier study found the same skew (A1 §2).

- Users show automatic is the job, and a *visible* last-backup time matters because silent failures are the worst case:
  - "I discovered none of my backups had actually occurred and over two years of habit tracking data had been lost."
    (HabitNow, 2★, `612d885e-cb1c-4553-ac0b-fca77eaf2090`)
  - "It has been 20 (!) days since it was last backed up." (HabitBull, 1★, `9cd2e6db-9e01-43a7-a21f-8961a8aaf765`)
  - "the last backup was from months of not years ago. Shouldn’t the app be auto backing up every day?" (Habit — Daily
    Tracker, 3★, `12440071394`)
  - "Had I known that I was supposed to be syncing my app info manually all this time, I would have no issues"
    (Fabulous, 3★, `6807744815`)
- Users show manual options get missed:
  - "you can set a reminder to do it manually but looking through some reviews you can see a lot of people didn’t know
    that was an option" (Finch, 5★, `13159004777`)
  - "how can I set up a daily automatic backup export? I've seen it in the app description, but I couldn't find that
    option." (Loop, 5★, `f7ff777e-915b-4fd3-9b09-d545618b2f6d`)
  - "I also can't see how to back up manually." (RoutineFlow, 1★, `f6bab211-e840-4080-8e2a-740ea4d04e82`)
- Praise when it just works: "they don't have auto backup like this app and this makes love it even more" (Me+, 5★,
  `b023f571-a541-42b3-a7ed-ab427e72aa7f`).
- **Strength:** strong for automatic backup (99 here, 110 in A1, 225 in A4, 21+ apps). Medium for "show when it last
  happened" (10 silent-failure / stale reviews here, 24 in Data Safety B1, Rulebook D4). Weak for a manual "Back up
  now" button: one reviewer asks for it (`8553855848`); A1 §4.3 keeps it "for people who look for them".

### B5. Moving to a new phone

Pattern `NEW_PHONE` (962 matches), narrowed to those that also mention data and a how / where / ease word: **144 read,
every one of those.**

| Code | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Lost data on the new phone (no way existed, or they didn't know) | 41 | 15 | 3.00 |
| Tried to move and it failed | 19 | 13 | 2.53 |
| **The purchase didn't follow** | 17 | 9 | 2.18 |
| **Asks how to move, before or after** | 15 | 10 | 4.40 |
| **Couldn't find where to sign in on the new phone** | 11 | 7 | 2.09 |
| Didn't know a backup option existed / couldn't find it | 9 | 6 | 3.56 |
| **Moved and it worked** | 9 | 5 | **5.00** |

- Users show the question comes *before* the move, from happy users:
  - "I recently got a new phone and I don't know how to transfer my tasks to this phone, without having to start all
    over." (Me+, 5★, `5f4172cb-5d4a-474b-ad72-099447067f88`)
  - "how to backup in future?if I buy a new phone" (Productive, 4★, `82bc9038-198e-4274-866a-4ebc035222ac`)
- Users show success comes from clear instructions, and is praised:
  - "Got a new phone, followed the instructions and Bam all my data is till here!" (Loop, 5★,
    `bac98001-21fb-47d4-bea1-d7f80ca1d688`)
  - "I also recently changed devices and everything transferred perfectly." (Habit Check Calendar, 5★,
    `260a8ed4-58b9-4b1c-ae59-04868ecefb94`)
  - "they got back to me quickly instructing me how to use the backup feature" (HabitNow, 5★,
    `c700424d-001a-4ae4-82be-ce9773f55220`)
- Users show the sign-in place is hunted for on a new phone:
  - "I got a new phone and I can't find where to sign in so I can have my premium and see all my habits I logged."
    (HabitNow, 5★, `f4db08af-2d86-4cfc-b23e-1f4f52ea0268`)
  - "there is no profile icon on the homepage" (Fabulous, 1★, `8212273805`)
  - "when installing the app on a new device it would be great if it gave you the option of restoring a backup file
    rather than being forced to go through the initial wizard again" (Fabulous, 5★,
    `5b330392-d720-4b07-98ad-87ec4f58784b`)
- **Strength:** strong that moving is a top job and that failures are severe (Data Safety Part 1 #3: "100% of the
  phone-change sample was a real loss"). Medium that people want instructions for it in advance (15 how-to + 9
  unaware). The purchase-not-following rows point to Restore Purchases in Plus, not to this screen.

### B6. Export and its formats

Pattern `EXPORT`: 1,165 matches; **868** use the word "export". Format mentions among those 868 (keyword counts, not
hand-coded): **CSV 189 reviews / 34 apps; Excel / spreadsheet / Google Sheets 94 / 26; PDF 25 / 17; JSON 9 / 9; SQLite
4 / 3.** Loop supplies 303 of the 868. A capped sample of **124** format-naming reviews (≤6 per app) was read.

What the 124 show (hand-read):
- **Purpose is analysis in a spreadsheet** (about 24 of 124): "Exports to excel so you can create charts and see
  progress or correlations." (Habit Tracker, 5★, `8660793578`); "It would be great to export to a cvs or xls instead of
  a text doc." (Habit Tracker, 5★, `10191151944`).
- **Purpose is keeping or moving their data, no lock-in** (about 18): "Lets me export my data as .csv, no lock-in!"
  (Habit Tracker, 5★, `12205288948`); "Out of nowhere, the developer decided to disable CSV exports. Thus, now years of
  data are stuck in this app" (Super Habit, 1★, `13731751322`).
- **A readable report (PDF), for themselves or a professional** (about 14): "for deeper analysis or sharing with
  professionals like therapists or coaches" (Atoms, 5★, `11715418924`); one asks for a PDF "good to read over and
  review" (Way of Life, 5★, `5064555393`).
- **Export broken** (about 10): "Whenever I try to export a CSV file, which I’ve been trying to do for weeks, the app
  freezes." (Do Habits, 1★, `9600503059`).
- **Export + import praised as control:** "I also love the option to export and import files, as it provides a sense
  of full control" (HabitKit, 5★, `12174698408`).
- **Don't know where the file went:** "i just want to know where the export data goes?" (Habit Tracker, 5★,
  `1ff9d841-500d-454d-9a2e-3f60a5fb3d86`); "Please tell me where does the backup file go in the drive when we do a
  backup." (HabitNow, 4★, `b661b70a-ed6a-4730-8145-880bcfc3061f`).
- **Strength:** strong that a CSV / spreadsheet export is wanted and valued (Export report: 1,002 reviews / 82 apps,
  4.41★). The spreadsheet is a *different job* from backup in reviewers' words (analysis, lock-in), which supports
  keeping it as its own clearly named action. PDF is a minority request.

### B7. Sync switches and buttons

Pattern `SYNC_TOGGLE`: **105 read, every match.**

| Code | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Want sync (feature request) | 47 | 16 | 3.89 |
| Sync broken | 24 | 7 | 2.67 |
| **Hate pressing a sync button every time** | 10 | 3 | 3.20 |
| **Can't tell when / whether it syncs, or where the control is** | 6 | 3 | 2.67 |
| **Toggled sync off and on to fix it** | 4 | 3 | 2.75 |
| Want a way to force a sync when it lags | 3 | 3 | 3.33 |
| Turning sync on wiped data | 1 | 1 | 2.00 |
| Want to turn sync off | 1 | 1 | 2.00 |

- "Is there a sync button that i am not seeing? When does it sync by itself?" (Habit Tracker, 3★, `8228130430`)
- "I have to kill the app to force a sync. Not ideal. A pull to refresh or a button is needed." (Streaks, 3★,
  `8438191895`)
- "tried turning sync on and off on each device." (Strides, 4★, `9927115798`)
- "I can only get it to sync by using the drop down menu in the app." (HabitBull, 4★,
  `d15d8b89-989d-401c-9016-6ff855fa37cb`)
- Sync behind a paywall without saying so: "DOESN'T MENTION THIS ANYWHERE IN APP WHEN YOU PRESS SYNC." (HabitBull, 1★,
  `b756ce42-47ac-404a-8a43-bcb46f3e7805`)
- A switch that destroyed data: review titled "Turning on Sync deletes your data" (Routinery, 2★, `8120137325`).
- **Strength:** weak-to-medium. No review asks for a sync *switch*; they ask for sync to be automatic, to say when it
  happened, and occasionally for a way to nudge it. A "Sync: On" row that can't be changed is not addressed by any
  review directly; the closest evidence is the HabitBull reviewer who wanted to be able to say no
  (`d3d02976-bfc5-4604-9835-1fb4f1af77d7`, B3) and the "when does it sync?" questions.

### B8. Where people look for sign-in, sign-out and account deletion

Patterns `SIGN_OUT` (**86 read, every match**), `DELETE_ACCOUNT` (445; 63 "can't find / can't delete" matches read),
and every account review naming a place in the app (104 read).

| Code (`SIGN_OUT`, 86) | Reviews | Apps | Mean ★ |
|---|---|---|---|
| **No sign-out, or couldn't find it** | **28** | 15 | 2.18 |
| Log out / in as a fix for bugs | 15 | 11 | 2.73 |
| **Signing out lost data or premium** | 10 | 8 | 2.30 |
| Sign-out broken (crash, nothing happens) | 9 | 3 | 1.44 |
| Wrong account / two accounts, need to switch | 7 | 6 | 3.57 |
| Thought signing out would cancel the subscription | 6 | 3 | 1.00 |
| Random logouts | 5 | 4 | 2.60 |

- **Where they looked (account reviews that name a place, hand-read):** *Settings* is named most often (about 13:
  "delete through the settings", "account settings", "in their settings", "Sign Out button (in preferences)");
  *profile* next (about 9: "profile page", "in my profile", "log out from my profile"); an "Account" section (1);
  the home or first screen on a new phone (about 4). Fabulous accounts for many of the deletion complaints.
  - "don’t see a way to get in contact with the developer or delete through the settings" (Habit Tracker, 2★,
    `14279113511`)
  - "Where is Log In or Register option? Cant find anywhere." (Habit Tracker, 1★, `6586401791`)
  - "I cannot find my account settings ANYWHERE! I should be able to view my account info! Did I buy a lifetime or
    yearly subscription?" (Me+, 2★, `11495117139`) — the account place is also where they expect their plan.
  - "there’s no profile page. It doesn’t show my name or information and doesn’t allow me to edit it. How do I even
    log in and out?" (Me+, 3★, `10312885270`)
  - "section so how do I sign up my account" — the reviewer found no "Account" section (HabitNow, 5★,
    `f88b4213-0c5e-4b01-a550-830fb2848141`)
  - "when I click the Sign Out button (in preferences)" (Habitify, 3★, `9183367135`)
  - "The function “delete my account” in my profile is not working." (Habitify, 1★, `6434454672`)
  - "can't delete my account anywhere in settings" (Fabulous, 1★, `5c109901-1786-4b49-b6f8-9a34989152ff`)
  - "There isn't an account setting in the app?" (Fabulous, 1★, `245ac0fa-8543-4e7a-9844-b64cf04ba45b`)
  - A to-do app reviewer found the sign-out control named "exit profile" and called it confusing
    (`74746bb8-93ba-4f75-896d-e8872629c7ff`): name it what it does.
- **Signing out must not cost data** (Rulebook D3; Data Safety A7):
  - "don't ever "logout" of the Free Version as it wipes the slate clean" (Atoms, 3★, `12195412874`)
  - "Then sign decided the sign out and sign in again and I lost all my habits." (Habitify, 5★, `5259328224`)
  - A backup flow that sent the user through sign-out: "it told me to sign out and then back in." then they could
    not sign back in (Finch, 5★, `9900048977`)
- **Switching accounts:** "you can’t log out of an account if you’d want to switch users." (Finch, 4★,
  `14023262213`); "Impossible to log out of. To switch accounts, you have to uninstall & reinstall." (HabitBull, 1★,
  `2971dca3-9144-482d-89bb-cfa40ffc48b2`).
- **Account vs subscription:** "There are no options to cancel the subscription in the email or even sign out on the
  app" (Fabulous, 1★, `8813316830`); Data Safety D5 already requires deletion to show the store subscription.
- **Strength:** strong that sign-out and delete-account must exist and be findable (28 + 63 reviews; Data Safety D5:
  85% 1★). Medium that people look for them under **Settings** or a **profile / account** place (about 22 named
  locations). **No review in this screen looks for sign-in inside a backup screen**, and none complains about finding
  it there; the only backup-related account evidence is the new-phone moment (B5) and the "account but stored locally"
  confusion (B2).

---

## Part C — Users' top jobs on a backup screen, in order

Order = how often and how severely users show the need, adjusted for whether the job happens *on this screen*.

| # | Job | What users show | Strength | Implication (labelled) |
|---|---|---|---|---|
| 1 | **Know my habits are safe, without doing anything** | 99 want automatic (here), 110 (A1), 225 (A4); silent failures and stale backups are the bitterest (10 here, 1.6–2.8★) | **Strong** | Users show: one status line with a real time ("Backed up · last night 03:12") is the screen's first answer (A1 rule 9, Rulebook D4) |
| 2 | **Get my habits onto a new phone** | 144 read: 41 lost, 19 failed, 15 ask how, 11 couldn't find sign-in, 9 praise a working move | **Strong** | Users show: one clearly named way, with short instructions that say what to do on the new phone (QR Move §3.2). Reasoned: the new-phone answer differs by case (same Apple Account / account / file), so the screen can show the person's case only |
| 3 | **Get my habits back after a loss (restore)** | 34 failed data restores, 23 had nothing to restore; few say the button was hard to find, more say the *file* was | **Strong** (severity), **weak** (findability) | Users show: name it by its object, not "Restore…" (58 of 123 read "restore" as a purchase). Reasoned: it is rare, so it need not be first, but it must not sit among look-alike buttons |
| 4 | **Know where my data lives, and that it isn't somewhere I didn't choose** | 6 object to server storage they couldn't refuse; 11 praise local; 4 didn't know data was local-only; 2 call iCloud private | **Medium** | Users show: say where in words people trust ("your iCloud", "this iPhone"); a server copy must be something they chose and can turn off (Backlog 5 §5.4). No review reacts to the label "our server" itself (reasoned) |
| 5 | **Take my data out: a spreadsheet** | CSV 189 / Excel 94 reviews (keyword); purpose is analysis or no lock-in; PDF a minority | **Strong** (wanted), separate job | Users show: a different job from backup; name it by its result ("a spreadsheet") |
| 6 | **Keep my own complete copy (a backup file)** | Export+import praised as control; "export without import" and "where did the file go" confuse | **Medium** | Users show: if it stays, it must say where the file goes and that it can be brought back |
| 7 | **Make the same habits appear on my other devices (sync)** | Want sync 47; broken 24; manual-button burden 10; "when does it sync?" 6 | **Strong** demand, **weak** for any switch | Users show: automatic, and say when it last happened; no review asks for an on/off sync switch, one wants to be able to refuse (`d3d02976…`) |
| 8 | **Back up right now** | 1 explicit request (`8553855848`); A1 §4.3 keeps it for "people who look" | **Weak** | Reasoned: secondary |

**Where users expect account controls (sign in, sign out, delete):** users show *Settings* or a *profile / account*
place, and on a new phone the first screen or a visible profile entry (B8). They also expect that place to show their
plan ("Did I buy a lifetime or yearly subscription?", `11495117139`). Nothing shows they look inside Backup. The
existing reports place sign-in in Backup only as one of several entry points (A1 §4.5) and assumed a "Settings →
Account" row (A4 §4.1) or "Account (Plus only)" under Plus (Navigation Round 3); the ≡ menu list is FINAL and has no
Account row, so adding one needs the user's say-so.

---

## Part D — Limits

- English keyword screens on habit apps only; non-English reviews are under-counted. Counts are floors.
- Some codes are dominated by one app: Loop (Play, local-only) for automatic backup and sync wishes; Fabulous for
  account deletion and "restore" of purchases; HabitBull for manual sync. Disclosed per section.
- The `NEW_PHONE` read set is a filtered subset (144 of 962); the 818 not read are mostly "new phone" in passing.
  `DELETE_ACCOUNT` read only the 63 can't-find / can't-delete matches and the location-naming ones.
- Export format counts are keyword counts over 868 reviews; the 124 hand-read are a capped sample.
- No review tests a screen like ours; the ordering in Part C combines frequency and severity by judgement.
