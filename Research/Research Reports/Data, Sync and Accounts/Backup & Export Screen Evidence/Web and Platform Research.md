# 58 — Backup & Export screen and account placement: web research notes

Written by Claude (Claude Code), 9 October 2026. Scratch notes for the "Backup & Export" redesign (Often Enough, iOS).
Web sources only; nothing here comes from the App Store review corpus. Quotes are verbatim from the page unless marked
"paraphrase". "Retrieved" = 9 Oct 2026.

Evidence labels used below:
- **Apple guidance**: Human Interface Guidelines (HIG) or Apple developer/support pages.
- **Research**: NN/g, academic or government usability studies.
- **Platform guidance (non-Apple)**: Android/Microsoft design docs. Useful as convergent evidence, not iOS authority.
- **Competitor pattern**: what another app does. A reference only, never an authority.
- **User feedback**: forum/community posts. Anecdotal; small n.

---

## 1. Apple: HIG and Apple's own screens

HIG pages were read from Apple's JSON feed of the same pages (`developer.apple.com/tutorials/data/design/human-interface-guidelines/<page>.json`), because the HTML pages render client-side.

### 1.1 Settings (HIG, last change 10 Jun 2024)
https://developer.apple.com/design/human-interface-guidelines/settings
- "Minimize the number of settings you offer. Although people appreciate having control over an app or game, too many settings can make the experience feel less approachable, while also making it hard to find a particular setting."
- "Aim to provide default settings that give the best experience to the largest number of people."
- "Put general, infrequently changed settings in your custom settings area. … both apps and games might offer options related to people's accounts." → account options belong in the app's settings area.
- "Avoid using settings to ask for setup information you can get in other ways."
- No iOS-specific considerations; nothing on section order.

