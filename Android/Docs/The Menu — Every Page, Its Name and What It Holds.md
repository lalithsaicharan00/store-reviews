# The Menu — Every Page, Its Name and What It Holds

Written by Claude (Claude Code), 14 October 2026, at the user's request (Current Work 112): "The most important thing is …
the information architecture and the overall screens and naming as well. Each item in the sidebar hamburger menu, the
names as well, like what the screen name is and what options we have in it, so that it's not confusing for the users.
Take care of this first, and then build the designs for the screens."

**Status: the menu names are decided (the user, 14 Oct 2026): the same on every platform; Google Drive & Backup and iCloud & Backup become Backup & Sync, and the account lives in Plus, never as its own row. The iPhone keeps this structure with its own native components** ("whatever screens that we are going to create for iPhone, they should have this familiarity"). The Backup & Sync section in Figma (`1461:2`) follows it. Screens are designed from it afterwards, in a new, temporary Figma
section. The research behind it is in [The Account and Backup Pages](<../../Research/Research Reports/Data, Sync and Accounts/The Account and Backup Pages — Your Google Drive, and an Account Only for Plus.md>).
It's for Android; the iPhone is the same with iCloud in place of Google Drive (last section).

**What it rests on** (the user, 14 Oct 2026, Rulebook D15, D16):
- Free people have no account, and one device at a time is gone.
- Habits live only on the phone and in the person's own Google Drive (iCloud on iPhone and iPad).
- The account exists only for Plus: the purchase, Plus Family, and where the habits are backed up.

## The rules for names

1. **Name things the way people look for them.**
   - The person's own words, not ours: "Google Drive", "backup", "Plus", "Sign in", "Move to a new phone".
   - **Users show** a returning person looks for "Sign in" (Backup & Export and Your Account §3).
   - **Users show** "restore" alone is read as the purchase 58 times in 123 (same report §2.3), so the word "restore"
     always names its object.
2. **A Google sign-in is a "Google account"; a backup is a "Google Drive"** (the user, 14 Oct 2026). The two can be
   different accounts.
3. **One page, one job.** Its title says the job; its first card states where things are now, before any action (W6).
4. **Nothing in the menu is called "Account".**
   - A free person has none, so an Account page would be empty for them, or an advert.
   - The account exists only for Plus, so it lives in **Plus**. That placement itself says what the account is for.
5. **Every action names what it acts on:**
   - "Restore from a backup", not "Restore";
   - "Delete Google Drive backup…";
   - "Delete my account…", never "Delete" alone.

## The menu (≡)

```
Often Enough
─────────────
Today
Progress
Habits                    15
Tasks                      3
─────────────
Times of Day
Day and Week
Reminders
General
─────────────
Backup & Sync        ← where your habits are; moving phones
Privacy & Security
─────────────
Plus & Account               ← your purchase, your account, where your habits are
─────────────
Help & Feedback
About
```

**The rows don't change** from the menu designed on 12–14 Oct (`1326:2`). What changes is what's on the last pages:

| Row | Its page's job | Who sees what |
|---|---|---|
| **Backup & Sync** | Where your habits are, that they're safe, moving them to a new phone, getting them back, a copy to keep | Everyone; the first card changes with the state |
| **Privacy & Security** | Who can see your habits, and locking the app | Everyone |
| **Plus** | What Plus adds and buying it; for Plus people: **your account, your family**, signing out | Free: the offer and **Already have Plus?** Plus: what you have and your account |

## Backup & Sync

**Title:** Backup & Sync. **Job:** "Where are my habits, are they safe, and how do I move them?"

| Order | Section | Rows (label · line under it → where it goes) |
|---|---|---|
| 1 | *(card, no header)*: **where your habits are** | One state line and one place line, e.g. **Backed up** · *Today 9:14 AM, in your Google Drive*; then sam@gmail.com and **Back up now** (free) or **Sync now** (Plus); a note under the card: *Only Often Enough can open this copy, and only on your phones. We never see your habits.* |
| 2 | **Your Google Drive** | **Use another Google Drive** · *Back up to a different Google account* → Google's account chooser → "Back up to lee@gmail.com instead?" |
| 3 | **Devices** *(Plus only)* | This phone · *Pixel 9 · synced just now*; Pixel Tablet · *Last synced 9:14 AM* |
| 4 | **Move and restore** | **Move to a new phone** · *Show a code to scan on your new phone* → Move to a new phone. **Restore from a backup** · *From Google Drive, a backup file or your old phone* → Restore from a backup. **Undo last restore** · *Until 13 Nov* (only within 30 days of a restore) |
| 5 | **Export** | **Save a backup file** · *To restore later, on any phone*. **Export a spreadsheet (CSV)** · *To open in Google Sheets or Excel* |
| 6 | *(no header)* | **Delete Google Drive backup…** (red); **Erase all my data…** (red) |

