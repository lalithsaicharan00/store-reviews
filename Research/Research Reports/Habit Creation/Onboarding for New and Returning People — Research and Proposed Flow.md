# Onboarding for New and Returning People — Research and Proposed Flow

Written by Claude (Claude Code), 9 October 2026, for Current Work items 73 (onboarding, and getting everything back for
someone returning) and 3 (the account out of Backup & Export). The user asked for research into the whole first-run
flow so that every kind of person feels it is seamless: someone new, and someone coming back with an account, an
iPhone backup or a backup file. Their assumption, to test: **the first screen should split people into new and
returning.** Today's first screen is written for a first-timer, yet it shows a returning person's option ("Restore
from a Backup File") to everyone, and has no way to sign in.

It builds on [The First Run — Start in One Tap](<The First Run — Start in One Tap.md>) (30 Sep) and
[Onboarding — The Name, What's Free, and a First Habit](<Onboarding — The Name, What's Free, and a First Habit.md>)
(1 Oct), which designed today's four welcome pages, and on the accounts and backup research in
`Data, Sync and Accounts/`. Today's screens are on the Figma page **onboarding**, frame "Current screens — 9 Oct 2026".

Evidence labels: **users show** (reviews), **iPhone does / Apple says** (Apple's documentation), **reasoned** (first
principles, no direct review evidence). Competitors appear only through their own users' reviews.

## The answer

1. **The user's assumption holds, with one refinement.** A returning person needs a way in on the very first
   screen, before any question, tour or setup: that is the single clearest finding here. But the app should not
   make people sort themselves when it can already tell. So: **recognise returning people automatically wherever
   possible, and only when nothing is known show a first screen with two doors**: a big **Get Started** for new
   people and a plain **I've used Often Enough before** for everyone else.
2. **Signing in must bring everything back by itself, with no other step.** "Sign in and pick up where I left off"
   is what returning people expect; signing in and finding nothing is among the worst-rated experiences in this
   study.
3. **A sign-in that finds no account must say so and never quietly start a new one.** The wrong Apple ID, Google
   account or email is a common way people lose their history.
4. **New people: fast, optional, no account, nothing to decide about backups.** Long or interrupted first runs are
   the worst-rated theme of all.
5. **The account gets its own place, visible at the top of ≡.** People can't find how to sign in or out, or which
   account they're in, when it hides inside another page.

## 1. How the evidence was gathered

- **Corpus:** every review in the three local corpora, **1,487,223 reviews** (App Store habit and routine apps,
  Play Store habit apps, and Apple's and Google's built-in apps). The built-in apps matter because Notes, Calendar
  and Keep set what iPhone owners expect from "sign in and it's all there".
- **Scan** ([`scan.py`](<Onboarding New and Returning Evidence/scan.py>)), five patterns: a returning person at the
  start (an existing account and onboarding or sign-in, "no login option", "made a new account", "existing user");
  reinstalls and new phones together with sign-in, account, restore, backup or iCloud; restore prompts and "it found
  my data"; signing in the wrong way; and not finding the account or sign-out. **1,613 candidates.** Mostly English
  patterns, so non-English reviews are under-counted.
- **Reading:** all 1,613 read one by one and hand-coded into 26 themes
  ([codebook](<Onboarding New and Returning Evidence/CODEBOOK.md>), map in
  [`cls/`](<Onboarding New and Returning Evidence/cls>)).
  [`check_cls.py`](<Onboarding New and Returning Evidence/check_cls.py>) confirms that every candidate is coded
  exactly once, every code is known, and every quoted fragment appears in its review. **1,078 are on topic**, from
  89 apps: 962 from habit apps, 116 from built-in apps. Every review ID per theme is in the
  [Review Index](<Onboarding New and Returning Evidence/Onboarding for New and Returning People — Review Index.md>).
- **Web:** Apple's Human Interface Guidelines (Onboarding, Launching, Managing accounts, Sign in with Apple) and
  developer documentation (AuthenticationServices, NSUbiquitousKeyValueStore), read from Apple's own documentation
  data on 9 Oct 2026.
- **Our own app:** today's welcome and Backup & Export (screenshots from the iPhone, 9 Oct), and the code that
  decides what survives a reinstall (`SyncService.swift`, `Persistence.swift`).

**Concentration, disclosed.** One app family (two listings of the same routine app) supplies 48 of the 62
"onboarding again" reviews and 70 of the 211 lost-purchase reviews: it forces a long questionnaire before sign-in,
so its users say the most about it. The same complaint appears in 11 other apps; the "no way to sign in" theme is
spread across 23 apps, with that family at 22 of 92. Counts are reviews, not people. ★ is the reviews' average.

## 2. What the reviews say

| Theme | Reviews | Apps | Mean ★ | 1★ |
|---|---|---|---|---|
| Paid access not restored on a reinstall or new phone | 211 | 38 | 1.70 | 69% |
| Signing back in blocked (codes, links, passwords, errors) | 207 | 35 | 2.00 | 54% |
| A restore or sync-down failed, was empty or partial | 127 | 30 | 2.08 | 51% |
| **Signed in on return and found nothing** ("no account", empty) | **100** | 26 | **1.97** | 54% |
| Reinstalled or new phone: data gone, no way back offered | 95 | 31 | 2.72 | 33% |
| **No way to sign in / couldn't find where** | **92** | 23 | **2.57** | 40% |
| **New-person first run: long, stuck, interrupted** | **72** | 18 | **1.29** | 81% |
| **Made to repeat the new-person setup before signing in** | **62** | 13 | **1.56** | 68% |
| The backup existed only if made by hand | 55 | 18 | 2.51 | 31% |
| iCloud didn't bring it back | 51 | 14 | 1.71 | 63% |
| **Signing in or restoring brought everything back** | **43** | 20 | **4.77** | 0% |
| **Signed in the wrong way: new or empty account** | **39** | 11 | **1.95** | 56% |
| Had to start over / make a new account | 31 | 8 | 2.81 | 39% |
| Didn't know how to move to the new phone | 30 | 9 | 3.87 | 7% |
| **"No login needed" praised** | **29** | 11 | **4.69** | 0% |
| **Expects: sign in and pick up where I left off** | **29** | 16 | 3.28 | 10% |
| **Can't find the account, sign-out, or which account** | **28** | 15 | **1.93** | 50% |
| Forced to make an account before using it | 16 | 10 | 1.50 | 75% |
| Learned only after a loss that an account or backup was needed | 15 | 8 | 2.60 | 27% |
| The app asked whether to restore | 7 | 3 | 2.14 | 29% |
| The app found the account by itself | 4 | 2 | 4.75 | 0% |

### Returning people need a door on the first screen, before any setup

Users show this most sharply when a returning person is pushed through the new-person flow: 62 reviews, 1.56★.
- "I just want to log in people, not answer everything all over again" (Fabulous, 4★, `8944276113`).
- "And I already have an account. Why didn't it ask me that before this quiz so I can just jump back in?"
  (Fabulous, Play, 1★, `9cfc961f-cfe4-4c9a-8d55-9e479161f91b`).
- "it forces you to go through the entire test without checking if you have an account first" (Fabulous, Play, 2★,
  `d02dab83-fa14-4080-8e2c-cb85a43a6584`).
- "Returning users shouldn't have to go through the startup intro each time they move devices or reset the app!"
  (Fabulous, Play, 3★, `8c318a94-048a-459a-8ba1-631dfd688984`).
- "when installing the app on a new device it would be great if it gave you the option of restoring a backup file
  rather than being forced to go through the initial wizard again" (Fabulous, Play, 5★,
  `5b330392-d720-4b07-98ad-87ec4f58784b`).

