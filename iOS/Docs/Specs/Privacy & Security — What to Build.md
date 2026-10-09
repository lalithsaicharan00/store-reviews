# Privacy & Security — What to Build

Written by Claude (Claude Code), 9 October 2026, at the user's request: "everything should be in privacy and security
tab and remove widgets tab … it should be communicated in UI properly, like app asks separate code when Face ID is
changed and about cooling period and whichever is important."

**Status: built on branch `app-lock-privacy-security` (9 Oct 2026), tested on GitHub; iPhone check pending (U9).** Current Work item 58. Built differently from this spec, and why: the lock cover is in its own window above sheets and alerts (an overlay sat under a sheet), and locking ends typing (the keyboard sits above every window; the typed text stays); "Use Face ID again?" is answered on the cover before the app opens. The decisions behind every line are in
[App Lock and Widget Privacy — What People Expect](<../../../Research/Research Reports/Settings and Help/App Lock and Widget Privacy — What People Expect.md>)
§6a–§6e (decisions 1–4, the user, 9 Oct 2026). Decision 5 (locking only some habits) is in the checklist's Future list.

Rules that apply throughout: native Form rows and system alerts only (U1); monochrome chrome, green switches (U2); plain
words (U11); widgets are locked (U28): this spec changes only what the user approved for decisions 1 and 4, and keeps
§6b of the report (taps at once, every tap saved, sync without opening the app).

---

## 1. The menu: one page for privacy, no Widgets page

| Before | After |
|---|---|
| ≡ → **Privacy** ("Lock the app with Face ID, and erase your data.") | ≡ → **Privacy & Security**, the same `hand.raised` icon. Subtitle: "Lock the app, hide names outside it, and choose what's shared." (the old subtitle promised "erase your data", which the page never had) |
| ≡ → **Widgets** | Removed. Every part of it moves (U5, table below) |

Menu groups become `[.timesOfDay, .dayAndWeek, .reminders, .appearance]` and `[.backup, .privacy]`. Update the menu
order line in Design Rules ("≡ Menu — FINAL") in the same change.

**What the Widgets page showed, and where each part goes (U5):**

| On the Widgets page today | Goes to |
|---|---|
| "Hide widget content" switch | Privacy & Security → **Hide Names Outside the App** (§2.3), with the new meaning (names hidden, widgets keep working) |
| The widget kinds (One habit, Today, This week, Tasks, Lock Screen) and what ✓, +, ▶ do | Help & Feedback → new **Widgets** section, as topics ("Which widgets are there?", "What the buttons on a widget do") |
| How to add a widget to the Home Screen and the Lock Screen | Help → Widgets → "Add a widget" |
| How to choose a habit or a section (Edit Widget) | Help → Widgets → "Choose a habit for a widget" |
| "Open the app after changing your time zone …" | Help → Widgets → "A widget looks out of date" |
| "Widget updates" problem notice with **Try again** (shown only when publishing failed) | Help → Widgets, at the top of the section, only while there's a problem, with the same Try again |
| A widget's **Choose a habit** link (`oftenenough://widgets`, `routeWidgetSetup`) opened the Widgets page | Opens Help → Widgets → "Choose a habit for a widget", replacing whatever was open (as now) |

Every Help answer names the exact button (Design Rules, "Onboarding, empty Today and Help"). The analytics screen
`widgets_settings` stops being sent; don't reuse or rename the value (Analytics Contract). The onboarding link
"Privacy & Optional Usage Sharing" still opens this page.

---

## 2. The Privacy & Security page

A native `Form`, title **Privacy & Security**. Four sections, top to bottom. Rows appear only when they mean something.

### 2.1 Lock off (the default)

```
Privacy & Security
┌──────────────────────────────────────────┐
│ Lock with Face ID                   ( ○) │
└──────────────────────────────────────────┘
 Asks for Face ID each time you open Often
 Enough. Your iPhone checks your face;
 Often Enough never sees it.

 OUTSIDE THE APP
┌──────────────────────────────────────────┐
│ Hide Names Outside the App          ( ○) │
└──────────────────────────────────────────┘
 Widgets, reminders, alarms, the timer on the
 Lock Screen and Siri show icons and numbers
 without habit names. ✓ and + keep working.

 HELP IMPROVE OFTEN ENOUGH
┌──────────────────────────────────────────┐
│ Share Usage                         ( ○) │
│ Share Crash Diagnostics             ( ○) │
└──────────────────────────────────────────┘
 (today's footer, unchanged)

 No ads. An account is optional; without one,
 your habits stay on this phone unless you
 share them.
```

