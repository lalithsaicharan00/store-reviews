# App Lock Redesign — What to Build

Written by Claude (Claude Code), 9 October 2026, from the user's design review the same day. Current Work 58.13.

**Status: designed, approved for implementation by the user (9 Oct 2026); not built.** This folder is everything an
agent needs to build it: this file, the screen images in [`Images/`](Images/), and the Figma section
[App Lock — redesign, main flow](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=935-309)
(iPhone SE, 375 × 667). Read the Rulebook first; U1, U2, U11, U12, U18, U28, D-rules, T3, T4, T15 and U9 apply.

**What it replaces.** The App Lock part of [Privacy & Security — What to Build](<../Privacy & Security — What to Build.md>)
§2.1, §2.2, §2.4 and §3.1, already built on this branch (`PrivacyView.swift`, `LockViews.swift`, `AppLock.swift`).
**The security model does not change**: the Keychain vault, the six-digit code's hash, wrong-code waits, the
Face-ID-changed check, the fixed 24-hour reset, the lock cover in its own window, Lock Again timing, Hide Names
Outside the App, Reminder Says and the discreet widgets all stay exactly as built. What changes is **where things
are, in what order people meet them, and the words**.

---

## 1. Why (the user's review, 9 Oct 2026)

- The App Lock block on Privacy & Security must say what it's for (lock the app) and whether it's on or off.
- Like WhatsApp's App lock: a page with **one switch**, off by default. Everything else appears only once it's on.
- Turning it on must first **ask how to unlock** before setting anything, and explain the choice plainly.
- The old copy was confusing: "Face ID" vs "Often Enough code" vs "your iPhone checks your face; Often Enough never
  sees it". Those lines raised doubts instead of settling them.
- **Say "the app", never "Often Enough"**: people may not connect the brand name with the app they're in.
- Explain clearly, in simple full sentences: Face ID comes first; the separate app passcode; what happens when Face ID
  changes; the 24-hour wait and why it exists.
- No "Recommended" badge: both choices are safe, since the app passcode can always be reset.
- The security delay stays a fixed 24 hours, not a setting (§7).

## 2. Words (one word per idea, everywhere: screens, alerts, Face ID prompts, Help, notifications)

| Idea | Always | Never |
|---|---|---|
| The feature | **App Lock** | app lock, screen lock, "the lock" as a name |
| The app | **the app** / **this app** | Often Enough |
| The phone's biometrics | **Face ID** (Touch ID / Optic ID on those iPhones: use `ability.method`) | biometric, unique identifiers |
| The phone's code | **iPhone passcode** | device passcode, phone code |
| The separate code | **app passcode** | Often Enough code, code (alone), PIN |
| What opens it when Face ID can't | **"If Face ID doesn't work"** | Unlock With, unlock method, fallback, backup (backup is Backup & Export) |
| How soon it locks after leaving | **Lock Again** | Ask Again, Lock After |

Never on screen: "Your iPhone checks your face; the app never sees it", "device-owner authentication", "security
wait", "trusted biometrics".

## 3. The flow

![The whole flow](<Images/0 The whole flow.png>)

```
Privacy & Security ──▶ App Lock (off) ──switch on──▶ [sheet] If Face ID doesn't work
                                                        ├─ iPhone Passcode ─ Turn On App Lock ─ Face ID/passcode ─▶ App Lock (on)
                                                        └─ App Passcode ─ Continue ─▶ How your app passcode works
                                                              ─ Create App Passcode ─ Face ID/passcode ─▶ Enter ─▶ Enter it again
                                                              ─ match ─▶ App Lock (on)          (✕ anywhere: nothing changes)
```

The switch on the App Lock page **stays off until setup finishes**. ✕, a failed Face ID, a mismatch or leaving the
app part-way changes nothing (nothing is saved until the second entry matches and the Keychain write succeeds).

---

## 4. Screen by screen

### Screen 1 · Privacy & Security, App Lock off

<img src="Images/1 Privacy & Security — App Lock off.png" width="300">