**The first card, by state:**

| State | Line 1 | Line 2 | Button |
|---|---|---|---|
| Never connected | **Not backed up** | *Your habits are only on this phone* | **Back up to Google Drive** |
| Free, backed up | **Backed up** | *Today 9:14 AM · in your Google Drive* | Back up now |
| Plus, synced | **Synced** | *Just now · through your Google Drive* | Sync now |
| No internet | **No internet** | *3 changes waiting. They go when you're back online* | Try again |
| A problem (Drive full, access removed) | **Not backing up** | *Your Google Drive is full* (one cause, plainly) | Its one fix (e.g. **Manage storage**) |

**Its pages:**
- **Move to a new phone:** the old phone's side of D15. Its title is the job.
  - "Scan this code on your new phone": a QR code and the 6 digits, waiting.
  - Two steps under them: *1 On your new phone, open Often Enough and choose I've used it before. 2 Choose Your old phone,
    then scan this code or type the 6 digits.*
  - After a wrong try or 10 minutes the code changes by itself: *That code was tried and didn't match, so here's a new
    one.*
  - Then *Sending your habits…* and *Done. Your new phone has everything*.
  - One line about the other way: *Or sign in to Google Drive on your new phone: your habits are there too.*
- **Restore from a backup:** three choices, the same three as coming back in onboarding, in the same words.
  - **Google Drive** · *Any backup from the last week, month or six months*.
  - **A backup file** · *Open a file you saved (it starts with "Often Enough backup")*.
  - **Your old phone** · *Scan or type the code it shows*.
  - Footer: *You see what's in it before anything changes, and you can undo it for 30 days.*
- **Use another Google Drive:** Google's own account chooser, then a dialog.
  - **Back up to lee@gmail.com instead?**
  - *Your habits are copied to that Google Drive and backed up there from now on. The copy in sam@gmail.com's Drive
    stays until you delete it.*
  - **Back up there** / Cancel.
  - If that Drive already has habits: **Combine them?** (merge by ID; nothing replaced, D3).

**What changes from today's page (U5):**
- The top card says where the habits are in one place line, not a paragraph.
- **Change account** becomes **Use another Google Drive** (rule 2).
- **Move to a new phone** is back on the page. Android had lost it on 12 Oct; it's the old phone's side of the code
  (Current Work 110).
- **Restore from a backup** gains **Your old phone**.
- **Use on more devices · with Plus** leaves the free page: state before offers (W6). What Plus adds is on Plus.

## Plus & Account (renamed from Plus, 14 Oct 2026)

**Name:** the user: "people think plus is the tab where … upgrade selling is there … right now plus is not anymore about
just upgrade". The row and the page title are **Plus & Account**: both jobs named, "Account" being a word people look for
to sign in, and paired with Plus so the account reads as part of Plus, never as somewhere habits are kept.

**Job, in order** (the user: "keep upfront and important things first"): where your habits are and what an account is
for; then the person's own state; then Plus as a calm reminder; then getting a purchase back.

### The page, by state

Copy rule (the user, 14 Oct 2026): every line says what the person gets, never what they're refused, and never that the
account syncs or holds the habits. **The habits sync through the person's own Google Drive; the account is for signing
in and keeping the purchase and the family**, which is how Plus and the way back to the habits reach every device.

**One structure in every state** (the user, 14 Oct 2026: "the mental model for everyone should almost stay same"): the
same parts in the same places, top to bottom; only what's inside them changes, and each part's action sits inside it.

