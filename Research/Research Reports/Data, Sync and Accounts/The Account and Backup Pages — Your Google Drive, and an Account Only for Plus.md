# The Account and Backup Pages — Your Google Drive, and an Account Only for Plus

Written by Claude (Claude Code), 14 October 2026, at the user's request (Current Work 112): "in the sidebar, we need to
create a page, or whatever is best to do … very clearly convey that your data will be stored in … your own Google Drive
… They can select a different account or change to a different account … the account is only for holding whether you
have Plus or not … it helps you sign in to different accounts and get back your data properly … Let's do some research
and figure out how it should be overall."

**Status: research and a proposal. Decided since (the user, 14 Oct 2026):** the menu row is **Backup & Sync** on every platform; there's no Account row (the account lives in Plus); and the skip line stays **"Without an account, Plus works only on this device"**, simple on purpose, never forcing an account. §1.6 and §4.2 below are the proposal the user chose not to take. The designs are in a new, temporary Figma section on the Android page, beside
the current pages, which are untouched until the user chooses.

**The rules this starts from** (the user, 14 Oct 2026; Rulebook D15, D16):
- Free people have no account at all, on any device.
- One device at a time is dropped.
- Free habits are backed up to the person's own Google Drive (iCloud on iPhone and iPad). They come back from there, from
  the old phone with a code, or from a backup file.
- The account is only for Plus. It holds the purchase, Plus Family and where the habits live, and never the habits.
- Sign in with Google or Apple only.

**How each point is backed:**
- **Users show:** reviews, read by hand for this report.
- **Earlier report:** a finding from an earlier study, named and not re-checked.
- **Platform fact:** Google's or Apple's own documentation, or our own architecture document that cites it.
- **Reasoned from first principles:** no review covers it.

**Evidence** ([`Account Pages Evidence/`](<Account Pages Evidence/CODEBOOK.md>)):
- **The scan:** all **1,487,223** reviews, six patterns:
  - your own cloud;
  - why an account;
  - a purchase on another device or platform;
  - restore purchase;
  - family plans;
  - where is my data.
- **1,438 matches.** I read by hand **all 1,064** from the App Store and Play Store, and every non-family match from the
  built-in apps (32). I sampled 25 of the built-in apps' 342 family matches: all were about shared calendars and lists,
  so off topic.
- **791 reviews were on topic, from 91 apps,** coded into 34 codes. The map validates with no unknown or missing keys
  ([`tally.py`](<Account Pages Evidence/tally.py>)).
- **21 quotes,** each checked word for word against its review by [`verify.py`](<Account Pages Evidence/verify.py>).

---

## 1. The short answer

1. **Free people never see an account; the account lives inside Plus.**
   - There's no separate Account row in the menu. An Account page for someone without an account would be empty, or an
     advert.
   - Two rows each do one job:
     - **Google Drive & Backup:** where your habits are.
     - **Plus:** your purchase, and for Plus people the account and the family.
2. **Google Drive & Backup opens with one plain sentence: your habits are in your own Google Drive.**
   - It names the Google account, with **Change**, and says who can read the copy: only you, through this app.
   - Everything else follows: backed up when, restore, **Move to a new phone** (its new home), export and delete.
3. **The Plus page says what the account holds, as a short list.**
   - It holds your purchase, your family and where your habits are backed up.
   - It says, as plainly, what it never holds: your habits.
4. **Plus and the habits are shown as two separate things wherever both appear.**
   - **Users show** they are lost separately: 51 people got their purchase back but not their habits, or their habits
     but not the purchase.
5. **Plus Family is managed in the app,** with:
   - an **Add a person** button;
   - an invite link and code;
   - each member's state.
   - **Users show** this is where family plans fail: **50** buyers couldn't find how to add anyone, and **29** followed
     the steps and the member still didn't get it. These are all from apps that leaned on Apple's Family Sharing.
6. **One sentence we wrote earlier is wrong and should change.**
   - It's the account skip message, "Without an account, Plus works only on this device."
   - On Android, Plus bought through Google Play already comes back on every Android device signed in to the same Play
     account (platform fact, Architecture 02 §3.4).
   - What the account adds is the iPhone and iPad, Plus Family, and finding the habits again.
   - Proposed: **"Without an account, Plus stays with your Google Play account, on Android only. You can create one
     later."**

---

## 2. What users show

