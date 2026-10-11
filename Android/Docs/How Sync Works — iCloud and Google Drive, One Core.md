# How Sync Works — iCloud and Google Drive, One Core

Written by Claude (Claude Code), 11 October 2026, at the user's request: "explain … how we are going to handle merge
conflicts … how it resolves and comes back to its intended state … is the mechanism the same for iCloud and Google
Drive … the shared core logic … and how it solves the problems other apps' syncing faces."

**Yes, it's the same logic on both.** iCloud (Apple's `CKSyncEngine`, built: [Architecture 11](<../../Architecture/11. iCloud Sync with CloudKit.md>))
and Google Drive (to build: [Google Drive Sync](<Research/Google Drive Sync — Download, Merge, Upload, and the Version Chain.md>))
only carry the changes. How devices merge, settle conflicts and recover is one piece of code in the shared Kotlin core
(`Core/sync/…/SyncRules.kt`, `Hlc.kt`), used by iPhone, iPad, Mac, Watch and Android.

## The idea in one line

Every device keeps all of its habits itself (Rulebook D1); sync only swaps small changes; every device applies the
same fixed rules to every change, so they all end identical, whatever order the changes arrive in and however often.

## The building blocks (shared, identical everywhere)

| Building block | What it means | Problem it removes |
|---|---|---|
| **Every record has a permanent ID, made on the device at the tap** | The same change arriving twice (a retry, the Watch and the phone, a widget) is one record | Logs counted twice |
| **Every log is its own record**, not a number that gets overwritten | Two glasses logged offline on the phone and one on the tablet are three records: the total is 3, never "the last device wins with 1" | Lost logs |
| **Every change has a stamp** (time, counter, device; a hybrid logical clock): a device's next stamp is always later than anything it has made or seen | A change made after seeing another device's change wins over it, even when this device's clock is wrong | Wrong clocks deciding |
| **Field by field, the later stamp wins** | A name changed on the phone and a colour changed on the iPad both stay | Whole-record overwrites |
| **A delete always wins**, and is an archive with undo (D6) | An old device can't bring a deleted habit back; its late logs are kept for the undo | Deleted things returning |
| **Unknown fields are kept** | An older app version can't erase what a newer one added | Old versions wiping data |
| **The outbox:** each change waits on the device until the cloud confirms it (D12) | Offline, closed or restarted: it goes when it can, never lost on the way | Changes silently never sent |
| **Order-free and repeatable** | Any order, any number of times: the same result | Races and retries |
| **Safety rules** (D4, D14, D17) | A fresh install pulls first and sends nothing until set up; large deletes stop and ask; a copy with habits is never replaced by an empty one; dated backups kept apart from sync | Empty phones wiping the cloud; a bug spreading "nothing" |

## A sync round

**iCloud (built):** a change goes into the outbox → Apple's engine sends it → iCloud tells the person's other devices,
which fetch it → each merges what it fetched with the shared rules, in one transaction → if iCloud says "this record
changed since you saw it", the device merges iCloud's version with its own and sends the result. Apple handles
retries and pushes; we handle merging.

**Google Drive (to build):** a change goes into the outbox → on opening, a few seconds after changes, about once a
minute while the app is on screen, and in the background (no relay server, the user's decision): check whether Drive
changed → if so, download and merge with the same rules → upload the merged copy through the **version chain** (each
saved copy reserves the next one's file ID; Drive accepts only the first save under that ID, so the other device
downloads it, merges and saves next).

**The only difference is the carrier:** who moves the data, and how "someone changed it first" is detected (iCloud's
"record changed" answer against Drive's refusal of a second file with the same ID). The merge, the outbox, the safety
rules and the words on screen are the same.

## Examples: how it reaches the intended state

| Situation | Result |
|---|---|
| The phone, offline, logs 2 glasses; the tablet logs 1 | 3, on both, once the phone is online |
| The phone renames a habit; the tablet changes its colour | Both kept |
| Both rename it differently while offline | The later one shows; the other is kept in history with "Use This Instead" (to design, Current Work 89) |
| The tablet deletes a habit; the phone, offline, logs to it | Deleted on both; the log kept for the undo |
| A Mac unused for days opens with an old copy | Its old values have older stamps and lose; anything it changed later itself still counts. "My Mac replaced the work I'd done today" can't happen |
| A Watch tap delivered twice | One log (same ID) |
| A timer stopped on two devices | One entry (its ID comes from the habit and start time); the later stop's minutes win |
| A reinstall or a new phone | Pulls everything first, sends nothing until set up: never wipes the cloud with an empty copy |
| A bug or a mistake deletes hundreds of records | The brake holds the deletes and asks first, Restore one tap away |
| A device's clock is a year wrong | It can't win for ever; the others move past its stamps |

## What other apps do wrong, and how this avoids it (users show: 197 sync complaints read)

- **One whole file, last device wins** (Money Manager EX's users; Streaks in reviews): devices lose each other's work.
  We merge record by record, field by field.
- **"Which copy do you want?"** (KeePass apps on Android, Bluecoins): confusing, one wrong tap loses data. We never ask;
  the fixed rules decide and nothing is thrown away.
- **Duplicates after sync:** IDs made at the tap; joining merges by ID.
- **Lost on a reinstall or new phone:** pull first; never replace with empty.
- **Silent failure:** the outbox keeps every change until confirmed; the status row and the line on Today say the truth.
- **A delete or a bad state spreading everywhere:** the brake; dated backups apart from sync.

## What it can't do

An offline or switched-off device's changes wait until it's online; a device lost before it ever got online loses
only what it hadn't sent; the same field edited on two devices keeps one and puts the other in history; a person
logging the same thing on two devices is asked once (Keep Both / Remove One). Details and the complaints behind each:
[Sync Status Across Devices](<Research/Sync Status Across Devices — When It Shows, Where, and the Complaints Behind It.md>).