- The lock section becomes **one navigation row** (replaces the inline switch, Unlock With, Change Code and Ask Again
  rows in `lockSection`):
  - Icon: SF Symbol `lock.fill`, white on a grey (`.gray`) rounded-square tile, as iOS Settings rows.
  - Title **App Lock**; subtitle (secondary, footnote/subheadline) **Lock the app with Face ID** (method-adaptive:
    "Lock the app with Touch ID", "…with Optic ID"; with no biometrics enrolled: "Lock the app with your passcode").
  - Value **Off** / **On**, chevron. Pushes the App Lock page (screens 2 and 7). Accessibility: one element, "App Lock,
    Off, Lock the app with Face ID", button; id `privacy-app-lock`.
  - No section footer under it (the row says it all).
- **Outside the app** section, as built (`privacy-hide-names`), footer reworded: **Widgets, reminders, alarms and Siri
  show icons and numbers instead of habit names.** The details dropped from the footer (the timer on the Lock Screen,
  ✓ and + keep working, the Reminder Says hint) stay in Help → "Hide names outside the app" (§6), so nothing is lost
  (U5).
- **Help improve the app** (header renamed from "Help Improve Often Enough"). ⚠ The Share Usage / What's Shared /
  Crash Diagnostics "Not available yet" / Privacy Policy rows in the images come from a **separate, unapproved
  proposal** (Codex, Figma 915:309). **Leave that section as built** apart from the header text; it is not part of
  this work.
- The **"Code reset asked for"** section that the built page shows at the top while a reset waits moves to the top of
  the App Lock page (§4, screen 7), reworded there.

### Screen 2 · App Lock, off

<img src="Images/2 App Lock — off.png" width="300">

- New pushed page, title **App Lock** (inline). A `Form` with one section:
  - `Toggle` **Lock with Face ID** (method-adaptive, as built: `"Lock with \(ability.method)"`), off. id `privacy-lock`.
  - Footer, two short paragraphs: **The app will ask for Face ID each time you open it.** / **Widgets and reminders
    keep working, without habit names.**
- **No passcode on this iPhone:** the switch is shown disabled and the footer reads **To use App Lock, set a passcode
  for this iPhone first: Settings → Face ID & Passcode.** (Built hides the switch; showing it disabled explains why.)
- Turning the switch **on** never sets anything by itself: the switch springs back off at once and the setup sheet
  (screen 3) opens. It reads on only after setup finishes.

### Screen 3 · Set Up App Lock (sheet): If Face ID doesn't work

<img src="Images/3 Set Up App Lock — if Face ID doesn't work.png" width="300">

- A `.large` sheet with its own `NavigationStack`, title **Set Up App Lock** (inline, one line), icon-only ✕ on the
  left (accessible name **Cancel**, U18).
- Heading (title2, bold): **If Face ID doesn't work**. Under it (secondary): **Face ID is always tried first. Choose
  what opens the app when it can't recognise you.**
- One section, two selectable rows (checkmark on the selected one, ink colour, `.isSelected` trait), **no badge**:
  - **iPhone Passcode** — *Nothing new to remember. Anyone who knows your iPhone passcode can open the app.*
    Selected by default. id `setup-iphone-passcode`.
  - **App Passcode** — *Six digits, just for this app. Your iPhone passcode won't open it. Good if people around you
    know it.* id `setup-app-passcode`.
- Full-width filled ink button at the bottom (`safeAreaInset(edge: .bottom)`, as `DayButton(prominent:)`), its label
  says what happens next:
  - iPhone Passcode selected: **Turn On App Lock** → `AppLock.authenticate(reason: "Turn on App Lock")`
    (`.deviceOwnerAuthentication`) → success: `AppLock.setEnabled(true)`, dismiss, the App Lock page shows screen 7
    with ✓ iPhone Passcode, publish (`privacyChanged`). Failure/cancel: stay on the sheet, nothing changes.
  - App Passcode selected: **Continue** → push screen 4.
- **No Face ID or Touch ID enrolled** (passcode only): skip the sheet; the switch authenticates and turns on in
  iPhone-passcode mode directly (an app passcode without Face ID could only ever be reset by the 24-hour wait).
- The image shows App Passcode selected (the button reads Continue).

### Screen 4 · How your app passcode works

