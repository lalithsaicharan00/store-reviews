# App Lock — Private Without Lock-outs

Written by Claude (Claude Code), 30 September 2026. A lock for the iOS app. Ledger cards [C017](<../Feature Ledger.md#c017>) (passcode lock: 15 apps, Strong, "decide whether needed at all") and [C096](<../Feature Ledger.md#c096>) (privacy and discretion stack: Face ID lock, no account, discretion; "category-critical for recovery users on family phones"). The app already keeps everything on the phone with no account; this adds the lock.

## Answer

1. **Settings → Privacy → Lock with Face ID** (Touch ID or Optic ID on those phones), off by default and free.
2. **The iPhone's own Face ID and passcode, never a separate code.** If Face ID fails, the iPhone passcode opens it, so no one can be locked out of their own history.
3. **It turns on or off only after Face ID works once**, so it can't be switched on in a state that locks the person out.
4. **Nothing shows before the lock.** The setting is read before the first frame; whenever the app isn't in front, a plain cover hides it (so the app switcher shows "Habits is locked", not the list).
5. **It asks by itself when you come back,** once. A cancelled prompt leaves an Unlock button rather than asking again and again.
6. **The widget stays discreet:** while the lock is on it shows icons and counts, not names ("Habit"), and still ticks.

## What the reviews say

Keyword scan of habit and routine trackers' App Store and Play Store reviews (1,238,784 reviews, 229 mention a passcode, Face ID, Touch ID or an app lock; `Research/Temp/stats/lock/`), samples read by hand. The groups overlap and include noise (Face ID also confirms purchases), so counts are rough.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Liking the lock | 65 | 16 | 4.54 |
| Asking for one | 47 | 22 | 4.28 |
| Lock charged for, or moved to paid | 16 | 8 | 2.38 |
| Lock leaking (widget, background) | 13 | 7 | 3.92 |
| Locked out, or stuck asking | 2 | 1 | 2.00 |

- **It's wanted because habits are personal.** Users show: "I … think of this personal development as a kinda intimate thing, I would love if you added an option to lock the app with a passcode or Touch ID/Face ID" (Streaks, 5★, `3222394240`); "I especially like the app lock option so you have to verify it's you with touch id or password so your family can't …" (Finch, 5★, `8294662483`); "Love the Face ID lock feature as well" (Days Since, 5★, `9521396070`).
- **A separate code locks people out.** Users show: "LOCKED OUT OF APP — I am locked out of my app and have zero way to get back in … It was asking me to put a pin password in on a numeric keypad" (Way of Life, 1★, `11882060257`). Hence the iPhone's own passcode as the fallback, always.
- **A prompt that repeats is broken.** Users show: "can't open the app as it's continuously scanning tha face again and again" (Way of Life, 3★, `9616858460`). Hence one automatic ask per return, then a button.
- **A lock that leaks is worse than none.** Users show: "FaceID and passcode are not required if the app is running in background and open it again" (Today, 4★, `3674778427`); "What is the point of protecting your goals with password / touchid / faceid if 3D Touch widget reveals all my habits" (Today, 4★, `5116388115`). Hence locking whenever the app leaves the screen, the cover in the app switcher, and a widget without names.
- **Don't charge for it, and never move it to paid.** Users show: "The latest update changes the option for TouchID in a paid feature … I really feel scammed now" (Do Habits, 1★, `3873301504`); "Passcode should be free" (Productive, 2★, `1349485581`).
- **Ask by itself.** Users show: "Touch ID only unlock (currently you need to tap the icon 'unlock' to enable Touch ID)" (HabitMinder, 4★, `3399514212`).

## Reasoned from first principles

- **Off by default** (C006): most people don't need it, and Face ID on every open would slow the most frequent task.
- **Locks each time the app leaves the screen,** not after a timer: simple to predict, and Face ID takes under a second.
- **Kept on this iPhone, not in backups:** a lock belongs to a device; restoring a backup on a new phone shouldn't lock it before Face ID is set up there.
- **The widget still works while discreet,** because ticking without opening the app is its point (widget report); only the names go.

## Not built yet

- Notifications still name the habit on the Lock Screen unless iOS's own Show Previews is set to When Unlocked; How It Works says how.
- Siri and Shortcuts answers aren't behind the lock.
- A discreet app icon (C096), with the icon work.

## Limits

Keyword counts are rough. The lock hasn't been tried on a device: this cloud session can't build Swift.
