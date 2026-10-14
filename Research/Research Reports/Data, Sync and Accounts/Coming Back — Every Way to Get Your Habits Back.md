# Coming Back — Every Way to Get Your Habits Back

Written by Claude (Claude Code), 14 October 2026, for the Android onboarding's **"I've used it before"** door (Figma
section "Onboarding: coming back", `1549:2`). The user asked for "every possible flow" back, from the reviews, for the
model decided the same day (Rulebook D15, D16; Current Work 110):

- habits live only on the phone and in the person's own Google Drive (or iCloud on iPhone and iPad);
- an optional Often Enough account (Sign in with Google or Apple) holds only the purchase, the family and **which
  cloud account holds the habits**;
- free syncs one device at a time;
- a **move code** sends a locked copy once through our server, deleted on pickup or after 24 hours;
- a backup file still works anywhere.

Evidence labels: **users show** (reviews), **platform fact** (Android's or Google's own behaviour), **reasoned** (first
principles, no direct review evidence). Competitors appear only through their own users' reviews.

## The answer

1. **Sign in first; the other ways below** (revised the same day, after the user's review: "if they have an account,
   this is how they think … signing in is what is intuitive"). Screen 1 is **Welcome back**, "Sign in to get your
   habits back", with **Continue with Google** and **Continue with Apple**, then **Other ways**: the old phone (a
   code) and a backup file. Signing in lets the account do the finding: it remembers which Google Drive or iCloud
   holds the habits (by that cloud account's private ID) and the app goes there by itself. Continue with Google also
   serves someone with no account, by looking in that Google account's Drive, where free backups go. Users show:
   Drive backup is the most requested thing here (75 reviews, 4.25★), and an account that "carried everything over"
   is the most praised way across phones (15 reviews, 4.53★). (The first version asked "where are your habits?" with
   four equal answers; that question only helps someone without an account.)
2. **Say what was found before bringing anything back.** The angriest themes are the wrong account (18 reviews,
   1.89★) and getting an old copy back (8 reviews, 1.88★). The app shows which account it looked in and what it found
   (how many habits, from when, from which phone), and always takes the newest copy.
3. **When the habits are somewhere this phone can't reach, say so plainly and give the way across.** Nothing in this
   Google account: say so and offer **Choose another Google account**, never naming another account (corrected 14 Oct, see
   below). Habits in iCloud: say they're on the iPhone, and offer the
   move code. Users show: switching between iPhone and Android is where paid access and data are lost
   (32 reviews 2.00★; 18 reviews 2.17★).
4. **The move code is a secondary door, not the main one.** Almost nobody asks for a phone-to-phone transfer
   (1 review here; the 28 Sep study found 5 for "the move worked"). It's for the case nothing else covers: an
   iPhone on iCloud moving to Android, or anyone without an account who still has the old phone (reasoned).
5. **Plus never needs a separate restore.** On the same Google account, Google Play brings it back by itself
   (platform fact); across stores, signing in does (D16). Users show: paid access not following is the largest
   cross-platform complaint here (32 of 102 cross-platform reviews).

## 1. How the evidence was gathered

- **Corpus:** every review in the three local corpora, **1,487,223 reviews** (App Store and Play Store habit and
  routine apps, and Apple's, Google's, Microsoft's and Samsung's own apps).
- **Scan** ([`scan.py`](<Coming Back Evidence/scan.py>)), six patterns for what the 9 Oct study didn't cover:
  - Google Drive with restore, backup or account;
  - a different Google, Apple or email account;
  - a lost, broken or dead old phone;
  - moving by code, QR, nearby or Wi-Fi;
  - an old or chosen backup;
  - switching between iPhone and Android.

  **693 candidates**, after leaving out 36 already read on 9 Oct.
- **Reading:** all 693 read one by one and hand-coded into 20 themes, one per review
  ([codebook](<Coming Back Evidence/CODEBOOK.md>), map in [`cls/`](<Coming Back Evidence/cls>)).
  [`check.py`](<Coming Back Evidence/check.py>) confirms every candidate is coded exactly once, every code is
  known, and every quoted fragment appears in its review. **261 are on topic** (432 off topic: mostly Samsung
  watches and Google's apps syncing documents, which match "sync" and "Android" without being about coming back).
- **Reused, not re-read:**
  - [Onboarding for New and Returning People](<../Habit Creation/Onboarding for New and Returning People — Research and Proposed Flow.md>)
    (9 Oct): 1,078 on-topic reviews about signing back in, finding nothing, and the first screen.
  - [QR Move, Apple Health and Launch Operations](<QR Move, Apple Health and Launch Operations — Final Backlog.md>)
    (28 Sep): 49 on-topic reviews about moves between platforms.

**Concentration, disclosed.**
- One routine app supplies 18 of the 32 "paid access didn't follow" reviews, on its two listings. The same complaint
  appears in 9 other apps.
- Samsung Health supplies 8 of the 18 "data lost switching platforms" reviews.
- Counts are reviews, not people. ★ is the reviews' average.

## 2. What the reviews say

| Theme | Reviews | Apps | Mean ★ | 1★ |
|---|---|---|---|---|
| Asks for automatic Google Drive backup or sync | 75 | 12 | 4.25 | 1% |
| **A purchase didn't follow to the other platform** | **32** | 11 | **2.00** | 59% |
| iPhone and Android copies don't sync | 23 | 14 | 2.04 | 48% |
| Phone lost or broken, nothing backed up by itself | 21 | 11 | 3.57 | 19% |
| **A different Google, Apple or email account: nothing found** | **18** | 13 | **1.89** | 56% |
| Data lost switching between iPhone and Android | 18 | 7 | 2.17 | 44% |
| **An account carried everything across platforms** | **15** | 8 | **4.53** | 0% |
| Wants the app on both platforms | 14 | 8 | 4.29 | 7% |
| Moving by export and import, by hand | 10 | 6 | 4.40 | 0% |
| Praises Google Drive backup being there | 8 | 5 | 4.75 | 0% |
| **An old backup came back, or had to choose one** | **8** | 6 | **1.88** | 62% |
| A Google Drive backup or restore failed | 7 | 6 | 3.00 | 29% |
| A purchase didn't come back (same platform, another account) | 5 | 5 | 3.40 | 20% |
| Phone lost, but the habits came back | 3 | 3 | 5.00 | 0% |
| Signing in on a device with data: mixed or overwritten | 2 | 2 | 3.00 | 50% |
| Asks for a phone-to-phone code or QR | 1 | 1 | 4.00 | 0% |
| Moved through Google Drive | 1 | 1 | 5.00 | 0% |

### Google Drive is where Android people expect their habits to be

Users show this as a request far more than a complaint: 75 ask for it (4.25★), 8 praise it (4.75★).
- "automatic daily backups to Google Drive, like Truecaller and WhatsApp" (Loop, Play, 5★, `P3#2596`).
- "not requiring to register to another online service" (HabitNow, Play, 5★, `P2#13093`).
- When it's there: "Has automatic Google Drive backups" (Goal & Habit Tracker, Play, 5★, `P65#2822`).

When the Drive way back failed, people couldn't find their way in (7 reviews, 3.00★):
- "I could not restore the same task list on Google drive from another Android phone" (`P110#3245`).
- "I could not import data from a back up file to new android 14 phone" (`P65#2552`).

For the flow: a returning Android person thinks "my Google account", not "a backup". The way back should be named
for the account they know, and should look in Drive by itself (reasoned from the above).

### The wrong account is the most painful way to "lose" everything

18 reviews, 1.89★, 56% 1★. Built-in apps show it as often as habit apps (9 of 18), so it's how people's phones work,
not one app's bug.
- "Transferring to a new Google account meant that I lost all my previous data (2yrs)" (Habit Tracker, Play, 1★,
  `P24#1946`).
- "it keeps trying to log me in to a different Gmail account" (Me+, Play, 1★, `P4#25885`).
- "all my info was in the old iCloud email account" (Microsoft To Do, 1★, `N10#10273`).
- "I thought all my notes were gone when I opened the app today" (Notes, 3★, `N3#24131`: the default account had
  changed).

This is why the account remembers which cloud account holds the habits (D16). **Correction, 14 Oct (the user's
review):** the first design had a "wrong account" screen naming the right one (`l•••••@gmail.com`). In the common case
here, someone picking a different Google account than last time, the app can't know the other account at all: it
only learns about the account just picked. And naming another account "might also be a security issue". So the app
never names another account: it says **"No habits found. Choose another Google account."**, and compares the account's
private ID after the pick. A Drive backed up to a different Google account still works: the permission belongs to
that Drive's account, so choosing it (or adding it in Google's own chooser) brings the habits back with no permission
screen.

**A separate "Google Drive account" choice? No** (checked 14 Oct, at the user's request). A second scan of all
1,487,223 reviews for backups or restores in a different, second or wrong Google account found 9 matches, 6 already
read above and 3 off topic; in all the reading for this report, no review separates the account someone signs in with
from the account their backups are in. People say "my Google account". So the app offers one choice, **Choose another
Google account**, and looks for both an account and a Drive backup in whichever they pick (reasoned from the absence of
evidence and from first principles: two near-identical choices make people guess). Evidence:
[`Coming Back Evidence/drive-account-scan.py`](<Coming Back Evidence/drive-account-scan.py>).

### An old copy is nearly as bad as no copy

8 reviews, 1.88★, 62% 1★.
- "it restored a two day old backup resulting in my chains being broken" (Fabulous, 3★, `A24#27585`).
- "had to restore my streaks from a back up from 12 days ago" (Streaks, 1★, `A23#397`).
- "the latest back up was a month ago" (Streaks, 1★, `A23#2054`).

For the flow: show the copy's date and its counts before bringing it back, and always take the newest. Never offer
a list of backups to choose from at onboarding (reasoned: people can't tell copies apart, and an older one breaks
streaks).

### Switching between iPhone and Android loses the purchase first, then the data

- **Paid access didn't follow:** 32 reviews, 2.00★, 59% 1★.
  - "You'll be charged twice if you switch phones" (Fabulous, Play, 1★, `P12#67558`).
  - "the account cannot be transferred from one OS to another yet" (`P12#66741`).
  - "accounts and purchases are not connected or synced in any way" (Productive, 2★, `A13#12339`).
- **The data didn't follow:** 18 reviews, 2.17★.
  - "I can't even get my backup from the IOS version to restore on the Android version" (Way of Life, Play, 3★,
    `P130#354`).
  - "it didn’t save any of my progress and I had almost 2 years streak" (Finch, 5★, `A10#20322`).
- **When an account carries both, people say so**: 15 reviews, 4.53★, no 1★.
  - "Since I have a gmail account all my notes were carried over when placing it on my iPhone" (Google Keep, 5★,
    `N7#11523`).
  - "I purchased lifetime subscription works on both" (Habitify, Play, 5★, `P37#576`).

### A lost phone with no backup: the reason Drive backup is automatic

21 reviews (3.57★: many still like the app, and say they lost everything anyway).
- "my old phone broke and I couldn’t get back my progress and it really demotivated me" (Habit, 5★, `A20#1287`).
- "I had to pay 60$ at a phone repair shop to get the screen on my broken phone fixed so that I can export the
  app's data" (HabitNow, Play, 5★, `P2#10704`).

For the flow: when the old phone is gone, only the cloud and the account can help. So the main door must not
assume the old phone is at hand. The move code comes second.

### Phone-to-phone codes: almost nobody asks

One review asks for a QR transfer (`A1#49842`, between an iPhone and an iPad, from someone without iCloud). The
28 Sep study found 5 reviews where "the move worked" and 2 where moving was hard. The code is useful for a real
gap (an iPhone on iCloud moving to Android, someone with no account), so it stays, but as the third door (reasoned).

## 3. Platform facts the flow relies on

- **Google's account choice and Drive permission are Android's own screens** (`2`, `2.1`): Google's account chooser
  sheet, then its consent screen for `drive.appdata`. We don't redraw them.
- **A purchase on Google Play comes back on the same Google account by itself** (Play Billing's query of past
  purchases), with no restore button needed. Across stores, the account carries it (D16).
- **Android's own backup can bring the app's data back during phone setup** (Auto Backup, D16). Then the app opens
  with habits already there and never shows onboarding; the free one-device check (D4) asks "Move here?" if another
  phone was the syncing one.
- **The file picker is Android's own** (`5`): the person picks the file from Drive, Downloads or wherever they
  saved it.
- **Google Drive's permission is asked once per Google account**, not per phone: Google keeps it in the account, so
  another phone signed in to the same account gets access with no screen (Android's AuthorizationClient guide). An
  iPhone using Google Drive should too (the same app registered with Google); our Drive test confirms it.
- **iCloud asks no permission at all.** A device signed in to iCloud can use the app's own iCloud space (on unless the
  person turns it off in Settings). On an iPhone or iPad with the same Apple Account the habits come back when the
  app opens, with no screen (D14); with a different Apple Account the app can tell (CloudKit's user record ID against
  the one the account remembers) and says so, since an app can't switch iCloud accounts.
- **An iCloud copy can't be read from Android**: the only ways across are the iPhone switching to Google Drive, a
  move code from the iPhone, or a backup file.

## 3a. Moving with a code: QR or 6 digits (added 14 Oct 2026)

The user rejected a 12-character code typed into one field ("no one enters hyphen in between … terrible experience")
and asked whether a short code is a production method. It is, when both devices are online at once:

- **Apple's Move to iOS** (Android to iPhone): the iPhone shows a 6-digit code; the person types it on the Android
  phone. **TV and console sign-in** (Google, Microsoft, GitHub): a short code typed on the phone, short-lived, limited
  tries (OAuth device flow, RFC 8628). **Magic Wormhole**: short codes with **SPAKE2**, so each code allows one guess
  and the code becomes a strong key (Tahoe-LAFS documentation). **Signal** moves an account between iPhones by
  scanning a QR code, with the old phone confirming.
- In each, the code **pairs two live devices**; none uses a short code as the only key to a copy left on a server,
  which anyone holding the copy could break by trying every code.
- **Typed codes:** one box per character, moving on by itself, paste filling every box, checking itself when full,
  4–8 characters (UXCel, Nord, UX4G component guidance; not controlled studies).

**Decided:** the old phone's Move to a new phone page shows a **QR code and 6 digits**; the new phone **scans** (Google
code scanner on Android, no camera permission) or **types the 6 digits** (the user: scanning can be awkward on a
tablet or elsewhere). The phones run SPAKE2 through a Cloudflare Worker relay, so the key never reaches us; one
guess per code, 10 minutes. Rulebook D15.

## 4. The flow

> **Revised 14 Oct 2026, later the same day (the user's decisions; Rulebook D16):** free people have no account at all;
> the account is for Plus, offered after buying. Screen 1 is now **With your Plus account** (Continue with Google,
> Continue with Apple: these always bring Plus back) and **Without an account** (Google Drive, Your old phone, A
> backup file), and the flow has six rows to match: 2 Google and 3 Apple (Found / In iCloud with the code / No account
> found), 4 Google Drive (a free person's backup: Found / No habits found), 5 Old phone (the code carries Plus too), 6
> Backup file. The table below records the earlier, single-screen version.

Figma: section **Onboarding: coming back** (`1549:2`), arranged like the habit form's flow:
- the first screen at the top;
- one row per way back;
- a step's outcomes stacked beside it;
- arrows between them.

Screens already drawn are kept where they fit (to redesign later); new screens are empty frames named for their job.

| # | Screen | Why |
|---|---|---|
| **1** | **Welcome back** (from Welcome's "I've used it before"; `1549:3`): Continue with Google, Continue with Apple; Other ways: your old phone, a backup file | Signing in is how people with an account expect to come back (9 Oct study: 29 + 43 reviews); returning people need their door before any setup (62 reviews, 1.56★) |
| **2** | **Continue with Google** → choose an account (`1549:38`) → Looking for your habits (`1549:128`); **Allow Google Drive (`1549:97`) only if this account hasn't allowed it before** | The main door on Android (§2 Drive; account praise) |
| 2.3 | Found: your habits are back (summary: how many, from when, which phone, Plus) → Bringing back → Today; Start fresh instead → Start fresh? (dialog: the habits stay in your Google Drive) | Show the copy before restoring; the newest copy only (old-backup reviews, 1.88★); never start fresh without saying where the habits stay |
| 2.4 | **No habits found. Choose another Google account** (the main button), or another way (Apple, a code, a file), or Start fresh (no dialog: nothing to leave behind) | Wrong account, 1.89★; the 9 Oct study: "signed in and found nothing", 100 reviews, 1.97★; never a blank Today, never another account's name |
| 2.6 | **In another Google account** (the person's own record says the backups are in a different Google account): "One more step." "Your habits are backed up to a different Google account. Choose it to bring them back." → Google's chooser → the IDs are compared → 2.2. No account is named | The app knows this from the record, so saying it is honest; naming it isn't needed. Apple row's 3.2 is the same screen |
| 2.5 | In iCloud (the account says they're on an iPhone): use a code from the iPhone | Cross-platform data loss, 2.17★ |
| **3** | **Continue with Apple** → Looking for your habits → in Google Drive (one tap: Continue with Google for that exact account, then 2.2), in iCloud (use a code from the iPhone), or no account for this Apple ID | People who made their account on an iPhone (reasoned; Apple sign-in on Android is Apple's web sheet) |
| **4** | **Move from another phone**: Enter the code → Getting your habits → Found (summary) → Today; This code didn't work; and, on the old phone, Move to a new phone (shows the code) | The gap nothing else covers (§2 codes) |
| **5** | **Restore a backup file** → Android's file picker → This backup (its date, habits and logs) → Bringing back → Today; This file isn't a backup | Users show manual moves work but need clear steps (10 reviews, 4.40★) |

The old "Restore a backup" screen (Google Drive or a file) is kept beside the flow, marked as not in it: its two
choices are now rows 2 and 5.

**What every "found" screen says** (2.3, 4.2, 5.1), reasoned from the wrong-account and old-copy evidence:
- what came back ("31 habits · 929 logs"), and from when ("last synced today, 9:41, from a Pixel 7");
- which account it came from;
- Plus, if the person has it, or "Sign in to bring Plus" when it was bought on the other store.

**Start fresh is always one tap, and never deletes anything.** It says where the habits stay, so the person can come
back for them later (D3).

## 5. Decisions for the user

1. ~~The main door on Android~~ **Decided 14 Oct:** sign in first (Continue with Google, Continue with Apple), other
   ways below.
2. **The move code's direction:** the old phone shows the code and the new one types it (recommended: at onboarding
   the person is already on the new phone, and the old one may be an iPhone); or the new phone shows a QR the old
   one scans.
3. **Show what was found before bringing it back** (2.3, recommended), or bring it straight back and show the
   summary after.
4. **The old "Restore a backup" screen:** delete it, or keep it beside the flow as now.

## 6. Limits

- The scan's patterns are mostly English; non-English reviews are under-counted.
- The cross-platform themes are concentrated in one routine app (paid access) and Samsung Health (data), disclosed
  in §1.
- Habit-app reviewers rarely describe a good return, so the positive evidence (15 + 3 + 8) is smaller than the
  negative.
- The move code, the "found" summary and the wrong-account screen are reasoned from the evidence. They need checking
  on real phones: a reinstall, a new phone with the old one lost, an iPhone moving to Android, and two Google
  accounts on one phone (U9).
- The same flow is meant for the iPhone too (whatever is designed for one platform works the same on the other), with
  iCloud as a third place; this pass designs Android's.
