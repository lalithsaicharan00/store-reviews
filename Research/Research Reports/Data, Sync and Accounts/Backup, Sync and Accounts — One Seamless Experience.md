# Backup, Sync and Accounts — One Seamless Experience

*Written by Claude (Claude Code), 1 Oct 2026. The experience design that follows the user's rules of 1 Oct. It replaces the "safety copy on our server without an account" recommendation in [Free Plan Data Protection](<Free Plan Data Protection — Backup Without Giving Away Plus.md>) §4. A design to decide in Notion, not a decision record.*

**The user's rules (1 Oct, final):**
1. **Sync works only through our server.** No sync through iCloud or Google Drive.
2. **Free works without an account.** Anyone may make an account if they want one.
3. **People who don't make an account don't want their data on a server.** So without an account, nothing goes to our server.
4. **With an account, people choose where their backup lives:** our server, iCloud or Google Drive. Our server is a fine default.
5. **A free user on two devices can copy (import) their data, but it doesn't sync.**
6. **Never ask "do you want sync?" after someone buys Plus.** They probably bought it for sync.
7. **No odd questions** ("where should your backup go?" during onboarding). It should feel automatic and smooth, while people stay in control.

**How each point is backed:**
- **Users show**: review evidence.
- **Platform fact**: Apple or Google documentation, linked.
- **First principles**: reasoned from how the system works.

**Evidence:**
- **A fresh screen:** 897,899 habit-app reviews (App Store and Play; to-do, gym, planner and built-in apps left out), 5 patterns: choosing a backup place, sign-in around buying, moving to another device, automatic-backup expectations, "where is my data".
- **Every match read and coded:** 264 read, 187 on topic, from 33 apps. 21 quotes checked word for word.
- **Reused:** [Backlog 4](<Sign-in Prompts and the Backup Guarantee — Backlog 4.md>), [Plus Scope](<../Business Model and Monetization/Plus Scope and Account at Purchase.md>), [Free Plan Data Protection](<Free Plan Data Protection — Backup Without Giving Away Plus.md>), [Architecture 01, 03, 04, 07](<../../../Architecture/README.md>).
- **Files:** [`Backup Experience Evidence/`](<Backup Experience Evidence/>).

---

## 1. The short answer

1. **People don't want to choose; they want backup to just happen.**
   - **Users show:** 110 reviews ask for automatic backup. Only **2** ask to *choose* where it goes.
   - When people name a place, it's the one they already have: their Google account or Drive on Android, iCloud on iPhone.
   - **So:** pick the right place automatically, show it plainly in Settings, and let people change it there. Ask nothing in onboarding.
2. **Backup and sync are two different things, and the app says so.**
   - **Backup** = a copy so you never lose your habits.
   - **Sync** = the same habits on all your devices.
   - **Users show:** people try to use backups as sync and hate it: 12 reviews here (`A76#576`, `P2#3087`), 23 in [Backlog 4](<Sign-in Prompts and the Backup Guarantee — Backlog 4.md>). People mix the two up because apps blur them.
3. **The defaults (nobody is asked anything):**

   | Who | Backup goes, automatically | Our server? |
   |---|---|---|
   | **iPhone or iPad, no account** | Nightly to **their own iCloud** (a hidden folder of our app), if iCloud is on | **No** |
   | **Android, no account** | **Android's own Google backup** (on by default for most phones); a daily copy in **their Google Drive** after one tap (§4.2) | **No** |
   | **Has an account** (free or Plus) | **Our server**: nightly on free, every change on Plus. The iCloud or Drive copy keeps running as a second copy | Yes, they chose an account |

4. **Accounts are optional for everyone.** They are offered only where they help (Settings → Backup & Sync, a new device, the Plus purchase), never in onboarding and never as nagging.
5. **Upgrading never asks "do you want sync?".**
   - With an account on our server, sync simply switches on.
   - Without an account, the purchase screen's "One last step" (already designed) explains that sync needs an account.
   - Only someone who deliberately chose "iCloud only" sees one honest line, because they made that choice earlier.