The same need, from apps that have no sign-in at all: 92 reviews, 23 apps, 2.57★.
- "USUALLY, you can click log in, but I don't see it anywhere" (Finch, 4★, `11138529640`).
- "I was met with the starting screen and I couldn't get my old account with all of my progress back" (Finch, 3★,
  `8453713802`).
- "there's no option to login... only an option to create an account" (Fabulous, 4★, `7220752454`).
- "There is absolutely no place to "log in." "Join" is the only option." (Me+, Play, 1★,
  `415c8652-10e0-41a0-a7cc-68c6322d0866`).
- "Got a new phone and when I open the app it forces me to make a new profile with subscription. Why can't I just
  log in ?" (Me+, 5★, `11997815850`).

### Signing in must bring everything back, by itself

The expectation is plain and widely held: 29 reviews state it directly, and 43 praise it when it works (4.77★, no 1★).
- "I assumed I could log back in and pick up where I left off" (Finch, 4★, `13355771551`).
- "I figured I'd be able to sign in and out like a normal functioning app" (Finch, 1★, `12944782274`).
- When it works: "I got everything back once I logged into my Premium account on the new phone. Such a relief!"
  (Tasks, Play, 5★, `379629a8-393f-4fc6-b1c6-242ea5ce88a4`); "I uninstalled the app, reinstalled it, and signed back
  in. All my to-do lists were there" (Rabit, Play, 5★, `e6dc9e3c-5ed0-4d24-8f45-9b73bb49f264`); "With the new phone
  and my google account, all of the history is still here." (Google Calendar, 5★, `3489487832`).

