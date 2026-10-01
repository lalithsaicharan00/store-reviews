# Undo After Logging

Written by Claude (Claude Code), 29 September 2026. Build Plan #57, "easy undo after checking or logging (snackbar or a suitable native presentation)". The Feature Ledger settles *that* undo is needed: [C223](<../Feature Ledger.md#c223>) (Certain, 11 apps: undo is a visible button, never a gesture-only path) and [C262](<../Feature Ledger.md#c262>) (undoing a wrong entry stays free). This check is about *how* and *where*.

## Answer

1. **After a tap logs something on Today, a small bar at the bottom says what was logged and offers Undo**: "Water: +1 glass · Undo". It stays about 6 seconds (20 with VoiceOver), then goes by itself. Nothing is asked before the tap.
2. **Undo takes back exactly what that tap added**: one glass, one tick, one step, the amount just typed. Never the whole day. The biggest single complaint after "I can't uncheck it" is having to reset a whole day to fix one wrong number.
3. **The visible ways back stay too.** A tick's ✓ is tapped again to take it back; amounts and time keep Undo Last Entry in the long-press menu; any day's entries can be deleted one by one from the habit page's day sheet (built in loop 1).
4. **No confirmation before logging, no long-press to log, no shake.** Confirmation dialogs and press-and-hold add a step to the most frequent action ([C264](<../Feature Ledger.md#c264>): never add a tap to the logging path), and a confirmation that "appears too often" is itself a complaint (C223). Shake-to-undo is the complaint that started C223.
5. **Not for pausing a timer.** In the routine player, Undo after Pause deleted the session's time instead of un-pausing (found by hand, 29 Sep); ⏸ saves the time and the row says so. Typing time by hand does get Undo.

## What the reviews say

Scan of 1,238,784 App Store and Play Store reviews for undo, uncheck / untick / unmark / uncomplete, "by mistake", "accidentally" or mis-tap, together with a habit word (`Research/Temp/scan.py`): 1,203 hits. The 1,162 English ones were read by hand, around the matching phrase, after removing those about purchases and deleted apps.

| Theme (pattern-matched, then read) | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Can't undo or uncheck an accidental check or log | 200 | 47 | 3.26 |
| Asks for an undo *button* by name | 44 | 14 | 3.93 |
| Shake-to-undo (all negative or confused) | 8 | 2 | 3.12 |

**It's the accidental tap, and it matters to honest people.** "I accidentally ticked that I'd taken my medication one day and discovered that you cannot undo a task ticked off by mistake (this, in my opinion is worrying)" (Fabulous, 1★, `5911520819`). "I always accidentally click one and then feel guilty for lying" (Finch, 5★, `10470650664`). Fabulous refuses unchecks on purpose, and it's the largest group in the scan (69 reviews across its two listings).

**A button, not a gesture.** "An undo button (rather than shake to undo). I don't want to shake the phone" (Streaks, 4★, `6906929739`); "Worst part is definitely that you need to shake your phone to undo a completed task" (Streaks, 2★, `10535886439`); "The shake to undo option rarely works" (Streaks, 3★, `7273743439`); "not possible to manually undo a completed entry except by shaking immediately after" (Streaks, 2★, `14245262334`). Habitica alone has 16 "undo button" requests: "Great app, but it needs an undo button badly!" (`2eadce7c-98d1-424d-a995-0530772a43a5`).

**Right after the action, where it happened:** a UX designer's suggestion, "adding an Undo option in the 'Task Finished' snackbar. A small action button like [Undo]" (To Do List, 3★, `6ffd6bc1-ed20-415c-9f70-749d0f6c3357`). Where an app has one, it's praised: "there is a very helpful undo button" (Tasks, 5★, `6f9e8cc8-37bf-495e-9113-4eabaad2ca38`). **But not gone too fast:** "if you … cannot hit the undo button before it disappears, the only way to get that item back…" (Tasks, 4★, `4ca246e9-e28c-47d1-a190-c8d8075d0e16`); "the undo button should always be there" (Tasks, 5★, `1fefc488-7562-45ee-9eea-9e5a0d83ec20`). Hence 6 seconds rather than the player's 4, the other visible ways back, and a longer time with VoiceOver.

**Exactly the wrong entry, not the day:**

- "if you accidentally add the wrong amount of time, there seems to be no way to undo it except to reset the timer for the full day" (Habit Tracker, 3★, `11377690769`).
- "Often I subtract some accidentally, and want to undo, but the only undo button is to reset the whole day" (Habit Tracker, 4★, `10438584903`).
- "if I stretched 3 times a day but accidentally put four. I have to reset the entire habit" (Habit Tracker, 4★, `9466621749`).
- "How to undo a value log?! … allowing users to undo or modify a wrong value log" (Habitify, 4★, `13588028708`).
- "Can't decrement if incremented by mistake" (Streaks, 3★, `1389005299`); "if you accidentally put your water intake higher than what it actually was there's no way to reduce the number" (Me+, 5★, `13071525679`).

**Don't ask first.** "not asking you every time if you're sure you want to undo adding a tally" is on one reviewer's list of fixes (Do Habits, 2★, `10581441781`). A few do ask for a confirmation or a press-and-hold to prevent accidents (`4197330166`, `ef99f86f-e377-4fb1-91b2-5ed83d447c45`), while another finds holding annoying: "it would be much better if i can simply click on it than holding it" (Loop, 4★, `872434a7-ad11-4f75-8490-df93de5c44c7`). Undo after the tap serves both without slowing the tap.

**Tap again takes a tick back** (kept as it is): "Please revise the check-in button so that the first press will check-in, and pressing it again will undo the check-in" (Habit Tracker, 4★, `12474979339`); "the rare occasions it happened I just unlogged the habit" (Atoms, 5★, `11814577640`).

**A mistaken skip needs a way back too** (the player's Skip has Undo, and the habit page's day sheet has Undo Skip): "I accidentally 'skipped' a day. There was no option to undo this" (Productive, 1★, `4611291380`); "Multiple times I have accidentally 'skipped' a habit, and there's no way to easily add it back" (Productive, 3★, `10489403945`).

## The design, reasoned from first principles on top of that

- **Where is the person looking?** At the row they just tapped, near the bottom of the screen where the day bar and the timer bar already sit. The bar appears there, in the same pill as the player's "saved · Undo", so the app has one way of saying "done, and you can take it back".
- **Fewest steps for the frequent task:** logging stays one tap; the rare mistake costs one more.
- **No hidden state:** the bar names the habit and what was added, so it's clear what Undo will take back.
- **Accessibility:** VoiceOver announces "Water: +1 glass. Undo available." and the bar waits 20 seconds; with Reduce Motion it fades instead of sliding.

## Limits

Keyword counts are floors, and the themes overlap. Many hits are about Fabulous's deliberate "no uncheck" rule, so the 200 is weighted toward one app; the button, shake and exact-entry findings come from many apps. The 6-second time is reasoned, not tested with people.