| What people say | Reviews | Apps | Mean ★ | 1★ |
|---|---|---|---|---|
| Restore gave nothing back | 144 | 39 | 1.66 | 69% |
| Plus didn't follow to a second device, new phone or reinstall | 97 | 28 | 1.89 | 63% |
| Lifetime taken away by a switch to subscription | 85 | 5 | 1.39 | 79% |
| **Praise for needing no account** | **75** | **24** | **4.77** | **1%** |
| Ask for a family plan | 56 | 15 | 4.02 | 5% |
| Plus came back and the habits didn't (or the reverse) | 51 | 16 | 2.04 | 53% |
| **Bought a family plan; couldn't find how to add people** | **50** | 5 | 2.80 | 36% |
| Want an account (to keep habits or Plus across phones) | 36 | 22 | 2.92 | 25% |
| Family member didn't get it after the steps | 29 | 8 | 2.21 | 38% |
| Angry at a required account | 28 | 13 | 1.46 | 79% |
| Email accounts that couldn't be signed in to | 26 | 8 | 2.19 | 46% |
| Paid on one platform, moved to the other, paid again | 25 | 12 | 1.92 | 56% |
| Couldn't find where to restore or sign in | 16 | 12 | 2.38 | 56% |
| No way to sign in on the new phone, so the purchase was lost | 15 | 11 | 2.27 | 53% |
| Worried about what an account holds | 13 | 12 | 2.23 | 54% |
| Backup or restore behind a payment | 7 | 5 | 2.14 | 43% |
| Signed in with the wrong Google account or Play profile | 5 | 3 | 1.80 | 60% |

### 2.1 An account is welcome only when it's optional and does a job

- **No account, praised:** the 75 reviews that praise needing no account average **4.77★**: "requires no account—your
  data is stored securely in iCloud" (`A41#500`).
- **A required account, hated:** the 28 angry at one average **1.46★**. Privacy is the reason given: "I consider the
  habits I want to change private, so why do I need a login (presumably for a server) to use this app?" (`A85#853`).
- **People who want an account want what it carries.** The 36 who ask for one want their habits or their purchase to
  survive a new phone: "the risk is that my data disappears if, let's say, my phone crashes and cannot be repaired"
  (`P3#6387`).
  - For us, the habits are already safe without an account (their Drive or iCloud). So the account's job is the
    purchase.
- **So the account is offered once, after buying Plus,** with its job named.

### 2.2 The purchase is what gets lost

- **The biggest group in this study is people who paid and lost what they paid for.**
  - 144 tried restore and got nothing back.
  - 97 found Plus didn't follow them to a second device or a new phone.
  - 25 changed platform and had to pay again.
  - 15 had no way to sign in at all.
- **Users ask for exactly the account we're building.**
  - "please make binding of the premium privileges to each of the account" (`P130#87`).
  - "you should provide a button for us to sign in so I don't have to buy and pay again" (`P130#308`, iPhone to Android).
  - And, from someone who lost theirs: "if you are going to buy premium, please make an account first, then buy premium.
    I bought premium without an account and was fine until I switched phones" (`P24#7671`).
- **Where people look:** "that feature is very hidden, most apps have a button right on the settings page" (`A3#7582`).
  So **Sign in** sits on the Plus page itself, near the top, never behind a menu or after a questionnaire.
- **The word "restore" confuses** ("What is restore purchases. Am I trapped into pro", `A16#1077`). An earlier report
  found 58 of 123 "restore" reviews meant the purchase, not data (Backup & Export and Your Account §2.3). So the
  purchase side says **Sign in**, and data keeps "Restore from a backup".
- **Picking the wrong account is real but rare:** "it was through the wrong play store profile than the one I have
  everything else on" (`P12#42239`). And a sign-in that quietly made a new account: "all it had to do was notify that I
  have no account with that Gmail" (`P8#5810`).
  - Our coming-back screens already say "No Plus account uses sam@gmail.com" and offer another account (Onboarding
    2.4).
  - The Plus page shows which account is signed in.

### 2.3 Plus and the habits are two things, and people lose them separately

- **51 people got one back without the other.**
  - "Despite being able to restore my purchase of premium, all my progress was gone" (`A24#41347`).
  - "The data is there … but the Premium status did not carry over to my iPad" (`A1#2286`).
  - One lost their backup because restoring it needed the purchase: "my account is showing as a free version. Because
    of this, I cannot restore my data from the cloud backup" (`P2#1413`). We never do that (Rulebook D10).