- The switch names the method: "Lock with Face ID", "Lock with Touch ID", "Lock with Optic ID" or "Lock with
  Passcode" (as now).
- **No passcode on this iPhone:** the switch is hidden and the footer says: "To lock Often Enough, set a passcode for
  this iPhone first: Settings → Face ID & Passcode." (as now, with the place named).
- **Turning it on** asks Face ID ("Turn on the lock for Often Enough"); it changes only if that works (as now), then
  publishes widgets at once.

### 2.2 Lock on

```
┌──────────────────────────────────────────┐
│ Lock with Face ID                   ( ●) │
│ Unlock With    Face ID or iPhone Passcode›│
│ Ask Again                     Immediately›│
└──────────────────────────────────────────┘
 Locking your iPhone always locks Often
 Enough straight away.

 OUTSIDE THE APP
┌──────────────────────────────────────────┐
│ Hide Names Outside the App          ( ●) │  ← greyed
└──────────────────────────────────────────┘
 On while App Lock is on. Widgets, reminders,
 alarms, the timer on the Lock Screen and
 Siri show icons and numbers without habit
 names. ✓ and + keep working. To make a
 reminder say something you'll recognise,
 add "Reminder says…" in the habit's
 Reminders.
```

**Unlock With** (a pushed choice page, two rows with a checkmark, each with a line of explanation under it):

| Row | Line under it |
|---|---|
| **Face ID or iPhone Passcode** (default) | "Nothing new to remember. Anyone who knows your iPhone passcode can open Often Enough." |
| **Face ID or Often Enough Code** | "Your iPhone passcode can't open it. If you forget the code, Face ID resets it." |

Footer of that page: "Choose an Often Enough code if people around you know your iPhone passcode."

**Ask Again** (pushed choice page): Immediately (default) · After 1 Minute · After 15 Minutes. Footer: "How long
Often Enough stays open after you switch to another app. Locking your iPhone always locks it straight away."

### 2.3 Hide Names Outside the App

- Lock off: an ordinary switch, default off. Footer as in 2.1.
- Lock on: on and greyed (`disabled`), footer starts "On while App Lock is on." Turning App Lock off returns it to
  whatever the person had chosen before.
- Changing it (or the lock) publishes widgets at once and re-plans reminders, so the next reminder already follows it.
- What it changes (decided, report §6a and §6e): widgets lose habit names, task titles and section names (also for
  VoiceOver); reminders and alarms say the habit's own "Reminder says…" words, or "Reminder · 8:00"; the timer's Live
  Activity shows icon, clock and fill; Siri answers without names and per-habit phrases and suggestions are withdrawn.
  Icons, colours, numbers and the ✓ / + / ▶ buttons stay.

### 2.4 Lock on with an Often Enough code

```
┌──────────────────────────────────────────┐
│ Lock with Face ID                   ( ●) │
│ Unlock With   Face ID or Often Enough Code›│
│ Change Code                              ›│
│ Ask Again                     Immediately›│
└──────────────────────────────────────────┘
 Forgot the code? Face ID resets it. If Face
 ID can't, your iPhone passcode can reset it
 after a 24-hour wait, so no one can do it
 quickly without you seeing.
```

While a reset is waiting, a section appears at the very top of the page (and on the lock screen, §3.5):

```
┌──────────────────────────────────────────┐
│ ⏳ Code reset asked for                   │
│ Tue 10:14. Ready Wed 10:14.              │
│ Cancel Reset                             │
└──────────────────────────────────────────┘
 If you didn't ask for this, cancel it.
```

---

## 3. Every message, in order of when people meet it

### 3.1 Choosing an Often Enough code

Picking **Face ID or Often Enough Code**:

1. Face ID (or the iPhone passcode, this once), reason "Set an Often Enough code". Proves it's the owner.
2. A sheet, title **Your Own Code**, three short lines and one button:
   - "Only Face ID or this code opens Often Enough. Your iPhone passcode won't."
   - "Forgot it? Face ID resets it straight away."
   - "If Face ID can't help, your iPhone passcode resets it after 24 hours. Often Enough tells you on its lock screen
     while a reset is waiting, so you can cancel it."
   - Button **Choose a Code** (filled, at the bottom). ✕ cancels and nothing changes.