<img src="Images/4 How your app passcode works.png" width="300">

- Pushed inside the sheet, title **App Passcode**, back chevron.
- Heading (title2, bold): **How your app passcode works**.
- One section, three rows, each a bold line and a secondary sentence (text only, no accessories, not tappable):

| Bold line | Sentence |
|---|---|
| **If you forget it** | Use Face ID to choose a new app passcode. |
| **If Face ID changes** | Whenever Face ID is changed on your iPhone, the app asks for your app passcode once, so no one else can get in with their face. |
| **If you forget it and Face ID can't help** | For example, if Face ID is broken or turned off. Your iPhone passcode can set a new app passcode after a 24-hour wait. The wait gives you time to notice and cancel it if it wasn't you. |

- Footer: **Your habits are never deleted, whatever happens.**
- Bottom button **Create App Passcode** → owner check: `AppLock.authenticate(reason: "Create your app passcode")`
  (Face ID or the iPhone passcode, this once; as built for "Set an Often Enough code") → push screen 5. Failure:
  stay.
- "If Face ID changes" is one rule for everyone on purpose: iOS only says the enrolled set changed
  (`LADomainState`), never whose face, so the owner's own change and someone else's are treated the same.
- This screen replaces the built `YourOwnCodeSheet` intro ("Your Own Code", three labels, "Choose a Code").

### Screens 5 and 6 · Enter, then enter it again

<img src="Images/5 Create app passcode.png" width="300"> <img src="Images/6 Enter it again.png" width="300">

- Pushed inside the sheet, title **App Passcode**, back chevron. Reuse the built `CodeEntry` (six dots, round keys,
  number pad), with:
  - Screen 5 prompt **Enter a six-digit passcode**, and under the dots (secondary): **You'll only need it when Face ID
    doesn't work.**
  - Screen 6 prompt **Enter it again**.
  - Different: back to screen 5, cleared, with **The passcodes didn't match. Try again.** (replaces "The two codes are
    different. Try again.").
- On a match: save as built (salted slow hash, Keychain this device only, the current `LADomainState`), turn the lock
  on in app-passcode mode, dismiss the sheet, publish. The App Lock page shows screen 7.
- Back from 6 returns to 5 (first entry cleared). Back from 5 returns to 4.

### Screen 7 · App Lock, on

<img src="Images/7 App Lock — on.png" width="300">

The same page as screen 2, now showing everything (progressive disclosure):

1. *(Only while a reset waits, at the very top)* a section: **⌛ App passcode reset asked for** / *Tue 10:14. Ready
   Wed 10:14.* / button **Cancel Reset** (id `privacy-cancel-reset`); footer **If you didn't ask for this, cancel
   it.** Behaviour as built (`cancelReset`: Face ID or the app passcode). Not drawn.
2. `Toggle` **Lock with Face ID**, on. Footer: **Habit names are hidden on widgets, reminders and Siri while App Lock
   is on.**
3. Section header **If Face ID doesn't work**: two inline rows with a checkmark, **iPhone Passcode** / **App
   Passcode** (replaces the pushed Unlock With page). ids `unlock-iphone-passcode`, `unlock-app-passcode`. Footer by
   mode:
   - App passcode: **Only Face ID or your app passcode opens the app. Your iPhone passcode can't.**
   - iPhone passcode: **Anyone who knows your iPhone passcode can open the app.**
   - Switching to **App Passcode**: open the setup sheet straight at screen 4 (owner check, then 5 → 6), as built's
     `chooseUnlock(.code)`. Switching to **iPhone Passcode** from app-passcode mode: `confirmOwner` (Face ID or the
     app passcode, **never** the iPhone passcode), then `removeCode()`, as built.
4. *(App passcode only)* **Change App Passcode ›** (id `privacy-change-code`): `confirmOwner("Change your app
   passcode")`, then screens 5–6 in a sheet titled **Change App Passcode**.
5. *(App passcode only, when Face ID is off for the app)* **Use Face ID Again** (id `privacy-use-face-id-again`), and
   the section footer starts **Face ID is off for the app. Turn it back on with Use Face ID Again.** As built. Not
   drawn.
