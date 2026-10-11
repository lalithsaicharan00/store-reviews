# Sync Status Across Devices — When It Shows, Where, and the Complaints Behind It

Written by Claude (Claude Code), 11 October 2026, from the user's questions: how does the other device know "Pixel 8
last synced at 9:14"? when to show it? where (Today, widgets, the Watch)? and "gather all these complaints".
Applies to iCloud (iPhone, iPad, Mac, Watch) and Google Drive (Android) alike. Draft for the user's decisions.

## 1. How the other device knows (reasoned from first principles)

The other device can never know what an offline phone logged. It can only know **when that phone last checked in**.

- **Each device keeps one tiny record of itself in the shared store** (a CloudKit record in the person's iCloud; a
  small file per device in the Drive app folder): its name ("Pixel 8"), **last checked in** (its last successful
  sync, including quiet background checks with nothing to send) and **last change sent** (time of its newest change).
- **"Quiet while in use"** = all of:
  1. this device is online and has just synced itself (otherwise its own status is the story);
  2. the other device sent a change in the last 7 days (it's in use, not a drawer iPad);
  3. its silence is unusual for it: longer than 3× its own usual gap between check-ins (learned from the last week)
     and at least 2 hours. Adaptive, because iPhones check in less predictably in the background than Android phones;
  4. it was logging that day: it sent a change in the 24 hours before it went quiet.
- **Free plan:** one device syncs at a time, so this only arises with Plus (several devices) — and the Watch.

## 2. Where it shows — every surface (respecting decided rules)

Decided already (Design Rules, iCloud page, 10 Oct 2026): the iCloud & Backup page's status row says "Waiting for a
connection · 3 changes not sent yet · Your habits are on this iPhone" with **Sync Now**; Devices lists each device
with when it last synced (Plus); **Today shows a card only when iCloud needs the person, nothing about sync otherwise,
never a spinner.** The proposals below keep that rule; anything that would change it is marked **(your call)**.

| Surface | The device with changes waiting | The other device (a device has gone quiet) |
|---|---|---|
| **iCloud & Backup page** (Android: Sync & Backup) | Status row as decided: "Waiting for a connection · 3 changes not sent yet" + Sync Now | Devices: "Pixel 8 · last synced 9:14 AM". Always there, no banner |
| **Today** | Nothing (it fixes itself). **(your call)** after 24 h still waiting, the existing Today card appears, because then it needs the person (connect) | Nothing by the decided rule. **(your call)** one dismissible line, only when §1's four conditions hold |
| **Day details** (where people go when a log looks missing) | — | Today's Day details only, one footnote while a device is quiet: "Pixel 8 last synced at 9:14 AM. Anything logged there since will show up here once it's back online." |
| **A log's view** (U19) | — | "Logged on Pixel 8" — so a log that arrived late, or twice, is recognisable |
| **Home Screen / Lock Screen widgets** | No message (too small; they show this device's data, which is correct here). Widget taps count in the waiting number | No message. **Must refresh the moment synced changes arrive** (complaints: widget stale after sync) |
| **Live Activity, notifications** | Nothing. Never a notification about sync | Nothing |
| **Apple Watch** (Wear OS later, same) | On the Watch's own sync status only: "2 not sent to iPhone yet", and Sync Now there (people ask for it) | On iPhone: "Apple Watch · last synced 9:14" in Devices |
| **When it catches up** | Status row goes back to "Synced" | No toast (Today stays calm, U4); the logs appear; the footnote/line disappears by itself |

**Words** (U3, U11): name the device, never the person; never "error", "failed", "missed", "not saved" — the changes
are saved, on that device; always say what happens next ("will show up here once it's back online").

## 3. The complaints this has to prevent (users show)

Five searches over both stores (a sync/device word and a problem word in the same sentence: duplicate 62, missing
294, slow 164, overwrite 76, "can't tell" 56 matches); a seeded random 40 of each read by hand, 197 different
reviews (`Android Plus Evidence/coded_synccomp.py`, `synccomp_tally.md`). Each review counted once.

| Complaint | Reviews (Play / App Store) | What prevents it here |
|---|---|---|
| **Data lost** (new phone, reinstall, "backed up to iCloud" but gone) | 33 (13 / 20) | D1–D5, D14 already; merge never deletes another device's work |
| Sync between devices wanted | 21 (14 / 7) | Plus sync |
| **Slow** ("takes hours to sync up") | 18 (6 / 12) | Sync on open, after changes, on leaving; status visible |
| **Watch and phone out of step** | 15 (0 / 15) | Watch design (Architecture 12); waiting count + Sync Now on the Watch |
| **An old device replaced newer work** ("my Mac … replaced all the work I'd done today", `A23#4576`; "it never sync first", `A23#2046`) | 12 (2 / 10) | **Merge, never replace**; download before upload; the version chain on Drive |
| Wants a Sync Now button | 10 (3 / 7) | Sync Now on the status row (decided) and on the Watch |
| Pressed sync, nothing happened | 8 (7 / 1) | Sync Now must show its result ("Synced just now" / why not) |
| Has to sync by hand every time | 8 (7 / 1) | Automatic; Sync Now is only extra |
| A change not showing on the other device | 7 (1 / 6) | §1–2: "Pixel 8 last synced…" |
| **Logs recorded twice** after sync (e.g. Watch water logged twice, `A53#1105`) | 5 (1 / 4) | Each tap's ID made at the tap (already: "the same tap saved twice counts once"); a timer stopped on two devices is one entry (Architecture 12) |
| Can't tell if / where it synced, or it says synced when it isn't | 5 (2 / 3) | The status row in words; "Synced" only after a real exchange |
| **Widget stale after sync** | 4 (0 / 4) | Widgets reload when synced changes arrive |
| **Whole habits duplicated** across devices | 3 (0 / 3) | Joining a second device merges by habit ID; two devices that each made "Water" before joining → **open: offer to combine** |
| **Person logged it twice** because sync was late | 2 (1 / 1) | The quiet-device footnote; "Logged on Pixel 8"; Undo in Day details |
| Surprised a delete spread to the other device | 1 (0 / 1) | Deleting is archiving with undo (D6); the brake on large deletes (D17) |

Counts are small (sync complaints are a small share of all reviews) but they are buyers' complaints about the thing
Plus sells. The reviews read: `Android Plus Evidence/read/synccomp-*.txt`.

## 3b. Will it still get complaints? (the user: "the same on iPhone and Android … which can we solve, which are
technically impossible")

Same design on both: the same merge rules (shared Core), the same device records, the same status words and places;
only the carrier differs (iCloud / Google Drive).

**Solvable with the plan (if built and tested well):** data lost on a new phone or reinstall; an old device
overwriting newer work; the same tap counted twice; widgets stale after a sync; "says synced but isn't"; Sync Now that
does nothing; having to sync by hand; habits duplicated when a second device joins (needs the "combine" design); a
purchase not following the person across stores (entitlement account); Watch logs not reaching the phone (Watch design).

**Can be reduced, not removed:**
- **Slow sync on Android.** iPhones get a push from iCloud the moment something changes; Google Drive can only push to
  a web server, which we don't have, so Android devices learn of changes when opened and on their own background
  schedule (and some phone makers delay that). Sync on open makes the common case fine. Closing the gap fully would
  need a tiny relay that only says "something changed" (no habit data) — a server, so the user's call under D16.
- **A person logging something twice** because the other device was late — the notes reduce it; Undo fixes it.
- **The same thing edited differently on two offline devices** (e.g. a habit renamed on both): the newest edit wins and
  the other is replaced. Rare; an edit history could keep the other.
- **A delete reaching the other device** surprising someone: archive-with-undo and the brake soften it.

**Technically impossible (outside anyone's control), explained instead:**
- An offline or switched-off device's changes can't appear elsewhere until it's online.
- Changes made on a device that's lost, broken or wiped before it ever got online are gone (only what wasn't sent yet).
- iCloud or Google Drive full, signed out, access removed, the wrong account chosen, or Apple/Google down: the app can
  detect and say so, not fix it for them.
- iCloud can't reach Android: someone with an iPhone and an Android tablet syncs only if both use Google Drive (a
  build decision, not impossible).

**Coverage:** for normal use (devices online, used day to day) the plan covers the complaint types found in the
reviews; what's left is rare, outside our control, or "late, not lost". It can't be proven as a percentage before the
two-device tests; the target the plan does guarantee by design is **no silent data loss**.

## 3c. Follow-up, same day (the user's questions)

### The "something changed" relay — within free limits?
- **Design:** the first device makes a random **sync-group ID and secret** and keeps them in the Google Drive app folder
  (every device of the person reads them there). Each Android device registers its Firebase push token with the relay
  under that group. After a device uploads to Drive, it pings the relay ("group X changed", signed with the secret);
  the relay sends a push to the group's other devices; they sync from Drive at once. **The relay never sees habits,
  Google accounts or names** — only random IDs and push tokens. No Drive webhooks needed.
- **Free limits (checked 11 Oct 2026):** Cloudflare Workers Free: 100,000 requests a day, 10 ms CPU each
  (https://developers.cloudflare.com/workers/platform/limits/). One request per sync (batched) ≈ 10–20 a day for a
  person with two Android devices → roughly 5,000–10,000 such people a day on the free plan; the paid plan has no
  request cap (price on Cloudflare's pricing page, not checked). Firebase Cloud Messaging is free at any volume
  (Firebase pricing). Token storage: a KV read per ping fits the free plan.
- **Limit (platform rule):** Android may lower a silent high-priority push to normal priority when pushes don't show a
  notification, so a sleeping device may get it later (https://firebase.google.com/docs/cloud-messaging/android/message-priority).
  The case that matters — the other device is in use — gets it quickly; a sleeping one syncs when opened anyway.
- **It is a server** (D16 says the only server is the entitlement record): the user's call. It would live in the same
  Cloudflare account as the entitlement record. iPhone needs none (iCloud already pushes).

### Where the "Pixel 8 last synced" note goes — corrected
- **Not Day details.** The note is about a device, not a habit (the app can't know which habits the phone logged), and
  no native app puts sync status there. The user was right to doubt it.
- **Native pattern: a status line at the bottom of the main list** — Mail's "Updated Just Now" at the foot of the
  inbox, Photos' sync line at the end of the library. So: **one quiet grey line at the end of Today's list**, only when
  there's something to say ("3 changes waiting to sync" / "Pixel 8 last synced at 9:14 AM…" / "Updated with 3 logs
  from Pixel 8", which fades after the next visit). Tapping it opens iCloud & Backup (Android: Sync & Backup) with Sync
  Now and the device list. This **changes the decided rule** "nothing about sync on Today" → the user's say-so.
- How the person knows: they don't have to look anywhere; the line comes to them, only when it's true. The page is
  for details. (On `main` the ≡ row is now "iCloud & Backup"; it replaced Backup & Export in item 81.)
- Per log: the log's own view says "Logged on Pixel 8" (U19's "where it came from").

### The three "reduced" cases — solvable
- **Same thing edited differently on two offline devices:** solvable. Field-level merge already keeps different
  fields; for the same field the newer one shows and the other is **kept in history**, with a quiet "Also changed on
  Pixel 8 to 'Read 20 min' · Use This Instead" on that habit. Nothing lost.
- **A delete reaching the other device:** solvable. A delete is an archive (D6); the Archived list says "Archived on
  Pixel 8 · 9:14 AM" with Restore; the brake asks first for large deletes (D17).
- **Logging the same thing twice:** mostly solvable. After a merge, if the same habit got the same amount from two
  different devices within about 30 minutes, and one of them had been offline, the habit's Day details asks once:
  "Logged on Pixel 8 and this tablet around 9:00 · Keep Both / Remove One". Check habits need nothing (the merge makes
  one). The conditions keep it from asking about two genuine glasses of water logged on one device.

### Relay at scale, and without it (the user: "if we reach many users, do we pay? without it, is sync less reliable?")
- **Cost (Cloudflare pricing, checked 11 Oct 2026):** Workers Paid $5/month includes 10 million requests, then $0.30
  per extra million (https://developers.cloudflare.com/workers/platform/pricing/). Only Plus users with 2+ Android
  devices use it (~10–20 requests/day): ≈ $5/month at 10,000 such people a day, ≈ $15 at 100,000, ≈ $140 at 1,000,000,
  plus a similar small KV amount (KV overage price not checked). ≈ 0.2 cents per person per year. FCM free at any size.
- **Without the relay, reliability is the same** (merge, version chain, sync on open); only speed differs when two
  devices are in use at the same moment.
- **Free alternative that gets most of the speed:** while the app is open on screen, check Drive's change list about
  once a minute (cheap), so a device someone is looking at catches up within a minute; closed, it syncs on open and in
  the background as planned.
- **Recommendation:** launch without the relay (keeps D16); add it only if reviews ask for faster Android-to-Android
  sync.

**DECIDED by the user, 11 Oct 2026: no relay server** ("not necessary cost and unnecessary relay"). Android uses the
once-a-minute check while the app is open, sync on open, and background sync.

### When the person's iCloud or Google Drive can't be used after they bought Plus (the user's question, same day)
- **Nothing stops working on the device** (D1): habits, widgets, more than 5 habits, widget designs — all of Plus
  except sync. Only sync and the cloud backup pause; the status row says why, with the one fix (decided for iCloud:
  "iCloud is full" + Manage Storage; "iCloud is off" + Open Settings). Same words on Android: "Google Drive is full ·
  Your habits are on this phone · Manage Storage"; "Google Drive isn't connected · Connect".
- **The space needed is tiny** (a typical person's whole history < 1 MB; an extreme one tens of MB over many years),
  so freeing a little space fixes it; iCloud gives 5 GB free, Google 15 GB (shared with Gmail and Photos, so "full"
  does happen).
- **Before buying, the Plus page checks and says it honestly** if sync can't work right now ("Sync uses your iCloud.
  It's full at the moment: Plus syncs once there's a little free space"). Never blocks the purchase. Reasoned: "paid
  for it and it doesn't work" is the most common kind of buyer complaint in the reviews (§5 of the report).
- **Refunds stay the stores' (Apple, Google Play)**; we never argue with one.
- **iPhone has a second carrier only if Google Drive is built for Apple** (Current Work 77, open). Android's only
  carrier is Google Drive; other clouds (Dropbox, OneDrive) could be added later as carriers but reviews ask for Google
  Drive (117 of 205 Drive reviews). A phone without Google services can't install from Google Play anyway.

## 4. Decisions for the user
1. Today: stay silent about sync (decided), or the two **(your call)** cases above.
2. The quiet-device footnote in today's Day details (recommended).
3. Two devices that each created the same habit before joining: offer to combine them (recommended to design).