3. **Enter a code**: six digits, number pad, dots (as the iPhone's own). Then **Enter it again**. If they differ:
   "The two codes are different. Try again." and back to the first entry.
4. Done: back on the page, the row reads "Face ID or Often Enough Code".

No hints and no security questions (users show they fail and leak, report §6c).

### 3.2 Changing the code and switching back

- **Change Code:** Face ID or the current code, then 3.1 step 3.
- **Switching back to Face ID or iPhone Passcode**, or **turning the lock off**, in code mode: Face ID or the code;
  the iPhone passcode is not accepted (it would undo the point of the code).

### 3.3 The lock screen (the cover)

What shows instead of the app while it's locked: the lock icon, "Often Enough is locked", and:

| Mode | What happens |
|---|---|
| iPhone passcode | Face ID is asked for at once. After a cancel: **Unlock** (as now). |
| Often Enough code | Face ID is asked for at once. After a cancel, or when Face ID can't be used: the code keypad, with **Use Face ID** above it (only if Face ID can be used) and **Forgot Code?** below it. |

**Wrong code:** "That's not the code." The dots shake. After 5 wrong codes in a row the keypad waits, like the iPhone
does: 1 minute, then 5, 15, and 1 hour after each further wrong code, saying "Try again in 5 minutes." Nothing is ever
erased (data safety, D-rules).

### 3.4 Face ID changed (someone may have added a face or a finger)

On the cover, instead of asking Face ID:

> **Face ID has changed on this iPhone**
> A face or a fingerprint was added or removed in Settings. Enter your Often Enough code to continue.
> [keypad]  ·  **Forgot Code?**

After the right code, an alert (it must never silently trust the new set):

> **Use Face ID again?**
> If you changed Face ID yourself, use it again. If you didn't, someone may have added their face: keep Face ID off
> and check Settings → Face ID & Passcode.
> **Use Face ID Again** · **Keep Face ID Off**

"Keep Face ID Off" leaves the code as the only way in; the page's footer then says "Face ID is off for Often Enough.
Turn it back on with Use Face ID Again." with that button in the section. In iPhone-passcode mode a changed Face ID
needs no message (the iPhone's own lock already decides who may unlock).

### 3.5 Forgot the code

**Forgot Code?** opens a sheet, title **Forgot Your Code**:

- If Face ID is available and unchanged: "Use Face ID to choose a new code." Button **Use Face ID** → Face ID → 3.1
  step 3. Done at once.
- Otherwise (Face ID changed, off, broken, a mask): "Your iPhone passcode can reset the code after a 24-hour wait.
  The wait keeps someone who knows your passcode from doing it quickly without you seeing. Your habits stay as they
  are." Button **Start 24-Hour Reset** → iPhone passcode → back on the cover, which now shows:

> **Code reset asked for**
> Tue 10:14. You can choose a new code from Wed 10:14.
> If you didn't ask for this, cancel it with Face ID or your code.
> **Cancel Reset**  ·  [keypad: the code still works throughout]

- A notification at the moment it's asked: "A code reset was asked for. If it wasn't you, open Often Enough and
  cancel it." (No habit names, whatever the setting.)
- When the 24 hours are up, the cover shows **Choose a New Code** → iPhone passcode → 3.1 step 3.
- The wait keeps counting if the app is closed or deleted and reinstalled (its start is kept in the Keychain with the
  code), and changing the iPhone's clock doesn't shorten it (count from the system's uptime and the saved time
  together; check on the iPhone).
- **Cancel Reset** needs Face ID (if trusted) or the code. Typing the right code also cancels a waiting reset, with
  a one-line note: "The code reset was cancelled."

### 3.6 Ask Again

No message. The setting does the explaining (2.2). Rules that hold whatever is chosen (report §6d): never ask while
the app is in front; not after the iPhone's own interruptions; ask by itself on return; return to exactly the same
screen and typed text; every way in (a notification, a widget that opens the app, a link) waits for the unlock.

### 3.7 Reminder says… (in each habit's Reminders)

In the habit form's **Reminders** screen, a section under the reminder times, only while there's a reminder:

```
┌──────────────────────────────────────────┐
│ Reminder Says   Your words, e.g. The usual│
└──────────────────────────────────────────┘
 Shown in this habit's reminders. When names
 are hidden outside the app, it's shown
 instead of the name.
```

- Optional, one line, 24 characters (TextLimit, as names; U6), typed with S11's field rules.
- Names shown: title is the habit's name and the body is these words (when set) instead of the usual line.
  Names hidden: the title is these words, or "Reminder · 8:00" when there are none; a group: "3 reminders · 8:00"; a
  follow-up: "Still open · 8:00" (U3). The + action reads "+1" without a unit while names are hidden.
- Alarms: the same title. `hiddenPreviewsBodyPlaceholder` is "Reminder", so a phone with previews off says the same.
- Saved with the habit and synced like its other fields (D-rules: a database upgrade adds the column only if missing,
  tested from every past version).

### 3.8 On a new iPhone or after a restore

The lock, the code and Ask Again stay on the iPhone they were set on (the code never syncs). After a restore from a
backup or a sign-in on a new phone, the lock is off; Help explains it ("Lock Often Enough on a new iPhone"). The
"Reminder says…" words come along with the habit.

---

## 4. Help topics to add or change (each names the exact button)

- **Widgets** section (§1 table): Which widgets are there · What the buttons on a widget do · Add a widget · Choose a
  habit for a widget · A widget looks out of date.
- **Privacy & Security** section: Lock Often Enough (≡ → Privacy & Security → Lock with Face ID) · Use a code instead
  of your iPhone passcode (Unlock With) · Forgot your Often Enough code (Forgot Code? on the lock screen) · "Face ID has
  changed" (what it means, and Settings → Face ID & Passcode) · Hide names outside the app · Make a reminder say
  something else (the habit's Reminders → Reminder Says) · Lock Often Enough on a new iPhone.

---

## 5. For whoever builds it

- **The code:** store only a salted, slow hash (PBKDF2 or similar) in the Keychain with
  `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly` (never `…WhenPasscodeSetThisDeviceOnly`: those items are deleted
  if the iPhone's passcode is removed, which would leave a code no one can check). Keep the wrong-code count, the wait,
  the reset's start time and the trusted `LADomainState` (`evaluatedPolicyDomainState`) in the same Keychain item.
- **Face ID in code mode:** `.deviceOwnerAuthenticationWithBiometrics` (no passcode fallback); compare the domain state
  before trusting a match (report §6c, point 4). iPhone-passcode mode keeps `.deviceOwnerAuthentication` (as now).
- **Phone lock:** lock at once on `protectedDataWillBecomeUnavailable` whatever Ask Again says; Ask Again counts from
  `.background`. Check both on the iPhone.
- **Widgets (U28):** "hide names" is a different state from today's `hidden` (which drops items and makes
  `WidgetTaps` refuse taps). Discreet widgets keep every item and every tap; strip the words in the app's snapshot, not
  in the widget (U26). Check with `WidgetLatencyDeviceTests` and `-sync-verify` (report §6b). Rename the stored key
  only with a migration that keeps the person's choice.
- **Siri:** `WhatsLeftIntent` and `HabitProgressIntent` answer without names when names are hidden;
  `suggestedEntities` returns none and `updateAppShortcutParameters` runs with no names. Intents keep
  `.alwaysAllowed` where D13 requires it.
- **Live Activity:** the attributes keep the name (for the app's own use), the view draws it only when names are shown;
  an activity already running is updated when the setting changes.
- **Test launches (D8):** `-uitest` keeps the lock off; add a test-only switch that turns the lock on with a fake
  authenticator so the cover, code entry, wrong-code waits, Face-ID-changed and reset flows get UI tests (none exist
  today). T11: the 24-hour wait is tested with a set clock.
- **Tests that change with this (T3):** `WidgetUITests` (the Widgets page and `widgets-hide`, lines 157–160) moves to
  Privacy & Security; `WidgetCheck` and `WidgetReliabilityCheck` expect "Hide widget content turns widget logging off",
  which is no longer true: rewrite them to expect discreet cards whose taps still log.
- **Speed (S2, T4):** a `PerfDriver` scenario for the Privacy & Security page and for the cover with the keypad.