When it fails, it fails badly: 100 reviews, 1.97★.
- "when I logged in with my email all my progress was gone" (Fabulous, Play, 1★, `7715fa8e-6a78-4e09-a6c0-1ed7abc85a44`).
- "I logged into it with my email as I did before then it flashed "HELLO NEW PLAYER"" (Habitica, Play, 2★,
  `48c09760-53cd-4816-a830-7f7077c3a4e3`).
- "Even though I logged in with my existing ID and password, all of my challenge steps were lost" (Samsung Health,
  2★, `6014417031`).

This is exactly what happened on our own iPhone on 8 Oct (Current Work 72): a reinstalled app signed in "OK" and
brought nothing back until the full download was fixed. A reinstall that still looks signed in, and then shows an
empty Today, is the same experience from the person's side.

### "No account for this" must never quietly become a new, empty account

Signing in the wrong way: 39 reviews, 1.95★. Some of the "found nothing" reviews are this too: the person used a
different sign-in last time.
- "it said I didn't have an account. So I made one" (Fabulous, 1★, `11224545593`).
- "I choose log in with Google and it just creates an account without warning" (Habitica, Play, 1★,
  `41181311-ae5c-4012-a63c-1d4e0893469b`).
- "the app tells me that I'm starting a new account. So, I stop signing in bc I don't want to delete everything. Am I
  signed in or not?" (Fabulous, 2★, `3922090491`).
- "it never hints at realising that maybe it was taken by me" (Habit Tracker, Play, 2★,
  `71c836e5-84e6-465d-882f-87977fd91c34`).

Often Enough already refuses to create an account silently (Rulebook D3; the "No account yet" question in
`SignInSheet`). The finding here is about wording and next steps: say which sign-in found nothing, suggest the other
one, and offer the file and a fresh start, all from the same place.

### New people: fast, optional, no account

- First runs that were long, stuck or interrupted: 72 reviews, **1.29★**, 81% 1★ (the worst-rated theme). "It takes
  forever to reach the app and start using it." (Dear Me, Play, 1★, `6e101166-7682-4cb1-8bbf-0242679da283`);
  "asked me for a review LITERALLY while I was setting up my account" (Habitica, Play, 1★,
  `8f7fc2a2-ca4a-4090-b84e-e3f3b92b876c`). This agrees with the 30 Sep study (long onboarding or questionnaires: 228
  reviews, 1.64★).
- Forced accounts: 16 reviews, 1.50★. "Uninstalled instantly when it wanted me to make an account." (Habitica,
  Play, 1★, `02686967-6a3e-475f-bd8c-94ba841676b2`).
- No login praised: 29 reviews, 4.69★. "As soon as you install it, you can instantly create new tasks. No login
  required." (To Do List, Play, 5★, `f6795c0d-9eb4-45d2-8282-afa812e72f50`); "It uses iCloud, no login account
  needed." (Habit Tracker, 5★, `9780701808`).

So the new door must not ask about accounts, and the returning door must not get in a new person's way: it is a
quiet second option, not a fork that forces a choice.

### People learn about backups only when it's too late

95 reviews lost everything with no way back (2.72★); 55 had a backup only if they had made it by hand (2.51★); 15
say they learned the rules only after a loss.
- "Didn't realise when I had a new phone I didn't have a log in." (Finch, 4★, `11951919458`).
- "From the main screen I didn't see any prompting so did not know I was supposed to or how to." (Tasks, Play, 3★,
  `659c8fd7-c26c-4460-ac85-0180214abf37`).
- "Every other app I use allows its data to be backed up automatically via iCloud." (Days Since, 1★, `9112628469`).

This agrees with the earlier rule (Backup, Sync and Accounts §4): no backup question in onboarding; backups happen by
themselves (D4). For the welcome it means one plain line about where habits are kept, never a choice.

### A restore question at the start: rare, and only bad when it traps

Only 7 reviews mention being asked whether to restore (2.14★), all from apps that asked and then broke: "I said no to
restoring my progress, it wouldn't let me do anything, unless I restored it." (Fabulous, Play, 3★,
`5382fedd-97d6-46d7-9c66-6dad9b028677`). The 4 reviews where the app simply found the account are all 4–5★: "Perfect
for making notes due to it's ability to use instantly even on a new device as long as you have your account signed
in" (Notes, 5★, `13177094360`). The evidence is thin either way. Reasoned: bringing data back by itself when the app
is sure whose it is, with "Start fresh instead" always offered, beats a question.