6. **Lock Again** as a native menu `Picker` (`.pickerStyle(.menu)`) in its row: **Immediately** · **After 1 Minute**
   · **After 15 Minutes** (replaces the pushed Ask Again page; same stored value `AppLock.askAgain`). id
   `privacy-lock-again`. Footer: **After you leave the app. Locking your iPhone always locks the app straight away.**

Turning the switch **off**: `confirmOwner("Turn off App Lock")` (in app-passcode mode Face ID or the app passcode,
never the iPhone passcode), then `turnOff()` as built; the page collapses back to screen 2.

The image shows app-passcode mode. In iPhone-passcode mode rows 4 and 5 are absent.

### Screen 8 · Privacy & Security, App Lock on

<img src="Images/8 Privacy & Security — App Lock on.png" width="300">

- The App Lock row's value reads **On**.
- Hide Names Outside the App is on and disabled while App Lock is on (as built); footer: **On while App Lock is on.**
  then the same sentence as screen 1. Turning App Lock off restores the person's own choice (as built).

---

## 5. Screens not redrawn: same behaviour, new words

The lock cover, Forgot, the reset and the alerts keep their built layout and behaviour for now (a redesign of the
lock screen is the next design round). Update only their words, so the whole feature speaks one language:

| Where (built) | Now | Becomes |
|---|---|---|
| Cover title (`LockViews` 20, 103, 149) | Often Enough is locked | **The app is locked** |
| Cover, reset ready (136) | The 24 hours are up. Choose a new code with your iPhone passcode. | **The 24 hours are up. Choose a new app passcode with your iPhone passcode.** |
| Button (140, 123) | Choose a New Code | **Choose a New App Passcode** |
| Face ID changed title / detail (146–147) | Face ID has changed on this iPhone / A face or a fingerprint was added or removed in Settings. Enter your Often Enough code to continue. | **Face ID was changed on this iPhone** / **Enter your app passcode to continue.** |
| Alert after the right passcode (126–130) | Use Face ID again? · If you changed Face ID yourself, use it again. If you didn't, someone may have added their face: keep Face ID off and check Settings → Face ID & Passcode. · Use Face ID Again / Keep Face ID Off | **Did you change Face ID?** · **If it wasn't you, someone may have added their face. Turn Face ID off for the app and check Settings → Face ID & Passcode.** · **Yes, Use Face ID** / **No, Turn It Off** ⚠ to confirm with the user in the lock-screen round; keep the question (typing the passcode must never silently trust a changed set, spec §3.4) |
| Keypad prompt (157, 491) | Enter your code / Enter your Often Enough code | **Enter your app passcode** |
| Button (160) | Forgot Code? | **Forgot App Passcode?** |
| Wrong entry (`AppLock` 285, 410) | That's not the code. | **That's not your app passcode.** |
| Reset waiting (174–177) | Code reset asked for · …You can choose a new code from Wed 10:14. · …cancel it with Face ID or your code. | **App passcode reset asked for** · **…You can choose a new app passcode from Wed 10:14.** · **…cancel it with Face ID or your app passcode.** |
| Cancelled (`AppLock` 265, 343) | The code reset was cancelled. | **The reset was cancelled.** |
| Forgot sheet title (475) | Forgot Your Code | **Forgot App Passcode** |
| Forgot, Face ID (450) | Use Face ID to choose a new code. | **Use Face ID to choose a new app passcode.** |
| Forgot, no Face ID (462) | Your iPhone passcode can reset the code after a 24-hour wait. The wait keeps someone who knows your passcode from doing it quickly without you seeing. Your habits stay as they are. | **Your iPhone passcode can set a new app passcode after a 24-hour wait. The wait gives you time to notice and cancel it if it wasn't you. Your habits stay as they are.** |
| Code-check sheet title (`AppLock` 388) | Enter Your Code | **Enter Your App Passcode** |
| Reset notification (`AppLock` 332–333) | title Often Enough · A code reset was asked for. If it wasn't you, open Often Enough and cancel it. | title **App Lock** · **A reset of your app passcode was asked for. If it wasn't you, open the app and cancel it.** |
| Face ID prompt reasons (`AppLock` 237, 302, 322, 327, 340, 352; `PrivacyView` 97, 134, 137, 153, 156, 164) | Unlock Often Enough · Use Face ID for Often Enough · Choose a new Often Enough code · Reset your Often Enough code · Cancel the code reset · Turn on/off the lock for Often Enough · Set an Often Enough code · Use your iPhone passcode for Often Enough | **Unlock the app** · **Use Face ID for the app** · **Choose a new app passcode** · **Reset your app passcode** · **Cancel the reset** · **Turn on App Lock** / **Turn off App Lock** · **Create your app passcode** · **Use your iPhone passcode for the app** |

