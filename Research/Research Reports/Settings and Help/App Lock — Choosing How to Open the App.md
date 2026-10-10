# App Lock — Choosing How to Open the App

Written by Claude (Claude Code), 10 October 2026, for Current Work 58.13. The user's iPhone check that day found App
Lock skipping its whole setup when Face ID was switched off for the app, and the user then set out a model for App Lock
and asked: "Those are my assumptions. So do some research. Figure it out. If they are okay, then update the designs."
This note tests each assumption against the evidence and against what iOS allows, and records where the design
follows it, where it adjusts it and why. The screens are in Figma:
[App Lock — how to open the app, and every case](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=1003-309)
(23 screens, iPhone SE).

**Evidence used.** Review evidence comes from the earlier study
[App Lock and Widget Privacy — What People Expect](<App Lock and Widget Privacy — What People Expect.md>) (8–9 Oct 2026:
1,487,223 reviews scanned, 3,861 read one by one, 2,205 on topic; its counts are quoted here, not recounted). **No new
review scan was made for this note**; where the reviews say nothing, the reasoning is marked "reasoned from first
principles". iOS behaviour comes from Apple's documentation, cited inline, and from the user's own iPhone (10 Oct 2026).

## The user's model (10 Oct 2026)

1. Turning App Lock on never locks straight away with the iPhone passcode; it always asks first.
2. People choose their **everyday way** to open the app: **Face ID** (the default), **iPhone Passcode** or **App
   Passcode**.
3. **An app passcode is always made**, whichever way is chosen. With Face ID or the iPhone passcode it is the backup,
   asked when something changes; with App Passcode it is the only way in.
4. With App Passcode as the everyday way, Face ID and the iPhone passcode play no part; a forgotten app passcode has
   only a **24-hour security delay**, then a new one. No data is ever lost.
5. With Face ID or the iPhone passcode, if Face ID doesn't work or has changed, the iPhone passcode can reset the app
   passcode; if there's no iPhone passcode, the 24-hour delay alone.
6. An iPhone with **no passcode at all** can still use App Lock, with the app passcode only.
7. The screens never say "Lock with Face ID" (or show a switch that reads as on) when Face ID can't be used, and they
   say plainly why: Face ID not allowed for the app, Face ID not set up, no passcode.

## Verdict, point by point