### Where's my account?

28 reviews, 1.93★, from 15 apps (built-in apps included): no sign-out, no account page, or unsure which account.
- "I cannot find my account settings ANYWHERE!" (Me+, 2★, `11495117139`).
- "I now have two accounts, but there is no way to log out" (Routine Planner, 2★, `8320244419`).
- "Where is Log In or Register option? Cant find anywhere." (Habit Tracker, 1★, `6586401791`).

## 3. What Apple says

- **Onboarding: fast, fun and optional; after launch, not part of it.** "If you let people skip the tutorial when
  they first launch your app or game, don't present it again on subsequent launches, but make sure it's easy for
  people to find if they want to view it later." Postpone nonessential setup, and provide reasonable default
  settings so most people can start at once. (HIG, Onboarding.)
- **Restore where people left off.** "Restore the previous state when your app restarts so people can continue where
  they left off. Avoid making people retrace steps." (HIG, Launching.) A returning person is the strongest case.
- **Accounts: only when needed, and as late as possible.** "Ask people to create an account only if your core
  functionality requires it"; "Delay sign-in for as long as possible." (HIG, Managing accounts.) "Ask people to sign
  in only in exchange for value." (HIG, Sign in with Apple.)
- **Show that someone is signed in.** "Indicate when people are currently signed in … displaying a phrase like
  'Using Sign in with Apple' in places like a settings or account interface." (HIG, Sign in with Apple.)
- **Welcome people as soon as sign-in completes.** "Help people use their new account right away; don't delay the
  experience by asking for information that isn't required." (HIG, Sign in with Apple.)
- **Sign in with Apple no smaller than other sign-in buttons, never below a scroll.** (HIG, Sign in with Apple.)
- **Finding an existing account: Apple's own pattern.** Apple's Sign in with Apple sample checks for an existing
  account on its sign-in screen by requesting an Apple ID and an iCloud Keychain password together
  (`performExistingAccountSetupFlows`); when one exists, iOS offers it in a system sheet. Apps can also ask iOS to
  answer only if a credential is already on the device (`ASAuthorizationController.RequestOptions
  .preferImmediatelyAvailableCredentials`), so a new person sees nothing. (AuthenticationServices documentation.)
- **A small marker that follows the Apple Account.** `NSUbiquitousKeyValueStore` keeps up to 1 MB of key-value data
  in the person's iCloud and shares it with all their devices; it is not for personal or sensitive data. Enough to
  remember "this Apple Account has used Often Enough; it signed in with Apple; its last iCloud backup was 8 Oct".
  It needs the `ubiquity-kvstore-identifier` entitlement, which the app doesn't have yet.

## 4. Where Often Enough is today (audited 9 Oct 2026)