The "Start 24-Hour Reset", "Cancel Reset", "Use Face ID" and wrong-passcode wait texts ("Try again in 5 minutes.")
stay as they are.

## 6. Help topics (`HelpView.swift`, Privacy & Security section), rewritten

| Question | Answer |
|---|---|
| **Lock the app** | In ≡ › Privacy & Security, tap App Lock and turn on Lock with Face ID, then choose what opens the app if Face ID doesn't work. Lock Again sets how long it stays open after you leave it; locking your iPhone always locks it. |
| **Use an app passcode instead of your iPhone passcode** | In ≡ › Privacy & Security › App Lock, under If Face ID doesn't work, choose App Passcode and create a six-digit passcode. Your iPhone passcode no longer opens the app, so people who know it can't. |
| **Forgot your app passcode** | On the lock screen, tap Forgot App Passcode?. Face ID lets you choose a new one straight away. If Face ID can't help, tap Start 24-Hour Reset: after 24 hours your iPhone passcode lets you choose a new one. Your habits stay as they are. |
| **"Face ID was changed"** | Whenever Face ID is changed on your iPhone, the app asks for your app passcode once, so no one else can get in with their face. If you made the change, choose Yes, Use Face ID; if not, turn it off and check Settings › Face ID & Passcode. |
| **Hide names outside the app** | In ≡ › Privacy & Security, turn on Hide Names Outside the App. Widgets, reminders, alarms, the timer on the Lock Screen and Siri then show icons and numbers without habit names, and ✓ and + still work. It's always on while App Lock is on. To make a reminder say something you'll recognise, add Reminder Says in the habit's Reminders. |
| **Make a reminder say something else** | (unchanged) |
| **App Lock on a new iPhone** | App Lock and your app passcode stay on the iPhone they were set on. After moving to a new iPhone or restoring a backup, App Lock is off: turn it on again in ≡ › Privacy & Security › App Lock. Your Reminder Says words come with your habits. |

Also in Help: "A widget looks out of date" starts "Open the app: …" (the rule in §2).

## 7. Decisions and why (reasoned from first principles; review evidence is in the report)

- **One decision per screen.** Off page: on or off. Sheet: what opens the app when Face ID can't. Explainer: only for
  people who picked the app passcode, so the default path is two taps and one Face ID.
- **Face ID is never the choice.** Both ways use Face ID first, so the question is only what happens when it doesn't
  work. The earlier design read as "Face ID or a passcode".
- **Each option carries its one trade-off** so no one picks without knowing who else can get in. Default iPhone
  passcode: 406 lock-out reviews came from separate codes; 29–38 ask for a separate code because family knows the
  passcode ([report §2, §6c](<../../../../Research/Research Reports/Settings and Help/App Lock and Widget Privacy — What People Expect.md>)).
- **Explain before creating**: the recovery rules come before the passcode exists, when they decide whether to go on.
- **Nothing turns on until setup finishes**, so a half-done setup can never lock anyone out.
- **The security delay is a fixed 24 hours, not a setting** (the user asked us to decide, 9 Oct 2026). A setting adds
  a decision for a case most people never meet (forgot the app passcode *and* Face ID can't help). Shorter helps
  someone who knows the iPhone passcode; longer makes a real lock-out longer. What protects people is the visible
  request and Cancel, not the exact length; 24 hours means the owner sees it next time they pick up the phone.
  Apple's own security delay is fixed too. Revisit only if people get stuck on the wait or ask for a longer one.
- **Is the user's summary of the report right?** Yes: Face ID first; the iPhone passcode is the default way in when
  it fails; the app passcode is the option; forgot it → Face ID sets a new one at once; Face ID changed → the app
  passcode once; only when Face ID can't help, the iPhone passcode sets a new one after 24 hours. The wait slows
  someone down; it can't stop someone who has the phone and its passcode for a day unnoticed (the accepted limit,
  so no one is ever locked out of their own habits).