| # | Holds? | Why |
|---|---|---|
| 1 | **Yes** | The bug that started this: the app took "Face ID switched off for the app" for "no Face ID" and skipped every question. Reasoned: a security setting should never be decided for the person without them seeing it. |
| 2 | **Yes, with one limit iOS imposes** | Users show the choice is real: 63 reviews want Face ID instead of typing a code, 38 want a code separate from the iPhone's because the people around them know it, 13 want the iPhone passcode as the way back in. Face ID as the default fits the larger group. **The limit:** an app can't ask for the iPhone passcode on its own; `deviceOwnerAuthentication` "prompts for biometrics when they're available and falls back to the passcode", and there is no passcode-only policy ([LAPolicy](https://developer.apple.com/documentation/localauthentication/lapolicy/deviceownerauthentication)). So "iPhone Passcode" opens the app the way the iPhone opens: Face ID first when the app may use it, then the passcode. The design says so on the row (A2) instead of promising passcode-only. Someone who wants no Face ID at all chooses App Passcode. |
| 3 | **Yes** | One model for everyone, and nobody is ever stuck when Face ID or the passcode goes away. The known risk is the Apple Notes trap: a password made once and never typed is forgotten (406 lock-out reviews, 2.03★; "if you forget a password that you created years ago and weren't asked for since then, those notes are gone", Notes, 1★, `8627894676`). Here a forgotten app passcode never loses anything: the everyday way sets a new one at once while it works (D1, D2), and otherwise the 24-hour delay does. **One correction to "asked whenever anything changes":** iOS tells an app when Face ID changes (`LADomainState`) or when the passcode is turned off (`canEvaluatePolicy` fails), but never when the passcode is only changed. The screens say "turned off", not "changed" (A7, C3). |
| 4 | **Yes** | Reasoned: with Face ID and the iPhone passcode excluded by the person's own choice, nothing else on the phone can prove who they are, so a wait is the only safe way back. It's Apple's own idea for the same problem (Stolen Device Protection's security delay). The wait protects only while the owner opens the app now and then: the lock screen shows the waiting reset every time (C5), a notification says so, and the right passcode cancels it. Someone who holds the phone for a whole day unseen still gets in; that is the accepted limit of "never lose your own data" (earlier study §6c). |
| 5 | **Holds, with one adjustment for the Face ID way** | **iPhone Passcode way:** the iPhone passcode resets the app passcode **at once** (D2). It already opens the app every day, so this gives nobody anything new. **Face ID way:** the iPhone passcode resets it **after the 24-hour wait** (D3), as designed on 9 Oct. If it reset at once, anyone who knows the iPhone passcode could get in: fail Face ID, tap Forgot, type the iPhone passcode. The Face ID way would then protect no more than the iPhone Passcode way, and the 38 people who want a code apart from the iPhone's would lose what they chose it for. **No iPhone passcode:** the wait alone (D4). For the user to confirm. |
| 6 | **Yes** | Users show it: "I like being able to creat a separate password for my notes, and not having to have a password on my phone to lock a note" (Notes, 5★, `11163066888`). Face ID can't exist without a passcode, so App Passcode is the only choice there (A5), with the wait alone if it's forgotten. |
| 7 | **Yes** | Reasoned, and the user's own iPhone shows it: a switch labelled for Face ID turned on, and the person assumed Face ID was on. The switch is now just **App Lock** (A1); each way's availability is shown where it's chosen (A3–A5) and on the page (B4). |

## Every case, and what iOS lets the app do about it

| Case | What iOS tells the app | What the screens do |
|---|---|---|
| Face ID set up and allowed | `canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics)` succeeds | Face ID is the default (A2). The first Face ID check during setup shows iOS's "Allow Face ID?" question. |
| Face ID set up, **switched off for the app** (Settings › Face ID & Passcode › Other Apps) | The check fails, but `biometryType` still says Face ID (seen on the user's iPhone, 10 Oct 2026) | Face ID can't be chosen; "Allow Face ID in Settings" (A3). If it was chosen before and switched off later, the choice stays and the app passcode opens the app meanwhile (B4, C2). |
| Face ID not set up, or no Face ID | The check fails with "not enrolled", or `biometryType` is none | "Not set up on this iPhone", with where to set it up (A4). An app can open only its own Settings page (`openSettingsURLString`), not Face ID & Passcode, so the row names the path. |
| No iPhone passcode | `deviceOwnerAuthentication` can't be evaluated | Face ID and iPhone Passcode unavailable, App Passcode chosen (A5). |
| Face ID locked out after failed tries | Biometrics fail until the iPhone passcode is typed | Face ID way: the app passcode (C1). |
| Face ID enrolment changed | `LADomainState` differs | Face ID way: the app passcode once, then "Did you change Face ID?" (screens 9–10, 9 Oct). |
| iPhone passcode turned off | `deviceOwnerAuthentication` fails; Face ID goes with it | Face ID and iPhone Passcode ways: the app passcode (C3). |
| iPhone passcode changed | Nothing | Nothing to do; the iPhone passcode simply keeps working. |

## Not settled by this note

- **The user's call on point 5** (the Face ID way's reset: after 24 hours, as recommended, or at once).
- Whether App Passcode should still offer Face ID for a forgotten passcode when the iPhone has it (the user said no:
  "we don't care about iPhone passcode or Face ID"). Followed as said.
- How often the backup passcode should be asked so it isn't forgotten. Not proposed: a forgotten backup costs at
  most a day's wait, never data, and asking for it unprompted adds the friction 24 reviews complain about.
- Real-iPhone checks of the switched-off and not-set-up states, and of the "Allow Face ID?" question's timing.