6. **A free user on a second device gets "Copy my habits here once", never anything that looks like sync.**
7. **Moving without an account must be foolproof:** "Move to another device" makes a file and sends it any way the phone can (AirDrop, Quick Share, Files, email); the new device imports it from the first screen. **Users show:** failed imports average 2.38★ (21 reviews); a working move is praised at 4.86★.

---

## 2. What users show

From 264 reviews read (187 on topic, 33 apps).

| What they say | Reviews | Apps | Mean ★ | Design rule |
|---|---|---|---|---|
| **Want backup to happen automatically** | **110** | 21 | 4.23 | Backup on by default, no setup (§4.2) |
| of those, name their own cloud (Drive, iCloud, Dropbox) | 33 | | | Default to their own cloud when there is no account |
| of those, name a Google account or "login" | 23 | | | An account is a natural place for those who want one |
| **Ask to *choose* where the backup goes** | **2** | 2 | 4.00 | No choice screen; the choice lives in Settings |
| Import or move to a new device failed or was confusing | 21 | 11 | **2.38** | Foolproof move and import (§4.8) |
| Ask how to move to a new phone or tablet | 15 | 11 | 3.87 | "Move to another device" in Settings; "I've used this before" at first launch |
| Use backups as manual sync, and hate it | 12 | 7 | 4.08 | Say plainly that backup ≠ sync; never make backup look like sync |
| Want sync through iCloud or Dropbox | 11 | 3 | 4.18 | Sync only through our server; their cloud is for backup |
| Moved their data and it worked | 7 | 1 | **4.86** | The bar to meet |
| Backups not frequent enough (every 2 days, "real-time") | 7 | 4 | 3.57 | Nightly at least; every change on Plus |
| Praise automatic backup | 4 | 4 | 5.00 | – |
| Left because there was no automatic backup | 4 | 3 | 2.00 | – |

*Loop Habit Tracker (an open-source Android app with manual backup only) supplies 67 of the 110 "automatic backup" requests and all 7 "move worked" reviews. Its users are vocal about one missing feature; the request still spans 21 apps.*