| Situation | What happens today | Gap |
|---|---|---|
| New person, fresh install | Four welcome pages (the name, free with no account, days and weeks, a first habit), each skippable | Page 1 shows "Restore from a Backup File" to everyone; four pages for a new person |
| Has an account, fresh install on a new iPhone | The same four pages; signing in is only at ≡ → Backup & Export → Account, or in Restore… | No sign-in on the welcome (Current Work 73) |
| Reinstall on the same iPhone | The Keychain keeps the session and device ID (`kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`), the database is gone | The app looks signed in but empty; until 8 Oct nothing came back without signing out and in (item 72) |
| New iPhone restored from an iPhone backup or Quick Start | The database comes back with the iPhone backup (it isn't excluded); the welcome never shows, as there are habits; `ThisDeviceOnly` Keychain items don't move to a new phone, so the session is gone | Habits are there, but backups to the account stop silently until the person signs in again |
| Only a backup file | Page 1's "Restore from a Backup File" → Backup & Export → Restore… → Import a File | Three steps through a page about something else |
| Only iCloud (no account) | iCloud backup is built but hidden (`BackupFeatures.iCloudBackup`) | Nothing finds it on a new install |
| Signed in, looking for the account | ≡ → Backup & Export → (scroll) Account → Your Account | The account lives inside backup (Current Work 3); ≡ never says who you are |

## 5. Proposed flow

Each step follows from the evidence above, or is reasoned from first principles where marked.

### 5a. Before any screen: what the app already knows

The app checks, in this order, before deciding what to show. It never shows the new-person welcome to someone it
knows.

| # | What the app finds | What the person sees | Why |
|---|---|---|---|
| A | Habits already on this iPhone (an update, or a new iPhone restored from its backup) | Today, as always. If this phone was signed in before but no longer is (a new iPhone), **one** card on Today: "Sign in to keep backing up to your account" with Continue with Apple, dismissable, never repeated | Nothing to restore; the session didn't move with the phone (§4) |
| B | No habits, and a session still in this iPhone's Keychain (a reinstall) | **Welcome back** straight away: "Bringing back your habits from your account" with the account shown (method and email, or "Hidden email"), then what came back ("31 habits and 929 logs are back"), then Today. A plain **Start Fresh Instead** keeps the account untouched | "Sign in and pick up where I left off" (29 + 43 reviews); signed in but empty (100, 1.97★); HIG: restore where people left off |
| C | No habits, no session, but the iCloud marker says this Apple Account has used Often Enough | **Welcome back** with one main button that matches last time: **Continue with Apple** (or Google), or **Restore from iCloud · 8 Oct**; **Start Fresh Instead** below | People forget how they signed in (39 wrong-sign-in reviews); a reasoned way to remember it for them |
| D | Nothing known | The **Welcome** with two doors (5b) | — |

### 5b. The Welcome: two doors, the new one first

- **Often Enough**, the one-line promise ("A habit doesn't need a perfect record. It needs to happen often enough."),
  and one small line of facts: "Free · No account needed".
- **Get Started**: the full-width main button, for new people.
- **I've used Often Enough before**: a plain text button under it, for everyone else. It replaces today's "Restore
  from a Backup File", which a new person doesn't need to see.
- Privacy stays a small link at the bottom.

The user's assumption, sharpened: the split happens on the first screen, but the new path stays the main one and needs
no choice from a new person (forced-account and long-first-run reviews, 1.50★ and 1.29★). A returning person sees
their door before any question (62 reviews at 1.56★ were made to sit through setup first).

### 5c. "I've used Often Enough before": one screen, every way back

Title **Get your habits back**. In order:
1. **Continue with Apple** and **Continue with Google**, the same size (HIG).
2. **Restore from iCloud · 8 Oct 2026** (only when an iCloud backup is found).
3. **Restore a Backup File** (a file from "Save a Backup File", in Files, AirDrop or Mail).
4. A footer that helps people who don't remember: "Use the same sign-in as last time. Never made an account? Your
   habits may be in your iPhone's backup or a backup file."
5. **I'm new here**: back to Get Started.

After signing in:
- **Account found:** a **Welcome back** card with the account (method, email or "Hidden email") and what it holds
  ("31 habits · last used today · Plus") and one button, **Bring Back My Habits**, then progress, then Today. The
  day start, week start and appearance come from the account; no new-person page is shown.
- **No account found:** say it plainly and keep every way forward on one sheet: "No Often Enough account uses this
  Apple ID (hidden email ab12…@privaterelay.appleid.com)." Then **Try Google Instead**, **Restore a Backup File**,
  **Start as New** (creates the account only on this explicit tap: D3), **Cancel**.
- **A backup file** opens the existing Restore preview; on an empty iPhone there is nothing to merge, so it is one
  tap: "Restore 31 habits and 929 logs".

### 5d. The new person: three short steps

1. **Welcome** (5b): Get Started.
2. **How it works**: today's page 1 (the name, with the week picture) and page 2 (what's free) as one page of three
   or four lines: you choose how often; streaks count your goal; skipped and paused days never count against you;
   free for 5 habits, no account, kept safe on this iPhone and in its backup.
3. **What's one habit to start with?**: today's ideas, Make Your Own, Not Now.

Day start and week start: the 28 Sep decision put them in onboarding, but Apple says to postpone nonessential setup
with good defaults, and four pages became three only by moving them. Decision 3 below.

### 5e. The account gets its own place (Current Work 3)

- **≡ opens with the account at the top**, as the first row of the sidebar. Signed out: "Often Enough · Free" with
  "Sign in to back up to your account". Signed in: the method and email ("Apple · Hidden email") and "Backed up 2 min
  ago" (HIG: show that someone is signed in; 28 can't-find reviews).
- **Account** (its own page, opened from that row): how you sign in, Plus, your devices, Sign Out, Delete Account.
  Signed out, the page offers Continue with Apple / Google, and says what an account does.