## 8. For whoever builds it

**Files.**
- `iOS/Habits/Menu/PrivacyView.swift`: `lockSection` → the App Lock row (screen 1); new `AppLockPage` (screens 2 and
  7) holding the switch, the inline If Face ID doesn't work rows, Change App Passcode, Use Face ID Again, Lock Again
  menu and the reset-waiting section; remove `UnlockWithPage` and `AskAgainPage` (their jobs move inline; keep
  `AskAgainPage.name` or an equivalent for the menu's labels). Hide-names footer and header text (§4, screen 1).
- `iOS/Habits/App/LockViews.swift`: the setup sheet (screens 3–6) replaces `YourOwnCodeSheet`'s intro and reuses
  `NewCodeSheet`/`CodeEntry`; every string in §5.
- `iOS/Habits/App/AppLock.swift`: strings in §5 only. **No change to the vault, hashing, waits, domain state, reset
  timing or the cover window.**
- `iOS/Habits/Help/HelpView.swift`: §6.
- Widgets are locked (U28): nothing here touches widget code; `privacyChanged()` publishing stays as built.

**Accessibility (U1).** Rows are single elements with label, value and selected traits; the sheet's ✕ is "Cancel";
headings are headers; Dynamic Type up to accessibility sizes (screen 4's rows wrap; the page scrolls).

**Tests (T3, T7).** Ids that move or go: `privacy-unlock-with` (gone → `unlock-iphone-passcode` /
`unlock-app-passcode` on the App Lock page), `unlock-with-code`, `privacy-ask-again` and `ask-again-0/60/900` (gone →
`privacy-lock-again` menu), `lock-your-own-code` / `lock-choose-code` (→ the setup sheet: `setup-app-passcode`,
`setup-continue`, `setup-create-app-passcode`), `privacy-lock` (now on the App Lock page, reached through
`privacy-app-lock`). Update `AppLockUITests`, `SmallScreenUITests` and any test that reads the changed labels. Add:
turning on with iPhone Passcode; turning on with App Passcode through 3 → 4 → 5 → 6; ✕ on each step leaves the switch
off; a mismatch returns to 5; switching modes both ways; Lock Again menu.

**Small screens (T15).** Screens 3–7 were designed on the SE (375 × 667) and fit without scrolling at the default text
size; check on the SE simulator with the frames named on one line (T14).

**Speed (T4, S2).** A `PerfDriver` scenario for opening the App Lock page and the setup sheet.

**iPhone (U9).** Look at every screen on the real iPhone before calling it done; check Face ID, Touch ID wording
and a phone without a passcode.

## 9. Not designed yet (next round, after this is built or as the user asks)

The lock cover and its states (locked, wrong passcode and waits, Forgot, Face ID changed and its question, reset
waiting and ready), the Change App Passcode sheet's own look, and the mini and 6.1-inch sizes. Until then they keep
their built layout with §5's words.

## 10. Checklist (the user's points, 9 Oct 2026)

- [x] Sync `main` and `app-lock-privacy-security`; read the App Lock report and spec.
- [x] The App Lock block says what it's for and whether it's on or off.
- [x] App Lock opens with one switch, off by default; options appear once it's on.
- [x] Turning it on first asks what opens the app when Face ID doesn't work.
- [x] One set of words; drop lines that raise doubts; "the app", never "Often Enough".
- [x] Explain Face ID first, the app passcode, a changed Face ID and the 24-hour wait in simple full sentences.
- [x] Remove the Recommended badge.
- [x] Decide whether the security delay is a setting: no, fixed 24 hours (§7).
- [x] Document the whole flow with images in one folder for implementation; push to `app-lock-privacy-security`.
- [ ] Build it (§8), tests on GitHub, then the iPhone check (U9).
- [ ] Design the lock cover and recovery screens (§9).