**What they want: it just happens, in a place they already trust:**
- “Why is there no Google account sign in and backup automatically.” (`P3#15260`)
- “Everyday Auto Backup (like WhatsApp)” (`P69#245`)
- “You can let us set backup frequency like every night or weekly, and save it on any cloud. Local device can be lost or gone anytime.” (`P110#1454`)
- Either place is fine to them: “either connect to Google drive and automatically backup daily, or make an account with a cloud” (`P3#14335`)
- Some see their own cloud as fair to the developer: “(Like Dropbox, so the developer shouldn't waste his own money for servers)” (`P3#2531`)
- Privacy-minded users accept less: “they seems commited to make it fully accessible offline to keep user privacy (which is nice)” (`P3#6989`)
- The one explicit choice request: “allows me to choose where to back up to (e.g. Drive)” (`P2#12079`)

**Manual backup and hidden options fail people:**
- “you can set a reminder to do it manually but looking through some reviews you can see a lot of people didn’t know that was an option” (`A10#29286`)
- “the application has no auto backup.  So I decided to no longer use this application.” (`A24#28960`)
- “the shortest interval for automatic backups is two days” (`P2#3497`)

**Backup used as sync is a chore and loses data:**
- “I would need to go to the other device and restore that back up to the device each and every time. It’s really annoying so I just use one device.” (`A76#576`)
- “I backed up the wrong device and imported from cloud on the device with the last few days on it” (`P2#3087`)
- When it's real sync: “I am delighted that the app update across devices without having to backup and then import back on another device.” (`P70#174`)
- Free users already expect sync to be paid: “Automatic sync between two devices would be nice. But I guess I can't ask it from the free app” (`P3#10745`)

**Moving devices: either it's effortless or it's a disaster:**
- Effortless: “the fast and seamless copy of data from old phone to my new phone via Bluetooth, without any hitch, and without the need to log in” (`P3#10847`)
- Disaster: “I tried for 45 minutes to figure out how to export the data and import it on my new phone.” (`P3#13435`); “I can not find the folder that is mentioned in the faqs.” (`P3#20156`); “When I import the file I experienced from another phone, the app I import to still stays empty.” (`P3#14530`)
- What people ask: “how do i transfer my habits from phone to ipad” (`A1#53141`); “it would've been cool to Log into my Tablet with the Habits I created” (`P2#12061`)
- One user even wants an account at sign-up (“An account should be created immediately created upon sign up!!!!”, `A10#39038`), after losing data. The fix they need is automatic backup, which the defaults give without forcing an account on everyone (forced sign-up averages 1.42★, [Plus Scope §1](<../Business Model and Monetization/Plus Scope and Account at Purchase.md>)).

**From earlier studies:**
- Repeated prompts average 1.75★; "once is fine" ([Backlog 4 §2.1](<Sign-in Prompts and the Backup Guarantee — Backlog 4.md>)).
- "No account needed" praise averages 4.85★ (151 reviews).
- iCloud is full or off for some people (16 reviews), and iCloud backups that failed at restore average 1.93★ (46). So a backup only counts once it has been read back and checked ([03 §3.4](<../../../Architecture/03. Backup and Restore.md>)).

---

## 3. The rules

| # | Rule | Backed by |
|---|---|---|
| 1 | **Sync only through our server, and only with Plus.** Words used in the app: "Sync keeps the same habits on all your devices. It needs your account, because your devices talk through it." | User's decision; first principles |
| 2 | **Backup is always on and automatic.** Nightly at least. Where it goes is chosen by default (below) and changed only in Settings | Users show: 110 vs 2 |
| 3 | **Without an account, nothing goes to our server.** The backup goes to the user's own iCloud (iPhone, iPad) or Google's backup and Drive (Android) | User's decision |
| 4 | **With an account, backup goes to our server by default.** Settings can switch it to "My iCloud / Google Drive only" | User's decision; first principles: it makes Plus sync instant later |
| 5 | **The own-cloud copy never stops because of an account.** It keeps running as a second copy unless turned off | First principles: two copies are safer; nothing disappears on upgrade |
| 6 | **No backup or account questions in onboarding.** The only first-launch question is "New here / I've used this before" | Users show: prompts 1.75★; first principles |
| 7 | **A free account backs up but never syncs.** A second device gets "Copy my habits here once" | User's decision |
| 8 | **Buying Plus never asks "do you want sync?"** | User's decision |
| 9 | **Status is always one tap away and honest:** Settings → Backup & Sync shows where the last good backup is and when | Users show: "where does my data even backup to?" (03 §2) |
| 10 | **The words "backup" and "sync" are never mixed.** Backup screens never promise other devices; sync screens never claim to be a backup | Users show: backup-as-sync reviews (12 here, 23 in Backlog 4) |

---

## 4. The experience, moment by moment

### 4.1 First launch: one question only

```
┌─────────────────────────────┐
│  Welcome to Often Enough     │
│                              │
│  [ I'm new ]                 │
│  [ I've used this before ]   │
└─────────────────────────────┘
```

- **"I'm new"** goes straight to creating habits. Nothing about backup or accounts.
- **"I've used this before"** opens one screen with whatever applies, most likely first:
  - **"We found your backup in iCloud: 'iPhone 16', last night 21:40, 5 habits. [Restore]"** (found automatically when the same Apple Account has one);
  - **[Sign in]**: Apple or Google, for people with an account;
  - **[Import a file]**: a file from "Move to another device" or an export;
  - **Android:** if Google's own backup restored our data during phone setup, the app simply opens with the habits and says "Welcome back" (03 §3.5). Nothing to tap.
- *Platform fact:* Apple says data stored in iCloud is not deleted when the app is deleted ([Apple Support](https://support.apple.com/guide/iphone/remove-or-delete-apps-iph248b543ca/ios)). Android Auto Backup restores app data whenever the app is installed again ([Android](https://developer.android.com/identity/data/autobackup)).

### 4.2 Every day: backup happens by itself

**iPhone and iPad without an account:**
- Every night (and after big changes, at most every few hours) the app writes the checked backup file to **its own hidden folder in the user's iCloud Drive**. That is their storage; we can't see it.
- No question is asked. The app has its own switch in the iPhone's iCloud settings, so people stay in control there.
- If iCloud is signed out, off for our app, or full, the backup stays on the phone, and the user is told at once (§4.4).

**Android without an account:**
- **Android's own backup** (Google) includes our data automatically if the user's Google backup is on. That is the default on most phones. We can't confirm it ran, so Settings words it as "Your phone's Google backup includes Often Enough (if it's on)".
- **A daily copy in their Google Drive needs one consent tap** (Google requires it). Offer it once, and not in onboarding:
  - **When:** after **14 days with check-ins**, so there is real progress to protect.
  - **Where:** one small card at the bottom of Today, not a pop-up: **"Keep a daily copy of your habits in your Google Drive? Only this app can see it. [Turn on] · [No thanks]"**
  - Either answer ends it; it never comes back. Settings keeps the switch.
  - **Why this one exception (users show):** 93 Play reviews ask for automatic backup, mostly to Google Drive or a Google account. Android has no silent way to do it, and a single well-timed card is accepted ("Once is fine but they keep popping up", `A13#12100`, quoted in [Backlog 4 §2.1](<Sign-in Prompts and the Backup Guarantee — Backlog 4.md>)).
  - If you'd rather have no card at all, drop it and rely on Settings. Android's own backup still covers a reinstall and a new phone.

**With an account (free or Plus):**
- **Free account:** a nightly backup on our server.
- **Plus:** every change goes to the server through sync.
- The iCloud or Drive copy keeps running beside it as a second, independent copy.

### 4.3 Settings → Backup & Sync (one screen, two clearly separate parts)

```
BACKUP — so you never lose your habits
  ✅ Backed up · last night 03:12
  Where:  Your account (our server)            ›   ← or "Your iCloud" / "This phone only"
  Also:   Copy in your iCloud              [on]
  [ Back up now ]   [ Restore… ]   [ Move to another device ]   [ Export a file ]

SYNC — the same habits on all your devices
  Plus:     "On · iPhone, iPad, Apple Watch"   [Devices ›]
  Free:     "Sync is part of Plus. Your devices talk through your account."  [About Plus]
```

- **"Where" lists only what exists for this person:**
  - with an account: Your account (our server) · Your iCloud / Google Drive only · This phone only;
  - without one: Your iCloud / Google Drive · This phone only · [Sign in to back up to your account].
- **Switching to "iCloud / Google Drive only" with an account** says what happens: "Your habits will be removed from our server and kept only in your iCloud. Sync can't work without the server (§4.7). [Switch] [Cancel]".
- The status uses plain words and real times, and turns red only for real failures (§4.4).

### 4.4 When something goes wrong with their backup

**Rule (the user's, 1 Oct):** whenever their backup can't work, we tell them **as soon as we know**, say plainly what happened, and offer the fix. A backup that isn't happening is never hidden.

**When we know:** the app checks at every backup attempt (nightly, and after changes) **and every time it opens**. So "as soon as we know" means the next app open or the next backup, whichever comes first.

**How we tell them, for a problem we're sure about** (the table below):
1. **Settings → Backup & Sync turns red at once,** and stays red until it's fixed.
2. **A card at the top of Today** the next time they open the app (not a pop-up): what happened, and [Fix it]. "Not now" hides it for **7 days**; it returns if it's still broken.
3. **If the app is closed when the nightly backup finds it, one notification,** once per problem: "Your habits aren't being backed up: your iCloud is full." Tapping it opens the fix.

| Problem (with their own cloud or our server) | How the app knows | What it says | Fix button |
|---|---|---|---|
| **iCloud is full** | The write fails with "out of space" | "Your habits can't be backed up: your iCloud is full." | [How to free up space] · [Back up to your account instead] |
| **Signed out of iCloud, or iCloud Drive turned off** | iOS reports no iCloud account for the app (the identity changes or is missing) | "Your habits aren't being backed up: this iPhone isn't signed in to iCloud (or iCloud Drive is off)." | [Open Settings] · [Back up to your account instead] |
| **iCloud turned off for our app only** | Same signal, while the phone is signed in | "Backup to iCloud is turned off for Often Enough in your iPhone's iCloud settings." | [Open Settings] |
| **Signed in to a different Apple Account** | The iCloud identity changed since the last backup | "This iPhone now uses a different Apple Account, so your backup moved to a new iCloud. Your old backup is still in the other account." | [Back up now] |
| **Google Drive access removed** (in Google's settings, or the Google account removed from the phone) | Google refuses our access at the next upload or open | "Your habits can't be backed up: Google Drive access was removed." | [Reconnect Google Drive] |
| **Google Drive is full** | Google reports its storage quota exceeded | "Your habits can't be backed up: your Google storage is full." | [Manage Google storage] · [Back up to your account instead] |
| **Signed out of our account, or the session ended** | The server refuses the session | "You're signed out, so your habits aren't being backed up to your account." Everything stays on the phone (01 §3.5) | [Sign in] |
| **Our server can't be reached** (no internet, an outage) | Uploads fail | Nothing for the first 2 nights, because short gaps are normal. After that: "Your habits haven't been backed up for 2 days: we can't reach our server." | [Try now] |
| **The phone itself is full** | Saving on the phone fails | At once: "Your phone is full. Changes can't be saved." ([03 §3.7](<../../../Architecture/03. Backup and Restore.md>)) | [How to free up space] |
| **A backup was saved but fails its check** (corrupt) | The read-back after writing doesn't match | "Last night's backup didn't save correctly. We'll try again tonight; the one before is safe." Shown only if it fails twice | [Back up now] |
| **Android's own Google backup is off** | Android gives apps no way to tell | Nothing; we can't know. The Drive copy, if on, is checked like everything above | – |

- **Second copies get a quieter message.** If their main backup works (for example our server), a problem with the extra iCloud copy is only a grey line in Settings: "Copy in your iCloud: paused, iCloud is full". No card, no notification.
- **[Back up to your account instead]** appears only where it solves the problem. It is never an upsell: a free account is enough.
- **When it works again,** the status returns to "Backed up · just now", the card disappears, and nothing pops up.
- **Words:** say what happened and what is still safe ("your habits are safe on this phone"). Never "Error", never a code number, never blame the user.

### 4.5 Making an account (optional, free)

**Offered only where it helps, never as a nudge:**
- in Settings → Backup & Sync ("Sign in to back up to your account");
- on "I've used this before" (§4.1);
- when they add a second device (§4.6);
- in the Plus purchase flow (§4.7).

**What the sign-in sheet says (one screen):**
- "Sign in with Apple / Google. Your habits are backed up to your account every night, so a new phone just needs a sign-in. Sync between devices comes with Plus."
- "We store your habits on our server only to back them up and sync them. We never sell them or use them for ads. Delete everything any time in Settings."
- Small print: "Prefer not to? Your backup stays in your iCloud." (or "your phone's Google backup" on Android)

After sign-in, nothing else changes on screen. The status line becomes "Backed up · your account".

### 4.6 A second device on the free plan

| Case | What the second device shows |
|---|---|
| **No account, iPhone → iPad on the same Apple Account** | First launch, "I've used this before": **"Copy your iPhone's habits here once? They won't stay in sync: on the free plan each device keeps its own habits. [Copy once] [Start fresh] · Same habits on both, kept in sync: Plus"** |
| **No account, any other pair** (Android tablet, a different Apple Account) | "I've used this before → Import a file". On the old device, Settings → **Move to another device** sends the file (§4.8) |
| **Free account, signs in on the second device** | **"Your account is on the free plan, so your devices don't sync. [Copy my habits here once] (from last night's backup) [Start fresh] · Same habits on both, kept in sync: Plus"** |
| After that, ticking on one device | The other device doesn't change. Settings → Sync says "Sync is part of Plus". Nothing pops up |

### 4.7 Buying Plus: no "do you want sync?"

| Situation at purchase | What happens after "Purchase complete" |
|---|---|
| **Has an account, backup on our server** (the default for accounts) | **"Plus is yours. Your habits now sync to every device you sign in on."** Sync is simply on. Nothing to choose |
| **No account** | The existing "One last step" screen (01 §3.2), worded around sync: **"Plus is yours. To use your habits on your iPad, Mac or another phone, sign in: your devices sync through your account. [Continue with Apple] [Continue with Google] · Not now: use Plus on this device"**. "Not now" keeps their own-cloud backup as it is. Apple requires that link (5.1.1(v)) |
| **Has an account but chose "iCloud / Google Drive only"** | One honest line under the celebration, because they made this choice themselves: **"Sync needs your habits on our server, and you chose iCloud only. Plus works fully on this phone and your Watch. [Turn on sync] · Keep iCloud only"** |
| **Phone + Watch only** | Works in every case. The Watch syncs through the phone, no server needed ([07 §4](<../../../Architecture/07. Other Surfaces.md>)) |

### 4.8 Moving without an account

**Settings → Backup & Sync → Move to another device:**
1. **"Is the new device using the same Apple Account?"** If it is an iPhone or iPad on the same account: "Nothing to do: open Often Enough there and choose 'I've used this before'. Your iCloud backup is waiting."
2. **Otherwise:** [Send my habits] creates the checked file and opens the share sheet: AirDrop, Quick Share or Nearby Share, Files, Google Drive, email.
3. **On the new device:** opening the file starts the app, which offers "Import 5 habits, 412 check-ins from 'Lalith's iPhone', 30 Sep?". From the app it's "I've used this before → Import a file" (the system file picker, never a folder path).

**Rules for import (users show the failures):**
- the app finds and opens the file itself; no folder hunting (`P3#20156`);
- every app version reads every older file (03 §3.2);
- it shows what's inside before changing anything; Replace or Merge; undo for 30 days (03 §3.6);
- an import that adds nothing says why, never "success" with an empty screen (`P3#14530`).

### 4.9 Reinstall, new phone, lost phone

| Situation | No account | With an account |
|---|---|---|
| App deleted and reinstalled | iPhone: "I've used this before" finds the iCloud backup. Android: Google's backup restores it during install | Sign in, and the habits come back |
| New phone, same platform | iPhone: the iCloud backup (or Quick Start). Android: Google's backup or device transfer, plus the Drive copy if it was turned on | Sign in |
| iPhone ⇄ Android | Move to another device (file), from the old phone | Sign in |
| Old phone lost, iCloud or Google backup off | Lost, unless they exported a file. Settings warned "Backed up only on this phone" all along | Sign in |

---

## 5. Words the app uses

| Say | Never say |
|---|---|
| **Backup:** "a copy so you never lose your habits" | "Sync" for a backup, or "backed up" for something not yet checked |
| **Sync:** "the same habits on all your devices" | "Cloud" on its own (which cloud?) |
| **Your account:** "lets your devices talk to each other, and keeps your backup on our server" | "Create an account to continue" |
| **Your iCloud / Google Drive:** "your own storage; we can't see it" | "Free backup" / "premium backup" (backup is never a Plus feature) |

---

## 6. Edge cases

| Case | Behaviour |
|---|---|
| iCloud or Drive is full, access removed, signed out | Red status in Settings at once; a card on Today at the next open; one notification if the app was closed (§4.4) |
| Signs in on the first device while the iCloud copy is on | Both run. The status names both |
| Free account, deletes the account | Server data deleted (09 §7). The iCloud or Drive copy stays theirs |
| Plus with "iCloud only", later adds an iPad | The iPad sign-in shows the line from §4.7 with [Turn on sync] |
| Two free devices, then buys Plus and signs in on both | The habits merge by ID with a preview; same-name habits can be combined (07 §7.1) |
| Turns off backup completely | Allowed in Settings, with a plain line: "If this phone is lost, your habits are lost." |
| A family member on the same Apple Account | They see "We found your backup in iCloud" on their device. Restoring is always a choice, never automatic, and shows the device name |
| **iPhone and iPad on different Apple Accounts, no account of ours** | Each device backs up to its own iCloud, and neither can see the other's: an app's iCloud folder belongs to one Apple Account, and with no account of ours there is no link between the two. So no "We found your backup" on the iPad. The way across is **Move to another device** (AirDrop works between different Apple Accounts) or **Import a file** |
| **Same, but with an account of ours** | Sign in with the **same method** on both. Sign in with Apple uses the device's own Apple Account, so on a device with a different Apple Account it would open a different account; **Google sign-in works on both**. An account can hold both Apple and Google sign-ins ([01](<../../../Architecture/01. Accounts and Identity.md>)), so linking Google on the iPhone first makes the iPad sign-in find the same account |

---

## 7. Platform facts used

| Fact | Source |
|---|---|
| Deleting an iPhone app deletes its data, but data the app stored in iCloud is not deleted | [Apple Support](https://support.apple.com/guide/iphone/remove-or-delete-apps-iph248b543ca/ios) |
| An app's iCloud Drive folder can be hidden from the Files app (`NSUbiquitousContainerIsDocumentScopePublic` defaults to NO), and it appears on the user's other devices with the same Apple Account | [Apple: QA1893](https://developer.apple.com/library/archive/qa/qa1893/_index.html), [Designing for Documents in iCloud](https://developer.apple.com/library/archive/documentation/General/Conceptual/iCloudDesignGuide/Chapters/DesigningForDocumentsIniCloud.html) |
| Android Auto Backup restores app data whenever the app is installed again, including after a factory reset; it needs the user's Google backup on | [Android Auto Backup](https://developer.android.com/identity/data/autobackup) |
| A hidden Drive app folder (`drive.appdata`) is visible only to our app, needs one consent, and is a **non-sensitive** scope (basic verification only) | [Drive app data](https://developers.google.com/workspace/drive/api/guides/appdata), [Google OAuth scopes](https://developers.google.com/identity/protocols/oauth2/scopes) |
| Apple: a purchase that doesn't need an account must not require one (hence "Not now: use Plus on this device") | Apple 5.1.1(v), [01 §3.2](<../../../Architecture/01. Accounts and Identity.md>) |

---

## 8. What this changes

| Earlier | Now |
|---|---|
| 27 Sep: no copies in the user's own iCloud or Drive | **Their own cloud is the default backup when there is no account** |
| 27 Sep: accounts only for Plus | **Accounts are optional for everyone; sync is Plus only** |
| 1 Oct (Free Plan Data Protection §4): an encrypted copy on our server without an account | **Dropped.** Without an account, nothing goes to our server |
| [Server Cost and Capacity](<../../../Architecture/Server Cost and Capacity — Free Safety Copy vs Plus Sync.md>): a free lane for anonymous copies | The free lane serves **free accounts only**. Cost goes down: no-account users cost us nothing |

---

## 9. Limits of this evidence

- **Keyword screen.** Reviews that describe these moments in other words were missed. "Choose where" is rare, which could partly be because the pattern is narrow; the 110 automatic-backup requests that name no place, or name only the one they own, point the same way.
- **One app dominates some rows** (Loop: 67 of 110 automatic-backup requests, all 7 "move worked"). Disclosed in §2.
- **No review tests this exact flow.** The flow is reasoned from first principles, the evidence above and the platform facts. The 14-day Android card (§4.2) is the least certain choice; it can be dropped without breaking anything else.

---

## Appendix — reviews cited

<!-- APPENDIX -->
21 reviews cited. Ref = store letter + app number + line index in that app's `reviews.jsonl`. All 264 coded reviews: [`coded.json`](<Backup Experience Evidence/coded.json>).

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#53141` | `10692256226` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2023-12-14 | 4★ | WANT_TRANSFER |
| `A10#29286` | `13159004777` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-09-19 | 5★ | AUTO_BACKUP_WANT |
| `A10#39038` | `11882875394` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2024-10-28 | 2★ | AUTO_BACKUP_WANT, ACCOUNT_NAMED |
| `A24#28960` | `10012255705` | App Store (us) | 24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help | 2023-06-08 | 3★ | AUTO_BACKUP_WANT, LEFT |
| `A76#576` | `12729140007` | App Store (ca) | 76. Way of Life - Habit Tracker - Build a better, stronger you | 2025-06-02 | 4★ | OWN_CLOUD_SYNC, BACKUP_AS_SYNC_PAIN |
| `P2#3087` | `4ad4eb96-420d-4360-b4cd-684bdc0b573d` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2025-04-14 | 3★ | BACKUP_AS_SYNC_PAIN, ACCOUNT_NAMED |
| `P2#3497` | `15886fc1-a752-4bd3-8bae-3f59ea4078ed` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2025-01-23 | 4★ | BACKUP_AS_SYNC_PAIN, BACKUP_FREQ |
| `P2#12061` | `d7ddcba1-a1fa-42e1-8ae1-1f4ecf7470ee` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2021-01-11 | 4★ | ACCOUNT_NAMED, WANT_TRANSFER |
| `P2#12079` | `69560eb3-476b-4e72-a643-cd5960d24841` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2021-01-07 | 4★ | OWN_CLOUD_NAMED, CHOOSE_WHERE |
| `P3#2531` | `a129192d-9611-4b99-9adf-e1ba9de25897` | Play Store (en) | 3. Loop Habit Tracker | 2025-10-21 | 5★ | AUTO_BACKUP_WANT, OWN_CLOUD_NAMED |
| `P3#6989` | `9f31dd44-ba1c-4669-a415-2e12891a8e6a` | Play Store (en) | 3. Loop Habit Tracker | 2022-01-24 | 5★ | AUTO_BACKUP_WANT, PRIVACY_OFFLINE_OK |
| `P3#10745` | `88b65eb4-6f9b-4ede-a234-48a8ee09ea77` | Play Store (en) | 3. Loop Habit Tracker | 2019-10-27 | 5★ | NR |
| `P3#10847` | `81b45c92-fb55-4dbd-bcde-df70f0a193c5` | Play Store (en) | 3. Loop Habit Tracker | 2019-10-02 | 5★ | MOVE_WORKS |
| `P3#13435` | `a9fb2010-9ec1-487c-9fd7-1ee02136c969` | Play Store (en) | 3. Loop Habit Tracker | 2018-02-04 | 2★ | MOVE_FAILS |
| `P3#14335` | `a80cb37a-509e-4958-b412-58c0961dee39` | Play Store (en) | 3. Loop Habit Tracker | 2017-07-25 | 4★ | AUTO_BACKUP_WANT, ACCOUNT_NAMED, OWN_CLOUD_NAMED |
| `P3#14530` | `673040cb-76a2-4ca3-a0df-f1dd4fd50464` | Play Store (en) | 3. Loop Habit Tracker | 2017-06-19 | 2★ | MOVE_FAILS |
| `P3#15260` | `f334e0b5-5504-4d94-8b1e-f3e77c06fac4` | Play Store (en) | 3. Loop Habit Tracker | 2017-01-23 | 4★ | AUTO_BACKUP_WANT, ACCOUNT_NAMED |
| `P3#20156` | `e3f65b9b-82fd-4e7c-83fb-5833d0e676af` | Play Store (nl) | 3. Loop Habit Tracker | 2017-06-10 | 1★ | MOVE_FAILS |
| `P69#245` | `a9b336b2-8f13-4228-a367-f958e56dd2a9` | Play Store (en) | 69. EZ Habit - simple habit tracker | 2022-06-23 | 5★ | AUTO_BACKUP_WANT, OWN_CLOUD_NAMED |
| `P70#174` | `e5bc4555-7d2b-43d4-b66c-9fb3ccbe261f` | Play Store (en) | 70. everyday Habit Tracker | 2025-01-13 | 3★ | AUTO_SYNC_PRAISE |
| `P110#1454` | `2b76a608-28c2-43ca-9698-1e08502f4fef` | Play Store (en) | 110. Habit Tracker Unlimited | 2024-09-07 | 4★ | AUTO_BACKUP_WANT, OWN_CLOUD_NAMED, CHOOSE_WHERE |