- **Backup & Export** keeps only backup and export: status, where, Back Up Now, Restore, Save a Backup File, Export a
  Spreadsheet, Undo Last Restore, Erase. Its Account section becomes one line: "Backing up to your account ›
  Account".
- Item 58 is also changing ≡ (Privacy & Security, the Widgets page removed): build the two together.

### 5f. What stays the same

- Nothing is asked about backups, notifications or Plus during onboarding (30 Sep and 1 Oct reports; Backlog 4).
- Signing in never deletes and never quietly creates (D3); a restore keeps an undo file (D5).
- Help → Show the Welcome Again still shows the new-person pages.
- Test launches never see real accounts or data (D8); every new screen gets a speed scenario (T4).

## 6. Decisions for the user

1. **The first screen:** (a) **Get Started** main, **I've used Often Enough before** as a text button
   (recommended); (b) two equal buttons; (c) a separate first screen that only asks "New here or coming back?".
2. **A reinstall that still has the session (5a, B):** (a) bring everything back by itself on a Welcome back screen
   with Start Fresh Instead (recommended); (b) ask first.
3. **Day start and week start:** (a) keep them in onboarding, as a row on "How it works"; (b) leave them at their
   defaults and offer them in ≡ → Day and Week, with a one-time tip the first time someone logs after midnight
   (recommended, per Apple's "postpone nonessential setup").
4. **New-person pages:** (a) three (Welcome, How it works, First habit; recommended); (b) keep today's four.
5. **The iCloud marker (5a, C):** add the iCloud key-value entitlement and remember how this Apple Account last
   signed in (recommended); or skip it, and rely on the "I've used Often Enough before" screen alone.
6. **The account in ≡:** (a) a row at the top of the sidebar (recommended); (b) a row near the bottom, above Help.

## 6a. The first screen: one question (added 9 Oct 2026)

The user, on the proposed flow: instead of the launch checks (§5a) and the two-door Welcome (§5b), the first screen
should ask one thing, new or coming back, and look good: not weird for a first-timer, not friction for someone
returning. Figma: frame "First screen — new or coming back (9 Oct 2026)", screens F1 (iPhone 16 and iPhone SE).

**The words come from the people coming back.** Of the 796 habit-app reviews coded here about returning (any of the
returning themes), almost none call themselves an "existing user" or "returning user" (3, 0.4%) or say "I already
have an account" (9, 1%). They name what happened: a new phone (271, 34%), a reinstall (235, 30%), logging in (230,
29%), restoring (191, 24%), "my old account" (160, 20%). Keyword counts over reviews already read by hand.

**The screen (F1):** the app icon, **Often Enough**, one line about what it is; then the question **Have you used
Often Enough before?** and two equal cards that move on at the first tap (no Continue, no Skip, no dots):
- **I'm new here**: "Start with one habit. Free, no account needed." → How it works (N2).
- **I've used it before**: "New phone, reinstalled, or have a backup or an account." → Get your habits back (R1).

Why: "I've used it before", not "I have an account", because many people coming back never made one (backup files,
the iPhone's backup, iCloud); a card about accounts would send them down the new path. The new card answers the two
worries that drive new people away (forced accounts 1.50★; no login praised 4.69★). Returning people get their way in
at the first tap (62 reviews, 1.56★, made to sit through setup first). One tap, not two (long first runs: 1.29★).
Apple's own setup asks a similar question as tappable rows ("Transfer Your Apps & Data" → "From iCloud Backup",
Apple Support 118105), so the shape is familiar on an iPhone (reasoned: platform familiarity, not review evidence).

**What it changes:** F1 replaces N1 and the A–D launch checks as the first screen of a fresh install. A phone that
already has habits still opens on Today; after a reinstall, "I've used it before" can go straight to Welcome back (B1)
because the sign-in is still on the phone. The iCloud marker (decision 5) becomes optional.

## 7. Limits

- The scan's patterns are mostly English; non-English reviews are under-counted.
- One app family supplies most of the "onboarding again" reviews (§1); the theme appears in 11 other apps, but its
  size reflects that one app's flow.
- Habit-app reviewers rarely describe what a good return looked like, so the positive evidence (43 + 4 reviews) is
  smaller than the negative.
- The Welcome back screens and the iCloud marker are reasoned from the evidence and Apple's documentation; they must
  be checked on the iPhone with a real reinstall, a new-iPhone restore and both sign-in methods (U9).
- `check_cls.py` and `tally.py` read `candidates.jsonl`, which `scan.py` rebuilds from the corpora (it is kept in
  `Research/Temp/onboarding-returning/`, not in git).
