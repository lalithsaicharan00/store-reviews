# Today on iPhone — Notice Card, Edit and Back to Today

Written by Claude (Claude Code), 6 November 2026.

The user reviewed Today in the iPhone Figma file ("IOS app") on 6 November 2026 and asked for four things, each with proper research: Back to Today shouldn't be a main button; Nothing planned looked like Material's Expressive style; the notice card "is not at all looking good" and might not be native; and the pencil-and-plus in the bar "is looking a little bit weird". This is what was found and what changed. It is reasoned from Apple's guidance and from Apple's own apps on the iPhone 17 Simulator (iOS 26), not from reviews: none of the four is something people write reviews about.

## 1. The notice card

**What people need from it.** It tells someone that something about their habits needs them (iCloud is full, a backup is paused) and gives the one thing that fixes it. It must be seen without getting in the way of logging.

**Does iOS have a component for it? No.** Apple's guidance has no "notice card":

- [Feedback](https://developer.apple.com/design/human-interface-guidelines/feedback) says to show status near the thing it's about, and to keep alerts for what's critical and needs acting on now. A full iCloud doesn't stop anyone logging, so it isn't an alert.
- [Alerts](https://developer.apple.com/design/human-interface-guidelines/alerts) agrees: no alert for information people can't act on now.
- [Offering help](https://developer.apple.com/design/human-interface-guidelines/offering-help) and [TipView](https://developer.apple.com/documentation/tipkit/tipview) are the nearest native thing drawn inside a list: a filled symbol at the leading edge, a Headline title, a Subheadline message, an action under the words and a ✕ at the top right. But TipKit decides when a tip shows and can hide it for good after it's closed, which is wrong for a problem that's still there. So the card borrows the tip's anatomy and stays our own view.
- Apple's iOS 26 Figma kit (in Figma's libraries) has no card, banner or tip component either (searched).
- **Apple's own apps draw it this way** (Simulator, 6 Nov): Health's Summary cards (*Health Data Not Synced*, *Health notifications are currently off*) and Reminders' *Sync Reminders with iCloud* each have a title, a line of text, one tinted button under the words and a ✕ at the top right; Health adds a red filled symbol for the problem.

**What was wrong with the old one.** It was Android's card with words swapped: a dark filled button beside a second, plain *Not Now*. Two buttons of different weight side by side in a list section isn't something iOS draws, and a dark Prominent button made a routine notice look like the screen's main action.

**What it is now** (`795:499` in Figma, tried side by side on the Simulator first):

- A list section: the filled symbol in a 32 box, red only for a problem, Secondary Label otherwise.
- Headline, then Subheadline in Secondary Label, lined up with the habit names below.
- At most one fix, a Regular **Bordered** button (Ink at 18 %) under the words.
- A ✕ (`xmark.circle.fill`, Ink at 25 %) at the top right **only on what can wait**. *Not Now* is gone: the ✕ does that job.
- A card that only informs (Planned, Paused, Backed up) has no button and no ✕.

## 2. Edit and +

**What people need.** Two different jobs sit in Today's bar: change the order and layout of Today (Edit), and add a habit (+). They must not be confused with each other.

**What Apple says.** [Toolbars](https://developer.apple.com/design/human-interface-guidelines/toolbars): prefer symbols, "except for actions like edit" that no symbol says well, and keep a button with a word apart from symbol buttons, with fixed space between, so they don't read as one control. Apple's Shortcuts app on iOS 26 does exactly this: an **Edit** capsule, then a separate **+**.

**What was wrong.** A pencil and + shared one glass capsule. A pencil reads as "write" or "rename", and the shared capsule made two unrelated jobs look like one.

**What it is now.** The Navigation bar (`495:70`) has a new *Text action*: a word in its own glass capsule, 12 before the symbol capsule. On Today: **Edit** (63 × 44), then **+** alone (44). 264 copies on Today were changed. In SwiftUI: `ToolbarItem { Button("Edit") }`, `ToolbarSpacer(.fixed)`, `ToolbarItem { Button("New", systemImage: "plus") }`. Five other options were tried and not chosen: pencil and + together (as it was), both in one capsule, `EditButton`, the pencil alone, and an arrows symbol.

## 3. Back to Today

**What people need.** One tap back after looking at another day ([Back to Today — When and Where](<Back to Today — When and Where.md>), 28 Sep 2026). It's a way back, not the screen's main action, as the user said: "it is like kind of optional thing for a user."

**What it is now.** The Floating button set (`4193:106216`) has two variants: **Glass**, the plain Liquid Glass of the bars with a Label-coloured word and symbol, used for Back to Today; and **Prominent** (Ink), kept for History's Add and the other floating buttons that are a page's main action. Only Back to Today was changed. Android's choice of a filled Back to today (16 Oct) stays on Android.

## 4. Nothing planned

The flower-shaped cookie behind the picture is Material 3 Expressive and iOS has nothing like it. The page is now `ContentUnavailableView`, as No Habits Yet is: the `calendar` symbol in Secondary Label, Title 2 Bold, Subheadline, and one Large Prominent **New Habit**.

## 5. Edit Today: editing a time of day, and adding one

The user, the same day: the pencil by each time of day "is very weird", and Add time of day's small button "is having some issues … in terms of like contrast". The place was right; the button wasn't.

**What people need.** On Edit Today, people change the order of habits and change a time of day itself (its name and hours). They also add a new time of day. Each needs a control that says what it does and is easy to hit.

**What Apple's apps do** (iPhone 17 Simulator, iOS 26):

- **Reminders, Edit:** each list gets an ⓘ that opens its name and colour, and a drag handle. Adding a group is an *Add Group* glass button at the bottom.
- **Contacts, New Contact:** every addable thing is a list row of its own, starting with a filled ⊕ (*add phone*, *add email*).
- **Health, Summary:** the *Pinned* section header ends in a plain word, **Edit**, lined up with the card's inner edge (seen on the Simulator). Apple tints it blue; ours is Ink.

**Tried on the Simulator:** the pencil (as it was), ⓘ, the word Edit, ⋯ with a menu, and four Add rows: green ⊕, Ink ⊕, a plain + and the old capsule.

**The ⓘ was rejected by the user.** It opened the same Edit time of day, but it reads as "information", so it looked as if editing had been taken away: "things should be reachable from multiple ways … you're removing edit option itself." **A control that changes something must say so.** The header ends in the word **Edit**, a Small Borderless button, its word ending where the rows' handles end, as Health's does. Three Edits on a page called Edit Today is acceptable; a hidden action isn't.

**Add Time of Day** is now a list row of its own after the timed sections, where the button was: a filled ⊕ in Ink, then *Add Time of Day* in Body, 52 tall, the whole row a target. Apple draws that ⊕ green; it's Ink here because the chrome stays neutral and the switch is the only green. The old app had this row with the green ⊕ (`AddRow`).

## Left for the user

- **Back to this week / month** on History is still Prominent. It does the same job as Back to Today, so it may want the Glass variant too.
- **Android-only notices on Today** (a phone maker stopping reminders, a reminder 40 minutes late, *Let Often Enough run in the background*) have no iPhone cause and are candidates to delete.
- **Settings still describes Google Drive** (Back up to Google Drive, Change account, Delete Google Drive backup).