### 1.2 Lists and tables (HIG, last change 21 Jun 2023)
https://developer.apple.com/design/human-interface-guidelines/lists-and-tables
- "Keep item text succinct so row content is comfortable to read. … If each item consists of a large amount of text, consider alternatives … For example, you could list item titles only, letting people choose an item to reveal its content in a detail view." → long explanations go to a pushed detail page.
- "In iOS and iPadOS, for example, the grouped style uses headers, footers, and additional space to separate groups of data."
- "If you need to let people drill into a list or table row's subviews, use a disclosure indicator accessory control." (Info button only reveals more information; it doesn't navigate.)

### 1.3 Toggles (HIG, last change 29 Mar 2024)
https://developer.apple.com/design/human-interface-guidelines/toggles
- "Use a toggle to help people choose between two opposing values that affect the state of content or a view. A toggle always lets people manage the state of something…" → a row that only reports a state the person can't change is not a toggle; it's a status/value row. ("Sync: On" that can't be changed is a fact, not a setting.)
- "Use the switch toggle style only in a list row. You don't need to supply a label in this situation because the content in the row provides the context."
- "Change the default color of a switch only if necessary. The default green color tends to work well in most cases."

### 1.4 Writing (HIG, last change 16 Dec 2025)
https://developer.apple.com/design/human-interface-guidelines/writing
- "Consider each screen's purpose. … put the most important information first."
- "Be clear. … Check each word to be sure it needs to be there. If you can use fewer words, do so."
- "Use possessive pronouns sparingly. … Avoid using **we** altogether because it may be unclear who the 'we' in question refers to." → "Your account (our server)" breaks both halves of this.
- "Keep settings labels clear and simple. … If the setting label isn't enough, add an explanation. Describe what it does when turned on, and people can infer the opposite." → a one-line footer per switch, not a paragraph per screen.
- "If you need to direct someone to a setting, provide a direct link or button, rather than trying to describe its location."
- "When labeling buttons and links, it's almost always best to use a verb."

### 1.5 iCloud (HIG, last change 9 Jun 2025)
https://developer.apple.com/design/human-interface-guidelines/icloud
- "A fundamental aspect of iCloud is transparency. People don't need to know where content resides. They can just assume they're always accessing the latest version."
- "Avoid asking which documents to keep in iCloud … try to perform more file-management tasks automatically."
- "Make sure your app behaves appropriately when iCloud is unavailable. … you don't need to display an alert … it may still be helpful to unobtrusively let people know that changes they make won't be available on other devices until they restore iCloud access." → status line, not alert.

### 1.6 Feedback (HIG)
https://developer.apple.com/design/human-interface-guidelines/feedback
- "it often works well to display status information in a passive way so that people can view it when they need it. In contrast, a warning about possible data loss needs to interrupt people…"
- "Consider integrating status feedback into your interface. When status feedback is available near the items it describes, people get important information without having to take action… For example, Mail … describes the most recent update … in the toolbar."
- "people typically expect their action or task to succeed, they only need to know when it doesn't." → quiet success, loud failure.

### 1.7 Alerts / action sheets / buttons (HIG; Alerts last change 2 Feb 2024; Buttons 16 Dec 2025 "Updated guidance for Liquid Glass")
https://developer.apple.com/design/human-interface-guidelines/alerts · …/action-sheets · …/buttons
- Alerts: "Avoid displaying alerts for common, undoable actions, even when they're destructive. … when people take an uncommon destructive action that they can't undo, it's important to display an alert."
- Alerts: use a specific title ("Erase", "Delete"), not OK; always "Cancel" for cancel.
- Alerts: "Use the destructive style to identify a button that performs a destructive action people didn't deliberately choose." (Deliberately chosen destructive action, e.g. Empty Trash, is not styled destructive in its own confirmation.)
- Action sheets: "Use an action sheet — not an alert — to offer choices related to an intentional action." → Restore source picker (Account / iCloud / File) fits a confirmation dialog or a pushed list.
- Buttons: "Destructive. The button performs an action that can result in data destruction." / "a destructive button uses the system red color." "Don't assign the primary role to a button that performs a destructive action."

### 1.8 Disclosure controls (HIG)
https://developer.apple.com/design/human-interface-guidelines/disclosure-controls
- "Place controls that people are most likely to use at the top of the disclosure hierarchy so they're always visible, with more advanced functionality hidden by default."

### 1.9 Managing accounts (HIG)
https://developer.apple.com/design/human-interface-guidelines/managing-accounts
- "Ask people to create an account only if your core functionality requires it."
- "Explain the benefits of creating an account … write a brief, friendly description … Display this message in your sign-in view." → the benefit copy belongs on the sign-in view, not on the backup screen.
- "Delay sign-in for as long as possible."
- "Always identify the authentication method you offer" ("Sign In with Face ID", not "Sign In").
- Deleting: "Provide a clear way to initiate account deletion within your app… Make the link easy to discover." "Tell people when account deletion will complete." Subscriptions continue to bill through Apple until cancelled; explain this on deletion.

### 1.10 Apple: Offering account deletion (developer support page, undated; © 2026)
https://developer.apple.com/support/offering-account-deletion-in-your-app/
- "**Make the account deletion option easy to find in your app.** Typically, it's included in the app's account settings."
- App Review guideline 5.1.1(v) reference: https://developer.apple.com/help/app-review/guideline-reference/5-1-1-account-deletion

### 1.11 Apple's iCloud Backup screen (support article 108366, published 24 Sep 2026)
https://support.apple.com/en-us/108366
- Path: "Open the Settings app, tap your name, then tap iCloud." → "Tap iCloud Backup." → "Tap Back Up Now."
- "Under Back Up Now, the date and time of your last backup is shown." (Shipping label, per third-party guides, is "Last successful backup: …"; switchingtomac.com 2026, https://www.switchingtomac.com/tutorials/ios-tutorials/backup-your-ios-device-over-wifi-automatically/)
- Structure (observed, paraphrase): one switch "Back Up This iPhone"; a "Back Up Now" button with the last-backup time directly under it; the device list ("All Device Backups") below. The status sits with the action, not in a separate section. Restore is **not** on this screen: an iCloud restore happens in iPhone setup (Apps & Data). Apple's backup screen is backup-only.
- Apple iPhone User Guide "Back up iPhone": https://support.apple.com/guide/iphone/back-up-iphone-iph3ecf67d29/ios (guide covers the current iOS; content not machine-readable in this session).

### 1.12 Apple's account placement in Settings
- Account is the first row of Settings, under Search: name and photo in one row; tapping opens the Apple Account page (Personal Information, Sign-In & Security, Payment & Shipping, Subscriptions; then iCloud, Family, Find My, Media & Purchases). Six Colors, Mar 2025: https://sixcolors.com/post/2025/03/searching-for-settings-in-all-the-wrong-places/ ; iPhone Life: https://iphonelife.com/blog/5/tip-day-manage-your-apple-id-account-settings
- Sign Out is at the **bottom** of the Apple Account page, in red text; it then asks what to keep on the phone (community answers, e.g. https://discussions.apple.com/thread/255703288; Apple's restrictions article https://support.apple.com/101973).
- iCloud Backup is **inside** the account (Settings › [name] › iCloud › iCloud Backup): Apple's model is "account → its services (backup, sync) → each service's page". Backup status is one row on the iCloud page.
- Precedent for "move" as its own job: Settings › General › Transfer or Reset iPhone (bottom of General). Not inside Backup.

### 1.13 WWDC25 "Get to know the new design system" (session 356, June 2025)
https://developer.apple.com/videos/play/wwdc2025/356/
- "Instead of relying on decoration, hierarchy should be expressed through layout and grouping."
- "If your bar is feeling too crowded, use it as a cue to remove anything unnecessary and move secondary actions into a more menu… Group bar items by function and frequency."
- "Avoid placing screen-specific actions [in tab-bar accessories]… a checkout button, for example, belongs with the content it supports."
- No settings-specific WWDC session found (searched 2024–2026). Session 323 ("Build a SwiftUI app with the new design") has nothing on Form layout.

---

## 2. UX research and non-Apple platform guidance

### 2.1 Progressive disclosure — NN/g, Jakob Nielsen, 3 Dec 2006
https://www.nngroup.com/articles/progressive-disclosure/
- "Initially, show users only a few of the most important options. Offer a larger set of specialized options upon request."
- "You have to disclose everything that users frequently need up front."
- "label the button or link in a way that sets clear expectations."
- "designs that go beyond 2 disclosure levels typically have low usability." → main screen + one detail page per job; no third level.
- Choose what's primary from task analysis and usage data.

### 2.2 How little users read — NN/g, Jakob Nielsen, 5 May 2008
https://www.nngroup.com/articles/how-little-do-users-read/
- "On the average Web page, users have time to read at most 28% of the words during an average visit; 20% is more likely." (web pages; directional for app copy). → paragraphs in footers are mostly unread; the row label must carry the meaning.

### 2.3 Visibility of system status — NN/g heuristic #1
https://www.nngroup.com/articles/visibility-system-status/
- "The design should always keep users informed about what is going on, through appropriate feedback within a reasonable amount of time." (Article examples: battery indicator, unread count.)

### 2.4 Toggle-switch guidelines — NN/g, Alita Kendrick, 29 Jul 2018
https://www.nngroup.com/articles/toggle-switch-guidelines/
- "Toggle switches should take immediate effect." "Keep labels for toggle switches short and direct." "Toggle switches should only be used when the user needs to decide between two opposing states."

### 2.5 Common region — NN/g, Aurora Harley, 12 Jul 2020
https://www.nngroup.com/articles/common-region/
- "items within a boundary are perceived as a group." Containers are strong cues, but too many boxes add clutter. → in an inset-grouped list, each section box should be one job; a box mixing "backup", "move" and "export" reads as one job.

### 2.6 Mental models for cloud storage — NN/g, Raluca Budiu, 24 Nov 2019 (8 participants)
https://www.nngroup.com/articles/cloud-storage/
- Users "attempt to fit [cloud services] into their existent, simpler mental models". Unclear labels ("the cloud in the Status column", "Pending shared folders") confused participants. Users didn't know which copies were local. → name places by what people already know (this iPhone, iCloud, your account), not by infrastructure.
- Related: Marshall & Tang, "That syncing feeling" (DIS 2012): people use the cloud variously as a personal store, a replica and a sync mechanism — several models at once. https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/DISCamReadyFix.pdf
- Kang et al., SOUPS 2015, "my data just goes everywhere": lay mental models of where data goes are vague; technical detail does not reliably improve them (title only verified here).

### 2.7 Logout placement — U.S. Census Bureau working paper rsm2022-04, Falcone, Feuer, Wang, 22 Jul 2022
https://www.census.gov/library/working-papers/2022/adrm/rsm2022-04.html
- Three placements of "Save & Logout" on a mobile survey: on screen, main menu, sub-menu. Success 100 % / 100 % / **54 %**. "logout action is fastest with on-screen design." (Survey context; n not in the abstract.) → a sign-out buried a level deep is found far less often.

### 2.8 Android settings design guidelines (last updated 27 Feb 2025)
https://source.android.com/docs/core/settings/settings-guidelines
- "Place frequently used settings at the top of the screen." "Showing more than 10-15 items can be overwhelming." "Create intuitive menus by moving some settings to a separate screen."
- "Users should be able to glance at settings screens and understand all of the individual settings and their values." "Below the title, show the status to highlight the value of the setting." "Show the specific details instead of just describing the title."
- "Make your settings' titles brief and meaningful." "Put the most important text of your label first." Avoid "generic terms, such as set, change, edit, modify, manage, use, select, or choose."
- "Footer text can be used to add explanatory content."
- An "entity screen" (e.g. an account) holds only that entity's settings.

### 2.9 Microsoft UI text guidance (Visual Studio UX guidelines)
https://learn.microsoft.com/en-us/visualstudio/extensibility/ux-guidelines/ui-text-and-help-for-visual-studio
- Users read control labels first; static text least. "Unless it is absolutely needed, do not include instructional text." Link to detail instead.

---

## 3. Competitor patterns (reference only) and user feedback

| App | Where backup/export/account live | Structure notes | User feedback found |
|---|---|---|---|
| **Apple iCloud Backup** (iOS) | Settings › [name] › iCloud › iCloud Backup | One switch, Back Up Now, last-backup time under the button, device list. Restore only during device setup. | — |
| **WhatsApp** (iOS) | Settings › Chats › Chat Backup; separate "Transfer Chats" row in Settings › Chats | Status first ("Last Backup" date/size), Back Up Now, Auto Backup frequency, Include Videos, E2E-encrypted backup; one footer. Restore only on reinstall. Transfer (QR) is a separate row, started from the new phone. (iGeeksBlog, iMore third-party guides; TechRadar/TweakTown 2023 on QR transfer) | Frequent confusion when restore isn't offered: restore exists only at setup and needs same number + iCloud account + 2.05× space (Apple Community thread https://discussions.apple.com/thread/254298690). → Hidden/conditional restore = support burden. |
| **Signal** (iOS 7.86+, Nov 2025 beta) | Settings › Backups | Opt-in, daily, replaces the previous archive; recovery key; "Turn Off and Delete Backup". Device transfer starts from the new device's registration ("Transfer from iOS device", QR), not from Settings. Signal blog 8 Sep 2025 https://signal.org/blog/introducing-secure-backups/ ; Signal device transfer blog https://signal.org/blog/ios-device-transfer/ ; Privacy Guides 25 Nov 2025 https://www.privacyguides.org/news/2025/11/25/signal-rolls-out-secure-backups-for-ios-in-beta/ | Not collected. |
| **Day One** | Settings: Account row first (sign in "for syncing and online backups"), then Appearance…, then Import/Export and local backups further down; Sync page holds encryption key, storage. Help: https://dayoneapp.com/guides/settings/accessing-the-settings-in-day-one-for-ios ; backup options page lists five methods (Secure Cloud Backup, Auto Text Backups to iCloud, iCloud device backups, JSON export, Time Machine) https://dayoneapp.com/guides/day-one-ios/backup-and-sync-options-on-ios-and-macos/ | Five overlapping "backup" concepts. | "I cannot find the backup settings anywhere… What am I missing?" (forum, 1 Aug 2025, https://forums.dayoneapp.com/forums/topic/where-are-the-backup-settings/); staff: the web app "automatically syncs to our server, essentially creating a backup". Their own guide: the most common sync failure is "being signed into different accounts without realizing it" → show the signed-in identity (https://dayoneapp.com/guides/troubleshooting/solving-sync-troubles/). "Backup logic?" thread: users can't tell iCloud device backup from Day One backup (https://forums.dayoneapp.com/forums/topic/backup-logic). |
| **Bear** (iOS) | Sidebar ⋮ menu › Backup all notes / Restore Backup (FAQ © 2025 https://bear.app/faq/backup-restore/); iCloud sync separate | Backup is a manual file; restore **replaces** all notes ("all notes currently in Bear, including trashed notes, will be permanently deleted"). | Feature request, 28 Feb 2025: "Bear contains many important data that I don't want to lose" — asks for automatic backups; another user: "While waiting for years, I had to come up with some shortcut/Python solution" (https://community.bear.app/t/feature-request-automatic-backup-support-from-within-the-app-on-ios-macos/15447). No dev reply. |
| **Things 3** | Settings › Things Cloud | Switch + account (email) + last sync time + error message on one page; no backup screen (relies on Things Cloud/iCloud device backup). Troubleshooting checks exactly those four items: "Is Things Cloud switched on?", "same Things Cloud account?", "Is there an error message?", "What time does it show for the most recent sync?" (https://culturedcode.com/things/support/articles/2803590/) | Not collected. Note: sign-out is the switch itself (toggle off) — Cultured Code's own reset advice is "toggle the Things Cloud switch off, and then on again" (https://culturedcode.com/things/support/articles/2997514/). |
| **Habitify** | Settings › Import / Export: "Export as .csv" (spreadsheet) and "Export as Backup" (.sqlite, restorable). Help article 10 Apr 2026 https://intercom.help/habitify-app/en/articles/10501738-how-to-export-data-of-habitify-account ; iOS 29.0 changelog 27 Oct 2025 | Each option carries a one-line "Best for" (analysis vs. complete backup) — a compact way to make CSV vs. backup clear. | A second help article says there's no file import (conflict with changelog) — users get mixed messages. |
| **Loop Habit Tracker** (Android, open source) | Settings › Database: "Export full backup", "Import data" | Relies on Android system backup for automatic copies. FAQ (iSoron, 28 Dec 2020, https://github.com/iSoron/uhabits/discussions/689): "this backup system can be unreliable at times"; "uninstalling the app will delete all your data, in addition to all the backups stored in the cloud". | The FAQ itself is the complaint record: automatic backup isn't trustworthy, so users are told to export. |
| **Streaks** | iCloud sync; CSV export/import (App Store notes) | No backup screen found. | — |
| **1Password** (iOS, older 7.x threads) | Settings › Accounts › [account] › Sign Out at bottom, red | Sign out greyed out when it's the only account. | Multiple community threads ("Cannot sign out of work account on iPhone", "remove account in ios") — people couldn't find or use Sign Out; staff suggested reinstall/erase. (https://1password.community/discussion/83735/remove-account-in-ios) |
| **Notion** | Account at top of Settings; workspace export only on desktop/web | — | Export unavailable on iOS (help https://www.notion.com/help/workspace-settings). |
| **Apple Health** | Profile picture (top right) › Export All Health Data at the bottom | Export is a one-off action at the end of the profile page, away from settings that change state. | — |

Patterns that recur across the well-regarded ones:
1. **Status first, then the one action** (Apple iCloud Backup, WhatsApp, Things): last backup/sync time is the first thing; "Back Up Now" sits beside it.
2. **Restore is not a peer of backup on the backup screen** in Apple/WhatsApp/Signal — it happens on the new or reset device. Where restore is only there, people get stuck (WhatsApp threads). Bear/Loop put Restore/Import next to Backup/Export in a menu.
3. **Transfer to another device is a separate job** (WhatsApp "Transfer Chats", Signal "Transfer from iOS device", Apple "Transfer or Reset iPhone"), usually started from the new device by QR.
4. **CSV export is described by purpose** ("for spreadsheets") vs. full backup ("to restore") — Habitify.
5. **Account at the top of settings** (Apple, Day One, Notion); sign out at the bottom of the account page, red (Apple, 1Password).
6. **Too many "backup" concepts confuse** (Day One's five; iCloud device backup vs. app backup).

---

## 4. Where users expect account controls

Evidence:
- Apple Settings: account row first; Sign Out at the bottom of the account page; deletion "typically … in the app's account settings" (Apple developer page). Services (iCloud, backup) hang under the account.
- HIG Settings: account options belong in the app's settings area. HIG Managing accounts: explain the account's benefits on the sign-in view.
- Census 2022: logout in a sub-menu found by 54 % vs. 100 % on screen or in the main menu.
- Day One: the commonest sync failure is being in the wrong account without knowing → the signed-in identity must be visible where sync/backup status is shown.
- 1Password threads: Sign Out unavailable/greyed is a repeated complaint.
- Discourse meta thread (2019, https://meta.discourse.org/t/a-click-too-many-logging-out/130615): moving logout one level deeper drew "may have trouble finding it" replies (anecdotal).

Synthesis: users look first at the **top of Settings** for an account row (identity + plan), and expect **sign in / create account** there and **sign out / delete account** at the bottom of that account's own page. Backup may *show* which account it uses, and may offer "Sign In to Back Up" when signed out, but it shouldn't be the only door.

---

## 5. Recommended principles for the Backup & Export screen

1. **Open with one status line that answers "is my data safe?"** — e.g. "Backed up · 2 min ago" with the place in plain words, and Back Up Now right with it. *Evidence: Apple iCloud Backup (support 108366, 24 Sep 2026); HIG Feedback; NN/g heuristic #1; Android "show the status"; WhatsApp/Things.* Keep success quiet and make failure loud and specific with one fix (HIG Feedback: people "only need to know when it doesn't").
2. **Group by the person's job, one section per job, in order of need:** (a) Backup — status, Back Up Now, the iCloud copy switch; (b) Restore — its own row/section, near the top, not between export rows; (c) Move to Another Device; (d) Export — Backup File, Spreadsheet (CSV). *Evidence: NN/g common region; HIG grouped style; WWDC25 356 "hierarchy … through layout and grouping"; competitor pattern of separate Transfer.*
3. **Push detail to one level of pushed pages, never two.** The main screen shows labels and status; each job's explanation, options and sources live on its own page (Restore › choose source; Move › QR steps). *Evidence: NN/g progressive disclosure (≤ 2 levels); HIG Lists "reveal its content in a detail view"; Android "moving some settings to a separate screen".*
4. **Name places the way people already do: "iCloud", "This iPhone", "your Often Enough account" — never "our server" or "we".** *Evidence: HIG Writing ("Avoid using we altogether"; possessives sparingly); HIG iCloud ("People don't need to know where content resides"); NN/g cloud mental models.* Infrastructure detail (encryption, server, retention) can sit on the detail page for those who look.
5. **Cut helper text to one line per item that needs it; no screen-wide paragraph.** Describe what a switch does when on. Use row subtitles for purpose ("Opens in Numbers or Excel" for CSV; "Restores into Often Enough" for a backup file). *Evidence: HIG Writing; NN/g 20–28 % read; Microsoft "do not include instructional text" unless needed; Habitify "Best for" lines.*
6. **Make the difference between backup, move and export visible in the labels themselves**, by outcome: back up (automatic safety copy), move (this phone to a new one), export (a file you keep: a backup file to restore later, or a spreadsheet to read). *Reasoned from first principles, supported by Day One forum confusion and Habitify's "Best for".*
7. **No switch or value row for something the person can't change.** Fold "Sync: On" into the status line ("Synced with your iPad · just now") or the account page; show it only when it adds information. *Evidence: HIG Toggles ("A toggle always lets people manage the state of something"); NN/g toggles (two opposing states the user chooses); Android "show the specific details".*
8. **Restore is easy to find but deliberate:** a clear row near the top; choosing a source is an action sheet or a pushed list; replacing data asks once with a specific button ("Restore", not OK) and says the current data is kept for 30 days. *Evidence: HIG Alerts/Action sheets; Bear's replace-everything warning; WhatsApp "restore only at setup" complaints. The 30-day undo is the app's own rule D5.*
9. **Account lives at the top of Settings as one identity row (name/email · plan ›), with Sign Out and Delete Account at the bottom of its page.** The backup screen shows which account it backs up to (one line, tappable to the account page) and offers "Sign In to Back Up" when signed out. *Evidence: Apple Settings structure; Apple developer page on account deletion; HIG Settings/Managing accounts; Census 54 % vs 100 %; Day One "different accounts" sync failures.*
10. **Plus-only extras appear as facts, not upsell paragraphs** ("Nightly copy on the server · kept 30 days" for Plus; nothing or one quiet line for free). Backup, export and restore must never look paywalled. *Reasoned from first principles; consistent with the app's own rule D10 and HIG Managing accounts (benefits explained on the sign-in view).*
11. **Native list only, monochrome chrome, green only for the system switch and an optional status checkmark; no destructive red on this screen except a confirmed Delete.** *Evidence: HIG Toggles (default green); HIG Buttons (red = data destruction); app rules U1/U2.*
12. **Validate with people, not just guidance:** the competitor patterns above are references; check the new order by asking testers to "restore last week's data" and "get your habits onto a new iPhone" and timing first taps. *Reasoned from first principles; NN/g recommends task analysis and observational testing to choose what's primary.*