| Place | Free | Plus, no account yet | Plus with an account | Plus Family, you manage it | Plus from a family |
|---|---|---|---|---|---|
| 1 · Plan card | **Free** (our app icon) · *3 of 5 free habits used* | **Plus is yours** · *Yours forever, on this phone* | **Plus is yours** · *Yours forever, every device* | **Plus is yours** · *Plus Family · yours forever* | **Plus is yours** · *From Lee's family* |
| 2 · Where your habits are | **In your own Google Drive** · sam@gmail.com › (Backup & Sync). *We never see your habits.* Not connected: **Only on this phone** · *Not backed up yet* · **Back up to Google Drive** | the same | the same | the same | the same |
| 3 · Your account | **No sign-in needed** · *Free works without an account. Your habits back up to your own Google Drive.* | **No account yet** · *An account keeps Plus on all your devices. Your habits sync through your own Google Drive.* · **Create an account** | **Signed in with Google**; **What your account holds** · *Your Plus purchase, so you can sign in on your other devices. Your habits aren't in it: they sync through your own Google Drive, and we never see them.*; **Sign out** | the same; it holds *your Plus purchase and your family* | the same; it holds *your place in Lee's family* |
| 4 · Your family | **Join a family** · *Have an invite? Type its code* | **Upgrade to Plus Family** · *$35.00, the difference* | the same | **You** · Owner; **Lee** › (Remove); **Invite sent** ›; **Add a person** · *3 places free* › | **Lee** · Owner; **You**; **Leave Lee's family** |
| 5 | The **Plus** card · *Unlimited habits, and the same habits on all your devices, synced through your own Google Drive. One payment, yours forever.* · **See Plus**; **Already have Plus?** · Sign in, Restore from Google Play | — | **Delete my account…** | **Delete my account…** | **Delete my account…** |

The options are on the page, never on a sub-page (the user, 14 Oct 2026: "instead of tucking them away … keep it up
front").

### The flows (Figma `1476:2`, laid out as rows with arrows)

- **Get Plus** (its own page, from See Plus and from the 6th-habit sheet): Plus · Just you / Plus Family, what you get,
  **Get Plus · $24.99** → **Google Play's own purchase sheet** → **Plus is yours.** (the cookie icon; *Thank you. Keep it
  on all your devices with an account.*; three points: Plus on all your devices, Your habits sync through your Google
  Drive, Your purchase stays safe) → **Continue with Google** or **Not now** (*Without an account, Plus works only on this
  device. You can create one later.*) → the page, with or without an account. No Continue with Apple here: on Android the
  person has just paid with their Google account. Plus Family asks for the account (to add people), with no Not now.
  Also: **Payment pending** (Google Play's pending payments) and **Payment not completed**.
- **Restore from Google Play:** looking → **Plus is back** (bought on this Google account) or **No Plus found** (Sign in
  instead, if it was bought on an iPhone or with an account).
- **Sign in** (Google or Apple: an account made on an iPhone may be Apple's): Google's own account sheet → looking →
  **Plus is back** (signed in) or **No account found** (Another Google account · Continue with Apple · Get Plus).
- **Join a family:** type the code → sign in (Google or Apple) → **Join Lee's family?** → Plus from a family.
- **Create an account** (Plus, no account yet): *Keep Plus everywhere.* → Continue with Google → the page with an account.
- **Your family:** Invite someone (from Add a person or Invite sent), **Remove Lee?** (the manager), **Leave Lee's family?** (a member).
- **The account:** Sign out?, Delete your account? (designed 14 Oct).

## Privacy & Security, About, Help

- **Privacy & Security:**
  - App lock and Hide names outside the app, as designed.
  - The footer changes from "No ads. No account." to: *No ads. Your habits stay on your phones and in your own Google
    Drive; we never see them. An account, only with Plus, holds your purchase and your family.*
  - With an account, one more row: **Your account** · *What it holds, and deleting it* → Plus & Account › Your account. Apple asks
    for Delete in "the app's account settings"; people looking in Privacy find the way there.
- **About:** the same change to its Privacy paragraph.
- **Help & Feedback** gains two topics:
  - **Move to a new phone** (the two steps, opening the page);
  - **Plus on a new phone or an iPhone** (sign in, or Restore from Google Play).

## The iPhone and iPad

- **The same menu, with the same names** (the user, 14 Oct 2026: different names on the two platforms would confuse
  people). The iPhone's "iCloud & Backup" becomes **Backup & Sync**: a name tied to one cloud is wrong for an iPhone person
  who backs up to Google Drive. Still different today: iPhone "Appearance", Android "General" (for the user).
- **Use another Google Drive** has no iCloud equivalent: the Apple Account is the phone's own, so the card says *In
  your iCloud* and points to Settings › your name.
- The account rows are the same, with "Signed in with Apple".

## For the user to decide

1. **No Account row; the account is part of Plus** (rule 4).
2. **Delete my account** sits on Plus › Your account, with a row in Privacy that leads there. D16 said "Delete my
   account (Privacy)".
3. **Plus Family needs an account** to add people. Buying it asks the buyer to create one; single Plus stays optional.
4. **The skip line (decided by the user, 14 Oct 2026):** "Without an account, Plus works only on this device. You can create one later." Never forced: "if they don't want to create an account, then let it be." Kept simple on purpose, though Google Play and the App Store can bring Plus back on the same store account.
5. **Use another Google Drive with Plus on several devices:** the account remembers the place, so every device follows.