- **So both pages show both things, each where it lives:**
  - the Plus page: "Your habits: in sam@gmail.com's Google Drive ›";
  - Google Drive & Backup, for Plus: "Plus keeps your other devices the same".
  - (Reasoned from first principles, from these reviews.)

### 2.4 Family plans fail at "how do I add someone?"

- **Nearly all the evidence is from one app** that sells a lifetime family plan through Apple's Family Sharing (Habit
  Tracker, `A1`). That limits how far it generalises: it shows one way of doing family plans failing, not every way.
  - 50 buyers couldn't find how to add anyone.
  - 29 did the steps and their family member still didn't get it.
  - "there is no place or link to share with family, and there is no user information tab" (`A1#46767`).
  - "I don’t see any options to share my subscription with my family … there is no access to “my account”"
    (`A1#48844`).
  - "There’s NO option to invite others using emails, ONLY way is to turn on Family Purchase Sharing" (`A1#323`).
- **Families span platforms.** "Cool app, but don’t buy if your family has android" (`A1#51952`); "Could you also confirm
  if this is available across platforms on Google?" (`A1#45184`).
- **Platform facts:**
  - Google Play's Family Library can't share in-app purchases at all (Google Play Help, "Use Google Play Family
    Library").
  - Apple's Family Sharing reaches only the buyer's Apple family. Both stop at their own platform.
  - Ours, through the account, works on both (D16).
- **So the Plus page shows the family itself:**
  - each person, with their state (joined, invite sent and when it ends, empty seat);
  - one **Add a person** button that opens an invite with a link and a code;
  - the plain rule that nobody sees anyone else's habits.
  - It follows the iPhone design of 10 Oct (Your family, Invite to your family), adapted to Android.

### 2.5 What the account holds must be said, not implied

- Worries about accounts are about what they hold (13 reviews, 2.23★). The angriest is "presumably for a server"
  (`A85#853`).
- A smaller group resents paying for sync that runs through their own cloud: "this app just uses iCloud to sync, which I
  already pay for. I don’t understand why I would also need to subscribe" (`A41#375`). Our one payment answers part of
  that. The page shouldn't make Plus sound like storage we provide.
- **So both the account offer and the Plus page carry the same short list:**
  - Your purchase.
  - Your family.
  - Where your habits are backed up, so you can find them again.
  - Then one line: **"Never your habits. They're only on your phones and in your Google Drive."**

---

## 3. The proposal (Android first; the iPhone the same with iCloud)

### 3.1 The menu

| Row | For | What it holds |
|---|---|---|
| **Google Drive & Backup** | Everyone | Where your habits are, backed up when, the Google account (Change), Restore from a backup, **Move to a new phone**, Save a backup file, Export a spreadsheet, Delete from Google Drive, Erase |
| **Plus** | Everyone | Free: what Plus adds, the price, **Already have Plus? Sign in**, Have an invite?. Plus: what you have, your account, your family, Sign out, Delete account |

The labels don't change. The words people look for are "Google Drive", "backup" and "Plus": "Sign in" for the
purchase, "Restore" for data. Neither row is renamed "Account", because free people have none.

### 3.2 Google Drive & Backup

- **First, where your habits are,** in one card:
  - "Your habits are in your Google Drive"
  - sam@gmail.com · **Change**
  - "Only you can open them, through this app. Often Enough never sees them."
  - Then the state on its own line: backed up today 9:14 (free), synced just now (Plus), not backed up yet, no
    internet.
- **Change** opens Google's own account chooser, then asks: "Back up to lee@gmail.com instead?"
  - "Your habits are copied to that Google Drive and backed up there from now on. The copy in sam@gmail.com's Drive
    stays until you delete it."
  - If the other Drive already has habits, it offers to combine them (merge by ID; nothing replaced, D3).
- **Move to a new phone** (the old phone's side of D15) opens its own page:
  - the QR code and the 6 digits, waiting;
  - both change by themselves after a wrong try or 10 minutes, with "Keep this open until your new phone has
    everything".
  - This is the page Android's menu was missing (Current Work 110).
- **Plus only:** "Plus keeps your other devices the same" and the devices list stay as designed on 12 Oct. Free has no
  "Use on more devices" upsell at the top; state comes before offers (W6).

### 3.3 Plus

- **Free:**
  - the offer as designed on 12 Oct;
  - under the price, **Already have Plus? Sign in** (Continue with Google, Continue with Apple);
  - and **Have an invite?**
- **Plus, no account yet:**
  - "Plus is yours";
  - a card: **Keep Plus on all your devices** (the list of what an account holds; **Create an account**);
  - the skip line: "Without an account, Plus stays with your Google Play account, on Android only."
- **Plus with an account:**
  - "Plus is yours";
  - **Your account:** Signed in with Google, sam@gmail.com;
  - **What your account holds:** the three items and "Never your habits";
  - **Your habits:** in sam@gmail.com's Google Drive ›;
  - **Your family:** each person, Add a person;
  - **Sign out:** "Plus stays on this phone through Google Play; your habits stay here and in your Google Drive";
  - **Delete account** (red, asks first; also in Privacy).
- **Create an account** (after buying Plus, once, and from the card): a full screen with:
  - "Keep Plus on all your devices" and the list;
  - Continue with Google / Continue with Apple;
  - **Not now** and the skip line.

---

## 4. For the user to decide

1. **No separate Account row; the account lives in Plus** (§3.1). The alternative is an Account row shown only to Plus
   people, which would mean a menu that changes shape.
2. **The skip line.** Replace "Without an account, Plus works only on this device" (D16, item 110) with "Without an
   account, Plus stays with your Google Play account, on Android only. You can create one later." On the iPhone: "…with
   your Apple Account, on iPhone, iPad and Mac only."
3. **Plus Family needs an account.** People can't be added without one, so buying Plus Family asks the buyer to create
   one (the single Plus stays optional). Members sign in with their own.
4. **Changing the Google account with Plus on several devices.** The account remembers where the habits live (D16), so
   one change moves every device: the others follow the next time they open. Proposed; not yet decided.
5. **Signing out** keeps Plus on this phone when it was bought through this Google Play account. It ends Plus only when
   Plus came from the iPhone or a family.

---

## 5. Method and limits

- **Patterns:** [`scan.py`](<Account Pages Evidence/scan.py>). They are English-led, so other languages are thin.
  OWN_CLOUD and WHERE_DATA found few reviews (16 and 2): people rarely write where their data lives. The trust findings
  lean on the "why an account" reviews and the earlier [Without an Account](<Without an Account — iCloud and Google Drive Backup, or Only This Phone.md>)
  study (36 praise local-only storage, 339 lost everything kept only on the phone).
- **One app dominates two codes.**
  - "Lifetime taken away" (85) is mostly one app's switch to a subscription, so it says little about account pages.
  - The family failures are mostly one app's (50 of 50; 21 of 29). §2.4 says so where it's used.
- **The Android family evidence is thin** (3 Play reviews ask for a family plan; none describe one failing), because
  few Android habit apps sell one.
- **Platform facts reused:**
  - Plus restoring from the store on the same platform without our account: [Architecture 02](<../../../Architecture/02. Billing and Entitlements.md>)
    §3.4.
  - Google Play Family Library excluding in-app purchases: Google Play Help, "Use Google Play Family Library".
  - Drive's hidden app folder (visible to the person only as space used, with a way to delete it): Google's Drive API
    guide, "Store application-specific data".

---

## 6. Restore: replace, or add what's missing? (14 Oct 2026, the user's question)

The user: "I don't know … what do you mean by add what's missing … do we really need [it] … it should be like replace this
phone with that backup … if you only keep one option then make it as an information rather than option".

- **The scan:** 1,238,784 habit-app reviews (App Store and Play), four patterns: a restore that overwrote newer data, merge,
  duplicates after a restore or import, an old backup restored ([`restore-mode-scan.py`](<Account Pages Evidence/restore-mode-scan.py>)).
  44 matches, all read; **8 on topic**, so this is thin evidence.
- **Users show both harms, a few times each.**
  - **Replacing lost newer logs** (3): "it restored a two day old backup resulting in my chains being br[oken]" (`A24#27585`;
    also `A24#31237`, `A31#676`).
  - **Adding made duplicates** (2): "every task gets added twice/thrice" (`A23#2573`); an import "all doubled" (`P111#1199`).
  - **Asking for the choice** (1): "I'd like a warning and/or choice to merge or overwrite existing data" (`P3#14438`).
  - **Expecting an add and getting a replace** (1): "I thought it would add the things from my iPad but I didn’t" (`A10#22168`).
- **Decision (the user's reading; nothing here shows people need a merge):** a restore **replaces** what's on the phone, and
  the screen says so as information, never as a choice. It names what is replaced ("The 10 habits and 812 logs on this
  phone now are replaced with the backup"), because that is the harm people met, and it can be undone for 30 days (D5).
  The shared core keeps its Merge (`Restore.kt`), unused by the screens.
