# Account and Backup Redesign

Written by Claude (Claude Code), 10 October 2026, at the user's request: the sidebar, the Account page and Backup &
Export are "okay but not good". The account must be easy to find without pushing anyone to make one; what it gives
must be clear; Backup & Export must show every way to keep, move and get back habits, for people without an account,
with a free account and with Plus. Current Work 76.

**Status: designed and reviewed with the user (10 Oct 2026); ready to build (§8). Not built.**
[Figma section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=950-309) (iPhone SE, 375 × 667,
light mode). Images in [`Images/`](Images/).

![All screens](<Images/0 All screens.png>)

## 1. The user's points

First pass (10 Oct 2026):
- [x] The account is easy to discover (onboarding doesn't make people create one), but never pushed.
- [x] Say clearly what an account gives. Facts from the research: free = backed up to the account, one device, no
      syncing between devices (a tablet can be the one device); Plus syncs devices.
- [x] Without an account an iPhone backs up to iCloud by default; people can choose Google Drive instead.
- [x] Improve Create Account and the signed-in Account page.
- [x] Backup & Export: export, **move to another device** (phone or tablet) by transfer code or backup file, and
      restore, matching onboarding's Move from another device and Restore a backup.

Review of the first pass (10 Oct 2026):
- [x] **Sidebar:** the account isn't the most important thing; don't put it at the top. Order by importance; keep it
      with Backup & Export and Privacy & Security, as before, or at the bottom.
- [x] **Account, not signed in, was confusing:** "Already backed up to iCloud" and then, suddenly, a list that
      included Plus. Why Plus? If something needs explaining, explain it. And the Continue buttons appeared without
      saying what they do.
- [x] **Backup & Export for someone with a free account, and for Plus:** missing.
- [x] Think from first principles about why people come to each screen.
- [x] **One Create an Account button** on the Account page; Continue with Apple / Google in a bottom sheet (the user,
      10 Oct 2026). Superseded the same day:
- [x] **"Something is wrong with the Account page"** (the user, 10 Oct 2026): it promoted instead of showing what
      people want; a returning person had to read a footnote to sign in. Research what users actually want to see
      (§4a) and rebuild: Sign In and Create Account as their own rows, each opening its sheet.
- [x] **From now on, every screen starts from "what do users actually want to see here?"**, answered from reviews
      and research (Rulebook W6).
- [x] **Backup & Export felt inconsistent** (the user, 10 Oct 2026): an account seemed to remove iCloud and Google
      Drive, Plus seemed to remove things, and "Add Another Device" led nowhere. Rebuilt: the same rows in every
      state (§4); Move to Another Device fits each plan, with Plus's sign-in steps drawn (5b, 5c); Restore when signed
      in (7b).
- [x] **Why back up to iCloud or Google Drive when signed in?** (the user, 10 Oct 2026). Reviews checked (§4): it
      serves no purpose and risks duplicates. Decided: one backup place at a time.
- [x] **Move to Another Device opens the transfer code directly**, like WhatsApp; no options screen, no Send a
      Backup File (it's in Export), no sign-in instructions (the user, 10 Oct 2026).
- [x] The user reviewed every screen (10 Oct 2026). Ready to build: §8.
- [ ] Then: the states of Move and Restore (sending, found, replace, done, problems), Backup & Export's problem
      states, dark mode and the larger iPhones; then the build spec.

## 2. Why people come to each screen (first principles)

| Screen | Why someone opens it | So it leads with |
|---|---|---|
| Sidebar | To go somewhere they use often: Today, Progress, their habits. Settings are occasional | Daily places first, settings by how often they matter, the account last among them |
| Account, not signed in | **Users show (§4a):** to sign in (returning, new phone) or to make an account; and whether their habits are safe without one | Who you are now (not signed in, where your habits are), then **Sign In** and **Create Account** as two plainly named rows, then two facts |
| Account, signed in | **Users show (§4a):** which account, what plan they have ("did I buy lifetime or yearly?"), whether it's working, how to get on another device, sign out, delete | Who you are, plan (Plus says lifetime), last backup or sync, devices with how to add one, then Sign Out and Delete |
| Backup & Export | "Am I safe?" first; then a job: a new phone, getting something back, a file to keep | Status and Back Up Now, then where it's kept, then the jobs, each named by its object |
| Move to Another Device | They have a new phone or tablet in hand and want the habits on it now | The transfer code at once (no choices), the three steps, and that the habits stay here too |
| Restore From a Backup | Something went wrong, or a reinstall | Where the backup is, then the warning that it replaces what's here, and the undo |

## 3. Facts the screens rely on (checked)

| Fact | Source |
|---|---|
| No account: backed up to the person's iCloud; nothing syncs; iPhone and iPad each keep their own copy | [Free Plan Backups](<../../../../Research/Research Reports/Data, Sync and Accounts/Free Plan Backups — iPhone and iPad, and a Backup That's Never a Day Behind.md>) §1–2 |
| Free account: backed up to the account (today also to iCloud beside it; that stops, §4), 7 daily copies kept, encrypted in transit and at rest; one device; **never syncs** | Free Plan Backups §1, §4; Backup & Export research §6 |
| Backed up **as you go** (not once a day), with or without an account | Free Plan Backups §7, recommendation B: **decided by the user, 10 Oct 2026** |
| Plus: every change syncs to every device; daily snapshots kept 90 days; no iCloud copy (one backup place at a time, §4) | Free Plan Backups §1; Backup & Export research §6 |
| Free covers one device, phone **or tablet** | Architecture 02 (1 Oct) |
| Google Drive as a backup place on iOS | **The user, 10 Oct 2026** (before: Android only, no Drive code on iOS) |
| Move by transfer code; restore from iCloud, Google Drive or a file | Onboarding wireframes R01, R04–R09 (Figma 835:503); the transfer code is built (Current Work 73.1, `DeviceTransfer.swift`: 8 characters, local network, nothing through the server); Google Drive isn't |
| Restore keeps an undo for 30 days | Rulebook D5 |
| "Restore" alone reads as Restore Purchases to many; name the object | Backup & Export research §2.3 |
| Never "our server" or "we"; places named as people name them | Backup & Export research §2.4 |

## 4a. What people want on the Account screen (fresh review scan, 10 Oct 2026)

**Users show.** All 1,238,784 App Store and Play reviews of habit and routine apps in the repo, scanned with five
patterns ([`Evidence/scan.py`](Evidence/scan.py)); the on-topic matches read by hand (a reading of the filtered
matches, not a full coded study; counts are approximate). Earlier, fuller evidence: [Backup & Export research,
Review Evidence B4 and B8](<../../../../Research/Research Reports/Data, Sync and Accounts/Backup & Export Screen Evidence/Review Evidence.md>).

| What people want | Evidence | Examples |
|---|---|---|
| **A way to sign in that says "sign in / log in"** | About 25 reviews, mostly 1–3★, say there was "no login option" or they couldn't find where to sign in, often on a new phone; several saw only sign-up or register | "There is no login option just the sign up one" (Life Reset, 1★, `12766875691`); "Literally no login option, kept asking me to Register" (Habit Tracker, 1★, `24d0a3a3-25bd-406d-b9db-d7bc05f07752`); "Where is Log In or Register option? Cant find anywhere." (Habit Tracker, 1★, `6586401791`); "How do I login? I can't see login button?!" (Habit Tracker, 1★, `c24e6c0e-93b8-49ff-8cc9-8ff98ae51517`); earlier study: 11 couldn't find where to sign in on a new phone (B4) |
| **Returning people want to just sign in**, not be treated as new | 4 reviews | "I just want to log in people, not answer everything all over again" (Fabulous, 4★, `8944276113`); "Why didn't it ask me that before this quiz so I can just jump back in?" (Fabulous, 1★, `9cfc961f-cfe4-4c9a-8d55-9e479161f91b`) |
| **To see their plan** | Several | "what plan do I have, when is my next billing date" (Me+, 4★, `79d4cf46-9834-48e8-86f7-96594767ff4a`); "Did I buy a lifetime or yearly subscription?" (Me+, 2★, `11495117139`) |
| **To see who they are and log in or out** | Several | "there’s no profile page. It doesn’t show my name or information … How do I even log in and out? How do I connect to my account on another device?" (Me+, 3★, `10312885270`) |
| **To know what an account really does** (they assume sync or restore) | 3 of 7 "why an account" reviews | "I thought the point of having an account is sync, but..." (Fabulous, 4★, `d5d15008-3843-4aa4-9763-1ea6deeef46c`); "What’s the point of making an account if when u get a new phone all your progress is lost?" (Fabulous, 3★, `6576967437`) |
| **Not to be made to have one** | 3 of 7; 180 "forced to create" matches overall (not read here) | "Why do I have to make an account? just let me use the app without signing up" (Hevy, 1★, `8c6590ad-835b-4854-a8b7-48ae86e00d45`) |

Nobody asks for a list of an account's benefits. So the signed-out page shows **state, the two actions by their own
names, and two facts**; the signed-in page shows **who, plan, status, devices, sign out, delete**.

## 4. The screens

### 1 · Sidebar

<img src="Images/1 Sidebar.png" width="300">

- **Account goes back into the data group, last:** Backup & Export · Privacy & Security · **Account**. Order by
  importance: daily places first (Today, Progress, Habits, Tasks), then how the app works (Times of Day … Appearance),
  then your data (backup matters to everyone; privacy to many; an account only to those who want one), then Plus, then
  Help and About.
- Not signed in: just **Account**, no value (no "Not Signed In", which read like a warning). Signed in: the plan as
  its value, **Free** or **Plus**.

### 2 · Account, not signed in

<img src="Images/2 Account — not signed in.png" width="300">

Rebuilt 10 Oct 2026 after the user's review ("what users actually want to see, not what we want to promote") and the
review scan in §4a:

1. **Who you are now:** a grey avatar, **Not signed in**, *Your habits are on this iPhone and backed up to iCloud.*
   (*…to Google Drive* if chosen; *Your habits are only on this iPhone* if there's no backup place.) Same place as the
   signed-in page's "Signed in with Apple", so the top of the page always answers "who am I here?".
2. **Sign In** › and **Create Account** › as two rows. Returning people look for the words *sign in / log in*; a page
   that only says create or register reads to them as "no login option" (§4a). Two plain rows, no filled button: the
   page informs, it doesn't push.
3. Footer, facts only: *With an account, your habits are backed up to it as you go, and come back when you sign in on
   a new phone or tablet.* / *A free account is for one device. Syncing several devices is part of Plus.* (People
   assume an account means sync or a guaranteed restore and are angry when it isn't: §4a, and Free Plan Backups §3.)

Gone: the "What an account adds" list, the single Create an Account button and its "the same button signs you in"
note.

### 2b · Sign In and 2c · Create Account (bottom sheets)

<img src="Images/2b Sign In — sheet.png" width="300"> <img src="Images/2c Create Account — sheet.png" width="300">

- Each row opens its own bottom sheet (fits its content; ✕ closes, accessible name Cancel), with **Continue with
  Apple** (Apple's button) and **Continue with Google** (Google's button).
- **Sign In:** *Use the same way you signed in before.* Footer: *No account found? You'll be asked before a new one is
  made.* (D3: an unknown sign-in never creates an account silently.)
- **Create Account:** *Choose how you'll sign in. Already have an account? You'll be signed in to it.* Footer: *Used
  only to back up your habits. Never sold, never for ads.*
- With Apple and Google both buttons do the same thing underneath; the two titles exist because people come with two
  different intentions and look for their own word.
- A sheet, not an alert: the person chose to start this, and the branded buttons are custom content.

### 3 · Account, signed in (free) and 3b · Plus

<img src="Images/3 Account — signed in, free.png" width="300"> <img src="Images/3b Account — signed in, Plus.png" width="300">

- **Signed in with Apple** / *Email hidden by Apple* (or the Google email): which account, first.
- **Plan: Free ›** or **Plus (lifetime) ›** (Plus is a one-time purchase, Architecture 02; reviewers ask "did I buy a
  lifetime or yearly…?"). Free: **Last Backup**, footer *Backed up as you go, with the last 7 days kept.* Plus: **Last
  Synced**, footer *Every change syncs to all your devices.*
- **Devices**, with how to get on another one right under it: free *A free account is for one device. To use a new
  phone or tablet instead, sign in on it.*; Plus *To add a device, sign in on it with this account.* (Reviewers ask
  "how do I connect to my account on another device?")
- **Sign Out** (*Your habits stay on this iPhone.*) and **Delete Account…** (red text, its own confirmation page as
  built).

### 4 · Backup & Export: no account, 4b · free account, 4c · Plus

<img src="Images/4 Backup & Export — not signed in.png" width="260"> <img src="Images/4b Backup & Export — free account.png" width="260"> <img src="Images/4c Backup & Export — Plus.png" width="260">

**One backup place at a time** (the user, 10 Oct 2026, after asking why a synced or signed-in person would need an
iCloud or Google Drive copy too):

- **No account:** the backup lives in **iCloud or Google Drive**, the person's choice.
- **Signed in (free or Plus):** the backup lives in **the account**. iCloud and Google Drive aren't written to.
- **Signing out** goes back to iCloud or Google Drive.
- **The moment someone creates an account or signs in, the app backs up to the account at once**, then stops backing
  up to iCloud or Google Drive (the user, 10 Oct 2026). Data safety (D4): the iCloud / Google Drive backups stop only
  after the account copy has been read back and checked; until then both keep going. The old iCloud or Google Drive
  copy is left where it is, never deleted.

Why (users show, fresh scan [`Evidence/scan3.py`](Evidence/scan3.py), every match read): almost nobody who syncs asks
for a second copy elsewhere (6 reviews come near it, and they treat sync as the backup: "It syncs all tasks to one's
Google account (Better than a local backup imho)", To Do List, 5★, `12aafc1e-44bf-4f8a-a856-0e78bbefa92e`); what goes
wrong is too many copies: duplicates (13 reviews, 3.15★, e.g. "No matter what I do, duplicates appear on regular
basis", Streaks, 2★, `8591937731`) and one device overwriting another (2 reviews, 1.5★). Reasoned: with an account,
its daily copies (7 days free, 90 days Plus) already undo a mistake, and Save a Backup File covers the account itself
failing; an iCloud file per device would add nothing but more look-alike copies in Restore.
**Today's build:** Plus already writes no iCloud copy; a free account writes one beside the account copy. That stops.

| Part | No account (4) | Free account (4b) | Plus (4c) |
|---|---|---|---|
| **Status** | **Backed up** · *Today 9:14 · iCloud* | **Backed up** · *Just now · Your account* | **Backed up and in sync** · *Just now · Your account · 2 devices* |
| | **Back Up Now** | **Back Up Now** | **Back Up Now** |
| **Backed up to** | **iCloud** ✓ / **Google Drive** (one choice, iCloud by default), *Backed up automatically as you go, to the one you choose.* Then **Your Account ›** · *Not signed in*, *Optional. If you sign in, your habits are backed up to your account instead.* | **Your Account ›** · *Free · Signed in with Apple*, *Backed up as you go, with the last 7 days kept. iCloud and Google Drive are used only when you're not signed in.* | **Your Account ›** · *Plus · Keeps your devices in sync*, *Keeps every device in sync, with a copy of each day for 90 days. iCloud and Google Drive are used only when you're not signed in.* |
| **Move and restore** (same in all) | **Move to Another Device** (*A new phone or tablet*) · **Restore From a Backup** | the same | the same |
| **Export** (same in all) | Save a Backup File · Export a Spreadsheet (CSV) | the same | the same |
| **Last** | **Erase All My Data…** (red, asks first, offers a file first) | — (Delete Account is on the Account page) | — |

- **Order (the user, 10 Oct 2026):** the place the habits are actually backed up comes first, under the status:
  iCloud / Google Drive without an account (the account row sits quietly below, worded as an option); the account
  when signed in. The page says where the backup goes and, when signed in, why iCloud and Google Drive aren't there,
  so nothing seems to vanish without a reason.
- **Your Account ›** (every version) opens the same Account page as the sidebar's Account row (screens 2, 3, 3b),
  pushed on top of Backup & Export, so Back returns here.
- Choosing Google Drive asks for Google's permission (Drive access only; it never creates an app account).
- On the SE these pages scroll; the dashed line in the images is where the SE screen ends.

### 5 · Move to Another Device

<img src="Images/5 Move to Another Device.png" width="300">

**Tapping Move to Another Device opens the transfer code straight away**, the same for everyone (the user, 10 Oct
2026, "like WhatsApp": no screen of options first). Sending a backup file is already in Export, and signing in on the
other device needs no instructions, so neither is offered here.

- Title **Move to Another Device**. Three numbered steps: **Install Often Enough on the other device** (the name stays
  here on purpose: it's what people search for in the App Store) · **Choose I've used it before, then Move from
  another device** (onboarding R01's words) · **Enter this code**.
- The code, large. **K7QM 4X2P is an example**: its length and format are the transfer service's.
- **Waiting for the other device…** under it, then *Keep this screen open until your habits arrive on the other
  device. They stay on this device too.* No expiry is promised until the service has one. Then *Sending your
  habits…* and *Done*, as onboarding R08 (not drawn).
- **For whoever builds it:** with an account, the new device should end up signed in to the same account after the
  transfer (Plus: it then syncs), so moving never leaves the account behind. To decide with the transfer service.

### 6 · Restore From a Backup: no account, 6b · free account, 6c · Plus

<img src="Images/6 Restore From a Backup.png" width="260"> <img src="Images/6b Restore — free account.png" width="260"> <img src="Images/6c Restore — Plus.png" width="260">

- *Where is your backup stored?* No account (6): **iCloud** · **Google Drive** · **Backup File**, with onboarding
  R04's lines. Signed in (6b): **Your Account** (free *Any of the last 7 days*; Plus *Any day in the last 90 days*) ·
  **Backup File**. iCloud and Google Drive aren't shown when signed in: the account is the only backup place then, and
  everything was copied to it the moment the person signed in (below). A backup file can always be opened.
- **Plus keeps Restore (6c)** (decided with the user, 10 Oct 2026): sync copies a mistake to every device within
  seconds (a wrong delete, a bad import, a bug), so the account's daily copies are the only way back. Users show it:
  "all my tasks were erased on both phones" (To Do List, 1★, `c24c439d-f3d5-453d-bcbf-8b75e08983ac`). The server
  already keeps them (Architecture 03: nightly snapshots, 30-day point-in-time recovery). Plus's footer: *Restoring
  replaces your habits on all your devices, since they stay in sync. You can undo it for 30 days.* The confirmation
  must say the same before it replaces anything.
- Footer (no account, free): *Restoring replaces the habits on this iPhone. You can undo it for 30 days.*
- Found, replace-confirmation and loading reuse onboarding's R05, R06, R12 and R09.

## 5. Checked against design guidance (10 Oct 2026)

| Source | What it says | Here |
|---|---|---|
| Apple HIG, Sheets / Alerts / Action sheets ([mirror of Apple's text](https://glama.ai/mcp/servers/@tmaasen/apple-dev-mcp/blob/b82f0efe2115dc4539c83a2374a714a84aeb350a/content/universal/sheets.md)) | A sheet for a short task that needs custom content; an alert for something unexpected that needs an answer; swipe-down dismisses a sheet; a grabber when it can be resized | 2b is a sheet (branded sign-in buttons are custom content; swiping down cancels). App Lock's "Did you change Face ID?" stays an alert |
| Sign in with Apple, HIG (secondhand: [summary](https://en.wikipedia.org/wiki/Sign_in_with_Apple), [forum](https://developer.apple.com/forums/thread/672570)) | Use Apple's own button and titles ("Continue with Apple"); black or white only; at least as prominent as other sign-in options | Same size as Google's, above Google's. **Build with `SignInWithAppleButton`**, never a drawn copy |
| [Sign in with Google branding](https://developers.google.com/identity/branding-guidelines?authuser=0), [iOS SDK](https://developers.google.com/identity/sign-in/ios/sign-in) | Required for app verification: the standard multicolour "G", "Continue with Google", at least as prominent as other options; use the SDK button | The drawn "G" is a placeholder. **Build with `GoogleSignInButton`** (light scheme, standard style), sized like Apple's |
| [Apple: offering account deletion](https://developer.apple.com/support/offering-account-deletion-in-your-app) | Deletion easy to find, in the app's account settings; deactivating isn't enough | Delete Account… on the Account page (3, 3b), as built |
| [GOV.UK Design System: create accounts](https://design-system.service.gov.uk/patterns/create-accounts) | Don't require an account when the service works without one; accounts are a barrier; let people do as much as possible first | No account needed anywhere; the Account page opens with "An account is optional" |
| NN/g, progressive disclosure (used for App Lock too) | Common things first, detail when it matters | One button on the page, the sign-in choices only in the sheet; Move and Restore one level down |
| Nielsen's heuristics: visibility of status, error prevention, consistency | Show what's happening; warn before loss; same words for the same thing | Status first on Backup & Export; "Waiting for the other device…"; Restore warns and offers 30-day undo; one "Backed up to" header across all three Backup & Export versions |

Changed after this check: "Back up to" became "Backed up to" on screen 4 (one header everywhere); Move says the habits
stay on this device; Transfer Code shows it's waiting; the Google "G" is Google blue as a reminder that the real button
is Google's (SDK), and Apple's is Apple's.

## 6. Words

| Always | Never |
|---|---|
| Account, Your Account | "Not Signed In" as a menu value; "our server", "we" |
| Backed up as you go | "nightly" alone (the daily copies are history, not how often it backs up) |
| A second copy / Extra Copy | backup (alone) for the account's copy, which confuses it with iCloud's |
| Move to Another Device; a new phone or tablet | Move to a New iPhone |
| Restore From a Backup | Restore (alone) |
| Backed up to (one header on every version of the page) | Where; Back up to |
| the app (Often Enough only where people must find it in the App Store) | |

## 7. Still open (for whoever builds it)

1. ~~Backed up as you go~~ **Decided, 10 Oct 2026: yes**, for every free user, with or without an account (Current
   Work 75; Rulebook D4).
2. **Google Drive on iOS** isn't built (Google *sign-in* is, `SignInProviders.swift`; Drive backup isn't). It needs the
   Drive scope (`drive.appdata`, the app's hidden folder) on Google's consent, the Drive API enabled in the Google Cloud
   project, upload, list and restore. Enabling the API or changing the consent screen is done in Google's console by the
   user: if that's needed, stop and ask. Never ship a Google Drive row that does nothing (Backup & Export research §6).
3. **The transfer code exists** (Current Work 73.1: `DeviceTransfer.swift`, `TransferSendView.swift`; 8-character
   code, the file goes straight between the two devices over the local network, nothing through the server). What's
   new: Move to Another Device opens it directly (screen 5), with the screen's new words. With an account, the new device
   should end up signed in to the same account after the transfer (Plus then syncs): decide how with the code that
   exists, or say on the new device "Sign in to keep your account".
4. **"Any of the last 7 days" / "any day in the last 90 days"** needs Restore to list the account's copies by day
   (`server/src/backup.ts` keeps 7 weekday copies per device; `snapshots.ts` the Plus nightly snapshots). If there's no
   listing endpoint, add one (Rulebook T6: `npm test`, `npm run typecheck`, deploy to dev; production only with the
   user's go-ahead).
5. ~~An iCloud / Google Drive copy beside the account~~ **Decided, 10 Oct 2026: one backup place at a time.**
6. ~~Restore for Plus~~ **Decided, 10 Oct 2026: kept** (screen 6c).

## 8. For whoever builds it

**Read first:** the Rulebook (all of it), this file, Design Rules' sidebar and Backup & Export sections, and the
reports linked in §3. Widgets are locked (U28): nothing here touches widget code.

**Files** (as of commit `e69173d9` on `app-lock-privacy-security`):

| Screen | Code |
|---|---|
| 1 Sidebar | `iOS/Habits/Menu/MenuModel.swift` (groups and order: `.backup, .privacy, .account`; Account's value: none signed out, **Free** / **Plus** signed in), `SideMenu.swift`. Update the menu order line in Design Rules ("≡ Menu") in the same change |
| 2, 2b, 2c, 3, 3b Account | `iOS/Habits/Backup/AccountView.swift`, `SignInSheet.swift` (two titles: Sign In, Create Account; Sign In with an unknown account asks before creating, D3; Create Account with a known account signs in), `SignInProviders.swift` (Apple's `SignInWithAppleButton`; Google's official button look) |
| 4, 4b, 4c Backup & Export | `iOS/Habits/Backup/BackupSyncView.swift`, `BackupCenter.swift`, `BackupIssueCard.swift` (problem states stay as built, in the status block) |
| 5 Move to Another Device | `TransferSendView.swift` becomes the page the row opens (the old "Move to a New iPhone" page with its two steps goes; U5: its "Send a Backup File" lives on in Export) |
| 6, 6b, 6c Restore | `iOS/Habits/Backup/RestoreViews.swift`; server `backup.ts`, `snapshots.ts` if a listing is needed |

**Behaviour that changes (and must be tested):**

1. **One backup place at a time.** No account: iCloud or Google Drive (the person's choice, iCloud by default).
   Signed in (free or Plus): the account only. Today a free account also writes an iCloud copy beside the account
   copy: stop that.
2. **Switching over on sign-in or account creation:** back up to the account at once; stop iCloud / Google Drive only
   after that copy has been read back and checked (D4); until then both run. Leave the old iCloud / Drive copy where it
   is, never delete it. **On sign-out:** back up to iCloud / Google Drive again at once, then as usual.
3. **Backed up as you go** (Current Work 75, Free Plan Backups §7, Rulebook D4): on leaving the app when something
   changed, at least 10 minutes after the last upload; after a widget, notification or Live Activity log (through
   `SyncService.scheduleSoon`-style background time, D12); and at least once a day. Each device keeps its own copies;
   nothing syncs on the free plan. Raise the server's per-copy limit to about 12 an hour. Do the iCloud reinstall fix
   first (Free Plan Backups §2.2 #1, a data-loss bug): never back up an empty database over a copy that has habits, and
   no backup until the welcome is finished.
4. **Restore lists by state:** no account iCloud · Google Drive · Backup File; free Your Account (7 days) · Backup File;
   Plus Your Account (90 days) · Backup File. Plus restores replace the habits on every device and the confirmation says
   so; every restore keeps the 30-day undo (D5).
5. **Plus keeps no iCloud copy** (as today).

**Everything else stays as built** (U5): Undo Last Restore (within 30 days), Erase All My Data (no account only),
Delete Account and its confirmation page, sign-out keeping the habits on the iPhone, problem states and their fixes,
the backup file and CSV exports.

**Words:** §6 here; "the app", never "Often Enough", on screens (Often Enough only where people must find it in the
App Store). Help & Feedback's backup, account and moving topics must match the new names (Move to Another Device,
Restore From a Backup, Sign In / Create Account, one backup place).

**Tests (T3, T7, T15):** update `BackupUITests`, `SyncUITests`, `OnboardingBackupScreenshotUITests` and anything that
taps the old labels ("Move to a New iPhone", "Restore Habits From a Backup…", "Create Account" as a single row). Add:
each Backup & Export state (no account, free, Plus) shows the drawn rows in the drawn order; signing in switches the
backup place only after a checked account copy (use the existing test hooks, `-test-icloud`); signing out resumes
iCloud; Restore lists per state; the Sign In / Create Account sheets; the sidebar order. A `PerfDriver` scenario for the
redesigned Account and Backup & Export pages (T4). Check the SE layouts (T15).
