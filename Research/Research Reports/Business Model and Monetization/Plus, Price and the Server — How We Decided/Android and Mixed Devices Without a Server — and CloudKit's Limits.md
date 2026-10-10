# Android and Mixed Devices Without a Server — and CloudKit's Limits

Written by Claude (Claude Code), 10 October 2026, for Current Work 80. Follows
[Plus Without a Server](<Plus Without a Server — Sync, Entitlements and Data Safety on Apple's Own Services.md>).
The user, the same day: is CloudKit with `CKSyncEngine` part of the Apple Developer account, does it have limits, and
are we charged for it? Android has nothing like it, and we can't leave Android users out: what do they accept, when do
they pay, what do they expect, and how do we stay server-free and still be usable on Android? What about someone with
a Mac and an Android phone? For Plus across Apple and Android, an account is acceptable, on Cloudflare's free plan.

**Evidence.** Platform documentation (Apple, Google, Cloudflare), fetched today. Users show: all 205 Play Store reviews
that name Google Drive, **read by hand** ([`Research/Temp/no-server/play_drive_codes.py`](../../../Temp/no-server/play_drive_codes.py));
a machine inventory of what 2,683 self-declared Play payers mention (`android_scan.py`, English wording, co-mentions,
not causes); the cross-platform reviews already read for the previous report.

## 1. The answer

| Who | Sync | Backup | Plus |
|---|---|---|---|
| **Apple devices only** | iCloud (CloudKit) | iCloud + the daily file | App Store |
| **Android only** | **Through their own Google Drive** (Plus), between their Android phone and tablet | **Android's own backup, automatic, plus a daily file in their Google Drive, "like WhatsApp" (free)** | Google Play |
| **Apple and Android together** (a Mac or iPad with an Android phone) | **Choose Google Drive as the sync place on every device**, Apple ones included | The same Drive files | One account, only to carry Plus between the two stores |
| **Switching iPhone ⇄ Android** | — | The backup file moves everything | The account carries Plus |

No server holds anyone's habits. The only server is the small entitlement account the user accepted, and the store's
own purchase never depends on it.

## 2. CloudKit: is it ours to use, is it charged, what are the limits?

- **It comes with the Apple Developer Program** we already pay for ($99 a year). There's nothing to buy and no bill
  for the private database: **its data counts toward each person's own iCloud storage, not ours**
  ([Apple, `CKContainer`](https://developer.apple.com/documentation/cloudkit/ckcontainer)). We never use the public
  database, which is the part with developer allowances.
- **Limits that matter:**
  - **The person's iCloud storage** (5 GB free, shared with their photos and device backups). When it's full,
    CloudKit refuses new data for that person (`quotaExceeded`): sync pauses, the phone keeps everything, and the app
    says so. Compacting finished years keeps an extreme account to roughly 55 MB over 15 years.
  - **Throttling:** Apple slows an app that sends bursts of requests, and doesn't publish exact numbers
    ([TN3162, Understanding CloudKit throttles](https://developer.apple.com/documentation/technotes/tn3162-understanding-cloudkit-throttles)).
    `CKSyncEngine` waits and retries on its own; about 70 changes a day per person is far from any burst.
  - **iCloud must be signed in and on for the app.** Without it, no CloudKit: the backup file and Export remain.
  - **Records are small** (about 1 MB each at most); anything bigger goes as a file (an asset). Our records are a few
    hundred bytes.
- **The real risk is depending on Apple:** CloudKit has run since 2014 and Apple's own apps sync with it; if it ever
  changed, the phone and the daily file still hold everything (D1).

## 3. What Android users expect (users show)

**205 Play reviews name Google Drive (mean 4.15★): 175 on topic, mostly Loop Habit Tracker (87), a goal tracker (23)
and two to-do apps (32).**

| What they say | Reviews | Mean ★ |
|---|---|---|
| **Asks for an automatic backup to Google Drive** | **117** | 4.24 |
| Wants their devices kept in sync through Google Drive | 19 | 4.11 |
| Lost their data because the backup wasn't automatic | 9 | 4.22 |
| A Drive backup or restore that failed | 12 | 3.08 |
| Praises an existing Drive backup | 11 | 5.00 |

- **The expectation is clear: their own Google Drive, automatic, like WhatsApp.** "It would be great if I could back
  up my data to Google drive like WhatsApp" (Loop, 5★, `a758a2f2-3c93-43c4-8393-c662e65cf567`); "Why must I create
  another online account that can get hacked, instead of using the Google drive I already have?" (everyday, 3★,
  `4ccc8f63-45e3-4cdd-a916-6701c384611c`).
- **Manual export isn't enough:** "Today i lost 2.5 years of data as i forgot to backup the file and hit factory reset"
  (Loop, 4★, `5d37a37b-72de-4482-a85c-c7138ebebc8b`).
- **Backup must stay free:** "the one critical function that needs a subscription, which is the backup & restore
  function, I don't want to use this app" (Habit Tracker n Pets, 2★, `b46a70a1-d4c6-4858-b306-ea4c783204ae`). Sync
  is what some would pay for: "cloud sync via Gdrive/DropBox, I'd happily pay a one off price for" (Tasks, 5★,
  `85155a96-1e87-49af-a02d-e631a141ed2a`).
- **The most loved Android habit app asks for none of this from a server:** Loop is free, without ads or an account,
  and its reviews' one big wish is an automatic Drive backup.

**What Play payers mention** (2,683 who say they paid; machine co-mentions): lifetime / one-time / no subscription
**17.1%**, no ads 6.6%, sync / tablet / other devices 5.6%, widgets 4.3%, backup 3.3%, statistics 3.1%, themes 3.0%.
The same order as on the App Store: owning it outright first, then devices. **When they pay** is covered by the
earlier study (Business Model §4.3): after trying it, at a success moment, never on opening.

## 4. Android without a server

**Free:**

1. **Android's own Auto Backup**, on by default, nothing to set up: up to 25 MB an app, kept in the person's Google
   account without using their Drive storage, restored when the app is installed on a new phone, end-to-end
   encrypted on Android 9 and later ([Android Auto Backup](https://developer.android.com/identity/data/autobackup)).
   We put a compressed copy in it (about 89 bytes a record): 25 MB holds about 11 years of an extreme user; beyond
   that it holds the latest years and the Drive file holds everything.
2. **A daily backup file in their own Google Drive**, turned on with one tap ("Back up to Google Drive, like
   WhatsApp"), the most-asked-for thing in §3. It uses Drive's per-app folder with Google's non-sensitive
   `drive.appdata` scope, so it needs only Google's basic app verification
   ([Google Drive API scopes](https://developers.google.com/workspace/drive/api/guides/api-specific-auth)). Free to
   us; it counts toward their Drive storage.

**Plus (one-time on Google Play):** unlimited habits and **sync between their Android devices through the same Drive
folder**: each device writes its own small change files there and reads the others', and the shared core merges them
by record (our sync already exchanges changes, not whole databases). Wear OS later.

**What's harder than on iOS, honestly:**

- It's **our own sync engine on a file store**, not Apple's: more to build and test (two devices changing the same
  day, a device offline for a month, Drive full, access revoked). Android can launch with the two free backups and
  add Drive sync for Plus when it's proven.
- Sync isn't instant: it runs when the app opens and in the background a few times a day (WorkManager). For habits
  that's enough; the widget and the phone are always right locally.
- People must connect Google Drive once; some won't, and they still have Auto Backup.

## 5. Apple and Android together (a Mac or iPad with an Android phone)

- **iCloud can't reach Android** in any way we'd rely on. (CloudKit has a web interface an Android app could call
  after the person signs in to their Apple Account in a browser, with a fresh token on every request; it's possible
  on paper, untested, and not something to promise.)
- **Google Drive reaches both.** The iPhone, iPad and Mac app can sign in to Google with the same `drive.appdata`
  access and use the same change files. So a person with mixed devices picks **one sync place: iCloud (Apple devices
  only) or Google Drive (any device)**, the same "one place at a time" rule as D4.
- **Plus across the two stores** needs the account the user accepted (§6).
- **This is later work, not launch:** users show it's a small group (about 50 reviews in our corpus), and it depends
  on the Drive engine from §4 working first.

## 6. Plus across the App Store and Google Play: the account on Cloudflare's free plan

**Only for Plus, never for habits.** Signing in with Apple or Google records "this person owns Plus (bought on the App
Store / Google Play)" so the other platform unlocks it too.

- **Cost:** Cloudflare's free plan allows 100,000 Worker requests a day, and D1 allows 5 GB, 100,000 rows written and
  5 million rows read a day ([Workers limits](https://developers.cloudflare.com/workers/platform/limits/),
  [D1 pricing](https://developers.cloudflare.com/d1/platform/pricing/)). An entitlement is one small row, checked
  when someone signs in on a new device: hundreds of thousands of customers fit. Above that, the paid plan is $5 a
  month, flat. One thing to watch: Cloudflare says that **from 1 September 2026 D1 queries on the free plan fail
  once the day's limit is reached** (stored data isn't affected), so the app must treat "couldn't check" as "keep
  what you have", never as "no Plus" (Billing 02's rule: never downgrade on doubt).
- **The store purchase never depends on it:** Plus bought on the App Store works on Apple devices with no account and
  no server; the account only extends it. If the server ever stopped, nobody loses Plus on the platform they paid on.
- **Store rules:** Apple allows unlocking what was bought on another platform if it's also sold in the app
  (App Review 3.1.3(b), multiplatform services). **Google Play's wording on this wasn't found today; check it before
  building.** Both stores require in-app account deletion for any account (D9).
- **Plus Family:** on Apple, Family Sharing (previous report §4). Google Play's family sharing for one-time in-app
  purchases needs checking; if it doesn't cover them, Android's Plus Family can be our invite on the same small account.

## 7. For the user to decide

1. Android: **free Auto Backup + a daily Drive file** at launch, and **Drive sync for Plus** once it's proven (recommended).
2. Mixed Apple + Android devices: **Google Drive as the one sync place**, later, after Android's Drive sync works.
3. The **entitlement-only account** on Cloudflare's free plan, for Plus across stores (the user's idea; recommended,
   with "couldn't check" never removing Plus).
4. To check before building: Google Play's policy on unlocking purchases made on another store, and its family
   sharing for one-time purchases.

## Sources

- Apple: [`CKContainer`](https://developer.apple.com/documentation/cloudkit/ckcontainer) (private data counts toward
  the user's iCloud storage); [TN3162: Understanding CloudKit throttles](https://developer.apple.com/documentation/technotes/tn3162-understanding-cloudkit-throttles);
  [CloudKit pricing thread](https://developer.apple.com/forums/thread/715649) (no current published price for the
  public database); [CloudKit Web Services](https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/CloudKitWebServicesReference/SettingUpWebServices.html).
- Google: [Auto Backup](https://developer.android.com/identity/data/autobackup); [Drive API scopes](https://developers.google.com/workspace/drive/api/guides/api-specific-auth).
- Cloudflare: [Workers limits](https://developers.cloudflare.com/workers/platform/limits/),
  [D1 pricing](https://developers.cloudflare.com/d1/platform/pricing/), [D1 FAQ](https://developers.cloudflare.com/d1/reference/faq/).
- Reviews: `Research/Temp/no-server/` (`play_drive.json` with `play_drive_codes.py`; `android_scan.py`); quotes checked
  against those files.
